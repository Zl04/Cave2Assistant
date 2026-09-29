.class Lcom/cyjh/mobileanjian/ipc/i$2;
.super Ljava/lang/Object;
.source "SourceFile"

# interfaces
.implements Ljava/lang/Runnable;


# annotations
.annotation system Ldalvik/annotation/EnclosingMethod;
    value = Lcom/cyjh/mobileanjian/ipc/i;->d()V
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x0
    name = null
.end annotation


# instance fields
.field final synthetic a:Lcom/cyjh/mobileanjian/ipc/i;


# direct methods
.method constructor <init>(Lcom/cyjh/mobileanjian/ipc/i;)V
    .locals 0

    .prologue
    .line 125
    iput-object p1, p0, Lcom/cyjh/mobileanjian/ipc/i$2;->a:Lcom/cyjh/mobileanjian/ipc/i;

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method


# virtual methods
.method public run()V
    .locals 3

    .prologue
    .line 129
    invoke-static {}, Lcom/cyjh/mobileanjian/ipc/h;->b()Landroid/content/Context;

    move-result-object v0

    sget v1, Lcom/cyjh/rootipc/R$string;->toast_script_engine_failed_start:I

    invoke-virtual {v0, v1}, Landroid/content/Context;->getString(I)Ljava/lang/String;

    move-result-object v0

    .line 130
    invoke-static {}, Lcom/cyjh/mobileanjian/ipc/h;->b()Landroid/content/Context;

    move-result-object v1

    const/16 v2, 0xdac

    invoke-static {v1, v0, v2}, Lcom/cyjh/mobileanjian/ipc/view/ExToast;->makeText(Landroid/content/Context;Ljava/lang/CharSequence;I)Lcom/cyjh/mobileanjian/ipc/view/ExToast;

    move-result-object v0

    invoke-virtual {v0}, Lcom/cyjh/mobileanjian/ipc/view/ExToast;->show()V

    .line 131
    return-void
.end method
