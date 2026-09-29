.class Lcom/cyjh/elfin/fragment/SplashFragment$2;
.super Ljava/lang/Object;
.source "SplashFragment.java"

# interfaces
.implements Landroid/view/View$OnClickListener;


# annotations
.annotation system Ldalvik/annotation/EnclosingMethod;
    value = Lcom/cyjh/elfin/fragment/SplashFragment;->initView(Landroid/view/View;)V
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x0
    name = null
.end annotation


# instance fields
.field final synthetic this$0:Lcom/cyjh/elfin/fragment/SplashFragment;


# direct methods
.method constructor <init>(Lcom/cyjh/elfin/fragment/SplashFragment;)V
    .locals 0
    .param p1, "this$0"    # Lcom/cyjh/elfin/fragment/SplashFragment;

    .prologue
    .line 399
    iput-object p1, p0, Lcom/cyjh/elfin/fragment/SplashFragment$2;->this$0:Lcom/cyjh/elfin/fragment/SplashFragment;

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method


# virtual methods
.method public onClick(Landroid/view/View;)V
    .locals 2
    .param p1, "v"    # Landroid/view/View;

    .prologue
    .line 402
    const-string v0, "zzz"

    const-string v1, "SplashFragment---mTvCloseAd.setOnClickListener---1"

    invoke-static {v0, v1}, Landroid/util/Log;->e(Ljava/lang/String;Ljava/lang/String;)I

    .line 403
    iget-object v0, p0, Lcom/cyjh/elfin/fragment/SplashFragment$2;->this$0:Lcom/cyjh/elfin/fragment/SplashFragment;

    invoke-static {v0}, Lcom/cyjh/elfin/fragment/SplashFragment;->access$1700(Lcom/cyjh/elfin/fragment/SplashFragment;)V

    .line 404
    iget-object v0, p0, Lcom/cyjh/elfin/fragment/SplashFragment$2;->this$0:Lcom/cyjh/elfin/fragment/SplashFragment;

    invoke-static {v0}, Lcom/cyjh/elfin/fragment/SplashFragment;->access$1800(Lcom/cyjh/elfin/fragment/SplashFragment;)I

    move-result v0

    const/4 v1, 0x4

    if-gt v0, v1, :cond_0

    .line 405
    const-string v0, "zzz"

    const-string v1, "SplashFragment---mTvCloseAd.setOnClickListener---2"

    invoke-static {v0, v1}, Landroid/util/Log;->e(Ljava/lang/String;Ljava/lang/String;)I

    .line 406
    iget-object v0, p0, Lcom/cyjh/elfin/fragment/SplashFragment$2;->this$0:Lcom/cyjh/elfin/fragment/SplashFragment;

    iget-object v1, p0, Lcom/cyjh/elfin/fragment/SplashFragment$2;->this$0:Lcom/cyjh/elfin/fragment/SplashFragment;

    invoke-static {v1}, Lcom/cyjh/elfin/fragment/SplashFragment;->access$900(Lcom/cyjh/elfin/fragment/SplashFragment;)Landroid/widget/ImageView;

    move-result-object v1

    invoke-static {v0, v1}, Lcom/cyjh/elfin/fragment/SplashFragment;->access$1900(Lcom/cyjh/elfin/fragment/SplashFragment;Landroid/view/View;)V

    .line 411
    :goto_0
    return-void

    .line 408
    :cond_0
    const-string v0, "zzz"

    const-string v1, "SplashFragment---mTvCloseAd.setOnClickListener---2"

    invoke-static {v0, v1}, Landroid/util/Log;->e(Ljava/lang/String;Ljava/lang/String;)I

    .line 409
    iget-object v0, p0, Lcom/cyjh/elfin/fragment/SplashFragment$2;->this$0:Lcom/cyjh/elfin/fragment/SplashFragment;

    invoke-static {v0}, Lcom/cyjh/elfin/fragment/SplashFragment;->access$800(Lcom/cyjh/elfin/fragment/SplashFragment;)Landroid/os/Handler;

    move-result-object v0

    const/16 v1, 0xc

    invoke-virtual {v0, v1}, Landroid/os/Handler;->obtainMessage(I)Landroid/os/Message;

    move-result-object v0

    invoke-virtual {v0}, Landroid/os/Message;->sendToTarget()V

    goto :goto_0
.end method
