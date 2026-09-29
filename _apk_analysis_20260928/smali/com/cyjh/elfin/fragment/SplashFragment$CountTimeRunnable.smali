.class Lcom/cyjh/elfin/fragment/SplashFragment$CountTimeRunnable;
.super Ljava/lang/Object;
.source "SplashFragment.java"

# interfaces
.implements Ljava/lang/Runnable;


# annotations
.annotation system Ldalvik/annotation/EnclosingClass;
    value = Lcom/cyjh/elfin/fragment/SplashFragment;
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x0
    name = "CountTimeRunnable"
.end annotation


# instance fields
.field final synthetic this$0:Lcom/cyjh/elfin/fragment/SplashFragment;


# direct methods
.method constructor <init>(Lcom/cyjh/elfin/fragment/SplashFragment;)V
    .locals 0
    .param p1, "this$0"    # Lcom/cyjh/elfin/fragment/SplashFragment;

    .prologue
    .line 937
    iput-object p1, p0, Lcom/cyjh/elfin/fragment/SplashFragment$CountTimeRunnable;->this$0:Lcom/cyjh/elfin/fragment/SplashFragment;

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method


# virtual methods
.method public onStart()V
    .locals 4

    .prologue
    .line 939
    iget-object v0, p0, Lcom/cyjh/elfin/fragment/SplashFragment$CountTimeRunnable;->this$0:Lcom/cyjh/elfin/fragment/SplashFragment;

    invoke-static {v0}, Lcom/cyjh/elfin/fragment/SplashFragment;->access$800(Lcom/cyjh/elfin/fragment/SplashFragment;)Landroid/os/Handler;

    move-result-object v0

    invoke-virtual {v0, p0}, Landroid/os/Handler;->removeCallbacks(Ljava/lang/Runnable;)V

    .line 940
    iget-object v0, p0, Lcom/cyjh/elfin/fragment/SplashFragment$CountTimeRunnable;->this$0:Lcom/cyjh/elfin/fragment/SplashFragment;

    invoke-static {v0}, Lcom/cyjh/elfin/fragment/SplashFragment;->access$800(Lcom/cyjh/elfin/fragment/SplashFragment;)Landroid/os/Handler;

    move-result-object v0

    const-wide/16 v2, 0x3e8

    invoke-virtual {v0, p0, v2, v3}, Landroid/os/Handler;->postDelayed(Ljava/lang/Runnable;J)Z

    .line 941
    return-void
.end method

.method public run()V
    .locals 4

    .prologue
    .line 944
    iget-object v0, p0, Lcom/cyjh/elfin/fragment/SplashFragment$CountTimeRunnable;->this$0:Lcom/cyjh/elfin/fragment/SplashFragment;

    invoke-static {v0}, Lcom/cyjh/elfin/fragment/SplashFragment;->access$3008(Lcom/cyjh/elfin/fragment/SplashFragment;)I

    .line 945
    const-string v0, "zzz"

    new-instance v1, Ljava/lang/StringBuilder;

    invoke-direct {v1}, Ljava/lang/StringBuilder;-><init>()V

    const-string v2, "CountTimeRunnable--countTimeAdd="

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    iget-object v2, p0, Lcom/cyjh/elfin/fragment/SplashFragment$CountTimeRunnable;->this$0:Lcom/cyjh/elfin/fragment/SplashFragment;

    invoke-static {v2}, Lcom/cyjh/elfin/fragment/SplashFragment;->access$3000(Lcom/cyjh/elfin/fragment/SplashFragment;)I

    move-result v2

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v1

    invoke-static {v0, v1}, Landroid/util/Log;->e(Ljava/lang/String;Ljava/lang/String;)I

    .line 946
    iget-object v0, p0, Lcom/cyjh/elfin/fragment/SplashFragment$CountTimeRunnable;->this$0:Lcom/cyjh/elfin/fragment/SplashFragment;

    iget-object v0, v0, Lcom/cyjh/elfin/fragment/SplashFragment;->commonLog:Lcom/cyjh/elfin/log/CommonLog;

    new-instance v1, Ljava/lang/StringBuilder;

    invoke-direct {v1}, Ljava/lang/StringBuilder;-><init>()V

    const-string v2, "countTimeAdd="

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    iget-object v2, p0, Lcom/cyjh/elfin/fragment/SplashFragment$CountTimeRunnable;->this$0:Lcom/cyjh/elfin/fragment/SplashFragment;

    invoke-static {v2}, Lcom/cyjh/elfin/fragment/SplashFragment;->access$3000(Lcom/cyjh/elfin/fragment/SplashFragment;)I

    move-result v2

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v1

    invoke-virtual {v0, v1}, Lcom/cyjh/elfin/log/CommonLog;->e(Ljava/lang/Object;)V

    .line 947
    iget-object v0, p0, Lcom/cyjh/elfin/fragment/SplashFragment$CountTimeRunnable;->this$0:Lcom/cyjh/elfin/fragment/SplashFragment;

    invoke-static {v0}, Lcom/cyjh/elfin/fragment/SplashFragment;->access$3000(Lcom/cyjh/elfin/fragment/SplashFragment;)I

    move-result v0

    const/16 v1, 0xa

    if-lt v0, v1, :cond_0

    .line 948
    iget-object v0, p0, Lcom/cyjh/elfin/fragment/SplashFragment$CountTimeRunnable;->this$0:Lcom/cyjh/elfin/fragment/SplashFragment;

    invoke-static {v0}, Lcom/cyjh/elfin/fragment/SplashFragment;->access$800(Lcom/cyjh/elfin/fragment/SplashFragment;)Landroid/os/Handler;

    move-result-object v0

    invoke-virtual {v0, p0}, Landroid/os/Handler;->removeCallbacks(Ljava/lang/Runnable;)V

    .line 949
    iget-object v0, p0, Lcom/cyjh/elfin/fragment/SplashFragment$CountTimeRunnable;->this$0:Lcom/cyjh/elfin/fragment/SplashFragment;

    iget-object v0, v0, Lcom/cyjh/elfin/fragment/SplashFragment;->commonLog:Lcom/cyjh/elfin/log/CommonLog;

    new-instance v1, Ljava/lang/StringBuilder;

    invoke-direct {v1}, Ljava/lang/StringBuilder;-><init>()V

    const-string v2, "countTimeAdd=\u65f6\u95f4\u5230\u4e86\uff1a"

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    iget-object v2, p0, Lcom/cyjh/elfin/fragment/SplashFragment$CountTimeRunnable;->this$0:Lcom/cyjh/elfin/fragment/SplashFragment;

    invoke-static {v2}, Lcom/cyjh/elfin/fragment/SplashFragment;->access$3000(Lcom/cyjh/elfin/fragment/SplashFragment;)I

    move-result v2

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v1

    invoke-virtual {v0, v1}, Lcom/cyjh/elfin/log/CommonLog;->e(Ljava/lang/Object;)V

    .line 950
    const-string v0, "zzz"

    new-instance v1, Ljava/lang/StringBuilder;

    invoke-direct {v1}, Ljava/lang/StringBuilder;-><init>()V

    const-string v2, "CountTimeRunnable--countTimeAdd=\u65f6\u95f4\u5230\u4e86"

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    iget-object v2, p0, Lcom/cyjh/elfin/fragment/SplashFragment$CountTimeRunnable;->this$0:Lcom/cyjh/elfin/fragment/SplashFragment;

    invoke-static {v2}, Lcom/cyjh/elfin/fragment/SplashFragment;->access$3000(Lcom/cyjh/elfin/fragment/SplashFragment;)I

    move-result v2

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v1

    invoke-static {v0, v1}, Landroid/util/Log;->e(Ljava/lang/String;Ljava/lang/String;)I

    .line 951
    iget-object v0, p0, Lcom/cyjh/elfin/fragment/SplashFragment$CountTimeRunnable;->this$0:Lcom/cyjh/elfin/fragment/SplashFragment;

    invoke-static {v0}, Lcom/cyjh/elfin/fragment/SplashFragment;->access$800(Lcom/cyjh/elfin/fragment/SplashFragment;)Landroid/os/Handler;

    move-result-object v0

    const/16 v1, 0xc

    invoke-virtual {v0, v1}, Landroid/os/Handler;->obtainMessage(I)Landroid/os/Message;

    move-result-object v0

    invoke-virtual {v0}, Landroid/os/Message;->sendToTarget()V

    .line 956
    :goto_0
    return-void

    .line 953
    :cond_0
    iget-object v0, p0, Lcom/cyjh/elfin/fragment/SplashFragment$CountTimeRunnable;->this$0:Lcom/cyjh/elfin/fragment/SplashFragment;

    invoke-static {v0}, Lcom/cyjh/elfin/fragment/SplashFragment;->access$800(Lcom/cyjh/elfin/fragment/SplashFragment;)Landroid/os/Handler;

    move-result-object v0

    invoke-virtual {v0, p0}, Landroid/os/Handler;->removeCallbacks(Ljava/lang/Runnable;)V

    .line 954
    iget-object v0, p0, Lcom/cyjh/elfin/fragment/SplashFragment$CountTimeRunnable;->this$0:Lcom/cyjh/elfin/fragment/SplashFragment;

    invoke-static {v0}, Lcom/cyjh/elfin/fragment/SplashFragment;->access$800(Lcom/cyjh/elfin/fragment/SplashFragment;)Landroid/os/Handler;

    move-result-object v0

    const-wide/16 v2, 0x3e8

    invoke-virtual {v0, p0, v2, v3}, Landroid/os/Handler;->postDelayed(Ljava/lang/Runnable;J)Z

    goto :goto_0
.end method
