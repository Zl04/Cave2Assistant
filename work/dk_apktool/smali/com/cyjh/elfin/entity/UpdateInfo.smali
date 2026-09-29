.class public Lcom/cyjh/elfin/entity/UpdateInfo;
.super Ljava/lang/Object;
.source "UpdateInfo.java"


# static fields
.field public static final APPID:Ljava/lang/String; = "AppId"

.field public static final DOWNLOAD_PATH:Ljava/lang/String; = "DownLoadPath"

.field public static final PACKAGENAME:Ljava/lang/String; = "PackageName"

.field public static final UPDATETYPE_FORCE:I = 0x0

.field public static final UPDATETYPE_OPTIONAL:I = 0x1

.field public static final UPDATE_NOTICE:Ljava/lang/String; = "UpdateNotice"

.field public static final UPDATE_TYPE:Ljava/lang/String; = "UpdateType"

.field public static final VERSION:Ljava/lang/String; = "Version"


# instance fields
.field private DownLoadPath:Ljava/lang/String;

.field private FileSize:Ljava/lang/String;

.field private UpdateNotice:Ljava/lang/String;

.field private UpdateType:I

.field private isDismissing:Z

.field public mContext:Landroid/content/Context;


# direct methods
.method public constructor <init>()V
    .locals 1

    .prologue
    .line 5
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    .line 24
    const/4 v0, 0x0

    iput-boolean v0, p0, Lcom/cyjh/elfin/entity/UpdateInfo;->isDismissing:Z

    return-void
.end method


# virtual methods
.method public getDownLoadPath()Ljava/lang/String;
    .locals 1

    .prologue
    .line 45
    iget-object v0, p0, Lcom/cyjh/elfin/entity/UpdateInfo;->DownLoadPath:Ljava/lang/String;

    return-object v0
.end method

.method public getFileSize()Ljava/lang/String;
    .locals 1

    .prologue
    .line 53
    iget-object v0, p0, Lcom/cyjh/elfin/entity/UpdateInfo;->FileSize:Ljava/lang/String;

    return-object v0
.end method

.method public getIsDismissing()Z
    .locals 1

    .prologue
    .line 66
    iget-boolean v0, p0, Lcom/cyjh/elfin/entity/UpdateInfo;->isDismissing:Z

    return v0
.end method

.method public getUpdateNotice()Ljava/lang/String;
    .locals 1

    .prologue
    .line 29
    iget-object v0, p0, Lcom/cyjh/elfin/entity/UpdateInfo;->UpdateNotice:Ljava/lang/String;

    return-object v0
.end method

.method public getUpdateType()I
    .locals 1

    .prologue
    .line 37
    iget v0, p0, Lcom/cyjh/elfin/entity/UpdateInfo;->UpdateType:I

    return v0
.end method

.method public setDismissing(Z)V
    .locals 0
    .param p1, "dismissing"    # Z

    .prologue
    .line 62
    iput-boolean p1, p0, Lcom/cyjh/elfin/entity/UpdateInfo;->isDismissing:Z

    .line 63
    return-void
.end method

.method public setDownLoadPath(Ljava/lang/String;)V
    .locals 0
    .param p1, "downLoadPath"    # Ljava/lang/String;

    .prologue
    .line 49
    iput-object p1, p0, Lcom/cyjh/elfin/entity/UpdateInfo;->DownLoadPath:Ljava/lang/String;

    .line 50
    return-void
.end method

.method public setFileSize(Ljava/lang/String;)V
    .locals 0
    .param p1, "fileSize"    # Ljava/lang/String;

    .prologue
    .line 57
    iput-object p1, p0, Lcom/cyjh/elfin/entity/UpdateInfo;->FileSize:Ljava/lang/String;

    .line 58
    return-void
.end method

.method public setUpdateNotice(Ljava/lang/String;)V
    .locals 0
    .param p1, "updateNotice"    # Ljava/lang/String;

    .prologue
    .line 33
    iput-object p1, p0, Lcom/cyjh/elfin/entity/UpdateInfo;->UpdateNotice:Ljava/lang/String;

    .line 34
    return-void
.end method

.method public setUpdateType(I)V
    .locals 0
    .param p1, "updateType"    # I

    .prologue
    .line 41
    iput p1, p0, Lcom/cyjh/elfin/entity/UpdateInfo;->UpdateType:I

    .line 42
    return-void
.end method
