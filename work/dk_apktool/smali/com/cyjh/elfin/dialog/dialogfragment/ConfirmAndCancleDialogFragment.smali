.class public Lcom/cyjh/elfin/dialog/dialogfragment/ConfirmAndCancleDialogFragment;
.super Lcom/cyjh/elfin/dialog/dialogfragment/BasicDialogFragment;
.source "ConfirmAndCancleDialogFragment.java"

# interfaces
.implements Landroid/view/View$OnClickListener;


# instance fields
.field private contentTv:Landroid/widget/TextView;

.field private floatEditBean:Lcom/cyjh/elfin/entity/FloatEditBean;

.field private isCancle:Z

.field private leftTv:Landroid/widget/TextView;

.field private object:Ljava/lang/Object;

.field private rightBtnOpera:Lcom/cyjh/elfin/inf/RightBtnOpera;

.field private rightTv:Landroid/widget/TextView;

.field private titleTv:Landroid/widget/TextView;


# direct methods
.method public constructor <init>()V
    .locals 0

    .prologue
    .line 22
    invoke-direct {p0}, Lcom/cyjh/elfin/dialog/dialogfragment/BasicDialogFragment;-><init>()V

    return-void
.end method

.method public static getInstance(Lcom/cyjh/elfin/entity/FloatEditBean;)Lcom/cyjh/elfin/dialog/dialogfragment/ConfirmAndCancleDialogFragment;
    .locals 3
    .param p0, "floatEditBean"    # Lcom/cyjh/elfin/entity/FloatEditBean;

    .prologue
    .line 40
    new-instance v1, Lcom/cyjh/elfin/dialog/dialogfragment/ConfirmAndCancleDialogFragment;

    invoke-direct {v1}, Lcom/cyjh/elfin/dialog/dialogfragment/ConfirmAndCancleDialogFragment;-><init>()V

    .line 41
    .local v1, "confirmAndCancleDialogFragment":Lcom/cyjh/elfin/dialog/dialogfragment/ConfirmAndCancleDialogFragment;
    new-instance v0, Landroid/os/Bundle;

    invoke-direct {v0}, Landroid/os/Bundle;-><init>()V

    .line 42
    .local v0, "bundle":Landroid/os/Bundle;
    const-class v2, Lcom/cyjh/elfin/entity/FloatEditBean;

    invoke-virtual {v2}, Ljava/lang/Class;->getName()Ljava/lang/String;

    move-result-object v2

    invoke-virtual {v0, v2, p0}, Landroid/os/Bundle;->putParcelable(Ljava/lang/String;Landroid/os/Parcelable;)V

    .line 43
    invoke-virtual {v1, v0}, Lcom/cyjh/elfin/dialog/dialogfragment/ConfirmAndCancleDialogFragment;->setArguments(Landroid/os/Bundle;)V

    .line 44
    return-object v1
.end method


# virtual methods
.method public initDataAfterView()V
    .locals 2

    .prologue
    .line 72
    iget-object v0, p0, Lcom/cyjh/elfin/dialog/dialogfragment/ConfirmAndCancleDialogFragment;->titleTv:Landroid/widget/TextView;

    iget-object v1, p0, Lcom/cyjh/elfin/dialog/dialogfragment/ConfirmAndCancleDialogFragment;->floatEditBean:Lcom/cyjh/elfin/entity/FloatEditBean;

    iget-object v1, v1, Lcom/cyjh/elfin/entity/FloatEditBean;->intentTtile:Ljava/lang/String;

    invoke-virtual {v0, v1}, Landroid/widget/TextView;->setText(Ljava/lang/CharSequence;)V

    .line 73
    iget-object v0, p0, Lcom/cyjh/elfin/dialog/dialogfragment/ConfirmAndCancleDialogFragment;->contentTv:Landroid/widget/TextView;

    iget-object v1, p0, Lcom/cyjh/elfin/dialog/dialogfragment/ConfirmAndCancleDialogFragment;->floatEditBean:Lcom/cyjh/elfin/entity/FloatEditBean;

    iget-object v1, v1, Lcom/cyjh/elfin/entity/FloatEditBean;->intentContent:Ljava/lang/String;

    invoke-virtual {v0, v1}, Landroid/widget/TextView;->setText(Ljava/lang/CharSequence;)V

    .line 74
    iget-object v0, p0, Lcom/cyjh/elfin/dialog/dialogfragment/ConfirmAndCancleDialogFragment;->leftTv:Landroid/widget/TextView;

    iget-object v1, p0, Lcom/cyjh/elfin/dialog/dialogfragment/ConfirmAndCancleDialogFragment;->floatEditBean:Lcom/cyjh/elfin/entity/FloatEditBean;

    iget-object v1, v1, Lcom/cyjh/elfin/entity/FloatEditBean;->leftContent:Ljava/lang/String;

    invoke-virtual {v0, v1}, Landroid/widget/TextView;->setText(Ljava/lang/CharSequence;)V

    .line 75
    iget-object v0, p0, Lcom/cyjh/elfin/dialog/dialogfragment/ConfirmAndCancleDialogFragment;->rightTv:Landroid/widget/TextView;

    iget-object v1, p0, Lcom/cyjh/elfin/dialog/dialogfragment/ConfirmAndCancleDialogFragment;->floatEditBean:Lcom/cyjh/elfin/entity/FloatEditBean;

    iget-object v1, v1, Lcom/cyjh/elfin/entity/FloatEditBean;->rightContent:Ljava/lang/String;

    invoke-virtual {v0, v1}, Landroid/widget/TextView;->setText(Ljava/lang/CharSequence;)V

    .line 76
    return-void
.end method

.method public initDataBeforeView()V
    .locals 2

    .prologue
    .line 49
    invoke-virtual {p0}, Lcom/cyjh/elfin/dialog/dialogfragment/ConfirmAndCancleDialogFragment;->getArguments()Landroid/os/Bundle;

    move-result-object v0

    .line 50
    .local v0, "bundle":Landroid/os/Bundle;
    if-eqz v0, :cond_0

    .line 51
    const-class v1, Lcom/cyjh/elfin/entity/FloatEditBean;

    invoke-virtual {v1}, Ljava/lang/Class;->getName()Ljava/lang/String;

    move-result-object v1

    invoke-virtual {v0, v1}, Landroid/os/Bundle;->getParcelable(Ljava/lang/String;)Landroid/os/Parcelable;

    move-result-object v1

    check-cast v1, Lcom/cyjh/elfin/entity/FloatEditBean;

    iput-object v1, p0, Lcom/cyjh/elfin/dialog/dialogfragment/ConfirmAndCancleDialogFragment;->floatEditBean:Lcom/cyjh/elfin/entity/FloatEditBean;

    .line 52
    iget-object v1, p0, Lcom/cyjh/elfin/dialog/dialogfragment/ConfirmAndCancleDialogFragment;->floatEditBean:Lcom/cyjh/elfin/entity/FloatEditBean;

    iget-boolean v1, v1, Lcom/cyjh/elfin/entity/FloatEditBean;->isCancle:Z

    invoke-virtual {p0, v1}, Lcom/cyjh/elfin/dialog/dialogfragment/ConfirmAndCancleDialogFragment;->setClickDimiss(Z)V

    .line 54
    :cond_0
    return-void
.end method

.method public initListener()V
    .locals 1

    .prologue
    .line 67
    iget-object v0, p0, Lcom/cyjh/elfin/dialog/dialogfragment/ConfirmAndCancleDialogFragment;->leftTv:Landroid/widget/TextView;

    invoke-virtual {v0, p0}, Landroid/widget/TextView;->setOnClickListener(Landroid/view/View$OnClickListener;)V

    .line 68
    iget-object v0, p0, Lcom/cyjh/elfin/dialog/dialogfragment/ConfirmAndCancleDialogFragment;->rightTv:Landroid/widget/TextView;

    invoke-virtual {v0, p0}, Landroid/widget/TextView;->setOnClickListener(Landroid/view/View$OnClickListener;)V

    .line 69
    return-void
.end method

.method public initView(Landroid/view/LayoutInflater;Landroid/view/ViewGroup;Landroid/os/Bundle;)Landroid/view/View;
    .locals 3
    .param p1, "inflater"    # Landroid/view/LayoutInflater;
    .param p2, "container"    # Landroid/view/ViewGroup;
    .param p3, "savedInstanceState"    # Landroid/os/Bundle;

    .prologue
    .line 58
    const v1, 0x7f040032

    const/4 v2, 0x0

    invoke-virtual {p1, v1, p2, v2}, Landroid/view/LayoutInflater;->inflate(ILandroid/view/ViewGroup;Z)Landroid/view/View;

    move-result-object v0

    .line 59
    .local v0, "view":Landroid/view/View;
    const v1, 0x7f0f00a6

    invoke-virtual {v0, v1}, Landroid/view/View;->findViewById(I)Landroid/view/View;

    move-result-object v1

    check-cast v1, Landroid/widget/TextView;

    iput-object v1, p0, Lcom/cyjh/elfin/dialog/dialogfragment/ConfirmAndCancleDialogFragment;->titleTv:Landroid/widget/TextView;

    .line 60
    const v1, 0x7f0f00a7

    invoke-virtual {v0, v1}, Landroid/view/View;->findViewById(I)Landroid/view/View;

    move-result-object v1

    check-cast v1, Landroid/widget/TextView;

    iput-object v1, p0, Lcom/cyjh/elfin/dialog/dialogfragment/ConfirmAndCancleDialogFragment;->contentTv:Landroid/widget/TextView;

    .line 61
    const v1, 0x7f0f00a8

    invoke-virtual {v0, v1}, Landroid/view/View;->findViewById(I)Landroid/view/View;

    move-result-object v1

    check-cast v1, Landroid/widget/TextView;

    iput-object v1, p0, Lcom/cyjh/elfin/dialog/dialogfragment/ConfirmAndCancleDialogFragment;->leftTv:Landroid/widget/TextView;

    .line 62
    const v1, 0x7f0f00a9

    invoke-virtual {v0, v1}, Landroid/view/View;->findViewById(I)Landroid/view/View;

    move-result-object v1

    check-cast v1, Landroid/widget/TextView;

    iput-object v1, p0, Lcom/cyjh/elfin/dialog/dialogfragment/ConfirmAndCancleDialogFragment;->rightTv:Landroid/widget/TextView;

    .line 63
    return-object v0
.end method

.method public onClick(Landroid/view/View;)V
    .locals 3
    .param p1, "v"    # Landroid/view/View;

    .prologue
    const/4 v2, 0x0

    .line 91
    iget-object v0, p0, Lcom/cyjh/elfin/dialog/dialogfragment/ConfirmAndCancleDialogFragment;->leftTv:Landroid/widget/TextView;

    if-ne p1, v0, :cond_1

    .line 92
    iget-object v0, p0, Lcom/cyjh/elfin/dialog/dialogfragment/ConfirmAndCancleDialogFragment;->rightBtnOpera:Lcom/cyjh/elfin/inf/RightBtnOpera;

    sget-object v1, Lcom/cyjh/elfin/entity/ActionBarOperaEnum;->CANCLE:Lcom/cyjh/elfin/entity/ActionBarOperaEnum;

    invoke-interface {v0, v1, v2}, Lcom/cyjh/elfin/inf/RightBtnOpera;->rightBtnOpera(Lcom/cyjh/elfin/entity/ActionBarOperaEnum;Ljava/lang/Object;)V

    .line 93
    invoke-virtual {p0}, Lcom/cyjh/elfin/dialog/dialogfragment/ConfirmAndCancleDialogFragment;->dismissAllowingStateLoss()V

    .line 102
    :cond_0
    :goto_0
    return-void

    .line 94
    :cond_1
    iget-object v0, p0, Lcom/cyjh/elfin/dialog/dialogfragment/ConfirmAndCancleDialogFragment;->rightTv:Landroid/widget/TextView;

    if-ne p1, v0, :cond_0

    .line 95
    iget-object v0, p0, Lcom/cyjh/elfin/dialog/dialogfragment/ConfirmAndCancleDialogFragment;->object:Ljava/lang/Object;

    if-nez v0, :cond_2

    .line 96
    iget-object v0, p0, Lcom/cyjh/elfin/dialog/dialogfragment/ConfirmAndCancleDialogFragment;->rightBtnOpera:Lcom/cyjh/elfin/inf/RightBtnOpera;

    iget-object v1, p0, Lcom/cyjh/elfin/dialog/dialogfragment/ConfirmAndCancleDialogFragment;->floatEditBean:Lcom/cyjh/elfin/entity/FloatEditBean;

    iget-object v1, v1, Lcom/cyjh/elfin/entity/FloatEditBean;->type:Lcom/cyjh/elfin/entity/ActionBarOperaEnum;

    invoke-interface {v0, v1, v2}, Lcom/cyjh/elfin/inf/RightBtnOpera;->rightBtnOpera(Lcom/cyjh/elfin/entity/ActionBarOperaEnum;Ljava/lang/Object;)V

    .line 100
    :goto_1
    invoke-virtual {p0}, Lcom/cyjh/elfin/dialog/dialogfragment/ConfirmAndCancleDialogFragment;->dismissAllowingStateLoss()V

    goto :goto_0

    .line 98
    :cond_2
    iget-object v0, p0, Lcom/cyjh/elfin/dialog/dialogfragment/ConfirmAndCancleDialogFragment;->rightBtnOpera:Lcom/cyjh/elfin/inf/RightBtnOpera;

    iget-object v1, p0, Lcom/cyjh/elfin/dialog/dialogfragment/ConfirmAndCancleDialogFragment;->floatEditBean:Lcom/cyjh/elfin/entity/FloatEditBean;

    iget-object v1, v1, Lcom/cyjh/elfin/entity/FloatEditBean;->type:Lcom/cyjh/elfin/entity/ActionBarOperaEnum;

    iget-object v2, p0, Lcom/cyjh/elfin/dialog/dialogfragment/ConfirmAndCancleDialogFragment;->object:Ljava/lang/Object;

    invoke-interface {v0, v1, v2}, Lcom/cyjh/elfin/inf/RightBtnOpera;->rightBtnOpera(Lcom/cyjh/elfin/entity/ActionBarOperaEnum;Ljava/lang/Object;)V

    goto :goto_1
.end method

.method public renewLayout(Landroid/util/DisplayMetrics;)V
    .locals 3
    .param p1, "dm"    # Landroid/util/DisplayMetrics;

    .prologue
    .line 80
    invoke-virtual {p0}, Lcom/cyjh/elfin/dialog/dialogfragment/ConfirmAndCancleDialogFragment;->getDialog()Landroid/app/Dialog;

    move-result-object v1

    invoke-virtual {v1}, Landroid/app/Dialog;->getWindow()Landroid/view/Window;

    move-result-object v1

    invoke-virtual {v1}, Landroid/view/Window;->getAttributes()Landroid/view/WindowManager$LayoutParams;

    move-result-object v0

    .line 81
    .local v0, "layoutParams":Landroid/view/WindowManager$LayoutParams;
    iget v1, p1, Landroid/util/DisplayMetrics;->widthPixels:I

    iput v1, v0, Landroid/view/WindowManager$LayoutParams;->width:I

    .line 82
    const/4 v1, -0x2

    iput v1, v0, Landroid/view/WindowManager$LayoutParams;->height:I

    .line 83
    const/16 v1, 0x50

    iput v1, v0, Landroid/view/WindowManager$LayoutParams;->gravity:I

    .line 84
    invoke-virtual {p0}, Lcom/cyjh/elfin/dialog/dialogfragment/ConfirmAndCancleDialogFragment;->getDialog()Landroid/app/Dialog;

    move-result-object v1

    invoke-virtual {v1}, Landroid/app/Dialog;->getWindow()Landroid/view/Window;

    move-result-object v1

    invoke-virtual {v1, v0}, Landroid/view/Window;->setAttributes(Landroid/view/WindowManager$LayoutParams;)V

    .line 85
    invoke-virtual {p0}, Lcom/cyjh/elfin/dialog/dialogfragment/ConfirmAndCancleDialogFragment;->getDialog()Landroid/app/Dialog;

    move-result-object v1

    invoke-virtual {v1}, Landroid/app/Dialog;->getWindow()Landroid/view/Window;

    move-result-object v1

    const v2, 0x7f0a00ab

    invoke-virtual {v1, v2}, Landroid/view/Window;->setWindowAnimations(I)V

    .line 87
    return-void
.end method

.method public setObject(Ljava/lang/Object;)V
    .locals 0
    .param p1, "object"    # Ljava/lang/Object;

    .prologue
    .line 109
    iput-object p1, p0, Lcom/cyjh/elfin/dialog/dialogfragment/ConfirmAndCancleDialogFragment;->object:Ljava/lang/Object;

    .line 110
    return-void
.end method

.method public setRightBtnOpera(Lcom/cyjh/elfin/inf/RightBtnOpera;)V
    .locals 0
    .param p1, "rightBtnOpera"    # Lcom/cyjh/elfin/inf/RightBtnOpera;

    .prologue
    .line 105
    iput-object p1, p0, Lcom/cyjh/elfin/dialog/dialogfragment/ConfirmAndCancleDialogFragment;->rightBtnOpera:Lcom/cyjh/elfin/inf/RightBtnOpera;

    .line 106
    return-void
.end method
