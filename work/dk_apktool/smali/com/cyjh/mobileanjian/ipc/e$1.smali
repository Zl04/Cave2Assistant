.class Lcom/cyjh/mobileanjian/ipc/e$1;
.super Landroid/os/HandlerThread;
.source "SourceFile"


# annotations
.annotation system Ldalvik/annotation/EnclosingMethod;
    value = Lcom/cyjh/mobileanjian/ipc/e;->a(Ljava/lang/String;I)V
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x0
    name = null
.end annotation


# instance fields
.field final synthetic a:Lcom/cyjh/mobileanjian/ipc/e;


# direct methods
.method constructor <init>(Lcom/cyjh/mobileanjian/ipc/e;Ljava/lang/String;)V
    .locals 0

    .prologue
    .line 72
    iput-object p1, p0, Lcom/cyjh/mobileanjian/ipc/e$1;->a:Lcom/cyjh/mobileanjian/ipc/e;

    invoke-direct {p0, p2}, Landroid/os/HandlerThread;-><init>(Ljava/lang/String;)V

    return-void
.end method


# virtual methods
.method protected onLooperPrepared()V
    .locals 4

    .prologue
    .line 76
    invoke-super {p0}, Landroid/os/HandlerThread;->onLooperPrepared()V

    .line 79
    :goto_0
    :try_start_0
    iget-object v0, p0, Lcom/cyjh/mobileanjian/ipc/e$1;->a:Lcom/cyjh/mobileanjian/ipc/e;

    invoke-static {v0}, Lcom/cyjh/mobileanjian/ipc/e;->a(Lcom/cyjh/mobileanjian/ipc/e;)Z

    move-result v0

    if-nez v0, :cond_1

    .line 81
    iget-object v0, p0, Lcom/cyjh/mobileanjian/ipc/e$1;->a:Lcom/cyjh/mobileanjian/ipc/e;

    invoke-static {v0}, Lcom/cyjh/mobileanjian/ipc/e;->b(Lcom/cyjh/mobileanjian/ipc/e;)Ljava/net/ServerSocket;

    move-result-object v0

    invoke-virtual {v0}, Ljava/net/ServerSocket;->accept()Ljava/net/Socket;

    move-result-object v0

    .line 82
    const-string v1, "a client connected to app!"

    invoke-static {v1}, Lcom/cyjh/mobileanjian/ipc/utils/CLog;->i(Ljava/lang/String;)V

    .line 83
    iget-object v1, p0, Lcom/cyjh/mobileanjian/ipc/e$1;->a:Lcom/cyjh/mobileanjian/ipc/e;

    invoke-static {v1}, Lcom/cyjh/mobileanjian/ipc/e;->c(Lcom/cyjh/mobileanjian/ipc/e;)Lcom/cyjh/mobileanjian/ipc/d;

    move-result-object v1

    if-eqz v1, :cond_0

    iget-object v1, p0, Lcom/cyjh/mobileanjian/ipc/e$1;->a:Lcom/cyjh/mobileanjian/ipc/e;

    invoke-static {v1}, Lcom/cyjh/mobileanjian/ipc/e;->c(Lcom/cyjh/mobileanjian/ipc/e;)Lcom/cyjh/mobileanjian/ipc/d;

    move-result-object v1

    invoke-virtual {v1}, Lcom/cyjh/mobileanjian/ipc/d;->b()Z

    move-result v1

    if-eqz v1, :cond_0

    .line 84
    invoke-virtual {v0}, Ljava/net/Socket;->close()V
    :try_end_0
    .catch Ljava/io/IOException; {:try_start_0 .. :try_end_0} :catch_0

    goto :goto_0

    .line 95
    :catch_0
    move-exception v0

    .line 97
    invoke-virtual {v0}, Ljava/io/IOException;->printStackTrace()V

    .line 99
    :goto_1
    return-void

    .line 87
    :cond_0
    :try_start_1
    iget-object v1, p0, Lcom/cyjh/mobileanjian/ipc/e$1;->a:Lcom/cyjh/mobileanjian/ipc/e;

    new-instance v2, Lcom/cyjh/mobileanjian/ipc/d;

    iget-object v3, p0, Lcom/cyjh/mobileanjian/ipc/e$1;->a:Lcom/cyjh/mobileanjian/ipc/e;

    invoke-static {v3}, Lcom/cyjh/mobileanjian/ipc/e;->d(Lcom/cyjh/mobileanjian/ipc/e;)Landroid/content/Context;

    move-result-object v3

    invoke-direct {v2, v3, v0}, Lcom/cyjh/mobileanjian/ipc/d;-><init>(Landroid/content/Context;Ljava/net/Socket;)V

    invoke-static {v1, v2}, Lcom/cyjh/mobileanjian/ipc/e;->a(Lcom/cyjh/mobileanjian/ipc/e;Lcom/cyjh/mobileanjian/ipc/d;)Lcom/cyjh/mobileanjian/ipc/d;

    .line 88
    iget-object v0, p0, Lcom/cyjh/mobileanjian/ipc/e$1;->a:Lcom/cyjh/mobileanjian/ipc/e;

    invoke-static {v0}, Lcom/cyjh/mobileanjian/ipc/e;->c(Lcom/cyjh/mobileanjian/ipc/e;)Lcom/cyjh/mobileanjian/ipc/d;

    move-result-object v0

    iget-object v1, p0, Lcom/cyjh/mobileanjian/ipc/e$1;->a:Lcom/cyjh/mobileanjian/ipc/e;

    invoke-static {v1}, Lcom/cyjh/mobileanjian/ipc/e;->e(Lcom/cyjh/mobileanjian/ipc/e;)Ljava/util/List;

    move-result-object v1

    invoke-virtual {v0, v1}, Lcom/cyjh/mobileanjian/ipc/d;->a(Ljava/util/List;)V

    .line 90
    iget-object v0, p0, Lcom/cyjh/mobileanjian/ipc/e$1;->a:Lcom/cyjh/mobileanjian/ipc/e;

    invoke-static {v0}, Lcom/cyjh/mobileanjian/ipc/e;->c(Lcom/cyjh/mobileanjian/ipc/e;)Lcom/cyjh/mobileanjian/ipc/d;

    move-result-object v0

    invoke-virtual {v0}, Lcom/cyjh/mobileanjian/ipc/d;->d()V

    goto :goto_0

    .line 93
    :cond_1
    iget-object v0, p0, Lcom/cyjh/mobileanjian/ipc/e$1;->a:Lcom/cyjh/mobileanjian/ipc/e;

    invoke-static {v0}, Lcom/cyjh/mobileanjian/ipc/e;->b(Lcom/cyjh/mobileanjian/ipc/e;)Ljava/net/ServerSocket;

    move-result-object v0

    invoke-virtual {v0}, Ljava/net/ServerSocket;->close()V
    :try_end_1
    .catch Ljava/io/IOException; {:try_start_1 .. :try_end_1} :catch_0

    goto :goto_1
.end method
