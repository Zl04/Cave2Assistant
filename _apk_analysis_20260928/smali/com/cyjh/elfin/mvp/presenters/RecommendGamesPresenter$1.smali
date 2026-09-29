.class Lcom/cyjh/elfin/mvp/presenters/RecommendGamesPresenter$1;
.super Ljava/lang/Object;
.source "RecommendGamesPresenter.java"

# interfaces
.implements Lcom/cyjh/elfin/mvp/managers/Callback;


# annotations
.annotation system Ldalvik/annotation/EnclosingMethod;
    value = Lcom/cyjh/elfin/mvp/presenters/RecommendGamesPresenter;->gameJumpSwitch(Landroid/content/Context;)V
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x0
    name = null
.end annotation

.annotation system Ldalvik/annotation/Signature;
    value = {
        "Ljava/lang/Object;",
        "Lcom/cyjh/elfin/mvp/managers/Callback",
        "<",
        "Lcom/cyjh/elfin/entity/GameSwitchBean;",
        ">;"
    }
.end annotation


# instance fields
.field final synthetic this$0:Lcom/cyjh/elfin/mvp/presenters/RecommendGamesPresenter;


# direct methods
.method constructor <init>(Lcom/cyjh/elfin/mvp/presenters/RecommendGamesPresenter;)V
    .locals 0
    .param p1, "this$0"    # Lcom/cyjh/elfin/mvp/presenters/RecommendGamesPresenter;

    .prologue
    .line 30
    iput-object p1, p0, Lcom/cyjh/elfin/mvp/presenters/RecommendGamesPresenter$1;->this$0:Lcom/cyjh/elfin/mvp/presenters/RecommendGamesPresenter;

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method


# virtual methods
.method public error(Ljava/lang/String;)V
    .locals 2
    .param p1, "msg"    # Ljava/lang/String;

    .prologue
    .line 38
    iget-object v0, p0, Lcom/cyjh/elfin/mvp/presenters/RecommendGamesPresenter$1;->this$0:Lcom/cyjh/elfin/mvp/presenters/RecommendGamesPresenter;

    invoke-static {v0}, Lcom/cyjh/elfin/mvp/presenters/RecommendGamesPresenter;->access$000(Lcom/cyjh/elfin/mvp/presenters/RecommendGamesPresenter;)Lcom/cyjh/elfin/mvp/views/RecommendGamesView;

    move-result-object v0

    const-string v1, "GetFreeElfGameRecommended_New"

    invoke-interface {v0, p1, v1}, Lcom/cyjh/elfin/mvp/views/RecommendGamesView;->onErrorMsg(Ljava/lang/String;Ljava/lang/String;)V

    .line 39
    return-void
.end method

.method public finish(Lcom/cyjh/elfin/entity/GameSwitchBean;)V
    .locals 1
    .param p1, "gameSwitchBean"    # Lcom/cyjh/elfin/entity/GameSwitchBean;

    .prologue
    .line 33
    iget-object v0, p0, Lcom/cyjh/elfin/mvp/presenters/RecommendGamesPresenter$1;->this$0:Lcom/cyjh/elfin/mvp/presenters/RecommendGamesPresenter;

    invoke-static {v0}, Lcom/cyjh/elfin/mvp/presenters/RecommendGamesPresenter;->access$000(Lcom/cyjh/elfin/mvp/presenters/RecommendGamesPresenter;)Lcom/cyjh/elfin/mvp/views/RecommendGamesView;

    move-result-object v0

    invoke-interface {v0, p1}, Lcom/cyjh/elfin/mvp/views/RecommendGamesView;->gamesSwitch(Lcom/cyjh/elfin/entity/GameSwitchBean;)V

    .line 34
    return-void
.end method

.method public bridge synthetic finish(Ljava/lang/Object;)V
    .locals 0

    .prologue
    .line 30
    check-cast p1, Lcom/cyjh/elfin/entity/GameSwitchBean;

    invoke-virtual {p0, p1}, Lcom/cyjh/elfin/mvp/presenters/RecommendGamesPresenter$1;->finish(Lcom/cyjh/elfin/entity/GameSwitchBean;)V

    return-void
.end method
