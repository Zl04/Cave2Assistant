"""Compare the shipped OCR SDK and equal-tensor Paddle/ORT inference.

Generated models, environments and results belong in project publish/.ocr-benchmark.
Run --native with a Python process that has not imported Paddle Python, then --tensor
with the isolated environment. Separate processes avoid conflicting Paddle DLLs.
"""
import argparse
import ctypes
import json
import os
from pathlib import Path
import statistics
import sys
import time

PROJECT = Path(__file__).resolve().parents[1]
ROOT = PROJECT / "publish/PaddleOCR"
BENCH = PROJECT / "publish/.ocr-benchmark"
FIXTURES = [
    PROJECT.parent / "grid_confirmation_walkthrough/source.png",
    PROJECT / "tests/VisualFixtures/next-floor-warning-confirm.png",
    PROJECT / "tests/VisualFixtures/greedy-mixed-continue-return.png",
]


def measure(fn, count=5):
    times = []
    for _ in range(2):
        fn()
    for _ in range(count):
        start = time.perf_counter()
        result = fn()
        times.append((time.perf_counter() - start) * 1000)
    return result, {"median_ms": statistics.median(times), "samples_ms": times}


def native():
    os.environ["PATH"] = str(ROOT / "native") + ";" + os.environ["PATH"]
    cookie = os.add_dll_directory(str(ROOT / "native"))
    os.chdir(ROOT)
    dll = ctypes.CDLL(str(ROOT / "native/PaddleOCR.dll"))
    dll.Initjson.argtypes = [ctypes.c_char_p] * 4
    dll.Initjson.restype = ctypes.c_bool
    dll.DetectByte.argtypes = [ctypes.c_char_p, ctypes.c_size_t]
    dll.DetectByte.restype = ctypes.c_void_p
    dll.FreeResultBuffer.argtypes = [ctypes.c_void_p]
    dll.EnableLog(False)
    dll.EnableASCIIResult(True)
    dll.EnableJsonResult(True)
    params = dict(det=True, rec=True, cls=False, use_gpu=False,
                  cpu_mem=0, cpu_threads=8, enable_mkldnn=True, max_side_len=960,
                  det_db_thresh=.2, det_db_box_thresh=.35,
                  det_db_unclip_ratio=1.6, use_angle_cls=False,
                  rec_batch_num=6, rec_img_h=48, rec_img_w=320,
                  visualize=False, return_word_box=False, ocr_instance_count=1)
    paths = [ROOT / "paddle-models/PP-OCRv5_mobile_det_infer",
             ROOT / "paddle-models/PP-LCNet_x1_0_textline_ori",
             ROOT / "paddle-models/PP-OCRv4_mobile_rec_infer"]
    assert dll.Initjson(*[str(p).encode() for p in paths], json.dumps(params).encode())
    results = []
    try:
        for path in FIXTURES:
            data = path.read_bytes()
            def run():
                pointer = dll.DetectByte(data, len(data))
                if not pointer:
                    raise RuntimeError("SDK returned no result")
                try:
                    return json.loads(ctypes.string_at(pointer).decode())
                finally:
                    dll.FreeResultBuffer(pointer)
            words, timing = measure(run)
            results.append(dict(image=str(path), words=words, sdk=timing))
            print(path.name, timing, flush=True)
    finally:
        dll.FreeEngine()
    (BENCH / "native.json").write_text(json.dumps(results, ensure_ascii=False), encoding="utf8")


def tensor(threads, provider="CPUExecutionProvider"):
    sys.path.insert(0,str(Path(__file__).resolve().parent))
    import cv2
    import numpy as np
    import onnxruntime as ort
    import paddle.inference as pi
    import yaml
    import pyclipper

    from ocr_benchmark_pipeline import prepare_detection, detection_boxes, prepare_recognition

    models = PROJECT / "Resources/OcrModels"
    def predictor(name):
        path = models / name
        config = pi.Config(str(path / "inference.json"), str(path / "inference.pdiparams"))
        config.disable_gpu()
        config.set_cpu_math_library_num_threads(threads)
        config.enable_mkldnn()
        config.switch_ir_optim(True)
        config.disable_glog_info()
        p = pi.create_predictor(config)
        input_handle = p.get_input_handle(p.get_input_names()[0])
        output_handle = p.get_output_handle(p.get_output_names()[0])
        def run(x):
            input_handle.reshape(x.shape)
            input_handle.copy_from_cpu(x)
            p.run()
            return output_handle.copy_to_cpu()
        return run

    options = ort.SessionOptions()
    options.intra_op_num_threads = threads
    options.inter_op_num_threads = 1
    options.graph_optimization_level = ort.GraphOptimizationLevel.ORT_ENABLE_ALL
    def session(name):
        opts = ort.SessionOptions()
        opts.intra_op_num_threads = threads
        opts.inter_op_num_threads = 1
        opts.log_severity_level = 3
        opts.add_session_config_entry("session.intra_op.allow_spinning", "0")
        opts.graph_optimization_level = options.graph_optimization_level
        if provider == "DmlExecutionProvider":
            opts.enable_mem_pattern = False
            opts.execution_mode = ort.ExecutionMode.ORT_SEQUENTIAL
            opts.enable_profiling = True
            opts.profile_file_prefix = str(BENCH / f"{name}-dml-profile")
        opts.optimized_model_filepath = str(BENCH / f"{name}.optimized.onnx")
        if provider not in ort.get_available_providers():
            raise RuntimeError(f"Missing execution provider {provider}")
        s = ort.InferenceSession(str(BENCH / f"{name}.onnx"), opts, providers=[provider,"CPUExecutionProvider"] if provider != "CPUExecutionProvider" else [provider])
        if provider == "DmlExecutionProvider":
            from collections import Counter
            shape = (1,3,48,320) if name == "rec" else (1,3,544,960)
            s.run(None,{s.get_inputs()[0].name:np.zeros(shape,np.float32)})
            profile = Path(s.end_profiling())
            counts = Counter(event.get("args",{}).get("provider") for event in json.loads(profile.read_text()) if event.get("args",{}).get("provider"))
            print(name,"executed providers (separate untimed probe)",dict(counts),flush=True)
        sessions.append(s)
        return lambda x: s.run(None, {s.get_inputs()[0].name: x})[0]

    sessions = []
    pd_det, pd_rec = predictor("PP-OCRv5_mobile_det_infer"), predictor("PP-OCRv4_mobile_rec_infer")
    ort_det, ort_rec = session("det"), session("rec")
    dictionary = yaml.safe_load((models / "PP-OCRv4_mobile_rec_infer/inference.yml").read_text(encoding="utf8"))["PostProcess"]["character_dict"]
    dictionary = [""] + dictionary + [" "]
    def decode(output):
        indices = output.argmax(axis=2)
        texts = []
        for row in indices:
            previous, text = -1, ""
            for index in row:
                if index != 0 and index != previous:
                    text += dictionary[int(index)]
                previous = index
            texts.append(text)
        return texts

    results = json.loads((BENCH / "native.json").read_text(encoding="utf8"))
    for entry in results:
        entry["runtime"] = dict(onnxruntime=ort.__version__,provider=provider,threads=threads,paddle=__import__("paddle").__version__)
        image = cv2.imdecode(np.frombuffer(Path(entry["image"]).read_bytes(), np.uint8), cv2.IMREAD_COLOR)
        height, width = image.shape[:2]
        ratio = min(1., 960 / max(height, width))
        rh, rw = max(32, round(height * ratio / 32) * 32), max(32, round(width * ratio / 32) * 32)
        resized = cv2.resize(image, (rw, rh)).astype(np.float32) / 255
        det_input = np.ascontiguousarray(((resized - np.array([.485,.456,.406], np.float32)) / np.array([.229,.224,.225], np.float32)).transpose(2,0,1)[None])
        crops = []
        for word in entry["words"]:
            points = np.array([[p["x"],p["y"]] for p in word["Location"]], np.float32)
            # Convert the SDK's quadrilateral to a bounding rectangle for this
            # equal-tensor test. Both backends share it; it is not an exact
            # reproduction of the SDK's internal perspective crop.
            x1,y1 = points.min(axis=0).astype(int)
            x2,y2 = points.max(axis=0).astype(int)
            crop = image[max(0,y1):min(height,y2),max(0,x1):min(width,x2)]
            if crop.size == 0:
                raise ValueError("Invalid SDK rectangle")
            if crop.shape[0] / crop.shape[1] >= 1.5:
                crop = np.rot90(crop)
            crops.append(crop)
        order = sorted(range(len(crops)), key=lambda i: crops[i].shape[1]/crops[i].shape[0])
        batches = []
        for start in range(0,len(order),6):
            selected = [crops[i] for i in order[start:start+6]]
            target_width = max(320, int(48 * max(c.shape[1]/c.shape[0] for c in selected)))
            batch = np.zeros((len(selected),3,48,target_width), np.float32)
            for i,crop in enumerate(selected):
                resized_width = min(target_width, int(np.ceil(48*crop.shape[1]/crop.shape[0])))
                normalized = cv2.resize(crop,(resized_width,48)).astype(np.float32)/127.5-1
                batch[i,:,:,:resized_width] = normalized.transpose(2,0,1)
            batches.append(batch)
        entry["backends"] = {}
        for name,run_det,run_rec in [("paddle",pd_det,pd_rec),("onnxruntime",ort_det,ort_rec)]:
            det_output,det_time = measure(lambda:run_det(det_input))
            outputs,rec_time = measure(lambda:[run_rec(batch) for batch in batches])
            texts = [t for output in outputs for t in decode(output)]
            entry["backends"][name] = dict(det=det_time,rec=rec_time,texts=texts)
            if name == "paddle":
                reference_det,reference_outputs = det_output,outputs
            else:
                entry["max_absolute_difference"] = dict(det=float(np.max(np.abs(det_output-reference_det))),rec=max(float(np.max(np.abs(a-b))) for a,b in zip(outputs,reference_outputs)))
                entry["same_text_count"] = sum(a==b for a,b in zip(texts,entry["backends"]["paddle"]["texts"]))
        entry["batches"] = [list(x.shape) for x in batches]
        entry["full_pipeline"] = {}
        for name,run_det,run_rec in [("paddle",pd_det,pd_rec),("onnxruntime",ort_det,ort_rec)]:
            def full_run():
                marks = [time.perf_counter()]
                x = prepare_detection(image)
                marks.append(time.perf_counter())
                out = run_det(x)
                marks.append(time.perf_counter())
                boxes = detection_boxes(out,image)
                prepared,order = prepare_recognition(image,boxes)
                marks.append(time.perf_counter())
                outputs = [run_rec(batch) for batch in prepared]
                marks.append(time.perf_counter())
                decoded = [t for output in outputs for t in decode(output)]
                texts = [""]*len(order)
                for index,text in zip(order,decoded):
                    texts[index] = text
                marks.append(time.perf_counter())
                return dict(texts=texts,boxes=[p.tolist() for p in boxes],stages_ms=[(b-a)*1000 for a,b in zip(marks,marks[1:])])
            result,timing = measure(full_run)
            entry["full_pipeline"][name] = dict(**result,timing=timing)
        entry["full_pipeline_same_texts"] = entry["full_pipeline"]["paddle"]["texts"] == entry["full_pipeline"]["onnxruntime"]["texts"]
        entry["full_pipeline_same_boxes"] = entry["full_pipeline"]["paddle"]["boxes"] == entry["full_pipeline"]["onnxruntime"]["boxes"]
        summary = {name: dict(det_ms=value["det"]["median_ms"],rec_ms=value["rec"]["median_ms"],full_ms=entry["full_pipeline"][name]["timing"]["median_ms"])
                   for name,value in entry["backends"].items()}
        print(Path(entry["image"]).name,json.dumps(dict(timings=summary,same_texts=entry["same_text_count"],full_same_texts=entry["full_pipeline_same_texts"],full_same_boxes=entry["full_pipeline_same_boxes"])),flush=True)
    suffix = "-dml" if provider == "DmlExecutionProvider" else ""
    (BENCH / f"tensor-{threads}{suffix}.json").write_text(json.dumps(results,ensure_ascii=False,indent=2),encoding="utf8")


if __name__ == "__main__":
    args = argparse.ArgumentParser()
    args.add_argument("--native", action="store_true")
    args.add_argument("--tensor", action="store_true")
    args.add_argument("--threads", type=int, default=8)
    args.add_argument("--provider", default="CPUExecutionProvider",choices=["CPUExecutionProvider","DmlExecutionProvider"])
    options = args.parse_args()
    if options.native:
        native()
    elif options.tensor:
        tensor(options.threads,options.provider)
    else:
        args.error("select --native or --tensor")
