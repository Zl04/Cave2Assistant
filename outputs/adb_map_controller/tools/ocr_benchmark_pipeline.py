"""Shared full-screen OCR preprocessing for controlled benchmarks."""
import cv2
import numpy as np
import pyclipper

def prepare_detection(image, fast=False):
    height, width = image.shape[:2]
    ratio = min(1., 960 / max(height, width))
    rh, rw = max(32, round(height * ratio / 32) * 32), max(32, round(width * ratio / 32) * 32)
    if fast:
        value = cv2.dnn.blobFromImage(image,scalefactor=1/255,size=(rw,rh),
            mean=(123.675,116.28,103.53),swapRB=False,crop=False)
        value /= np.array([.229,.224,.225],np.float32).reshape(1,3,1,1)
        return value
    resized = cv2.resize(image, (rw, rh)).astype(np.float32) / 255
    return np.ascontiguousarray(((resized - np.array([.485,.456,.406], np.float32)) / np.array([.229,.224,.225], np.float32)).transpose(2,0,1)[None])

def detection_boxes(output, image):
    probability = output[0, 0]
    bitmap = (probability > .2).astype(np.uint8)
    contours, _ = cv2.findContours(bitmap, cv2.RETR_LIST, cv2.CHAIN_APPROX_SIMPLE)
    boxes = []
    for contour in contours[:1000]:
        rect = cv2.minAreaRect(contour)
        if min(rect[1]) < 3:
            continue
        points = cv2.boxPoints(rect)
        left, top = np.floor(points.min(axis=0)).astype(int)
        right, bottom = np.ceil(points.max(axis=0)).astype(int)
        left, top = max(0,left), max(0,top)
        right, bottom = min(probability.shape[1]-1,right), min(probability.shape[0]-1,bottom)
        mask = np.zeros((bottom-top+1,right-left+1), np.uint8)
        cv2.fillPoly(mask, [np.round(points-[left,top]).astype(np.int32)], 1)
        if cv2.mean(probability[top:bottom+1,left:right+1], mask)[0] < .35:
            continue
        perimeter = cv2.arcLength(points, True)
        if perimeter <= 0:
            continue
        offset = pyclipper.PyclipperOffset()
        offset.AddPath(np.round(points*1024).astype(np.int64).tolist(), pyclipper.JT_ROUND, pyclipper.ET_CLOSEDPOLYGON)
        expanded = offset.Execute(cv2.contourArea(points)*1.6/perimeter*1024)
        if len(expanded) != 1:
            continue
        rect = cv2.minAreaRect(np.array(expanded[0],np.float32)/1024)
        if min(rect[1]) < 5:
            continue
        points = cv2.boxPoints(rect)
        # Order the four vertices clockwise from the top-left.
        points = points[np.argsort(points[:,0])]
        l = points[:2][np.argsort(points[:2,1])]
        r = points[2:][np.argsort(points[2:,1])]
        points = np.array([l[0],r[0],r[1],l[1]],np.float32)
        points[:,0] *= image.shape[1]/probability.shape[1]
        points[:,1] *= image.shape[0]/probability.shape[0]
        points[:,0] = np.clip(np.round(points[:,0]),0,image.shape[1]-1)
        points[:,1] = np.clip(np.round(points[:,1]),0,image.shape[0]-1)
        boxes.append(points)
    return sorted(boxes,key=lambda p:(p[0,1],p[0,0]))

def prepare_recognition(image, boxes, batch_size=6, min_width=320, width_multiple=1, fixed_batch=False, adaptive_batch=False):
    crops = []
    for p in boxes:
        w = max(1,int(max(np.linalg.norm(p[0]-p[1]),np.linalg.norm(p[2]-p[3]))))
        h = max(1,int(max(np.linalg.norm(p[0]-p[3]),np.linalg.norm(p[1]-p[2]))))
        target = np.array([[0,0],[w,0],[w,h],[0,h]],np.float32)
        crop = cv2.warpPerspective(image,cv2.getPerspectiveTransform(p,target),(w,h),flags=cv2.INTER_CUBIC,borderMode=cv2.BORDER_REPLICATE)
        if h/w >= 1.5:
            crop = np.rot90(crop)
        crops.append(crop)
    order = sorted(range(len(crops)),key=lambda i:crops[i].shape[1]/crops[i].shape[0])
    batches = []
    for start in range(0,len(order),batch_size):
        selected = [crops[i] for i in order[start:start+batch_size]]
        target_width = max(min_width,int(48*max(c.shape[1]/c.shape[0] for c in selected)))
        target_width = int(np.ceil(target_width/width_multiple)*width_multiple)
        rows = batch_size if fixed_batch else len(selected)
        if adaptive_batch:
            rows = 2**int(np.ceil(np.log2(len(selected))))
        batch = np.zeros((rows,3,48,target_width),np.float32)
        for i,crop in enumerate(selected):
            resized_width = min(target_width,int(np.ceil(48*crop.shape[1]/crop.shape[0])))
            normalized = cv2.resize(crop,(resized_width,48)).astype(np.float32)/127.5-1
            batch[i,:,:,:resized_width] = normalized.transpose(2,0,1)
        batches.append(batch)
    return batches, order

