.class public Lcom/cyjh/elfin/customview/loadwidget/swiperefresh/FootView;
.super Lcom/cyjh/elfin/customview/loadwidget/swiperefresh/BaseFootView;
.source "FootView.java"


# instance fields
.field private mClickListener:Landroid/view/View$OnClickListener;

.field protected mLoadEmptyTv:Landroid/widget/TextView;


# direct methods
.method public constructor <init>(Landroid/content/Context;)V
    .locals 1
    .param p1, "context"    # Landroid/content/Context;

    .prologue
    .line 40
    invoke-direct {p0, p1}, Lcom/cyjh/elfin/customview/loadwidget/swiperefresh/BaseFootView;-><init>(Landroid/content/Context;)V

    .line 102
    new-instance v0, Lcom/cyjh/elfin/customview/loadwidget/swiperefresh/FootView$1;

    invoke-direct {v0, p0}, Lcom/cyjh/elfin/customview/loadwidget/swiperefresh/FootView$1;-><init>(Lcom/cyjh/elfin/customview/loadwidget/swiperefresh/FootView;)V

    iput-object v0, p0, Lcom/cyjh/elfin/customview/loadwidget/swiperefresh/FootView;->mClickListener:Landroid/view/View$OnClickListener;

    .line 41
    invoke-direct {p0}, Lcom/cyjh/elfin/customview/loadwidget/swiperefresh/FootView;->init()V

    .line 42
    return-void
.end method

.method public constructor <init>(Landroid/content/Context;Landroid/util/AttributeSet;)V
    .locals 1
    .param p1, "context"    # Landroid/content/Context;
    .param p2, "attrs"    # Landroid/util/AttributeSet;

    .prologue
    .line 35
    invoke-direct {p0, p1, p2}, Lcom/cyjh/elfin/customview/loadwidget/swiperefresh/BaseFootView;-><init>(Landroid/content/Context;Landroid/util/AttributeSet;)V

    .line 102
    new-instance v0, Lcom/cyjh/elfin/customview/loadwidget/swiperefresh/FootView$1;

    invoke-direct {v0, p0}, Lcom/cyjh/elfin/customview/loadwidget/swiperefresh/FootView$1;-><init>(Lcom/cyjh/elfin/customview/loadwidget/swiperefresh/FootView;)V

    iput-object v0, p0, Lcom/cyjh/elfin/customview/loadwidget/swiperefresh/FootView;->mClickListener:Landroid/view/View$OnClickListener;

    .line 36
    invoke-direct {p0}, Lcom/cyjh/elfin/customview/loadwidget/swiperefresh/FootView;->init()V

    .line 37
    return-void
.end method

.method private init()V
    .locals 4

    .prologue
    const/4 v2, -0x1

    .line 49
    new-instance v0, Landroid/widget/LinearLayout$LayoutParams;

    invoke-direct {v0, v2, v2}, Landroid/widget/LinearLayout$LayoutParams;-><init>(II)V

    .line 50
    .local v0, "mLayoutParams":Landroid/widget/LinearLayout$LayoutParams;
    invoke-virtual {p0}, Lcom/cyjh/elfin/customview/loadwidget/swiperefresh/FootView;->getLayout()Landroid/view/View;

    move-result-object v1

    .line 51
    .local v1, "view":Landroid/view/View;
    const/16 v2, 0x11

    iput v2, v0, Landroid/widget/LinearLayout$LayoutParams;->gravity:I

    .line 53
    invoke-virtual {p0, v1, v0}, Lcom/cyjh/elfin/customview/loadwidget/swiperefresh/FootView;->addView(Landroid/view/View;Landroid/view/ViewGroup$LayoutParams;)V

    .line 54
    const v2, 0x7f0f00e8

    invoke-virtual {p0, v2}, Lcom/cyjh/elfin/customview/loadwidget/swiperefresh/FootView;->findViewById(I)Landroid/view/View;

    move-result-object v2

    check-cast v2, Landroid/widget/TextView;

    iput-object v2, p0, Lcom/cyjh/elfin/customview/loadwidget/swiperefresh/FootView;->mLoadEmptyTv:Landroid/widget/TextView;

    .line 55
    iget-object v2, p0, Lcom/cyjh/elfin/customview/loadwidget/swiperefresh/FootView;->mLoadEmptyTv:Landroid/widget/TextView;

    iget-object v3, p0, Lcom/cyjh/elfin/customview/loadwidget/swiperefresh/FootView;->mClickListener:Landroid/view/View$OnClickListener;

    invoke-virtual {v2, v3}, Landroid/widget/TextView;->setOnClickListener(Landroid/view/View$OnClickListener;)V

    .line 56
    return-void
.end method


# virtual methods
.method protected dispathShowView(Landroid/view/View;)V
    .locals 0
    .param p1, "v"    # Landroid/view/View;

    .prologue
    .line 100
    return-void
.end method

.method public getLayout()Landroid/view/View;
    .locals 3

    .prologue
    .line 59
    invoke-virtual {p0}, Lcom/cyjh/elfin/customview/loadwidget/swiperefresh/FootView;->getContext()Landroid/content/Context;

    move-result-object v0

    invoke-static {v0}, Landroid/view/LayoutInflater;->from(Landroid/content/Context;)Landroid/view/LayoutInflater;

    move-result-object v0

    const v1, 0x7f040044

    const/4 v2, 0x0

    invoke-virtual {v0, v1, v2}, Landroid/view/LayoutInflater;->inflate(ILandroid/view/ViewGroup;)Landroid/view/View;

    move-result-object v0

    return-object v0
.end method

.method public onLoadComplete()V
    .locals 2

    .prologue
    .line 78
    iget-object v0, p0, Lcom/cyjh/elfin/customview/loadwidget/swiperefresh/FootView;->mLoadEmptyTv:Landroid/widget/TextView;

    const/16 v1, 0x8

    invoke-virtual {v0, v1}, Landroid/widget/TextView;->setVisibility(I)V

    .line 79
    return-void
.end method

.method public onLoadEmpty()V
    .locals 2

    .prologue
    .line 83
    iget-object v0, p0, Lcom/cyjh/elfin/customview/loadwidget/swiperefresh/FootView;->mLoadEmptyTv:Landroid/widget/TextView;

    const/16 v1, 0x8

    invoke-virtual {v0, v1}, Landroid/widget/TextView;->setVisibility(I)V

    .line 84
    iget-object v0, p0, Lcom/cyjh/elfin/customview/loadwidget/swiperefresh/FootView;->mLoadEmptyTv:Landroid/widget/TextView;

    invoke-virtual {p0, v0}, Lcom/cyjh/elfin/customview/loadwidget/swiperefresh/FootView;->dispathShowView(Landroid/view/View;)V

    .line 85
    return-void
.end method

.method public onLoadFailed()V
    .locals 2

    .prologue
    .line 67
    iget-object v0, p0, Lcom/cyjh/elfin/customview/loadwidget/swiperefresh/FootView;->mLoadEmptyTv:Landroid/widget/TextView;

    const/4 v1, 0x0

    invoke-virtual {v0, v1}, Landroid/widget/TextView;->setVisibility(I)V

    .line 68
    iget-object v0, p0, Lcom/cyjh/elfin/customview/loadwidget/swiperefresh/FootView;->mLoadEmptyTv:Landroid/widget/TextView;

    const-string v1, "\u70b9\u51fb\u52a0\u8f7d\u66f4\u591a"

    invoke-virtual {v0, v1}, Landroid/widget/TextView;->setText(Ljava/lang/CharSequence;)V

    .line 69
    return-void
.end method

.method public onLoadStart()V
    .locals 2

    .prologue
    .line 89
    iget-object v0, p0, Lcom/cyjh/elfin/customview/loadwidget/swiperefresh/FootView;->mLoadEmptyTv:Landroid/widget/TextView;

    const/4 v1, 0x0

    invoke-virtual {v0, v1}, Landroid/widget/TextView;->setVisibility(I)V

    .line 90
    return-void
.end method

.method public onLoadSuccess()V
    .locals 2

    .prologue
    .line 73
    iget-object v0, p0, Lcom/cyjh/elfin/customview/loadwidget/swiperefresh/FootView;->mLoadEmptyTv:Landroid/widget/TextView;

    const-string v1, "\u52a0\u8f7d\u4e2d..."

    invoke-virtual {v0, v1}, Landroid/widget/TextView;->setText(Ljava/lang/CharSequence;)V

    .line 74
    return-void
.end method
