.class Lcom/cyjh/mobileanjian/ipc/i$1;
.super Landroid/os/Handler;
.source "SourceFile"


# annotations
.annotation system Ldalvik/annotation/EnclosingMethod;
    value = Lcom/cyjh/mobileanjian/ipc/i;-><init>()V
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x0
    name = null
.end annotation


# instance fields
.field final synthetic a:Lcom/cyjh/mobileanjian/ipc/i;


# direct methods
.method constructor <init>(Lcom/cyjh/mobileanjian/ipc/i;Landroid/os/Looper;)V
    .locals 0

    .prologue
    .line 45
    iput-object p1, p0, Lcom/cyjh/mobileanjian/ipc/i$1;->a:Lcom/cyjh/mobileanjian/ipc/i;

    invoke-direct {p0, p2}, Landroid/os/Handler;-><init>(Landroid/os/Looper;)V

    return-void
.end method


# virtual methods
.method public handleMessage(Landroid/os/Message;)V
    .locals 3

    .prologue
    .line 49
    invoke-static {}, Lcom/cyjh/mobileanjian/ipc/h;->f()Lcom/cyjh/mobileanjian/ipc/interfaces/RootProgressListener;

    move-result-object v0

    if-eqz v0, :cond_0

    .line 51
    invoke-static {}, Lcom/cyjh/mobileanjian/ipc/h;->f()Lcom/cyjh/mobileanjian/ipc/interfaces/RootProgressListener;

    move-result-object v1

    iget-object v0, p1, Landroid/os/Message;->obj:Ljava/lang/Object;

    check-cast v0, Ljava/lang/String;

    iget v2, p1, Landroid/os/Message;->what:I

    invoke-interface {v1, v0, v2}, Lcom/cyjh/mobileanjian/ipc/interfaces/RootProgressListener;->onRootProgress(Ljava/lang/String;I)V

    .line 53
    :cond_0
    return-void
.end method
