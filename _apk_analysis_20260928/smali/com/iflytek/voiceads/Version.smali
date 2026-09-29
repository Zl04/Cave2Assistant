.class public Lcom/iflytek/voiceads/Version;
.super Ljava/lang/Object;
.source "Version.java"


# direct methods
.method public constructor <init>()V
    .locals 0

    .prologue
    .line 3
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method

.method public static getVersion()Ljava/lang/String;
    .locals 1

    .prologue
    .line 6
    const-string v0, "3.2_IFLY"

    return-object v0
.end method
