.class public Lcom/cyjh/elfin/activity/ImagePicZoomActivity;
.super Lcom/cyjh/elfin/activity/BaseActivity;
.source "ImagePicZoomActivity.java"


# annotations
.annotation system Ldalvik/annotation/MemberClasses;
    value = {
        Lcom/cyjh/elfin/activity/ImagePicZoomActivity$ImageAdapter;
    }
.end annotation


# instance fields
.field private currentIndex:I

.field private imageViewList:Ljava/util/List;
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "Ljava/util/List",
            "<",
            "Landroid/widget/ImageView;",
            ">;"
        }
    .end annotation
.end field

.field private imgUrlList:Ljava/util/List;
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "Ljava/util/List",
            "<",
            "Ljava/lang/String;",
            ">;"
        }
    .end annotation
.end field

.field private mImageAdapter:Lcom/cyjh/elfin/activity/ImagePicZoomActivity$ImageAdapter;

.field private mViewPager:Landroid/support/v4/view/ViewPager;


# direct methods
.method public constructor <init>()V
    .locals 1

    .prologue
    .line 18
    invoke-direct {p0}, Lcom/cyjh/elfin/activity/BaseActivity;-><init>()V

    .line 20
    new-instance v0, Ljava/util/ArrayList;

    invoke-direct {v0}, Ljava/util/ArrayList;-><init>()V

    iput-object v0, p0, Lcom/cyjh/elfin/activity/ImagePicZoomActivity;->imageViewList:Ljava/util/List;

    return-void
.end method

.method static synthetic access$000(Lcom/cyjh/elfin/activity/ImagePicZoomActivity;)Ljava/util/List;
    .locals 1
    .param p0, "x0"    # Lcom/cyjh/elfin/activity/ImagePicZoomActivity;

    .prologue
    .line 18
    iget-object v0, p0, Lcom/cyjh/elfin/activity/ImagePicZoomActivity;->imgUrlList:Ljava/util/List;

    return-object v0
.end method

.method static synthetic access$100(Lcom/cyjh/elfin/activity/ImagePicZoomActivity;)Ljava/util/List;
    .locals 1
    .param p0, "x0"    # Lcom/cyjh/elfin/activity/ImagePicZoomActivity;

    .prologue
    .line 18
    iget-object v0, p0, Lcom/cyjh/elfin/activity/ImagePicZoomActivity;->imageViewList:Ljava/util/List;

    return-object v0
.end method

.method private initData()V
    .locals 5

    .prologue
    .line 37
    invoke-virtual {p0}, Lcom/cyjh/elfin/activity/ImagePicZoomActivity;->getIntent()Landroid/content/Intent;

    move-result-object v2

    const-class v3, Lcom/cyjh/elfin/activity/ImagePicZoomActivity;

    invoke-virtual {v3}, Ljava/lang/Class;->getSimpleName()Ljava/lang/String;

    move-result-object v3

    const/4 v4, 0x0

    invoke-virtual {v2, v3, v4}, Landroid/content/Intent;->getIntExtra(Ljava/lang/String;I)I

    move-result v2

    iput v2, p0, Lcom/cyjh/elfin/activity/ImagePicZoomActivity;->currentIndex:I

    .line 38
    const/4 v2, 0x0

    iput-object v2, p0, Lcom/cyjh/elfin/activity/ImagePicZoomActivity;->imgUrlList:Ljava/util/List;

    .line 39
    invoke-virtual {p0}, Lcom/cyjh/elfin/activity/ImagePicZoomActivity;->getIntent()Landroid/content/Intent;

    move-result-object v2

    const-class v3, Lcom/cyjh/elfin/activity/ImagePicZoomActivity;

    invoke-virtual {v3}, Ljava/lang/Class;->getCanonicalName()Ljava/lang/String;

    move-result-object v3

    invoke-virtual {v2, v3}, Landroid/content/Intent;->getStringArrayListExtra(Ljava/lang/String;)Ljava/util/ArrayList;

    move-result-object v2

    iput-object v2, p0, Lcom/cyjh/elfin/activity/ImagePicZoomActivity;->imgUrlList:Ljava/util/List;

    .line 40
    iget-object v2, p0, Lcom/cyjh/elfin/activity/ImagePicZoomActivity;->imgUrlList:Ljava/util/List;

    invoke-interface {v2}, Ljava/util/List;->iterator()Ljava/util/Iterator;

    move-result-object v2

    :goto_0
    invoke-interface {v2}, Ljava/util/Iterator;->hasNext()Z

    move-result v3

    if-eqz v3, :cond_0

    invoke-interface {v2}, Ljava/util/Iterator;->next()Ljava/lang/Object;

    move-result-object v1

    check-cast v1, Ljava/lang/String;

    .line 41
    .local v1, "str":Ljava/lang/String;
    new-instance v0, Landroid/widget/ImageView;

    invoke-direct {v0, p0}, Landroid/widget/ImageView;-><init>(Landroid/content/Context;)V

    .line 42
    .local v0, "imageView":Landroid/widget/ImageView;
    sget-object v3, Landroid/widget/ImageView$ScaleType;->FIT_XY:Landroid/widget/ImageView$ScaleType;

    invoke-virtual {v0, v3}, Landroid/widget/ImageView;->setScaleType(Landroid/widget/ImageView$ScaleType;)V

    .line 43
    iget-object v3, p0, Lcom/cyjh/elfin/activity/ImagePicZoomActivity;->imageViewList:Ljava/util/List;

    invoke-interface {v3, v0}, Ljava/util/List;->add(Ljava/lang/Object;)Z

    goto :goto_0

    .line 45
    .end local v0    # "imageView":Landroid/widget/ImageView;
    .end local v1    # "str":Ljava/lang/String;
    :cond_0
    return-void
.end method

.method private initView()V
    .locals 1

    .prologue
    .line 62
    const v0, 0x7f0f0075

    invoke-virtual {p0, v0}, Lcom/cyjh/elfin/activity/ImagePicZoomActivity;->findViewById(I)Landroid/view/View;

    move-result-object v0

    check-cast v0, Landroid/support/v4/view/ViewPager;

    iput-object v0, p0, Lcom/cyjh/elfin/activity/ImagePicZoomActivity;->mViewPager:Landroid/support/v4/view/ViewPager;

    .line 63
    return-void
.end method


# virtual methods
.method protected onCreate(Landroid/os/Bundle;)V
    .locals 2
    .param p1, "savedInstanceState"    # Landroid/os/Bundle;

    .prologue
    .line 27
    invoke-super {p0, p1}, Lcom/cyjh/elfin/activity/BaseActivity;->onCreate(Landroid/os/Bundle;)V

    .line 28
    const v0, 0x7f04001f

    invoke-virtual {p0, v0}, Lcom/cyjh/elfin/activity/ImagePicZoomActivity;->setContentView(I)V

    .line 29
    invoke-direct {p0}, Lcom/cyjh/elfin/activity/ImagePicZoomActivity;->initView()V

    .line 30
    invoke-direct {p0}, Lcom/cyjh/elfin/activity/ImagePicZoomActivity;->initData()V

    .line 31
    new-instance v0, Lcom/cyjh/elfin/activity/ImagePicZoomActivity$ImageAdapter;

    invoke-direct {v0, p0}, Lcom/cyjh/elfin/activity/ImagePicZoomActivity$ImageAdapter;-><init>(Lcom/cyjh/elfin/activity/ImagePicZoomActivity;)V

    iput-object v0, p0, Lcom/cyjh/elfin/activity/ImagePicZoomActivity;->mImageAdapter:Lcom/cyjh/elfin/activity/ImagePicZoomActivity$ImageAdapter;

    .line 32
    iget-object v0, p0, Lcom/cyjh/elfin/activity/ImagePicZoomActivity;->mViewPager:Landroid/support/v4/view/ViewPager;

    iget-object v1, p0, Lcom/cyjh/elfin/activity/ImagePicZoomActivity;->mImageAdapter:Lcom/cyjh/elfin/activity/ImagePicZoomActivity$ImageAdapter;

    invoke-virtual {v0, v1}, Landroid/support/v4/view/ViewPager;->setAdapter(Landroid/support/v4/view/PagerAdapter;)V

    .line 33
    iget-object v0, p0, Lcom/cyjh/elfin/activity/ImagePicZoomActivity;->mViewPager:Landroid/support/v4/view/ViewPager;

    iget v1, p0, Lcom/cyjh/elfin/activity/ImagePicZoomActivity;->currentIndex:I

    add-int/lit8 v1, v1, -0x1

    invoke-virtual {v0, v1}, Landroid/support/v4/view/ViewPager;->setCurrentItem(I)V

    .line 34
    return-void
.end method

.method protected onPause()V
    .locals 1

    .prologue
    .line 56
    invoke-super {p0}, Lcom/cyjh/elfin/activity/BaseActivity;->onPause()V

    .line 57
    const-class v0, Lcom/cyjh/elfin/activity/ImagePicZoomActivity;

    invoke-virtual {v0}, Ljava/lang/Class;->getCanonicalName()Ljava/lang/String;

    move-result-object v0

    invoke-static {v0}, Lcom/umeng/analytics/MobclickAgent;->onPageEnd(Ljava/lang/String;)V

    .line 58
    invoke-static {p0}, Lcom/umeng/analytics/MobclickAgent;->onPause(Landroid/content/Context;)V

    .line 59
    return-void
.end method

.method protected onResume()V
    .locals 1

    .prologue
    .line 49
    invoke-super {p0}, Lcom/cyjh/elfin/activity/BaseActivity;->onResume()V

    .line 50
    const-class v0, Lcom/cyjh/elfin/activity/ImagePicZoomActivity;

    invoke-virtual {v0}, Ljava/lang/Class;->getCanonicalName()Ljava/lang/String;

    move-result-object v0

    invoke-static {v0}, Lcom/umeng/analytics/MobclickAgent;->onPageStart(Ljava/lang/String;)V

    .line 51
    invoke-static {p0}, Lcom/umeng/analytics/MobclickAgent;->onResume(Landroid/content/Context;)V

    .line 52
    return-void
.end method
