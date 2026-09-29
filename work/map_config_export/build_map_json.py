"""Build a localized map ID/name JSON from the game's generated Lua profiles."""

from collections import Counter
from pathlib import Path
import json
import re

ROOT = Path(__file__).resolve().parent
DECRYPTED = ROOT / "decrypted"
OUTPUT = ROOT.parents[1] / "outputs" / "map_id_name_config.json"

MODE_NAMES = {
    1: "时光之门（普通模式）", 2: "深渊模式", 3: "新手引导模式",
    4: "时光之门（英雄模式）", 5: "梦境挑战模式", 6: "世界Boss模式",
    7: "公会场景", 8: "沙之眼", 9: "扭曲空间", 10: "活动模式",
    11: "宠物对战", 12: "炼狱/后扭曲模式", 13: "幽灵深渊",
    14: "虚空秘境", 15: "试炼之地", 16: "维京时代", 17: "永冬裂缝",
    18: "泰坦之路", 19: "泰坦之路（英雄）", 20: "干涸之泉",
    21: "洞窟夺宝", 22: "经验副本", 23: "混沌虫洞", 24: "虫洞深处",
    25: "未知模式25", 26: "未知模式26",
}

language_text = (DECRYPTED / "ResourceCN" / "ProfileLanguage.lua").read_text(encoding="utf-8")
language = {
    int(key): value.replace(r'\"', '"').replace(r"\\", "\\")
    for key, value in re.findall(
        r'data\[(\d+)\]\s*=\s*\{[^\n]*?\blanguage\s*=\s*"((?:\\.|[^"\\])*)"',
        language_text,
    )
}

records = []
unresolved = set()
profile_pattern = re.compile(r"ProfileClientLevel_(\d+)_(\d+)\.lua$")
entry_pattern = re.compile(r"data\[(\d+)\]\s*=\s*\{.*\bID\s*=\s*(\d+).*\bmapName\s*=\s*(\d+)")

profile_dir = DECRYPTED / "Resource" / "profiles" / "dataProfile"
for path in sorted(profile_dir.glob("ProfileClientLevel_*_*.lua")):
    match = profile_pattern.match(path.name)
    if not match:
        continue
    mode, difficulty = map(int, match.groups())
    text = path.read_text(encoding="utf-8")
    for line in text.splitlines():
        entry = entry_pattern.match(line)
        if not entry:
            continue
        table_key, map_id, language_id = entry.groups()
        map_id = int(map_id)
        language_id = int(language_id)
        name = language.get(language_id) if language_id else None
        if name is None and language_id:
            unresolved.add(language_id)
        config_map = re.search(r"\bconfigMapID\s*=\s*(\d+)", line)
        appearance = re.search(r"\bmapAppearanceID\s*=\s*(\d+)", line)
        records.append({
            "mapId": map_id,
            "mapName": name,
            "mapNameLanguageId": language_id,
            "configMapId": int(config_map.group(1)) if config_map else None,
            "mapAppearanceId": int(appearance.group(1)) if appearance else None,
            "mode": mode,
            "modeName": MODE_NAMES.get(mode, f"未知模式{mode}"),
            "difficulty": difficulty,
            "source": path.name,
        })

records.sort(key=lambda item: (item["mode"], item["difficulty"], item["mapId"]))
source_counts = Counter(record["source"] for record in records)
document = {
    "schemaVersion": 1,
    "description": "游戏 ProfileClientLevel 配置中的地图ID与简体中文地图名称（已合并设备热更新覆盖）",
    "identityNote": "mapId 在不同 mode/difficulty 下可能重复，唯一定位应使用 mode + difficulty + mapId。",
    "recordCount": len(records),
    "sourceProfileCount": len(source_counts),
    "emptyNameRecordCount": sum(record["mapNameLanguageId"] == 0 for record in records),
    "unresolvedLanguageIds": sorted(unresolved),
    "maps": records,
}

OUTPUT.parent.mkdir(parents=True, exist_ok=True)
OUTPUT.write_text(json.dumps(document, ensure_ascii=False, indent=2) + "\n", encoding="utf-8")
print(f"wrote {len(records)} records from {len(source_counts)} profiles to {OUTPUT}")
if unresolved:
    raise SystemExit(f"unresolved language IDs: {sorted(unresolved)}")
