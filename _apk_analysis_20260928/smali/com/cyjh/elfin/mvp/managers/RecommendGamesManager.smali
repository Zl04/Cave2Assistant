.class public Lcom/cyjh/elfin/mvp/managers/RecommendGamesManager;
.super Ljava/lang/Object;
.source "RecommendGamesManager.java"

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
.method public adRecommendGames(Landroid/content/Context;Lcom/cyjh/elfin/mvp/managers/Callback;)V
    .locals 3
    .param p1, "context"    # Landroid/content/Context;
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "(",
            "Landroid/content/Context;",
            "Lcom/cyjh/elfin/mvp/managers/Callback",
            "<",
            "Lcom/cyjh/elfin/entity/RecommendGamesBean;",
            ">;)V"
        }
    .end annotation

    .prologue
    .line 27
    .local p2, "callback":Lcom/cyjh/elfin/mvp/managers/Callback;, "Lcom/cyjh/elfin/mvp/managers/Callback<Lcom/cyjh/elfin/entity/RecommendGamesBean;>;"
    const-string v1, "api.51moba.com"

    const-string v2, "GetFreeElfGameRecommended"

    invoke-static {v1, v2}, Lcom/cyjh/elfin/constant/MyBuildConfig;->getBuilder(Ljava/lang/String;Ljava/lang/String;)Landroid/net/Uri$Builder;

    move-result-object v1

    invoke-virtual {v1}, Landroid/net/Uri$Builder;->build()Landroid/net/Uri;

    move-result-object v1

    invoke-virtual {v1}, Landroid/net/Uri;->toString()Ljava/lang/String;

    move-result-object v0

    .line 28
    .local v0, "url":Ljava/lang/String;
    new-instance v1, Ljava/lang/StringBuilder;

    invoke-direct {v1}, Ljava/lang/StringBuilder;-><init>()V

    const-string v2, "\u63a8\u8350\u6e38\u620furl:"

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1, v0}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v1

    const/4 v2, 0x0

    new-array v2, v2, [Ljava/lang/Object;

    invoke-static {v1, v2}, Lcom/orhanobut/logger/Logger;->e(Ljava/lang/String;[Ljava/lang/Object;)V

    .line 29
    const-class v1, Lcom/cyjh/elfin/mvp/managers/RecommendGamesManager;

    invoke-virtual {v1}, Ljava/lang/Class;->getSimpleName()Ljava/lang/String;

    move-result-object v1

    new-instance v2, Lcom/cyjh/elfin/mvp/managers/RecommendGamesManager$1;

    invoke-direct {v2, p0, p1, p2}, Lcom/cyjh/elfin/mvp/managers/RecommendGamesManager$1;-><init>(Lcom/cyjh/elfin/mvp/managers/RecommendGamesManager;Landroid/content/Context;Lcom/cyjh/elfin/mvp/managers/Callback;)V

    invoke-static {v0, v1, v2}, Lcom/cyjh/elfin/net/volley/VolleyManager;->requestStringGet(Ljava/lang/String;Ljava/lang/String;Lcom/cyjh/elfin/net/volley/VolleyRequestManager;)V

    .line 45
    return-void
.end method

.method public gameJumpSwitch(Landroid/content/Context;Lcom/cyjh/elfin/mvp/managers/Callback;)V
    .locals 3
    .param p1, "context"    # Landroid/content/Context;
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "(",
            "Landroid/content/Context;",
            "Lcom/cyjh/elfin/mvp/managers/Callback",
            "<",
            "Lcom/cyjh/elfin/entity/GameSwitchBean;",
            ">;)V"
        }
    .end annotation

    .prologue
    .line 48
    .local p2, "callback":Lcom/cyjh/elfin/mvp/managers/Callback;, "Lcom/cyjh/elfin/mvp/managers/Callback<Lcom/cyjh/elfin/entity/GameSwitchBean;>;"
    const-string v1, "api.51moba.com"

    const-string v2, "GetFreeElfGameRecommended_New"

    invoke-static {v1, v2}, Lcom/cyjh/elfin/constant/MyBuildConfig;->getBuilder(Ljava/lang/String;Ljava/lang/String;)Landroid/net/Uri$Builder;

    move-result-object v1

    .line 49
    invoke-virtual {v1}, Landroid/net/Uri$Builder;->build()Landroid/net/Uri;

    move-result-object v1

    invoke-virtual {v1}, Landroid/net/Uri;->toString()Ljava/lang/String;

    move-result-object v0

    .line 50
    .local v0, "url":Ljava/lang/String;
    new-instance v1, Ljava/lang/StringBuilder;

    invoke-direct {v1}, Ljava/lang/StringBuilder;-><init>()V

    const-string v2, "\u6e38\u620f\u63a7\u5236\u5f00\u5173url:"

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1, v0}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v1

    const/4 v2, 0x0

    new-array v2, v2, [Ljava/lang/Object;

    invoke-static {v1, v2}, Lcom/orhanobut/logger/Logger;->e(Ljava/lang/String;[Ljava/lang/Object;)V

    .line 51
    const-class v1, Lcom/cyjh/elfin/mvp/managers/RecommendGamesManager;

    invoke-virtual {v1}, Ljava/lang/Class;->getCanonicalName()Ljava/lang/String;

    move-result-object v1

    new-instance v2, Lcom/cyjh/elfin/mvp/managers/RecommendGamesManager$2;

    invoke-direct {v2, p0, p1, p2}, Lcom/cyjh/elfin/mvp/managers/RecommendGamesManager$2;-><init>(Lcom/cyjh/elfin/mvp/managers/RecommendGamesManager;Landroid/content/Context;Lcom/cyjh/elfin/mvp/managers/Callback;)V

    invoke-static {v0, v1, v2}, Lcom/cyjh/elfin/net/volley/VolleyManager;->requestStringGet(Ljava/lang/String;Ljava/lang/String;Lcom/cyjh/elfin/net/volley/VolleyRequestManager;)V

    .line 66
    return-void
.end method
