.class Lcom/cyjh/elfin/mvp/managers/RecommendGamesManager$1;
.super Lcom/cyjh/elfin/net/volley/VolleyRequestManager;
.source "RecommendGamesManager.java"


# annotations
.annotation system Ldalvik/annotation/EnclosingMethod;
    value = Lcom/cyjh/elfin/mvp/managers/RecommendGamesManager;->adRecommendGames(Landroid/content/Context;Lcom/cyjh/elfin/mvp/managers/Callback;)V
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x0
    name = null
.end annotation


# instance fields
.field final synthetic this$0:Lcom/cyjh/elfin/mvp/managers/RecommendGamesManager;

.field final synthetic val$callback:Lcom/cyjh/elfin/mvp/managers/Callback;


# direct methods
.method constructor <init>(Lcom/cyjh/elfin/mvp/managers/RecommendGamesManager;Landroid/content/Context;Lcom/cyjh/elfin/mvp/managers/Callback;)V
    .locals 0
    .param p1, "this$0"    # Lcom/cyjh/elfin/mvp/managers/RecommendGamesManager;
    .param p2, "context"    # Landroid/content/Context;

    .prologue
    .line 29
    iput-object p1, p0, Lcom/cyjh/elfin/mvp/managers/RecommendGamesManager$1;->this$0:Lcom/cyjh/elfin/mvp/managers/RecommendGamesManager;

    iput-object p3, p0, Lcom/cyjh/elfin/mvp/managers/RecommendGamesManager$1;->val$callback:Lcom/cyjh/elfin/mvp/managers/Callback;

    invoke-direct {p0, p2}, Lcom/cyjh/elfin/net/volley/VolleyRequestManager;-><init>(Landroid/content/Context;)V

    return-void
.end method


# virtual methods
.method public onRequestErrorRes(Ljava/lang/String;)V
    .locals 2
    .param p1, "msg"    # Ljava/lang/String;

    .prologue
    .line 41
    new-instance v0, Ljava/lang/StringBuilder;

    invoke-direct {v0}, Ljava/lang/StringBuilder;-><init>()V

    const-string v1, "msg"

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-virtual {v0, p1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-virtual {v0}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v0

    const/4 v1, 0x0

    new-array v1, v1, [Ljava/lang/Object;

    invoke-static {v0, v1}, Lcom/orhanobut/logger/Logger;->e(Ljava/lang/String;[Ljava/lang/Object;)V

    .line 42
    iget-object v0, p0, Lcom/cyjh/elfin/mvp/managers/RecommendGamesManager$1;->val$callback:Lcom/cyjh/elfin/mvp/managers/Callback;

    invoke-interface {v0, p1}, Lcom/cyjh/elfin/mvp/managers/Callback;->error(Ljava/lang/String;)V

    .line 43
    return-void
.end method

.method public onRequestSuccessRes(Ljava/lang/String;)V
    .locals 3
    .param p1, "res"    # Ljava/lang/String;

    .prologue
    .line 32
    invoke-static {p1}, Landroid/text/TextUtils;->isEmpty(Ljava/lang/CharSequence;)Z

    move-result v2

    if-nez v2, :cond_0

    .line 33
    new-instance v0, Lcom/google/gson/Gson;

    invoke-direct {v0}, Lcom/google/gson/Gson;-><init>()V

    .line 34
    .local v0, "gson":Lcom/google/gson/Gson;
    const-class v2, Lcom/cyjh/elfin/entity/RecommendGamesBean;

    invoke-virtual {v0, p1, v2}, Lcom/google/gson/Gson;->fromJson(Ljava/lang/String;Ljava/lang/Class;)Ljava/lang/Object;

    move-result-object v1

    check-cast v1, Lcom/cyjh/elfin/entity/RecommendGamesBean;

    .line 35
    .local v1, "recommendGamesBean":Lcom/cyjh/elfin/entity/RecommendGamesBean;
    iget-object v2, p0, Lcom/cyjh/elfin/mvp/managers/RecommendGamesManager$1;->val$callback:Lcom/cyjh/elfin/mvp/managers/Callback;

    invoke-interface {v2, v1}, Lcom/cyjh/elfin/mvp/managers/Callback;->finish(Ljava/lang/Object;)V

    .line 37
    .end local v0    # "gson":Lcom/google/gson/Gson;
    .end local v1    # "recommendGamesBean":Lcom/cyjh/elfin/entity/RecommendGamesBean;
    :cond_0
    return-void
.end method
