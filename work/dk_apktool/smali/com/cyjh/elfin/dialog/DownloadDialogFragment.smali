.class public Lcom/cyjh/elfin/dialog/DownloadDialogFragment;
.super Landroid/support/v4/app/DialogFragment;
.source "DownloadDialogFragment.java"


# annotations
.annotation system Ldalvik/annotation/MemberClasses;
    value = {
        Lcom/cyjh/elfin/dialog/DownloadDialogFragment$OnDownloadClickListener;
    }
.end annotation


# static fields
.field public static final MESSAGE_ONE:I = 0x3e9


# instance fields
.field public apkDownloadUrl:Ljava/lang/String;

.field public apkName:Ljava/lang/String;

.field public apkPackageName:Ljava/lang/String;

.field public desApkFile:Ljava/io/File;

.field private downloadHandler:Lcom/lidroid/xutils/http/HttpHandler;
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "Lcom/lidroid/xutils/http/HttpHandler",
            "<",
            "Ljava/io/File;",
            ">;"
        }
    .end annotation
.end field

.field private fileLength:I

.field private imgPath:Ljava/lang/String;

.field public isDownloadComplete:Z

.field private mButtonDownload:Lcom/dd/processbutton/iml/SubmitProcessButton;

.field private mDownloadOnClickListener:Landroid/view/View$OnClickListener;

.field private mHandler:Landroid/os/Handler;

.field private mImageView:Landroid/widget/ImageView;

.field private mOnDownloadClickListener:Lcom/cyjh/elfin/dialog/DownloadDialogFragment$OnDownloadClickListener;

.field private mTvContent:Landroid/widget/TextView;


# direct methods
.method public constructor <init>()V
    .locals 1

    .prologue
    const/4 v0, 0x0

    .line 36
    invoke-direct {p0}, Landroid/support/v4/app/DialogFragment;-><init>()V

    .line 42
    iput v0, p0, Lcom/cyjh/elfin/dialog/DownloadDialogFragment;->fileLength:I

    .line 43
    iput-boolean v0, p0, Lcom/cyjh/elfin/dialog/DownloadDialogFragment;->isDownloadComplete:Z

    .line 151
    new-instance v0, Lcom/cyjh/elfin/dialog/DownloadDialogFragment$2;

    invoke-direct {v0, p0}, Lcom/cyjh/elfin/dialog/DownloadDialogFragment$2;-><init>(Lcom/cyjh/elfin/dialog/DownloadDialogFragment;)V

    iput-object v0, p0, Lcom/cyjh/elfin/dialog/DownloadDialogFragment;->mHandler:Landroid/os/Handler;

    .line 183
    new-instance v0, Lcom/cyjh/elfin/dialog/DownloadDialogFragment$3;

    invoke-direct {v0, p0}, Lcom/cyjh/elfin/dialog/DownloadDialogFragment$3;-><init>(Lcom/cyjh/elfin/dialog/DownloadDialogFragment;)V

    iput-object v0, p0, Lcom/cyjh/elfin/dialog/DownloadDialogFragment;->mDownloadOnClickListener:Landroid/view/View$OnClickListener;

    return-void
.end method

.method static synthetic access$000(Lcom/cyjh/elfin/dialog/DownloadDialogFragment;)I
    .locals 1
    .param p0, "x0"    # Lcom/cyjh/elfin/dialog/DownloadDialogFragment;

    .prologue
    .line 36
    iget v0, p0, Lcom/cyjh/elfin/dialog/DownloadDialogFragment;->fileLength:I

    return v0
.end method

.method static synthetic access$002(Lcom/cyjh/elfin/dialog/DownloadDialogFragment;I)I
    .locals 0
    .param p0, "x0"    # Lcom/cyjh/elfin/dialog/DownloadDialogFragment;
    .param p1, "x1"    # I

    .prologue
    .line 36
    iput p1, p0, Lcom/cyjh/elfin/dialog/DownloadDialogFragment;->fileLength:I

    return p1
.end method

.method static synthetic access$100(Lcom/cyjh/elfin/dialog/DownloadDialogFragment;)Landroid/os/Handler;
    .locals 1
    .param p0, "x0"    # Lcom/cyjh/elfin/dialog/DownloadDialogFragment;

    .prologue
    .line 36
    iget-object v0, p0, Lcom/cyjh/elfin/dialog/DownloadDialogFragment;->mHandler:Landroid/os/Handler;

    return-object v0
.end method

.method static synthetic access$200(Lcom/cyjh/elfin/dialog/DownloadDialogFragment;)Lcom/dd/processbutton/iml/SubmitProcessButton;
    .locals 1
    .param p0, "x0"    # Lcom/cyjh/elfin/dialog/DownloadDialogFragment;

    .prologue
    .line 36
    iget-object v0, p0, Lcom/cyjh/elfin/dialog/DownloadDialogFragment;->mButtonDownload:Lcom/dd/processbutton/iml/SubmitProcessButton;

    return-object v0
.end method

.method static synthetic access$300(Lcom/cyjh/elfin/dialog/DownloadDialogFragment;)Lcom/cyjh/elfin/dialog/DownloadDialogFragment$OnDownloadClickListener;
    .locals 1
    .param p0, "x0"    # Lcom/cyjh/elfin/dialog/DownloadDialogFragment;

    .prologue
    .line 36
    iget-object v0, p0, Lcom/cyjh/elfin/dialog/DownloadDialogFragment;->mOnDownloadClickListener:Lcom/cyjh/elfin/dialog/DownloadDialogFragment$OnDownloadClickListener;

    return-object v0
.end method

.method public static newInstance(Lcom/cyjh/elfin/entity/RootRelatedEntity$RootRelatedData;)Lcom/cyjh/elfin/dialog/DownloadDialogFragment;
    .locals 4
    .param p0, "data"    # Lcom/cyjh/elfin/entity/RootRelatedEntity$RootRelatedData;

    .prologue
    .line 73
    new-instance v0, Landroid/os/Bundle;

    invoke-direct {v0}, Landroid/os/Bundle;-><init>()V

    .line 74
    .local v0, "bundle":Landroid/os/Bundle;
    const-string v2, "apkDownloadUrl"

    iget-object v3, p0, Lcom/cyjh/elfin/entity/RootRelatedEntity$RootRelatedData;->Path:Ljava/lang/String;

    invoke-virtual {v0, v2, v3}, Landroid/os/Bundle;->putString(Ljava/lang/String;Ljava/lang/String;)V

    .line 75
    const-string v2, "apkName"

    iget-object v3, p0, Lcom/cyjh/elfin/entity/RootRelatedEntity$RootRelatedData;->ScriptName:Ljava/lang/String;

    invoke-virtual {v0, v2, v3}, Landroid/os/Bundle;->putString(Ljava/lang/String;Ljava/lang/String;)V

    .line 76
    const-string v2, "apkPackageName"

    iget-object v3, p0, Lcom/cyjh/elfin/entity/RootRelatedEntity$RootRelatedData;->PackageName:Ljava/lang/String;

    invoke-virtual {v0, v2, v3}, Landroid/os/Bundle;->putString(Ljava/lang/String;Ljava/lang/String;)V

    .line 77
    const-string v2, "imgPath"

    iget-object v3, p0, Lcom/cyjh/elfin/entity/RootRelatedEntity$RootRelatedData;->Image:Ljava/lang/String;

    invoke-virtual {v0, v2, v3}, Landroid/os/Bundle;->putString(Ljava/lang/String;Ljava/lang/String;)V

    .line 78
    new-instance v1, Lcom/cyjh/elfin/dialog/DownloadDialogFragment;

    invoke-direct {v1}, Lcom/cyjh/elfin/dialog/DownloadDialogFragment;-><init>()V

    .line 79
    .local v1, "downloadDialogFragment":Lcom/cyjh/elfin/dialog/DownloadDialogFragment;
    invoke-virtual {v1, v0}, Lcom/cyjh/elfin/dialog/DownloadDialogFragment;->setArguments(Landroid/os/Bundle;)V

    .line 80
    return-object v1
.end method

.method public static newInstance(Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;)Lcom/cyjh/elfin/dialog/DownloadDialogFragment;
    .locals 3
    .param p0, "apkDownloadUrl"    # Ljava/lang/String;
    .param p1, "apkName"    # Ljava/lang/String;
    .param p2, "packageName"    # Ljava/lang/String;
    .param p3, "imgPath"    # Ljava/lang/String;

    .prologue
    .line 62
    new-instance v0, Landroid/os/Bundle;

    invoke-direct {v0}, Landroid/os/Bundle;-><init>()V

    .line 63
    .local v0, "bundle":Landroid/os/Bundle;
    const-string v2, "apkDownloadUrl"

    invoke-virtual {v0, v2, p0}, Landroid/os/Bundle;->putString(Ljava/lang/String;Ljava/lang/String;)V

    .line 64
    const-string v2, "apkName"

    invoke-virtual {v0, v2, p1}, Landroid/os/Bundle;->putString(Ljava/lang/String;Ljava/lang/String;)V

    .line 65
    const-string v2, "apkPackageName"

    invoke-virtual {v0, v2, p2}, Landroid/os/Bundle;->putString(Ljava/lang/String;Ljava/lang/String;)V

    .line 66
    const-string v2, "imgPath"

    invoke-virtual {v0, v2, p3}, Landroid/os/Bundle;->putString(Ljava/lang/String;Ljava/lang/String;)V

    .line 67
    new-instance v1, Lcom/cyjh/elfin/dialog/DownloadDialogFragment;

    invoke-direct {v1}, Lcom/cyjh/elfin/dialog/DownloadDialogFragment;-><init>()V

    .line 68
    .local v1, "downloadDialogFragment":Lcom/cyjh/elfin/dialog/DownloadDialogFragment;
    invoke-virtual {v1, v0}, Lcom/cyjh/elfin/dialog/DownloadDialogFragment;->setArguments(Landroid/os/Bundle;)V

    .line 69
    return-object v1
.end method


# virtual methods
.method public onActivityCreated(Landroid/os/Bundle;)V
    .locals 2
    .param p1, "savedInstanceState"    # Landroid/os/Bundle;

    .prologue
    .line 128
    invoke-super {p0, p1}, Landroid/support/v4/app/DialogFragment;->onActivityCreated(Landroid/os/Bundle;)V

    .line 130
    invoke-virtual {p0}, Lcom/cyjh/elfin/dialog/DownloadDialogFragment;->getActivity()Landroid/support/v4/app/FragmentActivity;

    move-result-object v0

    iget-object v1, p0, Lcom/cyjh/elfin/dialog/DownloadDialogFragment;->apkPackageName:Ljava/lang/String;

    invoke-static {v0, v1}, Lcom/cyjh/elfin/util/AppDeviceUtils;->isAInstallPackage(Landroid/content/Context;Ljava/lang/String;)Z

    move-result v0

    if-nez v0, :cond_0

    .line 131
    new-instance v0, Lcom/cyjh/elfin/dialog/DownloadDialogFragment$1;

    invoke-direct {v0, p0}, Lcom/cyjh/elfin/dialog/DownloadDialogFragment$1;-><init>(Lcom/cyjh/elfin/dialog/DownloadDialogFragment;)V

    .line 147
    invoke-virtual {v0}, Lcom/cyjh/elfin/dialog/DownloadDialogFragment$1;->start()V

    .line 149
    :cond_0
    return-void
.end method

.method public onCreate(Landroid/os/Bundle;)V
    .locals 4
    .param p1, "savedInstanceState"    # Landroid/os/Bundle;
        .annotation build Landroid/support/annotation/Nullable;
        .end annotation
    .end param

    .prologue
    .line 85
    invoke-super {p0, p1}, Landroid/support/v4/app/DialogFragment;->onCreate(Landroid/os/Bundle;)V

    .line 87
    const/4 v1, 0x1

    const v2, 0x1030074

    invoke-virtual {p0, v1, v2}, Lcom/cyjh/elfin/dialog/DownloadDialogFragment;->setStyle(II)V

    .line 88
    invoke-virtual {p0}, Lcom/cyjh/elfin/dialog/DownloadDialogFragment;->getArguments()Landroid/os/Bundle;

    move-result-object v0

    .line 89
    .local v0, "bundle":Landroid/os/Bundle;
    const-string v1, "apkName"

    invoke-virtual {v0, v1}, Landroid/os/Bundle;->getString(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v1

    iput-object v1, p0, Lcom/cyjh/elfin/dialog/DownloadDialogFragment;->apkName:Ljava/lang/String;

    .line 90
    const-string v1, "apkDownloadUrl"

    invoke-virtual {v0, v1}, Landroid/os/Bundle;->getString(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v1

    iput-object v1, p0, Lcom/cyjh/elfin/dialog/DownloadDialogFragment;->apkDownloadUrl:Ljava/lang/String;

    .line 91
    const-string v1, "apkPackageName"

    invoke-virtual {v0, v1}, Landroid/os/Bundle;->getString(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v1

    iput-object v1, p0, Lcom/cyjh/elfin/dialog/DownloadDialogFragment;->apkPackageName:Ljava/lang/String;

    .line 92
    new-instance v1, Ljava/io/File;

    invoke-virtual {p0}, Lcom/cyjh/elfin/dialog/DownloadDialogFragment;->getActivity()Landroid/support/v4/app/FragmentActivity;

    move-result-object v2

    invoke-static {v2}, Lcom/cyjh/elfin/constant/Constants;->getApkPath(Landroid/content/Context;)Ljava/lang/String;

    move-result-object v2

    iget-object v3, p0, Lcom/cyjh/elfin/dialog/DownloadDialogFragment;->apkName:Ljava/lang/String;

    invoke-direct {v1, v2, v3}, Ljava/io/File;-><init>(Ljava/lang/String;Ljava/lang/String;)V

    iput-object v1, p0, Lcom/cyjh/elfin/dialog/DownloadDialogFragment;->desApkFile:Ljava/io/File;

    .line 93
    const-string v1, "imgPath"

    invoke-virtual {v0, v1}, Landroid/os/Bundle;->getString(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v1

    iput-object v1, p0, Lcom/cyjh/elfin/dialog/DownloadDialogFragment;->imgPath:Ljava/lang/String;

    .line 94
    return-void
.end method

.method public onCreateView(Landroid/view/LayoutInflater;Landroid/view/ViewGroup;Landroid/os/Bundle;)Landroid/view/View;
    .locals 1
    .param p1, "inflater"    # Landroid/view/LayoutInflater;
    .param p2, "container"    # Landroid/view/ViewGroup;
    .param p3, "savedInstanceState"    # Landroid/os/Bundle;
    .annotation build Landroid/support/annotation/Nullable;
    .end annotation

    .prologue
    .line 58
    const v0, 0x7f040040

    invoke-virtual {p1, v0, p2}, Landroid/view/LayoutInflater;->inflate(ILandroid/view/ViewGroup;)Landroid/view/View;

    move-result-object v0

    return-object v0
.end method

.method public onViewCreated(Landroid/view/View;Landroid/os/Bundle;)V
    .locals 6
    .param p1, "view"    # Landroid/view/View;
    .param p2, "savedInstanceState"    # Landroid/os/Bundle;
        .annotation build Landroid/support/annotation/Nullable;
        .end annotation
    .end param

    .prologue
    const/high16 v5, 0x41200000    # 10.0f

    const/4 v4, 0x0

    .line 98
    invoke-super {p0, p1, p2}, Landroid/support/v4/app/DialogFragment;->onViewCreated(Landroid/view/View;Landroid/os/Bundle;)V

    .line 99
    invoke-virtual {p0}, Lcom/cyjh/elfin/dialog/DownloadDialogFragment;->getView()Landroid/view/View;

    move-result-object v1

    if-nez v1, :cond_0

    .line 124
    :goto_0
    return-void

    .line 102
    :cond_0
    invoke-virtual {p0}, Lcom/cyjh/elfin/dialog/DownloadDialogFragment;->getView()Landroid/view/View;

    move-result-object v1

    const v2, 0x7f0f00d2

    invoke-virtual {v1, v2}, Landroid/view/View;->findViewById(I)Landroid/view/View;

    move-result-object v1

    check-cast v1, Lcom/dd/processbutton/iml/SubmitProcessButton;

    iput-object v1, p0, Lcom/cyjh/elfin/dialog/DownloadDialogFragment;->mButtonDownload:Lcom/dd/processbutton/iml/SubmitProcessButton;

    .line 103
    invoke-virtual {p0}, Lcom/cyjh/elfin/dialog/DownloadDialogFragment;->getView()Landroid/view/View;

    move-result-object v1

    const v2, 0x7f0f00d1

    invoke-virtual {v1, v2}, Landroid/view/View;->findViewById(I)Landroid/view/View;

    move-result-object v1

    check-cast v1, Landroid/widget/ImageView;

    iput-object v1, p0, Lcom/cyjh/elfin/dialog/DownloadDialogFragment;->mImageView:Landroid/widget/ImageView;

    .line 104
    invoke-virtual {p0}, Lcom/cyjh/elfin/dialog/DownloadDialogFragment;->getView()Landroid/view/View;

    move-result-object v1

    const v2, 0x7f0f00d0

    invoke-virtual {v1, v2}, Landroid/view/View;->findViewById(I)Landroid/view/View;

    move-result-object v1

    check-cast v1, Landroid/widget/TextView;

    iput-object v1, p0, Lcom/cyjh/elfin/dialog/DownloadDialogFragment;->mTvContent:Landroid/widget/TextView;

    .line 105
    iget-object v1, p0, Lcom/cyjh/elfin/dialog/DownloadDialogFragment;->imgPath:Ljava/lang/String;

    invoke-static {v1}, Landroid/text/TextUtils;->isEmpty(Ljava/lang/CharSequence;)Z

    move-result v1

    if-eqz v1, :cond_2

    .line 106
    iget-object v1, p0, Lcom/cyjh/elfin/dialog/DownloadDialogFragment;->mTvContent:Landroid/widget/TextView;

    invoke-virtual {v1, v4}, Landroid/widget/TextView;->setVisibility(I)V

    .line 108
    iget-object v1, p0, Lcom/cyjh/elfin/dialog/DownloadDialogFragment;->mImageView:Landroid/widget/ImageView;

    const v2, 0x7f02006d

    invoke-virtual {v1, v2}, Landroid/widget/ImageView;->setImageResource(I)V

    .line 120
    :goto_1
    iget-object v1, p0, Lcom/cyjh/elfin/dialog/DownloadDialogFragment;->apkPackageName:Ljava/lang/String;

    if-eqz v1, :cond_1

    invoke-virtual {p0}, Lcom/cyjh/elfin/dialog/DownloadDialogFragment;->getActivity()Landroid/support/v4/app/FragmentActivity;

    move-result-object v1

    iget-object v2, p0, Lcom/cyjh/elfin/dialog/DownloadDialogFragment;->apkPackageName:Ljava/lang/String;

    invoke-static {v1, v2}, Lcom/cyjh/elfin/util/AppDeviceUtils;->isAInstallPackage(Landroid/content/Context;Ljava/lang/String;)Z

    move-result v1

    if-eqz v1, :cond_1

    .line 121
    iget-object v1, p0, Lcom/cyjh/elfin/dialog/DownloadDialogFragment;->mButtonDownload:Lcom/dd/processbutton/iml/SubmitProcessButton;

    const v2, 0x7f08003c

    invoke-virtual {p0, v2}, Lcom/cyjh/elfin/dialog/DownloadDialogFragment;->getString(I)Ljava/lang/String;

    move-result-object v2

    invoke-virtual {v1, v2}, Lcom/dd/processbutton/iml/SubmitProcessButton;->setText(Ljava/lang/CharSequence;)V

    .line 123
    :cond_1
    iget-object v1, p0, Lcom/cyjh/elfin/dialog/DownloadDialogFragment;->mButtonDownload:Lcom/dd/processbutton/iml/SubmitProcessButton;

    iget-object v2, p0, Lcom/cyjh/elfin/dialog/DownloadDialogFragment;->mDownloadOnClickListener:Landroid/view/View$OnClickListener;

    invoke-virtual {v1, v2}, Lcom/dd/processbutton/iml/SubmitProcessButton;->setOnClickListener(Landroid/view/View$OnClickListener;)V

    goto :goto_0

    .line 110
    :cond_2
    iget-object v1, p0, Lcom/cyjh/elfin/dialog/DownloadDialogFragment;->mTvContent:Landroid/widget/TextView;

    const/16 v2, 0x8

    invoke-virtual {v1, v2}, Landroid/widget/TextView;->setVisibility(I)V

    .line 111
    iget-object v1, p0, Lcom/cyjh/elfin/dialog/DownloadDialogFragment;->mImageView:Landroid/widget/ImageView;

    invoke-virtual {v1}, Landroid/widget/ImageView;->getLayoutParams()Landroid/view/ViewGroup$LayoutParams;

    move-result-object v0

    check-cast v0, Landroid/widget/LinearLayout$LayoutParams;

    .line 112
    .local v0, "params":Landroid/widget/LinearLayout$LayoutParams;
    invoke-virtual {p0}, Lcom/cyjh/elfin/dialog/DownloadDialogFragment;->getActivity()Landroid/support/v4/app/FragmentActivity;

    move-result-object v1

    const/high16 v2, 0x43af0000    # 350.0f

    invoke-static {v1, v2}, Lcom/cyjh/elfin/util/AppDeviceUtils;->getDipToPx(Landroid/content/Context;F)I

    move-result v1

    iput v1, v0, Landroid/widget/LinearLayout$LayoutParams;->height:I

    .line 113
    const/4 v1, -0x1

    iput v1, v0, Landroid/widget/LinearLayout$LayoutParams;->width:I

    .line 114
    invoke-virtual {p0}, Lcom/cyjh/elfin/dialog/DownloadDialogFragment;->getActivity()Landroid/support/v4/app/FragmentActivity;

    move-result-object v1

    invoke-static {v1, v5}, Lcom/cyjh/elfin/util/AppDeviceUtils;->getDipToPx(Landroid/content/Context;F)I

    move-result v1

    invoke-virtual {p0}, Lcom/cyjh/elfin/dialog/DownloadDialogFragment;->getActivity()Landroid/support/v4/app/FragmentActivity;

    move-result-object v2

    invoke-static {v2, v5}, Lcom/cyjh/elfin/util/AppDeviceUtils;->getDipToPx(Landroid/content/Context;F)I

    move-result v2

    invoke-virtual {v0, v4, v1, v4, v2}, Landroid/widget/LinearLayout$LayoutParams;->setMargins(IIII)V

    .line 115
    iget-object v1, p0, Lcom/cyjh/elfin/dialog/DownloadDialogFragment;->mImageView:Landroid/widget/ImageView;

    sget-object v2, Landroid/widget/ImageView$ScaleType;->FIT_XY:Landroid/widget/ImageView$ScaleType;

    invoke-virtual {v1, v2}, Landroid/widget/ImageView;->setScaleType(Landroid/widget/ImageView$ScaleType;)V

    .line 116
    iget-object v1, p0, Lcom/cyjh/elfin/dialog/DownloadDialogFragment;->mImageView:Landroid/widget/ImageView;

    invoke-virtual {p0}, Lcom/cyjh/elfin/dialog/DownloadDialogFragment;->getActivity()Landroid/support/v4/app/FragmentActivity;

    move-result-object v2

    invoke-static {v2, v5}, Lcom/cyjh/elfin/util/AppDeviceUtils;->getDipToPx(Landroid/content/Context;F)I

    move-result v2

    invoke-virtual {p0}, Lcom/cyjh/elfin/dialog/DownloadDialogFragment;->getActivity()Landroid/support/v4/app/FragmentActivity;

    move-result-object v3

    invoke-static {v3, v5}, Lcom/cyjh/elfin/util/AppDeviceUtils;->getDipToPx(Landroid/content/Context;F)I

    move-result v3

    invoke-virtual {v1, v2, v4, v3, v4}, Landroid/widget/ImageView;->setPadding(IIII)V

    .line 117
    iget-object v1, p0, Lcom/cyjh/elfin/dialog/DownloadDialogFragment;->mImageView:Landroid/widget/ImageView;

    invoke-virtual {v1, v0}, Landroid/widget/ImageView;->setLayoutParams(Landroid/view/ViewGroup$LayoutParams;)V

    .line 118
    invoke-virtual {p0}, Lcom/cyjh/elfin/dialog/DownloadDialogFragment;->getActivity()Landroid/support/v4/app/FragmentActivity;

    move-result-object v1

    invoke-static {v1}, Lcom/squareup/picasso/Picasso;->with(Landroid/content/Context;)Lcom/squareup/picasso/Picasso;

    move-result-object v1

    iget-object v2, p0, Lcom/cyjh/elfin/dialog/DownloadDialogFragment;->imgPath:Ljava/lang/String;

    invoke-virtual {v1, v2}, Lcom/squareup/picasso/Picasso;->load(Ljava/lang/String;)Lcom/squareup/picasso/RequestCreator;

    move-result-object v1

    iget-object v2, p0, Lcom/cyjh/elfin/dialog/DownloadDialogFragment;->mImageView:Landroid/widget/ImageView;

    invoke-virtual {v1, v2}, Lcom/squareup/picasso/RequestCreator;->into(Landroid/widget/ImageView;)V

    goto/16 :goto_1
.end method

.method public setDialogShowing()V
    .locals 1

    .prologue
    .line 206
    const/4 v0, 0x0

    invoke-virtual {p0, v0}, Lcom/cyjh/elfin/dialog/DownloadDialogFragment;->setCancelable(Z)V

    .line 207
    return-void
.end method

.method protected setDialogSize()V
    .locals 4

    .prologue
    .line 168
    invoke-virtual {p0}, Lcom/cyjh/elfin/dialog/DownloadDialogFragment;->getActivity()Landroid/support/v4/app/FragmentActivity;

    move-result-object v2

    invoke-static {v2}, Lcom/cyjh/elfin/util/AppDeviceUtils;->getResolution(Landroid/content/Context;)Landroid/graphics/Point;

    move-result-object v1

    .line 169
    .local v1, "resolution":Landroid/graphics/Point;
    invoke-virtual {p0}, Lcom/cyjh/elfin/dialog/DownloadDialogFragment;->getDialog()Landroid/app/Dialog;

    move-result-object v2

    invoke-virtual {v2}, Landroid/app/Dialog;->getWindow()Landroid/view/Window;

    move-result-object v2

    invoke-virtual {v2}, Landroid/view/Window;->getAttributes()Landroid/view/WindowManager$LayoutParams;

    move-result-object v0

    .line 170
    .local v0, "p":Landroid/view/WindowManager$LayoutParams;
    iget v2, v1, Landroid/graphics/Point;->x:I

    int-to-float v2, v2

    const v3, 0x3f4ccccd    # 0.8f

    mul-float/2addr v2, v3

    float-to-int v2, v2

    iput v2, v0, Landroid/view/WindowManager$LayoutParams;->width:I

    .line 171
    iget v2, v1, Landroid/graphics/Point;->y:I

    int-to-float v2, v2

    const/high16 v3, 0x3f000000    # 0.5f

    mul-float/2addr v2, v3

    float-to-int v2, v2

    iput v2, v0, Landroid/view/WindowManager$LayoutParams;->height:I

    .line 172
    invoke-virtual {p0}, Lcom/cyjh/elfin/dialog/DownloadDialogFragment;->getDialog()Landroid/app/Dialog;

    move-result-object v2

    invoke-virtual {v2}, Landroid/app/Dialog;->getWindow()Landroid/view/Window;

    move-result-object v2

    invoke-virtual {v2, v0}, Landroid/view/Window;->setAttributes(Landroid/view/WindowManager$LayoutParams;)V

    .line 173
    return-void
.end method

.method public setHttpHandler(Lcom/lidroid/xutils/http/HttpHandler;)V
    .locals 0
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "(",
            "Lcom/lidroid/xutils/http/HttpHandler",
            "<",
            "Ljava/io/File;",
            ">;)V"
        }
    .end annotation

    .prologue
    .line 202
    .local p1, "downloadHandler":Lcom/lidroid/xutils/http/HttpHandler;, "Lcom/lidroid/xutils/http/HttpHandler<Ljava/io/File;>;"
    iput-object p1, p0, Lcom/cyjh/elfin/dialog/DownloadDialogFragment;->downloadHandler:Lcom/lidroid/xutils/http/HttpHandler;

    .line 203
    return-void
.end method

.method public setOnDownloadClickListener(Lcom/cyjh/elfin/dialog/DownloadDialogFragment$OnDownloadClickListener;)V
    .locals 0
    .param p1, "onDownloadClickListener"    # Lcom/cyjh/elfin/dialog/DownloadDialogFragment$OnDownloadClickListener;

    .prologue
    .line 197
    iput-object p1, p0, Lcom/cyjh/elfin/dialog/DownloadDialogFragment;->mOnDownloadClickListener:Lcom/cyjh/elfin/dialog/DownloadDialogFragment$OnDownloadClickListener;

    .line 198
    return-void
.end method
