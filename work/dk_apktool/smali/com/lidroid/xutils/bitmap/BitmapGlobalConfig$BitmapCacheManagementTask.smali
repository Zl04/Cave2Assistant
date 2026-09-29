.class Lcom/lidroid/xutils/bitmap/BitmapGlobalConfig$BitmapCacheManagementTask;
.super Lcom/lidroid/xutils/task/PriorityAsyncTask;
.source "SourceFile"


# annotations
.annotation system Ldalvik/annotation/EnclosingClass;
    value = Lcom/lidroid/xutils/bitmap/BitmapGlobalConfig;
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x2
    name = "BitmapCacheManagementTask"
.end annotation

.annotation system Ldalvik/annotation/Signature;
    value = {
        "Lcom/lidroid/xutils/task/PriorityAsyncTask",
        "<",
        "Ljava/lang/Object;",
        "Ljava/lang/Void;",
        "[",
        "Ljava/lang/Object;",
        ">;"
    }
.end annotation


# static fields
.field public static final MESSAGE_CLEAR:I = 0x4

.field public static final MESSAGE_CLEAR_BY_KEY:I = 0x7

.field public static final MESSAGE_CLEAR_DISK:I = 0x6

.field public static final MESSAGE_CLEAR_DISK_BY_KEY:I = 0x9

.field public static final MESSAGE_CLEAR_MEMORY:I = 0x5

.field public static final MESSAGE_CLEAR_MEMORY_BY_KEY:I = 0x8

.field public static final MESSAGE_CLOSE:I = 0x3

.field public static final MESSAGE_FLUSH:I = 0x2

.field public static final MESSAGE_INIT_DISK_CACHE:I = 0x1

.field public static final MESSAGE_INIT_MEMORY_CACHE:I


# instance fields
.field final synthetic this$0:Lcom/lidroid/xutils/bitmap/BitmapGlobalConfig;


# direct methods
.method private constructor <init>(Lcom/lidroid/xutils/bitmap/BitmapGlobalConfig;)V
    .locals 1

    .prologue
    .line 257
    iput-object p1, p0, Lcom/lidroid/xutils/bitmap/BitmapGlobalConfig$BitmapCacheManagementTask;->this$0:Lcom/lidroid/xutils/bitmap/BitmapGlobalConfig;

    invoke-direct {p0}, Lcom/lidroid/xutils/task/PriorityAsyncTask;-><init>()V

    .line 258
    sget-object v0, Lcom/lidroid/xutils/task/Priority;->UI_TOP:Lcom/lidroid/xutils/task/Priority;

    invoke-virtual {p0, v0}, Lcom/lidroid/xutils/bitmap/BitmapGlobalConfig$BitmapCacheManagementTask;->setPriority(Lcom/lidroid/xutils/task/Priority;)V

    .line 259
    return-void
.end method

.method synthetic constructor <init>(Lcom/lidroid/xutils/bitmap/BitmapGlobalConfig;Lcom/lidroid/xutils/bitmap/BitmapGlobalConfig$BitmapCacheManagementTask;)V
    .locals 0

    .prologue
    .line 257
    invoke-direct {p0, p1}, Lcom/lidroid/xutils/bitmap/BitmapGlobalConfig$BitmapCacheManagementTask;-><init>(Lcom/lidroid/xutils/bitmap/BitmapGlobalConfig;)V

    return-void
.end method


# virtual methods
.method protected bridge varargs synthetic doInBackground([Ljava/lang/Object;)Ljava/lang/Object;
    .locals 1

    .prologue
    .line 1
    check-cast p1, [Ljava/lang/Object;

    invoke-virtual {p0, p1}, Lcom/lidroid/xutils/bitmap/BitmapGlobalConfig$BitmapCacheManagementTask;->doInBackground([Ljava/lang/Object;)[Ljava/lang/Object;

    move-result-object v0

    return-object v0
.end method

.method protected varargs doInBackground([Ljava/lang/Object;)[Ljava/lang/Object;
    .locals 3

    .prologue
    const/4 v2, 0x2

    .line 263
    if-eqz p1, :cond_0

    array-length v0, p1

    if-nez v0, :cond_1

    .line 308
    :cond_0
    :goto_0
    return-object p1

    .line 264
    :cond_1
    iget-object v0, p0, Lcom/lidroid/xutils/bitmap/BitmapGlobalConfig$BitmapCacheManagementTask;->this$0:Lcom/lidroid/xutils/bitmap/BitmapGlobalConfig;

    invoke-virtual {v0}, Lcom/lidroid/xutils/bitmap/BitmapGlobalConfig;->getBitmapCache()Lcom/lidroid/xutils/bitmap/core/BitmapCache;

    move-result-object v1

    .line 265
    if-eqz v1, :cond_0

    .line 267
    const/4 v0, 0x0

    :try_start_0
    aget-object v0, p1, v0

    check-cast v0, Ljava/lang/Integer;

    invoke-virtual {v0}, Ljava/lang/Integer;->intValue()I

    move-result v0

    packed-switch v0, :pswitch_data_0

    goto :goto_0

    .line 269
    :pswitch_0
    invoke-virtual {v1}, Lcom/lidroid/xutils/bitmap/core/BitmapCache;->initMemoryCache()V
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_0

    goto :goto_0

    .line 305
    :catch_0
    move-exception v0

    .line 306
    invoke-virtual {v0}, Ljava/lang/Throwable;->getMessage()Ljava/lang/String;

    move-result-object v1

    invoke-static {v1, v0}, Lcom/lidroid/xutils/util/LogUtils;->e(Ljava/lang/String;Ljava/lang/Throwable;)V

    goto :goto_0

    .line 272
    :pswitch_1
    :try_start_1
    invoke-virtual {v1}, Lcom/lidroid/xutils/bitmap/core/BitmapCache;->initDiskCache()V

    goto :goto_0

    .line 275
    :pswitch_2
    invoke-virtual {v1}, Lcom/lidroid/xutils/bitmap/core/BitmapCache;->flush()V

    goto :goto_0

    .line 278
    :pswitch_3
    invoke-virtual {v1}, Lcom/lidroid/xutils/bitmap/core/BitmapCache;->clearMemoryCache()V

    .line 279
    invoke-virtual {v1}, Lcom/lidroid/xutils/bitmap/core/BitmapCache;->close()V

    goto :goto_0

    .line 282
    :pswitch_4
    invoke-virtual {v1}, Lcom/lidroid/xutils/bitmap/core/BitmapCache;->clearCache()V

    goto :goto_0

    .line 285
    :pswitch_5
    invoke-virtual {v1}, Lcom/lidroid/xutils/bitmap/core/BitmapCache;->clearMemoryCache()V

    goto :goto_0

    .line 288
    :pswitch_6
    invoke-virtual {v1}, Lcom/lidroid/xutils/bitmap/core/BitmapCache;->clearDiskCache()V

    goto :goto_0

    .line 291
    :pswitch_7
    array-length v0, p1

    if-ne v0, v2, :cond_0

    .line 292
    const/4 v0, 0x1

    aget-object v0, p1, v0

    invoke-static {v0}, Ljava/lang/String;->valueOf(Ljava/lang/Object;)Ljava/lang/String;

    move-result-object v0

    invoke-virtual {v1, v0}, Lcom/lidroid/xutils/bitmap/core/BitmapCache;->clearCache(Ljava/lang/String;)V

    goto :goto_0

    .line 295
    :pswitch_8
    array-length v0, p1

    if-ne v0, v2, :cond_0

    .line 296
    const/4 v0, 0x1

    aget-object v0, p1, v0

    invoke-static {v0}, Ljava/lang/String;->valueOf(Ljava/lang/Object;)Ljava/lang/String;

    move-result-object v0

    invoke-virtual {v1, v0}, Lcom/lidroid/xutils/bitmap/core/BitmapCache;->clearMemoryCache(Ljava/lang/String;)V

    goto :goto_0

    .line 299
    :pswitch_9
    array-length v0, p1

    if-ne v0, v2, :cond_0

    .line 300
    const/4 v0, 0x1

    aget-object v0, p1, v0

    invoke-static {v0}, Ljava/lang/String;->valueOf(Ljava/lang/Object;)Ljava/lang/String;

    move-result-object v0

    invoke-virtual {v1, v0}, Lcom/lidroid/xutils/bitmap/core/BitmapCache;->clearDiskCache(Ljava/lang/String;)V
    :try_end_1
    .catch Ljava/lang/Throwable; {:try_start_1 .. :try_end_1} :catch_0

    goto :goto_0

    .line 267
    :pswitch_data_0
    .packed-switch 0x0
        :pswitch_0
        :pswitch_1
        :pswitch_2
        :pswitch_3
        :pswitch_4
        :pswitch_5
        :pswitch_6
        :pswitch_7
        :pswitch_8
        :pswitch_9
    .end packed-switch
.end method

.method protected bridge synthetic onPostExecute(Ljava/lang/Object;)V
    .locals 0

    .prologue
    .line 1
    check-cast p1, [Ljava/lang/Object;

    invoke-virtual {p0, p1}, Lcom/lidroid/xutils/bitmap/BitmapGlobalConfig$BitmapCacheManagementTask;->onPostExecute([Ljava/lang/Object;)V

    return-void
.end method

.method protected onPostExecute([Ljava/lang/Object;)V
    .locals 2

    .prologue
    const/4 v1, 0x2

    .line 313
    iget-object v0, p0, Lcom/lidroid/xutils/bitmap/BitmapGlobalConfig$BitmapCacheManagementTask;->this$0:Lcom/lidroid/xutils/bitmap/BitmapGlobalConfig;

    invoke-static {v0}, Lcom/lidroid/xutils/bitmap/BitmapGlobalConfig;->access$0(Lcom/lidroid/xutils/bitmap/BitmapGlobalConfig;)Lcom/lidroid/xutils/bitmap/BitmapCacheListener;

    move-result-object v0

    if-eqz v0, :cond_0

    if-eqz p1, :cond_0

    array-length v0, p1

    if-nez v0, :cond_1

    .line 355
    :cond_0
    :goto_0
    return-void

    .line 315
    :cond_1
    const/4 v0, 0x0

    :try_start_0
    aget-object v0, p1, v0

    check-cast v0, Ljava/lang/Integer;

    invoke-virtual {v0}, Ljava/lang/Integer;->intValue()I

    move-result v0

    packed-switch v0, :pswitch_data_0

    goto :goto_0

    .line 317
    :pswitch_0
    iget-object v0, p0, Lcom/lidroid/xutils/bitmap/BitmapGlobalConfig$BitmapCacheManagementTask;->this$0:Lcom/lidroid/xutils/bitmap/BitmapGlobalConfig;

    invoke-static {v0}, Lcom/lidroid/xutils/bitmap/BitmapGlobalConfig;->access$0(Lcom/lidroid/xutils/bitmap/BitmapGlobalConfig;)Lcom/lidroid/xutils/bitmap/BitmapCacheListener;

    move-result-object v0

    invoke-interface {v0}, Lcom/lidroid/xutils/bitmap/BitmapCacheListener;->onInitMemoryCacheFinished()V
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_0

    goto :goto_0

    .line 352
    :catch_0
    move-exception v0

    .line 353
    invoke-virtual {v0}, Ljava/lang/Throwable;->getMessage()Ljava/lang/String;

    move-result-object v1

    invoke-static {v1, v0}, Lcom/lidroid/xutils/util/LogUtils;->e(Ljava/lang/String;Ljava/lang/Throwable;)V

    goto :goto_0

    .line 320
    :pswitch_1
    :try_start_1
    iget-object v0, p0, Lcom/lidroid/xutils/bitmap/BitmapGlobalConfig$BitmapCacheManagementTask;->this$0:Lcom/lidroid/xutils/bitmap/BitmapGlobalConfig;

    invoke-static {v0}, Lcom/lidroid/xutils/bitmap/BitmapGlobalConfig;->access$0(Lcom/lidroid/xutils/bitmap/BitmapGlobalConfig;)Lcom/lidroid/xutils/bitmap/BitmapCacheListener;

    move-result-object v0

    invoke-interface {v0}, Lcom/lidroid/xutils/bitmap/BitmapCacheListener;->onInitDiskFinished()V

    goto :goto_0

    .line 323
    :pswitch_2
    iget-object v0, p0, Lcom/lidroid/xutils/bitmap/BitmapGlobalConfig$BitmapCacheManagementTask;->this$0:Lcom/lidroid/xutils/bitmap/BitmapGlobalConfig;

    invoke-static {v0}, Lcom/lidroid/xutils/bitmap/BitmapGlobalConfig;->access$0(Lcom/lidroid/xutils/bitmap/BitmapGlobalConfig;)Lcom/lidroid/xutils/bitmap/BitmapCacheListener;

    move-result-object v0

    invoke-interface {v0}, Lcom/lidroid/xutils/bitmap/BitmapCacheListener;->onFlushCacheFinished()V

    goto :goto_0

    .line 326
    :pswitch_3
    iget-object v0, p0, Lcom/lidroid/xutils/bitmap/BitmapGlobalConfig$BitmapCacheManagementTask;->this$0:Lcom/lidroid/xutils/bitmap/BitmapGlobalConfig;

    invoke-static {v0}, Lcom/lidroid/xutils/bitmap/BitmapGlobalConfig;->access$0(Lcom/lidroid/xutils/bitmap/BitmapGlobalConfig;)Lcom/lidroid/xutils/bitmap/BitmapCacheListener;

    move-result-object v0

    invoke-interface {v0}, Lcom/lidroid/xutils/bitmap/BitmapCacheListener;->onCloseCacheFinished()V

    goto :goto_0

    .line 329
    :pswitch_4
    iget-object v0, p0, Lcom/lidroid/xutils/bitmap/BitmapGlobalConfig$BitmapCacheManagementTask;->this$0:Lcom/lidroid/xutils/bitmap/BitmapGlobalConfig;

    invoke-static {v0}, Lcom/lidroid/xutils/bitmap/BitmapGlobalConfig;->access$0(Lcom/lidroid/xutils/bitmap/BitmapGlobalConfig;)Lcom/lidroid/xutils/bitmap/BitmapCacheListener;

    move-result-object v0

    invoke-interface {v0}, Lcom/lidroid/xutils/bitmap/BitmapCacheListener;->onClearCacheFinished()V

    goto :goto_0

    .line 332
    :pswitch_5
    iget-object v0, p0, Lcom/lidroid/xutils/bitmap/BitmapGlobalConfig$BitmapCacheManagementTask;->this$0:Lcom/lidroid/xutils/bitmap/BitmapGlobalConfig;

    invoke-static {v0}, Lcom/lidroid/xutils/bitmap/BitmapGlobalConfig;->access$0(Lcom/lidroid/xutils/bitmap/BitmapGlobalConfig;)Lcom/lidroid/xutils/bitmap/BitmapCacheListener;

    move-result-object v0

    invoke-interface {v0}, Lcom/lidroid/xutils/bitmap/BitmapCacheListener;->onClearMemoryCacheFinished()V

    goto :goto_0

    .line 335
    :pswitch_6
    iget-object v0, p0, Lcom/lidroid/xutils/bitmap/BitmapGlobalConfig$BitmapCacheManagementTask;->this$0:Lcom/lidroid/xutils/bitmap/BitmapGlobalConfig;

    invoke-static {v0}, Lcom/lidroid/xutils/bitmap/BitmapGlobalConfig;->access$0(Lcom/lidroid/xutils/bitmap/BitmapGlobalConfig;)Lcom/lidroid/xutils/bitmap/BitmapCacheListener;

    move-result-object v0

    invoke-interface {v0}, Lcom/lidroid/xutils/bitmap/BitmapCacheListener;->onClearDiskCacheFinished()V

    goto :goto_0

    .line 338
    :pswitch_7
    array-length v0, p1

    if-ne v0, v1, :cond_0

    .line 339
    iget-object v0, p0, Lcom/lidroid/xutils/bitmap/BitmapGlobalConfig$BitmapCacheManagementTask;->this$0:Lcom/lidroid/xutils/bitmap/BitmapGlobalConfig;

    invoke-static {v0}, Lcom/lidroid/xutils/bitmap/BitmapGlobalConfig;->access$0(Lcom/lidroid/xutils/bitmap/BitmapGlobalConfig;)Lcom/lidroid/xutils/bitmap/BitmapCacheListener;

    move-result-object v0

    const/4 v1, 0x1

    aget-object v1, p1, v1

    invoke-static {v1}, Ljava/lang/String;->valueOf(Ljava/lang/Object;)Ljava/lang/String;

    move-result-object v1

    invoke-interface {v0, v1}, Lcom/lidroid/xutils/bitmap/BitmapCacheListener;->onClearCacheFinished(Ljava/lang/String;)V

    goto :goto_0

    .line 342
    :pswitch_8
    array-length v0, p1

    if-ne v0, v1, :cond_0

    .line 343
    iget-object v0, p0, Lcom/lidroid/xutils/bitmap/BitmapGlobalConfig$BitmapCacheManagementTask;->this$0:Lcom/lidroid/xutils/bitmap/BitmapGlobalConfig;

    invoke-static {v0}, Lcom/lidroid/xutils/bitmap/BitmapGlobalConfig;->access$0(Lcom/lidroid/xutils/bitmap/BitmapGlobalConfig;)Lcom/lidroid/xutils/bitmap/BitmapCacheListener;

    move-result-object v0

    const/4 v1, 0x1

    aget-object v1, p1, v1

    invoke-static {v1}, Ljava/lang/String;->valueOf(Ljava/lang/Object;)Ljava/lang/String;

    move-result-object v1

    invoke-interface {v0, v1}, Lcom/lidroid/xutils/bitmap/BitmapCacheListener;->onClearMemoryCacheFinished(Ljava/lang/String;)V

    goto/16 :goto_0

    .line 346
    :pswitch_9
    array-length v0, p1

    if-ne v0, v1, :cond_0

    .line 347
    iget-object v0, p0, Lcom/lidroid/xutils/bitmap/BitmapGlobalConfig$BitmapCacheManagementTask;->this$0:Lcom/lidroid/xutils/bitmap/BitmapGlobalConfig;

    invoke-static {v0}, Lcom/lidroid/xutils/bitmap/BitmapGlobalConfig;->access$0(Lcom/lidroid/xutils/bitmap/BitmapGlobalConfig;)Lcom/lidroid/xutils/bitmap/BitmapCacheListener;

    move-result-object v0

    const/4 v1, 0x1

    aget-object v1, p1, v1

    invoke-static {v1}, Ljava/lang/String;->valueOf(Ljava/lang/Object;)Ljava/lang/String;

    move-result-object v1

    invoke-interface {v0, v1}, Lcom/lidroid/xutils/bitmap/BitmapCacheListener;->onClearDiskCacheFinished(Ljava/lang/String;)V
    :try_end_1
    .catch Ljava/lang/Throwable; {:try_start_1 .. :try_end_1} :catch_0

    goto/16 :goto_0

    .line 315
    nop

    :pswitch_data_0
    .packed-switch 0x0
        :pswitch_0
        :pswitch_1
        :pswitch_2
        :pswitch_3
        :pswitch_4
        :pswitch_5
        :pswitch_6
        :pswitch_7
        :pswitch_8
        :pswitch_9
    .end packed-switch
.end method
