.class public Lcom/lidroid/xutils/task/PriorityRunnable;
.super Lcom/lidroid/xutils/task/PriorityObject;
.source "SourceFile"

# interfaces
.implements Ljava/lang/Runnable;


# annotations
.annotation system Ldalvik/annotation/Signature;
    value = {
        "Lcom/lidroid/xutils/task/PriorityObject",
        "<",
        "Ljava/lang/Runnable;",
        ">;",
        "Ljava/lang/Runnable;"
    }
.end annotation


# direct methods
.method public constructor <init>(Lcom/lidroid/xutils/task/Priority;Ljava/lang/Runnable;)V
    .locals 0

    .prologue
    .line 11
    invoke-direct {p0, p1, p2}, Lcom/lidroid/xutils/task/PriorityObject;-><init>(Lcom/lidroid/xutils/task/Priority;Ljava/lang/Object;)V

    .line 12
    return-void
.end method


# virtual methods
.method public run()V
    .locals 1

    .prologue
    .line 16
    iget-object v0, p0, Lcom/lidroid/xutils/task/PriorityRunnable;->obj:Ljava/lang/Object;

    check-cast v0, Ljava/lang/Runnable;

    invoke-interface {v0}, Ljava/lang/Runnable;->run()V

    .line 17
    return-void
.end method
