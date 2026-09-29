.class public Lcom/lidroid/xutils/cache/KeyExpiryMap;
.super Ljava/util/concurrent/ConcurrentHashMap;
.source "SourceFile"


# annotations
.annotation system Ldalvik/annotation/Signature;
    value = {
        "<K:",
        "Ljava/lang/Object;",
        "V:",
        "Ljava/lang/Object;",
        ">",
        "Ljava/util/concurrent/ConcurrentHashMap",
        "<TK;",
        "Ljava/lang/Long;",
        ">;"
    }
.end annotation


# static fields
.field private static final DEFAULT_CONCURRENCY_LEVEL:I = 0x10

.field private static final serialVersionUID:J = 0x1L


# direct methods
.method public constructor <init>()V
    .locals 0

    .prologue
    .line 47
    invoke-direct {p0}, Ljava/util/concurrent/ConcurrentHashMap;-><init>()V

    .line 48
    return-void
.end method

.method public constructor <init>(I)V
    .locals 0

    .prologue
    .line 43
    invoke-direct {p0, p1}, Ljava/util/concurrent/ConcurrentHashMap;-><init>(I)V

    .line 44
    return-void
.end method

.method public constructor <init>(IF)V
    .locals 1

    .prologue
    .line 39
    const/16 v0, 0x10

    invoke-direct {p0, p1, p2, v0}, Ljava/util/concurrent/ConcurrentHashMap;-><init>(IFI)V

    .line 40
    return-void
.end method

.method public constructor <init>(IFI)V
    .locals 0

    .prologue
    .line 35
    invoke-direct {p0, p1, p2, p3}, Ljava/util/concurrent/ConcurrentHashMap;-><init>(IFI)V

    .line 36
    return-void
.end method


# virtual methods
.method public declared-synchronized clear()V
    .locals 1

    .prologue
    .line 86
    monitor-enter p0

    :try_start_0
    invoke-super {p0}, Ljava/util/concurrent/ConcurrentHashMap;->clear()V
    :try_end_0
    .catchall {:try_start_0 .. :try_end_0} :catchall_0

    .line 87
    monitor-exit p0

    return-void

    .line 86
    :catchall_0
    move-exception v0

    monitor-exit p0

    throw v0
.end method

.method public declared-synchronized containsKey(Ljava/lang/Object;)Z
    .locals 6

    .prologue
    .line 69
    monitor-enter p0

    const/4 v1, 0x0

    .line 70
    :try_start_0
    invoke-super {p0, p1}, Ljava/util/concurrent/ConcurrentHashMap;->get(Ljava/lang/Object;)Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Ljava/lang/Long;

    .line 71
    if-eqz v0, :cond_0

    invoke-static {}, Ljava/lang/System;->currentTimeMillis()J

    move-result-wide v2

    invoke-virtual {v0}, Ljava/lang/Long;->longValue()J
    :try_end_0
    .catchall {:try_start_0 .. :try_end_0} :catchall_0

    move-result-wide v4

    cmp-long v0, v2, v4

    if-gez v0, :cond_0

    .line 72
    const/4 v0, 0x1

    .line 76
    :goto_0
    monitor-exit p0

    return v0

    .line 74
    :cond_0
    :try_start_1
    invoke-virtual {p0, p1}, Lcom/lidroid/xutils/cache/KeyExpiryMap;->remove(Ljava/lang/Object;)Ljava/lang/Long;
    :try_end_1
    .catchall {:try_start_1 .. :try_end_1} :catchall_0

    move v0, v1

    goto :goto_0

    .line 69
    :catchall_0
    move-exception v0

    monitor-exit p0

    throw v0
.end method

.method public declared-synchronized get(Ljava/lang/Object;)Ljava/lang/Long;
    .locals 1

    .prologue
    .line 52
    monitor-enter p0

    :try_start_0
    invoke-virtual {p0, p1}, Lcom/lidroid/xutils/cache/KeyExpiryMap;->containsKey(Ljava/lang/Object;)Z

    move-result v0

    if-eqz v0, :cond_0

    .line 53
    invoke-super {p0, p1}, Ljava/util/concurrent/ConcurrentHashMap;->get(Ljava/lang/Object;)Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Ljava/lang/Long;
    :try_end_0
    .catchall {:try_start_0 .. :try_end_0} :catchall_0

    .line 55
    :goto_0
    monitor-exit p0

    return-object v0

    :cond_0
    const/4 v0, 0x0

    goto :goto_0

    .line 52
    :catchall_0
    move-exception v0

    monitor-exit p0

    throw v0
.end method

.method public bridge synthetic get(Ljava/lang/Object;)Ljava/lang/Object;
    .locals 1

    .prologue
    .line 1
    invoke-virtual {p0, p1}, Lcom/lidroid/xutils/cache/KeyExpiryMap;->get(Ljava/lang/Object;)Ljava/lang/Long;

    move-result-object v0

    return-object v0
.end method

.method public declared-synchronized put(Ljava/lang/Object;Ljava/lang/Long;)Ljava/lang/Long;
    .locals 1
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "(TK;",
            "Ljava/lang/Long;",
            ")",
            "Ljava/lang/Long;"
        }
    .end annotation

    .prologue
    .line 61
    monitor-enter p0

    :try_start_0
    invoke-virtual {p0, p1}, Lcom/lidroid/xutils/cache/KeyExpiryMap;->containsKey(Ljava/lang/Object;)Z

    move-result v0

    if-eqz v0, :cond_0

    .line 62
    invoke-virtual {p0, p1}, Lcom/lidroid/xutils/cache/KeyExpiryMap;->remove(Ljava/lang/Object;)Ljava/lang/Long;

    .line 64
    :cond_0
    invoke-super {p0, p1, p2}, Ljava/util/concurrent/ConcurrentHashMap;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Ljava/lang/Long;
    :try_end_0
    .catchall {:try_start_0 .. :try_end_0} :catchall_0

    monitor-exit p0

    return-object v0

    .line 61
    :catchall_0
    move-exception v0

    monitor-exit p0

    throw v0
.end method

.method public bridge synthetic put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;
    .locals 1

    .prologue
    .line 1
    check-cast p1, Ljava/lang/Object;

    check-cast p2, Ljava/lang/Long;

    invoke-virtual {p0, p1, p2}, Lcom/lidroid/xutils/cache/KeyExpiryMap;->put(Ljava/lang/Object;Ljava/lang/Long;)Ljava/lang/Long;

    move-result-object v0

    return-object v0
.end method

.method public declared-synchronized remove(Ljava/lang/Object;)Ljava/lang/Long;
    .locals 1

    .prologue
    .line 81
    monitor-enter p0

    :try_start_0
    invoke-super {p0, p1}, Ljava/util/concurrent/ConcurrentHashMap;->remove(Ljava/lang/Object;)Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Ljava/lang/Long;
    :try_end_0
    .catchall {:try_start_0 .. :try_end_0} :catchall_0

    monitor-exit p0

    return-object v0

    :catchall_0
    move-exception v0

    monitor-exit p0

    throw v0
.end method

.method public bridge synthetic remove(Ljava/lang/Object;)Ljava/lang/Object;
    .locals 1

    .prologue
    .line 1
    invoke-virtual {p0, p1}, Lcom/lidroid/xutils/cache/KeyExpiryMap;->remove(Ljava/lang/Object;)Ljava/lang/Long;

    move-result-object v0

    return-object v0
.end method
