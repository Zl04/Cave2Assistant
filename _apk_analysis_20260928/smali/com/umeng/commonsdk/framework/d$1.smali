.class final Lcom/umeng/commonsdk/framework/d$1;
.super Landroid/content/BroadcastReceiver;
.source "UMNetWorkSender.java"


# annotations
.annotation system Ldalvik/annotation/EnclosingClass;
    value = Lcom/umeng/commonsdk/framework/d;
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x8
    name = null
.end annotation


# direct methods
.method constructor <init>()V
    .locals 0

    .prologue
    .line 55
    invoke-direct {p0}, Landroid/content/BroadcastReceiver;-><init>()V

    return-void
.end method


# virtual methods
.method public onReceive(Landroid/content/Context;Landroid/content/Intent;)V
    .locals 3

    .prologue
    const/4 v2, 0x1

    .line 59
    new-instance v0, Ljava/lang/Thread;

    new-instance v1, Lcom/umeng/commonsdk/framework/d$1$1;

    invoke-direct {v1, p0, p1}, Lcom/umeng/commonsdk/framework/d$1$1;-><init>(Lcom/umeng/commonsdk/framework/d$1;Landroid/content/Context;)V

    invoke-direct {v0, v1}, Ljava/lang/Thread;-><init>(Ljava/lang/Runnable;)V

    .line 64
    invoke-virtual {v0}, Ljava/lang/Thread;->start()V

    .line 65
    invoke-virtual {p2}, Landroid/content/Intent;->getAction()Ljava/lang/String;

    move-result-object v0

    .line 66
    const-string v1, "android.net.conn.CONNECTIVITY_CHANGE"

    invoke-virtual {v0, v1}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v0

    if-eqz v0, :cond_0

    .line 67
    invoke-static {}, Lcom/umeng/commonsdk/framework/c;->a()Landroid/content/Context;

    move-result-object v1

    .line 68
    const-string v0, "connectivity"

    invoke-virtual {v1, v0}, Landroid/content/Context;->getSystemService(Ljava/lang/String;)Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Landroid/net/ConnectivityManager;

    invoke-static {v0}, Lcom/umeng/commonsdk/framework/d;->a(Landroid/net/ConnectivityManager;)Landroid/net/ConnectivityManager;

    .line 70
    :try_start_0
    invoke-static {}, Lcom/umeng/commonsdk/framework/d;->d()Landroid/net/ConnectivityManager;

    move-result-object v0

    invoke-virtual {v0}, Landroid/net/ConnectivityManager;->getActiveNetworkInfo()Landroid/net/NetworkInfo;

    move-result-object v0

    invoke-static {v0}, Lcom/umeng/commonsdk/framework/d;->a(Landroid/net/NetworkInfo;)Landroid/net/NetworkInfo;

    .line 71
    invoke-static {}, Lcom/umeng/commonsdk/framework/d;->e()Landroid/net/NetworkInfo;

    move-result-object v0

    if-eqz v0, :cond_1

    invoke-static {}, Lcom/umeng/commonsdk/framework/d;->e()Landroid/net/NetworkInfo;

    move-result-object v0

    invoke-virtual {v0}, Landroid/net/NetworkInfo;->isAvailable()Z

    move-result v0

    if-eqz v0, :cond_1

    .line 72
    const-string v0, "--->>> network isAvailable, check if there are any files to send."

    invoke-static {v0}, Lcom/umeng/commonsdk/statistics/common/e;->c(Ljava/lang/String;)V

    .line 73
    const/4 v0, 0x1

    invoke-static {v0}, Lcom/umeng/commonsdk/framework/d;->a(Z)Z

    .line 74
    const/16 v0, 0x111

    invoke-static {v0}, Lcom/umeng/commonsdk/framework/d;->a(I)V

    .line 75
    invoke-static {}, Lcom/umeng/commonsdk/framework/d;->e()Landroid/net/NetworkInfo;

    move-result-object v0

    invoke-virtual {v0}, Landroid/net/NetworkInfo;->getType()I

    move-result v0

    if-ne v0, v2, :cond_0

    .line 78
    const-string v0, "--->>> wifi connection available, send uop packet now."

    invoke-static {v0}, Lcom/umeng/commonsdk/statistics/common/e;->c(Ljava/lang/String;)V

    .line 80
    new-instance v0, Ljava/lang/Thread;

    new-instance v2, Lcom/umeng/commonsdk/framework/d$1$2;

    invoke-direct {v2, p0, v1}, Lcom/umeng/commonsdk/framework/d$1$2;-><init>(Lcom/umeng/commonsdk/framework/d$1;Landroid/content/Context;)V

    invoke-direct {v0, v2}, Ljava/lang/Thread;-><init>(Ljava/lang/Runnable;)V

    .line 89
    invoke-virtual {v0}, Ljava/lang/Thread;->start()V

    .line 101
    :cond_0
    :goto_0
    return-void

    .line 93
    :cond_1
    const-string v0, "--->>> network disconnected."

    invoke-static {v0}, Lcom/umeng/commonsdk/statistics/common/e;->c(Ljava/lang/String;)V

    .line 94
    const/4 v0, 0x0

    invoke-static {v0}, Lcom/umeng/commonsdk/framework/d;->a(Z)Z
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_0

    goto :goto_0

    .line 96
    :catch_0
    move-exception v0

    .line 97
    invoke-static {v1, v0}, Lcom/umeng/commonsdk/proguard/e;->a(Landroid/content/Context;Ljava/lang/Throwable;)V

    goto :goto_0
.end method
