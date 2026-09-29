.class public abstract Lcn/bingoogolapple/androidcommon/adapter/BGAAdapterViewAdapter;
.super Landroid/widget/BaseAdapter;
.source "BGAAdapterViewAdapter.java"


# annotations
.annotation system Ldalvik/annotation/Signature;
    value = {
        "<M:",
        "Ljava/lang/Object;",
        ">",
        "Landroid/widget/BaseAdapter;"
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


# direct methods
.method public constructor <init>(Landroid/content/Context;I)V
    .locals 1
    .param p1, "context"    # Landroid/content/Context;
    .param p2, "itemLayoutId"    # I

    .prologue
    .line 41
    .local p0, "this":Lcn/bingoogolapple/androidcommon/adapter/BGAAdapterViewAdapter;, "Lcn/bingoogolapple/androidcommon/adapter/BGAAdapterViewAdapter<TM;>;"
    invoke-direct {p0}, Landroid/widget/BaseAdapter;-><init>()V

    .line 42
    iput-object p1, p0, Lcn/bingoogolapple/androidcommon/adapter/BGAAdapterViewAdapter;->mContext:Landroid/content/Context;

    .line 43
    iput p2, p0, Lcn/bingoogolapple/androidcommon/adapter/BGAAdapterViewAdapter;->mItemLayoutId:I

    .line 44
    new-instance v0, Ljava/util/ArrayList;

    invoke-direct {v0}, Ljava/util/ArrayList;-><init>()V

    iput-object v0, p0, Lcn/bingoogolapple/androidcommon/adapter/BGAAdapterViewAdapter;->mDatas:Ljava/util/List;

    .line 45
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
    .line 211
    .local p0, "this":Lcn/bingoogolapple/androidcommon/adapter/BGAAdapterViewAdapter;, "Lcn/bingoogolapple/androidcommon/adapter/BGAAdapterViewAdapter<TM;>;"
    .local p1, "model":Ljava/lang/Object;, "TM;"
    const/4 v0, 0x0

    invoke-virtual {p0, v0, p1}, Lcn/bingoogolapple/androidcommon/adapter/BGAAdapterViewAdapter;->addItem(ILjava/lang/Object;)V

    .line 212
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
    .line 201
    .local p0, "this":Lcn/bingoogolapple/androidcommon/adapter/BGAAdapterViewAdapter;, "Lcn/bingoogolapple/androidcommon/adapter/BGAAdapterViewAdapter<TM;>;"
    .local p2, "model":Ljava/lang/Object;, "TM;"
    iget-object v0, p0, Lcn/bingoogolapple/androidcommon/adapter/BGAAdapterViewAdapter;->mDatas:Ljava/util/List;

    invoke-interface {v0, p1, p2}, Ljava/util/List;->add(ILjava/lang/Object;)V

    .line 202
    invoke-virtual {p0}, Lcn/bingoogolapple/androidcommon/adapter/BGAAdapterViewAdapter;->notifyDataSetChanged()V

    .line 203
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
    .line 220
    .local p0, "this":Lcn/bingoogolapple/androidcommon/adapter/BGAAdapterViewAdapter;, "Lcn/bingoogolapple/androidcommon/adapter/BGAAdapterViewAdapter<TM;>;"
    .local p1, "model":Ljava/lang/Object;, "TM;"
    iget-object v0, p0, Lcn/bingoogolapple/androidcommon/adapter/BGAAdapterViewAdapter;->mDatas:Ljava/util/List;

    invoke-interface {v0}, Ljava/util/List;->size()I

    move-result v0

    invoke-virtual {p0, v0, p1}, Lcn/bingoogolapple/androidcommon/adapter/BGAAdapterViewAdapter;->addItem(ILjava/lang/Object;)V

    .line 221
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
    .line 146
    .local p0, "this":Lcn/bingoogolapple/androidcommon/adapter/BGAAdapterViewAdapter;, "Lcn/bingoogolapple/androidcommon/adapter/BGAAdapterViewAdapter<TM;>;"
    .local p1, "datas":Ljava/util/List;, "Ljava/util/List<TM;>;"
    if-eqz p1, :cond_0

    .line 147
    iget-object v0, p0, Lcn/bingoogolapple/androidcommon/adapter/BGAAdapterViewAdapter;->mDatas:Ljava/util/List;

    iget-object v1, p0, Lcn/bingoogolapple/androidcommon/adapter/BGAAdapterViewAdapter;->mDatas:Ljava/util/List;

    invoke-interface {v1}, Ljava/util/List;->size()I

    move-result v1

    invoke-interface {v0, v1, p1}, Ljava/util/List;->addAll(ILjava/util/Collection;)Z

    .line 148
    invoke-virtual {p0}, Lcn/bingoogolapple/androidcommon/adapter/BGAAdapterViewAdapter;->notifyDataSetChanged()V

    .line 150
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
    .line 134
    .local p0, "this":Lcn/bingoogolapple/androidcommon/adapter/BGAAdapterViewAdapter;, "Lcn/bingoogolapple/androidcommon/adapter/BGAAdapterViewAdapter<TM;>;"
    .local p1, "datas":Ljava/util/List;, "Ljava/util/List<TM;>;"
    if-eqz p1, :cond_0

    .line 135
    iget-object v0, p0, Lcn/bingoogolapple/androidcommon/adapter/BGAAdapterViewAdapter;->mDatas:Ljava/util/List;

    const/4 v1, 0x0

    invoke-interface {v0, v1, p1}, Ljava/util/List;->addAll(ILjava/util/Collection;)Z

    .line 136
    invoke-virtual {p0}, Lcn/bingoogolapple/androidcommon/adapter/BGAAdapterViewAdapter;->notifyDataSetChanged()V

    .line 138
    :cond_0
    return-void
.end method

.method public clear()V
    .locals 1

    .prologue
    .line 170
    .local p0, "this":Lcn/bingoogolapple/androidcommon/adapter/BGAAdapterViewAdapter;, "Lcn/bingoogolapple/androidcommon/adapter/BGAAdapterViewAdapter<TM;>;"
    iget-object v0, p0, Lcn/bingoogolapple/androidcommon/adapter/BGAAdapterViewAdapter;->mDatas:Ljava/util/List;

    invoke-interface {v0}, Ljava/util/List;->clear()V

    .line 171
    invoke-virtual {p0}, Lcn/bingoogolapple/androidcommon/adapter/BGAAdapterViewAdapter;->notifyDataSetChanged()V

    .line 172
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

.method public getCount()I
    .locals 1

    .prologue
    .line 49
    .local p0, "this":Lcn/bingoogolapple/androidcommon/adapter/BGAAdapterViewAdapter;, "Lcn/bingoogolapple/androidcommon/adapter/BGAAdapterViewAdapter<TM;>;"
    iget-object v0, p0, Lcn/bingoogolapple/androidcommon/adapter/BGAAdapterViewAdapter;->mDatas:Ljava/util/List;

    invoke-interface {v0}, Ljava/util/List;->size()I

    move-result v0

    return v0
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
    .line 125
    .local p0, "this":Lcn/bingoogolapple/androidcommon/adapter/BGAAdapterViewAdapter;, "Lcn/bingoogolapple/androidcommon/adapter/BGAAdapterViewAdapter<TM;>;"
    iget-object v0, p0, Lcn/bingoogolapple/androidcommon/adapter/BGAAdapterViewAdapter;->mDatas:Ljava/util/List;

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
    .line 54
    .local p0, "this":Lcn/bingoogolapple/androidcommon/adapter/BGAAdapterViewAdapter;, "Lcn/bingoogolapple/androidcommon/adapter/BGAAdapterViewAdapter<TM;>;"
    iget-object v0, p0, Lcn/bingoogolapple/androidcommon/adapter/BGAAdapterViewAdapter;->mDatas:Ljava/util/List;

    invoke-interface {v0, p1}, Ljava/util/List;->get(I)Ljava/lang/Object;

    move-result-object v0

    return-object v0
.end method

.method public getItemId(I)J
    .locals 2
    .param p1, "position"    # I

    .prologue
    .line 59
    .local p0, "this":Lcn/bingoogolapple/androidcommon/adapter/BGAAdapterViewAdapter;, "Lcn/bingoogolapple/androidcommon/adapter/BGAAdapterViewAdapter<TM;>;"
    int-to-long v0, p1

    return-wide v0
.end method

.method public getView(ILandroid/view/View;Landroid/view/ViewGroup;)Landroid/view/View;
    .locals 3
    .param p1, "position"    # I
    .param p2, "convertView"    # Landroid/view/View;
    .param p3, "parent"    # Landroid/view/ViewGroup;

    .prologue
    .line 64
    .local p0, "this":Lcn/bingoogolapple/androidcommon/adapter/BGAAdapterViewAdapter;, "Lcn/bingoogolapple/androidcommon/adapter/BGAAdapterViewAdapter<TM;>;"
    iget v1, p0, Lcn/bingoogolapple/androidcommon/adapter/BGAAdapterViewAdapter;->mItemLayoutId:I

    invoke-static {p2, p3, v1}, Lcn/bingoogolapple/androidcommon/adapter/BGAAdapterViewHolder;->dequeueReusableAdapterViewHolder(Landroid/view/View;Landroid/view/ViewGroup;I)Lcn/bingoogolapple/androidcommon/adapter/BGAAdapterViewHolder;

    move-result-object v0

    .line 65
    .local v0, "viewHolder":Lcn/bingoogolapple/androidcommon/adapter/BGAAdapterViewHolder;
    invoke-virtual {v0}, Lcn/bingoogolapple/androidcommon/adapter/BGAAdapterViewHolder;->getViewHolderHelper()Lcn/bingoogolapple/androidcommon/adapter/BGAViewHolderHelper;

    move-result-object v1

    invoke-virtual {v1, p1}, Lcn/bingoogolapple/androidcommon/adapter/BGAViewHolderHelper;->setPosition(I)V

    .line 66
    invoke-virtual {v0}, Lcn/bingoogolapple/androidcommon/adapter/BGAAdapterViewHolder;->getViewHolderHelper()Lcn/bingoogolapple/androidcommon/adapter/BGAViewHolderHelper;

    move-result-object v1

    iget-object v2, p0, Lcn/bingoogolapple/androidcommon/adapter/BGAAdapterViewAdapter;->mOnItemChildClickListener:Lcn/bingoogolapple/androidcommon/adapter/BGAOnItemChildClickListener;

    invoke-virtual {v1, v2}, Lcn/bingoogolapple/androidcommon/adapter/BGAViewHolderHelper;->setOnItemChildClickListener(Lcn/bingoogolapple/androidcommon/adapter/BGAOnItemChildClickListener;)V

    .line 67
    invoke-virtual {v0}, Lcn/bingoogolapple/androidcommon/adapter/BGAAdapterViewHolder;->getViewHolderHelper()Lcn/bingoogolapple/androidcommon/adapter/BGAViewHolderHelper;

    move-result-object v1

    iget-object v2, p0, Lcn/bingoogolapple/androidcommon/adapter/BGAAdapterViewAdapter;->mOnItemChildLongClickListener:Lcn/bingoogolapple/androidcommon/adapter/BGAOnItemChildLongClickListener;

    invoke-virtual {v1, v2}, Lcn/bingoogolapple/androidcommon/adapter/BGAViewHolderHelper;->setOnItemChildLongClickListener(Lcn/bingoogolapple/androidcommon/adapter/BGAOnItemChildLongClickListener;)V

    .line 68
    invoke-virtual {v0}, Lcn/bingoogolapple/androidcommon/adapter/BGAAdapterViewHolder;->getViewHolderHelper()Lcn/bingoogolapple/androidcommon/adapter/BGAViewHolderHelper;

    move-result-object v1

    iget-object v2, p0, Lcn/bingoogolapple/androidcommon/adapter/BGAAdapterViewAdapter;->mOnItemChildCheckedChangeListener:Lcn/bingoogolapple/androidcommon/adapter/BGAOnItemChildCheckedChangeListener;

    invoke-virtual {v1, v2}, Lcn/bingoogolapple/androidcommon/adapter/BGAViewHolderHelper;->setOnItemChildCheckedChangeListener(Lcn/bingoogolapple/androidcommon/adapter/BGAOnItemChildCheckedChangeListener;)V

    .line 69
    invoke-virtual {v0}, Lcn/bingoogolapple/androidcommon/adapter/BGAAdapterViewHolder;->getViewHolderHelper()Lcn/bingoogolapple/androidcommon/adapter/BGAViewHolderHelper;

    move-result-object v1

    invoke-virtual {p0, v1}, Lcn/bingoogolapple/androidcommon/adapter/BGAAdapterViewAdapter;->setItemChildListener(Lcn/bingoogolapple/androidcommon/adapter/BGAViewHolderHelper;)V

    .line 71
    invoke-virtual {v0}, Lcn/bingoogolapple/androidcommon/adapter/BGAAdapterViewHolder;->getViewHolderHelper()Lcn/bingoogolapple/androidcommon/adapter/BGAViewHolderHelper;

    move-result-object v1

    invoke-virtual {p0, p1}, Lcn/bingoogolapple/androidcommon/adapter/BGAAdapterViewAdapter;->getItem(I)Ljava/lang/Object;

    move-result-object v2

    invoke-virtual {p0, v1, p1, v2}, Lcn/bingoogolapple/androidcommon/adapter/BGAAdapterViewAdapter;->fillData(Lcn/bingoogolapple/androidcommon/adapter/BGAViewHolderHelper;ILjava/lang/Object;)V

    .line 72
    invoke-virtual {v0}, Lcn/bingoogolapple/androidcommon/adapter/BGAAdapterViewHolder;->getConvertView()Landroid/view/View;

    move-result-object v1

    return-object v1
.end method

.method public moveItem(II)V
    .locals 1
    .param p1, "fromPosition"    # I
    .param p2, "toPosition"    # I

    .prologue
    .line 251
    .local p0, "this":Lcn/bingoogolapple/androidcommon/adapter/BGAAdapterViewAdapter;, "Lcn/bingoogolapple/androidcommon/adapter/BGAAdapterViewAdapter<TM;>;"
    iget-object v0, p0, Lcn/bingoogolapple/androidcommon/adapter/BGAAdapterViewAdapter;->mDatas:Ljava/util/List;

    invoke-static {v0, p1, p2}, Ljava/util/Collections;->swap(Ljava/util/List;II)V

    .line 252
    invoke-virtual {p0}, Lcn/bingoogolapple/androidcommon/adapter/BGAAdapterViewAdapter;->notifyDataSetChanged()V

    .line 253
    return-void
.end method

.method public removeItem(I)V
    .locals 1
    .param p1, "position"    # I

    .prologue
    .line 180
    .local p0, "this":Lcn/bingoogolapple/androidcommon/adapter/BGAAdapterViewAdapter;, "Lcn/bingoogolapple/androidcommon/adapter/BGAAdapterViewAdapter<TM;>;"
    iget-object v0, p0, Lcn/bingoogolapple/androidcommon/adapter/BGAAdapterViewAdapter;->mDatas:Ljava/util/List;

    invoke-interface {v0, p1}, Ljava/util/List;->remove(I)Ljava/lang/Object;

    .line 181
    invoke-virtual {p0}, Lcn/bingoogolapple/androidcommon/adapter/BGAAdapterViewAdapter;->notifyDataSetChanged()V

    .line 182
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
    .line 190
    .local p0, "this":Lcn/bingoogolapple/androidcommon/adapter/BGAAdapterViewAdapter;, "Lcn/bingoogolapple/androidcommon/adapter/BGAAdapterViewAdapter<TM;>;"
    .local p1, "model":Ljava/lang/Object;, "TM;"
    iget-object v0, p0, Lcn/bingoogolapple/androidcommon/adapter/BGAAdapterViewAdapter;->mDatas:Ljava/util/List;

    invoke-interface {v0, p1}, Ljava/util/List;->remove(Ljava/lang/Object;)Z

    .line 191
    invoke-virtual {p0}, Lcn/bingoogolapple/androidcommon/adapter/BGAAdapterViewAdapter;->notifyDataSetChanged()V

    .line 192
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
    .line 158
    .local p0, "this":Lcn/bingoogolapple/androidcommon/adapter/BGAAdapterViewAdapter;, "Lcn/bingoogolapple/androidcommon/adapter/BGAAdapterViewAdapter<TM;>;"
    .local p1, "datas":Ljava/util/List;, "Ljava/util/List<TM;>;"
    if-eqz p1, :cond_0

    .line 159
    iput-object p1, p0, Lcn/bingoogolapple/androidcommon/adapter/BGAAdapterViewAdapter;->mDatas:Ljava/util/List;

    .line 163
    :goto_0
    invoke-virtual {p0}, Lcn/bingoogolapple/androidcommon/adapter/BGAAdapterViewAdapter;->notifyDataSetChanged()V

    .line 164
    return-void

    .line 161
    :cond_0
    iget-object v0, p0, Lcn/bingoogolapple/androidcommon/adapter/BGAAdapterViewAdapter;->mDatas:Ljava/util/List;

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
    .line 230
    .local p0, "this":Lcn/bingoogolapple/androidcommon/adapter/BGAAdapterViewAdapter;, "Lcn/bingoogolapple/androidcommon/adapter/BGAAdapterViewAdapter<TM;>;"
    .local p2, "newModel":Ljava/lang/Object;, "TM;"
    iget-object v0, p0, Lcn/bingoogolapple/androidcommon/adapter/BGAAdapterViewAdapter;->mDatas:Ljava/util/List;

    invoke-interface {v0, p1, p2}, Ljava/util/List;->set(ILjava/lang/Object;)Ljava/lang/Object;

    .line 231
    invoke-virtual {p0}, Lcn/bingoogolapple/androidcommon/adapter/BGAAdapterViewAdapter;->notifyDataSetChanged()V

    .line 232
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
    .line 241
    .local p0, "this":Lcn/bingoogolapple/androidcommon/adapter/BGAAdapterViewAdapter;, "Lcn/bingoogolapple/androidcommon/adapter/BGAAdapterViewAdapter<TM;>;"
    .local p1, "oldModel":Ljava/lang/Object;, "TM;"
    .local p2, "newModel":Ljava/lang/Object;, "TM;"
    iget-object v0, p0, Lcn/bingoogolapple/androidcommon/adapter/BGAAdapterViewAdapter;->mDatas:Ljava/util/List;

    invoke-interface {v0, p1}, Ljava/util/List;->indexOf(Ljava/lang/Object;)I

    move-result v0

    invoke-virtual {p0, v0, p2}, Lcn/bingoogolapple/androidcommon/adapter/BGAAdapterViewAdapter;->setItem(ILjava/lang/Object;)V

    .line 242
    return-void
.end method

.method protected setItemChildListener(Lcn/bingoogolapple/androidcommon/adapter/BGAViewHolderHelper;)V
    .locals 0
    .param p1, "viewHolderHelper"    # Lcn/bingoogolapple/androidcommon/adapter/BGAViewHolderHelper;

    .prologue
    .line 81
    .local p0, "this":Lcn/bingoogolapple/androidcommon/adapter/BGAAdapterViewAdapter;, "Lcn/bingoogolapple/androidcommon/adapter/BGAAdapterViewAdapter<TM;>;"
    return-void
.end method

.method public setOnItemChildCheckedChangeListener(Lcn/bingoogolapple/androidcommon/adapter/BGAOnItemChildCheckedChangeListener;)V
    .locals 0
    .param p1, "onItemChildCheckedChangeListener"    # Lcn/bingoogolapple/androidcommon/adapter/BGAOnItemChildCheckedChangeListener;

    .prologue
    .line 116
    .local p0, "this":Lcn/bingoogolapple/androidcommon/adapter/BGAAdapterViewAdapter;, "Lcn/bingoogolapple/androidcommon/adapter/BGAAdapterViewAdapter<TM;>;"
    iput-object p1, p0, Lcn/bingoogolapple/androidcommon/adapter/BGAAdapterViewAdapter;->mOnItemChildCheckedChangeListener:Lcn/bingoogolapple/androidcommon/adapter/BGAOnItemChildCheckedChangeListener;

    .line 117
    return-void
.end method

.method public setOnItemChildClickListener(Lcn/bingoogolapple/androidcommon/adapter/BGAOnItemChildClickListener;)V
    .locals 0
    .param p1, "onItemChildClickListener"    # Lcn/bingoogolapple/androidcommon/adapter/BGAOnItemChildClickListener;

    .prologue
    .line 98
    .local p0, "this":Lcn/bingoogolapple/androidcommon/adapter/BGAAdapterViewAdapter;, "Lcn/bingoogolapple/androidcommon/adapter/BGAAdapterViewAdapter<TM;>;"
    iput-object p1, p0, Lcn/bingoogolapple/androidcommon/adapter/BGAAdapterViewAdapter;->mOnItemChildClickListener:Lcn/bingoogolapple/androidcommon/adapter/BGAOnItemChildClickListener;

    .line 99
    return-void
.end method

.method public setOnItemChildLongClickListener(Lcn/bingoogolapple/androidcommon/adapter/BGAOnItemChildLongClickListener;)V
    .locals 0
    .param p1, "onItemChildLongClickListener"    # Lcn/bingoogolapple/androidcommon/adapter/BGAOnItemChildLongClickListener;

    .prologue
    .line 107
    .local p0, "this":Lcn/bingoogolapple/androidcommon/adapter/BGAAdapterViewAdapter;, "Lcn/bingoogolapple/androidcommon/adapter/BGAAdapterViewAdapter<TM;>;"
    iput-object p1, p0, Lcn/bingoogolapple/androidcommon/adapter/BGAAdapterViewAdapter;->mOnItemChildLongClickListener:Lcn/bingoogolapple/androidcommon/adapter/BGAOnItemChildLongClickListener;

    .line 108
    return-void
.end method
