.class public Lcom/cyjh/mobileanjian/ipc/i;
.super Ljava/lang/Object;
.source "SourceFile"


# static fields
.field public static final a:I = 0x1

.field public static final b:I = 0x2

.field private static c:Lcom/cyjh/mobileanjian/ipc/i; = null

.field private static final j:Ljava/lang/String; = "3rd.need.or.not.m"


# instance fields
.field private d:Landroid/os/Handler;

.field private e:Z

.field private f:Z

.field private g:Z

.field private h:Z

.field private i:I


# direct methods
.method private constructor <init>()V
    .locals 2

    .prologue
    const/4 v0, 0x0

    .line 43
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    .line 34
    iput-boolean v0, p0, Lcom/cyjh/mobileanjian/ipc/i;->e:Z

    .line 35
    iput-boolean v0, p0, Lcom/cyjh/mobileanjian/ipc/i;->f:Z

    .line 36
    iput-boolean v0, p0, Lcom/cyjh/mobileanjian/ipc/i;->g:Z

    .line 37
    iput-boolean v0, p0, Lcom/cyjh/mobileanjian/ipc/i;->h:Z

    .line 44
    new-instance v0, Lcom/cyjh/mobileanjian/ipc/i$1;

    invoke-static {}, Landroid/os/Looper;->getMainLooper()Landroid/os/Looper;

    move-result-object v1

    invoke-direct {v0, p0, v1}, Lcom/cyjh/mobileanjian/ipc/i$1;-><init>(Lcom/cyjh/mobileanjian/ipc/i;Landroid/os/Looper;)V

    iput-object v0, p0, Lcom/cyjh/mobileanjian/ipc/i;->d:Landroid/os/Handler;

    .line 55
    return-void
.end method

.method static synthetic a(Lcom/cyjh/mobileanjian/ipc/i;)Landroid/os/Handler;
    .locals 1

    .prologue
    .line 27
    iget-object v0, p0, Lcom/cyjh/mobileanjian/ipc/i;->d:Landroid/os/Handler;

    return-object v0
.end method

.method public static declared-synchronized a()Lcom/cyjh/mobileanjian/ipc/i;
    .locals 2

    .prologue
    .line 59
    const-class v1, Lcom/cyjh/mobileanjian/ipc/i;

    monitor-enter v1

    :try_start_0
    sget-object v0, Lcom/cyjh/mobileanjian/ipc/i;->c:Lcom/cyjh/mobileanjian/ipc/i;

    if-nez v0, :cond_0

    .line 61
    new-instance v0, Lcom/cyjh/mobileanjian/ipc/i;

    invoke-direct {v0}, Lcom/cyjh/mobileanjian/ipc/i;-><init>()V

    sput-object v0, Lcom/cyjh/mobileanjian/ipc/i;->c:Lcom/cyjh/mobileanjian/ipc/i;

    .line 63
    :cond_0
    sget-object v0, Lcom/cyjh/mobileanjian/ipc/i;->c:Lcom/cyjh/mobileanjian/ipc/i;
    :try_end_0
    .catchall {:try_start_0 .. :try_end_0} :catchall_0

    monitor-exit v1

    return-object v0

    .line 59
    :catchall_0
    move-exception v0

    monitor-exit v1

    throw v0
.end method

.method private a(Z)V
    .locals 3

    .prologue
    .line 229
    new-instance v1, Landroid/content/Intent;

    const-string v0, "try_active_runner_use_other_way"

    invoke-direct {v1, v0}, Landroid/content/Intent;-><init>(Ljava/lang/String;)V

    .line 231
    const-string v0, "active_type"

    const-string v2, "2"

    invoke-virtual {v1, v0, v2}, Landroid/content/Intent;->putExtra(Ljava/lang/String;Ljava/lang/String;)Landroid/content/Intent;

    .line 232
    const-string v2, "active_result"

    if-eqz p1, :cond_0

    const-string v0, "1"

    :goto_0
    invoke-virtual {v1, v2, v0}, Landroid/content/Intent;->putExtra(Ljava/lang/String;Ljava/lang/String;)Landroid/content/Intent;

    .line 233
    invoke-static {}, Lcom/cyjh/mobileanjian/ipc/h;->a()Landroid/app/Application;

    move-result-object v0

    invoke-static {v0}, Landroid/support/v4/content/LocalBroadcastManager;->getInstance(Landroid/content/Context;)Landroid/support/v4/content/LocalBroadcastManager;

    move-result-object v0

    invoke-virtual {v0, v1}, Landroid/support/v4/content/LocalBroadcastManager;->sendBroadcast(Landroid/content/Intent;)Z

    .line 234
    return-void

    .line 232
    :cond_0
    const-string v0, "0"

    goto :goto_0
.end method

.method private static a(Landroid/content/Context;)Z
    .locals 1

    .prologue
    .line 221
    const-string v0, "connectivity"

    invoke-virtual {p0, v0}, Landroid/content/Context;->getSystemService(Ljava/lang/String;)Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Landroid/net/ConnectivityManager;

    .line 222
    invoke-virtual {v0}, Landroid/net/ConnectivityManager;->getActiveNetworkInfo()Landroid/net/NetworkInfo;

    move-result-object v0

    .line 224
    if-eqz v0, :cond_0

    invoke-virtual {v0}, Landroid/net/NetworkInfo;->isConnected()Z

    move-result v0

    if-eqz v0, :cond_0

    const/4 v0, 0x1

    :goto_0
    return v0

    :cond_0
    const/4 v0, 0x0

    goto :goto_0
.end method

.method static synthetic a(Lcom/cyjh/mobileanjian/ipc/i;Z)Z
    .locals 0

    .prologue
    .line 27
    iput-boolean p1, p0, Lcom/cyjh/mobileanjian/ipc/i;->e:Z

    return p1
.end method

.method static synthetic b(Lcom/cyjh/mobileanjian/ipc/i;)Z
    .locals 1

    .prologue
    .line 27
    iget-boolean v0, p0, Lcom/cyjh/mobileanjian/ipc/i;->h:Z

    return v0
.end method

.method static synthetic b(Lcom/cyjh/mobileanjian/ipc/i;Z)Z
    .locals 0

    .prologue
    .line 27
    iput-boolean p1, p0, Lcom/cyjh/mobileanjian/ipc/i;->h:Z

    return p1
.end method

.method static synthetic c(Lcom/cyjh/mobileanjian/ipc/i;Z)Z
    .locals 0

    .prologue
    .line 27
    iput-boolean p1, p0, Lcom/cyjh/mobileanjian/ipc/i;->g:Z

    return p1
.end method

.method private d()V
    .locals 5

    .prologue
    const/4 v3, 0x5

    const/4 v4, 0x1

    .line 106
    iget-boolean v0, p0, Lcom/cyjh/mobileanjian/ipc/i;->e:Z

    if-eqz v0, :cond_0

    .line 108
    iget-object v0, p0, Lcom/cyjh/mobileanjian/ipc/i;->d:Landroid/os/Handler;

    new-instance v1, Ljava/lang/StringBuilder;

    invoke-direct {v1}, Ljava/lang/StringBuilder;-><init>()V

    const-string v2, "3rd root is going on now."

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    const-class v2, Lcom/goldcoast/sdk/domain/EntryPoint;

    invoke-virtual {v2}, Ljava/lang/Class;->getSimpleName()Ljava/lang/String;

    move-result-object v2

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v1

    invoke-virtual {v0, v4, v1}, Landroid/os/Handler;->obtainMessage(ILjava/lang/Object;)Landroid/os/Message;

    move-result-object v0

    invoke-virtual {v0}, Landroid/os/Message;->sendToTarget()V

    .line 217
    :goto_0
    return-void

    .line 113
    :cond_0
    new-instance v0, Ljava/io/File;

    invoke-static {}, Lcom/cyjh/mobileanjian/ipc/h;->a()Landroid/app/Application;

    move-result-object v1

    invoke-virtual {v1}, Landroid/app/Application;->getFilesDir()Ljava/io/File;

    move-result-object v1

    const-string v2, "3rd.need.or.not.m"

    invoke-direct {v0, v1, v2}, Ljava/io/File;-><init>(Ljava/io/File;Ljava/lang/String;)V

    .line 114
    invoke-virtual {v0}, Ljava/io/File;->exists()Z

    move-result v1

    if-nez v1, :cond_1

    invoke-static {}, Lcom/cyjh/mobileanjian/ipc/h;->a()Landroid/app/Application;

    move-result-object v1

    invoke-static {v1}, Lcom/cyjh/mobileanjian/ipc/i;->a(Landroid/content/Context;)Z

    move-result v1

    if-nez v1, :cond_2

    .line 116
    :cond_1
    iget-object v0, p0, Lcom/cyjh/mobileanjian/ipc/i;->d:Landroid/os/Handler;

    const-string v1, "failed because mark file"

    invoke-virtual {v0, v3, v1}, Landroid/os/Handler;->obtainMessage(ILjava/lang/Object;)Landroid/os/Message;

    move-result-object v0

    invoke-virtual {v0}, Landroid/os/Message;->sendToTarget()V

    goto :goto_0

    .line 120
    :cond_2
    iget-boolean v1, p0, Lcom/cyjh/mobileanjian/ipc/i;->h:Z

    if-eqz v1, :cond_4

    .line 122
    iget-boolean v0, p0, Lcom/cyjh/mobileanjian/ipc/i;->g:Z

    if-eqz v0, :cond_3

    .line 124
    iget-object v0, p0, Lcom/cyjh/mobileanjian/ipc/i;->d:Landroid/os/Handler;

    new-instance v1, Lcom/cyjh/mobileanjian/ipc/i$2;

    invoke-direct {v1, p0}, Lcom/cyjh/mobileanjian/ipc/i$2;-><init>(Lcom/cyjh/mobileanjian/ipc/i;)V

    invoke-virtual {v0, v1}, Landroid/os/Handler;->post(Ljava/lang/Runnable;)Z

    goto :goto_0

    .line 136
    :cond_3
    iget-object v0, p0, Lcom/cyjh/mobileanjian/ipc/i;->d:Landroid/os/Handler;

    const-string v1, "result"

    invoke-virtual {v0, v3, v1}, Landroid/os/Handler;->obtainMessage(ILjava/lang/Object;)Landroid/os/Message;

    move-result-object v0

    invoke-virtual {v0}, Landroid/os/Message;->sendToTarget()V

    goto :goto_0

    .line 141
    :cond_4
    iput-boolean v4, p0, Lcom/cyjh/mobileanjian/ipc/i;->e:Z

    .line 142
    iget-object v1, p0, Lcom/cyjh/mobileanjian/ipc/i;->d:Landroid/os/Handler;

    new-instance v2, Ljava/lang/StringBuilder;

    invoke-direct {v2}, Ljava/lang/StringBuilder;-><init>()V

    const-string v3, "Now start 3rd root using "

    invoke-virtual {v2, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    const-class v3, Lcom/goldcoast/sdk/domain/EntryPoint;

    invoke-virtual {v3}, Ljava/lang/Class;->getSimpleName()Ljava/lang/String;

    move-result-object v3

    invoke-virtual {v2, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    invoke-virtual {v2}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v2

    invoke-virtual {v1, v4, v2}, Landroid/os/Handler;->obtainMessage(ILjava/lang/Object;)Landroid/os/Message;

    move-result-object v1

    invoke-virtual {v1}, Landroid/os/Message;->sendToTarget()V

    .line 144
    const-string v1, "analyse entry point"

    invoke-static {v1}, Lcom/cyjh/mobileanjian/ipc/utils/CLog;->i(Ljava/lang/String;)V

    .line 145
    new-instance v1, Lcom/cyjh/mobileanjian/ipc/i$3;

    const-string v2, "third_root_request"

    invoke-direct {v1, p0, v2, v0}, Lcom/cyjh/mobileanjian/ipc/i$3;-><init>(Lcom/cyjh/mobileanjian/ipc/i;Ljava/lang/String;Ljava/io/File;)V

    .line 216
    invoke-virtual {v1}, Lcom/cyjh/mobileanjian/ipc/i$3;->start()V

    goto :goto_0
.end method

.method static synthetic d(Lcom/cyjh/mobileanjian/ipc/i;Z)V
    .locals 0

    .prologue
    .line 27
    invoke-direct {p0, p1}, Lcom/cyjh/mobileanjian/ipc/i;->a(Z)V

    return-void
.end method


# virtual methods
.method public a(I)V
    .locals 0

    .prologue
    .line 68
    iput p1, p0, Lcom/cyjh/mobileanjian/ipc/i;->i:I

    .line 69
    return-void
.end method

.method public b()Z
    .locals 1

    .prologue
    .line 73
    iget-boolean v0, p0, Lcom/cyjh/mobileanjian/ipc/i;->h:Z

    if-eqz v0, :cond_0

    iget-boolean v0, p0, Lcom/cyjh/mobileanjian/ipc/i;->g:Z

    if-eqz v0, :cond_0

    const/4 v0, 0x1

    :goto_0
    return v0

    :cond_0
    const/4 v0, 0x0

    goto :goto_0
.end method

.method public c()V
    .locals 2

    .prologue
    .line 81
    iget-boolean v0, p0, Lcom/cyjh/mobileanjian/ipc/i;->f:Z

    if-eqz v0, :cond_0

    .line 99
    :goto_0
    return-void

    .line 83
    :cond_0
    const/4 v0, 0x1

    iput-boolean v0, p0, Lcom/cyjh/mobileanjian/ipc/i;->f:Z

    .line 84
    invoke-static {}, Lcom/cyjh/mobileanjian/ipc/utils/RootUtil;->isRoot()Z

    move-result v0

    if-eqz v0, :cond_2

    .line 86
    invoke-static {}, Lcom/cyjh/mobileanjian/ipc/j;->b()Lcom/cyjh/mobileanjian/ipc/j;

    move-result-object v0

    invoke-static {}, Lcom/cyjh/mobileanjian/ipc/MqRunner;->getInstance()Lcom/cyjh/mobileanjian/ipc/MqRunner;

    move-result-object v1

    invoke-virtual {v0, v1}, Lcom/cyjh/mobileanjian/ipc/j;->a(Lcom/cyjh/mobileanjian/ipc/interfaces/OnRootApplyCallback;)V

    .line 98
    :cond_1
    :goto_1
    const/4 v0, 0x0

    iput-boolean v0, p0, Lcom/cyjh/mobileanjian/ipc/i;->f:Z

    goto :goto_0

    .line 90
    :cond_2
    new-instance v0, Ljava/lang/StringBuilder;

    invoke-direct {v0}, Ljava/lang/StringBuilder;-><init>()V

    const-string v1, "check EntryPoint "

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-static {}, Lcom/goldcoast/sdk/domain/EntryPoint;->instance()Lcom/goldcoast/sdk/domain/EntryPoint;

    move-result-object v1

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/Object;)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-virtual {v0}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v0

    invoke-static {v0}, Lcom/cyjh/mobileanjian/ipc/utils/CLog;->i(Ljava/lang/String;)V

    .line 91
    invoke-static {}, Lcom/goldcoast/sdk/domain/EntryPoint;->instance()Lcom/goldcoast/sdk/domain/EntryPoint;

    move-result-object v0

    .line 92
    if-eqz v0, :cond_1

    invoke-static {}, Lcom/cyjh/mobileanjian/ipc/h;->f()Lcom/cyjh/mobileanjian/ipc/interfaces/RootProgressListener;

    move-result-object v0

    if-eqz v0, :cond_1

    .line 94
    const-string v0, "start third root..."

    invoke-static {v0}, Lcom/cyjh/mobileanjian/ipc/utils/CLog;->i(Ljava/lang/String;)V

    .line 95
    invoke-direct {p0}, Lcom/cyjh/mobileanjian/ipc/i;->d()V

    goto :goto_1
.end method
