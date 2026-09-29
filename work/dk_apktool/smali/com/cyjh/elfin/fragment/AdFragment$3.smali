.class Lcom/cyjh/elfin/fragment/AdFragment$3;
.super Lcom/cyjh/elfin/listener/IFLYADListener;
.source "AdFragment.java"


# annotations
.annotation system Ldalvik/annotation/EnclosingClass;
    value = Lcom/cyjh/elfin/fragment/AdFragment;
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x0
    name = null
.end annotation


# instance fields
.field final synthetic this$0:Lcom/cyjh/elfin/fragment/AdFragment;


# direct methods
.method constructor <init>(Lcom/cyjh/elfin/fragment/AdFragment;)V
    .locals 0
    .param p1, "this$0"    # Lcom/cyjh/elfin/fragment/AdFragment;

    .prologue
    .line 411
    iput-object p1, p0, Lcom/cyjh/elfin/fragment/AdFragment$3;->this$0:Lcom/cyjh/elfin/fragment/AdFragment;

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
    .line 414
    .local p1, "list":Ljava/util/List;, "Ljava/util/List<Lcom/iflytek/voiceads/NativeADDataRef;>;"
    invoke-interface {p1}, Ljava/util/List;->size()I

    move-result v0

    if-lez v0, :cond_0

    .line 415
    iget-object v1, p0, Lcom/cyjh/elfin/fragment/AdFragment$3;->this$0:Lcom/cyjh/elfin/fragment/AdFragment;

    const/4 v0, 0x0

    invoke-interface {p1, v0}, Ljava/util/List;->get(I)Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Lcom/iflytek/voiceads/NativeADDataRef;

    invoke-static {v1, v0}, Lcom/cyjh/elfin/fragment/AdFragment;->access$602(Lcom/cyjh/elfin/fragment/AdFragment;Lcom/iflytek/voiceads/NativeADDataRef;)Lcom/iflytek/voiceads/NativeADDataRef;

    .line 416
    iget-object v0, p0, Lcom/cyjh/elfin/fragment/AdFragment$3;->this$0:Lcom/cyjh/elfin/fragment/AdFragment;

    iget-object v0, v0, Lcom/cyjh/elfin/fragment/AdFragment;->commonLog:Lcom/cyjh/elfin/log/CommonLog;

    new-instance v1, Ljava/lang/StringBuilder;

    invoke-direct {v1}, Ljava/lang/StringBuilder;-><init>()V

    const-string v2, "aditem:"

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    iget-object v2, p0, Lcom/cyjh/elfin/fragment/AdFragment$3;->this$0:Lcom/cyjh/elfin/fragment/AdFragment;

    invoke-static {v2}, Lcom/cyjh/elfin/fragment/AdFragment;->access$600(Lcom/cyjh/elfin/fragment/AdFragment;)Lcom/iflytek/voiceads/NativeADDataRef;

    move-result-object v2

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/Object;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v1

    invoke-virtual {v0, v1}, Lcom/cyjh/elfin/log/CommonLog;->e(Ljava/lang/Object;)V

    .line 417
    const-string v0, "zzz"

    new-instance v1, Ljava/lang/StringBuilder;

    invoke-direct {v1}, Ljava/lang/StringBuilder;-><init>()V

    const-string v2, "AdFragment--url--"

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    iget-object v2, p0, Lcom/cyjh/elfin/fragment/AdFragment$3;->this$0:Lcom/cyjh/elfin/fragment/AdFragment;

    invoke-static {v2}, Lcom/cyjh/elfin/fragment/AdFragment;->access$600(Lcom/cyjh/elfin/fragment/AdFragment;)Lcom/iflytek/voiceads/NativeADDataRef;

    move-result-object v2

    invoke-virtual {v2}, Lcom/iflytek/voiceads/NativeADDataRef;->getImage()Ljava/lang/String;

    move-result-object v2

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v1

    invoke-static {v0, v1}, Landroid/util/Log;->e(Ljava/lang/String;Ljava/lang/String;)I

    .line 418
    iget-object v0, p0, Lcom/cyjh/elfin/fragment/AdFragment$3;->this$0:Lcom/cyjh/elfin/fragment/AdFragment;

    iget-object v0, v0, Lcom/cyjh/elfin/fragment/AdFragment;->appContext:Lcom/cyjh/elfin/AppContext;

    invoke-static {v0}, Lcom/squareup/picasso/Picasso;->with(Landroid/content/Context;)Lcom/squareup/picasso/Picasso;

    move-result-object v0

    iget-object v1, p0, Lcom/cyjh/elfin/fragment/AdFragment$3;->this$0:Lcom/cyjh/elfin/fragment/AdFragment;

    invoke-static {v1}, Lcom/cyjh/elfin/fragment/AdFragment;->access$600(Lcom/cyjh/elfin/fragment/AdFragment;)Lcom/iflytek/voiceads/NativeADDataRef;

    move-result-object v1

    invoke-virtual {v1}, Lcom/iflytek/voiceads/NativeADDataRef;->getImage()Ljava/lang/String;

    move-result-object v1

    invoke-virtual {v0, v1}, Lcom/squareup/picasso/Picasso;->load(Ljava/lang/String;)Lcom/squareup/picasso/RequestCreator;

    move-result-object v0

    iget-object v1, p0, Lcom/cyjh/elfin/fragment/AdFragment$3;->this$0:Lcom/cyjh/elfin/fragment/AdFragment;

    invoke-static {v1}, Lcom/cyjh/elfin/fragment/AdFragment;->access$700(Lcom/cyjh/elfin/fragment/AdFragment;)Landroid/widget/ImageView;

    move-result-object v1

    new-instance v2, Lcom/cyjh/elfin/fragment/AdFragment$3$1;

    invoke-direct {v2, p0}, Lcom/cyjh/elfin/fragment/AdFragment$3$1;-><init>(Lcom/cyjh/elfin/fragment/AdFragment$3;)V

    invoke-virtual {v0, v1, v2}, Lcom/squareup/picasso/RequestCreator;->into(Landroid/widget/ImageView;Lcom/squareup/picasso/Callback;)V

    .line 445
    :goto_0
    return-void

    .line 443
    :cond_0
    iget-object v0, p0, Lcom/cyjh/elfin/fragment/AdFragment$3;->this$0:Lcom/cyjh/elfin/fragment/AdFragment;

    invoke-static {v0}, Lcom/cyjh/elfin/fragment/AdFragment;->access$1200(Lcom/cyjh/elfin/fragment/AdFragment;)V

    goto :goto_0
.end method

.method public onAdFailed(Lcom/iflytek/voiceads/AdError;)V
    .locals 3
    .param p1, "adError"    # Lcom/iflytek/voiceads/AdError;

    .prologue
    .line 448
    const-string v0, "zzz"

    new-instance v1, Ljava/lang/StringBuilder;

    invoke-direct {v1}, Ljava/lang/StringBuilder;-><init>()V

    const-string v2, "AdFragment onAdFailed--"

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {p1}, Lcom/iflytek/voiceads/AdError;->getMessage()Ljava/lang/String;

    move-result-object v2

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    const-string v2, ",,,"

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {p1}, Lcom/iflytek/voiceads/AdError;->getErrorDescription()Ljava/lang/String;

    move-result-object v2

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v1

    invoke-static {v0, v1}, Landroid/util/Log;->e(Ljava/lang/String;Ljava/lang/String;)I

    .line 449
    iget-object v0, p0, Lcom/cyjh/elfin/fragment/AdFragment$3;->this$0:Lcom/cyjh/elfin/fragment/AdFragment;

    invoke-static {v0}, Lcom/cyjh/elfin/fragment/AdFragment;->access$1200(Lcom/cyjh/elfin/fragment/AdFragment;)V

    .line 450
    return-void
.end method
