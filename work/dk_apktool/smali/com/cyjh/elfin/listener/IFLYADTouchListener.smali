.class public Lcom/cyjh/elfin/listener/IFLYADTouchListener;
.super Ljava/lang/Object;
.source "IFLYADTouchListener.java"

# interfaces
.implements Landroid/view/View$OnTouchListener;


# instance fields
.field private nativeAd:Lcom/iflytek/voiceads/IFLYNativeAd;


# direct methods
.method public constructor <init>(Lcom/iflytek/voiceads/IFLYNativeAd;)V
    .locals 0
    .param p1, "nativeAd"    # Lcom/iflytek/voiceads/IFLYNativeAd;

    .prologue
    .line 19
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    .line 20
    iput-object p1, p0, Lcom/cyjh/elfin/listener/IFLYADTouchListener;->nativeAd:Lcom/iflytek/voiceads/IFLYNativeAd;

    .line 21
    return-void
.end method


# virtual methods
.method public onTouch(Landroid/view/View;Landroid/view/MotionEvent;)Z
    .locals 4
    .param p1, "v"    # Landroid/view/View;
    .param p2, "event"    # Landroid/view/MotionEvent;

    .prologue
    .line 25
    invoke-virtual {p2}, Landroid/view/MotionEvent;->getAction()I

    move-result v0

    packed-switch v0, :pswitch_data_0

    .line 37
    :goto_0
    const/4 v0, 0x0

    return v0

    .line 27
    :pswitch_0
    iget-object v0, p0, Lcom/cyjh/elfin/listener/IFLYADTouchListener;->nativeAd:Lcom/iflytek/voiceads/IFLYNativeAd;

    const-string v1, "ACTION_DOWN_X"

    new-instance v2, Ljava/lang/StringBuilder;

    invoke-direct {v2}, Ljava/lang/StringBuilder;-><init>()V

    invoke-virtual {p2}, Landroid/view/MotionEvent;->getX()F

    move-result v3

    invoke-virtual {v2, v3}, Ljava/lang/StringBuilder;->append(F)Ljava/lang/StringBuilder;

    move-result-object v2

    const-string v3, ""

    invoke-virtual {v2, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    invoke-virtual {v2}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v2

    invoke-virtual {v0, v1, v2}, Lcom/iflytek/voiceads/IFLYNativeAd;->setParameter(Ljava/lang/String;Ljava/lang/String;)V

    .line 28
    iget-object v0, p0, Lcom/cyjh/elfin/listener/IFLYADTouchListener;->nativeAd:Lcom/iflytek/voiceads/IFLYNativeAd;

    const-string v1, "ACTION_DOWN_Y"

    new-instance v2, Ljava/lang/StringBuilder;

    invoke-direct {v2}, Ljava/lang/StringBuilder;-><init>()V

    invoke-virtual {p2}, Landroid/view/MotionEvent;->getY()F

    move-result v3

    invoke-virtual {v2, v3}, Ljava/lang/StringBuilder;->append(F)Ljava/lang/StringBuilder;

    move-result-object v2

    const-string v3, ""

    invoke-virtual {v2, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    invoke-virtual {v2}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v2

    invoke-virtual {v0, v1, v2}, Lcom/iflytek/voiceads/IFLYNativeAd;->setParameter(Ljava/lang/String;Ljava/lang/String;)V

    goto :goto_0

    .line 31
    :pswitch_1
    iget-object v0, p0, Lcom/cyjh/elfin/listener/IFLYADTouchListener;->nativeAd:Lcom/iflytek/voiceads/IFLYNativeAd;

    const-string v1, "ACTION_UP_X"

    new-instance v2, Ljava/lang/StringBuilder;

    invoke-direct {v2}, Ljava/lang/StringBuilder;-><init>()V

    invoke-virtual {p2}, Landroid/view/MotionEvent;->getX()F

    move-result v3

    invoke-virtual {v2, v3}, Ljava/lang/StringBuilder;->append(F)Ljava/lang/StringBuilder;

    move-result-object v2

    const-string v3, ""

    invoke-virtual {v2, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    invoke-virtual {v2}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v2

    invoke-virtual {v0, v1, v2}, Lcom/iflytek/voiceads/IFLYNativeAd;->setParameter(Ljava/lang/String;Ljava/lang/String;)V

    .line 32
    iget-object v0, p0, Lcom/cyjh/elfin/listener/IFLYADTouchListener;->nativeAd:Lcom/iflytek/voiceads/IFLYNativeAd;

    const-string v1, "ACTION_UP_Y"

    new-instance v2, Ljava/lang/StringBuilder;

    invoke-direct {v2}, Ljava/lang/StringBuilder;-><init>()V

    invoke-virtual {p2}, Landroid/view/MotionEvent;->getY()F

    move-result v3

    invoke-virtual {v2, v3}, Ljava/lang/StringBuilder;->append(F)Ljava/lang/StringBuilder;

    move-result-object v2

    const-string v3, ""

    invoke-virtual {v2, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    invoke-virtual {v2}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v2

    invoke-virtual {v0, v1, v2}, Lcom/iflytek/voiceads/IFLYNativeAd;->setParameter(Ljava/lang/String;Ljava/lang/String;)V

    goto :goto_0

    .line 25
    nop

    :pswitch_data_0
    .packed-switch 0x0
        :pswitch_0
        :pswitch_1
    .end packed-switch
.end method
