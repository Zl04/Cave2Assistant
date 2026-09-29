.class Lcom/cyjh/elfin/fragment/OptionFragment$1;
.super Ljava/lang/Object;
.source "OptionFragment.java"

# interfaces
.implements Lcom/squareup/picasso/Callback;


# annotations
.annotation system Ldalvik/annotation/EnclosingMethod;
    value = Lcom/cyjh/elfin/fragment/OptionFragment;->showAdToBackstage(Lcom/cyjh/elfin/entity/Ad;)V
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x0
    name = null
.end annotation


# instance fields
.field final synthetic this$0:Lcom/cyjh/elfin/fragment/OptionFragment;

.field final synthetic val$dataBean:Lcom/cyjh/elfin/entity/Ad$DataBean;


# direct methods
.method constructor <init>(Lcom/cyjh/elfin/fragment/OptionFragment;Lcom/cyjh/elfin/entity/Ad$DataBean;)V
    .locals 0
    .param p1, "this$0"    # Lcom/cyjh/elfin/fragment/OptionFragment;

    .prologue
    .line 480
    iput-object p1, p0, Lcom/cyjh/elfin/fragment/OptionFragment$1;->this$0:Lcom/cyjh/elfin/fragment/OptionFragment;

    iput-object p2, p0, Lcom/cyjh/elfin/fragment/OptionFragment$1;->val$dataBean:Lcom/cyjh/elfin/entity/Ad$DataBean;

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method


# virtual methods
.method public onError()V
    .locals 2

    .prologue
    .line 492
    iget-object v0, p0, Lcom/cyjh/elfin/fragment/OptionFragment$1;->this$0:Lcom/cyjh/elfin/fragment/OptionFragment;

    invoke-static {v0}, Lcom/cyjh/elfin/fragment/OptionFragment;->access$300(Lcom/cyjh/elfin/fragment/OptionFragment;)Landroid/widget/RelativeLayout;

    move-result-object v0

    const/4 v1, 0x0

    invoke-virtual {v0, v1}, Landroid/widget/RelativeLayout;->setVisibility(I)V

    .line 493
    iget-object v0, p0, Lcom/cyjh/elfin/fragment/OptionFragment$1;->this$0:Lcom/cyjh/elfin/fragment/OptionFragment;

    invoke-static {v0}, Lcom/cyjh/elfin/fragment/OptionFragment;->access$200(Lcom/cyjh/elfin/fragment/OptionFragment;)Landroid/widget/RelativeLayout;

    move-result-object v0

    const/16 v1, 0x8

    invoke-virtual {v0, v1}, Landroid/widget/RelativeLayout;->setVisibility(I)V

    .line 494
    return-void
.end method

.method public onSuccess()V
    .locals 4

    .prologue
    .line 483
    iget-object v0, p0, Lcom/cyjh/elfin/fragment/OptionFragment$1;->this$0:Lcom/cyjh/elfin/fragment/OptionFragment;

    invoke-static {v0}, Lcom/cyjh/elfin/fragment/OptionFragment;->access$100(Lcom/cyjh/elfin/fragment/OptionFragment;)V

    .line 484
    iget-object v0, p0, Lcom/cyjh/elfin/fragment/OptionFragment$1;->this$0:Lcom/cyjh/elfin/fragment/OptionFragment;

    invoke-static {v0}, Lcom/cyjh/elfin/fragment/OptionFragment;->access$200(Lcom/cyjh/elfin/fragment/OptionFragment;)Landroid/widget/RelativeLayout;

    move-result-object v0

    const/4 v1, 0x0

    invoke-virtual {v0, v1}, Landroid/widget/RelativeLayout;->setVisibility(I)V

    .line 485
    iget-object v0, p0, Lcom/cyjh/elfin/fragment/OptionFragment$1;->this$0:Lcom/cyjh/elfin/fragment/OptionFragment;

    invoke-static {v0}, Lcom/cyjh/elfin/fragment/OptionFragment;->access$300(Lcom/cyjh/elfin/fragment/OptionFragment;)Landroid/widget/RelativeLayout;

    move-result-object v0

    const/16 v1, 0x8

    invoke-virtual {v0, v1}, Landroid/widget/RelativeLayout;->setVisibility(I)V

    .line 487
    iget-object v0, p0, Lcom/cyjh/elfin/fragment/OptionFragment$1;->this$0:Lcom/cyjh/elfin/fragment/OptionFragment;

    invoke-static {v0}, Lcom/cyjh/elfin/fragment/OptionFragment;->access$400(Lcom/cyjh/elfin/fragment/OptionFragment;)Lcom/cyjh/elfin/mvp/managers/BackgroundSettingsAdStatistics;

    move-result-object v0

    iget-object v1, p0, Lcom/cyjh/elfin/fragment/OptionFragment$1;->this$0:Lcom/cyjh/elfin/fragment/OptionFragment;

    invoke-virtual {v1}, Lcom/cyjh/elfin/fragment/OptionFragment;->getActivity()Landroid/support/v4/app/FragmentActivity;

    move-result-object v1

    iget-object v2, p0, Lcom/cyjh/elfin/fragment/OptionFragment$1;->val$dataBean:Lcom/cyjh/elfin/entity/Ad$DataBean;

    iget-object v2, v2, Lcom/cyjh/elfin/entity/Ad$DataBean;->Id:Ljava/lang/String;

    const-string v3, "3"

    invoke-virtual {v0, v1, v2, v3}, Lcom/cyjh/elfin/mvp/managers/BackgroundSettingsAdStatistics;->backgroundStatisticsAdCount(Landroid/content/Context;Ljava/lang/String;Ljava/lang/String;)V

    .line 489
    return-void
.end method
