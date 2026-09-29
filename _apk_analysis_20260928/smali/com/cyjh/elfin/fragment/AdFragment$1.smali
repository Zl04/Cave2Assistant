.class Lcom/cyjh/elfin/fragment/AdFragment$1;
.super Ljava/lang/Object;
.source "AdFragment.java"

# interfaces
.implements Lcom/squareup/picasso/Callback;


# annotations
.annotation system Ldalvik/annotation/EnclosingMethod;
    value = Lcom/cyjh/elfin/fragment/AdFragment;->displayBackGroundAd()V
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x0
    name = null
.end annotation


# instance fields
.field final synthetic this$0:Lcom/cyjh/elfin/fragment/AdFragment;


# direct methods
.method constructor <init>(Lcom/cyjh/elfin/fragment/AdFragment;)V
    .locals 0
    .param p1, "this$0"    # Lcom/cyjh/elfin/fragment/AdFragment;

    .prologue
    .line 184
    iput-object p1, p0, Lcom/cyjh/elfin/fragment/AdFragment$1;->this$0:Lcom/cyjh/elfin/fragment/AdFragment;

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method


# virtual methods
.method public onError()V
    .locals 2

    .prologue
    .line 194
    const-string v0, "zzz"

    const-string v1, "displayBackGroundAd()---3"

    invoke-static {v0, v1}, Landroid/util/Log;->e(Ljava/lang/String;Ljava/lang/String;)I

    .line 195
    iget-object v0, p0, Lcom/cyjh/elfin/fragment/AdFragment$1;->this$0:Lcom/cyjh/elfin/fragment/AdFragment;

    invoke-static {v0}, Lcom/cyjh/elfin/fragment/AdFragment;->access$400(Lcom/cyjh/elfin/fragment/AdFragment;)V

    .line 196
    return-void
.end method

.method public onSuccess()V
    .locals 4

    .prologue
    .line 187
    const-string v0, "zzz"

    const-string v1, "displayBackGroundAd()---2"

    invoke-static {v0, v1}, Landroid/util/Log;->e(Ljava/lang/String;Ljava/lang/String;)I

    .line 188
    iget-object v0, p0, Lcom/cyjh/elfin/fragment/AdFragment$1;->this$0:Lcom/cyjh/elfin/fragment/AdFragment;

    invoke-static {v0}, Lcom/cyjh/elfin/fragment/AdFragment;->access$100(Lcom/cyjh/elfin/fragment/AdFragment;)Lcom/cyjh/elfin/mvp/managers/BackgroundSettingsAdStatistics;

    move-result-object v0

    iget-object v1, p0, Lcom/cyjh/elfin/fragment/AdFragment$1;->this$0:Lcom/cyjh/elfin/fragment/AdFragment;

    invoke-virtual {v1}, Lcom/cyjh/elfin/fragment/AdFragment;->getActivity()Landroid/support/v4/app/FragmentActivity;

    move-result-object v1

    iget-object v2, p0, Lcom/cyjh/elfin/fragment/AdFragment$1;->this$0:Lcom/cyjh/elfin/fragment/AdFragment;

    invoke-static {v2}, Lcom/cyjh/elfin/fragment/AdFragment;->access$000(Lcom/cyjh/elfin/fragment/AdFragment;)Ljava/lang/String;

    move-result-object v2

    const-string v3, "3"

    invoke-virtual {v0, v1, v2, v3}, Lcom/cyjh/elfin/mvp/managers/BackgroundSettingsAdStatistics;->backgroundStatisticsAdCount(Landroid/content/Context;Ljava/lang/String;Ljava/lang/String;)V

    .line 189
    iget-object v0, p0, Lcom/cyjh/elfin/fragment/AdFragment$1;->this$0:Lcom/cyjh/elfin/fragment/AdFragment;

    invoke-static {v0}, Lcom/cyjh/elfin/fragment/AdFragment;->access$200(Lcom/cyjh/elfin/fragment/AdFragment;)Landroid/widget/TextView;

    move-result-object v0

    const/4 v1, 0x0

    invoke-virtual {v0, v1}, Landroid/widget/TextView;->setVisibility(I)V

    .line 190
    iget-object v0, p0, Lcom/cyjh/elfin/fragment/AdFragment$1;->this$0:Lcom/cyjh/elfin/fragment/AdFragment;

    invoke-static {v0}, Lcom/cyjh/elfin/fragment/AdFragment;->access$300(Lcom/cyjh/elfin/fragment/AdFragment;)Lcom/cyjh/elfin/fragment/AdFragment$SubmitCountTimer;

    move-result-object v0

    invoke-virtual {v0}, Lcom/cyjh/elfin/fragment/AdFragment$SubmitCountTimer;->start()Landroid/os/CountDownTimer;

    .line 191
    return-void
.end method
