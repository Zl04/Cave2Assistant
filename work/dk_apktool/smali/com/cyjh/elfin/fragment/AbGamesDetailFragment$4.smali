.class Lcom/cyjh/elfin/fragment/AbGamesDetailFragment$4;
.super Ljava/lang/Object;
.source "AbGamesDetailFragment.java"

# interfaces
.implements Ljava/lang/Runnable;


# annotations
.annotation system Ldalvik/annotation/EnclosingMethod;
    value = Lcom/cyjh/elfin/fragment/AbGamesDetailFragment;->hideLoading()V
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
    .line 279
    iput-object p1, p0, Lcom/cyjh/elfin/fragment/AbGamesDetailFragment$4;->this$0:Lcom/cyjh/elfin/fragment/AbGamesDetailFragment;

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method


# virtual methods
.method public run()V
    .locals 2

    .prologue
    .line 282
    iget-object v0, p0, Lcom/cyjh/elfin/fragment/AbGamesDetailFragment$4;->this$0:Lcom/cyjh/elfin/fragment/AbGamesDetailFragment;

    invoke-static {v0}, Lcom/cyjh/elfin/fragment/AbGamesDetailFragment;->access$100(Lcom/cyjh/elfin/fragment/AbGamesDetailFragment;)Landroid/support/v4/widget/SwipeRefreshLayout;

    move-result-object v0

    const/4 v1, 0x0

    invoke-virtual {v0, v1}, Landroid/support/v4/widget/SwipeRefreshLayout;->setRefreshing(Z)V

    .line 283
    return-void
.end method
