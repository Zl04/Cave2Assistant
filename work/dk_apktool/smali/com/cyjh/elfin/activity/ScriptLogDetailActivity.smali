.class public Lcom/cyjh/elfin/activity/ScriptLogDetailActivity;
.super Lcom/cyjh/elfin/activity/BaseActivity;
.source "ScriptLogDetailActivity.java"

# interfaces
.implements Landroid/view/View$OnClickListener;


# annotations
.annotation system Ldalvik/annotation/MemberClasses;
    value = {
        Lcom/cyjh/elfin/activity/ScriptLogDetailActivity$ReadScriptLogTask;,
        Lcom/cyjh/elfin/activity/ScriptLogDetailActivity$OnLeftImageViewListener;
    }
.end annotation


# instance fields
.field private btnShowMore:Landroid/widget/Button;

.field private isLastScriptLog:Z

.field private scriptLog:Lcom/cyjh/elfin/entity/ScriptLog;

.field private titleView:Lcom/cyjh/elfin/customview/TitleView;

.field private tvScriptLog:Landroid/widget/TextView;


# direct methods
.method public constructor <init>()V
    .locals 0

    .prologue
    .line 20
    invoke-direct {p0}, Lcom/cyjh/elfin/activity/BaseActivity;-><init>()V

    return-void
.end method

.method static synthetic access$200(Lcom/cyjh/elfin/activity/ScriptLogDetailActivity;)Lcom/cyjh/elfin/entity/ScriptLog;
    .locals 1
    .param p0, "x0"    # Lcom/cyjh/elfin/activity/ScriptLogDetailActivity;

    .prologue
    .line 20
    iget-object v0, p0, Lcom/cyjh/elfin/activity/ScriptLogDetailActivity;->scriptLog:Lcom/cyjh/elfin/entity/ScriptLog;

    return-object v0
.end method

.method static synthetic access$300(Lcom/cyjh/elfin/activity/ScriptLogDetailActivity;)Landroid/widget/TextView;
    .locals 1
    .param p0, "x0"    # Lcom/cyjh/elfin/activity/ScriptLogDetailActivity;

    .prologue
    .line 20
    iget-object v0, p0, Lcom/cyjh/elfin/activity/ScriptLogDetailActivity;->tvScriptLog:Landroid/widget/TextView;

    return-object v0
.end method

.method private initScriptLog()V
    .locals 3

    .prologue
    .line 52
    invoke-virtual {p0}, Lcom/cyjh/elfin/activity/ScriptLogDetailActivity;->getIntent()Landroid/content/Intent;

    move-result-object v0

    .line 53
    .local v0, "intent":Landroid/content/Intent;
    const-string v1, "com.cyjh.elfin.activity.SettingActivity.FlagLastLog"

    const/4 v2, 0x0

    invoke-virtual {v0, v1, v2}, Landroid/content/Intent;->getBooleanExtra(Ljava/lang/String;Z)Z

    move-result v1

    iput-boolean v1, p0, Lcom/cyjh/elfin/activity/ScriptLogDetailActivity;->isLastScriptLog:Z

    .line 54
    const-string v1, "com.cyjh.elfin.activity.ScriptLogActivity.ScriptLog"

    invoke-virtual {v0, v1}, Landroid/content/Intent;->getParcelableExtra(Ljava/lang/String;)Landroid/os/Parcelable;

    move-result-object v1

    check-cast v1, Lcom/cyjh/elfin/entity/ScriptLog;

    iput-object v1, p0, Lcom/cyjh/elfin/activity/ScriptLogDetailActivity;->scriptLog:Lcom/cyjh/elfin/entity/ScriptLog;

    .line 55
    return-void
.end method

.method private initShowMoreButton()V
    .locals 2

    .prologue
    .line 74
    const v0, 0x7f0f0089

    invoke-virtual {p0, v0}, Lcom/cyjh/elfin/activity/ScriptLogDetailActivity;->findViewById(I)Landroid/view/View;

    move-result-object v0

    check-cast v0, Landroid/widget/Button;

    iput-object v0, p0, Lcom/cyjh/elfin/activity/ScriptLogDetailActivity;->btnShowMore:Landroid/widget/Button;

    .line 75
    iget-boolean v0, p0, Lcom/cyjh/elfin/activity/ScriptLogDetailActivity;->isLastScriptLog:Z

    if-eqz v0, :cond_0

    .line 76
    iget-object v0, p0, Lcom/cyjh/elfin/activity/ScriptLogDetailActivity;->btnShowMore:Landroid/widget/Button;

    const/4 v1, 0x0

    invoke-virtual {v0, v1}, Landroid/widget/Button;->setVisibility(I)V

    .line 77
    iget-object v0, p0, Lcom/cyjh/elfin/activity/ScriptLogDetailActivity;->btnShowMore:Landroid/widget/Button;

    invoke-virtual {v0, p0}, Landroid/widget/Button;->setOnClickListener(Landroid/view/View$OnClickListener;)V

    .line 81
    :goto_0
    return-void

    .line 79
    :cond_0
    iget-object v0, p0, Lcom/cyjh/elfin/activity/ScriptLogDetailActivity;->btnShowMore:Landroid/widget/Button;

    const/16 v1, 0x8

    invoke-virtual {v0, v1}, Landroid/widget/Button;->setVisibility(I)V

    goto :goto_0
.end method

.method private initTitle()V
    .locals 3

    .prologue
    .line 65
    const v0, 0x7f0f0087

    invoke-virtual {p0, v0}, Lcom/cyjh/elfin/activity/ScriptLogDetailActivity;->findViewById(I)Landroid/view/View;

    move-result-object v0

    check-cast v0, Lcom/cyjh/elfin/customview/TitleView;

    iput-object v0, p0, Lcom/cyjh/elfin/activity/ScriptLogDetailActivity;->titleView:Lcom/cyjh/elfin/customview/TitleView;

    .line 66
    iget-object v0, p0, Lcom/cyjh/elfin/activity/ScriptLogDetailActivity;->titleView:Lcom/cyjh/elfin/customview/TitleView;

    iget-object v1, p0, Lcom/cyjh/elfin/activity/ScriptLogDetailActivity;->scriptLog:Lcom/cyjh/elfin/entity/ScriptLog;

    invoke-virtual {v1}, Lcom/cyjh/elfin/entity/ScriptLog;->getName()Ljava/lang/String;

    move-result-object v1

    invoke-virtual {v0, v1}, Lcom/cyjh/elfin/customview/TitleView;->setTitleText(Ljava/lang/String;)V

    .line 67
    iget-object v0, p0, Lcom/cyjh/elfin/activity/ScriptLogDetailActivity;->titleView:Lcom/cyjh/elfin/customview/TitleView;

    const/4 v1, 0x4

    invoke-virtual {v0, v1}, Lcom/cyjh/elfin/customview/TitleView;->setVisibilityRightImage(I)V

    .line 68
    iget-object v0, p0, Lcom/cyjh/elfin/activity/ScriptLogDetailActivity;->titleView:Lcom/cyjh/elfin/customview/TitleView;

    const v1, 0x7f02008f

    invoke-virtual {v0, v1}, Lcom/cyjh/elfin/customview/TitleView;->setleftImage(I)V

    .line 69
    iget-object v0, p0, Lcom/cyjh/elfin/activity/ScriptLogDetailActivity;->titleView:Lcom/cyjh/elfin/customview/TitleView;

    new-instance v1, Lcom/cyjh/elfin/activity/ScriptLogDetailActivity$OnLeftImageViewListener;

    const/4 v2, 0x0

    invoke-direct {v1, p0, v2}, Lcom/cyjh/elfin/activity/ScriptLogDetailActivity$OnLeftImageViewListener;-><init>(Lcom/cyjh/elfin/activity/ScriptLogDetailActivity;Lcom/cyjh/elfin/activity/ScriptLogDetailActivity$1;)V

    invoke-virtual {v0, v1}, Lcom/cyjh/elfin/customview/TitleView;->setOnLeftImageViewListener(Lcom/cyjh/elfin/customview/TitleView$OnLeftImageViewListener;)V

    .line 70
    iget-object v0, p0, Lcom/cyjh/elfin/activity/ScriptLogDetailActivity;->titleView:Lcom/cyjh/elfin/customview/TitleView;

    const/16 v1, 0x12

    invoke-virtual {v0, v1}, Lcom/cyjh/elfin/customview/TitleView;->setTitleSize(I)V

    .line 71
    return-void
.end method

.method private initView()V
    .locals 4

    .prologue
    .line 58
    invoke-direct {p0}, Lcom/cyjh/elfin/activity/ScriptLogDetailActivity;->initTitle()V

    .line 59
    invoke-direct {p0}, Lcom/cyjh/elfin/activity/ScriptLogDetailActivity;->initShowMoreButton()V

    .line 60
    const v0, 0x7f0f0088

    invoke-virtual {p0, v0}, Lcom/cyjh/elfin/activity/ScriptLogDetailActivity;->findViewById(I)Landroid/view/View;

    move-result-object v0

    check-cast v0, Landroid/widget/TextView;

    iput-object v0, p0, Lcom/cyjh/elfin/activity/ScriptLogDetailActivity;->tvScriptLog:Landroid/widget/TextView;

    .line 61
    new-instance v0, Lcom/cyjh/elfin/activity/ScriptLogDetailActivity$ReadScriptLogTask;

    const/4 v1, 0x0

    invoke-direct {v0, p0, v1}, Lcom/cyjh/elfin/activity/ScriptLogDetailActivity$ReadScriptLogTask;-><init>(Lcom/cyjh/elfin/activity/ScriptLogDetailActivity;Lcom/cyjh/elfin/activity/ScriptLogDetailActivity$1;)V

    const/4 v1, 0x1

    new-array v1, v1, [Ljava/io/File;

    const/4 v2, 0x0

    iget-object v3, p0, Lcom/cyjh/elfin/activity/ScriptLogDetailActivity;->scriptLog:Lcom/cyjh/elfin/entity/ScriptLog;

    invoke-virtual {v3}, Lcom/cyjh/elfin/entity/ScriptLog;->getFile()Ljava/io/File;

    move-result-object v3

    aput-object v3, v1, v2

    invoke-virtual {v0, v1}, Lcom/cyjh/elfin/activity/ScriptLogDetailActivity$ReadScriptLogTask;->execute([Ljava/lang/Object;)Landroid/os/AsyncTask;

    .line 62
    return-void
.end method


# virtual methods
.method public onClick(Landroid/view/View;)V
    .locals 2
    .param p1, "v"    # Landroid/view/View;

    .prologue
    .line 129
    invoke-virtual {p1}, Landroid/view/View;->getId()I

    move-result v0

    packed-switch v0, :pswitch_data_0

    .line 137
    :goto_0
    return-void

    .line 131
    :pswitch_0
    new-instance v0, Landroid/content/Intent;

    const-class v1, Lcom/cyjh/elfin/activity/ScriptLogActivity;

    invoke-direct {v0, p0, v1}, Landroid/content/Intent;-><init>(Landroid/content/Context;Ljava/lang/Class;)V

    invoke-virtual {p0, v0}, Lcom/cyjh/elfin/activity/ScriptLogDetailActivity;->startActivity(Landroid/content/Intent;)V

    goto :goto_0

    .line 129
    nop

    :pswitch_data_0
    .packed-switch 0x7f0f0089
        :pswitch_0
    .end packed-switch
.end method

.method protected onCreate(Landroid/os/Bundle;)V
    .locals 1
    .param p1, "savedInstanceState"    # Landroid/os/Bundle;

    .prologue
    .line 31
    invoke-super {p0, p1}, Lcom/cyjh/elfin/activity/BaseActivity;->onCreate(Landroid/os/Bundle;)V

    .line 32
    const v0, 0x7f040026

    invoke-virtual {p0, v0}, Lcom/cyjh/elfin/activity/ScriptLogDetailActivity;->setContentView(I)V

    .line 33
    invoke-direct {p0}, Lcom/cyjh/elfin/activity/ScriptLogDetailActivity;->initScriptLog()V

    .line 34
    invoke-direct {p0}, Lcom/cyjh/elfin/activity/ScriptLogDetailActivity;->initView()V

    .line 35
    return-void
.end method

.method protected onPause()V
    .locals 1

    .prologue
    .line 46
    invoke-super {p0}, Lcom/cyjh/elfin/activity/BaseActivity;->onPause()V

    .line 47
    const-class v0, Lcom/cyjh/elfin/activity/ScriptLogDetailActivity;

    invoke-virtual {v0}, Ljava/lang/Class;->getCanonicalName()Ljava/lang/String;

    move-result-object v0

    invoke-static {v0}, Lcom/umeng/analytics/MobclickAgent;->onPageEnd(Ljava/lang/String;)V

    .line 48
    invoke-static {p0}, Lcom/umeng/analytics/MobclickAgent;->onPause(Landroid/content/Context;)V

    .line 49
    return-void
.end method

.method protected onResume()V
    .locals 1

    .prologue
    .line 39
    invoke-super {p0}, Lcom/cyjh/elfin/activity/BaseActivity;->onResume()V

    .line 40
    const-class v0, Lcom/cyjh/elfin/activity/ScriptLogDetailActivity;

    invoke-virtual {v0}, Ljava/lang/Class;->getCanonicalName()Ljava/lang/String;

    move-result-object v0

    invoke-static {v0}, Lcom/umeng/analytics/MobclickAgent;->onPageStart(Ljava/lang/String;)V

    .line 41
    invoke-static {p0}, Lcom/umeng/analytics/MobclickAgent;->onResume(Landroid/content/Context;)V

    .line 42
    return-void
.end method
