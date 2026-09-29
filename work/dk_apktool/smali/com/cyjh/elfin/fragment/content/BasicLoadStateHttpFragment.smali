.class public abstract Lcom/cyjh/elfin/fragment/content/BasicLoadStateHttpFragment;
.super Lcom/cyjh/elfin/fragment/content/LoadStateHttpFragment;
.source "BasicLoadStateHttpFragment.java"


# direct methods
.method public constructor <init>()V
    .locals 0

    .prologue
    .line 13
    invoke-direct {p0}, Lcom/cyjh/elfin/fragment/content/LoadStateHttpFragment;-><init>()V

    return-void
.end method


# virtual methods
.method public getEmptyView()Landroid/view/View;
    .locals 3

    .prologue
    .line 54
    invoke-virtual {p0}, Lcom/cyjh/elfin/fragment/content/BasicLoadStateHttpFragment;->getActivity()Landroid/support/v4/app/FragmentActivity;

    move-result-object v0

    invoke-virtual {v0}, Landroid/support/v4/app/FragmentActivity;->getApplicationContext()Landroid/content/Context;

    move-result-object v0

    iget-object v1, p0, Lcom/cyjh/elfin/fragment/content/BasicLoadStateHttpFragment;->mContentView:Landroid/view/View;

    const/4 v2, 0x0

    invoke-static {v0, v1, v2}, Lcom/cyjh/elfin/customview/loadstate/LoadstatueViewFactory;->getLoadEmpty(Landroid/content/Context;Landroid/view/View;Landroid/view/View$OnClickListener;)Landroid/view/View;

    move-result-object v0

    return-object v0
.end method

.method public getLoadFailedView()Landroid/view/View;
    .locals 3

    .prologue
    .line 48
    invoke-virtual {p0}, Lcom/cyjh/elfin/fragment/content/BasicLoadStateHttpFragment;->getActivity()Landroid/support/v4/app/FragmentActivity;

    move-result-object v0

    invoke-virtual {v0}, Landroid/support/v4/app/FragmentActivity;->getApplicationContext()Landroid/content/Context;

    move-result-object v0

    iget-object v1, p0, Lcom/cyjh/elfin/fragment/content/BasicLoadStateHttpFragment;->mContentView:Landroid/view/View;

    const/4 v2, 0x0

    invoke-static {v0, v1, v2}, Lcom/cyjh/elfin/customview/loadstate/LoadstatueViewFactory;->getLoadFailed(Landroid/content/Context;Landroid/view/View;Landroid/view/View$OnClickListener;)Landroid/view/View;

    move-result-object v0

    return-object v0
.end method

.method public getLoadingView()Landroid/view/View;
    .locals 2

    .prologue
    .line 42
    invoke-virtual {p0}, Lcom/cyjh/elfin/fragment/content/BasicLoadStateHttpFragment;->getActivity()Landroid/support/v4/app/FragmentActivity;

    move-result-object v0

    invoke-virtual {v0}, Landroid/support/v4/app/FragmentActivity;->getApplicationContext()Landroid/content/Context;

    move-result-object v0

    iget-object v1, p0, Lcom/cyjh/elfin/fragment/content/BasicLoadStateHttpFragment;->mContentView:Landroid/view/View;

    invoke-static {v0, v1}, Lcom/cyjh/elfin/customview/loadstate/LoadstatueViewFactory;->getLoadingView(Landroid/content/Context;Landroid/view/View;)Landroid/view/View;

    move-result-object v0

    return-object v0
.end method

.method public getNotNetworkView()Landroid/view/View;
    .locals 3

    .prologue
    .line 60
    invoke-virtual {p0}, Lcom/cyjh/elfin/fragment/content/BasicLoadStateHttpFragment;->getActivity()Landroid/support/v4/app/FragmentActivity;

    move-result-object v0

    invoke-virtual {v0}, Landroid/support/v4/app/FragmentActivity;->getApplicationContext()Landroid/content/Context;

    move-result-object v0

    iget-object v1, p0, Lcom/cyjh/elfin/fragment/content/BasicLoadStateHttpFragment;->mContentView:Landroid/view/View;

    const/4 v2, 0x0

    invoke-static {v0, v1, v2}, Lcom/cyjh/elfin/customview/loadstate/LoadstatueViewFactory;->getLoadNotNetwork(Landroid/content/Context;Landroid/view/View;Landroid/view/View$OnClickListener;)Landroid/view/View;

    move-result-object v0

    return-object v0
.end method

.method public initDataBeforeView()V
    .locals 0

    .prologue
    .line 33
    invoke-super {p0}, Lcom/cyjh/elfin/fragment/content/LoadStateHttpFragment;->initDataBeforeView()V

    .line 34
    return-void
.end method

.method public invalidateViews()V
    .locals 0

    .prologue
    .line 29
    return-void
.end method

.method public loadData(I)V
    .locals 0
    .param p1, "page"    # I

    .prologue
    .line 38
    return-void
.end method

.method public onAttach(Landroid/app/Activity;)V
    .locals 0
    .param p1, "activity"    # Landroid/app/Activity;

    .prologue
    .line 17
    invoke-super {p0, p1}, Lcom/cyjh/elfin/fragment/content/LoadStateHttpFragment;->onAttach(Landroid/app/Activity;)V

    .line 19
    return-void
.end method

.method public onHiddenChanged(Z)V
    .locals 0
    .param p1, "hidden"    # Z

    .prologue
    .line 23
    invoke-super {p0, p1}, Lcom/cyjh/elfin/fragment/content/LoadStateHttpFragment;->onHiddenChanged(Z)V

    .line 25
    return-void
.end method
