.class public abstract Lcom/cyjh/elfin/customview/loadwidget/swiperefresh/ReDefaultSwipeRefreshLayout;
.super Landroid/support/v4/widget/SwipeRefreshLayout;
.source "ReDefaultSwipeRefreshLayout.java"

# interfaces
.implements Lcom/cyjh/elfin/mvp/views/loadstate/ILoadViewState;


# annotations
.annotation system Ldalvik/annotation/MemberClasses;
    value = {
        Lcom/cyjh/elfin/customview/loadwidget/swiperefresh/ReDefaultSwipeRefreshLayout$TouchCallBackListener;
    }
.end annotation


# instance fields
.field protected mListView:Lcom/cyjh/elfin/customview/loadwidget/swiperefresh/BaseListView;

.field private mPrevX:F

.field private mTouchSlop:I

.field private touchCallBackListener:Lcom/cyjh/elfin/customview/loadwidget/swiperefresh/ReDefaultSwipeRefreshLayout$TouchCallBackListener;


# direct methods
.method public constructor <init>(Landroid/content/Context;Landroid/util/AttributeSet;)V
    .locals 0
    .param p1, "context"    # Landroid/content/Context;
    .param p2, "attrs"    # Landroid/util/AttributeSet;

    .prologue
    .line 35
    invoke-direct {p0, p1, p2}, Landroid/support/v4/widget/SwipeRefreshLayout;-><init>(Landroid/content/Context;Landroid/util/AttributeSet;)V

    .line 37
    return-void
.end method


# virtual methods
.method public addHeaderView(Landroid/view/View;)V
    .locals 1
    .param p1, "headView"    # Landroid/view/View;

    .prologue
    .line 54
    iget-object v0, p0, Lcom/cyjh/elfin/customview/loadwidget/swiperefresh/ReDefaultSwipeRefreshLayout;->mListView:Lcom/cyjh/elfin/customview/loadwidget/swiperefresh/BaseListView;

    invoke-virtual {v0, p1}, Lcom/cyjh/elfin/customview/loadwidget/swiperefresh/BaseListView;->addHeaderView(Landroid/view/View;)V

    .line 56
    return-void
.end method

.method public getListView()Lcom/cyjh/elfin/customview/loadwidget/swiperefresh/BaseListView;
    .locals 1

    .prologue
    .line 45
    iget-object v0, p0, Lcom/cyjh/elfin/customview/loadwidget/swiperefresh/ReDefaultSwipeRefreshLayout;->mListView:Lcom/cyjh/elfin/customview/loadwidget/swiperefresh/BaseListView;

    return-object v0
.end method

.method public abstract init()V
.end method

.method public onInterceptTouchEvent(Landroid/view/MotionEvent;)Z
    .locals 3
    .param p1, "event"    # Landroid/view/MotionEvent;

    .prologue
    .line 135
    invoke-virtual {p1}, Landroid/view/MotionEvent;->getAction()I

    move-result v2

    packed-switch v2, :pswitch_data_0

    .line 151
    :cond_0
    :goto_0
    :pswitch_0
    invoke-super {p0, p1}, Landroid/support/v4/widget/SwipeRefreshLayout;->onInterceptTouchEvent(Landroid/view/MotionEvent;)Z

    move-result v2

    :goto_1
    return v2

    .line 137
    :pswitch_1
    invoke-virtual {p1}, Landroid/view/MotionEvent;->getX()F

    move-result v2

    iput v2, p0, Lcom/cyjh/elfin/customview/loadwidget/swiperefresh/ReDefaultSwipeRefreshLayout;->mPrevX:F

    .line 138
    iget-object v2, p0, Lcom/cyjh/elfin/customview/loadwidget/swiperefresh/ReDefaultSwipeRefreshLayout;->touchCallBackListener:Lcom/cyjh/elfin/customview/loadwidget/swiperefresh/ReDefaultSwipeRefreshLayout$TouchCallBackListener;

    if-eqz v2, :cond_0

    .line 139
    iget-object v2, p0, Lcom/cyjh/elfin/customview/loadwidget/swiperefresh/ReDefaultSwipeRefreshLayout;->touchCallBackListener:Lcom/cyjh/elfin/customview/loadwidget/swiperefresh/ReDefaultSwipeRefreshLayout$TouchCallBackListener;

    invoke-interface {v2}, Lcom/cyjh/elfin/customview/loadwidget/swiperefresh/ReDefaultSwipeRefreshLayout$TouchCallBackListener;->TouchCallBack()V

    goto :goto_0

    .line 144
    :pswitch_2
    invoke-virtual {p1}, Landroid/view/MotionEvent;->getX()F

    move-result v0

    .line 145
    .local v0, "eventX":F
    iget v2, p0, Lcom/cyjh/elfin/customview/loadwidget/swiperefresh/ReDefaultSwipeRefreshLayout;->mPrevX:F

    sub-float v2, v0, v2

    invoke-static {v2}, Ljava/lang/Math;->abs(F)F

    move-result v1

    .line 147
    .local v1, "xDiff":F
    iget v2, p0, Lcom/cyjh/elfin/customview/loadwidget/swiperefresh/ReDefaultSwipeRefreshLayout;->mTouchSlop:I

    add-int/lit8 v2, v2, 0x3c

    int-to-float v2, v2

    cmpl-float v2, v1, v2

    if-lez v2, :cond_0

    .line 148
    const/4 v2, 0x0

    goto :goto_1

    .line 135
    nop

    :pswitch_data_0
    .packed-switch 0x0
        :pswitch_1
        :pswitch_0
        :pswitch_2
    .end packed-switch
.end method

.method public onLoadComplete()V
    .locals 1

    .prologue
    .line 115
    const/4 v0, 0x0

    invoke-virtual {p0, v0}, Lcom/cyjh/elfin/customview/loadwidget/swiperefresh/ReDefaultSwipeRefreshLayout;->setRefreshing(Z)V

    .line 116
    iget-object v0, p0, Lcom/cyjh/elfin/customview/loadwidget/swiperefresh/ReDefaultSwipeRefreshLayout;->mListView:Lcom/cyjh/elfin/customview/loadwidget/swiperefresh/BaseListView;

    invoke-virtual {v0}, Lcom/cyjh/elfin/customview/loadwidget/swiperefresh/BaseListView;->onLoadComplete()V

    .line 117
    return-void
.end method

.method public onLoadEmpty()V
    .locals 1

    .prologue
    .line 121
    const/4 v0, 0x0

    invoke-virtual {p0, v0}, Lcom/cyjh/elfin/customview/loadwidget/swiperefresh/ReDefaultSwipeRefreshLayout;->setRefreshing(Z)V

    .line 122
    iget-object v0, p0, Lcom/cyjh/elfin/customview/loadwidget/swiperefresh/ReDefaultSwipeRefreshLayout;->mListView:Lcom/cyjh/elfin/customview/loadwidget/swiperefresh/BaseListView;

    invoke-virtual {v0}, Lcom/cyjh/elfin/customview/loadwidget/swiperefresh/BaseListView;->onLoadEmpty()V

    .line 123
    return-void
.end method

.method public onLoadFailed()V
    .locals 1

    .prologue
    .line 103
    const/4 v0, 0x0

    invoke-virtual {p0, v0}, Lcom/cyjh/elfin/customview/loadwidget/swiperefresh/ReDefaultSwipeRefreshLayout;->setRefreshing(Z)V

    .line 104
    iget-object v0, p0, Lcom/cyjh/elfin/customview/loadwidget/swiperefresh/ReDefaultSwipeRefreshLayout;->mListView:Lcom/cyjh/elfin/customview/loadwidget/swiperefresh/BaseListView;

    invoke-virtual {v0}, Lcom/cyjh/elfin/customview/loadwidget/swiperefresh/BaseListView;->onLoadFailed()V

    .line 105
    return-void
.end method

.method public onLoadStart()V
    .locals 1

    .prologue
    .line 127
    const/4 v0, 0x0

    invoke-virtual {p0, v0}, Lcom/cyjh/elfin/customview/loadwidget/swiperefresh/ReDefaultSwipeRefreshLayout;->setRefreshing(Z)V

    .line 128
    iget-object v0, p0, Lcom/cyjh/elfin/customview/loadwidget/swiperefresh/ReDefaultSwipeRefreshLayout;->mListView:Lcom/cyjh/elfin/customview/loadwidget/swiperefresh/BaseListView;

    invoke-virtual {v0}, Lcom/cyjh/elfin/customview/loadwidget/swiperefresh/BaseListView;->onLoadStart()V

    .line 130
    return-void
.end method

.method public onLoadSuccess()V
    .locals 1

    .prologue
    .line 109
    const/4 v0, 0x0

    invoke-virtual {p0, v0}, Lcom/cyjh/elfin/customview/loadwidget/swiperefresh/ReDefaultSwipeRefreshLayout;->setRefreshing(Z)V

    .line 110
    iget-object v0, p0, Lcom/cyjh/elfin/customview/loadwidget/swiperefresh/ReDefaultSwipeRefreshLayout;->mListView:Lcom/cyjh/elfin/customview/loadwidget/swiperefresh/BaseListView;

    invoke-virtual {v0}, Lcom/cyjh/elfin/customview/loadwidget/swiperefresh/BaseListView;->onLoadSuccess()V

    .line 111
    return-void
.end method

.method public prepareLoad(II)V
    .locals 1
    .param p1, "pageSize"    # I
    .param p2, "beforLoadNum"    # I

    .prologue
    .line 90
    iget-object v0, p0, Lcom/cyjh/elfin/customview/loadwidget/swiperefresh/ReDefaultSwipeRefreshLayout;->mListView:Lcom/cyjh/elfin/customview/loadwidget/swiperefresh/BaseListView;

    invoke-virtual {v0, p1, p2}, Lcom/cyjh/elfin/customview/loadwidget/swiperefresh/BaseListView;->prepareLoad(II)V

    .line 91
    return-void
.end method

.method public setAdapter(Landroid/widget/BaseAdapter;)V
    .locals 1
    .param p1, "adapter"    # Landroid/widget/BaseAdapter;

    .prologue
    .line 64
    iget-object v0, p0, Lcom/cyjh/elfin/customview/loadwidget/swiperefresh/ReDefaultSwipeRefreshLayout;->mListView:Lcom/cyjh/elfin/customview/loadwidget/swiperefresh/BaseListView;

    invoke-virtual {v0, p1}, Lcom/cyjh/elfin/customview/loadwidget/swiperefresh/BaseListView;->setAdapter(Landroid/widget/ListAdapter;)V

    .line 65
    return-void
.end method

.method public setOnItemClickListener(Landroid/widget/AdapterView$OnItemClickListener;)V
    .locals 1
    .param p1, "clickListener"    # Landroid/widget/AdapterView$OnItemClickListener;

    .prologue
    .line 97
    if-eqz p1, :cond_0

    .line 98
    iget-object v0, p0, Lcom/cyjh/elfin/customview/loadwidget/swiperefresh/ReDefaultSwipeRefreshLayout;->mListView:Lcom/cyjh/elfin/customview/loadwidget/swiperefresh/BaseListView;

    invoke-virtual {v0, p1}, Lcom/cyjh/elfin/customview/loadwidget/swiperefresh/BaseListView;->setOnItemClickListener(Landroid/widget/AdapterView$OnItemClickListener;)V

    .line 99
    :cond_0
    return-void
.end method

.method public setTouchCallBackListener(Lcom/cyjh/elfin/customview/loadwidget/swiperefresh/ReDefaultSwipeRefreshLayout$TouchCallBackListener;)V
    .locals 0
    .param p1, "touchCallBackListener"    # Lcom/cyjh/elfin/customview/loadwidget/swiperefresh/ReDefaultSwipeRefreshLayout$TouchCallBackListener;

    .prologue
    .line 157
    iput-object p1, p0, Lcom/cyjh/elfin/customview/loadwidget/swiperefresh/ReDefaultSwipeRefreshLayout;->touchCallBackListener:Lcom/cyjh/elfin/customview/loadwidget/swiperefresh/ReDefaultSwipeRefreshLayout$TouchCallBackListener;

    .line 158
    return-void
.end method

.method public setUpAndDownRefresh(Lcom/cyjh/elfin/mvp/views/loadstate/IListViewLoadCallBack;Landroid/support/v4/widget/SwipeRefreshLayout$OnRefreshListener;)V
    .locals 1
    .param p1, "callBack"    # Lcom/cyjh/elfin/mvp/views/loadstate/IListViewLoadCallBack;
    .param p2, "onRefreshListener"    # Landroid/support/v4/widget/SwipeRefreshLayout$OnRefreshListener;

    .prologue
    .line 75
    if-eqz p1, :cond_0

    .line 76
    iget-object v0, p0, Lcom/cyjh/elfin/customview/loadwidget/swiperefresh/ReDefaultSwipeRefreshLayout;->mListView:Lcom/cyjh/elfin/customview/loadwidget/swiperefresh/BaseListView;

    invoke-virtual {v0, p1}, Lcom/cyjh/elfin/customview/loadwidget/swiperefresh/BaseListView;->setIListViewCallBack(Lcom/cyjh/elfin/mvp/views/loadstate/IListViewLoadCallBack;)V

    .line 78
    :cond_0
    if-eqz p2, :cond_1

    .line 79
    invoke-virtual {p0, p2}, Lcom/cyjh/elfin/customview/loadwidget/swiperefresh/ReDefaultSwipeRefreshLayout;->setOnRefreshListener(Landroid/support/v4/widget/SwipeRefreshLayout$OnRefreshListener;)V

    .line 81
    :cond_1
    return-void
.end method
