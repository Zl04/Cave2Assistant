.class public Lcom/cyjh/elfin/customview/GameDownloadView;
.super Landroid/widget/RelativeLayout;
.source "GameDownloadView.java"

# interfaces
.implements Lcom/kaopu/download/intf/IDownloadView;
.implements Landroid/view/View$OnClickListener;


# annotations
.annotation system Ldalvik/annotation/MemberClasses;
    value = {
        Lcom/cyjh/elfin/customview/GameDownloadView$DownloadDisplayHelper;
    }
.end annotation

.annotation system Ldalvik/annotation/Signature;
    value = {
        "Landroid/widget/RelativeLayout;",
        "Lcom/kaopu/download/intf/IDownloadView",
        "<",
        "Lcom/kaopu/download/kernel/BaseDownloadInfo;",
        ">;",
        "Landroid/view/View$OnClickListener;"
    }
.end annotation


# instance fields
.field private fileSize:Ljava/lang/String;

.field private isDetailsDownload:Z

.field protected mClickHelper:Lcom/cyjh/elfin/download/GameDownloadHelper;

.field protected mContext:Landroid/content/Context;

.field protected mDisplayHelper:Lcom/cyjh/elfin/customview/GameDownloadView$DownloadDisplayHelper;

.field private mGameInfo:Lcom/cyjh/elfin/entity/GameInfo;

.field private mInfo:Lcom/kaopu/download/kernel/BaseDownloadInfo;

.field private progressBar:Landroid/widget/ProgressBar;

.field private updateBtn:Landroid/widget/TextView;

.field private updateRl:Landroid/widget/RelativeLayout;


# direct methods
.method public constructor <init>(Landroid/content/Context;)V
    .locals 1
    .param p1, "context"    # Landroid/content/Context;

    .prologue
    .line 56
    invoke-direct {p0, p1}, Landroid/widget/RelativeLayout;-><init>(Landroid/content/Context;)V

    .line 52
    const/4 v0, 0x0

    iput-boolean v0, p0, Lcom/cyjh/elfin/customview/GameDownloadView;->isDetailsDownload:Z

    .line 66
    new-instance v0, Lcom/cyjh/elfin/customview/GameDownloadView$DownloadDisplayHelper;

    invoke-direct {v0, p0, p0}, Lcom/cyjh/elfin/customview/GameDownloadView$DownloadDisplayHelper;-><init>(Lcom/cyjh/elfin/customview/GameDownloadView;Lcom/kaopu/download/intf/IDownloadView;)V

    iput-object v0, p0, Lcom/cyjh/elfin/customview/GameDownloadView;->mDisplayHelper:Lcom/cyjh/elfin/customview/GameDownloadView$DownloadDisplayHelper;

    .line 70
    new-instance v0, Lcom/cyjh/elfin/download/GameDownloadHelper;

    invoke-direct {v0, p0}, Lcom/cyjh/elfin/download/GameDownloadHelper;-><init>(Lcom/kaopu/download/intf/IDownloadView;)V

    iput-object v0, p0, Lcom/cyjh/elfin/customview/GameDownloadView;->mClickHelper:Lcom/cyjh/elfin/download/GameDownloadHelper;

    .line 57
    invoke-virtual {p0, p1}, Lcom/cyjh/elfin/customview/GameDownloadView;->init(Landroid/content/Context;)V

    .line 58
    return-void
.end method

.method public constructor <init>(Landroid/content/Context;Landroid/util/AttributeSet;)V
    .locals 1
    .param p1, "context"    # Landroid/content/Context;
    .param p2, "attrs"    # Landroid/util/AttributeSet;

    .prologue
    .line 60
    invoke-direct {p0, p1, p2}, Landroid/widget/RelativeLayout;-><init>(Landroid/content/Context;Landroid/util/AttributeSet;)V

    .line 52
    const/4 v0, 0x0

    iput-boolean v0, p0, Lcom/cyjh/elfin/customview/GameDownloadView;->isDetailsDownload:Z

    .line 66
    new-instance v0, Lcom/cyjh/elfin/customview/GameDownloadView$DownloadDisplayHelper;

    invoke-direct {v0, p0, p0}, Lcom/cyjh/elfin/customview/GameDownloadView$DownloadDisplayHelper;-><init>(Lcom/cyjh/elfin/customview/GameDownloadView;Lcom/kaopu/download/intf/IDownloadView;)V

    iput-object v0, p0, Lcom/cyjh/elfin/customview/GameDownloadView;->mDisplayHelper:Lcom/cyjh/elfin/customview/GameDownloadView$DownloadDisplayHelper;

    .line 70
    new-instance v0, Lcom/cyjh/elfin/download/GameDownloadHelper;

    invoke-direct {v0, p0}, Lcom/cyjh/elfin/download/GameDownloadHelper;-><init>(Lcom/kaopu/download/intf/IDownloadView;)V

    iput-object v0, p0, Lcom/cyjh/elfin/customview/GameDownloadView;->mClickHelper:Lcom/cyjh/elfin/download/GameDownloadHelper;

    .line 61
    invoke-virtual {p0, p1}, Lcom/cyjh/elfin/customview/GameDownloadView;->init(Landroid/content/Context;)V

    .line 62
    return-void
.end method

.method static synthetic access$000(Lcom/cyjh/elfin/customview/GameDownloadView;)Lcom/cyjh/elfin/entity/GameInfo;
    .locals 1
    .param p0, "x0"    # Lcom/cyjh/elfin/customview/GameDownloadView;

    .prologue
    .line 34
    iget-object v0, p0, Lcom/cyjh/elfin/customview/GameDownloadView;->mGameInfo:Lcom/cyjh/elfin/entity/GameInfo;

    return-object v0
.end method

.method static synthetic access$100(Lcom/cyjh/elfin/customview/GameDownloadView;)Lcom/kaopu/download/kernel/BaseDownloadInfo;
    .locals 1
    .param p0, "x0"    # Lcom/cyjh/elfin/customview/GameDownloadView;

    .prologue
    .line 34
    iget-object v0, p0, Lcom/cyjh/elfin/customview/GameDownloadView;->mInfo:Lcom/kaopu/download/kernel/BaseDownloadInfo;

    return-object v0
.end method

.method static synthetic access$102(Lcom/cyjh/elfin/customview/GameDownloadView;Lcom/kaopu/download/kernel/BaseDownloadInfo;)Lcom/kaopu/download/kernel/BaseDownloadInfo;
    .locals 0
    .param p0, "x0"    # Lcom/cyjh/elfin/customview/GameDownloadView;
    .param p1, "x1"    # Lcom/kaopu/download/kernel/BaseDownloadInfo;

    .prologue
    .line 34
    iput-object p1, p0, Lcom/cyjh/elfin/customview/GameDownloadView;->mInfo:Lcom/kaopu/download/kernel/BaseDownloadInfo;

    return-object p1
.end method

.method static synthetic access$200(Lcom/cyjh/elfin/customview/GameDownloadView;)Z
    .locals 1
    .param p0, "x0"    # Lcom/cyjh/elfin/customview/GameDownloadView;

    .prologue
    .line 34
    iget-boolean v0, p0, Lcom/cyjh/elfin/customview/GameDownloadView;->isDetailsDownload:Z

    return v0
.end method

.method static synthetic access$300(Lcom/cyjh/elfin/customview/GameDownloadView;)Ljava/lang/String;
    .locals 1
    .param p0, "x0"    # Lcom/cyjh/elfin/customview/GameDownloadView;

    .prologue
    .line 34
    iget-object v0, p0, Lcom/cyjh/elfin/customview/GameDownloadView;->fileSize:Ljava/lang/String;

    return-object v0
.end method

.method static synthetic access$400(Lcom/cyjh/elfin/customview/GameDownloadView;)Landroid/widget/TextView;
    .locals 1
    .param p0, "x0"    # Lcom/cyjh/elfin/customview/GameDownloadView;

    .prologue
    .line 34
    iget-object v0, p0, Lcom/cyjh/elfin/customview/GameDownloadView;->updateBtn:Landroid/widget/TextView;

    return-object v0
.end method

.method static synthetic access$500(Lcom/cyjh/elfin/customview/GameDownloadView;)Landroid/widget/ProgressBar;
    .locals 1
    .param p0, "x0"    # Lcom/cyjh/elfin/customview/GameDownloadView;

    .prologue
    .line 34
    iget-object v0, p0, Lcom/cyjh/elfin/customview/GameDownloadView;->progressBar:Landroid/widget/ProgressBar;

    return-object v0
.end method

.method private createRootDownloadInfo(Ljava/lang/String;)Lcom/kaopu/download/kernel/BaseDownloadInfo;
    .locals 3
    .param p1, "url"    # Ljava/lang/String;

    .prologue
    .line 249
    new-instance v0, Lcom/kaopu/download/kernel/BaseDownloadInfo;

    invoke-direct {v0}, Lcom/kaopu/download/kernel/BaseDownloadInfo;-><init>()V

    .line 250
    .local v0, "info":Lcom/kaopu/download/kernel/BaseDownloadInfo;
    invoke-virtual {v0, p1}, Lcom/kaopu/download/kernel/BaseDownloadInfo;->setIdentification(Ljava/lang/String;)V

    .line 251
    invoke-virtual {v0, p1}, Lcom/kaopu/download/kernel/BaseDownloadInfo;->setUrl(Ljava/lang/String;)V

    .line 252
    iget-object v1, p0, Lcom/cyjh/elfin/customview/GameDownloadView;->mContext:Landroid/content/Context;

    invoke-static {v1}, Lcom/cyjh/elfin/constant/Constants;->getApkPath(Landroid/content/Context;)Ljava/lang/String;

    move-result-object v1

    const-string v2, "APP"

    invoke-static {v1, v2}, Lcom/cyjh/elfin/util/FileUtils;->makePath(Ljava/lang/String;Ljava/lang/String;)Ljava/lang/String;

    move-result-object v1

    invoke-static {v1}, Lcom/cyjh/elfin/util/FileUtils;->mkdirs(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v1

    invoke-virtual {v0, v1}, Lcom/kaopu/download/kernel/BaseDownloadInfo;->setSaveDir(Ljava/lang/String;)V

    .line 253
    new-instance v1, Ljava/lang/StringBuilder;

    invoke-direct {v1}, Ljava/lang/StringBuilder;-><init>()V

    invoke-static {p1}, Lcom/cyjh/elfin/util/MD5Util;->MD5(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v2

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    const-string v2, ".apk"

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v1

    invoke-virtual {v0, v1}, Lcom/kaopu/download/kernel/BaseDownloadInfo;->setSaveName(Ljava/lang/String;)V

    .line 254
    new-instance v1, Lcom/cyjh/elfin/download/GameDownloadCallBackImpl;

    iget-object v2, p0, Lcom/cyjh/elfin/customview/GameDownloadView;->mGameInfo:Lcom/cyjh/elfin/entity/GameInfo;

    invoke-direct {v1, v2}, Lcom/cyjh/elfin/download/GameDownloadCallBackImpl;-><init>(Lcom/cyjh/elfin/entity/GameInfo;)V

    invoke-virtual {v0, v1}, Lcom/kaopu/download/kernel/BaseDownloadInfo;->setCallBack(Lcom/kaopu/download/BaseDownloadWorker$DownloadCallBack;)V

    .line 255
    return-object v0
.end method

.method public static getDownloadProgress(JJ)F
    .locals 6
    .param p0, "dSize"    # J
    .param p2, "fSize"    # J

    .prologue
    const-wide/high16 v4, 0x3ff0000000000000L    # 1.0

    .line 312
    const-wide/16 v0, 0x0

    cmp-long v0, p2, v0

    if-nez v0, :cond_0

    .line 313
    const/4 v0, 0x0

    .line 315
    :goto_0
    return v0

    :cond_0
    long-to-double v0, p0

    mul-double/2addr v0, v4

    long-to-double v2, p2

    div-double/2addr v0, v2

    mul-double/2addr v0, v4

    double-to-float v0, v0

    goto :goto_0
.end method


# virtual methods
.method public cancel()V
    .locals 0

    .prologue
    .line 100
    return-void
.end method

.method public checkDownloadState(Lcom/kaopu/download/kernel/BaseDownloadInfo;)Z
    .locals 2
    .param p1, "baseDownloadInfo"    # Lcom/kaopu/download/kernel/BaseDownloadInfo;

    .prologue
    .line 94
    iget-object v0, p0, Lcom/cyjh/elfin/customview/GameDownloadView;->mInfo:Lcom/kaopu/download/kernel/BaseDownloadInfo;

    if-nez v0, :cond_0

    .line 95
    const/4 v0, 0x0

    .line 97
    :goto_0
    return v0

    :cond_0
    iget-object v0, p0, Lcom/cyjh/elfin/customview/GameDownloadView;->mInfo:Lcom/kaopu/download/kernel/BaseDownloadInfo;

    invoke-virtual {v0}, Lcom/kaopu/download/kernel/BaseDownloadInfo;->getIdentification()Ljava/lang/String;

    move-result-object v0

    invoke-virtual {p1}, Lcom/kaopu/download/kernel/BaseDownloadInfo;->getIdentification()Ljava/lang/String;

    move-result-object v1

    invoke-virtual {v0, v1}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v0

    goto :goto_0
.end method

.method public getDownloadInfo()Lcom/kaopu/download/kernel/BaseDownloadInfo;
    .locals 1

    .prologue
    .line 83
    iget-object v0, p0, Lcom/cyjh/elfin/customview/GameDownloadView;->mInfo:Lcom/kaopu/download/kernel/BaseDownloadInfo;

    return-object v0
.end method

.method public getState()Lcom/kaopu/download/BaseDownloadStateFactory$State;
    .locals 1

    .prologue
    .line 105
    iget-object v0, p0, Lcom/cyjh/elfin/customview/GameDownloadView;->mInfo:Lcom/kaopu/download/kernel/BaseDownloadInfo;

    invoke-virtual {v0}, Lcom/kaopu/download/kernel/BaseDownloadInfo;->getState()Lcom/kaopu/download/intf/IDownloadState;

    move-result-object v0

    invoke-interface {v0}, Lcom/kaopu/download/intf/IDownloadState;->getState()Lcom/kaopu/download/BaseDownloadStateFactory$State;

    move-result-object v0

    return-object v0
.end method

.method protected init(Landroid/content/Context;)V
    .locals 2
    .param p1, "context"    # Landroid/content/Context;

    .prologue
    .line 259
    iput-object p1, p0, Lcom/cyjh/elfin/customview/GameDownloadView;->mContext:Landroid/content/Context;

    .line 260
    invoke-virtual {p0}, Lcom/cyjh/elfin/customview/GameDownloadView;->getContext()Landroid/content/Context;

    move-result-object v0

    invoke-static {v0}, Landroid/view/LayoutInflater;->from(Landroid/content/Context;)Landroid/view/LayoutInflater;

    move-result-object v0

    const v1, 0x7f04007d

    invoke-virtual {v0, v1, p0}, Landroid/view/LayoutInflater;->inflate(ILandroid/view/ViewGroup;)Landroid/view/View;

    .line 261
    const v0, 0x7f0f0183

    invoke-virtual {p0, v0}, Lcom/cyjh/elfin/customview/GameDownloadView;->findViewById(I)Landroid/view/View;

    move-result-object v0

    check-cast v0, Landroid/widget/TextView;

    iput-object v0, p0, Lcom/cyjh/elfin/customview/GameDownloadView;->updateBtn:Landroid/widget/TextView;

    .line 262
    const v0, 0x7f0f0181

    invoke-virtual {p0, v0}, Lcom/cyjh/elfin/customview/GameDownloadView;->findViewById(I)Landroid/view/View;

    move-result-object v0

    check-cast v0, Landroid/widget/RelativeLayout;

    iput-object v0, p0, Lcom/cyjh/elfin/customview/GameDownloadView;->updateRl:Landroid/widget/RelativeLayout;

    .line 263
    const v0, 0x7f0f0182

    invoke-virtual {p0, v0}, Lcom/cyjh/elfin/customview/GameDownloadView;->findViewById(I)Landroid/view/View;

    move-result-object v0

    check-cast v0, Landroid/widget/ProgressBar;

    iput-object v0, p0, Lcom/cyjh/elfin/customview/GameDownloadView;->progressBar:Landroid/widget/ProgressBar;

    .line 264
    iget-object v0, p0, Lcom/cyjh/elfin/customview/GameDownloadView;->updateBtn:Landroid/widget/TextView;

    invoke-virtual {v0, p0}, Landroid/widget/TextView;->setOnClickListener(Landroid/view/View$OnClickListener;)V

    .line 265
    return-void
.end method

.method protected onAttachedToWindow()V
    .locals 1

    .prologue
    .line 73
    iget-object v0, p0, Lcom/cyjh/elfin/customview/GameDownloadView;->mDisplayHelper:Lcom/cyjh/elfin/customview/GameDownloadView$DownloadDisplayHelper;

    invoke-virtual {v0}, Lcom/cyjh/elfin/customview/GameDownloadView$DownloadDisplayHelper;->registerDownloadReceiver()V

    .line 74
    invoke-super {p0}, Landroid/widget/RelativeLayout;->onAttachedToWindow()V

    .line 75
    return-void
.end method

.method public onClick(Landroid/view/View;)V
    .locals 2
    .param p1, "v"    # Landroid/view/View;

    .prologue
    .line 110
    iget-object v0, p0, Lcom/cyjh/elfin/customview/GameDownloadView;->mClickHelper:Lcom/cyjh/elfin/download/GameDownloadHelper;

    new-instance v1, Lcom/cyjh/elfin/customview/GameDownloadView$1;

    invoke-direct {v1, p0}, Lcom/cyjh/elfin/customview/GameDownloadView$1;-><init>(Lcom/cyjh/elfin/customview/GameDownloadView;)V

    invoke-virtual {v0, v1}, Lcom/cyjh/elfin/download/GameDownloadHelper;->setOnClickerCallback(Lcom/cyjh/elfin/download/GameDownloadHelper$OnClickerCallback;)V

    .line 117
    iget-object v0, p0, Lcom/cyjh/elfin/customview/GameDownloadView;->mInfo:Lcom/kaopu/download/kernel/BaseDownloadInfo;

    iget-object v1, p0, Lcom/cyjh/elfin/customview/GameDownloadView;->mClickHelper:Lcom/cyjh/elfin/download/GameDownloadHelper;

    invoke-virtual {v0, v1}, Lcom/kaopu/download/kernel/BaseDownloadInfo;->onClick(Lcom/kaopu/download/intf/IDownloadClickHelper;)V

    .line 118
    return-void
.end method

.method protected onDetachedFromWindow()V
    .locals 1

    .prologue
    .line 78
    iget-object v0, p0, Lcom/cyjh/elfin/customview/GameDownloadView;->mDisplayHelper:Lcom/cyjh/elfin/customview/GameDownloadView$DownloadDisplayHelper;

    invoke-virtual {v0}, Lcom/cyjh/elfin/customview/GameDownloadView$DownloadDisplayHelper;->unregisterDownloadReceiver()V

    .line 79
    invoke-super {p0}, Landroid/widget/RelativeLayout;->onDetachedFromWindow()V

    .line 80
    return-void
.end method

.method public pause()V
    .locals 0

    .prologue
    .line 102
    return-void
.end method

.method public progressBarVisibility(I)V
    .locals 1
    .param p1, "visibility"    # I

    .prologue
    .line 319
    iget-object v0, p0, Lcom/cyjh/elfin/customview/GameDownloadView;->progressBar:Landroid/widget/ProgressBar;

    invoke-virtual {v0, p1}, Landroid/widget/ProgressBar;->setVisibility(I)V

    .line 320
    return-void
.end method

.method public removeAppUpdateView(Ljava/lang/String;)V
    .locals 6
    .param p1, "packageName"    # Ljava/lang/String;

    .prologue
    const/4 v5, 0x0

    .line 280
    iget-object v0, p0, Lcom/cyjh/elfin/customview/GameDownloadView;->mGameInfo:Lcom/cyjh/elfin/entity/GameInfo;

    iget-object v0, v0, Lcom/cyjh/elfin/entity/GameInfo;->PackageName:Ljava/lang/String;

    invoke-virtual {v0, p1}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v0

    if-eqz v0, :cond_0

    .line 281
    iget-object v0, p0, Lcom/cyjh/elfin/customview/GameDownloadView;->mInfo:Lcom/kaopu/download/kernel/BaseDownloadInfo;

    invoke-virtual {v0}, Lcom/kaopu/download/kernel/BaseDownloadInfo;->getSaveDir()Ljava/lang/String;

    move-result-object v0

    iget-object v1, p0, Lcom/cyjh/elfin/customview/GameDownloadView;->mInfo:Lcom/kaopu/download/kernel/BaseDownloadInfo;

    invoke-virtual {v1}, Lcom/kaopu/download/kernel/BaseDownloadInfo;->getSaveName()Ljava/lang/String;

    move-result-object v1

    invoke-static {v0, v1}, Lcom/cyjh/elfin/util/FileUtils;->isFileExits(Ljava/lang/String;Ljava/lang/String;)Z

    move-result v0

    if-eqz v0, :cond_1

    .line 282
    iget-object v0, p0, Lcom/cyjh/elfin/customview/GameDownloadView;->progressBar:Landroid/widget/ProgressBar;

    invoke-virtual {v0, v5}, Landroid/widget/ProgressBar;->setProgress(I)V

    .line 283
    const v0, 0x7f080038

    invoke-virtual {p0, v0}, Lcom/cyjh/elfin/customview/GameDownloadView;->showUnDownload(I)V

    .line 292
    :cond_0
    :goto_0
    return-void

    .line 285
    :cond_1
    iget-boolean v0, p0, Lcom/cyjh/elfin/customview/GameDownloadView;->isDetailsDownload:Z

    if-eqz v0, :cond_2

    .line 286
    iget-object v0, p0, Lcom/cyjh/elfin/customview/GameDownloadView;->updateBtn:Landroid/widget/TextView;

    invoke-virtual {p0}, Lcom/cyjh/elfin/customview/GameDownloadView;->getContext()Landroid/content/Context;

    move-result-object v1

    const v2, 0x7f08002f

    const/4 v3, 0x1

    new-array v3, v3, [Ljava/lang/Object;

    iget-object v4, p0, Lcom/cyjh/elfin/customview/GameDownloadView;->fileSize:Ljava/lang/String;

    aput-object v4, v3, v5

    invoke-virtual {v1, v2, v3}, Landroid/content/Context;->getString(I[Ljava/lang/Object;)Ljava/lang/String;

    move-result-object v1

    invoke-virtual {v0, v1}, Landroid/widget/TextView;->setText(Ljava/lang/CharSequence;)V

    goto :goto_0

    .line 288
    :cond_2
    const v0, 0x7f080062

    invoke-virtual {p0, v0}, Lcom/cyjh/elfin/customview/GameDownloadView;->showUnDownload(I)V

    goto :goto_0
.end method

.method public setDownloadInfo(Lcom/kaopu/download/kernel/BaseDownloadInfo;)V
    .locals 2
    .param p1, "baseDownloadInfo"    # Lcom/kaopu/download/kernel/BaseDownloadInfo;

    .prologue
    .line 87
    iput-object p1, p0, Lcom/cyjh/elfin/customview/GameDownloadView;->mInfo:Lcom/kaopu/download/kernel/BaseDownloadInfo;

    .line 88
    iget-object v0, p0, Lcom/cyjh/elfin/customview/GameDownloadView;->mDisplayHelper:Lcom/cyjh/elfin/customview/GameDownloadView$DownloadDisplayHelper;

    iget-object v1, p0, Lcom/cyjh/elfin/customview/GameDownloadView;->mInfo:Lcom/kaopu/download/kernel/BaseDownloadInfo;

    invoke-virtual {v0, v1}, Lcom/cyjh/elfin/customview/GameDownloadView$DownloadDisplayHelper;->setDownloadInfo(Lcom/kaopu/download/kernel/BaseDownloadInfo;)V

    .line 89
    iget-object v0, p0, Lcom/cyjh/elfin/customview/GameDownloadView;->mClickHelper:Lcom/cyjh/elfin/download/GameDownloadHelper;

    iget-object v1, p0, Lcom/cyjh/elfin/customview/GameDownloadView;->mInfo:Lcom/kaopu/download/kernel/BaseDownloadInfo;

    invoke-virtual {v0, v1}, Lcom/cyjh/elfin/download/GameDownloadHelper;->setDownloadInfo(Lcom/kaopu/download/kernel/BaseDownloadInfo;)V

    .line 90
    iget-object v0, p0, Lcom/cyjh/elfin/customview/GameDownloadView;->mInfo:Lcom/kaopu/download/kernel/BaseDownloadInfo;

    iget-object v1, p0, Lcom/cyjh/elfin/customview/GameDownloadView;->mDisplayHelper:Lcom/cyjh/elfin/customview/GameDownloadView$DownloadDisplayHelper;

    invoke-virtual {v0, v1}, Lcom/kaopu/download/kernel/BaseDownloadInfo;->display(Lcom/kaopu/download/intf/IDownloadDisplayHelper;)V

    .line 91
    return-void
.end method

.method public setInfo(Lcom/cyjh/elfin/entity/GameInfo;)V
    .locals 4
    .param p1, "gameInfo"    # Lcom/cyjh/elfin/entity/GameInfo;

    .prologue
    .line 214
    iput-object p1, p0, Lcom/cyjh/elfin/customview/GameDownloadView;->mGameInfo:Lcom/cyjh/elfin/entity/GameInfo;

    .line 216
    iget-object v2, p0, Lcom/cyjh/elfin/customview/GameDownloadView;->mClickHelper:Lcom/cyjh/elfin/download/GameDownloadHelper;

    invoke-virtual {v2, p0}, Lcom/cyjh/elfin/download/GameDownloadHelper;->setGameDownloadView(Lcom/cyjh/elfin/customview/GameDownloadView;)V

    .line 217
    iget-object v2, p0, Lcom/cyjh/elfin/customview/GameDownloadView;->mClickHelper:Lcom/cyjh/elfin/download/GameDownloadHelper;

    iget-object v3, p0, Lcom/cyjh/elfin/customview/GameDownloadView;->mGameInfo:Lcom/cyjh/elfin/entity/GameInfo;

    invoke-virtual {v2, v3}, Lcom/cyjh/elfin/download/GameDownloadHelper;->setGameInfo(Lcom/cyjh/elfin/entity/GameInfo;)V

    .line 218
    iget-object v2, p0, Lcom/cyjh/elfin/customview/GameDownloadView;->mContext:Landroid/content/Context;

    iget-object v3, p0, Lcom/cyjh/elfin/customview/GameDownloadView;->mGameInfo:Lcom/cyjh/elfin/entity/GameInfo;

    iget-object v3, v3, Lcom/cyjh/elfin/entity/GameInfo;->DownLoadUrl:Ljava/lang/String;

    invoke-static {v2, v3}, Lcom/kaopu/download/BaseDownloadOperate;->getDownloadInfo(Landroid/content/Context;Ljava/lang/String;)Lcom/kaopu/download/kernel/BaseDownloadInfo;

    move-result-object v0

    .line 220
    .local v0, "downloadInfo":Lcom/kaopu/download/kernel/BaseDownloadInfo;
    if-eqz v0, :cond_1

    .line 221
    iput-object v0, p0, Lcom/cyjh/elfin/customview/GameDownloadView;->mInfo:Lcom/kaopu/download/kernel/BaseDownloadInfo;

    .line 225
    :goto_0
    iget-object v2, p0, Lcom/cyjh/elfin/customview/GameDownloadView;->mInfo:Lcom/kaopu/download/kernel/BaseDownloadInfo;

    invoke-virtual {p0, v2}, Lcom/cyjh/elfin/customview/GameDownloadView;->setDownloadInfo(Lcom/kaopu/download/kernel/BaseDownloadInfo;)V

    .line 226
    iget-object v2, p0, Lcom/cyjh/elfin/customview/GameDownloadView;->mContext:Landroid/content/Context;

    iget-object v3, p0, Lcom/cyjh/elfin/customview/GameDownloadView;->mGameInfo:Lcom/cyjh/elfin/entity/GameInfo;

    iget-object v3, v3, Lcom/cyjh/elfin/entity/GameInfo;->PackageName:Ljava/lang/String;

    invoke-static {v2, v3}, Lcom/cyjh/elfin/util/AppDeviceUtils;->isPackageInstalled(Landroid/content/Context;Ljava/lang/String;)Z

    move-result v2

    if-eqz v2, :cond_2

    .line 227
    const v2, 0x7f0800b1

    invoke-virtual {p0, v2}, Lcom/cyjh/elfin/customview/GameDownloadView;->showUnDownload(I)V

    .line 243
    :cond_0
    :goto_1
    return-void

    .line 223
    :cond_1
    iget-object v2, p0, Lcom/cyjh/elfin/customview/GameDownloadView;->mGameInfo:Lcom/cyjh/elfin/entity/GameInfo;

    iget-object v2, v2, Lcom/cyjh/elfin/entity/GameInfo;->DownLoadUrl:Ljava/lang/String;

    invoke-direct {p0, v2}, Lcom/cyjh/elfin/customview/GameDownloadView;->createRootDownloadInfo(Ljava/lang/String;)Lcom/kaopu/download/kernel/BaseDownloadInfo;

    move-result-object v2

    iput-object v2, p0, Lcom/cyjh/elfin/customview/GameDownloadView;->mInfo:Lcom/kaopu/download/kernel/BaseDownloadInfo;

    goto :goto_0

    .line 230
    :cond_2
    new-instance v2, Ljava/lang/StringBuilder;

    invoke-direct {v2}, Ljava/lang/StringBuilder;-><init>()V

    iget-object v3, p0, Lcom/cyjh/elfin/customview/GameDownloadView;->mInfo:Lcom/kaopu/download/kernel/BaseDownloadInfo;

    invoke-virtual {v3}, Lcom/kaopu/download/kernel/BaseDownloadInfo;->getUrl()Ljava/lang/String;

    move-result-object v3

    invoke-static {v3}, Lcom/cyjh/elfin/util/MD5Util;->MD5(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v3

    invoke-virtual {v2, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    const-string v3, ".apk.temp"

    invoke-virtual {v2, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    invoke-virtual {v2}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v1

    .line 231
    .local v1, "tempFileName":Ljava/lang/String;
    iget-object v2, p0, Lcom/cyjh/elfin/customview/GameDownloadView;->mInfo:Lcom/kaopu/download/kernel/BaseDownloadInfo;

    invoke-virtual {v2}, Lcom/kaopu/download/kernel/BaseDownloadInfo;->getSaveDir()Ljava/lang/String;

    move-result-object v2

    invoke-static {v2, v1}, Lcom/cyjh/elfin/util/FileUtils;->isFileExits(Ljava/lang/String;Ljava/lang/String;)Z

    move-result v2

    if-eqz v2, :cond_3

    .line 232
    const v2, 0x7f080064

    invoke-virtual {p0, v2}, Lcom/cyjh/elfin/customview/GameDownloadView;->showUnDownload(I)V

    .line 234
    :cond_3
    iget-object v2, p0, Lcom/cyjh/elfin/customview/GameDownloadView;->mGameInfo:Lcom/cyjh/elfin/entity/GameInfo;

    iget-object v2, v2, Lcom/cyjh/elfin/entity/GameInfo;->DownLoadUrl:Ljava/lang/String;

    if-eqz v2, :cond_4

    iget-object v2, p0, Lcom/cyjh/elfin/customview/GameDownloadView;->mGameInfo:Lcom/cyjh/elfin/entity/GameInfo;

    iget-object v2, v2, Lcom/cyjh/elfin/entity/GameInfo;->DownLoadUrl:Ljava/lang/String;

    const-string v3, ""

    invoke-virtual {v2, v3}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v2

    if-eqz v2, :cond_5

    .line 235
    :cond_4
    iget-object v2, p0, Lcom/cyjh/elfin/customview/GameDownloadView;->updateRl:Landroid/widget/RelativeLayout;

    const/16 v3, 0x8

    invoke-virtual {v2, v3}, Landroid/widget/RelativeLayout;->setVisibility(I)V

    goto :goto_1

    .line 238
    :cond_5
    iget-object v2, p0, Lcom/cyjh/elfin/customview/GameDownloadView;->updateRl:Landroid/widget/RelativeLayout;

    const/4 v3, 0x0

    invoke-virtual {v2, v3}, Landroid/widget/RelativeLayout;->setVisibility(I)V

    .line 240
    iget-object v2, p0, Lcom/cyjh/elfin/customview/GameDownloadView;->mInfo:Lcom/kaopu/download/kernel/BaseDownloadInfo;

    invoke-virtual {v2}, Lcom/kaopu/download/kernel/BaseDownloadInfo;->getSaveDir()Ljava/lang/String;

    move-result-object v2

    iget-object v3, p0, Lcom/cyjh/elfin/customview/GameDownloadView;->mInfo:Lcom/kaopu/download/kernel/BaseDownloadInfo;

    invoke-virtual {v3}, Lcom/kaopu/download/kernel/BaseDownloadInfo;->getSaveName()Ljava/lang/String;

    move-result-object v3

    invoke-static {v2, v3}, Lcom/cyjh/elfin/util/FileUtils;->isFileExits(Ljava/lang/String;Ljava/lang/String;)Z

    move-result v2

    if-eqz v2, :cond_0

    .line 241
    const v2, 0x7f080038

    invoke-virtual {p0, v2}, Lcom/cyjh/elfin/customview/GameDownloadView;->showUnDownload(I)V

    goto :goto_1
.end method

.method public setTextStyle(Ljava/lang/String;Z)V
    .locals 7
    .param p1, "text"    # Ljava/lang/String;
    .param p2, "flag"    # Z

    .prologue
    const/4 v6, 0x0

    const/high16 v4, 0x42480000    # 50.0f

    .line 335
    invoke-virtual {p0, v6}, Lcom/cyjh/elfin/customview/GameDownloadView;->progressBarVisibility(I)V

    .line 336
    iget-object v2, p0, Lcom/cyjh/elfin/customview/GameDownloadView;->updateBtn:Landroid/widget/TextView;

    invoke-virtual {v2}, Landroid/widget/TextView;->getLayoutParams()Landroid/view/ViewGroup$LayoutParams;

    move-result-object v0

    check-cast v0, Landroid/widget/RelativeLayout$LayoutParams;

    .line 337
    .local v0, "params":Landroid/widget/RelativeLayout$LayoutParams;
    invoke-virtual {p0}, Lcom/cyjh/elfin/customview/GameDownloadView;->getContext()Landroid/content/Context;

    move-result-object v2

    invoke-static {v2, v4}, Lcom/cyjh/elfin/util/AppDeviceUtils;->getDipToPx(Landroid/content/Context;F)I

    move-result v2

    iput v2, v0, Landroid/widget/RelativeLayout$LayoutParams;->height:I

    .line 338
    iget-object v2, p0, Lcom/cyjh/elfin/customview/GameDownloadView;->updateBtn:Landroid/widget/TextView;

    invoke-virtual {v2, v0}, Landroid/widget/TextView;->setLayoutParams(Landroid/view/ViewGroup$LayoutParams;)V

    .line 339
    iget-object v2, p0, Lcom/cyjh/elfin/customview/GameDownloadView;->updateBtn:Landroid/widget/TextView;

    const v3, 0x7f020050

    invoke-virtual {v2, v3}, Landroid/widget/TextView;->setBackgroundResource(I)V

    .line 340
    iget-object v2, p0, Lcom/cyjh/elfin/customview/GameDownloadView;->progressBar:Landroid/widget/ProgressBar;

    invoke-virtual {v2}, Landroid/widget/ProgressBar;->getLayoutParams()Landroid/view/ViewGroup$LayoutParams;

    move-result-object v1

    check-cast v1, Landroid/widget/RelativeLayout$LayoutParams;

    .line 341
    .local v1, "paramsProgressBar":Landroid/widget/RelativeLayout$LayoutParams;
    invoke-virtual {p0}, Lcom/cyjh/elfin/customview/GameDownloadView;->getContext()Landroid/content/Context;

    move-result-object v2

    invoke-static {v2, v4}, Lcom/cyjh/elfin/util/AppDeviceUtils;->getDipToPx(Landroid/content/Context;F)I

    move-result v2

    iput v2, v1, Landroid/widget/RelativeLayout$LayoutParams;->height:I

    .line 342
    iget-object v2, p0, Lcom/cyjh/elfin/customview/GameDownloadView;->progressBar:Landroid/widget/ProgressBar;

    invoke-virtual {v2, v1}, Landroid/widget/ProgressBar;->setLayoutParams(Landroid/view/ViewGroup$LayoutParams;)V

    .line 343
    iget-object v2, p0, Lcom/cyjh/elfin/customview/GameDownloadView;->progressBar:Landroid/widget/ProgressBar;

    invoke-virtual {p0}, Lcom/cyjh/elfin/customview/GameDownloadView;->getResources()Landroid/content/res/Resources;

    move-result-object v3

    const v4, 0x7f0200b5

    invoke-virtual {v3, v4}, Landroid/content/res/Resources;->getDrawable(I)Landroid/graphics/drawable/Drawable;

    move-result-object v3

    invoke-virtual {v2, v3}, Landroid/widget/ProgressBar;->setProgressDrawable(Landroid/graphics/drawable/Drawable;)V

    .line 344
    iput-boolean p2, p0, Lcom/cyjh/elfin/customview/GameDownloadView;->isDetailsDownload:Z

    .line 345
    iput-object p1, p0, Lcom/cyjh/elfin/customview/GameDownloadView;->fileSize:Ljava/lang/String;

    .line 346
    iget-object v2, p0, Lcom/cyjh/elfin/customview/GameDownloadView;->updateBtn:Landroid/widget/TextView;

    const/high16 v3, 0x41800000    # 16.0f

    invoke-virtual {v2, v3}, Landroid/widget/TextView;->setTextSize(F)V

    .line 347
    iget-object v2, p0, Lcom/cyjh/elfin/customview/GameDownloadView;->updateBtn:Landroid/widget/TextView;

    invoke-virtual {p0}, Lcom/cyjh/elfin/customview/GameDownloadView;->getContext()Landroid/content/Context;

    move-result-object v3

    const v4, 0x7f08002f

    const/4 v5, 0x1

    new-array v5, v5, [Ljava/lang/Object;

    aput-object p1, v5, v6

    invoke-virtual {v3, v4, v5}, Landroid/content/Context;->getString(I[Ljava/lang/Object;)Ljava/lang/String;

    move-result-object v3

    invoke-virtual {v2, v3}, Landroid/widget/TextView;->setText(Ljava/lang/CharSequence;)V

    .line 348
    iget-object v2, p0, Lcom/cyjh/elfin/customview/GameDownloadView;->updateBtn:Landroid/widget/TextView;

    invoke-virtual {p0}, Lcom/cyjh/elfin/customview/GameDownloadView;->getResources()Landroid/content/res/Resources;

    move-result-object v3

    const v4, 0x7f0e0081

    invoke-virtual {v3, v4}, Landroid/content/res/Resources;->getColor(I)I

    move-result v3

    invoke-virtual {v2, v3}, Landroid/widget/TextView;->setTextColor(I)V

    .line 349
    iget-object v2, p0, Lcom/cyjh/elfin/customview/GameDownloadView;->mClickHelper:Lcom/cyjh/elfin/download/GameDownloadHelper;

    invoke-virtual {v2, p2}, Lcom/cyjh/elfin/download/GameDownloadHelper;->setDetailsDownloadButton(Z)V

    .line 350
    return-void
.end method

.method protected showDownload()V
    .locals 6

    .prologue
    .line 301
    iget-object v2, p0, Lcom/cyjh/elfin/customview/GameDownloadView;->updateBtn:Landroid/widget/TextView;

    iget-object v3, p0, Lcom/cyjh/elfin/customview/GameDownloadView;->mContext:Landroid/content/Context;

    const v4, 0x7f0800bc

    invoke-virtual {v3, v4}, Landroid/content/Context;->getString(I)Ljava/lang/String;

    move-result-object v3

    invoke-virtual {v2, v3}, Landroid/widget/TextView;->setText(Ljava/lang/CharSequence;)V

    .line 302
    iget-boolean v2, p0, Lcom/cyjh/elfin/customview/GameDownloadView;->isDetailsDownload:Z

    if-eqz v2, :cond_0

    .line 303
    iget-object v2, p0, Lcom/cyjh/elfin/customview/GameDownloadView;->updateBtn:Landroid/widget/TextView;

    const v3, 0x7f020057

    invoke-virtual {v2, v3}, Landroid/widget/TextView;->setBackgroundResource(I)V

    .line 304
    iget-object v2, p0, Lcom/cyjh/elfin/customview/GameDownloadView;->updateBtn:Landroid/widget/TextView;

    invoke-virtual {p0}, Lcom/cyjh/elfin/customview/GameDownloadView;->getResources()Landroid/content/res/Resources;

    move-result-object v3

    const v4, 0x7f0e0023

    invoke-virtual {v3, v4}, Landroid/content/res/Resources;->getColor(I)I

    move-result v3

    invoke-virtual {v2, v3}, Landroid/widget/TextView;->setTextColor(I)V

    .line 306
    :cond_0
    iget-object v2, p0, Lcom/cyjh/elfin/customview/GameDownloadView;->mInfo:Lcom/kaopu/download/kernel/BaseDownloadInfo;

    invoke-virtual {v2}, Lcom/kaopu/download/kernel/BaseDownloadInfo;->getdSize()J

    move-result-wide v2

    iget-object v4, p0, Lcom/cyjh/elfin/customview/GameDownloadView;->mInfo:Lcom/kaopu/download/kernel/BaseDownloadInfo;

    invoke-virtual {v4}, Lcom/kaopu/download/kernel/BaseDownloadInfo;->getfSize()J

    move-result-wide v4

    invoke-static {v2, v3, v4, v5}, Lcom/cyjh/elfin/customview/GameDownloadView;->getDownloadProgress(JJ)F

    move-result v1

    .line 307
    .local v1, "progress":F
    const/high16 v2, 0x42c80000    # 100.0f

    mul-float/2addr v2, v1

    float-to-int v0, v2

    .line 308
    .local v0, "intProgress":I
    iget-object v2, p0, Lcom/cyjh/elfin/customview/GameDownloadView;->progressBar:Landroid/widget/ProgressBar;

    invoke-virtual {v2, v0}, Landroid/widget/ProgressBar;->setProgress(I)V

    .line 309
    return-void
.end method

.method public showDownloadProgressRate()V
    .locals 6

    .prologue
    .line 323
    iget-object v2, p0, Lcom/cyjh/elfin/customview/GameDownloadView;->mInfo:Lcom/kaopu/download/kernel/BaseDownloadInfo;

    invoke-virtual {v2}, Lcom/kaopu/download/kernel/BaseDownloadInfo;->getdSize()J

    move-result-wide v2

    iget-object v4, p0, Lcom/cyjh/elfin/customview/GameDownloadView;->mInfo:Lcom/kaopu/download/kernel/BaseDownloadInfo;

    invoke-virtual {v4}, Lcom/kaopu/download/kernel/BaseDownloadInfo;->getfSize()J

    move-result-wide v4

    invoke-static {v2, v3, v4, v5}, Lcom/cyjh/elfin/customview/GameDownloadView;->getDownloadProgress(JJ)F

    move-result v1

    .line 324
    .local v1, "progress":F
    const/high16 v2, 0x42c80000    # 100.0f

    mul-float/2addr v2, v1

    float-to-int v0, v2

    .line 325
    .local v0, "intProgress":I
    iget-object v2, p0, Lcom/cyjh/elfin/customview/GameDownloadView;->updateBtn:Landroid/widget/TextView;

    new-instance v3, Ljava/lang/StringBuilder;

    invoke-direct {v3}, Ljava/lang/StringBuilder;-><init>()V

    invoke-virtual {v3, v0}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v3

    const-string v4, "%"

    invoke-virtual {v3, v4}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v3

    invoke-virtual {v3}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v3

    invoke-virtual {v2, v3}, Landroid/widget/TextView;->setText(Ljava/lang/CharSequence;)V

    .line 326
    return-void
.end method

.method public showUnDownload(I)V
    .locals 3
    .param p1, "strId"    # I

    .prologue
    .line 271
    iget-object v0, p0, Lcom/cyjh/elfin/customview/GameDownloadView;->progressBar:Landroid/widget/ProgressBar;

    const/4 v1, 0x0

    invoke-virtual {v0, v1}, Landroid/widget/ProgressBar;->setProgress(I)V

    .line 272
    iget-object v0, p0, Lcom/cyjh/elfin/customview/GameDownloadView;->updateBtn:Landroid/widget/TextView;

    iget-object v1, p0, Lcom/cyjh/elfin/customview/GameDownloadView;->mContext:Landroid/content/Context;

    invoke-virtual {v1, p1}, Landroid/content/Context;->getString(I)Ljava/lang/String;

    move-result-object v1

    invoke-virtual {v0, v1}, Landroid/widget/TextView;->setText(Ljava/lang/CharSequence;)V

    .line 273
    iget-boolean v0, p0, Lcom/cyjh/elfin/customview/GameDownloadView;->isDetailsDownload:Z

    if-eqz v0, :cond_0

    .line 274
    iget-object v0, p0, Lcom/cyjh/elfin/customview/GameDownloadView;->updateBtn:Landroid/widget/TextView;

    const v1, 0x7f020050

    invoke-virtual {v0, v1}, Landroid/widget/TextView;->setBackgroundResource(I)V

    .line 275
    iget-object v0, p0, Lcom/cyjh/elfin/customview/GameDownloadView;->updateBtn:Landroid/widget/TextView;

    invoke-virtual {p0}, Lcom/cyjh/elfin/customview/GameDownloadView;->getResources()Landroid/content/res/Resources;

    move-result-object v1

    const v2, 0x7f0e0081

    invoke-virtual {v1, v2}, Landroid/content/res/Resources;->getColor(I)I

    move-result v1

    invoke-virtual {v0, v1}, Landroid/widget/TextView;->setTextColor(I)V

    .line 277
    :cond_0
    return-void
.end method

.method public startDownload()V
    .locals 1

    .prologue
    .line 295
    iget-object v0, p0, Lcom/cyjh/elfin/customview/GameDownloadView;->mClickHelper:Lcom/cyjh/elfin/download/GameDownloadHelper;

    invoke-virtual {v0}, Lcom/cyjh/elfin/download/GameDownloadHelper;->down()V

    .line 296
    return-void
.end method
