"""Read-only replay of user-supplied sale screenshots; never sends input."""
from pathlib import Path
import sys
import json
import cv2
import numpy as np
from PIL import Image, ImageDraw, ImageFont

sys.path.insert(0,str(Path(__file__).resolve().parents[1]))
from equipment_grid_inference import detect

ROOT=Path(__file__).resolve().parent
TEMP=Path(r'C:\Users\WARRIO~1.ZEN\AppData\Local\Temp')
IDS=['1cbf1fd0-5bdc-49db-a729-d65621186d7e','f481983e-c857-4ff6-9533-cd1c59b34313',
 '78f258af-1f41-4ee0-9df7-80ce1792da7c','132d69e7-caed-4d81-b78f-f4654decd482',
 '49b5cc81-e0a8-4401-8d09-50176c78dd53','4f72ace2-3499-4d4f-8ed7-27561d06caec',
 '90032f56-28de-4eb7-9a5f-20b12744ce1f','277947c3-2c95-4a35-8a7e-bb8f40a04c9e',
 '62da35a9-a933-48a7-8c86-599d928f3d8c','0a006871-3483-49cd-81f8-1f28376c9821',
 'beb2fd1d-309c-4705-bcf1-19eff27f1490','ce1aec56-d96e-4a92-81b8-3b7c3f8e4d1c',
 '485d3ec2-109a-4afd-a2ea-e9c919540d15','618b6636-926f-455e-a160-b901ad6e7282',
 '6e31b921-87dd-472a-985a-8924ec390f49']
images={i+1:cv2.imread(str(TEMP/f'codex-clipboard-{name}.png')) for i,name in enumerate(IDS)}
templates=ROOT/'templates';templates.mkdir(exist_ok=True)
definitions={
 'bag':(images[2],(.86,.78,1,1)),
 'equipment_tab_idle':(images[4],(.59,.88,.68,1)),
 'equipment_tab_active':(images[5],(.59,.88,.68,1)),
 'sale_idle':(images[7],(.75,.09,.815,.195)),
 'sale_active':(images[11],(.75,.09,.815,.195)),
 'blue_white_sale':(images[8],(.81,.09,.88,.195)),
 'back':(images[14],(.81,0,.94,.11)),
 'role_title':(images[10][8:43,96:221],(0,0,.27,.12)),
 'sale_submit':(images[12][75:95,776:805],(.75,.09,.815,.195)),
 'green_confirm':(images[9][346:375,548:639],(.3,.55,.7,.70)),
 'empty_cell':(images[15][350:399,701:749],(.54,.24,.90,.83)),
}
for name,(template,_) in definitions.items():cv2.imwrite(str(templates/f'{name}.png'),template)
results={};grid_results={}
for number in [1,3,6,9,10,12,13,15]:
    image=images[number];height,width=image.shape[:2]
    matches={}
    for name,(template,roi) in definitions.items():
        x,y,x1,y1=[round(v) for v in (roi[0]*width,roi[1]*height,roi[2]*width,roi[3]*height)]
        response=cv2.matchTemplate(image[y:y1,x:x1],template,cv2.TM_SQDIFF_NORMED)
        difference,_,position,_=cv2.minMaxLoc(response)
        matches[name]={'difference':round(float(difference),5),'matched':difference<.08,
                       'center':[x+position[0]+template.shape[1]//2,y+position[1]+template.shape[0]//2]}
    results[str(number)]=matches
    if number in [3,6,10,12,13,15]:
        try:
            grid=detect(cv2.cvtColor(image,cv2.COLOR_BGR2RGB))
            grid_results[str(number)]={'accepted':True,'pitch':[grid['x']['pitch'],grid['y']['pitch']],
                                      'columns':grid['columns'],'rows':grid['confirmed_rows']}
        except ValueError as error:grid_results[str(number)]={'accepted':False,'reason':str(error)}

# Empty-cell evidence: use the grid geometry; reject faded bottom row.
last=cv2.cvtColor(images[15],cv2.COLOR_BGR2RGB);grid=detect(last)
visual=Image.fromarray(last);draw=ImageDraw.Draw(visual)
font=ImageFont.truetype('C:/Windows/Fonts/msyh.ttc',14)
empty=[]
for row,(ya,yb) in enumerate(zip(grid['y']['boundaries'],grid['y']['boundaries'][1:]),1):
    for col,(xa,xb) in enumerate(zip(grid['x']['boundaries'],grid['x']['boundaries'][1:]),1):
        x,y=round(xa+14),round(ya+14);x1,y1=round(xb-14),round(yb-14)
        patch=last[y:y1,x:x1]
        # Demonstration evidence only, not a production empty-cell classifier.
        spread=float(np.max(np.std(patch,axis=(0,1))))
        if spread<3:
            empty.append({'row':row,'column':col,'max_channel_std':round(spread,3)})
            draw.rectangle((xa+3,ya+3,xb-3,yb-3),outline='#00e6ff',width=2)
            draw.text((xa+7,ya+26),'空格',font=font,fill='#00e6ff')
visual.crop((545,141,903,473)).resize((716,664)).save(ROOT/'last_page_empty_cells.png')
(ROOT/'replay_results.json').write_text(json.dumps({'method':'RGB TM_SQDIFF_NORMED; illustrative cutoff 0.08',
 'template_checks':results,'grid_checks':grid_results,'empty_cells':empty,
 'limitations':['same-resolution supplied samples only','template reference reused within sample set',
 'OCR not executed','no scrolling or dynamic return-button test','empty classifier provisional']},ensure_ascii=False,indent=2),encoding='utf8')
print(json.dumps({'grid_checks':grid_results,'empty_cells':empty,
 'button_states':{i:{name:result['matched'] for name,result in m.items()} for i,m in results.items()}},ensure_ascii=False))
