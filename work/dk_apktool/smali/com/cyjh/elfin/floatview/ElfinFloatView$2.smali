.class Lcom/cyjh/elfin/floatview/ElfinFloatView$2;
.super Ljava/lang/Object;
.source "ElfinFloatView.java"

# interfaces
.implements Landroid/view/View$OnTouchListener;


# annotations
.annotation system Ldalvik/annotation/EnclosingClass;
    value = Lcom/cyjh/elfin/floatview/ElfinFloatView;
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x0
    name = null
.end annotation


# static fields
.field private static final MIN_MOVEMENT:I = 0x5


# instance fields
.field private gestureDetector:Landroid/view/GestureDetector;

.field private gestureListener:Lcom/cyjh/elfin/floatview/ElfinFloatView$ElfinGestureListener;

.field final synthetic this$0:Lcom/cyjh/elfin/floatview/ElfinFloatView;


# direct methods
.method constructor <init>(Lcom/cyjh/elfin/floatview/ElfinFloatView;)V
    .locals 3
    .param p1, "this$0"    # Lcom/cyjh/elfin/floatview/ElfinFloatView;

    .prologue
    .line 441
    iput-object p1, p0, Lcom/cyjh/elfin/floatview/ElfinFloatView$2;->this$0:Lcom/cyjh/elfin/floatview/ElfinFloatView;

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    .line 443
    new-instance v0, Lcom/cyjh/elfin/floatview/ElfinFloatView$ElfinGestureListener;

    iget-object v1, p0, Lcom/cyjh/elfin/floatview/ElfinFloatView$2;->this$0:Lcom/cyjh/elfin/floatview/ElfinFloatView;

    const/4 v2, 0x0

    invoke-direct {v0, v1, v2}, Lcom/cyjh/elfin/floatview/ElfinFloatView$ElfinGestureListener;-><init>(Lcom/cyjh/elfin/floatview/ElfinFloatView;Lcom/cyjh/elfin/floatview/ElfinFloatView$1;)V

    iput-object v0, p0, Lcom/cyjh/elfin/floatview/ElfinFloatView$2;->gestureListener:Lcom/cyjh/elfin/floatview/ElfinFloatView$ElfinGestureListener;

    .line 444
    new-instance v0, Landroid/view/GestureDetector;

    iget-object v1, p0, Lcom/cyjh/elfin/floatview/ElfinFloatView$2;->this$0:Lcom/cyjh/elfin/floatview/ElfinFloatView;

    invoke-virtual {v1}, Lcom/cyjh/elfin/floatview/ElfinFloatView;->getContext()Landroid/content/Context;

    move-result-object v1

    iget-object v2, p0, Lcom/cyjh/elfin/floatview/ElfinFloatView$2;->gestureListener:Lcom/cyjh/elfin/floatview/ElfinFloatView$ElfinGestureListener;

    invoke-direct {v0, v1, v2}, Landroid/view/GestureDetector;-><init>(Landroid/content/Context;Landroid/view/GestureDetector$OnGestureListener;)V

    iput-object v0, p0, Lcom/cyjh/elfin/floatview/ElfinFloatView$2;->gestureDetector:Landroid/view/GestureDetector;

    return-void
.end method


# virtual methods
.method public getDistance(FFFF)F
    .locals 8
    .param p1, "x1"    # F
    .param p2, "y1"    # F
    .param p3, "x2"    # F
    .param p4, "y2"    # F

    .prologue
    const-wide/high16 v6, 0x4000000000000000L    # 2.0

    .line 455
    sub-float v1, p1, p3

    float-to-double v2, v1

    invoke-static {v2, v3, v6, v7}, Ljava/lang/Math;->pow(DD)D

    move-result-wide v2

    sub-float v1, p2, p4

    float-to-double v4, v1

    invoke-static {v4, v5, v6, v7}, Ljava/lang/Math;->pow(DD)D

    move-result-wide v4

    add-double/2addr v2, v4

    invoke-static {v2, v3}, Ljava/lang/Math;->sqrt(D)D

    move-result-wide v2

    double-to-float v0, v2

    .line 456
    .local v0, "distance":F
    return v0
.end method

.method public onTouch(Landroid/view/View;Landroid/view/MotionEvent;)Z
    .locals 10
    .param p1, "v"    # Landroid/view/View;
    .param p2, "event"    # Landroid/view/MotionEvent;

    .prologue
    .line 461
    iget-object v6, p0, Lcom/cyjh/elfin/floatview/ElfinFloatView$2;->gestureDetector:Landroid/view/GestureDetector;

    invoke-virtual {v6, p2}, Landroid/view/GestureDetector;->onTouchEvent(Landroid/view/MotionEvent;)Z

    move-result v6

    if-eqz v6, :cond_0

    .line 462
    const/4 v6, 0x1

    .line 534
    :goto_0
    return v6

    .line 464
    :cond_0
    invoke-virtual {p2}, Landroid/view/MotionEvent;->getAction()I

    move-result v6

    packed-switch v6, :pswitch_data_0

    .line 534
    :goto_1
    const/4 v6, 0x0

    goto :goto_0

    .line 466
    :pswitch_0
    iget-object v6, p0, Lcom/cyjh/elfin/floatview/ElfinFloatView$2;->this$0:Lcom/cyjh/elfin/floatview/ElfinFloatView;

    invoke-static {v6}, Lcom/cyjh/elfin/floatview/ElfinFloatView;->access$400(Lcom/cyjh/elfin/floatview/ElfinFloatView;)V

    .line 467
    iget-object v6, p0, Lcom/cyjh/elfin/floatview/ElfinFloatView$2;->this$0:Lcom/cyjh/elfin/floatview/ElfinFloatView;

    invoke-virtual {p2}, Landroid/view/MotionEvent;->getRawX()F

    move-result v7

    invoke-static {v6, v7}, Lcom/cyjh/elfin/floatview/ElfinFloatView;->access$502(Lcom/cyjh/elfin/floatview/ElfinFloatView;F)F

    .line 468
    iget-object v6, p0, Lcom/cyjh/elfin/floatview/ElfinFloatView$2;->this$0:Lcom/cyjh/elfin/floatview/ElfinFloatView;

    invoke-virtual {p2}, Landroid/view/MotionEvent;->getRawY()F

    move-result v7

    iget-object v8, p0, Lcom/cyjh/elfin/floatview/ElfinFloatView$2;->this$0:Lcom/cyjh/elfin/floatview/ElfinFloatView;

    invoke-virtual {v8}, Lcom/cyjh/elfin/floatview/ElfinFloatView;->getContext()Landroid/content/Context;

    move-result-object v8

    invoke-static {v8}, Lcom/cyjh/elfin/util/AppDeviceUtils;->getStatusBarHeight(Landroid/content/Context;)I

    move-result v8

    int-to-float v8, v8

    sub-float/2addr v7, v8

    invoke-static {v6, v7}, Lcom/cyjh/elfin/floatview/ElfinFloatView;->access$602(Lcom/cyjh/elfin/floatview/ElfinFloatView;F)F

    .line 469
    iget-object v6, p0, Lcom/cyjh/elfin/floatview/ElfinFloatView$2;->this$0:Lcom/cyjh/elfin/floatview/ElfinFloatView;

    invoke-virtual {p2}, Landroid/view/MotionEvent;->getX()F

    move-result v7

    invoke-static {v6, v7}, Lcom/cyjh/elfin/floatview/ElfinFloatView;->access$102(Lcom/cyjh/elfin/floatview/ElfinFloatView;F)F

    .line 470
    iget-object v6, p0, Lcom/cyjh/elfin/floatview/ElfinFloatView$2;->this$0:Lcom/cyjh/elfin/floatview/ElfinFloatView;

    invoke-virtual {p2}, Landroid/view/MotionEvent;->getY()F

    move-result v7

    invoke-static {v6, v7}, Lcom/cyjh/elfin/floatview/ElfinFloatView;->access$702(Lcom/cyjh/elfin/floatview/ElfinFloatView;F)F

    goto :goto_1

    .line 474
    :pswitch_1
    iget-object v6, p0, Lcom/cyjh/elfin/floatview/ElfinFloatView$2;->this$0:Lcom/cyjh/elfin/floatview/ElfinFloatView;

    invoke-static {v6}, Lcom/cyjh/elfin/floatview/ElfinFloatView;->access$800(Lcom/cyjh/elfin/floatview/ElfinFloatView;)Landroid/widget/LinearLayout;

    move-result-object v6

    invoke-virtual {v6}, Landroid/widget/LinearLayout;->getVisibility()I

    move-result v6

    if-nez v6, :cond_1

    .line 475
    const/4 v6, 0x1

    goto :goto_0

    .line 477
    :cond_1
    iget-object v6, p0, Lcom/cyjh/elfin/floatview/ElfinFloatView$2;->this$0:Lcom/cyjh/elfin/floatview/ElfinFloatView;

    iget-object v7, p0, Lcom/cyjh/elfin/floatview/ElfinFloatView$2;->this$0:Lcom/cyjh/elfin/floatview/ElfinFloatView;

    invoke-static {v7}, Lcom/cyjh/elfin/floatview/ElfinFloatView;->access$500(Lcom/cyjh/elfin/floatview/ElfinFloatView;)F

    move-result v7

    invoke-static {v6, v7}, Lcom/cyjh/elfin/floatview/ElfinFloatView;->access$902(Lcom/cyjh/elfin/floatview/ElfinFloatView;F)F

    .line 478
    iget-object v6, p0, Lcom/cyjh/elfin/floatview/ElfinFloatView$2;->this$0:Lcom/cyjh/elfin/floatview/ElfinFloatView;

    iget-object v7, p0, Lcom/cyjh/elfin/floatview/ElfinFloatView$2;->this$0:Lcom/cyjh/elfin/floatview/ElfinFloatView;

    invoke-static {v7}, Lcom/cyjh/elfin/floatview/ElfinFloatView;->access$600(Lcom/cyjh/elfin/floatview/ElfinFloatView;)F

    move-result v7

    invoke-static {v6, v7}, Lcom/cyjh/elfin/floatview/ElfinFloatView;->access$1002(Lcom/cyjh/elfin/floatview/ElfinFloatView;F)F

    .line 480
    iget-object v6, p0, Lcom/cyjh/elfin/floatview/ElfinFloatView$2;->this$0:Lcom/cyjh/elfin/floatview/ElfinFloatView;

    invoke-virtual {p2}, Landroid/view/MotionEvent;->getRawX()F

    move-result v7

    invoke-static {v6, v7}, Lcom/cyjh/elfin/floatview/ElfinFloatView;->access$502(Lcom/cyjh/elfin/floatview/ElfinFloatView;F)F

    .line 481
    iget-object v6, p0, Lcom/cyjh/elfin/floatview/ElfinFloatView$2;->this$0:Lcom/cyjh/elfin/floatview/ElfinFloatView;

    invoke-virtual {p2}, Landroid/view/MotionEvent;->getRawY()F

    move-result v7

    iget-object v8, p0, Lcom/cyjh/elfin/floatview/ElfinFloatView$2;->this$0:Lcom/cyjh/elfin/floatview/ElfinFloatView;

    invoke-virtual {v8}, Lcom/cyjh/elfin/floatview/ElfinFloatView;->getContext()Landroid/content/Context;

    move-result-object v8

    invoke-static {v8}, Lcom/cyjh/elfin/util/AppDeviceUtils;->getStatusBarHeight(Landroid/content/Context;)I

    move-result v8

    int-to-float v8, v8

    sub-float/2addr v7, v8

    invoke-static {v6, v7}, Lcom/cyjh/elfin/floatview/ElfinFloatView;->access$602(Lcom/cyjh/elfin/floatview/ElfinFloatView;F)F

    .line 484
    iget-object v6, p0, Lcom/cyjh/elfin/floatview/ElfinFloatView$2;->this$0:Lcom/cyjh/elfin/floatview/ElfinFloatView;

    invoke-static {v6}, Lcom/cyjh/elfin/floatview/ElfinFloatView;->access$900(Lcom/cyjh/elfin/floatview/ElfinFloatView;)F

    move-result v6

    iget-object v7, p0, Lcom/cyjh/elfin/floatview/ElfinFloatView$2;->this$0:Lcom/cyjh/elfin/floatview/ElfinFloatView;

    invoke-static {v7}, Lcom/cyjh/elfin/floatview/ElfinFloatView;->access$1000(Lcom/cyjh/elfin/floatview/ElfinFloatView;)F

    move-result v7

    iget-object v8, p0, Lcom/cyjh/elfin/floatview/ElfinFloatView$2;->this$0:Lcom/cyjh/elfin/floatview/ElfinFloatView;

    invoke-static {v8}, Lcom/cyjh/elfin/floatview/ElfinFloatView;->access$500(Lcom/cyjh/elfin/floatview/ElfinFloatView;)F

    move-result v8

    iget-object v9, p0, Lcom/cyjh/elfin/floatview/ElfinFloatView$2;->this$0:Lcom/cyjh/elfin/floatview/ElfinFloatView;

    invoke-static {v9}, Lcom/cyjh/elfin/floatview/ElfinFloatView;->access$600(Lcom/cyjh/elfin/floatview/ElfinFloatView;)F

    move-result v9

    invoke-virtual {p0, v6, v7, v8, v9}, Lcom/cyjh/elfin/floatview/ElfinFloatView$2;->getDistance(FFFF)F

    move-result v6

    const/high16 v7, 0x40a00000    # 5.0f

    cmpg-float v6, v6, v7

    if-gtz v6, :cond_2

    .line 485
    const/4 v6, 0x1

    goto/16 :goto_0

    .line 487
    :cond_2
    const/4 v2, 0x1

    .line 488
    .local v2, "elfinDirection":I
    iget-object v6, p0, Lcom/cyjh/elfin/floatview/ElfinFloatView$2;->this$0:Lcom/cyjh/elfin/floatview/ElfinFloatView;

    invoke-static {v6}, Lcom/cyjh/elfin/floatview/ElfinFloatView;->access$600(Lcom/cyjh/elfin/floatview/ElfinFloatView;)F

    move-result v6

    iget-object v7, p0, Lcom/cyjh/elfin/floatview/ElfinFloatView$2;->this$0:Lcom/cyjh/elfin/floatview/ElfinFloatView;

    invoke-static {v7}, Lcom/cyjh/elfin/floatview/ElfinFloatView;->access$1000(Lcom/cyjh/elfin/floatview/ElfinFloatView;)F

    move-result v7

    sub-float/2addr v6, v7

    float-to-double v6, v6

    iget-object v8, p0, Lcom/cyjh/elfin/floatview/ElfinFloatView$2;->this$0:Lcom/cyjh/elfin/floatview/ElfinFloatView;

    invoke-static {v8}, Lcom/cyjh/elfin/floatview/ElfinFloatView;->access$500(Lcom/cyjh/elfin/floatview/ElfinFloatView;)F

    move-result v8

    iget-object v9, p0, Lcom/cyjh/elfin/floatview/ElfinFloatView$2;->this$0:Lcom/cyjh/elfin/floatview/ElfinFloatView;

    invoke-static {v9}, Lcom/cyjh/elfin/floatview/ElfinFloatView;->access$900(Lcom/cyjh/elfin/floatview/ElfinFloatView;)F

    move-result v9

    sub-float/2addr v8, v9

    float-to-double v8, v8

    invoke-static {v6, v7, v8, v9}, Ljava/lang/Math;->atan2(DD)D

    move-result-wide v4

    .line 489
    .local v4, "radian":D
    invoke-static {v4, v5}, Ljava/lang/Math;->toDegrees(D)D

    move-result-wide v0

    .line 490
    .local v0, "degree":D
    const-wide/high16 v6, -0x3fb2000000000000L    # -60.0

    cmpg-double v6, v0, v6

    if-gez v6, :cond_5

    const-wide/high16 v6, -0x3fa2000000000000L    # -120.0

    cmpl-double v6, v0, v6

    if-lez v6, :cond_5

    .line 491
    const/4 v2, 0x1

    .line 499
    :cond_3
    :goto_2
    iget-object v6, p0, Lcom/cyjh/elfin/floatview/ElfinFloatView$2;->this$0:Lcom/cyjh/elfin/floatview/ElfinFloatView;

    invoke-static {v6, v2}, Lcom/cyjh/elfin/floatview/ElfinFloatView;->access$1100(Lcom/cyjh/elfin/floatview/ElfinFloatView;I)V

    .line 500
    iget-object v6, p0, Lcom/cyjh/elfin/floatview/ElfinFloatView$2;->this$0:Lcom/cyjh/elfin/floatview/ElfinFloatView;

    iget-object v7, p0, Lcom/cyjh/elfin/floatview/ElfinFloatView$2;->this$0:Lcom/cyjh/elfin/floatview/ElfinFloatView;

    invoke-static {v7}, Lcom/cyjh/elfin/floatview/ElfinFloatView;->access$500(Lcom/cyjh/elfin/floatview/ElfinFloatView;)F

    move-result v7

    iget-object v8, p0, Lcom/cyjh/elfin/floatview/ElfinFloatView$2;->this$0:Lcom/cyjh/elfin/floatview/ElfinFloatView;

    invoke-static {v8}, Lcom/cyjh/elfin/floatview/ElfinFloatView;->access$100(Lcom/cyjh/elfin/floatview/ElfinFloatView;)F

    move-result v8

    sub-float/2addr v7, v8

    float-to-int v7, v7

    iget-object v8, p0, Lcom/cyjh/elfin/floatview/ElfinFloatView$2;->this$0:Lcom/cyjh/elfin/floatview/ElfinFloatView;

    invoke-static {v8}, Lcom/cyjh/elfin/floatview/ElfinFloatView;->access$600(Lcom/cyjh/elfin/floatview/ElfinFloatView;)F

    move-result v8

    iget-object v9, p0, Lcom/cyjh/elfin/floatview/ElfinFloatView$2;->this$0:Lcom/cyjh/elfin/floatview/ElfinFloatView;

    invoke-static {v9}, Lcom/cyjh/elfin/floatview/ElfinFloatView;->access$700(Lcom/cyjh/elfin/floatview/ElfinFloatView;)F

    move-result v9

    sub-float/2addr v8, v9

    float-to-int v8, v8

    invoke-virtual {v6, v7, v8}, Lcom/cyjh/elfin/floatview/ElfinFloatView;->updateFloatViewPosition(II)V

    .line 501
    iget-object v6, p0, Lcom/cyjh/elfin/floatview/ElfinFloatView$2;->this$0:Lcom/cyjh/elfin/floatview/ElfinFloatView;

    invoke-static {v6}, Lcom/cyjh/elfin/floatview/ElfinFloatView;->access$1200(Lcom/cyjh/elfin/floatview/ElfinFloatView;)Lcom/cyjh/elfin/floatview/DeleteFloatView;

    move-result-object v6

    invoke-virtual {v6}, Lcom/cyjh/elfin/floatview/DeleteFloatView;->getVisibility()I

    move-result v6

    const/16 v7, 0x8

    if-ne v6, v7, :cond_4

    .line 502
    iget-object v6, p0, Lcom/cyjh/elfin/floatview/ElfinFloatView$2;->this$0:Lcom/cyjh/elfin/floatview/ElfinFloatView;

    invoke-static {v6}, Lcom/cyjh/elfin/floatview/ElfinFloatView;->access$1200(Lcom/cyjh/elfin/floatview/ElfinFloatView;)Lcom/cyjh/elfin/floatview/DeleteFloatView;

    move-result-object v6

    const/4 v7, 0x0

    invoke-virtual {v6, v7}, Lcom/cyjh/elfin/floatview/DeleteFloatView;->setVisibility(I)V

    .line 504
    :cond_4
    iget-object v6, p0, Lcom/cyjh/elfin/floatview/ElfinFloatView$2;->this$0:Lcom/cyjh/elfin/floatview/ElfinFloatView;

    invoke-static {v6}, Lcom/cyjh/elfin/floatview/ElfinFloatView;->access$1300(Lcom/cyjh/elfin/floatview/ElfinFloatView;)Z

    move-result v6

    if-eqz v6, :cond_9

    .line 505
    iget-object v6, p0, Lcom/cyjh/elfin/floatview/ElfinFloatView$2;->this$0:Lcom/cyjh/elfin/floatview/ElfinFloatView;

    invoke-static {v6}, Lcom/cyjh/elfin/floatview/ElfinFloatView;->access$1200(Lcom/cyjh/elfin/floatview/ElfinFloatView;)Lcom/cyjh/elfin/floatview/DeleteFloatView;

    move-result-object v6

    invoke-virtual {v6}, Lcom/cyjh/elfin/floatview/DeleteFloatView;->setHide()V

    .line 509
    :goto_3
    const/4 v6, 0x1

    goto/16 :goto_0

    .line 492
    :cond_5
    const-wide/high16 v6, -0x3fb2000000000000L    # -60.0

    cmpl-double v6, v0, v6

    if-ltz v6, :cond_6

    const-wide/high16 v6, 0x404e000000000000L    # 60.0

    cmpg-double v6, v0, v6

    if-gtz v6, :cond_6

    .line 493
    const/4 v2, 0x2

    goto :goto_2

    .line 494
    :cond_6
    const-wide/high16 v6, 0x404e000000000000L    # 60.0

    cmpl-double v6, v0, v6

    if-lez v6, :cond_7

    const-wide/high16 v6, 0x405e000000000000L    # 120.0

    cmpg-double v6, v0, v6

    if-gez v6, :cond_7

    .line 495
    const/4 v2, 0x3

    goto :goto_2

    .line 496
    :cond_7
    const-wide/high16 v6, 0x405e000000000000L    # 120.0

    cmpl-double v6, v0, v6

    if-gez v6, :cond_8

    const-wide/high16 v6, -0x3fa2000000000000L    # -120.0

    cmpg-double v6, v0, v6

    if-gtz v6, :cond_3

    .line 497
    :cond_8
    const/4 v2, 0x4

    goto :goto_2

    .line 507
    :cond_9
    iget-object v6, p0, Lcom/cyjh/elfin/floatview/ElfinFloatView$2;->this$0:Lcom/cyjh/elfin/floatview/ElfinFloatView;

    invoke-static {v6}, Lcom/cyjh/elfin/floatview/ElfinFloatView;->access$1200(Lcom/cyjh/elfin/floatview/ElfinFloatView;)Lcom/cyjh/elfin/floatview/DeleteFloatView;

    move-result-object v6

    invoke-virtual {v6}, Lcom/cyjh/elfin/floatview/DeleteFloatView;->setNormal()V

    goto :goto_3

    .line 511
    .end local v0    # "degree":D
    .end local v2    # "elfinDirection":I
    .end local v4    # "radian":D
    :pswitch_2
    iget-object v6, p0, Lcom/cyjh/elfin/floatview/ElfinFloatView$2;->this$0:Lcom/cyjh/elfin/floatview/ElfinFloatView;

    invoke-virtual {p2}, Landroid/view/MotionEvent;->getRawX()F

    move-result v7

    invoke-static {v6, v7}, Lcom/cyjh/elfin/floatview/ElfinFloatView;->access$502(Lcom/cyjh/elfin/floatview/ElfinFloatView;F)F

    .line 512
    iget-object v6, p0, Lcom/cyjh/elfin/floatview/ElfinFloatView$2;->this$0:Lcom/cyjh/elfin/floatview/ElfinFloatView;

    invoke-virtual {p2}, Landroid/view/MotionEvent;->getRawY()F

    move-result v7

    iget-object v8, p0, Lcom/cyjh/elfin/floatview/ElfinFloatView$2;->this$0:Lcom/cyjh/elfin/floatview/ElfinFloatView;

    invoke-virtual {v8}, Lcom/cyjh/elfin/floatview/ElfinFloatView;->getContext()Landroid/content/Context;

    move-result-object v8

    invoke-static {v8}, Lcom/cyjh/elfin/util/AppDeviceUtils;->getStatusBarHeight(Landroid/content/Context;)I

    move-result v8

    int-to-float v8, v8

    sub-float/2addr v7, v8

    invoke-static {v6, v7}, Lcom/cyjh/elfin/floatview/ElfinFloatView;->access$602(Lcom/cyjh/elfin/floatview/ElfinFloatView;F)F

    .line 514
    iget-object v6, p0, Lcom/cyjh/elfin/floatview/ElfinFloatView$2;->this$0:Lcom/cyjh/elfin/floatview/ElfinFloatView;

    invoke-static {v6}, Lcom/cyjh/elfin/floatview/ElfinFloatView;->access$1300(Lcom/cyjh/elfin/floatview/ElfinFloatView;)Z

    move-result v6

    if-eqz v6, :cond_a

    .line 515
    new-instance v3, Lcom/cyjh/elfin/dialog/HideFWDialog;

    iget-object v6, p0, Lcom/cyjh/elfin/floatview/ElfinFloatView$2;->this$0:Lcom/cyjh/elfin/floatview/ElfinFloatView;

    invoke-virtual {v6}, Lcom/cyjh/elfin/floatview/ElfinFloatView;->getContext()Landroid/content/Context;

    move-result-object v6

    invoke-direct {v3, v6}, Lcom/cyjh/elfin/dialog/HideFWDialog;-><init>(Landroid/content/Context;)V

    .line 516
    .local v3, "hideFWDialog":Lcom/cyjh/elfin/dialog/HideFWDialog;
    iget-object v6, p0, Lcom/cyjh/elfin/floatview/ElfinFloatView$2;->this$0:Lcom/cyjh/elfin/floatview/ElfinFloatView;

    invoke-static {v6}, Lcom/cyjh/elfin/floatview/ElfinFloatView;->access$1400(Lcom/cyjh/elfin/floatview/ElfinFloatView;)Lcom/cyjh/elfin/dialog/HideFWDialog$OnHideOKClickListener;

    move-result-object v6

    invoke-virtual {v3, v6}, Lcom/cyjh/elfin/dialog/HideFWDialog;->setOnHideOKClickListener(Lcom/cyjh/elfin/dialog/HideFWDialog$OnHideOKClickListener;)V

    .line 517
    iget-object v6, p0, Lcom/cyjh/elfin/floatview/ElfinFloatView$2;->this$0:Lcom/cyjh/elfin/floatview/ElfinFloatView;

    invoke-static {v6}, Lcom/cyjh/elfin/floatview/ElfinFloatView;->access$1500(Lcom/cyjh/elfin/floatview/ElfinFloatView;)Lcom/cyjh/elfin/dialog/HideFWDialog$OnHideCancelClickListener;

    move-result-object v6

    invoke-virtual {v3, v6}, Lcom/cyjh/elfin/dialog/HideFWDialog;->setOnHideCancelClickListener(Lcom/cyjh/elfin/dialog/HideFWDialog$OnHideCancelClickListener;)V

    .line 518
    new-instance v6, Lcom/cyjh/elfin/floatview/ElfinFloatView$2$1;

    invoke-direct {v6, p0}, Lcom/cyjh/elfin/floatview/ElfinFloatView$2$1;-><init>(Lcom/cyjh/elfin/floatview/ElfinFloatView$2;)V

    invoke-virtual {v3, v6}, Lcom/cyjh/elfin/dialog/HideFWDialog;->setOnCancelListener(Landroid/content/DialogInterface$OnCancelListener;)V

    .line 524
    invoke-virtual {v3}, Lcom/cyjh/elfin/dialog/HideFWDialog;->show()V

    goto/16 :goto_1

    .line 527
    .end local v3    # "hideFWDialog":Lcom/cyjh/elfin/dialog/HideFWDialog;
    :cond_a
    iget-object v6, p0, Lcom/cyjh/elfin/floatview/ElfinFloatView$2;->this$0:Lcom/cyjh/elfin/floatview/ElfinFloatView;

    invoke-static {v6}, Lcom/cyjh/elfin/floatview/ElfinFloatView;->access$800(Lcom/cyjh/elfin/floatview/ElfinFloatView;)Landroid/widget/LinearLayout;

    move-result-object v6

    invoke-virtual {v6}, Landroid/widget/LinearLayout;->getVisibility()I

    move-result v6

    const/16 v7, 0x8

    if-ne v6, v7, :cond_b

    .line 528
    iget-object v6, p0, Lcom/cyjh/elfin/floatview/ElfinFloatView$2;->this$0:Lcom/cyjh/elfin/floatview/ElfinFloatView;

    invoke-static {v6}, Lcom/cyjh/elfin/floatview/ElfinFloatView;->access$1600(Lcom/cyjh/elfin/floatview/ElfinFloatView;)V

    .line 530
    :cond_b
    iget-object v6, p0, Lcom/cyjh/elfin/floatview/ElfinFloatView$2;->this$0:Lcom/cyjh/elfin/floatview/ElfinFloatView;

    invoke-static {v6}, Lcom/cyjh/elfin/floatview/ElfinFloatView;->access$1200(Lcom/cyjh/elfin/floatview/ElfinFloatView;)Lcom/cyjh/elfin/floatview/DeleteFloatView;

    move-result-object v6

    const/16 v7, 0x8

    invoke-virtual {v6, v7}, Lcom/cyjh/elfin/floatview/DeleteFloatView;->setVisibility(I)V

    .line 531
    iget-object v6, p0, Lcom/cyjh/elfin/floatview/ElfinFloatView$2;->this$0:Lcom/cyjh/elfin/floatview/ElfinFloatView;

    invoke-static {v6}, Lcom/cyjh/elfin/floatview/ElfinFloatView;->access$1700(Lcom/cyjh/elfin/floatview/ElfinFloatView;)Landroid/os/CountDownTimer;

    move-result-object v6

    invoke-virtual {v6}, Landroid/os/CountDownTimer;->start()Landroid/os/CountDownTimer;

    goto/16 :goto_1

    .line 464
    nop

    :pswitch_data_0
    .packed-switch 0x0
        :pswitch_0
        :pswitch_2
        :pswitch_1
    .end packed-switch
.end method
