.class public Lcom/cyjh/elfin/mvp/presenters/BlackListPresenter;
.super Ljava/lang/Object;
.source "BlackListPresenter.java"

# interfaces
.implements Lcom/cyjh/elfin/mvp/presenters/BasePresenter;


# instance fields
.field private blackListManager:Lcom/cyjh/elfin/mvp/managers/BlackListManager;

.field private blackListView:Lcom/cyjh/elfin/mvp/views/BlackListView;


# direct methods
.method public constructor <init>(Lcom/cyjh/elfin/mvp/views/BlackListView;)V
    .locals 1
    .param p1, "blackListView"    # Lcom/cyjh/elfin/mvp/views/BlackListView;

    .prologue
    .line 16
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    .line 17
    iput-object p1, p0, Lcom/cyjh/elfin/mvp/presenters/BlackListPresenter;->blackListView:Lcom/cyjh/elfin/mvp/views/BlackListView;

    .line 18
    new-instance v0, Lcom/cyjh/elfin/mvp/managers/BlackListManager;

    invoke-direct {v0}, Lcom/cyjh/elfin/mvp/managers/BlackListManager;-><init>()V

    iput-object v0, p0, Lcom/cyjh/elfin/mvp/presenters/BlackListPresenter;->blackListManager:Lcom/cyjh/elfin/mvp/managers/BlackListManager;

    .line 19
    return-void
.end method

.method static synthetic access$000(Lcom/cyjh/elfin/mvp/presenters/BlackListPresenter;)Lcom/cyjh/elfin/mvp/views/BlackListView;
    .locals 1
    .param p0, "x0"    # Lcom/cyjh/elfin/mvp/presenters/BlackListPresenter;

    .prologue
    .line 12
    iget-object v0, p0, Lcom/cyjh/elfin/mvp/presenters/BlackListPresenter;->blackListView:Lcom/cyjh/elfin/mvp/views/BlackListView;

    return-object v0
.end method


# virtual methods
.method public isSetBlackList(Landroid/content/Context;)V
    .locals 3
    .param p1, "context"    # Landroid/content/Context;

    .prologue
    .line 26
    iget-object v0, p0, Lcom/cyjh/elfin/mvp/presenters/BlackListPresenter;->blackListManager:Lcom/cyjh/elfin/mvp/managers/BlackListManager;

    const-class v1, Lcom/cyjh/elfin/mvp/presenters/BlackListPresenter;

    invoke-virtual {v1}, Ljava/lang/Class;->getSimpleName()Ljava/lang/String;

    move-result-object v1

    new-instance v2, Lcom/cyjh/elfin/mvp/presenters/BlackListPresenter$1;

    invoke-direct {v2, p0}, Lcom/cyjh/elfin/mvp/presenters/BlackListPresenter$1;-><init>(Lcom/cyjh/elfin/mvp/presenters/BlackListPresenter;)V

    invoke-virtual {v0, p1, v1, v2}, Lcom/cyjh/elfin/mvp/managers/BlackListManager;->isSetBlackList(Landroid/content/Context;Ljava/lang/String;Lcom/cyjh/elfin/mvp/managers/Callback;)V

    .line 37
    return-void
.end method
