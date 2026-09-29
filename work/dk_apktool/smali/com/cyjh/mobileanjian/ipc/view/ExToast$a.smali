.class Lcom/cyjh/mobileanjian/ipc/view/ExToast$a;
.super Ljava/util/TimerTask;
.source "SourceFile"


# annotations
.annotation system Ldalvik/annotation/EnclosingClass;
    value = Lcom/cyjh/mobileanjian/ipc/view/ExToast;
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x2
    name = "a"
.end annotation


# instance fields
.field final synthetic a:Lcom/cyjh/mobileanjian/ipc/view/ExToast;


# direct methods
.method private constructor <init>(Lcom/cyjh/mobileanjian/ipc/view/ExToast;)V
    .locals 0

    .prologue
    .line 100
    iput-object p1, p0, Lcom/cyjh/mobileanjian/ipc/view/ExToast$a;->a:Lcom/cyjh/mobileanjian/ipc/view/ExToast;

    invoke-direct {p0}, Ljava/util/TimerTask;-><init>()V

    return-void
.end method

.method synthetic constructor <init>(Lcom/cyjh/mobileanjian/ipc/view/ExToast;Lcom/cyjh/mobileanjian/ipc/view/ExToast$1;)V
    .locals 0

    .prologue
    .line 100
    invoke-direct {p0, p1}, Lcom/cyjh/mobileanjian/ipc/view/ExToast$a;-><init>(Lcom/cyjh/mobileanjian/ipc/view/ExToast;)V

    return-void
.end method


# virtual methods
.method public run()V
    .locals 1

    .prologue
    .line 105
    iget-object v0, p0, Lcom/cyjh/mobileanjian/ipc/view/ExToast$a;->a:Lcom/cyjh/mobileanjian/ipc/view/ExToast;

    invoke-virtual {v0}, Lcom/cyjh/mobileanjian/ipc/view/ExToast;->hide()V

    .line 106
    return-void
.end method
