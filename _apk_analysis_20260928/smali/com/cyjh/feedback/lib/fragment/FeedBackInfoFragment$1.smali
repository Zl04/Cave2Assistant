.class Lcom/cyjh/feedback/lib/fragment/FeedBackInfoFragment$1;
.super Ljava/lang/Object;
.source "FeedBackInfoFragment.java"

# interfaces
.implements Lcom/cyjh/feedback/lib/dialog/FeedBackDialog$OnResultCode;


# annotations
.annotation system Ldalvik/annotation/EnclosingMethod;
    value = Lcom/cyjh/feedback/lib/fragment/FeedBackInfoFragment;->showFeedbackDialog()V
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
    .line 148
    iput-object p1, p0, Lcom/cyjh/feedback/lib/fragment/FeedBackInfoFragment$1;->this$0:Lcom/cyjh/feedback/lib/fragment/FeedBackInfoFragment;

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method


# virtual methods
.method public getResultCode(I)V
    .locals 3
    .param p1, "code"    # I

    .prologue
    const/4 v2, 0x0

    .line 151
    new-instance v0, Ljava/lang/StringBuilder;

    invoke-direct {v0}, Ljava/lang/StringBuilder;-><init>()V

    const-string v1, "code:"

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-virtual {v0, p1}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-virtual {v0}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v0

    new-array v1, v2, [Ljava/lang/Object;

    invoke-static {v0, v1}, Lcom/orhanobut/logger/Logger;->e(Ljava/lang/String;[Ljava/lang/Object;)V

    .line 153
    const/4 v0, 0x1

    if-ne p1, v0, :cond_0

    .line 154
    iget-object v0, p0, Lcom/cyjh/feedback/lib/fragment/FeedBackInfoFragment$1;->this$0:Lcom/cyjh/feedback/lib/fragment/FeedBackInfoFragment;

    invoke-virtual {v0}, Lcom/cyjh/feedback/lib/fragment/FeedBackInfoFragment;->getActivity()Landroid/support/v4/app/FragmentActivity;

    move-result-object v0

    const/4 v1, -0x1

    invoke-virtual {v0, v1}, Landroid/support/v4/app/FragmentActivity;->setResult(I)V

    .line 158
    :goto_0
    iget-object v0, p0, Lcom/cyjh/feedback/lib/fragment/FeedBackInfoFragment$1;->this$0:Lcom/cyjh/feedback/lib/fragment/FeedBackInfoFragment;

    invoke-virtual {v0}, Lcom/cyjh/feedback/lib/fragment/FeedBackInfoFragment;->getActivity()Landroid/support/v4/app/FragmentActivity;

    move-result-object v0

    invoke-virtual {v0}, Landroid/support/v4/app/FragmentActivity;->finish()V

    .line 159
    return-void

    .line 156
    :cond_0
    iget-object v0, p0, Lcom/cyjh/feedback/lib/fragment/FeedBackInfoFragment$1;->this$0:Lcom/cyjh/feedback/lib/fragment/FeedBackInfoFragment;

    invoke-virtual {v0}, Lcom/cyjh/feedback/lib/fragment/FeedBackInfoFragment;->getActivity()Landroid/support/v4/app/FragmentActivity;

    move-result-object v0

    invoke-virtual {v0, v2}, Landroid/support/v4/app/FragmentActivity;->setResult(I)V

    goto :goto_0
.end method
