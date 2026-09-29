.class public Lcom/cyjh/feedback/lib/utils/ImageLoader;
.super Ljava/lang/Object;
.source "ImageLoader.java"


# annotations
.annotation system Ldalvik/annotation/MemberClasses;
    value = {
        Lcom/cyjh/feedback/lib/utils/ImageLoader$ImageSize;,
        Lcom/cyjh/feedback/lib/utils/ImageLoader$ImageHolder;,
        Lcom/cyjh/feedback/lib/utils/ImageLoader$Type;
    }
.end annotation


# static fields
.field private static final DEFAULT_COUNT:I = 0x3

.field private static final DEFAULT_LOAD:I = 0x110

.field private static mImageLoader:Lcom/cyjh/feedback/lib/utils/ImageLoader;


# instance fields
.field private mLruCache:Landroid/util/LruCache;
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "Landroid/util/LruCache",
            "<",
            "Ljava/lang/String;",
            "Landroid/graphics/Bitmap;",
            ">;"
        }
    .end annotation
.end field

.field private mPoolThread:Ljava/util/concurrent/ExecutorService;

.field private mQueueList:Ljava/util/LinkedList;
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "Ljava/util/LinkedList",
            "<",
            "Ljava/lang/Runnable;",
            ">;"
        }
    .end annotation
.end field

.field private mSemaphoreThreadHandler:Ljava/util/concurrent/Semaphore;

.field private mSemaphoreThreadPool:Ljava/util/concurrent/Semaphore;

.field private mThreadBackground:Ljava/lang/Thread;

.field private mThreadHandler:Landroid/os/Handler;

.field private mType:Lcom/cyjh/feedback/lib/utils/ImageLoader$Type;

.field private mUIHandler:Landroid/os/Handler;


# direct methods
.method private constructor <init>(Lcom/cyjh/feedback/lib/utils/ImageLoader$Type;I)V
    .locals 2
    .param p1, "type"    # Lcom/cyjh/feedback/lib/utils/ImageLoader$Type;
    .param p2, "threadCount"    # I

    .prologue
    .line 81
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    .line 73
    new-instance v0, Ljava/util/concurrent/Semaphore;

    const/4 v1, 0x0

    invoke-direct {v0, v1}, Ljava/util/concurrent/Semaphore;-><init>(I)V

    iput-object v0, p0, Lcom/cyjh/feedback/lib/utils/ImageLoader;->mSemaphoreThreadHandler:Ljava/util/concurrent/Semaphore;

    .line 82
    invoke-direct {p0, p1, p2}, Lcom/cyjh/feedback/lib/utils/ImageLoader;->init(Lcom/cyjh/feedback/lib/utils/ImageLoader$Type;I)V

    .line 83
    return-void
.end method

.method static synthetic access$002(Lcom/cyjh/feedback/lib/utils/ImageLoader;Landroid/os/Handler;)Landroid/os/Handler;
    .locals 0
    .param p0, "x0"    # Lcom/cyjh/feedback/lib/utils/ImageLoader;
    .param p1, "x1"    # Landroid/os/Handler;

    .prologue
    .line 24
    iput-object p1, p0, Lcom/cyjh/feedback/lib/utils/ImageLoader;->mThreadHandler:Landroid/os/Handler;

    return-object p1
.end method

.method static synthetic access$100(Lcom/cyjh/feedback/lib/utils/ImageLoader;)Ljava/lang/Runnable;
    .locals 1
    .param p0, "x0"    # Lcom/cyjh/feedback/lib/utils/ImageLoader;

    .prologue
    .line 24
    invoke-direct {p0}, Lcom/cyjh/feedback/lib/utils/ImageLoader;->getTask()Ljava/lang/Runnable;

    move-result-object v0

    return-object v0
.end method

.method static synthetic access$200(Lcom/cyjh/feedback/lib/utils/ImageLoader;)Ljava/util/concurrent/ExecutorService;
    .locals 1
    .param p0, "x0"    # Lcom/cyjh/feedback/lib/utils/ImageLoader;

    .prologue
    .line 24
    iget-object v0, p0, Lcom/cyjh/feedback/lib/utils/ImageLoader;->mPoolThread:Ljava/util/concurrent/ExecutorService;

    return-object v0
.end method

.method static synthetic access$300(Lcom/cyjh/feedback/lib/utils/ImageLoader;)Ljava/util/concurrent/Semaphore;
    .locals 1
    .param p0, "x0"    # Lcom/cyjh/feedback/lib/utils/ImageLoader;

    .prologue
    .line 24
    iget-object v0, p0, Lcom/cyjh/feedback/lib/utils/ImageLoader;->mSemaphoreThreadPool:Ljava/util/concurrent/Semaphore;

    return-object v0
.end method

.method static synthetic access$400(Lcom/cyjh/feedback/lib/utils/ImageLoader;)Ljava/util/concurrent/Semaphore;
    .locals 1
    .param p0, "x0"    # Lcom/cyjh/feedback/lib/utils/ImageLoader;

    .prologue
    .line 24
    iget-object v0, p0, Lcom/cyjh/feedback/lib/utils/ImageLoader;->mSemaphoreThreadHandler:Ljava/util/concurrent/Semaphore;

    return-object v0
.end method

.method static synthetic access$500(Lcom/cyjh/feedback/lib/utils/ImageLoader;Landroid/widget/ImageView;)Lcom/cyjh/feedback/lib/utils/ImageLoader$ImageSize;
    .locals 1
    .param p0, "x0"    # Lcom/cyjh/feedback/lib/utils/ImageLoader;
    .param p1, "x1"    # Landroid/widget/ImageView;

    .prologue
    .line 24
    invoke-direct {p0, p1}, Lcom/cyjh/feedback/lib/utils/ImageLoader;->getImageViewSize(Landroid/widget/ImageView;)Lcom/cyjh/feedback/lib/utils/ImageLoader$ImageSize;

    move-result-object v0

    return-object v0
.end method

.method static synthetic access$600(Lcom/cyjh/feedback/lib/utils/ImageLoader;Ljava/lang/String;Lcom/cyjh/feedback/lib/utils/ImageLoader$ImageSize;)Landroid/graphics/Bitmap;
    .locals 1
    .param p0, "x0"    # Lcom/cyjh/feedback/lib/utils/ImageLoader;
    .param p1, "x1"    # Ljava/lang/String;
    .param p2, "x2"    # Lcom/cyjh/feedback/lib/utils/ImageLoader$ImageSize;

    .prologue
    .line 24
    invoke-direct {p0, p1, p2}, Lcom/cyjh/feedback/lib/utils/ImageLoader;->decodeSampleBitmapFormPath(Ljava/lang/String;Lcom/cyjh/feedback/lib/utils/ImageLoader$ImageSize;)Landroid/graphics/Bitmap;

    move-result-object v0

    return-object v0
.end method

.method static synthetic access$700(Lcom/cyjh/feedback/lib/utils/ImageLoader;Landroid/graphics/Bitmap;Ljava/lang/String;)V
    .locals 0
    .param p0, "x0"    # Lcom/cyjh/feedback/lib/utils/ImageLoader;
    .param p1, "x1"    # Landroid/graphics/Bitmap;
    .param p2, "x2"    # Ljava/lang/String;

    .prologue
    .line 24
    invoke-direct {p0, p1, p2}, Lcom/cyjh/feedback/lib/utils/ImageLoader;->addBitmapToLruCache(Landroid/graphics/Bitmap;Ljava/lang/String;)V

    return-void
.end method

.method static synthetic access$800(Lcom/cyjh/feedback/lib/utils/ImageLoader;Landroid/graphics/Bitmap;Ljava/lang/String;Landroid/widget/ImageView;)V
    .locals 0
    .param p0, "x0"    # Lcom/cyjh/feedback/lib/utils/ImageLoader;
    .param p1, "x1"    # Landroid/graphics/Bitmap;
    .param p2, "x2"    # Ljava/lang/String;
    .param p3, "x3"    # Landroid/widget/ImageView;

    .prologue
    .line 24
    invoke-direct {p0, p1, p2, p3}, Lcom/cyjh/feedback/lib/utils/ImageLoader;->refreshBitmap(Landroid/graphics/Bitmap;Ljava/lang/String;Landroid/widget/ImageView;)V

    return-void
.end method

.method private addBitmapToLruCache(Landroid/graphics/Bitmap;Ljava/lang/String;)V
    .locals 1
    .param p1, "bitmap"    # Landroid/graphics/Bitmap;
    .param p2, "path"    # Ljava/lang/String;

    .prologue
    .line 229
    invoke-direct {p0, p2}, Lcom/cyjh/feedback/lib/utils/ImageLoader;->getBitmapFromLruCache(Ljava/lang/String;)Landroid/graphics/Bitmap;

    move-result-object v0

    if-nez v0, :cond_0

    .line 230
    if-eqz p1, :cond_0

    .line 231
    iget-object v0, p0, Lcom/cyjh/feedback/lib/utils/ImageLoader;->mLruCache:Landroid/util/LruCache;

    invoke-virtual {v0, p2, p1}, Landroid/util/LruCache;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    .line 234
    :cond_0
    return-void
.end method

.method private declared-synchronized addTask(Ljava/lang/Runnable;)V
    .locals 3
    .param p1, "runnable"    # Ljava/lang/Runnable;

    .prologue
    .line 341
    monitor-enter p0

    :try_start_0
    iget-object v1, p0, Lcom/cyjh/feedback/lib/utils/ImageLoader;->mQueueList:Ljava/util/LinkedList;

    invoke-virtual {v1, p1}, Ljava/util/LinkedList;->add(Ljava/lang/Object;)Z
    :try_end_0
    .catchall {:try_start_0 .. :try_end_0} :catchall_0

    .line 346
    :try_start_1
    iget-object v1, p0, Lcom/cyjh/feedback/lib/utils/ImageLoader;->mThreadHandler:Landroid/os/Handler;

    if-nez v1, :cond_0

    .line 347
    iget-object v1, p0, Lcom/cyjh/feedback/lib/utils/ImageLoader;->mSemaphoreThreadHandler:Ljava/util/concurrent/Semaphore;

    invoke-virtual {v1}, Ljava/util/concurrent/Semaphore;->acquire()V
    :try_end_1
    .catch Ljava/lang/InterruptedException; {:try_start_1 .. :try_end_1} :catch_0
    .catchall {:try_start_1 .. :try_end_1} :catchall_0

    .line 353
    :cond_0
    :goto_0
    :try_start_2
    iget-object v1, p0, Lcom/cyjh/feedback/lib/utils/ImageLoader;->mThreadHandler:Landroid/os/Handler;

    const/16 v2, 0x110

    invoke-virtual {v1, v2}, Landroid/os/Handler;->sendEmptyMessage(I)Z
    :try_end_2
    .catchall {:try_start_2 .. :try_end_2} :catchall_0

    .line 354
    monitor-exit p0

    return-void

    .line 349
    :catch_0
    move-exception v0

    .line 350
    .local v0, "e":Ljava/lang/InterruptedException;
    :try_start_3
    invoke-virtual {v0}, Ljava/lang/InterruptedException;->printStackTrace()V
    :try_end_3
    .catchall {:try_start_3 .. :try_end_3} :catchall_0

    goto :goto_0

    .line 341
    .end local v0    # "e":Ljava/lang/InterruptedException;
    :catchall_0
    move-exception v1

    monitor-exit p0

    throw v1
.end method

.method private calculateInSample(Landroid/graphics/BitmapFactory$Options;Lcom/cyjh/feedback/lib/utils/ImageLoader$ImageSize;)I
    .locals 8
    .param p1, "options"    # Landroid/graphics/BitmapFactory$Options;
    .param p2, "imageSize"    # Lcom/cyjh/feedback/lib/utils/ImageLoader$ImageSize;

    .prologue
    const/high16 v7, 0x3f800000    # 1.0f

    .line 259
    iget v3, p1, Landroid/graphics/BitmapFactory$Options;->outWidth:I

    .line 260
    .local v3, "width":I
    iget v0, p1, Landroid/graphics/BitmapFactory$Options;->outHeight:I

    .line 261
    .local v0, "height":I
    const/4 v2, 0x1

    .line 262
    .local v2, "inSampleSize":I
    iget v5, p2, Lcom/cyjh/feedback/lib/utils/ImageLoader$ImageSize;->imageWidth:I

    if-gt v3, v5, :cond_0

    iget v5, p2, Lcom/cyjh/feedback/lib/utils/ImageLoader$ImageSize;->imageHeight:I

    if-le v0, v5, :cond_1

    .line 263
    :cond_0
    int-to-float v5, v3

    mul-float/2addr v5, v7

    iget v6, p2, Lcom/cyjh/feedback/lib/utils/ImageLoader$ImageSize;->imageWidth:I

    int-to-float v6, v6

    div-float/2addr v5, v6

    invoke-static {v5}, Ljava/lang/Math;->round(F)I

    move-result v4

    .line 264
    .local v4, "widthRatio":I
    int-to-float v5, v0

    mul-float/2addr v5, v7

    iget v6, p2, Lcom/cyjh/feedback/lib/utils/ImageLoader$ImageSize;->imageHeight:I

    int-to-float v6, v6

    div-float/2addr v5, v6

    invoke-static {v5}, Ljava/lang/Math;->round(F)I

    move-result v1

    .line 265
    .local v1, "heightRatio":I
    invoke-static {v4, v1}, Ljava/lang/Math;->max(II)I

    move-result v2

    .line 267
    .end local v1    # "heightRatio":I
    .end local v4    # "widthRatio":I
    :cond_1
    return v2
.end method

.method private decodeSampleBitmapFormPath(Ljava/lang/String;Lcom/cyjh/feedback/lib/utils/ImageLoader$ImageSize;)Landroid/graphics/Bitmap;
    .locals 2
    .param p1, "path"    # Ljava/lang/String;
    .param p2, "imageSize"    # Lcom/cyjh/feedback/lib/utils/ImageLoader$ImageSize;

    .prologue
    .line 243
    new-instance v0, Landroid/graphics/BitmapFactory$Options;

    invoke-direct {v0}, Landroid/graphics/BitmapFactory$Options;-><init>()V

    .line 244
    .local v0, "options":Landroid/graphics/BitmapFactory$Options;
    const/4 v1, 0x1

    iput-boolean v1, v0, Landroid/graphics/BitmapFactory$Options;->inJustDecodeBounds:Z

    .line 245
    invoke-static {p1, v0}, Landroid/graphics/BitmapFactory;->decodeFile(Ljava/lang/String;Landroid/graphics/BitmapFactory$Options;)Landroid/graphics/Bitmap;

    .line 247
    invoke-direct {p0, v0, p2}, Lcom/cyjh/feedback/lib/utils/ImageLoader;->calculateInSample(Landroid/graphics/BitmapFactory$Options;Lcom/cyjh/feedback/lib/utils/ImageLoader$ImageSize;)I

    move-result v1

    iput v1, v0, Landroid/graphics/BitmapFactory$Options;->inSampleSize:I

    .line 248
    const/4 v1, 0x0

    iput-boolean v1, v0, Landroid/graphics/BitmapFactory$Options;->inJustDecodeBounds:Z

    .line 249
    invoke-static {p1, v0}, Landroid/graphics/BitmapFactory;->decodeFile(Ljava/lang/String;Landroid/graphics/BitmapFactory$Options;)Landroid/graphics/Bitmap;

    move-result-object v1

    return-object v1
.end method

.method private getBitmapFromLruCache(Ljava/lang/String;)Landroid/graphics/Bitmap;
    .locals 1
    .param p1, "path"    # Ljava/lang/String;

    .prologue
    .line 362
    iget-object v0, p0, Lcom/cyjh/feedback/lib/utils/ImageLoader;->mLruCache:Landroid/util/LruCache;

    invoke-virtual {v0, p1}, Landroid/util/LruCache;->get(Ljava/lang/Object;)Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Landroid/graphics/Bitmap;

    return-object v0
.end method

.method private getImageViewFiled(Ljava/lang/Object;Ljava/lang/String;)I
    .locals 5
    .param p1, "object"    # Ljava/lang/Object;
    .param p2, "fieldName"    # Ljava/lang/String;

    .prologue
    .line 322
    const/4 v3, 0x0

    .line 324
    .local v3, "value":I
    :try_start_0
    const-class v4, Landroid/widget/ImageView;

    invoke-virtual {v4, p2}, Ljava/lang/Class;->getDeclaredField(Ljava/lang/String;)Ljava/lang/reflect/Field;

    move-result-object v2

    .line 325
    .local v2, "mField":Ljava/lang/reflect/Field;
    const/4 v4, 0x1

    invoke-virtual {v2, v4}, Ljava/lang/reflect/Field;->setAccessible(Z)V

    .line 326
    invoke-virtual {v2, p1}, Ljava/lang/reflect/Field;->getInt(Ljava/lang/Object;)I
    :try_end_0
    .catch Ljava/lang/Exception; {:try_start_0 .. :try_end_0} :catch_0

    move-result v1

    .line 327
    .local v1, "fieldValue":I
    if-lez v1, :cond_0

    const v4, 0x7fffffff

    if-ge v1, v4, :cond_0

    .line 328
    move v3, v1

    .line 333
    .end local v1    # "fieldValue":I
    .end local v2    # "mField":Ljava/lang/reflect/Field;
    :cond_0
    :goto_0
    return v3

    .line 330
    :catch_0
    move-exception v0

    .line 331
    .local v0, "e":Ljava/lang/Exception;
    invoke-virtual {v0}, Ljava/lang/Exception;->printStackTrace()V

    goto :goto_0
.end method

.method private getImageViewSize(Landroid/widget/ImageView;)Lcom/cyjh/feedback/lib/utils/ImageLoader$ImageSize;
    .locals 6
    .param p1, "imageView"    # Landroid/widget/ImageView;

    .prologue
    .line 275
    invoke-virtual {p1}, Landroid/widget/ImageView;->getContext()Landroid/content/Context;

    move-result-object v5

    invoke-virtual {v5}, Landroid/content/Context;->getResources()Landroid/content/res/Resources;

    move-result-object v5

    invoke-virtual {v5}, Landroid/content/res/Resources;->getDisplayMetrics()Landroid/util/DisplayMetrics;

    move-result-object v2

    .line 276
    .local v2, "metrics":Landroid/util/DisplayMetrics;
    invoke-virtual {p1}, Landroid/widget/ImageView;->getLayoutParams()Landroid/view/ViewGroup$LayoutParams;

    move-result-object v3

    .line 278
    .local v3, "params":Landroid/view/ViewGroup$LayoutParams;
    invoke-virtual {p1}, Landroid/widget/ImageView;->getWidth()I

    move-result v4

    .line 279
    .local v4, "width":I
    if-gtz v4, :cond_0

    .line 281
    iget v4, v3, Landroid/view/ViewGroup$LayoutParams;->width:I

    .line 283
    :cond_0
    if-gtz v4, :cond_1

    .line 286
    const-string v5, "mMaxWidth"

    invoke-direct {p0, p1, v5}, Lcom/cyjh/feedback/lib/utils/ImageLoader;->getImageViewFiled(Ljava/lang/Object;Ljava/lang/String;)I

    move-result v4

    .line 288
    :cond_1
    if-gtz v4, :cond_2

    .line 290
    iget v4, v2, Landroid/util/DisplayMetrics;->widthPixels:I

    .line 294
    :cond_2
    invoke-virtual {p1}, Landroid/widget/ImageView;->getHeight()I

    move-result v0

    .line 295
    .local v0, "height":I
    if-gtz v0, :cond_3

    .line 297
    iget v0, v3, Landroid/view/ViewGroup$LayoutParams;->height:I

    .line 299
    :cond_3
    if-gtz v0, :cond_4

    .line 302
    const-string v5, "mMaxHeight"

    invoke-direct {p0, p1, v5}, Lcom/cyjh/feedback/lib/utils/ImageLoader;->getImageViewFiled(Ljava/lang/Object;Ljava/lang/String;)I

    move-result v0

    .line 304
    :cond_4
    if-gtz v0, :cond_5

    .line 306
    iget v0, v2, Landroid/util/DisplayMetrics;->heightPixels:I

    .line 309
    :cond_5
    new-instance v1, Lcom/cyjh/feedback/lib/utils/ImageLoader$ImageSize;

    invoke-direct {v1, p0}, Lcom/cyjh/feedback/lib/utils/ImageLoader$ImageSize;-><init>(Lcom/cyjh/feedback/lib/utils/ImageLoader;)V

    .line 310
    .local v1, "imageSize":Lcom/cyjh/feedback/lib/utils/ImageLoader$ImageSize;
    iput v4, v1, Lcom/cyjh/feedback/lib/utils/ImageLoader$ImageSize;->imageWidth:I

    .line 311
    iput v0, v1, Lcom/cyjh/feedback/lib/utils/ImageLoader$ImageSize;->imageHeight:I

    .line 312
    return-object v1
.end method

.method public static getInstance()Lcom/cyjh/feedback/lib/utils/ImageLoader;
    .locals 4

    .prologue
    .line 145
    sget-object v0, Lcom/cyjh/feedback/lib/utils/ImageLoader;->mImageLoader:Lcom/cyjh/feedback/lib/utils/ImageLoader;

    if-nez v0, :cond_1

    .line 146
    const-class v1, Lcom/cyjh/feedback/lib/utils/ImageLoader;

    monitor-enter v1

    .line 147
    :try_start_0
    sget-object v0, Lcom/cyjh/feedback/lib/utils/ImageLoader;->mImageLoader:Lcom/cyjh/feedback/lib/utils/ImageLoader;

    if-nez v0, :cond_0

    .line 148
    new-instance v0, Lcom/cyjh/feedback/lib/utils/ImageLoader;

    sget-object v2, Lcom/cyjh/feedback/lib/utils/ImageLoader$Type;->FILO:Lcom/cyjh/feedback/lib/utils/ImageLoader$Type;

    const/4 v3, 0x3

    invoke-direct {v0, v2, v3}, Lcom/cyjh/feedback/lib/utils/ImageLoader;-><init>(Lcom/cyjh/feedback/lib/utils/ImageLoader$Type;I)V

    sput-object v0, Lcom/cyjh/feedback/lib/utils/ImageLoader;->mImageLoader:Lcom/cyjh/feedback/lib/utils/ImageLoader;

    .line 150
    :cond_0
    monitor-exit v1
    :try_end_0
    .catchall {:try_start_0 .. :try_end_0} :catchall_0

    .line 152
    :cond_1
    sget-object v0, Lcom/cyjh/feedback/lib/utils/ImageLoader;->mImageLoader:Lcom/cyjh/feedback/lib/utils/ImageLoader;

    return-object v0

    .line 150
    :catchall_0
    move-exception v0

    :try_start_1
    monitor-exit v1
    :try_end_1
    .catchall {:try_start_1 .. :try_end_1} :catchall_0

    throw v0
.end method

.method public static getInstance(Lcom/cyjh/feedback/lib/utils/ImageLoader$Type;I)Lcom/cyjh/feedback/lib/utils/ImageLoader;
    .locals 2
    .param p0, "type"    # Lcom/cyjh/feedback/lib/utils/ImageLoader$Type;
    .param p1, "threadCount"    # I

    .prologue
    .line 156
    sget-object v0, Lcom/cyjh/feedback/lib/utils/ImageLoader;->mImageLoader:Lcom/cyjh/feedback/lib/utils/ImageLoader;

    if-nez v0, :cond_1

    .line 157
    const-class v1, Lcom/cyjh/feedback/lib/utils/ImageLoader;

    monitor-enter v1

    .line 158
    :try_start_0
    sget-object v0, Lcom/cyjh/feedback/lib/utils/ImageLoader;->mImageLoader:Lcom/cyjh/feedback/lib/utils/ImageLoader;

    if-nez v0, :cond_0

    .line 159
    new-instance v0, Lcom/cyjh/feedback/lib/utils/ImageLoader;

    invoke-direct {v0, p0, p1}, Lcom/cyjh/feedback/lib/utils/ImageLoader;-><init>(Lcom/cyjh/feedback/lib/utils/ImageLoader$Type;I)V

    sput-object v0, Lcom/cyjh/feedback/lib/utils/ImageLoader;->mImageLoader:Lcom/cyjh/feedback/lib/utils/ImageLoader;

    .line 161
    :cond_0
    monitor-exit v1
    :try_end_0
    .catchall {:try_start_0 .. :try_end_0} :catchall_0

    .line 163
    :cond_1
    sget-object v0, Lcom/cyjh/feedback/lib/utils/ImageLoader;->mImageLoader:Lcom/cyjh/feedback/lib/utils/ImageLoader;

    return-object v0

    .line 161
    :catchall_0
    move-exception v0

    :try_start_1
    monitor-exit v1
    :try_end_1
    .catchall {:try_start_1 .. :try_end_1} :catchall_0

    throw v0
.end method

.method private getTask()Ljava/lang/Runnable;
    .locals 2

    .prologue
    .line 136
    sget-object v0, Lcom/cyjh/feedback/lib/utils/ImageLoader$Type;->FIFO:Lcom/cyjh/feedback/lib/utils/ImageLoader$Type;

    iget-object v1, p0, Lcom/cyjh/feedback/lib/utils/ImageLoader;->mType:Lcom/cyjh/feedback/lib/utils/ImageLoader$Type;

    if-ne v0, v1, :cond_0

    .line 137
    iget-object v0, p0, Lcom/cyjh/feedback/lib/utils/ImageLoader;->mQueueList:Ljava/util/LinkedList;

    invoke-virtual {v0}, Ljava/util/LinkedList;->removeFirst()Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Ljava/lang/Runnable;

    .line 141
    :goto_0
    return-object v0

    .line 138
    :cond_0
    sget-object v0, Lcom/cyjh/feedback/lib/utils/ImageLoader$Type;->FILO:Lcom/cyjh/feedback/lib/utils/ImageLoader$Type;

    iget-object v1, p0, Lcom/cyjh/feedback/lib/utils/ImageLoader;->mType:Lcom/cyjh/feedback/lib/utils/ImageLoader$Type;

    if-ne v0, v1, :cond_1

    .line 139
    iget-object v0, p0, Lcom/cyjh/feedback/lib/utils/ImageLoader;->mQueueList:Ljava/util/LinkedList;

    invoke-virtual {v0}, Ljava/util/LinkedList;->removeLast()Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Ljava/lang/Runnable;

    goto :goto_0

    .line 141
    :cond_1
    const/4 v0, 0x0

    goto :goto_0
.end method

.method private init(Lcom/cyjh/feedback/lib/utils/ImageLoader$Type;I)V
    .locals 4
    .param p1, "type"    # Lcom/cyjh/feedback/lib/utils/ImageLoader$Type;
    .param p2, "threadCount"    # I

    .prologue
    .line 86
    iput-object p1, p0, Lcom/cyjh/feedback/lib/utils/ImageLoader;->mType:Lcom/cyjh/feedback/lib/utils/ImageLoader$Type;

    .line 87
    new-instance v2, Ljava/util/concurrent/Semaphore;

    invoke-direct {v2, p2}, Ljava/util/concurrent/Semaphore;-><init>(I)V

    iput-object v2, p0, Lcom/cyjh/feedback/lib/utils/ImageLoader;->mSemaphoreThreadPool:Ljava/util/concurrent/Semaphore;

    .line 89
    new-instance v2, Lcom/cyjh/feedback/lib/utils/ImageLoader$1;

    invoke-direct {v2, p0}, Lcom/cyjh/feedback/lib/utils/ImageLoader$1;-><init>(Lcom/cyjh/feedback/lib/utils/ImageLoader;)V

    iput-object v2, p0, Lcom/cyjh/feedback/lib/utils/ImageLoader;->mThreadBackground:Ljava/lang/Thread;

    .line 113
    iget-object v2, p0, Lcom/cyjh/feedback/lib/utils/ImageLoader;->mThreadBackground:Ljava/lang/Thread;

    invoke-virtual {v2}, Ljava/lang/Thread;->start()V

    .line 115
    invoke-static {}, Ljava/lang/Runtime;->getRuntime()Ljava/lang/Runtime;

    move-result-object v2

    invoke-virtual {v2}, Ljava/lang/Runtime;->maxMemory()J

    move-result-wide v2

    long-to-int v1, v2

    .line 116
    .local v1, "maxMemory":I
    div-int/lit8 v0, v1, 0x8

    .line 117
    .local v0, "cacheMemory":I
    new-instance v2, Lcom/cyjh/feedback/lib/utils/ImageLoader$2;

    invoke-direct {v2, p0, v0}, Lcom/cyjh/feedback/lib/utils/ImageLoader$2;-><init>(Lcom/cyjh/feedback/lib/utils/ImageLoader;I)V

    iput-object v2, p0, Lcom/cyjh/feedback/lib/utils/ImageLoader;->mLruCache:Landroid/util/LruCache;

    .line 126
    new-instance v2, Ljava/util/LinkedList;

    invoke-direct {v2}, Ljava/util/LinkedList;-><init>()V

    iput-object v2, p0, Lcom/cyjh/feedback/lib/utils/ImageLoader;->mQueueList:Ljava/util/LinkedList;

    .line 128
    invoke-static {p2}, Ljava/util/concurrent/Executors;->newFixedThreadPool(I)Ljava/util/concurrent/ExecutorService;

    move-result-object v2

    iput-object v2, p0, Lcom/cyjh/feedback/lib/utils/ImageLoader;->mPoolThread:Ljava/util/concurrent/ExecutorService;

    .line 129
    return-void
.end method

.method private refreshBitmap(Landroid/graphics/Bitmap;Ljava/lang/String;Landroid/widget/ImageView;)V
    .locals 3
    .param p1, "bitmap"    # Landroid/graphics/Bitmap;
    .param p2, "path"    # Ljava/lang/String;
    .param p3, "mImageview"    # Landroid/widget/ImageView;

    .prologue
    .line 214
    new-instance v0, Lcom/cyjh/feedback/lib/utils/ImageLoader$ImageHolder;

    invoke-direct {v0, p0}, Lcom/cyjh/feedback/lib/utils/ImageLoader$ImageHolder;-><init>(Lcom/cyjh/feedback/lib/utils/ImageLoader;)V

    .line 215
    .local v0, "mImageHolder":Lcom/cyjh/feedback/lib/utils/ImageLoader$ImageHolder;
    iput-object p1, v0, Lcom/cyjh/feedback/lib/utils/ImageLoader$ImageHolder;->bitmap:Landroid/graphics/Bitmap;

    .line 216
    iput-object p2, v0, Lcom/cyjh/feedback/lib/utils/ImageLoader$ImageHolder;->path:Ljava/lang/String;

    .line 217
    iput-object p3, v0, Lcom/cyjh/feedback/lib/utils/ImageLoader$ImageHolder;->imageView:Landroid/widget/ImageView;

    .line 218
    iget-object v2, p0, Lcom/cyjh/feedback/lib/utils/ImageLoader;->mUIHandler:Landroid/os/Handler;

    invoke-virtual {v2}, Landroid/os/Handler;->obtainMessage()Landroid/os/Message;

    move-result-object v1

    .line 219
    .local v1, "message":Landroid/os/Message;
    iput-object v0, v1, Landroid/os/Message;->obj:Ljava/lang/Object;

    .line 220
    iget-object v2, p0, Lcom/cyjh/feedback/lib/utils/ImageLoader;->mUIHandler:Landroid/os/Handler;

    invoke-virtual {v2, v1}, Landroid/os/Handler;->sendMessage(Landroid/os/Message;)Z

    .line 221
    return-void
.end method


# virtual methods
.method public imageLoader(Ljava/lang/String;Landroid/widget/ImageView;)V
    .locals 2
    .param p1, "path"    # Ljava/lang/String;
    .param p2, "mImageview"    # Landroid/widget/ImageView;

    .prologue
    .line 173
    invoke-virtual {p2, p1}, Landroid/widget/ImageView;->setTag(Ljava/lang/Object;)V

    .line 174
    iget-object v1, p0, Lcom/cyjh/feedback/lib/utils/ImageLoader;->mUIHandler:Landroid/os/Handler;

    if-nez v1, :cond_0

    .line 175
    new-instance v1, Lcom/cyjh/feedback/lib/utils/ImageLoader$3;

    invoke-direct {v1, p0}, Lcom/cyjh/feedback/lib/utils/ImageLoader$3;-><init>(Lcom/cyjh/feedback/lib/utils/ImageLoader;)V

    iput-object v1, p0, Lcom/cyjh/feedback/lib/utils/ImageLoader;->mUIHandler:Landroid/os/Handler;

    .line 190
    :cond_0
    invoke-direct {p0, p1}, Lcom/cyjh/feedback/lib/utils/ImageLoader;->getBitmapFromLruCache(Ljava/lang/String;)Landroid/graphics/Bitmap;

    move-result-object v0

    .line 191
    .local v0, "bitmap":Landroid/graphics/Bitmap;
    if-eqz v0, :cond_1

    .line 192
    invoke-direct {p0, v0, p1, p2}, Lcom/cyjh/feedback/lib/utils/ImageLoader;->refreshBitmap(Landroid/graphics/Bitmap;Ljava/lang/String;Landroid/widget/ImageView;)V

    .line 211
    :goto_0
    return-void

    .line 195
    :cond_1
    new-instance v1, Lcom/cyjh/feedback/lib/utils/ImageLoader$4;

    invoke-direct {v1, p0, p2, p1}, Lcom/cyjh/feedback/lib/utils/ImageLoader$4;-><init>(Lcom/cyjh/feedback/lib/utils/ImageLoader;Landroid/widget/ImageView;Ljava/lang/String;)V

    invoke-direct {p0, v1}, Lcom/cyjh/feedback/lib/utils/ImageLoader;->addTask(Ljava/lang/Runnable;)V

    goto :goto_0
.end method
