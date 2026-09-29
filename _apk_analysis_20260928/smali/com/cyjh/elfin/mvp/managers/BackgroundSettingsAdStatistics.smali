.class public Lcom/cyjh/elfin/mvp/managers/BackgroundSettingsAdStatistics;
.super Ljava/lang/Object;
.source "BackgroundSettingsAdStatistics.java"


# static fields
.field public static final AD_PARAMS_CLICK:Ljava/lang/String; = "1"

.field public static final AD_PARAMS_DISPLAY:Ljava/lang/String; = "3"

.field public static final AD_PARAMS_REQUEST:Ljava/lang/String; = "2"

.field public static final REQUEST_TAG:Ljava/lang/String;


# direct methods
.method static constructor <clinit>()V
    .locals 1

    .prologue
    .line 22
    const-class v0, Lcom/cyjh/elfin/mvp/managers/BackgroundSettingsAdStatistics;

    invoke-virtual {v0}, Ljava/lang/Class;->getCanonicalName()Ljava/lang/String;

    move-result-object v0

    sput-object v0, Lcom/cyjh/elfin/mvp/managers/BackgroundSettingsAdStatistics;->REQUEST_TAG:Ljava/lang/String;

    return-void
.end method

.method public constructor <init>()V
    .locals 0

    .prologue
    .line 21
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method


# virtual methods
.method public backgroundStatisticsAdCount(Landroid/content/Context;Ljava/lang/String;Ljava/lang/String;)V
    .locals 4
    .param p1, "context"    # Landroid/content/Context;
    .param p2, "id"    # Ljava/lang/String;
    .param p3, "type"    # Ljava/lang/String;

    .prologue
    .line 28
    const-string v1, "api.51moba.com"

    const-string v2, "SetApkAdvertisementCount"

    invoke-static {v1, v2}, Lcom/cyjh/elfin/constant/MyBuildConfig;->getBuilder(Ljava/lang/String;Ljava/lang/String;)Landroid/net/Uri$Builder;

    move-result-object v1

    const-string v2, "id"

    .line 29
    invoke-virtual {v1, v2, p2}, Landroid/net/Uri$Builder;->appendQueryParameter(Ljava/lang/String;Ljava/lang/String;)Landroid/net/Uri$Builder;

    move-result-object v1

    const-string v2, "type"

    .line 30
    invoke-virtual {v1, v2, p3}, Landroid/net/Uri$Builder;->appendQueryParameter(Ljava/lang/String;Ljava/lang/String;)Landroid/net/Uri$Builder;

    move-result-object v1

    const-string v2, "packagename"

    .line 31
    invoke-static {}, Lcom/cyjh/elfin/AppContext;->getInstance()Lcom/cyjh/elfin/AppContext;

    move-result-object v3

    invoke-virtual {v3}, Lcom/cyjh/elfin/AppContext;->getPackageName()Ljava/lang/String;

    move-result-object v3

    invoke-virtual {v1, v2, v3}, Landroid/net/Uri$Builder;->appendQueryParameter(Ljava/lang/String;Ljava/lang/String;)Landroid/net/Uri$Builder;

    move-result-object v1

    .line 32
    invoke-virtual {v1}, Landroid/net/Uri$Builder;->build()Landroid/net/Uri;

    move-result-object v1

    invoke-virtual {v1}, Landroid/net/Uri;->toString()Ljava/lang/String;

    move-result-object v0

    .line 33
    .local v0, "url":Ljava/lang/String;
    new-instance v1, Ljava/lang/StringBuilder;

    invoke-direct {v1}, Ljava/lang/StringBuilder;-><init>()V

    const-string v2, "BackgroundSettingsAdStatistics Url="

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1, v0}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v1

    const/4 v2, 0x0

    new-array v2, v2, [Ljava/lang/Object;

    invoke-static {v1, v2}, Lcom/orhanobut/logger/Logger;->e(Ljava/lang/String;[Ljava/lang/Object;)V

    .line 34
    sget-object v1, Lcom/cyjh/elfin/mvp/managers/BackgroundSettingsAdStatistics;->REQUEST_TAG:Ljava/lang/String;

    new-instance v2, Lcom/cyjh/elfin/mvp/managers/BackgroundSettingsAdStatistics$1;

    invoke-direct {v2, p0, p1}, Lcom/cyjh/elfin/mvp/managers/BackgroundSettingsAdStatistics$1;-><init>(Lcom/cyjh/elfin/mvp/managers/BackgroundSettingsAdStatistics;Landroid/content/Context;)V

    invoke-static {v0, v1, v2}, Lcom/cyjh/elfin/net/volley/VolleyManager;->requestStringGet(Ljava/lang/String;Ljava/lang/String;Lcom/cyjh/elfin/net/volley/VolleyRequestManager;)V

    .line 46
    return-void
.end method

.method public cancelReqCountStatistics()V
    .locals 0

    .prologue
    .line 50
    invoke-static {}, Lcom/cyjh/elfin/net/volley/VolleyManager;->cancelAllReq()V

    .line 51
    return-void
.end method
