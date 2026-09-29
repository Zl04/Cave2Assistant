.class public Lcom/cyjh/mobileanjian/ipc/log/ScriptUnexpectedStopLog;
.super Lcom/cyjh/mobileanjian/ipc/log/a;
.source "SourceFile"


# static fields
.field private static final c:Ljava/lang/String; = "http://api.mobileanjian.com/api/SetErrorLog"


# instance fields
.field private d:I

.field private e:Ljava/lang/String;


# direct methods
.method public constructor <init>(Landroid/content/Context;)V
    .locals 0

    .prologue
    .line 25
    invoke-direct {p0, p1}, Lcom/cyjh/mobileanjian/ipc/log/a;-><init>(Landroid/content/Context;)V

    .line 26
    return-void
.end method

.method private static a(Landroid/content/Context;)Ljava/lang/String;
    .locals 2

    .prologue
    .line 81
    const-string v0, "connectivity"

    invoke-virtual {p0, v0}, Landroid/content/Context;->getSystemService(Ljava/lang/String;)Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Landroid/net/ConnectivityManager;

    .line 82
    invoke-virtual {v0}, Landroid/net/ConnectivityManager;->getActiveNetworkInfo()Landroid/net/NetworkInfo;

    move-result-object v0

    .line 83
    if-eqz v0, :cond_0

    invoke-virtual {v0}, Landroid/net/NetworkInfo;->isConnected()Z

    move-result v1

    if-nez v1, :cond_1

    .line 85
    :cond_0
    const-string v0, "No Network"

    .line 95
    :goto_0
    return-object v0

    .line 88
    :cond_1
    invoke-virtual {v0}, Landroid/net/NetworkInfo;->getType()I

    move-result v0

    packed-switch v0, :pswitch_data_0

    .line 95
    const-string v0, "UNKNOWN"

    goto :goto_0

    .line 91
    :pswitch_0
    const-string v0, "WIFI"

    goto :goto_0

    .line 93
    :pswitch_1
    const-string v0, "MOBILE"

    goto :goto_0

    .line 88
    nop

    :pswitch_data_0
    .packed-switch 0x0
        :pswitch_1
        :pswitch_0
    .end packed-switch
.end method


# virtual methods
.method protected a()V
    .locals 1

    .prologue
    .line 43
    const-string v0, "http://api.mobileanjian.com/api/SetErrorLog"

    iput-object v0, p0, Lcom/cyjh/mobileanjian/ipc/log/ScriptUnexpectedStopLog;->b:Ljava/lang/String;

    .line 44
    return-void
.end method

.method protected b()Ljava/lang/String;
    .locals 5

    .prologue
    .line 49
    invoke-static {}, Lcom/cyjh/mobileanjian/ipc/log/b;->a()Lcom/cyjh/mobileanjian/ipc/log/b;

    move-result-object v0

    .line 50
    new-instance v1, Lorg/json/JSONObject;

    invoke-direct {v1}, Lorg/json/JSONObject;-><init>()V

    .line 53
    :try_start_0
    new-instance v2, Lorg/json/JSONObject;

    invoke-direct {v2}, Lorg/json/JSONObject;-><init>()V

    .line 54
    const-string v3, "PhoneModel"

    iget-object v4, v0, Lcom/cyjh/mobileanjian/ipc/log/b;->a:Ljava/lang/String;

    invoke-virtual {v2, v3, v4}, Lorg/json/JSONObject;->put(Ljava/lang/String;Ljava/lang/Object;)Lorg/json/JSONObject;

    .line 55
    const-string v3, "MACMD5"

    iget-object v4, v0, Lcom/cyjh/mobileanjian/ipc/log/b;->c:Ljava/lang/String;

    invoke-virtual {v2, v3, v4}, Lorg/json/JSONObject;->put(Ljava/lang/String;Ljava/lang/Object;)Lorg/json/JSONObject;

    .line 56
    const-string v3, "AndroidVersion"

    iget-object v4, v0, Lcom/cyjh/mobileanjian/ipc/log/b;->b:Ljava/lang/String;

    invoke-virtual {v2, v3, v4}, Lorg/json/JSONObject;->put(Ljava/lang/String;Ljava/lang/Object;)Lorg/json/JSONObject;

    .line 57
    const-string v3, "ROM"

    iget-object v4, v0, Lcom/cyjh/mobileanjian/ipc/log/b;->d:Ljava/lang/String;

    invoke-virtual {v2, v3, v4}, Lorg/json/JSONObject;->put(Ljava/lang/String;Ljava/lang/Object;)Lorg/json/JSONObject;

    .line 59
    const-string v3, "PackageName"

    iget-object v4, v0, Lcom/cyjh/mobileanjian/ipc/log/b;->g:Ljava/lang/String;

    invoke-virtual {v2, v3, v4}, Lorg/json/JSONObject;->put(Ljava/lang/String;Ljava/lang/Object;)Lorg/json/JSONObject;

    .line 60
    const-string v3, "AppID"

    iget-object v4, v0, Lcom/cyjh/mobileanjian/ipc/log/b;->i:Ljava/lang/String;

    invoke-virtual {v2, v3, v4}, Lorg/json/JSONObject;->put(Ljava/lang/String;Ljava/lang/Object;)Lorg/json/JSONObject;

    .line 61
    const-string v3, "AppVersion"

    iget-object v4, v0, Lcom/cyjh/mobileanjian/ipc/log/b;->k:Ljava/lang/String;

    invoke-virtual {v2, v3, v4}, Lorg/json/JSONObject;->put(Ljava/lang/String;Ljava/lang/Object;)Lorg/json/JSONObject;

    .line 62
    const-string v3, "Version"

    iget-object v4, v0, Lcom/cyjh/mobileanjian/ipc/log/b;->l:Ljava/lang/String;

    invoke-virtual {v2, v3, v4}, Lorg/json/JSONObject;->put(Ljava/lang/String;Ljava/lang/Object;)Lorg/json/JSONObject;

    .line 63
    const-string v3, "IsFree"

    iget-boolean v0, v0, Lcom/cyjh/mobileanjian/ipc/log/b;->j:Z

    if-eqz v0, :cond_0

    const-string v0, "1"

    :goto_0
    invoke-virtual {v2, v3, v0}, Lorg/json/JSONObject;->put(Ljava/lang/String;Ljava/lang/Object;)Lorg/json/JSONObject;

    .line 64
    const-string v0, "NetworkType"

    iget-object v3, p0, Lcom/cyjh/mobileanjian/ipc/log/ScriptUnexpectedStopLog;->a:Landroid/content/Context;

    invoke-static {v3}, Lcom/cyjh/mobileanjian/ipc/log/ScriptUnexpectedStopLog;->a(Landroid/content/Context;)Ljava/lang/String;

    move-result-object v3

    invoke-virtual {v2, v0, v3}, Lorg/json/JSONObject;->put(Ljava/lang/String;Ljava/lang/Object;)Lorg/json/JSONObject;

    .line 65
    const-string v0, "MqmCode"

    iget v3, p0, Lcom/cyjh/mobileanjian/ipc/log/ScriptUnexpectedStopLog;->d:I

    invoke-static {v3}, Ljava/lang/String;->valueOf(I)Ljava/lang/String;

    move-result-object v3

    invoke-virtual {v2, v0, v3}, Lorg/json/JSONObject;->put(Ljava/lang/String;Ljava/lang/Object;)Lorg/json/JSONObject;

    .line 66
    const-string v0, "MqmMessage"

    iget v3, p0, Lcom/cyjh/mobileanjian/ipc/log/ScriptUnexpectedStopLog;->d:I

    invoke-static {v3}, Lcom/cyjh/mobileanjian/ipc/stuff/MqmCode;->getMessageFromCode(I)Ljava/lang/String;

    move-result-object v3

    invoke-virtual {v2, v0, v3}, Lorg/json/JSONObject;->put(Ljava/lang/String;Ljava/lang/Object;)Lorg/json/JSONObject;

    .line 67
    const-string v0, "ExtraMessage"

    iget-object v3, p0, Lcom/cyjh/mobileanjian/ipc/log/ScriptUnexpectedStopLog;->e:Ljava/lang/String;

    invoke-virtual {v2, v0, v3}, Lorg/json/JSONObject;->put(Ljava/lang/String;Ljava/lang/Object;)Lorg/json/JSONObject;

    .line 69
    const-string v0, "Data"

    invoke-virtual {v1, v0, v2}, Lorg/json/JSONObject;->put(Ljava/lang/String;Ljava/lang/Object;)Lorg/json/JSONObject;
    :try_end_0
    .catch Lorg/json/JSONException; {:try_start_0 .. :try_end_0} :catch_0

    .line 76
    :goto_1
    invoke-virtual {v1}, Lorg/json/JSONObject;->toString()Ljava/lang/String;

    move-result-object v0

    return-object v0

    .line 63
    :cond_0
    :try_start_1
    const-string v0, "0"
    :try_end_1
    .catch Lorg/json/JSONException; {:try_start_1 .. :try_end_1} :catch_0

    goto :goto_0

    .line 71
    :catch_0
    move-exception v0

    .line 73
    invoke-virtual {v0}, Lorg/json/JSONException;->printStackTrace()V

    goto :goto_1
.end method

.method public setExtraLog(Ljava/lang/String;)Lcom/cyjh/mobileanjian/ipc/log/ScriptUnexpectedStopLog;
    .locals 0

    .prologue
    .line 36
    iput-object p1, p0, Lcom/cyjh/mobileanjian/ipc/log/ScriptUnexpectedStopLog;->e:Ljava/lang/String;

    .line 37
    return-object p0
.end method

.method public setMqmCode(I)Lcom/cyjh/mobileanjian/ipc/log/ScriptUnexpectedStopLog;
    .locals 0

    .prologue
    .line 30
    iput p1, p0, Lcom/cyjh/mobileanjian/ipc/log/ScriptUnexpectedStopLog;->d:I

    .line 31
    return-object p0
.end method
