.class Lcom/cyjh/elfin/fragment/SplashFragment$RunnableTask;
.super Ljava/lang/Object;
.source "SplashFragment.java"

# interfaces
.implements Ljava/lang/Runnable;


# annotations
.annotation system Ldalvik/annotation/EnclosingClass;
    value = Lcom/cyjh/elfin/fragment/SplashFragment;
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x2
    name = "RunnableTask"
.end annotation


# instance fields
.field final synthetic this$0:Lcom/cyjh/elfin/fragment/SplashFragment;


# direct methods
.method private constructor <init>(Lcom/cyjh/elfin/fragment/SplashFragment;)V
    .locals 0

    .prologue
    .line 675
    iput-object p1, p0, Lcom/cyjh/elfin/fragment/SplashFragment$RunnableTask;->this$0:Lcom/cyjh/elfin/fragment/SplashFragment;

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method

.method synthetic constructor <init>(Lcom/cyjh/elfin/fragment/SplashFragment;Lcom/cyjh/elfin/fragment/SplashFragment$1;)V
    .locals 0
    .param p1, "x0"    # Lcom/cyjh/elfin/fragment/SplashFragment;
    .param p2, "x1"    # Lcom/cyjh/elfin/fragment/SplashFragment$1;

    .prologue
    .line 675
    invoke-direct {p0, p1}, Lcom/cyjh/elfin/fragment/SplashFragment$RunnableTask;-><init>(Lcom/cyjh/elfin/fragment/SplashFragment;)V

    return-void
.end method


# virtual methods
.method public run()V
    .locals 4

    .prologue
    .line 683
    iget-object v1, p0, Lcom/cyjh/elfin/fragment/SplashFragment$RunnableTask;->this$0:Lcom/cyjh/elfin/fragment/SplashFragment;

    invoke-static {v1}, Lcom/cyjh/elfin/fragment/SplashFragment;->access$2108(Lcom/cyjh/elfin/fragment/SplashFragment;)I

    .line 684
    const/4 v0, 0x0

    .local v0, "i":I
    :goto_0
    iget-object v1, p0, Lcom/cyjh/elfin/fragment/SplashFragment$RunnableTask;->this$0:Lcom/cyjh/elfin/fragment/SplashFragment;

    invoke-static {v1}, Lcom/cyjh/elfin/fragment/SplashFragment;->access$2200(Lcom/cyjh/elfin/fragment/SplashFragment;)Ljava/util/List;

    move-result-object v1

    invoke-interface {v1}, Ljava/util/List;->size()I

    move-result v1

    if-ge v0, v1, :cond_1

    .line 685
    iget-object v1, p0, Lcom/cyjh/elfin/fragment/SplashFragment$RunnableTask;->this$0:Lcom/cyjh/elfin/fragment/SplashFragment;

    invoke-static {v1}, Lcom/cyjh/elfin/fragment/SplashFragment;->access$2100(Lcom/cyjh/elfin/fragment/SplashFragment;)I

    move-result v1

    iget-object v2, p0, Lcom/cyjh/elfin/fragment/SplashFragment$RunnableTask;->this$0:Lcom/cyjh/elfin/fragment/SplashFragment;

    invoke-static {v2}, Lcom/cyjh/elfin/fragment/SplashFragment;->access$2200(Lcom/cyjh/elfin/fragment/SplashFragment;)Ljava/util/List;

    move-result-object v2

    invoke-interface {v2}, Ljava/util/List;->size()I

    move-result v2

    rem-int/2addr v1, v2

    if-ne v0, v1, :cond_0

    .line 686
    iget-object v1, p0, Lcom/cyjh/elfin/fragment/SplashFragment$RunnableTask;->this$0:Lcom/cyjh/elfin/fragment/SplashFragment;

    invoke-static {v1}, Lcom/cyjh/elfin/fragment/SplashFragment;->access$2200(Lcom/cyjh/elfin/fragment/SplashFragment;)Ljava/util/List;

    move-result-object v1

    invoke-interface {v1, v0}, Ljava/util/List;->get(I)Ljava/lang/Object;

    move-result-object v1

    check-cast v1, Landroid/widget/ImageView;

    iget-object v2, p0, Lcom/cyjh/elfin/fragment/SplashFragment$RunnableTask;->this$0:Lcom/cyjh/elfin/fragment/SplashFragment;

    invoke-static {v2}, Lcom/cyjh/elfin/fragment/SplashFragment;->access$2300(Lcom/cyjh/elfin/fragment/SplashFragment;)Landroid/graphics/drawable/GradientDrawable;

    move-result-object v2

    invoke-virtual {v1, v2}, Landroid/widget/ImageView;->setImageDrawable(Landroid/graphics/drawable/Drawable;)V

    .line 684
    :goto_1
    add-int/lit8 v0, v0, 0x1

    goto :goto_0

    .line 688
    :cond_0
    iget-object v1, p0, Lcom/cyjh/elfin/fragment/SplashFragment$RunnableTask;->this$0:Lcom/cyjh/elfin/fragment/SplashFragment;

    invoke-static {v1}, Lcom/cyjh/elfin/fragment/SplashFragment;->access$2200(Lcom/cyjh/elfin/fragment/SplashFragment;)Ljava/util/List;

    move-result-object v1

    invoke-interface {v1, v0}, Ljava/util/List;->get(I)Ljava/lang/Object;

    move-result-object v1

    check-cast v1, Landroid/widget/ImageView;

    iget-object v2, p0, Lcom/cyjh/elfin/fragment/SplashFragment$RunnableTask;->this$0:Lcom/cyjh/elfin/fragment/SplashFragment;

    invoke-static {v2}, Lcom/cyjh/elfin/fragment/SplashFragment;->access$2400(Lcom/cyjh/elfin/fragment/SplashFragment;)Landroid/graphics/drawable/GradientDrawable;

    move-result-object v2

    invoke-virtual {v1, v2}, Landroid/widget/ImageView;->setImageDrawable(Landroid/graphics/drawable/Drawable;)V

    goto :goto_1

    .line 691
    :cond_1
    iget-object v1, p0, Lcom/cyjh/elfin/fragment/SplashFragment$RunnableTask;->this$0:Lcom/cyjh/elfin/fragment/SplashFragment;

    invoke-static {v1}, Lcom/cyjh/elfin/fragment/SplashFragment;->access$800(Lcom/cyjh/elfin/fragment/SplashFragment;)Landroid/os/Handler;

    move-result-object v1

    invoke-virtual {v1, p0}, Landroid/os/Handler;->removeCallbacks(Ljava/lang/Runnable;)V

    .line 692
    iget-object v1, p0, Lcom/cyjh/elfin/fragment/SplashFragment$RunnableTask;->this$0:Lcom/cyjh/elfin/fragment/SplashFragment;

    invoke-static {v1}, Lcom/cyjh/elfin/fragment/SplashFragment;->access$800(Lcom/cyjh/elfin/fragment/SplashFragment;)Landroid/os/Handler;

    move-result-object v1

    const-wide/16 v2, 0x64

    invoke-virtual {v1, p0, v2, v3}, Landroid/os/Handler;->postDelayed(Ljava/lang/Runnable;J)Z

    .line 693
    return-void
.end method

.method public start()V
    .locals 4

    .prologue
    .line 678
    iget-object v0, p0, Lcom/cyjh/elfin/fragment/SplashFragment$RunnableTask;->this$0:Lcom/cyjh/elfin/fragment/SplashFragment;

    invoke-static {v0}, Lcom/cyjh/elfin/fragment/SplashFragment;->access$800(Lcom/cyjh/elfin/fragment/SplashFragment;)Landroid/os/Handler;

    move-result-object v0

    invoke-virtual {v0, p0}, Landroid/os/Handler;->removeCallbacks(Ljava/lang/Runnable;)V

    .line 679
    iget-object v0, p0, Lcom/cyjh/elfin/fragment/SplashFragment$RunnableTask;->this$0:Lcom/cyjh/elfin/fragment/SplashFragment;

    invoke-static {v0}, Lcom/cyjh/elfin/fragment/SplashFragment;->access$800(Lcom/cyjh/elfin/fragment/SplashFragment;)Landroid/os/Handler;

    move-result-object v0

    const-wide/16 v2, 0x64

    invoke-virtual {v0, p0, v2, v3}, Landroid/os/Handler;->postDelayed(Ljava/lang/Runnable;J)Z

    .line 680
    return-void
.end method
