.class public Lcom/cyjh/elfin/mvp/managers/IFLYAdCountStatistics;
.super Ljava/lang/Object;
.source "IFLYAdCountStatistics.java"


# static fields
.field public static final BOTTOM_SCREEN_TYPE:I = 0x4

.field public static final FULLSCREEN_TYPE:I = 0x2

.field public static final REQUEST_TAG:Ljava/lang/String;


# direct methods
.method static constructor <clinit>()V
    .locals 1

    .prologue
    .line 22
    const-class v0, Lcom/cyjh/elfin/mvp/managers/IFLYAdCountStatistics;

    invoke-virtual {v0}, Ljava/lang/Class;->getCanonicalName()Ljava/lang/String;

    move-result-object v0

    sput-object v0, Lcom/cyjh/elfin/mvp/managers/IFLYAdCountStatistics;->REQUEST_TAG:Ljava/lang/String;

    return-void
.end method

.method public constructor <init>()V
    .locals 0

    .prologue
    .line 21
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method

.method public static cancelReqCountStatistics()V
    .locals 0

    .prologue
    .line 45
    invoke-static {}, Lcom/cyjh/elfin/net/volley/VolleyManager;->cancelAllReq()V

    .line 46
    return-void
.end method

.method public static requestCountStatistics(Landroid/content/Context;I)V
    .locals 4
    .param p0, "context"    # Landroid/content/Context;
    .param p1, "type"    # I

    .prologue
    .line 26
    const-string v1, "api.51moba.com"

    const-string v2, "SetFlyAdvertisingStatistics"

    invoke-static {v1, v2}, Lcom/cyjh/elfin/constant/MyBuildConfig;->getBuilder(Ljava/lang/String;Ljava/lang/String;)Landroid/net/Uri$Builder;

    move-result-object v1

    const-string v2, "type"

    .line 27
    invoke-static {p1}, Ljava/lang/String;->valueOf(I)Ljava/lang/String;

    move-result-object v3

    invoke-virtual {v1, v2, v3}, Landroid/net/Uri$Builder;->appendQueryParameter(Ljava/lang/String;Ljava/lang/String;)Landroid/net/Uri$Builder;

    move-result-object v1

    .line 28
    invoke-virtual {v1}, Landroid/net/Uri$Builder;->build()Landroid/net/Uri;

    move-result-object v1

    invoke-virtual {v1}, Landroid/net/Uri;->toString()Ljava/lang/String;

    move-result-object v0

    .line 30
    .local v0, "url":Ljava/lang/String;
    sget-object v1, Lcom/cyjh/elfin/mvp/managers/IFLYAdCountStatistics;->REQUEST_TAG:Ljava/lang/String;

    new-instance v2, Lcom/cyjh/elfin/mvp/managers/IFLYAdCountStatistics$1;

    invoke-direct {v2, p0}, Lcom/cyjh/elfin/mvp/managers/IFLYAdCountStatistics$1;-><init>(Landroid/content/Context;)V

    invoke-static {v0, v1, v2}, Lcom/cyjh/elfin/net/volley/VolleyManager;->requestStringGet(Ljava/lang/String;Ljava/lang/String;Lcom/cyjh/elfin/net/volley/VolleyRequestManager;)V

    .line 41
    return-void
.end method
