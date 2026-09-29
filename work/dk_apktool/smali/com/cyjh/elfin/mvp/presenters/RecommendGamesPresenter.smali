.class public Lcom/cyjh/elfin/mvp/presenters/RecommendGamesPresenter;
.super Ljava/lang/Object;
.source "RecommendGamesPresenter.java"

# interfaces
.implements Lcom/cyjh/elfin/mvp/presenters/BasePresenter;


# instance fields
.field private recommendGamesManager:Lcom/cyjh/elfin/mvp/managers/RecommendGamesManager;

.field private recommendGamesView:Lcom/cyjh/elfin/mvp/views/RecommendGamesView;


# direct methods
.method public constructor <init>(Lcom/cyjh/elfin/mvp/views/RecommendGamesView;)V
    .locals 1
    .param p1, "recommendGamesView"    # Lcom/cyjh/elfin/mvp/views/RecommendGamesView;

    .prologue
    .line 20
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    .line 21
    iput-object p1, p0, Lcom/cyjh/elfin/mvp/presenters/RecommendGamesPresenter;->recommendGamesView:Lcom/cyjh/elfin/mvp/views/RecommendGamesView;

    .line 22
    new-instance v0, Lcom/cyjh/elfin/mvp/managers/RecommendGamesManager;

    invoke-direct {v0}, Lcom/cyjh/elfin/mvp/managers/RecommendGamesManager;-><init>()V

    iput-object v0, p0, Lcom/cyjh/elfin/mvp/presenters/RecommendGamesPresenter;->recommendGamesManager:Lcom/cyjh/elfin/mvp/managers/RecommendGamesManager;

    .line 23
    return-void
.end method

.method static synthetic access$000(Lcom/cyjh/elfin/mvp/presenters/RecommendGamesPresenter;)Lcom/cyjh/elfin/mvp/views/RecommendGamesView;
    .locals 1
    .param p0, "x0"    # Lcom/cyjh/elfin/mvp/presenters/RecommendGamesPresenter;

    .prologue
    .line 15
    iget-object v0, p0, Lcom/cyjh/elfin/mvp/presenters/RecommendGamesPresenter;->recommendGamesView:Lcom/cyjh/elfin/mvp/views/RecommendGamesView;

    return-object v0
.end method


# virtual methods
.method public gameJumpSwitch(Landroid/content/Context;)V
    .locals 2
    .param p1, "context"    # Landroid/content/Context;

    .prologue
    .line 30
    iget-object v0, p0, Lcom/cyjh/elfin/mvp/presenters/RecommendGamesPresenter;->recommendGamesManager:Lcom/cyjh/elfin/mvp/managers/RecommendGamesManager;

    new-instance v1, Lcom/cyjh/elfin/mvp/presenters/RecommendGamesPresenter$1;

    invoke-direct {v1, p0}, Lcom/cyjh/elfin/mvp/presenters/RecommendGamesPresenter$1;-><init>(Lcom/cyjh/elfin/mvp/presenters/RecommendGamesPresenter;)V

    invoke-virtual {v0, p1, v1}, Lcom/cyjh/elfin/mvp/managers/RecommendGamesManager;->gameJumpSwitch(Landroid/content/Context;Lcom/cyjh/elfin/mvp/managers/Callback;)V

    .line 41
    return-void
.end method
