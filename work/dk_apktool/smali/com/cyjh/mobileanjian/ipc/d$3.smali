.class Lcom/cyjh/mobileanjian/ipc/d$3;
.super Ljava/lang/Object;
.source "SourceFile"

# interfaces
.implements Ljava/lang/Runnable;


# annotations
.annotation system Ldalvik/annotation/EnclosingMethod;
    value = Lcom/cyjh/mobileanjian/ipc/d;->p()V
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x0
    name = null
.end annotation


# instance fields
.field final synthetic a:Lcom/cyjh/mobileanjian/ipc/d;


# direct methods
.method constructor <init>(Lcom/cyjh/mobileanjian/ipc/d;)V
    .locals 0

    .prologue
    .line 344
    iput-object p1, p0, Lcom/cyjh/mobileanjian/ipc/d$3;->a:Lcom/cyjh/mobileanjian/ipc/d;

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method


# virtual methods
.method public run()V
    .locals 3

    .prologue
    .line 348
    iget-object v0, p0, Lcom/cyjh/mobileanjian/ipc/d$3;->a:Lcom/cyjh/mobileanjian/ipc/d;

    invoke-static {v0}, Lcom/cyjh/mobileanjian/ipc/d;->d(Lcom/cyjh/mobileanjian/ipc/d;)Lcom/cyjh/mobileanjian/ipc/interfaces/OnScriptListener;

    move-result-object v0

    if-eqz v0, :cond_0

    .line 350
    iget-object v0, p0, Lcom/cyjh/mobileanjian/ipc/d$3;->a:Lcom/cyjh/mobileanjian/ipc/d;

    invoke-static {v0}, Lcom/cyjh/mobileanjian/ipc/d;->d(Lcom/cyjh/mobileanjian/ipc/d;)Lcom/cyjh/mobileanjian/ipc/interfaces/OnScriptListener;

    move-result-object v0

    const/16 v1, 0x3ea

    const-string v2, "root\u8fdb\u7a0b\u5f02\u5e38\u7ec8\u6b62"

    invoke-interface {v0, v1, v2}, Lcom/cyjh/mobileanjian/ipc/interfaces/OnScriptListener;->onStopScript(ILjava/lang/String;)V

    .line 352
    :cond_0
    iget-object v0, p0, Lcom/cyjh/mobileanjian/ipc/d$3;->a:Lcom/cyjh/mobileanjian/ipc/d;

    invoke-static {v0}, Lcom/cyjh/mobileanjian/ipc/d;->e(Lcom/cyjh/mobileanjian/ipc/d;)Landroid/content/Context;

    move-result-object v0

    sget v1, Lcom/cyjh/rootipc/R$string;->toast_engine_crash_then_restart:I

    const/16 v2, 0x7d0

    invoke-static {v0, v1, v2}, Lcom/cyjh/mobileanjian/ipc/view/ExToast;->makeText(Landroid/content/Context;II)Lcom/cyjh/mobileanjian/ipc/view/ExToast;

    move-result-object v0

    invoke-virtual {v0}, Lcom/cyjh/mobileanjian/ipc/view/ExToast;->show()V

    .line 353
    return-void
.end method
