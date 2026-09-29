.class public Lcn/bingoogolapple/androidcommon/adapter/BGAAdapterViewHolder;
.super Ljava/lang/Object;
.source "BGAAdapterViewHolder.java"


# instance fields
.field protected mConvertView:Landroid/view/View;

.field protected mViewHolderHelper:Lcn/bingoogolapple/androidcommon/adapter/BGAViewHolderHelper;


# direct methods
.method private constructor <init>(Landroid/view/ViewGroup;I)V
    .locals 2
    .param p1, "parent"    # Landroid/view/ViewGroup;
    .param p2, "layoutId"    # I

    .prologue
    .line 32
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    .line 33
    invoke-virtual {p1}, Landroid/view/ViewGroup;->getContext()Landroid/content/Context;

    move-result-object v0

    invoke-static {v0}, Landroid/view/LayoutInflater;->from(Landroid/content/Context;)Landroid/view/LayoutInflater;

    move-result-object v0

    const/4 v1, 0x0

    invoke-virtual {v0, p2, p1, v1}, Landroid/view/LayoutInflater;->inflate(ILandroid/view/ViewGroup;Z)Landroid/view/View;

    move-result-object v0

    iput-object v0, p0, Lcn/bingoogolapple/androidcommon/adapter/BGAAdapterViewHolder;->mConvertView:Landroid/view/View;

    .line 34
    iget-object v0, p0, Lcn/bingoogolapple/androidcommon/adapter/BGAAdapterViewHolder;->mConvertView:Landroid/view/View;

    invoke-virtual {v0, p0}, Landroid/view/View;->setTag(Ljava/lang/Object;)V

    .line 35
    new-instance v0, Lcn/bingoogolapple/androidcommon/adapter/BGAViewHolderHelper;

    iget-object v1, p0, Lcn/bingoogolapple/androidcommon/adapter/BGAAdapterViewHolder;->mConvertView:Landroid/view/View;

    invoke-direct {v0, p1, v1}, Lcn/bingoogolapple/androidcommon/adapter/BGAViewHolderHelper;-><init>(Landroid/view/ViewGroup;Landroid/view/View;)V

    iput-object v0, p0, Lcn/bingoogolapple/androidcommon/adapter/BGAAdapterViewHolder;->mViewHolderHelper:Lcn/bingoogolapple/androidcommon/adapter/BGAViewHolderHelper;

    .line 36
    return-void
.end method

.method public static dequeueReusableAdapterViewHolder(Landroid/view/View;Landroid/view/ViewGroup;I)Lcn/bingoogolapple/androidcommon/adapter/BGAAdapterViewHolder;
    .locals 1
    .param p0, "convertView"    # Landroid/view/View;
    .param p1, "parent"    # Landroid/view/ViewGroup;
    .param p2, "layoutId"    # I

    .prologue
    .line 47
    if-nez p0, :cond_0

    .line 48
    new-instance v0, Lcn/bingoogolapple/androidcommon/adapter/BGAAdapterViewHolder;

    invoke-direct {v0, p1, p2}, Lcn/bingoogolapple/androidcommon/adapter/BGAAdapterViewHolder;-><init>(Landroid/view/ViewGroup;I)V

    .line 50
    :goto_0
    return-object v0

    :cond_0
    invoke-virtual {p0}, Landroid/view/View;->getTag()Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Lcn/bingoogolapple/androidcommon/adapter/BGAAdapterViewHolder;

    goto :goto_0
.end method


# virtual methods
.method public getConvertView()Landroid/view/View;
    .locals 1

    .prologue
    .line 58
    iget-object v0, p0, Lcn/bingoogolapple/androidcommon/adapter/BGAAdapterViewHolder;->mConvertView:Landroid/view/View;

    return-object v0
.end method

.method public getViewHolderHelper()Lcn/bingoogolapple/androidcommon/adapter/BGAViewHolderHelper;
    .locals 1

    .prologue
    .line 54
    iget-object v0, p0, Lcn/bingoogolapple/androidcommon/adapter/BGAAdapterViewHolder;->mViewHolderHelper:Lcn/bingoogolapple/androidcommon/adapter/BGAViewHolderHelper;

    return-object v0
.end method
