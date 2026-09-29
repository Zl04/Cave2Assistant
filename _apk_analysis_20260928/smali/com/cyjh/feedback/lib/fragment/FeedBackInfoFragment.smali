.class public Lcom/cyjh/feedback/lib/fragment/FeedBackInfoFragment;
.super Lcom/cyjh/feedback/lib/base/BaseFragment;
.source "FeedBackInfoFragment.java"

# interfaces
.implements Landroid/view/View$OnClickListener;


# annotations
.annotation system Ldalvik/annotation/MemberClasses;
    value = {
        Lcom/cyjh/feedback/lib/fragment/FeedBackInfoFragment$MyHandler;
    }
.end annotation


# static fields
.field private static final ANDROID_SDK_13:I = 0xd

.field private static final ANDROID_SDK_15:I = 0xf

.field private static final CORE_NUMBER_CPU1:I = 0x1

.field private static final CORE_NUMBER_CPU16:I = 0x10

.field private static final CORE_NUMBER_CPU2:I = 0x2

.field private static final CORE_NUMBER_CPU3:I = 0x3

.field private static final CORE_NUMBER_CPU4:I = 0x4

.field private static final CORE_NUMBER_CPU8:I = 0x8

.field private static final HUA_WEI_MODEL:Ljava/lang/String; = "HUAWEI"

.field public static final NO_ROOT:I = 0x2

.field private static final PIC_COUNT_MAX:I = 0x4

.field public static final REQUEST_CODE:I = 0x100

.field private static final SAN_XING_MODEL:Ljava/lang/String; = "GT-I9"

.field private static final SYSTEM_HUA_WEI:Ljava/lang/String; = "EMUI\u7cfb\u7edf"

.field private static final SYSTEM_MEI_ZU:Ljava/lang/String; = "Flyme\u7cfb\u7edf"

.field private static final SYSTEM_SAN_XING:Ljava/lang/String; = "TouchWiz\u7cfb\u7edf"

.field private static final SYSTEM_XIAO_MI:Ljava/lang/String; = "MIUI\u7cfb\u7edf"

.field public static final VALUE_EMPTY:I = 0x0

.field public static final YES_ROOT:I = 0x1


# instance fields
.field private flag:Z

.field private mAdapter:Lcom/cyjh/feedback/lib/adapter/ImageShowAdapter;

.field private mAddList:Ljava/util/List;
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "Ljava/util/List",
            "<",
            "Ljava/lang/String;",
            ">;"
        }
    .end annotation
.end field

.field private mFeedBackInfo:Landroid/widget/EditText;

.field private mFeedBackInfoBean:Lcom/cyjh/feedback/lib/entities/FeedBackInfoBean;

.field private mGridView:Landroid/widget/GridView;

.field private mHandler:Lcom/cyjh/feedback/lib/fragment/FeedBackInfoFragment$MyHandler;

.field private mLoadingDialog:Lcom/cyjh/feedback/lib/dialog/LoadingDialog;

.field private mQQOrPhone:Landroid/widget/EditText;

.field private mTvComplaintsQQ:Landroid/widget/TextView;

.field private mTvImageCount:Landroid/widget/TextView;

.field private mTvRecordFontNumber:Landroid/widget/TextView;

.field private onlyOneGuid:Ljava/lang/String;

.field private viewLine:Landroid/view/View;


# direct methods
.method public constructor <init>()V
    .locals 2

    .prologue
    .line 57
    invoke-direct {p0}, Lcom/cyjh/feedback/lib/base/BaseFragment;-><init>()V

    .line 72
    new-instance v0, Ljava/util/ArrayList;

    invoke-direct {v0}, Ljava/util/ArrayList;-><init>()V

    iput-object v0, p0, Lcom/cyjh/feedback/lib/fragment/FeedBackInfoFragment;->mAddList:Ljava/util/List;

    .line 116
    new-instance v0, Lcom/cyjh/feedback/lib/fragment/FeedBackInfoFragment$MyHandler;

    const/4 v1, 0x0

    invoke-direct {v0, p0, v1}, Lcom/cyjh/feedback/lib/fragment/FeedBackInfoFragment$MyHandler;-><init>(Lcom/cyjh/feedback/lib/fragment/FeedBackInfoFragment;Lcom/cyjh/feedback/lib/fragment/FeedBackInfoFragment$1;)V

    iput-object v0, p0, Lcom/cyjh/feedback/lib/fragment/FeedBackInfoFragment;->mHandler:Lcom/cyjh/feedback/lib/fragment/FeedBackInfoFragment$MyHandler;

    return-void
.end method

.method static synthetic access$100(Lcom/cyjh/feedback/lib/fragment/FeedBackInfoFragment;)Lcom/cyjh/feedback/lib/dialog/LoadingDialog;
    .locals 1
    .param p0, "x0"    # Lcom/cyjh/feedback/lib/fragment/FeedBackInfoFragment;

    .prologue
    .line 57
    iget-object v0, p0, Lcom/cyjh/feedback/lib/fragment/FeedBackInfoFragment;->mLoadingDialog:Lcom/cyjh/feedback/lib/dialog/LoadingDialog;

    return-object v0
.end method

.method static synthetic access$200(Lcom/cyjh/feedback/lib/fragment/FeedBackInfoFragment;)Lcom/cyjh/feedback/lib/entities/FeedBackInfoBean;
    .locals 1
    .param p0, "x0"    # Lcom/cyjh/feedback/lib/fragment/FeedBackInfoFragment;

    .prologue
    .line 57
    iget-object v0, p0, Lcom/cyjh/feedback/lib/fragment/FeedBackInfoFragment;->mFeedBackInfoBean:Lcom/cyjh/feedback/lib/entities/FeedBackInfoBean;

    return-object v0
.end method

.method static synthetic access$300(Lcom/cyjh/feedback/lib/fragment/FeedBackInfoFragment;)V
    .locals 0
    .param p0, "x0"    # Lcom/cyjh/feedback/lib/fragment/FeedBackInfoFragment;

    .prologue
    .line 57
    invoke-direct {p0}, Lcom/cyjh/feedback/lib/fragment/FeedBackInfoFragment;->fillInfo()V

    return-void
.end method

.method static synthetic access$400(Lcom/cyjh/feedback/lib/fragment/FeedBackInfoFragment;)Landroid/widget/TextView;
    .locals 1
    .param p0, "x0"    # Lcom/cyjh/feedback/lib/fragment/FeedBackInfoFragment;

    .prologue
    .line 57
    iget-object v0, p0, Lcom/cyjh/feedback/lib/fragment/FeedBackInfoFragment;->mTvComplaintsQQ:Landroid/widget/TextView;

    return-object v0
.end method

.method static synthetic access$500(Lcom/cyjh/feedback/lib/fragment/FeedBackInfoFragment;)Landroid/view/View;
    .locals 1
    .param p0, "x0"    # Lcom/cyjh/feedback/lib/fragment/FeedBackInfoFragment;

    .prologue
    .line 57
    iget-object v0, p0, Lcom/cyjh/feedback/lib/fragment/FeedBackInfoFragment;->viewLine:Landroid/view/View;

    return-object v0
.end method

.method static synthetic access$600(Lcom/cyjh/feedback/lib/fragment/FeedBackInfoFragment;)Z
    .locals 1
    .param p0, "x0"    # Lcom/cyjh/feedback/lib/fragment/FeedBackInfoFragment;

    .prologue
    .line 57
    iget-boolean v0, p0, Lcom/cyjh/feedback/lib/fragment/FeedBackInfoFragment;->flag:Z

    return v0
.end method

.method static synthetic access$700(Lcom/cyjh/feedback/lib/fragment/FeedBackInfoFragment;)Landroid/widget/TextView;
    .locals 1
    .param p0, "x0"    # Lcom/cyjh/feedback/lib/fragment/FeedBackInfoFragment;

    .prologue
    .line 57
    iget-object v0, p0, Lcom/cyjh/feedback/lib/fragment/FeedBackInfoFragment;->mTvRecordFontNumber:Landroid/widget/TextView;

    return-object v0
.end method

.method static synthetic access$800(Lcom/cyjh/feedback/lib/fragment/FeedBackInfoFragment;)Ljava/util/List;
    .locals 1
    .param p0, "x0"    # Lcom/cyjh/feedback/lib/fragment/FeedBackInfoFragment;

    .prologue
    .line 57
    iget-object v0, p0, Lcom/cyjh/feedback/lib/fragment/FeedBackInfoFragment;->mAddList:Ljava/util/List;

    return-object v0
.end method

.method static synthetic access$900(Lcom/cyjh/feedback/lib/fragment/FeedBackInfoFragment;)Landroid/widget/TextView;
    .locals 1
    .param p0, "x0"    # Lcom/cyjh/feedback/lib/fragment/FeedBackInfoFragment;

    .prologue
    .line 57
    iget-object v0, p0, Lcom/cyjh/feedback/lib/fragment/FeedBackInfoFragment;->mTvImageCount:Landroid/widget/TextView;

    return-object v0
.end method

.method private fillInfo()V
    .locals 3

    .prologue
    const/4 v2, 0x0

    .line 119
    iget-object v0, p0, Lcom/cyjh/feedback/lib/fragment/FeedBackInfoFragment;->mQQOrPhone:Landroid/widget/EditText;

    invoke-virtual {v0}, Landroid/widget/EditText;->getText()Landroid/text/Editable;

    move-result-object v0

    invoke-virtual {v0}, Ljava/lang/Object;->toString()Ljava/lang/String;

    move-result-object v0

    invoke-virtual {v0}, Ljava/lang/String;->trim()Ljava/lang/String;

    move-result-object v0

    invoke-static {v0}, Landroid/text/TextUtils;->isEmpty(Ljava/lang/CharSequence;)Z

    move-result v0

    if-eqz v0, :cond_0

    iget-object v0, p0, Lcom/cyjh/feedback/lib/fragment/FeedBackInfoFragment;->mFeedBackInfo:Landroid/widget/EditText;

    .line 120
    invoke-virtual {v0}, Landroid/widget/EditText;->getText()Landroid/text/Editable;

    move-result-object v0

    invoke-virtual {v0}, Ljava/lang/Object;->toString()Ljava/lang/String;

    move-result-object v0

    invoke-virtual {v0}, Ljava/lang/String;->trim()Ljava/lang/String;

    move-result-object v0

    invoke-static {v0}, Landroid/text/TextUtils;->isEmpty(Ljava/lang/CharSequence;)Z

    move-result v0

    if-eqz v0, :cond_0

    .line 121
    invoke-virtual {p0}, Lcom/cyjh/feedback/lib/fragment/FeedBackInfoFragment;->getActivity()Landroid/support/v4/app/FragmentActivity;

    move-result-object v0

    sget v1, Lcom/cyjh/feedback/libraryfeedbackinfo/R$string;->no_fill_info:I

    invoke-virtual {p0, v1}, Lcom/cyjh/feedback/lib/fragment/FeedBackInfoFragment;->getString(I)Ljava/lang/String;

    move-result-object v1

    const/4 v2, 0x1

    invoke-static {v0, v1, v2}, Landroid/widget/Toast;->makeText(Landroid/content/Context;Ljava/lang/CharSequence;I)Landroid/widget/Toast;

    move-result-object v0

    invoke-virtual {v0}, Landroid/widget/Toast;->show()V

    .line 143
    :goto_0
    return-void

    .line 123
    :cond_0
    iget-object v0, p0, Lcom/cyjh/feedback/lib/fragment/FeedBackInfoFragment;->mQQOrPhone:Landroid/widget/EditText;

    invoke-virtual {v0}, Landroid/widget/EditText;->getText()Landroid/text/Editable;

    move-result-object v0

    invoke-virtual {v0}, Ljava/lang/Object;->toString()Ljava/lang/String;

    move-result-object v0

    invoke-virtual {v0}, Ljava/lang/String;->trim()Ljava/lang/String;

    move-result-object v0

    invoke-static {v0}, Landroid/text/TextUtils;->isEmpty(Ljava/lang/CharSequence;)Z

    move-result v0

    if-nez v0, :cond_2

    .line 125
    iget-object v0, p0, Lcom/cyjh/feedback/lib/fragment/FeedBackInfoFragment;->mQQOrPhone:Landroid/widget/EditText;

    invoke-virtual {v0}, Landroid/widget/EditText;->getText()Landroid/text/Editable;

    move-result-object v0

    invoke-virtual {v0}, Ljava/lang/Object;->toString()Ljava/lang/String;

    move-result-object v0

    invoke-virtual {v0}, Ljava/lang/String;->trim()Ljava/lang/String;

    move-result-object v0

    invoke-static {v0}, Lcom/cyjh/feedback/lib/utils/AppDevicesUtils;->isMobileNO(Ljava/lang/String;)Z

    move-result v0

    if-eqz v0, :cond_1

    .line 126
    iget-object v0, p0, Lcom/cyjh/feedback/lib/fragment/FeedBackInfoFragment;->mFeedBackInfoBean:Lcom/cyjh/feedback/lib/entities/FeedBackInfoBean;

    iget-object v1, p0, Lcom/cyjh/feedback/lib/fragment/FeedBackInfoFragment;->mQQOrPhone:Landroid/widget/EditText;

    invoke-virtual {v1}, Landroid/widget/EditText;->getText()Landroid/text/Editable;

    move-result-object v1

    invoke-virtual {v1}, Ljava/lang/Object;->toString()Ljava/lang/String;

    move-result-object v1

    invoke-virtual {v1}, Ljava/lang/String;->trim()Ljava/lang/String;

    move-result-object v1

    invoke-virtual {v0, v1}, Lcom/cyjh/feedback/lib/entities/FeedBackInfoBean;->setTelNumber(Ljava/lang/String;)V

    .line 127
    iget-object v0, p0, Lcom/cyjh/feedback/lib/fragment/FeedBackInfoFragment;->mFeedBackInfoBean:Lcom/cyjh/feedback/lib/entities/FeedBackInfoBean;

    invoke-static {v2}, Ljava/lang/String;->valueOf(I)Ljava/lang/String;

    move-result-object v1

    invoke-virtual {v0, v1}, Lcom/cyjh/feedback/lib/entities/FeedBackInfoBean;->setQQ(Ljava/lang/String;)V

    .line 136
    :goto_1
    iget-object v0, p0, Lcom/cyjh/feedback/lib/fragment/FeedBackInfoFragment;->mFeedBackInfo:Landroid/widget/EditText;

    invoke-virtual {v0}, Landroid/widget/EditText;->getText()Landroid/text/Editable;

    move-result-object v0

    invoke-virtual {v0}, Ljava/lang/Object;->toString()Ljava/lang/String;

    move-result-object v0

    invoke-virtual {v0}, Ljava/lang/String;->trim()Ljava/lang/String;

    move-result-object v0

    invoke-static {v0}, Landroid/text/TextUtils;->isEmpty(Ljava/lang/CharSequence;)Z

    move-result v0

    if-nez v0, :cond_3

    .line 137
    iget-object v0, p0, Lcom/cyjh/feedback/lib/fragment/FeedBackInfoFragment;->mFeedBackInfoBean:Lcom/cyjh/feedback/lib/entities/FeedBackInfoBean;

    iget-object v1, p0, Lcom/cyjh/feedback/lib/fragment/FeedBackInfoFragment;->mFeedBackInfo:Landroid/widget/EditText;

    invoke-virtual {v1}, Landroid/widget/EditText;->getText()Landroid/text/Editable;

    move-result-object v1

    invoke-virtual {v1}, Ljava/lang/Object;->toString()Ljava/lang/String;

    move-result-object v1

    invoke-virtual {v1}, Ljava/lang/String;->trim()Ljava/lang/String;

    move-result-object v1

    invoke-virtual {v0, v1}, Lcom/cyjh/feedback/lib/entities/FeedBackInfoBean;->setFeedBack(Ljava/lang/String;)V

    .line 141
    :goto_2
    invoke-direct {p0}, Lcom/cyjh/feedback/lib/fragment/FeedBackInfoFragment;->showFeedbackDialog()V

    goto :goto_0

    .line 129
    :cond_1
    iget-object v0, p0, Lcom/cyjh/feedback/lib/fragment/FeedBackInfoFragment;->mFeedBackInfoBean:Lcom/cyjh/feedback/lib/entities/FeedBackInfoBean;

    iget-object v1, p0, Lcom/cyjh/feedback/lib/fragment/FeedBackInfoFragment;->mQQOrPhone:Landroid/widget/EditText;

    invoke-virtual {v1}, Landroid/widget/EditText;->getText()Landroid/text/Editable;

    move-result-object v1

    invoke-virtual {v1}, Ljava/lang/Object;->toString()Ljava/lang/String;

    move-result-object v1

    invoke-virtual {v1}, Ljava/lang/String;->trim()Ljava/lang/String;

    move-result-object v1

    invoke-virtual {v0, v1}, Lcom/cyjh/feedback/lib/entities/FeedBackInfoBean;->setQQ(Ljava/lang/String;)V

    .line 130
    iget-object v0, p0, Lcom/cyjh/feedback/lib/fragment/FeedBackInfoFragment;->mFeedBackInfoBean:Lcom/cyjh/feedback/lib/entities/FeedBackInfoBean;

    invoke-static {v2}, Ljava/lang/String;->valueOf(I)Ljava/lang/String;

    move-result-object v1

    invoke-virtual {v0, v1}, Lcom/cyjh/feedback/lib/entities/FeedBackInfoBean;->setTelNumber(Ljava/lang/String;)V

    goto :goto_1

    .line 133
    :cond_2
    iget-object v0, p0, Lcom/cyjh/feedback/lib/fragment/FeedBackInfoFragment;->mFeedBackInfoBean:Lcom/cyjh/feedback/lib/entities/FeedBackInfoBean;

    invoke-static {v2}, Ljava/lang/String;->valueOf(I)Ljava/lang/String;

    move-result-object v1

    invoke-virtual {v0, v1}, Lcom/cyjh/feedback/lib/entities/FeedBackInfoBean;->setQQ(Ljava/lang/String;)V

    .line 134
    iget-object v0, p0, Lcom/cyjh/feedback/lib/fragment/FeedBackInfoFragment;->mFeedBackInfoBean:Lcom/cyjh/feedback/lib/entities/FeedBackInfoBean;

    invoke-static {v2}, Ljava/lang/String;->valueOf(I)Ljava/lang/String;

    move-result-object v1

    invoke-virtual {v0, v1}, Lcom/cyjh/feedback/lib/entities/FeedBackInfoBean;->setTelNumber(Ljava/lang/String;)V

    goto :goto_1

    .line 139
    :cond_3
    iget-object v0, p0, Lcom/cyjh/feedback/lib/fragment/FeedBackInfoFragment;->mFeedBackInfoBean:Lcom/cyjh/feedback/lib/entities/FeedBackInfoBean;

    invoke-static {v2}, Ljava/lang/String;->valueOf(I)Ljava/lang/String;

    move-result-object v1

    invoke-virtual {v0, v1}, Lcom/cyjh/feedback/lib/entities/FeedBackInfoBean;->setFeedBack(Ljava/lang/String;)V

    goto :goto_2
.end method

.method private getCPUCoreNum(I)Ljava/lang/String;
    .locals 2
    .param p1, "cpuNuclearNum"    # I

    .prologue
    .line 471
    const/4 v0, 0x0

    .line 472
    .local v0, "result":Ljava/lang/String;
    sparse-switch p1, :sswitch_data_0

    .line 494
    :goto_0
    return-object v0

    .line 474
    :sswitch_0
    sget v1, Lcom/cyjh/feedback/libraryfeedbackinfo/R$string;->cpu_core_one:I

    invoke-virtual {p0, v1}, Lcom/cyjh/feedback/lib/fragment/FeedBackInfoFragment;->getString(I)Ljava/lang/String;

    move-result-object v0

    .line 475
    goto :goto_0

    .line 477
    :sswitch_1
    sget v1, Lcom/cyjh/feedback/libraryfeedbackinfo/R$string;->cpu_core_two:I

    invoke-virtual {p0, v1}, Lcom/cyjh/feedback/lib/fragment/FeedBackInfoFragment;->getString(I)Ljava/lang/String;

    move-result-object v0

    .line 478
    goto :goto_0

    .line 480
    :sswitch_2
    sget v1, Lcom/cyjh/feedback/libraryfeedbackinfo/R$string;->cpu_core_three:I

    invoke-virtual {p0, v1}, Lcom/cyjh/feedback/lib/fragment/FeedBackInfoFragment;->getString(I)Ljava/lang/String;

    move-result-object v0

    .line 481
    goto :goto_0

    .line 483
    :sswitch_3
    sget v1, Lcom/cyjh/feedback/libraryfeedbackinfo/R$string;->cpu_core_four:I

    invoke-virtual {p0, v1}, Lcom/cyjh/feedback/lib/fragment/FeedBackInfoFragment;->getString(I)Ljava/lang/String;

    move-result-object v0

    .line 484
    goto :goto_0

    .line 486
    :sswitch_4
    sget v1, Lcom/cyjh/feedback/libraryfeedbackinfo/R$string;->cpu_core_eight:I

    invoke-virtual {p0, v1}, Lcom/cyjh/feedback/lib/fragment/FeedBackInfoFragment;->getString(I)Ljava/lang/String;

    move-result-object v0

    .line 487
    goto :goto_0

    .line 489
    :sswitch_5
    sget v1, Lcom/cyjh/feedback/libraryfeedbackinfo/R$string;->cpu_core_sixteen:I

    invoke-virtual {p0, v1}, Lcom/cyjh/feedback/lib/fragment/FeedBackInfoFragment;->getString(I)Ljava/lang/String;

    move-result-object v0

    .line 490
    goto :goto_0

    .line 472
    nop

    :sswitch_data_0
    .sparse-switch
        0x1 -> :sswitch_0
        0x2 -> :sswitch_1
        0x3 -> :sswitch_2
        0x4 -> :sswitch_3
        0x8 -> :sswitch_4
        0x10 -> :sswitch_5
    .end sparse-switch
.end method

.method private getFeedBackInfo()V
    .locals 26

    .prologue
    .line 352
    move-object/from16 v0, p0

    iget-object v8, v0, Lcom/cyjh/feedback/lib/fragment/FeedBackInfoFragment;->onlyOneGuid:Ljava/lang/String;

    .line 353
    .local v8, "guid":Ljava/lang/String;
    new-instance v24, Ljava/lang/StringBuilder;

    invoke-direct/range {v24 .. v24}, Ljava/lang/StringBuilder;-><init>()V

    const-string v25, "guid = "

    invoke-virtual/range {v24 .. v25}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v24

    move-object/from16 v0, v24

    invoke-virtual {v0, v8}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v24

    invoke-virtual/range {v24 .. v24}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v24

    const/16 v25, 0x0

    move/from16 v0, v25

    new-array v0, v0, [Ljava/lang/Object;

    move-object/from16 v25, v0

    invoke-static/range {v24 .. v25}, Lcom/orhanobut/logger/Logger;->e(Ljava/lang/String;[Ljava/lang/Object;)V

    .line 355
    sget-object v18, Landroid/os/Build$VERSION;->SDK:Ljava/lang/String;

    .line 357
    .local v18, "sdk":Ljava/lang/String;
    sget-object v13, Landroid/os/Build;->MODEL:Ljava/lang/String;

    .line 358
    .local v13, "model":Ljava/lang/String;
    new-instance v24, Ljava/lang/StringBuilder;

    invoke-direct/range {v24 .. v24}, Ljava/lang/StringBuilder;-><init>()V

    const-string v25, "model = "

    invoke-virtual/range {v24 .. v25}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v24

    move-object/from16 v0, v24

    invoke-virtual {v0, v13}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v24

    invoke-virtual/range {v24 .. v24}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v24

    const/16 v25, 0x0

    move/from16 v0, v25

    new-array v0, v0, [Ljava/lang/Object;

    move-object/from16 v25, v0

    invoke-static/range {v24 .. v25}, Lcom/orhanobut/logger/Logger;->e(Ljava/lang/String;[Ljava/lang/Object;)V

    .line 360
    sget-object v16, Landroid/os/Build$VERSION;->RELEASE:Ljava/lang/String;

    .line 361
    .local v16, "release":Ljava/lang/String;
    const-string v20, ""

    .line 363
    .local v20, "systemVersion":Ljava/lang/String;
    invoke-static {}, Lcom/cyjh/feedback/lib/utils/AppDevicesUtils;->isFlyme()Z

    move-result v24

    if-eqz v24, :cond_2

    .line 364
    const-string v20, "Flyme\u7cfb\u7edf"

    .line 373
    :cond_0
    :goto_0
    invoke-static {}, Lcom/cyjh/feedback/lib/utils/RootUtil;->isRoot()Z

    move-result v24

    if-eqz v24, :cond_5

    .line 374
    const/16 v24, 0x1

    invoke-static/range {v24 .. v24}, Ljava/lang/String;->valueOf(I)Ljava/lang/String;

    move-result-object v10

    .line 379
    .local v10, "isRoot":Ljava/lang/String;
    :goto_1
    invoke-virtual/range {p0 .. p0}, Lcom/cyjh/feedback/lib/fragment/FeedBackInfoFragment;->getActivity()Landroid/support/v4/app/FragmentActivity;

    move-result-object v24

    invoke-static/range {v24 .. v24}, Lcom/cyjh/feedback/lib/utils/AppDevicesUtils;->getTotalMemorySize(Landroid/content/Context;)J

    move-result-wide v14

    .line 381
    .local v14, "ram":J
    invoke-virtual/range {p0 .. p0}, Lcom/cyjh/feedback/lib/fragment/FeedBackInfoFragment;->getActivity()Landroid/support/v4/app/FragmentActivity;

    move-result-object v24

    invoke-static/range {v24 .. v24}, Lcom/cyjh/feedback/lib/utils/AppDevicesUtils;->getResolution(Landroid/content/Context;)Landroid/graphics/Point;

    move-result-object v24

    move-object/from16 v0, v24

    iget v0, v0, Landroid/graphics/Point;->x:I

    move/from16 v23, v0

    .line 382
    .local v23, "width":I
    invoke-virtual/range {p0 .. p0}, Lcom/cyjh/feedback/lib/fragment/FeedBackInfoFragment;->getActivity()Landroid/support/v4/app/FragmentActivity;

    move-result-object v24

    invoke-static/range {v24 .. v24}, Lcom/cyjh/feedback/lib/utils/AppDevicesUtils;->getResolution(Landroid/content/Context;)Landroid/graphics/Point;

    move-result-object v24

    move-object/from16 v0, v24

    iget v9, v0, Landroid/graphics/Point;->y:I

    .line 383
    .local v9, "height":I
    invoke-virtual/range {p0 .. p0}, Lcom/cyjh/feedback/lib/fragment/FeedBackInfoFragment;->getActivity()Landroid/support/v4/app/FragmentActivity;

    move-result-object v24

    move-object/from16 v0, v24

    invoke-static {v0, v14, v15}, Landroid/text/format/Formatter;->formatFileSize(Landroid/content/Context;J)Ljava/lang/String;

    move-result-object v12

    .line 385
    .local v12, "memoryTotal":Ljava/lang/String;
    invoke-virtual/range {p0 .. p0}, Lcom/cyjh/feedback/lib/fragment/FeedBackInfoFragment;->getActivity()Landroid/support/v4/app/FragmentActivity;

    move-result-object v24

    invoke-static/range {v24 .. v24}, Lcom/cyjh/feedback/lib/utils/AppDevicesUtils;->getScreenDPI(Landroid/content/Context;)I

    move-result v7

    .line 387
    .local v7, "dpiValue":I
    invoke-static {}, Lcom/cyjh/feedback/lib/utils/AppDevicesUtils;->getKernelVersion()Ljava/lang/String;

    move-result-object v11

    .line 388
    .local v11, "kernelVersion":Ljava/lang/String;
    invoke-virtual/range {p0 .. p0}, Lcom/cyjh/feedback/lib/fragment/FeedBackInfoFragment;->getActivity()Landroid/support/v4/app/FragmentActivity;

    move-result-object v24

    const-string v25, "phone"

    invoke-virtual/range {v24 .. v25}, Landroid/support/v4/app/FragmentActivity;->getSystemService(Ljava/lang/String;)Ljava/lang/Object;

    move-result-object v22

    check-cast v22, Landroid/telephony/TelephonyManager;

    .line 390
    .local v22, "telephonyMgr":Landroid/telephony/TelephonyManager;
    invoke-virtual/range {v22 .. v22}, Landroid/telephony/TelephonyManager;->getDeviceId()Ljava/lang/String;

    move-result-object v21

    .line 392
    .local v21, "telIMEI":Ljava/lang/String;
    invoke-static {}, Lcom/cyjh/feedback/lib/utils/AppDevicesUtils;->getSerialNumber()Ljava/lang/String;

    move-result-object v19

    .line 393
    .local v19, "serial":Ljava/lang/String;
    new-instance v24, Ljava/lang/StringBuilder;

    invoke-direct/range {v24 .. v24}, Ljava/lang/StringBuilder;-><init>()V

    const-string v25, "\u624b\u673a\u5e8f\u5217\u53f7\uff1a"

    invoke-virtual/range {v24 .. v25}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v24

    move-object/from16 v0, v24

    move-object/from16 v1, v19

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v24

    invoke-virtual/range {v24 .. v24}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v24

    const/16 v25, 0x0

    move/from16 v0, v25

    new-array v0, v0, [Ljava/lang/Object;

    move-object/from16 v25, v0

    invoke-static/range {v24 .. v25}, Lcom/orhanobut/logger/Logger;->e(Ljava/lang/String;[Ljava/lang/Object;)V

    .line 395
    invoke-static {}, Lcom/cyjh/feedback/lib/utils/AppDevicesUtils;->getBaseBandVer()Ljava/lang/String;

    move-result-object v2

    .line 397
    .local v2, "baseBandVersion":Ljava/lang/String;
    invoke-static {}, Lcom/cyjh/feedback/lib/utils/AppDevicesUtils;->getNumCores()I

    move-result v6

    .line 398
    .local v6, "cpuNuclearNum":I
    move-object/from16 v0, p0

    invoke-direct {v0, v6}, Lcom/cyjh/feedback/lib/fragment/FeedBackInfoFragment;->getCPUCoreNum(I)Ljava/lang/String;

    move-result-object v3

    .line 399
    .local v3, "cpuCoreNum":Ljava/lang/String;
    new-instance v24, Ljava/lang/StringBuilder;

    invoke-direct/range {v24 .. v24}, Ljava/lang/StringBuilder;-><init>()V

    move-object/from16 v0, v24

    move/from16 v1, v23

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v24

    const-string v25, "*"

    invoke-virtual/range {v24 .. v25}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v24

    move-object/from16 v0, v24

    invoke-virtual {v0, v9}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v24

    invoke-virtual/range {v24 .. v24}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v17

    .line 401
    .local v17, "resolutionRatio":Ljava/lang/String;
    invoke-static {}, Lcom/cyjh/feedback/lib/utils/AppDevicesUtils;->getCpuInfo()Ljava/lang/String;

    move-result-object v5

    .line 402
    .local v5, "cpuModel":Ljava/lang/String;
    const-string v4, ""

    .line 403
    .local v4, "cpuInfo":Ljava/lang/String;
    invoke-static {v3}, Landroid/text/TextUtils;->isEmpty(Ljava/lang/CharSequence;)Z

    move-result v24

    if-nez v24, :cond_6

    invoke-static {v5}, Landroid/text/TextUtils;->isEmpty(Ljava/lang/CharSequence;)Z

    move-result v24

    if-nez v24, :cond_6

    .line 404
    new-instance v24, Ljava/lang/StringBuilder;

    invoke-direct/range {v24 .. v24}, Ljava/lang/StringBuilder;-><init>()V

    move-object/from16 v0, v24

    invoke-virtual {v0, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v24

    const-string v25, "\uff0cCPU\u578b\u53f7\uff1a"

    invoke-virtual/range {v24 .. v25}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v24

    move-object/from16 v0, v24

    invoke-virtual {v0, v5}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v24

    invoke-virtual/range {v24 .. v24}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v4

    .line 410
    :cond_1
    :goto_2
    new-instance v24, Ljava/lang/StringBuilder;

    invoke-direct/range {v24 .. v24}, Ljava/lang/StringBuilder;-><init>()V

    const-string v25, "cpuInfo:"

    invoke-virtual/range {v24 .. v25}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v24

    move-object/from16 v0, v24

    invoke-virtual {v0, v4}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v24

    invoke-virtual/range {v24 .. v24}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v24

    const/16 v25, 0x0

    move/from16 v0, v25

    new-array v0, v0, [Ljava/lang/Object;

    move-object/from16 v25, v0

    invoke-static/range {v24 .. v25}, Lcom/orhanobut/logger/Logger;->e(Ljava/lang/String;[Ljava/lang/Object;)V

    .line 411
    move-object/from16 v0, p0

    iget-object v0, v0, Lcom/cyjh/feedback/lib/fragment/FeedBackInfoFragment;->mFeedBackInfoBean:Lcom/cyjh/feedback/lib/entities/FeedBackInfoBean;

    move-object/from16 v24, v0

    move-object/from16 v0, v24

    invoke-virtual {v0, v8}, Lcom/cyjh/feedback/lib/entities/FeedBackInfoBean;->setGUID(Ljava/lang/String;)V

    .line 412
    move-object/from16 v0, p0

    iget-object v0, v0, Lcom/cyjh/feedback/lib/fragment/FeedBackInfoFragment;->mFeedBackInfoBean:Lcom/cyjh/feedback/lib/entities/FeedBackInfoBean;

    move-object/from16 v24, v0

    move-object/from16 v0, v24

    invoke-virtual {v0, v13}, Lcom/cyjh/feedback/lib/entities/FeedBackInfoBean;->setModel(Ljava/lang/String;)V

    .line 413
    move-object/from16 v0, p0

    iget-object v0, v0, Lcom/cyjh/feedback/lib/fragment/FeedBackInfoFragment;->mFeedBackInfoBean:Lcom/cyjh/feedback/lib/entities/FeedBackInfoBean;

    move-object/from16 v24, v0

    move-object/from16 v0, v24

    invoke-virtual {v0, v12}, Lcom/cyjh/feedback/lib/entities/FeedBackInfoBean;->setRAM(Ljava/lang/String;)V

    .line 414
    move-object/from16 v0, p0

    iget-object v0, v0, Lcom/cyjh/feedback/lib/fragment/FeedBackInfoFragment;->mFeedBackInfoBean:Lcom/cyjh/feedback/lib/entities/FeedBackInfoBean;

    move-object/from16 v24, v0

    move-object/from16 v0, v24

    invoke-virtual {v0, v4}, Lcom/cyjh/feedback/lib/entities/FeedBackInfoBean;->setProcess(Ljava/lang/String;)V

    .line 415
    move-object/from16 v0, p0

    iget-object v0, v0, Lcom/cyjh/feedback/lib/fragment/FeedBackInfoFragment;->mFeedBackInfoBean:Lcom/cyjh/feedback/lib/entities/FeedBackInfoBean;

    move-object/from16 v24, v0

    move-object/from16 v0, v24

    move-object/from16 v1, v16

    invoke-virtual {v0, v1}, Lcom/cyjh/feedback/lib/entities/FeedBackInfoBean;->setAndoridData(Ljava/lang/String;)V

    .line 416
    move-object/from16 v0, p0

    iget-object v0, v0, Lcom/cyjh/feedback/lib/fragment/FeedBackInfoFragment;->mFeedBackInfoBean:Lcom/cyjh/feedback/lib/entities/FeedBackInfoBean;

    move-object/from16 v24, v0

    move-object/from16 v0, v24

    invoke-virtual {v0, v10}, Lcom/cyjh/feedback/lib/entities/FeedBackInfoBean;->setRooStatus(Ljava/lang/String;)V

    .line 417
    move-object/from16 v0, p0

    iget-object v0, v0, Lcom/cyjh/feedback/lib/fragment/FeedBackInfoFragment;->mFeedBackInfoBean:Lcom/cyjh/feedback/lib/entities/FeedBackInfoBean;

    move-object/from16 v24, v0

    invoke-static {v7}, Ljava/lang/String;->valueOf(I)Ljava/lang/String;

    move-result-object v25

    invoke-virtual/range {v24 .. v25}, Lcom/cyjh/feedback/lib/entities/FeedBackInfoBean;->setDPI(Ljava/lang/String;)V

    .line 418
    move-object/from16 v0, p0

    iget-object v0, v0, Lcom/cyjh/feedback/lib/fragment/FeedBackInfoFragment;->mFeedBackInfoBean:Lcom/cyjh/feedback/lib/entities/FeedBackInfoBean;

    move-object/from16 v24, v0

    move-object/from16 v0, v24

    invoke-virtual {v0, v2}, Lcom/cyjh/feedback/lib/entities/FeedBackInfoBean;->setBaseBandVersion(Ljava/lang/String;)V

    .line 419
    move-object/from16 v0, p0

    iget-object v0, v0, Lcom/cyjh/feedback/lib/fragment/FeedBackInfoFragment;->mFeedBackInfoBean:Lcom/cyjh/feedback/lib/entities/FeedBackInfoBean;

    move-object/from16 v24, v0

    move-object/from16 v0, v24

    move-object/from16 v1, v21

    invoke-virtual {v0, v1}, Lcom/cyjh/feedback/lib/entities/FeedBackInfoBean;->setIMEI(Ljava/lang/String;)V

    .line 420
    move-object/from16 v0, p0

    iget-object v0, v0, Lcom/cyjh/feedback/lib/fragment/FeedBackInfoFragment;->mFeedBackInfoBean:Lcom/cyjh/feedback/lib/entities/FeedBackInfoBean;

    move-object/from16 v24, v0

    move-object/from16 v0, v24

    move-object/from16 v1, v19

    invoke-virtual {v0, v1}, Lcom/cyjh/feedback/lib/entities/FeedBackInfoBean;->setSerialNumber(Ljava/lang/String;)V

    .line 421
    move-object/from16 v0, p0

    iget-object v0, v0, Lcom/cyjh/feedback/lib/fragment/FeedBackInfoFragment;->mFeedBackInfoBean:Lcom/cyjh/feedback/lib/entities/FeedBackInfoBean;

    move-object/from16 v24, v0

    move-object/from16 v0, v24

    invoke-virtual {v0, v11}, Lcom/cyjh/feedback/lib/entities/FeedBackInfoBean;->setCoreVersion(Ljava/lang/String;)V

    .line 422
    move-object/from16 v0, p0

    iget-object v0, v0, Lcom/cyjh/feedback/lib/fragment/FeedBackInfoFragment;->mFeedBackInfoBean:Lcom/cyjh/feedback/lib/entities/FeedBackInfoBean;

    move-object/from16 v24, v0

    move-object/from16 v0, v24

    move-object/from16 v1, v17

    invoke-virtual {v0, v1}, Lcom/cyjh/feedback/lib/entities/FeedBackInfoBean;->setResolution(Ljava/lang/String;)V

    .line 423
    move-object/from16 v0, p0

    iget-object v0, v0, Lcom/cyjh/feedback/lib/fragment/FeedBackInfoFragment;->mFeedBackInfoBean:Lcom/cyjh/feedback/lib/entities/FeedBackInfoBean;

    move-object/from16 v24, v0

    move-object/from16 v0, v24

    move-object/from16 v1, v20

    invoke-virtual {v0, v1}, Lcom/cyjh/feedback/lib/entities/FeedBackInfoBean;->setSystemVersion(Ljava/lang/String;)V

    .line 424
    new-instance v24, Ljava/lang/StringBuilder;

    invoke-direct/range {v24 .. v24}, Ljava/lang/StringBuilder;-><init>()V

    const-string v25, "systemVersion:"

    invoke-virtual/range {v24 .. v25}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v24

    move-object/from16 v0, v24

    move-object/from16 v1, v20

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v24

    invoke-virtual/range {v24 .. v24}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v24

    const/16 v25, 0x0

    move/from16 v0, v25

    new-array v0, v0, [Ljava/lang/Object;

    move-object/from16 v25, v0

    invoke-static/range {v24 .. v25}, Lcom/orhanobut/logger/Logger;->e(Ljava/lang/String;[Ljava/lang/Object;)V

    .line 425
    return-void

    .line 365
    .end local v2    # "baseBandVersion":Ljava/lang/String;
    .end local v3    # "cpuCoreNum":Ljava/lang/String;
    .end local v4    # "cpuInfo":Ljava/lang/String;
    .end local v5    # "cpuModel":Ljava/lang/String;
    .end local v6    # "cpuNuclearNum":I
    .end local v7    # "dpiValue":I
    .end local v9    # "height":I
    .end local v10    # "isRoot":Ljava/lang/String;
    .end local v11    # "kernelVersion":Ljava/lang/String;
    .end local v12    # "memoryTotal":Ljava/lang/String;
    .end local v14    # "ram":J
    .end local v17    # "resolutionRatio":Ljava/lang/String;
    .end local v19    # "serial":Ljava/lang/String;
    .end local v21    # "telIMEI":Ljava/lang/String;
    .end local v22    # "telephonyMgr":Landroid/telephony/TelephonyManager;
    .end local v23    # "width":I
    :cond_2
    invoke-static {}, Lcom/cyjh/feedback/lib/utils/AppDevicesUtils;->isMIUI()Z

    move-result v24

    if-eqz v24, :cond_3

    .line 366
    const-string v20, "MIUI\u7cfb\u7edf"

    goto/16 :goto_0

    .line 367
    :cond_3
    const-string v24, "HUAWEI"

    move-object/from16 v0, v24

    invoke-virtual {v13, v0}, Ljava/lang/String;->startsWith(Ljava/lang/String;)Z

    move-result v24

    if-eqz v24, :cond_4

    invoke-static/range {v18 .. v18}, Ljava/lang/Integer;->parseInt(Ljava/lang/String;)I

    move-result v24

    const/16 v25, 0xf

    move/from16 v0, v24

    move/from16 v1, v25

    if-le v0, v1, :cond_4

    .line 368
    const-string v20, "EMUI\u7cfb\u7edf"

    goto/16 :goto_0

    .line 369
    :cond_4
    const-string v24, "GT-I9"

    move-object/from16 v0, v24

    invoke-virtual {v13, v0}, Ljava/lang/String;->startsWith(Ljava/lang/String;)Z

    move-result v24

    if-eqz v24, :cond_0

    invoke-static/range {v18 .. v18}, Ljava/lang/Integer;->parseInt(Ljava/lang/String;)I

    move-result v24

    const/16 v25, 0xd

    move/from16 v0, v24

    move/from16 v1, v25

    if-le v0, v1, :cond_0

    .line 370
    const-string v20, "TouchWiz\u7cfb\u7edf"

    goto/16 :goto_0

    .line 376
    :cond_5
    const/16 v24, 0x2

    invoke-static/range {v24 .. v24}, Ljava/lang/String;->valueOf(I)Ljava/lang/String;

    move-result-object v10

    .restart local v10    # "isRoot":Ljava/lang/String;
    goto/16 :goto_1

    .line 405
    .restart local v2    # "baseBandVersion":Ljava/lang/String;
    .restart local v3    # "cpuCoreNum":Ljava/lang/String;
    .restart local v4    # "cpuInfo":Ljava/lang/String;
    .restart local v5    # "cpuModel":Ljava/lang/String;
    .restart local v6    # "cpuNuclearNum":I
    .restart local v7    # "dpiValue":I
    .restart local v9    # "height":I
    .restart local v11    # "kernelVersion":Ljava/lang/String;
    .restart local v12    # "memoryTotal":Ljava/lang/String;
    .restart local v14    # "ram":J
    .restart local v17    # "resolutionRatio":Ljava/lang/String;
    .restart local v19    # "serial":Ljava/lang/String;
    .restart local v21    # "telIMEI":Ljava/lang/String;
    .restart local v22    # "telephonyMgr":Landroid/telephony/TelephonyManager;
    .restart local v23    # "width":I
    :cond_6
    invoke-static {v3}, Landroid/text/TextUtils;->isEmpty(Ljava/lang/CharSequence;)Z

    move-result v24

    if-nez v24, :cond_7

    invoke-static {v5}, Landroid/text/TextUtils;->isEmpty(Ljava/lang/CharSequence;)Z

    move-result v24

    if-eqz v24, :cond_7

    .line 406
    move-object v4, v3

    goto/16 :goto_2

    .line 407
    :cond_7
    invoke-static {v3}, Landroid/text/TextUtils;->isEmpty(Ljava/lang/CharSequence;)Z

    move-result v24

    if-eqz v24, :cond_1

    invoke-static {v5}, Landroid/text/TextUtils;->isEmpty(Ljava/lang/CharSequence;)Z

    move-result v24

    if-nez v24, :cond_1

    .line 408
    new-instance v24, Ljava/lang/StringBuilder;

    invoke-direct/range {v24 .. v24}, Ljava/lang/StringBuilder;-><init>()V

    const-string v25, "CPU\u578b\u53f7\uff1a"

    invoke-virtual/range {v24 .. v25}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v24

    move-object/from16 v0, v24

    invoke-virtual {v0, v5}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v24

    invoke-virtual/range {v24 .. v24}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v4

    goto/16 :goto_2
.end method

.method private initData()V
    .locals 2

    .prologue
    .line 213
    new-instance v0, Lcom/cyjh/feedback/lib/dialog/LoadingDialog;

    invoke-virtual {p0}, Lcom/cyjh/feedback/lib/fragment/FeedBackInfoFragment;->getActivity()Landroid/support/v4/app/FragmentActivity;

    move-result-object v1

    invoke-direct {v0, v1}, Lcom/cyjh/feedback/lib/dialog/LoadingDialog;-><init>(Landroid/content/Context;)V

    iput-object v0, p0, Lcom/cyjh/feedback/lib/fragment/FeedBackInfoFragment;->mLoadingDialog:Lcom/cyjh/feedback/lib/dialog/LoadingDialog;

    .line 214
    return-void
.end method

.method private initEvent()V
    .locals 2

    .prologue
    .line 298
    iget-object v0, p0, Lcom/cyjh/feedback/lib/fragment/FeedBackInfoFragment;->mFeedBackInfo:Landroid/widget/EditText;

    new-instance v1, Lcom/cyjh/feedback/lib/fragment/FeedBackInfoFragment$4;

    invoke-direct {v1, p0}, Lcom/cyjh/feedback/lib/fragment/FeedBackInfoFragment$4;-><init>(Lcom/cyjh/feedback/lib/fragment/FeedBackInfoFragment;)V

    invoke-virtual {v0, v1}, Landroid/widget/EditText;->addTextChangedListener(Landroid/text/TextWatcher;)V

    .line 315
    iget-object v0, p0, Lcom/cyjh/feedback/lib/fragment/FeedBackInfoFragment;->mGridView:Landroid/widget/GridView;

    new-instance v1, Lcom/cyjh/feedback/lib/fragment/FeedBackInfoFragment$5;

    invoke-direct {v1, p0}, Lcom/cyjh/feedback/lib/fragment/FeedBackInfoFragment$5;-><init>(Lcom/cyjh/feedback/lib/fragment/FeedBackInfoFragment;)V

    invoke-virtual {v0, v1}, Landroid/widget/GridView;->setOnItemClickListener(Landroid/widget/AdapterView$OnItemClickListener;)V

    .line 325
    iget-object v0, p0, Lcom/cyjh/feedback/lib/fragment/FeedBackInfoFragment;->mAdapter:Lcom/cyjh/feedback/lib/adapter/ImageShowAdapter;

    new-instance v1, Lcom/cyjh/feedback/lib/fragment/FeedBackInfoFragment$6;

    invoke-direct {v1, p0}, Lcom/cyjh/feedback/lib/fragment/FeedBackInfoFragment$6;-><init>(Lcom/cyjh/feedback/lib/fragment/FeedBackInfoFragment;)V

    invoke-virtual {v0, v1}, Lcom/cyjh/feedback/lib/adapter/ImageShowAdapter;->setmDeleteSelectImg(Lcom/cyjh/feedback/lib/adapter/ImageShowAdapter$OnDeleteSelectImg;)V

    .line 331
    return-void
.end method

.method private initView(Landroid/view/View;)V
    .locals 7
    .param p1, "view"    # Landroid/view/View;

    .prologue
    const/4 v6, 0x1

    const/4 v5, 0x0

    .line 217
    sget v1, Lcom/cyjh/feedback/libraryfeedbackinfo/R$id;->grid_view:I

    invoke-virtual {p1, v1}, Landroid/view/View;->findViewById(I)Landroid/view/View;

    move-result-object v1

    check-cast v1, Landroid/widget/GridView;

    iput-object v1, p0, Lcom/cyjh/feedback/lib/fragment/FeedBackInfoFragment;->mGridView:Landroid/widget/GridView;

    .line 218
    sget v1, Lcom/cyjh/feedback/libraryfeedbackinfo/R$id;->id_et_qq_phone:I

    invoke-virtual {p1, v1}, Landroid/view/View;->findViewById(I)Landroid/view/View;

    move-result-object v1

    check-cast v1, Landroid/widget/EditText;

    iput-object v1, p0, Lcom/cyjh/feedback/lib/fragment/FeedBackInfoFragment;->mQQOrPhone:Landroid/widget/EditText;

    .line 219
    sget v1, Lcom/cyjh/feedback/libraryfeedbackinfo/R$id;->id_et_feedback:I

    invoke-virtual {p1, v1}, Landroid/view/View;->findViewById(I)Landroid/view/View;

    move-result-object v1

    check-cast v1, Landroid/widget/EditText;

    iput-object v1, p0, Lcom/cyjh/feedback/lib/fragment/FeedBackInfoFragment;->mFeedBackInfo:Landroid/widget/EditText;

    .line 220
    sget v1, Lcom/cyjh/feedback/libraryfeedbackinfo/R$id;->id_tv_image_num:I

    invoke-virtual {p1, v1}, Landroid/view/View;->findViewById(I)Landroid/view/View;

    move-result-object v1

    check-cast v1, Landroid/widget/TextView;

    iput-object v1, p0, Lcom/cyjh/feedback/lib/fragment/FeedBackInfoFragment;->mTvImageCount:Landroid/widget/TextView;

    .line 221
    sget v1, Lcom/cyjh/feedback/libraryfeedbackinfo/R$id;->id_btn_commit_feedback:I

    invoke-virtual {p1, v1}, Landroid/view/View;->findViewById(I)Landroid/view/View;

    move-result-object v0

    check-cast v0, Landroid/widget/Button;

    .line 222
    .local v0, "mBtnCommitInfo":Landroid/widget/Button;
    sget v1, Lcom/cyjh/feedback/libraryfeedbackinfo/R$id;->id_tv_feedback_input_font_num:I

    invoke-virtual {p1, v1}, Landroid/view/View;->findViewById(I)Landroid/view/View;

    move-result-object v1

    check-cast v1, Landroid/widget/TextView;

    iput-object v1, p0, Lcom/cyjh/feedback/lib/fragment/FeedBackInfoFragment;->mTvRecordFontNumber:Landroid/widget/TextView;

    .line 223
    new-instance v1, Lcom/cyjh/feedback/lib/adapter/ImageShowAdapter;

    invoke-virtual {p0}, Lcom/cyjh/feedback/lib/fragment/FeedBackInfoFragment;->getActivity()Landroid/support/v4/app/FragmentActivity;

    move-result-object v2

    const/4 v3, 0x0

    invoke-direct {v1, v2, v3}, Lcom/cyjh/feedback/lib/adapter/ImageShowAdapter;-><init>(Landroid/content/Context;Ljava/util/List;)V

    iput-object v1, p0, Lcom/cyjh/feedback/lib/fragment/FeedBackInfoFragment;->mAdapter:Lcom/cyjh/feedback/lib/adapter/ImageShowAdapter;

    .line 224
    iget-object v1, p0, Lcom/cyjh/feedback/lib/fragment/FeedBackInfoFragment;->mGridView:Landroid/widget/GridView;

    iget-object v2, p0, Lcom/cyjh/feedback/lib/fragment/FeedBackInfoFragment;->mAdapter:Lcom/cyjh/feedback/lib/adapter/ImageShowAdapter;

    invoke-virtual {v1, v2}, Landroid/widget/GridView;->setAdapter(Landroid/widget/ListAdapter;)V

    .line 225
    invoke-virtual {v0, p0}, Landroid/widget/Button;->setOnClickListener(Landroid/view/View$OnClickListener;)V

    .line 227
    iget-object v1, p0, Lcom/cyjh/feedback/lib/fragment/FeedBackInfoFragment;->mTvImageCount:Landroid/widget/TextView;

    sget v2, Lcom/cyjh/feedback/libraryfeedbackinfo/R$string;->image_add:I

    new-array v3, v6, [Ljava/lang/Object;

    iget-object v4, p0, Lcom/cyjh/feedback/lib/fragment/FeedBackInfoFragment;->mAddList:Ljava/util/List;

    invoke-interface {v4}, Ljava/util/List;->size()I

    move-result v4

    invoke-static {v4}, Ljava/lang/Integer;->valueOf(I)Ljava/lang/Integer;

    move-result-object v4

    aput-object v4, v3, v5

    invoke-virtual {p0, v2, v3}, Lcom/cyjh/feedback/lib/fragment/FeedBackInfoFragment;->getString(I[Ljava/lang/Object;)Ljava/lang/String;

    move-result-object v2

    invoke-virtual {v1, v2}, Landroid/widget/TextView;->setText(Ljava/lang/CharSequence;)V

    .line 229
    iget-object v1, p0, Lcom/cyjh/feedback/lib/fragment/FeedBackInfoFragment;->mTvRecordFontNumber:Landroid/widget/TextView;

    sget v2, Lcom/cyjh/feedback/libraryfeedbackinfo/R$string;->feedback_num_hint:I

    new-array v3, v6, [Ljava/lang/Object;

    invoke-static {v5}, Ljava/lang/Integer;->valueOf(I)Ljava/lang/Integer;

    move-result-object v4

    aput-object v4, v3, v5

    invoke-virtual {p0, v2, v3}, Lcom/cyjh/feedback/lib/fragment/FeedBackInfoFragment;->getString(I[Ljava/lang/Object;)Ljava/lang/String;

    move-result-object v2

    invoke-virtual {v1, v2}, Landroid/widget/TextView;->setText(Ljava/lang/CharSequence;)V

    .line 230
    new-instance v1, Lcom/cyjh/feedback/lib/entities/FeedBackInfoBean;

    invoke-direct {v1}, Lcom/cyjh/feedback/lib/entities/FeedBackInfoBean;-><init>()V

    iput-object v1, p0, Lcom/cyjh/feedback/lib/fragment/FeedBackInfoFragment;->mFeedBackInfoBean:Lcom/cyjh/feedback/lib/entities/FeedBackInfoBean;

    .line 232
    sget v1, Lcom/cyjh/feedback/libraryfeedbackinfo/R$id;->id_complaints_qq:I

    invoke-virtual {p1, v1}, Landroid/view/View;->findViewById(I)Landroid/view/View;

    move-result-object v1

    check-cast v1, Landroid/widget/TextView;

    iput-object v1, p0, Lcom/cyjh/feedback/lib/fragment/FeedBackInfoFragment;->mTvComplaintsQQ:Landroid/widget/TextView;

    .line 233
    sget v1, Lcom/cyjh/feedback/libraryfeedbackinfo/R$id;->id_line:I

    invoke-virtual {p1, v1}, Landroid/view/View;->findViewById(I)Landroid/view/View;

    move-result-object v1

    iput-object v1, p0, Lcom/cyjh/feedback/lib/fragment/FeedBackInfoFragment;->viewLine:Landroid/view/View;

    .line 235
    invoke-virtual {p0}, Lcom/cyjh/feedback/lib/fragment/FeedBackInfoFragment;->getArguments()Landroid/os/Bundle;

    move-result-object v1

    const-string v2, "feed_back_flag"

    invoke-virtual {v1, v2}, Landroid/os/Bundle;->getBoolean(Ljava/lang/String;)Z

    move-result v1

    iput-boolean v1, p0, Lcom/cyjh/feedback/lib/fragment/FeedBackInfoFragment;->flag:Z

    .line 236
    return-void
.end method

.method private isFillAllFeedbackInfo()V
    .locals 3

    .prologue
    const/4 v2, 0x0

    .line 428
    iget-object v0, p0, Lcom/cyjh/feedback/lib/fragment/FeedBackInfoFragment;->mFeedBackInfoBean:Lcom/cyjh/feedback/lib/entities/FeedBackInfoBean;

    invoke-virtual {v0}, Lcom/cyjh/feedback/lib/entities/FeedBackInfoBean;->getModel()Ljava/lang/String;

    move-result-object v0

    invoke-static {v0}, Lcom/cyjh/feedback/lib/utils/AppDevicesUtils;->isEmpty(Ljava/lang/String;)Z

    move-result v0

    if-nez v0, :cond_0

    iget-object v0, p0, Lcom/cyjh/feedback/lib/fragment/FeedBackInfoFragment;->mFeedBackInfoBean:Lcom/cyjh/feedback/lib/entities/FeedBackInfoBean;

    invoke-virtual {v0}, Lcom/cyjh/feedback/lib/entities/FeedBackInfoBean;->getModel()Ljava/lang/String;

    move-result-object v0

    invoke-static {v0}, Landroid/text/TextUtils;->isEmpty(Ljava/lang/CharSequence;)Z

    move-result v0

    if-eqz v0, :cond_1

    .line 429
    :cond_0
    iget-object v0, p0, Lcom/cyjh/feedback/lib/fragment/FeedBackInfoFragment;->mFeedBackInfoBean:Lcom/cyjh/feedback/lib/entities/FeedBackInfoBean;

    invoke-static {v2}, Ljava/lang/String;->valueOf(I)Ljava/lang/String;

    move-result-object v1

    invoke-virtual {v0, v1}, Lcom/cyjh/feedback/lib/entities/FeedBackInfoBean;->setModel(Ljava/lang/String;)V

    .line 431
    :cond_1
    iget-object v0, p0, Lcom/cyjh/feedback/lib/fragment/FeedBackInfoFragment;->mFeedBackInfoBean:Lcom/cyjh/feedback/lib/entities/FeedBackInfoBean;

    invoke-virtual {v0}, Lcom/cyjh/feedback/lib/entities/FeedBackInfoBean;->getAndoridData()Ljava/lang/String;

    move-result-object v0

    invoke-static {v0}, Landroid/text/TextUtils;->isEmpty(Ljava/lang/CharSequence;)Z

    move-result v0

    if-eqz v0, :cond_2

    .line 432
    iget-object v0, p0, Lcom/cyjh/feedback/lib/fragment/FeedBackInfoFragment;->mFeedBackInfoBean:Lcom/cyjh/feedback/lib/entities/FeedBackInfoBean;

    invoke-static {v2}, Ljava/lang/String;->valueOf(I)Ljava/lang/String;

    move-result-object v1

    invoke-virtual {v0, v1}, Lcom/cyjh/feedback/lib/entities/FeedBackInfoBean;->setAndoridData(Ljava/lang/String;)V

    .line 434
    :cond_2
    iget-object v0, p0, Lcom/cyjh/feedback/lib/fragment/FeedBackInfoFragment;->mFeedBackInfoBean:Lcom/cyjh/feedback/lib/entities/FeedBackInfoBean;

    invoke-virtual {v0}, Lcom/cyjh/feedback/lib/entities/FeedBackInfoBean;->getProcess()Ljava/lang/String;

    move-result-object v0

    invoke-static {v0}, Landroid/text/TextUtils;->isEmpty(Ljava/lang/CharSequence;)Z

    move-result v0

    if-eqz v0, :cond_3

    .line 435
    iget-object v0, p0, Lcom/cyjh/feedback/lib/fragment/FeedBackInfoFragment;->mFeedBackInfoBean:Lcom/cyjh/feedback/lib/entities/FeedBackInfoBean;

    invoke-static {v2}, Ljava/lang/String;->valueOf(I)Ljava/lang/String;

    move-result-object v1

    invoke-virtual {v0, v1}, Lcom/cyjh/feedback/lib/entities/FeedBackInfoBean;->setProcess(Ljava/lang/String;)V

    .line 437
    :cond_3
    iget-object v0, p0, Lcom/cyjh/feedback/lib/fragment/FeedBackInfoFragment;->mFeedBackInfoBean:Lcom/cyjh/feedback/lib/entities/FeedBackInfoBean;

    invoke-virtual {v0}, Lcom/cyjh/feedback/lib/entities/FeedBackInfoBean;->getIMEI()Ljava/lang/String;

    move-result-object v0

    invoke-static {v0}, Landroid/text/TextUtils;->isEmpty(Ljava/lang/CharSequence;)Z

    move-result v0

    if-eqz v0, :cond_4

    .line 438
    iget-object v0, p0, Lcom/cyjh/feedback/lib/fragment/FeedBackInfoFragment;->mFeedBackInfoBean:Lcom/cyjh/feedback/lib/entities/FeedBackInfoBean;

    invoke-static {v2}, Ljava/lang/String;->valueOf(I)Ljava/lang/String;

    move-result-object v1

    invoke-virtual {v0, v1}, Lcom/cyjh/feedback/lib/entities/FeedBackInfoBean;->setIMEI(Ljava/lang/String;)V

    .line 440
    :cond_4
    iget-object v0, p0, Lcom/cyjh/feedback/lib/fragment/FeedBackInfoFragment;->mFeedBackInfoBean:Lcom/cyjh/feedback/lib/entities/FeedBackInfoBean;

    invoke-virtual {v0}, Lcom/cyjh/feedback/lib/entities/FeedBackInfoBean;->getBaseBandVersion()Ljava/lang/String;

    move-result-object v0

    invoke-static {v0}, Landroid/text/TextUtils;->isEmpty(Ljava/lang/CharSequence;)Z

    move-result v0

    if-eqz v0, :cond_5

    .line 441
    iget-object v0, p0, Lcom/cyjh/feedback/lib/fragment/FeedBackInfoFragment;->mFeedBackInfoBean:Lcom/cyjh/feedback/lib/entities/FeedBackInfoBean;

    invoke-static {v2}, Ljava/lang/String;->valueOf(I)Ljava/lang/String;

    move-result-object v1

    invoke-virtual {v0, v1}, Lcom/cyjh/feedback/lib/entities/FeedBackInfoBean;->setBaseBandVersion(Ljava/lang/String;)V

    .line 443
    :cond_5
    iget-object v0, p0, Lcom/cyjh/feedback/lib/fragment/FeedBackInfoFragment;->mFeedBackInfoBean:Lcom/cyjh/feedback/lib/entities/FeedBackInfoBean;

    invoke-virtual {v0}, Lcom/cyjh/feedback/lib/entities/FeedBackInfoBean;->getCoreVersion()Ljava/lang/String;

    move-result-object v0

    invoke-static {v0}, Landroid/text/TextUtils;->isEmpty(Ljava/lang/CharSequence;)Z

    move-result v0

    if-eqz v0, :cond_6

    .line 444
    iget-object v0, p0, Lcom/cyjh/feedback/lib/fragment/FeedBackInfoFragment;->mFeedBackInfoBean:Lcom/cyjh/feedback/lib/entities/FeedBackInfoBean;

    invoke-static {v2}, Ljava/lang/String;->valueOf(I)Ljava/lang/String;

    move-result-object v1

    invoke-virtual {v0, v1}, Lcom/cyjh/feedback/lib/entities/FeedBackInfoBean;->setCoreVersion(Ljava/lang/String;)V

    .line 446
    :cond_6
    iget-object v0, p0, Lcom/cyjh/feedback/lib/fragment/FeedBackInfoFragment;->mFeedBackInfoBean:Lcom/cyjh/feedback/lib/entities/FeedBackInfoBean;

    invoke-virtual {v0}, Lcom/cyjh/feedback/lib/entities/FeedBackInfoBean;->getRAM()Ljava/lang/String;

    move-result-object v0

    invoke-static {v0}, Landroid/text/TextUtils;->isEmpty(Ljava/lang/CharSequence;)Z

    move-result v0

    if-eqz v0, :cond_7

    .line 447
    iget-object v0, p0, Lcom/cyjh/feedback/lib/fragment/FeedBackInfoFragment;->mFeedBackInfoBean:Lcom/cyjh/feedback/lib/entities/FeedBackInfoBean;

    invoke-static {v2}, Ljava/lang/String;->valueOf(I)Ljava/lang/String;

    move-result-object v1

    invoke-virtual {v0, v1}, Lcom/cyjh/feedback/lib/entities/FeedBackInfoBean;->setRAM(Ljava/lang/String;)V

    .line 449
    :cond_7
    iget-object v0, p0, Lcom/cyjh/feedback/lib/fragment/FeedBackInfoFragment;->mFeedBackInfoBean:Lcom/cyjh/feedback/lib/entities/FeedBackInfoBean;

    invoke-virtual {v0}, Lcom/cyjh/feedback/lib/entities/FeedBackInfoBean;->getGUID()Ljava/lang/String;

    move-result-object v0

    invoke-static {v0}, Landroid/text/TextUtils;->isEmpty(Ljava/lang/CharSequence;)Z

    move-result v0

    if-eqz v0, :cond_8

    .line 450
    iget-object v0, p0, Lcom/cyjh/feedback/lib/fragment/FeedBackInfoFragment;->mFeedBackInfoBean:Lcom/cyjh/feedback/lib/entities/FeedBackInfoBean;

    invoke-static {v2}, Ljava/lang/String;->valueOf(I)Ljava/lang/String;

    move-result-object v1

    invoke-virtual {v0, v1}, Lcom/cyjh/feedback/lib/entities/FeedBackInfoBean;->setGUID(Ljava/lang/String;)V

    .line 452
    :cond_8
    iget-object v0, p0, Lcom/cyjh/feedback/lib/fragment/FeedBackInfoFragment;->mFeedBackInfoBean:Lcom/cyjh/feedback/lib/entities/FeedBackInfoBean;

    invoke-virtual {v0}, Lcom/cyjh/feedback/lib/entities/FeedBackInfoBean;->getDPI()Ljava/lang/String;

    move-result-object v0

    invoke-static {v0}, Ljava/lang/String;->valueOf(Ljava/lang/Object;)Ljava/lang/String;

    move-result-object v0

    invoke-static {v0}, Landroid/text/TextUtils;->isEmpty(Ljava/lang/CharSequence;)Z

    move-result v0

    if-eqz v0, :cond_9

    .line 453
    iget-object v0, p0, Lcom/cyjh/feedback/lib/fragment/FeedBackInfoFragment;->mFeedBackInfoBean:Lcom/cyjh/feedback/lib/entities/FeedBackInfoBean;

    invoke-static {v2}, Ljava/lang/String;->valueOf(I)Ljava/lang/String;

    move-result-object v1

    invoke-virtual {v0, v1}, Lcom/cyjh/feedback/lib/entities/FeedBackInfoBean;->setDPI(Ljava/lang/String;)V

    .line 455
    :cond_9
    iget-object v0, p0, Lcom/cyjh/feedback/lib/fragment/FeedBackInfoFragment;->mFeedBackInfoBean:Lcom/cyjh/feedback/lib/entities/FeedBackInfoBean;

    invoke-virtual {v0}, Lcom/cyjh/feedback/lib/entities/FeedBackInfoBean;->getResolution()Ljava/lang/String;

    move-result-object v0

    invoke-static {v0}, Landroid/text/TextUtils;->isEmpty(Ljava/lang/CharSequence;)Z

    move-result v0

    if-eqz v0, :cond_a

    .line 456
    iget-object v0, p0, Lcom/cyjh/feedback/lib/fragment/FeedBackInfoFragment;->mFeedBackInfoBean:Lcom/cyjh/feedback/lib/entities/FeedBackInfoBean;

    invoke-static {v2}, Ljava/lang/String;->valueOf(I)Ljava/lang/String;

    move-result-object v1

    invoke-virtual {v0, v1}, Lcom/cyjh/feedback/lib/entities/FeedBackInfoBean;->setResolution(Ljava/lang/String;)V

    .line 458
    :cond_a
    iget-object v0, p0, Lcom/cyjh/feedback/lib/fragment/FeedBackInfoFragment;->mFeedBackInfoBean:Lcom/cyjh/feedback/lib/entities/FeedBackInfoBean;

    invoke-virtual {v0}, Lcom/cyjh/feedback/lib/entities/FeedBackInfoBean;->getSerialNumber()Ljava/lang/String;

    move-result-object v0

    invoke-static {v0}, Landroid/text/TextUtils;->isEmpty(Ljava/lang/CharSequence;)Z

    move-result v0

    if-eqz v0, :cond_b

    .line 459
    iget-object v0, p0, Lcom/cyjh/feedback/lib/fragment/FeedBackInfoFragment;->mFeedBackInfoBean:Lcom/cyjh/feedback/lib/entities/FeedBackInfoBean;

    invoke-static {v2}, Ljava/lang/String;->valueOf(I)Ljava/lang/String;

    move-result-object v1

    invoke-virtual {v0, v1}, Lcom/cyjh/feedback/lib/entities/FeedBackInfoBean;->setSerialNumber(Ljava/lang/String;)V

    .line 461
    :cond_b
    iget-object v0, p0, Lcom/cyjh/feedback/lib/fragment/FeedBackInfoFragment;->mFeedBackInfoBean:Lcom/cyjh/feedback/lib/entities/FeedBackInfoBean;

    invoke-virtual {v0}, Lcom/cyjh/feedback/lib/entities/FeedBackInfoBean;->getSystemVersion()Ljava/lang/String;

    move-result-object v0

    invoke-static {v0}, Landroid/text/TextUtils;->isEmpty(Ljava/lang/CharSequence;)Z

    move-result v0

    if-eqz v0, :cond_c

    .line 462
    iget-object v0, p0, Lcom/cyjh/feedback/lib/fragment/FeedBackInfoFragment;->mFeedBackInfoBean:Lcom/cyjh/feedback/lib/entities/FeedBackInfoBean;

    invoke-static {v2}, Ljava/lang/String;->valueOf(I)Ljava/lang/String;

    move-result-object v1

    invoke-virtual {v0, v1}, Lcom/cyjh/feedback/lib/entities/FeedBackInfoBean;->setSystemVersion(Ljava/lang/String;)V

    .line 464
    :cond_c
    return-void
.end method

.method public static newInstance(Ljava/lang/String;Z)Lcom/cyjh/feedback/lib/fragment/FeedBackInfoFragment;
    .locals 3
    .param p0, "guid"    # Ljava/lang/String;
    .param p1, "flag"    # Z

    .prologue
    .line 185
    new-instance v1, Lcom/cyjh/feedback/lib/fragment/FeedBackInfoFragment;

    invoke-direct {v1}, Lcom/cyjh/feedback/lib/fragment/FeedBackInfoFragment;-><init>()V

    .line 186
    .local v1, "feedBackInfoFragment":Lcom/cyjh/feedback/lib/fragment/FeedBackInfoFragment;
    new-instance v0, Landroid/os/Bundle;

    invoke-direct {v0}, Landroid/os/Bundle;-><init>()V

    .line 187
    .local v0, "bundle":Landroid/os/Bundle;
    const-string v2, "guid"

    invoke-virtual {v0, v2, p0}, Landroid/os/Bundle;->putString(Ljava/lang/String;Ljava/lang/String;)V

    .line 188
    const-string v2, "feed_back_flag"

    invoke-virtual {v0, v2, p1}, Landroid/os/Bundle;->putBoolean(Ljava/lang/String;Z)V

    .line 189
    invoke-virtual {v1, v0}, Lcom/cyjh/feedback/lib/fragment/FeedBackInfoFragment;->setArguments(Landroid/os/Bundle;)V

    .line 190
    return-object v1
.end method

.method private requestNet()V
    .locals 6

    .prologue
    const/4 v5, 0x0

    .line 243
    new-instance v0, Landroid/net/Uri$Builder;

    invoke-direct {v0}, Landroid/net/Uri$Builder;-><init>()V

    .line 244
    .local v0, "builder":Landroid/net/Uri$Builder;
    const-string v2, "http"

    invoke-virtual {v0, v2}, Landroid/net/Uri$Builder;->scheme(Ljava/lang/String;)Landroid/net/Uri$Builder;

    move-result-object v2

    const-string v3, "api.mobileanjian.com"

    invoke-virtual {v2, v3}, Landroid/net/Uri$Builder;->encodedAuthority(Ljava/lang/String;)Landroid/net/Uri$Builder;

    move-result-object v2

    const-string v3, "api"

    .line 245
    invoke-virtual {v2, v3}, Landroid/net/Uri$Builder;->appendPath(Ljava/lang/String;)Landroid/net/Uri$Builder;

    move-result-object v2

    const-string v3, "GetAuthorFeedback"

    invoke-virtual {v2, v3}, Landroid/net/Uri$Builder;->appendPath(Ljava/lang/String;)Landroid/net/Uri$Builder;

    move-result-object v2

    const-string v3, "Appid"

    iget-object v4, p0, Lcom/cyjh/feedback/lib/fragment/FeedBackInfoFragment;->onlyOneGuid:Ljava/lang/String;

    .line 246
    invoke-virtual {v2, v3, v4}, Landroid/net/Uri$Builder;->appendQueryParameter(Ljava/lang/String;Ljava/lang/String;)Landroid/net/Uri$Builder;

    .line 247
    invoke-virtual {v0}, Landroid/net/Uri$Builder;->build()Landroid/net/Uri;

    move-result-object v2

    invoke-virtual {v2}, Landroid/net/Uri;->toString()Ljava/lang/String;

    move-result-object v2

    new-array v3, v5, [Ljava/lang/Object;

    invoke-static {v2, v3}, Lcom/orhanobut/logger/Logger;->e(Ljava/lang/String;[Ljava/lang/Object;)V

    .line 249
    invoke-static {}, Lcom/cyjh/feedback/lib/base/BaseDialog;->getmRequestQueue()Lcom/android/volley/RequestQueue;

    move-result-object v2

    const-string v3, "BaseDialog"

    invoke-virtual {v2, v3}, Lcom/android/volley/RequestQueue;->cancelAll(Ljava/lang/Object;)V

    .line 250
    new-instance v1, Lcom/android/volley/toolbox/StringRequest;

    invoke-virtual {v0}, Landroid/net/Uri$Builder;->build()Landroid/net/Uri;

    move-result-object v2

    invoke-virtual {v2}, Landroid/net/Uri;->toString()Ljava/lang/String;

    move-result-object v2

    new-instance v3, Lcom/cyjh/feedback/lib/fragment/FeedBackInfoFragment$2;

    invoke-direct {v3, p0}, Lcom/cyjh/feedback/lib/fragment/FeedBackInfoFragment$2;-><init>(Lcom/cyjh/feedback/lib/fragment/FeedBackInfoFragment;)V

    new-instance v4, Lcom/cyjh/feedback/lib/fragment/FeedBackInfoFragment$3;

    invoke-direct {v4, p0}, Lcom/cyjh/feedback/lib/fragment/FeedBackInfoFragment$3;-><init>(Lcom/cyjh/feedback/lib/fragment/FeedBackInfoFragment;)V

    invoke-direct {v1, v5, v2, v3, v4}, Lcom/android/volley/toolbox/StringRequest;-><init>(ILjava/lang/String;Lcom/android/volley/Response$Listener;Lcom/android/volley/Response$ErrorListener;)V

    .line 291
    .local v1, "stringRequest":Lcom/android/volley/toolbox/StringRequest;
    const-string v2, "BaseDialog"

    invoke-virtual {v1, v2}, Lcom/android/volley/toolbox/StringRequest;->setTag(Ljava/lang/Object;)Lcom/android/volley/Request;

    .line 292
    invoke-virtual {v1, v5}, Lcom/android/volley/toolbox/StringRequest;->setShouldCache(Z)Lcom/android/volley/Request;

    .line 293
    invoke-static {}, Lcom/cyjh/feedback/lib/base/BaseDialog;->getmRequestQueue()Lcom/android/volley/RequestQueue;

    move-result-object v2

    invoke-virtual {v2, v1}, Lcom/android/volley/RequestQueue;->add(Lcom/android/volley/Request;)Lcom/android/volley/Request;

    .line 294
    return-void
.end method

.method private showFeedbackDialog()V
    .locals 3

    .prologue
    .line 146
    new-instance v0, Lcom/cyjh/feedback/lib/dialog/FeedBackDialog;

    invoke-virtual {p0}, Lcom/cyjh/feedback/lib/fragment/FeedBackInfoFragment;->getActivity()Landroid/support/v4/app/FragmentActivity;

    move-result-object v1

    iget-object v2, p0, Lcom/cyjh/feedback/lib/fragment/FeedBackInfoFragment;->mFeedBackInfoBean:Lcom/cyjh/feedback/lib/entities/FeedBackInfoBean;

    invoke-direct {v0, v1, v2}, Lcom/cyjh/feedback/lib/dialog/FeedBackDialog;-><init>(Landroid/content/Context;Lcom/cyjh/feedback/lib/entities/FeedBackInfoBean;)V

    .line 147
    .local v0, "mFeedBackDialog":Lcom/cyjh/feedback/lib/dialog/FeedBackDialog;
    invoke-virtual {v0}, Lcom/cyjh/feedback/lib/dialog/FeedBackDialog;->show()V

    .line 148
    new-instance v1, Lcom/cyjh/feedback/lib/fragment/FeedBackInfoFragment$1;

    invoke-direct {v1, p0}, Lcom/cyjh/feedback/lib/fragment/FeedBackInfoFragment$1;-><init>(Lcom/cyjh/feedback/lib/fragment/FeedBackInfoFragment;)V

    invoke-virtual {v0, v1}, Lcom/cyjh/feedback/lib/dialog/FeedBackDialog;->setOnResultCode(Lcom/cyjh/feedback/lib/dialog/FeedBackDialog$OnResultCode;)V

    .line 161
    return-void
.end method


# virtual methods
.method public getFragmentLayoutId()I
    .locals 1

    .prologue
    .line 200
    sget v0, Lcom/cyjh/feedback/libraryfeedbackinfo/R$layout;->fragment_feedback_info:I

    return v0
.end method

.method public onActivityResult(IILandroid/content/Intent;)V
    .locals 10
    .param p1, "requestCode"    # I
    .param p2, "resultCode"    # I
    .param p3, "data"    # Landroid/content/Intent;

    .prologue
    const/4 v9, 0x1

    const/4 v8, 0x0

    .line 499
    invoke-super {p0, p1, p2, p3}, Lcom/cyjh/feedback/lib/base/BaseFragment;->onActivityResult(IILandroid/content/Intent;)V

    .line 500
    const/16 v4, 0x100

    if-ne p1, v4, :cond_0

    const/4 v4, -0x1

    if-ne p2, v4, :cond_0

    .line 502
    if-eqz p3, :cond_0

    .line 503
    const-string v4, "bundle"

    invoke-virtual {p3, v4}, Landroid/content/Intent;->getBundleExtra(Ljava/lang/String;)Landroid/os/Bundle;

    move-result-object v1

    .line 504
    .local v1, "bundle":Landroid/os/Bundle;
    const-string v4, "image"

    invoke-virtual {v1, v4}, Landroid/os/Bundle;->getStringArrayList(Ljava/lang/String;)Ljava/util/ArrayList;

    move-result-object v2

    .line 505
    .local v2, "mDataList":Ljava/util/ArrayList;, "Ljava/util/ArrayList<Ljava/lang/String;>;"
    if-nez v2, :cond_1

    .line 529
    .end local v1    # "bundle":Landroid/os/Bundle;
    .end local v2    # "mDataList":Ljava/util/ArrayList;, "Ljava/util/ArrayList<Ljava/lang/String;>;"
    :cond_0
    :goto_0
    return-void

    .line 508
    .restart local v1    # "bundle":Landroid/os/Bundle;
    .restart local v2    # "mDataList":Ljava/util/ArrayList;, "Ljava/util/ArrayList<Ljava/lang/String;>;"
    :cond_1
    new-instance v4, Ljava/lang/StringBuilder;

    invoke-direct {v4}, Ljava/lang/StringBuilder;-><init>()V

    const-string v5, "mDataList:"

    invoke-virtual {v4, v5}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v4

    invoke-virtual {v2}, Ljava/util/ArrayList;->size()I

    move-result v5

    invoke-virtual {v4, v5}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v4

    invoke-virtual {v4}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v4

    new-array v5, v8, [Ljava/lang/Object;

    invoke-static {v4, v5}, Lcom/orhanobut/logger/Logger;->e(Ljava/lang/String;[Ljava/lang/Object;)V

    .line 509
    iget-object v4, p0, Lcom/cyjh/feedback/lib/fragment/FeedBackInfoFragment;->mAddList:Ljava/util/List;

    invoke-interface {v4}, Ljava/util/List;->size()I

    move-result v0

    .line 510
    .local v0, "arrayListSize":I
    new-instance v4, Ljava/lang/StringBuilder;

    invoke-direct {v4}, Ljava/lang/StringBuilder;-><init>()V

    const-string v5, "mAddListSize:"

    invoke-virtual {v4, v5}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v4

    iget-object v5, p0, Lcom/cyjh/feedback/lib/fragment/FeedBackInfoFragment;->mAddList:Ljava/util/List;

    invoke-interface {v5}, Ljava/util/List;->size()I

    move-result v5

    invoke-virtual {v4, v5}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v4

    invoke-virtual {v4}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v4

    new-array v5, v8, [Ljava/lang/Object;

    invoke-static {v4, v5}, Lcom/orhanobut/logger/Logger;->e(Ljava/lang/String;[Ljava/lang/Object;)V

    .line 511
    invoke-virtual {v2}, Ljava/util/ArrayList;->size()I

    move-result v4

    add-int/2addr v4, v0

    const/4 v5, 0x4

    if-le v4, v5, :cond_2

    .line 512
    invoke-virtual {p0}, Lcom/cyjh/feedback/lib/fragment/FeedBackInfoFragment;->getActivity()Landroid/support/v4/app/FragmentActivity;

    move-result-object v4

    sget v5, Lcom/cyjh/feedback/libraryfeedbackinfo/R$string;->img_num_limit:I

    const/4 v6, 0x2

    new-array v6, v6, [Ljava/lang/Object;

    invoke-static {v0}, Ljava/lang/Integer;->valueOf(I)Ljava/lang/Integer;

    move-result-object v7

    aput-object v7, v6, v8

    rsub-int/lit8 v7, v0, 0x4

    invoke-static {v7}, Ljava/lang/Integer;->valueOf(I)Ljava/lang/Integer;

    move-result-object v7

    aput-object v7, v6, v9

    invoke-virtual {p0, v5, v6}, Lcom/cyjh/feedback/lib/fragment/FeedBackInfoFragment;->getString(I[Ljava/lang/Object;)Ljava/lang/String;

    move-result-object v5

    invoke-static {v4, v5, v9}, Landroid/widget/Toast;->makeText(Landroid/content/Context;Ljava/lang/CharSequence;I)Landroid/widget/Toast;

    move-result-object v4

    invoke-virtual {v4}, Landroid/widget/Toast;->show()V

    .line 513
    invoke-virtual {v2}, Ljava/util/ArrayList;->clear()V

    goto :goto_0

    .line 516
    :cond_2
    invoke-virtual {v2}, Ljava/util/ArrayList;->iterator()Ljava/util/Iterator;

    move-result-object v4

    :cond_3
    :goto_1
    invoke-interface {v4}, Ljava/util/Iterator;->hasNext()Z

    move-result v5

    if-eqz v5, :cond_4

    invoke-interface {v4}, Ljava/util/Iterator;->next()Ljava/lang/Object;

    move-result-object v3

    check-cast v3, Ljava/lang/String;

    .line 517
    .local v3, "path":Ljava/lang/String;
    iget-object v5, p0, Lcom/cyjh/feedback/lib/fragment/FeedBackInfoFragment;->mAddList:Ljava/util/List;

    invoke-interface {v5, v3}, Ljava/util/List;->contains(Ljava/lang/Object;)Z

    move-result v5

    if-nez v5, :cond_3

    .line 518
    iget-object v5, p0, Lcom/cyjh/feedback/lib/fragment/FeedBackInfoFragment;->mAddList:Ljava/util/List;

    invoke-interface {v5, v3}, Ljava/util/List;->add(Ljava/lang/Object;)Z

    goto :goto_1

    .line 521
    .end local v3    # "path":Ljava/lang/String;
    :cond_4
    const-string v4, "zzz"

    new-instance v5, Ljava/lang/StringBuilder;

    invoke-direct {v5}, Ljava/lang/StringBuilder;-><init>()V

    const-string v6, "\u56fe\u7247\u9009\u62e9"

    invoke-virtual {v5, v6}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v5

    iget-object v6, p0, Lcom/cyjh/feedback/lib/fragment/FeedBackInfoFragment;->mAddList:Ljava/util/List;

    invoke-interface {v6}, Ljava/util/List;->size()I

    move-result v6

    invoke-virtual {v5, v6}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v5

    invoke-virtual {v5}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v5

    invoke-static {v4, v5}, Landroid/util/Log;->e(Ljava/lang/String;Ljava/lang/String;)I

    .line 522
    iget-object v4, p0, Lcom/cyjh/feedback/lib/fragment/FeedBackInfoFragment;->mTvImageCount:Landroid/widget/TextView;

    sget v5, Lcom/cyjh/feedback/libraryfeedbackinfo/R$string;->image_add:I

    new-array v6, v9, [Ljava/lang/Object;

    iget-object v7, p0, Lcom/cyjh/feedback/lib/fragment/FeedBackInfoFragment;->mAddList:Ljava/util/List;

    invoke-interface {v7}, Ljava/util/List;->size()I

    move-result v7

    invoke-static {v7}, Ljava/lang/Integer;->valueOf(I)Ljava/lang/Integer;

    move-result-object v7

    aput-object v7, v6, v8

    invoke-virtual {p0, v5, v6}, Lcom/cyjh/feedback/lib/fragment/FeedBackInfoFragment;->getString(I[Ljava/lang/Object;)Ljava/lang/String;

    move-result-object v5

    invoke-virtual {v4, v5}, Landroid/widget/TextView;->setText(Ljava/lang/CharSequence;)V

    .line 523
    iget-object v4, p0, Lcom/cyjh/feedback/lib/fragment/FeedBackInfoFragment;->mAdapter:Lcom/cyjh/feedback/lib/adapter/ImageShowAdapter;

    iget-object v5, p0, Lcom/cyjh/feedback/lib/fragment/FeedBackInfoFragment;->mAddList:Ljava/util/List;

    invoke-virtual {v4, v5}, Lcom/cyjh/feedback/lib/adapter/ImageShowAdapter;->setmData(Ljava/util/List;)V

    .line 525
    iget-object v4, p0, Lcom/cyjh/feedback/lib/fragment/FeedBackInfoFragment;->mGridView:Landroid/widget/GridView;

    iget-object v5, p0, Lcom/cyjh/feedback/lib/fragment/FeedBackInfoFragment;->mAdapter:Lcom/cyjh/feedback/lib/adapter/ImageShowAdapter;

    invoke-virtual {v4, v5}, Landroid/widget/GridView;->setAdapter(Landroid/widget/ListAdapter;)V

    .line 526
    iget-object v4, p0, Lcom/cyjh/feedback/lib/fragment/FeedBackInfoFragment;->mAdapter:Lcom/cyjh/feedback/lib/adapter/ImageShowAdapter;

    invoke-virtual {v4}, Lcom/cyjh/feedback/lib/adapter/ImageShowAdapter;->notifyDataSetChanged()V

    goto/16 :goto_0
.end method

.method public onClick(Landroid/view/View;)V
    .locals 6
    .param p1, "v"    # Landroid/view/View;

    .prologue
    .line 335
    invoke-virtual {p1}, Landroid/view/View;->getId()I

    move-result v0

    .line 337
    .local v0, "id":I
    sget v1, Lcom/cyjh/feedback/libraryfeedbackinfo/R$id;->id_btn_commit_feedback:I

    if-ne v0, v1, :cond_0

    .line 338
    iget-object v1, p0, Lcom/cyjh/feedback/lib/fragment/FeedBackInfoFragment;->mLoadingDialog:Lcom/cyjh/feedback/lib/dialog/LoadingDialog;

    invoke-virtual {v1}, Lcom/cyjh/feedback/lib/dialog/LoadingDialog;->show()V

    .line 339
    invoke-direct {p0}, Lcom/cyjh/feedback/lib/fragment/FeedBackInfoFragment;->getFeedBackInfo()V

    .line 340
    invoke-direct {p0}, Lcom/cyjh/feedback/lib/fragment/FeedBackInfoFragment;->isFillAllFeedbackInfo()V

    .line 341
    invoke-static {}, Lcom/cyjh/feedback/lib/executor/ThreadPoolProxyFactory;->getNormalThreadPool()Lcom/cyjh/feedback/lib/executor/ThreadPoolProxy;

    move-result-object v1

    new-instance v2, Lcom/cyjh/feedback/lib/runnable/TraversePicRunnable;

    .line 342
    invoke-virtual {p0}, Lcom/cyjh/feedback/lib/fragment/FeedBackInfoFragment;->getActivity()Landroid/support/v4/app/FragmentActivity;

    move-result-object v3

    iget-object v4, p0, Lcom/cyjh/feedback/lib/fragment/FeedBackInfoFragment;->mHandler:Lcom/cyjh/feedback/lib/fragment/FeedBackInfoFragment$MyHandler;

    iget-object v5, p0, Lcom/cyjh/feedback/lib/fragment/FeedBackInfoFragment;->mAddList:Ljava/util/List;

    invoke-direct {v2, v3, v4, v5}, Lcom/cyjh/feedback/lib/runnable/TraversePicRunnable;-><init>(Landroid/content/Context;Landroid/os/Handler;Ljava/util/List;)V

    invoke-virtual {v1, v2}, Lcom/cyjh/feedback/lib/executor/ThreadPoolProxy;->executeRunnable(Ljava/lang/Runnable;)V

    .line 344
    :cond_0
    return-void
.end method

.method public onCreate(Landroid/os/Bundle;)V
    .locals 2
    .param p1, "savedInstanceState"    # Landroid/os/Bundle;

    .prologue
    .line 195
    invoke-super {p0, p1}, Lcom/cyjh/feedback/lib/base/BaseFragment;->onCreate(Landroid/os/Bundle;)V

    .line 196
    invoke-virtual {p0}, Lcom/cyjh/feedback/lib/fragment/FeedBackInfoFragment;->getArguments()Landroid/os/Bundle;

    move-result-object v0

    const-string v1, "guid"

    invoke-virtual {v0, v1}, Landroid/os/Bundle;->get(Ljava/lang/String;)Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Ljava/lang/String;

    iput-object v0, p0, Lcom/cyjh/feedback/lib/fragment/FeedBackInfoFragment;->onlyOneGuid:Ljava/lang/String;

    .line 197
    return-void
.end method

.method public onDestroy()V
    .locals 2

    .prologue
    const/4 v1, 0x0

    .line 545
    invoke-super {p0}, Lcom/cyjh/feedback/lib/base/BaseFragment;->onDestroy()V

    .line 546
    iget-object v0, p0, Lcom/cyjh/feedback/lib/fragment/FeedBackInfoFragment;->mHandler:Lcom/cyjh/feedback/lib/fragment/FeedBackInfoFragment$MyHandler;

    invoke-virtual {v0, v1}, Lcom/cyjh/feedback/lib/fragment/FeedBackInfoFragment$MyHandler;->removeCallbacksAndMessages(Ljava/lang/Object;)V

    .line 547
    iput-object v1, p0, Lcom/cyjh/feedback/lib/fragment/FeedBackInfoFragment;->mHandler:Lcom/cyjh/feedback/lib/fragment/FeedBackInfoFragment$MyHandler;

    .line 548
    return-void
.end method

.method public onPause()V
    .locals 1

    .prologue
    .line 539
    invoke-super {p0}, Lcom/cyjh/feedback/lib/base/BaseFragment;->onPause()V

    .line 540
    const-class v0, Lcom/cyjh/feedback/lib/fragment/FeedBackInfoFragment;

    invoke-virtual {v0}, Ljava/lang/Class;->getCanonicalName()Ljava/lang/String;

    move-result-object v0

    invoke-static {v0}, Lcom/umeng/analytics/MobclickAgent;->onPageEnd(Ljava/lang/String;)V

    .line 541
    return-void
.end method

.method public onResume()V
    .locals 1

    .prologue
    .line 533
    invoke-super {p0}, Lcom/cyjh/feedback/lib/base/BaseFragment;->onResume()V

    .line 534
    const-class v0, Lcom/cyjh/feedback/lib/fragment/FeedBackInfoFragment;

    invoke-virtual {v0}, Ljava/lang/Class;->getCanonicalName()Ljava/lang/String;

    move-result-object v0

    invoke-static {v0}, Lcom/umeng/analytics/MobclickAgent;->onPageStart(Ljava/lang/String;)V

    .line 535
    return-void
.end method

.method public onViewCreated(Landroid/view/View;Landroid/os/Bundle;)V
    .locals 0
    .param p1, "view"    # Landroid/view/View;
    .param p2, "savedInstanceState"    # Landroid/os/Bundle;

    .prologue
    .line 205
    invoke-super {p0, p1, p2}, Lcom/cyjh/feedback/lib/base/BaseFragment;->onViewCreated(Landroid/view/View;Landroid/os/Bundle;)V

    .line 206
    invoke-direct {p0, p1}, Lcom/cyjh/feedback/lib/fragment/FeedBackInfoFragment;->initView(Landroid/view/View;)V

    .line 207
    invoke-direct {p0}, Lcom/cyjh/feedback/lib/fragment/FeedBackInfoFragment;->initData()V

    .line 208
    invoke-direct {p0}, Lcom/cyjh/feedback/lib/fragment/FeedBackInfoFragment;->requestNet()V

    .line 209
    invoke-direct {p0}, Lcom/cyjh/feedback/lib/fragment/FeedBackInfoFragment;->initEvent()V

    .line 210
    return-void
.end method
