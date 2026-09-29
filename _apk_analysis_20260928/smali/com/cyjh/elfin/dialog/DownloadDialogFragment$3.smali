.class Lcom/cyjh/elfin/dialog/DownloadDialogFragment$3;
.super Ljava/lang/Object;
.source "DownloadDialogFragment.java"

# interfaces
.implements Landroid/view/View$OnClickListener;


# annotations
.annotation system Ldalvik/annotation/EnclosingClass;
    value = Lcom/cyjh/elfin/dialog/DownloadDialogFragment;
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x0
    name = null
.end annotation


# instance fields
.field final synthetic this$0:Lcom/cyjh/elfin/dialog/DownloadDialogFragment;


# direct methods
.method constructor <init>(Lcom/cyjh/elfin/dialog/DownloadDialogFragment;)V
    .locals 0
    .param p1, "this$0"    # Lcom/cyjh/elfin/dialog/DownloadDialogFragment;

    .prologue
    .line 183
    iput-object p1, p0, Lcom/cyjh/elfin/dialog/DownloadDialogFragment$3;->this$0:Lcom/cyjh/elfin/dialog/DownloadDialogFragment;

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method


# virtual methods
.method public onClick(Landroid/view/View;)V
    .locals 2
    .param p1, "v"    # Landroid/view/View;

    .prologue
    .line 187
    iget-object v0, p0, Lcom/cyjh/elfin/dialog/DownloadDialogFragment$3;->this$0:Lcom/cyjh/elfin/dialog/DownloadDialogFragment;

    invoke-static {v0}, Lcom/cyjh/elfin/dialog/DownloadDialogFragment;->access$300(Lcom/cyjh/elfin/dialog/DownloadDialogFragment;)Lcom/cyjh/elfin/dialog/DownloadDialogFragment$OnDownloadClickListener;

    move-result-object v0

    iget-object v1, p0, Lcom/cyjh/elfin/dialog/DownloadDialogFragment$3;->this$0:Lcom/cyjh/elfin/dialog/DownloadDialogFragment;

    invoke-static {v1}, Lcom/cyjh/elfin/dialog/DownloadDialogFragment;->access$200(Lcom/cyjh/elfin/dialog/DownloadDialogFragment;)Lcom/dd/processbutton/iml/SubmitProcessButton;

    move-result-object v1

    invoke-interface {v0, v1}, Lcom/cyjh/elfin/dialog/DownloadDialogFragment$OnDownloadClickListener;->downloadOnClick(Lcom/dd/processbutton/iml/SubmitProcessButton;)V

    .line 188
    return-void
.end method
