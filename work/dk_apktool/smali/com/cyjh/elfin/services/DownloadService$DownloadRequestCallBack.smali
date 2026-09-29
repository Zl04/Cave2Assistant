.class Lcom/cyjh/elfin/services/DownloadService$DownloadRequestCallBack;
.super Lcom/lidroid/xutils/http/callback/RequestCallBack;
.source "DownloadService.java"


# annotations
.annotation system Ldalvik/annotation/EnclosingClass;
    value = Lcom/cyjh/elfin/services/DownloadService;
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x2
    name = "DownloadRequestCallBack"
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
.field private file:Ljava/io/File;

.field private mProgressCallBack:Lcom/lidroid/xutils/http/callback/RequestCallBack;

.field final synthetic this$0:Lcom/cyjh/elfin/services/DownloadService;


# direct methods
.method public constructor <init>(Lcom/cyjh/elfin/services/DownloadService;Lcom/lidroid/xutils/http/callback/RequestCallBack;)V
    .locals 3
    .param p2, "mProgressCallBack"    # Lcom/lidroid/xutils/http/callback/RequestCallBack;

    .prologue
    .line 54
    iput-object p1, p0, Lcom/cyjh/elfin/services/DownloadService$DownloadRequestCallBack;->this$0:Lcom/cyjh/elfin/services/DownloadService;

    invoke-direct {p0}, Lcom/lidroid/xutils/http/callback/RequestCallBack;-><init>()V

    .line 50
    new-instance v0, Ljava/io/File;

    invoke-static {}, Landroid/os/Environment;->getExternalStorageDirectory()Ljava/io/File;

    move-result-object v1

    const-string v2, "youxifengwo.apk"

    invoke-direct {v0, v1, v2}, Ljava/io/File;-><init>(Ljava/io/File;Ljava/lang/String;)V

    iput-object v0, p0, Lcom/cyjh/elfin/services/DownloadService$DownloadRequestCallBack;->file:Ljava/io/File;

    .line 55
    iput-object p2, p0, Lcom/cyjh/elfin/services/DownloadService$DownloadRequestCallBack;->mProgressCallBack:Lcom/lidroid/xutils/http/callback/RequestCallBack;

    .line 56
    return-void
.end method


# virtual methods
.method public onCancelled()V
    .locals 0

    .prologue
    .line 86
    invoke-super {p0}, Lcom/lidroid/xutils/http/callback/RequestCallBack;->onCancelled()V

    .line 87
    return-void
.end method

.method public onFailure(Lcom/lidroid/xutils/exception/HttpException;Ljava/lang/String;)V
    .locals 0
    .param p1, "e"    # Lcom/lidroid/xutils/exception/HttpException;
    .param p2, "s"    # Ljava/lang/String;

    .prologue
    .line 82
    return-void
.end method

.method public onLoading(JJZ)V
    .locals 7
    .param p1, "total"    # J
    .param p3, "current"    # J
    .param p5, "isUploading"    # Z

    .prologue
    const-wide/16 v2, 0x64

    .line 67
    mul-long v4, p3, v2

    div-long/2addr v4, p1

    long-to-int v0, v4

    .line 68
    .local v0, "progress":I
    iget-object v1, p0, Lcom/cyjh/elfin/services/DownloadService$DownloadRequestCallBack;->mProgressCallBack:Lcom/lidroid/xutils/http/callback/RequestCallBack;

    int-to-long v4, v0

    move v6, p5

    invoke-virtual/range {v1 .. v6}, Lcom/lidroid/xutils/http/callback/RequestCallBack;->onLoading(JJZ)V

    .line 69
    iget-object v1, p0, Lcom/cyjh/elfin/services/DownloadService$DownloadRequestCallBack;->this$0:Lcom/cyjh/elfin/services/DownloadService;

    invoke-static {v1}, Lcom/cyjh/elfin/services/DownloadService;->access$100(Lcom/cyjh/elfin/services/DownloadService;)Landroid/app/NotificationManager;

    move-result-object v1

    const v2, 0x1337959

    iget-object v3, p0, Lcom/cyjh/elfin/services/DownloadService$DownloadRequestCallBack;->this$0:Lcom/cyjh/elfin/services/DownloadService;

    invoke-static {v3}, Lcom/cyjh/elfin/services/DownloadService;->access$000(Lcom/cyjh/elfin/services/DownloadService;)Landroid/support/v4/app/NotificationCompat$Builder;

    move-result-object v3

    invoke-virtual {v3}, Landroid/support/v4/app/NotificationCompat$Builder;->build()Landroid/app/Notification;

    move-result-object v3

    invoke-virtual {v1, v2, v3}, Landroid/app/NotificationManager;->notify(ILandroid/app/Notification;)V

    .line 70
    return-void
.end method

.method public onStart()V
    .locals 3

    .prologue
    const/4 v2, 0x0

    .line 60
    invoke-super {p0}, Lcom/lidroid/xutils/http/callback/RequestCallBack;->onStart()V

    .line 61
    iget-object v0, p0, Lcom/cyjh/elfin/services/DownloadService$DownloadRequestCallBack;->this$0:Lcom/cyjh/elfin/services/DownloadService;

    invoke-static {v0}, Lcom/cyjh/elfin/services/DownloadService;->access$000(Lcom/cyjh/elfin/services/DownloadService;)Landroid/support/v4/app/NotificationCompat$Builder;

    move-result-object v0

    const/16 v1, 0x64

    invoke-virtual {v0, v1, v2, v2}, Landroid/support/v4/app/NotificationCompat$Builder;->setProgress(IIZ)Landroid/support/v4/app/NotificationCompat$Builder;

    .line 62
    iget-object v0, p0, Lcom/cyjh/elfin/services/DownloadService$DownloadRequestCallBack;->this$0:Lcom/cyjh/elfin/services/DownloadService;

    invoke-static {v0}, Lcom/cyjh/elfin/services/DownloadService;->access$100(Lcom/cyjh/elfin/services/DownloadService;)Landroid/app/NotificationManager;

    move-result-object v0

    const v1, 0x1337959

    iget-object v2, p0, Lcom/cyjh/elfin/services/DownloadService$DownloadRequestCallBack;->this$0:Lcom/cyjh/elfin/services/DownloadService;

    invoke-static {v2}, Lcom/cyjh/elfin/services/DownloadService;->access$000(Lcom/cyjh/elfin/services/DownloadService;)Landroid/support/v4/app/NotificationCompat$Builder;

    move-result-object v2

    invoke-virtual {v2}, Landroid/support/v4/app/NotificationCompat$Builder;->build()Landroid/app/Notification;

    move-result-object v2

    invoke-virtual {v0, v1, v2}, Landroid/app/NotificationManager;->notify(ILandroid/app/Notification;)V

    .line 63
    return-void
.end method

.method public onSuccess(Lcom/lidroid/xutils/http/ResponseInfo;)V
    .locals 3
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
    const/16 v2, 0x64

    .line 74
    iget-object v0, p0, Lcom/cyjh/elfin/services/DownloadService$DownloadRequestCallBack;->this$0:Lcom/cyjh/elfin/services/DownloadService;

    invoke-static {v0}, Lcom/cyjh/elfin/services/DownloadService;->access$000(Lcom/cyjh/elfin/services/DownloadService;)Landroid/support/v4/app/NotificationCompat$Builder;

    move-result-object v0

    const/4 v1, 0x0

    invoke-virtual {v0, v2, v2, v1}, Landroid/support/v4/app/NotificationCompat$Builder;->setProgress(IIZ)Landroid/support/v4/app/NotificationCompat$Builder;

    .line 75
    iget-object v0, p0, Lcom/cyjh/elfin/services/DownloadService$DownloadRequestCallBack;->this$0:Lcom/cyjh/elfin/services/DownloadService;

    invoke-static {v0}, Lcom/cyjh/elfin/services/DownloadService;->access$100(Lcom/cyjh/elfin/services/DownloadService;)Landroid/app/NotificationManager;

    move-result-object v0

    const v1, 0x1337959

    iget-object v2, p0, Lcom/cyjh/elfin/services/DownloadService$DownloadRequestCallBack;->this$0:Lcom/cyjh/elfin/services/DownloadService;

    invoke-static {v2}, Lcom/cyjh/elfin/services/DownloadService;->access$000(Lcom/cyjh/elfin/services/DownloadService;)Landroid/support/v4/app/NotificationCompat$Builder;

    move-result-object v2

    invoke-virtual {v2}, Landroid/support/v4/app/NotificationCompat$Builder;->build()Landroid/app/Notification;

    move-result-object v2

    invoke-virtual {v0, v1, v2}, Landroid/app/NotificationManager;->notify(ILandroid/app/Notification;)V

    .line 76
    iget-object v0, p0, Lcom/cyjh/elfin/services/DownloadService$DownloadRequestCallBack;->this$0:Lcom/cyjh/elfin/services/DownloadService;

    iget-object v1, p0, Lcom/cyjh/elfin/services/DownloadService$DownloadRequestCallBack;->file:Ljava/io/File;

    invoke-static {v0, v1}, Lcom/cyjh/elfin/util/AppDeviceUtils;->installAPK(Landroid/content/Context;Ljava/io/File;)V

    .line 77
    return-void
.end method
