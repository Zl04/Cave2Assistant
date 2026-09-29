.class public Lcom/umeng/analytics/pro/i;
.super Ljava/lang/Object;
.source "CoreProtocolImpl.java"


# annotations
.annotation system Ldalvik/annotation/MemberClasses;
    value = {
        Lcom/umeng/analytics/pro/i$c;,
        Lcom/umeng/analytics/pro/i$a;,
        Lcom/umeng/analytics/pro/i$d;,
        Lcom/umeng/analytics/pro/i$b;
    }
.end annotation


# static fields
.field private static A:Z = false

.field private static final B:Ljava/lang/String; = "n_sess_dp"

.field private static final C:Ljava/lang/String; = "n_sess_dp_type"

.field private static a:Landroid/content/Context; = null

.field private static final q:Ljava/lang/String; = "first_activate_time"

.field private static final r:Ljava/lang/String; = "ana_is_f"

.field private static final s:Ljava/lang/String; = "thtstart"

.field private static final t:Ljava/lang/String; = "dstk_last_time"

.field private static final u:Ljava/lang/String; = "dstk_cnt"

.field private static final v:Ljava/lang/String; = "gkvc"

.field private static final w:Ljava/lang/String; = "ekvc"

.field private static final y:Ljava/lang/String; = "-1"

.field private static z:Z


# instance fields
.field private b:Lcom/umeng/commonsdk/statistics/noise/ABTest;

.field private c:Lcom/umeng/commonsdk/statistics/noise/ImLatent;

.field private d:Lcom/umeng/analytics/pro/i$c;

.field private e:Landroid/content/SharedPreferences;

.field private f:Ljava/lang/String;

.field private g:Ljava/lang/String;

.field private h:Ljava/lang/String;

.field private i:Ljava/lang/String;

.field private j:J

.field private k:I

.field private l:Lorg/json/JSONArray;

.field private final m:I

.field private n:I

.field private o:I

.field private p:J

.field private final x:J


# direct methods
.method static constructor <clinit>()V
    .locals 2

    .prologue
    const/4 v1, 0x0

    .line 45
    const/4 v0, 0x0

    sput-object v0, Lcom/umeng/analytics/pro/i;->a:Landroid/content/Context;

    .line 77
    sput-boolean v1, Lcom/umeng/analytics/pro/i;->z:Z

    .line 83
    sput-boolean v1, Lcom/umeng/analytics/pro/i;->A:Z

    return-void
.end method

.method private constructor <init>()V
    .locals 4

    .prologue
    const-wide/16 v2, 0x0

    const/4 v1, 0x0

    const/4 v0, 0x0

    .line 88
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    .line 46
    iput-object v0, p0, Lcom/umeng/analytics/pro/i;->b:Lcom/umeng/commonsdk/statistics/noise/ABTest;

    .line 47
    iput-object v0, p0, Lcom/umeng/analytics/pro/i;->c:Lcom/umeng/commonsdk/statistics/noise/ImLatent;

    .line 48
    iput-object v0, p0, Lcom/umeng/analytics/pro/i;->d:Lcom/umeng/analytics/pro/i$c;

    .line 50
    iput-object v0, p0, Lcom/umeng/analytics/pro/i;->e:Landroid/content/SharedPreferences;

    .line 51
    iput-object v0, p0, Lcom/umeng/analytics/pro/i;->f:Ljava/lang/String;

    .line 52
    iput-object v0, p0, Lcom/umeng/analytics/pro/i;->g:Ljava/lang/String;

    .line 54
    iput-object v0, p0, Lcom/umeng/analytics/pro/i;->h:Ljava/lang/String;

    .line 55
    iput-object v0, p0, Lcom/umeng/analytics/pro/i;->i:Ljava/lang/String;

    .line 57
    iput-wide v2, p0, Lcom/umeng/analytics/pro/i;->j:J

    .line 59
    const/16 v0, 0xa

    iput v0, p0, Lcom/umeng/analytics/pro/i;->k:I

    .line 61
    new-instance v0, Lorg/json/JSONArray;

    invoke-direct {v0}, Lorg/json/JSONArray;-><init>()V

    iput-object v0, p0, Lcom/umeng/analytics/pro/i;->l:Lorg/json/JSONArray;

    .line 62
    const/16 v0, 0x1388

    iput v0, p0, Lcom/umeng/analytics/pro/i;->m:I

    .line 63
    iput v1, p0, Lcom/umeng/analytics/pro/i;->n:I

    .line 64
    iput v1, p0, Lcom/umeng/analytics/pro/i;->o:I

    .line 65
    iput-wide v2, p0, Lcom/umeng/analytics/pro/i;->p:J

    .line 73
    const-wide/32 v0, 0x1b77400

    iput-wide v0, p0, Lcom/umeng/analytics/pro/i;->x:J

    .line 90
    :try_start_0
    sget-object v0, Lcom/umeng/analytics/pro/i;->a:Landroid/content/Context;

    invoke-static {v0}, Lcom/umeng/commonsdk/statistics/internal/PreferenceWrapper;->getDefault(Landroid/content/Context;)Landroid/content/SharedPreferences;

    move-result-object v0

    .line 91
    const-string v1, "thtstart"

    const-wide/16 v2, 0x0

    invoke-interface {v0, v1, v2, v3}, Landroid/content/SharedPreferences;->getLong(Ljava/lang/String;J)J

    move-result-wide v2

    iput-wide v2, p0, Lcom/umeng/analytics/pro/i;->p:J

    .line 92
    const-string v1, "gkvc"

    const/4 v2, 0x0

    invoke-interface {v0, v1, v2}, Landroid/content/SharedPreferences;->getInt(Ljava/lang/String;I)I

    move-result v1

    iput v1, p0, Lcom/umeng/analytics/pro/i;->n:I

    .line 93
    const-string v1, "ekvc"

    const/4 v2, 0x0

    invoke-interface {v0, v1, v2}, Landroid/content/SharedPreferences;->getInt(Ljava/lang/String;I)I

    move-result v0

    iput v0, p0, Lcom/umeng/analytics/pro/i;->o:I

    .line 94
    new-instance v0, Lcom/umeng/analytics/pro/i$c;

    invoke-direct {v0, p0}, Lcom/umeng/analytics/pro/i$c;-><init>(Lcom/umeng/analytics/pro/i;)V

    iput-object v0, p0, Lcom/umeng/analytics/pro/i;->d:Lcom/umeng/analytics/pro/i$c;

    .line 95
    sget-object v0, Lcom/umeng/analytics/pro/i;->a:Landroid/content/Context;

    invoke-static {v0}, Lcom/umeng/commonsdk/statistics/noise/ABTest;->getService(Landroid/content/Context;)Lcom/umeng/commonsdk/statistics/noise/ABTest;

    move-result-object v0

    iput-object v0, p0, Lcom/umeng/analytics/pro/i;->b:Lcom/umeng/commonsdk/statistics/noise/ABTest;

    .line 96
    sget-object v0, Lcom/umeng/analytics/pro/i;->a:Landroid/content/Context;

    sget-object v1, Lcom/umeng/analytics/pro/i;->a:Landroid/content/Context;

    invoke-static {v1}, Lcom/umeng/commonsdk/statistics/internal/StatTracer;->getInstance(Landroid/content/Context;)Lcom/umeng/commonsdk/statistics/internal/StatTracer;

    move-result-object v1

    invoke-static {v0, v1}, Lcom/umeng/commonsdk/statistics/noise/ImLatent;->getService(Landroid/content/Context;Lcom/umeng/commonsdk/statistics/internal/StatTracer;)Lcom/umeng/commonsdk/statistics/noise/ImLatent;

    move-result-object v0

    iput-object v0, p0, Lcom/umeng/analytics/pro/i;->c:Lcom/umeng/commonsdk/statistics/noise/ImLatent;
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_0

    .line 98
    :goto_0
    return-void

    .line 97
    :catch_0
    move-exception v0

    goto :goto_0
.end method

.method synthetic constructor <init>(Lcom/umeng/analytics/pro/i$1;)V
    .locals 0

    .prologue
    .line 43
    invoke-direct {p0}, Lcom/umeng/analytics/pro/i;-><init>()V

    return-void
.end method

.method public static a(Landroid/content/Context;)Lcom/umeng/analytics/pro/i;
    .locals 1

    .prologue
    .line 105
    sget-object v0, Lcom/umeng/analytics/pro/i;->a:Landroid/content/Context;

    if-nez v0, :cond_0

    .line 106
    if-eqz p0, :cond_0

    .line 107
    invoke-virtual {p0}, Landroid/content/Context;->getApplicationContext()Landroid/content/Context;

    move-result-object v0

    sput-object v0, Lcom/umeng/analytics/pro/i;->a:Landroid/content/Context;

    .line 110
    :cond_0
    invoke-static {}, Lcom/umeng/analytics/pro/i$b;->a()Lcom/umeng/analytics/pro/i;

    move-result-object v0

    return-object v0
.end method

.method static synthetic a(Lcom/umeng/analytics/pro/i;)Lcom/umeng/commonsdk/statistics/noise/ABTest;
    .locals 1

    .prologue
    .line 43
    iget-object v0, p0, Lcom/umeng/analytics/pro/i;->b:Lcom/umeng/commonsdk/statistics/noise/ABTest;

    return-object v0
.end method

.method private a(Lorg/json/JSONObject;J)Lorg/json/JSONObject;
    .locals 4

    .prologue
    .line 606
    :try_start_0
    invoke-static {p1}, Lcom/umeng/analytics/pro/k;->a(Lorg/json/JSONObject;)J

    move-result-wide v0

    cmp-long v0, v0, p2

    if-lez v0, :cond_0

    .line 607
    const-string v0, "header"

    invoke-virtual {p1, v0}, Lorg/json/JSONObject;->getJSONObject(Ljava/lang/String;)Lorg/json/JSONObject;

    move-result-object v0

    .line 609
    const-string v1, "eof"

    invoke-static {p1}, Lcom/umeng/analytics/pro/k;->a(Lorg/json/JSONObject;)J

    move-result-wide v2

    invoke-virtual {v0, v1, v2, v3}, Lorg/json/JSONObject;->put(Ljava/lang/String;J)Lorg/json/JSONObject;

    .line 610
    const-string v1, "header"

    invoke-virtual {p1, v1, v0}, Lorg/json/JSONObject;->put(Ljava/lang/String;Ljava/lang/Object;)Lorg/json/JSONObject;

    .line 613
    sget-object v0, Lcom/umeng/analytics/pro/i;->a:Landroid/content/Context;

    invoke-static {v0, p2, p3, p1}, Lcom/umeng/analytics/pro/k;->a(Landroid/content/Context;JLorg/json/JSONObject;)Lorg/json/JSONObject;
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_0

    move-result-object p1

    .line 617
    :cond_0
    :goto_0
    return-object p1

    .line 616
    :catch_0
    move-exception v0

    goto :goto_0
.end method

.method private a(JI)Z
    .locals 7

    .prologue
    const/4 v0, 0x1

    .line 1078
    const-wide/16 v2, 0x0

    cmp-long v1, p1, v2

    if-eqz v1, :cond_0

    .line 1083
    invoke-static {}, Ljava/lang/System;->currentTimeMillis()J

    move-result-wide v2

    .line 1084
    sub-long/2addr v2, p1

    const-wide/32 v4, 0x1b77400

    cmp-long v1, v2, v4

    if-lez v1, :cond_1

    .line 1085
    invoke-direct {p0}, Lcom/umeng/analytics/pro/i;->j()V

    .line 1095
    :cond_0
    :goto_0
    return v0

    .line 1088
    :cond_1
    const/16 v1, 0x1388

    if-lt p3, v1, :cond_0

    .line 1091
    const/4 v0, 0x0

    goto :goto_0
.end method

.method private b(Lorg/json/JSONObject;)V
    .locals 7

    .prologue
    .line 1364
    if-nez p1, :cond_1

    .line 1429
    :cond_0
    :goto_0
    return-void

    .line 1366
    :cond_1
    :try_start_0
    invoke-virtual {p1}, Lorg/json/JSONObject;->length()I

    move-result v0

    if-lez v0, :cond_0

    .line 1367
    new-instance v1, Lorg/json/JSONObject;

    invoke-direct {v1}, Lorg/json/JSONObject;-><init>()V

    .line 1369
    const-string v0, "analytics"

    invoke-virtual {p1, v0}, Lorg/json/JSONObject;->has(Ljava/lang/String;)Z

    move-result v0

    if-eqz v0, :cond_a

    .line 1370
    const-string v0, "analytics"

    invoke-virtual {p1, v0}, Lorg/json/JSONObject;->getJSONObject(Ljava/lang/String;)Lorg/json/JSONObject;

    move-result-object v2

    .line 1371
    const-string v0, "ekv"

    invoke-virtual {v2, v0}, Lorg/json/JSONObject;->has(Ljava/lang/String;)Z

    move-result v0

    if-eqz v0, :cond_2

    .line 1372
    const-string v0, "ekv"

    invoke-virtual {v2, v0}, Lorg/json/JSONObject;->getJSONArray(Ljava/lang/String;)Lorg/json/JSONArray;

    move-result-object v0

    .line 1373
    const-string v3, "ekv"

    invoke-virtual {v1, v3, v0}, Lorg/json/JSONObject;->put(Ljava/lang/String;Ljava/lang/Object;)Lorg/json/JSONObject;

    .line 1375
    :cond_2
    const-string v0, "gkv"

    invoke-virtual {v2, v0}, Lorg/json/JSONObject;->has(Ljava/lang/String;)Z

    move-result v0

    if-eqz v0, :cond_3

    .line 1376
    const-string v0, "gkv"

    invoke-virtual {v2, v0}, Lorg/json/JSONObject;->getJSONArray(Ljava/lang/String;)Lorg/json/JSONArray;

    move-result-object v0

    .line 1377
    const-string v3, "gkv"

    invoke-virtual {v1, v3, v0}, Lorg/json/JSONObject;->put(Ljava/lang/String;Ljava/lang/Object;)Lorg/json/JSONObject;

    .line 1379
    :cond_3
    const-string v0, "error"

    invoke-virtual {v2, v0}, Lorg/json/JSONObject;->has(Ljava/lang/String;)Z

    move-result v0

    if-eqz v0, :cond_4

    .line 1380
    const-string v0, "error"

    invoke-virtual {v2, v0}, Lorg/json/JSONObject;->getJSONArray(Ljava/lang/String;)Lorg/json/JSONArray;

    move-result-object v0

    .line 1381
    const-string v3, "error"

    invoke-virtual {v1, v3, v0}, Lorg/json/JSONObject;->put(Ljava/lang/String;Ljava/lang/Object;)Lorg/json/JSONObject;

    .line 1383
    :cond_4
    const-string v0, "sessions"

    invoke-virtual {v2, v0}, Lorg/json/JSONObject;->has(Ljava/lang/String;)Z

    move-result v0

    if-eqz v0, :cond_8

    .line 1384
    const-string v0, "sessions"

    invoke-virtual {v2, v0}, Lorg/json/JSONObject;->getJSONArray(Ljava/lang/String;)Lorg/json/JSONArray;

    move-result-object v3

    .line 1386
    new-instance v4, Lorg/json/JSONArray;

    invoke-direct {v4}, Lorg/json/JSONArray;-><init>()V

    .line 1388
    const/4 v0, 0x0

    :goto_1
    invoke-virtual {v3}, Lorg/json/JSONArray;->length()I

    move-result v5

    if-ge v0, v5, :cond_7

    .line 1389
    invoke-virtual {v3, v0}, Lorg/json/JSONArray;->getJSONObject(I)Lorg/json/JSONObject;

    move-result-object v5

    .line 1390
    if-eqz v5, :cond_6

    invoke-virtual {v5}, Lorg/json/JSONObject;->length()I

    move-result v6

    if-lez v6, :cond_6

    .line 1391
    const-string v6, "autopages"

    invoke-virtual {v5, v6}, Lorg/json/JSONObject;->has(Ljava/lang/String;)Z

    move-result v6

    if-eqz v6, :cond_5

    .line 1392
    const-string v6, "autopages"

    invoke-virtual {v5, v6}, Lorg/json/JSONObject;->remove(Ljava/lang/String;)Ljava/lang/Object;

    .line 1394
    :cond_5
    invoke-virtual {v4, v5}, Lorg/json/JSONArray;->put(Ljava/lang/Object;)Lorg/json/JSONArray;

    .line 1388
    :cond_6
    add-int/lit8 v0, v0, 0x1

    goto :goto_1

    .line 1397
    :cond_7
    const-string v0, "sessions"

    invoke-virtual {v1, v0, v4}, Lorg/json/JSONObject;->put(Ljava/lang/String;Ljava/lang/Object;)Lorg/json/JSONObject;

    .line 1399
    :cond_8
    const-string v0, "activate_msg"

    invoke-virtual {v2, v0}, Lorg/json/JSONObject;->has(Ljava/lang/String;)Z

    move-result v0

    if-eqz v0, :cond_9

    .line 1400
    const-string v0, "activate_msg"

    invoke-virtual {v2, v0}, Lorg/json/JSONObject;->getJSONObject(Ljava/lang/String;)Lorg/json/JSONObject;

    move-result-object v0

    .line 1401
    const-string v3, "activate_msg"

    invoke-virtual {v1, v3, v0}, Lorg/json/JSONObject;->put(Ljava/lang/String;Ljava/lang/Object;)Lorg/json/JSONObject;

    .line 1403
    :cond_9
    const-string v0, "active_user"

    invoke-virtual {v2, v0}, Lorg/json/JSONObject;->has(Ljava/lang/String;)Z

    move-result v0

    if-eqz v0, :cond_a

    .line 1404
    const-string v0, "active_user"

    invoke-virtual {v2, v0}, Lorg/json/JSONObject;->getJSONObject(Ljava/lang/String;)Lorg/json/JSONObject;

    move-result-object v0

    .line 1405
    const-string v2, "active_user"

    invoke-virtual {v1, v2, v0}, Lorg/json/JSONObject;->put(Ljava/lang/String;Ljava/lang/Object;)Lorg/json/JSONObject;

    .line 1409
    :cond_a
    const-string v0, "dplus"

    invoke-virtual {p1, v0}, Lorg/json/JSONObject;->has(Ljava/lang/String;)Z

    move-result v0

    if-eqz v0, :cond_b

    .line 1410
    const-string v0, "dplus"

    invoke-virtual {p1, v0}, Lorg/json/JSONObject;->getJSONObject(Ljava/lang/String;)Lorg/json/JSONObject;

    move-result-object v0

    .line 1411
    const-string v2, "dplus"

    invoke-virtual {v1, v2, v0}, Lorg/json/JSONObject;->put(Ljava/lang/String;Ljava/lang/Object;)Lorg/json/JSONObject;

    .line 1414
    :cond_b
    const-string v0, "header"

    invoke-virtual {p1, v0}, Lorg/json/JSONObject;->has(Ljava/lang/String;)Z

    move-result v0

    if-eqz v0, :cond_c

    .line 1415
    const-string v0, "header"

    invoke-virtual {p1, v0}, Lorg/json/JSONObject;->getJSONObject(Ljava/lang/String;)Lorg/json/JSONObject;

    move-result-object v0

    .line 1416
    const-string v2, "sdk_version"

    const-string v3, "sdk_version"

    invoke-virtual {v0, v3}, Lorg/json/JSONObject;->getString(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v3

    invoke-virtual {v1, v2, v3}, Lorg/json/JSONObject;->put(Ljava/lang/String;Ljava/lang/Object;)Lorg/json/JSONObject;

    .line 1417
    const-string v2, "device_id"

    const-string v3, "device_id"

    invoke-virtual {v0, v3}, Lorg/json/JSONObject;->getString(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v3

    invoke-virtual {v1, v2, v3}, Lorg/json/JSONObject;->put(Ljava/lang/String;Ljava/lang/Object;)Lorg/json/JSONObject;

    .line 1418
    const-string v2, "device_model"

    const-string v3, "device_model"

    invoke-virtual {v0, v3}, Lorg/json/JSONObject;->getString(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v3

    invoke-virtual {v1, v2, v3}, Lorg/json/JSONObject;->put(Ljava/lang/String;Ljava/lang/Object;)Lorg/json/JSONObject;

    .line 1419
    const-string v2, "version"

    const-string v3, "version_code"

    invoke-virtual {v0, v3}, Lorg/json/JSONObject;->getString(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v3

    invoke-virtual {v1, v2, v3}, Lorg/json/JSONObject;->put(Ljava/lang/String;Ljava/lang/Object;)Lorg/json/JSONObject;

    .line 1420
    const-string v2, "appkey"

    const-string v3, "appkey"

    invoke-virtual {v0, v3}, Lorg/json/JSONObject;->getString(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v3

    invoke-virtual {v1, v2, v3}, Lorg/json/JSONObject;->put(Ljava/lang/String;Ljava/lang/Object;)Lorg/json/JSONObject;

    .line 1421
    const-string v2, "channel"

    const-string v3, "channel"

    invoke-virtual {v0, v3}, Lorg/json/JSONObject;->getString(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v0

    invoke-virtual {v1, v2, v0}, Lorg/json/JSONObject;->put(Ljava/lang/String;Ljava/lang/Object;)Lorg/json/JSONObject;

    .line 1424
    :cond_c
    invoke-virtual {v1}, Lorg/json/JSONObject;->length()I

    move-result v0

    if-lez v0, :cond_0

    new-instance v0, Ljava/lang/StringBuilder;

    invoke-direct {v0}, Ljava/lang/StringBuilder;-><init>()V

    const-string v2, "constructMessage:"

    invoke-virtual {v0, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-virtual {v1}, Lorg/json/JSONObject;->toString()Ljava/lang/String;

    move-result-object v1

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-virtual {v0}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v0

    invoke-static {v0}, Lcom/umeng/commonsdk/statistics/common/MLog;->d(Ljava/lang/String;)V
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_0

    goto/16 :goto_0

    .line 1426
    :catch_0
    move-exception v0

    .line 1427
    invoke-static {v0}, Lcom/umeng/commonsdk/statistics/common/MLog;->e(Ljava/lang/Throwable;)V

    goto/16 :goto_0
.end method

.method private c(Lorg/json/JSONObject;)V
    .locals 4

    .prologue
    .line 1481
    :try_start_0
    const-string v0, "header"

    invoke-virtual {p1, v0}, Lorg/json/JSONObject;->getJSONObject(Ljava/lang/String;)Lorg/json/JSONObject;

    move-result-object v0

    .line 1482
    const-string v1, "eof"

    invoke-virtual {v0, v1}, Lorg/json/JSONObject;->has(Ljava/lang/String;)Z

    move-result v0

    if-eqz v0, :cond_6

    .line 1484
    const-string v0, "content"

    invoke-virtual {p1, v0}, Lorg/json/JSONObject;->has(Ljava/lang/String;)Z

    move-result v0

    if-eqz v0, :cond_0

    .line 1485
    const-string v0, "content"

    invoke-virtual {p1, v0}, Lorg/json/JSONObject;->getJSONObject(Ljava/lang/String;)Lorg/json/JSONObject;

    move-result-object p1

    .line 1489
    :cond_0
    const-string v0, "analytics"

    invoke-virtual {p1, v0}, Lorg/json/JSONObject;->has(Ljava/lang/String;)Z

    move-result v0

    if-eqz v0, :cond_3

    .line 1494
    const-string v0, "analytics"

    invoke-virtual {p1, v0}, Lorg/json/JSONObject;->getJSONObject(Ljava/lang/String;)Lorg/json/JSONObject;

    move-result-object v0

    .line 1496
    const-string v1, "sessions"

    invoke-virtual {v0, v1}, Lorg/json/JSONObject;->has(Ljava/lang/String;)Z

    move-result v1

    if-eqz v1, :cond_2

    .line 1497
    const-string v1, "sessions"

    invoke-virtual {v0, v1}, Lorg/json/JSONObject;->getJSONArray(Ljava/lang/String;)Lorg/json/JSONArray;

    move-result-object v0

    .line 1498
    const/4 v1, 0x0

    invoke-virtual {v0, v1}, Lorg/json/JSONArray;->getJSONObject(I)Lorg/json/JSONObject;

    move-result-object v0

    .line 1499
    if-eqz v0, :cond_1

    .line 1500
    const-string v1, "id"

    invoke-virtual {v0, v1}, Lorg/json/JSONObject;->getString(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v0

    .line 1501
    sget-object v1, Lcom/umeng/analytics/pro/i;->a:Landroid/content/Context;

    invoke-static {v1}, Lcom/umeng/analytics/pro/g;->a(Landroid/content/Context;)Lcom/umeng/analytics/pro/g;

    move-result-object v1

    const/4 v2, 0x1

    invoke-virtual {v1, v2, v0}, Lcom/umeng/analytics/pro/g;->a(ZLjava/lang/String;)V

    .line 1521
    :cond_1
    :goto_0
    sget-object v0, Lcom/umeng/analytics/pro/i;->a:Landroid/content/Context;

    invoke-static {v0}, Lcom/umeng/analytics/pro/g;->a(Landroid/content/Context;)Lcom/umeng/analytics/pro/g;

    move-result-object v0

    invoke-virtual {v0}, Lcom/umeng/analytics/pro/g;->a()V

    .line 1553
    :goto_1
    return-void

    .line 1504
    :cond_2
    sget-object v0, Lcom/umeng/analytics/pro/i;->a:Landroid/content/Context;

    invoke-static {v0}, Lcom/umeng/analytics/pro/g;->a(Landroid/content/Context;)Lcom/umeng/analytics/pro/g;

    move-result-object v0

    invoke-virtual {v0}, Lcom/umeng/analytics/pro/g;->g()V

    goto :goto_0

    .line 1551
    :catch_0
    move-exception v0

    goto :goto_1

    .line 1506
    :cond_3
    const-string v0, "dplus"

    invoke-virtual {p1, v0}, Lorg/json/JSONObject;->has(Ljava/lang/String;)Z

    move-result v0

    if-eqz v0, :cond_1

    .line 1510
    const-string v0, "dplus"

    invoke-virtual {p1, v0}, Lorg/json/JSONObject;->getJSONObject(Ljava/lang/String;)Lorg/json/JSONObject;

    move-result-object v0

    .line 1511
    const-string v1, "events"

    invoke-virtual {v0, v1}, Lorg/json/JSONObject;->has(Ljava/lang/String;)Z

    move-result v1

    if-eqz v1, :cond_4

    .line 1512
    sget-object v1, Lcom/umeng/analytics/pro/i;->a:Landroid/content/Context;

    invoke-static {v1}, Lcom/umeng/analytics/pro/g;->a(Landroid/content/Context;)Lcom/umeng/analytics/pro/g;

    move-result-object v1

    const/4 v2, 0x0

    invoke-virtual {v1, v2}, Lcom/umeng/analytics/pro/g;->b(I)V

    .line 1514
    :cond_4
    const-string v1, "session"

    invoke-virtual {v0, v1}, Lorg/json/JSONObject;->has(Ljava/lang/String;)Z

    move-result v1

    if-eqz v1, :cond_5

    .line 1515
    sget-object v1, Lcom/umeng/analytics/pro/i;->a:Landroid/content/Context;

    invoke-static {v1}, Lcom/umeng/analytics/pro/g;->a(Landroid/content/Context;)Lcom/umeng/analytics/pro/g;

    move-result-object v1

    const/4 v2, 0x4

    invoke-virtual {v1, v2}, Lcom/umeng/analytics/pro/g;->b(I)V

    .line 1517
    :cond_5
    const-string v1, "pageview"

    invoke-virtual {v0, v1}, Lorg/json/JSONObject;->has(Ljava/lang/String;)Z

    move-result v0

    if-eqz v0, :cond_1

    .line 1518
    sget-object v0, Lcom/umeng/analytics/pro/i;->a:Landroid/content/Context;

    invoke-static {v0}, Lcom/umeng/analytics/pro/g;->a(Landroid/content/Context;)Lcom/umeng/analytics/pro/g;

    move-result-object v0

    const/4 v1, 0x1

    invoke-virtual {v0, v1}, Lcom/umeng/analytics/pro/g;->b(I)V

    goto :goto_0

    .line 1525
    :cond_6
    const-string v0, "content"

    invoke-virtual {p1, v0}, Lorg/json/JSONObject;->has(Ljava/lang/String;)Z

    move-result v0

    if-eqz v0, :cond_7

    .line 1526
    const-string v0, "content"

    invoke-virtual {p1, v0}, Lorg/json/JSONObject;->getJSONObject(Ljava/lang/String;)Lorg/json/JSONObject;

    move-result-object p1

    .line 1529
    :cond_7
    const-string v0, "analytics"

    invoke-virtual {p1, v0}, Lorg/json/JSONObject;->has(Ljava/lang/String;)Z

    move-result v0

    if-eqz v0, :cond_b

    .line 1530
    const-string v0, "analytics"

    invoke-virtual {p1, v0}, Lorg/json/JSONObject;->optJSONObject(Ljava/lang/String;)Lorg/json/JSONObject;

    move-result-object v0

    .line 1531
    if-eqz v0, :cond_b

    invoke-virtual {v0}, Lorg/json/JSONObject;->length()I

    move-result v1

    if-lez v1, :cond_b

    .line 1533
    const-string v1, "sessions"

    invoke-virtual {v0, v1}, Lorg/json/JSONObject;->has(Ljava/lang/String;)Z

    move-result v1

    if-eqz v1, :cond_8

    .line 1534
    sget-object v1, Lcom/umeng/analytics/pro/i;->a:Landroid/content/Context;

    invoke-static {v1}, Lcom/umeng/analytics/pro/g;->a(Landroid/content/Context;)Lcom/umeng/analytics/pro/g;

    move-result-object v1

    const/4 v2, 0x1

    const/4 v3, 0x0

    invoke-virtual {v1, v2, v3}, Lcom/umeng/analytics/pro/g;->a(ZZ)V

    .line 1536
    :cond_8
    const-string v1, "ekv"

    invoke-virtual {v0, v1}, Lorg/json/JSONObject;->has(Ljava/lang/String;)Z

    move-result v1

    if-nez v1, :cond_9

    const-string v1, "gkv"

    invoke-virtual {v0, v1}, Lorg/json/JSONObject;->has(Ljava/lang/String;)Z

    move-result v1

    if-eqz v1, :cond_a

    .line 1537
    :cond_9
    sget-object v1, Lcom/umeng/analytics/pro/i;->a:Landroid/content/Context;

    invoke-static {v1}, Lcom/umeng/analytics/pro/g;->a(Landroid/content/Context;)Lcom/umeng/analytics/pro/g;

    move-result-object v1

    invoke-virtual {v1}, Lcom/umeng/analytics/pro/g;->d()V

    .line 1540
    :cond_a
    const-string v1, "error"

    invoke-virtual {v0, v1}, Lorg/json/JSONObject;->has(Ljava/lang/String;)Z

    move-result v0

    if-eqz v0, :cond_b

    .line 1541
    sget-object v0, Lcom/umeng/analytics/pro/i;->a:Landroid/content/Context;

    invoke-static {v0}, Lcom/umeng/analytics/pro/g;->a(Landroid/content/Context;)Lcom/umeng/analytics/pro/g;

    move-result-object v0

    invoke-virtual {v0}, Lcom/umeng/analytics/pro/g;->e()V

    .line 1545
    :cond_b
    const-string v0, "dplus"

    invoke-virtual {p1, v0}, Lorg/json/JSONObject;->has(Ljava/lang/String;)Z

    move-result v0

    if-eqz v0, :cond_c

    .line 1546
    sget-object v0, Lcom/umeng/analytics/pro/i;->a:Landroid/content/Context;

    invoke-static {v0}, Lcom/umeng/analytics/pro/g;->a(Landroid/content/Context;)Lcom/umeng/analytics/pro/g;

    move-result-object v0

    invoke-virtual {v0}, Lcom/umeng/analytics/pro/g;->f()V

    .line 1549
    :cond_c
    sget-object v0, Lcom/umeng/analytics/pro/i;->a:Landroid/content/Context;

    invoke-static {v0}, Lcom/umeng/analytics/pro/g;->a(Landroid/content/Context;)Lcom/umeng/analytics/pro/g;

    move-result-object v0

    invoke-virtual {v0}, Lcom/umeng/analytics/pro/g;->a()V
    :try_end_0
    .catch Ljava/lang/Exception; {:try_start_0 .. :try_end_0} :catch_0

    goto/16 :goto_1
.end method

.method private c(Z)V
    .locals 3

    .prologue
    .line 404
    new-instance v0, Lorg/json/JSONObject;

    invoke-direct {v0}, Lorg/json/JSONObject;-><init>()V

    .line 405
    if-eqz p1, :cond_1

    .line 406
    sget-boolean v1, Lcom/umeng/analytics/AnalyticsConfig;->FLAG_DPLUS:Z

    if-eqz v1, :cond_3

    .line 409
    sget-object v0, Lcom/umeng/analytics/pro/i;->a:Landroid/content/Context;

    invoke-static {v0}, Lcom/umeng/commonsdk/framework/UMEnvelopeBuild;->maxDataSpace(Landroid/content/Context;)J

    move-result-wide v0

    invoke-virtual {p0, v0, v1}, Lcom/umeng/analytics/pro/i;->b(J)Lorg/json/JSONObject;

    move-result-object v0

    move-object v1, v0

    .line 417
    :goto_0
    if-eqz v1, :cond_0

    invoke-virtual {v1}, Lorg/json/JSONObject;->length()I

    move-result v0

    const/4 v2, 0x1

    if-ge v0, v2, :cond_2

    .line 434
    :cond_0
    :goto_1
    return-void

    .line 414
    :cond_1
    sget-object v0, Lcom/umeng/analytics/pro/i;->a:Landroid/content/Context;

    invoke-static {v0}, Lcom/umeng/commonsdk/framework/UMEnvelopeBuild;->maxDataSpace(Landroid/content/Context;)J

    move-result-wide v0

    invoke-virtual {p0, v0, v1}, Lcom/umeng/analytics/pro/i;->a(J)Lorg/json/JSONObject;

    move-result-object v0

    move-object v1, v0

    goto :goto_0

    .line 418
    :cond_2
    const-string v0, "header"

    invoke-virtual {v1, v0}, Lorg/json/JSONObject;->opt(Ljava/lang/String;)Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Lorg/json/JSONObject;

    .line 419
    const-string v2, "content"

    invoke-virtual {v1, v2}, Lorg/json/JSONObject;->opt(Ljava/lang/String;)Ljava/lang/Object;

    move-result-object v1

    check-cast v1, Lorg/json/JSONObject;

    .line 421
    sget-object v2, Lcom/umeng/analytics/pro/i;->a:Landroid/content/Context;

    if-eqz v2, :cond_0

    if-eqz v0, :cond_0

    if-eqz v1, :cond_0

    .line 423
    sget-object v2, Lcom/umeng/analytics/pro/i;->a:Landroid/content/Context;

    invoke-static {v2, v0, v1}, Lcom/umeng/commonsdk/framework/UMEnvelopeBuild;->buildEnvelopeWithExtHeader(Landroid/content/Context;Lorg/json/JSONObject;Lorg/json/JSONObject;)Lorg/json/JSONObject;

    move-result-object v0

    .line 426
    if-eqz v0, :cond_0

    .line 427
    invoke-direct {p0, v0}, Lcom/umeng/analytics/pro/i;->b(Lorg/json/JSONObject;)V

    .line 429
    invoke-virtual {p0, v0}, Lcom/umeng/analytics/pro/i;->a(Ljava/lang/Object;)V

    goto :goto_1

    :cond_3
    move-object v1, v0

    goto :goto_0
.end method

.method private d(Z)Lorg/json/JSONObject;
    .locals 8

    .prologue
    .line 621
    new-instance v1, Lorg/json/JSONObject;

    invoke-direct {v1}, Lorg/json/JSONObject;-><init>()V

    .line 623
    :try_start_0
    sget-object v0, Lcom/umeng/analytics/AnalyticsConfig;->mWrapperType:Ljava/lang/String;

    if-eqz v0, :cond_0

    sget-object v0, Lcom/umeng/analytics/AnalyticsConfig;->mWrapperVersion:Ljava/lang/String;

    if-eqz v0, :cond_0

    .line 624
    const-string v0, "wrapper_version"

    sget-object v2, Lcom/umeng/analytics/AnalyticsConfig;->mWrapperVersion:Ljava/lang/String;

    invoke-virtual {v1, v0, v2}, Lorg/json/JSONObject;->put(Ljava/lang/String;Ljava/lang/Object;)Lorg/json/JSONObject;

    .line 625
    const-string v0, "wrapper_type"

    sget-object v2, Lcom/umeng/analytics/AnalyticsConfig;->mWrapperType:Ljava/lang/String;

    invoke-virtual {v1, v0, v2}, Lorg/json/JSONObject;->put(Ljava/lang/String;Ljava/lang/Object;)Lorg/json/JSONObject;

    .line 628
    :cond_0
    sget-object v0, Lcom/umeng/analytics/pro/i;->a:Landroid/content/Context;

    invoke-static {v0}, Lcom/umeng/analytics/AnalyticsConfig;->getVerticalType(Landroid/content/Context;)I

    move-result v0

    .line 629
    sget-object v2, Lcom/umeng/analytics/MobclickAgent$EScenarioType;->E_DUM_NORMAL:Lcom/umeng/analytics/MobclickAgent$EScenarioType;

    invoke-virtual {v2}, Lcom/umeng/analytics/MobclickAgent$EScenarioType;->toValue()I

    move-result v2

    if-ne v0, v2, :cond_4

    .line 630
    const/4 v0, 0x1

    sput-boolean v0, Lcom/umeng/analytics/AnalyticsConfig;->FLAG_DPLUS:Z

    .line 631
    sget-object v0, Lcom/umeng/analytics/MobclickAgent$EScenarioType;->E_UM_NORMAL:Lcom/umeng/analytics/MobclickAgent$EScenarioType;

    invoke-virtual {v0}, Lcom/umeng/analytics/MobclickAgent$EScenarioType;->toValue()I

    move-result v0

    .line 638
    :goto_0
    const-string v2, "vertical_type"

    invoke-virtual {v1, v2, v0}, Lorg/json/JSONObject;->put(Ljava/lang/String;I)Lorg/json/JSONObject;

    .line 639
    const-string v0, "sdk_version"

    const-string v2, "7.3.2"

    invoke-virtual {v1, v0, v2}, Lorg/json/JSONObject;->put(Ljava/lang/String;Ljava/lang/Object;)Lorg/json/JSONObject;

    .line 642
    sget-object v0, Lcom/umeng/analytics/pro/i;->a:Landroid/content/Context;

    invoke-static {v0}, Lcom/umeng/analytics/AnalyticsConfig;->getSecretKey(Landroid/content/Context;)Ljava/lang/String;

    move-result-object v0

    invoke-static {v0}, Lcom/umeng/commonsdk/statistics/common/HelperUtils;->MD5(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v0

    .line 643
    invoke-static {v0}, Landroid/text/TextUtils;->isEmpty(Ljava/lang/CharSequence;)Z

    move-result v2

    if-nez v2, :cond_1

    .line 644
    const-string v2, "secret"

    invoke-virtual {v1, v2, v0}, Lorg/json/JSONObject;->put(Ljava/lang/String;Ljava/lang/Object;)Lorg/json/JSONObject;

    .line 647
    :cond_1
    sget-object v0, Lcom/umeng/analytics/pro/i;->a:Landroid/content/Context;

    const-string v2, "pr_ve"

    const/4 v3, 0x0

    invoke-static {v0, v2, v3}, Lcom/umeng/commonsdk/framework/UMEnvelopeBuild;->imprintProperty(Landroid/content/Context;Ljava/lang/String;Ljava/lang/String;)Ljava/lang/String;

    move-result-object v0

    .line 649
    sget-object v2, Lcom/umeng/analytics/pro/i;->a:Landroid/content/Context;

    invoke-static {v2}, Lcom/umeng/commonsdk/statistics/internal/PreferenceWrapper;->getDefault(Landroid/content/Context;)Landroid/content/SharedPreferences;

    move-result-object v2

    .line 650
    if-eqz p1, :cond_6

    .line 652
    const-string v3, "$pr_ve"

    invoke-direct {p0}, Lcom/umeng/analytics/pro/i;->h()Ljava/lang/String;

    move-result-object v4

    invoke-virtual {v1, v3, v4}, Lorg/json/JSONObject;->put(Ljava/lang/String;Ljava/lang/Object;)Lorg/json/JSONObject;

    .line 653
    const-string v3, "$ud_da"

    invoke-direct {p0}, Lcom/umeng/analytics/pro/i;->i()Ljava/lang/String;

    move-result-object v4

    invoke-virtual {v1, v3, v4}, Lorg/json/JSONObject;->put(Ljava/lang/String;Ljava/lang/Object;)Lorg/json/JSONObject;

    .line 658
    if-eqz v2, :cond_3

    .line 660
    const-string v3, "dp_vers_name"

    const-string v4, ""

    invoke-interface {v2, v3, v4}, Landroid/content/SharedPreferences;->getString(Ljava/lang/String;Ljava/lang/String;)Ljava/lang/String;

    move-result-object v3

    .line 661
    invoke-static {v3}, Landroid/text/TextUtils;->isEmpty(Ljava/lang/CharSequence;)Z

    move-result v4

    if-nez v4, :cond_3

    .line 662
    const-string v4, "app_version"

    invoke-virtual {v1, v4, v3}, Lorg/json/JSONObject;->put(Ljava/lang/String;Ljava/lang/Object;)Lorg/json/JSONObject;

    .line 663
    const-string v4, "version_code"

    const-string v5, "dp_vers_code"

    const/4 v6, 0x0

    invoke-interface {v2, v5, v6}, Landroid/content/SharedPreferences;->getInt(Ljava/lang/String;I)I

    move-result v5

    invoke-virtual {v1, v4, v5}, Lorg/json/JSONObject;->put(Ljava/lang/String;I)Lorg/json/JSONObject;

    .line 664
    new-instance v4, Ljava/text/SimpleDateFormat;

    const-string v5, "yyyy-MM-dd"

    invoke-static {}, Ljava/util/Locale;->getDefault()Ljava/util/Locale;

    move-result-object v6

    invoke-direct {v4, v5, v6}, Ljava/text/SimpleDateFormat;-><init>(Ljava/lang/String;Ljava/util/Locale;)V

    new-instance v5, Ljava/util/Date;

    .line 665
    invoke-static {}, Ljava/lang/System;->currentTimeMillis()J

    move-result-wide v6

    invoke-direct {v5, v6, v7}, Ljava/util/Date;-><init>(J)V

    invoke-virtual {v4, v5}, Ljava/text/SimpleDateFormat;->format(Ljava/util/Date;)Ljava/lang/String;

    move-result-object v4

    .line 668
    invoke-static {v0}, Landroid/text/TextUtils;->isEmpty(Ljava/lang/CharSequence;)Z

    move-result v0

    if-eqz v0, :cond_2

    .line 670
    const-string v0, "$pr_ve"

    const-string v5, "dp_vers_pre_version"

    const-string v6, "0"

    invoke-interface {v2, v5, v6}, Landroid/content/SharedPreferences;->getString(Ljava/lang/String;Ljava/lang/String;)Ljava/lang/String;

    move-result-object v5

    invoke-virtual {v1, v0, v5}, Lorg/json/JSONObject;->put(Ljava/lang/String;Ljava/lang/Object;)Lorg/json/JSONObject;

    .line 672
    const-string v0, "$ud_da"

    const-string v5, "dp_vers_date"

    invoke-interface {v2, v5, v4}, Landroid/content/SharedPreferences;->getString(Ljava/lang/String;Ljava/lang/String;)Ljava/lang/String;

    move-result-object v5

    invoke-virtual {v1, v0, v5}, Lorg/json/JSONObject;->put(Ljava/lang/String;Ljava/lang/Object;)Lorg/json/JSONObject;

    .line 676
    :cond_2
    sget-object v0, Lcom/umeng/analytics/pro/i;->a:Landroid/content/Context;

    invoke-static {v0}, Lcom/umeng/commonsdk/statistics/common/DeviceConfig;->getAppVersionName(Landroid/content/Context;)Ljava/lang/String;

    move-result-object v0

    .line 677
    invoke-interface {v2}, Landroid/content/SharedPreferences;->edit()Landroid/content/SharedPreferences$Editor;

    move-result-object v2

    const-string v5, "dp_pre_version"

    invoke-interface {v2, v5, v3}, Landroid/content/SharedPreferences$Editor;->putString(Ljava/lang/String;Ljava/lang/String;)Landroid/content/SharedPreferences$Editor;

    move-result-object v2

    const-string v3, "dp_cur_version"

    .line 678
    invoke-interface {v2, v3, v0}, Landroid/content/SharedPreferences$Editor;->putString(Ljava/lang/String;Ljava/lang/String;)Landroid/content/SharedPreferences$Editor;

    move-result-object v0

    const-string v2, "dp_pre_date"

    .line 679
    invoke-interface {v0, v2, v4}, Landroid/content/SharedPreferences$Editor;->putString(Ljava/lang/String;Ljava/lang/String;)Landroid/content/SharedPreferences$Editor;

    move-result-object v0

    const-string v2, "dp_vers_name"

    .line 680
    invoke-interface {v0, v2}, Landroid/content/SharedPreferences$Editor;->remove(Ljava/lang/String;)Landroid/content/SharedPreferences$Editor;

    move-result-object v0

    const-string v2, "dp_vers_code"

    .line 681
    invoke-interface {v0, v2}, Landroid/content/SharedPreferences$Editor;->remove(Ljava/lang/String;)Landroid/content/SharedPreferences$Editor;

    move-result-object v0

    const-string v2, "dp_vers_date"

    .line 682
    invoke-interface {v0, v2}, Landroid/content/SharedPreferences$Editor;->remove(Ljava/lang/String;)Landroid/content/SharedPreferences$Editor;

    move-result-object v0

    const-string v2, "dp_vers_pre_version"

    .line 683
    invoke-interface {v0, v2}, Landroid/content/SharedPreferences$Editor;->remove(Ljava/lang/String;)Landroid/content/SharedPreferences$Editor;

    move-result-object v0

    .line 684
    invoke-interface {v0}, Landroid/content/SharedPreferences$Editor;->commit()Z

    .line 733
    :cond_3
    :goto_1
    return-object v1

    .line 632
    :cond_4
    sget-object v2, Lcom/umeng/analytics/MobclickAgent$EScenarioType;->E_DUM_GAME:Lcom/umeng/analytics/MobclickAgent$EScenarioType;

    invoke-virtual {v2}, Lcom/umeng/analytics/MobclickAgent$EScenarioType;->toValue()I

    move-result v2

    if-ne v0, v2, :cond_5

    .line 633
    const/4 v0, 0x1

    sput-boolean v0, Lcom/umeng/analytics/AnalyticsConfig;->FLAG_DPLUS:Z

    .line 634
    sget-object v0, Lcom/umeng/analytics/MobclickAgent$EScenarioType;->E_UM_GAME:Lcom/umeng/analytics/MobclickAgent$EScenarioType;

    invoke-virtual {v0}, Lcom/umeng/analytics/MobclickAgent$EScenarioType;->toValue()I

    move-result v0

    goto/16 :goto_0

    .line 636
    :cond_5
    const/4 v2, 0x0

    sput-boolean v2, Lcom/umeng/analytics/AnalyticsConfig;->FLAG_DPLUS:Z
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_0

    goto/16 :goto_0

    .line 730
    :catch_0
    move-exception v0

    .line 731
    invoke-virtual {v0}, Ljava/lang/Throwable;->printStackTrace()V

    goto :goto_1

    .line 689
    :cond_6
    :try_start_1
    const-string v3, "$pr_ve"

    invoke-direct {p0}, Lcom/umeng/analytics/pro/i;->f()Ljava/lang/String;

    move-result-object v4

    invoke-virtual {v1, v3, v4}, Lorg/json/JSONObject;->put(Ljava/lang/String;Ljava/lang/Object;)Lorg/json/JSONObject;

    .line 690
    const-string v3, "$ud_da"

    invoke-direct {p0}, Lcom/umeng/analytics/pro/i;->g()Ljava/lang/String;

    move-result-object v4

    invoke-virtual {v1, v3, v4}, Lorg/json/JSONObject;->put(Ljava/lang/String;Ljava/lang/Object;)Lorg/json/JSONObject;

    .line 695
    if-eqz v2, :cond_3

    .line 697
    const-string v3, "vers_name"

    const-string v4, ""

    invoke-interface {v2, v3, v4}, Landroid/content/SharedPreferences;->getString(Ljava/lang/String;Ljava/lang/String;)Ljava/lang/String;

    move-result-object v3

    .line 698
    invoke-static {v3}, Landroid/text/TextUtils;->isEmpty(Ljava/lang/CharSequence;)Z

    move-result v4

    if-nez v4, :cond_3

    .line 699
    const-string v4, "app_version"

    invoke-virtual {v1, v4, v3}, Lorg/json/JSONObject;->put(Ljava/lang/String;Ljava/lang/Object;)Lorg/json/JSONObject;

    .line 700
    const-string v4, "version_code"

    const-string v5, "vers_code"

    const/4 v6, 0x0

    invoke-interface {v2, v5, v6}, Landroid/content/SharedPreferences;->getInt(Ljava/lang/String;I)I

    move-result v5

    invoke-virtual {v1, v4, v5}, Lorg/json/JSONObject;->put(Ljava/lang/String;I)Lorg/json/JSONObject;

    .line 701
    new-instance v4, Ljava/text/SimpleDateFormat;

    const-string v5, "yyyy-MM-dd"

    invoke-static {}, Ljava/util/Locale;->getDefault()Ljava/util/Locale;

    move-result-object v6

    invoke-direct {v4, v5, v6}, Ljava/text/SimpleDateFormat;-><init>(Ljava/lang/String;Ljava/util/Locale;)V

    new-instance v5, Ljava/util/Date;

    .line 702
    invoke-static {}, Ljava/lang/System;->currentTimeMillis()J

    move-result-wide v6

    invoke-direct {v5, v6, v7}, Ljava/util/Date;-><init>(J)V

    invoke-virtual {v4, v5}, Ljava/text/SimpleDateFormat;->format(Ljava/util/Date;)Ljava/lang/String;

    move-result-object v4

    .line 705
    invoke-static {v0}, Landroid/text/TextUtils;->isEmpty(Ljava/lang/CharSequence;)Z

    move-result v0

    if-eqz v0, :cond_7

    .line 707
    const-string v0, "$pr_ve"

    const-string v5, "vers_pre_version"

    const-string v6, "0"

    invoke-interface {v2, v5, v6}, Landroid/content/SharedPreferences;->getString(Ljava/lang/String;Ljava/lang/String;)Ljava/lang/String;

    move-result-object v5

    invoke-virtual {v1, v0, v5}, Lorg/json/JSONObject;->put(Ljava/lang/String;Ljava/lang/Object;)Lorg/json/JSONObject;

    .line 709
    const-string v0, "$ud_da"

    const-string v5, "vers_date"

    invoke-interface {v2, v5, v4}, Landroid/content/SharedPreferences;->getString(Ljava/lang/String;Ljava/lang/String;)Ljava/lang/String;

    move-result-object v5

    invoke-virtual {v1, v0, v5}, Lorg/json/JSONObject;->put(Ljava/lang/String;Ljava/lang/Object;)Lorg/json/JSONObject;

    .line 713
    :cond_7
    sget-object v0, Lcom/umeng/analytics/pro/i;->a:Landroid/content/Context;

    invoke-static {v0}, Lcom/umeng/commonsdk/statistics/common/DeviceConfig;->getAppVersionName(Landroid/content/Context;)Ljava/lang/String;

    move-result-object v0

    .line 714
    invoke-interface {v2}, Landroid/content/SharedPreferences;->edit()Landroid/content/SharedPreferences$Editor;

    move-result-object v2

    const-string v5, "pre_version"

    invoke-interface {v2, v5, v3}, Landroid/content/SharedPreferences$Editor;->putString(Ljava/lang/String;Ljava/lang/String;)Landroid/content/SharedPreferences$Editor;

    move-result-object v2

    const-string v3, "cur_version"

    .line 715
    invoke-interface {v2, v3, v0}, Landroid/content/SharedPreferences$Editor;->putString(Ljava/lang/String;Ljava/lang/String;)Landroid/content/SharedPreferences$Editor;

    move-result-object v0

    const-string v2, "pre_date"

    .line 716
    invoke-interface {v0, v2, v4}, Landroid/content/SharedPreferences$Editor;->putString(Ljava/lang/String;Ljava/lang/String;)Landroid/content/SharedPreferences$Editor;

    move-result-object v0

    const-string v2, "vers_name"

    .line 717
    invoke-interface {v0, v2}, Landroid/content/SharedPreferences$Editor;->remove(Ljava/lang/String;)Landroid/content/SharedPreferences$Editor;

    move-result-object v0

    const-string v2, "vers_code"

    .line 718
    invoke-interface {v0, v2}, Landroid/content/SharedPreferences$Editor;->remove(Ljava/lang/String;)Landroid/content/SharedPreferences$Editor;

    move-result-object v0

    const-string v2, "vers_date"

    .line 719
    invoke-interface {v0, v2}, Landroid/content/SharedPreferences$Editor;->remove(Ljava/lang/String;)Landroid/content/SharedPreferences$Editor;

    move-result-object v0

    const-string v2, "vers_pre_version"

    .line 720
    invoke-interface {v0, v2}, Landroid/content/SharedPreferences$Editor;->remove(Ljava/lang/String;)Landroid/content/SharedPreferences$Editor;

    move-result-object v0

    .line 721
    invoke-interface {v0}, Landroid/content/SharedPreferences$Editor;->commit()Z
    :try_end_1
    .catch Ljava/lang/Throwable; {:try_start_1 .. :try_end_1} :catch_0

    goto/16 :goto_1
.end method

.method private d(Ljava/lang/Object;)V
    .locals 4

    .prologue
    .line 1037
    :try_start_0
    check-cast p1, Lorg/json/JSONObject;

    .line 1038
    const/16 v0, 0x802

    const-string v1, "__t"

    invoke-virtual {p1, v1}, Lorg/json/JSONObject;->getInt(Ljava/lang/String;)I

    move-result v1

    if-ne v0, v1, :cond_5

    .line 1039
    iget-wide v0, p0, Lcom/umeng/analytics/pro/i;->p:J

    iget v2, p0, Lcom/umeng/analytics/pro/i;->n:I

    invoke-direct {p0, v0, v1, v2}, Lcom/umeng/analytics/pro/i;->a(JI)Z

    move-result v0

    if-nez v0, :cond_1

    .line 1061
    :cond_0
    :goto_0
    return-void

    .line 1042
    :cond_1
    iget v0, p0, Lcom/umeng/analytics/pro/i;->n:I

    add-int/lit8 v0, v0, 0x1

    iput v0, p0, Lcom/umeng/analytics/pro/i;->n:I

    .line 1050
    :cond_2
    :goto_1
    iget-object v0, p0, Lcom/umeng/analytics/pro/i;->l:Lorg/json/JSONArray;

    invoke-virtual {v0}, Lorg/json/JSONArray;->length()I

    move-result v0

    iget v1, p0, Lcom/umeng/analytics/pro/i;->k:I

    if-lt v0, v1, :cond_3

    .line 1051
    sget-object v0, Lcom/umeng/analytics/pro/i;->a:Landroid/content/Context;

    invoke-static {v0}, Lcom/umeng/analytics/pro/g;->a(Landroid/content/Context;)Lcom/umeng/analytics/pro/g;

    move-result-object v0

    iget-object v1, p0, Lcom/umeng/analytics/pro/i;->l:Lorg/json/JSONArray;

    invoke-virtual {v0, v1}, Lcom/umeng/analytics/pro/g;->a(Lorg/json/JSONArray;)V

    .line 1052
    new-instance v0, Lorg/json/JSONArray;

    invoke-direct {v0}, Lorg/json/JSONArray;-><init>()V

    iput-object v0, p0, Lcom/umeng/analytics/pro/i;->l:Lorg/json/JSONArray;

    .line 1054
    :cond_3
    iget-wide v0, p0, Lcom/umeng/analytics/pro/i;->p:J

    const-wide/16 v2, 0x0

    cmp-long v0, v0, v2

    if-nez v0, :cond_4

    .line 1055
    invoke-static {}, Ljava/lang/System;->currentTimeMillis()J

    move-result-wide v0

    iput-wide v0, p0, Lcom/umeng/analytics/pro/i;->p:J

    .line 1057
    :cond_4
    iget-object v0, p0, Lcom/umeng/analytics/pro/i;->l:Lorg/json/JSONArray;

    invoke-virtual {v0, p1}, Lorg/json/JSONArray;->put(Ljava/lang/Object;)Lorg/json/JSONArray;
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_0

    goto :goto_0

    .line 1058
    :catch_0
    move-exception v0

    .line 1059
    invoke-static {v0}, Lcom/umeng/commonsdk/statistics/common/MLog;->e(Ljava/lang/Throwable;)V

    goto :goto_0

    .line 1043
    :cond_5
    const/16 v0, 0x801

    :try_start_1
    const-string v1, "__t"

    invoke-virtual {p1, v1}, Lorg/json/JSONObject;->getInt(Ljava/lang/String;)I

    move-result v1

    if-ne v0, v1, :cond_2

    .line 1044
    iget-wide v0, p0, Lcom/umeng/analytics/pro/i;->p:J

    iget v2, p0, Lcom/umeng/analytics/pro/i;->o:I

    invoke-direct {p0, v0, v1, v2}, Lcom/umeng/analytics/pro/i;->a(JI)Z

    move-result v0

    if-eqz v0, :cond_0

    .line 1047
    iget v0, p0, Lcom/umeng/analytics/pro/i;->o:I

    add-int/lit8 v0, v0, 0x1

    iput v0, p0, Lcom/umeng/analytics/pro/i;->o:I
    :try_end_1
    .catch Ljava/lang/Throwable; {:try_start_1 .. :try_end_1} :catch_0

    goto :goto_1
.end method

.method static synthetic e()Landroid/content/Context;
    .locals 1

    .prologue
    .line 43
    sget-object v0, Lcom/umeng/analytics/pro/i;->a:Landroid/content/Context;

    return-object v0
.end method

.method private e(Ljava/lang/Object;)V
    .locals 6

    .prologue
    .line 1729
    :try_start_0
    sget-object v0, Lcom/umeng/analytics/pro/i;->a:Landroid/content/Context;

    invoke-virtual {p0, v0}, Lcom/umeng/analytics/pro/i;->b(Landroid/content/Context;)V

    .line 1730
    invoke-virtual {p0}, Lcom/umeng/analytics/pro/i;->a()V

    .line 1732
    check-cast p1, Lorg/json/JSONObject;

    .line 1733
    if-eqz p1, :cond_0

    invoke-virtual {p1}, Lorg/json/JSONObject;->length()I

    move-result v0

    if-gtz v0, :cond_1

    .line 1750
    :cond_0
    :goto_0
    return-void

    .line 1734
    :cond_1
    const-string v0, "provider"

    invoke-virtual {p1, v0}, Lorg/json/JSONObject;->getString(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v0

    .line 1735
    const-string v1, "uid"

    invoke-virtual {p1, v1}, Lorg/json/JSONObject;->getString(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v1

    .line 1737
    sget-object v2, Lcom/umeng/analytics/pro/i;->a:Landroid/content/Context;

    invoke-static {v2}, Lcom/umeng/analytics/c;->a(Landroid/content/Context;)[Ljava/lang/String;

    move-result-object v2

    .line 1738
    if-eqz v2, :cond_2

    const/4 v3, 0x0

    aget-object v3, v2, v3

    invoke-virtual {v0, v3}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v3

    if-eqz v3, :cond_2

    const/4 v3, 0x1

    aget-object v2, v2, v3

    invoke-virtual {v1, v2}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v2

    if-nez v2, :cond_0

    .line 1739
    :cond_2
    invoke-static {}, Lcom/umeng/analytics/pro/o;->a()Lcom/umeng/analytics/pro/o;

    move-result-object v2

    sget-object v3, Lcom/umeng/analytics/pro/i;->a:Landroid/content/Context;

    .line 1740
    invoke-static {}, Ljava/lang/System;->currentTimeMillis()J

    move-result-wide v4

    .line 1739
    invoke-virtual {v2, v3, v4, v5}, Lcom/umeng/analytics/pro/o;->a(Landroid/content/Context;J)Z

    move-result v2

    .line 1741
    sget-object v3, Lcom/umeng/analytics/pro/i;->a:Landroid/content/Context;

    invoke-static {v3, v0, v1}, Lcom/umeng/analytics/c;->a(Landroid/content/Context;Ljava/lang/String;Ljava/lang/String;)V

    .line 1742
    if-eqz v2, :cond_0

    .line 1743
    invoke-static {}, Lcom/umeng/analytics/pro/o;->a()Lcom/umeng/analytics/pro/o;

    move-result-object v0

    sget-object v1, Lcom/umeng/analytics/pro/i;->a:Landroid/content/Context;

    invoke-static {}, Ljava/lang/System;->currentTimeMillis()J

    move-result-wide v2

    invoke-virtual {v0, v1, v2, v3}, Lcom/umeng/analytics/pro/o;->b(Landroid/content/Context;J)V
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_0

    goto :goto_0

    .line 1747
    :catch_0
    move-exception v0

    goto :goto_0
.end method

.method private e(Z)Z
    .locals 3

    .prologue
    .line 1149
    invoke-direct {p0}, Lcom/umeng/analytics/pro/i;->n()Z

    move-result v0

    if-eqz v0, :cond_1

    const/4 v0, 0x1

    .line 1170
    :cond_0
    :goto_0
    return v0

    .line 1150
    :cond_1
    iget-object v0, p0, Lcom/umeng/analytics/pro/i;->d:Lcom/umeng/analytics/pro/i$c;

    if-nez v0, :cond_2

    .line 1151
    new-instance v0, Lcom/umeng/analytics/pro/i$c;

    invoke-direct {v0, p0}, Lcom/umeng/analytics/pro/i$c;-><init>(Lcom/umeng/analytics/pro/i;)V

    iput-object v0, p0, Lcom/umeng/analytics/pro/i;->d:Lcom/umeng/analytics/pro/i$c;

    .line 1154
    :cond_2
    iget-object v0, p0, Lcom/umeng/analytics/pro/i;->d:Lcom/umeng/analytics/pro/i$c;

    invoke-virtual {v0}, Lcom/umeng/analytics/pro/i$c;->a()V

    .line 1156
    iget-object v0, p0, Lcom/umeng/analytics/pro/i;->d:Lcom/umeng/analytics/pro/i$c;

    invoke-virtual {v0}, Lcom/umeng/analytics/pro/i$c;->c()Lcom/umeng/commonsdk/statistics/common/ReportPolicy$ReportStrategy;

    move-result-object v1

    .line 1157
    invoke-virtual {v1, p1}, Lcom/umeng/commonsdk/statistics/common/ReportPolicy$ReportStrategy;->shouldSendMessage(Z)Z

    move-result v0

    .line 1160
    if-eqz v0, :cond_0

    .line 1161
    instance-of v2, v1, Lcom/umeng/commonsdk/statistics/common/ReportPolicy$ReportByInterval;

    if-nez v2, :cond_3

    instance-of v1, v1, Lcom/umeng/commonsdk/statistics/common/ReportPolicy$DebugPolicy;

    if-eqz v1, :cond_0

    .line 1164
    :cond_3
    invoke-direct {p0}, Lcom/umeng/analytics/pro/i;->k()Z

    move-result v1

    if-eqz v1, :cond_0

    .line 1165
    invoke-virtual {p0}, Lcom/umeng/analytics/pro/i;->a()V

    goto :goto_0
.end method

.method private f()Ljava/lang/String;
    .locals 6

    .prologue
    const/4 v2, 0x0

    .line 821
    .line 823
    :try_start_0
    sget-object v0, Lcom/umeng/analytics/pro/i;->a:Landroid/content/Context;

    const-string v1, "pr_ve"

    const/4 v3, 0x0

    invoke-static {v0, v1, v3}, Lcom/umeng/commonsdk/framework/UMEnvelopeBuild;->imprintProperty(Landroid/content/Context;Ljava/lang/String;Ljava/lang/String;)Ljava/lang/String;
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_1

    move-result-object v2

    .line 824
    :try_start_1
    invoke-static {v2}, Landroid/text/TextUtils;->isEmpty(Ljava/lang/CharSequence;)Z

    move-result v0

    if-eqz v0, :cond_4

    .line 825
    iget-object v0, p0, Lcom/umeng/analytics/pro/i;->f:Ljava/lang/String;

    invoke-static {v0}, Landroid/text/TextUtils;->isEmpty(Ljava/lang/CharSequence;)Z

    move-result v0

    if-nez v0, :cond_0

    .line 826
    iget-object v0, p0, Lcom/umeng/analytics/pro/i;->f:Ljava/lang/String;

    .line 856
    :goto_0
    return-object v0

    .line 828
    :cond_0
    iget-object v0, p0, Lcom/umeng/analytics/pro/i;->e:Landroid/content/SharedPreferences;

    if-nez v0, :cond_1

    sget-object v0, Lcom/umeng/analytics/pro/i;->a:Landroid/content/Context;

    invoke-static {v0}, Lcom/umeng/commonsdk/statistics/internal/PreferenceWrapper;->getDefault(Landroid/content/Context;)Landroid/content/SharedPreferences;

    move-result-object v0

    iput-object v0, p0, Lcom/umeng/analytics/pro/i;->e:Landroid/content/SharedPreferences;

    .line 833
    :cond_1
    iget-object v0, p0, Lcom/umeng/analytics/pro/i;->e:Landroid/content/SharedPreferences;

    const-string v1, "pre_version"

    const-string v3, ""

    invoke-interface {v0, v1, v3}, Landroid/content/SharedPreferences;->getString(Ljava/lang/String;Ljava/lang/String;)Ljava/lang/String;

    move-result-object v1

    .line 834
    sget-object v0, Lcom/umeng/analytics/pro/i;->a:Landroid/content/Context;

    invoke-static {v0}, Lcom/umeng/commonsdk/statistics/common/DeviceConfig;->getAppVersionName(Landroid/content/Context;)Ljava/lang/String;

    move-result-object v3

    .line 836
    invoke-static {v1}, Landroid/text/TextUtils;->isEmpty(Ljava/lang/CharSequence;)Z

    move-result v0

    if-eqz v0, :cond_2

    .line 837
    iget-object v0, p0, Lcom/umeng/analytics/pro/i;->e:Landroid/content/SharedPreferences;

    invoke-interface {v0}, Landroid/content/SharedPreferences;->edit()Landroid/content/SharedPreferences$Editor;

    move-result-object v0

    const-string v1, "pre_version"

    const-string v4, "0"

    invoke-interface {v0, v1, v4}, Landroid/content/SharedPreferences$Editor;->putString(Ljava/lang/String;Ljava/lang/String;)Landroid/content/SharedPreferences$Editor;

    move-result-object v0

    const-string v1, "cur_version"

    invoke-interface {v0, v1, v3}, Landroid/content/SharedPreferences$Editor;->putString(Ljava/lang/String;Ljava/lang/String;)Landroid/content/SharedPreferences$Editor;

    move-result-object v0

    invoke-interface {v0}, Landroid/content/SharedPreferences$Editor;->commit()Z

    .line 838
    const-string v0, "0"
    :try_end_1
    .catch Ljava/lang/Throwable; {:try_start_1 .. :try_end_1} :catch_0

    .line 854
    :goto_1
    iput-object v0, p0, Lcom/umeng/analytics/pro/i;->f:Ljava/lang/String;

    goto :goto_0

    .line 840
    :cond_2
    :try_start_2
    iget-object v0, p0, Lcom/umeng/analytics/pro/i;->e:Landroid/content/SharedPreferences;

    const-string v4, "cur_version"

    const-string v5, ""

    invoke-interface {v0, v4, v5}, Landroid/content/SharedPreferences;->getString(Ljava/lang/String;Ljava/lang/String;)Ljava/lang/String;

    move-result-object v0

    .line 841
    invoke-virtual {v3, v0}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v4

    if-nez v4, :cond_3

    .line 842
    iget-object v1, p0, Lcom/umeng/analytics/pro/i;->e:Landroid/content/SharedPreferences;

    invoke-interface {v1}, Landroid/content/SharedPreferences;->edit()Landroid/content/SharedPreferences$Editor;

    move-result-object v1

    const-string v4, "pre_version"

    invoke-interface {v1, v4, v0}, Landroid/content/SharedPreferences$Editor;->putString(Ljava/lang/String;Ljava/lang/String;)Landroid/content/SharedPreferences$Editor;

    move-result-object v1

    const-string v4, "cur_version"

    invoke-interface {v1, v4, v3}, Landroid/content/SharedPreferences$Editor;->putString(Ljava/lang/String;Ljava/lang/String;)Landroid/content/SharedPreferences$Editor;

    move-result-object v1

    .line 843
    invoke-interface {v1}, Landroid/content/SharedPreferences$Editor;->commit()Z
    :try_end_2
    .catch Ljava/lang/Throwable; {:try_start_2 .. :try_end_2} :catch_0

    goto :goto_1

    .line 852
    :catch_0
    move-exception v0

    move-object v0, v2

    goto :goto_1

    :cond_3
    move-object v0, v1

    .line 846
    goto :goto_1

    .line 852
    :catch_1
    move-exception v0

    move-object v0, v2

    goto :goto_1

    :cond_4
    move-object v0, v2

    goto :goto_1
.end method

.method private f(Ljava/lang/Object;)V
    .locals 5

    .prologue
    .line 1754
    :try_start_0
    move-object v0, p1

    check-cast v0, Lorg/json/JSONObject;

    move-object v1, v0

    .line 1755
    if-eqz v1, :cond_0

    invoke-virtual {v1}, Lorg/json/JSONObject;->length()I

    move-result v2

    if-lez v2, :cond_0

    .line 1756
    const-string v2, "__ii"

    invoke-virtual {v1, v2}, Lorg/json/JSONObject;->has(Ljava/lang/String;)Z

    move-result v2

    if-eqz v2, :cond_0

    .line 1757
    const-string v2, "__ii"

    invoke-virtual {v1, v2}, Lorg/json/JSONObject;->optString(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v2

    .line 1758
    const-string v3, "__ii"

    invoke-virtual {v1, v3}, Lorg/json/JSONObject;->remove(Ljava/lang/String;)Ljava/lang/Object;

    .line 1759
    invoke-static {v2}, Landroid/text/TextUtils;->isEmpty(Ljava/lang/CharSequence;)Z

    move-result v1

    if-nez v1, :cond_0

    .line 1760
    sget-object v1, Lcom/umeng/analytics/pro/i;->a:Landroid/content/Context;

    invoke-static {v1}, Lcom/umeng/analytics/pro/g;->a(Landroid/content/Context;)Lcom/umeng/analytics/pro/g;

    move-result-object v1

    invoke-virtual {p1}, Ljava/lang/Object;->toString()Ljava/lang/String;

    move-result-object v3

    const/4 v4, 0x2

    invoke-virtual {v1, v2, v3, v4}, Lcom/umeng/analytics/pro/g;->a(Ljava/lang/String;Ljava/lang/String;I)Z
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_0

    .line 1766
    :cond_0
    :goto_0
    return-void

    .line 1764
    :catch_0
    move-exception v1

    goto :goto_0
.end method

.method private g()Ljava/lang/String;
    .locals 6

    .prologue
    const/4 v2, 0x0

    .line 865
    .line 867
    :try_start_0
    sget-object v0, Lcom/umeng/analytics/pro/i;->a:Landroid/content/Context;

    const-string v1, "ud_da"

    const/4 v3, 0x0

    invoke-static {v0, v1, v3}, Lcom/umeng/commonsdk/framework/UMEnvelopeBuild;->imprintProperty(Landroid/content/Context;Ljava/lang/String;Ljava/lang/String;)Ljava/lang/String;
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_1

    move-result-object v2

    .line 869
    :try_start_1
    invoke-static {v2}, Landroid/text/TextUtils;->isEmpty(Ljava/lang/CharSequence;)Z

    move-result v0

    if-eqz v0, :cond_4

    .line 870
    iget-object v0, p0, Lcom/umeng/analytics/pro/i;->g:Ljava/lang/String;

    invoke-static {v0}, Landroid/text/TextUtils;->isEmpty(Ljava/lang/CharSequence;)Z

    move-result v0

    if-nez v0, :cond_0

    .line 871
    iget-object v0, p0, Lcom/umeng/analytics/pro/i;->g:Ljava/lang/String;

    .line 895
    :goto_0
    return-object v0

    .line 873
    :cond_0
    iget-object v0, p0, Lcom/umeng/analytics/pro/i;->e:Landroid/content/SharedPreferences;

    if-nez v0, :cond_1

    sget-object v0, Lcom/umeng/analytics/pro/i;->a:Landroid/content/Context;

    invoke-static {v0}, Lcom/umeng/commonsdk/statistics/internal/PreferenceWrapper;->getDefault(Landroid/content/Context;)Landroid/content/SharedPreferences;

    move-result-object v0

    iput-object v0, p0, Lcom/umeng/analytics/pro/i;->e:Landroid/content/SharedPreferences;

    .line 874
    :cond_1
    iget-object v0, p0, Lcom/umeng/analytics/pro/i;->e:Landroid/content/SharedPreferences;

    const-string v1, "pre_date"

    const-string v3, ""

    invoke-interface {v0, v1, v3}, Landroid/content/SharedPreferences;->getString(Ljava/lang/String;Ljava/lang/String;)Ljava/lang/String;

    move-result-object v1

    .line 875
    invoke-static {v1}, Landroid/text/TextUtils;->isEmpty(Ljava/lang/CharSequence;)Z

    move-result v0

    if-eqz v0, :cond_2

    .line 876
    new-instance v0, Ljava/text/SimpleDateFormat;

    const-string v1, "yyyy-MM-dd"

    invoke-static {}, Ljava/util/Locale;->getDefault()Ljava/util/Locale;

    move-result-object v3

    invoke-direct {v0, v1, v3}, Ljava/text/SimpleDateFormat;-><init>(Ljava/lang/String;Ljava/util/Locale;)V

    new-instance v1, Ljava/util/Date;

    .line 877
    invoke-static {}, Ljava/lang/System;->currentTimeMillis()J

    move-result-wide v4

    invoke-direct {v1, v4, v5}, Ljava/util/Date;-><init>(J)V

    invoke-virtual {v0, v1}, Ljava/text/SimpleDateFormat;->format(Ljava/util/Date;)Ljava/lang/String;

    move-result-object v0

    .line 878
    iget-object v1, p0, Lcom/umeng/analytics/pro/i;->e:Landroid/content/SharedPreferences;

    invoke-interface {v1}, Landroid/content/SharedPreferences;->edit()Landroid/content/SharedPreferences$Editor;

    move-result-object v1

    const-string v3, "pre_date"

    invoke-interface {v1, v3, v0}, Landroid/content/SharedPreferences$Editor;->putString(Ljava/lang/String;Ljava/lang/String;)Landroid/content/SharedPreferences$Editor;

    move-result-object v1

    invoke-interface {v1}, Landroid/content/SharedPreferences$Editor;->commit()Z
    :try_end_1
    .catch Ljava/lang/Throwable; {:try_start_1 .. :try_end_1} :catch_0

    .line 894
    :goto_1
    iput-object v0, p0, Lcom/umeng/analytics/pro/i;->g:Ljava/lang/String;

    goto :goto_0

    .line 881
    :cond_2
    :try_start_2
    new-instance v0, Ljava/text/SimpleDateFormat;

    const-string v3, "yyyy-MM-dd"

    invoke-static {}, Ljava/util/Locale;->getDefault()Ljava/util/Locale;

    move-result-object v4

    invoke-direct {v0, v3, v4}, Ljava/text/SimpleDateFormat;-><init>(Ljava/lang/String;Ljava/util/Locale;)V

    new-instance v3, Ljava/util/Date;

    .line 882
    invoke-static {}, Ljava/lang/System;->currentTimeMillis()J

    move-result-wide v4

    invoke-direct {v3, v4, v5}, Ljava/util/Date;-><init>(J)V

    invoke-virtual {v0, v3}, Ljava/text/SimpleDateFormat;->format(Ljava/util/Date;)Ljava/lang/String;

    move-result-object v0

    .line 883
    invoke-virtual {v1, v0}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v3

    if-nez v3, :cond_3

    .line 884
    iget-object v1, p0, Lcom/umeng/analytics/pro/i;->e:Landroid/content/SharedPreferences;

    invoke-interface {v1}, Landroid/content/SharedPreferences;->edit()Landroid/content/SharedPreferences$Editor;

    move-result-object v1

    const-string v3, "pre_date"

    invoke-interface {v1, v3, v0}, Landroid/content/SharedPreferences$Editor;->putString(Ljava/lang/String;Ljava/lang/String;)Landroid/content/SharedPreferences$Editor;

    move-result-object v1

    invoke-interface {v1}, Landroid/content/SharedPreferences$Editor;->commit()Z
    :try_end_2
    .catch Ljava/lang/Throwable; {:try_start_2 .. :try_end_2} :catch_0

    goto :goto_1

    .line 892
    :catch_0
    move-exception v0

    move-object v0, v2

    goto :goto_1

    :cond_3
    move-object v0, v1

    .line 887
    goto :goto_1

    .line 892
    :catch_1
    move-exception v0

    move-object v0, v2

    goto :goto_1

    :cond_4
    move-object v0, v2

    goto :goto_1
.end method

.method private h()Ljava/lang/String;
    .locals 6

    .prologue
    const/4 v2, 0x0

    .line 904
    .line 906
    :try_start_0
    sget-object v0, Lcom/umeng/analytics/pro/i;->a:Landroid/content/Context;

    const-string v1, "pr_ve"

    const/4 v3, 0x0

    invoke-static {v0, v1, v3}, Lcom/umeng/commonsdk/framework/UMEnvelopeBuild;->imprintProperty(Landroid/content/Context;Ljava/lang/String;Ljava/lang/String;)Ljava/lang/String;
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_1

    move-result-object v2

    .line 907
    :try_start_1
    invoke-static {v2}, Landroid/text/TextUtils;->isEmpty(Ljava/lang/CharSequence;)Z

    move-result v0

    if-eqz v0, :cond_4

    .line 908
    iget-object v0, p0, Lcom/umeng/analytics/pro/i;->h:Ljava/lang/String;

    invoke-static {v0}, Landroid/text/TextUtils;->isEmpty(Ljava/lang/CharSequence;)Z

    move-result v0

    if-nez v0, :cond_0

    .line 909
    iget-object v0, p0, Lcom/umeng/analytics/pro/i;->h:Ljava/lang/String;

    .line 939
    :goto_0
    return-object v0

    .line 911
    :cond_0
    iget-object v0, p0, Lcom/umeng/analytics/pro/i;->e:Landroid/content/SharedPreferences;

    if-nez v0, :cond_1

    sget-object v0, Lcom/umeng/analytics/pro/i;->a:Landroid/content/Context;

    invoke-static {v0}, Lcom/umeng/commonsdk/statistics/internal/PreferenceWrapper;->getDefault(Landroid/content/Context;)Landroid/content/SharedPreferences;

    move-result-object v0

    iput-object v0, p0, Lcom/umeng/analytics/pro/i;->e:Landroid/content/SharedPreferences;

    .line 916
    :cond_1
    iget-object v0, p0, Lcom/umeng/analytics/pro/i;->e:Landroid/content/SharedPreferences;

    const-string v1, "dp_pre_version"

    const-string v3, ""

    invoke-interface {v0, v1, v3}, Landroid/content/SharedPreferences;->getString(Ljava/lang/String;Ljava/lang/String;)Ljava/lang/String;

    move-result-object v1

    .line 917
    sget-object v0, Lcom/umeng/analytics/pro/i;->a:Landroid/content/Context;

    invoke-static {v0}, Lcom/umeng/commonsdk/statistics/common/DeviceConfig;->getAppVersionName(Landroid/content/Context;)Ljava/lang/String;

    move-result-object v3

    .line 919
    invoke-static {v1}, Landroid/text/TextUtils;->isEmpty(Ljava/lang/CharSequence;)Z

    move-result v0

    if-eqz v0, :cond_2

    .line 920
    iget-object v0, p0, Lcom/umeng/analytics/pro/i;->e:Landroid/content/SharedPreferences;

    invoke-interface {v0}, Landroid/content/SharedPreferences;->edit()Landroid/content/SharedPreferences$Editor;

    move-result-object v0

    const-string v1, "dp_pre_version"

    const-string v4, "0"

    invoke-interface {v0, v1, v4}, Landroid/content/SharedPreferences$Editor;->putString(Ljava/lang/String;Ljava/lang/String;)Landroid/content/SharedPreferences$Editor;

    move-result-object v0

    const-string v1, "dp_cur_version"

    invoke-interface {v0, v1, v3}, Landroid/content/SharedPreferences$Editor;->putString(Ljava/lang/String;Ljava/lang/String;)Landroid/content/SharedPreferences$Editor;

    move-result-object v0

    invoke-interface {v0}, Landroid/content/SharedPreferences$Editor;->commit()Z

    .line 921
    const-string v0, "0"
    :try_end_1
    .catch Ljava/lang/Throwable; {:try_start_1 .. :try_end_1} :catch_0

    .line 937
    :goto_1
    iput-object v0, p0, Lcom/umeng/analytics/pro/i;->h:Ljava/lang/String;

    goto :goto_0

    .line 923
    :cond_2
    :try_start_2
    iget-object v0, p0, Lcom/umeng/analytics/pro/i;->e:Landroid/content/SharedPreferences;

    const-string v4, "dp_cur_version"

    const-string v5, ""

    invoke-interface {v0, v4, v5}, Landroid/content/SharedPreferences;->getString(Ljava/lang/String;Ljava/lang/String;)Ljava/lang/String;

    move-result-object v0

    .line 924
    invoke-virtual {v3, v0}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v4

    if-nez v4, :cond_3

    .line 925
    iget-object v1, p0, Lcom/umeng/analytics/pro/i;->e:Landroid/content/SharedPreferences;

    invoke-interface {v1}, Landroid/content/SharedPreferences;->edit()Landroid/content/SharedPreferences$Editor;

    move-result-object v1

    const-string v4, "dp_pre_version"

    invoke-interface {v1, v4, v0}, Landroid/content/SharedPreferences$Editor;->putString(Ljava/lang/String;Ljava/lang/String;)Landroid/content/SharedPreferences$Editor;

    move-result-object v1

    const-string v4, "dp_cur_version"

    invoke-interface {v1, v4, v3}, Landroid/content/SharedPreferences$Editor;->putString(Ljava/lang/String;Ljava/lang/String;)Landroid/content/SharedPreferences$Editor;

    move-result-object v1

    .line 926
    invoke-interface {v1}, Landroid/content/SharedPreferences$Editor;->commit()Z
    :try_end_2
    .catch Ljava/lang/Throwable; {:try_start_2 .. :try_end_2} :catch_0

    goto :goto_1

    .line 935
    :catch_0
    move-exception v0

    move-object v0, v2

    goto :goto_1

    :cond_3
    move-object v0, v1

    .line 929
    goto :goto_1

    .line 935
    :catch_1
    move-exception v0

    move-object v0, v2

    goto :goto_1

    :cond_4
    move-object v0, v2

    goto :goto_1
.end method

.method private i()Ljava/lang/String;
    .locals 6

    .prologue
    const/4 v2, 0x0

    .line 948
    .line 950
    :try_start_0
    sget-object v0, Lcom/umeng/analytics/pro/i;->a:Landroid/content/Context;

    const-string v1, "ud_da"

    const/4 v3, 0x0

    invoke-static {v0, v1, v3}, Lcom/umeng/commonsdk/framework/UMEnvelopeBuild;->imprintProperty(Landroid/content/Context;Ljava/lang/String;Ljava/lang/String;)Ljava/lang/String;
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_1

    move-result-object v2

    .line 952
    :try_start_1
    invoke-static {v2}, Landroid/text/TextUtils;->isEmpty(Ljava/lang/CharSequence;)Z

    move-result v0

    if-eqz v0, :cond_4

    .line 953
    iget-object v0, p0, Lcom/umeng/analytics/pro/i;->i:Ljava/lang/String;

    invoke-static {v0}, Landroid/text/TextUtils;->isEmpty(Ljava/lang/CharSequence;)Z

    move-result v0

    if-nez v0, :cond_0

    .line 954
    iget-object v0, p0, Lcom/umeng/analytics/pro/i;->i:Ljava/lang/String;

    .line 978
    :goto_0
    return-object v0

    .line 956
    :cond_0
    iget-object v0, p0, Lcom/umeng/analytics/pro/i;->e:Landroid/content/SharedPreferences;

    if-nez v0, :cond_1

    sget-object v0, Lcom/umeng/analytics/pro/i;->a:Landroid/content/Context;

    invoke-static {v0}, Lcom/umeng/commonsdk/statistics/internal/PreferenceWrapper;->getDefault(Landroid/content/Context;)Landroid/content/SharedPreferences;

    move-result-object v0

    iput-object v0, p0, Lcom/umeng/analytics/pro/i;->e:Landroid/content/SharedPreferences;

    .line 957
    :cond_1
    iget-object v0, p0, Lcom/umeng/analytics/pro/i;->e:Landroid/content/SharedPreferences;

    const-string v1, "dp_pre_date"

    const-string v3, ""

    invoke-interface {v0, v1, v3}, Landroid/content/SharedPreferences;->getString(Ljava/lang/String;Ljava/lang/String;)Ljava/lang/String;

    move-result-object v1

    .line 958
    invoke-static {v1}, Landroid/text/TextUtils;->isEmpty(Ljava/lang/CharSequence;)Z

    move-result v0

    if-eqz v0, :cond_2

    .line 959
    new-instance v0, Ljava/text/SimpleDateFormat;

    const-string v1, "yyyy-MM-dd"

    invoke-static {}, Ljava/util/Locale;->getDefault()Ljava/util/Locale;

    move-result-object v3

    invoke-direct {v0, v1, v3}, Ljava/text/SimpleDateFormat;-><init>(Ljava/lang/String;Ljava/util/Locale;)V

    new-instance v1, Ljava/util/Date;

    .line 960
    invoke-static {}, Ljava/lang/System;->currentTimeMillis()J

    move-result-wide v4

    invoke-direct {v1, v4, v5}, Ljava/util/Date;-><init>(J)V

    invoke-virtual {v0, v1}, Ljava/text/SimpleDateFormat;->format(Ljava/util/Date;)Ljava/lang/String;

    move-result-object v0

    .line 961
    iget-object v1, p0, Lcom/umeng/analytics/pro/i;->e:Landroid/content/SharedPreferences;

    invoke-interface {v1}, Landroid/content/SharedPreferences;->edit()Landroid/content/SharedPreferences$Editor;

    move-result-object v1

    const-string v3, "dp_pre_date"

    invoke-interface {v1, v3, v0}, Landroid/content/SharedPreferences$Editor;->putString(Ljava/lang/String;Ljava/lang/String;)Landroid/content/SharedPreferences$Editor;

    move-result-object v1

    invoke-interface {v1}, Landroid/content/SharedPreferences$Editor;->commit()Z
    :try_end_1
    .catch Ljava/lang/Throwable; {:try_start_1 .. :try_end_1} :catch_0

    .line 977
    :goto_1
    iput-object v0, p0, Lcom/umeng/analytics/pro/i;->i:Ljava/lang/String;

    goto :goto_0

    .line 964
    :cond_2
    :try_start_2
    new-instance v0, Ljava/text/SimpleDateFormat;

    const-string v3, "yyyy-MM-dd"

    invoke-static {}, Ljava/util/Locale;->getDefault()Ljava/util/Locale;

    move-result-object v4

    invoke-direct {v0, v3, v4}, Ljava/text/SimpleDateFormat;-><init>(Ljava/lang/String;Ljava/util/Locale;)V

    new-instance v3, Ljava/util/Date;

    .line 965
    invoke-static {}, Ljava/lang/System;->currentTimeMillis()J

    move-result-wide v4

    invoke-direct {v3, v4, v5}, Ljava/util/Date;-><init>(J)V

    invoke-virtual {v0, v3}, Ljava/text/SimpleDateFormat;->format(Ljava/util/Date;)Ljava/lang/String;

    move-result-object v0

    .line 966
    invoke-virtual {v1, v0}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v3

    if-nez v3, :cond_3

    .line 967
    iget-object v1, p0, Lcom/umeng/analytics/pro/i;->e:Landroid/content/SharedPreferences;

    invoke-interface {v1}, Landroid/content/SharedPreferences;->edit()Landroid/content/SharedPreferences$Editor;

    move-result-object v1

    const-string v3, "dp_pre_date"

    invoke-interface {v1, v3, v0}, Landroid/content/SharedPreferences$Editor;->putString(Ljava/lang/String;Ljava/lang/String;)Landroid/content/SharedPreferences$Editor;

    move-result-object v1

    invoke-interface {v1}, Landroid/content/SharedPreferences$Editor;->commit()Z
    :try_end_2
    .catch Ljava/lang/Throwable; {:try_start_2 .. :try_end_2} :catch_0

    goto :goto_1

    .line 975
    :catch_0
    move-exception v0

    move-object v0, v2

    goto :goto_1

    :cond_3
    move-object v0, v1

    .line 970
    goto :goto_1

    .line 975
    :catch_1
    move-exception v0

    move-object v0, v2

    goto :goto_1

    :cond_4
    move-object v0, v2

    goto :goto_1
.end method

.method private j()V
    .locals 4

    .prologue
    .line 1101
    const/4 v0, 0x0

    :try_start_0
    iput v0, p0, Lcom/umeng/analytics/pro/i;->n:I

    .line 1102
    const/4 v0, 0x0

    iput v0, p0, Lcom/umeng/analytics/pro/i;->o:I

    .line 1103
    invoke-static {}, Ljava/lang/System;->currentTimeMillis()J

    move-result-wide v0

    iput-wide v0, p0, Lcom/umeng/analytics/pro/i;->p:J

    .line 1105
    sget-object v0, Lcom/umeng/analytics/pro/i;->a:Landroid/content/Context;

    invoke-static {v0}, Lcom/umeng/commonsdk/statistics/internal/PreferenceWrapper;->getDefault(Landroid/content/Context;)Landroid/content/SharedPreferences;

    move-result-object v0

    .line 1106
    invoke-interface {v0}, Landroid/content/SharedPreferences;->edit()Landroid/content/SharedPreferences$Editor;

    move-result-object v0

    const-string v1, "dstk_last_time"

    invoke-static {}, Ljava/lang/System;->currentTimeMillis()J

    move-result-wide v2

    invoke-interface {v0, v1, v2, v3}, Landroid/content/SharedPreferences$Editor;->putLong(Ljava/lang/String;J)Landroid/content/SharedPreferences$Editor;

    move-result-object v0

    const-string v1, "dstk_cnt"

    const/4 v2, 0x0

    .line 1107
    invoke-interface {v0, v1, v2}, Landroid/content/SharedPreferences$Editor;->putInt(Ljava/lang/String;I)Landroid/content/SharedPreferences$Editor;

    move-result-object v0

    invoke-interface {v0}, Landroid/content/SharedPreferences$Editor;->commit()Z
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_0

    .line 1109
    :goto_0
    return-void

    .line 1108
    :catch_0
    move-exception v0

    goto :goto_0
.end method

.method private k()Z
    .locals 4

    .prologue
    const/4 v0, 0x0

    .line 1182
    :try_start_0
    invoke-static {}, Lcom/umeng/analytics/pro/o;->a()Lcom/umeng/analytics/pro/o;

    move-result-object v1

    invoke-virtual {v1}, Lcom/umeng/analytics/pro/o;->c()Ljava/lang/String;

    move-result-object v1

    .line 1183
    invoke-static {v1}, Landroid/text/TextUtils;->isEmpty(Ljava/lang/CharSequence;)Z

    move-result v1

    if-nez v1, :cond_0

    .line 1184
    sget-object v1, Lcom/umeng/analytics/pro/i;->a:Landroid/content/Context;

    invoke-virtual {p0, v1}, Lcom/umeng/analytics/pro/i;->b(Landroid/content/Context;)V

    .line 1187
    :cond_0
    iget-object v1, p0, Lcom/umeng/analytics/pro/i;->l:Lorg/json/JSONArray;

    invoke-virtual {v1}, Lorg/json/JSONArray;->length()I

    move-result v1

    if-lez v1, :cond_1

    move v1, v0

    .line 1190
    :goto_0
    iget-object v2, p0, Lcom/umeng/analytics/pro/i;->l:Lorg/json/JSONArray;

    invoke-virtual {v2}, Lorg/json/JSONArray;->length()I

    move-result v2

    if-ge v1, v2, :cond_3

    .line 1191
    iget-object v2, p0, Lcom/umeng/analytics/pro/i;->l:Lorg/json/JSONArray;

    invoke-virtual {v2, v1}, Lorg/json/JSONArray;->optJSONObject(I)Lorg/json/JSONObject;

    move-result-object v2

    .line 1192
    if-eqz v2, :cond_2

    invoke-virtual {v2}, Lorg/json/JSONObject;->length()I

    move-result v3

    if-lez v3, :cond_2

    .line 1193
    const-string v3, "__i"

    invoke-virtual {v2, v3}, Lorg/json/JSONObject;->optString(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v2

    .line 1194
    invoke-static {v2}, Landroid/text/TextUtils;->isEmpty(Ljava/lang/CharSequence;)Z

    move-result v3

    if-nez v3, :cond_1

    const-string v3, "-1"

    invoke-virtual {v3, v2}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_0

    move-result v2

    if-eqz v2, :cond_2

    .line 1204
    :cond_1
    :goto_1
    return v0

    .line 1190
    :cond_2
    add-int/lit8 v1, v1, 0x1

    goto :goto_0

    .line 1202
    :catch_0
    move-exception v0

    .line 1204
    :cond_3
    const/4 v0, 0x1

    goto :goto_1
.end method

.method private l()V
    .locals 5

    .prologue
    .line 1609
    iget-object v0, p0, Lcom/umeng/analytics/pro/i;->l:Lorg/json/JSONArray;

    invoke-virtual {v0}, Lorg/json/JSONArray;->length()I

    move-result v0

    if-lez v0, :cond_5

    .line 1615
    new-instance v2, Lorg/json/JSONArray;

    invoke-direct {v2}, Lorg/json/JSONArray;-><init>()V

    .line 1616
    const/4 v0, 0x0

    :goto_0
    iget-object v1, p0, Lcom/umeng/analytics/pro/i;->l:Lorg/json/JSONArray;

    invoke-virtual {v1}, Lorg/json/JSONArray;->length()I

    move-result v1

    if-ge v0, v1, :cond_4

    .line 1618
    :try_start_0
    iget-object v1, p0, Lcom/umeng/analytics/pro/i;->l:Lorg/json/JSONArray;

    invoke-virtual {v1, v0}, Lorg/json/JSONArray;->getJSONObject(I)Lorg/json/JSONObject;

    move-result-object v3

    .line 1619
    if-eqz v3, :cond_3

    invoke-virtual {v3}, Lorg/json/JSONObject;->length()I

    move-result v1

    if-lez v1, :cond_3

    .line 1620
    const-string v1, "__i"

    invoke-virtual {v3, v1}, Lorg/json/JSONObject;->optString(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v1

    .line 1621
    invoke-static {v1}, Landroid/text/TextUtils;->isEmpty(Ljava/lang/CharSequence;)Z

    move-result v4

    if-nez v4, :cond_0

    const-string v4, "-1"

    invoke-virtual {v4, v1}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v1

    if-eqz v1, :cond_2

    .line 1622
    :cond_0
    invoke-static {}, Lcom/umeng/analytics/pro/o;->a()Lcom/umeng/analytics/pro/o;

    move-result-object v1

    invoke-virtual {v1}, Lcom/umeng/analytics/pro/o;->c()Ljava/lang/String;

    move-result-object v1

    .line 1623
    invoke-static {v1}, Landroid/text/TextUtils;->isEmpty(Ljava/lang/CharSequence;)Z

    move-result v4

    if-eqz v4, :cond_1

    .line 1624
    const-string v1, "-1"

    .line 1626
    :cond_1
    const-string v4, "__i"

    invoke-virtual {v3, v4, v1}, Lorg/json/JSONObject;->put(Ljava/lang/String;Ljava/lang/Object;)Lorg/json/JSONObject;

    .line 1628
    :cond_2
    invoke-virtual {v2, v3}, Lorg/json/JSONArray;->put(Ljava/lang/Object;)Lorg/json/JSONArray;

    .line 1616
    :goto_1
    add-int/lit8 v0, v0, 0x1

    goto :goto_0

    .line 1630
    :cond_3
    invoke-virtual {v2, v3}, Lorg/json/JSONArray;->put(Ljava/lang/Object;)Lorg/json/JSONArray;
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_0

    goto :goto_1

    .line 1632
    :catch_0
    move-exception v1

    goto :goto_1

    .line 1634
    :cond_4
    iput-object v2, p0, Lcom/umeng/analytics/pro/i;->l:Lorg/json/JSONArray;

    .line 1636
    :cond_5
    return-void
.end method

.method private m()V
    .locals 6

    .prologue
    const-wide/16 v4, 0x0

    .line 1643
    :try_start_0
    invoke-direct {p0}, Lcom/umeng/analytics/pro/i;->n()Z

    move-result v0

    if-eqz v0, :cond_0

    .line 1644
    sget-object v0, Lcom/umeng/analytics/pro/i;->a:Landroid/content/Context;

    if-eqz v0, :cond_0

    .line 1645
    sget-object v0, Lcom/umeng/analytics/pro/i;->a:Landroid/content/Context;

    invoke-static {v0}, Lcom/umeng/commonsdk/statistics/internal/PreferenceWrapper;->getDefault(Landroid/content/Context;)Landroid/content/SharedPreferences;

    move-result-object v0

    .line 1646
    if-eqz v0, :cond_0

    .line 1647
    const-string v1, "first_activate_time"

    const-wide/16 v2, 0x0

    invoke-interface {v0, v1, v2, v3}, Landroid/content/SharedPreferences;->getLong(Ljava/lang/String;J)J

    move-result-wide v2

    .line 1648
    cmp-long v1, v2, v4

    if-nez v1, :cond_0

    .line 1649
    invoke-static {}, Ljava/lang/System;->currentTimeMillis()J

    move-result-wide v2

    .line 1650
    invoke-interface {v0}, Landroid/content/SharedPreferences;->edit()Landroid/content/SharedPreferences$Editor;

    move-result-object v0

    const-string v1, "first_activate_time"

    invoke-interface {v0, v1, v2, v3}, Landroid/content/SharedPreferences$Editor;->putLong(Ljava/lang/String;J)Landroid/content/SharedPreferences$Editor;

    move-result-object v0

    invoke-interface {v0}, Landroid/content/SharedPreferences$Editor;->commit()Z
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_0

    .line 1656
    :cond_0
    :goto_0
    return-void

    .line 1655
    :catch_0
    move-exception v0

    goto :goto_0
.end method

.method private n()Z
    .locals 4

    .prologue
    .line 1690
    :try_start_0
    sget-object v0, Lcom/umeng/analytics/pro/i;->a:Landroid/content/Context;

    if-eqz v0, :cond_0

    .line 1691
    sget-object v0, Lcom/umeng/analytics/pro/i;->a:Landroid/content/Context;

    invoke-static {v0}, Lcom/umeng/commonsdk/statistics/internal/PreferenceWrapper;->getDefault(Landroid/content/Context;)Landroid/content/SharedPreferences;

    move-result-object v0

    .line 1692
    if-eqz v0, :cond_0

    .line 1693
    const-string v1, "ana_is_f"

    const-wide/16 v2, -0x1

    invoke-interface {v0, v1, v2, v3}, Landroid/content/SharedPreferences;->getLong(Ljava/lang/String;J)J
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_0

    move-result-wide v0

    .line 1694
    const-wide/16 v2, 0x0

    cmp-long v0, v0, v2

    if-eqz v0, :cond_0

    .line 1695
    const/4 v0, 0x1

    .line 1700
    :goto_0
    return v0

    .line 1699
    :catch_0
    move-exception v0

    .line 1700
    :cond_0
    const/4 v0, 0x0

    goto :goto_0
.end method

.method private o()V
    .locals 4

    .prologue
    .line 1706
    :try_start_0
    sget-object v0, Lcom/umeng/analytics/pro/i;->a:Landroid/content/Context;

    invoke-virtual {p0, v0}, Lcom/umeng/analytics/pro/i;->b(Landroid/content/Context;)V

    .line 1707
    invoke-virtual {p0}, Lcom/umeng/analytics/pro/i;->a()V

    .line 1709
    sget-object v0, Lcom/umeng/analytics/pro/i;->a:Landroid/content/Context;

    invoke-static {v0}, Lcom/umeng/analytics/c;->a(Landroid/content/Context;)[Ljava/lang/String;

    move-result-object v0

    .line 1710
    if-eqz v0, :cond_0

    const/4 v1, 0x0

    aget-object v1, v0, v1

    invoke-static {v1}, Landroid/text/TextUtils;->isEmpty(Ljava/lang/CharSequence;)Z

    move-result v1

    if-nez v1, :cond_0

    const/4 v1, 0x1

    aget-object v0, v0, v1

    invoke-static {v0}, Landroid/text/TextUtils;->isEmpty(Ljava/lang/CharSequence;)Z

    move-result v0

    if-nez v0, :cond_0

    .line 1712
    invoke-static {}, Lcom/umeng/analytics/pro/o;->a()Lcom/umeng/analytics/pro/o;

    move-result-object v0

    sget-object v1, Lcom/umeng/analytics/pro/i;->a:Landroid/content/Context;

    .line 1713
    invoke-static {}, Ljava/lang/System;->currentTimeMillis()J

    move-result-wide v2

    .line 1712
    invoke-virtual {v0, v1, v2, v3}, Lcom/umeng/analytics/pro/o;->a(Landroid/content/Context;J)Z

    move-result v0

    .line 1714
    sget-object v1, Lcom/umeng/analytics/pro/i;->a:Landroid/content/Context;

    invoke-static {v1}, Lcom/umeng/analytics/c;->b(Landroid/content/Context;)V

    .line 1715
    if-eqz v0, :cond_0

    .line 1716
    invoke-static {}, Lcom/umeng/analytics/pro/o;->a()Lcom/umeng/analytics/pro/o;

    move-result-object v0

    sget-object v1, Lcom/umeng/analytics/pro/i;->a:Landroid/content/Context;

    invoke-static {}, Ljava/lang/System;->currentTimeMillis()J

    move-result-wide v2

    invoke-virtual {v0, v1, v2, v3}, Lcom/umeng/analytics/pro/o;->b(Landroid/content/Context;J)V
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_0

    .line 1724
    :cond_0
    :goto_0
    return-void

    .line 1719
    :catch_0
    move-exception v0

    .line 1720
    sget-boolean v1, Lcom/umeng/commonsdk/statistics/common/MLog;->DEBUG:Z

    if-eqz v1, :cond_0

    .line 1721
    const-string v1, " Excepthon  in  onProfileSignOff"

    invoke-static {v1, v0}, Lcom/umeng/commonsdk/statistics/common/MLog;->e(Ljava/lang/String;Ljava/lang/Throwable;)V

    goto :goto_0
.end method


# virtual methods
.method public a(J)Lorg/json/JSONObject;
    .locals 7

    .prologue
    const/4 v6, 0x0

    const/4 v5, 0x3

    const/4 v0, 0x0

    .line 449
    invoke-static {}, Lcom/umeng/analytics/pro/o;->a()Lcom/umeng/analytics/pro/o;

    move-result-object v1

    sget-object v2, Lcom/umeng/analytics/pro/i;->a:Landroid/content/Context;

    invoke-virtual {v1, v2}, Lcom/umeng/analytics/pro/o;->c(Landroid/content/Context;)Ljava/lang/String;

    move-result-object v1

    invoke-static {v1}, Landroid/text/TextUtils;->isEmpty(Ljava/lang/CharSequence;)Z

    move-result v1

    if-eqz v1, :cond_1

    .line 516
    :cond_0
    :goto_0
    return-object v0

    .line 454
    :cond_1
    invoke-virtual {p0, v6}, Lcom/umeng/analytics/pro/i;->b(Z)Lorg/json/JSONObject;

    move-result-object v1

    .line 456
    invoke-static {}, Lcom/umeng/analytics/pro/l;->a()Lcom/umeng/analytics/pro/l;

    move-result-object v2

    sget-object v3, Lcom/umeng/analytics/pro/i;->a:Landroid/content/Context;

    invoke-virtual {v2, v3}, Lcom/umeng/analytics/pro/l;->a(Landroid/content/Context;)I

    move-result v2

    .line 461
    invoke-virtual {v1}, Lorg/json/JSONObject;->length()I

    move-result v3

    if-lez v3, :cond_0

    .line 466
    invoke-virtual {v1}, Lorg/json/JSONObject;->length()I

    move-result v3

    const/4 v4, 0x1

    if-ne v3, v4, :cond_7

    .line 467
    const-string v3, "active_user"

    invoke-virtual {v1, v3}, Lorg/json/JSONObject;->optJSONObject(Ljava/lang/String;)Lorg/json/JSONObject;

    move-result-object v3

    if-eqz v3, :cond_2

    .line 470
    if-ne v2, v5, :cond_0

    .line 472
    :cond_2
    const-string v3, "userlevel"

    invoke-virtual {v1, v3}, Lorg/json/JSONObject;->optString(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v3

    invoke-static {v3}, Landroid/text/TextUtils;->isEmpty(Ljava/lang/CharSequence;)Z

    move-result v3

    if-nez v3, :cond_3

    .line 475
    if-ne v2, v5, :cond_0

    .line 489
    :cond_3
    invoke-direct {p0, v6}, Lcom/umeng/analytics/pro/i;->d(Z)Lorg/json/JSONObject;

    move-result-object v3

    .line 491
    new-instance v0, Lorg/json/JSONObject;

    invoke-direct {v0}, Lorg/json/JSONObject;-><init>()V

    .line 493
    :try_start_0
    new-instance v4, Lorg/json/JSONObject;

    invoke-direct {v4}, Lorg/json/JSONObject;-><init>()V

    .line 494
    if-ne v2, v5, :cond_8

    .line 495
    const-string v1, "analytics"

    new-instance v2, Lorg/json/JSONObject;

    invoke-direct {v2}, Lorg/json/JSONObject;-><init>()V

    invoke-virtual {v4, v1, v2}, Lorg/json/JSONObject;->put(Ljava/lang/String;Ljava/lang/Object;)Lorg/json/JSONObject;

    .line 501
    :cond_4
    :goto_1
    if-eqz v3, :cond_5

    invoke-virtual {v3}, Lorg/json/JSONObject;->length()I

    move-result v1

    if-lez v1, :cond_5

    .line 502
    const-string v1, "header"

    invoke-virtual {v0, v1, v3}, Lorg/json/JSONObject;->put(Ljava/lang/String;Ljava/lang/Object;)Lorg/json/JSONObject;

    .line 505
    :cond_5
    invoke-virtual {v4}, Lorg/json/JSONObject;->length()I

    move-result v1

    if-lez v1, :cond_6

    .line 506
    const-string v1, "content"

    invoke-virtual {v0, v1, v4}, Lorg/json/JSONObject;->put(Ljava/lang/String;Ljava/lang/Object;)Lorg/json/JSONObject;

    .line 509
    :cond_6
    invoke-direct {p0, v0, p1, p2}, Lcom/umeng/analytics/pro/i;->a(Lorg/json/JSONObject;J)Lorg/json/JSONObject;
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_0

    move-result-object v0

    goto :goto_0

    .line 478
    :cond_7
    invoke-virtual {v1}, Lorg/json/JSONObject;->length()I

    move-result v3

    const/4 v4, 0x2

    if-ne v3, v4, :cond_3

    .line 479
    const-string v3, "active_user"

    invoke-virtual {v1, v3}, Lorg/json/JSONObject;->optJSONObject(Ljava/lang/String;)Lorg/json/JSONObject;

    move-result-object v3

    if-eqz v3, :cond_3

    const-string v3, "userlevel"

    .line 480
    invoke-virtual {v1, v3}, Lorg/json/JSONObject;->optString(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v3

    invoke-static {v3}, Landroid/text/TextUtils;->isEmpty(Ljava/lang/CharSequence;)Z

    move-result v3

    if-nez v3, :cond_3

    .line 483
    if-eq v2, v5, :cond_3

    goto/16 :goto_0

    .line 497
    :cond_8
    if-eqz v1, :cond_4

    :try_start_1
    invoke-virtual {v1}, Lorg/json/JSONObject;->length()I

    move-result v2

    if-lez v2, :cond_4

    .line 498
    const-string v2, "analytics"

    invoke-virtual {v4, v2, v1}, Lorg/json/JSONObject;->put(Ljava/lang/String;Ljava/lang/Object;)Lorg/json/JSONObject;
    :try_end_1
    .catch Ljava/lang/Throwable; {:try_start_1 .. :try_end_1} :catch_0

    goto :goto_1

    .line 510
    :catch_0
    move-exception v1

    goto/16 :goto_0
.end method

.method public a()V
    .locals 4

    .prologue
    .line 986
    :try_start_0
    iget-object v0, p0, Lcom/umeng/analytics/pro/i;->l:Lorg/json/JSONArray;

    invoke-virtual {v0}, Lorg/json/JSONArray;->length()I

    move-result v0

    if-lez v0, :cond_0

    .line 987
    sget-object v0, Lcom/umeng/analytics/pro/i;->a:Landroid/content/Context;

    invoke-static {v0}, Lcom/umeng/analytics/pro/g;->a(Landroid/content/Context;)Lcom/umeng/analytics/pro/g;

    move-result-object v0

    iget-object v1, p0, Lcom/umeng/analytics/pro/i;->l:Lorg/json/JSONArray;

    invoke-virtual {v0, v1}, Lcom/umeng/analytics/pro/g;->a(Lorg/json/JSONArray;)V

    .line 988
    new-instance v0, Lorg/json/JSONArray;

    invoke-direct {v0}, Lorg/json/JSONArray;-><init>()V

    iput-object v0, p0, Lcom/umeng/analytics/pro/i;->l:Lorg/json/JSONArray;

    .line 990
    :cond_0
    sget-object v0, Lcom/umeng/analytics/pro/i;->a:Landroid/content/Context;

    invoke-static {v0}, Lcom/umeng/commonsdk/statistics/internal/PreferenceWrapper;->getDefault(Landroid/content/Context;)Landroid/content/SharedPreferences;

    move-result-object v0

    .line 991
    invoke-interface {v0}, Landroid/content/SharedPreferences;->edit()Landroid/content/SharedPreferences$Editor;

    move-result-object v0

    const-string v1, "thtstart"

    iget-wide v2, p0, Lcom/umeng/analytics/pro/i;->p:J

    invoke-interface {v0, v1, v2, v3}, Landroid/content/SharedPreferences$Editor;->putLong(Ljava/lang/String;J)Landroid/content/SharedPreferences$Editor;

    move-result-object v0

    const-string v1, "gkvc"

    iget v2, p0, Lcom/umeng/analytics/pro/i;->n:I

    invoke-interface {v0, v1, v2}, Landroid/content/SharedPreferences$Editor;->putInt(Ljava/lang/String;I)Landroid/content/SharedPreferences$Editor;

    move-result-object v0

    const-string v1, "ekvc"

    iget v2, p0, Lcom/umeng/analytics/pro/i;->o:I

    .line 992
    invoke-interface {v0, v1, v2}, Landroid/content/SharedPreferences$Editor;->putInt(Ljava/lang/String;I)Landroid/content/SharedPreferences$Editor;

    move-result-object v0

    invoke-interface {v0}, Landroid/content/SharedPreferences$Editor;->commit()Z
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_0

    .line 995
    :goto_0
    return-void

    .line 993
    :catch_0
    move-exception v0

    goto :goto_0
.end method

.method public a(Ljava/lang/Object;)V
    .locals 2

    .prologue
    .line 1451
    if-eqz p1, :cond_0

    .line 1452
    :try_start_0
    check-cast p1, Lorg/json/JSONObject;

    .line 1457
    invoke-virtual {p1}, Lorg/json/JSONObject;->length()I

    move-result v0

    if-lez v0, :cond_0

    .line 1458
    const-string v0, "exception"

    invoke-virtual {p1, v0}, Lorg/json/JSONObject;->has(Ljava/lang/String;)Z

    move-result v0

    if-eqz v0, :cond_2

    .line 1459
    const/16 v0, 0x65

    const-string v1, "exception"

    invoke-virtual {p1, v1}, Lorg/json/JSONObject;->getInt(Ljava/lang/String;)I

    move-result v1

    if-ne v0, v1, :cond_1

    .line 1470
    :cond_0
    :goto_0
    return-void

    .line 1462
    :cond_1
    invoke-direct {p0, p1}, Lcom/umeng/analytics/pro/i;->c(Lorg/json/JSONObject;)V

    goto :goto_0

    .line 1469
    :catch_0
    move-exception v0

    goto :goto_0

    .line 1465
    :cond_2
    invoke-direct {p0, p1}, Lcom/umeng/analytics/pro/i;->c(Lorg/json/JSONObject;)V
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_0

    goto :goto_0
.end method

.method public a(Ljava/lang/Object;I)V
    .locals 2

    .prologue
    const/4 v1, 0x0

    .line 114
    .line 116
    sparse-switch p2, :sswitch_data_0

    .line 236
    :cond_0
    :goto_0
    return-void

    .line 122
    :sswitch_0
    if-eqz p1, :cond_1

    .line 123
    :try_start_0
    invoke-direct {p0, p1}, Lcom/umeng/analytics/pro/i;->d(Ljava/lang/Object;)V

    .line 125
    :cond_1
    check-cast p1, Lorg/json/JSONObject;

    .line 126
    const-string v0, "__i"

    invoke-virtual {p1, v0}, Lorg/json/JSONObject;->optString(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v0

    .line 127
    const-string v1, "-1"

    invoke-virtual {v1, v0}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v0

    if-nez v0, :cond_0

    .line 128
    const/4 v0, 0x0

    invoke-virtual {p0, v0}, Lcom/umeng/analytics/pro/i;->a(Z)V
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_0

    goto :goto_0

    .line 130
    :catch_0
    move-exception v0

    goto :goto_0

    .line 137
    :sswitch_1
    if-eqz p1, :cond_2

    .line 138
    :try_start_1
    invoke-direct {p0, p1}, Lcom/umeng/analytics/pro/i;->d(Ljava/lang/Object;)V

    .line 140
    :cond_2
    check-cast p1, Lorg/json/JSONObject;

    .line 141
    const-string v0, "__i"

    invoke-virtual {p1, v0}, Lorg/json/JSONObject;->optString(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v0

    .line 142
    const-string v1, "-1"

    invoke-virtual {v1, v0}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v0

    if-nez v0, :cond_0

    .line 143
    const/4 v0, 0x0

    invoke-virtual {p0, v0}, Lcom/umeng/analytics/pro/i;->a(Z)V
    :try_end_1
    .catch Ljava/lang/Throwable; {:try_start_1 .. :try_end_1} :catch_1

    goto :goto_0

    .line 145
    :catch_1
    move-exception v0

    goto :goto_0

    .line 152
    :sswitch_2
    sget-object v0, Lcom/umeng/analytics/pro/i;->a:Landroid/content/Context;

    invoke-static {v0}, Lcom/umeng/analytics/pro/p;->a(Landroid/content/Context;)V

    goto :goto_0

    .line 158
    :sswitch_3
    sget-object v0, Lcom/umeng/analytics/pro/i;->a:Landroid/content/Context;

    invoke-static {v0}, Lcom/umeng/analytics/pro/h;->b(Landroid/content/Context;)V

    goto :goto_0

    .line 165
    :sswitch_4
    sget-object v0, Lcom/umeng/analytics/pro/i;->a:Landroid/content/Context;

    invoke-static {v0}, Lcom/umeng/analytics/pro/m;->a(Landroid/content/Context;)Lcom/umeng/analytics/pro/m;

    move-result-object v0

    invoke-virtual {v0, p1}, Lcom/umeng/analytics/pro/m;->a(Ljava/lang/Object;)V

    goto :goto_0

    .line 172
    :sswitch_5
    const/4 v0, 0x1

    invoke-virtual {p0, p1, v0, v1}, Lcom/umeng/analytics/pro/i;->a(Ljava/lang/Object;IZ)V

    goto :goto_0

    .line 179
    :sswitch_6
    invoke-virtual {p0}, Lcom/umeng/analytics/pro/i;->a()V

    goto :goto_0

    .line 186
    :sswitch_7
    invoke-direct {p0, p1}, Lcom/umeng/analytics/pro/i;->f(Ljava/lang/Object;)V

    goto :goto_0

    .line 192
    :sswitch_8
    invoke-direct {p0, p1}, Lcom/umeng/analytics/pro/i;->e(Ljava/lang/Object;)V

    goto :goto_0

    .line 198
    :sswitch_9
    invoke-direct {p0}, Lcom/umeng/analytics/pro/i;->o()V

    goto :goto_0

    .line 204
    :sswitch_a
    invoke-static {}, Lcom/umeng/analytics/b;->a()Lcom/umeng/analytics/b;

    move-result-object v0

    invoke-virtual {v0, p1}, Lcom/umeng/analytics/b;->a(Ljava/lang/Object;)V

    goto :goto_0

    .line 210
    :sswitch_b
    invoke-static {}, Lcom/umeng/analytics/b;->a()Lcom/umeng/analytics/b;

    move-result-object v0

    invoke-virtual {v0}, Lcom/umeng/analytics/b;->j()V

    goto :goto_0

    .line 216
    :sswitch_c
    invoke-static {}, Lcom/umeng/analytics/b;->a()Lcom/umeng/analytics/b;

    move-result-object v0

    invoke-virtual {v0}, Lcom/umeng/analytics/b;->h()V

    goto :goto_0

    .line 223
    :sswitch_d
    invoke-static {}, Lcom/umeng/analytics/pro/o;->a()Lcom/umeng/analytics/pro/o;

    move-result-object v0

    sget-object v1, Lcom/umeng/analytics/pro/i;->a:Landroid/content/Context;

    invoke-virtual {v0, v1, p1}, Lcom/umeng/analytics/pro/o;->a(Landroid/content/Context;Ljava/lang/Object;)V

    goto/16 :goto_0

    .line 230
    :sswitch_e
    invoke-static {}, Lcom/umeng/analytics/pro/o;->a()Lcom/umeng/analytics/pro/o;

    move-result-object v0

    sget-object v1, Lcom/umeng/analytics/pro/i;->a:Landroid/content/Context;

    invoke-virtual {v0, v1, p1}, Lcom/umeng/analytics/pro/o;->b(Landroid/content/Context;Ljava/lang/Object;)V

    goto/16 :goto_0

    .line 116
    :sswitch_data_0
    .sparse-switch
        0x1001 -> :sswitch_0
        0x1002 -> :sswitch_1
        0x1003 -> :sswitch_2
        0x1004 -> :sswitch_3
        0x1005 -> :sswitch_8
        0x1006 -> :sswitch_9
        0x1007 -> :sswitch_d
        0x1008 -> :sswitch_e
        0x1009 -> :sswitch_6
        0x100a -> :sswitch_7
        0x2001 -> :sswitch_5
        0x2002 -> :sswitch_4
        0x2003 -> :sswitch_a
        0x2004 -> :sswitch_b
        0x2005 -> :sswitch_c
    .end sparse-switch
.end method

.method public a(Ljava/lang/Object;IZ)V
    .locals 10

    .prologue
    const/4 v0, 0x0

    .line 250
    :try_start_0
    check-cast p1, Lorg/json/JSONObject;

    .line 251
    if-eqz p1, :cond_2

    invoke-virtual {p1}, Lorg/json/JSONObject;->length()I

    move-result v1

    if-lez v1, :cond_2

    .line 252
    const-string v1, "__ii"

    invoke-virtual {p1, v1}, Lorg/json/JSONObject;->optString(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v2

    .line 259
    sget-object v1, Lcom/umeng/analytics/pro/i;->a:Landroid/content/Context;

    invoke-static {v1}, Lcom/umeng/commonsdk/statistics/internal/PreferenceWrapper;->getDefault(Landroid/content/Context;)Landroid/content/SharedPreferences;

    move-result-object v3

    .line 264
    if-nez p2, :cond_0

    .line 265
    const-string v1, "dstk_last_time"

    const-wide/16 v4, 0x0

    invoke-interface {v3, v1, v4, v5}, Landroid/content/SharedPreferences;->getLong(Ljava/lang/String;J)J

    move-result-wide v4

    .line 266
    const-string v1, "dstk_cnt"

    const/4 v6, 0x0

    invoke-interface {v3, v1, v6}, Landroid/content/SharedPreferences;->getInt(Ljava/lang/String;I)I

    move-result v1

    .line 268
    invoke-direct {p0, v4, v5, v1}, Lcom/umeng/analytics/pro/i;->a(JI)Z

    move-result v4

    if-eqz v4, :cond_2

    .line 270
    invoke-interface {v3}, Landroid/content/SharedPreferences;->edit()Landroid/content/SharedPreferences$Editor;

    move-result-object v4

    const-string v5, "dstk_last_time"

    invoke-static {}, Ljava/lang/System;->currentTimeMillis()J

    move-result-wide v6

    invoke-interface {v4, v5, v6, v7}, Landroid/content/SharedPreferences$Editor;->putLong(Ljava/lang/String;J)Landroid/content/SharedPreferences$Editor;

    move-result-object v4

    const-string v5, "dstk_cnt"

    const/16 v6, 0x1388

    if-ne v1, v6, :cond_3

    move v1, v0

    .line 271
    :goto_0
    invoke-interface {v4, v5, v1}, Landroid/content/SharedPreferences$Editor;->putInt(Ljava/lang/String;I)Landroid/content/SharedPreferences$Editor;

    move-result-object v1

    .line 272
    invoke-interface {v1}, Landroid/content/SharedPreferences$Editor;->commit()Z

    .line 279
    :cond_0
    const-string v1, "n_sess_dp"

    const-string v4, ""

    invoke-interface {v3, v1, v4}, Landroid/content/SharedPreferences;->getString(Ljava/lang/String;Ljava/lang/String;)Ljava/lang/String;

    move-result-object v4

    .line 280
    invoke-static {v4}, Landroid/text/TextUtils;->isEmpty(Ljava/lang/CharSequence;)Z

    move-result v1

    if-eqz v1, :cond_4

    .line 281
    new-instance v1, Lorg/json/JSONArray;

    invoke-direct {v1}, Lorg/json/JSONArray;-><init>()V

    .line 286
    :goto_1
    invoke-static {}, Lcom/umeng/analytics/b;->a()Lcom/umeng/analytics/b;

    move-result-object v4

    .line 287
    invoke-virtual {v4}, Lcom/umeng/analytics/b;->i()Lorg/json/JSONObject;

    move-result-object v4

    .line 290
    const-string v5, "-1"

    invoke-virtual {v5, v2}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v5

    if-eqz v5, :cond_5

    .line 292
    const-string v0, "n_sess_dp_type"

    invoke-virtual {p1, v0, p2}, Lorg/json/JSONObject;->put(Ljava/lang/String;I)Lorg/json/JSONObject;

    .line 293
    const-string v0, "_$!sp"

    invoke-virtual {p1, v0}, Lorg/json/JSONObject;->has(Ljava/lang/String;)Z

    move-result v0

    if-nez v0, :cond_1

    .line 294
    invoke-virtual {v4}, Lorg/json/JSONObject;->length()I

    move-result v0

    if-lez v0, :cond_1

    .line 295
    const-string v0, "_$!sp"

    invoke-virtual {p1, v0, v4}, Lorg/json/JSONObject;->put(Ljava/lang/String;Ljava/lang/Object;)Lorg/json/JSONObject;

    .line 298
    :cond_1
    invoke-virtual {v1, p1}, Lorg/json/JSONArray;->put(Ljava/lang/Object;)Lorg/json/JSONArray;

    .line 300
    invoke-interface {v3}, Landroid/content/SharedPreferences;->edit()Landroid/content/SharedPreferences$Editor;

    move-result-object v0

    const-string v2, "n_sess_dp"

    invoke-virtual {v1}, Lorg/json/JSONArray;->toString()Ljava/lang/String;

    move-result-object v1

    invoke-interface {v0, v2, v1}, Landroid/content/SharedPreferences$Editor;->putString(Ljava/lang/String;Ljava/lang/String;)Landroid/content/SharedPreferences$Editor;

    move-result-object v0

    invoke-interface {v0}, Landroid/content/SharedPreferences$Editor;->commit()Z

    .line 379
    :cond_2
    :goto_2
    return-void

    .line 270
    :cond_3
    add-int/lit8 v1, v1, 0x1

    goto :goto_0

    .line 283
    :cond_4
    new-instance v1, Lorg/json/JSONArray;

    invoke-direct {v1, v4}, Lorg/json/JSONArray;-><init>(Ljava/lang/String;)V

    goto :goto_1

    .line 377
    :catch_0
    move-exception v0

    goto :goto_2

    .line 304
    :cond_5
    const/4 v5, 0x3

    if-eq p2, v5, :cond_9

    .line 305
    invoke-virtual {v1}, Lorg/json/JSONArray;->length()I

    move-result v5

    if-lez v5, :cond_9

    .line 308
    :goto_3
    invoke-virtual {v1}, Lorg/json/JSONArray;->length()I

    move-result v5

    if-ge v0, v5, :cond_8

    .line 309
    invoke-virtual {v1, v0}, Lorg/json/JSONArray;->getJSONObject(I)Lorg/json/JSONObject;

    move-result-object v5

    .line 311
    if-eqz v5, :cond_7

    invoke-virtual {v5}, Lorg/json/JSONObject;->length()I

    move-result v6

    if-lez v6, :cond_7

    .line 312
    const-string v6, "n_sess_dp_type"

    invoke-virtual {v5, v6}, Lorg/json/JSONObject;->getInt(Ljava/lang/String;)I

    move-result v6

    .line 314
    const-string v7, "_$!sp"

    invoke-virtual {v5, v7}, Lorg/json/JSONObject;->has(Ljava/lang/String;)Z

    move-result v7

    if-nez v7, :cond_6

    .line 315
    invoke-virtual {v4}, Lorg/json/JSONObject;->length()I

    move-result v7

    if-lez v7, :cond_6

    .line 316
    const-string v7, "_$!sp"

    invoke-virtual {v5, v7, v4}, Lorg/json/JSONObject;->put(Ljava/lang/String;Ljava/lang/Object;)Lorg/json/JSONObject;

    .line 320
    :cond_6
    packed-switch v6, :pswitch_data_0

    .line 337
    :goto_4
    const-string v7, "__ii"

    invoke-virtual {v5, v7, v2}, Lorg/json/JSONObject;->put(Ljava/lang/String;Ljava/lang/Object;)Lorg/json/JSONObject;

    .line 338
    const-string v7, "n_sess_dp_type"

    invoke-virtual {v5, v7}, Lorg/json/JSONObject;->remove(Ljava/lang/String;)Ljava/lang/Object;

    .line 340
    sget-object v7, Lcom/umeng/analytics/pro/i;->a:Landroid/content/Context;

    invoke-static {v7}, Lcom/umeng/analytics/pro/g;->a(Landroid/content/Context;)Lcom/umeng/analytics/pro/g;

    move-result-object v7

    invoke-virtual {v7, v5, v6}, Lcom/umeng/analytics/pro/g;->a(Lorg/json/JSONObject;I)V

    .line 308
    :cond_7
    add-int/lit8 v0, v0, 0x1

    goto :goto_3

    .line 325
    :pswitch_0
    const-string v7, "_$!ts"

    invoke-static {}, Ljava/lang/System;->currentTimeMillis()J

    move-result-wide v8

    invoke-virtual {v5, v7, v8, v9}, Lorg/json/JSONObject;->put(Ljava/lang/String;J)Lorg/json/JSONObject;

    goto :goto_4

    .line 331
    :pswitch_1
    const-string v7, "_$!ts"

    invoke-static {}, Ljava/lang/System;->currentTimeMillis()J

    move-result-wide v8

    invoke-virtual {v5, v7, v8, v9}, Lorg/json/JSONObject;->put(Ljava/lang/String;J)Lorg/json/JSONObject;

    goto :goto_4

    .line 344
    :cond_8
    invoke-static {}, Lcom/umeng/analytics/b;->a()Lcom/umeng/analytics/b;

    move-result-object v0

    invoke-virtual {v0}, Lcom/umeng/analytics/b;->d()V

    .line 345
    invoke-interface {v3}, Landroid/content/SharedPreferences;->edit()Landroid/content/SharedPreferences$Editor;

    move-result-object v0

    const-string v1, "n_sess_dp"

    invoke-interface {v0, v1}, Landroid/content/SharedPreferences$Editor;->remove(Ljava/lang/String;)Landroid/content/SharedPreferences$Editor;

    move-result-object v0

    invoke-interface {v0}, Landroid/content/SharedPreferences$Editor;->commit()Z

    .line 349
    :cond_9
    sget-object v0, Lcom/umeng/analytics/pro/i;->a:Landroid/content/Context;

    invoke-static {v0}, Lcom/umeng/analytics/pro/g;->a(Landroid/content/Context;)Lcom/umeng/analytics/pro/g;

    move-result-object v0

    invoke-virtual {v0, p1, p2}, Lcom/umeng/analytics/pro/g;->a(Lorg/json/JSONObject;I)V

    .line 356
    if-eqz p3, :cond_a

    .line 357
    const/4 v0, 0x1

    invoke-direct {p0, v0}, Lcom/umeng/analytics/pro/i;->c(Z)V

    goto/16 :goto_2

    .line 359
    :cond_a
    sget-object v0, Lcom/umeng/analytics/pro/i;->a:Landroid/content/Context;

    sget-object v1, Lcom/umeng/commonsdk/framework/UMLogDataProtocol$UMBusinessType;->U_DPLUS:Lcom/umeng/commonsdk/framework/UMLogDataProtocol$UMBusinessType;

    invoke-static {v0, v1}, Lcom/umeng/commonsdk/framework/UMEnvelopeBuild;->isReadyBuild(Landroid/content/Context;Lcom/umeng/commonsdk/framework/UMLogDataProtocol$UMBusinessType;)Z

    move-result v0

    if-eqz v0, :cond_2

    .line 361
    sget-object v0, Lcom/umeng/analytics/pro/i;->a:Landroid/content/Context;

    invoke-static {v0}, Lcom/umeng/commonsdk/statistics/noise/Defcon;->getService(Landroid/content/Context;)Lcom/umeng/commonsdk/statistics/noise/Defcon;

    move-result-object v0

    .line 362
    invoke-virtual {v0}, Lcom/umeng/commonsdk/statistics/noise/Defcon;->isOpen()Z

    move-result v1

    if-eqz v1, :cond_b

    .line 363
    new-instance v1, Lcom/umeng/commonsdk/statistics/common/ReportPolicy$DefconPolicy;

    sget-object v2, Lcom/umeng/analytics/pro/i;->a:Landroid/content/Context;

    invoke-static {v2}, Lcom/umeng/commonsdk/statistics/internal/StatTracer;->getInstance(Landroid/content/Context;)Lcom/umeng/commonsdk/statistics/internal/StatTracer;

    move-result-object v2

    invoke-direct {v1, v2, v0}, Lcom/umeng/commonsdk/statistics/common/ReportPolicy$DefconPolicy;-><init>(Lcom/umeng/commonsdk/statistics/internal/StatTracer;Lcom/umeng/commonsdk/statistics/noise/Defcon;)V

    const/4 v0, 0x0

    .line 364
    invoke-virtual {v1, v0}, Lcom/umeng/commonsdk/statistics/common/ReportPolicy$DefconPolicy;->shouldSendMessage(Z)Z

    move-result v0

    .line 365
    if-eqz v0, :cond_2

    .line 366
    const/4 v0, 0x1

    invoke-direct {p0, v0}, Lcom/umeng/analytics/pro/i;->c(Z)V

    goto/16 :goto_2

    .line 370
    :cond_b
    const/4 v0, 0x1

    invoke-direct {p0, v0}, Lcom/umeng/analytics/pro/i;->c(Z)V
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_0

    goto/16 :goto_2

    .line 320
    nop

    :pswitch_data_0
    .packed-switch 0x0
        :pswitch_1
        :pswitch_0
    .end packed-switch
.end method

.method public a(Lorg/json/JSONObject;)V
    .locals 5

    .prologue
    .line 1825
    :try_start_0
    sget-object v0, Lcom/umeng/analytics/pro/i;->a:Landroid/content/Context;

    sget-object v1, Lcom/umeng/commonsdk/framework/UMLogDataProtocol$UMBusinessType;->U_DPLUS:Lcom/umeng/commonsdk/framework/UMLogDataProtocol$UMBusinessType;

    invoke-static {v0, v1}, Lcom/umeng/commonsdk/framework/UMEnvelopeBuild;->isReadyBuild(Landroid/content/Context;Lcom/umeng/commonsdk/framework/UMLogDataProtocol$UMBusinessType;)Z

    move-result v0

    if-eqz v0, :cond_0

    .line 1829
    if-eqz p1, :cond_0

    .line 1831
    const/4 v0, 0x1

    invoke-direct {p0, v0}, Lcom/umeng/analytics/pro/i;->d(Z)Lorg/json/JSONObject;

    move-result-object v0

    .line 1832
    if-eqz v0, :cond_0

    invoke-virtual {v0}, Lorg/json/JSONObject;->length()I

    move-result v1

    if-lez v1, :cond_0

    .line 1833
    new-instance v1, Lorg/json/JSONObject;

    invoke-direct {v1}, Lorg/json/JSONObject;-><init>()V

    .line 1834
    new-instance v2, Lorg/json/JSONArray;

    invoke-direct {v2}, Lorg/json/JSONArray;-><init>()V

    .line 1835
    invoke-virtual {v2, p1}, Lorg/json/JSONArray;->put(Ljava/lang/Object;)Lorg/json/JSONArray;

    .line 1836
    new-instance v3, Lorg/json/JSONObject;

    invoke-direct {v3}, Lorg/json/JSONObject;-><init>()V

    .line 1837
    const-string v4, "session"

    invoke-virtual {v3, v4, v2}, Lorg/json/JSONObject;->put(Ljava/lang/String;Ljava/lang/Object;)Lorg/json/JSONObject;

    .line 1838
    const-string v2, "dplus"

    invoke-virtual {v1, v2, v3}, Lorg/json/JSONObject;->put(Ljava/lang/String;Ljava/lang/Object;)Lorg/json/JSONObject;

    .line 1839
    sget-object v2, Lcom/umeng/analytics/pro/i;->a:Landroid/content/Context;

    if-eqz v2, :cond_0

    if-eqz v0, :cond_0

    if-eqz v1, :cond_0

    .line 1841
    sget-object v2, Lcom/umeng/analytics/pro/i;->a:Landroid/content/Context;

    invoke-static {v2, v0, v1}, Lcom/umeng/commonsdk/framework/UMEnvelopeBuild;->buildEnvelopeWithExtHeader(Landroid/content/Context;Lorg/json/JSONObject;Lorg/json/JSONObject;)Lorg/json/JSONObject;
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_0

    .line 1848
    :cond_0
    :goto_0
    return-void

    .line 1846
    :catch_0
    move-exception v0

    goto :goto_0
.end method

.method public a(Z)V
    .locals 2

    .prologue
    .line 388
    invoke-direct {p0, p1}, Lcom/umeng/analytics/pro/i;->e(Z)Z

    move-result v0

    if-eqz v0, :cond_0

    .line 389
    sget-object v0, Lcom/umeng/analytics/pro/i;->a:Landroid/content/Context;

    sget-object v1, Lcom/umeng/commonsdk/framework/UMLogDataProtocol$UMBusinessType;->U_APP:Lcom/umeng/commonsdk/framework/UMLogDataProtocol$UMBusinessType;

    invoke-static {v0, v1}, Lcom/umeng/commonsdk/framework/UMEnvelopeBuild;->isReadyBuild(Landroid/content/Context;Lcom/umeng/commonsdk/framework/UMLogDataProtocol$UMBusinessType;)Z

    move-result v0

    if-eqz v0, :cond_0

    .line 390
    const/4 v0, 0x0

    invoke-direct {p0, v0}, Lcom/umeng/analytics/pro/i;->c(Z)V

    .line 393
    :cond_0
    return-void
.end method

.method public b(J)Lorg/json/JSONObject;
    .locals 5

    .prologue
    const/4 v1, 0x0

    .line 530
    sget-boolean v0, Lcom/umeng/analytics/AnalyticsConfig;->FLAG_DPLUS:Z

    if-nez v0, :cond_0

    move-object v0, v1

    .line 594
    :goto_0
    return-object v0

    .line 539
    :cond_0
    invoke-static {}, Lcom/umeng/analytics/pro/o;->a()Lcom/umeng/analytics/pro/o;

    move-result-object v0

    sget-object v2, Lcom/umeng/analytics/pro/i;->a:Landroid/content/Context;

    invoke-virtual {v0, v2}, Lcom/umeng/analytics/pro/o;->c(Landroid/content/Context;)Ljava/lang/String;

    move-result-object v0

    invoke-static {v0}, Landroid/text/TextUtils;->isEmpty(Ljava/lang/CharSequence;)Z

    move-result v0

    if-eqz v0, :cond_1

    move-object v0, v1

    .line 540
    goto :goto_0

    .line 543
    :cond_1
    new-instance v0, Lorg/json/JSONObject;

    invoke-direct {v0}, Lorg/json/JSONObject;-><init>()V

    .line 544
    sget-boolean v2, Lcom/umeng/analytics/AnalyticsConfig;->FLAG_DPLUS:Z

    if-eqz v2, :cond_2

    .line 546
    sget-object v0, Lcom/umeng/analytics/pro/i;->a:Landroid/content/Context;

    invoke-static {v0}, Lcom/umeng/analytics/pro/g;->a(Landroid/content/Context;)Lcom/umeng/analytics/pro/g;

    move-result-object v0

    invoke-virtual {v0}, Lcom/umeng/analytics/pro/g;->c()Lorg/json/JSONObject;

    move-result-object v0

    .line 548
    invoke-static {}, Lcom/umeng/analytics/pro/l;->a()Lcom/umeng/analytics/pro/l;

    move-result-object v2

    sget-object v3, Lcom/umeng/analytics/pro/i;->a:Landroid/content/Context;

    invoke-virtual {v2, v0, v3}, Lcom/umeng/analytics/pro/l;->a(Lorg/json/JSONObject;Landroid/content/Context;)V

    .line 551
    sget-object v2, Lcom/umeng/analytics/pro/i;->a:Landroid/content/Context;

    invoke-static {v2}, Lcom/umeng/commonsdk/statistics/noise/Defcon;->getService(Landroid/content/Context;)Lcom/umeng/commonsdk/statistics/noise/Defcon;

    move-result-object v2

    .line 552
    invoke-virtual {v2}, Lcom/umeng/commonsdk/statistics/noise/Defcon;->isOpen()Z

    move-result v3

    if-eqz v3, :cond_2

    .line 553
    new-instance v3, Lcom/umeng/commonsdk/statistics/common/ReportPolicy$DefconPolicy;

    sget-object v4, Lcom/umeng/analytics/pro/i;->a:Landroid/content/Context;

    invoke-static {v4}, Lcom/umeng/commonsdk/statistics/internal/StatTracer;->getInstance(Landroid/content/Context;)Lcom/umeng/commonsdk/statistics/internal/StatTracer;

    move-result-object v4

    invoke-direct {v3, v4, v2}, Lcom/umeng/commonsdk/statistics/common/ReportPolicy$DefconPolicy;-><init>(Lcom/umeng/commonsdk/statistics/internal/StatTracer;Lcom/umeng/commonsdk/statistics/noise/Defcon;)V

    const/4 v2, 0x0

    .line 555
    invoke-virtual {v3, v2}, Lcom/umeng/commonsdk/statistics/common/ReportPolicy$DefconPolicy;->shouldSendMessage(Z)Z

    move-result v2

    .line 556
    if-nez v2, :cond_2

    .line 557
    new-instance v0, Lorg/json/JSONObject;

    invoke-direct {v0}, Lorg/json/JSONObject;-><init>()V

    .line 565
    :cond_2
    invoke-virtual {v0}, Lorg/json/JSONObject;->length()I

    move-result v2

    if-gtz v2, :cond_3

    move-object v0, v1

    .line 567
    goto :goto_0

    .line 571
    :cond_3
    const/4 v1, 0x1

    invoke-direct {p0, v1}, Lcom/umeng/analytics/pro/i;->d(Z)Lorg/json/JSONObject;

    move-result-object v2

    .line 573
    new-instance v1, Lorg/json/JSONObject;

    invoke-direct {v1}, Lorg/json/JSONObject;-><init>()V

    .line 575
    :try_start_0
    new-instance v3, Lorg/json/JSONObject;

    invoke-direct {v3}, Lorg/json/JSONObject;-><init>()V

    .line 576
    if-eqz v0, :cond_4

    invoke-virtual {v0}, Lorg/json/JSONObject;->length()I

    move-result v4

    if-lez v4, :cond_4

    .line 577
    const-string v4, "dplus"

    invoke-virtual {v3, v4, v0}, Lorg/json/JSONObject;->put(Ljava/lang/String;Ljava/lang/Object;)Lorg/json/JSONObject;

    .line 580
    :cond_4
    if-eqz v2, :cond_5

    invoke-virtual {v2}, Lorg/json/JSONObject;->length()I

    move-result v0

    if-lez v0, :cond_5

    .line 581
    const-string v0, "header"

    invoke-virtual {v1, v0, v2}, Lorg/json/JSONObject;->put(Ljava/lang/String;Ljava/lang/Object;)Lorg/json/JSONObject;

    .line 584
    :cond_5
    invoke-virtual {v3}, Lorg/json/JSONObject;->length()I

    move-result v0

    if-lez v0, :cond_6

    .line 585
    const-string v0, "content"

    invoke-virtual {v1, v0, v3}, Lorg/json/JSONObject;->put(Ljava/lang/String;Ljava/lang/Object;)Lorg/json/JSONObject;

    .line 588
    :cond_6
    invoke-direct {p0, v1, p1, p2}, Lcom/umeng/analytics/pro/i;->a(Lorg/json/JSONObject;J)Lorg/json/JSONObject;
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_0

    move-result-object v0

    goto/16 :goto_0

    .line 589
    :catch_0
    move-exception v0

    move-object v0, v1

    goto/16 :goto_0
.end method

.method public b(Z)Lorg/json/JSONObject;
    .locals 6

    .prologue
    const-wide/16 v4, 0x0

    .line 744
    const/4 v0, 0x0

    .line 754
    :try_start_0
    sget-object v1, Lcom/umeng/analytics/pro/i;->a:Landroid/content/Context;

    invoke-static {v1}, Lcom/umeng/analytics/pro/g;->a(Landroid/content/Context;)Lcom/umeng/analytics/pro/g;

    move-result-object v1

    invoke-virtual {v1, p1}, Lcom/umeng/analytics/pro/g;->a(Z)Lorg/json/JSONObject;

    move-result-object v0

    .line 755
    if-nez v0, :cond_0

    .line 756
    new-instance v1, Lorg/json/JSONObject;

    invoke-direct {v1}, Lorg/json/JSONObject;-><init>()V

    move-object v0, v1

    .line 762
    :cond_0
    sget-object v1, Lcom/umeng/analytics/pro/i;->a:Landroid/content/Context;

    invoke-static {v1}, Lcom/umeng/commonsdk/statistics/internal/PreferenceWrapper;->getDefault(Landroid/content/Context;)Landroid/content/SharedPreferences;

    move-result-object v1

    .line 763
    if-eqz v1, :cond_1

    .line 764
    const-string v2, "userlevel"

    const-string v3, ""

    invoke-interface {v1, v2, v3}, Landroid/content/SharedPreferences;->getString(Ljava/lang/String;Ljava/lang/String;)Ljava/lang/String;

    move-result-object v2

    .line 765
    invoke-static {v2}, Landroid/text/TextUtils;->isEmpty(Ljava/lang/CharSequence;)Z

    move-result v3

    if-nez v3, :cond_1

    .line 766
    const-string v3, "userlevel"

    invoke-virtual {v0, v3, v2}, Lorg/json/JSONObject;->put(Ljava/lang/String;Ljava/lang/Object;)Lorg/json/JSONObject;

    .line 775
    :cond_1
    invoke-direct {p0}, Lcom/umeng/analytics/pro/i;->n()Z

    move-result v2

    if-eqz v2, :cond_2

    .line 776
    invoke-virtual {p0}, Lcom/umeng/analytics/pro/i;->c()J

    move-result-wide v2

    iput-wide v2, p0, Lcom/umeng/analytics/pro/i;->j:J

    .line 777
    iget-wide v2, p0, Lcom/umeng/analytics/pro/i;->j:J

    cmp-long v2, v2, v4

    if-eqz v2, :cond_2

    .line 778
    new-instance v2, Lorg/json/JSONObject;

    invoke-direct {v2}, Lorg/json/JSONObject;-><init>()V

    .line 779
    const-string v3, "ts"

    iget-wide v4, p0, Lcom/umeng/analytics/pro/i;->j:J

    invoke-virtual {v2, v3, v4, v5}, Lorg/json/JSONObject;->put(Ljava/lang/String;J)Lorg/json/JSONObject;

    .line 780
    const-string v3, "activate_msg"

    invoke-virtual {v0, v3, v2}, Lorg/json/JSONObject;->put(Ljava/lang/String;Ljava/lang/Object;)Lorg/json/JSONObject;

    .line 781
    invoke-interface {v1}, Landroid/content/SharedPreferences;->edit()Landroid/content/SharedPreferences$Editor;

    move-result-object v1

    const-string v2, "ana_is_f"

    const-wide/16 v4, 0x0

    invoke-interface {v1, v2, v4, v5}, Landroid/content/SharedPreferences$Editor;->putLong(Ljava/lang/String;J)Landroid/content/SharedPreferences$Editor;

    move-result-object v1

    invoke-interface {v1}, Landroid/content/SharedPreferences$Editor;->commit()Z

    .line 788
    :cond_2
    sget-object v1, Lcom/umeng/analytics/pro/i;->a:Landroid/content/Context;

    invoke-static {v1}, Lcom/umeng/analytics/c;->a(Landroid/content/Context;)[Ljava/lang/String;

    move-result-object v1

    .line 789
    if-eqz v1, :cond_3

    const/4 v2, 0x0

    aget-object v2, v1, v2

    invoke-static {v2}, Landroid/text/TextUtils;->isEmpty(Ljava/lang/CharSequence;)Z

    move-result v2

    if-nez v2, :cond_3

    const/4 v2, 0x1

    aget-object v2, v1, v2

    invoke-static {v2}, Landroid/text/TextUtils;->isEmpty(Ljava/lang/CharSequence;)Z

    move-result v2

    if-nez v2, :cond_3

    .line 790
    new-instance v2, Lorg/json/JSONObject;

    invoke-direct {v2}, Lorg/json/JSONObject;-><init>()V

    .line 791
    const-string v3, "provider"

    const/4 v4, 0x0

    aget-object v4, v1, v4

    invoke-virtual {v2, v3, v4}, Lorg/json/JSONObject;->put(Ljava/lang/String;Ljava/lang/Object;)Lorg/json/JSONObject;

    .line 792
    const-string v3, "puid"

    const/4 v4, 0x1

    aget-object v1, v1, v4

    invoke-virtual {v2, v3, v1}, Lorg/json/JSONObject;->put(Ljava/lang/String;Ljava/lang/Object;)Lorg/json/JSONObject;

    .line 793
    invoke-virtual {v2}, Lorg/json/JSONObject;->length()I

    move-result v1

    if-lez v1, :cond_3

    const-string v1, "active_user"

    invoke-virtual {v0, v1, v2}, Lorg/json/JSONObject;->put(Ljava/lang/String;Ljava/lang/Object;)Lorg/json/JSONObject;

    .line 798
    :cond_3
    sget-object v1, Lcom/umeng/analytics/pro/i;->a:Landroid/content/Context;

    invoke-static {v1}, Lcom/umeng/commonsdk/statistics/noise/ABTest;->getService(Landroid/content/Context;)Lcom/umeng/commonsdk/statistics/noise/ABTest;

    move-result-object v1

    invoke-virtual {v1}, Lcom/umeng/commonsdk/statistics/noise/ABTest;->isInTest()Z

    move-result v1

    if-eqz v1, :cond_4

    .line 799
    new-instance v1, Lorg/json/JSONObject;

    invoke-direct {v1}, Lorg/json/JSONObject;-><init>()V

    .line 800
    sget-object v2, Lcom/umeng/analytics/pro/i;->a:Landroid/content/Context;

    invoke-static {v2}, Lcom/umeng/commonsdk/statistics/noise/ABTest;->getService(Landroid/content/Context;)Lcom/umeng/commonsdk/statistics/noise/ABTest;

    move-result-object v2

    invoke-virtual {v2}, Lcom/umeng/commonsdk/statistics/noise/ABTest;->getTestName()Ljava/lang/String;

    move-result-object v2

    sget-object v3, Lcom/umeng/analytics/pro/i;->a:Landroid/content/Context;

    invoke-static {v3}, Lcom/umeng/commonsdk/statistics/noise/ABTest;->getService(Landroid/content/Context;)Lcom/umeng/commonsdk/statistics/noise/ABTest;

    move-result-object v3

    invoke-virtual {v3}, Lcom/umeng/commonsdk/statistics/noise/ABTest;->getGroupInfo()Ljava/lang/String;

    move-result-object v3

    invoke-virtual {v1, v2, v3}, Lorg/json/JSONObject;->put(Ljava/lang/String;Ljava/lang/Object;)Lorg/json/JSONObject;

    .line 801
    const-string v2, "group_info"

    invoke-virtual {v0, v2, v1}, Lorg/json/JSONObject;->put(Ljava/lang/String;Ljava/lang/Object;)Lorg/json/JSONObject;

    .line 804
    :cond_4
    invoke-static {}, Lcom/umeng/analytics/pro/l;->a()Lcom/umeng/analytics/pro/l;

    move-result-object v1

    sget-object v2, Lcom/umeng/analytics/pro/i;->a:Landroid/content/Context;

    invoke-virtual {v1, v0, v2}, Lcom/umeng/analytics/pro/l;->b(Lorg/json/JSONObject;Landroid/content/Context;)V

    .line 806
    invoke-virtual {v0}, Lorg/json/JSONObject;->length()I

    move-result v1

    if-lez v1, :cond_5

    .line 807
    new-instance v1, Lorg/json/JSONObject;

    invoke-direct {v1}, Lorg/json/JSONObject;-><init>()V

    .line 808
    const-string v2, "analytics"

    invoke-virtual {v1, v2, v0}, Lorg/json/JSONObject;->put(Ljava/lang/String;Ljava/lang/Object;)Lorg/json/JSONObject;
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_0

    .line 812
    :cond_5
    :goto_0
    return-object v0

    .line 810
    :catch_0
    move-exception v1

    goto :goto_0
.end method

.method public b()V
    .locals 1

    .prologue
    .line 1579
    const/4 v0, 0x1

    sput-boolean v0, Lcom/umeng/analytics/pro/i;->z:Z

    .line 1580
    const/4 v0, 0x0

    invoke-direct {p0, v0}, Lcom/umeng/analytics/pro/i;->c(Z)V

    .line 1581
    return-void
.end method

.method public b(Landroid/content/Context;)V
    .locals 1

    .prologue
    .line 1569
    :try_start_0
    invoke-static {p1}, Lcom/umeng/analytics/pro/g;->a(Landroid/content/Context;)Lcom/umeng/analytics/pro/g;

    move-result-object v0

    invoke-virtual {v0}, Lcom/umeng/analytics/pro/g;->b()V

    .line 1571
    invoke-direct {p0}, Lcom/umeng/analytics/pro/i;->l()V
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_0

    .line 1573
    :goto_0
    return-void

    .line 1572
    :catch_0
    move-exception v0

    goto :goto_0
.end method

.method public b(Ljava/lang/Object;)V
    .locals 2

    .prologue
    const/4 v1, 0x0

    .line 1556
    const/4 v0, 0x1

    sput-boolean v0, Lcom/umeng/analytics/pro/i;->z:Z

    .line 1557
    sget-object v0, Lcom/umeng/analytics/pro/i;->a:Landroid/content/Context;

    invoke-virtual {p0, v0}, Lcom/umeng/analytics/pro/i;->b(Landroid/content/Context;)V

    .line 1558
    invoke-virtual {p0}, Lcom/umeng/analytics/pro/i;->a()V

    .line 1560
    invoke-direct {p0, v1}, Lcom/umeng/analytics/pro/i;->c(Z)V

    .line 1562
    sget-boolean v0, Lcom/umeng/analytics/AnalyticsConfig;->FLAG_DPLUS:Z

    if-eqz v0, :cond_0

    .line 1563
    const/4 v0, 0x2

    invoke-virtual {p0, p1, v0, v1}, Lcom/umeng/analytics/pro/i;->a(Ljava/lang/Object;IZ)V

    .line 1565
    :cond_0
    return-void
.end method

.method public c()J
    .locals 8

    .prologue
    const-wide/16 v2, 0x0

    .line 1665
    .line 1667
    :try_start_0
    sget-object v0, Lcom/umeng/analytics/pro/i;->a:Landroid/content/Context;

    if-eqz v0, :cond_1

    .line 1668
    sget-object v0, Lcom/umeng/analytics/pro/i;->a:Landroid/content/Context;

    invoke-static {v0}, Lcom/umeng/commonsdk/statistics/internal/PreferenceWrapper;->getDefault(Landroid/content/Context;)Landroid/content/SharedPreferences;

    move-result-object v4

    .line 1669
    if-eqz v4, :cond_1

    .line 1670
    const-string v0, "first_activate_time"

    const-wide/16 v6, 0x0

    invoke-interface {v4, v0, v6, v7}, Landroid/content/SharedPreferences;->getLong(Ljava/lang/String;J)J
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_0

    move-result-wide v0

    .line 1671
    cmp-long v2, v0, v2

    if-nez v2, :cond_0

    .line 1672
    :try_start_1
    invoke-static {}, Ljava/lang/System;->currentTimeMillis()J

    move-result-wide v0

    .line 1673
    invoke-interface {v4}, Landroid/content/SharedPreferences;->edit()Landroid/content/SharedPreferences$Editor;

    move-result-object v2

    const-string v3, "first_activate_time"

    invoke-interface {v2, v3, v0, v1}, Landroid/content/SharedPreferences$Editor;->putLong(Ljava/lang/String;J)Landroid/content/SharedPreferences$Editor;

    move-result-object v2

    invoke-interface {v2}, Landroid/content/SharedPreferences$Editor;->commit()Z
    :try_end_1
    .catch Ljava/lang/Throwable; {:try_start_1 .. :try_end_1} :catch_1

    .line 1679
    :cond_0
    :goto_0
    return-wide v0

    .line 1677
    :catch_0
    move-exception v0

    move-wide v0, v2

    goto :goto_0

    :catch_1
    move-exception v2

    goto :goto_0

    :cond_1
    move-wide v0, v2

    goto :goto_0
.end method

.method public c(Ljava/lang/Object;)V
    .locals 2

    .prologue
    const/4 v0, 0x1

    .line 1589
    invoke-direct {p0}, Lcom/umeng/analytics/pro/i;->m()V

    .line 1590
    sput-boolean v0, Lcom/umeng/analytics/pro/i;->A:Z

    .line 1592
    invoke-direct {p0}, Lcom/umeng/analytics/pro/i;->f()Ljava/lang/String;

    .line 1593
    invoke-direct {p0}, Lcom/umeng/analytics/pro/i;->g()Ljava/lang/String;

    .line 1595
    invoke-direct {p0}, Lcom/umeng/analytics/pro/i;->h()Ljava/lang/String;

    .line 1596
    invoke-direct {p0}, Lcom/umeng/analytics/pro/i;->i()Ljava/lang/String;

    .line 1598
    invoke-virtual {p0, v0}, Lcom/umeng/analytics/pro/i;->a(Z)V

    .line 1600
    sget-boolean v0, Lcom/umeng/analytics/AnalyticsConfig;->FLAG_DPLUS:Z

    if-eqz v0, :cond_0

    .line 1601
    const/4 v0, 0x2

    const/4 v1, 0x0

    invoke-virtual {p0, p1, v0, v1}, Lcom/umeng/analytics/pro/i;->a(Ljava/lang/Object;IZ)V

    .line 1603
    :cond_0
    return-void
.end method

.method public d()V
    .locals 10

    .prologue
    .line 1770
    :try_start_0
    invoke-static {}, Lcom/umeng/analytics/pro/o;->a()Lcom/umeng/analytics/pro/o;

    move-result-object v0

    invoke-virtual {v0}, Lcom/umeng/analytics/pro/o;->c()Ljava/lang/String;

    move-result-object v2

    .line 1771
    invoke-static {v2}, Landroid/text/TextUtils;->isEmpty(Ljava/lang/CharSequence;)Z

    move-result v0

    if-nez v0, :cond_2

    .line 1773
    sget-object v0, Lcom/umeng/analytics/pro/i;->a:Landroid/content/Context;

    invoke-static {v0}, Lcom/umeng/commonsdk/statistics/internal/PreferenceWrapper;->getDefault(Landroid/content/Context;)Landroid/content/SharedPreferences;

    move-result-object v3

    .line 1774
    const-string v0, "n_sess_dp"

    const-string v1, ""

    invoke-interface {v3, v0, v1}, Landroid/content/SharedPreferences;->getString(Ljava/lang/String;Ljava/lang/String;)Ljava/lang/String;

    move-result-object v1

    .line 1776
    invoke-static {v1}, Landroid/text/TextUtils;->isEmpty(Ljava/lang/CharSequence;)Z

    move-result v0

    if-eqz v0, :cond_1

    .line 1777
    new-instance v0, Lorg/json/JSONArray;

    invoke-direct {v0}, Lorg/json/JSONArray;-><init>()V

    move-object v1, v0

    .line 1782
    :goto_0
    invoke-virtual {v1}, Lorg/json/JSONArray;->length()I

    move-result v0

    if-lez v0, :cond_2

    .line 1784
    const/4 v0, 0x0

    :goto_1
    invoke-virtual {v1}, Lorg/json/JSONArray;->length()I

    move-result v4

    if-ge v0, v4, :cond_3

    .line 1785
    invoke-virtual {v1, v0}, Lorg/json/JSONArray;->getJSONObject(I)Lorg/json/JSONObject;

    move-result-object v4

    .line 1787
    if-eqz v4, :cond_0

    invoke-virtual {v4}, Lorg/json/JSONObject;->length()I

    move-result v5

    if-lez v5, :cond_0

    .line 1788
    const-string v5, "n_sess_dp_type"

    invoke-virtual {v4, v5}, Lorg/json/JSONObject;->getInt(Ljava/lang/String;)I

    move-result v5

    .line 1790
    packed-switch v5, :pswitch_data_0

    .line 1801
    :goto_2
    const-string v6, "__ii"

    invoke-virtual {v4, v6, v2}, Lorg/json/JSONObject;->put(Ljava/lang/String;Ljava/lang/Object;)Lorg/json/JSONObject;

    .line 1802
    const-string v6, "n_sess_dp_type"

    invoke-virtual {v4, v6}, Lorg/json/JSONObject;->remove(Ljava/lang/String;)Ljava/lang/Object;

    .line 1804
    sget-object v6, Lcom/umeng/analytics/pro/i;->a:Landroid/content/Context;

    invoke-static {v6}, Lcom/umeng/analytics/pro/g;->a(Landroid/content/Context;)Lcom/umeng/analytics/pro/g;

    move-result-object v6

    invoke-virtual {v6, v4, v5}, Lcom/umeng/analytics/pro/g;->a(Lorg/json/JSONObject;I)V

    .line 1784
    :cond_0
    add-int/lit8 v0, v0, 0x1

    goto :goto_1

    .line 1779
    :cond_1
    new-instance v0, Lorg/json/JSONArray;

    invoke-direct {v0, v1}, Lorg/json/JSONArray;-><init>(Ljava/lang/String;)V

    move-object v1, v0

    goto :goto_0

    .line 1792
    :pswitch_0
    const-string v6, "_$!ts"

    invoke-static {}, Ljava/lang/System;->currentTimeMillis()J

    move-result-wide v8

    invoke-virtual {v4, v6, v8, v9}, Lorg/json/JSONObject;->put(Ljava/lang/String;J)Lorg/json/JSONObject;

    goto :goto_2

    .line 1814
    :catch_0
    move-exception v0

    .line 1816
    :cond_2
    :goto_3
    return-void

    .line 1795
    :pswitch_1
    const-string v6, "_$!ts"

    invoke-static {}, Ljava/lang/System;->currentTimeMillis()J

    move-result-wide v8

    invoke-virtual {v4, v6, v8, v9}, Lorg/json/JSONObject;->put(Ljava/lang/String;J)Lorg/json/JSONObject;

    goto :goto_2

    .line 1807
    :cond_3
    invoke-interface {v3}, Landroid/content/SharedPreferences;->edit()Landroid/content/SharedPreferences$Editor;

    move-result-object v0

    const-string v1, "n_sess_dp"

    invoke-interface {v0, v1}, Landroid/content/SharedPreferences$Editor;->remove(Ljava/lang/String;)Landroid/content/SharedPreferences$Editor;

    move-result-object v0

    invoke-interface {v0}, Landroid/content/SharedPreferences$Editor;->commit()Z

    .line 1809
    sget-object v0, Lcom/umeng/analytics/pro/i;->a:Landroid/content/Context;

    sget-object v1, Lcom/umeng/commonsdk/framework/UMLogDataProtocol$UMBusinessType;->U_DPLUS:Lcom/umeng/commonsdk/framework/UMLogDataProtocol$UMBusinessType;

    invoke-static {v0, v1}, Lcom/umeng/commonsdk/framework/UMEnvelopeBuild;->isReadyBuild(Landroid/content/Context;Lcom/umeng/commonsdk/framework/UMLogDataProtocol$UMBusinessType;)Z

    move-result v0

    if-eqz v0, :cond_2

    .line 1810
    const/4 v0, 0x1

    invoke-direct {p0, v0}, Lcom/umeng/analytics/pro/i;->c(Z)V
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_0

    goto :goto_3

    .line 1790
    nop

    :pswitch_data_0
    .packed-switch 0x0
        :pswitch_1
        :pswitch_0
    .end packed-switch
.end method
