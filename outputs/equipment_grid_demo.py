"""Screenshot-only grid analysis demo. Produces reviewable images, never device input."""
from pathlib import Path
import argparse
import json
import cv2
import numpy as np
from PIL import Image, ImageDraw, ImageFont


def clusters(values, tolerance=12):
    groups = []
    for value in sorted(values):
        if groups and abs(value - np.median(groups[-1])) < tolerance:
            groups[-1].append(value)
        else:
            groups.append([value])
    return [float(np.median(group)) for group in groups]


def main():
    parser = argparse.ArgumentParser()
    parser.add_argument('image')
    parser.add_argument('--output', default=str(Path(__file__).with_name('equipment_grid_demo')))
    args = parser.parse_args()
    out = Path(args.output)
    out.mkdir(parents=True, exist_ok=True)
    source = np.array(Image.open(args.image).convert('RGB'))
    h, w = source.shape[:2]
    # This is a declared, manually chosen search window for THIS supplied frame.
    # Grid locations inside it are detected from pixels, not entered by hand.
    x0, y0, x1, y1 = [round(v) for v in (w*.5428, h*.2496, w*.8994, h*.8372)]
    roi = source[y0:y1, x0:x1]
    font = ImageFont.truetype('C:/Windows/Fonts/msyh.ttc', 19)
    small = ImageFont.truetype('C:/Windows/Fonts/msyh.ttc', 14)
    records = []

    def save(name, array, title, description):
        base = Image.fromarray(array).convert('RGB')
        scale = 2 if base.width < 500 else 1
        base = base.resize((base.width*scale, base.height*scale))
        canvas = Image.new('RGB', (base.width, base.height+74), '#18212c')
        canvas.paste(base, (0, 74))
        draw = ImageDraw.Draw(canvas)
        draw.text((12, 8), title, font=font, fill='white')
        draw.text((12, 39), description, font=small, fill='#d2dae4')
        canvas.save(out/name)
        records.append((name, title, description))

    annotated = source.copy()
    cv2.rectangle(annotated, (x0,y0), (x1,y1), (0,230,255), 2)
    save('01_search_region.png', annotated, '1. 确定搜索区域（本例人工划定）',
         f'原图 {w}×{h}；ROI=({x0},{y0})–({x1},{y1})；尚未实现面板自动定位')
    hsv = cv2.cvtColor(roi, cv2.COLOR_RGB2HSV)
    mask = cv2.inRange(hsv, np.array([0,65,55]), np.array([179,255,240]))
    save('02_color_mask.png', cv2.cvtColor(mask,cv2.COLOR_GRAY2RGB), '2. 彩色像素候选掩膜',
         '保留饱和色：S≥65、55≤V≤240；装备图案也会进入候选')
    gray = cv2.cvtColor(roi,cv2.COLOR_RGB2GRAY)
    edges = cv2.Canny(gray,40,100)
    cs,_ = cv2.findContours(mask,cv2.RETR_LIST,cv2.CHAIN_APPROX_SIMPLE)
    boxes=[]
    expected=w*.06
    for c in cs:
        x,y,bw,bh=cv2.boundingRect(c)
        if expected*.68 < bw < expected*1.42 and expected*.68 < bh < expected*1.42 and .75 < bw/bh < 1.3:
            boxes.append((x,y,bw,bh))
    edge_image=cv2.cvtColor(edges,cv2.COLOR_GRAY2RGB)
    for x,y,bw,bh in boxes:
        cv2.rectangle(edge_image,(x,y),(x+bw,y+bh),(0,230,255),1)
    save('03_edges_candidates.png',edge_image,'3. 边缘与矩形候选',
         f'Canny 边缘（白）；尺寸/长宽比筛选后 {len(boxes)} 个候选（青）')
    xs=clusters([x+bw/2 for x,y,bw,bh in boxes])
    ys=clusters([y+bh/2 for x,y,bw,bh in boxes])
    if len(xs)!=5 or len(ys)<3:
        raise RuntimeError(f'Grid fit rejected: columns={xs}, rows={ys}')
    dx=float(np.median(np.diff(xs))); dy=float(np.median(np.diff(ys)))
    bw=float(np.median([b[2] for b in boxes])); bh=float(np.median([b[3] for b in boxes]))
    startx=float(np.median([x-i*dx for i,x in enumerate(xs)]))
    starty=float(np.median([y-i*dy for i,y in enumerate(ys)]))
    grid=roi.copy(); items=[]
    # Fifth row is visible through the bottom fade: geometry only; excluded later.
    rows=int((roi.shape[0]-starty+bh/2)//dy)+1
    for r in range(rows):
        cy=round(starty+r*dy)
        if cy+bh/2>roi.shape[0]: break
        for col in range(5):
            cx=round(startx+col*dx)
            left=round(cx-bw/2); top=round(cy-bh/2)
            rect=(left,top,round(bw),round(bh))
            cv2.rectangle(grid,(left,top),(left+round(bw),top+round(bh)),(0,230,255),1)
            cv2.putText(grid,f'{r+1}-{col+1}',(left+5,top+20),cv2.FONT_HERSHEY_SIMPLEX,.38,(255,255,255),1,cv2.LINE_AA)
            items.append({'row':r+1,'column':col+1,'rect':rect,'center':(cx,cy)})
    save('04_grid_fit.png',grid,'4. 拟合规则网格',
         f'检测出 5 列；列距 {dx:.1f}px、行距 {dy:.1f}px；底部一排为外推')
    colors={'紫色':(201,106,255),'暗金':(255,146,61),'金色':(255,220,68),'其他/未知':(220,90,90),'遮挡/灰暗':(170,180,195)}
    classified=Image.fromarray(roi.copy()); d=ImageDraw.Draw(classified)
    result=roi.copy()
    for item in items:
        left,top,bwi,bhi=item['rect']; cx,cy=item['center']
        # Border strips avoid the icon center and the top-right checkbox/red dot.
        strips=[hsv[top+12:top+bhi-12,left+2:left+5].reshape(-1,3),
                hsv[top+bhi-5:top+bhi-2,left+8:left+bwi-11].reshape(-1,3)]
        samples=np.concatenate(strips); saturated=samples[samples[:,1]>65]
        med=np.median(saturated,axis=0) if len(saturated) else np.zeros(3)
        hue,sat,value=map(float,med)
        dim=item['row']==5 or sat<95
        quality='遮挡/灰暗' if dim else ('紫色' if 130<=hue<=160 else '暗金' if 5<=hue<17 else '金色' if 17<=hue<=35 else '其他/未知')
        item['quality']=quality; item['border_hsv']=[round(float(v),1) for v in med]
        item['image_center']=[cx+x0,cy+y0]
        item['candidate_only']=quality in ('紫色','暗金','金色')
        item['click_point']=None
        color=colors[quality]
        d.rectangle((left,top,left+bwi-1,top+bhi-1),outline=color,width=2)
        d.rectangle((left+1,top+bhi-17,left+bwi-1,top+bhi-1),fill=(24,33,44))
        d.text((left+3,top+bhi-17),quality if quality!='遮挡/灰暗' else '跳过',font=small,fill=color)
        if item['candidate_only']:
            # Locate the light gray checkbox inside the cell's top-right corner.
            # Do not use the equipment icon center or the red notification dot.
            sx=left+round(bwi*.55); sy=max(0,top-round(bhi*.08))
            corner=hsv[sy:top+round(bhi*.36),sx:min(hsv.shape[1],left+bwi+round(bwi*.08))]
            checkbox_mask=cv2.inRange(corner,np.array([0,0,145]),np.array([179,40,225]))
            components,_=cv2.findContours(checkbox_mask,cv2.RETR_EXTERNAL,cv2.CHAIN_APPROX_SIMPLE)
            checkbox_boxes=[]
            for component in components:
                bx,by,bxw,bxh=cv2.boundingRect(component)
                if bwi*.20<=bxw<=bwi*.50 and bhi*.20<=bxh<=bhi*.50 and .75<=bxw/bxh<=1.35:
                    if cv2.contourArea(component)/(bxw*bxh)>.65:
                        checkbox_boxes.append((bx,by,bxw,bxh))
            if checkbox_boxes:
                bx,by,bxw,bxh=max(checkbox_boxes,key=lambda b:b[2]*b[3])
                px=sx+bx+bxw//2; py=sy+by+bxh//2
                item['click_point']=[px+x0,py+y0]
                item['checkbox_rect']=[sx+bx+x0,sy+by+y0,bxw,bxh]
                cv2.rectangle(result,(sx+bx,sy+by),(sx+bx+bxw-1,sy+by+bxh-1),color,1)
                cv2.circle(result,(px,py),4,color,1)
                cv2.line(result,(px-6,py),(px+6,py),color,1)
                cv2.line(result,(px,py-6),(px,py+6),color,1)
            else:
                item['candidate_only']=False
        else:
            cv2.line(result,(cx-7,cy-7),(cx+7,cy+7),(170,180,195),2)
            cv2.line(result,(cx-7,cy+7),(cx+7,cy-7),(170,180,195),2)
    save('05_quality_classification.png',np.array(classified),'5. 边框/底色品质分类（候选）',
         '采用用户确认的紫、橙棕、金黄色；灰暗、渐隐和未知格子跳过')
    save('06_candidate_centers.png',result,'6. 定位右上角选择框中心（未执行点击）',
         '按灰色方框像素定位；框内十字为点击点，未检测到方框则不生成点击点')
    counts={key:sum(i['quality']==key for i in items) for key in colors}
    (out/'result.json').write_text(json.dumps({'image_size':[w,h],'roi':[x0,y0,x1,y1],
        'pitch':[dx,dy],'counts':counts,'items':items,'limitations':[
        'ROI manually specified for supplied screenshot','HSV thresholds provisional, not production calibration',
        'Dim cells skipped conservatively; reason not inferred','No lock/socket/selection confirmation; no device actions']},ensure_ascii=False,indent=2),encoding='utf8')
    images=[Image.open(out/name) for name,_,_ in records]
    tw,th=760,650
    sheet=Image.new('RGB',(tw*3,th*2),'#101820')
    for i,im in enumerate(images):
        im.thumbnail((tw-16,th-16));sheet.paste(im,((i%3)*tw+(tw-im.width)//2,(i//3)*th+(th-im.height)//2))
    sheet.save(out/'all_steps.png')
    html='<meta charset="utf-8"><title>背包网格识别逐步演示</title><style>body{background:#101820;color:#eaf0f5;font:16px sans-serif;margin:28px}img{max-width:100%;display:block}section{margin-bottom:32px}</style><h1>背包网格识别逐步演示</h1><p>只处理用户截图，不点击游戏。搜索区域人工划定，网格自动拟合。品质结果是候选，不代表可出售。</p>'
    for name,title,description in records:html+=f'<section><h2>{title}</h2><p>{description}</p><img src="{name}"></section>'
    (out/'index.html').write_text(html,encoding='utf8')
    print(json.dumps({'roi':[x0,y0,x1,y1],'candidate_boxes':len(boxes),'columns':xs,'rows':ys,'pitch':[dx,dy],'counts':counts,'output':str(out.resolve())},ensure_ascii=False))


if __name__=='__main__':
    main()
