.class public Lcom/cyjh/feedback/lib/base/BaseDialog;
.super Landroid/app/Dialog;
.source "BaseDialog.java"


# static fields
.field public static final TAG:Ljava/lang/String; = "BaseDialog"

.field private static mRequestQueue:Lcom/android/volley/RequestQueue;


# instance fields
.field public mContext:Landroid/content/Context;

.field private mDialogHeight:F

.field private mDialogWidth:F


# direct methods
.method public constructor <init>(Landroid/content/Context;I)V
    .locals 1
    .param p1, "context"    # Landroid/content/Context;
    .param p2, "theme"    # I

    .prologue
    const v0, 0x3f4ccccd    # 0.8f

    .line 25
    invoke-direct {p0, p1, p2}, Landroid/app/Dialog;-><init>(Landroid/content/Context;I)V

    .line 20
    iput v0, p0, Lcom/cyjh/feedback/lib/base/BaseDialog;->mDialogWidth:F

    .line 21
    iput v0, p0, Lcom/cyjh/feedback/lib/base/BaseDialog;->mDialogHeight:F

    .line 26
    iput-object p1, p0, Lcom/cyjh/feedback/lib/base/BaseDialog;->mContext:Landroid/content/Context;

    .line 27
    iget-object v0, p0, Lcom/cyjh/feedback/lib/base/BaseDialog;->mContext:Landroid/content/Context;

    invoke-static {v0}, Lcom/android/volley/toolbox/Volley;->newRequestQueue(Landroid/content/Context;)Lcom/android/volley/RequestQueue;

    move-result-object v0

    sput-object v0, Lcom/cyjh/feedback/lib/base/BaseDialog;->mRequestQueue:Lcom/android/volley/RequestQueue;

    .line 28
    return-void
.end method

.method public static getmRequestQueue()Lcom/android/volley/RequestQueue;
    .locals 1

    .prologue
    .line 65
    sget-object v0, Lcom/cyjh/feedback/lib/base/BaseDialog;->mRequestQueue:Lcom/android/volley/RequestQueue;

    return-object v0
.end method

.method private setDialogSize()V
    .locals 4

    .prologue
    .line 51
    iget-object v2, p0, Lcom/cyjh/feedback/lib/base/BaseDialog;->mContext:Landroid/content/Context;

    invoke-static {v2}, Lcom/cyjh/feedback/lib/utils/AppDevicesUtils;->getResolution(Landroid/content/Context;)Landroid/graphics/Point;

    move-result-object v1

    .line 52
    .local v1, "point":Landroid/graphics/Point;
    invoke-virtual {p0}, Lcom/cyjh/feedback/lib/base/BaseDialog;->getWindow()Landroid/view/Window;

    move-result-object v2

    invoke-virtual {v2}, Landroid/view/Window;->getAttributes()Landroid/view/WindowManager$LayoutParams;

    move-result-object v0

    .line 53
    .local v0, "params":Landroid/view/WindowManager$LayoutParams;
    iget v2, v1, Landroid/graphics/Point;->x:I

    int-to-float v2, v2

    iget v3, p0, Lcom/cyjh/feedback/lib/base/BaseDialog;->mDialogWidth:F

    mul-float/2addr v2, v3

    float-to-int v2, v2

    iput v2, v0, Landroid/view/WindowManager$LayoutParams;->width:I

    .line 54
    iget v2, v1, Landroid/graphics/Point;->y:I

    int-to-float v2, v2

    iget v3, p0, Lcom/cyjh/feedback/lib/base/BaseDialog;->mDialogHeight:F

    mul-float/2addr v2, v3

    float-to-int v2, v2

    iput v2, v0, Landroid/view/WindowManager$LayoutParams;->height:I

    .line 55
    invoke-virtual {p0}, Lcom/cyjh/feedback/lib/base/BaseDialog;->getWindow()Landroid/view/Window;

    move-result-object v2

    invoke-virtual {v2, v0}, Landroid/view/Window;->setAttributes(Landroid/view/WindowManager$LayoutParams;)V

    .line 56
    return-void
.end method


# virtual methods
.method protected onCreate(Landroid/os/Bundle;)V
    .locals 0
    .param p1, "savedInstanceState"    # Landroid/os/Bundle;

    .prologue
    .line 32
    invoke-super {p0, p1}, Landroid/app/Dialog;->onCreate(Landroid/os/Bundle;)V

    .line 33
    return-void
.end method

.method public setBlurEffect(F)V
    .locals 3
    .param p1, "dimAcount"    # F

    .prologue
    .line 39
    invoke-virtual {p0}, Lcom/cyjh/feedback/lib/base/BaseDialog;->getWindow()Landroid/view/Window;

    move-result-object v0

    .line 40
    .local v0, "mWindow":Landroid/view/Window;
    invoke-virtual {v0}, Landroid/view/Window;->getAttributes()Landroid/view/WindowManager$LayoutParams;

    move-result-object v1

    .line 42
    .local v1, "params":Landroid/view/WindowManager$LayoutParams;
    iput p1, v1, Landroid/view/WindowManager$LayoutParams;->dimAmount:F

    .line 43
    invoke-virtual {v0, v1}, Landroid/view/Window;->setAttributes(Landroid/view/WindowManager$LayoutParams;)V

    .line 44
    const/4 v2, 0x2

    invoke-virtual {v0, v2}, Landroid/view/Window;->addFlags(I)V

    .line 45
    return-void
.end method

.method public setDialogSize(FF)V
    .locals 0
    .param p1, "mDialogWidth"    # F
    .param p2, "mDialogHeight"    # F

    .prologue
    .line 59
    iput p1, p0, Lcom/cyjh/feedback/lib/base/BaseDialog;->mDialogWidth:F

    .line 60
    iput p2, p0, Lcom/cyjh/feedback/lib/base/BaseDialog;->mDialogHeight:F

    .line 61
    invoke-direct {p0}, Lcom/cyjh/feedback/lib/base/BaseDialog;->setDialogSize()V

    .line 62
    return-void
.end method
