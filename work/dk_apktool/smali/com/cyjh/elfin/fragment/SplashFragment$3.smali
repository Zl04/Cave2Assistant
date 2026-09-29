.class Lcom/cyjh/elfin/fragment/SplashFragment$3;
.super Lcom/cyjh/elfin/listener/IFLYADListener;
.source "SplashFragment.java"


# annotations
.annotation system Ldalvik/annotation/EnclosingClass;
    value = Lcom/cyjh/elfin/fragment/SplashFragment;
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
    .line 783
    iput-object p1, p0, Lcom/cyjh/elfin/fragment/SplashFragment$3;->this$0:Lcom/cyjh/elfin/fragment/SplashFragment;

    invoke-direct {p0}, Lcom/cyjh/elfin/listener/IFLYADListener;-><init>()V

    return-void
.end method


# virtual methods
.method public onADLoaded(Ljava/util/List;)V
    .locals 3
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "(",
            "Ljava/util/List",
            "<",
            "Lcom/iflytek/voiceads/NativeADDataRef;",
            ">;)V"
        }
    .end annotation

    .prologue
    .line 786
    .local p1, "list":Ljava/util/List;, "Ljava/util/List<Lcom/iflytek/voiceads/NativeADDataRef;>;"
    const-string v0, "zzz"

    const-string v1, "SplashFragment---Picasso onADLoaded---1"

    invoke-static {v0, v1}, Landroid/util/Log;->e(Ljava/lang/String;Ljava/lang/String;)I

    .line 787
    invoke-interface {p1}, Ljava/util/List;->size()I

    move-result v0

    if-lez v0, :cond_0

    .line 788
    iget-object v1, p0, Lcom/cyjh/elfin/fragment/SplashFragment$3;->this$0:Lcom/cyjh/elfin/fragment/SplashFragment;

    const/4 v0, 0x0

    invoke-interface {p1, v0}, Ljava/util/List;->get(I)Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Lcom/iflytek/voiceads/NativeADDataRef;

    invoke-static {v1, v0}, Lcom/cyjh/elfin/fragment/SplashFragment;->access$2602(Lcom/cyjh/elfin/fragment/SplashFragment;Lcom/iflytek/voiceads/NativeADDataRef;)Lcom/iflytek/voiceads/NativeADDataRef;

    .line 789
    iget-object v0, p0, Lcom/cyjh/elfin/fragment/SplashFragment$3;->this$0:Lcom/cyjh/elfin/fragment/SplashFragment;

    iget-object v0, v0, Lcom/cyjh/elfin/fragment/SplashFragment;->commonLog:Lcom/cyjh/elfin/log/CommonLog;

    new-instance v1, Ljava/lang/StringBuilder;

    invoke-direct {v1}, Ljava/lang/StringBuilder;-><init>()V

    const-string v2, "aditem:"

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    iget-object v2, p0, Lcom/cyjh/elfin/fragment/SplashFragment$3;->this$0:Lcom/cyjh/elfin/fragment/SplashFragment;

    invoke-static {v2}, Lcom/cyjh/elfin/fragment/SplashFragment;->access$2600(Lcom/cyjh/elfin/fragment/SplashFragment;)Lcom/iflytek/voiceads/NativeADDataRef;

    move-result-object v2

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/Object;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v1

    invoke-virtual {v0, v1}, Lcom/cyjh/elfin/log/CommonLog;->e(Ljava/lang/Object;)V

    .line 790
    iget-object v0, p0, Lcom/cyjh/elfin/fragment/SplashFragment$3;->this$0:Lcom/cyjh/elfin/fragment/SplashFragment;

    iget-object v0, v0, Lcom/cyjh/elfin/fragment/SplashFragment;->appContext:Lcom/cyjh/elfin/AppContext;

    invoke-static {v0}, Lcom/squareup/picasso/Picasso;->with(Landroid/content/Context;)Lcom/squareup/picasso/Picasso;

    move-result-object v0

    iget-object v1, p0, Lcom/cyjh/elfin/fragment/SplashFragment$3;->this$0:Lcom/cyjh/elfin/fragment/SplashFragment;

    invoke-static {v1}, Lcom/cyjh/elfin/fragment/SplashFragment;->access$2600(Lcom/cyjh/elfin/fragment/SplashFragment;)Lcom/iflytek/voiceads/NativeADDataRef;

    move-result-object v1

    invoke-virtual {v1}, Lcom/iflytek/voiceads/NativeADDataRef;->getImage()Ljava/lang/String;

    move-result-object v1

    invoke-virtual {v0, v1}, Lcom/squareup/picasso/Picasso;->load(Ljava/lang/String;)Lcom/squareup/picasso/RequestCreator;

    move-result-object v0

    iget-object v1, p0, Lcom/cyjh/elfin/fragment/SplashFragment$3;->this$0:Lcom/cyjh/elfin/fragment/SplashFragment;

    invoke-static {v1}, Lcom/cyjh/elfin/fragment/SplashFragment;->access$900(Lcom/cyjh/elfin/fragment/SplashFragment;)Landroid/widget/ImageView;

    move-result-object v1

    new-instance v2, Lcom/cyjh/elfin/fragment/SplashFragment$3$1;

    invoke-direct {v2, p0}, Lcom/cyjh/elfin/fragment/SplashFragment$3$1;-><init>(Lcom/cyjh/elfin/fragment/SplashFragment$3;)V

    invoke-virtual {v0, v1, v2}, Lcom/squareup/picasso/RequestCreator;->into(Landroid/widget/ImageView;Lcom/squareup/picasso/Callback;)V

    .line 845
    :goto_0
    return-void

    .line 841
    :cond_0
    const-string v0, "zzz"

    const-string v1, "SplashFragment---Picasso onError\uff0c\u5f00\u59cb\u52a0\u8f7d\u540e\u53f0\u914d\u7f6e\u7684\u5e7f\u544a---2"

    invoke-static {v0, v1}, Landroid/util/Log;->e(Ljava/lang/String;Ljava/lang/String;)I

    .line 842
    iget-object v0, p0, Lcom/cyjh/elfin/fragment/SplashFragment$3;->this$0:Lcom/cyjh/elfin/fragment/SplashFragment;

    const/4 v1, 0x1

    invoke-static {v0, v1}, Lcom/cyjh/elfin/fragment/SplashFragment;->access$502(Lcom/cyjh/elfin/fragment/SplashFragment;Z)Z

    .line 843
    iget-object v0, p0, Lcom/cyjh/elfin/fragment/SplashFragment$3;->this$0:Lcom/cyjh/elfin/fragment/SplashFragment;

    invoke-static {v0}, Lcom/cyjh/elfin/fragment/SplashFragment;->access$800(Lcom/cyjh/elfin/fragment/SplashFragment;)Landroid/os/Handler;

    move-result-object v0

    const/16 v1, 0x10

    invoke-virtual {v0, v1}, Landroid/os/Handler;->obtainMessage(I)Landroid/os/Message;

    move-result-object v0

    invoke-virtual {v0}, Landroid/os/Message;->sendToTarget()V

    goto :goto_0
.end method

.method public onAdFailed(Lcom/iflytek/voiceads/AdError;)V
    .locals 3
    .param p1, "adError"    # Lcom/iflytek/voiceads/AdError;

    .prologue
    .line 848
    const-string v0, "zzz"

    new-instance v1, Ljava/lang/StringBuilder;

    invoke-direct {v1}, Ljava/lang/StringBuilder;-><init>()V

    const-string v2, "SplashFragment---Picasso onError\uff0c\u5f00\u59cb\u52a0\u8f7d\u540e\u53f0\u914d\u7f6e\u7684\u5e7f\u544a---3"

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {p1}, Lcom/iflytek/voiceads/AdError;->getMessage()Ljava/lang/String;

    move-result-object v2

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    const-string v2, ","

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {p1}, Lcom/iflytek/voiceads/AdError;->getErrorDescription()Ljava/lang/String;

    move-result-object v2

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v1

    invoke-static {v0, v1}, Landroid/util/Log;->e(Ljava/lang/String;Ljava/lang/String;)I

    .line 849
    iget-object v0, p0, Lcom/cyjh/elfin/fragment/SplashFragment$3;->this$0:Lcom/cyjh/elfin/fragment/SplashFragment;

    iget-object v0, v0, Lcom/cyjh/elfin/fragment/SplashFragment;->commonLog:Lcom/cyjh/elfin/log/CommonLog;

    const-string v1, "onAdFailed\u8baf\u98de\u52a0\u8f7d\u5931\u8d25\uff0c\u5f00\u59cb\u52a0\u8f7d\u540e\u53f0\u914d\u7f6e\u7684\u5e7f\u544a"

    invoke-virtual {v0, v1}, Lcom/cyjh/elfin/log/CommonLog;->e(Ljava/lang/Object;)V

    .line 850
    iget-object v0, p0, Lcom/cyjh/elfin/fragment/SplashFragment$3;->this$0:Lcom/cyjh/elfin/fragment/SplashFragment;

    const/4 v1, 0x1

    invoke-static {v0, v1}, Lcom/cyjh/elfin/fragment/SplashFragment;->access$502(Lcom/cyjh/elfin/fragment/SplashFragment;Z)Z

    .line 851
    iget-object v0, p0, Lcom/cyjh/elfin/fragment/SplashFragment$3;->this$0:Lcom/cyjh/elfin/fragment/SplashFragment;

    invoke-static {v0}, Lcom/cyjh/elfin/fragment/SplashFragment;->access$800(Lcom/cyjh/elfin/fragment/SplashFragment;)Landroid/os/Handler;

    move-result-object v0

    const/16 v1, 0x10

    invoke-virtual {v0, v1}, Landroid/os/Handler;->obtainMessage(I)Landroid/os/Message;

    move-result-object v0

    invoke-virtual {v0}, Landroid/os/Message;->sendToTarget()V

    .line 852
    return-void
.end method
