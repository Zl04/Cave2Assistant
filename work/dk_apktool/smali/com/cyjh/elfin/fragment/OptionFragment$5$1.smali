.class Lcom/cyjh/elfin/fragment/OptionFragment$5$1;
.super Ljava/lang/Object;
.source "OptionFragment.java"

# interfaces
.implements Lcom/squareup/picasso/Callback;


# annotations
.annotation system Ldalvik/annotation/EnclosingMethod;
    value = Lcom/cyjh/elfin/fragment/OptionFragment$5;->onADLoaded(Ljava/util/List;)V
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x0
    name = null
.end annotation


# instance fields
.field final synthetic this$1:Lcom/cyjh/elfin/fragment/OptionFragment$5;


# direct methods
.method constructor <init>(Lcom/cyjh/elfin/fragment/OptionFragment$5;)V
    .locals 0
    .param p1, "this$1"    # Lcom/cyjh/elfin/fragment/OptionFragment$5;

    .prologue
    .line 1322
    iput-object p1, p0, Lcom/cyjh/elfin/fragment/OptionFragment$5$1;->this$1:Lcom/cyjh/elfin/fragment/OptionFragment$5;

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method


# virtual methods
.method public onError()V
    .locals 2

    .prologue
    .line 1339
    const-string v0, "zzz"

    const-string v1, "OptionFragment---IFLYNativeListener--1"

    invoke-static {v0, v1}, Landroid/util/Log;->e(Ljava/lang/String;Ljava/lang/String;)I

    .line 1340
    iget-object v0, p0, Lcom/cyjh/elfin/fragment/OptionFragment$5$1;->this$1:Lcom/cyjh/elfin/fragment/OptionFragment$5;

    iget-object v0, v0, Lcom/cyjh/elfin/fragment/OptionFragment$5;->this$0:Lcom/cyjh/elfin/fragment/OptionFragment;

    const/4 v1, 0x1

    invoke-static {v0, v1}, Lcom/cyjh/elfin/fragment/OptionFragment;->access$1902(Lcom/cyjh/elfin/fragment/OptionFragment;Z)Z

    .line 1341
    iget-object v0, p0, Lcom/cyjh/elfin/fragment/OptionFragment$5$1;->this$1:Lcom/cyjh/elfin/fragment/OptionFragment$5;

    iget-object v0, v0, Lcom/cyjh/elfin/fragment/OptionFragment$5;->this$0:Lcom/cyjh/elfin/fragment/OptionFragment;

    iget-object v0, v0, Lcom/cyjh/elfin/fragment/OptionFragment;->commonLog:Lcom/cyjh/elfin/log/CommonLog;

    const-string v1, "onAdFailed:onError"

    invoke-virtual {v0, v1}, Lcom/cyjh/elfin/log/CommonLog;->e(Ljava/lang/Object;)V

    .line 1342
    iget-object v0, p0, Lcom/cyjh/elfin/fragment/OptionFragment$5$1;->this$1:Lcom/cyjh/elfin/fragment/OptionFragment$5;

    iget-object v0, v0, Lcom/cyjh/elfin/fragment/OptionFragment$5;->this$0:Lcom/cyjh/elfin/fragment/OptionFragment;

    invoke-static {v0}, Lcom/cyjh/elfin/fragment/OptionFragment;->access$1300(Lcom/cyjh/elfin/fragment/OptionFragment;)Landroid/os/Handler;

    move-result-object v0

    const/16 v1, 0x65

    invoke-virtual {v0, v1}, Landroid/os/Handler;->obtainMessage(I)Landroid/os/Message;

    move-result-object v0

    invoke-virtual {v0}, Landroid/os/Message;->sendToTarget()V

    .line 1343
    return-void
.end method

.method public onSuccess()V
    .locals 5

    .prologue
    const/4 v4, 0x0

    .line 1325
    iget-object v0, p0, Lcom/cyjh/elfin/fragment/OptionFragment$5$1;->this$1:Lcom/cyjh/elfin/fragment/OptionFragment$5;

    iget-object v0, v0, Lcom/cyjh/elfin/fragment/OptionFragment$5;->this$0:Lcom/cyjh/elfin/fragment/OptionFragment;

    invoke-static {v0}, Lcom/cyjh/elfin/fragment/OptionFragment;->access$1300(Lcom/cyjh/elfin/fragment/OptionFragment;)Landroid/os/Handler;

    move-result-object v0

    const/16 v1, 0x66

    invoke-virtual {v0, v1}, Landroid/os/Handler;->obtainMessage(I)Landroid/os/Message;

    move-result-object v0

    invoke-virtual {v0}, Landroid/os/Message;->sendToTarget()V

    .line 1326
    iget-object v0, p0, Lcom/cyjh/elfin/fragment/OptionFragment$5$1;->this$1:Lcom/cyjh/elfin/fragment/OptionFragment$5;

    iget-object v0, v0, Lcom/cyjh/elfin/fragment/OptionFragment$5;->this$0:Lcom/cyjh/elfin/fragment/OptionFragment;

    invoke-static {v0}, Lcom/cyjh/elfin/fragment/OptionFragment;->access$100(Lcom/cyjh/elfin/fragment/OptionFragment;)V

    .line 1327
    iget-object v0, p0, Lcom/cyjh/elfin/fragment/OptionFragment$5$1;->this$1:Lcom/cyjh/elfin/fragment/OptionFragment$5;

    iget-object v0, v0, Lcom/cyjh/elfin/fragment/OptionFragment$5;->this$0:Lcom/cyjh/elfin/fragment/OptionFragment;

    invoke-static {v0}, Lcom/cyjh/elfin/fragment/OptionFragment;->access$200(Lcom/cyjh/elfin/fragment/OptionFragment;)Landroid/widget/RelativeLayout;

    move-result-object v0

    invoke-virtual {v0, v4}, Landroid/widget/RelativeLayout;->setVisibility(I)V

    .line 1328
    iget-object v0, p0, Lcom/cyjh/elfin/fragment/OptionFragment$5$1;->this$1:Lcom/cyjh/elfin/fragment/OptionFragment$5;

    iget-object v0, v0, Lcom/cyjh/elfin/fragment/OptionFragment$5;->this$0:Lcom/cyjh/elfin/fragment/OptionFragment;

    invoke-static {v0}, Lcom/cyjh/elfin/fragment/OptionFragment;->access$300(Lcom/cyjh/elfin/fragment/OptionFragment;)Landroid/widget/RelativeLayout;

    move-result-object v0

    const/16 v1, 0x8

    invoke-virtual {v0, v1}, Landroid/widget/RelativeLayout;->setVisibility(I)V

    .line 1329
    iget-object v0, p0, Lcom/cyjh/elfin/fragment/OptionFragment$5$1;->this$1:Lcom/cyjh/elfin/fragment/OptionFragment$5;

    iget-object v0, v0, Lcom/cyjh/elfin/fragment/OptionFragment$5;->this$0:Lcom/cyjh/elfin/fragment/OptionFragment;

    invoke-static {v0}, Lcom/cyjh/elfin/fragment/OptionFragment;->access$1500(Lcom/cyjh/elfin/fragment/OptionFragment;)Landroid/widget/ImageView;

    move-result-object v0

    new-instance v1, Lcom/cyjh/elfin/listener/IFLYADTouchListener;

    iget-object v2, p0, Lcom/cyjh/elfin/fragment/OptionFragment$5$1;->this$1:Lcom/cyjh/elfin/fragment/OptionFragment$5;

    iget-object v2, v2, Lcom/cyjh/elfin/fragment/OptionFragment$5;->this$0:Lcom/cyjh/elfin/fragment/OptionFragment;

    invoke-static {v2}, Lcom/cyjh/elfin/fragment/OptionFragment;->access$1600(Lcom/cyjh/elfin/fragment/OptionFragment;)Lcom/iflytek/voiceads/IFLYNativeAd;

    move-result-object v2

    invoke-direct {v1, v2}, Lcom/cyjh/elfin/listener/IFLYADTouchListener;-><init>(Lcom/iflytek/voiceads/IFLYNativeAd;)V

    invoke-virtual {v0, v1}, Landroid/widget/ImageView;->setOnTouchListener(Landroid/view/View$OnTouchListener;)V

    .line 1330
    iget-object v0, p0, Lcom/cyjh/elfin/fragment/OptionFragment$5$1;->this$1:Lcom/cyjh/elfin/fragment/OptionFragment$5;

    iget-object v0, v0, Lcom/cyjh/elfin/fragment/OptionFragment$5;->this$0:Lcom/cyjh/elfin/fragment/OptionFragment;

    invoke-static {v0}, Lcom/cyjh/elfin/fragment/OptionFragment;->access$1700(Lcom/cyjh/elfin/fragment/OptionFragment;)Landroid/widget/TextView;

    move-result-object v0

    new-instance v1, Lcom/cyjh/elfin/listener/IFLYADTouchListener;

    iget-object v2, p0, Lcom/cyjh/elfin/fragment/OptionFragment$5$1;->this$1:Lcom/cyjh/elfin/fragment/OptionFragment$5;

    iget-object v2, v2, Lcom/cyjh/elfin/fragment/OptionFragment$5;->this$0:Lcom/cyjh/elfin/fragment/OptionFragment;

    invoke-static {v2}, Lcom/cyjh/elfin/fragment/OptionFragment;->access$1600(Lcom/cyjh/elfin/fragment/OptionFragment;)Lcom/iflytek/voiceads/IFLYNativeAd;

    move-result-object v2

    invoke-direct {v1, v2}, Lcom/cyjh/elfin/listener/IFLYADTouchListener;-><init>(Lcom/iflytek/voiceads/IFLYNativeAd;)V

    invoke-virtual {v0, v1}, Landroid/widget/TextView;->setOnTouchListener(Landroid/view/View$OnTouchListener;)V

    .line 1331
    iget-object v0, p0, Lcom/cyjh/elfin/fragment/OptionFragment$5$1;->this$1:Lcom/cyjh/elfin/fragment/OptionFragment$5;

    iget-object v0, v0, Lcom/cyjh/elfin/fragment/OptionFragment$5;->this$0:Lcom/cyjh/elfin/fragment/OptionFragment;

    invoke-static {v0}, Lcom/cyjh/elfin/fragment/OptionFragment;->access$1400(Lcom/cyjh/elfin/fragment/OptionFragment;)Lcom/iflytek/voiceads/NativeADDataRef;

    move-result-object v0

    iget-object v1, p0, Lcom/cyjh/elfin/fragment/OptionFragment$5$1;->this$1:Lcom/cyjh/elfin/fragment/OptionFragment$5;

    iget-object v1, v1, Lcom/cyjh/elfin/fragment/OptionFragment$5;->this$0:Lcom/cyjh/elfin/fragment/OptionFragment;

    invoke-static {v1}, Lcom/cyjh/elfin/fragment/OptionFragment;->access$200(Lcom/cyjh/elfin/fragment/OptionFragment;)Landroid/widget/RelativeLayout;

    move-result-object v1

    invoke-virtual {v0, v1}, Lcom/iflytek/voiceads/NativeADDataRef;->onExposured(Landroid/view/View;)Z

    .line 1332
    iget-object v0, p0, Lcom/cyjh/elfin/fragment/OptionFragment$5$1;->this$1:Lcom/cyjh/elfin/fragment/OptionFragment$5;

    iget-object v0, v0, Lcom/cyjh/elfin/fragment/OptionFragment$5;->this$0:Lcom/cyjh/elfin/fragment/OptionFragment;

    invoke-static {v0}, Lcom/cyjh/elfin/fragment/OptionFragment;->access$1400(Lcom/cyjh/elfin/fragment/OptionFragment;)Lcom/iflytek/voiceads/NativeADDataRef;

    move-result-object v0

    invoke-virtual {v0}, Lcom/iflytek/voiceads/NativeADDataRef;->getAdSourceMark()Ljava/lang/String;

    move-result-object v0

    invoke-static {v0}, Landroid/text/TextUtils;->isEmpty(Ljava/lang/CharSequence;)Z

    move-result v0

    if-nez v0, :cond_0

    .line 1333
    iget-object v0, p0, Lcom/cyjh/elfin/fragment/OptionFragment$5$1;->this$1:Lcom/cyjh/elfin/fragment/OptionFragment$5;

    iget-object v0, v0, Lcom/cyjh/elfin/fragment/OptionFragment$5;->this$0:Lcom/cyjh/elfin/fragment/OptionFragment;

    invoke-static {v0}, Lcom/cyjh/elfin/fragment/OptionFragment;->access$1800(Lcom/cyjh/elfin/fragment/OptionFragment;)Landroid/widget/TextView;

    move-result-object v0

    iget-object v1, p0, Lcom/cyjh/elfin/fragment/OptionFragment$5$1;->this$1:Lcom/cyjh/elfin/fragment/OptionFragment$5;

    iget-object v1, v1, Lcom/cyjh/elfin/fragment/OptionFragment$5;->this$0:Lcom/cyjh/elfin/fragment/OptionFragment;

    const v2, 0x7f080032

    invoke-virtual {v1, v2}, Lcom/cyjh/elfin/fragment/OptionFragment;->getString(I)Ljava/lang/String;

    move-result-object v1

    const/4 v2, 0x1

    new-array v2, v2, [Ljava/lang/Object;

    iget-object v3, p0, Lcom/cyjh/elfin/fragment/OptionFragment$5$1;->this$1:Lcom/cyjh/elfin/fragment/OptionFragment$5;

    iget-object v3, v3, Lcom/cyjh/elfin/fragment/OptionFragment$5;->this$0:Lcom/cyjh/elfin/fragment/OptionFragment;

    invoke-static {v3}, Lcom/cyjh/elfin/fragment/OptionFragment;->access$1400(Lcom/cyjh/elfin/fragment/OptionFragment;)Lcom/iflytek/voiceads/NativeADDataRef;

    move-result-object v3

    invoke-virtual {v3}, Lcom/iflytek/voiceads/NativeADDataRef;->getAdSourceMark()Ljava/lang/String;

    move-result-object v3

    aput-object v3, v2, v4

    invoke-static {v1, v2}, Ljava/lang/String;->format(Ljava/lang/String;[Ljava/lang/Object;)Ljava/lang/String;

    move-result-object v1

    invoke-virtual {v0, v1}, Landroid/widget/TextView;->setText(Ljava/lang/CharSequence;)V

    .line 1334
    iget-object v0, p0, Lcom/cyjh/elfin/fragment/OptionFragment$5$1;->this$1:Lcom/cyjh/elfin/fragment/OptionFragment$5;

    iget-object v0, v0, Lcom/cyjh/elfin/fragment/OptionFragment$5;->this$0:Lcom/cyjh/elfin/fragment/OptionFragment;

    invoke-static {v0}, Lcom/cyjh/elfin/fragment/OptionFragment;->access$1800(Lcom/cyjh/elfin/fragment/OptionFragment;)Landroid/widget/TextView;

    move-result-object v0

    invoke-virtual {v0, v4}, Landroid/widget/TextView;->setVisibility(I)V

    .line 1336
    :cond_0
    return-void
.end method
