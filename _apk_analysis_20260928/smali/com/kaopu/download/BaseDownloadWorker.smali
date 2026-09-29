.class public Lcom/kaopu/download/BaseDownloadWorker;
.super Lcom/kaopu/download/abst/ADownloadWorker;
.source "BaseDownloadWorker.java"


# annotations
.annotation system Ldalvik/annotation/MemberClasses;
    value = {
        Lcom/kaopu/download/BaseDownloadWorker$DownloadCallBack;
    }
.end annotation

.annotation system Ldalvik/annotation/Signature;
    value = {
        "<T:",
        "Lcom/kaopu/download/kernel/BaseDownloadInfo;",
        ">",
        "Lcom/kaopu/download/abst/ADownloadWorker",
        "<TT;>;"
    }
.end annotation


# static fields
.field public static final NOTIFY_VIEW_ACTION:Ljava/lang/String; = "com.kaopu.core.download.BaseDownloadWorker.notify_view_action"

.field public static final NOTIFY_VIEW_ACTION_EXTRA_INFO_KEY:Ljava/lang/String; = "info_key"


# instance fields
.field private mCallBack:Lcom/kaopu/download/BaseDownloadWorker$DownloadCallBack;

.field protected mContext:Landroid/content/Context;

.field private sizeOld:J

.field private timeOld:J


# direct methods
.method public constructor <init>(Landroid/content/Context;Lcom/kaopu/download/kernel/BaseDownloadInfo;)V
    .locals 1
    .param p1, "context"    # Landroid/content/Context;
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "(",
            "Landroid/content/Context;",
            "TT;)V"
        }
    .end annotation

    .prologue
    .line 33
    .local p0, "this":Lcom/kaopu/download/BaseDownloadWorker;, "Lcom/kaopu/download/BaseDownloadWorker<TT;>;"
    .local p2, "info":Lcom/kaopu/download/kernel/BaseDownloadInfo;, "TT;"
    invoke-direct {p0, p2}, Lcom/kaopu/download/abst/ADownloadWorker;-><init>(Lcom/kaopu/download/kernel/BaseDownloadInfo;)V

    .line 34
    iput-object p1, p0, Lcom/kaopu/download/BaseDownloadWorker;->mContext:Landroid/content/Context;

    .line 35
    invoke-virtual {p2}, Lcom/kaopu/download/kernel/BaseDownloadInfo;->getCallBack()Lcom/kaopu/download/BaseDownloadWorker$DownloadCallBack;

    move-result-object v0

    iput-object v0, p0, Lcom/kaopu/download/BaseDownloadWorker;->mCallBack:Lcom/kaopu/download/BaseDownloadWorker$DownloadCallBack;

    .line 36
    return-void
.end method

.method private sendNotifyBroadcast()V
    .locals 3

    .prologue
    .line 143
    .local p0, "this":Lcom/kaopu/download/BaseDownloadWorker;, "Lcom/kaopu/download/BaseDownloadWorker<TT;>;"
    new-instance v0, Landroid/content/Intent;

    const-string v1, "com.kaopu.core.download.BaseDownloadWorker.notify_view_action"

    invoke-direct {v0, v1}, Landroid/content/Intent;-><init>(Ljava/lang/String;)V

    .line 144
    .local v0, "intent":Landroid/content/Intent;
    const-string v1, "info_key"

    iget-object v2, p0, Lcom/kaopu/download/BaseDownloadWorker;->mDownloadInfo:Lcom/kaopu/download/kernel/BaseDownloadInfo;

    invoke-virtual {v0, v1, v2}, Landroid/content/Intent;->putExtra(Ljava/lang/String;Landroid/os/Parcelable;)Landroid/content/Intent;

    .line 145
    iget-object v1, p0, Lcom/kaopu/download/BaseDownloadWorker;->mContext:Landroid/content/Context;

    invoke-virtual {v1, v0}, Landroid/content/Context;->sendBroadcast(Landroid/content/Intent;)V

    .line 146
    return-void
.end method


# virtual methods
.method protected onDownloadCanceled(Ljava/lang/String;)V
    .locals 2
    .param p1, "identification"    # Ljava/lang/String;

    .prologue
    .line 40
    .local p0, "this":Lcom/kaopu/download/BaseDownloadWorker;, "Lcom/kaopu/download/BaseDownloadWorker<TT;>;"
    iget-object v0, p0, Lcom/kaopu/download/BaseDownloadWorker;->mDownloadInfo:Lcom/kaopu/download/kernel/BaseDownloadInfo;

    invoke-static {}, Lcom/kaopu/download/BaseDownloadStateFactory;->getDownloadNewState()Lcom/kaopu/download/state/DownloadNewState;

    move-result-object v1

    invoke-virtual {v0, v1}, Lcom/kaopu/download/kernel/BaseDownloadInfo;->setState(Lcom/kaopu/download/intf/IDownloadState;)V

    .line 41
    iget-object v0, p0, Lcom/kaopu/download/BaseDownloadWorker;->mCallBack:Lcom/kaopu/download/BaseDownloadWorker$DownloadCallBack;

    if-eqz v0, :cond_0

    .line 42
    iget-object v0, p0, Lcom/kaopu/download/BaseDownloadWorker;->mCallBack:Lcom/kaopu/download/BaseDownloadWorker$DownloadCallBack;

    invoke-interface {v0, p1}, Lcom/kaopu/download/BaseDownloadWorker$DownloadCallBack;->onDownloadCanceled(Ljava/lang/String;)V

    .line 44
    :cond_0
    invoke-static {p1}, Lcom/kaopu/download/kernel/DownloadWorkerSupervisor;->remove(Ljava/lang/String;)Z

    .line 45
    invoke-direct {p0}, Lcom/kaopu/download/BaseDownloadWorker;->sendNotifyBroadcast()V

    .line 46
    return-void
.end method

.method protected onDownloadCanceling(Ljava/lang/String;)V
    .locals 2
    .param p1, "identification"    # Ljava/lang/String;

    .prologue
    .line 125
    .local p0, "this":Lcom/kaopu/download/BaseDownloadWorker;, "Lcom/kaopu/download/BaseDownloadWorker<TT;>;"
    iget-object v0, p0, Lcom/kaopu/download/BaseDownloadWorker;->mDownloadInfo:Lcom/kaopu/download/kernel/BaseDownloadInfo;

    invoke-static {}, Lcom/kaopu/download/BaseDownloadStateFactory;->getDownloadCancelingState()Lcom/kaopu/download/state/DownloadCancelingState;

    move-result-object v1

    invoke-virtual {v0, v1}, Lcom/kaopu/download/kernel/BaseDownloadInfo;->setState(Lcom/kaopu/download/intf/IDownloadState;)V

    .line 126
    iget-object v0, p0, Lcom/kaopu/download/BaseDownloadWorker;->mCallBack:Lcom/kaopu/download/BaseDownloadWorker$DownloadCallBack;

    if-eqz v0, :cond_0

    .line 127
    iget-object v0, p0, Lcom/kaopu/download/BaseDownloadWorker;->mCallBack:Lcom/kaopu/download/BaseDownloadWorker$DownloadCallBack;

    invoke-interface {v0, p1}, Lcom/kaopu/download/BaseDownloadWorker$DownloadCallBack;->onDownloadCanceling(Ljava/lang/String;)V

    .line 129
    :cond_0
    invoke-direct {p0}, Lcom/kaopu/download/BaseDownloadWorker;->sendNotifyBroadcast()V

    .line 130
    return-void
.end method

.method protected onDownloadCompleted(Ljava/lang/String;Ljava/lang/String;J)V
    .locals 5
    .param p1, "identification"    # Ljava/lang/String;
    .param p2, "file"    # Ljava/lang/String;
    .param p3, "totalSize"    # J

    .prologue
    .line 83
    .local p0, "this":Lcom/kaopu/download/BaseDownloadWorker;, "Lcom/kaopu/download/BaseDownloadWorker<TT;>;"
    iget-object v0, p0, Lcom/kaopu/download/BaseDownloadWorker;->mDownloadInfo:Lcom/kaopu/download/kernel/BaseDownloadInfo;

    invoke-static {}, Lcom/kaopu/download/BaseDownloadStateFactory;->getDownloadedState()Lcom/kaopu/download/state/DownloadedState;

    move-result-object v1

    invoke-virtual {v0, v1}, Lcom/kaopu/download/kernel/BaseDownloadInfo;->setState(Lcom/kaopu/download/intf/IDownloadState;)V

    .line 84
    iget-object v0, p0, Lcom/kaopu/download/BaseDownloadWorker;->mDownloadInfo:Lcom/kaopu/download/kernel/BaseDownloadInfo;

    invoke-static {}, Ljava/lang/System;->currentTimeMillis()J

    move-result-wide v2

    invoke-virtual {v0, v2, v3}, Lcom/kaopu/download/kernel/BaseDownloadInfo;->setDownloadedTime(J)V

    .line 85
    iget-object v0, p0, Lcom/kaopu/download/BaseDownloadWorker;->mCallBack:Lcom/kaopu/download/BaseDownloadWorker$DownloadCallBack;

    if-eqz v0, :cond_0

    .line 86
    iget-object v0, p0, Lcom/kaopu/download/BaseDownloadWorker;->mCallBack:Lcom/kaopu/download/BaseDownloadWorker$DownloadCallBack;

    invoke-interface {v0, p1, p2, p3, p4}, Lcom/kaopu/download/BaseDownloadWorker$DownloadCallBack;->onDownloadCompleted(Ljava/lang/String;Ljava/lang/String;J)V

    .line 88
    :cond_0
    invoke-static {p1}, Lcom/kaopu/download/kernel/DownloadWorkerSupervisor;->remove(Ljava/lang/String;)Z

    .line 89
    invoke-direct {p0}, Lcom/kaopu/download/BaseDownloadWorker;->sendNotifyBroadcast()V

    .line 90
    return-void
.end method

.method protected onDownloadConnecting(Ljava/lang/String;J)V
    .locals 4
    .param p1, "identification"    # Ljava/lang/String;
    .param p2, "downloadSize"    # J

    .prologue
    .line 94
    .local p0, "this":Lcom/kaopu/download/BaseDownloadWorker;, "Lcom/kaopu/download/BaseDownloadWorker<TT;>;"
    iget-object v0, p0, Lcom/kaopu/download/BaseDownloadWorker;->mDownloadInfo:Lcom/kaopu/download/kernel/BaseDownloadInfo;

    invoke-static {}, Lcom/kaopu/download/BaseDownloadStateFactory;->getDownloadConnectingState()Lcom/kaopu/download/state/DownloadConnectingState;

    move-result-object v1

    invoke-virtual {v0, v1}, Lcom/kaopu/download/kernel/BaseDownloadInfo;->setState(Lcom/kaopu/download/intf/IDownloadState;)V

    .line 95
    iget-object v0, p0, Lcom/kaopu/download/BaseDownloadWorker;->mDownloadInfo:Lcom/kaopu/download/kernel/BaseDownloadInfo;

    invoke-virtual {v0, p2, p3}, Lcom/kaopu/download/kernel/BaseDownloadInfo;->setdSize(J)V

    .line 96
    const-wide/16 v0, 0x0

    cmp-long v0, p2, v0

    if-nez v0, :cond_0

    .line 97
    iget-object v0, p0, Lcom/kaopu/download/BaseDownloadWorker;->mDownloadInfo:Lcom/kaopu/download/kernel/BaseDownloadInfo;

    invoke-static {}, Ljava/lang/System;->currentTimeMillis()J

    move-result-wide v2

    invoke-virtual {v0, v2, v3}, Lcom/kaopu/download/kernel/BaseDownloadInfo;->setCreateTime(J)V

    .line 99
    :cond_0
    iget-object v0, p0, Lcom/kaopu/download/BaseDownloadWorker;->mCallBack:Lcom/kaopu/download/BaseDownloadWorker$DownloadCallBack;

    if-eqz v0, :cond_1

    .line 100
    iget-object v0, p0, Lcom/kaopu/download/BaseDownloadWorker;->mCallBack:Lcom/kaopu/download/BaseDownloadWorker$DownloadCallBack;

    invoke-interface {v0, p1, p2, p3}, Lcom/kaopu/download/BaseDownloadWorker$DownloadCallBack;->onDownloadStart(Ljava/lang/String;J)V

    .line 102
    :cond_1
    invoke-direct {p0}, Lcom/kaopu/download/BaseDownloadWorker;->sendNotifyBroadcast()V

    .line 103
    return-void
.end method

.method protected onDownloadFailed(Ljava/lang/String;)V
    .locals 2
    .param p1, "identification"    # Ljava/lang/String;

    .prologue
    .line 134
    .local p0, "this":Lcom/kaopu/download/BaseDownloadWorker;, "Lcom/kaopu/download/BaseDownloadWorker<TT;>;"
    iget-object v0, p0, Lcom/kaopu/download/BaseDownloadWorker;->mDownloadInfo:Lcom/kaopu/download/kernel/BaseDownloadInfo;

    invoke-static {}, Lcom/kaopu/download/BaseDownloadStateFactory;->getDownloadFailedState()Lcom/kaopu/download/state/DownloadFailedState;

    move-result-object v1

    invoke-virtual {v0, v1}, Lcom/kaopu/download/kernel/BaseDownloadInfo;->setState(Lcom/kaopu/download/intf/IDownloadState;)V

    .line 135
    iget-object v0, p0, Lcom/kaopu/download/BaseDownloadWorker;->mCallBack:Lcom/kaopu/download/BaseDownloadWorker$DownloadCallBack;

    if-eqz v0, :cond_0

    .line 136
    iget-object v0, p0, Lcom/kaopu/download/BaseDownloadWorker;->mCallBack:Lcom/kaopu/download/BaseDownloadWorker$DownloadCallBack;

    invoke-interface {v0, p1}, Lcom/kaopu/download/BaseDownloadWorker$DownloadCallBack;->onDownloadFailed(Ljava/lang/String;)V

    .line 138
    :cond_0
    invoke-static {p1}, Lcom/kaopu/download/kernel/DownloadWorkerSupervisor;->remove(Ljava/lang/String;)Z

    .line 139
    invoke-direct {p0}, Lcom/kaopu/download/BaseDownloadWorker;->sendNotifyBroadcast()V

    .line 140
    return-void
.end method

.method protected onDownloadPaused(Ljava/lang/String;)V
    .locals 2
    .param p1, "identification"    # Ljava/lang/String;

    .prologue
    .line 50
    .local p0, "this":Lcom/kaopu/download/BaseDownloadWorker;, "Lcom/kaopu/download/BaseDownloadWorker<TT;>;"
    iget-object v0, p0, Lcom/kaopu/download/BaseDownloadWorker;->mDownloadInfo:Lcom/kaopu/download/kernel/BaseDownloadInfo;

    invoke-static {}, Lcom/kaopu/download/BaseDownloadStateFactory;->getDownloadPausedState()Lcom/kaopu/download/state/DownloadPausedState;

    move-result-object v1

    invoke-virtual {v0, v1}, Lcom/kaopu/download/kernel/BaseDownloadInfo;->setState(Lcom/kaopu/download/intf/IDownloadState;)V

    .line 51
    iget-object v0, p0, Lcom/kaopu/download/BaseDownloadWorker;->mCallBack:Lcom/kaopu/download/BaseDownloadWorker$DownloadCallBack;

    if-eqz v0, :cond_0

    .line 52
    iget-object v0, p0, Lcom/kaopu/download/BaseDownloadWorker;->mCallBack:Lcom/kaopu/download/BaseDownloadWorker$DownloadCallBack;

    invoke-interface {v0, p1}, Lcom/kaopu/download/BaseDownloadWorker$DownloadCallBack;->onDownloadPaused(Ljava/lang/String;)V

    .line 54
    :cond_0
    invoke-static {p1}, Lcom/kaopu/download/kernel/DownloadWorkerSupervisor;->remove(Ljava/lang/String;)Z

    .line 55
    invoke-direct {p0}, Lcom/kaopu/download/BaseDownloadWorker;->sendNotifyBroadcast()V

    .line 56
    return-void
.end method

.method protected onDownloadPausing(Ljava/lang/String;)V
    .locals 2
    .param p1, "identification"    # Ljava/lang/String;

    .prologue
    .line 116
    .local p0, "this":Lcom/kaopu/download/BaseDownloadWorker;, "Lcom/kaopu/download/BaseDownloadWorker<TT;>;"
    iget-object v0, p0, Lcom/kaopu/download/BaseDownloadWorker;->mDownloadInfo:Lcom/kaopu/download/kernel/BaseDownloadInfo;

    invoke-static {}, Lcom/kaopu/download/BaseDownloadStateFactory;->getDownloadPausingState()Lcom/kaopu/download/state/DownloadPausingState;

    move-result-object v1

    invoke-virtual {v0, v1}, Lcom/kaopu/download/kernel/BaseDownloadInfo;->setState(Lcom/kaopu/download/intf/IDownloadState;)V

    .line 117
    iget-object v0, p0, Lcom/kaopu/download/BaseDownloadWorker;->mCallBack:Lcom/kaopu/download/BaseDownloadWorker$DownloadCallBack;

    if-eqz v0, :cond_0

    .line 118
    iget-object v0, p0, Lcom/kaopu/download/BaseDownloadWorker;->mCallBack:Lcom/kaopu/download/BaseDownloadWorker$DownloadCallBack;

    invoke-interface {v0, p1}, Lcom/kaopu/download/BaseDownloadWorker$DownloadCallBack;->onDownloadPausing(Ljava/lang/String;)V

    .line 120
    :cond_0
    invoke-direct {p0}, Lcom/kaopu/download/BaseDownloadWorker;->sendNotifyBroadcast()V

    .line 121
    return-void
.end method

.method protected onDownloadWait(Ljava/lang/String;)V
    .locals 2
    .param p1, "identification"    # Ljava/lang/String;

    .prologue
    .line 107
    .local p0, "this":Lcom/kaopu/download/BaseDownloadWorker;, "Lcom/kaopu/download/BaseDownloadWorker<TT;>;"
    iget-object v0, p0, Lcom/kaopu/download/BaseDownloadWorker;->mDownloadInfo:Lcom/kaopu/download/kernel/BaseDownloadInfo;

    invoke-static {}, Lcom/kaopu/download/BaseDownloadStateFactory;->getDownloadWaitState()Lcom/kaopu/download/state/DownloadWaitState;

    move-result-object v1

    invoke-virtual {v0, v1}, Lcom/kaopu/download/kernel/BaseDownloadInfo;->setState(Lcom/kaopu/download/intf/IDownloadState;)V

    .line 108
    iget-object v0, p0, Lcom/kaopu/download/BaseDownloadWorker;->mCallBack:Lcom/kaopu/download/BaseDownloadWorker$DownloadCallBack;

    if-eqz v0, :cond_0

    .line 109
    iget-object v0, p0, Lcom/kaopu/download/BaseDownloadWorker;->mCallBack:Lcom/kaopu/download/BaseDownloadWorker$DownloadCallBack;

    invoke-interface {v0, p1}, Lcom/kaopu/download/BaseDownloadWorker$DownloadCallBack;->onDownloadWait(Ljava/lang/String;)V

    .line 111
    :cond_0
    invoke-direct {p0}, Lcom/kaopu/download/BaseDownloadWorker;->sendNotifyBroadcast()V

    .line 112
    return-void
.end method

.method protected onDownloadWorking(Ljava/lang/String;JJI)V
    .locals 20
    .param p1, "identification"    # Ljava/lang/String;
    .param p2, "totalSize"    # J
    .param p4, "downloadSize"    # J
    .param p6, "progress"    # I

    .prologue
    .line 60
    .local p0, "this":Lcom/kaopu/download/BaseDownloadWorker;, "Lcom/kaopu/download/BaseDownloadWorker<TT;>;"
    move-object/from16 v0, p0

    iget-object v4, v0, Lcom/kaopu/download/BaseDownloadWorker;->mDownloadInfo:Lcom/kaopu/download/kernel/BaseDownloadInfo;

    invoke-static {}, Lcom/kaopu/download/BaseDownloadStateFactory;->getDownloadingState()Lcom/kaopu/download/state/DownloadingState;

    move-result-object v5

    invoke-virtual {v4, v5}, Lcom/kaopu/download/kernel/BaseDownloadInfo;->setState(Lcom/kaopu/download/intf/IDownloadState;)V

    .line 61
    move-object/from16 v0, p0

    iget-object v4, v0, Lcom/kaopu/download/BaseDownloadWorker;->mDownloadInfo:Lcom/kaopu/download/kernel/BaseDownloadInfo;

    move-wide/from16 v0, p2

    invoke-virtual {v4, v0, v1}, Lcom/kaopu/download/kernel/BaseDownloadInfo;->setfSize(J)V

    .line 62
    move-object/from16 v0, p0

    iget-object v4, v0, Lcom/kaopu/download/BaseDownloadWorker;->mDownloadInfo:Lcom/kaopu/download/kernel/BaseDownloadInfo;

    move-wide/from16 v0, p4

    invoke-virtual {v4, v0, v1}, Lcom/kaopu/download/kernel/BaseDownloadInfo;->setdSize(J)V

    .line 63
    move-object/from16 v0, p0

    iget-wide v4, v0, Lcom/kaopu/download/BaseDownloadWorker;->timeOld:J

    const-wide/16 v6, 0x0

    cmp-long v4, v4, v6

    if-nez v4, :cond_1

    .line 64
    invoke-static {}, Ljava/lang/System;->currentTimeMillis()J

    move-result-wide v4

    move-object/from16 v0, p0

    iput-wide v4, v0, Lcom/kaopu/download/BaseDownloadWorker;->timeOld:J

    .line 65
    move-wide/from16 v0, p4

    move-object/from16 v2, p0

    iput-wide v0, v2, Lcom/kaopu/download/BaseDownloadWorker;->sizeOld:J

    .line 66
    move-object/from16 v0, p0

    iget-object v4, v0, Lcom/kaopu/download/BaseDownloadWorker;->mDownloadInfo:Lcom/kaopu/download/kernel/BaseDownloadInfo;

    const-wide/16 v6, 0x0

    invoke-virtual {v4, v6, v7}, Lcom/kaopu/download/kernel/BaseDownloadInfo;->setSpeed(J)V

    .line 74
    :goto_0
    move-object/from16 v0, p0

    iget-object v4, v0, Lcom/kaopu/download/BaseDownloadWorker;->mCallBack:Lcom/kaopu/download/BaseDownloadWorker$DownloadCallBack;

    if-eqz v4, :cond_0

    .line 76
    move-object/from16 v0, p0

    iget-object v4, v0, Lcom/kaopu/download/BaseDownloadWorker;->mCallBack:Lcom/kaopu/download/BaseDownloadWorker$DownloadCallBack;

    move-object/from16 v5, p1

    move-wide/from16 v6, p2

    move-wide/from16 v8, p4

    move/from16 v10, p6

    invoke-interface/range {v4 .. v10}, Lcom/kaopu/download/BaseDownloadWorker$DownloadCallBack;->onDownloadWorking(Ljava/lang/String;JJI)V

    .line 78
    :cond_0
    invoke-direct/range {p0 .. p0}, Lcom/kaopu/download/BaseDownloadWorker;->sendNotifyBroadcast()V

    .line 79
    return-void

    .line 68
    :cond_1
    invoke-static {}, Ljava/lang/System;->currentTimeMillis()J

    move-result-wide v18

    .line 69
    .local v18, "timeNow":J
    move-object/from16 v0, p0

    iget-wide v4, v0, Lcom/kaopu/download/BaseDownloadWorker;->timeOld:J

    sub-long v16, v18, v4

    .line 70
    .local v16, "timeInterval":J
    move-object/from16 v0, p0

    iget-wide v4, v0, Lcom/kaopu/download/BaseDownloadWorker;->sizeOld:J

    sub-long v12, p4, v4

    .line 71
    .local v12, "addSize":J
    div-long v14, v12, v16

    .line 72
    .local v14, "speed":J
    move-object/from16 v0, p0

    iget-object v4, v0, Lcom/kaopu/download/BaseDownloadWorker;->mDownloadInfo:Lcom/kaopu/download/kernel/BaseDownloadInfo;

    invoke-virtual {v4, v14, v15}, Lcom/kaopu/download/kernel/BaseDownloadInfo;->setSpeed(J)V

    goto :goto_0
.end method
