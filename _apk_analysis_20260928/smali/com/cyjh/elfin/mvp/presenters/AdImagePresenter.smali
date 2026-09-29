.class public Lcom/cyjh/elfin/mvp/presenters/AdImagePresenter;
.super Ljava/lang/Object;
.source "AdImagePresenter.java"

# interfaces
.implements Lcom/cyjh/elfin/mvp/presenters/BasePresenter;


# instance fields
.field private adImageManager:Lcom/cyjh/elfin/mvp/managers/AdImageManager;

.field private adImageView:Lcom/cyjh/elfin/mvp/views/AdImageView;


# direct methods
.method public constructor <init>(Lcom/cyjh/elfin/mvp/views/AdImageView;)V
    .locals 1
    .param p1, "adImageView"    # Lcom/cyjh/elfin/mvp/views/AdImageView;

    .prologue
    .line 25
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    .line 26
    iput-object p1, p0, Lcom/cyjh/elfin/mvp/presenters/AdImagePresenter;->adImageView:Lcom/cyjh/elfin/mvp/views/AdImageView;

    .line 27
    new-instance v0, Lcom/cyjh/elfin/mvp/managers/AdImageManager;

    invoke-direct {v0}, Lcom/cyjh/elfin/mvp/managers/AdImageManager;-><init>()V

    iput-object v0, p0, Lcom/cyjh/elfin/mvp/presenters/AdImagePresenter;->adImageManager:Lcom/cyjh/elfin/mvp/managers/AdImageManager;

    .line 28
    return-void
.end method

.method static synthetic access$000(Lcom/cyjh/elfin/mvp/presenters/AdImagePresenter;)Lcom/cyjh/elfin/mvp/views/AdImageView;
    .locals 1
    .param p0, "x0"    # Lcom/cyjh/elfin/mvp/presenters/AdImagePresenter;

    .prologue
    .line 21
    iget-object v0, p0, Lcom/cyjh/elfin/mvp/presenters/AdImagePresenter;->adImageView:Lcom/cyjh/elfin/mvp/views/AdImageView;

    return-object v0
.end method


# virtual methods
.method public adClicker(Ljava/lang/String;Ljava/lang/String;Landroid/content/Context;)V
    .locals 1
    .param p1, "id"    # Ljava/lang/String;
    .param p2, "tag"    # Ljava/lang/String;
    .param p3, "context"    # Landroid/content/Context;

    .prologue
    .line 66
    iget-object v0, p0, Lcom/cyjh/elfin/mvp/presenters/AdImagePresenter;->adImageManager:Lcom/cyjh/elfin/mvp/managers/AdImageManager;

    invoke-virtual {v0, p1, p2, p3}, Lcom/cyjh/elfin/mvp/managers/AdImageManager;->adClicker(Ljava/lang/String;Ljava/lang/String;Landroid/content/Context;)V

    .line 67
    return-void
.end method

.method public adShow(Landroid/content/Context;ILjava/lang/String;)V
    .locals 2
    .param p1, "context"    # Landroid/content/Context;
    .param p2, "site"    # I
    .param p3, "tag"    # Ljava/lang/String;

    .prologue
    .line 36
    iget-object v0, p0, Lcom/cyjh/elfin/mvp/presenters/AdImagePresenter;->adImageManager:Lcom/cyjh/elfin/mvp/managers/AdImageManager;

    new-instance v1, Lcom/cyjh/elfin/mvp/presenters/AdImagePresenter$1;

    invoke-direct {v1, p0, p2}, Lcom/cyjh/elfin/mvp/presenters/AdImagePresenter$1;-><init>(Lcom/cyjh/elfin/mvp/presenters/AdImagePresenter;I)V

    invoke-virtual {v0, p2, p3, v1, p1}, Lcom/cyjh/elfin/mvp/managers/AdImageManager;->adShow(ILjava/lang/String;Lcom/cyjh/elfin/mvp/managers/Callback;Landroid/content/Context;)V

    .line 58
    return-void
.end method
