.class public abstract Lcom/iflytek/voiceads/NativeADDataRef;
.super Ljava/lang/Object;
.source "NativeADDataRef.java"


# static fields
.field public static final AD_DOWNLOAD:Ljava/lang/String; = "download"

.field public static final AD_REDIRECT:Ljava/lang/String; = "redirect"


# direct methods
.method public constructor <init>()V
    .locals 0

    .prologue
    .line 7
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method


# virtual methods
.method public abstract getAdSourceMark()Ljava/lang/String;
.end method

.method public abstract getAdtype()Ljava/lang/String;
.end method

.method public abstract getExplain()Ljava/lang/String;
.end method

.method public abstract getIcon()Ljava/lang/String;
.end method

.method public abstract getImage()Ljava/lang/String;
.end method

.method public abstract getImgUrls()Ljava/util/ArrayList;
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "()",
            "Ljava/util/ArrayList",
            "<",
            "Ljava/lang/String;",
            ">;"
        }
    .end annotation
.end method

.method public abstract getSubTitle()Ljava/lang/String;
.end method

.method public abstract getTitle()Ljava/lang/String;
.end method

.method public abstract isExposured()Z
.end method

.method public abstract onClicked(Landroid/view/View;)Z
.end method

.method public abstract onExposured(Landroid/view/View;)Z
.end method
