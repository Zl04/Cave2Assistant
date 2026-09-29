.class public Lcom/cyjh/elfin/download/GameDownloadCallBackImpl;
.super Ljava/lang/Object;
.source "GameDownloadCallBackImpl.java"

# interfaces
.implements Lcom/kaopu/download/BaseDownloadWorker$DownloadCallBack;


# static fields
.field public static final CREATOR:Landroid/os/Parcelable$Creator;
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "Landroid/os/Parcelable$Creator",
            "<",
            "Lcom/cyjh/elfin/download/GameDownloadCallBackImpl;",
            ">;"
        }
    .end annotation
.end field


# instance fields
.field private mGameInfo:Lcom/cyjh/elfin/entity/GameInfo;


# direct methods
.method static constructor <clinit>()V
    .locals 1

    .prologue
    .line 94
    new-instance v0, Lcom/cyjh/elfin/download/GameDownloadCallBackImpl$1;

    invoke-direct {v0}, Lcom/cyjh/elfin/download/GameDownloadCallBackImpl$1;-><init>()V

    sput-object v0, Lcom/cyjh/elfin/download/GameDownloadCallBackImpl;->CREATOR:Landroid/os/Parcelable$Creator;

    return-void
.end method

.method public constructor <init>()V
    .locals 0

    .prologue
    .line 67
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    .line 69
    return-void
.end method

.method protected constructor <init>(Landroid/os/Parcel;)V
    .locals 1
    .param p1, "in"    # Landroid/os/Parcel;

    .prologue
    .line 90
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    .line 91
    const-class v0, Lcom/cyjh/elfin/entity/GameInfo;

    invoke-virtual {v0}, Ljava/lang/Class;->getClassLoader()Ljava/lang/ClassLoader;

    move-result-object v0

    invoke-virtual {p1, v0}, Landroid/os/Parcel;->readParcelable(Ljava/lang/ClassLoader;)Landroid/os/Parcelable;

    move-result-object v0

    check-cast v0, Lcom/cyjh/elfin/entity/GameInfo;

    iput-object v0, p0, Lcom/cyjh/elfin/download/GameDownloadCallBackImpl;->mGameInfo:Lcom/cyjh/elfin/entity/GameInfo;

    .line 92
    return-void
.end method

.method public constructor <init>(Lcom/cyjh/elfin/entity/GameInfo;)V
    .locals 0
    .param p1, "gameInfo"    # Lcom/cyjh/elfin/entity/GameInfo;

    .prologue
    .line 71
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    .line 72
    iput-object p1, p0, Lcom/cyjh/elfin/download/GameDownloadCallBackImpl;->mGameInfo:Lcom/cyjh/elfin/entity/GameInfo;

    .line 73
    return-void
.end method


# virtual methods
.method public describeContents()I
    .locals 1

    .prologue
    .line 82
    const/4 v0, 0x0

    return v0
.end method

.method public onDownloadCanceled(Ljava/lang/String;)V
    .locals 0
    .param p1, "url"    # Ljava/lang/String;

    .prologue
    .line 78
    return-void
.end method

.method public onDownloadCanceling(Ljava/lang/String;)V
    .locals 0
    .param p1, "url"    # Ljava/lang/String;

    .prologue
    .line 60
    return-void
.end method

.method public onDownloadCompleted(Ljava/lang/String;Ljava/lang/String;J)V
    .locals 2
    .param p1, "url"    # Ljava/lang/String;
    .param p2, "file"    # Ljava/lang/String;
    .param p3, "totalSize"    # J

    .prologue
    .line 42
    iget-object v0, p0, Lcom/cyjh/elfin/download/GameDownloadCallBackImpl;->mGameInfo:Lcom/cyjh/elfin/entity/GameInfo;

    iget-object v0, v0, Lcom/cyjh/elfin/entity/GameInfo;->Id:Ljava/lang/String;

    invoke-static {}, Lcom/cyjh/elfin/AppContext;->getInstance()Lcom/cyjh/elfin/AppContext;

    move-result-object v1

    invoke-static {v0, v1}, Lcom/cyjh/elfin/download/DownloadCountOpera;->requestDownloadCompleteCount(Ljava/lang/String;Landroid/content/Context;)V

    .line 43
    invoke-static {}, Lcom/cyjh/elfin/AppContext;->getInstance()Lcom/cyjh/elfin/AppContext;

    move-result-object v0

    invoke-static {v0, p2}, Lcom/cyjh/elfin/util/AppDeviceUtils;->installApplicationNormal(Landroid/content/Context;Ljava/lang/String;)Z

    .line 44
    return-void
.end method

.method public onDownloadFailed(Ljava/lang/String;)V
    .locals 0
    .param p1, "url"    # Ljava/lang/String;

    .prologue
    .line 65
    return-void
.end method

.method public onDownloadPaused(Ljava/lang/String;)V
    .locals 0
    .param p1, "url"    # Ljava/lang/String;

    .prologue
    .line 26
    return-void
.end method

.method public onDownloadPausing(Ljava/lang/String;)V
    .locals 0
    .param p1, "url"    # Ljava/lang/String;

    .prologue
    .line 56
    return-void
.end method

.method public onDownloadStart(Ljava/lang/String;J)V
    .locals 0
    .param p1, "url"    # Ljava/lang/String;
    .param p2, "downloadSize"    # J

    .prologue
    .line 48
    return-void
.end method

.method public onDownloadWait(Ljava/lang/String;)V
    .locals 0
    .param p1, "url"    # Ljava/lang/String;

    .prologue
    .line 52
    return-void
.end method

.method public onDownloadWorking(Ljava/lang/String;JJI)V
    .locals 0
    .param p1, "url"    # Ljava/lang/String;
    .param p2, "totalSize"    # J
    .param p4, "downloadSize"    # J
    .param p6, "progress"    # I

    .prologue
    .line 32
    return-void
.end method

.method public writeToParcel(Landroid/os/Parcel;I)V
    .locals 1
    .param p1, "dest"    # Landroid/os/Parcel;
    .param p2, "flags"    # I

    .prologue
    .line 87
    iget-object v0, p0, Lcom/cyjh/elfin/download/GameDownloadCallBackImpl;->mGameInfo:Lcom/cyjh/elfin/entity/GameInfo;

    invoke-virtual {p1, v0, p2}, Landroid/os/Parcel;->writeParcelable(Landroid/os/Parcelable;I)V

    .line 88
    return-void
.end method
