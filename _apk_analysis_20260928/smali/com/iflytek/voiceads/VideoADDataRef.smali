.class public abstract Lcom/iflytek/voiceads/VideoADDataRef;
.super Ljava/lang/Object;
.source "VideoADDataRef.java"


# static fields
.field public static final AD_DOWNLOAD:Ljava/lang/String; = "download"

.field public static final AD_REDIRECT:Ljava/lang/String; = "redirect"


# direct methods
.method public constructor <init>()V
    .locals 0

    .prologue
    .line 9
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method


# virtual methods
.method public abstract getAdSourceMark()Ljava/lang/String;
.end method

.method public abstract getAdType()Ljava/lang/String;
.end method

.method public abstract getDuration()I
.end method

.method public abstract getMediaHeight()[I
.end method

.method public abstract getMediaWidth()[I
.end method

.method public abstract getSubTitle()Ljava/lang/String;
.end method

.method public abstract getTitle()Ljava/lang/String;
.end method

.method public abstract isExposured()Z
.end method

.method public abstract onClicked(Landroid/view/View;I)Z
.end method

.method public abstract onExposured(Landroid/view/View;)Z
.end method
