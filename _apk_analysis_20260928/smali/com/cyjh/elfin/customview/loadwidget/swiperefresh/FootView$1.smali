.class Lcom/cyjh/elfin/customview/loadwidget/swiperefresh/FootView$1;
.super Ljava/lang/Object;
.source "FootView.java"

# interfaces
.implements Landroid/view/View$OnClickListener;


# annotations
.annotation system Ldalvik/annotation/EnclosingClass;
    value = Lcom/cyjh/elfin/customview/loadwidget/swiperefresh/FootView;
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x0
    name = null
.end annotation


# instance fields
.field final synthetic this$0:Lcom/cyjh/elfin/customview/loadwidget/swiperefresh/FootView;


# direct methods
.method constructor <init>(Lcom/cyjh/elfin/customview/loadwidget/swiperefresh/FootView;)V
    .locals 0
    .param p1, "this$0"    # Lcom/cyjh/elfin/customview/loadwidget/swiperefresh/FootView;

    .prologue
    .line 102
    iput-object p1, p0, Lcom/cyjh/elfin/customview/loadwidget/swiperefresh/FootView$1;->this$0:Lcom/cyjh/elfin/customview/loadwidget/swiperefresh/FootView;

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method


# virtual methods
.method public onClick(Landroid/view/View;)V
    .locals 2
    .param p1, "v"    # Landroid/view/View;

    .prologue
    .line 106
    invoke-virtual {p1}, Landroid/view/View;->getId()I

    move-result v0

    iget-object v1, p0, Lcom/cyjh/elfin/customview/loadwidget/swiperefresh/FootView$1;->this$0:Lcom/cyjh/elfin/customview/loadwidget/swiperefresh/FootView;

    iget-object v1, v1, Lcom/cyjh/elfin/customview/loadwidget/swiperefresh/FootView;->mLoadEmptyTv:Landroid/widget/TextView;

    invoke-virtual {v1}, Landroid/widget/TextView;->getId()I

    move-result v1

    if-ne v0, v1, :cond_0

    .line 107
    iget-object v0, p0, Lcom/cyjh/elfin/customview/loadwidget/swiperefresh/FootView$1;->this$0:Lcom/cyjh/elfin/customview/loadwidget/swiperefresh/FootView;

    iget-object v0, v0, Lcom/cyjh/elfin/customview/loadwidget/swiperefresh/FootView;->mCallBack:Lcom/cyjh/elfin/mvp/views/loadstate/IListViewLoadCallBack;

    if-eqz v0, :cond_0

    .line 108
    iget-object v0, p0, Lcom/cyjh/elfin/customview/loadwidget/swiperefresh/FootView$1;->this$0:Lcom/cyjh/elfin/customview/loadwidget/swiperefresh/FootView;

    iget-object v0, v0, Lcom/cyjh/elfin/customview/loadwidget/swiperefresh/FootView;->mLoadEmptyTv:Landroid/widget/TextView;

    const-string v1, "\u52a0\u8f7d\u4e2d..."

    invoke-virtual {v0, v1}, Landroid/widget/TextView;->setText(Ljava/lang/CharSequence;)V

    .line 109
    iget-object v0, p0, Lcom/cyjh/elfin/customview/loadwidget/swiperefresh/FootView$1;->this$0:Lcom/cyjh/elfin/customview/loadwidget/swiperefresh/FootView;

    iget-object v0, v0, Lcom/cyjh/elfin/customview/loadwidget/swiperefresh/FootView;->mCallBack:Lcom/cyjh/elfin/mvp/views/loadstate/IListViewLoadCallBack;

    invoke-interface {v0}, Lcom/cyjh/elfin/mvp/views/loadstate/IListViewLoadCallBack;->loadNextPage()V

    .line 112
    :cond_0
    return-void
.end method
