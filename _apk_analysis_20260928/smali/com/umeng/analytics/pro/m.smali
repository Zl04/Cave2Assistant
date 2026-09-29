.class public Lcom/umeng/analytics/pro/m;
.super Ljava/lang/Object;
.source "EventTracker.java"


# annotations
.annotation system Ldalvik/annotation/MemberClasses;
    value = {
        Lcom/umeng/analytics/pro/m$a;
    }
.end annotation


# static fields
.field private static final a:Ljava/lang/String; = "fs_lc_tl"

.field private static final e:Ljava/lang/String; = "-1"

.field private static f:Landroid/content/Context;


# instance fields
.field private final b:I

.field private final c:I

.field private final d:I

.field private g:Lorg/json/JSONObject;


# direct methods
.method private constructor <init>()V
    .locals 1

    .prologue
    .line 47
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    .line 39
    const/16 v0, 0x80

    iput v0, p0, Lcom/umeng/analytics/pro/m;->b:I

    .line 40
    const/16 v0, 0x100

    iput v0, p0, Lcom/umeng/analytics/pro/m;->c:I

    .line 41
    const/16 v0, 0xa

    iput v0, p0, Lcom/umeng/analytics/pro/m;->d:I

    .line 45
    const/4 v0, 0x0

    iput-object v0, p0, Lcom/umeng/analytics/pro/m;->g:Lorg/json/JSONObject;

    .line 49
    :try_start_0
    iget-object v0, p0, Lcom/umeng/analytics/pro/m;->g:Lorg/json/JSONObject;

    if-nez v0, :cond_0

    .line 50
    sget-object v0, Lcom/umeng/analytics/pro/m;->f:Landroid/content/Context;

    invoke-direct {p0, v0}, Lcom/umeng/analytics/pro/m;->b(Landroid/content/Context;)V
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_0

    .line 54
    :cond_0
    :goto_0
    return-void

    .line 52
    :catch_0
    move-exception v0

    goto :goto_0
.end method

.method synthetic constructor <init>(Lcom/umeng/analytics/pro/m$1;)V
    .locals 0

    .prologue
    .line 36
    invoke-direct {p0}, Lcom/umeng/analytics/pro/m;-><init>()V

    return-void
.end method

.method public static a(Landroid/content/Context;)Lcom/umeng/analytics/pro/m;
    .locals 1

    .prologue
    .line 61
    sget-object v0, Lcom/umeng/analytics/pro/m;->f:Landroid/content/Context;

    if-nez v0, :cond_0

    .line 62
    if-eqz p0, :cond_0

    .line 63
    invoke-virtual {p0}, Landroid/content/Context;->getApplicationContext()Landroid/content/Context;

    move-result-object v0

    sput-object v0, Lcom/umeng/analytics/pro/m;->f:Landroid/content/Context;

    .line 67
    :cond_0
    invoke-static {}, Lcom/umeng/analytics/pro/m$a;->a()Lcom/umeng/analytics/pro/m;

    move-result-object v0

    return-object v0
.end method

.method private a(Ljava/util/Map;)Lorg/json/JSONObject;
    .locals 10
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "(",
            "Ljava/util/Map",
            "<",
            "Ljava/lang/String;",
            "Ljava/lang/Object;",
            ">;)",
            "Lorg/json/JSONObject;"
        }
    .end annotation

    .prologue
    const/4 v2, 0x0

    .line 470
    .line 472
    new-instance v3, Lorg/json/JSONObject;

    invoke-direct {v3}, Lorg/json/JSONObject;-><init>()V

    .line 475
    :try_start_0
    invoke-interface {p1}, Ljava/util/Map;->entrySet()Ljava/util/Set;

    move-result-object v0

    invoke-interface {v0}, Ljava/util/Set;->iterator()Ljava/util/Iterator;

    move-result-object v4

    .line 478
    :cond_0
    :goto_0
    invoke-interface {v4}, Ljava/util/Iterator;->hasNext()Z
    :try_end_0
    .catch Ljava/lang/Exception; {:try_start_0 .. :try_end_0} :catch_1

    move-result v0

    if-eqz v0, :cond_2

    .line 480
    :try_start_1
    invoke-interface {v4}, Ljava/util/Iterator;->next()Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Ljava/util/Map$Entry;

    .line 481
    invoke-interface {v0}, Ljava/util/Map$Entry;->getKey()Ljava/lang/Object;

    move-result-object v1

    check-cast v1, Ljava/lang/String;

    .line 482
    if-eqz v1, :cond_0

    .line 484
    const/16 v5, 0x80

    invoke-static {v1, v5}, Lcom/umeng/commonsdk/statistics/common/HelperUtils;->subStr(Ljava/lang/String;I)Ljava/lang/String;

    move-result-object v5

    .line 486
    invoke-interface {v0}, Ljava/util/Map$Entry;->getValue()Ljava/lang/Object;

    move-result-object v0

    .line 487
    if-eqz v0, :cond_0

    .line 489
    invoke-virtual {v0}, Ljava/lang/Object;->getClass()Ljava/lang/Class;

    move-result-object v1

    invoke-virtual {v1}, Ljava/lang/Class;->isArray()Z

    move-result v1

    if-eqz v1, :cond_b

    .line 490
    instance-of v1, v0, [I

    if-eqz v1, :cond_3

    .line 491
    check-cast v0, [I

    check-cast v0, [I

    .line 492
    new-instance v6, Lorg/json/JSONArray;

    invoke-direct {v6}, Lorg/json/JSONArray;-><init>()V

    move v1, v2

    .line 493
    :goto_1
    array-length v7, v0

    if-ge v1, v7, :cond_1

    .line 494
    aget v7, v0, v1

    invoke-virtual {v6, v7}, Lorg/json/JSONArray;->put(I)Lorg/json/JSONArray;

    .line 493
    add-int/lit8 v1, v1, 0x1

    goto :goto_1

    .line 496
    :cond_1
    invoke-virtual {v3, v5, v6}, Lorg/json/JSONObject;->put(Ljava/lang/String;Ljava/lang/Object;)Lorg/json/JSONObject;
    :try_end_1
    .catch Ljava/lang/Exception; {:try_start_1 .. :try_end_1} :catch_0

    goto :goto_0

    .line 594
    :catch_0
    move-exception v0

    .line 595
    :try_start_2
    invoke-static {v0}, Lcom/umeng/commonsdk/statistics/common/MLog;->e(Ljava/lang/Throwable;)V
    :try_end_2
    .catch Ljava/lang/Exception; {:try_start_2 .. :try_end_2} :catch_1

    goto :goto_0

    .line 598
    :catch_1
    move-exception v0

    .line 603
    :cond_2
    return-object v3

    .line 497
    :cond_3
    :try_start_3
    instance-of v1, v0, [D

    if-eqz v1, :cond_5

    .line 498
    check-cast v0, [D

    check-cast v0, [D

    .line 499
    new-instance v6, Lorg/json/JSONArray;

    invoke-direct {v6}, Lorg/json/JSONArray;-><init>()V

    move v1, v2

    .line 500
    :goto_2
    array-length v7, v0

    if-ge v1, v7, :cond_4

    .line 501
    aget-wide v8, v0, v1

    invoke-virtual {v6, v8, v9}, Lorg/json/JSONArray;->put(D)Lorg/json/JSONArray;

    .line 500
    add-int/lit8 v1, v1, 0x1

    goto :goto_2

    .line 503
    :cond_4
    invoke-virtual {v3, v5, v6}, Lorg/json/JSONObject;->put(Ljava/lang/String;Ljava/lang/Object;)Lorg/json/JSONObject;

    goto :goto_0

    .line 504
    :cond_5
    instance-of v1, v0, [J

    if-eqz v1, :cond_7

    .line 505
    check-cast v0, [J

    check-cast v0, [J

    .line 506
    new-instance v6, Lorg/json/JSONArray;

    invoke-direct {v6}, Lorg/json/JSONArray;-><init>()V

    move v1, v2

    .line 507
    :goto_3
    array-length v7, v0

    if-ge v1, v7, :cond_6

    .line 508
    aget-wide v8, v0, v1

    invoke-virtual {v6, v8, v9}, Lorg/json/JSONArray;->put(J)Lorg/json/JSONArray;

    .line 507
    add-int/lit8 v1, v1, 0x1

    goto :goto_3

    .line 510
    :cond_6
    invoke-virtual {v3, v5, v6}, Lorg/json/JSONObject;->put(Ljava/lang/String;Ljava/lang/Object;)Lorg/json/JSONObject;

    goto/16 :goto_0

    .line 511
    :cond_7
    instance-of v1, v0, [F

    if-eqz v1, :cond_9

    .line 512
    check-cast v0, [F

    check-cast v0, [F

    .line 513
    new-instance v6, Lorg/json/JSONArray;

    invoke-direct {v6}, Lorg/json/JSONArray;-><init>()V

    move v1, v2

    .line 514
    :goto_4
    array-length v7, v0

    if-ge v1, v7, :cond_8

    .line 515
    aget v7, v0, v1

    float-to-double v8, v7

    invoke-virtual {v6, v8, v9}, Lorg/json/JSONArray;->put(D)Lorg/json/JSONArray;

    .line 514
    add-int/lit8 v1, v1, 0x1

    goto :goto_4

    .line 517
    :cond_8
    invoke-virtual {v3, v5, v6}, Lorg/json/JSONObject;->put(Ljava/lang/String;Ljava/lang/Object;)Lorg/json/JSONObject;

    goto/16 :goto_0

    .line 518
    :cond_9
    instance-of v1, v0, [S

    if-eqz v1, :cond_0

    .line 519
    check-cast v0, [S

    check-cast v0, [S

    .line 520
    new-instance v6, Lorg/json/JSONArray;

    invoke-direct {v6}, Lorg/json/JSONArray;-><init>()V

    move v1, v2

    .line 521
    :goto_5
    array-length v7, v0

    if-ge v1, v7, :cond_a

    .line 522
    aget-short v7, v0, v1

    invoke-virtual {v6, v7}, Lorg/json/JSONArray;->put(I)Lorg/json/JSONArray;

    .line 521
    add-int/lit8 v1, v1, 0x1

    goto :goto_5

    .line 524
    :cond_a
    invoke-virtual {v3, v5, v6}, Lorg/json/JSONObject;->put(Ljava/lang/String;Ljava/lang/Object;)Lorg/json/JSONObject;

    goto/16 :goto_0

    .line 531
    :cond_b
    instance-of v1, v0, Ljava/util/List;

    if-eqz v1, :cond_f

    .line 532
    check-cast v0, Ljava/util/List;

    .line 533
    new-instance v6, Lorg/json/JSONArray;

    invoke-direct {v6}, Lorg/json/JSONArray;-><init>()V

    move v1, v2

    .line 535
    :goto_6
    invoke-interface {v0}, Ljava/util/List;->size()I

    move-result v7

    if-ge v1, v7, :cond_e

    .line 536
    invoke-interface {v0, v1}, Ljava/util/List;->get(I)Ljava/lang/Object;

    move-result-object v7

    .line 537
    instance-of v8, v7, Ljava/lang/String;

    if-nez v8, :cond_c

    instance-of v8, v7, Ljava/lang/Long;

    if-nez v8, :cond_c

    instance-of v8, v7, Ljava/lang/Integer;

    if-nez v8, :cond_c

    instance-of v8, v7, Ljava/lang/Float;

    if-nez v8, :cond_c

    instance-of v8, v7, Ljava/lang/Double;

    if-nez v8, :cond_c

    instance-of v7, v7, Ljava/lang/Short;

    if-eqz v7, :cond_d

    .line 544
    :cond_c
    invoke-interface {v0, v1}, Ljava/util/List;->get(I)Ljava/lang/Object;

    move-result-object v7

    invoke-virtual {v6, v7}, Lorg/json/JSONArray;->put(Ljava/lang/Object;)Lorg/json/JSONArray;

    .line 535
    :cond_d
    add-int/lit8 v1, v1, 0x1

    goto :goto_6

    .line 547
    :cond_e
    invoke-virtual {v6}, Lorg/json/JSONArray;->length()I

    move-result v0

    if-lez v0, :cond_0

    .line 548
    invoke-virtual {v3, v5, v6}, Lorg/json/JSONObject;->put(Ljava/lang/String;Ljava/lang/Object;)Lorg/json/JSONObject;

    goto/16 :goto_0

    .line 550
    :cond_f
    instance-of v1, v0, Ljava/lang/String;

    if-eqz v1, :cond_10

    .line 551
    invoke-virtual {v0}, Ljava/lang/Object;->toString()Ljava/lang/String;

    move-result-object v0

    const/16 v1, 0x100

    invoke-static {v0, v1}, Lcom/umeng/commonsdk/statistics/common/HelperUtils;->subStr(Ljava/lang/String;I)Ljava/lang/String;

    move-result-object v0

    .line 553
    invoke-virtual {v3, v5, v0}, Lorg/json/JSONObject;->put(Ljava/lang/String;Ljava/lang/Object;)Lorg/json/JSONObject;

    goto/16 :goto_0

    .line 554
    :cond_10
    instance-of v1, v0, Ljava/lang/Long;

    if-nez v1, :cond_11

    instance-of v1, v0, Ljava/lang/Integer;

    if-nez v1, :cond_11

    instance-of v1, v0, Ljava/lang/Float;

    if-nez v1, :cond_11

    instance-of v1, v0, Ljava/lang/Double;

    if-nez v1, :cond_11

    instance-of v1, v0, Ljava/lang/Short;

    if-eqz v1, :cond_12

    .line 560
    :cond_11
    invoke-virtual {v3, v5, v0}, Lorg/json/JSONObject;->put(Ljava/lang/String;Ljava/lang/Object;)Lorg/json/JSONObject;

    goto/16 :goto_0

    .line 585
    :cond_12
    const-string v0, "The param has not support type. please check !"

    invoke-static {v0}, Lcom/umeng/commonsdk/statistics/common/MLog;->e(Ljava/lang/String;)V
    :try_end_3
    .catch Ljava/lang/Exception; {:try_start_3 .. :try_end_3} :catch_0

    goto/16 :goto_0
.end method

.method private a()V
    .locals 7

    .prologue
    const/16 v6, 0xa

    const/4 v0, 0x0

    .line 312
    :try_start_0
    sget-object v1, Lcom/umeng/analytics/pro/m;->f:Landroid/content/Context;

    const-string v2, "track_list"

    const-string v3, ""

    invoke-static {v1, v2, v3}, Lcom/umeng/commonsdk/framework/UMEnvelopeBuild;->imprintProperty(Landroid/content/Context;Ljava/lang/String;Ljava/lang/String;)Ljava/lang/String;

    move-result-object v1

    .line 313
    invoke-static {v1}, Landroid/text/TextUtils;->isEmpty(Ljava/lang/CharSequence;)Z

    move-result v2

    if-nez v2, :cond_4

    .line 314
    const-string v2, "!"

    invoke-virtual {v1, v2}, Ljava/lang/String;->split(Ljava/lang/String;)[Ljava/lang/String;

    move-result-object v2

    .line 315
    new-instance v3, Lorg/json/JSONObject;

    invoke-direct {v3}, Lorg/json/JSONObject;-><init>()V

    .line 317
    iget-object v1, p0, Lcom/umeng/analytics/pro/m;->g:Lorg/json/JSONObject;

    if-eqz v1, :cond_1

    move v1, v0

    .line 319
    :goto_0
    array-length v4, v2

    if-ge v1, v4, :cond_1

    .line 320
    aget-object v4, v2, v1

    const/16 v5, 0x80

    invoke-static {v4, v5}, Lcom/umeng/commonsdk/statistics/common/HelperUtils;->subStr(Ljava/lang/String;I)Ljava/lang/String;

    move-result-object v4

    .line 321
    iget-object v5, p0, Lcom/umeng/analytics/pro/m;->g:Lorg/json/JSONObject;

    invoke-virtual {v5, v4}, Lorg/json/JSONObject;->has(Ljava/lang/String;)Z

    move-result v5

    if-eqz v5, :cond_0

    .line 322
    iget-object v5, p0, Lcom/umeng/analytics/pro/m;->g:Lorg/json/JSONObject;

    invoke-virtual {v5, v4}, Lorg/json/JSONObject;->get(Ljava/lang/String;)Ljava/lang/Object;

    move-result-object v5

    invoke-virtual {v3, v4, v5}, Lorg/json/JSONObject;->put(Ljava/lang/String;Ljava/lang/Object;)Lorg/json/JSONObject;

    .line 319
    :cond_0
    add-int/lit8 v1, v1, 0x1

    goto :goto_0

    .line 328
    :cond_1
    new-instance v1, Lorg/json/JSONObject;

    invoke-direct {v1}, Lorg/json/JSONObject;-><init>()V

    iput-object v1, p0, Lcom/umeng/analytics/pro/m;->g:Lorg/json/JSONObject;

    .line 329
    array-length v1, v2

    if-lt v1, v6, :cond_2

    .line 330
    :goto_1
    if-ge v0, v6, :cond_3

    .line 331
    aget-object v1, v2, v0

    invoke-direct {p0, v1, v3}, Lcom/umeng/analytics/pro/m;->a(Ljava/lang/String;Lorg/json/JSONObject;)V

    .line 330
    add-int/lit8 v0, v0, 0x1

    goto :goto_1

    .line 334
    :cond_2
    :goto_2
    array-length v1, v2

    if-ge v0, v1, :cond_3

    .line 335
    aget-object v1, v2, v0

    invoke-direct {p0, v1, v3}, Lcom/umeng/analytics/pro/m;->a(Ljava/lang/String;Lorg/json/JSONObject;)V

    .line 334
    add-int/lit8 v0, v0, 0x1

    goto :goto_2

    .line 339
    :cond_3
    sget-object v0, Lcom/umeng/analytics/pro/m;->f:Landroid/content/Context;

    invoke-direct {p0, v0}, Lcom/umeng/analytics/pro/m;->c(Landroid/content/Context;)V
    :try_end_0
    .catch Ljava/lang/Exception; {:try_start_0 .. :try_end_0} :catch_0

    .line 348
    :cond_4
    :goto_3
    return-void

    .line 343
    :catch_0
    move-exception v0

    goto :goto_3
.end method

.method private a(Ljava/lang/String;Lorg/json/JSONObject;)V
    .locals 2
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Lorg/json/JSONException;
        }
    .end annotation

    .prologue
    .line 353
    const/16 v0, 0x80

    invoke-static {p1, v0}, Lcom/umeng/commonsdk/statistics/common/HelperUtils;->subStr(Ljava/lang/String;I)Ljava/lang/String;

    move-result-object v1

    .line 354
    invoke-virtual {p2, v1}, Lorg/json/JSONObject;->has(Ljava/lang/String;)Z

    move-result v0

    if-eqz v0, :cond_0

    .line 355
    invoke-virtual {p2, v1}, Lorg/json/JSONObject;->get(Ljava/lang/String;)Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Ljava/lang/Boolean;

    invoke-virtual {v0}, Ljava/lang/Boolean;->booleanValue()Z

    move-result v0

    invoke-direct {p0, v1, v0}, Lcom/umeng/analytics/pro/m;->a(Ljava/lang/String;Z)V

    .line 359
    :goto_0
    return-void

    .line 357
    :cond_0
    const/4 v0, 0x0

    invoke-direct {p0, v1, v0}, Lcom/umeng/analytics/pro/m;->a(Ljava/lang/String;Z)V

    goto :goto_0
.end method

.method private a(Ljava/lang/String;Z)V
    .locals 1

    .prologue
    .line 363
    :try_start_0
    const-string v0, "$st_fl"

    invoke-virtual {v0, p1}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v0

    if-nez v0, :cond_0

    const-string v0, "du"

    .line 364
    invoke-virtual {v0, p1}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v0

    if-nez v0, :cond_0

    const-string v0, "id"

    .line 365
    invoke-virtual {v0, p1}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v0

    if-nez v0, :cond_0

    const-string v0, "ts"

    .line 366
    invoke-virtual {v0, p1}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v0

    if-nez v0, :cond_0

    .line 367
    iget-object v0, p0, Lcom/umeng/analytics/pro/m;->g:Lorg/json/JSONObject;

    invoke-virtual {v0, p1}, Lorg/json/JSONObject;->has(Ljava/lang/String;)Z

    move-result v0

    if-nez v0, :cond_0

    .line 368
    iget-object v0, p0, Lcom/umeng/analytics/pro/m;->g:Lorg/json/JSONObject;

    invoke-virtual {v0, p1, p2}, Lorg/json/JSONObject;->put(Ljava/lang/String;Z)Lorg/json/JSONObject;
    :try_end_0
    .catch Ljava/lang/Exception; {:try_start_0 .. :try_end_0} :catch_0

    .line 376
    :cond_0
    :goto_0
    return-void

    .line 371
    :catch_0
    move-exception v0

    goto :goto_0
.end method

.method private a(Ljava/lang/String;)Z
    .locals 2

    .prologue
    .line 608
    if-eqz p1, :cond_0

    .line 609
    :try_start_0
    invoke-virtual {p1}, Ljava/lang/String;->trim()Ljava/lang/String;

    move-result-object v0

    invoke-virtual {v0}, Ljava/lang/String;->getBytes()[B

    move-result-object v0

    array-length v0, v0

    .line 611
    if-lez v0, :cond_0

    const/16 v1, 0x80

    if-gt v0, v1, :cond_0

    .line 612
    const/4 v0, 0x1

    .line 623
    :goto_0
    return v0

    .line 616
    :cond_0
    const-string v0, "Event id is empty or too long in tracking Event"

    invoke-static {v0}, Lcom/umeng/commonsdk/statistics/common/MLog;->e(Ljava/lang/String;)V
    :try_end_0
    .catch Ljava/lang/Exception; {:try_start_0 .. :try_end_0} :catch_0

    .line 623
    :goto_1
    const/4 v0, 0x0

    goto :goto_0

    .line 617
    :catch_0
    move-exception v0

    goto :goto_1
.end method

.method private b(Landroid/content/Context;)V
    .locals 3

    .prologue
    .line 294
    :try_start_0
    invoke-static {p1}, Lcom/umeng/commonsdk/statistics/internal/PreferenceWrapper;->getDefault(Landroid/content/Context;)Landroid/content/SharedPreferences;

    move-result-object v0

    .line 295
    const-string v1, "fs_lc_tl"

    const/4 v2, 0x0

    invoke-interface {v0, v1, v2}, Landroid/content/SharedPreferences;->getString(Ljava/lang/String;Ljava/lang/String;)Ljava/lang/String;

    move-result-object v0

    .line 296
    invoke-static {v0}, Landroid/text/TextUtils;->isEmpty(Ljava/lang/CharSequence;)Z

    move-result v1

    if-nez v1, :cond_0

    .line 297
    new-instance v1, Lorg/json/JSONObject;

    invoke-direct {v1, v0}, Lorg/json/JSONObject;-><init>(Ljava/lang/String;)V

    iput-object v1, p0, Lcom/umeng/analytics/pro/m;->g:Lorg/json/JSONObject;

    .line 302
    :cond_0
    invoke-direct {p0}, Lcom/umeng/analytics/pro/m;->a()V
    :try_end_0
    .catch Ljava/lang/Exception; {:try_start_0 .. :try_end_0} :catch_0

    .line 305
    :goto_0
    return-void

    .line 303
    :catch_0
    move-exception v0

    goto :goto_0
.end method

.method private b(Ljava/lang/String;)Z
    .locals 3

    .prologue
    const/4 v0, 0x1

    .line 628
    if-nez p1, :cond_1

    .line 639
    :cond_0
    :goto_0
    return v0

    .line 630
    :cond_1
    :try_start_0
    invoke-virtual {p1}, Ljava/lang/String;->trim()Ljava/lang/String;

    move-result-object v1

    invoke-virtual {v1}, Ljava/lang/String;->getBytes()[B

    move-result-object v1

    array-length v1, v1

    const/16 v2, 0x100

    if-le v1, v2, :cond_0

    .line 633
    const-string v0, "Event label or value is empty or too long in tracking Event"

    invoke-static {v0}, Lcom/umeng/commonsdk/statistics/common/MLog;->e(Ljava/lang/String;)V
    :try_end_0
    .catch Ljava/lang/Exception; {:try_start_0 .. :try_end_0} :catch_0

    .line 639
    :goto_1
    const/4 v0, 0x0

    goto :goto_0

    .line 634
    :catch_0
    move-exception v0

    goto :goto_1
.end method

.method private b(Ljava/util/Map;)Z
    .locals 4
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "(",
            "Ljava/util/Map",
            "<",
            "Ljava/lang/String;",
            "Ljava/lang/Object;",
            ">;)Z"
        }
    .end annotation

    .prologue
    const/4 v2, 0x0

    .line 644
    if-eqz p1, :cond_0

    :try_start_0
    invoke-interface {p1}, Ljava/util/Map;->isEmpty()Z

    move-result v0

    if-eqz v0, :cond_1

    .line 645
    :cond_0
    const-string v0, "map is null or empty in onEvent"

    invoke-static {v0}, Lcom/umeng/commonsdk/statistics/common/MLog;->e(Ljava/lang/String;)V

    move v0, v2

    .line 668
    :goto_0
    return v0

    .line 649
    :cond_1
    invoke-interface {p1}, Ljava/util/Map;->entrySet()Ljava/util/Set;

    move-result-object v0

    invoke-interface {v0}, Ljava/util/Set;->iterator()Ljava/util/Iterator;

    move-result-object v3

    :cond_2
    invoke-interface {v3}, Ljava/util/Iterator;->hasNext()Z

    move-result v0

    if-eqz v0, :cond_5

    invoke-interface {v3}, Ljava/util/Iterator;->next()Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Ljava/util/Map$Entry;

    .line 650
    invoke-interface {v0}, Ljava/util/Map$Entry;->getKey()Ljava/lang/Object;

    move-result-object v1

    check-cast v1, Ljava/lang/String;

    invoke-direct {p0, v1}, Lcom/umeng/analytics/pro/m;->a(Ljava/lang/String;)Z

    move-result v1

    if-nez v1, :cond_3

    .line 651
    const-string v0, "map has NULL key. please check!"

    invoke-static {v0}, Lcom/umeng/commonsdk/statistics/common/MLog;->e(Ljava/lang/String;)V

    move v0, v2

    .line 652
    goto :goto_0

    .line 655
    :cond_3
    invoke-interface {v0}, Ljava/util/Map$Entry;->getValue()Ljava/lang/Object;

    move-result-object v1

    if-nez v1, :cond_4

    move v0, v2

    .line 656
    goto :goto_0

    .line 659
    :cond_4
    invoke-interface {v0}, Ljava/util/Map$Entry;->getValue()Ljava/lang/Object;

    move-result-object v1

    instance-of v1, v1, Ljava/lang/String;

    if-eqz v1, :cond_2

    invoke-interface {v0}, Ljava/util/Map$Entry;->getValue()Ljava/lang/Object;

    move-result-object v0

    invoke-virtual {v0}, Ljava/lang/Object;->toString()Ljava/lang/String;

    move-result-object v0

    invoke-direct {p0, v0}, Lcom/umeng/analytics/pro/m;->b(Ljava/lang/String;)Z
    :try_end_0
    .catch Ljava/lang/Exception; {:try_start_0 .. :try_end_0} :catch_0

    move-result v0

    if-nez v0, :cond_2

    move v0, v2

    .line 660
    goto :goto_0

    .line 663
    :catch_0
    move-exception v0

    .line 668
    :cond_5
    const/4 v0, 0x1

    goto :goto_0
.end method

.method private c(Landroid/content/Context;)V
    .locals 3

    .prologue
    .line 385
    :try_start_0
    iget-object v0, p0, Lcom/umeng/analytics/pro/m;->g:Lorg/json/JSONObject;

    if-eqz v0, :cond_0

    .line 386
    sget-object v0, Lcom/umeng/analytics/pro/m;->f:Landroid/content/Context;

    invoke-static {v0}, Lcom/umeng/commonsdk/statistics/internal/PreferenceWrapper;->getDefault(Landroid/content/Context;)Landroid/content/SharedPreferences;

    move-result-object v0

    .line 387
    invoke-interface {v0}, Landroid/content/SharedPreferences;->edit()Landroid/content/SharedPreferences$Editor;

    move-result-object v0

    const-string v1, "fs_lc_tl"

    iget-object v2, p0, Lcom/umeng/analytics/pro/m;->g:Lorg/json/JSONObject;

    invoke-virtual {v2}, Lorg/json/JSONObject;->toString()Ljava/lang/String;

    move-result-object v2

    invoke-interface {v0, v1, v2}, Landroid/content/SharedPreferences$Editor;->putString(Ljava/lang/String;Ljava/lang/String;)Landroid/content/SharedPreferences$Editor;

    move-result-object v0

    invoke-interface {v0}, Landroid/content/SharedPreferences$Editor;->commit()Z
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_0

    .line 391
    :cond_0
    :goto_0
    return-void

    .line 389
    :catch_0
    move-exception v0

    goto :goto_0
.end method


# virtual methods
.method public a(Ljava/lang/Object;)V
    .locals 7

    .prologue
    .line 159
    :try_start_0
    check-cast p1, Lcom/umeng/analytics/pro/i$d;

    .line 161
    invoke-virtual {p1}, Lcom/umeng/analytics/pro/i$d;->c()Ljava/lang/String;

    move-result-object v0

    .line 162
    invoke-virtual {p1}, Lcom/umeng/analytics/pro/i$d;->a()Ljava/util/Map;

    move-result-object v1

    .line 163
    invoke-virtual {p1}, Lcom/umeng/analytics/pro/i$d;->b()Ljava/lang/String;

    move-result-object v2

    .line 164
    invoke-virtual {p1}, Lcom/umeng/analytics/pro/i$d;->d()J

    move-result-wide v4

    .line 166
    invoke-static {v0}, Landroid/text/TextUtils;->isEmpty(Ljava/lang/CharSequence;)Z

    move-result v3

    if-eqz v3, :cond_0

    .line 238
    :goto_0
    return-void

    .line 170
    :cond_0
    const/16 v3, 0x80

    invoke-static {v0, v3}, Lcom/umeng/commonsdk/statistics/common/HelperUtils;->subStr(Ljava/lang/String;I)Ljava/lang/String;

    move-result-object v3

    .line 172
    new-instance v6, Lorg/json/JSONObject;

    invoke-direct {v6}, Lorg/json/JSONObject;-><init>()V

    .line 173
    const-string v0, "_$!id"

    invoke-virtual {v6, v0, v3}, Lorg/json/JSONObject;->put(Ljava/lang/String;Ljava/lang/Object;)Lorg/json/JSONObject;

    .line 174
    const-string v0, "_$!ts"

    invoke-virtual {v6, v0, v4, v5}, Lorg/json/JSONObject;->put(Ljava/lang/String;J)Lorg/json/JSONObject;

    .line 176
    invoke-static {}, Lcom/umeng/analytics/pro/o;->a()Lcom/umeng/analytics/pro/o;

    move-result-object v0

    invoke-virtual {v0}, Lcom/umeng/analytics/pro/o;->c()Ljava/lang/String;

    move-result-object v0

    .line 178
    const-string v4, "__ii"

    invoke-static {v0}, Landroid/text/TextUtils;->isEmpty(Ljava/lang/CharSequence;)Z

    move-result v5

    if-eqz v5, :cond_1

    const-string v0, "-1"

    :cond_1
    invoke-virtual {v6, v4, v0}, Lorg/json/JSONObject;->put(Ljava/lang/String;Ljava/lang/Object;)Lorg/json/JSONObject;

    .line 180
    invoke-static {v2}, Landroid/text/TextUtils;->isEmpty(Ljava/lang/CharSequence;)Z
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_1

    move-result v0

    if-nez v0, :cond_2

    .line 182
    :try_start_1
    new-instance v0, Lorg/json/JSONObject;

    invoke-direct {v0, v2}, Lorg/json/JSONObject;-><init>(Ljava/lang/String;)V

    .line 183
    invoke-virtual {v0}, Lorg/json/JSONObject;->length()I

    move-result v2

    if-lez v2, :cond_2

    .line 184
    const-string v2, "_$!sp"

    invoke-virtual {v6, v2, v0}, Lorg/json/JSONObject;->put(Ljava/lang/String;Ljava/lang/Object;)Lorg/json/JSONObject;
    :try_end_1
    .catch Lorg/json/JSONException; {:try_start_1 .. :try_end_1} :catch_2
    .catch Ljava/lang/Throwable; {:try_start_1 .. :try_end_1} :catch_1

    .line 190
    :cond_2
    :goto_1
    :try_start_2
    invoke-direct {p0}, Lcom/umeng/analytics/pro/m;->a()V

    .line 191
    if-eqz v1, :cond_4

    .line 192
    invoke-direct {p0, v1}, Lcom/umeng/analytics/pro/m;->a(Ljava/util/Map;)Lorg/json/JSONObject;

    move-result-object v1

    .line 194
    invoke-virtual {v1}, Lorg/json/JSONObject;->length()I

    move-result v0

    if-lez v0, :cond_4

    .line 195
    invoke-virtual {v1}, Lorg/json/JSONObject;->keys()Ljava/util/Iterator;

    move-result-object v2

    .line 197
    :goto_2
    invoke-interface {v2}, Ljava/util/Iterator;->hasNext()Z
    :try_end_2
    .catch Ljava/lang/Throwable; {:try_start_2 .. :try_end_2} :catch_1

    move-result v0

    if-eqz v0, :cond_4

    .line 199
    :try_start_3
    invoke-interface {v2}, Ljava/util/Iterator;->next()Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Ljava/lang/String;

    .line 200
    sget-object v4, Lcom/umeng/analytics/pro/b;->aq:[Ljava/lang/String;

    invoke-static {v4}, Ljava/util/Arrays;->asList([Ljava/lang/Object;)Ljava/util/List;

    move-result-object v4

    invoke-interface {v4, v0}, Ljava/util/List;->contains(Ljava/lang/Object;)Z

    move-result v4

    if-nez v4, :cond_3

    .line 201
    invoke-virtual {v1, v0}, Lorg/json/JSONObject;->get(Ljava/lang/String;)Ljava/lang/Object;

    move-result-object v4

    invoke-virtual {v6, v0, v4}, Lorg/json/JSONObject;->put(Ljava/lang/String;Ljava/lang/Object;)Lorg/json/JSONObject;
    :try_end_3
    .catch Ljava/lang/Throwable; {:try_start_3 .. :try_end_3} :catch_0

    goto :goto_2

    .line 205
    :catch_0
    move-exception v0

    .line 206
    :try_start_4
    invoke-static {v0}, Lcom/umeng/commonsdk/statistics/common/MLog;->e(Ljava/lang/Throwable;)V
    :try_end_4
    .catch Ljava/lang/Throwable; {:try_start_4 .. :try_end_4} :catch_1

    goto :goto_2

    .line 233
    :catch_1
    move-exception v0

    goto :goto_0

    .line 203
    :cond_3
    :try_start_5
    const-string v0, "the key in map about track interface is invalid.  "

    invoke-static {v0}, Lcom/umeng/commonsdk/statistics/common/MLog;->e(Ljava/lang/String;)V
    :try_end_5
    .catch Ljava/lang/Throwable; {:try_start_5 .. :try_end_5} :catch_0

    goto :goto_2

    .line 212
    :cond_4
    :try_start_6
    iget-object v0, p0, Lcom/umeng/analytics/pro/m;->g:Lorg/json/JSONObject;

    if-eqz v0, :cond_5

    .line 213
    iget-object v0, p0, Lcom/umeng/analytics/pro/m;->g:Lorg/json/JSONObject;

    invoke-virtual {v0, v3}, Lorg/json/JSONObject;->has(Ljava/lang/String;)Z

    move-result v0

    if-eqz v0, :cond_5

    .line 214
    iget-object v0, p0, Lcom/umeng/analytics/pro/m;->g:Lorg/json/JSONObject;

    invoke-virtual {v0, v3}, Lorg/json/JSONObject;->get(Ljava/lang/String;)Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Ljava/lang/Boolean;

    invoke-virtual {v0}, Ljava/lang/Boolean;->booleanValue()Z

    move-result v0

    .line 219
    if-nez v0, :cond_5

    .line 220
    const-string v0, "$st_fl"

    const/4 v1, 0x1

    invoke-virtual {v6, v0, v1}, Lorg/json/JSONObject;->put(Ljava/lang/String;I)Lorg/json/JSONObject;

    .line 221
    iget-object v0, p0, Lcom/umeng/analytics/pro/m;->g:Lorg/json/JSONObject;

    const/4 v1, 0x1

    invoke-virtual {v0, v3, v1}, Lorg/json/JSONObject;->put(Ljava/lang/String;Z)Lorg/json/JSONObject;

    .line 222
    sget-object v0, Lcom/umeng/analytics/pro/m;->f:Landroid/content/Context;

    invoke-direct {p0, v0}, Lcom/umeng/analytics/pro/m;->c(Landroid/content/Context;)V

    .line 230
    :cond_5
    sget-object v0, Lcom/umeng/analytics/pro/m;->f:Landroid/content/Context;

    invoke-static {v0}, Lcom/umeng/analytics/pro/i;->a(Landroid/content/Context;)Lcom/umeng/analytics/pro/i;

    move-result-object v0

    const/4 v1, 0x0

    const/4 v2, 0x0

    invoke-virtual {v0, v6, v1, v2}, Lcom/umeng/analytics/pro/i;->a(Ljava/lang/Object;IZ)V
    :try_end_6
    .catch Ljava/lang/Throwable; {:try_start_6 .. :try_end_6} :catch_1

    goto/16 :goto_0

    .line 186
    :catch_2
    move-exception v0

    goto :goto_1
.end method

.method public a(Ljava/lang/String;Ljava/lang/String;JI)V
    .locals 5

    .prologue
    .line 121
    :try_start_0
    invoke-direct {p0, p1}, Lcom/umeng/analytics/pro/m;->a(Ljava/lang/String;)Z

    move-result v0

    if-eqz v0, :cond_0

    invoke-direct {p0, p2}, Lcom/umeng/analytics/pro/m;->b(Ljava/lang/String;)Z

    move-result v0

    if-nez v0, :cond_1

    .line 144
    :cond_0
    :goto_0
    return-void

    .line 124
    :cond_1
    sget-object v0, Lcom/umeng/analytics/pro/b;->ap:[Ljava/lang/String;

    invoke-static {v0}, Ljava/util/Arrays;->asList([Ljava/lang/Object;)Ljava/util/List;

    move-result-object v0

    invoke-interface {v0, p1}, Ljava/util/List;->contains(Ljava/lang/Object;)Z

    move-result v0

    if-eqz v0, :cond_2

    .line 125
    const-string v0, "the id is valid!"

    invoke-static {v0}, Lcom/umeng/commonsdk/statistics/common/MLog;->e(Ljava/lang/String;)V

    goto :goto_0

    .line 142
    :catch_0
    move-exception v0

    goto :goto_0

    .line 128
    :cond_2
    new-instance v1, Lorg/json/JSONObject;

    invoke-direct {v1}, Lorg/json/JSONObject;-><init>()V

    .line 129
    const-string v0, "id"

    invoke-virtual {v1, v0, p1}, Lorg/json/JSONObject;->put(Ljava/lang/String;Ljava/lang/Object;)Lorg/json/JSONObject;

    .line 130
    const-string v0, "ts"

    invoke-static {}, Ljava/lang/System;->currentTimeMillis()J

    move-result-wide v2

    invoke-virtual {v1, v0, v2, v3}, Lorg/json/JSONObject;->put(Ljava/lang/String;J)Lorg/json/JSONObject;

    .line 131
    const-wide/16 v2, 0x0

    cmp-long v0, p3, v2

    if-lez v0, :cond_3

    .line 132
    const-string v0, "du"

    invoke-virtual {v1, v0, p3, p4}, Lorg/json/JSONObject;->put(Ljava/lang/String;J)Lorg/json/JSONObject;

    .line 134
    :cond_3
    const-string v0, "__t"

    const/16 v2, 0x801

    invoke-virtual {v1, v0, v2}, Lorg/json/JSONObject;->put(Ljava/lang/String;I)Lorg/json/JSONObject;

    .line 135
    if-nez p2, :cond_4

    const-string p2, ""

    :cond_4
    invoke-virtual {v1, p1, p2}, Lorg/json/JSONObject;->put(Ljava/lang/String;Ljava/lang/Object;)Lorg/json/JSONObject;

    .line 137
    invoke-static {}, Lcom/umeng/analytics/pro/o;->a()Lcom/umeng/analytics/pro/o;

    move-result-object v0

    invoke-virtual {v0}, Lcom/umeng/analytics/pro/o;->c()Ljava/lang/String;

    move-result-object v0

    .line 138
    const-string v2, "__i"

    invoke-static {v0}, Landroid/text/TextUtils;->isEmpty(Ljava/lang/CharSequence;)Z

    move-result v3

    if-eqz v3, :cond_5

    const-string v0, "-1"

    :cond_5
    invoke-virtual {v1, v2, v0}, Lorg/json/JSONObject;->put(Ljava/lang/String;Ljava/lang/Object;)Lorg/json/JSONObject;

    .line 140
    sget-object v0, Lcom/umeng/analytics/pro/m;->f:Landroid/content/Context;

    const/16 v2, 0x1001

    sget-object v3, Lcom/umeng/analytics/pro/m;->f:Landroid/content/Context;

    .line 141
    invoke-static {v3}, Lcom/umeng/analytics/CoreProtocol;->getInstance(Landroid/content/Context;)Lcom/umeng/analytics/CoreProtocol;

    move-result-object v3

    .line 140
    invoke-static {v0, v2, v3, v1}, Lcom/umeng/commonsdk/framework/UMWorkDispatch;->sendEvent(Landroid/content/Context;ILcom/umeng/commonsdk/framework/UMLogDataProtocol;Ljava/lang/Object;)V
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_0

    goto :goto_0
.end method

.method public a(Ljava/lang/String;Ljava/util/Map;)V
    .locals 6
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "(",
            "Ljava/lang/String;",
            "Ljava/util/Map",
            "<",
            "Ljava/lang/String;",
            "Ljava/lang/Object;",
            ">;)V"
        }
    .end annotation

    .prologue
    const/4 v0, 0x0

    .line 242
    :try_start_0
    invoke-direct {p0, p1}, Lcom/umeng/analytics/pro/m;->a(Ljava/lang/String;)Z

    move-result v1

    if-nez v1, :cond_0

    .line 279
    :goto_0
    return-void

    .line 245
    :cond_0
    new-instance v2, Lorg/json/JSONObject;

    invoke-direct {v2}, Lorg/json/JSONObject;-><init>()V

    .line 246
    const-string v1, "id"

    invoke-virtual {v2, v1, p1}, Lorg/json/JSONObject;->put(Ljava/lang/String;Ljava/lang/Object;)Lorg/json/JSONObject;

    .line 247
    const-string v1, "ts"

    invoke-static {}, Ljava/lang/System;->currentTimeMillis()J

    move-result-wide v4

    invoke-virtual {v2, v1, v4, v5}, Lorg/json/JSONObject;->put(Ljava/lang/String;J)Lorg/json/JSONObject;

    .line 248
    const-string v1, "du"

    const/4 v3, 0x0

    invoke-virtual {v2, v1, v3}, Lorg/json/JSONObject;->put(Ljava/lang/String;I)Lorg/json/JSONObject;

    .line 249
    const-string v1, "__t"

    const/16 v3, 0x802

    invoke-virtual {v2, v1, v3}, Lorg/json/JSONObject;->put(Ljava/lang/String;I)Lorg/json/JSONObject;

    .line 251
    invoke-interface {p2}, Ljava/util/Map;->entrySet()Ljava/util/Set;

    move-result-object v1

    invoke-interface {v1}, Ljava/util/Set;->iterator()Ljava/util/Iterator;

    move-result-object v3

    move v1, v0

    .line 255
    :goto_1
    const/16 v0, 0xa

    if-ge v1, v0, :cond_3

    invoke-interface {v3}, Ljava/util/Iterator;->hasNext()Z

    move-result v0

    if-eqz v0, :cond_3

    .line 256
    invoke-interface {v3}, Ljava/util/Iterator;->next()Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Ljava/util/Map$Entry;

    .line 257
    const-string v4, "$st_fl"

    invoke-interface {v0}, Ljava/util/Map$Entry;->getKey()Ljava/lang/Object;

    move-result-object v5

    invoke-virtual {v4, v5}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v4

    if-nez v4, :cond_2

    const-string v4, "du"

    .line 258
    invoke-interface {v0}, Ljava/util/Map$Entry;->getKey()Ljava/lang/Object;

    move-result-object v5

    invoke-virtual {v4, v5}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v4

    if-nez v4, :cond_2

    const-string v4, "id"

    .line 259
    invoke-interface {v0}, Ljava/util/Map$Entry;->getKey()Ljava/lang/Object;

    move-result-object v5

    invoke-virtual {v4, v5}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v4

    if-nez v4, :cond_2

    const-string v4, "ts"

    .line 260
    invoke-interface {v0}, Ljava/util/Map$Entry;->getKey()Ljava/lang/Object;

    move-result-object v5

    invoke-virtual {v4, v5}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v4

    if-nez v4, :cond_2

    .line 261
    invoke-interface {v0}, Ljava/util/Map$Entry;->getValue()Ljava/lang/Object;

    move-result-object v4

    .line 262
    instance-of v5, v4, Ljava/lang/String;

    if-nez v5, :cond_1

    instance-of v5, v4, Ljava/lang/Integer;

    if-nez v5, :cond_1

    instance-of v5, v4, Ljava/lang/Long;

    if-eqz v5, :cond_2

    .line 263
    :cond_1
    invoke-interface {v0}, Ljava/util/Map$Entry;->getKey()Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Ljava/lang/String;

    invoke-virtual {v2, v0, v4}, Lorg/json/JSONObject;->put(Ljava/lang/String;Ljava/lang/Object;)Lorg/json/JSONObject;

    .line 266
    :cond_2
    add-int/lit8 v0, v1, 0x1

    move v1, v0

    goto :goto_1

    .line 268
    :cond_3
    invoke-static {}, Lcom/umeng/analytics/pro/o;->a()Lcom/umeng/analytics/pro/o;

    move-result-object v0

    invoke-virtual {v0}, Lcom/umeng/analytics/pro/o;->c()Ljava/lang/String;

    move-result-object v0

    .line 269
    const-string v1, "__i"

    invoke-static {v0}, Landroid/text/TextUtils;->isEmpty(Ljava/lang/CharSequence;)Z

    move-result v3

    if-eqz v3, :cond_4

    const-string v0, "-1"

    :cond_4
    invoke-virtual {v2, v1, v0}, Lorg/json/JSONObject;->put(Ljava/lang/String;Ljava/lang/Object;)Lorg/json/JSONObject;

    .line 271
    sget-object v0, Lcom/umeng/analytics/pro/m;->f:Landroid/content/Context;

    const/16 v1, 0x1002

    sget-object v3, Lcom/umeng/analytics/pro/m;->f:Landroid/content/Context;

    .line 272
    invoke-static {v3}, Lcom/umeng/analytics/CoreProtocol;->getInstance(Landroid/content/Context;)Lcom/umeng/analytics/CoreProtocol;

    move-result-object v3

    .line 271
    invoke-static {v0, v1, v3, v2}, Lcom/umeng/commonsdk/framework/UMWorkDispatch;->sendEvent(Landroid/content/Context;ILcom/umeng/commonsdk/framework/UMLogDataProtocol;Ljava/lang/Object;)V
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_0

    goto/16 :goto_0

    .line 274
    :catch_0
    move-exception v0

    goto/16 :goto_0
.end method

.method public a(Ljava/lang/String;Ljava/util/Map;J)V
    .locals 7
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "(",
            "Ljava/lang/String;",
            "Ljava/util/Map",
            "<",
            "Ljava/lang/String;",
            "Ljava/lang/Object;",
            ">;J)V"
        }
    .end annotation

    .prologue
    .line 75
    :try_start_0
    invoke-direct {p0, p1}, Lcom/umeng/analytics/pro/m;->a(Ljava/lang/String;)Z

    move-result v0

    if-nez v0, :cond_1

    .line 116
    :cond_0
    :goto_0
    return-void

    .line 78
    :cond_1
    invoke-direct {p0, p2}, Lcom/umeng/analytics/pro/m;->b(Ljava/util/Map;)Z

    move-result v0

    if-eqz v0, :cond_0

    .line 81
    sget-object v0, Lcom/umeng/analytics/pro/b;->ap:[Ljava/lang/String;

    invoke-static {v0}, Ljava/util/Arrays;->asList([Ljava/lang/Object;)Ljava/util/List;

    move-result-object v0

    invoke-interface {v0, p1}, Ljava/util/List;->contains(Ljava/lang/Object;)Z

    move-result v0

    if-eqz v0, :cond_2

    .line 82
    const-string v0, "the id is valid!"

    invoke-static {v0}, Lcom/umeng/commonsdk/statistics/common/MLog;->e(Ljava/lang/String;)V

    goto :goto_0

    .line 114
    :catch_0
    move-exception v0

    goto :goto_0

    .line 86
    :cond_2
    new-instance v2, Lorg/json/JSONObject;

    invoke-direct {v2}, Lorg/json/JSONObject;-><init>()V

    .line 87
    const-string v0, "id"

    invoke-virtual {v2, v0, p1}, Lorg/json/JSONObject;->put(Ljava/lang/String;Ljava/lang/Object;)Lorg/json/JSONObject;

    .line 88
    const-string v0, "ts"

    invoke-static {}, Ljava/lang/System;->currentTimeMillis()J

    move-result-wide v4

    invoke-virtual {v2, v0, v4, v5}, Lorg/json/JSONObject;->put(Ljava/lang/String;J)Lorg/json/JSONObject;

    .line 89
    const-wide/16 v0, 0x0

    cmp-long v0, p3, v0

    if-lez v0, :cond_3

    .line 90
    const-string v0, "du"

    invoke-virtual {v2, v0, p3, p4}, Lorg/json/JSONObject;->put(Ljava/lang/String;J)Lorg/json/JSONObject;

    .line 92
    :cond_3
    const-string v0, "__t"

    const/16 v1, 0x801

    invoke-virtual {v2, v0, v1}, Lorg/json/JSONObject;->put(Ljava/lang/String;I)Lorg/json/JSONObject;

    .line 93
    invoke-interface {p2}, Ljava/util/Map;->entrySet()Ljava/util/Set;

    move-result-object v0

    invoke-interface {v0}, Ljava/util/Set;->iterator()Ljava/util/Iterator;

    move-result-object v3

    .line 95
    const/4 v0, 0x0

    move v1, v0

    .line 97
    :goto_1
    const/16 v0, 0xa

    if-ge v1, v0, :cond_7

    invoke-interface {v3}, Ljava/util/Iterator;->hasNext()Z

    move-result v0

    if-eqz v0, :cond_7

    .line 98
    invoke-interface {v3}, Ljava/util/Iterator;->next()Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Ljava/util/Map$Entry;

    .line 99
    sget-object v4, Lcom/umeng/analytics/pro/b;->ap:[Ljava/lang/String;

    invoke-static {v4}, Ljava/util/Arrays;->asList([Ljava/lang/Object;)Ljava/util/List;

    move-result-object v4

    invoke-interface {v0}, Ljava/util/Map$Entry;->getKey()Ljava/lang/Object;

    move-result-object v5

    invoke-interface {v4, v5}, Ljava/util/List;->contains(Ljava/lang/Object;)Z

    move-result v4

    if-nez v4, :cond_6

    .line 100
    invoke-interface {v0}, Ljava/util/Map$Entry;->getValue()Ljava/lang/Object;

    move-result-object v4

    .line 101
    instance-of v5, v4, Ljava/lang/String;

    if-nez v5, :cond_4

    instance-of v5, v4, Ljava/lang/Integer;

    if-nez v5, :cond_4

    instance-of v5, v4, Ljava/lang/Long;

    if-eqz v5, :cond_5

    .line 102
    :cond_4
    invoke-interface {v0}, Ljava/util/Map$Entry;->getKey()Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Ljava/lang/String;

    invoke-virtual {v2, v0, v4}, Lorg/json/JSONObject;->put(Ljava/lang/String;Ljava/lang/Object;)Lorg/json/JSONObject;

    .line 107
    :cond_5
    :goto_2
    add-int/lit8 v0, v1, 0x1

    move v1, v0

    goto :goto_1

    .line 105
    :cond_6
    const-string v0, "the key in map is invalid.  "

    invoke-static {v0}, Lcom/umeng/commonsdk/statistics/common/MLog;->e(Ljava/lang/String;)V

    goto :goto_2

    .line 109
    :cond_7
    invoke-static {}, Lcom/umeng/analytics/pro/o;->a()Lcom/umeng/analytics/pro/o;

    move-result-object v0

    invoke-virtual {v0}, Lcom/umeng/analytics/pro/o;->c()Ljava/lang/String;

    move-result-object v0

    .line 110
    const-string v1, "__i"

    invoke-static {v0}, Landroid/text/TextUtils;->isEmpty(Ljava/lang/CharSequence;)Z

    move-result v3

    if-eqz v3, :cond_8

    const-string v0, "-1"

    :cond_8
    invoke-virtual {v2, v1, v0}, Lorg/json/JSONObject;->put(Ljava/lang/String;Ljava/lang/Object;)Lorg/json/JSONObject;

    .line 111
    sget-object v0, Lcom/umeng/analytics/pro/m;->f:Landroid/content/Context;

    const/16 v1, 0x1001

    sget-object v3, Lcom/umeng/analytics/pro/m;->f:Landroid/content/Context;

    .line 112
    invoke-static {v3}, Lcom/umeng/analytics/CoreProtocol;->getInstance(Landroid/content/Context;)Lcom/umeng/analytics/CoreProtocol;

    move-result-object v3

    .line 111
    invoke-static {v0, v1, v3, v2}, Lcom/umeng/commonsdk/framework/UMWorkDispatch;->sendEvent(Landroid/content/Context;ILcom/umeng/commonsdk/framework/UMLogDataProtocol;Ljava/lang/Object;)V
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_0

    goto/16 :goto_0
.end method

.method public a(Ljava/util/List;)V
    .locals 5
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "(",
            "Ljava/util/List",
            "<",
            "Ljava/lang/String;",
            ">;)V"
        }
    .end annotation

    .prologue
    const/4 v4, 0x5

    const/4 v0, 0x0

    .line 404
    if-eqz p1, :cond_0

    :try_start_0
    invoke-interface {p1}, Ljava/util/List;->size()I

    move-result v1

    if-gtz v1, :cond_1

    .line 454
    :cond_0
    :goto_0
    return-void

    .line 407
    :cond_1
    invoke-direct {p0}, Lcom/umeng/analytics/pro/m;->a()V

    .line 409
    iget-object v1, p0, Lcom/umeng/analytics/pro/m;->g:Lorg/json/JSONObject;

    if-nez v1, :cond_6

    .line 410
    new-instance v1, Lorg/json/JSONObject;

    invoke-direct {v1}, Lorg/json/JSONObject;-><init>()V

    iput-object v1, p0, Lcom/umeng/analytics/pro/m;->g:Lorg/json/JSONObject;

    .line 411
    invoke-interface {p1}, Ljava/util/List;->size()I

    move-result v2

    move v1, v0

    .line 412
    :goto_1
    if-ge v1, v2, :cond_5

    .line 414
    iget-object v0, p0, Lcom/umeng/analytics/pro/m;->g:Lorg/json/JSONObject;

    if-nez v0, :cond_4

    .line 415
    new-instance v0, Lorg/json/JSONObject;

    invoke-direct {v0}, Lorg/json/JSONObject;-><init>()V

    iput-object v0, p0, Lcom/umeng/analytics/pro/m;->g:Lorg/json/JSONObject;

    .line 422
    :cond_2
    invoke-interface {p1, v1}, Ljava/util/List;->get(I)Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Ljava/lang/String;

    .line 423
    invoke-static {v0}, Landroid/text/TextUtils;->isEmpty(Ljava/lang/CharSequence;)Z

    move-result v3

    if-nez v3, :cond_3

    .line 424
    const/16 v3, 0x80

    invoke-static {v0, v3}, Lcom/umeng/commonsdk/statistics/common/HelperUtils;->subStr(Ljava/lang/String;I)Ljava/lang/String;

    move-result-object v0

    .line 425
    const/4 v3, 0x0

    invoke-direct {p0, v0, v3}, Lcom/umeng/analytics/pro/m;->a(Ljava/lang/String;Z)V

    .line 412
    :cond_3
    add-int/lit8 v0, v1, 0x1

    move v1, v0

    goto :goto_1

    .line 417
    :cond_4
    iget-object v0, p0, Lcom/umeng/analytics/pro/m;->g:Lorg/json/JSONObject;

    invoke-virtual {v0}, Lorg/json/JSONObject;->length()I

    move-result v0

    if-lt v0, v4, :cond_2

    .line 428
    :cond_5
    sget-object v0, Lcom/umeng/analytics/pro/m;->f:Landroid/content/Context;

    invoke-direct {p0, v0}, Lcom/umeng/analytics/pro/m;->c(Landroid/content/Context;)V

    goto :goto_0

    .line 449
    :catch_0
    move-exception v0

    goto :goto_0

    .line 430
    :cond_6
    iget-object v1, p0, Lcom/umeng/analytics/pro/m;->g:Lorg/json/JSONObject;

    invoke-virtual {v1}, Lorg/json/JSONObject;->length()I

    move-result v1

    if-lt v1, v4, :cond_7

    .line 431
    const-string v0, "already setFistLaunchEvent, igone."

    invoke-static {v0}, Lcom/umeng/commonsdk/statistics/common/MLog;->d(Ljava/lang/String;)V

    goto :goto_0

    :cond_7
    move v1, v0

    .line 434
    :goto_2
    invoke-interface {p1}, Ljava/util/List;->size()I

    move-result v0

    if-ge v1, v0, :cond_9

    .line 435
    iget-object v0, p0, Lcom/umeng/analytics/pro/m;->g:Lorg/json/JSONObject;

    invoke-virtual {v0}, Lorg/json/JSONObject;->length()I

    move-result v0

    if-lt v0, v4, :cond_8

    .line 436
    const-string v0, " add setFistLaunchEvent over."

    invoke-static {v0}, Lcom/umeng/commonsdk/statistics/common/MLog;->d(Ljava/lang/String;)V

    goto :goto_0

    .line 439
    :cond_8
    invoke-interface {p1, v1}, Ljava/util/List;->get(I)Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Ljava/lang/String;

    const/16 v2, 0x80

    invoke-static {v0, v2}, Lcom/umeng/commonsdk/statistics/common/HelperUtils;->subStr(Ljava/lang/String;I)Ljava/lang/String;

    move-result-object v0

    .line 440
    const/4 v2, 0x0

    invoke-direct {p0, v0, v2}, Lcom/umeng/analytics/pro/m;->a(Ljava/lang/String;Z)V

    .line 434
    add-int/lit8 v0, v1, 0x1

    move v1, v0

    goto :goto_2

    .line 443
    :cond_9
    sget-object v0, Lcom/umeng/analytics/pro/m;->f:Landroid/content/Context;

    invoke-direct {p0, v0}, Lcom/umeng/analytics/pro/m;->c(Landroid/content/Context;)V
    :try_end_0
    .catch Ljava/lang/Exception; {:try_start_0 .. :try_end_0} :catch_0

    goto/16 :goto_0
.end method
