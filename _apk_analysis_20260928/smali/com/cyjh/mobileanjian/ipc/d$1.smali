.class Lcom/cyjh/mobileanjian/ipc/d$1;
.super Ljava/lang/Thread;
.source "SourceFile"


# annotations
.annotation system Ldalvik/annotation/EnclosingClass;
    value = Lcom/cyjh/mobileanjian/ipc/d;
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x0
    name = null
.end annotation


# instance fields
.field final synthetic a:Lcom/cyjh/mobileanjian/ipc/d;


# direct methods
.method constructor <init>(Lcom/cyjh/mobileanjian/ipc/d;Ljava/lang/String;)V
    .locals 0

    .prologue
    .line 64
    iput-object p1, p0, Lcom/cyjh/mobileanjian/ipc/d$1;->a:Lcom/cyjh/mobileanjian/ipc/d;

    invoke-direct {p0, p2}, Ljava/lang/Thread;-><init>(Ljava/lang/String;)V

    return-void
.end method


# virtual methods
.method public run()V
    .locals 2

    .prologue
    .line 68
    invoke-super {p0}, Ljava/lang/Thread;->run()V

    .line 69
    :goto_0
    iget-object v0, p0, Lcom/cyjh/mobileanjian/ipc/d$1;->a:Lcom/cyjh/mobileanjian/ipc/d;

    invoke-static {v0}, Lcom/cyjh/mobileanjian/ipc/d;->a(Lcom/cyjh/mobileanjian/ipc/d;)Z

    move-result v0

    if-eqz v0, :cond_0

    .line 74
    :try_start_0
    iget-object v0, p0, Lcom/cyjh/mobileanjian/ipc/d$1;->a:Lcom/cyjh/mobileanjian/ipc/d;

    invoke-static {v0}, Lcom/cyjh/mobileanjian/ipc/d;->b(Lcom/cyjh/mobileanjian/ipc/d;)Ljava/util/concurrent/ArrayBlockingQueue;

    move-result-object v0

    invoke-virtual {v0}, Ljava/util/concurrent/ArrayBlockingQueue;->take()Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$IpcMessage;

    .line 75
    new-instance v1, Lcom/cyjh/mobileanjian/ipc/share/proto/c;

    invoke-direct {v1, v0}, Lcom/cyjh/mobileanjian/ipc/share/proto/c;-><init>(Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$IpcMessage;)V

    .line 76
    iget-object v0, p0, Lcom/cyjh/mobileanjian/ipc/d$1;->a:Lcom/cyjh/mobileanjian/ipc/d;

    invoke-virtual {v1}, Lcom/cyjh/mobileanjian/ipc/share/proto/c;->b()Ljava/nio/ByteBuffer;

    move-result-object v1

    invoke-virtual {v0, v1}, Lcom/cyjh/mobileanjian/ipc/d;->a(Ljava/nio/ByteBuffer;)V
    :try_end_0
    .catch Ljava/lang/InterruptedException; {:try_start_0 .. :try_end_0} :catch_0

    goto :goto_0

    .line 77
    :catch_0
    move-exception v0

    .line 79
    invoke-virtual {v0}, Ljava/lang/InterruptedException;->printStackTrace()V

    goto :goto_0

    .line 82
    :cond_0
    return-void
.end method
