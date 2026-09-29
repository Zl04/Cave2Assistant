.class public interface abstract Lcom/kaopu/download/intf/IDownloadView;
.super Ljava/lang/Object;
.source "IDownloadView.java"


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
.method public abstract cancel()V
.end method

.method public abstract checkDownloadState(Lcom/kaopu/download/kernel/BaseDownloadInfo;)Z
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "(TT;)Z"
        }
    .end annotation
.end method

.method public abstract getContext()Landroid/content/Context;
.end method

.method public abstract getDownloadInfo()Lcom/kaopu/download/kernel/BaseDownloadInfo;
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "()TT;"
        }
    .end annotation
.end method

.method public abstract getState()Lcom/kaopu/download/BaseDownloadStateFactory$State;
.end method

.method public abstract pause()V
.end method

.method public abstract setDownloadInfo(Lcom/kaopu/download/kernel/BaseDownloadInfo;)V
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "(TT;)V"
        }
    .end annotation
.end method
