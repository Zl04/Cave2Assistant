.class public Lcom/cyjh/mobileanjian/ipc/log/ScriptRunDurationLog;
.super Lcom/cyjh/mobileanjian/ipc/log/a;
.source "SourceFile"


# static fields
.field private static final c:Ljava/lang/String; = "http://api.mobileanjian.com/api/SetOperationLog"

.field private static final d:I = 0x4


# instance fields
.field private e:J


# direct methods
.method public constructor <init>(Landroid/content/Context;)V
    .locals 0

    .prologue
    .line 22
    invoke-direct {p0, p1}, Lcom/cyjh/mobileanjian/ipc/log/a;-><init>(Landroid/content/Context;)V

    .line 23
    return-void
.end method


# virtual methods
.method protected a()V
    .locals 1

    .prologue
    .line 34
    const-string v0, "http://api.mobileanjian.com/api/SetOperationLog"

    iput-object v0, p0, Lcom/cyjh/mobileanjian/ipc/log/ScriptRunDurationLog;->b:Ljava/lang/String;

    .line 35
    return-void
.end method

.method protected b()Ljava/lang/String;
    .locals 8

    .prologue
    .line 40
    invoke-static {}, Lcom/cyjh/mobileanjian/ipc/log/b;->a()Lcom/cyjh/mobileanjian/ipc/log/b;

    move-result-object v1

    .line 41
    new-instance v2, Lorg/json/JSONObject;

    invoke-direct {v2}, Lorg/json/JSONObject;-><init>()V

    .line 44
    :try_start_0
    new-instance v3, Lorg/json/JSONObject;

    invoke-direct {v3}, Lorg/json/JSONObject;-><init>()V

    .line 45
    const-string v0, "PhoneModel"

    iget-object v4, v1, Lcom/cyjh/mobileanjian/ipc/log/b;->a:Ljava/lang/String;

    invoke-virtual {v3, v0, v4}, Lorg/json/JSONObject;->put(Ljava/lang/String;Ljava/lang/Object;)Lorg/json/JSONObject;

    .line 46
    const-string v0, "MACMD5"

    iget-object v4, v1, Lcom/cyjh/mobileanjian/ipc/log/b;->c:Ljava/lang/String;

    invoke-virtual {v3, v0, v4}, Lorg/json/JSONObject;->put(Ljava/lang/String;Ljava/lang/Object;)Lorg/json/JSONObject;

    .line 47
    const-string v0, "AndroidVersion"

    iget-object v4, v1, Lcom/cyjh/mobileanjian/ipc/log/b;->b:Ljava/lang/String;

    invoke-virtual {v3, v0, v4}, Lorg/json/JSONObject;->put(Ljava/lang/String;Ljava/lang/Object;)Lorg/json/JSONObject;

    .line 48
    const-string v0, "ROM"

    iget-object v4, v1, Lcom/cyjh/mobileanjian/ipc/log/b;->d:Ljava/lang/String;

    invoke-virtual {v3, v0, v4}, Lorg/json/JSONObject;->put(Ljava/lang/String;Ljava/lang/Object;)Lorg/json/JSONObject;

    .line 50
    const-string v0, "PackageName"

    iget-object v4, v1, Lcom/cyjh/mobileanjian/ipc/log/b;->g:Ljava/lang/String;

    invoke-virtual {v3, v0, v4}, Lorg/json/JSONObject;->put(Ljava/lang/String;Ljava/lang/Object;)Lorg/json/JSONObject;

    .line 51
    const-string v4, "IsNew"

    iget-boolean v0, v1, Lcom/cyjh/mobileanjian/ipc/log/b;->m:Z

    if-eqz v0, :cond_0

    const-string v0, "1"

    :goto_0
    invoke-virtual {v3, v4, v0}, Lorg/json/JSONObject;->put(Ljava/lang/String;Ljava/lang/Object;)Lorg/json/JSONObject;

    .line 52
    const-string v0, "AppID"

    iget-object v4, v1, Lcom/cyjh/mobileanjian/ipc/log/b;->i:Ljava/lang/String;

    invoke-virtual {v3, v0, v4}, Lorg/json/JSONObject;->put(Ljava/lang/String;Ljava/lang/Object;)Lorg/json/JSONObject;

    .line 53
    const-string v0, "AppVersion"

    iget-object v4, v1, Lcom/cyjh/mobileanjian/ipc/log/b;->k:Ljava/lang/String;

    invoke-virtual {v3, v0, v4}, Lorg/json/JSONObject;->put(Ljava/lang/String;Ljava/lang/Object;)Lorg/json/JSONObject;

    .line 54
    const-string v0, "Version"

    iget-object v4, v1, Lcom/cyjh/mobileanjian/ipc/log/b;->l:Ljava/lang/String;

    invoke-virtual {v3, v0, v4}, Lorg/json/JSONObject;->put(Ljava/lang/String;Ljava/lang/Object;)Lorg/json/JSONObject;

    .line 55
    const-string v4, "IsFree"

    iget-boolean v0, v1, Lcom/cyjh/mobileanjian/ipc/log/b;->j:Z

    if-eqz v0, :cond_1

    const-string v0, "1"

    :goto_1
    invoke-virtual {v3, v4, v0}, Lorg/json/JSONObject;->put(Ljava/lang/String;Ljava/lang/Object;)Lorg/json/JSONObject;

    .line 56
    const-string v0, "UsedTime"

    invoke-static {}, Landroid/os/SystemClock;->uptimeMillis()J

    move-result-wide v4

    iget-wide v6, p0, Lcom/cyjh/mobileanjian/ipc/log/ScriptRunDurationLog;->e:J

    sub-long/2addr v4, v6

    const-wide/16 v6, 0x3e8

    div-long/2addr v4, v6

    invoke-static {v4, v5}, Ljava/lang/String;->valueOf(J)Ljava/lang/String;

    move-result-object v1

    invoke-virtual {v3, v0, v1}, Lorg/json/JSONObject;->put(Ljava/lang/String;Ljava/lang/Object;)Lorg/json/JSONObject;

    .line 58
    const-string v0, "LogType"

    const/4 v1, 0x4

    invoke-static {v1}, Ljava/lang/String;->valueOf(I)Ljava/lang/String;

    move-result-object v1

    invoke-virtual {v2, v0, v1}, Lorg/json/JSONObject;->put(Ljava/lang/String;Ljava/lang/Object;)Lorg/json/JSONObject;

    .line 59
    const-string v0, "Data"

    invoke-virtual {v2, v0, v3}, Lorg/json/JSONObject;->put(Ljava/lang/String;Ljava/lang/Object;)Lorg/json/JSONObject;
    :try_end_0
    .catch Lorg/json/JSONException; {:try_start_0 .. :try_end_0} :catch_0

    .line 66
    :goto_2
    invoke-virtual {v2}, Lorg/json/JSONObject;->toString()Ljava/lang/String;

    move-result-object v0

    return-object v0

    .line 51
    :cond_0
    :try_start_1
    const-string v0, "0"

    goto :goto_0

    .line 55
    :cond_1
    const-string v0, "0"
    :try_end_1
    .catch Lorg/json/JSONException; {:try_start_1 .. :try_end_1} :catch_0

    goto :goto_1

    .line 61
    :catch_0
    move-exception v0

    .line 63
    invoke-virtual {v0}, Lorg/json/JSONException;->printStackTrace()V

    goto :goto_2
.end method

.method public setScriptStartTime(J)Lcom/cyjh/mobileanjian/ipc/log/ScriptRunDurationLog;
    .locals 1

    .prologue
    .line 27
    iput-wide p1, p0, Lcom/cyjh/mobileanjian/ipc/log/ScriptRunDurationLog;->e:J

    .line 28
    return-object p0
.end method
