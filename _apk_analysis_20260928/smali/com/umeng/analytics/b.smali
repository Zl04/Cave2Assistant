.class public Lcom/umeng/analytics/b;
.super Ljava/lang/Object;
.source "InternalAgent.java"

# interfaces
.implements Lcom/umeng/analytics/pro/n;


# annotations
.annotation system Ldalvik/annotation/MemberClasses;
    value = {
        Lcom/umeng/analytics/b$a;
    }
.end annotation


# static fields
.field private static final g:Ljava/lang/String; = "sp"


# instance fields
.field private a:Landroid/content/Context;

.field private b:Lcom/umeng/analytics/pro/r;

.field private c:Lcom/umeng/analytics/pro/j;

.field private d:Lcom/umeng/analytics/pro/p;

.field private e:Lcom/umeng/analytics/pro/o;

.field private f:Lcom/umeng/analytics/pro/h;

.field private h:Z

.field private volatile i:Lorg/json/JSONObject;

.field private volatile j:Lorg/json/JSONObject;

.field private k:Z


# direct methods
.method private constructor <init>()V
    .locals 3

    .prologue
    const/4 v2, 0x0

    const/4 v1, 0x0

    .line 59
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    .line 46
    iput-object v1, p0, Lcom/umeng/analytics/b;->a:Landroid/content/Context;

    .line 49
    new-instance v0, Lcom/umeng/analytics/pro/j;

    invoke-direct {v0}, Lcom/umeng/analytics/pro/j;-><init>()V

    iput-object v0, p0, Lcom/umeng/analytics/b;->c:Lcom/umeng/analytics/pro/j;

    .line 50
    new-instance v0, Lcom/umeng/analytics/pro/p;

    invoke-direct {v0}, Lcom/umeng/analytics/pro/p;-><init>()V

    iput-object v0, p0, Lcom/umeng/analytics/b;->d:Lcom/umeng/analytics/pro/p;

    .line 51
    invoke-static {}, Lcom/umeng/analytics/pro/o;->a()Lcom/umeng/analytics/pro/o;

    move-result-object v0

    iput-object v0, p0, Lcom/umeng/analytics/b;->e:Lcom/umeng/analytics/pro/o;

    .line 52
    iput-object v1, p0, Lcom/umeng/analytics/b;->f:Lcom/umeng/analytics/pro/h;

    .line 54
    iput-boolean v2, p0, Lcom/umeng/analytics/b;->h:Z

    .line 55
    iput-object v1, p0, Lcom/umeng/analytics/b;->i:Lorg/json/JSONObject;

    .line 56
    iput-object v1, p0, Lcom/umeng/analytics/b;->j:Lorg/json/JSONObject;

    .line 57
    iput-boolean v2, p0, Lcom/umeng/analytics/b;->k:Z

    .line 60
    iget-object v0, p0, Lcom/umeng/analytics/b;->c:Lcom/umeng/analytics/pro/j;

    invoke-virtual {v0, p0}, Lcom/umeng/analytics/pro/j;->a(Lcom/umeng/analytics/pro/n;)V

    .line 61
    return-void
.end method

.method synthetic constructor <init>(Lcom/umeng/analytics/b$1;)V
    .locals 0

    .prologue
    .line 45
    invoke-direct {p0}, Lcom/umeng/analytics/b;-><init>()V

    return-void
.end method

.method public static a()Lcom/umeng/analytics/b;
    .locals 1

    .prologue
    .line 68
    invoke-static {}, Lcom/umeng/analytics/b$a;->a()Lcom/umeng/analytics/b;

    move-result-object v0

    return-object v0
.end method

.method private a(Ljava/lang/String;Ljava/lang/Object;)V
    .locals 4

    .prologue
    const/4 v0, 0x0

    .line 597
    :try_start_0
    iget-object v1, p0, Lcom/umeng/analytics/b;->i:Lorg/json/JSONObject;

    if-nez v1, :cond_0

    .line 598
    new-instance v1, Lorg/json/JSONObject;

    invoke-direct {v1}, Lorg/json/JSONObject;-><init>()V

    iput-object v1, p0, Lcom/umeng/analytics/b;->i:Lorg/json/JSONObject;

    .line 601
    :cond_0
    new-instance v1, Lorg/json/JSONObject;

    invoke-direct {v1}, Lorg/json/JSONObject;-><init>()V

    .line 603
    invoke-virtual {p2}, Ljava/lang/Object;->getClass()Ljava/lang/Class;

    move-result-object v1

    invoke-virtual {v1}, Ljava/lang/Class;->isArray()Z

    move-result v1

    if-eqz v1, :cond_d

    .line 604
    instance-of v1, p2, [Ljava/lang/String;

    if-eqz v1, :cond_3

    .line 606
    check-cast p2, [Ljava/lang/String;

    check-cast p2, [Ljava/lang/String;

    .line 607
    new-instance v1, Lorg/json/JSONArray;

    invoke-direct {v1}, Lorg/json/JSONArray;-><init>()V

    .line 608
    :goto_0
    array-length v2, p2

    if-ge v0, v2, :cond_1

    .line 609
    aget-object v2, p2, v0

    invoke-virtual {v1, v2}, Lorg/json/JSONArray;->put(Ljava/lang/Object;)Lorg/json/JSONArray;

    .line 608
    add-int/lit8 v0, v0, 0x1

    goto :goto_0

    .line 611
    :cond_1
    iget-object v0, p0, Lcom/umeng/analytics/b;->i:Lorg/json/JSONObject;

    invoke-virtual {v0, p1, v1}, Lorg/json/JSONObject;->put(Ljava/lang/String;Ljava/lang/Object;)Lorg/json/JSONObject;

    .line 684
    :cond_2
    :goto_1
    return-void

    .line 612
    :cond_3
    instance-of v1, p2, [J

    if-eqz v1, :cond_5

    .line 613
    check-cast p2, [J

    check-cast p2, [J

    .line 614
    new-instance v1, Lorg/json/JSONArray;

    invoke-direct {v1}, Lorg/json/JSONArray;-><init>()V

    .line 615
    :goto_2
    array-length v2, p2

    if-ge v0, v2, :cond_4

    .line 616
    aget-wide v2, p2, v0

    invoke-virtual {v1, v2, v3}, Lorg/json/JSONArray;->put(J)Lorg/json/JSONArray;

    .line 615
    add-int/lit8 v0, v0, 0x1

    goto :goto_2

    .line 618
    :cond_4
    iget-object v0, p0, Lcom/umeng/analytics/b;->i:Lorg/json/JSONObject;

    invoke-virtual {v0, p1, v1}, Lorg/json/JSONObject;->put(Ljava/lang/String;Ljava/lang/Object;)Lorg/json/JSONObject;

    goto :goto_1

    .line 681
    :catch_0
    move-exception v0

    goto :goto_1

    .line 619
    :cond_5
    instance-of v1, p2, [I

    if-eqz v1, :cond_7

    .line 620
    check-cast p2, [I

    check-cast p2, [I

    .line 621
    new-instance v1, Lorg/json/JSONArray;

    invoke-direct {v1}, Lorg/json/JSONArray;-><init>()V

    .line 622
    :goto_3
    array-length v2, p2

    if-ge v0, v2, :cond_6

    .line 623
    aget v2, p2, v0

    invoke-virtual {v1, v2}, Lorg/json/JSONArray;->put(I)Lorg/json/JSONArray;

    .line 622
    add-int/lit8 v0, v0, 0x1

    goto :goto_3

    .line 625
    :cond_6
    iget-object v0, p0, Lcom/umeng/analytics/b;->i:Lorg/json/JSONObject;

    invoke-virtual {v0, p1, v1}, Lorg/json/JSONObject;->put(Ljava/lang/String;Ljava/lang/Object;)Lorg/json/JSONObject;

    goto :goto_1

    .line 626
    :cond_7
    instance-of v1, p2, [F

    if-eqz v1, :cond_9

    .line 627
    check-cast p2, [F

    check-cast p2, [F

    .line 628
    new-instance v1, Lorg/json/JSONArray;

    invoke-direct {v1}, Lorg/json/JSONArray;-><init>()V

    .line 629
    :goto_4
    array-length v2, p2

    if-ge v0, v2, :cond_8

    .line 630
    aget v2, p2, v0

    float-to-double v2, v2

    invoke-virtual {v1, v2, v3}, Lorg/json/JSONArray;->put(D)Lorg/json/JSONArray;

    .line 629
    add-int/lit8 v0, v0, 0x1

    goto :goto_4

    .line 632
    :cond_8
    iget-object v0, p0, Lcom/umeng/analytics/b;->i:Lorg/json/JSONObject;

    invoke-virtual {v0, p1, v1}, Lorg/json/JSONObject;->put(Ljava/lang/String;Ljava/lang/Object;)Lorg/json/JSONObject;

    goto :goto_1

    .line 633
    :cond_9
    instance-of v1, p2, [D

    if-eqz v1, :cond_b

    .line 634
    check-cast p2, [D

    check-cast p2, [D

    .line 635
    new-instance v1, Lorg/json/JSONArray;

    invoke-direct {v1}, Lorg/json/JSONArray;-><init>()V

    .line 636
    :goto_5
    array-length v2, p2

    if-ge v0, v2, :cond_a

    .line 637
    aget-wide v2, p2, v0

    invoke-virtual {v1, v2, v3}, Lorg/json/JSONArray;->put(D)Lorg/json/JSONArray;

    .line 636
    add-int/lit8 v0, v0, 0x1

    goto :goto_5

    .line 639
    :cond_a
    iget-object v0, p0, Lcom/umeng/analytics/b;->i:Lorg/json/JSONObject;

    invoke-virtual {v0, p1, v1}, Lorg/json/JSONObject;->put(Ljava/lang/String;Ljava/lang/Object;)Lorg/json/JSONObject;

    goto :goto_1

    .line 640
    :cond_b
    instance-of v1, p2, [S

    if-eqz v1, :cond_2

    .line 641
    check-cast p2, [S

    check-cast p2, [S

    .line 642
    new-instance v1, Lorg/json/JSONArray;

    invoke-direct {v1}, Lorg/json/JSONArray;-><init>()V

    .line 643
    :goto_6
    array-length v2, p2

    if-ge v0, v2, :cond_c

    .line 644
    aget-short v2, p2, v0

    invoke-virtual {v1, v2}, Lorg/json/JSONArray;->put(I)Lorg/json/JSONArray;

    .line 643
    add-int/lit8 v0, v0, 0x1

    goto :goto_6

    .line 646
    :cond_c
    iget-object v0, p0, Lcom/umeng/analytics/b;->i:Lorg/json/JSONObject;

    invoke-virtual {v0, p1, v1}, Lorg/json/JSONObject;->put(Ljava/lang/String;Ljava/lang/Object;)Lorg/json/JSONObject;

    goto/16 :goto_1

    .line 651
    :cond_d
    instance-of v1, p2, Ljava/util/List;

    if-eqz v1, :cond_11

    .line 652
    check-cast p2, Ljava/util/List;

    .line 653
    new-instance v1, Lorg/json/JSONArray;

    invoke-direct {v1}, Lorg/json/JSONArray;-><init>()V

    .line 655
    :goto_7
    invoke-interface {p2}, Ljava/util/List;->size()I

    move-result v2

    if-ge v0, v2, :cond_10

    .line 656
    invoke-interface {p2, v0}, Ljava/util/List;->get(I)Ljava/lang/Object;

    move-result-object v2

    .line 657
    instance-of v3, v2, Ljava/lang/String;

    if-nez v3, :cond_e

    instance-of v3, v2, Ljava/lang/Long;

    if-nez v3, :cond_e

    instance-of v3, v2, Ljava/lang/Integer;

    if-nez v3, :cond_e

    instance-of v3, v2, Ljava/lang/Float;

    if-nez v3, :cond_e

    instance-of v3, v2, Ljava/lang/Double;

    if-nez v3, :cond_e

    instance-of v2, v2, Ljava/lang/Short;

    if-eqz v2, :cond_f

    .line 664
    :cond_e
    invoke-interface {p2, v0}, Ljava/util/List;->get(I)Ljava/lang/Object;

    move-result-object v2

    invoke-virtual {v1, v2}, Lorg/json/JSONArray;->put(Ljava/lang/Object;)Lorg/json/JSONArray;

    .line 655
    :cond_f
    add-int/lit8 v0, v0, 0x1

    goto :goto_7

    .line 667
    :cond_10
    iget-object v0, p0, Lcom/umeng/analytics/b;->i:Lorg/json/JSONObject;

    invoke-virtual {v0, p1, v1}, Lorg/json/JSONObject;->put(Ljava/lang/String;Ljava/lang/Object;)Lorg/json/JSONObject;

    goto/16 :goto_1

    .line 668
    :cond_11
    instance-of v0, p2, Ljava/lang/String;

    if-nez v0, :cond_12

    instance-of v0, p2, Ljava/lang/Long;

    if-nez v0, :cond_12

    instance-of v0, p2, Ljava/lang/Integer;

    if-nez v0, :cond_12

    instance-of v0, p2, Ljava/lang/Float;

    if-nez v0, :cond_12

    instance-of v0, p2, Ljava/lang/Double;

    if-nez v0, :cond_12

    instance-of v0, p2, Ljava/lang/Short;

    if-eqz v0, :cond_2

    .line 675
    :cond_12
    iget-object v0, p0, Lcom/umeng/analytics/b;->i:Lorg/json/JSONObject;

    invoke-virtual {v0, p1, p2}, Lorg/json/JSONObject;->put(Ljava/lang/String;Ljava/lang/Object;)Lorg/json/JSONObject;
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_0

    goto/16 :goto_1
.end method

.method private f(Landroid/content/Context;)Lorg/json/JSONObject;
    .locals 4

    .prologue
    const/4 v0, 0x0

    .line 823
    if-nez p1, :cond_1

    .line 824
    :try_start_0
    const-string v1, "unexpected null context in getNativeSuperProperties"

    invoke-static {v1}, Lcom/umeng/commonsdk/statistics/common/MLog;->e(Ljava/lang/String;)V

    .line 840
    :cond_0
    :goto_0
    return-object v0

    .line 827
    :cond_1
    iget-object v1, p0, Lcom/umeng/analytics/b;->a:Landroid/content/Context;

    if-nez v1, :cond_2

    .line 828
    iput-object p1, p0, Lcom/umeng/analytics/b;->a:Landroid/content/Context;

    .line 830
    :cond_2
    invoke-static {p1}, Lcom/umeng/commonsdk/statistics/internal/PreferenceWrapper;->getDefault(Landroid/content/Context;)Landroid/content/SharedPreferences;

    move-result-object v1

    .line 831
    const-string v2, "sp"

    const/4 v3, 0x0

    invoke-interface {v1, v2, v3}, Landroid/content/SharedPreferences;->getString(Ljava/lang/String;Ljava/lang/String;)Ljava/lang/String;

    move-result-object v2

    .line 833
    invoke-static {v2}, Landroid/text/TextUtils;->isEmpty(Ljava/lang/CharSequence;)Z

    move-result v1

    if-nez v1, :cond_0

    .line 834
    new-instance v1, Lorg/json/JSONObject;

    invoke-direct {v1, v2}, Lorg/json/JSONObject;-><init>(Ljava/lang/String;)V
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_0

    move-object v0, v1

    .line 835
    goto :goto_0

    .line 838
    :catch_0
    move-exception v1

    goto :goto_0
.end method


# virtual methods
.method a(DD)V
    .locals 3

    .prologue
    .line 474
    sget-object v0, Lcom/umeng/analytics/AnalyticsConfig;->a:[D

    if-nez v0, :cond_0

    .line 475
    const/4 v0, 0x2

    new-array v0, v0, [D

    sput-object v0, Lcom/umeng/analytics/AnalyticsConfig;->a:[D

    .line 478
    :cond_0
    sget-object v0, Lcom/umeng/analytics/AnalyticsConfig;->a:[D

    const/4 v1, 0x0

    aput-wide p1, v0, v1

    .line 479
    sget-object v0, Lcom/umeng/analytics/AnalyticsConfig;->a:[D

    const/4 v1, 0x1

    aput-wide p3, v0, v1

    .line 480
    return-void
.end method

.method a(J)V
    .locals 1

    .prologue
    .line 542
    sput-wide p1, Lcom/umeng/analytics/AnalyticsConfig;->kContinueSessionMillis:J

    .line 543
    return-void
.end method

.method a(Landroid/content/Context;)V
    .locals 2

    .prologue
    .line 155
    if-nez p1, :cond_0

    .line 156
    const-string v0, "unexpected null context in onResume"

    invoke-static {v0}, Lcom/umeng/commonsdk/statistics/common/MLog;->e(Ljava/lang/String;)V

    .line 174
    :goto_0
    return-void

    .line 159
    :cond_0
    iget-object v0, p0, Lcom/umeng/analytics/b;->a:Landroid/content/Context;

    if-nez v0, :cond_1

    .line 160
    iput-object p1, p0, Lcom/umeng/analytics/b;->a:Landroid/content/Context;

    .line 164
    :cond_1
    :try_start_0
    iget-boolean v0, p0, Lcom/umeng/analytics/b;->h:Z

    if-eqz v0, :cond_2

    iget-boolean v0, p0, Lcom/umeng/analytics/b;->k:Z

    if-nez v0, :cond_3

    .line 165
    :cond_2
    invoke-virtual {p0}, Lcom/umeng/analytics/b;->b()V

    .line 167
    :cond_3
    sget-boolean v0, Lcom/umeng/analytics/AnalyticsConfig;->ACTIVITY_DURATION_OPEN:Z

    if-eqz v0, :cond_4

    .line 168
    iget-object v0, p0, Lcom/umeng/analytics/b;->d:Lcom/umeng/analytics/pro/p;

    invoke-virtual {p1}, Ljava/lang/Object;->getClass()Ljava/lang/Class;

    move-result-object v1

    invoke-virtual {v1}, Ljava/lang/Class;->getName()Ljava/lang/String;

    move-result-object v1

    invoke-virtual {v0, v1}, Lcom/umeng/analytics/pro/p;->a(Ljava/lang/String;)V

    .line 170
    :cond_4
    invoke-virtual {p0}, Lcom/umeng/analytics/b;->e()V
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_0

    goto :goto_0

    .line 171
    :catch_0
    move-exception v0

    .line 172
    const-string v1, "Exception occurred in Mobclick.onResume(). "

    invoke-static {v1, v0}, Lcom/umeng/commonsdk/statistics/common/MLog;->e(Ljava/lang/String;Ljava/lang/Throwable;)V

    goto :goto_0
.end method

.method public a(Landroid/content/Context;I)V
    .locals 1

    .prologue
    .line 141
    if-nez p1, :cond_0

    .line 142
    const-string v0, "unexpected null context in setVerticalType"

    invoke-static {v0}, Lcom/umeng/commonsdk/statistics/common/MLog;->e(Ljava/lang/String;)V

    .line 152
    :goto_0
    return-void

    .line 145
    :cond_0
    iget-object v0, p0, Lcom/umeng/analytics/b;->a:Landroid/content/Context;

    if-nez v0, :cond_1

    .line 146
    iput-object p1, p0, Lcom/umeng/analytics/b;->a:Landroid/content/Context;

    .line 148
    :cond_1
    iget-boolean v0, p0, Lcom/umeng/analytics/b;->h:Z

    if-eqz v0, :cond_2

    iget-boolean v0, p0, Lcom/umeng/analytics/b;->k:Z

    if-nez v0, :cond_3

    .line 149
    :cond_2
    invoke-virtual {p0}, Lcom/umeng/analytics/b;->b()V

    .line 151
    :cond_3
    iget-object v0, p0, Lcom/umeng/analytics/b;->a:Landroid/content/Context;

    invoke-static {v0, p2}, Lcom/umeng/analytics/AnalyticsConfig;->a(Landroid/content/Context;I)V

    goto :goto_0
.end method

.method a(Landroid/content/Context;Lcom/umeng/analytics/MobclickAgent$EScenarioType;)V
    .locals 3

    .prologue
    const/4 v2, 0x1

    .line 489
    if-nez p1, :cond_1

    .line 490
    const-string v0, "unexpected null context in setScenarioType"

    invoke-static {v0}, Lcom/umeng/commonsdk/statistics/common/MLog;->e(Ljava/lang/String;)V

    .line 514
    :cond_0
    :goto_0
    return-void

    .line 493
    :cond_1
    iget-object v0, p0, Lcom/umeng/analytics/b;->a:Landroid/content/Context;

    if-nez v0, :cond_2

    .line 494
    iput-object p1, p0, Lcom/umeng/analytics/b;->a:Landroid/content/Context;

    .line 496
    :cond_2
    if-eqz p2, :cond_3

    .line 497
    invoke-virtual {p2}, Lcom/umeng/analytics/MobclickAgent$EScenarioType;->toValue()I

    move-result v0

    .line 501
    sget-object v1, Lcom/umeng/analytics/MobclickAgent$EScenarioType;->E_DUM_NORMAL:Lcom/umeng/analytics/MobclickAgent$EScenarioType;

    invoke-virtual {v1}, Lcom/umeng/analytics/MobclickAgent$EScenarioType;->toValue()I

    move-result v1

    if-ne v0, v1, :cond_5

    .line 502
    sput-boolean v2, Lcom/umeng/analytics/AnalyticsConfig;->FLAG_DPLUS:Z

    .line 508
    :goto_1
    iget-object v1, p0, Lcom/umeng/analytics/b;->a:Landroid/content/Context;

    invoke-virtual {p0, v1, v0}, Lcom/umeng/analytics/b;->a(Landroid/content/Context;I)V

    .line 510
    :cond_3
    iget-boolean v0, p0, Lcom/umeng/analytics/b;->h:Z

    if-eqz v0, :cond_4

    iget-boolean v0, p0, Lcom/umeng/analytics/b;->k:Z

    if-nez v0, :cond_0

    .line 511
    :cond_4
    invoke-virtual {p0}, Lcom/umeng/analytics/b;->b()V

    goto :goto_0

    .line 503
    :cond_5
    sget-object v1, Lcom/umeng/analytics/MobclickAgent$EScenarioType;->E_DUM_GAME:Lcom/umeng/analytics/MobclickAgent$EScenarioType;

    invoke-virtual {v1}, Lcom/umeng/analytics/MobclickAgent$EScenarioType;->toValue()I

    move-result v1

    if-ne v0, v1, :cond_6

    .line 504
    sput-boolean v2, Lcom/umeng/analytics/AnalyticsConfig;->FLAG_DPLUS:Z

    goto :goto_1

    .line 506
    :cond_6
    const/4 v1, 0x0

    sput-boolean v1, Lcom/umeng/analytics/AnalyticsConfig;->FLAG_DPLUS:Z

    goto :goto_1
.end method

.method a(Landroid/content/Context;Ljava/lang/String;)V
    .locals 4

    .prologue
    .line 219
    invoke-static {p2}, Landroid/text/TextUtils;->isEmpty(Ljava/lang/CharSequence;)Z

    move-result v0

    if-eqz v0, :cond_1

    .line 247
    :cond_0
    :goto_0
    return-void

    .line 223
    :cond_1
    if-nez p1, :cond_2

    .line 224
    const-string v0, "unexpected null context in reportError"

    invoke-static {v0}, Lcom/umeng/commonsdk/statistics/common/MLog;->e(Ljava/lang/String;)V

    goto :goto_0

    .line 227
    :cond_2
    iget-object v0, p0, Lcom/umeng/analytics/b;->a:Landroid/content/Context;

    if-nez v0, :cond_3

    .line 228
    iput-object p1, p0, Lcom/umeng/analytics/b;->a:Landroid/content/Context;

    .line 231
    :cond_3
    :try_start_0
    iget-boolean v0, p0, Lcom/umeng/analytics/b;->h:Z

    if-eqz v0, :cond_4

    iget-boolean v0, p0, Lcom/umeng/analytics/b;->k:Z

    if-nez v0, :cond_5

    .line 232
    :cond_4
    invoke-virtual {p0}, Lcom/umeng/analytics/b;->b()V

    .line 234
    :cond_5
    new-instance v0, Lorg/json/JSONObject;

    invoke-direct {v0}, Lorg/json/JSONObject;-><init>()V

    .line 235
    const-string v1, "ts"

    invoke-static {}, Ljava/lang/System;->currentTimeMillis()J

    move-result-wide v2

    invoke-virtual {v0, v1, v2, v3}, Lorg/json/JSONObject;->put(Ljava/lang/String;J)Lorg/json/JSONObject;

    .line 236
    const-string v1, "error_source"

    const/4 v2, 0x2

    invoke-virtual {v0, v1, v2}, Lorg/json/JSONObject;->put(Ljava/lang/String;I)Lorg/json/JSONObject;

    .line 237
    const-string v1, "context"

    invoke-virtual {v0, v1, p2}, Lorg/json/JSONObject;->put(Ljava/lang/String;Ljava/lang/Object;)Lorg/json/JSONObject;

    .line 238
    const-string v1, "__ii"

    iget-object v2, p0, Lcom/umeng/analytics/b;->e:Lcom/umeng/analytics/pro/o;

    invoke-virtual {v2}, Lcom/umeng/analytics/pro/o;->d()Ljava/lang/String;

    move-result-object v2

    invoke-virtual {v0, v1, v2}, Lorg/json/JSONObject;->put(Ljava/lang/String;Ljava/lang/Object;)Lorg/json/JSONObject;

    .line 239
    iget-object v1, p0, Lcom/umeng/analytics/b;->a:Landroid/content/Context;

    const/16 v2, 0x100a

    iget-object v3, p0, Lcom/umeng/analytics/b;->a:Landroid/content/Context;

    .line 241
    invoke-static {v3}, Lcom/umeng/analytics/CoreProtocol;->getInstance(Landroid/content/Context;)Lcom/umeng/analytics/CoreProtocol;

    move-result-object v3

    .line 239
    invoke-static {v1, v2, v3, v0}, Lcom/umeng/commonsdk/framework/UMWorkDispatch;->sendEvent(Landroid/content/Context;ILcom/umeng/commonsdk/framework/UMLogDataProtocol;Ljava/lang/Object;)V
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_0

    goto :goto_0

    .line 242
    :catch_0
    move-exception v0

    .line 243
    sget-boolean v1, Lcom/umeng/commonsdk/statistics/common/MLog;->DEBUG:Z

    if-eqz v1, :cond_0

    .line 244
    invoke-static {v0}, Lcom/umeng/commonsdk/statistics/common/MLog;->e(Ljava/lang/Throwable;)V

    goto :goto_0
.end method

.method public a(Landroid/content/Context;Ljava/lang/String;Ljava/lang/Object;)V
    .locals 4

    .prologue
    .line 558
    if-nez p1, :cond_0

    .line 559
    :try_start_0
    const-string v0, "unexpected null context in registerSuperProperty"

    invoke-static {v0}, Lcom/umeng/commonsdk/statistics/common/MLog;->e(Ljava/lang/String;)V

    .line 592
    :goto_0
    return-void

    .line 562
    :cond_0
    iget-object v0, p0, Lcom/umeng/analytics/b;->a:Landroid/content/Context;

    if-nez v0, :cond_1

    .line 563
    iput-object p1, p0, Lcom/umeng/analytics/b;->a:Landroid/content/Context;

    .line 565
    :cond_1
    iget-boolean v0, p0, Lcom/umeng/analytics/b;->h:Z

    if-eqz v0, :cond_2

    iget-boolean v0, p0, Lcom/umeng/analytics/b;->k:Z

    if-nez v0, :cond_3

    .line 566
    :cond_2
    invoke-virtual {p0}, Lcom/umeng/analytics/b;->b()V

    .line 568
    :cond_3
    invoke-static {p2}, Landroid/text/TextUtils;->isEmpty(Ljava/lang/CharSequence;)Z

    move-result v0

    if-nez v0, :cond_4

    if-nez p3, :cond_5

    .line 569
    :cond_4
    const-string v0, "please check key or value, must not NULL!"

    invoke-static {v0}, Lcom/umeng/commonsdk/statistics/common/MLog;->e(Ljava/lang/String;)V
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_0

    goto :goto_0

    .line 588
    :catch_0
    move-exception v0

    .line 589
    invoke-virtual {v0}, Ljava/lang/Throwable;->printStackTrace()V

    goto :goto_0

    .line 574
    :cond_5
    const/16 v0, 0x80

    :try_start_1
    invoke-static {p2, v0}, Lcom/umeng/commonsdk/statistics/common/HelperUtils;->subStr(Ljava/lang/String;I)Ljava/lang/String;

    move-result-object v0

    .line 576
    sget-object v1, Lcom/umeng/analytics/pro/b;->aq:[Ljava/lang/String;

    invoke-static {v1}, Ljava/util/Arrays;->asList([Ljava/lang/Object;)Ljava/util/List;

    move-result-object v1

    invoke-interface {v1, v0}, Ljava/util/List;->contains(Ljava/lang/Object;)Z

    move-result v1

    if-nez v1, :cond_7

    .line 577
    instance-of v1, p3, Ljava/lang/String;

    if-eqz v1, :cond_6

    .line 578
    invoke-virtual {p3}, Ljava/lang/Object;->toString()Ljava/lang/String;

    move-result-object v1

    const/16 v2, 0x100

    invoke-static {v1, v2}, Lcom/umeng/commonsdk/statistics/common/HelperUtils;->subStr(Ljava/lang/String;I)Ljava/lang/String;

    move-result-object p3

    .line 580
    :cond_6
    invoke-direct {p0, v0, p3}, Lcom/umeng/analytics/b;->a(Ljava/lang/String;Ljava/lang/Object;)V

    .line 581
    iget-object v0, p0, Lcom/umeng/analytics/b;->a:Landroid/content/Context;

    const/16 v1, 0x2003

    iget-object v2, p0, Lcom/umeng/analytics/b;->a:Landroid/content/Context;

    .line 583
    invoke-static {v2}, Lcom/umeng/analytics/CoreProtocol;->getInstance(Landroid/content/Context;)Lcom/umeng/analytics/CoreProtocol;

    move-result-object v2

    iget-object v3, p0, Lcom/umeng/analytics/b;->i:Lorg/json/JSONObject;

    invoke-virtual {v3}, Lorg/json/JSONObject;->toString()Ljava/lang/String;

    move-result-object v3

    .line 581
    invoke-static {v0, v1, v2, v3}, Lcom/umeng/commonsdk/framework/UMWorkDispatch;->sendEvent(Landroid/content/Context;ILcom/umeng/commonsdk/framework/UMLogDataProtocol;Ljava/lang/Object;)V

    goto :goto_0

    .line 585
    :cond_7
    const-string v0, "SuperProperty  key is invalid.  "

    invoke-static {v0}, Lcom/umeng/commonsdk/statistics/common/MLog;->e(Ljava/lang/String;)V
    :try_end_1
    .catch Ljava/lang/Throwable; {:try_start_1 .. :try_end_1} :catch_0

    goto :goto_0
.end method

.method public a(Landroid/content/Context;Ljava/lang/String;Ljava/lang/String;JI)V
    .locals 8

    .prologue
    .line 305
    if-eqz p1, :cond_0

    .line 306
    :try_start_0
    iput-object p1, p0, Lcom/umeng/analytics/b;->a:Landroid/content/Context;

    .line 308
    :cond_0
    iget-boolean v0, p0, Lcom/umeng/analytics/b;->h:Z

    if-eqz v0, :cond_1

    iget-boolean v0, p0, Lcom/umeng/analytics/b;->k:Z

    if-nez v0, :cond_2

    .line 309
    :cond_1
    invoke-virtual {p0}, Lcom/umeng/analytics/b;->b()V

    .line 311
    :cond_2
    iget-object v0, p0, Lcom/umeng/analytics/b;->a:Landroid/content/Context;

    invoke-static {v0}, Lcom/umeng/analytics/pro/m;->a(Landroid/content/Context;)Lcom/umeng/analytics/pro/m;

    move-result-object v1

    move-object v2, p2

    move-object v3, p3

    move-wide v4, p4

    move v6, p6

    invoke-virtual/range {v1 .. v6}, Lcom/umeng/analytics/pro/m;->a(Ljava/lang/String;Ljava/lang/String;JI)V
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_0

    .line 317
    :cond_3
    :goto_0
    return-void

    .line 312
    :catch_0
    move-exception v0

    .line 313
    sget-boolean v1, Lcom/umeng/commonsdk/statistics/common/MLog;->DEBUG:Z

    if-eqz v1, :cond_3

    .line 314
    invoke-static {v0}, Lcom/umeng/commonsdk/statistics/common/MLog;->e(Ljava/lang/Throwable;)V

    goto :goto_0
.end method

.method public a(Landroid/content/Context;Ljava/lang/String;Ljava/util/HashMap;)V
    .locals 2
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "(",
            "Landroid/content/Context;",
            "Ljava/lang/String;",
            "Ljava/util/HashMap",
            "<",
            "Ljava/lang/String;",
            "Ljava/lang/Object;",
            ">;)V"
        }
    .end annotation

    .prologue
    .line 202
    if-eqz p1, :cond_0

    .line 203
    :try_start_0
    iget-object v0, p0, Lcom/umeng/analytics/b;->a:Landroid/content/Context;

    if-nez v0, :cond_0

    .line 204
    iput-object p1, p0, Lcom/umeng/analytics/b;->a:Landroid/content/Context;

    .line 207
    :cond_0
    iget-boolean v0, p0, Lcom/umeng/analytics/b;->h:Z

    if-eqz v0, :cond_1

    iget-boolean v0, p0, Lcom/umeng/analytics/b;->k:Z

    if-nez v0, :cond_2

    .line 208
    :cond_1
    invoke-virtual {p0}, Lcom/umeng/analytics/b;->b()V

    .line 210
    :cond_2
    iget-object v0, p0, Lcom/umeng/analytics/b;->a:Landroid/content/Context;

    invoke-static {v0}, Lcom/umeng/analytics/pro/m;->a(Landroid/content/Context;)Lcom/umeng/analytics/pro/m;

    move-result-object v0

    invoke-virtual {v0, p2, p3}, Lcom/umeng/analytics/pro/m;->a(Ljava/lang/String;Ljava/util/Map;)V
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_0

    .line 216
    :cond_3
    :goto_0
    return-void

    .line 211
    :catch_0
    move-exception v0

    .line 212
    sget-boolean v1, Lcom/umeng/commonsdk/statistics/common/MLog;->DEBUG:Z

    if-eqz v1, :cond_3

    .line 213
    invoke-static {v0}, Lcom/umeng/commonsdk/statistics/common/MLog;->e(Ljava/lang/Throwable;)V

    goto :goto_0
.end method

.method public a(Landroid/content/Context;Ljava/lang/String;Ljava/util/Map;)V
    .locals 9
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "(",
            "Landroid/content/Context;",
            "Ljava/lang/String;",
            "Ljava/util/Map",
            "<",
            "Ljava/lang/String;",
            "Ljava/lang/Object;",
            ">;)V"
        }
    .end annotation

    .prologue
    .line 337
    if-eqz p1, :cond_0

    .line 338
    :try_start_0
    iget-object v0, p0, Lcom/umeng/analytics/b;->a:Landroid/content/Context;

    if-nez v0, :cond_0

    .line 339
    iput-object p1, p0, Lcom/umeng/analytics/b;->a:Landroid/content/Context;

    .line 342
    :cond_0
    iget-boolean v0, p0, Lcom/umeng/analytics/b;->h:Z

    if-eqz v0, :cond_1

    iget-boolean v0, p0, Lcom/umeng/analytics/b;->k:Z

    if-nez v0, :cond_2

    .line 343
    :cond_1
    invoke-virtual {p0}, Lcom/umeng/analytics/b;->b()V

    .line 345
    :cond_2
    invoke-static {p2}, Landroid/text/TextUtils;->isEmpty(Ljava/lang/CharSequence;)Z

    move-result v0

    if-eqz v0, :cond_3

    .line 346
    const-string v0, "the eventName is empty! please check~"

    invoke-static {v0}, Lcom/umeng/commonsdk/statistics/common/MLog;->e(Ljava/lang/String;)V

    .line 362
    :goto_0
    return-void

    .line 350
    :cond_3
    const-string v3, ""

    .line 351
    iget-object v0, p0, Lcom/umeng/analytics/b;->i:Lorg/json/JSONObject;

    if-nez v0, :cond_4

    .line 352
    new-instance v0, Lorg/json/JSONObject;

    invoke-direct {v0}, Lorg/json/JSONObject;-><init>()V

    iput-object v0, p0, Lcom/umeng/analytics/b;->i:Lorg/json/JSONObject;

    .line 356
    :goto_1
    iget-object v6, p0, Lcom/umeng/analytics/b;->a:Landroid/content/Context;

    const/16 v7, 0x2002

    iget-object v0, p0, Lcom/umeng/analytics/b;->a:Landroid/content/Context;

    .line 358
    invoke-static {v0}, Lcom/umeng/analytics/CoreProtocol;->getInstance(Landroid/content/Context;)Lcom/umeng/analytics/CoreProtocol;

    move-result-object v8

    new-instance v0, Lcom/umeng/analytics/pro/i$d;

    .line 359
    invoke-static {}, Ljava/lang/System;->currentTimeMillis()J

    move-result-wide v4

    move-object v1, p2

    move-object v2, p3

    invoke-direct/range {v0 .. v5}, Lcom/umeng/analytics/pro/i$d;-><init>(Ljava/lang/String;Ljava/util/Map;Ljava/lang/String;J)V

    .line 356
    invoke-static {v6, v7, v8, v0}, Lcom/umeng/commonsdk/framework/UMWorkDispatch;->sendEvent(Landroid/content/Context;ILcom/umeng/commonsdk/framework/UMLogDataProtocol;Ljava/lang/Object;)V

    goto :goto_0

    .line 360
    :catch_0
    move-exception v0

    goto :goto_0

    .line 354
    :cond_4
    iget-object v0, p0, Lcom/umeng/analytics/b;->i:Lorg/json/JSONObject;

    invoke-virtual {v0}, Lorg/json/JSONObject;->toString()Ljava/lang/String;
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_0

    move-result-object v3

    goto :goto_1
.end method

.method a(Landroid/content/Context;Ljava/lang/String;Ljava/util/Map;J)V
    .locals 2
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "(",
            "Landroid/content/Context;",
            "Ljava/lang/String;",
            "Ljava/util/Map",
            "<",
            "Ljava/lang/String;",
            "Ljava/lang/Object;",
            ">;J)V"
        }
    .end annotation

    .prologue
    .line 321
    if-eqz p1, :cond_0

    .line 322
    :try_start_0
    iput-object p1, p0, Lcom/umeng/analytics/b;->a:Landroid/content/Context;

    .line 324
    :cond_0
    iget-boolean v0, p0, Lcom/umeng/analytics/b;->h:Z

    if-eqz v0, :cond_1

    iget-boolean v0, p0, Lcom/umeng/analytics/b;->k:Z

    if-nez v0, :cond_2

    .line 325
    :cond_1
    invoke-virtual {p0}, Lcom/umeng/analytics/b;->b()V

    .line 327
    :cond_2
    iget-object v0, p0, Lcom/umeng/analytics/b;->a:Landroid/content/Context;

    invoke-static {v0}, Lcom/umeng/analytics/pro/m;->a(Landroid/content/Context;)Lcom/umeng/analytics/pro/m;

    move-result-object v0

    invoke-virtual {v0, p2, p3, p4, p5}, Lcom/umeng/analytics/pro/m;->a(Ljava/lang/String;Ljava/util/Map;J)V
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_0

    .line 333
    :cond_3
    :goto_0
    return-void

    .line 328
    :catch_0
    move-exception v0

    .line 329
    sget-boolean v1, Lcom/umeng/commonsdk/statistics/common/MLog;->DEBUG:Z

    if-eqz v1, :cond_3

    .line 330
    invoke-static {v0}, Lcom/umeng/commonsdk/statistics/common/MLog;->e(Ljava/lang/Throwable;)V

    goto :goto_0
.end method

.method a(Landroid/content/Context;Ljava/lang/Throwable;)V
    .locals 2

    .prologue
    .line 256
    if-eqz p1, :cond_0

    if-nez p2, :cond_1

    .line 272
    :cond_0
    :goto_0
    return-void

    .line 259
    :cond_1
    iget-object v0, p0, Lcom/umeng/analytics/b;->a:Landroid/content/Context;

    if-nez v0, :cond_2

    .line 260
    iput-object p1, p0, Lcom/umeng/analytics/b;->a:Landroid/content/Context;

    .line 263
    :cond_2
    :try_start_0
    iget-boolean v0, p0, Lcom/umeng/analytics/b;->h:Z

    if-eqz v0, :cond_3

    iget-boolean v0, p0, Lcom/umeng/analytics/b;->k:Z

    if-nez v0, :cond_4

    .line 264
    :cond_3
    invoke-virtual {p0}, Lcom/umeng/analytics/b;->b()V

    .line 266
    :cond_4
    iget-object v0, p0, Lcom/umeng/analytics/b;->a:Landroid/content/Context;

    invoke-static {p2}, Lcom/umeng/commonsdk/statistics/common/DataHelper;->convertExceptionToString(Ljava/lang/Throwable;)Ljava/lang/String;

    move-result-object v1

    invoke-virtual {p0, v0, v1}, Lcom/umeng/analytics/b;->a(Landroid/content/Context;Ljava/lang/String;)V
    :try_end_0
    .catch Ljava/lang/Exception; {:try_start_0 .. :try_end_0} :catch_0

    goto :goto_0

    .line 267
    :catch_0
    move-exception v0

    .line 268
    sget-boolean v1, Lcom/umeng/commonsdk/statistics/common/MLog;->DEBUG:Z

    if-eqz v1, :cond_0

    .line 269
    invoke-static {v0}, Lcom/umeng/commonsdk/statistics/common/MLog;->e(Ljava/lang/Throwable;)V

    goto :goto_0
.end method

.method public a(Landroid/content/Context;Ljava/util/List;)V
    .locals 1
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "(",
            "Landroid/content/Context;",
            "Ljava/util/List",
            "<",
            "Ljava/lang/String;",
            ">;)V"
        }
    .end annotation

    .prologue
    .line 878
    if-nez p1, :cond_0

    .line 879
    :try_start_0
    const-string v0, "unexpected null context in setFirstLaunchEvent"

    invoke-static {v0}, Lcom/umeng/commonsdk/statistics/common/MLog;->e(Ljava/lang/String;)V

    .line 892
    :goto_0
    return-void

    .line 882
    :cond_0
    iget-object v0, p0, Lcom/umeng/analytics/b;->a:Landroid/content/Context;

    if-nez v0, :cond_1

    .line 883
    iput-object p1, p0, Lcom/umeng/analytics/b;->a:Landroid/content/Context;

    .line 885
    :cond_1
    iget-boolean v0, p0, Lcom/umeng/analytics/b;->h:Z

    if-eqz v0, :cond_2

    iget-boolean v0, p0, Lcom/umeng/analytics/b;->k:Z

    if-nez v0, :cond_3

    .line 886
    :cond_2
    invoke-virtual {p0}, Lcom/umeng/analytics/b;->b()V

    .line 888
    :cond_3
    iget-object v0, p0, Lcom/umeng/analytics/b;->a:Landroid/content/Context;

    invoke-static {v0}, Lcom/umeng/analytics/pro/m;->a(Landroid/content/Context;)Lcom/umeng/analytics/pro/m;

    move-result-object v0

    invoke-virtual {v0, p2}, Lcom/umeng/analytics/pro/m;->a(Ljava/util/List;)V
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_0

    goto :goto_0

    .line 889
    :catch_0
    move-exception v0

    .line 890
    invoke-static {v0}, Lcom/umeng/commonsdk/statistics/common/MLog;->e(Ljava/lang/Throwable;)V

    goto :goto_0
.end method

.method public a(Lcom/umeng/analytics/pro/r;)V
    .locals 0

    .prologue
    .line 137
    iput-object p1, p0, Lcom/umeng/analytics/b;->b:Lcom/umeng/analytics/pro/r;

    .line 138
    return-void
.end method

.method public a(Ljava/lang/Object;)V
    .locals 3

    .prologue
    .line 693
    if-eqz p1, :cond_0

    .line 694
    :try_start_0
    check-cast p1, Ljava/lang/String;

    .line 695
    iget-object v0, p0, Lcom/umeng/analytics/b;->a:Landroid/content/Context;

    invoke-static {v0}, Lcom/umeng/commonsdk/statistics/internal/PreferenceWrapper;->getDefault(Landroid/content/Context;)Landroid/content/SharedPreferences;

    move-result-object v0

    invoke-interface {v0}, Landroid/content/SharedPreferences;->edit()Landroid/content/SharedPreferences$Editor;

    move-result-object v0

    .line 696
    if-eqz v0, :cond_0

    invoke-static {p1}, Landroid/text/TextUtils;->isEmpty(Ljava/lang/CharSequence;)Z

    move-result v1

    if-nez v1, :cond_0

    .line 697
    const-string v1, "sp"

    iget-object v2, p0, Lcom/umeng/analytics/b;->i:Lorg/json/JSONObject;

    invoke-virtual {v2}, Lorg/json/JSONObject;->toString()Ljava/lang/String;

    move-result-object v2

    invoke-interface {v0, v1, v2}, Landroid/content/SharedPreferences$Editor;->putString(Ljava/lang/String;Ljava/lang/String;)Landroid/content/SharedPreferences$Editor;

    move-result-object v0

    invoke-interface {v0}, Landroid/content/SharedPreferences$Editor;->commit()Z
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_0

    .line 703
    :cond_0
    :goto_0
    return-void

    .line 701
    :catch_0
    move-exception v0

    goto :goto_0
.end method

.method a(Ljava/lang/String;)V
    .locals 1

    .prologue
    .line 119
    sget-boolean v0, Lcom/umeng/analytics/AnalyticsConfig;->ACTIVITY_DURATION_OPEN:Z

    if-nez v0, :cond_0

    .line 121
    :try_start_0
    iget-object v0, p0, Lcom/umeng/analytics/b;->d:Lcom/umeng/analytics/pro/p;

    invoke-virtual {v0, p1}, Lcom/umeng/analytics/pro/p;->a(Ljava/lang/String;)V
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_0

    .line 125
    :cond_0
    :goto_0
    return-void

    .line 122
    :catch_0
    move-exception v0

    goto :goto_0
.end method

.method a(Ljava/lang/String;Ljava/lang/String;)V
    .locals 4

    .prologue
    .line 416
    :try_start_0
    new-instance v0, Lorg/json/JSONObject;

    invoke-direct {v0}, Lorg/json/JSONObject;-><init>()V

    .line 417
    const-string v1, "provider"

    invoke-virtual {v0, v1, p1}, Lorg/json/JSONObject;->put(Ljava/lang/String;Ljava/lang/Object;)Lorg/json/JSONObject;

    .line 418
    const-string v1, "uid"

    invoke-virtual {v0, v1, p2}, Lorg/json/JSONObject;->put(Ljava/lang/String;Ljava/lang/Object;)Lorg/json/JSONObject;

    .line 419
    iget-object v1, p0, Lcom/umeng/analytics/b;->a:Landroid/content/Context;

    const/16 v2, 0x1005

    iget-object v3, p0, Lcom/umeng/analytics/b;->a:Landroid/content/Context;

    .line 421
    invoke-static {v3}, Lcom/umeng/analytics/CoreProtocol;->getInstance(Landroid/content/Context;)Lcom/umeng/analytics/CoreProtocol;

    move-result-object v3

    .line 419
    invoke-static {v1, v2, v3, v0}, Lcom/umeng/commonsdk/framework/UMWorkDispatch;->sendEvent(Landroid/content/Context;ILcom/umeng/commonsdk/framework/UMLogDataProtocol;Ljava/lang/Object;)V
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_0

    .line 427
    :cond_0
    :goto_0
    return-void

    .line 422
    :catch_0
    move-exception v0

    .line 423
    sget-boolean v1, Lcom/umeng/commonsdk/statistics/common/MLog;->DEBUG:Z

    if-eqz v1, :cond_0

    .line 424
    const-string v1, " Excepthon  in  onProfileSignIn"

    invoke-static {v1, v0}, Lcom/umeng/commonsdk/statistics/common/MLog;->e(Ljava/lang/String;Ljava/lang/Throwable;)V

    goto :goto_0
.end method

.method public a(Ljava/lang/Throwable;)V
    .locals 4

    .prologue
    .line 388
    :try_start_0
    iget-object v0, p0, Lcom/umeng/analytics/b;->d:Lcom/umeng/analytics/pro/p;

    invoke-virtual {v0}, Lcom/umeng/analytics/pro/p;->a()V

    .line 389
    iget-object v0, p0, Lcom/umeng/analytics/b;->a:Landroid/content/Context;

    if-eqz v0, :cond_0

    .line 390
    iget-object v0, p0, Lcom/umeng/analytics/b;->f:Lcom/umeng/analytics/pro/h;

    iget-object v1, p0, Lcom/umeng/analytics/b;->a:Landroid/content/Context;

    invoke-virtual {v0, v1}, Lcom/umeng/analytics/pro/h;->a(Landroid/content/Context;)V

    .line 391
    iget-object v0, p0, Lcom/umeng/analytics/b;->e:Lcom/umeng/analytics/pro/o;

    iget-object v1, p0, Lcom/umeng/analytics/b;->a:Landroid/content/Context;

    invoke-static {}, Ljava/lang/System;->currentTimeMillis()J

    move-result-wide v2

    invoke-static {v2, v3}, Ljava/lang/Long;->valueOf(J)Ljava/lang/Long;

    move-result-object v2

    invoke-virtual {v0, v1, v2}, Lcom/umeng/analytics/pro/o;->b(Landroid/content/Context;Ljava/lang/Object;)V

    .line 392
    iget-object v0, p0, Lcom/umeng/analytics/b;->a:Landroid/content/Context;

    invoke-static {v0}, Lcom/umeng/analytics/pro/i;->a(Landroid/content/Context;)Lcom/umeng/analytics/pro/i;

    move-result-object v0

    invoke-virtual {v0}, Lcom/umeng/analytics/pro/i;->a()V

    .line 393
    iget-object v0, p0, Lcom/umeng/analytics/b;->a:Landroid/content/Context;

    invoke-static {v0}, Lcom/umeng/analytics/pro/p;->a(Landroid/content/Context;)V

    .line 394
    iget-object v0, p0, Lcom/umeng/analytics/b;->a:Landroid/content/Context;

    invoke-static {v0}, Lcom/umeng/analytics/pro/h;->b(Landroid/content/Context;)V

    .line 395
    iget-object v0, p0, Lcom/umeng/analytics/b;->a:Landroid/content/Context;

    invoke-static {v0}, Lcom/umeng/commonsdk/statistics/internal/PreferenceWrapper;->getDefault(Landroid/content/Context;)Landroid/content/SharedPreferences;

    move-result-object v0

    invoke-interface {v0}, Landroid/content/SharedPreferences;->edit()Landroid/content/SharedPreferences$Editor;

    move-result-object v0

    invoke-interface {v0}, Landroid/content/SharedPreferences$Editor;->commit()Z

    .line 396
    if-eqz p1, :cond_0

    .line 397
    new-instance v0, Lorg/json/JSONObject;

    invoke-direct {v0}, Lorg/json/JSONObject;-><init>()V

    .line 398
    const-string v1, "ts"

    invoke-static {}, Ljava/lang/System;->currentTimeMillis()J

    move-result-wide v2

    invoke-virtual {v0, v1, v2, v3}, Lorg/json/JSONObject;->put(Ljava/lang/String;J)Lorg/json/JSONObject;

    .line 399
    const-string v1, "error_source"

    const/4 v2, 0x1

    invoke-virtual {v0, v1, v2}, Lorg/json/JSONObject;->put(Ljava/lang/String;I)Lorg/json/JSONObject;

    .line 400
    const-string v1, "context"

    invoke-static {p1}, Lcom/umeng/commonsdk/statistics/common/DataHelper;->convertExceptionToString(Ljava/lang/Throwable;)Ljava/lang/String;

    move-result-object v2

    invoke-virtual {v0, v1, v2}, Lorg/json/JSONObject;->put(Ljava/lang/String;Ljava/lang/Object;)Lorg/json/JSONObject;

    .line 401
    iget-object v1, p0, Lcom/umeng/analytics/b;->a:Landroid/content/Context;

    invoke-static {v1}, Lcom/umeng/analytics/pro/g;->a(Landroid/content/Context;)Lcom/umeng/analytics/pro/g;

    move-result-object v1

    iget-object v2, p0, Lcom/umeng/analytics/b;->e:Lcom/umeng/analytics/pro/o;

    invoke-virtual {v2}, Lcom/umeng/analytics/pro/o;->d()Ljava/lang/String;

    move-result-object v2

    invoke-virtual {v0}, Lorg/json/JSONObject;->toString()Ljava/lang/String;

    move-result-object v0

    const/4 v3, 0x1

    invoke-virtual {v1, v2, v0, v3}, Lcom/umeng/analytics/pro/g;->a(Ljava/lang/String;Ljava/lang/String;I)Z

    .line 406
    :cond_0
    invoke-static {}, Lcom/umeng/commonsdk/framework/UMWorkDispatch;->Quit()V
    :try_end_0
    .catch Ljava/lang/Exception; {:try_start_0 .. :try_end_0} :catch_0

    .line 412
    :cond_1
    :goto_0
    return-void

    .line 407
    :catch_0
    move-exception v0

    .line 408
    sget-boolean v1, Lcom/umeng/commonsdk/statistics/common/MLog;->DEBUG:Z

    if-eqz v1, :cond_1

    .line 409
    const-string v1, "Exception in onAppCrash"

    invoke-static {v1, v0}, Lcom/umeng/commonsdk/statistics/common/MLog;->e(Ljava/lang/String;Ljava/lang/Throwable;)V

    goto :goto_0
.end method

.method a(Ljavax/microedition/khronos/opengles/GL10;)V
    .locals 3

    .prologue
    .line 451
    invoke-static {p1}, Lcom/umeng/commonsdk/utils/UMUtils;->getGPU(Ljavax/microedition/khronos/opengles/GL10;)[Ljava/lang/String;

    move-result-object v0

    .line 452
    array-length v1, v0

    const/4 v2, 0x2

    if-ne v1, v2, :cond_0

    .line 453
    const/4 v1, 0x0

    aget-object v1, v0, v1

    sput-object v1, Lcom/umeng/analytics/AnalyticsConfig;->GPU_VENDER:Ljava/lang/String;

    .line 454
    const/4 v1, 0x1

    aget-object v0, v0, v1

    sput-object v0, Lcom/umeng/analytics/AnalyticsConfig;->GPU_RENDERER:Ljava/lang/String;

    .line 456
    :cond_0
    return-void
.end method

.method a(Z)V
    .locals 0

    .prologue
    .line 442
    sput-boolean p1, Lcom/umeng/analytics/AnalyticsConfig;->CATCH_EXCEPTION:Z

    .line 443
    return-void
.end method

.method public b()V
    .locals 2

    .prologue
    .line 74
    :try_start_0
    iget-object v0, p0, Lcom/umeng/analytics/b;->a:Landroid/content/Context;

    if-nez v0, :cond_0

    .line 108
    :goto_0
    return-void

    .line 78
    :cond_0
    iget-boolean v0, p0, Lcom/umeng/analytics/b;->h:Z

    if-nez v0, :cond_2

    .line 79
    const/4 v0, 0x1

    iput-boolean v0, p0, Lcom/umeng/analytics/b;->h:Z

    .line 83
    iget-object v0, p0, Lcom/umeng/analytics/b;->a:Landroid/content/Context;

    invoke-direct {p0, v0}, Lcom/umeng/analytics/b;->f(Landroid/content/Context;)Lorg/json/JSONObject;

    move-result-object v0

    iput-object v0, p0, Lcom/umeng/analytics/b;->i:Lorg/json/JSONObject;

    .line 84
    iget-object v0, p0, Lcom/umeng/analytics/b;->i:Lorg/json/JSONObject;

    if-nez v0, :cond_1

    .line 85
    new-instance v0, Lorg/json/JSONObject;

    invoke-direct {v0}, Lorg/json/JSONObject;-><init>()V

    iput-object v0, p0, Lcom/umeng/analytics/b;->i:Lorg/json/JSONObject;

    .line 87
    :cond_1
    new-instance v0, Lorg/json/JSONObject;

    iget-object v1, p0, Lcom/umeng/analytics/b;->i:Lorg/json/JSONObject;

    invoke-virtual {v1}, Lorg/json/JSONObject;->toString()Ljava/lang/String;

    move-result-object v1

    invoke-direct {v0, v1}, Lorg/json/JSONObject;-><init>(Ljava/lang/String;)V

    iput-object v0, p0, Lcom/umeng/analytics/b;->j:Lorg/json/JSONObject;

    .line 90
    :cond_2
    sget v0, Landroid/os/Build$VERSION;->SDK_INT:I

    const/16 v1, 0xd

    if-le v0, v1, :cond_4

    .line 91
    monitor-enter p0
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_0

    .line 92
    :try_start_1
    iget-boolean v0, p0, Lcom/umeng/analytics/b;->k:Z

    if-nez v0, :cond_3

    .line 93
    iget-object v0, p0, Lcom/umeng/analytics/b;->a:Landroid/content/Context;

    instance-of v0, v0, Landroid/app/Activity;

    if-eqz v0, :cond_3

    .line 94
    new-instance v1, Lcom/umeng/analytics/pro/h;

    iget-object v0, p0, Lcom/umeng/analytics/b;->a:Landroid/content/Context;

    check-cast v0, Landroid/app/Activity;

    invoke-direct {v1, v0}, Lcom/umeng/analytics/pro/h;-><init>(Landroid/app/Activity;)V

    iput-object v1, p0, Lcom/umeng/analytics/b;->f:Lcom/umeng/analytics/pro/h;

    .line 95
    const/4 v0, 0x1

    iput-boolean v0, p0, Lcom/umeng/analytics/b;->k:Z

    .line 98
    :cond_3
    monitor-exit p0
    :try_end_1
    .catchall {:try_start_1 .. :try_end_1} :catchall_0

    .line 104
    :goto_1
    :try_start_2
    iget-object v0, p0, Lcom/umeng/analytics/b;->a:Landroid/content/Context;

    invoke-virtual {v0}, Landroid/content/Context;->getApplicationContext()Landroid/content/Context;

    move-result-object v0

    iput-object v0, p0, Lcom/umeng/analytics/b;->a:Landroid/content/Context;
    :try_end_2
    .catch Ljava/lang/Throwable; {:try_start_2 .. :try_end_2} :catch_0

    goto :goto_0

    .line 106
    :catch_0
    move-exception v0

    goto :goto_0

    .line 98
    :catchall_0
    move-exception v0

    :try_start_3
    monitor-exit p0
    :try_end_3
    .catchall {:try_start_3 .. :try_end_3} :catchall_0

    :try_start_4
    throw v0

    .line 101
    :cond_4
    const/4 v0, 0x1

    iput-boolean v0, p0, Lcom/umeng/analytics/b;->k:Z
    :try_end_4
    .catch Ljava/lang/Throwable; {:try_start_4 .. :try_end_4} :catch_0

    goto :goto_1
.end method

.method b(Landroid/content/Context;)V
    .locals 2

    .prologue
    .line 177
    if-nez p1, :cond_1

    .line 178
    const-string v0, "unexpected null context in onPause"

    invoke-static {v0}, Lcom/umeng/commonsdk/statistics/common/MLog;->e(Ljava/lang/String;)V

    .line 198
    :cond_0
    :goto_0
    return-void

    .line 181
    :cond_1
    iget-object v0, p0, Lcom/umeng/analytics/b;->a:Landroid/content/Context;

    if-nez v0, :cond_2

    .line 182
    iput-object p1, p0, Lcom/umeng/analytics/b;->a:Landroid/content/Context;

    .line 186
    :cond_2
    :try_start_0
    iget-boolean v0, p0, Lcom/umeng/analytics/b;->h:Z

    if-eqz v0, :cond_3

    iget-boolean v0, p0, Lcom/umeng/analytics/b;->k:Z

    if-nez v0, :cond_4

    .line 187
    :cond_3
    invoke-virtual {p0}, Lcom/umeng/analytics/b;->b()V

    .line 189
    :cond_4
    sget-boolean v0, Lcom/umeng/analytics/AnalyticsConfig;->ACTIVITY_DURATION_OPEN:Z

    if-eqz v0, :cond_5

    .line 190
    iget-object v0, p0, Lcom/umeng/analytics/b;->d:Lcom/umeng/analytics/pro/p;

    invoke-virtual {p1}, Ljava/lang/Object;->getClass()Ljava/lang/Class;

    move-result-object v1

    invoke-virtual {v1}, Ljava/lang/Class;->getName()Ljava/lang/String;

    move-result-object v1

    invoke-virtual {v0, v1}, Lcom/umeng/analytics/pro/p;->b(Ljava/lang/String;)V

    .line 192
    :cond_5
    invoke-virtual {p0}, Lcom/umeng/analytics/b;->f()V
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_0

    goto :goto_0

    .line 193
    :catch_0
    move-exception v0

    .line 194
    sget-boolean v1, Lcom/umeng/commonsdk/statistics/common/MLog;->DEBUG:Z

    if-eqz v1, :cond_0

    .line 195
    const-string v1, "Exception occurred in Mobclick.onRause(). "

    invoke-static {v1, v0}, Lcom/umeng/commonsdk/statistics/common/MLog;->e(Ljava/lang/String;Ljava/lang/Throwable;)V

    goto :goto_0
.end method

.method b(Landroid/content/Context;Ljava/lang/String;)V
    .locals 1

    .prologue
    .line 523
    if-nez p1, :cond_0

    .line 524
    const-string v0, "unexpected null context in setSecret"

    invoke-static {v0}, Lcom/umeng/commonsdk/statistics/common/MLog;->e(Ljava/lang/String;)V

    .line 534
    :goto_0
    return-void

    .line 527
    :cond_0
    iget-object v0, p0, Lcom/umeng/analytics/b;->a:Landroid/content/Context;

    if-nez v0, :cond_1

    .line 528
    iput-object p1, p0, Lcom/umeng/analytics/b;->a:Landroid/content/Context;

    .line 530
    :cond_1
    iget-boolean v0, p0, Lcom/umeng/analytics/b;->h:Z

    if-eqz v0, :cond_2

    iget-boolean v0, p0, Lcom/umeng/analytics/b;->k:Z

    if-nez v0, :cond_3

    .line 531
    :cond_2
    invoke-virtual {p0}, Lcom/umeng/analytics/b;->b()V

    .line 533
    :cond_3
    iget-object v0, p0, Lcom/umeng/analytics/b;->a:Landroid/content/Context;

    invoke-static {v0, p2}, Lcom/umeng/analytics/AnalyticsConfig;->a(Landroid/content/Context;Ljava/lang/String;)V

    goto :goto_0
.end method

.method b(Ljava/lang/String;)V
    .locals 1

    .prologue
    .line 128
    sget-boolean v0, Lcom/umeng/analytics/AnalyticsConfig;->ACTIVITY_DURATION_OPEN:Z

    if-nez v0, :cond_0

    .line 130
    :try_start_0
    iget-object v0, p0, Lcom/umeng/analytics/b;->d:Lcom/umeng/analytics/pro/p;

    invoke-virtual {v0, p1}, Lcom/umeng/analytics/pro/p;->b(Ljava/lang/String;)V
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_0

    .line 134
    :cond_0
    :goto_0
    return-void

    .line 131
    :catch_0
    move-exception v0

    goto :goto_0
.end method

.method b(Z)V
    .locals 0

    .prologue
    .line 464
    sput-boolean p1, Lcom/umeng/analytics/AnalyticsConfig;->ACTIVITY_DURATION_OPEN:Z

    .line 465
    return-void
.end method

.method public c()Lorg/json/JSONObject;
    .locals 1

    .prologue
    .line 111
    iget-object v0, p0, Lcom/umeng/analytics/b;->j:Lorg/json/JSONObject;

    return-object v0
.end method

.method c(Landroid/content/Context;)V
    .locals 4

    .prologue
    .line 366
    :try_start_0
    iget-object v0, p0, Lcom/umeng/analytics/b;->a:Landroid/content/Context;

    if-nez v0, :cond_0

    .line 367
    if-eqz p1, :cond_0

    .line 368
    iput-object p1, p0, Lcom/umeng/analytics/b;->a:Landroid/content/Context;

    .line 371
    :cond_0
    iget-object v0, p0, Lcom/umeng/analytics/b;->d:Lcom/umeng/analytics/pro/p;

    invoke-virtual {v0}, Lcom/umeng/analytics/pro/p;->a()V

    .line 372
    iget-object v0, p0, Lcom/umeng/analytics/b;->f:Lcom/umeng/analytics/pro/h;

    iget-object v1, p0, Lcom/umeng/analytics/b;->a:Landroid/content/Context;

    invoke-virtual {v0, v1}, Lcom/umeng/analytics/pro/h;->a(Landroid/content/Context;)V

    .line 373
    iget-object v0, p0, Lcom/umeng/analytics/b;->e:Lcom/umeng/analytics/pro/o;

    iget-object v1, p0, Lcom/umeng/analytics/b;->a:Landroid/content/Context;

    invoke-static {}, Ljava/lang/System;->currentTimeMillis()J

    move-result-wide v2

    invoke-static {v2, v3}, Ljava/lang/Long;->valueOf(J)Ljava/lang/Long;

    move-result-object v2

    invoke-virtual {v0, v1, v2}, Lcom/umeng/analytics/pro/o;->b(Landroid/content/Context;Ljava/lang/Object;)V

    .line 374
    iget-object v0, p0, Lcom/umeng/analytics/b;->a:Landroid/content/Context;

    invoke-static {v0}, Lcom/umeng/analytics/pro/i;->a(Landroid/content/Context;)Lcom/umeng/analytics/pro/i;

    move-result-object v0

    invoke-virtual {v0}, Lcom/umeng/analytics/pro/i;->a()V

    .line 375
    iget-object v0, p0, Lcom/umeng/analytics/b;->a:Landroid/content/Context;

    invoke-static {v0}, Lcom/umeng/analytics/pro/p;->a(Landroid/content/Context;)V

    .line 376
    iget-object v0, p0, Lcom/umeng/analytics/b;->a:Landroid/content/Context;

    invoke-static {v0}, Lcom/umeng/analytics/pro/h;->b(Landroid/content/Context;)V

    .line 377
    iget-object v0, p0, Lcom/umeng/analytics/b;->a:Landroid/content/Context;

    invoke-static {v0}, Lcom/umeng/commonsdk/statistics/internal/PreferenceWrapper;->getDefault(Landroid/content/Context;)Landroid/content/SharedPreferences;

    move-result-object v0

    invoke-interface {v0}, Landroid/content/SharedPreferences;->edit()Landroid/content/SharedPreferences$Editor;

    move-result-object v0

    invoke-interface {v0}, Landroid/content/SharedPreferences$Editor;->commit()Z

    .line 380
    invoke-static {}, Lcom/umeng/commonsdk/framework/UMWorkDispatch;->Quit()V
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_0

    .line 383
    :goto_0
    return-void

    .line 381
    :catch_0
    move-exception v0

    goto :goto_0
.end method

.method public c(Landroid/content/Context;Ljava/lang/String;)V
    .locals 4

    .prologue
    .line 717
    if-nez p1, :cond_1

    .line 718
    :try_start_0
    const-string v0, "unexpected null context in unregisterSuperProperty"

    invoke-static {v0}, Lcom/umeng/commonsdk/statistics/common/MLog;->e(Ljava/lang/String;)V

    .line 743
    :cond_0
    :goto_0
    return-void

    .line 721
    :cond_1
    iget-object v0, p0, Lcom/umeng/analytics/b;->a:Landroid/content/Context;

    if-nez v0, :cond_2

    .line 722
    iput-object p1, p0, Lcom/umeng/analytics/b;->a:Landroid/content/Context;

    .line 724
    :cond_2
    iget-boolean v0, p0, Lcom/umeng/analytics/b;->h:Z

    if-eqz v0, :cond_3

    iget-boolean v0, p0, Lcom/umeng/analytics/b;->k:Z

    if-nez v0, :cond_4

    .line 725
    :cond_3
    invoke-virtual {p0}, Lcom/umeng/analytics/b;->b()V

    .line 727
    :cond_4
    const/16 v0, 0x80

    invoke-static {p2, v0}, Lcom/umeng/commonsdk/statistics/common/HelperUtils;->subStr(Ljava/lang/String;I)Ljava/lang/String;

    move-result-object v0

    .line 729
    iget-object v1, p0, Lcom/umeng/analytics/b;->i:Lorg/json/JSONObject;

    if-nez v1, :cond_5

    .line 730
    new-instance v1, Lorg/json/JSONObject;

    invoke-direct {v1}, Lorg/json/JSONObject;-><init>()V

    iput-object v1, p0, Lcom/umeng/analytics/b;->i:Lorg/json/JSONObject;

    .line 732
    :cond_5
    iget-object v1, p0, Lcom/umeng/analytics/b;->i:Lorg/json/JSONObject;

    invoke-virtual {v1, v0}, Lorg/json/JSONObject;->has(Ljava/lang/String;)Z

    move-result v1

    if-eqz v1, :cond_0

    .line 733
    iget-object v1, p0, Lcom/umeng/analytics/b;->i:Lorg/json/JSONObject;

    invoke-virtual {v1, v0}, Lorg/json/JSONObject;->remove(Ljava/lang/String;)Ljava/lang/Object;

    .line 735
    iget-object v1, p0, Lcom/umeng/analytics/b;->a:Landroid/content/Context;

    const/16 v2, 0x2005

    iget-object v3, p0, Lcom/umeng/analytics/b;->a:Landroid/content/Context;

    .line 737
    invoke-static {v3}, Lcom/umeng/analytics/CoreProtocol;->getInstance(Landroid/content/Context;)Lcom/umeng/analytics/CoreProtocol;

    move-result-object v3

    .line 735
    invoke-static {v1, v2, v3, v0}, Lcom/umeng/commonsdk/framework/UMWorkDispatch;->sendEvent(Landroid/content/Context;ILcom/umeng/commonsdk/framework/UMLogDataProtocol;Ljava/lang/Object;)V
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_0

    goto :goto_0

    .line 740
    :catch_0
    move-exception v0

    .line 741
    invoke-virtual {v0}, Ljava/lang/Throwable;->printStackTrace()V

    goto :goto_0
.end method

.method public d(Landroid/content/Context;Ljava/lang/String;)Ljava/lang/Object;
    .locals 3

    .prologue
    const/4 v0, 0x0

    .line 764
    if-nez p1, :cond_1

    .line 765
    :try_start_0
    const-string v1, "unexpected null context in getSuperProperty"

    invoke-static {v1}, Lcom/umeng/commonsdk/statistics/common/MLog;->e(Ljava/lang/String;)V

    .line 782
    :cond_0
    :goto_0
    return-object v0

    .line 768
    :cond_1
    iget-object v1, p0, Lcom/umeng/analytics/b;->a:Landroid/content/Context;

    if-nez v1, :cond_2

    .line 769
    iput-object p1, p0, Lcom/umeng/analytics/b;->a:Landroid/content/Context;

    .line 771
    :cond_2
    iget-object v1, p0, Lcom/umeng/analytics/b;->i:Lorg/json/JSONObject;

    if-eqz v1, :cond_3

    .line 772
    const/16 v1, 0x80

    invoke-static {p2, v1}, Lcom/umeng/commonsdk/statistics/common/HelperUtils;->subStr(Ljava/lang/String;I)Ljava/lang/String;

    move-result-object v1

    .line 773
    iget-object v2, p0, Lcom/umeng/analytics/b;->i:Lorg/json/JSONObject;

    invoke-virtual {v2, v1}, Lorg/json/JSONObject;->has(Ljava/lang/String;)Z

    move-result v2

    if-eqz v2, :cond_0

    .line 774
    iget-object v2, p0, Lcom/umeng/analytics/b;->i:Lorg/json/JSONObject;

    invoke-virtual {v2, v1}, Lorg/json/JSONObject;->opt(Ljava/lang/String;)Ljava/lang/Object;

    move-result-object v0

    goto :goto_0

    .line 777
    :cond_3
    new-instance v1, Lorg/json/JSONObject;

    invoke-direct {v1}, Lorg/json/JSONObject;-><init>()V

    iput-object v1, p0, Lcom/umeng/analytics/b;->i:Lorg/json/JSONObject;
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_0

    goto :goto_0

    .line 779
    :catch_0
    move-exception v1

    .line 780
    invoke-virtual {v1}, Ljava/lang/Throwable;->printStackTrace()V

    goto :goto_0
.end method

.method public d(Landroid/content/Context;)Ljava/lang/String;
    .locals 2

    .prologue
    const/4 v0, 0x0

    .line 787
    if-nez p1, :cond_0

    .line 788
    :try_start_0
    const-string v1, "unexpected null context in getSuperProperties"

    invoke-static {v1}, Lcom/umeng/commonsdk/statistics/common/MLog;->e(Ljava/lang/String;)V

    .line 802
    :goto_0
    return-object v0

    .line 791
    :cond_0
    iget-object v1, p0, Lcom/umeng/analytics/b;->a:Landroid/content/Context;

    if-nez v1, :cond_1

    .line 792
    iput-object p1, p0, Lcom/umeng/analytics/b;->a:Landroid/content/Context;

    .line 794
    :cond_1
    iget-object v1, p0, Lcom/umeng/analytics/b;->i:Lorg/json/JSONObject;

    if-eqz v1, :cond_2

    .line 795
    iget-object v1, p0, Lcom/umeng/analytics/b;->i:Lorg/json/JSONObject;

    invoke-virtual {v1}, Lorg/json/JSONObject;->toString()Ljava/lang/String;

    move-result-object v0

    goto :goto_0

    .line 797
    :cond_2
    new-instance v1, Lorg/json/JSONObject;

    invoke-direct {v1}, Lorg/json/JSONObject;-><init>()V

    iput-object v1, p0, Lcom/umeng/analytics/b;->i:Lorg/json/JSONObject;
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_0

    goto :goto_0

    .line 799
    :catch_0
    move-exception v1

    .line 800
    invoke-virtual {v1}, Ljava/lang/Throwable;->printStackTrace()V

    goto :goto_0
.end method

.method public d()V
    .locals 1

    .prologue
    .line 115
    const/4 v0, 0x0

    iput-object v0, p0, Lcom/umeng/analytics/b;->j:Lorg/json/JSONObject;

    .line 116
    return-void
.end method

.method public e()V
    .locals 6

    .prologue
    .line 275
    iget-object v0, p0, Lcom/umeng/analytics/b;->a:Landroid/content/Context;

    const/16 v1, 0x1007

    iget-object v2, p0, Lcom/umeng/analytics/b;->a:Landroid/content/Context;

    .line 277
    invoke-static {v2}, Lcom/umeng/analytics/CoreProtocol;->getInstance(Landroid/content/Context;)Lcom/umeng/analytics/CoreProtocol;

    move-result-object v2

    invoke-static {}, Ljava/lang/System;->currentTimeMillis()J

    move-result-wide v4

    invoke-static {v4, v5}, Ljava/lang/Long;->valueOf(J)Ljava/lang/Long;

    move-result-object v3

    .line 275
    invoke-static {v0, v1, v2, v3}, Lcom/umeng/commonsdk/framework/UMWorkDispatch;->sendEvent(Landroid/content/Context;ILcom/umeng/commonsdk/framework/UMLogDataProtocol;Ljava/lang/Object;)V

    .line 278
    iget-object v0, p0, Lcom/umeng/analytics/b;->b:Lcom/umeng/analytics/pro/r;

    if-eqz v0, :cond_0

    iget-object v0, p0, Lcom/umeng/analytics/b;->b:Lcom/umeng/analytics/pro/r;

    invoke-interface {v0}, Lcom/umeng/analytics/pro/r;->a()V

    .line 279
    :cond_0
    return-void
.end method

.method public e(Landroid/content/Context;)V
    .locals 4

    .prologue
    .line 849
    if-nez p1, :cond_0

    .line 850
    const-string v0, "unexpected null context in clearSuperProperties"

    invoke-static {v0}, Lcom/umeng/commonsdk/statistics/common/MLog;->e(Ljava/lang/String;)V

    .line 863
    :goto_0
    return-void

    .line 853
    :cond_0
    iget-object v0, p0, Lcom/umeng/analytics/b;->a:Landroid/content/Context;

    if-nez v0, :cond_1

    .line 854
    iput-object p1, p0, Lcom/umeng/analytics/b;->a:Landroid/content/Context;

    .line 856
    :cond_1
    iget-boolean v0, p0, Lcom/umeng/analytics/b;->h:Z

    if-eqz v0, :cond_2

    iget-boolean v0, p0, Lcom/umeng/analytics/b;->k:Z

    if-nez v0, :cond_3

    .line 857
    :cond_2
    invoke-virtual {p0}, Lcom/umeng/analytics/b;->b()V

    .line 859
    :cond_3
    new-instance v0, Lorg/json/JSONObject;

    invoke-direct {v0}, Lorg/json/JSONObject;-><init>()V

    iput-object v0, p0, Lcom/umeng/analytics/b;->i:Lorg/json/JSONObject;

    .line 860
    iget-object v0, p0, Lcom/umeng/analytics/b;->a:Landroid/content/Context;

    const/16 v1, 0x2004

    iget-object v2, p0, Lcom/umeng/analytics/b;->a:Landroid/content/Context;

    .line 862
    invoke-static {v2}, Lcom/umeng/analytics/CoreProtocol;->getInstance(Landroid/content/Context;)Lcom/umeng/analytics/CoreProtocol;

    move-result-object v2

    const/4 v3, 0x0

    .line 860
    invoke-static {v0, v1, v2, v3}, Lcom/umeng/commonsdk/framework/UMWorkDispatch;->sendEvent(Landroid/content/Context;ILcom/umeng/commonsdk/framework/UMLogDataProtocol;Ljava/lang/Object;)V

    goto :goto_0
.end method

.method public f()V
    .locals 6

    .prologue
    .line 284
    :try_start_0
    iget-object v0, p0, Lcom/umeng/analytics/b;->a:Landroid/content/Context;

    const/16 v1, 0x1008

    iget-object v2, p0, Lcom/umeng/analytics/b;->a:Landroid/content/Context;

    .line 286
    invoke-static {v2}, Lcom/umeng/analytics/CoreProtocol;->getInstance(Landroid/content/Context;)Lcom/umeng/analytics/CoreProtocol;

    move-result-object v2

    invoke-static {}, Ljava/lang/System;->currentTimeMillis()J

    move-result-wide v4

    invoke-static {v4, v5}, Ljava/lang/Long;->valueOf(J)Ljava/lang/Long;

    move-result-object v3

    .line 284
    invoke-static {v0, v1, v2, v3}, Lcom/umeng/commonsdk/framework/UMWorkDispatch;->sendEvent(Landroid/content/Context;ILcom/umeng/commonsdk/framework/UMLogDataProtocol;Ljava/lang/Object;)V

    .line 287
    iget-object v0, p0, Lcom/umeng/analytics/b;->a:Landroid/content/Context;

    const/16 v1, 0x1004

    iget-object v2, p0, Lcom/umeng/analytics/b;->a:Landroid/content/Context;

    .line 289
    invoke-static {v2}, Lcom/umeng/analytics/CoreProtocol;->getInstance(Landroid/content/Context;)Lcom/umeng/analytics/CoreProtocol;

    move-result-object v2

    const/4 v3, 0x0

    .line 287
    invoke-static {v0, v1, v2, v3}, Lcom/umeng/commonsdk/framework/UMWorkDispatch;->sendEvent(Landroid/content/Context;ILcom/umeng/commonsdk/framework/UMLogDataProtocol;Ljava/lang/Object;)V

    .line 290
    iget-object v0, p0, Lcom/umeng/analytics/b;->a:Landroid/content/Context;

    const/16 v1, 0x1003

    iget-object v2, p0, Lcom/umeng/analytics/b;->a:Landroid/content/Context;

    .line 292
    invoke-static {v2}, Lcom/umeng/analytics/CoreProtocol;->getInstance(Landroid/content/Context;)Lcom/umeng/analytics/CoreProtocol;

    move-result-object v2

    const/4 v3, 0x0

    .line 290
    invoke-static {v0, v1, v2, v3}, Lcom/umeng/commonsdk/framework/UMWorkDispatch;->sendEvent(Landroid/content/Context;ILcom/umeng/commonsdk/framework/UMLogDataProtocol;Ljava/lang/Object;)V

    .line 293
    iget-object v0, p0, Lcom/umeng/analytics/b;->a:Landroid/content/Context;

    const/16 v1, 0x1009

    iget-object v2, p0, Lcom/umeng/analytics/b;->a:Landroid/content/Context;

    .line 295
    invoke-static {v2}, Lcom/umeng/analytics/CoreProtocol;->getInstance(Landroid/content/Context;)Lcom/umeng/analytics/CoreProtocol;

    move-result-object v2

    const/4 v3, 0x0

    .line 293
    invoke-static {v0, v1, v2, v3}, Lcom/umeng/commonsdk/framework/UMWorkDispatch;->sendEvent(Landroid/content/Context;ILcom/umeng/commonsdk/framework/UMLogDataProtocol;Ljava/lang/Object;)V
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_0

    .line 299
    :goto_0
    iget-object v0, p0, Lcom/umeng/analytics/b;->b:Lcom/umeng/analytics/pro/r;

    if-eqz v0, :cond_0

    iget-object v0, p0, Lcom/umeng/analytics/b;->b:Lcom/umeng/analytics/pro/r;

    invoke-interface {v0}, Lcom/umeng/analytics/pro/r;->b()V

    .line 300
    :cond_0
    return-void

    .line 296
    :catch_0
    move-exception v0

    goto :goto_0
.end method

.method g()V
    .locals 4

    .prologue
    .line 431
    iget-object v0, p0, Lcom/umeng/analytics/b;->a:Landroid/content/Context;

    const/16 v1, 0x1006

    iget-object v2, p0, Lcom/umeng/analytics/b;->a:Landroid/content/Context;

    .line 433
    invoke-static {v2}, Lcom/umeng/analytics/CoreProtocol;->getInstance(Landroid/content/Context;)Lcom/umeng/analytics/CoreProtocol;

    move-result-object v2

    const/4 v3, 0x0

    .line 431
    invoke-static {v0, v1, v2, v3}, Lcom/umeng/commonsdk/framework/UMWorkDispatch;->sendEvent(Landroid/content/Context;ILcom/umeng/commonsdk/framework/UMLogDataProtocol;Ljava/lang/Object;)V

    .line 434
    return-void
.end method

.method public h()V
    .locals 3

    .prologue
    .line 750
    :try_start_0
    iget-object v0, p0, Lcom/umeng/analytics/b;->i:Lorg/json/JSONObject;

    if-eqz v0, :cond_0

    .line 751
    iget-object v0, p0, Lcom/umeng/analytics/b;->a:Landroid/content/Context;

    invoke-static {v0}, Lcom/umeng/commonsdk/statistics/internal/PreferenceWrapper;->getDefault(Landroid/content/Context;)Landroid/content/SharedPreferences;

    move-result-object v0

    .line 752
    invoke-interface {v0}, Landroid/content/SharedPreferences;->edit()Landroid/content/SharedPreferences$Editor;

    move-result-object v0

    .line 753
    const-string v1, "sp"

    iget-object v2, p0, Lcom/umeng/analytics/b;->i:Lorg/json/JSONObject;

    invoke-virtual {v2}, Lorg/json/JSONObject;->toString()Ljava/lang/String;

    move-result-object v2

    invoke-interface {v0, v1, v2}, Landroid/content/SharedPreferences$Editor;->putString(Ljava/lang/String;Ljava/lang/String;)Landroid/content/SharedPreferences$Editor;

    .line 754
    invoke-interface {v0}, Landroid/content/SharedPreferences$Editor;->commit()Z

    .line 760
    :goto_0
    return-void

    .line 756
    :cond_0
    new-instance v0, Lorg/json/JSONObject;

    invoke-direct {v0}, Lorg/json/JSONObject;-><init>()V

    iput-object v0, p0, Lcom/umeng/analytics/b;->i:Lorg/json/JSONObject;
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_0

    goto :goto_0

    .line 758
    :catch_0
    move-exception v0

    goto :goto_0
.end method

.method public i()Lorg/json/JSONObject;
    .locals 1

    .prologue
    .line 807
    :try_start_0
    iget-object v0, p0, Lcom/umeng/analytics/b;->i:Lorg/json/JSONObject;

    if-nez v0, :cond_0

    .line 808
    new-instance v0, Lorg/json/JSONObject;

    invoke-direct {v0}, Lorg/json/JSONObject;-><init>()V

    iput-object v0, p0, Lcom/umeng/analytics/b;->i:Lorg/json/JSONObject;
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_0

    .line 812
    :cond_0
    :goto_0
    iget-object v0, p0, Lcom/umeng/analytics/b;->i:Lorg/json/JSONObject;

    return-object v0

    .line 810
    :catch_0
    move-exception v0

    goto :goto_0
.end method

.method public j()V
    .locals 2

    .prologue
    .line 867
    :try_start_0
    iget-object v0, p0, Lcom/umeng/analytics/b;->a:Landroid/content/Context;

    invoke-static {v0}, Lcom/umeng/commonsdk/statistics/internal/PreferenceWrapper;->getDefault(Landroid/content/Context;)Landroid/content/SharedPreferences;

    move-result-object v0

    .line 868
    invoke-interface {v0}, Landroid/content/SharedPreferences;->edit()Landroid/content/SharedPreferences$Editor;

    move-result-object v0

    .line 869
    const-string v1, "sp"

    invoke-interface {v0, v1}, Landroid/content/SharedPreferences$Editor;->remove(Ljava/lang/String;)Landroid/content/SharedPreferences$Editor;

    .line 870
    invoke-interface {v0}, Landroid/content/SharedPreferences$Editor;->commit()Z
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_0

    .line 874
    :goto_0
    return-void

    .line 871
    :catch_0
    move-exception v0

    .line 872
    invoke-virtual {v0}, Ljava/lang/Throwable;->printStackTrace()V

    goto :goto_0
.end method
