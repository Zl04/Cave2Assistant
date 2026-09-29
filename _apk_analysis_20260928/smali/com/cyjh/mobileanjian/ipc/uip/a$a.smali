.class public Lcom/cyjh/mobileanjian/ipc/uip/a$a;
.super Landroid/view/ViewGroup$MarginLayoutParams;
.source "SourceFile"


# annotations
.annotation system Ldalvik/annotation/EnclosingClass;
    value = Lcom/cyjh/mobileanjian/ipc/uip/a;
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x9
    name = "a"
.end annotation


# instance fields
.field public a:I


# direct methods
.method public constructor <init>(II)V
    .locals 1

    .prologue
    .line 400
    invoke-direct {p0, p1, p2}, Landroid/view/ViewGroup$MarginLayoutParams;-><init>(II)V

    .line 385
    const/4 v0, -0x1

    iput v0, p0, Lcom/cyjh/mobileanjian/ipc/uip/a$a;->a:I

    .line 401
    return-void
.end method

.method public constructor <init>(Landroid/content/Context;Landroid/util/AttributeSet;)V
    .locals 3

    .prologue
    const/4 v0, -0x1

    .line 388
    invoke-direct {p0, p1, p2}, Landroid/view/ViewGroup$MarginLayoutParams;-><init>(Landroid/content/Context;Landroid/util/AttributeSet;)V

    .line 385
    iput v0, p0, Lcom/cyjh/mobileanjian/ipc/uip/a$a;->a:I

    .line 390
    sget-object v0, Lcom/cyjh/rootipc/R$styleable;->FlowLayout_Layout:[I

    invoke-virtual {p1, p2, v0}, Landroid/content/Context;->obtainStyledAttributes(Landroid/util/AttributeSet;[I)Landroid/content/res/TypedArray;

    move-result-object v1

    .line 393
    :try_start_0
    sget v0, Lcom/cyjh/rootipc/R$styleable;->FlowLayout_Layout_android_layout_gravity:I

    const/4 v2, -0x1

    invoke-virtual {v1, v0, v2}, Landroid/content/res/TypedArray;->getInt(II)I

    move-result v0

    iput v0, p0, Lcom/cyjh/mobileanjian/ipc/uip/a$a;->a:I
    :try_end_0
    .catchall {:try_start_0 .. :try_end_0} :catchall_0

    .line 395
    invoke-virtual {v1}, Landroid/content/res/TypedArray;->recycle()V

    .line 397
    return-void

    .line 395
    :catchall_0
    move-exception v0

    invoke-virtual {v1}, Landroid/content/res/TypedArray;->recycle()V

    throw v0
.end method

.method public constructor <init>(Landroid/view/ViewGroup$LayoutParams;)V
    .locals 1

    .prologue
    .line 404
    invoke-direct {p0, p1}, Landroid/view/ViewGroup$MarginLayoutParams;-><init>(Landroid/view/ViewGroup$LayoutParams;)V

    .line 385
    const/4 v0, -0x1

    iput v0, p0, Lcom/cyjh/mobileanjian/ipc/uip/a$a;->a:I

    .line 405
    return-void
.end method
