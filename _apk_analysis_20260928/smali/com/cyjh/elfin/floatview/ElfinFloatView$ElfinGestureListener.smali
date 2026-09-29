.class Lcom/cyjh/elfin/floatview/ElfinFloatView$ElfinGestureListener;
.super Ljava/lang/Object;
.source "ElfinFloatView.java"

# interfaces
.implements Landroid/view/GestureDetector$OnGestureListener;


# annotations
.annotation system Ldalvik/annotation/EnclosingClass;
    value = Lcom/cyjh/elfin/floatview/ElfinFloatView;
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x2
    name = "ElfinGestureListener"
.end annotation


# instance fields
.field final synthetic this$0:Lcom/cyjh/elfin/floatview/ElfinFloatView;


# direct methods
.method private constructor <init>(Lcom/cyjh/elfin/floatview/ElfinFloatView;)V
    .locals 0

    .prologue
    .line 558
    iput-object p1, p0, Lcom/cyjh/elfin/floatview/ElfinFloatView$ElfinGestureListener;->this$0:Lcom/cyjh/elfin/floatview/ElfinFloatView;

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method

.method synthetic constructor <init>(Lcom/cyjh/elfin/floatview/ElfinFloatView;Lcom/cyjh/elfin/floatview/ElfinFloatView$1;)V
    .locals 0
    .param p1, "x0"    # Lcom/cyjh/elfin/floatview/ElfinFloatView;
    .param p2, "x1"    # Lcom/cyjh/elfin/floatview/ElfinFloatView$1;

    .prologue
    .line 558
    invoke-direct {p0, p1}, Lcom/cyjh/elfin/floatview/ElfinFloatView$ElfinGestureListener;-><init>(Lcom/cyjh/elfin/floatview/ElfinFloatView;)V

    return-void
.end method


# virtual methods
.method public onDown(Landroid/view/MotionEvent;)Z
    .locals 1
    .param p1, "e"    # Landroid/view/MotionEvent;

    .prologue
    .line 562
    const/4 v0, 0x0

    return v0
.end method

.method public onFling(Landroid/view/MotionEvent;Landroid/view/MotionEvent;FF)Z
    .locals 1
    .param p1, "e1"    # Landroid/view/MotionEvent;
    .param p2, "e2"    # Landroid/view/MotionEvent;
    .param p3, "velocityX"    # F
    .param p4, "velocityY"    # F

    .prologue
    .line 597
    const/4 v0, 0x0

    return v0
.end method

.method public onLongPress(Landroid/view/MotionEvent;)V
    .locals 0
    .param p1, "e"    # Landroid/view/MotionEvent;

    .prologue
    .line 593
    return-void
.end method

.method public onScroll(Landroid/view/MotionEvent;Landroid/view/MotionEvent;FF)Z
    .locals 1
    .param p1, "e1"    # Landroid/view/MotionEvent;
    .param p2, "e2"    # Landroid/view/MotionEvent;
    .param p3, "distanceX"    # F
    .param p4, "distanceY"    # F

    .prologue
    .line 587
    const/4 v0, 0x0

    return v0
.end method

.method public onShowPress(Landroid/view/MotionEvent;)V
    .locals 0
    .param p1, "e"    # Landroid/view/MotionEvent;

    .prologue
    .line 568
    return-void
.end method

.method public onSingleTapUp(Landroid/view/MotionEvent;)Z
    .locals 3
    .param p1, "e"    # Landroid/view/MotionEvent;

    .prologue
    const/4 v2, 0x1

    .line 572
    iget-object v0, p0, Lcom/cyjh/elfin/floatview/ElfinFloatView$ElfinGestureListener;->this$0:Lcom/cyjh/elfin/floatview/ElfinFloatView;

    invoke-static {v0}, Lcom/cyjh/elfin/floatview/ElfinFloatView;->access$1200(Lcom/cyjh/elfin/floatview/ElfinFloatView;)Lcom/cyjh/elfin/floatview/DeleteFloatView;

    move-result-object v0

    invoke-virtual {v0}, Lcom/cyjh/elfin/floatview/DeleteFloatView;->getVisibility()I

    move-result v0

    if-nez v0, :cond_0

    .line 573
    iget-object v0, p0, Lcom/cyjh/elfin/floatview/ElfinFloatView$ElfinGestureListener;->this$0:Lcom/cyjh/elfin/floatview/ElfinFloatView;

    invoke-static {v0}, Lcom/cyjh/elfin/floatview/ElfinFloatView;->access$1200(Lcom/cyjh/elfin/floatview/ElfinFloatView;)Lcom/cyjh/elfin/floatview/DeleteFloatView;

    move-result-object v0

    const/16 v1, 0x8

    invoke-virtual {v0, v1}, Lcom/cyjh/elfin/floatview/DeleteFloatView;->setVisibility(I)V

    .line 575
    :cond_0
    iget-object v0, p0, Lcom/cyjh/elfin/floatview/ElfinFloatView$ElfinGestureListener;->this$0:Lcom/cyjh/elfin/floatview/ElfinFloatView;

    invoke-static {v0}, Lcom/cyjh/elfin/floatview/ElfinFloatView;->access$800(Lcom/cyjh/elfin/floatview/ElfinFloatView;)Landroid/widget/LinearLayout;

    move-result-object v0

    invoke-virtual {v0}, Landroid/widget/LinearLayout;->getVisibility()I

    move-result v0

    if-nez v0, :cond_1

    .line 576
    iget-object v0, p0, Lcom/cyjh/elfin/floatview/ElfinFloatView$ElfinGestureListener;->this$0:Lcom/cyjh/elfin/floatview/ElfinFloatView;

    const/4 v1, 0x0

    invoke-virtual {v0, v1}, Lcom/cyjh/elfin/floatview/ElfinFloatView;->changeToolBarState(Z)V

    .line 580
    :goto_0
    iget-object v0, p0, Lcom/cyjh/elfin/floatview/ElfinFloatView$ElfinGestureListener;->this$0:Lcom/cyjh/elfin/floatview/ElfinFloatView;

    invoke-static {v0}, Lcom/cyjh/elfin/floatview/ElfinFloatView;->access$1700(Lcom/cyjh/elfin/floatview/ElfinFloatView;)Landroid/os/CountDownTimer;

    move-result-object v0

    invoke-virtual {v0}, Landroid/os/CountDownTimer;->start()Landroid/os/CountDownTimer;

    .line 581
    return v2

    .line 578
    :cond_1
    iget-object v0, p0, Lcom/cyjh/elfin/floatview/ElfinFloatView$ElfinGestureListener;->this$0:Lcom/cyjh/elfin/floatview/ElfinFloatView;

    invoke-virtual {v0, v2}, Lcom/cyjh/elfin/floatview/ElfinFloatView;->changeToolBarState(Z)V

    goto :goto_0
.end method
