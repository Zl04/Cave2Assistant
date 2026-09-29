.class public Lcom/cyjh/elfin/dialog/MIUIGuideDialog;
.super Lcom/cyjh/elfin/dialog/BaseDialog;
.source "MIUIGuideDialog.java"

# interfaces
.implements Landroid/view/View$OnClickListener;


# instance fields
.field private mButtonOpen:Landroid/widget/Button;


# direct methods
.method public constructor <init>(Landroid/content/Context;)V
    .locals 1
    .param p1, "context"    # Landroid/content/Context;

    .prologue
    .line 19
    const v0, 0x7f0a00f8

    invoke-direct {p0, p1, v0}, Lcom/cyjh/elfin/dialog/BaseDialog;-><init>(Landroid/content/Context;I)V

    .line 20
    return-void
.end method

.method private getAppDetailSettingIntent()Landroid/content/Intent;
    .locals 4

    .prologue
    .line 57
    new-instance v0, Landroid/content/Intent;

    invoke-direct {v0}, Landroid/content/Intent;-><init>()V

    .line 58
    .local v0, "localIntent":Landroid/content/Intent;
    const/high16 v1, 0x10000000

    invoke-virtual {v0, v1}, Landroid/content/Intent;->addFlags(I)Landroid/content/Intent;

    .line 59
    sget v1, Landroid/os/Build$VERSION;->SDK_INT:I

    const/16 v2, 0x9

    if-lt v1, v2, :cond_1

    .line 61
    const-string v1, "android.settings.APPLICATION_DETAILS_SETTINGS"

    invoke-virtual {v0, v1}, Landroid/content/Intent;->setAction(Ljava/lang/String;)Landroid/content/Intent;

    .line 62
    const-string v1, "package"

    invoke-virtual {p0}, Lcom/cyjh/elfin/dialog/MIUIGuideDialog;->getContext()Landroid/content/Context;

    move-result-object v2

    invoke-virtual {v2}, Landroid/content/Context;->getPackageName()Ljava/lang/String;

    move-result-object v2

    const/4 v3, 0x0

    invoke-static {v1, v2, v3}, Landroid/net/Uri;->fromParts(Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;)Landroid/net/Uri;

    move-result-object v1

    invoke-virtual {v0, v1}, Landroid/content/Intent;->setData(Landroid/net/Uri;)Landroid/content/Intent;

    .line 68
    :cond_0
    :goto_0
    return-object v0

    .line 63
    :cond_1
    sget v1, Landroid/os/Build$VERSION;->SDK_INT:I

    const/16 v2, 0x8

    if-gt v1, v2, :cond_0

    .line 64
    const-string v1, "android.intent.action.VIEW"

    invoke-virtual {v0, v1}, Landroid/content/Intent;->setAction(Ljava/lang/String;)Landroid/content/Intent;

    .line 65
    const-string v1, "com.android.settings"

    const-string v2, "com.android.settings.InstalledAppDetails"

    invoke-virtual {v0, v1, v2}, Landroid/content/Intent;->setClassName(Ljava/lang/String;Ljava/lang/String;)Landroid/content/Intent;

    .line 66
    const-string v1, "com.android.settings.ApplicationPkgName"

    invoke-virtual {p0}, Lcom/cyjh/elfin/dialog/MIUIGuideDialog;->getContext()Landroid/content/Context;

    move-result-object v2

    invoke-virtual {v2}, Landroid/content/Context;->getPackageName()Ljava/lang/String;

    move-result-object v2

    invoke-virtual {v0, v1, v2}, Landroid/content/Intent;->putExtra(Ljava/lang/String;Ljava/lang/String;)Landroid/content/Intent;

    goto :goto_0
.end method

.method private initView()V
    .locals 1

    .prologue
    .line 31
    const v0, 0x7f0f00bc

    invoke-virtual {p0, v0}, Lcom/cyjh/elfin/dialog/MIUIGuideDialog;->findViewById(I)Landroid/view/View;

    move-result-object v0

    check-cast v0, Landroid/widget/Button;

    iput-object v0, p0, Lcom/cyjh/elfin/dialog/MIUIGuideDialog;->mButtonOpen:Landroid/widget/Button;

    .line 32
    iget-object v0, p0, Lcom/cyjh/elfin/dialog/MIUIGuideDialog;->mButtonOpen:Landroid/widget/Button;

    invoke-virtual {v0, p0}, Landroid/widget/Button;->setOnClickListener(Landroid/view/View$OnClickListener;)V

    .line 33
    return-void
.end method


# virtual methods
.method public onClick(Landroid/view/View;)V
    .locals 3
    .param p1, "v"    # Landroid/view/View;

    .prologue
    .line 37
    invoke-virtual {p1}, Landroid/view/View;->getId()I

    move-result v1

    packed-switch v1, :pswitch_data_0

    .line 49
    :goto_0
    return-void

    .line 39
    :pswitch_0
    invoke-virtual {p0}, Lcom/cyjh/elfin/dialog/MIUIGuideDialog;->getContext()Landroid/content/Context;

    move-result-object v1

    invoke-direct {p0}, Lcom/cyjh/elfin/dialog/MIUIGuideDialog;->getAppDetailSettingIntent()Landroid/content/Intent;

    move-result-object v2

    invoke-virtual {v1, v2}, Landroid/content/Context;->startActivity(Landroid/content/Intent;)V

    .line 40
    iget-object v1, p0, Lcom/cyjh/elfin/dialog/MIUIGuideDialog;->mAppContext:Lcom/cyjh/elfin/AppContext;

    iget-object v1, v1, Lcom/cyjh/elfin/AppContext;->sharedPreferences:Landroid/content/SharedPreferences;

    invoke-interface {v1}, Landroid/content/SharedPreferences;->edit()Landroid/content/SharedPreferences$Editor;

    move-result-object v0

    .line 41
    .local v0, "edit":Landroid/content/SharedPreferences$Editor;
    const-string v1, "com.cyjh.elfin.20150527"

    const/4 v2, 0x0

    invoke-interface {v0, v1, v2}, Landroid/content/SharedPreferences$Editor;->putBoolean(Ljava/lang/String;Z)Landroid/content/SharedPreferences$Editor;

    .line 42
    invoke-interface {v0}, Landroid/content/SharedPreferences$Editor;->commit()Z

    .line 43
    invoke-virtual {p0}, Lcom/cyjh/elfin/dialog/MIUIGuideDialog;->dismiss()V

    goto :goto_0

    .line 37
    :pswitch_data_0
    .packed-switch 0x7f0f00bc
        :pswitch_0
    .end packed-switch
.end method

.method protected onCreate(Landroid/os/Bundle;)V
    .locals 2
    .param p1, "savedInstanceState"    # Landroid/os/Bundle;

    .prologue
    .line 24
    invoke-super {p0, p1}, Lcom/cyjh/elfin/dialog/BaseDialog;->onCreate(Landroid/os/Bundle;)V

    .line 25
    const v0, 0x7f040038

    invoke-virtual {p0, v0}, Lcom/cyjh/elfin/dialog/MIUIGuideDialog;->setContentView(I)V

    .line 26
    const v0, 0x3f4ccccd    # 0.8f

    const v1, 0x3ecccccd    # 0.4f

    invoke-virtual {p0, v0, v1}, Lcom/cyjh/elfin/dialog/MIUIGuideDialog;->setDialogSize(FF)V

    .line 27
    invoke-direct {p0}, Lcom/cyjh/elfin/dialog/MIUIGuideDialog;->initView()V

    .line 28
    return-void
.end method
