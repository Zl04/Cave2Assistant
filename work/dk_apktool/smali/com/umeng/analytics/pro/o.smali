.class public Lcom/umeng/analytics/pro/o;
.super Ljava/lang/Object;
.source "SessionTracker.java"


# annotations
.annotation system Ldalvik/annotation/MemberClasses;
    value = {
        Lcom/umeng/analytics/pro/o$a;
    }
.end annotation


# static fields
.field private static final a:Ljava/lang/String; = "session_start_time"

.field private static final b:Ljava/lang/String; = "session_end_time"

.field private static final c:Ljava/lang/String; = "session_id"

.field private static f:Ljava/lang/String;

.field private static g:Landroid/content/Context;


# instance fields
.field private final d:Ljava/lang/String;

.field private final e:Ljava/lang/String;


# direct methods
.method static constructor <clinit>()V
    .locals 1

    .prologue
    const/4 v0, 0x0

    .line 36
    sput-object v0, Lcom/umeng/analytics/pro/o;->f:Ljava/lang/String;

    .line 38
    sput-object v0, Lcom/umeng/analytics/pro/o;->g:Landroid/content/Context;

    return-void
.end method

.method private constructor <init>()V
    .locals 1

    .prologue
    .line 40
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    .line 33
    const-string v0, "a_start_time"

    iput-object v0, p0, Lcom/umeng/analytics/pro/o;->d:Ljava/lang/String;

    .line 34
    const-string v0, "a_end_time"

    iput-object v0, p0, Lcom/umeng/analytics/pro/o;->e:Ljava/lang/String;

    .line 41
    return-void
.end method

.method synthetic constructor <init>(Lcom/umeng/analytics/pro/o$1;)V
    .locals 0

    .prologue
    .line 28
    invoke-direct {p0}, Lcom/umeng/analytics/pro/o;-><init>()V

    return-void
.end method

.method public static a()Lcom/umeng/analytics/pro/o;
    .locals 1

    .prologue
    .line 48
    invoke-static {}, Lcom/umeng/analytics/pro/o$a;->a()Lcom/umeng/analytics/pro/o;

    move-result-object v0

    return-object v0
.end method

.method private a(Landroid/content/Context;Landroid/content/SharedPreferences;J)Ljava/lang/String;
    .locals 7

    .prologue
    .line 337
    sget-object v0, Lcom/umeng/analytics/pro/o;->g:Landroid/content/Context;

    if-nez v0, :cond_0

    .line 338
    if-eqz p1, :cond_0

    .line 339
    invoke-virtual {p1}, Landroid/content/Context;->getApplicationContext()Landroid/content/Context;

    move-result-object v0

    sput-object v0, Lcom/umeng/analytics/pro/o;->g:Landroid/content/Context;

    .line 342
    :cond_0
    sget-object v0, Lcom/umeng/analytics/pro/o;->g:Landroid/content/Context;

    invoke-virtual {p0, v0}, Lcom/umeng/analytics/pro/o;->b(Landroid/content/Context;)Ljava/lang/String;

    move-result-object v0

    .line 346
    :try_start_0
    invoke-direct {p0, p1}, Lcom/umeng/analytics/pro/o;->d(Landroid/content/Context;)V

    .line 348
    new-instance v1, Lorg/json/JSONObject;

    invoke-direct {v1}, Lorg/json/JSONObject;-><init>()V

    .line 349
    const-string v2, "__e"

    invoke-virtual {v1, v2, p3, p4}, Lorg/json/JSONObject;->put(Ljava/lang/String;J)Lorg/json/JSONObject;

    .line 350
    sget-object v2, Lcom/umeng/analytics/pro/o;->g:Landroid/content/Context;

    invoke-static {v2}, Lcom/umeng/analytics/pro/g;->a(Landroid/content/Context;)Lcom/umeng/analytics/pro/g;

    move-result-object v2

    sget-object v3, Lcom/umeng/analytics/pro/g$a;->c:Lcom/umeng/analytics/pro/g$a;

    invoke-virtual {v2, v0, v1, v3}, Lcom/umeng/analytics/pro/g;->a(Ljava/lang/String;Lorg/json/JSONObject;Lcom/umeng/analytics/pro/g$a;)Z

    .line 352
    sget-object v1, Lcom/umeng/analytics/pro/o;->g:Landroid/content/Context;

    invoke-virtual {p0, v1}, Lcom/umeng/analytics/pro/o;->a(Landroid/content/Context;)Z

    .line 354
    invoke-interface {p2}, Landroid/content/SharedPreferences;->edit()Landroid/content/SharedPreferences$Editor;

    move-result-object v1

    .line 356
    const-string v2, "session_id"

    invoke-interface {v1, v2, v0}, Landroid/content/SharedPreferences$Editor;->putString(Ljava/lang/String;Ljava/lang/String;)Landroid/content/SharedPreferences$Editor;

    .line 357
    const-string v2, "session_start_time"

    invoke-interface {v1, v2, p3, p4}, Landroid/content/SharedPreferences$Editor;->putLong(Ljava/lang/String;J)Landroid/content/SharedPreferences$Editor;

    .line 358
    const-string v2, "session_end_time"

    const-wide/16 v4, 0x0

    invoke-interface {v1, v2, v4, v5}, Landroid/content/SharedPreferences$Editor;->putLong(Ljava/lang/String;J)Landroid/content/SharedPreferences$Editor;

    .line 360
    const-string v2, "a_start_time"

    invoke-interface {v1, v2, p3, p4}, Landroid/content/SharedPreferences$Editor;->putLong(Ljava/lang/String;J)Landroid/content/SharedPreferences$Editor;

    .line 361
    const-string v2, "a_end_time"

    const-wide/16 v4, 0x0

    invoke-interface {v1, v2, v4, v5}, Landroid/content/SharedPreferences$Editor;->putLong(Ljava/lang/String;J)Landroid/content/SharedPreferences$Editor;

    .line 362
    const-string v2, "versioncode"

    invoke-static {p1}, Lcom/umeng/commonsdk/utils/UMUtils;->getAppVersionCode(Landroid/content/Context;)Ljava/lang/String;

    move-result-object v3

    invoke-static {v3}, Ljava/lang/Integer;->parseInt(Ljava/lang/String;)I

    move-result v3

    invoke-interface {v1, v2, v3}, Landroid/content/SharedPreferences$Editor;->putInt(Ljava/lang/String;I)Landroid/content/SharedPreferences$Editor;

    .line 363
    const-string v2, "versionname"

    invoke-static {p1}, Lcom/umeng/commonsdk/utils/UMUtils;->getAppVersionName(Landroid/content/Context;)Ljava/lang/String;

    move-result-object v3

    invoke-interface {v1, v2, v3}, Landroid/content/SharedPreferences$Editor;->putString(Ljava/lang/String;Ljava/lang/String;)Landroid/content/SharedPreferences$Editor;

    .line 364
    invoke-interface {v1}, Landroid/content/SharedPreferences$Editor;->commit()Z

    .line 367
    new-instance v1, Lorg/json/JSONObject;

    invoke-direct {v1}, Lorg/json/JSONObject;-><init>()V

    .line 369
    invoke-static {}, Lcom/umeng/analytics/b;->a()Lcom/umeng/analytics/b;

    move-result-object v2

    invoke-virtual {v2}, Lcom/umeng/analytics/b;->i()Lorg/json/JSONObject;

    move-result-object v2

    .line 370
    invoke-virtual {v2}, Lorg/json/JSONObject;->length()I

    move-result v3

    if-lez v3, :cond_1

    .line 371
    const-string v3, "_$!sp"

    invoke-virtual {v1, v3, v2}, Lorg/json/JSONObject;->put(Ljava/lang/String;Ljava/lang/Object;)Lorg/json/JSONObject;

    .line 373
    :cond_1
    const-string v2, "_$!s_b"

    invoke-virtual {v1, v2, v0}, Lorg/json/JSONObject;->put(Ljava/lang/String;Ljava/lang/Object;)Lorg/json/JSONObject;

    .line 374
    const-string v2, "__ii"

    invoke-virtual {v1, v2, v0}, Lorg/json/JSONObject;->put(Ljava/lang/String;Ljava/lang/Object;)Lorg/json/JSONObject;

    .line 375
    const-string v2, "_$!ts_b"

    invoke-virtual {v1, v2, p3, p4}, Lorg/json/JSONObject;->put(Ljava/lang/String;J)Lorg/json/JSONObject;

    .line 376
    sget-object v2, Lcom/umeng/analytics/pro/o;->g:Landroid/content/Context;

    invoke-static {v2}, Lcom/umeng/analytics/pro/i;->a(Landroid/content/Context;)Lcom/umeng/analytics/pro/i;

    move-result-object v2

    invoke-virtual {v2, v1}, Lcom/umeng/analytics/pro/i;->c(Ljava/lang/Object;)V
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_0

    .line 380
    :goto_0
    return-object v0

    .line 378
    :catch_0
    move-exception v1

    goto :goto_0
.end method

.method private a(Landroid/content/SharedPreferences;)V
    .locals 2

    .prologue
    .line 114
    invoke-interface {p1}, Landroid/content/SharedPreferences;->edit()Landroid/content/SharedPreferences$Editor;

    move-result-object v0

    .line 116
    const-string v1, "session_start_time"

    invoke-interface {v0, v1}, Landroid/content/SharedPreferences$Editor;->remove(Ljava/lang/String;)Landroid/content/SharedPreferences$Editor;

    .line 117
    const-string v1, "session_end_time"

    invoke-interface {v0, v1}, Landroid/content/SharedPreferences$Editor;->remove(Ljava/lang/String;)Landroid/content/SharedPreferences$Editor;

    .line 118
    const-string v1, "a_start_time"

    invoke-interface {v0, v1}, Landroid/content/SharedPreferences$Editor;->remove(Ljava/lang/String;)Landroid/content/SharedPreferences$Editor;

    .line 119
    const-string v1, "a_end_time"

    invoke-interface {v0, v1}, Landroid/content/SharedPreferences$Editor;->remove(Ljava/lang/String;)Landroid/content/SharedPreferences$Editor;

    .line 121
    invoke-interface {v0}, Landroid/content/SharedPreferences$Editor;->commit()Z

    .line 122
    return-void
.end method

.method private a(Landroid/content/SharedPreferences;J)Z
    .locals 10

    .prologue
    const/4 v0, 0x0

    const-wide/16 v8, 0x0

    .line 275
    const-string v1, "a_start_time"

    invoke-interface {p1, v1, v8, v9}, Landroid/content/SharedPreferences;->getLong(Ljava/lang/String;J)J

    move-result-wide v2

    .line 276
    const-string v1, "a_end_time"

    invoke-interface {p1, v1, v8, v9}, Landroid/content/SharedPreferences;->getLong(Ljava/lang/String;J)J

    move-result-wide v4

    .line 279
    cmp-long v1, v2, v8

    if-eqz v1, :cond_1

    sub-long v2, p2, v2

    sget-wide v6, Lcom/umeng/analytics/AnalyticsConfig;->kContinueSessionMillis:J

    cmp-long v1, v2, v6

    if-gez v1, :cond_1

    .line 280
    const-string v1, "onResume called before onPause"

    invoke-static {v1}, Lcom/umeng/commonsdk/statistics/common/MLog;->e(Ljava/lang/String;)V

    .line 325
    :cond_0
    :goto_0
    return v0

    .line 287
    :cond_1
    sub-long v2, p2, v4

    sget-wide v4, Lcom/umeng/analytics/AnalyticsConfig;->kContinueSessionMillis:J

    cmp-long v1, v2, v4

    if-lez v1, :cond_0

    .line 289
    :try_start_0
    const-string v0, "session_id"

    const-string v1, "-1"

    invoke-interface {p1, v0, v1}, Landroid/content/SharedPreferences;->getString(Ljava/lang/String;Ljava/lang/String;)Ljava/lang/String;

    move-result-object v2

    .line 290
    const-string v0, "session_end_time"

    const-wide/16 v4, 0x0

    invoke-interface {p1, v0, v4, v5}, Landroid/content/SharedPreferences;->getLong(Ljava/lang/String;J)J

    move-result-wide v0

    .line 292
    const-string v3, "-1"

    invoke-virtual {v3, v2}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v3

    if-nez v3, :cond_4

    .line 295
    cmp-long v3, v0, v8

    if-nez v3, :cond_2

    .line 296
    invoke-static {}, Ljava/lang/System;->currentTimeMillis()J

    move-result-wide v0

    .line 299
    :cond_2
    new-instance v3, Lorg/json/JSONObject;

    invoke-direct {v3}, Lorg/json/JSONObject;-><init>()V

    .line 300
    const-string v4, "__f"

    invoke-virtual {v3, v4, v0, v1}, Lorg/json/JSONObject;->put(Ljava/lang/String;J)Lorg/json/JSONObject;

    .line 301
    sget-object v4, Lcom/umeng/analytics/pro/o;->g:Landroid/content/Context;

    invoke-static {v4}, Lcom/umeng/analytics/pro/g;->a(Landroid/content/Context;)Lcom/umeng/analytics/pro/g;

    move-result-object v4

    sget-object v5, Lcom/umeng/analytics/pro/g$a;->d:Lcom/umeng/analytics/pro/g$a;

    invoke-virtual {v4, v2, v3, v5}, Lcom/umeng/analytics/pro/g;->a(Ljava/lang/String;Lorg/json/JSONObject;Lcom/umeng/analytics/pro/g$a;)Z

    .line 304
    sget-boolean v3, Lcom/umeng/analytics/AnalyticsConfig;->FLAG_DPLUS:Z

    if-eqz v3, :cond_4

    .line 305
    new-instance v3, Lorg/json/JSONObject;

    invoke-direct {v3}, Lorg/json/JSONObject;-><init>()V

    .line 307
    invoke-static {}, Lcom/umeng/analytics/b;->a()Lcom/umeng/analytics/b;

    move-result-object v4

    invoke-virtual {v4}, Lcom/umeng/analytics/b;->i()Lorg/json/JSONObject;

    move-result-object v4

    .line 308
    invoke-virtual {v4}, Lorg/json/JSONObject;->length()I

    move-result v5

    if-lez v5, :cond_3

    .line 309
    const-string v5, "_$!sp"

    invoke-virtual {v3, v5, v4}, Lorg/json/JSONObject;->put(Ljava/lang/String;Ljava/lang/Object;)Lorg/json/JSONObject;

    .line 311
    :cond_3
    const-string v4, "_$!s_e"

    invoke-virtual {v3, v4, v2}, Lorg/json/JSONObject;->put(Ljava/lang/String;Ljava/lang/Object;)Lorg/json/JSONObject;

    .line 312
    const-string v4, "__ii"

    invoke-virtual {v3, v4, v2}, Lorg/json/JSONObject;->put(Ljava/lang/String;Ljava/lang/Object;)Lorg/json/JSONObject;

    .line 313
    const-string v2, "_$!ts_e"

    invoke-virtual {v3, v2, v0, v1}, Lorg/json/JSONObject;->put(Ljava/lang/String;J)Lorg/json/JSONObject;

    .line 314
    sget-object v0, Lcom/umeng/analytics/pro/o;->g:Landroid/content/Context;

    invoke-static {v0}, Lcom/umeng/analytics/pro/i;->a(Landroid/content/Context;)Lcom/umeng/analytics/pro/i;

    move-result-object v0

    const/4 v1, 0x3

    const/4 v2, 0x0

    invoke-virtual {v0, v3, v1, v2}, Lcom/umeng/analytics/pro/i;->a(Ljava/lang/Object;IZ)V
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_0

    .line 323
    :cond_4
    :goto_1
    const/4 v0, 0x1

    goto :goto_0

    .line 321
    :catch_0
    move-exception v0

    goto :goto_1
.end method

.method private d(Landroid/content/Context;)V
    .locals 1

    .prologue
    .line 390
    invoke-static {p1}, Lcom/umeng/analytics/pro/i;->a(Landroid/content/Context;)Lcom/umeng/analytics/pro/i;

    move-result-object v0

    invoke-virtual {v0, p1}, Lcom/umeng/analytics/pro/i;->b(Landroid/content/Context;)V

    .line 392
    invoke-static {p1}, Lcom/umeng/analytics/pro/i;->a(Landroid/content/Context;)Lcom/umeng/analytics/pro/i;

    move-result-object v0

    invoke-virtual {v0}, Lcom/umeng/analytics/pro/i;->a()V

    .line 393
    return-void
.end method


# virtual methods
.method public a(Landroid/content/Context;Ljava/lang/Object;)V
    .locals 10

    .prologue
    .line 142
    :try_start_0
    sget-object v0, Lcom/umeng/analytics/pro/o;->g:Landroid/content/Context;

    if-nez v0, :cond_0

    .line 143
    if-eqz p1, :cond_0

    .line 144
    invoke-virtual {p1}, Landroid/content/Context;->getApplicationContext()Landroid/content/Context;

    move-result-object v0

    sput-object v0, Lcom/umeng/analytics/pro/o;->g:Landroid/content/Context;

    .line 147
    :cond_0
    check-cast p2, Ljava/lang/Long;

    invoke-virtual {p2}, Ljava/lang/Long;->longValue()J

    move-result-wide v0

    .line 148
    sget-object v2, Lcom/umeng/analytics/pro/o;->g:Landroid/content/Context;

    invoke-static {v2}, Lcom/umeng/commonsdk/statistics/internal/PreferenceWrapper;->getDefault(Landroid/content/Context;)Landroid/content/SharedPreferences;

    move-result-object v2

    .line 149
    if-nez v2, :cond_1

    .line 218
    :goto_0
    return-void

    .line 152
    :cond_1
    invoke-interface {v2}, Landroid/content/SharedPreferences;->edit()Landroid/content/SharedPreferences$Editor;

    move-result-object v3

    .line 155
    const-string v4, "versionname"

    const-string v5, ""

    invoke-interface {v2, v4, v5}, Landroid/content/SharedPreferences;->getString(Ljava/lang/String;Ljava/lang/String;)Ljava/lang/String;

    move-result-object v4

    .line 156
    sget-object v5, Lcom/umeng/analytics/pro/o;->g:Landroid/content/Context;

    invoke-static {v5}, Lcom/umeng/commonsdk/utils/UMUtils;->getAppVersionName(Landroid/content/Context;)Ljava/lang/String;

    move-result-object v5

    .line 157
    invoke-static {v4}, Landroid/text/TextUtils;->isEmpty(Ljava/lang/CharSequence;)Z

    move-result v6

    if-nez v6, :cond_3

    invoke-virtual {v4, v5}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v5

    if-nez v5, :cond_3

    .line 158
    const-string v5, "versioncode"

    const/4 v6, 0x0

    invoke-interface {v2, v5, v6}, Landroid/content/SharedPreferences;->getInt(Ljava/lang/String;I)I

    move-result v5

    .line 160
    const-string v6, "pre_date"

    const-string v7, ""

    invoke-interface {v2, v6, v7}, Landroid/content/SharedPreferences;->getString(Ljava/lang/String;Ljava/lang/String;)Ljava/lang/String;

    move-result-object v6

    .line 161
    const-string v7, "pre_version"

    const-string v8, ""

    invoke-interface {v2, v7, v8}, Landroid/content/SharedPreferences;->getString(Ljava/lang/String;Ljava/lang/String;)Ljava/lang/String;

    move-result-object v7

    .line 162
    const-string v8, "versionname"

    const-string v9, ""

    invoke-interface {v2, v8, v9}, Landroid/content/SharedPreferences;->getString(Ljava/lang/String;Ljava/lang/String;)Ljava/lang/String;

    move-result-object v8

    .line 164
    const-string v9, "vers_date"

    invoke-interface {v3, v9, v6}, Landroid/content/SharedPreferences$Editor;->putString(Ljava/lang/String;Ljava/lang/String;)Landroid/content/SharedPreferences$Editor;

    .line 165
    const-string v9, "vers_pre_version"

    invoke-interface {v3, v9, v7}, Landroid/content/SharedPreferences$Editor;->putString(Ljava/lang/String;Ljava/lang/String;)Landroid/content/SharedPreferences$Editor;

    .line 166
    const-string v9, "cur_version"

    invoke-interface {v3, v9, v8}, Landroid/content/SharedPreferences$Editor;->putString(Ljava/lang/String;Ljava/lang/String;)Landroid/content/SharedPreferences$Editor;

    .line 168
    const-string v9, "dp_vers_date"

    invoke-interface {v3, v9, v6}, Landroid/content/SharedPreferences$Editor;->putString(Ljava/lang/String;Ljava/lang/String;)Landroid/content/SharedPreferences$Editor;

    .line 169
    const-string v6, "dp_vers_pre_version"

    invoke-interface {v3, v6, v7}, Landroid/content/SharedPreferences$Editor;->putString(Ljava/lang/String;Ljava/lang/String;)Landroid/content/SharedPreferences$Editor;

    .line 170
    const-string v6, "dp_cur_version"

    invoke-interface {v3, v6, v8}, Landroid/content/SharedPreferences$Editor;->putString(Ljava/lang/String;Ljava/lang/String;)Landroid/content/SharedPreferences$Editor;

    .line 182
    const-string v6, "vers_code"

    invoke-interface {v3, v6, v5}, Landroid/content/SharedPreferences$Editor;->putInt(Ljava/lang/String;I)Landroid/content/SharedPreferences$Editor;

    .line 183
    const-string v6, "vers_name"

    invoke-interface {v3, v6, v4}, Landroid/content/SharedPreferences$Editor;->putString(Ljava/lang/String;Ljava/lang/String;)Landroid/content/SharedPreferences$Editor;

    .line 185
    const-string v6, "dp_vers_code"

    invoke-interface {v3, v6, v5}, Landroid/content/SharedPreferences$Editor;->putInt(Ljava/lang/String;I)Landroid/content/SharedPreferences$Editor;

    .line 186
    const-string v5, "dp_vers_name"

    invoke-interface {v3, v5, v4}, Landroid/content/SharedPreferences$Editor;->putString(Ljava/lang/String;Ljava/lang/String;)Landroid/content/SharedPreferences$Editor;

    .line 188
    const-string v4, "a_end_time"

    const-wide/16 v6, 0x0

    invoke-interface {v3, v4, v6, v7}, Landroid/content/SharedPreferences$Editor;->putLong(Ljava/lang/String;J)Landroid/content/SharedPreferences$Editor;

    .line 189
    invoke-interface {v3}, Landroid/content/SharedPreferences$Editor;->commit()Z

    .line 190
    invoke-virtual {p0, p1}, Lcom/umeng/analytics/pro/o;->c(Landroid/content/Context;)Ljava/lang/String;

    move-result-object v3

    if-nez v3, :cond_2

    .line 191
    invoke-direct {p0, p1, v2, v0, v1}, Lcom/umeng/analytics/pro/o;->a(Landroid/content/Context;Landroid/content/SharedPreferences;J)Ljava/lang/String;

    move-result-object v2

    sput-object v2, Lcom/umeng/analytics/pro/o;->f:Ljava/lang/String;

    .line 194
    :cond_2
    sget-object v2, Lcom/umeng/analytics/pro/o;->g:Landroid/content/Context;

    invoke-virtual {p0, v2, v0, v1}, Lcom/umeng/analytics/pro/o;->a(Landroid/content/Context;J)Z

    .line 195
    sget-object v2, Lcom/umeng/analytics/pro/o;->g:Landroid/content/Context;

    invoke-virtual {p0, v2, v0, v1}, Lcom/umeng/analytics/pro/o;->b(Landroid/content/Context;J)V

    goto/16 :goto_0

    .line 214
    :catch_0
    move-exception v0

    goto/16 :goto_0

    .line 199
    :cond_3
    invoke-direct {p0, v2, v0, v1}, Lcom/umeng/analytics/pro/o;->a(Landroid/content/SharedPreferences;J)Z

    move-result v4

    if-eqz v4, :cond_4

    .line 200
    invoke-direct {p0, p1, v2, v0, v1}, Lcom/umeng/analytics/pro/o;->a(Landroid/content/Context;Landroid/content/SharedPreferences;J)Ljava/lang/String;

    move-result-object v0

    sput-object v0, Lcom/umeng/analytics/pro/o;->f:Ljava/lang/String;

    .line 201
    new-instance v0, Ljava/lang/StringBuilder;

    invoke-direct {v0}, Ljava/lang/StringBuilder;-><init>()V

    const-string v1, "Start new session: "

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    sget-object v1, Lcom/umeng/analytics/pro/o;->f:Ljava/lang/String;

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-virtual {v0}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v0

    invoke-static {v0}, Lcom/umeng/commonsdk/statistics/common/MLog;->i(Ljava/lang/String;)V

    goto/16 :goto_0

    .line 203
    :cond_4
    const-string v4, "session_id"

    const/4 v5, 0x0

    invoke-interface {v2, v4, v5}, Landroid/content/SharedPreferences;->getString(Ljava/lang/String;Ljava/lang/String;)Ljava/lang/String;

    move-result-object v2

    sput-object v2, Lcom/umeng/analytics/pro/o;->f:Ljava/lang/String;

    .line 204
    const-string v2, "a_start_time"

    invoke-interface {v3, v2, v0, v1}, Landroid/content/SharedPreferences$Editor;->putLong(Ljava/lang/String;J)Landroid/content/SharedPreferences$Editor;

    .line 205
    const-string v0, "a_end_time"

    const-wide/16 v4, 0x0

    invoke-interface {v3, v0, v4, v5}, Landroid/content/SharedPreferences$Editor;->putLong(Ljava/lang/String;J)Landroid/content/SharedPreferences$Editor;

    .line 206
    invoke-interface {v3}, Landroid/content/SharedPreferences$Editor;->commit()Z

    .line 207
    new-instance v0, Ljava/lang/StringBuilder;

    invoke-direct {v0}, Ljava/lang/StringBuilder;-><init>()V

    const-string v1, "Extend current session: "

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    sget-object v1, Lcom/umeng/analytics/pro/o;->f:Ljava/lang/String;

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-virtual {v0}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v0

    invoke-static {v0}, Lcom/umeng/commonsdk/statistics/common/MLog;->i(Ljava/lang/String;)V

    .line 209
    invoke-direct {p0, p1}, Lcom/umeng/analytics/pro/o;->d(Landroid/content/Context;)V

    .line 211
    sget-object v0, Lcom/umeng/analytics/pro/o;->g:Landroid/content/Context;

    invoke-static {v0}, Lcom/umeng/analytics/pro/i;->a(Landroid/content/Context;)Lcom/umeng/analytics/pro/i;

    move-result-object v0

    const/4 v1, 0x0

    invoke-virtual {v0, v1}, Lcom/umeng/analytics/pro/i;->a(Z)V

    .line 212
    sget-object v0, Lcom/umeng/analytics/pro/o;->g:Landroid/content/Context;

    invoke-static {v0}, Lcom/umeng/analytics/pro/i;->a(Landroid/content/Context;)Lcom/umeng/analytics/pro/i;

    move-result-object v0

    invoke-virtual {v0}, Lcom/umeng/analytics/pro/i;->d()V
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_0

    goto/16 :goto_0
.end method

.method public a(Landroid/content/Context;)Z
    .locals 12

    .prologue
    .line 52
    invoke-static {p1}, Lcom/umeng/commonsdk/statistics/internal/PreferenceWrapper;->getDefault(Landroid/content/Context;)Landroid/content/SharedPreferences;

    move-result-object v1

    .line 53
    const-string v0, "session_id"

    const/4 v2, 0x0

    invoke-interface {v1, v0, v2}, Landroid/content/SharedPreferences;->getString(Ljava/lang/String;Ljava/lang/String;)Ljava/lang/String;

    move-result-object v2

    .line 54
    if-nez v2, :cond_0

    .line 55
    const/4 v0, 0x0

    .line 110
    :goto_0
    return v0

    .line 58
    :cond_0
    const-string v0, "session_start_time"

    const-wide/16 v4, 0x0

    invoke-interface {v1, v0, v4, v5}, Landroid/content/SharedPreferences;->getLong(Ljava/lang/String;J)J

    move-result-wide v4

    .line 59
    const-string v0, "session_end_time"

    const-wide/16 v6, 0x0

    invoke-interface {v1, v0, v6, v7}, Landroid/content/SharedPreferences;->getLong(Ljava/lang/String;J)J

    move-result-wide v6

    .line 62
    const-wide/16 v8, 0x0

    cmp-long v0, v6, v8

    if-eqz v0, :cond_1

    .line 63
    sub-long v8, v6, v4

    .line 64
    invoke-static {v8, v9}, Ljava/lang/Math;->abs(J)J

    move-result-wide v8

    const-wide/32 v10, 0x5265c00

    cmp-long v0, v8, v10

    if-lez v0, :cond_1

    .line 70
    :cond_1
    :try_start_0
    new-instance v3, Lorg/json/JSONObject;

    invoke-direct {v3}, Lorg/json/JSONObject;-><init>()V

    .line 71
    const-string v0, "__ii"

    invoke-virtual {v3, v0, v2}, Lorg/json/JSONObject;->put(Ljava/lang/String;Ljava/lang/Object;)Lorg/json/JSONObject;

    .line 72
    const-string v0, "__e"

    invoke-virtual {v3, v0, v4, v5}, Lorg/json/JSONObject;->put(Ljava/lang/String;J)Lorg/json/JSONObject;

    .line 73
    const-string v0, "__f"

    invoke-virtual {v3, v0, v6, v7}, Lorg/json/JSONObject;->put(Ljava/lang/String;J)Lorg/json/JSONObject;

    .line 75
    invoke-static {}, Lcom/umeng/analytics/AnalyticsConfig;->getLocation()[D

    move-result-object v0

    .line 76
    if-eqz v0, :cond_2

    .line 77
    new-instance v4, Lorg/json/JSONObject;

    invoke-direct {v4}, Lorg/json/JSONObject;-><init>()V

    .line 78
    const-string v5, "lat"

    const/4 v6, 0x0

    aget-wide v6, v0, v6

    invoke-virtual {v4, v5, v6, v7}, Lorg/json/JSONObject;->put(Ljava/lang/String;D)Lorg/json/JSONObject;

    .line 79
    const-string v5, "lng"

    const/4 v6, 0x1

    aget-wide v6, v0, v6

    invoke-virtual {v4, v5, v6, v7}, Lorg/json/JSONObject;->put(Ljava/lang/String;D)Lorg/json/JSONObject;

    .line 80
    const-string v0, "ts"

    invoke-static {}, Ljava/lang/System;->currentTimeMillis()J

    move-result-wide v6

    invoke-virtual {v4, v0, v6, v7}, Lorg/json/JSONObject;->put(Ljava/lang/String;J)Lorg/json/JSONObject;

    .line 81
    const-string v0, "__d"

    invoke-virtual {v3, v0, v4}, Lorg/json/JSONObject;->put(Ljava/lang/String;Ljava/lang/Object;)Lorg/json/JSONObject;

    .line 84
    :cond_2
    const-string v0, "android.net.TrafficStats"

    invoke-static {v0}, Ljava/lang/Class;->forName(Ljava/lang/String;)Ljava/lang/Class;

    move-result-object v0

    .line 85
    const-string v4, "getUidRxBytes"

    const/4 v5, 0x1

    new-array v5, v5, [Ljava/lang/Class;

    const/4 v6, 0x0

    sget-object v7, Ljava/lang/Integer;->TYPE:Ljava/lang/Class;

    aput-object v7, v5, v6

    invoke-virtual {v0, v4, v5}, Ljava/lang/Class;->getMethod(Ljava/lang/String;[Ljava/lang/Class;)Ljava/lang/reflect/Method;

    move-result-object v4

    .line 86
    const-string v5, "getUidTxBytes"

    const/4 v6, 0x1

    new-array v6, v6, [Ljava/lang/Class;

    const/4 v7, 0x0

    sget-object v8, Ljava/lang/Integer;->TYPE:Ljava/lang/Class;

    aput-object v8, v6, v7

    invoke-virtual {v0, v5, v6}, Ljava/lang/Class;->getMethod(Ljava/lang/String;[Ljava/lang/Class;)Ljava/lang/reflect/Method;

    move-result-object v5

    .line 87
    invoke-virtual {p1}, Landroid/content/Context;->getApplicationInfo()Landroid/content/pm/ApplicationInfo;

    move-result-object v0

    iget v6, v0, Landroid/content/pm/ApplicationInfo;->uid:I

    .line 88
    const/4 v0, -0x1

    if-ne v6, v0, :cond_3

    .line 89
    const/4 v0, 0x0

    goto/16 :goto_0

    .line 91
    :cond_3
    const/4 v0, 0x0

    const/4 v7, 0x1

    new-array v7, v7, [Ljava/lang/Object;

    const/4 v8, 0x0

    invoke-static {v6}, Ljava/lang/Integer;->valueOf(I)Ljava/lang/Integer;

    move-result-object v9

    aput-object v9, v7, v8

    invoke-virtual {v4, v0, v7}, Ljava/lang/reflect/Method;->invoke(Ljava/lang/Object;[Ljava/lang/Object;)Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Ljava/lang/Long;

    invoke-virtual {v0}, Ljava/lang/Long;->longValue()J

    move-result-wide v8

    .line 92
    const/4 v0, 0x0

    const/4 v4, 0x1

    new-array v4, v4, [Ljava/lang/Object;

    const/4 v7, 0x0

    invoke-static {v6}, Ljava/lang/Integer;->valueOf(I)Ljava/lang/Integer;

    move-result-object v6

    aput-object v6, v4, v7

    invoke-virtual {v5, v0, v4}, Ljava/lang/reflect/Method;->invoke(Ljava/lang/Object;[Ljava/lang/Object;)Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Ljava/lang/Long;

    invoke-virtual {v0}, Ljava/lang/Long;->longValue()J

    move-result-wide v4

    .line 93
    const-wide/16 v6, 0x0

    cmp-long v0, v8, v6

    if-lez v0, :cond_4

    const-wide/16 v6, 0x0

    cmp-long v0, v4, v6

    if-gtz v0, :cond_5

    .line 102
    :cond_4
    :goto_1
    invoke-static {p1}, Lcom/umeng/analytics/pro/g;->a(Landroid/content/Context;)Lcom/umeng/analytics/pro/g;

    move-result-object v0

    sget-object v4, Lcom/umeng/analytics/pro/g$a;->e:Lcom/umeng/analytics/pro/g$a;

    invoke-virtual {v0, v2, v3, v4}, Lcom/umeng/analytics/pro/g;->a(Ljava/lang/String;Lorg/json/JSONObject;Lcom/umeng/analytics/pro/g$a;)Z

    .line 103
    sget-object v0, Lcom/umeng/analytics/pro/o;->g:Landroid/content/Context;

    invoke-static {v0}, Lcom/umeng/analytics/pro/p;->a(Landroid/content/Context;)V

    .line 104
    sget-object v0, Lcom/umeng/analytics/pro/o;->g:Landroid/content/Context;

    invoke-static {v0}, Lcom/umeng/analytics/pro/h;->b(Landroid/content/Context;)V

    .line 105
    invoke-direct {p0, v1}, Lcom/umeng/analytics/pro/o;->a(Landroid/content/SharedPreferences;)V

    .line 110
    const/4 v0, 0x1

    goto/16 :goto_0

    .line 96
    :cond_5
    new-instance v0, Lorg/json/JSONObject;

    invoke-direct {v0}, Lorg/json/JSONObject;-><init>()V

    .line 97
    const-string v6, "download_traffic"

    invoke-virtual {v0, v6, v8, v9}, Lorg/json/JSONObject;->put(Ljava/lang/String;J)Lorg/json/JSONObject;

    .line 98
    const-string v6, "upload_traffic"

    invoke-virtual {v0, v6, v4, v5}, Lorg/json/JSONObject;->put(Ljava/lang/String;J)Lorg/json/JSONObject;

    .line 99
    const-string v4, "__c"

    invoke-virtual {v3, v4, v0}, Lorg/json/JSONObject;->put(Ljava/lang/String;Ljava/lang/Object;)Lorg/json/JSONObject;
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_0

    goto :goto_1

    .line 106
    :catch_0
    move-exception v0

    .line 107
    const/4 v0, 0x0

    goto/16 :goto_0
.end method

.method public a(Landroid/content/Context;J)Z
    .locals 12

    .prologue
    const/4 v1, 0x1

    const-wide/16 v10, 0x0

    .line 403
    const/4 v0, 0x0

    .line 406
    :try_start_0
    invoke-static {p1}, Lcom/umeng/commonsdk/statistics/internal/PreferenceWrapper;->getDefault(Landroid/content/Context;)Landroid/content/SharedPreferences;

    move-result-object v2

    .line 407
    if-nez v2, :cond_1

    .line 461
    :cond_0
    :goto_0
    return v0

    .line 411
    :cond_1
    const-string v3, "session_id"

    const/4 v4, 0x0

    invoke-interface {v2, v3, v4}, Landroid/content/SharedPreferences;->getString(Ljava/lang/String;Ljava/lang/String;)Ljava/lang/String;

    move-result-object v3

    .line 413
    if-eqz v3, :cond_0

    .line 417
    const-string v4, "a_start_time"

    const-wide/16 v6, 0x0

    invoke-interface {v2, v4, v6, v7}, Landroid/content/SharedPreferences;->getLong(Ljava/lang/String;J)J

    move-result-wide v4

    .line 418
    const-string v6, "a_end_time"

    const-wide/16 v8, 0x0

    invoke-interface {v2, v6, v8, v9}, Landroid/content/SharedPreferences;->getLong(Ljava/lang/String;J)J
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_0

    move-result-wide v6

    .line 421
    cmp-long v2, v4, v10

    if-lez v2, :cond_6

    cmp-long v2, v6, v10

    if-nez v2, :cond_6

    .line 423
    :try_start_1
    sget-object v0, Lcom/umeng/analytics/pro/o;->g:Landroid/content/Context;

    invoke-static {p2, p3}, Ljava/lang/Long;->valueOf(J)Ljava/lang/Long;

    move-result-object v2

    invoke-virtual {p0, v0, v2}, Lcom/umeng/analytics/pro/o;->b(Landroid/content/Context;Ljava/lang/Object;)V
    :try_end_1
    .catch Ljava/lang/Throwable; {:try_start_1 .. :try_end_1} :catch_2

    .line 427
    :try_start_2
    new-instance v0, Lorg/json/JSONObject;

    invoke-direct {v0}, Lorg/json/JSONObject;-><init>()V

    .line 428
    const-string v2, "__f"

    invoke-virtual {v0, v2, p2, p3}, Lorg/json/JSONObject;->put(Ljava/lang/String;J)Lorg/json/JSONObject;

    .line 429
    invoke-static {p1}, Lcom/umeng/analytics/pro/g;->a(Landroid/content/Context;)Lcom/umeng/analytics/pro/g;

    move-result-object v2

    sget-object v4, Lcom/umeng/analytics/pro/g$a;->d:Lcom/umeng/analytics/pro/g$a;

    invoke-virtual {v2, v3, v0, v4}, Lcom/umeng/analytics/pro/g;->a(Ljava/lang/String;Lorg/json/JSONObject;Lcom/umeng/analytics/pro/g$a;)Z

    .line 432
    sget-object v0, Lcom/umeng/analytics/pro/o;->g:Landroid/content/Context;

    invoke-static {v0}, Lcom/umeng/analytics/pro/i;->a(Landroid/content/Context;)Lcom/umeng/analytics/pro/i;

    move-result-object v0

    invoke-virtual {v0}, Lcom/umeng/analytics/pro/i;->b()V

    .line 435
    sget-boolean v0, Lcom/umeng/analytics/AnalyticsConfig;->FLAG_DPLUS:Z

    if-eqz v0, :cond_5

    .line 439
    new-instance v2, Lorg/json/JSONObject;

    invoke-direct {v2}, Lorg/json/JSONObject;-><init>()V

    .line 441
    invoke-static {}, Lcom/umeng/analytics/b;->a()Lcom/umeng/analytics/b;

    move-result-object v0

    invoke-virtual {v0}, Lcom/umeng/analytics/b;->c()Lorg/json/JSONObject;

    move-result-object v0

    .line 442
    if-eqz v0, :cond_2

    invoke-virtual {v0}, Lorg/json/JSONObject;->length()I

    move-result v4

    if-ge v4, v1, :cond_3

    .line 443
    :cond_2
    invoke-static {}, Lcom/umeng/analytics/b;->a()Lcom/umeng/analytics/b;

    move-result-object v0

    invoke-virtual {v0}, Lcom/umeng/analytics/b;->i()Lorg/json/JSONObject;

    move-result-object v0

    .line 445
    :cond_3
    invoke-virtual {v0}, Lorg/json/JSONObject;->length()I

    move-result v4

    if-lez v4, :cond_4

    .line 446
    const-string v4, "_$!sp"

    invoke-virtual {v2, v4, v0}, Lorg/json/JSONObject;->put(Ljava/lang/String;Ljava/lang/Object;)Lorg/json/JSONObject;

    .line 448
    :cond_4
    const-string v0, "_$!s_e"

    invoke-virtual {v2, v0, v3}, Lorg/json/JSONObject;->put(Ljava/lang/String;Ljava/lang/Object;)Lorg/json/JSONObject;

    .line 449
    const-string v0, "__ii"

    invoke-virtual {v2, v0, v3}, Lorg/json/JSONObject;->put(Ljava/lang/String;Ljava/lang/Object;)Lorg/json/JSONObject;

    .line 450
    const-string v0, "_$!ts_e"

    invoke-virtual {v2, v0, p2, p3}, Lorg/json/JSONObject;->put(Ljava/lang/String;J)Lorg/json/JSONObject;

    .line 451
    sget-object v0, Lcom/umeng/analytics/pro/o;->g:Landroid/content/Context;

    invoke-static {v0}, Lcom/umeng/analytics/pro/i;->a(Landroid/content/Context;)Lcom/umeng/analytics/pro/i;

    move-result-object v0

    const/4 v3, 0x3

    const/4 v4, 0x1

    invoke-virtual {v0, v2, v3, v4}, Lcom/umeng/analytics/pro/i;->a(Ljava/lang/Object;IZ)V
    :try_end_2
    .catch Ljava/lang/Throwable; {:try_start_2 .. :try_end_2} :catch_1

    :cond_5
    move v0, v1

    .line 459
    :cond_6
    :goto_1
    :try_start_3
    invoke-virtual {p0, p1}, Lcom/umeng/analytics/pro/o;->a(Landroid/content/Context;)Z
    :try_end_3
    .catch Ljava/lang/Throwable; {:try_start_3 .. :try_end_3} :catch_0

    goto/16 :goto_0

    .line 460
    :catch_0
    move-exception v1

    goto/16 :goto_0

    .line 454
    :catch_1
    move-exception v0

    move v0, v1

    goto :goto_1

    .line 460
    :catch_2
    move-exception v0

    move v0, v1

    goto/16 :goto_0
.end method

.method public b(Landroid/content/Context;)Ljava/lang/String;
    .locals 5

    .prologue
    .line 126
    invoke-static {p1}, Lcom/umeng/commonsdk/statistics/common/DeviceConfig;->getDeviceId(Landroid/content/Context;)Ljava/lang/String;

    move-result-object v0

    .line 127
    invoke-static {p1}, Lcom/umeng/commonsdk/utils/UMUtils;->getAppkey(Landroid/content/Context;)Ljava/lang/String;

    move-result-object v1

    .line 128
    invoke-static {}, Ljava/lang/System;->currentTimeMillis()J

    move-result-wide v2

    .line 130
    if-nez v1, :cond_0

    .line 131
    new-instance v0, Ljava/lang/RuntimeException;

    const-string v1, "Appkey is null or empty, Please check!"

    invoke-direct {v0, v1}, Ljava/lang/RuntimeException;-><init>(Ljava/lang/String;)V

    throw v0

    .line 134
    :cond_0
    new-instance v4, Ljava/lang/StringBuilder;

    invoke-direct {v4}, Ljava/lang/StringBuilder;-><init>()V

    .line 135
    invoke-virtual {v4, v2, v3}, Ljava/lang/StringBuilder;->append(J)Ljava/lang/StringBuilder;

    move-result-object v2

    invoke-virtual {v2, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1, v0}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    .line 136
    invoke-virtual {v4}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v0

    invoke-static {v0}, Lcom/umeng/commonsdk/utils/UMUtils;->MD5(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v0

    sput-object v0, Lcom/umeng/analytics/pro/o;->f:Ljava/lang/String;

    .line 137
    sget-object v0, Lcom/umeng/analytics/pro/o;->f:Ljava/lang/String;

    return-object v0
.end method

.method public b(Landroid/content/Context;J)V
    .locals 4

    .prologue
    .line 470
    invoke-static {p1}, Lcom/umeng/commonsdk/statistics/internal/PreferenceWrapper;->getDefault(Landroid/content/Context;)Landroid/content/SharedPreferences;

    move-result-object v0

    .line 471
    if-nez v0, :cond_0

    .line 505
    :goto_0
    return-void

    .line 474
    :cond_0
    invoke-virtual {p0, p1}, Lcom/umeng/analytics/pro/o;->b(Landroid/content/Context;)Ljava/lang/String;

    move-result-object v1

    sput-object v1, Lcom/umeng/analytics/pro/o;->f:Ljava/lang/String;

    .line 477
    :try_start_0
    invoke-interface {v0}, Landroid/content/SharedPreferences;->edit()Landroid/content/SharedPreferences$Editor;

    move-result-object v0

    .line 478
    const-string v1, "session_id"

    sget-object v2, Lcom/umeng/analytics/pro/o;->f:Ljava/lang/String;

    invoke-interface {v0, v1, v2}, Landroid/content/SharedPreferences$Editor;->putString(Ljava/lang/String;Ljava/lang/String;)Landroid/content/SharedPreferences$Editor;

    .line 479
    const-string v1, "session_start_time"

    invoke-interface {v0, v1, p2, p3}, Landroid/content/SharedPreferences$Editor;->putLong(Ljava/lang/String;J)Landroid/content/SharedPreferences$Editor;

    .line 480
    const-string v1, "session_end_time"

    const-wide/16 v2, 0x0

    invoke-interface {v0, v1, v2, v3}, Landroid/content/SharedPreferences$Editor;->putLong(Ljava/lang/String;J)Landroid/content/SharedPreferences$Editor;

    .line 481
    const-string v1, "a_start_time"

    invoke-interface {v0, v1, p2, p3}, Landroid/content/SharedPreferences$Editor;->putLong(Ljava/lang/String;J)Landroid/content/SharedPreferences$Editor;

    .line 482
    const-string v1, "a_end_time"

    const-wide/16 v2, 0x0

    invoke-interface {v0, v1, v2, v3}, Landroid/content/SharedPreferences$Editor;->putLong(Ljava/lang/String;J)Landroid/content/SharedPreferences$Editor;

    .line 483
    const-string v1, "versioncode"

    sget-object v2, Lcom/umeng/analytics/pro/o;->g:Landroid/content/Context;

    .line 484
    invoke-static {v2}, Lcom/umeng/commonsdk/utils/UMUtils;->getAppVersionCode(Landroid/content/Context;)Ljava/lang/String;

    move-result-object v2

    invoke-static {v2}, Ljava/lang/Integer;->parseInt(Ljava/lang/String;)I

    move-result v2

    .line 483
    invoke-interface {v0, v1, v2}, Landroid/content/SharedPreferences$Editor;->putInt(Ljava/lang/String;I)Landroid/content/SharedPreferences$Editor;

    .line 485
    const-string v1, "versionname"

    sget-object v2, Lcom/umeng/analytics/pro/o;->g:Landroid/content/Context;

    invoke-static {v2}, Lcom/umeng/commonsdk/utils/UMUtils;->getAppVersionName(Landroid/content/Context;)Ljava/lang/String;

    move-result-object v2

    invoke-interface {v0, v1, v2}, Landroid/content/SharedPreferences$Editor;->putString(Ljava/lang/String;Ljava/lang/String;)Landroid/content/SharedPreferences$Editor;

    .line 486
    invoke-interface {v0}, Landroid/content/SharedPreferences$Editor;->commit()Z

    .line 488
    new-instance v0, Lorg/json/JSONObject;

    invoke-direct {v0}, Lorg/json/JSONObject;-><init>()V

    .line 489
    const-string v1, "__e"

    invoke-virtual {v0, v1, p2, p3}, Lorg/json/JSONObject;->put(Ljava/lang/String;J)Lorg/json/JSONObject;

    .line 490
    sget-object v1, Lcom/umeng/analytics/pro/o;->g:Landroid/content/Context;

    invoke-static {v1}, Lcom/umeng/analytics/pro/g;->a(Landroid/content/Context;)Lcom/umeng/analytics/pro/g;

    move-result-object v1

    sget-object v2, Lcom/umeng/analytics/pro/o;->f:Ljava/lang/String;

    sget-object v3, Lcom/umeng/analytics/pro/g$a;->c:Lcom/umeng/analytics/pro/g$a;

    invoke-virtual {v1, v2, v0, v3}, Lcom/umeng/analytics/pro/g;->a(Ljava/lang/String;Lorg/json/JSONObject;Lcom/umeng/analytics/pro/g$a;)Z

    .line 492
    new-instance v0, Lorg/json/JSONObject;

    invoke-direct {v0}, Lorg/json/JSONObject;-><init>()V

    .line 494
    invoke-static {}, Lcom/umeng/analytics/b;->a()Lcom/umeng/analytics/b;

    move-result-object v1

    invoke-virtual {v1}, Lcom/umeng/analytics/b;->i()Lorg/json/JSONObject;

    move-result-object v1

    .line 495
    invoke-virtual {v1}, Lorg/json/JSONObject;->length()I

    move-result v2

    if-lez v2, :cond_1

    .line 496
    const-string v2, "_$!sp"

    invoke-virtual {v0, v2, v1}, Lorg/json/JSONObject;->put(Ljava/lang/String;Ljava/lang/Object;)Lorg/json/JSONObject;

    .line 498
    :cond_1
    const-string v1, "_$!s_b"

    sget-object v2, Lcom/umeng/analytics/pro/o;->f:Ljava/lang/String;

    invoke-virtual {v0, v1, v2}, Lorg/json/JSONObject;->put(Ljava/lang/String;Ljava/lang/Object;)Lorg/json/JSONObject;

    .line 499
    const-string v1, "__ii"

    sget-object v2, Lcom/umeng/analytics/pro/o;->f:Ljava/lang/String;

    invoke-virtual {v0, v1, v2}, Lorg/json/JSONObject;->put(Ljava/lang/String;Ljava/lang/Object;)Lorg/json/JSONObject;

    .line 500
    const-string v1, "_$!ts_b"

    invoke-virtual {v0, v1, p2, p3}, Lorg/json/JSONObject;->put(Ljava/lang/String;J)Lorg/json/JSONObject;

    .line 501
    sget-object v1, Lcom/umeng/analytics/pro/o;->g:Landroid/content/Context;

    invoke-static {v1}, Lcom/umeng/analytics/pro/i;->a(Landroid/content/Context;)Lcom/umeng/analytics/pro/i;

    move-result-object v1

    invoke-virtual {v1, v0}, Lcom/umeng/analytics/pro/i;->b(Ljava/lang/Object;)V
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_0

    goto/16 :goto_0

    .line 502
    :catch_0
    move-exception v0

    goto/16 :goto_0
.end method

.method public b(Landroid/content/Context;Ljava/lang/Object;)V
    .locals 8

    .prologue
    const-wide/16 v6, 0x0

    .line 222
    :try_start_0
    sget-object v0, Lcom/umeng/analytics/pro/o;->g:Landroid/content/Context;

    if-nez v0, :cond_0

    .line 223
    if-eqz p1, :cond_0

    .line 224
    invoke-virtual {p1}, Landroid/content/Context;->getApplicationContext()Landroid/content/Context;

    move-result-object v0

    sput-object v0, Lcom/umeng/analytics/pro/o;->g:Landroid/content/Context;

    .line 227
    :cond_0
    check-cast p2, Ljava/lang/Long;

    invoke-virtual {p2}, Ljava/lang/Long;->longValue()J

    move-result-wide v0

    .line 228
    invoke-static {p1}, Lcom/umeng/commonsdk/statistics/internal/PreferenceWrapper;->getDefault(Landroid/content/Context;)Landroid/content/SharedPreferences;

    move-result-object v2

    .line 229
    if-nez v2, :cond_1

    .line 247
    :goto_0
    return-void

    .line 233
    :cond_1
    const-string v3, "a_start_time"

    const-wide/16 v4, 0x0

    invoke-interface {v2, v3, v4, v5}, Landroid/content/SharedPreferences;->getLong(Ljava/lang/String;J)J

    move-result-wide v4

    .line 235
    cmp-long v3, v4, v6

    if-nez v3, :cond_2

    sget-boolean v3, Lcom/umeng/analytics/AnalyticsConfig;->ACTIVITY_DURATION_OPEN:Z

    if-eqz v3, :cond_2

    .line 236
    const-string v0, "onPause called before onResume"

    invoke-static {v0}, Lcom/umeng/commonsdk/statistics/common/MLog;->e(Ljava/lang/String;)V

    goto :goto_0

    .line 245
    :catch_0
    move-exception v0

    goto :goto_0

    .line 239
    :cond_2
    invoke-interface {v2}, Landroid/content/SharedPreferences;->edit()Landroid/content/SharedPreferences$Editor;

    move-result-object v2

    .line 241
    const-string v3, "a_end_time"

    invoke-interface {v2, v3, v0, v1}, Landroid/content/SharedPreferences$Editor;->putLong(Ljava/lang/String;J)Landroid/content/SharedPreferences$Editor;

    .line 242
    const-string v3, "session_end_time"

    invoke-interface {v2, v3, v0, v1}, Landroid/content/SharedPreferences$Editor;->putLong(Ljava/lang/String;J)Landroid/content/SharedPreferences$Editor;

    .line 243
    invoke-interface {v2}, Landroid/content/SharedPreferences$Editor;->commit()Z
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_0

    goto :goto_0
.end method

.method public b()Z
    .locals 10

    .prologue
    const-wide/16 v8, 0x0

    const/4 v0, 0x0

    .line 255
    sget-object v1, Lcom/umeng/analytics/pro/o;->g:Landroid/content/Context;

    invoke-static {v1}, Lcom/umeng/commonsdk/statistics/internal/PreferenceWrapper;->getDefault(Landroid/content/Context;)Landroid/content/SharedPreferences;

    move-result-object v1

    .line 256
    if-nez v1, :cond_1

    .line 271
    :cond_0
    :goto_0
    return v0

    .line 260
    :cond_1
    invoke-static {}, Ljava/lang/System;->currentTimeMillis()J

    move-result-wide v2

    .line 261
    const-string v4, "a_start_time"

    invoke-interface {v1, v4, v8, v9}, Landroid/content/SharedPreferences;->getLong(Ljava/lang/String;J)J

    move-result-wide v4

    .line 262
    const-string v6, "a_end_time"

    invoke-interface {v1, v6, v8, v9}, Landroid/content/SharedPreferences;->getLong(Ljava/lang/String;J)J

    move-result-wide v6

    .line 264
    cmp-long v1, v4, v8

    if-eqz v1, :cond_2

    sub-long v4, v2, v4

    sget-wide v8, Lcom/umeng/analytics/AnalyticsConfig;->kContinueSessionMillis:J

    cmp-long v1, v4, v8

    if-ltz v1, :cond_0

    .line 268
    :cond_2
    sub-long/2addr v2, v6

    sget-wide v4, Lcom/umeng/analytics/AnalyticsConfig;->kContinueSessionMillis:J

    cmp-long v1, v2, v4

    if-lez v1, :cond_0

    .line 269
    const/4 v0, 0x1

    goto :goto_0
.end method

.method public c()Ljava/lang/String;
    .locals 1

    .prologue
    .line 508
    sget-object v0, Lcom/umeng/analytics/pro/o;->f:Ljava/lang/String;

    return-object v0
.end method

.method public c(Landroid/content/Context;)Ljava/lang/String;
    .locals 3

    .prologue
    .line 513
    :try_start_0
    sget-object v0, Lcom/umeng/analytics/pro/o;->f:Ljava/lang/String;

    if-nez v0, :cond_0

    .line 514
    invoke-static {p1}, Lcom/umeng/commonsdk/statistics/internal/PreferenceWrapper;->getDefault(Landroid/content/Context;)Landroid/content/SharedPreferences;

    move-result-object v0

    const-string v1, "session_id"

    const/4 v2, 0x0

    invoke-interface {v0, v1, v2}, Landroid/content/SharedPreferences;->getString(Ljava/lang/String;Ljava/lang/String;)Ljava/lang/String;
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_0

    move-result-object v0

    .line 517
    :goto_0
    return-object v0

    .line 516
    :catch_0
    move-exception v0

    .line 517
    :cond_0
    sget-object v0, Lcom/umeng/analytics/pro/o;->f:Ljava/lang/String;

    goto :goto_0
.end method

.method public d()Ljava/lang/String;
    .locals 1

    .prologue
    .line 521
    sget-object v0, Lcom/umeng/analytics/pro/o;->g:Landroid/content/Context;

    invoke-virtual {p0, v0}, Lcom/umeng/analytics/pro/o;->c(Landroid/content/Context;)Ljava/lang/String;

    move-result-object v0

    return-object v0
.end method
