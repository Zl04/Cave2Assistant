.class public Lcom/umeng/analytics/dplus/UMADplus;
.super Ljava/lang/Object;
.source "UMADplus.java"


# direct methods
.method public constructor <init>()V
    .locals 0

    .prologue
    .line 18
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method

.method public static clearSuperProperties(Landroid/content/Context;)V
    .locals 1

    .prologue
    .line 116
    sget-boolean v0, Lcom/umeng/analytics/AnalyticsConfig;->FLAG_DPLUS:Z

    if-nez v0, :cond_0

    .line 117
    const-string v0, "UMADplus class is Dplus API, can\'t be use in no-Dplus scenario."

    invoke-static {v0}, Lcom/umeng/commonsdk/statistics/common/MLog;->e(Ljava/lang/String;)V

    .line 121
    :goto_0
    return-void

    .line 120
    :cond_0
    invoke-static {}, Lcom/umeng/analytics/MobclickAgent;->getAgent()Lcom/umeng/analytics/b;

    move-result-object v0

    invoke-virtual {v0, p0}, Lcom/umeng/analytics/b;->e(Landroid/content/Context;)V

    goto :goto_0
.end method

.method public static getSuperProperties(Landroid/content/Context;)Ljava/lang/String;
    .locals 1

    .prologue
    .line 103
    sget-boolean v0, Lcom/umeng/analytics/AnalyticsConfig;->FLAG_DPLUS:Z

    if-nez v0, :cond_0

    .line 104
    const-string v0, "UMADplus class is Dplus API, can\'t be use in no-Dplus scenario."

    invoke-static {v0}, Lcom/umeng/commonsdk/statistics/common/MLog;->e(Ljava/lang/String;)V

    .line 105
    const/4 v0, 0x0

    .line 107
    :goto_0
    return-object v0

    :cond_0
    invoke-static {}, Lcom/umeng/analytics/MobclickAgent;->getAgent()Lcom/umeng/analytics/b;

    move-result-object v0

    invoke-virtual {v0, p0}, Lcom/umeng/analytics/b;->d(Landroid/content/Context;)Ljava/lang/String;

    move-result-object v0

    goto :goto_0
.end method

.method public static getSuperProperty(Landroid/content/Context;Ljava/lang/String;)Ljava/lang/Object;
    .locals 1

    .prologue
    .line 89
    sget-boolean v0, Lcom/umeng/analytics/AnalyticsConfig;->FLAG_DPLUS:Z

    if-nez v0, :cond_0

    .line 90
    const-string v0, "UMADplus class is Dplus API, can\'t be use in no-Dplus scenario."

    invoke-static {v0}, Lcom/umeng/commonsdk/statistics/common/MLog;->e(Ljava/lang/String;)V

    .line 91
    const/4 v0, 0x0

    .line 93
    :goto_0
    return-object v0

    :cond_0
    invoke-static {}, Lcom/umeng/analytics/MobclickAgent;->getAgent()Lcom/umeng/analytics/b;

    move-result-object v0

    invoke-virtual {v0, p0, p1}, Lcom/umeng/analytics/b;->d(Landroid/content/Context;Ljava/lang/String;)Ljava/lang/Object;

    move-result-object v0

    goto :goto_0
.end method

.method public static registerSuperProperty(Landroid/content/Context;Ljava/lang/String;Ljava/lang/Object;)V
    .locals 1

    .prologue
    .line 60
    sget-boolean v0, Lcom/umeng/analytics/AnalyticsConfig;->FLAG_DPLUS:Z

    if-nez v0, :cond_0

    .line 61
    const-string v0, "UMADplus class is Dplus API, can\'t be use in no-Dplus scenario."

    invoke-static {v0}, Lcom/umeng/commonsdk/statistics/common/MLog;->e(Ljava/lang/String;)V

    .line 65
    :goto_0
    return-void

    .line 64
    :cond_0
    invoke-static {}, Lcom/umeng/analytics/MobclickAgent;->getAgent()Lcom/umeng/analytics/b;

    move-result-object v0

    invoke-virtual {v0, p0, p1, p2}, Lcom/umeng/analytics/b;->a(Landroid/content/Context;Ljava/lang/String;Ljava/lang/Object;)V

    goto :goto_0
.end method

.method public static setFirstLaunchEvent(Landroid/content/Context;Ljava/util/List;)V
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
    .line 129
    sget-boolean v0, Lcom/umeng/analytics/AnalyticsConfig;->FLAG_DPLUS:Z

    if-nez v0, :cond_0

    .line 130
    const-string v0, "UMADplus class is Dplus API, can\'t be use in no-Dplus scenario."

    invoke-static {v0}, Lcom/umeng/commonsdk/statistics/common/MLog;->e(Ljava/lang/String;)V

    .line 134
    :goto_0
    return-void

    .line 133
    :cond_0
    invoke-static {}, Lcom/umeng/analytics/MobclickAgent;->getAgent()Lcom/umeng/analytics/b;

    move-result-object v0

    invoke-virtual {v0, p0, p1}, Lcom/umeng/analytics/b;->a(Landroid/content/Context;Ljava/util/List;)V

    goto :goto_0
.end method

.method public static track(Landroid/content/Context;Ljava/lang/String;)V
    .locals 2

    .prologue
    .line 27
    sget-boolean v0, Lcom/umeng/analytics/AnalyticsConfig;->FLAG_DPLUS:Z

    if-nez v0, :cond_0

    .line 28
    const-string v0, "UMADplus class is Dplus API, can\'t be use in no-Dplus scenario."

    invoke-static {v0}, Lcom/umeng/commonsdk/statistics/common/MLog;->e(Ljava/lang/String;)V

    .line 32
    :goto_0
    return-void

    .line 31
    :cond_0
    invoke-static {}, Lcom/umeng/analytics/MobclickAgent;->getAgent()Lcom/umeng/analytics/b;

    move-result-object v0

    const/4 v1, 0x0

    invoke-virtual {v0, p0, p1, v1}, Lcom/umeng/analytics/b;->a(Landroid/content/Context;Ljava/lang/String;Ljava/util/Map;)V

    goto :goto_0
.end method

.method public static track(Landroid/content/Context;Ljava/lang/String;Ljava/util/Map;)V
    .locals 1
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
    .line 42
    sget-boolean v0, Lcom/umeng/analytics/AnalyticsConfig;->FLAG_DPLUS:Z

    if-nez v0, :cond_0

    .line 43
    const-string v0, "UMADplus class is Dplus API, can\'t be use in no-Dplus scenario."

    invoke-static {v0}, Lcom/umeng/commonsdk/statistics/common/MLog;->e(Ljava/lang/String;)V

    .line 50
    :goto_0
    return-void

    .line 46
    :cond_0
    if-eqz p2, :cond_1

    invoke-interface {p2}, Ljava/util/Map;->size()I

    move-result v0

    if-gtz v0, :cond_2

    .line 47
    :cond_1
    const-string v0, "the map is null!"

    invoke-static {v0}, Lcom/umeng/commonsdk/statistics/common/MLog;->e(Ljava/lang/String;)V

    .line 49
    :cond_2
    invoke-static {}, Lcom/umeng/analytics/MobclickAgent;->getAgent()Lcom/umeng/analytics/b;

    move-result-object v0

    invoke-virtual {v0, p0, p1, p2}, Lcom/umeng/analytics/b;->a(Landroid/content/Context;Ljava/lang/String;Ljava/util/Map;)V

    goto :goto_0
.end method

.method public static unregisterSuperProperty(Landroid/content/Context;Ljava/lang/String;)V
    .locals 1

    .prologue
    .line 74
    sget-boolean v0, Lcom/umeng/analytics/AnalyticsConfig;->FLAG_DPLUS:Z

    if-nez v0, :cond_0

    .line 75
    const-string v0, "UMADplus class is Dplus API, can\'t be use in no-Dplus scenario."

    invoke-static {v0}, Lcom/umeng/commonsdk/statistics/common/MLog;->e(Ljava/lang/String;)V

    .line 79
    :goto_0
    return-void

    .line 78
    :cond_0
    invoke-static {}, Lcom/umeng/analytics/MobclickAgent;->getAgent()Lcom/umeng/analytics/b;

    move-result-object v0

    invoke-virtual {v0, p0, p1}, Lcom/umeng/analytics/b;->c(Landroid/content/Context;Ljava/lang/String;)V

    goto :goto_0
.end method
