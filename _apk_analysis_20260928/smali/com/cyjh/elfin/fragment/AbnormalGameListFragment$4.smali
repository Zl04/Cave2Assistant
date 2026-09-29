.class Lcom/cyjh/elfin/fragment/AbnormalGameListFragment$4;
.super Ljava/lang/Object;
.source "AbnormalGameListFragment.java"

# interfaces
.implements Ljava/lang/Runnable;


# annotations
.annotation system Ldalvik/annotation/EnclosingMethod;
    value = Lcom/cyjh/elfin/fragment/AbnormalGameListFragment;->showLoading()V
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x0
    name = null
.end annotation


# instance fields
.field final synthetic this$0:Lcom/cyjh/elfin/fragment/AbnormalGameListFragment;


# direct methods
.method constructor <init>(Lcom/cyjh/elfin/fragment/AbnormalGameListFragment;)V
    .locals 0
    .param p1, "this$0"    # Lcom/cyjh/elfin/fragment/AbnormalGameListFragment;

    .prologue
    .line 281
    iput-object p1, p0, Lcom/cyjh/elfin/fragment/AbnormalGameListFragment$4;->this$0:Lcom/cyjh/elfin/fragment/AbnormalGameListFragment;

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method


# virtual methods
.method public run()V
    .locals 2

    .prologue
    .line 284
    iget-object v0, p0, Lcom/cyjh/elfin/fragment/AbnormalGameListFragment$4;->this$0:Lcom/cyjh/elfin/fragment/AbnormalGameListFragment;

    iget-object v0, v0, Lcom/cyjh/elfin/fragment/AbnormalGameListFragment;->findSwipeRefreshLayout:Lcom/cyjh/elfin/customview/loadwidget/swiperefresh/FindSwipeRefreshLayout;

    const/4 v1, 0x1

    invoke-virtual {v0, v1}, Lcom/cyjh/elfin/customview/loadwidget/swiperefresh/FindSwipeRefreshLayout;->setRefreshing(Z)V

    .line 285
    return-void
.end method
