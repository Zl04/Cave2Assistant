.class public Lcom/cyjh/mobileanjian/ipc/MqBridge;
.super Ljava/lang/Object;
.source "SourceFile"


# direct methods
.method public constructor <init>()V
    .locals 0

    .prologue
    .line 16
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method

.method public static exit()V
    .locals 3

    .prologue
    .line 44
    invoke-static {}, Lcom/cyjh/mobileanjian/ipc/h;->b()Landroid/content/Context;

    move-result-object v0

    .line 45
    new-instance v1, Landroid/content/Intent;

    const-class v2, Lcom/cyjh/mobileanjian/ipc/IpcService;

    invoke-direct {v1, v0, v2}, Landroid/content/Intent;-><init>(Landroid/content/Context;Ljava/lang/Class;)V

    .line 46
    invoke-virtual {v0, v1}, Landroid/content/Context;->stopService(Landroid/content/Intent;)Z

    .line 47
    return-void
.end method

.method public static init(Landroid/app/Application;Lcom/cyjh/mobileanjian/ipc/interfaces/OnKeyEventListener;Lcom/cyjh/mobileanjian/ipc/interfaces/RootProgressListener;Lcom/cyjh/mobileanjian/ipc/interfaces/OnEngineStartCallback;)V
    .locals 2

    .prologue
    const/4 v1, 0x0

    .line 26
    invoke-static {p0, p1, p2, p3}, Lcom/cyjh/mobileanjian/ipc/h;->a(Landroid/app/Application;Lcom/cyjh/mobileanjian/ipc/interfaces/OnKeyEventListener;Lcom/cyjh/mobileanjian/ipc/interfaces/RootProgressListener;Lcom/cyjh/mobileanjian/ipc/interfaces/OnEngineStartCallback;)V

    .line 27
    const/4 v0, 0x1

    invoke-static {p0, v0, v1, v1}, Lcom/cyjh/mobileanjian/ipc/log/b;->a(Landroid/content/Context;ZLjava/lang/String;Ljava/lang/String;)V

    .line 28
    return-void
.end method

.method public static init(Landroid/app/Application;ZLjava/lang/String;Ljava/lang/String;Lcom/cyjh/mobileanjian/ipc/interfaces/OnKeyEventListener;)V
    .locals 1

    .prologue
    const/4 v0, 0x0

    .line 39
    invoke-static {p0, p4, v0, v0}, Lcom/cyjh/mobileanjian/ipc/h;->a(Landroid/app/Application;Lcom/cyjh/mobileanjian/ipc/interfaces/OnKeyEventListener;Lcom/cyjh/mobileanjian/ipc/interfaces/RootProgressListener;Lcom/cyjh/mobileanjian/ipc/interfaces/OnEngineStartCallback;)V

    .line 40
    invoke-static {p0, p1, p2, p3}, Lcom/cyjh/mobileanjian/ipc/log/b;->a(Landroid/content/Context;ZLjava/lang/String;Ljava/lang/String;)V

    .line 41
    return-void
.end method
