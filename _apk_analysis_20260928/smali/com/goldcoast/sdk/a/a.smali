.class public final Lcom/goldcoast/sdk/a/a;
.super Lcom/goldcoast/sdk/a/c;
.source "SourceFile"


# annotations
.annotation system Ldalvik/annotation/Signature;
    value = {
        "Lcom/goldcoast/sdk/a/c",
        "<",
        "Lcom/goldcoast/sdk/a/a;",
        ">;"
    }
.end annotation


# instance fields
.field private a:Ljava/lang/String;

.field private b:Ljava/lang/String;

.field private c:Ljava/lang/String;

.field private d:Ljava/lang/String;

.field private e:Ljava/lang/String;

.field private f:Ljava/lang/String;

.field private g:Ljava/lang/String;

.field private h:Ljava/lang/String;

.field private i:Ljava/lang/String;

.field private j:Ljava/lang/String;

.field private k:Ljava/lang/String;


# direct methods
.method public constructor <init>()V
    .locals 1

    .prologue
    .line 38
    invoke-direct {p0}, Lcom/goldcoast/sdk/a/c;-><init>()V

    .line 25
    const-string v0, "0"

    iput-object v0, p0, Lcom/goldcoast/sdk/a/a;->a:Ljava/lang/String;

    .line 39
    return-void
.end method

.method public constructor <init>(Ljava/util/Map;)V
    .locals 1

    .prologue
    .line 47
    invoke-direct {p0}, Lcom/goldcoast/sdk/a/c;-><init>()V

    .line 25
    const-string v0, "0"

    iput-object v0, p0, Lcom/goldcoast/sdk/a/a;->a:Ljava/lang/String;

    .line 48
    invoke-direct {p0, p1}, Lcom/goldcoast/sdk/a/a;->a(Ljava/util/Map;)Lcom/goldcoast/sdk/a/a;

    .line 49
    return-void
.end method

.method private a(Ljava/util/Map;)Lcom/goldcoast/sdk/a/a;
    .locals 4
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "(",
            "Ljava/util/Map",
            "<",
            "Ljava/lang/String;",
            "Ljava/lang/String;",
            ">;)",
            "Lcom/goldcoast/sdk/a/a;"
        }
    .end annotation

    .prologue
    .line 52
    invoke-interface {p1}, Ljava/util/Map;->keySet()Ljava/util/Set;

    move-result-object v0

    invoke-interface {v0}, Ljava/util/Set;->iterator()Ljava/util/Iterator;

    move-result-object v1

    .line 53
    if-eqz v1, :cond_c

    invoke-interface {v1}, Ljava/util/Iterator;->hasNext()Z

    move-result v0

    if-eqz v0, :cond_c

    .line 54
    :cond_0
    :goto_0
    invoke-interface {v1}, Ljava/util/Iterator;->hasNext()Z

    move-result v0

    if-eqz v0, :cond_b

    .line 55
    invoke-interface {v1}, Ljava/util/Iterator;->next()Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Ljava/lang/String;

    .line 56
    const-string v2, " "

    const-string v3, ""

    invoke-virtual {v0, v2, v3}, Ljava/lang/String;->replace(Ljava/lang/CharSequence;Ljava/lang/CharSequence;)Ljava/lang/String;

    move-result-object v2

    invoke-virtual {v2}, Ljava/lang/String;->toLowerCase()Ljava/lang/String;

    move-result-object v2

    const-string v3, "processorcnt"

    invoke-virtual {v2, v3}, Ljava/lang/String;->contains(Ljava/lang/CharSequence;)Z

    move-result v2

    if-eqz v2, :cond_1

    .line 57
    invoke-interface {p1, v0}, Ljava/util/Map;->get(Ljava/lang/Object;)Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Ljava/lang/String;

    iput-object v0, p0, Lcom/goldcoast/sdk/a/a;->a:Ljava/lang/String;

    goto :goto_0

    .line 58
    :cond_1
    const-string v2, " "

    const-string v3, ""

    invoke-virtual {v0, v2, v3}, Ljava/lang/String;->replace(Ljava/lang/CharSequence;Ljava/lang/CharSequence;)Ljava/lang/String;

    move-result-object v2

    invoke-virtual {v2}, Ljava/lang/String;->toLowerCase()Ljava/lang/String;

    move-result-object v2

    const-string v3, "modelname"

    invoke-virtual {v2, v3}, Ljava/lang/String;->contains(Ljava/lang/CharSequence;)Z

    move-result v2

    if-eqz v2, :cond_2

    .line 59
    invoke-interface {p1, v0}, Ljava/util/Map;->get(Ljava/lang/Object;)Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Ljava/lang/String;

    iput-object v0, p0, Lcom/goldcoast/sdk/a/a;->b:Ljava/lang/String;

    goto :goto_0

    .line 60
    :cond_2
    const-string v2, " "

    const-string v3, ""

    invoke-virtual {v0, v2, v3}, Ljava/lang/String;->replace(Ljava/lang/CharSequence;Ljava/lang/CharSequence;)Ljava/lang/String;

    move-result-object v2

    invoke-virtual {v2}, Ljava/lang/String;->toLowerCase()Ljava/lang/String;

    move-result-object v2

    const-string v3, "features"

    invoke-virtual {v2, v3}, Ljava/lang/String;->contains(Ljava/lang/CharSequence;)Z

    move-result v2

    if-eqz v2, :cond_3

    .line 61
    invoke-interface {p1, v0}, Ljava/util/Map;->get(Ljava/lang/Object;)Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Ljava/lang/String;

    iput-object v0, p0, Lcom/goldcoast/sdk/a/a;->c:Ljava/lang/String;

    goto :goto_0

    .line 62
    :cond_3
    const-string v2, " "

    const-string v3, ""

    invoke-virtual {v0, v2, v3}, Ljava/lang/String;->replace(Ljava/lang/CharSequence;Ljava/lang/CharSequence;)Ljava/lang/String;

    move-result-object v2

    invoke-virtual {v2}, Ljava/lang/String;->toLowerCase()Ljava/lang/String;

    move-result-object v2

    const-string v3, "cpuimplementer"

    invoke-virtual {v2, v3}, Ljava/lang/String;->contains(Ljava/lang/CharSequence;)Z

    move-result v2

    if-eqz v2, :cond_4

    .line 63
    invoke-interface {p1, v0}, Ljava/util/Map;->get(Ljava/lang/Object;)Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Ljava/lang/String;

    iput-object v0, p0, Lcom/goldcoast/sdk/a/a;->d:Ljava/lang/String;

    goto :goto_0

    .line 64
    :cond_4
    const-string v2, " "

    const-string v3, ""

    invoke-virtual {v0, v2, v3}, Ljava/lang/String;->replace(Ljava/lang/CharSequence;Ljava/lang/CharSequence;)Ljava/lang/String;

    move-result-object v2

    invoke-virtual {v2}, Ljava/lang/String;->toLowerCase()Ljava/lang/String;

    move-result-object v2

    const-string v3, "cpuarchitecture"

    invoke-virtual {v2, v3}, Ljava/lang/String;->contains(Ljava/lang/CharSequence;)Z

    move-result v2

    if-eqz v2, :cond_5

    .line 65
    invoke-interface {p1, v0}, Ljava/util/Map;->get(Ljava/lang/Object;)Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Ljava/lang/String;

    iput-object v0, p0, Lcom/goldcoast/sdk/a/a;->e:Ljava/lang/String;

    goto/16 :goto_0

    .line 66
    :cond_5
    const-string v2, " "

    const-string v3, ""

    invoke-virtual {v0, v2, v3}, Ljava/lang/String;->replace(Ljava/lang/CharSequence;Ljava/lang/CharSequence;)Ljava/lang/String;

    move-result-object v2

    invoke-virtual {v2}, Ljava/lang/String;->toLowerCase()Ljava/lang/String;

    move-result-object v2

    const-string v3, "cpuvariant"

    invoke-virtual {v2, v3}, Ljava/lang/String;->contains(Ljava/lang/CharSequence;)Z

    move-result v2

    if-eqz v2, :cond_6

    .line 67
    invoke-interface {p1, v0}, Ljava/util/Map;->get(Ljava/lang/Object;)Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Ljava/lang/String;

    iput-object v0, p0, Lcom/goldcoast/sdk/a/a;->f:Ljava/lang/String;

    goto/16 :goto_0

    .line 68
    :cond_6
    const-string v2, " "

    const-string v3, ""

    invoke-virtual {v0, v2, v3}, Ljava/lang/String;->replace(Ljava/lang/CharSequence;Ljava/lang/CharSequence;)Ljava/lang/String;

    move-result-object v2

    invoke-virtual {v2}, Ljava/lang/String;->toLowerCase()Ljava/lang/String;

    move-result-object v2

    const-string v3, "cpupart"

    invoke-virtual {v2, v3}, Ljava/lang/String;->contains(Ljava/lang/CharSequence;)Z

    move-result v2

    if-eqz v2, :cond_7

    .line 69
    invoke-interface {p1, v0}, Ljava/util/Map;->get(Ljava/lang/Object;)Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Ljava/lang/String;

    iput-object v0, p0, Lcom/goldcoast/sdk/a/a;->g:Ljava/lang/String;

    goto/16 :goto_0

    .line 70
    :cond_7
    const-string v2, " "

    const-string v3, ""

    invoke-virtual {v0, v2, v3}, Ljava/lang/String;->replace(Ljava/lang/CharSequence;Ljava/lang/CharSequence;)Ljava/lang/String;

    move-result-object v2

    invoke-virtual {v2}, Ljava/lang/String;->toLowerCase()Ljava/lang/String;

    move-result-object v2

    const-string v3, "cpurevision"

    invoke-virtual {v2, v3}, Ljava/lang/String;->contains(Ljava/lang/CharSequence;)Z

    move-result v2

    if-eqz v2, :cond_8

    .line 71
    invoke-interface {p1, v0}, Ljava/util/Map;->get(Ljava/lang/Object;)Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Ljava/lang/String;

    iput-object v0, p0, Lcom/goldcoast/sdk/a/a;->h:Ljava/lang/String;

    goto/16 :goto_0

    .line 72
    :cond_8
    const-string v2, " "

    const-string v3, ""

    invoke-virtual {v0, v2, v3}, Ljava/lang/String;->replace(Ljava/lang/CharSequence;Ljava/lang/CharSequence;)Ljava/lang/String;

    move-result-object v2

    invoke-virtual {v2}, Ljava/lang/String;->toLowerCase()Ljava/lang/String;

    move-result-object v2

    const-string v3, "hardware"

    invoke-virtual {v2, v3}, Ljava/lang/String;->contains(Ljava/lang/CharSequence;)Z

    move-result v2

    if-eqz v2, :cond_9

    .line 73
    invoke-interface {p1, v0}, Ljava/util/Map;->get(Ljava/lang/Object;)Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Ljava/lang/String;

    iput-object v0, p0, Lcom/goldcoast/sdk/a/a;->i:Ljava/lang/String;

    goto/16 :goto_0

    .line 74
    :cond_9
    const-string v2, " "

    const-string v3, ""

    invoke-virtual {v0, v2, v3}, Ljava/lang/String;->replace(Ljava/lang/CharSequence;Ljava/lang/CharSequence;)Ljava/lang/String;

    move-result-object v2

    invoke-virtual {v2}, Ljava/lang/String;->toLowerCase()Ljava/lang/String;

    move-result-object v2

    const-string v3, "revision"

    invoke-virtual {v2, v3}, Ljava/lang/String;->contains(Ljava/lang/CharSequence;)Z

    move-result v2

    if-eqz v2, :cond_a

    .line 75
    invoke-interface {p1, v0}, Ljava/util/Map;->get(Ljava/lang/Object;)Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Ljava/lang/String;

    iput-object v0, p0, Lcom/goldcoast/sdk/a/a;->j:Ljava/lang/String;

    goto/16 :goto_0

    .line 76
    :cond_a
    const-string v2, " "

    const-string v3, ""

    invoke-virtual {v0, v2, v3}, Ljava/lang/String;->replace(Ljava/lang/CharSequence;Ljava/lang/CharSequence;)Ljava/lang/String;

    move-result-object v2

    invoke-virtual {v2}, Ljava/lang/String;->toLowerCase()Ljava/lang/String;

    move-result-object v2

    const-string v3, "serial"

    invoke-virtual {v2, v3}, Ljava/lang/String;->contains(Ljava/lang/CharSequence;)Z

    move-result v2

    if-eqz v2, :cond_0

    .line 77
    invoke-interface {p1, v0}, Ljava/util/Map;->get(Ljava/lang/Object;)Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Ljava/lang/String;

    iput-object v0, p0, Lcom/goldcoast/sdk/a/a;->k:Ljava/lang/String;

    goto/16 :goto_0

    .line 81
    :cond_b
    :try_start_0
    iget-object v0, p0, Lcom/goldcoast/sdk/a/a;->a:Ljava/lang/String;

    invoke-static {v0}, Ljava/lang/Integer;->valueOf(Ljava/lang/String;)Ljava/lang/Integer;

    move-result-object v0

    invoke-virtual {v0}, Ljava/lang/Integer;->intValue()I

    move-result v0

    add-int/lit8 v0, v0, 0x1

    invoke-static {v0}, Ljava/lang/String;->valueOf(I)Ljava/lang/String;

    move-result-object v0

    iput-object v0, p0, Lcom/goldcoast/sdk/a/a;->a:Ljava/lang/String;
    :try_end_0
    .catch Ljava/lang/NumberFormatException; {:try_start_0 .. :try_end_0} :catch_0

    .line 88
    :goto_1
    return-object p0

    .line 83
    :catch_0
    move-exception v0

    invoke-virtual {v0}, Ljava/lang/NumberFormatException;->printStackTrace()V

    goto :goto_1

    .line 86
    :cond_c
    const/4 p0, 0x0

    goto :goto_1
.end method


# virtual methods
.method public final a()Lorg/json/JSONObject;
    .locals 3

    .prologue
    .line 109
    new-instance v1, Lorg/json/JSONObject;

    invoke-direct {v1}, Lorg/json/JSONObject;-><init>()V

    .line 111
    :try_start_0
    const-string v2, "processorcnt"

    iget-object v0, p0, Lcom/goldcoast/sdk/a/a;->a:Ljava/lang/String;

    if-nez v0, :cond_0

    const-string v0, ""

    :goto_0
    invoke-virtual {v1, v2, v0}, Lorg/json/JSONObject;->put(Ljava/lang/String;Ljava/lang/Object;)Lorg/json/JSONObject;

    .line 112
    const-string v2, "modelname"

    iget-object v0, p0, Lcom/goldcoast/sdk/a/a;->b:Ljava/lang/String;

    if-nez v0, :cond_1

    const-string v0, ""

    :goto_1
    invoke-virtual {v1, v2, v0}, Lorg/json/JSONObject;->put(Ljava/lang/String;Ljava/lang/Object;)Lorg/json/JSONObject;

    .line 113
    const-string v2, "features"

    iget-object v0, p0, Lcom/goldcoast/sdk/a/a;->c:Ljava/lang/String;

    if-nez v0, :cond_2

    const-string v0, ""

    :goto_2
    invoke-virtual {v1, v2, v0}, Lorg/json/JSONObject;->put(Ljava/lang/String;Ljava/lang/Object;)Lorg/json/JSONObject;

    .line 114
    const-string v2, "cpuimplementer"

    iget-object v0, p0, Lcom/goldcoast/sdk/a/a;->d:Ljava/lang/String;

    if-nez v0, :cond_3

    const-string v0, ""

    :goto_3
    invoke-virtual {v1, v2, v0}, Lorg/json/JSONObject;->put(Ljava/lang/String;Ljava/lang/Object;)Lorg/json/JSONObject;

    .line 115
    const-string v2, "cpuarchitecture"

    iget-object v0, p0, Lcom/goldcoast/sdk/a/a;->e:Ljava/lang/String;

    if-nez v0, :cond_4

    const-string v0, ""

    :goto_4
    invoke-virtual {v1, v2, v0}, Lorg/json/JSONObject;->put(Ljava/lang/String;Ljava/lang/Object;)Lorg/json/JSONObject;

    .line 116
    const-string v2, "cpuvariant"

    iget-object v0, p0, Lcom/goldcoast/sdk/a/a;->f:Ljava/lang/String;

    if-nez v0, :cond_5

    const-string v0, ""

    :goto_5
    invoke-virtual {v1, v2, v0}, Lorg/json/JSONObject;->put(Ljava/lang/String;Ljava/lang/Object;)Lorg/json/JSONObject;

    .line 117
    const-string v2, "cpupart"

    iget-object v0, p0, Lcom/goldcoast/sdk/a/a;->g:Ljava/lang/String;

    if-nez v0, :cond_6

    const-string v0, ""

    :goto_6
    invoke-virtual {v1, v2, v0}, Lorg/json/JSONObject;->put(Ljava/lang/String;Ljava/lang/Object;)Lorg/json/JSONObject;

    .line 118
    const-string v2, "cpurevision"

    iget-object v0, p0, Lcom/goldcoast/sdk/a/a;->h:Ljava/lang/String;

    if-nez v0, :cond_7

    const-string v0, ""

    :goto_7
    invoke-virtual {v1, v2, v0}, Lorg/json/JSONObject;->put(Ljava/lang/String;Ljava/lang/Object;)Lorg/json/JSONObject;

    .line 119
    const-string v2, "hardware"

    iget-object v0, p0, Lcom/goldcoast/sdk/a/a;->i:Ljava/lang/String;

    if-nez v0, :cond_8

    const-string v0, ""

    :goto_8
    invoke-virtual {v1, v2, v0}, Lorg/json/JSONObject;->put(Ljava/lang/String;Ljava/lang/Object;)Lorg/json/JSONObject;

    .line 120
    const-string v2, "revision"

    iget-object v0, p0, Lcom/goldcoast/sdk/a/a;->j:Ljava/lang/String;

    if-nez v0, :cond_9

    const-string v0, ""

    :goto_9
    invoke-virtual {v1, v2, v0}, Lorg/json/JSONObject;->put(Ljava/lang/String;Ljava/lang/Object;)Lorg/json/JSONObject;

    .line 121
    const-string v2, "serial"

    iget-object v0, p0, Lcom/goldcoast/sdk/a/a;->k:Ljava/lang/String;

    if-nez v0, :cond_a

    const-string v0, ""

    :goto_a
    invoke-virtual {v1, v2, v0}, Lorg/json/JSONObject;->put(Ljava/lang/String;Ljava/lang/Object;)Lorg/json/JSONObject;

    .line 125
    :goto_b
    return-object v1

    .line 111
    :cond_0
    iget-object v0, p0, Lcom/goldcoast/sdk/a/a;->a:Ljava/lang/String;

    goto :goto_0

    .line 112
    :cond_1
    iget-object v0, p0, Lcom/goldcoast/sdk/a/a;->b:Ljava/lang/String;

    goto :goto_1

    .line 113
    :cond_2
    iget-object v0, p0, Lcom/goldcoast/sdk/a/a;->c:Ljava/lang/String;

    goto :goto_2

    .line 114
    :cond_3
    iget-object v0, p0, Lcom/goldcoast/sdk/a/a;->d:Ljava/lang/String;

    goto :goto_3

    .line 115
    :cond_4
    iget-object v0, p0, Lcom/goldcoast/sdk/a/a;->e:Ljava/lang/String;

    goto :goto_4

    .line 116
    :cond_5
    iget-object v0, p0, Lcom/goldcoast/sdk/a/a;->f:Ljava/lang/String;

    goto :goto_5

    .line 117
    :cond_6
    iget-object v0, p0, Lcom/goldcoast/sdk/a/a;->g:Ljava/lang/String;

    goto :goto_6

    .line 118
    :cond_7
    iget-object v0, p0, Lcom/goldcoast/sdk/a/a;->h:Ljava/lang/String;

    goto :goto_7

    .line 119
    :cond_8
    iget-object v0, p0, Lcom/goldcoast/sdk/a/a;->i:Ljava/lang/String;

    goto :goto_8

    .line 120
    :cond_9
    iget-object v0, p0, Lcom/goldcoast/sdk/a/a;->j:Ljava/lang/String;

    goto :goto_9

    .line 121
    :cond_a
    iget-object v0, p0, Lcom/goldcoast/sdk/a/a;->k:Ljava/lang/String;
    :try_end_0
    .catch Lorg/json/JSONException; {:try_start_0 .. :try_end_0} :catch_0

    goto :goto_a

    .line 123
    :catch_0
    move-exception v0

    invoke-virtual {v0}, Lorg/json/JSONException;->printStackTrace()V

    goto :goto_b
.end method
