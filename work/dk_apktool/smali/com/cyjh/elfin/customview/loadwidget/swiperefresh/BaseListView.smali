.class public Lcom/cyjh/elfin/customview/loadwidget/swiperefresh/BaseListView;
.super Landroid/widget/ListView;
.source "BaseListView.java"

# interfaces
.implements Landroid/widget/AbsListView$OnScrollListener;
.implements Lcom/cyjh/elfin/mvp/views/loadstate/ILoadViewState;


# annotations
.annotation system Ldalvik/annotation/MemberClasses;
    value = {
        Lcom/cyjh/elfin/customview/loadwidget/swiperefresh/BaseListView$ListViewScrollListener;
    }
.end annotation


# static fields
.field private static befor_load_num:I


# instance fields
.field private iScrollState:I

.field private isScrollLoad:Z

.field private mCallBack:Lcom/cyjh/elfin/mvp/views/loadstate/IListViewLoadCallBack;

.field private mFootView:Lcom/cyjh/elfin/customview/loadwidget/swiperefresh/BaseFootView;

.field private mListViewScrollListener:Lcom/cyjh/elfin/customview/loadwidget/swiperefresh/BaseListView$ListViewScrollListener;

.field private mPageSize:I

.field private mStatueEnum:Lcom/cyjh/elfin/mvp/views/loadstate/LoadStatueEnum;

.field private mTotalItemCount:I

.field private mVisibledCount:I


# direct methods
.method static constructor <clinit>()V
    .locals 1

    .prologue
    .line 34
    const/4 v0, 0x5

    sput v0, Lcom/cyjh/elfin/customview/loadwidget/swiperefresh/BaseListView;->befor_load_num:I

    return-void
.end method

.method public constructor <init>(Landroid/content/Context;)V
    .locals 1
    .param p1, "context"    # Landroid/content/Context;

    .prologue
    .line 70
    invoke-direct {p0, p1}, Landroid/widget/ListView;-><init>(Landroid/content/Context;)V

    .line 25
    const/4 v0, 0x0

    iput-boolean v0, p0, Lcom/cyjh/elfin/customview/loadwidget/swiperefresh/BaseListView;->isScrollLoad:Z

    .line 29
    sget-object v0, Lcom/cyjh/elfin/mvp/views/loadstate/LoadStatueEnum;->NON:Lcom/cyjh/elfin/mvp/views/loadstate/LoadStatueEnum;

    iput-object v0, p0, Lcom/cyjh/elfin/customview/loadwidget/swiperefresh/BaseListView;->mStatueEnum:Lcom/cyjh/elfin/mvp/views/loadstate/LoadStatueEnum;

    .line 30
    const/16 v0, 0xa

    iput v0, p0, Lcom/cyjh/elfin/customview/loadwidget/swiperefresh/BaseListView;->mPageSize:I

    .line 71
    invoke-direct {p0}, Lcom/cyjh/elfin/customview/loadwidget/swiperefresh/BaseListView;->init()V

    .line 72
    return-void
.end method

.method public constructor <init>(Landroid/content/Context;Landroid/util/AttributeSet;)V
    .locals 1
    .param p1, "context"    # Landroid/content/Context;
    .param p2, "attrs"    # Landroid/util/AttributeSet;

    .prologue
    .line 65
    invoke-direct {p0, p1, p2}, Landroid/widget/ListView;-><init>(Landroid/content/Context;Landroid/util/AttributeSet;)V

    .line 25
    const/4 v0, 0x0

    iput-boolean v0, p0, Lcom/cyjh/elfin/customview/loadwidget/swiperefresh/BaseListView;->isScrollLoad:Z

    .line 29
    sget-object v0, Lcom/cyjh/elfin/mvp/views/loadstate/LoadStatueEnum;->NON:Lcom/cyjh/elfin/mvp/views/loadstate/LoadStatueEnum;

    iput-object v0, p0, Lcom/cyjh/elfin/customview/loadwidget/swiperefresh/BaseListView;->mStatueEnum:Lcom/cyjh/elfin/mvp/views/loadstate/LoadStatueEnum;

    .line 30
    const/16 v0, 0xa

    iput v0, p0, Lcom/cyjh/elfin/customview/loadwidget/swiperefresh/BaseListView;->mPageSize:I

    .line 66
    invoke-direct {p0}, Lcom/cyjh/elfin/customview/loadwidget/swiperefresh/BaseListView;->init()V

    .line 67
    return-void
.end method

.method public constructor <init>(Landroid/content/Context;Landroid/util/AttributeSet;I)V
    .locals 1
    .param p1, "context"    # Landroid/content/Context;
    .param p2, "attrs"    # Landroid/util/AttributeSet;
    .param p3, "defStyleAttr"    # I

    .prologue
    .line 60
    invoke-direct {p0, p1, p2, p3}, Landroid/widget/ListView;-><init>(Landroid/content/Context;Landroid/util/AttributeSet;I)V

    .line 25
    const/4 v0, 0x0

    iput-boolean v0, p0, Lcom/cyjh/elfin/customview/loadwidget/swiperefresh/BaseListView;->isScrollLoad:Z

    .line 29
    sget-object v0, Lcom/cyjh/elfin/mvp/views/loadstate/LoadStatueEnum;->NON:Lcom/cyjh/elfin/mvp/views/loadstate/LoadStatueEnum;

    iput-object v0, p0, Lcom/cyjh/elfin/customview/loadwidget/swiperefresh/BaseListView;->mStatueEnum:Lcom/cyjh/elfin/mvp/views/loadstate/LoadStatueEnum;

    .line 30
    const/16 v0, 0xa

    iput v0, p0, Lcom/cyjh/elfin/customview/loadwidget/swiperefresh/BaseListView;->mPageSize:I

    .line 61
    invoke-direct {p0}, Lcom/cyjh/elfin/customview/loadwidget/swiperefresh/BaseListView;->init()V

    .line 62
    return-void
.end method

.method private init()V
    .locals 0

    .prologue
    .line 78
    invoke-virtual {p0, p0}, Lcom/cyjh/elfin/customview/loadwidget/swiperefresh/BaseListView;->setOnScrollListener(Landroid/widget/AbsListView$OnScrollListener;)V

    .line 79
    return-void
.end method

.method private scollLoadData()V
    .locals 3

    .prologue
    .line 167
    iget v1, p0, Lcom/cyjh/elfin/customview/loadwidget/swiperefresh/BaseListView;->iScrollState:I

    if-nez v1, :cond_1

    .line 177
    :cond_0
    :goto_0
    return-void

    .line 171
    :cond_1
    iget v1, p0, Lcom/cyjh/elfin/customview/loadwidget/swiperefresh/BaseListView;->mTotalItemCount:I

    iget v2, p0, Lcom/cyjh/elfin/customview/loadwidget/swiperefresh/BaseListView;->mVisibledCount:I

    sub-int/2addr v1, v2

    sget v2, Lcom/cyjh/elfin/customview/loadwidget/swiperefresh/BaseListView;->befor_load_num:I

    if-ge v1, v2, :cond_2

    const/4 v0, 0x1

    .line 173
    .local v0, "isLoad":Z
    :goto_1
    if-eqz v0, :cond_0

    .line 174
    invoke-virtual {p0}, Lcom/cyjh/elfin/customview/loadwidget/swiperefresh/BaseListView;->loadData()V

    goto :goto_0

    .line 171
    .end local v0    # "isLoad":Z
    :cond_2
    const/4 v0, 0x0

    goto :goto_1
.end method


# virtual methods
.method public addBaseFootView(Landroid/view/View;)V
    .locals 2
    .param p1, "v"    # Landroid/view/View;

    .prologue
    .line 97
    const/4 v0, 0x0

    const/4 v1, 0x0

    invoke-virtual {p0, p1, v0, v1}, Lcom/cyjh/elfin/customview/loadwidget/swiperefresh/BaseListView;->addFooterView(Landroid/view/View;Ljava/lang/Object;Z)V

    .line 98
    return-void
.end method

.method public addFooterView(Landroid/view/View;Ljava/lang/Object;Z)V
    .locals 2
    .param p1, "v"    # Landroid/view/View;
    .param p2, "data"    # Ljava/lang/Object;
    .param p3, "isSelectable"    # Z

    .prologue
    .line 102
    instance-of v0, p1, Lcom/cyjh/elfin/customview/loadwidget/swiperefresh/BaseFootView;

    if-eqz v0, :cond_0

    iget-object v0, p0, Lcom/cyjh/elfin/customview/loadwidget/swiperefresh/BaseListView;->mFootView:Lcom/cyjh/elfin/customview/loadwidget/swiperefresh/BaseFootView;

    if-nez v0, :cond_0

    move-object v0, p1

    .line 103
    check-cast v0, Lcom/cyjh/elfin/customview/loadwidget/swiperefresh/BaseFootView;

    iput-object v0, p0, Lcom/cyjh/elfin/customview/loadwidget/swiperefresh/BaseListView;->mFootView:Lcom/cyjh/elfin/customview/loadwidget/swiperefresh/BaseFootView;

    .line 104
    iget-object v0, p0, Lcom/cyjh/elfin/customview/loadwidget/swiperefresh/BaseListView;->mFootView:Lcom/cyjh/elfin/customview/loadwidget/swiperefresh/BaseFootView;

    iget-object v1, p0, Lcom/cyjh/elfin/customview/loadwidget/swiperefresh/BaseListView;->mCallBack:Lcom/cyjh/elfin/mvp/views/loadstate/IListViewLoadCallBack;

    invoke-virtual {v0, v1}, Lcom/cyjh/elfin/customview/loadwidget/swiperefresh/BaseFootView;->setCallBack(Lcom/cyjh/elfin/mvp/views/loadstate/IListViewLoadCallBack;)V

    .line 106
    :cond_0
    invoke-super {p0, p1, p2, p3}, Landroid/widget/ListView;->addFooterView(Landroid/view/View;Ljava/lang/Object;Z)V

    .line 107
    return-void
.end method

.method public getFootView()Lcom/cyjh/elfin/customview/loadwidget/swiperefresh/BaseFootView;
    .locals 1

    .prologue
    .line 254
    iget-object v0, p0, Lcom/cyjh/elfin/customview/loadwidget/swiperefresh/BaseListView;->mFootView:Lcom/cyjh/elfin/customview/loadwidget/swiperefresh/BaseFootView;

    return-object v0
.end method

.method public getPageSize()I
    .locals 1

    .prologue
    .line 230
    iget v0, p0, Lcom/cyjh/elfin/customview/loadwidget/swiperefresh/BaseListView;->mPageSize:I

    return v0
.end method

.method public isScrollLoad()Z
    .locals 1

    .prologue
    .line 234
    iget-boolean v0, p0, Lcom/cyjh/elfin/customview/loadwidget/swiperefresh/BaseListView;->isScrollLoad:Z

    return v0
.end method

.method public loadData()V
    .locals 2

    .prologue
    .line 223
    iget-object v0, p0, Lcom/cyjh/elfin/customview/loadwidget/swiperefresh/BaseListView;->mCallBack:Lcom/cyjh/elfin/mvp/views/loadstate/IListViewLoadCallBack;

    if-eqz v0, :cond_0

    iget-object v0, p0, Lcom/cyjh/elfin/customview/loadwidget/swiperefresh/BaseListView;->mStatueEnum:Lcom/cyjh/elfin/mvp/views/loadstate/LoadStatueEnum;

    sget-object v1, Lcom/cyjh/elfin/mvp/views/loadstate/LoadStatueEnum;->LOADING:Lcom/cyjh/elfin/mvp/views/loadstate/LoadStatueEnum;

    if-eq v0, v1, :cond_0

    .line 224
    sget-object v0, Lcom/cyjh/elfin/mvp/views/loadstate/LoadStatueEnum;->LOADING:Lcom/cyjh/elfin/mvp/views/loadstate/LoadStatueEnum;

    iput-object v0, p0, Lcom/cyjh/elfin/customview/loadwidget/swiperefresh/BaseListView;->mStatueEnum:Lcom/cyjh/elfin/mvp/views/loadstate/LoadStatueEnum;

    .line 225
    iget-object v0, p0, Lcom/cyjh/elfin/customview/loadwidget/swiperefresh/BaseListView;->mCallBack:Lcom/cyjh/elfin/mvp/views/loadstate/IListViewLoadCallBack;

    invoke-interface {v0}, Lcom/cyjh/elfin/mvp/views/loadstate/IListViewLoadCallBack;->loadNextPage()V

    .line 227
    :cond_0
    return-void
.end method

.method public onLoadComplete()V
    .locals 1

    .prologue
    .line 197
    sget-object v0, Lcom/cyjh/elfin/mvp/views/loadstate/LoadStatueEnum;->COMPLETE:Lcom/cyjh/elfin/mvp/views/loadstate/LoadStatueEnum;

    iput-object v0, p0, Lcom/cyjh/elfin/customview/loadwidget/swiperefresh/BaseListView;->mStatueEnum:Lcom/cyjh/elfin/mvp/views/loadstate/LoadStatueEnum;

    .line 198
    iget-object v0, p0, Lcom/cyjh/elfin/customview/loadwidget/swiperefresh/BaseListView;->mFootView:Lcom/cyjh/elfin/customview/loadwidget/swiperefresh/BaseFootView;

    if-eqz v0, :cond_0

    .line 199
    iget-object v0, p0, Lcom/cyjh/elfin/customview/loadwidget/swiperefresh/BaseListView;->mFootView:Lcom/cyjh/elfin/customview/loadwidget/swiperefresh/BaseFootView;

    invoke-virtual {v0}, Lcom/cyjh/elfin/customview/loadwidget/swiperefresh/BaseFootView;->onLoadComplete()V

    .line 201
    :cond_0
    return-void
.end method

.method public onLoadEmpty()V
    .locals 1

    .prologue
    .line 205
    sget-object v0, Lcom/cyjh/elfin/mvp/views/loadstate/LoadStatueEnum;->EMPTY:Lcom/cyjh/elfin/mvp/views/loadstate/LoadStatueEnum;

    iput-object v0, p0, Lcom/cyjh/elfin/customview/loadwidget/swiperefresh/BaseListView;->mStatueEnum:Lcom/cyjh/elfin/mvp/views/loadstate/LoadStatueEnum;

    .line 206
    iget-object v0, p0, Lcom/cyjh/elfin/customview/loadwidget/swiperefresh/BaseListView;->mFootView:Lcom/cyjh/elfin/customview/loadwidget/swiperefresh/BaseFootView;

    if-eqz v0, :cond_0

    .line 207
    iget-object v0, p0, Lcom/cyjh/elfin/customview/loadwidget/swiperefresh/BaseListView;->mFootView:Lcom/cyjh/elfin/customview/loadwidget/swiperefresh/BaseFootView;

    invoke-virtual {v0}, Lcom/cyjh/elfin/customview/loadwidget/swiperefresh/BaseFootView;->onLoadEmpty()V

    .line 209
    :cond_0
    return-void
.end method

.method public onLoadFailed()V
    .locals 1

    .prologue
    .line 181
    sget-object v0, Lcom/cyjh/elfin/mvp/views/loadstate/LoadStatueEnum;->FAILED:Lcom/cyjh/elfin/mvp/views/loadstate/LoadStatueEnum;

    iput-object v0, p0, Lcom/cyjh/elfin/customview/loadwidget/swiperefresh/BaseListView;->mStatueEnum:Lcom/cyjh/elfin/mvp/views/loadstate/LoadStatueEnum;

    .line 182
    iget-object v0, p0, Lcom/cyjh/elfin/customview/loadwidget/swiperefresh/BaseListView;->mFootView:Lcom/cyjh/elfin/customview/loadwidget/swiperefresh/BaseFootView;

    if-eqz v0, :cond_0

    .line 183
    iget-object v0, p0, Lcom/cyjh/elfin/customview/loadwidget/swiperefresh/BaseListView;->mFootView:Lcom/cyjh/elfin/customview/loadwidget/swiperefresh/BaseFootView;

    invoke-virtual {v0}, Lcom/cyjh/elfin/customview/loadwidget/swiperefresh/BaseFootView;->onLoadFailed()V

    .line 185
    :cond_0
    return-void
.end method

.method public onLoadStart()V
    .locals 1

    .prologue
    .line 213
    sget-object v0, Lcom/cyjh/elfin/mvp/views/loadstate/LoadStatueEnum;->NON:Lcom/cyjh/elfin/mvp/views/loadstate/LoadStatueEnum;

    iput-object v0, p0, Lcom/cyjh/elfin/customview/loadwidget/swiperefresh/BaseListView;->mStatueEnum:Lcom/cyjh/elfin/mvp/views/loadstate/LoadStatueEnum;

    .line 214
    iget-object v0, p0, Lcom/cyjh/elfin/customview/loadwidget/swiperefresh/BaseListView;->mFootView:Lcom/cyjh/elfin/customview/loadwidget/swiperefresh/BaseFootView;

    if-eqz v0, :cond_0

    .line 215
    iget-object v0, p0, Lcom/cyjh/elfin/customview/loadwidget/swiperefresh/BaseListView;->mFootView:Lcom/cyjh/elfin/customview/loadwidget/swiperefresh/BaseFootView;

    invoke-virtual {v0}, Lcom/cyjh/elfin/customview/loadwidget/swiperefresh/BaseFootView;->onLoadStart()V

    .line 217
    :cond_0
    return-void
.end method

.method public onLoadSuccess()V
    .locals 1

    .prologue
    .line 189
    sget-object v0, Lcom/cyjh/elfin/mvp/views/loadstate/LoadStatueEnum;->NON:Lcom/cyjh/elfin/mvp/views/loadstate/LoadStatueEnum;

    iput-object v0, p0, Lcom/cyjh/elfin/customview/loadwidget/swiperefresh/BaseListView;->mStatueEnum:Lcom/cyjh/elfin/mvp/views/loadstate/LoadStatueEnum;

    .line 190
    iget-object v0, p0, Lcom/cyjh/elfin/customview/loadwidget/swiperefresh/BaseListView;->mFootView:Lcom/cyjh/elfin/customview/loadwidget/swiperefresh/BaseFootView;

    if-eqz v0, :cond_0

    .line 191
    iget-object v0, p0, Lcom/cyjh/elfin/customview/loadwidget/swiperefresh/BaseListView;->mFootView:Lcom/cyjh/elfin/customview/loadwidget/swiperefresh/BaseFootView;

    invoke-virtual {v0}, Lcom/cyjh/elfin/customview/loadwidget/swiperefresh/BaseFootView;->onLoadSuccess()V

    .line 193
    :cond_0
    return-void
.end method

.method public onScroll(Landroid/widget/AbsListView;III)V
    .locals 1
    .param p1, "view"    # Landroid/widget/AbsListView;
    .param p2, "firstVisibleItem"    # I
    .param p3, "visibleItemCount"    # I
    .param p4, "totalItemCount"    # I

    .prologue
    .line 152
    iget-object v0, p0, Lcom/cyjh/elfin/customview/loadwidget/swiperefresh/BaseListView;->mListViewScrollListener:Lcom/cyjh/elfin/customview/loadwidget/swiperefresh/BaseListView$ListViewScrollListener;

    if-eqz v0, :cond_0

    .line 153
    iget-object v0, p0, Lcom/cyjh/elfin/customview/loadwidget/swiperefresh/BaseListView;->mListViewScrollListener:Lcom/cyjh/elfin/customview/loadwidget/swiperefresh/BaseListView$ListViewScrollListener;

    invoke-interface {v0, p1, p2, p3, p4}, Lcom/cyjh/elfin/customview/loadwidget/swiperefresh/BaseListView$ListViewScrollListener;->onScroll(Landroid/widget/AbsListView;III)V

    .line 155
    :cond_0
    iget-boolean v0, p0, Lcom/cyjh/elfin/customview/loadwidget/swiperefresh/BaseListView;->isScrollLoad:Z

    if-eqz v0, :cond_1

    .line 156
    add-int v0, p2, p3

    iput v0, p0, Lcom/cyjh/elfin/customview/loadwidget/swiperefresh/BaseListView;->mVisibledCount:I

    .line 157
    iput p4, p0, Lcom/cyjh/elfin/customview/loadwidget/swiperefresh/BaseListView;->mTotalItemCount:I

    .line 158
    invoke-direct {p0}, Lcom/cyjh/elfin/customview/loadwidget/swiperefresh/BaseListView;->scollLoadData()V

    .line 161
    :cond_1
    return-void
.end method

.method public onScrollStateChanged(Landroid/widget/AbsListView;I)V
    .locals 1
    .param p1, "view"    # Landroid/widget/AbsListView;
    .param p2, "scrollState"    # I

    .prologue
    .line 143
    iput p2, p0, Lcom/cyjh/elfin/customview/loadwidget/swiperefresh/BaseListView;->iScrollState:I

    .line 144
    iget-object v0, p0, Lcom/cyjh/elfin/customview/loadwidget/swiperefresh/BaseListView;->mListViewScrollListener:Lcom/cyjh/elfin/customview/loadwidget/swiperefresh/BaseListView$ListViewScrollListener;

    if-eqz v0, :cond_0

    .line 145
    iget-object v0, p0, Lcom/cyjh/elfin/customview/loadwidget/swiperefresh/BaseListView;->mListViewScrollListener:Lcom/cyjh/elfin/customview/loadwidget/swiperefresh/BaseListView$ListViewScrollListener;

    invoke-interface {v0, p1, p2}, Lcom/cyjh/elfin/customview/loadwidget/swiperefresh/BaseListView$ListViewScrollListener;->onScrollStateChanged(Landroid/widget/AbsListView;I)V

    .line 147
    :cond_0
    return-void
.end method

.method public prepareLoad(II)V
    .locals 1
    .param p1, "pageSize"    # I
    .param p2, "beforLoadNum"    # I

    .prologue
    .line 248
    iput p1, p0, Lcom/cyjh/elfin/customview/loadwidget/swiperefresh/BaseListView;->mPageSize:I

    .line 249
    sput p2, Lcom/cyjh/elfin/customview/loadwidget/swiperefresh/BaseListView;->befor_load_num:I

    .line 250
    const/4 v0, 0x1

    invoke-virtual {p0, v0}, Lcom/cyjh/elfin/customview/loadwidget/swiperefresh/BaseListView;->setScrollLoad(Z)V

    .line 251
    return-void
.end method

.method public removeFooterView()Z
    .locals 2

    .prologue
    .line 123
    iget-object v1, p0, Lcom/cyjh/elfin/customview/loadwidget/swiperefresh/BaseListView;->mFootView:Lcom/cyjh/elfin/customview/loadwidget/swiperefresh/BaseFootView;

    if-eqz v1, :cond_0

    .line 124
    iget-object v0, p0, Lcom/cyjh/elfin/customview/loadwidget/swiperefresh/BaseListView;->mFootView:Lcom/cyjh/elfin/customview/loadwidget/swiperefresh/BaseFootView;

    .line 125
    .local v0, "view":Lcom/cyjh/elfin/customview/loadwidget/swiperefresh/BaseFootView;
    const/4 v1, 0x0

    iput-object v1, p0, Lcom/cyjh/elfin/customview/loadwidget/swiperefresh/BaseListView;->mFootView:Lcom/cyjh/elfin/customview/loadwidget/swiperefresh/BaseFootView;

    .line 126
    invoke-virtual {p0, v0}, Lcom/cyjh/elfin/customview/loadwidget/swiperefresh/BaseListView;->removeFooterView(Landroid/view/View;)Z

    move-result v1

    .line 128
    .end local v0    # "view":Lcom/cyjh/elfin/customview/loadwidget/swiperefresh/BaseFootView;
    :goto_0
    return v1

    :cond_0
    const/4 v1, 0x0

    goto :goto_0
.end method

.method public removeFooterView(Landroid/view/View;)Z
    .locals 1
    .param p1, "v"    # Landroid/view/View;

    .prologue
    .line 111
    iget-object v0, p0, Lcom/cyjh/elfin/customview/loadwidget/swiperefresh/BaseListView;->mFootView:Lcom/cyjh/elfin/customview/loadwidget/swiperefresh/BaseFootView;

    if-ne v0, p1, :cond_0

    .line 112
    const/4 v0, 0x0

    iput-object v0, p0, Lcom/cyjh/elfin/customview/loadwidget/swiperefresh/BaseListView;->mFootView:Lcom/cyjh/elfin/customview/loadwidget/swiperefresh/BaseFootView;

    .line 114
    :cond_0
    invoke-super {p0, p1}, Landroid/widget/ListView;->removeFooterView(Landroid/view/View;)Z

    move-result v0

    return v0
.end method

.method public replaceFooterView(Landroid/view/View;)V
    .locals 0
    .param p1, "view"    # Landroid/view/View;

    .prologue
    .line 137
    invoke-virtual {p0}, Lcom/cyjh/elfin/customview/loadwidget/swiperefresh/BaseListView;->removeFooterView()Z

    .line 138
    invoke-virtual {p0, p1}, Lcom/cyjh/elfin/customview/loadwidget/swiperefresh/BaseListView;->addBaseFootView(Landroid/view/View;)V

    .line 139
    return-void
.end method

.method public setIListViewCallBack(Lcom/cyjh/elfin/mvp/views/loadstate/IListViewLoadCallBack;)V
    .locals 2
    .param p1, "callBack"    # Lcom/cyjh/elfin/mvp/views/loadstate/IListViewLoadCallBack;

    .prologue
    .line 87
    iput-object p1, p0, Lcom/cyjh/elfin/customview/loadwidget/swiperefresh/BaseListView;->mCallBack:Lcom/cyjh/elfin/mvp/views/loadstate/IListViewLoadCallBack;

    .line 88
    iget-object v0, p0, Lcom/cyjh/elfin/customview/loadwidget/swiperefresh/BaseListView;->mFootView:Lcom/cyjh/elfin/customview/loadwidget/swiperefresh/BaseFootView;

    iget-object v1, p0, Lcom/cyjh/elfin/customview/loadwidget/swiperefresh/BaseListView;->mCallBack:Lcom/cyjh/elfin/mvp/views/loadstate/IListViewLoadCallBack;

    invoke-virtual {v0, v1}, Lcom/cyjh/elfin/customview/loadwidget/swiperefresh/BaseFootView;->setCallBack(Lcom/cyjh/elfin/mvp/views/loadstate/IListViewLoadCallBack;)V

    .line 89
    return-void
.end method

.method public setScrollLoad(Z)V
    .locals 0
    .param p1, "isScrollLoad"    # Z

    .prologue
    .line 239
    iput-boolean p1, p0, Lcom/cyjh/elfin/customview/loadwidget/swiperefresh/BaseListView;->isScrollLoad:Z

    .line 240
    return-void
.end method

.method public setmListViewScrollListener(Lcom/cyjh/elfin/customview/loadwidget/swiperefresh/BaseListView$ListViewScrollListener;)V
    .locals 0
    .param p1, "mListViewScrollListener"    # Lcom/cyjh/elfin/customview/loadwidget/swiperefresh/BaseListView$ListViewScrollListener;

    .prologue
    .line 260
    iput-object p1, p0, Lcom/cyjh/elfin/customview/loadwidget/swiperefresh/BaseListView;->mListViewScrollListener:Lcom/cyjh/elfin/customview/loadwidget/swiperefresh/BaseListView$ListViewScrollListener;

    .line 261
    return-void
.end method
