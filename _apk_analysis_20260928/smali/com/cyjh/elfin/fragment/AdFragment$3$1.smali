.class Lcom/cyjh/elfin/fragment/AdFragment$3$1;
.super Ljava/lang/Object;
.source "AdFragment.java"

# interfaces
.implements Lcom/squareup/picasso/Callback;


# annotations
.annotation system Ldalvik/annotation/EnclosingMethod;
    value = Lcom/cyjh/elfin/fragment/AdFragment$3;->onADLoaded(Ljava/util/List;)V
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x0
    name = null
.end annotation


# instance fields
.field final synthetic this$1:Lcom/cyjh/elfin/fragment/AdFragment$3;


# direct methods
.method constructor <init>(Lcom/cyjh/elfin/fragment/AdFragment$3;)V
    .locals 0
    .param p1, "this$1"    # Lcom/cyjh/elfin/fragment/AdFragment$3;

    .prologue
    .line 418
    iput-object p1, p0, Lcom/cyjh/elfin/fragment/AdFragment$3$1;->this$1:Lcom/cyjh/elfin/fragment/AdFragment$3;

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method


# virtual methods
.method public onError()V
    .locals 1

    .prologue
    .line 439
    iget-object v0, p0, Lcom/cyjh/elfin/fragment/AdFragment$3$1;->this$1:Lcom/cyjh/elfin/fragment/AdFragment$3;

    iget-object v0, v0, Lcom/cyjh/elfin/fragment/AdFragment$3;->this$0:Lcom/cyjh/elfin/fragment/AdFragment;

    invoke-static {v0}, Lcom/cyjh/elfin/fragment/AdFragment;->access$1200(Lcom/cyjh/elfin/fragment/AdFragment;)V

    .line 440
    return-void
.end method

.method public onSuccess()V
    .locals 5

    .prologue
    const/4 v3, 0x1

    const/4 v4, 0x0

    .line 421
    const-string v0, "zzz"

    const-string v1, "AdFragment---displayXunFeiAdTwoSuc---"

    invoke-static {v0, v1}, Landroid/util/Log;->e(Ljava/lang/String;Ljava/lang/String;)I

    .line 422
    iget-object v0, p0, Lcom/cyjh/elfin/fragment/AdFragment$3$1;->this$1:Lcom/cyjh/elfin/fragment/AdFragment$3;

    iget-object v0, v0, Lcom/cyjh/elfin/fragment/AdFragment$3;->this$0:Lcom/cyjh/elfin/fragment/AdFragment;

    invoke-static {v0}, Lcom/cyjh/elfin/fragment/AdFragment;->access$800(Lcom/cyjh/elfin/fragment/AdFragment;)Lcom/cyjh/elfin/fragment/AdFragment$CloseAdTimer;

    move-result-object v0

    if-eqz v0, :cond_0

    .line 423
    iget-object v0, p0, Lcom/cyjh/elfin/fragment/AdFragment$3$1;->this$1:Lcom/cyjh/elfin/fragment/AdFragment$3;

    iget-object v0, v0, Lcom/cyjh/elfin/fragment/AdFragment$3;->this$0:Lcom/cyjh/elfin/fragment/AdFragment;

    invoke-static {v0}, Lcom/cyjh/elfin/fragment/AdFragment;->access$800(Lcom/cyjh/elfin/fragment/AdFragment;)Lcom/cyjh/elfin/fragment/AdFragment$CloseAdTimer;

    move-result-object v0

    invoke-virtual {v0}, Lcom/cyjh/elfin/fragment/AdFragment$CloseAdTimer;->cancel()V

    .line 424
    iget-object v0, p0, Lcom/cyjh/elfin/fragment/AdFragment$3$1;->this$1:Lcom/cyjh/elfin/fragment/AdFragment$3;

    iget-object v0, v0, Lcom/cyjh/elfin/fragment/AdFragment$3;->this$0:Lcom/cyjh/elfin/fragment/AdFragment;

    const/4 v1, 0x0

    invoke-static {v0, v1}, Lcom/cyjh/elfin/fragment/AdFragment;->access$802(Lcom/cyjh/elfin/fragment/AdFragment;Lcom/cyjh/elfin/fragment/AdFragment$CloseAdTimer;)Lcom/cyjh/elfin/fragment/AdFragment$CloseAdTimer;

    .line 426
    :cond_0
    iget-object v0, p0, Lcom/cyjh/elfin/fragment/AdFragment$3$1;->this$1:Lcom/cyjh/elfin/fragment/AdFragment$3;

    iget-object v0, v0, Lcom/cyjh/elfin/fragment/AdFragment$3;->this$0:Lcom/cyjh/elfin/fragment/AdFragment;

    invoke-static {v0, v3}, Lcom/cyjh/elfin/fragment/AdFragment;->access$902(Lcom/cyjh/elfin/fragment/AdFragment;Z)Z

    .line 427
    iget-object v0, p0, Lcom/cyjh/elfin/fragment/AdFragment$3$1;->this$1:Lcom/cyjh/elfin/fragment/AdFragment$3;

    iget-object v0, v0, Lcom/cyjh/elfin/fragment/AdFragment$3;->this$0:Lcom/cyjh/elfin/fragment/AdFragment;

    invoke-static {v0}, Lcom/cyjh/elfin/fragment/AdFragment;->access$700(Lcom/cyjh/elfin/fragment/AdFragment;)Landroid/widget/ImageView;

    move-result-object v0

    new-instance v1, Lcom/cyjh/elfin/listener/IFLYADTouchListener;

    iget-object v2, p0, Lcom/cyjh/elfin/fragment/AdFragment$3$1;->this$1:Lcom/cyjh/elfin/fragment/AdFragment$3;

    iget-object v2, v2, Lcom/cyjh/elfin/fragment/AdFragment$3;->this$0:Lcom/cyjh/elfin/fragment/AdFragment;

    invoke-static {v2}, Lcom/cyjh/elfin/fragment/AdFragment;->access$1000(Lcom/cyjh/elfin/fragment/AdFragment;)Lcom/iflytek/voiceads/IFLYNativeAd;

    move-result-object v2

    invoke-direct {v1, v2}, Lcom/cyjh/elfin/listener/IFLYADTouchListener;-><init>(Lcom/iflytek/voiceads/IFLYNativeAd;)V

    invoke-virtual {v0, v1}, Landroid/widget/ImageView;->setOnTouchListener(Landroid/view/View$OnTouchListener;)V

    .line 428
    iget-object v0, p0, Lcom/cyjh/elfin/fragment/AdFragment$3$1;->this$1:Lcom/cyjh/elfin/fragment/AdFragment$3;

    iget-object v0, v0, Lcom/cyjh/elfin/fragment/AdFragment$3;->this$0:Lcom/cyjh/elfin/fragment/AdFragment;

    invoke-static {v0}, Lcom/cyjh/elfin/fragment/AdFragment;->access$200(Lcom/cyjh/elfin/fragment/AdFragment;)Landroid/widget/TextView;

    move-result-object v0

    new-instance v1, Lcom/cyjh/elfin/listener/IFLYADTouchListener;

    iget-object v2, p0, Lcom/cyjh/elfin/fragment/AdFragment$3$1;->this$1:Lcom/cyjh/elfin/fragment/AdFragment$3;

    iget-object v2, v2, Lcom/cyjh/elfin/fragment/AdFragment$3;->this$0:Lcom/cyjh/elfin/fragment/AdFragment;

    invoke-static {v2}, Lcom/cyjh/elfin/fragment/AdFragment;->access$1000(Lcom/cyjh/elfin/fragment/AdFragment;)Lcom/iflytek/voiceads/IFLYNativeAd;

    move-result-object v2

    invoke-direct {v1, v2}, Lcom/cyjh/elfin/listener/IFLYADTouchListener;-><init>(Lcom/iflytek/voiceads/IFLYNativeAd;)V

    invoke-virtual {v0, v1}, Landroid/widget/TextView;->setOnTouchListener(Landroid/view/View$OnTouchListener;)V

    .line 429
    iget-object v0, p0, Lcom/cyjh/elfin/fragment/AdFragment$3$1;->this$1:Lcom/cyjh/elfin/fragment/AdFragment$3;

    iget-object v0, v0, Lcom/cyjh/elfin/fragment/AdFragment$3;->this$0:Lcom/cyjh/elfin/fragment/AdFragment;

    invoke-static {v0}, Lcom/cyjh/elfin/fragment/AdFragment;->access$200(Lcom/cyjh/elfin/fragment/AdFragment;)Landroid/widget/TextView;

    move-result-object v0

    invoke-virtual {v0, v4}, Landroid/widget/TextView;->setVisibility(I)V

    .line 430
    iget-object v0, p0, Lcom/cyjh/elfin/fragment/AdFragment$3$1;->this$1:Lcom/cyjh/elfin/fragment/AdFragment$3;

    iget-object v0, v0, Lcom/cyjh/elfin/fragment/AdFragment$3;->this$0:Lcom/cyjh/elfin/fragment/AdFragment;

    invoke-virtual {v0}, Lcom/cyjh/elfin/fragment/AdFragment;->isAdded()Z

    move-result v0

    if-eqz v0, :cond_1

    iget-object v0, p0, Lcom/cyjh/elfin/fragment/AdFragment$3$1;->this$1:Lcom/cyjh/elfin/fragment/AdFragment$3;

    iget-object v0, v0, Lcom/cyjh/elfin/fragment/AdFragment$3;->this$0:Lcom/cyjh/elfin/fragment/AdFragment;

    invoke-static {v0}, Lcom/cyjh/elfin/fragment/AdFragment;->access$600(Lcom/cyjh/elfin/fragment/AdFragment;)Lcom/iflytek/voiceads/NativeADDataRef;

    move-result-object v0

    invoke-virtual {v0}, Lcom/iflytek/voiceads/NativeADDataRef;->getAdSourceMark()Ljava/lang/String;

    move-result-object v0

    invoke-static {v0}, Landroid/text/TextUtils;->isEmpty(Ljava/lang/CharSequence;)Z

    move-result v0

    if-nez v0, :cond_1

    .line 431
    iget-object v0, p0, Lcom/cyjh/elfin/fragment/AdFragment$3$1;->this$1:Lcom/cyjh/elfin/fragment/AdFragment$3;

    iget-object v0, v0, Lcom/cyjh/elfin/fragment/AdFragment$3;->this$0:Lcom/cyjh/elfin/fragment/AdFragment;

    invoke-static {v0}, Lcom/cyjh/elfin/fragment/AdFragment;->access$1100(Lcom/cyjh/elfin/fragment/AdFragment;)Landroid/widget/TextView;

    move-result-object v0

    iget-object v1, p0, Lcom/cyjh/elfin/fragment/AdFragment$3$1;->this$1:Lcom/cyjh/elfin/fragment/AdFragment$3;

    iget-object v1, v1, Lcom/cyjh/elfin/fragment/AdFragment$3;->this$0:Lcom/cyjh/elfin/fragment/AdFragment;

    const v2, 0x7f080032

    invoke-virtual {v1, v2}, Lcom/cyjh/elfin/fragment/AdFragment;->getString(I)Ljava/lang/String;

    move-result-object v1

    new-array v2, v3, [Ljava/lang/Object;

    iget-object v3, p0, Lcom/cyjh/elfin/fragment/AdFragment$3$1;->this$1:Lcom/cyjh/elfin/fragment/AdFragment$3;

    iget-object v3, v3, Lcom/cyjh/elfin/fragment/AdFragment$3;->this$0:Lcom/cyjh/elfin/fragment/AdFragment;

    invoke-static {v3}, Lcom/cyjh/elfin/fragment/AdFragment;->access$600(Lcom/cyjh/elfin/fragment/AdFragment;)Lcom/iflytek/voiceads/NativeADDataRef;

    move-result-object v3

    invoke-virtual {v3}, Lcom/iflytek/voiceads/NativeADDataRef;->getAdSourceMark()Ljava/lang/String;

    move-result-object v3

    aput-object v3, v2, v4

    invoke-static {v1, v2}, Ljava/lang/String;->format(Ljava/lang/String;[Ljava/lang/Object;)Ljava/lang/String;

    move-result-object v1

    invoke-virtual {v0, v1}, Landroid/widget/TextView;->setText(Ljava/lang/CharSequence;)V

    .line 432
    iget-object v0, p0, Lcom/cyjh/elfin/fragment/AdFragment$3$1;->this$1:Lcom/cyjh/elfin/fragment/AdFragment$3;

    iget-object v0, v0, Lcom/cyjh/elfin/fragment/AdFragment$3;->this$0:Lcom/cyjh/elfin/fragment/AdFragment;

    invoke-static {v0}, Lcom/cyjh/elfin/fragment/AdFragment;->access$1100(Lcom/cyjh/elfin/fragment/AdFragment;)Landroid/widget/TextView;

    move-result-object v0

    invoke-virtual {v0, v4}, Landroid/widget/TextView;->setVisibility(I)V

    .line 434
    :cond_1
    iget-object v0, p0, Lcom/cyjh/elfin/fragment/AdFragment$3$1;->this$1:Lcom/cyjh/elfin/fragment/AdFragment$3;

    iget-object v0, v0, Lcom/cyjh/elfin/fragment/AdFragment$3;->this$0:Lcom/cyjh/elfin/fragment/AdFragment;

    invoke-static {v0}, Lcom/cyjh/elfin/fragment/AdFragment;->access$600(Lcom/cyjh/elfin/fragment/AdFragment;)Lcom/iflytek/voiceads/NativeADDataRef;

    move-result-object v0

    iget-object v1, p0, Lcom/cyjh/elfin/fragment/AdFragment$3$1;->this$1:Lcom/cyjh/elfin/fragment/AdFragment$3;

    iget-object v1, v1, Lcom/cyjh/elfin/fragment/AdFragment$3;->this$0:Lcom/cyjh/elfin/fragment/AdFragment;

    invoke-static {v1}, Lcom/cyjh/elfin/fragment/AdFragment;->access$700(Lcom/cyjh/elfin/fragment/AdFragment;)Landroid/widget/ImageView;

    move-result-object v1

    invoke-virtual {v0, v1}, Lcom/iflytek/voiceads/NativeADDataRef;->onExposured(Landroid/view/View;)Z

    .line 435
    iget-object v0, p0, Lcom/cyjh/elfin/fragment/AdFragment$3$1;->this$1:Lcom/cyjh/elfin/fragment/AdFragment$3;

    iget-object v0, v0, Lcom/cyjh/elfin/fragment/AdFragment$3;->this$0:Lcom/cyjh/elfin/fragment/AdFragment;

    invoke-static {v0}, Lcom/cyjh/elfin/fragment/AdFragment;->access$300(Lcom/cyjh/elfin/fragment/AdFragment;)Lcom/cyjh/elfin/fragment/AdFragment$SubmitCountTimer;

    move-result-object v0

    invoke-virtual {v0}, Lcom/cyjh/elfin/fragment/AdFragment$SubmitCountTimer;->start()Landroid/os/CountDownTimer;

    .line 436
    return-void
.end method
