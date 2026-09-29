.class public Lcom/cyjh/elfin/dialog/SettingDialog;
.super Lcom/cyjh/elfin/dialog/BaseDialog;
.source "SettingDialog.java"

# interfaces
.implements Landroid/widget/CompoundButton$OnCheckedChangeListener;
.implements Landroid/view/View$OnClickListener;


# static fields
.field private static final ANDROID_SDK_19:I = 0x13

.field private static final ANDROID_SDK_24:I = 0x18


# instance fields
.field private isDismiss:Z

.field public mContext:Landroid/content/Context;

.field private mSwtichCallStop:Landroid/widget/Switch;

.field private mSwtichFloatviewCtrl:Landroid/widget/Switch;

.field private mSwtichVibration:Landroid/widget/Switch;

.field private mSwtichVolumeKeyCtrl:Landroid/widget/Switch;

.field private mSwtichWaggleStop:Landroid/widget/Switch;


# direct methods
.method protected constructor <init>(Landroid/content/Context;)V
    .locals 2
    .param p1, "context"    # Landroid/content/Context;

    .prologue
    .line 59
    const v0, 0x7f0a00f8

    invoke-direct {p0, p1, v0}, Lcom/cyjh/elfin/dialog/BaseDialog;-><init>(Landroid/content/Context;I)V

    .line 60
    invoke-virtual {p1}, Landroid/content/Context;->getApplicationContext()Landroid/content/Context;

    move-result-object v0

    check-cast v0, Lcom/cyjh/elfin/AppContext;

    iput-object v0, p0, Lcom/cyjh/elfin/dialog/SettingDialog;->mAppContext:Lcom/cyjh/elfin/AppContext;

    .line 61
    sget v0, Landroid/os/Build$VERSION;->SDK_INT:I

    const/16 v1, 0x13

    if-lt v0, v1, :cond_1

    sget v0, Landroid/os/Build$VERSION;->SDK_INT:I

    const/16 v1, 0x18

    if-ge v0, v1, :cond_1

    .line 62
    invoke-virtual {p0}, Lcom/cyjh/elfin/dialog/SettingDialog;->getWindow()Landroid/view/Window;

    move-result-object v0

    if-eqz v0, :cond_0

    .line 63
    invoke-virtual {p0}, Lcom/cyjh/elfin/dialog/SettingDialog;->getWindow()Landroid/view/Window;

    move-result-object v0

    const/16 v1, 0x7d5

    invoke-virtual {v0, v1}, Landroid/view/Window;->setType(I)V

    .line 70
    :cond_0
    :goto_0
    return-void

    .line 66
    :cond_1
    invoke-virtual {p0}, Lcom/cyjh/elfin/dialog/SettingDialog;->getWindow()Landroid/view/Window;

    move-result-object v0

    if-eqz v0, :cond_0

    .line 67
    invoke-virtual {p0}, Lcom/cyjh/elfin/dialog/SettingDialog;->getWindow()Landroid/view/Window;

    move-result-object v0

    const/16 v1, 0x7d2

    invoke-virtual {v0, v1}, Landroid/view/Window;->setType(I)V

    goto :goto_0
.end method

.method private initSwtichStatus()V
    .locals 4

    .prologue
    const/4 v3, 0x1

    .line 107
    iget-object v0, p0, Lcom/cyjh/elfin/dialog/SettingDialog;->mSwtichCallStop:Landroid/widget/Switch;

    iget-object v1, p0, Lcom/cyjh/elfin/dialog/SettingDialog;->mAppContext:Lcom/cyjh/elfin/AppContext;

    iget-object v1, v1, Lcom/cyjh/elfin/AppContext;->sharedPreferences:Landroid/content/SharedPreferences;

    const-string v2, "com.cyjh.elfin.activity.SettingActivity.swtCallStop"

    invoke-interface {v1, v2, v3}, Landroid/content/SharedPreferences;->getBoolean(Ljava/lang/String;Z)Z

    move-result v1

    invoke-virtual {v0, v1}, Landroid/widget/Switch;->setChecked(Z)V

    .line 108
    iget-object v0, p0, Lcom/cyjh/elfin/dialog/SettingDialog;->mSwtichVolumeKeyCtrl:Landroid/widget/Switch;

    iget-object v1, p0, Lcom/cyjh/elfin/dialog/SettingDialog;->mAppContext:Lcom/cyjh/elfin/AppContext;

    iget-object v1, v1, Lcom/cyjh/elfin/AppContext;->sharedPreferences:Landroid/content/SharedPreferences;

    const-string v2, "com.cyjh.elfin.activity.SettingActivity.swtVolumeKeyCtrl"

    invoke-interface {v1, v2, v3}, Landroid/content/SharedPreferences;->getBoolean(Ljava/lang/String;Z)Z

    move-result v1

    invoke-virtual {v0, v1}, Landroid/widget/Switch;->setChecked(Z)V

    .line 109
    iget-object v0, p0, Lcom/cyjh/elfin/dialog/SettingDialog;->mSwtichWaggleStop:Landroid/widget/Switch;

    iget-object v1, p0, Lcom/cyjh/elfin/dialog/SettingDialog;->mAppContext:Lcom/cyjh/elfin/AppContext;

    iget-object v1, v1, Lcom/cyjh/elfin/AppContext;->sharedPreferences:Landroid/content/SharedPreferences;

    const-string v2, "com.cyjh.elfin.activity.SettingActivity.swtWaggleStop"

    invoke-interface {v1, v2, v3}, Landroid/content/SharedPreferences;->getBoolean(Ljava/lang/String;Z)Z

    move-result v1

    invoke-virtual {v0, v1}, Landroid/widget/Switch;->setChecked(Z)V

    .line 110
    iget-object v0, p0, Lcom/cyjh/elfin/dialog/SettingDialog;->mSwtichFloatviewCtrl:Landroid/widget/Switch;

    iget-object v1, p0, Lcom/cyjh/elfin/dialog/SettingDialog;->mAppContext:Lcom/cyjh/elfin/AppContext;

    iget-object v1, v1, Lcom/cyjh/elfin/AppContext;->sharedPreferences:Landroid/content/SharedPreferences;

    const-string v2, "com.cyjh.elfin.activity.SettingActivity.swtFloatviewCtrl"

    invoke-interface {v1, v2, v3}, Landroid/content/SharedPreferences;->getBoolean(Ljava/lang/String;Z)Z

    move-result v1

    invoke-virtual {v0, v1}, Landroid/widget/Switch;->setChecked(Z)V

    .line 111
    iget-object v0, p0, Lcom/cyjh/elfin/dialog/SettingDialog;->mSwtichVibration:Landroid/widget/Switch;

    iget-object v1, p0, Lcom/cyjh/elfin/dialog/SettingDialog;->mAppContext:Lcom/cyjh/elfin/AppContext;

    iget-object v1, v1, Lcom/cyjh/elfin/AppContext;->sharedPreferences:Landroid/content/SharedPreferences;

    const-string v2, "com.cyjh.elfin.activity.SettingActivity.swtVibration"

    invoke-interface {v1, v2, v3}, Landroid/content/SharedPreferences;->getBoolean(Ljava/lang/String;Z)Z

    move-result v1

    invoke-virtual {v0, v1}, Landroid/widget/Switch;->setChecked(Z)V

    .line 112
    return-void
.end method

.method private initView()V
    .locals 5

    .prologue
    .line 83
    const v4, 0x7f0f0154

    invoke-virtual {p0, v4}, Lcom/cyjh/elfin/dialog/SettingDialog;->findViewById(I)Landroid/view/View;

    move-result-object v4

    check-cast v4, Landroid/widget/Switch;

    iput-object v4, p0, Lcom/cyjh/elfin/dialog/SettingDialog;->mSwtichCallStop:Landroid/widget/Switch;

    .line 84
    const v4, 0x7f0f0151

    invoke-virtual {p0, v4}, Lcom/cyjh/elfin/dialog/SettingDialog;->findViewById(I)Landroid/view/View;

    move-result-object v4

    check-cast v4, Landroid/widget/Switch;

    iput-object v4, p0, Lcom/cyjh/elfin/dialog/SettingDialog;->mSwtichVolumeKeyCtrl:Landroid/widget/Switch;

    .line 85
    const v4, 0x7f0f0153

    invoke-virtual {p0, v4}, Lcom/cyjh/elfin/dialog/SettingDialog;->findViewById(I)Landroid/view/View;

    move-result-object v4

    check-cast v4, Landroid/widget/Switch;

    iput-object v4, p0, Lcom/cyjh/elfin/dialog/SettingDialog;->mSwtichWaggleStop:Landroid/widget/Switch;

    .line 86
    const v4, 0x7f0f0152

    invoke-virtual {p0, v4}, Lcom/cyjh/elfin/dialog/SettingDialog;->findViewById(I)Landroid/view/View;

    move-result-object v4

    check-cast v4, Landroid/widget/Switch;

    iput-object v4, p0, Lcom/cyjh/elfin/dialog/SettingDialog;->mSwtichFloatviewCtrl:Landroid/widget/Switch;

    .line 87
    const v4, 0x7f0f0155

    invoke-virtual {p0, v4}, Lcom/cyjh/elfin/dialog/SettingDialog;->findViewById(I)Landroid/view/View;

    move-result-object v4

    check-cast v4, Landroid/widget/Switch;

    iput-object v4, p0, Lcom/cyjh/elfin/dialog/SettingDialog;->mSwtichVibration:Landroid/widget/Switch;

    .line 88
    const v4, 0x7f0f0156

    invoke-virtual {p0, v4}, Lcom/cyjh/elfin/dialog/SettingDialog;->findViewById(I)Landroid/view/View;

    move-result-object v1

    check-cast v1, Landroid/widget/Button;

    .line 89
    .local v1, "mButtonScriptLog":Landroid/widget/Button;
    const v4, 0x7f0f0091

    invoke-virtual {p0, v4}, Lcom/cyjh/elfin/dialog/SettingDialog;->findViewById(I)Landroid/view/View;

    move-result-object v2

    check-cast v2, Landroid/widget/Button;

    .line 90
    .local v2, "mButtonUpdate":Landroid/widget/Button;
    const v4, 0x7f0f0093

    invoke-virtual {p0, v4}, Lcom/cyjh/elfin/dialog/SettingDialog;->findViewById(I)Landroid/view/View;

    move-result-object v0

    check-cast v0, Landroid/widget/Button;

    .line 91
    .local v0, "mButtonExitApp":Landroid/widget/Button;
    const v4, 0x7f0f0150

    invoke-virtual {p0, v4}, Lcom/cyjh/elfin/dialog/SettingDialog;->findViewById(I)Landroid/view/View;

    move-result-object v3

    check-cast v3, Landroid/widget/ImageView;

    .line 93
    .local v3, "mImageViewBack":Landroid/widget/ImageView;
    iget-object v4, p0, Lcom/cyjh/elfin/dialog/SettingDialog;->mSwtichCallStop:Landroid/widget/Switch;

    invoke-virtual {v4, p0}, Landroid/widget/Switch;->setOnCheckedChangeListener(Landroid/widget/CompoundButton$OnCheckedChangeListener;)V

    .line 94
    iget-object v4, p0, Lcom/cyjh/elfin/dialog/SettingDialog;->mSwtichVolumeKeyCtrl:Landroid/widget/Switch;

    invoke-virtual {v4, p0}, Landroid/widget/Switch;->setOnCheckedChangeListener(Landroid/widget/CompoundButton$OnCheckedChangeListener;)V

    .line 95
    iget-object v4, p0, Lcom/cyjh/elfin/dialog/SettingDialog;->mSwtichWaggleStop:Landroid/widget/Switch;

    invoke-virtual {v4, p0}, Landroid/widget/Switch;->setOnCheckedChangeListener(Landroid/widget/CompoundButton$OnCheckedChangeListener;)V

    .line 96
    iget-object v4, p0, Lcom/cyjh/elfin/dialog/SettingDialog;->mSwtichFloatviewCtrl:Landroid/widget/Switch;

    invoke-virtual {v4, p0}, Landroid/widget/Switch;->setOnCheckedChangeListener(Landroid/widget/CompoundButton$OnCheckedChangeListener;)V

    .line 97
    iget-object v4, p0, Lcom/cyjh/elfin/dialog/SettingDialog;->mSwtichVibration:Landroid/widget/Switch;

    invoke-virtual {v4, p0}, Landroid/widget/Switch;->setOnCheckedChangeListener(Landroid/widget/CompoundButton$OnCheckedChangeListener;)V

    .line 98
    invoke-virtual {v1, p0}, Landroid/widget/Button;->setOnClickListener(Landroid/view/View$OnClickListener;)V

    .line 99
    invoke-virtual {v0, p0}, Landroid/widget/Button;->setOnClickListener(Landroid/view/View$OnClickListener;)V

    .line 100
    invoke-virtual {v2, p0}, Landroid/widget/Button;->setOnClickListener(Landroid/view/View$OnClickListener;)V

    .line 101
    invoke-virtual {v3, p0}, Landroid/widget/ImageView;->setOnClickListener(Landroid/view/View$OnClickListener;)V

    .line 103
    invoke-direct {p0}, Lcom/cyjh/elfin/dialog/SettingDialog;->initSwtichStatus()V

    .line 104
    return-void
.end method


# virtual methods
.method public isDismiss()Z
    .locals 1

    .prologue
    .line 227
    iget-boolean v0, p0, Lcom/cyjh/elfin/dialog/SettingDialog;->isDismiss:Z

    return v0
.end method

.method public onCheckedChanged(Landroid/widget/CompoundButton;Z)V
    .locals 5
    .param p1, "paramCompoundButton"    # Landroid/widget/CompoundButton;
    .param p2, "paramBoolean"    # Z

    .prologue
    const v4, 0x7f0800ed

    const/4 v3, 0x1

    .line 116
    iget-object v2, p0, Lcom/cyjh/elfin/dialog/SettingDialog;->mAppContext:Lcom/cyjh/elfin/AppContext;

    iget-object v1, v2, Lcom/cyjh/elfin/AppContext;->sharedPreferences:Landroid/content/SharedPreferences;

    .line 117
    .local v1, "sharedPreferences":Landroid/content/SharedPreferences;
    invoke-interface {v1}, Landroid/content/SharedPreferences;->edit()Landroid/content/SharedPreferences$Editor;

    move-result-object v0

    .line 119
    .local v0, "edit":Landroid/content/SharedPreferences$Editor;
    invoke-virtual {p1}, Landroid/widget/CompoundButton;->getId()I

    move-result v2

    packed-switch v2, :pswitch_data_0

    .line 152
    :goto_0
    invoke-interface {v0}, Landroid/content/SharedPreferences$Editor;->apply()V

    .line 153
    return-void

    .line 121
    :pswitch_0
    const-string v2, "com.cyjh.elfin.activity.SettingActivity.swtCallStop"

    invoke-interface {v0, v2, p2}, Landroid/content/SharedPreferences$Editor;->putBoolean(Ljava/lang/String;Z)Landroid/content/SharedPreferences$Editor;

    goto :goto_0

    .line 125
    :pswitch_1
    if-nez p2, :cond_0

    iget-object v2, p0, Lcom/cyjh/elfin/dialog/SettingDialog;->mSwtichFloatviewCtrl:Landroid/widget/Switch;

    invoke-virtual {v2}, Landroid/widget/Switch;->isChecked()Z

    move-result v2

    if-nez v2, :cond_0

    .line 126
    iget-object v2, p0, Lcom/cyjh/elfin/dialog/SettingDialog;->mAppContext:Lcom/cyjh/elfin/AppContext;

    invoke-virtual {v2, v4}, Lcom/cyjh/elfin/AppContext;->showToast(I)V

    .line 127
    iget-object v2, p0, Lcom/cyjh/elfin/dialog/SettingDialog;->mSwtichVolumeKeyCtrl:Landroid/widget/Switch;

    invoke-virtual {v2, v3}, Landroid/widget/Switch;->setChecked(Z)V

    goto :goto_0

    .line 129
    :cond_0
    const-string v2, "com.cyjh.elfin.activity.SettingActivity.swtVolumeKeyCtrl"

    invoke-interface {v0, v2, p2}, Landroid/content/SharedPreferences$Editor;->putBoolean(Ljava/lang/String;Z)Landroid/content/SharedPreferences$Editor;

    goto :goto_0

    .line 133
    :pswitch_2
    const-string v2, "com.cyjh.elfin.activity.SettingActivity.swtWaggleStop"

    invoke-interface {v0, v2, p2}, Landroid/content/SharedPreferences$Editor;->putBoolean(Ljava/lang/String;Z)Landroid/content/SharedPreferences$Editor;

    goto :goto_0

    .line 137
    :pswitch_3
    if-nez p2, :cond_1

    iget-object v2, p0, Lcom/cyjh/elfin/dialog/SettingDialog;->mSwtichVolumeKeyCtrl:Landroid/widget/Switch;

    invoke-virtual {v2}, Landroid/widget/Switch;->isChecked()Z

    move-result v2

    if-nez v2, :cond_1

    .line 138
    iget-object v2, p0, Lcom/cyjh/elfin/dialog/SettingDialog;->mAppContext:Lcom/cyjh/elfin/AppContext;

    invoke-virtual {v2, v4}, Lcom/cyjh/elfin/AppContext;->showToast(I)V

    .line 139
    iget-object v2, p0, Lcom/cyjh/elfin/dialog/SettingDialog;->mSwtichFloatviewCtrl:Landroid/widget/Switch;

    invoke-virtual {v2, v3}, Landroid/widget/Switch;->setChecked(Z)V

    goto :goto_0

    .line 141
    :cond_1
    const-string v2, "com.cyjh.elfin.activity.SettingActivity.swtFloatviewCtrl"

    invoke-interface {v0, v2, p2}, Landroid/content/SharedPreferences$Editor;->putBoolean(Ljava/lang/String;Z)Landroid/content/SharedPreferences$Editor;

    .line 142
    iget-object v2, p0, Lcom/cyjh/elfin/dialog/SettingDialog;->mAppContext:Lcom/cyjh/elfin/AppContext;

    iget-object v2, v2, Lcom/cyjh/elfin/AppContext;->mElfinFloatView:Lcom/cyjh/elfin/floatview/ElfinFloatView;

    invoke-virtual {v2}, Lcom/cyjh/elfin/floatview/ElfinFloatView;->toggleElfinVisbility()V

    goto :goto_0

    .line 146
    :pswitch_4
    const-string v2, "com.cyjh.elfin.activity.SettingActivity.swtVibration"

    invoke-interface {v0, v2, p2}, Landroid/content/SharedPreferences$Editor;->putBoolean(Ljava/lang/String;Z)Landroid/content/SharedPreferences$Editor;

    goto :goto_0

    .line 119
    :pswitch_data_0
    .packed-switch 0x7f0f0151
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

    const/4 v9, 0x0

    .line 157
    invoke-virtual {p1}, Landroid/view/View;->getId()I

    move-result v7

    sparse-switch v7, :sswitch_data_0

    .line 224
    :cond_0
    :goto_0
    return-void

    .line 159
    :sswitch_0
    new-instance v1, Lcom/cyjh/elfin/util/FileUtils$FileSuffixrFilter;

    const-string v7, ".log"

    invoke-direct {v1, v7}, Lcom/cyjh/elfin/util/FileUtils$FileSuffixrFilter;-><init>(Ljava/lang/String;)V

    .line 160
    .local v1, "fileSuffixrFilter":Lcom/cyjh/elfin/util/FileUtils$FileSuffixrFilter;
    new-instance v7, Ljava/io/File;

    iget-object v8, p0, Lcom/cyjh/elfin/dialog/SettingDialog;->mAppContext:Lcom/cyjh/elfin/AppContext;

    iget-object v8, v8, Lcom/cyjh/elfin/AppContext;->PATH_PACKAGENAME_LOG:Ljava/lang/String;

    invoke-direct {v7, v8}, Ljava/io/File;-><init>(Ljava/lang/String;)V

    invoke-virtual {v7, v1}, Ljava/io/File;->listFiles(Ljava/io/FilenameFilter;)[Ljava/io/File;

    move-result-object v3

    .line 162
    .local v3, "logFiles":[Ljava/io/File;
    if-eqz v3, :cond_1

    array-length v7, v3

    if-nez v7, :cond_2

    .line 163
    :cond_1
    iget-object v7, p0, Lcom/cyjh/elfin/dialog/SettingDialog;->mAppContext:Lcom/cyjh/elfin/AppContext;

    const v8, 0x7f080028

    invoke-virtual {v7, v8}, Lcom/cyjh/elfin/AppContext;->showToast(I)V

    goto :goto_0

    .line 166
    :cond_2
    new-instance v7, Lcom/cyjh/elfin/util/FileComparator;

    invoke-direct {v7}, Lcom/cyjh/elfin/util/FileComparator;-><init>()V

    invoke-static {v3, v7}, Ljava/util/Arrays;->sort([Ljava/lang/Object;Ljava/util/Comparator;)V

    .line 168
    aget-object v4, v3, v9

    .line 169
    .local v4, "scriptFile":Ljava/io/File;
    new-instance v5, Lcom/cyjh/elfin/entity/ScriptLog;

    invoke-direct {v5}, Lcom/cyjh/elfin/entity/ScriptLog;-><init>()V

    .line 170
    .local v5, "scriptLog":Lcom/cyjh/elfin/entity/ScriptLog;
    invoke-virtual {v4}, Ljava/io/File;->getName()Ljava/lang/String;

    move-result-object v7

    invoke-virtual {v5, v7}, Lcom/cyjh/elfin/entity/ScriptLog;->setName(Ljava/lang/String;)V

    .line 171
    invoke-virtual {v4}, Ljava/io/File;->length()J

    move-result-wide v8

    invoke-static {v8, v9}, Lcom/cyjh/elfin/util/FileUtils;->formetFileSize(J)Ljava/lang/String;

    move-result-object v7

    invoke-virtual {v5, v7}, Lcom/cyjh/elfin/entity/ScriptLog;->setSize(Ljava/lang/String;)V

    .line 172
    invoke-virtual {v5, v4}, Lcom/cyjh/elfin/entity/ScriptLog;->setFile(Ljava/io/File;)V

    .line 174
    new-instance v2, Landroid/content/Intent;

    invoke-virtual {p0}, Lcom/cyjh/elfin/dialog/SettingDialog;->getContext()Landroid/content/Context;

    move-result-object v7

    const-class v8, Lcom/cyjh/elfin/activity/ScriptLogDetailActivity;

    invoke-direct {v2, v7, v8}, Landroid/content/Intent;-><init>(Landroid/content/Context;Ljava/lang/Class;)V

    .line 175
    .local v2, "intent":Landroid/content/Intent;
    const-string v7, "com.cyjh.elfin.activity.SettingActivity.FlagLastLog"

    invoke-virtual {v2, v7, v10}, Landroid/content/Intent;->putExtra(Ljava/lang/String;Z)Landroid/content/Intent;

    .line 176
    const-string v7, "com.cyjh.elfin.activity.ScriptLogActivity.ScriptLog"

    invoke-virtual {v2, v7, v5}, Landroid/content/Intent;->putExtra(Ljava/lang/String;Landroid/os/Parcelable;)Landroid/content/Intent;

    .line 177
    const/high16 v7, 0x10000000

    invoke-virtual {v2, v7}, Landroid/content/Intent;->addFlags(I)Landroid/content/Intent;

    .line 178
    invoke-virtual {p0}, Lcom/cyjh/elfin/dialog/SettingDialog;->getContext()Landroid/content/Context;

    move-result-object v7

    invoke-virtual {v7, v2}, Landroid/content/Context;->startActivity(Landroid/content/Intent;)V

    .line 179
    iput-boolean v10, p0, Lcom/cyjh/elfin/dialog/SettingDialog;->isDismiss:Z

    .line 180
    invoke-virtual {p0}, Lcom/cyjh/elfin/dialog/SettingDialog;->dismiss()V

    goto :goto_0

    .line 183
    .end local v1    # "fileSuffixrFilter":Lcom/cyjh/elfin/util/FileUtils$FileSuffixrFilter;
    .end local v2    # "intent":Landroid/content/Intent;
    .end local v3    # "logFiles":[Ljava/io/File;
    .end local v4    # "scriptFile":Ljava/io/File;
    .end local v5    # "scriptLog":Lcom/cyjh/elfin/entity/ScriptLog;
    :sswitch_1
    invoke-virtual {p0}, Lcom/cyjh/elfin/dialog/SettingDialog;->getContext()Landroid/content/Context;

    move-result-object v7

    invoke-static {v7}, Lcom/cyjh/elfin/util/NetworkUtils;->isAvailable(Landroid/content/Context;)Z

    move-result v7

    if-nez v7, :cond_3

    .line 184
    invoke-static {}, Lcom/cyjh/elfin/AppContext;->getInstance()Lcom/cyjh/elfin/AppContext;

    move-result-object v7

    const v8, 0x7f0800a4

    invoke-static {v7, v8}, Lcom/cyjh/elfin/util/ToastUtils;->showToastLong(Landroid/content/Context;I)V

    goto/16 :goto_0

    .line 187
    :cond_3
    iput-boolean v9, p0, Lcom/cyjh/elfin/dialog/SettingDialog;->isDismiss:Z

    .line 188
    invoke-static {}, Lcom/cyjh/elfin/mvp/managers/UpdateVersionManager;->builder()Lcom/cyjh/elfin/mvp/managers/UpdateVersionManager;

    move-result-object v7

    invoke-virtual {v7, v10}, Lcom/cyjh/elfin/mvp/managers/UpdateVersionManager;->setDismiss(Z)Lcom/cyjh/elfin/mvp/managers/UpdateVersionManager;

    move-result-object v7

    new-instance v8, Lcom/cyjh/elfin/dialog/SettingDialog$1;

    invoke-direct {v8, p0}, Lcom/cyjh/elfin/dialog/SettingDialog$1;-><init>(Lcom/cyjh/elfin/dialog/SettingDialog;)V

    invoke-virtual {v7, v8}, Lcom/cyjh/elfin/mvp/managers/UpdateVersionManager;->setDismissBack(Lcom/cyjh/elfin/mvp/managers/UpdateVersionManager$OnUpdateVersionBack;)Lcom/cyjh/elfin/mvp/managers/UpdateVersionManager;

    move-result-object v7

    .line 195
    invoke-virtual {p0}, Lcom/cyjh/elfin/dialog/SettingDialog;->getContext()Landroid/content/Context;

    move-result-object v8

    invoke-virtual {v7, v10, v8}, Lcom/cyjh/elfin/mvp/managers/UpdateVersionManager;->updateVersion(ZLandroid/content/Context;)V

    goto/16 :goto_0

    .line 198
    :sswitch_2
    iput-boolean v9, p0, Lcom/cyjh/elfin/dialog/SettingDialog;->isDismiss:Z

    .line 199
    new-instance v7, Ljava/lang/StringBuilder;

    invoke-direct {v7}, Ljava/lang/StringBuilder;-><init>()V

    const-string v8, "context:"

    invoke-virtual {v7, v8}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v7

    iget-object v8, p0, Lcom/cyjh/elfin/dialog/SettingDialog;->mContext:Landroid/content/Context;

    invoke-virtual {v7, v8}, Ljava/lang/StringBuilder;->append(Ljava/lang/Object;)Ljava/lang/StringBuilder;

    move-result-object v7

    invoke-virtual {v7}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v7

    new-array v8, v9, [Ljava/lang/Object;

    invoke-static {v7, v8}, Lcom/orhanobut/logger/Logger;->e(Ljava/lang/String;[Ljava/lang/Object;)V

    .line 200
    iget-object v7, p0, Lcom/cyjh/elfin/dialog/SettingDialog;->mContext:Landroid/content/Context;

    if-eqz v7, :cond_4

    .line 202
    iget-object v7, p0, Lcom/cyjh/elfin/dialog/SettingDialog;->mContext:Landroid/content/Context;

    check-cast v7, Landroid/app/Activity;

    invoke-virtual {v7}, Landroid/app/Activity;->finish()V

    .line 204
    :cond_4
    invoke-virtual {p0}, Lcom/cyjh/elfin/dialog/SettingDialog;->getContext()Landroid/content/Context;

    move-result-object v7

    new-instance v8, Landroid/content/Intent;

    invoke-virtual {p0}, Lcom/cyjh/elfin/dialog/SettingDialog;->getContext()Landroid/content/Context;

    move-result-object v9

    const-class v10, Lcom/cyjh/elfin/services/DownloadApkService;

    invoke-direct {v8, v9, v10}, Landroid/content/Intent;-><init>(Landroid/content/Context;Ljava/lang/Class;)V

    invoke-virtual {v7, v8}, Landroid/content/Context;->stopService(Landroid/content/Intent;)Z

    .line 205
    invoke-virtual {p0}, Lcom/cyjh/elfin/dialog/SettingDialog;->getContext()Landroid/content/Context;

    move-result-object v7

    new-instance v8, Landroid/content/Intent;

    invoke-virtual {p0}, Lcom/cyjh/elfin/dialog/SettingDialog;->getContext()Landroid/content/Context;

    move-result-object v9

    const-class v10, Lcom/cyjh/elfin/services/PhoneStateService;

    invoke-direct {v8, v9, v10}, Landroid/content/Intent;-><init>(Landroid/content/Context;Ljava/lang/Class;)V

    invoke-virtual {v7, v8}, Landroid/content/Context;->stopService(Landroid/content/Intent;)Z

    .line 206
    invoke-virtual {p0}, Lcom/cyjh/elfin/dialog/SettingDialog;->getContext()Landroid/content/Context;

    move-result-object v7

    new-instance v8, Landroid/content/Intent;

    invoke-virtual {p0}, Lcom/cyjh/elfin/dialog/SettingDialog;->getContext()Landroid/content/Context;

    move-result-object v9

    const-class v10, Lcom/cyjh/mobileanjian/ipc/IpcService;

    invoke-direct {v8, v9, v10}, Landroid/content/Intent;-><init>(Landroid/content/Context;Ljava/lang/Class;)V

    invoke-virtual {v7, v8}, Landroid/content/Context;->stopService(Landroid/content/Intent;)Z

    .line 207
    invoke-static {}, Landroid/os/Process;->myPid()I

    move-result v7

    invoke-static {v7}, Landroid/os/Process;->killProcess(I)V

    .line 208
    invoke-virtual {p0}, Lcom/cyjh/elfin/dialog/SettingDialog;->getContext()Landroid/content/Context;

    move-result-object v7

    const-string v8, "activity"

    invoke-virtual {v7, v8}, Landroid/content/Context;->getSystemService(Ljava/lang/String;)Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Landroid/app/ActivityManager;

    .line 209
    .local v0, "activityManager":Landroid/app/ActivityManager;
    invoke-virtual {p0}, Lcom/cyjh/elfin/dialog/SettingDialog;->getContext()Landroid/content/Context;

    move-result-object v7

    new-instance v8, Landroid/content/Intent;

    invoke-virtual {p0}, Lcom/cyjh/elfin/dialog/SettingDialog;->getContext()Landroid/content/Context;

    move-result-object v9

    const-class v10, Lcom/kaopu/download/kernel/DownloadService;

    invoke-direct {v8, v9, v10}, Landroid/content/Intent;-><init>(Landroid/content/Context;Ljava/lang/Class;)V

    invoke-virtual {v7, v8}, Landroid/content/Context;->stopService(Landroid/content/Intent;)Z

    .line 210
    if-eqz v0, :cond_0

    .line 212
    const-string v7, "com.cyjh.elfin:download_server"

    invoke-virtual {v0, v7}, Landroid/app/ActivityManager;->killBackgroundProcesses(Ljava/lang/String;)V

    goto/16 :goto_0

    .line 216
    .end local v0    # "activityManager":Landroid/app/ActivityManager;
    :sswitch_3
    iput-boolean v9, p0, Lcom/cyjh/elfin/dialog/SettingDialog;->isDismiss:Z

    .line 217
    invoke-virtual {p0}, Lcom/cyjh/elfin/dialog/SettingDialog;->dismiss()V

    .line 218
    new-instance v6, Lcom/cyjh/elfin/dialog/ScriptUIDialog;

    invoke-virtual {p0}, Lcom/cyjh/elfin/dialog/SettingDialog;->getContext()Landroid/content/Context;

    move-result-object v7

    invoke-direct {v6, v7}, Lcom/cyjh/elfin/dialog/ScriptUIDialog;-><init>(Landroid/content/Context;)V

    .line 219
    .local v6, "scriptUIDialog":Lcom/cyjh/elfin/dialog/ScriptUIDialog;
    invoke-virtual {v6}, Lcom/cyjh/elfin/dialog/ScriptUIDialog;->show()V

    goto/16 :goto_0

    .line 157
    nop

    :sswitch_data_0
    .sparse-switch
        0x7f0f0091 -> :sswitch_1
        0x7f0f0093 -> :sswitch_2
        0x7f0f0150 -> :sswitch_3
        0x7f0f0156 -> :sswitch_0
    .end sparse-switch
.end method

.method protected onCreate(Landroid/os/Bundle;)V
    .locals 2
    .param p1, "savedInstanceState"    # Landroid/os/Bundle;

    .prologue
    .line 74
    invoke-super {p0, p1}, Lcom/cyjh/elfin/dialog/BaseDialog;->onCreate(Landroid/os/Bundle;)V

    .line 75
    const v0, 0x7f04006b

    invoke-virtual {p0, v0}, Lcom/cyjh/elfin/dialog/SettingDialog;->setContentView(I)V

    .line 76
    const v0, 0x3dcccccd    # 0.1f

    invoke-virtual {p0, v0}, Lcom/cyjh/elfin/dialog/SettingDialog;->setBlurEffect(F)V

    .line 77
    const v0, 0x3f666666    # 0.9f

    const v1, 0x3f19999a    # 0.6f

    invoke-virtual {p0, v0, v1}, Lcom/cyjh/elfin/dialog/SettingDialog;->setDialogSize(FF)V

    .line 78
    invoke-direct {p0}, Lcom/cyjh/elfin/dialog/SettingDialog;->initView()V

    .line 79
    return-void
.end method
