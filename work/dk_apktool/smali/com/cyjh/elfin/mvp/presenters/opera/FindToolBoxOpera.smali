.class public Lcom/cyjh/elfin/mvp/presenters/opera/FindToolBoxOpera;
.super Ljava/lang/Object;
.source "FindToolBoxOpera.java"

# interfaces
.implements Lcom/cyjh/elfin/mvp/presenters/opera/ViewOpera;


# direct methods
.method public constructor <init>()V
    .locals 0

    .prologue
    .line 13
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method


# virtual methods
.method public loadData(ILcom/cyjh/elfin/net/volley/ActivityHttpHelper;Landroid/content/Context;)V
    .locals 4
    .param p1, "currentPage"    # I
    .param p2, "mA"    # Lcom/cyjh/elfin/net/volley/ActivityHttpHelper;
    .param p3, "context"    # Landroid/content/Context;

    .prologue
    .line 17
    :try_start_0
    const-string v1, "api.51moba.com"

    const-string v2, "GetElfAbnormalGameList"

    invoke-static {v1, v2}, Lcom/cyjh/elfin/constant/MyBuildConfig;->getBuilder(Ljava/lang/String;Ljava/lang/String;)Landroid/net/Uri$Builder;

    move-result-object v1

    const-string v2, "pageindex"

    .line 18
    invoke-static {p1}, Ljava/lang/String;->valueOf(I)Ljava/lang/String;

    move-result-object v3

    invoke-virtual {v1, v2, v3}, Landroid/net/Uri$Builder;->appendQueryParameter(Ljava/lang/String;Ljava/lang/String;)Landroid/net/Uri$Builder;

    move-result-object v1

    .line 19
    invoke-virtual {v1}, Landroid/net/Uri$Builder;->build()Landroid/net/Uri;

    move-result-object v1

    invoke-virtual {v1}, Landroid/net/Uri;->toString()Ljava/lang/String;

    move-result-object v0

    .line 21
    .local v0, "url":Ljava/lang/String;
    invoke-virtual {p2, p3, v0}, Lcom/cyjh/elfin/net/volley/ActivityHttpHelper;->sendGetRequest(Landroid/content/Context;Ljava/lang/String;)V
    :try_end_0
    .catch Ljava/lang/Exception; {:try_start_0 .. :try_end_0} :catch_0

    .line 25
    .end local v0    # "url":Ljava/lang/String;
    :goto_0
    return-void

    .line 22
    :catch_0
    move-exception v1

    goto :goto_0
.end method

.method public loadData(Ljava/lang/String;Lcom/cyjh/elfin/net/volley/ActivityHttpHelper;Landroid/content/Context;)V
    .locals 3
    .param p1, "id"    # Ljava/lang/String;
    .param p2, "mA"    # Lcom/cyjh/elfin/net/volley/ActivityHttpHelper;
    .param p3, "context"    # Landroid/content/Context;

    .prologue
    .line 30
    :try_start_0
    const-string v1, "api.51moba.com"

    const-string v2, "GetElfAbnormalGameInfo"

    invoke-static {v1, v2}, Lcom/cyjh/elfin/constant/MyBuildConfig;->getBuilder(Ljava/lang/String;Ljava/lang/String;)Landroid/net/Uri$Builder;

    move-result-object v1

    const-string v2, "id"

    .line 31
    invoke-virtual {v1, v2, p1}, Landroid/net/Uri$Builder;->appendQueryParameter(Ljava/lang/String;Ljava/lang/String;)Landroid/net/Uri$Builder;

    move-result-object v1

    .line 32
    invoke-virtual {v1}, Landroid/net/Uri$Builder;->build()Landroid/net/Uri;

    move-result-object v1

    invoke-virtual {v1}, Landroid/net/Uri;->toString()Ljava/lang/String;

    move-result-object v0

    .line 34
    .local v0, "url":Ljava/lang/String;
    invoke-virtual {p2, p3, v0}, Lcom/cyjh/elfin/net/volley/ActivityHttpHelper;->sendGetRequest(Landroid/content/Context;Ljava/lang/String;)V
    :try_end_0
    .catch Ljava/lang/Exception; {:try_start_0 .. :try_end_0} :catch_0

    .line 38
    .end local v0    # "url":Ljava/lang/String;
    :goto_0
    return-void

    .line 35
    :catch_0
    move-exception v1

    goto :goto_0
.end method
