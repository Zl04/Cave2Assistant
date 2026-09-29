.class public Lcom/cyjh/elfin/mvp/presenters/AbGameDetailsPresenter;
.super Lcom/cyjh/elfin/mvp/presenters/AbGamesBasicPresenter;
.source "AbGameDetailsPresenter.java"


# instance fields
.field private currentLoadState:I

.field private findBasicInf:Lcom/cyjh/elfin/mvp/views/loadstate/FindBasicInf;

.field private findToolBoxOpera:Lcom/cyjh/elfin/mvp/presenters/opera/FindToolBoxOpera;

.field private gameId:Ljava/lang/String;

.field private mContext:Landroid/content/Context;


# direct methods
.method public constructor <init>(Lcom/cyjh/elfin/mvp/views/loadstate/ILoadState;Landroid/content/Context;Lcom/cyjh/elfin/mvp/views/loadstate/FindBasicInf;)V
    .locals 1
    .param p1, "iLoadState"    # Lcom/cyjh/elfin/mvp/views/loadstate/ILoadState;
    .param p2, "context"    # Landroid/content/Context;
    .param p3, "findBasicInf"    # Lcom/cyjh/elfin/mvp/views/loadstate/FindBasicInf;

    .prologue
    .line 37
    invoke-direct {p0, p1}, Lcom/cyjh/elfin/mvp/presenters/AbGamesBasicPresenter;-><init>(Lcom/cyjh/elfin/mvp/views/loadstate/ILoadState;)V

    .line 38
    iput-object p2, p0, Lcom/cyjh/elfin/mvp/presenters/AbGameDetailsPresenter;->mContext:Landroid/content/Context;

    .line 39
    iput-object p3, p0, Lcom/cyjh/elfin/mvp/presenters/AbGameDetailsPresenter;->findBasicInf:Lcom/cyjh/elfin/mvp/views/loadstate/FindBasicInf;

    .line 40
    new-instance v0, Lcom/cyjh/elfin/mvp/presenters/opera/FindToolBoxOpera;

    invoke-direct {v0}, Lcom/cyjh/elfin/mvp/presenters/opera/FindToolBoxOpera;-><init>()V

    iput-object v0, p0, Lcom/cyjh/elfin/mvp/presenters/AbGameDetailsPresenter;->findToolBoxOpera:Lcom/cyjh/elfin/mvp/presenters/opera/FindToolBoxOpera;

    .line 41
    return-void
.end method


# virtual methods
.method public StopNetCallBack()V
    .locals 1

    .prologue
    .line 100
    iget-object v0, p0, Lcom/cyjh/elfin/mvp/presenters/AbGameDetailsPresenter;->mA:Lcom/cyjh/elfin/net/volley/ActivityHttpHelper;

    invoke-virtual {v0}, Lcom/cyjh/elfin/net/volley/ActivityHttpHelper;->stopRequest()V

    .line 101
    return-void
.end method

.method public firstLoadData(I)V
    .locals 4
    .param p1, "currentState"    # I

    .prologue
    .line 45
    iget-object v0, p0, Lcom/cyjh/elfin/mvp/presenters/AbGameDetailsPresenter;->mContext:Landroid/content/Context;

    invoke-static {v0}, Lcom/cyjh/elfin/util/NetworkUtils;->isAvailable(Landroid/content/Context;)Z

    move-result v0

    if-eqz v0, :cond_0

    .line 46
    iput p1, p0, Lcom/cyjh/elfin/mvp/presenters/AbGameDetailsPresenter;->currentLoadState:I

    .line 47
    iget-object v0, p0, Lcom/cyjh/elfin/mvp/presenters/AbGameDetailsPresenter;->findToolBoxOpera:Lcom/cyjh/elfin/mvp/presenters/opera/FindToolBoxOpera;

    iget-object v1, p0, Lcom/cyjh/elfin/mvp/presenters/AbGameDetailsPresenter;->gameId:Ljava/lang/String;

    iget-object v2, p0, Lcom/cyjh/elfin/mvp/presenters/AbGameDetailsPresenter;->mA:Lcom/cyjh/elfin/net/volley/ActivityHttpHelper;

    iget-object v3, p0, Lcom/cyjh/elfin/mvp/presenters/AbGameDetailsPresenter;->mContext:Landroid/content/Context;

    invoke-virtual {v0, v1, v2, v3}, Lcom/cyjh/elfin/mvp/presenters/opera/FindToolBoxOpera;->loadData(Ljava/lang/String;Lcom/cyjh/elfin/net/volley/ActivityHttpHelper;Landroid/content/Context;)V

    .line 51
    :goto_0
    return-void

    .line 49
    :cond_0
    iget-object v0, p0, Lcom/cyjh/elfin/mvp/presenters/AbGameDetailsPresenter;->iLoadState:Lcom/cyjh/elfin/mvp/views/loadstate/ILoadState;

    invoke-interface {v0}, Lcom/cyjh/elfin/mvp/views/loadstate/ILoadState;->onLoadNotNetwork()V

    goto :goto_0
.end method

.method public getData(Ljava/lang/String;)Ljava/lang/Object;
    .locals 1
    .param p1, "json"    # Ljava/lang/String;

    .prologue
    .line 72
    const-class v0, Lcom/cyjh/elfin/entity/GameDetails;

    invoke-static {p1, v0}, Lcom/cyjh/elfin/util/GsonExUtil;->parsData(Ljava/lang/String;Ljava/lang/Class;)Ljava/lang/Object;

    move-result-object v0

    return-object v0
.end method

.method public loadData(I)V
    .locals 0
    .param p1, "currentState"    # I

    .prologue
    .line 67
    return-void
.end method

.method public repeatLoadData(I)V
    .locals 4
    .param p1, "currentState"    # I

    .prologue
    .line 55
    iget-object v0, p0, Lcom/cyjh/elfin/mvp/presenters/AbGameDetailsPresenter;->mContext:Landroid/content/Context;

    invoke-static {v0}, Lcom/cyjh/elfin/util/NetworkUtils;->isAvailable(Landroid/content/Context;)Z

    move-result v0

    if-eqz v0, :cond_0

    .line 56
    iput p1, p0, Lcom/cyjh/elfin/mvp/presenters/AbGameDetailsPresenter;->currentLoadState:I

    .line 57
    iget-object v0, p0, Lcom/cyjh/elfin/mvp/presenters/AbGameDetailsPresenter;->findToolBoxOpera:Lcom/cyjh/elfin/mvp/presenters/opera/FindToolBoxOpera;

    iget-object v1, p0, Lcom/cyjh/elfin/mvp/presenters/AbGameDetailsPresenter;->gameId:Ljava/lang/String;

    iget-object v2, p0, Lcom/cyjh/elfin/mvp/presenters/AbGameDetailsPresenter;->mA:Lcom/cyjh/elfin/net/volley/ActivityHttpHelper;

    iget-object v3, p0, Lcom/cyjh/elfin/mvp/presenters/AbGameDetailsPresenter;->mContext:Landroid/content/Context;

    invoke-virtual {v0, v1, v2, v3}, Lcom/cyjh/elfin/mvp/presenters/opera/FindToolBoxOpera;->loadData(Ljava/lang/String;Lcom/cyjh/elfin/net/volley/ActivityHttpHelper;Landroid/content/Context;)V

    .line 62
    :goto_0
    return-void

    .line 59
    :cond_0
    iget-object v0, p0, Lcom/cyjh/elfin/mvp/presenters/AbGameDetailsPresenter;->findBasicInf:Lcom/cyjh/elfin/mvp/views/loadstate/FindBasicInf;

    invoke-interface {v0}, Lcom/cyjh/elfin/mvp/views/loadstate/FindBasicInf;->hideLoading()V

    .line 60
    iget-object v0, p0, Lcom/cyjh/elfin/mvp/presenters/AbGameDetailsPresenter;->iLoadState:Lcom/cyjh/elfin/mvp/views/loadstate/ILoadState;

    invoke-interface {v0}, Lcom/cyjh/elfin/mvp/views/loadstate/ILoadState;->onLoadNotNetwork()V

    goto :goto_0
.end method

.method public setGameId(Ljava/lang/String;)V
    .locals 0
    .param p1, "gameId"    # Ljava/lang/String;

    .prologue
    .line 33
    iput-object p1, p0, Lcom/cyjh/elfin/mvp/presenters/AbGameDetailsPresenter;->gameId:Ljava/lang/String;

    .line 34
    return-void
.end method

.method public uiDataError(Lcom/android/volley/VolleyError;)V
    .locals 2
    .param p1, "error"    # Lcom/android/volley/VolleyError;

    .prologue
    .line 93
    iget-object v0, p0, Lcom/cyjh/elfin/mvp/presenters/AbGameDetailsPresenter;->findBasicInf:Lcom/cyjh/elfin/mvp/views/loadstate/FindBasicInf;

    iget v1, p0, Lcom/cyjh/elfin/mvp/presenters/AbGameDetailsPresenter;->currentLoadState:I

    invoke-static {v0, p1, v1}, Lcom/cyjh/elfin/mvp/helper/LoadViewHelper;->loadDataError(Lcom/cyjh/elfin/mvp/views/loadstate/FindBasicInf;Lcom/android/volley/VolleyError;I)V

    .line 94
    return-void
.end method

.method public uiDataSuccess(Ljava/lang/Object;)V
    .locals 4
    .param p1, "object"    # Ljava/lang/Object;

    .prologue
    .line 77
    move-object v0, p1

    check-cast v0, Lcom/cyjh/elfin/entity/GameDetails;

    .line 78
    .local v0, "gameDetails":Lcom/cyjh/elfin/entity/GameDetails;
    if-nez v0, :cond_0

    .line 79
    iget-object v1, p0, Lcom/cyjh/elfin/mvp/presenters/AbGameDetailsPresenter;->findBasicInf:Lcom/cyjh/elfin/mvp/views/loadstate/FindBasicInf;

    iget v2, p0, Lcom/cyjh/elfin/mvp/presenters/AbGameDetailsPresenter;->currentLoadState:I

    invoke-static {v1, v2}, Lcom/cyjh/elfin/mvp/helper/LoadViewHelper;->loadSuccessNoData(Lcom/cyjh/elfin/mvp/views/loadstate/FindBasicInf;I)V

    .line 89
    :goto_0
    return-void

    .line 83
    :cond_0
    const-string v1, "1"

    iget-object v2, v0, Lcom/cyjh/elfin/entity/GameDetails;->Code:Ljava/lang/String;

    invoke-virtual {v1, v2}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v1

    if-eqz v1, :cond_1

    .line 85
    iget-object v1, p0, Lcom/cyjh/elfin/mvp/presenters/AbGameDetailsPresenter;->findBasicInf:Lcom/cyjh/elfin/mvp/views/loadstate/FindBasicInf;

    iget v2, p0, Lcom/cyjh/elfin/mvp/presenters/AbGameDetailsPresenter;->currentLoadState:I

    const/4 v3, 0x0

    invoke-static {v1, v2, v0, v3}, Lcom/cyjh/elfin/mvp/helper/LoadViewHelper;->loadSuccessHasData(Lcom/cyjh/elfin/mvp/views/loadstate/FindBasicInf;ILjava/lang/Object;Lcom/cyjh/elfin/model/PageInfo;)V

    goto :goto_0

    .line 87
    :cond_1
    iget-object v1, p0, Lcom/cyjh/elfin/mvp/presenters/AbGameDetailsPresenter;->findBasicInf:Lcom/cyjh/elfin/mvp/views/loadstate/FindBasicInf;

    iget v2, p0, Lcom/cyjh/elfin/mvp/presenters/AbGameDetailsPresenter;->currentLoadState:I

    invoke-static {v1, v2}, Lcom/cyjh/elfin/mvp/helper/LoadViewHelper;->loadSuccessNoData(Lcom/cyjh/elfin/mvp/views/loadstate/FindBasicInf;I)V

    goto :goto_0
.end method
