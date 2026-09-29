.class public final Lcom/king/sdk/i;
.super Ljava/lang/Object;
.source "SourceFile"


# static fields
.field private static b:Lcom/king/sdk/i;


# instance fields
.field private a:Lcom/king/sdk/b;


# direct methods
.method private constructor <init>(Lcom/king/sdk/b;)V
    .locals 0

    .prologue
    .line 26
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    .line 27
    iput-object p1, p0, Lcom/king/sdk/i;->a:Lcom/king/sdk/b;

    .line 28
    return-void
.end method

.method public static declared-synchronized a(Landroid/content/Context;)Lcom/king/sdk/i;
    .locals 4

    .prologue
    .line 327
    const-class v1, Lcom/king/sdk/i;

    monitor-enter v1

    :try_start_0
    sget-object v0, Lcom/king/sdk/i;->b:Lcom/king/sdk/i;

    if-eqz v0, :cond_0

    .line 328
    sget-object v0, Lcom/king/sdk/i;->b:Lcom/king/sdk/i;
    :try_end_0
    .catchall {:try_start_0 .. :try_end_0} :catchall_0

    .line 344
    :goto_0
    monitor-exit v1

    return-object v0

    .line 331
    :cond_0
    :try_start_1
    invoke-static {}, Lcom/king/sdk/a;->a()Lcom/king/sdk/b;

    move-result-object v0

    .line 332
    if-eqz v0, :cond_2

    .line 333
    new-instance v2, Lcom/king/sdk/i;

    invoke-direct {v2, v0}, Lcom/king/sdk/i;-><init>(Lcom/king/sdk/b;)V

    sput-object v2, Lcom/king/sdk/i;->b:Lcom/king/sdk/i;

    .line 344
    :cond_1
    :goto_1
    sget-object v0, Lcom/king/sdk/i;->b:Lcom/king/sdk/i;

    goto :goto_0

    .line 335
    :cond_2
    const/4 v0, 0x0

    new-instance v2, Landroid/content/IntentFilter;

    const-string v3, "GET_KING_SERVICE"

    invoke-direct {v2, v3}, Landroid/content/IntentFilter;-><init>(Ljava/lang/String;)V

    invoke-virtual {p0, v0, v2}, Landroid/content/Context;->registerReceiver(Landroid/content/BroadcastReceiver;Landroid/content/IntentFilter;)Landroid/content/Intent;

    move-result-object v0

    .line 336
    if-eqz v0, :cond_1

    .line 337
    const-string v2, "GET_KING_SERVICE"

    invoke-static {v0, v2}, Lcom/king/sdk/a/a;->a(Landroid/content/Intent;Ljava/lang/String;)Landroid/os/IBinder;

    move-result-object v0

    invoke-static {v0}, Lcom/king/sdk/c;->a(Landroid/os/IBinder;)Lcom/king/sdk/b;

    move-result-object v0

    .line 338
    if-eqz v0, :cond_1

    .line 339
    new-instance v2, Lcom/king/sdk/i;

    invoke-direct {v2, v0}, Lcom/king/sdk/i;-><init>(Lcom/king/sdk/b;)V

    sput-object v2, Lcom/king/sdk/i;->b:Lcom/king/sdk/i;
    :try_end_1
    .catchall {:try_start_1 .. :try_end_1} :catchall_0

    goto :goto_1

    .line 327
    :catchall_0
    move-exception v0

    monitor-exit v1

    throw v0
.end method


# virtual methods
.method public final a(Lcom/king/sdk/IDFEE16B42C8B2890D8FF2860AF5562B1;)V
    .locals 1

    .prologue
    .line 90
    :try_start_0
    iget-object v0, p0, Lcom/king/sdk/i;->a:Lcom/king/sdk/b;

    invoke-interface {v0, p1}, Lcom/king/sdk/b;->a(Lcom/king/sdk/IDFEE16B42C8B2890D8FF2860AF5562B1;)V
    :try_end_0
    .catch Ljava/lang/Exception; {:try_start_0 .. :try_end_0} :catch_0

    .line 93
    :goto_0
    return-void

    :catch_0
    move-exception v0

    goto :goto_0
.end method

.method public final a(Lcom/king/sdk/KingListener;)V
    .locals 1

    .prologue
    .line 102
    :try_start_0
    iget-object v0, p0, Lcom/king/sdk/i;->a:Lcom/king/sdk/b;

    invoke-interface {v0, p1}, Lcom/king/sdk/b;->b(Lcom/king/sdk/IDFEE16B42C8B2890D8FF2860AF5562B1;)V
    :try_end_0
    .catch Ljava/lang/Exception; {:try_start_0 .. :try_end_0} :catch_0

    .line 105
    :goto_0
    return-void

    :catch_0
    move-exception v0

    goto :goto_0
.end method

.method public final a([Ljava/lang/String;ILjava/lang/String;Ljava/lang/String;)V
    .locals 1

    .prologue
    .line 310
    :try_start_0
    iget-object v0, p0, Lcom/king/sdk/i;->a:Lcom/king/sdk/b;

    invoke-interface {v0, p1, p2, p3, p4}, Lcom/king/sdk/b;->a([Ljava/lang/String;ILjava/lang/String;Ljava/lang/String;)V
    :try_end_0
    .catch Ljava/lang/Exception; {:try_start_0 .. :try_end_0} :catch_0

    .line 314
    :goto_0
    return-void

    .line 312
    :catch_0
    move-exception v0

    invoke-virtual {v0}, Ljava/lang/Exception;->printStackTrace()V

    goto :goto_0
.end method

.method public final a(Ljava/lang/String;I[B)Z
    .locals 7

    .prologue
    .line 363
    :try_start_0
    iget-object v0, p0, Lcom/king/sdk/i;->a:Lcom/king/sdk/b;

    const/4 v2, 0x0

    const/4 v5, 0x0

    const/4 v6, 0x0

    move-object v1, p1

    move v3, p2

    move-object v4, p3

    invoke-interface/range {v0 .. v6}, Lcom/king/sdk/b;->a(Ljava/lang/String;Ljava/lang/String;I[BLandroid/app/PendingIntent;Landroid/app/PendingIntent;)Z
    :try_end_0
    .catch Ljava/lang/Exception; {:try_start_0 .. :try_end_0} :catch_0

    move-result v0

    .line 365
    :goto_0
    return v0

    :catch_0
    move-exception v0

    const/4 v0, 0x0

    goto :goto_0
.end method

.method public final a(Ljava/lang/String;Ljava/lang/String;)Z
    .locals 6

    .prologue
    .line 352
    :try_start_0
    iget-object v0, p0, Lcom/king/sdk/i;->a:Lcom/king/sdk/b;

    const/4 v2, 0x0

    const/4 v4, 0x0

    const/4 v5, 0x0

    move-object v1, p1

    move-object v3, p2

    invoke-interface/range {v0 .. v5}, Lcom/king/sdk/b;->a(Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;Landroid/app/PendingIntent;Landroid/app/PendingIntent;)Z
    :try_end_0
    .catch Ljava/lang/Exception; {:try_start_0 .. :try_end_0} :catch_0

    move-result v0

    .line 354
    :goto_0
    return v0

    :catch_0
    move-exception v0

    const/4 v0, 0x0

    goto :goto_0
.end method
