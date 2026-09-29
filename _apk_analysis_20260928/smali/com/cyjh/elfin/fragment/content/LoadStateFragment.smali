.class public abstract Lcom/cyjh/elfin/fragment/content/LoadStateFragment;
.super Lcom/cyjh/elfin/fragment/content/CYJHFragment;
.source "LoadStateFragment.java"

# interfaces
.implements Lcom/cyjh/elfin/mvp/views/loadstate/ILoadState;


# instance fields
.field private isInit:Z

.field protected mContentView:Landroid/view/View;

.field private mEmptyView:Landroid/view/View;

.field private mHandler:Landroid/os/Handler;

.field private mLoadFailedView:Landroid/view/View;

.field private mLoadingView:Landroid/view/View;

.field private mNotNewworkView:Landroid/view/View;


# direct methods
.method public constructor <init>()V
    .locals 1

    .prologue
    .line 13
    invoke-direct {p0}, Lcom/cyjh/elfin/fragment/content/CYJHFragment;-><init>()V

    .line 19
    const/4 v0, 0x0

    iput-boolean v0, p0, Lcom/cyjh/elfin/fragment/content/LoadStateFragment;->isInit:Z

    .line 21
    new-instance v0, Lcom/cyjh/elfin/fragment/content/LoadStateFragment$1;

    invoke-direct {v0, p0}, Lcom/cyjh/elfin/fragment/content/LoadStateFragment$1;-><init>(Lcom/cyjh/elfin/fragment/content/LoadStateFragment;)V

    iput-object v0, p0, Lcom/cyjh/elfin/fragment/content/LoadStateFragment;->mHandler:Landroid/os/Handler;

    return-void
.end method

.method static synthetic access$000(Lcom/cyjh/elfin/fragment/content/LoadStateFragment;)Landroid/view/View;
    .locals 1
    .param p0, "x0"    # Lcom/cyjh/elfin/fragment/content/LoadStateFragment;

    .prologue
    .line 13
    iget-object v0, p0, Lcom/cyjh/elfin/fragment/content/LoadStateFragment;->mLoadingView:Landroid/view/View;

    return-object v0
.end method

.method static synthetic access$100(Lcom/cyjh/elfin/fragment/content/LoadStateFragment;)Landroid/view/View;
    .locals 1
    .param p0, "x0"    # Lcom/cyjh/elfin/fragment/content/LoadStateFragment;

    .prologue
    .line 13
    iget-object v0, p0, Lcom/cyjh/elfin/fragment/content/LoadStateFragment;->mLoadFailedView:Landroid/view/View;

    return-object v0
.end method

.method static synthetic access$200(Lcom/cyjh/elfin/fragment/content/LoadStateFragment;)Landroid/view/View;
    .locals 1
    .param p0, "x0"    # Lcom/cyjh/elfin/fragment/content/LoadStateFragment;

    .prologue
    .line 13
    iget-object v0, p0, Lcom/cyjh/elfin/fragment/content/LoadStateFragment;->mNotNewworkView:Landroid/view/View;

    return-object v0
.end method

.method static synthetic access$300(Lcom/cyjh/elfin/fragment/content/LoadStateFragment;)Landroid/view/View;
    .locals 1
    .param p0, "x0"    # Lcom/cyjh/elfin/fragment/content/LoadStateFragment;

    .prologue
    .line 13
    iget-object v0, p0, Lcom/cyjh/elfin/fragment/content/LoadStateFragment;->mEmptyView:Landroid/view/View;

    return-object v0
.end method


# virtual methods
.method public initStateViews()V
    .locals 1

    .prologue
    .line 81
    iget-boolean v0, p0, Lcom/cyjh/elfin/fragment/content/LoadStateFragment;->isInit:Z

    if-eqz v0, :cond_0

    .line 89
    :goto_0
    return-void

    .line 83
    :cond_0
    invoke-virtual {p0}, Lcom/cyjh/elfin/fragment/content/LoadStateFragment;->getContentView()Landroid/view/View;

    move-result-object v0

    iput-object v0, p0, Lcom/cyjh/elfin/fragment/content/LoadStateFragment;->mContentView:Landroid/view/View;

    .line 84
    invoke-virtual {p0}, Lcom/cyjh/elfin/fragment/content/LoadStateFragment;->getLoadingView()Landroid/view/View;

    move-result-object v0

    iput-object v0, p0, Lcom/cyjh/elfin/fragment/content/LoadStateFragment;->mLoadingView:Landroid/view/View;

    .line 85
    invoke-virtual {p0}, Lcom/cyjh/elfin/fragment/content/LoadStateFragment;->getLoadFailedView()Landroid/view/View;

    move-result-object v0

    iput-object v0, p0, Lcom/cyjh/elfin/fragment/content/LoadStateFragment;->mLoadFailedView:Landroid/view/View;

    .line 86
    invoke-virtual {p0}, Lcom/cyjh/elfin/fragment/content/LoadStateFragment;->getEmptyView()Landroid/view/View;

    move-result-object v0

    iput-object v0, p0, Lcom/cyjh/elfin/fragment/content/LoadStateFragment;->mEmptyView:Landroid/view/View;

    .line 87
    invoke-virtual {p0}, Lcom/cyjh/elfin/fragment/content/LoadStateFragment;->getNotNetworkView()Landroid/view/View;

    move-result-object v0

    iput-object v0, p0, Lcom/cyjh/elfin/fragment/content/LoadStateFragment;->mNotNewworkView:Landroid/view/View;

    .line 88
    const/4 v0, 0x1

    iput-boolean v0, p0, Lcom/cyjh/elfin/fragment/content/LoadStateFragment;->isInit:Z

    goto :goto_0
.end method

.method public abstract invalidateViews()V
.end method

.method public onCreateView(Landroid/view/LayoutInflater;Landroid/view/ViewGroup;Landroid/os/Bundle;)Landroid/view/View;
    .locals 1
    .param p1, "inflater"    # Landroid/view/LayoutInflater;
    .param p2, "container"    # Landroid/view/ViewGroup;
    .param p3, "savedInstanceState"    # Landroid/os/Bundle;

    .prologue
    .line 75
    invoke-super {p0, p1, p2, p3}, Lcom/cyjh/elfin/fragment/content/CYJHFragment;->onCreateView(Landroid/view/LayoutInflater;Landroid/view/ViewGroup;Landroid/os/Bundle;)Landroid/view/View;

    move-result-object v0

    .line 76
    .local v0, "view":Landroid/view/View;
    invoke-virtual {p0}, Lcom/cyjh/elfin/fragment/content/LoadStateFragment;->initStateViews()V

    .line 77
    return-object v0
.end method

.method public onLoadEmpty()V
    .locals 2

    .prologue
    .line 109
    iget-object v0, p0, Lcom/cyjh/elfin/fragment/content/LoadStateFragment;->mHandler:Landroid/os/Handler;

    const/4 v1, 0x1

    invoke-virtual {v0, v1}, Landroid/os/Handler;->sendEmptyMessage(I)Z

    .line 110
    return-void
.end method

.method public onLoadFailed()V
    .locals 2

    .prologue
    .line 104
    iget-object v0, p0, Lcom/cyjh/elfin/fragment/content/LoadStateFragment;->mHandler:Landroid/os/Handler;

    const/4 v1, 0x2

    invoke-virtual {v0, v1}, Landroid/os/Handler;->sendEmptyMessage(I)Z

    .line 105
    return-void
.end method

.method public onLoadNotNetwork()V
    .locals 2

    .prologue
    .line 119
    iget-object v0, p0, Lcom/cyjh/elfin/fragment/content/LoadStateFragment;->mHandler:Landroid/os/Handler;

    const/4 v1, 0x4

    invoke-virtual {v0, v1}, Landroid/os/Handler;->sendEmptyMessage(I)Z

    .line 120
    return-void
.end method

.method public onLoadStart()V
    .locals 2

    .prologue
    .line 99
    iget-object v0, p0, Lcom/cyjh/elfin/fragment/content/LoadStateFragment;->mHandler:Landroid/os/Handler;

    const/4 v1, 0x0

    invoke-virtual {v0, v1}, Landroid/os/Handler;->sendEmptyMessage(I)Z

    .line 100
    return-void
.end method

.method public onLoadSuccess()V
    .locals 2

    .prologue
    .line 114
    iget-object v0, p0, Lcom/cyjh/elfin/fragment/content/LoadStateFragment;->mHandler:Landroid/os/Handler;

    const/4 v1, 0x3

    invoke-virtual {v0, v1}, Landroid/os/Handler;->sendEmptyMessage(I)Z

    .line 115
    return-void
.end method
