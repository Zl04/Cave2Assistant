.class public interface abstract Lcom/kaopu/download/intf/IDownloadClickHelper;
.super Ljava/lang/Object;
.source "IDownloadClickHelper.java"


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

.method public abstract onDownloadCancelingClick()V
.end method

.method public abstract onDownloadConnectingClick()V
.end method

.method public abstract onDownloadFailedClick()V
.end method

.method public abstract onDownloadNewClick()V
.end method

.method public abstract onDownloadNoneClick()V
.end method

.method public abstract onDownloadPausedClick()V
.end method

.method public abstract onDownloadPausingClick()V
.end method

.method public abstract onDownloadWaitClick()V
.end method

.method public abstract onDownloadedClick()V
.end method

.method public abstract onDownloadingClick()V
.end method

.method public abstract setDownloadInfo(Lcom/kaopu/download/kernel/BaseDownloadInfo;)V
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "(TT;)V"
        }
    .end annotation
.end method
