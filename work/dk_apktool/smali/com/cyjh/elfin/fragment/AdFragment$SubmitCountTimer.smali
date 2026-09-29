.class Lcom/cyjh/elfin/fragment/AdFragment$SubmitCountTimer;
.super Lcom/cyjh/elfin/counttimer/SecondTimer;
.source "AdFragment.java"


# annotations
.annotation system Ldalvik/annotation/EnclosingClass;
    value = Lcom/cyjh/elfin/fragment/AdFragment;
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x0
    name = "SubmitCountTimer"
.end annotation


# instance fields
.field final synthetic this$0:Lcom/cyjh/elfin/fragment/AdFragment;


# direct methods
.method public constructor <init>(Lcom/cyjh/elfin/fragment/AdFragment;I)V
    .locals 0
    .param p1, "this$0"    # Lcom/cyjh/elfin/fragment/AdFragment;
    .param p2, "secondsInFuture"    # I

    .prologue
    .line 375
    iput-object p1, p0, Lcom/cyjh/elfin/fragment/AdFragment$SubmitCountTimer;->this$0:Lcom/cyjh/elfin/fragment/AdFragment;

    .line 376
    invoke-direct {p0, p2}, Lcom/cyjh/elfin/counttimer/SecondTimer;-><init>(I)V

    .line 377
    return-void
.end method


# virtual methods
.method public onFinish()V
    .locals 2

    .prologue
    .line 390
    const-string v0, "zzz"

    const-string v1, "AdFragment--onFinish"

    invoke-static {v0, v1}, Landroid/util/Log;->e(Ljava/lang/String;Ljava/lang/String;)I

    .line 391
    iget-object v0, p0, Lcom/cyjh/elfin/fragment/AdFragment$SubmitCountTimer;->this$0:Lcom/cyjh/elfin/fragment/AdFragment;

    invoke-static {v0}, Lcom/cyjh/elfin/fragment/AdFragment;->access$400(Lcom/cyjh/elfin/fragment/AdFragment;)V

    .line 392
    return-void
.end method

.method protected onTick(I)V
    .locals 6
    .param p1, "second"    # I

    .prologue
    .line 381
    iget-object v0, p0, Lcom/cyjh/elfin/fragment/AdFragment$SubmitCountTimer;->this$0:Lcom/cyjh/elfin/fragment/AdFragment;

    invoke-static {v0}, Lcom/cyjh/elfin/fragment/AdFragment;->access$508(Lcom/cyjh/elfin/fragment/AdFragment;)I

    .line 382
    const-string v0, "zzz"

    new-instance v1, Ljava/lang/StringBuilder;

    invoke-direct {v1}, Ljava/lang/StringBuilder;-><init>()V

    const-string v2, "AdFragment--onTick"

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    iget-object v2, p0, Lcom/cyjh/elfin/fragment/AdFragment$SubmitCountTimer;->this$0:Lcom/cyjh/elfin/fragment/AdFragment;

    invoke-static {v2}, Lcom/cyjh/elfin/fragment/AdFragment;->access$500(Lcom/cyjh/elfin/fragment/AdFragment;)I

    move-result v2

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v1

    invoke-static {v0, v1}, Landroid/util/Log;->e(Ljava/lang/String;Ljava/lang/String;)I

    .line 383
    iget-object v0, p0, Lcom/cyjh/elfin/fragment/AdFragment$SubmitCountTimer;->this$0:Lcom/cyjh/elfin/fragment/AdFragment;

    invoke-virtual {v0}, Lcom/cyjh/elfin/fragment/AdFragment;->isAdded()Z

    move-result v0

    if-eqz v0, :cond_0

    .line 384
    iget-object v0, p0, Lcom/cyjh/elfin/fragment/AdFragment$SubmitCountTimer;->this$0:Lcom/cyjh/elfin/fragment/AdFragment;

    invoke-static {v0}, Lcom/cyjh/elfin/fragment/AdFragment;->access$200(Lcom/cyjh/elfin/fragment/AdFragment;)Landroid/widget/TextView;

    move-result-object v0

    iget-object v1, p0, Lcom/cyjh/elfin/fragment/AdFragment$SubmitCountTimer;->this$0:Lcom/cyjh/elfin/fragment/AdFragment;

    const v2, 0x7f08004a

    const/4 v3, 0x1

    new-array v3, v3, [Ljava/lang/Object;

    const/4 v4, 0x0

    invoke-static {p1}, Ljava/lang/Integer;->valueOf(I)Ljava/lang/Integer;

    move-result-object v5

    aput-object v5, v3, v4

    invoke-virtual {v1, v2, v3}, Lcom/cyjh/elfin/fragment/AdFragment;->getString(I[Ljava/lang/Object;)Ljava/lang/String;

    move-result-object v1

    invoke-virtual {v0, v1}, Landroid/widget/TextView;->setText(Ljava/lang/CharSequence;)V

    .line 386
    :cond_0
    return-void
.end method
