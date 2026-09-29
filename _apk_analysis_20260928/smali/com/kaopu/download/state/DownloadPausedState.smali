.class public Lcom/kaopu/download/state/DownloadPausedState;
.super Ljava/lang/Object;
.source "DownloadPausedState.java"

# interfaces
.implements Lcom/kaopu/download/intf/IDownloadState;


# static fields
.field public static final CREATOR:Landroid/os/Parcelable$Creator;
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "Landroid/os/Parcelable$Creator",
            "<",
            "Lcom/kaopu/download/state/DownloadPausedState;",
            ">;"
        }
    .end annotation
.end field


# direct methods
.method static constructor <clinit>()V
    .locals 1

    .prologue
    .line 54
    new-instance v0, Lcom/kaopu/download/state/DownloadPausedState$1;

    invoke-direct {v0}, Lcom/kaopu/download/state/DownloadPausedState$1;-><init>()V

    sput-object v0, Lcom/kaopu/download/state/DownloadPausedState;->CREATOR:Landroid/os/Parcelable$Creator;

    .line 65
    return-void
.end method

.method public constructor <init>()V
    .locals 0

    .prologue
    .line 46
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    .line 48
    return-void
.end method

.method public constructor <init>(Landroid/os/Parcel;)V
    .locals 0
    .param p1, "p"    # Landroid/os/Parcel;

    .prologue
    .line 50
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    .line 52
    return-void
.end method


# virtual methods
.method public describeContents()I
    .locals 1

    .prologue
    .line 38
    const/4 v0, 0x0

    return v0
.end method

.method public display(Lcom/kaopu/download/intf/IDownloadDisplayHelper;)V
    .locals 0
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "(",
            "Lcom/kaopu/download/intf/IDownloadDisplayHelper",
            "<+",
            "Lcom/kaopu/download/kernel/BaseDownloadInfo;",
            ">;)V"
        }
    .end annotation

    .prologue
    .line 33
    .local p1, "helper":Lcom/kaopu/download/intf/IDownloadDisplayHelper;, "Lcom/kaopu/download/intf/IDownloadDisplayHelper<+Lcom/kaopu/download/kernel/BaseDownloadInfo;>;"
    invoke-interface {p1}, Lcom/kaopu/download/intf/IDownloadDisplayHelper;->onDownloadPausedDisplay()V

    .line 34
    return-void
.end method

.method public getState()Lcom/kaopu/download/BaseDownloadStateFactory$State;
    .locals 1

    .prologue
    .line 22
    sget-object v0, Lcom/kaopu/download/BaseDownloadStateFactory$State;->DOWNLOAD_PAUSED:Lcom/kaopu/download/BaseDownloadStateFactory$State;

    return-object v0
.end method

.method public onClick(Lcom/kaopu/download/intf/IDownloadClickHelper;)V
    .locals 0
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "(",
            "Lcom/kaopu/download/intf/IDownloadClickHelper",
            "<+",
            "Lcom/kaopu/download/kernel/BaseDownloadInfo;",
            ">;)V"
        }
    .end annotation

    .prologue
    .line 27
    .local p1, "helper":Lcom/kaopu/download/intf/IDownloadClickHelper;, "Lcom/kaopu/download/intf/IDownloadClickHelper<+Lcom/kaopu/download/kernel/BaseDownloadInfo;>;"
    invoke-interface {p1}, Lcom/kaopu/download/intf/IDownloadClickHelper;->onDownloadPausedClick()V

    .line 29
    return-void
.end method

.method public writeToParcel(Landroid/os/Parcel;I)V
    .locals 0
    .param p1, "dest"    # Landroid/os/Parcel;
    .param p2, "flags"    # I

    .prologue
    .line 44
    return-void
.end method
