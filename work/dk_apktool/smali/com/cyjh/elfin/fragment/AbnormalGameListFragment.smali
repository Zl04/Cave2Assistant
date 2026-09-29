.class public Lcom/cyjh/elfin/fragment/AbnormalGameListFragment;
.super Lcom/cyjh/elfin/fragment/content/BasicLoadStateHttpFragment;
.source "AbnormalGameListFragment.java"

# interfaces
.implements Lcom/cyjh/elfin/inf/RightBtnOpera;
.implements Lcom/cyjh/elfin/mvp/views/loadstate/FindBasicInf;


# instance fields
.field private abnormalGamePresenter:Lcom/cyjh/elfin/mvp/presenters/AbnormalGamePresenter;

.field protected findSwipeRefreshLayout:Lcom/cyjh/elfin/customview/loadwidget/swiperefresh/FindSwipeRefreshLayout;

.field private gameDownloadView:Lcom/cyjh/elfin/customview/GameDownloadView;

.field private gameInfo:Lcom/cyjh/elfin/entity/GameInfo;

.field private mAdapter:Lcom/cyjh/elfin/adpter/AbnormalGameAdapter;


# direct methods
.method public constructor <init>()V
    .locals 0

    .prologue
    .line 46
    invoke-direct {p0}, Lcom/cyjh/elfin/fragment/content/BasicLoadStateHttpFragment;-><init>()V

    return-void
.end method

.method public static getInstance()Lcom/cyjh/elfin/fragment/AbnormalGameListFragment;
    .locals 1

    .prologue
    .line 54
    new-instance v0, Lcom/cyjh/elfin/fragment/AbnormalGameListFragment;

    invoke-direct {v0}, Lcom/cyjh/elfin/fragment/AbnormalGameListFragment;-><init>()V

    .line 55
    .local v0, "instance":Lcom/cyjh/elfin/fragment/AbnormalGameListFragment;
    return-object v0
.end method

.method private setAdapterData(Lcom/cyjh/elfin/entity/Game;)V
    .locals 6
    .param p1, "object"    # Lcom/cyjh/elfin/entity/Game;

    .prologue
    .line 206
    move-object v0, p1

    .line 207
    .local v0, "game":Lcom/cyjh/elfin/entity/Game;
    new-instance v2, Ljava/util/ArrayList;

    invoke-direct {v2}, Ljava/util/ArrayList;-><init>()V

    .line 208
    .local v2, "gameInfoList":Ljava/util/List;, "Ljava/util/List<Lcom/cyjh/elfin/entity/GameInfo;>;"
    invoke-interface {v2}, Ljava/util/List;->clear()V

    .line 209
    iget-object v3, v0, Lcom/cyjh/elfin/entity/Game;->Data:Ljava/util/List;

    invoke-interface {v3}, Ljava/util/List;->iterator()Ljava/util/Iterator;

    move-result-object v3

    :cond_0
    :goto_0
    invoke-interface {v3}, Ljava/util/Iterator;->hasNext()Z

    move-result v4

    if-eqz v4, :cond_1

    invoke-interface {v3}, Ljava/util/Iterator;->next()Ljava/lang/Object;

    move-result-object v1

    check-cast v1, Lcom/cyjh/elfin/entity/GameInfo;

    .line 210
    .local v1, "gameInfo":Lcom/cyjh/elfin/entity/GameInfo;
    const-string v4, "1"

    iget-object v5, v1, Lcom/cyjh/elfin/entity/GameInfo;->IsShow:Ljava/lang/String;

    invoke-virtual {v4, v5}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v4

    if-eqz v4, :cond_0

    .line 211
    invoke-interface {v2, v1}, Ljava/util/List;->add(Ljava/lang/Object;)Z

    goto :goto_0

    .line 214
    .end local v1    # "gameInfo":Lcom/cyjh/elfin/entity/GameInfo;
    :cond_1
    iget-object v3, p0, Lcom/cyjh/elfin/fragment/AbnormalGameListFragment;->mAdapter:Lcom/cyjh/elfin/adpter/AbnormalGameAdapter;

    if-nez v3, :cond_2

    .line 215
    new-instance v3, Lcom/cyjh/elfin/adpter/AbnormalGameAdapter;

    invoke-virtual {p0}, Lcom/cyjh/elfin/fragment/AbnormalGameListFragment;->getActivity()Landroid/support/v4/app/FragmentActivity;

    move-result-object v4

    invoke-direct {v3, v4, v2}, Lcom/cyjh/elfin/adpter/AbnormalGameAdapter;-><init>(Landroid/content/Context;Ljava/util/List;)V

    iput-object v3, p0, Lcom/cyjh/elfin/fragment/AbnormalGameListFragment;->mAdapter:Lcom/cyjh/elfin/adpter/AbnormalGameAdapter;

    .line 216
    iget-object v3, p0, Lcom/cyjh/elfin/fragment/AbnormalGameListFragment;->findSwipeRefreshLayout:Lcom/cyjh/elfin/customview/loadwidget/swiperefresh/FindSwipeRefreshLayout;

    iget-object v4, p0, Lcom/cyjh/elfin/fragment/AbnormalGameListFragment;->mAdapter:Lcom/cyjh/elfin/adpter/AbnormalGameAdapter;

    invoke-virtual {v3, v4}, Lcom/cyjh/elfin/customview/loadwidget/swiperefresh/FindSwipeRefreshLayout;->setAdapter(Landroid/widget/BaseAdapter;)V

    .line 217
    iget-object v3, p0, Lcom/cyjh/elfin/fragment/AbnormalGameListFragment;->findSwipeRefreshLayout:Lcom/cyjh/elfin/customview/loadwidget/swiperefresh/FindSwipeRefreshLayout;

    invoke-virtual {v3}, Lcom/cyjh/elfin/customview/loadwidget/swiperefresh/FindSwipeRefreshLayout;->getListView()Lcom/cyjh/elfin/customview/loadwidget/swiperefresh/BaseListView;

    move-result-object v3

    const/4 v4, 0x0

    invoke-virtual {v3, v4}, Lcom/cyjh/elfin/customview/loadwidget/swiperefresh/BaseListView;->setDivider(Landroid/graphics/drawable/Drawable;)V

    .line 221
    :goto_1
    iget-object v3, p0, Lcom/cyjh/elfin/fragment/AbnormalGameListFragment;->findSwipeRefreshLayout:Lcom/cyjh/elfin/customview/loadwidget/swiperefresh/FindSwipeRefreshLayout;

    new-instance v4, Lcom/cyjh/elfin/fragment/AbnormalGameListFragment$3;

    invoke-direct {v4, p0, v2}, Lcom/cyjh/elfin/fragment/AbnormalGameListFragment$3;-><init>(Lcom/cyjh/elfin/fragment/AbnormalGameListFragment;Ljava/util/List;)V

    invoke-virtual {v3, v4}, Lcom/cyjh/elfin/customview/loadwidget/swiperefresh/FindSwipeRefreshLayout;->setOnItemClickListener(Landroid/widget/AdapterView$OnItemClickListener;)V

    .line 227
    return-void

    .line 219
    :cond_2
    iget-object v3, p0, Lcom/cyjh/elfin/fragment/AbnormalGameListFragment;->mAdapter:Lcom/cyjh/elfin/adpter/AbnormalGameAdapter;

    invoke-virtual {v3, v2}, Lcom/cyjh/elfin/adpter/AbnormalGameAdapter;->notifyDataSetChanged(Ljava/util/List;)V

    goto :goto_1
.end method


# virtual methods
.method protected firstLoadData()V
    .locals 2

    .prologue
    .line 179
    iget-object v0, p0, Lcom/cyjh/elfin/fragment/AbnormalGameListFragment;->abnormalGamePresenter:Lcom/cyjh/elfin/mvp/presenters/AbnormalGamePresenter;

    const/4 v1, 0x1

    invoke-virtual {v0, v1}, Lcom/cyjh/elfin/mvp/presenters/AbnormalGamePresenter;->firstLoadData(I)V

    .line 180
    return-void
.end method

.method public firstLoadDataError(Lcom/android/volley/VolleyError;)V
    .locals 0
    .param p1, "error"    # Lcom/android/volley/VolleyError;

    .prologue
    .line 196
    invoke-virtual {p0}, Lcom/cyjh/elfin/fragment/AbnormalGameListFragment;->onLoadFailed()V

    .line 197
    return-void
.end method

.method public firstLoadDataSuccess(Ljava/lang/Object;)V
    .locals 2
    .param p1, "object"    # Ljava/lang/Object;

    .prologue
    .line 184
    iget-object v0, p0, Lcom/cyjh/elfin/fragment/AbnormalGameListFragment;->findSwipeRefreshLayout:Lcom/cyjh/elfin/customview/loadwidget/swiperefresh/FindSwipeRefreshLayout;

    invoke-virtual {v0}, Lcom/cyjh/elfin/customview/loadwidget/swiperefresh/FindSwipeRefreshLayout;->getListView()Lcom/cyjh/elfin/customview/loadwidget/swiperefresh/BaseListView;

    move-result-object v0

    const/4 v1, 0x1

    invoke-virtual {v0, v1}, Lcom/cyjh/elfin/customview/loadwidget/swiperefresh/BaseListView;->setScrollLoad(Z)V

    .line 185
    invoke-virtual {p0}, Lcom/cyjh/elfin/fragment/AbnormalGameListFragment;->onLoadSuccess()V

    .line 186
    check-cast p1, Lcom/cyjh/elfin/entity/Game;

    .end local p1    # "object":Ljava/lang/Object;
    invoke-direct {p0, p1}, Lcom/cyjh/elfin/fragment/AbnormalGameListFragment;->setAdapterData(Lcom/cyjh/elfin/entity/Game;)V

    .line 187
    return-void
.end method

.method public firstLoadDataSuccessAndEmpty()V
    .locals 0

    .prologue
    .line 191
    invoke-virtual {p0}, Lcom/cyjh/elfin/fragment/AbnormalGameListFragment;->onLoadEmpty()V

    .line 192
    return-void
.end method

.method public getContentView()Landroid/view/View;
    .locals 1

    .prologue
    .line 166
    iget-object v0, p0, Lcom/cyjh/elfin/fragment/AbnormalGameListFragment;->findSwipeRefreshLayout:Lcom/cyjh/elfin/customview/loadwidget/swiperefresh/FindSwipeRefreshLayout;

    return-object v0
.end method

.method public getEmptyView()Landroid/view/View;
    .locals 3

    .prologue
    .line 321
    invoke-virtual {p0}, Lcom/cyjh/elfin/fragment/AbnormalGameListFragment;->getActivity()Landroid/support/v4/app/FragmentActivity;

    move-result-object v0

    invoke-virtual {v0}, Landroid/support/v4/app/FragmentActivity;->getApplicationContext()Landroid/content/Context;

    move-result-object v0

    iget-object v1, p0, Lcom/cyjh/elfin/fragment/AbnormalGameListFragment;->mContentView:Landroid/view/View;

    new-instance v2, Lcom/cyjh/elfin/fragment/AbnormalGameListFragment$7;

    invoke-direct {v2, p0}, Lcom/cyjh/elfin/fragment/AbnormalGameListFragment$7;-><init>(Lcom/cyjh/elfin/fragment/AbnormalGameListFragment;)V

    invoke-static {v0, v1, v2}, Lcom/cyjh/elfin/customview/loadstate/LoadstatueViewFactory;->getLoadEmpty(Landroid/content/Context;Landroid/view/View;Landroid/view/View$OnClickListener;)Landroid/view/View;

    move-result-object v0

    return-object v0
.end method

.method public getLoadFailedView()Landroid/view/View;
    .locals 3

    .prologue
    .line 310
    invoke-virtual {p0}, Lcom/cyjh/elfin/fragment/AbnormalGameListFragment;->getActivity()Landroid/support/v4/app/FragmentActivity;

    move-result-object v0

    invoke-virtual {v0}, Landroid/support/v4/app/FragmentActivity;->getApplicationContext()Landroid/content/Context;

    move-result-object v0

    iget-object v1, p0, Lcom/cyjh/elfin/fragment/AbnormalGameListFragment;->mContentView:Landroid/view/View;

    new-instance v2, Lcom/cyjh/elfin/fragment/AbnormalGameListFragment$6;

    invoke-direct {v2, p0}, Lcom/cyjh/elfin/fragment/AbnormalGameListFragment$6;-><init>(Lcom/cyjh/elfin/fragment/AbnormalGameListFragment;)V

    invoke-static {v0, v1, v2}, Lcom/cyjh/elfin/customview/loadstate/LoadstatueViewFactory;->getLoadFailed(Landroid/content/Context;Landroid/view/View;Landroid/view/View$OnClickListener;)Landroid/view/View;

    move-result-object v0

    return-object v0
.end method

.method public getLoadingView()Landroid/view/View;
    .locals 2

    .prologue
    .line 304
    invoke-virtual {p0}, Lcom/cyjh/elfin/fragment/AbnormalGameListFragment;->getActivity()Landroid/support/v4/app/FragmentActivity;

    move-result-object v0

    invoke-virtual {v0}, Landroid/support/v4/app/FragmentActivity;->getApplicationContext()Landroid/content/Context;

    move-result-object v0

    iget-object v1, p0, Lcom/cyjh/elfin/fragment/AbnormalGameListFragment;->mContentView:Landroid/view/View;

    invoke-static {v0, v1}, Lcom/cyjh/elfin/customview/loadstate/LoadstatueViewFactory;->getLoadingView(Landroid/content/Context;Landroid/view/View;)Landroid/view/View;

    move-result-object v0

    return-object v0
.end method

.method public getNotNetworkView()Landroid/view/View;
    .locals 3

    .prologue
    .line 332
    invoke-virtual {p0}, Lcom/cyjh/elfin/fragment/AbnormalGameListFragment;->getActivity()Landroid/support/v4/app/FragmentActivity;

    move-result-object v0

    invoke-virtual {v0}, Landroid/support/v4/app/FragmentActivity;->getApplicationContext()Landroid/content/Context;

    move-result-object v0

    iget-object v1, p0, Lcom/cyjh/elfin/fragment/AbnormalGameListFragment;->mContentView:Landroid/view/View;

    new-instance v2, Lcom/cyjh/elfin/fragment/AbnormalGameListFragment$8;

    invoke-direct {v2, p0}, Lcom/cyjh/elfin/fragment/AbnormalGameListFragment$8;-><init>(Lcom/cyjh/elfin/fragment/AbnormalGameListFragment;)V

    invoke-static {v0, v1, v2}, Lcom/cyjh/elfin/customview/loadstate/LoadstatueViewFactory;->getLoadNotNetwork(Landroid/content/Context;Landroid/view/View;Landroid/view/View$OnClickListener;)Landroid/view/View;

    move-result-object v0

    return-object v0
.end method

.method public hideLoading()V
    .locals 2

    .prologue
    .line 294
    iget-object v0, p0, Lcom/cyjh/elfin/fragment/AbnormalGameListFragment;->findSwipeRefreshLayout:Lcom/cyjh/elfin/customview/loadwidget/swiperefresh/FindSwipeRefreshLayout;

    new-instance v1, Lcom/cyjh/elfin/fragment/AbnormalGameListFragment$5;

    invoke-direct {v1, p0}, Lcom/cyjh/elfin/fragment/AbnormalGameListFragment$5;-><init>(Lcom/cyjh/elfin/fragment/AbnormalGameListFragment;)V

    invoke-virtual {v0, v1}, Lcom/cyjh/elfin/customview/loadwidget/swiperefresh/FindSwipeRefreshLayout;->post(Ljava/lang/Runnable;)Z

    .line 300
    return-void
.end method

.method public initDataAfterView()V
    .locals 2

    .prologue
    .line 144
    invoke-virtual {p0}, Lcom/cyjh/elfin/fragment/AbnormalGameListFragment;->getActivity()Landroid/support/v4/app/FragmentActivity;

    move-result-object v0

    invoke-static {v0}, Lcom/cyjh/elfin/download/DownloadCountOpera;->requestEntranceGameCount(Landroid/content/Context;)V

    .line 145
    new-instance v0, Lcom/cyjh/elfin/mvp/presenters/AbnormalGamePresenter;

    invoke-virtual {p0}, Lcom/cyjh/elfin/fragment/AbnormalGameListFragment;->getActivity()Landroid/support/v4/app/FragmentActivity;

    move-result-object v1

    invoke-direct {v0, p0, v1, p0}, Lcom/cyjh/elfin/mvp/presenters/AbnormalGamePresenter;-><init>(Lcom/cyjh/elfin/mvp/views/loadstate/ILoadState;Landroid/content/Context;Lcom/cyjh/elfin/mvp/views/loadstate/FindBasicInf;)V

    iput-object v0, p0, Lcom/cyjh/elfin/fragment/AbnormalGameListFragment;->abnormalGamePresenter:Lcom/cyjh/elfin/mvp/presenters/AbnormalGamePresenter;

    .line 146
    iget-object v0, p0, Lcom/cyjh/elfin/fragment/AbnormalGameListFragment;->abnormalGamePresenter:Lcom/cyjh/elfin/mvp/presenters/AbnormalGamePresenter;

    const/4 v1, 0x1

    invoke-virtual {v0, v1}, Lcom/cyjh/elfin/mvp/presenters/AbnormalGamePresenter;->firstLoadData(I)V

    .line 147
    return-void
.end method

.method public initListener()V
    .locals 3

    .prologue
    .line 151
    iget-object v0, p0, Lcom/cyjh/elfin/fragment/AbnormalGameListFragment;->findSwipeRefreshLayout:Lcom/cyjh/elfin/customview/loadwidget/swiperefresh/FindSwipeRefreshLayout;

    new-instance v1, Lcom/cyjh/elfin/fragment/AbnormalGameListFragment$1;

    invoke-direct {v1, p0}, Lcom/cyjh/elfin/fragment/AbnormalGameListFragment$1;-><init>(Lcom/cyjh/elfin/fragment/AbnormalGameListFragment;)V

    new-instance v2, Lcom/cyjh/elfin/fragment/AbnormalGameListFragment$2;

    invoke-direct {v2, p0}, Lcom/cyjh/elfin/fragment/AbnormalGameListFragment$2;-><init>(Lcom/cyjh/elfin/fragment/AbnormalGameListFragment;)V

    invoke-virtual {v0, v1, v2}, Lcom/cyjh/elfin/customview/loadwidget/swiperefresh/FindSwipeRefreshLayout;->setUpAndDownRefresh(Lcom/cyjh/elfin/mvp/views/loadstate/IListViewLoadCallBack;Landroid/support/v4/widget/SwipeRefreshLayout$OnRefreshListener;)V

    .line 162
    return-void
.end method

.method public initView(Landroid/view/LayoutInflater;Landroid/view/ViewGroup;Landroid/os/Bundle;)Landroid/view/View;
    .locals 3
    .param p1, "inflater"    # Landroid/view/LayoutInflater;
    .param p2, "container"    # Landroid/view/ViewGroup;
    .param p3, "savedInstanceState"    # Landroid/os/Bundle;

    .prologue
    .line 135
    const v1, 0x7f040046

    const/4 v2, 0x0

    invoke-virtual {p1, v1, p2, v2}, Landroid/view/LayoutInflater;->inflate(ILandroid/view/ViewGroup;Z)Landroid/view/View;

    move-result-object v0

    .line 136
    .local v0, "view":Landroid/view/View;
    const v1, 0x7f0f0184

    invoke-virtual {v0, v1}, Landroid/view/View;->findViewById(I)Landroid/view/View;

    move-result-object v1

    check-cast v1, Lcom/cyjh/elfin/customview/loadwidget/swiperefresh/FindSwipeRefreshLayout;

    iput-object v1, p0, Lcom/cyjh/elfin/fragment/AbnormalGameListFragment;->findSwipeRefreshLayout:Lcom/cyjh/elfin/customview/loadwidget/swiperefresh/FindSwipeRefreshLayout;

    .line 137
    iget-object v1, p0, Lcom/cyjh/elfin/fragment/AbnormalGameListFragment;->findSwipeRefreshLayout:Lcom/cyjh/elfin/customview/loadwidget/swiperefresh/FindSwipeRefreshLayout;

    invoke-virtual {v1}, Lcom/cyjh/elfin/customview/loadwidget/swiperefresh/FindSwipeRefreshLayout;->init()V

    .line 138
    return-object v0
.end method

.method public loadDataButNotNetwork()V
    .locals 0

    .prologue
    .line 274
    return-void
.end method

.method protected loadDataNextPage()V
    .locals 2

    .prologue
    .line 171
    iget-object v0, p0, Lcom/cyjh/elfin/fragment/AbnormalGameListFragment;->abnormalGamePresenter:Lcom/cyjh/elfin/mvp/presenters/AbnormalGamePresenter;

    const/4 v1, 0x2

    invoke-virtual {v0, v1}, Lcom/cyjh/elfin/mvp/presenters/AbnormalGamePresenter;->loadData(I)V

    .line 172
    return-void
.end method

.method public loadDataSuccessAndLast()V
    .locals 2

    .prologue
    .line 267
    iget-object v0, p0, Lcom/cyjh/elfin/fragment/AbnormalGameListFragment;->findSwipeRefreshLayout:Lcom/cyjh/elfin/customview/loadwidget/swiperefresh/FindSwipeRefreshLayout;

    invoke-virtual {v0}, Lcom/cyjh/elfin/customview/loadwidget/swiperefresh/FindSwipeRefreshLayout;->getListView()Lcom/cyjh/elfin/customview/loadwidget/swiperefresh/BaseListView;

    move-result-object v0

    const/4 v1, 0x0

    invoke-virtual {v0, v1}, Lcom/cyjh/elfin/customview/loadwidget/swiperefresh/BaseListView;->setScrollLoad(Z)V

    .line 268
    iget-object v0, p0, Lcom/cyjh/elfin/fragment/AbnormalGameListFragment;->findSwipeRefreshLayout:Lcom/cyjh/elfin/customview/loadwidget/swiperefresh/FindSwipeRefreshLayout;

    invoke-virtual {v0}, Lcom/cyjh/elfin/customview/loadwidget/swiperefresh/FindSwipeRefreshLayout;->getListView()Lcom/cyjh/elfin/customview/loadwidget/swiperefresh/BaseListView;

    move-result-object v0

    invoke-virtual {v0}, Lcom/cyjh/elfin/customview/loadwidget/swiperefresh/BaseListView;->removeFooterView()Z

    .line 269
    return-void
.end method

.method public moreLoadDataError(Lcom/android/volley/VolleyError;)V
    .locals 1
    .param p1, "error"    # Lcom/android/volley/VolleyError;

    .prologue
    .line 262
    iget-object v0, p0, Lcom/cyjh/elfin/fragment/AbnormalGameListFragment;->findSwipeRefreshLayout:Lcom/cyjh/elfin/customview/loadwidget/swiperefresh/FindSwipeRefreshLayout;

    invoke-virtual {v0}, Lcom/cyjh/elfin/customview/loadwidget/swiperefresh/FindSwipeRefreshLayout;->getListView()Lcom/cyjh/elfin/customview/loadwidget/swiperefresh/BaseListView;

    move-result-object v0

    invoke-virtual {v0}, Lcom/cyjh/elfin/customview/loadwidget/swiperefresh/BaseListView;->onLoadFailed()V

    .line 263
    return-void
.end method

.method public moreLoadDataSuccess(Ljava/lang/Object;)V
    .locals 6
    .param p1, "object"    # Ljava/lang/Object;

    .prologue
    .line 241
    iget-object v3, p0, Lcom/cyjh/elfin/fragment/AbnormalGameListFragment;->findSwipeRefreshLayout:Lcom/cyjh/elfin/customview/loadwidget/swiperefresh/FindSwipeRefreshLayout;

    invoke-virtual {v3}, Lcom/cyjh/elfin/customview/loadwidget/swiperefresh/FindSwipeRefreshLayout;->getListView()Lcom/cyjh/elfin/customview/loadwidget/swiperefresh/BaseListView;

    move-result-object v3

    invoke-virtual {v3}, Lcom/cyjh/elfin/customview/loadwidget/swiperefresh/BaseListView;->onLoadSuccess()V

    move-object v0, p1

    .line 242
    check-cast v0, Lcom/cyjh/elfin/entity/Game;

    .line 243
    .local v0, "game":Lcom/cyjh/elfin/entity/Game;
    new-instance v2, Ljava/util/ArrayList;

    invoke-direct {v2}, Ljava/util/ArrayList;-><init>()V

    .line 244
    .local v2, "gameInfoList":Ljava/util/List;, "Ljava/util/List<Lcom/cyjh/elfin/entity/GameInfo;>;"
    invoke-interface {v2}, Ljava/util/List;->clear()V

    .line 245
    if-eqz v0, :cond_2

    iget-object v3, v0, Lcom/cyjh/elfin/entity/Game;->Data:Ljava/util/List;

    invoke-interface {v3}, Ljava/util/List;->size()I

    move-result v3

    if-lez v3, :cond_2

    .line 246
    iget-object v3, v0, Lcom/cyjh/elfin/entity/Game;->Data:Ljava/util/List;

    invoke-interface {v3}, Ljava/util/List;->iterator()Ljava/util/Iterator;

    move-result-object v3

    :cond_0
    :goto_0
    invoke-interface {v3}, Ljava/util/Iterator;->hasNext()Z

    move-result v4

    if-eqz v4, :cond_1

    invoke-interface {v3}, Ljava/util/Iterator;->next()Ljava/lang/Object;

    move-result-object v1

    check-cast v1, Lcom/cyjh/elfin/entity/GameInfo;

    .line 247
    .local v1, "gameInfo":Lcom/cyjh/elfin/entity/GameInfo;
    const-string v4, "1"

    iget-object v5, v1, Lcom/cyjh/elfin/entity/GameInfo;->IsShow:Ljava/lang/String;

    invoke-virtual {v4, v5}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v4

    if-eqz v4, :cond_0

    .line 248
    invoke-interface {v2, v1}, Ljava/util/List;->add(Ljava/lang/Object;)Z

    goto :goto_0

    .line 251
    .end local v1    # "gameInfo":Lcom/cyjh/elfin/entity/GameInfo;
    :cond_1
    iget-object v3, p0, Lcom/cyjh/elfin/fragment/AbnormalGameListFragment;->mAdapter:Lcom/cyjh/elfin/adpter/AbnormalGameAdapter;

    invoke-virtual {v3, v2}, Lcom/cyjh/elfin/adpter/AbnormalGameAdapter;->addBatchDataNotifyDataSetChanged(Ljava/util/List;)V

    .line 253
    :cond_2
    return-void
.end method

.method public moreLoadDataSuccessAndEmpty()V
    .locals 1

    .prologue
    .line 257
    iget-object v0, p0, Lcom/cyjh/elfin/fragment/AbnormalGameListFragment;->findSwipeRefreshLayout:Lcom/cyjh/elfin/customview/loadwidget/swiperefresh/FindSwipeRefreshLayout;

    invoke-virtual {v0}, Lcom/cyjh/elfin/customview/loadwidget/swiperefresh/FindSwipeRefreshLayout;->getListView()Lcom/cyjh/elfin/customview/loadwidget/swiperefresh/BaseListView;

    move-result-object v0

    invoke-virtual {v0}, Lcom/cyjh/elfin/customview/loadwidget/swiperefresh/BaseListView;->onLoadEmpty()V

    .line 258
    return-void
.end method

.method public onCreate(Landroid/os/Bundle;)V
    .locals 1
    .param p1, "savedInstanceState"    # Landroid/os/Bundle;
        .annotation build Landroid/support/annotation/Nullable;
        .end annotation
    .end param

    .prologue
    .line 60
    invoke-super {p0, p1}, Lcom/cyjh/elfin/fragment/content/BasicLoadStateHttpFragment;->onCreate(Landroid/os/Bundle;)V

    .line 61
    invoke-static {}, Lorg/greenrobot/eventbus/EventBus;->getDefault()Lorg/greenrobot/eventbus/EventBus;

    move-result-object v0

    invoke-virtual {v0, p0}, Lorg/greenrobot/eventbus/EventBus;->register(Ljava/lang/Object;)V

    .line 62
    return-void
.end method

.method public onDestroy()V
    .locals 1

    .prologue
    .line 111
    invoke-super {p0}, Lcom/cyjh/elfin/fragment/content/BasicLoadStateHttpFragment;->onDestroy()V

    .line 112
    invoke-static {}, Lorg/greenrobot/eventbus/EventBus;->getDefault()Lorg/greenrobot/eventbus/EventBus;

    move-result-object v0

    invoke-virtual {v0, p0}, Lorg/greenrobot/eventbus/EventBus;->unregister(Ljava/lang/Object;)V

    .line 113
    iget-object v0, p0, Lcom/cyjh/elfin/fragment/AbnormalGameListFragment;->abnormalGamePresenter:Lcom/cyjh/elfin/mvp/presenters/AbnormalGamePresenter;

    invoke-virtual {v0}, Lcom/cyjh/elfin/mvp/presenters/AbnormalGamePresenter;->StopNetCallBack()V

    .line 114
    return-void
.end method

.method public onMessageMainThread(Lcom/cyjh/elfin/entity/AbNormalGameEvent$InstallAppSuccessEvent;)V
    .locals 2
    .param p1, "event"    # Lcom/cyjh/elfin/entity/AbNormalGameEvent$InstallAppSuccessEvent;
    .annotation runtime Lorg/greenrobot/eventbus/Subscribe;
        threadMode = .enum Lorg/greenrobot/eventbus/ThreadMode;->MAIN:Lorg/greenrobot/eventbus/ThreadMode;
    .end annotation

    .prologue
    .line 72
    iget-object v0, p0, Lcom/cyjh/elfin/fragment/AbnormalGameListFragment;->gameInfo:Lcom/cyjh/elfin/entity/GameInfo;

    if-eqz v0, :cond_0

    new-instance v0, Ljava/lang/StringBuilder;

    invoke-direct {v0}, Ljava/lang/StringBuilder;-><init>()V

    const-string v1, "package:"

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    iget-object v1, p0, Lcom/cyjh/elfin/fragment/AbnormalGameListFragment;->gameInfo:Lcom/cyjh/elfin/entity/GameInfo;

    iget-object v1, v1, Lcom/cyjh/elfin/entity/GameInfo;->PackageName:Ljava/lang/String;

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-virtual {v0}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v0

    invoke-virtual {p1}, Lcom/cyjh/elfin/entity/AbNormalGameEvent$InstallAppSuccessEvent;->getPackageName()Ljava/lang/String;

    move-result-object v1

    invoke-virtual {v0, v1}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v0

    if-eqz v0, :cond_0

    iget-object v0, p0, Lcom/cyjh/elfin/fragment/AbnormalGameListFragment;->gameDownloadView:Lcom/cyjh/elfin/customview/GameDownloadView;

    if-eqz v0, :cond_0

    .line 74
    iget-object v0, p0, Lcom/cyjh/elfin/fragment/AbnormalGameListFragment;->gameDownloadView:Lcom/cyjh/elfin/customview/GameDownloadView;

    const v1, 0x7f0800b1

    invoke-virtual {v0, v1}, Lcom/cyjh/elfin/customview/GameDownloadView;->showUnDownload(I)V

    .line 76
    :cond_0
    return-void
.end method

.method public onMessageMainThread(Lcom/cyjh/elfin/entity/AbNormalGameEvent$PopDownloadDialogEvent;)V
    .locals 2
    .param p1, "event"    # Lcom/cyjh/elfin/entity/AbNormalGameEvent$PopDownloadDialogEvent;
    .annotation runtime Lorg/greenrobot/eventbus/Subscribe;
        threadMode = .enum Lorg/greenrobot/eventbus/ThreadMode;->MAIN:Lorg/greenrobot/eventbus/ThreadMode;
    .end annotation

    .prologue
    .line 96
    invoke-virtual {p1}, Lcom/cyjh/elfin/entity/AbNormalGameEvent$PopDownloadDialogEvent;->getGameDownloadView()Lcom/cyjh/elfin/customview/GameDownloadView;

    move-result-object v0

    iput-object v0, p0, Lcom/cyjh/elfin/fragment/AbnormalGameListFragment;->gameDownloadView:Lcom/cyjh/elfin/customview/GameDownloadView;

    .line 97
    invoke-virtual {p1}, Lcom/cyjh/elfin/entity/AbNormalGameEvent$PopDownloadDialogEvent;->getGameInfo()Lcom/cyjh/elfin/entity/GameInfo;

    move-result-object v0

    iput-object v0, p0, Lcom/cyjh/elfin/fragment/AbnormalGameListFragment;->gameInfo:Lcom/cyjh/elfin/entity/GameInfo;

    .line 98
    invoke-virtual {p1}, Lcom/cyjh/elfin/entity/AbNormalGameEvent$PopDownloadDialogEvent;->getDownloadUrl()Ljava/lang/String;

    move-result-object v0

    if-eqz v0, :cond_0

    .line 103
    iget-object v0, p0, Lcom/cyjh/elfin/fragment/AbnormalGameListFragment;->gameDownloadView:Lcom/cyjh/elfin/customview/GameDownloadView;

    if-eqz v0, :cond_0

    invoke-virtual {p1}, Lcom/cyjh/elfin/entity/AbNormalGameEvent$PopDownloadDialogEvent;->getDownloadUrl()Ljava/lang/String;

    move-result-object v0

    iget-object v1, p0, Lcom/cyjh/elfin/fragment/AbnormalGameListFragment;->gameInfo:Lcom/cyjh/elfin/entity/GameInfo;

    iget-object v1, v1, Lcom/cyjh/elfin/entity/GameInfo;->DownLoadUrl:Ljava/lang/String;

    invoke-virtual {v0, v1}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v0

    if-eqz v0, :cond_0

    .line 104
    iget-object v0, p0, Lcom/cyjh/elfin/fragment/AbnormalGameListFragment;->gameDownloadView:Lcom/cyjh/elfin/customview/GameDownloadView;

    invoke-virtual {v0}, Lcom/cyjh/elfin/customview/GameDownloadView;->startDownload()V

    .line 107
    :cond_0
    return-void
.end method

.method public onMessageMainThread(Lcom/cyjh/elfin/entity/AbNormalGameEvent$RemoveAppSuccessEvent;)V
    .locals 2
    .param p1, "event"    # Lcom/cyjh/elfin/entity/AbNormalGameEvent$RemoveAppSuccessEvent;
    .annotation runtime Lorg/greenrobot/eventbus/Subscribe;
        threadMode = .enum Lorg/greenrobot/eventbus/ThreadMode;->MAIN:Lorg/greenrobot/eventbus/ThreadMode;
    .end annotation

    .prologue
    .line 84
    iget-object v0, p0, Lcom/cyjh/elfin/fragment/AbnormalGameListFragment;->gameInfo:Lcom/cyjh/elfin/entity/GameInfo;

    if-eqz v0, :cond_0

    new-instance v0, Ljava/lang/StringBuilder;

    invoke-direct {v0}, Ljava/lang/StringBuilder;-><init>()V

    const-string v1, "package:"

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    iget-object v1, p0, Lcom/cyjh/elfin/fragment/AbnormalGameListFragment;->gameInfo:Lcom/cyjh/elfin/entity/GameInfo;

    iget-object v1, v1, Lcom/cyjh/elfin/entity/GameInfo;->PackageName:Ljava/lang/String;

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-virtual {v0}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v0

    invoke-virtual {p1}, Lcom/cyjh/elfin/entity/AbNormalGameEvent$RemoveAppSuccessEvent;->getPackageName()Ljava/lang/String;

    move-result-object v1

    invoke-virtual {v0, v1}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v0

    if-eqz v0, :cond_0

    iget-object v0, p0, Lcom/cyjh/elfin/fragment/AbnormalGameListFragment;->gameDownloadView:Lcom/cyjh/elfin/customview/GameDownloadView;

    if-eqz v0, :cond_0

    .line 86
    iget-object v0, p0, Lcom/cyjh/elfin/fragment/AbnormalGameListFragment;->gameDownloadView:Lcom/cyjh/elfin/customview/GameDownloadView;

    iget-object v1, p0, Lcom/cyjh/elfin/fragment/AbnormalGameListFragment;->gameInfo:Lcom/cyjh/elfin/entity/GameInfo;

    iget-object v1, v1, Lcom/cyjh/elfin/entity/GameInfo;->PackageName:Ljava/lang/String;

    invoke-virtual {v0, v1}, Lcom/cyjh/elfin/customview/GameDownloadView;->removeAppUpdateView(Ljava/lang/String;)V

    .line 88
    :cond_0
    return-void
.end method

.method public onPause()V
    .locals 1

    .prologue
    .line 343
    invoke-super {p0}, Lcom/cyjh/elfin/fragment/content/BasicLoadStateHttpFragment;->onPause()V

    .line 344
    const-class v0, Lcom/cyjh/elfin/fragment/AbnormalGameListFragment;

    invoke-virtual {v0}, Ljava/lang/Class;->getCanonicalName()Ljava/lang/String;

    move-result-object v0

    invoke-static {v0}, Lcom/umeng/analytics/MobclickAgent;->onPageEnd(Ljava/lang/String;)V

    .line 345
    return-void
.end method

.method protected onRepeatRefresh()V
    .locals 2

    .prologue
    .line 175
    iget-object v0, p0, Lcom/cyjh/elfin/fragment/AbnormalGameListFragment;->abnormalGamePresenter:Lcom/cyjh/elfin/mvp/presenters/AbnormalGamePresenter;

    const/4 v1, 0x3

    invoke-virtual {v0, v1}, Lcom/cyjh/elfin/mvp/presenters/AbnormalGamePresenter;->repeatLoadData(I)V

    .line 176
    return-void
.end method

.method public onResume()V
    .locals 1

    .prologue
    .line 349
    invoke-super {p0}, Lcom/cyjh/elfin/fragment/content/BasicLoadStateHttpFragment;->onResume()V

    .line 350
    const-class v0, Lcom/cyjh/elfin/fragment/AbnormalGameListFragment;

    invoke-virtual {v0}, Ljava/lang/Class;->getCanonicalName()Ljava/lang/String;

    move-result-object v0

    invoke-static {v0}, Lcom/umeng/analytics/MobclickAgent;->onPageStart(Ljava/lang/String;)V

    .line 351
    return-void
.end method

.method public repeatLoadDataError(Lcom/android/volley/VolleyError;)V
    .locals 0
    .param p1, "error"    # Lcom/android/volley/VolleyError;

    .prologue
    .line 236
    invoke-virtual {p0}, Lcom/cyjh/elfin/fragment/AbnormalGameListFragment;->onLoadFailed()V

    .line 237
    return-void
.end method

.method public repeatLoadDataSuccess(Ljava/lang/Object;)V
    .locals 2
    .param p1, "object"    # Ljava/lang/Object;

    .prologue
    .line 201
    iget-object v0, p0, Lcom/cyjh/elfin/fragment/AbnormalGameListFragment;->findSwipeRefreshLayout:Lcom/cyjh/elfin/customview/loadwidget/swiperefresh/FindSwipeRefreshLayout;

    invoke-virtual {v0}, Lcom/cyjh/elfin/customview/loadwidget/swiperefresh/FindSwipeRefreshLayout;->getListView()Lcom/cyjh/elfin/customview/loadwidget/swiperefresh/BaseListView;

    move-result-object v0

    const/4 v1, 0x1

    invoke-virtual {v0, v1}, Lcom/cyjh/elfin/customview/loadwidget/swiperefresh/BaseListView;->setScrollLoad(Z)V

    .line 202
    check-cast p1, Lcom/cyjh/elfin/entity/Game;

    .end local p1    # "object":Ljava/lang/Object;
    invoke-direct {p0, p1}, Lcom/cyjh/elfin/fragment/AbnormalGameListFragment;->setAdapterData(Lcom/cyjh/elfin/entity/Game;)V

    .line 203
    return-void
.end method

.method public repeatLoadDataSuccessAndEmpty()V
    .locals 0

    .prologue
    .line 231
    invoke-virtual {p0}, Lcom/cyjh/elfin/fragment/AbnormalGameListFragment;->onLoadEmpty()V

    .line 232
    return-void
.end method

.method public rightBtnOpera(Lcom/cyjh/elfin/entity/ActionBarOperaEnum;Ljava/lang/Object;)V
    .locals 3
    .param p1, "type"    # Lcom/cyjh/elfin/entity/ActionBarOperaEnum;
    .param p2, "param"    # Ljava/lang/Object;

    .prologue
    .line 123
    sget-object v1, Lcom/cyjh/elfin/fragment/AbnormalGameListFragment$9;->$SwitchMap$com$cyjh$elfin$entity$ActionBarOperaEnum:[I

    invoke-virtual {p1}, Lcom/cyjh/elfin/entity/ActionBarOperaEnum;->ordinal()I

    move-result v2

    aget v1, v1, v2

    packed-switch v1, :pswitch_data_0

    .line 131
    :cond_0
    :goto_0
    return-void

    :pswitch_0
    move-object v0, p2

    .line 125
    check-cast v0, Ljava/lang/String;

    .line 126
    .local v0, "url":Ljava/lang/String;
    iget-object v1, p0, Lcom/cyjh/elfin/fragment/AbnormalGameListFragment;->gameDownloadView:Lcom/cyjh/elfin/customview/GameDownloadView;

    if-eqz v1, :cond_0

    iget-object v1, p0, Lcom/cyjh/elfin/fragment/AbnormalGameListFragment;->gameInfo:Lcom/cyjh/elfin/entity/GameInfo;

    iget-object v1, v1, Lcom/cyjh/elfin/entity/GameInfo;->DownLoadUrl:Ljava/lang/String;

    invoke-virtual {v0, v1}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v1

    if-eqz v1, :cond_0

    .line 127
    iget-object v1, p0, Lcom/cyjh/elfin/fragment/AbnormalGameListFragment;->gameDownloadView:Lcom/cyjh/elfin/customview/GameDownloadView;

    invoke-virtual {v1}, Lcom/cyjh/elfin/customview/GameDownloadView;->startDownload()V

    goto :goto_0

    .line 123
    nop

    :pswitch_data_0
    .packed-switch 0x1
        :pswitch_0
    .end packed-switch
.end method

.method public showLoading()V
    .locals 2

    .prologue
    .line 281
    iget-object v0, p0, Lcom/cyjh/elfin/fragment/AbnormalGameListFragment;->findSwipeRefreshLayout:Lcom/cyjh/elfin/customview/loadwidget/swiperefresh/FindSwipeRefreshLayout;

    new-instance v1, Lcom/cyjh/elfin/fragment/AbnormalGameListFragment$4;

    invoke-direct {v1, p0}, Lcom/cyjh/elfin/fragment/AbnormalGameListFragment$4;-><init>(Lcom/cyjh/elfin/fragment/AbnormalGameListFragment;)V

    invoke-virtual {v0, v1}, Lcom/cyjh/elfin/customview/loadwidget/swiperefresh/FindSwipeRefreshLayout;->post(Ljava/lang/Runnable;)Z

    .line 287
    return-void
.end method
