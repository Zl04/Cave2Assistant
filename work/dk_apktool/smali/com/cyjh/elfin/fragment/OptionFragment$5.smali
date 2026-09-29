.class Lcom/cyjh/elfin/fragment/OptionFragment$5;
.super Lcom/cyjh/elfin/listener/IFLYADListener;
.source "OptionFragment.java"


# annotations
.annotation system Ldalvik/annotation/EnclosingClass;
    value = Lcom/cyjh/elfin/fragment/OptionFragment;
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x0
    name = null
.end annotation


# instance fields
.field final synthetic this$0:Lcom/cyjh/elfin/fragment/OptionFragment;


# direct methods
.method constructor <init>(Lcom/cyjh/elfin/fragment/OptionFragment;)V
    .locals 0
    .param p1, "this$0"    # Lcom/cyjh/elfin/fragment/OptionFragment;

    .prologue
    .line 1315
    iput-object p1, p0, Lcom/cyjh/elfin/fragment/OptionFragment$5;->this$0:Lcom/cyjh/elfin/fragment/OptionFragment;

    invoke-direct {p0}, Lcom/cyjh/elfin/listener/IFLYADListener;-><init>()V

    return-void
.end method


# virtual methods
.method public onADLoaded(Ljava/util/List;)V
    .locals 4
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
    .line 1318
    .local p1, "list":Ljava/util/List;, "Ljava/util/List<Lcom/iflytek/voiceads/NativeADDataRef;>;"
    invoke-interface {p1}, Ljava/util/List;->size()I

    move-result v1

    if-lez v1, :cond_0

    .line 1319
    iget-object v2, p0, Lcom/cyjh/elfin/fragment/OptionFragment$5;->this$0:Lcom/cyjh/elfin/fragment/OptionFragment;

    const/4 v1, 0x0

    invoke-interface {p1, v1}, Ljava/util/List;->get(I)Ljava/lang/Object;

    move-result-object v1

    check-cast v1, Lcom/iflytek/voiceads/NativeADDataRef;

    invoke-static {v2, v1}, Lcom/cyjh/elfin/fragment/OptionFragment;->access$1402(Lcom/cyjh/elfin/fragment/OptionFragment;Lcom/iflytek/voiceads/NativeADDataRef;)Lcom/iflytek/voiceads/NativeADDataRef;

    .line 1320
    iget-object v1, p0, Lcom/cyjh/elfin/fragment/OptionFragment$5;->this$0:Lcom/cyjh/elfin/fragment/OptionFragment;

    invoke-static {v1}, Lcom/cyjh/elfin/fragment/OptionFragment;->access$1400(Lcom/cyjh/elfin/fragment/OptionFragment;)Lcom/iflytek/voiceads/NativeADDataRef;

    move-result-object v1

    invoke-virtual {v1}, Lcom/iflytek/voiceads/NativeADDataRef;->getImage()Ljava/lang/String;

    move-result-object v0

    .line 1321
    .local v0, "url":Ljava/lang/String;
    const-string v1, "zzz"

    new-instance v2, Ljava/lang/StringBuilder;

    invoke-direct {v2}, Ljava/lang/StringBuilder;-><init>()V

    const-string v3, "OptionFragment--\u52a0\u8f7d\u8baf\u98de\u6210\u529furl--"

    invoke-virtual {v2, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    invoke-virtual {v2, v0}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    invoke-virtual {v2}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v2

    invoke-static {v1, v2}, Landroid/util/Log;->e(Ljava/lang/String;Ljava/lang/String;)I

    .line 1322
    iget-object v1, p0, Lcom/cyjh/elfin/fragment/OptionFragment$5;->this$0:Lcom/cyjh/elfin/fragment/OptionFragment;

    invoke-virtual {v1}, Lcom/cyjh/elfin/fragment/OptionFragment;->getActivity()Landroid/support/v4/app/FragmentActivity;

    move-result-object v1

    invoke-static {v1}, Lcom/squareup/picasso/Picasso;->with(Landroid/content/Context;)Lcom/squareup/picasso/Picasso;

    move-result-object v1

    invoke-virtual {v1, v0}, Lcom/squareup/picasso/Picasso;->load(Ljava/lang/String;)Lcom/squareup/picasso/RequestCreator;

    move-result-object v1

    iget-object v2, p0, Lcom/cyjh/elfin/fragment/OptionFragment$5;->this$0:Lcom/cyjh/elfin/fragment/OptionFragment;

    invoke-static {v2}, Lcom/cyjh/elfin/fragment/OptionFragment;->access$1500(Lcom/cyjh/elfin/fragment/OptionFragment;)Landroid/widget/ImageView;

    move-result-object v2

    new-instance v3, Lcom/cyjh/elfin/fragment/OptionFragment$5$1;

    invoke-direct {v3, p0}, Lcom/cyjh/elfin/fragment/OptionFragment$5$1;-><init>(Lcom/cyjh/elfin/fragment/OptionFragment$5;)V

    invoke-virtual {v1, v2, v3}, Lcom/squareup/picasso/RequestCreator;->into(Landroid/widget/ImageView;Lcom/squareup/picasso/Callback;)V

    .line 1351
    .end local v0    # "url":Ljava/lang/String;
    :goto_0
    return-void

    .line 1346
    :cond_0
    const-string v1, "zzz"

    const-string v2, "OptionFragment---IFLYNativeListener--2"

    invoke-static {v1, v2}, Landroid/util/Log;->e(Ljava/lang/String;Ljava/lang/String;)I

    .line 1347
    iget-object v1, p0, Lcom/cyjh/elfin/fragment/OptionFragment$5;->this$0:Lcom/cyjh/elfin/fragment/OptionFragment;

    const/4 v2, 0x1

    invoke-static {v1, v2}, Lcom/cyjh/elfin/fragment/OptionFragment;->access$1902(Lcom/cyjh/elfin/fragment/OptionFragment;Z)Z

    .line 1348
    iget-object v1, p0, Lcom/cyjh/elfin/fragment/OptionFragment$5;->this$0:Lcom/cyjh/elfin/fragment/OptionFragment;

    iget-object v1, v1, Lcom/cyjh/elfin/fragment/OptionFragment;->commonLog:Lcom/cyjh/elfin/log/CommonLog;

    const-string v2, "onAdFailed:onError"

    invoke-virtual {v1, v2}, Lcom/cyjh/elfin/log/CommonLog;->e(Ljava/lang/Object;)V

    .line 1349
    iget-object v1, p0, Lcom/cyjh/elfin/fragment/OptionFragment$5;->this$0:Lcom/cyjh/elfin/fragment/OptionFragment;

    invoke-static {v1}, Lcom/cyjh/elfin/fragment/OptionFragment;->access$1300(Lcom/cyjh/elfin/fragment/OptionFragment;)Landroid/os/Handler;

    move-result-object v1

    const/16 v2, 0x65

    invoke-virtual {v1, v2}, Landroid/os/Handler;->obtainMessage(I)Landroid/os/Message;

    move-result-object v1

    invoke-virtual {v1}, Landroid/os/Message;->sendToTarget()V

    goto :goto_0
.end method

.method public onAdFailed(Lcom/iflytek/voiceads/AdError;)V
    .locals 3
    .param p1, "adError"    # Lcom/iflytek/voiceads/AdError;

    .prologue
    .line 1355
    const-string v0, "zzz"

    new-instance v1, Ljava/lang/StringBuilder;

    invoke-direct {v1}, Ljava/lang/StringBuilder;-><init>()V

    const-string v2, "OptionFragment---IFLYNativeListener--3"

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {p1}, Lcom/iflytek/voiceads/AdError;->getErrorDescription()Ljava/lang/String;

    move-result-object v2

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    const-string v2, ",--"

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {p1}, Lcom/iflytek/voiceads/AdError;->getMessage()Ljava/lang/String;

    move-result-object v2

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v1

    invoke-static {v0, v1}, Landroid/util/Log;->e(Ljava/lang/String;Ljava/lang/String;)I

    .line 1356
    iget-object v0, p0, Lcom/cyjh/elfin/fragment/OptionFragment$5;->this$0:Lcom/cyjh/elfin/fragment/OptionFragment;

    const/4 v1, 0x1

    invoke-static {v0, v1}, Lcom/cyjh/elfin/fragment/OptionFragment;->access$1902(Lcom/cyjh/elfin/fragment/OptionFragment;Z)Z

    .line 1357
    iget-object v0, p0, Lcom/cyjh/elfin/fragment/OptionFragment$5;->this$0:Lcom/cyjh/elfin/fragment/OptionFragment;

    iget-object v0, v0, Lcom/cyjh/elfin/fragment/OptionFragment;->commonLog:Lcom/cyjh/elfin/log/CommonLog;

    new-instance v1, Ljava/lang/StringBuilder;

    invoke-direct {v1}, Ljava/lang/StringBuilder;-><init>()V

    const-string v2, "onAdFailed:onAdFailed(AdError adError)"

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {p1}, Lcom/iflytek/voiceads/AdError;->getErrorDescription()Ljava/lang/String;

    move-result-object v2

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    const-string v2, ",--"

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {p1}, Lcom/iflytek/voiceads/AdError;->getMessage()Ljava/lang/String;

    move-result-object v2

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v1

    invoke-virtual {v0, v1}, Lcom/cyjh/elfin/log/CommonLog;->e(Ljava/lang/Object;)V

    .line 1358
    iget-object v0, p0, Lcom/cyjh/elfin/fragment/OptionFragment$5;->this$0:Lcom/cyjh/elfin/fragment/OptionFragment;

    invoke-static {v0}, Lcom/cyjh/elfin/fragment/OptionFragment;->access$1300(Lcom/cyjh/elfin/fragment/OptionFragment;)Landroid/os/Handler;

    move-result-object v0

    const/16 v1, 0x65

    invoke-virtual {v0, v1}, Landroid/os/Handler;->obtainMessage(I)Landroid/os/Message;

    move-result-object v0

    invoke-virtual {v0}, Landroid/os/Message;->sendToTarget()V

    .line 1359
    return-void
.end method
