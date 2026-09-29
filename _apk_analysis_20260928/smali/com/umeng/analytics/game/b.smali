.class Lcom/umeng/analytics/game/b;
.super Ljava/lang/Object;
.source "InternalGameAgent.java"

# interfaces
.implements Lcom/umeng/analytics/pro/r;


# static fields
.field public static a:Z


# instance fields
.field private A:Landroid/content/Context;

.field private b:Lcom/umeng/analytics/b;

.field private c:Lcom/umeng/analytics/game/a;

.field private final d:I

.field private final e:I

.field private final f:I

.field private final g:I

.field private final h:I

.field private final i:Ljava/lang/String;

.field private final j:Ljava/lang/String;

.field private final k:Ljava/lang/String;

.field private final l:Ljava/lang/String;

.field private final m:Ljava/lang/String;

.field private final n:Ljava/lang/String;

.field private final o:Ljava/lang/String;

.field private final p:Ljava/lang/String;

.field private final q:Ljava/lang/String;

.field private final r:Ljava/lang/String;

.field private final s:Ljava/lang/String;

.field private final t:Ljava/lang/String;

.field private final u:Ljava/lang/String;

.field private final v:Ljava/lang/String;

.field private final w:Ljava/lang/String;

.field private final x:Ljava/lang/String;

.field private final y:Ljava/lang/String;

.field private final z:Ljava/lang/String;


# direct methods
.method static constructor <clinit>()V
    .locals 1

    .prologue
    .line 20
    const/4 v0, 0x1

    sput-boolean v0, Lcom/umeng/analytics/game/b;->a:Z

    return-void
.end method

.method public constructor <init>()V
    .locals 2

    .prologue
    const/4 v1, 0x1

    .line 53
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    .line 18
    invoke-static {}, Lcom/umeng/analytics/MobclickAgent;->getAgent()Lcom/umeng/analytics/b;

    move-result-object v0

    iput-object v0, p0, Lcom/umeng/analytics/game/b;->b:Lcom/umeng/analytics/b;

    .line 19
    const/4 v0, 0x0

    iput-object v0, p0, Lcom/umeng/analytics/game/b;->c:Lcom/umeng/analytics/game/a;

    .line 22
    const/16 v0, 0x64

    iput v0, p0, Lcom/umeng/analytics/game/b;->d:I

    .line 23
    iput v1, p0, Lcom/umeng/analytics/game/b;->e:I

    .line 25
    const/4 v0, 0x0

    iput v0, p0, Lcom/umeng/analytics/game/b;->f:I

    .line 26
    const/4 v0, -0x1

    iput v0, p0, Lcom/umeng/analytics/game/b;->g:I

    .line 27
    iput v1, p0, Lcom/umeng/analytics/game/b;->h:I

    .line 29
    const-string v0, "level"

    iput-object v0, p0, Lcom/umeng/analytics/game/b;->i:Ljava/lang/String;

    .line 30
    const-string v0, "pay"

    iput-object v0, p0, Lcom/umeng/analytics/game/b;->j:Ljava/lang/String;

    .line 31
    const-string v0, "buy"

    iput-object v0, p0, Lcom/umeng/analytics/game/b;->k:Ljava/lang/String;

    .line 32
    const-string v0, "use"

    iput-object v0, p0, Lcom/umeng/analytics/game/b;->l:Ljava/lang/String;

    .line 33
    const-string v0, "bonus"

    iput-object v0, p0, Lcom/umeng/analytics/game/b;->m:Ljava/lang/String;

    .line 35
    const-string v0, "item"

    iput-object v0, p0, Lcom/umeng/analytics/game/b;->n:Ljava/lang/String;

    .line 36
    const-string v0, "cash"

    iput-object v0, p0, Lcom/umeng/analytics/game/b;->o:Ljava/lang/String;

    .line 37
    const-string v0, "coin"

    iput-object v0, p0, Lcom/umeng/analytics/game/b;->p:Ljava/lang/String;

    .line 38
    const-string v0, "source"

    iput-object v0, p0, Lcom/umeng/analytics/game/b;->q:Ljava/lang/String;

    .line 39
    const-string v0, "amount"

    iput-object v0, p0, Lcom/umeng/analytics/game/b;->r:Ljava/lang/String;

    .line 40
    const-string v0, "user_level"

    iput-object v0, p0, Lcom/umeng/analytics/game/b;->s:Ljava/lang/String;

    .line 41
    const-string v0, "bonus_source"

    iput-object v0, p0, Lcom/umeng/analytics/game/b;->t:Ljava/lang/String;

    .line 43
    const-string v0, "level"

    iput-object v0, p0, Lcom/umeng/analytics/game/b;->u:Ljava/lang/String;

    .line 44
    const-string v0, "status"

    iput-object v0, p0, Lcom/umeng/analytics/game/b;->v:Ljava/lang/String;

    .line 45
    const-string v0, "duration"

    iput-object v0, p0, Lcom/umeng/analytics/game/b;->w:Ljava/lang/String;

    .line 47
    const-string v0, "curtype"

    iput-object v0, p0, Lcom/umeng/analytics/game/b;->x:Ljava/lang/String;

    .line 48
    const-string v0, "orderid"

    iput-object v0, p0, Lcom/umeng/analytics/game/b;->y:Ljava/lang/String;

    .line 50
    const-string v0, "UMGameAgent.init(Context) should be called before any game api"

    iput-object v0, p0, Lcom/umeng/analytics/game/b;->z:Ljava/lang/String;

    .line 54
    sput-boolean v1, Lcom/umeng/analytics/game/b;->a:Z

    .line 55
    return-void
.end method

.method private a(Ljava/lang/String;I)V
    .locals 5

    .prologue
    .line 120
    iget-object v0, p0, Lcom/umeng/analytics/game/b;->A:Landroid/content/Context;

    if-nez v0, :cond_0

    .line 121
    const-string v0, "UMGameAgent.init(Context) should be called before any game api"

    invoke-static {v0}, Lcom/umeng/commonsdk/statistics/common/MLog;->e(Ljava/lang/String;)V

    .line 147
    :goto_0
    return-void

    .line 124
    :cond_0
    iget-object v0, p0, Lcom/umeng/analytics/game/b;->A:Landroid/content/Context;

    invoke-static {v0}, Lcom/umeng/analytics/AnalyticsConfig;->getVerticalType(Landroid/content/Context;)I

    move-result v0

    sget-object v1, Lcom/umeng/analytics/MobclickAgent$EScenarioType;->E_DUM_NORMAL:Lcom/umeng/analytics/MobclickAgent$EScenarioType;

    invoke-virtual {v1}, Lcom/umeng/analytics/MobclickAgent$EScenarioType;->toValue()I

    move-result v1

    if-eq v0, v1, :cond_1

    iget-object v0, p0, Lcom/umeng/analytics/game/b;->A:Landroid/content/Context;

    .line 125
    invoke-static {v0}, Lcom/umeng/analytics/AnalyticsConfig;->getVerticalType(Landroid/content/Context;)I

    move-result v0

    sget-object v1, Lcom/umeng/analytics/MobclickAgent$EScenarioType;->E_UM_NORMAL:Lcom/umeng/analytics/MobclickAgent$EScenarioType;

    invoke-virtual {v1}, Lcom/umeng/analytics/MobclickAgent$EScenarioType;->toValue()I

    move-result v1

    if-ne v0, v1, :cond_2

    .line 126
    :cond_1
    const-string v0, "UMGameAgent class is UMGameAgent API, can\'t be use in no-game scenario. "

    invoke-static {v0}, Lcom/umeng/commonsdk/statistics/common/MLog;->e(Ljava/lang/String;)V

    goto :goto_0

    .line 129
    :cond_2
    iget-object v0, p0, Lcom/umeng/analytics/game/b;->c:Lcom/umeng/analytics/game/a;

    invoke-virtual {v0, p1}, Lcom/umeng/analytics/game/a;->b(Ljava/lang/String;)Lcom/umeng/analytics/game/a$a;

    move-result-object v0

    .line 130
    if-eqz v0, :cond_5

    .line 131
    invoke-virtual {v0}, Lcom/umeng/analytics/game/a$a;->e()J

    move-result-wide v0

    .line 132
    const-wide/16 v2, 0x0

    cmp-long v2, v0, v2

    if-gtz v2, :cond_3

    .line 133
    const-string v0, "level duration is 0"

    invoke-static {v0}, Lcom/umeng/commonsdk/statistics/common/MLog;->d(Ljava/lang/String;)V

    goto :goto_0

    .line 137
    :cond_3
    new-instance v2, Ljava/util/HashMap;

    invoke-direct {v2}, Ljava/util/HashMap;-><init>()V

    .line 139
    const-string v3, "level"

    invoke-virtual {v2, v3, p1}, Ljava/util/HashMap;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    .line 140
    const-string v3, "status"

    invoke-static {p2}, Ljava/lang/Integer;->valueOf(I)Ljava/lang/Integer;

    move-result-object v4

    invoke-virtual {v2, v3, v4}, Ljava/util/HashMap;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    .line 141
    const-string v3, "duration"

    invoke-static {v0, v1}, Ljava/lang/Long;->valueOf(J)Ljava/lang/Long;

    move-result-object v0

    invoke-virtual {v2, v3, v0}, Ljava/util/HashMap;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    .line 142
    iget-object v0, p0, Lcom/umeng/analytics/game/b;->c:Lcom/umeng/analytics/game/a;

    iget-object v0, v0, Lcom/umeng/analytics/game/a;->b:Ljava/lang/String;

    if-eqz v0, :cond_4

    const-string v0, "user_level"

    iget-object v1, p0, Lcom/umeng/analytics/game/b;->c:Lcom/umeng/analytics/game/a;

    iget-object v1, v1, Lcom/umeng/analytics/game/a;->b:Ljava/lang/String;

    invoke-virtual {v2, v0, v1}, Ljava/util/HashMap;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    .line 143
    :cond_4
    iget-object v0, p0, Lcom/umeng/analytics/game/b;->b:Lcom/umeng/analytics/b;

    iget-object v1, p0, Lcom/umeng/analytics/game/b;->A:Landroid/content/Context;

    const-string v3, "level"

    invoke-virtual {v0, v1, v3, v2}, Lcom/umeng/analytics/b;->a(Landroid/content/Context;Ljava/lang/String;Ljava/util/HashMap;)V

    goto :goto_0

    .line 145
    :cond_5
    const-string v0, "finishLevel(or failLevel) called before startLevel"

    const/4 v1, 0x0

    new-array v1, v1, [Ljava/lang/Object;

    invoke-static {v0, v1}, Ljava/lang/String;->format(Ljava/lang/String;[Ljava/lang/Object;)Ljava/lang/String;

    move-result-object v0

    invoke-static {v0}, Lcom/umeng/commonsdk/statistics/common/MLog;->w(Ljava/lang/String;)V

    goto :goto_0
.end method


# virtual methods
.method public a()V
    .locals 2

    .prologue
    .line 296
    const-string v0, "App resume from background"

    invoke-static {v0}, Lcom/umeng/commonsdk/statistics/common/MLog;->d(Ljava/lang/String;)V

    .line 298
    iget-object v0, p0, Lcom/umeng/analytics/game/b;->A:Landroid/content/Context;

    if-nez v0, :cond_1

    .line 299
    const-string v0, "UMGameAgent.init(Context) should be called before any game api"

    invoke-static {v0}, Lcom/umeng/commonsdk/statistics/common/MLog;->e(Ljava/lang/String;)V

    .line 310
    :cond_0
    :goto_0
    return-void

    .line 302
    :cond_1
    iget-object v0, p0, Lcom/umeng/analytics/game/b;->A:Landroid/content/Context;

    invoke-static {v0}, Lcom/umeng/analytics/AnalyticsConfig;->getVerticalType(Landroid/content/Context;)I

    move-result v0

    sget-object v1, Lcom/umeng/analytics/MobclickAgent$EScenarioType;->E_DUM_NORMAL:Lcom/umeng/analytics/MobclickAgent$EScenarioType;

    invoke-virtual {v1}, Lcom/umeng/analytics/MobclickAgent$EScenarioType;->toValue()I

    move-result v1

    if-eq v0, v1, :cond_2

    iget-object v0, p0, Lcom/umeng/analytics/game/b;->A:Landroid/content/Context;

    .line 303
    invoke-static {v0}, Lcom/umeng/analytics/AnalyticsConfig;->getVerticalType(Landroid/content/Context;)I

    move-result v0

    sget-object v1, Lcom/umeng/analytics/MobclickAgent$EScenarioType;->E_UM_NORMAL:Lcom/umeng/analytics/MobclickAgent$EScenarioType;

    invoke-virtual {v1}, Lcom/umeng/analytics/MobclickAgent$EScenarioType;->toValue()I

    move-result v1

    if-ne v0, v1, :cond_3

    .line 304
    :cond_2
    const-string v0, "UMGameAgent class is UMGameAgent API, can\'t be use in no-game scenario. "

    invoke-static {v0}, Lcom/umeng/commonsdk/statistics/common/MLog;->e(Ljava/lang/String;)V

    goto :goto_0

    .line 307
    :cond_3
    sget-boolean v0, Lcom/umeng/analytics/game/b;->a:Z

    if-eqz v0, :cond_0

    .line 308
    iget-object v0, p0, Lcom/umeng/analytics/game/b;->c:Lcom/umeng/analytics/game/a;

    invoke-virtual {v0}, Lcom/umeng/analytics/game/a;->b()V

    goto :goto_0
.end method

.method a(DDI)V
    .locals 7

    .prologue
    const-wide/high16 v4, 0x4059000000000000L    # 100.0

    .line 186
    iget-object v0, p0, Lcom/umeng/analytics/game/b;->A:Landroid/content/Context;

    if-nez v0, :cond_0

    .line 187
    const-string v0, "UMGameAgent.init(Context) should be called before any game api"

    invoke-static {v0}, Lcom/umeng/commonsdk/statistics/common/MLog;->e(Ljava/lang/String;)V

    .line 205
    :goto_0
    return-void

    .line 190
    :cond_0
    iget-object v0, p0, Lcom/umeng/analytics/game/b;->A:Landroid/content/Context;

    invoke-static {v0}, Lcom/umeng/analytics/AnalyticsConfig;->getVerticalType(Landroid/content/Context;)I

    move-result v0

    sget-object v1, Lcom/umeng/analytics/MobclickAgent$EScenarioType;->E_DUM_NORMAL:Lcom/umeng/analytics/MobclickAgent$EScenarioType;

    invoke-virtual {v1}, Lcom/umeng/analytics/MobclickAgent$EScenarioType;->toValue()I

    move-result v1

    if-eq v0, v1, :cond_1

    iget-object v0, p0, Lcom/umeng/analytics/game/b;->A:Landroid/content/Context;

    .line 191
    invoke-static {v0}, Lcom/umeng/analytics/AnalyticsConfig;->getVerticalType(Landroid/content/Context;)I

    move-result v0

    sget-object v1, Lcom/umeng/analytics/MobclickAgent$EScenarioType;->E_UM_NORMAL:Lcom/umeng/analytics/MobclickAgent$EScenarioType;

    invoke-virtual {v1}, Lcom/umeng/analytics/MobclickAgent$EScenarioType;->toValue()I

    move-result v1

    if-ne v0, v1, :cond_2

    .line 192
    :cond_1
    const-string v0, "UMGameAgent class is UMGameAgent API, can\'t be use in no-game scenario. "

    invoke-static {v0}, Lcom/umeng/commonsdk/statistics/common/MLog;->e(Ljava/lang/String;)V

    goto :goto_0

    .line 195
    :cond_2
    new-instance v0, Ljava/util/HashMap;

    invoke-direct {v0}, Ljava/util/HashMap;-><init>()V

    .line 197
    const-string v1, "cash"

    mul-double v2, p1, v4

    double-to-long v2, v2

    invoke-static {v2, v3}, Ljava/lang/Long;->valueOf(J)Ljava/lang/Long;

    move-result-object v2

    invoke-virtual {v0, v1, v2}, Ljava/util/HashMap;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    .line 198
    const-string v1, "coin"

    mul-double v2, p3, v4

    double-to-long v2, v2

    invoke-static {v2, v3}, Ljava/lang/Long;->valueOf(J)Ljava/lang/Long;

    move-result-object v2

    invoke-virtual {v0, v1, v2}, Ljava/util/HashMap;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    .line 199
    const-string v1, "source"

    invoke-static {p5}, Ljava/lang/Integer;->valueOf(I)Ljava/lang/Integer;

    move-result-object v2

    invoke-virtual {v0, v1, v2}, Ljava/util/HashMap;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    .line 201
    iget-object v1, p0, Lcom/umeng/analytics/game/b;->c:Lcom/umeng/analytics/game/a;

    iget-object v1, v1, Lcom/umeng/analytics/game/a;->b:Ljava/lang/String;

    if-eqz v1, :cond_3

    const-string v1, "user_level"

    iget-object v2, p0, Lcom/umeng/analytics/game/b;->c:Lcom/umeng/analytics/game/a;

    iget-object v2, v2, Lcom/umeng/analytics/game/a;->b:Ljava/lang/String;

    invoke-virtual {v0, v1, v2}, Ljava/util/HashMap;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    .line 202
    :cond_3
    iget-object v1, p0, Lcom/umeng/analytics/game/b;->c:Lcom/umeng/analytics/game/a;

    iget-object v1, v1, Lcom/umeng/analytics/game/a;->a:Ljava/lang/String;

    if-eqz v1, :cond_4

    const-string v1, "level"

    iget-object v2, p0, Lcom/umeng/analytics/game/b;->c:Lcom/umeng/analytics/game/a;

    iget-object v2, v2, Lcom/umeng/analytics/game/a;->a:Ljava/lang/String;

    invoke-virtual {v0, v1, v2}, Ljava/util/HashMap;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    .line 204
    :cond_4
    iget-object v1, p0, Lcom/umeng/analytics/game/b;->b:Lcom/umeng/analytics/b;

    iget-object v2, p0, Lcom/umeng/analytics/game/b;->A:Landroid/content/Context;

    const-string v3, "pay"

    invoke-virtual {v1, v2, v3, v0}, Lcom/umeng/analytics/b;->a(Landroid/content/Context;Ljava/lang/String;Ljava/util/HashMap;)V

    goto :goto_0
.end method

.method a(DI)V
    .locals 5

    .prologue
    .line 264
    iget-object v0, p0, Lcom/umeng/analytics/game/b;->A:Landroid/content/Context;

    if-nez v0, :cond_0

    .line 265
    const-string v0, "UMGameAgent.init(Context) should be called before any game api"

    invoke-static {v0}, Lcom/umeng/commonsdk/statistics/common/MLog;->e(Ljava/lang/String;)V

    .line 282
    :goto_0
    return-void

    .line 268
    :cond_0
    iget-object v0, p0, Lcom/umeng/analytics/game/b;->A:Landroid/content/Context;

    invoke-static {v0}, Lcom/umeng/analytics/AnalyticsConfig;->getVerticalType(Landroid/content/Context;)I

    move-result v0

    sget-object v1, Lcom/umeng/analytics/MobclickAgent$EScenarioType;->E_DUM_NORMAL:Lcom/umeng/analytics/MobclickAgent$EScenarioType;

    invoke-virtual {v1}, Lcom/umeng/analytics/MobclickAgent$EScenarioType;->toValue()I

    move-result v1

    if-eq v0, v1, :cond_1

    iget-object v0, p0, Lcom/umeng/analytics/game/b;->A:Landroid/content/Context;

    .line 269
    invoke-static {v0}, Lcom/umeng/analytics/AnalyticsConfig;->getVerticalType(Landroid/content/Context;)I

    move-result v0

    sget-object v1, Lcom/umeng/analytics/MobclickAgent$EScenarioType;->E_UM_NORMAL:Lcom/umeng/analytics/MobclickAgent$EScenarioType;

    invoke-virtual {v1}, Lcom/umeng/analytics/MobclickAgent$EScenarioType;->toValue()I

    move-result v1

    if-ne v0, v1, :cond_2

    .line 270
    :cond_1
    const-string v0, "UMGameAgent class is UMGameAgent API, can\'t be use in no-game scenario. "

    invoke-static {v0}, Lcom/umeng/commonsdk/statistics/common/MLog;->e(Ljava/lang/String;)V

    goto :goto_0

    .line 274
    :cond_2
    new-instance v0, Ljava/util/HashMap;

    invoke-direct {v0}, Ljava/util/HashMap;-><init>()V

    .line 275
    const-string v1, "coin"

    const-wide/high16 v2, 0x4059000000000000L    # 100.0

    mul-double/2addr v2, p1

    double-to-long v2, v2

    invoke-static {v2, v3}, Ljava/lang/Long;->valueOf(J)Ljava/lang/Long;

    move-result-object v2

    invoke-virtual {v0, v1, v2}, Ljava/util/HashMap;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    .line 276
    const-string v1, "bonus_source"

    invoke-static {p3}, Ljava/lang/Integer;->valueOf(I)Ljava/lang/Integer;

    move-result-object v2

    invoke-virtual {v0, v1, v2}, Ljava/util/HashMap;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    .line 278
    iget-object v1, p0, Lcom/umeng/analytics/game/b;->c:Lcom/umeng/analytics/game/a;

    iget-object v1, v1, Lcom/umeng/analytics/game/a;->b:Ljava/lang/String;

    if-eqz v1, :cond_3

    const-string v1, "user_level"

    iget-object v2, p0, Lcom/umeng/analytics/game/b;->c:Lcom/umeng/analytics/game/a;

    iget-object v2, v2, Lcom/umeng/analytics/game/a;->b:Ljava/lang/String;

    invoke-virtual {v0, v1, v2}, Ljava/util/HashMap;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    .line 279
    :cond_3
    iget-object v1, p0, Lcom/umeng/analytics/game/b;->c:Lcom/umeng/analytics/game/a;

    iget-object v1, v1, Lcom/umeng/analytics/game/a;->a:Ljava/lang/String;

    if-eqz v1, :cond_4

    const-string v1, "level"

    iget-object v2, p0, Lcom/umeng/analytics/game/b;->c:Lcom/umeng/analytics/game/a;

    iget-object v2, v2, Lcom/umeng/analytics/game/a;->a:Ljava/lang/String;

    invoke-virtual {v0, v1, v2}, Ljava/util/HashMap;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    .line 281
    :cond_4
    iget-object v1, p0, Lcom/umeng/analytics/game/b;->b:Lcom/umeng/analytics/b;

    iget-object v2, p0, Lcom/umeng/analytics/game/b;->A:Landroid/content/Context;

    const-string v3, "bonus"

    invoke-virtual {v1, v2, v3, v0}, Lcom/umeng/analytics/b;->a(Landroid/content/Context;Ljava/lang/String;Ljava/util/HashMap;)V

    goto :goto_0
.end method

.method a(DLjava/lang/String;DILjava/lang/String;)V
    .locals 6

    .prologue
    const-wide/high16 v4, 0x4059000000000000L    # 100.0

    const-wide/16 v2, 0x0

    .line 330
    iget-object v0, p0, Lcom/umeng/analytics/game/b;->A:Landroid/content/Context;

    if-nez v0, :cond_1

    .line 331
    const-string v0, "UMGameAgent.init(Context) should be called before any game api"

    invoke-static {v0}, Lcom/umeng/commonsdk/statistics/common/MLog;->e(Ljava/lang/String;)V

    .line 367
    :cond_0
    :goto_0
    return-void

    .line 334
    :cond_1
    iget-object v0, p0, Lcom/umeng/analytics/game/b;->A:Landroid/content/Context;

    invoke-static {v0}, Lcom/umeng/analytics/AnalyticsConfig;->getVerticalType(Landroid/content/Context;)I

    move-result v0

    sget-object v1, Lcom/umeng/analytics/MobclickAgent$EScenarioType;->E_DUM_NORMAL:Lcom/umeng/analytics/MobclickAgent$EScenarioType;

    invoke-virtual {v1}, Lcom/umeng/analytics/MobclickAgent$EScenarioType;->toValue()I

    move-result v1

    if-eq v0, v1, :cond_2

    iget-object v0, p0, Lcom/umeng/analytics/game/b;->A:Landroid/content/Context;

    .line 335
    invoke-static {v0}, Lcom/umeng/analytics/AnalyticsConfig;->getVerticalType(Landroid/content/Context;)I

    move-result v0

    sget-object v1, Lcom/umeng/analytics/MobclickAgent$EScenarioType;->E_UM_NORMAL:Lcom/umeng/analytics/MobclickAgent$EScenarioType;

    invoke-virtual {v1}, Lcom/umeng/analytics/MobclickAgent$EScenarioType;->toValue()I

    move-result v1

    if-ne v0, v1, :cond_3

    .line 336
    :cond_2
    const-string v0, "UMGameAgent class is UMGameAgent API, can\'t be use in no-game scenario. "

    invoke-static {v0}, Lcom/umeng/commonsdk/statistics/common/MLog;->e(Ljava/lang/String;)V

    goto :goto_0

    .line 339
    :cond_3
    cmpl-double v0, p1, v2

    if-ltz v0, :cond_0

    cmpl-double v0, p4, v2

    if-ltz v0, :cond_0

    .line 340
    new-instance v1, Ljava/util/HashMap;

    invoke-direct {v1}, Ljava/util/HashMap;-><init>()V

    .line 341
    invoke-static {p3}, Landroid/text/TextUtils;->isEmpty(Ljava/lang/CharSequence;)Z

    move-result v0

    if-nez v0, :cond_4

    .line 342
    invoke-virtual {p3}, Ljava/lang/String;->length()I

    move-result v0

    if-lez v0, :cond_4

    invoke-virtual {p3}, Ljava/lang/String;->length()I

    move-result v0

    const/4 v2, 0x3

    if-gt v0, v2, :cond_4

    .line 343
    const-string v0, "curtype"

    invoke-virtual {v1, v0, p3}, Ljava/util/HashMap;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    .line 346
    :cond_4
    invoke-static {p7}, Landroid/text/TextUtils;->isEmpty(Ljava/lang/CharSequence;)Z

    move-result v0

    if-nez v0, :cond_5

    .line 348
    :try_start_0
    const-string v0, "UTF-8"

    invoke-virtual {p7, v0}, Ljava/lang/String;->getBytes(Ljava/lang/String;)[B

    move-result-object v0

    array-length v0, v0

    .line 349
    if-lez v0, :cond_5

    const/16 v2, 0x400

    if-gt v0, v2, :cond_5

    .line 350
    const-string v0, "orderid"

    invoke-virtual {v1, v0, p7}, Ljava/util/HashMap;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;
    :try_end_0
    .catch Ljava/io/UnsupportedEncodingException; {:try_start_0 .. :try_end_0} :catch_0

    .line 357
    :cond_5
    :goto_1
    const-string v0, "cash"

    mul-double v2, p1, v4

    double-to-long v2, v2

    invoke-static {v2, v3}, Ljava/lang/Long;->valueOf(J)Ljava/lang/Long;

    move-result-object v2

    invoke-virtual {v1, v0, v2}, Ljava/util/HashMap;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    .line 358
    const-string v0, "coin"

    mul-double v2, p4, v4

    double-to-long v2, v2

    invoke-static {v2, v3}, Ljava/lang/Long;->valueOf(J)Ljava/lang/Long;

    move-result-object v2

    invoke-virtual {v1, v0, v2}, Ljava/util/HashMap;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    .line 359
    const-string v0, "source"

    invoke-static {p6}, Ljava/lang/Integer;->valueOf(I)Ljava/lang/Integer;

    move-result-object v2

    invoke-virtual {v1, v0, v2}, Ljava/util/HashMap;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    .line 361
    iget-object v0, p0, Lcom/umeng/analytics/game/b;->c:Lcom/umeng/analytics/game/a;

    iget-object v0, v0, Lcom/umeng/analytics/game/a;->b:Ljava/lang/String;

    if-eqz v0, :cond_6

    const-string v0, "user_level"

    iget-object v2, p0, Lcom/umeng/analytics/game/b;->c:Lcom/umeng/analytics/game/a;

    iget-object v2, v2, Lcom/umeng/analytics/game/a;->b:Ljava/lang/String;

    invoke-virtual {v1, v0, v2}, Ljava/util/HashMap;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    .line 362
    :cond_6
    iget-object v0, p0, Lcom/umeng/analytics/game/b;->c:Lcom/umeng/analytics/game/a;

    iget-object v0, v0, Lcom/umeng/analytics/game/a;->a:Ljava/lang/String;

    if-eqz v0, :cond_7

    const-string v0, "level"

    iget-object v2, p0, Lcom/umeng/analytics/game/b;->c:Lcom/umeng/analytics/game/a;

    iget-object v2, v2, Lcom/umeng/analytics/game/a;->a:Ljava/lang/String;

    invoke-virtual {v1, v0, v2}, Ljava/util/HashMap;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    .line 364
    :cond_7
    iget-object v0, p0, Lcom/umeng/analytics/game/b;->b:Lcom/umeng/analytics/b;

    iget-object v2, p0, Lcom/umeng/analytics/game/b;->A:Landroid/content/Context;

    const-string v3, "pay"

    invoke-virtual {v0, v2, v3, v1}, Lcom/umeng/analytics/b;->a(Landroid/content/Context;Ljava/lang/String;Ljava/util/HashMap;)V

    goto/16 :goto_0

    .line 352
    :catch_0
    move-exception v0

    .line 353
    invoke-virtual {v0}, Ljava/io/UnsupportedEncodingException;->printStackTrace()V

    goto :goto_1
.end method

.method a(DLjava/lang/String;IDI)V
    .locals 7

    .prologue
    .line 208
    iget-object v0, p0, Lcom/umeng/analytics/game/b;->A:Landroid/content/Context;

    invoke-static {v0}, Lcom/umeng/analytics/AnalyticsConfig;->getVerticalType(Landroid/content/Context;)I

    move-result v0

    sget-object v1, Lcom/umeng/analytics/MobclickAgent$EScenarioType;->E_DUM_NORMAL:Lcom/umeng/analytics/MobclickAgent$EScenarioType;

    invoke-virtual {v1}, Lcom/umeng/analytics/MobclickAgent$EScenarioType;->toValue()I

    move-result v1

    if-eq v0, v1, :cond_0

    iget-object v0, p0, Lcom/umeng/analytics/game/b;->A:Landroid/content/Context;

    .line 209
    invoke-static {v0}, Lcom/umeng/analytics/AnalyticsConfig;->getVerticalType(Landroid/content/Context;)I

    move-result v0

    sget-object v1, Lcom/umeng/analytics/MobclickAgent$EScenarioType;->E_UM_NORMAL:Lcom/umeng/analytics/MobclickAgent$EScenarioType;

    invoke-virtual {v1}, Lcom/umeng/analytics/MobclickAgent$EScenarioType;->toValue()I

    move-result v1

    if-ne v0, v1, :cond_1

    .line 210
    :cond_0
    const-string v0, "UMGameAgent class is UMGameAgent API, can\'t be use in no-game scenario. "

    invoke-static {v0}, Lcom/umeng/commonsdk/statistics/common/MLog;->e(Ljava/lang/String;)V

    .line 215
    :goto_0
    return-void

    .line 213
    :cond_1
    int-to-double v0, p4

    mul-double v4, p5, v0

    move-object v1, p0

    move-wide v2, p1

    move v6, p7

    invoke-virtual/range {v1 .. v6}, Lcom/umeng/analytics/game/b;->a(DDI)V

    .line 214
    invoke-virtual {p0, p3, p4, p5, p6}, Lcom/umeng/analytics/game/b;->a(Ljava/lang/String;ID)V

    goto :goto_0
.end method

.method a(Landroid/content/Context;)V
    .locals 2

    .prologue
    .line 58
    if-nez p1, :cond_0

    .line 59
    const-string v0, "Context is null, can\'t init GameAgent"

    invoke-static {v0}, Lcom/umeng/commonsdk/statistics/common/MLog;->e(Ljava/lang/String;)V

    .line 67
    :goto_0
    return-void

    .line 62
    :cond_0
    invoke-virtual {p1}, Landroid/content/Context;->getApplicationContext()Landroid/content/Context;

    move-result-object v0

    iput-object v0, p0, Lcom/umeng/analytics/game/b;->A:Landroid/content/Context;

    .line 63
    iget-object v0, p0, Lcom/umeng/analytics/game/b;->b:Lcom/umeng/analytics/b;

    invoke-virtual {v0, p0}, Lcom/umeng/analytics/b;->a(Lcom/umeng/analytics/pro/r;)V

    .line 64
    new-instance v0, Lcom/umeng/analytics/game/a;

    iget-object v1, p0, Lcom/umeng/analytics/game/b;->A:Landroid/content/Context;

    invoke-direct {v0, v1}, Lcom/umeng/analytics/game/a;-><init>(Landroid/content/Context;)V

    iput-object v0, p0, Lcom/umeng/analytics/game/b;->c:Lcom/umeng/analytics/game/a;

    goto :goto_0
.end method

.method a(Ljava/lang/String;)V
    .locals 2

    .prologue
    .line 77
    :try_start_0
    iget-object v0, p0, Lcom/umeng/analytics/game/b;->A:Landroid/content/Context;

    if-nez v0, :cond_1

    .line 78
    const-string v0, "UMGameAgent.init(Context) should be called before any game api"

    invoke-static {v0}, Lcom/umeng/commonsdk/statistics/common/MLog;->e(Ljava/lang/String;)V

    .line 87
    :cond_0
    :goto_0
    return-void

    .line 81
    :cond_1
    iget-object v0, p0, Lcom/umeng/analytics/game/b;->c:Lcom/umeng/analytics/game/a;

    iput-object p1, v0, Lcom/umeng/analytics/game/a;->b:Ljava/lang/String;

    .line 82
    iget-object v0, p0, Lcom/umeng/analytics/game/b;->A:Landroid/content/Context;

    invoke-static {v0}, Lcom/umeng/commonsdk/statistics/internal/PreferenceWrapper;->getDefault(Landroid/content/Context;)Landroid/content/SharedPreferences;

    move-result-object v0

    .line 83
    if-eqz v0, :cond_0

    .line 84
    invoke-interface {v0}, Landroid/content/SharedPreferences;->edit()Landroid/content/SharedPreferences$Editor;

    move-result-object v0

    const-string v1, "userlevel"

    invoke-interface {v0, v1, p1}, Landroid/content/SharedPreferences$Editor;->putString(Ljava/lang/String;Ljava/lang/String;)Landroid/content/SharedPreferences$Editor;

    move-result-object v0

    invoke-interface {v0}, Landroid/content/SharedPreferences$Editor;->commit()Z
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_0

    goto :goto_0

    .line 86
    :catch_0
    move-exception v0

    goto :goto_0
.end method

.method a(Ljava/lang/String;ID)V
    .locals 7

    .prologue
    .line 218
    iget-object v0, p0, Lcom/umeng/analytics/game/b;->A:Landroid/content/Context;

    if-nez v0, :cond_0

    .line 219
    const-string v0, "UMGameAgent.init(Context) should be called before any game api"

    invoke-static {v0}, Lcom/umeng/commonsdk/statistics/common/MLog;->e(Ljava/lang/String;)V

    .line 238
    :goto_0
    return-void

    .line 222
    :cond_0
    iget-object v0, p0, Lcom/umeng/analytics/game/b;->A:Landroid/content/Context;

    invoke-static {v0}, Lcom/umeng/analytics/AnalyticsConfig;->getVerticalType(Landroid/content/Context;)I

    move-result v0

    sget-object v1, Lcom/umeng/analytics/MobclickAgent$EScenarioType;->E_DUM_NORMAL:Lcom/umeng/analytics/MobclickAgent$EScenarioType;

    invoke-virtual {v1}, Lcom/umeng/analytics/MobclickAgent$EScenarioType;->toValue()I

    move-result v1

    if-eq v0, v1, :cond_1

    iget-object v0, p0, Lcom/umeng/analytics/game/b;->A:Landroid/content/Context;

    .line 223
    invoke-static {v0}, Lcom/umeng/analytics/AnalyticsConfig;->getVerticalType(Landroid/content/Context;)I

    move-result v0

    sget-object v1, Lcom/umeng/analytics/MobclickAgent$EScenarioType;->E_UM_NORMAL:Lcom/umeng/analytics/MobclickAgent$EScenarioType;

    invoke-virtual {v1}, Lcom/umeng/analytics/MobclickAgent$EScenarioType;->toValue()I

    move-result v1

    if-ne v0, v1, :cond_2

    .line 224
    :cond_1
    const-string v0, "UMGameAgent class is UMGameAgent API, can\'t be use in no-game scenario. "

    invoke-static {v0}, Lcom/umeng/commonsdk/statistics/common/MLog;->e(Ljava/lang/String;)V

    goto :goto_0

    .line 228
    :cond_2
    new-instance v0, Ljava/util/HashMap;

    invoke-direct {v0}, Ljava/util/HashMap;-><init>()V

    .line 230
    const-string v1, "item"

    invoke-virtual {v0, v1, p1}, Ljava/util/HashMap;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    .line 231
    const-string v1, "amount"

    invoke-static {p2}, Ljava/lang/Integer;->valueOf(I)Ljava/lang/Integer;

    move-result-object v2

    invoke-virtual {v0, v1, v2}, Ljava/util/HashMap;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    .line 232
    const-string v1, "coin"

    int-to-double v2, p2

    mul-double/2addr v2, p3

    const-wide/high16 v4, 0x4059000000000000L    # 100.0

    mul-double/2addr v2, v4

    double-to-long v2, v2

    invoke-static {v2, v3}, Ljava/lang/Long;->valueOf(J)Ljava/lang/Long;

    move-result-object v2

    invoke-virtual {v0, v1, v2}, Ljava/util/HashMap;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    .line 234
    iget-object v1, p0, Lcom/umeng/analytics/game/b;->c:Lcom/umeng/analytics/game/a;

    iget-object v1, v1, Lcom/umeng/analytics/game/a;->b:Ljava/lang/String;

    if-eqz v1, :cond_3

    const-string v1, "user_level"

    iget-object v2, p0, Lcom/umeng/analytics/game/b;->c:Lcom/umeng/analytics/game/a;

    iget-object v2, v2, Lcom/umeng/analytics/game/a;->b:Ljava/lang/String;

    invoke-virtual {v0, v1, v2}, Ljava/util/HashMap;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    .line 235
    :cond_3
    iget-object v1, p0, Lcom/umeng/analytics/game/b;->c:Lcom/umeng/analytics/game/a;

    iget-object v1, v1, Lcom/umeng/analytics/game/a;->a:Ljava/lang/String;

    if-eqz v1, :cond_4

    const-string v1, "level"

    iget-object v2, p0, Lcom/umeng/analytics/game/b;->c:Lcom/umeng/analytics/game/a;

    iget-object v2, v2, Lcom/umeng/analytics/game/a;->a:Ljava/lang/String;

    invoke-virtual {v0, v1, v2}, Ljava/util/HashMap;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    .line 237
    :cond_4
    iget-object v1, p0, Lcom/umeng/analytics/game/b;->b:Lcom/umeng/analytics/b;

    iget-object v2, p0, Lcom/umeng/analytics/game/b;->A:Landroid/content/Context;

    const-string v3, "buy"

    invoke-virtual {v1, v2, v3, v0}, Lcom/umeng/analytics/b;->a(Landroid/content/Context;Ljava/lang/String;Ljava/util/HashMap;)V

    goto :goto_0
.end method

.method a(Ljava/lang/String;IDI)V
    .locals 3

    .prologue
    .line 285
    iget-object v0, p0, Lcom/umeng/analytics/game/b;->A:Landroid/content/Context;

    invoke-static {v0}, Lcom/umeng/analytics/AnalyticsConfig;->getVerticalType(Landroid/content/Context;)I

    move-result v0

    sget-object v1, Lcom/umeng/analytics/MobclickAgent$EScenarioType;->E_DUM_NORMAL:Lcom/umeng/analytics/MobclickAgent$EScenarioType;

    invoke-virtual {v1}, Lcom/umeng/analytics/MobclickAgent$EScenarioType;->toValue()I

    move-result v1

    if-eq v0, v1, :cond_0

    iget-object v0, p0, Lcom/umeng/analytics/game/b;->A:Landroid/content/Context;

    .line 286
    invoke-static {v0}, Lcom/umeng/analytics/AnalyticsConfig;->getVerticalType(Landroid/content/Context;)I

    move-result v0

    sget-object v1, Lcom/umeng/analytics/MobclickAgent$EScenarioType;->E_UM_NORMAL:Lcom/umeng/analytics/MobclickAgent$EScenarioType;

    invoke-virtual {v1}, Lcom/umeng/analytics/MobclickAgent$EScenarioType;->toValue()I

    move-result v1

    if-ne v0, v1, :cond_1

    .line 287
    :cond_0
    const-string v0, "UMGameAgent class is UMGameAgent API, can\'t be use in no-game scenario. "

    invoke-static {v0}, Lcom/umeng/commonsdk/statistics/common/MLog;->e(Ljava/lang/String;)V

    .line 292
    :goto_0
    return-void

    .line 290
    :cond_1
    int-to-double v0, p2

    mul-double/2addr v0, p3

    invoke-virtual {p0, v0, v1, p5}, Lcom/umeng/analytics/game/b;->a(DI)V

    .line 291
    invoke-virtual {p0, p1, p2, p3, p4}, Lcom/umeng/analytics/game/b;->a(Ljava/lang/String;ID)V

    goto :goto_0
.end method

.method a(Z)V
    .locals 4

    .prologue
    .line 70
    const-string v0, "Trace sleep time : %b"

    const/4 v1, 0x1

    new-array v1, v1, [Ljava/lang/Object;

    const/4 v2, 0x0

    invoke-static {p1}, Ljava/lang/Boolean;->valueOf(Z)Ljava/lang/Boolean;

    move-result-object v3

    aput-object v3, v1, v2

    invoke-static {v0, v1}, Ljava/lang/String;->format(Ljava/lang/String;[Ljava/lang/Object;)Ljava/lang/String;

    move-result-object v0

    invoke-static {v0}, Lcom/umeng/commonsdk/statistics/common/MLog;->d(Ljava/lang/String;)V

    .line 72
    sput-boolean p1, Lcom/umeng/analytics/game/b;->a:Z

    .line 73
    return-void
.end method

.method public b()V
    .locals 2

    .prologue
    .line 314
    iget-object v0, p0, Lcom/umeng/analytics/game/b;->A:Landroid/content/Context;

    if-nez v0, :cond_1

    .line 315
    const-string v0, "UMGameAgent.init(Context) should be called before any game api"

    invoke-static {v0}, Lcom/umeng/commonsdk/statistics/common/MLog;->e(Ljava/lang/String;)V

    .line 327
    :cond_0
    :goto_0
    return-void

    .line 318
    :cond_1
    iget-object v0, p0, Lcom/umeng/analytics/game/b;->A:Landroid/content/Context;

    invoke-static {v0}, Lcom/umeng/analytics/AnalyticsConfig;->getVerticalType(Landroid/content/Context;)I

    move-result v0

    sget-object v1, Lcom/umeng/analytics/MobclickAgent$EScenarioType;->E_DUM_NORMAL:Lcom/umeng/analytics/MobclickAgent$EScenarioType;

    invoke-virtual {v1}, Lcom/umeng/analytics/MobclickAgent$EScenarioType;->toValue()I

    move-result v1

    if-eq v0, v1, :cond_2

    iget-object v0, p0, Lcom/umeng/analytics/game/b;->A:Landroid/content/Context;

    .line 319
    invoke-static {v0}, Lcom/umeng/analytics/AnalyticsConfig;->getVerticalType(Landroid/content/Context;)I

    move-result v0

    sget-object v1, Lcom/umeng/analytics/MobclickAgent$EScenarioType;->E_UM_NORMAL:Lcom/umeng/analytics/MobclickAgent$EScenarioType;

    invoke-virtual {v1}, Lcom/umeng/analytics/MobclickAgent$EScenarioType;->toValue()I

    move-result v1

    if-ne v0, v1, :cond_3

    .line 320
    :cond_2
    const-string v0, "UMGameAgent class is UMGameAgent API, can\'t be use in no-game scenario. "

    invoke-static {v0}, Lcom/umeng/commonsdk/statistics/common/MLog;->e(Ljava/lang/String;)V

    goto :goto_0

    .line 324
    :cond_3
    sget-boolean v0, Lcom/umeng/analytics/game/b;->a:Z

    if-eqz v0, :cond_0

    .line 325
    iget-object v0, p0, Lcom/umeng/analytics/game/b;->c:Lcom/umeng/analytics/game/a;

    invoke-virtual {v0}, Lcom/umeng/analytics/game/a;->a()V

    goto :goto_0
.end method

.method b(Ljava/lang/String;)V
    .locals 4

    .prologue
    .line 95
    iget-object v0, p0, Lcom/umeng/analytics/game/b;->A:Landroid/content/Context;

    if-nez v0, :cond_0

    .line 96
    const-string v0, "UMGameAgent.init(Context) should be called before any game api"

    invoke-static {v0}, Lcom/umeng/commonsdk/statistics/common/MLog;->e(Ljava/lang/String;)V

    .line 117
    :goto_0
    return-void

    .line 99
    :cond_0
    iget-object v0, p0, Lcom/umeng/analytics/game/b;->A:Landroid/content/Context;

    invoke-static {v0}, Lcom/umeng/analytics/AnalyticsConfig;->getVerticalType(Landroid/content/Context;)I

    move-result v0

    sget-object v1, Lcom/umeng/analytics/MobclickAgent$EScenarioType;->E_DUM_NORMAL:Lcom/umeng/analytics/MobclickAgent$EScenarioType;

    invoke-virtual {v1}, Lcom/umeng/analytics/MobclickAgent$EScenarioType;->toValue()I

    move-result v1

    if-eq v0, v1, :cond_1

    iget-object v0, p0, Lcom/umeng/analytics/game/b;->A:Landroid/content/Context;

    .line 100
    invoke-static {v0}, Lcom/umeng/analytics/AnalyticsConfig;->getVerticalType(Landroid/content/Context;)I

    move-result v0

    sget-object v1, Lcom/umeng/analytics/MobclickAgent$EScenarioType;->E_UM_NORMAL:Lcom/umeng/analytics/MobclickAgent$EScenarioType;

    invoke-virtual {v1}, Lcom/umeng/analytics/MobclickAgent$EScenarioType;->toValue()I

    move-result v1

    if-ne v0, v1, :cond_2

    .line 101
    :cond_1
    const-string v0, "UMGameAgent class is UMGameAgent API, can\'t be use in no-game scenario. "

    invoke-static {v0}, Lcom/umeng/commonsdk/statistics/common/MLog;->e(Ljava/lang/String;)V

    goto :goto_0

    .line 104
    :cond_2
    iget-object v0, p0, Lcom/umeng/analytics/game/b;->c:Lcom/umeng/analytics/game/a;

    iput-object p1, v0, Lcom/umeng/analytics/game/a;->a:Ljava/lang/String;

    .line 106
    iget-object v0, p0, Lcom/umeng/analytics/game/b;->c:Lcom/umeng/analytics/game/a;

    invoke-virtual {v0, p1}, Lcom/umeng/analytics/game/a;->a(Ljava/lang/String;)Lcom/umeng/analytics/game/a$a;

    .line 108
    new-instance v0, Ljava/util/HashMap;

    invoke-direct {v0}, Ljava/util/HashMap;-><init>()V

    .line 110
    const-string v1, "level"

    invoke-virtual {v0, v1, p1}, Ljava/util/HashMap;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    .line 111
    const-string v1, "status"

    const/4 v2, 0x0

    invoke-static {v2}, Ljava/lang/Integer;->valueOf(I)Ljava/lang/Integer;

    move-result-object v2

    invoke-virtual {v0, v1, v2}, Ljava/util/HashMap;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    .line 113
    iget-object v1, p0, Lcom/umeng/analytics/game/b;->c:Lcom/umeng/analytics/game/a;

    iget-object v1, v1, Lcom/umeng/analytics/game/a;->b:Ljava/lang/String;

    if-eqz v1, :cond_3

    .line 114
    const-string v1, "user_level"

    iget-object v2, p0, Lcom/umeng/analytics/game/b;->c:Lcom/umeng/analytics/game/a;

    iget-object v2, v2, Lcom/umeng/analytics/game/a;->b:Ljava/lang/String;

    invoke-virtual {v0, v1, v2}, Ljava/util/HashMap;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    .line 116
    :cond_3
    iget-object v1, p0, Lcom/umeng/analytics/game/b;->b:Lcom/umeng/analytics/b;

    iget-object v2, p0, Lcom/umeng/analytics/game/b;->A:Landroid/content/Context;

    const-string v3, "level"

    invoke-virtual {v1, v2, v3, v0}, Lcom/umeng/analytics/b;->a(Landroid/content/Context;Ljava/lang/String;Ljava/util/HashMap;)V

    goto :goto_0
.end method

.method b(Ljava/lang/String;ID)V
    .locals 7

    .prologue
    .line 241
    iget-object v0, p0, Lcom/umeng/analytics/game/b;->A:Landroid/content/Context;

    if-nez v0, :cond_0

    .line 242
    const-string v0, "UMGameAgent.init(Context) should be called before any game api"

    invoke-static {v0}, Lcom/umeng/commonsdk/statistics/common/MLog;->e(Ljava/lang/String;)V

    .line 261
    :goto_0
    return-void

    .line 245
    :cond_0
    iget-object v0, p0, Lcom/umeng/analytics/game/b;->A:Landroid/content/Context;

    invoke-static {v0}, Lcom/umeng/analytics/AnalyticsConfig;->getVerticalType(Landroid/content/Context;)I

    move-result v0

    sget-object v1, Lcom/umeng/analytics/MobclickAgent$EScenarioType;->E_DUM_NORMAL:Lcom/umeng/analytics/MobclickAgent$EScenarioType;

    invoke-virtual {v1}, Lcom/umeng/analytics/MobclickAgent$EScenarioType;->toValue()I

    move-result v1

    if-eq v0, v1, :cond_1

    iget-object v0, p0, Lcom/umeng/analytics/game/b;->A:Landroid/content/Context;

    .line 246
    invoke-static {v0}, Lcom/umeng/analytics/AnalyticsConfig;->getVerticalType(Landroid/content/Context;)I

    move-result v0

    sget-object v1, Lcom/umeng/analytics/MobclickAgent$EScenarioType;->E_UM_NORMAL:Lcom/umeng/analytics/MobclickAgent$EScenarioType;

    invoke-virtual {v1}, Lcom/umeng/analytics/MobclickAgent$EScenarioType;->toValue()I

    move-result v1

    if-ne v0, v1, :cond_2

    .line 247
    :cond_1
    const-string v0, "UMGameAgent class is UMGameAgent API, can\'t be use in no-game scenario. "

    invoke-static {v0}, Lcom/umeng/commonsdk/statistics/common/MLog;->e(Ljava/lang/String;)V

    goto :goto_0

    .line 251
    :cond_2
    new-instance v0, Ljava/util/HashMap;

    invoke-direct {v0}, Ljava/util/HashMap;-><init>()V

    .line 253
    const-string v1, "item"

    invoke-virtual {v0, v1, p1}, Ljava/util/HashMap;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    .line 254
    const-string v1, "amount"

    invoke-static {p2}, Ljava/lang/Integer;->valueOf(I)Ljava/lang/Integer;

    move-result-object v2

    invoke-virtual {v0, v1, v2}, Ljava/util/HashMap;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    .line 255
    const-string v1, "coin"

    int-to-double v2, p2

    mul-double/2addr v2, p3

    const-wide/high16 v4, 0x4059000000000000L    # 100.0

    mul-double/2addr v2, v4

    double-to-long v2, v2

    invoke-static {v2, v3}, Ljava/lang/Long;->valueOf(J)Ljava/lang/Long;

    move-result-object v2

    invoke-virtual {v0, v1, v2}, Ljava/util/HashMap;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    .line 257
    iget-object v1, p0, Lcom/umeng/analytics/game/b;->c:Lcom/umeng/analytics/game/a;

    iget-object v1, v1, Lcom/umeng/analytics/game/a;->b:Ljava/lang/String;

    if-eqz v1, :cond_3

    const-string v1, "user_level"

    iget-object v2, p0, Lcom/umeng/analytics/game/b;->c:Lcom/umeng/analytics/game/a;

    iget-object v2, v2, Lcom/umeng/analytics/game/a;->b:Ljava/lang/String;

    invoke-virtual {v0, v1, v2}, Ljava/util/HashMap;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    .line 258
    :cond_3
    iget-object v1, p0, Lcom/umeng/analytics/game/b;->c:Lcom/umeng/analytics/game/a;

    iget-object v1, v1, Lcom/umeng/analytics/game/a;->a:Ljava/lang/String;

    if-eqz v1, :cond_4

    const-string v1, "level"

    iget-object v2, p0, Lcom/umeng/analytics/game/b;->c:Lcom/umeng/analytics/game/a;

    iget-object v2, v2, Lcom/umeng/analytics/game/a;->a:Ljava/lang/String;

    invoke-virtual {v0, v1, v2}, Ljava/util/HashMap;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    .line 260
    :cond_4
    iget-object v1, p0, Lcom/umeng/analytics/game/b;->b:Lcom/umeng/analytics/b;

    iget-object v2, p0, Lcom/umeng/analytics/game/b;->A:Landroid/content/Context;

    const-string v3, "use"

    invoke-virtual {v1, v2, v3, v0}, Lcom/umeng/analytics/b;->a(Landroid/content/Context;Ljava/lang/String;Ljava/util/HashMap;)V

    goto :goto_0
.end method

.method c(Ljava/lang/String;)V
    .locals 2

    .prologue
    .line 155
    iget-object v0, p0, Lcom/umeng/analytics/game/b;->A:Landroid/content/Context;

    if-nez v0, :cond_0

    .line 156
    const-string v0, "UMGameAgent.init(Context) should be called before any game api"

    invoke-static {v0}, Lcom/umeng/commonsdk/statistics/common/MLog;->e(Ljava/lang/String;)V

    .line 165
    :goto_0
    return-void

    .line 159
    :cond_0
    iget-object v0, p0, Lcom/umeng/analytics/game/b;->A:Landroid/content/Context;

    invoke-static {v0}, Lcom/umeng/analytics/AnalyticsConfig;->getVerticalType(Landroid/content/Context;)I

    move-result v0

    sget-object v1, Lcom/umeng/analytics/MobclickAgent$EScenarioType;->E_DUM_NORMAL:Lcom/umeng/analytics/MobclickAgent$EScenarioType;

    invoke-virtual {v1}, Lcom/umeng/analytics/MobclickAgent$EScenarioType;->toValue()I

    move-result v1

    if-eq v0, v1, :cond_1

    iget-object v0, p0, Lcom/umeng/analytics/game/b;->A:Landroid/content/Context;

    .line 160
    invoke-static {v0}, Lcom/umeng/analytics/AnalyticsConfig;->getVerticalType(Landroid/content/Context;)I

    move-result v0

    sget-object v1, Lcom/umeng/analytics/MobclickAgent$EScenarioType;->E_UM_NORMAL:Lcom/umeng/analytics/MobclickAgent$EScenarioType;

    invoke-virtual {v1}, Lcom/umeng/analytics/MobclickAgent$EScenarioType;->toValue()I

    move-result v1

    if-ne v0, v1, :cond_2

    .line 161
    :cond_1
    const-string v0, "UMGameAgent class is UMGameAgent API, can\'t be use in no-game scenario. "

    invoke-static {v0}, Lcom/umeng/commonsdk/statistics/common/MLog;->e(Ljava/lang/String;)V

    goto :goto_0

    .line 164
    :cond_2
    const/4 v0, 0x1

    invoke-direct {p0, p1, v0}, Lcom/umeng/analytics/game/b;->a(Ljava/lang/String;I)V

    goto :goto_0
.end method

.method d(Ljava/lang/String;)V
    .locals 2

    .prologue
    .line 173
    iget-object v0, p0, Lcom/umeng/analytics/game/b;->A:Landroid/content/Context;

    if-nez v0, :cond_0

    .line 174
    const-string v0, "UMGameAgent.init(Context) should be called before any game api"

    invoke-static {v0}, Lcom/umeng/commonsdk/statistics/common/MLog;->e(Ljava/lang/String;)V

    .line 183
    :goto_0
    return-void

    .line 177
    :cond_0
    iget-object v0, p0, Lcom/umeng/analytics/game/b;->A:Landroid/content/Context;

    invoke-static {v0}, Lcom/umeng/analytics/AnalyticsConfig;->getVerticalType(Landroid/content/Context;)I

    move-result v0

    sget-object v1, Lcom/umeng/analytics/MobclickAgent$EScenarioType;->E_DUM_NORMAL:Lcom/umeng/analytics/MobclickAgent$EScenarioType;

    invoke-virtual {v1}, Lcom/umeng/analytics/MobclickAgent$EScenarioType;->toValue()I

    move-result v1

    if-eq v0, v1, :cond_1

    iget-object v0, p0, Lcom/umeng/analytics/game/b;->A:Landroid/content/Context;

    .line 178
    invoke-static {v0}, Lcom/umeng/analytics/AnalyticsConfig;->getVerticalType(Landroid/content/Context;)I

    move-result v0

    sget-object v1, Lcom/umeng/analytics/MobclickAgent$EScenarioType;->E_UM_NORMAL:Lcom/umeng/analytics/MobclickAgent$EScenarioType;

    invoke-virtual {v1}, Lcom/umeng/analytics/MobclickAgent$EScenarioType;->toValue()I

    move-result v1

    if-ne v0, v1, :cond_2

    .line 179
    :cond_1
    const-string v0, "UMGameAgent class is UMGameAgent API, can\'t be use in no-game scenario. "

    invoke-static {v0}, Lcom/umeng/commonsdk/statistics/common/MLog;->e(Ljava/lang/String;)V

    goto :goto_0

    .line 182
    :cond_2
    const/4 v0, -0x1

    invoke-direct {p0, p1, v0}, Lcom/umeng/analytics/game/b;->a(Ljava/lang/String;I)V

    goto :goto_0
.end method
