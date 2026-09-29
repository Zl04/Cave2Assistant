.class public abstract Lcom/cyjh/elfin/fragment/content/LoadStateHttpFragment;
.super Lcom/cyjh/elfin/fragment/content/LoadStateFragment;
.source "LoadStateHttpFragment.java"

# interfaces
.implements Lcom/cyjh/elfin/mvp/views/loadstate/ILazyLoad;


# instance fields
.field private isLoad:Z


# direct methods
.method public constructor <init>()V
    .locals 1

    .prologue
    .line 11
    invoke-direct {p0}, Lcom/cyjh/elfin/fragment/content/LoadStateFragment;-><init>()V

    .line 14
    const/4 v0, 0x1

    iput-boolean v0, p0, Lcom/cyjh/elfin/fragment/content/LoadStateHttpFragment;->isLoad:Z

    return-void
.end method


# virtual methods
.method public firstdata()Z
    .locals 2

    .prologue
    const/4 v0, 0x1

    .line 36
    iget-boolean v1, p0, Lcom/cyjh/elfin/fragment/content/LoadStateHttpFragment;->isLoad:Z

    if-eqz v1, :cond_0

    .line 37
    invoke-virtual {p0}, Lcom/cyjh/elfin/fragment/content/LoadStateHttpFragment;->onLoadStart()V

    .line 38
    invoke-virtual {p0, v0}, Lcom/cyjh/elfin/fragment/content/LoadStateHttpFragment;->loadData(I)V

    .line 41
    :goto_0
    return v0

    :cond_0
    const/4 v0, 0x0

    goto :goto_0
.end method

.method public onLoadEmpty()V
    .locals 1

    .prologue
    .line 30
    const/4 v0, 0x1

    iput-boolean v0, p0, Lcom/cyjh/elfin/fragment/content/LoadStateHttpFragment;->isLoad:Z

    .line 31
    invoke-super {p0}, Lcom/cyjh/elfin/fragment/content/LoadStateFragment;->onLoadEmpty()V

    .line 32
    return-void
.end method

.method public onLoadFailed()V
    .locals 1

    .prologue
    .line 24
    const/4 v0, 0x1

    iput-boolean v0, p0, Lcom/cyjh/elfin/fragment/content/LoadStateHttpFragment;->isLoad:Z

    .line 25
    invoke-super {p0}, Lcom/cyjh/elfin/fragment/content/LoadStateFragment;->onLoadFailed()V

    .line 26
    return-void
.end method

.method public onLoadSuccess()V
    .locals 1

    .prologue
    .line 18
    const/4 v0, 0x0

    iput-boolean v0, p0, Lcom/cyjh/elfin/fragment/content/LoadStateHttpFragment;->isLoad:Z

    .line 19
    invoke-super {p0}, Lcom/cyjh/elfin/fragment/content/LoadStateFragment;->onLoadSuccess()V

    .line 20
    return-void
.end method
