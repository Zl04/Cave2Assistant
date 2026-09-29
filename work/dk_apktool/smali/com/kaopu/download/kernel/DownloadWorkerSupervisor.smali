.class public Lcom/kaopu/download/kernel/DownloadWorkerSupervisor;
.super Ljava/lang/Object;
.source "DownloadWorkerSupervisor.java"


# static fields
.field private static final works:Ljava/util/Hashtable;
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "Ljava/util/Hashtable",
            "<",
            "Ljava/lang/String;",
            "Lcom/kaopu/download/abst/ADownloadWorker",
            "<+",
            "Lcom/kaopu/download/kernel/BaseDownloadInfo;",
            ">;>;"
        }
    .end annotation
.end field


# direct methods
.method static constructor <clinit>()V
    .locals 1

    .prologue
    .line 21
    new-instance v0, Ljava/util/Hashtable;

    invoke-direct {v0}, Ljava/util/Hashtable;-><init>()V

    sput-object v0, Lcom/kaopu/download/kernel/DownloadWorkerSupervisor;->works:Ljava/util/Hashtable;

    return-void
.end method

.method public constructor <init>()V
    .locals 0

    .prologue
    .line 19
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method

.method public static add(Ljava/lang/String;Lcom/kaopu/download/abst/ADownloadWorker;)Z
    .locals 3
    .param p0, "url"    # Ljava/lang/String;
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "(",
            "Ljava/lang/String;",
            "Lcom/kaopu/download/abst/ADownloadWorker",
            "<+",
            "Lcom/kaopu/download/kernel/BaseDownloadInfo;",
            ">;)Z"
        }
    .end annotation

    .prologue
    .line 31
    .local p1, "worker":Lcom/kaopu/download/abst/ADownloadWorker;, "Lcom/kaopu/download/abst/ADownloadWorker<+Lcom/kaopu/download/kernel/BaseDownloadInfo;>;"
    sget-object v0, Lcom/kaopu/download/kernel/DownloadWorkerSupervisor;->works:Ljava/util/Hashtable;

    invoke-virtual {v0, p0}, Ljava/util/Hashtable;->containsKey(Ljava/lang/Object;)Z

    move-result v0

    if-nez v0, :cond_0

    .line 32
    sget-object v0, Lcom/kaopu/download/kernel/DownloadWorkerSupervisor;->works:Ljava/util/Hashtable;

    invoke-virtual {v0, p0, p1}, Ljava/util/Hashtable;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    .line 33
    const/4 v0, 0x1

    .line 36
    :goto_0
    return v0

    .line 35
    :cond_0
    const-string v0, "http"

    new-instance v1, Ljava/lang/StringBuilder;

    const-string v2, "download mission has been in the queue -> "

    invoke-direct {v1, v2}, Ljava/lang/StringBuilder;-><init>(Ljava/lang/String;)V

    invoke-virtual {v1, p0}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v1

    invoke-static {v0, v1}, Landroid/util/Log;->e(Ljava/lang/String;Ljava/lang/String;)I

    .line 36
    const/4 v0, 0x0

    goto :goto_0
.end method

.method public static clearAllDownloadTask()V
    .locals 0

    .prologue
    .line 94
    invoke-static {}, Lcom/kaopu/download/util/DownloadThreadUtil;->clearAllDownloadTask()Ljava/util/List;

    .line 95
    return-void
.end method

.method public static getDownloadInfo(Ljava/lang/String;)Lcom/kaopu/download/kernel/BaseDownloadInfo;
    .locals 1
    .param p0, "url"    # Ljava/lang/String;

    .prologue
    .line 74
    invoke-static {p0}, Lcom/kaopu/download/kernel/DownloadWorkerSupervisor;->getDownloadWorkerById(Ljava/lang/String;)Lcom/kaopu/download/abst/ADownloadWorker;

    move-result-object v0

    invoke-virtual {v0}, Lcom/kaopu/download/abst/ADownloadWorker;->getBaseDownloadInfo()Lcom/kaopu/download/kernel/BaseDownloadInfo;

    move-result-object v0

    return-object v0
.end method

.method public static getDownloadInfos()Ljava/util/Map;
    .locals 5
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "()",
            "Ljava/util/Map",
            "<",
            "Ljava/lang/String;",
            "Lcom/kaopu/download/kernel/BaseDownloadInfo;",
            ">;"
        }
    .end annotation

    .prologue
    .line 83
    new-instance v1, Ljava/util/HashMap;

    invoke-direct {v1}, Ljava/util/HashMap;-><init>()V

    .line 84
    .local v1, "map":Ljava/util/Map;, "Ljava/util/Map<Ljava/lang/String;Lcom/kaopu/download/kernel/BaseDownloadInfo;>;"
    sget-object v2, Lcom/kaopu/download/kernel/DownloadWorkerSupervisor;->works:Ljava/util/Hashtable;

    invoke-virtual {v2}, Ljava/util/Hashtable;->entrySet()Ljava/util/Set;

    move-result-object v2

    invoke-interface {v2}, Ljava/util/Set;->iterator()Ljava/util/Iterator;

    move-result-object v4

    :goto_0
    invoke-interface {v4}, Ljava/util/Iterator;->hasNext()Z

    move-result v2

    if-nez v2, :cond_0

    .line 87
    return-object v1

    .line 84
    :cond_0
    invoke-interface {v4}, Ljava/util/Iterator;->next()Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Ljava/util/Map$Entry;

    .line 85
    .local v0, "entry":Ljava/util/Map$Entry;, "Ljava/util/Map$Entry<Ljava/lang/String;Lcom/kaopu/download/abst/ADownloadWorker<+Lcom/kaopu/download/kernel/BaseDownloadInfo;>;>;"
    invoke-interface {v0}, Ljava/util/Map$Entry;->getKey()Ljava/lang/Object;

    move-result-object v2

    check-cast v2, Ljava/lang/String;

    invoke-interface {v0}, Ljava/util/Map$Entry;->getValue()Ljava/lang/Object;

    move-result-object v3

    check-cast v3, Lcom/kaopu/download/abst/ADownloadWorker;

    invoke-virtual {v3}, Lcom/kaopu/download/abst/ADownloadWorker;->getBaseDownloadInfo()Lcom/kaopu/download/kernel/BaseDownloadInfo;

    move-result-object v3

    invoke-interface {v1, v2, v3}, Ljava/util/Map;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    goto :goto_0
.end method

.method public static getDownloadWorkerById(Ljava/lang/String;)Lcom/kaopu/download/abst/ADownloadWorker;
    .locals 1
    .param p0, "url"    # Ljava/lang/String;
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "(",
            "Ljava/lang/String;",
            ")",
            "Lcom/kaopu/download/abst/ADownloadWorker",
            "<+",
            "Lcom/kaopu/download/kernel/BaseDownloadInfo;",
            ">;"
        }
    .end annotation

    .prologue
    .line 64
    sget-object v0, Lcom/kaopu/download/kernel/DownloadWorkerSupervisor;->works:Ljava/util/Hashtable;

    invoke-virtual {v0, p0}, Ljava/util/Hashtable;->get(Ljava/lang/Object;)Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Lcom/kaopu/download/abst/ADownloadWorker;

    return-object v0
.end method

.method public static getTaskCount()I
    .locals 1

    .prologue
    .line 101
    sget-object v0, Lcom/kaopu/download/kernel/DownloadWorkerSupervisor;->works:Ljava/util/Hashtable;

    invoke-virtual {v0}, Ljava/util/Hashtable;->size()I

    move-result v0

    return v0
.end method

.method public static isDownloading(Ljava/lang/String;)Z
    .locals 1
    .param p0, "url"    # Ljava/lang/String;

    .prologue
    .line 57
    sget-object v0, Lcom/kaopu/download/kernel/DownloadWorkerSupervisor;->works:Ljava/util/Hashtable;

    invoke-virtual {v0, p0}, Ljava/util/Hashtable;->containsKey(Ljava/lang/Object;)Z

    move-result v0

    return v0
.end method

.method public static remove(Ljava/lang/String;)Z
    .locals 1
    .param p0, "url"    # Ljava/lang/String;

    .prologue
    .line 47
    sget-object v0, Lcom/kaopu/download/kernel/DownloadWorkerSupervisor;->works:Ljava/util/Hashtable;

    invoke-virtual {v0, p0}, Ljava/util/Hashtable;->remove(Ljava/lang/Object;)Ljava/lang/Object;

    move-result-object v0

    if-eqz v0, :cond_0

    const/4 v0, 0x1

    :goto_0
    return v0

    :cond_0
    const/4 v0, 0x0

    goto :goto_0
.end method
