.class public Lcom/cyjh/elfin/entity/Script;
.super Ljava/lang/Object;
.source "Script.java"


# static fields
.field public static final SCRIPT_STATE_FREE:I = 0x0

.field public static final SCRIPT_STATE_LOAD:I = 0x1

.field public static final SCRIPT_STATE_RUNING:I = 0x2


# instance fields
.field private atcFile:Ljava/io/File;

.field private bestResolution:Lcom/cyjh/elfin/entity/BestResolution;

.field private cfgFile:Ljava/io/File;

.field private changeFileList:I

.field private description:Ljava/lang/String;

.field private fileVersion:Lcom/cyjh/elfin/entity/FileVersion;

.field private id:Ljava/lang/String;

.field private lcFile:Ljava/io/File;

.field private name:Ljava/lang/String;

.field private propFile:Ljava/io/File;

.field private rtdFile:Ljava/io/File;

.field private size:Ljava/lang/String;

.field private uiFile:Ljava/io/File;

.field private uipFile:Ljava/io/File;


# direct methods
.method public constructor <init>()V
    .locals 0

    .prologue
    .line 29
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    .line 30
    return-void
.end method


# virtual methods
.method public getAtcFile()Ljava/io/File;
    .locals 1

    .prologue
    .line 89
    iget-object v0, p0, Lcom/cyjh/elfin/entity/Script;->atcFile:Ljava/io/File;

    return-object v0
.end method

.method public getBestResolution()Lcom/cyjh/elfin/entity/BestResolution;
    .locals 1

    .prologue
    .line 137
    iget-object v0, p0, Lcom/cyjh/elfin/entity/Script;->bestResolution:Lcom/cyjh/elfin/entity/BestResolution;

    return-object v0
.end method

.method public getCfgFile()Ljava/io/File;
    .locals 1

    .prologue
    .line 125
    iget-object v0, p0, Lcom/cyjh/elfin/entity/Script;->cfgFile:Ljava/io/File;

    return-object v0
.end method

.method public getChangeFileList()I
    .locals 1

    .prologue
    .line 33
    iget v0, p0, Lcom/cyjh/elfin/entity/Script;->changeFileList:I

    return v0
.end method

.method public getDescription()Ljava/lang/String;
    .locals 1

    .prologue
    .line 57
    iget-object v0, p0, Lcom/cyjh/elfin/entity/Script;->description:Ljava/lang/String;

    return-object v0
.end method

.method public getFileVersion()Lcom/cyjh/elfin/entity/FileVersion;
    .locals 1

    .prologue
    .line 121
    iget-object v0, p0, Lcom/cyjh/elfin/entity/Script;->fileVersion:Lcom/cyjh/elfin/entity/FileVersion;

    return-object v0
.end method

.method public getId()Ljava/lang/String;
    .locals 1

    .prologue
    .line 49
    iget-object v0, p0, Lcom/cyjh/elfin/entity/Script;->id:Ljava/lang/String;

    return-object v0
.end method

.method public getLcFile()Ljava/io/File;
    .locals 1

    .prologue
    .line 73
    iget-object v0, p0, Lcom/cyjh/elfin/entity/Script;->lcFile:Ljava/io/File;

    return-object v0
.end method

.method public getName()Ljava/lang/String;
    .locals 1

    .prologue
    .line 41
    iget-object v0, p0, Lcom/cyjh/elfin/entity/Script;->name:Ljava/lang/String;

    return-object v0
.end method

.method public getPropFile()Ljava/io/File;
    .locals 1

    .prologue
    .line 81
    iget-object v0, p0, Lcom/cyjh/elfin/entity/Script;->propFile:Ljava/io/File;

    return-object v0
.end method

.method public getRtdFile()Ljava/io/File;
    .locals 1

    .prologue
    .line 113
    iget-object v0, p0, Lcom/cyjh/elfin/entity/Script;->rtdFile:Ljava/io/File;

    return-object v0
.end method

.method public getSize()Ljava/lang/String;
    .locals 1

    .prologue
    .line 65
    iget-object v0, p0, Lcom/cyjh/elfin/entity/Script;->size:Ljava/lang/String;

    return-object v0
.end method

.method public getUiFile()Ljava/io/File;
    .locals 1

    .prologue
    .line 97
    iget-object v0, p0, Lcom/cyjh/elfin/entity/Script;->uiFile:Ljava/io/File;

    return-object v0
.end method

.method public getUipFile()Ljava/io/File;
    .locals 1

    .prologue
    .line 105
    iget-object v0, p0, Lcom/cyjh/elfin/entity/Script;->uipFile:Ljava/io/File;

    return-object v0
.end method

.method public setAtcFile(Ljava/io/File;)V
    .locals 0
    .param p1, "atcFile"    # Ljava/io/File;

    .prologue
    .line 93
    iput-object p1, p0, Lcom/cyjh/elfin/entity/Script;->atcFile:Ljava/io/File;

    .line 94
    return-void
.end method

.method public setBestResolution(Lcom/cyjh/elfin/entity/BestResolution;)V
    .locals 0
    .param p1, "bestResolution"    # Lcom/cyjh/elfin/entity/BestResolution;

    .prologue
    .line 141
    iput-object p1, p0, Lcom/cyjh/elfin/entity/Script;->bestResolution:Lcom/cyjh/elfin/entity/BestResolution;

    .line 142
    return-void
.end method

.method public setCfgFile(Ljava/io/File;)V
    .locals 0
    .param p1, "cfgFile"    # Ljava/io/File;

    .prologue
    .line 129
    iput-object p1, p0, Lcom/cyjh/elfin/entity/Script;->cfgFile:Ljava/io/File;

    .line 130
    return-void
.end method

.method public setChangeFileList(I)V
    .locals 0
    .param p1, "changeFileList"    # I

    .prologue
    .line 37
    iput p1, p0, Lcom/cyjh/elfin/entity/Script;->changeFileList:I

    .line 38
    return-void
.end method

.method public setDescription(Ljava/lang/String;)V
    .locals 0
    .param p1, "description"    # Ljava/lang/String;

    .prologue
    .line 61
    iput-object p1, p0, Lcom/cyjh/elfin/entity/Script;->description:Ljava/lang/String;

    .line 62
    return-void
.end method

.method public setFileVersion(Lcom/cyjh/elfin/entity/FileVersion;)V
    .locals 0
    .param p1, "fileVersion"    # Lcom/cyjh/elfin/entity/FileVersion;

    .prologue
    .line 133
    iput-object p1, p0, Lcom/cyjh/elfin/entity/Script;->fileVersion:Lcom/cyjh/elfin/entity/FileVersion;

    .line 134
    return-void
.end method

.method public setId(Ljava/lang/String;)V
    .locals 0
    .param p1, "id"    # Ljava/lang/String;

    .prologue
    .line 53
    iput-object p1, p0, Lcom/cyjh/elfin/entity/Script;->id:Ljava/lang/String;

    .line 54
    return-void
.end method

.method public setLcFile(Ljava/io/File;)V
    .locals 0
    .param p1, "lcFile"    # Ljava/io/File;

    .prologue
    .line 77
    iput-object p1, p0, Lcom/cyjh/elfin/entity/Script;->lcFile:Ljava/io/File;

    .line 78
    return-void
.end method

.method public setName(Ljava/lang/String;)V
    .locals 0
    .param p1, "name"    # Ljava/lang/String;

    .prologue
    .line 45
    iput-object p1, p0, Lcom/cyjh/elfin/entity/Script;->name:Ljava/lang/String;

    .line 46
    return-void
.end method

.method public setPropFile(Ljava/io/File;)V
    .locals 0
    .param p1, "propFile"    # Ljava/io/File;

    .prologue
    .line 85
    iput-object p1, p0, Lcom/cyjh/elfin/entity/Script;->propFile:Ljava/io/File;

    .line 86
    return-void
.end method

.method public setRtdFile(Ljava/io/File;)V
    .locals 0
    .param p1, "rtdFile"    # Ljava/io/File;

    .prologue
    .line 117
    iput-object p1, p0, Lcom/cyjh/elfin/entity/Script;->rtdFile:Ljava/io/File;

    .line 118
    return-void
.end method

.method public setSize(Ljava/lang/String;)V
    .locals 0
    .param p1, "size"    # Ljava/lang/String;

    .prologue
    .line 69
    iput-object p1, p0, Lcom/cyjh/elfin/entity/Script;->size:Ljava/lang/String;

    .line 70
    return-void
.end method

.method public setUiFile(Ljava/io/File;)V
    .locals 0
    .param p1, "uiFile"    # Ljava/io/File;

    .prologue
    .line 101
    iput-object p1, p0, Lcom/cyjh/elfin/entity/Script;->uiFile:Ljava/io/File;

    .line 102
    return-void
.end method

.method public setUipFile(Ljava/io/File;)V
    .locals 0
    .param p1, "uipFile"    # Ljava/io/File;

    .prologue
    .line 109
    iput-object p1, p0, Lcom/cyjh/elfin/entity/Script;->uipFile:Ljava/io/File;

    .line 110
    return-void
.end method
