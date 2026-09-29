.class Lcom/cyjh/elfin/fragment/OptionFragment$RunnableTask;
.super Ljava/lang/Object;
.source "OptionFragment.java"

# interfaces
.implements Ljava/lang/Runnable;


# annotations
.annotation system Ldalvik/annotation/EnclosingClass;
    value = Lcom/cyjh/elfin/fragment/OptionFragment;
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x2
    name = "RunnableTask"
.end annotation


# instance fields
.field final synthetic this$0:Lcom/cyjh/elfin/fragment/OptionFragment;


# direct methods
.method private constructor <init>(Lcom/cyjh/elfin/fragment/OptionFragment;)V
    .locals 0

    .prologue
    .line 1299
    iput-object p1, p0, Lcom/cyjh/elfin/fragment/OptionFragment$RunnableTask;->this$0:Lcom/cyjh/elfin/fragment/OptionFragment;

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method

.method synthetic constructor <init>(Lcom/cyjh/elfin/fragment/OptionFragment;Lcom/cyjh/elfin/fragment/OptionFragment$1;)V
    .locals 0
    .param p1, "x0"    # Lcom/cyjh/elfin/fragment/OptionFragment;
    .param p2, "x1"    # Lcom/cyjh/elfin/fragment/OptionFragment$1;

    .prologue
    .line 1299
    invoke-direct {p0, p1}, Lcom/cyjh/elfin/fragment/OptionFragment$RunnableTask;-><init>(Lcom/cyjh/elfin/fragment/OptionFragment;)V

    return-void
.end method


# virtual methods
.method public run()V
    .locals 3

    .prologue
    .line 1307
    :try_start_0
    iget-object v1, p0, Lcom/cyjh/elfin/fragment/OptionFragment$RunnableTask;->this$0:Lcom/cyjh/elfin/fragment/OptionFragment;

    invoke-virtual {v1}, Lcom/cyjh/elfin/fragment/OptionFragment;->generateOptionJson()V
    :try_end_0
    .catch Ljava/lang/Exception; {:try_start_0 .. :try_end_0} :catch_0

    .line 1311
    :goto_0
    iget-object v1, p0, Lcom/cyjh/elfin/fragment/OptionFragment$RunnableTask;->this$0:Lcom/cyjh/elfin/fragment/OptionFragment;

    invoke-static {v1}, Lcom/cyjh/elfin/fragment/OptionFragment;->access$1300(Lcom/cyjh/elfin/fragment/OptionFragment;)Landroid/os/Handler;

    move-result-object v1

    const/16 v2, 0x64

    invoke-virtual {v1, v2}, Landroid/os/Handler;->sendEmptyMessage(I)Z

    .line 1312
    return-void

    .line 1308
    :catch_0
    move-exception v0

    .line 1309
    .local v0, "e":Ljava/lang/Exception;
    invoke-virtual {v0}, Ljava/lang/Exception;->printStackTrace()V

    goto :goto_0
.end method

.method public start()V
    .locals 1

    .prologue
    .line 1301
    iget-object v0, p0, Lcom/cyjh/elfin/fragment/OptionFragment$RunnableTask;->this$0:Lcom/cyjh/elfin/fragment/OptionFragment;

    invoke-static {v0}, Lcom/cyjh/elfin/fragment/OptionFragment;->access$1300(Lcom/cyjh/elfin/fragment/OptionFragment;)Landroid/os/Handler;

    move-result-object v0

    invoke-virtual {v0, p0}, Landroid/os/Handler;->removeCallbacks(Ljava/lang/Runnable;)V

    .line 1302
    iget-object v0, p0, Lcom/cyjh/elfin/fragment/OptionFragment$RunnableTask;->this$0:Lcom/cyjh/elfin/fragment/OptionFragment;

    invoke-static {v0}, Lcom/cyjh/elfin/fragment/OptionFragment;->access$1300(Lcom/cyjh/elfin/fragment/OptionFragment;)Landroid/os/Handler;

    move-result-object v0

    invoke-virtual {v0, p0}, Landroid/os/Handler;->post(Ljava/lang/Runnable;)Z

    .line 1303
    return-void
.end method
