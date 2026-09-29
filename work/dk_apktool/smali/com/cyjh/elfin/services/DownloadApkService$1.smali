.class Lcom/cyjh/elfin/services/DownloadApkService$1;
.super Lcom/lidroid/xutils/http/callback/RequestCallBack;
.source "DownloadApkService.java"


# annotations
.annotation system Ldalvik/annotation/EnclosingMethod;
    value = Lcom/cyjh/elfin/services/DownloadApkService;->downloadApk(Ljava/lang/String;Ljava/lang/String;)V
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x0
    name = null
.end annotation

.annotation system Ldalvik/annotation/Signature;
    value = {
        "Lcom/lidroid/xutils/http/callback/RequestCallBack",
        "<",
        "Ljava/io/File;",
        ">;"
    }
.end annotation


# instance fields
.field final synthetic this$0:Lcom/cyjh/elfin/services/DownloadApkService;

.field final synthetic val$file:Ljava/io/File;


# direct methods
.method constructor <init>(Lcom/cyjh/elfin/services/DownloadApkService;Ljava/io/File;)V
    .locals 0
    .param p1, "this$0"    # Lcom/cyjh/elfin/services/DownloadApkService;

    .prologue
    .line 61
    iput-object p1, p0, Lcom/cyjh/elfin/services/DownloadApkService$1;->this$0:Lcom/cyjh/elfin/services/DownloadApkService;

    iput-object p2, p0, Lcom/cyjh/elfin/services/DownloadApkService$1;->val$file:Ljava/io/File;

    invoke-direct {p0}, Lcom/lidroid/xutils/http/callback/RequestCallBack;-><init>()V

    return-void
.end method


# virtual methods
.method public onFailure(Lcom/lidroid/xutils/exception/HttpException;Ljava/lang/String;)V
    .locals 3
    .param p1, "e"    # Lcom/lidroid/xutils/exception/HttpException;
    .param p2, "s"    # Ljava/lang/String;

    .prologue
    .line 76
    iget-object v0, p0, Lcom/cyjh/elfin/services/DownloadApkService$1;->this$0:Lcom/cyjh/elfin/services/DownloadApkService;

    iget-object v0, v0, Lcom/cyjh/elfin/services/DownloadApkService;->commonLog:Lcom/cyjh/elfin/log/CommonLog;

    const-string v1, "Download fail!"

    invoke-virtual {v0, v1}, Lcom/cyjh/elfin/log/CommonLog;->e(Ljava/lang/Object;)V

    .line 77
    invoke-static {}, Lorg/greenrobot/eventbus/EventBus;->getDefault()Lorg/greenrobot/eventbus/EventBus;

    move-result-object v0

    new-instance v1, Lcom/cyjh/elfin/entity/MsgItem;

    const/16 v2, 0x3f2

    invoke-direct {v1, v2}, Lcom/cyjh/elfin/entity/MsgItem;-><init>(I)V

    invoke-virtual {v0, v1}, Lorg/greenrobot/eventbus/EventBus;->post(Ljava/lang/Object;)V

    .line 78
    return-void
.end method

.method public onLoading(JJZ)V
    .locals 5
    .param p1, "total"    # J
    .param p3, "current"    # J
    .param p5, "isUploading"    # Z

    .prologue
    .line 91
    invoke-super/range {p0 .. p5}, Lcom/lidroid/xutils/http/callback/RequestCallBack;->onLoading(JJZ)V

    .line 92
    const-wide/16 v2, 0x64

    mul-long/2addr v2, p3

    div-long/2addr v2, p1

    long-to-int v0, v2

    .line 93
    .local v0, "progress":I
    iget-object v1, p0, Lcom/cyjh/elfin/services/DownloadApkService$1;->this$0:Lcom/cyjh/elfin/services/DownloadApkService;

    invoke-static {v1}, Lcom/cyjh/elfin/services/DownloadApkService;->access$000(Lcom/cyjh/elfin/services/DownloadApkService;)Landroid/support/v4/app/NotificationCompat$Builder;

    move-result-object v1

    const/16 v2, 0x64

    const/4 v3, 0x0

    invoke-virtual {v1, v2, v0, v3}, Landroid/support/v4/app/NotificationCompat$Builder;->setProgress(IIZ)Landroid/support/v4/app/NotificationCompat$Builder;

    .line 94
    iget-object v1, p0, Lcom/cyjh/elfin/services/DownloadApkService$1;->this$0:Lcom/cyjh/elfin/services/DownloadApkService;

    invoke-static {v1}, Lcom/cyjh/elfin/services/DownloadApkService;->access$100(Lcom/cyjh/elfin/services/DownloadApkService;)Landroid/app/NotificationManager;

    move-result-object v1

    const v2, 0x133c64e

    iget-object v3, p0, Lcom/cyjh/elfin/services/DownloadApkService$1;->this$0:Lcom/cyjh/elfin/services/DownloadApkService;

    invoke-static {v3}, Lcom/cyjh/elfin/services/DownloadApkService;->access$000(Lcom/cyjh/elfin/services/DownloadApkService;)Landroid/support/v4/app/NotificationCompat$Builder;

    move-result-object v3

    invoke-virtual {v3}, Landroid/support/v4/app/NotificationCompat$Builder;->build()Landroid/app/Notification;

    move-result-object v3

    invoke-virtual {v1, v2, v3}, Landroid/app/NotificationManager;->notify(ILandroid/app/Notification;)V

    .line 95
    return-void
.end method

.method public onStart()V
    .locals 4

    .prologue
    const/4 v3, 0x0

    .line 82
    invoke-super {p0}, Lcom/lidroid/xutils/http/callback/RequestCallBack;->onStart()V

    .line 83
    iget-object v0, p0, Lcom/cyjh/elfin/services/DownloadApkService$1;->this$0:Lcom/cyjh/elfin/services/DownloadApkService;

    iget-object v0, v0, Lcom/cyjh/elfin/services/DownloadApkService;->commonLog:Lcom/cyjh/elfin/log/CommonLog;

    const-string v1, "\u5f00\u59cb\u4e0b\u8f7d>>>"

    invoke-virtual {v0, v1}, Lcom/cyjh/elfin/log/CommonLog;->e(Ljava/lang/Object;)V

    .line 84
    iget-object v0, p0, Lcom/cyjh/elfin/services/DownloadApkService$1;->this$0:Lcom/cyjh/elfin/services/DownloadApkService;

    iget-object v1, p0, Lcom/cyjh/elfin/services/DownloadApkService$1;->this$0:Lcom/cyjh/elfin/services/DownloadApkService;

    const v2, 0x7f080036

    invoke-virtual {v1, v2}, Lcom/cyjh/elfin/services/DownloadApkService;->getString(I)Ljava/lang/String;

    move-result-object v1

    invoke-static {v0, v1}, Lcom/cyjh/elfin/util/ToastUtils;->showToastLong(Landroid/content/Context;Ljava/lang/String;)V

    .line 85
    iget-object v0, p0, Lcom/cyjh/elfin/services/DownloadApkService$1;->this$0:Lcom/cyjh/elfin/services/DownloadApkService;

    invoke-static {v0}, Lcom/cyjh/elfin/services/DownloadApkService;->access$000(Lcom/cyjh/elfin/services/DownloadApkService;)Landroid/support/v4/app/NotificationCompat$Builder;

    move-result-object v0

    const/16 v1, 0x64

    invoke-virtual {v0, v1, v3, v3}, Landroid/support/v4/app/NotificationCompat$Builder;->setProgress(IIZ)Landroid/support/v4/app/NotificationCompat$Builder;

    .line 86
    iget-object v0, p0, Lcom/cyjh/elfin/services/DownloadApkService$1;->this$0:Lcom/cyjh/elfin/services/DownloadApkService;

    invoke-static {v0}, Lcom/cyjh/elfin/services/DownloadApkService;->access$100(Lcom/cyjh/elfin/services/DownloadApkService;)Landroid/app/NotificationManager;

    move-result-object v0

    const v1, 0x133c64e

    iget-object v2, p0, Lcom/cyjh/elfin/services/DownloadApkService$1;->this$0:Lcom/cyjh/elfin/services/DownloadApkService;

    invoke-static {v2}, Lcom/cyjh/elfin/services/DownloadApkService;->access$000(Lcom/cyjh/elfin/services/DownloadApkService;)Landroid/support/v4/app/NotificationCompat$Builder;

    move-result-object v2

    invoke-virtual {v2}, Landroid/support/v4/app/NotificationCompat$Builder;->build()Landroid/app/Notification;

    move-result-object v2

    invoke-virtual {v0, v1, v2}, Landroid/app/NotificationManager;->notify(ILandroid/app/Notification;)V

    .line 87
    return-void
.end method

.method public onSuccess(Lcom/lidroid/xutils/http/ResponseInfo;)V
    .locals 5
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "(",
            "Lcom/lidroid/xutils/http/ResponseInfo",
            "<",
            "Ljava/io/File;",
            ">;)V"
        }
    .end annotation

    .prologue
    .local p1, "responseInfo":Lcom/lidroid/xutils/http/ResponseInfo;, "Lcom/lidroid/xutils/http/ResponseInfo<Ljava/io/File;>;"
    const v4, 0x133c64e

    const/16 v3, 0x64

    .line 64
    iget-object v0, p0, Lcom/cyjh/elfin/services/DownloadApkService$1;->this$0:Lcom/cyjh/elfin/services/DownloadApkService;

    iget-object v0, v0, Lcom/cyjh/elfin/services/DownloadApkService;->commonLog:Lcom/cyjh/elfin/log/CommonLog;

    const-string v1, "\u4e0b\u8f7donSuccess>>>"

    invoke-virtual {v0, v1}, Lcom/cyjh/elfin/log/CommonLog;->e(Ljava/lang/Object;)V

    .line 65
    invoke-static {}, Lorg/greenrobot/eventbus/EventBus;->getDefault()Lorg/greenrobot/eventbus/EventBus;

    move-result-object v0

    new-instance v1, Lcom/cyjh/elfin/entity/MsgItem;

    const/16 v2, 0x3f2

    invoke-direct {v1, v2}, Lcom/cyjh/elfin/entity/MsgItem;-><init>(I)V

    invoke-virtual {v0, v1}, Lorg/greenrobot/eventbus/EventBus;->post(Ljava/lang/Object;)V

    .line 66
    iget-object v0, p0, Lcom/cyjh/elfin/services/DownloadApkService$1;->this$0:Lcom/cyjh/elfin/services/DownloadApkService;

    invoke-static {v0}, Lcom/cyjh/elfin/services/DownloadApkService;->access$000(Lcom/cyjh/elfin/services/DownloadApkService;)Landroid/support/v4/app/NotificationCompat$Builder;

    move-result-object v0

    const/4 v1, 0x0

    invoke-virtual {v0, v3, v3, v1}, Landroid/support/v4/app/NotificationCompat$Builder;->setProgress(IIZ)Landroid/support/v4/app/NotificationCompat$Builder;

    .line 67
    iget-object v0, p0, Lcom/cyjh/elfin/services/DownloadApkService$1;->this$0:Lcom/cyjh/elfin/services/DownloadApkService;

    invoke-static {v0}, Lcom/cyjh/elfin/services/DownloadApkService;->access$100(Lcom/cyjh/elfin/services/DownloadApkService;)Landroid/app/NotificationManager;

    move-result-object v0

    iget-object v1, p0, Lcom/cyjh/elfin/services/DownloadApkService$1;->this$0:Lcom/cyjh/elfin/services/DownloadApkService;

    invoke-static {v1}, Lcom/cyjh/elfin/services/DownloadApkService;->access$000(Lcom/cyjh/elfin/services/DownloadApkService;)Landroid/support/v4/app/NotificationCompat$Builder;

    move-result-object v1

    invoke-virtual {v1}, Landroid/support/v4/app/NotificationCompat$Builder;->build()Landroid/app/Notification;

    move-result-object v1

    invoke-virtual {v0, v4, v1}, Landroid/app/NotificationManager;->notify(ILandroid/app/Notification;)V

    .line 68
    iget-object v0, p0, Lcom/cyjh/elfin/services/DownloadApkService$1;->this$0:Lcom/cyjh/elfin/services/DownloadApkService;

    iget-object v1, p0, Lcom/cyjh/elfin/services/DownloadApkService$1;->val$file:Ljava/io/File;

    invoke-virtual {v1}, Ljava/io/File;->getAbsoluteFile()Ljava/io/File;

    move-result-object v1

    invoke-static {v0, v1}, Lcom/cyjh/elfin/util/AppDeviceUtils;->installAPK(Landroid/content/Context;Ljava/io/File;)V

    .line 69
    iget-object v0, p0, Lcom/cyjh/elfin/services/DownloadApkService$1;->this$0:Lcom/cyjh/elfin/services/DownloadApkService;

    invoke-static {v0}, Lcom/cyjh/elfin/services/DownloadApkService;->access$100(Lcom/cyjh/elfin/services/DownloadApkService;)Landroid/app/NotificationManager;

    move-result-object v0

    invoke-virtual {v0, v4}, Landroid/app/NotificationManager;->cancel(I)V

    .line 70
    iget-object v0, p0, Lcom/cyjh/elfin/services/DownloadApkService$1;->this$0:Lcom/cyjh/elfin/services/DownloadApkService;

    invoke-virtual {v0}, Lcom/cyjh/elfin/services/DownloadApkService;->stopSelf()V

    .line 71
    return-void
.end method
