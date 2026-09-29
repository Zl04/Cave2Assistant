.class public Lcom/cyjh/elfin/activity/SettingActivity;
.super Lcom/cyjh/elfin/activity/BaseActivity;
.source "SettingActivity.java"

# interfaces
.implements Landroid/widget/CompoundButton$OnCheckedChangeListener;
.implements Landroid/view/View$OnClickListener;


# annotations
.annotation system Ldalvik/annotation/MemberClasses;
    value = {
        Lcom/cyjh/elfin/activity/SettingActivity$SubmitTimeCount;,
        Lcom/cyjh/elfin/activity/SettingActivity$OnLeftImageViewListener;
    }
.end annotation


# static fields
.field public static final DEFAULT_THREE_SECOND:I = 0xbb8

.field private static final REQUEST_CODE_FEEDBACK:I = 0x1

.field public static final TIME_INTERVAL:I = 0x3e8


# instance fields
.field private feedBackCommitDialog:Lcom/cyjh/feedback/lib/dialog/FeedBackCommitDialog;

.field private mSubmitTimeCount:Lcom/cyjh/elfin/activity/SettingActivity$SubmitTimeCount;

.field private swtCallStop:Landroid/widget/Switch;

.field private swtFloatviewCtrl:Landroid/widget/Switch;

.field private swtVibration:Landroid/widget/Switch;

.field private swtVolumeKeyCtrl:Landroid/widget/Switch;

.field private swtWaggleStop:Landroid/widget/Switch;


# direct methods
.method public constructor <init>()V
    .locals 0

    .prologue
    .line 43
    invoke-direct {p0}, Lcom/cyjh/elfin/activity/BaseActivity;-><init>()V

    return-void
.end method

.method static synthetic access$200(Lcom/cyjh/elfin/activity/SettingActivity;)Lcom/cyjh/feedback/lib/dialog/FeedBackCommitDialog;
    .locals 1
    .param p0, "x0"    # Lcom/cyjh/elfin/activity/SettingActivity;

    .prologue
    .line 43
    iget-object v0, p0, Lcom/cyjh/elfin/activity/SettingActivity;->feedBackCommitDialog:Lcom/cyjh/feedback/lib/dialog/FeedBackCommitDialog;

    return-object v0
.end method

.method private initSwtichStatus()V
    .locals 4

    .prologue
    const/4 v3, 0x1

    .line 102
    iget-object v0, p0, Lcom/cyjh/elfin/activity/SettingActivity;->swtCallStop:Landroid/widget/Switch;

    iget-object v1, p0, Lcom/cyjh/elfin/activity/SettingActivity;->appContext:Lcom/cyjh/elfin/AppContext;

    iget-object v1, v1, Lcom/cyjh/elfin/AppContext;->sharedPreferences:Landroid/content/SharedPreferences;

    const-string v2, "com.cyjh.elfin.activity.SettingActivity.swtCallStop"

    invoke-interface {v1, v2, v3}, Landroid/content/SharedPreferences;->getBoolean(Ljava/lang/String;Z)Z

    move-result v1

    invoke-virtual {v0, v1}, Landroid/widget/Switch;->setChecked(Z)V

    .line 103
    iget-object v0, p0, Lcom/cyjh/elfin/activity/SettingActivity;->swtVolumeKeyCtrl:Landroid/widget/Switch;

    iget-object v1, p0, Lcom/cyjh/elfin/activity/SettingActivity;->appContext:Lcom/cyjh/elfin/AppContext;

    iget-object v1, v1, Lcom/cyjh/elfin/AppContext;->sharedPreferences:Landroid/content/SharedPreferences;

    const-string v2, "com.cyjh.elfin.activity.SettingActivity.swtVolumeKeyCtrl"

    invoke-interface {v1, v2, v3}, Landroid/content/SharedPreferences;->getBoolean(Ljava/lang/String;Z)Z

    move-result v1

    invoke-virtual {v0, v1}, Landroid/widget/Switch;->setChecked(Z)V

    .line 104
    iget-object v0, p0, Lcom/cyjh/elfin/activity/SettingActivity;->swtWaggleStop:Landroid/widget/Switch;

    iget-object v1, p0, Lcom/cyjh/elfin/activity/SettingActivity;->appContext:Lcom/cyjh/elfin/AppContext;

    iget-object v1, v1, Lcom/cyjh/elfin/AppContext;->sharedPreferences:Landroid/content/SharedPreferences;

    const-string v2, "com.cyjh.elfin.activity.SettingActivity.swtWaggleStop"

    invoke-interface {v1, v2, v3}, Landroid/content/SharedPreferences;->getBoolean(Ljava/lang/String;Z)Z

    move-result v1

    invoke-virtual {v0, v1}, Landroid/widget/Switch;->setChecked(Z)V

    .line 105
    iget-object v0, p0, Lcom/cyjh/elfin/activity/SettingActivity;->swtFloatviewCtrl:Landroid/widget/Switch;

    iget-object v1, p0, Lcom/cyjh/elfin/activity/SettingActivity;->appContext:Lcom/cyjh/elfin/AppContext;

    iget-object v1, v1, Lcom/cyjh/elfin/AppContext;->sharedPreferences:Landroid/content/SharedPreferences;

    const-string v2, "com.cyjh.elfin.activity.SettingActivity.swtFloatviewCtrl"

    invoke-interface {v1, v2, v3}, Landroid/content/SharedPreferences;->getBoolean(Ljava/lang/String;Z)Z

    move-result v1

    invoke-virtual {v0, v1}, Landroid/widget/Switch;->setChecked(Z)V

    .line 106
    iget-object v0, p0, Lcom/cyjh/elfin/activity/SettingActivity;->swtVibration:Landroid/widget/Switch;

    iget-object v1, p0, Lcom/cyjh/elfin/activity/SettingActivity;->appContext:Lcom/cyjh/elfin/AppContext;

    iget-object v1, v1, Lcom/cyjh/elfin/AppContext;->sharedPreferences:Landroid/content/SharedPreferences;

    const-string v2, "com.cyjh.elfin.activity.SettingActivity.swtVibration"

    invoke-interface {v1, v2, v3}, Landroid/content/SharedPreferences;->getBoolean(Ljava/lang/String;Z)Z

    move-result v1

    invoke-virtual {v0, v1}, Landroid/widget/Switch;->setChecked(Z)V

    .line 107
    return-void
.end method

.method private initTitle()V
    .locals 3

    .prologue
    .line 93
    const v1, 0x7f0f008a

    invoke-virtual {p0, v1}, Lcom/cyjh/elfin/activity/SettingActivity;->findViewById(I)Landroid/view/View;

    move-result-object v0

    check-cast v0, Lcom/cyjh/elfin/customview/TitleView;

    .line 94
    .local v0, "titleView":Lcom/cyjh/elfin/customview/TitleView;
    const v1, 0x7f0800ea

    invoke-virtual {v0, v1}, Lcom/cyjh/elfin/customview/TitleView;->setTitleText(I)V

    .line 95
    const/4 v1, 0x0

    invoke-virtual {v0, v1}, Lcom/cyjh/elfin/customview/TitleView;->setVisibilityLeftImage(I)V

    .line 96
    const v1, 0x7f02008f

    invoke-virtual {v0, v1}, Lcom/cyjh/elfin/customview/TitleView;->setleftImage(I)V

    .line 97
    new-instance v1, Lcom/cyjh/elfin/activity/SettingActivity$OnLeftImageViewListener;

    const/4 v2, 0x0

    invoke-direct {v1, p0, v2}, Lcom/cyjh/elfin/activity/SettingActivity$OnLeftImageViewListener;-><init>(Lcom/cyjh/elfin/activity/SettingActivity;Lcom/cyjh/elfin/activity/SettingActivity$1;)V

    invoke-virtual {v0, v1}, Lcom/cyjh/elfin/customview/TitleView;->setOnLeftImageViewListener(Lcom/cyjh/elfin/customview/TitleView$OnLeftImageViewListener;)V

    .line 98
    const/4 v1, 0x4

    invoke-virtual {v0, v1}, Lcom/cyjh/elfin/customview/TitleView;->setVisibilityRightImage(I)V

    .line 99
    return-void
.end method

.method private initView()V
    .locals 5

    .prologue
    .line 67
    invoke-direct {p0}, Lcom/cyjh/elfin/activity/SettingActivity;->initTitle()V

    .line 69
    const v4, 0x7f0f008e

    invoke-virtual {p0, v4}, Lcom/cyjh/elfin/activity/SettingActivity;->findViewById(I)Landroid/view/View;

    move-result-object v4

    check-cast v4, Landroid/widget/Switch;

    iput-object v4, p0, Lcom/cyjh/elfin/activity/SettingActivity;->swtCallStop:Landroid/widget/Switch;

    .line 70
    const v4, 0x7f0f008b

    invoke-virtual {p0, v4}, Lcom/cyjh/elfin/activity/SettingActivity;->findViewById(I)Landroid/view/View;

    move-result-object v4

    check-cast v4, Landroid/widget/Switch;

    iput-object v4, p0, Lcom/cyjh/elfin/activity/SettingActivity;->swtVolumeKeyCtrl:Landroid/widget/Switch;

    .line 71
    const v4, 0x7f0f008d

    invoke-virtual {p0, v4}, Lcom/cyjh/elfin/activity/SettingActivity;->findViewById(I)Landroid/view/View;

    move-result-object v4

    check-cast v4, Landroid/widget/Switch;

    iput-object v4, p0, Lcom/cyjh/elfin/activity/SettingActivity;->swtWaggleStop:Landroid/widget/Switch;

    .line 72
    const v4, 0x7f0f008c

    invoke-virtual {p0, v4}, Lcom/cyjh/elfin/activity/SettingActivity;->findViewById(I)Landroid/view/View;

    move-result-object v4

    check-cast v4, Landroid/widget/Switch;

    iput-object v4, p0, Lcom/cyjh/elfin/activity/SettingActivity;->swtFloatviewCtrl:Landroid/widget/Switch;

    .line 73
    const v4, 0x7f0f008f

    invoke-virtual {p0, v4}, Lcom/cyjh/elfin/activity/SettingActivity;->findViewById(I)Landroid/view/View;

    move-result-object v4

    check-cast v4, Landroid/widget/Switch;

    iput-object v4, p0, Lcom/cyjh/elfin/activity/SettingActivity;->swtVibration:Landroid/widget/Switch;

    .line 74
    const v4, 0x7f0f0090

    invoke-virtual {p0, v4}, Lcom/cyjh/elfin/activity/SettingActivity;->findViewById(I)Landroid/view/View;

    move-result-object v0

    check-cast v0, Landroid/widget/Button;

    .line 75
    .local v0, "btnScriptLog":Landroid/widget/Button;
    const v4, 0x7f0f0091

    invoke-virtual {p0, v4}, Lcom/cyjh/elfin/activity/SettingActivity;->findViewById(I)Landroid/view/View;

    move-result-object v3

    check-cast v3, Landroid/widget/Button;

    .line 76
    .local v3, "mButtonUpdate":Landroid/widget/Button;
    const v4, 0x7f0f0093

    invoke-virtual {p0, v4}, Lcom/cyjh/elfin/activity/SettingActivity;->findViewById(I)Landroid/view/View;

    move-result-object v1

    check-cast v1, Landroid/widget/Button;

    .line 77
    .local v1, "mButtonExitApp":Landroid/widget/Button;
    const v4, 0x7f0f0092

    invoke-virtual {p0, v4}, Lcom/cyjh/elfin/activity/SettingActivity;->findViewById(I)Landroid/view/View;

    move-result-object v2

    check-cast v2, Landroid/widget/Button;

    .line 79
    .local v2, "mButtonFeedback":Landroid/widget/Button;
    iget-object v4, p0, Lcom/cyjh/elfin/activity/SettingActivity;->swtCallStop:Landroid/widget/Switch;

    invoke-virtual {v4, p0}, Landroid/widget/Switch;->setOnCheckedChangeListener(Landroid/widget/CompoundButton$OnCheckedChangeListener;)V

    .line 80
    iget-object v4, p0, Lcom/cyjh/elfin/activity/SettingActivity;->swtVolumeKeyCtrl:Landroid/widget/Switch;

    invoke-virtual {v4, p0}, Landroid/widget/Switch;->setOnCheckedChangeListener(Landroid/widget/CompoundButton$OnCheckedChangeListener;)V

    .line 81
    iget-object v4, p0, Lcom/cyjh/elfin/activity/SettingActivity;->swtWaggleStop:Landroid/widget/Switch;

    invoke-virtual {v4, p0}, Landroid/widget/Switch;->setOnCheckedChangeListener(Landroid/widget/CompoundButton$OnCheckedChangeListener;)V

    .line 82
    iget-object v4, p0, Lcom/cyjh/elfin/activity/SettingActivity;->swtFloatviewCtrl:Landroid/widget/Switch;

    invoke-virtual {v4, p0}, Landroid/widget/Switch;->setOnCheckedChangeListener(Landroid/widget/CompoundButton$OnCheckedChangeListener;)V

    .line 83
    iget-object v4, p0, Lcom/cyjh/elfin/activity/SettingActivity;->swtVibration:Landroid/widget/Switch;

    invoke-virtual {v4, p0}, Landroid/widget/Switch;->setOnCheckedChangeListener(Landroid/widget/CompoundButton$OnCheckedChangeListener;)V

    .line 84
    invoke-virtual {v0, p0}, Landroid/widget/Button;->setOnClickListener(Landroid/view/View$OnClickListener;)V

    .line 85
    invoke-virtual {v3, p0}, Landroid/widget/Button;->setOnClickListener(Landroid/view/View$OnClickListener;)V

    .line 86
    invoke-virtual {v1, p0}, Landroid/widget/Button;->setOnClickListener(Landroid/view/View$OnClickListener;)V

    .line 87
    invoke-virtual {v2, p0}, Landroid/widget/Button;->setOnClickListener(Landroid/view/View$OnClickListener;)V

    .line 89
    invoke-direct {p0}, Lcom/cyjh/elfin/activity/SettingActivity;->initSwtichStatus()V

    .line 90
    return-void
.end method


# virtual methods
.method protected onActivityResult(IILandroid/content/Intent;)V
    .locals 7
    .param p1, "requestCode"    # I
    .param p2, "resultCode"    # I
    .param p3, "data"    # Landroid/content/Intent;

    .prologue
    .line 214
    invoke-super {p0, p1, p2, p3}, Lcom/cyjh/elfin/activity/BaseActivity;->onActivityResult(IILandroid/content/Intent;)V

    .line 215
    new-instance v0, Ljava/lang/StringBuilder;

    invoke-direct {v0}, Ljava/lang/StringBuilder;-><init>()V

    const-string v1, "resultCode = "

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-virtual {v0, p2}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-virtual {v0}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v0

    const/4 v1, 0x0

    new-array v1, v1, [Ljava/lang/Object;

    invoke-static {v0, v1}, Lcom/orhanobut/logger/Logger;->e(Ljava/lang/String;[Ljava/lang/Object;)V

    .line 216
    packed-switch p1, :pswitch_data_0

    .line 228
    :cond_0
    :goto_0
    return-void

    .line 218
    :pswitch_0
    const/4 v0, -0x1

    if-ne p2, v0, :cond_0

    .line 219
    new-instance v0, Lcom/cyjh/feedback/lib/dialog/FeedBackCommitDialog;

    invoke-direct {v0, p0}, Lcom/cyjh/feedback/lib/dialog/FeedBackCommitDialog;-><init>(Landroid/content/Context;)V

    iput-object v0, p0, Lcom/cyjh/elfin/activity/SettingActivity;->feedBackCommitDialog:Lcom/cyjh/feedback/lib/dialog/FeedBackCommitDialog;

    .line 220
    iget-object v0, p0, Lcom/cyjh/elfin/activity/SettingActivity;->feedBackCommitDialog:Lcom/cyjh/feedback/lib/dialog/FeedBackCommitDialog;

    invoke-virtual {v0}, Lcom/cyjh/feedback/lib/dialog/FeedBackCommitDialog;->show()V

    .line 221
    new-instance v0, Lcom/cyjh/elfin/activity/SettingActivity$SubmitTimeCount;

    const-wide/16 v2, 0xbb8

    const-wide/16 v4, 0x3e8

    const/4 v6, 0x0

    move-object v1, p0

    invoke-direct/range {v0 .. v6}, Lcom/cyjh/elfin/activity/SettingActivity$SubmitTimeCount;-><init>(Lcom/cyjh/elfin/activity/SettingActivity;JJLcom/cyjh/elfin/activity/SettingActivity$1;)V

    iput-object v0, p0, Lcom/cyjh/elfin/activity/SettingActivity;->mSubmitTimeCount:Lcom/cyjh/elfin/activity/SettingActivity$SubmitTimeCount;

    .line 222
    iget-object v0, p0, Lcom/cyjh/elfin/activity/SettingActivity;->mSubmitTimeCount:Lcom/cyjh/elfin/activity/SettingActivity$SubmitTimeCount;

    invoke-virtual {v0}, Lcom/cyjh/elfin/activity/SettingActivity$SubmitTimeCount;->start()Landroid/os/CountDownTimer;

    goto :goto_0

    .line 216
    :pswitch_data_0
    .packed-switch 0x1
        :pswitch_0
    .end packed-switch
.end method

.method public onCheckedChanged(Landroid/widget/CompoundButton;Z)V
    .locals 5
    .param p1, "paramCompoundButton"    # Landroid/widget/CompoundButton;
    .param p2, "paramBoolean"    # Z

    .prologue
    const v4, 0x7f0800ed

    const/4 v3, 0x1

    .line 111
    iget-object v2, p0, Lcom/cyjh/elfin/activity/SettingActivity;->appContext:Lcom/cyjh/elfin/AppContext;

    iget-object v1, v2, Lcom/cyjh/elfin/AppContext;->sharedPreferences:Landroid/content/SharedPreferences;

    .line 112
    .local v1, "sharedPreferences":Landroid/content/SharedPreferences;
    invoke-interface {v1}, Landroid/content/SharedPreferences;->edit()Landroid/content/SharedPreferences$Editor;

    move-result-object v0

    .line 114
    .local v0, "edit":Landroid/content/SharedPreferences$Editor;
    invoke-virtual {p1}, Landroid/widget/CompoundButton;->getId()I

    move-result v2

    packed-switch v2, :pswitch_data_0

    .line 146
    :goto_0
    invoke-interface {v0}, Landroid/content/SharedPreferences$Editor;->apply()V

    .line 147
    return-void

    .line 116
    :pswitch_0
    const-string v2, "com.cyjh.elfin.activity.SettingActivity.swtCallStop"

    invoke-interface {v0, v2, p2}, Landroid/content/SharedPreferences$Editor;->putBoolean(Ljava/lang/String;Z)Landroid/content/SharedPreferences$Editor;

    goto :goto_0

    .line 120
    :pswitch_1
    if-nez p2, :cond_0

    iget-object v2, p0, Lcom/cyjh/elfin/activity/SettingActivity;->swtFloatviewCtrl:Landroid/widget/Switch;

    invoke-virtual {v2}, Landroid/widget/Switch;->isChecked()Z

    move-result v2

    if-nez v2, :cond_0

    .line 121
    iget-object v2, p0, Lcom/cyjh/elfin/activity/SettingActivity;->appContext:Lcom/cyjh/elfin/AppContext;

    invoke-virtual {v2, v4}, Lcom/cyjh/elfin/AppContext;->showToast(I)V

    .line 122
    iget-object v2, p0, Lcom/cyjh/elfin/activity/SettingActivity;->swtVolumeKeyCtrl:Landroid/widget/Switch;

    invoke-virtual {v2, v3}, Landroid/widget/Switch;->setChecked(Z)V

    goto :goto_0

    .line 124
    :cond_0
    const-string v2, "com.cyjh.elfin.activity.SettingActivity.swtVolumeKeyCtrl"

    invoke-interface {v0, v2, p2}, Landroid/content/SharedPreferences$Editor;->putBoolean(Ljava/lang/String;Z)Landroid/content/SharedPreferences$Editor;

    goto :goto_0

    .line 128
    :pswitch_2
    const-string v2, "com.cyjh.elfin.activity.SettingActivity.swtWaggleStop"

    invoke-interface {v0, v2, p2}, Landroid/content/SharedPreferences$Editor;->putBoolean(Ljava/lang/String;Z)Landroid/content/SharedPreferences$Editor;

    goto :goto_0

    .line 132
    :pswitch_3
    if-nez p2, :cond_1

    iget-object v2, p0, Lcom/cyjh/elfin/activity/SettingActivity;->swtVolumeKeyCtrl:Landroid/widget/Switch;

    invoke-virtual {v2}, Landroid/widget/Switch;->isChecked()Z

    move-result v2

    if-nez v2, :cond_1

    .line 133
    iget-object v2, p0, Lcom/cyjh/elfin/activity/SettingActivity;->appContext:Lcom/cyjh/elfin/AppContext;

    invoke-virtual {v2, v4}, Lcom/cyjh/elfin/AppContext;->showToast(I)V

    .line 134
    iget-object v2, p0, Lcom/cyjh/elfin/activity/SettingActivity;->swtFloatviewCtrl:Landroid/widget/Switch;

    invoke-virtual {v2, v3}, Landroid/widget/Switch;->setChecked(Z)V

    goto :goto_0

    .line 136
    :cond_1
    const-string v2, "com.cyjh.elfin.activity.SettingActivity.swtFloatviewCtrl"

    invoke-interface {v0, v2, p2}, Landroid/content/SharedPreferences$Editor;->putBoolean(Ljava/lang/String;Z)Landroid/content/SharedPreferences$Editor;

    goto :goto_0

    .line 140
    :pswitch_4
    const-string v2, "com.cyjh.elfin.activity.SettingActivity.swtVibration"

    invoke-interface {v0, v2, p2}, Landroid/content/SharedPreferences$Editor;->putBoolean(Ljava/lang/String;Z)Landroid/content/SharedPreferences$Editor;

    goto :goto_0

    .line 114
    nop

    :pswitch_data_0
    .packed-switch 0x7f0f008b
        :pswitch_1
        :pswitch_3
        :pswitch_2
        :pswitch_0
        :pswitch_4
    .end packed-switch
.end method

.method public onClick(Landroid/view/View;)V
    .locals 11
    .param p1, "view"    # Landroid/view/View;

    .prologue
    const/4 v10, 0x1

    .line 160
    invoke-virtual {p1}, Landroid/view/View;->getId()I

    move-result v7

    packed-switch v7, :pswitch_data_0

    .line 210
    :goto_0
    return-void

    .line 162
    :pswitch_0
    new-instance v1, Lcom/cyjh/elfin/util/FileUtils$FileSuffixrFilter;

    const-string v7, ".log"

    invoke-direct {v1, v7}, Lcom/cyjh/elfin/util/FileUtils$FileSuffixrFilter;-><init>(Ljava/lang/String;)V

    .line 163
    .local v1, "fileSuffixrFilter":Lcom/cyjh/elfin/util/FileUtils$FileSuffixrFilter;
    new-instance v7, Ljava/io/File;

    iget-object v8, p0, Lcom/cyjh/elfin/activity/SettingActivity;->appContext:Lcom/cyjh/elfin/AppContext;

    iget-object v8, v8, Lcom/cyjh/elfin/AppContext;->PATH_PACKAGENAME_LOG:Ljava/lang/String;

    invoke-direct {v7, v8}, Ljava/io/File;-><init>(Ljava/lang/String;)V

    invoke-virtual {v7, v1}, Ljava/io/File;->listFiles(Ljava/io/FilenameFilter;)[Ljava/io/File;

    move-result-object v4

    .line 165
    .local v4, "logFiles":[Ljava/io/File;
    if-eqz v4, :cond_0

    array-length v7, v4

    if-nez v7, :cond_1

    .line 166
    :cond_0
    iget-object v7, p0, Lcom/cyjh/elfin/activity/SettingActivity;->appContext:Lcom/cyjh/elfin/AppContext;

    const v8, 0x7f080028

    invoke-virtual {v7, v8}, Lcom/cyjh/elfin/AppContext;->showToast(I)V

    goto :goto_0

    .line 169
    :cond_1
    new-instance v7, Lcom/cyjh/elfin/util/FileComparator;

    invoke-direct {v7}, Lcom/cyjh/elfin/util/FileComparator;-><init>()V

    invoke-static {v4, v7}, Ljava/util/Arrays;->sort([Ljava/lang/Object;Ljava/util/Comparator;)V

    .line 171
    const/4 v7, 0x0

    aget-object v5, v4, v7

    .line 172
    .local v5, "scriptFile":Ljava/io/File;
    new-instance v6, Lcom/cyjh/elfin/entity/ScriptLog;

    invoke-direct {v6}, Lcom/cyjh/elfin/entity/ScriptLog;-><init>()V

    .line 173
    .local v6, "scriptLog":Lcom/cyjh/elfin/entity/ScriptLog;
    invoke-virtual {v5}, Ljava/io/File;->getName()Ljava/lang/String;

    move-result-object v7

    invoke-virtual {v6, v7}, Lcom/cyjh/elfin/entity/ScriptLog;->setName(Ljava/lang/String;)V

    .line 174
    invoke-virtual {v5}, Ljava/io/File;->length()J

    move-result-wide v8

    invoke-static {v8, v9}, Lcom/cyjh/elfin/util/FileUtils;->formetFileSize(J)Ljava/lang/String;

    move-result-object v7

    invoke-virtual {v6, v7}, Lcom/cyjh/elfin/entity/ScriptLog;->setSize(Ljava/lang/String;)V

    .line 175
    invoke-virtual {v6, v5}, Lcom/cyjh/elfin/entity/ScriptLog;->setFile(Ljava/io/File;)V

    .line 177
    new-instance v2, Landroid/content/Intent;

    const-class v7, Lcom/cyjh/elfin/activity/ScriptLogDetailActivity;

    invoke-direct {v2, p0, v7}, Landroid/content/Intent;-><init>(Landroid/content/Context;Ljava/lang/Class;)V

    .line 178
    .local v2, "intent":Landroid/content/Intent;
    const-string v7, "com.cyjh.elfin.activity.SettingActivity.FlagLastLog"

    invoke-virtual {v2, v7, v10}, Landroid/content/Intent;->putExtra(Ljava/lang/String;Z)Landroid/content/Intent;

    .line 179
    const-string v7, "com.cyjh.elfin.activity.ScriptLogActivity.ScriptLog"

    invoke-virtual {v2, v7, v6}, Landroid/content/Intent;->putExtra(Ljava/lang/String;Landroid/os/Parcelable;)Landroid/content/Intent;

    .line 180
    invoke-virtual {p0, v2}, Lcom/cyjh/elfin/activity/SettingActivity;->startActivity(Landroid/content/Intent;)V

    goto :goto_0

    .line 184
    .end local v1    # "fileSuffixrFilter":Lcom/cyjh/elfin/util/FileUtils$FileSuffixrFilter;
    .end local v2    # "intent":Landroid/content/Intent;
    .end local v4    # "logFiles":[Ljava/io/File;
    .end local v5    # "scriptFile":Ljava/io/File;
    .end local v6    # "scriptLog":Lcom/cyjh/elfin/entity/ScriptLog;
    :pswitch_1
    new-instance v7, Landroid/content/Intent;

    const-class v8, Lcom/cyjh/elfin/services/PhoneStateService;

    invoke-direct {v7, p0, v8}, Landroid/content/Intent;-><init>(Landroid/content/Context;Ljava/lang/Class;)V

    invoke-virtual {p0, v7}, Lcom/cyjh/elfin/activity/SettingActivity;->stopService(Landroid/content/Intent;)Z

    .line 185
    new-instance v7, Landroid/content/Intent;

    const-class v8, Lcom/cyjh/mobileanjian/ipc/IpcService;

    invoke-direct {v7, p0, v8}, Landroid/content/Intent;-><init>(Landroid/content/Context;Ljava/lang/Class;)V

    invoke-virtual {p0, v7}, Lcom/cyjh/elfin/activity/SettingActivity;->stopService(Landroid/content/Intent;)Z

    .line 186
    invoke-static {}, Lcom/cyjh/elfin/AppContext;->getInstance()Lcom/cyjh/elfin/AppContext;

    move-result-object v7

    invoke-virtual {v7}, Lcom/cyjh/elfin/AppContext;->onKillProcess()V

    .line 187
    new-instance v7, Landroid/content/Intent;

    const-class v8, Lcom/kaopu/download/kernel/DownloadService;

    invoke-direct {v7, p0, v8}, Landroid/content/Intent;-><init>(Landroid/content/Context;Ljava/lang/Class;)V

    invoke-virtual {p0, v7}, Lcom/cyjh/elfin/activity/SettingActivity;->stopService(Landroid/content/Intent;)Z

    .line 188
    const-string v7, "activity"

    invoke-virtual {p0, v7}, Lcom/cyjh/elfin/activity/SettingActivity;->getSystemService(Ljava/lang/String;)Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Landroid/app/ActivityManager;

    .line 189
    .local v0, "activityManager":Landroid/app/ActivityManager;
    if-eqz v0, :cond_2

    .line 191
    const-string v7, "com.cyjh.elfin:download_server"

    invoke-virtual {v0, v7}, Landroid/app/ActivityManager;->killBackgroundProcesses(Ljava/lang/String;)V

    .line 193
    :cond_2
    invoke-static {}, Landroid/os/Process;->myPid()I

    move-result v7

    invoke-static {v7}, Landroid/os/Process;->killProcess(I)V

    goto/16 :goto_0

    .line 196
    .end local v0    # "activityManager":Landroid/app/ActivityManager;
    :pswitch_2
    invoke-static {p0}, Lcom/cyjh/elfin/util/NetworkUtils;->isAvailable(Landroid/content/Context;)Z

    move-result v7

    if-nez v7, :cond_3

    .line 197
    const v7, 0x7f0800a4

    invoke-static {p0, v7}, Lcom/cyjh/elfin/util/ToastUtils;->showToastLong(Landroid/content/Context;I)V

    goto/16 :goto_0

    .line 200
    :cond_3
    invoke-static {}, Lcom/cyjh/elfin/mvp/managers/UpdateVersionManager;->builder()Lcom/cyjh/elfin/mvp/managers/UpdateVersionManager;

    move-result-object v7

    const/4 v8, 0x0

    invoke-virtual {v7, v8}, Lcom/cyjh/elfin/mvp/managers/UpdateVersionManager;->setDismissBack(Lcom/cyjh/elfin/mvp/managers/UpdateVersionManager$OnUpdateVersionBack;)Lcom/cyjh/elfin/mvp/managers/UpdateVersionManager;

    move-result-object v7

    invoke-virtual {v7, v10, p0}, Lcom/cyjh/elfin/mvp/managers/UpdateVersionManager;->updateVersion(ZLandroid/content/Context;)V

    goto/16 :goto_0

    .line 203
    :pswitch_3
    new-instance v3, Landroid/content/Intent;

    const-class v7, Lcom/cyjh/elfin/activity/FeedbackActivity;

    invoke-direct {v3, p0, v7}, Landroid/content/Intent;-><init>(Landroid/content/Context;Ljava/lang/Class;)V

    .line 204
    .local v3, "intent1":Landroid/content/Intent;
    const-class v7, Lcom/cyjh/elfin/activity/FeedbackActivity;

    invoke-virtual {v7}, Ljava/lang/Class;->getCanonicalName()Ljava/lang/String;

    move-result-object v7

    const v8, 0x7f0800bf

    invoke-virtual {p0, v8}, Lcom/cyjh/elfin/activity/SettingActivity;->getString(I)Ljava/lang/String;

    move-result-object v8

    invoke-virtual {v3, v7, v8}, Landroid/content/Intent;->putExtra(Ljava/lang/String;Ljava/lang/String;)Landroid/content/Intent;

    .line 205
    invoke-virtual {p0, v3, v10}, Lcom/cyjh/elfin/activity/SettingActivity;->startActivityForResult(Landroid/content/Intent;I)V

    goto/16 :goto_0

    .line 160
    :pswitch_data_0
    .packed-switch 0x7f0f0090
        :pswitch_0
        :pswitch_2
        :pswitch_3
        :pswitch_1
    .end packed-switch
.end method

.method protected onCreate(Landroid/os/Bundle;)V
    .locals 1
    .param p1, "savedInstanceState"    # Landroid/os/Bundle;

    .prologue
    .line 61
    invoke-super {p0, p1}, Lcom/cyjh/elfin/activity/BaseActivity;->onCreate(Landroid/os/Bundle;)V

    .line 62
    const v0, 0x7f040027

    invoke-virtual {p0, v0}, Lcom/cyjh/elfin/activity/SettingActivity;->setContentView(I)V

    .line 63
    invoke-direct {p0}, Lcom/cyjh/elfin/activity/SettingActivity;->initView()V

    .line 64
    return-void
.end method

.method protected onDestroy()V
    .locals 1

    .prologue
    .line 251
    invoke-super {p0}, Lcom/cyjh/elfin/activity/BaseActivity;->onDestroy()V

    .line 252
    iget-object v0, p0, Lcom/cyjh/elfin/activity/SettingActivity;->mSubmitTimeCount:Lcom/cyjh/elfin/activity/SettingActivity$SubmitTimeCount;

    if-eqz v0, :cond_0

    .line 253
    iget-object v0, p0, Lcom/cyjh/elfin/activity/SettingActivity;->mSubmitTimeCount:Lcom/cyjh/elfin/activity/SettingActivity$SubmitTimeCount;

    invoke-virtual {v0}, Lcom/cyjh/elfin/activity/SettingActivity$SubmitTimeCount;->cancel()V

    .line 255
    :cond_0
    return-void
.end method

.method protected onPause()V
    .locals 1

    .prologue
    .line 266
    invoke-super {p0}, Lcom/cyjh/elfin/activity/BaseActivity;->onPause()V

    .line 267
    const-class v0, Lcom/cyjh/elfin/activity/SettingActivity;

    invoke-virtual {v0}, Ljava/lang/Class;->getCanonicalName()Ljava/lang/String;

    move-result-object v0

    invoke-static {v0}, Lcom/umeng/analytics/MobclickAgent;->onPageEnd(Ljava/lang/String;)V

    .line 268
    invoke-static {p0}, Lcom/umeng/analytics/MobclickAgent;->onPause(Landroid/content/Context;)V

    .line 269
    return-void
.end method

.method protected onResume()V
    .locals 1

    .prologue
    .line 259
    invoke-super {p0}, Lcom/cyjh/elfin/activity/BaseActivity;->onResume()V

    .line 260
    const-class v0, Lcom/cyjh/elfin/activity/SettingActivity;

    invoke-virtual {v0}, Ljava/lang/Class;->getCanonicalName()Ljava/lang/String;

    move-result-object v0

    invoke-static {v0}, Lcom/umeng/analytics/MobclickAgent;->onPageStart(Ljava/lang/String;)V

    .line 261
    invoke-static {p0}, Lcom/umeng/analytics/MobclickAgent;->onResume(Landroid/content/Context;)V

    .line 262
    return-void
.end method
