.class public Lcom/cyjh/elfin/activity/AbnormalGamesActivity;
.super Lcom/cyjh/elfin/activity/BaseActivity;
.source "AbnormalGamesActivity.java"


# instance fields
.field private mLeftListener:Lcom/cyjh/elfin/customview/TitleView$OnLeftImageViewListener;

.field private mTitleView:Lcom/cyjh/elfin/customview/TitleView;


# direct methods
.method public constructor <init>()V
    .locals 1

    .prologue
    .line 20
    invoke-direct {p0}, Lcom/cyjh/elfin/activity/BaseActivity;-><init>()V

    .line 44
    new-instance v0, Lcom/cyjh/elfin/activity/AbnormalGamesActivity$1;

    invoke-direct {v0, p0}, Lcom/cyjh/elfin/activity/AbnormalGamesActivity$1;-><init>(Lcom/cyjh/elfin/activity/AbnormalGamesActivity;)V

    iput-object v0, p0, Lcom/cyjh/elfin/activity/AbnormalGamesActivity;->mLeftListener:Lcom/cyjh/elfin/customview/TitleView$OnLeftImageViewListener;

    return-void
.end method

.method private initView()V
    .locals 3

    .prologue
    .line 33
    const v1, 0x7f0f006b

    invoke-virtual {p0, v1}, Lcom/cyjh/elfin/activity/AbnormalGamesActivity;->findViewById(I)Landroid/view/View;

    move-result-object v1

    check-cast v1, Lcom/cyjh/elfin/customview/TitleView;

    iput-object v1, p0, Lcom/cyjh/elfin/activity/AbnormalGamesActivity;->mTitleView:Lcom/cyjh/elfin/customview/TitleView;

    .line 34
    iget-object v1, p0, Lcom/cyjh/elfin/activity/AbnormalGamesActivity;->mTitleView:Lcom/cyjh/elfin/customview/TitleView;

    const v2, 0x7f02008f

    invoke-virtual {v1, v2}, Lcom/cyjh/elfin/customview/TitleView;->setleftImage(I)V

    .line 35
    invoke-virtual {p0}, Lcom/cyjh/elfin/activity/AbnormalGamesActivity;->getIntent()Landroid/content/Intent;

    move-result-object v1

    const-class v2, Lcom/cyjh/elfin/activity/AbnormalGamesActivity;

    invoke-virtual {v2}, Ljava/lang/Class;->getCanonicalName()Ljava/lang/String;

    move-result-object v2

    invoke-virtual {v1, v2}, Landroid/content/Intent;->getStringExtra(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v0

    .line 36
    .local v0, "name":Ljava/lang/String;
    invoke-static {v0}, Landroid/text/TextUtils;->isEmpty(Ljava/lang/CharSequence;)Z

    move-result v1

    if-eqz v1, :cond_0

    .line 37
    const v1, 0x7f0800fd

    invoke-virtual {p0, v1}, Lcom/cyjh/elfin/activity/AbnormalGamesActivity;->getString(I)Ljava/lang/String;

    move-result-object v0

    .line 39
    :cond_0
    iget-object v1, p0, Lcom/cyjh/elfin/activity/AbnormalGamesActivity;->mTitleView:Lcom/cyjh/elfin/customview/TitleView;

    invoke-virtual {v1, v0}, Lcom/cyjh/elfin/customview/TitleView;->setTitleText(Ljava/lang/String;)V

    .line 40
    iget-object v1, p0, Lcom/cyjh/elfin/activity/AbnormalGamesActivity;->mTitleView:Lcom/cyjh/elfin/customview/TitleView;

    iget-object v2, p0, Lcom/cyjh/elfin/activity/AbnormalGamesActivity;->mLeftListener:Lcom/cyjh/elfin/customview/TitleView$OnLeftImageViewListener;

    invoke-virtual {v1, v2}, Lcom/cyjh/elfin/customview/TitleView;->setOnLeftImageViewListener(Lcom/cyjh/elfin/customview/TitleView$OnLeftImageViewListener;)V

    .line 41
    iget-object v1, p0, Lcom/cyjh/elfin/activity/AbnormalGamesActivity;->mTitleView:Lcom/cyjh/elfin/customview/TitleView;

    const/16 v2, 0x8

    invoke-virtual {v1, v2}, Lcom/cyjh/elfin/customview/TitleView;->setVisibilityRightImage(I)V

    .line 42
    return-void
.end method

.method private replaceFragment()V
    .locals 3

    .prologue
    .line 52
    invoke-virtual {p0}, Lcom/cyjh/elfin/activity/AbnormalGamesActivity;->getSupportFragmentManager()Landroid/support/v4/app/FragmentManager;

    move-result-object v0

    invoke-virtual {v0}, Landroid/support/v4/app/FragmentManager;->beginTransaction()Landroid/support/v4/app/FragmentTransaction;

    move-result-object v0

    const v1, 0x7f0f006d

    .line 53
    invoke-static {}, Lcom/cyjh/elfin/fragment/AbnormalGameListFragment;->getInstance()Lcom/cyjh/elfin/fragment/AbnormalGameListFragment;

    move-result-object v2

    .line 52
    invoke-virtual {v0, v1, v2}, Landroid/support/v4/app/FragmentTransaction;->replace(ILandroid/support/v4/app/Fragment;)Landroid/support/v4/app/FragmentTransaction;

    move-result-object v0

    .line 53
    invoke-virtual {v0}, Landroid/support/v4/app/FragmentTransaction;->commit()I

    .line 54
    return-void
.end method


# virtual methods
.method protected onCreate(Landroid/os/Bundle;)V
    .locals 1
    .param p1, "savedInstanceState"    # Landroid/os/Bundle;

    .prologue
    .line 26
    invoke-super {p0, p1}, Lcom/cyjh/elfin/activity/BaseActivity;->onCreate(Landroid/os/Bundle;)V

    .line 27
    const v0, 0x7f04001a

    invoke-virtual {p0, v0}, Lcom/cyjh/elfin/activity/AbnormalGamesActivity;->setContentView(I)V

    .line 28
    invoke-direct {p0}, Lcom/cyjh/elfin/activity/AbnormalGamesActivity;->initView()V

    .line 29
    invoke-direct {p0}, Lcom/cyjh/elfin/activity/AbnormalGamesActivity;->replaceFragment()V

    .line 30
    return-void
.end method

.method protected onPause()V
    .locals 0

    .prologue
    .line 64
    invoke-super {p0}, Lcom/cyjh/elfin/activity/BaseActivity;->onPause()V

    .line 65
    invoke-static {p0}, Lcom/umeng/analytics/MobclickAgent;->onPause(Landroid/content/Context;)V

    .line 66
    return-void
.end method

.method protected onResume()V
    .locals 0

    .prologue
    .line 58
    invoke-super {p0}, Lcom/cyjh/elfin/activity/BaseActivity;->onResume()V

    .line 59
    invoke-static {p0}, Lcom/umeng/analytics/MobclickAgent;->onResume(Landroid/content/Context;)V

    .line 60
    return-void
.end method
