.class public Lcom/cyjh/elfin/activity/MessageDetailActivity;
.super Lcom/cyjh/elfin/activity/BaseActivity;
.source "MessageDetailActivity.java"


# annotations
.annotation system Ldalvik/annotation/MemberClasses;
    value = {
        Lcom/cyjh/elfin/activity/MessageDetailActivity$OnLeftImageOnClickerListener;
    }
.end annotation


# instance fields
.field private titleView:Lcom/cyjh/elfin/customview/TitleView;


# direct methods
.method public constructor <init>()V
    .locals 0

    .prologue
    .line 17
    invoke-direct {p0}, Lcom/cyjh/elfin/activity/BaseActivity;-><init>()V

    return-void
.end method

.method private initTitleView()V
    .locals 3

    .prologue
    .line 30
    const v0, 0x7f0f007f

    invoke-virtual {p0, v0}, Lcom/cyjh/elfin/activity/MessageDetailActivity;->findViewById(I)Landroid/view/View;

    move-result-object v0

    check-cast v0, Lcom/cyjh/elfin/customview/TitleView;

    iput-object v0, p0, Lcom/cyjh/elfin/activity/MessageDetailActivity;->titleView:Lcom/cyjh/elfin/customview/TitleView;

    .line 31
    iget-object v0, p0, Lcom/cyjh/elfin/activity/MessageDetailActivity;->titleView:Lcom/cyjh/elfin/customview/TitleView;

    const v1, 0x7f02008f

    invoke-virtual {v0, v1}, Lcom/cyjh/elfin/customview/TitleView;->setleftImage(I)V

    .line 32
    iget-object v0, p0, Lcom/cyjh/elfin/activity/MessageDetailActivity;->titleView:Lcom/cyjh/elfin/customview/TitleView;

    const v1, 0x7f08009e

    invoke-virtual {v0, v1}, Lcom/cyjh/elfin/customview/TitleView;->setTitleText(I)V

    .line 33
    iget-object v0, p0, Lcom/cyjh/elfin/activity/MessageDetailActivity;->titleView:Lcom/cyjh/elfin/customview/TitleView;

    const/4 v1, 0x4

    invoke-virtual {v0, v1}, Lcom/cyjh/elfin/customview/TitleView;->setVisibilityRightImage(I)V

    .line 34
    iget-object v0, p0, Lcom/cyjh/elfin/activity/MessageDetailActivity;->titleView:Lcom/cyjh/elfin/customview/TitleView;

    new-instance v1, Lcom/cyjh/elfin/activity/MessageDetailActivity$OnLeftImageOnClickerListener;

    const/4 v2, 0x0

    invoke-direct {v1, p0, v2}, Lcom/cyjh/elfin/activity/MessageDetailActivity$OnLeftImageOnClickerListener;-><init>(Lcom/cyjh/elfin/activity/MessageDetailActivity;Lcom/cyjh/elfin/activity/MessageDetailActivity$1;)V

    invoke-virtual {v0, v1}, Lcom/cyjh/elfin/customview/TitleView;->setOnLeftImageViewListener(Lcom/cyjh/elfin/customview/TitleView$OnLeftImageViewListener;)V

    .line 35
    return-void
.end method


# virtual methods
.method protected onCreate(Landroid/os/Bundle;)V
    .locals 4
    .param p1, "savedInstanceState"    # Landroid/os/Bundle;

    .prologue
    .line 21
    invoke-super {p0, p1}, Lcom/cyjh/elfin/activity/BaseActivity;->onCreate(Landroid/os/Bundle;)V

    .line 22
    const v2, 0x7f040022

    invoke-virtual {p0, v2}, Lcom/cyjh/elfin/activity/MessageDetailActivity;->setContentView(I)V

    .line 23
    invoke-direct {p0}, Lcom/cyjh/elfin/activity/MessageDetailActivity;->initTitleView()V

    .line 24
    invoke-virtual {p0}, Lcom/cyjh/elfin/activity/MessageDetailActivity;->getIntent()Landroid/content/Intent;

    move-result-object v2

    const-class v3, Lcom/cyjh/elfin/activity/MessageDetailActivity;

    invoke-virtual {v3}, Ljava/lang/Class;->getCanonicalName()Ljava/lang/String;

    move-result-object v3

    invoke-virtual {v2, v3}, Landroid/content/Intent;->getParcelableExtra(Ljava/lang/String;)Landroid/os/Parcelable;

    move-result-object v1

    check-cast v1, Lcom/cyjh/elfin/entity/NotifyMsgBean;

    .line 25
    .local v1, "notifyMsgBean":Lcom/cyjh/elfin/entity/NotifyMsgBean;
    invoke-virtual {p0}, Lcom/cyjh/elfin/activity/MessageDetailActivity;->getSupportFragmentManager()Landroid/support/v4/app/FragmentManager;

    move-result-object v2

    invoke-virtual {v2}, Landroid/support/v4/app/FragmentManager;->beginTransaction()Landroid/support/v4/app/FragmentTransaction;

    move-result-object v0

    .line 26
    .local v0, "ft":Landroid/support/v4/app/FragmentTransaction;
    const v2, 0x7f0f0080

    invoke-static {v1}, Lcom/cyjh/elfin/fragment/MsgDetailFragment;->newInstance(Lcom/cyjh/elfin/entity/NotifyMsgBean;)Lcom/cyjh/elfin/fragment/MsgDetailFragment;

    move-result-object v3

    invoke-virtual {v0, v2, v3}, Landroid/support/v4/app/FragmentTransaction;->replace(ILandroid/support/v4/app/Fragment;)Landroid/support/v4/app/FragmentTransaction;

    move-result-object v2

    .line 27
    invoke-virtual {v2}, Landroid/support/v4/app/FragmentTransaction;->commit()I

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
