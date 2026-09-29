.class public interface abstract Lcom/iflytek/voiceads/IFLYVideoAdListener;
.super Ljava/lang/Object;
.source "IFLYVideoAdListener.java"

# interfaces
.implements Lcom/iflytek/voiceads/listener/DialogConfirmListener;


# virtual methods
.method public abstract onAdClick()V
.end method

.method public abstract onAdFailed(Lcom/iflytek/voiceads/AdError;)V
.end method

.method public abstract onAdLoaded(Ljava/util/List;)V
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "(",
            "Ljava/util/List",
            "<",
            "Lcom/iflytek/voiceads/VideoADDataRef;",
            ">;)V"
        }
    .end annotation
.end method

.method public abstract onAdPlayComplete()V
.end method

.method public abstract onAdPlayError()V
.end method

.method public abstract onAdSkip()V
.end method

.method public abstract onAdStartPlay()V
.end method
