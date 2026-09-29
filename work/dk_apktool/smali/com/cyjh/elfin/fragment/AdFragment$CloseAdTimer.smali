.class Lcom/cyjh/elfin/fragment/AdFragment$CloseAdTimer;
.super Lcom/cyjh/elfin/counttimer/SecondTimer;
.source "AdFragment.java"


# annotations
.annotation system Ldalvik/annotation/EnclosingClass;
    value = Lcom/cyjh/elfin/fragment/AdFragment;
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x0
    name = "CloseAdTimer"
.end annotation


# instance fields
.field final synthetic this$0:Lcom/cyjh/elfin/fragment/AdFragment;


# direct methods
.method public constructor <init>(Lcom/cyjh/elfin/fragment/AdFragment;I)V
    .locals 0
    .param p1, "this$0"    # Lcom/cyjh/elfin/fragment/AdFragment;
    .param p2, "secondsInFuture"    # I

    .prologue
    .line 456
    iput-object p1, p0, Lcom/cyjh/elfin/fragment/AdFragment$CloseAdTimer;->this$0:Lcom/cyjh/elfin/fragment/AdFragment;

    .line 457
    invoke-direct {p0, p2}, Lcom/cyjh/elfin/counttimer/SecondTimer;-><init>(I)V

    .line 458
    return-void
.end method


# virtual methods
.method public onFinish()V
    .locals 1

    .prologue
    .line 468
    iget-object v0, p0, Lcom/cyjh/elfin/fragment/AdFragment$CloseAdTimer;->this$0:Lcom/cyjh/elfin/fragment/AdFragment;

    invoke-static {v0}, Lcom/cyjh/elfin/fragment/AdFragment;->access$1400(Lcom/cyjh/elfin/fragment/AdFragment;)V

    .line 469
    return-void
.end method

.method protected onTick(I)V
    .locals 2
    .param p1, "second"    # I

    .prologue
    .line 461
    iget-object v0, p0, Lcom/cyjh/elfin/fragment/AdFragment$CloseAdTimer;->this$0:Lcom/cyjh/elfin/fragment/AdFragment;

    invoke-static {v0}, Lcom/cyjh/elfin/fragment/AdFragment;->access$1308(Lcom/cyjh/elfin/fragment/AdFragment;)I

    .line 462
    iget-object v0, p0, Lcom/cyjh/elfin/fragment/AdFragment$CloseAdTimer;->this$0:Lcom/cyjh/elfin/fragment/AdFragment;

    invoke-static {v0}, Lcom/cyjh/elfin/fragment/AdFragment;->access$1300(Lcom/cyjh/elfin/fragment/AdFragment;)I

    move-result v0

    const/16 v1, 0xa

    if-le v0, v1, :cond_0

    .line 463
    iget-object v0, p0, Lcom/cyjh/elfin/fragment/AdFragment$CloseAdTimer;->this$0:Lcom/cyjh/elfin/fragment/AdFragment;

    invoke-static {v0}, Lcom/cyjh/elfin/fragment/AdFragment;->access$1200(Lcom/cyjh/elfin/fragment/AdFragment;)V

    .line 465
    :cond_0
    return-void
.end method
