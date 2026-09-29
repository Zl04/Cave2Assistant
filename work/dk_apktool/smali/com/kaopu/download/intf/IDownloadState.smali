.class public interface abstract Lcom/kaopu/download/intf/IDownloadState;
.super Ljava/lang/Object;
.source "IDownloadState.java"

# interfaces
.implements Landroid/os/Parcelable;


# virtual methods
.method public abstract display(Lcom/kaopu/download/intf/IDownloadDisplayHelper;)V
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "(",
            "Lcom/kaopu/download/intf/IDownloadDisplayHelper",
            "<+",
            "Lcom/kaopu/download/kernel/BaseDownloadInfo;",
            ">;)V"
        }
    .end annotation
.end method

.method public abstract getState()Lcom/kaopu/download/BaseDownloadStateFactory$State;
.end method

.method public abstract onClick(Lcom/kaopu/download/intf/IDownloadClickHelper;)V
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "(",
            "Lcom/kaopu/download/intf/IDownloadClickHelper",
            "<+",
            "Lcom/kaopu/download/kernel/BaseDownloadInfo;",
            ">;)V"
        }
    .end annotation
.end method
