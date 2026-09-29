.class public Lcom/cyjh/feedback/lib/runnable/TraversePicRunnable;
.super Ljava/lang/Object;
.source "TraversePicRunnable.java"

# interfaces
.implements Ljava/lang/Runnable;


# instance fields
.field private mAddList:Ljava/util/List;
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "Ljava/util/List",
            "<",
            "Ljava/lang/String;",
            ">;"
        }
    .end annotation
.end field

.field private mContext:Landroid/content/Context;

.field private mHandler:Landroid/os/Handler;


# direct methods
.method public constructor <init>(Landroid/content/Context;Landroid/os/Handler;Ljava/util/List;)V
    .locals 0
    .param p1, "context"    # Landroid/content/Context;
    .param p2, "handler"    # Landroid/os/Handler;
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "(",
            "Landroid/content/Context;",
            "Landroid/os/Handler;",
            "Ljava/util/List",
            "<",
            "Ljava/lang/String;",
            ">;)V"
        }
    .end annotation

    .prologue
    .line 27
    .local p3, "addList":Ljava/util/List;, "Ljava/util/List<Ljava/lang/String;>;"
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    .line 28
    iput-object p1, p0, Lcom/cyjh/feedback/lib/runnable/TraversePicRunnable;->mContext:Landroid/content/Context;

    .line 29
    iput-object p2, p0, Lcom/cyjh/feedback/lib/runnable/TraversePicRunnable;->mHandler:Landroid/os/Handler;

    .line 30
    iput-object p3, p0, Lcom/cyjh/feedback/lib/runnable/TraversePicRunnable;->mAddList:Ljava/util/List;

    .line 31
    return-void
.end method


# virtual methods
.method public run()V
    .locals 9

    .prologue
    const/4 v8, 0x0

    .line 35
    new-instance v1, Lcom/cyjh/feedback/lib/entities/PicDataBean;

    invoke-direct {v1}, Lcom/cyjh/feedback/lib/entities/PicDataBean;-><init>()V

    .line 36
    .local v1, "mPicDataBean":Lcom/cyjh/feedback/lib/entities/PicDataBean;
    new-instance v3, Ljava/util/ArrayList;

    invoke-direct {v3}, Ljava/util/ArrayList;-><init>()V

    .line 38
    .local v3, "mPicList":Ljava/util/List;, "Ljava/util/List<Lcom/cyjh/feedback/lib/entities/PicPathBean;>;"
    iget-object v6, p0, Lcom/cyjh/feedback/lib/runnable/TraversePicRunnable;->mAddList:Ljava/util/List;

    if-eqz v6, :cond_0

    iget-object v6, p0, Lcom/cyjh/feedback/lib/runnable/TraversePicRunnable;->mAddList:Ljava/util/List;

    invoke-interface {v6}, Ljava/util/List;->size()I

    move-result v6

    if-lez v6, :cond_0

    .line 39
    iget-object v6, p0, Lcom/cyjh/feedback/lib/runnable/TraversePicRunnable;->mAddList:Ljava/util/List;

    invoke-interface {v6}, Ljava/util/List;->iterator()Ljava/util/Iterator;

    move-result-object v6

    :goto_0
    invoke-interface {v6}, Ljava/util/Iterator;->hasNext()Z

    move-result v7

    if-eqz v7, :cond_1

    invoke-interface {v6}, Ljava/util/Iterator;->next()Ljava/lang/Object;

    move-result-object v5

    check-cast v5, Ljava/lang/String;

    .line 40
    .local v5, "path":Ljava/lang/String;
    iget-object v7, p0, Lcom/cyjh/feedback/lib/runnable/TraversePicRunnable;->mContext:Landroid/content/Context;

    invoke-static {v7, v5}, Lcom/cyjh/feedback/lib/utils/ImageReaderLoacl;->img2Base64(Landroid/content/Context;Ljava/lang/String;)Ljava/lang/String;

    move-result-object v0

    .line 41
    .local v0, "imgBase64":Ljava/lang/String;
    new-instance v2, Lcom/cyjh/feedback/lib/entities/PicPathBean;

    invoke-direct {v2}, Lcom/cyjh/feedback/lib/entities/PicPathBean;-><init>()V

    .line 42
    .local v2, "mPicInfoBean":Lcom/cyjh/feedback/lib/entities/PicPathBean;
    invoke-virtual {v2, v0}, Lcom/cyjh/feedback/lib/entities/PicPathBean;->setImage(Ljava/lang/String;)V

    .line 43
    invoke-interface {v3, v2}, Ljava/util/List;->add(Ljava/lang/Object;)Z

    goto :goto_0

    .line 46
    .end local v0    # "imgBase64":Ljava/lang/String;
    .end local v2    # "mPicInfoBean":Lcom/cyjh/feedback/lib/entities/PicPathBean;
    .end local v5    # "path":Ljava/lang/String;
    :cond_0
    new-instance v2, Lcom/cyjh/feedback/lib/entities/PicPathBean;

    invoke-direct {v2}, Lcom/cyjh/feedback/lib/entities/PicPathBean;-><init>()V

    .line 47
    .restart local v2    # "mPicInfoBean":Lcom/cyjh/feedback/lib/entities/PicPathBean;
    invoke-static {v8}, Ljava/lang/String;->valueOf(I)Ljava/lang/String;

    move-result-object v6

    invoke-virtual {v2, v6}, Lcom/cyjh/feedback/lib/entities/PicPathBean;->setImage(Ljava/lang/String;)V

    .line 48
    invoke-interface {v3, v2}, Ljava/util/List;->add(Ljava/lang/Object;)Z

    .line 50
    .end local v2    # "mPicInfoBean":Lcom/cyjh/feedback/lib/entities/PicPathBean;
    :cond_1
    invoke-virtual {v1, v3}, Lcom/cyjh/feedback/lib/entities/PicDataBean;->setRdata(Ljava/util/List;)V

    .line 51
    iget-object v6, p0, Lcom/cyjh/feedback/lib/runnable/TraversePicRunnable;->mHandler:Landroid/os/Handler;

    invoke-virtual {v6}, Landroid/os/Handler;->obtainMessage()Landroid/os/Message;

    move-result-object v4

    .line 52
    .local v4, "message":Landroid/os/Message;
    iput-object v1, v4, Landroid/os/Message;->obj:Ljava/lang/Object;

    .line 53
    iput v8, v4, Landroid/os/Message;->what:I

    .line 54
    iget-object v6, p0, Lcom/cyjh/feedback/lib/runnable/TraversePicRunnable;->mHandler:Landroid/os/Handler;

    invoke-virtual {v6, v4}, Landroid/os/Handler;->sendMessage(Landroid/os/Message;)Z

    .line 55
    return-void
.end method
