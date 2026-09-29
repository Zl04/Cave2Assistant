.class public Lcom/cyjh/elfin/fragment/MsgDetailFragment;
.super Lcom/cyjh/elfin/fragment/BaseFragement;
.source "MsgDetailFragment.java"


# instance fields
.field private mTvMsgTime:Landroid/widget/TextView;

.field private mTvMsgTitle:Landroid/widget/TextView;

.field private mWebViewMsgContent:Landroid/webkit/WebView;

.field private notifyMsgBean:Lcom/cyjh/elfin/entity/NotifyMsgBean;


# direct methods
.method public constructor <init>()V
    .locals 0

    .prologue
    .line 17
    invoke-direct {p0}, Lcom/cyjh/elfin/fragment/BaseFragement;-><init>()V

    return-void
.end method

.method private initFillData()V
    .locals 6

    .prologue
    const/4 v1, 0x0

    .line 59
    iget-object v0, p0, Lcom/cyjh/elfin/fragment/MsgDetailFragment;->mTvMsgTitle:Landroid/widget/TextView;

    iget-object v2, p0, Lcom/cyjh/elfin/fragment/MsgDetailFragment;->notifyMsgBean:Lcom/cyjh/elfin/entity/NotifyMsgBean;

    iget-object v2, v2, Lcom/cyjh/elfin/entity/NotifyMsgBean;->NoticeTitle:Ljava/lang/String;

    invoke-virtual {v0, v2}, Landroid/widget/TextView;->setText(Ljava/lang/CharSequence;)V

    .line 60
    iget-object v0, p0, Lcom/cyjh/elfin/fragment/MsgDetailFragment;->mTvMsgTime:Landroid/widget/TextView;

    iget-object v2, p0, Lcom/cyjh/elfin/fragment/MsgDetailFragment;->notifyMsgBean:Lcom/cyjh/elfin/entity/NotifyMsgBean;

    iget-object v2, v2, Lcom/cyjh/elfin/entity/NotifyMsgBean;->NoticeTime:Ljava/lang/String;

    invoke-virtual {v0, v2}, Landroid/widget/TextView;->setText(Ljava/lang/CharSequence;)V

    .line 61
    iget-object v0, p0, Lcom/cyjh/elfin/fragment/MsgDetailFragment;->mWebViewMsgContent:Landroid/webkit/WebView;

    iget-object v2, p0, Lcom/cyjh/elfin/fragment/MsgDetailFragment;->notifyMsgBean:Lcom/cyjh/elfin/entity/NotifyMsgBean;

    iget-object v2, v2, Lcom/cyjh/elfin/entity/NotifyMsgBean;->NoticeContent:Ljava/lang/String;

    const-string v3, "text/html"

    const-string v4, "utf-8"

    move-object v5, v1

    invoke-virtual/range {v0 .. v5}, Landroid/webkit/WebView;->loadDataWithBaseURL(Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;)V

    .line 62
    iget-object v0, p0, Lcom/cyjh/elfin/fragment/MsgDetailFragment;->mWebViewMsgContent:Landroid/webkit/WebView;

    invoke-virtual {v0}, Landroid/webkit/WebView;->getSettings()Landroid/webkit/WebSettings;

    move-result-object v0

    const/4 v1, 0x1

    invoke-virtual {v0, v1}, Landroid/webkit/WebSettings;->setJavaScriptEnabled(Z)V

    .line 63
    iget-object v0, p0, Lcom/cyjh/elfin/fragment/MsgDetailFragment;->mWebViewMsgContent:Landroid/webkit/WebView;

    new-instance v1, Landroid/webkit/WebChromeClient;

    invoke-direct {v1}, Landroid/webkit/WebChromeClient;-><init>()V

    invoke-virtual {v0, v1}, Landroid/webkit/WebView;->setWebChromeClient(Landroid/webkit/WebChromeClient;)V

    .line 64
    return-void
.end method

.method private initView(Landroid/view/View;)V
    .locals 1
    .param p1, "view"    # Landroid/view/View;

    .prologue
    .line 67
    const v0, 0x7f0f0095

    invoke-virtual {p1, v0}, Landroid/view/View;->findViewById(I)Landroid/view/View;

    move-result-object v0

    check-cast v0, Landroid/widget/TextView;

    iput-object v0, p0, Lcom/cyjh/elfin/fragment/MsgDetailFragment;->mTvMsgTitle:Landroid/widget/TextView;

    .line 68
    const v0, 0x7f0f0096

    invoke-virtual {p1, v0}, Landroid/view/View;->findViewById(I)Landroid/view/View;

    move-result-object v0

    check-cast v0, Landroid/widget/TextView;

    iput-object v0, p0, Lcom/cyjh/elfin/fragment/MsgDetailFragment;->mTvMsgTime:Landroid/widget/TextView;

    .line 69
    const v0, 0x7f0f0103

    invoke-virtual {p1, v0}, Landroid/view/View;->findViewById(I)Landroid/view/View;

    move-result-object v0

    check-cast v0, Landroid/webkit/WebView;

    iput-object v0, p0, Lcom/cyjh/elfin/fragment/MsgDetailFragment;->mWebViewMsgContent:Landroid/webkit/WebView;

    .line 70
    return-void
.end method

.method public static newInstance(Lcom/cyjh/elfin/entity/NotifyMsgBean;)Lcom/cyjh/elfin/fragment/MsgDetailFragment;
    .locals 3
    .param p0, "notifyMsgBean"    # Lcom/cyjh/elfin/entity/NotifyMsgBean;

    .prologue
    .line 33
    new-instance v1, Lcom/cyjh/elfin/fragment/MsgDetailFragment;

    invoke-direct {v1}, Lcom/cyjh/elfin/fragment/MsgDetailFragment;-><init>()V

    .line 34
    .local v1, "msgDetailFragment":Lcom/cyjh/elfin/fragment/MsgDetailFragment;
    new-instance v0, Landroid/os/Bundle;

    invoke-direct {v0}, Landroid/os/Bundle;-><init>()V

    .line 35
    .local v0, "bundle":Landroid/os/Bundle;
    const-class v2, Lcom/cyjh/elfin/fragment/MsgDetailFragment;

    invoke-virtual {v2}, Ljava/lang/Class;->getCanonicalName()Ljava/lang/String;

    move-result-object v2

    invoke-virtual {v0, v2, p0}, Landroid/os/Bundle;->putParcelable(Ljava/lang/String;Landroid/os/Parcelable;)V

    .line 36
    invoke-virtual {v1, v0}, Lcom/cyjh/elfin/fragment/MsgDetailFragment;->setArguments(Landroid/os/Bundle;)V

    .line 37
    return-object v1
.end method


# virtual methods
.method public getFragmentLayoutId()I
    .locals 1

    .prologue
    .line 24
    const v0, 0x7f040049

    return v0
.end method

.method public onCreate(Landroid/os/Bundle;)V
    .locals 3
    .param p1, "savedInstanceState"    # Landroid/os/Bundle;

    .prologue
    .line 42
    invoke-super {p0, p1}, Lcom/cyjh/elfin/fragment/BaseFragement;->onCreate(Landroid/os/Bundle;)V

    .line 43
    invoke-virtual {p0}, Lcom/cyjh/elfin/fragment/MsgDetailFragment;->getArguments()Landroid/os/Bundle;

    move-result-object v1

    if-eqz v1, :cond_0

    .line 44
    invoke-virtual {p0}, Lcom/cyjh/elfin/fragment/MsgDetailFragment;->getArguments()Landroid/os/Bundle;

    move-result-object v0

    .line 45
    .local v0, "bundle":Landroid/os/Bundle;
    const-class v1, Lcom/cyjh/elfin/fragment/MsgDetailFragment;

    invoke-virtual {v1}, Ljava/lang/Class;->getCanonicalName()Ljava/lang/String;

    move-result-object v1

    invoke-virtual {v0, v1}, Landroid/os/Bundle;->getParcelable(Ljava/lang/String;)Landroid/os/Parcelable;

    move-result-object v1

    check-cast v1, Lcom/cyjh/elfin/entity/NotifyMsgBean;

    iput-object v1, p0, Lcom/cyjh/elfin/fragment/MsgDetailFragment;->notifyMsgBean:Lcom/cyjh/elfin/entity/NotifyMsgBean;

    .line 46
    new-instance v1, Ljava/lang/StringBuilder;

    invoke-direct {v1}, Ljava/lang/StringBuilder;-><init>()V

    const-string v2, "notify\uff1b"

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    iget-object v2, p0, Lcom/cyjh/elfin/fragment/MsgDetailFragment;->notifyMsgBean:Lcom/cyjh/elfin/entity/NotifyMsgBean;

    invoke-virtual {v2}, Lcom/cyjh/elfin/entity/NotifyMsgBean;->toString()Ljava/lang/String;

    move-result-object v2

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v1

    const/4 v2, 0x0

    new-array v2, v2, [Ljava/lang/Object;

    invoke-static {v1, v2}, Lcom/orhanobut/logger/Logger;->e(Ljava/lang/String;[Ljava/lang/Object;)V

    .line 48
    .end local v0    # "bundle":Landroid/os/Bundle;
    :cond_0
    return-void
.end method

.method public onPause()V
    .locals 1

    .prologue
    .line 80
    invoke-super {p0}, Lcom/cyjh/elfin/fragment/BaseFragement;->onPause()V

    .line 81
    const-class v0, Lcom/cyjh/elfin/fragment/MsgDetailFragment;

    invoke-virtual {v0}, Ljava/lang/Class;->getCanonicalName()Ljava/lang/String;

    move-result-object v0

    invoke-static {v0}, Lcom/umeng/analytics/MobclickAgent;->onPageEnd(Ljava/lang/String;)V

    .line 82
    return-void
.end method

.method public onResume()V
    .locals 1

    .prologue
    .line 74
    invoke-super {p0}, Lcom/cyjh/elfin/fragment/BaseFragement;->onResume()V

    .line 75
    const-class v0, Lcom/cyjh/elfin/fragment/MsgDetailFragment;

    invoke-virtual {v0}, Ljava/lang/Class;->getCanonicalName()Ljava/lang/String;

    move-result-object v0

    invoke-static {v0}, Lcom/umeng/analytics/MobclickAgent;->onPageStart(Ljava/lang/String;)V

    .line 76
    return-void
.end method

.method public onViewCreated(Landroid/view/View;Landroid/os/Bundle;)V
    .locals 0
    .param p1, "view"    # Landroid/view/View;
    .param p2, "savedInstanceState"    # Landroid/os/Bundle;

    .prologue
    .line 52
    invoke-super {p0, p1, p2}, Lcom/cyjh/elfin/fragment/BaseFragement;->onViewCreated(Landroid/view/View;Landroid/os/Bundle;)V

    .line 53
    invoke-direct {p0, p1}, Lcom/cyjh/elfin/fragment/MsgDetailFragment;->initView(Landroid/view/View;)V

    .line 54
    invoke-direct {p0}, Lcom/cyjh/elfin/fragment/MsgDetailFragment;->initFillData()V

    .line 55
    return-void
.end method
