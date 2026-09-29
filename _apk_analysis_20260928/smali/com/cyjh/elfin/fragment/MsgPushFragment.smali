.class public Lcom/cyjh/elfin/fragment/MsgPushFragment;
.super Lcom/cyjh/elfin/fragment/BaseFragement;
.source "MsgPushFragment.java"


# instance fields
.field private mBGAOnRVItemClicker:Lcn/bingoogolapple/androidcommon/adapter/BGAOnRVItemClickListener;

.field private mDataMsgList:Ljava/util/List;
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "Ljava/util/List",
            "<",
            "Lcom/cyjh/elfin/entity/NotifyMsgBean;",
            ">;"
        }
    .end annotation
.end field

.field private mRecyclerAdapter:Lcn/bingoogolapple/androidcommon/adapter/BGARecyclerViewAdapter;

.field private mRecyclerView:Landroid/support/v7/widget/RecyclerView;

.field private mTvNoMsg:Landroid/widget/TextView;


# direct methods
.method public constructor <init>()V
    .locals 1

    .prologue
    .line 33
    invoke-direct {p0}, Lcom/cyjh/elfin/fragment/BaseFragement;-><init>()V

    .line 100
    new-instance v0, Lcom/cyjh/elfin/fragment/MsgPushFragment$1;

    invoke-direct {v0, p0}, Lcom/cyjh/elfin/fragment/MsgPushFragment$1;-><init>(Lcom/cyjh/elfin/fragment/MsgPushFragment;)V

    iput-object v0, p0, Lcom/cyjh/elfin/fragment/MsgPushFragment;->mBGAOnRVItemClicker:Lcn/bingoogolapple/androidcommon/adapter/BGAOnRVItemClickListener;

    return-void
.end method

.method static synthetic access$000(Lcom/cyjh/elfin/fragment/MsgPushFragment;)Lcn/bingoogolapple/androidcommon/adapter/BGARecyclerViewAdapter;
    .locals 1
    .param p0, "x0"    # Lcom/cyjh/elfin/fragment/MsgPushFragment;

    .prologue
    .line 33
    iget-object v0, p0, Lcom/cyjh/elfin/fragment/MsgPushFragment;->mRecyclerAdapter:Lcn/bingoogolapple/androidcommon/adapter/BGARecyclerViewAdapter;

    return-object v0
.end method

.method private initView(Landroid/view/View;)V
    .locals 3
    .param p1, "view"    # Landroid/view/View;

    .prologue
    .line 81
    const v0, 0x7f0f0104

    invoke-virtual {p1, v0}, Landroid/view/View;->findViewById(I)Landroid/view/View;

    move-result-object v0

    check-cast v0, Landroid/support/v7/widget/RecyclerView;

    iput-object v0, p0, Lcom/cyjh/elfin/fragment/MsgPushFragment;->mRecyclerView:Landroid/support/v7/widget/RecyclerView;

    .line 82
    iget-object v0, p0, Lcom/cyjh/elfin/fragment/MsgPushFragment;->mRecyclerView:Landroid/support/v7/widget/RecyclerView;

    new-instance v1, Landroid/support/v7/widget/DefaultItemAnimator;

    invoke-direct {v1}, Landroid/support/v7/widget/DefaultItemAnimator;-><init>()V

    invoke-virtual {v0, v1}, Landroid/support/v7/widget/RecyclerView;->setItemAnimator(Landroid/support/v7/widget/RecyclerView$ItemAnimator;)V

    .line 83
    iget-object v0, p0, Lcom/cyjh/elfin/fragment/MsgPushFragment;->mRecyclerView:Landroid/support/v7/widget/RecyclerView;

    const/4 v1, 0x1

    invoke-virtual {v0, v1}, Landroid/support/v7/widget/RecyclerView;->setHasFixedSize(Z)V

    .line 84
    iget-object v0, p0, Lcom/cyjh/elfin/fragment/MsgPushFragment;->mRecyclerView:Landroid/support/v7/widget/RecyclerView;

    new-instance v1, Landroid/support/v7/widget/LinearLayoutManager;

    invoke-virtual {p0}, Lcom/cyjh/elfin/fragment/MsgPushFragment;->getActivity()Landroid/support/v4/app/FragmentActivity;

    move-result-object v2

    invoke-direct {v1, v2}, Landroid/support/v7/widget/LinearLayoutManager;-><init>(Landroid/content/Context;)V

    invoke-virtual {v0, v1}, Landroid/support/v7/widget/RecyclerView;->setLayoutManager(Landroid/support/v7/widget/RecyclerView$LayoutManager;)V

    .line 86
    new-instance v0, Lcom/cyjh/elfin/adpter/MsgNotifyAdapter;

    iget-object v1, p0, Lcom/cyjh/elfin/fragment/MsgPushFragment;->mRecyclerView:Landroid/support/v7/widget/RecyclerView;

    const v2, 0x7f040029

    invoke-direct {v0, v1, v2}, Lcom/cyjh/elfin/adpter/MsgNotifyAdapter;-><init>(Landroid/support/v7/widget/RecyclerView;I)V

    iput-object v0, p0, Lcom/cyjh/elfin/fragment/MsgPushFragment;->mRecyclerAdapter:Lcn/bingoogolapple/androidcommon/adapter/BGARecyclerViewAdapter;

    .line 87
    iget-object v0, p0, Lcom/cyjh/elfin/fragment/MsgPushFragment;->mRecyclerAdapter:Lcn/bingoogolapple/androidcommon/adapter/BGARecyclerViewAdapter;

    iget-object v1, p0, Lcom/cyjh/elfin/fragment/MsgPushFragment;->mBGAOnRVItemClicker:Lcn/bingoogolapple/androidcommon/adapter/BGAOnRVItemClickListener;

    invoke-virtual {v0, v1}, Lcn/bingoogolapple/androidcommon/adapter/BGARecyclerViewAdapter;->setOnRVItemClickListener(Lcn/bingoogolapple/androidcommon/adapter/BGAOnRVItemClickListener;)V

    .line 88
    const v0, 0x7f0f0105

    invoke-virtual {p1, v0}, Landroid/view/View;->findViewById(I)Landroid/view/View;

    move-result-object v0

    check-cast v0, Landroid/widget/TextView;

    iput-object v0, p0, Lcom/cyjh/elfin/fragment/MsgPushFragment;->mTvNoMsg:Landroid/widget/TextView;

    .line 89
    return-void
.end method

.method private isShowView()V
    .locals 3

    .prologue
    const/16 v2, 0x8

    const/4 v1, 0x0

    .line 69
    iget-object v0, p0, Lcom/cyjh/elfin/fragment/MsgPushFragment;->mDataMsgList:Ljava/util/List;

    if-eqz v0, :cond_0

    iget-object v0, p0, Lcom/cyjh/elfin/fragment/MsgPushFragment;->mDataMsgList:Ljava/util/List;

    invoke-interface {v0}, Ljava/util/List;->size()I

    move-result v0

    if-lez v0, :cond_0

    .line 70
    iget-object v0, p0, Lcom/cyjh/elfin/fragment/MsgPushFragment;->mTvNoMsg:Landroid/widget/TextView;

    invoke-virtual {v0, v2}, Landroid/widget/TextView;->setVisibility(I)V

    .line 71
    iget-object v0, p0, Lcom/cyjh/elfin/fragment/MsgPushFragment;->mRecyclerView:Landroid/support/v7/widget/RecyclerView;

    invoke-virtual {v0, v1}, Landroid/support/v7/widget/RecyclerView;->setVisibility(I)V

    .line 72
    iget-object v0, p0, Lcom/cyjh/elfin/fragment/MsgPushFragment;->mRecyclerAdapter:Lcn/bingoogolapple/androidcommon/adapter/BGARecyclerViewAdapter;

    iget-object v1, p0, Lcom/cyjh/elfin/fragment/MsgPushFragment;->mDataMsgList:Ljava/util/List;

    invoke-virtual {v0, v1}, Lcn/bingoogolapple/androidcommon/adapter/BGARecyclerViewAdapter;->setDatas(Ljava/util/List;)V

    .line 73
    iget-object v0, p0, Lcom/cyjh/elfin/fragment/MsgPushFragment;->mRecyclerView:Landroid/support/v7/widget/RecyclerView;

    iget-object v1, p0, Lcom/cyjh/elfin/fragment/MsgPushFragment;->mRecyclerAdapter:Lcn/bingoogolapple/androidcommon/adapter/BGARecyclerViewAdapter;

    invoke-virtual {v0, v1}, Landroid/support/v7/widget/RecyclerView;->setAdapter(Landroid/support/v7/widget/RecyclerView$Adapter;)V

    .line 78
    :goto_0
    return-void

    .line 75
    :cond_0
    iget-object v0, p0, Lcom/cyjh/elfin/fragment/MsgPushFragment;->mTvNoMsg:Landroid/widget/TextView;

    invoke-virtual {v0, v1}, Landroid/widget/TextView;->setVisibility(I)V

    .line 76
    iget-object v0, p0, Lcom/cyjh/elfin/fragment/MsgPushFragment;->mRecyclerView:Landroid/support/v7/widget/RecyclerView;

    invoke-virtual {v0, v2}, Landroid/support/v7/widget/RecyclerView;->setVisibility(I)V

    goto :goto_0
.end method

.method public static newInstance(Ljava/util/ArrayList;)Lcom/cyjh/elfin/fragment/MsgPushFragment;
    .locals 3
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "(",
            "Ljava/util/ArrayList",
            "<",
            "Lcom/cyjh/elfin/entity/NotifyMsgBean;",
            ">;)",
            "Lcom/cyjh/elfin/fragment/MsgPushFragment;"
        }
    .end annotation

    .prologue
    .line 41
    .local p0, "datas":Ljava/util/ArrayList;, "Ljava/util/ArrayList<Lcom/cyjh/elfin/entity/NotifyMsgBean;>;"
    new-instance v1, Lcom/cyjh/elfin/fragment/MsgPushFragment;

    invoke-direct {v1}, Lcom/cyjh/elfin/fragment/MsgPushFragment;-><init>()V

    .line 42
    .local v1, "msgPushFragment":Lcom/cyjh/elfin/fragment/MsgPushFragment;
    new-instance v0, Landroid/os/Bundle;

    invoke-direct {v0}, Landroid/os/Bundle;-><init>()V

    .line 43
    .local v0, "bundle":Landroid/os/Bundle;
    const-string v2, "msg_data"

    invoke-virtual {v0, v2, p0}, Landroid/os/Bundle;->putParcelableArrayList(Ljava/lang/String;Ljava/util/ArrayList;)V

    .line 44
    invoke-virtual {v1, v0}, Lcom/cyjh/elfin/fragment/MsgPushFragment;->setArguments(Landroid/os/Bundle;)V

    .line 45
    return-object v1
.end method


# virtual methods
.method public getFragmentLayoutId()I
    .locals 1

    .prologue
    .line 50
    const v0, 0x7f04004a

    return v0
.end method

.method public onDestroy()V
    .locals 1

    .prologue
    .line 93
    invoke-super {p0}, Lcom/cyjh/elfin/fragment/BaseFragement;->onDestroy()V

    .line 94
    invoke-static {}, Lorg/greenrobot/eventbus/EventBus;->getDefault()Lorg/greenrobot/eventbus/EventBus;

    move-result-object v0

    invoke-virtual {v0, p0}, Lorg/greenrobot/eventbus/EventBus;->unregister(Ljava/lang/Object;)V

    .line 95
    return-void
.end method

.method public onMessageMainThread(Lcom/cyjh/elfin/entity/MsgItem;)V
    .locals 4
    .param p1, "msgItem"    # Lcom/cyjh/elfin/entity/MsgItem;
    .annotation runtime Lorg/greenrobot/eventbus/Subscribe;
        threadMode = .enum Lorg/greenrobot/eventbus/ThreadMode;->MAIN:Lorg/greenrobot/eventbus/ThreadMode;
    .end annotation

    .prologue
    .line 118
    invoke-virtual {p1}, Lcom/cyjh/elfin/entity/MsgItem;->getMsgType()I

    move-result v0

    .line 119
    .local v0, "msgType":I
    packed-switch v0, :pswitch_data_0

    .line 128
    :goto_0
    return-void

    .line 121
    :pswitch_0
    iget-object v1, p0, Lcom/cyjh/elfin/fragment/MsgPushFragment;->mRecyclerAdapter:Lcn/bingoogolapple/androidcommon/adapter/BGARecyclerViewAdapter;

    invoke-virtual {v1}, Lcn/bingoogolapple/androidcommon/adapter/BGARecyclerViewAdapter;->clear()V

    .line 122
    iget-object v1, p0, Lcom/cyjh/elfin/fragment/MsgPushFragment;->mTvNoMsg:Landroid/widget/TextView;

    const/4 v2, 0x0

    invoke-virtual {v1, v2}, Landroid/widget/TextView;->setVisibility(I)V

    .line 123
    iget-object v1, p0, Lcom/cyjh/elfin/fragment/MsgPushFragment;->mRecyclerView:Landroid/support/v7/widget/RecyclerView;

    const/16 v2, 0x8

    invoke-virtual {v1, v2}, Landroid/support/v7/widget/RecyclerView;->setVisibility(I)V

    .line 125
    invoke-static {}, Lorg/greenrobot/eventbus/EventBus;->getDefault()Lorg/greenrobot/eventbus/EventBus;

    move-result-object v1

    new-instance v2, Lcom/cyjh/elfin/entity/MsgItem;

    const/16 v3, 0x3eb

    invoke-direct {v2, v3}, Lcom/cyjh/elfin/entity/MsgItem;-><init>(I)V

    invoke-virtual {v1, v2}, Lorg/greenrobot/eventbus/EventBus;->post(Ljava/lang/Object;)V

    goto :goto_0

    .line 119
    nop

    :pswitch_data_0
    .packed-switch 0x3ea
        :pswitch_0
    .end packed-switch
.end method

.method public onPause()V
    .locals 1

    .prologue
    .line 138
    invoke-super {p0}, Lcom/cyjh/elfin/fragment/BaseFragement;->onPause()V

    .line 139
    const-class v0, Lcom/cyjh/elfin/fragment/MsgPushFragment;

    invoke-virtual {v0}, Ljava/lang/Class;->getCanonicalName()Ljava/lang/String;

    move-result-object v0

    invoke-static {v0}, Lcom/umeng/analytics/MobclickAgent;->onPageEnd(Ljava/lang/String;)V

    .line 140
    return-void
.end method

.method public onResume()V
    .locals 1

    .prologue
    .line 132
    invoke-super {p0}, Lcom/cyjh/elfin/fragment/BaseFragement;->onResume()V

    .line 133
    const-class v0, Lcom/cyjh/elfin/fragment/MsgPushFragment;

    invoke-virtual {v0}, Ljava/lang/Class;->getCanonicalName()Ljava/lang/String;

    move-result-object v0

    invoke-static {v0}, Lcom/umeng/analytics/MobclickAgent;->onPageStart(Ljava/lang/String;)V

    .line 134
    return-void
.end method

.method public onViewCreated(Landroid/view/View;Landroid/os/Bundle;)V
    .locals 2
    .param p1, "view"    # Landroid/view/View;
    .param p2, "savedInstanceState"    # Landroid/os/Bundle;

    .prologue
    .line 55
    invoke-super {p0, p1, p2}, Lcom/cyjh/elfin/fragment/BaseFragement;->onViewCreated(Landroid/view/View;Landroid/os/Bundle;)V

    .line 56
    invoke-virtual {p0}, Lcom/cyjh/elfin/fragment/MsgPushFragment;->getArguments()Landroid/os/Bundle;

    move-result-object v0

    .line 57
    .local v0, "bundle":Landroid/os/Bundle;
    invoke-static {}, Lorg/greenrobot/eventbus/EventBus;->getDefault()Lorg/greenrobot/eventbus/EventBus;

    move-result-object v1

    invoke-virtual {v1, p0}, Lorg/greenrobot/eventbus/EventBus;->register(Ljava/lang/Object;)V

    .line 58
    if-eqz v0, :cond_0

    .line 59
    const-string v1, "msg_data"

    invoke-virtual {v0, v1}, Landroid/os/Bundle;->getParcelableArrayList(Ljava/lang/String;)Ljava/util/ArrayList;

    move-result-object v1

    iput-object v1, p0, Lcom/cyjh/elfin/fragment/MsgPushFragment;->mDataMsgList:Ljava/util/List;

    .line 61
    :cond_0
    invoke-direct {p0, p1}, Lcom/cyjh/elfin/fragment/MsgPushFragment;->initView(Landroid/view/View;)V

    .line 62
    invoke-direct {p0}, Lcom/cyjh/elfin/fragment/MsgPushFragment;->isShowView()V

    .line 63
    return-void
.end method
