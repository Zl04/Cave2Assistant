.class Lcom/cyjh/elfin/fragment/OptionFragment$3;
.super Lcom/lidroid/xutils/http/callback/RequestCallBack;
.source "OptionFragment.java"


# annotations
.annotation system Ldalvik/annotation/EnclosingMethod;
    value = Lcom/cyjh/elfin/fragment/OptionFragment;->downloadOnClick(Lcom/dd/processbutton/iml/SubmitProcessButton;)V
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
.field final synthetic this$0:Lcom/cyjh/elfin/fragment/OptionFragment;

.field final synthetic val$buttonDownload:Lcom/dd/processbutton/iml/SubmitProcessButton;


# direct methods
.method constructor <init>(Lcom/cyjh/elfin/fragment/OptionFragment;Lcom/dd/processbutton/iml/SubmitProcessButton;)V
    .locals 0
    .param p1, "this$0"    # Lcom/cyjh/elfin/fragment/OptionFragment;

    .prologue
    .line 1004
    iput-object p1, p0, Lcom/cyjh/elfin/fragment/OptionFragment$3;->this$0:Lcom/cyjh/elfin/fragment/OptionFragment;

    iput-object p2, p0, Lcom/cyjh/elfin/fragment/OptionFragment$3;->val$buttonDownload:Lcom/dd/processbutton/iml/SubmitProcessButton;

    invoke-direct {p0}, Lcom/lidroid/xutils/http/callback/RequestCallBack;-><init>()V

    return-void
.end method


# virtual methods
.method public onFailure(Lcom/lidroid/xutils/exception/HttpException;Ljava/lang/String;)V
    .locals 0
    .param p1, "e"    # Lcom/lidroid/xutils/exception/HttpException;
    .param p2, "s"    # Ljava/lang/String;

    .prologue
    .line 1016
    return-void
.end method

.method public onLoading(JJZ)V
    .locals 5
    .param p1, "total"    # J
    .param p3, "current"    # J
    .param p5, "isUploading"    # Z

    .prologue
    .line 1028
    invoke-super/range {p0 .. p5}, Lcom/lidroid/xutils/http/callback/RequestCallBack;->onLoading(JJZ)V

    .line 1029
    const-wide/16 v2, 0x64

    mul-long/2addr v2, p3

    div-long/2addr v2, p1

    long-to-int v0, v2

    .line 1030
    .local v0, "progress":I
    iget-object v1, p0, Lcom/cyjh/elfin/fragment/OptionFragment$3;->val$buttonDownload:Lcom/dd/processbutton/iml/SubmitProcessButton;

    invoke-virtual {v1, v0}, Lcom/dd/processbutton/iml/SubmitProcessButton;->setProgress(I)V

    .line 1031
    iget-object v1, p0, Lcom/cyjh/elfin/fragment/OptionFragment$3;->this$0:Lcom/cyjh/elfin/fragment/OptionFragment;

    invoke-static {v1}, Lcom/cyjh/elfin/fragment/OptionFragment;->access$600(Lcom/cyjh/elfin/fragment/OptionFragment;)Landroid/support/v4/app/NotificationCompat$Builder;

    move-result-object v1

    const/16 v2, 0x64

    const/4 v3, 0x0

    invoke-virtual {v1, v2, v0, v3}, Landroid/support/v4/app/NotificationCompat$Builder;->setProgress(IIZ)Landroid/support/v4/app/NotificationCompat$Builder;

    .line 1032
    iget-object v1, p0, Lcom/cyjh/elfin/fragment/OptionFragment$3;->this$0:Lcom/cyjh/elfin/fragment/OptionFragment;

    invoke-static {v1}, Lcom/cyjh/elfin/fragment/OptionFragment;->access$700(Lcom/cyjh/elfin/fragment/OptionFragment;)Landroid/app/NotificationManager;

    move-result-object v1

    const v2, 0x1337959

    iget-object v3, p0, Lcom/cyjh/elfin/fragment/OptionFragment$3;->this$0:Lcom/cyjh/elfin/fragment/OptionFragment;

    invoke-static {v3}, Lcom/cyjh/elfin/fragment/OptionFragment;->access$600(Lcom/cyjh/elfin/fragment/OptionFragment;)Landroid/support/v4/app/NotificationCompat$Builder;

    move-result-object v3

    invoke-virtual {v3}, Landroid/support/v4/app/NotificationCompat$Builder;->build()Landroid/app/Notification;

    move-result-object v3

    invoke-virtual {v1, v2, v3}, Landroid/app/NotificationManager;->notify(ILandroid/app/Notification;)V

    .line 1033
    return-void
.end method

.method public onStart()V
    .locals 3

    .prologue
    const/4 v2, 0x0

    .line 1020
    invoke-super {p0}, Lcom/lidroid/xutils/http/callback/RequestCallBack;->onStart()V

    .line 1021
    iget-object v0, p0, Lcom/cyjh/elfin/fragment/OptionFragment$3;->this$0:Lcom/cyjh/elfin/fragment/OptionFragment;

    iget-object v0, v0, Lcom/cyjh/elfin/fragment/OptionFragment;->commonLog:Lcom/cyjh/elfin/log/CommonLog;

    const-string v1, "\u5f00\u59cb\u4e0b\u8f7d>>>"

    invoke-virtual {v0, v1}, Lcom/cyjh/elfin/log/CommonLog;->e(Ljava/lang/Object;)V

    .line 1022
    iget-object v0, p0, Lcom/cyjh/elfin/fragment/OptionFragment$3;->this$0:Lcom/cyjh/elfin/fragment/OptionFragment;

    invoke-static {v0}, Lcom/cyjh/elfin/fragment/OptionFragment;->access$600(Lcom/cyjh/elfin/fragment/OptionFragment;)Landroid/support/v4/app/NotificationCompat$Builder;

    move-result-object v0

    const/16 v1, 0x64

    invoke-virtual {v0, v1, v2, v2}, Landroid/support/v4/app/NotificationCompat$Builder;->setProgress(IIZ)Landroid/support/v4/app/NotificationCompat$Builder;

    .line 1023
    iget-object v0, p0, Lcom/cyjh/elfin/fragment/OptionFragment$3;->this$0:Lcom/cyjh/elfin/fragment/OptionFragment;

    invoke-static {v0}, Lcom/cyjh/elfin/fragment/OptionFragment;->access$700(Lcom/cyjh/elfin/fragment/OptionFragment;)Landroid/app/NotificationManager;

    move-result-object v0

    const v1, 0x1337959

    iget-object v2, p0, Lcom/cyjh/elfin/fragment/OptionFragment$3;->this$0:Lcom/cyjh/elfin/fragment/OptionFragment;

    invoke-static {v2}, Lcom/cyjh/elfin/fragment/OptionFragment;->access$600(Lcom/cyjh/elfin/fragment/OptionFragment;)Landroid/support/v4/app/NotificationCompat$Builder;

    move-result-object v2

    invoke-virtual {v2}, Landroid/support/v4/app/NotificationCompat$Builder;->build()Landroid/app/Notification;

    move-result-object v2

    invoke-virtual {v0, v1, v2}, Landroid/app/NotificationManager;->notify(ILandroid/app/Notification;)V

    .line 1024
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

    .line 1007
    iget-object v0, p0, Lcom/cyjh/elfin/fragment/OptionFragment$3;->this$0:Lcom/cyjh/elfin/fragment/OptionFragment;

    iget-object v0, v0, Lcom/cyjh/elfin/fragment/OptionFragment;->commonLog:Lcom/cyjh/elfin/log/CommonLog;

    const-string v1, "\u4e0b\u8f7donSuccess>>>"

    invoke-virtual {v0, v1}, Lcom/cyjh/elfin/log/CommonLog;->e(Ljava/lang/Object;)V

    .line 1008
    iget-object v0, p0, Lcom/cyjh/elfin/fragment/OptionFragment$3;->this$0:Lcom/cyjh/elfin/fragment/OptionFragment;

    invoke-static {v0}, Lcom/cyjh/elfin/fragment/OptionFragment;->access$600(Lcom/cyjh/elfin/fragment/OptionFragment;)Landroid/support/v4/app/NotificationCompat$Builder;

    move-result-object v0

    const/4 v1, 0x0

    invoke-virtual {v0, v2, v2, v1}, Landroid/support/v4/app/NotificationCompat$Builder;->setProgress(IIZ)Landroid/support/v4/app/NotificationCompat$Builder;

    .line 1009
    iget-object v0, p0, Lcom/cyjh/elfin/fragment/OptionFragment$3;->this$0:Lcom/cyjh/elfin/fragment/OptionFragment;

    invoke-static {v0}, Lcom/cyjh/elfin/fragment/OptionFragment;->access$700(Lcom/cyjh/elfin/fragment/OptionFragment;)Landroid/app/NotificationManager;

    move-result-object v0

    const v1, 0x1337959

    iget-object v2, p0, Lcom/cyjh/elfin/fragment/OptionFragment$3;->this$0:Lcom/cyjh/elfin/fragment/OptionFragment;

    invoke-static {v2}, Lcom/cyjh/elfin/fragment/OptionFragment;->access$600(Lcom/cyjh/elfin/fragment/OptionFragment;)Landroid/support/v4/app/NotificationCompat$Builder;

    move-result-object v2

    invoke-virtual {v2}, Landroid/support/v4/app/NotificationCompat$Builder;->build()Landroid/app/Notification;

    move-result-object v2

    invoke-virtual {v0, v1, v2}, Landroid/app/NotificationManager;->notify(ILandroid/app/Notification;)V

    .line 1010
    iget-object v0, p0, Lcom/cyjh/elfin/fragment/OptionFragment$3;->this$0:Lcom/cyjh/elfin/fragment/OptionFragment;

    invoke-virtual {v0}, Lcom/cyjh/elfin/fragment/OptionFragment;->getActivity()Landroid/support/v4/app/FragmentActivity;

    move-result-object v0

    iget-object v1, p0, Lcom/cyjh/elfin/fragment/OptionFragment$3;->this$0:Lcom/cyjh/elfin/fragment/OptionFragment;

    invoke-static {v1}, Lcom/cyjh/elfin/fragment/OptionFragment;->access$800(Lcom/cyjh/elfin/fragment/OptionFragment;)Lcom/cyjh/elfin/dialog/DownloadDialogFragment;

    move-result-object v1

    iget-object v1, v1, Lcom/cyjh/elfin/dialog/DownloadDialogFragment;->desApkFile:Ljava/io/File;

    invoke-static {v0, v1}, Lcom/cyjh/elfin/util/AppDeviceUtils;->installAPK(Landroid/content/Context;Ljava/io/File;)V

    .line 1011
    iget-object v0, p0, Lcom/cyjh/elfin/fragment/OptionFragment$3;->this$0:Lcom/cyjh/elfin/fragment/OptionFragment;

    invoke-static {v0}, Lcom/cyjh/elfin/fragment/OptionFragment;->access$800(Lcom/cyjh/elfin/fragment/OptionFragment;)Lcom/cyjh/elfin/dialog/DownloadDialogFragment;

    move-result-object v0

    invoke-virtual {v0}, Lcom/cyjh/elfin/dialog/DownloadDialogFragment;->dismiss()V

    .line 1012
    return-void
.end method
