.class public Lcom/cyjh/feedback/lib/activity/ImageSelectActivity;
.super Landroid/support/v4/app/FragmentActivity;
.source "ImageSelectActivity.java"

# interfaces
.implements Landroid/view/View$OnClickListener;


# instance fields
.field private mImgLeftBack:Landroid/widget/ImageView;

.field private mTvTitle:Landroid/widget/TextView;


# direct methods
.method public constructor <init>()V
    .locals 0

    .prologue
    .line 19
    invoke-direct {p0}, Landroid/support/v4/app/FragmentActivity;-><init>()V

    return-void
.end method

.method private initView()V
    .locals 1

    .prologue
    .line 36
    sget v0, Lcom/cyjh/feedback/libraryfeedbackinfo/R$id;->id_img_left_back_arrow:I

    invoke-virtual {p0, v0}, Lcom/cyjh/feedback/lib/activity/ImageSelectActivity;->findViewById(I)Landroid/view/View;

    move-result-object v0

    check-cast v0, Landroid/widget/ImageView;

    iput-object v0, p0, Lcom/cyjh/feedback/lib/activity/ImageSelectActivity;->mImgLeftBack:Landroid/widget/ImageView;

    .line 37
    sget v0, Lcom/cyjh/feedback/libraryfeedbackinfo/R$id;->id_tv_title:I

    invoke-virtual {p0, v0}, Lcom/cyjh/feedback/lib/activity/ImageSelectActivity;->findViewById(I)Landroid/view/View;

    move-result-object v0

    check-cast v0, Landroid/widget/TextView;

    iput-object v0, p0, Lcom/cyjh/feedback/lib/activity/ImageSelectActivity;->mTvTitle:Landroid/widget/TextView;

    .line 39
    return-void
.end method


# virtual methods
.method public onClick(Landroid/view/View;)V
    .locals 2
    .param p1, "v"    # Landroid/view/View;

    .prologue
    .line 43
    invoke-virtual {p1}, Landroid/view/View;->getId()I

    move-result v0

    .line 44
    .local v0, "id":I
    sget v1, Lcom/cyjh/feedback/libraryfeedbackinfo/R$id;->id_img_left_back_arrow:I

    if-ne v0, v1, :cond_0

    .line 45
    invoke-virtual {p0}, Lcom/cyjh/feedback/lib/activity/ImageSelectActivity;->onBackPressed()V

    .line 47
    :cond_0
    return-void
.end method

.method protected onCreate(Landroid/os/Bundle;)V
    .locals 2
    .param p1, "savedInstanceState"    # Landroid/os/Bundle;

    .prologue
    .line 25
    invoke-super {p0, p1}, Landroid/support/v4/app/FragmentActivity;->onCreate(Landroid/os/Bundle;)V

    .line 26
    const/4 v0, 0x1

    invoke-virtual {p0, v0}, Lcom/cyjh/feedback/lib/activity/ImageSelectActivity;->requestWindowFeature(I)Z

    .line 27
    sget v0, Lcom/cyjh/feedback/libraryfeedbackinfo/R$layout;->activity_img_select:I

    invoke-virtual {p0, v0}, Lcom/cyjh/feedback/lib/activity/ImageSelectActivity;->setContentView(I)V

    .line 28
    invoke-direct {p0}, Lcom/cyjh/feedback/lib/activity/ImageSelectActivity;->initView()V

    .line 29
    iget-object v0, p0, Lcom/cyjh/feedback/lib/activity/ImageSelectActivity;->mTvTitle:Landroid/widget/TextView;

    sget v1, Lcom/cyjh/feedback/libraryfeedbackinfo/R$string;->img_select_title:I

    invoke-virtual {p0, v1}, Lcom/cyjh/feedback/lib/activity/ImageSelectActivity;->getString(I)Ljava/lang/String;

    move-result-object v1

    invoke-virtual {v0, v1}, Landroid/widget/TextView;->setText(Ljava/lang/CharSequence;)V

    .line 30
    iget-object v0, p0, Lcom/cyjh/feedback/lib/activity/ImageSelectActivity;->mTvTitle:Landroid/widget/TextView;

    const/4 v1, 0x0

    invoke-virtual {v0, v1}, Landroid/widget/TextView;->setVisibility(I)V

    .line 31
    iget-object v0, p0, Lcom/cyjh/feedback/lib/activity/ImageSelectActivity;->mImgLeftBack:Landroid/widget/ImageView;

    invoke-virtual {v0, p0}, Landroid/widget/ImageView;->setOnClickListener(Landroid/view/View$OnClickListener;)V

    .line 32
    invoke-static {}, Lcom/cyjh/feedback/lib/fragment/ImageSelectFragment;->newInstance()Lcom/cyjh/feedback/lib/fragment/ImageSelectFragment;

    move-result-object v0

    const-string v1, "ImageSelectFragment"

    invoke-virtual {p0, v0, v1}, Lcom/cyjh/feedback/lib/activity/ImageSelectActivity;->replaceFragment(Landroid/support/v4/app/Fragment;Ljava/lang/String;)V

    .line 33
    return-void
.end method

.method protected onPause()V
    .locals 0

    .prologue
    .line 67
    invoke-super {p0}, Landroid/support/v4/app/FragmentActivity;->onPause()V

    .line 68
    invoke-static {p0}, Lcom/umeng/analytics/MobclickAgent;->onPause(Landroid/content/Context;)V

    .line 69
    return-void
.end method

.method protected onResume()V
    .locals 0

    .prologue
    .line 61
    invoke-super {p0}, Landroid/support/v4/app/FragmentActivity;->onResume()V

    .line 62
    invoke-static {p0}, Lcom/umeng/analytics/MobclickAgent;->onResume(Landroid/content/Context;)V

    .line 63
    return-void
.end method

.method public replaceFragment(Landroid/support/v4/app/Fragment;Ljava/lang/String;)V
    .locals 2
    .param p1, "fragment"    # Landroid/support/v4/app/Fragment;
    .param p2, "tag"    # Ljava/lang/String;

    .prologue
    .line 50
    invoke-virtual {p0}, Lcom/cyjh/feedback/lib/activity/ImageSelectActivity;->getSupportFragmentManager()Landroid/support/v4/app/FragmentManager;

    move-result-object v1

    invoke-virtual {v1}, Landroid/support/v4/app/FragmentManager;->beginTransaction()Landroid/support/v4/app/FragmentTransaction;

    move-result-object v0

    .line 51
    .local v0, "transaction":Landroid/support/v4/app/FragmentTransaction;
    if-nez p2, :cond_0

    .line 52
    sget v1, Lcom/cyjh/feedback/libraryfeedbackinfo/R$id;->id_fl_replace_fragment:I

    invoke-virtual {v0, v1, p1}, Landroid/support/v4/app/FragmentTransaction;->replace(ILandroid/support/v4/app/Fragment;)Landroid/support/v4/app/FragmentTransaction;

    .line 56
    :goto_0
    invoke-virtual {v0}, Landroid/support/v4/app/FragmentTransaction;->commit()I

    .line 57
    return-void

    .line 54
    :cond_0
    sget v1, Lcom/cyjh/feedback/libraryfeedbackinfo/R$id;->id_fl_replace_fragment:I

    invoke-virtual {v0, v1, p1, p2}, Landroid/support/v4/app/FragmentTransaction;->replace(ILandroid/support/v4/app/Fragment;Ljava/lang/String;)Landroid/support/v4/app/FragmentTransaction;

    goto :goto_0
.end method
