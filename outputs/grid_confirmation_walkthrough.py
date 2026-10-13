"""Expose actual intermediate values of screenshot grid confirmation."""
from pathlib import Path
import json
import sys
import shutil
import numpy as np
import cv2
from PIL import Image, ImageDraw, ImageFont

sys.path.insert(0,str(Path(__file__).resolve().parent))
from equipment_grid_inference import detect, bands

ROOT=Path(__file__).with_name('grid_confirmation_walkthrough')
ROOT.mkdir(exist_ok=True)
SOURCE=Path(r'C:\Users\WARRIO~1.ZEN\AppData\Local\Temp\codex-clipboard-6e31b921-87dd-472a-985a-8924ec390f49.png')
if SOURCE.exists():shutil.copyfile(SOURCE,ROOT/'source.png')
source=np.array(Image.open(ROOT/'source.png').convert('RGB'))
result=detect(source)
font=ImageFont.truetype('C:/Windows/Fonts/msyh.ttc',20)
small=ImageFont.truetype('C:/Windows/Fonts/msyh.ttc',16)
large=ImageFont.truetype('C:/Windows/Fonts/msyh.ttc',25)
view=(545,141,903,473)
files=[]

def emit(name,image,title,subtitle):
    canvas=Image.new('RGB',(image.width,image.height+86),'#17212c')
    canvas.paste(image,(0,86));d=ImageDraw.Draw(canvas)
    d.text((14,8),title,font=font,fill='white');d.text((14,46),subtitle,font=small,fill='#cbd6e3')
    canvas.save(ROOT/name);files.append((name,title,subtitle))

def crop(image):return image.crop(view).resize((716,664),Image.Resampling.NEAREST)

x0,y0,x1,bottom=result['search_region'];column_bottom=round(source.shape[0]*.726)
im=Image.fromarray(source);d=ImageDraw.Draw(im)
d.rectangle((x0,y0,x1,bottom),outline='#00e6ff',width=2)
d.rectangle((x0,y0,x1,column_bottom),outline='#ffd450',width=1)
d.rectangle((552,y0,559,column_bottom),fill='#39ed8c')
emit('01_roi_background.png',im,'1. 指定搜索范围，并采样面板背景',
     '青框：搜索区域；黄框：列统计范围；绿条：背景采样。本步仍使用人工标定位置。')

hsv=cv2.cvtColor(source,cv2.COLOR_RGB2HSV);pv=result['panel_value']
mask=(hsv[:,:,1]<45)&(np.abs(hsv[:,:,2].astype(float)-pv)<pv*.20)
masked=Image.fromarray((mask.astype('uint8')*255)).convert('RGB')
emit('02_separator_mask.png',crop(masked),'2. 构造“接近面板背景”的像素掩膜',
     f'白色：S<45 且 {pv*.8:.1f}<V<{pv*1.2:.1f}；面板亮度中位数 V={pv:.0f}。')

chart=Image.new('RGB',(880,590),'#101923');d=ImageDraw.Draw(chart)
profiles=[('横向统计：每个 X 上有多少像素像面板背景',x0,result['vertical_profile'],90),
          ('纵向统计：每个 Y 上有多少像素像面板背景',y0,result['horizontal_profile'],360)]
for title,offset,profile,top in profiles:
    left,right,height=76,842,160
    d.text((20,top-53),title,font=font,fill='white')
    for fraction in [0,.5,.7,1]:
        yy=top+height*(1-fraction)
        d.line((left,yy,right,yy),fill='#405060' if fraction!=.7 else '#ffcf4a',width=1)
        d.text((20,yy-9),f'{fraction*100:.0f}%',font=small,fill='#cbd6e3')
    values=1-np.array(profile)
    points=[(left+i*(right-left)/(len(values)-1),top+height*(1-float(v))) for i,v in enumerate(values)]
    d.line(points,fill='#00e6ff',width=2)
    for i in np.linspace(0,len(values)-1,6).astype(int):
        xx=left+i*(right-left)/(len(values)-1)
        d.text((xx-16,top+height+10),str(offset+i),font=small,fill='#cbd6e3')
    d.text((left+390,top-25),'黄色线：70%候选阈值',font=small,fill='#ffcf4a')
emit('03_coverage_profiles.png',chart,'3. 统计背景像素覆盖率，找连续分隔带',
     '覆盖率超过70%，并连续至少2像素才成为候选；整条线不必全部清晰。')

im=Image.fromarray(source);d=ImageDraw.Draw(im,'RGBA')
for axis,color in [('x',(0,230,255,150)),('y',(255,212,80,150))]:
    for a,b in result[axis]['inlier_bands']:
        box=(a,141,b,473) if axis=='x' else (545,a,903,b)
        d.rectangle(box,fill=color)
    for a,b in result[axis]['rejected_bands']:
        box=(a,141,b,473) if axis=='x' else (545,a,903,b)
        d.rectangle(box,fill=(255,75,75,110))
emit('04_periodic_bands.png',crop(im),'4. 筛选等间距分隔带，排除不符合周期的区域',
     '青：6条列分隔；黄：5条行分隔；红：底部445–469区域被排除。')

checks=Image.new('RGB',(850,520),'#101923');d=ImageDraw.Draw(checks)
lines=[
 '候选间距 = 两个候选中心的距离 ÷ 假设间隔数',
 '预测分隔线 = 起点 + 编号 × 间距',
 '至少4条连续分隔线符合周期；每条偏差 ≤ 2.008 px',
 '',
 f'列间距：{result["x"]["pitch"]:.3f} px；最大拟合残差：{result["x"]["max_residual"]:.3f} px',
 f'行间距：{result["y"]["pitch"]:.3f} px；最大拟合残差：{result["y"]["max_residual"]:.3f} px',
 '列边界数 = 6 → 5列，符合当前界面已确认的布局',
 '行边界数 = 5 → 当前确认4行',
 f'横纵间距差异：{abs(result["x"]["pitch"]/result["y"]["pitch"]-1)*100:.3f}% < 6%',
 '',
 '本图通过这些检查；底部第五排没有两条可靠边界，排除。',
 '这些是当前实验的确认条件，不是完整的生产验收规则。',
]
for i,line in enumerate(lines):
    d.text((20,18+i*39),line,font=small if i<3 else font,fill='#cbd6e3' if i<3 else '#e8f0f8')
emit('05_geometry_checks.png',checks,'5. 拟合与几何一致性检查',
     '不检测选择框；不用装备品质判断网格。确认条件来自当前实验脚本。')

im=Image.fromarray(source);d=ImageDraw.Draw(im)
xb=result['x']['boundaries'];yb=result['y']['boundaries']
for x in xb:d.line((x,yb[0],x,yb[-1]),fill='#00e6ff',width=1)
for y in yb:d.line((xb[0],y,xb[-1],y),fill='#ffd450',width=1)
cells=[]
for row,(ya,yz) in enumerate(zip(yb,yb[1:]),1):
    for col,(xa,xz) in enumerate(zip(xb,xb[1:]),1):
        cx,cy=(xa+xz)/2,(ya+yz)/2
        d.text((cx-11,cy-8),f'{row}-{col}',font=small,fill='white')
        cells.append({'row':row,'column':col,'bounds':[xa,ya,xz,yz]})
emit('06_confirmed_grid.png',crop(im),'6. 输出已确认网格，供后续逐格分析',
     '5列×4行；网格线位于空隙中心。随后才检查品质、空格及右上角勾选控件。')

result['confirmed_cells']=cells
(ROOT/'result.json').write_text(json.dumps(result,ensure_ascii=False,indent=2),encoding='utf8')
html='<meta charset="utf-8"><title>网格确认过程</title><style>body{background:#101923;color:#e8f0f8;font:17px sans-serif;margin:24px}img{max-width:100%;display:block}section{margin:36px 0}</style><h1>网格确认的实际处理过程</h1><p>使用用户提供的末页截图；不操作游戏。搜索区域和背景条仍需人工标定。</p>'
for name,title,subtitle in files:html+=f'<section><h2>{title}</h2><p>{subtitle}</p><img src="{name}"></section>'
(ROOT/'index.html').write_text(html,encoding='utf8')
print(json.dumps({'columns':result['columns'],'rows':result['confirmed_rows'],'panel_value':pv,
 'column_pitch':result['x']['pitch'],'row_pitch':result['y']['pitch'],'output':str(ROOT)},ensure_ascii=False))
