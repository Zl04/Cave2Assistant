.class public abstract Lcom/cyjh/elfin/listener/OnClickerNetworkListener;
.super Lcom/cyjh/elfin/clicker/BaseOnClicker;
.source "OnClickerNetworkListener.java"


# direct methods
.method public constructor <init>()V
    .locals 0

    .prologue
    .line 12
    invoke-direct {p0}, Lcom/cyjh/elfin/clicker/BaseOnClicker;-><init>()V

    return-void
.end method


# virtual methods
.method public onClick(Landroid/view/View;)V
    .locals 2
    .param p1, "view"    # Landroid/view/View;

    .prologue
    .line 16
    invoke-super {p0, p1}, Lcom/cyjh/elfin/clicker/BaseOnClicker;->onClick(Landroid/view/View;)V

    .line 17
    invoke-virtual {p1}, Landroid/view/View;->getContext()Landroid/content/Context;

    move-result-object v1

    invoke-static {v1}, Lcom/cyjh/elfin/util/NetworkUtils;->isAvailable(Landroid/content/Context;)Z

    move-result v0

    .line 18
    .local v0, "isConnection":Z
    if-eqz v0, :cond_0

    .line 19
    invoke-virtual {p0, p1}, Lcom/cyjh/elfin/listener/OnClickerNetworkListener;->onNetworkListener(Landroid/view/View;)V

    .line 23
    :goto_0
    return-void

    .line 21
    :cond_0
    invoke-virtual {p0, p1}, Lcom/cyjh/elfin/listener/OnClickerNetworkListener;->onNoNetworkListener(Landroid/view/View;)V

    goto :goto_0
.end method

.method public abstract onNetworkListener(Landroid/view/View;)V
.end method

.method public abstract onNoNetworkListener(Landroid/view/View;)V
.end method
