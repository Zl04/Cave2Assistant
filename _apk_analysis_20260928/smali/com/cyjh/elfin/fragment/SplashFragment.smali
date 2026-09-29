.class public Lcom/cyjh/elfin/fragment/SplashFragment;
.super Lcom/cyjh/elfin/fragment/BaseFragement;
.source "SplashFragment.java"

# interfaces
.implements Lcom/cyjh/elfin/mvp/views/TemplateView;
.implements Lcom/cyjh/elfin/mvp/views/AdImageView;
.implements Lcom/cyjh/elfin/mvp/views/RecommendGamesView;
.implements Lcom/cyjh/elfin/mvp/views/BlackListView;


# annotations
.annotation system Ldalvik/annotation/MemberClasses;
    value = {
        Lcom/cyjh/elfin/fragment/SplashFragment$CloseAdTimer;,
        Lcom/cyjh/elfin/fragment/SplashFragment$CountTimeRunnable;,
        Lcom/cyjh/elfin/fragment/SplashFragment$VersionKnownListener;,
        Lcom/cyjh/elfin/fragment/SplashFragment$ResetNetworkListener;,
        Lcom/cyjh/elfin/fragment/SplashFragment$SettingNetworkListener;,
        Lcom/cyjh/elfin/fragment/SplashFragment$RunnableTask;
    }
.end annotation


# static fields
.field public static final AD_SHOW_TIME:I = 0x8

.field public static final AN_HOUR:I = 0x3c

.field private static final APP_CLOSED:I = 0x1

.field private static final APP_PASS:I = 0x3

.field private static final APP_USE_TIPS:I = 0x2

.field public static final BACK_AD_REQ_MESSAGE:I = 0xc

.field public static final CHECKED_XUNFEI_REQ_MESSAGE:I = 0xe

.field private static final CIRCLE_SIZE_VALUE:F = 8.0f

.field private static final CIRCLE_TOTAL_COUNT:I = 0x6

.field private static final COLOR_BLUE:Ljava/lang/String; = "#3c7ac5"

.field private static final COLOR_GRAY:Ljava/lang/String; = "#bababa"

.field private static final CYCLE_TIME_DOT:I = 0x64

.field private static final DEFAULT_VALUE:I = 0x0

.field public static final HALF_AN_HOUR:I = 0x1e

.field private static final ILFY_AD_REPLACE_MESSAGE:I = 0x10

.field public static final ILFY_REQ_COUNT_MESSAGE:I = 0xf

.field public static final OTHERS_AD_REQ_MESSAGE:I = 0xd

.field public static final REQ_TOTAL_COUNT:I = 0x5

.field public static final STR_START_INTERCEPT:I = 0x2

.field private static final TIME_INTERTAL_Millis:I = 0x3e8

.field public static final TOTAL_TIME:I = 0xa


# instance fields
.field private OnImageClick:Landroid/view/View$OnClickListener;

.field private XunFeiFlag:Z

.field private adDataBean:Lcom/cyjh/elfin/entity/Ad$DataBean;

.field private adILFYType:Ljava/lang/String;

.field private adImagePresenter:Lcom/cyjh/elfin/mvp/presenters/AdImagePresenter;

.field private adImgClicker:Z

.field private adItem:Lcom/iflytek/voiceads/NativeADDataRef;

.field private backgroundAdStatistics:Lcom/cyjh/elfin/mvp/managers/BackgroundSettingsAdStatistics;

.field private blackListPresenter:Lcom/cyjh/elfin/mvp/presenters/BlackListPresenter;

.field private checkedResultReq:Z

.field private countAdTimer:I

.field private countReq:I

.field private countTimeAdd:I

.field private currentDotCounts:I

.field private imageViewLists:Ljava/util/List;
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "Ljava/util/List",
            "<",
            "Landroid/widget/ImageView;",
            ">;"
        }
    .end annotation
.end field

.field private isClickerFirst:Z

.field private isDisplayScreenAd:Z

.field private isLoadXunFeiFirst:Z

.field private isOpenScreenLoad:Z

.field private isSecondRequestFlag:Z

.field private mBlueGradientDrawable:Landroid/graphics/drawable/GradientDrawable;

.field private mCloseAdTimer:Lcom/cyjh/elfin/fragment/SplashFragment$CloseAdTimer;

.field private mCountRunnable:Lcom/cyjh/elfin/fragment/SplashFragment$CountTimeRunnable;

.field private mGrayGradientDrawable:Landroid/graphics/drawable/GradientDrawable;

.field private mHandler:Landroid/os/Handler;

.field private mImgAdFullScreen:Landroid/widget/ImageView;

.field private mImgBgLogo:Landroid/widget/ImageView;

.field private mLinearCircleDot:Landroid/widget/LinearLayout;

.field private mNativeListener:Lcom/iflytek/voiceads/IFLYNativeListener;

.field private mRlBottomLayout:Landroid/widget/RelativeLayout;

.field private mRunnableTask:Lcom/cyjh/elfin/fragment/SplashFragment$RunnableTask;

.field private mTvAdMark:Landroid/widget/TextView;

.field private mTvCloseAd:Landroid/widget/TextView;

.field private nativeAd:Lcom/iflytek/voiceads/IFLYNativeAd;

.field private recommendGamesPresenter:Lcom/cyjh/elfin/mvp/presenters/RecommendGamesPresenter;

.field private remarkText:Ljava/lang/String;

.field private saveServerTime:J

.field private templatePresenter:Lcom/cyjh/elfin/mvp/presenters/TemplatePresenter;


# direct methods
.method public constructor <init>()V
    .locals 3

    .prologue
    const/4 v2, 0x0

    .line 79
    invoke-direct {p0}, Lcom/cyjh/elfin/fragment/BaseFragement;-><init>()V

    .line 106
    iput-boolean v2, p0, Lcom/cyjh/elfin/fragment/SplashFragment;->isSecondRequestFlag:Z

    .line 108
    new-instance v0, Ljava/util/ArrayList;

    invoke-direct {v0}, Ljava/util/ArrayList;-><init>()V

    iput-object v0, p0, Lcom/cyjh/elfin/fragment/SplashFragment;->imageViewLists:Ljava/util/List;

    .line 114
    iput v2, p0, Lcom/cyjh/elfin/fragment/SplashFragment;->countReq:I

    .line 115
    const-wide/16 v0, 0x0

    iput-wide v0, p0, Lcom/cyjh/elfin/fragment/SplashFragment;->saveServerTime:J

    .line 121
    iput-boolean v2, p0, Lcom/cyjh/elfin/fragment/SplashFragment;->isClickerFirst:Z

    .line 122
    iput-boolean v2, p0, Lcom/cyjh/elfin/fragment/SplashFragment;->checkedResultReq:Z

    .line 129
    iput v2, p0, Lcom/cyjh/elfin/fragment/SplashFragment;->countTimeAdd:I

    .line 132
    iput-boolean v2, p0, Lcom/cyjh/elfin/fragment/SplashFragment;->XunFeiFlag:Z

    .line 133
    iput-boolean v2, p0, Lcom/cyjh/elfin/fragment/SplashFragment;->isOpenScreenLoad:Z

    .line 135
    iput-boolean v2, p0, Lcom/cyjh/elfin/fragment/SplashFragment;->isDisplayScreenAd:Z

    .line 139
    new-instance v0, Lcom/cyjh/elfin/fragment/SplashFragment$1;

    invoke-direct {v0, p0}, Lcom/cyjh/elfin/fragment/SplashFragment$1;-><init>(Lcom/cyjh/elfin/fragment/SplashFragment;)V

    iput-object v0, p0, Lcom/cyjh/elfin/fragment/SplashFragment;->mHandler:Landroid/os/Handler;

    .line 783
    new-instance v0, Lcom/cyjh/elfin/fragment/SplashFragment$3;

    invoke-direct {v0, p0}, Lcom/cyjh/elfin/fragment/SplashFragment$3;-><init>(Lcom/cyjh/elfin/fragment/SplashFragment;)V

    iput-object v0, p0, Lcom/cyjh/elfin/fragment/SplashFragment;->mNativeListener:Lcom/iflytek/voiceads/IFLYNativeListener;

    .line 869
    new-instance v0, Lcom/cyjh/elfin/fragment/SplashFragment$4;

    invoke-direct {v0, p0}, Lcom/cyjh/elfin/fragment/SplashFragment$4;-><init>(Lcom/cyjh/elfin/fragment/SplashFragment;)V

    iput-object v0, p0, Lcom/cyjh/elfin/fragment/SplashFragment;->OnImageClick:Landroid/view/View$OnClickListener;

    return-void
.end method

.method static synthetic access$000(Lcom/cyjh/elfin/fragment/SplashFragment;)Lcom/cyjh/elfin/mvp/presenters/TemplatePresenter;
    .locals 1
    .param p0, "x0"    # Lcom/cyjh/elfin/fragment/SplashFragment;

    .prologue
    .line 79
    iget-object v0, p0, Lcom/cyjh/elfin/fragment/SplashFragment;->templatePresenter:Lcom/cyjh/elfin/mvp/presenters/TemplatePresenter;

    return-object v0
.end method

.method static synthetic access$100(Lcom/cyjh/elfin/fragment/SplashFragment;)Lcom/cyjh/elfin/mvp/presenters/AdImagePresenter;
    .locals 1
    .param p0, "x0"    # Lcom/cyjh/elfin/fragment/SplashFragment;

    .prologue
    .line 79
    iget-object v0, p0, Lcom/cyjh/elfin/fragment/SplashFragment;->adImagePresenter:Lcom/cyjh/elfin/mvp/presenters/AdImagePresenter;

    return-object v0
.end method

.method static synthetic access$1000(Lcom/cyjh/elfin/fragment/SplashFragment;)Landroid/widget/TextView;
    .locals 1
    .param p0, "x0"    # Lcom/cyjh/elfin/fragment/SplashFragment;

    .prologue
    .line 79
    iget-object v0, p0, Lcom/cyjh/elfin/fragment/SplashFragment;->mTvCloseAd:Landroid/widget/TextView;

    return-object v0
.end method

.method static synthetic access$1100(Lcom/cyjh/elfin/fragment/SplashFragment;)Landroid/widget/ImageView;
    .locals 1
    .param p0, "x0"    # Lcom/cyjh/elfin/fragment/SplashFragment;

    .prologue
    .line 79
    iget-object v0, p0, Lcom/cyjh/elfin/fragment/SplashFragment;->mImgBgLogo:Landroid/widget/ImageView;

    return-object v0
.end method

.method static synthetic access$1200(Lcom/cyjh/elfin/fragment/SplashFragment;)Landroid/widget/RelativeLayout;
    .locals 1
    .param p0, "x0"    # Lcom/cyjh/elfin/fragment/SplashFragment;

    .prologue
    .line 79
    iget-object v0, p0, Lcom/cyjh/elfin/fragment/SplashFragment;->mRlBottomLayout:Landroid/widget/RelativeLayout;

    return-object v0
.end method

.method static synthetic access$1300(Lcom/cyjh/elfin/fragment/SplashFragment;)Lcom/cyjh/elfin/mvp/managers/BackgroundSettingsAdStatistics;
    .locals 1
    .param p0, "x0"    # Lcom/cyjh/elfin/fragment/SplashFragment;

    .prologue
    .line 79
    iget-object v0, p0, Lcom/cyjh/elfin/fragment/SplashFragment;->backgroundAdStatistics:Lcom/cyjh/elfin/mvp/managers/BackgroundSettingsAdStatistics;

    return-object v0
.end method

.method static synthetic access$1402(Lcom/cyjh/elfin/fragment/SplashFragment;Z)Z
    .locals 0
    .param p0, "x0"    # Lcom/cyjh/elfin/fragment/SplashFragment;
    .param p1, "x1"    # Z

    .prologue
    .line 79
    iput-boolean p1, p0, Lcom/cyjh/elfin/fragment/SplashFragment;->isDisplayScreenAd:Z

    return p1
.end method

.method static synthetic access$1500(Lcom/cyjh/elfin/fragment/SplashFragment;)Landroid/view/View$OnClickListener;
    .locals 1
    .param p0, "x0"    # Lcom/cyjh/elfin/fragment/SplashFragment;

    .prologue
    .line 79
    iget-object v0, p0, Lcom/cyjh/elfin/fragment/SplashFragment;->OnImageClick:Landroid/view/View$OnClickListener;

    return-object v0
.end method

.method static synthetic access$1600(Lcom/cyjh/elfin/fragment/SplashFragment;)V
    .locals 0
    .param p0, "x0"    # Lcom/cyjh/elfin/fragment/SplashFragment;

    .prologue
    .line 79
    invoke-direct {p0}, Lcom/cyjh/elfin/fragment/SplashFragment;->displayEightSecond()V

    return-void
.end method

.method static synthetic access$1700(Lcom/cyjh/elfin/fragment/SplashFragment;)V
    .locals 0
    .param p0, "x0"    # Lcom/cyjh/elfin/fragment/SplashFragment;

    .prologue
    .line 79
    invoke-direct {p0}, Lcom/cyjh/elfin/fragment/SplashFragment;->cancelCloseTimer()V

    return-void
.end method

.method static synthetic access$1800(Lcom/cyjh/elfin/fragment/SplashFragment;)I
    .locals 1
    .param p0, "x0"    # Lcom/cyjh/elfin/fragment/SplashFragment;

    .prologue
    .line 79
    iget v0, p0, Lcom/cyjh/elfin/fragment/SplashFragment;->countAdTimer:I

    return v0
.end method

.method static synthetic access$1808(Lcom/cyjh/elfin/fragment/SplashFragment;)I
    .locals 2
    .param p0, "x0"    # Lcom/cyjh/elfin/fragment/SplashFragment;

    .prologue
    .line 79
    iget v0, p0, Lcom/cyjh/elfin/fragment/SplashFragment;->countAdTimer:I

    add-int/lit8 v1, v0, 0x1

    iput v1, p0, Lcom/cyjh/elfin/fragment/SplashFragment;->countAdTimer:I

    return v0
.end method

.method static synthetic access$1900(Lcom/cyjh/elfin/fragment/SplashFragment;Landroid/view/View;)V
    .locals 0
    .param p0, "x0"    # Lcom/cyjh/elfin/fragment/SplashFragment;
    .param p1, "x1"    # Landroid/view/View;

    .prologue
    .line 79
    invoke-direct {p0, p1}, Lcom/cyjh/elfin/fragment/SplashFragment;->onClickImgFullScrenAd(Landroid/view/View;)V

    return-void
.end method

.method static synthetic access$200(Lcom/cyjh/elfin/fragment/SplashFragment;)Z
    .locals 1
    .param p0, "x0"    # Lcom/cyjh/elfin/fragment/SplashFragment;

    .prologue
    .line 79
    iget-boolean v0, p0, Lcom/cyjh/elfin/fragment/SplashFragment;->isLoadXunFeiFirst:Z

    return v0
.end method

.method static synthetic access$202(Lcom/cyjh/elfin/fragment/SplashFragment;Z)Z
    .locals 0
    .param p0, "x0"    # Lcom/cyjh/elfin/fragment/SplashFragment;
    .param p1, "x1"    # Z

    .prologue
    .line 79
    iput-boolean p1, p0, Lcom/cyjh/elfin/fragment/SplashFragment;->isLoadXunFeiFirst:Z

    return p1
.end method

.method static synthetic access$2100(Lcom/cyjh/elfin/fragment/SplashFragment;)I
    .locals 1
    .param p0, "x0"    # Lcom/cyjh/elfin/fragment/SplashFragment;

    .prologue
    .line 79
    iget v0, p0, Lcom/cyjh/elfin/fragment/SplashFragment;->currentDotCounts:I

    return v0
.end method

.method static synthetic access$2108(Lcom/cyjh/elfin/fragment/SplashFragment;)I
    .locals 2
    .param p0, "x0"    # Lcom/cyjh/elfin/fragment/SplashFragment;

    .prologue
    .line 79
    iget v0, p0, Lcom/cyjh/elfin/fragment/SplashFragment;->currentDotCounts:I

    add-int/lit8 v1, v0, 0x1

    iput v1, p0, Lcom/cyjh/elfin/fragment/SplashFragment;->currentDotCounts:I

    return v0
.end method

.method static synthetic access$2200(Lcom/cyjh/elfin/fragment/SplashFragment;)Ljava/util/List;
    .locals 1
    .param p0, "x0"    # Lcom/cyjh/elfin/fragment/SplashFragment;

    .prologue
    .line 79
    iget-object v0, p0, Lcom/cyjh/elfin/fragment/SplashFragment;->imageViewLists:Ljava/util/List;

    return-object v0
.end method

.method static synthetic access$2300(Lcom/cyjh/elfin/fragment/SplashFragment;)Landroid/graphics/drawable/GradientDrawable;
    .locals 1
    .param p0, "x0"    # Lcom/cyjh/elfin/fragment/SplashFragment;

    .prologue
    .line 79
    iget-object v0, p0, Lcom/cyjh/elfin/fragment/SplashFragment;->mBlueGradientDrawable:Landroid/graphics/drawable/GradientDrawable;

    return-object v0
.end method

.method static synthetic access$2400(Lcom/cyjh/elfin/fragment/SplashFragment;)Landroid/graphics/drawable/GradientDrawable;
    .locals 1
    .param p0, "x0"    # Lcom/cyjh/elfin/fragment/SplashFragment;

    .prologue
    .line 79
    iget-object v0, p0, Lcom/cyjh/elfin/fragment/SplashFragment;->mGrayGradientDrawable:Landroid/graphics/drawable/GradientDrawable;

    return-object v0
.end method

.method static synthetic access$2500(Lcom/cyjh/elfin/fragment/SplashFragment;Z)V
    .locals 0
    .param p0, "x0"    # Lcom/cyjh/elfin/fragment/SplashFragment;
    .param p1, "x1"    # Z

    .prologue
    .line 79
    invoke-direct {p0, p1}, Lcom/cyjh/elfin/fragment/SplashFragment;->isHasNetwork(Z)V

    return-void
.end method

.method static synthetic access$2600(Lcom/cyjh/elfin/fragment/SplashFragment;)Lcom/iflytek/voiceads/NativeADDataRef;
    .locals 1
    .param p0, "x0"    # Lcom/cyjh/elfin/fragment/SplashFragment;

    .prologue
    .line 79
    iget-object v0, p0, Lcom/cyjh/elfin/fragment/SplashFragment;->adItem:Lcom/iflytek/voiceads/NativeADDataRef;

    return-object v0
.end method

.method static synthetic access$2602(Lcom/cyjh/elfin/fragment/SplashFragment;Lcom/iflytek/voiceads/NativeADDataRef;)Lcom/iflytek/voiceads/NativeADDataRef;
    .locals 0
    .param p0, "x0"    # Lcom/cyjh/elfin/fragment/SplashFragment;
    .param p1, "x1"    # Lcom/iflytek/voiceads/NativeADDataRef;

    .prologue
    .line 79
    iput-object p1, p0, Lcom/cyjh/elfin/fragment/SplashFragment;->adItem:Lcom/iflytek/voiceads/NativeADDataRef;

    return-object p1
.end method

.method static synthetic access$2700(Lcom/cyjh/elfin/fragment/SplashFragment;)Landroid/widget/TextView;
    .locals 1
    .param p0, "x0"    # Lcom/cyjh/elfin/fragment/SplashFragment;

    .prologue
    .line 79
    iget-object v0, p0, Lcom/cyjh/elfin/fragment/SplashFragment;->mTvAdMark:Landroid/widget/TextView;

    return-object v0
.end method

.method static synthetic access$2802(Lcom/cyjh/elfin/fragment/SplashFragment;Ljava/lang/String;)Ljava/lang/String;
    .locals 0
    .param p0, "x0"    # Lcom/cyjh/elfin/fragment/SplashFragment;
    .param p1, "x1"    # Ljava/lang/String;

    .prologue
    .line 79
    iput-object p1, p0, Lcom/cyjh/elfin/fragment/SplashFragment;->adILFYType:Ljava/lang/String;

    return-object p1
.end method

.method static synthetic access$2900(Lcom/cyjh/elfin/fragment/SplashFragment;)Lcom/cyjh/elfin/fragment/SplashFragment$RunnableTask;
    .locals 1
    .param p0, "x0"    # Lcom/cyjh/elfin/fragment/SplashFragment;

    .prologue
    .line 79
    iget-object v0, p0, Lcom/cyjh/elfin/fragment/SplashFragment;->mRunnableTask:Lcom/cyjh/elfin/fragment/SplashFragment$RunnableTask;

    return-object v0
.end method

.method static synthetic access$2902(Lcom/cyjh/elfin/fragment/SplashFragment;Lcom/cyjh/elfin/fragment/SplashFragment$RunnableTask;)Lcom/cyjh/elfin/fragment/SplashFragment$RunnableTask;
    .locals 0
    .param p0, "x0"    # Lcom/cyjh/elfin/fragment/SplashFragment;
    .param p1, "x1"    # Lcom/cyjh/elfin/fragment/SplashFragment$RunnableTask;

    .prologue
    .line 79
    iput-object p1, p0, Lcom/cyjh/elfin/fragment/SplashFragment;->mRunnableTask:Lcom/cyjh/elfin/fragment/SplashFragment$RunnableTask;

    return-object p1
.end method

.method static synthetic access$300(Lcom/cyjh/elfin/fragment/SplashFragment;)Lcom/iflytek/voiceads/IFLYNativeAd;
    .locals 1
    .param p0, "x0"    # Lcom/cyjh/elfin/fragment/SplashFragment;

    .prologue
    .line 79
    iget-object v0, p0, Lcom/cyjh/elfin/fragment/SplashFragment;->nativeAd:Lcom/iflytek/voiceads/IFLYNativeAd;

    return-object v0
.end method

.method static synthetic access$3000(Lcom/cyjh/elfin/fragment/SplashFragment;)I
    .locals 1
    .param p0, "x0"    # Lcom/cyjh/elfin/fragment/SplashFragment;

    .prologue
    .line 79
    iget v0, p0, Lcom/cyjh/elfin/fragment/SplashFragment;->countTimeAdd:I

    return v0
.end method

.method static synthetic access$3008(Lcom/cyjh/elfin/fragment/SplashFragment;)I
    .locals 2
    .param p0, "x0"    # Lcom/cyjh/elfin/fragment/SplashFragment;

    .prologue
    .line 79
    iget v0, p0, Lcom/cyjh/elfin/fragment/SplashFragment;->countTimeAdd:I

    add-int/lit8 v1, v0, 0x1

    iput v1, p0, Lcom/cyjh/elfin/fragment/SplashFragment;->countTimeAdd:I

    return v0
.end method

.method static synthetic access$3100(Lcom/cyjh/elfin/fragment/SplashFragment;)Z
    .locals 1
    .param p0, "x0"    # Lcom/cyjh/elfin/fragment/SplashFragment;

    .prologue
    .line 79
    iget-boolean v0, p0, Lcom/cyjh/elfin/fragment/SplashFragment;->adImgClicker:Z

    return v0
.end method

.method static synthetic access$400(Lcom/cyjh/elfin/fragment/SplashFragment;)Lcom/cyjh/elfin/fragment/SplashFragment$CountTimeRunnable;
    .locals 1
    .param p0, "x0"    # Lcom/cyjh/elfin/fragment/SplashFragment;

    .prologue
    .line 79
    iget-object v0, p0, Lcom/cyjh/elfin/fragment/SplashFragment;->mCountRunnable:Lcom/cyjh/elfin/fragment/SplashFragment$CountTimeRunnable;

    return-object v0
.end method

.method static synthetic access$402(Lcom/cyjh/elfin/fragment/SplashFragment;Lcom/cyjh/elfin/fragment/SplashFragment$CountTimeRunnable;)Lcom/cyjh/elfin/fragment/SplashFragment$CountTimeRunnable;
    .locals 0
    .param p0, "x0"    # Lcom/cyjh/elfin/fragment/SplashFragment;
    .param p1, "x1"    # Lcom/cyjh/elfin/fragment/SplashFragment$CountTimeRunnable;

    .prologue
    .line 79
    iput-object p1, p0, Lcom/cyjh/elfin/fragment/SplashFragment;->mCountRunnable:Lcom/cyjh/elfin/fragment/SplashFragment$CountTimeRunnable;

    return-object p1
.end method

.method static synthetic access$500(Lcom/cyjh/elfin/fragment/SplashFragment;)Z
    .locals 1
    .param p0, "x0"    # Lcom/cyjh/elfin/fragment/SplashFragment;

    .prologue
    .line 79
    iget-boolean v0, p0, Lcom/cyjh/elfin/fragment/SplashFragment;->XunFeiFlag:Z

    return v0
.end method

.method static synthetic access$502(Lcom/cyjh/elfin/fragment/SplashFragment;Z)Z
    .locals 0
    .param p0, "x0"    # Lcom/cyjh/elfin/fragment/SplashFragment;
    .param p1, "x1"    # Z

    .prologue
    .line 79
    iput-boolean p1, p0, Lcom/cyjh/elfin/fragment/SplashFragment;->XunFeiFlag:Z

    return p1
.end method

.method static synthetic access$600(Lcom/cyjh/elfin/fragment/SplashFragment;)Z
    .locals 1
    .param p0, "x0"    # Lcom/cyjh/elfin/fragment/SplashFragment;

    .prologue
    .line 79
    iget-boolean v0, p0, Lcom/cyjh/elfin/fragment/SplashFragment;->isOpenScreenLoad:Z

    return v0
.end method

.method static synthetic access$700(Lcom/cyjh/elfin/fragment/SplashFragment;)Lcom/cyjh/elfin/entity/Ad$DataBean;
    .locals 1
    .param p0, "x0"    # Lcom/cyjh/elfin/fragment/SplashFragment;

    .prologue
    .line 79
    iget-object v0, p0, Lcom/cyjh/elfin/fragment/SplashFragment;->adDataBean:Lcom/cyjh/elfin/entity/Ad$DataBean;

    return-object v0
.end method

.method static synthetic access$800(Lcom/cyjh/elfin/fragment/SplashFragment;)Landroid/os/Handler;
    .locals 1
    .param p0, "x0"    # Lcom/cyjh/elfin/fragment/SplashFragment;

    .prologue
    .line 79
    iget-object v0, p0, Lcom/cyjh/elfin/fragment/SplashFragment;->mHandler:Landroid/os/Handler;

    return-object v0
.end method

.method static synthetic access$900(Lcom/cyjh/elfin/fragment/SplashFragment;)Landroid/widget/ImageView;
    .locals 1
    .param p0, "x0"    # Lcom/cyjh/elfin/fragment/SplashFragment;

    .prologue
    .line 79
    iget-object v0, p0, Lcom/cyjh/elfin/fragment/SplashFragment;->mImgAdFullScreen:Landroid/widget/ImageView;

    return-object v0
.end method

.method private cancelCloseTimer()V
    .locals 1

    .prologue
    .line 470
    iget-object v0, p0, Lcom/cyjh/elfin/fragment/SplashFragment;->mCloseAdTimer:Lcom/cyjh/elfin/fragment/SplashFragment$CloseAdTimer;

    if-eqz v0, :cond_0

    .line 471
    iget-object v0, p0, Lcom/cyjh/elfin/fragment/SplashFragment;->mCloseAdTimer:Lcom/cyjh/elfin/fragment/SplashFragment$CloseAdTimer;

    invoke-virtual {v0}, Lcom/cyjh/elfin/fragment/SplashFragment$CloseAdTimer;->cancel()V

    .line 472
    const/4 v0, 0x0

    iput-object v0, p0, Lcom/cyjh/elfin/fragment/SplashFragment;->mCloseAdTimer:Lcom/cyjh/elfin/fragment/SplashFragment$CloseAdTimer;

    .line 474
    :cond_0
    return-void
.end method

.method private clickXunFeiAd(Landroid/view/View;)V
    .locals 2
    .param p1, "view"    # Landroid/view/View;

    .prologue
    .line 919
    const-string v0, "zzz"

    const-string v1, "Splash clickXunFeiAd---1"

    invoke-static {v0, v1}, Landroid/util/Log;->e(Ljava/lang/String;Ljava/lang/String;)I

    .line 921
    const/4 v0, 0x1

    iput-boolean v0, p0, Lcom/cyjh/elfin/fragment/SplashFragment;->isClickerFirst:Z

    .line 922
    iget-object v0, p0, Lcom/cyjh/elfin/fragment/SplashFragment;->adItem:Lcom/iflytek/voiceads/NativeADDataRef;

    invoke-virtual {v0, p1}, Lcom/iflytek/voiceads/NativeADDataRef;->onClicked(Landroid/view/View;)Z

    move-result v0

    iput-boolean v0, p0, Lcom/cyjh/elfin/fragment/SplashFragment;->adImgClicker:Z

    .line 924
    const-string v0, "redirect"

    iget-object v1, p0, Lcom/cyjh/elfin/fragment/SplashFragment;->adILFYType:Ljava/lang/String;

    invoke-virtual {v0, v1}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v0

    if-nez v0, :cond_1

    .line 925
    const/16 v0, 0x9

    iput v0, p0, Lcom/cyjh/elfin/fragment/SplashFragment;->countTimeAdd:I

    .line 926
    iget-object v0, p0, Lcom/cyjh/elfin/fragment/SplashFragment;->mCountRunnable:Lcom/cyjh/elfin/fragment/SplashFragment$CountTimeRunnable;

    if-nez v0, :cond_0

    .line 927
    new-instance v0, Lcom/cyjh/elfin/fragment/SplashFragment$CountTimeRunnable;

    invoke-direct {v0, p0}, Lcom/cyjh/elfin/fragment/SplashFragment$CountTimeRunnable;-><init>(Lcom/cyjh/elfin/fragment/SplashFragment;)V

    iput-object v0, p0, Lcom/cyjh/elfin/fragment/SplashFragment;->mCountRunnable:Lcom/cyjh/elfin/fragment/SplashFragment$CountTimeRunnable;

    .line 929
    :cond_0
    const-string v0, "zzz"

    const-string v1, "Splash clickXunFeiAd---1-\u5f00\u542f\u5b9a\u65f6\u5668"

    invoke-static {v0, v1}, Landroid/util/Log;->e(Ljava/lang/String;Ljava/lang/String;)I

    .line 930
    iget-object v0, p0, Lcom/cyjh/elfin/fragment/SplashFragment;->mCountRunnable:Lcom/cyjh/elfin/fragment/SplashFragment$CountTimeRunnable;

    invoke-virtual {v0}, Lcom/cyjh/elfin/fragment/SplashFragment$CountTimeRunnable;->onStart()V

    .line 932
    :cond_1
    return-void
.end method

.method private displayEightSecond()V
    .locals 2

    .prologue
    .line 859
    invoke-direct {p0}, Lcom/cyjh/elfin/fragment/SplashFragment;->cancelCloseTimer()V

    .line 860
    iget-object v0, p0, Lcom/cyjh/elfin/fragment/SplashFragment;->mCloseAdTimer:Lcom/cyjh/elfin/fragment/SplashFragment$CloseAdTimer;

    if-nez v0, :cond_0

    .line 861
    new-instance v0, Lcom/cyjh/elfin/fragment/SplashFragment$CloseAdTimer;

    const/16 v1, 0x8

    invoke-direct {v0, p0, v1}, Lcom/cyjh/elfin/fragment/SplashFragment$CloseAdTimer;-><init>(Lcom/cyjh/elfin/fragment/SplashFragment;I)V

    iput-object v0, p0, Lcom/cyjh/elfin/fragment/SplashFragment;->mCloseAdTimer:Lcom/cyjh/elfin/fragment/SplashFragment$CloseAdTimer;

    .line 863
    :cond_0
    iget-object v0, p0, Lcom/cyjh/elfin/fragment/SplashFragment;->mCloseAdTimer:Lcom/cyjh/elfin/fragment/SplashFragment$CloseAdTimer;

    invoke-virtual {v0}, Lcom/cyjh/elfin/fragment/SplashFragment$CloseAdTimer;->start()Landroid/os/CountDownTimer;

    .line 864
    return-void
.end method

.method private getDialogMessageByServer(ILjava/lang/String;)V
    .locals 8
    .param p1, "resultCode"    # I
    .param p2, "remark"    # Ljava/lang/String;

    .prologue
    .line 370
    invoke-static {}, Lcom/cyjh/elfin/dialog/DialogManager;->getInstance()Lcom/cyjh/elfin/dialog/DialogManager;

    move-result-object v4

    invoke-virtual {p0}, Lcom/cyjh/elfin/fragment/SplashFragment;->getActivity()Landroid/support/v4/app/FragmentActivity;

    move-result-object v5

    const v6, 0x7f04003e

    const v7, 0x7f0a00f8

    invoke-virtual {v4, v5, v6, v7}, Lcom/cyjh/elfin/dialog/DialogManager;->showMessageDialog(Landroid/content/Context;II)Landroid/app/AlertDialog;

    move-result-object v0

    .line 372
    .local v0, "mAlertDialog":Landroid/app/AlertDialog;
    const/4 v4, 0x0

    invoke-virtual {v0, v4}, Landroid/app/AlertDialog;->setCancelable(Z)V

    .line 373
    invoke-virtual {v0}, Landroid/app/AlertDialog;->show()V

    .line 374
    const v4, 0x7f0f00be

    invoke-virtual {v0, v4}, Landroid/app/AlertDialog;->findViewById(I)Landroid/view/View;

    move-result-object v2

    check-cast v2, Landroid/widget/TextView;

    .line 375
    .local v2, "mTvMessage":Landroid/widget/TextView;
    const-string v4, "\r\n"

    const-string v5, ""

    invoke-virtual {p2, v4, v5}, Ljava/lang/String;->replace(Ljava/lang/CharSequence;Ljava/lang/CharSequence;)Ljava/lang/String;

    move-result-object v3

    .line 376
    .local v3, "text":Ljava/lang/String;
    const/4 v4, 0x1

    if-ne p1, v4, :cond_0

    invoke-static {v3}, Landroid/text/TextUtils;->isEmpty(Ljava/lang/CharSequence;)Z

    move-result v4

    if-eqz v4, :cond_0

    .line 377
    const v4, 0x7f080132

    invoke-virtual {p0, v4}, Lcom/cyjh/elfin/fragment/SplashFragment;->getString(I)Ljava/lang/String;

    move-result-object v4

    invoke-virtual {v2, v4}, Landroid/widget/TextView;->setText(Ljava/lang/CharSequence;)V

    .line 381
    :goto_0
    const v4, 0x7f0f00cc

    invoke-virtual {v0, v4}, Landroid/app/AlertDialog;->findViewById(I)Landroid/view/View;

    move-result-object v1

    check-cast v1, Landroid/widget/TextView;

    .line 382
    .local v1, "mTvIKnown":Landroid/widget/TextView;
    new-instance v4, Lcom/cyjh/elfin/fragment/SplashFragment$VersionKnownListener;

    invoke-direct {v4, p0, v0, p1}, Lcom/cyjh/elfin/fragment/SplashFragment$VersionKnownListener;-><init>(Lcom/cyjh/elfin/fragment/SplashFragment;Landroid/app/AlertDialog;I)V

    invoke-virtual {v1, v4}, Landroid/widget/TextView;->setOnClickListener(Landroid/view/View$OnClickListener;)V

    .line 383
    return-void

    .line 379
    .end local v1    # "mTvIKnown":Landroid/widget/TextView;
    :cond_0
    invoke-virtual {v2, v3}, Landroid/widget/TextView;->setText(Ljava/lang/CharSequence;)V

    goto :goto_0
.end method

.method private initDot()V
    .locals 9

    .prologue
    const/4 v8, -0x2

    const/4 v7, 0x0

    const/high16 v6, 0x41000000    # 8.0f

    .line 425
    iget-object v4, p0, Lcom/cyjh/elfin/fragment/SplashFragment;->mLinearCircleDot:Landroid/widget/LinearLayout;

    invoke-virtual {v4}, Landroid/widget/LinearLayout;->removeAllViews()V

    .line 426
    iget-object v4, p0, Lcom/cyjh/elfin/fragment/SplashFragment;->imageViewLists:Ljava/util/List;

    invoke-interface {v4}, Ljava/util/List;->clear()V

    .line 427
    const/4 v1, 0x0

    .local v1, "i":I
    :goto_0
    const/4 v4, 0x6

    if-ge v1, v4, :cond_2

    .line 428
    new-instance v2, Landroid/widget/ImageView;

    invoke-virtual {p0}, Lcom/cyjh/elfin/fragment/SplashFragment;->getActivity()Landroid/support/v4/app/FragmentActivity;

    move-result-object v4

    invoke-direct {v2, v4}, Landroid/widget/ImageView;-><init>(Landroid/content/Context;)V

    .line 429
    .local v2, "imageView":Landroid/widget/ImageView;
    new-instance v0, Landroid/graphics/drawable/GradientDrawable;

    invoke-direct {v0}, Landroid/graphics/drawable/GradientDrawable;-><init>()V

    .line 430
    .local v0, "dotDrawable":Landroid/graphics/drawable/GradientDrawable;
    const/4 v4, 0x1

    invoke-virtual {v0, v4}, Landroid/graphics/drawable/GradientDrawable;->setShape(I)V

    .line 431
    invoke-virtual {p0}, Lcom/cyjh/elfin/fragment/SplashFragment;->getActivity()Landroid/support/v4/app/FragmentActivity;

    move-result-object v4

    invoke-static {v4, v6}, Lcom/cyjh/elfin/util/AppDeviceUtils;->getDipToPx(Landroid/content/Context;F)I

    move-result v4

    int-to-float v4, v4

    invoke-virtual {v0, v4}, Landroid/graphics/drawable/GradientDrawable;->setCornerRadius(F)V

    .line 432
    invoke-virtual {p0}, Lcom/cyjh/elfin/fragment/SplashFragment;->getActivity()Landroid/support/v4/app/FragmentActivity;

    move-result-object v4

    invoke-static {v4, v6}, Lcom/cyjh/elfin/util/AppDeviceUtils;->getDipToPx(Landroid/content/Context;F)I

    move-result v4

    invoke-virtual {p0}, Lcom/cyjh/elfin/fragment/SplashFragment;->getActivity()Landroid/support/v4/app/FragmentActivity;

    move-result-object v5

    invoke-static {v5, v6}, Lcom/cyjh/elfin/util/AppDeviceUtils;->getDipToPx(Landroid/content/Context;F)I

    move-result v5

    invoke-virtual {v0, v4, v5}, Landroid/graphics/drawable/GradientDrawable;->setSize(II)V

    .line 433
    if-nez v1, :cond_1

    .line 434
    const-string v4, "#3c7ac5"

    invoke-static {v4}, Landroid/graphics/Color;->parseColor(Ljava/lang/String;)I

    move-result v4

    invoke-virtual {v0, v4}, Landroid/graphics/drawable/GradientDrawable;->setColor(I)V

    .line 435
    iput-object v0, p0, Lcom/cyjh/elfin/fragment/SplashFragment;->mBlueGradientDrawable:Landroid/graphics/drawable/GradientDrawable;

    .line 442
    :cond_0
    :goto_1
    invoke-virtual {v2, v0}, Landroid/widget/ImageView;->setImageDrawable(Landroid/graphics/drawable/Drawable;)V

    .line 443
    new-instance v3, Landroid/widget/LinearLayout$LayoutParams;

    invoke-direct {v3, v8, v8}, Landroid/widget/LinearLayout$LayoutParams;-><init>(II)V

    .line 445
    .local v3, "mParams":Landroid/widget/LinearLayout$LayoutParams;
    invoke-virtual {p0}, Lcom/cyjh/elfin/fragment/SplashFragment;->getActivity()Landroid/support/v4/app/FragmentActivity;

    move-result-object v4

    invoke-static {v4, v6}, Lcom/cyjh/elfin/util/AppDeviceUtils;->getDipToPx(Landroid/content/Context;F)I

    move-result v4

    invoke-virtual {v3, v7, v7, v4, v7}, Landroid/widget/LinearLayout$LayoutParams;->setMargins(IIII)V

    .line 446
    iget-object v4, p0, Lcom/cyjh/elfin/fragment/SplashFragment;->mLinearCircleDot:Landroid/widget/LinearLayout;

    invoke-virtual {v4, v2, v3}, Landroid/widget/LinearLayout;->addView(Landroid/view/View;Landroid/view/ViewGroup$LayoutParams;)V

    .line 447
    iget-object v4, p0, Lcom/cyjh/elfin/fragment/SplashFragment;->imageViewLists:Ljava/util/List;

    invoke-interface {v4, v2}, Ljava/util/List;->add(Ljava/lang/Object;)Z

    .line 427
    add-int/lit8 v1, v1, 0x1

    goto :goto_0

    .line 437
    .end local v3    # "mParams":Landroid/widget/LinearLayout$LayoutParams;
    :cond_1
    const-string v4, "#bababa"

    invoke-static {v4}, Landroid/graphics/Color;->parseColor(Ljava/lang/String;)I

    move-result v4

    invoke-virtual {v0, v4}, Landroid/graphics/drawable/GradientDrawable;->setColor(I)V

    .line 438
    const/4 v4, 0x5

    if-ne v1, v4, :cond_0

    .line 439
    iput-object v0, p0, Lcom/cyjh/elfin/fragment/SplashFragment;->mGrayGradientDrawable:Landroid/graphics/drawable/GradientDrawable;

    goto :goto_1

    .line 449
    .end local v0    # "dotDrawable":Landroid/graphics/drawable/GradientDrawable;
    .end local v2    # "imageView":Landroid/widget/ImageView;
    :cond_2
    return-void
.end method

.method private initGetServerTime()V
    .locals 2

    .prologue
    .line 287
    new-instance v0, Lcom/cyjh/elfin/mvp/managers/GetServerTimeManager;

    invoke-direct {v0}, Lcom/cyjh/elfin/mvp/managers/GetServerTimeManager;-><init>()V

    .line 288
    .local v0, "serverTimeManager":Lcom/cyjh/elfin/mvp/managers/GetServerTimeManager;
    invoke-virtual {p0}, Lcom/cyjh/elfin/fragment/SplashFragment;->getActivity()Landroid/support/v4/app/FragmentActivity;

    move-result-object v1

    invoke-virtual {v0, v1}, Lcom/cyjh/elfin/mvp/managers/GetServerTimeManager;->getServerTime(Landroid/content/Context;)V

    .line 289
    return-void
.end method

.method private initView(Landroid/view/View;)V
    .locals 4
    .param p1, "view"    # Landroid/view/View;

    .prologue
    .line 392
    const v0, 0x7f0f0111

    invoke-virtual {p1, v0}, Landroid/view/View;->findViewById(I)Landroid/view/View;

    move-result-object v0

    check-cast v0, Landroid/widget/ImageView;

    iput-object v0, p0, Lcom/cyjh/elfin/fragment/SplashFragment;->mImgAdFullScreen:Landroid/widget/ImageView;

    .line 393
    const v0, 0x7f0f0112

    invoke-virtual {p1, v0}, Landroid/view/View;->findViewById(I)Landroid/view/View;

    move-result-object v0

    check-cast v0, Landroid/widget/TextView;

    iput-object v0, p0, Lcom/cyjh/elfin/fragment/SplashFragment;->mTvAdMark:Landroid/widget/TextView;

    .line 394
    const v0, 0x7f0f0117

    invoke-virtual {p1, v0}, Landroid/view/View;->findViewById(I)Landroid/view/View;

    move-result-object v0

    check-cast v0, Landroid/widget/ImageView;

    iput-object v0, p0, Lcom/cyjh/elfin/fragment/SplashFragment;->mImgBgLogo:Landroid/widget/ImageView;

    .line 395
    const v0, 0x7f0f0118

    invoke-virtual {p1, v0}, Landroid/view/View;->findViewById(I)Landroid/view/View;

    move-result-object v0

    check-cast v0, Landroid/widget/RelativeLayout;

    iput-object v0, p0, Lcom/cyjh/elfin/fragment/SplashFragment;->mRlBottomLayout:Landroid/widget/RelativeLayout;

    .line 396
    const v0, 0x7f0f011a

    invoke-virtual {p1, v0}, Landroid/view/View;->findViewById(I)Landroid/view/View;

    move-result-object v0

    check-cast v0, Landroid/widget/LinearLayout;

    iput-object v0, p0, Lcom/cyjh/elfin/fragment/SplashFragment;->mLinearCircleDot:Landroid/widget/LinearLayout;

    .line 397
    const v0, 0x7f0f0113

    invoke-virtual {p1, v0}, Landroid/view/View;->findViewById(I)Landroid/view/View;

    move-result-object v0

    check-cast v0, Landroid/widget/TextView;

    iput-object v0, p0, Lcom/cyjh/elfin/fragment/SplashFragment;->mTvCloseAd:Landroid/widget/TextView;

    .line 398
    new-instance v0, Lcom/iflytek/voiceads/IFLYNativeAd;

    invoke-virtual {p0}, Lcom/cyjh/elfin/fragment/SplashFragment;->getActivity()Landroid/support/v4/app/FragmentActivity;

    move-result-object v1

    const-string v2, "21462E427898ADCCC2171718D603B0DE"

    iget-object v3, p0, Lcom/cyjh/elfin/fragment/SplashFragment;->mNativeListener:Lcom/iflytek/voiceads/IFLYNativeListener;

    invoke-direct {v0, v1, v2, v3}, Lcom/iflytek/voiceads/IFLYNativeAd;-><init>(Landroid/content/Context;Ljava/lang/String;Lcom/iflytek/voiceads/IFLYNativeListener;)V

    iput-object v0, p0, Lcom/cyjh/elfin/fragment/SplashFragment;->nativeAd:Lcom/iflytek/voiceads/IFLYNativeAd;

    .line 399
    iget-object v0, p0, Lcom/cyjh/elfin/fragment/SplashFragment;->mTvCloseAd:Landroid/widget/TextView;

    new-instance v1, Lcom/cyjh/elfin/fragment/SplashFragment$2;

    invoke-direct {v1, p0}, Lcom/cyjh/elfin/fragment/SplashFragment$2;-><init>(Lcom/cyjh/elfin/fragment/SplashFragment;)V

    invoke-virtual {v0, v1}, Landroid/widget/TextView;->setOnClickListener(Landroid/view/View$OnClickListener;)V

    .line 413
    invoke-direct {p0}, Lcom/cyjh/elfin/fragment/SplashFragment;->initDot()V

    .line 414
    iget-object v0, p0, Lcom/cyjh/elfin/fragment/SplashFragment;->mRunnableTask:Lcom/cyjh/elfin/fragment/SplashFragment$RunnableTask;

    if-nez v0, :cond_0

    .line 415
    new-instance v0, Lcom/cyjh/elfin/fragment/SplashFragment$RunnableTask;

    const/4 v1, 0x0

    invoke-direct {v0, p0, v1}, Lcom/cyjh/elfin/fragment/SplashFragment$RunnableTask;-><init>(Lcom/cyjh/elfin/fragment/SplashFragment;Lcom/cyjh/elfin/fragment/SplashFragment$1;)V

    iput-object v0, p0, Lcom/cyjh/elfin/fragment/SplashFragment;->mRunnableTask:Lcom/cyjh/elfin/fragment/SplashFragment$RunnableTask;

    .line 416
    iget-object v0, p0, Lcom/cyjh/elfin/fragment/SplashFragment;->mRunnableTask:Lcom/cyjh/elfin/fragment/SplashFragment$RunnableTask;

    invoke-virtual {v0}, Lcom/cyjh/elfin/fragment/SplashFragment$RunnableTask;->start()V

    .line 418
    :cond_0
    return-void
.end method

.method private isHasNetwork(Z)V
    .locals 4
    .param p1, "netFlag"    # Z

    .prologue
    const/16 v2, 0xe

    const/4 v3, 0x3

    .line 259
    if-nez p1, :cond_1

    .line 268
    const-string v0, "zzz"

    const-string v1, "SplashFragment--isHasNetwork--\u6ca1\u6709\u7f51\u7edc"

    invoke-static {v0, v1}, Landroid/util/Log;->e(Ljava/lang/String;Ljava/lang/String;)I

    .line 269
    iget-object v0, p0, Lcom/cyjh/elfin/fragment/SplashFragment;->mHandler:Landroid/os/Handler;

    invoke-virtual {v0, v2}, Landroid/os/Handler;->obtainMessage(I)Landroid/os/Message;

    move-result-object v0

    invoke-virtual {v0}, Landroid/os/Message;->sendToTarget()V

    .line 270
    iget-object v0, p0, Lcom/cyjh/elfin/fragment/SplashFragment;->blackListPresenter:Lcom/cyjh/elfin/mvp/presenters/BlackListPresenter;

    invoke-virtual {p0}, Lcom/cyjh/elfin/fragment/SplashFragment;->getActivity()Landroid/support/v4/app/FragmentActivity;

    move-result-object v1

    invoke-virtual {v0, v1}, Lcom/cyjh/elfin/mvp/presenters/BlackListPresenter;->isSetBlackList(Landroid/content/Context;)V

    .line 271
    iget-object v0, p0, Lcom/cyjh/elfin/fragment/SplashFragment;->adImagePresenter:Lcom/cyjh/elfin/mvp/presenters/AdImagePresenter;

    invoke-virtual {p0}, Lcom/cyjh/elfin/fragment/SplashFragment;->getActivity()Landroid/support/v4/app/FragmentActivity;

    move-result-object v1

    const-class v2, Lcom/cyjh/elfin/fragment/AdFragment;

    invoke-virtual {v2}, Ljava/lang/Class;->getCanonicalName()Ljava/lang/String;

    move-result-object v2

    invoke-virtual {v0, v1, v3, v2}, Lcom/cyjh/elfin/mvp/presenters/AdImagePresenter;->adShow(Landroid/content/Context;ILjava/lang/String;)V

    .line 272
    iget-object v0, p0, Lcom/cyjh/elfin/fragment/SplashFragment;->mCloseAdTimer:Lcom/cyjh/elfin/fragment/SplashFragment$CloseAdTimer;

    if-nez v0, :cond_0

    .line 273
    new-instance v0, Lcom/cyjh/elfin/fragment/SplashFragment$CloseAdTimer;

    const/16 v1, 0x14

    invoke-direct {v0, p0, v1}, Lcom/cyjh/elfin/fragment/SplashFragment$CloseAdTimer;-><init>(Lcom/cyjh/elfin/fragment/SplashFragment;I)V

    iput-object v0, p0, Lcom/cyjh/elfin/fragment/SplashFragment;->mCloseAdTimer:Lcom/cyjh/elfin/fragment/SplashFragment$CloseAdTimer;

    .line 275
    :cond_0
    iget-object v0, p0, Lcom/cyjh/elfin/fragment/SplashFragment;->mCloseAdTimer:Lcom/cyjh/elfin/fragment/SplashFragment$CloseAdTimer;

    invoke-virtual {v0}, Lcom/cyjh/elfin/fragment/SplashFragment$CloseAdTimer;->start()Landroid/os/CountDownTimer;

    .line 284
    :goto_0
    return-void

    .line 280
    :cond_1
    iget-object v0, p0, Lcom/cyjh/elfin/fragment/SplashFragment;->mHandler:Landroid/os/Handler;

    invoke-virtual {v0, v2}, Landroid/os/Handler;->obtainMessage(I)Landroid/os/Message;

    move-result-object v0

    invoke-virtual {v0}, Landroid/os/Message;->sendToTarget()V

    .line 281
    iget-object v0, p0, Lcom/cyjh/elfin/fragment/SplashFragment;->blackListPresenter:Lcom/cyjh/elfin/mvp/presenters/BlackListPresenter;

    invoke-virtual {p0}, Lcom/cyjh/elfin/fragment/SplashFragment;->getActivity()Landroid/support/v4/app/FragmentActivity;

    move-result-object v1

    invoke-virtual {v0, v1}, Lcom/cyjh/elfin/mvp/presenters/BlackListPresenter;->isSetBlackList(Landroid/content/Context;)V

    .line 282
    iget-object v0, p0, Lcom/cyjh/elfin/fragment/SplashFragment;->adImagePresenter:Lcom/cyjh/elfin/mvp/presenters/AdImagePresenter;

    invoke-virtual {p0}, Lcom/cyjh/elfin/fragment/SplashFragment;->getActivity()Landroid/support/v4/app/FragmentActivity;

    move-result-object v1

    const-class v2, Lcom/cyjh/elfin/fragment/AdFragment;

    invoke-virtual {v2}, Ljava/lang/Class;->getCanonicalName()Ljava/lang/String;

    move-result-object v2

    invoke-virtual {v0, v1, v3, v2}, Lcom/cyjh/elfin/mvp/presenters/AdImagePresenter;->adShow(Landroid/content/Context;ILjava/lang/String;)V

    goto :goto_0
.end method

.method public static newInstance()Lcom/cyjh/elfin/fragment/SplashFragment;
    .locals 1

    .prologue
    .line 233
    new-instance v0, Lcom/cyjh/elfin/fragment/SplashFragment;

    invoke-direct {v0}, Lcom/cyjh/elfin/fragment/SplashFragment;-><init>()V

    return-object v0
.end method

.method private onClickImgBackGroundAd()V
    .locals 7

    .prologue
    .line 897
    const/4 v3, 0x1

    iput-boolean v3, p0, Lcom/cyjh/elfin/fragment/SplashFragment;->isClickerFirst:Z

    .line 898
    iget-object v3, p0, Lcom/cyjh/elfin/fragment/SplashFragment;->adDataBean:Lcom/cyjh/elfin/entity/Ad$DataBean;

    iget-object v3, v3, Lcom/cyjh/elfin/entity/Ad$DataBean;->LinkType:Ljava/lang/String;

    const-string v4, "1"

    invoke-static {v3, v4}, Landroid/text/TextUtils;->equals(Ljava/lang/CharSequence;Ljava/lang/CharSequence;)Z

    move-result v3

    if-eqz v3, :cond_1

    .line 899
    iget-object v3, p0, Lcom/cyjh/elfin/fragment/SplashFragment;->adDataBean:Lcom/cyjh/elfin/entity/Ad$DataBean;

    iget-object v3, v3, Lcom/cyjh/elfin/entity/Ad$DataBean;->Link:Ljava/lang/String;

    invoke-static {v3}, Landroid/text/TextUtils;->isEmpty(Ljava/lang/CharSequence;)Z

    move-result v3

    if-nez v3, :cond_0

    iget-object v3, p0, Lcom/cyjh/elfin/fragment/SplashFragment;->adDataBean:Lcom/cyjh/elfin/entity/Ad$DataBean;

    iget-object v3, v3, Lcom/cyjh/elfin/entity/Ad$DataBean;->Link:Ljava/lang/String;

    const-string v4, "http"

    invoke-virtual {v3, v4}, Ljava/lang/String;->startsWith(Ljava/lang/String;)Z

    move-result v3

    if-eqz v3, :cond_0

    .line 900
    iget-object v3, p0, Lcom/cyjh/elfin/fragment/SplashFragment;->adDataBean:Lcom/cyjh/elfin/entity/Ad$DataBean;

    iget-object v3, v3, Lcom/cyjh/elfin/entity/Ad$DataBean;->Link:Ljava/lang/String;

    invoke-static {v3}, Landroid/net/Uri;->parse(Ljava/lang/String;)Landroid/net/Uri;

    move-result-object v2

    .line 901
    .local v2, "uri":Landroid/net/Uri;
    new-instance v1, Landroid/content/Intent;

    const-string v3, "android.intent.action.VIEW"

    invoke-direct {v1, v3, v2}, Landroid/content/Intent;-><init>(Ljava/lang/String;Landroid/net/Uri;)V

    .line 902
    .local v1, "intent":Landroid/content/Intent;
    const/high16 v3, 0x10000000

    invoke-virtual {v1, v3}, Landroid/content/Intent;->addFlags(I)Landroid/content/Intent;

    .line 903
    invoke-virtual {p0}, Lcom/cyjh/elfin/fragment/SplashFragment;->getActivity()Landroid/support/v4/app/FragmentActivity;

    move-result-object v3

    invoke-virtual {v3, v1}, Landroid/support/v4/app/FragmentActivity;->startActivity(Landroid/content/Intent;)V

    .line 915
    .end local v1    # "intent":Landroid/content/Intent;
    .end local v2    # "uri":Landroid/net/Uri;
    :cond_0
    :goto_0
    iget-object v3, p0, Lcom/cyjh/elfin/fragment/SplashFragment;->backgroundAdStatistics:Lcom/cyjh/elfin/mvp/managers/BackgroundSettingsAdStatistics;

    invoke-virtual {p0}, Lcom/cyjh/elfin/fragment/SplashFragment;->getActivity()Landroid/support/v4/app/FragmentActivity;

    move-result-object v4

    iget-object v5, p0, Lcom/cyjh/elfin/fragment/SplashFragment;->adDataBean:Lcom/cyjh/elfin/entity/Ad$DataBean;

    iget-object v5, v5, Lcom/cyjh/elfin/entity/Ad$DataBean;->Id:Ljava/lang/String;

    const-string v6, "1"

    invoke-virtual {v3, v4, v5, v6}, Lcom/cyjh/elfin/mvp/managers/BackgroundSettingsAdStatistics;->backgroundStatisticsAdCount(Landroid/content/Context;Ljava/lang/String;Ljava/lang/String;)V

    .line 916
    return-void

    .line 905
    :cond_1
    iget-object v3, p0, Lcom/cyjh/elfin/fragment/SplashFragment;->adDataBean:Lcom/cyjh/elfin/entity/Ad$DataBean;

    iget-object v3, v3, Lcom/cyjh/elfin/entity/Ad$DataBean;->LinkType:Ljava/lang/String;

    const-string v4, "2"

    invoke-static {v3, v4}, Landroid/text/TextUtils;->equals(Ljava/lang/CharSequence;Ljava/lang/CharSequence;)Z

    move-result v3

    if-eqz v3, :cond_0

    .line 906
    iget-object v3, p0, Lcom/cyjh/elfin/fragment/SplashFragment;->adDataBean:Lcom/cyjh/elfin/entity/Ad$DataBean;

    iget-object v3, v3, Lcom/cyjh/elfin/entity/Ad$DataBean;->AdvertisementTitle:Ljava/lang/String;

    const v4, 0x7f0800fd

    invoke-virtual {p0, v4}, Lcom/cyjh/elfin/fragment/SplashFragment;->getString(I)Ljava/lang/String;

    move-result-object v4

    invoke-virtual {v3, v4}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v3

    if-eqz v3, :cond_2

    .line 907
    invoke-virtual {p0}, Lcom/cyjh/elfin/fragment/SplashFragment;->getContext()Landroid/content/Context;

    move-result-object v3

    iget-object v4, p0, Lcom/cyjh/elfin/fragment/SplashFragment;->adDataBean:Lcom/cyjh/elfin/entity/Ad$DataBean;

    iget-object v4, v4, Lcom/cyjh/elfin/entity/Ad$DataBean;->AdvertisementTitle:Ljava/lang/String;

    invoke-static {v3, v4}, Lcom/cyjh/elfin/util/IntentUtils;->toCallAbGames(Landroid/content/Context;Ljava/lang/String;)V

    goto :goto_0

    .line 909
    :cond_2
    new-instance v0, Lcom/cyjh/elfin/entity/GameInfo;

    invoke-direct {v0}, Lcom/cyjh/elfin/entity/GameInfo;-><init>()V

    .line 910
    .local v0, "gameInfo":Lcom/cyjh/elfin/entity/GameInfo;
    iget-object v3, p0, Lcom/cyjh/elfin/fragment/SplashFragment;->adDataBean:Lcom/cyjh/elfin/entity/Ad$DataBean;

    iget-object v3, v3, Lcom/cyjh/elfin/entity/Ad$DataBean;->Link:Ljava/lang/String;

    iput-object v3, v0, Lcom/cyjh/elfin/entity/GameInfo;->Id:Ljava/lang/String;

    .line 911
    iget-object v3, p0, Lcom/cyjh/elfin/fragment/SplashFragment;->adDataBean:Lcom/cyjh/elfin/entity/Ad$DataBean;

    iget-object v3, v3, Lcom/cyjh/elfin/entity/Ad$DataBean;->AdvertisementTitle:Ljava/lang/String;

    iput-object v3, v0, Lcom/cyjh/elfin/entity/GameInfo;->Name:Ljava/lang/String;

    .line 912
    invoke-virtual {p0}, Lcom/cyjh/elfin/fragment/SplashFragment;->getContext()Landroid/content/Context;

    move-result-object v3

    invoke-static {v3, v0}, Lcom/cyjh/elfin/util/IntentUtils;->toAbGamesDetailsActivity(Landroid/content/Context;Lcom/cyjh/elfin/entity/GameInfo;)V

    goto :goto_0
.end method

.method private onClickImgFullScrenAd(Landroid/view/View;)V
    .locals 2
    .param p1, "view"    # Landroid/view/View;

    .prologue
    .line 877
    const-string v0, "zzz"

    const-string v1, "Splash onClickImgFullScrenAd---1"

    invoke-static {v0, v1}, Landroid/util/Log;->e(Ljava/lang/String;Ljava/lang/String;)I

    .line 878
    iget-boolean v0, p0, Lcom/cyjh/elfin/fragment/SplashFragment;->isDisplayScreenAd:Z

    if-nez v0, :cond_1

    .line 879
    const-string v0, "zzz"

    const-string v1, "Splash onClickImgFullScrenAd---2"

    invoke-static {v0, v1}, Landroid/util/Log;->e(Ljava/lang/String;Ljava/lang/String;)I

    .line 880
    iget-boolean v0, p0, Lcom/cyjh/elfin/fragment/SplashFragment;->isClickerFirst:Z

    if-nez v0, :cond_0

    .line 881
    const-string v0, "zzz"

    const-string v1, "Splash onClickImgFullScrenAd---3"

    invoke-static {v0, v1}, Landroid/util/Log;->e(Ljava/lang/String;Ljava/lang/String;)I

    .line 882
    invoke-direct {p0, p1}, Lcom/cyjh/elfin/fragment/SplashFragment;->clickXunFeiAd(Landroid/view/View;)V

    .line 891
    :cond_0
    :goto_0
    return-void

    .line 885
    :cond_1
    const-string v0, "zzz"

    const-string v1, "Splash onClickImgFullScrenAd---4"

    invoke-static {v0, v1}, Landroid/util/Log;->e(Ljava/lang/String;Ljava/lang/String;)I

    .line 886
    iget-boolean v0, p0, Lcom/cyjh/elfin/fragment/SplashFragment;->isClickerFirst:Z

    if-nez v0, :cond_0

    .line 887
    const-string v0, "zzz"

    const-string v1, "Splash onClickImgFullScrenAd---5"

    invoke-static {v0, v1}, Landroid/util/Log;->e(Ljava/lang/String;Ljava/lang/String;)I

    .line 888
    invoke-direct {p0}, Lcom/cyjh/elfin/fragment/SplashFragment;->onClickImgBackGroundAd()V

    goto :goto_0
.end method


# virtual methods
.method public apkCheckedResult(Lcom/cyjh/elfin/entity/TemplateStatus;)V
    .locals 10
    .param p1, "templateStatus"    # Lcom/cyjh/elfin/entity/TemplateStatus;

    .prologue
    const/4 v9, 0x2

    const/4 v8, 0x1

    .line 482
    if-eqz p1, :cond_0

    .line 483
    iget-boolean v2, p0, Lcom/cyjh/elfin/fragment/SplashFragment;->isSecondRequestFlag:Z

    if-nez v2, :cond_1

    .line 484
    iput-boolean v8, p0, Lcom/cyjh/elfin/fragment/SplashFragment;->isSecondRequestFlag:Z

    .line 485
    iget-object v1, p1, Lcom/cyjh/elfin/entity/TemplateStatus;->status:Ljava/lang/String;

    .line 486
    .local v1, "status":Ljava/lang/String;
    invoke-static {v1}, Landroid/text/TextUtils;->isEmpty(Ljava/lang/CharSequence;)Z

    move-result v2

    if-nez v2, :cond_0

    .line 487
    invoke-static {v1}, Ljava/lang/Integer;->parseInt(Ljava/lang/String;)I

    move-result v2

    packed-switch v2, :pswitch_data_0

    .line 532
    .end local v1    # "status":Ljava/lang/String;
    :cond_0
    :goto_0
    return-void

    .line 489
    .restart local v1    # "status":Ljava/lang/String;
    :pswitch_0
    iget-object v2, p0, Lcom/cyjh/elfin/fragment/SplashFragment;->commonLog:Lcom/cyjh/elfin/log/CommonLog;

    new-instance v3, Ljava/lang/StringBuilder;

    invoke-direct {v3}, Ljava/lang/StringBuilder;-><init>()V

    const-string v4, "\u6587\u672c\u63d0\u793a\uff1a"

    invoke-virtual {v3, v4}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v3

    iget-object v4, p1, Lcom/cyjh/elfin/entity/TemplateStatus;->remark:Ljava/lang/String;

    invoke-virtual {v3, v4}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v3

    invoke-virtual {v3}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v3

    invoke-virtual {v2, v3}, Lcom/cyjh/elfin/log/CommonLog;->e(Ljava/lang/Object;)V

    .line 490
    iget-object v2, p1, Lcom/cyjh/elfin/entity/TemplateStatus;->remark:Ljava/lang/String;

    invoke-direct {p0, v8, v2}, Lcom/cyjh/elfin/fragment/SplashFragment;->getDialogMessageByServer(ILjava/lang/String;)V

    goto :goto_0

    .line 493
    :pswitch_1
    iget-object v2, p1, Lcom/cyjh/elfin/entity/TemplateStatus;->remark:Ljava/lang/String;

    iput-object v2, p0, Lcom/cyjh/elfin/fragment/SplashFragment;->remarkText:Ljava/lang/String;

    .line 495
    :pswitch_2
    iget-object v2, p0, Lcom/cyjh/elfin/fragment/SplashFragment;->mHandler:Landroid/os/Handler;

    const/16 v3, 0xb

    invoke-virtual {v2, v3}, Landroid/os/Handler;->obtainMessage(I)Landroid/os/Message;

    move-result-object v2

    invoke-virtual {v2}, Landroid/os/Message;->sendToTarget()V

    goto :goto_0

    .line 500
    .end local v1    # "status":Ljava/lang/String;
    :cond_1
    const/4 v2, 0x0

    iput-boolean v2, p0, Lcom/cyjh/elfin/fragment/SplashFragment;->isSecondRequestFlag:Z

    .line 501
    iget-object v1, p1, Lcom/cyjh/elfin/entity/TemplateStatus;->status:Ljava/lang/String;

    .line 502
    .restart local v1    # "status":Ljava/lang/String;
    invoke-static {v1}, Landroid/text/TextUtils;->isEmpty(Ljava/lang/CharSequence;)Z

    move-result v2

    if-nez v2, :cond_0

    .line 503
    iget-object v2, p0, Lcom/cyjh/elfin/fragment/SplashFragment;->appContext:Lcom/cyjh/elfin/AppContext;

    iget-object v2, v2, Lcom/cyjh/elfin/AppContext;->mSharePre:Landroid/content/SharedPreferences;

    invoke-interface {v2}, Landroid/content/SharedPreferences;->edit()Landroid/content/SharedPreferences$Editor;

    move-result-object v2

    const-string v3, "server_time"

    iget-wide v4, p0, Lcom/cyjh/elfin/fragment/SplashFragment;->saveServerTime:J

    const-wide/32 v6, 0x6ddd00

    add-long/2addr v4, v6

    invoke-interface {v2, v3, v4, v5}, Landroid/content/SharedPreferences$Editor;->putLong(Ljava/lang/String;J)Landroid/content/SharedPreferences$Editor;

    move-result-object v2

    invoke-interface {v2}, Landroid/content/SharedPreferences$Editor;->commit()Z

    .line 504
    iget-object v2, p0, Lcom/cyjh/elfin/fragment/SplashFragment;->commonLog:Lcom/cyjh/elfin/log/CommonLog;

    new-instance v3, Ljava/lang/StringBuilder;

    invoke-direct {v3}, Ljava/lang/StringBuilder;-><init>()V

    const-string v4, "serverSaveTime="

    invoke-virtual {v3, v4}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v3

    iget-wide v4, p0, Lcom/cyjh/elfin/fragment/SplashFragment;->saveServerTime:J

    invoke-virtual {v3, v4, v5}, Ljava/lang/StringBuilder;->append(J)Ljava/lang/StringBuilder;

    move-result-object v3

    invoke-virtual {v3}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v3

    invoke-virtual {v2, v3}, Lcom/cyjh/elfin/log/CommonLog;->e(Ljava/lang/Object;)V

    .line 505
    invoke-static {v1}, Ljava/lang/Integer;->parseInt(Ljava/lang/String;)I

    move-result v2

    packed-switch v2, :pswitch_data_1

    goto :goto_0

    .line 507
    :pswitch_3
    iget-object v2, p1, Lcom/cyjh/elfin/entity/TemplateStatus;->remark:Ljava/lang/String;

    invoke-direct {p0, v8, v2}, Lcom/cyjh/elfin/fragment/SplashFragment;->getDialogMessageByServer(ILjava/lang/String;)V

    goto :goto_0

    .line 510
    :pswitch_4
    iget-object v0, p1, Lcom/cyjh/elfin/entity/TemplateStatus;->remark:Ljava/lang/String;

    .line 511
    .local v0, "secondRemark":Ljava/lang/String;
    iget-object v2, p0, Lcom/cyjh/elfin/fragment/SplashFragment;->remarkText:Ljava/lang/String;

    invoke-static {v2}, Landroid/text/TextUtils;->isEmpty(Ljava/lang/CharSequence;)Z

    move-result v2

    if-nez v2, :cond_2

    .line 512
    iget-object v2, p0, Lcom/cyjh/elfin/fragment/SplashFragment;->remarkText:Ljava/lang/String;

    invoke-direct {p0, v9, v2}, Lcom/cyjh/elfin/fragment/SplashFragment;->getDialogMessageByServer(ILjava/lang/String;)V

    goto/16 :goto_0

    .line 514
    :cond_2
    invoke-static {v0}, Landroid/text/TextUtils;->isEmpty(Ljava/lang/CharSequence;)Z

    move-result v2

    if-nez v2, :cond_0

    .line 515
    invoke-direct {p0, v9, v0}, Lcom/cyjh/elfin/fragment/SplashFragment;->getDialogMessageByServer(ILjava/lang/String;)V

    goto/16 :goto_0

    .line 520
    .end local v0    # "secondRemark":Ljava/lang/String;
    :pswitch_5
    iget-object v2, p0, Lcom/cyjh/elfin/fragment/SplashFragment;->remarkText:Ljava/lang/String;

    invoke-static {v2}, Landroid/text/TextUtils;->isEmpty(Ljava/lang/CharSequence;)Z

    move-result v2

    if-nez v2, :cond_3

    .line 521
    iget-object v2, p0, Lcom/cyjh/elfin/fragment/SplashFragment;->remarkText:Ljava/lang/String;

    invoke-direct {p0, v9, v2}, Lcom/cyjh/elfin/fragment/SplashFragment;->getDialogMessageByServer(ILjava/lang/String;)V

    goto/16 :goto_0

    .line 524
    :cond_3
    iget-object v2, p0, Lcom/cyjh/elfin/fragment/SplashFragment;->commonLog:Lcom/cyjh/elfin/log/CommonLog;

    const-string v3, "\u9a8c\u8bc1\u754c\u9762\u52a0\u8f7d\u5b8c"

    invoke-virtual {v2, v3}, Lcom/cyjh/elfin/log/CommonLog;->e(Ljava/lang/Object;)V

    .line 525
    iget-object v2, p0, Lcom/cyjh/elfin/fragment/SplashFragment;->mHandler:Landroid/os/Handler;

    const/16 v3, 0xe

    invoke-virtual {v2, v3}, Landroid/os/Handler;->obtainMessage(I)Landroid/os/Message;

    move-result-object v2

    invoke-virtual {v2}, Landroid/os/Message;->sendToTarget()V

    goto/16 :goto_0

    .line 487
    nop

    :pswitch_data_0
    .packed-switch 0x1
        :pswitch_0
        :pswitch_1
        :pswitch_2
    .end packed-switch

    .line 505
    :pswitch_data_1
    .packed-switch 0x1
        :pswitch_3
        :pswitch_4
        :pswitch_5
    .end packed-switch
.end method

.method public gamesSwitch(Lcom/cyjh/elfin/entity/GameSwitchBean;)V
    .locals 4
    .param p1, "gameSwitchBean"    # Lcom/cyjh/elfin/entity/GameSwitchBean;

    .prologue
    .line 643
    if-eqz p1, :cond_2

    iget-object v1, p1, Lcom/cyjh/elfin/entity/GameSwitchBean;->Data:Lcom/cyjh/elfin/entity/GameSwitchInfo;

    if-eqz v1, :cond_2

    .line 644
    iget-object v1, p0, Lcom/cyjh/elfin/fragment/SplashFragment;->appContext:Lcom/cyjh/elfin/AppContext;

    iget-object v1, v1, Lcom/cyjh/elfin/AppContext;->mSharePre:Landroid/content/SharedPreferences;

    const-string v2, "recommend_games_link"

    const-string v3, ""

    invoke-interface {v1, v2, v3}, Landroid/content/SharedPreferences;->getString(Ljava/lang/String;Ljava/lang/String;)Ljava/lang/String;

    move-result-object v0

    .line 645
    .local v0, "recommendGamesLink":Ljava/lang/String;
    iget-object v1, p0, Lcom/cyjh/elfin/fragment/SplashFragment;->commonLog:Lcom/cyjh/elfin/log/CommonLog;

    new-instance v2, Ljava/lang/StringBuilder;

    invoke-direct {v2}, Ljava/lang/StringBuilder;-><init>()V

    const-string v3, "recommendGamesLink:"

    invoke-virtual {v2, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    invoke-virtual {v2, v0}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    invoke-virtual {v2}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v2

    invoke-virtual {v1, v2}, Lcom/cyjh/elfin/log/CommonLog;->e(Ljava/lang/Object;)V

    .line 646
    iget-object v1, p1, Lcom/cyjh/elfin/entity/GameSwitchBean;->Data:Lcom/cyjh/elfin/entity/GameSwitchInfo;

    iget-object v1, v1, Lcom/cyjh/elfin/entity/GameSwitchInfo;->Path:Ljava/lang/String;

    invoke-virtual {v1, v0}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v1

    if-nez v1, :cond_1

    const-string v1, "2"

    iget-object v2, p1, Lcom/cyjh/elfin/entity/GameSwitchBean;->Data:Lcom/cyjh/elfin/entity/GameSwitchInfo;

    iget-object v2, v2, Lcom/cyjh/elfin/entity/GameSwitchInfo;->Type:Ljava/lang/String;

    invoke-virtual {v1, v2}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v1

    if-eqz v1, :cond_1

    .line 647
    iget-object v1, p0, Lcom/cyjh/elfin/fragment/SplashFragment;->appContext:Lcom/cyjh/elfin/AppContext;

    iget-object v2, p1, Lcom/cyjh/elfin/entity/GameSwitchBean;->Data:Lcom/cyjh/elfin/entity/GameSwitchInfo;

    iget-object v2, v2, Lcom/cyjh/elfin/entity/GameSwitchInfo;->Name:Ljava/lang/String;

    iget-object v3, p1, Lcom/cyjh/elfin/entity/GameSwitchBean;->Data:Lcom/cyjh/elfin/entity/GameSwitchInfo;

    iget-object v3, v3, Lcom/cyjh/elfin/entity/GameSwitchInfo;->Path:Ljava/lang/String;

    invoke-static {v1, v2, v3}, Lcom/cyjh/elfin/util/IntentUtils;->toCallWebGamesActivity(Landroid/content/Context;Ljava/lang/String;Ljava/lang/String;)V

    .line 648
    iget-object v1, p0, Lcom/cyjh/elfin/fragment/SplashFragment;->appContext:Lcom/cyjh/elfin/AppContext;

    iget-object v1, v1, Lcom/cyjh/elfin/AppContext;->mSharePre:Landroid/content/SharedPreferences;

    invoke-interface {v1}, Landroid/content/SharedPreferences;->edit()Landroid/content/SharedPreferences$Editor;

    move-result-object v1

    const-string v2, "default_entry_games"

    const/4 v3, 0x1

    invoke-interface {v1, v2, v3}, Landroid/content/SharedPreferences$Editor;->putBoolean(Ljava/lang/String;Z)Landroid/content/SharedPreferences$Editor;

    move-result-object v1

    invoke-interface {v1}, Landroid/content/SharedPreferences$Editor;->apply()V

    .line 655
    .end local v0    # "recommendGamesLink":Ljava/lang/String;
    :goto_0
    invoke-virtual {p0}, Lcom/cyjh/elfin/fragment/SplashFragment;->getActivity()Landroid/support/v4/app/FragmentActivity;

    move-result-object v1

    if-eqz v1, :cond_0

    .line 657
    invoke-virtual {p0}, Lcom/cyjh/elfin/fragment/SplashFragment;->getActivity()Landroid/support/v4/app/FragmentActivity;

    move-result-object v1

    invoke-virtual {v1}, Landroid/support/v4/app/FragmentActivity;->finish()V

    .line 659
    :cond_0
    return-void

    .line 650
    .restart local v0    # "recommendGamesLink":Ljava/lang/String;
    :cond_1
    invoke-virtual {p0}, Lcom/cyjh/elfin/fragment/SplashFragment;->getContext()Landroid/content/Context;

    move-result-object v1

    invoke-static {v1}, Lcom/cyjh/elfin/activity/ElfinFreeActivity;->toCallActivity(Landroid/content/Context;)V

    goto :goto_0

    .line 653
    .end local v0    # "recommendGamesLink":Ljava/lang/String;
    :cond_2
    invoke-virtual {p0}, Lcom/cyjh/elfin/fragment/SplashFragment;->getContext()Landroid/content/Context;

    move-result-object v1

    invoke-static {v1}, Lcom/cyjh/elfin/activity/ElfinFreeActivity;->toCallActivity(Landroid/content/Context;)V

    goto :goto_0
.end method

.method public getFragmentLayoutId()I
    .locals 1

    .prologue
    .line 228
    const v0, 0x7f04004f

    return v0
.end method

.method public imgAdResult(Lcom/cyjh/elfin/entity/Ad;)V
    .locals 9
    .param p1, "ad"    # Lcom/cyjh/elfin/entity/Ad;

    .prologue
    const/4 v7, 0x0

    const/4 v8, 0x1

    .line 566
    iget-object v4, p0, Lcom/cyjh/elfin/fragment/SplashFragment;->commonLog:Lcom/cyjh/elfin/log/CommonLog;

    new-instance v5, Ljava/lang/StringBuilder;

    invoke-direct {v5}, Ljava/lang/StringBuilder;-><init>()V

    const-string v6, "imgAdResult,ad="

    invoke-virtual {v5, v6}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v5

    invoke-virtual {v5, p1}, Ljava/lang/StringBuilder;->append(Ljava/lang/Object;)Ljava/lang/StringBuilder;

    move-result-object v5

    invoke-virtual {v5}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v5

    invoke-virtual {v4, v5}, Lcom/cyjh/elfin/log/CommonLog;->e(Ljava/lang/Object;)V

    .line 567
    iget v4, p1, Lcom/cyjh/elfin/entity/Ad;->site:I

    const/4 v5, 0x3

    if-ne v4, v5, :cond_2

    .line 568
    iput-boolean v8, p0, Lcom/cyjh/elfin/fragment/SplashFragment;->isOpenScreenLoad:Z

    .line 569
    iget-object v4, p1, Lcom/cyjh/elfin/entity/Ad;->Data:Ljava/util/List;

    if-eqz v4, :cond_0

    iget-object v4, p1, Lcom/cyjh/elfin/entity/Ad;->Data:Ljava/util/List;

    invoke-interface {v4}, Ljava/util/List;->size()I

    move-result v4

    if-lez v4, :cond_0

    .line 570
    iget-object v4, p1, Lcom/cyjh/elfin/entity/Ad;->Data:Ljava/util/List;

    invoke-interface {v4, v7}, Ljava/util/List;->get(I)Ljava/lang/Object;

    move-result-object v4

    check-cast v4, Lcom/cyjh/elfin/entity/Ad$DataBean;

    iput-object v4, p0, Lcom/cyjh/elfin/fragment/SplashFragment;->adDataBean:Lcom/cyjh/elfin/entity/Ad$DataBean;

    .line 571
    iget-object v4, p0, Lcom/cyjh/elfin/fragment/SplashFragment;->backgroundAdStatistics:Lcom/cyjh/elfin/mvp/managers/BackgroundSettingsAdStatistics;

    invoke-virtual {p0}, Lcom/cyjh/elfin/fragment/SplashFragment;->getActivity()Landroid/support/v4/app/FragmentActivity;

    move-result-object v5

    iget-object v6, p0, Lcom/cyjh/elfin/fragment/SplashFragment;->adDataBean:Lcom/cyjh/elfin/entity/Ad$DataBean;

    iget-object v6, v6, Lcom/cyjh/elfin/entity/Ad$DataBean;->Id:Ljava/lang/String;

    const-string v7, "2"

    invoke-virtual {v4, v5, v6, v7}, Lcom/cyjh/elfin/mvp/managers/BackgroundSettingsAdStatistics;->backgroundStatisticsAdCount(Landroid/content/Context;Ljava/lang/String;Ljava/lang/String;)V

    .line 574
    :cond_0
    iget-object v4, p0, Lcom/cyjh/elfin/fragment/SplashFragment;->mHandler:Landroid/os/Handler;

    const/16 v5, 0x10

    invoke-virtual {v4, v5}, Landroid/os/Handler;->obtainMessage(I)Landroid/os/Message;

    move-result-object v4

    invoke-virtual {v4}, Landroid/os/Message;->sendToTarget()V

    .line 639
    :cond_1
    :goto_0
    return-void

    .line 575
    :cond_2
    iget v4, p1, Lcom/cyjh/elfin/entity/Ad;->site:I

    if-ne v4, v8, :cond_1

    .line 576
    iget-boolean v4, p0, Lcom/cyjh/elfin/fragment/SplashFragment;->checkedResultReq:Z

    if-nez v4, :cond_3

    iget-object v4, p1, Lcom/cyjh/elfin/entity/Ad;->Data:Ljava/util/List;

    invoke-interface {v4}, Ljava/util/List;->size()I

    move-result v4

    if-lez v4, :cond_3

    if-eqz p1, :cond_3

    .line 577
    iput-boolean v8, p0, Lcom/cyjh/elfin/fragment/SplashFragment;->checkedResultReq:Z

    .line 578
    iget-object v4, p1, Lcom/cyjh/elfin/entity/Ad;->Data:Ljava/util/List;

    invoke-interface {v4, v7}, Ljava/util/List;->get(I)Ljava/lang/Object;

    move-result-object v1

    check-cast v1, Lcom/cyjh/elfin/entity/Ad$DataBean;

    .line 579
    .local v1, "dataBean":Lcom/cyjh/elfin/entity/Ad$DataBean;
    new-instance v0, Lcom/cyjh/elfin/entity/AdPassData;

    invoke-direct {v0}, Lcom/cyjh/elfin/entity/AdPassData;-><init>()V

    .line 580
    .local v0, "adPassData":Lcom/cyjh/elfin/entity/AdPassData;
    iget-object v4, v1, Lcom/cyjh/elfin/entity/Ad$DataBean;->Url:Ljava/lang/String;

    iput-object v4, v0, Lcom/cyjh/elfin/entity/AdPassData;->adImgUrl:Ljava/lang/String;

    .line 581
    iget-object v4, v1, Lcom/cyjh/elfin/entity/Ad$DataBean;->Id:Ljava/lang/String;

    iput-object v4, v0, Lcom/cyjh/elfin/entity/AdPassData;->adDataId:Ljava/lang/String;

    .line 582
    iget-object v4, v1, Lcom/cyjh/elfin/entity/Ad$DataBean;->Link:Ljava/lang/String;

    iput-object v4, v0, Lcom/cyjh/elfin/entity/AdPassData;->adJumpLink:Ljava/lang/String;

    .line 583
    iget-object v4, v1, Lcom/cyjh/elfin/entity/Ad$DataBean;->LinkType:Ljava/lang/String;

    iput-object v4, v0, Lcom/cyjh/elfin/entity/AdPassData;->adLinkType:Ljava/lang/String;

    .line 584
    iget-object v4, v1, Lcom/cyjh/elfin/entity/Ad$DataBean;->AdvertisementTitle:Ljava/lang/String;

    iput-object v4, v0, Lcom/cyjh/elfin/entity/AdPassData;->adTitle:Ljava/lang/String;

    .line 585
    iget-object v4, p0, Lcom/cyjh/elfin/fragment/SplashFragment;->backgroundAdStatistics:Lcom/cyjh/elfin/mvp/managers/BackgroundSettingsAdStatistics;

    invoke-virtual {p0}, Lcom/cyjh/elfin/fragment/SplashFragment;->getActivity()Landroid/support/v4/app/FragmentActivity;

    move-result-object v5

    iget-object v6, v0, Lcom/cyjh/elfin/entity/AdPassData;->adDataId:Ljava/lang/String;

    const-string v7, "2"

    invoke-virtual {v4, v5, v6, v7}, Lcom/cyjh/elfin/mvp/managers/BackgroundSettingsAdStatistics;->backgroundStatisticsAdCount(Landroid/content/Context;Ljava/lang/String;Ljava/lang/String;)V

    .line 586
    iget-object v4, p0, Lcom/cyjh/elfin/fragment/SplashFragment;->appContext:Lcom/cyjh/elfin/AppContext;

    iget-object v4, v4, Lcom/cyjh/elfin/AppContext;->mSharePre:Landroid/content/SharedPreferences;

    const-string v5, "ad_is_first"

    invoke-interface {v4, v5, v8}, Landroid/content/SharedPreferences;->getBoolean(Ljava/lang/String;Z)Z

    move-result v3

    .line 587
    .local v3, "isFirst":Z
    iget-object v4, p0, Lcom/cyjh/elfin/fragment/SplashFragment;->commonLog:Lcom/cyjh/elfin/log/CommonLog;

    new-instance v5, Ljava/lang/StringBuilder;

    invoke-direct {v5}, Ljava/lang/StringBuilder;-><init>()V

    const-string v6, "isFirst:\u662f\u5426\u8fdb\u5165\u5e7f\u544a\u9875\u9762"

    invoke-virtual {v5, v6}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v5

    invoke-virtual {v5, v3}, Ljava/lang/StringBuilder;->append(Z)Ljava/lang/StringBuilder;

    move-result-object v5

    invoke-virtual {v5}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v5

    invoke-virtual {v4, v5}, Lcom/cyjh/elfin/log/CommonLog;->e(Ljava/lang/Object;)V

    .line 588
    const-string v4, "zzz"

    new-instance v5, Ljava/lang/StringBuilder;

    invoke-direct {v5}, Ljava/lang/StringBuilder;-><init>()V

    const-string v6, "isFirst:\u662f\u5426\u8fdb\u5165\u5e7f\u544a\u9875\u9762"

    invoke-virtual {v5, v6}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v5

    invoke-virtual {v5, v3}, Ljava/lang/StringBuilder;->append(Z)Ljava/lang/StringBuilder;

    move-result-object v5

    invoke-virtual {v5}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v5

    invoke-static {v4, v5}, Landroid/util/Log;->e(Ljava/lang/String;Ljava/lang/String;)I

    .line 601
    new-instance v2, Landroid/content/Intent;

    invoke-virtual {p0}, Lcom/cyjh/elfin/fragment/SplashFragment;->getActivity()Landroid/support/v4/app/FragmentActivity;

    move-result-object v4

    const-class v5, Lcom/cyjh/elfin/activity/AdActivity;

    invoke-direct {v2, v4, v5}, Landroid/content/Intent;-><init>(Landroid/content/Context;Ljava/lang/Class;)V

    .line 602
    .local v2, "intent":Landroid/content/Intent;
    const-class v4, Lcom/cyjh/elfin/activity/AdActivity;

    invoke-virtual {v4}, Ljava/lang/Class;->getCanonicalName()Ljava/lang/String;

    move-result-object v4

    invoke-virtual {v2, v4, v0}, Landroid/content/Intent;->putExtra(Ljava/lang/String;Landroid/os/Parcelable;)Landroid/content/Intent;

    .line 603
    const/high16 v4, 0x10000000

    invoke-virtual {v2, v4}, Landroid/content/Intent;->addFlags(I)Landroid/content/Intent;

    .line 604
    invoke-virtual {p0}, Lcom/cyjh/elfin/fragment/SplashFragment;->getActivity()Landroid/support/v4/app/FragmentActivity;

    move-result-object v4

    invoke-virtual {v4, v2}, Landroid/support/v4/app/FragmentActivity;->startActivity(Landroid/content/Intent;)V

    .line 605
    invoke-virtual {p0}, Lcom/cyjh/elfin/fragment/SplashFragment;->getActivity()Landroid/support/v4/app/FragmentActivity;

    move-result-object v4

    if-eqz v4, :cond_1

    invoke-virtual {p0}, Lcom/cyjh/elfin/fragment/SplashFragment;->getActivity()Landroid/support/v4/app/FragmentActivity;

    move-result-object v4

    invoke-virtual {v4}, Landroid/support/v4/app/FragmentActivity;->isFinishing()Z

    move-result v4

    if-nez v4, :cond_1

    .line 606
    invoke-virtual {p0}, Lcom/cyjh/elfin/fragment/SplashFragment;->getActivity()Landroid/support/v4/app/FragmentActivity;

    move-result-object v4

    invoke-virtual {v4}, Landroid/support/v4/app/FragmentActivity;->finish()V

    goto/16 :goto_0

    .line 633
    .end local v0    # "adPassData":Lcom/cyjh/elfin/entity/AdPassData;
    .end local v1    # "dataBean":Lcom/cyjh/elfin/entity/Ad$DataBean;
    .end local v2    # "intent":Landroid/content/Intent;
    .end local v3    # "isFirst":Z
    :cond_3
    iget-boolean v4, p0, Lcom/cyjh/elfin/fragment/SplashFragment;->checkedResultReq:Z

    if-nez v4, :cond_1

    .line 634
    iput-boolean v8, p0, Lcom/cyjh/elfin/fragment/SplashFragment;->checkedResultReq:Z

    .line 635
    iget-object v4, p0, Lcom/cyjh/elfin/fragment/SplashFragment;->recommendGamesPresenter:Lcom/cyjh/elfin/mvp/presenters/RecommendGamesPresenter;

    invoke-virtual {p0}, Lcom/cyjh/elfin/fragment/SplashFragment;->getActivity()Landroid/support/v4/app/FragmentActivity;

    move-result-object v5

    invoke-virtual {v4, v5}, Lcom/cyjh/elfin/mvp/presenters/RecommendGamesPresenter;->gameJumpSwitch(Landroid/content/Context;)V

    goto/16 :goto_0
.end method

.method public onActivityCreated(Landroid/os/Bundle;)V
    .locals 2
    .param p1, "savedInstanceState"    # Landroid/os/Bundle;

    .prologue
    .line 237
    invoke-super {p0, p1}, Lcom/cyjh/elfin/fragment/BaseFragement;->onActivityCreated(Landroid/os/Bundle;)V

    .line 238
    invoke-virtual {p0}, Lcom/cyjh/elfin/fragment/SplashFragment;->getActivity()Landroid/support/v4/app/FragmentActivity;

    move-result-object v1

    invoke-static {v1}, Lcom/cyjh/elfin/util/NetworkUtils;->isAvailable(Landroid/content/Context;)Z

    move-result v0

    .line 239
    .local v0, "netFlag":Z
    new-instance v1, Lcom/cyjh/elfin/mvp/presenters/TemplatePresenter;

    invoke-direct {v1, p0}, Lcom/cyjh/elfin/mvp/presenters/TemplatePresenter;-><init>(Lcom/cyjh/elfin/mvp/views/TemplateView;)V

    iput-object v1, p0, Lcom/cyjh/elfin/fragment/SplashFragment;->templatePresenter:Lcom/cyjh/elfin/mvp/presenters/TemplatePresenter;

    .line 240
    new-instance v1, Lcom/cyjh/elfin/mvp/presenters/AdImagePresenter;

    invoke-direct {v1, p0}, Lcom/cyjh/elfin/mvp/presenters/AdImagePresenter;-><init>(Lcom/cyjh/elfin/mvp/views/AdImageView;)V

    iput-object v1, p0, Lcom/cyjh/elfin/fragment/SplashFragment;->adImagePresenter:Lcom/cyjh/elfin/mvp/presenters/AdImagePresenter;

    .line 241
    new-instance v1, Lcom/cyjh/elfin/mvp/presenters/RecommendGamesPresenter;

    invoke-direct {v1, p0}, Lcom/cyjh/elfin/mvp/presenters/RecommendGamesPresenter;-><init>(Lcom/cyjh/elfin/mvp/views/RecommendGamesView;)V

    iput-object v1, p0, Lcom/cyjh/elfin/fragment/SplashFragment;->recommendGamesPresenter:Lcom/cyjh/elfin/mvp/presenters/RecommendGamesPresenter;

    .line 242
    new-instance v1, Lcom/cyjh/elfin/mvp/presenters/BlackListPresenter;

    invoke-direct {v1, p0}, Lcom/cyjh/elfin/mvp/presenters/BlackListPresenter;-><init>(Lcom/cyjh/elfin/mvp/views/BlackListView;)V

    iput-object v1, p0, Lcom/cyjh/elfin/fragment/SplashFragment;->blackListPresenter:Lcom/cyjh/elfin/mvp/presenters/BlackListPresenter;

    .line 243
    new-instance v1, Lcom/cyjh/elfin/mvp/managers/BackgroundSettingsAdStatistics;

    invoke-direct {v1}, Lcom/cyjh/elfin/mvp/managers/BackgroundSettingsAdStatistics;-><init>()V

    iput-object v1, p0, Lcom/cyjh/elfin/fragment/SplashFragment;->backgroundAdStatistics:Lcom/cyjh/elfin/mvp/managers/BackgroundSettingsAdStatistics;

    .line 244
    invoke-direct {p0, v0}, Lcom/cyjh/elfin/fragment/SplashFragment;->isHasNetwork(Z)V

    .line 245
    return-void
.end method

.method public onCreate(Landroid/os/Bundle;)V
    .locals 1
    .param p1, "savedInstanceState"    # Landroid/os/Bundle;
        .annotation build Landroid/support/annotation/Nullable;
        .end annotation
    .end param

    .prologue
    .line 249
    invoke-super {p0, p1}, Lcom/cyjh/elfin/fragment/BaseFragement;->onCreate(Landroid/os/Bundle;)V

    .line 250
    invoke-static {}, Lorg/greenrobot/eventbus/EventBus;->getDefault()Lorg/greenrobot/eventbus/EventBus;

    move-result-object v0

    invoke-virtual {v0, p0}, Lorg/greenrobot/eventbus/EventBus;->register(Ljava/lang/Object;)V

    .line 251
    return-void
.end method

.method public onDestroy()V
    .locals 3

    .prologue
    const/4 v2, 0x0

    .line 453
    invoke-super {p0}, Lcom/cyjh/elfin/fragment/BaseFragement;->onDestroy()V

    .line 454
    invoke-static {}, Lcom/cyjh/elfin/mvp/managers/IFLYAdCountStatistics;->cancelReqCountStatistics()V

    .line 455
    iget-object v0, p0, Lcom/cyjh/elfin/fragment/SplashFragment;->mRunnableTask:Lcom/cyjh/elfin/fragment/SplashFragment$RunnableTask;

    if-eqz v0, :cond_0

    .line 456
    iget-object v0, p0, Lcom/cyjh/elfin/fragment/SplashFragment;->mHandler:Landroid/os/Handler;

    iget-object v1, p0, Lcom/cyjh/elfin/fragment/SplashFragment;->mRunnableTask:Lcom/cyjh/elfin/fragment/SplashFragment$RunnableTask;

    invoke-virtual {v0, v1}, Landroid/os/Handler;->removeCallbacks(Ljava/lang/Runnable;)V

    .line 457
    iput-object v2, p0, Lcom/cyjh/elfin/fragment/SplashFragment;->mRunnableTask:Lcom/cyjh/elfin/fragment/SplashFragment$RunnableTask;

    .line 459
    :cond_0
    invoke-direct {p0}, Lcom/cyjh/elfin/fragment/SplashFragment;->cancelCloseTimer()V

    .line 460
    invoke-static {}, Lorg/greenrobot/eventbus/EventBus;->getDefault()Lorg/greenrobot/eventbus/EventBus;

    move-result-object v0

    invoke-virtual {v0, p0}, Lorg/greenrobot/eventbus/EventBus;->unregister(Ljava/lang/Object;)V

    .line 461
    iget-object v0, p0, Lcom/cyjh/elfin/fragment/SplashFragment;->mCountRunnable:Lcom/cyjh/elfin/fragment/SplashFragment$CountTimeRunnable;

    if-eqz v0, :cond_1

    .line 462
    const-string v0, "zzz"

    const-string v1, "SplashFrgament---onDestroy--mCountRunnable != null"

    invoke-static {v0, v1}, Landroid/util/Log;->e(Ljava/lang/String;Ljava/lang/String;)I

    .line 463
    iget-object v0, p0, Lcom/cyjh/elfin/fragment/SplashFragment;->mHandler:Landroid/os/Handler;

    iget-object v1, p0, Lcom/cyjh/elfin/fragment/SplashFragment;->mCountRunnable:Lcom/cyjh/elfin/fragment/SplashFragment$CountTimeRunnable;

    invoke-virtual {v0, v1}, Landroid/os/Handler;->removeCallbacks(Ljava/lang/Runnable;)V

    .line 464
    iput-object v2, p0, Lcom/cyjh/elfin/fragment/SplashFragment;->mCountRunnable:Lcom/cyjh/elfin/fragment/SplashFragment$CountTimeRunnable;

    .line 467
    :cond_1
    return-void
.end method

.method public onErrorMsg(Ljava/lang/String;Ljava/lang/String;)V
    .locals 8
    .param p1, "message"    # Ljava/lang/String;
    .param p2, "authority"    # Ljava/lang/String;

    .prologue
    const v7, 0x7f0800d9

    const/4 v6, 0x5

    const/4 v5, 0x2

    const/4 v3, 0x1

    const/4 v4, 0x0

    .line 540
    const-string v0, "GetFreeElfGameRecommended_New"

    invoke-virtual {v0, p2}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v0

    if-eqz v0, :cond_0

    .line 541
    invoke-virtual {p0}, Lcom/cyjh/elfin/fragment/SplashFragment;->getActivity()Landroid/support/v4/app/FragmentActivity;

    move-result-object v0

    invoke-static {v0}, Lcom/cyjh/elfin/activity/ElfinFreeActivity;->toCallActivity(Landroid/content/Context;)V

    .line 542
    invoke-virtual {p0}, Lcom/cyjh/elfin/fragment/SplashFragment;->getActivity()Landroid/support/v4/app/FragmentActivity;

    move-result-object v0

    invoke-virtual {v0}, Landroid/support/v4/app/FragmentActivity;->finish()V

    .line 558
    :goto_0
    return-void

    .line 544
    :cond_0
    iget v0, p0, Lcom/cyjh/elfin/fragment/SplashFragment;->countReq:I

    add-int/lit8 v0, v0, 0x1

    iput v0, p0, Lcom/cyjh/elfin/fragment/SplashFragment;->countReq:I

    .line 545
    iget-object v0, p0, Lcom/cyjh/elfin/fragment/SplashFragment;->commonLog:Lcom/cyjh/elfin/log/CommonLog;

    new-instance v1, Ljava/lang/StringBuilder;

    invoke-direct {v1}, Ljava/lang/StringBuilder;-><init>()V

    const-string v2, "\u8bf7\u6c42\u5931\u8d25"

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    iget v2, p0, Lcom/cyjh/elfin/fragment/SplashFragment;->countReq:I

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v1

    const-string v2, ",message"

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1, p1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v1

    invoke-virtual {v0, v1}, Lcom/cyjh/elfin/log/CommonLog;->e(Ljava/lang/Object;)V

    .line 546
    invoke-virtual {p0}, Lcom/cyjh/elfin/fragment/SplashFragment;->isAdded()Z

    move-result v0

    if-eqz v0, :cond_1

    .line 547
    const-string v0, "10"

    invoke-virtual {p1, v0}, Ljava/lang/String;->startsWith(Ljava/lang/String;)Z

    move-result v0

    if-eqz v0, :cond_2

    iget v0, p0, Lcom/cyjh/elfin/fragment/SplashFragment;->countReq:I

    if-gt v0, v6, :cond_2

    .line 548
    iget-object v0, p0, Lcom/cyjh/elfin/fragment/SplashFragment;->mHandler:Landroid/os/Handler;

    const/16 v1, 0xa

    invoke-virtual {v0, v1}, Landroid/os/Handler;->obtainMessage(I)Landroid/os/Message;

    move-result-object v0

    invoke-virtual {v0}, Landroid/os/Message;->sendToTarget()V

    .line 549
    new-instance v0, Ljava/lang/StringBuilder;

    invoke-direct {v0}, Ljava/lang/StringBuilder;-><init>()V

    invoke-virtual {p0, v7}, Lcom/cyjh/elfin/fragment/SplashFragment;->getString(I)Ljava/lang/String;

    move-result-object v1

    new-array v2, v3, [Ljava/lang/Object;

    iget v3, p0, Lcom/cyjh/elfin/fragment/SplashFragment;->countReq:I

    invoke-static {v3}, Ljava/lang/Integer;->valueOf(I)Ljava/lang/Integer;

    move-result-object v3

    aput-object v3, v2, v4

    invoke-static {v1, v2}, Ljava/lang/String;->format(Ljava/lang/String;[Ljava/lang/Object;)Ljava/lang/String;

    move-result-object v1

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-virtual {p1, v5}, Ljava/lang/String;->substring(I)Ljava/lang/String;

    move-result-object v1

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-virtual {v0}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object p1

    .line 550
    iget-object v0, p0, Lcom/cyjh/elfin/fragment/SplashFragment;->commonLog:Lcom/cyjh/elfin/log/CommonLog;

    new-instance v1, Ljava/lang/StringBuilder;

    invoke-direct {v1}, Ljava/lang/StringBuilder;-><init>()V

    const-string v2, "network onErrorMsg,\u5410\u53f8\u4fe1\u606f\uff1a"

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1, p1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v1

    invoke-virtual {v0, v1}, Lcom/cyjh/elfin/log/CommonLog;->e(Ljava/lang/Object;)V

    .line 556
    :cond_1
    :goto_1
    invoke-virtual {p0}, Lcom/cyjh/elfin/fragment/SplashFragment;->getActivity()Landroid/support/v4/app/FragmentActivity;

    move-result-object v0

    invoke-static {v0, p1}, Lcom/cyjh/elfin/util/ToastUtils;->showToastLong(Landroid/content/Context;Ljava/lang/String;)V

    goto/16 :goto_0

    .line 551
    :cond_2
    const-string v0, "11"

    invoke-virtual {p1, v0}, Ljava/lang/String;->startsWith(Ljava/lang/String;)Z

    move-result v0

    if-eqz v0, :cond_1

    iget v0, p0, Lcom/cyjh/elfin/fragment/SplashFragment;->countReq:I

    if-gt v0, v6, :cond_1

    .line 552
    iget-object v0, p0, Lcom/cyjh/elfin/fragment/SplashFragment;->mHandler:Landroid/os/Handler;

    const/16 v1, 0xb

    invoke-virtual {v0, v1}, Landroid/os/Handler;->obtainMessage(I)Landroid/os/Message;

    move-result-object v0

    invoke-virtual {v0}, Landroid/os/Message;->sendToTarget()V

    .line 553
    new-instance v0, Ljava/lang/StringBuilder;

    invoke-direct {v0}, Ljava/lang/StringBuilder;-><init>()V

    invoke-virtual {p0, v7}, Lcom/cyjh/elfin/fragment/SplashFragment;->getString(I)Ljava/lang/String;

    move-result-object v1

    new-array v2, v3, [Ljava/lang/Object;

    iget v3, p0, Lcom/cyjh/elfin/fragment/SplashFragment;->countReq:I

    invoke-static {v3}, Ljava/lang/Integer;->valueOf(I)Ljava/lang/Integer;

    move-result-object v3

    aput-object v3, v2, v4

    invoke-static {v1, v2}, Ljava/lang/String;->format(Ljava/lang/String;[Ljava/lang/Object;)Ljava/lang/String;

    move-result-object v1

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-virtual {p1, v5}, Ljava/lang/String;->substring(I)Ljava/lang/String;

    move-result-object v1

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-virtual {v0}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object p1

    goto :goto_1
.end method

.method public onMessageMainThread(Lcom/cyjh/elfin/entity/MsgItem$CheckedSwitchAdEvent;)V
    .locals 2
    .param p1, "event"    # Lcom/cyjh/elfin/entity/MsgItem$CheckedSwitchAdEvent;
    .annotation runtime Lorg/greenrobot/eventbus/Subscribe;
        threadMode = .enum Lorg/greenrobot/eventbus/ThreadMode;->MAIN:Lorg/greenrobot/eventbus/ThreadMode;
    .end annotation

    .prologue
    .line 321
    const-string v0, "zzz"

    const-string v1, "SplashFragment---onMessageMainThread(MsgItem.CheckedSwitchAdEvent---1"

    invoke-static {v0, v1}, Landroid/util/Log;->e(Ljava/lang/String;Ljava/lang/String;)I

    .line 322
    iget-object v0, p1, Lcom/cyjh/elfin/entity/MsgItem$CheckedSwitchAdEvent;->status:Ljava/lang/String;

    const-string v1, "1"

    invoke-virtual {v0, v1}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v0

    if-eqz v0, :cond_0

    iget-boolean v0, p1, Lcom/cyjh/elfin/entity/MsgItem$CheckedSwitchAdEvent;->isShow:Z

    if-eqz v0, :cond_0

    .line 323
    const-string v0, "zzz"

    const-string v1, "SplashFragment---onMessageMainThread(MsgItem.CheckedSwitchAdEvent---2"

    invoke-static {v0, v1}, Landroid/util/Log;->e(Ljava/lang/String;Ljava/lang/String;)I

    .line 325
    iget-object v0, p0, Lcom/cyjh/elfin/fragment/SplashFragment;->mHandler:Landroid/os/Handler;

    const/16 v1, 0xd

    invoke-virtual {v0, v1}, Landroid/os/Handler;->obtainMessage(I)Landroid/os/Message;

    move-result-object v0

    invoke-virtual {v0}, Landroid/os/Message;->sendToTarget()V

    .line 336
    :goto_0
    return-void

    .line 329
    :cond_0
    const-string v0, "zzz"

    const-string v1, "SplashFragment---onMessageMainThread(MsgItem.CheckedSwitchAdEvent---3"

    invoke-static {v0, v1}, Landroid/util/Log;->e(Ljava/lang/String;Ljava/lang/String;)I

    .line 333
    const/4 v0, 0x1

    iput-boolean v0, p0, Lcom/cyjh/elfin/fragment/SplashFragment;->XunFeiFlag:Z

    .line 334
    iget-object v0, p0, Lcom/cyjh/elfin/fragment/SplashFragment;->mHandler:Landroid/os/Handler;

    const/16 v1, 0x10

    invoke-virtual {v0, v1}, Landroid/os/Handler;->obtainMessage(I)Landroid/os/Message;

    move-result-object v0

    invoke-virtual {v0}, Landroid/os/Message;->sendToTarget()V

    goto :goto_0
.end method

.method public onMessageMainThread(Lcom/cyjh/elfin/entity/MsgItem$GetServerTime;)V
    .locals 13
    .param p1, "serverTime"    # Lcom/cyjh/elfin/entity/MsgItem$GetServerTime;
    .annotation runtime Lorg/greenrobot/eventbus/Subscribe;
        threadMode = .enum Lorg/greenrobot/eventbus/ThreadMode;->MAIN:Lorg/greenrobot/eventbus/ThreadMode;
    .end annotation

    .prologue
    const/16 v12, 0xa

    .line 342
    :try_start_0
    new-instance v3, Lorg/json/JSONObject;

    iget-object v7, p1, Lcom/cyjh/elfin/entity/MsgItem$GetServerTime;->data:Ljava/lang/String;

    invoke-direct {v3, v7}, Lorg/json/JSONObject;-><init>(Ljava/lang/String;)V

    .line 343
    .local v3, "jsonObject":Lorg/json/JSONObject;
    const-string v7, "Code"

    invoke-virtual {v3, v7}, Lorg/json/JSONObject;->getString(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v7

    const-string v8, "0"

    invoke-virtual {v7, v8}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v7

    if-eqz v7, :cond_1

    .line 344
    const-string v7, "Data"

    invoke-virtual {v3, v7}, Lorg/json/JSONObject;->getString(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v0

    .line 345
    .local v0, "dataTime":Ljava/lang/String;
    new-instance v6, Ljava/text/SimpleDateFormat;

    const-string v7, "yyyy-MM-dd HH:mm:ss"

    invoke-direct {v6, v7}, Ljava/text/SimpleDateFormat;-><init>(Ljava/lang/String;)V

    .line 346
    .local v6, "sdf":Ljava/text/SimpleDateFormat;
    invoke-virtual {v6, v0}, Ljava/text/SimpleDateFormat;->parse(Ljava/lang/String;)Ljava/util/Date;

    move-result-object v1

    .line 347
    .local v1, "date":Ljava/util/Date;
    invoke-virtual {v1}, Ljava/util/Date;->getTime()J

    move-result-wide v8

    iput-wide v8, p0, Lcom/cyjh/elfin/fragment/SplashFragment;->saveServerTime:J

    .line 348
    iget-object v7, p0, Lcom/cyjh/elfin/fragment/SplashFragment;->appContext:Lcom/cyjh/elfin/AppContext;

    iget-object v7, v7, Lcom/cyjh/elfin/AppContext;->mSharePre:Landroid/content/SharedPreferences;

    const-string v8, "server_time"

    const-wide/16 v10, 0x0

    invoke-interface {v7, v8, v10, v11}, Landroid/content/SharedPreferences;->getLong(Ljava/lang/String;J)J

    move-result-wide v4

    .line 349
    .local v4, "saveTime":J
    iget-object v7, p0, Lcom/cyjh/elfin/fragment/SplashFragment;->commonLog:Lcom/cyjh/elfin/log/CommonLog;

    new-instance v8, Ljava/lang/StringBuilder;

    invoke-direct {v8}, Ljava/lang/StringBuilder;-><init>()V

    const-string v9, "saverServerTime="

    invoke-virtual {v8, v9}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v8

    iget-wide v10, p0, Lcom/cyjh/elfin/fragment/SplashFragment;->saveServerTime:J

    invoke-virtual {v8, v10, v11}, Ljava/lang/StringBuilder;->append(J)Ljava/lang/StringBuilder;

    move-result-object v8

    const-string v9, ",SaveTime="

    invoke-virtual {v8, v9}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v8

    invoke-virtual {v8, v4, v5}, Ljava/lang/StringBuilder;->append(J)Ljava/lang/StringBuilder;

    move-result-object v8

    invoke-virtual {v8}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v8

    invoke-virtual {v7, v8}, Lcom/cyjh/elfin/log/CommonLog;->e(Ljava/lang/Object;)V

    .line 350
    iget-wide v8, p0, Lcom/cyjh/elfin/fragment/SplashFragment;->saveServerTime:J

    cmp-long v7, v8, v4

    if-ltz v7, :cond_0

    .line 351
    iget-object v7, p0, Lcom/cyjh/elfin/fragment/SplashFragment;->mHandler:Landroid/os/Handler;

    const/16 v8, 0xa

    invoke-virtual {v7, v8}, Landroid/os/Handler;->obtainMessage(I)Landroid/os/Message;

    move-result-object v7

    invoke-virtual {v7}, Landroid/os/Message;->sendToTarget()V

    .line 367
    .end local v0    # "dataTime":Ljava/lang/String;
    .end local v1    # "date":Ljava/util/Date;
    .end local v3    # "jsonObject":Lorg/json/JSONObject;
    .end local v4    # "saveTime":J
    .end local v6    # "sdf":Ljava/text/SimpleDateFormat;
    :goto_0
    return-void

    .line 354
    .restart local v0    # "dataTime":Ljava/lang/String;
    .restart local v1    # "date":Ljava/util/Date;
    .restart local v3    # "jsonObject":Lorg/json/JSONObject;
    .restart local v4    # "saveTime":J
    .restart local v6    # "sdf":Ljava/text/SimpleDateFormat;
    :cond_0
    iget-object v7, p0, Lcom/cyjh/elfin/fragment/SplashFragment;->commonLog:Lcom/cyjh/elfin/log/CommonLog;

    const-string v8, "\u9a8c\u8bc1\u5728\u4e24\u5c0f\u65f6\u4e4b\u5185\uff0c\u5f00\u59cb\u52a0\u8f7d\u8baf\u98de"

    invoke-virtual {v7, v8}, Lcom/cyjh/elfin/log/CommonLog;->e(Ljava/lang/Object;)V

    .line 355
    iget-object v7, p0, Lcom/cyjh/elfin/fragment/SplashFragment;->mHandler:Landroid/os/Handler;

    const/16 v8, 0xe

    invoke-virtual {v7, v8}, Landroid/os/Handler;->obtainMessage(I)Landroid/os/Message;

    move-result-object v7

    invoke-virtual {v7}, Landroid/os/Message;->sendToTarget()V
    :try_end_0
    .catch Lorg/json/JSONException; {:try_start_0 .. :try_end_0} :catch_0
    .catch Ljava/text/ParseException; {:try_start_0 .. :try_end_0} :catch_1

    goto :goto_0

    .line 360
    .end local v0    # "dataTime":Ljava/lang/String;
    .end local v1    # "date":Ljava/util/Date;
    .end local v3    # "jsonObject":Lorg/json/JSONObject;
    .end local v4    # "saveTime":J
    .end local v6    # "sdf":Ljava/text/SimpleDateFormat;
    :catch_0
    move-exception v2

    .line 361
    .local v2, "e":Lorg/json/JSONException;
    invoke-virtual {v2}, Lorg/json/JSONException;->printStackTrace()V

    .line 362
    iget-object v7, p0, Lcom/cyjh/elfin/fragment/SplashFragment;->mHandler:Landroid/os/Handler;

    invoke-virtual {v7, v12}, Landroid/os/Handler;->obtainMessage(I)Landroid/os/Message;

    move-result-object v7

    invoke-virtual {v7}, Landroid/os/Message;->sendToTarget()V

    goto :goto_0

    .line 358
    .end local v2    # "e":Lorg/json/JSONException;
    .restart local v3    # "jsonObject":Lorg/json/JSONObject;
    :cond_1
    :try_start_1
    iget-object v7, p0, Lcom/cyjh/elfin/fragment/SplashFragment;->mHandler:Landroid/os/Handler;

    const/16 v8, 0xa

    invoke-virtual {v7, v8}, Landroid/os/Handler;->obtainMessage(I)Landroid/os/Message;

    move-result-object v7

    invoke-virtual {v7}, Landroid/os/Message;->sendToTarget()V
    :try_end_1
    .catch Lorg/json/JSONException; {:try_start_1 .. :try_end_1} :catch_0
    .catch Ljava/text/ParseException; {:try_start_1 .. :try_end_1} :catch_1

    goto :goto_0

    .line 363
    .end local v3    # "jsonObject":Lorg/json/JSONObject;
    :catch_1
    move-exception v2

    .line 364
    .local v2, "e":Ljava/text/ParseException;
    invoke-virtual {v2}, Ljava/text/ParseException;->printStackTrace()V

    .line 365
    iget-object v7, p0, Lcom/cyjh/elfin/fragment/SplashFragment;->mHandler:Landroid/os/Handler;

    invoke-virtual {v7, v12}, Landroid/os/Handler;->obtainMessage(I)Landroid/os/Message;

    move-result-object v7

    invoke-virtual {v7}, Landroid/os/Message;->sendToTarget()V

    goto :goto_0
.end method

.method public onMessageMainThread(Lcom/cyjh/elfin/entity/MsgItem;)V
    .locals 2
    .param p1, "msgItem"    # Lcom/cyjh/elfin/entity/MsgItem;
    .annotation runtime Lorg/greenrobot/eventbus/Subscribe;
        threadMode = .enum Lorg/greenrobot/eventbus/ThreadMode;->MAIN:Lorg/greenrobot/eventbus/ThreadMode;
    .end annotation

    .prologue
    .line 298
    invoke-virtual {p1}, Lcom/cyjh/elfin/entity/MsgItem;->getMsgType()I

    move-result v0

    packed-switch v0, :pswitch_data_0

    .line 316
    :goto_0
    :pswitch_0
    return-void

    .line 300
    :pswitch_1
    iget-object v0, p0, Lcom/cyjh/elfin/fragment/SplashFragment;->mHandler:Landroid/os/Handler;

    const/16 v1, 0xa

    invoke-virtual {v0, v1}, Landroid/os/Handler;->obtainMessage(I)Landroid/os/Message;

    move-result-object v0

    invoke-virtual {v0}, Landroid/os/Message;->sendToTarget()V

    goto :goto_0

    .line 303
    :pswitch_2
    const-string v0, "zzz"

    const-string v1, "Splash--\u83b7\u53d6\u8baf\u98de\u5f00\u5173\u5931\u8d25"

    invoke-static {v0, v1}, Landroid/util/Log;->e(Ljava/lang/String;Ljava/lang/String;)I

    .line 307
    const/4 v0, 0x1

    iput-boolean v0, p0, Lcom/cyjh/elfin/fragment/SplashFragment;->XunFeiFlag:Z

    .line 308
    iget-object v0, p0, Lcom/cyjh/elfin/fragment/SplashFragment;->mHandler:Landroid/os/Handler;

    const/16 v1, 0x10

    invoke-virtual {v0, v1}, Landroid/os/Handler;->obtainMessage(I)Landroid/os/Message;

    move-result-object v0

    invoke-virtual {v0}, Landroid/os/Message;->sendToTarget()V

    goto :goto_0

    .line 311
    :pswitch_3
    const-string v0, "zzz"

    const-string v1, "Splash--\u540e\u53f0\u8bf7\u6c42\u5e7f\u544a\u5931\u8d25,\u76f4\u63a5\u8df3\u8f6c\u4e3b\u754c\u9762"

    invoke-static {v0, v1}, Landroid/util/Log;->e(Ljava/lang/String;Ljava/lang/String;)I

    .line 312
    invoke-virtual {p0}, Lcom/cyjh/elfin/fragment/SplashFragment;->getActivity()Landroid/support/v4/app/FragmentActivity;

    move-result-object v0

    invoke-static {v0}, Lcom/cyjh/elfin/activity/ElfinFreeActivity;->toCallActivity(Landroid/content/Context;)V

    .line 313
    invoke-virtual {p0}, Lcom/cyjh/elfin/fragment/SplashFragment;->getActivity()Landroid/support/v4/app/FragmentActivity;

    move-result-object v0

    invoke-virtual {v0}, Landroid/support/v4/app/FragmentActivity;->finish()V

    goto :goto_0

    .line 298
    :pswitch_data_0
    .packed-switch 0x3ee
        :pswitch_3
        :pswitch_1
        :pswitch_0
        :pswitch_2
    .end packed-switch
.end method

.method public onPause()V
    .locals 1

    .prologue
    .line 762
    invoke-super {p0}, Lcom/cyjh/elfin/fragment/BaseFragement;->onPause()V

    .line 763
    const-class v0, Lcom/cyjh/elfin/fragment/SplashFragment;

    invoke-virtual {v0}, Ljava/lang/Class;->getCanonicalName()Ljava/lang/String;

    move-result-object v0

    invoke-static {v0}, Lcom/umeng/analytics/MobclickAgent;->onPageEnd(Ljava/lang/String;)V

    .line 764
    return-void
.end method

.method public onResume()V
    .locals 3

    .prologue
    .line 751
    invoke-super {p0}, Lcom/cyjh/elfin/fragment/BaseFragement;->onResume()V

    .line 752
    const-class v0, Lcom/cyjh/elfin/fragment/SplashFragment;

    invoke-virtual {v0}, Ljava/lang/Class;->getCanonicalName()Ljava/lang/String;

    move-result-object v0

    invoke-static {v0}, Lcom/umeng/analytics/MobclickAgent;->onPageStart(Ljava/lang/String;)V

    .line 753
    iget-object v0, p0, Lcom/cyjh/elfin/fragment/SplashFragment;->commonLog:Lcom/cyjh/elfin/log/CommonLog;

    new-instance v1, Ljava/lang/StringBuilder;

    invoke-direct {v1}, Ljava/lang/StringBuilder;-><init>()V

    const-string v2, "onResume()=="

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    iget-boolean v2, p0, Lcom/cyjh/elfin/fragment/SplashFragment;->isClickerFirst:Z

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Z)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v1

    invoke-virtual {v0, v1}, Lcom/cyjh/elfin/log/CommonLog;->e(Ljava/lang/Object;)V

    .line 754
    iget-boolean v0, p0, Lcom/cyjh/elfin/fragment/SplashFragment;->isClickerFirst:Z

    if-eqz v0, :cond_0

    .line 755
    const-string v0, "zzz"

    const-string v1, "SplashFragment---onResume"

    invoke-static {v0, v1}, Landroid/util/Log;->e(Ljava/lang/String;Ljava/lang/String;)I

    .line 756
    iget-object v0, p0, Lcom/cyjh/elfin/fragment/SplashFragment;->mHandler:Landroid/os/Handler;

    const/16 v1, 0xc

    invoke-virtual {v0, v1}, Landroid/os/Handler;->obtainMessage(I)Landroid/os/Message;

    move-result-object v0

    invoke-virtual {v0}, Landroid/os/Message;->sendToTarget()V

    .line 758
    :cond_0
    return-void
.end method

.method public onStop()V
    .locals 2

    .prologue
    .line 768
    invoke-super {p0}, Lcom/cyjh/elfin/fragment/BaseFragement;->onStop()V

    .line 769
    iget-object v0, p0, Lcom/cyjh/elfin/fragment/SplashFragment;->commonLog:Lcom/cyjh/elfin/log/CommonLog;

    const-string v1, "onStop="

    invoke-virtual {v0, v1}, Lcom/cyjh/elfin/log/CommonLog;->e(Ljava/lang/Object;)V

    .line 770
    iget-boolean v0, p0, Lcom/cyjh/elfin/fragment/SplashFragment;->isClickerFirst:Z

    if-eqz v0, :cond_0

    .line 771
    invoke-direct {p0}, Lcom/cyjh/elfin/fragment/SplashFragment;->cancelCloseTimer()V

    .line 772
    iget-object v0, p0, Lcom/cyjh/elfin/fragment/SplashFragment;->mCountRunnable:Lcom/cyjh/elfin/fragment/SplashFragment$CountTimeRunnable;

    if-eqz v0, :cond_0

    .line 773
    iget-object v0, p0, Lcom/cyjh/elfin/fragment/SplashFragment;->mHandler:Landroid/os/Handler;

    iget-object v1, p0, Lcom/cyjh/elfin/fragment/SplashFragment;->mCountRunnable:Lcom/cyjh/elfin/fragment/SplashFragment$CountTimeRunnable;

    invoke-virtual {v0, v1}, Landroid/os/Handler;->removeCallbacks(Ljava/lang/Runnable;)V

    .line 774
    const/4 v0, 0x0

    iput-object v0, p0, Lcom/cyjh/elfin/fragment/SplashFragment;->mCountRunnable:Lcom/cyjh/elfin/fragment/SplashFragment$CountTimeRunnable;

    .line 778
    :cond_0
    return-void
.end method

.method public onViewCreated(Landroid/view/View;Landroid/os/Bundle;)V
    .locals 0
    .param p1, "view"    # Landroid/view/View;
    .param p2, "savedInstanceState"    # Landroid/os/Bundle;

    .prologue
    .line 387
    invoke-super {p0, p1, p2}, Lcom/cyjh/elfin/fragment/BaseFragement;->onViewCreated(Landroid/view/View;Landroid/os/Bundle;)V

    .line 388
    invoke-direct {p0, p1}, Lcom/cyjh/elfin/fragment/SplashFragment;->initView(Landroid/view/View;)V

    .line 389
    return-void
.end method

.method public setBlackListResult(Ljava/lang/String;)V
    .locals 6
    .param p1, "result"    # Ljava/lang/String;

    .prologue
    .line 667
    invoke-static {p1}, Landroid/text/TextUtils;->isEmpty(Ljava/lang/CharSequence;)Z

    move-result v0

    if-nez v0, :cond_0

    .line 669
    iget-object v0, p0, Lcom/cyjh/elfin/fragment/SplashFragment;->appContext:Lcom/cyjh/elfin/AppContext;

    invoke-static {}, Ljava/lang/Math;->random()D

    move-result-wide v2

    const-wide/high16 v4, 0x404e000000000000L    # 60.0

    mul-double/2addr v2, v4

    const-wide/high16 v4, 0x403e000000000000L    # 30.0

    add-double/2addr v2, v4

    double-to-int v1, v2

    iput v1, v0, Lcom/cyjh/elfin/AppContext;->runTime:I

    .line 671
    new-instance v0, Ljava/lang/StringBuilder;

    invoke-direct {v0}, Ljava/lang/StringBuilder;-><init>()V

    const-string v1, "\u8fd0\u884c\u65f6\u95f4\uff1a"

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    iget-object v1, p0, Lcom/cyjh/elfin/fragment/SplashFragment;->appContext:Lcom/cyjh/elfin/AppContext;

    iget v1, v1, Lcom/cyjh/elfin/AppContext;->runTime:I

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-virtual {v0}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v0

    const/4 v1, 0x0

    new-array v1, v1, [Ljava/lang/Object;

    invoke-static {v0, v1}, Lcom/orhanobut/logger/Logger;->e(Ljava/lang/String;[Ljava/lang/Object;)V

    .line 673
    :cond_0
    return-void
.end method
