.class Lcom/cyjh/mobileanjian/ipc/IpcService$2;
.super Ljava/lang/Thread;
.source "SourceFile"


# annotations
.annotation system Ldalvik/annotation/EnclosingMethod;
    value = Lcom/cyjh/mobileanjian/ipc/IpcService;->f()V
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
    .line 230
    iput-object p1, p0, Lcom/cyjh/mobileanjian/ipc/IpcService$2;->a:Lcom/cyjh/mobileanjian/ipc/IpcService;

    invoke-direct {p0, p2}, Ljava/lang/Thread;-><init>(Ljava/lang/String;)V

    return-void
.end method


# virtual methods
.method public run()V
    .locals 1

    .prologue
    .line 234
    invoke-super {p0}, Ljava/lang/Thread;->run()V

    .line 235
    iget-object v0, p0, Lcom/cyjh/mobileanjian/ipc/IpcService$2;->a:Lcom/cyjh/mobileanjian/ipc/IpcService;

    invoke-static {v0}, Lcom/cyjh/mobileanjian/ipc/IpcService;->c(Lcom/cyjh/mobileanjian/ipc/IpcService;)V

    .line 236
    iget-object v0, p0, Lcom/cyjh/mobileanjian/ipc/IpcService$2;->a:Lcom/cyjh/mobileanjian/ipc/IpcService;

    invoke-static {v0}, Lcom/cyjh/mobileanjian/ipc/IpcService;->d(Lcom/cyjh/mobileanjian/ipc/IpcService;)V

    .line 237
    iget-object v0, p0, Lcom/cyjh/mobileanjian/ipc/IpcService$2;->a:Lcom/cyjh/mobileanjian/ipc/IpcService;

    invoke-static {v0}, Lcom/cyjh/mobileanjian/ipc/IpcService;->e(Lcom/cyjh/mobileanjian/ipc/IpcService;)V

    .line 239
    return-void
.end method
