.class public Lcom/cyjh/elfin/customview/loadwidget/swiperefresh/FindSwipeRefreshLayout;
.super Lcom/cyjh/elfin/customview/loadwidget/swiperefresh/ReHeadDefaultSwipeRefreshLayout;
.source "FindSwipeRefreshLayout.java"


# direct methods
.method public constructor <init>(Landroid/content/Context;Landroid/util/AttributeSet;)V
    .locals 0
    .param p1, "context"    # Landroid/content/Context;
    .param p2, "attrs"    # Landroid/util/AttributeSet;

    .prologue
    .line 16
    invoke-direct {p0, p1, p2}, Lcom/cyjh/elfin/customview/loadwidget/swiperefresh/ReHeadDefaultSwipeRefreshLayout;-><init>(Landroid/content/Context;Landroid/util/AttributeSet;)V

    .line 17
    return-void
.end method


# virtual methods
.method public init()V
    .locals 4

    .prologue
    .line 21
    const/4 v1, 0x1

    new-array v1, v1, [I

    const/4 v2, 0x0

    const v3, 0x7f0e0012

    aput v3, v1, v2

    invoke-virtual {p0, v1}, Lcom/cyjh/elfin/customview/loadwidget/swiperefresh/FindSwipeRefreshLayout;->setColorSchemeResources([I)V

    .line 22
    const v1, 0x7f0f0185

    invoke-virtual {p0, v1}, Lcom/cyjh/elfin/customview/loadwidget/swiperefresh/FindSwipeRefreshLayout;->findViewById(I)Landroid/view/View;

    move-result-object v1

    check-cast v1, Lcom/cyjh/elfin/customview/loadwidget/swiperefresh/BaseListView;

    iput-object v1, p0, Lcom/cyjh/elfin/customview/loadwidget/swiperefresh/FindSwipeRefreshLayout;->mListView:Lcom/cyjh/elfin/customview/loadwidget/swiperefresh/BaseListView;

    .line 23
    new-instance v0, Lcom/cyjh/elfin/customview/loadwidget/swiperefresh/FootView;

    invoke-virtual {p0}, Lcom/cyjh/elfin/customview/loadwidget/swiperefresh/FindSwipeRefreshLayout;->getContext()Landroid/content/Context;

    move-result-object v1

    invoke-direct {v0, v1}, Lcom/cyjh/elfin/customview/loadwidget/swiperefresh/FootView;-><init>(Landroid/content/Context;)V

    .line 24
    .local v0, "footView":Lcom/cyjh/elfin/customview/loadwidget/swiperefresh/FootView;
    iget-object v1, p0, Lcom/cyjh/elfin/customview/loadwidget/swiperefresh/FindSwipeRefreshLayout;->mListView:Lcom/cyjh/elfin/customview/loadwidget/swiperefresh/BaseListView;

    invoke-virtual {v1, v0}, Lcom/cyjh/elfin/customview/loadwidget/swiperefresh/BaseListView;->addBaseFootView(Landroid/view/View;)V

    .line 25
    return-void
.end method
