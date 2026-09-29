.class Lcom/cyjh/elfin/customview/GameDownloadView$DownloadDisplayHelper$1;
.super Ljava/lang/Object;
.source "GameDownloadView.java"

# interfaces
.implements Ljava/lang/Runnable;


# annotations
.annotation system Ldalvik/annotation/EnclosingMethod;
    value = Lcom/cyjh/elfin/customview/GameDownloadView$DownloadDisplayHelper;->onDownloadedDisplay()V
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x0
    name = null
.end annotation


# instance fields
.field final synthetic this$1:Lcom/cyjh/elfin/customview/GameDownloadView$DownloadDisplayHelper;


# direct methods
.method constructor <init>(Lcom/cyjh/elfin/customview/GameDownloadView$DownloadDisplayHelper;)V
    .locals 0
    .param p1, "this$1"    # Lcom/cyjh/elfin/customview/GameDownloadView$DownloadDisplayHelper;

    .prologue
    .line 154
    iput-object p1, p0, Lcom/cyjh/elfin/customview/GameDownloadView$DownloadDisplayHelper$1;->this$1:Lcom/cyjh/elfin/customview/GameDownloadView$DownloadDisplayHelper;

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method


# virtual methods
.method public run()V
    .locals 2

    .prologue
    .line 157
    iget-object v0, p0, Lcom/cyjh/elfin/customview/GameDownloadView$DownloadDisplayHelper$1;->this$1:Lcom/cyjh/elfin/customview/GameDownloadView$DownloadDisplayHelper;

    iget-object v0, v0, Lcom/cyjh/elfin/customview/GameDownloadView$DownloadDisplayHelper;->this$0:Lcom/cyjh/elfin/customview/GameDownloadView;

    invoke-static {v0}, Lcom/cyjh/elfin/customview/GameDownloadView;->access$500(Lcom/cyjh/elfin/customview/GameDownloadView;)Landroid/widget/ProgressBar;

    move-result-object v0

    const/4 v1, 0x0

    invoke-virtual {v0, v1}, Landroid/widget/ProgressBar;->setProgress(I)V

    .line 158
    return-void
.end method
