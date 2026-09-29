.class public Lcom/cyjh/elfin/entity/AbNormalGameEvent$PopDownloadDialogEvent;
.super Ljava/lang/Object;
.source "AbNormalGameEvent.java"


# annotations
.annotation system Ldalvik/annotation/EnclosingClass;
    value = Lcom/cyjh/elfin/entity/AbNormalGameEvent;
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x9
    name = "PopDownloadDialogEvent"
.end annotation


# instance fields
.field private downloadUrl:Ljava/lang/String;

.field private gameDownloadView:Lcom/cyjh/elfin/customview/GameDownloadView;

.field private gameInfo:Lcom/cyjh/elfin/entity/GameInfo;


# direct methods
.method public constructor <init>(Lcom/cyjh/elfin/customview/GameDownloadView;Lcom/cyjh/elfin/entity/GameInfo;Ljava/lang/String;)V
    .locals 0
    .param p1, "gameDownloadView"    # Lcom/cyjh/elfin/customview/GameDownloadView;
    .param p2, "gameInfo"    # Lcom/cyjh/elfin/entity/GameInfo;
    .param p3, "downloadUrl"    # Ljava/lang/String;

    .prologue
    .line 64
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    .line 65
    iput-object p1, p0, Lcom/cyjh/elfin/entity/AbNormalGameEvent$PopDownloadDialogEvent;->gameDownloadView:Lcom/cyjh/elfin/customview/GameDownloadView;

    .line 66
    iput-object p2, p0, Lcom/cyjh/elfin/entity/AbNormalGameEvent$PopDownloadDialogEvent;->gameInfo:Lcom/cyjh/elfin/entity/GameInfo;

    .line 67
    iput-object p3, p0, Lcom/cyjh/elfin/entity/AbNormalGameEvent$PopDownloadDialogEvent;->downloadUrl:Ljava/lang/String;

    .line 68
    return-void
.end method

.method public constructor <init>(Ljava/lang/String;)V
    .locals 0
    .param p1, "downloadUrl"    # Ljava/lang/String;

    .prologue
    .line 60
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    .line 61
    iput-object p1, p0, Lcom/cyjh/elfin/entity/AbNormalGameEvent$PopDownloadDialogEvent;->downloadUrl:Ljava/lang/String;

    .line 62
    return-void
.end method


# virtual methods
.method public getDownloadUrl()Ljava/lang/String;
    .locals 1

    .prologue
    .line 71
    iget-object v0, p0, Lcom/cyjh/elfin/entity/AbNormalGameEvent$PopDownloadDialogEvent;->downloadUrl:Ljava/lang/String;

    return-object v0
.end method

.method public getGameDownloadView()Lcom/cyjh/elfin/customview/GameDownloadView;
    .locals 1

    .prologue
    .line 79
    iget-object v0, p0, Lcom/cyjh/elfin/entity/AbNormalGameEvent$PopDownloadDialogEvent;->gameDownloadView:Lcom/cyjh/elfin/customview/GameDownloadView;

    return-object v0
.end method

.method public getGameInfo()Lcom/cyjh/elfin/entity/GameInfo;
    .locals 1

    .prologue
    .line 87
    iget-object v0, p0, Lcom/cyjh/elfin/entity/AbNormalGameEvent$PopDownloadDialogEvent;->gameInfo:Lcom/cyjh/elfin/entity/GameInfo;

    return-object v0
.end method

.method public setDownloadUrl(Ljava/lang/String;)V
    .locals 0
    .param p1, "downloadUrl"    # Ljava/lang/String;

    .prologue
    .line 75
    iput-object p1, p0, Lcom/cyjh/elfin/entity/AbNormalGameEvent$PopDownloadDialogEvent;->downloadUrl:Ljava/lang/String;

    .line 76
    return-void
.end method

.method public setGameDownloadView(Lcom/cyjh/elfin/customview/GameDownloadView;)V
    .locals 0
    .param p1, "gameDownloadView"    # Lcom/cyjh/elfin/customview/GameDownloadView;

    .prologue
    .line 83
    iput-object p1, p0, Lcom/cyjh/elfin/entity/AbNormalGameEvent$PopDownloadDialogEvent;->gameDownloadView:Lcom/cyjh/elfin/customview/GameDownloadView;

    .line 84
    return-void
.end method

.method public setGameInfo(Lcom/cyjh/elfin/entity/GameInfo;)V
    .locals 0
    .param p1, "gameInfo"    # Lcom/cyjh/elfin/entity/GameInfo;

    .prologue
    .line 91
    iput-object p1, p0, Lcom/cyjh/elfin/entity/AbNormalGameEvent$PopDownloadDialogEvent;->gameInfo:Lcom/cyjh/elfin/entity/GameInfo;

    .line 92
    return-void
.end method
