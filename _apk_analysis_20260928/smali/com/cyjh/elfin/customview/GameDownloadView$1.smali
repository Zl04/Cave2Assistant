.class Lcom/cyjh/elfin/customview/GameDownloadView$1;
.super Ljava/lang/Object;
.source "GameDownloadView.java"

# interfaces
.implements Lcom/cyjh/elfin/download/GameDownloadHelper$OnClickerCallback;


# annotations
.annotation system Ldalvik/annotation/EnclosingMethod;
    value = Lcom/cyjh/elfin/customview/GameDownloadView;->onClick(Landroid/view/View;)V
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x0
    name = null
.end annotation


# instance fields
.field final synthetic this$0:Lcom/cyjh/elfin/customview/GameDownloadView;


# direct methods
.method constructor <init>(Lcom/cyjh/elfin/customview/GameDownloadView;)V
    .locals 0
    .param p1, "this$0"    # Lcom/cyjh/elfin/customview/GameDownloadView;

    .prologue
    .line 110
    iput-object p1, p0, Lcom/cyjh/elfin/customview/GameDownloadView$1;->this$0:Lcom/cyjh/elfin/customview/GameDownloadView;

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method


# virtual methods
.method public onClicker()V
    .locals 2

    .prologue
    .line 114
    iget-object v0, p0, Lcom/cyjh/elfin/customview/GameDownloadView$1;->this$0:Lcom/cyjh/elfin/customview/GameDownloadView;

    invoke-static {v0}, Lcom/cyjh/elfin/customview/GameDownloadView;->access$000(Lcom/cyjh/elfin/customview/GameDownloadView;)Lcom/cyjh/elfin/entity/GameInfo;

    move-result-object v0

    iget-object v0, v0, Lcom/cyjh/elfin/entity/GameInfo;->Id:Ljava/lang/String;

    iget-object v1, p0, Lcom/cyjh/elfin/customview/GameDownloadView$1;->this$0:Lcom/cyjh/elfin/customview/GameDownloadView;

    iget-object v1, v1, Lcom/cyjh/elfin/customview/GameDownloadView;->mContext:Landroid/content/Context;

    invoke-static {v0, v1}, Lcom/cyjh/elfin/download/DownloadCountOpera;->requestClickerDownloadCount(Ljava/lang/String;Landroid/content/Context;)V

    .line 115
    return-void
.end method
