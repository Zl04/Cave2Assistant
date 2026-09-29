.class public abstract Lcom/kaopu/download/abst/ADownloadDisplayHelper;
.super Ljava/lang/Object;
.source "ADownloadDisplayHelper.java"

# interfaces
.implements Lcom/kaopu/download/intf/IDownloadDisplayHelper;


# annotations
.annotation system Ldalvik/annotation/MemberClasses;
    value = {
        Lcom/kaopu/download/abst/ADownloadDisplayHelper$DownloadViewNotifyBroadcastReceiver;
    }
.end annotation

.annotation system Ldalvik/annotation/Signature;
    value = {
        "<T:",
        "Lcom/kaopu/download/kernel/BaseDownloadInfo;",
        ">",
        "Ljava/lang/Object;",
        "Lcom/kaopu/download/intf/IDownloadDisplayHelper",
        "<TT;>;"
    }
.end annotation


# instance fields
.field private mContext:Landroid/content/Context;

.field private mDownloadView:Lcom/kaopu/download/intf/IDownloadView;
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "Lcom/kaopu/download/intf/IDownloadView",
            "<TT;>;"
        }
    .end annotation
.end field

.field private mReceiver:Lcom/kaopu/download/abst/ADownloadDisplayHelper$DownloadViewNotifyBroadcastReceiver;
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "Lcom/kaopu/download/abst/ADownloadDisplayHelper",
            "<TT;>.DownloadViewNotifyBroadcastReceiver;"
        }
    .end annotation
.end field


# direct methods
.method public constructor <init>(Lcom/kaopu/download/intf/IDownloadView;)V
    .locals 1
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "(",
            "Lcom/kaopu/download/intf/IDownloadView",
            "<TT;>;)V"
        }
    .end annotation

    .prologue
    .line 25
    .local p0, "this":Lcom/kaopu/download/abst/ADownloadDisplayHelper;, "Lcom/kaopu/download/abst/ADownloadDisplayHelper<TT;>;"
    .local p1, "downloadView":Lcom/kaopu/download/intf/IDownloadView;, "Lcom/kaopu/download/intf/IDownloadView<TT;>;"
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    .line 26
    iput-object p1, p0, Lcom/kaopu/download/abst/ADownloadDisplayHelper;->mDownloadView:Lcom/kaopu/download/intf/IDownloadView;

    .line 27
    iget-object v0, p0, Lcom/kaopu/download/abst/ADownloadDisplayHelper;->mDownloadView:Lcom/kaopu/download/intf/IDownloadView;

    invoke-interface {v0}, Lcom/kaopu/download/intf/IDownloadView;->getContext()Landroid/content/Context;

    move-result-object v0

    iput-object v0, p0, Lcom/kaopu/download/abst/ADownloadDisplayHelper;->mContext:Landroid/content/Context;

    .line 28
    return-void
.end method


# virtual methods
.method public getReceiver()Lcom/kaopu/download/abst/ADownloadDisplayHelper$DownloadViewNotifyBroadcastReceiver;
    .locals 1
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "()",
            "Lcom/kaopu/download/abst/ADownloadDisplayHelper",
            "<TT;>.DownloadViewNotifyBroadcastReceiver;"
        }
    .end annotation

    .prologue
    .line 31
    .local p0, "this":Lcom/kaopu/download/abst/ADownloadDisplayHelper;, "Lcom/kaopu/download/abst/ADownloadDisplayHelper<TT;>;"
    iget-object v0, p0, Lcom/kaopu/download/abst/ADownloadDisplayHelper;->mReceiver:Lcom/kaopu/download/abst/ADownloadDisplayHelper$DownloadViewNotifyBroadcastReceiver;

    return-object v0
.end method

.method public onReceiveResult(Landroid/content/Context;Landroid/content/Intent;)V
    .locals 2
    .param p1, "context"    # Landroid/content/Context;
    .param p2, "intent"    # Landroid/content/Intent;

    .prologue
    .line 66
    .local p0, "this":Lcom/kaopu/download/abst/ADownloadDisplayHelper;, "Lcom/kaopu/download/abst/ADownloadDisplayHelper<TT;>;"
    const-string v1, "info_key"

    invoke-virtual {p2, v1}, Landroid/content/Intent;->getParcelableExtra(Ljava/lang/String;)Landroid/os/Parcelable;

    move-result-object v0

    check-cast v0, Lcom/kaopu/download/kernel/BaseDownloadInfo;

    .line 67
    .local v0, "info":Lcom/kaopu/download/kernel/BaseDownloadInfo;, "TT;"
    iget-object v1, p0, Lcom/kaopu/download/abst/ADownloadDisplayHelper;->mDownloadView:Lcom/kaopu/download/intf/IDownloadView;

    invoke-interface {v1, v0}, Lcom/kaopu/download/intf/IDownloadView;->checkDownloadState(Lcom/kaopu/download/kernel/BaseDownloadInfo;)Z

    move-result v1

    if-eqz v1, :cond_0

    .line 68
    iget-object v1, p0, Lcom/kaopu/download/abst/ADownloadDisplayHelper;->mDownloadView:Lcom/kaopu/download/intf/IDownloadView;

    invoke-interface {v1, v0}, Lcom/kaopu/download/intf/IDownloadView;->setDownloadInfo(Lcom/kaopu/download/kernel/BaseDownloadInfo;)V

    .line 70
    :cond_0
    return-void
.end method

.method public registerDownloadReceiver()V
    .locals 3

    .prologue
    .line 40
    .local p0, "this":Lcom/kaopu/download/abst/ADownloadDisplayHelper;, "Lcom/kaopu/download/abst/ADownloadDisplayHelper<TT;>;"
    new-instance v0, Landroid/content/IntentFilter;

    const-string v1, "com.kaopu.core.download.BaseDownloadWorker.notify_view_action"

    invoke-direct {v0, v1}, Landroid/content/IntentFilter;-><init>(Ljava/lang/String;)V

    .line 41
    .local v0, "filter":Landroid/content/IntentFilter;
    iget-object v1, p0, Lcom/kaopu/download/abst/ADownloadDisplayHelper;->mReceiver:Lcom/kaopu/download/abst/ADownloadDisplayHelper$DownloadViewNotifyBroadcastReceiver;

    if-nez v1, :cond_0

    .line 42
    new-instance v1, Lcom/kaopu/download/abst/ADownloadDisplayHelper$DownloadViewNotifyBroadcastReceiver;

    const/4 v2, 0x0

    invoke-direct {v1, p0, v2}, Lcom/kaopu/download/abst/ADownloadDisplayHelper$DownloadViewNotifyBroadcastReceiver;-><init>(Lcom/kaopu/download/abst/ADownloadDisplayHelper;Lcom/kaopu/download/abst/ADownloadDisplayHelper$DownloadViewNotifyBroadcastReceiver;)V

    iput-object v1, p0, Lcom/kaopu/download/abst/ADownloadDisplayHelper;->mReceiver:Lcom/kaopu/download/abst/ADownloadDisplayHelper$DownloadViewNotifyBroadcastReceiver;

    .line 44
    :cond_0
    iget-object v1, p0, Lcom/kaopu/download/abst/ADownloadDisplayHelper;->mContext:Landroid/content/Context;

    iget-object v2, p0, Lcom/kaopu/download/abst/ADownloadDisplayHelper;->mReceiver:Lcom/kaopu/download/abst/ADownloadDisplayHelper$DownloadViewNotifyBroadcastReceiver;

    invoke-virtual {v1, v2, v0}, Landroid/content/Context;->registerReceiver(Landroid/content/BroadcastReceiver;Landroid/content/IntentFilter;)Landroid/content/Intent;

    .line 45
    return-void
.end method

.method public setReceiver(Lcom/kaopu/download/abst/ADownloadDisplayHelper$DownloadViewNotifyBroadcastReceiver;)V
    .locals 0
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "(",
            "Lcom/kaopu/download/abst/ADownloadDisplayHelper",
            "<TT;>.DownloadViewNotifyBroadcastReceiver;)V"
        }
    .end annotation

    .prologue
    .line 35
    .local p0, "this":Lcom/kaopu/download/abst/ADownloadDisplayHelper;, "Lcom/kaopu/download/abst/ADownloadDisplayHelper<TT;>;"
    .local p1, "receiver":Lcom/kaopu/download/abst/ADownloadDisplayHelper$DownloadViewNotifyBroadcastReceiver;, "Lcom/kaopu/download/abst/ADownloadDisplayHelper<TT;>.DownloadViewNotifyBroadcastReceiver;"
    iput-object p1, p0, Lcom/kaopu/download/abst/ADownloadDisplayHelper;->mReceiver:Lcom/kaopu/download/abst/ADownloadDisplayHelper$DownloadViewNotifyBroadcastReceiver;

    .line 36
    return-void
.end method

.method public unregisterDownloadReceiver()V
    .locals 2

    .prologue
    .line 49
    .local p0, "this":Lcom/kaopu/download/abst/ADownloadDisplayHelper;, "Lcom/kaopu/download/abst/ADownloadDisplayHelper<TT;>;"
    iget-object v0, p0, Lcom/kaopu/download/abst/ADownloadDisplayHelper;->mReceiver:Lcom/kaopu/download/abst/ADownloadDisplayHelper$DownloadViewNotifyBroadcastReceiver;

    if-eqz v0, :cond_0

    .line 50
    iget-object v0, p0, Lcom/kaopu/download/abst/ADownloadDisplayHelper;->mContext:Landroid/content/Context;

    iget-object v1, p0, Lcom/kaopu/download/abst/ADownloadDisplayHelper;->mReceiver:Lcom/kaopu/download/abst/ADownloadDisplayHelper$DownloadViewNotifyBroadcastReceiver;

    invoke-virtual {v0, v1}, Landroid/content/Context;->unregisterReceiver(Landroid/content/BroadcastReceiver;)V

    .line 52
    :cond_0
    return-void
.end method
