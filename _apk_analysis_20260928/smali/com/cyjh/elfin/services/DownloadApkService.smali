.class public Lcom/cyjh/elfin/services/DownloadApkService;
.super Lcom/cyjh/elfin/services/BaseService;
.source "DownloadApkService.java"


# static fields
.field public static final GAMES_APK_URL:Ljava/lang/String; = "games_apk_url"

.field private static final NID:I = 0x133c64e

.field public static final YDXJL_DOWNLOAD_APK:Ljava/lang/String; = "ydxjl.apk"


# instance fields
.field private mBuilder:Landroid/support/v4/app/NotificationCompat$Builder;

.field private mNotifyManager:Landroid/app/NotificationManager;


# direct methods
.method public constructor <init>()V
    .locals 0

    .prologue
    .line 30
    invoke-direct {p0}, Lcom/cyjh/elfin/services/BaseService;-><init>()V

    return-void
.end method

.method static synthetic access$000(Lcom/cyjh/elfin/services/DownloadApkService;)Landroid/support/v4/app/NotificationCompat$Builder;
    .locals 1
    .param p0, "x0"    # Lcom/cyjh/elfin/services/DownloadApkService;

    .prologue
    .line 30
    iget-object v0, p0, Lcom/cyjh/elfin/services/DownloadApkService;->mBuilder:Landroid/support/v4/app/NotificationCompat$Builder;

    return-object v0
.end method

.method static synthetic access$100(Lcom/cyjh/elfin/services/DownloadApkService;)Landroid/app/NotificationManager;
    .locals 1
    .param p0, "x0"    # Lcom/cyjh/elfin/services/DownloadApkService;

    .prologue
    .line 30
    iget-object v0, p0, Lcom/cyjh/elfin/services/DownloadApkService;->mNotifyManager:Landroid/app/NotificationManager;

    return-object v0
.end method

.method private downloadApk(Ljava/lang/String;Ljava/lang/String;)V
    .locals 4
    .param p1, "downloadUrl"    # Ljava/lang/String;
    .param p2, "apkName"    # Ljava/lang/String;

    .prologue
    .line 60
    new-instance v0, Ljava/io/File;

    invoke-static {p0}, Lcom/cyjh/elfin/constant/Constants;->getApkPath(Landroid/content/Context;)Ljava/lang/String;

    move-result-object v1

    invoke-direct {v0, v1, p2}, Ljava/io/File;-><init>(Ljava/lang/String;Ljava/lang/String;)V

    .line 61
    .local v0, "file":Ljava/io/File;
    invoke-static {p0}, Lcom/cyjh/elfin/net/xutils/XUtilsHttpClient;->getInstence(Landroid/content/Context;)Lcom/lidroid/xutils/HttpUtils;

    move-result-object v1

    invoke-virtual {v0}, Ljava/io/File;->getAbsolutePath()Ljava/lang/String;

    move-result-object v2

    new-instance v3, Lcom/cyjh/elfin/services/DownloadApkService$1;

    invoke-direct {v3, p0, v0}, Lcom/cyjh/elfin/services/DownloadApkService$1;-><init>(Lcom/cyjh/elfin/services/DownloadApkService;Ljava/io/File;)V

    invoke-virtual {v1, p1, v2, v3}, Lcom/lidroid/xutils/HttpUtils;->download(Ljava/lang/String;Ljava/lang/String;Lcom/lidroid/xutils/http/callback/RequestCallBack;)Lcom/lidroid/xutils/http/HttpHandler;

    .line 97
    return-void
.end method

.method private initNotification()V
    .locals 2

    .prologue
    .line 52
    const-string v0, "notification"

    invoke-virtual {p0, v0}, Lcom/cyjh/elfin/services/DownloadApkService;->getSystemService(Ljava/lang/String;)Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Landroid/app/NotificationManager;

    iput-object v0, p0, Lcom/cyjh/elfin/services/DownloadApkService;->mNotifyManager:Landroid/app/NotificationManager;

    .line 53
    new-instance v0, Landroid/support/v4/app/NotificationCompat$Builder;

    invoke-direct {v0, p0}, Landroid/support/v4/app/NotificationCompat$Builder;-><init>(Landroid/content/Context;)V

    iput-object v0, p0, Lcom/cyjh/elfin/services/DownloadApkService;->mBuilder:Landroid/support/v4/app/NotificationCompat$Builder;

    .line 54
    iget-object v0, p0, Lcom/cyjh/elfin/services/DownloadApkService;->mBuilder:Landroid/support/v4/app/NotificationCompat$Builder;

    const-string v1, "\u4e0b\u8f7d"

    invoke-virtual {v0, v1}, Landroid/support/v4/app/NotificationCompat$Builder;->setContentTitle(Ljava/lang/CharSequence;)Landroid/support/v4/app/NotificationCompat$Builder;

    move-result-object v0

    const v1, 0x7f080036

    .line 55
    invoke-virtual {p0, v1}, Lcom/cyjh/elfin/services/DownloadApkService;->getString(I)Ljava/lang/String;

    move-result-object v1

    invoke-virtual {v0, v1}, Landroid/support/v4/app/NotificationCompat$Builder;->setContentText(Ljava/lang/CharSequence;)Landroid/support/v4/app/NotificationCompat$Builder;

    move-result-object v0

    const v1, 0x7f020098

    .line 56
    invoke-virtual {v0, v1}, Landroid/support/v4/app/NotificationCompat$Builder;->setSmallIcon(I)Landroid/support/v4/app/NotificationCompat$Builder;

    .line 57
    return-void
.end method


# virtual methods
.method public onBind(Landroid/content/Intent;)Landroid/os/IBinder;
    .locals 1
    .param p1, "intent"    # Landroid/content/Intent;
    .annotation build Landroid/support/annotation/Nullable;
    .end annotation

    .prologue
    .line 40
    const/4 v0, 0x0

    return-object v0
.end method

.method public onDestroy()V
    .locals 2

    .prologue
    .line 101
    invoke-super {p0}, Lcom/cyjh/elfin/services/BaseService;->onDestroy()V

    .line 102
    iget-object v0, p0, Lcom/cyjh/elfin/services/DownloadApkService;->commonLog:Lcom/cyjh/elfin/log/CommonLog;

    const-string v1, "download games apk stop service"

    invoke-virtual {v0, v1}, Lcom/cyjh/elfin/log/CommonLog;->e(Ljava/lang/Object;)V

    .line 103
    iget-object v0, p0, Lcom/cyjh/elfin/services/DownloadApkService;->mNotifyManager:Landroid/app/NotificationManager;

    const v1, 0x133c64e

    invoke-virtual {v0, v1}, Landroid/app/NotificationManager;->cancel(I)V

    .line 104
    return-void
.end method

.method public onStartCommand(Landroid/content/Intent;II)I
    .locals 2
    .param p1, "intent"    # Landroid/content/Intent;
    .param p2, "flags"    # I
    .param p3, "startId"    # I

    .prologue
    .line 45
    const-string v1, "games_apk_url"

    invoke-virtual {p1, v1}, Landroid/content/Intent;->getStringExtra(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v0

    .line 46
    .local v0, "url":Ljava/lang/String;
    invoke-direct {p0}, Lcom/cyjh/elfin/services/DownloadApkService;->initNotification()V

    .line 47
    const-string v1, "ydxjl.apk"

    invoke-direct {p0, v0, v1}, Lcom/cyjh/elfin/services/DownloadApkService;->downloadApk(Ljava/lang/String;Ljava/lang/String;)V

    .line 48
    invoke-super {p0, p1, p2, p3}, Lcom/cyjh/elfin/services/BaseService;->onStartCommand(Landroid/content/Intent;II)I

    move-result v1

    return v1
.end method
