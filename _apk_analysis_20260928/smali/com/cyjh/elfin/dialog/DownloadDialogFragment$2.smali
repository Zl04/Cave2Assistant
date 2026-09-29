.class Lcom/cyjh/elfin/dialog/DownloadDialogFragment$2;
.super Landroid/os/Handler;
.source "DownloadDialogFragment.java"


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
    .line 151
    iput-object p1, p0, Lcom/cyjh/elfin/dialog/DownloadDialogFragment$2;->this$0:Lcom/cyjh/elfin/dialog/DownloadDialogFragment;

    invoke-direct {p0}, Landroid/os/Handler;-><init>()V

    return-void
.end method


# virtual methods
.method public handleMessage(Landroid/os/Message;)V
    .locals 4
    .param p1, "msg"    # Landroid/os/Message;

    .prologue
    .line 154
    iget v0, p1, Landroid/os/Message;->what:I

    packed-switch v0, :pswitch_data_0

    .line 164
    :cond_0
    :goto_0
    return-void

    .line 156
    :pswitch_0
    iget-object v0, p0, Lcom/cyjh/elfin/dialog/DownloadDialogFragment$2;->this$0:Lcom/cyjh/elfin/dialog/DownloadDialogFragment;

    invoke-static {v0}, Lcom/cyjh/elfin/dialog/DownloadDialogFragment;->access$000(Lcom/cyjh/elfin/dialog/DownloadDialogFragment;)I

    move-result v0

    if-eqz v0, :cond_0

    iget-object v0, p0, Lcom/cyjh/elfin/dialog/DownloadDialogFragment$2;->this$0:Lcom/cyjh/elfin/dialog/DownloadDialogFragment;

    iget-object v0, v0, Lcom/cyjh/elfin/dialog/DownloadDialogFragment;->desApkFile:Ljava/io/File;

    invoke-virtual {v0}, Ljava/io/File;->length()J

    move-result-wide v0

    iget-object v2, p0, Lcom/cyjh/elfin/dialog/DownloadDialogFragment$2;->this$0:Lcom/cyjh/elfin/dialog/DownloadDialogFragment;

    invoke-static {v2}, Lcom/cyjh/elfin/dialog/DownloadDialogFragment;->access$000(Lcom/cyjh/elfin/dialog/DownloadDialogFragment;)I

    move-result v2

    int-to-long v2, v2

    cmp-long v0, v0, v2

    if-nez v0, :cond_0

    iget-object v0, p0, Lcom/cyjh/elfin/dialog/DownloadDialogFragment$2;->this$0:Lcom/cyjh/elfin/dialog/DownloadDialogFragment;

    invoke-virtual {v0}, Lcom/cyjh/elfin/dialog/DownloadDialogFragment;->isAdded()Z

    move-result v0

    if-eqz v0, :cond_0

    .line 157
    iget-object v0, p0, Lcom/cyjh/elfin/dialog/DownloadDialogFragment$2;->this$0:Lcom/cyjh/elfin/dialog/DownloadDialogFragment;

    invoke-static {v0}, Lcom/cyjh/elfin/dialog/DownloadDialogFragment;->access$200(Lcom/cyjh/elfin/dialog/DownloadDialogFragment;)Lcom/dd/processbutton/iml/SubmitProcessButton;

    move-result-object v0

    iget-object v1, p0, Lcom/cyjh/elfin/dialog/DownloadDialogFragment$2;->this$0:Lcom/cyjh/elfin/dialog/DownloadDialogFragment;

    const v2, 0x7f080038

    invoke-virtual {v1, v2}, Lcom/cyjh/elfin/dialog/DownloadDialogFragment;->getString(I)Ljava/lang/String;

    move-result-object v1

    invoke-virtual {v0, v1}, Lcom/dd/processbutton/iml/SubmitProcessButton;->setText(Ljava/lang/CharSequence;)V

    .line 158
    iget-object v0, p0, Lcom/cyjh/elfin/dialog/DownloadDialogFragment$2;->this$0:Lcom/cyjh/elfin/dialog/DownloadDialogFragment;

    const/4 v1, 0x1

    iput-boolean v1, v0, Lcom/cyjh/elfin/dialog/DownloadDialogFragment;->isDownloadComplete:Z

    goto :goto_0

    .line 154
    nop

    :pswitch_data_0
    .packed-switch 0x3e9
        :pswitch_0
    .end packed-switch
.end method
