.class public abstract Lcn/bingoogolapple/androidcommon/adapter/BGARecyclerViewAdapter;
.super Landroid/support/v7/widget/RecyclerView$Adapter;
.source "BGARecyclerViewAdapter.java"


# annotations
.annotation system Ldalvik/annotation/Signature;
    value = {
        "<M:",
        "Ljava/lang/Object;",
        ">",
        "Landroid/support/v7/widget/RecyclerView$Adapter",
        "<",
        "Lcn/bingoogolapple/androidcommon/adapter/BGARecyclerViewHolder;",
        ">;"
    }
.end annotation


# instance fields
.field protected mContext:Landroid/content/Context;

.field protected mDatas:Ljava/util/List;
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "Ljava/util/List",
            "<TM;>;"
        }
    .end annotation
.end field

.field protected final mItemLayoutId:I

.field protected mOnItemChildCheckedChangeListener:Lcn/bingoogolapple/androidcommon/adapter/BGAOnItemChildCheckedChangeListener;

.field protected mOnItemChildClickListener:Lcn/bingoogolapple/androidcommon/adapter/BGAOnItemChildClickListener;

.field protected mOnItemChildLongClickListener:Lcn/bingoogolapple/androidcommon/adapter/BGAOnItemChildLongClickListener;

.field protected mOnRVItemClickListener:Lcn/bingoogolapple/androidcommon/adapter/BGAOnRVItemClickListener;

.field protected mOnRVItemLongClickListener:Lcn/bingoogolapple/androidcommon/adapter/BGAOnRVItemLongClickListener;

.field protected mRecyclerView:Landroid/support/v7/widget/RecyclerView;


# direct methods
.method public constructor <init>(Landroid/support/v7/widget/RecyclerView;I)V
    .locals 1
    .param p1, "recyclerView"    # Landroid/support/v7/widget/RecyclerView;
    .param p2, "itemLayoutId"    # I

    .prologue
    .line 42
    .local p0, "this":Lcn/bingoogolapple/androidcommon/adapter/BGARecyclerViewAdapter;, "Lcn/bingoogolapple/androidcommon/adapter/BGARecyclerViewAdapter<TM;>;"
    invoke-direct {p0}, Landroid/support/v7/widget/RecyclerView$Adapter;-><init>()V

    .line 43
    iput-object p1, p0, Lcn/bingoogolapple/androidcommon/adapter/BGARecyclerViewAdapter;->mRecyclerView:Landroid/support/v7/widget/RecyclerView;

    .line 44
    iget-object v0, p0, Lcn/bingoogolapple/androidcommon/adapter/BGARecyclerViewAdapter;->mRecyclerView:Landroid/support/v7/widget/RecyclerView;

    invoke-virtual {v0}, Landroid/support/v7/widget/RecyclerView;->getContext()Landroid/content/Context;

    move-result-object v0

    iput-object v0, p0, Lcn/bingoogolapple/androidcommon/adapter/BGARecyclerViewAdapter;->mContext:Landroid/content/Context;

    .line 45
    iput p2, p0, Lcn/bingoogolapple/androidcommon/adapter/BGARecyclerViewAdapter;->mItemLayoutId:I

    .line 46
    new-instance v0, Ljava/util/ArrayList;

    invoke-direct {v0}, Ljava/util/ArrayList;-><init>()V

    iput-object v0, p0, Lcn/bingoogolapple/androidcommon/adapter/BGARecyclerViewAdapter;->mDatas:Ljava/util/List;

    .line 47
    return-void
.end method


# virtual methods
.method public addFirstItem(Ljava/lang/Object;)V
    .locals 1
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "(TM;)V"
        }
    .end annotation

    .prologue
    .line 226
    .local p0, "this":Lcn/bingoogolapple/androidcommon/adapter/BGARecyclerViewAdapter;, "Lcn/bingoogolapple/androidcommon/adapter/BGARecyclerViewAdapter<TM;>;"
    .local p1, "model":Ljava/lang/Object;, "TM;"
    const/4 v0, 0x0

    invoke-virtual {p0, v0, p1}, Lcn/bingoogolapple/androidcommon/adapter/BGARecyclerViewAdapter;->addItem(ILjava/lang/Object;)V

    .line 227
    return-void
.end method

.method public addItem(ILjava/lang/Object;)V
    .locals 1
    .param p1, "position"    # I
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "(ITM;)V"
        }
    .end annotation

    .prologue
    .line 216
    .local p0, "this":Lcn/bingoogolapple/androidcommon/adapter/BGARecyclerViewAdapter;, "Lcn/bingoogolapple/androidcommon/adapter/BGARecyclerViewAdapter<TM;>;"
    .local p2, "model":Ljava/lang/Object;, "TM;"
    iget-object v0, p0, Lcn/bingoogolapple/androidcommon/adapter/BGARecyclerViewAdapter;->mDatas:Ljava/util/List;

    invoke-interface {v0, p1, p2}, Ljava/util/List;->add(ILjava/lang/Object;)V

    .line 217
    invoke-virtual {p0, p1}, Lcn/bingoogolapple/androidcommon/adapter/BGARecyclerViewAdapter;->notifyItemInserted(I)V

    .line 218
    return-void
.end method

.method public addLastItem(Ljava/lang/Object;)V
    .locals 1
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "(TM;)V"
        }
    .end annotation

    .prologue
    .line 235
    .local p0, "this":Lcn/bingoogolapple/androidcommon/adapter/BGARecyclerViewAdapter;, "Lcn/bingoogolapple/androidcommon/adapter/BGARecyclerViewAdapter<TM;>;"
    .local p1, "model":Ljava/lang/Object;, "TM;"
    iget-object v0, p0, Lcn/bingoogolapple/androidcommon/adapter/BGARecyclerViewAdapter;->mDatas:Ljava/util/List;

    invoke-interface {v0}, Ljava/util/List;->size()I

    move-result v0

    invoke-virtual {p0, v0, p1}, Lcn/bingoogolapple/androidcommon/adapter/BGARecyclerViewAdapter;->addItem(ILjava/lang/Object;)V

    .line 236
    return-void
.end method

.method public addMoreDatas(Ljava/util/List;)V
    .locals 2
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "(",
            "Ljava/util/List",
            "<TM;>;)V"
        }
    .end annotation

    .prologue
    .line 162
    .local p0, "this":Lcn/bingoogolapple/androidcommon/adapter/BGARecyclerViewAdapter;, "Lcn/bingoogolapple/androidcommon/adapter/BGARecyclerViewAdapter<TM;>;"
    .local p1, "datas":Ljava/util/List;, "Ljava/util/List<TM;>;"
    if-eqz p1, :cond_0

    .line 163
    iget-object v0, p0, Lcn/bingoogolapple/androidcommon/adapter/BGARecyclerViewAdapter;->mDatas:Ljava/util/List;

    iget-object v1, p0, Lcn/bingoogolapple/androidcommon/adapter/BGARecyclerViewAdapter;->mDatas:Ljava/util/List;

    invoke-interface {v1}, Ljava/util/List;->size()I

    move-result v1

    invoke-interface {v0, v1, p1}, Ljava/util/List;->addAll(ILjava/util/Collection;)Z

    .line 164
    iget-object v0, p0, Lcn/bingoogolapple/androidcommon/adapter/BGARecyclerViewAdapter;->mDatas:Ljava/util/List;

    invoke-interface {v0}, Ljava/util/List;->size()I

    move-result v0

    invoke-interface {p1}, Ljava/util/List;->size()I

    move-result v1

    invoke-virtual {p0, v0, v1}, Lcn/bingoogolapple/androidcommon/adapter/BGARecyclerViewAdapter;->notifyItemRangeInserted(II)V

    .line 166
    :cond_0
    return-void
.end method

.method public addNewDatas(Ljava/util/List;)V
    .locals 2
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "(",
            "Ljava/util/List",
            "<TM;>;)V"
        }
    .end annotation

    .prologue
    .local p0, "this":Lcn/bingoogolapple/androidcommon/adapter/BGARecyclerViewAdapter;, "Lcn/bingoogolapple/androidcommon/adapter/BGARecyclerViewAdapter<TM;>;"
    .local p1, "datas":Ljava/util/List;, "Ljava/util/List<TM;>;"
    const/4 v1, 0x0

    .line 150
    if-eqz p1, :cond_0

    .line 151
    iget-object v0, p0, Lcn/bingoogolapple/androidcommon/adapter/BGARecyclerViewAdapter;->mDatas:Ljava/util/List;

    invoke-interface {v0, v1, p1}, Ljava/util/List;->addAll(ILjava/util/Collection;)Z

    .line 152
    invoke-interface {p1}, Ljava/util/List;->size()I

    move-result v0

    invoke-virtual {p0, v1, v0}, Lcn/bingoogolapple/androidcommon/adapter/BGARecyclerViewAdapter;->notifyItemRangeInserted(II)V

    .line 154
    :cond_0
    return-void
.end method

.method public clear()V
    .locals 1

    .prologue
    .line 186
    .local p0, "this":Lcn/bingoogolapple/androidcommon/adapter/BGARecyclerViewAdapter;, "Lcn/bingoogolapple/androidcommon/adapter/BGARecyclerViewAdapter<TM;>;"
    iget-object v0, p0, Lcn/bingoogolapple/androidcommon/adapter/BGARecyclerViewAdapter;->mDatas:Ljava/util/List;

    invoke-interface {v0}, Ljava/util/List;->clear()V

    .line 187
    invoke-virtual {p0}, Lcn/bingoogolapple/androidcommon/adapter/BGARecyclerViewAdapter;->notifyDataSetChanged()V

    .line 188
    return-void
.end method

.method protected abstract fillData(Lcn/bingoogolapple/androidcommon/adapter/BGAViewHolderHelper;ILjava/lang/Object;)V
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "(",
            "Lcn/bingoogolapple/androidcommon/adapter/BGAViewHolderHelper;",
            "ITM;)V"
        }
    .end annotation
.end method

.method public getDatas()Ljava/util/List;
    .locals 1
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "()",
            "Ljava/util/List",
            "<TM;>;"
        }
    .end annotation

    .prologue
    .line 141
    .local p0, "this":Lcn/bingoogolapple/androidcommon/adapter/BGARecyclerViewAdapter;, "Lcn/bingoogolapple/androidcommon/adapter/BGARecyclerViewAdapter<TM;>;"
    iget-object v0, p0, Lcn/bingoogolapple/androidcommon/adapter/BGARecyclerViewAdapter;->mDatas:Ljava/util/List;

    return-object v0
.end method

.method public getItem(I)Ljava/lang/Object;
    .locals 1
    .param p1, "position"    # I
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "(I)TM;"
        }
    .end annotation

    .prologue
    .line 132
    .local p0, "this":Lcn/bingoogolapple/androidcommon/adapter/BGARecyclerViewAdapter;, "Lcn/bingoogolapple/androidcommon/adapter/BGARecyclerViewAdapter<TM;>;"
    iget-object v0, p0, Lcn/bingoogolapple/androidcommon/adapter/BGARecyclerViewAdapter;->mDatas:Ljava/util/List;

    invoke-interface {v0, p1}, Ljava/util/List;->get(I)Ljava/lang/Object;

    move-result-object v0

    return-object v0
.end method

.method public getItemCount()I
    .locals 1

    .prologue
    .line 51
    .local p0, "this":Lcn/bingoogolapple/androidcommon/adapter/BGARecyclerViewAdapter;, "Lcn/bingoogolapple/androidcommon/adapter/BGARecyclerViewAdapter<TM;>;"
    iget-object v0, p0, Lcn/bingoogolapple/androidcommon/adapter/BGARecyclerViewAdapter;->mDatas:Ljava/util/List;

    invoke-interface {v0}, Ljava/util/List;->size()I

    move-result v0

    return v0
.end method

.method public moveItem(II)V
    .locals 2
    .param p1, "fromPosition"    # I
    .param p2, "toPosition"    # I

    .prologue
    .line 266
    .local p0, "this":Lcn/bingoogolapple/androidcommon/adapter/BGARecyclerViewAdapter;, "Lcn/bingoogolapple/androidcommon/adapter/BGARecyclerViewAdapter<TM;>;"
    iget-object v0, p0, Lcn/bingoogolapple/androidcommon/adapter/BGARecyclerViewAdapter;->mDatas:Ljava/util/List;

    iget-object v1, p0, Lcn/bingoogolapple/androidcommon/adapter/BGARecyclerViewAdapter;->mDatas:Ljava/util/List;

    invoke-interface {v1, p1}, Ljava/util/List;->remove(I)Ljava/lang/Object;

    move-result-object v1

    invoke-interface {v0, p2, v1}, Ljava/util/List;->add(ILjava/lang/Object;)V

    .line 267
    invoke-virtual {p0, p1, p2}, Lcn/bingoogolapple/androidcommon/adapter/BGARecyclerViewAdapter;->notifyItemMoved(II)V

    .line 268
    return-void
.end method

.method public bridge synthetic onBindViewHolder(Landroid/support/v7/widget/RecyclerView$ViewHolder;I)V
    .locals 0
    .param p1, "x0"    # Landroid/support/v7/widget/RecyclerView$ViewHolder;
    .param p2, "x1"    # I

    .prologue
    .line 30
    .local p0, "this":Lcn/bingoogolapple/androidcommon/adapter/BGARecyclerViewAdapter;, "Lcn/bingoogolapple/androidcommon/adapter/BGARecyclerViewAdapter<TM;>;"
    check-cast p1, Lcn/bingoogolapple/androidcommon/adapter/BGARecyclerViewHolder;

    .end local p1    # "x0":Landroid/support/v7/widget/RecyclerView$ViewHolder;
    invoke-virtual {p0, p1, p2}, Lcn/bingoogolapple/androidcommon/adapter/BGARecyclerViewAdapter;->onBindViewHolder(Lcn/bingoogolapple/androidcommon/adapter/BGARecyclerViewHolder;I)V

    return-void
.end method

.method public onBindViewHolder(Lcn/bingoogolapple/androidcommon/adapter/BGARecyclerViewHolder;I)V
    .locals 2
    .param p1, "viewHolder"    # Lcn/bingoogolapple/androidcommon/adapter/BGARecyclerViewHolder;
    .param p2, "position"    # I

    .prologue
    .line 74
    .local p0, "this":Lcn/bingoogolapple/androidcommon/adapter/BGARecyclerViewAdapter;, "Lcn/bingoogolapple/androidcommon/adapter/BGARecyclerViewAdapter<TM;>;"
    invoke-virtual {p1}, Lcn/bingoogolapple/androidcommon/adapter/BGARecyclerViewHolder;->getViewHolderHelper()Lcn/bingoogolapple/androidcommon/adapter/BGAViewHolderHelper;

    move-result-object v0

    invoke-virtual {p0, p2}, Lcn/bingoogolapple/androidcommon/adapter/BGARecyclerViewAdapter;->getItem(I)Ljava/lang/Object;

    move-result-object v1

    invoke-virtual {p0, v0, p2, v1}, Lcn/bingoogolapple/androidcommon/adapter/BGARecyclerViewAdapter;->fillData(Lcn/bingoogolapple/androidcommon/adapter/BGAViewHolderHelper;ILjava/lang/Object;)V

    .line 75
    return-void
.end method

.method public bridge synthetic onCreateViewHolder(Landroid/view/ViewGroup;I)Landroid/support/v7/widget/RecyclerView$ViewHolder;
    .locals 1
    .param p1, "x0"    # Landroid/view/ViewGroup;
    .param p2, "x1"    # I

    .prologue
    .line 30
    .local p0, "this":Lcn/bingoogolapple/androidcommon/adapter/BGARecyclerViewAdapter;, "Lcn/bingoogolapple/androidcommon/adapter/BGARecyclerViewAdapter<TM;>;"
    invoke-virtual {p0, p1, p2}, Lcn/bingoogolapple/androidcommon/adapter/BGARecyclerViewAdapter;->onCreateViewHolder(Landroid/view/ViewGroup;I)Lcn/bingoogolapple/androidcommon/adapter/BGARecyclerViewHolder;

    move-result-object v0

    return-object v0
.end method

.method public onCreateViewHolder(Landroid/view/ViewGroup;I)Lcn/bingoogolapple/androidcommon/adapter/BGARecyclerViewHolder;
    .locals 5
    .param p1, "parent"    # Landroid/view/ViewGroup;
    .param p2, "viewType"    # I

    .prologue
    .line 56
    .local p0, "this":Lcn/bingoogolapple/androidcommon/adapter/BGARecyclerViewAdapter;, "Lcn/bingoogolapple/androidcommon/adapter/BGARecyclerViewAdapter<TM;>;"
    new-instance v0, Lcn/bingoogolapple/androidcommon/adapter/BGARecyclerViewHolder;

    iget-object v1, p0, Lcn/bingoogolapple/androidcommon/adapter/BGARecyclerViewAdapter;->mRecyclerView:Landroid/support/v7/widget/RecyclerView;

    iget-object v2, p0, Lcn/bingoogolapple/androidcommon/adapter/BGARecyclerViewAdapter;->mContext:Landroid/content/Context;

    invoke-static {v2}, Landroid/view/LayoutInflater;->from(Landroid/content/Context;)Landroid/view/LayoutInflater;

    move-result-object v2

    iget v3, p0, Lcn/bingoogolapple/androidcommon/adapter/BGARecyclerViewAdapter;->mItemLayoutId:I

    const/4 v4, 0x0

    invoke-virtual {v2, v3, p1, v4}, Landroid/view/LayoutInflater;->inflate(ILandroid/view/ViewGroup;Z)Landroid/view/View;

    move-result-object v2

    iget-object v3, p0, Lcn/bingoogolapple/androidcommon/adapter/BGARecyclerViewAdapter;->mOnRVItemClickListener:Lcn/bingoogolapple/androidcommon/adapter/BGAOnRVItemClickListener;

    iget-object v4, p0, Lcn/bingoogolapple/androidcommon/adapter/BGARecyclerViewAdapter;->mOnRVItemLongClickListener:Lcn/bingoogolapple/androidcommon/adapter/BGAOnRVItemLongClickListener;

    invoke-direct {v0, v1, v2, v3, v4}, Lcn/bingoogolapple/androidcommon/adapter/BGARecyclerViewHolder;-><init>(Landroid/support/v7/widget/RecyclerView;Landroid/view/View;Lcn/bingoogolapple/androidcommon/adapter/BGAOnRVItemClickListener;Lcn/bingoogolapple/androidcommon/adapter/BGAOnRVItemLongClickListener;)V

    .line 57
    .local v0, "viewHolder":Lcn/bingoogolapple/androidcommon/adapter/BGARecyclerViewHolder;
    invoke-virtual {v0}, Lcn/bingoogolapple/androidcommon/adapter/BGARecyclerViewHolder;->getViewHolderHelper()Lcn/bingoogolapple/androidcommon/adapter/BGAViewHolderHelper;

    move-result-object v1

    iget-object v2, p0, Lcn/bingoogolapple/androidcommon/adapter/BGARecyclerViewAdapter;->mOnItemChildClickListener:Lcn/bingoogolapple/androidcommon/adapter/BGAOnItemChildClickListener;

    invoke-virtual {v1, v2}, Lcn/bingoogolapple/androidcommon/adapter/BGAViewHolderHelper;->setOnItemChildClickListener(Lcn/bingoogolapple/androidcommon/adapter/BGAOnItemChildClickListener;)V

    .line 58
    invoke-virtual {v0}, Lcn/bingoogolapple/androidcommon/adapter/BGARecyclerViewHolder;->getViewHolderHelper()Lcn/bingoogolapple/androidcommon/adapter/BGAViewHolderHelper;

    move-result-object v1

    iget-object v2, p0, Lcn/bingoogolapple/androidcommon/adapter/BGARecyclerViewAdapter;->mOnItemChildLongClickListener:Lcn/bingoogolapple/androidcommon/adapter/BGAOnItemChildLongClickListener;

    invoke-virtual {v1, v2}, Lcn/bingoogolapple/androidcommon/adapter/BGAViewHolderHelper;->setOnItemChildLongClickListener(Lcn/bingoogolapple/androidcommon/adapter/BGAOnItemChildLongClickListener;)V

    .line 59
    invoke-virtual {v0}, Lcn/bingoogolapple/androidcommon/adapter/BGARecyclerViewHolder;->getViewHolderHelper()Lcn/bingoogolapple/androidcommon/adapter/BGAViewHolderHelper;

    move-result-object v1

    iget-object v2, p0, Lcn/bingoogolapple/androidcommon/adapter/BGARecyclerViewAdapter;->mOnItemChildCheckedChangeListener:Lcn/bingoogolapple/androidcommon/adapter/BGAOnItemChildCheckedChangeListener;

    invoke-virtual {v1, v2}, Lcn/bingoogolapple/androidcommon/adapter/BGAViewHolderHelper;->setOnItemChildCheckedChangeListener(Lcn/bingoogolapple/androidcommon/adapter/BGAOnItemChildCheckedChangeListener;)V

    .line 60
    invoke-virtual {v0}, Lcn/bingoogolapple/androidcommon/adapter/BGARecyclerViewHolder;->getViewHolderHelper()Lcn/bingoogolapple/androidcommon/adapter/BGAViewHolderHelper;

    move-result-object v1

    invoke-virtual {p0, v1}, Lcn/bingoogolapple/androidcommon/adapter/BGARecyclerViewAdapter;->setItemChildListener(Lcn/bingoogolapple/androidcommon/adapter/BGAViewHolderHelper;)V

    .line 61
    return-object v0
.end method

.method public removeItem(I)V
    .locals 1
    .param p1, "position"    # I

    .prologue
    .line 196
    .local p0, "this":Lcn/bingoogolapple/androidcommon/adapter/BGARecyclerViewAdapter;, "Lcn/bingoogolapple/androidcommon/adapter/BGARecyclerViewAdapter<TM;>;"
    iget-object v0, p0, Lcn/bingoogolapple/androidcommon/adapter/BGARecyclerViewAdapter;->mDatas:Ljava/util/List;

    invoke-interface {v0, p1}, Ljava/util/List;->remove(I)Ljava/lang/Object;

    .line 197
    invoke-virtual {p0, p1}, Lcn/bingoogolapple/androidcommon/adapter/BGARecyclerViewAdapter;->notifyItemRemoved(I)V

    .line 198
    return-void
.end method

.method public removeItem(Ljava/lang/Object;)V
    .locals 1
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "(TM;)V"
        }
    .end annotation

    .prologue
    .line 206
    .local p0, "this":Lcn/bingoogolapple/androidcommon/adapter/BGARecyclerViewAdapter;, "Lcn/bingoogolapple/androidcommon/adapter/BGARecyclerViewAdapter<TM;>;"
    .local p1, "model":Ljava/lang/Object;, "TM;"
    iget-object v0, p0, Lcn/bingoogolapple/androidcommon/adapter/BGARecyclerViewAdapter;->mDatas:Ljava/util/List;

    invoke-interface {v0, p1}, Ljava/util/List;->indexOf(Ljava/lang/Object;)I

    move-result v0

    invoke-virtual {p0, v0}, Lcn/bingoogolapple/androidcommon/adapter/BGARecyclerViewAdapter;->removeItem(I)V

    .line 207
    return-void
.end method

.method public setDatas(Ljava/util/List;)V
    .locals 1
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "(",
            "Ljava/util/List",
            "<TM;>;)V"
        }
    .end annotation

    .prologue
    .line 174
    .local p0, "this":Lcn/bingoogolapple/androidcommon/adapter/BGARecyclerViewAdapter;, "Lcn/bingoogolapple/androidcommon/adapter/BGARecyclerViewAdapter<TM;>;"
    .local p1, "datas":Ljava/util/List;, "Ljava/util/List<TM;>;"
    if-eqz p1, :cond_0

    .line 175
    iput-object p1, p0, Lcn/bingoogolapple/androidcommon/adapter/BGARecyclerViewAdapter;->mDatas:Ljava/util/List;

    .line 179
    :goto_0
    invoke-virtual {p0}, Lcn/bingoogolapple/androidcommon/adapter/BGARecyclerViewAdapter;->notifyDataSetChanged()V

    .line 180
    return-void

    .line 177
    :cond_0
    iget-object v0, p0, Lcn/bingoogolapple/androidcommon/adapter/BGARecyclerViewAdapter;->mDatas:Ljava/util/List;

    invoke-interface {v0}, Ljava/util/List;->clear()V

    goto :goto_0
.end method

.method public setItem(ILjava/lang/Object;)V
    .locals 1
    .param p1, "location"    # I
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "(ITM;)V"
        }
    .end annotation

    .prologue
    .line 245
    .local p0, "this":Lcn/bingoogolapple/androidcommon/adapter/BGARecyclerViewAdapter;, "Lcn/bingoogolapple/androidcommon/adapter/BGARecyclerViewAdapter<TM;>;"
    .local p2, "newModel":Ljava/lang/Object;, "TM;"
    iget-object v0, p0, Lcn/bingoogolapple/androidcommon/adapter/BGARecyclerViewAdapter;->mDatas:Ljava/util/List;

    invoke-interface {v0, p1, p2}, Ljava/util/List;->set(ILjava/lang/Object;)Ljava/lang/Object;

    .line 246
    invoke-virtual {p0, p1}, Lcn/bingoogolapple/androidcommon/adapter/BGARecyclerViewAdapter;->notifyItemChanged(I)V

    .line 247
    return-void
.end method

.method public setItem(Ljava/lang/Object;Ljava/lang/Object;)V
    .locals 1
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "(TM;TM;)V"
        }
    .end annotation

    .prologue
    .line 256
    .local p0, "this":Lcn/bingoogolapple/androidcommon/adapter/BGARecyclerViewAdapter;, "Lcn/bingoogolapple/androidcommon/adapter/BGARecyclerViewAdapter<TM;>;"
    .local p1, "oldModel":Ljava/lang/Object;, "TM;"
    .local p2, "newModel":Ljava/lang/Object;, "TM;"
    iget-object v0, p0, Lcn/bingoogolapple/androidcommon/adapter/BGARecyclerViewAdapter;->mDatas:Ljava/util/List;

    invoke-interface {v0, p1}, Ljava/util/List;->indexOf(Ljava/lang/Object;)I

    move-result v0

    invoke-virtual {p0, v0, p2}, Lcn/bingoogolapple/androidcommon/adapter/BGARecyclerViewAdapter;->setItem(ILjava/lang/Object;)V

    .line 257
    return-void
.end method

.method protected setItemChildListener(Lcn/bingoogolapple/androidcommon/adapter/BGAViewHolderHelper;)V
    .locals 0
    .param p1, "viewHolderHelper"    # Lcn/bingoogolapple/androidcommon/adapter/BGAViewHolderHelper;

    .prologue
    .line 70
    .local p0, "this":Lcn/bingoogolapple/androidcommon/adapter/BGARecyclerViewAdapter;, "Lcn/bingoogolapple/androidcommon/adapter/BGARecyclerViewAdapter<TM;>;"
    return-void
.end method

.method public setOnItemChildCheckedChangeListener(Lcn/bingoogolapple/androidcommon/adapter/BGAOnItemChildCheckedChangeListener;)V
    .locals 0
    .param p1, "onItemChildCheckedChangeListener"    # Lcn/bingoogolapple/androidcommon/adapter/BGAOnItemChildCheckedChangeListener;

    .prologue
    .line 128
    .local p0, "this":Lcn/bingoogolapple/androidcommon/adapter/BGARecyclerViewAdapter;, "Lcn/bingoogolapple/androidcommon/adapter/BGARecyclerViewAdapter<TM;>;"
    iput-object p1, p0, Lcn/bingoogolapple/androidcommon/adapter/BGARecyclerViewAdapter;->mOnItemChildCheckedChangeListener:Lcn/bingoogolapple/androidcommon/adapter/BGAOnItemChildCheckedChangeListener;

    .line 129
    return-void
.end method

.method public setOnItemChildClickListener(Lcn/bingoogolapple/androidcommon/adapter/BGAOnItemChildClickListener;)V
    .locals 0
    .param p1, "onItemChildClickListener"    # Lcn/bingoogolapple/androidcommon/adapter/BGAOnItemChildClickListener;

    .prologue
    .line 110
    .local p0, "this":Lcn/bingoogolapple/androidcommon/adapter/BGARecyclerViewAdapter;, "Lcn/bingoogolapple/androidcommon/adapter/BGARecyclerViewAdapter<TM;>;"
    iput-object p1, p0, Lcn/bingoogolapple/androidcommon/adapter/BGARecyclerViewAdapter;->mOnItemChildClickListener:Lcn/bingoogolapple/androidcommon/adapter/BGAOnItemChildClickListener;

    .line 111
    return-void
.end method

.method public setOnItemChildLongClickListener(Lcn/bingoogolapple/androidcommon/adapter/BGAOnItemChildLongClickListener;)V
    .locals 0
    .param p1, "onItemChildLongClickListener"    # Lcn/bingoogolapple/androidcommon/adapter/BGAOnItemChildLongClickListener;

    .prologue
    .line 119
    .local p0, "this":Lcn/bingoogolapple/androidcommon/adapter/BGARecyclerViewAdapter;, "Lcn/bingoogolapple/androidcommon/adapter/BGARecyclerViewAdapter<TM;>;"
    iput-object p1, p0, Lcn/bingoogolapple/androidcommon/adapter/BGARecyclerViewAdapter;->mOnItemChildLongClickListener:Lcn/bingoogolapple/androidcommon/adapter/BGAOnItemChildLongClickListener;

    .line 120
    return-void
.end method

.method public setOnRVItemClickListener(Lcn/bingoogolapple/androidcommon/adapter/BGAOnRVItemClickListener;)V
    .locals 0
    .param p1, "onRVItemClickListener"    # Lcn/bingoogolapple/androidcommon/adapter/BGAOnRVItemClickListener;

    .prologue
    .line 92
    .local p0, "this":Lcn/bingoogolapple/androidcommon/adapter/BGARecyclerViewAdapter;, "Lcn/bingoogolapple/androidcommon/adapter/BGARecyclerViewAdapter<TM;>;"
    iput-object p1, p0, Lcn/bingoogolapple/androidcommon/adapter/BGARecyclerViewAdapter;->mOnRVItemClickListener:Lcn/bingoogolapple/androidcommon/adapter/BGAOnRVItemClickListener;

    .line 93
    return-void
.end method

.method public setOnRVItemLongClickListener(Lcn/bingoogolapple/androidcommon/adapter/BGAOnRVItemLongClickListener;)V
    .locals 0
    .param p1, "onRVItemLongClickListener"    # Lcn/bingoogolapple/androidcommon/adapter/BGAOnRVItemLongClickListener;

    .prologue
    .line 101
    .local p0, "this":Lcn/bingoogolapple/androidcommon/adapter/BGARecyclerViewAdapter;, "Lcn/bingoogolapple/androidcommon/adapter/BGARecyclerViewAdapter<TM;>;"
    iput-object p1, p0, Lcn/bingoogolapple/androidcommon/adapter/BGARecyclerViewAdapter;->mOnRVItemLongClickListener:Lcn/bingoogolapple/androidcommon/adapter/BGAOnRVItemLongClickListener;

    .line 102
    return-void
.end method
