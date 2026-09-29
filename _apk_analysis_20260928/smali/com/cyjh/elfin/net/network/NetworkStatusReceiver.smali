.class public Lcom/cyjh/elfin/net/network/NetworkStatusReceiver;
.super Landroid/content/BroadcastReceiver;
.source "NetworkStatusReceiver.java"


# instance fields
.field private networkrListener:Lcom/cyjh/elfin/net/network/NetworkStatusReceiverListener;


# direct methods
.method public constructor <init>()V
    .locals 0

    .prologue
    .line 13
    invoke-direct {p0}, Landroid/content/BroadcastReceiver;-><init>()V

    return-void
.end method


# virtual methods
.method public onReceive(Landroid/content/Context;Landroid/content/Intent;)V
    .locals 4
    .param p1, "context"    # Landroid/content/Context;
    .param p2, "intent"    # Landroid/content/Intent;

    .prologue
    .line 17
    const-string v3, "connectivity"

    invoke-virtual {p1, v3}, Landroid/content/Context;->getSystemService(Ljava/lang/String;)Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Landroid/net/ConnectivityManager;

    .line 18
    .local v0, "connectivityManager":Landroid/net/ConnectivityManager;
    invoke-virtual {v0}, Landroid/net/ConnectivityManager;->getActiveNetworkInfo()Landroid/net/NetworkInfo;

    move-result-object v2

    .line 19
    .local v2, "networkInfo":Landroid/net/NetworkInfo;
    if-eqz v2, :cond_1

    invoke-virtual {v2}, Landroid/net/NetworkInfo;->isAvailable()Z

    move-result v3

    if-eqz v3, :cond_1

    const/4 v1, 0x1

    .line 20
    .local v1, "isNetwork":Z
    :goto_0
    iget-object v3, p0, Lcom/cyjh/elfin/net/network/NetworkStatusReceiver;->networkrListener:Lcom/cyjh/elfin/net/network/NetworkStatusReceiverListener;

    if-eqz v3, :cond_0

    .line 21
    iget-object v3, p0, Lcom/cyjh/elfin/net/network/NetworkStatusReceiver;->networkrListener:Lcom/cyjh/elfin/net/network/NetworkStatusReceiverListener;

    invoke-interface {v3, v1}, Lcom/cyjh/elfin/net/network/NetworkStatusReceiverListener;->onReceive(Z)V

    .line 23
    :cond_0
    return-void

    .line 19
    .end local v1    # "isNetwork":Z
    :cond_1
    const/4 v1, 0x0

    goto :goto_0
.end method

.method public setNetworkrListener(Lcom/cyjh/elfin/net/network/NetworkStatusReceiverListener;)V
    .locals 0
    .param p1, "networkrListener"    # Lcom/cyjh/elfin/net/network/NetworkStatusReceiverListener;

    .prologue
    .line 26
    iput-object p1, p0, Lcom/cyjh/elfin/net/network/NetworkStatusReceiver;->networkrListener:Lcom/cyjh/elfin/net/network/NetworkStatusReceiverListener;

    .line 27
    return-void
.end method
