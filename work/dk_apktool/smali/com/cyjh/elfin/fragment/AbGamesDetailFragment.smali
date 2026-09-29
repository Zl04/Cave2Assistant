.class public Lcom/cyjh/elfin/fragment/AbGamesDetailFragment;
.super Lcom/cyjh/elfin/fragment/content/BasicLoadStateHttpFragment;
.source "AbGamesDetailFragment.java"

# interfaces
.implements Lcom/cyjh/elfin/mvp/views/loadstate/FindBasicInf;
.implements Lcom/cyjh/elfin/inf/RightBtnOpera;
.implements Landroid/view/View$OnClickListener;


# instance fields
.field private abGameDetailsPresenter:Lcom/cyjh/elfin/mvp/presenters/AbGameDetailsPresenter;

.field private gameDownloadView:Lcom/cyjh/elfin/customview/GameDownloadView;

.field private gameId:Ljava/lang/String;

.field private imgList:Ljava/util/ArrayList;
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "Ljava/util/ArrayList",
            "<",
            "Ljava/lang/String;",
            ">;"
        }
    .end annotation
.end field

.field private mGameInfo:Lcom/cyjh/elfin/entity/GameInfo;

.field private mHorizontalScrollView:Landroid/widget/HorizontalScrollView;

.field private mImgLogo:Landroid/widget/ImageView;

.field private mImgPic1:Landroid/widget/ImageView;

.field private mImgPic2:Landroid/widget/ImageView;

.field private mImgPic3:Landroid/widget/ImageView;

.field private mImgPic4:Landroid/widget/ImageView;

.field private mImgPic5:Landroid/widget/ImageView;

.field private mRlContent:Landroid/widget/LinearLayout;

.field private mScrollView:Landroid/widget/ScrollView;

.field private mSwipeRefresh:Landroid/support/v4/widget/SwipeRefreshLayout;

.field private mTvDes:Landroid/widget/TextView;

.field private mTvLabelFour:Landroid/widget/TextView;

.field private mTvLabelOne:Landroid/widget/TextView;

.field private mTvLabelThree:Landroid/widget/TextView;

.field private mTvLabelTwo:Landroid/widget/TextView;

.field private mTvTitle:Landroid/widget/TextView;


# direct methods
.method public constructor <init>()V
    .locals 1

    .prologue
    .line 47
    invoke-direct {p0}, Lcom/cyjh/elfin/fragment/content/BasicLoadStateHttpFragment;-><init>()V

    .line 66
    new-instance v0, Ljava/util/ArrayList;

    invoke-direct {v0}, Ljava/util/ArrayList;-><init>()V

    iput-object v0, p0, Lcom/cyjh/elfin/fragment/AbGamesDetailFragment;->imgList:Ljava/util/ArrayList;

    return-void
.end method

.method static synthetic access$000(Lcom/cyjh/elfin/fragment/AbGamesDetailFragment;)Landroid/widget/ScrollView;
    .locals 1
    .param p0, "x0"    # Lcom/cyjh/elfin/fragment/AbGamesDetailFragment;

    .prologue
    .line 47
    iget-object v0, p0, Lcom/cyjh/elfin/fragment/AbGamesDetailFragment;->mScrollView:Landroid/widget/ScrollView;

    return-object v0
.end method

.method static synthetic access$100(Lcom/cyjh/elfin/fragment/AbGamesDetailFragment;)Landroid/support/v4/widget/SwipeRefreshLayout;
    .locals 1
    .param p0, "x0"    # Lcom/cyjh/elfin/fragment/AbGamesDetailFragment;

    .prologue
    .line 47
    iget-object v0, p0, Lcom/cyjh/elfin/fragment/AbGamesDetailFragment;->mSwipeRefresh:Landroid/support/v4/widget/SwipeRefreshLayout;

    return-object v0
.end method

.method static synthetic access$200(Lcom/cyjh/elfin/fragment/AbGamesDetailFragment;)Lcom/cyjh/elfin/mvp/presenters/AbGameDetailsPresenter;
    .locals 1
    .param p0, "x0"    # Lcom/cyjh/elfin/fragment/AbGamesDetailFragment;

    .prologue
    .line 47
    iget-object v0, p0, Lcom/cyjh/elfin/fragment/AbGamesDetailFragment;->abGameDetailsPresenter:Lcom/cyjh/elfin/mvp/presenters/AbGameDetailsPresenter;

    return-object v0
.end method

.method private isVisitibityLabel([Ljava/lang/String;)V
    .locals 7
    .param p1, "arrLabel"    # [Ljava/lang/String;

    .prologue
    const/4 v6, 0x4

    const/4 v5, 0x3

    const/4 v4, 0x2

    const/4 v3, 0x1

    const/4 v2, 0x0

    .line 292
    array-length v0, p1

    if-lez v0, :cond_0

    aget-object v0, p1, v2

    invoke-static {v0}, Landroid/text/TextUtils;->isEmpty(Ljava/lang/CharSequence;)Z

    move-result v0

    if-nez v0, :cond_0

    .line 293
    iget-object v0, p0, Lcom/cyjh/elfin/fragment/AbGamesDetailFragment;->mTvLabelOne:Landroid/widget/TextView;

    aget-object v1, p1, v2

    invoke-virtual {v0, v1}, Landroid/widget/TextView;->setText(Ljava/lang/CharSequence;)V

    .line 294
    iget-object v0, p0, Lcom/cyjh/elfin/fragment/AbGamesDetailFragment;->mTvLabelOne:Landroid/widget/TextView;

    invoke-virtual {v0, v2}, Landroid/widget/TextView;->setVisibility(I)V

    .line 298
    :goto_0
    array-length v0, p1

    if-le v0, v3, :cond_1

    aget-object v0, p1, v3

    invoke-static {v0}, Landroid/text/TextUtils;->isEmpty(Ljava/lang/CharSequence;)Z

    move-result v0

    if-nez v0, :cond_1

    .line 299
    iget-object v0, p0, Lcom/cyjh/elfin/fragment/AbGamesDetailFragment;->mTvLabelTwo:Landroid/widget/TextView;

    aget-object v1, p1, v3

    invoke-virtual {v0, v1}, Landroid/widget/TextView;->setText(Ljava/lang/CharSequence;)V

    .line 300
    iget-object v0, p0, Lcom/cyjh/elfin/fragment/AbGamesDetailFragment;->mTvLabelTwo:Landroid/widget/TextView;

    invoke-virtual {v0, v2}, Landroid/widget/TextView;->setVisibility(I)V

    .line 304
    :goto_1
    array-length v0, p1

    if-le v0, v4, :cond_2

    aget-object v0, p1, v4

    invoke-static {v0}, Landroid/text/TextUtils;->isEmpty(Ljava/lang/CharSequence;)Z

    move-result v0

    if-nez v0, :cond_2

    .line 305
    iget-object v0, p0, Lcom/cyjh/elfin/fragment/AbGamesDetailFragment;->mTvLabelThree:Landroid/widget/TextView;

    aget-object v1, p1, v4

    invoke-virtual {v0, v1}, Landroid/widget/TextView;->setText(Ljava/lang/CharSequence;)V

    .line 306
    iget-object v0, p0, Lcom/cyjh/elfin/fragment/AbGamesDetailFragment;->mTvLabelThree:Landroid/widget/TextView;

    invoke-virtual {v0, v2}, Landroid/widget/TextView;->setVisibility(I)V

    .line 310
    :goto_2
    array-length v0, p1

    if-le v0, v5, :cond_3

    aget-object v0, p1, v5

    invoke-static {v0}, Landroid/text/TextUtils;->isEmpty(Ljava/lang/CharSequence;)Z

    move-result v0

    if-nez v0, :cond_3

    .line 311
    iget-object v0, p0, Lcom/cyjh/elfin/fragment/AbGamesDetailFragment;->mTvLabelFour:Landroid/widget/TextView;

    aget-object v1, p1, v5

    invoke-virtual {v0, v1}, Landroid/widget/TextView;->setText(Ljava/lang/CharSequence;)V

    .line 312
    iget-object v0, p0, Lcom/cyjh/elfin/fragment/AbGamesDetailFragment;->mTvLabelFour:Landroid/widget/TextView;

    invoke-virtual {v0, v2}, Landroid/widget/TextView;->setVisibility(I)V

    .line 316
    :goto_3
    return-void

    .line 296
    :cond_0
    iget-object v0, p0, Lcom/cyjh/elfin/fragment/AbGamesDetailFragment;->mTvLabelOne:Landroid/widget/TextView;

    invoke-virtual {v0, v6}, Landroid/widget/TextView;->setVisibility(I)V

    goto :goto_0

    .line 302
    :cond_1
    iget-object v0, p0, Lcom/cyjh/elfin/fragment/AbGamesDetailFragment;->mTvLabelTwo:Landroid/widget/TextView;

    invoke-virtual {v0, v6}, Landroid/widget/TextView;->setVisibility(I)V

    goto :goto_1

    .line 308
    :cond_2
    iget-object v0, p0, Lcom/cyjh/elfin/fragment/AbGamesDetailFragment;->mTvLabelThree:Landroid/widget/TextView;

    invoke-virtual {v0, v6}, Landroid/widget/TextView;->setVisibility(I)V

    goto :goto_2

    .line 314
    :cond_3
    iget-object v0, p0, Lcom/cyjh/elfin/fragment/AbGamesDetailFragment;->mTvLabelFour:Landroid/widget/TextView;

    const/16 v1, 0x8

    invoke-virtual {v0, v1}, Landroid/widget/TextView;->setVisibility(I)V

    goto :goto_3
.end method

.method public static newInstance(Ljava/lang/String;)Lcom/cyjh/elfin/fragment/AbGamesDetailFragment;
    .locals 3
    .param p0, "gameId"    # Ljava/lang/String;

    .prologue
    .line 71
    new-instance v0, Lcom/cyjh/elfin/fragment/AbGamesDetailFragment;

    invoke-direct {v0}, Lcom/cyjh/elfin/fragment/AbGamesDetailFragment;-><init>()V

    .line 72
    .local v0, "abGamesDetailFragment":Lcom/cyjh/elfin/fragment/AbGamesDetailFragment;
    new-instance v1, Landroid/os/Bundle;

    invoke-direct {v1}, Landroid/os/Bundle;-><init>()V

    .line 73
    .local v1, "bundle":Landroid/os/Bundle;
    const-string v2, "id"

    invoke-virtual {v1, v2, p0}, Landroid/os/Bundle;->putString(Ljava/lang/String;Ljava/lang/String;)V

    .line 74
    invoke-virtual {v0, v1}, Lcom/cyjh/elfin/fragment/AbGamesDetailFragment;->setArguments(Landroid/os/Bundle;)V

    .line 75
    return-object v0
.end method

.method private setGameData(Lcom/cyjh/elfin/entity/GameDetails;)V
    .locals 4
    .param p1, "gameDetails"    # Lcom/cyjh/elfin/entity/GameDetails;

    .prologue
    const v3, 0x7f0200a4

    .line 152
    iget-object v1, p1, Lcom/cyjh/elfin/entity/GameDetails;->Data:Lcom/cyjh/elfin/entity/GameInfo;

    iput-object v1, p0, Lcom/cyjh/elfin/fragment/AbGamesDetailFragment;->mGameInfo:Lcom/cyjh/elfin/entity/GameInfo;

    .line 153
    iget-object v1, p0, Lcom/cyjh/elfin/fragment/AbGamesDetailFragment;->mGameInfo:Lcom/cyjh/elfin/entity/GameInfo;

    if-eqz v1, :cond_0

    .line 154
    iget-object v1, p0, Lcom/cyjh/elfin/fragment/AbGamesDetailFragment;->mTvTitle:Landroid/widget/TextView;

    iget-object v2, p0, Lcom/cyjh/elfin/fragment/AbGamesDetailFragment;->mGameInfo:Lcom/cyjh/elfin/entity/GameInfo;

    iget-object v2, v2, Lcom/cyjh/elfin/entity/GameInfo;->Name:Ljava/lang/String;

    invoke-virtual {v1, v2}, Landroid/widget/TextView;->setText(Ljava/lang/CharSequence;)V

    .line 155
    invoke-virtual {p0}, Lcom/cyjh/elfin/fragment/AbGamesDetailFragment;->getActivity()Landroid/support/v4/app/FragmentActivity;

    move-result-object v1

    invoke-static {v1}, Lcom/squareup/picasso/Picasso;->with(Landroid/content/Context;)Lcom/squareup/picasso/Picasso;

    move-result-object v1

    iget-object v2, p0, Lcom/cyjh/elfin/fragment/AbGamesDetailFragment;->mGameInfo:Lcom/cyjh/elfin/entity/GameInfo;

    iget-object v2, v2, Lcom/cyjh/elfin/entity/GameInfo;->Icon:Ljava/lang/String;

    invoke-virtual {v1, v2}, Lcom/squareup/picasso/Picasso;->load(Ljava/lang/String;)Lcom/squareup/picasso/RequestCreator;

    move-result-object v1

    invoke-virtual {v1, v3}, Lcom/squareup/picasso/RequestCreator;->placeholder(I)Lcom/squareup/picasso/RequestCreator;

    move-result-object v1

    .line 156
    invoke-virtual {v1, v3}, Lcom/squareup/picasso/RequestCreator;->error(I)Lcom/squareup/picasso/RequestCreator;

    move-result-object v1

    iget-object v2, p0, Lcom/cyjh/elfin/fragment/AbGamesDetailFragment;->mImgLogo:Landroid/widget/ImageView;

    invoke-virtual {v1, v2}, Lcom/squareup/picasso/RequestCreator;->into(Landroid/widget/ImageView;)V

    .line 157
    iget-object v1, p0, Lcom/cyjh/elfin/fragment/AbGamesDetailFragment;->mGameInfo:Lcom/cyjh/elfin/entity/GameInfo;

    iget-object v1, v1, Lcom/cyjh/elfin/entity/GameInfo;->Label:Ljava/lang/String;

    const-string v2, "-"

    invoke-virtual {v1, v2}, Ljava/lang/String;->split(Ljava/lang/String;)[Ljava/lang/String;

    move-result-object v0

    .line 158
    .local v0, "labelStrArray":[Ljava/lang/String;
    invoke-direct {p0, v0}, Lcom/cyjh/elfin/fragment/AbGamesDetailFragment;->isVisitibityLabel([Ljava/lang/String;)V

    .line 159
    invoke-direct {p0}, Lcom/cyjh/elfin/fragment/AbGamesDetailFragment;->showGameDetailsPic()V

    .line 160
    iget-object v1, p0, Lcom/cyjh/elfin/fragment/AbGamesDetailFragment;->mTvDes:Landroid/widget/TextView;

    iget-object v2, p0, Lcom/cyjh/elfin/fragment/AbGamesDetailFragment;->mGameInfo:Lcom/cyjh/elfin/entity/GameInfo;

    iget-object v2, v2, Lcom/cyjh/elfin/entity/GameInfo;->Detail:Ljava/lang/String;

    invoke-virtual {v1, v2}, Landroid/widget/TextView;->setText(Ljava/lang/CharSequence;)V

    .line 161
    iget-object v1, p0, Lcom/cyjh/elfin/fragment/AbGamesDetailFragment;->gameDownloadView:Lcom/cyjh/elfin/customview/GameDownloadView;

    iget-object v2, p0, Lcom/cyjh/elfin/fragment/AbGamesDetailFragment;->mGameInfo:Lcom/cyjh/elfin/entity/GameInfo;

    iget-object v2, v2, Lcom/cyjh/elfin/entity/GameInfo;->Size:Ljava/lang/String;

    const/4 v3, 0x1

    invoke-virtual {v1, v2, v3}, Lcom/cyjh/elfin/customview/GameDownloadView;->setTextStyle(Ljava/lang/String;Z)V

    .line 162
    iget-object v1, p0, Lcom/cyjh/elfin/fragment/AbGamesDetailFragment;->gameDownloadView:Lcom/cyjh/elfin/customview/GameDownloadView;

    const/4 v2, 0x0

    invoke-virtual {v1, v2}, Lcom/cyjh/elfin/customview/GameDownloadView;->setVisibility(I)V

    .line 163
    iget-object v1, p0, Lcom/cyjh/elfin/fragment/AbGamesDetailFragment;->gameDownloadView:Lcom/cyjh/elfin/customview/GameDownloadView;

    iget-object v2, p0, Lcom/cyjh/elfin/fragment/AbGamesDetailFragment;->mGameInfo:Lcom/cyjh/elfin/entity/GameInfo;

    invoke-virtual {v1, v2}, Lcom/cyjh/elfin/customview/GameDownloadView;->setInfo(Lcom/cyjh/elfin/entity/GameInfo;)V

    .line 165
    .end local v0    # "labelStrArray":[Ljava/lang/String;
    :cond_0
    return-void
.end method

.method private showGameDetailsPic()V
    .locals 5

    .prologue
    const/16 v4, 0x8

    const/4 v3, 0x0

    const v2, 0x7f020049

    .line 168
    iget-object v0, p0, Lcom/cyjh/elfin/fragment/AbGamesDetailFragment;->mGameInfo:Lcom/cyjh/elfin/entity/GameInfo;

    iget-object v0, v0, Lcom/cyjh/elfin/entity/GameInfo;->Image1:Ljava/lang/String;

    invoke-static {v0}, Landroid/text/TextUtils;->isEmpty(Ljava/lang/CharSequence;)Z

    move-result v0

    if-nez v0, :cond_0

    .line 169
    iget-object v0, p0, Lcom/cyjh/elfin/fragment/AbGamesDetailFragment;->mImgPic1:Landroid/widget/ImageView;

    invoke-virtual {v0, v3}, Landroid/widget/ImageView;->setVisibility(I)V

    .line 170
    iget-object v0, p0, Lcom/cyjh/elfin/fragment/AbGamesDetailFragment;->imgList:Ljava/util/ArrayList;

    iget-object v1, p0, Lcom/cyjh/elfin/fragment/AbGamesDetailFragment;->mGameInfo:Lcom/cyjh/elfin/entity/GameInfo;

    iget-object v1, v1, Lcom/cyjh/elfin/entity/GameInfo;->Image1:Ljava/lang/String;

    invoke-virtual {v0, v1}, Ljava/util/ArrayList;->add(Ljava/lang/Object;)Z

    .line 171
    invoke-virtual {p0}, Lcom/cyjh/elfin/fragment/AbGamesDetailFragment;->getActivity()Landroid/support/v4/app/FragmentActivity;

    move-result-object v0

    invoke-static {v0}, Lcom/squareup/picasso/Picasso;->with(Landroid/content/Context;)Lcom/squareup/picasso/Picasso;

    move-result-object v0

    iget-object v1, p0, Lcom/cyjh/elfin/fragment/AbGamesDetailFragment;->mGameInfo:Lcom/cyjh/elfin/entity/GameInfo;

    iget-object v1, v1, Lcom/cyjh/elfin/entity/GameInfo;->Image1:Ljava/lang/String;

    invoke-virtual {v0, v1}, Lcom/squareup/picasso/Picasso;->load(Ljava/lang/String;)Lcom/squareup/picasso/RequestCreator;

    move-result-object v0

    invoke-virtual {v0, v2}, Lcom/squareup/picasso/RequestCreator;->placeholder(I)Lcom/squareup/picasso/RequestCreator;

    move-result-object v0

    .line 172
    invoke-virtual {v0, v2}, Lcom/squareup/picasso/RequestCreator;->error(I)Lcom/squareup/picasso/RequestCreator;

    move-result-object v0

    iget-object v1, p0, Lcom/cyjh/elfin/fragment/AbGamesDetailFragment;->mImgPic1:Landroid/widget/ImageView;

    invoke-virtual {v0, v1}, Lcom/squareup/picasso/RequestCreator;->into(Landroid/widget/ImageView;)V

    .line 176
    :goto_0
    iget-object v0, p0, Lcom/cyjh/elfin/fragment/AbGamesDetailFragment;->mGameInfo:Lcom/cyjh/elfin/entity/GameInfo;

    iget-object v0, v0, Lcom/cyjh/elfin/entity/GameInfo;->Image2:Ljava/lang/String;

    invoke-static {v0}, Landroid/text/TextUtils;->isEmpty(Ljava/lang/CharSequence;)Z

    move-result v0

    if-nez v0, :cond_1

    .line 177
    iget-object v0, p0, Lcom/cyjh/elfin/fragment/AbGamesDetailFragment;->mImgPic2:Landroid/widget/ImageView;

    invoke-virtual {v0, v3}, Landroid/widget/ImageView;->setVisibility(I)V

    .line 178
    iget-object v0, p0, Lcom/cyjh/elfin/fragment/AbGamesDetailFragment;->imgList:Ljava/util/ArrayList;

    iget-object v1, p0, Lcom/cyjh/elfin/fragment/AbGamesDetailFragment;->mGameInfo:Lcom/cyjh/elfin/entity/GameInfo;

    iget-object v1, v1, Lcom/cyjh/elfin/entity/GameInfo;->Image2:Ljava/lang/String;

    invoke-virtual {v0, v1}, Ljava/util/ArrayList;->add(Ljava/lang/Object;)Z

    .line 179
    invoke-virtual {p0}, Lcom/cyjh/elfin/fragment/AbGamesDetailFragment;->getActivity()Landroid/support/v4/app/FragmentActivity;

    move-result-object v0

    invoke-static {v0}, Lcom/squareup/picasso/Picasso;->with(Landroid/content/Context;)Lcom/squareup/picasso/Picasso;

    move-result-object v0

    iget-object v1, p0, Lcom/cyjh/elfin/fragment/AbGamesDetailFragment;->mGameInfo:Lcom/cyjh/elfin/entity/GameInfo;

    iget-object v1, v1, Lcom/cyjh/elfin/entity/GameInfo;->Image2:Ljava/lang/String;

    invoke-virtual {v0, v1}, Lcom/squareup/picasso/Picasso;->load(Ljava/lang/String;)Lcom/squareup/picasso/RequestCreator;

    move-result-object v0

    invoke-virtual {v0, v2}, Lcom/squareup/picasso/RequestCreator;->placeholder(I)Lcom/squareup/picasso/RequestCreator;

    move-result-object v0

    .line 180
    invoke-virtual {v0, v2}, Lcom/squareup/picasso/RequestCreator;->error(I)Lcom/squareup/picasso/RequestCreator;

    move-result-object v0

    iget-object v1, p0, Lcom/cyjh/elfin/fragment/AbGamesDetailFragment;->mImgPic2:Landroid/widget/ImageView;

    invoke-virtual {v0, v1}, Lcom/squareup/picasso/RequestCreator;->into(Landroid/widget/ImageView;)V

    .line 184
    :goto_1
    iget-object v0, p0, Lcom/cyjh/elfin/fragment/AbGamesDetailFragment;->mGameInfo:Lcom/cyjh/elfin/entity/GameInfo;

    iget-object v0, v0, Lcom/cyjh/elfin/entity/GameInfo;->Image3:Ljava/lang/String;

    invoke-static {v0}, Landroid/text/TextUtils;->isEmpty(Ljava/lang/CharSequence;)Z

    move-result v0

    if-nez v0, :cond_2

    .line 185
    iget-object v0, p0, Lcom/cyjh/elfin/fragment/AbGamesDetailFragment;->mImgPic3:Landroid/widget/ImageView;

    invoke-virtual {v0, v3}, Landroid/widget/ImageView;->setVisibility(I)V

    .line 186
    iget-object v0, p0, Lcom/cyjh/elfin/fragment/AbGamesDetailFragment;->imgList:Ljava/util/ArrayList;

    iget-object v1, p0, Lcom/cyjh/elfin/fragment/AbGamesDetailFragment;->mGameInfo:Lcom/cyjh/elfin/entity/GameInfo;

    iget-object v1, v1, Lcom/cyjh/elfin/entity/GameInfo;->Image3:Ljava/lang/String;

    invoke-virtual {v0, v1}, Ljava/util/ArrayList;->add(Ljava/lang/Object;)Z

    .line 187
    invoke-virtual {p0}, Lcom/cyjh/elfin/fragment/AbGamesDetailFragment;->getActivity()Landroid/support/v4/app/FragmentActivity;

    move-result-object v0

    invoke-static {v0}, Lcom/squareup/picasso/Picasso;->with(Landroid/content/Context;)Lcom/squareup/picasso/Picasso;

    move-result-object v0

    iget-object v1, p0, Lcom/cyjh/elfin/fragment/AbGamesDetailFragment;->mGameInfo:Lcom/cyjh/elfin/entity/GameInfo;

    iget-object v1, v1, Lcom/cyjh/elfin/entity/GameInfo;->Image3:Ljava/lang/String;

    invoke-virtual {v0, v1}, Lcom/squareup/picasso/Picasso;->load(Ljava/lang/String;)Lcom/squareup/picasso/RequestCreator;

    move-result-object v0

    invoke-virtual {v0, v2}, Lcom/squareup/picasso/RequestCreator;->placeholder(I)Lcom/squareup/picasso/RequestCreator;

    move-result-object v0

    .line 188
    invoke-virtual {v0, v2}, Lcom/squareup/picasso/RequestCreator;->error(I)Lcom/squareup/picasso/RequestCreator;

    move-result-object v0

    iget-object v1, p0, Lcom/cyjh/elfin/fragment/AbGamesDetailFragment;->mImgPic3:Landroid/widget/ImageView;

    invoke-virtual {v0, v1}, Lcom/squareup/picasso/RequestCreator;->into(Landroid/widget/ImageView;)V

    .line 192
    :goto_2
    iget-object v0, p0, Lcom/cyjh/elfin/fragment/AbGamesDetailFragment;->mGameInfo:Lcom/cyjh/elfin/entity/GameInfo;

    iget-object v0, v0, Lcom/cyjh/elfin/entity/GameInfo;->Image4:Ljava/lang/String;

    invoke-static {v0}, Landroid/text/TextUtils;->isEmpty(Ljava/lang/CharSequence;)Z

    move-result v0

    if-nez v0, :cond_3

    .line 193
    iget-object v0, p0, Lcom/cyjh/elfin/fragment/AbGamesDetailFragment;->mImgPic4:Landroid/widget/ImageView;

    invoke-virtual {v0, v3}, Landroid/widget/ImageView;->setVisibility(I)V

    .line 194
    iget-object v0, p0, Lcom/cyjh/elfin/fragment/AbGamesDetailFragment;->imgList:Ljava/util/ArrayList;

    iget-object v1, p0, Lcom/cyjh/elfin/fragment/AbGamesDetailFragment;->mGameInfo:Lcom/cyjh/elfin/entity/GameInfo;

    iget-object v1, v1, Lcom/cyjh/elfin/entity/GameInfo;->Image4:Ljava/lang/String;

    invoke-virtual {v0, v1}, Ljava/util/ArrayList;->add(Ljava/lang/Object;)Z

    .line 195
    invoke-virtual {p0}, Lcom/cyjh/elfin/fragment/AbGamesDetailFragment;->getActivity()Landroid/support/v4/app/FragmentActivity;

    move-result-object v0

    invoke-static {v0}, Lcom/squareup/picasso/Picasso;->with(Landroid/content/Context;)Lcom/squareup/picasso/Picasso;

    move-result-object v0

    iget-object v1, p0, Lcom/cyjh/elfin/fragment/AbGamesDetailFragment;->mGameInfo:Lcom/cyjh/elfin/entity/GameInfo;

    iget-object v1, v1, Lcom/cyjh/elfin/entity/GameInfo;->Image4:Ljava/lang/String;

    invoke-virtual {v0, v1}, Lcom/squareup/picasso/Picasso;->load(Ljava/lang/String;)Lcom/squareup/picasso/RequestCreator;

    move-result-object v0

    invoke-virtual {v0, v2}, Lcom/squareup/picasso/RequestCreator;->placeholder(I)Lcom/squareup/picasso/RequestCreator;

    move-result-object v0

    .line 196
    invoke-virtual {v0, v2}, Lcom/squareup/picasso/RequestCreator;->error(I)Lcom/squareup/picasso/RequestCreator;

    move-result-object v0

    iget-object v1, p0, Lcom/cyjh/elfin/fragment/AbGamesDetailFragment;->mImgPic4:Landroid/widget/ImageView;

    invoke-virtual {v0, v1}, Lcom/squareup/picasso/RequestCreator;->into(Landroid/widget/ImageView;)V

    .line 200
    :goto_3
    iget-object v0, p0, Lcom/cyjh/elfin/fragment/AbGamesDetailFragment;->mGameInfo:Lcom/cyjh/elfin/entity/GameInfo;

    iget-object v0, v0, Lcom/cyjh/elfin/entity/GameInfo;->Image5:Ljava/lang/String;

    invoke-static {v0}, Landroid/text/TextUtils;->isEmpty(Ljava/lang/CharSequence;)Z

    move-result v0

    if-nez v0, :cond_4

    .line 201
    iget-object v0, p0, Lcom/cyjh/elfin/fragment/AbGamesDetailFragment;->mImgPic5:Landroid/widget/ImageView;

    invoke-virtual {v0, v3}, Landroid/widget/ImageView;->setVisibility(I)V

    .line 202
    iget-object v0, p0, Lcom/cyjh/elfin/fragment/AbGamesDetailFragment;->imgList:Ljava/util/ArrayList;

    iget-object v1, p0, Lcom/cyjh/elfin/fragment/AbGamesDetailFragment;->mGameInfo:Lcom/cyjh/elfin/entity/GameInfo;

    iget-object v1, v1, Lcom/cyjh/elfin/entity/GameInfo;->Image5:Ljava/lang/String;

    invoke-virtual {v0, v1}, Ljava/util/ArrayList;->add(Ljava/lang/Object;)Z

    .line 203
    invoke-virtual {p0}, Lcom/cyjh/elfin/fragment/AbGamesDetailFragment;->getActivity()Landroid/support/v4/app/FragmentActivity;

    move-result-object v0

    invoke-static {v0}, Lcom/squareup/picasso/Picasso;->with(Landroid/content/Context;)Lcom/squareup/picasso/Picasso;

    move-result-object v0

    iget-object v1, p0, Lcom/cyjh/elfin/fragment/AbGamesDetailFragment;->mGameInfo:Lcom/cyjh/elfin/entity/GameInfo;

    iget-object v1, v1, Lcom/cyjh/elfin/entity/GameInfo;->Image5:Ljava/lang/String;

    invoke-virtual {v0, v1}, Lcom/squareup/picasso/Picasso;->load(Ljava/lang/String;)Lcom/squareup/picasso/RequestCreator;

    move-result-object v0

    invoke-virtual {v0, v2}, Lcom/squareup/picasso/RequestCreator;->placeholder(I)Lcom/squareup/picasso/RequestCreator;

    move-result-object v0

    .line 204
    invoke-virtual {v0, v2}, Lcom/squareup/picasso/RequestCreator;->error(I)Lcom/squareup/picasso/RequestCreator;

    move-result-object v0

    iget-object v1, p0, Lcom/cyjh/elfin/fragment/AbGamesDetailFragment;->mImgPic5:Landroid/widget/ImageView;

    invoke-virtual {v0, v1}, Lcom/squareup/picasso/RequestCreator;->into(Landroid/widget/ImageView;)V

    .line 208
    :goto_4
    iget-object v0, p0, Lcom/cyjh/elfin/fragment/AbGamesDetailFragment;->imgList:Ljava/util/ArrayList;

    invoke-virtual {v0}, Ljava/util/ArrayList;->size()I

    move-result v0

    if-lez v0, :cond_5

    .line 209
    iget-object v0, p0, Lcom/cyjh/elfin/fragment/AbGamesDetailFragment;->mHorizontalScrollView:Landroid/widget/HorizontalScrollView;

    invoke-virtual {v0, v3}, Landroid/widget/HorizontalScrollView;->setVisibility(I)V

    .line 213
    :goto_5
    return-void

    .line 174
    :cond_0
    iget-object v0, p0, Lcom/cyjh/elfin/fragment/AbGamesDetailFragment;->mImgPic1:Landroid/widget/ImageView;

    invoke-virtual {v0, v4}, Landroid/widget/ImageView;->setVisibility(I)V

    goto/16 :goto_0

    .line 182
    :cond_1
    iget-object v0, p0, Lcom/cyjh/elfin/fragment/AbGamesDetailFragment;->mImgPic2:Landroid/widget/ImageView;

    invoke-virtual {v0, v4}, Landroid/widget/ImageView;->setVisibility(I)V

    goto/16 :goto_1

    .line 190
    :cond_2
    iget-object v0, p0, Lcom/cyjh/elfin/fragment/AbGamesDetailFragment;->mImgPic3:Landroid/widget/ImageView;

    invoke-virtual {v0, v4}, Landroid/widget/ImageView;->setVisibility(I)V

    goto/16 :goto_2

    .line 198
    :cond_3
    iget-object v0, p0, Lcom/cyjh/elfin/fragment/AbGamesDetailFragment;->mImgPic4:Landroid/widget/ImageView;

    invoke-virtual {v0, v4}, Landroid/widget/ImageView;->setVisibility(I)V

    goto :goto_3

    .line 206
    :cond_4
    iget-object v0, p0, Lcom/cyjh/elfin/fragment/AbGamesDetailFragment;->mImgPic5:Landroid/widget/ImageView;

    invoke-virtual {v0, v4}, Landroid/widget/ImageView;->setVisibility(I)V

    goto :goto_4

    .line 211
    :cond_5
    iget-object v0, p0, Lcom/cyjh/elfin/fragment/AbGamesDetailFragment;->mHorizontalScrollView:Landroid/widget/HorizontalScrollView;

    invoke-virtual {v0, v4}, Landroid/widget/HorizontalScrollView;->setVisibility(I)V

    goto :goto_5
.end method


# virtual methods
.method public firstLoadDataError(Lcom/android/volley/VolleyError;)V
    .locals 0
    .param p1, "error"    # Lcom/android/volley/VolleyError;

    .prologue
    .line 222
    invoke-virtual {p0}, Lcom/cyjh/elfin/fragment/AbGamesDetailFragment;->onLoadFailed()V

    .line 223
    return-void
.end method

.method public firstLoadDataSuccess(Ljava/lang/Object;)V
    .locals 1
    .param p1, "object"    # Ljava/lang/Object;

    .prologue
    .line 146
    move-object v0, p1

    check-cast v0, Lcom/cyjh/elfin/entity/GameDetails;

    .line 147
    .local v0, "gameDetails":Lcom/cyjh/elfin/entity/GameDetails;
    invoke-virtual {p0}, Lcom/cyjh/elfin/fragment/AbGamesDetailFragment;->onLoadSuccess()V

    .line 148
    invoke-direct {p0, v0}, Lcom/cyjh/elfin/fragment/AbGamesDetailFragment;->setGameData(Lcom/cyjh/elfin/entity/GameDetails;)V

    .line 149
    return-void
.end method

.method public firstLoadDataSuccessAndEmpty()V
    .locals 0

    .prologue
    .line 217
    invoke-virtual {p0}, Lcom/cyjh/elfin/fragment/AbGamesDetailFragment;->onLoadEmpty()V

    .line 218
    return-void
.end method

.method public getContentView()Landroid/view/View;
    .locals 1

    .prologue
    .line 141
    iget-object v0, p0, Lcom/cyjh/elfin/fragment/AbGamesDetailFragment;->mRlContent:Landroid/widget/LinearLayout;

    return-object v0
.end method

.method public getEmptyView()Landroid/view/View;
    .locals 3

    .prologue
    .line 398
    invoke-virtual {p0}, Lcom/cyjh/elfin/fragment/AbGamesDetailFragment;->getActivity()Landroid/support/v4/app/FragmentActivity;

    move-result-object v0

    invoke-virtual {v0}, Landroid/support/v4/app/FragmentActivity;->getApplicationContext()Landroid/content/Context;

    move-result-object v0

    iget-object v1, p0, Lcom/cyjh/elfin/fragment/AbGamesDetailFragment;->mContentView:Landroid/view/View;

    new-instance v2, Lcom/cyjh/elfin/fragment/AbGamesDetailFragment$6;

    invoke-direct {v2, p0}, Lcom/cyjh/elfin/fragment/AbGamesDetailFragment$6;-><init>(Lcom/cyjh/elfin/fragment/AbGamesDetailFragment;)V

    invoke-static {v0, v1, v2}, Lcom/cyjh/elfin/customview/loadstate/LoadstatueViewFactory;->getLoadEmpty(Landroid/content/Context;Landroid/view/View;Landroid/view/View$OnClickListener;)Landroid/view/View;

    move-result-object v0

    return-object v0
.end method

.method public getLoadFailedView()Landroid/view/View;
    .locals 3

    .prologue
    .line 387
    invoke-virtual {p0}, Lcom/cyjh/elfin/fragment/AbGamesDetailFragment;->getActivity()Landroid/support/v4/app/FragmentActivity;

    move-result-object v0

    invoke-virtual {v0}, Landroid/support/v4/app/FragmentActivity;->getApplicationContext()Landroid/content/Context;

    move-result-object v0

    iget-object v1, p0, Lcom/cyjh/elfin/fragment/AbGamesDetailFragment;->mContentView:Landroid/view/View;

    new-instance v2, Lcom/cyjh/elfin/fragment/AbGamesDetailFragment$5;

    invoke-direct {v2, p0}, Lcom/cyjh/elfin/fragment/AbGamesDetailFragment$5;-><init>(Lcom/cyjh/elfin/fragment/AbGamesDetailFragment;)V

    invoke-static {v0, v1, v2}, Lcom/cyjh/elfin/customview/loadstate/LoadstatueViewFactory;->getLoadFailed(Landroid/content/Context;Landroid/view/View;Landroid/view/View$OnClickListener;)Landroid/view/View;

    move-result-object v0

    return-object v0
.end method

.method public getLoadingView()Landroid/view/View;
    .locals 2

    .prologue
    .line 381
    invoke-virtual {p0}, Lcom/cyjh/elfin/fragment/AbGamesDetailFragment;->getActivity()Landroid/support/v4/app/FragmentActivity;

    move-result-object v0

    invoke-virtual {v0}, Landroid/support/v4/app/FragmentActivity;->getApplicationContext()Landroid/content/Context;

    move-result-object v0

    iget-object v1, p0, Lcom/cyjh/elfin/fragment/AbGamesDetailFragment;->mContentView:Landroid/view/View;

    invoke-static {v0, v1}, Lcom/cyjh/elfin/customview/loadstate/LoadstatueViewFactory;->getLoadingView(Landroid/content/Context;Landroid/view/View;)Landroid/view/View;

    move-result-object v0

    return-object v0
.end method

.method public getNotNetworkView()Landroid/view/View;
    .locals 3

    .prologue
    .line 409
    invoke-virtual {p0}, Lcom/cyjh/elfin/fragment/AbGamesDetailFragment;->getActivity()Landroid/support/v4/app/FragmentActivity;

    move-result-object v0

    invoke-virtual {v0}, Landroid/support/v4/app/FragmentActivity;->getApplicationContext()Landroid/content/Context;

    move-result-object v0

    iget-object v1, p0, Lcom/cyjh/elfin/fragment/AbGamesDetailFragment;->mContentView:Landroid/view/View;

    new-instance v2, Lcom/cyjh/elfin/fragment/AbGamesDetailFragment$7;

    invoke-direct {v2, p0}, Lcom/cyjh/elfin/fragment/AbGamesDetailFragment$7;-><init>(Lcom/cyjh/elfin/fragment/AbGamesDetailFragment;)V

    invoke-static {v0, v1, v2}, Lcom/cyjh/elfin/customview/loadstate/LoadstatueViewFactory;->getLoadNotNetwork(Landroid/content/Context;Landroid/view/View;Landroid/view/View$OnClickListener;)Landroid/view/View;

    move-result-object v0

    return-object v0
.end method

.method public hideLoading()V
    .locals 2

    .prologue
    .line 279
    iget-object v0, p0, Lcom/cyjh/elfin/fragment/AbGamesDetailFragment;->mSwipeRefresh:Landroid/support/v4/widget/SwipeRefreshLayout;

    new-instance v1, Lcom/cyjh/elfin/fragment/AbGamesDetailFragment$4;

    invoke-direct {v1, p0}, Lcom/cyjh/elfin/fragment/AbGamesDetailFragment$4;-><init>(Lcom/cyjh/elfin/fragment/AbGamesDetailFragment;)V

    invoke-virtual {v0, v1}, Landroid/support/v4/widget/SwipeRefreshLayout;->post(Ljava/lang/Runnable;)Z

    .line 285
    return-void
.end method

.method public initDataAfterView()V
    .locals 2

    .prologue
    .line 118
    invoke-virtual {p0}, Lcom/cyjh/elfin/fragment/AbGamesDetailFragment;->getArguments()Landroid/os/Bundle;

    move-result-object v0

    const-string v1, "id"

    invoke-virtual {v0, v1}, Landroid/os/Bundle;->getString(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v0

    iput-object v0, p0, Lcom/cyjh/elfin/fragment/AbGamesDetailFragment;->gameId:Ljava/lang/String;

    .line 119
    new-instance v0, Lcom/cyjh/elfin/mvp/presenters/AbGameDetailsPresenter;

    invoke-virtual {p0}, Lcom/cyjh/elfin/fragment/AbGamesDetailFragment;->getActivity()Landroid/support/v4/app/FragmentActivity;

    move-result-object v1

    invoke-direct {v0, p0, v1, p0}, Lcom/cyjh/elfin/mvp/presenters/AbGameDetailsPresenter;-><init>(Lcom/cyjh/elfin/mvp/views/loadstate/ILoadState;Landroid/content/Context;Lcom/cyjh/elfin/mvp/views/loadstate/FindBasicInf;)V

    iput-object v0, p0, Lcom/cyjh/elfin/fragment/AbGamesDetailFragment;->abGameDetailsPresenter:Lcom/cyjh/elfin/mvp/presenters/AbGameDetailsPresenter;

    .line 120
    iget-object v0, p0, Lcom/cyjh/elfin/fragment/AbGamesDetailFragment;->abGameDetailsPresenter:Lcom/cyjh/elfin/mvp/presenters/AbGameDetailsPresenter;

    iget-object v1, p0, Lcom/cyjh/elfin/fragment/AbGamesDetailFragment;->gameId:Ljava/lang/String;

    invoke-virtual {v0, v1}, Lcom/cyjh/elfin/mvp/presenters/AbGameDetailsPresenter;->setGameId(Ljava/lang/String;)V

    .line 121
    iget-object v0, p0, Lcom/cyjh/elfin/fragment/AbGamesDetailFragment;->abGameDetailsPresenter:Lcom/cyjh/elfin/mvp/presenters/AbGameDetailsPresenter;

    const/4 v1, 0x1

    invoke-virtual {v0, v1}, Lcom/cyjh/elfin/mvp/presenters/AbGameDetailsPresenter;->firstLoadData(I)V

    .line 122
    return-void
.end method

.method public initListener()V
    .locals 2

    .prologue
    .line 126
    iget-object v0, p0, Lcom/cyjh/elfin/fragment/AbGamesDetailFragment;->mSwipeRefresh:Landroid/support/v4/widget/SwipeRefreshLayout;

    new-instance v1, Lcom/cyjh/elfin/fragment/AbGamesDetailFragment$2;

    invoke-direct {v1, p0}, Lcom/cyjh/elfin/fragment/AbGamesDetailFragment$2;-><init>(Lcom/cyjh/elfin/fragment/AbGamesDetailFragment;)V

    invoke-virtual {v0, v1}, Landroid/support/v4/widget/SwipeRefreshLayout;->setOnRefreshListener(Landroid/support/v4/widget/SwipeRefreshLayout$OnRefreshListener;)V

    .line 132
    iget-object v0, p0, Lcom/cyjh/elfin/fragment/AbGamesDetailFragment;->mImgPic1:Landroid/widget/ImageView;

    invoke-virtual {v0, p0}, Landroid/widget/ImageView;->setOnClickListener(Landroid/view/View$OnClickListener;)V

    .line 133
    iget-object v0, p0, Lcom/cyjh/elfin/fragment/AbGamesDetailFragment;->mImgPic2:Landroid/widget/ImageView;

    invoke-virtual {v0, p0}, Landroid/widget/ImageView;->setOnClickListener(Landroid/view/View$OnClickListener;)V

    .line 134
    iget-object v0, p0, Lcom/cyjh/elfin/fragment/AbGamesDetailFragment;->mImgPic3:Landroid/widget/ImageView;

    invoke-virtual {v0, p0}, Landroid/widget/ImageView;->setOnClickListener(Landroid/view/View$OnClickListener;)V

    .line 135
    iget-object v0, p0, Lcom/cyjh/elfin/fragment/AbGamesDetailFragment;->mImgPic4:Landroid/widget/ImageView;

    invoke-virtual {v0, p0}, Landroid/widget/ImageView;->setOnClickListener(Landroid/view/View$OnClickListener;)V

    .line 136
    iget-object v0, p0, Lcom/cyjh/elfin/fragment/AbGamesDetailFragment;->mImgPic5:Landroid/widget/ImageView;

    invoke-virtual {v0, p0}, Landroid/widget/ImageView;->setOnClickListener(Landroid/view/View$OnClickListener;)V

    .line 137
    return-void
.end method

.method public initView(Landroid/view/LayoutInflater;Landroid/view/ViewGroup;Landroid/os/Bundle;)Landroid/view/View;
    .locals 5
    .param p1, "inflater"    # Landroid/view/LayoutInflater;
    .param p2, "container"    # Landroid/view/ViewGroup;
    .param p3, "savedInstanceState"    # Landroid/os/Bundle;

    .prologue
    const/4 v4, 0x0

    .line 86
    const v1, 0x7f040045

    invoke-virtual {p1, v1, p2, v4}, Landroid/view/LayoutInflater;->inflate(ILandroid/view/ViewGroup;Z)Landroid/view/View;

    move-result-object v0

    .line 87
    .local v0, "view":Landroid/view/View;
    const v1, 0x7f0f00ea

    invoke-virtual {v0, v1}, Landroid/view/View;->findViewById(I)Landroid/view/View;

    move-result-object v1

    check-cast v1, Landroid/support/v4/widget/SwipeRefreshLayout;

    iput-object v1, p0, Lcom/cyjh/elfin/fragment/AbGamesDetailFragment;->mSwipeRefresh:Landroid/support/v4/widget/SwipeRefreshLayout;

    .line 88
    iget-object v1, p0, Lcom/cyjh/elfin/fragment/AbGamesDetailFragment;->mSwipeRefresh:Landroid/support/v4/widget/SwipeRefreshLayout;

    const/4 v2, 0x1

    new-array v2, v2, [I

    const v3, 0x7f0e0012

    aput v3, v2, v4

    invoke-virtual {v1, v2}, Landroid/support/v4/widget/SwipeRefreshLayout;->setColorSchemeResources([I)V

    .line 89
    const v1, 0x7f0f0178

    invoke-virtual {v0, v1}, Landroid/view/View;->findViewById(I)Landroid/view/View;

    move-result-object v1

    check-cast v1, Landroid/widget/ImageView;

    iput-object v1, p0, Lcom/cyjh/elfin/fragment/AbGamesDetailFragment;->mImgLogo:Landroid/widget/ImageView;

    .line 90
    const v1, 0x7f0f0179

    invoke-virtual {v0, v1}, Landroid/view/View;->findViewById(I)Landroid/view/View;

    move-result-object v1

    check-cast v1, Landroid/widget/TextView;

    iput-object v1, p0, Lcom/cyjh/elfin/fragment/AbGamesDetailFragment;->mTvTitle:Landroid/widget/TextView;

    .line 91
    const v1, 0x7f0f017a

    invoke-virtual {v0, v1}, Landroid/view/View;->findViewById(I)Landroid/view/View;

    move-result-object v1

    check-cast v1, Landroid/widget/TextView;

    iput-object v1, p0, Lcom/cyjh/elfin/fragment/AbGamesDetailFragment;->mTvLabelOne:Landroid/widget/TextView;

    .line 92
    const v1, 0x7f0f017b

    invoke-virtual {v0, v1}, Landroid/view/View;->findViewById(I)Landroid/view/View;

    move-result-object v1

    check-cast v1, Landroid/widget/TextView;

    iput-object v1, p0, Lcom/cyjh/elfin/fragment/AbGamesDetailFragment;->mTvLabelTwo:Landroid/widget/TextView;

    .line 93
    const v1, 0x7f0f017c

    invoke-virtual {v0, v1}, Landroid/view/View;->findViewById(I)Landroid/view/View;

    move-result-object v1

    check-cast v1, Landroid/widget/TextView;

    iput-object v1, p0, Lcom/cyjh/elfin/fragment/AbGamesDetailFragment;->mTvLabelThree:Landroid/widget/TextView;

    .line 94
    const v1, 0x7f0f017d

    invoke-virtual {v0, v1}, Landroid/view/View;->findViewById(I)Landroid/view/View;

    move-result-object v1

    check-cast v1, Landroid/widget/TextView;

    iput-object v1, p0, Lcom/cyjh/elfin/fragment/AbGamesDetailFragment;->mTvLabelFour:Landroid/widget/TextView;

    .line 95
    const v1, 0x7f0f00f4

    invoke-virtual {v0, v1}, Landroid/view/View;->findViewById(I)Landroid/view/View;

    move-result-object v1

    check-cast v1, Landroid/widget/TextView;

    iput-object v1, p0, Lcom/cyjh/elfin/fragment/AbGamesDetailFragment;->mTvDes:Landroid/widget/TextView;

    .line 96
    const v1, 0x7f0f00f5

    invoke-virtual {v0, v1}, Landroid/view/View;->findViewById(I)Landroid/view/View;

    move-result-object v1

    check-cast v1, Lcom/cyjh/elfin/customview/GameDownloadView;

    iput-object v1, p0, Lcom/cyjh/elfin/fragment/AbGamesDetailFragment;->gameDownloadView:Lcom/cyjh/elfin/customview/GameDownloadView;

    .line 97
    iget-object v1, p0, Lcom/cyjh/elfin/fragment/AbGamesDetailFragment;->gameDownloadView:Lcom/cyjh/elfin/customview/GameDownloadView;

    const/4 v2, 0x4

    invoke-virtual {v1, v2}, Lcom/cyjh/elfin/customview/GameDownloadView;->setVisibility(I)V

    .line 98
    const v1, 0x7f0f00ef

    invoke-virtual {v0, v1}, Landroid/view/View;->findViewById(I)Landroid/view/View;

    move-result-object v1

    check-cast v1, Landroid/widget/ImageView;

    iput-object v1, p0, Lcom/cyjh/elfin/fragment/AbGamesDetailFragment;->mImgPic1:Landroid/widget/ImageView;

    .line 99
    const v1, 0x7f0f00f0

    invoke-virtual {v0, v1}, Landroid/view/View;->findViewById(I)Landroid/view/View;

    move-result-object v1

    check-cast v1, Landroid/widget/ImageView;

    iput-object v1, p0, Lcom/cyjh/elfin/fragment/AbGamesDetailFragment;->mImgPic2:Landroid/widget/ImageView;

    .line 100
    const v1, 0x7f0f00f1

    invoke-virtual {v0, v1}, Landroid/view/View;->findViewById(I)Landroid/view/View;

    move-result-object v1

    check-cast v1, Landroid/widget/ImageView;

    iput-object v1, p0, Lcom/cyjh/elfin/fragment/AbGamesDetailFragment;->mImgPic3:Landroid/widget/ImageView;

    .line 101
    const v1, 0x7f0f00f2

    invoke-virtual {v0, v1}, Landroid/view/View;->findViewById(I)Landroid/view/View;

    move-result-object v1

    check-cast v1, Landroid/widget/ImageView;

    iput-object v1, p0, Lcom/cyjh/elfin/fragment/AbGamesDetailFragment;->mImgPic4:Landroid/widget/ImageView;

    .line 102
    const v1, 0x7f0f00f3

    invoke-virtual {v0, v1}, Landroid/view/View;->findViewById(I)Landroid/view/View;

    move-result-object v1

    check-cast v1, Landroid/widget/ImageView;

    iput-object v1, p0, Lcom/cyjh/elfin/fragment/AbGamesDetailFragment;->mImgPic5:Landroid/widget/ImageView;

    .line 103
    const v1, 0x7f0f00ee

    invoke-virtual {v0, v1}, Landroid/view/View;->findViewById(I)Landroid/view/View;

    move-result-object v1

    check-cast v1, Landroid/widget/HorizontalScrollView;

    iput-object v1, p0, Lcom/cyjh/elfin/fragment/AbGamesDetailFragment;->mHorizontalScrollView:Landroid/widget/HorizontalScrollView;

    .line 104
    const v1, 0x7f0f00e9

    invoke-virtual {v0, v1}, Landroid/view/View;->findViewById(I)Landroid/view/View;

    move-result-object v1

    check-cast v1, Landroid/widget/LinearLayout;

    iput-object v1, p0, Lcom/cyjh/elfin/fragment/AbGamesDetailFragment;->mRlContent:Landroid/widget/LinearLayout;

    .line 105
    const v1, 0x7f0f00eb

    invoke-virtual {v0, v1}, Landroid/view/View;->findViewById(I)Landroid/view/View;

    move-result-object v1

    check-cast v1, Landroid/widget/ScrollView;

    iput-object v1, p0, Lcom/cyjh/elfin/fragment/AbGamesDetailFragment;->mScrollView:Landroid/widget/ScrollView;

    .line 106
    iget-object v1, p0, Lcom/cyjh/elfin/fragment/AbGamesDetailFragment;->mScrollView:Landroid/widget/ScrollView;

    invoke-virtual {v1}, Landroid/widget/ScrollView;->getViewTreeObserver()Landroid/view/ViewTreeObserver;

    move-result-object v1

    new-instance v2, Lcom/cyjh/elfin/fragment/AbGamesDetailFragment$1;

    invoke-direct {v2, p0}, Lcom/cyjh/elfin/fragment/AbGamesDetailFragment$1;-><init>(Lcom/cyjh/elfin/fragment/AbGamesDetailFragment;)V

    invoke-virtual {v1, v2}, Landroid/view/ViewTreeObserver;->addOnScrollChangedListener(Landroid/view/ViewTreeObserver$OnScrollChangedListener;)V

    .line 113
    return-object v0
.end method

.method public loadDataButNotNetwork()V
    .locals 0

    .prologue
    .line 264
    return-void
.end method

.method public loadDataSuccessAndLast()V
    .locals 0

    .prologue
    .line 259
    return-void
.end method

.method public moreLoadDataError(Lcom/android/volley/VolleyError;)V
    .locals 0
    .param p1, "error"    # Lcom/android/volley/VolleyError;

    .prologue
    .line 254
    return-void
.end method

.method public moreLoadDataSuccess(Ljava/lang/Object;)V
    .locals 0
    .param p1, "object"    # Ljava/lang/Object;

    .prologue
    .line 244
    return-void
.end method

.method public moreLoadDataSuccessAndEmpty()V
    .locals 0

    .prologue
    .line 249
    return-void
.end method

.method public onClick(Landroid/view/View;)V
    .locals 3
    .param p1, "v"    # Landroid/view/View;

    .prologue
    .line 420
    invoke-virtual {p1}, Landroid/view/View;->getId()I

    move-result v0

    packed-switch v0, :pswitch_data_0

    .line 437
    :goto_0
    return-void

    .line 422
    :pswitch_0
    invoke-virtual {p0}, Lcom/cyjh/elfin/fragment/AbGamesDetailFragment;->getActivity()Landroid/support/v4/app/FragmentActivity;

    move-result-object v0

    iget-object v1, p0, Lcom/cyjh/elfin/fragment/AbGamesDetailFragment;->imgList:Ljava/util/ArrayList;

    const/4 v2, 0x1

    invoke-static {v0, v1, v2}, Lcom/cyjh/elfin/util/IntentUtils;->toImagePicZoomActivity(Landroid/content/Context;Ljava/util/ArrayList;I)V

    goto :goto_0

    .line 425
    :pswitch_1
    invoke-virtual {p0}, Lcom/cyjh/elfin/fragment/AbGamesDetailFragment;->getActivity()Landroid/support/v4/app/FragmentActivity;

    move-result-object v0

    iget-object v1, p0, Lcom/cyjh/elfin/fragment/AbGamesDetailFragment;->imgList:Ljava/util/ArrayList;

    const/4 v2, 0x2

    invoke-static {v0, v1, v2}, Lcom/cyjh/elfin/util/IntentUtils;->toImagePicZoomActivity(Landroid/content/Context;Ljava/util/ArrayList;I)V

    goto :goto_0

    .line 428
    :pswitch_2
    invoke-virtual {p0}, Lcom/cyjh/elfin/fragment/AbGamesDetailFragment;->getActivity()Landroid/support/v4/app/FragmentActivity;

    move-result-object v0

    iget-object v1, p0, Lcom/cyjh/elfin/fragment/AbGamesDetailFragment;->imgList:Ljava/util/ArrayList;

    const/4 v2, 0x3

    invoke-static {v0, v1, v2}, Lcom/cyjh/elfin/util/IntentUtils;->toImagePicZoomActivity(Landroid/content/Context;Ljava/util/ArrayList;I)V

    goto :goto_0

    .line 431
    :pswitch_3
    invoke-virtual {p0}, Lcom/cyjh/elfin/fragment/AbGamesDetailFragment;->getActivity()Landroid/support/v4/app/FragmentActivity;

    move-result-object v0

    iget-object v1, p0, Lcom/cyjh/elfin/fragment/AbGamesDetailFragment;->imgList:Ljava/util/ArrayList;

    const/4 v2, 0x4

    invoke-static {v0, v1, v2}, Lcom/cyjh/elfin/util/IntentUtils;->toImagePicZoomActivity(Landroid/content/Context;Ljava/util/ArrayList;I)V

    goto :goto_0

    .line 434
    :pswitch_4
    invoke-virtual {p0}, Lcom/cyjh/elfin/fragment/AbGamesDetailFragment;->getActivity()Landroid/support/v4/app/FragmentActivity;

    move-result-object v0

    iget-object v1, p0, Lcom/cyjh/elfin/fragment/AbGamesDetailFragment;->imgList:Ljava/util/ArrayList;

    const/4 v2, 0x5

    invoke-static {v0, v1, v2}, Lcom/cyjh/elfin/util/IntentUtils;->toImagePicZoomActivity(Landroid/content/Context;Ljava/util/ArrayList;I)V

    goto :goto_0

    .line 420
    nop

    :pswitch_data_0
    .packed-switch 0x7f0f00ef
        :pswitch_0
        :pswitch_1
        :pswitch_2
        :pswitch_3
        :pswitch_4
    .end packed-switch
.end method

.method public onCreate(Landroid/os/Bundle;)V
    .locals 1
    .param p1, "savedInstanceState"    # Landroid/os/Bundle;

    .prologue
    .line 80
    invoke-super {p0, p1}, Lcom/cyjh/elfin/fragment/content/BasicLoadStateHttpFragment;->onCreate(Landroid/os/Bundle;)V

    .line 81
    invoke-static {}, Lorg/greenrobot/eventbus/EventBus;->getDefault()Lorg/greenrobot/eventbus/EventBus;

    move-result-object v0

    invoke-virtual {v0, p0}, Lorg/greenrobot/eventbus/EventBus;->register(Ljava/lang/Object;)V

    .line 82
    return-void
.end method

.method public onDestroy()V
    .locals 1

    .prologue
    .line 320
    invoke-super {p0}, Lcom/cyjh/elfin/fragment/content/BasicLoadStateHttpFragment;->onDestroy()V

    .line 321
    invoke-static {}, Lorg/greenrobot/eventbus/EventBus;->getDefault()Lorg/greenrobot/eventbus/EventBus;

    move-result-object v0

    invoke-virtual {v0, p0}, Lorg/greenrobot/eventbus/EventBus;->unregister(Ljava/lang/Object;)V

    .line 322
    iget-object v0, p0, Lcom/cyjh/elfin/fragment/AbGamesDetailFragment;->abGameDetailsPresenter:Lcom/cyjh/elfin/mvp/presenters/AbGameDetailsPresenter;

    invoke-virtual {v0}, Lcom/cyjh/elfin/mvp/presenters/AbGameDetailsPresenter;->StopNetCallBack()V

    .line 323
    return-void
.end method

.method public onMessageMainThread(Lcom/cyjh/elfin/entity/AbNormalGameEvent$DetailsPopDialogEvent;)V
    .locals 2
    .param p1, "event"    # Lcom/cyjh/elfin/entity/AbNormalGameEvent$DetailsPopDialogEvent;
    .annotation runtime Lorg/greenrobot/eventbus/Subscribe;
        threadMode = .enum Lorg/greenrobot/eventbus/ThreadMode;->MAIN:Lorg/greenrobot/eventbus/ThreadMode;
    .end annotation

    .prologue
    .line 357
    invoke-virtual {p1}, Lcom/cyjh/elfin/entity/AbNormalGameEvent$DetailsPopDialogEvent;->getUrl()Ljava/lang/String;

    move-result-object v0

    if-eqz v0, :cond_0

    .line 361
    invoke-virtual {p1}, Lcom/cyjh/elfin/entity/AbNormalGameEvent$DetailsPopDialogEvent;->getUrl()Ljava/lang/String;

    move-result-object v0

    iget-object v1, p0, Lcom/cyjh/elfin/fragment/AbGamesDetailFragment;->mGameInfo:Lcom/cyjh/elfin/entity/GameInfo;

    iget-object v1, v1, Lcom/cyjh/elfin/entity/GameInfo;->DownLoadUrl:Ljava/lang/String;

    invoke-virtual {v0, v1}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v0

    if-eqz v0, :cond_0

    .line 362
    iget-object v0, p0, Lcom/cyjh/elfin/fragment/AbGamesDetailFragment;->gameDownloadView:Lcom/cyjh/elfin/customview/GameDownloadView;

    invoke-virtual {v0}, Lcom/cyjh/elfin/customview/GameDownloadView;->startDownload()V

    .line 365
    :cond_0
    return-void
.end method

.method public onMessageMainThread(Lcom/cyjh/elfin/entity/AbNormalGameEvent$InstallAppSuccessEvent;)V
    .locals 2
    .param p1, "event"    # Lcom/cyjh/elfin/entity/AbNormalGameEvent$InstallAppSuccessEvent;
    .annotation runtime Lorg/greenrobot/eventbus/Subscribe;
        threadMode = .enum Lorg/greenrobot/eventbus/ThreadMode;->MAIN:Lorg/greenrobot/eventbus/ThreadMode;
    .end annotation

    .prologue
    .line 333
    iget-object v0, p0, Lcom/cyjh/elfin/fragment/AbGamesDetailFragment;->mGameInfo:Lcom/cyjh/elfin/entity/GameInfo;

    if-eqz v0, :cond_0

    new-instance v0, Ljava/lang/StringBuilder;

    invoke-direct {v0}, Ljava/lang/StringBuilder;-><init>()V

    const-string v1, "package:"

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    iget-object v1, p0, Lcom/cyjh/elfin/fragment/AbGamesDetailFragment;->mGameInfo:Lcom/cyjh/elfin/entity/GameInfo;

    iget-object v1, v1, Lcom/cyjh/elfin/entity/GameInfo;->PackageName:Ljava/lang/String;

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-virtual {v0}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v0

    invoke-virtual {p1}, Lcom/cyjh/elfin/entity/AbNormalGameEvent$InstallAppSuccessEvent;->getPackageName()Ljava/lang/String;

    move-result-object v1

    invoke-virtual {v0, v1}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v0

    if-eqz v0, :cond_0

    iget-object v0, p0, Lcom/cyjh/elfin/fragment/AbGamesDetailFragment;->gameDownloadView:Lcom/cyjh/elfin/customview/GameDownloadView;

    if-eqz v0, :cond_0

    .line 335
    iget-object v0, p0, Lcom/cyjh/elfin/fragment/AbGamesDetailFragment;->gameDownloadView:Lcom/cyjh/elfin/customview/GameDownloadView;

    const v1, 0x7f0800b1

    invoke-virtual {v0, v1}, Lcom/cyjh/elfin/customview/GameDownloadView;->showUnDownload(I)V

    .line 337
    :cond_0
    return-void
.end method

.method public onMessageMainThread(Lcom/cyjh/elfin/entity/AbNormalGameEvent$RemoveAppSuccessEvent;)V
    .locals 2
    .param p1, "event"    # Lcom/cyjh/elfin/entity/AbNormalGameEvent$RemoveAppSuccessEvent;
    .annotation runtime Lorg/greenrobot/eventbus/Subscribe;
        threadMode = .enum Lorg/greenrobot/eventbus/ThreadMode;->MAIN:Lorg/greenrobot/eventbus/ThreadMode;
    .end annotation

    .prologue
    .line 345
    iget-object v0, p0, Lcom/cyjh/elfin/fragment/AbGamesDetailFragment;->mGameInfo:Lcom/cyjh/elfin/entity/GameInfo;

    if-eqz v0, :cond_0

    new-instance v0, Ljava/lang/StringBuilder;

    invoke-direct {v0}, Ljava/lang/StringBuilder;-><init>()V

    const-string v1, "package:"

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    iget-object v1, p0, Lcom/cyjh/elfin/fragment/AbGamesDetailFragment;->mGameInfo:Lcom/cyjh/elfin/entity/GameInfo;

    iget-object v1, v1, Lcom/cyjh/elfin/entity/GameInfo;->PackageName:Ljava/lang/String;

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-virtual {v0}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v0

    invoke-virtual {p1}, Lcom/cyjh/elfin/entity/AbNormalGameEvent$RemoveAppSuccessEvent;->getPackageName()Ljava/lang/String;

    move-result-object v1

    invoke-virtual {v0, v1}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v0

    if-eqz v0, :cond_0

    iget-object v0, p0, Lcom/cyjh/elfin/fragment/AbGamesDetailFragment;->gameDownloadView:Lcom/cyjh/elfin/customview/GameDownloadView;

    if-eqz v0, :cond_0

    .line 347
    iget-object v0, p0, Lcom/cyjh/elfin/fragment/AbGamesDetailFragment;->gameDownloadView:Lcom/cyjh/elfin/customview/GameDownloadView;

    iget-object v1, p0, Lcom/cyjh/elfin/fragment/AbGamesDetailFragment;->mGameInfo:Lcom/cyjh/elfin/entity/GameInfo;

    iget-object v1, v1, Lcom/cyjh/elfin/entity/GameInfo;->PackageName:Ljava/lang/String;

    invoke-virtual {v0, v1}, Lcom/cyjh/elfin/customview/GameDownloadView;->removeAppUpdateView(Ljava/lang/String;)V

    .line 349
    :cond_0
    return-void
.end method

.method public onPause()V
    .locals 1

    .prologue
    .line 447
    invoke-super {p0}, Lcom/cyjh/elfin/fragment/content/BasicLoadStateHttpFragment;->onPause()V

    .line 448
    const-class v0, Lcom/cyjh/elfin/fragment/AbGamesDetailFragment;

    invoke-virtual {v0}, Ljava/lang/Class;->getCanonicalName()Ljava/lang/String;

    move-result-object v0

    invoke-static {v0}, Lcom/umeng/analytics/MobclickAgent;->onPageEnd(Ljava/lang/String;)V

    .line 449
    return-void
.end method

.method public onResume()V
    .locals 1

    .prologue
    .line 441
    invoke-super {p0}, Lcom/cyjh/elfin/fragment/content/BasicLoadStateHttpFragment;->onResume()V

    .line 442
    const-class v0, Lcom/cyjh/elfin/fragment/AbGamesDetailFragment;

    invoke-virtual {v0}, Ljava/lang/Class;->getCanonicalName()Ljava/lang/String;

    move-result-object v0

    invoke-static {v0}, Lcom/umeng/analytics/MobclickAgent;->onPageStart(Ljava/lang/String;)V

    .line 443
    return-void
.end method

.method public repeatLoadDataError(Lcom/android/volley/VolleyError;)V
    .locals 0
    .param p1, "error"    # Lcom/android/volley/VolleyError;

    .prologue
    .line 238
    invoke-virtual {p0}, Lcom/cyjh/elfin/fragment/AbGamesDetailFragment;->onLoadFailed()V

    .line 239
    return-void
.end method

.method public repeatLoadDataSuccess(Ljava/lang/Object;)V
    .locals 1
    .param p1, "object"    # Ljava/lang/Object;

    .prologue
    .line 227
    move-object v0, p1

    check-cast v0, Lcom/cyjh/elfin/entity/GameDetails;

    .line 228
    .local v0, "gameDetails":Lcom/cyjh/elfin/entity/GameDetails;
    invoke-direct {p0, v0}, Lcom/cyjh/elfin/fragment/AbGamesDetailFragment;->setGameData(Lcom/cyjh/elfin/entity/GameDetails;)V

    .line 229
    return-void
.end method

.method public repeatLoadDataSuccessAndEmpty()V
    .locals 0

    .prologue
    .line 233
    invoke-virtual {p0}, Lcom/cyjh/elfin/fragment/AbGamesDetailFragment;->onLoadEmpty()V

    .line 234
    return-void
.end method

.method public rightBtnOpera(Lcom/cyjh/elfin/entity/ActionBarOperaEnum;Ljava/lang/Object;)V
    .locals 3
    .param p1, "type"    # Lcom/cyjh/elfin/entity/ActionBarOperaEnum;
    .param p2, "param"    # Ljava/lang/Object;

    .prologue
    .line 369
    sget-object v1, Lcom/cyjh/elfin/fragment/AbGamesDetailFragment$8;->$SwitchMap$com$cyjh$elfin$entity$ActionBarOperaEnum:[I

    invoke-virtual {p1}, Lcom/cyjh/elfin/entity/ActionBarOperaEnum;->ordinal()I

    move-result v2

    aget v1, v1, v2

    packed-switch v1, :pswitch_data_0

    .line 377
    :cond_0
    :goto_0
    return-void

    :pswitch_0
    move-object v0, p2

    .line 371
    check-cast v0, Ljava/lang/String;

    .line 372
    .local v0, "url":Ljava/lang/String;
    iget-object v1, p0, Lcom/cyjh/elfin/fragment/AbGamesDetailFragment;->mGameInfo:Lcom/cyjh/elfin/entity/GameInfo;

    iget-object v1, v1, Lcom/cyjh/elfin/entity/GameInfo;->DownLoadUrl:Ljava/lang/String;

    invoke-virtual {v0, v1}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v1

    if-eqz v1, :cond_0

    .line 373
    iget-object v1, p0, Lcom/cyjh/elfin/fragment/AbGamesDetailFragment;->gameDownloadView:Lcom/cyjh/elfin/customview/GameDownloadView;

    invoke-virtual {v1}, Lcom/cyjh/elfin/customview/GameDownloadView;->startDownload()V

    goto :goto_0

    .line 369
    nop

    :pswitch_data_0
    .packed-switch 0x1
        :pswitch_0
    .end packed-switch
.end method

.method public showLoading()V
    .locals 2

    .prologue
    .line 269
    iget-object v0, p0, Lcom/cyjh/elfin/fragment/AbGamesDetailFragment;->mSwipeRefresh:Landroid/support/v4/widget/SwipeRefreshLayout;

    new-instance v1, Lcom/cyjh/elfin/fragment/AbGamesDetailFragment$3;

    invoke-direct {v1, p0}, Lcom/cyjh/elfin/fragment/AbGamesDetailFragment$3;-><init>(Lcom/cyjh/elfin/fragment/AbGamesDetailFragment;)V

    invoke-virtual {v0, v1}, Landroid/support/v4/widget/SwipeRefreshLayout;->post(Ljava/lang/Runnable;)Z

    .line 275
    return-void
.end method
