.class Lcom/cyjh/elfin/mvp/managers/RecommendGamesManager$2;
.super Lcom/cyjh/elfin/net/volley/VolleyRequestManager;
.source "RecommendGamesManager.java"


# annotations
.annotation system Ldalvik/annotation/EnclosingMethod;
    value = Lcom/cyjh/elfin/mvp/managers/RecommendGamesManager;->gameJumpSwitch(Landroid/content/Context;Lcom/cyjh/elfin/mvp/managers/Callback;)V
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
    .line 51
    iput-object p1, p0, Lcom/cyjh/elfin/mvp/managers/RecommendGamesManager$2;->this$0:Lcom/cyjh/elfin/mvp/managers/RecommendGamesManager;

    iput-object p3, p0, Lcom/cyjh/elfin/mvp/managers/RecommendGamesManager$2;->val$callback:Lcom/cyjh/elfin/mvp/managers/Callback;

    invoke-direct {p0, p2}, Lcom/cyjh/elfin/net/volley/VolleyRequestManager;-><init>(Landroid/content/Context;)V

    return-void
.end method


# virtual methods
.method public onRequestErrorRes(Ljava/lang/String;)V
    .locals 1
    .param p1, "msg"    # Ljava/lang/String;

    .prologue
    .line 63
    iget-object v0, p0, Lcom/cyjh/elfin/mvp/managers/RecommendGamesManager$2;->val$callback:Lcom/cyjh/elfin/mvp/managers/Callback;

    invoke-interface {v0, p1}, Lcom/cyjh/elfin/mvp/managers/Callback;->error(Ljava/lang/String;)V

    .line 64
    return-void
.end method

.method public onRequestSuccessRes(Ljava/lang/String;)V
    .locals 3
    .param p1, "res"    # Ljava/lang/String;

    .prologue
    .line 54
    invoke-static {p1}, Landroid/text/TextUtils;->isEmpty(Ljava/lang/CharSequence;)Z

    move-result v2

    if-nez v2, :cond_0

    .line 55
    new-instance v1, Lcom/google/gson/Gson;

    invoke-direct {v1}, Lcom/google/gson/Gson;-><init>()V

    .line 56
    .local v1, "gson":Lcom/google/gson/Gson;
    const-class v2, Lcom/cyjh/elfin/entity/GameSwitchBean;

    invoke-virtual {v1, p1, v2}, Lcom/google/gson/Gson;->fromJson(Ljava/lang/String;Ljava/lang/Class;)Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Lcom/cyjh/elfin/entity/GameSwitchBean;

    .line 57
    .local v0, "gameSwitchBean":Lcom/cyjh/elfin/entity/GameSwitchBean;
    iget-object v2, p0, Lcom/cyjh/elfin/mvp/managers/RecommendGamesManager$2;->val$callback:Lcom/cyjh/elfin/mvp/managers/Callback;

    invoke-interface {v2, v0}, Lcom/cyjh/elfin/mvp/managers/Callback;->finish(Ljava/lang/Object;)V

    .line 59
    .end local v0    # "gameSwitchBean":Lcom/cyjh/elfin/entity/GameSwitchBean;
    .end local v1    # "gson":Lcom/google/gson/Gson;
    :cond_0
    return-void
.end method
