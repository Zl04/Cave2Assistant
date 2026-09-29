.class public Lcom/cyjh/elfin/floatview/ElfinFloatView;
.super Landroid/widget/LinearLayout;
.source "ElfinFloatView.java"

# interfaces
.implements Landroid/view/View$OnClickListener;


# annotations
.annotation system Ldalvik/annotation/MemberClasses;
    value = {
        Lcom/cyjh/elfin/floatview/ElfinFloatView$ElfinGestureListener;
    }
.end annotation


# static fields
.field private static final ELFIN_ORIENTATION_DOWN:I = 0x3

.field private static final ELFIN_ORIENTATION_LEFT:I = 0x4

.field private static final ELFIN_ORIENTATION_RIGHT:I = 0x2

.field private static final ELFIN_ORIENTATION_UP:I = 0x1

.field private static final LIMIT_ANGLE:I = 0x3c

.field private static final LIMIT_COUNT:I = 0x2

.field private static final TIME_ADSORPTION:I = 0x7d0

.field private static final TIME_INTERVAL:I = 0x3e8

.field private static final TIME_TRANSLUCENT:I = 0x1388


# instance fields
.field private commonLog:Lcom/cyjh/elfin/log/CommonLog;

.field private mAppContext:Lcom/cyjh/elfin/AppContext;

.field private mContext:Landroid/content/Context;

.field private mCountDownTimer:Landroid/os/CountDownTimer;

.field private mDeleteFloatView:Lcom/cyjh/elfin/floatview/DeleteFloatView;

.field private mDownX:F

.field private mDownY:F

.field private mImageViewElfin:Landroid/widget/ImageView;

.field public mImgRunAndStop:Landroid/widget/ImageView;

.field private mLastX:F

.field private mLastY:F

.field private mLinearLayoutElfin:Landroid/widget/LinearLayout;

.field private mLinearLayoutInfo:Landroid/widget/LinearLayout;

.field private mLinearLayoutRun:Landroid/widget/LinearLayout;

.field private mLinearLayoutSetting:Landroid/widget/LinearLayout;

.field private mLinearLayoutTools:Landroid/widget/LinearLayout;

.field private mLockState:I

.field private mRawCurrentX:F

.field private mRawCurrentY:F

.field private mScriptRTDDialog:Lcom/cyjh/elfin/dialog/ScriptRTDDialog;

.field private mScriptUIDialog:Lcom/cyjh/elfin/dialog/ScriptUIDialog;

.field public mTvRunScript:Landroid/widget/TextView;

.field private mWindowManager:Landroid/view/WindowManager;

.field private mWindowManagerParams:Landroid/view/WindowManager$LayoutParams;

.field private onHideCancelClickListener:Lcom/cyjh/elfin/dialog/HideFWDialog$OnHideCancelClickListener;

.field private onHideOKClickListener:Lcom/cyjh/elfin/dialog/HideFWDialog$OnHideOKClickListener;

.field private final onTouchListener:Landroid/view/View$OnTouchListener;


# direct methods
.method public constructor <init>(Landroid/content/Context;Lcom/cyjh/elfin/floatview/DeleteFloatView;)V
    .locals 6
    .param p1, "context"    # Landroid/content/Context;
    .param p2, "deleteFloatView"    # Lcom/cyjh/elfin/floatview/DeleteFloatView;

    .prologue
    .line 119
    invoke-direct {p0, p1}, Landroid/widget/LinearLayout;-><init>(Landroid/content/Context;)V

    .line 47
    new-instance v0, Lcom/cyjh/elfin/log/CommonLog;

    invoke-direct {v0}, Lcom/cyjh/elfin/log/CommonLog;-><init>()V

    iput-object v0, p0, Lcom/cyjh/elfin/floatview/ElfinFloatView;->commonLog:Lcom/cyjh/elfin/log/CommonLog;

    .line 205
    new-instance v0, Lcom/cyjh/elfin/floatview/ElfinFloatView$1;

    const-wide/16 v2, 0x1b58

    const-wide/16 v4, 0x3e8

    move-object v1, p0

    invoke-direct/range {v0 .. v5}, Lcom/cyjh/elfin/floatview/ElfinFloatView$1;-><init>(Lcom/cyjh/elfin/floatview/ElfinFloatView;JJ)V

    iput-object v0, p0, Lcom/cyjh/elfin/floatview/ElfinFloatView;->mCountDownTimer:Landroid/os/CountDownTimer;

    .line 441
    new-instance v0, Lcom/cyjh/elfin/floatview/ElfinFloatView$2;

    invoke-direct {v0, p0}, Lcom/cyjh/elfin/floatview/ElfinFloatView$2;-><init>(Lcom/cyjh/elfin/floatview/ElfinFloatView;)V

    iput-object v0, p0, Lcom/cyjh/elfin/floatview/ElfinFloatView;->onTouchListener:Landroid/view/View$OnTouchListener;

    .line 602
    new-instance v0, Lcom/cyjh/elfin/floatview/ElfinFloatView$3;

    invoke-direct {v0, p0}, Lcom/cyjh/elfin/floatview/ElfinFloatView$3;-><init>(Lcom/cyjh/elfin/floatview/ElfinFloatView;)V

    iput-object v0, p0, Lcom/cyjh/elfin/floatview/ElfinFloatView;->onHideOKClickListener:Lcom/cyjh/elfin/dialog/HideFWDialog$OnHideOKClickListener;

    .line 610
    new-instance v0, Lcom/cyjh/elfin/floatview/ElfinFloatView$4;

    invoke-direct {v0, p0}, Lcom/cyjh/elfin/floatview/ElfinFloatView$4;-><init>(Lcom/cyjh/elfin/floatview/ElfinFloatView;)V

    iput-object v0, p0, Lcom/cyjh/elfin/floatview/ElfinFloatView;->onHideCancelClickListener:Lcom/cyjh/elfin/dialog/HideFWDialog$OnHideCancelClickListener;

    .line 120
    check-cast p1, Lcom/cyjh/elfin/AppContext;

    .end local p1    # "context":Landroid/content/Context;
    iput-object p1, p0, Lcom/cyjh/elfin/floatview/ElfinFloatView;->mAppContext:Lcom/cyjh/elfin/AppContext;

    .line 121
    invoke-direct {p0}, Lcom/cyjh/elfin/floatview/ElfinFloatView;->initView()V

    .line 122
    invoke-direct {p0}, Lcom/cyjh/elfin/floatview/ElfinFloatView;->initWindow()V

    .line 123
    iput-object p2, p0, Lcom/cyjh/elfin/floatview/ElfinFloatView;->mDeleteFloatView:Lcom/cyjh/elfin/floatview/DeleteFloatView;

    .line 124
    iget-object v0, p0, Lcom/cyjh/elfin/floatview/ElfinFloatView;->mCountDownTimer:Landroid/os/CountDownTimer;

    invoke-virtual {v0}, Landroid/os/CountDownTimer;->start()Landroid/os/CountDownTimer;

    .line 130
    return-void
.end method

.method static synthetic access$000(Lcom/cyjh/elfin/floatview/ElfinFloatView;)Landroid/widget/ImageView;
    .locals 1
    .param p0, "x0"    # Lcom/cyjh/elfin/floatview/ElfinFloatView;

    .prologue
    .line 46
    iget-object v0, p0, Lcom/cyjh/elfin/floatview/ElfinFloatView;->mImageViewElfin:Landroid/widget/ImageView;

    return-object v0
.end method

.method static synthetic access$100(Lcom/cyjh/elfin/floatview/ElfinFloatView;)F
    .locals 1
    .param p0, "x0"    # Lcom/cyjh/elfin/floatview/ElfinFloatView;

    .prologue
    .line 46
    iget v0, p0, Lcom/cyjh/elfin/floatview/ElfinFloatView;->mDownX:F

    return v0
.end method

.method static synthetic access$1000(Lcom/cyjh/elfin/floatview/ElfinFloatView;)F
    .locals 1
    .param p0, "x0"    # Lcom/cyjh/elfin/floatview/ElfinFloatView;

    .prologue
    .line 46
    iget v0, p0, Lcom/cyjh/elfin/floatview/ElfinFloatView;->mLastY:F

    return v0
.end method

.method static synthetic access$1002(Lcom/cyjh/elfin/floatview/ElfinFloatView;F)F
    .locals 0
    .param p0, "x0"    # Lcom/cyjh/elfin/floatview/ElfinFloatView;
    .param p1, "x1"    # F

    .prologue
    .line 46
    iput p1, p0, Lcom/cyjh/elfin/floatview/ElfinFloatView;->mLastY:F

    return p1
.end method

.method static synthetic access$102(Lcom/cyjh/elfin/floatview/ElfinFloatView;F)F
    .locals 0
    .param p0, "x0"    # Lcom/cyjh/elfin/floatview/ElfinFloatView;
    .param p1, "x1"    # F

    .prologue
    .line 46
    iput p1, p0, Lcom/cyjh/elfin/floatview/ElfinFloatView;->mDownX:F

    return p1
.end method

.method static synthetic access$1100(Lcom/cyjh/elfin/floatview/ElfinFloatView;I)V
    .locals 0
    .param p0, "x0"    # Lcom/cyjh/elfin/floatview/ElfinFloatView;
    .param p1, "x1"    # I

    .prologue
    .line 46
    invoke-direct {p0, p1}, Lcom/cyjh/elfin/floatview/ElfinFloatView;->updateFloatViewDirection(I)V

    return-void
.end method

.method static synthetic access$1200(Lcom/cyjh/elfin/floatview/ElfinFloatView;)Lcom/cyjh/elfin/floatview/DeleteFloatView;
    .locals 1
    .param p0, "x0"    # Lcom/cyjh/elfin/floatview/ElfinFloatView;

    .prologue
    .line 46
    iget-object v0, p0, Lcom/cyjh/elfin/floatview/ElfinFloatView;->mDeleteFloatView:Lcom/cyjh/elfin/floatview/DeleteFloatView;

    return-object v0
.end method

.method static synthetic access$1300(Lcom/cyjh/elfin/floatview/ElfinFloatView;)Z
    .locals 1
    .param p0, "x0"    # Lcom/cyjh/elfin/floatview/ElfinFloatView;

    .prologue
    .line 46
    invoke-direct {p0}, Lcom/cyjh/elfin/floatview/ElfinFloatView;->isHide()Z

    move-result v0

    return v0
.end method

.method static synthetic access$1400(Lcom/cyjh/elfin/floatview/ElfinFloatView;)Lcom/cyjh/elfin/dialog/HideFWDialog$OnHideOKClickListener;
    .locals 1
    .param p0, "x0"    # Lcom/cyjh/elfin/floatview/ElfinFloatView;

    .prologue
    .line 46
    iget-object v0, p0, Lcom/cyjh/elfin/floatview/ElfinFloatView;->onHideOKClickListener:Lcom/cyjh/elfin/dialog/HideFWDialog$OnHideOKClickListener;

    return-object v0
.end method

.method static synthetic access$1500(Lcom/cyjh/elfin/floatview/ElfinFloatView;)Lcom/cyjh/elfin/dialog/HideFWDialog$OnHideCancelClickListener;
    .locals 1
    .param p0, "x0"    # Lcom/cyjh/elfin/floatview/ElfinFloatView;

    .prologue
    .line 46
    iget-object v0, p0, Lcom/cyjh/elfin/floatview/ElfinFloatView;->onHideCancelClickListener:Lcom/cyjh/elfin/dialog/HideFWDialog$OnHideCancelClickListener;

    return-object v0
.end method

.method static synthetic access$1600(Lcom/cyjh/elfin/floatview/ElfinFloatView;)V
    .locals 0
    .param p0, "x0"    # Lcom/cyjh/elfin/floatview/ElfinFloatView;

    .prologue
    .line 46
    invoke-direct {p0}, Lcom/cyjh/elfin/floatview/ElfinFloatView;->moveToEdge()V

    return-void
.end method

.method static synthetic access$1700(Lcom/cyjh/elfin/floatview/ElfinFloatView;)Landroid/os/CountDownTimer;
    .locals 1
    .param p0, "x0"    # Lcom/cyjh/elfin/floatview/ElfinFloatView;

    .prologue
    .line 46
    iget-object v0, p0, Lcom/cyjh/elfin/floatview/ElfinFloatView;->mCountDownTimer:Landroid/os/CountDownTimer;

    return-object v0
.end method

.method static synthetic access$200(Lcom/cyjh/elfin/floatview/ElfinFloatView;)Lcom/cyjh/elfin/AppContext;
    .locals 1
    .param p0, "x0"    # Lcom/cyjh/elfin/floatview/ElfinFloatView;

    .prologue
    .line 46
    iget-object v0, p0, Lcom/cyjh/elfin/floatview/ElfinFloatView;->mAppContext:Lcom/cyjh/elfin/AppContext;

    return-object v0
.end method

.method static synthetic access$400(Lcom/cyjh/elfin/floatview/ElfinFloatView;)V
    .locals 0
    .param p0, "x0"    # Lcom/cyjh/elfin/floatview/ElfinFloatView;

    .prologue
    .line 46
    invoke-direct {p0}, Lcom/cyjh/elfin/floatview/ElfinFloatView;->resetElfinState()V

    return-void
.end method

.method static synthetic access$500(Lcom/cyjh/elfin/floatview/ElfinFloatView;)F
    .locals 1
    .param p0, "x0"    # Lcom/cyjh/elfin/floatview/ElfinFloatView;

    .prologue
    .line 46
    iget v0, p0, Lcom/cyjh/elfin/floatview/ElfinFloatView;->mRawCurrentX:F

    return v0
.end method

.method static synthetic access$502(Lcom/cyjh/elfin/floatview/ElfinFloatView;F)F
    .locals 0
    .param p0, "x0"    # Lcom/cyjh/elfin/floatview/ElfinFloatView;
    .param p1, "x1"    # F

    .prologue
    .line 46
    iput p1, p0, Lcom/cyjh/elfin/floatview/ElfinFloatView;->mRawCurrentX:F

    return p1
.end method

.method static synthetic access$600(Lcom/cyjh/elfin/floatview/ElfinFloatView;)F
    .locals 1
    .param p0, "x0"    # Lcom/cyjh/elfin/floatview/ElfinFloatView;

    .prologue
    .line 46
    iget v0, p0, Lcom/cyjh/elfin/floatview/ElfinFloatView;->mRawCurrentY:F

    return v0
.end method

.method static synthetic access$602(Lcom/cyjh/elfin/floatview/ElfinFloatView;F)F
    .locals 0
    .param p0, "x0"    # Lcom/cyjh/elfin/floatview/ElfinFloatView;
    .param p1, "x1"    # F

    .prologue
    .line 46
    iput p1, p0, Lcom/cyjh/elfin/floatview/ElfinFloatView;->mRawCurrentY:F

    return p1
.end method

.method static synthetic access$700(Lcom/cyjh/elfin/floatview/ElfinFloatView;)F
    .locals 1
    .param p0, "x0"    # Lcom/cyjh/elfin/floatview/ElfinFloatView;

    .prologue
    .line 46
    iget v0, p0, Lcom/cyjh/elfin/floatview/ElfinFloatView;->mDownY:F

    return v0
.end method

.method static synthetic access$702(Lcom/cyjh/elfin/floatview/ElfinFloatView;F)F
    .locals 0
    .param p0, "x0"    # Lcom/cyjh/elfin/floatview/ElfinFloatView;
    .param p1, "x1"    # F

    .prologue
    .line 46
    iput p1, p0, Lcom/cyjh/elfin/floatview/ElfinFloatView;->mDownY:F

    return p1
.end method

.method static synthetic access$800(Lcom/cyjh/elfin/floatview/ElfinFloatView;)Landroid/widget/LinearLayout;
    .locals 1
    .param p0, "x0"    # Lcom/cyjh/elfin/floatview/ElfinFloatView;

    .prologue
    .line 46
    iget-object v0, p0, Lcom/cyjh/elfin/floatview/ElfinFloatView;->mLinearLayoutTools:Landroid/widget/LinearLayout;

    return-object v0
.end method

.method static synthetic access$900(Lcom/cyjh/elfin/floatview/ElfinFloatView;)F
    .locals 1
    .param p0, "x0"    # Lcom/cyjh/elfin/floatview/ElfinFloatView;

    .prologue
    .line 46
    iget v0, p0, Lcom/cyjh/elfin/floatview/ElfinFloatView;->mLastX:F

    return v0
.end method

.method static synthetic access$902(Lcom/cyjh/elfin/floatview/ElfinFloatView;F)F
    .locals 0
    .param p0, "x0"    # Lcom/cyjh/elfin/floatview/ElfinFloatView;
    .param p1, "x1"    # F

    .prologue
    .line 46
    iput p1, p0, Lcom/cyjh/elfin/floatview/ElfinFloatView;->mLastX:F

    return p1
.end method

.method private initElfinImageView()V
    .locals 3

    .prologue
    .line 155
    const v0, 0x7f0f00e7

    invoke-virtual {p0, v0}, Lcom/cyjh/elfin/floatview/ElfinFloatView;->findViewById(I)Landroid/view/View;

    move-result-object v0

    check-cast v0, Landroid/widget/ImageView;

    iput-object v0, p0, Lcom/cyjh/elfin/floatview/ElfinFloatView;->mImageViewElfin:Landroid/widget/ImageView;

    .line 157
    iget-object v0, p0, Lcom/cyjh/elfin/floatview/ElfinFloatView;->mAppContext:Lcom/cyjh/elfin/AppContext;

    iget v0, v0, Lcom/cyjh/elfin/AppContext;->STATE_SCRIPT:I

    const/4 v1, 0x2

    if-ne v0, v1, :cond_0

    .line 158
    iget-object v0, p0, Lcom/cyjh/elfin/floatview/ElfinFloatView;->mImageViewElfin:Landroid/widget/ImageView;

    const v1, 0x7f02007b

    invoke-virtual {v0, v1}, Landroid/widget/ImageView;->setImageResource(I)V

    .line 159
    iget-object v0, p0, Lcom/cyjh/elfin/floatview/ElfinFloatView;->mTvRunScript:Landroid/widget/TextView;

    invoke-virtual {p0}, Lcom/cyjh/elfin/floatview/ElfinFloatView;->getContext()Landroid/content/Context;

    move-result-object v1

    const v2, 0x7f080077

    invoke-virtual {v1, v2}, Landroid/content/Context;->getString(I)Ljava/lang/String;

    move-result-object v1

    invoke-virtual {v0, v1}, Landroid/widget/TextView;->setText(Ljava/lang/CharSequence;)V

    .line 160
    iget-object v0, p0, Lcom/cyjh/elfin/floatview/ElfinFloatView;->mImgRunAndStop:Landroid/widget/ImageView;

    const v1, 0x7f02008c

    invoke-virtual {v0, v1}, Landroid/widget/ImageView;->setImageResource(I)V

    .line 166
    :goto_0
    iget-object v0, p0, Lcom/cyjh/elfin/floatview/ElfinFloatView;->mImageViewElfin:Landroid/widget/ImageView;

    const/4 v1, 0x0

    invoke-virtual {v0, v1}, Landroid/widget/ImageView;->setOnClickListener(Landroid/view/View$OnClickListener;)V

    .line 167
    iget-object v0, p0, Lcom/cyjh/elfin/floatview/ElfinFloatView;->mImageViewElfin:Landroid/widget/ImageView;

    iget-object v1, p0, Lcom/cyjh/elfin/floatview/ElfinFloatView;->onTouchListener:Landroid/view/View$OnTouchListener;

    invoke-virtual {v0, v1}, Landroid/widget/ImageView;->setOnTouchListener(Landroid/view/View$OnTouchListener;)V

    .line 168
    return-void

    .line 162
    :cond_0
    iget-object v0, p0, Lcom/cyjh/elfin/floatview/ElfinFloatView;->mImageViewElfin:Landroid/widget/ImageView;

    const v1, 0x7f02006e

    invoke-virtual {v0, v1}, Landroid/widget/ImageView;->setImageResource(I)V

    .line 163
    iget-object v0, p0, Lcom/cyjh/elfin/floatview/ElfinFloatView;->mTvRunScript:Landroid/widget/TextView;

    invoke-virtual {p0}, Lcom/cyjh/elfin/floatview/ElfinFloatView;->getContext()Landroid/content/Context;

    move-result-object v1

    const v2, 0x7f080075

    invoke-virtual {v1, v2}, Landroid/content/Context;->getString(I)Ljava/lang/String;

    move-result-object v1

    invoke-virtual {v0, v1}, Landroid/widget/TextView;->setText(Ljava/lang/CharSequence;)V

    .line 164
    iget-object v0, p0, Lcom/cyjh/elfin/floatview/ElfinFloatView;->mImgRunAndStop:Landroid/widget/ImageView;

    const v1, 0x7f02008a

    invoke-virtual {v0, v1}, Landroid/widget/ImageView;->setImageResource(I)V

    goto :goto_0
.end method

.method private initView()V
    .locals 2

    .prologue
    .line 133
    invoke-virtual {p0}, Lcom/cyjh/elfin/floatview/ElfinFloatView;->getContext()Landroid/content/Context;

    move-result-object v0

    invoke-static {v0}, Landroid/view/LayoutInflater;->from(Landroid/content/Context;)Landroid/view/LayoutInflater;

    move-result-object v0

    const v1, 0x7f040043

    invoke-virtual {v0, v1, p0}, Landroid/view/LayoutInflater;->inflate(ILandroid/view/ViewGroup;)Landroid/view/View;

    .line 135
    const v0, 0x7f0f00de

    invoke-virtual {p0, v0}, Lcom/cyjh/elfin/floatview/ElfinFloatView;->findViewById(I)Landroid/view/View;

    move-result-object v0

    check-cast v0, Landroid/widget/LinearLayout;

    iput-object v0, p0, Lcom/cyjh/elfin/floatview/ElfinFloatView;->mLinearLayoutElfin:Landroid/widget/LinearLayout;

    .line 136
    const v0, 0x7f0f00df

    invoke-virtual {p0, v0}, Lcom/cyjh/elfin/floatview/ElfinFloatView;->findViewById(I)Landroid/view/View;

    move-result-object v0

    check-cast v0, Landroid/widget/LinearLayout;

    iput-object v0, p0, Lcom/cyjh/elfin/floatview/ElfinFloatView;->mLinearLayoutTools:Landroid/widget/LinearLayout;

    .line 138
    const v0, 0x7f0f00e0

    invoke-virtual {p0, v0}, Lcom/cyjh/elfin/floatview/ElfinFloatView;->findViewById(I)Landroid/view/View;

    move-result-object v0

    check-cast v0, Landroid/widget/LinearLayout;

    iput-object v0, p0, Lcom/cyjh/elfin/floatview/ElfinFloatView;->mLinearLayoutRun:Landroid/widget/LinearLayout;

    .line 139
    const v0, 0x7f0f00e3

    invoke-virtual {p0, v0}, Lcom/cyjh/elfin/floatview/ElfinFloatView;->findViewById(I)Landroid/view/View;

    move-result-object v0

    check-cast v0, Landroid/widget/LinearLayout;

    iput-object v0, p0, Lcom/cyjh/elfin/floatview/ElfinFloatView;->mLinearLayoutInfo:Landroid/widget/LinearLayout;

    .line 140
    const v0, 0x7f0f00e5

    invoke-virtual {p0, v0}, Lcom/cyjh/elfin/floatview/ElfinFloatView;->findViewById(I)Landroid/view/View;

    move-result-object v0

    check-cast v0, Landroid/widget/LinearLayout;

    iput-object v0, p0, Lcom/cyjh/elfin/floatview/ElfinFloatView;->mLinearLayoutSetting:Landroid/widget/LinearLayout;

    .line 143
    const v0, 0x7f0f00e2

    invoke-virtual {p0, v0}, Lcom/cyjh/elfin/floatview/ElfinFloatView;->findViewById(I)Landroid/view/View;

    move-result-object v0

    check-cast v0, Landroid/widget/TextView;

    iput-object v0, p0, Lcom/cyjh/elfin/floatview/ElfinFloatView;->mTvRunScript:Landroid/widget/TextView;

    .line 144
    const v0, 0x7f0f00e1

    invoke-virtual {p0, v0}, Lcom/cyjh/elfin/floatview/ElfinFloatView;->findViewById(I)Landroid/view/View;

    move-result-object v0

    check-cast v0, Landroid/widget/ImageView;

    iput-object v0, p0, Lcom/cyjh/elfin/floatview/ElfinFloatView;->mImgRunAndStop:Landroid/widget/ImageView;

    .line 146
    iget-object v0, p0, Lcom/cyjh/elfin/floatview/ElfinFloatView;->mLinearLayoutRun:Landroid/widget/LinearLayout;

    invoke-virtual {v0, p0}, Landroid/widget/LinearLayout;->setOnClickListener(Landroid/view/View$OnClickListener;)V

    .line 147
    iget-object v0, p0, Lcom/cyjh/elfin/floatview/ElfinFloatView;->mLinearLayoutInfo:Landroid/widget/LinearLayout;

    invoke-virtual {v0, p0}, Landroid/widget/LinearLayout;->setOnClickListener(Landroid/view/View$OnClickListener;)V

    .line 148
    iget-object v0, p0, Lcom/cyjh/elfin/floatview/ElfinFloatView;->mLinearLayoutSetting:Landroid/widget/LinearLayout;

    invoke-virtual {v0, p0}, Landroid/widget/LinearLayout;->setOnClickListener(Landroid/view/View$OnClickListener;)V

    .line 151
    invoke-direct {p0}, Lcom/cyjh/elfin/floatview/ElfinFloatView;->initElfinImageView()V

    .line 152
    return-void
.end method

.method private initWindow()V
    .locals 3

    .prologue
    .line 171
    invoke-virtual {p0}, Lcom/cyjh/elfin/floatview/ElfinFloatView;->getContext()Landroid/content/Context;

    move-result-object v0

    const-string v1, "window"

    invoke-virtual {v0, v1}, Landroid/content/Context;->getSystemService(Ljava/lang/String;)Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Landroid/view/WindowManager;

    iput-object v0, p0, Lcom/cyjh/elfin/floatview/ElfinFloatView;->mWindowManager:Landroid/view/WindowManager;

    .line 172
    new-instance v0, Landroid/view/WindowManager$LayoutParams;

    invoke-direct {v0}, Landroid/view/WindowManager$LayoutParams;-><init>()V

    iput-object v0, p0, Lcom/cyjh/elfin/floatview/ElfinFloatView;->mWindowManagerParams:Landroid/view/WindowManager$LayoutParams;

    .line 175
    sget v0, Landroid/os/Build$VERSION;->SDK_INT:I

    const/16 v1, 0x13

    if-lt v0, v1, :cond_0

    sget v0, Landroid/os/Build$VERSION;->SDK_INT:I

    const/16 v1, 0x18

    if-ge v0, v1, :cond_0

    .line 177
    iget-object v0, p0, Lcom/cyjh/elfin/floatview/ElfinFloatView;->mWindowManagerParams:Landroid/view/WindowManager$LayoutParams;

    const/16 v1, 0x7d5

    iput v1, v0, Landroid/view/WindowManager$LayoutParams;->type:I

    .line 182
    :goto_0
    iget-object v0, p0, Lcom/cyjh/elfin/floatview/ElfinFloatView;->mWindowManagerParams:Landroid/view/WindowManager$LayoutParams;

    const/4 v1, 0x1

    iput v1, v0, Landroid/view/WindowManager$LayoutParams;->format:I

    .line 183
    iget-object v0, p0, Lcom/cyjh/elfin/floatview/ElfinFloatView;->mWindowManagerParams:Landroid/view/WindowManager$LayoutParams;

    const/16 v1, 0x28

    iput v1, v0, Landroid/view/WindowManager$LayoutParams;->flags:I

    .line 185
    iget-object v0, p0, Lcom/cyjh/elfin/floatview/ElfinFloatView;->mWindowManagerParams:Landroid/view/WindowManager$LayoutParams;

    const/16 v1, 0x33

    iput v1, v0, Landroid/view/WindowManager$LayoutParams;->gravity:I

    .line 187
    iget-object v0, p0, Lcom/cyjh/elfin/floatview/ElfinFloatView;->mWindowManagerParams:Landroid/view/WindowManager$LayoutParams;

    invoke-virtual {p0}, Lcom/cyjh/elfin/floatview/ElfinFloatView;->getContext()Landroid/content/Context;

    move-result-object v1

    invoke-static {v1}, Lcom/cyjh/elfin/util/AppDeviceUtils;->getResolution(Landroid/content/Context;)Landroid/graphics/Point;

    move-result-object v1

    iget v1, v1, Landroid/graphics/Point;->x:I

    iget-object v2, p0, Lcom/cyjh/elfin/floatview/ElfinFloatView;->mLinearLayoutElfin:Landroid/widget/LinearLayout;

    invoke-virtual {v2}, Landroid/widget/LinearLayout;->getLayoutParams()Landroid/view/ViewGroup$LayoutParams;

    move-result-object v2

    iget v2, v2, Landroid/view/ViewGroup$LayoutParams;->width:I

    sub-int/2addr v1, v2

    iput v1, v0, Landroid/view/WindowManager$LayoutParams;->x:I

    .line 188
    iget-object v0, p0, Lcom/cyjh/elfin/floatview/ElfinFloatView;->mWindowManagerParams:Landroid/view/WindowManager$LayoutParams;

    invoke-virtual {p0}, Lcom/cyjh/elfin/floatview/ElfinFloatView;->getContext()Landroid/content/Context;

    move-result-object v1

    invoke-static {v1}, Lcom/cyjh/elfin/util/AppDeviceUtils;->getResolution(Landroid/content/Context;)Landroid/graphics/Point;

    move-result-object v1

    iget v1, v1, Landroid/graphics/Point;->y:I

    div-int/lit8 v1, v1, 0x4

    iput v1, v0, Landroid/view/WindowManager$LayoutParams;->y:I

    .line 189
    invoke-virtual {p0}, Lcom/cyjh/elfin/floatview/ElfinFloatView;->getContext()Landroid/content/Context;

    move-result-object v0

    invoke-static {v0}, Lcom/cyjh/elfin/util/AppDeviceUtils;->getResolution(Landroid/content/Context;)Landroid/graphics/Point;

    move-result-object v0

    iget v0, v0, Landroid/graphics/Point;->y:I

    div-int/lit8 v0, v0, 0x4

    int-to-float v0, v0

    iput v0, p0, Lcom/cyjh/elfin/floatview/ElfinFloatView;->mRawCurrentY:F

    .line 192
    iget-object v0, p0, Lcom/cyjh/elfin/floatview/ElfinFloatView;->mWindowManagerParams:Landroid/view/WindowManager$LayoutParams;

    iget-object v1, p0, Lcom/cyjh/elfin/floatview/ElfinFloatView;->mLinearLayoutElfin:Landroid/widget/LinearLayout;

    invoke-virtual {v1}, Landroid/widget/LinearLayout;->getLayoutParams()Landroid/view/ViewGroup$LayoutParams;

    move-result-object v1

    iget v1, v1, Landroid/view/ViewGroup$LayoutParams;->width:I

    iput v1, v0, Landroid/view/WindowManager$LayoutParams;->width:I

    .line 193
    iget-object v0, p0, Lcom/cyjh/elfin/floatview/ElfinFloatView;->mWindowManagerParams:Landroid/view/WindowManager$LayoutParams;

    iget-object v1, p0, Lcom/cyjh/elfin/floatview/ElfinFloatView;->mLinearLayoutElfin:Landroid/widget/LinearLayout;

    invoke-virtual {v1}, Landroid/widget/LinearLayout;->getLayoutParams()Landroid/view/ViewGroup$LayoutParams;

    move-result-object v1

    iget v1, v1, Landroid/view/ViewGroup$LayoutParams;->height:I

    iput v1, v0, Landroid/view/WindowManager$LayoutParams;->height:I

    .line 195
    return-void

    .line 180
    :cond_0
    iget-object v0, p0, Lcom/cyjh/elfin/floatview/ElfinFloatView;->mWindowManagerParams:Landroid/view/WindowManager$LayoutParams;

    const/16 v1, 0x7d2

    iput v1, v0, Landroid/view/WindowManager$LayoutParams;->type:I

    goto :goto_0
.end method

.method private isHide()Z
    .locals 7

    .prologue
    const/4 v5, 0x2

    const/4 v2, 0x1

    const/4 v3, 0x0

    .line 356
    new-array v1, v5, [I

    .line 357
    .local v1, "elfinOnScreenLocation":[I
    iget-object v4, p0, Lcom/cyjh/elfin/floatview/ElfinFloatView;->mImageViewElfin:Landroid/widget/ImageView;

    invoke-virtual {v4, v1}, Landroid/widget/ImageView;->getLocationOnScreen([I)V

    .line 358
    new-array v0, v5, [I

    .line 359
    .local v0, "deleteOnScreenLocation":[I
    iget-object v4, p0, Lcom/cyjh/elfin/floatview/ElfinFloatView;->mDeleteFloatView:Lcom/cyjh/elfin/floatview/DeleteFloatView;

    invoke-virtual {v4, v0}, Lcom/cyjh/elfin/floatview/DeleteFloatView;->getLocationOnScreen([I)V

    .line 360
    aget v4, v1, v3

    aget v5, v0, v3

    if-le v4, v5, :cond_0

    aget v4, v1, v3

    aget v5, v0, v3

    iget-object v6, p0, Lcom/cyjh/elfin/floatview/ElfinFloatView;->mDeleteFloatView:Lcom/cyjh/elfin/floatview/DeleteFloatView;

    .line 361
    invoke-virtual {v6}, Lcom/cyjh/elfin/floatview/DeleteFloatView;->geTextViewtWidth()I

    move-result v6

    add-int/2addr v5, v6

    if-ge v4, v5, :cond_0

    aget v4, v1, v2

    aget v5, v0, v2

    if-le v4, v5, :cond_0

    .line 366
    :goto_0
    return v2

    :cond_0
    move v2, v3

    goto :goto_0
.end method

.method private moveToEdge()V
    .locals 6

    .prologue
    const/4 v5, 0x2

    const/4 v4, 0x0

    .line 249
    iget-object v1, p0, Lcom/cyjh/elfin/floatview/ElfinFloatView;->mDeleteFloatView:Lcom/cyjh/elfin/floatview/DeleteFloatView;

    invoke-virtual {v1}, Lcom/cyjh/elfin/floatview/DeleteFloatView;->getVisibility()I

    move-result v1

    if-nez v1, :cond_0

    .line 250
    iget-object v1, p0, Lcom/cyjh/elfin/floatview/ElfinFloatView;->mDeleteFloatView:Lcom/cyjh/elfin/floatview/DeleteFloatView;

    const/16 v2, 0x8

    invoke-virtual {v1, v2}, Lcom/cyjh/elfin/floatview/DeleteFloatView;->setVisibility(I)V

    .line 251
    iget-object v1, p0, Lcom/cyjh/elfin/floatview/ElfinFloatView;->mDeleteFloatView:Lcom/cyjh/elfin/floatview/DeleteFloatView;

    invoke-virtual {v1}, Lcom/cyjh/elfin/floatview/DeleteFloatView;->setNormal()V

    .line 253
    :cond_0
    new-array v0, v5, [I

    .line 254
    .local v0, "onScreenLocation":[I
    iget-object v1, p0, Lcom/cyjh/elfin/floatview/ElfinFloatView;->mImageViewElfin:Landroid/widget/ImageView;

    invoke-virtual {v1, v0}, Landroid/widget/ImageView;->getLocationOnScreen([I)V

    .line 255
    aget v1, v0, v4

    int-to-float v1, v1

    invoke-virtual {p0}, Lcom/cyjh/elfin/floatview/ElfinFloatView;->getContext()Landroid/content/Context;

    move-result-object v2

    invoke-static {v2}, Lcom/cyjh/elfin/util/AppDeviceUtils;->getResolution(Landroid/content/Context;)Landroid/graphics/Point;

    move-result-object v2

    iget v2, v2, Landroid/graphics/Point;->x:I

    int-to-float v2, v2

    iget v3, p0, Lcom/cyjh/elfin/floatview/ElfinFloatView;->mDownX:F

    sub-float/2addr v2, v3

    const/high16 v3, 0x40000000    # 2.0f

    div-float/2addr v2, v3

    cmpl-float v1, v1, v2

    if-ltz v1, :cond_1

    .line 256
    invoke-virtual {p0}, Lcom/cyjh/elfin/floatview/ElfinFloatView;->getContext()Landroid/content/Context;

    move-result-object v1

    invoke-static {v1}, Lcom/cyjh/elfin/util/AppDeviceUtils;->getResolution(Landroid/content/Context;)Landroid/graphics/Point;

    move-result-object v1

    iget v1, v1, Landroid/graphics/Point;->x:I

    iget v2, p0, Lcom/cyjh/elfin/floatview/ElfinFloatView;->mRawCurrentY:F

    iget v3, p0, Lcom/cyjh/elfin/floatview/ElfinFloatView;->mDownY:F

    sub-float/2addr v2, v3

    float-to-int v2, v2

    invoke-virtual {p0, v1, v2}, Lcom/cyjh/elfin/floatview/ElfinFloatView;->updateFloatViewPosition(II)V

    .line 257
    iget-object v1, p0, Lcom/cyjh/elfin/floatview/ElfinFloatView;->mLinearLayoutElfin:Landroid/widget/LinearLayout;

    iget-object v2, p0, Lcom/cyjh/elfin/floatview/ElfinFloatView;->mLinearLayoutTools:Landroid/widget/LinearLayout;

    invoke-virtual {v1, v2}, Landroid/widget/LinearLayout;->removeView(Landroid/view/View;)V

    .line 258
    iget-object v1, p0, Lcom/cyjh/elfin/floatview/ElfinFloatView;->mLinearLayoutElfin:Landroid/widget/LinearLayout;

    iget-object v2, p0, Lcom/cyjh/elfin/floatview/ElfinFloatView;->mLinearLayoutTools:Landroid/widget/LinearLayout;

    invoke-virtual {v1, v2, v4}, Landroid/widget/LinearLayout;->addView(Landroid/view/View;I)V

    .line 264
    :goto_0
    iget-object v1, p0, Lcom/cyjh/elfin/floatview/ElfinFloatView;->mAppContext:Lcom/cyjh/elfin/AppContext;

    iget v1, v1, Lcom/cyjh/elfin/AppContext;->STATE_SCRIPT:I

    if-ne v1, v5, :cond_2

    .line 265
    iget-object v1, p0, Lcom/cyjh/elfin/floatview/ElfinFloatView;->mImageViewElfin:Landroid/widget/ImageView;

    const v2, 0x7f02007b

    invoke-virtual {v1, v2}, Landroid/widget/ImageView;->setImageResource(I)V

    .line 270
    :goto_1
    return-void

    .line 260
    :cond_1
    iget v1, p0, Lcom/cyjh/elfin/floatview/ElfinFloatView;->mRawCurrentY:F

    iget v2, p0, Lcom/cyjh/elfin/floatview/ElfinFloatView;->mDownY:F

    sub-float/2addr v1, v2

    float-to-int v1, v1

    invoke-virtual {p0, v4, v1}, Lcom/cyjh/elfin/floatview/ElfinFloatView;->updateFloatViewPosition(II)V

    .line 261
    iget-object v1, p0, Lcom/cyjh/elfin/floatview/ElfinFloatView;->mLinearLayoutElfin:Landroid/widget/LinearLayout;

    iget-object v2, p0, Lcom/cyjh/elfin/floatview/ElfinFloatView;->mLinearLayoutTools:Landroid/widget/LinearLayout;

    invoke-virtual {v1, v2}, Landroid/widget/LinearLayout;->removeView(Landroid/view/View;)V

    .line 262
    iget-object v1, p0, Lcom/cyjh/elfin/floatview/ElfinFloatView;->mLinearLayoutElfin:Landroid/widget/LinearLayout;

    iget-object v2, p0, Lcom/cyjh/elfin/floatview/ElfinFloatView;->mLinearLayoutTools:Landroid/widget/LinearLayout;

    const/4 v3, 0x1

    invoke-virtual {v1, v2, v3}, Landroid/widget/LinearLayout;->addView(Landroid/view/View;I)V

    goto :goto_0

    .line 267
    :cond_2
    iget-object v1, p0, Lcom/cyjh/elfin/floatview/ElfinFloatView;->mImageViewElfin:Landroid/widget/ImageView;

    const v2, 0x7f02006e

    invoke-virtual {v1, v2}, Landroid/widget/ImageView;->setImageResource(I)V

    goto :goto_1
.end method

.method private resetElfinState()V
    .locals 2

    .prologue
    .line 346
    iget-object v0, p0, Lcom/cyjh/elfin/floatview/ElfinFloatView;->mCountDownTimer:Landroid/os/CountDownTimer;

    invoke-virtual {v0}, Landroid/os/CountDownTimer;->cancel()V

    .line 347
    iget-object v0, p0, Lcom/cyjh/elfin/floatview/ElfinFloatView;->mImageViewElfin:Landroid/widget/ImageView;

    const/high16 v1, 0x3f800000    # 1.0f

    invoke-virtual {v0, v1}, Landroid/widget/ImageView;->setAlpha(F)V

    .line 348
    return-void
.end method

.method private updateFloatViewDirection(I)V
    .locals 2
    .param p1, "elfinDirection"    # I

    .prologue
    const/4 v1, 0x2

    .line 276
    packed-switch p1, :pswitch_data_0

    .line 309
    :goto_0
    return-void

    .line 278
    :pswitch_0
    iget-object v0, p0, Lcom/cyjh/elfin/floatview/ElfinFloatView;->mAppContext:Lcom/cyjh/elfin/AppContext;

    iget v0, v0, Lcom/cyjh/elfin/AppContext;->STATE_SCRIPT:I

    if-ne v0, v1, :cond_0

    .line 279
    iget-object v0, p0, Lcom/cyjh/elfin/floatview/ElfinFloatView;->mImageViewElfin:Landroid/widget/ImageView;

    const v1, 0x7f02007b

    invoke-virtual {v0, v1}, Landroid/widget/ImageView;->setImageResource(I)V

    goto :goto_0

    .line 281
    :cond_0
    iget-object v0, p0, Lcom/cyjh/elfin/floatview/ElfinFloatView;->mImageViewElfin:Landroid/widget/ImageView;

    const v1, 0x7f02006e

    invoke-virtual {v0, v1}, Landroid/widget/ImageView;->setImageResource(I)V

    goto :goto_0

    .line 285
    :pswitch_1
    iget-object v0, p0, Lcom/cyjh/elfin/floatview/ElfinFloatView;->mAppContext:Lcom/cyjh/elfin/AppContext;

    iget v0, v0, Lcom/cyjh/elfin/AppContext;->STATE_SCRIPT:I

    if-ne v0, v1, :cond_1

    .line 286
    iget-object v0, p0, Lcom/cyjh/elfin/floatview/ElfinFloatView;->mImageViewElfin:Landroid/widget/ImageView;

    const v1, 0x7f020083

    invoke-virtual {v0, v1}, Landroid/widget/ImageView;->setImageResource(I)V

    goto :goto_0

    .line 288
    :cond_1
    iget-object v0, p0, Lcom/cyjh/elfin/floatview/ElfinFloatView;->mImageViewElfin:Landroid/widget/ImageView;

    const v1, 0x7f02007a

    invoke-virtual {v0, v1}, Landroid/widget/ImageView;->setImageResource(I)V

    goto :goto_0

    .line 292
    :pswitch_2
    iget-object v0, p0, Lcom/cyjh/elfin/floatview/ElfinFloatView;->mAppContext:Lcom/cyjh/elfin/AppContext;

    iget v0, v0, Lcom/cyjh/elfin/AppContext;->STATE_SCRIPT:I

    if-ne v0, v1, :cond_2

    .line 293
    iget-object v0, p0, Lcom/cyjh/elfin/floatview/ElfinFloatView;->mImageViewElfin:Landroid/widget/ImageView;

    const v1, 0x7f02007f

    invoke-virtual {v0, v1}, Landroid/widget/ImageView;->setImageResource(I)V

    goto :goto_0

    .line 295
    :cond_2
    iget-object v0, p0, Lcom/cyjh/elfin/floatview/ElfinFloatView;->mImageViewElfin:Landroid/widget/ImageView;

    const v1, 0x7f020072

    invoke-virtual {v0, v1}, Landroid/widget/ImageView;->setImageResource(I)V

    goto :goto_0

    .line 299
    :pswitch_3
    iget-object v0, p0, Lcom/cyjh/elfin/floatview/ElfinFloatView;->mAppContext:Lcom/cyjh/elfin/AppContext;

    iget v0, v0, Lcom/cyjh/elfin/AppContext;->STATE_SCRIPT:I

    if-ne v0, v1, :cond_3

    .line 300
    iget-object v0, p0, Lcom/cyjh/elfin/floatview/ElfinFloatView;->mImageViewElfin:Landroid/widget/ImageView;

    const v1, 0x7f020081

    invoke-virtual {v0, v1}, Landroid/widget/ImageView;->setImageResource(I)V

    goto :goto_0

    .line 302
    :cond_3
    iget-object v0, p0, Lcom/cyjh/elfin/floatview/ElfinFloatView;->mImageViewElfin:Landroid/widget/ImageView;

    const v1, 0x7f020076

    invoke-virtual {v0, v1}, Landroid/widget/ImageView;->setImageResource(I)V

    goto :goto_0

    .line 276
    nop

    :pswitch_data_0
    .packed-switch 0x1
        :pswitch_0
        :pswitch_1
        :pswitch_2
        :pswitch_3
    .end packed-switch
.end method


# virtual methods
.method public changeToolBarState(Z)V
    .locals 2
    .param p1, "isVisible"    # Z

    .prologue
    const/16 v1, 0x8

    .line 330
    const/4 v0, 0x1

    invoke-direct {p0, v0}, Lcom/cyjh/elfin/floatview/ElfinFloatView;->updateFloatViewDirection(I)V

    .line 331
    if-eqz p1, :cond_1

    .line 332
    iget-object v0, p0, Lcom/cyjh/elfin/floatview/ElfinFloatView;->mLinearLayoutTools:Landroid/widget/LinearLayout;

    invoke-virtual {v0}, Landroid/widget/LinearLayout;->getVisibility()I

    move-result v0

    if-ne v0, v1, :cond_0

    .line 333
    iget-object v0, p0, Lcom/cyjh/elfin/floatview/ElfinFloatView;->mLinearLayoutTools:Landroid/widget/LinearLayout;

    const/4 v1, 0x0

    invoke-virtual {v0, v1}, Landroid/widget/LinearLayout;->setVisibility(I)V

    .line 340
    :cond_0
    :goto_0
    return-void

    .line 336
    :cond_1
    iget-object v0, p0, Lcom/cyjh/elfin/floatview/ElfinFloatView;->mLinearLayoutTools:Landroid/widget/LinearLayout;

    invoke-virtual {v0}, Landroid/widget/LinearLayout;->getVisibility()I

    move-result v0

    if-nez v0, :cond_0

    .line 337
    iget-object v0, p0, Lcom/cyjh/elfin/floatview/ElfinFloatView;->mLinearLayoutTools:Landroid/widget/LinearLayout;

    invoke-virtual {v0, v1}, Landroid/widget/LinearLayout;->setVisibility(I)V

    goto :goto_0
.end method

.method public bridge synthetic getLayoutParams()Landroid/view/ViewGroup$LayoutParams;
    .locals 1

    .prologue
    .line 46
    invoke-virtual {p0}, Lcom/cyjh/elfin/floatview/ElfinFloatView;->getLayoutParams()Landroid/view/WindowManager$LayoutParams;

    move-result-object v0

    return-object v0
.end method

.method public getLayoutParams()Landroid/view/WindowManager$LayoutParams;
    .locals 1

    .prologue
    .line 199
    iget-object v0, p0, Lcom/cyjh/elfin/floatview/ElfinFloatView;->mWindowManagerParams:Landroid/view/WindowManager$LayoutParams;

    return-object v0
.end method

.method public getmContext()Landroid/content/Context;
    .locals 1

    .prologue
    .line 644
    iget-object v0, p0, Lcom/cyjh/elfin/floatview/ElfinFloatView;->mContext:Landroid/content/Context;

    return-object v0
.end method

.method public onClick(Landroid/view/View;)V
    .locals 2
    .param p1, "v"    # Landroid/view/View;

    .prologue
    .line 384
    invoke-direct {p0}, Lcom/cyjh/elfin/floatview/ElfinFloatView;->resetElfinState()V

    .line 385
    invoke-virtual {p1}, Landroid/view/View;->getId()I

    move-result v0

    packed-switch v0, :pswitch_data_0

    .line 438
    :cond_0
    :goto_0
    :pswitch_0
    iget-object v0, p0, Lcom/cyjh/elfin/floatview/ElfinFloatView;->mCountDownTimer:Landroid/os/CountDownTimer;

    invoke-virtual {v0}, Landroid/os/CountDownTimer;->start()Landroid/os/CountDownTimer;

    .line 439
    return-void

    .line 387
    :pswitch_1
    invoke-static {}, Lcom/cyjh/mobileanjian/ipc/MqRunner;->getInstance()Lcom/cyjh/mobileanjian/ipc/MqRunner;

    move-result-object v0

    invoke-virtual {v0}, Lcom/cyjh/mobileanjian/ipc/MqRunner;->isScriptStarted()Z

    move-result v0

    if-eqz v0, :cond_1

    .line 388
    invoke-static {}, Lcom/cyjh/mobileanjian/ipc/MqRunner;->getInstance()Lcom/cyjh/mobileanjian/ipc/MqRunner;

    move-result-object v0

    invoke-virtual {v0}, Lcom/cyjh/mobileanjian/ipc/MqRunner;->stop()V

    goto :goto_0

    .line 390
    :cond_1
    iget-object v0, p0, Lcom/cyjh/elfin/floatview/ElfinFloatView;->mAppContext:Lcom/cyjh/elfin/AppContext;

    iget v0, v0, Lcom/cyjh/elfin/AppContext;->STATE_SCRIPT:I

    const/4 v1, 0x1

    if-ne v0, v1, :cond_0

    .line 392
    iget-object v0, p0, Lcom/cyjh/elfin/floatview/ElfinFloatView;->mAppContext:Lcom/cyjh/elfin/AppContext;

    invoke-virtual {v0}, Lcom/cyjh/elfin/AppContext;->runScript()V

    goto :goto_0

    .line 423
    :pswitch_2
    new-instance v0, Lcom/cyjh/elfin/dialog/ScriptRTDDialog;

    invoke-virtual {p0}, Lcom/cyjh/elfin/floatview/ElfinFloatView;->getContext()Landroid/content/Context;

    move-result-object v1

    invoke-direct {v0, v1}, Lcom/cyjh/elfin/dialog/ScriptRTDDialog;-><init>(Landroid/content/Context;)V

    iput-object v0, p0, Lcom/cyjh/elfin/floatview/ElfinFloatView;->mScriptRTDDialog:Lcom/cyjh/elfin/dialog/ScriptRTDDialog;

    .line 424
    iget-object v0, p0, Lcom/cyjh/elfin/floatview/ElfinFloatView;->mScriptRTDDialog:Lcom/cyjh/elfin/dialog/ScriptRTDDialog;

    invoke-virtual {v0}, Lcom/cyjh/elfin/dialog/ScriptRTDDialog;->show()V

    goto :goto_0

    .line 427
    :pswitch_3
    new-instance v0, Lcom/cyjh/elfin/dialog/ScriptUIDialog;

    invoke-virtual {p0}, Lcom/cyjh/elfin/floatview/ElfinFloatView;->getContext()Landroid/content/Context;

    move-result-object v1

    invoke-direct {v0, v1}, Lcom/cyjh/elfin/dialog/ScriptUIDialog;-><init>(Landroid/content/Context;)V

    iput-object v0, p0, Lcom/cyjh/elfin/floatview/ElfinFloatView;->mScriptUIDialog:Lcom/cyjh/elfin/dialog/ScriptUIDialog;

    .line 428
    iget-object v0, p0, Lcom/cyjh/elfin/floatview/ElfinFloatView;->mScriptUIDialog:Lcom/cyjh/elfin/dialog/ScriptUIDialog;

    iget-object v1, p0, Lcom/cyjh/elfin/floatview/ElfinFloatView;->mContext:Landroid/content/Context;

    iput-object v1, v0, Lcom/cyjh/elfin/dialog/ScriptUIDialog;->mContext:Landroid/content/Context;

    .line 429
    iget-object v0, p0, Lcom/cyjh/elfin/floatview/ElfinFloatView;->mScriptUIDialog:Lcom/cyjh/elfin/dialog/ScriptUIDialog;

    invoke-virtual {v0}, Lcom/cyjh/elfin/dialog/ScriptUIDialog;->show()V

    goto :goto_0

    .line 385
    nop

    :pswitch_data_0
    .packed-switch 0x7f0f00e0
        :pswitch_1
        :pswitch_0
        :pswitch_0
        :pswitch_2
        :pswitch_0
        :pswitch_3
    .end packed-switch
.end method

.method public posContorlbar(FI)V
    .locals 3
    .param p1, "postion"    # F
    .param p2, "lockState"    # I

    .prologue
    .line 622
    iget-object v0, p0, Lcom/cyjh/elfin/floatview/ElfinFloatView;->commonLog:Lcom/cyjh/elfin/log/CommonLog;

    new-instance v1, Ljava/lang/StringBuilder;

    invoke-direct {v1}, Ljava/lang/StringBuilder;-><init>()V

    const-string v2, "postion>>>"

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1, p1}, Ljava/lang/StringBuilder;->append(F)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v1

    invoke-virtual {v0, v1}, Lcom/cyjh/elfin/log/CommonLog;->e(Ljava/lang/Object;)V

    .line 623
    iput p2, p0, Lcom/cyjh/elfin/floatview/ElfinFloatView;->mLockState:I

    .line 625
    iget v0, p0, Lcom/cyjh/elfin/floatview/ElfinFloatView;->mLockState:I

    if-eqz v0, :cond_0

    .line 626
    iget-object v0, p0, Lcom/cyjh/elfin/floatview/ElfinFloatView;->mImageViewElfin:Landroid/widget/ImageView;

    const/4 v1, 0x0

    invoke-virtual {v0, v1}, Landroid/widget/ImageView;->setOnTouchListener(Landroid/view/View$OnTouchListener;)V

    .line 628
    :cond_0
    iget-object v0, p0, Lcom/cyjh/elfin/floatview/ElfinFloatView;->mDeleteFloatView:Lcom/cyjh/elfin/floatview/DeleteFloatView;

    invoke-virtual {v0}, Lcom/cyjh/elfin/floatview/DeleteFloatView;->getVisibility()I

    move-result v0

    if-nez v0, :cond_1

    .line 629
    iget-object v0, p0, Lcom/cyjh/elfin/floatview/ElfinFloatView;->mDeleteFloatView:Lcom/cyjh/elfin/floatview/DeleteFloatView;

    const/16 v1, 0x8

    invoke-virtual {v0, v1}, Lcom/cyjh/elfin/floatview/DeleteFloatView;->setVisibility(I)V

    .line 630
    iget-object v0, p0, Lcom/cyjh/elfin/floatview/ElfinFloatView;->mDeleteFloatView:Lcom/cyjh/elfin/floatview/DeleteFloatView;

    invoke-virtual {v0}, Lcom/cyjh/elfin/floatview/DeleteFloatView;->setNormal()V

    .line 632
    :cond_1
    invoke-virtual {p0}, Lcom/cyjh/elfin/floatview/ElfinFloatView;->getContext()Landroid/content/Context;

    move-result-object v0

    invoke-static {v0}, Lcom/cyjh/elfin/util/AppDeviceUtils;->getResolution(Landroid/content/Context;)Landroid/graphics/Point;

    move-result-object v0

    iget v0, v0, Landroid/graphics/Point;->x:I

    .line 633
    invoke-virtual {p0}, Lcom/cyjh/elfin/floatview/ElfinFloatView;->getContext()Landroid/content/Context;

    move-result-object v1

    invoke-static {v1}, Lcom/cyjh/elfin/util/AppDeviceUtils;->getResolution(Landroid/content/Context;)Landroid/graphics/Point;

    move-result-object v1

    iget v1, v1, Landroid/graphics/Point;->y:I

    int-to-float v1, v1

    mul-float/2addr v1, p1

    invoke-virtual {p0}, Lcom/cyjh/elfin/floatview/ElfinFloatView;->getHeight()I

    move-result v2

    int-to-float v2, v2

    sub-float/2addr v1, v2

    float-to-int v1, v1

    .line 632
    invoke-virtual {p0, v0, v1}, Lcom/cyjh/elfin/floatview/ElfinFloatView;->updateFloatViewPosition(II)V

    .line 634
    iget-object v0, p0, Lcom/cyjh/elfin/floatview/ElfinFloatView;->mLinearLayoutElfin:Landroid/widget/LinearLayout;

    iget-object v1, p0, Lcom/cyjh/elfin/floatview/ElfinFloatView;->mLinearLayoutTools:Landroid/widget/LinearLayout;

    invoke-virtual {v0, v1}, Landroid/widget/LinearLayout;->removeView(Landroid/view/View;)V

    .line 635
    iget-object v0, p0, Lcom/cyjh/elfin/floatview/ElfinFloatView;->mLinearLayoutElfin:Landroid/widget/LinearLayout;

    iget-object v1, p0, Lcom/cyjh/elfin/floatview/ElfinFloatView;->mLinearLayoutTools:Landroid/widget/LinearLayout;

    const/4 v2, 0x0

    invoke-virtual {v0, v1, v2}, Landroid/widget/LinearLayout;->addView(Landroid/view/View;I)V

    .line 636
    iget-object v0, p0, Lcom/cyjh/elfin/floatview/ElfinFloatView;->mAppContext:Lcom/cyjh/elfin/AppContext;

    iget v0, v0, Lcom/cyjh/elfin/AppContext;->STATE_SCRIPT:I

    const/4 v1, 0x2

    if-ne v0, v1, :cond_2

    .line 637
    iget-object v0, p0, Lcom/cyjh/elfin/floatview/ElfinFloatView;->mImageViewElfin:Landroid/widget/ImageView;

    const v1, 0x7f02007b

    invoke-virtual {v0, v1}, Landroid/widget/ImageView;->setImageResource(I)V

    .line 641
    :goto_0
    return-void

    .line 639
    :cond_2
    iget-object v0, p0, Lcom/cyjh/elfin/floatview/ElfinFloatView;->mImageViewElfin:Landroid/widget/ImageView;

    const v1, 0x7f02006e

    invoke-virtual {v0, v1}, Landroid/widget/ImageView;->setImageResource(I)V

    goto :goto_0
.end method

.method public rotateScreen()V
    .locals 3

    .prologue
    .line 373
    invoke-direct {p0}, Lcom/cyjh/elfin/floatview/ElfinFloatView;->resetElfinState()V

    .line 374
    iget-object v0, p0, Lcom/cyjh/elfin/floatview/ElfinFloatView;->mCountDownTimer:Landroid/os/CountDownTimer;

    invoke-virtual {v0}, Landroid/os/CountDownTimer;->start()Landroid/os/CountDownTimer;

    .line 375
    const/4 v0, 0x1

    invoke-direct {p0, v0}, Lcom/cyjh/elfin/floatview/ElfinFloatView;->updateFloatViewDirection(I)V

    .line 376
    iget-object v0, p0, Lcom/cyjh/elfin/floatview/ElfinFloatView;->mWindowManagerParams:Landroid/view/WindowManager$LayoutParams;

    invoke-virtual {p0}, Lcom/cyjh/elfin/floatview/ElfinFloatView;->getContext()Landroid/content/Context;

    move-result-object v1

    invoke-static {v1}, Lcom/cyjh/elfin/util/AppDeviceUtils;->getResolution(Landroid/content/Context;)Landroid/graphics/Point;

    move-result-object v1

    iget v1, v1, Landroid/graphics/Point;->x:I

    iget-object v2, p0, Lcom/cyjh/elfin/floatview/ElfinFloatView;->mLinearLayoutElfin:Landroid/widget/LinearLayout;

    invoke-virtual {v2}, Landroid/widget/LinearLayout;->getLayoutParams()Landroid/view/ViewGroup$LayoutParams;

    move-result-object v2

    iget v2, v2, Landroid/view/ViewGroup$LayoutParams;->width:I

    sub-int/2addr v1, v2

    iput v1, v0, Landroid/view/WindowManager$LayoutParams;->x:I

    .line 377
    iget-object v0, p0, Lcom/cyjh/elfin/floatview/ElfinFloatView;->mWindowManagerParams:Landroid/view/WindowManager$LayoutParams;

    invoke-virtual {p0}, Lcom/cyjh/elfin/floatview/ElfinFloatView;->getContext()Landroid/content/Context;

    move-result-object v1

    invoke-static {v1}, Lcom/cyjh/elfin/util/AppDeviceUtils;->getResolution(Landroid/content/Context;)Landroid/graphics/Point;

    move-result-object v1

    iget v1, v1, Landroid/graphics/Point;->y:I

    div-int/lit8 v1, v1, 0x4

    iput v1, v0, Landroid/view/WindowManager$LayoutParams;->y:I

    .line 378
    iget-object v0, p0, Lcom/cyjh/elfin/floatview/ElfinFloatView;->mWindowManager:Landroid/view/WindowManager;

    iget-object v1, p0, Lcom/cyjh/elfin/floatview/ElfinFloatView;->mWindowManagerParams:Landroid/view/WindowManager$LayoutParams;

    invoke-interface {v0, p0, v1}, Landroid/view/WindowManager;->updateViewLayout(Landroid/view/View;Landroid/view/ViewGroup$LayoutParams;)V

    .line 379
    iget-object v0, p0, Lcom/cyjh/elfin/floatview/ElfinFloatView;->mDeleteFloatView:Lcom/cyjh/elfin/floatview/DeleteFloatView;

    invoke-virtual {v0}, Lcom/cyjh/elfin/floatview/DeleteFloatView;->rotateScreen()V

    .line 380
    return-void
.end method

.method public setImageViewElfinTouchListener()V
    .locals 2

    .prologue
    .line 653
    iget-object v0, p0, Lcom/cyjh/elfin/floatview/ElfinFloatView;->mImageViewElfin:Landroid/widget/ImageView;

    iget-object v1, p0, Lcom/cyjh/elfin/floatview/ElfinFloatView;->onTouchListener:Landroid/view/View$OnTouchListener;

    invoke-virtual {v0, v1}, Landroid/widget/ImageView;->setOnTouchListener(Landroid/view/View$OnTouchListener;)V

    .line 654
    return-void
.end method

.method public setmContext(Landroid/content/Context;)V
    .locals 0
    .param p1, "mContext"    # Landroid/content/Context;

    .prologue
    .line 648
    iput-object p1, p0, Lcom/cyjh/elfin/floatview/ElfinFloatView;->mContext:Landroid/content/Context;

    .line 649
    return-void
.end method

.method public toggleElfinVisbility()V
    .locals 3

    .prologue
    const/16 v1, 0x8

    const/4 v2, 0x0

    .line 540
    invoke-direct {p0}, Lcom/cyjh/elfin/floatview/ElfinFloatView;->resetElfinState()V

    .line 541
    invoke-virtual {p0}, Lcom/cyjh/elfin/floatview/ElfinFloatView;->getVisibility()I

    move-result v0

    if-nez v0, :cond_0

    .line 542
    invoke-virtual {p0, v2}, Lcom/cyjh/elfin/floatview/ElfinFloatView;->changeToolBarState(Z)V

    .line 543
    iget-object v0, p0, Lcom/cyjh/elfin/floatview/ElfinFloatView;->mDeleteFloatView:Lcom/cyjh/elfin/floatview/DeleteFloatView;

    invoke-virtual {v0, v1}, Lcom/cyjh/elfin/floatview/DeleteFloatView;->setVisibility(I)V

    .line 544
    invoke-virtual {p0, v1}, Lcom/cyjh/elfin/floatview/ElfinFloatView;->setVisibility(I)V

    .line 550
    :goto_0
    return-void

    .line 546
    :cond_0
    iget-object v0, p0, Lcom/cyjh/elfin/floatview/ElfinFloatView;->mCountDownTimer:Landroid/os/CountDownTimer;

    invoke-virtual {v0}, Landroid/os/CountDownTimer;->start()Landroid/os/CountDownTimer;

    .line 547
    invoke-virtual {p0}, Lcom/cyjh/elfin/floatview/ElfinFloatView;->getContext()Landroid/content/Context;

    move-result-object v0

    invoke-static {v0}, Lcom/cyjh/elfin/util/AppDeviceUtils;->getResolution(Landroid/content/Context;)Landroid/graphics/Point;

    move-result-object v0

    iget v0, v0, Landroid/graphics/Point;->x:I

    invoke-virtual {p0}, Lcom/cyjh/elfin/floatview/ElfinFloatView;->getContext()Landroid/content/Context;

    move-result-object v1

    invoke-static {v1}, Lcom/cyjh/elfin/util/AppDeviceUtils;->getResolution(Landroid/content/Context;)Landroid/graphics/Point;

    move-result-object v1

    iget v1, v1, Landroid/graphics/Point;->y:I

    div-int/lit8 v1, v1, 0x4

    invoke-virtual {p0, v0, v1}, Lcom/cyjh/elfin/floatview/ElfinFloatView;->updateFloatViewPosition(II)V

    .line 548
    invoke-virtual {p0, v2}, Lcom/cyjh/elfin/floatview/ElfinFloatView;->setVisibility(I)V

    goto :goto_0
.end method

.method public upadateElfinImages()V
    .locals 2

    .prologue
    .line 315
    iget-object v0, p0, Lcom/cyjh/elfin/floatview/ElfinFloatView;->mAppContext:Lcom/cyjh/elfin/AppContext;

    iget v0, v0, Lcom/cyjh/elfin/AppContext;->STATE_SCRIPT:I

    const/4 v1, 0x2

    if-ne v0, v1, :cond_0

    .line 316
    iget-object v0, p0, Lcom/cyjh/elfin/floatview/ElfinFloatView;->mImageViewElfin:Landroid/widget/ImageView;

    const v1, 0x7f02007b

    invoke-virtual {v0, v1}, Landroid/widget/ImageView;->setImageResource(I)V

    .line 320
    :goto_0
    invoke-direct {p0}, Lcom/cyjh/elfin/floatview/ElfinFloatView;->resetElfinState()V

    .line 321
    iget-object v0, p0, Lcom/cyjh/elfin/floatview/ElfinFloatView;->mCountDownTimer:Landroid/os/CountDownTimer;

    invoke-virtual {v0}, Landroid/os/CountDownTimer;->start()Landroid/os/CountDownTimer;

    .line 322
    return-void

    .line 318
    :cond_0
    iget-object v0, p0, Lcom/cyjh/elfin/floatview/ElfinFloatView;->mImageViewElfin:Landroid/widget/ImageView;

    const v1, 0x7f02006e

    invoke-virtual {v0, v1}, Landroid/widget/ImageView;->setImageResource(I)V

    goto :goto_0
.end method

.method public updateFloatViewPosition(II)V
    .locals 2
    .param p1, "x"    # I
    .param p2, "y"    # I

    .prologue
    .line 240
    iget-object v0, p0, Lcom/cyjh/elfin/floatview/ElfinFloatView;->mWindowManagerParams:Landroid/view/WindowManager$LayoutParams;

    iput p1, v0, Landroid/view/WindowManager$LayoutParams;->x:I

    .line 241
    iget-object v0, p0, Lcom/cyjh/elfin/floatview/ElfinFloatView;->mWindowManagerParams:Landroid/view/WindowManager$LayoutParams;

    iput p2, v0, Landroid/view/WindowManager$LayoutParams;->y:I

    .line 242
    iget-object v0, p0, Lcom/cyjh/elfin/floatview/ElfinFloatView;->mWindowManager:Landroid/view/WindowManager;

    iget-object v1, p0, Lcom/cyjh/elfin/floatview/ElfinFloatView;->mWindowManagerParams:Landroid/view/WindowManager$LayoutParams;

    invoke-interface {v0, p0, v1}, Landroid/view/WindowManager;->updateViewLayout(Landroid/view/View;Landroid/view/ViewGroup$LayoutParams;)V

    .line 243
    return-void
.end method
