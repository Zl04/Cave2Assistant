.class Lcom/cyjh/elfin/AppContext$BlackListCountTimeRunnable;
.super Ljava/lang/Object;
.source "AppContext.java"

# interfaces
.implements Ljava/lang/Runnable;


# annotations
.annotation system Ldalvik/annotation/EnclosingClass;
    value = Lcom/cyjh/elfin/AppContext;
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x0
    name = "BlackListCountTimeRunnable"
.end annotation


# instance fields
.field final synthetic this$0:Lcom/cyjh/elfin/AppContext;


# direct methods
.method constructor <init>(Lcom/cyjh/elfin/AppContext;)V
    .locals 0
    .param p1, "this$0"    # Lcom/cyjh/elfin/AppContext;

    .prologue
    .line 775
    iput-object p1, p0, Lcom/cyjh/elfin/AppContext$BlackListCountTimeRunnable;->this$0:Lcom/cyjh/elfin/AppContext;

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method


# virtual methods
.method public onStart()V
    .locals 4

    .prologue
    .line 777
    iget-object v0, p0, Lcom/cyjh/elfin/AppContext$BlackListCountTimeRunnable;->this$0:Lcom/cyjh/elfin/AppContext;

    invoke-static {v0}, Lcom/cyjh/elfin/AppContext;->access$100(Lcom/cyjh/elfin/AppContext;)Landroid/os/Handler;

    move-result-object v0

    invoke-virtual {v0, p0}, Landroid/os/Handler;->removeCallbacks(Ljava/lang/Runnable;)V

    .line 778
    iget-object v0, p0, Lcom/cyjh/elfin/AppContext$BlackListCountTimeRunnable;->this$0:Lcom/cyjh/elfin/AppContext;

    invoke-static {v0}, Lcom/cyjh/elfin/AppContext;->access$100(Lcom/cyjh/elfin/AppContext;)Landroid/os/Handler;

    move-result-object v0

    const-wide/16 v2, 0x7530

    invoke-virtual {v0, p0, v2, v3}, Landroid/os/Handler;->postDelayed(Ljava/lang/Runnable;J)Z

    .line 779
    return-void
.end method

.method public run()V
    .locals 4

    .prologue
    .line 782
    iget-object v0, p0, Lcom/cyjh/elfin/AppContext$BlackListCountTimeRunnable;->this$0:Lcom/cyjh/elfin/AppContext;

    invoke-static {v0}, Lcom/cyjh/elfin/AppContext;->access$208(Lcom/cyjh/elfin/AppContext;)I

    .line 783
    iget-object v0, p0, Lcom/cyjh/elfin/AppContext$BlackListCountTimeRunnable;->this$0:Lcom/cyjh/elfin/AppContext;

    iget-object v0, v0, Lcom/cyjh/elfin/AppContext;->commonLog:Lcom/cyjh/elfin/log/CommonLog;

    new-instance v1, Ljava/lang/StringBuilder;

    invoke-direct {v1}, Ljava/lang/StringBuilder;-><init>()V

    const-string v2, "AppContext countTimeAdd="

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    iget-object v2, p0, Lcom/cyjh/elfin/AppContext$BlackListCountTimeRunnable;->this$0:Lcom/cyjh/elfin/AppContext;

    invoke-static {v2}, Lcom/cyjh/elfin/AppContext;->access$200(Lcom/cyjh/elfin/AppContext;)I

    move-result v2

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v1

    invoke-virtual {v0, v1}, Lcom/cyjh/elfin/log/CommonLog;->e(Ljava/lang/Object;)V

    .line 784
    iget-object v0, p0, Lcom/cyjh/elfin/AppContext$BlackListCountTimeRunnable;->this$0:Lcom/cyjh/elfin/AppContext;

    invoke-static {v0}, Lcom/cyjh/elfin/AppContext;->access$200(Lcom/cyjh/elfin/AppContext;)I

    move-result v0

    iget-object v1, p0, Lcom/cyjh/elfin/AppContext$BlackListCountTimeRunnable;->this$0:Lcom/cyjh/elfin/AppContext;

    invoke-static {v1}, Lcom/cyjh/elfin/AppContext;->access$300(Lcom/cyjh/elfin/AppContext;)I

    move-result v1

    if-lt v0, v1, :cond_1

    .line 785
    iget-object v0, p0, Lcom/cyjh/elfin/AppContext$BlackListCountTimeRunnable;->this$0:Lcom/cyjh/elfin/AppContext;

    invoke-static {v0}, Lcom/cyjh/elfin/AppContext;->access$100(Lcom/cyjh/elfin/AppContext;)Landroid/os/Handler;

    move-result-object v0

    invoke-virtual {v0, p0}, Landroid/os/Handler;->removeCallbacks(Ljava/lang/Runnable;)V

    .line 786
    iget-object v0, p0, Lcom/cyjh/elfin/AppContext$BlackListCountTimeRunnable;->this$0:Lcom/cyjh/elfin/AppContext;

    iget-object v0, v0, Lcom/cyjh/elfin/AppContext;->commonLog:Lcom/cyjh/elfin/log/CommonLog;

    new-instance v1, Ljava/lang/StringBuilder;

    invoke-direct {v1}, Ljava/lang/StringBuilder;-><init>()V

    const-string v2, "countTimeAdd=\u65f6\u95f4\u5230\u4e86\uff1a"

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    iget-object v2, p0, Lcom/cyjh/elfin/AppContext$BlackListCountTimeRunnable;->this$0:Lcom/cyjh/elfin/AppContext;

    invoke-static {v2}, Lcom/cyjh/elfin/AppContext;->access$200(Lcom/cyjh/elfin/AppContext;)I

    move-result v2

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v1

    invoke-virtual {v0, v1}, Lcom/cyjh/elfin/log/CommonLog;->e(Ljava/lang/Object;)V

    .line 787
    iget-object v0, p0, Lcom/cyjh/elfin/AppContext$BlackListCountTimeRunnable;->this$0:Lcom/cyjh/elfin/AppContext;

    invoke-static {v0}, Lcom/cyjh/elfin/AppContext;->access$400(Lcom/cyjh/elfin/AppContext;)Z

    move-result v0

    if-nez v0, :cond_0

    .line 788
    iget-object v0, p0, Lcom/cyjh/elfin/AppContext$BlackListCountTimeRunnable;->this$0:Lcom/cyjh/elfin/AppContext;

    invoke-static {v0}, Lcom/cyjh/elfin/AppContext;->access$100(Lcom/cyjh/elfin/AppContext;)Landroid/os/Handler;

    move-result-object v0

    const/16 v1, 0x110

    invoke-virtual {v0, v1}, Landroid/os/Handler;->obtainMessage(I)Landroid/os/Message;

    move-result-object v0

    invoke-virtual {v0}, Landroid/os/Message;->sendToTarget()V

    .line 796
    :goto_0
    return-void

    .line 790
    :cond_0
    iget-object v0, p0, Lcom/cyjh/elfin/AppContext$BlackListCountTimeRunnable;->this$0:Lcom/cyjh/elfin/AppContext;

    invoke-static {v0}, Lcom/cyjh/elfin/AppContext;->access$100(Lcom/cyjh/elfin/AppContext;)Landroid/os/Handler;

    move-result-object v0

    const/16 v1, 0x120

    invoke-virtual {v0, v1}, Landroid/os/Handler;->obtainMessage(I)Landroid/os/Message;

    move-result-object v0

    invoke-virtual {v0}, Landroid/os/Message;->sendToTarget()V

    goto :goto_0

    .line 793
    :cond_1
    iget-object v0, p0, Lcom/cyjh/elfin/AppContext$BlackListCountTimeRunnable;->this$0:Lcom/cyjh/elfin/AppContext;

    invoke-static {v0}, Lcom/cyjh/elfin/AppContext;->access$100(Lcom/cyjh/elfin/AppContext;)Landroid/os/Handler;

    move-result-object v0

    invoke-virtual {v0, p0}, Landroid/os/Handler;->removeCallbacks(Ljava/lang/Runnable;)V

    .line 794
    iget-object v0, p0, Lcom/cyjh/elfin/AppContext$BlackListCountTimeRunnable;->this$0:Lcom/cyjh/elfin/AppContext;

    invoke-static {v0}, Lcom/cyjh/elfin/AppContext;->access$100(Lcom/cyjh/elfin/AppContext;)Landroid/os/Handler;

    move-result-object v0

    const-wide/16 v2, 0x7530

    invoke-virtual {v0, p0, v2, v3}, Landroid/os/Handler;->postDelayed(Ljava/lang/Runnable;J)Z

    goto :goto_0
.end method
