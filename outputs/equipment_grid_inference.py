"""Infer a screenshot's inventory lattice from separators, without checkbox detection."""
from pathlib import Path
import argparse
import json
import cv2
import numpy as np
from PIL import Image, ImageDraw, ImageFont


def bands(profile, offset, threshold=45):
    active = profile < threshold
    edges = np.diff(np.r_[False, active, False].astype(int))
    return [(int(a+offset), int(b-1+offset))
            for a,b in zip(np.flatnonzero(edges==1), np.flatnonzero(edges==-1)) if b-a>=2]


def infer(band_list, width):
    points=np.array([(a+b)/2 for a,b in band_list])
    best=None
    for i,origin in enumerate(points):
        for end in points[i+1:]:
            for steps in range(1,9):
                pitch=(end-origin)/steps
                if not width*.03<=pitch<=width*.12: continue
                indices=np.rint((points-origin)/pitch)
                errors=np.abs(points-(origin+indices*pitch))
                valid=errors<=width*.002
                occupied=sorted(set(int(v) for v in indices[valid]))
                run=longest=0; previous=None
                for index in occupied:
                    run=run+1 if previous is not None and index==previous+1 else 1
                    longest=max(longest,run); previous=index
                if longest<4: continue
                score=(len(occupied),longest,-float(np.sum(errors[valid])))
                if best is None or score>best[0]:best=(score,indices,valid)
    if best is None:raise ValueError('没有至少四条连续、等间距的分隔带，拒绝推算网格')
    _,indices,valid=best
    pitch,origin=np.polyfit(indices[valid],points[valid],1)
    lo=int(indices[valid].min()); hi=int(indices[valid].max())
    boundaries=[float(origin+index*pitch) for index in range(lo,hi+1)]
    residuals=np.abs(points[valid]-(origin+indices[valid]*pitch))
    return {'pitch':float(pitch),'boundaries':boundaries,
            'inlier_bands':[list(band_list[i]) for i in np.flatnonzero(valid)],
            'rejected_bands':[list(band_list[i]) for i in np.flatnonzero(~valid)],
            'max_residual':float(residuals.max())}


def detect(image):
    height,width=image.shape[:2]
    hsv=cv2.cvtColor(image,cv2.COLOR_RGB2HSV)
    # Manually calibrated broad search area for the supplied layout.
    # It does not specify any individual cell, checkbox, or actual grid pitch.
    x0,x1=round(width*.5578),round(width*.8884)
    y0,y1=round(height*.2566),round(height*.726)
    # Empty cells are also neutral, but darker than panel separators. Estimate
    # panel brightness from a calibrated strip outside the grid, not from items.
    strip=hsv[y0:y1,max(0,x0-round(width*.008)):x0]
    panel_value=float(np.median(strip[:,:,2]))
    neutral=(hsv[:,:,1]<45)&(np.abs(hsv[:,:,2].astype(float)-panel_value)<panel_value*.20)
    vertical=1-neutral[y0:y1,x0:x1].mean(axis=0)
    vb=bands(vertical,x0,.30)
    vx=infer(vb,width)
    left,right=round(vx['boundaries'][0]+4),round(vx['boundaries'][-1]-4)
    bottom=round(height*.8319)
    horizontal=1-neutral[y0:bottom,left:right].mean(axis=1)
    hb=bands(horizontal,y0,.30)
    hy=infer(hb,width)
    if len(vx['boundaries'])!=6:raise ValueError('列边界数量不符合已确认的五列布局')
    if abs(vx['pitch']/hy['pitch']-1)>.06:raise ValueError('横纵间距不一致，拒绝定位')
    return {'x':vx,'y':hy,'columns':5,'confirmed_rows':len(hy['boundaries'])-1,
            'vertical_profile':vertical.tolist(),'horizontal_profile':horizontal.tolist(),
            'search_region':[x0,y0,x1,bottom],'panel_value':panel_value}


def main():
    parser=argparse.ArgumentParser()
    parser.add_argument('image')
    parser.add_argument('--output',default=str(Path(__file__).with_name('equipment_grid_inference')))
    args=parser.parse_args()
    image=np.array(Image.open(args.image).convert('RGB'))
    out=Path(args.output);out.mkdir(parents=True,exist_ok=True)
    detection=detect(image)
    width=image.shape[1];height=image.shape[0]
    xb=detection['x']['boundaries'];yb=detection['y']['boundaries']
    view=(round(width*.5428),round(height*.2496),round(width*.8994),round(height*.8372))
    font=ImageFont.truetype('C:/Windows/Fonts/msyh.ttc',19)
    small=ImageFont.truetype('C:/Windows/Fonts/msyh.ttc',14)

    def save(name,arr,title,subtitle):
        base=Image.fromarray(arr).crop(view);base=base.resize((base.width*2,base.height*2))
        canvas=Image.new('RGB',(base.width,base.height+80),'#18212c');canvas.paste(base,(0,80))
        d=ImageDraw.Draw(canvas);d.text((12,8),title,font=font,fill='white');d.text((12,43),subtitle,font=small,fill='#d2dae4')
        canvas.save(out/name)

    separators=image.copy()
    for axis,color in [('x',(0,230,255)),('y',(255,216,80))]:
        for a,b in detection[axis]['inlier_bands']:
            if axis=='x':cv2.rectangle(separators,(a,145),(b,470),color,1)
            else:cv2.rectangle(separators,(560,a),(891,b),color,1)
    save('01_separator_bands.png',separators,'1. 从面板背景色空隙找到分隔带',
         '青：列间分隔；黄：行间分隔。没有检测选择框或完整装备矩形')
    grid=image.copy()
    for x in xb:cv2.line(grid,(round(x),round(yb[0])),(round(x),round(yb[-1])),(0,230,255),1)
    for y in yb:cv2.line(grid,(round(xb[0]),round(y)),(round(xb[-1]),round(y)),(255,216,80),1)
    centers=[]
    for row,(ya,yz) in enumerate(zip(yb,yb[1:]),1):
        for col,(xa,xz) in enumerate(zip(xb,xb[1:]),1):
            cx,cy=round((xa+xz)/2),round((ya+yz)/2)
            centers.append({'row':row,'column':col,'center':[cx,cy]})
            cv2.putText(grid,f'{row}-{col}',(cx-13,cy+5),cv2.FONT_HERSHEY_SIMPLEX,.4,(255,255,255),1,cv2.LINE_AA)
    save('02_inferred_grid.png',grid,'2. 用等间距分隔线推算网格',
         f'列距 {detection["x"]["pitch"]:.2f}px；行距 {detection["y"]["pitch"]:.2f}px；确认五列、四行')
    # Synthetic ablation: hide all top-right corner controls in the visible lattice.
    # This is a diagnostic image, not a real second screenshot.
    hidden=image.copy()
    for row in range(5):
        cy=(yb[0]+yb[1])/2+row*detection['y']['pitch']
        for col in range(5):
            cx=(xb[col]+xb[col+1])/2
            # Use a colored block so neutral corner controls cannot contribute gaps.
            a,b=round(cx+8),round(cy-34);c,d=round(cx+36),round(cy-7)
            hidden[max(0,b):d,max(0,a):c]=(92,55,112)
    try:
        hidden_result=detect(hidden)
        xshift=max(abs(a-b) for a,b in zip(xb,hidden_result['x']['boundaries']))
        yshift=max(abs(a-b) for a,b in zip(yb,hidden_result['y']['boundaries']))
        ablation={'accepted':True,'x_shift':xshift,'y_shift':yshift}
        ablation_text=f'网格定位成功；横向变化 {xshift:.2f}px，纵向变化 {yshift:.2f}px'
        for x in hidden_result['x']['boundaries']:
            cv2.line(hidden,(round(x),round(yb[0])),(round(x),round(yb[-1])),(0,230,255),1)
        for y in hidden_result['y']['boundaries']:
            cv2.line(hidden,(round(xb[0]),round(y)),(round(xb[-1]),round(y)),(255,216,80),1)
    except ValueError as error:
        ablation={'accepted':False,'reason':str(error)}
        ablation_text='遮挡也覆盖了部分分隔带，证据不足，拒绝推算网格'
    save('03_no_corner_controls.png',hidden,'3. 遮住右上角控件后重新检测（模拟）',
         ablation_text)
    cases={}
    for scale,brightness in [(1,.7),(1,1.2),(.75,1),(1.5,1)]:
        modified=np.clip(image.astype(float)*brightness,0,255).astype('uint8')
        if scale!=1:modified=cv2.resize(modified,None,fx=scale,fy=scale,interpolation=cv2.INTER_AREA if scale<1 else cv2.INTER_CUBIC)
        try:
            result=detect(modified)
            cases[f'scale={scale},brightness={brightness}']={'accepted':True,'columns':result['columns'],
                'confirmed_rows':result['confirmed_rows'],'normalized_pitch':[result['x']['pitch']/scale,result['y']['pitch']/scale]}
        except ValueError as error:cases[f'scale={scale},brightness={brightness}']={'accepted':False,'reason':str(error)}
    for key in ['vertical_profile','horizontal_profile']:detection.pop(key)
    detection['centers']=centers;detection['synthetic_corner_removal']=ablation
    detection['synthetic_cases']=cases
    (out/'result.json').write_text(json.dumps(detection,ensure_ascii=False,indent=2),encoding='utf8')
    report=f'''# 不依赖选择框的网格推算验证

仅处理用户截图；没有执行设备操作，也没有接入项目出售功能。

## 实际方法

搜索区域仍是本图人工标定的面板内部范围，不声称已实现自动定位面板。
从网格左侧的面板背景窄条估计亮度，结合低饱和度（本图 S<45），筛选接近面板背景亮度（±20%）的像素。
横向对多行、纵向对多列统计这些像素的覆盖率。覆盖率至少70%的连续区段作为灰色间隙候选，避免把更暗的空格内部也当成间隙。
从候选间隙中寻找至少四条连续、等间距的分隔带，排除不符合周期的装备图案、选择框及底部渐隐区干扰。
拟合间隙中心线；两个相邻中心线的中点就是格子中心。没有检测完整矩形，也没有使用选择框定位。

列间距：{detection['x']['pitch']:.3f} 像素；行间距：{detection['y']['pitch']:.3f} 像素。
横向最大拟合残差：{detection['x']['max_residual']:.3f} 像素；纵向最大拟合残差：{detection['y']['max_residual']:.3f} 像素。
确认五列、四行；底部渐隐的第五排不当作可靠行。

## 无选择框验证

用彩色块覆盖可见网格每格的右上角控件，再运行相同检测。这是人为遮挡实验，不是另一张真实游戏截图。
{ablation_text}。具体结果见 result.json；遮挡块也可能覆盖分隔带，因此拒绝定位不等同于依赖选择框。

## 实际限制

- S<45、搜索区域及间距范围仅在当前样本上验证，不能承诺兼容所有界面或主题。
- 模拟亮度和缩放实验只说明本样本的敏感性；没有真实滚动截图，不能声称滚动后定位已验证。
- 搜索范围边缘不能截断主要分隔带；面板锚点定位和窗口尺寸适配仍需单独完成。
- 无空隙、候选不足、周期不一致或横纵间距矛盾时拒绝定位，不外推点击。
- 本例网格线是间隙中心线，不是装备边框的精确外轮廓。

完整数据与模拟实验结果见 result.json。
'''
    (out/'findings.md').write_text(report,encoding='utf8')
    print(json.dumps(detection,ensure_ascii=False))


if __name__=='__main__':main()
