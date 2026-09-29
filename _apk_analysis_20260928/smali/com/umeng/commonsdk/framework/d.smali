.class Lcom/umeng/commonsdk/framework/d;
.super Ljava/lang/Object;
.source "UMNetWorkSender.java"


# annotations
.annotation system Ldalvik/annotation/MemberClasses;
    value = {
        Lcom/umeng/commonsdk/framework/d$a;
    }
.end annotation


# static fields
.field private static a:Landroid/os/HandlerThread; = null

.field private static b:Landroid/os/Handler; = null

.field private static c:Landroid/os/Handler; = null

.field private static final d:I = 0x111

.field private static final e:I = 0x200

.field private static final f:I = 0x301

.field private static g:Lcom/umeng/commonsdk/framework/d$a;

.field private static h:Landroid/net/ConnectivityManager;

.field private static i:Landroid/net/NetworkInfo;

.field private static j:Landroid/content/IntentFilter;

.field private static k:Lcom/umeng/commonsdk/statistics/internal/StatTracer;

.field private static l:Lcom/umeng/commonsdk/statistics/noise/ImLatent;

.field private static m:Z

.field private static n:Landroid/content/BroadcastReceiver;


# direct methods
.method static constructor <clinit>()V
    .locals 1

    .prologue
    const/4 v0, 0x0

    .line 31
    sput-object v0, Lcom/umeng/commonsdk/framework/d;->a:Landroid/os/HandlerThread;

    .line 33
    sput-object v0, Lcom/umeng/commonsdk/framework/d;->b:Landroid/os/Handler;

    .line 35
    sput-object v0, Lcom/umeng/commonsdk/framework/d;->c:Landroid/os/Handler;

    .line 47
    sput-object v0, Lcom/umeng/commonsdk/framework/d;->j:Landroid/content/IntentFilter;

    .line 50
    sput-object v0, Lcom/umeng/commonsdk/framework/d;->k:Lcom/umeng/commonsdk/statistics/internal/StatTracer;

    .line 51
    sput-object v0, Lcom/umeng/commonsdk/framework/d;->l:Lcom/umeng/commonsdk/statistics/noise/ImLatent;

    .line 53
    const/4 v0, 0x0

    sput-boolean v0, Lcom/umeng/commonsdk/framework/d;->m:Z

    .line 55
    new-instance v0, Lcom/umeng/commonsdk/framework/d$1;

    invoke-direct {v0}, Lcom/umeng/commonsdk/framework/d$1;-><init>()V

    sput-object v0, Lcom/umeng/commonsdk/framework/d;->n:Landroid/content/BroadcastReceiver;

    return-void
.end method

.method public constructor <init>(Landroid/content/Context;Landroid/os/Handler;)V
    .locals 3

    .prologue
    .line 108
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    .line 109
    sput-object p2, Lcom/umeng/commonsdk/framework/d;->c:Landroid/os/Handler;

    .line 111
    sget-object v0, Lcom/umeng/commonsdk/framework/d;->a:Landroid/os/HandlerThread;

    if-nez v0, :cond_3

    .line 113
    new-instance v0, Landroid/os/HandlerThread;

    const-string v1, "NetWorkSender"

    invoke-direct {v0, v1}, Landroid/os/HandlerThread;-><init>(Ljava/lang/String;)V

    sput-object v0, Lcom/umeng/commonsdk/framework/d;->a:Landroid/os/HandlerThread;

    .line 114
    sget-object v0, Lcom/umeng/commonsdk/framework/d;->a:Landroid/os/HandlerThread;

    invoke-virtual {v0}, Landroid/os/HandlerThread;->start()V

    .line 115
    sget-object v0, Lcom/umeng/commonsdk/framework/d;->g:Lcom/umeng/commonsdk/framework/d$a;

    if-nez v0, :cond_0

    .line 116
    new-instance v0, Lcom/umeng/commonsdk/framework/d$a;

    invoke-static {p1}, Lcom/umeng/commonsdk/framework/b;->h(Landroid/content/Context;)Ljava/lang/String;

    move-result-object v1

    invoke-direct {v0, v1}, Lcom/umeng/commonsdk/framework/d$a;-><init>(Ljava/lang/String;)V

    sput-object v0, Lcom/umeng/commonsdk/framework/d;->g:Lcom/umeng/commonsdk/framework/d$a;

    .line 117
    sget-object v0, Lcom/umeng/commonsdk/framework/d;->g:Lcom/umeng/commonsdk/framework/d$a;

    invoke-virtual {v0}, Lcom/umeng/commonsdk/framework/d$a;->startWatching()V

    .line 118
    const-string v0, "--->>> FileMonitor has already started!"

    invoke-static {v0}, Lcom/umeng/commonsdk/statistics/common/e;->b(Ljava/lang/String;)V

    .line 120
    :cond_0
    invoke-static {}, Lcom/umeng/commonsdk/framework/c;->a()Landroid/content/Context;

    move-result-object v0

    .line 121
    const-string v1, "android.permission.ACCESS_NETWORK_STATE"

    invoke-static {v0, v1}, Lcom/umeng/commonsdk/statistics/common/DeviceConfig;->checkPermission(Landroid/content/Context;Ljava/lang/String;)Z

    move-result v1

    if-eqz v1, :cond_1

    .line 122
    sget-object v1, Lcom/umeng/commonsdk/framework/d;->j:Landroid/content/IntentFilter;

    if-nez v1, :cond_1

    .line 123
    new-instance v1, Landroid/content/IntentFilter;

    invoke-direct {v1}, Landroid/content/IntentFilter;-><init>()V

    sput-object v1, Lcom/umeng/commonsdk/framework/d;->j:Landroid/content/IntentFilter;

    .line 124
    sget-object v1, Lcom/umeng/commonsdk/framework/d;->j:Landroid/content/IntentFilter;

    const-string v2, "android.net.conn.CONNECTIVITY_CHANGE"

    invoke-virtual {v1, v2}, Landroid/content/IntentFilter;->addAction(Ljava/lang/String;)V

    .line 125
    sget-object v1, Lcom/umeng/commonsdk/framework/d;->n:Landroid/content/BroadcastReceiver;

    if-eqz v1, :cond_1

    .line 126
    sget-object v1, Lcom/umeng/commonsdk/framework/d;->n:Landroid/content/BroadcastReceiver;

    sget-object v2, Lcom/umeng/commonsdk/framework/d;->j:Landroid/content/IntentFilter;

    invoke-virtual {v0, v1, v2}, Landroid/content/Context;->registerReceiver(Landroid/content/BroadcastReceiver;Landroid/content/IntentFilter;)Landroid/content/Intent;

    .line 132
    :cond_1
    sget-object v0, Lcom/umeng/commonsdk/framework/d;->k:Lcom/umeng/commonsdk/statistics/internal/StatTracer;

    if-nez v0, :cond_2

    .line 133
    invoke-static {p1}, Lcom/umeng/commonsdk/statistics/internal/StatTracer;->getInstance(Landroid/content/Context;)Lcom/umeng/commonsdk/statistics/internal/StatTracer;

    move-result-object v0

    sput-object v0, Lcom/umeng/commonsdk/framework/d;->k:Lcom/umeng/commonsdk/statistics/internal/StatTracer;

    .line 134
    sget-object v0, Lcom/umeng/commonsdk/framework/d;->k:Lcom/umeng/commonsdk/statistics/internal/StatTracer;

    invoke-static {p1, v0}, Lcom/umeng/commonsdk/statistics/noise/ImLatent;->getService(Landroid/content/Context;Lcom/umeng/commonsdk/statistics/internal/StatTracer;)Lcom/umeng/commonsdk/statistics/noise/ImLatent;

    move-result-object v0

    sput-object v0, Lcom/umeng/commonsdk/framework/d;->l:Lcom/umeng/commonsdk/statistics/noise/ImLatent;

    .line 137
    :cond_2
    sget-object v0, Lcom/umeng/commonsdk/framework/d;->b:Landroid/os/Handler;

    if-nez v0, :cond_3

    .line 138
    new-instance v0, Lcom/umeng/commonsdk/framework/d$2;

    sget-object v1, Lcom/umeng/commonsdk/framework/d;->a:Landroid/os/HandlerThread;

    invoke-virtual {v1}, Landroid/os/HandlerThread;->getLooper()Landroid/os/Looper;

    move-result-object v1

    invoke-direct {v0, p0, v1}, Lcom/umeng/commonsdk/framework/d$2;-><init>(Lcom/umeng/commonsdk/framework/d;Landroid/os/Looper;)V

    sput-object v0, Lcom/umeng/commonsdk/framework/d;->b:Landroid/os/Handler;

    .line 164
    :cond_3
    return-void
.end method

.method static synthetic a(Landroid/net/ConnectivityManager;)Landroid/net/ConnectivityManager;
    .locals 0

    .prologue
    .line 28
    sput-object p0, Lcom/umeng/commonsdk/framework/d;->h:Landroid/net/ConnectivityManager;

    return-object p0
.end method

.method static synthetic a(Landroid/net/NetworkInfo;)Landroid/net/NetworkInfo;
    .locals 0

    .prologue
    .line 28
    sput-object p0, Lcom/umeng/commonsdk/framework/d;->i:Landroid/net/NetworkInfo;

    return-object p0
.end method

.method public static a()V
    .locals 1

    .prologue
    .line 218
    const/16 v0, 0x200

    invoke-static {v0}, Lcom/umeng/commonsdk/framework/d;->c(I)V

    .line 219
    return-void
.end method

.method static synthetic a(I)V
    .locals 0

    .prologue
    .line 28
    invoke-static {p0}, Lcom/umeng/commonsdk/framework/d;->c(I)V

    return-void
.end method

.method private static a(II)V
    .locals 4

    .prologue
    .line 271
    sget-boolean v0, Lcom/umeng/commonsdk/framework/d;->m:Z

    if-eqz v0, :cond_0

    sget-object v0, Lcom/umeng/commonsdk/framework/d;->c:Landroid/os/Handler;

    if-eqz v0, :cond_0

    .line 272
    sget-object v0, Lcom/umeng/commonsdk/framework/d;->c:Landroid/os/Handler;

    invoke-virtual {v0, p0}, Landroid/os/Handler;->removeMessages(I)V

    .line 273
    sget-object v0, Lcom/umeng/commonsdk/framework/d;->c:Landroid/os/Handler;

    invoke-virtual {v0}, Landroid/os/Handler;->obtainMessage()Landroid/os/Message;

    move-result-object v0

    .line 274
    iput p0, v0, Landroid/os/Message;->what:I

    .line 275
    sget-object v1, Lcom/umeng/commonsdk/framework/d;->c:Landroid/os/Handler;

    int-to-long v2, p1

    invoke-virtual {v1, v0, v2, v3}, Landroid/os/Handler;->sendMessageDelayed(Landroid/os/Message;J)Z

    .line 277
    :cond_0
    return-void
.end method

.method private static a(IJ)V
    .locals 3

    .prologue
    .line 252
    sget-boolean v0, Lcom/umeng/commonsdk/framework/d;->m:Z

    if-eqz v0, :cond_0

    sget-object v0, Lcom/umeng/commonsdk/framework/d;->b:Landroid/os/Handler;

    if-eqz v0, :cond_0

    .line 253
    sget-object v0, Lcom/umeng/commonsdk/framework/d;->b:Landroid/os/Handler;

    invoke-virtual {v0}, Landroid/os/Handler;->obtainMessage()Landroid/os/Message;

    move-result-object v0

    .line 254
    iput p0, v0, Landroid/os/Message;->what:I

    .line 255
    sget-object v1, Lcom/umeng/commonsdk/framework/d;->b:Landroid/os/Handler;

    invoke-virtual {v1, v0, p1, p2}, Landroid/os/Handler;->sendMessageDelayed(Landroid/os/Message;J)Z

    .line 257
    :cond_0
    return-void
.end method

.method static synthetic a(Z)Z
    .locals 0

    .prologue
    .line 28
    sput-boolean p0, Lcom/umeng/commonsdk/framework/d;->m:Z

    return p0
.end method

.method public static b()V
    .locals 1

    .prologue
    .line 263
    const/16 v0, 0x111

    invoke-static {v0}, Lcom/umeng/commonsdk/framework/d;->b(I)V

    .line 264
    return-void
.end method

.method private static b(I)V
    .locals 2

    .prologue
    .line 226
    sget-boolean v0, Lcom/umeng/commonsdk/framework/d;->m:Z

    if-eqz v0, :cond_0

    sget-object v0, Lcom/umeng/commonsdk/framework/d;->b:Landroid/os/Handler;

    if-eqz v0, :cond_0

    .line 227
    sget-object v0, Lcom/umeng/commonsdk/framework/d;->b:Landroid/os/Handler;

    invoke-virtual {v0, p0}, Landroid/os/Handler;->hasMessages(I)Z

    move-result v0

    if-nez v0, :cond_0

    .line 228
    sget-object v0, Lcom/umeng/commonsdk/framework/d;->b:Landroid/os/Handler;

    invoke-virtual {v0}, Landroid/os/Handler;->obtainMessage()Landroid/os/Message;

    move-result-object v0

    .line 229
    iput p0, v0, Landroid/os/Message;->what:I

    .line 230
    sget-object v1, Lcom/umeng/commonsdk/framework/d;->b:Landroid/os/Handler;

    invoke-virtual {v1, v0}, Landroid/os/Handler;->sendMessage(Landroid/os/Message;)Z

    .line 233
    :cond_0
    return-void
.end method

.method public static c()V
    .locals 2

    .prologue
    .line 280
    const/16 v0, 0x301

    const/16 v1, 0xbb8

    invoke-static {v0, v1}, Lcom/umeng/commonsdk/framework/d;->a(II)V

    .line 281
    return-void
.end method

.method private static c(I)V
    .locals 2

    .prologue
    .line 240
    sget-boolean v0, Lcom/umeng/commonsdk/framework/d;->m:Z

    if-eqz v0, :cond_0

    sget-object v0, Lcom/umeng/commonsdk/framework/d;->b:Landroid/os/Handler;

    if-eqz v0, :cond_0

    .line 241
    sget-object v0, Lcom/umeng/commonsdk/framework/d;->b:Landroid/os/Handler;

    invoke-virtual {v0}, Landroid/os/Handler;->obtainMessage()Landroid/os/Message;

    move-result-object v0

    .line 242
    iput p0, v0, Landroid/os/Message;->what:I

    .line 243
    sget-object v1, Lcom/umeng/commonsdk/framework/d;->b:Landroid/os/Handler;

    invoke-virtual {v1, v0}, Landroid/os/Handler;->sendMessage(Landroid/os/Message;)Z

    .line 245
    :cond_0
    return-void
.end method

.method static synthetic d()Landroid/net/ConnectivityManager;
    .locals 1

    .prologue
    .line 28
    sget-object v0, Lcom/umeng/commonsdk/framework/d;->h:Landroid/net/ConnectivityManager;

    return-object v0
.end method

.method static synthetic e()Landroid/net/NetworkInfo;
    .locals 1

    .prologue
    .line 28
    sget-object v0, Lcom/umeng/commonsdk/framework/d;->i:Landroid/net/NetworkInfo;

    return-object v0
.end method

.method static synthetic f()V
    .locals 0

    .prologue
    .line 28
    invoke-static {}, Lcom/umeng/commonsdk/framework/d;->j()V

    return-void
.end method

.method static synthetic g()V
    .locals 0

    .prologue
    .line 28
    invoke-static {}, Lcom/umeng/commonsdk/framework/d;->i()V

    return-void
.end method

.method private static h()V
    .locals 2

    .prologue
    const/4 v1, 0x0

    .line 170
    sget-object v0, Lcom/umeng/commonsdk/framework/d;->a:Landroid/os/HandlerThread;

    if-eqz v0, :cond_0

    .line 171
    sput-object v1, Lcom/umeng/commonsdk/framework/d;->a:Landroid/os/HandlerThread;

    .line 173
    :cond_0
    sget-object v0, Lcom/umeng/commonsdk/framework/d;->b:Landroid/os/Handler;

    if-eqz v0, :cond_1

    .line 174
    sput-object v1, Lcom/umeng/commonsdk/framework/d;->b:Landroid/os/Handler;

    .line 176
    :cond_1
    sget-object v0, Lcom/umeng/commonsdk/framework/d;->c:Landroid/os/Handler;

    if-eqz v0, :cond_2

    .line 177
    sput-object v1, Lcom/umeng/commonsdk/framework/d;->c:Landroid/os/Handler;

    .line 180
    :cond_2
    sget-object v0, Lcom/umeng/commonsdk/framework/d;->l:Lcom/umeng/commonsdk/statistics/noise/ImLatent;

    if-eqz v0, :cond_3

    .line 181
    sput-object v1, Lcom/umeng/commonsdk/framework/d;->l:Lcom/umeng/commonsdk/statistics/noise/ImLatent;

    .line 184
    :cond_3
    sget-object v0, Lcom/umeng/commonsdk/framework/d;->k:Lcom/umeng/commonsdk/statistics/internal/StatTracer;

    if-eqz v0, :cond_4

    .line 185
    sput-object v1, Lcom/umeng/commonsdk/framework/d;->k:Lcom/umeng/commonsdk/statistics/internal/StatTracer;

    .line 187
    :cond_4
    return-void
.end method

.method private static i()V
    .locals 3

    .prologue
    const/4 v2, 0x0

    .line 194
    sget-object v0, Lcom/umeng/commonsdk/framework/d;->g:Lcom/umeng/commonsdk/framework/d$a;

    if-eqz v0, :cond_0

    .line 195
    sget-object v0, Lcom/umeng/commonsdk/framework/d;->g:Lcom/umeng/commonsdk/framework/d$a;

    invoke-virtual {v0}, Lcom/umeng/commonsdk/framework/d$a;->stopWatching()V

    .line 196
    sput-object v2, Lcom/umeng/commonsdk/framework/d;->g:Lcom/umeng/commonsdk/framework/d$a;

    .line 198
    :cond_0
    sget-object v0, Lcom/umeng/commonsdk/framework/d;->j:Landroid/content/IntentFilter;

    if-eqz v0, :cond_2

    .line 199
    sget-object v0, Lcom/umeng/commonsdk/framework/d;->n:Landroid/content/BroadcastReceiver;

    if-eqz v0, :cond_1

    .line 200
    invoke-static {}, Lcom/umeng/commonsdk/framework/c;->a()Landroid/content/Context;

    move-result-object v0

    .line 201
    sget-object v1, Lcom/umeng/commonsdk/framework/d;->n:Landroid/content/BroadcastReceiver;

    invoke-virtual {v0, v1}, Landroid/content/Context;->unregisterReceiver(Landroid/content/BroadcastReceiver;)V

    .line 202
    sput-object v2, Lcom/umeng/commonsdk/framework/d;->n:Landroid/content/BroadcastReceiver;

    .line 204
    :cond_1
    sput-object v2, Lcom/umeng/commonsdk/framework/d;->j:Landroid/content/IntentFilter;

    .line 206
    :cond_2
    const-string v0, "--->>> handleQuit: Quit sender thread."

    invoke-static {v0}, Lcom/umeng/commonsdk/statistics/common/e;->b(Ljava/lang/String;)V

    .line 207
    sget-object v0, Lcom/umeng/commonsdk/framework/d;->a:Landroid/os/HandlerThread;

    if-eqz v0, :cond_3

    .line 208
    sget-object v0, Lcom/umeng/commonsdk/framework/d;->a:Landroid/os/HandlerThread;

    invoke-virtual {v0}, Landroid/os/HandlerThread;->quit()Z

    .line 209
    invoke-static {}, Lcom/umeng/commonsdk/framework/d;->h()V

    .line 212
    :cond_3
    return-void
.end method

.method private static j()V
    .locals 8

    .prologue
    .line 316
    const-string v0, "--->>> handleProcessNext: Enter..."

    invoke-static {v0}, Lcom/umeng/commonsdk/statistics/common/e;->b(Ljava/lang/String;)V

    .line 319
    sget-boolean v0, Lcom/umeng/commonsdk/framework/d;->m:Z

    if-nez v0, :cond_0

    .line 379
    :goto_0
    return-void

    .line 322
    :cond_0
    invoke-static {}, Lcom/umeng/commonsdk/framework/c;->a()Landroid/content/Context;

    move-result-object v1

    .line 324
    :try_start_0
    invoke-static {v1}, Lcom/umeng/commonsdk/framework/b;->c(Landroid/content/Context;)I

    move-result v0

    if-lez v0, :cond_5

    .line 325
    const-string v0, "--->>> The envelope file exists."

    invoke-static {v0}, Lcom/umeng/commonsdk/statistics/common/e;->b(Ljava/lang/String;)V

    .line 326
    invoke-static {v1}, Lcom/umeng/commonsdk/framework/b;->c(Landroid/content/Context;)I

    move-result v0

    const/16 v2, 0x64

    if-le v0, v2, :cond_1

    .line 327
    const-string v0, "--->>> Number of envelope files is greater than 100, remove old files first."

    invoke-static {v0}, Lcom/umeng/commonsdk/statistics/common/e;->b(Ljava/lang/String;)V

    .line 328
    invoke-static {v1}, Lcom/umeng/commonsdk/framework/b;->d(Landroid/content/Context;)V

    .line 331
    :cond_1
    invoke-static {v1}, Lcom/umeng/commonsdk/framework/b;->e(Landroid/content/Context;)Ljava/io/File;

    move-result-object v0

    .line 332
    if-eqz v0, :cond_5

    .line 333
    invoke-virtual {v0}, Ljava/io/File;->getPath()Ljava/lang/String;

    move-result-object v2

    .line 335
    new-instance v3, Ljava/lang/StringBuilder;

    invoke-direct {v3}, Ljava/lang/StringBuilder;-><init>()V

    const-string v4, "--->>> Ready to send envelope file ["

    invoke-virtual {v3, v4}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v3

    invoke-virtual {v3, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    const-string v3, "]."

    invoke-virtual {v2, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    invoke-virtual {v2}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v2

    invoke-static {v2}, Lcom/umeng/commonsdk/statistics/common/e;->b(Ljava/lang/String;)V

    .line 336
    new-instance v2, Lcom/umeng/commonsdk/statistics/d;

    invoke-direct {v2, v1}, Lcom/umeng/commonsdk/statistics/d;-><init>(Landroid/content/Context;)V

    .line 339
    sget-object v3, Lcom/umeng/commonsdk/framework/d;->l:Lcom/umeng/commonsdk/statistics/noise/ImLatent;

    if-eqz v3, :cond_2

    sget-object v3, Lcom/umeng/commonsdk/framework/d;->l:Lcom/umeng/commonsdk/statistics/noise/ImLatent;

    invoke-virtual {v3}, Lcom/umeng/commonsdk/statistics/noise/ImLatent;->isLatentActivite()Z

    move-result v3

    if-eqz v3, :cond_2

    .line 340
    sget-object v3, Lcom/umeng/commonsdk/framework/d;->l:Lcom/umeng/commonsdk/statistics/noise/ImLatent;

    invoke-virtual {v3}, Lcom/umeng/commonsdk/statistics/noise/ImLatent;->latentDeactivite()V

    .line 341
    sget-object v3, Lcom/umeng/commonsdk/framework/d;->l:Lcom/umeng/commonsdk/statistics/noise/ImLatent;

    invoke-virtual {v3}, Lcom/umeng/commonsdk/statistics/noise/ImLatent;->getDelayTime()J

    move-result-wide v4

    .line 342
    const-wide/16 v6, 0x0

    cmp-long v3, v4, v6

    if-lez v3, :cond_2

    .line 343
    new-instance v3, Ljava/lang/StringBuilder;

    invoke-direct {v3}, Ljava/lang/StringBuilder;-><init>()V

    const-string v6, "start lacency policy, wait ["

    invoke-virtual {v3, v6}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v3

    invoke-virtual {v3, v4, v5}, Ljava/lang/StringBuilder;->append(J)Ljava/lang/StringBuilder;

    move-result-object v3

    const-string v6, "] milliseconds ."

    invoke-virtual {v3, v6}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v3

    invoke-virtual {v3}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v3

    invoke-static {v3}, Lcom/umeng/commonsdk/statistics/common/e;->c(Ljava/lang/String;)V
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_0

    .line 345
    const-wide/16 v6, 0x3e8

    mul-long/2addr v4, v6

    :try_start_1
    invoke-static {v4, v5}, Ljava/lang/Thread;->sleep(J)V
    :try_end_1
    .catch Ljava/lang/Throwable; {:try_start_1 .. :try_end_1} :catch_1

    .line 352
    :cond_2
    :goto_1
    :try_start_2
    invoke-virtual {v2, v0}, Lcom/umeng/commonsdk/statistics/d;->a(Ljava/io/File;)Z

    move-result v2

    .line 353
    if-eqz v2, :cond_4

    .line 354
    const-string v2, "--->>> Send envelope file success, delete it."

    invoke-static {v2}, Lcom/umeng/commonsdk/statistics/common/e;->b(Ljava/lang/String;)V

    .line 356
    invoke-static {v0}, Lcom/umeng/commonsdk/framework/b;->a(Ljava/io/File;)Z

    move-result v2

    if-nez v2, :cond_3

    .line 357
    const-string v2, "--->>> Failed to delete already processed file. We try again after delete failed."

    invoke-static {v2}, Lcom/umeng/commonsdk/statistics/common/e;->b(Ljava/lang/String;)V

    .line 358
    invoke-static {v0}, Lcom/umeng/commonsdk/framework/b;->a(Ljava/io/File;)Z

    .line 366
    :cond_3
    const/16 v0, 0x111

    invoke-static {v0}, Lcom/umeng/commonsdk/framework/d;->c(I)V
    :try_end_2
    .catch Ljava/lang/Throwable; {:try_start_2 .. :try_end_2} :catch_0

    goto/16 :goto_0

    .line 376
    :catch_0
    move-exception v0

    .line 377
    invoke-static {v1, v0}, Lcom/umeng/commonsdk/proguard/e;->a(Landroid/content/Context;Ljava/lang/Throwable;)V

    goto/16 :goto_0

    .line 346
    :catch_1
    move-exception v3

    .line 347
    :try_start_3
    invoke-static {v1, v3}, Lcom/umeng/commonsdk/proguard/e;->a(Landroid/content/Context;Ljava/lang/Throwable;)V

    goto :goto_1

    .line 362
    :cond_4
    const-string v0, "--->>> Send envelope file failed, abandon and wait next trigger!"

    invoke-static {v0}, Lcom/umeng/commonsdk/statistics/common/e;->b(Ljava/lang/String;)V

    goto/16 :goto_0

    .line 370
    :cond_5
    const-string v0, "--->>> The envelope file not exists, start auto process for module cache data."

    invoke-static {v0}, Lcom/umeng/commonsdk/statistics/common/e;->b(Ljava/lang/String;)V

    .line 375
    invoke-static {}, Lcom/umeng/commonsdk/framework/d;->c()V
    :try_end_3
    .catch Ljava/lang/Throwable; {:try_start_3 .. :try_end_3} :catch_0

    goto/16 :goto_0
.end method
