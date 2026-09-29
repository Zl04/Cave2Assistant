.class public Lcom/kaopu/download/BaseDownloadOperate;
.super Ljava/lang/Object;
.source "BaseDownloadOperate.java"


# direct methods
.method public constructor <init>()V
    .locals 0

    .prologue
    .line 17
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method

.method public static addNewDownloadTask(Landroid/content/Context;Lcom/kaopu/download/kernel/BaseDownloadInfo;)V
    .locals 2
    .param p0, "context"    # Landroid/content/Context;
    .param p1, "info"    # Lcom/kaopu/download/kernel/BaseDownloadInfo;

    .prologue
    .line 26
    new-instance v0, Lcom/kaopu/download/kernel/DownloadServiceConnection;

    invoke-direct {v0, p0}, Lcom/kaopu/download/kernel/DownloadServiceConnection;-><init>(Landroid/content/Context;)V

    .line 27
    .local v0, "connection":Lcom/kaopu/download/kernel/DownloadServiceConnection;
    invoke-static {p1}, Lcom/kaopu/download/util/DownloadObjectUtil;->object2Map(Ljava/lang/Object;)Ljava/util/Map;

    move-result-object v1

    invoke-virtual {v0, v1}, Lcom/kaopu/download/kernel/DownloadServiceConnection;->addDownloadTask(Ljava/util/Map;)Z

    .line 28
    return-void
.end method

.method public static cancelDownloadTask(Landroid/content/Context;Lcom/kaopu/download/kernel/BaseDownloadInfo;)V
    .locals 2
    .param p0, "context"    # Landroid/content/Context;
    .param p1, "info"    # Lcom/kaopu/download/kernel/BaseDownloadInfo;

    .prologue
    .line 48
    new-instance v0, Lcom/kaopu/download/kernel/DownloadServiceConnection;

    invoke-direct {v0, p0}, Lcom/kaopu/download/kernel/DownloadServiceConnection;-><init>(Landroid/content/Context;)V

    .line 49
    .local v0, "connection":Lcom/kaopu/download/kernel/DownloadServiceConnection;
    invoke-static {p1}, Lcom/kaopu/download/util/DownloadObjectUtil;->object2Map(Ljava/lang/Object;)Ljava/util/Map;

    move-result-object v1

    invoke-virtual {v0, v1}, Lcom/kaopu/download/kernel/DownloadServiceConnection;->cancel(Ljava/util/Map;)Z

    .line 50
    return-void
.end method

.method public static clearAllDownloadTask(Landroid/content/Context;)V
    .locals 1
    .param p0, "context"    # Landroid/content/Context;

    .prologue
    .line 88
    new-instance v0, Lcom/kaopu/download/kernel/DownloadServiceConnection;

    invoke-direct {v0, p0}, Lcom/kaopu/download/kernel/DownloadServiceConnection;-><init>(Landroid/content/Context;)V

    .line 89
    .local v0, "connection":Lcom/kaopu/download/kernel/DownloadServiceConnection;
    invoke-virtual {v0}, Lcom/kaopu/download/kernel/DownloadServiceConnection;->clearAllDownloadTask()Z

    .line 90
    return-void
.end method

.method public static continueDownload(Landroid/content/Context;Lcom/kaopu/download/kernel/BaseDownloadInfo;)Z
    .locals 2
    .param p0, "context"    # Landroid/content/Context;
    .param p1, "info"    # Lcom/kaopu/download/kernel/BaseDownloadInfo;

    .prologue
    .line 123
    new-instance v0, Lcom/kaopu/download/kernel/DownloadServiceConnection;

    invoke-direct {v0, p0}, Lcom/kaopu/download/kernel/DownloadServiceConnection;-><init>(Landroid/content/Context;)V

    .line 124
    .local v0, "connection":Lcom/kaopu/download/kernel/DownloadServiceConnection;
    invoke-static {p1}, Lcom/kaopu/download/util/DownloadObjectUtil;->object2Map(Ljava/lang/Object;)Ljava/util/Map;

    move-result-object v1

    invoke-virtual {v0, v1}, Lcom/kaopu/download/kernel/DownloadServiceConnection;->continueDownload(Ljava/util/Map;)Z

    move-result v1

    return v1
.end method

.method public static getDownloadInfo(Landroid/content/Context;Ljava/lang/String;)Lcom/kaopu/download/kernel/BaseDownloadInfo;
    .locals 3
    .param p0, "context"    # Landroid/content/Context;
    .param p1, "url"    # Ljava/lang/String;

    .prologue
    .line 61
    new-instance v0, Lcom/kaopu/download/kernel/DownloadServiceConnection;

    invoke-direct {v0, p0}, Lcom/kaopu/download/kernel/DownloadServiceConnection;-><init>(Landroid/content/Context;)V

    .line 62
    .local v0, "connection":Lcom/kaopu/download/kernel/DownloadServiceConnection;
    invoke-virtual {v0, p1}, Lcom/kaopu/download/kernel/DownloadServiceConnection;->getDownloadInfo(Ljava/lang/String;)Ljava/util/Map;

    move-result-object v2

    .line 63
    .local v2, "map":Ljava/util/Map;
    if-nez v2, :cond_0

    .line 64
    const/4 v1, 0x0

    .line 67
    :goto_0
    return-object v1

    .line 66
    :cond_0
    invoke-static {v2}, Lcom/kaopu/download/util/DownloadObjectUtil;->map2DownloadInfo(Ljava/util/Map;)Lcom/kaopu/download/kernel/BaseDownloadInfo;

    move-result-object v1

    .line 67
    .local v1, "info":Lcom/kaopu/download/kernel/BaseDownloadInfo;
    goto :goto_0
.end method

.method public static getDownloadInfos(Landroid/content/Context;)Ljava/util/Map;
    .locals 2
    .param p0, "context"    # Landroid/content/Context;

    .prologue
    .line 100
    new-instance v0, Lcom/kaopu/download/kernel/DownloadServiceConnection;

    invoke-direct {v0, p0}, Lcom/kaopu/download/kernel/DownloadServiceConnection;-><init>(Landroid/content/Context;)V

    .line 101
    .local v0, "connection":Lcom/kaopu/download/kernel/DownloadServiceConnection;
    invoke-virtual {v0}, Lcom/kaopu/download/kernel/DownloadServiceConnection;->getDownloadInfos()Ljava/util/Map;

    move-result-object v1

    return-object v1
.end method

.method public static getTaskCount(Landroid/content/Context;)I
    .locals 2
    .param p0, "context"    # Landroid/content/Context;

    .prologue
    .line 111
    new-instance v0, Lcom/kaopu/download/kernel/DownloadServiceConnection;

    invoke-direct {v0, p0}, Lcom/kaopu/download/kernel/DownloadServiceConnection;-><init>(Landroid/content/Context;)V

    .line 112
    .local v0, "connection":Lcom/kaopu/download/kernel/DownloadServiceConnection;
    invoke-virtual {v0}, Lcom/kaopu/download/kernel/DownloadServiceConnection;->getTaskCount()I

    move-result v1

    return v1
.end method

.method public static isBind(Landroid/content/Context;Ljava/lang/String;)Z
    .locals 2
    .param p0, "context"    # Landroid/content/Context;
    .param p1, "url"    # Ljava/lang/String;

    .prologue
    .line 78
    new-instance v0, Lcom/kaopu/download/kernel/DownloadServiceConnection;

    invoke-direct {v0, p0}, Lcom/kaopu/download/kernel/DownloadServiceConnection;-><init>(Landroid/content/Context;)V

    .line 79
    .local v0, "connection":Lcom/kaopu/download/kernel/DownloadServiceConnection;
    invoke-virtual {v0}, Lcom/kaopu/download/kernel/DownloadServiceConnection;->isBind()Z

    move-result v1

    return v1
.end method

.method public static pauseDownloadTask(Landroid/content/Context;Lcom/kaopu/download/kernel/BaseDownloadInfo;)V
    .locals 2
    .param p0, "context"    # Landroid/content/Context;
    .param p1, "info"    # Lcom/kaopu/download/kernel/BaseDownloadInfo;

    .prologue
    .line 37
    new-instance v0, Lcom/kaopu/download/kernel/DownloadServiceConnection;

    invoke-direct {v0, p0}, Lcom/kaopu/download/kernel/DownloadServiceConnection;-><init>(Landroid/content/Context;)V

    .line 38
    .local v0, "connection":Lcom/kaopu/download/kernel/DownloadServiceConnection;
    invoke-static {p1}, Lcom/kaopu/download/util/DownloadObjectUtil;->object2Map(Ljava/lang/Object;)Ljava/util/Map;

    move-result-object v1

    invoke-virtual {v0, v1}, Lcom/kaopu/download/kernel/DownloadServiceConnection;->pause(Ljava/util/Map;)Z

    .line 39
    return-void
.end method
