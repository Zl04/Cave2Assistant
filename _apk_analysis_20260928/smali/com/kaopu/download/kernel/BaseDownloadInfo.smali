.class public Lcom/kaopu/download/kernel/BaseDownloadInfo;
.super Ljava/lang/Object;
.source "BaseDownloadInfo.java"

# interfaces
.implements Landroid/os/Parcelable;


# static fields
.field public static final CREATOR:Landroid/os/Parcelable$Creator;
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "Landroid/os/Parcelable$Creator",
            "<",
            "Lcom/kaopu/download/kernel/BaseDownloadInfo;",
            ">;"
        }
    .end annotation
.end field


# instance fields
.field private createTime:J

.field private dSize:J

.field private downloadWorkerClassName:Ljava/lang/String;

.field private downloadedTime:J

.field private fSize:J

.field private identification:Ljava/lang/String;

.field private mCallBack:Lcom/kaopu/download/BaseDownloadWorker$DownloadCallBack;

.field private saveDir:Ljava/lang/String;

.field private saveName:Ljava/lang/String;

.field private speed:J

.field private state:Lcom/kaopu/download/intf/IDownloadState;

.field private url:Ljava/lang/String;


# direct methods
.method static constructor <clinit>()V
    .locals 1

    .prologue
    .line 198
    new-instance v0, Lcom/kaopu/download/kernel/BaseDownloadInfo$1;

    invoke-direct {v0}, Lcom/kaopu/download/kernel/BaseDownloadInfo$1;-><init>()V

    sput-object v0, Lcom/kaopu/download/kernel/BaseDownloadInfo;->CREATOR:Landroid/os/Parcelable$Creator;

    .line 211
    return-void
.end method

.method public constructor <init>()V
    .locals 2

    .prologue
    .line 46
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    .line 34
    new-instance v0, Lcom/kaopu/download/state/DownloadNewState;

    invoke-direct {v0}, Lcom/kaopu/download/state/DownloadNewState;-><init>()V

    iput-object v0, p0, Lcom/kaopu/download/kernel/BaseDownloadInfo;->state:Lcom/kaopu/download/intf/IDownloadState;

    .line 40
    const-wide/16 v0, 0x0

    iput-wide v0, p0, Lcom/kaopu/download/kernel/BaseDownloadInfo;->downloadedTime:J

    .line 48
    return-void
.end method

.method public constructor <init>(Landroid/os/Parcel;)V
    .locals 2
    .param p1, "p"    # Landroid/os/Parcel;

    .prologue
    .line 194
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    .line 34
    new-instance v0, Lcom/kaopu/download/state/DownloadNewState;

    invoke-direct {v0}, Lcom/kaopu/download/state/DownloadNewState;-><init>()V

    iput-object v0, p0, Lcom/kaopu/download/kernel/BaseDownloadInfo;->state:Lcom/kaopu/download/intf/IDownloadState;

    .line 40
    const-wide/16 v0, 0x0

    iput-wide v0, p0, Lcom/kaopu/download/kernel/BaseDownloadInfo;->downloadedTime:J

    .line 195
    invoke-virtual {p0, p1}, Lcom/kaopu/download/kernel/BaseDownloadInfo;->readFromParcel(Landroid/os/Parcel;)V

    .line 196
    return-void
.end method


# virtual methods
.method public describeContents()I
    .locals 1

    .prologue
    .line 175
    const/4 v0, 0x0

    return v0
.end method

.method public display(Lcom/kaopu/download/intf/IDownloadDisplayHelper;)V
    .locals 1
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
    .line 160
    .local p1, "helper":Lcom/kaopu/download/intf/IDownloadDisplayHelper;, "Lcom/kaopu/download/intf/IDownloadDisplayHelper<+Lcom/kaopu/download/kernel/BaseDownloadInfo;>;"
    iget-object v0, p0, Lcom/kaopu/download/kernel/BaseDownloadInfo;->state:Lcom/kaopu/download/intf/IDownloadState;

    invoke-interface {v0, p1}, Lcom/kaopu/download/intf/IDownloadState;->display(Lcom/kaopu/download/intf/IDownloadDisplayHelper;)V

    .line 161
    return-void
.end method

.method public equals(Ljava/lang/Object;)Z
    .locals 3
    .param p1, "o"    # Ljava/lang/Object;

    .prologue
    const/4 v1, 0x0

    .line 165
    if-nez p1, :cond_1

    .line 170
    :cond_0
    :goto_0
    return v1

    .line 167
    :cond_1
    instance-of v2, p1, Lcom/kaopu/download/kernel/BaseDownloadInfo;

    if-eqz v2, :cond_0

    move-object v0, p1

    .line 169
    check-cast v0, Lcom/kaopu/download/kernel/BaseDownloadInfo;

    .line 170
    .local v0, "other":Lcom/kaopu/download/kernel/BaseDownloadInfo;
    invoke-virtual {v0}, Lcom/kaopu/download/kernel/BaseDownloadInfo;->getIdentification()Ljava/lang/String;

    move-result-object v1

    invoke-virtual {p0}, Lcom/kaopu/download/kernel/BaseDownloadInfo;->getIdentification()Ljava/lang/String;

    move-result-object v2

    invoke-virtual {v1, v2}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v1

    goto :goto_0
.end method

.method public getCallBack()Lcom/kaopu/download/BaseDownloadWorker$DownloadCallBack;
    .locals 1

    .prologue
    .line 123
    iget-object v0, p0, Lcom/kaopu/download/kernel/BaseDownloadInfo;->mCallBack:Lcom/kaopu/download/BaseDownloadWorker$DownloadCallBack;

    return-object v0
.end method

.method public getCreateTime()J
    .locals 2

    .prologue
    .line 51
    iget-wide v0, p0, Lcom/kaopu/download/kernel/BaseDownloadInfo;->createTime:J

    return-wide v0
.end method

.method public getDownloadWorkerClassName()Ljava/lang/String;
    .locals 1

    .prologue
    .line 131
    iget-object v0, p0, Lcom/kaopu/download/kernel/BaseDownloadInfo;->downloadWorkerClassName:Ljava/lang/String;

    return-object v0
.end method

.method public getDownloadedTime()J
    .locals 2

    .prologue
    .line 99
    iget-wide v0, p0, Lcom/kaopu/download/kernel/BaseDownloadInfo;->downloadedTime:J

    return-wide v0
.end method

.method public getIdentification()Ljava/lang/String;
    .locals 1

    .prologue
    .line 143
    iget-object v0, p0, Lcom/kaopu/download/kernel/BaseDownloadInfo;->identification:Ljava/lang/String;

    return-object v0
.end method

.method public getSaveDir()Ljava/lang/String;
    .locals 1

    .prologue
    .line 115
    iget-object v0, p0, Lcom/kaopu/download/kernel/BaseDownloadInfo;->saveDir:Ljava/lang/String;

    return-object v0
.end method

.method public getSaveName()Ljava/lang/String;
    .locals 1

    .prologue
    .line 107
    iget-object v0, p0, Lcom/kaopu/download/kernel/BaseDownloadInfo;->saveName:Ljava/lang/String;

    return-object v0
.end method

.method public getSpeed()J
    .locals 2

    .prologue
    .line 91
    iget-wide v0, p0, Lcom/kaopu/download/kernel/BaseDownloadInfo;->speed:J

    return-wide v0
.end method

.method public getState()Lcom/kaopu/download/intf/IDownloadState;
    .locals 1

    .prologue
    .line 83
    iget-object v0, p0, Lcom/kaopu/download/kernel/BaseDownloadInfo;->state:Lcom/kaopu/download/intf/IDownloadState;

    return-object v0
.end method

.method public getUrl()Ljava/lang/String;
    .locals 1

    .prologue
    .line 59
    iget-object v0, p0, Lcom/kaopu/download/kernel/BaseDownloadInfo;->url:Ljava/lang/String;

    return-object v0
.end method

.method public getdSize()J
    .locals 2

    .prologue
    .line 75
    iget-wide v0, p0, Lcom/kaopu/download/kernel/BaseDownloadInfo;->dSize:J

    return-wide v0
.end method

.method public getfSize()J
    .locals 2

    .prologue
    .line 67
    iget-wide v0, p0, Lcom/kaopu/download/kernel/BaseDownloadInfo;->fSize:J

    return-wide v0
.end method

.method public onClick(Lcom/kaopu/download/intf/IDownloadClickHelper;)V
    .locals 1
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
    .line 156
    .local p1, "helper":Lcom/kaopu/download/intf/IDownloadClickHelper;, "Lcom/kaopu/download/intf/IDownloadClickHelper<+Lcom/kaopu/download/kernel/BaseDownloadInfo;>;"
    iget-object v0, p0, Lcom/kaopu/download/kernel/BaseDownloadInfo;->state:Lcom/kaopu/download/intf/IDownloadState;

    invoke-interface {v0, p1}, Lcom/kaopu/download/intf/IDownloadState;->onClick(Lcom/kaopu/download/intf/IDownloadClickHelper;)V

    .line 157
    return-void
.end method

.method public readFromParcel(Landroid/os/Parcel;)V
    .locals 2
    .param p1, "p"    # Landroid/os/Parcel;

    .prologue
    .line 214
    invoke-virtual {p1}, Landroid/os/Parcel;->readString()Ljava/lang/String;

    move-result-object v0

    invoke-virtual {p0, v0}, Lcom/kaopu/download/kernel/BaseDownloadInfo;->setUrl(Ljava/lang/String;)V

    .line 215
    invoke-virtual {p1}, Landroid/os/Parcel;->readLong()J

    move-result-wide v0

    invoke-virtual {p0, v0, v1}, Lcom/kaopu/download/kernel/BaseDownloadInfo;->setfSize(J)V

    .line 216
    invoke-virtual {p1}, Landroid/os/Parcel;->readLong()J

    move-result-wide v0

    invoke-virtual {p0, v0, v1}, Lcom/kaopu/download/kernel/BaseDownloadInfo;->setdSize(J)V

    .line 217
    const-class v0, Lcom/kaopu/download/intf/IDownloadState;

    invoke-virtual {v0}, Ljava/lang/Class;->getClassLoader()Ljava/lang/ClassLoader;

    move-result-object v0

    invoke-virtual {p1, v0}, Landroid/os/Parcel;->readParcelable(Ljava/lang/ClassLoader;)Landroid/os/Parcelable;

    move-result-object v0

    check-cast v0, Lcom/kaopu/download/intf/IDownloadState;

    invoke-virtual {p0, v0}, Lcom/kaopu/download/kernel/BaseDownloadInfo;->setState(Lcom/kaopu/download/intf/IDownloadState;)V

    .line 218
    invoke-virtual {p1}, Landroid/os/Parcel;->readLong()J

    move-result-wide v0

    invoke-virtual {p0, v0, v1}, Lcom/kaopu/download/kernel/BaseDownloadInfo;->setSpeed(J)V

    .line 219
    invoke-virtual {p1}, Landroid/os/Parcel;->readLong()J

    move-result-wide v0

    invoke-virtual {p0, v0, v1}, Lcom/kaopu/download/kernel/BaseDownloadInfo;->setCreateTime(J)V

    .line 220
    invoke-virtual {p1}, Landroid/os/Parcel;->readLong()J

    move-result-wide v0

    invoke-virtual {p0, v0, v1}, Lcom/kaopu/download/kernel/BaseDownloadInfo;->setDownloadedTime(J)V

    .line 221
    invoke-virtual {p1}, Landroid/os/Parcel;->readString()Ljava/lang/String;

    move-result-object v0

    invoke-virtual {p0, v0}, Lcom/kaopu/download/kernel/BaseDownloadInfo;->setSaveDir(Ljava/lang/String;)V

    .line 222
    invoke-virtual {p1}, Landroid/os/Parcel;->readString()Ljava/lang/String;

    move-result-object v0

    invoke-virtual {p0, v0}, Lcom/kaopu/download/kernel/BaseDownloadInfo;->setSaveName(Ljava/lang/String;)V

    .line 223
    const-class v0, Lcom/kaopu/download/BaseDownloadWorker$DownloadCallBack;

    invoke-virtual {v0}, Ljava/lang/Class;->getClassLoader()Ljava/lang/ClassLoader;

    move-result-object v0

    invoke-virtual {p1, v0}, Landroid/os/Parcel;->readParcelable(Ljava/lang/ClassLoader;)Landroid/os/Parcelable;

    move-result-object v0

    check-cast v0, Lcom/kaopu/download/BaseDownloadWorker$DownloadCallBack;

    invoke-virtual {p0, v0}, Lcom/kaopu/download/kernel/BaseDownloadInfo;->setCallBack(Lcom/kaopu/download/BaseDownloadWorker$DownloadCallBack;)V

    .line 224
    invoke-virtual {p1}, Landroid/os/Parcel;->readString()Ljava/lang/String;

    move-result-object v0

    invoke-virtual {p0, v0}, Lcom/kaopu/download/kernel/BaseDownloadInfo;->setDownloadWorkerClassName(Ljava/lang/String;)V

    .line 225
    invoke-virtual {p1}, Landroid/os/Parcel;->readString()Ljava/lang/String;

    move-result-object v0

    invoke-virtual {p0, v0}, Lcom/kaopu/download/kernel/BaseDownloadInfo;->setIdentification(Ljava/lang/String;)V

    .line 226
    return-void
.end method

.method public setCallBack(Lcom/kaopu/download/BaseDownloadWorker$DownloadCallBack;)V
    .locals 0

    .prologue
    .line 127
    .local p1, "callBack":Lcom/kaopu/download/BaseDownloadWorker$DownloadCallBack;, "Lcom/kaopu/download/BaseDownloadWorker$DownloadCallBack;"
    iput-object p1, p0, Lcom/kaopu/download/kernel/BaseDownloadInfo;->mCallBack:Lcom/kaopu/download/BaseDownloadWorker$DownloadCallBack;

    .line 128
    return-void
.end method

.method public setCreateTime(J)V
    .locals 1
    .param p1, "createTime"    # J

    .prologue
    .line 55
    iput-wide p1, p0, Lcom/kaopu/download/kernel/BaseDownloadInfo;->createTime:J

    .line 56
    return-void
.end method

.method public setDownloadWorkerClassName(Ljava/lang/Class;)V
    .locals 1
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "(",
            "Ljava/lang/Class",
            "<+",
            "Lcom/kaopu/download/abst/ADownloadWorker",
            "<+",
            "Lcom/kaopu/download/kernel/BaseDownloadInfo;",
            ">;>;)V"
        }
    .end annotation

    .prologue
    .line 139
    .local p1, "clazz":Ljava/lang/Class;, "Ljava/lang/Class<+Lcom/kaopu/download/abst/ADownloadWorker<+Lcom/kaopu/download/kernel/BaseDownloadInfo;>;>;"
    invoke-virtual {p1}, Ljava/lang/Class;->getName()Ljava/lang/String;

    move-result-object v0

    iput-object v0, p0, Lcom/kaopu/download/kernel/BaseDownloadInfo;->downloadWorkerClassName:Ljava/lang/String;

    .line 140
    return-void
.end method

.method public setDownloadWorkerClassName(Ljava/lang/String;)V
    .locals 0
    .param p1, "downloadWorkerClassName"    # Ljava/lang/String;

    .prologue
    .line 135
    iput-object p1, p0, Lcom/kaopu/download/kernel/BaseDownloadInfo;->downloadWorkerClassName:Ljava/lang/String;

    .line 136
    return-void
.end method

.method public setDownloadedTime(J)V
    .locals 1
    .param p1, "downloadedTime"    # J

    .prologue
    .line 103
    iput-wide p1, p0, Lcom/kaopu/download/kernel/BaseDownloadInfo;->downloadedTime:J

    .line 104
    return-void
.end method

.method public setIdentification(Ljava/lang/String;)V
    .locals 0
    .param p1, "identification"    # Ljava/lang/String;

    .prologue
    .line 147
    iput-object p1, p0, Lcom/kaopu/download/kernel/BaseDownloadInfo;->identification:Ljava/lang/String;

    .line 148
    return-void
.end method

.method public setSaveDir(Ljava/lang/String;)V
    .locals 0
    .param p1, "saveDir"    # Ljava/lang/String;

    .prologue
    .line 119
    iput-object p1, p0, Lcom/kaopu/download/kernel/BaseDownloadInfo;->saveDir:Ljava/lang/String;

    .line 120
    return-void
.end method

.method public setSaveName(Ljava/lang/String;)V
    .locals 0
    .param p1, "saveName"    # Ljava/lang/String;

    .prologue
    .line 111
    iput-object p1, p0, Lcom/kaopu/download/kernel/BaseDownloadInfo;->saveName:Ljava/lang/String;

    .line 112
    return-void
.end method

.method public setSpeed(J)V
    .locals 1
    .param p1, "speed"    # J

    .prologue
    .line 95
    iput-wide p1, p0, Lcom/kaopu/download/kernel/BaseDownloadInfo;->speed:J

    .line 96
    return-void
.end method

.method public setState(Lcom/kaopu/download/intf/IDownloadState;)V
    .locals 0
    .param p1, "state"    # Lcom/kaopu/download/intf/IDownloadState;

    .prologue
    .line 87
    iput-object p1, p0, Lcom/kaopu/download/kernel/BaseDownloadInfo;->state:Lcom/kaopu/download/intf/IDownloadState;

    .line 88
    return-void
.end method

.method public setUrl(Ljava/lang/String;)V
    .locals 0
    .param p1, "url"    # Ljava/lang/String;

    .prologue
    .line 63
    iput-object p1, p0, Lcom/kaopu/download/kernel/BaseDownloadInfo;->url:Ljava/lang/String;

    .line 64
    return-void
.end method

.method public setdSize(J)V
    .locals 1
    .param p1, "dSize"    # J

    .prologue
    .line 79
    iput-wide p1, p0, Lcom/kaopu/download/kernel/BaseDownloadInfo;->dSize:J

    .line 80
    return-void
.end method

.method public setfSize(J)V
    .locals 1
    .param p1, "fSize"    # J

    .prologue
    .line 71
    iput-wide p1, p0, Lcom/kaopu/download/kernel/BaseDownloadInfo;->fSize:J

    .line 72
    return-void
.end method

.method public writeToParcel(Landroid/os/Parcel;I)V
    .locals 3
    .param p1, "dest"    # Landroid/os/Parcel;
    .param p2, "flags"    # I

    .prologue
    const/4 v2, 0x0

    .line 180
    iget-object v0, p0, Lcom/kaopu/download/kernel/BaseDownloadInfo;->url:Ljava/lang/String;

    invoke-virtual {p1, v0}, Landroid/os/Parcel;->writeString(Ljava/lang/String;)V

    .line 181
    iget-wide v0, p0, Lcom/kaopu/download/kernel/BaseDownloadInfo;->fSize:J

    invoke-virtual {p1, v0, v1}, Landroid/os/Parcel;->writeLong(J)V

    .line 182
    iget-wide v0, p0, Lcom/kaopu/download/kernel/BaseDownloadInfo;->dSize:J

    invoke-virtual {p1, v0, v1}, Landroid/os/Parcel;->writeLong(J)V

    .line 183
    iget-object v0, p0, Lcom/kaopu/download/kernel/BaseDownloadInfo;->state:Lcom/kaopu/download/intf/IDownloadState;

    invoke-virtual {p1, v0, v2}, Landroid/os/Parcel;->writeParcelable(Landroid/os/Parcelable;I)V

    .line 184
    iget-wide v0, p0, Lcom/kaopu/download/kernel/BaseDownloadInfo;->speed:J

    invoke-virtual {p1, v0, v1}, Landroid/os/Parcel;->writeLong(J)V

    .line 185
    iget-wide v0, p0, Lcom/kaopu/download/kernel/BaseDownloadInfo;->createTime:J

    invoke-virtual {p1, v0, v1}, Landroid/os/Parcel;->writeLong(J)V

    .line 186
    iget-wide v0, p0, Lcom/kaopu/download/kernel/BaseDownloadInfo;->downloadedTime:J

    invoke-virtual {p1, v0, v1}, Landroid/os/Parcel;->writeLong(J)V

    .line 187
    iget-object v0, p0, Lcom/kaopu/download/kernel/BaseDownloadInfo;->saveDir:Ljava/lang/String;

    invoke-virtual {p1, v0}, Landroid/os/Parcel;->writeString(Ljava/lang/String;)V

    .line 188
    iget-object v0, p0, Lcom/kaopu/download/kernel/BaseDownloadInfo;->saveName:Ljava/lang/String;

    invoke-virtual {p1, v0}, Landroid/os/Parcel;->writeString(Ljava/lang/String;)V

    .line 189
    iget-object v0, p0, Lcom/kaopu/download/kernel/BaseDownloadInfo;->mCallBack:Lcom/kaopu/download/BaseDownloadWorker$DownloadCallBack;

    invoke-virtual {p1, v0, v2}, Landroid/os/Parcel;->writeParcelable(Landroid/os/Parcelable;I)V

    .line 190
    iget-object v0, p0, Lcom/kaopu/download/kernel/BaseDownloadInfo;->downloadWorkerClassName:Ljava/lang/String;

    invoke-virtual {p1, v0}, Landroid/os/Parcel;->writeString(Ljava/lang/String;)V

    .line 191
    iget-object v0, p0, Lcom/kaopu/download/kernel/BaseDownloadInfo;->identification:Ljava/lang/String;

    invoke-virtual {p1, v0}, Landroid/os/Parcel;->writeString(Ljava/lang/String;)V

    .line 192
    return-void
.end method
