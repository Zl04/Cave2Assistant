.class public Lcom/cyjh/elfin/services/DownloadService;
.super Landroid/app/Service;
.source "DownloadService.java"


# annotations
.annotation system Ldalvik/annotation/MemberClasses;
    value = {
        Lcom/cyjh/elfin/services/DownloadService$DownloadRequestCallBack;
    }
.end annotation


# static fields
.field private static final HONEYCOMB_PACAKGE:Ljava/lang/String; = "com.cyjh.gundam"

.field private static final NID:I = 0x1337959

.field private static final URL_HONEYCOMB:Ljava/lang/String; = "http://m.anjian.com/help/jiaoben/yxfwaj.apk"


# instance fields
.field private mBuilder:Landroid/support/v4/app/NotificationCompat$Builder;

.field private mNotifyManager:Landroid/app/NotificationManager;


# direct methods
.method public constructor <init>()V
    .locals 0

    .prologue
    .line 21
    invoke-direct {p0}, Landroid/app/Service;-><init>()V

    return-void
.end method

.method static synthetic access$000(Lcom/cyjh/elfin/services/DownloadService;)Landroid/support/v4/app/NotificationCompat$Builder;
    .locals 1
    .param p0, "x0"    # Lcom/cyjh/elfin/services/DownloadService;

    .prologue
    .line 21
    iget-object v0, p0, Lcom/cyjh/elfin/services/DownloadService;->mBuilder:Landroid/support/v4/app/NotificationCompat$Builder;

    return-object v0
.end method

.method static synthetic access$100(Lcom/cyjh/elfin/services/DownloadService;)Landroid/app/NotificationManager;
    .locals 1
    .param p0, "x0"    # Lcom/cyjh/elfin/services/DownloadService;

    .prologue
    .line 21
    iget-object v0, p0, Lcom/cyjh/elfin/services/DownloadService;->mNotifyManager:Landroid/app/NotificationManager;

    return-object v0
.end method


# virtual methods
.method public onBind(Landroid/content/Intent;)Landroid/os/IBinder;
    .locals 1
    .param p1, "intent"    # Landroid/content/Intent;

    .prologue
    .line 33
    const/4 v0, 0x0

    return-object v0
.end method

.method public onStartCommand(Landroid/content/Intent;II)I
    .locals 8
    .param p1, "intent"    # Landroid/content/Intent;
    .param p2, "flags"    # I
    .param p3, "startId"    # I

    .prologue
    const/4 v3, 0x0

    const/4 v4, 0x0

    .line 38
    new-instance v7, Ljava/io/File;

    invoke-static {}, Landroid/os/Environment;->getExternalStorageDirectory()Ljava/io/File;

    move-result-object v0

    const-string v1, "youxifengwo.apk"

    invoke-direct {v7, v0, v1}, Ljava/io/File;-><init>(Ljava/io/File;Ljava/lang/String;)V

    .line 39
    .local v7, "file":Ljava/io/File;
    invoke-static {p0}, Lcom/cyjh/elfin/net/xutils/XUtilsHttpClient;->getInstence(Landroid/content/Context;)Lcom/lidroid/xutils/HttpUtils;

    move-result-object v0

    const-string v1, "http://m.anjian.com/help/jiaoben/yxfwaj.apk"

    invoke-virtual {v7}, Ljava/io/File;->getAbsolutePath()Ljava/lang/String;

    move-result-object v2

    move v5, v4

    move-object v6, v3

    invoke-virtual/range {v0 .. v6}, Lcom/lidroid/xutils/HttpUtils;->download(Ljava/lang/String;Ljava/lang/String;Lcom/lidroid/xutils/http/RequestParams;ZZLcom/lidroid/xutils/http/callback/RequestCallBack;)Lcom/lidroid/xutils/http/HttpHandler;

    .line 42
    invoke-super {p0, p1, p2, p3}, Landroid/app/Service;->onStartCommand(Landroid/content/Intent;II)I

    move-result v0

    return v0
.end method
