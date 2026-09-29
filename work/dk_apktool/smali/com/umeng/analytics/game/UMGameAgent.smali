.class public Lcom/umeng/analytics/game/UMGameAgent;
.super Lcom/umeng/analytics/MobclickAgent;
.source "UMGameAgent.java"


# static fields
.field private static final a:Ljava/lang/String; = "Input string is null or empty"

.field private static final b:Ljava/lang/String; = "Input string must be less than 64 chars"

.field private static final c:Ljava/lang/String; = "Input value type is negative"

.field private static final d:Ljava/lang/String; = "The int value for \'Pay Channels\' ranges between 1 ~ 99 "

.field private static final e:Lcom/umeng/analytics/game/b;

.field private static f:Landroid/content/Context;


# direct methods
.method static constructor <clinit>()V
    .locals 1

    .prologue
    .line 14
    new-instance v0, Lcom/umeng/analytics/game/b;

    invoke-direct {v0}, Lcom/umeng/analytics/game/b;-><init>()V

    sput-object v0, Lcom/umeng/analytics/game/UMGameAgent;->e:Lcom/umeng/analytics/game/b;

    return-void
.end method

.method public constructor <init>()V
    .locals 0

    .prologue
    .line 8
    invoke-direct {p0}, Lcom/umeng/analytics/MobclickAgent;-><init>()V

    return-void
.end method

.method private static a(Ljava/lang/String;)Z
    .locals 2

    .prologue
    const/4 v0, 0x1

    .line 252
    if-nez p0, :cond_1

    .line 258
    :cond_0
    :goto_0
    return v0

    .line 256
    :cond_1
    invoke-virtual {p0}, Ljava/lang/String;->trim()Ljava/lang/String;

    move-result-object v1

    .line 258
    invoke-virtual {v1}, Ljava/lang/String;->length()I

    move-result v1

    if-lez v1, :cond_0

    const/4 v0, 0x0

    goto :goto_0
.end method

.method public static bonus(DI)V
    .locals 2

    .prologue
    .line 220
    const-wide/16 v0, 0x0

    cmpg-double v0, p0, v0

    if-gez v0, :cond_0

    .line 221
    const-string v0, "Input value type is negative"

    invoke-static {v0}, Lcom/umeng/commonsdk/statistics/common/MLog;->e(Ljava/lang/String;)V

    .line 230
    :goto_0
    return-void

    .line 225
    :cond_0
    if-lez p2, :cond_1

    const/16 v0, 0x64

    if-lt p2, v0, :cond_2

    .line 226
    :cond_1
    const-string v0, "The int value for \'Pay Channels\' ranges between 1 ~ 99 "

    invoke-static {v0}, Lcom/umeng/commonsdk/statistics/common/MLog;->e(Ljava/lang/String;)V

    goto :goto_0

    .line 229
    :cond_2
    sget-object v0, Lcom/umeng/analytics/game/UMGameAgent;->e:Lcom/umeng/analytics/game/b;

    invoke-virtual {v0, p0, p1, p2}, Lcom/umeng/analytics/game/b;->a(DI)V

    goto :goto_0
.end method

.method public static bonus(Ljava/lang/String;IDI)V
    .locals 8

    .prologue
    .line 233
    invoke-static {p0}, Lcom/umeng/analytics/game/UMGameAgent;->a(Ljava/lang/String;)Z

    move-result v0

    if-eqz v0, :cond_0

    .line 234
    const-string v0, "Input string is null or empty"

    invoke-static {v0}, Lcom/umeng/commonsdk/statistics/common/MLog;->e(Ljava/lang/String;)V

    .line 249
    :goto_0
    return-void

    .line 238
    :cond_0
    if-ltz p1, :cond_1

    const-wide/16 v0, 0x0

    cmpg-double v0, p2, v0

    if-gez v0, :cond_2

    .line 239
    :cond_1
    const-string v0, "Input value type is negative"

    invoke-static {v0}, Lcom/umeng/commonsdk/statistics/common/MLog;->e(Ljava/lang/String;)V

    goto :goto_0

    .line 243
    :cond_2
    if-lez p4, :cond_3

    const/16 v0, 0x64

    if-lt p4, v0, :cond_4

    .line 244
    :cond_3
    const-string v0, "The int value for \'Pay Channels\' ranges between 1 ~ 99 "

    invoke-static {v0}, Lcom/umeng/commonsdk/statistics/common/MLog;->e(Ljava/lang/String;)V

    goto :goto_0

    .line 248
    :cond_4
    sget-object v1, Lcom/umeng/analytics/game/UMGameAgent;->e:Lcom/umeng/analytics/game/b;

    move-object v2, p0

    move v3, p1

    move-wide v4, p2

    move v6, p4

    invoke-virtual/range {v1 .. v6}, Lcom/umeng/analytics/game/b;->a(Ljava/lang/String;IDI)V

    goto :goto_0
.end method

.method public static buy(Ljava/lang/String;ID)V
    .locals 2

    .prologue
    .line 179
    invoke-static {p0}, Lcom/umeng/analytics/game/UMGameAgent;->a(Ljava/lang/String;)Z

    move-result v0

    if-eqz v0, :cond_0

    .line 180
    const-string v0, "Input string is null or empty"

    invoke-static {v0}, Lcom/umeng/commonsdk/statistics/common/MLog;->e(Ljava/lang/String;)V

    .line 190
    :goto_0
    return-void

    .line 184
    :cond_0
    if-ltz p1, :cond_1

    const-wide/16 v0, 0x0

    cmpg-double v0, p2, v0

    if-gez v0, :cond_2

    .line 185
    :cond_1
    const-string v0, "Input value type is negative"

    invoke-static {v0}, Lcom/umeng/commonsdk/statistics/common/MLog;->e(Ljava/lang/String;)V

    goto :goto_0

    .line 189
    :cond_2
    sget-object v0, Lcom/umeng/analytics/game/UMGameAgent;->e:Lcom/umeng/analytics/game/b;

    invoke-virtual {v0, p0, p1, p2, p3}, Lcom/umeng/analytics/game/b;->a(Ljava/lang/String;ID)V

    goto :goto_0
.end method

.method public static exchange(DLjava/lang/String;DILjava/lang/String;)V
    .locals 8

    .prologue
    const-wide/16 v2, 0x0

    .line 160
    cmpg-double v0, p0, v2

    if-ltz v0, :cond_0

    cmpg-double v0, p3, v2

    if-gez v0, :cond_1

    .line 161
    :cond_0
    const-string v0, "Input value type is negative"

    invoke-static {v0}, Lcom/umeng/commonsdk/statistics/common/MLog;->e(Ljava/lang/String;)V

    .line 169
    :goto_0
    return-void

    .line 164
    :cond_1
    if-lez p5, :cond_2

    const/16 v0, 0x64

    if-lt p5, v0, :cond_3

    .line 165
    :cond_2
    const-string v0, "The int value for \'Pay Channels\' ranges between 1 ~ 99 "

    invoke-static {v0}, Lcom/umeng/commonsdk/statistics/common/MLog;->e(Ljava/lang/String;)V

    goto :goto_0

    .line 168
    :cond_3
    sget-object v0, Lcom/umeng/analytics/game/UMGameAgent;->e:Lcom/umeng/analytics/game/b;

    move-wide v1, p0

    move-object v3, p2

    move-wide v4, p3

    move v6, p5

    move-object v7, p6

    invoke-virtual/range {v0 .. v7}, Lcom/umeng/analytics/game/b;->a(DLjava/lang/String;DILjava/lang/String;)V

    goto :goto_0
.end method

.method public static failLevel(Ljava/lang/String;)V
    .locals 2

    .prologue
    .line 84
    invoke-static {p0}, Lcom/umeng/analytics/game/UMGameAgent;->a(Ljava/lang/String;)Z

    move-result v0

    if-eqz v0, :cond_0

    .line 85
    const-string v0, "Input string is null or empty"

    invoke-static {v0}, Lcom/umeng/commonsdk/statistics/common/MLog;->e(Ljava/lang/String;)V

    .line 93
    :goto_0
    return-void

    .line 88
    :cond_0
    invoke-virtual {p0}, Ljava/lang/String;->length()I

    move-result v0

    const/16 v1, 0x40

    if-le v0, v1, :cond_1

    .line 89
    const-string v0, "Input string must be less than 64 chars"

    invoke-static {v0}, Lcom/umeng/commonsdk/statistics/common/MLog;->e(Ljava/lang/String;)V

    goto :goto_0

    .line 92
    :cond_1
    sget-object v0, Lcom/umeng/analytics/game/UMGameAgent;->e:Lcom/umeng/analytics/game/b;

    invoke-virtual {v0, p0}, Lcom/umeng/analytics/game/b;->d(Ljava/lang/String;)V

    goto :goto_0
.end method

.method public static finishLevel(Ljava/lang/String;)V
    .locals 2

    .prologue
    .line 67
    invoke-static {p0}, Lcom/umeng/analytics/game/UMGameAgent;->a(Ljava/lang/String;)Z

    move-result v0

    if-eqz v0, :cond_0

    .line 68
    const-string v0, "Input string is null or empty"

    invoke-static {v0}, Lcom/umeng/commonsdk/statistics/common/MLog;->e(Ljava/lang/String;)V

    .line 76
    :goto_0
    return-void

    .line 71
    :cond_0
    invoke-virtual {p0}, Ljava/lang/String;->length()I

    move-result v0

    const/16 v1, 0x40

    if-le v0, v1, :cond_1

    .line 72
    const-string v0, "Input string must be less than 64 chars"

    invoke-static {v0}, Lcom/umeng/commonsdk/statistics/common/MLog;->e(Ljava/lang/String;)V

    goto :goto_0

    .line 75
    :cond_1
    sget-object v0, Lcom/umeng/analytics/game/UMGameAgent;->e:Lcom/umeng/analytics/game/b;

    invoke-virtual {v0, p0}, Lcom/umeng/analytics/game/b;->c(Ljava/lang/String;)V

    goto :goto_0
.end method

.method public static init(Landroid/content/Context;)V
    .locals 2

    .prologue
    .line 24
    :try_start_0
    sget-object v0, Lcom/umeng/analytics/game/UMGameAgent;->f:Landroid/content/Context;

    if-nez v0, :cond_0

    .line 25
    if-eqz p0, :cond_0

    .line 26
    invoke-virtual {p0}, Landroid/content/Context;->getApplicationContext()Landroid/content/Context;

    move-result-object v0

    sput-object v0, Lcom/umeng/analytics/game/UMGameAgent;->f:Landroid/content/Context;

    .line 29
    :cond_0
    sget-object v0, Lcom/umeng/analytics/game/UMGameAgent;->e:Lcom/umeng/analytics/game/b;

    sget-object v1, Lcom/umeng/analytics/game/UMGameAgent;->f:Landroid/content/Context;

    invoke-virtual {v0, v1}, Lcom/umeng/analytics/game/b;->a(Landroid/content/Context;)V
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_0

    .line 33
    :goto_0
    return-void

    .line 30
    :catch_0
    move-exception v0

    .line 31
    const-string v0, "please check Context!"

    invoke-static {v0}, Lcom/umeng/commonsdk/statistics/common/MLog;->e(Ljava/lang/String;)V

    goto :goto_0
.end method

.method public static pay(DDI)V
    .locals 8

    .prologue
    const-wide/16 v2, 0x0

    .line 103
    if-lez p4, :cond_0

    const/16 v0, 0x64

    if-lt p4, v0, :cond_1

    .line 104
    :cond_0
    const-string v0, "The int value for \'Pay Channels\' ranges between 1 ~ 99 "

    invoke-static {v0}, Lcom/umeng/commonsdk/statistics/common/MLog;->e(Ljava/lang/String;)V

    .line 114
    :goto_0
    return-void

    .line 108
    :cond_1
    cmpg-double v0, p0, v2

    if-ltz v0, :cond_2

    cmpg-double v0, p2, v2

    if-gez v0, :cond_3

    .line 109
    :cond_2
    const-string v0, "Input value type is negative"

    invoke-static {v0}, Lcom/umeng/commonsdk/statistics/common/MLog;->e(Ljava/lang/String;)V

    goto :goto_0

    .line 113
    :cond_3
    sget-object v1, Lcom/umeng/analytics/game/UMGameAgent;->e:Lcom/umeng/analytics/game/b;

    move-wide v2, p0

    move-wide v4, p2

    move v6, p4

    invoke-virtual/range {v1 .. v6}, Lcom/umeng/analytics/game/b;->a(DDI)V

    goto :goto_0
.end method

.method public static pay(DLjava/lang/String;IDI)V
    .locals 12

    .prologue
    const-wide/16 v4, 0x0

    .line 131
    if-lez p6, :cond_0

    const/16 v2, 0x64

    move/from16 v0, p6

    if-lt v0, v2, :cond_1

    .line 132
    :cond_0
    const-string v2, "The int value for \'Pay Channels\' ranges between 1 ~ 99 "

    invoke-static {v2}, Lcom/umeng/commonsdk/statistics/common/MLog;->e(Ljava/lang/String;)V

    .line 147
    :goto_0
    return-void

    .line 136
    :cond_1
    cmpg-double v2, p0, v4

    if-ltz v2, :cond_2

    if-ltz p3, :cond_2

    cmpg-double v2, p4, v4

    if-gez v2, :cond_3

    .line 137
    :cond_2
    const-string v2, "Input value type is negative"

    invoke-static {v2}, Lcom/umeng/commonsdk/statistics/common/MLog;->e(Ljava/lang/String;)V

    goto :goto_0

    .line 141
    :cond_3
    invoke-static {p2}, Lcom/umeng/analytics/game/UMGameAgent;->a(Ljava/lang/String;)Z

    move-result v2

    if-eqz v2, :cond_4

    .line 142
    const-string v2, "Input string is null or empty"

    invoke-static {v2}, Lcom/umeng/commonsdk/statistics/common/MLog;->e(Ljava/lang/String;)V

    goto :goto_0

    .line 146
    :cond_4
    sget-object v3, Lcom/umeng/analytics/game/UMGameAgent;->e:Lcom/umeng/analytics/game/b;

    move-wide v4, p0

    move-object v6, p2

    move v7, p3

    move-wide/from16 v8, p4

    move/from16 v10, p6

    invoke-virtual/range {v3 .. v10}, Lcom/umeng/analytics/game/b;->a(DLjava/lang/String;IDI)V

    goto :goto_0
.end method

.method public static setPlayerLevel(I)V
    .locals 2

    .prologue
    .line 40
    sget-object v0, Lcom/umeng/analytics/game/UMGameAgent;->e:Lcom/umeng/analytics/game/b;

    invoke-static {p0}, Ljava/lang/String;->valueOf(I)Ljava/lang/String;

    move-result-object v1

    invoke-virtual {v0, v1}, Lcom/umeng/analytics/game/b;->a(Ljava/lang/String;)V

    .line 41
    return-void
.end method

.method public static setTraceSleepTime(Z)V
    .locals 1

    .prologue
    .line 36
    sget-object v0, Lcom/umeng/analytics/game/UMGameAgent;->e:Lcom/umeng/analytics/game/b;

    invoke-virtual {v0, p0}, Lcom/umeng/analytics/game/b;->a(Z)V

    .line 37
    return-void
.end method

.method public static startLevel(Ljava/lang/String;)V
    .locals 2

    .prologue
    .line 49
    invoke-static {p0}, Lcom/umeng/analytics/game/UMGameAgent;->a(Ljava/lang/String;)Z

    move-result v0

    if-eqz v0, :cond_0

    .line 50
    const-string v0, "Input string is null or empty"

    invoke-static {v0}, Lcom/umeng/commonsdk/statistics/common/MLog;->e(Ljava/lang/String;)V

    .line 59
    :goto_0
    return-void

    .line 54
    :cond_0
    invoke-virtual {p0}, Ljava/lang/String;->length()I

    move-result v0

    const/16 v1, 0x40

    if-le v0, v1, :cond_1

    .line 55
    const-string v0, "Input string must be less than 64 chars"

    invoke-static {v0}, Lcom/umeng/commonsdk/statistics/common/MLog;->e(Ljava/lang/String;)V

    goto :goto_0

    .line 58
    :cond_1
    sget-object v0, Lcom/umeng/analytics/game/UMGameAgent;->e:Lcom/umeng/analytics/game/b;

    invoke-virtual {v0, p0}, Lcom/umeng/analytics/game/b;->b(Ljava/lang/String;)V

    goto :goto_0
.end method

.method public static use(Ljava/lang/String;ID)V
    .locals 2

    .prologue
    .line 200
    invoke-static {p0}, Lcom/umeng/analytics/game/UMGameAgent;->a(Ljava/lang/String;)Z

    move-result v0

    if-eqz v0, :cond_0

    .line 201
    const-string v0, "Input string is null or empty"

    invoke-static {v0}, Lcom/umeng/commonsdk/statistics/common/MLog;->e(Ljava/lang/String;)V

    .line 211
    :goto_0
    return-void

    .line 205
    :cond_0
    if-ltz p1, :cond_1

    const-wide/16 v0, 0x0

    cmpg-double v0, p2, v0

    if-gez v0, :cond_2

    .line 206
    :cond_1
    const-string v0, "Input value type is negative"

    invoke-static {v0}, Lcom/umeng/commonsdk/statistics/common/MLog;->e(Ljava/lang/String;)V

    goto :goto_0

    .line 210
    :cond_2
    sget-object v0, Lcom/umeng/analytics/game/UMGameAgent;->e:Lcom/umeng/analytics/game/b;

    invoke-virtual {v0, p0, p1, p2, p3}, Lcom/umeng/analytics/game/b;->b(Ljava/lang/String;ID)V

    goto :goto_0
.end method
