.class public Lcom/umeng/commonsdk/proguard/g;
.super Ljava/lang/Object;
.source "UMSysLocation.java"


# static fields
.field private static final a:Ljava/lang/String; = "UMSysLocation"

.field private static final c:I = 0x2710


# instance fields
.field private b:Landroid/location/LocationManager;

.field private d:Z

.field private e:Landroid/content/Context;

.field private f:Landroid/location/LocationListener;

.field private g:Lcom/umeng/commonsdk/proguard/i;


# direct methods
.method private constructor <init>()V
    .locals 1

    .prologue
    .line 37
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    .line 33
    const/4 v0, 0x0

    iput-boolean v0, p0, Lcom/umeng/commonsdk/proguard/g;->d:Z

    .line 59
    new-instance v0, Lcom/umeng/commonsdk/proguard/g$1;

    invoke-direct {v0, p0}, Lcom/umeng/commonsdk/proguard/g$1;-><init>(Lcom/umeng/commonsdk/proguard/g;)V

    iput-object v0, p0, Lcom/umeng/commonsdk/proguard/g;->f:Landroid/location/LocationListener;

    .line 39
    return-void
.end method

.method public constructor <init>(Landroid/content/Context;)V
    .locals 2

    .prologue
    .line 41
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    .line 33
    const/4 v0, 0x0

    iput-boolean v0, p0, Lcom/umeng/commonsdk/proguard/g;->d:Z

    .line 59
    new-instance v0, Lcom/umeng/commonsdk/proguard/g$1;

    invoke-direct {v0, p0}, Lcom/umeng/commonsdk/proguard/g$1;-><init>(Lcom/umeng/commonsdk/proguard/g;)V

    iput-object v0, p0, Lcom/umeng/commonsdk/proguard/g;->f:Landroid/location/LocationListener;

    .line 42
    if-nez p1, :cond_0

    .line 44
    const-string v0, "Context\u53c2\u6570\u4e0d\u80fd\u4e3anull"

    invoke-static {v0}, Lcom/umeng/commonsdk/statistics/common/MLog;->e(Ljava/lang/String;)V

    .line 49
    :goto_0
    return-void

    .line 46
    :cond_0
    invoke-virtual {p1}, Landroid/content/Context;->getApplicationContext()Landroid/content/Context;

    move-result-object v0

    iput-object v0, p0, Lcom/umeng/commonsdk/proguard/g;->e:Landroid/content/Context;

    .line 47
    invoke-virtual {p1}, Landroid/content/Context;->getApplicationContext()Landroid/content/Context;

    move-result-object v0

    const-string v1, "location"

    invoke-virtual {v0, v1}, Landroid/content/Context;->getSystemService(Ljava/lang/String;)Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Landroid/location/LocationManager;

    iput-object v0, p0, Lcom/umeng/commonsdk/proguard/g;->b:Landroid/location/LocationManager;

    goto :goto_0
.end method

.method static synthetic a(Lcom/umeng/commonsdk/proguard/g;)Lcom/umeng/commonsdk/proguard/i;
    .locals 1

    .prologue
    .line 17
    iget-object v0, p0, Lcom/umeng/commonsdk/proguard/g;->g:Lcom/umeng/commonsdk/proguard/i;

    return-object v0
.end method

.method static synthetic a(Lcom/umeng/commonsdk/proguard/g;Z)Z
    .locals 0

    .prologue
    .line 17
    iput-boolean p1, p0, Lcom/umeng/commonsdk/proguard/g;->d:Z

    return p1
.end method

.method static synthetic b(Lcom/umeng/commonsdk/proguard/g;)Landroid/content/Context;
    .locals 1

    .prologue
    .line 17
    iget-object v0, p0, Lcom/umeng/commonsdk/proguard/g;->e:Landroid/content/Context;

    return-object v0
.end method

.method static synthetic c(Lcom/umeng/commonsdk/proguard/g;)Z
    .locals 1

    .prologue
    .line 17
    iget-boolean v0, p0, Lcom/umeng/commonsdk/proguard/g;->d:Z

    return v0
.end method

.method static synthetic d(Lcom/umeng/commonsdk/proguard/g;)Landroid/location/LocationManager;
    .locals 1

    .prologue
    .line 17
    iget-object v0, p0, Lcom/umeng/commonsdk/proguard/g;->b:Landroid/location/LocationManager;

    return-object v0
.end method

.method static synthetic e(Lcom/umeng/commonsdk/proguard/g;)Landroid/location/LocationListener;
    .locals 1

    .prologue
    .line 17
    iget-object v0, p0, Lcom/umeng/commonsdk/proguard/g;->f:Landroid/location/LocationListener;

    return-object v0
.end method


# virtual methods
.method public declared-synchronized a()V
    .locals 4

    .prologue
    .line 194
    monitor-enter p0

    :try_start_0
    const-string v0, "UMSysLocation"

    const/4 v1, 0x1

    new-array v1, v1, [Ljava/lang/Object;

    const/4 v2, 0x0

    const-string v3, "destroy"

    aput-object v3, v1, v2

    invoke-static {v0, v1}, Lcom/umeng/commonsdk/statistics/common/e;->a(Ljava/lang/String;[Ljava/lang/Object;)V
    :try_end_0
    .catchall {:try_start_0 .. :try_end_0} :catchall_0

    .line 197
    :try_start_1
    iget-object v0, p0, Lcom/umeng/commonsdk/proguard/g;->e:Landroid/content/Context;

    const-string v1, "android.permission.ACCESS_COARSE_LOCATION"

    invoke-static {v0, v1}, Lcom/umeng/commonsdk/utils/UMUtils;->checkPermission(Landroid/content/Context;Ljava/lang/String;)Z

    move-result v0

    if-eqz v0, :cond_0

    iget-object v0, p0, Lcom/umeng/commonsdk/proguard/g;->e:Landroid/content/Context;

    const-string v1, "android.permission.ACCESS_FINE_LOCATION"

    invoke-static {v0, v1}, Lcom/umeng/commonsdk/utils/UMUtils;->checkPermission(Landroid/content/Context;Ljava/lang/String;)Z
    :try_end_1
    .catch Ljava/lang/Throwable; {:try_start_1 .. :try_end_1} :catch_0
    .catchall {:try_start_1 .. :try_end_1} :catchall_0

    move-result v0

    if-nez v0, :cond_1

    .line 220
    :cond_0
    :goto_0
    monitor-exit p0

    return-void

    .line 201
    :cond_1
    :try_start_2
    iget-object v0, p0, Lcom/umeng/commonsdk/proguard/g;->b:Landroid/location/LocationManager;

    if-eqz v0, :cond_0

    .line 202
    iget-object v0, p0, Lcom/umeng/commonsdk/proguard/g;->f:Landroid/location/LocationListener;
    :try_end_2
    .catch Ljava/lang/Throwable; {:try_start_2 .. :try_end_2} :catch_0
    .catchall {:try_start_2 .. :try_end_2} :catchall_0

    if-eqz v0, :cond_2

    .line 204
    :try_start_3
    iget-object v0, p0, Lcom/umeng/commonsdk/proguard/g;->b:Landroid/location/LocationManager;

    iget-object v1, p0, Lcom/umeng/commonsdk/proguard/g;->f:Landroid/location/LocationListener;

    invoke-virtual {v0, v1}, Landroid/location/LocationManager;->removeUpdates(Landroid/location/LocationListener;)V
    :try_end_3
    .catch Ljava/lang/RuntimeException; {:try_start_3 .. :try_end_3} :catch_2
    .catch Ljava/lang/Throwable; {:try_start_3 .. :try_end_3} :catch_1
    .catchall {:try_start_3 .. :try_end_3} :catchall_0

    .line 211
    :cond_2
    :goto_1
    const/4 v0, 0x0

    :try_start_4
    iput-object v0, p0, Lcom/umeng/commonsdk/proguard/g;->b:Landroid/location/LocationManager;
    :try_end_4
    .catch Ljava/lang/Throwable; {:try_start_4 .. :try_end_4} :catch_0
    .catchall {:try_start_4 .. :try_end_4} :catchall_0

    goto :goto_0

    .line 216
    :catch_0
    move-exception v0

    .line 217
    :try_start_5
    iget-object v1, p0, Lcom/umeng/commonsdk/proguard/g;->e:Landroid/content/Context;

    invoke-static {v1, v0}, Lcom/umeng/commonsdk/proguard/e;->a(Landroid/content/Context;Ljava/lang/Throwable;)V
    :try_end_5
    .catchall {:try_start_5 .. :try_end_5} :catchall_0

    goto :goto_0

    .line 194
    :catchall_0
    move-exception v0

    monitor-exit p0

    throw v0

    .line 207
    :catch_1
    move-exception v0

    goto :goto_1

    .line 205
    :catch_2
    move-exception v0

    goto :goto_1
.end method

.method public declared-synchronized a(Lcom/umeng/commonsdk/proguard/i;)V
    .locals 6

    .prologue
    .line 89
    monitor-enter p0

    :try_start_0
    const-string v0, "UMSysLocation"

    const/4 v1, 0x1

    new-array v1, v1, [Ljava/lang/Object;

    const/4 v2, 0x0

    const-string v3, "getSystemLocation"

    aput-object v3, v1, v2

    invoke-static {v0, v1}, Lcom/umeng/commonsdk/statistics/common/e;->a(Ljava/lang/String;[Ljava/lang/Object;)V

    .line 91
    if-eqz p1, :cond_0

    iget-object v0, p0, Lcom/umeng/commonsdk/proguard/g;->e:Landroid/content/Context;
    :try_end_0
    .catchall {:try_start_0 .. :try_end_0} :catchall_0

    if-nez v0, :cond_1

    .line 190
    :cond_0
    :goto_0
    monitor-exit p0

    return-void

    .line 95
    :cond_1
    :try_start_1
    iput-object p1, p0, Lcom/umeng/commonsdk/proguard/g;->g:Lcom/umeng/commonsdk/proguard/i;

    .line 97
    iget-object v0, p0, Lcom/umeng/commonsdk/proguard/g;->e:Landroid/content/Context;

    const-string v1, "android.permission.ACCESS_COARSE_LOCATION"

    invoke-static {v0, v1}, Lcom/umeng/commonsdk/utils/UMUtils;->checkPermission(Landroid/content/Context;Ljava/lang/String;)Z

    move-result v0

    if-eqz v0, :cond_2

    iget-object v0, p0, Lcom/umeng/commonsdk/proguard/g;->e:Landroid/content/Context;

    const-string v1, "android.permission.ACCESS_FINE_LOCATION"

    invoke-static {v0, v1}, Lcom/umeng/commonsdk/utils/UMUtils;->checkPermission(Landroid/content/Context;Ljava/lang/String;)Z

    move-result v0

    if-nez v0, :cond_3

    .line 98
    :cond_2
    iget-object v0, p0, Lcom/umeng/commonsdk/proguard/g;->g:Lcom/umeng/commonsdk/proguard/i;

    if-eqz v0, :cond_0

    .line 99
    iget-object v0, p0, Lcom/umeng/commonsdk/proguard/g;->g:Lcom/umeng/commonsdk/proguard/i;

    const/4 v1, 0x0

    invoke-virtual {v0, v1}, Lcom/umeng/commonsdk/proguard/i;->a(Landroid/location/Location;)V
    :try_end_1
    .catchall {:try_start_1 .. :try_end_1} :catchall_0

    goto :goto_0

    .line 89
    :catchall_0
    move-exception v0

    monitor-exit p0

    throw v0

    .line 105
    :cond_3
    const/4 v0, 0x1

    :try_start_2
    iput-boolean v0, p0, Lcom/umeng/commonsdk/proguard/g;->d:Z

    .line 107
    iget-object v0, p0, Lcom/umeng/commonsdk/proguard/g;->b:Landroid/location/LocationManager;

    if-eqz v0, :cond_5

    iget-object v0, p0, Lcom/umeng/commonsdk/proguard/g;->b:Landroid/location/LocationManager;

    const-string v1, "network"

    invoke-virtual {v0, v1}, Landroid/location/LocationManager;->isProviderEnabled(Ljava/lang/String;)Z

    move-result v0

    if-eqz v0, :cond_5

    .line 108
    const-string v0, "UMSysLocation"

    const/4 v1, 0x1

    new-array v1, v1, [Ljava/lang/Object;

    const/4 v2, 0x0

    const-string v3, "NETWORK_PROVIDER"

    aput-object v3, v1, v2

    invoke-static {v0, v1}, Lcom/umeng/commonsdk/statistics/common/e;->a(Ljava/lang/String;[Ljava/lang/Object;)V

    .line 109
    iget-object v0, p0, Lcom/umeng/commonsdk/proguard/g;->b:Landroid/location/LocationManager;

    const-string v1, "network"

    const-wide/16 v2, 0x3e8

    const/4 v4, 0x0

    iget-object v5, p0, Lcom/umeng/commonsdk/proguard/g;->f:Landroid/location/LocationListener;

    invoke-virtual/range {v0 .. v5}, Landroid/location/LocationManager;->requestLocationUpdates(Ljava/lang/String;JFLandroid/location/LocationListener;)V

    .line 111
    new-instance v0, Ljava/util/Timer;

    invoke-direct {v0}, Ljava/util/Timer;-><init>()V

    .line 112
    new-instance v1, Lcom/umeng/commonsdk/proguard/g$2;

    invoke-direct {v1, p0, v0}, Lcom/umeng/commonsdk/proguard/g$2;-><init>(Lcom/umeng/commonsdk/proguard/g;Ljava/util/Timer;)V

    .line 138
    const-wide/16 v2, 0x2710

    invoke-virtual {v0, v1, v2, v3}, Ljava/util/Timer;->schedule(Ljava/util/TimerTask;J)V
    :try_end_2
    .catch Ljava/lang/Throwable; {:try_start_2 .. :try_end_2} :catch_0
    .catchall {:try_start_2 .. :try_end_2} :catchall_0

    goto :goto_0

    .line 177
    :catch_0
    move-exception v0

    .line 178
    :try_start_3
    const-string v1, "UMSysLocation"

    const/4 v2, 0x1

    new-array v2, v2, [Ljava/lang/Object;

    const/4 v3, 0x0

    new-instance v4, Ljava/lang/StringBuilder;

    invoke-direct {v4}, Ljava/lang/StringBuilder;-><init>()V

    const-string v5, "e is "

    invoke-virtual {v4, v5}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v4

    invoke-virtual {v4, v0}, Ljava/lang/StringBuilder;->append(Ljava/lang/Object;)Ljava/lang/StringBuilder;

    move-result-object v4

    invoke-virtual {v4}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v4

    aput-object v4, v2, v3

    invoke-static {v1, v2}, Lcom/umeng/commonsdk/statistics/common/e;->a(Ljava/lang/String;[Ljava/lang/Object;)V
    :try_end_3
    .catchall {:try_start_3 .. :try_end_3} :catchall_0

    .line 180
    if-eqz p1, :cond_4

    .line 181
    const/4 v1, 0x0

    :try_start_4
    invoke-virtual {p1, v1}, Lcom/umeng/commonsdk/proguard/i;->a(Landroid/location/Location;)V
    :try_end_4
    .catch Ljava/lang/Throwable; {:try_start_4 .. :try_end_4} :catch_1
    .catchall {:try_start_4 .. :try_end_4} :catchall_0

    .line 187
    :cond_4
    :goto_1
    :try_start_5
    iget-object v1, p0, Lcom/umeng/commonsdk/proguard/g;->e:Landroid/content/Context;

    invoke-static {v1, v0}, Lcom/umeng/commonsdk/proguard/e;->a(Landroid/content/Context;Ljava/lang/Throwable;)V
    :try_end_5
    .catchall {:try_start_5 .. :try_end_5} :catchall_0

    goto/16 :goto_0

    .line 143
    :cond_5
    :try_start_6
    iget-object v0, p0, Lcom/umeng/commonsdk/proguard/g;->b:Landroid/location/LocationManager;

    const-string v1, "gps"

    invoke-virtual {v0, v1}, Landroid/location/LocationManager;->isProviderEnabled(Ljava/lang/String;)Z

    move-result v0

    if-eqz v0, :cond_0

    .line 144
    const-string v0, "UMSysLocation"

    const/4 v1, 0x1

    new-array v1, v1, [Ljava/lang/Object;

    const/4 v2, 0x0

    const-string v3, "GPS_PROVIDER"

    aput-object v3, v1, v2

    invoke-static {v0, v1}, Lcom/umeng/commonsdk/statistics/common/e;->a(Ljava/lang/String;[Ljava/lang/Object;)V

    .line 145
    iget-object v0, p0, Lcom/umeng/commonsdk/proguard/g;->b:Landroid/location/LocationManager;

    const-string v1, "gps"

    const-wide/16 v2, 0x3e8

    const/4 v4, 0x0

    iget-object v5, p0, Lcom/umeng/commonsdk/proguard/g;->f:Landroid/location/LocationListener;

    invoke-virtual/range {v0 .. v5}, Landroid/location/LocationManager;->requestLocationUpdates(Ljava/lang/String;JFLandroid/location/LocationListener;)V

    .line 147
    new-instance v0, Ljava/util/Timer;

    invoke-direct {v0}, Ljava/util/Timer;-><init>()V

    .line 148
    new-instance v1, Lcom/umeng/commonsdk/proguard/g$3;

    invoke-direct {v1, p0, v0}, Lcom/umeng/commonsdk/proguard/g$3;-><init>(Lcom/umeng/commonsdk/proguard/g;Ljava/util/Timer;)V

    .line 175
    const-wide/16 v2, 0x2710

    invoke-virtual {v0, v1, v2, v3}, Ljava/util/Timer;->schedule(Ljava/util/TimerTask;J)V
    :try_end_6
    .catch Ljava/lang/Throwable; {:try_start_6 .. :try_end_6} :catch_0
    .catchall {:try_start_6 .. :try_end_6} :catchall_0

    goto/16 :goto_0

    .line 183
    :catch_1
    move-exception v1

    .line 184
    :try_start_7
    iget-object v2, p0, Lcom/umeng/commonsdk/proguard/g;->e:Landroid/content/Context;

    invoke-static {v2, v1}, Lcom/umeng/commonsdk/proguard/e;->a(Landroid/content/Context;Ljava/lang/Throwable;)V
    :try_end_7
    .catchall {:try_start_7 .. :try_end_7} :catchall_0

    goto :goto_1
.end method
