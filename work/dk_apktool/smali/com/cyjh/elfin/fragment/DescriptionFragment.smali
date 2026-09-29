.class public Lcom/cyjh/elfin/fragment/DescriptionFragment;
.super Lcom/cyjh/elfin/fragment/BaseFragement;
.source "DescriptionFragment.java"


# instance fields
.field private scrollView:Landroid/widget/ScrollView;

.field private tvDescription:Landroid/widget/TextView;

.field private webView:Landroid/webkit/WebView;


# direct methods
.method public constructor <init>()V
    .locals 0

    .prologue
    .line 30
    invoke-direct {p0}, Lcom/cyjh/elfin/fragment/BaseFragement;-><init>()V

    return-void
.end method

.method private initView()V
    .locals 7

    .prologue
    const/16 v6, 0x8

    const/4 v5, 0x0

    .line 62
    invoke-virtual {p0}, Lcom/cyjh/elfin/fragment/DescriptionFragment;->getView()Landroid/view/View;

    move-result-object v3

    if-nez v3, :cond_0

    .line 85
    :goto_0
    return-void

    .line 65
    :cond_0
    invoke-virtual {p0}, Lcom/cyjh/elfin/fragment/DescriptionFragment;->getView()Landroid/view/View;

    move-result-object v2

    .line 66
    .local v2, "viewParent":Landroid/view/View;
    const v3, 0x7f0f010d

    invoke-virtual {v2, v3}, Landroid/view/View;->findViewById(I)Landroid/view/View;

    move-result-object v3

    check-cast v3, Landroid/widget/ScrollView;

    iput-object v3, p0, Lcom/cyjh/elfin/fragment/DescriptionFragment;->scrollView:Landroid/widget/ScrollView;

    .line 67
    const v3, 0x7f0f010f

    invoke-virtual {v2, v3}, Landroid/view/View;->findViewById(I)Landroid/view/View;

    move-result-object v3

    check-cast v3, Landroid/webkit/WebView;

    iput-object v3, p0, Lcom/cyjh/elfin/fragment/DescriptionFragment;->webView:Landroid/webkit/WebView;

    .line 68
    const v3, 0x7f0f010e

    invoke-virtual {v2, v3}, Landroid/view/View;->findViewById(I)Landroid/view/View;

    move-result-object v3

    check-cast v3, Landroid/widget/TextView;

    iput-object v3, p0, Lcom/cyjh/elfin/fragment/DescriptionFragment;->tvDescription:Landroid/widget/TextView;

    .line 70
    iget-object v3, p0, Lcom/cyjh/elfin/fragment/DescriptionFragment;->webView:Landroid/webkit/WebView;

    invoke-virtual {v3}, Landroid/webkit/WebView;->getSettings()Landroid/webkit/WebSettings;

    move-result-object v3

    const/4 v4, 0x1

    invoke-virtual {v3, v4}, Landroid/webkit/WebSettings;->setJavaScriptEnabled(Z)V

    .line 72
    :try_start_0
    iget-object v3, p0, Lcom/cyjh/elfin/fragment/DescriptionFragment;->appContext:Lcom/cyjh/elfin/AppContext;

    invoke-virtual {v3}, Lcom/cyjh/elfin/AppContext;->getAssets()Landroid/content/res/AssetManager;

    move-result-object v3

    const-string v4, "script.rtd"

    invoke-virtual {v3, v4}, Landroid/content/res/AssetManager;->open(Ljava/lang/String;)Ljava/io/InputStream;

    .line 73
    iget-object v3, p0, Lcom/cyjh/elfin/fragment/DescriptionFragment;->webView:Landroid/webkit/WebView;

    const/4 v4, 0x0

    invoke-virtual {v3, v4}, Landroid/webkit/WebView;->setVisibility(I)V

    .line 74
    iget-object v3, p0, Lcom/cyjh/elfin/fragment/DescriptionFragment;->scrollView:Landroid/widget/ScrollView;

    const/16 v4, 0x8

    invoke-virtual {v3, v4}, Landroid/widget/ScrollView;->setVisibility(I)V

    .line 75
    const-string v0, "file:///android_asset/script.rtd"

    .line 76
    .local v0, "Url":Ljava/lang/String;
    iget-object v3, p0, Lcom/cyjh/elfin/fragment/DescriptionFragment;->commonLog:Lcom/cyjh/elfin/log/CommonLog;

    invoke-virtual {v3, v0}, Lcom/cyjh/elfin/log/CommonLog;->e(Ljava/lang/Object;)V

    .line 77
    iget-object v3, p0, Lcom/cyjh/elfin/fragment/DescriptionFragment;->webView:Landroid/webkit/WebView;

    invoke-virtual {v3, v0}, Landroid/webkit/WebView;->loadUrl(Ljava/lang/String;)V
    :try_end_0
    .catch Ljava/io/IOException; {:try_start_0 .. :try_end_0} :catch_0

    goto :goto_0

    .line 78
    .end local v0    # "Url":Ljava/lang/String;
    :catch_0
    move-exception v1

    .line 80
    .local v1, "e":Ljava/io/IOException;
    iget-object v3, p0, Lcom/cyjh/elfin/fragment/DescriptionFragment;->scrollView:Landroid/widget/ScrollView;

    invoke-virtual {v3, v5}, Landroid/widget/ScrollView;->setVisibility(I)V

    .line 81
    iget-object v3, p0, Lcom/cyjh/elfin/fragment/DescriptionFragment;->webView:Landroid/webkit/WebView;

    invoke-virtual {v3, v6}, Landroid/webkit/WebView;->setVisibility(I)V

    goto :goto_0
.end method


# virtual methods
.method public getFragmentLayoutId()I
    .locals 1

    .prologue
    .line 51
    const v0, 0x7f04004d

    return v0
.end method

.method public onActivityCreated(Landroid/os/Bundle;)V
    .locals 0
    .param p1, "savedInstanceState"    # Landroid/os/Bundle;

    .prologue
    .line 44
    invoke-super {p0, p1}, Lcom/cyjh/elfin/fragment/BaseFragement;->onActivityCreated(Landroid/os/Bundle;)V

    .line 45
    invoke-direct {p0}, Lcom/cyjh/elfin/fragment/DescriptionFragment;->initView()V

    .line 47
    return-void
.end method

.method public onPause()V
    .locals 1

    .prologue
    .line 95
    invoke-super {p0}, Lcom/cyjh/elfin/fragment/BaseFragement;->onPause()V

    .line 96
    const-class v0, Lcom/cyjh/elfin/fragment/DescriptionFragment;

    invoke-virtual {v0}, Ljava/lang/Class;->getCanonicalName()Ljava/lang/String;

    move-result-object v0

    invoke-static {v0}, Lcom/umeng/analytics/MobclickAgent;->onPageEnd(Ljava/lang/String;)V

    .line 97
    return-void
.end method

.method public onResume()V
    .locals 1

    .prologue
    .line 89
    invoke-super {p0}, Lcom/cyjh/elfin/fragment/BaseFragement;->onResume()V

    .line 90
    const-class v0, Lcom/cyjh/elfin/fragment/DescriptionFragment;

    invoke-virtual {v0}, Ljava/lang/Class;->getCanonicalName()Ljava/lang/String;

    move-result-object v0

    invoke-static {v0}, Lcom/umeng/analytics/MobclickAgent;->onPageStart(Ljava/lang/String;)V

    .line 91
    return-void
.end method

.method public onSaveInstanceState(Landroid/os/Bundle;)V
    .locals 1
    .param p1, "outState"    # Landroid/os/Bundle;

    .prologue
    .line 38
    invoke-super {p0, p1}, Lcom/cyjh/elfin/fragment/BaseFragement;->onSaveInstanceState(Landroid/os/Bundle;)V

    .line 39
    const/4 v0, 0x1

    invoke-virtual {p0, v0}, Lcom/cyjh/elfin/fragment/DescriptionFragment;->setUserVisibleHint(Z)V

    .line 40
    return-void
.end method
