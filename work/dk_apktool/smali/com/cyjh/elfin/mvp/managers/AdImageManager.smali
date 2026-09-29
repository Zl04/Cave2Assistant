.class public Lcom/cyjh/elfin/mvp/managers/AdImageManager;
.super Ljava/lang/Object;
.source "AdImageManager.java"

# interfaces
.implements Lcom/cyjh/elfin/mvp/managers/BaseManager;


# direct methods
.method public constructor <init>()V
    .locals 0

    .prologue
    .line 20
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method


# virtual methods
.method public adClicker(Ljava/lang/String;Ljava/lang/String;Landroid/content/Context;)V
    .locals 3
    .param p1, "id"    # Ljava/lang/String;
    .param p2, "tag"    # Ljava/lang/String;
    .param p3, "context"    # Landroid/content/Context;

    .prologue
    .line 61
    const-string v1, "api.51moba.com"

    const-string v2, "ApkAdvertisementOpen"

    invoke-static {v1, v2}, Lcom/cyjh/elfin/constant/MyBuildConfig;->getBuilder(Ljava/lang/String;Ljava/lang/String;)Landroid/net/Uri$Builder;

    move-result-object v1

    const-string v2, "Id"

    .line 63
    invoke-virtual {v1, v2, p1}, Landroid/net/Uri$Builder;->appendQueryParameter(Ljava/lang/String;Ljava/lang/String;)Landroid/net/Uri$Builder;

    move-result-object v1

    .line 64
    invoke-virtual {v1}, Landroid/net/Uri$Builder;->build()Landroid/net/Uri;

    move-result-object v1

    invoke-virtual {v1}, Landroid/net/Uri;->toString()Ljava/lang/String;

    move-result-object v0

    .line 65
    .local v0, "urlClicker":Ljava/lang/String;
    new-instance v1, Ljava/lang/StringBuilder;

    invoke-direct {v1}, Ljava/lang/StringBuilder;-><init>()V

    const-string v2, "\u5e7f\u544a\u70b9\u51fburl:"

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1, v0}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v1

    const/4 v2, 0x0

    new-array v2, v2, [Ljava/lang/Object;

    invoke-static {v1, v2}, Lcom/orhanobut/logger/Logger;->e(Ljava/lang/String;[Ljava/lang/Object;)V

    .line 66
    new-instance v1, Lcom/cyjh/elfin/mvp/managers/AdImageManager$2;

    invoke-direct {v1, p0, p3}, Lcom/cyjh/elfin/mvp/managers/AdImageManager$2;-><init>(Lcom/cyjh/elfin/mvp/managers/AdImageManager;Landroid/content/Context;)V

    invoke-static {v0, p2, v1}, Lcom/cyjh/elfin/net/volley/VolleyManager;->requestStringGet(Ljava/lang/String;Ljava/lang/String;Lcom/cyjh/elfin/net/volley/VolleyRequestManager;)V

    .line 78
    return-void
.end method

.method public adShow(ILjava/lang/String;Lcom/cyjh/elfin/mvp/managers/Callback;Landroid/content/Context;)V
    .locals 4
    .param p1, "site"    # I
    .param p2, "tag"    # Ljava/lang/String;
    .param p4, "context"    # Landroid/content/Context;
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "(I",
            "Ljava/lang/String;",
            "Lcom/cyjh/elfin/mvp/managers/Callback",
            "<",
            "Lcom/cyjh/elfin/entity/Ad;",
            ">;",
            "Landroid/content/Context;",
            ")V"
        }
    .end annotation

    .prologue
    .line 30
    .local p3, "callback":Lcom/cyjh/elfin/mvp/managers/Callback;, "Lcom/cyjh/elfin/mvp/managers/Callback<Lcom/cyjh/elfin/entity/Ad;>;"
    const-string v1, "api.51moba.com"

    const-string v2, "GetApkAdvertisement"

    invoke-static {v1, v2}, Lcom/cyjh/elfin/constant/MyBuildConfig;->getBuilder(Ljava/lang/String;Ljava/lang/String;)Landroid/net/Uri$Builder;

    move-result-object v1

    const-string v2, "site"

    .line 31
    invoke-static {p1}, Ljava/lang/String;->valueOf(I)Ljava/lang/String;

    move-result-object v3

    invoke-virtual {v1, v2, v3}, Landroid/net/Uri$Builder;->appendQueryParameter(Ljava/lang/String;Ljava/lang/String;)Landroid/net/Uri$Builder;

    move-result-object v1

    const-string v2, "type"

    sget-object v3, Lcom/cyjh/elfin/constant/URLConstant;->VALUE_TYPE:Ljava/lang/String;

    .line 32
    invoke-virtual {v1, v2, v3}, Landroid/net/Uri$Builder;->appendQueryParameter(Ljava/lang/String;Ljava/lang/String;)Landroid/net/Uri$Builder;

    move-result-object v1

    .line 33
    invoke-virtual {v1}, Landroid/net/Uri$Builder;->build()Landroid/net/Uri;

    move-result-object v1

    invoke-virtual {v1}, Landroid/net/Uri;->toString()Ljava/lang/String;

    move-result-object v0

    .line 34
    .local v0, "url":Ljava/lang/String;
    new-instance v1, Ljava/lang/StringBuilder;

    invoke-direct {v1}, Ljava/lang/StringBuilder;-><init>()V

    const-string v2, "\u5e7f\u544aurl:"

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1, v0}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v1

    const/4 v2, 0x0

    new-array v2, v2, [Ljava/lang/Object;

    invoke-static {v1, v2}, Lcom/orhanobut/logger/Logger;->e(Ljava/lang/String;[Ljava/lang/Object;)V

    .line 35
    const-string v1, "zzz"

    new-instance v2, Ljava/lang/StringBuilder;

    invoke-direct {v2}, Ljava/lang/StringBuilder;-><init>()V

    const-string v3, "AdImageManager--\u5e7f\u544aurl:"

    invoke-virtual {v2, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    invoke-virtual {v2, v0}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    invoke-virtual {v2}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v2

    invoke-static {v1, v2}, Landroid/util/Log;->e(Ljava/lang/String;Ljava/lang/String;)I

    .line 36
    new-instance v1, Lcom/cyjh/elfin/mvp/managers/AdImageManager$1;

    invoke-direct {v1, p0, p4, p1, p3}, Lcom/cyjh/elfin/mvp/managers/AdImageManager$1;-><init>(Lcom/cyjh/elfin/mvp/managers/AdImageManager;Landroid/content/Context;ILcom/cyjh/elfin/mvp/managers/Callback;)V

    invoke-static {v0, p2, v1}, Lcom/cyjh/elfin/net/volley/VolleyManager;->requestStringGet(Ljava/lang/String;Ljava/lang/String;Lcom/cyjh/elfin/net/volley/VolleyRequestManager;)V

    .line 55
    return-void
.end method
