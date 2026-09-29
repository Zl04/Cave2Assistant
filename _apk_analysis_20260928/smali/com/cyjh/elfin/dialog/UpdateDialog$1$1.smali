.class Lcom/cyjh/elfin/dialog/UpdateDialog$1$1;
.super Ljava/lang/Object;
.source "UpdateDialog.java"

# interfaces
.implements Landroid/view/View$OnClickListener;


# annotations
.annotation system Ldalvik/annotation/EnclosingMethod;
    value = Lcom/cyjh/elfin/dialog/UpdateDialog$1;->onSuccess(Lcom/lidroid/xutils/http/ResponseInfo;)V
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x0
    name = null
.end annotation


# instance fields
.field final synthetic this$1:Lcom/cyjh/elfin/dialog/UpdateDialog$1;

.field final synthetic val$responseInfo:Lcom/lidroid/xutils/http/ResponseInfo;


# direct methods
.method constructor <init>(Lcom/cyjh/elfin/dialog/UpdateDialog$1;Lcom/lidroid/xutils/http/ResponseInfo;)V
    .locals 0
    .param p1, "this$1"    # Lcom/cyjh/elfin/dialog/UpdateDialog$1;

    .prologue
    .line 176
    iput-object p1, p0, Lcom/cyjh/elfin/dialog/UpdateDialog$1$1;->this$1:Lcom/cyjh/elfin/dialog/UpdateDialog$1;

    iput-object p2, p0, Lcom/cyjh/elfin/dialog/UpdateDialog$1$1;->val$responseInfo:Lcom/lidroid/xutils/http/ResponseInfo;

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method


# virtual methods
.method public onClick(Landroid/view/View;)V
    .locals 2
    .param p1, "v"    # Landroid/view/View;

    .prologue
    .line 179
    iget-object v0, p0, Lcom/cyjh/elfin/dialog/UpdateDialog$1$1;->this$1:Lcom/cyjh/elfin/dialog/UpdateDialog$1;

    iget-object v0, v0, Lcom/cyjh/elfin/dialog/UpdateDialog$1;->this$0:Lcom/cyjh/elfin/dialog/UpdateDialog;

    invoke-virtual {v0}, Lcom/cyjh/elfin/dialog/UpdateDialog;->getContext()Landroid/content/Context;

    move-result-object v1

    iget-object v0, p0, Lcom/cyjh/elfin/dialog/UpdateDialog$1$1;->val$responseInfo:Lcom/lidroid/xutils/http/ResponseInfo;

    iget-object v0, v0, Lcom/lidroid/xutils/http/ResponseInfo;->result:Ljava/lang/Object;

    check-cast v0, Ljava/io/File;

    invoke-static {v1, v0}, Lcom/cyjh/elfin/util/AppDeviceUtils;->installAPK(Landroid/content/Context;Ljava/io/File;)V

    .line 180
    return-void
.end method
