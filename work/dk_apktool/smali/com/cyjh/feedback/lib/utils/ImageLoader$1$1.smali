.class Lcom/cyjh/feedback/lib/utils/ImageLoader$1$1;
.super Landroid/os/Handler;
.source "ImageLoader.java"


# annotations
.annotation system Ldalvik/annotation/EnclosingMethod;
    value = Lcom/cyjh/feedback/lib/utils/ImageLoader$1;->run()V
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x0
    name = null
.end annotation


# instance fields
.field final synthetic this$1:Lcom/cyjh/feedback/lib/utils/ImageLoader$1;


# direct methods
.method constructor <init>(Lcom/cyjh/feedback/lib/utils/ImageLoader$1;)V
    .locals 0
    .param p1, "this$1"    # Lcom/cyjh/feedback/lib/utils/ImageLoader$1;

    .prologue
    .line 94
    iput-object p1, p0, Lcom/cyjh/feedback/lib/utils/ImageLoader$1$1;->this$1:Lcom/cyjh/feedback/lib/utils/ImageLoader$1;

    invoke-direct {p0}, Landroid/os/Handler;-><init>()V

    return-void
.end method


# virtual methods
.method public handleMessage(Landroid/os/Message;)V
    .locals 3
    .param p1, "msg"    # Landroid/os/Message;

    .prologue
    .line 97
    iget-object v1, p0, Lcom/cyjh/feedback/lib/utils/ImageLoader$1$1;->this$1:Lcom/cyjh/feedback/lib/utils/ImageLoader$1;

    iget-object v1, v1, Lcom/cyjh/feedback/lib/utils/ImageLoader$1;->this$0:Lcom/cyjh/feedback/lib/utils/ImageLoader;

    invoke-static {v1}, Lcom/cyjh/feedback/lib/utils/ImageLoader;->access$200(Lcom/cyjh/feedback/lib/utils/ImageLoader;)Ljava/util/concurrent/ExecutorService;

    move-result-object v1

    iget-object v2, p0, Lcom/cyjh/feedback/lib/utils/ImageLoader$1$1;->this$1:Lcom/cyjh/feedback/lib/utils/ImageLoader$1;

    iget-object v2, v2, Lcom/cyjh/feedback/lib/utils/ImageLoader$1;->this$0:Lcom/cyjh/feedback/lib/utils/ImageLoader;

    invoke-static {v2}, Lcom/cyjh/feedback/lib/utils/ImageLoader;->access$100(Lcom/cyjh/feedback/lib/utils/ImageLoader;)Ljava/lang/Runnable;

    move-result-object v2

    invoke-interface {v1, v2}, Ljava/util/concurrent/ExecutorService;->execute(Ljava/lang/Runnable;)V

    .line 102
    :try_start_0
    iget-object v1, p0, Lcom/cyjh/feedback/lib/utils/ImageLoader$1$1;->this$1:Lcom/cyjh/feedback/lib/utils/ImageLoader$1;

    iget-object v1, v1, Lcom/cyjh/feedback/lib/utils/ImageLoader$1;->this$0:Lcom/cyjh/feedback/lib/utils/ImageLoader;

    invoke-static {v1}, Lcom/cyjh/feedback/lib/utils/ImageLoader;->access$300(Lcom/cyjh/feedback/lib/utils/ImageLoader;)Ljava/util/concurrent/Semaphore;

    move-result-object v1

    invoke-virtual {v1}, Ljava/util/concurrent/Semaphore;->acquire()V
    :try_end_0
    .catch Ljava/lang/InterruptedException; {:try_start_0 .. :try_end_0} :catch_0

    .line 106
    :goto_0
    return-void

    .line 103
    :catch_0
    move-exception v0

    .line 104
    .local v0, "e":Ljava/lang/InterruptedException;
    invoke-virtual {v0}, Ljava/lang/InterruptedException;->printStackTrace()V

    goto :goto_0
.end method
