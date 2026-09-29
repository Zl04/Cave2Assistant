.class public Lcom/cyjh/elfin/activity/SplashActivity;
.super Lcom/cyjh/elfin/activity/BaseActivity;
.source "SplashActivity.java"


# direct methods
.method public constructor <init>()V
    .locals 0

    .prologue
    .line 12
    invoke-direct {p0}, Lcom/cyjh/elfin/activity/BaseActivity;-><init>()V

    return-void
.end method


# virtual methods
.method public finish()V
    .locals 2

    .prologue
    .line 28
    invoke-super {p0}, Lcom/cyjh/elfin/activity/BaseActivity;->finish()V

    .line 29
    const v0, 0x7f050012

    const v1, 0x7f050013

    invoke-virtual {p0, v0, v1}, Lcom/cyjh/elfin/activity/SplashActivity;->overridePendingTransition(II)V

    .line 30
    return-void
.end method

.method protected onCreate(Landroid/os/Bundle;)V
    .locals 3
    .param p1, "savedInstanceState"    # Landroid/os/Bundle;

    .prologue
    .line 15
    invoke-super {p0, p1}, Lcom/cyjh/elfin/activity/BaseActivity;->onCreate(Landroid/os/Bundle;)V

    .line 16
    const v0, 0x7f040028

    invoke-virtual {p0, v0}, Lcom/cyjh/elfin/activity/SplashActivity;->setContentView(I)V

    .line 17
    invoke-virtual {p0}, Lcom/cyjh/elfin/activity/SplashActivity;->isTaskRoot()Z

    move-result v0

    if-nez v0, :cond_0

    .line 18
    invoke-virtual {p0}, Lcom/cyjh/elfin/activity/SplashActivity;->finish()V

    .line 24
    :goto_0
    return-void

    .line 21
    :cond_0
    invoke-virtual {p0}, Lcom/cyjh/elfin/activity/SplashActivity;->getSupportFragmentManager()Landroid/support/v4/app/FragmentManager;

    move-result-object v0

    invoke-virtual {v0}, Landroid/support/v4/app/FragmentManager;->beginTransaction()Landroid/support/v4/app/FragmentTransaction;

    move-result-object v0

    const v1, 0x7f0f0094

    .line 22
    invoke-static {}, Lcom/cyjh/elfin/fragment/SplashFragment;->newInstance()Lcom/cyjh/elfin/fragment/SplashFragment;

    move-result-object v2

    invoke-virtual {v0, v1, v2}, Landroid/support/v4/app/FragmentTransaction;->replace(ILandroid/support/v4/app/Fragment;)Landroid/support/v4/app/FragmentTransaction;

    move-result-object v0

    .line 23
    invoke-virtual {v0}, Landroid/support/v4/app/FragmentTransaction;->commit()I

    goto :goto_0
.end method

.method protected onPause()V
    .locals 0

    .prologue
    .line 34
    invoke-super {p0}, Lcom/cyjh/elfin/activity/BaseActivity;->onPause()V

    .line 35
    invoke-static {p0}, Lcom/umeng/analytics/MobclickAgent;->onPause(Landroid/content/Context;)V

    .line 36
    return-void
.end method

.method protected onResume()V
    .locals 0

    .prologue
    .line 40
    invoke-super {p0}, Lcom/cyjh/elfin/activity/BaseActivity;->onResume()V

    .line 41
    invoke-static {p0}, Lcom/umeng/analytics/MobclickAgent;->onResume(Landroid/content/Context;)V

    .line 42
    return-void
.end method
