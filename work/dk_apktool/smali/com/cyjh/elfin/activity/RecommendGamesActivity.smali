.class public Lcom/cyjh/elfin/activity/RecommendGamesActivity;
.super Lcom/cyjh/elfin/activity/BaseActivity;
.source "RecommendGamesActivity.java"


# annotations
.annotation system Ldalvik/annotation/MemberClasses;
    value = {
        Lcom/cyjh/elfin/activity/RecommendGamesActivity$OnRightTextViewOnClicker;,
        Lcom/cyjh/elfin/activity/RecommendGamesActivity$OnLeftBackListener;
    }
.end annotation


# instance fields
.field private isFirstEntry:Z

.field private mTitleView:Lcom/cyjh/elfin/customview/TitleView;


# direct methods
.method public constructor <init>()V
    .locals 0

    .prologue
    .line 22
    invoke-direct {p0}, Lcom/cyjh/elfin/activity/BaseActivity;-><init>()V

    return-void
.end method

.method static synthetic access$200(Lcom/cyjh/elfin/activity/RecommendGamesActivity;)V
    .locals 0
    .param p0, "x0"    # Lcom/cyjh/elfin/activity/RecommendGamesActivity;

    .prologue
    .line 22
    invoke-direct {p0}, Lcom/cyjh/elfin/activity/RecommendGamesActivity;->isStartActivity()V

    return-void
.end method

.method private initView(Ljava/lang/String;)V
    .locals 3
    .param p1, "name"    # Ljava/lang/String;

    .prologue
    const/4 v2, 0x0

    .line 47
    const v0, 0x7f0f006b

    invoke-virtual {p0, v0}, Lcom/cyjh/elfin/activity/RecommendGamesActivity;->findViewById(I)Landroid/view/View;

    move-result-object v0

    check-cast v0, Lcom/cyjh/elfin/customview/TitleView;

    iput-object v0, p0, Lcom/cyjh/elfin/activity/RecommendGamesActivity;->mTitleView:Lcom/cyjh/elfin/customview/TitleView;

    .line 48
    iget-object v0, p0, Lcom/cyjh/elfin/activity/RecommendGamesActivity;->mTitleView:Lcom/cyjh/elfin/customview/TitleView;

    invoke-virtual {v0, p1}, Lcom/cyjh/elfin/customview/TitleView;->setTitleText(Ljava/lang/String;)V

    .line 49
    iget-object v0, p0, Lcom/cyjh/elfin/activity/RecommendGamesActivity;->mTitleView:Lcom/cyjh/elfin/customview/TitleView;

    const v1, 0x7f080043

    invoke-virtual {p0, v1}, Lcom/cyjh/elfin/activity/RecommendGamesActivity;->getString(I)Ljava/lang/String;

    move-result-object v1

    invoke-virtual {v0, v1}, Lcom/cyjh/elfin/customview/TitleView;->setRightTvText(Ljava/lang/String;)V

    .line 50
    iget-object v0, p0, Lcom/cyjh/elfin/activity/RecommendGamesActivity;->mTitleView:Lcom/cyjh/elfin/customview/TitleView;

    const v1, 0x7f02008f

    invoke-virtual {v0, v1}, Lcom/cyjh/elfin/customview/TitleView;->setleftImage(I)V

    .line 51
    iget-object v0, p0, Lcom/cyjh/elfin/activity/RecommendGamesActivity;->mTitleView:Lcom/cyjh/elfin/customview/TitleView;

    const/16 v1, 0x8

    invoke-virtual {v0, v1}, Lcom/cyjh/elfin/customview/TitleView;->setVisibilityRightImage(I)V

    .line 52
    iget-object v0, p0, Lcom/cyjh/elfin/activity/RecommendGamesActivity;->mTitleView:Lcom/cyjh/elfin/customview/TitleView;

    const/4 v1, 0x0

    invoke-virtual {v0, v1}, Lcom/cyjh/elfin/customview/TitleView;->setVisibilityTvRight(I)V

    .line 53
    iget-object v0, p0, Lcom/cyjh/elfin/activity/RecommendGamesActivity;->mTitleView:Lcom/cyjh/elfin/customview/TitleView;

    new-instance v1, Lcom/cyjh/elfin/activity/RecommendGamesActivity$OnRightTextViewOnClicker;

    invoke-direct {v1, p0, v2}, Lcom/cyjh/elfin/activity/RecommendGamesActivity$OnRightTextViewOnClicker;-><init>(Lcom/cyjh/elfin/activity/RecommendGamesActivity;Lcom/cyjh/elfin/activity/RecommendGamesActivity$1;)V

    invoke-virtual {v0, v1}, Lcom/cyjh/elfin/customview/TitleView;->setOnRightTextViewListener(Lcom/cyjh/elfin/customview/TitleView$OnRightTextViewListener;)V

    .line 54
    iget-object v0, p0, Lcom/cyjh/elfin/activity/RecommendGamesActivity;->mTitleView:Lcom/cyjh/elfin/customview/TitleView;

    new-instance v1, Lcom/cyjh/elfin/activity/RecommendGamesActivity$OnLeftBackListener;

    invoke-direct {v1, p0, v2}, Lcom/cyjh/elfin/activity/RecommendGamesActivity$OnLeftBackListener;-><init>(Lcom/cyjh/elfin/activity/RecommendGamesActivity;Lcom/cyjh/elfin/activity/RecommendGamesActivity$1;)V

    invoke-virtual {v0, v1}, Lcom/cyjh/elfin/customview/TitleView;->setOnLeftImageViewListener(Lcom/cyjh/elfin/customview/TitleView$OnLeftImageViewListener;)V

    .line 55
    return-void
.end method

.method private isStartActivity()V
    .locals 3

    .prologue
    .line 69
    iget-boolean v0, p0, Lcom/cyjh/elfin/activity/RecommendGamesActivity;->isFirstEntry:Z

    if-eqz v0, :cond_0

    .line 70
    invoke-static {p0}, Lcom/cyjh/elfin/activity/ElfinFreeActivity;->toCallActivity(Landroid/content/Context;)V

    .line 71
    iget-object v0, p0, Lcom/cyjh/elfin/activity/RecommendGamesActivity;->appContext:Lcom/cyjh/elfin/AppContext;

    iget-object v0, v0, Lcom/cyjh/elfin/AppContext;->mSharePre:Landroid/content/SharedPreferences;

    invoke-interface {v0}, Landroid/content/SharedPreferences;->edit()Landroid/content/SharedPreferences$Editor;

    move-result-object v0

    const-string v1, "default_entry_games"

    const/4 v2, 0x0

    invoke-interface {v0, v1, v2}, Landroid/content/SharedPreferences$Editor;->putBoolean(Ljava/lang/String;Z)Landroid/content/SharedPreferences$Editor;

    move-result-object v0

    invoke-interface {v0}, Landroid/content/SharedPreferences$Editor;->apply()V

    .line 73
    :cond_0
    invoke-virtual {p0}, Lcom/cyjh/elfin/activity/RecommendGamesActivity;->finish()V

    .line 74
    return-void
.end method

.method private replaceFragment(Ljava/lang/String;)V
    .locals 3
    .param p1, "path"    # Ljava/lang/String;

    .prologue
    .line 42
    invoke-virtual {p0}, Lcom/cyjh/elfin/activity/RecommendGamesActivity;->getSupportFragmentManager()Landroid/support/v4/app/FragmentManager;

    move-result-object v0

    invoke-virtual {v0}, Landroid/support/v4/app/FragmentManager;->beginTransaction()Landroid/support/v4/app/FragmentTransaction;

    move-result-object v0

    const v1, 0x7f0f0082

    .line 43
    invoke-static {p1}, Lcom/cyjh/elfin/fragment/RecommendGamesFragment;->newInstance(Ljava/lang/String;)Lcom/cyjh/elfin/fragment/RecommendGamesFragment;

    move-result-object v2

    invoke-virtual {v0, v1, v2}, Landroid/support/v4/app/FragmentTransaction;->replace(ILandroid/support/v4/app/Fragment;)Landroid/support/v4/app/FragmentTransaction;

    move-result-object v0

    invoke-virtual {v0}, Landroid/support/v4/app/FragmentTransaction;->commit()I

    .line 44
    return-void
.end method


# virtual methods
.method protected onCreate(Landroid/os/Bundle;)V
    .locals 6
    .param p1, "savedInstanceState"    # Landroid/os/Bundle;

    .prologue
    const/16 v4, 0x80

    .line 30
    invoke-virtual {p0}, Lcom/cyjh/elfin/activity/RecommendGamesActivity;->getWindow()Landroid/view/Window;

    move-result-object v3

    invoke-virtual {v3, v4, v4}, Landroid/view/Window;->setFlags(II)V

    .line 31
    invoke-super {p0, p1}, Lcom/cyjh/elfin/activity/BaseActivity;->onCreate(Landroid/os/Bundle;)V

    .line 32
    const v3, 0x7f040024

    invoke-virtual {p0, v3}, Lcom/cyjh/elfin/activity/RecommendGamesActivity;->setContentView(I)V

    .line 33
    invoke-virtual {p0}, Lcom/cyjh/elfin/activity/RecommendGamesActivity;->getIntent()Landroid/content/Intent;

    move-result-object v0

    .line 34
    .local v0, "intent":Landroid/content/Intent;
    const-class v3, Lcom/cyjh/elfin/activity/RecommendGamesActivity;

    invoke-virtual {v3}, Ljava/lang/Class;->getCanonicalName()Ljava/lang/String;

    move-result-object v3

    invoke-virtual {v0, v3}, Landroid/content/Intent;->getStringExtra(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v1

    .line 35
    .local v1, "name":Ljava/lang/String;
    const-class v3, Lcom/cyjh/elfin/activity/RecommendGamesActivity;

    invoke-virtual {v3}, Ljava/lang/Class;->getSimpleName()Ljava/lang/String;

    move-result-object v3

    invoke-virtual {v0, v3}, Landroid/content/Intent;->getStringExtra(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v2

    .line 36
    .local v2, "path":Ljava/lang/String;
    iget-object v3, p0, Lcom/cyjh/elfin/activity/RecommendGamesActivity;->appContext:Lcom/cyjh/elfin/AppContext;

    iget-object v3, v3, Lcom/cyjh/elfin/AppContext;->mSharePre:Landroid/content/SharedPreferences;

    const-string v4, "default_entry_games"

    const/4 v5, 0x0

    invoke-interface {v3, v4, v5}, Landroid/content/SharedPreferences;->getBoolean(Ljava/lang/String;Z)Z

    move-result v3

    iput-boolean v3, p0, Lcom/cyjh/elfin/activity/RecommendGamesActivity;->isFirstEntry:Z

    .line 37
    invoke-direct {p0, v1}, Lcom/cyjh/elfin/activity/RecommendGamesActivity;->initView(Ljava/lang/String;)V

    .line 38
    invoke-direct {p0, v2}, Lcom/cyjh/elfin/activity/RecommendGamesActivity;->replaceFragment(Ljava/lang/String;)V

    .line 39
    return-void
.end method

.method public onKeyDown(ILandroid/view/KeyEvent;)Z
    .locals 1
    .param p1, "keyCode"    # I
    .param p2, "event"    # Landroid/view/KeyEvent;

    .prologue
    .line 88
    const/4 v0, 0x4

    if-ne p1, v0, :cond_0

    invoke-virtual {p2}, Landroid/view/KeyEvent;->getRepeatCount()I

    move-result v0

    if-nez v0, :cond_0

    .line 89
    invoke-direct {p0}, Lcom/cyjh/elfin/activity/RecommendGamesActivity;->isStartActivity()V

    .line 90
    const/4 v0, 0x1

    .line 92
    :goto_0
    return v0

    :cond_0
    invoke-super {p0, p1, p2}, Lcom/cyjh/elfin/activity/BaseActivity;->onKeyDown(ILandroid/view/KeyEvent;)Z

    move-result v0

    goto :goto_0
.end method

.method protected onPause()V
    .locals 0

    .prologue
    .line 103
    invoke-super {p0}, Lcom/cyjh/elfin/activity/BaseActivity;->onPause()V

    .line 104
    invoke-static {p0}, Lcom/umeng/analytics/MobclickAgent;->onPause(Landroid/content/Context;)V

    .line 105
    return-void
.end method

.method protected onResume()V
    .locals 0

    .prologue
    .line 97
    invoke-super {p0}, Lcom/cyjh/elfin/activity/BaseActivity;->onResume()V

    .line 98
    invoke-static {p0}, Lcom/umeng/analytics/MobclickAgent;->onResume(Landroid/content/Context;)V

    .line 99
    return-void
.end method
