.class public Lcom/lidroid/xutils/cache/LruMemoryCache;
.super Ljava/lang/Object;
.source "SourceFile"


# annotations
.annotation system Ldalvik/annotation/Signature;
    value = {
        "<K:",
        "Ljava/lang/Object;",
        "V:",
        "Ljava/lang/Object;",
        ">",
        "Ljava/lang/Object;"
    }
.end annotation


# instance fields
.field private createCount:I

.field private evictionCount:I

.field private hitCount:I

.field private keyExpiryMap:Lcom/lidroid/xutils/cache/KeyExpiryMap;
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "Lcom/lidroid/xutils/cache/KeyExpiryMap",
            "<TK;",
            "Ljava/lang/Long;",
            ">;"
        }
    .end annotation
.end field

.field private final map:Ljava/util/LinkedHashMap;
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "Ljava/util/LinkedHashMap",
            "<TK;TV;>;"
        }
    .end annotation
.end field

.field private maxSize:I

.field private missCount:I

.field private putCount:I

.field private size:I


# direct methods
.method public constructor <init>(I)V
    .locals 4

    .prologue
    const/4 v3, 0x0

    const/high16 v2, 0x3f400000    # 0.75f

    .line 47
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    .line 48
    if-gtz p1, :cond_0

    .line 49
    new-instance v0, Ljava/lang/IllegalArgumentException;

    const-string v1, "maxSize <= 0"

    invoke-direct {v0, v1}, Ljava/lang/IllegalArgumentException;-><init>(Ljava/lang/String;)V

    throw v0

    .line 51
    :cond_0
    iput p1, p0, Lcom/lidroid/xutils/cache/LruMemoryCache;->maxSize:I

    .line 52
    new-instance v0, Ljava/util/LinkedHashMap;

    const/4 v1, 0x1

    invoke-direct {v0, v3, v2, v1}, Ljava/util/LinkedHashMap;-><init>(IFZ)V

    iput-object v0, p0, Lcom/lidroid/xutils/cache/LruMemoryCache;->map:Ljava/util/LinkedHashMap;

    .line 53
    new-instance v0, Lcom/lidroid/xutils/cache/KeyExpiryMap;

    invoke-direct {v0, v3, v2}, Lcom/lidroid/xutils/cache/KeyExpiryMap;-><init>(IF)V

    iput-object v0, p0, Lcom/lidroid/xutils/cache/LruMemoryCache;->keyExpiryMap:Lcom/lidroid/xutils/cache/KeyExpiryMap;

    .line 54
    return-void
.end method

.method private safeSizeOf(Ljava/lang/Object;Ljava/lang/Object;)I
    .locals 5
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "(TK;TV;)I"
        }
    .end annotation

    .prologue
    .line 255
    invoke-virtual {p0, p1, p2}, Lcom/lidroid/xutils/cache/LruMemoryCache;->sizeOf(Ljava/lang/Object;Ljava/lang/Object;)I

    move-result v1

    .line 256
    if-gtz v1, :cond_0

    .line 257
    const/4 v0, 0x0

    iput v0, p0, Lcom/lidroid/xutils/cache/LruMemoryCache;->size:I

    .line 258
    iget-object v0, p0, Lcom/lidroid/xutils/cache/LruMemoryCache;->map:Ljava/util/LinkedHashMap;

    invoke-virtual {v0}, Ljava/util/LinkedHashMap;->entrySet()Ljava/util/Set;

    move-result-object v0

    invoke-interface {v0}, Ljava/util/Set;->iterator()Ljava/util/Iterator;

    move-result-object v2

    :goto_0
    invoke-interface {v2}, Ljava/util/Iterator;->hasNext()Z

    move-result v0

    if-nez v0, :cond_1

    .line 262
    :cond_0
    return v1

    .line 258
    :cond_1
    invoke-interface {v2}, Ljava/util/Iterator;->next()Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Ljava/util/Map$Entry;

    .line 259
    iget v3, p0, Lcom/lidroid/xutils/cache/LruMemoryCache;->size:I

    invoke-interface {v0}, Ljava/util/Map$Entry;->getKey()Ljava/lang/Object;

    move-result-object v4

    invoke-interface {v0}, Ljava/util/Map$Entry;->getValue()Ljava/lang/Object;

    move-result-object v0

    invoke-virtual {p0, v4, v0}, Lcom/lidroid/xutils/cache/LruMemoryCache;->sizeOf(Ljava/lang/Object;Ljava/lang/Object;)I

    move-result v0

    add-int/2addr v0, v3

    iput v0, p0, Lcom/lidroid/xutils/cache/LruMemoryCache;->size:I

    goto :goto_0
.end method

.method private trimToSize(I)V
    .locals 4

    .prologue
    .line 169
    :goto_0
    monitor-enter p0

    .line 170
    :try_start_0
    iget v0, p0, Lcom/lidroid/xutils/cache/LruMemoryCache;->size:I

    if-le v0, p1, :cond_0

    iget-object v0, p0, Lcom/lidroid/xutils/cache/LruMemoryCache;->map:Ljava/util/LinkedHashMap;

    invoke-virtual {v0}, Ljava/util/LinkedHashMap;->isEmpty()Z

    move-result v0

    if-eqz v0, :cond_1

    .line 171
    :cond_0
    monitor-exit p0

    .line 185
    return-void

    .line 174
    :cond_1
    iget-object v0, p0, Lcom/lidroid/xutils/cache/LruMemoryCache;->map:Ljava/util/LinkedHashMap;

    invoke-virtual {v0}, Ljava/util/LinkedHashMap;->entrySet()Ljava/util/Set;

    move-result-object v0

    invoke-interface {v0}, Ljava/util/Set;->iterator()Ljava/util/Iterator;

    move-result-object v0

    invoke-interface {v0}, Ljava/util/Iterator;->next()Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Ljava/util/Map$Entry;

    .line 175
    invoke-interface {v0}, Ljava/util/Map$Entry;->getKey()Ljava/lang/Object;

    move-result-object v1

    .line 176
    invoke-interface {v0}, Ljava/util/Map$Entry;->getValue()Ljava/lang/Object;

    move-result-object v0

    .line 177
    iget-object v2, p0, Lcom/lidroid/xutils/cache/LruMemoryCache;->map:Ljava/util/LinkedHashMap;

    invoke-virtual {v2, v1}, Ljava/util/LinkedHashMap;->remove(Ljava/lang/Object;)Ljava/lang/Object;

    .line 178
    iget-object v2, p0, Lcom/lidroid/xutils/cache/LruMemoryCache;->keyExpiryMap:Lcom/lidroid/xutils/cache/KeyExpiryMap;

    invoke-virtual {v2, v1}, Lcom/lidroid/xutils/cache/KeyExpiryMap;->remove(Ljava/lang/Object;)Ljava/lang/Long;

    .line 179
    iget v2, p0, Lcom/lidroid/xutils/cache/LruMemoryCache;->size:I

    invoke-direct {p0, v1, v0}, Lcom/lidroid/xutils/cache/LruMemoryCache;->safeSizeOf(Ljava/lang/Object;Ljava/lang/Object;)I

    move-result v3

    sub-int/2addr v2, v3

    iput v2, p0, Lcom/lidroid/xutils/cache/LruMemoryCache;->size:I

    .line 180
    iget v2, p0, Lcom/lidroid/xutils/cache/LruMemoryCache;->evictionCount:I

    add-int/lit8 v2, v2, 0x1

    iput v2, p0, Lcom/lidroid/xutils/cache/LruMemoryCache;->evictionCount:I

    .line 169
    monitor-exit p0
    :try_end_0
    .catchall {:try_start_0 .. :try_end_0} :catchall_0

    .line 183
    const/4 v2, 0x1

    const/4 v3, 0x0

    invoke-virtual {p0, v2, v1, v0, v3}, Lcom/lidroid/xutils/cache/LruMemoryCache;->entryRemoved(ZLjava/lang/Object;Ljava/lang/Object;Ljava/lang/Object;)V

    goto :goto_0

    .line 169
    :catchall_0
    move-exception v0

    :try_start_1
    monitor-exit p0
    :try_end_1
    .catchall {:try_start_1 .. :try_end_1} :catchall_0

    throw v0
.end method


# virtual methods
.method public final containsKey(Ljava/lang/Object;)Z
    .locals 1
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "(TK;)Z"
        }
    .end annotation

    .prologue
    .line 214
    iget-object v0, p0, Lcom/lidroid/xutils/cache/LruMemoryCache;->map:Ljava/util/LinkedHashMap;

    invoke-virtual {v0, p1}, Ljava/util/LinkedHashMap;->containsKey(Ljava/lang/Object;)Z

    move-result v0

    return v0
.end method

.method protected create(Ljava/lang/Object;)Ljava/lang/Object;
    .locals 1
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "(TK;)TV;"
        }
    .end annotation

    .prologue
    .line 251
    const/4 v0, 0x0

    return-object v0
.end method

.method public final declared-synchronized createCount()I
    .locals 1

    .prologue
    .line 321
    monitor-enter p0

    :try_start_0
    iget v0, p0, Lcom/lidroid/xutils/cache/LruMemoryCache;->createCount:I
    :try_end_0
    .catchall {:try_start_0 .. :try_end_0} :catchall_0

    monitor-exit p0

    return v0

    :catchall_0
    move-exception v0

    monitor-exit p0

    throw v0
.end method

.method protected entryRemoved(ZLjava/lang/Object;Ljava/lang/Object;Ljava/lang/Object;)V
    .locals 0
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "(ZTK;TV;TV;)V"
        }
    .end annotation

    .prologue
    .line 233
    return-void
.end method

.method public final evictAll()V
    .locals 1

    .prologue
    .line 280
    const/4 v0, -0x1

    invoke-direct {p0, v0}, Lcom/lidroid/xutils/cache/LruMemoryCache;->trimToSize(I)V

    .line 281
    iget-object v0, p0, Lcom/lidroid/xutils/cache/LruMemoryCache;->keyExpiryMap:Lcom/lidroid/xutils/cache/KeyExpiryMap;

    invoke-virtual {v0}, Lcom/lidroid/xutils/cache/KeyExpiryMap;->clear()V

    .line 282
    return-void
.end method

.method public final declared-synchronized evictionCount()I
    .locals 1

    .prologue
    .line 335
    monitor-enter p0

    :try_start_0
    iget v0, p0, Lcom/lidroid/xutils/cache/LruMemoryCache;->evictionCount:I
    :try_end_0
    .catchall {:try_start_0 .. :try_end_0} :catchall_0

    monitor-exit p0

    return v0

    :catchall_0
    move-exception v0

    monitor-exit p0

    throw v0
.end method

.method public final get(Ljava/lang/Object;)Ljava/lang/Object;
    .locals 4
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "(TK;)TV;"
        }
    .end annotation

    .prologue
    const/4 v0, 0x0

    .line 68
    if-nez p1, :cond_0

    .line 69
    new-instance v0, Ljava/lang/NullPointerException;

    const-string v1, "key == null"

    invoke-direct {v0, v1}, Ljava/lang/NullPointerException;-><init>(Ljava/lang/String;)V

    throw v0

    .line 73
    :cond_0
    monitor-enter p0

    .line 75
    :try_start_0
    iget-object v1, p0, Lcom/lidroid/xutils/cache/LruMemoryCache;->keyExpiryMap:Lcom/lidroid/xutils/cache/KeyExpiryMap;

    invoke-virtual {v1, p1}, Lcom/lidroid/xutils/cache/KeyExpiryMap;->containsKey(Ljava/lang/Object;)Z

    move-result v1

    if-nez v1, :cond_2

    .line 76
    invoke-virtual {p0, p1}, Lcom/lidroid/xutils/cache/LruMemoryCache;->remove(Ljava/lang/Object;)Ljava/lang/Object;

    .line 77
    monitor-exit p0

    .line 116
    :cond_1
    :goto_0
    return-object v0

    .line 79
    :cond_2
    iget-object v1, p0, Lcom/lidroid/xutils/cache/LruMemoryCache;->map:Ljava/util/LinkedHashMap;

    invoke-virtual {v1, p1}, Ljava/util/LinkedHashMap;->get(Ljava/lang/Object;)Ljava/lang/Object;

    move-result-object v1

    .line 80
    if-eqz v1, :cond_3

    .line 81
    iget v0, p0, Lcom/lidroid/xutils/cache/LruMemoryCache;->hitCount:I

    add-int/lit8 v0, v0, 0x1

    iput v0, p0, Lcom/lidroid/xutils/cache/LruMemoryCache;->hitCount:I

    .line 82
    monitor-exit p0

    move-object v0, v1

    goto :goto_0

    .line 84
    :cond_3
    iget v1, p0, Lcom/lidroid/xutils/cache/LruMemoryCache;->missCount:I

    add-int/lit8 v1, v1, 0x1

    iput v1, p0, Lcom/lidroid/xutils/cache/LruMemoryCache;->missCount:I

    .line 73
    monitor-exit p0
    :try_end_0
    .catchall {:try_start_0 .. :try_end_0} :catchall_0

    .line 94
    invoke-virtual {p0, p1}, Lcom/lidroid/xutils/cache/LruMemoryCache;->create(Ljava/lang/Object;)Ljava/lang/Object;

    move-result-object v1

    .line 95
    if-eqz v1, :cond_1

    .line 99
    monitor-enter p0

    .line 100
    :try_start_1
    iget v0, p0, Lcom/lidroid/xutils/cache/LruMemoryCache;->createCount:I

    add-int/lit8 v0, v0, 0x1

    iput v0, p0, Lcom/lidroid/xutils/cache/LruMemoryCache;->createCount:I

    .line 101
    iget-object v0, p0, Lcom/lidroid/xutils/cache/LruMemoryCache;->map:Ljava/util/LinkedHashMap;

    invoke-virtual {v0, p1, v1}, Ljava/util/LinkedHashMap;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    move-result-object v0

    .line 103
    if-eqz v0, :cond_4

    .line 105
    iget-object v2, p0, Lcom/lidroid/xutils/cache/LruMemoryCache;->map:Ljava/util/LinkedHashMap;

    invoke-virtual {v2, p1, v0}, Ljava/util/LinkedHashMap;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    .line 99
    :goto_1
    monitor-exit p0
    :try_end_1
    .catchall {:try_start_1 .. :try_end_1} :catchall_1

    .line 111
    if-eqz v0, :cond_5

    .line 112
    const/4 v2, 0x0

    invoke-virtual {p0, v2, p1, v1, v0}, Lcom/lidroid/xutils/cache/LruMemoryCache;->entryRemoved(ZLjava/lang/Object;Ljava/lang/Object;Ljava/lang/Object;)V

    goto :goto_0

    .line 73
    :catchall_0
    move-exception v0

    :try_start_2
    monitor-exit p0
    :try_end_2
    .catchall {:try_start_2 .. :try_end_2} :catchall_0

    throw v0

    .line 107
    :cond_4
    :try_start_3
    iget v2, p0, Lcom/lidroid/xutils/cache/LruMemoryCache;->size:I

    invoke-direct {p0, p1, v1}, Lcom/lidroid/xutils/cache/LruMemoryCache;->safeSizeOf(Ljava/lang/Object;Ljava/lang/Object;)I

    move-result v3

    add-int/2addr v2, v3

    iput v2, p0, Lcom/lidroid/xutils/cache/LruMemoryCache;->size:I

    goto :goto_1

    .line 99
    :catchall_1
    move-exception v0

    monitor-exit p0
    :try_end_3
    .catchall {:try_start_3 .. :try_end_3} :catchall_1

    throw v0

    .line 115
    :cond_5
    iget v0, p0, Lcom/lidroid/xutils/cache/LruMemoryCache;->maxSize:I

    invoke-direct {p0, v0}, Lcom/lidroid/xutils/cache/LruMemoryCache;->trimToSize(I)V

    move-object v0, v1

    .line 116
    goto :goto_0
.end method

.method public final declared-synchronized hitCount()I
    .locals 1

    .prologue
    .line 306
    monitor-enter p0

    :try_start_0
    iget v0, p0, Lcom/lidroid/xutils/cache/LruMemoryCache;->hitCount:I
    :try_end_0
    .catchall {:try_start_0 .. :try_end_0} :catchall_0

    monitor-exit p0

    return v0

    :catchall_0
    move-exception v0

    monitor-exit p0

    throw v0
.end method

.method public final declared-synchronized maxSize()I
    .locals 1

    .prologue
    .line 299
    monitor-enter p0

    :try_start_0
    iget v0, p0, Lcom/lidroid/xutils/cache/LruMemoryCache;->maxSize:I
    :try_end_0
    .catchall {:try_start_0 .. :try_end_0} :catchall_0

    monitor-exit p0

    return v0

    :catchall_0
    move-exception v0

    monitor-exit p0

    throw v0
.end method

.method public final declared-synchronized missCount()I
    .locals 1

    .prologue
    .line 314
    monitor-enter p0

    :try_start_0
    iget v0, p0, Lcom/lidroid/xutils/cache/LruMemoryCache;->missCount:I
    :try_end_0
    .catchall {:try_start_0 .. :try_end_0} :catchall_0

    monitor-exit p0

    return v0

    :catchall_0
    move-exception v0

    monitor-exit p0

    throw v0
.end method

.method public final put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;
    .locals 2
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "(TK;TV;)TV;"
        }
    .end annotation

    .prologue
    .line 128
    const-wide v0, 0x7fffffffffffffffL

    invoke-virtual {p0, p1, p2, v0, v1}, Lcom/lidroid/xutils/cache/LruMemoryCache;->put(Ljava/lang/Object;Ljava/lang/Object;J)Ljava/lang/Object;

    move-result-object v0

    return-object v0
.end method

.method public final put(Ljava/lang/Object;Ljava/lang/Object;J)Ljava/lang/Object;
    .locals 3
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "(TK;TV;J)TV;"
        }
    .end annotation

    .prologue
    .line 138
    if-eqz p1, :cond_0

    if-nez p2, :cond_1

    .line 139
    :cond_0
    new-instance v0, Ljava/lang/NullPointerException;

    const-string v1, "key == null || value == null"

    invoke-direct {v0, v1}, Ljava/lang/NullPointerException;-><init>(Ljava/lang/String;)V

    throw v0

    .line 143
    :cond_1
    monitor-enter p0

    .line 144
    :try_start_0
    iget v0, p0, Lcom/lidroid/xutils/cache/LruMemoryCache;->putCount:I

    add-int/lit8 v0, v0, 0x1

    iput v0, p0, Lcom/lidroid/xutils/cache/LruMemoryCache;->putCount:I

    .line 145
    iget v0, p0, Lcom/lidroid/xutils/cache/LruMemoryCache;->size:I

    invoke-direct {p0, p1, p2}, Lcom/lidroid/xutils/cache/LruMemoryCache;->safeSizeOf(Ljava/lang/Object;Ljava/lang/Object;)I

    move-result v1

    add-int/2addr v0, v1

    iput v0, p0, Lcom/lidroid/xutils/cache/LruMemoryCache;->size:I

    .line 146
    iget-object v0, p0, Lcom/lidroid/xutils/cache/LruMemoryCache;->map:Ljava/util/LinkedHashMap;

    invoke-virtual {v0, p1, p2}, Ljava/util/LinkedHashMap;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    move-result-object v0

    .line 147
    iget-object v1, p0, Lcom/lidroid/xutils/cache/LruMemoryCache;->keyExpiryMap:Lcom/lidroid/xutils/cache/KeyExpiryMap;

    invoke-static {p3, p4}, Ljava/lang/Long;->valueOf(J)Ljava/lang/Long;

    move-result-object v2

    invoke-virtual {v1, p1, v2}, Lcom/lidroid/xutils/cache/KeyExpiryMap;->put(Ljava/lang/Object;Ljava/lang/Long;)Ljava/lang/Long;

    .line 148
    if-eqz v0, :cond_2

    .line 149
    iget v1, p0, Lcom/lidroid/xutils/cache/LruMemoryCache;->size:I

    invoke-direct {p0, p1, v0}, Lcom/lidroid/xutils/cache/LruMemoryCache;->safeSizeOf(Ljava/lang/Object;Ljava/lang/Object;)I

    move-result v2

    sub-int/2addr v1, v2

    iput v1, p0, Lcom/lidroid/xutils/cache/LruMemoryCache;->size:I

    .line 143
    :cond_2
    monitor-exit p0
    :try_end_0
    .catchall {:try_start_0 .. :try_end_0} :catchall_0

    .line 153
    if-eqz v0, :cond_3

    .line 154
    const/4 v1, 0x0

    invoke-virtual {p0, v1, p1, v0, p2}, Lcom/lidroid/xutils/cache/LruMemoryCache;->entryRemoved(ZLjava/lang/Object;Ljava/lang/Object;Ljava/lang/Object;)V

    .line 157
    :cond_3
    iget v1, p0, Lcom/lidroid/xutils/cache/LruMemoryCache;->maxSize:I

    invoke-direct {p0, v1}, Lcom/lidroid/xutils/cache/LruMemoryCache;->trimToSize(I)V

    .line 158
    return-object v0

    .line 143
    :catchall_0
    move-exception v0

    :try_start_1
    monitor-exit p0
    :try_end_1
    .catchall {:try_start_1 .. :try_end_1} :catchall_0

    throw v0
.end method

.method public final declared-synchronized putCount()I
    .locals 1

    .prologue
    .line 328
    monitor-enter p0

    :try_start_0
    iget v0, p0, Lcom/lidroid/xutils/cache/LruMemoryCache;->putCount:I
    :try_end_0
    .catchall {:try_start_0 .. :try_end_0} :catchall_0

    monitor-exit p0

    return v0

    :catchall_0
    move-exception v0

    monitor-exit p0

    throw v0
.end method

.method public final remove(Ljava/lang/Object;)Ljava/lang/Object;
    .locals 3
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "(TK;)TV;"
        }
    .end annotation

    .prologue
    .line 193
    if-nez p1, :cond_0

    .line 194
    new-instance v0, Ljava/lang/NullPointerException;

    const-string v1, "key == null"

    invoke-direct {v0, v1}, Ljava/lang/NullPointerException;-><init>(Ljava/lang/String;)V

    throw v0

    .line 198
    :cond_0
    monitor-enter p0

    .line 199
    :try_start_0
    iget-object v0, p0, Lcom/lidroid/xutils/cache/LruMemoryCache;->map:Ljava/util/LinkedHashMap;

    invoke-virtual {v0, p1}, Ljava/util/LinkedHashMap;->remove(Ljava/lang/Object;)Ljava/lang/Object;

    move-result-object v0

    .line 200
    iget-object v1, p0, Lcom/lidroid/xutils/cache/LruMemoryCache;->keyExpiryMap:Lcom/lidroid/xutils/cache/KeyExpiryMap;

    invoke-virtual {v1, p1}, Lcom/lidroid/xutils/cache/KeyExpiryMap;->remove(Ljava/lang/Object;)Ljava/lang/Long;

    .line 201
    if-eqz v0, :cond_1

    .line 202
    iget v1, p0, Lcom/lidroid/xutils/cache/LruMemoryCache;->size:I

    invoke-direct {p0, p1, v0}, Lcom/lidroid/xutils/cache/LruMemoryCache;->safeSizeOf(Ljava/lang/Object;Ljava/lang/Object;)I

    move-result v2

    sub-int/2addr v1, v2

    iput v1, p0, Lcom/lidroid/xutils/cache/LruMemoryCache;->size:I

    .line 198
    :cond_1
    monitor-exit p0
    :try_end_0
    .catchall {:try_start_0 .. :try_end_0} :catchall_0

    .line 206
    if-eqz v0, :cond_2

    .line 207
    const/4 v1, 0x0

    const/4 v2, 0x0

    invoke-virtual {p0, v1, p1, v0, v2}, Lcom/lidroid/xutils/cache/LruMemoryCache;->entryRemoved(ZLjava/lang/Object;Ljava/lang/Object;Ljava/lang/Object;)V

    .line 210
    :cond_2
    return-object v0

    .line 198
    :catchall_0
    move-exception v0

    :try_start_1
    monitor-exit p0
    :try_end_1
    .catchall {:try_start_1 .. :try_end_1} :catchall_0

    throw v0
.end method

.method public setMaxSize(I)V
    .locals 0

    .prologue
    .line 57
    iput p1, p0, Lcom/lidroid/xutils/cache/LruMemoryCache;->maxSize:I

    .line 58
    invoke-direct {p0, p1}, Lcom/lidroid/xutils/cache/LruMemoryCache;->trimToSize(I)V

    .line 59
    return-void
.end method

.method public final declared-synchronized size()I
    .locals 1

    .prologue
    .line 290
    monitor-enter p0

    :try_start_0
    iget v0, p0, Lcom/lidroid/xutils/cache/LruMemoryCache;->size:I
    :try_end_0
    .catchall {:try_start_0 .. :try_end_0} :catchall_0

    monitor-exit p0

    return v0

    :catchall_0
    move-exception v0

    monitor-exit p0

    throw v0
.end method

.method protected sizeOf(Ljava/lang/Object;Ljava/lang/Object;)I
    .locals 1
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "(TK;TV;)I"
        }
    .end annotation

    .prologue
    .line 273
    const/4 v0, 0x1

    return v0
.end method

.method public final declared-synchronized snapshot()Ljava/util/Map;
    .locals 2
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "()",
            "Ljava/util/Map",
            "<TK;TV;>;"
        }
    .end annotation

    .prologue
    .line 343
    monitor-enter p0

    :try_start_0
    new-instance v0, Ljava/util/LinkedHashMap;

    iget-object v1, p0, Lcom/lidroid/xutils/cache/LruMemoryCache;->map:Ljava/util/LinkedHashMap;

    invoke-direct {v0, v1}, Ljava/util/LinkedHashMap;-><init>(Ljava/util/Map;)V
    :try_end_0
    .catchall {:try_start_0 .. :try_end_0} :catchall_0

    monitor-exit p0

    return-object v0

    :catchall_0
    move-exception v0

    monitor-exit p0

    throw v0
.end method

.method public final declared-synchronized toString()Ljava/lang/String;
    .locals 5

    .prologue
    const/4 v0, 0x0

    .line 347
    monitor-enter p0

    :try_start_0
    iget v1, p0, Lcom/lidroid/xutils/cache/LruMemoryCache;->hitCount:I

    iget v2, p0, Lcom/lidroid/xutils/cache/LruMemoryCache;->missCount:I

    add-int/2addr v1, v2

    .line 348
    if-eqz v1, :cond_0

    iget v0, p0, Lcom/lidroid/xutils/cache/LruMemoryCache;->hitCount:I

    mul-int/lit8 v0, v0, 0x64

    div-int/2addr v0, v1

    .line 349
    :cond_0
    const-string v1, "LruMemoryCache[maxSize=%d,hits=%d,misses=%d,hitRate=%d%%]"

    const/4 v2, 0x4

    new-array v2, v2, [Ljava/lang/Object;

    const/4 v3, 0x0

    iget v4, p0, Lcom/lidroid/xutils/cache/LruMemoryCache;->maxSize:I

    invoke-static {v4}, Ljava/lang/Integer;->valueOf(I)Ljava/lang/Integer;

    move-result-object v4

    aput-object v4, v2, v3

    const/4 v3, 0x1

    iget v4, p0, Lcom/lidroid/xutils/cache/LruMemoryCache;->hitCount:I

    invoke-static {v4}, Ljava/lang/Integer;->valueOf(I)Ljava/lang/Integer;

    move-result-object v4

    aput-object v4, v2, v3

    const/4 v3, 0x2

    iget v4, p0, Lcom/lidroid/xutils/cache/LruMemoryCache;->missCount:I

    invoke-static {v4}, Ljava/lang/Integer;->valueOf(I)Ljava/lang/Integer;

    move-result-object v4

    aput-object v4, v2, v3

    const/4 v3, 0x3

    invoke-static {v0}, Ljava/lang/Integer;->valueOf(I)Ljava/lang/Integer;

    move-result-object v0

    aput-object v0, v2, v3

    invoke-static {v1, v2}, Ljava/lang/String;->format(Ljava/lang/String;[Ljava/lang/Object;)Ljava/lang/String;
    :try_end_0
    .catchall {:try_start_0 .. :try_end_0} :catchall_0

    move-result-object v0

    monitor-exit p0

    return-object v0

    .line 347
    :catchall_0
    move-exception v0

    monitor-exit p0

    throw v0
.end method
