.class public abstract Lcom/kaopu/download/BaseDownloadClickHelper;
.super Ljava/lang/Object;
.source "BaseDownloadClickHelper.java"

# interfaces
.implements Lcom/kaopu/download/intf/IDownloadClickHelper;


# annotations
.annotation system Ldalvik/annotation/Signature;
    value = {
        "<T:",
        "Lcom/kaopu/download/kernel/BaseDownloadInfo;",
        ">",
        "Ljava/lang/Object;",
        "Lcom/kaopu/download/intf/IDownloadClickHelper",
        "<TT;>;"
    }
.end annotation


# static fields
.field private static final TAG:Ljava/lang/String;


# instance fields
.field public mContext:Landroid/content/Context;

.field public mDownloadInfo:Lcom/kaopu/download/kernel/BaseDownloadInfo;
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "TT;"
        }
    .end annotation
.end field

.field private mDownloadView:Lcom/kaopu/download/intf/IDownloadView;
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "Lcom/kaopu/download/intf/IDownloadView",
            "<TT;>;"
        }
    .end annotation
.end field


# direct methods
.method static constructor <clinit>()V
    .locals 1

    .prologue
    .line 18
    const-class v0, Lcom/kaopu/download/BaseDownloadClickHelper;

    invoke-virtual {v0}, Ljava/lang/Class;->getName()Ljava/lang/String;

    move-result-object v0

    sput-object v0, Lcom/kaopu/download/BaseDownloadClickHelper;->TAG:Ljava/lang/String;

    return-void
.end method

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
    .line 31
    .local p0, "this":Lcom/kaopu/download/BaseDownloadClickHelper;, "Lcom/kaopu/download/BaseDownloadClickHelper<TT;>;"
    .local p1, "downloadView":Lcom/kaopu/download/intf/IDownloadView;, "Lcom/kaopu/download/intf/IDownloadView<TT;>;"
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    .line 32
    iput-object p1, p0, Lcom/kaopu/download/BaseDownloadClickHelper;->mDownloadView:Lcom/kaopu/download/intf/IDownloadView;

    .line 33
    iget-object v0, p0, Lcom/kaopu/download/BaseDownloadClickHelper;->mDownloadView:Lcom/kaopu/download/intf/IDownloadView;

    invoke-interface {v0}, Lcom/kaopu/download/intf/IDownloadView;->getContext()Landroid/content/Context;

    move-result-object v0

    iput-object v0, p0, Lcom/kaopu/download/BaseDownloadClickHelper;->mContext:Landroid/content/Context;

    .line 34
    return-void
.end method


# virtual methods
.method public getDownloadInfo()Lcom/kaopu/download/kernel/BaseDownloadInfo;
    .locals 1
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "()TT;"
        }
    .end annotation

    .prologue
    .line 83
    .local p0, "this":Lcom/kaopu/download/BaseDownloadClickHelper;, "Lcom/kaopu/download/BaseDownloadClickHelper<TT;>;"
    iget-object v0, p0, Lcom/kaopu/download/BaseDownloadClickHelper;->mDownloadInfo:Lcom/kaopu/download/kernel/BaseDownloadInfo;

    return-object v0
.end method

.method public onDownloadCancelingClick()V
    .locals 0

    .prologue
    .line 69
    .local p0, "this":Lcom/kaopu/download/BaseDownloadClickHelper;, "Lcom/kaopu/download/BaseDownloadClickHelper<TT;>;"
    return-void
.end method

.method public onDownloadConnectingClick()V
    .locals 2

    .prologue
    .line 38
    .local p0, "this":Lcom/kaopu/download/BaseDownloadClickHelper;, "Lcom/kaopu/download/BaseDownloadClickHelper<TT;>;"
    iget-object v0, p0, Lcom/kaopu/download/BaseDownloadClickHelper;->mContext:Landroid/content/Context;

    iget-object v1, p0, Lcom/kaopu/download/BaseDownloadClickHelper;->mDownloadInfo:Lcom/kaopu/download/kernel/BaseDownloadInfo;

    invoke-static {v0, v1}, Lcom/kaopu/download/BaseDownloadOperate;->pauseDownloadTask(Landroid/content/Context;Lcom/kaopu/download/kernel/BaseDownloadInfo;)V

    .line 39
    return-void
.end method

.method public onDownloadFailedClick()V
    .locals 2

    .prologue
    .line 73
    .local p0, "this":Lcom/kaopu/download/BaseDownloadClickHelper;, "Lcom/kaopu/download/BaseDownloadClickHelper<TT;>;"
    iget-object v0, p0, Lcom/kaopu/download/BaseDownloadClickHelper;->mContext:Landroid/content/Context;

    iget-object v1, p0, Lcom/kaopu/download/BaseDownloadClickHelper;->mDownloadInfo:Lcom/kaopu/download/kernel/BaseDownloadInfo;

    invoke-static {v0, v1}, Lcom/kaopu/download/BaseDownloadOperate;->addNewDownloadTask(Landroid/content/Context;Lcom/kaopu/download/kernel/BaseDownloadInfo;)V

    .line 75
    return-void
.end method

.method public onDownloadNewClick()V
    .locals 2

    .prologue
    .line 43
    .local p0, "this":Lcom/kaopu/download/BaseDownloadClickHelper;, "Lcom/kaopu/download/BaseDownloadClickHelper<TT;>;"
    iget-object v0, p0, Lcom/kaopu/download/BaseDownloadClickHelper;->mContext:Landroid/content/Context;

    iget-object v1, p0, Lcom/kaopu/download/BaseDownloadClickHelper;->mDownloadInfo:Lcom/kaopu/download/kernel/BaseDownloadInfo;

    invoke-static {v0, v1}, Lcom/kaopu/download/BaseDownloadOperate;->addNewDownloadTask(Landroid/content/Context;Lcom/kaopu/download/kernel/BaseDownloadInfo;)V

    .line 44
    return-void
.end method

.method public onDownloadNoneClick()V
    .locals 2

    .prologue
    .line 79
    .local p0, "this":Lcom/kaopu/download/BaseDownloadClickHelper;, "Lcom/kaopu/download/BaseDownloadClickHelper<TT;>;"
    iget-object v0, p0, Lcom/kaopu/download/BaseDownloadClickHelper;->mContext:Landroid/content/Context;

    iget-object v1, p0, Lcom/kaopu/download/BaseDownloadClickHelper;->mDownloadInfo:Lcom/kaopu/download/kernel/BaseDownloadInfo;

    invoke-static {v0, v1}, Lcom/kaopu/download/BaseDownloadOperate;->addNewDownloadTask(Landroid/content/Context;Lcom/kaopu/download/kernel/BaseDownloadInfo;)V

    .line 80
    return-void
.end method

.method public onDownloadPausedClick()V
    .locals 2

    .prologue
    .line 63
    .local p0, "this":Lcom/kaopu/download/BaseDownloadClickHelper;, "Lcom/kaopu/download/BaseDownloadClickHelper<TT;>;"
    iget-object v0, p0, Lcom/kaopu/download/BaseDownloadClickHelper;->mContext:Landroid/content/Context;

    iget-object v1, p0, Lcom/kaopu/download/BaseDownloadClickHelper;->mDownloadInfo:Lcom/kaopu/download/kernel/BaseDownloadInfo;

    invoke-static {v0, v1}, Lcom/kaopu/download/BaseDownloadOperate;->addNewDownloadTask(Landroid/content/Context;Lcom/kaopu/download/kernel/BaseDownloadInfo;)V

    .line 64
    return-void
.end method

.method public onDownloadPausingClick()V
    .locals 0

    .prologue
    .line 59
    .local p0, "this":Lcom/kaopu/download/BaseDownloadClickHelper;, "Lcom/kaopu/download/BaseDownloadClickHelper<TT;>;"
    return-void
.end method

.method public onDownloadWaitClick()V
    .locals 2

    .prologue
    .line 48
    .local p0, "this":Lcom/kaopu/download/BaseDownloadClickHelper;, "Lcom/kaopu/download/BaseDownloadClickHelper<TT;>;"
    iget-object v0, p0, Lcom/kaopu/download/BaseDownloadClickHelper;->mContext:Landroid/content/Context;

    iget-object v1, p0, Lcom/kaopu/download/BaseDownloadClickHelper;->mDownloadInfo:Lcom/kaopu/download/kernel/BaseDownloadInfo;

    invoke-static {v0, v1}, Lcom/kaopu/download/BaseDownloadOperate;->pauseDownloadTask(Landroid/content/Context;Lcom/kaopu/download/kernel/BaseDownloadInfo;)V

    .line 49
    return-void
.end method

.method public onDownloadingClick()V
    .locals 2

    .prologue
    .line 53
    .local p0, "this":Lcom/kaopu/download/BaseDownloadClickHelper;, "Lcom/kaopu/download/BaseDownloadClickHelper<TT;>;"
    iget-object v0, p0, Lcom/kaopu/download/BaseDownloadClickHelper;->mContext:Landroid/content/Context;

    iget-object v1, p0, Lcom/kaopu/download/BaseDownloadClickHelper;->mDownloadInfo:Lcom/kaopu/download/kernel/BaseDownloadInfo;

    invoke-static {v0, v1}, Lcom/kaopu/download/BaseDownloadOperate;->pauseDownloadTask(Landroid/content/Context;Lcom/kaopu/download/kernel/BaseDownloadInfo;)V

    .line 54
    return-void
.end method

.method public setDownloadInfo(Lcom/kaopu/download/kernel/BaseDownloadInfo;)V
    .locals 0
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "(TT;)V"
        }
    .end annotation

    .prologue
    .line 87
    .local p0, "this":Lcom/kaopu/download/BaseDownloadClickHelper;, "Lcom/kaopu/download/BaseDownloadClickHelper<TT;>;"
    .local p1, "downloadInfo":Lcom/kaopu/download/kernel/BaseDownloadInfo;, "TT;"
    iput-object p1, p0, Lcom/kaopu/download/BaseDownloadClickHelper;->mDownloadInfo:Lcom/kaopu/download/kernel/BaseDownloadInfo;

    .line 88
    return-void
.end method
