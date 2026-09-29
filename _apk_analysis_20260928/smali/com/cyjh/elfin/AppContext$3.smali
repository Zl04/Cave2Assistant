.class Lcom/cyjh/elfin/AppContext$3;
.super Landroid/os/Handler;
.source "AppContext.java"


# annotations
.annotation system Ldalvik/annotation/EnclosingClass;
    value = Lcom/cyjh/elfin/AppContext;
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x0
    name = null
.end annotation


# instance fields
.field final synthetic this$0:Lcom/cyjh/elfin/AppContext;


# direct methods
.method constructor <init>(Lcom/cyjh/elfin/AppContext;)V
    .locals 0
    .param p1, "this$0"    # Lcom/cyjh/elfin/AppContext;

    .prologue
    .line 800
    iput-object p1, p0, Lcom/cyjh/elfin/AppContext$3;->this$0:Lcom/cyjh/elfin/AppContext;

    invoke-direct {p0}, Landroid/os/Handler;-><init>()V

    return-void
.end method


# virtual methods
.method public handleMessage(Landroid/os/Message;)V
    .locals 7
    .param p1, "msg"    # Landroid/os/Message;

    .prologue
    const/4 v6, 0x0

    .line 803
    iget v1, p1, Landroid/os/Message;->what:I

    sparse-switch v1, :sswitch_data_0

    .line 827
    :cond_0
    :goto_0
    return-void

    .line 805
    :sswitch_0
    iget-object v1, p0, Lcom/cyjh/elfin/AppContext$3;->this$0:Lcom/cyjh/elfin/AppContext;

    iget-object v1, v1, Lcom/cyjh/elfin/AppContext;->commonLog:Lcom/cyjh/elfin/log/CommonLog;

    new-instance v2, Ljava/lang/StringBuilder;

    invoke-direct {v2}, Ljava/lang/StringBuilder;-><init>()V

    const-string v3, "AppContext handleMessage 0x110"

    invoke-virtual {v2, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    invoke-static {}, Lcom/cyjh/mobileanjian/ipc/MqRunner;->getInstance()Lcom/cyjh/mobileanjian/ipc/MqRunner;

    move-result-object v3

    invoke-virtual {v3}, Lcom/cyjh/mobileanjian/ipc/MqRunner;->isScriptStarted()Z

    move-result v3

    invoke-virtual {v2, v3}, Ljava/lang/StringBuilder;->append(Z)Ljava/lang/StringBuilder;

    move-result-object v2

    invoke-virtual {v2}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v2

    invoke-virtual {v1, v2}, Lcom/cyjh/elfin/log/CommonLog;->e(Ljava/lang/Object;)V

    .line 806
    invoke-static {}, Ljava/lang/Math;->random()D

    move-result-wide v2

    const-wide/high16 v4, 0x4000000000000000L    # 2.0

    mul-double/2addr v2, v4

    const-wide/high16 v4, 0x4008000000000000L    # 3.0

    add-double/2addr v2, v4

    double-to-int v0, v2

    .line 808
    .local v0, "randomTimeSecond":I
    iget-object v1, p0, Lcom/cyjh/elfin/AppContext$3;->this$0:Lcom/cyjh/elfin/AppContext;

    invoke-static {v1, v0}, Lcom/cyjh/elfin/AppContext;->access$500(Lcom/cyjh/elfin/AppContext;I)V

    .line 809
    iget-object v1, p0, Lcom/cyjh/elfin/AppContext$3;->this$0:Lcom/cyjh/elfin/AppContext;

    invoke-static {v1, v6}, Lcom/cyjh/elfin/AppContext;->access$202(Lcom/cyjh/elfin/AppContext;I)I

    .line 810
    iget-object v1, p0, Lcom/cyjh/elfin/AppContext$3;->this$0:Lcom/cyjh/elfin/AppContext;

    iget-object v1, v1, Lcom/cyjh/elfin/AppContext;->commonLog:Lcom/cyjh/elfin/log/CommonLog;

    new-instance v2, Ljava/lang/StringBuilder;

    invoke-direct {v2}, Ljava/lang/StringBuilder;-><init>()V

    const-string v3, "AppContext handleMessage 0x110 totalTime = "

    invoke-virtual {v2, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    iget-object v3, p0, Lcom/cyjh/elfin/AppContext$3;->this$0:Lcom/cyjh/elfin/AppContext;

    invoke-static {v3}, Lcom/cyjh/elfin/AppContext;->access$300(Lcom/cyjh/elfin/AppContext;)I

    move-result v3

    invoke-virtual {v2, v3}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v2

    const-string v3, ",randomTime = "

    invoke-virtual {v2, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    invoke-virtual {v2, v0}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v2

    invoke-virtual {v2}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v2

    invoke-virtual {v1, v2}, Lcom/cyjh/elfin/log/CommonLog;->e(Ljava/lang/Object;)V

    .line 811
    iget-object v1, p0, Lcom/cyjh/elfin/AppContext$3;->this$0:Lcom/cyjh/elfin/AppContext;

    const/4 v2, 0x1

    invoke-static {v1, v2}, Lcom/cyjh/elfin/AppContext;->access$402(Lcom/cyjh/elfin/AppContext;Z)Z

    .line 812
    iget-object v1, p0, Lcom/cyjh/elfin/AppContext$3;->this$0:Lcom/cyjh/elfin/AppContext;

    invoke-static {v1}, Lcom/cyjh/elfin/AppContext;->access$600(Lcom/cyjh/elfin/AppContext;)Lcom/cyjh/elfin/AppContext$BlackListCountTimeRunnable;

    move-result-object v1

    invoke-virtual {v1}, Lcom/cyjh/elfin/AppContext$BlackListCountTimeRunnable;->onStart()V

    goto :goto_0

    .line 815
    .end local v0    # "randomTimeSecond":I
    :sswitch_1
    iget-object v1, p0, Lcom/cyjh/elfin/AppContext$3;->this$0:Lcom/cyjh/elfin/AppContext;

    iget-object v1, v1, Lcom/cyjh/elfin/AppContext;->commonLog:Lcom/cyjh/elfin/log/CommonLog;

    new-instance v2, Ljava/lang/StringBuilder;

    invoke-direct {v2}, Ljava/lang/StringBuilder;-><init>()V

    const-string v3, "AppContext handleMessage 0x120"

    invoke-virtual {v2, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    invoke-static {}, Lcom/cyjh/mobileanjian/ipc/MqRunner;->getInstance()Lcom/cyjh/mobileanjian/ipc/MqRunner;

    move-result-object v3

    invoke-virtual {v3}, Lcom/cyjh/mobileanjian/ipc/MqRunner;->isScriptStarted()Z

    move-result v3

    invoke-virtual {v2, v3}, Ljava/lang/StringBuilder;->append(Z)Ljava/lang/StringBuilder;

    move-result-object v2

    invoke-virtual {v2}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v2

    invoke-virtual {v1, v2}, Lcom/cyjh/elfin/log/CommonLog;->e(Ljava/lang/Object;)V

    .line 816
    iget-object v1, p0, Lcom/cyjh/elfin/AppContext$3;->this$0:Lcom/cyjh/elfin/AppContext;

    invoke-static {v1, v6}, Lcom/cyjh/elfin/AppContext;->access$402(Lcom/cyjh/elfin/AppContext;Z)Z

    .line 817
    iget-object v1, p0, Lcom/cyjh/elfin/AppContext$3;->this$0:Lcom/cyjh/elfin/AppContext;

    invoke-static {v1, v6}, Lcom/cyjh/elfin/AppContext;->access$202(Lcom/cyjh/elfin/AppContext;I)I

    .line 818
    invoke-static {}, Lcom/cyjh/mobileanjian/ipc/MqRunner;->getInstance()Lcom/cyjh/mobileanjian/ipc/MqRunner;

    move-result-object v1

    invoke-virtual {v1}, Lcom/cyjh/mobileanjian/ipc/MqRunner;->isScriptStarted()Z

    move-result v1

    if-eqz v1, :cond_0

    .line 819
    iget-object v1, p0, Lcom/cyjh/elfin/AppContext$3;->this$0:Lcom/cyjh/elfin/AppContext;

    iget-object v1, v1, Lcom/cyjh/elfin/AppContext;->commonLog:Lcom/cyjh/elfin/log/CommonLog;

    const-string v2, "AppContext handleMessage 0x120 MqRunner.getInstance().stop();"

    invoke-virtual {v1, v2}, Lcom/cyjh/elfin/log/CommonLog;->e(Ljava/lang/Object;)V

    .line 820
    invoke-static {}, Lcom/cyjh/mobileanjian/ipc/MqRunner;->getInstance()Lcom/cyjh/mobileanjian/ipc/MqRunner;

    move-result-object v1

    invoke-virtual {v1}, Lcom/cyjh/mobileanjian/ipc/MqRunner;->stop()V

    .line 821
    invoke-static {}, Lcom/cyjh/mobileanjian/ipc/MqRunner;->getInstance()Lcom/cyjh/mobileanjian/ipc/MqRunner;

    move-result-object v1

    invoke-virtual {v1}, Lcom/cyjh/mobileanjian/ipc/MqRunner;->stop()V

    goto/16 :goto_0

    .line 803
    nop

    :sswitch_data_0
    .sparse-switch
        0x110 -> :sswitch_0
        0x120 -> :sswitch_1
    .end sparse-switch
.end method
