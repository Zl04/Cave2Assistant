.class final Lcom/goldcoast/sdk/domain/c;
.super Landroid/content/BroadcastReceiver;
.source "SourceFile"


# instance fields
.field final synthetic a:Lcom/goldcoast/sdk/domain/EntryPoint;


# direct methods
.method constructor <init>(Lcom/goldcoast/sdk/domain/EntryPoint;)V
    .locals 0

    .prologue
    .line 168
    iput-object p1, p0, Lcom/goldcoast/sdk/domain/c;->a:Lcom/goldcoast/sdk/domain/EntryPoint;

    invoke-direct {p0}, Landroid/content/BroadcastReceiver;-><init>()V

    return-void
.end method


# virtual methods
.method public final onReceive(Landroid/content/Context;Landroid/content/Intent;)V
    .locals 1

    .prologue
    .line 171
    iget-object v0, p0, Lcom/goldcoast/sdk/domain/c;->a:Lcom/goldcoast/sdk/domain/EntryPoint;

    invoke-static {v0}, Lcom/goldcoast/sdk/domain/EntryPoint;->a(Lcom/goldcoast/sdk/domain/EntryPoint;)Landroid/net/ConnectivityManager;

    move-result-object v0

    invoke-virtual {v0}, Landroid/net/ConnectivityManager;->getActiveNetworkInfo()Landroid/net/NetworkInfo;

    move-result-object v0

    .line 172
    if-eqz v0, :cond_0

    invoke-virtual {v0}, Landroid/net/NetworkInfo;->isConnected()Z

    move-result v0

    if-eqz v0, :cond_0

    .line 173
    iget-object v0, p0, Lcom/goldcoast/sdk/domain/c;->a:Lcom/goldcoast/sdk/domain/EntryPoint;

    invoke-static {v0}, Lcom/goldcoast/sdk/domain/EntryPoint;->b(Lcom/goldcoast/sdk/domain/EntryPoint;)V

    .line 175
    :cond_0
    return-void
.end method
