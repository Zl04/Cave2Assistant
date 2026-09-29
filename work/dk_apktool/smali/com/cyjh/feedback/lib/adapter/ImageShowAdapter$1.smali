.class Lcom/cyjh/feedback/lib/adapter/ImageShowAdapter$1;
.super Ljava/lang/Object;
.source "ImageShowAdapter.java"

# interfaces
.implements Landroid/view/View$OnClickListener;


# annotations
.annotation system Ldalvik/annotation/EnclosingMethod;
    value = Lcom/cyjh/feedback/lib/adapter/ImageShowAdapter;->getView(ILandroid/view/View;Landroid/view/ViewGroup;)Landroid/view/View;
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x0
    name = null
.end annotation


# instance fields
.field final synthetic this$0:Lcom/cyjh/feedback/lib/adapter/ImageShowAdapter;

.field final synthetic val$position:I


# direct methods
.method constructor <init>(Lcom/cyjh/feedback/lib/adapter/ImageShowAdapter;I)V
    .locals 0
    .param p1, "this$0"    # Lcom/cyjh/feedback/lib/adapter/ImageShowAdapter;

    .prologue
    .line 96
    iput-object p1, p0, Lcom/cyjh/feedback/lib/adapter/ImageShowAdapter$1;->this$0:Lcom/cyjh/feedback/lib/adapter/ImageShowAdapter;

    iput p2, p0, Lcom/cyjh/feedback/lib/adapter/ImageShowAdapter$1;->val$position:I

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method


# virtual methods
.method public onClick(Landroid/view/View;)V
    .locals 3
    .param p1, "v"    # Landroid/view/View;

    .prologue
    .line 99
    iget-object v0, p0, Lcom/cyjh/feedback/lib/adapter/ImageShowAdapter$1;->this$0:Lcom/cyjh/feedback/lib/adapter/ImageShowAdapter;

    invoke-static {v0}, Lcom/cyjh/feedback/lib/adapter/ImageShowAdapter;->access$000(Lcom/cyjh/feedback/lib/adapter/ImageShowAdapter;)Ljava/util/List;

    move-result-object v0

    iget-object v1, p0, Lcom/cyjh/feedback/lib/adapter/ImageShowAdapter$1;->this$0:Lcom/cyjh/feedback/lib/adapter/ImageShowAdapter;

    invoke-static {v1}, Lcom/cyjh/feedback/lib/adapter/ImageShowAdapter;->access$000(Lcom/cyjh/feedback/lib/adapter/ImageShowAdapter;)Ljava/util/List;

    move-result-object v1

    iget v2, p0, Lcom/cyjh/feedback/lib/adapter/ImageShowAdapter$1;->val$position:I

    invoke-interface {v1, v2}, Ljava/util/List;->get(I)Ljava/lang/Object;

    move-result-object v1

    invoke-interface {v0, v1}, Ljava/util/List;->remove(Ljava/lang/Object;)Z

    .line 100
    iget-object v0, p0, Lcom/cyjh/feedback/lib/adapter/ImageShowAdapter$1;->this$0:Lcom/cyjh/feedback/lib/adapter/ImageShowAdapter;

    invoke-virtual {v0}, Lcom/cyjh/feedback/lib/adapter/ImageShowAdapter;->notifyDataSetChanged()V

    .line 101
    iget-object v0, p0, Lcom/cyjh/feedback/lib/adapter/ImageShowAdapter$1;->this$0:Lcom/cyjh/feedback/lib/adapter/ImageShowAdapter;

    invoke-static {v0}, Lcom/cyjh/feedback/lib/adapter/ImageShowAdapter;->access$100(Lcom/cyjh/feedback/lib/adapter/ImageShowAdapter;)Lcom/cyjh/feedback/lib/adapter/ImageShowAdapter$OnDeleteSelectImg;

    move-result-object v0

    if-eqz v0, :cond_0

    .line 102
    iget-object v0, p0, Lcom/cyjh/feedback/lib/adapter/ImageShowAdapter$1;->this$0:Lcom/cyjh/feedback/lib/adapter/ImageShowAdapter;

    invoke-static {v0}, Lcom/cyjh/feedback/lib/adapter/ImageShowAdapter;->access$100(Lcom/cyjh/feedback/lib/adapter/ImageShowAdapter;)Lcom/cyjh/feedback/lib/adapter/ImageShowAdapter$OnDeleteSelectImg;

    move-result-object v0

    iget-object v1, p0, Lcom/cyjh/feedback/lib/adapter/ImageShowAdapter$1;->this$0:Lcom/cyjh/feedback/lib/adapter/ImageShowAdapter;

    invoke-static {v1}, Lcom/cyjh/feedback/lib/adapter/ImageShowAdapter;->access$000(Lcom/cyjh/feedback/lib/adapter/ImageShowAdapter;)Ljava/util/List;

    move-result-object v1

    invoke-interface {v1}, Ljava/util/List;->size()I

    move-result v1

    invoke-interface {v0, v1}, Lcom/cyjh/feedback/lib/adapter/ImageShowAdapter$OnDeleteSelectImg;->onClick(I)V

    .line 104
    :cond_0
    return-void
.end method
