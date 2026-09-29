.class public Lcom/cyjh/elfin/dialog/BaseDialog;
.super Landroid/app/Dialog;
.source "BaseDialog.java"

# interfaces
.implements Lcom/cyjh/elfin/constant/APPConstant;


# instance fields
.field protected commonLog:Lcom/cyjh/elfin/log/CommonLog;

.field private heightPercentage:F

.field protected mAppContext:Lcom/cyjh/elfin/AppContext;

.field private widthPercentage:F


# direct methods
.method public constructor <init>(Landroid/content/Context;I)V
    .locals 2
    .param p1, "context"    # Landroid/content/Context;
    .param p2, "theme"    # I

    .prologue
    const v1, 0x3f4ccccd    # 0.8f

    .line 23
    invoke-direct {p0, p1, p2}, Landroid/app/Dialog;-><init>(Landroid/content/Context;I)V

    .line 17
    new-instance v0, Lcom/cyjh/elfin/log/CommonLog;

    invoke-direct {v0}, Lcom/cyjh/elfin/log/CommonLog;-><init>()V

    iput-object v0, p0, Lcom/cyjh/elfin/dialog/BaseDialog;->commonLog:Lcom/cyjh/elfin/log/CommonLog;

    .line 20
    iput v1, p0, Lcom/cyjh/elfin/dialog/BaseDialog;->widthPercentage:F

    .line 21
    iput v1, p0, Lcom/cyjh/elfin/dialog/BaseDialog;->heightPercentage:F

    .line 24
    invoke-virtual {p1}, Landroid/content/Context;->getApplicationContext()Landroid/content/Context;

    move-result-object v0

    check-cast v0, Lcom/cyjh/elfin/AppContext;

    iput-object v0, p0, Lcom/cyjh/elfin/dialog/BaseDialog;->mAppContext:Lcom/cyjh/elfin/AppContext;

    .line 25
    return-void
.end method


# virtual methods
.method protected onCreate(Landroid/os/Bundle;)V
    .locals 0
    .param p1, "savedInstanceState"    # Landroid/os/Bundle;

    .prologue
    .line 29
    invoke-super {p0, p1}, Landroid/app/Dialog;->onCreate(Landroid/os/Bundle;)V

    .line 30
    invoke-virtual {p0}, Lcom/cyjh/elfin/dialog/BaseDialog;->setBlurEffect()V

    .line 31
    return-void
.end method

.method protected setBlurEffect()V
    .locals 1

    .prologue
    .line 45
    const/high16 v0, 0x3f000000    # 0.5f

    invoke-virtual {p0, v0}, Lcom/cyjh/elfin/dialog/BaseDialog;->setBlurEffect(F)V

    .line 46
    return-void
.end method

.method protected setBlurEffect(F)V
    .locals 3
    .param p1, "dimAmount"    # F

    .prologue
    .line 37
    invoke-virtual {p0}, Lcom/cyjh/elfin/dialog/BaseDialog;->getWindow()Landroid/view/Window;

    move-result-object v1

    .line 38
    .local v1, "window":Landroid/view/Window;
    invoke-virtual {v1}, Landroid/view/Window;->getAttributes()Landroid/view/WindowManager$LayoutParams;

    move-result-object v0

    .line 39
    .local v0, "lp":Landroid/view/WindowManager$LayoutParams;
    iput p1, v0, Landroid/view/WindowManager$LayoutParams;->dimAmount:F

    .line 40
    invoke-virtual {v1, v0}, Landroid/view/Window;->setAttributes(Landroid/view/WindowManager$LayoutParams;)V

    .line 41
    const/4 v2, 0x2

    invoke-virtual {v1, v2}, Landroid/view/Window;->addFlags(I)V

    .line 42
    return-void
.end method

.method protected setDialogSize()V
    .locals 4

    .prologue
    .line 49
    invoke-virtual {p0}, Lcom/cyjh/elfin/dialog/BaseDialog;->getContext()Landroid/content/Context;

    move-result-object v2

    invoke-static {v2}, Lcom/cyjh/elfin/util/AppDeviceUtils;->getResolution(Landroid/content/Context;)Landroid/graphics/Point;

    move-result-object v1

    .line 50
    .local v1, "resolution":Landroid/graphics/Point;
    invoke-virtual {p0}, Lcom/cyjh/elfin/dialog/BaseDialog;->getWindow()Landroid/view/Window;

    move-result-object v2

    invoke-virtual {v2}, Landroid/view/Window;->getAttributes()Landroid/view/WindowManager$LayoutParams;

    move-result-object v0

    .line 51
    .local v0, "p":Landroid/view/WindowManager$LayoutParams;
    iget v2, v1, Landroid/graphics/Point;->x:I

    int-to-float v2, v2

    iget v3, p0, Lcom/cyjh/elfin/dialog/BaseDialog;->widthPercentage:F

    mul-float/2addr v2, v3

    float-to-int v2, v2

    iput v2, v0, Landroid/view/WindowManager$LayoutParams;->width:I

    .line 52
    iget v2, v1, Landroid/graphics/Point;->y:I

    int-to-float v2, v2

    iget v3, p0, Lcom/cyjh/elfin/dialog/BaseDialog;->heightPercentage:F

    mul-float/2addr v2, v3

    float-to-int v2, v2

    iput v2, v0, Landroid/view/WindowManager$LayoutParams;->height:I

    .line 53
    invoke-virtual {p0}, Lcom/cyjh/elfin/dialog/BaseDialog;->getWindow()Landroid/view/Window;

    move-result-object v2

    invoke-virtual {v2, v0}, Landroid/view/Window;->setAttributes(Landroid/view/WindowManager$LayoutParams;)V

    .line 54
    return-void
.end method

.method protected setDialogSize(FF)V
    .locals 0
    .param p1, "widthPercentage"    # F
    .param p2, "heightPercentage"    # F

    .prologue
    .line 57
    iput p1, p0, Lcom/cyjh/elfin/dialog/BaseDialog;->widthPercentage:F

    .line 58
    iput p2, p0, Lcom/cyjh/elfin/dialog/BaseDialog;->heightPercentage:F

    .line 59
    invoke-virtual {p0}, Lcom/cyjh/elfin/dialog/BaseDialog;->setDialogSize()V

    .line 60
    return-void
.end method
