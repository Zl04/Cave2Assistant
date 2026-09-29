.class public Lcom/cyjh/elfin/customview/DialogFactory;
.super Ljava/lang/Object;
.source "DialogFactory.java"


# direct methods
.method public constructor <init>()V
    .locals 0

    .prologue
    .line 14
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method

.method public static showStartDownloadDialog(Landroid/support/v4/app/FragmentManager;Lcom/cyjh/elfin/inf/RightBtnOpera;Lcom/cyjh/elfin/entity/FloatEditBean;Ljava/lang/String;)Lcom/cyjh/elfin/dialog/dialogfragment/ConfirmAndCancleDialogFragment;
    .locals 2
    .param p0, "fm"    # Landroid/support/v4/app/FragmentManager;
    .param p1, "rightBtnOpera"    # Lcom/cyjh/elfin/inf/RightBtnOpera;
    .param p2, "floatEditBean"    # Lcom/cyjh/elfin/entity/FloatEditBean;
    .param p3, "url"    # Ljava/lang/String;

    .prologue
    .line 18
    invoke-static {p2}, Lcom/cyjh/elfin/dialog/dialogfragment/ConfirmAndCancleDialogFragment;->getInstance(Lcom/cyjh/elfin/entity/FloatEditBean;)Lcom/cyjh/elfin/dialog/dialogfragment/ConfirmAndCancleDialogFragment;

    move-result-object v0

    .line 19
    .local v0, "confirmAndCancleDialogFragment":Lcom/cyjh/elfin/dialog/dialogfragment/ConfirmAndCancleDialogFragment;
    invoke-virtual {v0, p1}, Lcom/cyjh/elfin/dialog/dialogfragment/ConfirmAndCancleDialogFragment;->setRightBtnOpera(Lcom/cyjh/elfin/inf/RightBtnOpera;)V

    .line 20
    invoke-virtual {v0, p3}, Lcom/cyjh/elfin/dialog/dialogfragment/ConfirmAndCancleDialogFragment;->setObject(Ljava/lang/Object;)V

    .line 21
    const-string v1, "ConfirmAndCancleDialogFragment"

    invoke-virtual {v0, p0, v1}, Lcom/cyjh/elfin/dialog/dialogfragment/ConfirmAndCancleDialogFragment;->show(Landroid/support/v4/app/FragmentManager;Ljava/lang/String;)V

    .line 22
    return-object v0
.end method
