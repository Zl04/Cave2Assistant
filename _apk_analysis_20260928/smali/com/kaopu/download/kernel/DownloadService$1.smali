.class Lcom/kaopu/download/kernel/DownloadService$1;
.super Lcom/kaopu/download/kernel/IDownloadService$Stub;
.source "DownloadService.java"


# annotations
.annotation system Ldalvik/annotation/EnclosingClass;
    value = Lcom/kaopu/download/kernel/DownloadService;
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x0
    name = null
.end annotation


# instance fields
.field final synthetic this$0:Lcom/kaopu/download/kernel/DownloadService;


# direct methods
.method constructor <init>(Lcom/kaopu/download/kernel/DownloadService;)V
    .locals 0

    .prologue
    .line 1
    iput-object p1, p0, Lcom/kaopu/download/kernel/DownloadService$1;->this$0:Lcom/kaopu/download/kernel/DownloadService;

    .line 30
    invoke-direct {p0}, Lcom/kaopu/download/kernel/IDownloadService$Stub;-><init>()V

    return-void
.end method


# virtual methods
.method public addNewDownloadTask(Ljava/util/Map;)Z
    .locals 4
    .param p1, "map"    # Ljava/util/Map;
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Landroid/os/RemoteException;
        }
    .end annotation

    .prologue
    const/4 v2, 0x0

    .line 40
    invoke-static {p1}, Lcom/kaopu/download/util/DownloadObjectUtil;->map2DownloadInfo(Ljava/util/Map;)Lcom/kaopu/download/kernel/BaseDownloadInfo;

    move-result-object v0

    .line 41
    .local v0, "info":Lcom/kaopu/download/kernel/BaseDownloadInfo;
    if-nez v0, :cond_1

    .line 48
    :cond_0
    :goto_0
    return v2

    .line 44
    :cond_1
    iget-object v3, p0, Lcom/kaopu/download/kernel/DownloadService$1;->this$0:Lcom/kaopu/download/kernel/DownloadService;

    invoke-static {v3, v0}, Lcom/kaopu/download/kernel/DownloadService;->access$1(Lcom/kaopu/download/kernel/DownloadService;Lcom/kaopu/download/kernel/BaseDownloadInfo;)Lcom/kaopu/download/abst/ADownloadWorker;

    move-result-object v1

    .line 45
    .local v1, "worker":Lcom/kaopu/download/abst/ADownloadWorker;, "Lcom/kaopu/download/abst/ADownloadWorker<+Lcom/kaopu/download/kernel/BaseDownloadInfo;>;"
    if-eqz v1, :cond_0

    .line 48
    invoke-virtual {v1}, Lcom/kaopu/download/abst/ADownloadWorker;->start()Z

    move-result v2

    goto :goto_0
.end method

.method public cancelDownloadTask(Ljava/util/Map;)Z
    .locals 4
    .param p1, "map"    # Ljava/util/Map;
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Landroid/os/RemoteException;
        }
    .end annotation

    .prologue
    const/4 v2, 0x0

    .line 68
    invoke-static {p1}, Lcom/kaopu/download/util/DownloadObjectUtil;->map2DownloadInfo(Ljava/util/Map;)Lcom/kaopu/download/kernel/BaseDownloadInfo;

    move-result-object v0

    .line 69
    .local v0, "info":Lcom/kaopu/download/kernel/BaseDownloadInfo;
    if-nez v0, :cond_1

    .line 79
    :cond_0
    :goto_0
    return v2

    .line 72
    :cond_1
    invoke-virtual {v0}, Lcom/kaopu/download/kernel/BaseDownloadInfo;->getUrl()Ljava/lang/String;

    move-result-object v3

    invoke-static {v3}, Lcom/kaopu/download/kernel/DownloadWorkerSupervisor;->getDownloadWorkerById(Ljava/lang/String;)Lcom/kaopu/download/abst/ADownloadWorker;

    move-result-object v1

    .line 73
    .local v1, "worker":Lcom/kaopu/download/abst/ADownloadWorker;, "Lcom/kaopu/download/abst/ADownloadWorker<+Lcom/kaopu/download/kernel/BaseDownloadInfo;>;"
    if-nez v1, :cond_2

    .line 74
    iget-object v3, p0, Lcom/kaopu/download/kernel/DownloadService$1;->this$0:Lcom/kaopu/download/kernel/DownloadService;

    invoke-static {v3, v0}, Lcom/kaopu/download/kernel/DownloadService;->access$1(Lcom/kaopu/download/kernel/DownloadService;Lcom/kaopu/download/kernel/BaseDownloadInfo;)Lcom/kaopu/download/abst/ADownloadWorker;

    move-result-object v1

    .line 76
    :cond_2
    if-eqz v1, :cond_0

    .line 79
    invoke-virtual {v1}, Lcom/kaopu/download/abst/ADownloadWorker;->cancle()Z

    move-result v2

    goto :goto_0
.end method

.method public clearAllDownloadTask()V
    .locals 0
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Landroid/os/RemoteException;
        }
    .end annotation

    .prologue
    .line 84
    invoke-static {}, Lcom/kaopu/download/kernel/DownloadWorkerSupervisor;->clearAllDownloadTask()V

    .line 85
    return-void
.end method

.method public continueDownload(Ljava/util/Map;)Z
    .locals 4
    .param p1, "map"    # Ljava/util/Map;
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Landroid/os/RemoteException;
        }
    .end annotation

    .prologue
    const/4 v2, 0x0

    .line 108
    invoke-static {p1}, Lcom/kaopu/download/util/DownloadObjectUtil;->map2DownloadInfo(Ljava/util/Map;)Lcom/kaopu/download/kernel/BaseDownloadInfo;

    move-result-object v0

    .line 109
    .local v0, "info":Lcom/kaopu/download/kernel/BaseDownloadInfo;
    if-nez v0, :cond_1

    .line 115
    :cond_0
    :goto_0
    return v2

    .line 112
    :cond_1
    iget-object v3, p0, Lcom/kaopu/download/kernel/DownloadService$1;->this$0:Lcom/kaopu/download/kernel/DownloadService;

    invoke-static {v3, v0}, Lcom/kaopu/download/kernel/DownloadService;->access$1(Lcom/kaopu/download/kernel/DownloadService;Lcom/kaopu/download/kernel/BaseDownloadInfo;)Lcom/kaopu/download/abst/ADownloadWorker;

    move-result-object v1

    .line 113
    .local v1, "worker":Lcom/kaopu/download/abst/ADownloadWorker;, "Lcom/kaopu/download/abst/ADownloadWorker<+Lcom/kaopu/download/kernel/BaseDownloadInfo;>;"
    if-eqz v1, :cond_0

    .line 115
    invoke-virtual {v1}, Lcom/kaopu/download/abst/ADownloadWorker;->start()Z

    move-result v2

    goto :goto_0
.end method

.method public getDownloadInfo(Ljava/lang/String;)Ljava/util/Map;
    .locals 2
    .param p1, "url"    # Ljava/lang/String;
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Landroid/os/RemoteException;
        }
    .end annotation

    .prologue
    .line 101
    invoke-static {p1}, Lcom/kaopu/download/kernel/DownloadWorkerSupervisor;->getDownloadInfo(Ljava/lang/String;)Lcom/kaopu/download/kernel/BaseDownloadInfo;

    move-result-object v0

    .line 102
    .local v0, "info":Lcom/kaopu/download/kernel/BaseDownloadInfo;
    invoke-static {v0}, Lcom/kaopu/download/util/DownloadObjectUtil;->object2Map(Ljava/lang/Object;)Ljava/util/Map;

    move-result-object v1

    return-object v1
.end method

.method public getDownloadInfos()Ljava/util/Map;
    .locals 1
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Landroid/os/RemoteException;
        }
    .end annotation

    .prologue
    .line 90
    invoke-static {}, Lcom/kaopu/download/kernel/DownloadWorkerSupervisor;->getDownloadInfos()Ljava/util/Map;

    move-result-object v0

    return-object v0
.end method

.method public getTaskCount()I
    .locals 1
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Landroid/os/RemoteException;
        }
    .end annotation

    .prologue
    .line 95
    invoke-static {}, Lcom/kaopu/download/kernel/DownloadWorkerSupervisor;->getTaskCount()I

    move-result v0

    return v0
.end method

.method public isServiceAlive()Z
    .locals 1
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Landroid/os/RemoteException;
        }
    .end annotation

    .prologue
    .line 34
    iget-object v0, p0, Lcom/kaopu/download/kernel/DownloadService$1;->this$0:Lcom/kaopu/download/kernel/DownloadService;

    invoke-static {v0}, Lcom/kaopu/download/kernel/DownloadService;->access$0(Lcom/kaopu/download/kernel/DownloadService;)Z

    move-result v0

    return v0
.end method

.method public pauseDownloadTask(Ljava/util/Map;)Z
    .locals 4
    .param p1, "map"    # Ljava/util/Map;
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Landroid/os/RemoteException;
        }
    .end annotation

    .prologue
    const/4 v2, 0x0

    .line 54
    invoke-static {p1}, Lcom/kaopu/download/util/DownloadObjectUtil;->map2DownloadInfo(Ljava/util/Map;)Lcom/kaopu/download/kernel/BaseDownloadInfo;

    move-result-object v0

    .line 55
    .local v0, "info":Lcom/kaopu/download/kernel/BaseDownloadInfo;
    if-nez v0, :cond_1

    .line 62
    :cond_0
    :goto_0
    return v2

    .line 58
    :cond_1
    invoke-virtual {v0}, Lcom/kaopu/download/kernel/BaseDownloadInfo;->getUrl()Ljava/lang/String;

    move-result-object v3

    invoke-static {v3}, Lcom/kaopu/download/kernel/DownloadWorkerSupervisor;->getDownloadWorkerById(Ljava/lang/String;)Lcom/kaopu/download/abst/ADownloadWorker;

    move-result-object v1

    .line 59
    .local v1, "worker":Lcom/kaopu/download/abst/ADownloadWorker;, "Lcom/kaopu/download/abst/ADownloadWorker<+Lcom/kaopu/download/kernel/BaseDownloadInfo;>;"
    if-eqz v1, :cond_0

    .line 62
    invoke-virtual {v1}, Lcom/kaopu/download/abst/ADownloadWorker;->pause()Z

    move-result v2

    goto :goto_0
.end method
