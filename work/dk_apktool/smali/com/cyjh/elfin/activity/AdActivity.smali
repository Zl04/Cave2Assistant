.class public Lcom/cyjh/elfin/activity/AdActivity;
.super Lcom/cyjh/elfin/activity/BaseActivity;
.source "AdActivity.java"


# direct methods
.method public constructor <init>()V
    .locals 0

    .prologue
    .line 18
    invoke-direct {p0}, Lcom/cyjh/elfin/activity/BaseActivity;-><init>()V

    return-void
.end method


# virtual methods
.method protected onCreate(Landroid/os/Bundle;)V
    .locals 5
    .param p1, "savedInstanceState"    # Landroid/os/Bundle;

    .prologue
    .line 22
    invoke-super {p0, p1}, Lcom/cyjh/elfin/activity/BaseActivity;->onCreate(Landroid/os/Bundle;)V

    .line 23
    const v3, 0x7f04001b

    invoke-virtual {p0, v3}, Lcom/cyjh/elfin/activity/AdActivity;->setContentView(I)V

    .line 24
    iget-object v3, p0, Lcom/cyjh/elfin/activity/AdActivity;->appContext:Lcom/cyjh/elfin/AppContext;

    const/4 v4, 0x2

    iput v4, v3, Lcom/cyjh/elfin/AppContext;->isVerifyPass:I

    .line 25
    invoke-virtual {p0}, Lcom/cyjh/elfin/activity/AdActivity;->getIntent()Landroid/content/Intent;

    move-result-object v3

    const-class v4, Lcom/cyjh/elfin/activity/AdActivity;

    invoke-virtual {v4}, Ljava/lang/Class;->getCanonicalName()Ljava/lang/String;

    move-result-object v4

    invoke-virtual {v3, v4}, Landroid/content/Intent;->getParcelableExtra(Ljava/lang/String;)Landroid/os/Parcelable;

    move-result-object v0

    check-cast v0, Lcom/cyjh/elfin/entity/AdPassData;

    .line 26
    .local v0, "adPassData":Lcom/cyjh/elfin/entity/AdPassData;
    new-instance v3, Ljava/lang/StringBuilder;

    invoke-direct {v3}, Ljava/lang/StringBuilder;-><init>()V

    const-string v4, "\u5e7f\u544a\u4f20\u9012\u7684\u6570\u636e\uff1a"

    invoke-virtual {v3, v4}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v3

    invoke-virtual {v0}, Lcom/cyjh/elfin/entity/AdPassData;->toString()Ljava/lang/String;

    move-result-object v4

    invoke-virtual {v3, v4}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v3

    invoke-virtual {v3}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v3

    const/4 v4, 0x0

    new-array v4, v4, [Ljava/lang/Object;

    invoke-static {v3, v4}, Lcom/orhanobut/logger/Logger;->e(Ljava/lang/String;[Ljava/lang/Object;)V

    .line 27
    invoke-static {p0}, Lcom/cyjh/elfin/util/NetworkUtils;->isAvailable(Landroid/content/Context;)Z

    move-result v2

    .line 28
    .local v2, "isConnectedStatus":Z
    if-eqz v2, :cond_0

    .line 29
    invoke-virtual {p0}, Lcom/cyjh/elfin/activity/AdActivity;->getSupportFragmentManager()Landroid/support/v4/app/FragmentManager;

    move-result-object v3

    invoke-virtual {v3}, Landroid/support/v4/app/FragmentManager;->beginTransaction()Landroid/support/v4/app/FragmentTransaction;

    move-result-object v1

    .line 30
    .local v1, "ft":Landroid/support/v4/app/FragmentTransaction;
    const v3, 0x7f0f006e

    invoke-static {v0}, Lcom/cyjh/elfin/fragment/AdFragment;->newInstance(Lcom/cyjh/elfin/entity/AdPassData;)Lcom/cyjh/elfin/fragment/AdFragment;

    move-result-object v4

    invoke-virtual {v1, v3, v4}, Landroid/support/v4/app/FragmentTransaction;->replace(ILandroid/support/v4/app/Fragment;)Landroid/support/v4/app/FragmentTransaction;

    move-result-object v3

    invoke-virtual {v3}, Landroid/support/v4/app/FragmentTransaction;->commit()I

    .line 36
    .end local v1    # "ft":Landroid/support/v4/app/FragmentTransaction;
    :goto_0
    return-void

    .line 32
    :cond_0
    invoke-static {p0}, Lcom/cyjh/elfin/activity/ElfinFreeActivity;->toCallActivity(Landroid/content/Context;)V

    .line 33
    invoke-virtual {p0}, Lcom/cyjh/elfin/activity/AdActivity;->finish()V

    goto :goto_0
.end method

.method public onPause()V
    .locals 0

    .prologue
    .line 46
    invoke-super {p0}, Lcom/cyjh/elfin/activity/BaseActivity;->onPause()V

    .line 47
    invoke-static {p0}, Lcom/umeng/analytics/MobclickAgent;->onPause(Landroid/content/Context;)V

    .line 48
    return-void
.end method

.method public onResume()V
    .locals 0

    .prologue
    .line 40
    invoke-super {p0}, Lcom/cyjh/elfin/activity/BaseActivity;->onResume()V

    .line 41
    invoke-static {p0}, Lcom/umeng/analytics/MobclickAgent;->onResume(Landroid/content/Context;)V

    .line 43
    return-void
.end method
