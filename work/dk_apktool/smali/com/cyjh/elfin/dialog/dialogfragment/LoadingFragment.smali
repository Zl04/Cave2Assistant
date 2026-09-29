.class public Lcom/cyjh/elfin/dialog/dialogfragment/LoadingFragment;
.super Landroid/support/v4/app/DialogFragment;
.source "LoadingFragment.java"


# annotations
.annotation system Ldalvik/annotation/MemberClasses;
    value = {
        Lcom/cyjh/elfin/dialog/dialogfragment/LoadingFragment$LoadingCallback;
    }
.end annotation


# static fields
.field private static final EXTRA_CANCLE:Ljava/lang/String; = "com.xsq.nkysw.fragment.isClickCancle"


# instance fields
.field private isClickCancle:Z

.field private loadingCallback:Lcom/cyjh/elfin/dialog/dialogfragment/LoadingFragment$LoadingCallback;

.field private mAnimationDrawable:Landroid/graphics/drawable/AnimationDrawable;


# direct methods
.method public constructor <init>()V
    .locals 1

    .prologue
    .line 22
    invoke-direct {p0}, Landroid/support/v4/app/DialogFragment;-><init>()V

    .line 25
    const/4 v0, 0x0

    iput-boolean v0, p0, Lcom/cyjh/elfin/dialog/dialogfragment/LoadingFragment;->isClickCancle:Z

    return-void
.end method

.method public static newInstance(Z)Lcom/cyjh/elfin/dialog/dialogfragment/LoadingFragment;
    .locals 3
    .param p0, "isClickCancle"    # Z

    .prologue
    .line 31
    new-instance v1, Lcom/cyjh/elfin/dialog/dialogfragment/LoadingFragment;

    invoke-direct {v1}, Lcom/cyjh/elfin/dialog/dialogfragment/LoadingFragment;-><init>()V

    .line 32
    .local v1, "loadingFragment":Lcom/cyjh/elfin/dialog/dialogfragment/LoadingFragment;
    new-instance v0, Landroid/os/Bundle;

    invoke-direct {v0}, Landroid/os/Bundle;-><init>()V

    .line 33
    .local v0, "bundle":Landroid/os/Bundle;
    const-string v2, "com.xsq.nkysw.fragment.isClickCancle"

    invoke-virtual {v0, v2, p0}, Landroid/os/Bundle;->putBoolean(Ljava/lang/String;Z)V

    .line 34
    invoke-virtual {v1, v0}, Lcom/cyjh/elfin/dialog/dialogfragment/LoadingFragment;->setArguments(Landroid/os/Bundle;)V

    .line 35
    return-object v1
.end method


# virtual methods
.method public dismiss()V
    .locals 1

    .prologue
    .line 72
    iget-object v0, p0, Lcom/cyjh/elfin/dialog/dialogfragment/LoadingFragment;->mAnimationDrawable:Landroid/graphics/drawable/AnimationDrawable;

    invoke-virtual {v0}, Landroid/graphics/drawable/AnimationDrawable;->stop()V

    .line 73
    invoke-super {p0}, Landroid/support/v4/app/DialogFragment;->dismiss()V

    .line 74
    return-void
.end method

.method public onCancel(Landroid/content/DialogInterface;)V
    .locals 1
    .param p1, "dialog"    # Landroid/content/DialogInterface;

    .prologue
    .line 65
    invoke-super {p0, p1}, Landroid/support/v4/app/DialogFragment;->onCancel(Landroid/content/DialogInterface;)V

    .line 66
    iget-object v0, p0, Lcom/cyjh/elfin/dialog/dialogfragment/LoadingFragment;->loadingCallback:Lcom/cyjh/elfin/dialog/dialogfragment/LoadingFragment$LoadingCallback;

    if-eqz v0, :cond_0

    .line 67
    iget-object v0, p0, Lcom/cyjh/elfin/dialog/dialogfragment/LoadingFragment;->loadingCallback:Lcom/cyjh/elfin/dialog/dialogfragment/LoadingFragment$LoadingCallback;

    invoke-interface {v0}, Lcom/cyjh/elfin/dialog/dialogfragment/LoadingFragment$LoadingCallback;->callback()V

    .line 69
    :cond_0
    return-void
.end method

.method public onCreateView(Landroid/view/LayoutInflater;Landroid/view/ViewGroup;Landroid/os/Bundle;)Landroid/view/View;
    .locals 5
    .param p1, "inflater"    # Landroid/view/LayoutInflater;
    .param p2, "container"    # Landroid/view/ViewGroup;
    .param p3, "savedInstanceState"    # Landroid/os/Bundle;

    .prologue
    const/4 v4, 0x0

    .line 42
    invoke-virtual {p0}, Lcom/cyjh/elfin/dialog/dialogfragment/LoadingFragment;->getDialog()Landroid/app/Dialog;

    move-result-object v2

    invoke-virtual {v2}, Landroid/app/Dialog;->getWindow()Landroid/view/Window;

    move-result-object v2

    new-instance v3, Landroid/graphics/drawable/ColorDrawable;

    invoke-direct {v3, v4}, Landroid/graphics/drawable/ColorDrawable;-><init>(I)V

    invoke-virtual {v2, v3}, Landroid/view/Window;->setBackgroundDrawable(Landroid/graphics/drawable/Drawable;)V

    .line 43
    invoke-virtual {p0}, Lcom/cyjh/elfin/dialog/dialogfragment/LoadingFragment;->getDialog()Landroid/app/Dialog;

    move-result-object v2

    const/4 v3, 0x1

    invoke-virtual {v2, v3}, Landroid/app/Dialog;->requestWindowFeature(I)Z

    .line 45
    invoke-virtual {p0}, Lcom/cyjh/elfin/dialog/dialogfragment/LoadingFragment;->getArguments()Landroid/os/Bundle;

    move-result-object v2

    if-eqz v2, :cond_0

    invoke-virtual {p0}, Lcom/cyjh/elfin/dialog/dialogfragment/LoadingFragment;->getArguments()Landroid/os/Bundle;

    move-result-object v2

    invoke-virtual {v2}, Landroid/os/Bundle;->isEmpty()Z

    move-result v2

    if-nez v2, :cond_0

    .line 46
    invoke-virtual {p0}, Lcom/cyjh/elfin/dialog/dialogfragment/LoadingFragment;->getArguments()Landroid/os/Bundle;

    move-result-object v2

    const-string v3, "com.xsq.nkysw.fragment.isClickCancle"

    invoke-virtual {v2, v3, v4}, Landroid/os/Bundle;->getBoolean(Ljava/lang/String;Z)Z

    move-result v2

    iput-boolean v2, p0, Lcom/cyjh/elfin/dialog/dialogfragment/LoadingFragment;->isClickCancle:Z

    .line 47
    iget-boolean v2, p0, Lcom/cyjh/elfin/dialog/dialogfragment/LoadingFragment;->isClickCancle:Z

    if-eqz v2, :cond_0

    .line 48
    invoke-virtual {p0, v4}, Lcom/cyjh/elfin/dialog/dialogfragment/LoadingFragment;->setCancelable(Z)V

    .line 51
    :cond_0
    const v2, 0x7f04003f

    invoke-virtual {p1, v2, p2}, Landroid/view/LayoutInflater;->inflate(ILandroid/view/ViewGroup;)Landroid/view/View;

    move-result-object v1

    .line 52
    .local v1, "view":Landroid/view/View;
    const v2, 0x7f0f00cd

    invoke-virtual {v1, v2}, Landroid/view/View;->findViewById(I)Landroid/view/View;

    move-result-object v0

    check-cast v0, Landroid/widget/ImageView;

    .line 53
    .local v0, "mWaitView":Landroid/widget/ImageView;
    invoke-virtual {v0}, Landroid/widget/ImageView;->getBackground()Landroid/graphics/drawable/Drawable;

    move-result-object v2

    check-cast v2, Landroid/graphics/drawable/AnimationDrawable;

    iput-object v2, p0, Lcom/cyjh/elfin/dialog/dialogfragment/LoadingFragment;->mAnimationDrawable:Landroid/graphics/drawable/AnimationDrawable;

    .line 54
    iget-object v2, p0, Lcom/cyjh/elfin/dialog/dialogfragment/LoadingFragment;->mAnimationDrawable:Landroid/graphics/drawable/AnimationDrawable;

    invoke-virtual {v2, v4}, Landroid/graphics/drawable/AnimationDrawable;->setOneShot(Z)V

    .line 55
    iget-object v2, p0, Lcom/cyjh/elfin/dialog/dialogfragment/LoadingFragment;->mAnimationDrawable:Landroid/graphics/drawable/AnimationDrawable;

    invoke-virtual {v2}, Landroid/graphics/drawable/AnimationDrawable;->start()V

    .line 57
    return-object v1
.end method

.method public setLoadingCallback(Lcom/cyjh/elfin/dialog/dialogfragment/LoadingFragment$LoadingCallback;)V
    .locals 0
    .param p1, "loadingCallback"    # Lcom/cyjh/elfin/dialog/dialogfragment/LoadingFragment$LoadingCallback;

    .prologue
    .line 60
    iput-object p1, p0, Lcom/cyjh/elfin/dialog/dialogfragment/LoadingFragment;->loadingCallback:Lcom/cyjh/elfin/dialog/dialogfragment/LoadingFragment$LoadingCallback;

    .line 61
    return-void
.end method
