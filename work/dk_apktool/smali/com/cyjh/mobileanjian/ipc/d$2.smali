.class Lcom/cyjh/mobileanjian/ipc/d$2;
.super Ljava/lang/Thread;
.source "SourceFile"


# annotations
.annotation system Ldalvik/annotation/EnclosingMethod;
    value = Lcom/cyjh/mobileanjian/ipc/d;->n()V
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
    .line 307
    iput-object p1, p0, Lcom/cyjh/mobileanjian/ipc/d$2;->a:Lcom/cyjh/mobileanjian/ipc/d;

    invoke-direct {p0}, Ljava/lang/Thread;-><init>()V

    return-void
.end method


# virtual methods
.method public run()V
    .locals 3

    .prologue
    .line 310
    iget-object v0, p0, Lcom/cyjh/mobileanjian/ipc/d$2;->a:Lcom/cyjh/mobileanjian/ipc/d;

    invoke-static {v0}, Lcom/cyjh/mobileanjian/ipc/d;->c(Lcom/cyjh/mobileanjian/ipc/d;)Ljava/util/List;

    move-result-object v0

    invoke-interface {v0}, Ljava/util/List;->iterator()Ljava/util/Iterator;

    move-result-object v1

    :goto_0
    invoke-interface {v1}, Ljava/util/Iterator;->hasNext()Z

    move-result v0

    if-eqz v0, :cond_0

    invoke-interface {v1}, Ljava/util/Iterator;->next()Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Lcom/cyjh/mobileanjian/ipc/interfaces/EngineStateObserver;

    .line 312
    iget-object v2, p0, Lcom/cyjh/mobileanjian/ipc/d$2;->a:Lcom/cyjh/mobileanjian/ipc/d;

    invoke-interface {v0, v2}, Lcom/cyjh/mobileanjian/ipc/interfaces/EngineStateObserver;->onConnected(Lcom/cyjh/mobileanjian/ipc/d;)V

    goto :goto_0

    .line 314
    :cond_0
    invoke-static {}, Lcom/cyjh/mobileanjian/ipc/h;->g()Lcom/cyjh/mobileanjian/ipc/interfaces/OnEngineStartCallback;

    move-result-object v0

    if-eqz v0, :cond_1

    .line 316
    invoke-static {}, Lcom/cyjh/mobileanjian/ipc/h;->g()Lcom/cyjh/mobileanjian/ipc/interfaces/OnEngineStartCallback;

    move-result-object v0

    invoke-static {}, Lcom/cyjh/mobileanjian/ipc/stuff/b;->t()I

    move-result v1

    invoke-interface {v0, v1}, Lcom/cyjh/mobileanjian/ipc/interfaces/OnEngineStartCallback;->onEngineStart(I)V

    .line 318
    :cond_1
    return-void
.end method
