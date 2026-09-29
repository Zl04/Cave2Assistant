.class Lcom/umeng/commonsdk/proguard/h$1$1;
.super Lcom/umeng/commonsdk/proguard/i;
.source "UMSysLocationCache.java"


# annotations
.annotation system Ldalvik/annotation/EnclosingMethod;
    value = Lcom/umeng/commonsdk/proguard/h$1;->run()V
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x0
    name = null
.end annotation


# instance fields
.field final synthetic a:Lcom/umeng/commonsdk/proguard/g;

.field final synthetic b:Lcom/umeng/commonsdk/proguard/h$1;


# direct methods
.method constructor <init>(Lcom/umeng/commonsdk/proguard/h$1;Lcom/umeng/commonsdk/proguard/g;)V
    .locals 0

    .prologue
    .line 64
    iput-object p1, p0, Lcom/umeng/commonsdk/proguard/h$1$1;->b:Lcom/umeng/commonsdk/proguard/h$1;

    iput-object p2, p0, Lcom/umeng/commonsdk/proguard/h$1$1;->a:Lcom/umeng/commonsdk/proguard/g;

    invoke-direct {p0}, Lcom/umeng/commonsdk/proguard/i;-><init>()V

    return-void
.end method


# virtual methods
.method public a(Landroid/location/Location;)V
    .locals 12

    .prologue
    const-wide/16 v10, 0x0

    const/4 v9, 0x1

    const/4 v8, 0x0

    .line 69
    if-eqz p1, :cond_0

    .line 70
    invoke-virtual {p1}, Landroid/location/Location;->getLongitude()D

    move-result-wide v0

    .line 71
    invoke-virtual {p1}, Landroid/location/Location;->getLatitude()D

    move-result-wide v2

    .line 72
    const-string v4, "UMSysLocationCache"

    new-array v5, v9, [Ljava/lang/Object;

    new-instance v6, Ljava/lang/StringBuilder;

    invoke-direct {v6}, Ljava/lang/StringBuilder;-><init>()V

    const-string v7, "lon is "

    invoke-virtual {v6, v7}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v6

    invoke-virtual {v6, v0, v1}, Ljava/lang/StringBuilder;->append(D)Ljava/lang/StringBuilder;

    move-result-object v6

    const-string v7, ", lat is "

    invoke-virtual {v6, v7}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v6

    invoke-virtual {v6, v2, v3}, Ljava/lang/StringBuilder;->append(D)Ljava/lang/StringBuilder;

    move-result-object v6

    invoke-virtual {v6}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v6

    aput-object v6, v5, v8

    invoke-static {v4, v5}, Lcom/umeng/commonsdk/statistics/common/e;->a(Ljava/lang/String;[Ljava/lang/Object;)V

    .line 74
    cmpl-double v4, v0, v10

    if-eqz v4, :cond_0

    cmpl-double v4, v2, v10

    if-eqz v4, :cond_0

    .line 75
    invoke-static {}, Ljava/lang/System;->currentTimeMillis()J

    move-result-wide v4

    .line 77
    new-instance v6, Lorg/json/JSONObject;

    invoke-direct {v6}, Lorg/json/JSONObject;-><init>()V

    .line 79
    :try_start_0
    const-string v7, "lng"

    invoke-virtual {v6, v7, v0, v1}, Lorg/json/JSONObject;->put(Ljava/lang/String;D)Lorg/json/JSONObject;

    .line 80
    const-string v0, "lat"

    invoke-virtual {v6, v0, v2, v3}, Lorg/json/JSONObject;->put(Ljava/lang/String;D)Lorg/json/JSONObject;

    .line 81
    const-string v0, "ts"

    invoke-virtual {v6, v0, v4, v5}, Lorg/json/JSONObject;->put(Ljava/lang/String;J)Lorg/json/JSONObject;
    :try_end_0
    .catch Lorg/json/JSONException; {:try_start_0 .. :try_end_0} :catch_0

    .line 86
    :goto_0
    const-string v0, "UMSysLocationCache"

    new-array v1, v9, [Ljava/lang/Object;

    new-instance v2, Ljava/lang/StringBuilder;

    invoke-direct {v2}, Ljava/lang/StringBuilder;-><init>()V

    const-string v3, "locationJSONObject is "

    invoke-virtual {v2, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    invoke-virtual {v6}, Lorg/json/JSONObject;->toString()Ljava/lang/String;

    move-result-object v3

    invoke-virtual {v2, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    invoke-virtual {v2}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v2

    aput-object v2, v1, v8

    invoke-static {v0, v1}, Lcom/umeng/commonsdk/statistics/common/e;->a(Ljava/lang/String;[Ljava/lang/Object;)V

    .line 88
    iget-object v0, p0, Lcom/umeng/commonsdk/proguard/h$1$1;->b:Lcom/umeng/commonsdk/proguard/h$1;

    iget-object v0, v0, Lcom/umeng/commonsdk/proguard/h$1;->a:Landroid/content/Context;

    const v1, 0x8002

    iget-object v2, p0, Lcom/umeng/commonsdk/proguard/h$1$1;->b:Lcom/umeng/commonsdk/proguard/h$1;

    iget-object v2, v2, Lcom/umeng/commonsdk/proguard/h$1;->a:Landroid/content/Context;

    .line 89
    invoke-static {v2}, Lcom/umeng/commonsdk/proguard/b;->a(Landroid/content/Context;)Lcom/umeng/commonsdk/proguard/b;

    move-result-object v2

    invoke-virtual {v2}, Lcom/umeng/commonsdk/proguard/b;->a()Lcom/umeng/commonsdk/proguard/c;

    move-result-object v2

    invoke-virtual {v6}, Lorg/json/JSONObject;->toString()Ljava/lang/String;

    move-result-object v3

    .line 88
    invoke-static {v0, v1, v2, v3}, Lcom/umeng/commonsdk/framework/UMWorkDispatch;->sendEvent(Landroid/content/Context;ILcom/umeng/commonsdk/framework/UMLogDataProtocol;Ljava/lang/Object;)V

    .line 101
    :cond_0
    iget-object v0, p0, Lcom/umeng/commonsdk/proguard/h$1$1;->a:Lcom/umeng/commonsdk/proguard/g;

    invoke-virtual {v0}, Lcom/umeng/commonsdk/proguard/g;->a()V

    .line 102
    return-void

    .line 82
    :catch_0
    move-exception v0

    .line 83
    const-string v1, "UMSysLocationCache"

    new-array v2, v9, [Ljava/lang/Object;

    new-instance v3, Ljava/lang/StringBuilder;

    invoke-direct {v3}, Ljava/lang/StringBuilder;-><init>()V

    const-string v4, "e is "

    invoke-virtual {v3, v4}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v3

    invoke-virtual {v3, v0}, Ljava/lang/StringBuilder;->append(Ljava/lang/Object;)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-virtual {v0}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v0

    aput-object v0, v2, v8

    invoke-static {v1, v2}, Lcom/umeng/commonsdk/statistics/common/e;->a(Ljava/lang/String;[Ljava/lang/Object;)V

    goto :goto_0
.end method
