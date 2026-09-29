.class Lcom/cyjh/elfin/activity/BaseActivity$1;
.super Ljava/lang/Object;
.source "BaseActivity.java"

# interfaces
.implements Lcom/cyjh/elfin/net/network/NetworkStatusReceiverListener;


# annotations
.annotation system Ldalvik/annotation/EnclosingMethod;
    value = Lcom/cyjh/elfin/activity/BaseActivity;->onCreate(Landroid/os/Bundle;)V
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x0
    name = null
.end annotation


# instance fields
.field final synthetic this$0:Lcom/cyjh/elfin/activity/BaseActivity;


# direct methods
.method constructor <init>(Lcom/cyjh/elfin/activity/BaseActivity;)V
    .locals 0
    .param p1, "this$0"    # Lcom/cyjh/elfin/activity/BaseActivity;

    .prologue
    .line 46
    iput-object p1, p0, Lcom/cyjh/elfin/activity/BaseActivity$1;->this$0:Lcom/cyjh/elfin/activity/BaseActivity;

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method


# virtual methods
.method public onReceive(Z)V
    .locals 2
    .param p1, "isConnected"    # Z

    .prologue
    .line 49
    iget-object v0, p0, Lcom/cyjh/elfin/activity/BaseActivity$1;->this$0:Lcom/cyjh/elfin/activity/BaseActivity;

    invoke-virtual {v0, p1}, Lcom/cyjh/elfin/activity/BaseActivity;->onNetWorkChange(Z)V

    .line 50
    if-nez p1, :cond_0

    .line 51
    iget-object v0, p0, Lcom/cyjh/elfin/activity/BaseActivity$1;->this$0:Lcom/cyjh/elfin/activity/BaseActivity;

    const v1, 0x7f0800a4

    invoke-static {v0, v1}, Lcom/cyjh/elfin/util/ToastUtils;->showToastLong(Landroid/content/Context;I)V

    .line 53
    :cond_0
    return-void
.end method
