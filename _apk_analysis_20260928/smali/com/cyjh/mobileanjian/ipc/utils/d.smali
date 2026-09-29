.class public Lcom/cyjh/mobileanjian/ipc/utils/d;
.super Ljava/lang/Object;
.source "SourceFile"


# static fields
.field private static final a:Ljava/lang/String; = "http://logapi.mobileanjian.com/api/SetLog"

.field private static final b:I = 0x4

.field private static final c:Ljava/lang/String; = "RunScriptDurationApi"

.field private static d:Ljava/lang/String;


# direct methods
.method static constructor <clinit>()V
    .locals 1

    .prologue
    .line 26
    const/4 v0, 0x0

    sput-object v0, Lcom/cyjh/mobileanjian/ipc/utils/d;->d:Ljava/lang/String;

    return-void
.end method

.method public constructor <init>()V
    .locals 0

    .prologue
    .line 18
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method

.method private static varargs a(Landroid/content/Context;I[J)Ljava/lang/String;
    .locals 8

    .prologue
    .line 30
    new-instance v1, Lorg/json/JSONObject;

    invoke-direct {v1}, Lorg/json/JSONObject;-><init>()V

    .line 33
    :try_start_0
    new-instance v2, Lorg/json/JSONObject;

    invoke-direct {v2}, Lorg/json/JSONObject;-><init>()V

    .line 34
    const-string v0, "AppID"

    invoke-static {}, Lcom/cyjh/mobileanjian/ipc/stuff/AppAttr;->getAppId()Ljava/lang/String;

    move-result-object v3

    invoke-virtual {v2, v0, v3}, Lorg/json/JSONObject;->put(Ljava/lang/String;Ljava/lang/Object;)Lorg/json/JSONObject;

    .line 35
    const-string v0, "MachineCode"

    invoke-static {p0}, Lcom/cyjh/mobileanjian/ipc/utils/m;->b(Landroid/content/Context;)Ljava/lang/String;

    move-result-object v3

    invoke-virtual {v2, v0, v3}, Lorg/json/JSONObject;->put(Ljava/lang/String;Ljava/lang/Object;)Lorg/json/JSONObject;

    .line 36
    const-string v0, "AppVersion"

    invoke-static {}, Lcom/cyjh/mobileanjian/ipc/stuff/AppAttr;->getEfinVersion()Ljava/lang/String;

    move-result-object v3

    invoke-virtual {v2, v0, v3}, Lorg/json/JSONObject;->put(Ljava/lang/String;Ljava/lang/Object;)Lorg/json/JSONObject;

    .line 37
    const-string v3, "IsFree"

    invoke-static {}, Lcom/cyjh/mobileanjian/ipc/stuff/AppAttr;->isEfinFree()Z

    move-result v0

    if-eqz v0, :cond_0

    const-string v0, "1"

    :goto_0
    invoke-virtual {v2, v3, v0}, Lorg/json/JSONObject;->put(Ljava/lang/String;Ljava/lang/Object;)Lorg/json/JSONObject;

    .line 38
    const-string v0, "UsedTime"

    invoke-static {}, Landroid/os/SystemClock;->uptimeMillis()J

    move-result-wide v4

    const/4 v3, 0x0

    aget-wide v6, p2, v3

    sub-long/2addr v4, v6

    const-wide/16 v6, 0x3e8

    div-long/2addr v4, v6

    invoke-static {v4, v5}, Ljava/lang/String;->valueOf(J)Ljava/lang/String;

    move-result-object v3

    invoke-virtual {v2, v0, v3}, Lorg/json/JSONObject;->put(Ljava/lang/String;Ljava/lang/Object;)Lorg/json/JSONObject;

    .line 40
    const-string v0, "LogType"

    invoke-static {p1}, Ljava/lang/String;->valueOf(I)Ljava/lang/String;

    move-result-object v3

    invoke-virtual {v1, v0, v3}, Lorg/json/JSONObject;->put(Ljava/lang/String;Ljava/lang/Object;)Lorg/json/JSONObject;

    .line 41
    const-string v0, "Data"

    invoke-virtual {v1, v0, v2}, Lorg/json/JSONObject;->put(Ljava/lang/String;Ljava/lang/Object;)Lorg/json/JSONObject;
    :try_end_0
    .catch Lorg/json/JSONException; {:try_start_0 .. :try_end_0} :catch_0

    .line 48
    :goto_1
    invoke-virtual {v1}, Lorg/json/JSONObject;->toString()Ljava/lang/String;

    move-result-object v0

    return-object v0

    .line 37
    :cond_0
    :try_start_1
    const-string v0, "0"
    :try_end_1
    .catch Lorg/json/JSONException; {:try_start_1 .. :try_end_1} :catch_0

    goto :goto_0

    .line 43
    :catch_0
    move-exception v0

    .line 45
    invoke-virtual {v0}, Lorg/json/JSONException;->printStackTrace()V

    goto :goto_1
.end method

.method public static a(Landroid/content/Context;J)V
    .locals 7

    .prologue
    const/4 v5, 0x0

    .line 53
    invoke-static {}, Lcom/cyjh/mobileanjian/ipc/utils/CLog;->isDebug()Z

    move-result v0

    if-eqz v0, :cond_1

    sget-object v0, Lcom/cyjh/mobileanjian/ipc/utils/d;->d:Ljava/lang/String;

    if-nez v0, :cond_1

    .line 55
    const-string v0, "http://testurls.mobileanjian.com/minielf.html"

    invoke-static {v0, v5}, Lcom/cyjh/mobileanjian/ipc/utils/MiscUtils;->sendGet(Ljava/lang/String;Ljava/lang/String;)Ljava/lang/String;

    move-result-object v0

    .line 56
    invoke-static {v0}, Landroid/text/TextUtils;->isEmpty(Ljava/lang/CharSequence;)Z

    move-result v1

    if-nez v1, :cond_0

    .line 59
    :try_start_0
    new-instance v1, Lorg/json/JSONObject;

    invoke-direct {v1, v0}, Lorg/json/JSONObject;-><init>(Ljava/lang/String;)V

    const-string v0, "RunScriptDurationApi"

    invoke-virtual {v1, v0}, Lorg/json/JSONObject;->getString(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v0

    sput-object v0, Lcom/cyjh/mobileanjian/ipc/utils/d;->d:Ljava/lang/String;
    :try_end_0
    .catch Lorg/json/JSONException; {:try_start_0 .. :try_end_0} :catch_0

    .line 71
    :goto_0
    new-instance v0, Ljava/lang/StringBuilder;

    invoke-direct {v0}, Ljava/lang/StringBuilder;-><init>()V

    const-string v1, "log uri: "

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    sget-object v1, Lcom/cyjh/mobileanjian/ipc/utils/d;->d:Ljava/lang/String;

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-virtual {v0}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v0

    invoke-static {v0}, Lcom/cyjh/mobileanjian/ipc/utils/CLog;->i(Ljava/lang/String;)V

    .line 73
    new-instance v0, Lcom/lidroid/xutils/HttpUtils;

    invoke-direct {v0}, Lcom/lidroid/xutils/HttpUtils;-><init>()V

    .line 74
    new-instance v1, Lcom/lidroid/xutils/http/RequestParams;

    invoke-direct {v1}, Lcom/lidroid/xutils/http/RequestParams;-><init>()V

    .line 75
    const/4 v2, 0x4

    const/4 v3, 0x1

    new-array v3, v3, [J

    const/4 v4, 0x0

    aput-wide p1, v3, v4

    invoke-static {p0, v2, v3}, Lcom/cyjh/mobileanjian/ipc/utils/d;->a(Landroid/content/Context;I[J)Ljava/lang/String;

    move-result-object v2

    .line 76
    const-string v3, "Data"

    invoke-virtual {v1, v3, v2}, Lcom/lidroid/xutils/http/RequestParams;->addQueryStringParameter(Ljava/lang/String;Ljava/lang/String;)V

    .line 77
    sget-object v2, Lcom/lidroid/xutils/http/client/HttpRequest$HttpMethod;->GET:Lcom/lidroid/xutils/http/client/HttpRequest$HttpMethod;

    sget-object v3, Lcom/cyjh/mobileanjian/ipc/utils/d;->d:Ljava/lang/String;

    invoke-virtual {v0, v2, v3, v1, v5}, Lcom/lidroid/xutils/HttpUtils;->send(Lcom/lidroid/xutils/http/client/HttpRequest$HttpMethod;Ljava/lang/String;Lcom/lidroid/xutils/http/RequestParams;Lcom/lidroid/xutils/http/callback/RequestCallBack;)Lcom/lidroid/xutils/http/HttpHandler;

    .line 78
    return-void

    .line 60
    :catch_0
    move-exception v0

    .line 62
    const-string v1, "http://logapi.mobileanjian.com/api/SetLog"

    sput-object v1, Lcom/cyjh/mobileanjian/ipc/utils/d;->d:Ljava/lang/String;

    .line 63
    invoke-virtual {v0}, Lorg/json/JSONException;->printStackTrace()V

    goto :goto_0

    .line 66
    :cond_0
    const-string v0, "http://logapi.mobileanjian.com/api/SetLog"

    sput-object v0, Lcom/cyjh/mobileanjian/ipc/utils/d;->d:Ljava/lang/String;

    goto :goto_0

    .line 69
    :cond_1
    const-string v0, "http://logapi.mobileanjian.com/api/SetLog"

    sput-object v0, Lcom/cyjh/mobileanjian/ipc/utils/d;->d:Ljava/lang/String;

    goto :goto_0
.end method
