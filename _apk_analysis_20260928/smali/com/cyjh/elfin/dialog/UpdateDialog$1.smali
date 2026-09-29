.class Lcom/cyjh/elfin/dialog/UpdateDialog$1;
.super Lcom/lidroid/xutils/http/callback/RequestCallBack;
.source "UpdateDialog.java"


# annotations
.annotation system Ldalvik/annotation/EnclosingMethod;
    value = Lcom/cyjh/elfin/dialog/UpdateDialog;->download()V
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
.field final synthetic this$0:Lcom/cyjh/elfin/dialog/UpdateDialog;


# direct methods
.method constructor <init>(Lcom/cyjh/elfin/dialog/UpdateDialog;)V
    .locals 0
    .param p1, "this$0"    # Lcom/cyjh/elfin/dialog/UpdateDialog;

    .prologue
    .line 153
    iput-object p1, p0, Lcom/cyjh/elfin/dialog/UpdateDialog$1;->this$0:Lcom/cyjh/elfin/dialog/UpdateDialog;

    invoke-direct {p0}, Lcom/lidroid/xutils/http/callback/RequestCallBack;-><init>()V

    return-void
.end method


# virtual methods
.method public onFailure(Lcom/lidroid/xutils/exception/HttpException;Ljava/lang/String;)V
    .locals 0
    .param p1, "exception"    # Lcom/lidroid/xutils/exception/HttpException;
    .param p2, "msg"    # Ljava/lang/String;

    .prologue
    .line 187
    return-void
.end method

.method public onLoading(JJZ)V
    .locals 7
    .param p1, "total"    # J
    .param p3, "current"    # J
    .param p5, "isUploading"    # Z

    .prologue
    .line 157
    invoke-super/range {p0 .. p5}, Lcom/lidroid/xutils/http/callback/RequestCallBack;->onLoading(JJZ)V

    .line 158
    invoke-static {p3, p4}, Ljava/math/BigInteger;->valueOf(J)Ljava/math/BigInteger;

    move-result-object v2

    invoke-static {v2}, Lorg/apache/commons/io/FileUtils;->byteCountToDisplaySize(Ljava/math/BigInteger;)Ljava/lang/String;

    move-result-object v0

    .line 159
    .local v0, "downloadSize":Ljava/lang/String;
    invoke-static {p1, p2}, Ljava/math/BigInteger;->valueOf(J)Ljava/math/BigInteger;

    move-result-object v2

    invoke-static {v2}, Lorg/apache/commons/io/FileUtils;->byteCountToDisplaySize(Ljava/math/BigInteger;)Ljava/lang/String;

    move-result-object v1

    .line 161
    .local v1, "fileSzie":Ljava/lang/String;
    iget-object v2, p0, Lcom/cyjh/elfin/dialog/UpdateDialog$1;->this$0:Lcom/cyjh/elfin/dialog/UpdateDialog;

    invoke-static {v2}, Lcom/cyjh/elfin/dialog/UpdateDialog;->access$000(Lcom/cyjh/elfin/dialog/UpdateDialog;)Landroid/widget/TextView;

    move-result-object v2

    iget-object v3, p0, Lcom/cyjh/elfin/dialog/UpdateDialog$1;->this$0:Lcom/cyjh/elfin/dialog/UpdateDialog;

    invoke-virtual {v3}, Lcom/cyjh/elfin/dialog/UpdateDialog;->getContext()Landroid/content/Context;

    move-result-object v3

    const v4, 0x7f080066

    invoke-virtual {v3, v4}, Landroid/content/Context;->getString(I)Ljava/lang/String;

    move-result-object v3

    const/4 v4, 0x2

    new-array v4, v4, [Ljava/lang/Object;

    const/4 v5, 0x0

    aput-object v0, v4, v5

    const/4 v5, 0x1

    aput-object v1, v4, v5

    invoke-static {v3, v4}, Ljava/lang/String;->format(Ljava/lang/String;[Ljava/lang/Object;)Ljava/lang/String;

    move-result-object v3

    invoke-virtual {v2, v3}, Landroid/widget/TextView;->setText(Ljava/lang/CharSequence;)V

    .line 163
    iget-object v2, p0, Lcom/cyjh/elfin/dialog/UpdateDialog$1;->this$0:Lcom/cyjh/elfin/dialog/UpdateDialog;

    invoke-static {v2}, Lcom/cyjh/elfin/dialog/UpdateDialog;->access$100(Lcom/cyjh/elfin/dialog/UpdateDialog;)Landroid/widget/ProgressBar;

    move-result-object v2

    const-wide/16 v4, 0x64

    mul-long/2addr v4, p3

    div-long/2addr v4, p1

    long-to-int v3, v4

    invoke-virtual {v2, v3}, Landroid/widget/ProgressBar;->setProgress(I)V

    .line 164
    return-void
.end method

.method public onSuccess(Lcom/lidroid/xutils/http/ResponseInfo;)V
    .locals 2
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
    .line 168
    .local p1, "responseInfo":Lcom/lidroid/xutils/http/ResponseInfo;, "Lcom/lidroid/xutils/http/ResponseInfo<Ljava/io/File;>;"
    iget-object v0, p0, Lcom/cyjh/elfin/dialog/UpdateDialog$1;->this$0:Lcom/cyjh/elfin/dialog/UpdateDialog;

    invoke-virtual {v0}, Lcom/cyjh/elfin/dialog/UpdateDialog;->getContext()Landroid/content/Context;

    move-result-object v1

    iget-object v0, p1, Lcom/lidroid/xutils/http/ResponseInfo;->result:Ljava/lang/Object;

    check-cast v0, Ljava/io/File;

    invoke-static {v1, v0}, Lcom/cyjh/elfin/util/AppDeviceUtils;->installAPK(Landroid/content/Context;Ljava/io/File;)V

    .line 172
    iget-object v0, p0, Lcom/cyjh/elfin/dialog/UpdateDialog$1;->this$0:Lcom/cyjh/elfin/dialog/UpdateDialog;

    invoke-static {v0}, Lcom/cyjh/elfin/dialog/UpdateDialog;->access$200(Lcom/cyjh/elfin/dialog/UpdateDialog;)Lcom/cyjh/elfin/entity/UpdateInfo;

    move-result-object v0

    invoke-virtual {v0}, Lcom/cyjh/elfin/entity/UpdateInfo;->getIsDismissing()Z

    move-result v0

    if-eqz v0, :cond_0

    .line 173
    iget-object v0, p0, Lcom/cyjh/elfin/dialog/UpdateDialog$1;->this$0:Lcom/cyjh/elfin/dialog/UpdateDialog;

    invoke-virtual {v0}, Lcom/cyjh/elfin/dialog/UpdateDialog;->dismiss()V

    .line 175
    :cond_0
    iget-object v0, p0, Lcom/cyjh/elfin/dialog/UpdateDialog$1;->this$0:Lcom/cyjh/elfin/dialog/UpdateDialog;

    invoke-static {v0}, Lcom/cyjh/elfin/dialog/UpdateDialog;->access$300(Lcom/cyjh/elfin/dialog/UpdateDialog;)Landroid/widget/Button;

    move-result-object v0

    const-string v1, "\u5b89\u88c5"

    invoke-virtual {v0, v1}, Landroid/widget/Button;->setText(Ljava/lang/CharSequence;)V

    .line 176
    iget-object v0, p0, Lcom/cyjh/elfin/dialog/UpdateDialog$1;->this$0:Lcom/cyjh/elfin/dialog/UpdateDialog;

    invoke-static {v0}, Lcom/cyjh/elfin/dialog/UpdateDialog;->access$300(Lcom/cyjh/elfin/dialog/UpdateDialog;)Landroid/widget/Button;

    move-result-object v0

    new-instance v1, Lcom/cyjh/elfin/dialog/UpdateDialog$1$1;

    invoke-direct {v1, p0, p1}, Lcom/cyjh/elfin/dialog/UpdateDialog$1$1;-><init>(Lcom/cyjh/elfin/dialog/UpdateDialog$1;Lcom/lidroid/xutils/http/ResponseInfo;)V

    invoke-virtual {v0, v1}, Landroid/widget/Button;->setOnClickListener(Landroid/view/View$OnClickListener;)V

    .line 182
    return-void
.end method
