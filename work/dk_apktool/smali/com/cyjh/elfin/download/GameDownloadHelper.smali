.class public Lcom/cyjh/elfin/download/GameDownloadHelper;
.super Lcom/kaopu/download/BaseDownloadClickHelper;
.source "GameDownloadHelper.java"


# annotations
.annotation system Ldalvik/annotation/MemberClasses;
    value = {
        Lcom/cyjh/elfin/download/GameDownloadHelper$OnClickerCallback;
    }
.end annotation

.annotation system Ldalvik/annotation/Signature;
    value = {
        "Lcom/kaopu/download/BaseDownloadClickHelper",
        "<",
        "Lcom/kaopu/download/kernel/BaseDownloadInfo;",
        ">;"
    }
.end annotation


# instance fields
.field private gameDownloadView:Lcom/cyjh/elfin/customview/GameDownloadView;

.field private gameInfo:Lcom/cyjh/elfin/entity/GameInfo;

.field private isDetailsDownloadButton:Z

.field public onClickerCallback:Lcom/cyjh/elfin/download/GameDownloadHelper$OnClickerCallback;


# direct methods
.method public constructor <init>(Lcom/kaopu/download/intf/IDownloadView;)V
    .locals 1
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "(",
            "Lcom/kaopu/download/intf/IDownloadView",
            "<",
            "Lcom/kaopu/download/kernel/BaseDownloadInfo;",
            ">;)V"
        }
    .end annotation

    .prologue
    .line 29
    .local p1, "downloadView":Lcom/kaopu/download/intf/IDownloadView;, "Lcom/kaopu/download/intf/IDownloadView<Lcom/kaopu/download/kernel/BaseDownloadInfo;>;"
    invoke-direct {p0, p1}, Lcom/kaopu/download/BaseDownloadClickHelper;-><init>(Lcom/kaopu/download/intf/IDownloadView;)V

    .line 148
    const/4 v0, 0x0

    iput-boolean v0, p0, Lcom/cyjh/elfin/download/GameDownloadHelper;->isDetailsDownloadButton:Z

    .line 30
    return-void
.end method

.method private addNewDownloadTask()V
    .locals 2

    .prologue
    .line 108
    iget-object v0, p0, Lcom/cyjh/elfin/download/GameDownloadHelper;->mContext:Landroid/content/Context;

    invoke-static {v0}, Lcom/cyjh/elfin/util/NetworkUtils;->isAvailable(Landroid/content/Context;)Z

    move-result v0

    if-eqz v0, :cond_0

    .line 109
    iget-object v0, p0, Lcom/cyjh/elfin/download/GameDownloadHelper;->mContext:Landroid/content/Context;

    iget-object v1, p0, Lcom/cyjh/elfin/download/GameDownloadHelper;->mDownloadInfo:Lcom/kaopu/download/kernel/BaseDownloadInfo;

    invoke-static {v0, v1}, Lcom/kaopu/download/BaseDownloadOperate;->addNewDownloadTask(Landroid/content/Context;Lcom/kaopu/download/kernel/BaseDownloadInfo;)V

    .line 113
    :goto_0
    return-void

    .line 111
    :cond_0
    iget-object v0, p0, Lcom/cyjh/elfin/download/GameDownloadHelper;->mContext:Landroid/content/Context;

    const-string v1, "\u65e0\u7f51\u7edc\u8fde\u63a5"

    invoke-static {v0, v1}, Lcom/cyjh/elfin/util/ToastUtils;->showToastLong(Landroid/content/Context;Ljava/lang/String;)V

    goto :goto_0
.end method

.method private isDownload(Lcom/kaopu/download/kernel/BaseDownloadInfo;)Z
    .locals 3
    .param p1, "info"    # Lcom/kaopu/download/kernel/BaseDownloadInfo;

    .prologue
    .line 142
    invoke-virtual {p1}, Lcom/kaopu/download/kernel/BaseDownloadInfo;->getSaveDir()Ljava/lang/String;

    move-result-object v1

    invoke-virtual {p1}, Lcom/kaopu/download/kernel/BaseDownloadInfo;->getSaveName()Ljava/lang/String;

    move-result-object v2

    invoke-static {v1, v2}, Lcom/cyjh/elfin/util/FileUtils;->isFileExits(Ljava/lang/String;Ljava/lang/String;)Z

    move-result v0

    .line 143
    .local v0, "isFileExits":Z
    if-nez v0, :cond_0

    const/4 v1, 0x1

    :goto_0
    return v1

    :cond_0
    const/4 v1, 0x0

    goto :goto_0
.end method


# virtual methods
.method public down()V
    .locals 4

    .prologue
    .line 119
    iget-object v0, p0, Lcom/cyjh/elfin/download/GameDownloadHelper;->mContext:Landroid/content/Context;

    iget-object v1, p0, Lcom/cyjh/elfin/download/GameDownloadHelper;->gameInfo:Lcom/cyjh/elfin/entity/GameInfo;

    iget-object v1, v1, Lcom/cyjh/elfin/entity/GameInfo;->PackageName:Ljava/lang/String;

    invoke-static {v0, v1}, Lcom/cyjh/elfin/util/AppDeviceUtils;->isPackageInstalled(Landroid/content/Context;Ljava/lang/String;)Z

    move-result v0

    if-eqz v0, :cond_1

    .line 120
    iget-object v0, p0, Lcom/cyjh/elfin/download/GameDownloadHelper;->mContext:Landroid/content/Context;

    iget-object v1, p0, Lcom/cyjh/elfin/download/GameDownloadHelper;->gameInfo:Lcom/cyjh/elfin/entity/GameInfo;

    iget-object v1, v1, Lcom/cyjh/elfin/entity/GameInfo;->PackageName:Ljava/lang/String;

    invoke-static {v0, v1}, Lcom/cyjh/elfin/util/AppDeviceUtils;->openApp(Landroid/content/Context;Ljava/lang/String;)Z

    .line 133
    :cond_0
    :goto_0
    return-void

    .line 123
    :cond_1
    iget-object v0, p0, Lcom/cyjh/elfin/download/GameDownloadHelper;->mDownloadInfo:Lcom/kaopu/download/kernel/BaseDownloadInfo;

    invoke-virtual {v0}, Lcom/kaopu/download/kernel/BaseDownloadInfo;->getState()Lcom/kaopu/download/intf/IDownloadState;

    move-result-object v0

    invoke-interface {v0}, Lcom/kaopu/download/intf/IDownloadState;->getState()Lcom/kaopu/download/BaseDownloadStateFactory$State;

    move-result-object v0

    invoke-virtual {v0}, Lcom/kaopu/download/BaseDownloadStateFactory$State;->getIntValue()I

    move-result v0

    sget-object v1, Lcom/kaopu/download/BaseDownloadStateFactory$State;->DOWNLOADING:Lcom/kaopu/download/BaseDownloadStateFactory$State;

    .line 124
    invoke-virtual {v1}, Lcom/kaopu/download/BaseDownloadStateFactory$State;->getIntValue()I

    move-result v1

    if-eq v0, v1, :cond_0

    .line 127
    iget-object v0, p0, Lcom/cyjh/elfin/download/GameDownloadHelper;->mDownloadInfo:Lcom/kaopu/download/kernel/BaseDownloadInfo;

    invoke-direct {p0, v0}, Lcom/cyjh/elfin/download/GameDownloadHelper;->isDownload(Lcom/kaopu/download/kernel/BaseDownloadInfo;)Z

    move-result v0

    if-eqz v0, :cond_2

    .line 128
    invoke-direct {p0}, Lcom/cyjh/elfin/download/GameDownloadHelper;->addNewDownloadTask()V

    goto :goto_0

    .line 130
    :cond_2
    invoke-static {}, Lcom/cyjh/elfin/AppContext;->getInstance()Lcom/cyjh/elfin/AppContext;

    move-result-object v0

    new-instance v1, Ljava/io/File;

    new-instance v2, Ljava/lang/StringBuilder;

    invoke-direct {v2}, Ljava/lang/StringBuilder;-><init>()V

    iget-object v3, p0, Lcom/cyjh/elfin/download/GameDownloadHelper;->mDownloadInfo:Lcom/kaopu/download/kernel/BaseDownloadInfo;

    invoke-virtual {v3}, Lcom/kaopu/download/kernel/BaseDownloadInfo;->getSaveDir()Ljava/lang/String;

    move-result-object v3

    invoke-virtual {v2, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    sget-object v3, Ljava/io/File;->separator:Ljava/lang/String;

    invoke-virtual {v2, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    iget-object v3, p0, Lcom/cyjh/elfin/download/GameDownloadHelper;->mDownloadInfo:Lcom/kaopu/download/kernel/BaseDownloadInfo;

    .line 131
    invoke-virtual {v3}, Lcom/kaopu/download/kernel/BaseDownloadInfo;->getSaveName()Ljava/lang/String;

    move-result-object v3

    invoke-virtual {v2, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    invoke-virtual {v2}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v2

    invoke-direct {v1, v2}, Ljava/io/File;-><init>(Ljava/lang/String;)V

    .line 130
    invoke-static {v0, v1}, Lcom/cyjh/elfin/util/AppDeviceUtils;->installApplicationNormal(Landroid/content/Context;Ljava/io/File;)Z

    goto :goto_0
.end method

.method public onDownloadCancelingClick()V
    .locals 0

    .prologue
    .line 91
    invoke-super {p0}, Lcom/kaopu/download/BaseDownloadClickHelper;->onDownloadCancelingClick()V

    .line 92
    return-void
.end method

.method public onDownloadConnectingClick()V
    .locals 0

    .prologue
    .line 66
    invoke-super {p0}, Lcom/kaopu/download/BaseDownloadClickHelper;->onDownloadConnectingClick()V

    .line 67
    return-void
.end method

.method public onDownloadFailedClick()V
    .locals 0

    .prologue
    .line 96
    invoke-virtual {p0}, Lcom/cyjh/elfin/download/GameDownloadHelper;->down()V

    .line 97
    return-void
.end method

.method public onDownloadNewClick()V
    .locals 10

    .prologue
    .line 39
    new-instance v5, Ljava/lang/StringBuilder;

    invoke-direct {v5}, Ljava/lang/StringBuilder;-><init>()V

    iget-object v6, p0, Lcom/cyjh/elfin/download/GameDownloadHelper;->mDownloadInfo:Lcom/kaopu/download/kernel/BaseDownloadInfo;

    invoke-virtual {v6}, Lcom/kaopu/download/kernel/BaseDownloadInfo;->getUrl()Ljava/lang/String;

    move-result-object v6

    invoke-static {v6}, Lcom/cyjh/elfin/util/MD5Util;->MD5(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v6

    invoke-virtual {v5, v6}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v5

    const-string v6, ".apk.temp"

    invoke-virtual {v5, v6}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v5

    invoke-virtual {v5}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v4

    .line 40
    .local v4, "tempFileName":Ljava/lang/String;
    new-instance v5, Ljava/lang/StringBuilder;

    invoke-direct {v5}, Ljava/lang/StringBuilder;-><init>()V

    iget-object v6, p0, Lcom/cyjh/elfin/download/GameDownloadHelper;->mDownloadInfo:Lcom/kaopu/download/kernel/BaseDownloadInfo;

    invoke-virtual {v6}, Lcom/kaopu/download/kernel/BaseDownloadInfo;->getUrl()Ljava/lang/String;

    move-result-object v6

    invoke-static {v6}, Lcom/cyjh/elfin/util/MD5Util;->MD5(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v6

    invoke-virtual {v5, v6}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v5

    const-string v6, ".apk"

    invoke-virtual {v5, v6}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v5

    invoke-virtual {v5}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v0

    .line 41
    .local v0, "appFileName":Ljava/lang/String;
    iget-object v5, p0, Lcom/cyjh/elfin/download/GameDownloadHelper;->mDownloadInfo:Lcom/kaopu/download/kernel/BaseDownloadInfo;

    invoke-virtual {v5}, Lcom/kaopu/download/kernel/BaseDownloadInfo;->getSaveDir()Ljava/lang/String;

    move-result-object v5

    invoke-static {v5, v4}, Lcom/cyjh/elfin/util/FileUtils;->isFileExits(Ljava/lang/String;Ljava/lang/String;)Z

    move-result v2

    .line 42
    .local v2, "isFileExits":Z
    iget-object v5, p0, Lcom/cyjh/elfin/download/GameDownloadHelper;->mDownloadInfo:Lcom/kaopu/download/kernel/BaseDownloadInfo;

    invoke-virtual {v5}, Lcom/kaopu/download/kernel/BaseDownloadInfo;->getSaveDir()Ljava/lang/String;

    move-result-object v5

    invoke-static {v5, v0}, Lcom/cyjh/elfin/util/FileUtils;->isFileExits(Ljava/lang/String;Ljava/lang/String;)Z

    move-result v1

    .line 43
    .local v1, "isAppFileExits":Z
    iget-object v5, p0, Lcom/cyjh/elfin/download/GameDownloadHelper;->mContext:Landroid/content/Context;

    iget-object v6, p0, Lcom/cyjh/elfin/download/GameDownloadHelper;->gameInfo:Lcom/cyjh/elfin/entity/GameInfo;

    iget-object v6, v6, Lcom/cyjh/elfin/entity/GameInfo;->PackageName:Ljava/lang/String;

    invoke-static {v5, v6}, Lcom/cyjh/elfin/util/AppDeviceUtils;->isPackageInstalled(Landroid/content/Context;Ljava/lang/String;)Z

    move-result v3

    .line 44
    .local v3, "isInstall":Z
    if-nez v2, :cond_2

    if-nez v1, :cond_2

    if-nez v3, :cond_2

    .line 45
    iget-object v5, p0, Lcom/cyjh/elfin/download/GameDownloadHelper;->onClickerCallback:Lcom/cyjh/elfin/download/GameDownloadHelper$OnClickerCallback;

    if-eqz v5, :cond_0

    .line 46
    iget-object v5, p0, Lcom/cyjh/elfin/download/GameDownloadHelper;->onClickerCallback:Lcom/cyjh/elfin/download/GameDownloadHelper$OnClickerCallback;

    invoke-interface {v5}, Lcom/cyjh/elfin/download/GameDownloadHelper$OnClickerCallback;->onClicker()V

    .line 48
    :cond_0
    iget-boolean v5, p0, Lcom/cyjh/elfin/download/GameDownloadHelper;->isDetailsDownloadButton:Z

    if-eqz v5, :cond_1

    .line 50
    invoke-static {}, Lorg/greenrobot/eventbus/EventBus;->getDefault()Lorg/greenrobot/eventbus/EventBus;

    move-result-object v5

    new-instance v6, Lcom/cyjh/elfin/entity/AbNormalGameEvent$DetailsPopDialogEvent;

    iget-object v7, p0, Lcom/cyjh/elfin/download/GameDownloadHelper;->mDownloadInfo:Lcom/kaopu/download/kernel/BaseDownloadInfo;

    invoke-virtual {v7}, Lcom/kaopu/download/kernel/BaseDownloadInfo;->getUrl()Ljava/lang/String;

    move-result-object v7

    invoke-direct {v6, v7}, Lcom/cyjh/elfin/entity/AbNormalGameEvent$DetailsPopDialogEvent;-><init>(Ljava/lang/String;)V

    invoke-virtual {v5, v6}, Lorg/greenrobot/eventbus/EventBus;->post(Ljava/lang/Object;)V

    .line 62
    :goto_0
    return-void

    .line 52
    :cond_1
    invoke-static {}, Lorg/greenrobot/eventbus/EventBus;->getDefault()Lorg/greenrobot/eventbus/EventBus;

    move-result-object v5

    new-instance v6, Lcom/cyjh/elfin/entity/AbNormalGameEvent$PopDownloadDialogEvent;

    iget-object v7, p0, Lcom/cyjh/elfin/download/GameDownloadHelper;->gameDownloadView:Lcom/cyjh/elfin/customview/GameDownloadView;

    iget-object v8, p0, Lcom/cyjh/elfin/download/GameDownloadHelper;->gameInfo:Lcom/cyjh/elfin/entity/GameInfo;

    iget-object v9, p0, Lcom/cyjh/elfin/download/GameDownloadHelper;->mDownloadInfo:Lcom/kaopu/download/kernel/BaseDownloadInfo;

    .line 53
    invoke-virtual {v9}, Lcom/kaopu/download/kernel/BaseDownloadInfo;->getUrl()Ljava/lang/String;

    move-result-object v9

    invoke-direct {v6, v7, v8, v9}, Lcom/cyjh/elfin/entity/AbNormalGameEvent$PopDownloadDialogEvent;-><init>(Lcom/cyjh/elfin/customview/GameDownloadView;Lcom/cyjh/elfin/entity/GameInfo;Ljava/lang/String;)V

    .line 52
    invoke-virtual {v5, v6}, Lorg/greenrobot/eventbus/EventBus;->post(Ljava/lang/Object;)V

    goto :goto_0

    .line 56
    :cond_2
    iget-boolean v5, p0, Lcom/cyjh/elfin/download/GameDownloadHelper;->isDetailsDownloadButton:Z

    if-nez v5, :cond_3

    .line 57
    invoke-static {}, Lorg/greenrobot/eventbus/EventBus;->getDefault()Lorg/greenrobot/eventbus/EventBus;

    move-result-object v5

    new-instance v6, Lcom/cyjh/elfin/entity/AbNormalGameEvent$PopDownloadDialogEvent;

    iget-object v7, p0, Lcom/cyjh/elfin/download/GameDownloadHelper;->gameDownloadView:Lcom/cyjh/elfin/customview/GameDownloadView;

    iget-object v8, p0, Lcom/cyjh/elfin/download/GameDownloadHelper;->gameInfo:Lcom/cyjh/elfin/entity/GameInfo;

    const/4 v9, 0x0

    invoke-direct {v6, v7, v8, v9}, Lcom/cyjh/elfin/entity/AbNormalGameEvent$PopDownloadDialogEvent;-><init>(Lcom/cyjh/elfin/customview/GameDownloadView;Lcom/cyjh/elfin/entity/GameInfo;Ljava/lang/String;)V

    invoke-virtual {v5, v6}, Lorg/greenrobot/eventbus/EventBus;->post(Ljava/lang/Object;)V

    .line 60
    :cond_3
    invoke-virtual {p0}, Lcom/cyjh/elfin/download/GameDownloadHelper;->down()V

    goto :goto_0
.end method

.method public onDownloadNoneClick()V
    .locals 0

    .prologue
    .line 101
    return-void
.end method

.method public onDownloadPausedClick()V
    .locals 0

    .prologue
    .line 86
    invoke-super {p0}, Lcom/kaopu/download/BaseDownloadClickHelper;->onDownloadPausedClick()V

    .line 87
    return-void
.end method

.method public onDownloadPausingClick()V
    .locals 0

    .prologue
    .line 81
    invoke-super {p0}, Lcom/kaopu/download/BaseDownloadClickHelper;->onDownloadPausingClick()V

    .line 82
    return-void
.end method

.method public onDownloadWaitClick()V
    .locals 0

    .prologue
    .line 71
    invoke-super {p0}, Lcom/kaopu/download/BaseDownloadClickHelper;->onDownloadWaitClick()V

    .line 72
    return-void
.end method

.method public onDownloadedClick()V
    .locals 0

    .prologue
    .line 34
    invoke-virtual {p0}, Lcom/cyjh/elfin/download/GameDownloadHelper;->down()V

    .line 35
    return-void
.end method

.method public onDownloadingClick()V
    .locals 0

    .prologue
    .line 76
    invoke-super {p0}, Lcom/kaopu/download/BaseDownloadClickHelper;->onDownloadingClick()V

    .line 77
    return-void
.end method

.method public setDetailsDownloadButton(Z)V
    .locals 0
    .param p1, "detailsDownloadButton"    # Z

    .prologue
    .line 158
    iput-boolean p1, p0, Lcom/cyjh/elfin/download/GameDownloadHelper;->isDetailsDownloadButton:Z

    .line 159
    return-void
.end method

.method public setGameDownloadView(Lcom/cyjh/elfin/customview/GameDownloadView;)V
    .locals 0
    .param p1, "gameDownloadView"    # Lcom/cyjh/elfin/customview/GameDownloadView;

    .prologue
    .line 154
    iput-object p1, p0, Lcom/cyjh/elfin/download/GameDownloadHelper;->gameDownloadView:Lcom/cyjh/elfin/customview/GameDownloadView;

    .line 155
    return-void
.end method

.method public setGameInfo(Lcom/cyjh/elfin/entity/GameInfo;)V
    .locals 0
    .param p1, "gameInfo"    # Lcom/cyjh/elfin/entity/GameInfo;

    .prologue
    .line 150
    iput-object p1, p0, Lcom/cyjh/elfin/download/GameDownloadHelper;->gameInfo:Lcom/cyjh/elfin/entity/GameInfo;

    .line 151
    return-void
.end method

.method public setOnClickerCallback(Lcom/cyjh/elfin/download/GameDownloadHelper$OnClickerCallback;)V
    .locals 0
    .param p1, "onClickerCallback"    # Lcom/cyjh/elfin/download/GameDownloadHelper$OnClickerCallback;

    .prologue
    .line 170
    iput-object p1, p0, Lcom/cyjh/elfin/download/GameDownloadHelper;->onClickerCallback:Lcom/cyjh/elfin/download/GameDownloadHelper$OnClickerCallback;

    .line 171
    return-void
.end method
