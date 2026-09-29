.class public Lcom/cyjh/feedback/lib/entities/FolderBean;
.super Ljava/lang/Object;
.source "FolderBean.java"


# instance fields
.field private dirCount:I

.field private dirName:Ljava/lang/String;

.field private dirPath:Ljava/lang/String;

.field private firstImgPath:Ljava/lang/String;

.field private isSelect:Z


# direct methods
.method public constructor <init>()V
    .locals 0

    .prologue
    .line 10
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method


# virtual methods
.method public getDirCount()I
    .locals 1

    .prologue
    .line 56
    iget v0, p0, Lcom/cyjh/feedback/lib/entities/FolderBean;->dirCount:I

    return v0
.end method

.method public getDirName()Ljava/lang/String;
    .locals 1

    .prologue
    .line 72
    iget-object v0, p0, Lcom/cyjh/feedback/lib/entities/FolderBean;->dirName:Ljava/lang/String;

    return-object v0
.end method

.method public getDirPath()Ljava/lang/String;
    .locals 1

    .prologue
    .line 35
    iget-object v0, p0, Lcom/cyjh/feedback/lib/entities/FolderBean;->dirPath:Ljava/lang/String;

    return-object v0
.end method

.method public getFirstImgPath()Ljava/lang/String;
    .locals 1

    .prologue
    .line 64
    iget-object v0, p0, Lcom/cyjh/feedback/lib/entities/FolderBean;->firstImgPath:Ljava/lang/String;

    return-object v0
.end method

.method public isSelect()Z
    .locals 1

    .prologue
    .line 48
    iget-boolean v0, p0, Lcom/cyjh/feedback/lib/entities/FolderBean;->isSelect:Z

    return v0
.end method

.method public setDirCount(I)V
    .locals 0
    .param p1, "dirCount"    # I

    .prologue
    .line 60
    iput p1, p0, Lcom/cyjh/feedback/lib/entities/FolderBean;->dirCount:I

    .line 61
    return-void
.end method

.method public setDirName(Ljava/lang/String;)V
    .locals 0
    .param p1, "dirName"    # Ljava/lang/String;

    .prologue
    .line 76
    iput-object p1, p0, Lcom/cyjh/feedback/lib/entities/FolderBean;->dirName:Ljava/lang/String;

    .line 77
    return-void
.end method

.method public setDirPath(Ljava/lang/String;)V
    .locals 2
    .param p1, "dirPath"    # Ljava/lang/String;

    .prologue
    .line 39
    iput-object p1, p0, Lcom/cyjh/feedback/lib/entities/FolderBean;->dirPath:Ljava/lang/String;

    .line 40
    iget-object v1, p0, Lcom/cyjh/feedback/lib/entities/FolderBean;->dirName:Ljava/lang/String;

    invoke-static {v1}, Landroid/text/TextUtils;->isEmpty(Ljava/lang/CharSequence;)Z

    move-result v1

    if-eqz v1, :cond_0

    .line 41
    const-string v1, "/"

    invoke-virtual {p1, v1}, Ljava/lang/String;->lastIndexOf(Ljava/lang/String;)I

    move-result v1

    add-int/lit8 v0, v1, 0x1

    .line 42
    .local v0, "lastIndex":I
    invoke-virtual {p1, v0}, Ljava/lang/String;->substring(I)Ljava/lang/String;

    move-result-object v1

    iput-object v1, p0, Lcom/cyjh/feedback/lib/entities/FolderBean;->dirName:Ljava/lang/String;

    .line 45
    .end local v0    # "lastIndex":I
    :cond_0
    return-void
.end method

.method public setFirstImgPath(Ljava/lang/String;)V
    .locals 0
    .param p1, "firstImgPath"    # Ljava/lang/String;

    .prologue
    .line 68
    iput-object p1, p0, Lcom/cyjh/feedback/lib/entities/FolderBean;->firstImgPath:Ljava/lang/String;

    .line 69
    return-void
.end method

.method public setIsSelect(Z)V
    .locals 0
    .param p1, "isSelect"    # Z

    .prologue
    .line 52
    iput-boolean p1, p0, Lcom/cyjh/feedback/lib/entities/FolderBean;->isSelect:Z

    .line 53
    return-void
.end method

.method public toString()Ljava/lang/String;
    .locals 3

    .prologue
    const/16 v2, 0x27

    .line 81
    new-instance v0, Ljava/lang/StringBuilder;

    invoke-direct {v0}, Ljava/lang/StringBuilder;-><init>()V

    const-string v1, "FolderBean{dirPath=\'"

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    iget-object v1, p0, Lcom/cyjh/feedback/lib/entities/FolderBean;->dirPath:Ljava/lang/String;

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-virtual {v0, v2}, Ljava/lang/StringBuilder;->append(C)Ljava/lang/StringBuilder;

    move-result-object v0

    const-string v1, ", dirName=\'"

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    iget-object v1, p0, Lcom/cyjh/feedback/lib/entities/FolderBean;->dirName:Ljava/lang/String;

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-virtual {v0, v2}, Ljava/lang/StringBuilder;->append(C)Ljava/lang/StringBuilder;

    move-result-object v0

    const-string v1, ", firstImgPath=\'"

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    iget-object v1, p0, Lcom/cyjh/feedback/lib/entities/FolderBean;->firstImgPath:Ljava/lang/String;

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-virtual {v0, v2}, Ljava/lang/StringBuilder;->append(C)Ljava/lang/StringBuilder;

    move-result-object v0

    const-string v1, ", dirCount="

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    iget v1, p0, Lcom/cyjh/feedback/lib/entities/FolderBean;->dirCount:I

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v0

    const-string v1, ", isSelect="

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    iget-boolean v1, p0, Lcom/cyjh/feedback/lib/entities/FolderBean;->isSelect:Z

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Z)Ljava/lang/StringBuilder;

    move-result-object v0

    const/16 v1, 0x7d

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(C)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-virtual {v0}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v0

    return-object v0
.end method
