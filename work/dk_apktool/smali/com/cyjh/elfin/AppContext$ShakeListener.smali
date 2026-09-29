.class public Lcom/cyjh/elfin/AppContext$ShakeListener;
.super Ljava/lang/Object;
.source "AppContext.java"

# interfaces
.implements Landroid/hardware/SensorEventListener;


# annotations
.annotation system Ldalvik/annotation/EnclosingClass;
    value = Lcom/cyjh/elfin/AppContext;
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x9
    name = "ShakeListener"
.end annotation

.annotation system Ldalvik/annotation/MemberClasses;
    value = {
        Lcom/cyjh/elfin/AppContext$ShakeListener$OnShakeListener;
    }
.end annotation


# static fields
.field private static final SPEED_SHRESHOLD:I = 0xbb8

.field private static final UPTATE_INTERVAL_TIME:I = 0x64


# instance fields
.field private lastUpdateTime:J

.field private lastX:F

.field private lastY:F

.field private lastZ:F

.field private mContext:Landroid/content/Context;

.field private onShakeListener:Lcom/cyjh/elfin/AppContext$ShakeListener$OnShakeListener;

.field private sensor:Landroid/hardware/Sensor;

.field private sensorManager:Landroid/hardware/SensorManager;


# direct methods
.method public constructor <init>(Landroid/content/Context;)V
    .locals 0
    .param p1, "c"    # Landroid/content/Context;

    .prologue
    .line 644
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    .line 646
    iput-object p1, p0, Lcom/cyjh/elfin/AppContext$ShakeListener;->mContext:Landroid/content/Context;

    .line 647
    invoke-virtual {p0}, Lcom/cyjh/elfin/AppContext$ShakeListener;->start()V

    .line 648
    return-void
.end method


# virtual methods
.method public onAccuracyChanged(Landroid/hardware/Sensor;I)V
    .locals 0
    .param p1, "sensor"    # Landroid/hardware/Sensor;
    .param p2, "accuracy"    # I

    .prologue
    .line 709
    return-void
.end method

.method public onSensorChanged(Landroid/hardware/SensorEvent;)V
    .locals 18
    .param p1, "event"    # Landroid/hardware/SensorEvent;

    .prologue
    .line 679
    invoke-static {}, Ljava/lang/System;->currentTimeMillis()J

    move-result-wide v2

    .line 681
    .local v2, "currentUpdateTime":J
    move-object/from16 v0, p0

    iget-wide v14, v0, Lcom/cyjh/elfin/AppContext$ShakeListener;->lastUpdateTime:J

    sub-long v10, v2, v14

    .line 683
    .local v10, "timeInterval":J
    const-wide/16 v14, 0x64

    cmp-long v14, v10, v14

    if-gez v14, :cond_1

    .line 704
    :cond_0
    :goto_0
    return-void

    .line 686
    :cond_1
    move-object/from16 v0, p0

    iput-wide v2, v0, Lcom/cyjh/elfin/AppContext$ShakeListener;->lastUpdateTime:J

    .line 688
    move-object/from16 v0, p1

    iget-object v14, v0, Landroid/hardware/SensorEvent;->values:[F

    const/4 v15, 0x0

    aget v7, v14, v15

    .line 689
    .local v7, "x":F
    move-object/from16 v0, p1

    iget-object v14, v0, Landroid/hardware/SensorEvent;->values:[F

    const/4 v15, 0x1

    aget v12, v14, v15

    .line 690
    .local v12, "y":F
    move-object/from16 v0, p1

    iget-object v14, v0, Landroid/hardware/SensorEvent;->values:[F

    const/4 v15, 0x2

    aget v13, v14, v15

    .line 692
    .local v13, "z":F
    move-object/from16 v0, p0

    iget v14, v0, Lcom/cyjh/elfin/AppContext$ShakeListener;->lastX:F

    sub-float v4, v7, v14

    .line 693
    .local v4, "deltaX":F
    move-object/from16 v0, p0

    iget v14, v0, Lcom/cyjh/elfin/AppContext$ShakeListener;->lastY:F

    sub-float v5, v12, v14

    .line 694
    .local v5, "deltaY":F
    move-object/from16 v0, p0

    iget v14, v0, Lcom/cyjh/elfin/AppContext$ShakeListener;->lastZ:F

    sub-float v6, v13, v14

    .line 696
    .local v6, "deltaZ":F
    move-object/from16 v0, p0

    iput v7, v0, Lcom/cyjh/elfin/AppContext$ShakeListener;->lastX:F

    .line 697
    move-object/from16 v0, p0

    iput v12, v0, Lcom/cyjh/elfin/AppContext$ShakeListener;->lastY:F

    .line 698
    move-object/from16 v0, p0

    iput v13, v0, Lcom/cyjh/elfin/AppContext$ShakeListener;->lastZ:F

    .line 699
    mul-float v14, v4, v4

    mul-float v15, v5, v5

    add-float/2addr v14, v15

    mul-float v15, v6, v6

    add-float/2addr v14, v15

    float-to-double v14, v14

    invoke-static {v14, v15}, Ljava/lang/Math;->sqrt(D)D

    move-result-wide v14

    long-to-double v0, v10

    move-wide/from16 v16, v0

    div-double v14, v14, v16

    const-wide v16, 0x40c3880000000000L    # 10000.0

    mul-double v8, v14, v16

    .line 701
    .local v8, "speed":D
    const-wide v14, 0x40a7700000000000L    # 3000.0

    cmpl-double v14, v8, v14

    if-ltz v14, :cond_0

    .line 702
    move-object/from16 v0, p0

    iget-object v14, v0, Lcom/cyjh/elfin/AppContext$ShakeListener;->onShakeListener:Lcom/cyjh/elfin/AppContext$ShakeListener$OnShakeListener;

    invoke-interface {v14}, Lcom/cyjh/elfin/AppContext$ShakeListener$OnShakeListener;->onShake()V

    goto :goto_0
.end method

.method public setOnShakeListener(Lcom/cyjh/elfin/AppContext$ShakeListener$OnShakeListener;)V
    .locals 0
    .param p1, "listener"    # Lcom/cyjh/elfin/AppContext$ShakeListener$OnShakeListener;

    .prologue
    .line 672
    iput-object p1, p0, Lcom/cyjh/elfin/AppContext$ShakeListener;->onShakeListener:Lcom/cyjh/elfin/AppContext$ShakeListener$OnShakeListener;

    .line 673
    return-void
.end method

.method public start()V
    .locals 3

    .prologue
    const/4 v2, 0x1

    .line 653
    iget-object v0, p0, Lcom/cyjh/elfin/AppContext$ShakeListener;->mContext:Landroid/content/Context;

    const-string v1, "sensor"

    invoke-virtual {v0, v1}, Landroid/content/Context;->getSystemService(Ljava/lang/String;)Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Landroid/hardware/SensorManager;

    iput-object v0, p0, Lcom/cyjh/elfin/AppContext$ShakeListener;->sensorManager:Landroid/hardware/SensorManager;

    .line 654
    iget-object v0, p0, Lcom/cyjh/elfin/AppContext$ShakeListener;->sensorManager:Landroid/hardware/SensorManager;

    if-eqz v0, :cond_0

    .line 656
    iget-object v0, p0, Lcom/cyjh/elfin/AppContext$ShakeListener;->sensorManager:Landroid/hardware/SensorManager;

    invoke-virtual {v0, v2}, Landroid/hardware/SensorManager;->getDefaultSensor(I)Landroid/hardware/Sensor;

    move-result-object v0

    iput-object v0, p0, Lcom/cyjh/elfin/AppContext$ShakeListener;->sensor:Landroid/hardware/Sensor;

    .line 659
    :cond_0
    iget-object v0, p0, Lcom/cyjh/elfin/AppContext$ShakeListener;->sensor:Landroid/hardware/Sensor;

    if-eqz v0, :cond_1

    .line 660
    iget-object v0, p0, Lcom/cyjh/elfin/AppContext$ShakeListener;->sensorManager:Landroid/hardware/SensorManager;

    iget-object v1, p0, Lcom/cyjh/elfin/AppContext$ShakeListener;->sensor:Landroid/hardware/Sensor;

    invoke-virtual {v0, p0, v1, v2}, Landroid/hardware/SensorManager;->registerListener(Landroid/hardware/SensorEventListener;Landroid/hardware/Sensor;I)Z

    .line 663
    :cond_1
    return-void
.end method

.method public stop()V
    .locals 1

    .prologue
    .line 667
    iget-object v0, p0, Lcom/cyjh/elfin/AppContext$ShakeListener;->sensorManager:Landroid/hardware/SensorManager;

    invoke-virtual {v0, p0}, Landroid/hardware/SensorManager;->unregisterListener(Landroid/hardware/SensorEventListener;)V

    .line 668
    return-void
.end method
