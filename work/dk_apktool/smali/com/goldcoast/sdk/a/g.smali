.class public final Lcom/goldcoast/sdk/a/g;
.super Lcom/goldcoast/sdk/a/c;
.source "SourceFile"


# annotations
.annotation system Ldalvik/annotation/Signature;
    value = {
        "Lcom/goldcoast/sdk/a/c",
        "<",
        "Lcom/goldcoast/sdk/a/g;",
        ">;"
    }
.end annotation


# instance fields
.field private a:Ljava/lang/String;

.field private b:I

.field private c:Ljava/lang/String;

.field private d:J

.field private e:Ljava/lang/String;

.field private f:Ljava/lang/String;

.field private g:Ljava/lang/String;

.field private h:Ljava/lang/String;

.field private i:Ljava/lang/String;

.field private j:Ljava/lang/String;

.field private k:I

.field private l:Lcom/goldcoast/sdk/a/f;

.field private m:Ljava/lang/String;

.field private n:Ljava/lang/String;

.field private o:Ljava/lang/String;


# direct methods
.method public constructor <init>()V
    .locals 0

    .prologue
    .line 26
    invoke-direct {p0}, Lcom/goldcoast/sdk/a/c;-><init>()V

    .line 27
    return-void
.end method


# virtual methods
.method public final a()Lorg/json/JSONObject;
    .locals 4

    .prologue
    .line 51
    .line 1165
    iget-object v0, p0, Lcom/goldcoast/sdk/a/g;->l:Lcom/goldcoast/sdk/a/f;

    .line 51
    if-eqz v0, :cond_0

    .line 2165
    iget-object v0, p0, Lcom/goldcoast/sdk/a/g;->l:Lcom/goldcoast/sdk/a/f;

    .line 52
    invoke-virtual {v0}, Lcom/goldcoast/sdk/a/f;->b()Lorg/json/JSONObject;

    move-result-object v0

    .line 57
    :goto_0
    :try_start_0
    const-string v1, "rf_md5"

    iget-object v2, p0, Lcom/goldcoast/sdk/a/g;->a:Ljava/lang/String;

    invoke-virtual {v0, v1, v2}, Lorg/json/JSONObject;->put(Ljava/lang/String;Ljava/lang/Object;)Lorg/json/JSONObject;

    .line 58
    const-string v1, "status"

    iget v2, p0, Lcom/goldcoast/sdk/a/g;->b:I

    invoke-virtual {v0, v1, v2}, Lorg/json/JSONObject;->put(Ljava/lang/String;I)Lorg/json/JSONObject;

    .line 59
    const-string v1, "msg"

    iget-object v2, p0, Lcom/goldcoast/sdk/a/g;->c:Ljava/lang/String;

    invoke-virtual {v0, v1, v2}, Lorg/json/JSONObject;->put(Ljava/lang/String;Ljava/lang/Object;)Lorg/json/JSONObject;

    .line 60
    const-string v1, "runTime"

    iget-wide v2, p0, Lcom/goldcoast/sdk/a/g;->d:J

    invoke-virtual {v0, v1, v2, v3}, Lorg/json/JSONObject;->put(Ljava/lang/String;J)Lorg/json/JSONObject;

    .line 61
    const-string v1, "androidId"

    iget-object v2, p0, Lcom/goldcoast/sdk/a/g;->e:Ljava/lang/String;

    invoke-virtual {v0, v1, v2}, Lorg/json/JSONObject;->put(Ljava/lang/String;Ljava/lang/Object;)Lorg/json/JSONObject;

    .line 62
    const-string v1, "netOperator"

    iget-object v2, p0, Lcom/goldcoast/sdk/a/g;->f:Ljava/lang/String;

    invoke-virtual {v0, v1, v2}, Lorg/json/JSONObject;->put(Ljava/lang/String;Ljava/lang/Object;)Lorg/json/JSONObject;

    .line 63
    const-string v1, "simOperatorName"

    iget-object v2, p0, Lcom/goldcoast/sdk/a/g;->g:Ljava/lang/String;

    invoke-virtual {v0, v1, v2}, Lorg/json/JSONObject;->put(Ljava/lang/String;Ljava/lang/Object;)Lorg/json/JSONObject;

    .line 64
    const-string v1, "displayLanguage"

    iget-object v2, p0, Lcom/goldcoast/sdk/a/g;->h:Ljava/lang/String;

    invoke-virtual {v0, v1, v2}, Lorg/json/JSONObject;->put(Ljava/lang/String;Ljava/lang/Object;)Lorg/json/JSONObject;

    .line 65
    const-string v1, "displayCountry"

    iget-object v2, p0, Lcom/goldcoast/sdk/a/g;->i:Ljava/lang/String;

    invoke-virtual {v0, v1, v2}, Lorg/json/JSONObject;->put(Ljava/lang/String;Ljava/lang/Object;)Lorg/json/JSONObject;

    .line 66
    const-string v1, "token"

    iget-object v2, p0, Lcom/goldcoast/sdk/a/g;->j:Ljava/lang/String;

    invoke-virtual {v0, v1, v2}, Lorg/json/JSONObject;->put(Ljava/lang/String;Ljava/lang/Object;)Lorg/json/JSONObject;

    .line 67
    const-string v1, "category"

    iget v2, p0, Lcom/goldcoast/sdk/a/g;->k:I

    invoke-virtual {v0, v1, v2}, Lorg/json/JSONObject;->put(Ljava/lang/String;I)Lorg/json/JSONObject;

    .line 68
    const-string v1, "sdkV"

    iget-object v2, p0, Lcom/goldcoast/sdk/a/g;->m:Ljava/lang/String;

    invoke-virtual {v0, v1, v2}, Lorg/json/JSONObject;->put(Ljava/lang/String;Ljava/lang/Object;)Lorg/json/JSONObject;

    .line 69
    const-string v1, "package_name"

    iget-object v2, p0, Lcom/goldcoast/sdk/a/g;->n:Ljava/lang/String;

    invoke-virtual {v0, v1, v2}, Lorg/json/JSONObject;->put(Ljava/lang/String;Ljava/lang/Object;)Lorg/json/JSONObject;

    .line 70
    const-string v1, "signature"

    iget-object v2, p0, Lcom/goldcoast/sdk/a/g;->o:Ljava/lang/String;

    invoke-virtual {v0, v1, v2}, Lorg/json/JSONObject;->put(Ljava/lang/String;Ljava/lang/Object;)Lorg/json/JSONObject;
    :try_end_0
    .catch Lorg/json/JSONException; {:try_start_0 .. :try_end_0} :catch_0

    .line 73
    :goto_1
    return-object v0

    .line 54
    :cond_0
    new-instance v0, Lorg/json/JSONObject;

    invoke-direct {v0}, Lorg/json/JSONObject;-><init>()V

    goto :goto_0

    :catch_0
    move-exception v1

    goto :goto_1
.end method

.method public final a(I)V
    .locals 0

    .prologue
    .line 89
    iput p1, p0, Lcom/goldcoast/sdk/a/g;->b:I

    .line 90
    return-void
.end method

.method public final a(J)V
    .locals 1

    .prologue
    .line 105
    iput-wide p1, p0, Lcom/goldcoast/sdk/a/g;->d:J

    .line 106
    return-void
.end method

.method public final a(Lcom/goldcoast/sdk/a/f;)V
    .locals 0

    .prologue
    .line 169
    iput-object p1, p0, Lcom/goldcoast/sdk/a/g;->l:Lcom/goldcoast/sdk/a/f;

    .line 170
    return-void
.end method

.method public final a(Ljava/lang/String;)V
    .locals 0

    .prologue
    .line 81
    iput-object p1, p0, Lcom/goldcoast/sdk/a/g;->a:Ljava/lang/String;

    .line 82
    return-void
.end method

.method public final b(I)V
    .locals 0

    .prologue
    .line 161
    iput p1, p0, Lcom/goldcoast/sdk/a/g;->k:I

    .line 162
    return-void
.end method

.method public final b(Ljava/lang/String;)V
    .locals 0

    .prologue
    .line 97
    iput-object p1, p0, Lcom/goldcoast/sdk/a/g;->c:Ljava/lang/String;

    .line 98
    return-void
.end method

.method public final c(Ljava/lang/String;)V
    .locals 0

    .prologue
    .line 113
    iput-object p1, p0, Lcom/goldcoast/sdk/a/g;->e:Ljava/lang/String;

    .line 114
    return-void
.end method

.method public final d(Ljava/lang/String;)V
    .locals 0

    .prologue
    .line 121
    iput-object p1, p0, Lcom/goldcoast/sdk/a/g;->f:Ljava/lang/String;

    .line 122
    return-void
.end method

.method public final e(Ljava/lang/String;)V
    .locals 0

    .prologue
    .line 129
    iput-object p1, p0, Lcom/goldcoast/sdk/a/g;->g:Ljava/lang/String;

    .line 130
    return-void
.end method

.method public final f(Ljava/lang/String;)V
    .locals 0

    .prologue
    .line 137
    iput-object p1, p0, Lcom/goldcoast/sdk/a/g;->h:Ljava/lang/String;

    .line 138
    return-void
.end method

.method public final g(Ljava/lang/String;)V
    .locals 0

    .prologue
    .line 145
    iput-object p1, p0, Lcom/goldcoast/sdk/a/g;->i:Ljava/lang/String;

    .line 146
    return-void
.end method

.method public final h(Ljava/lang/String;)V
    .locals 0

    .prologue
    .line 153
    iput-object p1, p0, Lcom/goldcoast/sdk/a/g;->j:Ljava/lang/String;

    .line 154
    return-void
.end method

.method public final i(Ljava/lang/String;)V
    .locals 0

    .prologue
    .line 177
    iput-object p1, p0, Lcom/goldcoast/sdk/a/g;->m:Ljava/lang/String;

    .line 178
    return-void
.end method

.method public final j(Ljava/lang/String;)V
    .locals 0

    .prologue
    .line 185
    iput-object p1, p0, Lcom/goldcoast/sdk/a/g;->n:Ljava/lang/String;

    .line 186
    return-void
.end method

.method public final k(Ljava/lang/String;)V
    .locals 0

    .prologue
    .line 193
    iput-object p1, p0, Lcom/goldcoast/sdk/a/g;->o:Ljava/lang/String;

    .line 194
    return-void
.end method
