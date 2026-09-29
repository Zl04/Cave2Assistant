.class public interface abstract Lcom/kaopu/download/intf/IDownloadDisplayHelper;
.super Ljava/lang/Object;
.source "IDownloadDisplayHelper.java"


# annotations
.annotation system Ldalvik/annotation/Signature;
    value = {
        "<T:",
        "Lcom/kaopu/download/kernel/BaseDownloadInfo;",
        ">",
        "Ljava/lang/Object;"
    }
.end annotation


# virtual methods
.method public abstract getDownloadInfo()Lcom/kaopu/download/kernel/BaseDownloadInfo;
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "()TT;"
        }
    .end annotation
.end method

.method public abstract onDownloadCancelingDisplay()V
.end method

.method public abstract onDownloadConnectDisplay()V
.end method

.method public abstract onDownloadFailedDisplay()V
.end method

.method public abstract onDownloadNewDisplay()V
.end method

.method public abstract onDownloadNoneDisplay()V
.end method

.method public abstract onDownloadPausedDisplay()V
.end method

.method public abstract onDownloadPausingDisplay()V
.end method

.method public abstract onDownloadWaitDisplay()V
.end method

.method public abstract onDownloadedDisplay()V
.end method

.method public abstract onDownloadingDisplay()V
.end method

.method public abstract registerDownloadReceiver()V
.end method

.method public abstract setDownloadInfo(Lcom/kaopu/download/kernel/BaseDownloadInfo;)V
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "(TT;)V"
        }
    .end annotation
.end method

.method public abstract unregisterDownloadReceiver()V
.end method
