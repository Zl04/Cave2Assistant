.class public Lcom/cyjh/elfin/customview/FindErrorView;
.super Landroid/widget/LinearLayout;
.source "FindErrorView.java"


# instance fields
.field protected errorBtn:Landroid/widget/TextView;

.field protected errorImg:Landroid/widget/ImageView;

.field protected errorTips:Landroid/widget/TextView;

.field protected mContext:Landroid/content/Context;


# direct methods
.method public constructor <init>(Landroid/content/Context;)V
    .locals 1
    .param p1, "context"    # Landroid/content/Context;

    .prologue
    .line 23
    const/4 v0, 0x0

    invoke-direct {p0, p1, v0}, Lcom/cyjh/elfin/customview/FindErrorView;-><init>(Landroid/content/Context;Landroid/util/AttributeSet;)V

    .line 24
    return-void
.end method

.method public constructor <init>(Landroid/content/Context;Landroid/util/AttributeSet;)V
    .locals 1
    .param p1, "context"    # Landroid/content/Context;
    .param p2, "attrs"    # Landroid/util/AttributeSet;

    .prologue
    .line 26
    const/4 v0, 0x0

    invoke-direct {p0, p1, p2, v0}, Lcom/cyjh/elfin/customview/FindErrorView;-><init>(Landroid/content/Context;Landroid/util/AttributeSet;I)V

    .line 27
    return-void
.end method

.method public constructor <init>(Landroid/content/Context;Landroid/util/AttributeSet;I)V
    .locals 0
    .param p1, "context"    # Landroid/content/Context;
    .param p2, "attrs"    # Landroid/util/AttributeSet;
    .param p3, "defStyleAttr"    # I

    .prologue
    .line 29
    invoke-direct {p0, p1, p2, p3}, Landroid/widget/LinearLayout;-><init>(Landroid/content/Context;Landroid/util/AttributeSet;I)V

    .line 30
    iput-object p1, p0, Lcom/cyjh/elfin/customview/FindErrorView;->mContext:Landroid/content/Context;

    .line 31
    invoke-direct {p0}, Lcom/cyjh/elfin/customview/FindErrorView;->initView()V

    .line 32
    return-void
.end method

.method private initView()V
    .locals 3

    .prologue
    .line 35
    iget-object v1, p0, Lcom/cyjh/elfin/customview/FindErrorView;->mContext:Landroid/content/Context;

    const-string v2, "layout_inflater"

    invoke-virtual {v1, v2}, Landroid/content/Context;->getSystemService(Ljava/lang/String;)Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Landroid/view/LayoutInflater;

    .line 37
    .local v0, "inflater":Landroid/view/LayoutInflater;
    const v1, 0x7f04007c

    invoke-virtual {v0, v1, p0}, Landroid/view/LayoutInflater;->inflate(ILandroid/view/ViewGroup;)Landroid/view/View;

    .line 38
    const v1, 0x7f0f017e

    invoke-virtual {p0, v1}, Lcom/cyjh/elfin/customview/FindErrorView;->findViewById(I)Landroid/view/View;

    move-result-object v1

    check-cast v1, Landroid/widget/ImageView;

    iput-object v1, p0, Lcom/cyjh/elfin/customview/FindErrorView;->errorImg:Landroid/widget/ImageView;

    .line 39
    const v1, 0x7f0f017f

    invoke-virtual {p0, v1}, Lcom/cyjh/elfin/customview/FindErrorView;->findViewById(I)Landroid/view/View;

    move-result-object v1

    check-cast v1, Landroid/widget/TextView;

    iput-object v1, p0, Lcom/cyjh/elfin/customview/FindErrorView;->errorTips:Landroid/widget/TextView;

    .line 40
    const v1, 0x7f0f0180

    invoke-virtual {p0, v1}, Lcom/cyjh/elfin/customview/FindErrorView;->findViewById(I)Landroid/view/View;

    move-result-object v1

    check-cast v1, Landroid/widget/TextView;

    iput-object v1, p0, Lcom/cyjh/elfin/customview/FindErrorView;->errorBtn:Landroid/widget/TextView;

    .line 41
    return-void
.end method


# virtual methods
.method public setErrorImg(I)V
    .locals 1
    .param p1, "resId"    # I

    .prologue
    .line 44
    iget-object v0, p0, Lcom/cyjh/elfin/customview/FindErrorView;->errorImg:Landroid/widget/ImageView;

    invoke-virtual {v0, p1}, Landroid/widget/ImageView;->setImageResource(I)V

    .line 45
    return-void
.end method

.method public setErrorTips(I)V
    .locals 1
    .param p1, "resId"    # I

    .prologue
    .line 48
    iget-object v0, p0, Lcom/cyjh/elfin/customview/FindErrorView;->errorTips:Landroid/widget/TextView;

    invoke-virtual {v0, p1}, Landroid/widget/TextView;->setText(I)V

    .line 49
    return-void
.end method
