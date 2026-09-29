.class public Lcom/kaopu/download/kernel/DownloadService;
.super Landroid/app/Service;
.source "DownloadService.java"


# instance fields
.field private isServiceAlive:Z

.field private mDownloadServiceImpl:Lcom/kaopu/download/kernel/IDownloadService$Stub;


# direct methods
.method public constructor <init>()V
    .locals 1

    .prologue
    .line 24
    invoke-direct {p0}, Landroid/app/Service;-><init>()V

    .line 27
    const/4 v0, 0x0

    iput-boolean v0, p0, Lcom/kaopu/download/kernel/DownloadService;->isServiceAlive:Z

    .line 30
    new-instance v0, Lcom/kaopu/download/kernel/DownloadService$1;

    invoke-direct {v0, p0}, Lcom/kaopu/download/kernel/DownloadService$1;-><init>(Lcom/kaopu/download/kernel/DownloadService;)V

    iput-object v0, p0, Lcom/kaopu/download/kernel/DownloadService;->mDownloadServiceImpl:Lcom/kaopu/download/kernel/IDownloadService$Stub;

    .line 24
    return-void
.end method

.method static synthetic access$0(Lcom/kaopu/download/kernel/DownloadService;)Z
    .locals 1

    .prologue
    .line 27
    iget-boolean v0, p0, Lcom/kaopu/download/kernel/DownloadService;->isServiceAlive:Z

    return v0
.end method

.method static synthetic access$1(Lcom/kaopu/download/kernel/DownloadService;Lcom/kaopu/download/kernel/BaseDownloadInfo;)Lcom/kaopu/download/abst/ADownloadWorker;
    .locals 1

    .prologue
    .line 126
    invoke-direct {p0, p1}, Lcom/kaopu/download/kernel/DownloadService;->createDownloadWorker(Lcom/kaopu/download/kernel/BaseDownloadInfo;)Lcom/kaopu/download/abst/ADownloadWorker;

    move-result-object v0

    return-object v0
.end method

.method private createDownloadWorker(Lcom/kaopu/download/kernel/BaseDownloadInfo;)Lcom/kaopu/download/abst/ADownloadWorker;
    .locals 8
    .param p1, "info"    # Lcom/kaopu/download/kernel/BaseDownloadInfo;
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "(",
            "Lcom/kaopu/download/kernel/BaseDownloadInfo;",
            ")",
            "Lcom/kaopu/download/abst/ADownloadWorker",
            "<+",
            "Lcom/kaopu/download/kernel/BaseDownloadInfo;",
            ">;"
        }
    .end annotation

    .prologue
    .line 127
    invoke-virtual {p1}, Lcom/kaopu/download/kernel/BaseDownloadInfo;->getDownloadWorkerClassName()Ljava/lang/String;

    move-result-object v2

    .line 128
    .local v2, "downloadWorkerClassName":Ljava/lang/String;
    if-nez v2, :cond_0

    .line 129
    new-instance v4, Lcom/kaopu/download/BaseDownloadWorker;

    invoke-direct {v4, p0, p1}, Lcom/kaopu/download/BaseDownloadWorker;-><init>(Landroid/content/Context;Lcom/kaopu/download/kernel/BaseDownloadInfo;)V

    .line 149
    :goto_0
    return-object v4

    .line 132
    :cond_0
    :try_start_0
    invoke-virtual {p1}, Lcom/kaopu/download/kernel/BaseDownloadInfo;->getDownloadWorkerClassName()Ljava/lang/String;

    move-result-object v5

    invoke-static {v5}, Ljava/lang/Class;->forName(Ljava/lang/String;)Ljava/lang/Class;

    move-result-object v0

    .line 133
    .local v0, "clazz":Ljava/lang/Class;
    const/4 v5, 0x2

    new-array v5, v5, [Ljava/lang/Class;

    const/4 v6, 0x0

    const-class v7, Landroid/content/Context;

    aput-object v7, v5, v6

    const/4 v6, 0x1

    invoke-virtual {p1}, Ljava/lang/Object;->getClass()Ljava/lang/Class;

    move-result-object v7

    aput-object v7, v5, v6

    invoke-virtual {v0, v5}, Ljava/lang/Class;->getConstructor([Ljava/lang/Class;)Ljava/lang/reflect/Constructor;

    move-result-object v1

    .line 134
    .local v1, "constructor":Ljava/lang/reflect/Constructor;
    const/4 v5, 0x2

    new-array v5, v5, [Ljava/lang/Object;

    const/4 v6, 0x0

    aput-object p0, v5, v6

    const/4 v6, 0x1

    aput-object p1, v5, v6

    invoke-virtual {v1, v5}, Ljava/lang/reflect/Constructor;->newInstance([Ljava/lang/Object;)Ljava/lang/Object;

    move-result-object v4

    check-cast v4, Lcom/kaopu/download/abst/ADownloadWorker;
    :try_end_0
    .catch Ljava/lang/IllegalArgumentException; {:try_start_0 .. :try_end_0} :catch_0
    .catch Ljava/lang/ClassNotFoundException; {:try_start_0 .. :try_end_0} :catch_1
    .catch Ljava/lang/NoSuchMethodException; {:try_start_0 .. :try_end_0} :catch_2
    .catch Ljava/lang/InstantiationException; {:try_start_0 .. :try_end_0} :catch_3
    .catch Ljava/lang/IllegalAccessException; {:try_start_0 .. :try_end_0} :catch_4
    .catch Ljava/lang/reflect/InvocationTargetException; {:try_start_0 .. :try_end_0} :catch_5

    .line 135
    .local v4, "worker":Lcom/kaopu/download/abst/ADownloadWorker;, "Lcom/kaopu/download/abst/ADownloadWorker<+Lcom/kaopu/download/kernel/BaseDownloadInfo;>;"
    goto :goto_0

    .line 136
    .end local v0    # "clazz":Ljava/lang/Class;
    .end local v1    # "constructor":Ljava/lang/reflect/Constructor;
    .end local v4    # "worker":Lcom/kaopu/download/abst/ADownloadWorker;, "Lcom/kaopu/download/abst/ADownloadWorker<+Lcom/kaopu/download/kernel/BaseDownloadInfo;>;"
    :catch_0
    move-exception v3

    .line 137
    .local v3, "e":Ljava/lang/IllegalArgumentException;
    invoke-virtual {v3}, Ljava/lang/IllegalArgumentException;->printStackTrace()V

    .line 149
    .end local v3    # "e":Ljava/lang/IllegalArgumentException;
    :goto_1
    const/4 v4, 0x0

    goto :goto_0

    .line 138
    :catch_1
    move-exception v3

    .line 139
    .local v3, "e":Ljava/lang/ClassNotFoundException;
    invoke-virtual {v3}, Ljava/lang/ClassNotFoundException;->printStackTrace()V

    goto :goto_1

    .line 140
    .end local v3    # "e":Ljava/lang/ClassNotFoundException;
    :catch_2
    move-exception v3

    .line 141
    .local v3, "e":Ljava/lang/NoSuchMethodException;
    invoke-virtual {v3}, Ljava/lang/NoSuchMethodException;->printStackTrace()V

    goto :goto_1

    .line 142
    .end local v3    # "e":Ljava/lang/NoSuchMethodException;
    :catch_3
    move-exception v3

    .line 143
    .local v3, "e":Ljava/lang/InstantiationException;
    invoke-virtual {v3}, Ljava/lang/InstantiationException;->printStackTrace()V

    goto :goto_1

    .line 144
    .end local v3    # "e":Ljava/lang/InstantiationException;
    :catch_4
    move-exception v3

    .line 145
    .local v3, "e":Ljava/lang/IllegalAccessException;
    invoke-virtual {v3}, Ljava/lang/IllegalAccessException;->printStackTrace()V

    goto :goto_1

    .line 146
    .end local v3    # "e":Ljava/lang/IllegalAccessException;
    :catch_5
    move-exception v3

    .line 147
    .local v3, "e":Ljava/lang/reflect/InvocationTargetException;
    invoke-virtual {v3}, Ljava/lang/reflect/InvocationTargetException;->printStackTrace()V

    goto :goto_1
.end method


# virtual methods
.method public onBind(Landroid/content/Intent;)Landroid/os/IBinder;
    .locals 1
    .param p1, "intent"    # Landroid/content/Intent;

    .prologue
    .line 154
    iget-object v0, p0, Lcom/kaopu/download/kernel/DownloadService;->mDownloadServiceImpl:Lcom/kaopu/download/kernel/IDownloadService$Stub;

    return-object v0
.end method

.method public onCreate()V
    .locals 1

    .prologue
    .line 159
    invoke-super {p0}, Landroid/app/Service;->onCreate()V

    .line 160
    const/4 v0, 0x1

    iput-boolean v0, p0, Lcom/kaopu/download/kernel/DownloadService;->isServiceAlive:Z

    .line 161
    return-void
.end method

.method public onDestroy()V
    .locals 1

    .prologue
    .line 165
    invoke-super {p0}, Landroid/app/Service;->onDestroy()V

    .line 166
    const/4 v0, 0x0

    iput-boolean v0, p0, Lcom/kaopu/download/kernel/DownloadService;->isServiceAlive:Z

    .line 167
    return-void
.end method
