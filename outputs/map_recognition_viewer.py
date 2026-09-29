"""PROTOTYPE: Windows GUI for inspecting minimap recognition frame by frame."""

from __future__ import annotations

import csv
import importlib.util
import json
import sys
import tkinter as tk
from pathlib import Path
from tkinter import filedialog, messagebox, ttk

import numpy as np
from PIL import Image, ImageDraw, ImageFilter, ImageOps, ImageTk


HERE = Path(__file__).resolve().parent
ENGINE_PATH = HERE / "build_map_from_four_screenshots.py"
DEFAULT_IMAGES = [
    Path(r"C:\Users\WARRIO~1.ZEN\AppData\Local\Temp\codex-clipboard-309aa9d3-6f0d-4039-a4fb-49ec8c25bded.png"),
    Path(r"C:\Users\WARRIO~1.ZEN\AppData\Local\Temp\codex-clipboard-4734ae92-3d7b-40e0-925e-a4bf9d311c80.png"),
]


def load_engine():
    spec = importlib.util.spec_from_file_location("map_engine", ENGINE_PATH)
    if spec is None or spec.loader is None:
        raise RuntimeError(f"无法载入识别引擎：{ENGINE_PATH}")
    module = importlib.util.module_from_spec(spec)
    spec.loader.exec_module(module)
    return module


ENGINE = load_engine()
from map_model_v5 import MapModel


def fit_image(image: Image.Image, box: tuple[int, int], background=(22, 26, 34, 255)) -> Image.Image:
    result = Image.new("RGBA", box, background)
    copy = image.convert("RGBA")
    copy.thumbnail(box, Image.Resampling.LANCZOS)
    result.alpha_composite(copy, ((box[0] - copy.width) // 2, (box[1] - copy.height) // 2))
    return result


def make_structure_map(canvas: Image.Image, players, frame_index: int) -> Image.Image:
    """Turn road outlines into a high-contrast, rectified structure diagram."""
    crop = canvas.crop(ENGINE.MAP_CROP)
    mask = ENGINE.road_mask(crop)
    # 加粗轮廓，使其在仿射校正后仍保持可见。
    line = Image.fromarray((mask.astype(np.uint8) * 255), "L").filter(ImageFilter.MaxFilter(3))
    line_rgba = Image.new("RGBA", line.size, (0, 0, 0, 0))
    line_rgba.paste((104, 195, 255, 255), mask=line)
    corrected = ENGINE.rectify(line_rgba)

    draw = ImageDraw.Draw(corrected)
    crop_size = (ENGINE.MAP_CROP[2] - ENGINE.MAP_CROP[0], ENGINE.MAP_CROP[3] - ENGINE.MAP_CROP[1])
    points = []
    for point in players[: frame_index + 1]:
        relative = (point[0] - ENGINE.MAP_CROP[0], point[1] - ENGINE.MAP_CROP[1])
        points.append(ENGINE.rectify_point(relative, crop_size))
    for a, b in zip(points, points[1:]):
        draw.line((*a, *b), fill=(255, 255, 255, 220), width=3)
    palette = [(255, 84, 84), (255, 211, 72), (81, 226, 132), (255, 91, 214)]
    for i, (x, y) in enumerate(points):
        color = palette[i % len(palette)]
        draw.ellipse((x - 6, y - 6, x + 6, y + 6), fill=color, outline="white", width=2)
        draw.text((x + 9, y - 12), f"P{i+1}", fill=color, stroke_width=2, stroke_fill="black")
    return corrected


class ImagePanel(ttk.Frame):
    def __init__(self, parent, title: str):
        super().__init__(parent, style="Card.TFrame")
        ttk.Label(self, text=title, style="CardTitle.TLabel").pack(anchor="w", padx=12, pady=(10, 6))
        self.label = ttk.Label(self, anchor="center", style="Image.TLabel")
        self.label.pack(fill="both", expand=True, padx=10, pady=(0, 10))
        self.photo = None

    def show(self, image: Image.Image, size=(570, 430)):
        rendered = fit_image(image, size)
        self.photo = ImageTk.PhotoImage(rendered)
        self.label.configure(image=self.photo)


class MapWorkbench(tk.Tk):
    def __init__(self):
        super().__init__()
        self.title("小地图识别与构建工作台 — 原型")
        self.geometry("1540x920")
        self.minsize(1180, 720)
        self.configure(bg="#11151d")
        self.paths = []
        self.images = []
        self.players_local = []
        self.players_map = []
        self.offsets = []
        self.registration_score = 0.0
        self.model = None
        self.frame = 0
        self.overlay_player = tk.BooleanVar(value=True)
        self.overlay_road = tk.BooleanVar(value=True)
        self._configure_styles()
        self._build_ui()
        existing = [p for p in DEFAULT_IMAGES if p.exists()]
        if existing:
            self.load_paths(existing)

    def _configure_styles(self):
        style = ttk.Style(self)
        style.theme_use("clam")
        style.configure("TFrame", background="#11151d")
        style.configure("Card.TFrame", background="#1b2230", relief="flat")
        style.configure("TLabel", background="#11151d", foreground="#dce7f5")
        style.configure("Title.TLabel", font=("Microsoft YaHei UI", 18, "bold"), foreground="#f5f8fc")
        style.configure("Sub.TLabel", foreground="#8fa3bd")
        style.configure("CardTitle.TLabel", background="#1b2230", foreground="#eaf2ff", font=("Microsoft YaHei UI", 11, "bold"))
        style.configure("Image.TLabel", background="#151a24")
        style.configure("Data.TLabel", background="#1b2230", foreground="#cfdded", font=("Consolas", 11))
        style.configure("Accent.TButton", font=("Microsoft YaHei UI", 10, "bold"))
        style.configure("TCheckbutton", background="#11151d", foreground="#cbd8e8")

    def _build_ui(self):
        toolbar = ttk.Frame(self)
        toolbar.pack(fill="x", padx=18, pady=(14, 10))
        ttk.Label(toolbar, text="小地图识别与构建工作台", style="Title.TLabel").pack(side="left")
        ttk.Label(toolbar, text="  PROTOTYPE", style="Sub.TLabel").pack(side="left")
        ttk.Button(toolbar, text="打开截图…", command=self.open_images, style="Accent.TButton").pack(side="right", padx=4)
        ttk.Button(toolbar, text="导出当前结果", command=self.export_current).pack(side="right", padx=4)
        ttk.Button(toolbar, text="重新识别", command=self.process).pack(side="right", padx=4)

        options = ttk.Frame(self)
        options.pack(fill="x", padx=18, pady=(0, 10))
        ttk.Checkbutton(options, text="显示人物落点", variable=self.overlay_player, command=self.render).pack(side="left")
        ttk.Checkbutton(options, text="显示道路蒙版", variable=self.overlay_road, command=self.render).pack(side="left", padx=16)
        self.status = ttk.Label(options, text="等待载入截图", style="Sub.TLabel")
        self.status.pack(side="right")

        body = ttk.Frame(self)
        body.pack(fill="both", expand=True, padx=18)
        body.columnconfigure(0, weight=5)
        body.columnconfigure(1, weight=5)
        body.columnconfigure(2, weight=2)
        body.rowconfigure(0, weight=1)
        self.original_panel = ImagePanel(body, "当前截图 · 识别覆盖层")
        self.original_panel.grid(row=0, column=0, sticky="nsew", padx=(0, 8))
        self.map_panel = ImagePanel(body, "偏移取色道路图 · 逐帧累计 · 方向已校正")
        self.map_panel.grid(row=0, column=1, sticky="nsew", padx=8)

        data_card = ttk.Frame(body, style="Card.TFrame")
        data_card.grid(row=0, column=2, sticky="nsew", padx=(8, 0))
        ttk.Label(data_card, text="当前帧关键数据", style="CardTitle.TLabel").pack(anchor="w", padx=14, pady=(12, 12))
        self.data_labels = {}
        for key, title in [
            ("frame", "帧"), ("size", "截图尺寸"), ("local", "截图内坐标"),
            ("offset", "配准偏移"), ("map", "统一地图坐标"),
            ("rect", "校正后坐标"), ("score", "配准相似度"),
            ("road", "道路像素"), ("new", "新增道路像素"),
            ("unknown", "未知格子"), ("nodes", "图节点 / 边"),
            ("frontier", "候选探索前沿"),
        ]:
            ttk.Label(data_card, text=title, style="CardTitle.TLabel").pack(anchor="w", padx=14, pady=(7, 1))
            label = ttk.Label(data_card, text="—", style="Data.TLabel")
            label.pack(anchor="w", padx=14)
            self.data_labels[key] = label
        ttk.Separator(data_card).pack(fill="x", padx=14, pady=14)
        ttk.Label(data_card, text="坐标定义", style="CardTitle.TLabel").pack(anchor="w", padx=14)
        ttk.Label(data_card, text="人物蓝色箭头下半部\n尖端作为道路落点。", style="Data.TLabel").pack(anchor="w", padx=14, pady=5)

        timeline_card = ttk.Frame(self, style="Card.TFrame")
        timeline_card.pack(fill="x", padx=18, pady=14)
        header = ttk.Frame(timeline_card, style="Card.TFrame")
        header.pack(fill="x", padx=12, pady=(8, 3))
        ttk.Label(header, text="逐帧构建时间线", style="CardTitle.TLabel").pack(side="left")
        ttk.Button(header, text="◀ 上一帧", command=lambda: self.select_frame(self.frame - 1)).pack(side="right", padx=3)
        ttk.Button(header, text="下一帧 ▶", command=lambda: self.select_frame(self.frame + 1)).pack(side="right", padx=3)
        self.timeline = ttk.Frame(timeline_card, style="Card.TFrame")
        self.timeline.pack(fill="x", padx=10, pady=(3, 10))

    def open_images(self):
        names = filedialog.askopenfilenames(title="选择按时间排序的地图截图", filetypes=[("PNG/JPEG", "*.png *.jpg *.jpeg")])
        if names:
            self.load_paths([Path(p) for p in names])

    def load_paths(self, paths):
        self.paths = list(paths)
        try:
            self.images = [Image.open(p).convert("RGBA") for p in self.paths]
            self.process()
        except Exception as exc:
            messagebox.showerror("载入失败", str(exc))

    def process(self):
        if not self.images:
            return
        try:
            self.players_local = [ENGINE.find_player(im) for im in self.images]
            if len(self.images) > 1:
                score, dx, dy = ENGINE.register_first_to_reference(self.images[0], self.images[-1])
            else:
                score, dx, dy = 1.0, 0, 0
            self.registration_score = score
            self.offsets = [(dx, dy)] + [(0, 0)] * (len(self.images) - 1)
            self.players_map = [(p[0] + o[0], p[1] + o[1]) for p, o in zip(self.players_local, self.offsets)]
            self.model = MapModel.from_images(self.images, ENGINE_PATH)
            self.frame = min(self.frame, len(self.images) - 1)
            self._rebuild_timeline()
            self.render()
            self.status.configure(text=f"识别完成 · {len(self.images)} 帧")
        except Exception as exc:
            messagebox.showerror("识别失败", str(exc))

    def current_canvas(self):
        image = self.images[self.frame]
        offset = self.offsets[self.frame]
        size = self.images[-1].size
        canvas = Image.new("RGBA", size, (24, 28, 37, 255))
        canvas.alpha_composite(image, dest=offset)
        return canvas

    def render(self):
        if not self.images or not self.players_map:
            return
        canvas = self.current_canvas()
        annotated = canvas.copy()
        draw = ImageDraw.Draw(annotated)
        if self.overlay_road.get():
            road = ENGINE.road_mask(canvas)
            overlay = Image.new("RGBA", canvas.size, (0, 0, 0, 0))
            overlay.paste((59, 184, 255, 150), mask=Image.fromarray((road * 255).astype(np.uint8), "L"))
            annotated = Image.alpha_composite(annotated, overlay)
            draw = ImageDraw.Draw(annotated)
        if self.overlay_player.get():
            for i, point in enumerate(self.players_map[: self.frame + 1]):
                x, y = point
                color = (255, 74, 74, 255) if i == self.frame else (255, 220, 90, 220)
                draw.line((x - 12, y, x + 12, y), fill=color, width=3)
                draw.line((x, y - 12, x, y + 12), fill=color, width=3)
                draw.ellipse((x - 6, y - 6, x + 6, y + 6), outline="white", width=2)
                draw.text((x + 10, y - 19), f"P{i+1}", fill=color, stroke_width=2, stroke_fill="black")
        structure = self.model.render(self.frame, scale=6)
        self.original_panel.show(annotated)
        self.map_panel.show(structure)
        self._update_data(canvas)

    def _update_data(self, canvas):
        i = self.frame
        local, offset, point = self.players_local[i], self.offsets[i], self.players_map[i]
        crop_size = (ENGINE.MAP_CROP[2] - ENGINE.MAP_CROP[0], ENGINE.MAP_CROP[3] - ENGINE.MAP_CROP[1])
        rect = ENGINE.rectify_point((point[0] - ENGINE.MAP_CROP[0], point[1] - ENGINE.MAP_CROP[1]), crop_size)
        snapshot = self.model.snapshot(i)
        road_count = snapshot.total_road_pixels
        new_count = snapshot.new_road_pixels
        values = {
            "frame": f"{i + 1} / {len(self.images)}",
            "size": f"{self.images[i].width} × {self.images[i].height}",
            "local": f"({local[0]:.2f}, {local[1]:.2f})",
            "offset": f"({offset[0]:+d}, {offset[1]:+d})",
            "map": f"({point[0]:.2f}, {point[1]:.2f})",
            "rect": f"({rect[0]:.2f}, {rect[1]:.2f})",
            "score": f"{self.registration_score * 100:.2f}%" if i == 0 else "同画布",
            "road": f"{road_count:,}",
            "new": f"{new_count:,}",
            "unknown": f"{int((snapshot.occupancy == 0).sum()):,}",
            "nodes": f"{len(snapshot.nodes)} / {len(snapshot.edges)}",
            "frontier": f"{len(snapshot.frontiers)}",
        }
        for key, value in values.items():
            self.data_labels[key].configure(text=value)

    def _rebuild_timeline(self):
        for widget in self.timeline.winfo_children():
            widget.destroy()
        for i, path in enumerate(self.paths):
            ttk.Button(self.timeline, text=f"P{i+1}\n{path.name[:18]}", command=lambda n=i: self.select_frame(n)).pack(side="left", fill="x", expand=True, padx=4)

    def select_frame(self, index):
        if not self.images:
            return
        self.frame = max(0, min(index, len(self.images) - 1))
        self.render()

    def export_current(self):
        if not self.images:
            return
        folder = filedialog.askdirectory(title="选择导出目录")
        if not folder:
            return
        destination = Path(folder)
        canvas = self.current_canvas()
        structure = self.model.render(self.frame, scale=6)
        structure.save(destination / f"frame_{self.frame + 1}_structure.png")
        rows = []
        for i, (local, offset, point) in enumerate(zip(self.players_local, self.offsets, self.players_map), 1):
            rows.append({"frame": i, "local_x": local[0], "local_y": local[1], "offset_x": offset[0], "offset_y": offset[1], "map_x": point[0], "map_y": point[1]})
        (destination / "recognition_data.json").write_text(json.dumps(rows, ensure_ascii=False, indent=2), encoding="utf-8")
        with (destination / "recognition_data.csv").open("w", newline="", encoding="utf-8-sig") as stream:
            writer = csv.DictWriter(stream, fieldnames=rows[0].keys())
            writer.writeheader()
            writer.writerows(rows)
        messagebox.showinfo("导出完成", f"结果已保存到：\n{destination}")


if __name__ == "__main__":
    app = MapWorkbench()
    app.mainloop()
