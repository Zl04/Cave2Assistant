.class public Lcom/cyjh/elfin/activity/AbGamesDetailsActivity;
.super Lcom/cyjh/elfin/activity/BaseActivity;
.source "AbGamesDetailsActivity.java"


# instance fields
.field private mLeftListener:Lcom/cyjh/elfin/customview/TitleView$OnLeftImageViewListener;

.field private mTitleView:Lcom/cyjh/elfin/customview/TitleView;


# direct methods
.method public constructor <init>()V
    .locals 1

    .prologue
    .line 12
    invoke-direct {p0}, Lcom/cyjh/elfin/activity/BaseActivity;-><init>()V

    .line 50
    new-instance v0, Lcom/cyjh/elfin/activity/AbGamesDetailsActivity$1;

    invoke-direct {v0, p0}, Lcom/cyjh/elfin/activity/AbGamesDetailsActivity$1;-><init>(Lcom/cyjh/elfin/activity/AbGamesDetailsActivity;)V

    iput-object v0, p0, Lcom/cyjh/elfin/activity/AbGamesDetailsActivity;->mLeftListener:Lcom/cyjh/elfin/customview/TitleView$OnLeftImageViewListener;

    return-void
.end method

.method private initView(Ljava/lang/String;)V
    .locals 2
    .param p1, "title"    # Ljava/lang/String;

    .prologue
    .line 31
    const v0, 0x7f0f006b

    invoke-virtual {p0, v0}, Lcom/cyjh/elfin/activity/AbGamesDetailsActivity;->findViewById(I)Landroid/view/View;

    move-result-object v0

    check-cast v0, Lcom/cyjh/elfin/customview/TitleView;

    iput-object v0, p0, Lcom/cyjh/elfin/activity/AbGamesDetailsActivity;->mTitleView:Lcom/cyjh/elfin/customview/TitleView;

    .line 32
    iget-object v0, p0, Lcom/cyjh/elfin/activity/AbGamesDetailsActivity;->mTitleView:Lcom/cyjh/elfin/customview/TitleView;

    const v1, 0x7f02008f

    invoke-virtual {v0, v1}, Lcom/cyjh/elfin/customview/TitleView;->setleftImage(I)V

    .line 33
    iget-object v0, p0, Lcom/cyjh/elfin/activity/AbGamesDetailsActivity;->mTitleView:Lcom/cyjh/elfin/customview/TitleView;

    iget-object v1, p0, Lcom/cyjh/elfin/activity/AbGamesDetailsActivity;->mLeftListener:Lcom/cyjh/elfin/customview/TitleView$OnLeftImageViewListener;

    invoke-virtual {v0, v1}, Lcom/cyjh/elfin/customview/TitleView;->setOnLeftImageViewListener(Lcom/cyjh/elfin/customview/TitleView$OnLeftImageViewListener;)V

    .line 34
    iget-object v0, p0, Lcom/cyjh/elfin/activity/AbGamesDetailsActivity;->mTitleView:Lcom/cyjh/elfin/customview/TitleView;

    const/16 v1, 0x8

    invoke-virtual {v0, v1}, Lcom/cyjh/elfin/customview/TitleView;->setVisibilityRightImage(I)V

    .line 35
    iget-object v0, p0, Lcom/cyjh/elfin/activity/AbGamesDetailsActivity;->mTitleView:Lcom/cyjh/elfin/customview/TitleView;

    invoke-virtual {v0, p1}, Lcom/cyjh/elfin/customview/TitleView;->setTitleText(Ljava/lang/String;)V

    .line 36
    return-void
.end method

.method private replaceFragment(Ljava/lang/String;)V
    .locals 3
    .param p1, "id"    # Ljava/lang/String;

    .prologue
    .line 26
    invoke-virtual {p0}, Lcom/cyjh/elfin/activity/AbGamesDetailsActivity;->getSupportFragmentManager()Landroid/support/v4/app/FragmentManager;

    move-result-object v0

    invoke-virtual {v0}, Landroid/support/v4/app/FragmentManager;->beginTransaction()Landroid/support/v4/app/FragmentTransaction;

    move-result-object v0

    const v1, 0x7f0f006c

    .line 27
    invoke-static {p1}, Lcom/cyjh/elfin/fragment/AbGamesDetailFragment;->newInstance(Ljava/lang/String;)Lcom/cyjh/elfin/fragment/AbGamesDetailFragment;

    move-result-object v2

    .line 26
    invoke-virtual {v0, v1, v2}, Landroid/support/v4/app/FragmentTransaction;->replace(ILandroid/support/v4/app/Fragment;)Landroid/support/v4/app/FragmentTransaction;

    move-result-object v0

    .line 27
    invoke-virtual {v0}, Landroid/support/v4/app/FragmentTransaction;->commit()I

    .line 28
    return-void
.end method


# virtual methods
.method protected onCreate(Landroid/os/Bundle;)V
    .locals 3
    .param p1, "savedInstanceState"    # Landroid/os/Bundle;

    .prologue
    .line 18
    invoke-super {p0, p1}, Lcom/cyjh/elfin/activity/BaseActivity;->onCreate(Landroid/os/Bundle;)V

    .line 19
    const v1, 0x7f040019

    invoke-virtual {p0, v1}, Lcom/cyjh/elfin/activity/AbGamesDetailsActivity;->setContentView(I)V

    .line 20
    invoke-virtual {p0}, Lcom/cyjh/elfin/activity/AbGamesDetailsActivity;->getIntent()Landroid/content/Intent;

    move-result-object v1

    const-class v2, Lcom/cyjh/elfin/entity/GameInfo;

    invoke-virtual {v2}, Ljava/lang/Class;->getCanonicalName()Ljava/lang/String;

    move-result-object v2

    invoke-virtual {v1, v2}, Landroid/content/Intent;->getParcelableExtra(Ljava/lang/String;)Landroid/os/Parcelable;

    move-result-object v0

    check-cast v0, Lcom/cyjh/elfin/entity/GameInfo;

    .line 21
    .local v0, "gameInfo":Lcom/cyjh/elfin/entity/GameInfo;
    iget-object v1, v0, Lcom/cyjh/elfin/entity/GameInfo;->Name:Ljava/lang/String;

    invoke-direct {p0, v1}, Lcom/cyjh/elfin/activity/AbGamesDetailsActivity;->initView(Ljava/lang/String;)V

    .line 22
    iget-object v1, v0, Lcom/cyjh/elfin/entity/GameInfo;->Id:Ljava/lang/String;

    invoke-direct {p0, v1}, Lcom/cyjh/elfin/activity/AbGamesDetailsActivity;->replaceFragment(Ljava/lang/String;)V

    .line 23
    return-void
.end method

.method protected onPause()V
    .locals 0

    .prologue
    .line 40
    invoke-super {p0}, Lcom/cyjh/elfin/activity/BaseActivity;->onPause()V

    .line 41
    invoke-static {p0}, Lcom/umeng/analytics/MobclickAgent;->onPause(Landroid/content/Context;)V

    .line 42
    return-void
.end method

.method protected onResume()V
    .locals 0

    .prologue
    .line 46
    invoke-super {p0}, Lcom/cyjh/elfin/activity/BaseActivity;->onResume()V

    .line 47
    invoke-static {p0}, Lcom/umeng/analytics/MobclickAgent;->onResume(Landroid/content/Context;)V

    .line 48
    return-void
.end method
