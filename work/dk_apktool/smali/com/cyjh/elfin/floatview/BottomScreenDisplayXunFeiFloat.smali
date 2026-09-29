.class public Lcom/cyjh/elfin/floatview/BottomScreenDisplayXunFeiFloat;
.super Landroid/widget/RelativeLayout;
.source "BottomScreenDisplayXunFeiFloat.java"


# annotations
.annotation system Ldalvik/annotation/MemberClasses;
    value = {
        Lcom/cyjh/elfin/floatview/BottomScreenDisplayXunFeiFloat$SubmitCountTimer;
    }
.end annotation


# static fields
.field private static final SECONDS_IN_FUTURE:I = 0xa


# instance fields
.field private adDataRef:Lcom/iflytek/voiceads/NativeADDataRef;

.field private context:Landroid/content/Context;

.field private counter:I

.field public isDisplayComplete:Z

.field private mImgAd:Landroid/widget/ImageView;

.field private mNativeAd:Lcom/iflytek/voiceads/IFLYNativeAd;

.field private mNativeListener:Lcom/iflytek/voiceads/IFLYNativeListener;

.field private mRlContainer:Landroid/widget/RelativeLayout;

.field private mSubmitCountTimer:Lcom/cyjh/elfin/floatview/BottomScreenDisplayXunFeiFloat$SubmitCountTimer;

.field private mTvDelete:Landroid/widget/TextView;

.field private mTvILFYAdMark:Landroid/widget/TextView;


# direct methods
.method public constructor <init>(Landroid/content/Context;)V
    .locals 1
    .param p1, "context"    # Landroid/content/Context;

    .prologue
    .line 43
    const/4 v0, 0x0

    invoke-direct {p0, p1, v0}, Lcom/cyjh/elfin/floatview/BottomScreenDisplayXunFeiFloat;-><init>(Landroid/content/Context;Landroid/util/AttributeSet;)V

    .line 44
    return-void
.end method

.method public constructor <init>(Landroid/content/Context;Landroid/util/AttributeSet;)V
    .locals 1
    .param p1, "context"    # Landroid/content/Context;
    .param p2, "attrs"    # Landroid/util/AttributeSet;

    .prologue
    .line 47
    const/4 v0, 0x0

    invoke-direct {p0, p1, p2, v0}, Lcom/cyjh/elfin/floatview/BottomScreenDisplayXunFeiFloat;-><init>(Landroid/content/Context;Landroid/util/AttributeSet;I)V

    .line 48
    return-void
.end method

.method public constructor <init>(Landroid/content/Context;Landroid/util/AttributeSet;I)V
    .locals 2
    .param p1, "context"    # Landroid/content/Context;
    .param p2, "attrs"    # Landroid/util/AttributeSet;
    .param p3, "defStyleAttr"    # I

    .prologue
    const/4 v1, 0x0

    .line 51
    invoke-direct {p0, p1, p2, p3}, Landroid/widget/RelativeLayout;-><init>(Landroid/content/Context;Landroid/util/AttributeSet;I)V

    .line 41
    iput-boolean v1, p0, Lcom/cyjh/elfin/floatview/BottomScreenDisplayXunFeiFloat;->isDisplayComplete:Z

    .line 116
    new-instance v0, Lcom/cyjh/elfin/floatview/BottomScreenDisplayXunFeiFloat$3;

    invoke-direct {v0, p0}, Lcom/cyjh/elfin/floatview/BottomScreenDisplayXunFeiFloat$3;-><init>(Lcom/cyjh/elfin/floatview/BottomScreenDisplayXunFeiFloat;)V

    iput-object v0, p0, Lcom/cyjh/elfin/floatview/BottomScreenDisplayXunFeiFloat;->mNativeListener:Lcom/iflytek/voiceads/IFLYNativeListener;

    .line 155
    iput v1, p0, Lcom/cyjh/elfin/floatview/BottomScreenDisplayXunFeiFloat;->counter:I

    .line 52
    iput-object p1, p0, Lcom/cyjh/elfin/floatview/BottomScreenDisplayXunFeiFloat;->context:Landroid/content/Context;

    .line 53
    invoke-direct {p0}, Lcom/cyjh/elfin/floatview/BottomScreenDisplayXunFeiFloat;->init()V

    .line 54
    return-void
.end method

.method static synthetic access$000(Lcom/cyjh/elfin/floatview/BottomScreenDisplayXunFeiFloat;)V
    .locals 0
    .param p0, "x0"    # Lcom/cyjh/elfin/floatview/BottomScreenDisplayXunFeiFloat;

    .prologue
    .line 38
    invoke-direct {p0}, Lcom/cyjh/elfin/floatview/BottomScreenDisplayXunFeiFloat;->onclickImg()V

    return-void
.end method

.method static synthetic access$100(Lcom/cyjh/elfin/floatview/BottomScreenDisplayXunFeiFloat;)V
    .locals 0
    .param p0, "x0"    # Lcom/cyjh/elfin/floatview/BottomScreenDisplayXunFeiFloat;

    .prologue
    .line 38
    invoke-direct {p0}, Lcom/cyjh/elfin/floatview/BottomScreenDisplayXunFeiFloat;->removeView()V

    return-void
.end method

.method static synthetic access$1000(Lcom/cyjh/elfin/floatview/BottomScreenDisplayXunFeiFloat;)Landroid/content/Context;
    .locals 1
    .param p0, "x0"    # Lcom/cyjh/elfin/floatview/BottomScreenDisplayXunFeiFloat;

    .prologue
    .line 38
    iget-object v0, p0, Lcom/cyjh/elfin/floatview/BottomScreenDisplayXunFeiFloat;->context:Landroid/content/Context;

    return-object v0
.end method

.method static synthetic access$200(Lcom/cyjh/elfin/floatview/BottomScreenDisplayXunFeiFloat;)I
    .locals 1
    .param p0, "x0"    # Lcom/cyjh/elfin/floatview/BottomScreenDisplayXunFeiFloat;

    .prologue
    .line 38
    iget v0, p0, Lcom/cyjh/elfin/floatview/BottomScreenDisplayXunFeiFloat;->counter:I

    return v0
.end method

.method static synthetic access$202(Lcom/cyjh/elfin/floatview/BottomScreenDisplayXunFeiFloat;I)I
    .locals 0
    .param p0, "x0"    # Lcom/cyjh/elfin/floatview/BottomScreenDisplayXunFeiFloat;
    .param p1, "x1"    # I

    .prologue
    .line 38
    iput p1, p0, Lcom/cyjh/elfin/floatview/BottomScreenDisplayXunFeiFloat;->counter:I

    return p1
.end method

.method static synthetic access$208(Lcom/cyjh/elfin/floatview/BottomScreenDisplayXunFeiFloat;)I
    .locals 2
    .param p0, "x0"    # Lcom/cyjh/elfin/floatview/BottomScreenDisplayXunFeiFloat;

    .prologue
    .line 38
    iget v0, p0, Lcom/cyjh/elfin/floatview/BottomScreenDisplayXunFeiFloat;->counter:I

    add-int/lit8 v1, v0, 0x1

    iput v1, p0, Lcom/cyjh/elfin/floatview/BottomScreenDisplayXunFeiFloat;->counter:I

    return v0
.end method

.method static synthetic access$300(Lcom/cyjh/elfin/floatview/BottomScreenDisplayXunFeiFloat;)Lcom/iflytek/voiceads/NativeADDataRef;
    .locals 1
    .param p0, "x0"    # Lcom/cyjh/elfin/floatview/BottomScreenDisplayXunFeiFloat;

    .prologue
    .line 38
    iget-object v0, p0, Lcom/cyjh/elfin/floatview/BottomScreenDisplayXunFeiFloat;->adDataRef:Lcom/iflytek/voiceads/NativeADDataRef;

    return-object v0
.end method

.method static synthetic access$302(Lcom/cyjh/elfin/floatview/BottomScreenDisplayXunFeiFloat;Lcom/iflytek/voiceads/NativeADDataRef;)Lcom/iflytek/voiceads/NativeADDataRef;
    .locals 0
    .param p0, "x0"    # Lcom/cyjh/elfin/floatview/BottomScreenDisplayXunFeiFloat;
    .param p1, "x1"    # Lcom/iflytek/voiceads/NativeADDataRef;

    .prologue
    .line 38
    iput-object p1, p0, Lcom/cyjh/elfin/floatview/BottomScreenDisplayXunFeiFloat;->adDataRef:Lcom/iflytek/voiceads/NativeADDataRef;

    return-object p1
.end method

.method static synthetic access$400(Lcom/cyjh/elfin/floatview/BottomScreenDisplayXunFeiFloat;)Landroid/widget/ImageView;
    .locals 1
    .param p0, "x0"    # Lcom/cyjh/elfin/floatview/BottomScreenDisplayXunFeiFloat;

    .prologue
    .line 38
    iget-object v0, p0, Lcom/cyjh/elfin/floatview/BottomScreenDisplayXunFeiFloat;->mImgAd:Landroid/widget/ImageView;

    return-object v0
.end method

.method static synthetic access$500(Lcom/cyjh/elfin/floatview/BottomScreenDisplayXunFeiFloat;)V
    .locals 0
    .param p0, "x0"    # Lcom/cyjh/elfin/floatview/BottomScreenDisplayXunFeiFloat;

    .prologue
    .line 38
    invoke-direct {p0}, Lcom/cyjh/elfin/floatview/BottomScreenDisplayXunFeiFloat;->startCountTimer()V

    return-void
.end method

.method static synthetic access$600(Lcom/cyjh/elfin/floatview/BottomScreenDisplayXunFeiFloat;)Lcom/iflytek/voiceads/IFLYNativeAd;
    .locals 1
    .param p0, "x0"    # Lcom/cyjh/elfin/floatview/BottomScreenDisplayXunFeiFloat;

    .prologue
    .line 38
    iget-object v0, p0, Lcom/cyjh/elfin/floatview/BottomScreenDisplayXunFeiFloat;->mNativeAd:Lcom/iflytek/voiceads/IFLYNativeAd;

    return-object v0
.end method

.method static synthetic access$700(Lcom/cyjh/elfin/floatview/BottomScreenDisplayXunFeiFloat;)Landroid/widget/TextView;
    .locals 1
    .param p0, "x0"    # Lcom/cyjh/elfin/floatview/BottomScreenDisplayXunFeiFloat;

    .prologue
    .line 38
    iget-object v0, p0, Lcom/cyjh/elfin/floatview/BottomScreenDisplayXunFeiFloat;->mTvDelete:Landroid/widget/TextView;

    return-object v0
.end method

.method static synthetic access$800(Lcom/cyjh/elfin/floatview/BottomScreenDisplayXunFeiFloat;)Landroid/widget/RelativeLayout;
    .locals 1
    .param p0, "x0"    # Lcom/cyjh/elfin/floatview/BottomScreenDisplayXunFeiFloat;

    .prologue
    .line 38
    iget-object v0, p0, Lcom/cyjh/elfin/floatview/BottomScreenDisplayXunFeiFloat;->mRlContainer:Landroid/widget/RelativeLayout;

    return-object v0
.end method

.method static synthetic access$900(Lcom/cyjh/elfin/floatview/BottomScreenDisplayXunFeiFloat;)Landroid/widget/TextView;
    .locals 1
    .param p0, "x0"    # Lcom/cyjh/elfin/floatview/BottomScreenDisplayXunFeiFloat;

    .prologue
    .line 38
    iget-object v0, p0, Lcom/cyjh/elfin/floatview/BottomScreenDisplayXunFeiFloat;->mTvILFYAdMark:Landroid/widget/TextView;

    return-object v0
.end method

.method private init()V
    .locals 2

    .prologue
    .line 63
    iget-object v0, p0, Lcom/cyjh/elfin/floatview/BottomScreenDisplayXunFeiFloat;->context:Landroid/content/Context;

    invoke-static {v0}, Landroid/view/LayoutInflater;->from(Landroid/content/Context;)Landroid/view/LayoutInflater;

    move-result-object v0

    const v1, 0x7f040041

    invoke-virtual {v0, v1, p0}, Landroid/view/LayoutInflater;->inflate(ILandroid/view/ViewGroup;)Landroid/view/View;

    .line 64
    const v0, 0x7f0f00d3

    invoke-virtual {p0, v0}, Lcom/cyjh/elfin/floatview/BottomScreenDisplayXunFeiFloat;->findViewById(I)Landroid/view/View;

    move-result-object v0

    check-cast v0, Landroid/widget/RelativeLayout;

    iput-object v0, p0, Lcom/cyjh/elfin/floatview/BottomScreenDisplayXunFeiFloat;->mRlContainer:Landroid/widget/RelativeLayout;

    .line 65
    const v0, 0x7f0f00d4

    invoke-virtual {p0, v0}, Lcom/cyjh/elfin/floatview/BottomScreenDisplayXunFeiFloat;->findViewById(I)Landroid/view/View;

    move-result-object v0

    check-cast v0, Landroid/widget/ImageView;

    iput-object v0, p0, Lcom/cyjh/elfin/floatview/BottomScreenDisplayXunFeiFloat;->mImgAd:Landroid/widget/ImageView;

    .line 66
    const v0, 0x7f0f00d5

    invoke-virtual {p0, v0}, Lcom/cyjh/elfin/floatview/BottomScreenDisplayXunFeiFloat;->findViewById(I)Landroid/view/View;

    move-result-object v0

    check-cast v0, Landroid/widget/TextView;

    iput-object v0, p0, Lcom/cyjh/elfin/floatview/BottomScreenDisplayXunFeiFloat;->mTvDelete:Landroid/widget/TextView;

    .line 67
    const v0, 0x7f0f00d6

    invoke-virtual {p0, v0}, Lcom/cyjh/elfin/floatview/BottomScreenDisplayXunFeiFloat;->findViewById(I)Landroid/view/View;

    move-result-object v0

    check-cast v0, Landroid/widget/TextView;

    iput-object v0, p0, Lcom/cyjh/elfin/floatview/BottomScreenDisplayXunFeiFloat;->mTvILFYAdMark:Landroid/widget/TextView;

    .line 68
    invoke-direct {p0}, Lcom/cyjh/elfin/floatview/BottomScreenDisplayXunFeiFloat;->initNativeAd()V

    .line 69
    invoke-direct {p0}, Lcom/cyjh/elfin/floatview/BottomScreenDisplayXunFeiFloat;->initEvent()V

    .line 70
    return-void
.end method

.method private initEvent()V
    .locals 2

    .prologue
    .line 73
    iget-object v0, p0, Lcom/cyjh/elfin/floatview/BottomScreenDisplayXunFeiFloat;->mImgAd:Landroid/widget/ImageView;

    new-instance v1, Lcom/cyjh/elfin/floatview/BottomScreenDisplayXunFeiFloat$1;

    invoke-direct {v1, p0}, Lcom/cyjh/elfin/floatview/BottomScreenDisplayXunFeiFloat$1;-><init>(Lcom/cyjh/elfin/floatview/BottomScreenDisplayXunFeiFloat;)V

    invoke-virtual {v0, v1}, Landroid/widget/ImageView;->setOnClickListener(Landroid/view/View$OnClickListener;)V

    .line 87
    iget-object v0, p0, Lcom/cyjh/elfin/floatview/BottomScreenDisplayXunFeiFloat;->mTvDelete:Landroid/widget/TextView;

    new-instance v1, Lcom/cyjh/elfin/floatview/BottomScreenDisplayXunFeiFloat$2;

    invoke-direct {v1, p0}, Lcom/cyjh/elfin/floatview/BottomScreenDisplayXunFeiFloat$2;-><init>(Lcom/cyjh/elfin/floatview/BottomScreenDisplayXunFeiFloat;)V

    invoke-virtual {v0, v1}, Landroid/widget/TextView;->setOnClickListener(Landroid/view/View$OnClickListener;)V

    .line 96
    return-void
.end method

.method private initNativeAd()V
    .locals 4

    .prologue
    .line 109
    const-string v0, "zzz"

    const-string v1, "BottomScreenDisplayXunFei--initNativeAd()-"

    invoke-static {v0, v1}, Landroid/util/Log;->e(Ljava/lang/String;Ljava/lang/String;)I

    .line 110
    iget-object v0, p0, Lcom/cyjh/elfin/floatview/BottomScreenDisplayXunFeiFloat;->mNativeAd:Lcom/iflytek/voiceads/IFLYNativeAd;

    if-nez v0, :cond_0

    .line 111
    new-instance v0, Lcom/iflytek/voiceads/IFLYNativeAd;

    iget-object v1, p0, Lcom/cyjh/elfin/floatview/BottomScreenDisplayXunFeiFloat;->context:Landroid/content/Context;

    const-string v2, "5FF8BF855D9553F32AA0CD1DB70FEDC6"

    iget-object v3, p0, Lcom/cyjh/elfin/floatview/BottomScreenDisplayXunFeiFloat;->mNativeListener:Lcom/iflytek/voiceads/IFLYNativeListener;

    invoke-direct {v0, v1, v2, v3}, Lcom/iflytek/voiceads/IFLYNativeAd;-><init>(Landroid/content/Context;Ljava/lang/String;Lcom/iflytek/voiceads/IFLYNativeListener;)V

    iput-object v0, p0, Lcom/cyjh/elfin/floatview/BottomScreenDisplayXunFeiFloat;->mNativeAd:Lcom/iflytek/voiceads/IFLYNativeAd;

    .line 113
    :cond_0
    iget-object v0, p0, Lcom/cyjh/elfin/floatview/BottomScreenDisplayXunFeiFloat;->mNativeAd:Lcom/iflytek/voiceads/IFLYNativeAd;

    const/4 v1, 0x1

    invoke-virtual {v0, v1}, Lcom/iflytek/voiceads/IFLYNativeAd;->loadAd(I)V

    .line 114
    return-void
.end method

.method private onclickImg()V
    .locals 4

    .prologue
    .line 99
    iget-object v1, p0, Lcom/cyjh/elfin/floatview/BottomScreenDisplayXunFeiFloat;->adDataRef:Lcom/iflytek/voiceads/NativeADDataRef;

    iget-object v2, p0, Lcom/cyjh/elfin/floatview/BottomScreenDisplayXunFeiFloat;->mImgAd:Landroid/widget/ImageView;

    invoke-virtual {v1, v2}, Lcom/iflytek/voiceads/NativeADDataRef;->onClicked(Landroid/view/View;)Z

    .line 100
    iget-object v1, p0, Lcom/cyjh/elfin/floatview/BottomScreenDisplayXunFeiFloat;->adDataRef:Lcom/iflytek/voiceads/NativeADDataRef;

    invoke-virtual {v1}, Lcom/iflytek/voiceads/NativeADDataRef;->getAdtype()Ljava/lang/String;

    move-result-object v0

    .line 101
    .local v0, "adtype":Ljava/lang/String;
    const-string v1, "zzz"

    new-instance v2, Ljava/lang/StringBuilder;

    invoke-direct {v2}, Ljava/lang/StringBuilder;-><init>()V

    const-string v3, "BottomScreenDisplayXunFei--initEvent--"

    invoke-virtual {v2, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    invoke-virtual {v2, v0}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    invoke-virtual {v2}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v2

    invoke-static {v1, v2}, Landroid/util/Log;->e(Ljava/lang/String;Ljava/lang/String;)I

    .line 102
    const-string v1, "redirect"

    invoke-virtual {v1, v0}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v1

    if-eqz v1, :cond_0

    .line 103
    const-string v1, "zzz"

    const-string v2, "BottomScreenDisplayXunFei--initEvent--"

    invoke-static {v1, v2}, Landroid/util/Log;->e(Ljava/lang/String;Ljava/lang/String;)I

    .line 104
    invoke-static {}, Lcom/cyjh/elfin/AppContext;->getInstance()Lcom/cyjh/elfin/AppContext;

    move-result-object v1

    const/4 v2, 0x1

    iput-boolean v2, v1, Lcom/cyjh/elfin/AppContext;->isOnclickXunFei:Z

    .line 106
    :cond_0
    return-void
.end method

.method private removeView()V
    .locals 2

    .prologue
    .line 195
    iget-object v0, p0, Lcom/cyjh/elfin/floatview/BottomScreenDisplayXunFeiFloat;->mSubmitCountTimer:Lcom/cyjh/elfin/floatview/BottomScreenDisplayXunFeiFloat$SubmitCountTimer;

    if-eqz v0, :cond_0

    .line 196
    iget-object v0, p0, Lcom/cyjh/elfin/floatview/BottomScreenDisplayXunFeiFloat;->mSubmitCountTimer:Lcom/cyjh/elfin/floatview/BottomScreenDisplayXunFeiFloat$SubmitCountTimer;

    invoke-virtual {v0}, Lcom/cyjh/elfin/floatview/BottomScreenDisplayXunFeiFloat$SubmitCountTimer;->cancel()V

    .line 197
    const/4 v0, 0x0

    iput-object v0, p0, Lcom/cyjh/elfin/floatview/BottomScreenDisplayXunFeiFloat;->mSubmitCountTimer:Lcom/cyjh/elfin/floatview/BottomScreenDisplayXunFeiFloat$SubmitCountTimer;

    .line 199
    :cond_0
    invoke-static {}, Lcom/cyjh/elfin/AppContext;->getInstance()Lcom/cyjh/elfin/AppContext;

    move-result-object v0

    invoke-virtual {v0}, Lcom/cyjh/elfin/AppContext;->removeBigFloat()V

    .line 200
    iget-object v0, p0, Lcom/cyjh/elfin/floatview/BottomScreenDisplayXunFeiFloat;->mRlContainer:Landroid/widget/RelativeLayout;

    const/16 v1, 0x8

    invoke-virtual {v0, v1}, Landroid/widget/RelativeLayout;->setVisibility(I)V

    .line 201
    return-void
.end method

.method private startCountTimer()V
    .locals 2

    .prologue
    .line 188
    iget-object v0, p0, Lcom/cyjh/elfin/floatview/BottomScreenDisplayXunFeiFloat;->mSubmitCountTimer:Lcom/cyjh/elfin/floatview/BottomScreenDisplayXunFeiFloat$SubmitCountTimer;

    if-nez v0, :cond_0

    .line 189
    new-instance v0, Lcom/cyjh/elfin/floatview/BottomScreenDisplayXunFeiFloat$SubmitCountTimer;

    const/16 v1, 0xa

    invoke-direct {v0, p0, v1}, Lcom/cyjh/elfin/floatview/BottomScreenDisplayXunFeiFloat$SubmitCountTimer;-><init>(Lcom/cyjh/elfin/floatview/BottomScreenDisplayXunFeiFloat;I)V

    iput-object v0, p0, Lcom/cyjh/elfin/floatview/BottomScreenDisplayXunFeiFloat;->mSubmitCountTimer:Lcom/cyjh/elfin/floatview/BottomScreenDisplayXunFeiFloat$SubmitCountTimer;

    .line 191
    :cond_0
    iget-object v0, p0, Lcom/cyjh/elfin/floatview/BottomScreenDisplayXunFeiFloat;->mSubmitCountTimer:Lcom/cyjh/elfin/floatview/BottomScreenDisplayXunFeiFloat$SubmitCountTimer;

    invoke-virtual {v0}, Lcom/cyjh/elfin/floatview/BottomScreenDisplayXunFeiFloat$SubmitCountTimer;->start()Landroid/os/CountDownTimer;

    .line 192
    return-void
.end method
