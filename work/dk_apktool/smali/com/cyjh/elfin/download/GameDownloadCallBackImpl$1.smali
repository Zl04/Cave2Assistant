.class final Lcom/cyjh/elfin/download/GameDownloadCallBackImpl$1;
.super Ljava/lang/Object;
.source "GameDownloadCallBackImpl.java"

# interfaces
.implements Landroid/os/Parcelable$Creator;


# annotations
.annotation system Ldalvik/annotation/EnclosingClass;
    value = Lcom/cyjh/elfin/download/GameDownloadCallBackImpl;
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x8
    name = null
.end annotation

.annotation system Ldalvik/annotation/Signature;
    value = {
        "Ljava/lang/Object;",
        "Landroid/os/Parcelable$Creator",
        "<",
        "Lcom/cyjh/elfin/download/GameDownloadCallBackImpl;",
        ">;"
    }
.end annotation


# direct methods
.method constructor <init>()V
    .locals 0

    .prologue
    .line 94
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method


# virtual methods
.method public createFromParcel(Landroid/os/Parcel;)Lcom/cyjh/elfin/download/GameDownloadCallBackImpl;
    .locals 1
    .param p1, "source"    # Landroid/os/Parcel;

    .prologue
    .line 97
    new-instance v0, Lcom/cyjh/elfin/download/GameDownloadCallBackImpl;

    invoke-direct {v0, p1}, Lcom/cyjh/elfin/download/GameDownloadCallBackImpl;-><init>(Landroid/os/Parcel;)V

    return-object v0
.end method

.method public bridge synthetic createFromParcel(Landroid/os/Parcel;)Ljava/lang/Object;
    .locals 1

    .prologue
    .line 94
    invoke-virtual {p0, p1}, Lcom/cyjh/elfin/download/GameDownloadCallBackImpl$1;->createFromParcel(Landroid/os/Parcel;)Lcom/cyjh/elfin/download/GameDownloadCallBackImpl;

    move-result-object v0

    return-object v0
.end method

.method public newArray(I)[Lcom/cyjh/elfin/download/GameDownloadCallBackImpl;
    .locals 1
    .param p1, "size"    # I

    .prologue
    .line 102
    new-array v0, p1, [Lcom/cyjh/elfin/download/GameDownloadCallBackImpl;

    return-object v0
.end method

.method public bridge synthetic newArray(I)[Ljava/lang/Object;
    .locals 1

    .prologue
    .line 94
    invoke-virtual {p0, p1}, Lcom/cyjh/elfin/download/GameDownloadCallBackImpl$1;->newArray(I)[Lcom/cyjh/elfin/download/GameDownloadCallBackImpl;

    move-result-object v0

    return-object v0
.end method
