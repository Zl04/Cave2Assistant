"""Extract map configuration bytecode from the installed Android game.

Base APK entries are read through adb without copying the ~1 GiB APK. Files in
the game's Hotfix directory are then overlaid, matching the game's load order.
"""

from pathlib import Path
import subprocess
import sys

ROOT = Path(__file__).resolve().parent
BASE = ROOT / "base"
MERGED = ROOT / "merged"
APK = "/data/app/com.avalon.caveonline.cn.huawei-y4QmJNAMXza9PGtPSRVSFw==/base.apk"
HOTFIX = "/data/user/0/com.avalon.caveonline.cn.huawei/files/CaveOnline/Hotfix/res"
PREFIX = "assets/res/"


def adb_bytes(*args: str) -> bytes:
    result = subprocess.run(["adb", "exec-out", *args], check=True, stdout=subprocess.PIPE)
    # Android 的旧版 unzip 能正确输出请求的成员，但到达中央目录后会向 stdout
    # 输出一个无关的 ZIP64 错误。
    return result.stdout.removesuffix(b"unzip: invalid zip magic 00000000\n")


def write(relative: str, data: bytes, root: Path) -> None:
    target = root / relative
    target.parent.mkdir(parents=True, exist_ok=True)
    target.write_bytes(data)


listing = subprocess.run(
    ["adb", "shell", f"unzip -l '{APK}' 2>/dev/null"], check=False, text=True,
    encoding="utf-8", errors="replace", stdout=subprocess.PIPE,
).stdout

entries = []
for line in listing.splitlines():
    path = line.split()[-1] if line.split() else ""
    if path.startswith(PREFIX + "Resource/profiles/dataProfile/ProfileClientLevel_") and path.endswith(".luac"):
        entries.append(path)
    elif path in {
        PREFIX + "Resource/profiles/commonProfile/ProfileMisty.luac",
        PREFIX + "ResourceCN/ProfileLanguage.luac",
    }:
        entries.append(path)

for entry in sorted(set(entries)):
    relative = entry[len(PREFIX):]
    data = adb_bytes("unzip", "-p", APK, entry)
    write(relative, data, BASE)
    write(relative, data, MERGED)

hotfix_listing = subprocess.run(
    ["adb", "shell", f"find '{HOTFIX}' -type f"], check=True, text=True,
    encoding="utf-8", errors="replace", stdout=subprocess.PIPE,
).stdout
for remote in hotfix_listing.splitlines():
    relative = remote.removeprefix(HOTFIX + "/")
    if (
        relative.startswith("Resource/profiles/dataProfile/ProfileClientLevel_")
        or relative in {"Resource/profiles/commonProfile/ProfileMisty.luac", "ResourceCN/ProfileLanguage.luac"}
    ):
        write(relative, adb_bytes("cat", remote), MERGED)

print(f"extracted {len(entries)} base files; applied hotfix overlays")
