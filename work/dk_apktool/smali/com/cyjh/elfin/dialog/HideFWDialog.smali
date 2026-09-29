.class public Lcom/cyjh/elfin/dialog/HideFWDialog;
.super Lcom/cyjh/elfin/dialog/BaseDialog;
.source "HideFWDialog.java"

# interfaces
.implements Landroid/view/View$OnClickListener;


# annotations
.annotation system Ldalvik/annotation/MemberClasses;
    value = {
        Lcom/cyjh/elfin/dialog/HideFWDialog$OnHideCancelClickListener;,
        Lcom/cyjh/elfin/dialog/HideFWDialog$OnHideOKClickListener;
    }
.end annotation


# instance fields
.field private mButtonCancel:Landroid/widget/Button;

.field private mButtonOK:Landroid/widget/Button;

.field private mOnHideCancelClickListener:Lcom/cyjh/elfin/dialog/HideFWDialog$OnHideCancelClickListener;

.field private mOnHideOKClickListener:Lcom/cyjh/elfin/dialog/HideFWDialog$OnHideOKClickListener;


# direct methods
.method public constructor <init>(Landroid/content/Context;)V
    .locals 2
    .param p1, "context"    # Landroid/content/Context;

    .prologue
    .line 21
    const v0, 0x7f0a00f8

    invoke-direct {p0, p1, v0}, Lcom/cyjh/elfin/dialog/BaseDialog;-><init>(Landroid/content/Context;I)V

    .line 22
    sget v0, Landroid/os/Build$VERSION;->SDK_INT:I

    const/16 v1, 0x13

    if-lt v0, v1, :cond_0

    sget v0, Landroid/os/Build$VERSION;->SDK_INT:I

    const/16 v1, 0x18

    if-ge v0, v1, :cond_0

    .line 24
    invoke-virtual {p0}, Lcom/cyjh/elfin/dialog/HideFWDialog;->getWindow()Landroid/view/Window;

    move-result-object v0

    const/16 v1, 0x7d5

    invoke-virtual {v0, v1}, Landroid/view/Window;->setType(I)V

    .line 29
    :goto_0
    return-void

    .line 27
    :cond_0
    invoke-virtual {p0}, Lcom/cyjh/elfin/dialog/HideFWDialog;->getWindow()Landroid/view/Window;

    move-result-object v0

    const/16 v1, 0x7d2

    invoke-virtual {v0, v1}, Landroid/view/Window;->setType(I)V

    goto :goto_0
.end method

.method private initView()V
    .locals 1

    .prologue
    .line 41
    const v0, 0x7f0f00b8

    invoke-virtual {p0, v0}, Lcom/cyjh/elfin/dialog/HideFWDialog;->findViewById(I)Landroid/view/View;

    move-result-object v0

    check-cast v0, Landroid/widget/Button;

    iput-object v0, p0, Lcom/cyjh/elfin/dialog/HideFWDialog;->mButtonOK:Landroid/widget/Button;

    .line 42
    const v0, 0x7f0f00b7

    invoke-virtual {p0, v0}, Lcom/cyjh/elfin/dialog/HideFWDialog;->findViewById(I)Landroid/view/View;

    move-result-object v0

    check-cast v0, Landroid/widget/Button;

    iput-object v0, p0, Lcom/cyjh/elfin/dialog/HideFWDialog;->mButtonCancel:Landroid/widget/Button;

    .line 44
    iget-object v0, p0, Lcom/cyjh/elfin/dialog/HideFWDialog;->mButtonOK:Landroid/widget/Button;

    invoke-virtual {v0, p0}, Landroid/widget/Button;->setOnClickListener(Landroid/view/View$OnClickListener;)V

    .line 45
    iget-object v0, p0, Lcom/cyjh/elfin/dialog/HideFWDialog;->mButtonCancel:Landroid/widget/Button;

    invoke-virtual {v0, p0}, Landroid/widget/Button;->setOnClickListener(Landroid/view/View$OnClickListener;)V

    .line 46
    return-void
.end method


# virtual methods
.method public onClick(Landroid/view/View;)V
    .locals 1
    .param p1, "v"    # Landroid/view/View;

    .prologue
    .line 50
    invoke-virtual {p1}, Landroid/view/View;->getId()I

    move-result v0

    packed-switch v0, :pswitch_data_0

    .line 65
    :cond_0
    :goto_0
    invoke-virtual {p0}, Lcom/cyjh/elfin/dialog/HideFWDialog;->dismiss()V

    .line 66
    return-void

    .line 52
    :pswitch_0
    iget-object v0, p0, Lcom/cyjh/elfin/dialog/HideFWDialog;->mOnHideOKClickListener:Lcom/cyjh/elfin/dialog/HideFWDialog$OnHideOKClickListener;

    if-eqz v0, :cond_0

    .line 53
    iget-object v0, p0, Lcom/cyjh/elfin/dialog/HideFWDialog;->mOnHideOKClickListener:Lcom/cyjh/elfin/dialog/HideFWDialog$OnHideOKClickListener;

    invoke-interface {v0, p1}, Lcom/cyjh/elfin/dialog/HideFWDialog$OnHideOKClickListener;->onClick(Landroid/view/View;)V

    goto :goto_0

    .line 57
    :pswitch_1
    iget-object v0, p0, Lcom/cyjh/elfin/dialog/HideFWDialog;->mOnHideCancelClickListener:Lcom/cyjh/elfin/dialog/HideFWDialog$OnHideCancelClickListener;

    if-eqz v0, :cond_0

    .line 58
    iget-object v0, p0, Lcom/cyjh/elfin/dialog/HideFWDialog;->mOnHideCancelClickListener:Lcom/cyjh/elfin/dialog/HideFWDialog$OnHideCancelClickListener;

    invoke-interface {v0, p1}, Lcom/cyjh/elfin/dialog/HideFWDialog$OnHideCancelClickListener;->onClick(Landroid/view/View;)V

    goto :goto_0

    .line 50
    nop

    :pswitch_data_0
    .packed-switch 0x7f0f00b7
        :pswitch_1
        :pswitch_0
    .end packed-switch
.end method

.method protected onCreate(Landroid/os/Bundle;)V
    .locals 2
    .param p1, "savedInstanceState"    # Landroid/os/Bundle;

    .prologue
    .line 33
    invoke-super {p0, p1}, Lcom/cyjh/elfin/dialog/BaseDialog;->onCreate(Landroid/os/Bundle;)V

    .line 34
    const v0, 0x7f040035

    invoke-virtual {p0, v0}, Lcom/cyjh/elfin/dialog/HideFWDialog;->setContentView(I)V

    .line 35
    const v0, 0x3dcccccd    # 0.1f

    invoke-virtual {p0, v0}, Lcom/cyjh/elfin/dialog/HideFWDialog;->setBlurEffect(F)V

    .line 36
    const v0, 0x3f4ccccd    # 0.8f

    const v1, 0x3e99999a    # 0.3f

    invoke-virtual {p0, v0, v1}, Lcom/cyjh/elfin/dialog/HideFWDialog;->setDialogSize(FF)V

    .line 37
    invoke-direct {p0}, Lcom/cyjh/elfin/dialog/HideFWDialog;->initView()V

    .line 38
    return-void
.end method

.method public setOnHideCancelClickListener(Lcom/cyjh/elfin/dialog/HideFWDialog$OnHideCancelClickListener;)V
    .locals 0
    .param p1, "onHideCancelClickListener"    # Lcom/cyjh/elfin/dialog/HideFWDialog$OnHideCancelClickListener;

    .prologue
    .line 73
    iput-object p1, p0, Lcom/cyjh/elfin/dialog/HideFWDialog;->mOnHideCancelClickListener:Lcom/cyjh/elfin/dialog/HideFWDialog$OnHideCancelClickListener;

    .line 74
    return-void
.end method

.method public setOnHideOKClickListener(Lcom/cyjh/elfin/dialog/HideFWDialog$OnHideOKClickListener;)V
    .locals 0
    .param p1, "onHideOKClickListener"    # Lcom/cyjh/elfin/dialog/HideFWDialog$OnHideOKClickListener;

    .prologue
    .line 69
    iput-object p1, p0, Lcom/cyjh/elfin/dialog/HideFWDialog;->mOnHideOKClickListener:Lcom/cyjh/elfin/dialog/HideFWDialog$OnHideOKClickListener;

    .line 70
    return-void
.end method
