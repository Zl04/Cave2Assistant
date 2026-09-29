.class Lcom/cyjh/elfin/floatview/BottomScreenDisplayXunFeiFloat$3$1;
.super Ljava/lang/Object;
.source "BottomScreenDisplayXunFeiFloat.java"

# interfaces
.implements Lcom/squareup/picasso/Callback;


# annotations
.annotation system Ldalvik/annotation/EnclosingMethod;
    value = Lcom/cyjh/elfin/floatview/BottomScreenDisplayXunFeiFloat$3;->onADLoaded(Ljava/util/List;)V
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x0
    name = null
.end annotation


# instance fields
.field final synthetic this$1:Lcom/cyjh/elfin/floatview/BottomScreenDisplayXunFeiFloat$3;


# direct methods
.method constructor <init>(Lcom/cyjh/elfin/floatview/BottomScreenDisplayXunFeiFloat$3;)V
    .locals 0
    .param p1, "this$1"    # Lcom/cyjh/elfin/floatview/BottomScreenDisplayXunFeiFloat$3;

    .prologue
    .line 122
    iput-object p1, p0, Lcom/cyjh/elfin/floatview/BottomScreenDisplayXunFeiFloat$3$1;->this$1:Lcom/cyjh/elfin/floatview/BottomScreenDisplayXunFeiFloat$3;

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method


# virtual methods
.method public onError()V
    .locals 1

    .prologue
    .line 140
    iget-object v0, p0, Lcom/cyjh/elfin/floatview/BottomScreenDisplayXunFeiFloat$3$1;->this$1:Lcom/cyjh/elfin/floatview/BottomScreenDisplayXunFeiFloat$3;

    iget-object v0, v0, Lcom/cyjh/elfin/floatview/BottomScreenDisplayXunFeiFloat$3;->this$0:Lcom/cyjh/elfin/floatview/BottomScreenDisplayXunFeiFloat;

    invoke-static {v0}, Lcom/cyjh/elfin/floatview/BottomScreenDisplayXunFeiFloat;->access$100(Lcom/cyjh/elfin/floatview/BottomScreenDisplayXunFeiFloat;)V

    .line 141
    return-void
.end method

.method public onSuccess()V
    .locals 5

    .prologue
    const/4 v4, 0x0

    .line 125
    const-string v0, "zzz"

    const-string v1, "BottomScreenDisplayXunFei--initNativeAd()-2"

    invoke-static {v0, v1}, Landroid/util/Log;->e(Ljava/lang/String;Ljava/lang/String;)I

    .line 126
    iget-object v0, p0, Lcom/cyjh/elfin/floatview/BottomScreenDisplayXunFeiFloat$3$1;->this$1:Lcom/cyjh/elfin/floatview/BottomScreenDisplayXunFeiFloat$3;

    iget-object v0, v0, Lcom/cyjh/elfin/floatview/BottomScreenDisplayXunFeiFloat$3;->this$0:Lcom/cyjh/elfin/floatview/BottomScreenDisplayXunFeiFloat;

    invoke-static {v0}, Lcom/cyjh/elfin/floatview/BottomScreenDisplayXunFeiFloat;->access$500(Lcom/cyjh/elfin/floatview/BottomScreenDisplayXunFeiFloat;)V

    .line 127
    iget-object v0, p0, Lcom/cyjh/elfin/floatview/BottomScreenDisplayXunFeiFloat$3$1;->this$1:Lcom/cyjh/elfin/floatview/BottomScreenDisplayXunFeiFloat$3;

    iget-object v0, v0, Lcom/cyjh/elfin/floatview/BottomScreenDisplayXunFeiFloat$3;->this$0:Lcom/cyjh/elfin/floatview/BottomScreenDisplayXunFeiFloat;

    invoke-static {v0}, Lcom/cyjh/elfin/floatview/BottomScreenDisplayXunFeiFloat;->access$400(Lcom/cyjh/elfin/floatview/BottomScreenDisplayXunFeiFloat;)Landroid/widget/ImageView;

    move-result-object v0

    new-instance v1, Lcom/cyjh/elfin/listener/IFLYADTouchListener;

    iget-object v2, p0, Lcom/cyjh/elfin/floatview/BottomScreenDisplayXunFeiFloat$3$1;->this$1:Lcom/cyjh/elfin/floatview/BottomScreenDisplayXunFeiFloat$3;

    iget-object v2, v2, Lcom/cyjh/elfin/floatview/BottomScreenDisplayXunFeiFloat$3;->this$0:Lcom/cyjh/elfin/floatview/BottomScreenDisplayXunFeiFloat;

    invoke-static {v2}, Lcom/cyjh/elfin/floatview/BottomScreenDisplayXunFeiFloat;->access$600(Lcom/cyjh/elfin/floatview/BottomScreenDisplayXunFeiFloat;)Lcom/iflytek/voiceads/IFLYNativeAd;

    move-result-object v2

    invoke-direct {v1, v2}, Lcom/cyjh/elfin/listener/IFLYADTouchListener;-><init>(Lcom/iflytek/voiceads/IFLYNativeAd;)V

    invoke-virtual {v0, v1}, Landroid/widget/ImageView;->setOnTouchListener(Landroid/view/View$OnTouchListener;)V

    .line 128
    iget-object v0, p0, Lcom/cyjh/elfin/floatview/BottomScreenDisplayXunFeiFloat$3$1;->this$1:Lcom/cyjh/elfin/floatview/BottomScreenDisplayXunFeiFloat$3;

    iget-object v0, v0, Lcom/cyjh/elfin/floatview/BottomScreenDisplayXunFeiFloat$3;->this$0:Lcom/cyjh/elfin/floatview/BottomScreenDisplayXunFeiFloat;

    invoke-static {v0}, Lcom/cyjh/elfin/floatview/BottomScreenDisplayXunFeiFloat;->access$700(Lcom/cyjh/elfin/floatview/BottomScreenDisplayXunFeiFloat;)Landroid/widget/TextView;

    move-result-object v0

    new-instance v1, Lcom/cyjh/elfin/listener/IFLYADTouchListener;

    iget-object v2, p0, Lcom/cyjh/elfin/floatview/BottomScreenDisplayXunFeiFloat$3$1;->this$1:Lcom/cyjh/elfin/floatview/BottomScreenDisplayXunFeiFloat$3;

    iget-object v2, v2, Lcom/cyjh/elfin/floatview/BottomScreenDisplayXunFeiFloat$3;->this$0:Lcom/cyjh/elfin/floatview/BottomScreenDisplayXunFeiFloat;

    invoke-static {v2}, Lcom/cyjh/elfin/floatview/BottomScreenDisplayXunFeiFloat;->access$600(Lcom/cyjh/elfin/floatview/BottomScreenDisplayXunFeiFloat;)Lcom/iflytek/voiceads/IFLYNativeAd;

    move-result-object v2

    invoke-direct {v1, v2}, Lcom/cyjh/elfin/listener/IFLYADTouchListener;-><init>(Lcom/iflytek/voiceads/IFLYNativeAd;)V

    invoke-virtual {v0, v1}, Landroid/widget/TextView;->setOnTouchListener(Landroid/view/View$OnTouchListener;)V

    .line 129
    iget-object v0, p0, Lcom/cyjh/elfin/floatview/BottomScreenDisplayXunFeiFloat$3$1;->this$1:Lcom/cyjh/elfin/floatview/BottomScreenDisplayXunFeiFloat$3;

    iget-object v0, v0, Lcom/cyjh/elfin/floatview/BottomScreenDisplayXunFeiFloat$3;->this$0:Lcom/cyjh/elfin/floatview/BottomScreenDisplayXunFeiFloat;

    invoke-static {v0}, Lcom/cyjh/elfin/floatview/BottomScreenDisplayXunFeiFloat;->access$800(Lcom/cyjh/elfin/floatview/BottomScreenDisplayXunFeiFloat;)Landroid/widget/RelativeLayout;

    move-result-object v0

    invoke-virtual {v0, v4}, Landroid/widget/RelativeLayout;->setVisibility(I)V

    .line 130
    iget-object v0, p0, Lcom/cyjh/elfin/floatview/BottomScreenDisplayXunFeiFloat$3$1;->this$1:Lcom/cyjh/elfin/floatview/BottomScreenDisplayXunFeiFloat$3;

    iget-object v0, v0, Lcom/cyjh/elfin/floatview/BottomScreenDisplayXunFeiFloat$3;->this$0:Lcom/cyjh/elfin/floatview/BottomScreenDisplayXunFeiFloat;

    invoke-static {v0}, Lcom/cyjh/elfin/floatview/BottomScreenDisplayXunFeiFloat;->access$300(Lcom/cyjh/elfin/floatview/BottomScreenDisplayXunFeiFloat;)Lcom/iflytek/voiceads/NativeADDataRef;

    move-result-object v0

    invoke-virtual {v0}, Lcom/iflytek/voiceads/NativeADDataRef;->getAdSourceMark()Ljava/lang/String;

    move-result-object v0

    invoke-static {v0}, Landroid/text/TextUtils;->isEmpty(Ljava/lang/CharSequence;)Z

    move-result v0

    if-nez v0, :cond_0

    .line 131
    iget-object v0, p0, Lcom/cyjh/elfin/floatview/BottomScreenDisplayXunFeiFloat$3$1;->this$1:Lcom/cyjh/elfin/floatview/BottomScreenDisplayXunFeiFloat$3;

    iget-object v0, v0, Lcom/cyjh/elfin/floatview/BottomScreenDisplayXunFeiFloat$3;->this$0:Lcom/cyjh/elfin/floatview/BottomScreenDisplayXunFeiFloat;

    invoke-static {v0}, Lcom/cyjh/elfin/floatview/BottomScreenDisplayXunFeiFloat;->access$900(Lcom/cyjh/elfin/floatview/BottomScreenDisplayXunFeiFloat;)Landroid/widget/TextView;

    move-result-object v0

    invoke-static {}, Lcom/cyjh/elfin/AppContext;->getInstance()Lcom/cyjh/elfin/AppContext;

    move-result-object v1

    const v2, 0x7f080032

    invoke-virtual {v1, v2}, Lcom/cyjh/elfin/AppContext;->getString(I)Ljava/lang/String;

    move-result-object v1

    const/4 v2, 0x1

    new-array v2, v2, [Ljava/lang/Object;

    iget-object v3, p0, Lcom/cyjh/elfin/floatview/BottomScreenDisplayXunFeiFloat$3$1;->this$1:Lcom/cyjh/elfin/floatview/BottomScreenDisplayXunFeiFloat$3;

    iget-object v3, v3, Lcom/cyjh/elfin/floatview/BottomScreenDisplayXunFeiFloat$3;->this$0:Lcom/cyjh/elfin/floatview/BottomScreenDisplayXunFeiFloat;

    .line 132
    invoke-static {v3}, Lcom/cyjh/elfin/floatview/BottomScreenDisplayXunFeiFloat;->access$300(Lcom/cyjh/elfin/floatview/BottomScreenDisplayXunFeiFloat;)Lcom/iflytek/voiceads/NativeADDataRef;

    move-result-object v3

    invoke-virtual {v3}, Lcom/iflytek/voiceads/NativeADDataRef;->getAdSourceMark()Ljava/lang/String;

    move-result-object v3

    aput-object v3, v2, v4

    .line 131
    invoke-static {v1, v2}, Ljava/lang/String;->format(Ljava/lang/String;[Ljava/lang/Object;)Ljava/lang/String;

    move-result-object v1

    invoke-virtual {v0, v1}, Landroid/widget/TextView;->setText(Ljava/lang/CharSequence;)V

    .line 133
    iget-object v0, p0, Lcom/cyjh/elfin/floatview/BottomScreenDisplayXunFeiFloat$3$1;->this$1:Lcom/cyjh/elfin/floatview/BottomScreenDisplayXunFeiFloat$3;

    iget-object v0, v0, Lcom/cyjh/elfin/floatview/BottomScreenDisplayXunFeiFloat$3;->this$0:Lcom/cyjh/elfin/floatview/BottomScreenDisplayXunFeiFloat;

    invoke-static {v0}, Lcom/cyjh/elfin/floatview/BottomScreenDisplayXunFeiFloat;->access$900(Lcom/cyjh/elfin/floatview/BottomScreenDisplayXunFeiFloat;)Landroid/widget/TextView;

    move-result-object v0

    invoke-virtual {v0, v4}, Landroid/widget/TextView;->setVisibility(I)V

    .line 135
    :cond_0
    iget-object v0, p0, Lcom/cyjh/elfin/floatview/BottomScreenDisplayXunFeiFloat$3$1;->this$1:Lcom/cyjh/elfin/floatview/BottomScreenDisplayXunFeiFloat$3;

    iget-object v0, v0, Lcom/cyjh/elfin/floatview/BottomScreenDisplayXunFeiFloat$3;->this$0:Lcom/cyjh/elfin/floatview/BottomScreenDisplayXunFeiFloat;

    invoke-static {v0}, Lcom/cyjh/elfin/floatview/BottomScreenDisplayXunFeiFloat;->access$300(Lcom/cyjh/elfin/floatview/BottomScreenDisplayXunFeiFloat;)Lcom/iflytek/voiceads/NativeADDataRef;

    move-result-object v0

    iget-object v1, p0, Lcom/cyjh/elfin/floatview/BottomScreenDisplayXunFeiFloat$3$1;->this$1:Lcom/cyjh/elfin/floatview/BottomScreenDisplayXunFeiFloat$3;

    iget-object v1, v1, Lcom/cyjh/elfin/floatview/BottomScreenDisplayXunFeiFloat$3;->this$0:Lcom/cyjh/elfin/floatview/BottomScreenDisplayXunFeiFloat;

    invoke-static {v1}, Lcom/cyjh/elfin/floatview/BottomScreenDisplayXunFeiFloat;->access$800(Lcom/cyjh/elfin/floatview/BottomScreenDisplayXunFeiFloat;)Landroid/widget/RelativeLayout;

    move-result-object v1

    invoke-virtual {v0, v1}, Lcom/iflytek/voiceads/NativeADDataRef;->onExposured(Landroid/view/View;)Z

    .line 137
    return-void
.end method
