.class public Lcom/cyjh/elfin/model/LogData$Data;
.super Ljava/lang/Object;
.source "LogData.java"


# annotations
.annotation system Ldalvik/annotation/EnclosingClass;
    value = Lcom/cyjh/elfin/model/LogData;
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x9
    name = "Data"
.end annotation


# instance fields
.field private AppID:Ljava/lang/String;

.field private AppVersion:Ljava/lang/String;

.field private IsFree:Ljava/lang/String;

.field private MachineCode:Ljava/lang/String;

.field private UsedTime:Ljava/lang/String;


# direct methods
.method public constructor <init>(Landroid/content/Context;)V
    .locals 1
    .param p1, "context"    # Landroid/content/Context;

    .prologue
    .line 95
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    .line 96
    const v0, 0x7f0800c9

    invoke-virtual {p1, v0}, Landroid/content/Context;->getString(I)Ljava/lang/String;

    move-result-object v0

    iput-object v0, p0, Lcom/cyjh/elfin/model/LogData$Data;->AppVersion:Ljava/lang/String;

    .line 97
    const v0, 0x7f0800bf

    invoke-virtual {p1, v0}, Landroid/content/Context;->getString(I)Ljava/lang/String;

    move-result-object v0

    iput-object v0, p0, Lcom/cyjh/elfin/model/LogData$Data;->AppID:Ljava/lang/String;

    .line 98
    invoke-static {p1}, Lcom/cyjh/elfin/util/UniqIdUtil;->getUniqId(Landroid/content/Context;)Ljava/lang/String;

    move-result-object v0

    iput-object v0, p0, Lcom/cyjh/elfin/model/LogData$Data;->MachineCode:Ljava/lang/String;

    .line 99
    const-string v0, "1"

    iput-object v0, p0, Lcom/cyjh/elfin/model/LogData$Data;->IsFree:Ljava/lang/String;

    .line 100
    const-string v0, "0"

    iput-object v0, p0, Lcom/cyjh/elfin/model/LogData$Data;->UsedTime:Ljava/lang/String;

    .line 101
    return-void
.end method


# virtual methods
.method public getAppID()Ljava/lang/String;
    .locals 1

    .prologue
    .line 112
    iget-object v0, p0, Lcom/cyjh/elfin/model/LogData$Data;->AppID:Ljava/lang/String;

    return-object v0
.end method

.method public getAppVersion()Ljava/lang/String;
    .locals 1

    .prologue
    .line 104
    iget-object v0, p0, Lcom/cyjh/elfin/model/LogData$Data;->AppVersion:Ljava/lang/String;

    return-object v0
.end method

.method public getIsFree()Ljava/lang/String;
    .locals 1

    .prologue
    .line 128
    iget-object v0, p0, Lcom/cyjh/elfin/model/LogData$Data;->IsFree:Ljava/lang/String;

    return-object v0
.end method

.method public getMachineCode()Ljava/lang/String;
    .locals 1

    .prologue
    .line 120
    iget-object v0, p0, Lcom/cyjh/elfin/model/LogData$Data;->MachineCode:Ljava/lang/String;

    return-object v0
.end method

.method public getUsedTime()Ljava/lang/String;
    .locals 1

    .prologue
    .line 136
    iget-object v0, p0, Lcom/cyjh/elfin/model/LogData$Data;->UsedTime:Ljava/lang/String;

    return-object v0
.end method

.method public setAppID(Ljava/lang/String;)V
    .locals 0
    .param p1, "appID"    # Ljava/lang/String;

    .prologue
    .line 116
    iput-object p1, p0, Lcom/cyjh/elfin/model/LogData$Data;->AppID:Ljava/lang/String;

    .line 117
    return-void
.end method

.method public setAppVersion(Ljava/lang/String;)V
    .locals 0
    .param p1, "appVersion"    # Ljava/lang/String;

    .prologue
    .line 108
    iput-object p1, p0, Lcom/cyjh/elfin/model/LogData$Data;->AppVersion:Ljava/lang/String;

    .line 109
    return-void
.end method

.method public setIsFree(Ljava/lang/String;)V
    .locals 0
    .param p1, "isFree"    # Ljava/lang/String;

    .prologue
    .line 132
    iput-object p1, p0, Lcom/cyjh/elfin/model/LogData$Data;->IsFree:Ljava/lang/String;

    .line 133
    return-void
.end method

.method public setMachineCode(Ljava/lang/String;)V
    .locals 0
    .param p1, "machineCode"    # Ljava/lang/String;

    .prologue
    .line 124
    iput-object p1, p0, Lcom/cyjh/elfin/model/LogData$Data;->MachineCode:Ljava/lang/String;

    .line 125
    return-void
.end method

.method public setUsedTime(Ljava/lang/String;)V
    .locals 0
    .param p1, "usedTime"    # Ljava/lang/String;

    .prologue
    .line 140
    iput-object p1, p0, Lcom/cyjh/elfin/model/LogData$Data;->UsedTime:Ljava/lang/String;

    .line 141
    return-void
.end method
