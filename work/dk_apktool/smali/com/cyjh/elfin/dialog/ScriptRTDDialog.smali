.class public Lcom/cyjh/elfin/dialog/ScriptRTDDialog;
.super Lcom/cyjh/elfin/dialog/BaseDialog;
.source "ScriptRTDDialog.java"


# instance fields
.field private mTextvViewNoRtd:Landroid/widget/TextView;

.field private mWebView:Landroid/webkit/WebView;


# direct methods
.method public constructor <init>(Landroid/content/Context;)V
    .locals 2
    .param p1, "context"    # Landroid/content/Context;

    .prologue
    .line 21
    const v0, 0x7f0a00f8

    invoke-direct {p0, p1, v0}, Lcom/cyjh/elfin/dialog/BaseDialog;-><init>(Landroid/content/Context;I)V

    .line 22
    sget v0, Landroid/os/Build$VERSION;->SDK_INT:I

    const/16 v1, 0x13

    if-lt v0, v1, :cond_0

    sget v0, Landroid/os/Build$VERSION;->SDK_INT:I

    const/16 v1, 0x18

    if-ge v0, v1, :cond_0

    .line 24
    invoke-virtual {p0}, Lcom/cyjh/elfin/dialog/ScriptRTDDialog;->getWindow()Landroid/view/Window;

    move-result-object v0

    const/16 v1, 0x7d5

    invoke-virtual {v0, v1}, Landroid/view/Window;->setType(I)V

    .line 29
    :goto_0
    return-void

    .line 27
    :cond_0
    invoke-virtual {p0}, Lcom/cyjh/elfin/dialog/ScriptRTDDialog;->getWindow()Landroid/view/Window;

    move-result-object v0

    const/16 v1, 0x7d2

    invoke-virtual {v0, v1}, Landroid/view/Window;->setType(I)V

    goto :goto_0
.end method

.method static synthetic access$000(Lcom/cyjh/elfin/dialog/ScriptRTDDialog;FF)V
    .locals 0
    .param p0, "x0"    # Lcom/cyjh/elfin/dialog/ScriptRTDDialog;
    .param p1, "x1"    # F
    .param p2, "x2"    # F

    .prologue
    .line 15
    invoke-direct {p0, p1, p2}, Lcom/cyjh/elfin/dialog/ScriptRTDDialog;->convertScreen(FF)V

    return-void
.end method

.method private convertScreen(FF)V
    .locals 4
    .param p1, "width"    # F
    .param p2, "height"    # F

    .prologue
    .line 64
    invoke-virtual {p0}, Lcom/cyjh/elfin/dialog/ScriptRTDDialog;->isShowing()Z

    move-result v0

    if-eqz v0, :cond_0

    .line 65
    invoke-virtual {p0}, Lcom/cyjh/elfin/dialog/ScriptRTDDialog;->dismiss()V

    .line 66
    new-instance v0, Landroid/os/Handler;

    invoke-direct {v0}, Landroid/os/Handler;-><init>()V

    new-instance v1, Lcom/cyjh/elfin/dialog/ScriptRTDDialog$2;

    invoke-direct {v1, p0, p1, p2}, Lcom/cyjh/elfin/dialog/ScriptRTDDialog$2;-><init>(Lcom/cyjh/elfin/dialog/ScriptRTDDialog;FF)V

    const-wide/16 v2, 0x1f4

    invoke-virtual {v0, v1, v2, v3}, Landroid/os/Handler;->postDelayed(Ljava/lang/Runnable;J)Z

    .line 74
    :cond_0
    return-void
.end method

.method private initEvent()V
    .locals 2

    .prologue
    .line 51
    iget-object v0, p0, Lcom/cyjh/elfin/dialog/ScriptRTDDialog;->mAppContext:Lcom/cyjh/elfin/AppContext;

    new-instance v1, Lcom/cyjh/elfin/dialog/ScriptRTDDialog$1;

    invoke-direct {v1, p0}, Lcom/cyjh/elfin/dialog/ScriptRTDDialog$1;-><init>(Lcom/cyjh/elfin/dialog/ScriptRTDDialog;)V

    invoke-virtual {v0, v1}, Lcom/cyjh/elfin/AppContext;->setScreenConversion(Lcom/cyjh/elfin/AppContext$ScreenOrientationConversion;)V

    .line 61
    return-void
.end method

.method private initView()V
    .locals 0

    .prologue
    .line 47
    invoke-direct {p0}, Lcom/cyjh/elfin/dialog/ScriptRTDDialog;->initWebView()V

    .line 48
    return-void
.end method

.method private initWebView()V
    .locals 4

    .prologue
    .line 77
    const v2, 0x7f0f00c5

    invoke-virtual {p0, v2}, Lcom/cyjh/elfin/dialog/ScriptRTDDialog;->findViewById(I)Landroid/view/View;

    move-result-object v2

    check-cast v2, Landroid/widget/TextView;

    iput-object v2, p0, Lcom/cyjh/elfin/dialog/ScriptRTDDialog;->mTextvViewNoRtd:Landroid/widget/TextView;

    .line 78
    const v2, 0x7f0f00c6

    invoke-virtual {p0, v2}, Lcom/cyjh/elfin/dialog/ScriptRTDDialog;->findViewById(I)Landroid/view/View;

    move-result-object v2

    check-cast v2, Landroid/webkit/WebView;

    iput-object v2, p0, Lcom/cyjh/elfin/dialog/ScriptRTDDialog;->mWebView:Landroid/webkit/WebView;

    .line 79
    iget-object v2, p0, Lcom/cyjh/elfin/dialog/ScriptRTDDialog;->mWebView:Landroid/webkit/WebView;

    invoke-virtual {v2}, Landroid/webkit/WebView;->getSettings()Landroid/webkit/WebSettings;

    move-result-object v2

    const/4 v3, 0x1

    invoke-virtual {v2, v3}, Landroid/webkit/WebSettings;->setJavaScriptEnabled(Z)V

    .line 81
    :try_start_0
    iget-object v2, p0, Lcom/cyjh/elfin/dialog/ScriptRTDDialog;->mAppContext:Lcom/cyjh/elfin/AppContext;

    invoke-virtual {v2}, Lcom/cyjh/elfin/AppContext;->getAssets()Landroid/content/res/AssetManager;

    move-result-object v2

    const-string v3, "script.rtd"

    invoke-virtual {v2, v3}, Landroid/content/res/AssetManager;->open(Ljava/lang/String;)Ljava/io/InputStream;

    .line 82
    const-string v0, "file:///android_asset/script.rtd"

    .line 83
    .local v0, "Url":Ljava/lang/String;
    iget-object v2, p0, Lcom/cyjh/elfin/dialog/ScriptRTDDialog;->mWebView:Landroid/webkit/WebView;

    invoke-virtual {v2, v0}, Landroid/webkit/WebView;->loadUrl(Ljava/lang/String;)V
    :try_end_0
    .catch Ljava/lang/Exception; {:try_start_0 .. :try_end_0} :catch_0

    .line 88
    .end local v0    # "Url":Ljava/lang/String;
    :goto_0
    return-void

    .line 84
    :catch_0
    move-exception v1

    .line 85
    .local v1, "e":Ljava/lang/Exception;
    iget-object v2, p0, Lcom/cyjh/elfin/dialog/ScriptRTDDialog;->mWebView:Landroid/webkit/WebView;

    const/16 v3, 0x8

    invoke-virtual {v2, v3}, Landroid/webkit/WebView;->setVisibility(I)V

    .line 86
    iget-object v2, p0, Lcom/cyjh/elfin/dialog/ScriptRTDDialog;->mTextvViewNoRtd:Landroid/widget/TextView;

    const/4 v3, 0x0

    invoke-virtual {v2, v3}, Landroid/widget/TextView;->setVisibility(I)V

    goto :goto_0
.end method


# virtual methods
.method protected onCreate(Landroid/os/Bundle;)V
    .locals 2
    .param p1, "savedInstanceState"    # Landroid/os/Bundle;

    .prologue
    const v1, 0x3f666666    # 0.9f

    .line 33
    invoke-super {p0, p1}, Lcom/cyjh/elfin/dialog/BaseDialog;->onCreate(Landroid/os/Bundle;)V

    .line 34
    const v0, 0x7f04003c

    invoke-virtual {p0, v0}, Lcom/cyjh/elfin/dialog/ScriptRTDDialog;->setContentView(I)V

    .line 35
    const v0, 0x3dcccccd    # 0.1f

    invoke-virtual {p0, v0}, Lcom/cyjh/elfin/dialog/ScriptRTDDialog;->setBlurEffect(F)V

    .line 36
    iget-object v0, p0, Lcom/cyjh/elfin/dialog/ScriptRTDDialog;->mAppContext:Lcom/cyjh/elfin/AppContext;

    iget-boolean v0, v0, Lcom/cyjh/elfin/AppContext;->checkedScreenOrientation:Z

    if-eqz v0, :cond_0

    .line 37
    const v0, 0x3f4ccccd    # 0.8f

    invoke-virtual {p0, v1, v0}, Lcom/cyjh/elfin/dialog/ScriptRTDDialog;->setDialogSize(FF)V

    .line 41
    :goto_0
    invoke-direct {p0}, Lcom/cyjh/elfin/dialog/ScriptRTDDialog;->initView()V

    .line 42
    invoke-direct {p0}, Lcom/cyjh/elfin/dialog/ScriptRTDDialog;->initEvent()V

    .line 43
    return-void

    .line 39
    :cond_0
    const v0, 0x3f19999a    # 0.6f

    invoke-virtual {p0, v1, v0}, Lcom/cyjh/elfin/dialog/ScriptRTDDialog;->setDialogSize(FF)V

    goto :goto_0
.end method
