.class public Lcom/umeng/commonsdk/UMConfigureImpl;
.super Ljava/lang/Object;
.source "UMConfigureImpl.java"


# static fields
.field private static a:Lcom/umeng/commonsdk/amap/b;

.field private static b:Z


# direct methods
.method static constructor <clinit>()V
    .locals 1

    .prologue
    .line 33
    const/4 v0, 0x0

    sput-boolean v0, Lcom/umeng/commonsdk/UMConfigureImpl;->b:Z

    return-void
.end method

.method public constructor <init>()V
    .locals 0

    .prologue
    .line 29
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method

.method private static declared-synchronized a(Landroid/content/Context;)V
    .locals 7

    .prologue
    .line 69
    const-class v1, Lcom/umeng/commonsdk/UMConfigureImpl;

    monitor-enter v1

    if-eqz p0, :cond_1

    .line 70
    :try_start_0
    invoke-virtual {p0}, Landroid/content/Context;->getApplicationContext()Landroid/content/Context;

    move-result-object p0

    .line 71
    new-instance v0, Lcom/umeng/commonsdk/amap/a;

    invoke-direct {v0, p0}, Lcom/umeng/commonsdk/amap/a;-><init>(Landroid/content/Context;)V

    .line 72
    if-eqz v0, :cond_3

    invoke-virtual {v0}, Lcom/umeng/commonsdk/amap/a;->a()Ljava/lang/Class;

    move-result-object v0

    if-eqz v0, :cond_3

    .line 73
    invoke-static {p0}, Lcom/umeng/commonsdk/framework/b;->a(Landroid/content/Context;)Ljava/lang/String;

    move-result-object v0

    .line 74
    invoke-virtual {p0}, Landroid/content/Context;->getPackageName()Ljava/lang/String;

    move-result-object v2

    .line 75
    invoke-static {v0}, Landroid/text/TextUtils;->isEmpty(Ljava/lang/CharSequence;)Z

    move-result v3

    if-nez v3, :cond_1

    invoke-static {v2}, Landroid/text/TextUtils;->isEmpty(Ljava/lang/CharSequence;)Z

    move-result v3

    if-nez v3, :cond_1

    invoke-virtual {v0, v2}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v0

    if-eqz v0, :cond_1

    .line 76
    sget-object v0, Lcom/umeng/commonsdk/UMConfigureImpl;->a:Lcom/umeng/commonsdk/amap/b;

    if-nez v0, :cond_0

    .line 77
    new-instance v0, Lcom/umeng/commonsdk/amap/b;

    const/4 v2, 0x1

    const-wide/16 v4, 0x2710

    invoke-direct {v0, p0, v2, v4, v5}, Lcom/umeng/commonsdk/amap/b;-><init>(Landroid/content/Context;IJ)V

    sput-object v0, Lcom/umeng/commonsdk/UMConfigureImpl;->a:Lcom/umeng/commonsdk/amap/b;

    .line 80
    :cond_0
    sget-object v0, Lcom/umeng/commonsdk/UMConfigureImpl;->a:Lcom/umeng/commonsdk/amap/b;

    invoke-virtual {v0}, Lcom/umeng/commonsdk/amap/b;->isAlive()Z

    move-result v0

    if-nez v0, :cond_2

    .line 81
    const-string v0, "AmapLBS"

    const/4 v2, 0x1

    new-array v2, v2, [Ljava/lang/Object;

    const/4 v3, 0x0

    const-string v4, "[lbs-build] begin write LBS"

    aput-object v4, v2, v3

    invoke-static {v0, v2}, Lcom/umeng/commonsdk/statistics/common/e;->a(Ljava/lang/String;[Ljava/lang/Object;)V

    .line 82
    sget-object v0, Lcom/umeng/commonsdk/UMConfigureImpl;->a:Lcom/umeng/commonsdk/amap/b;

    invoke-virtual {v0}, Lcom/umeng/commonsdk/amap/b;->start()V
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_0
    .catchall {:try_start_0 .. :try_end_0} :catchall_0

    .line 97
    :cond_1
    :goto_0
    monitor-exit v1

    return-void

    .line 84
    :cond_2
    :try_start_1
    const-string v0, "AmapLBS"

    const/4 v2, 0x1

    new-array v2, v2, [Ljava/lang/Object;

    const/4 v3, 0x0

    const-string v4, "[lbs-build] not write start"

    aput-object v4, v2, v3

    invoke-static {v0, v2}, Lcom/umeng/commonsdk/statistics/common/e;->a(Ljava/lang/String;[Ljava/lang/Object;)V
    :try_end_1
    .catch Ljava/lang/Throwable; {:try_start_1 .. :try_end_1} :catch_0
    .catchall {:try_start_1 .. :try_end_1} :catchall_0

    goto :goto_0

    .line 91
    :catch_0
    move-exception v0

    .line 93
    :try_start_2
    const-string v2, "AmapLBS"

    const/4 v3, 0x1

    new-array v3, v3, [Ljava/lang/Object;

    const/4 v4, 0x0

    new-instance v5, Ljava/lang/StringBuilder;

    invoke-direct {v5}, Ljava/lang/StringBuilder;-><init>()V

    const-string v6, "e is "

    invoke-virtual {v5, v6}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v5

    invoke-virtual {v0}, Ljava/lang/Throwable;->getMessage()Ljava/lang/String;

    move-result-object v6

    invoke-virtual {v5, v6}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v5

    invoke-virtual {v5}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v5

    aput-object v5, v3, v4

    invoke-static {v2, v3}, Lcom/umeng/commonsdk/statistics/common/e;->c(Ljava/lang/String;[Ljava/lang/Object;)V

    .line 94
    invoke-static {p0, v0}, Lcom/umeng/commonsdk/proguard/e;->a(Landroid/content/Context;Ljava/lang/Throwable;)V
    :try_end_2
    .catchall {:try_start_2 .. :try_end_2} :catchall_0

    goto :goto_0

    .line 69
    :catchall_0
    move-exception v0

    monitor-exit v1

    throw v0

    .line 88
    :cond_3
    :try_start_3
    const-string v0, "AmapLBS"

    const/4 v2, 0x1

    new-array v2, v2, [Ljava/lang/Object;

    const/4 v3, 0x0

    const-string v4, "[lbs-send] not get AMAP !!!"

    aput-object v4, v2, v3

    invoke-static {v0, v2}, Lcom/umeng/commonsdk/statistics/common/e;->a(Ljava/lang/String;[Ljava/lang/Object;)V
    :try_end_3
    .catch Ljava/lang/Throwable; {:try_start_3 .. :try_end_3} :catch_0
    .catchall {:try_start_3 .. :try_end_3} :catchall_0

    goto :goto_0
.end method

.method private static b(Landroid/content/Context;)V
    .locals 3

    .prologue
    .line 101
    if-eqz p0, :cond_0

    .line 102
    :try_start_0
    invoke-static {p0}, Lcom/umeng/commonsdk/framework/b;->a(Landroid/content/Context;)Ljava/lang/String;

    move-result-object v0

    .line 103
    invoke-virtual {p0}, Landroid/content/Context;->getPackageName()Ljava/lang/String;

    move-result-object v1

    .line 104
    invoke-static {v0}, Landroid/text/TextUtils;->isEmpty(Ljava/lang/CharSequence;)Z

    move-result v2

    if-nez v2, :cond_0

    invoke-static {v1}, Landroid/text/TextUtils;->isEmpty(Ljava/lang/CharSequence;)Z

    move-result v2

    if-nez v2, :cond_0

    invoke-virtual {v0, v1}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v0

    if-eqz v0, :cond_0

    .line 106
    new-instance v0, Ljava/lang/Thread;

    new-instance v1, Lcom/umeng/commonsdk/UMConfigureImpl$1;

    invoke-direct {v1, p0}, Lcom/umeng/commonsdk/UMConfigureImpl$1;-><init>(Landroid/content/Context;)V

    invoke-direct {v0, v1}, Ljava/lang/Thread;-><init>(Ljava/lang/Runnable;)V

    .line 124
    invoke-virtual {v0}, Ljava/lang/Thread;->start()V
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_0

    .line 130
    :cond_0
    :goto_0
    return-void

    .line 127
    :catch_0
    move-exception v0

    .line 128
    invoke-static {p0, v0}, Lcom/umeng/commonsdk/proguard/e;->a(Landroid/content/Context;Ljava/lang/Throwable;)V

    goto :goto_0
.end method

.method private static declared-synchronized c(Landroid/content/Context;)V
    .locals 7

    .prologue
    .line 135
    const-class v1, Lcom/umeng/commonsdk/UMConfigureImpl;

    monitor-enter v1

    if-eqz p0, :cond_2

    :try_start_0
    sget-boolean v0, Lcom/umeng/commonsdk/UMConfigureImpl;->b:Z

    if-nez v0, :cond_2

    .line 136
    new-instance v0, Ljava/lang/Thread;

    new-instance v2, Lcom/umeng/commonsdk/UMConfigureImpl$2;

    invoke-direct {v2, p0}, Lcom/umeng/commonsdk/UMConfigureImpl$2;-><init>(Landroid/content/Context;)V

    invoke-direct {v0, v2}, Ljava/lang/Thread;-><init>(Ljava/lang/Runnable;)V

    .line 215
    invoke-virtual {v0}, Ljava/lang/Thread;->start()V

    .line 218
    invoke-static {p0}, Lcom/umeng/commonsdk/framework/b;->a(Landroid/content/Context;)Ljava/lang/String;

    move-result-object v0

    .line 219
    invoke-virtual {p0}, Landroid/content/Context;->getPackageName()Ljava/lang/String;

    move-result-object v2

    .line 220
    invoke-static {v0}, Landroid/text/TextUtils;->isEmpty(Ljava/lang/CharSequence;)Z

    move-result v3

    if-nez v3, :cond_0

    invoke-static {v2}, Landroid/text/TextUtils;->isEmpty(Ljava/lang/CharSequence;)Z

    move-result v3

    if-nez v3, :cond_0

    invoke-virtual {v0, v2}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_1
    .catchall {:try_start_0 .. :try_end_0} :catchall_0

    move-result v0

    if-eqz v0, :cond_0

    .line 222
    :try_start_1
    invoke-static {p0}, Lcom/umeng/commonsdk/proguard/j;->r(Landroid/content/Context;)Ljava/lang/String;
    :try_end_1
    .catch Ljava/lang/Exception; {:try_start_1 .. :try_end_1} :catch_0
    .catch Ljava/lang/Throwable; {:try_start_1 .. :try_end_1} :catch_1
    .catchall {:try_start_1 .. :try_end_1} :catchall_0

    .line 230
    :cond_0
    :goto_0
    :try_start_2
    invoke-static {p0}, Lcom/umeng/commonsdk/proguard/k;->a(Landroid/content/Context;)Lcom/umeng/commonsdk/proguard/k;

    move-result-object v0

    invoke-virtual {v0}, Lcom/umeng/commonsdk/proguard/k;->a()Z

    move-result v0

    if-nez v0, :cond_1

    .line 231
    invoke-static {p0}, Lcom/umeng/commonsdk/proguard/k;->a(Landroid/content/Context;)Lcom/umeng/commonsdk/proguard/k;

    move-result-object v0

    invoke-virtual {v0}, Lcom/umeng/commonsdk/proguard/k;->b()V
    :try_end_2
    .catch Ljava/lang/Throwable; {:try_start_2 .. :try_end_2} :catch_2
    .catchall {:try_start_2 .. :try_end_2} :catchall_0

    .line 239
    :cond_1
    :goto_1
    const/4 v0, 0x1

    :try_start_3
    sput-boolean v0, Lcom/umeng/commonsdk/UMConfigureImpl;->b:Z
    :try_end_3
    .catch Ljava/lang/Throwable; {:try_start_3 .. :try_end_3} :catch_1
    .catchall {:try_start_3 .. :try_end_3} :catchall_0

    .line 248
    :cond_2
    :goto_2
    monitor-exit v1

    return-void

    .line 223
    :catch_0
    move-exception v0

    .line 224
    :try_start_4
    const-string v2, "internal"

    const/4 v3, 0x1

    new-array v3, v3, [Ljava/lang/Object;

    const/4 v4, 0x0

    new-instance v5, Ljava/lang/StringBuilder;

    invoke-direct {v5}, Ljava/lang/StringBuilder;-><init>()V

    const-string v6, "e is "

    invoke-virtual {v5, v6}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v5

    invoke-virtual {v5, v0}, Ljava/lang/StringBuilder;->append(Ljava/lang/Object;)Ljava/lang/StringBuilder;

    move-result-object v5

    invoke-virtual {v5}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v5

    aput-object v5, v3, v4

    invoke-static {v2, v3}, Lcom/umeng/commonsdk/statistics/common/e;->c(Ljava/lang/String;[Ljava/lang/Object;)V

    .line 225
    invoke-static {p0, v0}, Lcom/umeng/commonsdk/proguard/e;->a(Landroid/content/Context;Ljava/lang/Throwable;)V
    :try_end_4
    .catch Ljava/lang/Throwable; {:try_start_4 .. :try_end_4} :catch_1
    .catchall {:try_start_4 .. :try_end_4} :catchall_0

    goto :goto_0

    .line 242
    :catch_1
    move-exception v0

    .line 244
    :try_start_5
    const-string v2, "internal"

    const/4 v3, 0x1

    new-array v3, v3, [Ljava/lang/Object;

    const/4 v4, 0x0

    new-instance v5, Ljava/lang/StringBuilder;

    invoke-direct {v5}, Ljava/lang/StringBuilder;-><init>()V

    const-string v6, "e is "

    invoke-virtual {v5, v6}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v5

    invoke-virtual {v0}, Ljava/lang/Throwable;->getMessage()Ljava/lang/String;

    move-result-object v6

    invoke-virtual {v5, v6}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v5

    invoke-virtual {v5}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v5

    aput-object v5, v3, v4

    invoke-static {v2, v3}, Lcom/umeng/commonsdk/statistics/common/e;->c(Ljava/lang/String;[Ljava/lang/Object;)V

    .line 245
    invoke-static {p0, v0}, Lcom/umeng/commonsdk/proguard/e;->a(Landroid/content/Context;Ljava/lang/Throwable;)V
    :try_end_5
    .catchall {:try_start_5 .. :try_end_5} :catchall_0

    goto :goto_2

    .line 135
    :catchall_0
    move-exception v0

    monitor-exit v1

    throw v0

    .line 233
    :catch_2
    move-exception v0

    .line 234
    :try_start_6
    const-string v2, "internal"

    const/4 v3, 0x1

    new-array v3, v3, [Ljava/lang/Object;

    const/4 v4, 0x0

    new-instance v5, Ljava/lang/StringBuilder;

    invoke-direct {v5}, Ljava/lang/StringBuilder;-><init>()V

    const-string v6, "e is "

    invoke-virtual {v5, v6}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v5

    invoke-virtual {v5, v0}, Ljava/lang/StringBuilder;->append(Ljava/lang/Object;)Ljava/lang/StringBuilder;

    move-result-object v5

    invoke-virtual {v5}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v5

    aput-object v5, v3, v4

    invoke-static {v2, v3}, Lcom/umeng/commonsdk/statistics/common/e;->c(Ljava/lang/String;[Ljava/lang/Object;)V

    .line 235
    invoke-static {p0, v0}, Lcom/umeng/commonsdk/proguard/e;->a(Landroid/content/Context;Ljava/lang/Throwable;)V
    :try_end_6
    .catch Ljava/lang/Throwable; {:try_start_6 .. :try_end_6} :catch_1
    .catchall {:try_start_6 .. :try_end_6} :catchall_0

    goto :goto_1
.end method

.method public static init(Landroid/content/Context;)V
    .locals 1

    .prologue
    .line 36
    if-nez p0, :cond_0

    .line 44
    :goto_0
    return-void

    .line 39
    :cond_0
    invoke-virtual {p0}, Landroid/content/Context;->getApplicationContext()Landroid/content/Context;

    move-result-object v0

    .line 40
    invoke-static {v0}, Lcom/umeng/commonsdk/UMConfigureImpl;->a(Landroid/content/Context;)V

    .line 41
    invoke-static {v0}, Lcom/umeng/commonsdk/UMConfigureImpl;->b(Landroid/content/Context;)V

    .line 42
    invoke-static {v0}, Lcom/umeng/commonsdk/UMConfigureImpl;->c(Landroid/content/Context;)V

    goto :goto_0
.end method
