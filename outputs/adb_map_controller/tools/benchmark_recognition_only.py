"""Compare shipped Paddle SDK detection+recognition with recognition only.

Each mode runs in a separate process. Crops are encoded in memory; hot timings
include SDK PNG decoding and result JSON parsing, but exclude crop/PNG encoding.
"""
import argparse
import ctypes
import io
import json
import os
from pathlib import Path
import statistics
import sys
import time

from PIL import Image

PROJECT = Path(__file__).resolve().parents[1]


def main():
    sys.stdout.reconfigure(encoding='utf-8')
    parser = argparse.ArgumentParser()
    parser.add_argument('--mode', choices=['full', 'rec'], required=True)
    parser.add_argument('--detection-model', default='PP-OCRv5_mobile_det_infer')
    parser.add_argument('--samples', type=int, default=20)
    parser.add_argument('--threads', type=int, default=8)
    parser.add_argument('--no-mkldnn', action='store_true')
    parser.add_argument('--max-median-ms', type=float, default=None)
    parser.add_argument('--tight', action='store_true', help='Use measured single-line greedy title box')
    parser.add_argument('--whole-frame', action='store_true')
    args = parser.parse_args()
    root = PROJECT / 'publish/PaddleOCR'
    os.environ['PATH'] = str(root / 'native') + ';' + os.environ['PATH']
    cookie = os.add_dll_directory(str(root / 'native'))
    os.chdir(root)
    dll = ctypes.CDLL(str(root / 'native/PaddleOCR.dll'))
    dll.Initjson.argtypes = [ctypes.c_char_p] * 4
    dll.Initjson.restype = ctypes.c_bool
    dll.DetectByte.argtypes = [ctypes.c_char_p, ctypes.c_size_t]
    dll.DetectByte.restype = ctypes.c_void_p
    dll.FreeResultBuffer.argtypes = [ctypes.c_void_p]
    dll.EnableLog(False)
    dll.EnableASCIIResult(False)
    dll.EnableJsonResult(True)
    parameters = dict(det=args.mode == 'full', rec=True, cls=False,
                      use_gpu=False, cpu_threads=args.threads, cpu_mem=0,
                      enable_mkldnn=not args.no_mkldnn, max_side_len=960,
                      det_db_thresh=.2, det_db_box_thresh=.35,
                      det_db_unclip_ratio=1.6, use_angle_cls=False,
                      rec_batch_num=6, rec_img_h=48, rec_img_w=320,
                      visualize=False, return_word_box=False, ocr_instance_count=1)
    models = root / 'paddle-models'
    paths = [models / args.detection_model,
             models / 'PP-LCNet_x1_0_textline_ori',
             models / 'PP-OCRv4_mobile_rec_infer']
    assert dll.Initjson(*[str(p).encode() for p in paths],
                        json.dumps(parameters).encode()), 'SDK initialization failed'
    try:
        for name in ['greedy-mixed-continue-return.png', 'next-floor-warning-confirm.png']:
            if args.tight and name != 'greedy-mixed-continue-return.png':
                continue
            with Image.open(PROJECT / 'tests/VisualFixtures' / name) as image:
                w, h = image.size
                # Current production title region, deliberately not hand-tightened.
                crop = image.crop((int(w*.35), int(h*.03), int(w*.65), int(h*.18)))
                if args.whole_frame:
                    crop = image.copy()
                if args.tight:
                    # Measured full-mode box in the 301x85 fixture region.
                    # Experimental fixture crop, not a production layout rule.
                    crop = crop.crop((98, 21, 201, 51))
                stream = io.BytesIO()
                crop.convert('RGB').save(stream, format='PNG')
                data = stream.getvalue()

            def run():
                pointer = dll.DetectByte(data, len(data))
                if not pointer:
                    raise RuntimeError('SDK returned no result')
                try:
                    return json.loads(ctypes.string_at(pointer).decode())
                finally:
                    dll.FreeResultBuffer(pointer)

            for _ in range(2):
                run()
            elapsed = []
            cpu_elapsed = []
            for _ in range(args.samples):
                start = time.perf_counter()
                cpu_start = time.process_time()
                result = run()
                elapsed.append((time.perf_counter()-start)*1000)
                cpu_elapsed.append((time.process_time()-cpu_start)*1000)
            print(json.dumps(dict(mode=args.mode, threads=args.threads, mkldnn=not args.no_mkldnn, tight=args.tight, image=name, crop=crop.size,
                                  median_ms=statistics.median(elapsed),
                                  cpu_median_ms=statistics.median(cpu_elapsed),
                                  samples_ms=elapsed,
                                  p95_ms=sorted(elapsed)[int((len(elapsed)-1)*.95)],
                                  result=result), ensure_ascii=False), flush=True)
            if args.max_median_ms is not None and statistics.median(elapsed) > args.max_median_ms:
                raise SystemExit('FAIL: hot median exceeds requested latency')
    finally:
        dll.FreeEngine()
        cookie.close()


if __name__ == '__main__':
    main()
