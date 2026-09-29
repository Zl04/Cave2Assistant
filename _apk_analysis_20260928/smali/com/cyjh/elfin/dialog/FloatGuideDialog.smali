.class public Lcom/cyjh/elfin/dialog/FloatGuideDialog;
.super Lcom/cyjh/elfin/dialog/BaseDialog;
.source "FloatGuideDialog.java"

# interfaces
.implements Landroid/view/View$OnClickListener;


# annotations
.annotation system Ldalvik/annotation/MemberClasses;
    value = {
        Lcom/cyjh/elfin/dialog/FloatGuideDialog$OnConfirmResult;
    }
.end annotation


# instance fields
.field private mButtonOpen:Landroid/widget/Button;

.field private mConfirmResult:Lcom/cyjh/elfin/dialog/FloatGuideDialog$OnConfirmResult;


# direct methods
.method public constructor <init>(Landroid/content/Context;)V
    .locals 1
    .param p1, "context"    # Landroid/content/Context;

    .prologue
    .line 15
    const v0, 0x7f0a00f8

    invoke-direct {p0, p1, v0}, Lcom/cyjh/elfin/dialog/BaseDialog;-><init>(Landroid/content/Context;I)V

    .line 16
    return-void
.end method

.method private initView()V
    .locals 1

    .prologue
    .line 27
    const v0, 0x7f0f00bc

    invoke-virtual {p0, v0}, Lcom/cyjh/elfin/dialog/FloatGuideDialog;->findViewById(I)Landroid/view/View;

    move-result-object v0

    check-cast v0, Landroid/widget/Button;

    iput-object v0, p0, Lcom/cyjh/elfin/dialog/FloatGuideDialog;->mButtonOpen:Landroid/widget/Button;

    .line 28
    iget-object v0, p0, Lcom/cyjh/elfin/dialog/FloatGuideDialog;->mButtonOpen:Landroid/widget/Button;

    invoke-virtual {v0, p0}, Landroid/widget/Button;->setOnClickListener(Landroid/view/View$OnClickListener;)V

    .line 29
    return-void
.end method


# virtual methods
.method public onClick(Landroid/view/View;)V
    .locals 2
    .param p1, "v"    # Landroid/view/View;

    .prologue
    .line 33
    invoke-virtual {p1}, Landroid/view/View;->getId()I

    move-result v0

    packed-switch v0, :pswitch_data_0

    .line 43
    :cond_0
    :goto_0
    return-void

    .line 35
    :pswitch_0
    iget-object v0, p0, Lcom/cyjh/elfin/dialog/FloatGuideDialog;->mConfirmResult:Lcom/cyjh/elfin/dialog/FloatGuideDialog$OnConfirmResult;

    if-eqz v0, :cond_0

    .line 36
    iget-object v0, p0, Lcom/cyjh/elfin/dialog/FloatGuideDialog;->mConfirmResult:Lcom/cyjh/elfin/dialog/FloatGuideDialog$OnConfirmResult;

    const/4 v1, 0x1

    invoke-interface {v0, v1}, Lcom/cyjh/elfin/dialog/FloatGuideDialog$OnConfirmResult;->confirmResult(Z)V

    goto :goto_0

    .line 33
    nop

    :pswitch_data_0
    .packed-switch 0x7f0f00bc
        :pswitch_0
    .end packed-switch
.end method

.method protected onCreate(Landroid/os/Bundle;)V
    .locals 2
    .param p1, "savedInstanceState"    # Landroid/os/Bundle;

    .prologue
    .line 20
    invoke-super {p0, p1}, Lcom/cyjh/elfin/dialog/BaseDialog;->onCreate(Landroid/os/Bundle;)V

    .line 21
    const v0, 0x7f040038

    invoke-virtual {p0, v0}, Lcom/cyjh/elfin/dialog/FloatGuideDialog;->setContentView(I)V

    .line 22
    const v0, 0x3f4ccccd    # 0.8f

    const v1, 0x3ecccccd    # 0.4f

    invoke-virtual {p0, v0, v1}, Lcom/cyjh/elfin/dialog/FloatGuideDialog;->setDialogSize(FF)V

    .line 23
    invoke-direct {p0}, Lcom/cyjh/elfin/dialog/FloatGuideDialog;->initView()V

    .line 24
    return-void
.end method

.method public setConfirmResult(Lcom/cyjh/elfin/dialog/FloatGuideDialog$OnConfirmResult;)V
    .locals 0
    .param p1, "confirmResult"    # Lcom/cyjh/elfin/dialog/FloatGuideDialog$OnConfirmResult;

    .prologue
    .line 52
    iput-object p1, p0, Lcom/cyjh/elfin/dialog/FloatGuideDialog;->mConfirmResult:Lcom/cyjh/elfin/dialog/FloatGuideDialog$OnConfirmResult;

    .line 53
    return-void
.end method
