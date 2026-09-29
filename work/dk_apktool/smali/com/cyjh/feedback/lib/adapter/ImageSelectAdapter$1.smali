.class Lcom/cyjh/feedback/lib/adapter/ImageSelectAdapter$1;
.super Ljava/lang/Object;
.source "ImageSelectAdapter.java"

# interfaces
.implements Landroid/view/View$OnClickListener;


# annotations
.annotation system Ldalvik/annotation/EnclosingMethod;
    value = Lcom/cyjh/feedback/lib/adapter/ImageSelectAdapter;->getView(ILandroid/view/View;Landroid/view/ViewGroup;)Landroid/view/View;
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x0
    name = null
.end annotation


# instance fields
.field final synthetic this$0:Lcom/cyjh/feedback/lib/adapter/ImageSelectAdapter;

.field final synthetic val$mHolder:Lcom/cyjh/feedback/lib/adapter/ImageSelectAdapter$ViewHolder;

.field final synthetic val$path:Ljava/lang/String;


# direct methods
.method constructor <init>(Lcom/cyjh/feedback/lib/adapter/ImageSelectAdapter;Ljava/lang/String;Lcom/cyjh/feedback/lib/adapter/ImageSelectAdapter$ViewHolder;)V
    .locals 0
    .param p1, "this$0"    # Lcom/cyjh/feedback/lib/adapter/ImageSelectAdapter;

    .prologue
    .line 79
    iput-object p1, p0, Lcom/cyjh/feedback/lib/adapter/ImageSelectAdapter$1;->this$0:Lcom/cyjh/feedback/lib/adapter/ImageSelectAdapter;

    iput-object p2, p0, Lcom/cyjh/feedback/lib/adapter/ImageSelectAdapter$1;->val$path:Ljava/lang/String;

    iput-object p3, p0, Lcom/cyjh/feedback/lib/adapter/ImageSelectAdapter$1;->val$mHolder:Lcom/cyjh/feedback/lib/adapter/ImageSelectAdapter$ViewHolder;

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method


# virtual methods
.method public onClick(Landroid/view/View;)V
    .locals 7
    .param p1, "v"    # Landroid/view/View;

    .prologue
    const/4 v6, 0x1

    .line 82
    new-instance v0, Ljava/io/File;

    iget-object v1, p0, Lcom/cyjh/feedback/lib/adapter/ImageSelectAdapter$1;->val$path:Ljava/lang/String;

    invoke-direct {v0, v1}, Ljava/io/File;-><init>(Ljava/lang/String;)V

    .line 83
    .local v0, "file":Ljava/io/File;
    invoke-virtual {v0}, Ljava/io/File;->length()J

    move-result-wide v2

    const-wide/16 v4, 0x400

    div-long/2addr v2, v4

    const-wide/16 v4, 0x800

    sub-long/2addr v2, v4

    const-wide/16 v4, 0x0

    cmp-long v1, v2, v4

    if-lez v1, :cond_1

    .line 84
    iget-object v1, p0, Lcom/cyjh/feedback/lib/adapter/ImageSelectAdapter$1;->this$0:Lcom/cyjh/feedback/lib/adapter/ImageSelectAdapter;

    invoke-static {v1}, Lcom/cyjh/feedback/lib/adapter/ImageSelectAdapter;->access$000(Lcom/cyjh/feedback/lib/adapter/ImageSelectAdapter;)Landroid/content/Context;

    move-result-object v1

    iget-object v2, p0, Lcom/cyjh/feedback/lib/adapter/ImageSelectAdapter$1;->this$0:Lcom/cyjh/feedback/lib/adapter/ImageSelectAdapter;

    invoke-static {v2}, Lcom/cyjh/feedback/lib/adapter/ImageSelectAdapter;->access$000(Lcom/cyjh/feedback/lib/adapter/ImageSelectAdapter;)Landroid/content/Context;

    move-result-object v2

    sget v3, Lcom/cyjh/feedback/libraryfeedbackinfo/R$string;->img_content_too_large:I

    invoke-virtual {v2, v3}, Landroid/content/Context;->getString(I)Ljava/lang/String;

    move-result-object v2

    invoke-static {v1, v2, v6}, Landroid/widget/Toast;->makeText(Landroid/content/Context;Ljava/lang/CharSequence;I)Landroid/widget/Toast;

    move-result-object v1

    invoke-virtual {v1}, Landroid/widget/Toast;->show()V

    .line 109
    :cond_0
    :goto_0
    return-void

    .line 88
    :cond_1
    iget-object v1, p0, Lcom/cyjh/feedback/lib/adapter/ImageSelectAdapter$1;->this$0:Lcom/cyjh/feedback/lib/adapter/ImageSelectAdapter;

    invoke-static {v1}, Lcom/cyjh/feedback/lib/adapter/ImageSelectAdapter;->access$100(Lcom/cyjh/feedback/lib/adapter/ImageSelectAdapter;)Ljava/util/Set;

    move-result-object v1

    iget-object v2, p0, Lcom/cyjh/feedback/lib/adapter/ImageSelectAdapter$1;->val$path:Ljava/lang/String;

    invoke-interface {v1, v2}, Ljava/util/Set;->contains(Ljava/lang/Object;)Z

    move-result v1

    if-eqz v1, :cond_2

    .line 89
    iget-object v1, p0, Lcom/cyjh/feedback/lib/adapter/ImageSelectAdapter$1;->this$0:Lcom/cyjh/feedback/lib/adapter/ImageSelectAdapter;

    invoke-static {v1}, Lcom/cyjh/feedback/lib/adapter/ImageSelectAdapter;->access$100(Lcom/cyjh/feedback/lib/adapter/ImageSelectAdapter;)Ljava/util/Set;

    move-result-object v1

    iget-object v2, p0, Lcom/cyjh/feedback/lib/adapter/ImageSelectAdapter$1;->val$path:Ljava/lang/String;

    invoke-interface {v1, v2}, Ljava/util/Set;->remove(Ljava/lang/Object;)Z

    .line 90
    iget-object v1, p0, Lcom/cyjh/feedback/lib/adapter/ImageSelectAdapter$1;->val$mHolder:Lcom/cyjh/feedback/lib/adapter/ImageSelectAdapter$ViewHolder;

    iget-object v1, v1, Lcom/cyjh/feedback/lib/adapter/ImageSelectAdapter$ViewHolder;->imageView:Landroid/widget/ImageView;

    const/4 v2, 0x0

    invoke-virtual {v1, v2}, Landroid/widget/ImageView;->setColorFilter(Landroid/graphics/ColorFilter;)V

    .line 91
    iget-object v1, p0, Lcom/cyjh/feedback/lib/adapter/ImageSelectAdapter$1;->val$mHolder:Lcom/cyjh/feedback/lib/adapter/ImageSelectAdapter$ViewHolder;

    iget-object v1, v1, Lcom/cyjh/feedback/lib/adapter/ImageSelectAdapter$ViewHolder;->imageButton:Landroid/widget/ImageButton;

    const/4 v2, 0x4

    invoke-virtual {v1, v2}, Landroid/widget/ImageButton;->setVisibility(I)V

    .line 105
    :goto_1
    iget-object v1, p0, Lcom/cyjh/feedback/lib/adapter/ImageSelectAdapter$1;->this$0:Lcom/cyjh/feedback/lib/adapter/ImageSelectAdapter;

    invoke-static {v1}, Lcom/cyjh/feedback/lib/adapter/ImageSelectAdapter;->access$200(Lcom/cyjh/feedback/lib/adapter/ImageSelectAdapter;)Lcom/cyjh/feedback/lib/adapter/ImageSelectAdapter$OnSelectImgNumber;

    move-result-object v1

    if-eqz v1, :cond_0

    .line 107
    iget-object v1, p0, Lcom/cyjh/feedback/lib/adapter/ImageSelectAdapter$1;->this$0:Lcom/cyjh/feedback/lib/adapter/ImageSelectAdapter;

    invoke-static {v1}, Lcom/cyjh/feedback/lib/adapter/ImageSelectAdapter;->access$200(Lcom/cyjh/feedback/lib/adapter/ImageSelectAdapter;)Lcom/cyjh/feedback/lib/adapter/ImageSelectAdapter$OnSelectImgNumber;

    move-result-object v1

    iget-object v2, p0, Lcom/cyjh/feedback/lib/adapter/ImageSelectAdapter$1;->this$0:Lcom/cyjh/feedback/lib/adapter/ImageSelectAdapter;

    invoke-static {v2}, Lcom/cyjh/feedback/lib/adapter/ImageSelectAdapter;->access$100(Lcom/cyjh/feedback/lib/adapter/ImageSelectAdapter;)Ljava/util/Set;

    move-result-object v2

    invoke-interface {v2}, Ljava/util/Set;->size()I

    move-result v2

    invoke-interface {v1, v2}, Lcom/cyjh/feedback/lib/adapter/ImageSelectAdapter$OnSelectImgNumber;->isSelectImg(I)V

    goto :goto_0

    .line 94
    :cond_2
    iget-object v1, p0, Lcom/cyjh/feedback/lib/adapter/ImageSelectAdapter$1;->this$0:Lcom/cyjh/feedback/lib/adapter/ImageSelectAdapter;

    invoke-static {v1}, Lcom/cyjh/feedback/lib/adapter/ImageSelectAdapter;->access$100(Lcom/cyjh/feedback/lib/adapter/ImageSelectAdapter;)Ljava/util/Set;

    move-result-object v1

    invoke-interface {v1}, Ljava/util/Set;->size()I

    move-result v1

    const/4 v2, 0x3

    if-le v1, v2, :cond_3

    .line 95
    iget-object v1, p0, Lcom/cyjh/feedback/lib/adapter/ImageSelectAdapter$1;->this$0:Lcom/cyjh/feedback/lib/adapter/ImageSelectAdapter;

    invoke-static {v1}, Lcom/cyjh/feedback/lib/adapter/ImageSelectAdapter;->access$000(Lcom/cyjh/feedback/lib/adapter/ImageSelectAdapter;)Landroid/content/Context;

    move-result-object v1

    iget-object v2, p0, Lcom/cyjh/feedback/lib/adapter/ImageSelectAdapter$1;->this$0:Lcom/cyjh/feedback/lib/adapter/ImageSelectAdapter;

    invoke-static {v2}, Lcom/cyjh/feedback/lib/adapter/ImageSelectAdapter;->access$000(Lcom/cyjh/feedback/lib/adapter/ImageSelectAdapter;)Landroid/content/Context;

    move-result-object v2

    sget v3, Lcom/cyjh/feedback/libraryfeedbackinfo/R$string;->img_count_more:I

    invoke-virtual {v2, v3}, Landroid/content/Context;->getString(I)Ljava/lang/String;

    move-result-object v2

    invoke-static {v1, v2, v6}, Landroid/widget/Toast;->makeText(Landroid/content/Context;Ljava/lang/CharSequence;I)Landroid/widget/Toast;

    move-result-object v1

    invoke-virtual {v1}, Landroid/widget/Toast;->show()V

    goto :goto_0

    .line 98
    :cond_3
    iget-object v1, p0, Lcom/cyjh/feedback/lib/adapter/ImageSelectAdapter$1;->this$0:Lcom/cyjh/feedback/lib/adapter/ImageSelectAdapter;

    invoke-static {v1}, Lcom/cyjh/feedback/lib/adapter/ImageSelectAdapter;->access$100(Lcom/cyjh/feedback/lib/adapter/ImageSelectAdapter;)Ljava/util/Set;

    move-result-object v1

    iget-object v2, p0, Lcom/cyjh/feedback/lib/adapter/ImageSelectAdapter$1;->val$path:Ljava/lang/String;

    invoke-interface {v1, v2}, Ljava/util/Set;->add(Ljava/lang/Object;)Z

    .line 99
    iget-object v1, p0, Lcom/cyjh/feedback/lib/adapter/ImageSelectAdapter$1;->val$mHolder:Lcom/cyjh/feedback/lib/adapter/ImageSelectAdapter$ViewHolder;

    iget-object v1, v1, Lcom/cyjh/feedback/lib/adapter/ImageSelectAdapter$ViewHolder;->imageView:Landroid/widget/ImageView;

    const-string v2, "#77000000"

    invoke-static {v2}, Landroid/graphics/Color;->parseColor(Ljava/lang/String;)I

    move-result v2

    invoke-virtual {v1, v2}, Landroid/widget/ImageView;->setColorFilter(I)V

    .line 100
    iget-object v1, p0, Lcom/cyjh/feedback/lib/adapter/ImageSelectAdapter$1;->val$mHolder:Lcom/cyjh/feedback/lib/adapter/ImageSelectAdapter$ViewHolder;

    iget-object v1, v1, Lcom/cyjh/feedback/lib/adapter/ImageSelectAdapter$ViewHolder;->imageButton:Landroid/widget/ImageButton;

    const/4 v2, 0x0

    invoke-virtual {v1, v2}, Landroid/widget/ImageButton;->setVisibility(I)V

    goto :goto_1
.end method
