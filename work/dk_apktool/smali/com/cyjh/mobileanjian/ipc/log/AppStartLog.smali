.class public Lcom/cyjh/mobileanjian/ipc/log/AppStartLog;
.super Lcom/cyjh/mobileanjian/ipc/log/a;
.source "SourceFile"


# static fields
.field private static final c:Ljava/lang/String; = "http://api.mobileanjian.com/api/SetOperationLog"

.field private static final d:I = 0x3


# direct methods
.method public constructor <init>(Landroid/content/Context;)V
    .locals 0

    .prologue
    .line 19
    invoke-direct {p0, p1}, Lcom/cyjh/mobileanjian/ipc/log/a;-><init>(Landroid/content/Context;)V

    .line 20
    return-void
.end method


# virtual methods
.method protected a()V
    .locals 1

    .prologue
    .line 25
    const-string v0, "http://api.mobileanjian.com/api/SetOperationLog"

    iput-object v0, p0, Lcom/cyjh/mobileanjian/ipc/log/AppStartLog;->b:Ljava/lang/String;

    .line 26
    return-void
.end method

.method protected b()Ljava/lang/String;
    .locals 5

    .prologue
    .line 31
    invoke-static {}, Lcom/cyjh/mobileanjian/ipc/log/b;->a()Lcom/cyjh/mobileanjian/ipc/log/b;

    move-result-object v1

    .line 32
    new-instance v2, Lorg/json/JSONObject;

    invoke-direct {v2}, Lorg/json/JSONObject;-><init>()V

    .line 35
    :try_start_0
    new-instance v3, Lorg/json/JSONObject;

    invoke-direct {v3}, Lorg/json/JSONObject;-><init>()V

    .line 36
    const-string v0, "PhoneModel"

    iget-object v4, v1, Lcom/cyjh/mobileanjian/ipc/log/b;->a:Ljava/lang/String;

    invoke-virtual {v3, v0, v4}, Lorg/json/JSONObject;->put(Ljava/lang/String;Ljava/lang/Object;)Lorg/json/JSONObject;

    .line 37
    const-string v0, "MACMD5"

    iget-object v4, v1, Lcom/cyjh/mobileanjian/ipc/log/b;->c:Ljava/lang/String;

    invoke-virtual {v3, v0, v4}, Lorg/json/JSONObject;->put(Ljava/lang/String;Ljava/lang/Object;)Lorg/json/JSONObject;

    .line 38
    const-string v0, "AndroidVersion"

    iget-object v4, v1, Lcom/cyjh/mobileanjian/ipc/log/b;->b:Ljava/lang/String;

    invoke-virtual {v3, v0, v4}, Lorg/json/JSONObject;->put(Ljava/lang/String;Ljava/lang/Object;)Lorg/json/JSONObject;

    .line 39
    const-string v0, "ROM"

    iget-object v4, v1, Lcom/cyjh/mobileanjian/ipc/log/b;->d:Ljava/lang/String;

    invoke-virtual {v3, v0, v4}, Lorg/json/JSONObject;->put(Ljava/lang/String;Ljava/lang/Object;)Lorg/json/JSONObject;

    .line 41
    const-string v0, "PackageName"

    iget-object v4, v1, Lcom/cyjh/mobileanjian/ipc/log/b;->g:Ljava/lang/String;

    invoke-virtual {v3, v0, v4}, Lorg/json/JSONObject;->put(Ljava/lang/String;Ljava/lang/Object;)Lorg/json/JSONObject;

    .line 42
    const-string v4, "IsNew"

    iget-boolean v0, v1, Lcom/cyjh/mobileanjian/ipc/log/b;->m:Z

    if-eqz v0, :cond_0

    const-string v0, "1"

    :goto_0
    invoke-virtual {v3, v4, v0}, Lorg/json/JSONObject;->put(Ljava/lang/String;Ljava/lang/Object;)Lorg/json/JSONObject;

    .line 43
    const-string v0, "AppID"

    iget-object v4, v1, Lcom/cyjh/mobileanjian/ipc/log/b;->i:Ljava/lang/String;

    invoke-virtual {v3, v0, v4}, Lorg/json/JSONObject;->put(Ljava/lang/String;Ljava/lang/Object;)Lorg/json/JSONObject;

    .line 44
    const-string v0, "AppVersion"

    iget-object v4, v1, Lcom/cyjh/mobileanjian/ipc/log/b;->k:Ljava/lang/String;

    invoke-virtual {v3, v0, v4}, Lorg/json/JSONObject;->put(Ljava/lang/String;Ljava/lang/Object;)Lorg/json/JSONObject;

    .line 45
    const-string v0, "Version"

    iget-object v4, v1, Lcom/cyjh/mobileanjian/ipc/log/b;->l:Ljava/lang/String;

    invoke-virtual {v3, v0, v4}, Lorg/json/JSONObject;->put(Ljava/lang/String;Ljava/lang/Object;)Lorg/json/JSONObject;

    .line 46
    const-string v4, "IsFree"

    iget-boolean v0, v1, Lcom/cyjh/mobileanjian/ipc/log/b;->j:Z

    if-eqz v0, :cond_1

    const-string v0, "1"

    :goto_1
    invoke-virtual {v3, v4, v0}, Lorg/json/JSONObject;->put(Ljava/lang/String;Ljava/lang/Object;)Lorg/json/JSONObject;

    .line 47
    const-string v0, "UsedTime"

    const-string v1, "0"

    invoke-virtual {v3, v0, v1}, Lorg/json/JSONObject;->put(Ljava/lang/String;Ljava/lang/Object;)Lorg/json/JSONObject;

    .line 49
    const-string v0, "LogType"

    const/4 v1, 0x3

    invoke-static {v1}, Ljava/lang/String;->valueOf(I)Ljava/lang/String;

    move-result-object v1

    invoke-virtual {v2, v0, v1}, Lorg/json/JSONObject;->put(Ljava/lang/String;Ljava/lang/Object;)Lorg/json/JSONObject;

    .line 50
    const-string v0, "Data"

    invoke-virtual {v2, v0, v3}, Lorg/json/JSONObject;->put(Ljava/lang/String;Ljava/lang/Object;)Lorg/json/JSONObject;
    :try_end_0
    .catch Lorg/json/JSONException; {:try_start_0 .. :try_end_0} :catch_0

    .line 57
    :goto_2
    invoke-virtual {v2}, Lorg/json/JSONObject;->toString()Ljava/lang/String;

    move-result-object v0

    return-object v0

    .line 42
    :cond_0
    :try_start_1
    const-string v0, "0"

    goto :goto_0

    .line 46
    :cond_1
    const-string v0, "0"
    :try_end_1
    .catch Lorg/json/JSONException; {:try_start_1 .. :try_end_1} :catch_0

    goto :goto_1

    .line 52
    :catch_0
    move-exception v0

    .line 54
    invoke-virtual {v0}, Lorg/json/JSONException;->printStackTrace()V

    goto :goto_2
.end method
