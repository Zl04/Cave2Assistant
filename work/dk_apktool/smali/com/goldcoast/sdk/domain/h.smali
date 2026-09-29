.class final Lcom/goldcoast/sdk/domain/h;
.super Ljava/lang/Object;
.source "SourceFile"

# interfaces
.implements Lcom/b/a/h;


# instance fields
.field final synthetic a:I

.field final synthetic b:Ljava/lang/String;

.field final synthetic c:Landroid/os/ConditionVariable;

.field final synthetic d:I

.field final synthetic e:Lcom/goldcoast/sdk/domain/EntryPoint;


# direct methods
.method constructor <init>(Lcom/goldcoast/sdk/domain/EntryPoint;ILjava/lang/String;Landroid/os/ConditionVariable;I)V
    .locals 0

    .prologue
    .line 990
    iput-object p1, p0, Lcom/goldcoast/sdk/domain/h;->e:Lcom/goldcoast/sdk/domain/EntryPoint;

    iput p2, p0, Lcom/goldcoast/sdk/domain/h;->a:I

    iput-object p3, p0, Lcom/goldcoast/sdk/domain/h;->b:Ljava/lang/String;

    iput-object p4, p0, Lcom/goldcoast/sdk/domain/h;->c:Landroid/os/ConditionVariable;

    iput p5, p0, Lcom/goldcoast/sdk/domain/h;->d:I

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method


# virtual methods
.method public final a(Lcom/b/a/as;)V
    .locals 7

    .prologue
    const/4 v6, 0x1

    .line 993
    invoke-virtual {p1}, Lcom/b/a/as;->e()Lcom/b/a/au;

    move-result-object v0

    invoke-virtual {v0}, Lcom/b/a/au;->d()Ljava/lang/String;

    move-result-object v1

    .line 995
    new-instance v2, Ljava/util/HashMap;

    invoke-direct {v2}, Ljava/util/HashMap;-><init>()V

    .line 999
    new-instance v0, Ljava/lang/StringBuilder;

    invoke-direct {v0}, Ljava/lang/StringBuilder;-><init>()V

    .line 1000
    const-string v3, "######\n"

    invoke-virtual {v0, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    .line 1001
    const-string v3, "<feedBackP.Enc>:%s\n"

    new-array v4, v6, [Ljava/lang/Object;

    const/4 v5, 0x0

    aput-object v1, v4, v5

    invoke-static {v3, v4}, Ljava/lang/String;->format(Ljava/lang/String;[Ljava/lang/Object;)Ljava/lang/String;

    move-result-object v3

    invoke-virtual {v0, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    .line 1002
    invoke-static {}, Lcom/goldcoast/sdk/c/g;->a()Lcom/goldcoast/sdk/c/g;

    invoke-virtual {v0}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v0

    invoke-static {v0}, Lcom/goldcoast/sdk/c/g;->b(Ljava/lang/String;)V

    .line 1003
    invoke-static {v1}, Landroid/text/TextUtils;->isEmpty(Ljava/lang/CharSequence;)Z

    move-result v0

    if-eqz v0, :cond_0

    iget v0, p0, Lcom/goldcoast/sdk/domain/h;->a:I

    if-ne v0, v6, :cond_0

    .line 1004
    const-string v0, "message"

    const-string v1, "response is null"

    invoke-interface {v2, v0, v1}, Ljava/util/Map;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    .line 1008
    iget-object v0, p0, Lcom/goldcoast/sdk/domain/h;->b:Ljava/lang/String;

    invoke-static {v0}, Lcom/goldcoast/sdk/domain/EntryPoint;->a(Ljava/lang/String;)V

    .line 1009
    iget-object v0, p0, Lcom/goldcoast/sdk/domain/h;->c:Landroid/os/ConditionVariable;

    invoke-virtual {v0}, Landroid/os/ConditionVariable;->open()V

    .line 1056
    :goto_0
    return-void

    .line 1012
    :cond_0
    const/4 v0, 0x0

    .line 1014
    :try_start_0
    new-instance v3, Lorg/json/JSONObject;

    invoke-direct {v3, v1}, Lorg/json/JSONObject;-><init>(Ljava/lang/String;)V

    const-string v1, "body"

    const-string v4, ""

    invoke-virtual {v3, v1, v4}, Lorg/json/JSONObject;->optString(Ljava/lang/String;Ljava/lang/String;)Ljava/lang/String;

    move-result-object v1

    invoke-static {v1}, Lcom/goldcoast/sdk/c/a;->b(Ljava/lang/String;)Ljava/lang/String;
    :try_end_0
    .catch Lorg/json/JSONException; {:try_start_0 .. :try_end_0} :catch_0

    move-result-object v0

    .line 1028
    :goto_1
    invoke-static {v0}, Landroid/text/TextUtils;->isEmpty(Ljava/lang/CharSequence;)Z

    move-result v1

    if-eqz v1, :cond_1

    invoke-virtual {p1}, Lcom/b/a/as;->b()I

    move-result v1

    const/16 v3, 0xc8

    if-eq v1, v3, :cond_1

    iget v1, p0, Lcom/goldcoast/sdk/domain/h;->a:I

    if-ne v1, v6, :cond_1

    .line 1029
    iget-object v0, p0, Lcom/goldcoast/sdk/domain/h;->b:Ljava/lang/String;

    invoke-static {v0}, Lcom/goldcoast/sdk/domain/EntryPoint;->a(Ljava/lang/String;)V

    .line 1030
    iget-object v0, p0, Lcom/goldcoast/sdk/domain/h;->c:Landroid/os/ConditionVariable;

    invoke-virtual {v0}, Landroid/os/ConditionVariable;->open()V

    goto :goto_0

    .line 1022
    :catch_0
    move-exception v1

    .line 1023
    const-string v3, "message"

    iget-object v4, p0, Lcom/goldcoast/sdk/domain/h;->e:Lcom/goldcoast/sdk/domain/EntryPoint;

    invoke-virtual {v4, v1}, Lcom/goldcoast/sdk/domain/EntryPoint;->getStackString(Ljava/lang/Throwable;)Ljava/lang/String;

    move-result-object v1

    invoke-interface {v2, v3, v1}, Ljava/util/Map;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    goto :goto_1

    .line 1034
    :cond_1
    :try_start_1
    new-instance v1, Lorg/json/JSONObject;

    invoke-direct {v1, v0}, Lorg/json/JSONObject;-><init>(Ljava/lang/String;)V

    .line 1035
    const-string v0, "code"

    const-string v3, ""

    invoke-virtual {v1, v0, v3}, Lorg/json/JSONObject;->optString(Ljava/lang/String;Ljava/lang/String;)Ljava/lang/String;

    move-result-object v0

    const-string v1, "200"

    invoke-virtual {v0, v1}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v0

    if-eqz v0, :cond_3

    .line 1036
    iget v0, p0, Lcom/goldcoast/sdk/domain/h;->a:I

    const/4 v1, 0x2

    if-ne v0, v1, :cond_2

    .line 1037
    iget v0, p0, Lcom/goldcoast/sdk/domain/h;->d:I

    invoke-static {v0}, Lcom/goldcoast/sdk/domain/EntryPoint;->a(I)V
    :try_end_1
    .catch Ljava/lang/Exception; {:try_start_1 .. :try_end_1} :catch_1

    .line 1055
    :cond_2
    :goto_2
    iget-object v0, p0, Lcom/goldcoast/sdk/domain/h;->c:Landroid/os/ConditionVariable;

    invoke-virtual {v0}, Landroid/os/ConditionVariable;->open()V

    goto :goto_0

    .line 1040
    :cond_3
    :try_start_2
    iget v0, p0, Lcom/goldcoast/sdk/domain/h;->a:I

    if-ne v0, v6, :cond_2

    .line 1041
    iget-object v0, p0, Lcom/goldcoast/sdk/domain/h;->b:Ljava/lang/String;

    invoke-static {v0}, Lcom/goldcoast/sdk/domain/EntryPoint;->a(Ljava/lang/String;)V

    .line 1042
    const-string v0, "message"

    const-string v1, "code not equals 200"

    invoke-interface {v2, v0, v1}, Ljava/util/Map;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;
    :try_end_2
    .catch Ljava/lang/Exception; {:try_start_2 .. :try_end_2} :catch_1

    goto :goto_2

    .line 1048
    :catch_1
    move-exception v0

    .line 1049
    const-string v1, "stack"

    iget-object v3, p0, Lcom/goldcoast/sdk/domain/h;->e:Lcom/goldcoast/sdk/domain/EntryPoint;

    invoke-virtual {v3, v0}, Lcom/goldcoast/sdk/domain/EntryPoint;->getStackString(Ljava/lang/Throwable;)Ljava/lang/String;

    move-result-object v0

    invoke-interface {v2, v1, v0}, Ljava/util/Map;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    goto :goto_2
.end method

.method public final a(Ljava/io/IOException;)V
    .locals 3

    .prologue
    .line 1062
    new-instance v0, Ljava/util/HashMap;

    invoke-direct {v0}, Ljava/util/HashMap;-><init>()V

    .line 1066
    iget v0, p0, Lcom/goldcoast/sdk/domain/h;->a:I

    const/4 v1, 0x1

    if-ne v0, v1, :cond_0

    .line 1067
    iget-object v0, p0, Lcom/goldcoast/sdk/domain/h;->b:Ljava/lang/String;

    invoke-static {v0}, Lcom/goldcoast/sdk/domain/EntryPoint;->a(Ljava/lang/String;)V

    .line 1069
    :cond_0
    iget-object v0, p0, Lcom/goldcoast/sdk/domain/h;->e:Lcom/goldcoast/sdk/domain/EntryPoint;

    iget-object v1, p0, Lcom/goldcoast/sdk/domain/h;->e:Lcom/goldcoast/sdk/domain/EntryPoint;

    invoke-virtual {v1, p1}, Lcom/goldcoast/sdk/domain/EntryPoint;->getStackString(Ljava/lang/Throwable;)Ljava/lang/String;

    move-result-object v1

    const/4 v2, 0x3

    invoke-static {v0, v1, v2}, Lcom/goldcoast/sdk/domain/EntryPoint;->a(Lcom/goldcoast/sdk/domain/EntryPoint;Ljava/lang/String;I)V

    .line 1070
    iget-object v0, p0, Lcom/goldcoast/sdk/domain/h;->c:Landroid/os/ConditionVariable;

    invoke-virtual {v0}, Landroid/os/ConditionVariable;->open()V

    .line 1071
    return-void
.end method
