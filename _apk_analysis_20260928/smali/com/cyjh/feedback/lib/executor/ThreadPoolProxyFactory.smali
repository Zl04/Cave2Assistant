.class public Lcom/cyjh/feedback/lib/executor/ThreadPoolProxyFactory;
.super Ljava/lang/Object;
.source "ThreadPoolProxyFactory.java"


# static fields
.field private static sNormalThreadPool:Lcom/cyjh/feedback/lib/executor/ThreadPoolProxy;


# direct methods
.method public constructor <init>()V
    .locals 0

    .prologue
    .line 10
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method

.method public static getNormalThreadPool()Lcom/cyjh/feedback/lib/executor/ThreadPoolProxy;
    .locals 2

    .prologue
    .line 13
    sget-object v0, Lcom/cyjh/feedback/lib/executor/ThreadPoolProxyFactory;->sNormalThreadPool:Lcom/cyjh/feedback/lib/executor/ThreadPoolProxy;

    if-nez v0, :cond_1

    .line 14
    const-class v1, Lcom/cyjh/feedback/lib/executor/ThreadPoolProxyFactory;

    monitor-enter v1

    .line 15
    :try_start_0
    sget-object v0, Lcom/cyjh/feedback/lib/executor/ThreadPoolProxyFactory;->sNormalThreadPool:Lcom/cyjh/feedback/lib/executor/ThreadPoolProxy;

    if-nez v0, :cond_0

    .line 16
    new-instance v0, Lcom/cyjh/feedback/lib/executor/ThreadPoolProxy;

    invoke-direct {v0}, Lcom/cyjh/feedback/lib/executor/ThreadPoolProxy;-><init>()V

    sput-object v0, Lcom/cyjh/feedback/lib/executor/ThreadPoolProxyFactory;->sNormalThreadPool:Lcom/cyjh/feedback/lib/executor/ThreadPoolProxy;

    .line 18
    :cond_0
    monitor-exit v1
    :try_end_0
    .catchall {:try_start_0 .. :try_end_0} :catchall_0

    .line 20
    :cond_1
    sget-object v0, Lcom/cyjh/feedback/lib/executor/ThreadPoolProxyFactory;->sNormalThreadPool:Lcom/cyjh/feedback/lib/executor/ThreadPoolProxy;

    return-object v0

    .line 18
    :catchall_0
    move-exception v0

    :try_start_1
    monitor-exit v1
    :try_end_1
    .catchall {:try_start_1 .. :try_end_1} :catchall_0

    throw v0
.end method
