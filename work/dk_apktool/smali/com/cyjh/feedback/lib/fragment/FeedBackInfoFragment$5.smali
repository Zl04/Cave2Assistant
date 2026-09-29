.class Lcom/cyjh/feedback/lib/fragment/FeedBackInfoFragment$5;
.super Ljava/lang/Object;
.source "FeedBackInfoFragment.java"

# interfaces
.implements Landroid/widget/AdapterView$OnItemClickListener;


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
    .line 315
    iput-object p1, p0, Lcom/cyjh/feedback/lib/fragment/FeedBackInfoFragment$5;->this$0:Lcom/cyjh/feedback/lib/fragment/FeedBackInfoFragment;

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method


# virtual methods
.method public onItemClick(Landroid/widget/AdapterView;Landroid/view/View;IJ)V
    .locals 3
    .param p2, "view"    # Landroid/view/View;
    .param p3, "position"    # I
    .param p4, "id"    # J
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "(",
            "Landroid/widget/AdapterView",
            "<*>;",
            "Landroid/view/View;",
            "IJ)V"
        }
    .end annotation

    .prologue
    .line 318
    .local p1, "parent":Landroid/widget/AdapterView;, "Landroid/widget/AdapterView<*>;"
    iget-object v1, p0, Lcom/cyjh/feedback/lib/fragment/FeedBackInfoFragment$5;->this$0:Lcom/cyjh/feedback/lib/fragment/FeedBackInfoFragment;

    invoke-static {v1}, Lcom/cyjh/feedback/lib/fragment/FeedBackInfoFragment;->access$800(Lcom/cyjh/feedback/lib/fragment/FeedBackInfoFragment;)Ljava/util/List;

    move-result-object v1

    invoke-interface {v1}, Ljava/util/List;->size()I

    move-result v1

    if-ne p3, v1, :cond_0

    .line 319
    new-instance v0, Landroid/content/Intent;

    iget-object v1, p0, Lcom/cyjh/feedback/lib/fragment/FeedBackInfoFragment$5;->this$0:Lcom/cyjh/feedback/lib/fragment/FeedBackInfoFragment;

    invoke-virtual {v1}, Lcom/cyjh/feedback/lib/fragment/FeedBackInfoFragment;->getActivity()Landroid/support/v4/app/FragmentActivity;

    move-result-object v1

    const-class v2, Lcom/cyjh/feedback/lib/activity/ImageSelectActivity;

    invoke-direct {v0, v1, v2}, Landroid/content/Intent;-><init>(Landroid/content/Context;Ljava/lang/Class;)V

    .line 320
    .local v0, "intent":Landroid/content/Intent;
    iget-object v1, p0, Lcom/cyjh/feedback/lib/fragment/FeedBackInfoFragment$5;->this$0:Lcom/cyjh/feedback/lib/fragment/FeedBackInfoFragment;

    const/16 v2, 0x100

    invoke-virtual {v1, v0, v2}, Lcom/cyjh/feedback/lib/fragment/FeedBackInfoFragment;->startActivityForResult(Landroid/content/Intent;I)V

    .line 322
    .end local v0    # "intent":Landroid/content/Intent;
    :cond_0
    return-void
.end method
