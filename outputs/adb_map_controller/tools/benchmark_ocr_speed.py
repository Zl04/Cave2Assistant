"""Full-screen OCR speed/accuracy experiments; all generated files stay in publish.

Run using an isolated Python environment with onnxruntime-directml, OpenCV,
onnx, onnxconverter-common, PyYAML and pyclipper. Export models with Paddle2ONNX
as det.onnx, rec.onnx, tiny-rec.onnx and tiny-det.onnx under publish/.ocr-speed.
"""
import argparse
import gc
import json
from pathlib import Path
import statistics
import time

import cv2
import numpy as np
import onnx
import onnxruntime as ort
import yaml
from ocr_benchmark_pipeline import prepare_detection, detection_boxes, prepare_recognition

PROJECT = Path(__file__).resolve().parents[1]
BENCH = PROJECT / "publish/.ocr-speed"
FIXTURES = [PROJECT.parent / "grid_confirmation_walkthrough/source.png",
            PROJECT / "tests/VisualFixtures/next-floor-warning-confirm.png",
            PROJECT / "tests/VisualFixtures/greedy-mixed-continue-return.png"]
KEYWORDS = [[],["是否进入下一层"],
            ["贪婪抉择","返回城镇","继续探险","前往下一层","安全回城","再考虑一下"]]


class Model:
    def __init__(self, path, static=False, fp16=False, compact=False, cpu=False, raw=False):
        self.model = onnx.load(path)
        self.static, self.cpu = static, cpu
        self.raw = raw
        self.sessions = {}
        self.provider_counts = {}
        if fp16:
            from onnxconverter_common import float16
            self.model = float16.convert_float_to_float16(self.model,keep_io_types=True)
        if compact:
            output = self.model.graph.output[0]
            probabilities = output.name
            score_type = output.type.tensor_type.elem_type
            del self.model.graph.output[:]
            self.model.graph.node.append(onnx.helper.make_node("ArgMax",[probabilities],["ctc_indices"],axis=2,keepdims=0))
            self.model.graph.node.append(onnx.helper.make_node("ReduceMax",[probabilities],["ctc_scores"],axes=[2],keepdims=0))
            self.model.graph.output.extend([
                onnx.helper.make_tensor_value_info("ctc_indices",onnx.TensorProto.INT64,[None,None]),
                onnx.helper.make_tensor_value_info("ctc_scores",score_type,[None,None])])
        self.compact = compact

    def run(self, x):
        key = x.shape if self.static else ()
        if key not in self.sessions:
            model = onnx.ModelProto()
            model.CopyFrom(self.model)
            if self.static:
                for dimension,value in zip(model.graph.input[0].type.tensor_type.shape.dim,x.shape):
                    dimension.ClearField("dim_param")
                    dimension.dim_value = value
                # Remove symbolic internal annotations to allow shape propagation
                # from the now-static input during ORT optimization.
                del model.graph.value_info[:]
            options = ort.SessionOptions()
            options.intra_op_num_threads = 8
            options.inter_op_num_threads = 1
            options.enable_mem_pattern = False
            options.execution_mode = ort.ExecutionMode.ORT_SEQUENTIAL
            options.graph_optimization_level = ort.GraphOptimizationLevel.ORT_ENABLE_ALL
            options.log_severity_level = 3
            options.enable_profiling = True
            options.profile_file_prefix = str(BENCH/"provider-probe")
            options.add_session_config_entry("session.intra_op.allow_spinning","0")
            providers = ["CPUExecutionProvider"] if self.cpu else ["DmlExecutionProvider","CPUExecutionProvider"]
            session = ort.InferenceSession(model.SerializeToString(),options,providers=providers)
            # Audit an untimed warmup; disable profiling before measured runs.
            session.run(None,{session.get_inputs()[0].name:x})
            profile = Path(session.end_profiling())
            from collections import Counter
            counts = Counter(event.get("args",{}).get("provider") for event in json.loads(profile.read_text()) if event.get("args",{}).get("provider"))
            if not self.cpu and not counts.get("DmlExecutionProvider"):
                raise RuntimeError("DirectML provider registered but GPU execution was not observed")
            self.provider_counts[str(key)] = dict(counts)
            profile.unlink()
            self.sessions[key] = session
        session = self.sessions[key]
        result = session.run(None,{session.get_inputs()[0].name:x})
        if self.compact or self.raw:
            return result
        return [result[0].argmax(axis=2),result[0].max(axis=2)]


def dictionary(tiny):
    path = BENCH / "models/PP-OCRv6_tiny_rec_infer/inference.yml" if tiny else PROJECT / "Resources/OcrModels/PP-OCRv4_mobile_rec_infer/inference.yml"
    return [""]+yaml.safe_load(path.read_text(encoding="utf8"))["PostProcess"]["character_dict"]+[" "]


def decode(indices,scores,keys):
    results = []
    for row,probabilities in zip(indices,scores):
        texts, confidences, previous = [], [], -1
        for index,score in zip(row,probabilities):
            if index != 0 and index != previous:
                texts.append(keys[int(index)])
                confidences.append(float(score))
            previous = index
        results.append(dict(text="".join(texts),confidence=statistics.mean(confidences) if confidences else 0.))
    return results


def pipeline(image,det,rec,keys,variant):
    marks = [time.perf_counter()]
    x = prepare_detection(image,fast=variant.get("fast_preprocess",False))
    marks.append(time.perf_counter())
    # Detection requires the probability map, not the recognition summary.
    probability = det.run(x)[0]
    marks.append(time.perf_counter())
    boxes = detection_boxes(probability,image)
    prepared,order = prepare_recognition(image,boxes,batch_size=variant.get("batch",6),
        min_width=variant.get("width",320),width_multiple=variant.get("multiple",1),fixed_batch=variant.get("static",False),adaptive_batch=variant.get("adaptive_batch",False))
    marks.append(time.perf_counter())
    outputs = [rec.run(batch) for batch in prepared]
    marks.append(time.perf_counter())
    values = []
    for batch_index,(indices,scores) in enumerate(outputs):
        real_rows = min(variant.get("batch",6),len(order)-batch_index*variant.get("batch",6))
        values.extend(decode(indices[:real_rows],scores[:real_rows],keys))
    texts = [None]*len(boxes)
    # Fixed batches contain dummy rows at the end of the final batch.
    for index,value in zip(order,values):
        texts[index] = value
    marks.append(time.perf_counter())
    return dict(words=texts,boxes=[p.tolist() for p in boxes],
                stages_ms=[(b-a)*1000 for a,b in zip(marks,marks[1:])],
                batches=[list(batch.shape) for batch in prepared])


VARIANTS = [
    dict(name="v4-dynamic-b6"),
    dict(name="v4-dynamic-b16",batch=16),
    dict(name="v4-dynamic-b32",batch=32),
    dict(name="v4-static-b8",batch=8,static=True),
    dict(name="v4-static-b16",batch=16,static=True),
    dict(name="v4-static-adaptive",batch=8,static=True,width=32,multiple=64),
    dict(name="v4-fp16-static-adaptive",batch=8,static=True,width=32,multiple=64,fp16=True),
    dict(name="v4-static-compact",batch=8,static=True,compact=True),
    dict(name="tiny-dynamic-b6",tiny=True),
    dict(name="tiny-static-b16",tiny=True,batch=16,static=True),
    dict(name="tiny-static-adaptive",tiny=True,batch=8,static=True,width=32,multiple=64),
    dict(name="tiny-fp16-static-adaptive",tiny=True,batch=8,static=True,width=32,multiple=64,fp16=True),
    dict(name="tiny-det-and-rec",tiny=True,tiny_det=True,batch=8,static=True,width=32,multiple=64),
    dict(name="tiny-fp16-dynamic-det",tiny=True,batch=8,static=True,width=32,multiple=64,fp16=True),
    dict(name="tiny-all-fp16",tiny=True,batch=8,static=True,width=32,multiple=64,fp16=True,det_fp16=True),
    dict(name="tiny-all-fp16-compact",tiny=True,batch=8,static=True,width=32,multiple=64,fp16=True,det_fp16=True,compact=True),
    dict(name="tiny-det-rec-fp16",tiny=True,tiny_det=True,batch=8,static=True,width=32,multiple=64,fp16=True,det_fp16=True),
    dict(name="tiny-fast-preprocess",tiny=True,batch=8,static=True,width=32,multiple=64,fast_preprocess=True),
    dict(name="tiny-det-rec-fast",tiny=True,tiny_det=True,batch=8,static=True,width=32,multiple=64,fast_preprocess=True),
    dict(name="tiny-det-rec-fast-fp16",tiny=True,tiny_det=True,batch=8,static=True,width=32,multiple=64,fp16=True,det_fp16=True,fast_preprocess=True),
    dict(name="tiny-det-rec-fast-compact",tiny=True,tiny_det=True,batch=8,static=True,width=32,multiple=64,compact=True,fast_preprocess=True),
    dict(name="tiny-det-rec-fast-fp16-compact",tiny=True,tiny_det=True,batch=8,static=True,width=32,multiple=64,fp16=True,det_fp16=True,compact=True,fast_preprocess=True),
    dict(name="tiny-adaptive-batch",tiny=True,tiny_det=True,batch=8,static=True,width=32,multiple=64,compact=True,fast_preprocess=True,adaptive_batch=True),
    dict(name="tiny-v5-det-compact",tiny=True,batch=8,static=True,width=32,multiple=64,compact=True,fast_preprocess=True,adaptive_batch=True),
    dict(name="tiny-single-cv-thread",tiny=True,tiny_det=True,batch=8,static=True,width=32,multiple=64,compact=True,fast_preprocess=True,adaptive_batch=True,cv_threads=1),
]


def main(args):
    if "DmlExecutionProvider" not in ort.get_available_providers():
        raise RuntimeError("DirectML unavailable")
    images = [cv2.imdecode(np.frombuffer(path.read_bytes(),np.uint8),cv2.IMREAD_COLOR) for path in FIXTURES]
    variants = [v for v in VARIANTS if not args.variants or v["name"] in args.variants.split(",")]
    baseline = {}
    baseline_path = BENCH/"baseline.json"
    if baseline_path.exists():
        baseline = json.loads(baseline_path.read_text(encoding="utf8"))
    results = []
    for variant in variants:
        cv2.setNumThreads(variant.get("cv_threads",8))
        print("start",variant["name"],flush=True)
        try:
            rec = Model(BENCH/("tiny-rec.onnx" if variant.get("tiny") else "rec.onnx"),static=variant.get("static",False),fp16=variant.get("fp16",False),compact=variant.get("compact",False))
            det = Model(BENCH/("tiny-det.onnx" if variant.get("tiny_det") else "det.onnx"),static=variant.get("det_static",False),fp16=variant.get("det_fp16",False),raw=True)
            keys = dictionary(variant.get("tiny",False))
            for number,(path,image) in enumerate(zip(FIXTURES,images)):
                cold_start = time.perf_counter()
                for _ in range(2):
                    value = pipeline(image,det,rec,keys,variant)
                warmup_ms = (time.perf_counter()-cold_start)*1000
                times,stage_samples = [],[]
                for _ in range(args.samples):
                    start = time.perf_counter()
                    value = pipeline(image,det,rec,keys,variant)
                    times.append((time.perf_counter()-start)*1000)
                    stage_samples.append(value["stages_ms"])
                texts = [w["text"] for w in value["words"]]
                if variant["name"] == "v4-dynamic-b6":
                    baseline[path.name] = dict(texts=texts,boxes=value["boxes"])
                    baseline_path.write_text(json.dumps(baseline,ensure_ascii=False),encoding="utf8")
                reference = baseline.get(path.name,{})
                same_boxes = reference.get("boxes") == value["boxes"]
                same_texts = sum(a==b for a,b in zip(texts,reference.get("texts",[]))) if same_boxes else None
                keywords = {k:any(k in text for text in texts) for k in KEYWORDS[number]}
                row = dict(variant=variant,image=path.name,median_ms=statistics.median(times),samples_ms=times,
                           p95_ms=float(np.percentile(times,95)),max_ms=max(times),
                           target_median_met=statistics.median(times)<=100,
                           key_texts_pass=all(keywords.values()),
                           stage_medians_ms=np.median(stage_samples,axis=0).tolist(),stage_samples_ms=stage_samples,warmup_ms=warmup_ms,
                           reference_same_boxes=same_boxes,reference_same_text_count=same_texts,
                           keywords=keywords,providers=dict(det=det.provider_counts,rec=rec.provider_counts),**value)
                results.append(row)
                print(path.name,json.dumps({k:row[k] for k in ["median_ms","stage_medians_ms","reference_same_text_count","reference_same_boxes","keywords"]},ensure_ascii=True),flush=True)
        except Exception as error:
            import traceback
            traceback.print_exc()
            results.append(dict(variant=variant,error=str(error)))
        finally:
            rec = det = None
            gc.collect()
        (BENCH/args.output).write_text(json.dumps(dict(runtime=ort.__version__,samples=args.samples,results=results),ensure_ascii=False,indent=2),encoding="utf8")


if __name__ == "__main__":
    parser = argparse.ArgumentParser()
    parser.add_argument("--variants",default="v4-dynamic-b6,tiny-single-cv-thread")
    parser.add_argument("--samples",type=int,default=5)
    parser.add_argument("--output",default="speed.json")
    main(parser.parse_args())
