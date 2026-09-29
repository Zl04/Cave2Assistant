.class Lcom/cyjh/elfin/fragment/SplashFragment$3$1;
.super Ljava/lang/Object;
.source "SplashFragment.java"

# interfaces
.implements Lcom/squareup/picasso/Callback;


# annotations
.annotation system Ldalvik/annotation/EnclosingMethod;
    value = Lcom/cyjh/elfin/fragment/SplashFragment$3;->onADLoaded(Ljava/util/List;)V
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x0
    name = null
.end annotation


# instance fields
.field final synthetic this$1:Lcom/cyjh/elfin/fragment/SplashFragment$3;


# direct methods
.method constructor <init>(Lcom/cyjh/elfin/fragment/SplashFragment$3;)V
    .locals 0
    .param p1, "this$1"    # Lcom/cyjh/elfin/fragment/SplashFragment$3;

    .prologue
    .line 790
    iput-object p1, p0, Lcom/cyjh/elfin/fragment/SplashFragment$3$1;->this$1:Lcom/cyjh/elfin/fragment/SplashFragment$3;

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method


# virtual methods
.method public onError()V
    .locals 2

    .prologue
    .line 832
    const-string v0, "zzz"

    const-string v1, "SplashFragment---Picasso onError\uff0c\u5f00\u59cb\u52a0\u8f7d\u540e\u53f0\u914d\u7f6e\u7684\u5e7f\u544a---1"

    invoke-static {v0, v1}, Landroid/util/Log;->e(Ljava/lang/String;Ljava/lang/String;)I

    .line 833
    iget-object v0, p0, Lcom/cyjh/elfin/fragment/SplashFragment$3$1;->this$1:Lcom/cyjh/elfin/fragment/SplashFragment$3;

    iget-object v0, v0, Lcom/cyjh/elfin/fragment/SplashFragment$3;->this$0:Lcom/cyjh/elfin/fragment/SplashFragment;

    iget-object v0, v0, Lcom/cyjh/elfin/fragment/SplashFragment;->commonLog:Lcom/cyjh/elfin/log/CommonLog;

    const-string v1, "Picasso onError\uff0c\u5f00\u59cb\u52a0\u8f7d\u540e\u53f0\u914d\u7f6e\u7684\u5e7f\u544a"

    invoke-virtual {v0, v1}, Lcom/cyjh/elfin/log/CommonLog;->e(Ljava/lang/Object;)V

    .line 836
    iget-object v0, p0, Lcom/cyjh/elfin/fragment/SplashFragment$3$1;->this$1:Lcom/cyjh/elfin/fragment/SplashFragment$3;

    iget-object v0, v0, Lcom/cyjh/elfin/fragment/SplashFragment$3;->this$0:Lcom/cyjh/elfin/fragment/SplashFragment;

    const/4 v1, 0x1

    invoke-static {v0, v1}, Lcom/cyjh/elfin/fragment/SplashFragment;->access$502(Lcom/cyjh/elfin/fragment/SplashFragment;Z)Z

    .line 837
    iget-object v0, p0, Lcom/cyjh/elfin/fragment/SplashFragment$3$1;->this$1:Lcom/cyjh/elfin/fragment/SplashFragment$3;

    iget-object v0, v0, Lcom/cyjh/elfin/fragment/SplashFragment$3;->this$0:Lcom/cyjh/elfin/fragment/SplashFragment;

    invoke-static {v0}, Lcom/cyjh/elfin/fragment/SplashFragment;->access$800(Lcom/cyjh/elfin/fragment/SplashFragment;)Landroid/os/Handler;

    move-result-object v0

    const/16 v1, 0x10

    invoke-virtual {v0, v1}, Landroid/os/Handler;->obtainMessage(I)Landroid/os/Message;

    move-result-object v0

    invoke-virtual {v0}, Landroid/os/Message;->sendToTarget()V

    .line 838
    return-void
.end method

.method public onSuccess()V
    .locals 6

    .prologue
    const/4 v5, 0x0

    const/16 v2, 0x8

    const/4 v4, 0x0

    .line 793
    const-string v0, "zzz"

    const-string v1, "SplashFragment---Picasso onSuccess---1"

    invoke-static {v0, v1}, Landroid/util/Log;->e(Ljava/lang/String;Ljava/lang/String;)I

    .line 794
    iget-object v0, p0, Lcom/cyjh/elfin/fragment/SplashFragment$3$1;->this$1:Lcom/cyjh/elfin/fragment/SplashFragment$3;

    iget-object v0, v0, Lcom/cyjh/elfin/fragment/SplashFragment$3;->this$0:Lcom/cyjh/elfin/fragment/SplashFragment;

    invoke-static {v0}, Lcom/cyjh/elfin/fragment/SplashFragment;->access$800(Lcom/cyjh/elfin/fragment/SplashFragment;)Landroid/os/Handler;

    move-result-object v0

    const/16 v1, 0xf

    invoke-virtual {v0, v1}, Landroid/os/Handler;->obtainMessage(I)Landroid/os/Message;

    move-result-object v0

    invoke-virtual {v0}, Landroid/os/Message;->sendToTarget()V

    .line 795
    iget-object v0, p0, Lcom/cyjh/elfin/fragment/SplashFragment$3$1;->this$1:Lcom/cyjh/elfin/fragment/SplashFragment$3;

    iget-object v0, v0, Lcom/cyjh/elfin/fragment/SplashFragment$3;->this$0:Lcom/cyjh/elfin/fragment/SplashFragment;

    invoke-static {v0}, Lcom/cyjh/elfin/fragment/SplashFragment;->access$1100(Lcom/cyjh/elfin/fragment/SplashFragment;)Landroid/widget/ImageView;

    move-result-object v0

    invoke-virtual {v0, v2}, Landroid/widget/ImageView;->setVisibility(I)V

    .line 796
    iget-object v0, p0, Lcom/cyjh/elfin/fragment/SplashFragment$3$1;->this$1:Lcom/cyjh/elfin/fragment/SplashFragment$3;

    iget-object v0, v0, Lcom/cyjh/elfin/fragment/SplashFragment$3;->this$0:Lcom/cyjh/elfin/fragment/SplashFragment;

    invoke-static {v0}, Lcom/cyjh/elfin/fragment/SplashFragment;->access$1200(Lcom/cyjh/elfin/fragment/SplashFragment;)Landroid/widget/RelativeLayout;

    move-result-object v0

    invoke-virtual {v0, v2}, Landroid/widget/RelativeLayout;->setVisibility(I)V

    .line 797
    iget-object v0, p0, Lcom/cyjh/elfin/fragment/SplashFragment$3$1;->this$1:Lcom/cyjh/elfin/fragment/SplashFragment$3;

    iget-object v0, v0, Lcom/cyjh/elfin/fragment/SplashFragment$3;->this$0:Lcom/cyjh/elfin/fragment/SplashFragment;

    invoke-static {v0}, Lcom/cyjh/elfin/fragment/SplashFragment;->access$900(Lcom/cyjh/elfin/fragment/SplashFragment;)Landroid/widget/ImageView;

    move-result-object v0

    iget-object v1, p0, Lcom/cyjh/elfin/fragment/SplashFragment$3$1;->this$1:Lcom/cyjh/elfin/fragment/SplashFragment$3;

    iget-object v1, v1, Lcom/cyjh/elfin/fragment/SplashFragment$3;->this$0:Lcom/cyjh/elfin/fragment/SplashFragment;

    invoke-static {v1}, Lcom/cyjh/elfin/fragment/SplashFragment;->access$1500(Lcom/cyjh/elfin/fragment/SplashFragment;)Landroid/view/View$OnClickListener;

    move-result-object v1

    invoke-virtual {v0, v1}, Landroid/widget/ImageView;->setOnClickListener(Landroid/view/View$OnClickListener;)V

    .line 798
    iget-object v0, p0, Lcom/cyjh/elfin/fragment/SplashFragment$3$1;->this$1:Lcom/cyjh/elfin/fragment/SplashFragment$3;

    iget-object v0, v0, Lcom/cyjh/elfin/fragment/SplashFragment$3;->this$0:Lcom/cyjh/elfin/fragment/SplashFragment;

    invoke-static {v0}, Lcom/cyjh/elfin/fragment/SplashFragment;->access$900(Lcom/cyjh/elfin/fragment/SplashFragment;)Landroid/widget/ImageView;

    move-result-object v0

    new-instance v1, Lcom/cyjh/elfin/listener/IFLYADTouchListener;

    iget-object v2, p0, Lcom/cyjh/elfin/fragment/SplashFragment$3$1;->this$1:Lcom/cyjh/elfin/fragment/SplashFragment$3;

    iget-object v2, v2, Lcom/cyjh/elfin/fragment/SplashFragment$3;->this$0:Lcom/cyjh/elfin/fragment/SplashFragment;

    invoke-static {v2}, Lcom/cyjh/elfin/fragment/SplashFragment;->access$300(Lcom/cyjh/elfin/fragment/SplashFragment;)Lcom/iflytek/voiceads/IFLYNativeAd;

    move-result-object v2

    invoke-direct {v1, v2}, Lcom/cyjh/elfin/listener/IFLYADTouchListener;-><init>(Lcom/iflytek/voiceads/IFLYNativeAd;)V

    invoke-virtual {v0, v1}, Landroid/widget/ImageView;->setOnTouchListener(Landroid/view/View$OnTouchListener;)V

    .line 799
    iget-object v0, p0, Lcom/cyjh/elfin/fragment/SplashFragment$3$1;->this$1:Lcom/cyjh/elfin/fragment/SplashFragment$3;

    iget-object v0, v0, Lcom/cyjh/elfin/fragment/SplashFragment$3;->this$0:Lcom/cyjh/elfin/fragment/SplashFragment;

    invoke-static {v0}, Lcom/cyjh/elfin/fragment/SplashFragment;->access$1000(Lcom/cyjh/elfin/fragment/SplashFragment;)Landroid/widget/TextView;

    move-result-object v0

    new-instance v1, Lcom/cyjh/elfin/listener/IFLYADTouchListener;

    iget-object v2, p0, Lcom/cyjh/elfin/fragment/SplashFragment$3$1;->this$1:Lcom/cyjh/elfin/fragment/SplashFragment$3;

    iget-object v2, v2, Lcom/cyjh/elfin/fragment/SplashFragment$3;->this$0:Lcom/cyjh/elfin/fragment/SplashFragment;

    invoke-static {v2}, Lcom/cyjh/elfin/fragment/SplashFragment;->access$300(Lcom/cyjh/elfin/fragment/SplashFragment;)Lcom/iflytek/voiceads/IFLYNativeAd;

    move-result-object v2

    invoke-direct {v1, v2}, Lcom/cyjh/elfin/listener/IFLYADTouchListener;-><init>(Lcom/iflytek/voiceads/IFLYNativeAd;)V

    invoke-virtual {v0, v1}, Landroid/widget/TextView;->setOnTouchListener(Landroid/view/View$OnTouchListener;)V

    .line 800
    iget-object v0, p0, Lcom/cyjh/elfin/fragment/SplashFragment$3$1;->this$1:Lcom/cyjh/elfin/fragment/SplashFragment$3;

    iget-object v0, v0, Lcom/cyjh/elfin/fragment/SplashFragment$3;->this$0:Lcom/cyjh/elfin/fragment/SplashFragment;

    invoke-static {v0}, Lcom/cyjh/elfin/fragment/SplashFragment;->access$1000(Lcom/cyjh/elfin/fragment/SplashFragment;)Landroid/widget/TextView;

    move-result-object v0

    invoke-virtual {v0, v4}, Landroid/widget/TextView;->setVisibility(I)V

    .line 801
    iget-object v0, p0, Lcom/cyjh/elfin/fragment/SplashFragment$3$1;->this$1:Lcom/cyjh/elfin/fragment/SplashFragment$3;

    iget-object v0, v0, Lcom/cyjh/elfin/fragment/SplashFragment$3;->this$0:Lcom/cyjh/elfin/fragment/SplashFragment;

    invoke-virtual {v0}, Lcom/cyjh/elfin/fragment/SplashFragment;->isAdded()Z

    move-result v0

    if-eqz v0, :cond_0

    iget-object v0, p0, Lcom/cyjh/elfin/fragment/SplashFragment$3$1;->this$1:Lcom/cyjh/elfin/fragment/SplashFragment$3;

    iget-object v0, v0, Lcom/cyjh/elfin/fragment/SplashFragment$3;->this$0:Lcom/cyjh/elfin/fragment/SplashFragment;

    invoke-static {v0}, Lcom/cyjh/elfin/fragment/SplashFragment;->access$2600(Lcom/cyjh/elfin/fragment/SplashFragment;)Lcom/iflytek/voiceads/NativeADDataRef;

    move-result-object v0

    invoke-virtual {v0}, Lcom/iflytek/voiceads/NativeADDataRef;->getAdSourceMark()Ljava/lang/String;

    move-result-object v0

    invoke-static {v0}, Landroid/text/TextUtils;->isEmpty(Ljava/lang/CharSequence;)Z

    move-result v0

    if-nez v0, :cond_0

    .line 802
    iget-object v0, p0, Lcom/cyjh/elfin/fragment/SplashFragment$3$1;->this$1:Lcom/cyjh/elfin/fragment/SplashFragment$3;

    iget-object v0, v0, Lcom/cyjh/elfin/fragment/SplashFragment$3;->this$0:Lcom/cyjh/elfin/fragment/SplashFragment;

    invoke-static {v0}, Lcom/cyjh/elfin/fragment/SplashFragment;->access$2700(Lcom/cyjh/elfin/fragment/SplashFragment;)Landroid/widget/TextView;

    move-result-object v0

    iget-object v1, p0, Lcom/cyjh/elfin/fragment/SplashFragment$3$1;->this$1:Lcom/cyjh/elfin/fragment/SplashFragment$3;

    iget-object v1, v1, Lcom/cyjh/elfin/fragment/SplashFragment$3;->this$0:Lcom/cyjh/elfin/fragment/SplashFragment;

    const v2, 0x7f080032

    invoke-virtual {v1, v2}, Lcom/cyjh/elfin/fragment/SplashFragment;->getString(I)Ljava/lang/String;

    move-result-object v1

    const/4 v2, 0x1

    new-array v2, v2, [Ljava/lang/Object;

    iget-object v3, p0, Lcom/cyjh/elfin/fragment/SplashFragment$3$1;->this$1:Lcom/cyjh/elfin/fragment/SplashFragment$3;

    iget-object v3, v3, Lcom/cyjh/elfin/fragment/SplashFragment$3;->this$0:Lcom/cyjh/elfin/fragment/SplashFragment;

    invoke-static {v3}, Lcom/cyjh/elfin/fragment/SplashFragment;->access$2600(Lcom/cyjh/elfin/fragment/SplashFragment;)Lcom/iflytek/voiceads/NativeADDataRef;

    move-result-object v3

    invoke-virtual {v3}, Lcom/iflytek/voiceads/NativeADDataRef;->getAdSourceMark()Ljava/lang/String;

    move-result-object v3

    aput-object v3, v2, v4

    invoke-static {v1, v2}, Ljava/lang/String;->format(Ljava/lang/String;[Ljava/lang/Object;)Ljava/lang/String;

    move-result-object v1

    invoke-virtual {v0, v1}, Landroid/widget/TextView;->setText(Ljava/lang/CharSequence;)V

    .line 803
    iget-object v0, p0, Lcom/cyjh/elfin/fragment/SplashFragment$3$1;->this$1:Lcom/cyjh/elfin/fragment/SplashFragment$3;

    iget-object v0, v0, Lcom/cyjh/elfin/fragment/SplashFragment$3;->this$0:Lcom/cyjh/elfin/fragment/SplashFragment;

    invoke-static {v0}, Lcom/cyjh/elfin/fragment/SplashFragment;->access$2700(Lcom/cyjh/elfin/fragment/SplashFragment;)Landroid/widget/TextView;

    move-result-object v0

    invoke-virtual {v0, v4}, Landroid/widget/TextView;->setVisibility(I)V

    .line 805
    :cond_0
    iget-object v0, p0, Lcom/cyjh/elfin/fragment/SplashFragment$3$1;->this$1:Lcom/cyjh/elfin/fragment/SplashFragment$3;

    iget-object v0, v0, Lcom/cyjh/elfin/fragment/SplashFragment$3;->this$0:Lcom/cyjh/elfin/fragment/SplashFragment;

    invoke-static {v0}, Lcom/cyjh/elfin/fragment/SplashFragment;->access$2600(Lcom/cyjh/elfin/fragment/SplashFragment;)Lcom/iflytek/voiceads/NativeADDataRef;

    move-result-object v0

    iget-object v1, p0, Lcom/cyjh/elfin/fragment/SplashFragment$3$1;->this$1:Lcom/cyjh/elfin/fragment/SplashFragment$3;

    iget-object v1, v1, Lcom/cyjh/elfin/fragment/SplashFragment$3;->this$0:Lcom/cyjh/elfin/fragment/SplashFragment;

    invoke-static {v1}, Lcom/cyjh/elfin/fragment/SplashFragment;->access$900(Lcom/cyjh/elfin/fragment/SplashFragment;)Landroid/widget/ImageView;

    move-result-object v1

    invoke-virtual {v0, v1}, Lcom/iflytek/voiceads/NativeADDataRef;->onExposured(Landroid/view/View;)Z

    .line 806
    iget-object v0, p0, Lcom/cyjh/elfin/fragment/SplashFragment$3$1;->this$1:Lcom/cyjh/elfin/fragment/SplashFragment$3;

    iget-object v0, v0, Lcom/cyjh/elfin/fragment/SplashFragment$3;->this$0:Lcom/cyjh/elfin/fragment/SplashFragment;

    iget-object v1, p0, Lcom/cyjh/elfin/fragment/SplashFragment$3$1;->this$1:Lcom/cyjh/elfin/fragment/SplashFragment$3;

    iget-object v1, v1, Lcom/cyjh/elfin/fragment/SplashFragment$3;->this$0:Lcom/cyjh/elfin/fragment/SplashFragment;

    invoke-static {v1}, Lcom/cyjh/elfin/fragment/SplashFragment;->access$2600(Lcom/cyjh/elfin/fragment/SplashFragment;)Lcom/iflytek/voiceads/NativeADDataRef;

    move-result-object v1

    invoke-virtual {v1}, Lcom/iflytek/voiceads/NativeADDataRef;->getAdtype()Ljava/lang/String;

    move-result-object v1

    invoke-static {v0, v1}, Lcom/cyjh/elfin/fragment/SplashFragment;->access$2802(Lcom/cyjh/elfin/fragment/SplashFragment;Ljava/lang/String;)Ljava/lang/String;

    .line 808
    iget-object v0, p0, Lcom/cyjh/elfin/fragment/SplashFragment$3$1;->this$1:Lcom/cyjh/elfin/fragment/SplashFragment$3;

    iget-object v0, v0, Lcom/cyjh/elfin/fragment/SplashFragment$3;->this$0:Lcom/cyjh/elfin/fragment/SplashFragment;

    invoke-static {v0}, Lcom/cyjh/elfin/fragment/SplashFragment;->access$2900(Lcom/cyjh/elfin/fragment/SplashFragment;)Lcom/cyjh/elfin/fragment/SplashFragment$RunnableTask;

    move-result-object v0

    if-eqz v0, :cond_1

    .line 809
    iget-object v0, p0, Lcom/cyjh/elfin/fragment/SplashFragment$3$1;->this$1:Lcom/cyjh/elfin/fragment/SplashFragment$3;

    iget-object v0, v0, Lcom/cyjh/elfin/fragment/SplashFragment$3;->this$0:Lcom/cyjh/elfin/fragment/SplashFragment;

    invoke-static {v0}, Lcom/cyjh/elfin/fragment/SplashFragment;->access$800(Lcom/cyjh/elfin/fragment/SplashFragment;)Landroid/os/Handler;

    move-result-object v0

    iget-object v1, p0, Lcom/cyjh/elfin/fragment/SplashFragment$3$1;->this$1:Lcom/cyjh/elfin/fragment/SplashFragment$3;

    iget-object v1, v1, Lcom/cyjh/elfin/fragment/SplashFragment$3;->this$0:Lcom/cyjh/elfin/fragment/SplashFragment;

    invoke-static {v1}, Lcom/cyjh/elfin/fragment/SplashFragment;->access$2900(Lcom/cyjh/elfin/fragment/SplashFragment;)Lcom/cyjh/elfin/fragment/SplashFragment$RunnableTask;

    move-result-object v1

    invoke-virtual {v0, v1}, Landroid/os/Handler;->removeCallbacks(Ljava/lang/Runnable;)V

    .line 810
    iget-object v0, p0, Lcom/cyjh/elfin/fragment/SplashFragment$3$1;->this$1:Lcom/cyjh/elfin/fragment/SplashFragment$3;

    iget-object v0, v0, Lcom/cyjh/elfin/fragment/SplashFragment$3;->this$0:Lcom/cyjh/elfin/fragment/SplashFragment;

    invoke-static {v0, v5}, Lcom/cyjh/elfin/fragment/SplashFragment;->access$2902(Lcom/cyjh/elfin/fragment/SplashFragment;Lcom/cyjh/elfin/fragment/SplashFragment$RunnableTask;)Lcom/cyjh/elfin/fragment/SplashFragment$RunnableTask;

    .line 813
    :cond_1
    iget-object v0, p0, Lcom/cyjh/elfin/fragment/SplashFragment$3$1;->this$1:Lcom/cyjh/elfin/fragment/SplashFragment$3;

    iget-object v0, v0, Lcom/cyjh/elfin/fragment/SplashFragment$3;->this$0:Lcom/cyjh/elfin/fragment/SplashFragment;

    invoke-static {v0}, Lcom/cyjh/elfin/fragment/SplashFragment;->access$400(Lcom/cyjh/elfin/fragment/SplashFragment;)Lcom/cyjh/elfin/fragment/SplashFragment$CountTimeRunnable;

    move-result-object v0

    if-eqz v0, :cond_2

    .line 814
    iget-object v0, p0, Lcom/cyjh/elfin/fragment/SplashFragment$3$1;->this$1:Lcom/cyjh/elfin/fragment/SplashFragment$3;

    iget-object v0, v0, Lcom/cyjh/elfin/fragment/SplashFragment$3;->this$0:Lcom/cyjh/elfin/fragment/SplashFragment;

    invoke-static {v0}, Lcom/cyjh/elfin/fragment/SplashFragment;->access$800(Lcom/cyjh/elfin/fragment/SplashFragment;)Landroid/os/Handler;

    move-result-object v0

    iget-object v1, p0, Lcom/cyjh/elfin/fragment/SplashFragment$3$1;->this$1:Lcom/cyjh/elfin/fragment/SplashFragment$3;

    iget-object v1, v1, Lcom/cyjh/elfin/fragment/SplashFragment$3;->this$0:Lcom/cyjh/elfin/fragment/SplashFragment;

    invoke-static {v1}, Lcom/cyjh/elfin/fragment/SplashFragment;->access$400(Lcom/cyjh/elfin/fragment/SplashFragment;)Lcom/cyjh/elfin/fragment/SplashFragment$CountTimeRunnable;

    move-result-object v1

    invoke-virtual {v0, v1}, Landroid/os/Handler;->removeCallbacks(Ljava/lang/Runnable;)V

    .line 815
    iget-object v0, p0, Lcom/cyjh/elfin/fragment/SplashFragment$3$1;->this$1:Lcom/cyjh/elfin/fragment/SplashFragment$3;

    iget-object v0, v0, Lcom/cyjh/elfin/fragment/SplashFragment$3;->this$0:Lcom/cyjh/elfin/fragment/SplashFragment;

    invoke-static {v0, v5}, Lcom/cyjh/elfin/fragment/SplashFragment;->access$402(Lcom/cyjh/elfin/fragment/SplashFragment;Lcom/cyjh/elfin/fragment/SplashFragment$CountTimeRunnable;)Lcom/cyjh/elfin/fragment/SplashFragment$CountTimeRunnable;

    .line 818
    :cond_2
    iget-object v0, p0, Lcom/cyjh/elfin/fragment/SplashFragment$3$1;->this$1:Lcom/cyjh/elfin/fragment/SplashFragment$3;

    iget-object v0, v0, Lcom/cyjh/elfin/fragment/SplashFragment$3;->this$0:Lcom/cyjh/elfin/fragment/SplashFragment;

    invoke-static {v0}, Lcom/cyjh/elfin/fragment/SplashFragment;->access$1600(Lcom/cyjh/elfin/fragment/SplashFragment;)V

    .line 828
    return-void
.end method
