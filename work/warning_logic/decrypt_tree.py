from pathlib import Path
import sys

sys.path.insert(0, str(Path(__file__).resolve().parents[2] / "outputs" / "runtime_hook"))
from cocos_xxtea import decrypt

SIGN = b"svednolava"
KEY = b"8102enilnOevac"

source_root = Path(sys.argv[1])
target_root = Path(sys.argv[2])
for source in source_root.rglob("*.luac"):
    blob = source.read_bytes()
    if not blob.startswith(SIGN):
        continue
    target = (target_root / source.relative_to(source_root)).with_suffix(".lua")
    target.parent.mkdir(parents=True, exist_ok=True)
    target.write_bytes(decrypt(blob[len(SIGN):], KEY))
