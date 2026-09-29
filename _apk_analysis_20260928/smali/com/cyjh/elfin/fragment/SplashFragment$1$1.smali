.class Lcom/cyjh/elfin/fragment/SplashFragment$1$1;
.super Ljava/lang/Object;
.source "SplashFragment.java"

# interfaces
.implements Lcom/squareup/picasso/Callback;


# annotations
.annotation system Ldalvik/annotation/EnclosingMethod;
    value = Lcom/cyjh/elfin/fragment/SplashFragment$1;->handleMessage(Landroid/os/Message;)V
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x0
    name = null
.end annotation


# instance fields
.field final synthetic this$1:Lcom/cyjh/elfin/fragment/SplashFragment$1;


# direct methods
.method constructor <init>(Lcom/cyjh/elfin/fragment/SplashFragment$1;)V
    .locals 0
    .param p1, "this$1"    # Lcom/cyjh/elfin/fragment/SplashFragment$1;

    .prologue
    .line 191
    iput-object p1, p0, Lcom/cyjh/elfin/fragment/SplashFragment$1$1;->this$1:Lcom/cyjh/elfin/fragment/SplashFragment$1;

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method


# virtual methods
.method public onError()V
    .locals 2

    .prologue
    .line 215
    const-string v0, "zzz"

    const-string v1, "SplashFragment---\u5f00\u5c4f\u5e7f\u544a\u5c55\u793a\u9519\u8bef"

    invoke-static {v0, v1}, Landroid/util/Log;->e(Ljava/lang/String;Ljava/lang/String;)I

    .line 217
    iget-object v0, p0, Lcom/cyjh/elfin/fragment/SplashFragment$1$1;->this$1:Lcom/cyjh/elfin/fragment/SplashFragment$1;

    iget-object v0, v0, Lcom/cyjh/elfin/fragment/SplashFragment$1;->this$0:Lcom/cyjh/elfin/fragment/SplashFragment;

    invoke-static {v0}, Lcom/cyjh/elfin/fragment/SplashFragment;->access$800(Lcom/cyjh/elfin/fragment/SplashFragment;)Landroid/os/Handler;

    move-result-object v0

    const/16 v1, 0xc

    invoke-virtual {v0, v1}, Landroid/os/Handler;->obtainMessage(I)Landroid/os/Message;

    move-result-object v0

    invoke-virtual {v0}, Landroid/os/Message;->sendToTarget()V

    .line 218
    return-void
.end method

.method public onSuccess()V
    .locals 4

    .prologue
    const/16 v2, 0x8

    .line 194
    iget-object v0, p0, Lcom/cyjh/elfin/fragment/SplashFragment$1$1;->this$1:Lcom/cyjh/elfin/fragment/SplashFragment$1;

    iget-object v0, v0, Lcom/cyjh/elfin/fragment/SplashFragment$1;->this$0:Lcom/cyjh/elfin/fragment/SplashFragment;

    invoke-static {v0}, Lcom/cyjh/elfin/fragment/SplashFragment;->access$1000(Lcom/cyjh/elfin/fragment/SplashFragment;)Landroid/widget/TextView;

    move-result-object v0

    const/4 v1, 0x0

    invoke-virtual {v0, v1}, Landroid/widget/TextView;->setVisibility(I)V

    .line 195
    iget-object v0, p0, Lcom/cyjh/elfin/fragment/SplashFragment$1$1;->this$1:Lcom/cyjh/elfin/fragment/SplashFragment$1;

    iget-object v0, v0, Lcom/cyjh/elfin/fragment/SplashFragment$1;->this$0:Lcom/cyjh/elfin/fragment/SplashFragment;

    invoke-static {v0}, Lcom/cyjh/elfin/fragment/SplashFragment;->access$1100(Lcom/cyjh/elfin/fragment/SplashFragment;)Landroid/widget/ImageView;

    move-result-object v0

    invoke-virtual {v0, v2}, Landroid/widget/ImageView;->setVisibility(I)V

    .line 196
    iget-object v0, p0, Lcom/cyjh/elfin/fragment/SplashFragment$1$1;->this$1:Lcom/cyjh/elfin/fragment/SplashFragment$1;

    iget-object v0, v0, Lcom/cyjh/elfin/fragment/SplashFragment$1;->this$0:Lcom/cyjh/elfin/fragment/SplashFragment;

    invoke-static {v0}, Lcom/cyjh/elfin/fragment/SplashFragment;->access$1200(Lcom/cyjh/elfin/fragment/SplashFragment;)Landroid/widget/RelativeLayout;

    move-result-object v0

    invoke-virtual {v0, v2}, Landroid/widget/RelativeLayout;->setVisibility(I)V

    .line 197
    iget-object v0, p0, Lcom/cyjh/elfin/fragment/SplashFragment$1$1;->this$1:Lcom/cyjh/elfin/fragment/SplashFragment$1;

    iget-object v0, v0, Lcom/cyjh/elfin/fragment/SplashFragment$1;->this$0:Lcom/cyjh/elfin/fragment/SplashFragment;

    invoke-static {v0}, Lcom/cyjh/elfin/fragment/SplashFragment;->access$1300(Lcom/cyjh/elfin/fragment/SplashFragment;)Lcom/cyjh/elfin/mvp/managers/BackgroundSettingsAdStatistics;

    move-result-object v0

    iget-object v1, p0, Lcom/cyjh/elfin/fragment/SplashFragment$1$1;->this$1:Lcom/cyjh/elfin/fragment/SplashFragment$1;

    iget-object v1, v1, Lcom/cyjh/elfin/fragment/SplashFragment$1;->this$0:Lcom/cyjh/elfin/fragment/SplashFragment;

    invoke-virtual {v1}, Lcom/cyjh/elfin/fragment/SplashFragment;->getActivity()Landroid/support/v4/app/FragmentActivity;

    move-result-object v1

    iget-object v2, p0, Lcom/cyjh/elfin/fragment/SplashFragment$1$1;->this$1:Lcom/cyjh/elfin/fragment/SplashFragment$1;

    iget-object v2, v2, Lcom/cyjh/elfin/fragment/SplashFragment$1;->this$0:Lcom/cyjh/elfin/fragment/SplashFragment;

    invoke-static {v2}, Lcom/cyjh/elfin/fragment/SplashFragment;->access$700(Lcom/cyjh/elfin/fragment/SplashFragment;)Lcom/cyjh/elfin/entity/Ad$DataBean;

    move-result-object v2

    iget-object v2, v2, Lcom/cyjh/elfin/entity/Ad$DataBean;->Id:Ljava/lang/String;

    const-string v3, "3"

    invoke-virtual {v0, v1, v2, v3}, Lcom/cyjh/elfin/mvp/managers/BackgroundSettingsAdStatistics;->backgroundStatisticsAdCount(Landroid/content/Context;Ljava/lang/String;Ljava/lang/String;)V

    .line 199
    iget-object v0, p0, Lcom/cyjh/elfin/fragment/SplashFragment$1$1;->this$1:Lcom/cyjh/elfin/fragment/SplashFragment$1;

    iget-object v0, v0, Lcom/cyjh/elfin/fragment/SplashFragment$1;->this$0:Lcom/cyjh/elfin/fragment/SplashFragment;

    const/4 v1, 0x1

    invoke-static {v0, v1}, Lcom/cyjh/elfin/fragment/SplashFragment;->access$1402(Lcom/cyjh/elfin/fragment/SplashFragment;Z)Z

    .line 200
    iget-object v0, p0, Lcom/cyjh/elfin/fragment/SplashFragment$1$1;->this$1:Lcom/cyjh/elfin/fragment/SplashFragment$1;

    iget-object v0, v0, Lcom/cyjh/elfin/fragment/SplashFragment$1;->this$0:Lcom/cyjh/elfin/fragment/SplashFragment;

    invoke-static {v0}, Lcom/cyjh/elfin/fragment/SplashFragment;->access$900(Lcom/cyjh/elfin/fragment/SplashFragment;)Landroid/widget/ImageView;

    move-result-object v0

    iget-object v1, p0, Lcom/cyjh/elfin/fragment/SplashFragment$1$1;->this$1:Lcom/cyjh/elfin/fragment/SplashFragment$1;

    iget-object v1, v1, Lcom/cyjh/elfin/fragment/SplashFragment$1;->this$0:Lcom/cyjh/elfin/fragment/SplashFragment;

    invoke-static {v1}, Lcom/cyjh/elfin/fragment/SplashFragment;->access$1500(Lcom/cyjh/elfin/fragment/SplashFragment;)Landroid/view/View$OnClickListener;

    move-result-object v1

    invoke-virtual {v0, v1}, Landroid/widget/ImageView;->setOnClickListener(Landroid/view/View$OnClickListener;)V

    .line 210
    iget-object v0, p0, Lcom/cyjh/elfin/fragment/SplashFragment$1$1;->this$1:Lcom/cyjh/elfin/fragment/SplashFragment$1;

    iget-object v0, v0, Lcom/cyjh/elfin/fragment/SplashFragment$1;->this$0:Lcom/cyjh/elfin/fragment/SplashFragment;

    invoke-static {v0}, Lcom/cyjh/elfin/fragment/SplashFragment;->access$1600(Lcom/cyjh/elfin/fragment/SplashFragment;)V

    .line 211
    return-void
.end method
