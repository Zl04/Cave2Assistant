.class public Lcom/cyjh/elfin/AppContext;
.super Landroid/app/Application;
.source "AppContext.java"

# interfaces
.implements Lcom/cyjh/elfin/constant/APPConstant;
.implements Lcom/cyjh/mobileanjian/ipc/interfaces/OnKeyEventListener;
.implements Lcom/cyjh/mobileanjian/ipc/interfaces/OnScriptListener;


# annotations
.annotation system Ldalvik/annotation/MemberClasses;
    value = {
        Lcom/cyjh/elfin/AppContext$BlackListCountTimeRunnable;,
        Lcom/cyjh/elfin/AppContext$ScreenOrientationConversion;,
        Lcom/cyjh/elfin/AppContext$ShakeListener;
    }
.end annotation


# static fields
.field private static final BLACK_LIST_RANDOM_TIME_EXPIRE_MSG:I = 0x110

.field private static final LOG_TAG:Ljava/lang/String; = "ELFIN"

.field private static final LOOP_INTERINVAL_TIME:I = 0x7530

.field private static final RANDOM_TIME_EXPIRE_SECOND_MSG:I = 0x120

.field private static booted:Z

.field protected static mAppContext:Lcom/cyjh/elfin/AppContext;

.field private static mRequestQueue:Lcom/android/volley/RequestQueue;


# instance fields
.field public PATH_APPFILE:Ljava/lang/String;

.field public PATH_PACKAGENAME_LOG:Ljava/lang/String;

.field public PATH_SDCARD:Ljava/lang/String;

.field public STATE_SCRIPT:I

.field public checkedScreenOrientation:Z

.field public commonLog:Lcom/cyjh/elfin/log/CommonLog;

.field public connection:Lcom/kaopu/download/kernel/DownloadServiceConnection;

.field private countTimeAdd:I

.field public display:Landroid/view/Display;

.field private fwManagerFloat:Lcom/cyjh/elfin/floatview/XunFeiFloatManager;

.field private isBlackTimerArrive:Z

.field public isLoadBottomAd:Z

.field public isOnclickXunFei:Z

.field public isVerifyPass:I

.field private mBlackListRunnable:Lcom/cyjh/elfin/AppContext$BlackListCountTimeRunnable;

.field public mElfinFloatView:Lcom/cyjh/elfin/floatview/ElfinFloatView;

.field private mHandler:Landroid/os/Handler;

.field public mScreenConversion:Lcom/cyjh/elfin/AppContext$ScreenOrientationConversion;

.field public mScript:Lcom/cyjh/elfin/entity/Script;

.field private mScriptStartTime:J

.field public mSharePre:Landroid/content/SharedPreferences;

.field public mUipHelper:Lcom/cyjh/mobileanjian/ipc/uip/UipHelper;

.field private mobileIMIE:Ljava/lang/String;

.field private mqRunner:Lcom/cyjh/mobileanjian/ipc/MqRunner;

.field public runTime:I

.field private script4Run:Lcom/cyjh/mobileanjian/ipc/stuff/Script4Run;

.field public sharedPreferences:Landroid/content/SharedPreferences;

.field private totalCount:I

.field private windowManager:Landroid/view/WindowManager;


# direct methods
.method static constructor <clinit>()V
    .locals 1

    .prologue
    .line 125
    const/4 v0, 0x0

    sput-boolean v0, Lcom/cyjh/elfin/AppContext;->booted:Z

    return-void
.end method

.method public constructor <init>()V
    .locals 2

    .prologue
    const/4 v1, 0x0

    .line 91
    invoke-direct {p0}, Landroid/app/Application;-><init>()V

    .line 100
    new-instance v0, Lcom/cyjh/elfin/log/CommonLog;

    invoke-direct {v0}, Lcom/cyjh/elfin/log/CommonLog;-><init>()V

    iput-object v0, p0, Lcom/cyjh/elfin/AppContext;->commonLog:Lcom/cyjh/elfin/log/CommonLog;

    .line 120
    iput v1, p0, Lcom/cyjh/elfin/AppContext;->STATE_SCRIPT:I

    .line 127
    iput v1, p0, Lcom/cyjh/elfin/AppContext;->runTime:I

    .line 128
    iput v1, p0, Lcom/cyjh/elfin/AppContext;->isVerifyPass:I

    .line 130
    iput-boolean v1, p0, Lcom/cyjh/elfin/AppContext;->checkedScreenOrientation:Z

    .line 767
    iput v1, p0, Lcom/cyjh/elfin/AppContext;->totalCount:I

    .line 800
    new-instance v0, Lcom/cyjh/elfin/AppContext$3;

    invoke-direct {v0, p0}, Lcom/cyjh/elfin/AppContext$3;-><init>(Lcom/cyjh/elfin/AppContext;)V

    iput-object v0, p0, Lcom/cyjh/elfin/AppContext;->mHandler:Landroid/os/Handler;

    .line 855
    iput-boolean v1, p0, Lcom/cyjh/elfin/AppContext;->isLoadBottomAd:Z

    .line 856
    iput-boolean v1, p0, Lcom/cyjh/elfin/AppContext;->isOnclickXunFei:Z

    return-void
.end method

.method static synthetic access$000(Lcom/cyjh/elfin/AppContext;)Lcom/cyjh/mobileanjian/ipc/MqRunner;
    .locals 1
    .param p0, "x0"    # Lcom/cyjh/elfin/AppContext;

    .prologue
    .line 91
    iget-object v0, p0, Lcom/cyjh/elfin/AppContext;->mqRunner:Lcom/cyjh/mobileanjian/ipc/MqRunner;

    return-object v0
.end method

.method static synthetic access$100(Lcom/cyjh/elfin/AppContext;)Landroid/os/Handler;
    .locals 1
    .param p0, "x0"    # Lcom/cyjh/elfin/AppContext;

    .prologue
    .line 91
    iget-object v0, p0, Lcom/cyjh/elfin/AppContext;->mHandler:Landroid/os/Handler;

    return-object v0
.end method

.method static synthetic access$200(Lcom/cyjh/elfin/AppContext;)I
    .locals 1
    .param p0, "x0"    # Lcom/cyjh/elfin/AppContext;

    .prologue
    .line 91
    iget v0, p0, Lcom/cyjh/elfin/AppContext;->countTimeAdd:I

    return v0
.end method

.method static synthetic access$202(Lcom/cyjh/elfin/AppContext;I)I
    .locals 0
    .param p0, "x0"    # Lcom/cyjh/elfin/AppContext;
    .param p1, "x1"    # I

    .prologue
    .line 91
    iput p1, p0, Lcom/cyjh/elfin/AppContext;->countTimeAdd:I

    return p1
.end method

.method static synthetic access$208(Lcom/cyjh/elfin/AppContext;)I
    .locals 2
    .param p0, "x0"    # Lcom/cyjh/elfin/AppContext;

    .prologue
    .line 91
    iget v0, p0, Lcom/cyjh/elfin/AppContext;->countTimeAdd:I

    add-int/lit8 v1, v0, 0x1

    iput v1, p0, Lcom/cyjh/elfin/AppContext;->countTimeAdd:I

    return v0
.end method

.method static synthetic access$300(Lcom/cyjh/elfin/AppContext;)I
    .locals 1
    .param p0, "x0"    # Lcom/cyjh/elfin/AppContext;

    .prologue
    .line 91
    iget v0, p0, Lcom/cyjh/elfin/AppContext;->totalCount:I

    return v0
.end method

.method static synthetic access$400(Lcom/cyjh/elfin/AppContext;)Z
    .locals 1
    .param p0, "x0"    # Lcom/cyjh/elfin/AppContext;

    .prologue
    .line 91
    iget-boolean v0, p0, Lcom/cyjh/elfin/AppContext;->isBlackTimerArrive:Z

    return v0
.end method

.method static synthetic access$402(Lcom/cyjh/elfin/AppContext;Z)Z
    .locals 0
    .param p0, "x0"    # Lcom/cyjh/elfin/AppContext;
    .param p1, "x1"    # Z

    .prologue
    .line 91
    iput-boolean p1, p0, Lcom/cyjh/elfin/AppContext;->isBlackTimerArrive:Z

    return p1
.end method

.method static synthetic access$500(Lcom/cyjh/elfin/AppContext;I)V
    .locals 0
    .param p0, "x0"    # Lcom/cyjh/elfin/AppContext;
    .param p1, "x1"    # I

    .prologue
    .line 91
    invoke-direct {p0, p1}, Lcom/cyjh/elfin/AppContext;->randomTimeConvertTotal(I)V

    return-void
.end method

.method static synthetic access$600(Lcom/cyjh/elfin/AppContext;)Lcom/cyjh/elfin/AppContext$BlackListCountTimeRunnable;
    .locals 1
    .param p0, "x0"    # Lcom/cyjh/elfin/AppContext;

    .prologue
    .line 91
    iget-object v0, p0, Lcom/cyjh/elfin/AppContext;->mBlackListRunnable:Lcom/cyjh/elfin/AppContext$BlackListCountTimeRunnable;

    return-object v0
.end method

.method private createDirs()V
    .locals 2

    .prologue
    .line 213
    new-instance v0, Ljava/io/File;

    iget-object v1, p0, Lcom/cyjh/elfin/AppContext;->PATH_PACKAGENAME_LOG:Ljava/lang/String;

    invoke-direct {v0, v1}, Ljava/io/File;-><init>(Ljava/lang/String;)V

    .line 214
    .local v0, "logFile":Ljava/io/File;
    invoke-virtual {v0}, Ljava/io/File;->exists()Z

    move-result v1

    if-nez v1, :cond_0

    .line 215
    invoke-virtual {v0}, Ljava/io/File;->mkdirs()Z

    .line 217
    :cond_0
    return-void
.end method

.method private createElfinFloatView()V
    .locals 4

    .prologue
    .line 332
    new-instance v0, Lcom/cyjh/elfin/floatview/DeleteFloatView;

    invoke-direct {v0, p0}, Lcom/cyjh/elfin/floatview/DeleteFloatView;-><init>(Landroid/content/Context;)V

    .line 333
    .local v0, "deleteFloatView":Lcom/cyjh/elfin/floatview/DeleteFloatView;
    new-instance v1, Lcom/cyjh/elfin/floatview/ElfinFloatView;

    invoke-direct {v1, p0, v0}, Lcom/cyjh/elfin/floatview/ElfinFloatView;-><init>(Landroid/content/Context;Lcom/cyjh/elfin/floatview/DeleteFloatView;)V

    iput-object v1, p0, Lcom/cyjh/elfin/AppContext;->mElfinFloatView:Lcom/cyjh/elfin/floatview/ElfinFloatView;

    .line 334
    iget-object v1, p0, Lcom/cyjh/elfin/AppContext;->windowManager:Landroid/view/WindowManager;

    invoke-virtual {v0}, Lcom/cyjh/elfin/floatview/DeleteFloatView;->getLayoutParams()Landroid/view/WindowManager$LayoutParams;

    move-result-object v2

    invoke-interface {v1, v0, v2}, Landroid/view/WindowManager;->addView(Landroid/view/View;Landroid/view/ViewGroup$LayoutParams;)V

    .line 335
    iget-object v1, p0, Lcom/cyjh/elfin/AppContext;->windowManager:Landroid/view/WindowManager;

    iget-object v2, p0, Lcom/cyjh/elfin/AppContext;->mElfinFloatView:Lcom/cyjh/elfin/floatview/ElfinFloatView;

    iget-object v3, p0, Lcom/cyjh/elfin/AppContext;->mElfinFloatView:Lcom/cyjh/elfin/floatview/ElfinFloatView;

    invoke-virtual {v3}, Lcom/cyjh/elfin/floatview/ElfinFloatView;->getLayoutParams()Landroid/view/WindowManager$LayoutParams;

    move-result-object v3

    invoke-interface {v1, v2, v3}, Landroid/view/WindowManager;->addView(Landroid/view/View;Landroid/view/ViewGroup$LayoutParams;)V

    .line 336
    const/4 v1, 0x2

    invoke-virtual {p0}, Lcom/cyjh/elfin/AppContext;->getResources()Landroid/content/res/Resources;

    move-result-object v2

    invoke-virtual {v2}, Landroid/content/res/Resources;->getConfiguration()Landroid/content/res/Configuration;

    move-result-object v2

    iget v2, v2, Landroid/content/res/Configuration;->orientation:I

    if-ne v1, v2, :cond_0

    .line 337
    iget-object v1, p0, Lcom/cyjh/elfin/AppContext;->mElfinFloatView:Lcom/cyjh/elfin/floatview/ElfinFloatView;

    invoke-virtual {v1}, Lcom/cyjh/elfin/floatview/ElfinFloatView;->rotateScreen()V

    .line 341
    :cond_0
    return-void
.end method

.method public static getInstance()Lcom/cyjh/elfin/AppContext;
    .locals 1

    .prologue
    .line 763
    sget-object v0, Lcom/cyjh/elfin/AppContext;->mAppContext:Lcom/cyjh/elfin/AppContext;

    return-object v0
.end method

.method public static getmRequestQueue()Lcom/android/volley/RequestQueue;
    .locals 1

    .prologue
    .line 183
    sget-object v0, Lcom/cyjh/elfin/AppContext;->mRequestQueue:Lcom/android/volley/RequestQueue;

    return-object v0
.end method

.method private initMQScript()V
    .locals 11

    .prologue
    .line 259
    new-instance v3, Ljava/io/File;

    iget-object v8, p0, Lcom/cyjh/elfin/AppContext;->PATH_APPFILE:Ljava/lang/String;

    const-string v9, "script.lc"

    invoke-static {v8, v9}, Lcom/cyjh/elfin/util/FileUtils;->makePath(Ljava/lang/String;Ljava/lang/String;)Ljava/lang/String;

    move-result-object v8

    invoke-direct {v3, v8}, Ljava/io/File;-><init>(Ljava/lang/String;)V

    .line 260
    .local v3, "lcFile":Ljava/io/File;
    new-instance v4, Ljava/io/File;

    iget-object v8, p0, Lcom/cyjh/elfin/AppContext;->PATH_APPFILE:Ljava/lang/String;

    const-string v9, "script.prop"

    invoke-static {v8, v9}, Lcom/cyjh/elfin/util/FileUtils;->makePath(Ljava/lang/String;Ljava/lang/String;)Ljava/lang/String;

    move-result-object v8

    invoke-direct {v4, v8}, Ljava/io/File;-><init>(Ljava/lang/String;)V

    .line 261
    .local v4, "propFile":Ljava/io/File;
    new-instance v0, Ljava/io/File;

    iget-object v8, p0, Lcom/cyjh/elfin/AppContext;->PATH_APPFILE:Ljava/lang/String;

    const-string v9, "script.atc"

    invoke-static {v8, v9}, Lcom/cyjh/elfin/util/FileUtils;->makePath(Ljava/lang/String;Ljava/lang/String;)Ljava/lang/String;

    move-result-object v8

    invoke-direct {v0, v8}, Ljava/io/File;-><init>(Ljava/lang/String;)V

    .line 262
    .local v0, "atcFile":Ljava/io/File;
    new-instance v6, Ljava/io/File;

    iget-object v8, p0, Lcom/cyjh/elfin/AppContext;->PATH_APPFILE:Ljava/lang/String;

    const-string v9, "script.ui"

    invoke-static {v8, v9}, Lcom/cyjh/elfin/util/FileUtils;->makePath(Ljava/lang/String;Ljava/lang/String;)Ljava/lang/String;

    move-result-object v8

    invoke-direct {v6, v8}, Ljava/io/File;-><init>(Ljava/lang/String;)V

    .line 263
    .local v6, "uiFile":Ljava/io/File;
    new-instance v7, Ljava/io/File;

    iget-object v8, p0, Lcom/cyjh/elfin/AppContext;->PATH_APPFILE:Ljava/lang/String;

    const-string v9, "script.uip"

    invoke-static {v8, v9}, Lcom/cyjh/elfin/util/FileUtils;->makePath(Ljava/lang/String;Ljava/lang/String;)Ljava/lang/String;

    move-result-object v8

    invoke-direct {v7, v8}, Ljava/io/File;-><init>(Ljava/lang/String;)V

    .line 264
    .local v7, "uipFile":Ljava/io/File;
    new-instance v5, Ljava/io/File;

    iget-object v8, p0, Lcom/cyjh/elfin/AppContext;->PATH_APPFILE:Ljava/lang/String;

    const-string v9, "script.rtd"

    invoke-static {v8, v9}, Lcom/cyjh/elfin/util/FileUtils;->makePath(Ljava/lang/String;Ljava/lang/String;)Ljava/lang/String;

    move-result-object v8

    invoke-direct {v5, v8}, Ljava/io/File;-><init>(Ljava/lang/String;)V

    .line 265
    .local v5, "rtdFile":Ljava/io/File;
    new-instance v1, Ljava/io/File;

    iget-object v8, p0, Lcom/cyjh/elfin/AppContext;->PATH_APPFILE:Ljava/lang/String;

    const-string v9, "script.cfg"

    invoke-static {v8, v9}, Lcom/cyjh/elfin/util/FileUtils;->makePath(Ljava/lang/String;Ljava/lang/String;)Ljava/lang/String;

    move-result-object v8

    invoke-direct {v1, v8}, Ljava/io/File;-><init>(Ljava/lang/String;)V

    .line 267
    .local v1, "cfgFile":Ljava/io/File;
    :try_start_0
    invoke-virtual {p0}, Lcom/cyjh/elfin/AppContext;->getAssets()Landroid/content/res/AssetManager;

    move-result-object v8

    const-string v9, "script.prop"

    invoke-virtual {v8, v9}, Landroid/content/res/AssetManager;->open(Ljava/lang/String;)Ljava/io/InputStream;

    move-result-object v8

    invoke-static {v8}, Lcom/cyjh/elfin/util/JsonUtils;->parPropJson(Ljava/io/InputStream;)Lcom/cyjh/elfin/entity/Script;

    move-result-object v8

    iput-object v8, p0, Lcom/cyjh/elfin/AppContext;->mScript:Lcom/cyjh/elfin/entity/Script;

    .line 269
    iget-object v8, p0, Lcom/cyjh/elfin/AppContext;->commonLog:Lcom/cyjh/elfin/log/CommonLog;

    new-instance v9, Ljava/lang/StringBuilder;

    invoke-direct {v9}, Ljava/lang/StringBuilder;-><init>()V

    const-string v10, "mScript = "

    invoke-virtual {v9, v10}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v9

    iget-object v10, p0, Lcom/cyjh/elfin/AppContext;->mScript:Lcom/cyjh/elfin/entity/Script;

    invoke-virtual {v9, v10}, Ljava/lang/StringBuilder;->append(Ljava/lang/Object;)Ljava/lang/StringBuilder;

    move-result-object v9

    invoke-virtual {v9}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v9

    invoke-virtual {v8, v9}, Lcom/cyjh/elfin/log/CommonLog;->e(Ljava/lang/Object;)V
    :try_end_0
    .catch Ljava/io/IOException; {:try_start_0 .. :try_end_0} :catch_0

    .line 273
    :goto_0
    iget-object v8, p0, Lcom/cyjh/elfin/AppContext;->mScript:Lcom/cyjh/elfin/entity/Script;

    invoke-virtual {v8, v3}, Lcom/cyjh/elfin/entity/Script;->setLcFile(Ljava/io/File;)V

    .line 274
    iget-object v8, p0, Lcom/cyjh/elfin/AppContext;->mScript:Lcom/cyjh/elfin/entity/Script;

    invoke-virtual {v8, v4}, Lcom/cyjh/elfin/entity/Script;->setPropFile(Ljava/io/File;)V

    .line 275
    iget-object v8, p0, Lcom/cyjh/elfin/AppContext;->mScript:Lcom/cyjh/elfin/entity/Script;

    invoke-virtual {v8, v0}, Lcom/cyjh/elfin/entity/Script;->setAtcFile(Ljava/io/File;)V

    .line 276
    iget-object v8, p0, Lcom/cyjh/elfin/AppContext;->mScript:Lcom/cyjh/elfin/entity/Script;

    invoke-virtual {v8, v6}, Lcom/cyjh/elfin/entity/Script;->setUiFile(Ljava/io/File;)V

    .line 277
    iget-object v8, p0, Lcom/cyjh/elfin/AppContext;->mScript:Lcom/cyjh/elfin/entity/Script;

    invoke-virtual {v8, v7}, Lcom/cyjh/elfin/entity/Script;->setUipFile(Ljava/io/File;)V

    .line 278
    iget-object v8, p0, Lcom/cyjh/elfin/AppContext;->mScript:Lcom/cyjh/elfin/entity/Script;

    invoke-virtual {v8, v5}, Lcom/cyjh/elfin/entity/Script;->setRtdFile(Ljava/io/File;)V

    .line 279
    iget-object v8, p0, Lcom/cyjh/elfin/AppContext;->mScript:Lcom/cyjh/elfin/entity/Script;

    invoke-virtual {v8, v1}, Lcom/cyjh/elfin/entity/Script;->setCfgFile(Ljava/io/File;)V

    .line 282
    return-void

    .line 270
    :catch_0
    move-exception v2

    .line 271
    .local v2, "e":Ljava/io/IOException;
    invoke-virtual {v2}, Ljava/io/IOException;->printStackTrace()V

    goto :goto_0
.end method

.method private initObject()V
    .locals 3

    .prologue
    const/4 v2, 0x0

    .line 162
    invoke-static {}, Lcom/cyjh/elfin/constant/MyBuildConfig;->isOutputLog()Z

    move-result v0

    if-eqz v0, :cond_0

    .line 163
    const-string v0, "ELFIN"

    invoke-static {v0}, Lcom/orhanobut/logger/Logger;->init(Ljava/lang/String;)Lcom/orhanobut/logger/Settings;

    move-result-object v0

    sget-object v1, Lcom/orhanobut/logger/LogLevel;->FULL:Lcom/orhanobut/logger/LogLevel;

    invoke-virtual {v0, v1}, Lcom/orhanobut/logger/Settings;->setLogLevel(Lcom/orhanobut/logger/LogLevel;)Lcom/orhanobut/logger/Settings;

    .line 167
    :goto_0
    const-string v0, "com.cyjh.elfin.AppContext"

    invoke-virtual {p0, v0, v2}, Lcom/cyjh/elfin/AppContext;->getSharedPreferences(Ljava/lang/String;I)Landroid/content/SharedPreferences;

    move-result-object v0

    iput-object v0, p0, Lcom/cyjh/elfin/AppContext;->sharedPreferences:Landroid/content/SharedPreferences;

    .line 168
    const-string v0, "small_red_dot"

    invoke-virtual {p0, v0, v2}, Lcom/cyjh/elfin/AppContext;->getSharedPreferences(Ljava/lang/String;I)Landroid/content/SharedPreferences;

    move-result-object v0

    iput-object v0, p0, Lcom/cyjh/elfin/AppContext;->mSharePre:Landroid/content/SharedPreferences;

    .line 169
    invoke-virtual {p0}, Lcom/cyjh/elfin/AppContext;->getApplicationContext()Landroid/content/Context;

    move-result-object v0

    invoke-static {v0}, Lcom/android/volley/toolbox/Volley;->newRequestQueue(Landroid/content/Context;)Lcom/android/volley/RequestQueue;

    move-result-object v0

    sput-object v0, Lcom/cyjh/elfin/AppContext;->mRequestQueue:Lcom/android/volley/RequestQueue;

    .line 170
    invoke-static {}, Lcom/cyjh/elfin/net/volley/VollerHttpManager;->getInstance()Lcom/cyjh/elfin/net/volley/VollerHttpManager;

    move-result-object v0

    sget-object v1, Lcom/cyjh/elfin/AppContext;->mRequestQueue:Lcom/android/volley/RequestQueue;

    invoke-virtual {v0, v1}, Lcom/cyjh/elfin/net/volley/VollerHttpManager;->init(Lcom/android/volley/RequestQueue;)V

    .line 171
    return-void

    .line 165
    :cond_0
    const-string v0, "ELFIN"

    invoke-static {v0}, Lcom/orhanobut/logger/Logger;->init(Ljava/lang/String;)Lcom/orhanobut/logger/Settings;

    move-result-object v0

    sget-object v1, Lcom/orhanobut/logger/LogLevel;->NONE:Lcom/orhanobut/logger/LogLevel;

    invoke-virtual {v0, v1}, Lcom/orhanobut/logger/Settings;->setLogLevel(Lcom/orhanobut/logger/LogLevel;)Lcom/orhanobut/logger/Settings;

    goto :goto_0
.end method

.method private initPath()V
    .locals 10

    .prologue
    const/4 v7, 0x0

    .line 194
    iget-object v3, p0, Lcom/cyjh/elfin/AppContext;->mSharePre:Landroid/content/SharedPreferences;

    const-string v6, "save_network_message"

    const-wide/16 v8, 0x0

    invoke-interface {v3, v6, v8, v9}, Landroid/content/SharedPreferences;->getLong(Ljava/lang/String;J)J

    move-result-wide v4

    .line 195
    .local v4, "timingFileTime":J
    invoke-static {}, Ljava/lang/System;->currentTimeMillis()J

    move-result-wide v0

    .line 196
    .local v0, "currentTime":J
    new-instance v3, Ljava/lang/StringBuilder;

    invoke-direct {v3}, Ljava/lang/StringBuilder;-><init>()V

    const-string v6, "\u662f\u5426\u5220\u6389\u6587\u4ef6:"

    invoke-virtual {v3, v6}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v3

    invoke-virtual {v3, v4, v5}, Ljava/lang/StringBuilder;->append(J)Ljava/lang/StringBuilder;

    move-result-object v3

    const-string v6, ",current:"

    invoke-virtual {v3, v6}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v3

    invoke-virtual {v3, v0, v1}, Ljava/lang/StringBuilder;->append(J)Ljava/lang/StringBuilder;

    move-result-object v3

    invoke-virtual {v3}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v3

    new-array v6, v7, [Ljava/lang/Object;

    invoke-static {v3, v6}, Lcom/orhanobut/logger/Logger;->e(Ljava/lang/String;[Ljava/lang/Object;)V

    .line 197
    cmp-long v3, v4, v0

    if-gez v3, :cond_0

    .line 198
    invoke-static {p0}, Lcom/cyjh/elfin/constant/Constants;->getNetworkErrorLogFile(Landroid/content/Context;)Ljava/io/File;

    move-result-object v3

    invoke-virtual {v3}, Ljava/io/File;->delete()Z

    move-result v2

    .line 199
    .local v2, "isDelete":Z
    new-instance v3, Ljava/lang/StringBuilder;

    invoke-direct {v3}, Ljava/lang/StringBuilder;-><init>()V

    const-string v6, "\u662f\u5426\u5220\u6389\u6587\u4ef6:"

    invoke-virtual {v3, v6}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v3

    invoke-virtual {v3, v2}, Ljava/lang/StringBuilder;->append(Z)Ljava/lang/StringBuilder;

    move-result-object v3

    invoke-virtual {v3, v4, v5}, Ljava/lang/StringBuilder;->append(J)Ljava/lang/StringBuilder;

    move-result-object v3

    const-string v6, ",current:"

    invoke-virtual {v3, v6}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v3

    invoke-virtual {v3, v0, v1}, Ljava/lang/StringBuilder;->append(J)Ljava/lang/StringBuilder;

    move-result-object v3

    invoke-virtual {v3}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v3

    new-array v6, v7, [Ljava/lang/Object;

    invoke-static {v3, v6}, Lcom/orhanobut/logger/Logger;->e(Ljava/lang/String;[Ljava/lang/Object;)V

    .line 200
    iget-object v3, p0, Lcom/cyjh/elfin/AppContext;->mSharePre:Landroid/content/SharedPreferences;

    invoke-interface {v3}, Landroid/content/SharedPreferences;->edit()Landroid/content/SharedPreferences$Editor;

    move-result-object v3

    const-string v6, "network_file_is_exist"

    invoke-interface {v3, v6, v7}, Landroid/content/SharedPreferences$Editor;->putBoolean(Ljava/lang/String;Z)Landroid/content/SharedPreferences$Editor;

    move-result-object v3

    invoke-interface {v3}, Landroid/content/SharedPreferences$Editor;->commit()Z

    .line 202
    .end local v2    # "isDelete":Z
    :cond_0
    invoke-virtual {p0}, Lcom/cyjh/elfin/AppContext;->getFilesDir()Ljava/io/File;

    move-result-object v3

    invoke-virtual {v3}, Ljava/io/File;->getAbsolutePath()Ljava/lang/String;

    move-result-object v3

    iput-object v3, p0, Lcom/cyjh/elfin/AppContext;->PATH_APPFILE:Ljava/lang/String;

    .line 203
    new-instance v3, Ljava/lang/StringBuilder;

    invoke-direct {v3}, Ljava/lang/StringBuilder;-><init>()V

    const-string v6, "PATH_APPFILE="

    invoke-virtual {v3, v6}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v3

    iget-object v6, p0, Lcom/cyjh/elfin/AppContext;->PATH_APPFILE:Ljava/lang/String;

    invoke-virtual {v3, v6}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v3

    invoke-virtual {v3}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v3

    new-array v6, v7, [Ljava/lang/Object;

    invoke-static {v3, v6}, Lcom/orhanobut/logger/Logger;->e(Ljava/lang/String;[Ljava/lang/Object;)V

    .line 204
    invoke-static {}, Landroid/os/Environment;->getExternalStorageDirectory()Ljava/io/File;

    move-result-object v3

    invoke-virtual {v3}, Ljava/io/File;->getAbsolutePath()Ljava/lang/String;

    move-result-object v3

    iput-object v3, p0, Lcom/cyjh/elfin/AppContext;->PATH_SDCARD:Ljava/lang/String;

    .line 205
    iget-object v3, p0, Lcom/cyjh/elfin/AppContext;->PATH_SDCARD:Ljava/lang/String;

    invoke-virtual {p0}, Lcom/cyjh/elfin/AppContext;->getPackageName()Ljava/lang/String;

    move-result-object v6

    invoke-static {v3, v6}, Lcom/cyjh/elfin/util/FileUtils;->makePath(Ljava/lang/String;Ljava/lang/String;)Ljava/lang/String;

    move-result-object v3

    const-string v6, "log"

    invoke-static {v3, v6}, Lcom/cyjh/elfin/util/FileUtils;->makePath(Ljava/lang/String;Ljava/lang/String;)Ljava/lang/String;

    move-result-object v3

    iput-object v3, p0, Lcom/cyjh/elfin/AppContext;->PATH_PACKAGENAME_LOG:Ljava/lang/String;

    .line 206
    invoke-direct {p0}, Lcom/cyjh/elfin/AppContext;->createDirs()V

    .line 207
    return-void
.end method

.method private initScript4Run()V
    .locals 4

    .prologue
    .line 221
    new-instance v0, Lcom/cyjh/mobileanjian/ipc/stuff/Script4Run;

    iget-object v1, p0, Lcom/cyjh/elfin/AppContext;->mScript:Lcom/cyjh/elfin/entity/Script;

    invoke-virtual {v1}, Lcom/cyjh/elfin/entity/Script;->getLcFile()Ljava/io/File;

    move-result-object v1

    invoke-virtual {v1}, Ljava/io/File;->getAbsolutePath()Ljava/lang/String;

    move-result-object v1

    iget-object v2, p0, Lcom/cyjh/elfin/AppContext;->mScript:Lcom/cyjh/elfin/entity/Script;

    .line 222
    invoke-virtual {v2}, Lcom/cyjh/elfin/entity/Script;->getAtcFile()Ljava/io/File;

    move-result-object v2

    invoke-virtual {v2}, Ljava/io/File;->getAbsolutePath()Ljava/lang/String;

    move-result-object v2

    iget-object v3, p0, Lcom/cyjh/elfin/AppContext;->mScript:Lcom/cyjh/elfin/entity/Script;

    invoke-virtual {v3}, Lcom/cyjh/elfin/entity/Script;->getCfgFile()Ljava/io/File;

    move-result-object v3

    invoke-virtual {v3}, Ljava/io/File;->getAbsolutePath()Ljava/lang/String;

    move-result-object v3

    invoke-direct {v0, v1, v2, v3}, Lcom/cyjh/mobileanjian/ipc/stuff/Script4Run;-><init>(Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;)V

    iput-object v0, p0, Lcom/cyjh/elfin/AppContext;->script4Run:Lcom/cyjh/mobileanjian/ipc/stuff/Script4Run;

    .line 223
    iget-object v0, p0, Lcom/cyjh/elfin/AppContext;->mqRunner:Lcom/cyjh/mobileanjian/ipc/MqRunner;

    iget-object v1, p0, Lcom/cyjh/elfin/AppContext;->script4Run:Lcom/cyjh/mobileanjian/ipc/stuff/Script4Run;

    invoke-virtual {v0, v1}, Lcom/cyjh/mobileanjian/ipc/MqRunner;->setScript(Lcom/cyjh/mobileanjian/ipc/stuff/Script4Run;)Lcom/cyjh/mobileanjian/ipc/MqRunner;

    .line 224
    return-void
.end method

.method private initShake()V
    .locals 3

    .prologue
    .line 300
    const-string v2, "vibrator"

    invoke-virtual {p0, v2}, Lcom/cyjh/elfin/AppContext;->getSystemService(Ljava/lang/String;)Ljava/lang/Object;

    move-result-object v1

    check-cast v1, Landroid/os/Vibrator;

    .line 301
    .local v1, "vibrator":Landroid/os/Vibrator;
    new-instance v0, Lcom/cyjh/elfin/AppContext$ShakeListener;

    invoke-direct {v0, p0}, Lcom/cyjh/elfin/AppContext$ShakeListener;-><init>(Landroid/content/Context;)V

    .line 302
    .local v0, "mShakeListener":Lcom/cyjh/elfin/AppContext$ShakeListener;
    new-instance v2, Lcom/cyjh/elfin/AppContext$1;

    invoke-direct {v2, p0, v0, v1}, Lcom/cyjh/elfin/AppContext$1;-><init>(Lcom/cyjh/elfin/AppContext;Lcom/cyjh/elfin/AppContext$ShakeListener;Landroid/os/Vibrator;)V

    invoke-virtual {v0, v2}, Lcom/cyjh/elfin/AppContext$ShakeListener;->setOnShakeListener(Lcom/cyjh/elfin/AppContext$ShakeListener$OnShakeListener;)V

    .line 321
    return-void
.end method

.method private initUmeng()V
    .locals 3

    .prologue
    const/4 v2, 0x0

    .line 188
    const-string v0, "Umeng"

    const/4 v1, 0x1

    invoke-static {p0, v2, v0, v1, v2}, Lcom/umeng/commonsdk/UMConfigure;->init(Landroid/content/Context;Ljava/lang/String;Ljava/lang/String;ILjava/lang/String;)V

    .line 189
    const/4 v0, 0x0

    invoke-static {v0}, Lcom/umeng/analytics/MobclickAgent;->openActivityDurationTrack(Z)V

    .line 190
    return-void
.end method

.method private initlService()V
    .locals 2

    .prologue
    .line 246
    new-instance v0, Landroid/content/Intent;

    const-class v1, Lcom/cyjh/elfin/services/PhoneStateService;

    invoke-direct {v0, p0, v1}, Landroid/content/Intent;-><init>(Landroid/content/Context;Ljava/lang/Class;)V

    invoke-virtual {p0, v0}, Lcom/cyjh/elfin/AppContext;->startService(Landroid/content/Intent;)Landroid/content/ComponentName;

    .line 247
    return-void
.end method

.method private intMobileIMIE()V
    .locals 2

    .prologue
    .line 174
    const-string v1, "phone"

    invoke-virtual {p0, v1}, Lcom/cyjh/elfin/AppContext;->getSystemService(Ljava/lang/String;)Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Landroid/telephony/TelephonyManager;

    .line 175
    .local v0, "TelephonyMgr":Landroid/telephony/TelephonyManager;
    invoke-virtual {v0}, Landroid/telephony/TelephonyManager;->getDeviceId()Ljava/lang/String;

    move-result-object v1

    iput-object v1, p0, Lcom/cyjh/elfin/AppContext;->mobileIMIE:Ljava/lang/String;

    .line 176
    return-void
.end method

.method private randomTimeConvertTotal(I)V
    .locals 1
    .param p1, "randomTime"    # I

    .prologue
    .line 835
    mul-int/lit8 v0, p1, 0x3c

    mul-int/lit16 v0, v0, 0x3e8

    div-int/lit16 v0, v0, 0x7530

    iput v0, p0, Lcom/cyjh/elfin/AppContext;->totalCount:I

    .line 836
    return-void
.end method

.method private startAppViaVolume()V
    .locals 7

    .prologue
    const/4 v6, 0x0

    .line 592
    iget-object v1, p0, Lcom/cyjh/elfin/AppContext;->mqRunner:Lcom/cyjh/mobileanjian/ipc/MqRunner;

    invoke-virtual {v1}, Lcom/cyjh/mobileanjian/ipc/MqRunner;->isScriptStarted()Z

    move-result v1

    if-nez v1, :cond_1

    iget v1, p0, Lcom/cyjh/elfin/AppContext;->isVerifyPass:I

    if-eqz v1, :cond_1

    .line 595
    new-instance v1, Ljava/lang/StringBuilder;

    invoke-direct {v1}, Ljava/lang/StringBuilder;-><init>()V

    const-string v2, "AppContext onKeyEvent \u968f\u673a\u65f6\u95f4\u4e3a\uff1arunTime "

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    iget v2, p0, Lcom/cyjh/elfin/AppContext;->runTime:I

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v1

    new-array v2, v6, [Ljava/lang/Object;

    invoke-static {v1, v2}, Lcom/orhanobut/logger/Logger;->e(Ljava/lang/String;[Ljava/lang/Object;)V

    .line 596
    iget v1, p0, Lcom/cyjh/elfin/AppContext;->runTime:I

    if-lez v1, :cond_0

    .line 598
    invoke-static {}, Ljava/lang/Math;->random()D

    move-result-wide v2

    const-wide/high16 v4, 0x404e000000000000L    # 60.0

    mul-double/2addr v2, v4

    const-wide/high16 v4, 0x403e000000000000L    # 30.0

    add-double/2addr v2, v4

    double-to-int v0, v2

    .line 600
    .local v0, "randomRunTime":I
    invoke-direct {p0, v0}, Lcom/cyjh/elfin/AppContext;->randomTimeConvertTotal(I)V

    .line 601
    new-instance v1, Ljava/lang/StringBuilder;

    invoke-direct {v1}, Ljava/lang/StringBuilder;-><init>()V

    const-string v2, "AppContext onKeyEvent \u8bbe\u7f6e\u65f6\u95f4\u4e3a\uff1arandomRunTime "

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1, v0}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v1

    new-array v2, v6, [Ljava/lang/Object;

    invoke-static {v1, v2}, Lcom/orhanobut/logger/Logger;->e(Ljava/lang/String;[Ljava/lang/Object;)V

    .line 602
    iget-object v1, p0, Lcom/cyjh/elfin/AppContext;->script4Run:Lcom/cyjh/mobileanjian/ipc/stuff/Script4Run;

    invoke-virtual {v1, v0}, Lcom/cyjh/mobileanjian/ipc/stuff/Script4Run;->setDuration(I)Lcom/cyjh/mobileanjian/ipc/stuff/Script4Run;

    .line 607
    .end local v0    # "randomRunTime":I
    :cond_0
    iget-object v1, p0, Lcom/cyjh/elfin/AppContext;->mqRunner:Lcom/cyjh/mobileanjian/ipc/MqRunner;

    iget-object v2, p0, Lcom/cyjh/elfin/AppContext;->script4Run:Lcom/cyjh/mobileanjian/ipc/stuff/Script4Run;

    invoke-virtual {v1, v2}, Lcom/cyjh/mobileanjian/ipc/MqRunner;->setScript(Lcom/cyjh/mobileanjian/ipc/stuff/Script4Run;)Lcom/cyjh/mobileanjian/ipc/MqRunner;

    move-result-object v1

    .line 608
    invoke-virtual {v1, p0}, Lcom/cyjh/mobileanjian/ipc/MqRunner;->setOnScriptListener(Lcom/cyjh/mobileanjian/ipc/interfaces/OnScriptListener;)Lcom/cyjh/mobileanjian/ipc/MqRunner;

    move-result-object v1

    .line 609
    invoke-virtual {v1}, Lcom/cyjh/mobileanjian/ipc/MqRunner;->start()V

    .line 613
    :goto_0
    return-void

    .line 611
    :cond_1
    iget-object v1, p0, Lcom/cyjh/elfin/AppContext;->mqRunner:Lcom/cyjh/mobileanjian/ipc/MqRunner;

    invoke-virtual {v1}, Lcom/cyjh/mobileanjian/ipc/MqRunner;->stop()V

    goto :goto_0
.end method

.method private startVibrator()V
    .locals 4

    .prologue
    .line 325
    const-string v1, "vibrator"

    invoke-virtual {p0, v1}, Lcom/cyjh/elfin/AppContext;->getSystemService(Ljava/lang/String;)Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Landroid/os/Vibrator;

    .line 326
    .local v0, "vibrator":Landroid/os/Vibrator;
    iget-object v1, p0, Lcom/cyjh/elfin/AppContext;->sharedPreferences:Landroid/content/SharedPreferences;

    const-string v2, "com.cyjh.elfin.activity.SettingActivity.swtVibration"

    const/4 v3, 0x1

    invoke-interface {v1, v2, v3}, Landroid/content/SharedPreferences;->getBoolean(Ljava/lang/String;Z)Z

    move-result v1

    if-eqz v1, :cond_0

    .line 327
    const-wide/16 v2, 0x3e8

    invoke-virtual {v0, v2, v3}, Landroid/os/Vibrator;->vibrate(J)V

    .line 329
    :cond_0
    return-void
.end method

.method private statistics()V
    .locals 2

    .prologue
    .line 389
    new-instance v0, Ljava/lang/Thread;

    new-instance v1, Lcom/cyjh/elfin/AppContext$2;

    invoke-direct {v1, p0}, Lcom/cyjh/elfin/AppContext$2;-><init>(Lcom/cyjh/elfin/AppContext;)V

    invoke-direct {v0, v1}, Ljava/lang/Thread;-><init>(Ljava/lang/Runnable;)V

    .line 419
    invoke-virtual {v0}, Ljava/lang/Thread;->start()V

    .line 421
    return-void
.end method


# virtual methods
.method public backApp()V
    .locals 6

    .prologue
    .line 478
    const-string v4, "activity"

    invoke-virtual {p0, v4}, Lcom/cyjh/elfin/AppContext;->getSystemService(Ljava/lang/String;)Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Landroid/app/ActivityManager;

    .line 479
    .local v0, "am":Landroid/app/ActivityManager;
    const/4 v4, 0x1

    invoke-virtual {v0, v4}, Landroid/app/ActivityManager;->getRunningTasks(I)Ljava/util/List;

    move-result-object v4

    const/4 v5, 0x0

    invoke-interface {v4, v5}, Ljava/util/List;->get(I)Ljava/lang/Object;

    move-result-object v4

    check-cast v4, Landroid/app/ActivityManager$RunningTaskInfo;

    iget-object v1, v4, Landroid/app/ActivityManager$RunningTaskInfo;->topActivity:Landroid/content/ComponentName;

    .line 480
    .local v1, "cn":Landroid/content/ComponentName;
    invoke-virtual {v1}, Landroid/content/ComponentName;->getPackageName()Ljava/lang/String;

    move-result-object v3

    .line 482
    .local v3, "packageName":Ljava/lang/String;
    invoke-virtual {p0}, Lcom/cyjh/elfin/AppContext;->getPackageName()Ljava/lang/String;

    move-result-object v4

    invoke-virtual {v4, v3}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v4

    if-nez v4, :cond_0

    .line 483
    new-instance v2, Landroid/content/Intent;

    invoke-virtual {p0}, Lcom/cyjh/elfin/AppContext;->getApplicationContext()Landroid/content/Context;

    move-result-object v4

    const-class v5, Lcom/cyjh/elfin/activity/ElfinFreeActivity;

    invoke-direct {v2, v4, v5}, Landroid/content/Intent;-><init>(Landroid/content/Context;Ljava/lang/Class;)V

    .line 484
    .local v2, "intent":Landroid/content/Intent;
    const/high16 v4, 0x10000000

    invoke-virtual {v2, v4}, Landroid/content/Intent;->addFlags(I)Landroid/content/Intent;

    .line 485
    const-string v4, "android.intent.action.MAIN"

    invoke-virtual {v2, v4}, Landroid/content/Intent;->setAction(Ljava/lang/String;)Landroid/content/Intent;

    .line 486
    const-string v4, "android.intent.category.LAUNCHER"

    invoke-virtual {v2, v4}, Landroid/content/Intent;->addCategory(Ljava/lang/String;)Landroid/content/Intent;

    .line 487
    invoke-virtual {p0, v2}, Lcom/cyjh/elfin/AppContext;->startActivity(Landroid/content/Intent;)V

    .line 489
    .end local v2    # "intent":Landroid/content/Intent;
    :cond_0
    iget-object v4, p0, Lcom/cyjh/elfin/AppContext;->mElfinFloatView:Lcom/cyjh/elfin/floatview/ElfinFloatView;

    const/16 v5, 0x8

    invoke-virtual {v4, v5}, Lcom/cyjh/elfin/floatview/ElfinFloatView;->setVisibility(I)V

    .line 490
    return-void
.end method

.method public getInteger(I)I
    .locals 1
    .param p1, "resId"    # I

    .prologue
    .line 290
    invoke-virtual {p0}, Lcom/cyjh/elfin/AppContext;->getResources()Landroid/content/res/Resources;

    move-result-object v0

    invoke-virtual {v0, p1}, Landroid/content/res/Resources;->getInteger(I)I

    move-result v0

    return v0
.end method

.method public getMobileIMIE()Ljava/lang/String;
    .locals 1

    .prologue
    .line 179
    iget-object v0, p0, Lcom/cyjh/elfin/AppContext;->mobileIMIE:Ljava/lang/String;

    return-object v0
.end method

.method public initMeasure()V
    .locals 2

    .prologue
    .line 232
    const-string v1, "window"

    invoke-virtual {p0, v1}, Lcom/cyjh/elfin/AppContext;->getSystemService(Ljava/lang/String;)Ljava/lang/Object;

    move-result-object v1

    check-cast v1, Landroid/view/WindowManager;

    iput-object v1, p0, Lcom/cyjh/elfin/AppContext;->windowManager:Landroid/view/WindowManager;

    .line 233
    new-instance v0, Landroid/util/DisplayMetrics;

    invoke-direct {v0}, Landroid/util/DisplayMetrics;-><init>()V

    .line 234
    .local v0, "dm":Landroid/util/DisplayMetrics;
    iget-object v1, p0, Lcom/cyjh/elfin/AppContext;->windowManager:Landroid/view/WindowManager;

    invoke-interface {v1}, Landroid/view/WindowManager;->getDefaultDisplay()Landroid/view/Display;

    move-result-object v1

    invoke-virtual {v1, v0}, Landroid/view/Display;->getMetrics(Landroid/util/DisplayMetrics;)V

    .line 235
    iget-object v1, p0, Lcom/cyjh/elfin/AppContext;->windowManager:Landroid/view/WindowManager;

    invoke-interface {v1}, Landroid/view/WindowManager;->getDefaultDisplay()Landroid/view/Display;

    move-result-object v1

    iput-object v1, p0, Lcom/cyjh/elfin/AppContext;->display:Landroid/view/Display;

    .line 236
    return-void
.end method

.method public initParams()V
    .locals 2

    .prologue
    .line 755
    new-instance v0, Lcom/kaopu/download/kernel/DownloadServiceConnection;

    invoke-direct {v0, p0}, Lcom/kaopu/download/kernel/DownloadServiceConnection;-><init>(Landroid/content/Context;)V

    iput-object v0, p0, Lcom/cyjh/elfin/AppContext;->connection:Lcom/kaopu/download/kernel/DownloadServiceConnection;

    .line 756
    iget-object v0, p0, Lcom/cyjh/elfin/AppContext;->connection:Lcom/kaopu/download/kernel/DownloadServiceConnection;

    const/4 v1, 0x0

    invoke-virtual {v0, v1}, Lcom/kaopu/download/kernel/DownloadServiceConnection;->bindDownloadService(Lcom/kaopu/download/kernel/ConnectionCallBack;)V

    .line 757
    return-void
.end method

.method public onConfigurationChanged(Landroid/content/res/Configuration;)V
    .locals 3
    .param p1, "newConfig"    # Landroid/content/res/Configuration;

    .prologue
    const/4 v2, 0x1

    .line 363
    invoke-super {p0, p1}, Landroid/app/Application;->onConfigurationChanged(Landroid/content/res/Configuration;)V

    .line 365
    iget-object v0, p0, Lcom/cyjh/elfin/AppContext;->mElfinFloatView:Lcom/cyjh/elfin/floatview/ElfinFloatView;

    if-eqz v0, :cond_0

    .line 366
    iget-object v0, p0, Lcom/cyjh/elfin/AppContext;->mElfinFloatView:Lcom/cyjh/elfin/floatview/ElfinFloatView;

    invoke-virtual {v0}, Lcom/cyjh/elfin/floatview/ElfinFloatView;->rotateScreen()V

    .line 369
    :cond_0
    iget v0, p1, Landroid/content/res/Configuration;->orientation:I

    const/4 v1, 0x2

    if-ne v0, v1, :cond_2

    .line 370
    iput-boolean v2, p0, Lcom/cyjh/elfin/AppContext;->checkedScreenOrientation:Z

    .line 371
    iget-object v0, p0, Lcom/cyjh/elfin/AppContext;->mScreenConversion:Lcom/cyjh/elfin/AppContext$ScreenOrientationConversion;

    if-eqz v0, :cond_1

    .line 372
    iget-object v0, p0, Lcom/cyjh/elfin/AppContext;->mScreenConversion:Lcom/cyjh/elfin/AppContext$ScreenOrientationConversion;

    invoke-interface {v0}, Lcom/cyjh/elfin/AppContext$ScreenOrientationConversion;->onLandscapeOrientation()V

    .line 380
    :cond_1
    :goto_0
    return-void

    .line 374
    :cond_2
    iget v0, p1, Landroid/content/res/Configuration;->orientation:I

    if-ne v0, v2, :cond_1

    .line 375
    const/4 v0, 0x0

    iput-boolean v0, p0, Lcom/cyjh/elfin/AppContext;->checkedScreenOrientation:Z

    .line 376
    iget-object v0, p0, Lcom/cyjh/elfin/AppContext;->mScreenConversion:Lcom/cyjh/elfin/AppContext$ScreenOrientationConversion;

    if-eqz v0, :cond_1

    .line 377
    iget-object v0, p0, Lcom/cyjh/elfin/AppContext;->mScreenConversion:Lcom/cyjh/elfin/AppContext$ScreenOrientationConversion;

    invoke-interface {v0}, Lcom/cyjh/elfin/AppContext$ScreenOrientationConversion;->onPortraitOrientation()V

    goto :goto_0
.end method

.method public onCreate()V
    .locals 5

    .prologue
    const/4 v4, 0x1

    .line 135
    invoke-super {p0}, Landroid/app/Application;->onCreate()V

    .line 136
    invoke-direct {p0}, Lcom/cyjh/elfin/AppContext;->initUmeng()V

    .line 137
    invoke-static {}, Lcom/cyjh/elfin/log/AppCrashHandler;->getInstance()Lcom/cyjh/elfin/log/AppCrashHandler;

    move-result-object v0

    invoke-virtual {v0, p0}, Lcom/cyjh/elfin/log/AppCrashHandler;->init(Lcom/cyjh/elfin/AppContext;)V

    .line 138
    sput-object p0, Lcom/cyjh/elfin/AppContext;->mAppContext:Lcom/cyjh/elfin/AppContext;

    .line 139
    const-string v0, "mqm"

    invoke-static {v0}, Ljava/lang/System;->loadLibrary(Ljava/lang/String;)V

    .line 141
    const v0, 0x7f0800bf

    invoke-virtual {p0, v0}, Lcom/cyjh/elfin/AppContext;->getString(I)Ljava/lang/String;

    move-result-object v0

    const v1, 0x7f0800c9

    invoke-virtual {p0, v1}, Lcom/cyjh/elfin/AppContext;->getString(I)Ljava/lang/String;

    move-result-object v1

    invoke-static {p0, v4, v0, v1, p0}, Lcom/cyjh/mobileanjian/ipc/MqBridge;->init(Landroid/app/Application;ZLjava/lang/String;Ljava/lang/String;Lcom/cyjh/mobileanjian/ipc/interfaces/OnKeyEventListener;)V

    .line 142
    const-string v0, ""

    const/4 v1, 0x0

    const/16 v2, 0xa

    const/4 v3, 0x0

    invoke-static {p0, v0, v1, v2, v3}, Lcom/goldcoast/sdk/domain/EntryPoint;->init(Landroid/app/Application;Ljava/lang/String;Lcom/goldcoast/sdk/domain/AnalyseResult;IB)V

    .line 144
    sget-boolean v0, Lcom/cyjh/elfin/AppContext;->booted:Z

    if-nez v0, :cond_0

    .line 145
    sput-boolean v4, Lcom/cyjh/elfin/AppContext;->booted:Z

    .line 146
    new-instance v0, Lcom/cyjh/mobileanjian/ipc/log/AppStartLog;

    invoke-direct {v0, p0}, Lcom/cyjh/mobileanjian/ipc/log/AppStartLog;-><init>(Landroid/content/Context;)V

    invoke-virtual {v0}, Lcom/cyjh/mobileanjian/ipc/log/AppStartLog;->commit()V

    .line 148
    :cond_0
    invoke-static {}, Lcom/cyjh/mobileanjian/ipc/MqRunner;->getInstance()Lcom/cyjh/mobileanjian/ipc/MqRunner;

    move-result-object v0

    iput-object v0, p0, Lcom/cyjh/elfin/AppContext;->mqRunner:Lcom/cyjh/mobileanjian/ipc/MqRunner;

    .line 149
    invoke-direct {p0}, Lcom/cyjh/elfin/AppContext;->initObject()V

    .line 150
    invoke-direct {p0}, Lcom/cyjh/elfin/AppContext;->initPath()V

    .line 151
    invoke-virtual {p0}, Lcom/cyjh/elfin/AppContext;->initMeasure()V

    .line 152
    invoke-direct {p0}, Lcom/cyjh/elfin/AppContext;->initMQScript()V

    .line 153
    invoke-direct {p0}, Lcom/cyjh/elfin/AppContext;->initShake()V

    .line 154
    invoke-direct {p0}, Lcom/cyjh/elfin/AppContext;->initlService()V

    .line 155
    invoke-direct {p0}, Lcom/cyjh/elfin/AppContext;->intMobileIMIE()V

    .line 156
    invoke-direct {p0}, Lcom/cyjh/elfin/AppContext;->initScript4Run()V

    .line 159
    return-void
.end method

.method public onKeyEvent(I)V
    .locals 3
    .param p1, "keyCode"    # I

    .prologue
    .line 550
    iget-object v0, p0, Lcom/cyjh/elfin/AppContext;->sharedPreferences:Landroid/content/SharedPreferences;

    const-string v1, "com.cyjh.elfin.activity.SettingActivity.swtVolumeKeyCtrl"

    const/4 v2, 0x1

    invoke-interface {v0, v1, v2}, Landroid/content/SharedPreferences;->getBoolean(Ljava/lang/String;Z)Z

    move-result v0

    if-eqz v0, :cond_0

    .line 551
    const/16 v0, 0x72

    if-ne p1, v0, :cond_0

    .line 552
    invoke-static {p0}, Lcom/cyjh/elfin/util/NetworkUtils;->isAvailable(Landroid/content/Context;)Z

    move-result v0

    if-nez v0, :cond_1

    .line 553
    invoke-static {}, Lcom/cyjh/elfin/AppContext;->getInstance()Lcom/cyjh/elfin/AppContext;

    move-result-object v0

    const v1, 0x7f0800a4

    invoke-static {v0, v1}, Lcom/cyjh/elfin/util/ToastUtils;->showToastShort(Landroid/content/Context;I)V

    .line 586
    :cond_0
    :goto_0
    return-void

    .line 556
    :cond_1
    iget-object v0, p0, Lcom/cyjh/elfin/AppContext;->mqRunner:Lcom/cyjh/mobileanjian/ipc/MqRunner;

    invoke-virtual {v0}, Lcom/cyjh/mobileanjian/ipc/MqRunner;->isScriptStarted()Z

    move-result v0

    if-eqz v0, :cond_2

    .line 557
    iget-object v0, p0, Lcom/cyjh/elfin/AppContext;->mqRunner:Lcom/cyjh/mobileanjian/ipc/MqRunner;

    invoke-virtual {v0}, Lcom/cyjh/mobileanjian/ipc/MqRunner;->stop()V

    goto :goto_0

    .line 561
    :cond_2
    invoke-direct {p0}, Lcom/cyjh/elfin/AppContext;->startAppViaVolume()V

    .line 583
    new-instance v0, Ljava/lang/StringBuilder;

    invoke-direct {v0}, Ljava/lang/StringBuilder;-><init>()V

    const-string v1, "\u9a8c\u8bc1\u662f\u5426\u901a\u8fc7"

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    iget v1, p0, Lcom/cyjh/elfin/AppContext;->isVerifyPass:I

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-virtual {v0}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v0

    const/4 v1, 0x0

    new-array v1, v1, [Ljava/lang/Object;

    invoke-static {v0, v1}, Lcom/orhanobut/logger/Logger;->e(Ljava/lang/String;[Ljava/lang/Object;)V

    goto :goto_0
.end method

.method public onKillProcess()V
    .locals 5

    .prologue
    const/4 v4, 0x0

    .line 736
    invoke-static {p0}, Lcom/umeng/analytics/MobclickAgent;->onKillProcess(Landroid/content/Context;)V

    .line 738
    iget-object v2, p0, Lcom/cyjh/elfin/AppContext;->connection:Lcom/kaopu/download/kernel/DownloadServiceConnection;

    if-eqz v2, :cond_0

    .line 740
    iget-object v2, p0, Lcom/cyjh/elfin/AppContext;->connection:Lcom/kaopu/download/kernel/DownloadServiceConnection;

    invoke-virtual {v2}, Lcom/kaopu/download/kernel/DownloadServiceConnection;->getDownloadInfos()Ljava/util/Map;

    move-result-object v0

    .line 741
    .local v0, "downloadInfoMap":Ljava/util/Map;, "Ljava/util/Map<Ljava/lang/String;Lcom/kaopu/download/kernel/BaseDownloadInfo;>;"
    if-eqz v0, :cond_0

    .line 742
    invoke-interface {v0}, Ljava/util/Map;->entrySet()Ljava/util/Set;

    move-result-object v2

    invoke-interface {v2}, Ljava/util/Set;->iterator()Ljava/util/Iterator;

    move-result-object v3

    :goto_0
    invoke-interface {v3}, Ljava/util/Iterator;->hasNext()Z

    move-result v2

    if-eqz v2, :cond_0

    invoke-interface {v3}, Ljava/util/Iterator;->next()Ljava/lang/Object;

    move-result-object v1

    check-cast v1, Ljava/util/Map$Entry;

    .line 744
    .local v1, "entry":Ljava/util/Map$Entry;, "Ljava/util/Map$Entry<Ljava/lang/String;Lcom/kaopu/download/kernel/BaseDownloadInfo;>;"
    invoke-interface {v1}, Ljava/util/Map$Entry;->getValue()Ljava/lang/Object;

    move-result-object v2

    check-cast v2, Lcom/kaopu/download/kernel/BaseDownloadInfo;

    invoke-static {p0, v2}, Lcom/kaopu/download/BaseDownloadOperate;->cancelDownloadTask(Landroid/content/Context;Lcom/kaopu/download/kernel/BaseDownloadInfo;)V

    goto :goto_0

    .line 748
    .end local v0    # "downloadInfoMap":Ljava/util/Map;, "Ljava/util/Map<Ljava/lang/String;Lcom/kaopu/download/kernel/BaseDownloadInfo;>;"
    .end local v1    # "entry":Ljava/util/Map$Entry;, "Ljava/util/Map$Entry<Ljava/lang/String;Lcom/kaopu/download/kernel/BaseDownloadInfo;>;"
    :cond_0
    iget-object v2, p0, Lcom/cyjh/elfin/AppContext;->mHandler:Landroid/os/Handler;

    invoke-virtual {v2, v4}, Landroid/os/Handler;->removeCallbacksAndMessages(Ljava/lang/Object;)V

    .line 749
    iput-object v4, p0, Lcom/cyjh/elfin/AppContext;->mBlackListRunnable:Lcom/cyjh/elfin/AppContext$BlackListCountTimeRunnable;

    .line 750
    return-void
.end method

.method public onPause()V
    .locals 0

    .prologue
    .line 515
    return-void
.end method

.method public onResume()V
    .locals 0

    .prologue
    .line 520
    return-void
.end method

.method public onScriptIsRunning()V
    .locals 0

    .prologue
    .line 524
    return-void
.end method

.method public onStartScript()V
    .locals 3

    .prologue
    .line 494
    invoke-static {}, Landroid/os/SystemClock;->uptimeMillis()J

    move-result-wide v0

    iput-wide v0, p0, Lcom/cyjh/elfin/AppContext;->mScriptStartTime:J

    .line 495
    const/4 v0, 0x2

    iput v0, p0, Lcom/cyjh/elfin/AppContext;->STATE_SCRIPT:I

    .line 496
    invoke-direct {p0}, Lcom/cyjh/elfin/AppContext;->startVibrator()V

    .line 497
    iget-object v0, p0, Lcom/cyjh/elfin/AppContext;->mElfinFloatView:Lcom/cyjh/elfin/floatview/ElfinFloatView;

    if-eqz v0, :cond_0

    .line 498
    iget-object v0, p0, Lcom/cyjh/elfin/AppContext;->mElfinFloatView:Lcom/cyjh/elfin/floatview/ElfinFloatView;

    iget-object v0, v0, Lcom/cyjh/elfin/floatview/ElfinFloatView;->mImgRunAndStop:Landroid/widget/ImageView;

    const v1, 0x7f02008c

    invoke-virtual {v0, v1}, Landroid/widget/ImageView;->setImageResource(I)V

    .line 499
    iget-object v0, p0, Lcom/cyjh/elfin/AppContext;->mElfinFloatView:Lcom/cyjh/elfin/floatview/ElfinFloatView;

    iget-object v0, v0, Lcom/cyjh/elfin/floatview/ElfinFloatView;->mTvRunScript:Landroid/widget/TextView;

    const v1, 0x7f080077

    invoke-virtual {p0, v1}, Lcom/cyjh/elfin/AppContext;->getString(I)Ljava/lang/String;

    move-result-object v1

    invoke-virtual {v0, v1}, Landroid/widget/TextView;->setText(Ljava/lang/CharSequence;)V

    .line 500
    iget-object v0, p0, Lcom/cyjh/elfin/AppContext;->mElfinFloatView:Lcom/cyjh/elfin/floatview/ElfinFloatView;

    invoke-virtual {v0}, Lcom/cyjh/elfin/floatview/ElfinFloatView;->upadateElfinImages()V

    .line 503
    :cond_0
    iget v0, p0, Lcom/cyjh/elfin/AppContext;->runTime:I

    if-eqz v0, :cond_2

    .line 504
    iget-object v0, p0, Lcom/cyjh/elfin/AppContext;->mBlackListRunnable:Lcom/cyjh/elfin/AppContext$BlackListCountTimeRunnable;

    if-nez v0, :cond_1

    .line 505
    new-instance v0, Lcom/cyjh/elfin/AppContext$BlackListCountTimeRunnable;

    invoke-direct {v0, p0}, Lcom/cyjh/elfin/AppContext$BlackListCountTimeRunnable;-><init>(Lcom/cyjh/elfin/AppContext;)V

    iput-object v0, p0, Lcom/cyjh/elfin/AppContext;->mBlackListRunnable:Lcom/cyjh/elfin/AppContext$BlackListCountTimeRunnable;

    .line 507
    :cond_1
    iget-object v0, p0, Lcom/cyjh/elfin/AppContext;->mBlackListRunnable:Lcom/cyjh/elfin/AppContext$BlackListCountTimeRunnable;

    invoke-virtual {v0}, Lcom/cyjh/elfin/AppContext$BlackListCountTimeRunnable;->onStart()V

    .line 508
    iget-object v0, p0, Lcom/cyjh/elfin/AppContext;->commonLog:Lcom/cyjh/elfin/log/CommonLog;

    new-instance v1, Ljava/lang/StringBuilder;

    invoke-direct {v1}, Ljava/lang/StringBuilder;-><init>()V

    const-string v2, "AppContext onStartScript runTime "

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    iget v2, p0, Lcom/cyjh/elfin/AppContext;->runTime:I

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v1

    const-string v2, ",totalTime="

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    iget v2, p0, Lcom/cyjh/elfin/AppContext;->totalCount:I

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v1

    invoke-virtual {v0, v1}, Lcom/cyjh/elfin/log/CommonLog;->e(Ljava/lang/Object;)V

    .line 510
    :cond_2
    return-void
.end method

.method public onStopScript(ILjava/lang/String;)V
    .locals 4
    .param p1, "returnCode"    # I
    .param p2, "msg"    # Ljava/lang/String;

    .prologue
    .line 528
    new-instance v0, Lcom/cyjh/mobileanjian/ipc/log/ScriptRunDurationLog;

    invoke-direct {v0, p0}, Lcom/cyjh/mobileanjian/ipc/log/ScriptRunDurationLog;-><init>(Landroid/content/Context;)V

    .line 529
    .local v0, "cloudLog":Lcom/cyjh/mobileanjian/ipc/log/ScriptRunDurationLog;
    iget-wide v2, p0, Lcom/cyjh/elfin/AppContext;->mScriptStartTime:J

    invoke-virtual {v0, v2, v3}, Lcom/cyjh/mobileanjian/ipc/log/ScriptRunDurationLog;->setScriptStartTime(J)Lcom/cyjh/mobileanjian/ipc/log/ScriptRunDurationLog;

    move-result-object v1

    invoke-virtual {v1}, Lcom/cyjh/mobileanjian/ipc/log/ScriptRunDurationLog;->commit()V

    .line 530
    const/4 v1, 0x1

    iput v1, p0, Lcom/cyjh/elfin/AppContext;->STATE_SCRIPT:I

    .line 531
    invoke-direct {p0}, Lcom/cyjh/elfin/AppContext;->startVibrator()V

    .line 532
    iget-object v1, p0, Lcom/cyjh/elfin/AppContext;->mElfinFloatView:Lcom/cyjh/elfin/floatview/ElfinFloatView;

    if-eqz v1, :cond_0

    .line 533
    iget-object v1, p0, Lcom/cyjh/elfin/AppContext;->mElfinFloatView:Lcom/cyjh/elfin/floatview/ElfinFloatView;

    invoke-virtual {v1}, Lcom/cyjh/elfin/floatview/ElfinFloatView;->upadateElfinImages()V

    .line 534
    iget-object v1, p0, Lcom/cyjh/elfin/AppContext;->mElfinFloatView:Lcom/cyjh/elfin/floatview/ElfinFloatView;

    iget-object v1, v1, Lcom/cyjh/elfin/floatview/ElfinFloatView;->mImgRunAndStop:Landroid/widget/ImageView;

    const v2, 0x7f02008a

    invoke-virtual {v1, v2}, Landroid/widget/ImageView;->setImageResource(I)V

    .line 535
    iget-object v1, p0, Lcom/cyjh/elfin/AppContext;->mElfinFloatView:Lcom/cyjh/elfin/floatview/ElfinFloatView;

    iget-object v1, v1, Lcom/cyjh/elfin/floatview/ElfinFloatView;->mTvRunScript:Landroid/widget/TextView;

    const v2, 0x7f080075

    invoke-virtual {p0, v2}, Lcom/cyjh/elfin/AppContext;->getString(I)Ljava/lang/String;

    move-result-object v2

    invoke-virtual {v1, v2}, Landroid/widget/TextView;->setText(Ljava/lang/CharSequence;)V

    .line 536
    iget-object v1, p0, Lcom/cyjh/elfin/AppContext;->mElfinFloatView:Lcom/cyjh/elfin/floatview/ElfinFloatView;

    invoke-virtual {v1}, Lcom/cyjh/elfin/floatview/ElfinFloatView;->setImageViewElfinTouchListener()V

    .line 542
    :cond_0
    const/16 v1, 0x3eb

    if-ne p1, v1, :cond_1

    .line 543
    const v1, 0x7f080109

    invoke-virtual {p0, v1}, Lcom/cyjh/elfin/AppContext;->showToast(I)V

    .line 545
    :cond_1
    return-void
.end method

.method public onUpdateControlBarPos(FI)V
    .locals 1
    .param p1, "radio"    # F
    .param p2, "lock"    # I

    .prologue
    .line 617
    iget-object v0, p0, Lcom/cyjh/elfin/AppContext;->mElfinFloatView:Lcom/cyjh/elfin/floatview/ElfinFloatView;

    if-eqz v0, :cond_0

    .line 618
    iget-object v0, p0, Lcom/cyjh/elfin/AppContext;->mElfinFloatView:Lcom/cyjh/elfin/floatview/ElfinFloatView;

    invoke-virtual {v0}, Lcom/cyjh/elfin/floatview/ElfinFloatView;->upadateElfinImages()V

    .line 619
    iget-object v0, p0, Lcom/cyjh/elfin/AppContext;->mElfinFloatView:Lcom/cyjh/elfin/floatview/ElfinFloatView;

    invoke-virtual {v0, p1, p2}, Lcom/cyjh/elfin/floatview/ElfinFloatView;->posContorlbar(FI)V

    .line 621
    :cond_0
    return-void
.end method

.method public removeBigFloat()V
    .locals 1

    .prologue
    .line 852
    iget-object v0, p0, Lcom/cyjh/elfin/AppContext;->fwManagerFloat:Lcom/cyjh/elfin/floatview/XunFeiFloatManager;

    invoke-virtual {v0}, Lcom/cyjh/elfin/floatview/XunFeiFloatManager;->removeBigFloat()V

    .line 853
    return-void
.end method

.method public runScript()V
    .locals 7

    .prologue
    const/4 v6, 0x0

    .line 453
    iget-object v1, p0, Lcom/cyjh/elfin/AppContext;->commonLog:Lcom/cyjh/elfin/log/CommonLog;

    const-string v2, "\u8fd0\u884c\u811a\u672crunScript"

    invoke-virtual {v1, v2}, Lcom/cyjh/elfin/log/CommonLog;->e(Ljava/lang/Object;)V

    .line 454
    iget-object v1, p0, Lcom/cyjh/elfin/AppContext;->mElfinFloatView:Lcom/cyjh/elfin/floatview/ElfinFloatView;

    invoke-virtual {v1, v6}, Lcom/cyjh/elfin/floatview/ElfinFloatView;->changeToolBarState(Z)V

    .line 457
    new-instance v1, Ljava/lang/StringBuilder;

    invoke-direct {v1}, Ljava/lang/StringBuilder;-><init>()V

    const-string v2, "runScript \u8bbe\u7f6e\u65f6\u95f4\u4e3a\uff1a"

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    iget v2, p0, Lcom/cyjh/elfin/AppContext;->runTime:I

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v1

    new-array v2, v6, [Ljava/lang/Object;

    invoke-static {v1, v2}, Lcom/orhanobut/logger/Logger;->e(Ljava/lang/String;[Ljava/lang/Object;)V

    .line 458
    iget v1, p0, Lcom/cyjh/elfin/AppContext;->runTime:I

    if-lez v1, :cond_0

    .line 459
    invoke-static {}, Ljava/lang/Math;->random()D

    move-result-wide v2

    const-wide/high16 v4, 0x404e000000000000L    # 60.0

    mul-double/2addr v2, v4

    const-wide/high16 v4, 0x403e000000000000L    # 30.0

    add-double/2addr v2, v4

    double-to-int v0, v2

    .line 461
    .local v0, "randomRunTime":I
    invoke-direct {p0, v0}, Lcom/cyjh/elfin/AppContext;->randomTimeConvertTotal(I)V

    .line 462
    new-instance v1, Ljava/lang/StringBuilder;

    invoke-direct {v1}, Ljava/lang/StringBuilder;-><init>()V

    const-string v2, "\u8bbe\u7f6e\u65f6\u95f4\u4e3a\uff1arandomRunTime  = "

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1, v0}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v1

    new-array v2, v6, [Ljava/lang/Object;

    invoke-static {v1, v2}, Lcom/orhanobut/logger/Logger;->e(Ljava/lang/String;[Ljava/lang/Object;)V

    .line 463
    iget-object v1, p0, Lcom/cyjh/elfin/AppContext;->script4Run:Lcom/cyjh/mobileanjian/ipc/stuff/Script4Run;

    invoke-virtual {v1, v0}, Lcom/cyjh/mobileanjian/ipc/stuff/Script4Run;->setDuration(I)Lcom/cyjh/mobileanjian/ipc/stuff/Script4Run;

    .line 465
    .end local v0    # "randomRunTime":I
    :cond_0
    iget-object v1, p0, Lcom/cyjh/elfin/AppContext;->mqRunner:Lcom/cyjh/mobileanjian/ipc/MqRunner;

    iget-object v2, p0, Lcom/cyjh/elfin/AppContext;->script4Run:Lcom/cyjh/mobileanjian/ipc/stuff/Script4Run;

    invoke-virtual {v1, v2}, Lcom/cyjh/mobileanjian/ipc/MqRunner;->setScript(Lcom/cyjh/mobileanjian/ipc/stuff/Script4Run;)Lcom/cyjh/mobileanjian/ipc/MqRunner;

    move-result-object v1

    .line 466
    invoke-virtual {v1, p0}, Lcom/cyjh/mobileanjian/ipc/MqRunner;->setOnScriptListener(Lcom/cyjh/mobileanjian/ipc/interfaces/OnScriptListener;)Lcom/cyjh/mobileanjian/ipc/MqRunner;

    move-result-object v1

    .line 467
    invoke-virtual {v1}, Lcom/cyjh/mobileanjian/ipc/MqRunner;->start()V

    .line 468
    return-void
.end method

.method public setScreenConversion(Lcom/cyjh/elfin/AppContext$ScreenOrientationConversion;)V
    .locals 0
    .param p1, "screenConvert"    # Lcom/cyjh/elfin/AppContext$ScreenOrientationConversion;

    .prologue
    .line 728
    iput-object p1, p0, Lcom/cyjh/elfin/AppContext;->mScreenConversion:Lcom/cyjh/elfin/AppContext$ScreenOrientationConversion;

    .line 729
    return-void
.end method

.method public showBigFloat()V
    .locals 1

    .prologue
    .line 842
    iget-object v0, p0, Lcom/cyjh/elfin/AppContext;->fwManagerFloat:Lcom/cyjh/elfin/floatview/XunFeiFloatManager;

    if-nez v0, :cond_0

    .line 843
    invoke-static {p0}, Lcom/cyjh/elfin/floatview/XunFeiFloatManager;->getInstance(Landroid/content/Context;)Lcom/cyjh/elfin/floatview/XunFeiFloatManager;

    move-result-object v0

    iput-object v0, p0, Lcom/cyjh/elfin/AppContext;->fwManagerFloat:Lcom/cyjh/elfin/floatview/XunFeiFloatManager;

    .line 845
    :cond_0
    iget-object v0, p0, Lcom/cyjh/elfin/AppContext;->fwManagerFloat:Lcom/cyjh/elfin/floatview/XunFeiFloatManager;

    iget-boolean v0, v0, Lcom/cyjh/elfin/floatview/XunFeiFloatManager;->isAddBig:Z

    if-nez v0, :cond_1

    .line 846
    iget-object v0, p0, Lcom/cyjh/elfin/AppContext;->fwManagerFloat:Lcom/cyjh/elfin/floatview/XunFeiFloatManager;

    invoke-virtual {v0}, Lcom/cyjh/elfin/floatview/XunFeiFloatManager;->addBigFloat()V

    .line 848
    :cond_1
    return-void
.end method

.method public showFloatView()V
    .locals 3

    .prologue
    .line 345
    iget-object v0, p0, Lcom/cyjh/elfin/AppContext;->mElfinFloatView:Lcom/cyjh/elfin/floatview/ElfinFloatView;

    if-nez v0, :cond_0

    .line 346
    invoke-direct {p0}, Lcom/cyjh/elfin/AppContext;->createElfinFloatView()V

    .line 353
    :goto_0
    iget-object v0, p0, Lcom/cyjh/elfin/AppContext;->sharedPreferences:Landroid/content/SharedPreferences;

    const-string v1, "com.cyjh.elfin.activity.SettingActivity.swtFloatviewCtrl"

    const/4 v2, 0x1

    invoke-interface {v0, v1, v2}, Landroid/content/SharedPreferences;->getBoolean(Ljava/lang/String;Z)Z

    move-result v0

    if-eqz v0, :cond_1

    .line 354
    iget-object v0, p0, Lcom/cyjh/elfin/AppContext;->mElfinFloatView:Lcom/cyjh/elfin/floatview/ElfinFloatView;

    const/4 v1, 0x0

    invoke-virtual {v0, v1}, Lcom/cyjh/elfin/floatview/ElfinFloatView;->setVisibility(I)V

    .line 359
    :goto_1
    return-void

    .line 348
    :cond_0
    iget-object v0, p0, Lcom/cyjh/elfin/AppContext;->mElfinFloatView:Lcom/cyjh/elfin/floatview/ElfinFloatView;

    invoke-virtual {v0}, Lcom/cyjh/elfin/floatview/ElfinFloatView;->rotateScreen()V

    goto :goto_0

    .line 357
    :cond_1
    iget-object v0, p0, Lcom/cyjh/elfin/AppContext;->mElfinFloatView:Lcom/cyjh/elfin/floatview/ElfinFloatView;

    const/16 v1, 0x8

    invoke-virtual {v0, v1}, Lcom/cyjh/elfin/floatview/ElfinFloatView;->setVisibility(I)V

    goto :goto_1
.end method

.method public showToast(I)V
    .locals 1
    .param p1, "resId"    # I

    .prologue
    .line 442
    const/4 v0, 0x0

    invoke-static {p0, p1, v0}, Landroid/widget/Toast;->makeText(Landroid/content/Context;II)Landroid/widget/Toast;

    move-result-object v0

    invoke-virtual {v0}, Landroid/widget/Toast;->show()V

    .line 443
    return-void
.end method

.method public showToast(Ljava/lang/String;)V
    .locals 1
    .param p1, "text"    # Ljava/lang/String;

    .prologue
    .line 446
    const/4 v0, 0x0

    invoke-static {p0, p1, v0}, Landroid/widget/Toast;->makeText(Landroid/content/Context;Ljava/lang/CharSequence;I)Landroid/widget/Toast;

    move-result-object v0

    invoke-virtual {v0}, Landroid/widget/Toast;->show()V

    .line 447
    return-void
.end method

.method public showToastCenter(I)V
    .locals 3
    .param p1, "resId"    # I

    .prologue
    const/4 v2, 0x0

    .line 430
    invoke-static {p0, p1, v2}, Landroid/widget/Toast;->makeText(Landroid/content/Context;II)Landroid/widget/Toast;

    move-result-object v0

    .line 431
    .local v0, "toast":Landroid/widget/Toast;
    const/16 v1, 0x11

    invoke-virtual {v0, v1, v2, v2}, Landroid/widget/Toast;->setGravity(III)V

    .line 432
    invoke-virtual {v0}, Landroid/widget/Toast;->show()V

    .line 433
    return-void
.end method
