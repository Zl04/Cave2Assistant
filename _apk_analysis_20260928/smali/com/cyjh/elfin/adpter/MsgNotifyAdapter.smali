.class public Lcom/cyjh/elfin/adpter/MsgNotifyAdapter;
.super Lcn/bingoogolapple/androidcommon/adapter/BGARecyclerViewAdapter;
.source "MsgNotifyAdapter.java"


# annotations
.annotation system Ldalvik/annotation/Signature;
    value = {
        "Lcn/bingoogolapple/androidcommon/adapter/BGARecyclerViewAdapter",
        "<",
        "Lcom/cyjh/elfin/entity/NotifyMsgBean;",
        ">;"
    }
.end annotation


# direct methods
.method public constructor <init>(Landroid/support/v7/widget/RecyclerView;I)V
    .locals 0
    .param p1, "recyclerView"    # Landroid/support/v7/widget/RecyclerView;
    .param p2, "itemLayoutId"    # I

    .prologue
    .line 21
    invoke-direct {p0, p1, p2}, Lcn/bingoogolapple/androidcommon/adapter/BGARecyclerViewAdapter;-><init>(Landroid/support/v7/widget/RecyclerView;I)V

    .line 22
    return-void
.end method


# virtual methods
.method protected fillData(Lcn/bingoogolapple/androidcommon/adapter/BGAViewHolderHelper;ILcom/cyjh/elfin/entity/NotifyMsgBean;)V
    .locals 8
    .param p1, "bgaViewHolderHelper"    # Lcn/bingoogolapple/androidcommon/adapter/BGAViewHolderHelper;
    .param p2, "i"    # I
    .param p3, "notifyMsgBean"    # Lcom/cyjh/elfin/entity/NotifyMsgBean;

    .prologue
    const v7, 0x7f0f0097

    const v6, 0x7f0200a9

    const/16 v5, 0x8

    const/4 v4, 0x0

    .line 26
    if-eqz p3, :cond_0

    .line 27
    invoke-virtual {p1, v7}, Lcn/bingoogolapple/androidcommon/adapter/BGAViewHolderHelper;->getView(I)Landroid/view/View;

    move-result-object v1

    check-cast v1, Landroid/widget/TextView;

    .line 28
    .local v1, "mTvNoticeDesc":Landroid/widget/TextView;
    const v2, 0x7f0f0079

    invoke-virtual {p1, v2}, Lcn/bingoogolapple/androidcommon/adapter/BGAViewHolderHelper;->getView(I)Landroid/view/View;

    move-result-object v0

    check-cast v0, Landroid/widget/ImageView;

    .line 29
    .local v0, "mImgNoticeDesc":Landroid/widget/ImageView;
    const v2, 0x7f0f0095

    iget-object v3, p3, Lcom/cyjh/elfin/entity/NotifyMsgBean;->NoticeTitle:Ljava/lang/String;

    invoke-virtual {p1, v2, v3}, Lcn/bingoogolapple/androidcommon/adapter/BGAViewHolderHelper;->setText(ILjava/lang/CharSequence;)Lcn/bingoogolapple/androidcommon/adapter/BGAViewHolderHelper;

    .line 30
    const v2, 0x7f0f0096

    iget-object v3, p3, Lcom/cyjh/elfin/entity/NotifyMsgBean;->NoticeTime:Ljava/lang/String;

    invoke-virtual {p1, v2, v3}, Lcn/bingoogolapple/androidcommon/adapter/BGAViewHolderHelper;->setText(ILjava/lang/CharSequence;)Lcn/bingoogolapple/androidcommon/adapter/BGAViewHolderHelper;

    .line 31
    iget-object v2, p3, Lcom/cyjh/elfin/entity/NotifyMsgBean;->DescriptionType:Ljava/lang/String;

    const/4 v3, 0x1

    invoke-static {v3}, Ljava/lang/String;->valueOf(I)Ljava/lang/String;

    move-result-object v3

    invoke-virtual {v2, v3}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v2

    if-eqz v2, :cond_1

    .line 32
    iget-object v2, p3, Lcom/cyjh/elfin/entity/NotifyMsgBean;->NoticeDescription:Ljava/lang/String;

    invoke-virtual {p1, v7, v2}, Lcn/bingoogolapple/androidcommon/adapter/BGAViewHolderHelper;->setText(ILjava/lang/CharSequence;)Lcn/bingoogolapple/androidcommon/adapter/BGAViewHolderHelper;

    .line 33
    invoke-virtual {v0, v5}, Landroid/widget/ImageView;->setVisibility(I)V

    .line 34
    invoke-virtual {v1, v4}, Landroid/widget/TextView;->setVisibility(I)V

    .line 46
    .end local v0    # "mImgNoticeDesc":Landroid/widget/ImageView;
    .end local v1    # "mTvNoticeDesc":Landroid/widget/TextView;
    :cond_0
    :goto_0
    return-void

    .line 35
    .restart local v0    # "mImgNoticeDesc":Landroid/widget/ImageView;
    .restart local v1    # "mTvNoticeDesc":Landroid/widget/TextView;
    :cond_1
    iget-object v2, p3, Lcom/cyjh/elfin/entity/NotifyMsgBean;->DescriptionType:Ljava/lang/String;

    const/4 v3, 0x2

    invoke-static {v3}, Ljava/lang/String;->valueOf(I)Ljava/lang/String;

    move-result-object v3

    invoke-virtual {v2, v3}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v2

    if-eqz v2, :cond_0

    .line 36
    invoke-virtual {v1, v5}, Landroid/widget/TextView;->setVisibility(I)V

    .line 37
    invoke-virtual {v0, v4}, Landroid/widget/ImageView;->setVisibility(I)V

    .line 38
    iget-object v2, p0, Lcom/cyjh/elfin/adpter/MsgNotifyAdapter;->mContext:Landroid/content/Context;

    invoke-static {v2}, Lcom/squareup/picasso/Picasso;->with(Landroid/content/Context;)Lcom/squareup/picasso/Picasso;

    move-result-object v2

    iget-object v3, p3, Lcom/cyjh/elfin/entity/NotifyMsgBean;->NoticeDescription:Ljava/lang/String;

    invoke-virtual {v2, v3}, Lcom/squareup/picasso/Picasso;->load(Ljava/lang/String;)Lcom/squareup/picasso/RequestCreator;

    move-result-object v2

    .line 39
    invoke-virtual {v2}, Lcom/squareup/picasso/RequestCreator;->fit()Lcom/squareup/picasso/RequestCreator;

    move-result-object v2

    .line 40
    invoke-virtual {v2, v6}, Lcom/squareup/picasso/RequestCreator;->error(I)Lcom/squareup/picasso/RequestCreator;

    move-result-object v2

    .line 41
    invoke-virtual {v2, v6}, Lcom/squareup/picasso/RequestCreator;->placeholder(I)Lcom/squareup/picasso/RequestCreator;

    move-result-object v2

    .line 42
    invoke-virtual {v2, v0}, Lcom/squareup/picasso/RequestCreator;->into(Landroid/widget/ImageView;)V

    goto :goto_0
.end method

.method protected bridge synthetic fillData(Lcn/bingoogolapple/androidcommon/adapter/BGAViewHolderHelper;ILjava/lang/Object;)V
    .locals 0

    .prologue
    .line 18
    check-cast p3, Lcom/cyjh/elfin/entity/NotifyMsgBean;

    invoke-virtual {p0, p1, p2, p3}, Lcom/cyjh/elfin/adpter/MsgNotifyAdapter;->fillData(Lcn/bingoogolapple/androidcommon/adapter/BGAViewHolderHelper;ILcom/cyjh/elfin/entity/NotifyMsgBean;)V

    return-void
.end method
