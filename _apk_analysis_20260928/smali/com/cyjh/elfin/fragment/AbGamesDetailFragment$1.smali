.class Lcom/cyjh/elfin/fragment/AbGamesDetailFragment$1;
.super Ljava/lang/Object;
.source "AbGamesDetailFragment.java"

# interfaces
.implements Landroid/view/ViewTreeObserver$OnScrollChangedListener;


# annotations
.annotation system Ldalvik/annotation/EnclosingMethod;
    value = Lcom/cyjh/elfin/fragment/AbGamesDetailFragment;->initView(Landroid/view/LayoutInflater;Landroid/view/ViewGroup;Landroid/os/Bundle;)Landroid/view/View;
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
    .line 106
    iput-object p1, p0, Lcom/cyjh/elfin/fragment/AbGamesDetailFragment$1;->this$0:Lcom/cyjh/elfin/fragment/AbGamesDetailFragment;

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method


# virtual methods
.method public onScrollChanged()V
    .locals 2

    .prologue
    .line 110
    iget-object v0, p0, Lcom/cyjh/elfin/fragment/AbGamesDetailFragment$1;->this$0:Lcom/cyjh/elfin/fragment/AbGamesDetailFragment;

    invoke-static {v0}, Lcom/cyjh/elfin/fragment/AbGamesDetailFragment;->access$100(Lcom/cyjh/elfin/fragment/AbGamesDetailFragment;)Landroid/support/v4/widget/SwipeRefreshLayout;

    move-result-object v1

    iget-object v0, p0, Lcom/cyjh/elfin/fragment/AbGamesDetailFragment$1;->this$0:Lcom/cyjh/elfin/fragment/AbGamesDetailFragment;

    invoke-static {v0}, Lcom/cyjh/elfin/fragment/AbGamesDetailFragment;->access$000(Lcom/cyjh/elfin/fragment/AbGamesDetailFragment;)Landroid/widget/ScrollView;

    move-result-object v0

    invoke-virtual {v0}, Landroid/widget/ScrollView;->getScrollY()I

    move-result v0

    if-nez v0, :cond_0

    const/4 v0, 0x1

    :goto_0
    invoke-virtual {v1, v0}, Landroid/support/v4/widget/SwipeRefreshLayout;->setEnabled(Z)V

    .line 111
    return-void

    .line 110
    :cond_0
    const/4 v0, 0x0

    goto :goto_0
.end method
