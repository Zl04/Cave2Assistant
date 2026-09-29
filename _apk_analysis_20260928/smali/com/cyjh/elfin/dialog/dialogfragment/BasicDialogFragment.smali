.class public abstract Lcom/cyjh/elfin/dialog/dialogfragment/BasicDialogFragment;
.super Landroid/support/v4/app/DialogFragment;
.source "BasicDialogFragment.java"


# instance fields
.field public isClickDimiss:Z

.field private loadingFragment:Lcom/cyjh/elfin/dialog/dialogfragment/LoadingFragment;


# direct methods
.method public constructor <init>()V
    .locals 1

    .prologue
    .line 16
    invoke-direct {p0}, Landroid/support/v4/app/DialogFragment;-><init>()V

    .line 18
    const/4 v0, 0x1

    iput-boolean v0, p0, Lcom/cyjh/elfin/dialog/dialogfragment/BasicDialogFragment;->isClickDimiss:Z

    return-void
.end method


# virtual methods
.method public dismisProgressDialog()V
    .locals 1

    .prologue
    .line 64
    iget-object v0, p0, Lcom/cyjh/elfin/dialog/dialogfragment/BasicDialogFragment;->loadingFragment:Lcom/cyjh/elfin/dialog/dialogfragment/LoadingFragment;

    if-eqz v0, :cond_0

    .line 65
    iget-object v0, p0, Lcom/cyjh/elfin/dialog/dialogfragment/BasicDialogFragment;->loadingFragment:Lcom/cyjh/elfin/dialog/dialogfragment/LoadingFragment;

    invoke-virtual {v0}, Lcom/cyjh/elfin/dialog/dialogfragment/LoadingFragment;->dismiss()V

    .line 67
    :cond_0
    return-void
.end method

.method public abstract initDataAfterView()V
.end method

.method public abstract initDataBeforeView()V
.end method

.method public abstract initListener()V
.end method

.method public abstract initView(Landroid/view/LayoutInflater;Landroid/view/ViewGroup;Landroid/os/Bundle;)Landroid/view/View;
.end method

.method public onCreate(Landroid/os/Bundle;)V
    .locals 0
    .param p1, "savedInstanceState"    # Landroid/os/Bundle;

    .prologue
    .line 22
    invoke-super {p0, p1}, Landroid/support/v4/app/DialogFragment;->onCreate(Landroid/os/Bundle;)V

    .line 23
    invoke-virtual {p0}, Lcom/cyjh/elfin/dialog/dialogfragment/BasicDialogFragment;->initDataBeforeView()V

    .line 24
    return-void
.end method

.method public onCreateView(Landroid/view/LayoutInflater;Landroid/view/ViewGroup;Landroid/os/Bundle;)Landroid/view/View;
    .locals 3
    .param p1, "inflater"    # Landroid/view/LayoutInflater;
    .param p2, "container"    # Landroid/view/ViewGroup;
    .param p3, "savedInstanceState"    # Landroid/os/Bundle;

    .prologue
    .line 28
    invoke-virtual {p0}, Lcom/cyjh/elfin/dialog/dialogfragment/BasicDialogFragment;->getDialog()Landroid/app/Dialog;

    move-result-object v1

    const/4 v2, 0x1

    invoke-virtual {v1, v2}, Landroid/app/Dialog;->requestWindowFeature(I)Z

    .line 29
    iget-boolean v1, p0, Lcom/cyjh/elfin/dialog/dialogfragment/BasicDialogFragment;->isClickDimiss:Z

    invoke-virtual {p0, v1}, Lcom/cyjh/elfin/dialog/dialogfragment/BasicDialogFragment;->setCancelable(Z)V

    .line 30
    invoke-virtual {p0, p1, p2, p3}, Lcom/cyjh/elfin/dialog/dialogfragment/BasicDialogFragment;->initView(Landroid/view/LayoutInflater;Landroid/view/ViewGroup;Landroid/os/Bundle;)Landroid/view/View;

    move-result-object v0

    .line 31
    .local v0, "view":Landroid/view/View;
    invoke-virtual {p0}, Lcom/cyjh/elfin/dialog/dialogfragment/BasicDialogFragment;->initDataAfterView()V

    .line 32
    invoke-virtual {p0}, Lcom/cyjh/elfin/dialog/dialogfragment/BasicDialogFragment;->initListener()V

    .line 33
    return-object v0
.end method

.method public onStart()V
    .locals 4

    .prologue
    .line 48
    invoke-super {p0}, Landroid/support/v4/app/DialogFragment;->onStart()V

    .line 49
    new-instance v0, Landroid/util/DisplayMetrics;

    invoke-direct {v0}, Landroid/util/DisplayMetrics;-><init>()V

    .line 50
    .local v0, "dm":Landroid/util/DisplayMetrics;
    invoke-virtual {p0}, Lcom/cyjh/elfin/dialog/dialogfragment/BasicDialogFragment;->getActivity()Landroid/support/v4/app/FragmentActivity;

    move-result-object v1

    invoke-virtual {v1}, Landroid/support/v4/app/FragmentActivity;->getWindowManager()Landroid/view/WindowManager;

    move-result-object v1

    invoke-interface {v1}, Landroid/view/WindowManager;->getDefaultDisplay()Landroid/view/Display;

    move-result-object v1

    invoke-virtual {v1, v0}, Landroid/view/Display;->getMetrics(Landroid/util/DisplayMetrics;)V

    .line 51
    invoke-virtual {p0}, Lcom/cyjh/elfin/dialog/dialogfragment/BasicDialogFragment;->getDialog()Landroid/app/Dialog;

    move-result-object v1

    invoke-virtual {v1}, Landroid/app/Dialog;->getWindow()Landroid/view/Window;

    move-result-object v1

    iget v2, v0, Landroid/util/DisplayMetrics;->widthPixels:I

    invoke-virtual {p0}, Lcom/cyjh/elfin/dialog/dialogfragment/BasicDialogFragment;->getDialog()Landroid/app/Dialog;

    move-result-object v3

    invoke-virtual {v3}, Landroid/app/Dialog;->getWindow()Landroid/view/Window;

    move-result-object v3

    invoke-virtual {v3}, Landroid/view/Window;->getAttributes()Landroid/view/WindowManager$LayoutParams;

    move-result-object v3

    iget v3, v3, Landroid/view/WindowManager$LayoutParams;->height:I

    invoke-virtual {v1, v2, v3}, Landroid/view/Window;->setLayout(II)V

    .line 52
    invoke-virtual {p0}, Lcom/cyjh/elfin/dialog/dialogfragment/BasicDialogFragment;->getDialog()Landroid/app/Dialog;

    move-result-object v1

    invoke-virtual {v1}, Landroid/app/Dialog;->getWindow()Landroid/view/Window;

    move-result-object v1

    new-instance v2, Landroid/graphics/drawable/ColorDrawable;

    const/high16 v3, -0x1000000

    invoke-direct {v2, v3}, Landroid/graphics/drawable/ColorDrawable;-><init>(I)V

    invoke-virtual {v1, v2}, Landroid/view/Window;->setBackgroundDrawable(Landroid/graphics/drawable/Drawable;)V

    .line 53
    invoke-virtual {p0, v0}, Lcom/cyjh/elfin/dialog/dialogfragment/BasicDialogFragment;->renewLayout(Landroid/util/DisplayMetrics;)V

    .line 54
    return-void
.end method

.method public abstract renewLayout(Landroid/util/DisplayMetrics;)V
.end method

.method public setClickDimiss(Z)V
    .locals 0
    .param p1, "isClickDimiss"    # Z

    .prologue
    .line 43
    iput-boolean p1, p0, Lcom/cyjh/elfin/dialog/dialogfragment/BasicDialogFragment;->isClickDimiss:Z

    .line 44
    return-void
.end method

.method public showProgressDialog(Z)V
    .locals 3
    .param p1, "flag"    # Z

    .prologue
    .line 56
    iget-object v0, p0, Lcom/cyjh/elfin/dialog/dialogfragment/BasicDialogFragment;->loadingFragment:Lcom/cyjh/elfin/dialog/dialogfragment/LoadingFragment;

    if-nez v0, :cond_0

    .line 57
    invoke-static {p1}, Lcom/cyjh/elfin/dialog/dialogfragment/LoadingFragment;->newInstance(Z)Lcom/cyjh/elfin/dialog/dialogfragment/LoadingFragment;

    move-result-object v0

    iput-object v0, p0, Lcom/cyjh/elfin/dialog/dialogfragment/BasicDialogFragment;->loadingFragment:Lcom/cyjh/elfin/dialog/dialogfragment/LoadingFragment;

    .line 59
    :cond_0
    iget-object v0, p0, Lcom/cyjh/elfin/dialog/dialogfragment/BasicDialogFragment;->loadingFragment:Lcom/cyjh/elfin/dialog/dialogfragment/LoadingFragment;

    invoke-virtual {p0}, Lcom/cyjh/elfin/dialog/dialogfragment/BasicDialogFragment;->getActivity()Landroid/support/v4/app/FragmentActivity;

    move-result-object v1

    invoke-virtual {v1}, Landroid/support/v4/app/FragmentActivity;->getSupportFragmentManager()Landroid/support/v4/app/FragmentManager;

    move-result-object v1

    const-string v2, "LoadingFragment"

    invoke-virtual {v0, v1, v2}, Lcom/cyjh/elfin/dialog/dialogfragment/LoadingFragment;->show(Landroid/support/v4/app/FragmentManager;Ljava/lang/String;)V

    .line 61
    return-void
.end method
