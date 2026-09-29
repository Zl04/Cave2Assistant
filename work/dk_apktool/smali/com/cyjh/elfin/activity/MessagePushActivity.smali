.class public Lcom/cyjh/elfin/activity/MessagePushActivity;
.super Lcom/cyjh/elfin/activity/BaseActivity;
.source "MessagePushActivity.java"


# annotations
.annotation system Ldalvik/annotation/MemberClasses;
    value = {
        Lcom/cyjh/elfin/activity/MessagePushActivity$OnRightTextViewOnClicker;,
        Lcom/cyjh/elfin/activity/MessagePushActivity$OnLeftImageOnClicker;
    }
.end annotation


# instance fields
.field private datas:Ljava/util/ArrayList;
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "Ljava/util/ArrayList",
            "<",
            "Lcom/cyjh/elfin/entity/NotifyMsgBean;",
            ">;"
        }
    .end annotation
.end field

.field private mSharePres:Landroid/content/SharedPreferences;

.field private titleView:Lcom/cyjh/elfin/customview/TitleView;


# direct methods
.method public constructor <init>()V
    .locals 0

    .prologue
    .line 24
    invoke-direct {p0}, Lcom/cyjh/elfin/activity/BaseActivity;-><init>()V

    return-void
.end method

.method private initTitleView()V
    .locals 4

    .prologue
    const/4 v3, 0x0

    const/4 v2, 0x0

    .line 47
    const v0, 0x7f0f0081

    invoke-virtual {p0, v0}, Lcom/cyjh/elfin/activity/MessagePushActivity;->findViewById(I)Landroid/view/View;

    move-result-object v0

    check-cast v0, Lcom/cyjh/elfin/customview/TitleView;

    iput-object v0, p0, Lcom/cyjh/elfin/activity/MessagePushActivity;->titleView:Lcom/cyjh/elfin/customview/TitleView;

    .line 48
    iget-object v0, p0, Lcom/cyjh/elfin/activity/MessagePushActivity;->titleView:Lcom/cyjh/elfin/customview/TitleView;

    const v1, 0x7f02008f

    invoke-virtual {v0, v1}, Lcom/cyjh/elfin/customview/TitleView;->setleftImage(I)V

    .line 49
    iget-object v0, p0, Lcom/cyjh/elfin/activity/MessagePushActivity;->titleView:Lcom/cyjh/elfin/customview/TitleView;

    new-instance v1, Lcom/cyjh/elfin/activity/MessagePushActivity$OnLeftImageOnClicker;

    invoke-direct {v1, p0, v3}, Lcom/cyjh/elfin/activity/MessagePushActivity$OnLeftImageOnClicker;-><init>(Lcom/cyjh/elfin/activity/MessagePushActivity;Lcom/cyjh/elfin/activity/MessagePushActivity$1;)V

    invoke-virtual {v0, v1}, Lcom/cyjh/elfin/customview/TitleView;->setOnLeftImageViewListener(Lcom/cyjh/elfin/customview/TitleView$OnLeftImageViewListener;)V

    .line 50
    iget-object v0, p0, Lcom/cyjh/elfin/activity/MessagePushActivity;->titleView:Lcom/cyjh/elfin/customview/TitleView;

    const v1, 0x7f08009e

    invoke-virtual {v0, v1}, Lcom/cyjh/elfin/customview/TitleView;->setTitleText(I)V

    .line 51
    iget-object v0, p0, Lcom/cyjh/elfin/activity/MessagePushActivity;->titleView:Lcom/cyjh/elfin/customview/TitleView;

    const v1, 0x7f080046

    invoke-virtual {v0, v1}, Lcom/cyjh/elfin/customview/TitleView;->setRightTvText(I)V

    .line 52
    iget-object v0, p0, Lcom/cyjh/elfin/activity/MessagePushActivity;->titleView:Lcom/cyjh/elfin/customview/TitleView;

    const/16 v1, 0x8

    invoke-virtual {v0, v1}, Lcom/cyjh/elfin/customview/TitleView;->setVisibilityRightImage(I)V

    .line 53
    iget-object v0, p0, Lcom/cyjh/elfin/activity/MessagePushActivity;->titleView:Lcom/cyjh/elfin/customview/TitleView;

    invoke-virtual {v0, v2}, Lcom/cyjh/elfin/customview/TitleView;->setVisibilityTvRight(I)V

    .line 54
    iget-object v0, p0, Lcom/cyjh/elfin/activity/MessagePushActivity;->titleView:Lcom/cyjh/elfin/customview/TitleView;

    new-instance v1, Lcom/cyjh/elfin/activity/MessagePushActivity$OnRightTextViewOnClicker;

    invoke-direct {v1, p0, v3}, Lcom/cyjh/elfin/activity/MessagePushActivity$OnRightTextViewOnClicker;-><init>(Lcom/cyjh/elfin/activity/MessagePushActivity;Lcom/cyjh/elfin/activity/MessagePushActivity$1;)V

    invoke-virtual {v0, v1}, Lcom/cyjh/elfin/customview/TitleView;->setOnRightTextViewListener(Lcom/cyjh/elfin/customview/TitleView$OnRightTextViewListener;)V

    .line 56
    const-string v0, "small_red_dot"

    invoke-virtual {p0, v0, v2}, Lcom/cyjh/elfin/activity/MessagePushActivity;->getSharedPreferences(Ljava/lang/String;I)Landroid/content/SharedPreferences;

    move-result-object v0

    iput-object v0, p0, Lcom/cyjh/elfin/activity/MessagePushActivity;->mSharePres:Landroid/content/SharedPreferences;

    .line 58
    iget-object v0, p0, Lcom/cyjh/elfin/activity/MessagePushActivity;->mSharePres:Landroid/content/SharedPreferences;

    invoke-interface {v0}, Landroid/content/SharedPreferences;->edit()Landroid/content/SharedPreferences$Editor;

    move-result-object v0

    const-string v1, "red_dot_flag"

    invoke-interface {v0, v1, v2}, Landroid/content/SharedPreferences$Editor;->putBoolean(Ljava/lang/String;Z)Landroid/content/SharedPreferences$Editor;

    move-result-object v0

    invoke-interface {v0}, Landroid/content/SharedPreferences$Editor;->apply()V

    .line 59
    return-void
.end method

.method private replaceFragment()V
    .locals 3

    .prologue
    .line 41
    invoke-virtual {p0}, Lcom/cyjh/elfin/activity/MessagePushActivity;->getSupportFragmentManager()Landroid/support/v4/app/FragmentManager;

    move-result-object v1

    invoke-virtual {v1}, Landroid/support/v4/app/FragmentManager;->beginTransaction()Landroid/support/v4/app/FragmentTransaction;

    move-result-object v0

    .line 42
    .local v0, "ft":Landroid/support/v4/app/FragmentTransaction;
    const v1, 0x7f0f0080

    iget-object v2, p0, Lcom/cyjh/elfin/activity/MessagePushActivity;->datas:Ljava/util/ArrayList;

    invoke-static {v2}, Lcom/cyjh/elfin/fragment/MsgPushFragment;->newInstance(Ljava/util/ArrayList;)Lcom/cyjh/elfin/fragment/MsgPushFragment;

    move-result-object v2

    invoke-virtual {v0, v1, v2}, Landroid/support/v4/app/FragmentTransaction;->replace(ILandroid/support/v4/app/Fragment;)Landroid/support/v4/app/FragmentTransaction;

    .line 43
    invoke-virtual {v0}, Landroid/support/v4/app/FragmentTransaction;->commit()I

    .line 44
    return-void
.end method


# virtual methods
.method protected onCreate(Landroid/os/Bundle;)V
    .locals 3
    .param p1, "savedInstanceState"    # Landroid/os/Bundle;

    .prologue
    .line 31
    invoke-super {p0, p1}, Lcom/cyjh/elfin/activity/BaseActivity;->onCreate(Landroid/os/Bundle;)V

    .line 32
    const v0, 0x7f040023

    invoke-virtual {p0, v0}, Lcom/cyjh/elfin/activity/MessagePushActivity;->setContentView(I)V

    .line 33
    invoke-virtual {p0}, Lcom/cyjh/elfin/activity/MessagePushActivity;->getIntent()Landroid/content/Intent;

    move-result-object v0

    const-string v1, "msg_data"

    invoke-virtual {v0, v1}, Landroid/content/Intent;->getParcelableArrayListExtra(Ljava/lang/String;)Ljava/util/ArrayList;

    move-result-object v0

    iput-object v0, p0, Lcom/cyjh/elfin/activity/MessagePushActivity;->datas:Ljava/util/ArrayList;

    .line 35
    invoke-static {}, Lorg/greenrobot/eventbus/EventBus;->getDefault()Lorg/greenrobot/eventbus/EventBus;

    move-result-object v0

    new-instance v1, Lcom/cyjh/elfin/entity/MsgItem;

    const/16 v2, 0x3e9

    invoke-direct {v1, v2}, Lcom/cyjh/elfin/entity/MsgItem;-><init>(I)V

    invoke-virtual {v0, v1}, Lorg/greenrobot/eventbus/EventBus;->post(Ljava/lang/Object;)V

    .line 36
    invoke-direct {p0}, Lcom/cyjh/elfin/activity/MessagePushActivity;->initTitleView()V

    .line 37
    invoke-direct {p0}, Lcom/cyjh/elfin/activity/MessagePushActivity;->replaceFragment()V

    .line 38
    return-void
.end method

.method protected onPause()V
    .locals 0

    .prologue
    .line 87
    invoke-super {p0}, Lcom/cyjh/elfin/activity/BaseActivity;->onPause()V

    .line 88
    invoke-static {p0}, Lcom/umeng/analytics/MobclickAgent;->onPause(Landroid/content/Context;)V

    .line 89
    return-void
.end method

.method protected onResume()V
    .locals 0

    .prologue
    .line 81
    invoke-super {p0}, Lcom/cyjh/elfin/activity/BaseActivity;->onResume()V

    .line 82
    invoke-static {p0}, Lcom/umeng/analytics/MobclickAgent;->onResume(Landroid/content/Context;)V

    .line 83
    return-void
.end method
