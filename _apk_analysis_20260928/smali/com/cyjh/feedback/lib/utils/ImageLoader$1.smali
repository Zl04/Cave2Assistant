.class Lcom/cyjh/feedback/lib/utils/ImageLoader$1;
.super Ljava/lang/Thread;
.source "ImageLoader.java"


# annotations
.annotation system Ldalvik/annotation/EnclosingMethod;
    value = Lcom/cyjh/feedback/lib/utils/ImageLoader;->init(Lcom/cyjh/feedback/lib/utils/ImageLoader$Type;I)V
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x0
    name = null
.end annotation


# instance fields
.field final synthetic this$0:Lcom/cyjh/feedback/lib/utils/ImageLoader;


# direct methods
.method constructor <init>(Lcom/cyjh/feedback/lib/utils/ImageLoader;)V
    .locals 0
    .param p1, "this$0"    # Lcom/cyjh/feedback/lib/utils/ImageLoader;

    .prologue
    .line 89
    iput-object p1, p0, Lcom/cyjh/feedback/lib/utils/ImageLoader$1;->this$0:Lcom/cyjh/feedback/lib/utils/ImageLoader;

    invoke-direct {p0}, Ljava/lang/Thread;-><init>()V

    return-void
.end method


# virtual methods
.method public run()V
    .locals 2

    .prologue
    .line 92
    invoke-super {p0}, Ljava/lang/Thread;->run()V

    .line 93
    invoke-static {}, Landroid/os/Looper;->prepare()V

    .line 94
    iget-object v0, p0, Lcom/cyjh/feedback/lib/utils/ImageLoader$1;->this$0:Lcom/cyjh/feedback/lib/utils/ImageLoader;

    new-instance v1, Lcom/cyjh/feedback/lib/utils/ImageLoader$1$1;

    invoke-direct {v1, p0}, Lcom/cyjh/feedback/lib/utils/ImageLoader$1$1;-><init>(Lcom/cyjh/feedback/lib/utils/ImageLoader$1;)V

    invoke-static {v0, v1}, Lcom/cyjh/feedback/lib/utils/ImageLoader;->access$002(Lcom/cyjh/feedback/lib/utils/ImageLoader;Landroid/os/Handler;)Landroid/os/Handler;

    .line 109
    iget-object v0, p0, Lcom/cyjh/feedback/lib/utils/ImageLoader$1;->this$0:Lcom/cyjh/feedback/lib/utils/ImageLoader;

    invoke-static {v0}, Lcom/cyjh/feedback/lib/utils/ImageLoader;->access$400(Lcom/cyjh/feedback/lib/utils/ImageLoader;)Ljava/util/concurrent/Semaphore;

    move-result-object v0

    invoke-virtual {v0}, Ljava/util/concurrent/Semaphore;->release()V

    .line 110
    invoke-static {}, Landroid/os/Looper;->loop()V

    .line 111
    return-void
.end method
