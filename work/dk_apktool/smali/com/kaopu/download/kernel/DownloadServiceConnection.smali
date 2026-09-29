.class public Lcom/kaopu/download/kernel/DownloadServiceConnection;
.super Ljava/lang/Object;
.source "DownloadServiceConnection.java"

# interfaces
.implements Landroid/content/ServiceConnection;


# static fields
.field private static sAidlService:Lcom/kaopu/download/kernel/IDownloadService;


# instance fields
.field private mContext:Landroid/content/Context;

.field private mIsConnectionBind:Z


# direct methods
.method static constructor <clinit>()V
    .locals 1

    .prologue
    .line 21
    const/4 v0, 0x0

    sput-object v0, Lcom/kaopu/download/kernel/DownloadServiceConnection;->sAidlService:Lcom/kaopu/download/kernel/IDownloadService;

    return-void
.end method

.method public constructor <init>(Landroid/content/Context;)V
    .locals 4
    .param p1, "context"    # Landroid/content/Context;

    .prologue
    .line 27
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    .line 23
    const/4 v1, 0x0

    iput-object v1, p0, Lcom/kaopu/download/kernel/DownloadServiceConnection;->mContext:Landroid/content/Context;

    .line 25
    const/4 v1, 0x0

    iput-boolean v1, p0, Lcom/kaopu/download/kernel/DownloadServiceConnection;->mIsConnectionBind:Z

    .line 28
    iput-object p1, p0, Lcom/kaopu/download/kernel/DownloadServiceConnection;->mContext:Landroid/content/Context;

    .line 30
    :try_start_0
    sget-object v1, Lcom/kaopu/download/kernel/DownloadServiceConnection;->sAidlService:Lcom/kaopu/download/kernel/IDownloadService;

    if-eqz v1, :cond_0

    sget-object v1, Lcom/kaopu/download/kernel/DownloadServiceConnection;->sAidlService:Lcom/kaopu/download/kernel/IDownloadService;

    invoke-interface {v1}, Lcom/kaopu/download/kernel/IDownloadService;->isServiceAlive()Z

    move-result v1

    if-nez v1, :cond_1

    .line 31
    :cond_0
    new-instance v1, Landroid/content/Intent;

    iget-object v2, p0, Lcom/kaopu/download/kernel/DownloadServiceConnection;->mContext:Landroid/content/Context;

    const-class v3, Lcom/kaopu/download/kernel/DownloadService;

    invoke-direct {v1, v2, v3}, Landroid/content/Intent;-><init>(Landroid/content/Context;Ljava/lang/Class;)V

    invoke-virtual {p1, v1}, Landroid/content/Context;->startService(Landroid/content/Intent;)Landroid/content/ComponentName;
    :try_end_0
    .catch Ljava/lang/Exception; {:try_start_0 .. :try_end_0} :catch_0

    .line 36
    :cond_1
    :goto_0
    return-void

    .line 32
    :catch_0
    move-exception v0

    .line 33
    .local v0, "e":Ljava/lang/Exception;
    new-instance v1, Landroid/content/Intent;

    iget-object v2, p0, Lcom/kaopu/download/kernel/DownloadServiceConnection;->mContext:Landroid/content/Context;

    const-class v3, Lcom/kaopu/download/kernel/DownloadService;

    invoke-direct {v1, v2, v3}, Landroid/content/Intent;-><init>(Landroid/content/Context;Ljava/lang/Class;)V

    invoke-virtual {p1, v1}, Landroid/content/Context;->startService(Landroid/content/Intent;)Landroid/content/ComponentName;

    goto :goto_0
.end method


# virtual methods
.method public addDownloadTask(Ljava/util/ArrayList;)Z
    .locals 4
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "(",
            "Ljava/util/ArrayList",
            "<",
            "Ljava/util/Map;",
            ">;)Z"
        }
    .end annotation

    .prologue
    .line 85
    .local p1, "infos":Ljava/util/ArrayList;, "Ljava/util/ArrayList<Ljava/util/Map;>;"
    invoke-virtual {p0}, Lcom/kaopu/download/kernel/DownloadServiceConnection;->startBind()Z

    move-result v2

    if-nez v2, :cond_0

    .line 86
    const/4 v2, 0x0

    .line 99
    :goto_0
    return v2

    .line 88
    :cond_0
    sget-object v2, Lcom/kaopu/download/kernel/DownloadServiceConnection;->sAidlService:Lcom/kaopu/download/kernel/IDownloadService;

    if-eqz v2, :cond_1

    .line 90
    :try_start_0
    invoke-virtual {p1}, Ljava/util/ArrayList;->iterator()Ljava/util/Iterator;

    move-result-object v2

    :goto_1
    invoke-interface {v2}, Ljava/util/Iterator;->hasNext()Z

    move-result v3

    if-nez v3, :cond_2

    .line 99
    :cond_1
    :goto_2
    const/4 v2, 0x1

    goto :goto_0

    .line 90
    :cond_2
    invoke-interface {v2}, Ljava/util/Iterator;->next()Ljava/lang/Object;

    move-result-object v1

    check-cast v1, Ljava/util/Map;

    .line 91
    .local v1, "info":Ljava/util/Map;
    sget-object v3, Lcom/kaopu/download/kernel/DownloadServiceConnection;->sAidlService:Lcom/kaopu/download/kernel/IDownloadService;

    invoke-interface {v3, v1}, Lcom/kaopu/download/kernel/IDownloadService;->addNewDownloadTask(Ljava/util/Map;)Z
    :try_end_0
    .catch Landroid/os/RemoteException; {:try_start_0 .. :try_end_0} :catch_0
    .catch Ljava/lang/Exception; {:try_start_0 .. :try_end_0} :catch_1

    goto :goto_1

    .line 93
    .end local v1    # "info":Ljava/util/Map;
    :catch_0
    move-exception v0

    .line 94
    .local v0, "e":Landroid/os/RemoteException;
    invoke-virtual {v0}, Landroid/os/RemoteException;->printStackTrace()V

    goto :goto_2

    .line 95
    .end local v0    # "e":Landroid/os/RemoteException;
    :catch_1
    move-exception v0

    .line 96
    .local v0, "e":Ljava/lang/Exception;
    invoke-virtual {v0}, Ljava/lang/Exception;->printStackTrace()V

    goto :goto_2
.end method

.method public addDownloadTask(Ljava/util/Map;)Z
    .locals 3
    .param p1, "info"    # Ljava/util/Map;

    .prologue
    const/4 v1, 0x0

    .line 63
    invoke-virtual {p0}, Lcom/kaopu/download/kernel/DownloadServiceConnection;->startBind()Z

    move-result v2

    if-nez v2, :cond_1

    .line 74
    :cond_0
    :goto_0
    return v1

    .line 65
    :cond_1
    sget-object v2, Lcom/kaopu/download/kernel/DownloadServiceConnection;->sAidlService:Lcom/kaopu/download/kernel/IDownloadService;

    if-eqz v2, :cond_0

    .line 67
    :try_start_0
    sget-object v2, Lcom/kaopu/download/kernel/DownloadServiceConnection;->sAidlService:Lcom/kaopu/download/kernel/IDownloadService;

    invoke-interface {v2, p1}, Lcom/kaopu/download/kernel/IDownloadService;->addNewDownloadTask(Ljava/util/Map;)Z
    :try_end_0
    .catch Landroid/os/RemoteException; {:try_start_0 .. :try_end_0} :catch_0
    .catch Ljava/lang/Exception; {:try_start_0 .. :try_end_0} :catch_1

    move-result v1

    goto :goto_0

    .line 68
    :catch_0
    move-exception v0

    .line 69
    .local v0, "e":Landroid/os/RemoteException;
    invoke-virtual {v0}, Landroid/os/RemoteException;->printStackTrace()V

    goto :goto_0

    .line 70
    .end local v0    # "e":Landroid/os/RemoteException;
    :catch_1
    move-exception v0

    .line 71
    .local v0, "e":Ljava/lang/Exception;
    invoke-virtual {v0}, Ljava/lang/Exception;->printStackTrace()V

    goto :goto_0
.end method

.method public bindDownloadService(Lcom/kaopu/download/kernel/ConnectionCallBack;)V
    .locals 7
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "(",
            "Lcom/kaopu/download/kernel/ConnectionCallBack",
            "<",
            "Ljava/lang/Boolean;",
            ">;)V"
        }
    .end annotation

    .prologue
    .local p1, "callBack":Lcom/kaopu/download/kernel/ConnectionCallBack;, "Lcom/kaopu/download/kernel/ConnectionCallBack<Ljava/lang/Boolean;>;"
    const/4 v6, 0x0

    const/4 v5, 0x1

    .line 233
    invoke-virtual {p0}, Lcom/kaopu/download/kernel/DownloadServiceConnection;->isBind()Z

    move-result v1

    if-eqz v1, :cond_1

    .line 235
    if-eqz p1, :cond_0

    .line 236
    new-array v1, v5, [Ljava/lang/Boolean;

    invoke-static {v5}, Ljava/lang/Boolean;->valueOf(Z)Ljava/lang/Boolean;

    move-result-object v2

    aput-object v2, v1, v6

    invoke-interface {p1, v1}, Lcom/kaopu/download/kernel/ConnectionCallBack;->invoke([Ljava/lang/Object;)V

    .line 249
    :cond_0
    :goto_0
    return-void

    .line 241
    :cond_1
    iget-object v1, p0, Lcom/kaopu/download/kernel/DownloadServiceConnection;->mContext:Landroid/content/Context;

    new-instance v2, Landroid/content/Intent;

    iget-object v3, p0, Lcom/kaopu/download/kernel/DownloadServiceConnection;->mContext:Landroid/content/Context;

    const-class v4, Lcom/kaopu/download/kernel/DownloadService;

    invoke-direct {v2, v3, v4}, Landroid/content/Intent;-><init>(Landroid/content/Context;Ljava/lang/Class;)V

    invoke-virtual {v1, v2, p0, v5}, Landroid/content/Context;->bindService(Landroid/content/Intent;Landroid/content/ServiceConnection;I)Z

    move-result v0

    .line 243
    .local v0, "bindSuccess":Z
    if-nez v0, :cond_0

    .line 245
    if-eqz p1, :cond_0

    .line 246
    new-array v1, v5, [Ljava/lang/Boolean;

    invoke-static {v6}, Ljava/lang/Boolean;->valueOf(Z)Ljava/lang/Boolean;

    move-result-object v2

    aput-object v2, v1, v6

    invoke-interface {p1, v1}, Lcom/kaopu/download/kernel/ConnectionCallBack;->invoke([Ljava/lang/Object;)V

    goto :goto_0
.end method

.method public cancel(Ljava/util/Map;)Z
    .locals 3
    .param p1, "info"    # Ljava/util/Map;

    .prologue
    const/4 v1, 0x0

    .line 135
    invoke-virtual {p0}, Lcom/kaopu/download/kernel/DownloadServiceConnection;->startBind()Z

    move-result v2

    if-nez v2, :cond_1

    .line 147
    :cond_0
    :goto_0
    return v1

    .line 138
    :cond_1
    sget-object v2, Lcom/kaopu/download/kernel/DownloadServiceConnection;->sAidlService:Lcom/kaopu/download/kernel/IDownloadService;

    if-eqz v2, :cond_0

    .line 140
    :try_start_0
    sget-object v2, Lcom/kaopu/download/kernel/DownloadServiceConnection;->sAidlService:Lcom/kaopu/download/kernel/IDownloadService;

    invoke-interface {v2, p1}, Lcom/kaopu/download/kernel/IDownloadService;->cancelDownloadTask(Ljava/util/Map;)Z
    :try_end_0
    .catch Landroid/os/RemoteException; {:try_start_0 .. :try_end_0} :catch_0
    .catch Ljava/lang/Exception; {:try_start_0 .. :try_end_0} :catch_1

    move-result v1

    goto :goto_0

    .line 141
    :catch_0
    move-exception v0

    .line 142
    .local v0, "e":Landroid/os/RemoteException;
    invoke-virtual {v0}, Landroid/os/RemoteException;->printStackTrace()V

    goto :goto_0

    .line 143
    .end local v0    # "e":Landroid/os/RemoteException;
    :catch_1
    move-exception v0

    .line 144
    .local v0, "e":Ljava/lang/Exception;
    invoke-virtual {v0}, Ljava/lang/Exception;->printStackTrace()V

    goto :goto_0
.end method

.method public clearAllDownloadTask()Z
    .locals 2

    .prologue
    const/4 v0, 0x0

    .line 154
    invoke-virtual {p0}, Lcom/kaopu/download/kernel/DownloadServiceConnection;->startBind()Z

    move-result v1

    if-nez v1, :cond_0

    .line 163
    :goto_0
    return v0

    .line 158
    :cond_0
    :try_start_0
    sget-object v1, Lcom/kaopu/download/kernel/DownloadServiceConnection;->sAidlService:Lcom/kaopu/download/kernel/IDownloadService;

    invoke-interface {v1}, Lcom/kaopu/download/kernel/IDownloadService;->clearAllDownloadTask()V
    :try_end_0
    .catch Ljava/lang/Exception; {:try_start_0 .. :try_end_0} :catch_0

    .line 159
    const/4 v0, 0x1

    goto :goto_0

    .line 160
    :catch_0
    move-exception v1

    goto :goto_0
.end method

.method public continueDownload(Ljava/util/Map;)Z
    .locals 2
    .param p1, "info"    # Ljava/util/Map;

    .prologue
    const/4 v0, 0x0

    .line 319
    invoke-virtual {p0}, Lcom/kaopu/download/kernel/DownloadServiceConnection;->startBind()Z

    move-result v1

    if-nez v1, :cond_0

    .line 327
    :goto_0
    return v0

    .line 323
    :cond_0
    :try_start_0
    sget-object v1, Lcom/kaopu/download/kernel/DownloadServiceConnection;->sAidlService:Lcom/kaopu/download/kernel/IDownloadService;

    invoke-interface {v1, p1}, Lcom/kaopu/download/kernel/IDownloadService;->continueDownload(Ljava/util/Map;)Z
    :try_end_0
    .catch Ljava/lang/Exception; {:try_start_0 .. :try_end_0} :catch_0

    move-result v0

    goto :goto_0

    .line 324
    :catch_0
    move-exception v1

    goto :goto_0
.end method

.method public getDownloadInfo(Ljava/lang/String;)Ljava/util/Map;
    .locals 3
    .param p1, "url"    # Ljava/lang/String;

    .prologue
    const/4 v1, 0x0

    .line 195
    invoke-virtual {p0}, Lcom/kaopu/download/kernel/DownloadServiceConnection;->startBind()Z

    move-result v2

    if-nez v2, :cond_0

    .line 204
    :goto_0
    return-object v1

    .line 199
    :cond_0
    :try_start_0
    sget-object v2, Lcom/kaopu/download/kernel/DownloadServiceConnection;->sAidlService:Lcom/kaopu/download/kernel/IDownloadService;

    invoke-interface {v2, p1}, Lcom/kaopu/download/kernel/IDownloadService;->getDownloadInfo(Ljava/lang/String;)Ljava/util/Map;
    :try_end_0
    .catch Ljava/lang/Exception; {:try_start_0 .. :try_end_0} :catch_0

    move-result-object v1

    goto :goto_0

    .line 200
    :catch_0
    move-exception v0

    .line 201
    .local v0, "e":Ljava/lang/Exception;
    invoke-virtual {v0}, Ljava/lang/Exception;->printStackTrace()V

    goto :goto_0
.end method

.method public getDownloadInfos()Ljava/util/Map;
    .locals 3
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
    const/4 v1, 0x0

    .line 173
    invoke-virtual {p0}, Lcom/kaopu/download/kernel/DownloadServiceConnection;->startBind()Z

    move-result v2

    if-nez v2, :cond_0

    .line 183
    :goto_0
    return-object v1

    .line 177
    :cond_0
    :try_start_0
    sget-object v2, Lcom/kaopu/download/kernel/DownloadServiceConnection;->sAidlService:Lcom/kaopu/download/kernel/IDownloadService;

    invoke-interface {v2}, Lcom/kaopu/download/kernel/IDownloadService;->getDownloadInfos()Ljava/util/Map;
    :try_end_0
    .catch Ljava/lang/Exception; {:try_start_0 .. :try_end_0} :catch_0

    move-result-object v1

    goto :goto_0

    .line 179
    :catch_0
    move-exception v0

    .line 180
    .local v0, "e":Ljava/lang/Exception;
    invoke-virtual {v0}, Ljava/lang/Exception;->printStackTrace()V

    goto :goto_0
.end method

.method public getTaskCount()I
    .locals 2

    .prologue
    const/4 v0, 0x0

    .line 213
    invoke-virtual {p0}, Lcom/kaopu/download/kernel/DownloadServiceConnection;->startBind()Z

    move-result v1

    if-nez v1, :cond_0

    .line 220
    :goto_0
    return v0

    .line 217
    :cond_0
    :try_start_0
    sget-object v1, Lcom/kaopu/download/kernel/DownloadServiceConnection;->sAidlService:Lcom/kaopu/download/kernel/IDownloadService;

    invoke-interface {v1}, Lcom/kaopu/download/kernel/IDownloadService;->getTaskCount()I
    :try_end_0
    .catch Ljava/lang/Exception; {:try_start_0 .. :try_end_0} :catch_0

    move-result v0

    goto :goto_0

    .line 218
    :catch_0
    move-exception v1

    goto :goto_0
.end method

.method public isBind()Z
    .locals 1

    .prologue
    .line 307
    :try_start_0
    sget-object v0, Lcom/kaopu/download/kernel/DownloadServiceConnection;->sAidlService:Lcom/kaopu/download/kernel/IDownloadService;

    if-eqz v0, :cond_0

    sget-object v0, Lcom/kaopu/download/kernel/DownloadServiceConnection;->sAidlService:Lcom/kaopu/download/kernel/IDownloadService;

    invoke-interface {v0}, Lcom/kaopu/download/kernel/IDownloadService;->isServiceAlive()Z
    :try_end_0
    .catch Ljava/lang/Exception; {:try_start_0 .. :try_end_0} :catch_0

    move-result v0

    if-eqz v0, :cond_0

    .line 308
    const/4 v0, 0x1

    .line 311
    :goto_0
    return v0

    .line 309
    :catch_0
    move-exception v0

    .line 311
    :cond_0
    const/4 v0, 0x0

    goto :goto_0
.end method

.method public onServiceConnected(Landroid/content/ComponentName;Landroid/os/IBinder;)V
    .locals 3
    .param p1, "name"    # Landroid/content/ComponentName;
    .param p2, "service"    # Landroid/os/IBinder;

    .prologue
    .line 41
    :try_start_0
    invoke-static {p2}, Lcom/kaopu/download/kernel/IDownloadService$Stub;->asInterface(Landroid/os/IBinder;)Lcom/kaopu/download/kernel/IDownloadService;

    move-result-object v1

    .line 42
    .local v1, "remoteService":Lcom/kaopu/download/kernel/IDownloadService;
    sput-object v1, Lcom/kaopu/download/kernel/DownloadServiceConnection;->sAidlService:Lcom/kaopu/download/kernel/IDownloadService;

    .line 43
    const/4 v2, 0x1

    iput-boolean v2, p0, Lcom/kaopu/download/kernel/DownloadServiceConnection;->mIsConnectionBind:Z
    :try_end_0
    .catch Ljava/lang/Exception; {:try_start_0 .. :try_end_0} :catch_0

    .line 47
    .end local v1    # "remoteService":Lcom/kaopu/download/kernel/IDownloadService;
    :goto_0
    return-void

    .line 44
    :catch_0
    move-exception v0

    .line 45
    .local v0, "ex":Ljava/lang/Exception;
    invoke-virtual {v0}, Ljava/lang/Exception;->printStackTrace()V

    goto :goto_0
.end method

.method public onServiceDisconnected(Landroid/content/ComponentName;)V
    .locals 1
    .param p1, "name"    # Landroid/content/ComponentName;

    .prologue
    .line 51
    const/4 v0, 0x0

    sput-object v0, Lcom/kaopu/download/kernel/DownloadServiceConnection;->sAidlService:Lcom/kaopu/download/kernel/IDownloadService;

    .line 52
    const/4 v0, 0x0

    iput-boolean v0, p0, Lcom/kaopu/download/kernel/DownloadServiceConnection;->mIsConnectionBind:Z

    .line 53
    return-void
.end method

.method public pause(Ljava/util/Map;)Z
    .locals 3
    .param p1, "info"    # Ljava/util/Map;

    .prologue
    const/4 v1, 0x0

    .line 111
    invoke-virtual {p0}, Lcom/kaopu/download/kernel/DownloadServiceConnection;->startBind()Z

    move-result v2

    if-nez v2, :cond_1

    .line 123
    :cond_0
    :goto_0
    return v1

    .line 114
    :cond_1
    sget-object v2, Lcom/kaopu/download/kernel/DownloadServiceConnection;->sAidlService:Lcom/kaopu/download/kernel/IDownloadService;

    if-eqz v2, :cond_0

    .line 116
    :try_start_0
    sget-object v2, Lcom/kaopu/download/kernel/DownloadServiceConnection;->sAidlService:Lcom/kaopu/download/kernel/IDownloadService;

    invoke-interface {v2, p1}, Lcom/kaopu/download/kernel/IDownloadService;->pauseDownloadTask(Ljava/util/Map;)Z
    :try_end_0
    .catch Landroid/os/RemoteException; {:try_start_0 .. :try_end_0} :catch_0
    .catch Ljava/lang/Exception; {:try_start_0 .. :try_end_0} :catch_1

    move-result v1

    goto :goto_0

    .line 117
    :catch_0
    move-exception v0

    .line 118
    .local v0, "e":Landroid/os/RemoteException;
    invoke-virtual {v0}, Landroid/os/RemoteException;->printStackTrace()V

    goto :goto_0

    .line 119
    .end local v0    # "e":Landroid/os/RemoteException;
    :catch_1
    move-exception v0

    .line 120
    .local v0, "e":Ljava/lang/Exception;
    invoke-virtual {v0}, Ljava/lang/Exception;->printStackTrace()V

    goto :goto_0
.end method

.method public startBind()Z
    .locals 6

    .prologue
    const/4 v0, 0x1

    .line 274
    invoke-virtual {p0}, Lcom/kaopu/download/kernel/DownloadServiceConnection;->isBind()Z

    move-result v2

    if-eqz v2, :cond_0

    .line 286
    :goto_0
    return v0

    .line 277
    :cond_0
    :try_start_0
    iget-object v2, p0, Lcom/kaopu/download/kernel/DownloadServiceConnection;->mContext:Landroid/content/Context;

    new-instance v3, Landroid/content/Intent;

    iget-object v4, p0, Lcom/kaopu/download/kernel/DownloadServiceConnection;->mContext:Landroid/content/Context;

    const-class v5, Lcom/kaopu/download/kernel/DownloadService;

    invoke-direct {v3, v4, v5}, Landroid/content/Intent;-><init>(Landroid/content/Context;Ljava/lang/Class;)V

    const/4 v4, 0x1

    invoke-virtual {v2, v3, p0, v4}, Landroid/content/Context;->bindService(Landroid/content/Intent;Landroid/content/ServiceConnection;I)Z
    :try_end_0
    .catch Ljava/lang/Exception; {:try_start_0 .. :try_end_0} :catch_0

    move-result v0

    .line 278
    .local v0, "bindSuccess":Z
    goto :goto_0

    .line 279
    .end local v0    # "bindSuccess":Z
    :catch_0
    move-exception v1

    .line 280
    .local v1, "e":Ljava/lang/Exception;
    invoke-virtual {v1}, Ljava/lang/Exception;->printStackTrace()V

    .line 282
    :try_start_1
    iget-object v2, p0, Lcom/kaopu/download/kernel/DownloadServiceConnection;->mContext:Landroid/content/Context;

    invoke-virtual {v2, p0}, Landroid/content/Context;->unbindService(Landroid/content/ServiceConnection;)V
    :try_end_1
    .catch Ljava/lang/Exception; {:try_start_1 .. :try_end_1} :catch_1

    .line 286
    :goto_1
    const/4 v0, 0x0

    goto :goto_0

    .line 283
    :catch_1
    move-exception v2

    goto :goto_1
.end method

.method public unBindDownloadService()V
    .locals 2

    .prologue
    .line 259
    :try_start_0
    iget-boolean v1, p0, Lcom/kaopu/download/kernel/DownloadServiceConnection;->mIsConnectionBind:Z

    if-eqz v1, :cond_0

    .line 260
    iget-object v1, p0, Lcom/kaopu/download/kernel/DownloadServiceConnection;->mContext:Landroid/content/Context;

    invoke-virtual {v1, p0}, Landroid/content/Context;->unbindService(Landroid/content/ServiceConnection;)V
    :try_end_0
    .catch Ljava/lang/Exception; {:try_start_0 .. :try_end_0} :catch_0

    .line 265
    :cond_0
    :goto_0
    return-void

    .line 262
    :catch_0
    move-exception v0

    .line 263
    .local v0, "e":Ljava/lang/Exception;
    invoke-virtual {v0}, Ljava/lang/Exception;->printStackTrace()V

    goto :goto_0
.end method
