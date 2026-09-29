.class public Lcom/lidroid/xutils/bitmap/core/BitmapCache;
.super Ljava/lang/Object;
.source "SourceFile"


# annotations
.annotation system Ldalvik/annotation/MemberClasses;
    value = {
        Lcom/lidroid/xutils/bitmap/core/BitmapCache$BitmapMeta;,
        Lcom/lidroid/xutils/bitmap/core/BitmapCache$MemoryCacheKey;
    }
.end annotation


# instance fields
.field private final DISK_CACHE_INDEX:I

.field private globalConfig:Lcom/lidroid/xutils/bitmap/BitmapGlobalConfig;

.field private final mDiskCacheLock:Ljava/lang/Object;

.field private mDiskLruCache:Lcom/lidroid/xutils/cache/LruDiskCache;

.field private mMemoryCache:Lcom/lidroid/xutils/cache/LruMemoryCache;
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "Lcom/lidroid/xutils/cache/LruMemoryCache",
            "<",
            "Lcom/lidroid/xutils/bitmap/core/BitmapCache$MemoryCacheKey;",
            "Landroid/graphics/Bitmap;",
            ">;"
        }
    .end annotation
.end field


# direct methods
.method public constructor <init>(Lcom/lidroid/xutils/bitmap/BitmapGlobalConfig;)V
    .locals 2

    .prologue
    .line 51
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    .line 37
    const/4 v0, 0x0

    iput v0, p0, Lcom/lidroid/xutils/bitmap/core/BitmapCache;->DISK_CACHE_INDEX:I

    .line 42
    new-instance v0, Ljava/lang/Object;

    invoke-direct {v0}, Ljava/lang/Object;-><init>()V

    iput-object v0, p0, Lcom/lidroid/xutils/bitmap/core/BitmapCache;->mDiskCacheLock:Ljava/lang/Object;

    .line 52
    if-nez p1, :cond_0

    new-instance v0, Ljava/lang/IllegalArgumentException;

    const-string v1, "globalConfig may not be null"

    invoke-direct {v0, v1}, Ljava/lang/IllegalArgumentException;-><init>(Ljava/lang/String;)V

    throw v0

    .line 53
    :cond_0
    iput-object p1, p0, Lcom/lidroid/xutils/bitmap/core/BitmapCache;->globalConfig:Lcom/lidroid/xutils/bitmap/BitmapGlobalConfig;

    .line 54
    return-void
.end method

.method private decodeBitmapMeta(Lcom/lidroid/xutils/bitmap/core/BitmapCache$BitmapMeta;Lcom/lidroid/xutils/bitmap/BitmapDisplayConfig;)Landroid/graphics/Bitmap;
    .locals 3
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljava/io/IOException;
        }
    .end annotation

    .prologue
    const/4 v0, 0x0

    .line 393
    if-nez p1, :cond_1

    .line 414
    :cond_0
    :goto_0
    return-object v0

    .line 395
    :cond_1
    iget-object v1, p1, Lcom/lidroid/xutils/bitmap/core/BitmapCache$BitmapMeta;->inputStream:Ljava/io/FileInputStream;

    if-eqz v1, :cond_4

    .line 396
    if-eqz p2, :cond_2

    invoke-virtual {p2}, Lcom/lidroid/xutils/bitmap/BitmapDisplayConfig;->isShowOriginal()Z

    move-result v0

    if-eqz v0, :cond_3

    .line 397
    :cond_2
    iget-object v0, p1, Lcom/lidroid/xutils/bitmap/core/BitmapCache$BitmapMeta;->inputStream:Ljava/io/FileInputStream;

    invoke-virtual {v0}, Ljava/io/FileInputStream;->getFD()Ljava/io/FileDescriptor;

    move-result-object v0

    invoke-static {v0}, Lcom/lidroid/xutils/bitmap/core/BitmapDecoder;->decodeFileDescriptor(Ljava/io/FileDescriptor;)Landroid/graphics/Bitmap;

    move-result-object v0

    goto :goto_0

    .line 400
    :cond_3
    iget-object v0, p1, Lcom/lidroid/xutils/bitmap/core/BitmapCache$BitmapMeta;->inputStream:Ljava/io/FileInputStream;

    invoke-virtual {v0}, Ljava/io/FileInputStream;->getFD()Ljava/io/FileDescriptor;

    move-result-object v0

    .line 401
    invoke-virtual {p2}, Lcom/lidroid/xutils/bitmap/BitmapDisplayConfig;->getBitmapMaxSize()Lcom/lidroid/xutils/bitmap/core/BitmapSize;

    move-result-object v1

    .line 402
    invoke-virtual {p2}, Lcom/lidroid/xutils/bitmap/BitmapDisplayConfig;->getBitmapConfig()Landroid/graphics/Bitmap$Config;

    move-result-object v2

    .line 399
    invoke-static {v0, v1, v2}, Lcom/lidroid/xutils/bitmap/core/BitmapDecoder;->decodeSampledBitmapFromDescriptor(Ljava/io/FileDescriptor;Lcom/lidroid/xutils/bitmap/core/BitmapSize;Landroid/graphics/Bitmap$Config;)Landroid/graphics/Bitmap;

    move-result-object v0

    goto :goto_0

    .line 404
    :cond_4
    iget-object v1, p1, Lcom/lidroid/xutils/bitmap/core/BitmapCache$BitmapMeta;->data:[B

    if-eqz v1, :cond_0

    .line 405
    if-eqz p2, :cond_5

    invoke-virtual {p2}, Lcom/lidroid/xutils/bitmap/BitmapDisplayConfig;->isShowOriginal()Z

    move-result v0

    if-eqz v0, :cond_6

    .line 406
    :cond_5
    iget-object v0, p1, Lcom/lidroid/xutils/bitmap/core/BitmapCache$BitmapMeta;->data:[B

    invoke-static {v0}, Lcom/lidroid/xutils/bitmap/core/BitmapDecoder;->decodeByteArray([B)Landroid/graphics/Bitmap;

    move-result-object v0

    goto :goto_0

    .line 409
    :cond_6
    iget-object v0, p1, Lcom/lidroid/xutils/bitmap/core/BitmapCache$BitmapMeta;->data:[B

    .line 410
    invoke-virtual {p2}, Lcom/lidroid/xutils/bitmap/BitmapDisplayConfig;->getBitmapMaxSize()Lcom/lidroid/xutils/bitmap/core/BitmapSize;

    move-result-object v1

    .line 411
    invoke-virtual {p2}, Lcom/lidroid/xutils/bitmap/BitmapDisplayConfig;->getBitmapConfig()Landroid/graphics/Bitmap$Config;

    move-result-object v2

    .line 408
    invoke-static {v0, v1, v2}, Lcom/lidroid/xutils/bitmap/core/BitmapDecoder;->decodeSampledBitmapFromByteArray([BLcom/lidroid/xutils/bitmap/core/BitmapSize;Landroid/graphics/Bitmap$Config;)Landroid/graphics/Bitmap;

    move-result-object v0

    goto :goto_0
.end method

.method private declared-synchronized rotateBitmapIfNeeded(Ljava/lang/String;Lcom/lidroid/xutils/bitmap/BitmapDisplayConfig;Landroid/graphics/Bitmap;)Landroid/graphics/Bitmap;
    .locals 7

    .prologue
    const/4 v0, 0x0

    .line 418
    monitor-enter p0

    .line 419
    if-eqz p2, :cond_0

    :try_start_0
    invoke-virtual {p2}, Lcom/lidroid/xutils/bitmap/BitmapDisplayConfig;->isAutoRotation()Z

    move-result v1

    if-eqz v1, :cond_0

    .line 420
    invoke-virtual {p0, p1}, Lcom/lidroid/xutils/bitmap/core/BitmapCache;->getBitmapFileFromDiskCache(Ljava/lang/String;)Ljava/io/File;

    move-result-object v1

    .line 421
    if-eqz v1, :cond_0

    invoke-virtual {v1}, Ljava/io/File;->exists()Z
    :try_end_0
    .catchall {:try_start_0 .. :try_end_0} :catchall_0

    move-result v2

    if-eqz v2, :cond_0

    .line 424
    :try_start_1
    new-instance v2, Landroid/media/ExifInterface;

    invoke-virtual {v1}, Ljava/io/File;->getPath()Ljava/lang/String;

    move-result-object v1

    invoke-direct {v2, v1}, Landroid/media/ExifInterface;-><init>(Ljava/lang/String;)V
    :try_end_1
    .catch Ljava/lang/Throwable; {:try_start_1 .. :try_end_1} :catch_0
    .catchall {:try_start_1 .. :try_end_1} :catchall_0

    .line 428
    :try_start_2
    const-string v1, "Orientation"

    const/4 v3, 0x0

    invoke-virtual {v2, v1, v3}, Landroid/media/ExifInterface;->getAttributeInt(Ljava/lang/String;I)I

    move-result v1

    .line 430
    packed-switch v1, :pswitch_data_0

    .line 444
    :goto_0
    :pswitch_0
    if-eqz v0, :cond_0

    .line 445
    new-instance v5, Landroid/graphics/Matrix;

    invoke-direct {v5}, Landroid/graphics/Matrix;-><init>()V

    .line 446
    int-to-float v0, v0

    invoke-virtual {v5, v0}, Landroid/graphics/Matrix;->postRotate(F)Z

    .line 447
    const/4 v1, 0x0

    const/4 v2, 0x0

    invoke-virtual {p3}, Landroid/graphics/Bitmap;->getWidth()I

    move-result v3

    invoke-virtual {p3}, Landroid/graphics/Bitmap;->getHeight()I

    move-result v4

    const/4 v6, 0x1

    move-object v0, p3

    invoke-static/range {v0 .. v6}, Landroid/graphics/Bitmap;->createBitmap(Landroid/graphics/Bitmap;IIIILandroid/graphics/Matrix;Z)Landroid/graphics/Bitmap;

    move-result-object v0

    .line 448
    invoke-virtual {p3}, Landroid/graphics/Bitmap;->recycle()V
    :try_end_2
    .catchall {:try_start_2 .. :try_end_2} :catchall_0

    move-object p3, v0

    .line 453
    :cond_0
    :goto_1
    monitor-exit p0

    return-object p3

    .line 432
    :pswitch_1
    const/16 v0, 0x5a

    .line 433
    goto :goto_0

    .line 435
    :pswitch_2
    const/16 v0, 0xb4

    .line 436
    goto :goto_0

    .line 438
    :pswitch_3
    const/16 v0, 0x10e

    .line 439
    goto :goto_0

    .line 418
    :catchall_0
    move-exception v0

    monitor-exit p0

    throw v0

    .line 425
    :catch_0
    move-exception v0

    goto :goto_1

    .line 430
    :pswitch_data_0
    .packed-switch 0x3
        :pswitch_2
        :pswitch_0
        :pswitch_0
        :pswitch_1
        :pswitch_0
        :pswitch_3
    .end packed-switch
.end method


# virtual methods
.method public addBitmapToMemoryCache(Ljava/lang/String;Lcom/lidroid/xutils/bitmap/BitmapDisplayConfig;Landroid/graphics/Bitmap;J)Landroid/graphics/Bitmap;
    .locals 2
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljava/io/IOException;
        }
    .end annotation

    .prologue
    .line 209
    if-eqz p2, :cond_0

    .line 210
    invoke-virtual {p2}, Lcom/lidroid/xutils/bitmap/BitmapDisplayConfig;->getBitmapFactory()Lcom/lidroid/xutils/bitmap/factory/BitmapFactory;

    move-result-object v0

    .line 211
    if-eqz v0, :cond_0

    .line 212
    invoke-interface {v0}, Lcom/lidroid/xutils/bitmap/factory/BitmapFactory;->cloneNew()Lcom/lidroid/xutils/bitmap/factory/BitmapFactory;

    move-result-object v0

    invoke-interface {v0, p3}, Lcom/lidroid/xutils/bitmap/factory/BitmapFactory;->createBitmap(Landroid/graphics/Bitmap;)Landroid/graphics/Bitmap;

    move-result-object p3

    .line 215
    :cond_0
    if-eqz p1, :cond_1

    if-eqz p3, :cond_1

    iget-object v0, p0, Lcom/lidroid/xutils/bitmap/core/BitmapCache;->globalConfig:Lcom/lidroid/xutils/bitmap/BitmapGlobalConfig;

    invoke-virtual {v0}, Lcom/lidroid/xutils/bitmap/BitmapGlobalConfig;->isMemoryCacheEnabled()Z

    move-result v0

    if-eqz v0, :cond_1

    iget-object v0, p0, Lcom/lidroid/xutils/bitmap/core/BitmapCache;->mMemoryCache:Lcom/lidroid/xutils/cache/LruMemoryCache;

    if-eqz v0, :cond_1

    .line 216
    new-instance v0, Lcom/lidroid/xutils/bitmap/core/BitmapCache$MemoryCacheKey;

    const/4 v1, 0x0

    invoke-direct {v0, p0, p1, p2, v1}, Lcom/lidroid/xutils/bitmap/core/BitmapCache$MemoryCacheKey;-><init>(Lcom/lidroid/xutils/bitmap/core/BitmapCache;Ljava/lang/String;Lcom/lidroid/xutils/bitmap/BitmapDisplayConfig;Lcom/lidroid/xutils/bitmap/core/BitmapCache$MemoryCacheKey;)V

    .line 217
    iget-object v1, p0, Lcom/lidroid/xutils/bitmap/core/BitmapCache;->mMemoryCache:Lcom/lidroid/xutils/cache/LruMemoryCache;

    invoke-virtual {v1, v0, p3, p4, p5}, Lcom/lidroid/xutils/cache/LruMemoryCache;->put(Ljava/lang/Object;Ljava/lang/Object;J)Ljava/lang/Object;

    .line 219
    :cond_1
    return-object p3
.end method

.method public clearCache()V
    .locals 0

    .prologue
    .line 299
    invoke-virtual {p0}, Lcom/lidroid/xutils/bitmap/core/BitmapCache;->clearMemoryCache()V

    .line 300
    invoke-virtual {p0}, Lcom/lidroid/xutils/bitmap/core/BitmapCache;->clearDiskCache()V

    .line 301
    return-void
.end method

.method public clearCache(Ljava/lang/String;)V
    .locals 0

    .prologue
    .line 326
    invoke-virtual {p0, p1}, Lcom/lidroid/xutils/bitmap/core/BitmapCache;->clearMemoryCache(Ljava/lang/String;)V

    .line 327
    invoke-virtual {p0, p1}, Lcom/lidroid/xutils/bitmap/core/BitmapCache;->clearDiskCache(Ljava/lang/String;)V

    .line 328
    return-void
.end method

.method public clearDiskCache()V
    .locals 3

    .prologue
    .line 310
    iget-object v1, p0, Lcom/lidroid/xutils/bitmap/core/BitmapCache;->mDiskCacheLock:Ljava/lang/Object;

    monitor-enter v1

    .line 311
    :try_start_0
    iget-object v0, p0, Lcom/lidroid/xutils/bitmap/core/BitmapCache;->mDiskLruCache:Lcom/lidroid/xutils/cache/LruDiskCache;

    if-eqz v0, :cond_0

    iget-object v0, p0, Lcom/lidroid/xutils/bitmap/core/BitmapCache;->mDiskLruCache:Lcom/lidroid/xutils/cache/LruDiskCache;

    invoke-virtual {v0}, Lcom/lidroid/xutils/cache/LruDiskCache;->isClosed()Z
    :try_end_0
    .catchall {:try_start_0 .. :try_end_0} :catchall_0

    move-result v0

    if-nez v0, :cond_0

    .line 313
    :try_start_1
    iget-object v0, p0, Lcom/lidroid/xutils/bitmap/core/BitmapCache;->mDiskLruCache:Lcom/lidroid/xutils/cache/LruDiskCache;

    invoke-virtual {v0}, Lcom/lidroid/xutils/cache/LruDiskCache;->delete()V

    .line 314
    iget-object v0, p0, Lcom/lidroid/xutils/bitmap/core/BitmapCache;->mDiskLruCache:Lcom/lidroid/xutils/cache/LruDiskCache;

    invoke-virtual {v0}, Lcom/lidroid/xutils/cache/LruDiskCache;->close()V
    :try_end_1
    .catch Ljava/lang/Throwable; {:try_start_1 .. :try_end_1} :catch_0
    .catchall {:try_start_1 .. :try_end_1} :catchall_0

    .line 318
    :goto_0
    const/4 v0, 0x0

    :try_start_2
    iput-object v0, p0, Lcom/lidroid/xutils/bitmap/core/BitmapCache;->mDiskLruCache:Lcom/lidroid/xutils/cache/LruDiskCache;

    .line 310
    :cond_0
    monitor-exit v1
    :try_end_2
    .catchall {:try_start_2 .. :try_end_2} :catchall_0

    .line 321
    invoke-virtual {p0}, Lcom/lidroid/xutils/bitmap/core/BitmapCache;->initDiskCache()V

    .line 322
    return-void

    .line 315
    :catch_0
    move-exception v0

    .line 316
    :try_start_3
    invoke-virtual {v0}, Ljava/lang/Throwable;->getMessage()Ljava/lang/String;

    move-result-object v2

    invoke-static {v2, v0}, Lcom/lidroid/xutils/util/LogUtils;->e(Ljava/lang/String;Ljava/lang/Throwable;)V

    goto :goto_0

    .line 310
    :catchall_0
    move-exception v0

    monitor-exit v1
    :try_end_3
    .catchall {:try_start_3 .. :try_end_3} :catchall_0

    throw v0
.end method

.method public clearDiskCache(Ljava/lang/String;)V
    .locals 3

    .prologue
    .line 340
    iget-object v1, p0, Lcom/lidroid/xutils/bitmap/core/BitmapCache;->mDiskCacheLock:Ljava/lang/Object;

    monitor-enter v1

    .line 341
    :try_start_0
    iget-object v0, p0, Lcom/lidroid/xutils/bitmap/core/BitmapCache;->mDiskLruCache:Lcom/lidroid/xutils/cache/LruDiskCache;

    if-eqz v0, :cond_0

    iget-object v0, p0, Lcom/lidroid/xutils/bitmap/core/BitmapCache;->mDiskLruCache:Lcom/lidroid/xutils/cache/LruDiskCache;

    invoke-virtual {v0}, Lcom/lidroid/xutils/cache/LruDiskCache;->isClosed()Z
    :try_end_0
    .catchall {:try_start_0 .. :try_end_0} :catchall_0

    move-result v0

    if-nez v0, :cond_0

    .line 343
    :try_start_1
    iget-object v0, p0, Lcom/lidroid/xutils/bitmap/core/BitmapCache;->mDiskLruCache:Lcom/lidroid/xutils/cache/LruDiskCache;

    invoke-virtual {v0, p1}, Lcom/lidroid/xutils/cache/LruDiskCache;->remove(Ljava/lang/String;)Z
    :try_end_1
    .catch Ljava/lang/Throwable; {:try_start_1 .. :try_end_1} :catch_0
    .catchall {:try_start_1 .. :try_end_1} :catchall_0

    .line 340
    :cond_0
    :goto_0
    :try_start_2
    monitor-exit v1

    .line 349
    return-void

    .line 344
    :catch_0
    move-exception v0

    .line 345
    invoke-virtual {v0}, Ljava/lang/Throwable;->getMessage()Ljava/lang/String;

    move-result-object v2

    invoke-static {v2, v0}, Lcom/lidroid/xutils/util/LogUtils;->e(Ljava/lang/String;Ljava/lang/Throwable;)V

    goto :goto_0

    .line 340
    :catchall_0
    move-exception v0

    monitor-exit v1
    :try_end_2
    .catchall {:try_start_2 .. :try_end_2} :catchall_0

    throw v0
.end method

.method public clearMemoryCache()V
    .locals 1

    .prologue
    .line 304
    iget-object v0, p0, Lcom/lidroid/xutils/bitmap/core/BitmapCache;->mMemoryCache:Lcom/lidroid/xutils/cache/LruMemoryCache;

    if-eqz v0, :cond_0

    .line 305
    iget-object v0, p0, Lcom/lidroid/xutils/bitmap/core/BitmapCache;->mMemoryCache:Lcom/lidroid/xutils/cache/LruMemoryCache;

    invoke-virtual {v0}, Lcom/lidroid/xutils/cache/LruMemoryCache;->evictAll()V

    .line 307
    :cond_0
    return-void
.end method

.method public clearMemoryCache(Ljava/lang/String;)V
    .locals 2

    .prologue
    const/4 v1, 0x0

    .line 331
    new-instance v0, Lcom/lidroid/xutils/bitmap/core/BitmapCache$MemoryCacheKey;

    invoke-direct {v0, p0, p1, v1, v1}, Lcom/lidroid/xutils/bitmap/core/BitmapCache$MemoryCacheKey;-><init>(Lcom/lidroid/xutils/bitmap/core/BitmapCache;Ljava/lang/String;Lcom/lidroid/xutils/bitmap/BitmapDisplayConfig;Lcom/lidroid/xutils/bitmap/core/BitmapCache$MemoryCacheKey;)V

    .line 332
    iget-object v1, p0, Lcom/lidroid/xutils/bitmap/core/BitmapCache;->mMemoryCache:Lcom/lidroid/xutils/cache/LruMemoryCache;

    if-eqz v1, :cond_0

    .line 333
    :goto_0
    iget-object v1, p0, Lcom/lidroid/xutils/bitmap/core/BitmapCache;->mMemoryCache:Lcom/lidroid/xutils/cache/LruMemoryCache;

    invoke-virtual {v1, v0}, Lcom/lidroid/xutils/cache/LruMemoryCache;->containsKey(Ljava/lang/Object;)Z

    move-result v1

    if-nez v1, :cond_1

    .line 337
    :cond_0
    return-void

    .line 334
    :cond_1
    iget-object v1, p0, Lcom/lidroid/xutils/bitmap/core/BitmapCache;->mMemoryCache:Lcom/lidroid/xutils/cache/LruMemoryCache;

    invoke-virtual {v1, v0}, Lcom/lidroid/xutils/cache/LruMemoryCache;->remove(Ljava/lang/Object;)Ljava/lang/Object;

    goto :goto_0
.end method

.method public close()V
    .locals 3

    .prologue
    .line 372
    iget-object v1, p0, Lcom/lidroid/xutils/bitmap/core/BitmapCache;->mDiskCacheLock:Ljava/lang/Object;

    monitor-enter v1

    .line 373
    :try_start_0
    iget-object v0, p0, Lcom/lidroid/xutils/bitmap/core/BitmapCache;->mDiskLruCache:Lcom/lidroid/xutils/cache/LruDiskCache;
    :try_end_0
    .catchall {:try_start_0 .. :try_end_0} :catchall_0

    if-eqz v0, :cond_1

    .line 375
    :try_start_1
    iget-object v0, p0, Lcom/lidroid/xutils/bitmap/core/BitmapCache;->mDiskLruCache:Lcom/lidroid/xutils/cache/LruDiskCache;

    invoke-virtual {v0}, Lcom/lidroid/xutils/cache/LruDiskCache;->isClosed()Z

    move-result v0

    if-nez v0, :cond_0

    .line 376
    iget-object v0, p0, Lcom/lidroid/xutils/bitmap/core/BitmapCache;->mDiskLruCache:Lcom/lidroid/xutils/cache/LruDiskCache;

    invoke-virtual {v0}, Lcom/lidroid/xutils/cache/LruDiskCache;->close()V
    :try_end_1
    .catch Ljava/lang/Throwable; {:try_start_1 .. :try_end_1} :catch_0
    .catchall {:try_start_1 .. :try_end_1} :catchall_0

    .line 381
    :cond_0
    :goto_0
    const/4 v0, 0x0

    :try_start_2
    iput-object v0, p0, Lcom/lidroid/xutils/bitmap/core/BitmapCache;->mDiskLruCache:Lcom/lidroid/xutils/cache/LruDiskCache;

    .line 372
    :cond_1
    monitor-exit v1

    .line 384
    return-void

    .line 378
    :catch_0
    move-exception v0

    .line 379
    invoke-virtual {v0}, Ljava/lang/Throwable;->getMessage()Ljava/lang/String;

    move-result-object v2

    invoke-static {v2, v0}, Lcom/lidroid/xutils/util/LogUtils;->e(Ljava/lang/String;Ljava/lang/Throwable;)V

    goto :goto_0

    .line 372
    :catchall_0
    move-exception v0

    monitor-exit v1
    :try_end_2
    .catchall {:try_start_2 .. :try_end_2} :catchall_0

    throw v0
.end method

.method public downloadBitmap(Ljava/lang/String;Lcom/lidroid/xutils/bitmap/BitmapDisplayConfig;Lcom/lidroid/xutils/BitmapUtils$BitmapLoadTask;)Landroid/graphics/Bitmap;
    .locals 12
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "(",
            "Ljava/lang/String;",
            "Lcom/lidroid/xutils/bitmap/BitmapDisplayConfig;",
            "Lcom/lidroid/xutils/BitmapUtils$BitmapLoadTask",
            "<*>;)",
            "Landroid/graphics/Bitmap;"
        }
    .end annotation

    .prologue
    .line 135
    new-instance v6, Lcom/lidroid/xutils/bitmap/core/BitmapCache$BitmapMeta;

    const/4 v2, 0x0

    invoke-direct {v6, p0, v2}, Lcom/lidroid/xutils/bitmap/core/BitmapCache$BitmapMeta;-><init>(Lcom/lidroid/xutils/bitmap/core/BitmapCache;Lcom/lidroid/xutils/bitmap/core/BitmapCache$BitmapMeta;)V

    .line 137
    const/4 v5, 0x0

    .line 138
    const/4 v4, 0x0

    .line 141
    const/4 v3, 0x0

    .line 144
    :try_start_0
    iget-object v2, p0, Lcom/lidroid/xutils/bitmap/core/BitmapCache;->globalConfig:Lcom/lidroid/xutils/bitmap/BitmapGlobalConfig;

    invoke-virtual {v2}, Lcom/lidroid/xutils/bitmap/BitmapGlobalConfig;->isDiskCacheEnabled()Z

    move-result v2

    if-eqz v2, :cond_8

    .line 145
    iget-object v2, p0, Lcom/lidroid/xutils/bitmap/core/BitmapCache;->mDiskLruCache:Lcom/lidroid/xutils/cache/LruDiskCache;

    if-nez v2, :cond_0

    .line 146
    invoke-virtual {p0}, Lcom/lidroid/xutils/bitmap/core/BitmapCache;->initDiskCache()V

    .line 149
    :cond_0
    iget-object v2, p0, Lcom/lidroid/xutils/bitmap/core/BitmapCache;->mDiskLruCache:Lcom/lidroid/xutils/cache/LruDiskCache;
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_1
    .catchall {:try_start_0 .. :try_end_0} :catchall_0

    if-eqz v2, :cond_8

    .line 151
    :try_start_1
    iget-object v2, p0, Lcom/lidroid/xutils/bitmap/core/BitmapCache;->mDiskLruCache:Lcom/lidroid/xutils/cache/LruDiskCache;

    invoke-virtual {v2, p1}, Lcom/lidroid/xutils/cache/LruDiskCache;->get(Ljava/lang/String;)Lcom/lidroid/xutils/cache/LruDiskCache$Snapshot;

    move-result-object v4

    .line 152
    if-nez v4, :cond_2

    .line 153
    iget-object v2, p0, Lcom/lidroid/xutils/bitmap/core/BitmapCache;->mDiskLruCache:Lcom/lidroid/xutils/cache/LruDiskCache;

    invoke-virtual {v2, p1}, Lcom/lidroid/xutils/cache/LruDiskCache;->edit(Ljava/lang/String;)Lcom/lidroid/xutils/cache/LruDiskCache$Editor;

    move-result-object v2

    .line 154
    if-eqz v2, :cond_2

    .line 155
    const/4 v7, 0x0

    invoke-virtual {v2, v7}, Lcom/lidroid/xutils/cache/LruDiskCache$Editor;->newOutputStream(I)Ljava/io/OutputStream;

    move-result-object v5

    .line 156
    iget-object v7, p0, Lcom/lidroid/xutils/bitmap/core/BitmapCache;->globalConfig:Lcom/lidroid/xutils/bitmap/BitmapGlobalConfig;

    invoke-virtual {v7}, Lcom/lidroid/xutils/bitmap/BitmapGlobalConfig;->getDownloader()Lcom/lidroid/xutils/bitmap/download/Downloader;

    move-result-object v7

    invoke-virtual {v7, p1, v5, p3}, Lcom/lidroid/xutils/bitmap/download/Downloader;->downloadToStream(Ljava/lang/String;Ljava/io/OutputStream;Lcom/lidroid/xutils/BitmapUtils$BitmapLoadTask;)J

    move-result-wide v8

    iput-wide v8, v6, Lcom/lidroid/xutils/bitmap/core/BitmapCache$BitmapMeta;->expiryTimestamp:J

    .line 157
    iget-wide v8, v6, Lcom/lidroid/xutils/bitmap/core/BitmapCache$BitmapMeta;->expiryTimestamp:J

    const-wide/16 v10, 0x0

    cmp-long v7, v8, v10

    if-gez v7, :cond_1

    .line 158
    invoke-virtual {v2}, Lcom/lidroid/xutils/cache/LruDiskCache$Editor;->abort()V
    :try_end_1
    .catch Ljava/lang/Throwable; {:try_start_1 .. :try_end_1} :catch_0
    .catchall {:try_start_1 .. :try_end_1} :catchall_0

    .line 201
    invoke-static {v5}, Lcom/lidroid/xutils/util/IOUtils;->closeQuietly(Ljava/io/Closeable;)V

    .line 202
    invoke-static {v4}, Lcom/lidroid/xutils/util/IOUtils;->closeQuietly(Ljava/io/Closeable;)V

    .line 159
    const/4 v2, 0x0

    .line 205
    :goto_0
    return-object v2

    .line 161
    :cond_1
    :try_start_2
    iget-wide v8, v6, Lcom/lidroid/xutils/bitmap/core/BitmapCache$BitmapMeta;->expiryTimestamp:J

    invoke-virtual {v2, v8, v9}, Lcom/lidroid/xutils/cache/LruDiskCache$Editor;->setEntryExpiryTimestamp(J)V

    .line 162
    invoke-virtual {v2}, Lcom/lidroid/xutils/cache/LruDiskCache$Editor;->commit()V

    .line 164
    iget-object v2, p0, Lcom/lidroid/xutils/bitmap/core/BitmapCache;->mDiskLruCache:Lcom/lidroid/xutils/cache/LruDiskCache;

    invoke-virtual {v2, p1}, Lcom/lidroid/xutils/cache/LruDiskCache;->get(Ljava/lang/String;)Lcom/lidroid/xutils/cache/LruDiskCache$Snapshot;

    move-result-object v4

    .line 167
    :cond_2
    if-eqz v4, :cond_7

    .line 168
    const/4 v2, 0x0

    invoke-virtual {v4, v2}, Lcom/lidroid/xutils/cache/LruDiskCache$Snapshot;->getInputStream(I)Ljava/io/FileInputStream;

    move-result-object v2

    iput-object v2, v6, Lcom/lidroid/xutils/bitmap/core/BitmapCache$BitmapMeta;->inputStream:Ljava/io/FileInputStream;

    .line 169
    invoke-direct {p0, v6, p2}, Lcom/lidroid/xutils/bitmap/core/BitmapCache;->decodeBitmapMeta(Lcom/lidroid/xutils/bitmap/core/BitmapCache$BitmapMeta;Lcom/lidroid/xutils/bitmap/BitmapDisplayConfig;)Landroid/graphics/Bitmap;

    move-result-object v3

    .line 170
    if-nez v3, :cond_3

    .line 171
    const/4 v2, 0x0

    iput-object v2, v6, Lcom/lidroid/xutils/bitmap/core/BitmapCache$BitmapMeta;->inputStream:Ljava/io/FileInputStream;

    .line 172
    iget-object v2, p0, Lcom/lidroid/xutils/bitmap/core/BitmapCache;->mDiskLruCache:Lcom/lidroid/xutils/cache/LruDiskCache;

    invoke-virtual {v2, p1}, Lcom/lidroid/xutils/cache/LruDiskCache;->remove(Ljava/lang/String;)Z
    :try_end_2
    .catch Ljava/lang/Throwable; {:try_start_2 .. :try_end_2} :catch_0
    .catchall {:try_start_2 .. :try_end_2} :catchall_0

    move-object v2, v3

    move-object v8, v4

    .line 182
    :goto_1
    if-nez v2, :cond_6

    .line 183
    :try_start_3
    new-instance v3, Ljava/io/ByteArrayOutputStream;

    invoke-direct {v3}, Ljava/io/ByteArrayOutputStream;-><init>()V
    :try_end_3
    .catch Ljava/lang/Throwable; {:try_start_3 .. :try_end_3} :catch_3
    .catchall {:try_start_3 .. :try_end_3} :catchall_1

    .line 184
    :try_start_4
    iget-object v2, p0, Lcom/lidroid/xutils/bitmap/core/BitmapCache;->globalConfig:Lcom/lidroid/xutils/bitmap/BitmapGlobalConfig;

    invoke-virtual {v2}, Lcom/lidroid/xutils/bitmap/BitmapGlobalConfig;->getDownloader()Lcom/lidroid/xutils/bitmap/download/Downloader;

    move-result-object v2

    invoke-virtual {v2, p1, v3, p3}, Lcom/lidroid/xutils/bitmap/download/Downloader;->downloadToStream(Ljava/lang/String;Ljava/io/OutputStream;Lcom/lidroid/xutils/BitmapUtils$BitmapLoadTask;)J

    move-result-wide v4

    iput-wide v4, v6, Lcom/lidroid/xutils/bitmap/core/BitmapCache$BitmapMeta;->expiryTimestamp:J

    .line 185
    iget-wide v4, v6, Lcom/lidroid/xutils/bitmap/core/BitmapCache$BitmapMeta;->expiryTimestamp:J
    :try_end_4
    .catch Ljava/lang/Throwable; {:try_start_4 .. :try_end_4} :catch_4
    .catchall {:try_start_4 .. :try_end_4} :catchall_2

    const-wide/16 v10, 0x0

    cmp-long v2, v4, v10

    if-gez v2, :cond_4

    .line 201
    invoke-static {v3}, Lcom/lidroid/xutils/util/IOUtils;->closeQuietly(Ljava/io/Closeable;)V

    .line 202
    invoke-static {v8}, Lcom/lidroid/xutils/util/IOUtils;->closeQuietly(Ljava/io/Closeable;)V

    .line 186
    const/4 v2, 0x0

    goto :goto_0

    .line 175
    :catch_0
    move-exception v2

    .line 176
    :try_start_5
    invoke-virtual {v2}, Ljava/lang/Throwable;->getMessage()Ljava/lang/String;

    move-result-object v7

    invoke-static {v7, v2}, Lcom/lidroid/xutils/util/LogUtils;->e(Ljava/lang/String;Ljava/lang/Throwable;)V
    :try_end_5
    .catch Ljava/lang/Throwable; {:try_start_5 .. :try_end_5} :catch_2
    .catchall {:try_start_5 .. :try_end_5} :catchall_0

    :cond_3
    move-object v2, v3

    move-object v8, v4

    goto :goto_1

    .line 188
    :cond_4
    :try_start_6
    move-object v0, v3

    check-cast v0, Ljava/io/ByteArrayOutputStream;

    move-object v2, v0

    invoke-virtual {v2}, Ljava/io/ByteArrayOutputStream;->toByteArray()[B

    move-result-object v2

    iput-object v2, v6, Lcom/lidroid/xutils/bitmap/core/BitmapCache$BitmapMeta;->data:[B

    .line 189
    invoke-direct {p0, v6, p2}, Lcom/lidroid/xutils/bitmap/core/BitmapCache;->decodeBitmapMeta(Lcom/lidroid/xutils/bitmap/core/BitmapCache$BitmapMeta;Lcom/lidroid/xutils/bitmap/BitmapDisplayConfig;)Landroid/graphics/Bitmap;
    :try_end_6
    .catch Ljava/lang/Throwable; {:try_start_6 .. :try_end_6} :catch_4
    .catchall {:try_start_6 .. :try_end_6} :catchall_2

    move-result-object v2

    move-object v9, v3

    .line 193
    :goto_2
    if-eqz v2, :cond_5

    .line 194
    :try_start_7
    invoke-direct {p0, p1, p2, v2}, Lcom/lidroid/xutils/bitmap/core/BitmapCache;->rotateBitmapIfNeeded(Ljava/lang/String;Lcom/lidroid/xutils/bitmap/BitmapDisplayConfig;Landroid/graphics/Bitmap;)Landroid/graphics/Bitmap;

    move-result-object v5

    .line 195
    iget-wide v6, v6, Lcom/lidroid/xutils/bitmap/core/BitmapCache$BitmapMeta;->expiryTimestamp:J

    move-object v2, p0

    move-object v3, p1

    move-object v4, p2

    invoke-virtual/range {v2 .. v7}, Lcom/lidroid/xutils/bitmap/core/BitmapCache;->addBitmapToMemoryCache(Ljava/lang/String;Lcom/lidroid/xutils/bitmap/BitmapDisplayConfig;Landroid/graphics/Bitmap;J)Landroid/graphics/Bitmap;
    :try_end_7
    .catch Ljava/lang/Throwable; {:try_start_7 .. :try_end_7} :catch_5
    .catchall {:try_start_7 .. :try_end_7} :catchall_3

    move-result-object v2

    .line 201
    :cond_5
    invoke-static {v9}, Lcom/lidroid/xutils/util/IOUtils;->closeQuietly(Ljava/io/Closeable;)V

    .line 202
    invoke-static {v8}, Lcom/lidroid/xutils/util/IOUtils;->closeQuietly(Ljava/io/Closeable;)V

    goto :goto_0

    .line 198
    :catch_1
    move-exception v2

    move-object v3, v5

    .line 199
    :goto_3
    :try_start_8
    invoke-virtual {v2}, Ljava/lang/Throwable;->getMessage()Ljava/lang/String;

    move-result-object v5

    invoke-static {v5, v2}, Lcom/lidroid/xutils/util/LogUtils;->e(Ljava/lang/String;Ljava/lang/Throwable;)V
    :try_end_8
    .catchall {:try_start_8 .. :try_end_8} :catchall_4

    .line 201
    invoke-static {v3}, Lcom/lidroid/xutils/util/IOUtils;->closeQuietly(Ljava/io/Closeable;)V

    .line 202
    invoke-static {v4}, Lcom/lidroid/xutils/util/IOUtils;->closeQuietly(Ljava/io/Closeable;)V

    .line 205
    const/4 v2, 0x0

    goto/16 :goto_0

    .line 200
    :catchall_0
    move-exception v2

    .line 201
    :goto_4
    invoke-static {v5}, Lcom/lidroid/xutils/util/IOUtils;->closeQuietly(Ljava/io/Closeable;)V

    .line 202
    invoke-static {v4}, Lcom/lidroid/xutils/util/IOUtils;->closeQuietly(Ljava/io/Closeable;)V

    .line 203
    throw v2

    .line 200
    :catchall_1
    move-exception v2

    move-object v4, v8

    goto :goto_4

    :catchall_2
    move-exception v2

    move-object v4, v8

    move-object v5, v3

    goto :goto_4

    :catchall_3
    move-exception v2

    move-object v4, v8

    move-object v5, v9

    goto :goto_4

    :catchall_4
    move-exception v2

    move-object v5, v3

    goto :goto_4

    .line 198
    :catch_2
    move-exception v2

    move-object v3, v5

    goto :goto_3

    :catch_3
    move-exception v2

    move-object v4, v8

    move-object v3, v5

    goto :goto_3

    :catch_4
    move-exception v2

    move-object v4, v8

    goto :goto_3

    :catch_5
    move-exception v2

    move-object v4, v8

    move-object v3, v9

    goto :goto_3

    :cond_6
    move-object v9, v5

    goto :goto_2

    :cond_7
    move-object v2, v3

    move-object v8, v4

    goto/16 :goto_1

    :cond_8
    move-object v2, v3

    move-object v8, v4

    goto/16 :goto_1
.end method

.method public flush()V
    .locals 3

    .prologue
    .line 356
    iget-object v1, p0, Lcom/lidroid/xutils/bitmap/core/BitmapCache;->mDiskCacheLock:Ljava/lang/Object;

    monitor-enter v1

    .line 357
    :try_start_0
    iget-object v0, p0, Lcom/lidroid/xutils/bitmap/core/BitmapCache;->mDiskLruCache:Lcom/lidroid/xutils/cache/LruDiskCache;
    :try_end_0
    .catchall {:try_start_0 .. :try_end_0} :catchall_0

    if-eqz v0, :cond_0

    .line 359
    :try_start_1
    iget-object v0, p0, Lcom/lidroid/xutils/bitmap/core/BitmapCache;->mDiskLruCache:Lcom/lidroid/xutils/cache/LruDiskCache;

    invoke-virtual {v0}, Lcom/lidroid/xutils/cache/LruDiskCache;->flush()V
    :try_end_1
    .catch Ljava/lang/Throwable; {:try_start_1 .. :try_end_1} :catch_0
    .catchall {:try_start_1 .. :try_end_1} :catchall_0

    .line 356
    :cond_0
    :goto_0
    :try_start_2
    monitor-exit v1

    .line 365
    return-void

    .line 360
    :catch_0
    move-exception v0

    .line 361
    invoke-virtual {v0}, Ljava/lang/Throwable;->getMessage()Ljava/lang/String;

    move-result-object v2

    invoke-static {v2, v0}, Lcom/lidroid/xutils/util/LogUtils;->e(Ljava/lang/String;Ljava/lang/Throwable;)V

    goto :goto_0

    .line 356
    :catchall_0
    move-exception v0

    monitor-exit v1
    :try_end_2
    .catchall {:try_start_2 .. :try_end_2} :catchall_0

    throw v0
.end method

.method public getBitmapFileFromDiskCache(Ljava/lang/String;)Ljava/io/File;
    .locals 3

    .prologue
    .line 244
    iget-object v1, p0, Lcom/lidroid/xutils/bitmap/core/BitmapCache;->mDiskCacheLock:Ljava/lang/Object;

    monitor-enter v1

    .line 245
    :try_start_0
    iget-object v0, p0, Lcom/lidroid/xutils/bitmap/core/BitmapCache;->mDiskLruCache:Lcom/lidroid/xutils/cache/LruDiskCache;

    if-eqz v0, :cond_0

    .line 246
    iget-object v0, p0, Lcom/lidroid/xutils/bitmap/core/BitmapCache;->mDiskLruCache:Lcom/lidroid/xutils/cache/LruDiskCache;

    const/4 v2, 0x0

    invoke-virtual {v0, p1, v2}, Lcom/lidroid/xutils/cache/LruDiskCache;->getCacheFile(Ljava/lang/String;I)Ljava/io/File;

    move-result-object v0

    monitor-exit v1

    .line 248
    :goto_0
    return-object v0

    :cond_0
    monitor-exit v1

    const/4 v0, 0x0

    goto :goto_0

    .line 244
    :catchall_0
    move-exception v0

    monitor-exit v1
    :try_end_0
    .catchall {:try_start_0 .. :try_end_0} :catchall_0

    throw v0
.end method

.method public getBitmapFromDiskCache(Ljava/lang/String;Lcom/lidroid/xutils/bitmap/BitmapDisplayConfig;)Landroid/graphics/Bitmap;
    .locals 8

    .prologue
    const/4 v6, 0x0

    .line 261
    if-eqz p1, :cond_0

    iget-object v0, p0, Lcom/lidroid/xutils/bitmap/core/BitmapCache;->globalConfig:Lcom/lidroid/xutils/bitmap/BitmapGlobalConfig;

    invoke-virtual {v0}, Lcom/lidroid/xutils/bitmap/BitmapGlobalConfig;->isDiskCacheEnabled()Z

    move-result v0

    if-nez v0, :cond_1

    :cond_0
    move-object v0, v6

    .line 291
    :goto_0
    return-object v0

    .line 262
    :cond_1
    iget-object v0, p0, Lcom/lidroid/xutils/bitmap/core/BitmapCache;->mDiskLruCache:Lcom/lidroid/xutils/cache/LruDiskCache;

    if-nez v0, :cond_2

    .line 263
    invoke-virtual {p0}, Lcom/lidroid/xutils/bitmap/core/BitmapCache;->initDiskCache()V

    .line 265
    :cond_2
    iget-object v0, p0, Lcom/lidroid/xutils/bitmap/core/BitmapCache;->mDiskLruCache:Lcom/lidroid/xutils/cache/LruDiskCache;

    if-eqz v0, :cond_5

    .line 268
    :try_start_0
    iget-object v0, p0, Lcom/lidroid/xutils/bitmap/core/BitmapCache;->mDiskLruCache:Lcom/lidroid/xutils/cache/LruDiskCache;

    invoke-virtual {v0, p1}, Lcom/lidroid/xutils/cache/LruDiskCache;->get(Ljava/lang/String;)Lcom/lidroid/xutils/cache/LruDiskCache$Snapshot;
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_0
    .catchall {:try_start_0 .. :try_end_0} :catchall_0

    move-result-object v7

    .line 269
    if-eqz v7, :cond_6

    .line 271
    if-eqz p2, :cond_3

    :try_start_1
    invoke-virtual {p2}, Lcom/lidroid/xutils/bitmap/BitmapDisplayConfig;->isShowOriginal()Z

    move-result v0

    if-eqz v0, :cond_4

    .line 273
    :cond_3
    const/4 v0, 0x0

    invoke-virtual {v7, v0}, Lcom/lidroid/xutils/cache/LruDiskCache$Snapshot;->getInputStream(I)Ljava/io/FileInputStream;

    move-result-object v0

    invoke-virtual {v0}, Ljava/io/FileInputStream;->getFD()Ljava/io/FileDescriptor;

    move-result-object v0

    .line 272
    invoke-static {v0}, Lcom/lidroid/xutils/bitmap/core/BitmapDecoder;->decodeFileDescriptor(Ljava/io/FileDescriptor;)Landroid/graphics/Bitmap;

    move-result-object v0

    .line 281
    :goto_1
    invoke-direct {p0, p1, p2, v0}, Lcom/lidroid/xutils/bitmap/core/BitmapCache;->rotateBitmapIfNeeded(Ljava/lang/String;Lcom/lidroid/xutils/bitmap/BitmapDisplayConfig;Landroid/graphics/Bitmap;)Landroid/graphics/Bitmap;

    move-result-object v3

    .line 282
    iget-object v0, p0, Lcom/lidroid/xutils/bitmap/core/BitmapCache;->mDiskLruCache:Lcom/lidroid/xutils/cache/LruDiskCache;

    invoke-virtual {v0, p1}, Lcom/lidroid/xutils/cache/LruDiskCache;->getExpiryTimestamp(Ljava/lang/String;)J

    move-result-wide v4

    move-object v0, p0

    move-object v1, p1

    move-object v2, p2

    invoke-virtual/range {v0 .. v5}, Lcom/lidroid/xutils/bitmap/core/BitmapCache;->addBitmapToMemoryCache(Ljava/lang/String;Lcom/lidroid/xutils/bitmap/BitmapDisplayConfig;Landroid/graphics/Bitmap;J)Landroid/graphics/Bitmap;
    :try_end_1
    .catch Ljava/lang/Throwable; {:try_start_1 .. :try_end_1} :catch_1
    .catchall {:try_start_1 .. :try_end_1} :catchall_1

    move-result-object v0

    .line 288
    invoke-static {v7}, Lcom/lidroid/xutils/util/IOUtils;->closeQuietly(Ljava/io/Closeable;)V

    goto :goto_0

    .line 276
    :cond_4
    const/4 v0, 0x0

    :try_start_2
    invoke-virtual {v7, v0}, Lcom/lidroid/xutils/cache/LruDiskCache$Snapshot;->getInputStream(I)Ljava/io/FileInputStream;

    move-result-object v0

    invoke-virtual {v0}, Ljava/io/FileInputStream;->getFD()Ljava/io/FileDescriptor;

    move-result-object v0

    .line 277
    invoke-virtual {p2}, Lcom/lidroid/xutils/bitmap/BitmapDisplayConfig;->getBitmapMaxSize()Lcom/lidroid/xutils/bitmap/core/BitmapSize;

    move-result-object v1

    .line 278
    invoke-virtual {p2}, Lcom/lidroid/xutils/bitmap/BitmapDisplayConfig;->getBitmapConfig()Landroid/graphics/Bitmap$Config;

    move-result-object v2

    .line 275
    invoke-static {v0, v1, v2}, Lcom/lidroid/xutils/bitmap/core/BitmapDecoder;->decodeSampledBitmapFromDescriptor(Ljava/io/FileDescriptor;Lcom/lidroid/xutils/bitmap/core/BitmapSize;Landroid/graphics/Bitmap$Config;)Landroid/graphics/Bitmap;
    :try_end_2
    .catch Ljava/lang/Throwable; {:try_start_2 .. :try_end_2} :catch_1
    .catchall {:try_start_2 .. :try_end_2} :catchall_1

    move-result-object v0

    goto :goto_1

    .line 285
    :catch_0
    move-exception v0

    move-object v1, v6

    .line 286
    :goto_2
    :try_start_3
    invoke-virtual {v0}, Ljava/lang/Throwable;->getMessage()Ljava/lang/String;

    move-result-object v2

    invoke-static {v2, v0}, Lcom/lidroid/xutils/util/LogUtils;->e(Ljava/lang/String;Ljava/lang/Throwable;)V
    :try_end_3
    .catchall {:try_start_3 .. :try_end_3} :catchall_2

    .line 288
    invoke-static {v1}, Lcom/lidroid/xutils/util/IOUtils;->closeQuietly(Ljava/io/Closeable;)V

    :cond_5
    :goto_3
    move-object v0, v6

    .line 291
    goto :goto_0

    .line 287
    :catchall_0
    move-exception v0

    move-object v7, v6

    .line 288
    :goto_4
    invoke-static {v7}, Lcom/lidroid/xutils/util/IOUtils;->closeQuietly(Ljava/io/Closeable;)V

    .line 289
    throw v0

    .line 288
    :cond_6
    invoke-static {v7}, Lcom/lidroid/xutils/util/IOUtils;->closeQuietly(Ljava/io/Closeable;)V

    goto :goto_3

    .line 287
    :catchall_1
    move-exception v0

    goto :goto_4

    :catchall_2
    move-exception v0

    move-object v7, v1

    goto :goto_4

    .line 285
    :catch_1
    move-exception v0

    move-object v1, v7

    goto :goto_2
.end method

.method public getBitmapFromMemCache(Ljava/lang/String;Lcom/lidroid/xutils/bitmap/BitmapDisplayConfig;)Landroid/graphics/Bitmap;
    .locals 2

    .prologue
    const/4 v0, 0x0

    .line 230
    iget-object v1, p0, Lcom/lidroid/xutils/bitmap/core/BitmapCache;->mMemoryCache:Lcom/lidroid/xutils/cache/LruMemoryCache;

    if-eqz v1, :cond_0

    iget-object v1, p0, Lcom/lidroid/xutils/bitmap/core/BitmapCache;->globalConfig:Lcom/lidroid/xutils/bitmap/BitmapGlobalConfig;

    invoke-virtual {v1}, Lcom/lidroid/xutils/bitmap/BitmapGlobalConfig;->isMemoryCacheEnabled()Z

    move-result v1

    if-eqz v1, :cond_0

    .line 231
    new-instance v1, Lcom/lidroid/xutils/bitmap/core/BitmapCache$MemoryCacheKey;

    invoke-direct {v1, p0, p1, p2, v0}, Lcom/lidroid/xutils/bitmap/core/BitmapCache$MemoryCacheKey;-><init>(Lcom/lidroid/xutils/bitmap/core/BitmapCache;Ljava/lang/String;Lcom/lidroid/xutils/bitmap/BitmapDisplayConfig;Lcom/lidroid/xutils/bitmap/core/BitmapCache$MemoryCacheKey;)V

    .line 232
    iget-object v0, p0, Lcom/lidroid/xutils/bitmap/core/BitmapCache;->mMemoryCache:Lcom/lidroid/xutils/cache/LruMemoryCache;

    invoke-virtual {v0, v1}, Lcom/lidroid/xutils/cache/LruMemoryCache;->get(Ljava/lang/Object;)Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Landroid/graphics/Bitmap;

    .line 234
    :cond_0
    return-object v0
.end method

.method public initDiskCache()V
    .locals 7

    .prologue
    .line 91
    iget-object v4, p0, Lcom/lidroid/xutils/bitmap/core/BitmapCache;->mDiskCacheLock:Ljava/lang/Object;

    monitor-enter v4

    .line 92
    :try_start_0
    iget-object v0, p0, Lcom/lidroid/xutils/bitmap/core/BitmapCache;->globalConfig:Lcom/lidroid/xutils/bitmap/BitmapGlobalConfig;

    invoke-virtual {v0}, Lcom/lidroid/xutils/bitmap/BitmapGlobalConfig;->isDiskCacheEnabled()Z

    move-result v0

    if-eqz v0, :cond_2

    iget-object v0, p0, Lcom/lidroid/xutils/bitmap/core/BitmapCache;->mDiskLruCache:Lcom/lidroid/xutils/cache/LruDiskCache;

    if-eqz v0, :cond_0

    iget-object v0, p0, Lcom/lidroid/xutils/bitmap/core/BitmapCache;->mDiskLruCache:Lcom/lidroid/xutils/cache/LruDiskCache;

    invoke-virtual {v0}, Lcom/lidroid/xutils/cache/LruDiskCache;->isClosed()Z

    move-result v0

    if-eqz v0, :cond_2

    .line 93
    :cond_0
    new-instance v5, Ljava/io/File;

    iget-object v0, p0, Lcom/lidroid/xutils/bitmap/core/BitmapCache;->globalConfig:Lcom/lidroid/xutils/bitmap/BitmapGlobalConfig;

    invoke-virtual {v0}, Lcom/lidroid/xutils/bitmap/BitmapGlobalConfig;->getDiskCachePath()Ljava/lang/String;

    move-result-object v0

    invoke-direct {v5, v0}, Ljava/io/File;-><init>(Ljava/lang/String;)V

    .line 94
    invoke-virtual {v5}, Ljava/io/File;->exists()Z

    move-result v0

    if-nez v0, :cond_1

    invoke-virtual {v5}, Ljava/io/File;->mkdirs()Z

    move-result v0

    if-eqz v0, :cond_2

    .line 95
    :cond_1
    invoke-static {v5}, Lcom/lidroid/xutils/util/OtherUtils;->getAvailableSpace(Ljava/io/File;)J

    move-result-wide v2

    .line 96
    iget-object v0, p0, Lcom/lidroid/xutils/bitmap/core/BitmapCache;->globalConfig:Lcom/lidroid/xutils/bitmap/BitmapGlobalConfig;

    invoke-virtual {v0}, Lcom/lidroid/xutils/bitmap/BitmapGlobalConfig;->getDiskCacheSize()I
    :try_end_0
    .catchall {:try_start_0 .. :try_end_0} :catchall_0

    move-result v0

    int-to-long v0, v0

    .line 97
    cmp-long v6, v2, v0

    if-lez v6, :cond_3

    .line 99
    :goto_0
    const/4 v2, 0x1

    const/4 v3, 0x1

    :try_start_1
    invoke-static {v5, v2, v3, v0, v1}, Lcom/lidroid/xutils/cache/LruDiskCache;->open(Ljava/io/File;IIJ)Lcom/lidroid/xutils/cache/LruDiskCache;

    move-result-object v0

    iput-object v0, p0, Lcom/lidroid/xutils/bitmap/core/BitmapCache;->mDiskLruCache:Lcom/lidroid/xutils/cache/LruDiskCache;

    .line 100
    iget-object v0, p0, Lcom/lidroid/xutils/bitmap/core/BitmapCache;->mDiskLruCache:Lcom/lidroid/xutils/cache/LruDiskCache;

    iget-object v1, p0, Lcom/lidroid/xutils/bitmap/core/BitmapCache;->globalConfig:Lcom/lidroid/xutils/bitmap/BitmapGlobalConfig;

    invoke-virtual {v1}, Lcom/lidroid/xutils/bitmap/BitmapGlobalConfig;->getFileNameGenerator()Lcom/lidroid/xutils/cache/FileNameGenerator;

    move-result-object v1

    invoke-virtual {v0, v1}, Lcom/lidroid/xutils/cache/LruDiskCache;->setFileNameGenerator(Lcom/lidroid/xutils/cache/FileNameGenerator;)V

    .line 101
    const-string v0, "create disk cache success"

    invoke-static {v0}, Lcom/lidroid/xutils/util/LogUtils;->d(Ljava/lang/String;)V
    :try_end_1
    .catch Ljava/lang/Throwable; {:try_start_1 .. :try_end_1} :catch_0
    .catchall {:try_start_1 .. :try_end_1} :catchall_0

    .line 91
    :cond_2
    :goto_1
    :try_start_2
    monitor-exit v4

    .line 109
    return-void

    :cond_3
    move-wide v0, v2

    .line 97
    goto :goto_0

    .line 102
    :catch_0
    move-exception v0

    .line 103
    const/4 v1, 0x0

    iput-object v1, p0, Lcom/lidroid/xutils/bitmap/core/BitmapCache;->mDiskLruCache:Lcom/lidroid/xutils/cache/LruDiskCache;

    .line 104
    const-string v1, "create disk cache error"

    invoke-static {v1, v0}, Lcom/lidroid/xutils/util/LogUtils;->e(Ljava/lang/String;Ljava/lang/Throwable;)V

    goto :goto_1

    .line 91
    :catchall_0
    move-exception v0

    monitor-exit v4
    :try_end_2
    .catchall {:try_start_2 .. :try_end_2} :catchall_0

    throw v0
.end method

.method public initMemoryCache()V
    .locals 2

    .prologue
    .line 61
    iget-object v0, p0, Lcom/lidroid/xutils/bitmap/core/BitmapCache;->globalConfig:Lcom/lidroid/xutils/bitmap/BitmapGlobalConfig;

    invoke-virtual {v0}, Lcom/lidroid/xutils/bitmap/BitmapGlobalConfig;->isMemoryCacheEnabled()Z

    move-result v0

    if-nez v0, :cond_0

    .line 81
    :goto_0
    return-void

    .line 64
    :cond_0
    iget-object v0, p0, Lcom/lidroid/xutils/bitmap/core/BitmapCache;->mMemoryCache:Lcom/lidroid/xutils/cache/LruMemoryCache;

    if-eqz v0, :cond_1

    .line 66
    :try_start_0
    invoke-virtual {p0}, Lcom/lidroid/xutils/bitmap/core/BitmapCache;->clearMemoryCache()V
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_0

    .line 70
    :cond_1
    :goto_1
    new-instance v0, Lcom/lidroid/xutils/bitmap/core/BitmapCache$1;

    iget-object v1, p0, Lcom/lidroid/xutils/bitmap/core/BitmapCache;->globalConfig:Lcom/lidroid/xutils/bitmap/BitmapGlobalConfig;

    invoke-virtual {v1}, Lcom/lidroid/xutils/bitmap/BitmapGlobalConfig;->getMemoryCacheSize()I

    move-result v1

    invoke-direct {v0, p0, v1}, Lcom/lidroid/xutils/bitmap/core/BitmapCache$1;-><init>(Lcom/lidroid/xutils/bitmap/core/BitmapCache;I)V

    iput-object v0, p0, Lcom/lidroid/xutils/bitmap/core/BitmapCache;->mMemoryCache:Lcom/lidroid/xutils/cache/LruMemoryCache;

    goto :goto_0

    .line 67
    :catch_0
    move-exception v0

    goto :goto_1
.end method

.method public setDiskCacheFileNameGenerator(Lcom/lidroid/xutils/cache/FileNameGenerator;)V
    .locals 2

    .prologue
    .line 126
    iget-object v1, p0, Lcom/lidroid/xutils/bitmap/core/BitmapCache;->mDiskCacheLock:Ljava/lang/Object;

    monitor-enter v1

    .line 127
    :try_start_0
    iget-object v0, p0, Lcom/lidroid/xutils/bitmap/core/BitmapCache;->mDiskLruCache:Lcom/lidroid/xutils/cache/LruDiskCache;

    if-eqz v0, :cond_0

    if-eqz p1, :cond_0

    .line 128
    iget-object v0, p0, Lcom/lidroid/xutils/bitmap/core/BitmapCache;->mDiskLruCache:Lcom/lidroid/xutils/cache/LruDiskCache;

    invoke-virtual {v0, p1}, Lcom/lidroid/xutils/cache/LruDiskCache;->setFileNameGenerator(Lcom/lidroid/xutils/cache/FileNameGenerator;)V

    .line 126
    :cond_0
    monitor-exit v1

    .line 131
    return-void

    .line 126
    :catchall_0
    move-exception v0

    monitor-exit v1
    :try_end_0
    .catchall {:try_start_0 .. :try_end_0} :catchall_0

    throw v0
.end method

.method public setDiskCacheSize(I)V
    .locals 4

    .prologue
    .line 118
    iget-object v1, p0, Lcom/lidroid/xutils/bitmap/core/BitmapCache;->mDiskCacheLock:Ljava/lang/Object;

    monitor-enter v1

    .line 119
    :try_start_0
    iget-object v0, p0, Lcom/lidroid/xutils/bitmap/core/BitmapCache;->mDiskLruCache:Lcom/lidroid/xutils/cache/LruDiskCache;

    if-eqz v0, :cond_0

    .line 120
    iget-object v0, p0, Lcom/lidroid/xutils/bitmap/core/BitmapCache;->mDiskLruCache:Lcom/lidroid/xutils/cache/LruDiskCache;

    int-to-long v2, p1

    invoke-virtual {v0, v2, v3}, Lcom/lidroid/xutils/cache/LruDiskCache;->setMaxSize(J)V

    .line 118
    :cond_0
    monitor-exit v1

    .line 123
    return-void

    .line 118
    :catchall_0
    move-exception v0

    monitor-exit v1
    :try_end_0
    .catchall {:try_start_0 .. :try_end_0} :catchall_0

    throw v0
.end method

.method public setMemoryCacheSize(I)V
    .locals 1

    .prologue
    .line 112
    iget-object v0, p0, Lcom/lidroid/xutils/bitmap/core/BitmapCache;->mMemoryCache:Lcom/lidroid/xutils/cache/LruMemoryCache;

    if-eqz v0, :cond_0

    .line 113
    iget-object v0, p0, Lcom/lidroid/xutils/bitmap/core/BitmapCache;->mMemoryCache:Lcom/lidroid/xutils/cache/LruMemoryCache;

    invoke-virtual {v0, p1}, Lcom/lidroid/xutils/cache/LruMemoryCache;->setMaxSize(I)V

    .line 115
    :cond_0
    return-void
.end method
