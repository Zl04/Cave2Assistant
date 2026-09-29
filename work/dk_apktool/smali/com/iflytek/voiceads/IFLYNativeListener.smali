.class public interface abstract Lcom/iflytek/voiceads/IFLYNativeListener;
.super Ljava/lang/Object;
.source "IFLYNativeListener.java"

# interfaces
.implements Lcom/iflytek/voiceads/listener/DialogConfirmListener;


# virtual methods
.method public abstract onADLoaded(Ljava/util/List;)V
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "(",
            "Ljava/util/List",
            "<",
            "Lcom/iflytek/voiceads/NativeADDataRef;",
            ">;)V"
        }
    .end annotation
.end method

.method public abstract onAdFailed(Lcom/iflytek/voiceads/AdError;)V
.end method
