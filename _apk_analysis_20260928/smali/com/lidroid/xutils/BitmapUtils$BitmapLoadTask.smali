.class public Lcom/lidroid/xutils/BitmapUtils$BitmapLoadTask;
.super Lcom/lidroid/xutils/task/PriorityAsyncTask;
.source "SourceFile"


# annotations
.annotation system Ldalvik/annotation/EnclosingClass;
    value = Lcom/lidroid/xutils/BitmapUtils;
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x1
    name = "BitmapLoadTask"
.end annotation

.annotation system Ldalvik/annotation/Signature;
    value = {
        "<T:",
        "Landroid/view/View;",
        ">",
        "Lcom/lidroid/xutils/task/PriorityAsyncTask",
        "<",
        "Ljava/lang/Object;",
        "Ljava/lang/Object;",
        "Landroid/graphics/Bitmap;",
        ">;"
    }
.end annotation


# static fields
.field private static final PROGRESS_LOADING:I = 0x1

.field private static final PROGRESS_LOAD_STARTED:I


# instance fields
.field private final callBack:Lcom/lidroid/xutils/bitmap/callback/BitmapLoadCallBack;
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "Lcom/lidroid/xutils/bitmap/callback/BitmapLoadCallBack",
            "<TT;>;"
        }
    .end annotation
.end field

.field private final containerReference:Ljava/lang/ref/WeakReference;
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "Ljava/lang/ref/WeakReference",
            "<TT;>;"
        }
    .end annotation
.end field

.field private final displayConfig:Lcom/lidroid/xutils/bitmap/BitmapDisplayConfig;

.field private from:Lcom/lidroid/xutils/bitmap/callback/BitmapLoadFrom;

.field final synthetic this$0:Lcom/lidroid/xutils/BitmapUtils;

.field private final uri:Ljava/lang/String;


# direct methods
.method public constructor <init>(Lcom/lidroid/xutils/BitmapUtils;Landroid/view/View;Ljava/lang/String;Lcom/lidroid/xutils/bitmap/BitmapDisplayConfig;Lcom/lidroid/xutils/bitmap/callback/BitmapLoadCallBack;)V
    .locals 2
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "(TT;",
            "Ljava/lang/String;",
            "Lcom/lidroid/xutils/bitmap/BitmapDisplayConfig;",
            "Lcom/lidroid/xutils/bitmap/callback/BitmapLoadCallBack",
            "<TT;>;)V"
        }
    .end annotation

    .prologue
    .line 405
    iput-object p1, p0, Lcom/lidroid/xutils/BitmapUtils$BitmapLoadTask;->this$0:Lcom/lidroid/xutils/BitmapUtils;

    invoke-direct {p0}, Lcom/lidroid/xutils/task/PriorityAsyncTask;-><init>()V

    .line 403
    sget-object v0, Lcom/lidroid/xutils/bitmap/callback/BitmapLoadFrom;->DISK_CACHE:Lcom/lidroid/xutils/bitmap/callback/BitmapLoadFrom;

    iput-object v0, p0, Lcom/lidroid/xutils/BitmapUtils$BitmapLoadTask;->from:Lcom/lidroid/xutils/bitmap/callback/BitmapLoadFrom;

    .line 406
    if-eqz p2, :cond_0

    if-eqz p3, :cond_0

    if-eqz p4, :cond_0

    if-nez p5, :cond_1

    .line 407
    :cond_0
    new-instance v0, Ljava/lang/IllegalArgumentException;

    const-string v1, "args may not be null"

    invoke-direct {v0, v1}, Ljava/lang/IllegalArgumentException;-><init>(Ljava/lang/String;)V

    throw v0

    .line 410
    :cond_1
    new-instance v0, Ljava/lang/ref/WeakReference;

    invoke-direct {v0, p2}, Ljava/lang/ref/WeakReference;-><init>(Ljava/lang/Object;)V

    iput-object v0, p0, Lcom/lidroid/xutils/BitmapUtils$BitmapLoadTask;->containerReference:Ljava/lang/ref/WeakReference;

    .line 411
    iput-object p5, p0, Lcom/lidroid/xutils/BitmapUtils$BitmapLoadTask;->callBack:Lcom/lidroid/xutils/bitmap/callback/BitmapLoadCallBack;

    .line 412
    iput-object p3, p0, Lcom/lidroid/xutils/BitmapUtils$BitmapLoadTask;->uri:Ljava/lang/String;

    .line 413
    iput-object p4, p0, Lcom/lidroid/xutils/BitmapUtils$BitmapLoadTask;->displayConfig:Lcom/lidroid/xutils/bitmap/BitmapDisplayConfig;

    .line 414
    return-void
.end method

.method static synthetic access$3(Lcom/lidroid/xutils/BitmapUtils$BitmapLoadTask;)Ljava/lang/String;
    .locals 1

    .prologue
    .line 398
    iget-object v0, p0, Lcom/lidroid/xutils/BitmapUtils$BitmapLoadTask;->uri:Ljava/lang/String;

    return-object v0
.end method


# virtual methods
.method protected varargs doInBackground([Ljava/lang/Object;)Landroid/graphics/Bitmap;
    .locals 4

    .prologue
    const/4 v0, 0x0

    const/4 v3, 0x0

    .line 419
    iget-object v1, p0, Lcom/lidroid/xutils/BitmapUtils$BitmapLoadTask;->this$0:Lcom/lidroid/xutils/BitmapUtils;

    invoke-static {v1}, Lcom/lidroid/xutils/BitmapUtils;->access$0(Lcom/lidroid/xutils/BitmapUtils;)Ljava/lang/Object;

    move-result-object v1

    monitor-enter v1

    .line 420
    :cond_0
    :goto_0
    :try_start_0
    iget-object v2, p0, Lcom/lidroid/xutils/BitmapUtils$BitmapLoadTask;->this$0:Lcom/lidroid/xutils/BitmapUtils;

    invoke-static {v2}, Lcom/lidroid/xutils/BitmapUtils;->access$1(Lcom/lidroid/xutils/BitmapUtils;)Z

    move-result v2

    if-eqz v2, :cond_1

    invoke-virtual {p0}, Lcom/lidroid/xutils/BitmapUtils$BitmapLoadTask;->isCancelled()Z

    move-result v2

    if-eqz v2, :cond_4

    .line 419
    :cond_1
    monitor-exit v1
    :try_end_0
    .catchall {:try_start_0 .. :try_end_0} :catchall_0

    .line 434
    invoke-virtual {p0}, Lcom/lidroid/xutils/BitmapUtils$BitmapLoadTask;->isCancelled()Z

    move-result v1

    if-nez v1, :cond_2

    invoke-virtual {p0}, Lcom/lidroid/xutils/BitmapUtils$BitmapLoadTask;->getTargetContainer()Landroid/view/View;

    move-result-object v1

    if-eqz v1, :cond_2

    .line 435
    const/4 v0, 0x1

    new-array v0, v0, [Ljava/lang/Object;

    invoke-static {v3}, Ljava/lang/Integer;->valueOf(I)Ljava/lang/Integer;

    move-result-object v1

    aput-object v1, v0, v3

    invoke-virtual {p0, v0}, Lcom/lidroid/xutils/BitmapUtils$BitmapLoadTask;->publishProgress([Ljava/lang/Object;)V

    .line 436
    iget-object v0, p0, Lcom/lidroid/xutils/BitmapUtils$BitmapLoadTask;->this$0:Lcom/lidroid/xutils/BitmapUtils;

    invoke-static {v0}, Lcom/lidroid/xutils/BitmapUtils;->access$3(Lcom/lidroid/xutils/BitmapUtils;)Lcom/lidroid/xutils/bitmap/BitmapGlobalConfig;

    move-result-object v0

    invoke-virtual {v0}, Lcom/lidroid/xutils/bitmap/BitmapGlobalConfig;->getBitmapCache()Lcom/lidroid/xutils/bitmap/core/BitmapCache;

    move-result-object v0

    iget-object v1, p0, Lcom/lidroid/xutils/BitmapUtils$BitmapLoadTask;->uri:Ljava/lang/String;

    iget-object v2, p0, Lcom/lidroid/xutils/BitmapUtils$BitmapLoadTask;->displayConfig:Lcom/lidroid/xutils/bitmap/BitmapDisplayConfig;

    invoke-virtual {v0, v1, v2}, Lcom/lidroid/xutils/bitmap/core/BitmapCache;->getBitmapFromDiskCache(Ljava/lang/String;Lcom/lidroid/xutils/bitmap/BitmapDisplayConfig;)Landroid/graphics/Bitmap;

    move-result-object v0

    .line 440
    :cond_2
    if-nez v0, :cond_3

    invoke-virtual {p0}, Lcom/lidroid/xutils/BitmapUtils$BitmapLoadTask;->isCancelled()Z

    move-result v1

    if-nez v1, :cond_3

    invoke-virtual {p0}, Lcom/lidroid/xutils/BitmapUtils$BitmapLoadTask;->getTargetContainer()Landroid/view/View;

    move-result-object v1

    if-eqz v1, :cond_3

    .line 441
    iget-object v0, p0, Lcom/lidroid/xutils/BitmapUtils$BitmapLoadTask;->this$0:Lcom/lidroid/xutils/BitmapUtils;

    invoke-static {v0}, Lcom/lidroid/xutils/BitmapUtils;->access$3(Lcom/lidroid/xutils/BitmapUtils;)Lcom/lidroid/xutils/bitmap/BitmapGlobalConfig;

    move-result-object v0

    invoke-virtual {v0}, Lcom/lidroid/xutils/bitmap/BitmapGlobalConfig;->getBitmapCache()Lcom/lidroid/xutils/bitmap/core/BitmapCache;

    move-result-object v0

    iget-object v1, p0, Lcom/lidroid/xutils/BitmapUtils$BitmapLoadTask;->uri:Ljava/lang/String;

    iget-object v2, p0, Lcom/lidroid/xutils/BitmapUtils$BitmapLoadTask;->displayConfig:Lcom/lidroid/xutils/bitmap/BitmapDisplayConfig;

    invoke-virtual {v0, v1, v2, p0}, Lcom/lidroid/xutils/bitmap/core/BitmapCache;->downloadBitmap(Ljava/lang/String;Lcom/lidroid/xutils/bitmap/BitmapDisplayConfig;Lcom/lidroid/xutils/BitmapUtils$BitmapLoadTask;)Landroid/graphics/Bitmap;

    move-result-object v0

    .line 442
    sget-object v1, Lcom/lidroid/xutils/bitmap/callback/BitmapLoadFrom;->URI:Lcom/lidroid/xutils/bitmap/callback/BitmapLoadFrom;

    iput-object v1, p0, Lcom/lidroid/xutils/BitmapUtils$BitmapLoadTask;->from:Lcom/lidroid/xutils/bitmap/callback/BitmapLoadFrom;

    .line 445
    :cond_3
    :goto_1
    return-object v0

    .line 422
    :cond_4
    :try_start_1
    iget-object v2, p0, Lcom/lidroid/xutils/BitmapUtils$BitmapLoadTask;->this$0:Lcom/lidroid/xutils/BitmapUtils;

    invoke-static {v2}, Lcom/lidroid/xutils/BitmapUtils;->access$0(Lcom/lidroid/xutils/BitmapUtils;)Ljava/lang/Object;

    move-result-object v2

    invoke-virtual {v2}, Ljava/lang/Object;->wait()V

    .line 423
    iget-object v2, p0, Lcom/lidroid/xutils/BitmapUtils$BitmapLoadTask;->this$0:Lcom/lidroid/xutils/BitmapUtils;

    invoke-static {v2}, Lcom/lidroid/xutils/BitmapUtils;->access$2(Lcom/lidroid/xutils/BitmapUtils;)Z
    :try_end_1
    .catch Ljava/lang/Throwable; {:try_start_1 .. :try_end_1} :catch_0
    .catchall {:try_start_1 .. :try_end_1} :catchall_0

    move-result v2

    if-eqz v2, :cond_0

    .line 424
    :try_start_2
    monitor-exit v1

    goto :goto_1

    .line 419
    :catchall_0
    move-exception v0

    monitor-exit v1
    :try_end_2
    .catchall {:try_start_2 .. :try_end_2} :catchall_0

    throw v0

    .line 426
    :catch_0
    move-exception v2

    goto :goto_0
.end method

.method protected bridge varargs synthetic doInBackground([Ljava/lang/Object;)Ljava/lang/Object;
    .locals 1

    .prologue
    .line 1
    check-cast p1, [Ljava/lang/Object;

    invoke-virtual {p0, p1}, Lcom/lidroid/xutils/BitmapUtils$BitmapLoadTask;->doInBackground([Ljava/lang/Object;)Landroid/graphics/Bitmap;

    move-result-object v0

    return-object v0
.end method

.method public getTargetContainer()Landroid/view/View;
    .locals 2
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "()TT;"
        }
    .end annotation

    .prologue
    .line 503
    iget-object v0, p0, Lcom/lidroid/xutils/BitmapUtils$BitmapLoadTask;->containerReference:Ljava/lang/ref/WeakReference;

    invoke-virtual {v0}, Ljava/lang/ref/WeakReference;->get()Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Landroid/view/View;

    .line 504
    iget-object v1, p0, Lcom/lidroid/xutils/BitmapUtils$BitmapLoadTask;->callBack:Lcom/lidroid/xutils/bitmap/callback/BitmapLoadCallBack;

    invoke-static {v0, v1}, Lcom/lidroid/xutils/BitmapUtils;->access$4(Landroid/view/View;Lcom/lidroid/xutils/bitmap/callback/BitmapLoadCallBack;)Lcom/lidroid/xutils/BitmapUtils$BitmapLoadTask;

    move-result-object v1

    .line 506
    if-ne p0, v1, :cond_0

    .line 510
    :goto_0
    return-object v0

    :cond_0
    const/4 v0, 0x0

    goto :goto_0
.end method

.method protected onCancelled(Landroid/graphics/Bitmap;)V
    .locals 2

    .prologue
    .line 497
    iget-object v0, p0, Lcom/lidroid/xutils/BitmapUtils$BitmapLoadTask;->this$0:Lcom/lidroid/xutils/BitmapUtils;

    invoke-static {v0}, Lcom/lidroid/xutils/BitmapUtils;->access$0(Lcom/lidroid/xutils/BitmapUtils;)Ljava/lang/Object;

    move-result-object v1

    monitor-enter v1

    .line 498
    :try_start_0
    iget-object v0, p0, Lcom/lidroid/xutils/BitmapUtils$BitmapLoadTask;->this$0:Lcom/lidroid/xutils/BitmapUtils;

    invoke-static {v0}, Lcom/lidroid/xutils/BitmapUtils;->access$0(Lcom/lidroid/xutils/BitmapUtils;)Ljava/lang/Object;

    move-result-object v0

    invoke-virtual {v0}, Ljava/lang/Object;->notifyAll()V

    .line 497
    monitor-exit v1

    .line 500
    return-void

    .line 497
    :catchall_0
    move-exception v0

    monitor-exit v1
    :try_end_0
    .catchall {:try_start_0 .. :try_end_0} :catchall_0

    throw v0
.end method

.method protected bridge synthetic onCancelled(Ljava/lang/Object;)V
    .locals 0

    .prologue
    .line 1
    check-cast p1, Landroid/graphics/Bitmap;

    invoke-virtual {p0, p1}, Lcom/lidroid/xutils/BitmapUtils$BitmapLoadTask;->onCancelled(Landroid/graphics/Bitmap;)V

    return-void
.end method

.method protected onPostExecute(Landroid/graphics/Bitmap;)V
    .locals 6

    .prologue
    .line 477
    invoke-virtual {p0}, Lcom/lidroid/xutils/BitmapUtils$BitmapLoadTask;->getTargetContainer()Landroid/view/View;

    move-result-object v1

    .line 478
    if-eqz v1, :cond_0

    .line 479
    if-eqz p1, :cond_1

    .line 480
    iget-object v0, p0, Lcom/lidroid/xutils/BitmapUtils$BitmapLoadTask;->callBack:Lcom/lidroid/xutils/bitmap/callback/BitmapLoadCallBack;

    .line 482
    iget-object v2, p0, Lcom/lidroid/xutils/BitmapUtils$BitmapLoadTask;->uri:Ljava/lang/String;

    .line 484
    iget-object v4, p0, Lcom/lidroid/xutils/BitmapUtils$BitmapLoadTask;->displayConfig:Lcom/lidroid/xutils/bitmap/BitmapDisplayConfig;

    .line 485
    iget-object v5, p0, Lcom/lidroid/xutils/BitmapUtils$BitmapLoadTask;->from:Lcom/lidroid/xutils/bitmap/callback/BitmapLoadFrom;

    move-object v3, p1

    .line 480
    invoke-virtual/range {v0 .. v5}, Lcom/lidroid/xutils/bitmap/callback/BitmapLoadCallBack;->onLoadCompleted(Landroid/view/View;Ljava/lang/String;Landroid/graphics/Bitmap;Lcom/lidroid/xutils/bitmap/BitmapDisplayConfig;Lcom/lidroid/xutils/bitmap/callback/BitmapLoadFrom;)V

    .line 493
    :cond_0
    :goto_0
    return-void

    .line 487
    :cond_1
    iget-object v0, p0, Lcom/lidroid/xutils/BitmapUtils$BitmapLoadTask;->callBack:Lcom/lidroid/xutils/bitmap/callback/BitmapLoadCallBack;

    .line 489
    iget-object v2, p0, Lcom/lidroid/xutils/BitmapUtils$BitmapLoadTask;->uri:Ljava/lang/String;

    .line 490
    iget-object v3, p0, Lcom/lidroid/xutils/BitmapUtils$BitmapLoadTask;->displayConfig:Lcom/lidroid/xutils/bitmap/BitmapDisplayConfig;

    invoke-virtual {v3}, Lcom/lidroid/xutils/bitmap/BitmapDisplayConfig;->getLoadFailedDrawable()Landroid/graphics/drawable/Drawable;

    move-result-object v3

    .line 487
    invoke-virtual {v0, v1, v2, v3}, Lcom/lidroid/xutils/bitmap/callback/BitmapLoadCallBack;->onLoadFailed(Landroid/view/View;Ljava/lang/String;Landroid/graphics/drawable/Drawable;)V

    goto :goto_0
.end method

.method protected bridge synthetic onPostExecute(Ljava/lang/Object;)V
    .locals 0

    .prologue
    .line 1
    check-cast p1, Landroid/graphics/Bitmap;

    invoke-virtual {p0, p1}, Lcom/lidroid/xutils/BitmapUtils$BitmapLoadTask;->onPostExecute(Landroid/graphics/Bitmap;)V

    return-void
.end method

.method protected varargs onProgressUpdate([Ljava/lang/Object;)V
    .locals 8

    .prologue
    .line 457
    if-eqz p1, :cond_0

    array-length v0, p1

    if-nez v0, :cond_1

    .line 473
    :cond_0
    :goto_0
    return-void

    .line 459
    :cond_1
    invoke-virtual {p0}, Lcom/lidroid/xutils/BitmapUtils$BitmapLoadTask;->getTargetContainer()Landroid/view/View;

    move-result-object v1

    .line 460
    if-eqz v1, :cond_0

    .line 462
    const/4 v0, 0x0

    aget-object v0, p1, v0

    check-cast v0, Ljava/lang/Integer;

    invoke-virtual {v0}, Ljava/lang/Integer;->intValue()I

    move-result v0

    packed-switch v0, :pswitch_data_0

    goto :goto_0

    .line 464
    :pswitch_0
    iget-object v0, p0, Lcom/lidroid/xutils/BitmapUtils$BitmapLoadTask;->callBack:Lcom/lidroid/xutils/bitmap/callback/BitmapLoadCallBack;

    iget-object v2, p0, Lcom/lidroid/xutils/BitmapUtils$BitmapLoadTask;->uri:Ljava/lang/String;

    iget-object v3, p0, Lcom/lidroid/xutils/BitmapUtils$BitmapLoadTask;->displayConfig:Lcom/lidroid/xutils/bitmap/BitmapDisplayConfig;

    invoke-virtual {v0, v1, v2, v3}, Lcom/lidroid/xutils/bitmap/callback/BitmapLoadCallBack;->onLoadStarted(Landroid/view/View;Ljava/lang/String;Lcom/lidroid/xutils/bitmap/BitmapDisplayConfig;)V

    goto :goto_0

    .line 467
    :pswitch_1
    array-length v0, p1

    const/4 v2, 0x3

    if-ne v0, v2, :cond_0

    .line 468
    iget-object v0, p0, Lcom/lidroid/xutils/BitmapUtils$BitmapLoadTask;->callBack:Lcom/lidroid/xutils/bitmap/callback/BitmapLoadCallBack;

    iget-object v2, p0, Lcom/lidroid/xutils/BitmapUtils$BitmapLoadTask;->uri:Ljava/lang/String;

    iget-object v3, p0, Lcom/lidroid/xutils/BitmapUtils$BitmapLoadTask;->displayConfig:Lcom/lidroid/xutils/bitmap/BitmapDisplayConfig;

    const/4 v4, 0x1

    aget-object v4, p1, v4

    check-cast v4, Ljava/lang/Long;

    invoke-virtual {v4}, Ljava/lang/Long;->longValue()J

    move-result-wide v4

    const/4 v6, 0x2

    aget-object v6, p1, v6

    check-cast v6, Ljava/lang/Long;

    invoke-virtual {v6}, Ljava/lang/Long;->longValue()J

    move-result-wide v6

    invoke-virtual/range {v0 .. v7}, Lcom/lidroid/xutils/bitmap/callback/BitmapLoadCallBack;->onLoading(Landroid/view/View;Ljava/lang/String;Lcom/lidroid/xutils/bitmap/BitmapDisplayConfig;JJ)V

    goto :goto_0

    .line 462
    nop

    :pswitch_data_0
    .packed-switch 0x0
        :pswitch_0
        :pswitch_1
    .end packed-switch
.end method

.method public updateProgress(JJ)V
    .locals 5

    .prologue
    const/4 v3, 0x1

    .line 449
    const/4 v0, 0x3

    new-array v0, v0, [Ljava/lang/Object;

    const/4 v1, 0x0

    invoke-static {v3}, Ljava/lang/Integer;->valueOf(I)Ljava/lang/Integer;

    move-result-object v2

    aput-object v2, v0, v1

    invoke-static {p1, p2}, Ljava/lang/Long;->valueOf(J)Ljava/lang/Long;

    move-result-object v1

    aput-object v1, v0, v3

    const/4 v1, 0x2

    invoke-static {p3, p4}, Ljava/lang/Long;->valueOf(J)Ljava/lang/Long;

    move-result-object v2

    aput-object v2, v0, v1

    invoke-virtual {p0, v0}, Lcom/lidroid/xutils/BitmapUtils$BitmapLoadTask;->publishProgress([Ljava/lang/Object;)V

    .line 450
    return-void
.end method
