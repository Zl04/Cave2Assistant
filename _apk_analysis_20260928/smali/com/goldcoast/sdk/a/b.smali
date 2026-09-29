.class public final Lcom/goldcoast/sdk/a/b;
.super Lcom/goldcoast/sdk/a/c;
.source "SourceFile"


# annotations
.annotation system Ldalvik/annotation/Signature;
    value = {
        "Lcom/goldcoast/sdk/a/c",
        "<",
        "Lcom/goldcoast/sdk/a/b;",
        ">;"
    }
.end annotation


# instance fields
.field private a:Ljava/lang/String;

.field private b:Ljava/lang/String;

.field private c:Lcom/goldcoast/sdk/a/a;

.field private d:Lcom/goldcoast/sdk/a/e;

.field private e:Ljava/lang/String;

.field private f:Ljava/lang/String;

.field private g:Ljava/lang/String;

.field private h:Lcom/goldcoast/sdk/a/f;

.field private i:Ljava/lang/String;

.field private j:Ljava/lang/String;


# direct methods
.method public constructor <init>()V
    .locals 0

    .prologue
    .line 34
    invoke-direct {p0}, Lcom/goldcoast/sdk/a/c;-><init>()V

    .line 35
    return-void
.end method


# virtual methods
.method public final a()Lorg/json/JSONObject;
    .locals 3

    .prologue
    .line 59
    new-instance v1, Lorg/json/JSONObject;

    invoke-direct {v1}, Lorg/json/JSONObject;-><init>()V

    .line 61
    :try_start_0
    const-string v0, "cpuinfo"

    iget-object v2, p0, Lcom/goldcoast/sdk/a/b;->c:Lcom/goldcoast/sdk/a/a;

    invoke-virtual {v2}, Lcom/goldcoast/sdk/a/a;->a()Lorg/json/JSONObject;

    move-result-object v2

    invoke-virtual {v1, v0, v2}, Lorg/json/JSONObject;->put(Ljava/lang/String;Ljava/lang/Object;)Lorg/json/JSONObject;
    :try_end_0
    .catch Lorg/json/JSONException; {:try_start_0 .. :try_end_0} :catch_0

    .line 66
    :goto_0
    :try_start_1
    const-string v0, "prop"

    iget-object v2, p0, Lcom/goldcoast/sdk/a/b;->d:Lcom/goldcoast/sdk/a/e;

    invoke-virtual {v2}, Lcom/goldcoast/sdk/a/e;->a()Lorg/json/JSONObject;

    move-result-object v2

    invoke-virtual {v1, v0, v2}, Lorg/json/JSONObject;->put(Ljava/lang/String;Ljava/lang/Object;)Lorg/json/JSONObject;
    :try_end_1
    .catch Lorg/json/JSONException; {:try_start_1 .. :try_end_1} :catch_1

    .line 71
    :goto_1
    :try_start_2
    const-string v0, "propInfo"

    iget-object v2, p0, Lcom/goldcoast/sdk/a/b;->h:Lcom/goldcoast/sdk/a/f;

    invoke-virtual {v2}, Lcom/goldcoast/sdk/a/f;->b()Lorg/json/JSONObject;

    move-result-object v2

    invoke-virtual {v1, v0, v2}, Lorg/json/JSONObject;->put(Ljava/lang/String;Ljava/lang/Object;)Lorg/json/JSONObject;
    :try_end_2
    .catch Lorg/json/JSONException; {:try_start_2 .. :try_end_2} :catch_2

    .line 76
    :goto_2
    :try_start_3
    const-string v0, "MemTotal"

    iget-object v2, p0, Lcom/goldcoast/sdk/a/b;->a:Ljava/lang/String;

    invoke-virtual {v1, v0, v2}, Lorg/json/JSONObject;->put(Ljava/lang/String;Ljava/lang/Object;)Lorg/json/JSONObject;

    .line 77
    const-string v0, "linuxversion"

    iget-object v2, p0, Lcom/goldcoast/sdk/a/b;->b:Ljava/lang/String;

    invoke-virtual {v1, v0, v2}, Lorg/json/JSONObject;->put(Ljava/lang/String;Ljava/lang/Object;)Lorg/json/JSONObject;

    .line 79
    const-string v0, "imei"

    iget-object v2, p0, Lcom/goldcoast/sdk/a/b;->e:Ljava/lang/String;

    invoke-virtual {v1, v0, v2}, Lorg/json/JSONObject;->put(Ljava/lang/String;Ljava/lang/Object;)Lorg/json/JSONObject;

    .line 80
    const-string v0, "macAddr"

    iget-object v2, p0, Lcom/goldcoast/sdk/a/b;->f:Ljava/lang/String;

    invoke-virtual {v1, v0, v2}, Lorg/json/JSONObject;->put(Ljava/lang/String;Ljava/lang/Object;)Lorg/json/JSONObject;

    .line 81
    const-string v0, "androidId"

    iget-object v2, p0, Lcom/goldcoast/sdk/a/b;->g:Ljava/lang/String;

    invoke-virtual {v1, v0, v2}, Lorg/json/JSONObject;->put(Ljava/lang/String;Ljava/lang/Object;)Lorg/json/JSONObject;

    .line 82
    const-string v0, "currentTime"

    iget-object v2, p0, Lcom/goldcoast/sdk/a/b;->i:Ljava/lang/String;

    invoke-virtual {v1, v0, v2}, Lorg/json/JSONObject;->put(Ljava/lang/String;Ljava/lang/Object;)Lorg/json/JSONObject;

    .line 83
    const-string v0, "cpuType"

    iget-object v2, p0, Lcom/goldcoast/sdk/a/b;->j:Ljava/lang/String;

    invoke-virtual {v1, v0, v2}, Lorg/json/JSONObject;->put(Ljava/lang/String;Ljava/lang/Object;)Lorg/json/JSONObject;
    :try_end_3
    .catch Lorg/json/JSONException; {:try_start_3 .. :try_end_3} :catch_3

    .line 87
    :goto_3
    return-object v1

    .line 63
    :catch_0
    move-exception v0

    invoke-virtual {v0}, Lorg/json/JSONException;->printStackTrace()V

    goto :goto_0

    .line 68
    :catch_1
    move-exception v0

    invoke-virtual {v0}, Lorg/json/JSONException;->printStackTrace()V

    goto :goto_1

    .line 73
    :catch_2
    move-exception v0

    invoke-virtual {v0}, Lorg/json/JSONException;->printStackTrace()V

    goto :goto_2

    .line 85
    :catch_3
    move-exception v0

    invoke-virtual {v0}, Lorg/json/JSONException;->printStackTrace()V

    goto :goto_3
.end method

.method public final a(Lcom/goldcoast/sdk/a/a;)V
    .locals 0

    .prologue
    .line 111
    iput-object p1, p0, Lcom/goldcoast/sdk/a/b;->c:Lcom/goldcoast/sdk/a/a;

    .line 112
    return-void
.end method

.method public final a(Lcom/goldcoast/sdk/a/e;)V
    .locals 0

    .prologue
    .line 119
    iput-object p1, p0, Lcom/goldcoast/sdk/a/b;->d:Lcom/goldcoast/sdk/a/e;

    .line 120
    return-void
.end method

.method public final a(Lcom/goldcoast/sdk/a/f;)V
    .locals 0

    .prologue
    .line 159
    iput-object p1, p0, Lcom/goldcoast/sdk/a/b;->h:Lcom/goldcoast/sdk/a/f;

    .line 160
    return-void
.end method

.method public final a(Ljava/lang/String;)V
    .locals 0

    .prologue
    .line 95
    iput-object p1, p0, Lcom/goldcoast/sdk/a/b;->a:Ljava/lang/String;

    .line 96
    return-void
.end method

.method public final b()Lcom/goldcoast/sdk/a/e;
    .locals 1

    .prologue
    .line 115
    iget-object v0, p0, Lcom/goldcoast/sdk/a/b;->d:Lcom/goldcoast/sdk/a/e;

    return-object v0
.end method

.method public final b(Ljava/lang/String;)V
    .locals 0

    .prologue
    .line 103
    iput-object p1, p0, Lcom/goldcoast/sdk/a/b;->b:Ljava/lang/String;

    .line 104
    return-void
.end method

.method public final c(Ljava/lang/String;)V
    .locals 0

    .prologue
    .line 135
    iput-object p1, p0, Lcom/goldcoast/sdk/a/b;->e:Ljava/lang/String;

    .line 136
    return-void
.end method

.method public final d(Ljava/lang/String;)V
    .locals 0

    .prologue
    .line 143
    iput-object p1, p0, Lcom/goldcoast/sdk/a/b;->f:Ljava/lang/String;

    .line 144
    return-void
.end method

.method public final e(Ljava/lang/String;)V
    .locals 0

    .prologue
    .line 151
    iput-object p1, p0, Lcom/goldcoast/sdk/a/b;->g:Ljava/lang/String;

    .line 152
    return-void
.end method

.method public final f(Ljava/lang/String;)V
    .locals 0

    .prologue
    .line 167
    iput-object p1, p0, Lcom/goldcoast/sdk/a/b;->i:Ljava/lang/String;

    .line 168
    return-void
.end method

.method public final g(Ljava/lang/String;)V
    .locals 0

    .prologue
    .line 175
    iput-object p1, p0, Lcom/goldcoast/sdk/a/b;->j:Ljava/lang/String;

    .line 176
    return-void
.end method
