.class public Lcom/cyjh/elfin/fragment/AdFragment;
.super Lcom/cyjh/elfin/fragment/BaseFragement;
.source "AdFragment.java"

# interfaces
.implements Landroid/view/View$OnClickListener;
.implements Lcom/cyjh/elfin/mvp/views/AdImageView;
.implements Lcom/cyjh/elfin/mvp/views/RecommendGamesView;
.implements Lcom/cyjh/elfin/mvp/views/IFLYAdSwitchViews;


# annotations
.annotation system Ldalvik/annotation/MemberClasses;
    value = {
        Lcom/cyjh/elfin/fragment/AdFragment$CloseAdTimer;,
        Lcom/cyjh/elfin/fragment/AdFragment$SubmitCountTimer;
    }
.end annotation


# static fields
.field private static final TOTAL_TIME:I = 0x5

.field public static final VALUE_SITE:I = 0x1


# instance fields
.field private adImagePresenter:Lcom/cyjh/elfin/mvp/presenters/AdImagePresenter;

.field private adItem:Lcom/iflytek/voiceads/NativeADDataRef;

.field private adPassData:Lcom/cyjh/elfin/entity/AdPassData;

.field private backgroundAdStatistics:Lcom/cyjh/elfin/mvp/managers/BackgroundSettingsAdStatistics;

.field private count:I

.field private countAdTimer:I

.field private flag:Z

.field private gameSwitchBean:Lcom/cyjh/elfin/entity/GameSwitchBean;

.field private isCachePic:Z

.field private isDisplayCunFeiAd:Z

.field private isFirst:Z

.field private isRepeatLoad:Z

.field private lastAdId:Ljava/lang/String;

.field private lastAdTitle:Ljava/lang/String;

.field private lastJumpLinkUrl:Ljava/lang/String;

.field private lastLinkType:Ljava/lang/String;

.field private mAdSwitchPresenter:Lcom/cyjh/elfin/mvp/presenters/IFLYAdSwitchPresenter;

.field private mCloseAdTimer:Lcom/cyjh/elfin/fragment/AdFragment$CloseAdTimer;

.field private mImgAd:Landroid/widget/ImageView;

.field private mNativeListenerTwo:Lcom/iflytek/voiceads/IFLYNativeListener;

.field private mRelativeSplash:Landroid/widget/RelativeLayout;

.field private mTvCountTime:Landroid/widget/TextView;

.field private mTvMarkAd:Landroid/widget/TextView;

.field private nativeAd:Lcom/iflytek/voiceads/IFLYNativeAd;

.field private recommendGamesLink:Ljava/lang/String;

.field private recommendGamesPresenter:Lcom/cyjh/elfin/mvp/presenters/RecommendGamesPresenter;

.field private submitCountTimer:Lcom/cyjh/elfin/fragment/AdFragment$SubmitCountTimer;


# direct methods
.method public constructor <init>()V
    .locals 2

    .prologue
    const/4 v1, 0x0

    .line 57
    invoke-direct {p0}, Lcom/cyjh/elfin/fragment/BaseFragement;-><init>()V

    .line 63
    iput-boolean v1, p0, Lcom/cyjh/elfin/fragment/AdFragment;->flag:Z

    .line 398
    iput v1, p0, Lcom/cyjh/elfin/fragment/AdFragment;->count:I

    .line 402
    iput-boolean v1, p0, Lcom/cyjh/elfin/fragment/AdFragment;->isRepeatLoad:Z

    .line 411
    new-instance v0, Lcom/cyjh/elfin/fragment/AdFragment$3;

    invoke-direct {v0, p0}, Lcom/cyjh/elfin/fragment/AdFragment$3;-><init>(Lcom/cyjh/elfin/fragment/AdFragment;)V

    iput-object v0, p0, Lcom/cyjh/elfin/fragment/AdFragment;->mNativeListenerTwo:Lcom/iflytek/voiceads/IFLYNativeListener;

    .line 453
    iput v1, p0, Lcom/cyjh/elfin/fragment/AdFragment;->countAdTimer:I

    return-void
.end method

.method static synthetic access$000(Lcom/cyjh/elfin/fragment/AdFragment;)Ljava/lang/String;
    .locals 1
    .param p0, "x0"    # Lcom/cyjh/elfin/fragment/AdFragment;

    .prologue
    .line 57
    iget-object v0, p0, Lcom/cyjh/elfin/fragment/AdFragment;->lastAdId:Ljava/lang/String;

    return-object v0
.end method

.method static synthetic access$100(Lcom/cyjh/elfin/fragment/AdFragment;)Lcom/cyjh/elfin/mvp/managers/BackgroundSettingsAdStatistics;
    .locals 1
    .param p0, "x0"    # Lcom/cyjh/elfin/fragment/AdFragment;

    .prologue
    .line 57
    iget-object v0, p0, Lcom/cyjh/elfin/fragment/AdFragment;->backgroundAdStatistics:Lcom/cyjh/elfin/mvp/managers/BackgroundSettingsAdStatistics;

    return-object v0
.end method

.method static synthetic access$1000(Lcom/cyjh/elfin/fragment/AdFragment;)Lcom/iflytek/voiceads/IFLYNativeAd;
    .locals 1
    .param p0, "x0"    # Lcom/cyjh/elfin/fragment/AdFragment;

    .prologue
    .line 57
    iget-object v0, p0, Lcom/cyjh/elfin/fragment/AdFragment;->nativeAd:Lcom/iflytek/voiceads/IFLYNativeAd;

    return-object v0
.end method

.method static synthetic access$1100(Lcom/cyjh/elfin/fragment/AdFragment;)Landroid/widget/TextView;
    .locals 1
    .param p0, "x0"    # Lcom/cyjh/elfin/fragment/AdFragment;

    .prologue
    .line 57
    iget-object v0, p0, Lcom/cyjh/elfin/fragment/AdFragment;->mTvMarkAd:Landroid/widget/TextView;

    return-object v0
.end method

.method static synthetic access$1200(Lcom/cyjh/elfin/fragment/AdFragment;)V
    .locals 0
    .param p0, "x0"    # Lcom/cyjh/elfin/fragment/AdFragment;

    .prologue
    .line 57
    invoke-direct {p0}, Lcom/cyjh/elfin/fragment/AdFragment;->displayBackGroundAd()V

    return-void
.end method

.method static synthetic access$1300(Lcom/cyjh/elfin/fragment/AdFragment;)I
    .locals 1
    .param p0, "x0"    # Lcom/cyjh/elfin/fragment/AdFragment;

    .prologue
    .line 57
    iget v0, p0, Lcom/cyjh/elfin/fragment/AdFragment;->countAdTimer:I

    return v0
.end method

.method static synthetic access$1308(Lcom/cyjh/elfin/fragment/AdFragment;)I
    .locals 2
    .param p0, "x0"    # Lcom/cyjh/elfin/fragment/AdFragment;

    .prologue
    .line 57
    iget v0, p0, Lcom/cyjh/elfin/fragment/AdFragment;->countAdTimer:I

    add-int/lit8 v1, v0, 0x1

    iput v1, p0, Lcom/cyjh/elfin/fragment/AdFragment;->countAdTimer:I

    return v0
.end method

.method static synthetic access$1400(Lcom/cyjh/elfin/fragment/AdFragment;)V
    .locals 0
    .param p0, "x0"    # Lcom/cyjh/elfin/fragment/AdFragment;

    .prologue
    .line 57
    invoke-direct {p0}, Lcom/cyjh/elfin/fragment/AdFragment;->loadXunFei()V

    return-void
.end method

.method static synthetic access$200(Lcom/cyjh/elfin/fragment/AdFragment;)Landroid/widget/TextView;
    .locals 1
    .param p0, "x0"    # Lcom/cyjh/elfin/fragment/AdFragment;

    .prologue
    .line 57
    iget-object v0, p0, Lcom/cyjh/elfin/fragment/AdFragment;->mTvCountTime:Landroid/widget/TextView;

    return-object v0
.end method

.method static synthetic access$300(Lcom/cyjh/elfin/fragment/AdFragment;)Lcom/cyjh/elfin/fragment/AdFragment$SubmitCountTimer;
    .locals 1
    .param p0, "x0"    # Lcom/cyjh/elfin/fragment/AdFragment;

    .prologue
    .line 57
    iget-object v0, p0, Lcom/cyjh/elfin/fragment/AdFragment;->submitCountTimer:Lcom/cyjh/elfin/fragment/AdFragment$SubmitCountTimer;

    return-object v0
.end method

.method static synthetic access$400(Lcom/cyjh/elfin/fragment/AdFragment;)V
    .locals 0
    .param p0, "x0"    # Lcom/cyjh/elfin/fragment/AdFragment;

    .prologue
    .line 57
    invoke-direct {p0}, Lcom/cyjh/elfin/fragment/AdFragment;->toCallGamesOrFreeActivity()V

    return-void
.end method

.method static synthetic access$500(Lcom/cyjh/elfin/fragment/AdFragment;)I
    .locals 1
    .param p0, "x0"    # Lcom/cyjh/elfin/fragment/AdFragment;

    .prologue
    .line 57
    iget v0, p0, Lcom/cyjh/elfin/fragment/AdFragment;->count:I

    return v0
.end method

.method static synthetic access$508(Lcom/cyjh/elfin/fragment/AdFragment;)I
    .locals 2
    .param p0, "x0"    # Lcom/cyjh/elfin/fragment/AdFragment;

    .prologue
    .line 57
    iget v0, p0, Lcom/cyjh/elfin/fragment/AdFragment;->count:I

    add-int/lit8 v1, v0, 0x1

    iput v1, p0, Lcom/cyjh/elfin/fragment/AdFragment;->count:I

    return v0
.end method

.method static synthetic access$600(Lcom/cyjh/elfin/fragment/AdFragment;)Lcom/iflytek/voiceads/NativeADDataRef;
    .locals 1
    .param p0, "x0"    # Lcom/cyjh/elfin/fragment/AdFragment;

    .prologue
    .line 57
    iget-object v0, p0, Lcom/cyjh/elfin/fragment/AdFragment;->adItem:Lcom/iflytek/voiceads/NativeADDataRef;

    return-object v0
.end method

.method static synthetic access$602(Lcom/cyjh/elfin/fragment/AdFragment;Lcom/iflytek/voiceads/NativeADDataRef;)Lcom/iflytek/voiceads/NativeADDataRef;
    .locals 0
    .param p0, "x0"    # Lcom/cyjh/elfin/fragment/AdFragment;
    .param p1, "x1"    # Lcom/iflytek/voiceads/NativeADDataRef;

    .prologue
    .line 57
    iput-object p1, p0, Lcom/cyjh/elfin/fragment/AdFragment;->adItem:Lcom/iflytek/voiceads/NativeADDataRef;

    return-object p1
.end method

.method static synthetic access$700(Lcom/cyjh/elfin/fragment/AdFragment;)Landroid/widget/ImageView;
    .locals 1
    .param p0, "x0"    # Lcom/cyjh/elfin/fragment/AdFragment;

    .prologue
    .line 57
    iget-object v0, p0, Lcom/cyjh/elfin/fragment/AdFragment;->mImgAd:Landroid/widget/ImageView;

    return-object v0
.end method

.method static synthetic access$800(Lcom/cyjh/elfin/fragment/AdFragment;)Lcom/cyjh/elfin/fragment/AdFragment$CloseAdTimer;
    .locals 1
    .param p0, "x0"    # Lcom/cyjh/elfin/fragment/AdFragment;

    .prologue
    .line 57
    iget-object v0, p0, Lcom/cyjh/elfin/fragment/AdFragment;->mCloseAdTimer:Lcom/cyjh/elfin/fragment/AdFragment$CloseAdTimer;

    return-object v0
.end method

.method static synthetic access$802(Lcom/cyjh/elfin/fragment/AdFragment;Lcom/cyjh/elfin/fragment/AdFragment$CloseAdTimer;)Lcom/cyjh/elfin/fragment/AdFragment$CloseAdTimer;
    .locals 0
    .param p0, "x0"    # Lcom/cyjh/elfin/fragment/AdFragment;
    .param p1, "x1"    # Lcom/cyjh/elfin/fragment/AdFragment$CloseAdTimer;

    .prologue
    .line 57
    iput-object p1, p0, Lcom/cyjh/elfin/fragment/AdFragment;->mCloseAdTimer:Lcom/cyjh/elfin/fragment/AdFragment$CloseAdTimer;

    return-object p1
.end method

.method static synthetic access$902(Lcom/cyjh/elfin/fragment/AdFragment;Z)Z
    .locals 0
    .param p0, "x0"    # Lcom/cyjh/elfin/fragment/AdFragment;
    .param p1, "x1"    # Z

    .prologue
    .line 57
    iput-boolean p1, p0, Lcom/cyjh/elfin/fragment/AdFragment;->isDisplayCunFeiAd:Z

    return p1
.end method

.method private displayBackGroundAd()V
    .locals 3

    .prologue
    .line 178
    const-string v0, "zzz"

    const-string v1, "displayBackGroundAd()---1"

    invoke-static {v0, v1}, Landroid/util/Log;->e(Ljava/lang/String;Ljava/lang/String;)I

    .line 179
    iget-object v0, p0, Lcom/cyjh/elfin/fragment/AdFragment;->mCloseAdTimer:Lcom/cyjh/elfin/fragment/AdFragment$CloseAdTimer;

    if-eqz v0, :cond_0

    .line 180
    iget-object v0, p0, Lcom/cyjh/elfin/fragment/AdFragment;->mCloseAdTimer:Lcom/cyjh/elfin/fragment/AdFragment$CloseAdTimer;

    invoke-virtual {v0}, Lcom/cyjh/elfin/fragment/AdFragment$CloseAdTimer;->cancel()V

    .line 181
    const/4 v0, 0x0

    iput-object v0, p0, Lcom/cyjh/elfin/fragment/AdFragment;->mCloseAdTimer:Lcom/cyjh/elfin/fragment/AdFragment$CloseAdTimer;

    .line 183
    :cond_0
    iget-object v0, p0, Lcom/cyjh/elfin/fragment/AdFragment;->adPassData:Lcom/cyjh/elfin/entity/AdPassData;

    if-eqz v0, :cond_1

    .line 184
    invoke-virtual {p0}, Lcom/cyjh/elfin/fragment/AdFragment;->getActivity()Landroid/support/v4/app/FragmentActivity;

    move-result-object v0

    invoke-static {v0}, Lcom/squareup/picasso/Picasso;->with(Landroid/content/Context;)Lcom/squareup/picasso/Picasso;

    move-result-object v0

    iget-object v1, p0, Lcom/cyjh/elfin/fragment/AdFragment;->adPassData:Lcom/cyjh/elfin/entity/AdPassData;

    iget-object v1, v1, Lcom/cyjh/elfin/entity/AdPassData;->adImgUrl:Ljava/lang/String;

    invoke-virtual {v0, v1}, Lcom/squareup/picasso/Picasso;->load(Ljava/lang/String;)Lcom/squareup/picasso/RequestCreator;

    move-result-object v0

    iget-object v1, p0, Lcom/cyjh/elfin/fragment/AdFragment;->mImgAd:Landroid/widget/ImageView;

    new-instance v2, Lcom/cyjh/elfin/fragment/AdFragment$1;

    invoke-direct {v2, p0}, Lcom/cyjh/elfin/fragment/AdFragment$1;-><init>(Lcom/cyjh/elfin/fragment/AdFragment;)V

    invoke-virtual {v0, v1, v2}, Lcom/squareup/picasso/RequestCreator;->into(Landroid/widget/ImageView;Lcom/squareup/picasso/Callback;)V

    .line 219
    :goto_0
    return-void

    .line 199
    :cond_1
    const-string v0, "zzz"

    const-string v1, "displayBackGroundAd()---4"

    invoke-static {v0, v1}, Landroid/util/Log;->e(Ljava/lang/String;Ljava/lang/String;)I

    .line 200
    invoke-direct {p0}, Lcom/cyjh/elfin/fragment/AdFragment;->toCallGamesOrFreeActivity()V

    goto :goto_0
.end method

.method private initView(Landroid/view/View;)V
    .locals 2
    .param p1, "view"    # Landroid/view/View;

    .prologue
    .line 228
    const v0, 0x7f0f00fa

    invoke-virtual {p1, v0}, Landroid/view/View;->findViewById(I)Landroid/view/View;

    move-result-object v0

    check-cast v0, Landroid/widget/TextView;

    iput-object v0, p0, Lcom/cyjh/elfin/fragment/AdFragment;->mTvCountTime:Landroid/widget/TextView;

    .line 229
    const v0, 0x7f0f00f8

    invoke-virtual {p1, v0}, Landroid/view/View;->findViewById(I)Landroid/view/View;

    move-result-object v0

    check-cast v0, Landroid/widget/ImageView;

    iput-object v0, p0, Lcom/cyjh/elfin/fragment/AdFragment;->mImgAd:Landroid/widget/ImageView;

    .line 230
    const v0, 0x7f0f00f7

    invoke-virtual {p1, v0}, Landroid/view/View;->findViewById(I)Landroid/view/View;

    move-result-object v0

    check-cast v0, Landroid/widget/RelativeLayout;

    iput-object v0, p0, Lcom/cyjh/elfin/fragment/AdFragment;->mRelativeSplash:Landroid/widget/RelativeLayout;

    .line 231
    iget-object v0, p0, Lcom/cyjh/elfin/fragment/AdFragment;->mTvCountTime:Landroid/widget/TextView;

    invoke-virtual {v0, p0}, Landroid/widget/TextView;->setOnClickListener(Landroid/view/View$OnClickListener;)V

    .line 232
    iget-object v0, p0, Lcom/cyjh/elfin/fragment/AdFragment;->mImgAd:Landroid/widget/ImageView;

    invoke-virtual {v0, p0}, Landroid/widget/ImageView;->setOnClickListener(Landroid/view/View$OnClickListener;)V

    .line 233
    new-instance v0, Lcom/cyjh/elfin/fragment/AdFragment$SubmitCountTimer;

    const/4 v1, 0x5

    invoke-direct {v0, p0, v1}, Lcom/cyjh/elfin/fragment/AdFragment$SubmitCountTimer;-><init>(Lcom/cyjh/elfin/fragment/AdFragment;I)V

    iput-object v0, p0, Lcom/cyjh/elfin/fragment/AdFragment;->submitCountTimer:Lcom/cyjh/elfin/fragment/AdFragment$SubmitCountTimer;

    .line 236
    const v0, 0x7f0f00f9

    invoke-virtual {p1, v0}, Landroid/view/View;->findViewById(I)Landroid/view/View;

    move-result-object v0

    check-cast v0, Landroid/widget/TextView;

    iput-object v0, p0, Lcom/cyjh/elfin/fragment/AdFragment;->mTvMarkAd:Landroid/widget/TextView;

    .line 237
    return-void
.end method

.method private loadXunFei()V
    .locals 5

    .prologue
    const/4 v4, 0x1

    .line 404
    iget-boolean v0, p0, Lcom/cyjh/elfin/fragment/AdFragment;->isRepeatLoad:Z

    if-eqz v0, :cond_0

    .line 410
    :goto_0
    return-void

    .line 407
    :cond_0
    iput-boolean v4, p0, Lcom/cyjh/elfin/fragment/AdFragment;->isRepeatLoad:Z

    .line 408
    new-instance v0, Lcom/iflytek/voiceads/IFLYNativeAd;

    invoke-virtual {p0}, Lcom/cyjh/elfin/fragment/AdFragment;->getActivity()Landroid/support/v4/app/FragmentActivity;

    move-result-object v1

    const-string v2, "761D5F3C12409F07DCE571A8AA3C0480"

    iget-object v3, p0, Lcom/cyjh/elfin/fragment/AdFragment;->mNativeListenerTwo:Lcom/iflytek/voiceads/IFLYNativeListener;

    invoke-direct {v0, v1, v2, v3}, Lcom/iflytek/voiceads/IFLYNativeAd;-><init>(Landroid/content/Context;Ljava/lang/String;Lcom/iflytek/voiceads/IFLYNativeListener;)V

    iput-object v0, p0, Lcom/cyjh/elfin/fragment/AdFragment;->nativeAd:Lcom/iflytek/voiceads/IFLYNativeAd;

    .line 409
    iget-object v0, p0, Lcom/cyjh/elfin/fragment/AdFragment;->nativeAd:Lcom/iflytek/voiceads/IFLYNativeAd;

    invoke-virtual {v0, v4}, Lcom/iflytek/voiceads/IFLYNativeAd;->loadAd(I)V

    goto :goto_0
.end method

.method public static newInstance(Lcom/cyjh/elfin/entity/AdPassData;)Lcom/cyjh/elfin/fragment/AdFragment;
    .locals 3
    .param p0, "adPassData"    # Lcom/cyjh/elfin/entity/AdPassData;

    .prologue
    .line 89
    new-instance v1, Lcom/cyjh/elfin/fragment/AdFragment;

    invoke-direct {v1}, Lcom/cyjh/elfin/fragment/AdFragment;-><init>()V

    .line 90
    .local v1, "splashFragment":Lcom/cyjh/elfin/fragment/AdFragment;
    new-instance v0, Landroid/os/Bundle;

    invoke-direct {v0}, Landroid/os/Bundle;-><init>()V

    .line 91
    .local v0, "bundle":Landroid/os/Bundle;
    const-class v2, Lcom/cyjh/elfin/fragment/AdFragment;

    invoke-virtual {v2}, Ljava/lang/Class;->getCanonicalName()Ljava/lang/String;

    move-result-object v2

    invoke-virtual {v0, v2, p0}, Landroid/os/Bundle;->putParcelable(Ljava/lang/String;Landroid/os/Parcelable;)V

    .line 92
    invoke-virtual {v1, v0}, Lcom/cyjh/elfin/fragment/AdFragment;->setArguments(Landroid/os/Bundle;)V

    .line 93
    return-object v1
.end method

.method private onClickImageXunFeiAd()V
    .locals 4

    .prologue
    .line 339
    iget-object v0, p0, Lcom/cyjh/elfin/fragment/AdFragment;->adItem:Lcom/iflytek/voiceads/NativeADDataRef;

    iget-object v1, p0, Lcom/cyjh/elfin/fragment/AdFragment;->mImgAd:Landroid/widget/ImageView;

    invoke-virtual {v0, v1}, Lcom/iflytek/voiceads/NativeADDataRef;->onClicked(Landroid/view/View;)Z

    .line 340
    const/4 v0, 0x1

    iput-boolean v0, p0, Lcom/cyjh/elfin/fragment/AdFragment;->flag:Z

    .line 342
    const-string v0, "redirect"

    iget-object v1, p0, Lcom/cyjh/elfin/fragment/AdFragment;->adItem:Lcom/iflytek/voiceads/NativeADDataRef;

    invoke-virtual {v1}, Lcom/iflytek/voiceads/NativeADDataRef;->getAdtype()Ljava/lang/String;

    move-result-object v1

    invoke-virtual {v0, v1}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v0

    if-nez v0, :cond_0

    .line 343
    new-instance v0, Landroid/os/Handler;

    invoke-direct {v0}, Landroid/os/Handler;-><init>()V

    new-instance v1, Lcom/cyjh/elfin/fragment/AdFragment$2;

    invoke-direct {v1, p0}, Lcom/cyjh/elfin/fragment/AdFragment$2;-><init>(Lcom/cyjh/elfin/fragment/AdFragment;)V

    const-wide/16 v2, 0x3e8

    invoke-virtual {v0, v1, v2, v3}, Landroid/os/Handler;->postDelayed(Ljava/lang/Runnable;J)Z

    .line 350
    :cond_0
    return-void
.end method

.method private toCallGamesOrFreeActivity()V
    .locals 3

    .prologue
    const/4 v2, 0x0

    .line 250
    iget-object v0, p0, Lcom/cyjh/elfin/fragment/AdFragment;->gameSwitchBean:Lcom/cyjh/elfin/entity/GameSwitchBean;

    if-eqz v0, :cond_1

    iget-object v0, p0, Lcom/cyjh/elfin/fragment/AdFragment;->gameSwitchBean:Lcom/cyjh/elfin/entity/GameSwitchBean;

    iget-object v0, v0, Lcom/cyjh/elfin/entity/GameSwitchBean;->Data:Lcom/cyjh/elfin/entity/GameSwitchInfo;

    if-eqz v0, :cond_1

    .line 251
    iget-object v0, p0, Lcom/cyjh/elfin/fragment/AdFragment;->gameSwitchBean:Lcom/cyjh/elfin/entity/GameSwitchBean;

    iget-object v0, v0, Lcom/cyjh/elfin/entity/GameSwitchBean;->Data:Lcom/cyjh/elfin/entity/GameSwitchInfo;

    iget-object v0, v0, Lcom/cyjh/elfin/entity/GameSwitchInfo;->Path:Ljava/lang/String;

    iget-object v1, p0, Lcom/cyjh/elfin/fragment/AdFragment;->recommendGamesLink:Ljava/lang/String;

    invoke-virtual {v0, v1}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v0

    if-nez v0, :cond_0

    const-string v0, "2"

    iget-object v1, p0, Lcom/cyjh/elfin/fragment/AdFragment;->gameSwitchBean:Lcom/cyjh/elfin/entity/GameSwitchBean;

    iget-object v1, v1, Lcom/cyjh/elfin/entity/GameSwitchBean;->Data:Lcom/cyjh/elfin/entity/GameSwitchInfo;

    iget-object v1, v1, Lcom/cyjh/elfin/entity/GameSwitchInfo;->Type:Ljava/lang/String;

    invoke-virtual {v0, v1}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v0

    if-eqz v0, :cond_0

    .line 252
    invoke-virtual {p0}, Lcom/cyjh/elfin/fragment/AdFragment;->getActivity()Landroid/support/v4/app/FragmentActivity;

    move-result-object v0

    iget-object v1, p0, Lcom/cyjh/elfin/fragment/AdFragment;->gameSwitchBean:Lcom/cyjh/elfin/entity/GameSwitchBean;

    iget-object v1, v1, Lcom/cyjh/elfin/entity/GameSwitchBean;->Data:Lcom/cyjh/elfin/entity/GameSwitchInfo;

    iget-object v1, v1, Lcom/cyjh/elfin/entity/GameSwitchInfo;->Name:Ljava/lang/String;

    iget-object v2, p0, Lcom/cyjh/elfin/fragment/AdFragment;->gameSwitchBean:Lcom/cyjh/elfin/entity/GameSwitchBean;

    iget-object v2, v2, Lcom/cyjh/elfin/entity/GameSwitchBean;->Data:Lcom/cyjh/elfin/entity/GameSwitchInfo;

    iget-object v2, v2, Lcom/cyjh/elfin/entity/GameSwitchInfo;->Path:Ljava/lang/String;

    invoke-static {v0, v1, v2}, Lcom/cyjh/elfin/util/IntentUtils;->toCallWebGamesActivity(Landroid/content/Context;Ljava/lang/String;Ljava/lang/String;)V

    .line 253
    iget-object v0, p0, Lcom/cyjh/elfin/fragment/AdFragment;->appContext:Lcom/cyjh/elfin/AppContext;

    iget-object v0, v0, Lcom/cyjh/elfin/AppContext;->mSharePre:Landroid/content/SharedPreferences;

    invoke-interface {v0}, Landroid/content/SharedPreferences;->edit()Landroid/content/SharedPreferences$Editor;

    move-result-object v0

    const-string v1, "default_entry_games"

    const/4 v2, 0x1

    invoke-interface {v0, v1, v2}, Landroid/content/SharedPreferences$Editor;->putBoolean(Ljava/lang/String;Z)Landroid/content/SharedPreferences$Editor;

    move-result-object v0

    invoke-interface {v0}, Landroid/content/SharedPreferences$Editor;->apply()V

    .line 262
    :goto_0
    invoke-virtual {p0}, Lcom/cyjh/elfin/fragment/AdFragment;->getActivity()Landroid/support/v4/app/FragmentActivity;

    move-result-object v0

    invoke-virtual {v0}, Landroid/support/v4/app/FragmentActivity;->finish()V

    .line 263
    return-void

    .line 255
    :cond_0
    const-string v0, "\u5e7f\u544a\u56fe\u7247\uff1arecommendGamesLink\u76f8\u540c"

    new-array v1, v2, [Ljava/lang/Object;

    invoke-static {v0, v1}, Lcom/orhanobut/logger/Logger;->e(Ljava/lang/String;[Ljava/lang/Object;)V

    .line 256
    invoke-static {}, Lcom/cyjh/elfin/AppContext;->getInstance()Lcom/cyjh/elfin/AppContext;

    move-result-object v0

    invoke-static {v0}, Lcom/cyjh/elfin/activity/ElfinFreeActivity;->toCallActivity(Landroid/content/Context;)V

    goto :goto_0

    .line 259
    :cond_1
    const-string v0, "\u5e7f\u544a\u56fe\u7247\uff1arecommendGames == null"

    new-array v1, v2, [Ljava/lang/Object;

    invoke-static {v0, v1}, Lcom/orhanobut/logger/Logger;->e(Ljava/lang/String;[Ljava/lang/Object;)V

    .line 260
    invoke-static {}, Lcom/cyjh/elfin/AppContext;->getInstance()Lcom/cyjh/elfin/AppContext;

    move-result-object v0

    invoke-static {v0}, Lcom/cyjh/elfin/activity/ElfinFreeActivity;->toCallActivity(Landroid/content/Context;)V

    goto :goto_0
.end method


# virtual methods
.method public gamesSwitch(Lcom/cyjh/elfin/entity/GameSwitchBean;)V
    .locals 0
    .param p1, "gameSwitchBean"    # Lcom/cyjh/elfin/entity/GameSwitchBean;

    .prologue
    .line 363
    if-eqz p1, :cond_0

    .line 364
    iput-object p1, p0, Lcom/cyjh/elfin/fragment/AdFragment;->gameSwitchBean:Lcom/cyjh/elfin/entity/GameSwitchBean;

    .line 366
    :cond_0
    return-void
.end method

.method public getFragmentLayoutId()I
    .locals 1

    .prologue
    .line 85
    const v0, 0x7f040047

    return v0
.end method

.method public imgAdResult(Lcom/cyjh/elfin/entity/Ad;)V
    .locals 0
    .param p1, "ad"    # Lcom/cyjh/elfin/entity/Ad;

    .prologue
    .line 359
    return-void
.end method

.method public onActivityCreated(Landroid/os/Bundle;)V
    .locals 7
    .param p1, "savedInstanceState"    # Landroid/os/Bundle;

    .prologue
    const/4 v6, 0x1

    const/4 v5, 0x0

    .line 109
    invoke-super {p0, p1}, Lcom/cyjh/elfin/fragment/BaseFragement;->onActivityCreated(Landroid/os/Bundle;)V

    .line 110
    new-instance v2, Lcom/cyjh/elfin/mvp/managers/BackgroundSettingsAdStatistics;

    invoke-direct {v2}, Lcom/cyjh/elfin/mvp/managers/BackgroundSettingsAdStatistics;-><init>()V

    iput-object v2, p0, Lcom/cyjh/elfin/fragment/AdFragment;->backgroundAdStatistics:Lcom/cyjh/elfin/mvp/managers/BackgroundSettingsAdStatistics;

    .line 111
    new-instance v2, Lcom/cyjh/elfin/mvp/presenters/RecommendGamesPresenter;

    invoke-direct {v2, p0}, Lcom/cyjh/elfin/mvp/presenters/RecommendGamesPresenter;-><init>(Lcom/cyjh/elfin/mvp/views/RecommendGamesView;)V

    iput-object v2, p0, Lcom/cyjh/elfin/fragment/AdFragment;->recommendGamesPresenter:Lcom/cyjh/elfin/mvp/presenters/RecommendGamesPresenter;

    .line 112
    iget-object v2, p0, Lcom/cyjh/elfin/fragment/AdFragment;->recommendGamesPresenter:Lcom/cyjh/elfin/mvp/presenters/RecommendGamesPresenter;

    invoke-virtual {p0}, Lcom/cyjh/elfin/fragment/AdFragment;->getActivity()Landroid/support/v4/app/FragmentActivity;

    move-result-object v3

    invoke-virtual {v2, v3}, Lcom/cyjh/elfin/mvp/presenters/RecommendGamesPresenter;->gameJumpSwitch(Landroid/content/Context;)V

    .line 113
    new-instance v2, Lcom/cyjh/elfin/mvp/presenters/AdImagePresenter;

    invoke-direct {v2, p0}, Lcom/cyjh/elfin/mvp/presenters/AdImagePresenter;-><init>(Lcom/cyjh/elfin/mvp/views/AdImageView;)V

    iput-object v2, p0, Lcom/cyjh/elfin/fragment/AdFragment;->adImagePresenter:Lcom/cyjh/elfin/mvp/presenters/AdImagePresenter;

    .line 114
    invoke-virtual {p0}, Lcom/cyjh/elfin/fragment/AdFragment;->getArguments()Landroid/os/Bundle;

    move-result-object v2

    const-class v3, Lcom/cyjh/elfin/fragment/AdFragment;

    invoke-virtual {v3}, Ljava/lang/Class;->getCanonicalName()Ljava/lang/String;

    move-result-object v3

    invoke-virtual {v2, v3}, Landroid/os/Bundle;->getParcelable(Ljava/lang/String;)Landroid/os/Parcelable;

    move-result-object v2

    check-cast v2, Lcom/cyjh/elfin/entity/AdPassData;

    iput-object v2, p0, Lcom/cyjh/elfin/fragment/AdFragment;->adPassData:Lcom/cyjh/elfin/entity/AdPassData;

    .line 115
    iget-object v2, p0, Lcom/cyjh/elfin/fragment/AdFragment;->mRelativeSplash:Landroid/widget/RelativeLayout;

    invoke-virtual {v2, v5}, Landroid/widget/RelativeLayout;->setVisibility(I)V

    .line 123
    new-instance v2, Lcom/cyjh/elfin/mvp/presenters/IFLYAdSwitchPresenter;

    invoke-virtual {p0}, Lcom/cyjh/elfin/fragment/AdFragment;->getActivity()Landroid/support/v4/app/FragmentActivity;

    move-result-object v3

    invoke-direct {v2, v3, p0}, Lcom/cyjh/elfin/mvp/presenters/IFLYAdSwitchPresenter;-><init>(Landroid/content/Context;Lcom/cyjh/elfin/mvp/views/IFLYAdSwitchViews;)V

    iput-object v2, p0, Lcom/cyjh/elfin/fragment/AdFragment;->mAdSwitchPresenter:Lcom/cyjh/elfin/mvp/presenters/IFLYAdSwitchPresenter;

    .line 124
    iget-object v2, p0, Lcom/cyjh/elfin/fragment/AdFragment;->mAdSwitchPresenter:Lcom/cyjh/elfin/mvp/presenters/IFLYAdSwitchPresenter;

    const/4 v3, 0x3

    invoke-virtual {v2, v3}, Lcom/cyjh/elfin/mvp/presenters/IFLYAdSwitchPresenter;->load(I)V

    .line 125
    iget-object v2, p0, Lcom/cyjh/elfin/fragment/AdFragment;->appContext:Lcom/cyjh/elfin/AppContext;

    iget-object v2, v2, Lcom/cyjh/elfin/AppContext;->mSharePre:Landroid/content/SharedPreferences;

    const-string v3, "ad_is_first"

    invoke-interface {v2, v3, v6}, Landroid/content/SharedPreferences;->getBoolean(Ljava/lang/String;Z)Z

    move-result v2

    iput-boolean v2, p0, Lcom/cyjh/elfin/fragment/AdFragment;->isFirst:Z

    .line 127
    iget-object v2, p0, Lcom/cyjh/elfin/fragment/AdFragment;->appContext:Lcom/cyjh/elfin/AppContext;

    iget-object v2, v2, Lcom/cyjh/elfin/AppContext;->mSharePre:Landroid/content/SharedPreferences;

    const-string v3, "last_ad_link_url"

    const-string v4, ""

    invoke-interface {v2, v3, v4}, Landroid/content/SharedPreferences;->getString(Ljava/lang/String;Ljava/lang/String;)Ljava/lang/String;

    move-result-object v1

    .line 128
    .local v1, "lastImgUrl":Ljava/lang/String;
    iget-object v2, p0, Lcom/cyjh/elfin/fragment/AdFragment;->appContext:Lcom/cyjh/elfin/AppContext;

    iget-object v2, v2, Lcom/cyjh/elfin/AppContext;->mSharePre:Landroid/content/SharedPreferences;

    const-string v3, "last_ad_link_type"

    const-string v4, ""

    invoke-interface {v2, v3, v4}, Landroid/content/SharedPreferences;->getString(Ljava/lang/String;Ljava/lang/String;)Ljava/lang/String;

    move-result-object v2

    iput-object v2, p0, Lcom/cyjh/elfin/fragment/AdFragment;->lastLinkType:Ljava/lang/String;

    .line 129
    iget-object v2, p0, Lcom/cyjh/elfin/fragment/AdFragment;->appContext:Lcom/cyjh/elfin/AppContext;

    iget-object v2, v2, Lcom/cyjh/elfin/AppContext;->mSharePre:Landroid/content/SharedPreferences;

    const-string v3, "last_ad_jump_linkurl"

    const-string v4, ""

    invoke-interface {v2, v3, v4}, Landroid/content/SharedPreferences;->getString(Ljava/lang/String;Ljava/lang/String;)Ljava/lang/String;

    move-result-object v2

    iput-object v2, p0, Lcom/cyjh/elfin/fragment/AdFragment;->lastJumpLinkUrl:Ljava/lang/String;

    .line 130
    iget-object v2, p0, Lcom/cyjh/elfin/fragment/AdFragment;->appContext:Lcom/cyjh/elfin/AppContext;

    iget-object v2, v2, Lcom/cyjh/elfin/AppContext;->mSharePre:Landroid/content/SharedPreferences;

    const-string v3, "last_ad_title"

    const-string v4, ""

    invoke-interface {v2, v3, v4}, Landroid/content/SharedPreferences;->getString(Ljava/lang/String;Ljava/lang/String;)Ljava/lang/String;

    move-result-object v2

    iput-object v2, p0, Lcom/cyjh/elfin/fragment/AdFragment;->lastAdTitle:Ljava/lang/String;

    .line 131
    iget-object v2, p0, Lcom/cyjh/elfin/fragment/AdFragment;->appContext:Lcom/cyjh/elfin/AppContext;

    iget-object v2, v2, Lcom/cyjh/elfin/AppContext;->mSharePre:Landroid/content/SharedPreferences;

    const-string v3, "last_ad_id"

    const-string v4, ""

    invoke-interface {v2, v3, v4}, Landroid/content/SharedPreferences;->getString(Ljava/lang/String;Ljava/lang/String;)Ljava/lang/String;

    move-result-object v2

    iput-object v2, p0, Lcom/cyjh/elfin/fragment/AdFragment;->lastAdId:Ljava/lang/String;

    .line 132
    new-instance v2, Ljava/lang/StringBuilder;

    invoke-direct {v2}, Ljava/lang/StringBuilder;-><init>()V

    const-string v3, "lastImgUrl=="

    invoke-virtual {v2, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    invoke-virtual {v2, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    const-string v3, ",lastLinkType=="

    invoke-virtual {v2, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    iget-object v3, p0, Lcom/cyjh/elfin/fragment/AdFragment;->lastLinkType:Ljava/lang/String;

    invoke-virtual {v2, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    invoke-virtual {v2}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v2

    new-array v3, v5, [Ljava/lang/Object;

    invoke-static {v2, v3}, Lcom/orhanobut/logger/Logger;->e(Ljava/lang/String;[Ljava/lang/Object;)V

    .line 133
    new-instance v2, Ljava/lang/StringBuilder;

    invoke-direct {v2}, Ljava/lang/StringBuilder;-><init>()V

    const-string v3, "lastJumpLinkUrl=="

    invoke-virtual {v2, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    iget-object v3, p0, Lcom/cyjh/elfin/fragment/AdFragment;->lastJumpLinkUrl:Ljava/lang/String;

    invoke-virtual {v2, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    const-string v3, ",lastAdTitle=="

    invoke-virtual {v2, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    iget-object v3, p0, Lcom/cyjh/elfin/fragment/AdFragment;->lastAdTitle:Ljava/lang/String;

    invoke-virtual {v2, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    invoke-virtual {v2}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v2

    new-array v3, v5, [Ljava/lang/Object;

    invoke-static {v2, v3}, Lcom/orhanobut/logger/Logger;->e(Ljava/lang/String;[Ljava/lang/Object;)V

    .line 134
    new-instance v2, Ljava/lang/StringBuilder;

    invoke-direct {v2}, Ljava/lang/StringBuilder;-><init>()V

    const-string v3, "lastAdId=="

    invoke-virtual {v2, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    iget-object v3, p0, Lcom/cyjh/elfin/fragment/AdFragment;->lastAdId:Ljava/lang/String;

    invoke-virtual {v2, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    invoke-virtual {v2}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v2

    new-array v3, v5, [Ljava/lang/Object;

    invoke-static {v2, v3}, Lcom/orhanobut/logger/Logger;->e(Ljava/lang/String;[Ljava/lang/Object;)V

    .line 135
    const-string v2, "zzz"

    new-instance v3, Ljava/lang/StringBuilder;

    invoke-direct {v3}, Ljava/lang/StringBuilder;-><init>()V

    const-string v4, "onActivityCreated--adPassData--"

    invoke-virtual {v3, v4}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v3

    iget-object v4, p0, Lcom/cyjh/elfin/fragment/AdFragment;->adPassData:Lcom/cyjh/elfin/entity/AdPassData;

    invoke-virtual {v3, v4}, Ljava/lang/StringBuilder;->append(Ljava/lang/Object;)Ljava/lang/StringBuilder;

    move-result-object v3

    invoke-virtual {v3}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v3

    invoke-static {v2, v3}, Landroid/util/Log;->e(Ljava/lang/String;Ljava/lang/String;)I

    .line 136
    const-string v2, "zzz"

    new-instance v3, Ljava/lang/StringBuilder;

    invoke-direct {v3}, Ljava/lang/StringBuilder;-><init>()V

    const-string v4, "onActivityCreated--lastImgUrl--"

    invoke-virtual {v3, v4}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v3

    invoke-virtual {v3, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v3

    invoke-virtual {v3}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v3

    invoke-static {v2, v3}, Landroid/util/Log;->e(Ljava/lang/String;Ljava/lang/String;)I

    .line 137
    iget-object v2, p0, Lcom/cyjh/elfin/fragment/AdFragment;->adPassData:Lcom/cyjh/elfin/entity/AdPassData;

    if-eqz v2, :cond_0

    .line 138
    const-string v2, "zzz"

    new-instance v3, Ljava/lang/StringBuilder;

    invoke-direct {v3}, Ljava/lang/StringBuilder;-><init>()V

    const-string v4, "onActivityCreated--adPassData.adImgUrl--"

    invoke-virtual {v3, v4}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v3

    iget-object v4, p0, Lcom/cyjh/elfin/fragment/AdFragment;->adPassData:Lcom/cyjh/elfin/entity/AdPassData;

    iget-object v4, v4, Lcom/cyjh/elfin/entity/AdPassData;->adImgUrl:Ljava/lang/String;

    invoke-virtual {v3, v4}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v3

    invoke-virtual {v3}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v3

    invoke-static {v2, v3}, Landroid/util/Log;->e(Ljava/lang/String;Ljava/lang/String;)I

    .line 140
    iget-object v2, p0, Lcom/cyjh/elfin/fragment/AdFragment;->adPassData:Lcom/cyjh/elfin/entity/AdPassData;

    iget-object v2, v2, Lcom/cyjh/elfin/entity/AdPassData;->adImgUrl:Ljava/lang/String;

    invoke-static {v2, v1}, Landroid/text/TextUtils;->equals(Ljava/lang/CharSequence;Ljava/lang/CharSequence;)Z

    move-result v2

    if-nez v2, :cond_1

    .line 141
    iput-boolean v6, p0, Lcom/cyjh/elfin/fragment/AdFragment;->isCachePic:Z

    .line 162
    :goto_0
    iget-object v2, p0, Lcom/cyjh/elfin/fragment/AdFragment;->appContext:Lcom/cyjh/elfin/AppContext;

    iget-object v2, v2, Lcom/cyjh/elfin/AppContext;->mSharePre:Landroid/content/SharedPreferences;

    invoke-interface {v2}, Landroid/content/SharedPreferences;->edit()Landroid/content/SharedPreferences$Editor;

    move-result-object v0

    .line 163
    .local v0, "editor":Landroid/content/SharedPreferences$Editor;
    const-string v2, "last_ad_id"

    iget-object v3, p0, Lcom/cyjh/elfin/fragment/AdFragment;->adPassData:Lcom/cyjh/elfin/entity/AdPassData;

    iget-object v3, v3, Lcom/cyjh/elfin/entity/AdPassData;->adDataId:Ljava/lang/String;

    invoke-interface {v0, v2, v3}, Landroid/content/SharedPreferences$Editor;->putString(Ljava/lang/String;Ljava/lang/String;)Landroid/content/SharedPreferences$Editor;

    .line 164
    const-string v2, "last_ad_link_url"

    iget-object v3, p0, Lcom/cyjh/elfin/fragment/AdFragment;->adPassData:Lcom/cyjh/elfin/entity/AdPassData;

    iget-object v3, v3, Lcom/cyjh/elfin/entity/AdPassData;->adImgUrl:Ljava/lang/String;

    invoke-interface {v0, v2, v3}, Landroid/content/SharedPreferences$Editor;->putString(Ljava/lang/String;Ljava/lang/String;)Landroid/content/SharedPreferences$Editor;

    .line 165
    const-string v2, "last_ad_link_type"

    iget-object v3, p0, Lcom/cyjh/elfin/fragment/AdFragment;->adPassData:Lcom/cyjh/elfin/entity/AdPassData;

    iget-object v3, v3, Lcom/cyjh/elfin/entity/AdPassData;->adLinkType:Ljava/lang/String;

    invoke-interface {v0, v2, v3}, Landroid/content/SharedPreferences$Editor;->putString(Ljava/lang/String;Ljava/lang/String;)Landroid/content/SharedPreferences$Editor;

    .line 166
    const-string v2, "last_ad_jump_linkurl"

    iget-object v3, p0, Lcom/cyjh/elfin/fragment/AdFragment;->adPassData:Lcom/cyjh/elfin/entity/AdPassData;

    iget-object v3, v3, Lcom/cyjh/elfin/entity/AdPassData;->adJumpLink:Ljava/lang/String;

    invoke-interface {v0, v2, v3}, Landroid/content/SharedPreferences$Editor;->putString(Ljava/lang/String;Ljava/lang/String;)Landroid/content/SharedPreferences$Editor;

    .line 167
    const-string v2, "last_ad_title"

    iget-object v3, p0, Lcom/cyjh/elfin/fragment/AdFragment;->adPassData:Lcom/cyjh/elfin/entity/AdPassData;

    iget-object v3, v3, Lcom/cyjh/elfin/entity/AdPassData;->adTitle:Ljava/lang/String;

    invoke-interface {v0, v2, v3}, Landroid/content/SharedPreferences$Editor;->putString(Ljava/lang/String;Ljava/lang/String;)Landroid/content/SharedPreferences$Editor;

    .line 168
    invoke-interface {v0}, Landroid/content/SharedPreferences$Editor;->apply()V

    .line 171
    .end local v0    # "editor":Landroid/content/SharedPreferences$Editor;
    :cond_0
    return-void

    .line 144
    :cond_1
    iget-object v2, p0, Lcom/cyjh/elfin/fragment/AdFragment;->adPassData:Lcom/cyjh/elfin/entity/AdPassData;

    iget-object v2, v2, Lcom/cyjh/elfin/entity/AdPassData;->adTitle:Ljava/lang/String;

    iput-object v2, p0, Lcom/cyjh/elfin/fragment/AdFragment;->lastAdTitle:Ljava/lang/String;

    .line 145
    iget-object v2, p0, Lcom/cyjh/elfin/fragment/AdFragment;->adPassData:Lcom/cyjh/elfin/entity/AdPassData;

    iget-object v2, v2, Lcom/cyjh/elfin/entity/AdPassData;->adDataId:Ljava/lang/String;

    iput-object v2, p0, Lcom/cyjh/elfin/fragment/AdFragment;->lastAdId:Ljava/lang/String;

    .line 146
    iget-object v2, p0, Lcom/cyjh/elfin/fragment/AdFragment;->adPassData:Lcom/cyjh/elfin/entity/AdPassData;

    iget-object v2, v2, Lcom/cyjh/elfin/entity/AdPassData;->adLinkType:Ljava/lang/String;

    iput-object v2, p0, Lcom/cyjh/elfin/fragment/AdFragment;->lastLinkType:Ljava/lang/String;

    .line 147
    iget-object v2, p0, Lcom/cyjh/elfin/fragment/AdFragment;->adPassData:Lcom/cyjh/elfin/entity/AdPassData;

    iget-object v2, v2, Lcom/cyjh/elfin/entity/AdPassData;->adJumpLink:Ljava/lang/String;

    iput-object v2, p0, Lcom/cyjh/elfin/fragment/AdFragment;->lastJumpLinkUrl:Ljava/lang/String;

    goto :goto_0
.end method

.method public onClick(Landroid/view/View;)V
    .locals 7
    .param p1, "v"    # Landroid/view/View;

    .prologue
    .line 291
    invoke-virtual {p1}, Landroid/view/View;->getId()I

    move-result v3

    packed-switch v3, :pswitch_data_0

    .line 336
    :cond_0
    :goto_0
    :pswitch_0
    return-void

    .line 294
    :pswitch_1
    const-string v3, "zzz"

    const-string v4, "AdFragment---onClick---1"

    invoke-static {v3, v4}, Landroid/util/Log;->e(Ljava/lang/String;Ljava/lang/String;)I

    .line 295
    iget-boolean v3, p0, Lcom/cyjh/elfin/fragment/AdFragment;->isDisplayCunFeiAd:Z

    if-eqz v3, :cond_1

    iget v3, p0, Lcom/cyjh/elfin/fragment/AdFragment;->count:I

    const/4 v4, 0x3

    if-ge v3, v4, :cond_1

    .line 296
    const-string v3, "zzz"

    const-string v4, "AdFragment---onClick---2"

    invoke-static {v3, v4}, Landroid/util/Log;->e(Ljava/lang/String;Ljava/lang/String;)I

    .line 297
    invoke-direct {p0}, Lcom/cyjh/elfin/fragment/AdFragment;->onClickImageXunFeiAd()V

    goto :goto_0

    .line 299
    :cond_1
    const-string v3, "zzz"

    const-string v4, "AdFragment---onClick---3"

    invoke-static {v3, v4}, Landroid/util/Log;->e(Ljava/lang/String;Ljava/lang/String;)I

    .line 300
    invoke-direct {p0}, Lcom/cyjh/elfin/fragment/AdFragment;->toCallGamesOrFreeActivity()V

    goto :goto_0

    .line 305
    :pswitch_2
    iget-boolean v3, p0, Lcom/cyjh/elfin/fragment/AdFragment;->isDisplayCunFeiAd:Z

    if-eqz v3, :cond_2

    .line 306
    invoke-direct {p0}, Lcom/cyjh/elfin/fragment/AdFragment;->onClickImageXunFeiAd()V

    .line 327
    :goto_1
    const/4 v3, 0x1

    iput-boolean v3, p0, Lcom/cyjh/elfin/fragment/AdFragment;->flag:Z

    .line 328
    iget-object v3, p0, Lcom/cyjh/elfin/fragment/AdFragment;->submitCountTimer:Lcom/cyjh/elfin/fragment/AdFragment$SubmitCountTimer;

    if-eqz v3, :cond_0

    .line 329
    iget-object v3, p0, Lcom/cyjh/elfin/fragment/AdFragment;->submitCountTimer:Lcom/cyjh/elfin/fragment/AdFragment$SubmitCountTimer;

    invoke-virtual {v3}, Lcom/cyjh/elfin/fragment/AdFragment$SubmitCountTimer;->cancel()V

    .line 330
    const/4 v3, 0x0

    iput-object v3, p0, Lcom/cyjh/elfin/fragment/AdFragment;->submitCountTimer:Lcom/cyjh/elfin/fragment/AdFragment$SubmitCountTimer;

    goto :goto_0

    .line 308
    :cond_2
    iget-object v3, p0, Lcom/cyjh/elfin/fragment/AdFragment;->lastLinkType:Ljava/lang/String;

    const-string v4, "1"

    invoke-static {v3, v4}, Landroid/text/TextUtils;->equals(Ljava/lang/CharSequence;Ljava/lang/CharSequence;)Z

    move-result v3

    if-eqz v3, :cond_4

    .line 309
    iget-object v3, p0, Lcom/cyjh/elfin/fragment/AdFragment;->lastJumpLinkUrl:Ljava/lang/String;

    invoke-static {v3}, Landroid/text/TextUtils;->isEmpty(Ljava/lang/CharSequence;)Z

    move-result v3

    if-nez v3, :cond_3

    iget-object v3, p0, Lcom/cyjh/elfin/fragment/AdFragment;->lastJumpLinkUrl:Ljava/lang/String;

    const-string v4, "http"

    invoke-virtual {v3, v4}, Ljava/lang/String;->startsWith(Ljava/lang/String;)Z

    move-result v3

    if-eqz v3, :cond_3

    .line 310
    iget-object v3, p0, Lcom/cyjh/elfin/fragment/AdFragment;->lastJumpLinkUrl:Ljava/lang/String;

    invoke-static {v3}, Landroid/net/Uri;->parse(Ljava/lang/String;)Landroid/net/Uri;

    move-result-object v2

    .line 311
    .local v2, "uri":Landroid/net/Uri;
    new-instance v1, Landroid/content/Intent;

    const-string v3, "android.intent.action.VIEW"

    invoke-direct {v1, v3, v2}, Landroid/content/Intent;-><init>(Ljava/lang/String;Landroid/net/Uri;)V

    .line 312
    .local v1, "intent":Landroid/content/Intent;
    const/high16 v3, 0x10000000

    invoke-virtual {v1, v3}, Landroid/content/Intent;->addFlags(I)Landroid/content/Intent;

    .line 313
    invoke-virtual {p0}, Lcom/cyjh/elfin/fragment/AdFragment;->getActivity()Landroid/support/v4/app/FragmentActivity;

    move-result-object v3

    invoke-virtual {v3, v1}, Landroid/support/v4/app/FragmentActivity;->startActivity(Landroid/content/Intent;)V

    .line 325
    .end local v1    # "intent":Landroid/content/Intent;
    .end local v2    # "uri":Landroid/net/Uri;
    :cond_3
    :goto_2
    iget-object v3, p0, Lcom/cyjh/elfin/fragment/AdFragment;->backgroundAdStatistics:Lcom/cyjh/elfin/mvp/managers/BackgroundSettingsAdStatistics;

    invoke-virtual {p0}, Lcom/cyjh/elfin/fragment/AdFragment;->getActivity()Landroid/support/v4/app/FragmentActivity;

    move-result-object v4

    iget-object v5, p0, Lcom/cyjh/elfin/fragment/AdFragment;->lastAdId:Ljava/lang/String;

    const-string v6, "1"

    invoke-virtual {v3, v4, v5, v6}, Lcom/cyjh/elfin/mvp/managers/BackgroundSettingsAdStatistics;->backgroundStatisticsAdCount(Landroid/content/Context;Ljava/lang/String;Ljava/lang/String;)V

    goto :goto_1

    .line 315
    :cond_4
    iget-object v3, p0, Lcom/cyjh/elfin/fragment/AdFragment;->lastLinkType:Ljava/lang/String;

    const-string v4, "2"

    invoke-static {v3, v4}, Landroid/text/TextUtils;->equals(Ljava/lang/CharSequence;Ljava/lang/CharSequence;)Z

    move-result v3

    if-eqz v3, :cond_3

    .line 316
    iget-object v3, p0, Lcom/cyjh/elfin/fragment/AdFragment;->lastAdTitle:Ljava/lang/String;

    const v4, 0x7f0800fd

    invoke-virtual {p0, v4}, Lcom/cyjh/elfin/fragment/AdFragment;->getString(I)Ljava/lang/String;

    move-result-object v4

    invoke-virtual {v3, v4}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v3

    if-eqz v3, :cond_5

    .line 317
    invoke-virtual {p0}, Lcom/cyjh/elfin/fragment/AdFragment;->getContext()Landroid/content/Context;

    move-result-object v3

    iget-object v4, p0, Lcom/cyjh/elfin/fragment/AdFragment;->lastAdTitle:Ljava/lang/String;

    invoke-static {v3, v4}, Lcom/cyjh/elfin/util/IntentUtils;->toCallAbGames(Landroid/content/Context;Ljava/lang/String;)V

    goto :goto_2

    .line 319
    :cond_5
    new-instance v0, Lcom/cyjh/elfin/entity/GameInfo;

    invoke-direct {v0}, Lcom/cyjh/elfin/entity/GameInfo;-><init>()V

    .line 320
    .local v0, "gameInfo":Lcom/cyjh/elfin/entity/GameInfo;
    iget-object v3, p0, Lcom/cyjh/elfin/fragment/AdFragment;->lastJumpLinkUrl:Ljava/lang/String;

    iput-object v3, v0, Lcom/cyjh/elfin/entity/GameInfo;->Id:Ljava/lang/String;

    .line 321
    iget-object v3, p0, Lcom/cyjh/elfin/fragment/AdFragment;->lastAdTitle:Ljava/lang/String;

    iput-object v3, v0, Lcom/cyjh/elfin/entity/GameInfo;->Name:Ljava/lang/String;

    .line 322
    invoke-virtual {p0}, Lcom/cyjh/elfin/fragment/AdFragment;->getContext()Landroid/content/Context;

    move-result-object v3

    invoke-static {v3, v0}, Lcom/cyjh/elfin/util/IntentUtils;->toAbGamesDetailsActivity(Landroid/content/Context;Lcom/cyjh/elfin/entity/GameInfo;)V

    goto :goto_2

    .line 291
    :pswitch_data_0
    .packed-switch 0x7f0f00f8
        :pswitch_2
        :pswitch_0
        :pswitch_1
    .end packed-switch
.end method

.method public onCreate(Landroid/os/Bundle;)V
    .locals 4
    .param p1, "savedInstanceState"    # Landroid/os/Bundle;

    .prologue
    .line 98
    invoke-super {p0, p1}, Lcom/cyjh/elfin/fragment/BaseFragement;->onCreate(Landroid/os/Bundle;)V

    .line 100
    invoke-virtual {p0}, Lcom/cyjh/elfin/fragment/AdFragment;->getActivity()Landroid/support/v4/app/FragmentActivity;

    move-result-object v1

    invoke-virtual {v1}, Landroid/support/v4/app/FragmentActivity;->getApplicationContext()Landroid/content/Context;

    move-result-object v0

    check-cast v0, Lcom/cyjh/elfin/AppContext;

    .line 101
    .local v0, "appContext":Lcom/cyjh/elfin/AppContext;
    iget-object v1, v0, Lcom/cyjh/elfin/AppContext;->mSharePre:Landroid/content/SharedPreferences;

    const-string v2, "recommend_games_link"

    const-string v3, ""

    invoke-interface {v1, v2, v3}, Landroid/content/SharedPreferences;->getString(Ljava/lang/String;Ljava/lang/String;)Ljava/lang/String;

    move-result-object v1

    iput-object v1, p0, Lcom/cyjh/elfin/fragment/AdFragment;->recommendGamesLink:Ljava/lang/String;

    .line 102
    new-instance v1, Lcom/cyjh/elfin/fragment/AdFragment$CloseAdTimer;

    const/16 v2, 0x8

    invoke-direct {v1, p0, v2}, Lcom/cyjh/elfin/fragment/AdFragment$CloseAdTimer;-><init>(Lcom/cyjh/elfin/fragment/AdFragment;I)V

    iput-object v1, p0, Lcom/cyjh/elfin/fragment/AdFragment;->mCloseAdTimer:Lcom/cyjh/elfin/fragment/AdFragment$CloseAdTimer;

    .line 103
    iget-object v1, p0, Lcom/cyjh/elfin/fragment/AdFragment;->mCloseAdTimer:Lcom/cyjh/elfin/fragment/AdFragment$CloseAdTimer;

    invoke-virtual {v1}, Lcom/cyjh/elfin/fragment/AdFragment$CloseAdTimer;->start()Landroid/os/CountDownTimer;

    .line 104
    return-void
.end method

.method public onDestroy()V
    .locals 3

    .prologue
    .line 273
    invoke-super {p0}, Lcom/cyjh/elfin/fragment/BaseFragement;->onDestroy()V

    .line 274
    const-string v0, "zzz"

    new-instance v1, Ljava/lang/StringBuilder;

    invoke-direct {v1}, Ljava/lang/StringBuilder;-><init>()V

    const-string v2, "AdFragment--onDestroy"

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    iget-boolean v2, p0, Lcom/cyjh/elfin/fragment/AdFragment;->isCachePic:Z

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Z)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v1

    invoke-static {v0, v1}, Landroid/util/Log;->e(Ljava/lang/String;Ljava/lang/String;)I

    .line 281
    iget-object v0, p0, Lcom/cyjh/elfin/fragment/AdFragment;->submitCountTimer:Lcom/cyjh/elfin/fragment/AdFragment$SubmitCountTimer;

    if-eqz v0, :cond_0

    .line 282
    iget-object v0, p0, Lcom/cyjh/elfin/fragment/AdFragment;->submitCountTimer:Lcom/cyjh/elfin/fragment/AdFragment$SubmitCountTimer;

    invoke-virtual {v0}, Lcom/cyjh/elfin/fragment/AdFragment$SubmitCountTimer;->cancel()V

    .line 283
    const/4 v0, 0x0

    iput-object v0, p0, Lcom/cyjh/elfin/fragment/AdFragment;->submitCountTimer:Lcom/cyjh/elfin/fragment/AdFragment$SubmitCountTimer;

    .line 285
    :cond_0
    iget-object v0, p0, Lcom/cyjh/elfin/fragment/AdFragment;->backgroundAdStatistics:Lcom/cyjh/elfin/mvp/managers/BackgroundSettingsAdStatistics;

    invoke-virtual {v0}, Lcom/cyjh/elfin/mvp/managers/BackgroundSettingsAdStatistics;->cancelReqCountStatistics()V

    .line 286
    iget-object v0, p0, Lcom/cyjh/elfin/fragment/AdFragment;->mAdSwitchPresenter:Lcom/cyjh/elfin/mvp/presenters/IFLYAdSwitchPresenter;

    invoke-virtual {v0}, Lcom/cyjh/elfin/mvp/presenters/IFLYAdSwitchPresenter;->stop()V

    .line 287
    return-void
.end method

.method public onPause()V
    .locals 1

    .prologue
    .line 267
    invoke-super {p0}, Lcom/cyjh/elfin/fragment/BaseFragement;->onPause()V

    .line 268
    const-class v0, Lcom/cyjh/elfin/fragment/AdFragment;

    invoke-virtual {v0}, Ljava/lang/Class;->getCanonicalName()Ljava/lang/String;

    move-result-object v0

    invoke-static {v0}, Lcom/umeng/analytics/MobclickAgent;->onPageEnd(Ljava/lang/String;)V

    .line 269
    return-void
.end method

.method public onResume()V
    .locals 1

    .prologue
    .line 241
    invoke-super {p0}, Lcom/cyjh/elfin/fragment/BaseFragement;->onResume()V

    .line 242
    const-class v0, Lcom/cyjh/elfin/fragment/AdFragment;

    invoke-virtual {v0}, Ljava/lang/Class;->getCanonicalName()Ljava/lang/String;

    move-result-object v0

    invoke-static {v0}, Lcom/umeng/analytics/MobclickAgent;->onPageStart(Ljava/lang/String;)V

    .line 243
    iget-boolean v0, p0, Lcom/cyjh/elfin/fragment/AdFragment;->flag:Z

    if-eqz v0, :cond_0

    .line 244
    invoke-direct {p0}, Lcom/cyjh/elfin/fragment/AdFragment;->toCallGamesOrFreeActivity()V

    .line 247
    :cond_0
    return-void
.end method

.method public onSwitchFail()V
    .locals 0

    .prologue
    .line 486
    invoke-direct {p0}, Lcom/cyjh/elfin/fragment/AdFragment;->displayBackGroundAd()V

    .line 487
    return-void
.end method

.method public onSwitchSuc(Ljava/lang/String;Z)V
    .locals 2
    .param p1, "status"    # Ljava/lang/String;
    .param p2, "isShow"    # Z

    .prologue
    .line 474
    const-string v0, "1"

    invoke-virtual {p1, v0}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v0

    if-eqz v0, :cond_0

    if-eqz p2, :cond_0

    .line 475
    const-string v0, "zzz"

    const-string v1, "AdFragment IFLYAdSwitchManager.onSwitchSuc--1"

    invoke-static {v0, v1}, Landroid/util/Log;->e(Ljava/lang/String;Ljava/lang/String;)I

    .line 477
    invoke-direct {p0}, Lcom/cyjh/elfin/fragment/AdFragment;->loadXunFei()V

    .line 482
    :goto_0
    return-void

    .line 479
    :cond_0
    const-string v0, "zzz"

    const-string v1, "AdFragment IFLYAdSwitchManager.onSwitchSuc--2"

    invoke-static {v0, v1}, Landroid/util/Log;->e(Ljava/lang/String;Ljava/lang/String;)I

    .line 480
    invoke-direct {p0}, Lcom/cyjh/elfin/fragment/AdFragment;->displayBackGroundAd()V

    goto :goto_0
.end method

.method public onViewCreated(Landroid/view/View;Landroid/os/Bundle;)V
    .locals 0
    .param p1, "view"    # Landroid/view/View;
    .param p2, "savedInstanceState"    # Landroid/os/Bundle;

    .prologue
    .line 223
    invoke-super {p0, p1, p2}, Lcom/cyjh/elfin/fragment/BaseFragement;->onViewCreated(Landroid/view/View;Landroid/os/Bundle;)V

    .line 224
    invoke-direct {p0, p1}, Lcom/cyjh/elfin/fragment/AdFragment;->initView(Landroid/view/View;)V

    .line 225
    return-void
.end method
