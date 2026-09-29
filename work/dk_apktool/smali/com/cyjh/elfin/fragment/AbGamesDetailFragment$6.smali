.class Lcom/cyjh/elfin/fragment/AbGamesDetailFragment$6;
.super Ljava/lang/Object;
.source "AbGamesDetailFragment.java"

# interfaces
.implements Landroid/view/View$OnClickListener;


# annotations
.annotation system Ldalvik/annotation/EnclosingMethod;
    value = Lcom/cyjh/elfin/fragment/AbGamesDetailFragment;->getEmptyView()Landroid/view/View;
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x0
    name = null
.end annotation


# instance fields
.field final synthetic this$0:Lcom/cyjh/elfin/fragment/AbGamesDetailFragment;


# direct methods
.method constructor <init>(Lcom/cyjh/elfin/fragment/AbGamesDetailFragment;)V
    .locals 0
    .param p1, "this$0"    # Lcom/cyjh/elfin/fragment/AbGamesDetailFragment;

    .prologue
    .line 399
    iput-object p1, p0, Lcom/cyjh/elfin/fragment/AbGamesDetailFragment$6;->this$0:Lcom/cyjh/elfin/fragment/AbGamesDetailFragment;

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method


# virtual methods
.method public onClick(Landroid/view/View;)V
    .locals 2
    .param p1, "v"    # Landroid/view/View;

    .prologue
    .line 402
    iget-object v0, p0, Lcom/cyjh/elfin/fragment/AbGamesDetailFragment$6;->this$0:Lcom/cyjh/elfin/fragment/AbGamesDetailFragment;

    invoke-static {v0}, Lcom/cyjh/elfin/fragment/AbGamesDetailFragment;->access$200(Lcom/cyjh/elfin/fragment/AbGamesDetailFragment;)Lcom/cyjh/elfin/mvp/presenters/AbGameDetailsPresenter;

    move-result-object v0

    const/4 v1, 0x1

    invoke-virtual {v0, v1}, Lcom/cyjh/elfin/mvp/presenters/AbGameDetailsPresenter;->firstLoadData(I)V

    .line 403
    return-void
.end method
