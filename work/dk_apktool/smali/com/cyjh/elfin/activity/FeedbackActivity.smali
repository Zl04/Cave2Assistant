.class public Lcom/cyjh/elfin/activity/FeedbackActivity;
.super Lcom/cyjh/elfin/activity/BaseActivity;
.source "FeedbackActivity.java"


# instance fields
.field mTitleView:Lcom/cyjh/elfin/customview/TitleView;


# direct methods
.method public constructor <init>()V
    .locals 0

    .prologue
    .line 15
    invoke-direct {p0}, Lcom/cyjh/elfin/activity/BaseActivity;-><init>()V

    return-void
.end method

.method private initTitle()V
    .locals 2

    .prologue
    .line 31
    const v0, 0x7f0f0071

    invoke-virtual {p0, v0}, Lcom/cyjh/elfin/activity/FeedbackActivity;->findViewById(I)Landroid/view/View;

    move-result-object v0

    check-cast v0, Lcom/cyjh/elfin/customview/TitleView;

    iput-object v0, p0, Lcom/cyjh/elfin/activity/FeedbackActivity;->mTitleView:Lcom/cyjh/elfin/customview/TitleView;

    .line 32
    iget-object v0, p0, Lcom/cyjh/elfin/activity/FeedbackActivity;->mTitleView:Lcom/cyjh/elfin/customview/TitleView;

    const v1, 0x7f08006b

    invoke-virtual {v0, v1}, Lcom/cyjh/elfin/customview/TitleView;->setTitleText(I)V

    .line 33
    iget-object v0, p0, Lcom/cyjh/elfin/activity/FeedbackActivity;->mTitleView:Lcom/cyjh/elfin/customview/TitleView;

    const/4 v1, 0x0

    invoke-virtual {v0, v1}, Lcom/cyjh/elfin/customview/TitleView;->setVisibilityLeftImage(I)V

    .line 34
    iget-object v0, p0, Lcom/cyjh/elfin/activity/FeedbackActivity;->mTitleView:Lcom/cyjh/elfin/customview/TitleView;

    const v1, 0x7f02008f

    invoke-virtual {v0, v1}, Lcom/cyjh/elfin/customview/TitleView;->setleftImage(I)V

    .line 35
    iget-object v0, p0, Lcom/cyjh/elfin/activity/FeedbackActivity;->mTitleView:Lcom/cyjh/elfin/customview/TitleView;

    new-instance v1, Lcom/cyjh/elfin/activity/FeedbackActivity$1;

    invoke-direct {v1, p0}, Lcom/cyjh/elfin/activity/FeedbackActivity$1;-><init>(Lcom/cyjh/elfin/activity/FeedbackActivity;)V

    invoke-virtual {v0, v1}, Lcom/cyjh/elfin/customview/TitleView;->setOnLeftImageViewListener(Lcom/cyjh/elfin/customview/TitleView$OnLeftImageViewListener;)V

    .line 41
    iget-object v0, p0, Lcom/cyjh/elfin/activity/FeedbackActivity;->mTitleView:Lcom/cyjh/elfin/customview/TitleView;

    const/4 v1, 0x4

    invoke-virtual {v0, v1}, Lcom/cyjh/elfin/customview/TitleView;->setVisibilityRightImage(I)V

    .line 42
    return-void
.end method


# virtual methods
.method protected onCreate(Landroid/os/Bundle;)V
    .locals 4
    .param p1, "savedInstanceState"    # Landroid/os/Bundle;

    .prologue
    .line 20
    invoke-super {p0, p1}, Lcom/cyjh/elfin/activity/BaseActivity;->onCreate(Landroid/os/Bundle;)V

    .line 21
    const v1, 0x7f04001d

    invoke-virtual {p0, v1}, Lcom/cyjh/elfin/activity/FeedbackActivity;->setContentView(I)V

    .line 22
    invoke-direct {p0}, Lcom/cyjh/elfin/activity/FeedbackActivity;->initTitle()V

    .line 23
    invoke-virtual {p0}, Lcom/cyjh/elfin/activity/FeedbackActivity;->getSupportFragmentManager()Landroid/support/v4/app/FragmentManager;

    move-result-object v1

    invoke-virtual {v1}, Landroid/support/v4/app/FragmentManager;->beginTransaction()Landroid/support/v4/app/FragmentTransaction;

    move-result-object v0

    .line 24
    .local v0, "transaction":Landroid/support/v4/app/FragmentTransaction;
    const v1, 0x7f0f0072

    .line 26
    invoke-virtual {p0}, Lcom/cyjh/elfin/activity/FeedbackActivity;->getIntent()Landroid/content/Intent;

    move-result-object v2

    const-class v3, Lcom/cyjh/elfin/activity/FeedbackActivity;

    invoke-virtual {v3}, Ljava/lang/Class;->getCanonicalName()Ljava/lang/String;

    move-result-object v3

    invoke-virtual {v2, v3}, Landroid/content/Intent;->getStringExtra(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v2

    const/4 v3, 0x0

    .line 25
    invoke-static {v2, v3}, Lcom/cyjh/feedback/lib/fragment/FeedBackInfoFragment;->newInstance(Ljava/lang/String;Z)Lcom/cyjh/feedback/lib/fragment/FeedBackInfoFragment;

    move-result-object v2

    .line 24
    invoke-virtual {v0, v1, v2}, Landroid/support/v4/app/FragmentTransaction;->replace(ILandroid/support/v4/app/Fragment;)Landroid/support/v4/app/FragmentTransaction;

    .line 27
    invoke-virtual {v0}, Landroid/support/v4/app/FragmentTransaction;->commit()I

    .line 28
    return-void
.end method

.method protected onPause()V
    .locals 0

    .prologue
    .line 52
    invoke-super {p0}, Lcom/cyjh/elfin/activity/BaseActivity;->onPause()V

    .line 53
    invoke-static {p0}, Lcom/umeng/analytics/MobclickAgent;->onPause(Landroid/content/Context;)V

    .line 54
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
