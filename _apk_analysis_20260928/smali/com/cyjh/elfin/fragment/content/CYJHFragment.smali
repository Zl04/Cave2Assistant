.class public abstract Lcom/cyjh/elfin/fragment/content/CYJHFragment;
.super Landroid/support/v4/app/Fragment;
.source "CYJHFragment.java"

# interfaces
.implements Lcom/cyjh/elfin/fragment/content/IFragmentView;


# direct methods
.method public constructor <init>()V
    .locals 0

    .prologue
    .line 16
    invoke-direct {p0}, Landroid/support/v4/app/Fragment;-><init>()V

    return-void
.end method


# virtual methods
.method public initActionbar()V
    .locals 0

    .prologue
    .line 37
    return-void
.end method

.method public initDataBeforeView()V
    .locals 0

    .prologue
    .line 34
    return-void
.end method

.method public onCreate(Landroid/os/Bundle;)V
    .locals 0
    .param p1, "savedInstanceState"    # Landroid/os/Bundle;

    .prologue
    .line 29
    invoke-super {p0, p1}, Landroid/support/v4/app/Fragment;->onCreate(Landroid/os/Bundle;)V

    .line 30
    invoke-virtual {p0}, Lcom/cyjh/elfin/fragment/content/CYJHFragment;->initDataBeforeView()V

    .line 31
    return-void
.end method

.method public onCreateView(Landroid/view/LayoutInflater;Landroid/view/ViewGroup;Landroid/os/Bundle;)Landroid/view/View;
    .locals 1
    .param p1, "inflater"    # Landroid/view/LayoutInflater;
    .param p2, "container"    # Landroid/view/ViewGroup;
    .param p3, "savedInstanceState"    # Landroid/os/Bundle;

    .prologue
    .line 20
    invoke-virtual {p0, p1, p2, p3}, Lcom/cyjh/elfin/fragment/content/CYJHFragment;->initView(Landroid/view/LayoutInflater;Landroid/view/ViewGroup;Landroid/os/Bundle;)Landroid/view/View;

    move-result-object v0

    .line 21
    .local v0, "view":Landroid/view/View;
    invoke-virtual {p0}, Lcom/cyjh/elfin/fragment/content/CYJHFragment;->initDataAfterView()V

    .line 22
    invoke-virtual {p0}, Lcom/cyjh/elfin/fragment/content/CYJHFragment;->initListener()V

    .line 23
    invoke-virtual {p0}, Lcom/cyjh/elfin/fragment/content/CYJHFragment;->initActionbar()V

    .line 24
    return-object v0
.end method
