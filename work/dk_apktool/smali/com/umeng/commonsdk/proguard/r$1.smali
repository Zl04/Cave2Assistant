.class final Lcom/umeng/commonsdk/proguard/r$1;
.super Ljava/lang/Object;
.source "SystemLayerUtil.java"

# interfaces
.implements Landroid/hardware/SensorEventListener;


# annotations
.annotation system Ldalvik/annotation/EnclosingClass;
    value = Lcom/umeng/commonsdk/proguard/r;
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x8
    name = null
.end annotation


# direct methods
.method constructor <init>()V
    .locals 0

    .prologue
    .line 56
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method


# virtual methods
.method public onAccuracyChanged(Landroid/hardware/Sensor;I)V
    .locals 0

    .prologue
    .line 84
    return-void
.end method

.method public onSensorChanged(Landroid/hardware/SensorEvent;)V
    .locals 3

    .prologue
    const/16 v2, 0x14

    .line 60
    invoke-static {}, Lcom/umeng/commonsdk/proguard/r;->b()I

    move-result v0

    const/16 v1, 0xf

    if-ge v0, v1, :cond_1

    .line 61
    invoke-static {}, Lcom/umeng/commonsdk/proguard/r;->c()I

    .line 79
    :cond_0
    :goto_0
    return-void

    .line 64
    :cond_1
    invoke-static {}, Lcom/umeng/commonsdk/proguard/r;->d()I

    move-result v0

    if-ge v0, v2, :cond_2

    .line 65
    invoke-static {}, Lcom/umeng/commonsdk/proguard/r;->e()I

    .line 66
    invoke-static {}, Lcom/umeng/commonsdk/proguard/r;->f()Ljava/util/ArrayList;

    move-result-object v0

    iget-object v1, p1, Landroid/hardware/SensorEvent;->values:[F

    invoke-virtual {v0, v1}, Ljava/util/ArrayList;->add(Ljava/lang/Object;)Z

    .line 68
    :cond_2
    invoke-static {}, Lcom/umeng/commonsdk/proguard/r;->d()I

    move-result v0

    if-ne v0, v2, :cond_0

    .line 69
    invoke-static {}, Lcom/umeng/commonsdk/proguard/r;->e()I

    .line 70
    invoke-static {}, Lcom/umeng/commonsdk/proguard/r;->g()I

    move-result v0

    const/4 v1, 0x1

    if-ne v0, v1, :cond_3

    .line 71
    invoke-static {}, Ljava/lang/System;->currentTimeMillis()J

    move-result-wide v0

    invoke-static {v0, v1}, Lcom/umeng/commonsdk/proguard/r;->a(J)J

    .line 73
    :cond_3
    invoke-static {}, Lcom/umeng/commonsdk/proguard/r;->g()I

    move-result v0

    const/4 v1, 0x2

    if-ne v0, v1, :cond_4

    .line 74
    invoke-static {}, Ljava/lang/System;->currentTimeMillis()J

    move-result-wide v0

    invoke-static {v0, v1}, Lcom/umeng/commonsdk/proguard/r;->b(J)J

    .line 76
    :cond_4
    invoke-static {}, Lcom/umeng/commonsdk/proguard/r;->h()I

    .line 77
    invoke-static {}, Lcom/umeng/commonsdk/proguard/r;->i()V

    goto :goto_0
.end method
