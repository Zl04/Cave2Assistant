.class public abstract Lcom/cyjh/elfin/counttimer/SimpleTimer;
.super Landroid/os/CountDownTimer;
.source "SimpleTimer.java"


# instance fields
.field private final mCell:I

.field private mHandler:Landroid/os/Handler;


# direct methods
.method public constructor <init>(II)V
    .locals 4
    .param p1, "secondsInFuture"    # I
    .param p2, "countDownInterval"    # I

    .prologue
    .line 18
    mul-int/lit16 v0, p1, 0x3e8

    int-to-long v0, v0

    mul-int/lit16 v2, p2, 0x3e8

    int-to-long v2, v2

    invoke-direct {p0, v0, v1, v2, v3}, Landroid/os/CountDownTimer;-><init>(JJ)V

    .line 22
    new-instance v0, Landroid/os/Handler;

    invoke-static {}, Landroid/os/Looper;->getMainLooper()Landroid/os/Looper;

    move-result-object v1

    invoke-direct {v0, v1}, Landroid/os/Handler;-><init>(Landroid/os/Looper;)V

    iput-object v0, p0, Lcom/cyjh/elfin/counttimer/SimpleTimer;->mHandler:Landroid/os/Handler;

    .line 19
    iput p2, p0, Lcom/cyjh/elfin/counttimer/SimpleTimer;->mCell:I

    .line 20
    return-void
.end method

.method static synthetic access$000(Lcom/cyjh/elfin/counttimer/SimpleTimer;)I
    .locals 1
    .param p0, "x0"    # Lcom/cyjh/elfin/counttimer/SimpleTimer;

    .prologue
    .line 7
    iget v0, p0, Lcom/cyjh/elfin/counttimer/SimpleTimer;->mCell:I

    return v0
.end method


# virtual methods
.method protected abstract onTick(I)V
.end method

.method public onTick(J)V
    .locals 7
    .param p1, "millisUntilFinished"    # J

    .prologue
    .line 26
    long-to-float v1, p1

    const/high16 v2, 0x3f800000    # 1.0f

    mul-float/2addr v1, v2

    const/high16 v2, 0x447a0000    # 1000.0f

    div-float/2addr v1, v2

    invoke-static {v1}, Ljava/lang/Math;->round(F)I

    move-result v0

    .line 27
    .local v0, "i":I
    iget v1, p0, Lcom/cyjh/elfin/counttimer/SimpleTimer;->mCell:I

    mul-int/lit8 v1, v1, 0x2

    if-ne v0, v1, :cond_0

    .line 28
    iget-object v1, p0, Lcom/cyjh/elfin/counttimer/SimpleTimer;->mHandler:Landroid/os/Handler;

    new-instance v2, Lcom/cyjh/elfin/counttimer/SimpleTimer$1;

    invoke-direct {v2, p0}, Lcom/cyjh/elfin/counttimer/SimpleTimer$1;-><init>(Lcom/cyjh/elfin/counttimer/SimpleTimer;)V

    iget v3, p0, Lcom/cyjh/elfin/counttimer/SimpleTimer;->mCell:I

    mul-int/lit16 v3, v3, 0x3e8

    int-to-long v4, v3

    invoke-virtual {v1, v2, v4, v5}, Landroid/os/Handler;->postDelayed(Ljava/lang/Runnable;J)Z

    .line 35
    :cond_0
    invoke-virtual {p0, v0}, Lcom/cyjh/elfin/counttimer/SimpleTimer;->onTick(I)V

    .line 36
    return-void
.end method
