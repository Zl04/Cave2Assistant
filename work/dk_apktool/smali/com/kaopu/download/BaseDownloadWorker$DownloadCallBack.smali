.class public interface abstract Lcom/kaopu/download/BaseDownloadWorker$DownloadCallBack;
.super Ljava/lang/Object;
.source "BaseDownloadWorker.java"

# interfaces
.implements Landroid/os/Parcelable;


# annotations
.annotation system Ldalvik/annotation/EnclosingClass;
    value = Lcom/kaopu/download/BaseDownloadWorker;
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x609
    name = "DownloadCallBack"
.end annotation


# virtual methods
.method public abstract onDownloadCanceled(Ljava/lang/String;)V
.end method

.method public abstract onDownloadCanceling(Ljava/lang/String;)V
.end method

.method public abstract onDownloadCompleted(Ljava/lang/String;Ljava/lang/String;J)V
.end method

.method public abstract onDownloadFailed(Ljava/lang/String;)V
.end method

.method public abstract onDownloadPaused(Ljava/lang/String;)V
.end method

.method public abstract onDownloadPausing(Ljava/lang/String;)V
.end method

.method public abstract onDownloadStart(Ljava/lang/String;J)V
.end method

.method public abstract onDownloadWait(Ljava/lang/String;)V
.end method

.method public abstract onDownloadWorking(Ljava/lang/String;JJI)V
.end method
