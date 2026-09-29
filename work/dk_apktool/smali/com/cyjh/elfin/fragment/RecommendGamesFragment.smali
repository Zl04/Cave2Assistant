.class public Lcom/cyjh/elfin/fragment/RecommendGamesFragment;
.super Lcom/cyjh/elfin/fragment/BaseFragement;
.source "RecommendGamesFragment.java"

# interfaces
.implements Lcom/cyjh/elfin/mvp/views/RecommendGamesView;


# instance fields
.field private appContext:Lcom/cyjh/elfin/AppContext;

.field private gameLink:Ljava/lang/String;

.field private isDownloadSuc:Z

.field private mRootLayout:Landroid/widget/LinearLayout;

.field private mWebView:Landroid/webkit/WebView;

.field private reCommendGamesPresenter:Lcom/cyjh/elfin/mvp/presenters/RecommendGamesPresenter;


# direct methods
.method public constructor <init>()V
    .locals 1

    .prologue
    .line 36
    invoke-direct {p0}, Lcom/cyjh/elfin/fragment/BaseFragement;-><init>()V

    .line 43
    const/4 v0, 0x0

    iput-boolean v0, p0, Lcom/cyjh/elfin/fragment/RecommendGamesFragment;->isDownloadSuc:Z

    return-void
.end method

.method static synthetic access$000(Lcom/cyjh/elfin/fragment/RecommendGamesFragment;)Z
    .locals 1
    .param p0, "x0"    # Lcom/cyjh/elfin/fragment/RecommendGamesFragment;

    .prologue
    .line 36
    iget-boolean v0, p0, Lcom/cyjh/elfin/fragment/RecommendGamesFragment;->isDownloadSuc:Z

    return v0
.end method

.method static synthetic access$002(Lcom/cyjh/elfin/fragment/RecommendGamesFragment;Z)Z
    .locals 0
    .param p0, "x0"    # Lcom/cyjh/elfin/fragment/RecommendGamesFragment;
    .param p1, "x1"    # Z

    .prologue
    .line 36
    iput-boolean p1, p0, Lcom/cyjh/elfin/fragment/RecommendGamesFragment;->isDownloadSuc:Z

    return p1
.end method

.method private initView(Landroid/view/View;)V
    .locals 6
    .param p1, "view"    # Landroid/view/View;

    .prologue
    const/4 v5, -0x1

    const/4 v4, 0x1

    .line 86
    const v2, 0x7f0f010c

    invoke-virtual {p1, v2}, Landroid/view/View;->findViewById(I)Landroid/view/View;

    move-result-object v2

    check-cast v2, Landroid/widget/LinearLayout;

    iput-object v2, p0, Lcom/cyjh/elfin/fragment/RecommendGamesFragment;->mRootLayout:Landroid/widget/LinearLayout;

    .line 87
    new-instance v2, Landroid/webkit/WebView;

    invoke-virtual {p0}, Lcom/cyjh/elfin/fragment/RecommendGamesFragment;->getActivity()Landroid/support/v4/app/FragmentActivity;

    move-result-object v3

    invoke-virtual {v3}, Landroid/support/v4/app/FragmentActivity;->getApplicationContext()Landroid/content/Context;

    move-result-object v3

    invoke-direct {v2, v3}, Landroid/webkit/WebView;-><init>(Landroid/content/Context;)V

    iput-object v2, p0, Lcom/cyjh/elfin/fragment/RecommendGamesFragment;->mWebView:Landroid/webkit/WebView;

    .line 88
    new-instance v0, Landroid/widget/LinearLayout$LayoutParams;

    invoke-direct {v0, v5, v5}, Landroid/widget/LinearLayout$LayoutParams;-><init>(II)V

    .line 90
    .local v0, "params":Landroid/widget/LinearLayout$LayoutParams;
    iget-object v2, p0, Lcom/cyjh/elfin/fragment/RecommendGamesFragment;->mRootLayout:Landroid/widget/LinearLayout;

    iget-object v3, p0, Lcom/cyjh/elfin/fragment/RecommendGamesFragment;->mWebView:Landroid/webkit/WebView;

    invoke-virtual {v2, v3, v0}, Landroid/widget/LinearLayout;->addView(Landroid/view/View;Landroid/view/ViewGroup$LayoutParams;)V

    .line 91
    iget-object v2, p0, Lcom/cyjh/elfin/fragment/RecommendGamesFragment;->mWebView:Landroid/webkit/WebView;

    invoke-virtual {v2}, Landroid/webkit/WebView;->getSettings()Landroid/webkit/WebSettings;

    move-result-object v1

    .line 92
    .local v1, "webSettings":Landroid/webkit/WebSettings;
    invoke-virtual {v1, v4}, Landroid/webkit/WebSettings;->setJavaScriptEnabled(Z)V

    .line 93
    invoke-virtual {v1, v4}, Landroid/webkit/WebSettings;->setDomStorageEnabled(Z)V

    .line 96
    invoke-virtual {v1, v4}, Landroid/webkit/WebSettings;->setLoadWithOverviewMode(Z)V

    .line 97
    invoke-virtual {v1, v4}, Landroid/webkit/WebSettings;->setDatabaseEnabled(Z)V

    .line 98
    iget-object v2, p0, Lcom/cyjh/elfin/fragment/RecommendGamesFragment;->gameLink:Ljava/lang/String;

    invoke-static {v2}, Landroid/text/TextUtils;->isEmpty(Ljava/lang/CharSequence;)Z

    move-result v2

    if-nez v2, :cond_0

    .line 99
    iget-object v2, p0, Lcom/cyjh/elfin/fragment/RecommendGamesFragment;->gameLink:Ljava/lang/String;

    invoke-direct {p0, v2}, Lcom/cyjh/elfin/fragment/RecommendGamesFragment;->showWebView(Ljava/lang/String;)V

    .line 101
    :cond_0
    return-void
.end method

.method public static newInstance(Ljava/lang/String;)Lcom/cyjh/elfin/fragment/RecommendGamesFragment;
    .locals 3
    .param p0, "path"    # Ljava/lang/String;

    .prologue
    .line 63
    new-instance v1, Lcom/cyjh/elfin/fragment/RecommendGamesFragment;

    invoke-direct {v1}, Lcom/cyjh/elfin/fragment/RecommendGamesFragment;-><init>()V

    .line 64
    .local v1, "recommendGamesFragment":Lcom/cyjh/elfin/fragment/RecommendGamesFragment;
    new-instance v0, Landroid/os/Bundle;

    invoke-direct {v0}, Landroid/os/Bundle;-><init>()V

    .line 65
    .local v0, "bundle":Landroid/os/Bundle;
    const-class v2, Lcom/cyjh/elfin/fragment/RecommendGamesFragment;

    invoke-virtual {v2}, Ljava/lang/Class;->getCanonicalName()Ljava/lang/String;

    move-result-object v2

    invoke-virtual {v0, v2, p0}, Landroid/os/Bundle;->putString(Ljava/lang/String;Ljava/lang/String;)V

    .line 66
    invoke-virtual {v1, v0}, Lcom/cyjh/elfin/fragment/RecommendGamesFragment;->setArguments(Landroid/os/Bundle;)V

    .line 67
    return-object v1
.end method

.method private showWebView(Ljava/lang/String;)V
    .locals 2
    .param p1, "jumpLink"    # Ljava/lang/String;

    .prologue
    .line 119
    iget-object v0, p0, Lcom/cyjh/elfin/fragment/RecommendGamesFragment;->mWebView:Landroid/webkit/WebView;

    const/4 v1, 0x0

    invoke-virtual {v0, v1}, Landroid/webkit/WebView;->setVisibility(I)V

    .line 121
    iget-object v0, p0, Lcom/cyjh/elfin/fragment/RecommendGamesFragment;->mWebView:Landroid/webkit/WebView;

    new-instance v1, Lcom/cyjh/elfin/fragment/RecommendGamesFragment$1;

    invoke-direct {v1, p0}, Lcom/cyjh/elfin/fragment/RecommendGamesFragment$1;-><init>(Lcom/cyjh/elfin/fragment/RecommendGamesFragment;)V

    invoke-virtual {v0, v1}, Landroid/webkit/WebView;->setWebViewClient(Landroid/webkit/WebViewClient;)V

    .line 128
    iget-object v0, p0, Lcom/cyjh/elfin/fragment/RecommendGamesFragment;->mWebView:Landroid/webkit/WebView;

    new-instance v1, Lcom/cyjh/elfin/fragment/RecommendGamesFragment$2;

    invoke-direct {v1, p0}, Lcom/cyjh/elfin/fragment/RecommendGamesFragment$2;-><init>(Lcom/cyjh/elfin/fragment/RecommendGamesFragment;)V

    invoke-virtual {v0, v1}, Landroid/webkit/WebView;->setDownloadListener(Landroid/webkit/DownloadListener;)V

    .line 143
    iget-object v0, p0, Lcom/cyjh/elfin/fragment/RecommendGamesFragment;->mWebView:Landroid/webkit/WebView;

    invoke-virtual {v0, p1}, Landroid/webkit/WebView;->loadUrl(Ljava/lang/String;)V

    .line 144
    return-void
.end method


# virtual methods
.method public gamesSwitch(Lcom/cyjh/elfin/entity/GameSwitchBean;)V
    .locals 3
    .param p1, "gameSwitchBean"    # Lcom/cyjh/elfin/entity/GameSwitchBean;

    .prologue
    .line 106
    if-eqz p1, :cond_1

    const-string v0, "1"

    iget-object v1, p1, Lcom/cyjh/elfin/entity/GameSwitchBean;->Code:Ljava/lang/String;

    invoke-virtual {v0, v1}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v0

    if-eqz v0, :cond_1

    iget-object v0, p1, Lcom/cyjh/elfin/entity/GameSwitchBean;->Data:Lcom/cyjh/elfin/entity/GameSwitchInfo;

    if-eqz v0, :cond_1

    const-string v0, "2"

    iget-object v1, p1, Lcom/cyjh/elfin/entity/GameSwitchBean;->Data:Lcom/cyjh/elfin/entity/GameSwitchInfo;

    iget-object v1, v1, Lcom/cyjh/elfin/entity/GameSwitchInfo;->Type:Ljava/lang/String;

    .line 107
    invoke-virtual {v0, v1}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v0

    if-eqz v0, :cond_1

    .line 108
    iget-object v0, p1, Lcom/cyjh/elfin/entity/GameSwitchBean;->Data:Lcom/cyjh/elfin/entity/GameSwitchInfo;

    iget-object v0, v0, Lcom/cyjh/elfin/entity/GameSwitchInfo;->Path:Ljava/lang/String;

    invoke-direct {p0, v0}, Lcom/cyjh/elfin/fragment/RecommendGamesFragment;->showWebView(Ljava/lang/String;)V

    .line 109
    iget-object v0, p1, Lcom/cyjh/elfin/entity/GameSwitchBean;->Data:Lcom/cyjh/elfin/entity/GameSwitchInfo;

    iget-object v0, v0, Lcom/cyjh/elfin/entity/GameSwitchInfo;->Path:Ljava/lang/String;

    iget-object v1, p0, Lcom/cyjh/elfin/fragment/RecommendGamesFragment;->gameLink:Ljava/lang/String;

    invoke-virtual {v0, v1}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v0

    if-nez v0, :cond_0

    .line 110
    iget-object v0, p0, Lcom/cyjh/elfin/fragment/RecommendGamesFragment;->appContext:Lcom/cyjh/elfin/AppContext;

    iget-object v0, v0, Lcom/cyjh/elfin/AppContext;->mSharePre:Landroid/content/SharedPreferences;

    invoke-interface {v0}, Landroid/content/SharedPreferences;->edit()Landroid/content/SharedPreferences$Editor;

    move-result-object v0

    const-string v1, "recommend_games_link"

    iget-object v2, p0, Lcom/cyjh/elfin/fragment/RecommendGamesFragment;->gameLink:Ljava/lang/String;

    invoke-interface {v0, v1, v2}, Landroid/content/SharedPreferences$Editor;->putString(Ljava/lang/String;Ljava/lang/String;)Landroid/content/SharedPreferences$Editor;

    move-result-object v0

    invoke-interface {v0}, Landroid/content/SharedPreferences$Editor;->apply()V

    .line 115
    :cond_0
    :goto_0
    return-void

    .line 113
    :cond_1
    iget-object v0, p0, Lcom/cyjh/elfin/fragment/RecommendGamesFragment;->mWebView:Landroid/webkit/WebView;

    const/16 v1, 0x8

    invoke-virtual {v0, v1}, Landroid/webkit/WebView;->setVisibility(I)V

    goto :goto_0
.end method

.method public getFragmentLayoutId()I
    .locals 1

    .prologue
    .line 47
    const v0, 0x7f04004c

    return v0
.end method

.method public onActivityCreated(Landroid/os/Bundle;)V
    .locals 1
    .param p1, "savedInstanceState"    # Landroid/os/Bundle;

    .prologue
    .line 72
    invoke-super {p0, p1}, Lcom/cyjh/elfin/fragment/BaseFragement;->onActivityCreated(Landroid/os/Bundle;)V

    .line 74
    invoke-virtual {p0}, Lcom/cyjh/elfin/fragment/RecommendGamesFragment;->getActivity()Landroid/support/v4/app/FragmentActivity;

    move-result-object v0

    invoke-static {v0}, Lcom/cyjh/elfin/download/DownloadCountOpera;->requestEntranceGameCount(Landroid/content/Context;)V

    .line 75
    new-instance v0, Lcom/cyjh/elfin/mvp/presenters/RecommendGamesPresenter;

    invoke-direct {v0, p0}, Lcom/cyjh/elfin/mvp/presenters/RecommendGamesPresenter;-><init>(Lcom/cyjh/elfin/mvp/views/RecommendGamesView;)V

    iput-object v0, p0, Lcom/cyjh/elfin/fragment/RecommendGamesFragment;->reCommendGamesPresenter:Lcom/cyjh/elfin/mvp/presenters/RecommendGamesPresenter;

    .line 76
    return-void
.end method

.method public onCreate(Landroid/os/Bundle;)V
    .locals 3
    .param p1, "savedInstanceState"    # Landroid/os/Bundle;

    .prologue
    .line 52
    invoke-super {p0, p1}, Lcom/cyjh/elfin/fragment/BaseFragement;->onCreate(Landroid/os/Bundle;)V

    .line 53
    invoke-virtual {p0}, Lcom/cyjh/elfin/fragment/RecommendGamesFragment;->getArguments()Landroid/os/Bundle;

    move-result-object v0

    if-eqz v0, :cond_0

    .line 54
    invoke-virtual {p0}, Lcom/cyjh/elfin/fragment/RecommendGamesFragment;->getArguments()Landroid/os/Bundle;

    move-result-object v0

    const-class v1, Lcom/cyjh/elfin/fragment/RecommendGamesFragment;

    invoke-virtual {v1}, Ljava/lang/Class;->getCanonicalName()Ljava/lang/String;

    move-result-object v1

    invoke-virtual {v0, v1}, Landroid/os/Bundle;->getString(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v0

    iput-object v0, p0, Lcom/cyjh/elfin/fragment/RecommendGamesFragment;->gameLink:Ljava/lang/String;

    .line 55
    invoke-virtual {p0}, Lcom/cyjh/elfin/fragment/RecommendGamesFragment;->getActivity()Landroid/support/v4/app/FragmentActivity;

    move-result-object v0

    invoke-virtual {v0}, Landroid/support/v4/app/FragmentActivity;->getApplicationContext()Landroid/content/Context;

    move-result-object v0

    check-cast v0, Lcom/cyjh/elfin/AppContext;

    iput-object v0, p0, Lcom/cyjh/elfin/fragment/RecommendGamesFragment;->appContext:Lcom/cyjh/elfin/AppContext;

    .line 56
    iget-object v0, p0, Lcom/cyjh/elfin/fragment/RecommendGamesFragment;->appContext:Lcom/cyjh/elfin/AppContext;

    iget-object v0, v0, Lcom/cyjh/elfin/AppContext;->mSharePre:Landroid/content/SharedPreferences;

    invoke-interface {v0}, Landroid/content/SharedPreferences;->edit()Landroid/content/SharedPreferences$Editor;

    move-result-object v0

    const-string v1, "recommend_games_link"

    iget-object v2, p0, Lcom/cyjh/elfin/fragment/RecommendGamesFragment;->gameLink:Ljava/lang/String;

    invoke-interface {v0, v1, v2}, Landroid/content/SharedPreferences$Editor;->putString(Ljava/lang/String;Ljava/lang/String;)Landroid/content/SharedPreferences$Editor;

    move-result-object v0

    invoke-interface {v0}, Landroid/content/SharedPreferences$Editor;->apply()V

    .line 57
    iget-object v0, p0, Lcom/cyjh/elfin/fragment/RecommendGamesFragment;->commonLog:Lcom/cyjh/elfin/log/CommonLog;

    new-instance v1, Ljava/lang/StringBuilder;

    invoke-direct {v1}, Ljava/lang/StringBuilder;-><init>()V

    const-string v2, " RecommendGamesFragment \u94fe\u63a5="

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    iget-object v2, p0, Lcom/cyjh/elfin/fragment/RecommendGamesFragment;->gameLink:Ljava/lang/String;

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v1

    invoke-virtual {v0, v1}, Lcom/cyjh/elfin/log/CommonLog;->e(Ljava/lang/Object;)V

    .line 59
    :cond_0
    invoke-static {}, Lorg/greenrobot/eventbus/EventBus;->getDefault()Lorg/greenrobot/eventbus/EventBus;

    move-result-object v0

    invoke-virtual {v0, p0}, Lorg/greenrobot/eventbus/EventBus;->register(Ljava/lang/Object;)V

    .line 60
    return-void
.end method

.method public onDestroy()V
    .locals 2

    .prologue
    .line 148
    invoke-super {p0}, Lcom/cyjh/elfin/fragment/BaseFragement;->onDestroy()V

    .line 149
    invoke-static {}, Lorg/greenrobot/eventbus/EventBus;->getDefault()Lorg/greenrobot/eventbus/EventBus;

    move-result-object v0

    invoke-virtual {v0, p0}, Lorg/greenrobot/eventbus/EventBus;->unregister(Ljava/lang/Object;)V

    .line 150
    invoke-static {}, Lcom/cyjh/elfin/net/volley/VolleyManager;->cancelAllReq()V

    .line 151
    iget-object v0, p0, Lcom/cyjh/elfin/fragment/RecommendGamesFragment;->mWebView:Landroid/webkit/WebView;

    if-eqz v0, :cond_0

    .line 152
    iget-object v0, p0, Lcom/cyjh/elfin/fragment/RecommendGamesFragment;->mRootLayout:Landroid/widget/LinearLayout;

    iget-object v1, p0, Lcom/cyjh/elfin/fragment/RecommendGamesFragment;->mWebView:Landroid/webkit/WebView;

    invoke-virtual {v0, v1}, Landroid/widget/LinearLayout;->removeView(Landroid/view/View;)V

    .line 153
    iget-object v0, p0, Lcom/cyjh/elfin/fragment/RecommendGamesFragment;->mWebView:Landroid/webkit/WebView;

    invoke-virtual {v0}, Landroid/webkit/WebView;->removeAllViews()V

    .line 154
    iget-object v0, p0, Lcom/cyjh/elfin/fragment/RecommendGamesFragment;->mWebView:Landroid/webkit/WebView;

    invoke-virtual {v0}, Landroid/webkit/WebView;->destroy()V

    .line 155
    const/4 v0, 0x0

    iput-object v0, p0, Lcom/cyjh/elfin/fragment/RecommendGamesFragment;->mWebView:Landroid/webkit/WebView;

    .line 157
    :cond_0
    return-void
.end method

.method public onMessageByMainThread(Lcom/cyjh/elfin/entity/MsgItem;)V
    .locals 4
    .param p1, "msgItem"    # Lcom/cyjh/elfin/entity/MsgItem;
    .annotation runtime Lorg/greenrobot/eventbus/Subscribe;
        threadMode = .enum Lorg/greenrobot/eventbus/ThreadMode;->MAIN:Lorg/greenrobot/eventbus/ThreadMode;
    .end annotation

    .prologue
    .line 161
    if-eqz p1, :cond_0

    .line 162
    invoke-virtual {p1}, Lcom/cyjh/elfin/entity/MsgItem;->getMsgType()I

    move-result v0

    .line 163
    .local v0, "itemType":I
    iget-object v1, p0, Lcom/cyjh/elfin/fragment/RecommendGamesFragment;->commonLog:Lcom/cyjh/elfin/log/CommonLog;

    new-instance v2, Ljava/lang/StringBuilder;

    invoke-direct {v2}, Ljava/lang/StringBuilder;-><init>()V

    const-string v3, "itemType="

    invoke-virtual {v2, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    invoke-virtual {v2, v0}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v2

    invoke-virtual {v2}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v2

    invoke-virtual {v1, v2}, Lcom/cyjh/elfin/log/CommonLog;->e(Ljava/lang/Object;)V

    .line 164
    sparse-switch v0, :sswitch_data_0

    .line 174
    .end local v0    # "itemType":I
    :cond_0
    :goto_0
    return-void

    .line 166
    .restart local v0    # "itemType":I
    :sswitch_0
    iget-object v1, p0, Lcom/cyjh/elfin/fragment/RecommendGamesFragment;->reCommendGamesPresenter:Lcom/cyjh/elfin/mvp/presenters/RecommendGamesPresenter;

    invoke-virtual {p0}, Lcom/cyjh/elfin/fragment/RecommendGamesFragment;->getActivity()Landroid/support/v4/app/FragmentActivity;

    move-result-object v2

    invoke-virtual {v1, v2}, Lcom/cyjh/elfin/mvp/presenters/RecommendGamesPresenter;->gameJumpSwitch(Landroid/content/Context;)V

    goto :goto_0

    .line 169
    :sswitch_1
    const/4 v1, 0x0

    iput-boolean v1, p0, Lcom/cyjh/elfin/fragment/RecommendGamesFragment;->isDownloadSuc:Z

    .line 170
    iget-object v1, p0, Lcom/cyjh/elfin/fragment/RecommendGamesFragment;->commonLog:Lcom/cyjh/elfin/log/CommonLog;

    new-instance v2, Ljava/lang/StringBuilder;

    invoke-direct {v2}, Ljava/lang/StringBuilder;-><init>()V

    const-string v3, "\u63a8\u8350\u6e38\u620fapk\u4e0b\u8f7d:"

    invoke-virtual {v2, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    iget-boolean v3, p0, Lcom/cyjh/elfin/fragment/RecommendGamesFragment;->isDownloadSuc:Z

    invoke-virtual {v2, v3}, Ljava/lang/StringBuilder;->append(Z)Ljava/lang/StringBuilder;

    move-result-object v2

    invoke-virtual {v2}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v2

    invoke-virtual {v1, v2}, Lcom/cyjh/elfin/log/CommonLog;->e(Ljava/lang/Object;)V

    goto :goto_0

    .line 164
    :sswitch_data_0
    .sparse-switch
        0x3ec -> :sswitch_0
        0x3f2 -> :sswitch_1
    .end sparse-switch
.end method

.method public onPause()V
    .locals 1

    .prologue
    .line 178
    invoke-super {p0}, Lcom/cyjh/elfin/fragment/BaseFragement;->onPause()V

    .line 179
    const-class v0, Lcom/cyjh/elfin/fragment/RecommendGamesFragment;

    invoke-virtual {v0}, Ljava/lang/Class;->getCanonicalName()Ljava/lang/String;

    move-result-object v0

    invoke-static {v0}, Lcom/umeng/analytics/MobclickAgent;->onPageEnd(Ljava/lang/String;)V

    .line 180
    return-void
.end method

.method public onResume()V
    .locals 1

    .prologue
    .line 184
    invoke-super {p0}, Lcom/cyjh/elfin/fragment/BaseFragement;->onResume()V

    .line 185
    const-class v0, Lcom/cyjh/elfin/fragment/RecommendGamesFragment;

    invoke-virtual {v0}, Ljava/lang/Class;->getCanonicalName()Ljava/lang/String;

    move-result-object v0

    invoke-static {v0}, Lcom/umeng/analytics/MobclickAgent;->onPageStart(Ljava/lang/String;)V

    .line 186
    return-void
.end method

.method public onViewCreated(Landroid/view/View;Landroid/os/Bundle;)V
    .locals 0
    .param p1, "view"    # Landroid/view/View;
    .param p2, "savedInstanceState"    # Landroid/os/Bundle;

    .prologue
    .line 80
    invoke-super {p0, p1, p2}, Lcom/cyjh/elfin/fragment/BaseFragement;->onViewCreated(Landroid/view/View;Landroid/os/Bundle;)V

    .line 81
    invoke-direct {p0, p1}, Lcom/cyjh/elfin/fragment/RecommendGamesFragment;->initView(Landroid/view/View;)V

    .line 82
    return-void
.end method
