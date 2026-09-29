.class Lcom/kaopu/download/state/DownloadWaitState$1;
.super Ljava/lang/Object;
.source "DownloadWaitState.java"

# interfaces
.implements Landroid/os/Parcelable$Creator;


# annotations
.annotation system Ldalvik/annotation/EnclosingClass;
    value = Lcom/kaopu/download/state/DownloadWaitState;
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x0
    name = null
.end annotation

.annotation system Ldalvik/annotation/Signature;
    value = {
        "Ljava/lang/Object;",
        "Landroid/os/Parcelable$Creator",
        "<",
        "Lcom/kaopu/download/state/DownloadWaitState;",
        ">;"
    }
.end annotation


# direct methods
.method constructor <init>()V
    .locals 0

    .prologue
    .line 53
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    .line 1
    return-void
.end method


# virtual methods
.method public createFromParcel(Landroid/os/Parcel;)Lcom/kaopu/download/state/DownloadWaitState;
    .locals 1
    .param p1, "source"    # Landroid/os/Parcel;

    .prologue
    .line 62
    new-instance v0, Lcom/kaopu/download/state/DownloadWaitState;

    invoke-direct {v0, p1}, Lcom/kaopu/download/state/DownloadWaitState;-><init>(Landroid/os/Parcel;)V

    return-object v0
.end method

.method public bridge synthetic createFromParcel(Landroid/os/Parcel;)Ljava/lang/Object;
    .locals 1

    .prologue
    .line 1
    invoke-virtual {p0, p1}, Lcom/kaopu/download/state/DownloadWaitState$1;->createFromParcel(Landroid/os/Parcel;)Lcom/kaopu/download/state/DownloadWaitState;

    move-result-object v0

    return-object v0
.end method

.method public newArray(I)[Lcom/kaopu/download/state/DownloadWaitState;
    .locals 1
    .param p1, "size"    # I

    .prologue
    .line 57
    new-array v0, p1, [Lcom/kaopu/download/state/DownloadWaitState;

    return-object v0
.end method

.method public bridge synthetic newArray(I)[Ljava/lang/Object;
    .locals 1

    .prologue
    .line 1
    invoke-virtual {p0, p1}, Lcom/kaopu/download/state/DownloadWaitState$1;->newArray(I)[Lcom/kaopu/download/state/DownloadWaitState;

    move-result-object v0

    return-object v0
.end method
