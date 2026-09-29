.class public abstract Lcom/cyjh/elfin/fragment/BaseFragement;
.super Landroid/support/v4/app/Fragment;
.source "BaseFragement.java"

# interfaces
.implements Lcom/cyjh/elfin/constant/APPConstant;
.implements Lcom/cyjh/elfin/mvp/views/BaseView;


# instance fields
.field protected appContext:Lcom/cyjh/elfin/AppContext;

.field protected commonLog:Lcom/cyjh/elfin/log/CommonLog;


# direct methods
.method public constructor <init>()V
    .locals 1

    .prologue
    .line 32
    invoke-direct {p0}, Landroid/support/v4/app/Fragment;-><init>()V

    .line 34
    new-instance v0, Lcom/cyjh/elfin/log/CommonLog;

    invoke-direct {v0}, Lcom/cyjh/elfin/log/CommonLog;-><init>()V

    iput-object v0, p0, Lcom/cyjh/elfin/fragment/BaseFragement;->commonLog:Lcom/cyjh/elfin/log/CommonLog;

    return-void
.end method


# virtual methods
.method public abstract getFragmentLayoutId()I
.end method

.method public hideProgress()V
    .locals 0

    .prologue
    .line 66
    return-void
.end method

.method public hideProgressDialog()V
    .locals 1

    .prologue
    .line 75
    invoke-static {}, Lcom/cyjh/elfin/dialog/DialogManager;->getInstance()Lcom/cyjh/elfin/dialog/DialogManager;

    move-result-object v0

    invoke-virtual {v0}, Lcom/cyjh/elfin/dialog/DialogManager;->hideProgressDialog()V

    .line 76
    return-void
.end method

.method public onActivityCreated(Landroid/os/Bundle;)V
    .locals 1
    .param p1, "savedInstanceState"    # Landroid/os/Bundle;

    .prologue
    .line 51
    invoke-super {p0, p1}, Landroid/support/v4/app/Fragment;->onActivityCreated(Landroid/os/Bundle;)V

    .line 52
    invoke-virtual {p0}, Lcom/cyjh/elfin/fragment/BaseFragement;->getActivity()Landroid/support/v4/app/FragmentActivity;

    move-result-object v0

    invoke-virtual {v0}, Landroid/support/v4/app/FragmentActivity;->getApplicationContext()Landroid/content/Context;

    move-result-object v0

    check-cast v0, Lcom/cyjh/elfin/AppContext;

    iput-object v0, p0, Lcom/cyjh/elfin/fragment/BaseFragement;->appContext:Lcom/cyjh/elfin/AppContext;

    .line 53
    return-void
.end method

.method public onCreateView(Landroid/view/LayoutInflater;Landroid/view/ViewGroup;Landroid/os/Bundle;)Landroid/view/View;
    .locals 2
    .param p1, "inflater"    # Landroid/view/LayoutInflater;
    .param p2, "container"    # Landroid/view/ViewGroup;
    .param p3, "savedInstanceState"    # Landroid/os/Bundle;

    .prologue
    .line 40
    invoke-virtual {p0}, Lcom/cyjh/elfin/fragment/BaseFragement;->getFragmentLayoutId()I

    move-result v0

    const/4 v1, 0x0

    invoke-virtual {p1, v0, p2, v1}, Landroid/view/LayoutInflater;->inflate(ILandroid/view/ViewGroup;Z)Landroid/view/View;

    move-result-object v0

    return-object v0
.end method

.method public onErrorMsg(Ljava/lang/String;Ljava/lang/String;)V
    .locals 0
    .param p1, "message"    # Ljava/lang/String;
    .param p2, "authority"    # Ljava/lang/String;

    .prologue
    .line 86
    return-void
.end method

.method public onSaveInstanceState(Landroid/os/Bundle;)V
    .locals 1
    .param p1, "outState"    # Landroid/os/Bundle;

    .prologue
    .line 45
    invoke-super {p0, p1}, Landroid/support/v4/app/Fragment;->onSaveInstanceState(Landroid/os/Bundle;)V

    .line 46
    const/4 v0, 0x1

    invoke-virtual {p0, v0}, Lcom/cyjh/elfin/fragment/BaseFragement;->setUserVisibleHint(Z)V

    .line 47
    return-void
.end method

.method public showProgress()V
    .locals 0

    .prologue
    .line 61
    return-void
.end method

.method public showProgressDialog(Landroid/content/Context;I)V
    .locals 1
    .param p1, "context"    # Landroid/content/Context;
    .param p2, "resId"    # I

    .prologue
    .line 70
    invoke-static {}, Lcom/cyjh/elfin/dialog/DialogManager;->getInstance()Lcom/cyjh/elfin/dialog/DialogManager;

    move-result-object v0

    invoke-virtual {v0, p1, p2}, Lcom/cyjh/elfin/dialog/DialogManager;->showProgressDialog(Landroid/content/Context;I)V

    .line 71
    return-void
.end method
