.class public Lcom/kaopu/download/util/DownloadThreadUtil;
.super Ljava/lang/Object;
.source "DownloadThreadUtil.java"


# static fields
.field private static final DEFAULT_DOWNLOAD_SIZE:I = 0x5

.field private static mDownloadThreadPoolExecutor:Ljava/util/concurrent/ThreadPoolExecutor;


# direct methods
.method static constructor <clinit>()V
    .locals 8

    .prologue
    const/4 v2, 0x5

    .line 29
    new-instance v1, Ljava/util/concurrent/ThreadPoolExecutor;

    const-wide/16 v4, 0x0

    sget-object v6, Ljava/util/concurrent/TimeUnit;->MILLISECONDS:Ljava/util/concurrent/TimeUnit;

    new-instance v7, Ljava/util/concurrent/LinkedBlockingQueue;

    invoke-direct {v7}, Ljava/util/concurrent/LinkedBlockingQueue;-><init>()V

    move v3, v2

    invoke-direct/range {v1 .. v7}, Ljava/util/concurrent/ThreadPoolExecutor;-><init>(IIJLjava/util/concurrent/TimeUnit;Ljava/util/concurrent/BlockingQueue;)V

    sput-object v1, Lcom/kaopu/download/util/DownloadThreadUtil;->mDownloadThreadPoolExecutor:Ljava/util/concurrent/ThreadPoolExecutor;

    return-void
.end method

.method public constructor <init>()V
    .locals 0

    .prologue
    .line 19
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method

.method public static clearAllDownloadTask()Ljava/util/List;
    .locals 1
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "()",
            "Ljava/util/List",
            "<",
            "Ljava/lang/Runnable;",
            ">;"
        }
    .end annotation

    .prologue
    .line 46
    sget-object v0, Lcom/kaopu/download/util/DownloadThreadUtil;->mDownloadThreadPoolExecutor:Ljava/util/concurrent/ThreadPoolExecutor;

    invoke-virtual {v0}, Ljava/util/concurrent/ThreadPoolExecutor;->shutdownNow()Ljava/util/List;

    move-result-object v0

    return-object v0
.end method

.method public static excuteDownload(Ljava/lang/Runnable;)V
    .locals 1
    .param p0, "command"    # Ljava/lang/Runnable;

    .prologue
    .line 37
    sget-object v0, Lcom/kaopu/download/util/DownloadThreadUtil;->mDownloadThreadPoolExecutor:Ljava/util/concurrent/ThreadPoolExecutor;

    invoke-virtual {v0, p0}, Ljava/util/concurrent/ThreadPoolExecutor;->execute(Ljava/lang/Runnable;)V

    .line 38
    return-void
.end method

.method public static remove(Lcom/kaopu/download/abst/ADownloadWorker;)Z
    .locals 1
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "(",
            "Lcom/kaopu/download/abst/ADownloadWorker",
            "<+",
            "Lcom/kaopu/download/kernel/BaseDownloadInfo;",
            ">;)Z"
        }
    .end annotation

    .prologue
    .line 56
    .local p0, "worker":Lcom/kaopu/download/abst/ADownloadWorker;, "Lcom/kaopu/download/abst/ADownloadWorker<+Lcom/kaopu/download/kernel/BaseDownloadInfo;>;"
    sget-object v0, Lcom/kaopu/download/util/DownloadThreadUtil;->mDownloadThreadPoolExecutor:Ljava/util/concurrent/ThreadPoolExecutor;

    invoke-virtual {v0, p0}, Ljava/util/concurrent/ThreadPoolExecutor;->remove(Ljava/lang/Runnable;)Z

    move-result v0

    return v0
.end method
