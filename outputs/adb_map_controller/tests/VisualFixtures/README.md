# Visual frame fixtures

## Provenance and scope

`active-play-negative-1080x1920.png` is a direct Android `screencap -p` capture from the logged-in emulator on 2026-10-08. It shows active gameplay with characters/enemies and a transient event banner; it is not labeled as a town or a target modal. Device: model `SM-S9420`, Android release 9 / API 28, `wm size` 1080×1920; the game is in landscape and the captured PNG is 1920×1080. Package: `com.avalon.caveonline.cn.huawei`. SHA-256: `69F396CB84615AB7771AEF7F12E6725F435B7B9B2C29E2BA2F3C7CFA52F47E20`.

The six user-supplied popup frames below are saved in the order stated by the user. Their files are 1004×565; the original game/device resolution and capture frame IDs were not provided and are intentionally not inferred. The image pixels are preserved unchanged. SHA-256 values are for the copied PNGs in this directory.

| Fixture | User annotation / expected visual class | Bytes | SHA-256 |
| --- | --- | ---: | --- |
| `next-floor-plain-confirm.png` | Plain “是否进入下一层” confirmation; `PlainConfirm` | 393145 | `B0BDD158574924166D5CDA5999A5E0DAF19258407FF6602D9006FF213D87814F` |
| `rift-gem-selection.png` | “原初试炼宝石” three-card selection | 303495 | `B17F441DFDC26A242ADADD83B28864E1FE8C2DC0AB0D93969010809CB7EB1C2B` |
| `greedy-continue-only.png` | Greedy selection, all cards continue to next floor; no return-card ribbons | 497632 | `0F1AA9422CD22EE3194C6EB4DB07CFDA28176C65564A548E66C785B50682AA4D` |
| `greedy-return-only.png` | Greedy selection, all cards return to town | 485582 | `BDB41157786F615BFA5E13C7F226060DBDDE9961DCAF642FECD59C3F3C6A0F66` |
| `next-floor-warning-confirm.png` | Next-floor confirmation with red progress-loss warning; `WarningConfirm` | 361901 | `C1B7A18AA63A6EDFAB0A227C0B3D50FD6BB175BC249F7BF25B4FDCDD396AADAF` |
| `greedy-mixed-continue-return.png` | Greedy selection with one return card in the middle; expected card index `[1]` (zero-based) | 462531 | `63F4A21C7339EBD485309F7A8B383C5611AE728831E4C97B84700878ACFA8069` |

The replay test checks bitmap/color classification and semantic text rules using the user's category/transcription as supplied text; it does **not** claim that PaddleOCR extracted those strings from the images. Text-only boundary cases (announcement text, missing title/action pairs, mixed continue/return wording, punctuation) lock the current permissive substring behavior; several announcement/missing-title phrases intentionally classify positive today and are recorded as potential false-positive risks, not desired semantics. They are not screenshots and do not measure image-detector false positives. The active-gameplay frame remains one image negative sample. Server-error automated positive coverage, screenshot near-misses, other resolutions/floors/animation states, OCR accuracy and native runtime publication remain uncovered.

## Idle server disconnect sample (2026-10-09)

`server-idle-disconnect.png` is the user's unchanged 1004×565 screenshot labeled idle-time server disconnect. Visible message: “闲置时间过长,已和服务器断开连接.”; the single button is orange/red with a yellow cross. SHA-256: `78559493F69080D89EF759A1483617A8911BAAC7B4D83EFA52A340B5EF700081`.

This fixture is retained for subsequent regression work, not yet asserted as a passing recognition case. Current `AdbClient.HasServerErrorDialog` requires a green-button candidate and its text rule recognizes “服务器连接异常” or “连接异常” together with “重新进入游戏”; this supplied variant does not match those rules. No production behavior was changed when recording the sample.

The unused Loot color detector and `LootConfirm` popup kind have been removed because no production flow or watchdog node used them; no Loot screenshot fixture is needed.
