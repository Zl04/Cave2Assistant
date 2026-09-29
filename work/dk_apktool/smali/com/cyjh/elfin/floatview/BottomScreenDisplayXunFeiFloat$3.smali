.class Lcom/cyjh/elfin/floatview/BottomScreenDisplayXunFeiFloat$3;
.super Lcom/cyjh/elfin/listener/IFLYADListener;
.source "BottomScreenDisplayXunFeiFloat.java"


# annotations
.annotation system Ldalvik/annotation/EnclosingClass;
    value = Lcom/cyjh/elfin/floatview/BottomScreenDisplayXunFeiFloat;
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x0
    name = null
.end annotation


# instance fields
.field final synthetic this$0:Lcom/cyjh/elfin/floatview/BottomScreenDisplayXunFeiFloat;


# direct methods
.method constructor <init>(Lcom/cyjh/elfin/floatview/BottomScreenDisplayXunFeiFloat;)V
    .locals 0
    .param p1, "this$0"    # Lcom/cyjh/elfin/floatview/BottomScreenDisplayXunFeiFloat;

    .prologue
    .line 116
    iput-object p1, p0, Lcom/cyjh/elfin/floatview/BottomScreenDisplayXunFeiFloat$3;->this$0:Lcom/cyjh/elfin/floatview/BottomScreenDisplayXunFeiFloat;

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
    .line 119
    .local p1, "list":Ljava/util/List;, "Ljava/util/List<Lcom/iflytek/voiceads/NativeADDataRef;>;"
    const-string v0, "zzz"

    const-string v1, "BottomScreenDisplayXunFei--initNativeAd()-1"

    invoke-static {v0, v1}, Landroid/util/Log;->e(Ljava/lang/String;Ljava/lang/String;)I

    .line 120
    invoke-interface {p1}, Ljava/util/List;->size()I

    move-result v0

    if-lez v0, :cond_0

    .line 121
    iget-object v1, p0, Lcom/cyjh/elfin/floatview/BottomScreenDisplayXunFeiFloat$3;->this$0:Lcom/cyjh/elfin/floatview/BottomScreenDisplayXunFeiFloat;

    const/4 v0, 0x0

    invoke-interface {p1, v0}, Ljava/util/List;->get(I)Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Lcom/iflytek/voiceads/NativeADDataRef;

    invoke-static {v1, v0}, Lcom/cyjh/elfin/floatview/BottomScreenDisplayXunFeiFloat;->access$302(Lcom/cyjh/elfin/floatview/BottomScreenDisplayXunFeiFloat;Lcom/iflytek/voiceads/NativeADDataRef;)Lcom/iflytek/voiceads/NativeADDataRef;

    .line 122
    iget-object v0, p0, Lcom/cyjh/elfin/floatview/BottomScreenDisplayXunFeiFloat$3;->this$0:Lcom/cyjh/elfin/floatview/BottomScreenDisplayXunFeiFloat;

    invoke-static {v0}, Lcom/cyjh/elfin/floatview/BottomScreenDisplayXunFeiFloat;->access$1000(Lcom/cyjh/elfin/floatview/BottomScreenDisplayXunFeiFloat;)Landroid/content/Context;

    move-result-object v0

    invoke-static {v0}, Lcom/squareup/picasso/Picasso;->with(Landroid/content/Context;)Lcom/squareup/picasso/Picasso;

    move-result-object v0

    iget-object v1, p0, Lcom/cyjh/elfin/floatview/BottomScreenDisplayXunFeiFloat$3;->this$0:Lcom/cyjh/elfin/floatview/BottomScreenDisplayXunFeiFloat;

    invoke-static {v1}, Lcom/cyjh/elfin/floatview/BottomScreenDisplayXunFeiFloat;->access$300(Lcom/cyjh/elfin/floatview/BottomScreenDisplayXunFeiFloat;)Lcom/iflytek/voiceads/NativeADDataRef;

    move-result-object v1

    invoke-virtual {v1}, Lcom/iflytek/voiceads/NativeADDataRef;->getImage()Ljava/lang/String;

    move-result-object v1

    invoke-virtual {v0, v1}, Lcom/squareup/picasso/Picasso;->load(Ljava/lang/String;)Lcom/squareup/picasso/RequestCreator;

    move-result-object v0

    iget-object v1, p0, Lcom/cyjh/elfin/floatview/BottomScreenDisplayXunFeiFloat$3;->this$0:Lcom/cyjh/elfin/floatview/BottomScreenDisplayXunFeiFloat;

    invoke-static {v1}, Lcom/cyjh/elfin/floatview/BottomScreenDisplayXunFeiFloat;->access$400(Lcom/cyjh/elfin/floatview/BottomScreenDisplayXunFeiFloat;)Landroid/widget/ImageView;

    move-result-object v1

    new-instance v2, Lcom/cyjh/elfin/floatview/BottomScreenDisplayXunFeiFloat$3$1;

    invoke-direct {v2, p0}, Lcom/cyjh/elfin/floatview/BottomScreenDisplayXunFeiFloat$3$1;-><init>(Lcom/cyjh/elfin/floatview/BottomScreenDisplayXunFeiFloat$3;)V

    invoke-virtual {v0, v1, v2}, Lcom/squareup/picasso/RequestCreator;->into(Landroid/widget/ImageView;Lcom/squareup/picasso/Callback;)V

    .line 144
    :cond_0
    return-void
.end method

.method public onAdFailed(Lcom/iflytek/voiceads/AdError;)V
    .locals 3
    .param p1, "adError"    # Lcom/iflytek/voiceads/AdError;

    .prologue
    .line 148
    const-string v0, "zzz"

    new-instance v1, Ljava/lang/StringBuilder;

    invoke-direct {v1}, Ljava/lang/StringBuilder;-><init>()V

    const-string v2, "BottomScreenDisplayXunFei---"

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {p1}, Lcom/iflytek/voiceads/AdError;->getErrorDescription()Ljava/lang/String;

    move-result-object v2

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    const-string v2, ",,--"

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {p1}, Lcom/iflytek/voiceads/AdError;->getMessage()Ljava/lang/String;

    move-result-object v2

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v1

    invoke-static {v0, v1}, Landroid/util/Log;->e(Ljava/lang/String;Ljava/lang/String;)I

    .line 149
    iget-object v0, p0, Lcom/cyjh/elfin/floatview/BottomScreenDisplayXunFeiFloat$3;->this$0:Lcom/cyjh/elfin/floatview/BottomScreenDisplayXunFeiFloat;

    invoke-static {v0}, Lcom/cyjh/elfin/floatview/BottomScreenDisplayXunFeiFloat;->access$100(Lcom/cyjh/elfin/floatview/BottomScreenDisplayXunFeiFloat;)V

    .line 150
    return-void
.end method
