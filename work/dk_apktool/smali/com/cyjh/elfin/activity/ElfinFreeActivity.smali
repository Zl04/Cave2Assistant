.class public Lcom/cyjh/elfin/activity/ElfinFreeActivity;
.super Lcom/cyjh/elfin/activity/BaseActivity;
.source "ElfinFreeActivity.java"

# interfaces
.implements Landroid/view/View$OnClickListener;
.implements Lcom/cyjh/elfin/mvp/views/RecommendGamesView;
.implements Lcom/cyjh/elfin/mvp/views/PushMessageView;


# annotations
.annotation system Ldalvik/annotation/MemberClasses;
    value = {
        Lcom/cyjh/elfin/activity/ElfinFreeActivity$MainHandler;
    }
.end annotation


# static fields
.field private static final DEFAULT_VALUE_ONE:Ljava/lang/String; = "1"

.field private static final DEFAULT_VALUE_TWO:Ljava/lang/String; = "2"

.field public static final NOTIFY_MESSAGE_INIT_DB:I = 0x3ed

.field private static final NOTIFY_MESSAGE_PROMPT:I = 0x3ea

.field private static final NOTIFY_TYPE:I = 0x3e9

.field public static final PIC_BOUNDS_SIZE:I = 0x2


# instance fields
.field private appContext:Lcom/cyjh/elfin/AppContext;

.field private commonLog:Lcom/cyjh/elfin/log/CommonLog;

.field private doubleBackToExitPressedOnce:Z

.field private gameSwitchInfo:Lcom/cyjh/elfin/entity/GameSwitchInfo;

.field private isFirstPushMessage:Z

.field private mBuilder:Landroid/support/v4/app/NotificationCompat$Builder;

.field private mHandler:Lcom/cyjh/elfin/activity/ElfinFreeActivity$MainHandler;

.field private mImgRedDot:Landroid/widget/ImageView;

.field private mNotifyManager:Landroid/app/NotificationManager;

.field private mSharedPres:Landroid/content/SharedPreferences;

.field private mTvRecommendGames:Landroid/widget/TextView;

.field private msgDataList:Ljava/util/ArrayList;
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "Ljava/util/ArrayList",
            "<",
            "Lcom/cyjh/elfin/entity/NotifyMsgBean;",
            ">;"
        }
    .end annotation
.end field

.field private msgIdList:Ljava/util/List;
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "Ljava/util/List",
            "<",
            "Ljava/lang/String;",
            ">;"
        }
    .end annotation
.end field

.field private msgPartDataList:Ljava/util/ArrayList;
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "Ljava/util/ArrayList",
            "<",
            "Lcom/cyjh/elfin/entity/NotifyMsgBean;",
            ">;"
        }
    .end annotation
.end field

.field private optionFragment:Lcom/cyjh/elfin/fragment/OptionFragment;

.field private pushMessagePresenter:Lcom/cyjh/elfin/mvp/presenters/PushMessagePresenter;

.field private recommendGamesPresenter:Lcom/cyjh/elfin/mvp/presenters/RecommendGamesPresenter;


# direct methods
.method public constructor <init>()V
    .locals 3

    .prologue
    const/4 v2, 0x0

    .line 77
    invoke-direct {p0}, Lcom/cyjh/elfin/activity/BaseActivity;-><init>()V

    .line 80
    new-instance v0, Lcom/cyjh/elfin/log/CommonLog;

    invoke-direct {v0}, Lcom/cyjh/elfin/log/CommonLog;-><init>()V

    iput-object v0, p0, Lcom/cyjh/elfin/activity/ElfinFreeActivity;->commonLog:Lcom/cyjh/elfin/log/CommonLog;

    .line 97
    new-instance v0, Ljava/util/ArrayList;

    invoke-direct {v0}, Ljava/util/ArrayList;-><init>()V

    iput-object v0, p0, Lcom/cyjh/elfin/activity/ElfinFreeActivity;->msgDataList:Ljava/util/ArrayList;

    .line 98
    new-instance v0, Ljava/util/ArrayList;

    invoke-direct {v0}, Ljava/util/ArrayList;-><init>()V

    iput-object v0, p0, Lcom/cyjh/elfin/activity/ElfinFreeActivity;->msgPartDataList:Ljava/util/ArrayList;

    .line 99
    new-instance v0, Ljava/util/ArrayList;

    invoke-direct {v0}, Ljava/util/ArrayList;-><init>()V

    iput-object v0, p0, Lcom/cyjh/elfin/activity/ElfinFreeActivity;->msgIdList:Ljava/util/List;

    .line 113
    iput-boolean v2, p0, Lcom/cyjh/elfin/activity/ElfinFreeActivity;->isFirstPushMessage:Z

    .line 120
    new-instance v0, Lcom/cyjh/elfin/activity/ElfinFreeActivity$MainHandler;

    const/4 v1, 0x0

    invoke-direct {v0, p0, v1}, Lcom/cyjh/elfin/activity/ElfinFreeActivity$MainHandler;-><init>(Lcom/cyjh/elfin/activity/ElfinFreeActivity;Lcom/cyjh/elfin/activity/ElfinFreeActivity$1;)V

    iput-object v0, p0, Lcom/cyjh/elfin/activity/ElfinFreeActivity;->mHandler:Lcom/cyjh/elfin/activity/ElfinFreeActivity$MainHandler;

    .line 195
    iput-boolean v2, p0, Lcom/cyjh/elfin/activity/ElfinFreeActivity;->doubleBackToExitPressedOnce:Z

    return-void
.end method

.method static synthetic access$102(Lcom/cyjh/elfin/activity/ElfinFreeActivity;Z)Z
    .locals 0
    .param p0, "x0"    # Lcom/cyjh/elfin/activity/ElfinFreeActivity;
    .param p1, "x1"    # Z

    .prologue
    .line 77
    iput-boolean p1, p0, Lcom/cyjh/elfin/activity/ElfinFreeActivity;->doubleBackToExitPressedOnce:Z

    return p1
.end method

.method static synthetic access$200(Lcom/cyjh/elfin/activity/ElfinFreeActivity;)V
    .locals 0
    .param p0, "x0"    # Lcom/cyjh/elfin/activity/ElfinFreeActivity;

    .prologue
    .line 77
    invoke-direct {p0}, Lcom/cyjh/elfin/activity/ElfinFreeActivity;->pushDataProcess()V

    return-void
.end method

.method static synthetic access$300(Lcom/cyjh/elfin/activity/ElfinFreeActivity;Ljava/util/ArrayList;)V
    .locals 0
    .param p0, "x0"    # Lcom/cyjh/elfin/activity/ElfinFreeActivity;
    .param p1, "x1"    # Ljava/util/ArrayList;

    .prologue
    .line 77
    invoke-direct {p0, p1}, Lcom/cyjh/elfin/activity/ElfinFreeActivity;->processInitDbData(Ljava/util/ArrayList;)V

    return-void
.end method

.method private checkResolution()V
    .locals 7

    .prologue
    .line 235
    const v4, 0x7f0f007d

    invoke-virtual {p0, v4}, Lcom/cyjh/elfin/activity/ElfinFreeActivity;->findViewById(I)Landroid/view/View;

    move-result-object v3

    check-cast v3, Landroid/widget/TextView;

    .line 236
    .local v3, "tvResolutionUnSupport":Landroid/widget/TextView;
    new-instance v4, Ljava/lang/StringBuilder;

    invoke-direct {v4}, Ljava/lang/StringBuilder;-><init>()V

    invoke-static {p0}, Lcom/cyjh/elfin/util/AppDeviceUtils;->getResolution(Landroid/content/Context;)Landroid/graphics/Point;

    move-result-object v5

    iget v5, v5, Landroid/graphics/Point;->x:I

    invoke-virtual {v4, v5}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v4

    const-string v5, "*"

    invoke-virtual {v4, v5}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v4

    invoke-static {p0}, Lcom/cyjh/elfin/util/AppDeviceUtils;->getResolution(Landroid/content/Context;)Landroid/graphics/Point;

    move-result-object v5

    iget v5, v5, Landroid/graphics/Point;->y:I

    invoke-virtual {v4, v5}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v4

    invoke-virtual {v4}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v1

    .line 237
    .local v1, "resolution1":Ljava/lang/String;
    new-instance v4, Ljava/lang/StringBuilder;

    invoke-direct {v4}, Ljava/lang/StringBuilder;-><init>()V

    invoke-static {p0}, Lcom/cyjh/elfin/util/AppDeviceUtils;->getResolution(Landroid/content/Context;)Landroid/graphics/Point;

    move-result-object v5

    iget v5, v5, Landroid/graphics/Point;->y:I

    invoke-virtual {v4, v5}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v4

    const-string v5, "*"

    invoke-virtual {v4, v5}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v4

    invoke-static {p0}, Lcom/cyjh/elfin/util/AppDeviceUtils;->getResolution(Landroid/content/Context;)Landroid/graphics/Point;

    move-result-object v5

    iget v5, v5, Landroid/graphics/Point;->x:I

    invoke-virtual {v4, v5}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v4

    invoke-virtual {v4}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v2

    .line 238
    .local v2, "resolution2":Ljava/lang/String;
    const v4, 0x7f08003d

    invoke-virtual {p0, v4}, Lcom/cyjh/elfin/activity/ElfinFreeActivity;->getString(I)Ljava/lang/String;

    move-result-object v0

    .line 239
    .local v0, "resolution":Ljava/lang/String;
    iget-object v4, p0, Lcom/cyjh/elfin/activity/ElfinFreeActivity;->commonLog:Lcom/cyjh/elfin/log/CommonLog;

    new-instance v5, Ljava/lang/StringBuilder;

    invoke-direct {v5}, Ljava/lang/StringBuilder;-><init>()V

    const-string v6, "resolution1>>>"

    invoke-virtual {v5, v6}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v5

    invoke-virtual {v5, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v5

    invoke-virtual {v5}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v5

    invoke-virtual {v4, v5}, Lcom/cyjh/elfin/log/CommonLog;->e(Ljava/lang/Object;)V

    .line 240
    iget-object v4, p0, Lcom/cyjh/elfin/activity/ElfinFreeActivity;->commonLog:Lcom/cyjh/elfin/log/CommonLog;

    new-instance v5, Ljava/lang/StringBuilder;

    invoke-direct {v5}, Ljava/lang/StringBuilder;-><init>()V

    const-string v6, "resolution2>>>"

    invoke-virtual {v5, v6}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v5

    invoke-virtual {v5, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v5

    invoke-virtual {v5}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v5

    invoke-virtual {v4, v5}, Lcom/cyjh/elfin/log/CommonLog;->e(Ljava/lang/Object;)V

    .line 241
    iget-object v4, p0, Lcom/cyjh/elfin/activity/ElfinFreeActivity;->commonLog:Lcom/cyjh/elfin/log/CommonLog;

    new-instance v5, Ljava/lang/StringBuilder;

    invoke-direct {v5}, Ljava/lang/StringBuilder;-><init>()V

    const-string v6, "resolution>>>"

    invoke-virtual {v5, v6}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v5

    invoke-virtual {v5, v0}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v5

    invoke-virtual {v5}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v5

    invoke-virtual {v4, v5}, Lcom/cyjh/elfin/log/CommonLog;->e(Ljava/lang/Object;)V

    .line 242
    invoke-virtual {v0, v1}, Ljava/lang/String;->contains(Ljava/lang/CharSequence;)Z

    move-result v4

    if-nez v4, :cond_0

    invoke-virtual {v0, v2}, Ljava/lang/String;->contains(Ljava/lang/CharSequence;)Z

    move-result v4

    if-nez v4, :cond_0

    invoke-static {v0}, Landroid/text/TextUtils;->isEmpty(Ljava/lang/CharSequence;)Z

    move-result v4

    if-eqz v4, :cond_1

    .line 243
    :cond_0
    const/16 v4, 0x8

    invoke-virtual {v3, v4}, Landroid/widget/TextView;->setVisibility(I)V

    .line 247
    :goto_0
    return-void

    .line 245
    :cond_1
    const/4 v4, 0x0

    invoke-virtual {v3, v4}, Landroid/widget/TextView;->setVisibility(I)V

    goto :goto_0
.end method

.method private exit()V
    .locals 3

    .prologue
    .line 266
    new-instance v1, Landroid/content/Intent;

    const-class v2, Lcom/cyjh/elfin/services/SavePicService;

    invoke-direct {v1, p0, v2}, Landroid/content/Intent;-><init>(Landroid/content/Context;Ljava/lang/Class;)V

    invoke-virtual {p0, v1}, Lcom/cyjh/elfin/activity/ElfinFreeActivity;->stopService(Landroid/content/Intent;)Z

    .line 267
    new-instance v1, Landroid/content/Intent;

    const-class v2, Lcom/cyjh/elfin/services/PhoneStateService;

    invoke-direct {v1, p0, v2}, Landroid/content/Intent;-><init>(Landroid/content/Context;Ljava/lang/Class;)V

    invoke-virtual {p0, v1}, Lcom/cyjh/elfin/activity/ElfinFreeActivity;->stopService(Landroid/content/Intent;)Z

    .line 268
    new-instance v1, Landroid/content/Intent;

    const-class v2, Lcom/cyjh/mobileanjian/ipc/IpcService;

    invoke-direct {v1, p0, v2}, Landroid/content/Intent;-><init>(Landroid/content/Context;Ljava/lang/Class;)V

    invoke-virtual {p0, v1}, Lcom/cyjh/elfin/activity/ElfinFreeActivity;->stopService(Landroid/content/Intent;)Z

    .line 269
    new-instance v1, Landroid/content/Intent;

    const-class v2, Lcom/cyjh/elfin/services/DownloadApkService;

    invoke-direct {v1, p0, v2}, Landroid/content/Intent;-><init>(Landroid/content/Context;Ljava/lang/Class;)V

    invoke-virtual {p0, v1}, Lcom/cyjh/elfin/activity/ElfinFreeActivity;->stopService(Landroid/content/Intent;)Z

    .line 270
    invoke-static {}, Lcom/cyjh/elfin/AppContext;->getInstance()Lcom/cyjh/elfin/AppContext;

    move-result-object v1

    invoke-virtual {v1}, Lcom/cyjh/elfin/AppContext;->onKillProcess()V

    .line 271
    new-instance v1, Landroid/content/Intent;

    const-class v2, Lcom/kaopu/download/kernel/DownloadService;

    invoke-direct {v1, p0, v2}, Landroid/content/Intent;-><init>(Landroid/content/Context;Ljava/lang/Class;)V

    invoke-virtual {p0, v1}, Lcom/cyjh/elfin/activity/ElfinFreeActivity;->stopService(Landroid/content/Intent;)Z

    .line 272
    const-string v1, "activity"

    invoke-virtual {p0, v1}, Lcom/cyjh/elfin/activity/ElfinFreeActivity;->getSystemService(Ljava/lang/String;)Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Landroid/app/ActivityManager;

    .line 273
    .local v0, "activityManager":Landroid/app/ActivityManager;
    if-eqz v0, :cond_0

    .line 275
    const-string v1, "com.cyjh.elfin:download_server"

    invoke-virtual {v0, v1}, Landroid/app/ActivityManager;->killBackgroundProcesses(Ljava/lang/String;)V

    .line 277
    :cond_0
    invoke-static {}, Landroid/os/Process;->myPid()I

    move-result v1

    invoke-static {v1}, Landroid/os/Process;->killProcess(I)V

    .line 278
    return-void
.end method

.method private exitAll()V
    .locals 2

    .prologue
    .line 296
    :try_start_0
    iget-object v1, p0, Lcom/cyjh/elfin/activity/ElfinFreeActivity;->optionFragment:Lcom/cyjh/elfin/fragment/OptionFragment;

    invoke-virtual {v1}, Lcom/cyjh/elfin/fragment/OptionFragment;->generateOptionJson()V
    :try_end_0
    .catch Ljava/lang/Exception; {:try_start_0 .. :try_end_0} :catch_0

    .line 300
    :goto_0
    invoke-direct {p0}, Lcom/cyjh/elfin/activity/ElfinFreeActivity;->exit()V

    .line 301
    return-void

    .line 297
    :catch_0
    move-exception v0

    .line 298
    .local v0, "e":Ljava/lang/Exception;
    invoke-virtual {v0}, Ljava/lang/Exception;->printStackTrace()V

    goto :goto_0
.end method

.method private initDatabase()V
    .locals 2

    .prologue
    .line 152
    invoke-static {}, Lcom/cyjh/elfin/database/MsgDatabaseOpera;->getInstance()Lcom/cyjh/elfin/database/MsgDatabaseOpera;

    move-result-object v0

    iget-object v1, p0, Lcom/cyjh/elfin/activity/ElfinFreeActivity;->mHandler:Lcom/cyjh/elfin/activity/ElfinFreeActivity$MainHandler;

    invoke-virtual {v0, v1}, Lcom/cyjh/elfin/database/MsgDatabaseOpera;->queryAll(Landroid/os/Handler;)V

    .line 153
    return-void
.end method

.method private initNotify()V
    .locals 6

    .prologue
    const v5, 0x7f020098

    const/4 v4, 0x0

    .line 307
    new-instance v2, Landroid/support/v4/app/NotificationCompat$Builder;

    invoke-direct {v2, p0}, Landroid/support/v4/app/NotificationCompat$Builder;-><init>(Landroid/content/Context;)V

    iput-object v2, p0, Lcom/cyjh/elfin/activity/ElfinFreeActivity;->mBuilder:Landroid/support/v4/app/NotificationCompat$Builder;

    .line 308
    const-string v2, "notification"

    invoke-virtual {p0, v2}, Lcom/cyjh/elfin/activity/ElfinFreeActivity;->getSystemService(Ljava/lang/String;)Ljava/lang/Object;

    move-result-object v2

    check-cast v2, Landroid/app/NotificationManager;

    iput-object v2, p0, Lcom/cyjh/elfin/activity/ElfinFreeActivity;->mNotifyManager:Landroid/app/NotificationManager;

    .line 309
    new-instance v0, Landroid/content/Intent;

    const-class v2, Lcom/cyjh/elfin/activity/MessagePushActivity;

    invoke-direct {v0, p0, v2}, Landroid/content/Intent;-><init>(Landroid/content/Context;Ljava/lang/Class;)V

    .line 310
    .local v0, "intentClick":Landroid/content/Intent;
    const-string v2, "msg_data"

    iget-object v3, p0, Lcom/cyjh/elfin/activity/ElfinFreeActivity;->msgDataList:Ljava/util/ArrayList;

    invoke-virtual {v0, v2, v3}, Landroid/content/Intent;->putParcelableArrayListExtra(Ljava/lang/String;Ljava/util/ArrayList;)Landroid/content/Intent;

    .line 311
    const/high16 v2, 0x8000000

    invoke-static {p0, v4, v0, v2}, Landroid/app/PendingIntent;->getActivity(Landroid/content/Context;ILandroid/content/Intent;I)Landroid/app/PendingIntent;

    move-result-object v1

    .line 312
    .local v1, "pendingIntentClick":Landroid/app/PendingIntent;
    iget-object v2, p0, Lcom/cyjh/elfin/activity/ElfinFreeActivity;->mBuilder:Landroid/support/v4/app/NotificationCompat$Builder;

    invoke-virtual {v2, v5}, Landroid/support/v4/app/NotificationCompat$Builder;->setSmallIcon(I)Landroid/support/v4/app/NotificationCompat$Builder;

    move-result-object v2

    .line 313
    invoke-virtual {p0}, Lcom/cyjh/elfin/activity/ElfinFreeActivity;->getResources()Landroid/content/res/Resources;

    move-result-object v3

    invoke-static {v3, v5}, Landroid/graphics/BitmapFactory;->decodeResource(Landroid/content/res/Resources;I)Landroid/graphics/Bitmap;

    move-result-object v3

    invoke-virtual {v2, v3}, Landroid/support/v4/app/NotificationCompat$Builder;->setLargeIcon(Landroid/graphics/Bitmap;)Landroid/support/v4/app/NotificationCompat$Builder;

    move-result-object v2

    .line 314
    invoke-virtual {v2, v4}, Landroid/support/v4/app/NotificationCompat$Builder;->setOngoing(Z)Landroid/support/v4/app/NotificationCompat$Builder;

    move-result-object v2

    const/4 v3, 0x1

    .line 315
    invoke-virtual {v2, v3}, Landroid/support/v4/app/NotificationCompat$Builder;->setAutoCancel(Z)Landroid/support/v4/app/NotificationCompat$Builder;

    move-result-object v2

    .line 316
    invoke-virtual {v2, v4}, Landroid/support/v4/app/NotificationCompat$Builder;->setPriority(I)Landroid/support/v4/app/NotificationCompat$Builder;

    move-result-object v2

    const/4 v3, 0x2

    .line 317
    invoke-virtual {v2, v3}, Landroid/support/v4/app/NotificationCompat$Builder;->setDefaults(I)Landroid/support/v4/app/NotificationCompat$Builder;

    move-result-object v2

    .line 318
    invoke-virtual {v2, v1}, Landroid/support/v4/app/NotificationCompat$Builder;->setContentIntent(Landroid/app/PendingIntent;)Landroid/support/v4/app/NotificationCompat$Builder;

    .line 319
    return-void
.end method

.method private initPager()V
    .locals 6

    .prologue
    .line 250
    new-instance v1, Ljava/util/ArrayList;

    invoke-direct {v1}, Ljava/util/ArrayList;-><init>()V

    .line 251
    .local v1, "fragments":Ljava/util/ArrayList;, "Ljava/util/ArrayList<Landroid/support/v4/app/Fragment;>;"
    new-instance v5, Lcom/cyjh/elfin/fragment/OptionFragment;

    invoke-direct {v5}, Lcom/cyjh/elfin/fragment/OptionFragment;-><init>()V

    iput-object v5, p0, Lcom/cyjh/elfin/activity/ElfinFreeActivity;->optionFragment:Lcom/cyjh/elfin/fragment/OptionFragment;

    .line 252
    new-instance v0, Lcom/cyjh/elfin/fragment/DescriptionFragment;

    invoke-direct {v0}, Lcom/cyjh/elfin/fragment/DescriptionFragment;-><init>()V

    .line 253
    .local v0, "descriptionFragment":Lcom/cyjh/elfin/fragment/DescriptionFragment;
    iget-object v5, p0, Lcom/cyjh/elfin/activity/ElfinFreeActivity;->optionFragment:Lcom/cyjh/elfin/fragment/OptionFragment;

    invoke-virtual {v1, v5}, Ljava/util/ArrayList;->add(Ljava/lang/Object;)Z

    .line 254
    invoke-virtual {v1, v0}, Ljava/util/ArrayList;->add(Ljava/lang/Object;)Z

    .line 255
    new-instance v2, Lcom/cyjh/elfin/adpter/TabAdapter;

    invoke-virtual {p0}, Lcom/cyjh/elfin/activity/ElfinFreeActivity;->getSupportFragmentManager()Landroid/support/v4/app/FragmentManager;

    move-result-object v5

    invoke-direct {v2, p0, v5, v1}, Lcom/cyjh/elfin/adpter/TabAdapter;-><init>(Landroid/content/Context;Landroid/support/v4/app/FragmentManager;Ljava/util/ArrayList;)V

    .line 256
    .local v2, "mTabAdapter":Lcom/cyjh/elfin/adpter/TabAdapter;
    const v5, 0x7f0f007e

    invoke-virtual {p0, v5}, Lcom/cyjh/elfin/activity/ElfinFreeActivity;->findViewById(I)Landroid/view/View;

    move-result-object v4

    check-cast v4, Lcom/cyjh/elfin/customview/RTDViewPager;

    .line 257
    .local v4, "mViewPager":Lcom/cyjh/elfin/customview/RTDViewPager;
    invoke-virtual {v4, v2}, Lcom/cyjh/elfin/customview/RTDViewPager;->setAdapter(Landroid/support/v4/view/PagerAdapter;)V

    .line 258
    const v5, 0x7f0f007b

    invoke-virtual {p0, v5}, Lcom/cyjh/elfin/activity/ElfinFreeActivity;->findViewById(I)Landroid/view/View;

    move-result-object v3

    check-cast v3, Lcom/viewpagerindicator/TabPageIndicator;

    .line 259
    .local v3, "mTabPageIndicator":Lcom/viewpagerindicator/TabPageIndicator;
    invoke-virtual {v3, v4}, Lcom/viewpagerindicator/TabPageIndicator;->setViewPager(Landroid/support/v4/view/ViewPager;)V

    .line 261
    const v5, 0x7f0f007c

    invoke-virtual {p0, v5}, Lcom/cyjh/elfin/activity/ElfinFreeActivity;->findViewById(I)Landroid/view/View;

    move-result-object v5

    check-cast v5, Landroid/widget/TextView;

    iput-object v5, p0, Lcom/cyjh/elfin/activity/ElfinFreeActivity;->mTvRecommendGames:Landroid/widget/TextView;

    .line 262
    iget-object v5, p0, Lcom/cyjh/elfin/activity/ElfinFreeActivity;->mTvRecommendGames:Landroid/widget/TextView;

    invoke-virtual {v5, p0}, Landroid/widget/TextView;->setOnClickListener(Landroid/view/View$OnClickListener;)V

    .line 263
    return-void
.end method

.method private initTitle()V
    .locals 3

    .prologue
    .line 227
    const v2, 0x7f0f0078

    invoke-virtual {p0, v2}, Lcom/cyjh/elfin/activity/ElfinFreeActivity;->findViewById(I)Landroid/view/View;

    move-result-object v1

    check-cast v1, Landroid/widget/ImageView;

    .line 228
    .local v1, "mImgSetting":Landroid/widget/ImageView;
    const v2, 0x7f0f007a

    invoke-virtual {p0, v2}, Lcom/cyjh/elfin/activity/ElfinFreeActivity;->findViewById(I)Landroid/view/View;

    move-result-object v2

    check-cast v2, Landroid/widget/ImageView;

    iput-object v2, p0, Lcom/cyjh/elfin/activity/ElfinFreeActivity;->mImgRedDot:Landroid/widget/ImageView;

    .line 229
    const v2, 0x7f0f0079

    invoke-virtual {p0, v2}, Lcom/cyjh/elfin/activity/ElfinFreeActivity;->findViewById(I)Landroid/view/View;

    move-result-object v0

    check-cast v0, Landroid/widget/ImageView;

    .line 230
    .local v0, "mImgMsg":Landroid/widget/ImageView;
    invoke-virtual {v1, p0}, Landroid/widget/ImageView;->setOnClickListener(Landroid/view/View$OnClickListener;)V

    .line 231
    invoke-virtual {v0, p0}, Landroid/widget/ImageView;->setOnClickListener(Landroid/view/View$OnClickListener;)V

    .line 232
    return-void
.end method

.method private initView()V
    .locals 1

    .prologue
    .line 214
    invoke-direct {p0}, Lcom/cyjh/elfin/activity/ElfinFreeActivity;->initTitle()V

    .line 216
    invoke-direct {p0}, Lcom/cyjh/elfin/activity/ElfinFreeActivity;->checkResolution()V

    .line 217
    invoke-direct {p0}, Lcom/cyjh/elfin/activity/ElfinFreeActivity;->initPager()V

    .line 219
    invoke-virtual {p0}, Lcom/cyjh/elfin/activity/ElfinFreeActivity;->isRedVisibility()V

    .line 220
    invoke-static {}, Lorg/greenrobot/eventbus/EventBus;->getDefault()Lorg/greenrobot/eventbus/EventBus;

    move-result-object v0

    invoke-virtual {v0, p0}, Lorg/greenrobot/eventbus/EventBus;->register(Ljava/lang/Object;)V

    .line 221
    return-void
.end method

.method private processInitDbData(Ljava/util/ArrayList;)V
    .locals 4
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "(",
            "Ljava/util/ArrayList",
            "<",
            "Lcom/cyjh/elfin/entity/NotifyMsgBean;",
            ">;)V"
        }
    .end annotation

    .prologue
    .line 160
    .local p1, "data":Ljava/util/ArrayList;, "Ljava/util/ArrayList<Lcom/cyjh/elfin/entity/NotifyMsgBean;>;"
    iget-object v1, p0, Lcom/cyjh/elfin/activity/ElfinFreeActivity;->msgDataList:Ljava/util/ArrayList;

    invoke-virtual {v1}, Ljava/util/ArrayList;->clear()V

    .line 161
    iget-object v1, p0, Lcom/cyjh/elfin/activity/ElfinFreeActivity;->msgIdList:Ljava/util/List;

    invoke-interface {v1}, Ljava/util/List;->clear()V

    .line 162
    iget-object v1, p0, Lcom/cyjh/elfin/activity/ElfinFreeActivity;->msgDataList:Ljava/util/ArrayList;

    invoke-virtual {v1, p1}, Ljava/util/ArrayList;->addAll(Ljava/util/Collection;)Z

    .line 163
    iget-object v1, p0, Lcom/cyjh/elfin/activity/ElfinFreeActivity;->msgDataList:Ljava/util/ArrayList;

    invoke-virtual {v1}, Ljava/util/ArrayList;->iterator()Ljava/util/Iterator;

    move-result-object v1

    :goto_0
    invoke-interface {v1}, Ljava/util/Iterator;->hasNext()Z

    move-result v2

    if-eqz v2, :cond_0

    invoke-interface {v1}, Ljava/util/Iterator;->next()Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Lcom/cyjh/elfin/entity/NotifyMsgBean;

    .line 164
    .local v0, "notifyMsg":Lcom/cyjh/elfin/entity/NotifyMsgBean;
    iget-object v2, p0, Lcom/cyjh/elfin/activity/ElfinFreeActivity;->msgIdList:Ljava/util/List;

    iget-object v3, v0, Lcom/cyjh/elfin/entity/NotifyMsgBean;->ID:Ljava/lang/String;

    invoke-interface {v2, v3}, Ljava/util/List;->add(Ljava/lang/Object;)Z

    goto :goto_0

    .line 166
    .end local v0    # "notifyMsg":Lcom/cyjh/elfin/entity/NotifyMsgBean;
    :cond_0
    return-void
.end method

.method private pushDataProcess()V
    .locals 4

    .prologue
    const/4 v2, 0x0

    .line 437
    iget-object v1, p0, Lcom/cyjh/elfin/activity/ElfinFreeActivity;->mImgRedDot:Landroid/widget/ImageView;

    invoke-virtual {v1, v2}, Landroid/widget/ImageView;->setVisibility(I)V

    .line 438
    iget-object v1, p0, Lcom/cyjh/elfin/activity/ElfinFreeActivity;->msgPartDataList:Ljava/util/ArrayList;

    invoke-virtual {v1, v2}, Ljava/util/ArrayList;->get(I)Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Lcom/cyjh/elfin/entity/NotifyMsgBean;

    .line 439
    .local v0, "notifyMsgBean":Lcom/cyjh/elfin/entity/NotifyMsgBean;
    iget-boolean v1, v0, Lcom/cyjh/elfin/entity/NotifyMsgBean;->IsSendMessage:Z

    if-eqz v1, :cond_0

    .line 440
    invoke-direct {p0}, Lcom/cyjh/elfin/activity/ElfinFreeActivity;->initNotify()V

    .line 441
    iget-object v1, p0, Lcom/cyjh/elfin/activity/ElfinFreeActivity;->mBuilder:Landroid/support/v4/app/NotificationCompat$Builder;

    iget-object v2, v0, Lcom/cyjh/elfin/entity/NotifyMsgBean;->NoticeTitle:Ljava/lang/String;

    invoke-virtual {v1, v2}, Landroid/support/v4/app/NotificationCompat$Builder;->setContentTitle(Ljava/lang/CharSequence;)Landroid/support/v4/app/NotificationCompat$Builder;

    move-result-object v1

    iget-object v2, v0, Lcom/cyjh/elfin/entity/NotifyMsgBean;->NoticeTitle:Ljava/lang/String;

    .line 442
    invoke-virtual {v1, v2}, Landroid/support/v4/app/NotificationCompat$Builder;->setTicker(Ljava/lang/CharSequence;)Landroid/support/v4/app/NotificationCompat$Builder;

    move-result-object v1

    iget-object v2, v0, Lcom/cyjh/elfin/entity/NotifyMsgBean;->NoticeTitle:Ljava/lang/String;

    .line 443
    invoke-virtual {v1, v2}, Landroid/support/v4/app/NotificationCompat$Builder;->setContentText(Ljava/lang/CharSequence;)Landroid/support/v4/app/NotificationCompat$Builder;

    .line 444
    iget-object v1, p0, Lcom/cyjh/elfin/activity/ElfinFreeActivity;->mNotifyManager:Landroid/app/NotificationManager;

    const/16 v2, 0x3e9

    iget-object v3, p0, Lcom/cyjh/elfin/activity/ElfinFreeActivity;->mBuilder:Landroid/support/v4/app/NotificationCompat$Builder;

    invoke-virtual {v3}, Landroid/support/v4/app/NotificationCompat$Builder;->build()Landroid/app/Notification;

    move-result-object v3

    invoke-virtual {v1, v2, v3}, Landroid/app/NotificationManager;->notify(ILandroid/app/Notification;)V

    .line 447
    :cond_0
    iget-object v1, p0, Lcom/cyjh/elfin/activity/ElfinFreeActivity;->mSharedPres:Landroid/content/SharedPreferences;

    invoke-interface {v1}, Landroid/content/SharedPreferences;->edit()Landroid/content/SharedPreferences$Editor;

    move-result-object v1

    const-string v2, "red_dot_flag"

    const/4 v3, 0x1

    invoke-interface {v1, v2, v3}, Landroid/content/SharedPreferences$Editor;->putBoolean(Ljava/lang/String;Z)Landroid/content/SharedPreferences$Editor;

    move-result-object v1

    invoke-interface {v1}, Landroid/content/SharedPreferences$Editor;->apply()V

    .line 448
    invoke-static {}, Lcom/cyjh/elfin/database/MsgDatabaseOpera;->getInstance()Lcom/cyjh/elfin/database/MsgDatabaseOpera;

    move-result-object v1

    iget-object v2, p0, Lcom/cyjh/elfin/activity/ElfinFreeActivity;->msgPartDataList:Ljava/util/ArrayList;

    invoke-virtual {v1, v2}, Lcom/cyjh/elfin/database/MsgDatabaseOpera;->insertData(Ljava/util/List;)V

    .line 449
    return-void
.end method

.method public static toCallActivity(Landroid/content/Context;)V
    .locals 2
    .param p0, "context"    # Landroid/content/Context;

    .prologue
    .line 391
    new-instance v0, Landroid/content/Intent;

    const-class v1, Lcom/cyjh/elfin/activity/ElfinFreeActivity;

    invoke-direct {v0, p0, v1}, Landroid/content/Intent;-><init>(Landroid/content/Context;Ljava/lang/Class;)V

    .line 392
    .local v0, "intent":Landroid/content/Intent;
    const/high16 v1, 0x10000000

    invoke-virtual {v0, v1}, Landroid/content/Intent;->addFlags(I)Landroid/content/Intent;

    .line 393
    invoke-virtual {p0, v0}, Landroid/content/Context;->startActivity(Landroid/content/Intent;)V

    .line 394
    return-void
.end method


# virtual methods
.method public gamesSwitch(Lcom/cyjh/elfin/entity/GameSwitchBean;)V
    .locals 7
    .param p1, "gameSwitchBean"    # Lcom/cyjh/elfin/entity/GameSwitchBean;

    .prologue
    const/high16 v5, 0x40000000    # 2.0f

    .line 402
    if-eqz p1, :cond_0

    iget-object v3, p1, Lcom/cyjh/elfin/entity/GameSwitchBean;->Data:Lcom/cyjh/elfin/entity/GameSwitchInfo;

    if-eqz v3, :cond_0

    const-string v3, "1"

    iget-object v4, p1, Lcom/cyjh/elfin/entity/GameSwitchBean;->Code:Ljava/lang/String;

    invoke-virtual {v3, v4}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v3

    if-eqz v3, :cond_0

    .line 403
    iget-object v3, p1, Lcom/cyjh/elfin/entity/GameSwitchBean;->Data:Lcom/cyjh/elfin/entity/GameSwitchInfo;

    iput-object v3, p0, Lcom/cyjh/elfin/activity/ElfinFreeActivity;->gameSwitchInfo:Lcom/cyjh/elfin/entity/GameSwitchInfo;

    .line 404
    invoke-virtual {p0}, Lcom/cyjh/elfin/activity/ElfinFreeActivity;->getResources()Landroid/content/res/Resources;

    move-result-object v3

    const v4, 0x7f02008d

    invoke-virtual {v3, v4}, Landroid/content/res/Resources;->getDrawable(I)Landroid/graphics/drawable/Drawable;

    move-result-object v0

    .line 405
    .local v0, "drawable":Landroid/graphics/drawable/Drawable;
    invoke-static {p0, v5}, Lcom/cyjh/elfin/util/AppDeviceUtils;->getDipToPx(Landroid/content/Context;F)I

    move-result v3

    invoke-static {p0, v5}, Lcom/cyjh/elfin/util/AppDeviceUtils;->getDipToPx(Landroid/content/Context;F)I

    move-result v4

    .line 406
    invoke-virtual {v0}, Landroid/graphics/drawable/Drawable;->getIntrinsicWidth()I

    move-result v5

    invoke-virtual {v0}, Landroid/graphics/drawable/Drawable;->getIntrinsicHeight()I

    move-result v6

    .line 405
    invoke-virtual {v0, v3, v4, v5, v6}, Landroid/graphics/drawable/Drawable;->setBounds(IIII)V

    .line 407
    new-instance v1, Landroid/text/style/ImageSpan;

    const/4 v3, 0x1

    invoke-direct {v1, v0, v3}, Landroid/text/style/ImageSpan;-><init>(Landroid/graphics/drawable/Drawable;I)V

    .line 408
    .local v1, "imageSpan":Landroid/text/style/ImageSpan;
    new-instance v2, Landroid/text/SpannableString;

    new-instance v3, Ljava/lang/StringBuilder;

    invoke-direct {v3}, Ljava/lang/StringBuilder;-><init>()V

    iget-object v4, p0, Lcom/cyjh/elfin/activity/ElfinFreeActivity;->gameSwitchInfo:Lcom/cyjh/elfin/entity/GameSwitchInfo;

    iget-object v4, v4, Lcom/cyjh/elfin/entity/GameSwitchInfo;->Name:Ljava/lang/String;

    invoke-virtual {v3, v4}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v3

    const v4, 0x7f0800d8

    invoke-virtual {p0, v4}, Lcom/cyjh/elfin/activity/ElfinFreeActivity;->getString(I)Ljava/lang/String;

    move-result-object v4

    invoke-virtual {v3, v4}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v3

    invoke-virtual {v3}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v3

    invoke-direct {v2, v3}, Landroid/text/SpannableString;-><init>(Ljava/lang/CharSequence;)V

    .line 409
    .local v2, "span":Landroid/text/SpannableString;
    iget-object v3, p0, Lcom/cyjh/elfin/activity/ElfinFreeActivity;->gameSwitchInfo:Lcom/cyjh/elfin/entity/GameSwitchInfo;

    iget-object v3, v3, Lcom/cyjh/elfin/entity/GameSwitchInfo;->Name:Ljava/lang/String;

    invoke-virtual {v3}, Ljava/lang/String;->length()I

    move-result v3

    invoke-virtual {v2}, Landroid/text/SpannableString;->length()I

    move-result v4

    const/16 v5, 0x21

    invoke-virtual {v2, v1, v3, v4, v5}, Landroid/text/SpannableString;->setSpan(Ljava/lang/Object;III)V

    .line 410
    iget-object v3, p0, Lcom/cyjh/elfin/activity/ElfinFreeActivity;->mTvRecommendGames:Landroid/widget/TextView;

    invoke-virtual {v3, v2}, Landroid/widget/TextView;->setText(Ljava/lang/CharSequence;)V

    .line 411
    iget-object v3, p0, Lcom/cyjh/elfin/activity/ElfinFreeActivity;->mTvRecommendGames:Landroid/widget/TextView;

    const/4 v4, 0x0

    invoke-virtual {v3, v4}, Landroid/widget/TextView;->setVisibility(I)V

    .line 415
    .end local v0    # "drawable":Landroid/graphics/drawable/Drawable;
    .end local v1    # "imageSpan":Landroid/text/style/ImageSpan;
    .end local v2    # "span":Landroid/text/SpannableString;
    :goto_0
    return-void

    .line 413
    :cond_0
    iget-object v3, p0, Lcom/cyjh/elfin/activity/ElfinFreeActivity;->mTvRecommendGames:Landroid/widget/TextView;

    const/16 v4, 0x8

    invoke-virtual {v3, v4}, Landroid/widget/TextView;->setVisibility(I)V

    goto :goto_0
.end method

.method public isRedVisibility()V
    .locals 4

    .prologue
    const/4 v3, 0x0

    .line 322
    const-string v1, "small_red_dot"

    invoke-virtual {p0, v1, v3}, Lcom/cyjh/elfin/activity/ElfinFreeActivity;->getSharedPreferences(Ljava/lang/String;I)Landroid/content/SharedPreferences;

    move-result-object v1

    iput-object v1, p0, Lcom/cyjh/elfin/activity/ElfinFreeActivity;->mSharedPres:Landroid/content/SharedPreferences;

    .line 323
    iget-object v1, p0, Lcom/cyjh/elfin/activity/ElfinFreeActivity;->mSharedPres:Landroid/content/SharedPreferences;

    const-string v2, "red_dot_flag"

    invoke-interface {v1, v2, v3}, Landroid/content/SharedPreferences;->getBoolean(Ljava/lang/String;Z)Z

    move-result v0

    .line 326
    .local v0, "redFlag":Z
    if-eqz v0, :cond_0

    .line 327
    iget-object v1, p0, Lcom/cyjh/elfin/activity/ElfinFreeActivity;->mImgRedDot:Landroid/widget/ImageView;

    invoke-virtual {v1, v3}, Landroid/widget/ImageView;->setVisibility(I)V

    .line 329
    :cond_0
    return-void
.end method

.method public onBackPressed()V
    .locals 4

    .prologue
    .line 200
    iget-boolean v0, p0, Lcom/cyjh/elfin/activity/ElfinFreeActivity;->doubleBackToExitPressedOnce:Z

    if-eqz v0, :cond_0

    .line 201
    invoke-direct {p0}, Lcom/cyjh/elfin/activity/ElfinFreeActivity;->exitAll()V

    .line 203
    :cond_0
    const/4 v0, 0x1

    iput-boolean v0, p0, Lcom/cyjh/elfin/activity/ElfinFreeActivity;->doubleBackToExitPressedOnce:Z

    .line 204
    const v0, 0x7f080095

    invoke-static {p0, v0}, Lcom/cyjh/elfin/util/ToastUtils;->showToastShort(Landroid/content/Context;I)V

    .line 205
    new-instance v0, Landroid/os/Handler;

    invoke-direct {v0}, Landroid/os/Handler;-><init>()V

    new-instance v1, Lcom/cyjh/elfin/activity/ElfinFreeActivity$1;

    invoke-direct {v1, p0}, Lcom/cyjh/elfin/activity/ElfinFreeActivity$1;-><init>(Lcom/cyjh/elfin/activity/ElfinFreeActivity;)V

    const-wide/16 v2, 0x7d0

    invoke-virtual {v0, v1, v2, v3}, Landroid/os/Handler;->postDelayed(Ljava/lang/Runnable;J)Z

    .line 211
    return-void
.end method

.method public onClick(Landroid/view/View;)V
    .locals 3
    .param p1, "v"    # Landroid/view/View;

    .prologue
    .line 333
    invoke-virtual {p1}, Landroid/view/View;->getId()I

    move-result v1

    packed-switch v1, :pswitch_data_0

    .line 363
    :cond_0
    :goto_0
    :pswitch_0
    return-void

    .line 336
    :pswitch_1
    new-instance v1, Landroid/content/Intent;

    const-class v2, Lcom/cyjh/elfin/activity/SettingActivity;

    invoke-direct {v1, p0, v2}, Landroid/content/Intent;-><init>(Landroid/content/Context;Ljava/lang/Class;)V

    invoke-virtual {p0, v1}, Lcom/cyjh/elfin/activity/ElfinFreeActivity;->startActivity(Landroid/content/Intent;)V

    goto :goto_0

    .line 341
    :pswitch_2
    iget-object v1, p0, Lcom/cyjh/elfin/activity/ElfinFreeActivity;->mImgRedDot:Landroid/widget/ImageView;

    const/4 v2, 0x4

    invoke-virtual {v1, v2}, Landroid/widget/ImageView;->setVisibility(I)V

    .line 342
    new-instance v0, Landroid/content/Intent;

    const-class v1, Lcom/cyjh/elfin/activity/MessagePushActivity;

    invoke-direct {v0, p0, v1}, Landroid/content/Intent;-><init>(Landroid/content/Context;Ljava/lang/Class;)V

    .line 343
    .local v0, "intent":Landroid/content/Intent;
    iget-object v1, p0, Lcom/cyjh/elfin/activity/ElfinFreeActivity;->msgDataList:Ljava/util/ArrayList;

    if-eqz v1, :cond_1

    iget-object v1, p0, Lcom/cyjh/elfin/activity/ElfinFreeActivity;->msgDataList:Ljava/util/ArrayList;

    invoke-virtual {v1}, Ljava/util/ArrayList;->size()I

    move-result v1

    if-lez v1, :cond_1

    .line 344
    const-string v1, "msg_data"

    iget-object v2, p0, Lcom/cyjh/elfin/activity/ElfinFreeActivity;->msgDataList:Ljava/util/ArrayList;

    invoke-virtual {v0, v1, v2}, Landroid/content/Intent;->putParcelableArrayListExtra(Ljava/lang/String;Ljava/util/ArrayList;)Landroid/content/Intent;

    .line 346
    :cond_1
    invoke-virtual {p0, v0}, Lcom/cyjh/elfin/activity/ElfinFreeActivity;->startActivity(Landroid/content/Intent;)V

    goto :goto_0

    .line 350
    .end local v0    # "intent":Landroid/content/Intent;
    :pswitch_3
    iget-object v1, p0, Lcom/cyjh/elfin/activity/ElfinFreeActivity;->gameSwitchInfo:Lcom/cyjh/elfin/entity/GameSwitchInfo;

    if-eqz v1, :cond_0

    .line 351
    const-string v1, "1"

    iget-object v2, p0, Lcom/cyjh/elfin/activity/ElfinFreeActivity;->gameSwitchInfo:Lcom/cyjh/elfin/entity/GameSwitchInfo;

    iget-object v2, v2, Lcom/cyjh/elfin/entity/GameSwitchInfo;->Type:Ljava/lang/String;

    invoke-virtual {v1, v2}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v1

    if-eqz v1, :cond_2

    .line 352
    iget-object v1, p0, Lcom/cyjh/elfin/activity/ElfinFreeActivity;->gameSwitchInfo:Lcom/cyjh/elfin/entity/GameSwitchInfo;

    iget-object v1, v1, Lcom/cyjh/elfin/entity/GameSwitchInfo;->Name:Ljava/lang/String;

    invoke-static {p0, v1}, Lcom/cyjh/elfin/util/IntentUtils;->toCallAbGames(Landroid/content/Context;Ljava/lang/String;)V

    goto :goto_0

    .line 354
    :cond_2
    const-string v1, "2"

    iget-object v2, p0, Lcom/cyjh/elfin/activity/ElfinFreeActivity;->gameSwitchInfo:Lcom/cyjh/elfin/entity/GameSwitchInfo;

    iget-object v2, v2, Lcom/cyjh/elfin/entity/GameSwitchInfo;->Type:Ljava/lang/String;

    invoke-virtual {v1, v2}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v1

    if-eqz v1, :cond_0

    .line 355
    iget-object v1, p0, Lcom/cyjh/elfin/activity/ElfinFreeActivity;->gameSwitchInfo:Lcom/cyjh/elfin/entity/GameSwitchInfo;

    iget-object v1, v1, Lcom/cyjh/elfin/entity/GameSwitchInfo;->Name:Ljava/lang/String;

    iget-object v2, p0, Lcom/cyjh/elfin/activity/ElfinFreeActivity;->gameSwitchInfo:Lcom/cyjh/elfin/entity/GameSwitchInfo;

    iget-object v2, v2, Lcom/cyjh/elfin/entity/GameSwitchInfo;->Path:Ljava/lang/String;

    invoke-static {p0, v1, v2}, Lcom/cyjh/elfin/util/IntentUtils;->toCallWebGamesActivity(Landroid/content/Context;Ljava/lang/String;Ljava/lang/String;)V

    goto :goto_0

    .line 333
    nop

    :pswitch_data_0
    .packed-switch 0x7f0f0078
        :pswitch_1
        :pswitch_2
        :pswitch_0
        :pswitch_0
        :pswitch_3
    .end packed-switch
.end method

.method protected onCreate(Landroid/os/Bundle;)V
    .locals 2
    .param p1, "savedInstanceState"    # Landroid/os/Bundle;

    .prologue
    .line 123
    invoke-super {p0, p1}, Lcom/cyjh/elfin/activity/BaseActivity;->onCreate(Landroid/os/Bundle;)V

    .line 124
    const v0, 0x7f040021

    invoke-virtual {p0, v0}, Lcom/cyjh/elfin/activity/ElfinFreeActivity;->setContentView(I)V

    .line 125
    const-string v0, "zzz"

    const-string v1, "MainActivity-------onCreate"

    invoke-static {v0, v1}, Landroid/util/Log;->e(Ljava/lang/String;Ljava/lang/String;)I

    .line 126
    invoke-virtual {p0}, Lcom/cyjh/elfin/activity/ElfinFreeActivity;->getApplicationContext()Landroid/content/Context;

    move-result-object v0

    check-cast v0, Lcom/cyjh/elfin/AppContext;

    iput-object v0, p0, Lcom/cyjh/elfin/activity/ElfinFreeActivity;->appContext:Lcom/cyjh/elfin/AppContext;

    .line 127
    invoke-static {}, Lcom/cyjh/mobileanjian/ipc/MqRunner;->getInstance()Lcom/cyjh/mobileanjian/ipc/MqRunner;

    move-result-object v0

    new-instance v1, Lcom/cyjh/mobileanjian/ipc/stuff/Script4Run;

    invoke-direct {v1}, Lcom/cyjh/mobileanjian/ipc/stuff/Script4Run;-><init>()V

    invoke-virtual {v0, v1}, Lcom/cyjh/mobileanjian/ipc/MqRunner;->setScript(Lcom/cyjh/mobileanjian/ipc/stuff/Script4Run;)Lcom/cyjh/mobileanjian/ipc/MqRunner;

    .line 128
    invoke-static {}, Lcom/cyjh/elfin/AppContext;->getInstance()Lcom/cyjh/elfin/AppContext;

    move-result-object v0

    invoke-virtual {v0}, Lcom/cyjh/elfin/AppContext;->initParams()V

    .line 129
    iget-object v0, p0, Lcom/cyjh/elfin/activity/ElfinFreeActivity;->appContext:Lcom/cyjh/elfin/AppContext;

    const/4 v1, 0x2

    iput v1, v0, Lcom/cyjh/elfin/AppContext;->isVerifyPass:I

    .line 130
    new-instance v0, Lcom/cyjh/elfin/mvp/presenters/RecommendGamesPresenter;

    invoke-direct {v0, p0}, Lcom/cyjh/elfin/mvp/presenters/RecommendGamesPresenter;-><init>(Lcom/cyjh/elfin/mvp/views/RecommendGamesView;)V

    iput-object v0, p0, Lcom/cyjh/elfin/activity/ElfinFreeActivity;->recommendGamesPresenter:Lcom/cyjh/elfin/mvp/presenters/RecommendGamesPresenter;

    .line 131
    iget-object v0, p0, Lcom/cyjh/elfin/activity/ElfinFreeActivity;->appContext:Lcom/cyjh/elfin/AppContext;

    iget-object v0, v0, Lcom/cyjh/elfin/AppContext;->mUipHelper:Lcom/cyjh/mobileanjian/ipc/uip/UipHelper;

    if-nez v0, :cond_0

    .line 132
    iget-object v0, p0, Lcom/cyjh/elfin/activity/ElfinFreeActivity;->appContext:Lcom/cyjh/elfin/AppContext;

    new-instance v1, Lcom/cyjh/mobileanjian/ipc/uip/UipHelper;

    invoke-direct {v1, p0}, Lcom/cyjh/mobileanjian/ipc/uip/UipHelper;-><init>(Landroid/content/Context;)V

    iput-object v1, v0, Lcom/cyjh/elfin/AppContext;->mUipHelper:Lcom/cyjh/mobileanjian/ipc/uip/UipHelper;

    .line 134
    :cond_0
    invoke-direct {p0}, Lcom/cyjh/elfin/activity/ElfinFreeActivity;->initDatabase()V

    .line 135
    invoke-direct {p0}, Lcom/cyjh/elfin/activity/ElfinFreeActivity;->initView()V

    .line 136
    invoke-static {p0}, Lcom/cyjh/elfin/util/NetworkUtils;->isAvailable(Landroid/content/Context;)Z

    move-result v0

    if-eqz v0, :cond_2

    .line 137
    iget-object v0, p0, Lcom/cyjh/elfin/activity/ElfinFreeActivity;->pushMessagePresenter:Lcom/cyjh/elfin/mvp/presenters/PushMessagePresenter;

    if-nez v0, :cond_1

    .line 138
    new-instance v0, Lcom/cyjh/elfin/mvp/presenters/PushMessagePresenter;

    invoke-direct {v0, p0, p0}, Lcom/cyjh/elfin/mvp/presenters/PushMessagePresenter;-><init>(Lcom/cyjh/elfin/mvp/views/PushMessageView;Landroid/content/Context;)V

    iput-object v0, p0, Lcom/cyjh/elfin/activity/ElfinFreeActivity;->pushMessagePresenter:Lcom/cyjh/elfin/mvp/presenters/PushMessagePresenter;

    .line 139
    iget-object v0, p0, Lcom/cyjh/elfin/activity/ElfinFreeActivity;->pushMessagePresenter:Lcom/cyjh/elfin/mvp/presenters/PushMessagePresenter;

    iget-object v1, p0, Lcom/cyjh/elfin/activity/ElfinFreeActivity;->appContext:Lcom/cyjh/elfin/AppContext;

    invoke-virtual {v1}, Lcom/cyjh/elfin/AppContext;->getMobileIMIE()Ljava/lang/String;

    move-result-object v1

    invoke-virtual {v0, v1}, Lcom/cyjh/elfin/mvp/presenters/PushMessagePresenter;->acquireMessagePush(Ljava/lang/String;)V

    .line 141
    :cond_1
    invoke-static {}, Lcom/cyjh/elfin/mvp/managers/UpdateVersionManager;->builder()Lcom/cyjh/elfin/mvp/managers/UpdateVersionManager;

    move-result-object v0

    const/4 v1, 0x0

    invoke-virtual {v0, v1}, Lcom/cyjh/elfin/mvp/managers/UpdateVersionManager;->setDismissBack(Lcom/cyjh/elfin/mvp/managers/UpdateVersionManager$OnUpdateVersionBack;)Lcom/cyjh/elfin/mvp/managers/UpdateVersionManager;

    move-result-object v0

    const/4 v1, 0x0

    invoke-virtual {v0, v1, p0}, Lcom/cyjh/elfin/mvp/managers/UpdateVersionManager;->updateVersion(ZLandroid/content/Context;)V

    .line 144
    :cond_2
    return-void
.end method

.method protected onDestroy()V
    .locals 2

    .prologue
    .line 282
    invoke-super {p0}, Lcom/cyjh/elfin/activity/BaseActivity;->onDestroy()V

    .line 283
    invoke-static {}, Lcom/cyjh/elfin/AppContext;->getInstance()Lcom/cyjh/elfin/AppContext;

    move-result-object v0

    const/4 v1, 0x0

    iput-boolean v1, v0, Lcom/cyjh/elfin/AppContext;->isLoadBottomAd:Z

    .line 284
    iget-object v0, p0, Lcom/cyjh/elfin/activity/ElfinFreeActivity;->mHandler:Lcom/cyjh/elfin/activity/ElfinFreeActivity$MainHandler;

    const/4 v1, 0x0

    invoke-virtual {v0, v1}, Lcom/cyjh/elfin/activity/ElfinFreeActivity$MainHandler;->removeCallbacksAndMessages(Ljava/lang/Object;)V

    .line 285
    invoke-static {}, Lcom/cyjh/elfin/database/MsgDatabaseOpera;->getInstance()Lcom/cyjh/elfin/database/MsgDatabaseOpera;

    move-result-object v0

    invoke-virtual {v0}, Lcom/cyjh/elfin/database/MsgDatabaseOpera;->closeDatabaseHelper()V

    .line 286
    invoke-static {}, Lorg/greenrobot/eventbus/EventBus;->getDefault()Lorg/greenrobot/eventbus/EventBus;

    move-result-object v0

    invoke-virtual {v0, p0}, Lorg/greenrobot/eventbus/EventBus;->unregister(Ljava/lang/Object;)V

    .line 287
    invoke-static {}, Lcom/cyjh/elfin/net/volley/VolleyManager;->cancelAllReq()V

    .line 288
    iget-object v0, p0, Lcom/cyjh/elfin/activity/ElfinFreeActivity;->pushMessagePresenter:Lcom/cyjh/elfin/mvp/presenters/PushMessagePresenter;

    if-eqz v0, :cond_0

    .line 289
    iget-object v0, p0, Lcom/cyjh/elfin/activity/ElfinFreeActivity;->pushMessagePresenter:Lcom/cyjh/elfin/mvp/presenters/PushMessagePresenter;

    invoke-virtual {v0}, Lcom/cyjh/elfin/mvp/presenters/PushMessagePresenter;->onStopRequest()V

    .line 291
    :cond_0
    invoke-direct {p0}, Lcom/cyjh/elfin/activity/ElfinFreeActivity;->exit()V

    .line 292
    return-void
.end method

.method public onMessageMainThread(Lcom/cyjh/elfin/entity/MsgItem;)V
    .locals 2
    .param p1, "msgItem"    # Lcom/cyjh/elfin/entity/MsgItem;
    .annotation runtime Lorg/greenrobot/eventbus/Subscribe;
        threadMode = .enum Lorg/greenrobot/eventbus/ThreadMode;->MAIN:Lorg/greenrobot/eventbus/ThreadMode;
    .end annotation

    .prologue
    .line 371
    invoke-virtual {p1}, Lcom/cyjh/elfin/entity/MsgItem;->getMsgType()I

    move-result v0

    packed-switch v0, :pswitch_data_0

    .line 384
    :goto_0
    :pswitch_0
    return-void

    .line 374
    :pswitch_1
    iget-object v0, p0, Lcom/cyjh/elfin/activity/ElfinFreeActivity;->mImgRedDot:Landroid/widget/ImageView;

    const/4 v1, 0x4

    invoke-virtual {v0, v1}, Landroid/widget/ImageView;->setVisibility(I)V

    goto :goto_0

    .line 378
    :pswitch_2
    iget-object v0, p0, Lcom/cyjh/elfin/activity/ElfinFreeActivity;->msgDataList:Ljava/util/ArrayList;

    invoke-virtual {v0}, Ljava/util/ArrayList;->clear()V

    .line 379
    invoke-static {}, Lcom/cyjh/elfin/database/MsgDatabaseOpera;->getInstance()Lcom/cyjh/elfin/database/MsgDatabaseOpera;

    move-result-object v0

    invoke-virtual {v0}, Lcom/cyjh/elfin/database/MsgDatabaseOpera;->deleteAll()V

    goto :goto_0

    .line 371
    :pswitch_data_0
    .packed-switch 0x3e9
        :pswitch_1
        :pswitch_0
        :pswitch_2
    .end packed-switch
.end method

.method public onPause()V
    .locals 0

    .prologue
    .line 188
    invoke-super {p0}, Lcom/cyjh/elfin/activity/BaseActivity;->onPause()V

    .line 189
    invoke-static {p0}, Lcom/umeng/analytics/MobclickAgent;->onPause(Landroid/content/Context;)V

    .line 190
    return-void
.end method

.method public onResume()V
    .locals 3

    .prologue
    const/4 v2, 0x1

    .line 170
    invoke-super {p0}, Lcom/cyjh/elfin/activity/BaseActivity;->onResume()V

    .line 171
    invoke-static {}, Lcom/cyjh/elfin/AppContext;->getInstance()Lcom/cyjh/elfin/AppContext;

    move-result-object v0

    iget-boolean v0, v0, Lcom/cyjh/elfin/AppContext;->isOnclickXunFei:Z

    if-eqz v0, :cond_0

    .line 172
    const-string v0, "zzz"

    const-string v1, "ElfinFreeActivity--onResume()--"

    invoke-static {v0, v1}, Landroid/util/Log;->e(Ljava/lang/String;Ljava/lang/String;)I

    .line 173
    invoke-static {}, Lcom/cyjh/elfin/AppContext;->getInstance()Lcom/cyjh/elfin/AppContext;

    move-result-object v0

    const/4 v1, 0x0

    iput-boolean v1, v0, Lcom/cyjh/elfin/AppContext;->isOnclickXunFei:Z

    .line 174
    invoke-virtual {p0, v2}, Lcom/cyjh/elfin/activity/ElfinFreeActivity;->moveTaskToBack(Z)Z

    .line 184
    :goto_0
    return-void

    .line 178
    :cond_0
    invoke-static {p0}, Lcom/umeng/analytics/MobclickAgent;->onResume(Landroid/content/Context;)V

    .line 179
    iget-object v0, p0, Lcom/cyjh/elfin/activity/ElfinFreeActivity;->recommendGamesPresenter:Lcom/cyjh/elfin/mvp/presenters/RecommendGamesPresenter;

    invoke-virtual {v0, p0}, Lcom/cyjh/elfin/mvp/presenters/RecommendGamesPresenter;->gameJumpSwitch(Landroid/content/Context;)V

    .line 180
    iget-boolean v0, p0, Lcom/cyjh/elfin/activity/ElfinFreeActivity;->isFirstPushMessage:Z

    if-eqz v0, :cond_1

    iget-object v0, p0, Lcom/cyjh/elfin/activity/ElfinFreeActivity;->pushMessagePresenter:Lcom/cyjh/elfin/mvp/presenters/PushMessagePresenter;

    if-eqz v0, :cond_1

    .line 181
    iget-object v0, p0, Lcom/cyjh/elfin/activity/ElfinFreeActivity;->pushMessagePresenter:Lcom/cyjh/elfin/mvp/presenters/PushMessagePresenter;

    iget-object v1, p0, Lcom/cyjh/elfin/activity/ElfinFreeActivity;->appContext:Lcom/cyjh/elfin/AppContext;

    invoke-virtual {v1}, Lcom/cyjh/elfin/AppContext;->getMobileIMIE()Ljava/lang/String;

    move-result-object v1

    invoke-virtual {v0, v1}, Lcom/cyjh/elfin/mvp/presenters/PushMessagePresenter;->acquireMessagePush(Ljava/lang/String;)V

    .line 183
    :cond_1
    iput-boolean v2, p0, Lcom/cyjh/elfin/activity/ElfinFreeActivity;->isFirstPushMessage:Z

    goto :goto_0
.end method

.method public onSuccessfulAcquireNews(Ljava/util/List;)V
    .locals 3
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "(",
            "Ljava/util/List",
            "<",
            "Lcom/cyjh/elfin/entity/NotifyMsgBean;",
            ">;)V"
        }
    .end annotation

    .prologue
    .local p1, "partDatas":Ljava/util/List;, "Ljava/util/List<Lcom/cyjh/elfin/entity/NotifyMsgBean;>;"
    const/4 v2, 0x0

    .line 423
    iget-object v0, p0, Lcom/cyjh/elfin/activity/ElfinFreeActivity;->msgPartDataList:Ljava/util/ArrayList;

    invoke-virtual {v0}, Ljava/util/ArrayList;->clear()V

    .line 424
    iget-object v0, p0, Lcom/cyjh/elfin/activity/ElfinFreeActivity;->msgPartDataList:Ljava/util/ArrayList;

    invoke-virtual {v0, p1}, Ljava/util/ArrayList;->addAll(Ljava/util/Collection;)Z

    .line 426
    iget-object v1, p0, Lcom/cyjh/elfin/activity/ElfinFreeActivity;->msgIdList:Ljava/util/List;

    iget-object v0, p0, Lcom/cyjh/elfin/activity/ElfinFreeActivity;->msgPartDataList:Ljava/util/ArrayList;

    invoke-virtual {v0, v2}, Ljava/util/ArrayList;->get(I)Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Lcom/cyjh/elfin/entity/NotifyMsgBean;

    iget-object v0, v0, Lcom/cyjh/elfin/entity/NotifyMsgBean;->ID:Ljava/lang/String;

    invoke-interface {v1, v0}, Ljava/util/List;->contains(Ljava/lang/Object;)Z

    move-result v0

    if-nez v0, :cond_0

    .line 427
    iget-object v0, p0, Lcom/cyjh/elfin/activity/ElfinFreeActivity;->msgDataList:Ljava/util/ArrayList;

    iget-object v1, p0, Lcom/cyjh/elfin/activity/ElfinFreeActivity;->msgPartDataList:Ljava/util/ArrayList;

    invoke-virtual {v0, v2, v1}, Ljava/util/ArrayList;->addAll(ILjava/util/Collection;)Z

    .line 428
    iget-object v0, p0, Lcom/cyjh/elfin/activity/ElfinFreeActivity;->mHandler:Lcom/cyjh/elfin/activity/ElfinFreeActivity$MainHandler;

    const/16 v1, 0x3ea

    invoke-virtual {v0, v1}, Lcom/cyjh/elfin/activity/ElfinFreeActivity$MainHandler;->obtainMessage(I)Landroid/os/Message;

    move-result-object v0

    invoke-virtual {v0}, Landroid/os/Message;->sendToTarget()V

    .line 430
    :cond_0
    return-void
.end method
