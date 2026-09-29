.class Lcom/cyjh/mobileanjian/ipc/MqRunner$1;
.super Landroid/os/Handler;
.source "SourceFile"


# annotations
.annotation system Ldalvik/annotation/EnclosingMethod;
    value = Lcom/cyjh/mobileanjian/ipc/MqRunner;-><init>()V
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x0
    name = null
.end annotation


# instance fields
.field final synthetic a:Lcom/cyjh/mobileanjian/ipc/MqRunner;


# direct methods
.method constructor <init>(Lcom/cyjh/mobileanjian/ipc/MqRunner;Landroid/os/Looper;)V
    .locals 0

    .prologue
    .line 48
    iput-object p1, p0, Lcom/cyjh/mobileanjian/ipc/MqRunner$1;->a:Lcom/cyjh/mobileanjian/ipc/MqRunner;

    invoke-direct {p0, p2}, Landroid/os/Handler;-><init>(Landroid/os/Looper;)V

    return-void
.end method


# virtual methods
.method public handleMessage(Landroid/os/Message;)V
    .locals 5

    .prologue
    const/4 v4, 0x0

    .line 52
    invoke-super {p0, p1}, Landroid/os/Handler;->handleMessage(Landroid/os/Message;)V

    .line 53
    iget v0, p1, Landroid/os/Message;->what:I

    const/16 v1, 0x100

    if-ne v0, v1, :cond_1

    .line 55
    iget-object v0, p0, Lcom/cyjh/mobileanjian/ipc/MqRunner$1;->a:Lcom/cyjh/mobileanjian/ipc/MqRunner;

    invoke-static {v0, v4}, Lcom/cyjh/mobileanjian/ipc/MqRunner;->a(Lcom/cyjh/mobileanjian/ipc/MqRunner;Z)Z

    .line 66
    :cond_0
    :goto_0
    return-void

    .line 58
    :cond_1
    invoke-static {}, Lcom/cyjh/mobileanjian/ipc/h;->f()Lcom/cyjh/mobileanjian/ipc/interfaces/RootProgressListener;

    move-result-object v0

    if-eqz v0, :cond_0

    .line 60
    iget v0, p1, Landroid/os/Message;->what:I

    const/4 v1, 0x4

    if-ne v0, v1, :cond_2

    .line 61
    invoke-static {}, Lcom/cyjh/mobileanjian/ipc/h;->b()Landroid/content/Context;

    move-result-object v0

    .line 62
    invoke-static {}, Lcom/cyjh/mobileanjian/ipc/h;->a()Landroid/app/Application;

    move-result-object v1

    sget v2, Lcom/cyjh/rootipc/R$string;->toast_failed_got_root:I

    invoke-virtual {v1, v2}, Landroid/app/Application;->getString(I)Ljava/lang/String;

    move-result-object v1

    const/4 v2, 0x1

    new-array v2, v2, [Ljava/lang/Object;

    invoke-static {}, Lcom/cyjh/mobileanjian/ipc/log/b;->a()Lcom/cyjh/mobileanjian/ipc/log/b;

    move-result-object v3

    iget-object v3, v3, Lcom/cyjh/mobileanjian/ipc/log/b;->h:Ljava/lang/String;

    aput-object v3, v2, v4

    invoke-static {v1, v2}, Ljava/lang/String;->format(Ljava/lang/String;[Ljava/lang/Object;)Ljava/lang/String;

    move-result-object v1

    const/16 v2, 0xdac

    .line 61
    invoke-static {v0, v1, v2}, Lcom/cyjh/mobileanjian/ipc/view/ExToast;->makeText(Landroid/content/Context;Ljava/lang/CharSequence;I)Lcom/cyjh/mobileanjian/ipc/view/ExToast;

    move-result-object v0

    .line 63
    invoke-virtual {v0}, Lcom/cyjh/mobileanjian/ipc/view/ExToast;->show()V

    .line 64
    :cond_2
    invoke-static {}, Lcom/cyjh/mobileanjian/ipc/h;->f()Lcom/cyjh/mobileanjian/ipc/interfaces/RootProgressListener;

    move-result-object v1

    iget-object v0, p1, Landroid/os/Message;->obj:Ljava/lang/Object;

    check-cast v0, Ljava/lang/String;

    iget v2, p1, Landroid/os/Message;->what:I

    invoke-interface {v1, v0, v2}, Lcom/cyjh/mobileanjian/ipc/interfaces/RootProgressListener;->onRootProgress(Ljava/lang/String;I)V

    goto :goto_0
.end method
