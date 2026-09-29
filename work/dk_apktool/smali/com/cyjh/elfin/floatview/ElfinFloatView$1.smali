.class Lcom/cyjh/elfin/floatview/ElfinFloatView$1;
.super Landroid/os/CountDownTimer;
.source "ElfinFloatView.java"


# annotations
.annotation system Ldalvik/annotation/EnclosingClass;
    value = Lcom/cyjh/elfin/floatview/ElfinFloatView;
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x0
    name = null
.end annotation


# instance fields
.field final synthetic this$0:Lcom/cyjh/elfin/floatview/ElfinFloatView;


# direct methods
.method constructor <init>(Lcom/cyjh/elfin/floatview/ElfinFloatView;JJ)V
    .locals 0
    .param p1, "this$0"    # Lcom/cyjh/elfin/floatview/ElfinFloatView;
    .param p2, "x0"    # J
    .param p4, "x1"    # J

    .prologue
    .line 205
    iput-object p1, p0, Lcom/cyjh/elfin/floatview/ElfinFloatView$1;->this$0:Lcom/cyjh/elfin/floatview/ElfinFloatView;

    invoke-direct {p0, p2, p3, p4, p5}, Landroid/os/CountDownTimer;-><init>(JJ)V

    return-void
.end method


# virtual methods
.method public onFinish()V
    .locals 5

    .prologue
    const/4 v4, 0x2

    .line 218
    new-array v0, v4, [I

    .line 219
    .local v0, "onScreenLocation":[I
    iget-object v1, p0, Lcom/cyjh/elfin/floatview/ElfinFloatView$1;->this$0:Lcom/cyjh/elfin/floatview/ElfinFloatView;

    invoke-static {v1}, Lcom/cyjh/elfin/floatview/ElfinFloatView;->access$000(Lcom/cyjh/elfin/floatview/ElfinFloatView;)Landroid/widget/ImageView;

    move-result-object v1

    invoke-virtual {v1, v0}, Landroid/widget/ImageView;->getLocationOnScreen([I)V

    .line 220
    const/4 v1, 0x0

    aget v1, v0, v1

    int-to-float v1, v1

    iget-object v2, p0, Lcom/cyjh/elfin/floatview/ElfinFloatView$1;->this$0:Lcom/cyjh/elfin/floatview/ElfinFloatView;

    invoke-virtual {v2}, Lcom/cyjh/elfin/floatview/ElfinFloatView;->getContext()Landroid/content/Context;

    move-result-object v2

    invoke-static {v2}, Lcom/cyjh/elfin/util/AppDeviceUtils;->getResolution(Landroid/content/Context;)Landroid/graphics/Point;

    move-result-object v2

    iget v2, v2, Landroid/graphics/Point;->x:I

    int-to-float v2, v2

    iget-object v3, p0, Lcom/cyjh/elfin/floatview/ElfinFloatView$1;->this$0:Lcom/cyjh/elfin/floatview/ElfinFloatView;

    invoke-static {v3}, Lcom/cyjh/elfin/floatview/ElfinFloatView;->access$100(Lcom/cyjh/elfin/floatview/ElfinFloatView;)F

    move-result v3

    sub-float/2addr v2, v3

    const/high16 v3, 0x40000000    # 2.0f

    div-float/2addr v2, v3

    cmpl-float v1, v1, v2

    if-ltz v1, :cond_1

    .line 221
    iget-object v1, p0, Lcom/cyjh/elfin/floatview/ElfinFloatView$1;->this$0:Lcom/cyjh/elfin/floatview/ElfinFloatView;

    invoke-static {v1}, Lcom/cyjh/elfin/floatview/ElfinFloatView;->access$200(Lcom/cyjh/elfin/floatview/ElfinFloatView;)Lcom/cyjh/elfin/AppContext;

    move-result-object v1

    iget v1, v1, Lcom/cyjh/elfin/AppContext;->STATE_SCRIPT:I

    if-ne v1, v4, :cond_0

    .line 222
    iget-object v1, p0, Lcom/cyjh/elfin/floatview/ElfinFloatView$1;->this$0:Lcom/cyjh/elfin/floatview/ElfinFloatView;

    invoke-static {v1}, Lcom/cyjh/elfin/floatview/ElfinFloatView;->access$000(Lcom/cyjh/elfin/floatview/ElfinFloatView;)Landroid/widget/ImageView;

    move-result-object v1

    const v2, 0x7f020080

    invoke-virtual {v1, v2}, Landroid/widget/ImageView;->setImageResource(I)V

    .line 233
    :goto_0
    return-void

    .line 224
    :cond_0
    iget-object v1, p0, Lcom/cyjh/elfin/floatview/ElfinFloatView$1;->this$0:Lcom/cyjh/elfin/floatview/ElfinFloatView;

    invoke-static {v1}, Lcom/cyjh/elfin/floatview/ElfinFloatView;->access$000(Lcom/cyjh/elfin/floatview/ElfinFloatView;)Landroid/widget/ImageView;

    move-result-object v1

    const v2, 0x7f020075

    invoke-virtual {v1, v2}, Landroid/widget/ImageView;->setImageResource(I)V

    goto :goto_0

    .line 227
    :cond_1
    iget-object v1, p0, Lcom/cyjh/elfin/floatview/ElfinFloatView$1;->this$0:Lcom/cyjh/elfin/floatview/ElfinFloatView;

    invoke-static {v1}, Lcom/cyjh/elfin/floatview/ElfinFloatView;->access$200(Lcom/cyjh/elfin/floatview/ElfinFloatView;)Lcom/cyjh/elfin/AppContext;

    move-result-object v1

    iget v1, v1, Lcom/cyjh/elfin/AppContext;->STATE_SCRIPT:I

    if-ne v1, v4, :cond_2

    .line 228
    iget-object v1, p0, Lcom/cyjh/elfin/floatview/ElfinFloatView$1;->this$0:Lcom/cyjh/elfin/floatview/ElfinFloatView;

    invoke-static {v1}, Lcom/cyjh/elfin/floatview/ElfinFloatView;->access$000(Lcom/cyjh/elfin/floatview/ElfinFloatView;)Landroid/widget/ImageView;

    move-result-object v1

    const v2, 0x7f020082

    invoke-virtual {v1, v2}, Landroid/widget/ImageView;->setImageResource(I)V

    goto :goto_0

    .line 230
    :cond_2
    iget-object v1, p0, Lcom/cyjh/elfin/floatview/ElfinFloatView$1;->this$0:Lcom/cyjh/elfin/floatview/ElfinFloatView;

    invoke-static {v1}, Lcom/cyjh/elfin/floatview/ElfinFloatView;->access$000(Lcom/cyjh/elfin/floatview/ElfinFloatView;)Landroid/widget/ImageView;

    move-result-object v1

    const v2, 0x7f020079

    invoke-virtual {v1, v2}, Landroid/widget/ImageView;->setImageResource(I)V

    goto :goto_0
.end method

.method public onTick(J)V
    .locals 3
    .param p1, "millisUntilFinished"    # J

    .prologue
    .line 209
    const-wide/16 v0, 0xbb8

    cmp-long v0, p1, v0

    if-gtz v0, :cond_0

    const-wide/16 v0, 0x7d0

    cmp-long v0, p1, v0

    if-lez v0, :cond_0

    .line 210
    iget-object v0, p0, Lcom/cyjh/elfin/floatview/ElfinFloatView$1;->this$0:Lcom/cyjh/elfin/floatview/ElfinFloatView;

    invoke-static {v0}, Lcom/cyjh/elfin/floatview/ElfinFloatView;->access$000(Lcom/cyjh/elfin/floatview/ElfinFloatView;)Landroid/widget/ImageView;

    move-result-object v0

    const/high16 v1, 0x3f000000    # 0.5f

    invoke-virtual {v0, v1}, Landroid/widget/ImageView;->setAlpha(F)V

    .line 211
    iget-object v0, p0, Lcom/cyjh/elfin/floatview/ElfinFloatView$1;->this$0:Lcom/cyjh/elfin/floatview/ElfinFloatView;

    const/4 v1, 0x0

    invoke-virtual {v0, v1}, Lcom/cyjh/elfin/floatview/ElfinFloatView;->changeToolBarState(Z)V

    .line 214
    :cond_0
    return-void
.end method
