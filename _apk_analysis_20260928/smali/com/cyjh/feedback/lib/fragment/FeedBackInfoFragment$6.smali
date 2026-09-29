.class Lcom/cyjh/feedback/lib/fragment/FeedBackInfoFragment$6;
.super Ljava/lang/Object;
.source "FeedBackInfoFragment.java"

# interfaces
.implements Lcom/cyjh/feedback/lib/adapter/ImageShowAdapter$OnDeleteSelectImg;


# annotations
.annotation system Ldalvik/annotation/EnclosingMethod;
    value = Lcom/cyjh/feedback/lib/fragment/FeedBackInfoFragment;->initEvent()V
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x0
    name = null
.end annotation


# instance fields
.field final synthetic this$0:Lcom/cyjh/feedback/lib/fragment/FeedBackInfoFragment;


# direct methods
.method constructor <init>(Lcom/cyjh/feedback/lib/fragment/FeedBackInfoFragment;)V
    .locals 0
    .param p1, "this$0"    # Lcom/cyjh/feedback/lib/fragment/FeedBackInfoFragment;

    .prologue
    .line 325
    iput-object p1, p0, Lcom/cyjh/feedback/lib/fragment/FeedBackInfoFragment$6;->this$0:Lcom/cyjh/feedback/lib/fragment/FeedBackInfoFragment;

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method


# virtual methods
.method public onClick(I)V
    .locals 6
    .param p1, "imgCount"    # I

    .prologue
    .line 328
    iget-object v0, p0, Lcom/cyjh/feedback/lib/fragment/FeedBackInfoFragment$6;->this$0:Lcom/cyjh/feedback/lib/fragment/FeedBackInfoFragment;

    invoke-static {v0}, Lcom/cyjh/feedback/lib/fragment/FeedBackInfoFragment;->access$900(Lcom/cyjh/feedback/lib/fragment/FeedBackInfoFragment;)Landroid/widget/TextView;

    move-result-object v0

    iget-object v1, p0, Lcom/cyjh/feedback/lib/fragment/FeedBackInfoFragment$6;->this$0:Lcom/cyjh/feedback/lib/fragment/FeedBackInfoFragment;

    sget v2, Lcom/cyjh/feedback/libraryfeedbackinfo/R$string;->image_add:I

    const/4 v3, 0x1

    new-array v3, v3, [Ljava/lang/Object;

    const/4 v4, 0x0

    invoke-static {p1}, Ljava/lang/Integer;->valueOf(I)Ljava/lang/Integer;

    move-result-object v5

    aput-object v5, v3, v4

    invoke-virtual {v1, v2, v3}, Lcom/cyjh/feedback/lib/fragment/FeedBackInfoFragment;->getString(I[Ljava/lang/Object;)Ljava/lang/String;

    move-result-object v1

    invoke-virtual {v0, v1}, Landroid/widget/TextView;->setText(Ljava/lang/CharSequence;)V

    .line 329
    return-void
.end method
