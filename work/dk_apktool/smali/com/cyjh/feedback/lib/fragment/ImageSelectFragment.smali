.class public Lcom/cyjh/feedback/lib/fragment/ImageSelectFragment;
.super Lcom/cyjh/feedback/lib/base/BaseFragment;
.source "ImageSelectFragment.java"

# interfaces
.implements Landroid/view/View$OnClickListener;


# static fields
.field private static final LOAD_DEFAULT:I = 0x110

.field private static final SEPERATOR:Ljava/lang/String; = ","


# instance fields
.field private mAdapter:Lcom/cyjh/feedback/lib/adapter/ImageSelectAdapter;

.field private mButtonSure:Landroid/widget/Button;

.field private mFolderList:Ljava/util/List;
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "Ljava/util/List",
            "<",
            "Lcom/cyjh/feedback/lib/entities/FolderBean;",
            ">;"
        }
    .end annotation
.end field

.field private mGridView:Landroid/widget/GridView;

.field private mHandler:Landroid/os/Handler;

.field private mImg:Ljava/util/List;
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "Ljava/util/List",
            "<",
            "Ljava/lang/String;",
            ">;"
        }
    .end annotation
.end field

.field private mImgDir:Ljava/io/File;

.field private mPicSize:I

.field private mProgressDialog:Landroid/app/ProgressDialog;

.field private mdatas:Ljava/util/ArrayList;
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "Ljava/util/ArrayList",
            "<",
            "Ljava/lang/String;",
            ">;"
        }
    .end annotation
.end field


# direct methods
.method public constructor <init>()V
    .locals 1

    .prologue
    .line 39
    invoke-direct {p0}, Lcom/cyjh/feedback/lib/base/BaseFragment;-><init>()V

    .line 65
    new-instance v0, Lcom/cyjh/feedback/lib/fragment/ImageSelectFragment$1;

    invoke-direct {v0, p0}, Lcom/cyjh/feedback/lib/fragment/ImageSelectFragment$1;-><init>(Lcom/cyjh/feedback/lib/fragment/ImageSelectFragment;)V

    iput-object v0, p0, Lcom/cyjh/feedback/lib/fragment/ImageSelectFragment;->mHandler:Landroid/os/Handler;

    return-void
.end method

.method static synthetic access$000(Lcom/cyjh/feedback/lib/fragment/ImageSelectFragment;)Landroid/app/ProgressDialog;
    .locals 1
    .param p0, "x0"    # Lcom/cyjh/feedback/lib/fragment/ImageSelectFragment;

    .prologue
    .line 39
    iget-object v0, p0, Lcom/cyjh/feedback/lib/fragment/ImageSelectFragment;->mProgressDialog:Landroid/app/ProgressDialog;

    return-object v0
.end method

.method static synthetic access$100(Lcom/cyjh/feedback/lib/fragment/ImageSelectFragment;Lcom/cyjh/feedback/lib/entities/FolderBean;)V
    .locals 0
    .param p0, "x0"    # Lcom/cyjh/feedback/lib/fragment/ImageSelectFragment;
    .param p1, "x1"    # Lcom/cyjh/feedback/lib/entities/FolderBean;

    .prologue
    .line 39
    invoke-direct {p0, p1}, Lcom/cyjh/feedback/lib/fragment/ImageSelectFragment;->data2View(Lcom/cyjh/feedback/lib/entities/FolderBean;)V

    return-void
.end method

.method static synthetic access$200(Lcom/cyjh/feedback/lib/fragment/ImageSelectFragment;)Landroid/widget/Button;
    .locals 1
    .param p0, "x0"    # Lcom/cyjh/feedback/lib/fragment/ImageSelectFragment;

    .prologue
    .line 39
    iget-object v0, p0, Lcom/cyjh/feedback/lib/fragment/ImageSelectFragment;->mButtonSure:Landroid/widget/Button;

    return-object v0
.end method

.method static synthetic access$300(Lcom/cyjh/feedback/lib/fragment/ImageSelectFragment;Ljava/lang/String;)Z
    .locals 1
    .param p0, "x0"    # Lcom/cyjh/feedback/lib/fragment/ImageSelectFragment;
    .param p1, "x1"    # Ljava/lang/String;

    .prologue
    .line 39
    invoke-direct {p0, p1}, Lcom/cyjh/feedback/lib/fragment/ImageSelectFragment;->filterImgBySuffix(Ljava/lang/String;)Z

    move-result v0

    return v0
.end method

.method static synthetic access$400(Lcom/cyjh/feedback/lib/fragment/ImageSelectFragment;)I
    .locals 1
    .param p0, "x0"    # Lcom/cyjh/feedback/lib/fragment/ImageSelectFragment;

    .prologue
    .line 39
    iget v0, p0, Lcom/cyjh/feedback/lib/fragment/ImageSelectFragment;->mPicSize:I

    return v0
.end method

.method static synthetic access$402(Lcom/cyjh/feedback/lib/fragment/ImageSelectFragment;I)I
    .locals 0
    .param p0, "x0"    # Lcom/cyjh/feedback/lib/fragment/ImageSelectFragment;
    .param p1, "x1"    # I

    .prologue
    .line 39
    iput p1, p0, Lcom/cyjh/feedback/lib/fragment/ImageSelectFragment;->mPicSize:I

    return p1
.end method

.method static synthetic access$502(Lcom/cyjh/feedback/lib/fragment/ImageSelectFragment;Ljava/io/File;)Ljava/io/File;
    .locals 0
    .param p0, "x0"    # Lcom/cyjh/feedback/lib/fragment/ImageSelectFragment;
    .param p1, "x1"    # Ljava/io/File;

    .prologue
    .line 39
    iput-object p1, p0, Lcom/cyjh/feedback/lib/fragment/ImageSelectFragment;->mImgDir:Ljava/io/File;

    return-object p1
.end method

.method static synthetic access$600(Lcom/cyjh/feedback/lib/fragment/ImageSelectFragment;)Ljava/util/List;
    .locals 1
    .param p0, "x0"    # Lcom/cyjh/feedback/lib/fragment/ImageSelectFragment;

    .prologue
    .line 39
    iget-object v0, p0, Lcom/cyjh/feedback/lib/fragment/ImageSelectFragment;->mFolderList:Ljava/util/List;

    return-object v0
.end method

.method static synthetic access$700(Lcom/cyjh/feedback/lib/fragment/ImageSelectFragment;Lcom/cyjh/feedback/lib/entities/FolderBean;)V
    .locals 0
    .param p0, "x0"    # Lcom/cyjh/feedback/lib/fragment/ImageSelectFragment;
    .param p1, "x1"    # Lcom/cyjh/feedback/lib/entities/FolderBean;

    .prologue
    .line 39
    invoke-direct {p0, p1}, Lcom/cyjh/feedback/lib/fragment/ImageSelectFragment;->gridViewDatas(Lcom/cyjh/feedback/lib/entities/FolderBean;)V

    return-void
.end method

.method static synthetic access$800(Lcom/cyjh/feedback/lib/fragment/ImageSelectFragment;)Landroid/os/Handler;
    .locals 1
    .param p0, "x0"    # Lcom/cyjh/feedback/lib/fragment/ImageSelectFragment;

    .prologue
    .line 39
    iget-object v0, p0, Lcom/cyjh/feedback/lib/fragment/ImageSelectFragment;->mHandler:Landroid/os/Handler;

    return-object v0
.end method

.method private data2View(Lcom/cyjh/feedback/lib/entities/FolderBean;)V
    .locals 4
    .param p1, "folderBean"    # Lcom/cyjh/feedback/lib/entities/FolderBean;

    .prologue
    const/4 v3, 0x1

    const/4 v2, 0x0

    .line 78
    invoke-virtual {p1}, Lcom/cyjh/feedback/lib/entities/FolderBean;->getDirPath()Ljava/lang/String;

    move-result-object v0

    invoke-static {v0}, Landroid/text/TextUtils;->isEmpty(Ljava/lang/CharSequence;)Z

    move-result v0

    if-eqz v0, :cond_0

    .line 79
    invoke-virtual {p0}, Lcom/cyjh/feedback/lib/fragment/ImageSelectFragment;->getActivity()Landroid/support/v4/app/FragmentActivity;

    move-result-object v0

    sget v1, Lcom/cyjh/feedback/libraryfeedbackinfo/R$string;->no_everything_picture:I

    invoke-virtual {p0, v1}, Lcom/cyjh/feedback/lib/fragment/ImageSelectFragment;->getString(I)Ljava/lang/String;

    move-result-object v1

    invoke-static {v0, v1, v2}, Landroid/widget/Toast;->makeText(Landroid/content/Context;Ljava/lang/CharSequence;I)Landroid/widget/Toast;

    move-result-object v0

    invoke-virtual {v0}, Landroid/widget/Toast;->show()V

    .line 80
    const-string v0, "folderBean.getDirPath()"

    new-array v1, v2, [Ljava/lang/Object;

    invoke-static {v0, v1}, Lcom/orhanobut/logger/Logger;->e(Ljava/lang/String;[Ljava/lang/Object;)V

    .line 97
    :goto_0
    return-void

    .line 83
    :cond_0
    iget-object v0, p0, Lcom/cyjh/feedback/lib/fragment/ImageSelectFragment;->mImgDir:Ljava/io/File;

    if-nez v0, :cond_1

    .line 84
    invoke-virtual {p0}, Lcom/cyjh/feedback/lib/fragment/ImageSelectFragment;->getActivity()Landroid/support/v4/app/FragmentActivity;

    move-result-object v0

    sget v1, Lcom/cyjh/feedback/libraryfeedbackinfo/R$string;->no_everything_picture:I

    invoke-virtual {p0, v1}, Lcom/cyjh/feedback/lib/fragment/ImageSelectFragment;->getString(I)Ljava/lang/String;

    move-result-object v1

    invoke-static {v0, v1, v3}, Landroid/widget/Toast;->makeText(Landroid/content/Context;Ljava/lang/CharSequence;I)Landroid/widget/Toast;

    move-result-object v0

    invoke-virtual {v0}, Landroid/widget/Toast;->show()V

    .line 85
    const-string v0, "mImgDir == null"

    new-array v1, v2, [Ljava/lang/Object;

    invoke-static {v0, v1}, Lcom/orhanobut/logger/Logger;->e(Ljava/lang/String;[Ljava/lang/Object;)V

    goto :goto_0

    .line 88
    :cond_1
    iget-object v0, p0, Lcom/cyjh/feedback/lib/fragment/ImageSelectFragment;->mImg:Ljava/util/List;

    if-eqz v0, :cond_2

    iget-object v0, p0, Lcom/cyjh/feedback/lib/fragment/ImageSelectFragment;->mImg:Ljava/util/List;

    invoke-interface {v0}, Ljava/util/List;->size()I

    move-result v0

    if-gtz v0, :cond_2

    .line 89
    invoke-virtual {p0}, Lcom/cyjh/feedback/lib/fragment/ImageSelectFragment;->getActivity()Landroid/support/v4/app/FragmentActivity;

    move-result-object v0

    sget v1, Lcom/cyjh/feedback/libraryfeedbackinfo/R$string;->no_everything_picture:I

    invoke-virtual {p0, v1}, Lcom/cyjh/feedback/lib/fragment/ImageSelectFragment;->getString(I)Ljava/lang/String;

    move-result-object v1

    invoke-static {v0, v1, v3}, Landroid/widget/Toast;->makeText(Landroid/content/Context;Ljava/lang/CharSequence;I)Landroid/widget/Toast;

    move-result-object v0

    invoke-virtual {v0}, Landroid/widget/Toast;->show()V

    .line 90
    const-string v0, "mImg != null && mImg.size() <= 0"

    new-array v1, v2, [Ljava/lang/Object;

    invoke-static {v0, v1}, Lcom/orhanobut/logger/Logger;->e(Ljava/lang/String;[Ljava/lang/Object;)V

    goto :goto_0

    .line 93
    :cond_2
    new-instance v0, Lcom/cyjh/feedback/lib/adapter/ImageSelectAdapter;

    invoke-virtual {p0}, Lcom/cyjh/feedback/lib/fragment/ImageSelectFragment;->getActivity()Landroid/support/v4/app/FragmentActivity;

    move-result-object v1

    iget-object v2, p0, Lcom/cyjh/feedback/lib/fragment/ImageSelectFragment;->mImg:Ljava/util/List;

    invoke-direct {v0, v1, v2}, Lcom/cyjh/feedback/lib/adapter/ImageSelectAdapter;-><init>(Landroid/content/Context;Ljava/util/List;)V

    iput-object v0, p0, Lcom/cyjh/feedback/lib/fragment/ImageSelectFragment;->mAdapter:Lcom/cyjh/feedback/lib/adapter/ImageSelectAdapter;

    .line 94
    iget-object v0, p0, Lcom/cyjh/feedback/lib/fragment/ImageSelectFragment;->mGridView:Landroid/widget/GridView;

    iget-object v1, p0, Lcom/cyjh/feedback/lib/fragment/ImageSelectFragment;->mAdapter:Lcom/cyjh/feedback/lib/adapter/ImageSelectAdapter;

    invoke-virtual {v0, v1}, Landroid/widget/GridView;->setAdapter(Landroid/widget/ListAdapter;)V

    .line 95
    iget-object v0, p0, Lcom/cyjh/feedback/lib/fragment/ImageSelectFragment;->mAdapter:Lcom/cyjh/feedback/lib/adapter/ImageSelectAdapter;

    invoke-virtual {v0}, Lcom/cyjh/feedback/lib/adapter/ImageSelectAdapter;->notifyDataSetChanged()V

    .line 96
    invoke-direct {p0}, Lcom/cyjh/feedback/lib/fragment/ImageSelectFragment;->initEvent()V

    goto :goto_0
.end method

.method private filterImgBySuffix(Ljava/lang/String;)Z
    .locals 2
    .param p1, "filename"    # Ljava/lang/String;

    .prologue
    .line 266
    invoke-virtual {p1}, Ljava/lang/String;->toLowerCase()Ljava/lang/String;

    move-result-object v0

    const-string v1, ".jpg"

    invoke-virtual {v0, v1}, Ljava/lang/String;->endsWith(Ljava/lang/String;)Z

    move-result v0

    if-nez v0, :cond_0

    invoke-virtual {p1}, Ljava/lang/String;->toLowerCase()Ljava/lang/String;

    move-result-object v0

    const-string v1, ".jpeg"

    invoke-virtual {v0, v1}, Ljava/lang/String;->endsWith(Ljava/lang/String;)Z

    move-result v0

    if-nez v0, :cond_0

    .line 267
    invoke-virtual {p1}, Ljava/lang/String;->toLowerCase()Ljava/lang/String;

    move-result-object v0

    const-string v1, ".png"

    invoke-virtual {v0, v1}, Ljava/lang/String;->endsWith(Ljava/lang/String;)Z

    move-result v0

    if-eqz v0, :cond_1

    :cond_0
    const/4 v0, 0x1

    .line 266
    :goto_0
    return v0

    .line 267
    :cond_1
    const/4 v0, 0x0

    goto :goto_0
.end method

.method private gridViewDatas(Lcom/cyjh/feedback/lib/entities/FolderBean;)V
    .locals 13
    .param p1, "folder"    # Lcom/cyjh/feedback/lib/entities/FolderBean;

    .prologue
    const/4 v6, 0x0

    .line 234
    iget-object v5, p0, Lcom/cyjh/feedback/lib/fragment/ImageSelectFragment;->mImg:Ljava/util/List;

    invoke-interface {v5}, Ljava/util/List;->clear()V

    .line 236
    invoke-virtual {p1}, Lcom/cyjh/feedback/lib/entities/FolderBean;->getDirPath()Ljava/lang/String;

    move-result-object v5

    const-string v7, ","

    invoke-virtual {v5, v7}, Ljava/lang/String;->split(Ljava/lang/String;)[Ljava/lang/String;

    move-result-object v0

    .line 240
    .local v0, "dirPaths":[Ljava/lang/String;
    array-length v8, v0

    move v7, v6

    :goto_0
    if-ge v7, v8, :cond_1

    aget-object v2, v0, v7

    .line 241
    .local v2, "path":Ljava/lang/String;
    new-instance v3, Ljava/io/File;

    invoke-direct {v3, v2}, Ljava/io/File;-><init>(Ljava/lang/String;)V

    .line 244
    .local v3, "selDir":Ljava/io/File;
    new-instance v5, Lcom/cyjh/feedback/lib/fragment/ImageSelectFragment$4;

    invoke-direct {v5, p0}, Lcom/cyjh/feedback/lib/fragment/ImageSelectFragment$4;-><init>(Lcom/cyjh/feedback/lib/fragment/ImageSelectFragment;)V

    invoke-virtual {v3, v5}, Ljava/io/File;->list(Ljava/io/FilenameFilter;)[Ljava/lang/String;

    move-result-object v1

    .line 251
    .local v1, "fileNames":[Ljava/lang/String;
    if-eqz v1, :cond_0

    .line 252
    array-length v9, v1

    move v5, v6

    :goto_1
    if-ge v5, v9, :cond_0

    aget-object v4, v1, v5

    .line 253
    .local v4, "stra":Ljava/lang/String;
    iget-object v10, p0, Lcom/cyjh/feedback/lib/fragment/ImageSelectFragment;->mImg:Ljava/util/List;

    new-instance v11, Ljava/lang/StringBuilder;

    invoke-direct {v11}, Ljava/lang/StringBuilder;-><init>()V

    invoke-virtual {v11, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v11

    sget-object v12, Ljava/io/File;->separator:Ljava/lang/String;

    invoke-virtual {v11, v12}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v11

    invoke-virtual {v11, v4}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v11

    invoke-virtual {v11}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v11

    invoke-interface {v10, v11}, Ljava/util/List;->add(Ljava/lang/Object;)Z

    .line 252
    add-int/lit8 v5, v5, 0x1

    goto :goto_1

    .line 240
    .end local v4    # "stra":Ljava/lang/String;
    :cond_0
    add-int/lit8 v5, v7, 0x1

    move v7, v5

    goto :goto_0

    .line 258
    .end local v1    # "fileNames":[Ljava/lang/String;
    .end local v2    # "path":Ljava/lang/String;
    .end local v3    # "selDir":Ljava/io/File;
    :cond_1
    return-void
.end method

.method private initData()V
    .locals 3

    .prologue
    .line 139
    const-string v0, "mounted"

    invoke-static {}, Landroid/os/Environment;->getExternalStorageState()Ljava/lang/String;

    move-result-object v1

    invoke-virtual {v0, v1}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v0

    if-nez v0, :cond_0

    .line 140
    invoke-virtual {p0}, Lcom/cyjh/feedback/lib/fragment/ImageSelectFragment;->getActivity()Landroid/support/v4/app/FragmentActivity;

    move-result-object v0

    sget v1, Lcom/cyjh/feedback/libraryfeedbackinfo/R$string;->no_sdk:I

    invoke-virtual {p0, v1}, Lcom/cyjh/feedback/lib/fragment/ImageSelectFragment;->getString(I)Ljava/lang/String;

    move-result-object v1

    const/4 v2, 0x1

    invoke-static {v0, v1, v2}, Landroid/widget/Toast;->makeText(Landroid/content/Context;Ljava/lang/CharSequence;I)Landroid/widget/Toast;

    move-result-object v0

    invoke-virtual {v0}, Landroid/widget/Toast;->show()V

    .line 226
    :goto_0
    return-void

    .line 143
    :cond_0
    invoke-virtual {p0}, Lcom/cyjh/feedback/lib/fragment/ImageSelectFragment;->getActivity()Landroid/support/v4/app/FragmentActivity;

    move-result-object v0

    const/4 v1, 0x0

    sget v2, Lcom/cyjh/feedback/libraryfeedbackinfo/R$string;->loading_somethings:I

    invoke-virtual {p0, v2}, Lcom/cyjh/feedback/lib/fragment/ImageSelectFragment;->getString(I)Ljava/lang/String;

    move-result-object v2

    invoke-static {v0, v1, v2}, Landroid/app/ProgressDialog;->show(Landroid/content/Context;Ljava/lang/CharSequence;Ljava/lang/CharSequence;)Landroid/app/ProgressDialog;

    move-result-object v0

    iput-object v0, p0, Lcom/cyjh/feedback/lib/fragment/ImageSelectFragment;->mProgressDialog:Landroid/app/ProgressDialog;

    .line 145
    new-instance v0, Lcom/cyjh/feedback/lib/fragment/ImageSelectFragment$3;

    invoke-direct {v0, p0}, Lcom/cyjh/feedback/lib/fragment/ImageSelectFragment$3;-><init>(Lcom/cyjh/feedback/lib/fragment/ImageSelectFragment;)V

    .line 225
    invoke-virtual {v0}, Lcom/cyjh/feedback/lib/fragment/ImageSelectFragment$3;->start()V

    goto :goto_0
.end method

.method private initEvent()V
    .locals 2

    .prologue
    .line 117
    iget-object v0, p0, Lcom/cyjh/feedback/lib/fragment/ImageSelectFragment;->mAdapter:Lcom/cyjh/feedback/lib/adapter/ImageSelectAdapter;

    new-instance v1, Lcom/cyjh/feedback/lib/fragment/ImageSelectFragment$2;

    invoke-direct {v1, p0}, Lcom/cyjh/feedback/lib/fragment/ImageSelectFragment$2;-><init>(Lcom/cyjh/feedback/lib/fragment/ImageSelectFragment;)V

    invoke-virtual {v0, v1}, Lcom/cyjh/feedback/lib/adapter/ImageSelectAdapter;->setOnSelectImgNumber(Lcom/cyjh/feedback/lib/adapter/ImageSelectAdapter$OnSelectImgNumber;)V

    .line 123
    return-void
.end method

.method private initView(Landroid/view/View;)V
    .locals 5
    .param p1, "view"    # Landroid/view/View;

    .prologue
    .line 126
    new-instance v0, Ljava/util/ArrayList;

    invoke-direct {v0}, Ljava/util/ArrayList;-><init>()V

    iput-object v0, p0, Lcom/cyjh/feedback/lib/fragment/ImageSelectFragment;->mdatas:Ljava/util/ArrayList;

    .line 127
    sget v0, Lcom/cyjh/feedback/libraryfeedbackinfo/R$id;->grid_view:I

    invoke-virtual {p1, v0}, Landroid/view/View;->findViewById(I)Landroid/view/View;

    move-result-object v0

    check-cast v0, Landroid/widget/GridView;

    iput-object v0, p0, Lcom/cyjh/feedback/lib/fragment/ImageSelectFragment;->mGridView:Landroid/widget/GridView;

    .line 128
    new-instance v0, Ljava/util/ArrayList;

    invoke-direct {v0}, Ljava/util/ArrayList;-><init>()V

    iput-object v0, p0, Lcom/cyjh/feedback/lib/fragment/ImageSelectFragment;->mImg:Ljava/util/List;

    .line 129
    new-instance v0, Ljava/util/ArrayList;

    invoke-direct {v0}, Ljava/util/ArrayList;-><init>()V

    iput-object v0, p0, Lcom/cyjh/feedback/lib/fragment/ImageSelectFragment;->mFolderList:Ljava/util/List;

    .line 130
    sget v0, Lcom/cyjh/feedback/libraryfeedbackinfo/R$id;->id_btn_sure:I

    invoke-virtual {p1, v0}, Landroid/view/View;->findViewById(I)Landroid/view/View;

    move-result-object v0

    check-cast v0, Landroid/widget/Button;

    iput-object v0, p0, Lcom/cyjh/feedback/lib/fragment/ImageSelectFragment;->mButtonSure:Landroid/widget/Button;

    .line 131
    iget-object v0, p0, Lcom/cyjh/feedback/lib/fragment/ImageSelectFragment;->mButtonSure:Landroid/widget/Button;

    sget v1, Lcom/cyjh/feedback/libraryfeedbackinfo/R$string;->btn_sure:I

    const/4 v2, 0x1

    new-array v2, v2, [Ljava/lang/Object;

    const/4 v3, 0x0

    iget-object v4, p0, Lcom/cyjh/feedback/lib/fragment/ImageSelectFragment;->mdatas:Ljava/util/ArrayList;

    invoke-virtual {v4}, Ljava/util/ArrayList;->size()I

    move-result v4

    invoke-static {v4}, Ljava/lang/Integer;->valueOf(I)Ljava/lang/Integer;

    move-result-object v4

    aput-object v4, v2, v3

    invoke-virtual {p0, v1, v2}, Lcom/cyjh/feedback/lib/fragment/ImageSelectFragment;->getString(I[Ljava/lang/Object;)Ljava/lang/String;

    move-result-object v1

    invoke-virtual {v0, v1}, Landroid/widget/Button;->setText(Ljava/lang/CharSequence;)V

    .line 132
    iget-object v0, p0, Lcom/cyjh/feedback/lib/fragment/ImageSelectFragment;->mButtonSure:Landroid/widget/Button;

    invoke-virtual {v0, p0}, Landroid/widget/Button;->setOnClickListener(Landroid/view/View$OnClickListener;)V

    .line 133
    return-void
.end method

.method public static newInstance()Lcom/cyjh/feedback/lib/fragment/ImageSelectFragment;
    .locals 1

    .prologue
    .line 100
    new-instance v0, Lcom/cyjh/feedback/lib/fragment/ImageSelectFragment;

    invoke-direct {v0}, Lcom/cyjh/feedback/lib/fragment/ImageSelectFragment;-><init>()V

    return-object v0
.end method


# virtual methods
.method public getFragmentLayoutId()I
    .locals 1

    .prologue
    .line 104
    sget v0, Lcom/cyjh/feedback/libraryfeedbackinfo/R$layout;->fragment_select_image:I

    return v0
.end method

.method public onClick(Landroid/view/View;)V
    .locals 7
    .param p1, "v"    # Landroid/view/View;

    .prologue
    .line 272
    invoke-virtual {p1}, Landroid/view/View;->getId()I

    move-result v1

    .line 273
    .local v1, "id":I
    sget v4, Lcom/cyjh/feedback/libraryfeedbackinfo/R$id;->id_btn_sure:I

    if-ne v1, v4, :cond_0

    .line 274
    iget-object v4, p0, Lcom/cyjh/feedback/lib/fragment/ImageSelectFragment;->mAdapter:Lcom/cyjh/feedback/lib/adapter/ImageSelectAdapter;

    if-nez v4, :cond_1

    .line 291
    :cond_0
    :goto_0
    return-void

    .line 277
    :cond_1
    iget-object v4, p0, Lcom/cyjh/feedback/lib/fragment/ImageSelectFragment;->mAdapter:Lcom/cyjh/feedback/lib/adapter/ImageSelectAdapter;

    invoke-virtual {v4}, Lcom/cyjh/feedback/lib/adapter/ImageSelectAdapter;->getmSetSelect()Ljava/util/Set;

    move-result-object v4

    invoke-interface {v4}, Ljava/util/Set;->size()I

    move-result v4

    if-gtz v4, :cond_2

    .line 278
    invoke-virtual {p0}, Lcom/cyjh/feedback/lib/fragment/ImageSelectFragment;->getActivity()Landroid/support/v4/app/FragmentActivity;

    move-result-object v4

    sget v5, Lcom/cyjh/feedback/libraryfeedbackinfo/R$string;->please_choose_photo:I

    invoke-virtual {p0, v5}, Lcom/cyjh/feedback/lib/fragment/ImageSelectFragment;->getString(I)Ljava/lang/String;

    move-result-object v5

    const/4 v6, 0x1

    invoke-static {v4, v5, v6}, Landroid/widget/Toast;->makeText(Landroid/content/Context;Ljava/lang/CharSequence;I)Landroid/widget/Toast;

    move-result-object v4

    invoke-virtual {v4}, Landroid/widget/Toast;->show()V

    goto :goto_0

    .line 281
    :cond_2
    iget-object v4, p0, Lcom/cyjh/feedback/lib/fragment/ImageSelectFragment;->mAdapter:Lcom/cyjh/feedback/lib/adapter/ImageSelectAdapter;

    invoke-virtual {v4}, Lcom/cyjh/feedback/lib/adapter/ImageSelectAdapter;->getmSetSelect()Ljava/util/Set;

    move-result-object v4

    invoke-interface {v4}, Ljava/util/Set;->iterator()Ljava/util/Iterator;

    move-result-object v4

    :goto_1
    invoke-interface {v4}, Ljava/util/Iterator;->hasNext()Z

    move-result v5

    if-eqz v5, :cond_3

    invoke-interface {v4}, Ljava/util/Iterator;->next()Ljava/lang/Object;

    move-result-object v3

    check-cast v3, Ljava/lang/String;

    .line 282
    .local v3, "path":Ljava/lang/String;
    iget-object v5, p0, Lcom/cyjh/feedback/lib/fragment/ImageSelectFragment;->mdatas:Ljava/util/ArrayList;

    invoke-virtual {v5, v3}, Ljava/util/ArrayList;->add(Ljava/lang/Object;)Z

    goto :goto_1

    .line 284
    .end local v3    # "path":Ljava/lang/String;
    :cond_3
    new-instance v2, Landroid/content/Intent;

    invoke-direct {v2}, Landroid/content/Intent;-><init>()V

    .line 285
    .local v2, "intent":Landroid/content/Intent;
    new-instance v0, Landroid/os/Bundle;

    invoke-direct {v0}, Landroid/os/Bundle;-><init>()V

    .line 286
    .local v0, "bundle":Landroid/os/Bundle;
    const-string v4, "image"

    iget-object v5, p0, Lcom/cyjh/feedback/lib/fragment/ImageSelectFragment;->mdatas:Ljava/util/ArrayList;

    invoke-virtual {v0, v4, v5}, Landroid/os/Bundle;->putStringArrayList(Ljava/lang/String;Ljava/util/ArrayList;)V

    .line 287
    const-string v4, "bundle"

    invoke-virtual {v2, v4, v0}, Landroid/content/Intent;->putExtra(Ljava/lang/String;Landroid/os/Bundle;)Landroid/content/Intent;

    .line 288
    invoke-virtual {p0}, Lcom/cyjh/feedback/lib/fragment/ImageSelectFragment;->getActivity()Landroid/support/v4/app/FragmentActivity;

    move-result-object v4

    const/4 v5, -0x1

    invoke-virtual {v4, v5, v2}, Landroid/support/v4/app/FragmentActivity;->setResult(ILandroid/content/Intent;)V

    .line 289
    invoke-virtual {p0}, Lcom/cyjh/feedback/lib/fragment/ImageSelectFragment;->getActivity()Landroid/support/v4/app/FragmentActivity;

    move-result-object v4

    invoke-virtual {v4}, Landroid/support/v4/app/FragmentActivity;->finish()V

    goto :goto_0
.end method

.method public onPause()V
    .locals 1

    .prologue
    .line 301
    invoke-super {p0}, Lcom/cyjh/feedback/lib/base/BaseFragment;->onPause()V

    .line 302
    const-class v0, Lcom/cyjh/feedback/lib/fragment/ImageSelectFragment;

    invoke-virtual {v0}, Ljava/lang/Class;->getCanonicalName()Ljava/lang/String;

    move-result-object v0

    invoke-static {v0}, Lcom/umeng/analytics/MobclickAgent;->onPageEnd(Ljava/lang/String;)V

    .line 303
    return-void
.end method

.method public onResume()V
    .locals 1

    .prologue
    .line 295
    invoke-super {p0}, Lcom/cyjh/feedback/lib/base/BaseFragment;->onResume()V

    .line 296
    const-class v0, Lcom/cyjh/feedback/lib/fragment/ImageSelectFragment;

    invoke-virtual {v0}, Ljava/lang/Class;->getCanonicalName()Ljava/lang/String;

    move-result-object v0

    invoke-static {v0}, Lcom/umeng/analytics/MobclickAgent;->onPageStart(Ljava/lang/String;)V

    .line 297
    return-void
.end method

.method public onViewCreated(Landroid/view/View;Landroid/os/Bundle;)V
    .locals 0
    .param p1, "view"    # Landroid/view/View;
    .param p2, "savedInstanceState"    # Landroid/os/Bundle;

    .prologue
    .line 109
    invoke-super {p0, p1, p2}, Lcom/cyjh/feedback/lib/base/BaseFragment;->onViewCreated(Landroid/view/View;Landroid/os/Bundle;)V

    .line 110
    invoke-direct {p0, p1}, Lcom/cyjh/feedback/lib/fragment/ImageSelectFragment;->initView(Landroid/view/View;)V

    .line 111
    invoke-direct {p0}, Lcom/cyjh/feedback/lib/fragment/ImageSelectFragment;->initData()V

    .line 113
    return-void
.end method
