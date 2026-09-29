.class public Lcom/cyjh/elfin/customview/loadstate/LoadstatueViewFactory;
.super Ljava/lang/Object;
.source "LoadstatueViewFactory.java"


# direct methods
.method public constructor <init>()V
    .locals 0

    .prologue
    .line 17
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method

.method private static addView(Landroid/view/View;Landroid/view/View;)V
    .locals 5
    .param p0, "view"    # Landroid/view/View;
    .param p1, "contentView"    # Landroid/view/View;

    .prologue
    const/4 v4, -0x1

    .line 21
    invoke-virtual {p1}, Landroid/view/View;->getParent()Landroid/view/ViewParent;

    move-result-object v2

    check-cast v2, Landroid/view/View;

    .line 22
    .local v2, "parentView":Landroid/view/View;
    if-eqz v2, :cond_0

    .line 24
    instance-of v3, v2, Landroid/widget/RelativeLayout;

    if-eqz v3, :cond_1

    move-object v1, v2

    .line 25
    check-cast v1, Landroid/widget/RelativeLayout;

    .line 26
    .local v1, "parent":Landroid/widget/RelativeLayout;
    invoke-virtual {v1, p0}, Landroid/widget/RelativeLayout;->addView(Landroid/view/View;)V

    .line 27
    new-instance v0, Landroid/widget/RelativeLayout$LayoutParams;

    invoke-virtual {p0}, Landroid/view/View;->getLayoutParams()Landroid/view/ViewGroup$LayoutParams;

    move-result-object v3

    invoke-direct {v0, v3}, Landroid/widget/RelativeLayout$LayoutParams;-><init>(Landroid/view/ViewGroup$LayoutParams;)V

    .line 28
    .local v0, "l":Landroid/widget/RelativeLayout$LayoutParams;
    const/16 v3, 0xd

    invoke-virtual {v0, v3, v4}, Landroid/widget/RelativeLayout$LayoutParams;->addRule(II)V

    .line 29
    iput v4, v0, Landroid/widget/RelativeLayout$LayoutParams;->width:I

    .line 30
    iput v4, v0, Landroid/widget/RelativeLayout$LayoutParams;->height:I

    .line 31
    invoke-virtual {p0, v0}, Landroid/view/View;->setLayoutParams(Landroid/view/ViewGroup$LayoutParams;)V

    .line 44
    .end local v0    # "l":Landroid/widget/RelativeLayout$LayoutParams;
    .end local v1    # "parent":Landroid/widget/RelativeLayout;
    :cond_0
    :goto_0
    return-void

    .line 32
    :cond_1
    instance-of v3, v2, Landroid/widget/LinearLayout;

    if-eqz v3, :cond_2

    move-object v1, v2

    .line 33
    check-cast v1, Landroid/widget/LinearLayout;

    .line 34
    .local v1, "parent":Landroid/widget/LinearLayout;
    invoke-virtual {v1, p0}, Landroid/widget/LinearLayout;->addView(Landroid/view/View;)V

    .line 35
    new-instance v0, Landroid/widget/LinearLayout$LayoutParams;

    invoke-virtual {p0}, Landroid/view/View;->getLayoutParams()Landroid/view/ViewGroup$LayoutParams;

    move-result-object v3

    invoke-direct {v0, v3}, Landroid/widget/LinearLayout$LayoutParams;-><init>(Landroid/view/ViewGroup$LayoutParams;)V

    .line 36
    .local v0, "l":Landroid/widget/LinearLayout$LayoutParams;
    iput v4, v0, Landroid/widget/LinearLayout$LayoutParams;->width:I

    .line 37
    iput v4, v0, Landroid/widget/LinearLayout$LayoutParams;->height:I

    .line 38
    const/16 v3, 0x11

    iput v3, v0, Landroid/widget/LinearLayout$LayoutParams;->gravity:I

    .line 39
    invoke-virtual {p0, v0}, Landroid/view/View;->setLayoutParams(Landroid/view/ViewGroup$LayoutParams;)V

    goto :goto_0

    .line 41
    .end local v0    # "l":Landroid/widget/LinearLayout$LayoutParams;
    .end local v1    # "parent":Landroid/widget/LinearLayout;
    :cond_2
    new-instance v3, Ljava/lang/IllegalArgumentException;

    const-string v4, "ParentView must be a RelativeLayout or LinearLayout!!!"

    invoke-direct {v3, v4}, Ljava/lang/IllegalArgumentException;-><init>(Ljava/lang/String;)V

    throw v3
.end method

.method public static getLoadEmpty(Landroid/content/Context;Landroid/view/View;Landroid/view/View$OnClickListener;)Landroid/view/View;
    .locals 3
    .param p0, "context"    # Landroid/content/Context;
    .param p1, "contentView"    # Landroid/view/View;
    .param p2, "ocl"    # Landroid/view/View$OnClickListener;

    .prologue
    .line 69
    new-instance v1, Lcom/cyjh/elfin/customview/FindErrorView;

    invoke-direct {v1, p0}, Lcom/cyjh/elfin/customview/FindErrorView;-><init>(Landroid/content/Context;)V

    .line 70
    .local v1, "view":Lcom/cyjh/elfin/customview/FindErrorView;
    const v2, 0x7f0200a5

    invoke-virtual {v1, v2}, Lcom/cyjh/elfin/customview/FindErrorView;->setErrorImg(I)V

    .line 71
    const v2, 0x7f080091

    invoke-virtual {v1, v2}, Lcom/cyjh/elfin/customview/FindErrorView;->setErrorTips(I)V

    .line 72
    const v2, 0x7f0f0180

    .line 73
    invoke-virtual {v1, v2}, Lcom/cyjh/elfin/customview/FindErrorView;->findViewById(I)Landroid/view/View;

    move-result-object v0

    check-cast v0, Landroid/widget/TextView;

    .line 74
    .local v0, "textView":Landroid/widget/TextView;
    invoke-virtual {v0, p2}, Landroid/widget/TextView;->setOnClickListener(Landroid/view/View$OnClickListener;)V

    .line 75
    const/16 v2, 0x8

    invoke-virtual {v1, v2}, Lcom/cyjh/elfin/customview/FindErrorView;->setVisibility(I)V

    .line 76
    invoke-static {v1, p1}, Lcom/cyjh/elfin/customview/loadstate/LoadstatueViewFactory;->addView(Landroid/view/View;Landroid/view/View;)V

    .line 77
    return-object v1
.end method

.method public static getLoadFailed(Landroid/content/Context;Landroid/view/View;Landroid/view/View$OnClickListener;)Landroid/view/View;
    .locals 3
    .param p0, "context"    # Landroid/content/Context;
    .param p1, "contentView"    # Landroid/view/View;
    .param p2, "ocl"    # Landroid/view/View$OnClickListener;

    .prologue
    .line 98
    new-instance v1, Lcom/cyjh/elfin/customview/FindErrorView;

    invoke-direct {v1, p0}, Lcom/cyjh/elfin/customview/FindErrorView;-><init>(Landroid/content/Context;)V

    .line 99
    .local v1, "view":Lcom/cyjh/elfin/customview/FindErrorView;
    const v2, 0x7f0200a3

    invoke-virtual {v1, v2}, Lcom/cyjh/elfin/customview/FindErrorView;->setErrorImg(I)V

    .line 100
    const v2, 0x7f080092

    invoke-virtual {v1, v2}, Lcom/cyjh/elfin/customview/FindErrorView;->setErrorTips(I)V

    .line 101
    const v2, 0x7f0f0180

    .line 102
    invoke-virtual {v1, v2}, Lcom/cyjh/elfin/customview/FindErrorView;->findViewById(I)Landroid/view/View;

    move-result-object v0

    check-cast v0, Landroid/widget/TextView;

    .line 103
    .local v0, "textView":Landroid/widget/TextView;
    invoke-virtual {v0, p2}, Landroid/widget/TextView;->setOnClickListener(Landroid/view/View$OnClickListener;)V

    .line 104
    const/16 v2, 0x8

    invoke-virtual {v1, v2}, Lcom/cyjh/elfin/customview/FindErrorView;->setVisibility(I)V

    .line 105
    invoke-static {v1, p1}, Lcom/cyjh/elfin/customview/loadstate/LoadstatueViewFactory;->addView(Landroid/view/View;Landroid/view/View;)V

    .line 106
    return-object v1
.end method

.method public static getLoadNetInstability(Landroid/content/Context;Landroid/view/View;Landroid/view/View$OnClickListener;)Landroid/view/View;
    .locals 2
    .param p0, "context"    # Landroid/content/Context;
    .param p1, "contentView"    # Landroid/view/View;
    .param p2, "ocl"    # Landroid/view/View$OnClickListener;

    .prologue
    .line 113
    new-instance v0, Lcom/cyjh/elfin/customview/FindErrorView;

    invoke-direct {v0, p0}, Lcom/cyjh/elfin/customview/FindErrorView;-><init>(Landroid/content/Context;)V

    .line 117
    .local v0, "view":Landroid/view/View;
    const/16 v1, 0x8

    invoke-virtual {v0, v1}, Landroid/view/View;->setVisibility(I)V

    .line 118
    invoke-static {v0, p1}, Lcom/cyjh/elfin/customview/loadstate/LoadstatueViewFactory;->addView(Landroid/view/View;Landroid/view/View;)V

    .line 119
    return-object v0
.end method

.method public static getLoadNotNetwork(Landroid/content/Context;Landroid/view/View;Landroid/view/View$OnClickListener;)Landroid/view/View;
    .locals 3
    .param p0, "context"    # Landroid/content/Context;
    .param p1, "contentView"    # Landroid/view/View;
    .param p2, "ocl"    # Landroid/view/View$OnClickListener;

    .prologue
    .line 132
    new-instance v1, Lcom/cyjh/elfin/customview/FindErrorView;

    invoke-direct {v1, p0}, Lcom/cyjh/elfin/customview/FindErrorView;-><init>(Landroid/content/Context;)V

    .line 133
    .local v1, "view":Landroid/view/View;
    const v2, 0x7f0f0180

    .line 134
    invoke-virtual {v1, v2}, Landroid/view/View;->findViewById(I)Landroid/view/View;

    move-result-object v0

    check-cast v0, Landroid/widget/TextView;

    .line 135
    .local v0, "textView":Landroid/widget/TextView;
    invoke-virtual {v0, p2}, Landroid/widget/TextView;->setOnClickListener(Landroid/view/View$OnClickListener;)V

    .line 136
    const/16 v2, 0x8

    invoke-virtual {v1, v2}, Landroid/view/View;->setVisibility(I)V

    .line 137
    invoke-static {v1, p1}, Lcom/cyjh/elfin/customview/loadstate/LoadstatueViewFactory;->addView(Landroid/view/View;Landroid/view/View;)V

    .line 138
    return-object v1
.end method

.method public static getLoadingView(Landroid/content/Context;Landroid/view/View;)Landroid/view/View;
    .locals 4
    .param p0, "context"    # Landroid/content/Context;
    .param p1, "contentView"    # Landroid/view/View;

    .prologue
    .line 54
    invoke-static {p0}, Landroid/view/LayoutInflater;->from(Landroid/content/Context;)Landroid/view/LayoutInflater;

    move-result-object v0

    .line 55
    .local v0, "inflater":Landroid/view/LayoutInflater;
    const v2, 0x7f04005d

    const/4 v3, 0x0

    invoke-virtual {v0, v2, v3}, Landroid/view/LayoutInflater;->inflate(ILandroid/view/ViewGroup;)Landroid/view/View;

    move-result-object v1

    .line 56
    .local v1, "view":Landroid/view/View;
    const/16 v2, 0x8

    invoke-virtual {v1, v2}, Landroid/view/View;->setVisibility(I)V

    .line 57
    invoke-static {v1, p1}, Lcom/cyjh/elfin/customview/loadstate/LoadstatueViewFactory;->addView(Landroid/view/View;Landroid/view/View;)V

    .line 58
    return-object v1
.end method

.method public static getScriptListEmpty(Landroid/content/Context;Landroid/view/View;)Landroid/view/View;
    .locals 3
    .param p0, "context"    # Landroid/content/Context;
    .param p1, "contentView"    # Landroid/view/View;

    .prologue
    const/16 v2, 0x8

    .line 81
    new-instance v0, Lcom/cyjh/elfin/customview/FindErrorView;

    invoke-direct {v0, p0}, Lcom/cyjh/elfin/customview/FindErrorView;-><init>(Landroid/content/Context;)V

    .line 82
    .local v0, "view":Lcom/cyjh/elfin/customview/FindErrorView;
    const v1, 0x7f020048

    invoke-virtual {v0, v1}, Lcom/cyjh/elfin/customview/FindErrorView;->setErrorImg(I)V

    .line 83
    const v1, 0x7f0800af

    invoke-virtual {v0, v1}, Lcom/cyjh/elfin/customview/FindErrorView;->setErrorTips(I)V

    .line 84
    const v1, 0x7f0f0180

    invoke-virtual {v0, v1}, Lcom/cyjh/elfin/customview/FindErrorView;->findViewById(I)Landroid/view/View;

    move-result-object v1

    invoke-virtual {v1, v2}, Landroid/view/View;->setVisibility(I)V

    .line 85
    invoke-virtual {v0, v2}, Lcom/cyjh/elfin/customview/FindErrorView;->setVisibility(I)V

    .line 86
    invoke-static {v0, p1}, Lcom/cyjh/elfin/customview/loadstate/LoadstatueViewFactory;->addView(Landroid/view/View;Landroid/view/View;)V

    .line 87
    return-object v0
.end method

.method private static getView(Landroid/content/Context;)Landroid/view/View;
    .locals 3
    .param p0, "context"    # Landroid/content/Context;

    .prologue
    .line 148
    invoke-static {p0}, Landroid/view/LayoutInflater;->from(Landroid/content/Context;)Landroid/view/LayoutInflater;

    move-result-object v0

    .line 149
    .local v0, "inflater":Landroid/view/LayoutInflater;
    const v1, 0x7f04005c

    const/4 v2, 0x0

    invoke-virtual {v0, v1, v2}, Landroid/view/LayoutInflater;->inflate(ILandroid/view/ViewGroup;)Landroid/view/View;

    move-result-object v1

    return-object v1
.end method
