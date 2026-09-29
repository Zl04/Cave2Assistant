.class public Lcom/cyjh/elfin/dialog/NoRootDialog;
.super Lcom/cyjh/elfin/dialog/BaseDialog;
.source "NoRootDialog.java"


# instance fields
.field private mBtnSure:Landroid/widget/Button;


# direct methods
.method public constructor <init>(Landroid/content/Context;)V
    .locals 1
    .param p1, "context"    # Landroid/content/Context;

    .prologue
    .line 16
    const v0, 0x7f0a00f8

    invoke-direct {p0, p1, v0}, Lcom/cyjh/elfin/dialog/BaseDialog;-><init>(Landroid/content/Context;I)V

    .line 17
    return-void
.end method


# virtual methods
.method protected onCreate(Landroid/os/Bundle;)V
    .locals 2
    .param p1, "savedInstanceState"    # Landroid/os/Bundle;

    .prologue
    .line 21
    invoke-super {p0, p1}, Lcom/cyjh/elfin/dialog/BaseDialog;->onCreate(Landroid/os/Bundle;)V

    .line 22
    const v0, 0x7f04003a

    invoke-virtual {p0, v0}, Lcom/cyjh/elfin/dialog/NoRootDialog;->setContentView(I)V

    .line 23
    const v0, 0x3f4ccccd    # 0.8f

    const v1, 0x3ecccccd    # 0.4f

    invoke-virtual {p0, v0, v1}, Lcom/cyjh/elfin/dialog/NoRootDialog;->setDialogSize(FF)V

    .line 24
    const/high16 v0, 0x3f000000    # 0.5f

    invoke-virtual {p0, v0}, Lcom/cyjh/elfin/dialog/NoRootDialog;->setBlurEffect(F)V

    .line 25
    const/4 v0, 0x0

    invoke-virtual {p0, v0}, Lcom/cyjh/elfin/dialog/NoRootDialog;->setCanceledOnTouchOutside(Z)V

    .line 26
    const v0, 0x7f0f00c2

    invoke-virtual {p0, v0}, Lcom/cyjh/elfin/dialog/NoRootDialog;->findViewById(I)Landroid/view/View;

    move-result-object v0

    check-cast v0, Landroid/widget/Button;

    iput-object v0, p0, Lcom/cyjh/elfin/dialog/NoRootDialog;->mBtnSure:Landroid/widget/Button;

    .line 27
    iget-object v0, p0, Lcom/cyjh/elfin/dialog/NoRootDialog;->mBtnSure:Landroid/widget/Button;

    new-instance v1, Lcom/cyjh/elfin/dialog/NoRootDialog$1;

    invoke-direct {v1, p0}, Lcom/cyjh/elfin/dialog/NoRootDialog$1;-><init>(Lcom/cyjh/elfin/dialog/NoRootDialog;)V

    invoke-virtual {v0, v1}, Landroid/widget/Button;->setOnClickListener(Landroid/view/View$OnClickListener;)V

    .line 33
    return-void
.end method
