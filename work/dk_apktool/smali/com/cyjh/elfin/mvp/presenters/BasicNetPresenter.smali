.class public abstract Lcom/cyjh/elfin/mvp/presenters/BasicNetPresenter;
.super Ljava/lang/Object;
.source "BasicNetPresenter.java"

# interfaces
.implements Lcom/cyjh/elfin/net/volley/inf/IAnalysisJson;
.implements Lcom/cyjh/elfin/net/volley/inf/IUIDataListener;


# instance fields
.field protected iLoadState:Lcom/cyjh/elfin/mvp/views/loadstate/ILoadState;

.field protected mA:Lcom/cyjh/elfin/net/volley/ActivityHttpHelper;


# direct methods
.method public constructor <init>(Lcom/cyjh/elfin/mvp/views/loadstate/ILoadState;)V
    .locals 1
    .param p1, "iLoadState"    # Lcom/cyjh/elfin/mvp/views/loadstate/ILoadState;

    .prologue
    .line 15
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    .line 16
    new-instance v0, Lcom/cyjh/elfin/net/volley/ActivityHttpHelper;

    invoke-direct {v0, p0, p0}, Lcom/cyjh/elfin/net/volley/ActivityHttpHelper;-><init>(Lcom/cyjh/elfin/net/volley/inf/IUIDataListener;Lcom/cyjh/elfin/net/volley/inf/IAnalysisJson;)V

    iput-object v0, p0, Lcom/cyjh/elfin/mvp/presenters/BasicNetPresenter;->mA:Lcom/cyjh/elfin/net/volley/ActivityHttpHelper;

    .line 17
    iput-object p1, p0, Lcom/cyjh/elfin/mvp/presenters/BasicNetPresenter;->iLoadState:Lcom/cyjh/elfin/mvp/views/loadstate/ILoadState;

    .line 18
    return-void
.end method
