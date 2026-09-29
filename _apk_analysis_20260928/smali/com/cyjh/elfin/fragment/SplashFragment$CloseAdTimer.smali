.class Lcom/cyjh/elfin/fragment/SplashFragment$CloseAdTimer;
.super Lcom/cyjh/elfin/counttimer/SecondTimer;
.source "SplashFragment.java"


# annotations
.annotation system Ldalvik/annotation/EnclosingClass;
    value = Lcom/cyjh/elfin/fragment/SplashFragment;
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x0
    name = "CloseAdTimer"
.end annotation


# instance fields
.field final synthetic this$0:Lcom/cyjh/elfin/fragment/SplashFragment;


# direct methods
.method public constructor <init>(Lcom/cyjh/elfin/fragment/SplashFragment;I)V
    .locals 0
    .param p1, "this$0"    # Lcom/cyjh/elfin/fragment/SplashFragment;
    .param p2, "secondsInFuture"    # I

    .prologue
    .line 963
    iput-object p1, p0, Lcom/cyjh/elfin/fragment/SplashFragment$CloseAdTimer;->this$0:Lcom/cyjh/elfin/fragment/SplashFragment;

    .line 964
    invoke-direct {p0, p2}, Lcom/cyjh/elfin/counttimer/SecondTimer;-><init>(I)V

    .line 965
    return-void
.end method


# virtual methods
.method public onFinish()V
    .locals 2

    .prologue
    .line 972
    iget-object v0, p0, Lcom/cyjh/elfin/fragment/SplashFragment$CloseAdTimer;->this$0:Lcom/cyjh/elfin/fragment/SplashFragment;

    invoke-static {v0}, Lcom/cyjh/elfin/fragment/SplashFragment;->access$3100(Lcom/cyjh/elfin/fragment/SplashFragment;)Z

    move-result v0

    if-nez v0, :cond_0

    .line 973
    iget-object v0, p0, Lcom/cyjh/elfin/fragment/SplashFragment$CloseAdTimer;->this$0:Lcom/cyjh/elfin/fragment/SplashFragment;

    iget-object v0, v0, Lcom/cyjh/elfin/fragment/SplashFragment;->commonLog:Lcom/cyjh/elfin/log/CommonLog;

    const-string v1, "\u8baf\u98de\u5e7f\u544a\u663e\u793a\uff0c\u5f00\u59cb\u52a0\u8f7d\u540e\u53f0\u914d\u7f6e\u7684\u5e7f\u544a"

    invoke-virtual {v0, v1}, Lcom/cyjh/elfin/log/CommonLog;->e(Ljava/lang/Object;)V

    .line 974
    const-string v0, "zzz"

    const-string v1, "CloseAdTimer---\u8baf\u98de\u5e7f\u544a\u663e\u793a\uff0c\u5f00\u59cb\u52a0\u8f7d\u540e\u53f0\u914d\u7f6e\u7684\u5e7f\u544a"

    invoke-static {v0, v1}, Landroid/util/Log;->e(Ljava/lang/String;Ljava/lang/String;)I

    .line 975
    iget-object v0, p0, Lcom/cyjh/elfin/fragment/SplashFragment$CloseAdTimer;->this$0:Lcom/cyjh/elfin/fragment/SplashFragment;

    invoke-static {v0}, Lcom/cyjh/elfin/fragment/SplashFragment;->access$800(Lcom/cyjh/elfin/fragment/SplashFragment;)Landroid/os/Handler;

    move-result-object v0

    const/16 v1, 0xc

    invoke-virtual {v0, v1}, Landroid/os/Handler;->obtainMessage(I)Landroid/os/Message;

    move-result-object v0

    invoke-virtual {v0}, Landroid/os/Message;->sendToTarget()V

    .line 977
    :cond_0
    return-void
.end method

.method protected onTick(I)V
    .locals 1
    .param p1, "second"    # I

    .prologue
    .line 968
    iget-object v0, p0, Lcom/cyjh/elfin/fragment/SplashFragment$CloseAdTimer;->this$0:Lcom/cyjh/elfin/fragment/SplashFragment;

    invoke-static {v0}, Lcom/cyjh/elfin/fragment/SplashFragment;->access$1808(Lcom/cyjh/elfin/fragment/SplashFragment;)I

    .line 969
    return-void
.end method
