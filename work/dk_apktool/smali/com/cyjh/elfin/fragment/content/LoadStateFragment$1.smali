.class Lcom/cyjh/elfin/fragment/content/LoadStateFragment$1;
.super Landroid/os/Handler;
.source "LoadStateFragment.java"


# annotations
.annotation system Ldalvik/annotation/EnclosingClass;
    value = Lcom/cyjh/elfin/fragment/content/LoadStateFragment;
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x0
    name = null
.end annotation


# instance fields
.field final synthetic this$0:Lcom/cyjh/elfin/fragment/content/LoadStateFragment;


# direct methods
.method constructor <init>(Lcom/cyjh/elfin/fragment/content/LoadStateFragment;)V
    .locals 0
    .param p1, "this$0"    # Lcom/cyjh/elfin/fragment/content/LoadStateFragment;

    .prologue
    .line 21
    iput-object p1, p0, Lcom/cyjh/elfin/fragment/content/LoadStateFragment$1;->this$0:Lcom/cyjh/elfin/fragment/content/LoadStateFragment;

    invoke-direct {p0}, Landroid/os/Handler;-><init>()V

    return-void
.end method


# virtual methods
.method public dispatchMessage(Landroid/os/Message;)V
    .locals 3
    .param p1, "msg"    # Landroid/os/Message;

    .prologue
    const/4 v2, 0x0

    const/16 v1, 0x8

    .line 25
    iget v0, p1, Landroid/os/Message;->what:I

    packed-switch v0, :pswitch_data_0

    .line 65
    :goto_0
    return-void

    .line 27
    :pswitch_0
    iget-object v0, p0, Lcom/cyjh/elfin/fragment/content/LoadStateFragment$1;->this$0:Lcom/cyjh/elfin/fragment/content/LoadStateFragment;

    invoke-static {v0}, Lcom/cyjh/elfin/fragment/content/LoadStateFragment;->access$000(Lcom/cyjh/elfin/fragment/content/LoadStateFragment;)Landroid/view/View;

    move-result-object v0

    invoke-virtual {v0, v1}, Landroid/view/View;->setVisibility(I)V

    .line 28
    iget-object v0, p0, Lcom/cyjh/elfin/fragment/content/LoadStateFragment$1;->this$0:Lcom/cyjh/elfin/fragment/content/LoadStateFragment;

    invoke-static {v0}, Lcom/cyjh/elfin/fragment/content/LoadStateFragment;->access$100(Lcom/cyjh/elfin/fragment/content/LoadStateFragment;)Landroid/view/View;

    move-result-object v0

    invoke-virtual {v0, v1}, Landroid/view/View;->setVisibility(I)V

    .line 29
    iget-object v0, p0, Lcom/cyjh/elfin/fragment/content/LoadStateFragment$1;->this$0:Lcom/cyjh/elfin/fragment/content/LoadStateFragment;

    iget-object v0, v0, Lcom/cyjh/elfin/fragment/content/LoadStateFragment;->mContentView:Landroid/view/View;

    invoke-virtual {v0, v1}, Landroid/view/View;->setVisibility(I)V

    .line 30
    iget-object v0, p0, Lcom/cyjh/elfin/fragment/content/LoadStateFragment$1;->this$0:Lcom/cyjh/elfin/fragment/content/LoadStateFragment;

    invoke-static {v0}, Lcom/cyjh/elfin/fragment/content/LoadStateFragment;->access$200(Lcom/cyjh/elfin/fragment/content/LoadStateFragment;)Landroid/view/View;

    move-result-object v0

    invoke-virtual {v0, v1}, Landroid/view/View;->setVisibility(I)V

    .line 31
    iget-object v0, p0, Lcom/cyjh/elfin/fragment/content/LoadStateFragment$1;->this$0:Lcom/cyjh/elfin/fragment/content/LoadStateFragment;

    invoke-static {v0}, Lcom/cyjh/elfin/fragment/content/LoadStateFragment;->access$300(Lcom/cyjh/elfin/fragment/content/LoadStateFragment;)Landroid/view/View;

    move-result-object v0

    invoke-virtual {v0, v2}, Landroid/view/View;->setVisibility(I)V

    goto :goto_0

    .line 34
    :pswitch_1
    iget-object v0, p0, Lcom/cyjh/elfin/fragment/content/LoadStateFragment$1;->this$0:Lcom/cyjh/elfin/fragment/content/LoadStateFragment;

    invoke-static {v0}, Lcom/cyjh/elfin/fragment/content/LoadStateFragment;->access$000(Lcom/cyjh/elfin/fragment/content/LoadStateFragment;)Landroid/view/View;

    move-result-object v0

    invoke-virtual {v0, v1}, Landroid/view/View;->setVisibility(I)V

    .line 35
    iget-object v0, p0, Lcom/cyjh/elfin/fragment/content/LoadStateFragment$1;->this$0:Lcom/cyjh/elfin/fragment/content/LoadStateFragment;

    invoke-static {v0}, Lcom/cyjh/elfin/fragment/content/LoadStateFragment;->access$100(Lcom/cyjh/elfin/fragment/content/LoadStateFragment;)Landroid/view/View;

    move-result-object v0

    invoke-virtual {v0, v2}, Landroid/view/View;->setVisibility(I)V

    .line 36
    iget-object v0, p0, Lcom/cyjh/elfin/fragment/content/LoadStateFragment$1;->this$0:Lcom/cyjh/elfin/fragment/content/LoadStateFragment;

    iget-object v0, v0, Lcom/cyjh/elfin/fragment/content/LoadStateFragment;->mContentView:Landroid/view/View;

    invoke-virtual {v0, v1}, Landroid/view/View;->setVisibility(I)V

    .line 37
    iget-object v0, p0, Lcom/cyjh/elfin/fragment/content/LoadStateFragment$1;->this$0:Lcom/cyjh/elfin/fragment/content/LoadStateFragment;

    invoke-static {v0}, Lcom/cyjh/elfin/fragment/content/LoadStateFragment;->access$200(Lcom/cyjh/elfin/fragment/content/LoadStateFragment;)Landroid/view/View;

    move-result-object v0

    invoke-virtual {v0, v1}, Landroid/view/View;->setVisibility(I)V

    .line 38
    iget-object v0, p0, Lcom/cyjh/elfin/fragment/content/LoadStateFragment$1;->this$0:Lcom/cyjh/elfin/fragment/content/LoadStateFragment;

    invoke-static {v0}, Lcom/cyjh/elfin/fragment/content/LoadStateFragment;->access$300(Lcom/cyjh/elfin/fragment/content/LoadStateFragment;)Landroid/view/View;

    move-result-object v0

    invoke-virtual {v0, v1}, Landroid/view/View;->setVisibility(I)V

    goto :goto_0

    .line 41
    :pswitch_2
    iget-object v0, p0, Lcom/cyjh/elfin/fragment/content/LoadStateFragment$1;->this$0:Lcom/cyjh/elfin/fragment/content/LoadStateFragment;

    invoke-virtual {v0}, Lcom/cyjh/elfin/fragment/content/LoadStateFragment;->invalidateViews()V

    .line 42
    iget-object v0, p0, Lcom/cyjh/elfin/fragment/content/LoadStateFragment$1;->this$0:Lcom/cyjh/elfin/fragment/content/LoadStateFragment;

    invoke-static {v0}, Lcom/cyjh/elfin/fragment/content/LoadStateFragment;->access$000(Lcom/cyjh/elfin/fragment/content/LoadStateFragment;)Landroid/view/View;

    move-result-object v0

    invoke-virtual {v0, v1}, Landroid/view/View;->setVisibility(I)V

    .line 43
    iget-object v0, p0, Lcom/cyjh/elfin/fragment/content/LoadStateFragment$1;->this$0:Lcom/cyjh/elfin/fragment/content/LoadStateFragment;

    invoke-static {v0}, Lcom/cyjh/elfin/fragment/content/LoadStateFragment;->access$100(Lcom/cyjh/elfin/fragment/content/LoadStateFragment;)Landroid/view/View;

    move-result-object v0

    invoke-virtual {v0, v1}, Landroid/view/View;->setVisibility(I)V

    .line 44
    iget-object v0, p0, Lcom/cyjh/elfin/fragment/content/LoadStateFragment$1;->this$0:Lcom/cyjh/elfin/fragment/content/LoadStateFragment;

    iget-object v0, v0, Lcom/cyjh/elfin/fragment/content/LoadStateFragment;->mContentView:Landroid/view/View;

    invoke-virtual {v0, v2}, Landroid/view/View;->setVisibility(I)V

    .line 45
    iget-object v0, p0, Lcom/cyjh/elfin/fragment/content/LoadStateFragment$1;->this$0:Lcom/cyjh/elfin/fragment/content/LoadStateFragment;

    invoke-static {v0}, Lcom/cyjh/elfin/fragment/content/LoadStateFragment;->access$200(Lcom/cyjh/elfin/fragment/content/LoadStateFragment;)Landroid/view/View;

    move-result-object v0

    invoke-virtual {v0, v1}, Landroid/view/View;->setVisibility(I)V

    .line 46
    iget-object v0, p0, Lcom/cyjh/elfin/fragment/content/LoadStateFragment$1;->this$0:Lcom/cyjh/elfin/fragment/content/LoadStateFragment;

    invoke-static {v0}, Lcom/cyjh/elfin/fragment/content/LoadStateFragment;->access$300(Lcom/cyjh/elfin/fragment/content/LoadStateFragment;)Landroid/view/View;

    move-result-object v0

    invoke-virtual {v0, v1}, Landroid/view/View;->setVisibility(I)V

    goto/16 :goto_0

    .line 49
    :pswitch_3
    iget-object v0, p0, Lcom/cyjh/elfin/fragment/content/LoadStateFragment$1;->this$0:Lcom/cyjh/elfin/fragment/content/LoadStateFragment;

    invoke-static {v0}, Lcom/cyjh/elfin/fragment/content/LoadStateFragment;->access$000(Lcom/cyjh/elfin/fragment/content/LoadStateFragment;)Landroid/view/View;

    move-result-object v0

    invoke-virtual {v0, v2}, Landroid/view/View;->setVisibility(I)V

    .line 50
    iget-object v0, p0, Lcom/cyjh/elfin/fragment/content/LoadStateFragment$1;->this$0:Lcom/cyjh/elfin/fragment/content/LoadStateFragment;

    invoke-static {v0}, Lcom/cyjh/elfin/fragment/content/LoadStateFragment;->access$100(Lcom/cyjh/elfin/fragment/content/LoadStateFragment;)Landroid/view/View;

    move-result-object v0

    invoke-virtual {v0, v1}, Landroid/view/View;->setVisibility(I)V

    .line 51
    iget-object v0, p0, Lcom/cyjh/elfin/fragment/content/LoadStateFragment$1;->this$0:Lcom/cyjh/elfin/fragment/content/LoadStateFragment;

    iget-object v0, v0, Lcom/cyjh/elfin/fragment/content/LoadStateFragment;->mContentView:Landroid/view/View;

    invoke-virtual {v0, v1}, Landroid/view/View;->setVisibility(I)V

    .line 52
    iget-object v0, p0, Lcom/cyjh/elfin/fragment/content/LoadStateFragment$1;->this$0:Lcom/cyjh/elfin/fragment/content/LoadStateFragment;

    invoke-static {v0}, Lcom/cyjh/elfin/fragment/content/LoadStateFragment;->access$300(Lcom/cyjh/elfin/fragment/content/LoadStateFragment;)Landroid/view/View;

    move-result-object v0

    invoke-virtual {v0, v1}, Landroid/view/View;->setVisibility(I)V

    .line 53
    iget-object v0, p0, Lcom/cyjh/elfin/fragment/content/LoadStateFragment$1;->this$0:Lcom/cyjh/elfin/fragment/content/LoadStateFragment;

    invoke-static {v0}, Lcom/cyjh/elfin/fragment/content/LoadStateFragment;->access$200(Lcom/cyjh/elfin/fragment/content/LoadStateFragment;)Landroid/view/View;

    move-result-object v0

    invoke-virtual {v0, v1}, Landroid/view/View;->setVisibility(I)V

    goto/16 :goto_0

    .line 56
    :pswitch_4
    iget-object v0, p0, Lcom/cyjh/elfin/fragment/content/LoadStateFragment$1;->this$0:Lcom/cyjh/elfin/fragment/content/LoadStateFragment;

    invoke-static {v0}, Lcom/cyjh/elfin/fragment/content/LoadStateFragment;->access$000(Lcom/cyjh/elfin/fragment/content/LoadStateFragment;)Landroid/view/View;

    move-result-object v0

    invoke-virtual {v0, v1}, Landroid/view/View;->setVisibility(I)V

    .line 57
    iget-object v0, p0, Lcom/cyjh/elfin/fragment/content/LoadStateFragment$1;->this$0:Lcom/cyjh/elfin/fragment/content/LoadStateFragment;

    invoke-static {v0}, Lcom/cyjh/elfin/fragment/content/LoadStateFragment;->access$100(Lcom/cyjh/elfin/fragment/content/LoadStateFragment;)Landroid/view/View;

    move-result-object v0

    invoke-virtual {v0, v1}, Landroid/view/View;->setVisibility(I)V

    .line 58
    iget-object v0, p0, Lcom/cyjh/elfin/fragment/content/LoadStateFragment$1;->this$0:Lcom/cyjh/elfin/fragment/content/LoadStateFragment;

    iget-object v0, v0, Lcom/cyjh/elfin/fragment/content/LoadStateFragment;->mContentView:Landroid/view/View;

    invoke-virtual {v0, v1}, Landroid/view/View;->setVisibility(I)V

    .line 59
    iget-object v0, p0, Lcom/cyjh/elfin/fragment/content/LoadStateFragment$1;->this$0:Lcom/cyjh/elfin/fragment/content/LoadStateFragment;

    invoke-static {v0}, Lcom/cyjh/elfin/fragment/content/LoadStateFragment;->access$300(Lcom/cyjh/elfin/fragment/content/LoadStateFragment;)Landroid/view/View;

    move-result-object v0

    invoke-virtual {v0, v1}, Landroid/view/View;->setVisibility(I)V

    .line 60
    iget-object v0, p0, Lcom/cyjh/elfin/fragment/content/LoadStateFragment$1;->this$0:Lcom/cyjh/elfin/fragment/content/LoadStateFragment;

    invoke-static {v0}, Lcom/cyjh/elfin/fragment/content/LoadStateFragment;->access$200(Lcom/cyjh/elfin/fragment/content/LoadStateFragment;)Landroid/view/View;

    move-result-object v0

    invoke-virtual {v0, v2}, Landroid/view/View;->setVisibility(I)V

    goto/16 :goto_0

    .line 25
    nop

    :pswitch_data_0
    .packed-switch 0x0
        :pswitch_3
        :pswitch_0
        :pswitch_1
        :pswitch_2
        :pswitch_4
    .end packed-switch
.end method
