.class public Lcom/cyjh/elfin/customview/TitleView;
.super Landroid/widget/RelativeLayout;
.source "TitleView.java"


# annotations
.annotation system Ldalvik/annotation/MemberClasses;
    value = {
        Lcom/cyjh/elfin/customview/TitleView$OnRightTextViewOnClickerListener;,
        Lcom/cyjh/elfin/customview/TitleView$onRightImageViewClickListener;,
        Lcom/cyjh/elfin/customview/TitleView$onLeftImageViewClickListener;,
        Lcom/cyjh/elfin/customview/TitleView$OnRightTextViewListener;,
        Lcom/cyjh/elfin/customview/TitleView$OnRightImageViewListener;,
        Lcom/cyjh/elfin/customview/TitleView$OnLeftImageViewListener;
    }
.end annotation


# instance fields
.field private imgLeft:Landroid/widget/ImageView;

.field private imgRight:Landroid/widget/ImageView;

.field private mContext:Landroid/content/Context;

.field private mRightTextView:Landroid/widget/TextView;

.field private onLeftImgeViewListener:Lcom/cyjh/elfin/customview/TitleView$OnLeftImageViewListener;

.field private onRightImageViewListener:Lcom/cyjh/elfin/customview/TitleView$OnRightImageViewListener;

.field private onRightTextViewListener:Lcom/cyjh/elfin/customview/TitleView$OnRightTextViewListener;

.field private tvTitle:Landroid/widget/TextView;


# direct methods
.method public constructor <init>(Landroid/content/Context;)V
    .locals 1
    .param p1, "context"    # Landroid/content/Context;

    .prologue
    .line 28
    const/4 v0, 0x0

    invoke-direct {p0, p1, v0}, Lcom/cyjh/elfin/customview/TitleView;-><init>(Landroid/content/Context;Landroid/util/AttributeSet;)V

    .line 29
    return-void
.end method

.method public constructor <init>(Landroid/content/Context;Landroid/util/AttributeSet;)V
    .locals 1
    .param p1, "context"    # Landroid/content/Context;
    .param p2, "attrs"    # Landroid/util/AttributeSet;

    .prologue
    .line 32
    const/4 v0, 0x0

    invoke-direct {p0, p1, p2, v0}, Lcom/cyjh/elfin/customview/TitleView;-><init>(Landroid/content/Context;Landroid/util/AttributeSet;I)V

    .line 33
    return-void
.end method

.method public constructor <init>(Landroid/content/Context;Landroid/util/AttributeSet;I)V
    .locals 0
    .param p1, "context"    # Landroid/content/Context;
    .param p2, "attrs"    # Landroid/util/AttributeSet;
    .param p3, "defStyleAttr"    # I

    .prologue
    .line 36
    invoke-direct {p0, p1, p2, p3}, Landroid/widget/RelativeLayout;-><init>(Landroid/content/Context;Landroid/util/AttributeSet;I)V

    .line 37
    iput-object p1, p0, Lcom/cyjh/elfin/customview/TitleView;->mContext:Landroid/content/Context;

    .line 38
    invoke-direct {p0}, Lcom/cyjh/elfin/customview/TitleView;->initLayout()V

    .line 39
    invoke-direct {p0}, Lcom/cyjh/elfin/customview/TitleView;->initView()V

    .line 40
    return-void
.end method

.method static synthetic access$300(Lcom/cyjh/elfin/customview/TitleView;)Lcom/cyjh/elfin/customview/TitleView$OnLeftImageViewListener;
    .locals 1
    .param p0, "x0"    # Lcom/cyjh/elfin/customview/TitleView;

    .prologue
    .line 17
    iget-object v0, p0, Lcom/cyjh/elfin/customview/TitleView;->onLeftImgeViewListener:Lcom/cyjh/elfin/customview/TitleView$OnLeftImageViewListener;

    return-object v0
.end method

.method static synthetic access$400(Lcom/cyjh/elfin/customview/TitleView;)Lcom/cyjh/elfin/customview/TitleView$OnRightImageViewListener;
    .locals 1
    .param p0, "x0"    # Lcom/cyjh/elfin/customview/TitleView;

    .prologue
    .line 17
    iget-object v0, p0, Lcom/cyjh/elfin/customview/TitleView;->onRightImageViewListener:Lcom/cyjh/elfin/customview/TitleView$OnRightImageViewListener;

    return-object v0
.end method

.method static synthetic access$500(Lcom/cyjh/elfin/customview/TitleView;)Lcom/cyjh/elfin/customview/TitleView$OnRightTextViewListener;
    .locals 1
    .param p0, "x0"    # Lcom/cyjh/elfin/customview/TitleView;

    .prologue
    .line 17
    iget-object v0, p0, Lcom/cyjh/elfin/customview/TitleView;->onRightTextViewListener:Lcom/cyjh/elfin/customview/TitleView$OnRightTextViewListener;

    return-object v0
.end method

.method private initLayout()V
    .locals 3

    .prologue
    .line 45
    const/16 v0, 0x3c

    const/16 v1, 0x7a

    const/16 v2, 0xc5

    invoke-static {v0, v1, v2}, Landroid/graphics/Color;->rgb(III)I

    move-result v0

    invoke-virtual {p0, v0}, Lcom/cyjh/elfin/customview/TitleView;->setBackgroundColor(I)V

    .line 46
    return-void
.end method

.method private initView()V
    .locals 12

    .prologue
    const/16 v11, 0x14

    const/16 v10, 0xf

    const/4 v9, 0x0

    const/16 v8, 0xa

    const/4 v7, -0x2

    .line 50
    new-instance v2, Landroid/widget/RelativeLayout$LayoutParams;

    invoke-direct {v2, v7, v7}, Landroid/widget/RelativeLayout$LayoutParams;-><init>(II)V

    .line 51
    .local v2, "titleParams":Landroid/widget/RelativeLayout$LayoutParams;
    const/16 v4, 0xd

    invoke-virtual {v2, v4}, Landroid/widget/RelativeLayout$LayoutParams;->addRule(I)V

    .line 52
    new-instance v4, Landroid/widget/TextView;

    iget-object v5, p0, Lcom/cyjh/elfin/customview/TitleView;->mContext:Landroid/content/Context;

    invoke-direct {v4, v5}, Landroid/widget/TextView;-><init>(Landroid/content/Context;)V

    iput-object v4, p0, Lcom/cyjh/elfin/customview/TitleView;->tvTitle:Landroid/widget/TextView;

    .line 53
    iget-object v4, p0, Lcom/cyjh/elfin/customview/TitleView;->tvTitle:Landroid/widget/TextView;

    const/4 v5, -0x1

    invoke-virtual {v4, v5}, Landroid/widget/TextView;->setTextColor(I)V

    .line 54
    iget-object v4, p0, Lcom/cyjh/elfin/customview/TitleView;->tvTitle:Landroid/widget/TextView;

    const/high16 v5, 0x41900000    # 18.0f

    invoke-virtual {v4, v5}, Landroid/widget/TextView;->setTextSize(F)V

    .line 55
    iget-object v4, p0, Lcom/cyjh/elfin/customview/TitleView;->tvTitle:Landroid/widget/TextView;

    const/16 v5, 0x10

    invoke-virtual {v4, v5}, Landroid/widget/TextView;->setGravity(I)V

    .line 56
    iget-object v4, p0, Lcom/cyjh/elfin/customview/TitleView;->tvTitle:Landroid/widget/TextView;

    invoke-virtual {v4}, Landroid/widget/TextView;->setSingleLine()V

    .line 57
    iget-object v4, p0, Lcom/cyjh/elfin/customview/TitleView;->tvTitle:Landroid/widget/TextView;

    invoke-virtual {p0, v4, v2}, Lcom/cyjh/elfin/customview/TitleView;->addView(Landroid/view/View;Landroid/view/ViewGroup$LayoutParams;)V

    .line 60
    new-instance v0, Landroid/widget/RelativeLayout$LayoutParams;

    invoke-direct {v0, v7, v7}, Landroid/widget/RelativeLayout$LayoutParams;-><init>(II)V

    .line 61
    .local v0, "imgLeftParams":Landroid/widget/RelativeLayout$LayoutParams;
    new-instance v4, Landroid/widget/ImageView;

    iget-object v5, p0, Lcom/cyjh/elfin/customview/TitleView;->mContext:Landroid/content/Context;

    invoke-direct {v4, v5}, Landroid/widget/ImageView;-><init>(Landroid/content/Context;)V

    iput-object v4, p0, Lcom/cyjh/elfin/customview/TitleView;->imgLeft:Landroid/widget/ImageView;

    .line 62
    invoke-virtual {v0, v10}, Landroid/widget/RelativeLayout$LayoutParams;->addRule(I)V

    .line 63
    const/16 v4, 0x9

    invoke-virtual {v0, v4}, Landroid/widget/RelativeLayout$LayoutParams;->addRule(I)V

    .line 64
    invoke-virtual {v0, v11, v8, v9, v8}, Landroid/widget/RelativeLayout$LayoutParams;->setMargins(IIII)V

    .line 65
    iget-object v4, p0, Lcom/cyjh/elfin/customview/TitleView;->imgLeft:Landroid/widget/ImageView;

    const v5, 0x7f02009f

    invoke-virtual {v4, v5}, Landroid/widget/ImageView;->setImageResource(I)V

    .line 66
    iget-object v4, p0, Lcom/cyjh/elfin/customview/TitleView;->imgLeft:Landroid/widget/ImageView;

    new-instance v5, Lcom/cyjh/elfin/customview/TitleView$onLeftImageViewClickListener;

    const/4 v6, 0x0

    invoke-direct {v5, p0, v6}, Lcom/cyjh/elfin/customview/TitleView$onLeftImageViewClickListener;-><init>(Lcom/cyjh/elfin/customview/TitleView;Lcom/cyjh/elfin/customview/TitleView$1;)V

    invoke-virtual {v4, v5}, Landroid/widget/ImageView;->setOnClickListener(Landroid/view/View$OnClickListener;)V

    .line 67
    iget-object v4, p0, Lcom/cyjh/elfin/customview/TitleView;->imgLeft:Landroid/widget/ImageView;

    invoke-virtual {p0, v4, v0}, Lcom/cyjh/elfin/customview/TitleView;->addView(Landroid/view/View;Landroid/view/ViewGroup$LayoutParams;)V

    .line 70
    new-instance v1, Landroid/widget/RelativeLayout$LayoutParams;

    invoke-direct {v1, v7, v7}, Landroid/widget/RelativeLayout$LayoutParams;-><init>(II)V

    .line 71
    .local v1, "imgRightParams":Landroid/widget/RelativeLayout$LayoutParams;
    invoke-virtual {v1, v10}, Landroid/widget/RelativeLayout$LayoutParams;->addRule(I)V

    .line 72
    const/16 v4, 0xb

    invoke-virtual {v1, v4}, Landroid/widget/RelativeLayout$LayoutParams;->addRule(I)V

    .line 73
    invoke-virtual {v1, v9, v8, v11, v8}, Landroid/widget/RelativeLayout$LayoutParams;->setMargins(IIII)V

    .line 74
    new-instance v4, Landroid/widget/ImageView;

    iget-object v5, p0, Lcom/cyjh/elfin/customview/TitleView;->mContext:Landroid/content/Context;

    invoke-direct {v4, v5}, Landroid/widget/ImageView;-><init>(Landroid/content/Context;)V

    iput-object v4, p0, Lcom/cyjh/elfin/customview/TitleView;->imgRight:Landroid/widget/ImageView;

    .line 75
    iget-object v4, p0, Lcom/cyjh/elfin/customview/TitleView;->imgRight:Landroid/widget/ImageView;

    const v5, 0x7f02009f

    invoke-virtual {v4, v5}, Landroid/widget/ImageView;->setImageResource(I)V

    .line 76
    iget-object v4, p0, Lcom/cyjh/elfin/customview/TitleView;->imgRight:Landroid/widget/ImageView;

    new-instance v5, Lcom/cyjh/elfin/customview/TitleView$onRightImageViewClickListener;

    const/4 v6, 0x0

    invoke-direct {v5, p0, v6}, Lcom/cyjh/elfin/customview/TitleView$onRightImageViewClickListener;-><init>(Lcom/cyjh/elfin/customview/TitleView;Lcom/cyjh/elfin/customview/TitleView$1;)V

    invoke-virtual {v4, v5}, Landroid/widget/ImageView;->setOnClickListener(Landroid/view/View$OnClickListener;)V

    .line 77
    iget-object v4, p0, Lcom/cyjh/elfin/customview/TitleView;->imgRight:Landroid/widget/ImageView;

    invoke-virtual {p0, v4, v1}, Lcom/cyjh/elfin/customview/TitleView;->addView(Landroid/view/View;Landroid/view/ViewGroup$LayoutParams;)V

    .line 80
    new-instance v3, Landroid/widget/RelativeLayout$LayoutParams;

    invoke-direct {v3, v7, v7}, Landroid/widget/RelativeLayout$LayoutParams;-><init>(II)V

    .line 81
    .local v3, "tvRightParams":Landroid/widget/RelativeLayout$LayoutParams;
    const/16 v4, 0xb

    invoke-virtual {v3, v4}, Landroid/widget/RelativeLayout$LayoutParams;->addRule(I)V

    .line 82
    invoke-virtual {v3, v10}, Landroid/widget/RelativeLayout$LayoutParams;->addRule(I)V

    .line 83
    invoke-virtual {v3, v9, v8, v11, v8}, Landroid/widget/RelativeLayout$LayoutParams;->setMargins(IIII)V

    .line 84
    new-instance v4, Landroid/widget/TextView;

    iget-object v5, p0, Lcom/cyjh/elfin/customview/TitleView;->mContext:Landroid/content/Context;

    invoke-direct {v4, v5}, Landroid/widget/TextView;-><init>(Landroid/content/Context;)V

    iput-object v4, p0, Lcom/cyjh/elfin/customview/TitleView;->mRightTextView:Landroid/widget/TextView;

    .line 85
    iget-object v4, p0, Lcom/cyjh/elfin/customview/TitleView;->mRightTextView:Landroid/widget/TextView;

    const/16 v5, 0x8

    invoke-virtual {v4, v5}, Landroid/widget/TextView;->setVisibility(I)V

    .line 86
    iget-object v4, p0, Lcom/cyjh/elfin/customview/TitleView;->mRightTextView:Landroid/widget/TextView;

    new-instance v5, Lcom/cyjh/elfin/customview/TitleView$OnRightTextViewOnClickerListener;

    const/4 v6, 0x0

    invoke-direct {v5, p0, v6}, Lcom/cyjh/elfin/customview/TitleView$OnRightTextViewOnClickerListener;-><init>(Lcom/cyjh/elfin/customview/TitleView;Lcom/cyjh/elfin/customview/TitleView$1;)V

    invoke-virtual {v4, v5}, Landroid/widget/TextView;->setOnClickListener(Landroid/view/View$OnClickListener;)V

    .line 87
    iget-object v4, p0, Lcom/cyjh/elfin/customview/TitleView;->mRightTextView:Landroid/widget/TextView;

    invoke-virtual {v4}, Landroid/widget/TextView;->setSingleLine()V

    .line 88
    iget-object v4, p0, Lcom/cyjh/elfin/customview/TitleView;->mRightTextView:Landroid/widget/TextView;

    const/high16 v5, 0x41800000    # 16.0f

    invoke-virtual {v4, v5}, Landroid/widget/TextView;->setTextSize(F)V

    .line 89
    iget-object v4, p0, Lcom/cyjh/elfin/customview/TitleView;->mRightTextView:Landroid/widget/TextView;

    const/4 v5, -0x1

    invoke-virtual {v4, v5}, Landroid/widget/TextView;->setTextColor(I)V

    .line 90
    iget-object v4, p0, Lcom/cyjh/elfin/customview/TitleView;->mRightTextView:Landroid/widget/TextView;

    invoke-virtual {p0, v4, v3}, Lcom/cyjh/elfin/customview/TitleView;->addView(Landroid/view/View;Landroid/view/ViewGroup$LayoutParams;)V

    .line 91
    return-void
.end method


# virtual methods
.method public setOnLeftImageViewListener(Lcom/cyjh/elfin/customview/TitleView$OnLeftImageViewListener;)V
    .locals 0
    .param p1, "onLeftImageViewListener"    # Lcom/cyjh/elfin/customview/TitleView$OnLeftImageViewListener;

    .prologue
    .line 152
    iput-object p1, p0, Lcom/cyjh/elfin/customview/TitleView;->onLeftImgeViewListener:Lcom/cyjh/elfin/customview/TitleView$OnLeftImageViewListener;

    .line 153
    return-void
.end method

.method public setOnRightImageViewListener(Lcom/cyjh/elfin/customview/TitleView$OnRightImageViewListener;)V
    .locals 0
    .param p1, "onRightImageViewListener"    # Lcom/cyjh/elfin/customview/TitleView$OnRightImageViewListener;

    .prologue
    .line 156
    iput-object p1, p0, Lcom/cyjh/elfin/customview/TitleView;->onRightImageViewListener:Lcom/cyjh/elfin/customview/TitleView$OnRightImageViewListener;

    .line 157
    return-void
.end method

.method public setOnRightTextViewListener(Lcom/cyjh/elfin/customview/TitleView$OnRightTextViewListener;)V
    .locals 0
    .param p1, "onRightTextViewListener"    # Lcom/cyjh/elfin/customview/TitleView$OnRightTextViewListener;

    .prologue
    .line 160
    iput-object p1, p0, Lcom/cyjh/elfin/customview/TitleView;->onRightTextViewListener:Lcom/cyjh/elfin/customview/TitleView$OnRightTextViewListener;

    .line 161
    return-void
.end method

.method public setRightImage(I)V
    .locals 1
    .param p1, "resId"    # I

    .prologue
    .line 113
    iget-object v0, p0, Lcom/cyjh/elfin/customview/TitleView;->imgRight:Landroid/widget/ImageView;

    invoke-virtual {v0, p1}, Landroid/widget/ImageView;->setImageResource(I)V

    .line 114
    return-void
.end method

.method public setRightTvText(I)V
    .locals 1
    .param p1, "resId"    # I

    .prologue
    .line 124
    iget-object v0, p0, Lcom/cyjh/elfin/customview/TitleView;->mRightTextView:Landroid/widget/TextView;

    invoke-virtual {v0, p1}, Landroid/widget/TextView;->setText(I)V

    .line 125
    return-void
.end method

.method public setRightTvText(Ljava/lang/String;)V
    .locals 1
    .param p1, "text"    # Ljava/lang/String;

    .prologue
    .line 127
    iget-object v0, p0, Lcom/cyjh/elfin/customview/TitleView;->mRightTextView:Landroid/widget/TextView;

    invoke-virtual {v0, p1}, Landroid/widget/TextView;->setText(Ljava/lang/CharSequence;)V

    .line 128
    return-void
.end method

.method public setTitleSize(I)V
    .locals 2
    .param p1, "size"    # I

    .prologue
    .line 117
    iget-object v0, p0, Lcom/cyjh/elfin/customview/TitleView;->tvTitle:Landroid/widget/TextView;

    int-to-float v1, p1

    invoke-virtual {v0, v1}, Landroid/widget/TextView;->setTextSize(F)V

    .line 118
    return-void
.end method

.method public setTitleText(I)V
    .locals 1
    .param p1, "resid"    # I

    .prologue
    .line 97
    iget-object v0, p0, Lcom/cyjh/elfin/customview/TitleView;->tvTitle:Landroid/widget/TextView;

    invoke-virtual {v0, p1}, Landroid/widget/TextView;->setText(I)V

    .line 98
    return-void
.end method

.method public setTitleText(Ljava/lang/String;)V
    .locals 1
    .param p1, "text"    # Ljava/lang/String;

    .prologue
    .line 93
    iget-object v0, p0, Lcom/cyjh/elfin/customview/TitleView;->tvTitle:Landroid/widget/TextView;

    invoke-virtual {v0, p1}, Landroid/widget/TextView;->setText(Ljava/lang/CharSequence;)V

    .line 94
    return-void
.end method

.method public setVisibilityLeftImage(I)V
    .locals 1
    .param p1, "isVisibility"    # I

    .prologue
    .line 105
    iget-object v0, p0, Lcom/cyjh/elfin/customview/TitleView;->imgLeft:Landroid/widget/ImageView;

    invoke-virtual {v0, p1}, Landroid/widget/ImageView;->setVisibility(I)V

    .line 106
    return-void
.end method

.method public setVisibilityRightImage(I)V
    .locals 1
    .param p1, "isVisibility"    # I

    .prologue
    .line 101
    iget-object v0, p0, Lcom/cyjh/elfin/customview/TitleView;->imgRight:Landroid/widget/ImageView;

    invoke-virtual {v0, p1}, Landroid/widget/ImageView;->setVisibility(I)V

    .line 102
    return-void
.end method

.method public setVisibilityTvRight(I)V
    .locals 1
    .param p1, "isVisibility"    # I

    .prologue
    .line 121
    iget-object v0, p0, Lcom/cyjh/elfin/customview/TitleView;->mRightTextView:Landroid/widget/TextView;

    invoke-virtual {v0, p1}, Landroid/widget/TextView;->setVisibility(I)V

    .line 122
    return-void
.end method

.method public setleftImage(I)V
    .locals 1
    .param p1, "resId"    # I

    .prologue
    .line 109
    iget-object v0, p0, Lcom/cyjh/elfin/customview/TitleView;->imgLeft:Landroid/widget/ImageView;

    invoke-virtual {v0, p1}, Landroid/widget/ImageView;->setImageResource(I)V

    .line 110
    return-void
.end method
