.class public Lcom/cyjh/elfin/mvp/presenters/AbnormalGamePresenter;
.super Lcom/cyjh/elfin/mvp/presenters/AbGamesBasicPresenter;
.source "AbnormalGamePresenter.java"


# instance fields
.field private currentPage:I

.field private currentState:I

.field private findBasicInf:Lcom/cyjh/elfin/mvp/views/loadstate/FindBasicInf;

.field private findToolBoxOpera:Lcom/cyjh/elfin/mvp/presenters/opera/FindToolBoxOpera;

.field private mContext:Landroid/content/Context;

.field private pageInfo:Lcom/cyjh/elfin/model/PageInfo;


# direct methods
.method public constructor <init>(Lcom/cyjh/elfin/mvp/views/loadstate/ILoadState;Landroid/content/Context;Lcom/cyjh/elfin/mvp/views/loadstate/FindBasicInf;)V
    .locals 1
    .param p1, "iLoadState"    # Lcom/cyjh/elfin/mvp/views/loadstate/ILoadState;
    .param p2, "context"    # Landroid/content/Context;
    .param p3, "findBasicInf"    # Lcom/cyjh/elfin/mvp/views/loadstate/FindBasicInf;

    .prologue
    .line 36
    invoke-direct {p0, p1}, Lcom/cyjh/elfin/mvp/presenters/AbGamesBasicPresenter;-><init>(Lcom/cyjh/elfin/mvp/views/loadstate/ILoadState;)V

    .line 33
    const/4 v0, 0x1

    iput v0, p0, Lcom/cyjh/elfin/mvp/presenters/AbnormalGamePresenter;->currentPage:I

    .line 34
    new-instance v0, Lcom/cyjh/elfin/model/PageInfo;

    invoke-direct {v0}, Lcom/cyjh/elfin/model/PageInfo;-><init>()V

    iput-object v0, p0, Lcom/cyjh/elfin/mvp/presenters/AbnormalGamePresenter;->pageInfo:Lcom/cyjh/elfin/model/PageInfo;

    .line 37
    iput-object p2, p0, Lcom/cyjh/elfin/mvp/presenters/AbnormalGamePresenter;->mContext:Landroid/content/Context;

    .line 38
    new-instance v0, Lcom/cyjh/elfin/mvp/presenters/opera/FindToolBoxOpera;

    invoke-direct {v0}, Lcom/cyjh/elfin/mvp/presenters/opera/FindToolBoxOpera;-><init>()V

    iput-object v0, p0, Lcom/cyjh/elfin/mvp/presenters/AbnormalGamePresenter;->findToolBoxOpera:Lcom/cyjh/elfin/mvp/presenters/opera/FindToolBoxOpera;

    .line 39
    iput-object p3, p0, Lcom/cyjh/elfin/mvp/presenters/AbnormalGamePresenter;->findBasicInf:Lcom/cyjh/elfin/mvp/views/loadstate/FindBasicInf;

    .line 40
    return-void
.end method


# virtual methods
.method public StopNetCallBack()V
    .locals 1

    .prologue
    .line 113
    iget-object v0, p0, Lcom/cyjh/elfin/mvp/presenters/AbnormalGamePresenter;->mA:Lcom/cyjh/elfin/net/volley/ActivityHttpHelper;

    invoke-virtual {v0}, Lcom/cyjh/elfin/net/volley/ActivityHttpHelper;->stopRequest()V

    .line 114
    return-void
.end method

.method public firstLoadData(I)V
    .locals 4
    .param p1, "currentState"    # I

    .prologue
    .line 44
    iget-object v0, p0, Lcom/cyjh/elfin/mvp/presenters/AbnormalGamePresenter;->mContext:Landroid/content/Context;

    invoke-static {v0}, Lcom/cyjh/elfin/util/NetworkUtils;->isAvailable(Landroid/content/Context;)Z

    move-result v0

    if-eqz v0, :cond_0

    .line 45
    iget-object v0, p0, Lcom/cyjh/elfin/mvp/presenters/AbnormalGamePresenter;->iLoadState:Lcom/cyjh/elfin/mvp/views/loadstate/ILoadState;

    invoke-interface {v0}, Lcom/cyjh/elfin/mvp/views/loadstate/ILoadState;->onLoadStart()V

    .line 46
    iput p1, p0, Lcom/cyjh/elfin/mvp/presenters/AbnormalGamePresenter;->currentState:I

    .line 47
    const/4 v0, 0x1

    iput v0, p0, Lcom/cyjh/elfin/mvp/presenters/AbnormalGamePresenter;->currentPage:I

    .line 48
    iget-object v0, p0, Lcom/cyjh/elfin/mvp/presenters/AbnormalGamePresenter;->findToolBoxOpera:Lcom/cyjh/elfin/mvp/presenters/opera/FindToolBoxOpera;

    iget v1, p0, Lcom/cyjh/elfin/mvp/presenters/AbnormalGamePresenter;->currentPage:I

    iget-object v2, p0, Lcom/cyjh/elfin/mvp/presenters/AbnormalGamePresenter;->mA:Lcom/cyjh/elfin/net/volley/ActivityHttpHelper;

    iget-object v3, p0, Lcom/cyjh/elfin/mvp/presenters/AbnormalGamePresenter;->mContext:Landroid/content/Context;

    invoke-virtual {v0, v1, v2, v3}, Lcom/cyjh/elfin/mvp/presenters/opera/FindToolBoxOpera;->loadData(ILcom/cyjh/elfin/net/volley/ActivityHttpHelper;Landroid/content/Context;)V

    .line 52
    :goto_0
    return-void

    .line 50
    :cond_0
    iget-object v0, p0, Lcom/cyjh/elfin/mvp/presenters/AbnormalGamePresenter;->iLoadState:Lcom/cyjh/elfin/mvp/views/loadstate/ILoadState;

    invoke-interface {v0}, Lcom/cyjh/elfin/mvp/views/loadstate/ILoadState;->onLoadNotNetwork()V

    goto :goto_0
.end method

.method public getData(Ljava/lang/String;)Ljava/lang/Object;
    .locals 1
    .param p1, "json"    # Ljava/lang/String;

    .prologue
    .line 82
    const-class v0, Lcom/cyjh/elfin/entity/Game;

    invoke-static {p1, v0}, Lcom/cyjh/elfin/util/GsonExUtil;->parsData(Ljava/lang/String;Ljava/lang/Class;)Ljava/lang/Object;

    move-result-object v0

    return-object v0
.end method

.method public loadData(I)V
    .locals 4
    .param p1, "currentState"    # I

    .prologue
    .line 68
    iput p1, p0, Lcom/cyjh/elfin/mvp/presenters/AbnormalGamePresenter;->currentState:I

    .line 69
    iget v0, p0, Lcom/cyjh/elfin/mvp/presenters/AbnormalGamePresenter;->currentPage:I

    add-int/lit8 v0, v0, 0x1

    iput v0, p0, Lcom/cyjh/elfin/mvp/presenters/AbnormalGamePresenter;->currentPage:I

    .line 71
    iget-object v0, p0, Lcom/cyjh/elfin/mvp/presenters/AbnormalGamePresenter;->findToolBoxOpera:Lcom/cyjh/elfin/mvp/presenters/opera/FindToolBoxOpera;

    iget v1, p0, Lcom/cyjh/elfin/mvp/presenters/AbnormalGamePresenter;->currentPage:I

    iget-object v2, p0, Lcom/cyjh/elfin/mvp/presenters/AbnormalGamePresenter;->mA:Lcom/cyjh/elfin/net/volley/ActivityHttpHelper;

    iget-object v3, p0, Lcom/cyjh/elfin/mvp/presenters/AbnormalGamePresenter;->mContext:Landroid/content/Context;

    invoke-virtual {v0, v1, v2, v3}, Lcom/cyjh/elfin/mvp/presenters/opera/FindToolBoxOpera;->loadData(ILcom/cyjh/elfin/net/volley/ActivityHttpHelper;Landroid/content/Context;)V

    .line 72
    return-void
.end method

.method public repeatLoadData(I)V
    .locals 4
    .param p1, "currentState"    # I

    .prologue
    .line 56
    iget-object v0, p0, Lcom/cyjh/elfin/mvp/presenters/AbnormalGamePresenter;->mContext:Landroid/content/Context;

    invoke-static {v0}, Lcom/cyjh/elfin/util/NetworkUtils;->isAvailable(Landroid/content/Context;)Z

    move-result v0

    if-eqz v0, :cond_0

    .line 57
    iput p1, p0, Lcom/cyjh/elfin/mvp/presenters/AbnormalGamePresenter;->currentState:I

    .line 58
    const/4 v0, 0x1

    iput v0, p0, Lcom/cyjh/elfin/mvp/presenters/AbnormalGamePresenter;->currentPage:I

    .line 59
    iget-object v0, p0, Lcom/cyjh/elfin/mvp/presenters/AbnormalGamePresenter;->findToolBoxOpera:Lcom/cyjh/elfin/mvp/presenters/opera/FindToolBoxOpera;

    iget v1, p0, Lcom/cyjh/elfin/mvp/presenters/AbnormalGamePresenter;->currentPage:I

    iget-object v2, p0, Lcom/cyjh/elfin/mvp/presenters/AbnormalGamePresenter;->mA:Lcom/cyjh/elfin/net/volley/ActivityHttpHelper;

    iget-object v3, p0, Lcom/cyjh/elfin/mvp/presenters/AbnormalGamePresenter;->mContext:Landroid/content/Context;

    invoke-virtual {v0, v1, v2, v3}, Lcom/cyjh/elfin/mvp/presenters/opera/FindToolBoxOpera;->loadData(ILcom/cyjh/elfin/net/volley/ActivityHttpHelper;Landroid/content/Context;)V

    .line 64
    :goto_0
    return-void

    .line 61
    :cond_0
    iget-object v0, p0, Lcom/cyjh/elfin/mvp/presenters/AbnormalGamePresenter;->findBasicInf:Lcom/cyjh/elfin/mvp/views/loadstate/FindBasicInf;

    invoke-interface {v0}, Lcom/cyjh/elfin/mvp/views/loadstate/FindBasicInf;->hideLoading()V

    .line 62
    iget-object v0, p0, Lcom/cyjh/elfin/mvp/presenters/AbnormalGamePresenter;->iLoadState:Lcom/cyjh/elfin/mvp/views/loadstate/ILoadState;

    invoke-interface {v0}, Lcom/cyjh/elfin/mvp/views/loadstate/ILoadState;->onLoadNotNetwork()V

    goto :goto_0
.end method

.method public uiDataError(Lcom/android/volley/VolleyError;)V
    .locals 2
    .param p1, "error"    # Lcom/android/volley/VolleyError;

    .prologue
    .line 106
    iget-object v0, p0, Lcom/cyjh/elfin/mvp/presenters/AbnormalGamePresenter;->findBasicInf:Lcom/cyjh/elfin/mvp/views/loadstate/FindBasicInf;

    iget v1, p0, Lcom/cyjh/elfin/mvp/presenters/AbnormalGamePresenter;->currentState:I

    invoke-static {v0, p1, v1}, Lcom/cyjh/elfin/mvp/helper/LoadViewHelper;->loadDataError(Lcom/cyjh/elfin/mvp/views/loadstate/FindBasicInf;Lcom/android/volley/VolleyError;I)V

    .line 107
    return-void
.end method

.method public uiDataSuccess(Ljava/lang/Object;)V
    .locals 4
    .param p1, "object"    # Ljava/lang/Object;

    .prologue
    .line 87
    move-object v0, p1

    check-cast v0, Lcom/cyjh/elfin/entity/Game;

    .line 88
    .local v0, "game":Lcom/cyjh/elfin/entity/Game;
    if-nez v0, :cond_0

    .line 89
    iget-object v1, p0, Lcom/cyjh/elfin/mvp/presenters/AbnormalGamePresenter;->findBasicInf:Lcom/cyjh/elfin/mvp/views/loadstate/FindBasicInf;

    iget v2, p0, Lcom/cyjh/elfin/mvp/presenters/AbnormalGamePresenter;->currentState:I

    invoke-static {v1, v2}, Lcom/cyjh/elfin/mvp/helper/LoadViewHelper;->loadSuccessNoData(Lcom/cyjh/elfin/mvp/views/loadstate/FindBasicInf;I)V

    .line 102
    :goto_0
    return-void

    .line 92
    :cond_0
    const-string v1, "1"

    iget-object v2, v0, Lcom/cyjh/elfin/entity/Game;->Code:Ljava/lang/String;

    invoke-virtual {v1, v2}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v1

    if-eqz v1, :cond_2

    iget-object v1, v0, Lcom/cyjh/elfin/entity/Game;->Data:Ljava/util/List;

    invoke-interface {v1}, Ljava/util/List;->size()I

    move-result v1

    if-lez v1, :cond_2

    .line 93
    iget-object v1, v0, Lcom/cyjh/elfin/entity/Game;->Data:Ljava/util/List;

    invoke-interface {v1}, Ljava/util/List;->size()I

    move-result v1

    const/16 v2, 0xa

    if-ge v1, v2, :cond_1

    .line 94
    iget-object v1, p0, Lcom/cyjh/elfin/mvp/presenters/AbnormalGamePresenter;->pageInfo:Lcom/cyjh/elfin/model/PageInfo;

    const/4 v2, 0x1

    invoke-virtual {v1, v2}, Lcom/cyjh/elfin/model/PageInfo;->setIsLastPage(I)V

    .line 98
    :goto_1
    iget-object v1, p0, Lcom/cyjh/elfin/mvp/presenters/AbnormalGamePresenter;->findBasicInf:Lcom/cyjh/elfin/mvp/views/loadstate/FindBasicInf;

    iget v2, p0, Lcom/cyjh/elfin/mvp/presenters/AbnormalGamePresenter;->currentState:I

    iget-object v3, p0, Lcom/cyjh/elfin/mvp/presenters/AbnormalGamePresenter;->pageInfo:Lcom/cyjh/elfin/model/PageInfo;

    invoke-static {v1, v2, p1, v3}, Lcom/cyjh/elfin/mvp/helper/LoadViewHelper;->loadSuccessHasData(Lcom/cyjh/elfin/mvp/views/loadstate/FindBasicInf;ILjava/lang/Object;Lcom/cyjh/elfin/model/PageInfo;)V

    goto :goto_0

    .line 96
    :cond_1
    iget-object v1, p0, Lcom/cyjh/elfin/mvp/presenters/AbnormalGamePresenter;->pageInfo:Lcom/cyjh/elfin/model/PageInfo;

    const/4 v2, 0x0

    invoke-virtual {v1, v2}, Lcom/cyjh/elfin/model/PageInfo;->setIsLastPage(I)V

    goto :goto_1

    .line 100
    :cond_2
    iget-object v1, p0, Lcom/cyjh/elfin/mvp/presenters/AbnormalGamePresenter;->findBasicInf:Lcom/cyjh/elfin/mvp/views/loadstate/FindBasicInf;

    iget v2, p0, Lcom/cyjh/elfin/mvp/presenters/AbnormalGamePresenter;->currentState:I

    invoke-static {v1, v2}, Lcom/cyjh/elfin/mvp/helper/LoadViewHelper;->loadSuccessNoData(Lcom/cyjh/elfin/mvp/views/loadstate/FindBasicInf;I)V

    goto :goto_0
.end method
