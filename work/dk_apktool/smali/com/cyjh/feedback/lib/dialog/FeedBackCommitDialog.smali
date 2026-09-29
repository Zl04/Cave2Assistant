.class public Lcom/cyjh/feedback/lib/dialog/FeedBackCommitDialog;
.super Lcom/cyjh/feedback/lib/base/BaseDialog;
.source "FeedBackCommitDialog.java"


# direct methods
.method public constructor <init>(Landroid/content/Context;)V
    .locals 1
    .param p1, "context"    # Landroid/content/Context;

    .prologue
    .line 15
    sget v0, Lcom/cyjh/feedback/libraryfeedbackinfo/R$style;->Theme_Dialog:I

    invoke-direct {p0, p1, v0}, Lcom/cyjh/feedback/lib/base/BaseDialog;-><init>(Landroid/content/Context;I)V

    .line 16
    return-void
.end method


# virtual methods
.method protected onCreate(Landroid/os/Bundle;)V
    .locals 2
    .param p1, "savedInstanceState"    # Landroid/os/Bundle;

    .prologue
    const/high16 v1, 0x3f800000    # 1.0f

    .line 20
    invoke-super {p0, p1}, Lcom/cyjh/feedback/lib/base/BaseDialog;->onCreate(Landroid/os/Bundle;)V

    .line 21
    sget v0, Lcom/cyjh/feedback/libraryfeedbackinfo/R$layout;->dialog_feedback_commit:I

    invoke-virtual {p0, v0}, Lcom/cyjh/feedback/lib/dialog/FeedBackCommitDialog;->setContentView(I)V

    .line 22
    const/high16 v0, 0x3f000000    # 0.5f

    invoke-virtual {p0, v0}, Lcom/cyjh/feedback/lib/dialog/FeedBackCommitDialog;->setBlurEffect(F)V

    .line 23
    invoke-virtual {p0, v1, v1}, Lcom/cyjh/feedback/lib/dialog/FeedBackCommitDialog;->setDialogSize(FF)V

    .line 24
    return-void
.end method

.method public onTouchEvent(Landroid/view/MotionEvent;)Z
    .locals 1
    .param p1, "event"    # Landroid/view/MotionEvent;

    .prologue
    .line 28
    invoke-virtual {p0}, Lcom/cyjh/feedback/lib/dialog/FeedBackCommitDialog;->dismiss()V

    .line 29
    const/4 v0, 0x1

    return v0
.end method
