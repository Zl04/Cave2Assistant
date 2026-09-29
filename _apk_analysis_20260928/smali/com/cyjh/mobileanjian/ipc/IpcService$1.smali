.class Lcom/cyjh/mobileanjian/ipc/IpcService$1;
.super Landroid/os/HandlerThread;
.source "SourceFile"


# annotations
.annotation system Ldalvik/annotation/EnclosingMethod;
    value = Lcom/cyjh/mobileanjian/ipc/IpcService;->e()V
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x0
    name = null
.end annotation


# instance fields
.field final synthetic a:Lcom/cyjh/mobileanjian/ipc/IpcService;


# direct methods
.method constructor <init>(Lcom/cyjh/mobileanjian/ipc/IpcService;Ljava/lang/String;)V
    .locals 0

    .prologue
    .line 211
    iput-object p1, p0, Lcom/cyjh/mobileanjian/ipc/IpcService$1;->a:Lcom/cyjh/mobileanjian/ipc/IpcService;

    invoke-direct {p0, p2}, Landroid/os/HandlerThread;-><init>(Ljava/lang/String;)V

    return-void
.end method


# virtual methods
.method protected onLooperPrepared()V
    .locals 3

    .prologue
    .line 215
    invoke-super {p0}, Landroid/os/HandlerThread;->onLooperPrepared()V

    .line 216
    const-string v0, "ipc server thread begin..."

    invoke-static {v0}, Lcom/cyjh/mobileanjian/ipc/utils/CLog;->d(Ljava/lang/String;)V

    .line 217
    new-instance v0, Lcom/cyjh/mobileanjian/ipc/e;

    iget-object v1, p0, Lcom/cyjh/mobileanjian/ipc/IpcService$1;->a:Lcom/cyjh/mobileanjian/ipc/IpcService;

    invoke-direct {v0, v1}, Lcom/cyjh/mobileanjian/ipc/e;-><init>(Landroid/content/Context;)V

    .line 218
    invoke-static {}, Lcom/cyjh/mobileanjian/ipc/MqRunner;->getInstance()Lcom/cyjh/mobileanjian/ipc/MqRunner;

    move-result-object v1

    invoke-virtual {v0, v1}, Lcom/cyjh/mobileanjian/ipc/e;->a(Lcom/cyjh/mobileanjian/ipc/interfaces/EngineStateObserver;)V

    .line 219
    iget-object v1, p0, Lcom/cyjh/mobileanjian/ipc/IpcService$1;->a:Lcom/cyjh/mobileanjian/ipc/IpcService;

    invoke-static {v1}, Lcom/cyjh/mobileanjian/ipc/IpcService;->a(Lcom/cyjh/mobileanjian/ipc/IpcService;)Ljava/lang/String;

    move-result-object v1

    iget-object v2, p0, Lcom/cyjh/mobileanjian/ipc/IpcService$1;->a:Lcom/cyjh/mobileanjian/ipc/IpcService;

    invoke-static {v2}, Lcom/cyjh/mobileanjian/ipc/IpcService;->b(Lcom/cyjh/mobileanjian/ipc/IpcService;)I

    move-result v2

    invoke-virtual {v0, v1, v2}, Lcom/cyjh/mobileanjian/ipc/e;->a(Ljava/lang/String;I)V

    .line 220
    return-void
.end method
