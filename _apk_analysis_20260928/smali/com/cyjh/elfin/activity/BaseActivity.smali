.class public Lcom/cyjh/elfin/activity/BaseActivity;
.super Landroid/support/v4/app/FragmentActivity;
.source "BaseActivity.java"

# interfaces
.implements Lcom/cyjh/elfin/constant/APPConstant;
.implements Lcom/cyjh/elfin/mvp/views/BaseView;


# instance fields
.field protected appContext:Lcom/cyjh/elfin/AppContext;

.field protected commonLog:Lcom/cyjh/elfin/log/CommonLog;

.field private mNetworkReceiver:Lcom/cyjh/elfin/net/network/NetworkStatusReceiver;

.field private networkStatusListener:Lcom/cyjh/elfin/net/network/NetworkStatusReceiverListener;

.field private progressDialog:Landroid/app/ProgressDialog;


# direct methods
.method public constructor <init>()V
    .locals 1

    .prologue
    .line 32
    invoke-direct {p0}, Landroid/support/v4/app/FragmentActivity;-><init>()V

    .line 35
    new-instance v0, Lcom/cyjh/elfin/log/CommonLog;

    invoke-direct {v0}, Lcom/cyjh/elfin/log/CommonLog;-><init>()V

    iput-object v0, p0, Lcom/cyjh/elfin/activity/BaseActivity;->commonLog:Lcom/cyjh/elfin/log/CommonLog;

    return-void
.end method


# virtual methods
.method protected dismissProgressDialog()V
    .locals 1

    .prologue
    .line 77
    iget-object v0, p0, Lcom/cyjh/elfin/activity/BaseActivity;->progressDialog:Landroid/app/ProgressDialog;

    invoke-virtual {v0}, Landroid/app/ProgressDialog;->dismiss()V

    .line 78
    return-void
.end method

.method public hideProgress()V
    .locals 0

    .prologue
    .line 88
    return-void
.end method

.method public hideProgressDialog()V
    .locals 0

    .prologue
    .line 98
    return-void
.end method

.method protected onCreate(Landroid/os/Bundle;)V
    .locals 3
    .param p1, "savedInstanceState"    # Landroid/os/Bundle;

    .prologue
    .line 43
    invoke-super {p0, p1}, Landroid/support/v4/app/FragmentActivity;->onCreate(Landroid/os/Bundle;)V

    .line 44
    invoke-virtual {p0}, Lcom/cyjh/elfin/activity/BaseActivity;->getApplicationContext()Landroid/content/Context;

    move-result-object v0

    check-cast v0, Lcom/cyjh/elfin/AppContext;

    iput-object v0, p0, Lcom/cyjh/elfin/activity/BaseActivity;->appContext:Lcom/cyjh/elfin/AppContext;

    .line 45
    const/4 v0, 0x1

    invoke-virtual {p0, v0}, Lcom/cyjh/elfin/activity/BaseActivity;->requestWindowFeature(I)Z

    .line 46
    new-instance v0, Lcom/cyjh/elfin/activity/BaseActivity$1;

    invoke-direct {v0, p0}, Lcom/cyjh/elfin/activity/BaseActivity$1;-><init>(Lcom/cyjh/elfin/activity/BaseActivity;)V

    iput-object v0, p0, Lcom/cyjh/elfin/activity/BaseActivity;->networkStatusListener:Lcom/cyjh/elfin/net/network/NetworkStatusReceiverListener;

    .line 55
    new-instance v0, Lcom/cyjh/elfin/net/network/NetworkStatusReceiver;

    invoke-direct {v0}, Lcom/cyjh/elfin/net/network/NetworkStatusReceiver;-><init>()V

    iput-object v0, p0, Lcom/cyjh/elfin/activity/BaseActivity;->mNetworkReceiver:Lcom/cyjh/elfin/net/network/NetworkStatusReceiver;

    .line 56
    iget-object v0, p0, Lcom/cyjh/elfin/activity/BaseActivity;->mNetworkReceiver:Lcom/cyjh/elfin/net/network/NetworkStatusReceiver;

    iget-object v1, p0, Lcom/cyjh/elfin/activity/BaseActivity;->networkStatusListener:Lcom/cyjh/elfin/net/network/NetworkStatusReceiverListener;

    invoke-virtual {v0, v1}, Lcom/cyjh/elfin/net/network/NetworkStatusReceiver;->setNetworkrListener(Lcom/cyjh/elfin/net/network/NetworkStatusReceiverListener;)V

    .line 57
    iget-object v0, p0, Lcom/cyjh/elfin/activity/BaseActivity;->mNetworkReceiver:Lcom/cyjh/elfin/net/network/NetworkStatusReceiver;

    new-instance v1, Landroid/content/IntentFilter;

    const-string v2, "android.net.conn.CONNECTIVITY_CHANGE"

    invoke-direct {v1, v2}, Landroid/content/IntentFilter;-><init>(Ljava/lang/String;)V

    invoke-virtual {p0, v0, v1}, Lcom/cyjh/elfin/activity/BaseActivity;->registerReceiver(Landroid/content/BroadcastReceiver;Landroid/content/IntentFilter;)Landroid/content/Intent;

    .line 58
    return-void
.end method

.method protected onDestroy()V
    .locals 1

    .prologue
    .line 62
    invoke-super {p0}, Landroid/support/v4/app/FragmentActivity;->onDestroy()V

    .line 63
    iget-object v0, p0, Lcom/cyjh/elfin/activity/BaseActivity;->mNetworkReceiver:Lcom/cyjh/elfin/net/network/NetworkStatusReceiver;

    invoke-virtual {p0, v0}, Lcom/cyjh/elfin/activity/BaseActivity;->unregisterReceiver(Landroid/content/BroadcastReceiver;)V

    .line 64
    return-void
.end method

.method public onErrorMsg(Ljava/lang/String;Ljava/lang/String;)V
    .locals 0
    .param p1, "message"    # Ljava/lang/String;
    .param p2, "authority"    # Ljava/lang/String;

    .prologue
    .line 103
    return-void
.end method

.method protected onNetWorkChange(Z)V
    .locals 0
    .param p1, "isNetwork"    # Z

    .prologue
    .line 105
    return-void
.end method

.method public showProgress()V
    .locals 0

    .prologue
    .line 83
    return-void
.end method

.method public showProgressDialog(Landroid/content/Context;I)V
    .locals 0
    .param p1, "context"    # Landroid/content/Context;
    .param p2, "resId"    # I

    .prologue
    .line 93
    return-void
.end method

.method protected showProgressDialog(Landroid/content/Context;II)V
    .locals 3
    .param p1, "context"    # Landroid/content/Context;
    .param p2, "title"    # I
    .param p3, "content"    # I

    .prologue
    const/4 v2, 0x0

    .line 68
    new-instance v0, Landroid/app/ProgressDialog;

    invoke-direct {v0, p1}, Landroid/app/ProgressDialog;-><init>(Landroid/content/Context;)V

    iput-object v0, p0, Lcom/cyjh/elfin/activity/BaseActivity;->progressDialog:Landroid/app/ProgressDialog;

    .line 69
    iget-object v0, p0, Lcom/cyjh/elfin/activity/BaseActivity;->progressDialog:Landroid/app/ProgressDialog;

    invoke-virtual {p1, p2}, Landroid/content/Context;->getString(I)Ljava/lang/String;

    move-result-object v1

    invoke-virtual {v0, v1}, Landroid/app/ProgressDialog;->setTitle(Ljava/lang/CharSequence;)V

    .line 70
    iget-object v0, p0, Lcom/cyjh/elfin/activity/BaseActivity;->progressDialog:Landroid/app/ProgressDialog;

    invoke-virtual {v0, v2}, Landroid/app/ProgressDialog;->setProgressStyle(I)V

    .line 71
    iget-object v0, p0, Lcom/cyjh/elfin/activity/BaseActivity;->progressDialog:Landroid/app/ProgressDialog;

    invoke-virtual {p1, p3}, Landroid/content/Context;->getString(I)Ljava/lang/String;

    move-result-object v1

    invoke-virtual {v0, v1}, Landroid/app/ProgressDialog;->setMessage(Ljava/lang/CharSequence;)V

    .line 72
    iget-object v0, p0, Lcom/cyjh/elfin/activity/BaseActivity;->progressDialog:Landroid/app/ProgressDialog;

    invoke-virtual {v0, v2}, Landroid/app/ProgressDialog;->setCanceledOnTouchOutside(Z)V

    .line 73
    iget-object v0, p0, Lcom/cyjh/elfin/activity/BaseActivity;->progressDialog:Landroid/app/ProgressDialog;

    invoke-virtual {v0}, Landroid/app/ProgressDialog;->show()V

    .line 74
    return-void
.end method
