.class public Lcom/umeng/commonsdk/proguard/c;
.super Ljava/lang/Object;
.source "UMInternalDataProtocol.java"

# interfaces
.implements Lcom/umeng/commonsdk/framework/UMLogDataProtocol;


# static fields
.field private static final b:Ljava/lang/String; = "info"

.field private static final c:Ljava/lang/String; = "stat"


# instance fields
.field private a:Landroid/content/Context;


# direct methods
.method public constructor <init>(Landroid/content/Context;)V
    .locals 1

    .prologue
    .line 34
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    .line 35
    if-eqz p1, :cond_0

    .line 36
    invoke-virtual {p1}, Landroid/content/Context;->getApplicationContext()Landroid/content/Context;

    move-result-object v0

    iput-object v0, p0, Lcom/umeng/commonsdk/proguard/c;->a:Landroid/content/Context;

    .line 38
    :cond_0
    return-void
.end method

.method private static a(Landroid/content/Context;)V
    .locals 8

    .prologue
    const/4 v0, 0x1

    const/4 v1, 0x0

    .line 146
    if-nez p0, :cond_1

    .line 205
    :cond_0
    :goto_0
    return-void

    .line 149
    :cond_1
    invoke-static {p0}, Lcom/umeng/commonsdk/proguard/j;->c(Landroid/content/Context;)Landroid/net/wifi/WifiInfo;

    move-result-object v2

    .line 150
    if-eqz v2, :cond_0

    .line 153
    new-instance v3, Lcom/umeng/commonsdk/proguard/j$c;

    invoke-direct {v3}, Lcom/umeng/commonsdk/proguard/j$c;-><init>()V

    .line 154
    invoke-virtual {v2}, Landroid/net/wifi/WifiInfo;->describeContents()I

    move-result v4

    iput v4, v3, Lcom/umeng/commonsdk/proguard/j$c;->a:I

    .line 155
    invoke-virtual {v2}, Landroid/net/wifi/WifiInfo;->getBSSID()Ljava/lang/String;

    move-result-object v4

    iput-object v4, v3, Lcom/umeng/commonsdk/proguard/j$c;->b:Ljava/lang/String;

    .line 156
    invoke-virtual {v2}, Landroid/net/wifi/WifiInfo;->getSSID()Ljava/lang/String;

    move-result-object v4

    iput-object v4, v3, Lcom/umeng/commonsdk/proguard/j$c;->c:Ljava/lang/String;

    .line 157
    sget v4, Landroid/os/Build$VERSION;->SDK_INT:I

    const/16 v5, 0x15

    if-lt v4, v5, :cond_2

    .line 158
    invoke-virtual {v2}, Landroid/net/wifi/WifiInfo;->getFrequency()I

    move-result v4

    iput v4, v3, Lcom/umeng/commonsdk/proguard/j$c;->d:I

    .line 163
    :goto_1
    invoke-virtual {v2}, Landroid/net/wifi/WifiInfo;->getHiddenSSID()Z

    move-result v4

    if-eqz v4, :cond_3

    .line 164
    iput v0, v3, Lcom/umeng/commonsdk/proguard/j$c;->e:I

    .line 169
    :goto_2
    invoke-virtual {v2}, Landroid/net/wifi/WifiInfo;->getIpAddress()I

    move-result v4

    iput v4, v3, Lcom/umeng/commonsdk/proguard/j$c;->f:I

    .line 170
    invoke-virtual {v2}, Landroid/net/wifi/WifiInfo;->getLinkSpeed()I

    move-result v4

    iput v4, v3, Lcom/umeng/commonsdk/proguard/j$c;->g:I

    .line 171
    invoke-static {p0}, Lcom/umeng/commonsdk/statistics/common/DeviceConfig;->getMac(Landroid/content/Context;)Ljava/lang/String;

    move-result-object v4

    iput-object v4, v3, Lcom/umeng/commonsdk/proguard/j$c;->h:Ljava/lang/String;

    .line 172
    invoke-virtual {v2}, Landroid/net/wifi/WifiInfo;->getNetworkId()I

    move-result v4

    iput v4, v3, Lcom/umeng/commonsdk/proguard/j$c;->i:I

    .line 173
    invoke-virtual {v2}, Landroid/net/wifi/WifiInfo;->getRssi()I

    move-result v4

    iput v4, v3, Lcom/umeng/commonsdk/proguard/j$c;->j:I

    .line 174
    invoke-static {p0}, Lcom/umeng/commonsdk/proguard/j;->g(Landroid/content/Context;)I

    move-result v4

    iput v4, v3, Lcom/umeng/commonsdk/proguard/j$c;->k:I

    .line 175
    invoke-static {}, Ljava/lang/System;->currentTimeMillis()J

    move-result-wide v4

    iput-wide v4, v3, Lcom/umeng/commonsdk/proguard/j$c;->l:J

    .line 177
    if-eqz v2, :cond_0

    .line 182
    :try_start_0
    invoke-static {p0}, Lcom/umeng/commonsdk/proguard/n;->b(Landroid/content/Context;)Lorg/json/JSONArray;

    move-result-object v4

    .line 183
    if-eqz v4, :cond_5

    invoke-virtual {v4}, Lorg/json/JSONArray;->length()I

    move-result v2

    if-lez v2, :cond_5

    move v2, v1

    .line 184
    :goto_3
    invoke-virtual {v4}, Lorg/json/JSONArray;->length()I

    move-result v5

    if-ge v2, v5, :cond_5

    .line 185
    invoke-virtual {v4, v2}, Lorg/json/JSONArray;->optJSONObject(I)Lorg/json/JSONObject;

    move-result-object v5

    .line 186
    const-string v6, "ssid"

    const/4 v7, 0x0

    invoke-virtual {v5, v6, v7}, Lorg/json/JSONObject;->optString(Ljava/lang/String;Ljava/lang/String;)Ljava/lang/String;

    move-result-object v5

    .line 187
    if-eqz v5, :cond_4

    .line 188
    iget-object v6, v3, Lcom/umeng/commonsdk/proguard/j$c;->c:Ljava/lang/String;

    invoke-virtual {v5, v6}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v5

    if-eqz v5, :cond_4

    .line 195
    :goto_4
    if-nez v0, :cond_0

    .line 196
    invoke-static {p0, v3}, Lcom/umeng/commonsdk/proguard/n;->a(Landroid/content/Context;Lcom/umeng/commonsdk/proguard/j$c;)V
    :try_end_0
    .catch Ljava/lang/Exception; {:try_start_0 .. :try_end_0} :catch_0

    goto/16 :goto_0

    .line 198
    :catch_0
    move-exception v0

    .line 199
    if-eqz v0, :cond_0

    .line 200
    new-instance v1, Ljava/lang/StringBuilder;

    invoke-direct {v1}, Ljava/lang/StringBuilder;-><init>()V

    const-string v2, "wifiChange:"

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v0}, Ljava/lang/Exception;->getMessage()Ljava/lang/String;

    move-result-object v0

    invoke-virtual {v1, v0}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-virtual {v0}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v0

    invoke-static {v0}, Lcom/umeng/commonsdk/statistics/common/e;->e(Ljava/lang/String;)V

    goto/16 :goto_0

    .line 160
    :cond_2
    const/4 v4, -0x1

    iput v4, v3, Lcom/umeng/commonsdk/proguard/j$c;->d:I

    goto/16 :goto_1

    .line 166
    :cond_3
    iput v1, v3, Lcom/umeng/commonsdk/proguard/j$c;->e:I

    goto/16 :goto_2

    .line 184
    :cond_4
    add-int/lit8 v2, v2, 0x1

    goto :goto_3

    :cond_5
    move v0, v1

    goto :goto_4
.end method


# virtual methods
.method public removeCacheData(Ljava/lang/Object;)V
    .locals 0

    .prologue
    .line 211
    return-void
.end method

.method public setupReportData(J)Lorg/json/JSONObject;
    .locals 1

    .prologue
    .line 215
    const/4 v0, 0x0

    return-object v0
.end method

.method public workEvent(Ljava/lang/Object;I)V
    .locals 5

    .prologue
    const/4 v1, 0x1

    const/4 v3, 0x0

    .line 43
    const-string v0, "walle"

    new-array v1, v1, [Ljava/lang/Object;

    const-string v2, "[internal] workEvent"

    aput-object v2, v1, v3

    invoke-static {v0, v1}, Lcom/umeng/commonsdk/statistics/common/e;->a(Ljava/lang/String;[Ljava/lang/Object;)V

    .line 46
    packed-switch p2, :pswitch_data_0

    .line 136
    :cond_0
    :goto_0
    return-void

    .line 49
    :pswitch_0
    :try_start_0
    const-string v0, "walle"

    const/4 v1, 0x1

    new-array v1, v1, [Ljava/lang/Object;

    const/4 v2, 0x0

    const-string v3, "[internal] workEvent send envelope"

    aput-object v3, v1, v2

    invoke-static {v0, v1}, Lcom/umeng/commonsdk/statistics/common/e;->a(Ljava/lang/String;[Ljava/lang/Object;)V

    .line 50
    new-instance v0, Lorg/json/JSONObject;

    invoke-direct {v0}, Lorg/json/JSONObject;-><init>()V

    .line 51
    const-string v1, "i_sdk_v"

    const-string v2, "1.2.0"

    invoke-virtual {v0, v1, v2}, Lorg/json/JSONObject;->put(Ljava/lang/String;Ljava/lang/Object;)Lorg/json/JSONObject;

    .line 52
    iget-object v1, p0, Lcom/umeng/commonsdk/proguard/c;->a:Landroid/content/Context;

    invoke-static {v1}, Lcom/umeng/commonsdk/proguard/d;->d(Landroid/content/Context;)Lorg/json/JSONObject;

    move-result-object v1

    .line 53
    iget-object v2, p0, Lcom/umeng/commonsdk/proguard/c;->a:Landroid/content/Context;

    invoke-static {v2, v0, v1}, Lcom/umeng/commonsdk/framework/UMEnvelopeBuild;->buildEnvelopeWithExtHeader(Landroid/content/Context;Lorg/json/JSONObject;Lorg/json/JSONObject;)Lorg/json/JSONObject;

    move-result-object v0

    .line 54
    if-eqz v0, :cond_0

    const-string v1, "exception"

    invoke-virtual {v0, v1}, Lorg/json/JSONObject;->has(Ljava/lang/String;)Z

    move-result v0

    if-nez v0, :cond_0

    .line 56
    const-string v0, "walle"

    const/4 v1, 0x1

    new-array v1, v1, [Ljava/lang/Object;

    const/4 v2, 0x0

    const-string v3, "[internal] workEvent send envelope back, result is ok"

    aput-object v3, v1, v2

    invoke-static {v0, v1}, Lcom/umeng/commonsdk/statistics/common/e;->a(Ljava/lang/String;[Ljava/lang/Object;)V

    .line 57
    iget-object v0, p0, Lcom/umeng/commonsdk/proguard/c;->a:Landroid/content/Context;

    invoke-static {v0}, Lcom/umeng/commonsdk/proguard/j;->f(Landroid/content/Context;)V

    .line 58
    iget-object v0, p0, Lcom/umeng/commonsdk/proguard/c;->a:Landroid/content/Context;

    invoke-static {v0}, Lcom/umeng/commonsdk/proguard/r;->d(Landroid/content/Context;)V
    :try_end_0
    .catch Ljava/lang/Exception; {:try_start_0 .. :try_end_0} :catch_0

    goto :goto_0

    .line 60
    :catch_0
    move-exception v0

    .line 62
    iget-object v1, p0, Lcom/umeng/commonsdk/proguard/c;->a:Landroid/content/Context;

    invoke-static {v1, v0}, Lcom/umeng/commonsdk/proguard/e;->a(Landroid/content/Context;Ljava/lang/Throwable;)V

    goto :goto_0

    .line 69
    :pswitch_1
    :try_start_1
    const-string v0, "walle"

    const/4 v1, 0x1

    new-array v1, v1, [Ljava/lang/Object;

    const/4 v2, 0x0

    new-instance v3, Ljava/lang/StringBuilder;

    invoke-direct {v3}, Ljava/lang/StringBuilder;-><init>()V

    const-string v4, "[internal] workEvent cache location, event is "

    invoke-virtual {v3, v4}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v3

    invoke-virtual {p1}, Ljava/lang/Object;->toString()Ljava/lang/String;

    move-result-object v4

    invoke-virtual {v3, v4}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v3

    invoke-virtual {v3}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v3

    aput-object v3, v1, v2

    invoke-static {v0, v1}, Lcom/umeng/commonsdk/statistics/common/e;->a(Ljava/lang/String;[Ljava/lang/Object;)V

    .line 70
    iget-object v0, p0, Lcom/umeng/commonsdk/proguard/c;->a:Landroid/content/Context;

    const-string v1, "umeng_common_config"

    const/4 v2, 0x0

    invoke-virtual {v0, v1, v2}, Landroid/content/Context;->getSharedPreferences(Ljava/lang/String;I)Landroid/content/SharedPreferences;

    move-result-object v0

    .line 72
    if-eqz v0, :cond_0

    .line 75
    invoke-interface {v0}, Landroid/content/SharedPreferences;->edit()Landroid/content/SharedPreferences$Editor;

    move-result-object v0

    .line 76
    const-string v1, "location_json"

    invoke-virtual {p1}, Ljava/lang/Object;->toString()Ljava/lang/String;

    move-result-object v2

    invoke-interface {v0, v1, v2}, Landroid/content/SharedPreferences$Editor;->putString(Ljava/lang/String;Ljava/lang/String;)Landroid/content/SharedPreferences$Editor;

    .line 77
    invoke-interface {v0}, Landroid/content/SharedPreferences$Editor;->commit()Z
    :try_end_1
    .catch Ljava/lang/Exception; {:try_start_1 .. :try_end_1} :catch_1

    goto/16 :goto_0

    .line 78
    :catch_1
    move-exception v0

    .line 79
    iget-object v1, p0, Lcom/umeng/commonsdk/proguard/c;->a:Landroid/content/Context;

    invoke-static {v1, v0}, Lcom/umeng/commonsdk/proguard/e;->a(Landroid/content/Context;Ljava/lang/Throwable;)V

    goto/16 :goto_0

    .line 86
    :pswitch_2
    :try_start_2
    const-string v0, "walle"

    const/4 v1, 0x1

    new-array v1, v1, [Ljava/lang/Object;

    const/4 v2, 0x0

    new-instance v3, Ljava/lang/StringBuilder;

    invoke-direct {v3}, Ljava/lang/StringBuilder;-><init>()V

    const-string v4, "[internal] workEvent cache battery, event is "

    invoke-virtual {v3, v4}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v3

    invoke-virtual {p1}, Ljava/lang/Object;->toString()Ljava/lang/String;

    move-result-object v4

    invoke-virtual {v3, v4}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v3

    invoke-virtual {v3}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v3

    aput-object v3, v1, v2

    invoke-static {v0, v1}, Lcom/umeng/commonsdk/statistics/common/e;->a(Ljava/lang/String;[Ljava/lang/Object;)V

    .line 87
    iget-object v0, p0, Lcom/umeng/commonsdk/proguard/c;->a:Landroid/content/Context;

    invoke-virtual {p1}, Ljava/lang/Object;->toString()Ljava/lang/String;

    move-result-object v1

    invoke-static {v0, v1}, Lcom/umeng/commonsdk/proguard/s;->b(Landroid/content/Context;Ljava/lang/String;)V
    :try_end_2
    .catch Ljava/lang/Exception; {:try_start_2 .. :try_end_2} :catch_2

    goto/16 :goto_0

    .line 88
    :catch_2
    move-exception v0

    .line 89
    iget-object v1, p0, Lcom/umeng/commonsdk/proguard/c;->a:Landroid/content/Context;

    invoke-static {v1, v0}, Lcom/umeng/commonsdk/proguard/e;->a(Landroid/content/Context;Ljava/lang/Throwable;)V

    goto/16 :goto_0

    .line 96
    :pswitch_3
    :try_start_3
    const-string v0, "walle"

    const/4 v1, 0x1

    new-array v1, v1, [Ljava/lang/Object;

    const/4 v2, 0x0

    new-instance v3, Ljava/lang/StringBuilder;

    invoke-direct {v3}, Ljava/lang/StringBuilder;-><init>()V

    const-string v4, "[internal] workEvent cache station, event is "

    invoke-virtual {v3, v4}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v3

    invoke-virtual {p1}, Ljava/lang/Object;->toString()Ljava/lang/String;

    move-result-object v4

    invoke-virtual {v3, v4}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v3

    invoke-virtual {v3}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v3

    aput-object v3, v1, v2

    invoke-static {v0, v1}, Lcom/umeng/commonsdk/statistics/common/e;->a(Ljava/lang/String;[Ljava/lang/Object;)V

    .line 97
    iget-object v0, p0, Lcom/umeng/commonsdk/proguard/c;->a:Landroid/content/Context;

    invoke-virtual {p1}, Ljava/lang/Object;->toString()Ljava/lang/String;

    move-result-object v1

    invoke-static {v0, v1}, Lcom/umeng/commonsdk/proguard/s;->a(Landroid/content/Context;Ljava/lang/String;)V
    :try_end_3
    .catch Ljava/lang/Exception; {:try_start_3 .. :try_end_3} :catch_3

    goto/16 :goto_0

    .line 98
    :catch_3
    move-exception v0

    .line 99
    iget-object v1, p0, Lcom/umeng/commonsdk/proguard/c;->a:Landroid/content/Context;

    invoke-static {v1, v0}, Lcom/umeng/commonsdk/proguard/e;->a(Landroid/content/Context;Ljava/lang/Throwable;)V

    goto/16 :goto_0

    .line 104
    :pswitch_4
    iget-object v0, p0, Lcom/umeng/commonsdk/proguard/c;->a:Landroid/content/Context;

    check-cast p1, Lcom/umeng/commonsdk/proguard/j$b;

    invoke-static {v0, p1}, Lcom/umeng/commonsdk/proguard/n;->a(Landroid/content/Context;Lcom/umeng/commonsdk/proguard/j$b;)V

    goto/16 :goto_0

    .line 109
    :pswitch_5
    :try_start_4
    iget-object v0, p0, Lcom/umeng/commonsdk/proguard/c;->a:Landroid/content/Context;

    invoke-static {v0}, Lcom/umeng/commonsdk/proguard/c;->a(Landroid/content/Context;)V
    :try_end_4
    .catch Ljava/lang/Exception; {:try_start_4 .. :try_end_4} :catch_4

    goto/16 :goto_0

    .line 110
    :catch_4
    move-exception v0

    .line 111
    if-eqz v0, :cond_1

    .line 112
    new-instance v1, Ljava/lang/StringBuilder;

    invoke-direct {v1}, Ljava/lang/StringBuilder;-><init>()V

    const-string v2, "UM_INTERNAL_CACHE_WIFICHANGE_KEY:"

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v0}, Ljava/lang/Exception;->getMessage()Ljava/lang/String;

    move-result-object v2

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v1

    invoke-static {v1}, Lcom/umeng/commonsdk/statistics/common/e;->e(Ljava/lang/String;)V

    .line 114
    :cond_1
    iget-object v1, p0, Lcom/umeng/commonsdk/proguard/c;->a:Landroid/content/Context;

    invoke-static {v1, v0}, Lcom/umeng/commonsdk/proguard/e;->a(Landroid/content/Context;Ljava/lang/Throwable;)V

    goto/16 :goto_0

    .line 119
    :pswitch_6
    iget-object v0, p0, Lcom/umeng/commonsdk/proguard/c;->a:Landroid/content/Context;

    check-cast p1, Ljava/lang/String;

    invoke-static {v0, p1}, Lcom/umeng/commonsdk/proguard/n;->a(Landroid/content/Context;Ljava/lang/String;)V

    goto/16 :goto_0

    .line 124
    :pswitch_7
    iget-object v0, p0, Lcom/umeng/commonsdk/proguard/c;->a:Landroid/content/Context;

    invoke-virtual {v0}, Landroid/content/Context;->getApplicationContext()Landroid/content/Context;

    move-result-object v0

    const-string v1, "info"

    .line 125
    invoke-virtual {v0, v1, v3}, Landroid/content/Context;->getSharedPreferences(Ljava/lang/String;I)Landroid/content/SharedPreferences;

    move-result-object v0

    .line 126
    if-eqz v0, :cond_0

    .line 127
    invoke-interface {v0}, Landroid/content/SharedPreferences;->edit()Landroid/content/SharedPreferences$Editor;

    move-result-object v0

    const-string v1, "stat"

    check-cast p1, Ljava/lang/String;

    invoke-interface {v0, v1, p1}, Landroid/content/SharedPreferences$Editor;->putString(Ljava/lang/String;Ljava/lang/String;)Landroid/content/SharedPreferences$Editor;

    move-result-object v0

    invoke-interface {v0}, Landroid/content/SharedPreferences$Editor;->commit()Z

    goto/16 :goto_0

    .line 46
    :pswitch_data_0
    .packed-switch 0x8001
        :pswitch_0
        :pswitch_1
        :pswitch_2
        :pswitch_3
        :pswitch_4
        :pswitch_5
        :pswitch_6
        :pswitch_7
    .end packed-switch
.end method
