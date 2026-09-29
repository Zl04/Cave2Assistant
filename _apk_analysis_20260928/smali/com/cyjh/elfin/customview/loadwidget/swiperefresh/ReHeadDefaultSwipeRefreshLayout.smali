.class public abstract Lcom/cyjh/elfin/customview/loadwidget/swiperefresh/ReHeadDefaultSwipeRefreshLayout;
.super Lcom/cyjh/elfin/customview/loadwidget/swiperefresh/ReDefaultSwipeRefreshLayout;
.source "ReHeadDefaultSwipeRefreshLayout.java"


# annotations
.annotation system Ldalvik/annotation/Signature;
    value = {
        "<T:",
        "Ljava/lang/Object;",
        ">",
        "Lcom/cyjh/elfin/customview/loadwidget/swiperefresh/ReDefaultSwipeRefreshLayout;"
    }
.end annotation


# direct methods
.method public constructor <init>(Landroid/content/Context;Landroid/util/AttributeSet;)V
    .locals 0
    .param p1, "context"    # Landroid/content/Context;
    .param p2, "attrs"    # Landroid/util/AttributeSet;

    .prologue
    .line 18
    .local p0, "this":Lcom/cyjh/elfin/customview/loadwidget/swiperefresh/ReHeadDefaultSwipeRefreshLayout;, "Lcom/cyjh/elfin/customview/loadwidget/swiperefresh/ReHeadDefaultSwipeRefreshLayout<TT;>;"
    invoke-direct {p0, p1, p2}, Lcom/cyjh/elfin/customview/loadwidget/swiperefresh/ReDefaultSwipeRefreshLayout;-><init>(Landroid/content/Context;Landroid/util/AttributeSet;)V

    .line 19
    return-void
.end method


# virtual methods
.method public canChildScrollUp()Z
    .locals 5

    .prologue
    .local p0, "this":Lcom/cyjh/elfin/customview/loadwidget/swiperefresh/ReHeadDefaultSwipeRefreshLayout;, "Lcom/cyjh/elfin/customview/loadwidget/swiperefresh/ReHeadDefaultSwipeRefreshLayout<TT;>;"
    const/4 v1, 0x1

    const/4 v2, 0x0

    .line 23
    sget v3, Landroid/os/Build$VERSION;->SDK_INT:I

    const/16 v4, 0xe

    if-ge v3, v4, :cond_3

    .line 24
    iget-object v3, p0, Lcom/cyjh/elfin/customview/loadwidget/swiperefresh/ReHeadDefaultSwipeRefreshLayout;->mListView:Lcom/cyjh/elfin/customview/loadwidget/swiperefresh/BaseListView;

    instance-of v3, v3, Landroid/widget/AbsListView;

    if-eqz v3, :cond_2

    .line 25
    iget-object v0, p0, Lcom/cyjh/elfin/customview/loadwidget/swiperefresh/ReHeadDefaultSwipeRefreshLayout;->mListView:Lcom/cyjh/elfin/customview/loadwidget/swiperefresh/BaseListView;

    .line 26
    .local v0, "absListView":Landroid/widget/AbsListView;
    invoke-virtual {v0}, Landroid/widget/AbsListView;->getChildCount()I

    move-result v3

    if-lez v3, :cond_1

    .line 27
    invoke-virtual {v0}, Landroid/widget/AbsListView;->getFirstVisiblePosition()I

    move-result v3

    if-gtz v3, :cond_0

    .line 28
    invoke-virtual {v0, v2}, Landroid/widget/AbsListView;->getChildAt(I)Landroid/view/View;

    move-result-object v3

    invoke-virtual {v3}, Landroid/view/View;->getTop()I

    move-result v3

    .line 29
    invoke-virtual {v0}, Landroid/widget/AbsListView;->getPaddingTop()I

    move-result v4

    if-ge v3, v4, :cond_1

    .line 34
    .end local v0    # "absListView":Landroid/widget/AbsListView;
    :cond_0
    :goto_0
    return v1

    .restart local v0    # "absListView":Landroid/widget/AbsListView;
    :cond_1
    move v1, v2

    .line 29
    goto :goto_0

    .line 31
    .end local v0    # "absListView":Landroid/widget/AbsListView;
    :cond_2
    iget-object v3, p0, Lcom/cyjh/elfin/customview/loadwidget/swiperefresh/ReHeadDefaultSwipeRefreshLayout;->mListView:Lcom/cyjh/elfin/customview/loadwidget/swiperefresh/BaseListView;

    invoke-virtual {v3}, Lcom/cyjh/elfin/customview/loadwidget/swiperefresh/BaseListView;->getScrollY()I

    move-result v3

    if-gtz v3, :cond_0

    move v1, v2

    goto :goto_0

    .line 34
    :cond_3
    iget-object v1, p0, Lcom/cyjh/elfin/customview/loadwidget/swiperefresh/ReHeadDefaultSwipeRefreshLayout;->mListView:Lcom/cyjh/elfin/customview/loadwidget/swiperefresh/BaseListView;

    const/4 v2, -0x1

    invoke-static {v1, v2}, Landroid/support/v4/view/ViewCompat;->canScrollVertically(Landroid/view/View;I)Z

    move-result v1

    goto :goto_0
.end method
