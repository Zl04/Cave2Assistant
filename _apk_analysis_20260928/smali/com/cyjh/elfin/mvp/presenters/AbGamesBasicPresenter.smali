.class public abstract Lcom/cyjh/elfin/mvp/presenters/AbGamesBasicPresenter;
.super Lcom/cyjh/elfin/mvp/presenters/BasicNetPresenter;
.source "AbGamesBasicPresenter.java"


# direct methods
.method public constructor <init>(Lcom/cyjh/elfin/mvp/views/loadstate/ILoadState;)V
    .locals 0
    .param p1, "iLoadState"    # Lcom/cyjh/elfin/mvp/views/loadstate/ILoadState;

    .prologue
    .line 15
    invoke-direct {p0, p1}, Lcom/cyjh/elfin/mvp/presenters/BasicNetPresenter;-><init>(Lcom/cyjh/elfin/mvp/views/loadstate/ILoadState;)V

    .line 16
    return-void
.end method


# virtual methods
.method public abstract firstLoadData(I)V
.end method

.method public abstract loadData(I)V
.end method
