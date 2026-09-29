.class public Lcn/bingoogolapple/androidcommon/adapter/BGARecyclerViewHolder;
.super Landroid/support/v7/widget/RecyclerView$ViewHolder;
.source "BGARecyclerViewHolder.java"

# interfaces
.implements Landroid/view/View$OnClickListener;
.implements Landroid/view/View$OnLongClickListener;


# instance fields
.field protected mContext:Landroid/content/Context;

.field protected mOnRVItemClickListener:Lcn/bingoogolapple/androidcommon/adapter/BGAOnRVItemClickListener;

.field protected mOnRVItemLongClickListener:Lcn/bingoogolapple/androidcommon/adapter/BGAOnRVItemLongClickListener;

.field protected mRecyclerView:Landroid/support/v7/widget/RecyclerView;

.field protected mViewHolderHelper:Lcn/bingoogolapple/androidcommon/adapter/BGAViewHolderHelper;


# direct methods
.method public constructor <init>(Landroid/support/v7/widget/RecyclerView;Landroid/view/View;Lcn/bingoogolapple/androidcommon/adapter/BGAOnRVItemClickListener;Lcn/bingoogolapple/androidcommon/adapter/BGAOnRVItemLongClickListener;)V
    .locals 3
    .param p1, "recyclerView"    # Landroid/support/v7/widget/RecyclerView;
    .param p2, "itemView"    # Landroid/view/View;
    .param p3, "onRVItemClickListener"    # Lcn/bingoogolapple/androidcommon/adapter/BGAOnRVItemClickListener;
    .param p4, "onRVItemLongClickListener"    # Lcn/bingoogolapple/androidcommon/adapter/BGAOnRVItemLongClickListener;

    .prologue
    .line 36
    invoke-direct {p0, p2}, Landroid/support/v7/widget/RecyclerView$ViewHolder;-><init>(Landroid/view/View;)V

    .line 37
    iput-object p1, p0, Lcn/bingoogolapple/androidcommon/adapter/BGARecyclerViewHolder;->mRecyclerView:Landroid/support/v7/widget/RecyclerView;

    .line 38
    iget-object v0, p0, Lcn/bingoogolapple/androidcommon/adapter/BGARecyclerViewHolder;->mRecyclerView:Landroid/support/v7/widget/RecyclerView;

    invoke-virtual {v0}, Landroid/support/v7/widget/RecyclerView;->getContext()Landroid/content/Context;

    move-result-object v0

    iput-object v0, p0, Lcn/bingoogolapple/androidcommon/adapter/BGARecyclerViewHolder;->mContext:Landroid/content/Context;

    .line 39
    iput-object p3, p0, Lcn/bingoogolapple/androidcommon/adapter/BGARecyclerViewHolder;->mOnRVItemClickListener:Lcn/bingoogolapple/androidcommon/adapter/BGAOnRVItemClickListener;

    .line 40
    iput-object p4, p0, Lcn/bingoogolapple/androidcommon/adapter/BGARecyclerViewHolder;->mOnRVItemLongClickListener:Lcn/bingoogolapple/androidcommon/adapter/BGAOnRVItemLongClickListener;

    .line 41
    invoke-virtual {p2, p0}, Landroid/view/View;->setOnClickListener(Landroid/view/View$OnClickListener;)V

    .line 42
    invoke-virtual {p2, p0}, Landroid/view/View;->setOnLongClickListener(Landroid/view/View$OnLongClickListener;)V

    .line 43
    new-instance v0, Lcn/bingoogolapple/androidcommon/adapter/BGAViewHolderHelper;

    iget-object v1, p0, Lcn/bingoogolapple/androidcommon/adapter/BGARecyclerViewHolder;->mRecyclerView:Landroid/support/v7/widget/RecyclerView;

    iget-object v2, p0, Lcn/bingoogolapple/androidcommon/adapter/BGARecyclerViewHolder;->itemView:Landroid/view/View;

    invoke-direct {v0, v1, v2}, Lcn/bingoogolapple/androidcommon/adapter/BGAViewHolderHelper;-><init>(Landroid/support/v7/widget/RecyclerView;Landroid/view/View;)V

    iput-object v0, p0, Lcn/bingoogolapple/androidcommon/adapter/BGARecyclerViewHolder;->mViewHolderHelper:Lcn/bingoogolapple/androidcommon/adapter/BGAViewHolderHelper;

    .line 44
    iget-object v0, p0, Lcn/bingoogolapple/androidcommon/adapter/BGARecyclerViewHolder;->mViewHolderHelper:Lcn/bingoogolapple/androidcommon/adapter/BGAViewHolderHelper;

    invoke-virtual {v0, p0}, Lcn/bingoogolapple/androidcommon/adapter/BGAViewHolderHelper;->setRecyclerViewHolder(Lcn/bingoogolapple/androidcommon/adapter/BGARecyclerViewHolder;)V

    .line 45
    return-void
.end method


# virtual methods
.method public getViewHolderHelper()Lcn/bingoogolapple/androidcommon/adapter/BGAViewHolderHelper;
    .locals 1

    .prologue
    .line 48
    iget-object v0, p0, Lcn/bingoogolapple/androidcommon/adapter/BGARecyclerViewHolder;->mViewHolderHelper:Lcn/bingoogolapple/androidcommon/adapter/BGAViewHolderHelper;

    return-object v0
.end method

.method public onClick(Landroid/view/View;)V
    .locals 3
    .param p1, "v"    # Landroid/view/View;

    .prologue
    .line 53
    invoke-virtual {p1}, Landroid/view/View;->getId()I

    move-result v0

    iget-object v1, p0, Lcn/bingoogolapple/androidcommon/adapter/BGARecyclerViewHolder;->itemView:Landroid/view/View;

    invoke-virtual {v1}, Landroid/view/View;->getId()I

    move-result v1

    if-ne v0, v1, :cond_0

    iget-object v0, p0, Lcn/bingoogolapple/androidcommon/adapter/BGARecyclerViewHolder;->mOnRVItemClickListener:Lcn/bingoogolapple/androidcommon/adapter/BGAOnRVItemClickListener;

    if-eqz v0, :cond_0

    .line 54
    iget-object v0, p0, Lcn/bingoogolapple/androidcommon/adapter/BGARecyclerViewHolder;->mOnRVItemClickListener:Lcn/bingoogolapple/androidcommon/adapter/BGAOnRVItemClickListener;

    iget-object v1, p0, Lcn/bingoogolapple/androidcommon/adapter/BGARecyclerViewHolder;->mRecyclerView:Landroid/support/v7/widget/RecyclerView;

    invoke-virtual {p0}, Lcn/bingoogolapple/androidcommon/adapter/BGARecyclerViewHolder;->getAdapterPosition()I

    move-result v2

    invoke-interface {v0, v1, p1, v2}, Lcn/bingoogolapple/androidcommon/adapter/BGAOnRVItemClickListener;->onRVItemClick(Landroid/view/ViewGroup;Landroid/view/View;I)V

    .line 56
    :cond_0
    return-void
.end method

.method public onLongClick(Landroid/view/View;)Z
    .locals 3
    .param p1, "v"    # Landroid/view/View;

    .prologue
    .line 60
    invoke-virtual {p1}, Landroid/view/View;->getId()I

    move-result v0

    iget-object v1, p0, Lcn/bingoogolapple/androidcommon/adapter/BGARecyclerViewHolder;->itemView:Landroid/view/View;

    invoke-virtual {v1}, Landroid/view/View;->getId()I

    move-result v1

    if-ne v0, v1, :cond_0

    iget-object v0, p0, Lcn/bingoogolapple/androidcommon/adapter/BGARecyclerViewHolder;->mOnRVItemLongClickListener:Lcn/bingoogolapple/androidcommon/adapter/BGAOnRVItemLongClickListener;

    if-eqz v0, :cond_0

    .line 61
    iget-object v0, p0, Lcn/bingoogolapple/androidcommon/adapter/BGARecyclerViewHolder;->mOnRVItemLongClickListener:Lcn/bingoogolapple/androidcommon/adapter/BGAOnRVItemLongClickListener;

    iget-object v1, p0, Lcn/bingoogolapple/androidcommon/adapter/BGARecyclerViewHolder;->mRecyclerView:Landroid/support/v7/widget/RecyclerView;

    invoke-virtual {p0}, Lcn/bingoogolapple/androidcommon/adapter/BGARecyclerViewHolder;->getAdapterPosition()I

    move-result v2

    invoke-interface {v0, v1, p1, v2}, Lcn/bingoogolapple/androidcommon/adapter/BGAOnRVItemLongClickListener;->onRVItemLongClick(Landroid/view/ViewGroup;Landroid/view/View;I)Z

    move-result v0

    .line 63
    :goto_0
    return v0

    :cond_0
    const/4 v0, 0x0

    goto :goto_0
.end method
