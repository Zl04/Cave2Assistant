.class public abstract Lcom/cyjh/elfin/adpter/CYJHAdapter;
.super Landroid/widget/BaseAdapter;
.source "CYJHAdapter.java"

# interfaces
.implements Lcom/cyjh/elfin/adpter/IAdapterHelp;


# annotations
.annotation system Ldalvik/annotation/Signature;
    value = {
        "<T:",
        "Ljava/lang/Object;",
        ">",
        "Landroid/widget/BaseAdapter;",
        "Lcom/cyjh/elfin/adpter/IAdapterHelp",
        "<TT;>;"
    }
.end annotation


# instance fields
.field protected mContext:Landroid/content/Context;

.field protected mData:Ljava/util/List;
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "Ljava/util/List",
            "<TT;>;"
        }
    .end annotation
.end field


# direct methods
.method public constructor <init>(Landroid/content/Context;)V
    .locals 0
    .param p1, "context"    # Landroid/content/Context;

    .prologue
    .line 22
    .local p0, "this":Lcom/cyjh/elfin/adpter/CYJHAdapter;, "Lcom/cyjh/elfin/adpter/CYJHAdapter<TT;>;"
    invoke-direct {p0}, Landroid/widget/BaseAdapter;-><init>()V

    .line 23
    iput-object p1, p0, Lcom/cyjh/elfin/adpter/CYJHAdapter;->mContext:Landroid/content/Context;

    .line 24
    return-void
.end method

.method public constructor <init>(Landroid/content/Context;Ljava/util/List;)V
    .locals 0
    .param p1, "context"    # Landroid/content/Context;
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "(",
            "Landroid/content/Context;",
            "Ljava/util/List",
            "<TT;>;)V"
        }
    .end annotation

    .prologue
    .line 26
    .local p0, "this":Lcom/cyjh/elfin/adpter/CYJHAdapter;, "Lcom/cyjh/elfin/adpter/CYJHAdapter<TT;>;"
    .local p2, "data":Ljava/util/List;, "Ljava/util/List<TT;>;"
    invoke-direct {p0}, Landroid/widget/BaseAdapter;-><init>()V

    .line 27
    iput-object p1, p0, Lcom/cyjh/elfin/adpter/CYJHAdapter;->mContext:Landroid/content/Context;

    .line 28
    iput-object p2, p0, Lcom/cyjh/elfin/adpter/CYJHAdapter;->mData:Ljava/util/List;

    .line 29
    return-void
.end method


# virtual methods
.method public addBatchDataNotifyDataSetChanged(Ljava/util/List;)V
    .locals 1
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "(",
            "Ljava/util/List",
            "<TT;>;)V"
        }
    .end annotation

    .prologue
    .line 79
    .local p0, "this":Lcom/cyjh/elfin/adpter/CYJHAdapter;, "Lcom/cyjh/elfin/adpter/CYJHAdapter<TT;>;"
    .local p1, "ts":Ljava/util/List;, "Ljava/util/List<TT;>;"
    iget-object v0, p0, Lcom/cyjh/elfin/adpter/CYJHAdapter;->mData:Ljava/util/List;

    if-nez v0, :cond_0

    .line 80
    new-instance v0, Ljava/util/ArrayList;

    invoke-direct {v0}, Ljava/util/ArrayList;-><init>()V

    iput-object v0, p0, Lcom/cyjh/elfin/adpter/CYJHAdapter;->mData:Ljava/util/List;

    .line 82
    :cond_0
    if-eqz p1, :cond_1

    invoke-interface {p1}, Ljava/util/List;->isEmpty()Z

    move-result v0

    if-nez v0, :cond_1

    .line 83
    iget-object v0, p0, Lcom/cyjh/elfin/adpter/CYJHAdapter;->mData:Ljava/util/List;

    invoke-interface {v0, p1}, Ljava/util/List;->addAll(Ljava/util/Collection;)Z

    .line 84
    invoke-virtual {p0}, Lcom/cyjh/elfin/adpter/CYJHAdapter;->notifyDataSetChanged()V

    .line 87
    :cond_1
    return-void
.end method

.method public addDataNotifyDataSetChanged(ILjava/lang/Object;)V
    .locals 1
    .param p1, "position"    # I
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "(ITT;)V"
        }
    .end annotation

    .prologue
    .line 113
    .local p0, "this":Lcom/cyjh/elfin/adpter/CYJHAdapter;, "Lcom/cyjh/elfin/adpter/CYJHAdapter<TT;>;"
    .local p2, "t":Ljava/lang/Object;, "TT;"
    iget-object v0, p0, Lcom/cyjh/elfin/adpter/CYJHAdapter;->mData:Ljava/util/List;

    if-nez v0, :cond_0

    .line 114
    new-instance v0, Ljava/util/ArrayList;

    invoke-direct {v0}, Ljava/util/ArrayList;-><init>()V

    iput-object v0, p0, Lcom/cyjh/elfin/adpter/CYJHAdapter;->mData:Ljava/util/List;

    .line 116
    :cond_0
    if-eqz p2, :cond_1

    .line 117
    iget-object v0, p0, Lcom/cyjh/elfin/adpter/CYJHAdapter;->mData:Ljava/util/List;

    invoke-interface {v0, p1, p2}, Ljava/util/List;->add(ILjava/lang/Object;)V

    .line 118
    invoke-virtual {p0}, Lcom/cyjh/elfin/adpter/CYJHAdapter;->notifyDataSetChanged()V

    .line 120
    :cond_1
    return-void
.end method

.method public addDataNotifyDataSetChanged(Ljava/lang/Object;)V
    .locals 1
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "(TT;)V"
        }
    .end annotation

    .prologue
    .line 67
    .local p0, "this":Lcom/cyjh/elfin/adpter/CYJHAdapter;, "Lcom/cyjh/elfin/adpter/CYJHAdapter<TT;>;"
    .local p1, "t":Ljava/lang/Object;, "TT;"
    iget-object v0, p0, Lcom/cyjh/elfin/adpter/CYJHAdapter;->mData:Ljava/util/List;

    if-nez v0, :cond_0

    .line 68
    new-instance v0, Ljava/util/ArrayList;

    invoke-direct {v0}, Ljava/util/ArrayList;-><init>()V

    iput-object v0, p0, Lcom/cyjh/elfin/adpter/CYJHAdapter;->mData:Ljava/util/List;

    .line 70
    :cond_0
    if-eqz p1, :cond_1

    .line 71
    iget-object v0, p0, Lcom/cyjh/elfin/adpter/CYJHAdapter;->mData:Ljava/util/List;

    invoke-interface {v0, p1}, Ljava/util/List;->add(Ljava/lang/Object;)Z

    .line 72
    invoke-virtual {p0}, Lcom/cyjh/elfin/adpter/CYJHAdapter;->notifyDataSetChanged()V

    .line 74
    :cond_1
    return-void
.end method

.method public clear()V
    .locals 1

    .prologue
    .line 38
    .local p0, "this":Lcom/cyjh/elfin/adpter/CYJHAdapter;, "Lcom/cyjh/elfin/adpter/CYJHAdapter<TT;>;"
    iget-object v0, p0, Lcom/cyjh/elfin/adpter/CYJHAdapter;->mData:Ljava/util/List;

    if-eqz v0, :cond_0

    .line 39
    iget-object v0, p0, Lcom/cyjh/elfin/adpter/CYJHAdapter;->mData:Ljava/util/List;

    invoke-interface {v0}, Ljava/util/List;->clear()V

    .line 41
    :cond_0
    return-void
.end method

.method public getCount()I
    .locals 1

    .prologue
    .line 44
    .local p0, "this":Lcom/cyjh/elfin/adpter/CYJHAdapter;, "Lcom/cyjh/elfin/adpter/CYJHAdapter<TT;>;"
    iget-object v0, p0, Lcom/cyjh/elfin/adpter/CYJHAdapter;->mData:Ljava/util/List;

    if-eqz v0, :cond_0

    iget-object v0, p0, Lcom/cyjh/elfin/adpter/CYJHAdapter;->mData:Ljava/util/List;

    invoke-interface {v0}, Ljava/util/List;->isEmpty()Z

    move-result v0

    if-eqz v0, :cond_1

    :cond_0
    const/4 v0, 0x0

    :goto_0
    return v0

    :cond_1
    iget-object v0, p0, Lcom/cyjh/elfin/adpter/CYJHAdapter;->mData:Ljava/util/List;

    invoke-interface {v0}, Ljava/util/List;->size()I

    move-result v0

    goto :goto_0
.end method

.method public getData()Ljava/util/List;
    .locals 1
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "()",
            "Ljava/util/List",
            "<TT;>;"
        }
    .end annotation

    .prologue
    .line 55
    .local p0, "this":Lcom/cyjh/elfin/adpter/CYJHAdapter;, "Lcom/cyjh/elfin/adpter/CYJHAdapter<TT;>;"
    iget-object v0, p0, Lcom/cyjh/elfin/adpter/CYJHAdapter;->mData:Ljava/util/List;

    return-object v0
.end method

.method public getItem(I)Ljava/lang/Object;
    .locals 1
    .param p1, "position"    # I
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "(I)TT;"
        }
    .end annotation

    .prologue
    .line 48
    .local p0, "this":Lcom/cyjh/elfin/adpter/CYJHAdapter;, "Lcom/cyjh/elfin/adpter/CYJHAdapter<TT;>;"
    iget-object v0, p0, Lcom/cyjh/elfin/adpter/CYJHAdapter;->mData:Ljava/util/List;

    if-nez v0, :cond_0

    .line 49
    const/4 v0, 0x0

    .line 51
    :goto_0
    return-object v0

    :cond_0
    iget-object v0, p0, Lcom/cyjh/elfin/adpter/CYJHAdapter;->mData:Ljava/util/List;

    invoke-interface {v0, p1}, Ljava/util/List;->get(I)Ljava/lang/Object;

    move-result-object v0

    goto :goto_0
.end method

.method public notifyDataSetChanged(Ljava/util/List;)V
    .locals 0
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "(",
            "Ljava/util/List",
            "<TT;>;)V"
        }
    .end annotation

    .prologue
    .line 123
    .local p0, "this":Lcom/cyjh/elfin/adpter/CYJHAdapter;, "Lcom/cyjh/elfin/adpter/CYJHAdapter<TT;>;"
    .local p1, "data":Ljava/util/List;, "Ljava/util/List<TT;>;"
    if-nez p1, :cond_0

    .line 124
    new-instance p1, Ljava/util/ArrayList;

    .end local p1    # "data":Ljava/util/List;, "Ljava/util/List<TT;>;"
    invoke-direct {p1}, Ljava/util/ArrayList;-><init>()V

    .line 126
    .restart local p1    # "data":Ljava/util/List;, "Ljava/util/List<TT;>;"
    :cond_0
    iput-object p1, p0, Lcom/cyjh/elfin/adpter/CYJHAdapter;->mData:Ljava/util/List;

    .line 127
    invoke-virtual {p0}, Lcom/cyjh/elfin/adpter/CYJHAdapter;->notifyDataSetChanged()V

    .line 128
    return-void
.end method

.method public prependBatchDataNotifyDataSetChanged(Ljava/util/List;)V
    .locals 2
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "(",
            "Ljava/util/List",
            "<TT;>;)V"
        }
    .end annotation

    .prologue
    .line 101
    .local p0, "this":Lcom/cyjh/elfin/adpter/CYJHAdapter;, "Lcom/cyjh/elfin/adpter/CYJHAdapter<TT;>;"
    .local p1, "ts":Ljava/util/List;, "Ljava/util/List<TT;>;"
    iget-object v0, p0, Lcom/cyjh/elfin/adpter/CYJHAdapter;->mData:Ljava/util/List;

    if-nez v0, :cond_0

    .line 102
    new-instance v0, Ljava/util/ArrayList;

    invoke-direct {v0}, Ljava/util/ArrayList;-><init>()V

    iput-object v0, p0, Lcom/cyjh/elfin/adpter/CYJHAdapter;->mData:Ljava/util/List;

    .line 104
    :cond_0
    if-eqz p1, :cond_1

    invoke-interface {p1}, Ljava/util/List;->isEmpty()Z

    move-result v0

    if-nez v0, :cond_1

    .line 105
    iget-object v0, p0, Lcom/cyjh/elfin/adpter/CYJHAdapter;->mData:Ljava/util/List;

    const/4 v1, 0x0

    invoke-interface {v0, v1, p1}, Ljava/util/List;->addAll(ILjava/util/Collection;)Z

    .line 106
    invoke-virtual {p0}, Lcom/cyjh/elfin/adpter/CYJHAdapter;->notifyDataSetChanged()V

    .line 108
    :cond_1
    return-void
.end method

.method public prependDataNotifyDataSetChanged(Ljava/lang/Object;)V
    .locals 2
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "(TT;)V"
        }
    .end annotation

    .prologue
    .line 90
    .local p0, "this":Lcom/cyjh/elfin/adpter/CYJHAdapter;, "Lcom/cyjh/elfin/adpter/CYJHAdapter<TT;>;"
    .local p1, "t":Ljava/lang/Object;, "TT;"
    iget-object v0, p0, Lcom/cyjh/elfin/adpter/CYJHAdapter;->mData:Ljava/util/List;

    if-nez v0, :cond_0

    .line 91
    new-instance v0, Ljava/util/ArrayList;

    invoke-direct {v0}, Ljava/util/ArrayList;-><init>()V

    iput-object v0, p0, Lcom/cyjh/elfin/adpter/CYJHAdapter;->mData:Ljava/util/List;

    .line 93
    :cond_0
    if-eqz p1, :cond_1

    .line 94
    iget-object v0, p0, Lcom/cyjh/elfin/adpter/CYJHAdapter;->mData:Ljava/util/List;

    const/4 v1, 0x0

    invoke-interface {v0, v1, p1}, Ljava/util/List;->add(ILjava/lang/Object;)V

    .line 95
    invoke-virtual {p0}, Lcom/cyjh/elfin/adpter/CYJHAdapter;->notifyDataSetChanged()V

    .line 97
    :cond_1
    return-void
.end method

.method public removeData(I)V
    .locals 1
    .param p1, "position"    # I

    .prologue
    .line 59
    .local p0, "this":Lcom/cyjh/elfin/adpter/CYJHAdapter;, "Lcom/cyjh/elfin/adpter/CYJHAdapter<TT;>;"
    iget-object v0, p0, Lcom/cyjh/elfin/adpter/CYJHAdapter;->mData:Ljava/util/List;

    if-eqz v0, :cond_0

    iget-object v0, p0, Lcom/cyjh/elfin/adpter/CYJHAdapter;->mData:Ljava/util/List;

    invoke-interface {v0}, Ljava/util/List;->isEmpty()Z

    move-result v0

    if-nez v0, :cond_0

    .line 60
    iget-object v0, p0, Lcom/cyjh/elfin/adpter/CYJHAdapter;->mData:Ljava/util/List;

    invoke-interface {v0, p1}, Ljava/util/List;->remove(I)Ljava/lang/Object;

    .line 61
    invoke-virtual {p0}, Lcom/cyjh/elfin/adpter/CYJHAdapter;->notifyDataSetChanged()V

    .line 63
    :cond_0
    return-void
.end method

.method public setData(Ljava/util/List;)V
    .locals 1
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "(",
            "Ljava/util/List",
            "<TT;>;)V"
        }
    .end annotation

    .prologue
    .line 32
    .local p0, "this":Lcom/cyjh/elfin/adpter/CYJHAdapter;, "Lcom/cyjh/elfin/adpter/CYJHAdapter<TT;>;"
    .local p1, "list":Ljava/util/List;, "Ljava/util/List<TT;>;"
    if-eqz p1, :cond_0

    invoke-interface {p1}, Ljava/util/List;->size()I

    move-result v0

    if-lez v0, :cond_0

    .line 33
    iput-object p1, p0, Lcom/cyjh/elfin/adpter/CYJHAdapter;->mData:Ljava/util/List;

    .line 35
    :cond_0
    return-void
.end method
