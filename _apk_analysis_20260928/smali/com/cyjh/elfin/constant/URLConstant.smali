.class public Lcom/cyjh/elfin/constant/URLConstant;
.super Ljava/lang/Object;
.source "URLConstant.java"


# static fields
.field public static final ABNORMAL_DOWNLOAD_COUNT:Ljava/lang/String; = "SetElfAbnormalGameDownLoadCount"

.field public static final ABNORMAL_DOWNLOAD_COUNT_ID:Ljava/lang/String; = "id"

.field public static final ABNORMAL_DOWNLOAD_COUNT_TYPE:Ljava/lang/String; = "type"

.field public static final ABNORMAL_GAME_DETAILS:Ljava/lang/String; = "GetElfAbnormalGameInfo"

.field public static final ABNORMAL_GAME_DETAILS_ID:Ljava/lang/String; = "id"

.field public static final ABNORMAL_GAME_INDEX:Ljava/lang/String; = "pageindex"

.field public static final ABNORMAL_GAME_LIST:Ljava/lang/String; = "GetElfAbnormalGameList"

.field public static final AD_RECOMMEND_GAMES:Ljava/lang/String; = "GetFreeElfGameRecommended"

.field public static final AD_REQUEST_CLICKER_STATISTICS:Ljava/lang/String; = "ApkAdvertisementOpen"

.field public static final AD_REQUEST_NAME:Ljava/lang/String; = "GetApkAdvertisement"

.field public static final AD_REQUEST_SITE:Ljava/lang/String; = "site"

.field public static final AD_REQUEST_STATISTICS_ID:Ljava/lang/String; = "Id"

.field public static final AD_REQUEST_TYPE:Ljava/lang/String; = "type"

.field public static final AD_STATISTICS_COUNT_NAME:Ljava/lang/String; = "SetApkAdvertisementCount"

.field public static final AD_STATISTICS_PARAMS_ID:Ljava/lang/String; = "id"

.field public static final AD_STATISTICS_PARAMS_PKG:Ljava/lang/String; = "packagename"

.field public static final AD_STATISTICS_PARAMS_TYPE:Ljava/lang/String; = "type"

.field public static final BLACK_LIST_NAME:Ljava/lang/String; = "GetElfBlackList"

.field public static final BLACK_LIST_PACKAGE:Ljava/lang/String; = "packagename"

.field public static final BLACK_LIST_TYPE:Ljava/lang/String; = "type"

.field public static final GET_DATE_TIME:Ljava/lang/String; = "GetDateTime"

.field public static final IFLYAD_REQ_NAME:Ljava/lang/String; = "GetAdvertisementSwitch"

.field public static final IFLYAD_REQ_SITE:Ljava/lang/String; = "site"

.field public static final IFLYAD_RQE_RESOURCE:Ljava/lang/String; = "key"

.field public static final IFLYAD_RQE_STATISTICS_NAME:Ljava/lang/String; = "SetFlyAdvertisingStatistics"

.field public static final IFLYAD_RQE_STATISTICS_TYPE:Ljava/lang/String; = "type"

.field public static final LOG_REQUEST_NAME:Ljava/lang/String; = "SetLog"

.field public static final LOG_URL:Ljava/lang/String;

.field public static final MONOMER_INSTALLATION_PACKAGE:Ljava/lang/String; = "GetMonomerInstallationPackage"

.field public static final MONOMER_PACKAGE_NAME:Ljava/lang/String; = "packagename"

.field public static final MSG_REQUEST_GUID:Ljava/lang/String; = "guid"

.field public static final MSG_REQUEST_IMIE:Ljava/lang/String; = "imie"

.field public static final MSG_REQUEST_IS_FREE:Ljava/lang/String; = "isfree"

.field public static final MSG_REQUEST_NAME:Ljava/lang/String; = "GetMessage"

.field public static final MSG_REQUEST_PLATFORMS:Ljava/lang/String; = "platforms"

.field public static final OPEN_ABGAME_LABEL_COUNT:Ljava/lang/String; = "SetElfEntranceOpenCount"

.field public static final PAY_OR_Free:Ljava/lang/String;

.field public static final RECOMMEND_OR_ABNORMAL_GAME_ENTRANCE:Ljava/lang/String; = "GetFreeElfGameRecommended_New"

.field public static final ROOT_REQUEST_NAME:Ljava/lang/String; = "GetRootConfiguration"

.field public static final TEMPLATE_MANAGER:Ljava/lang/String; = "GetTemplateManager"

.field public static final TEMPLATE_TYPE:Ljava/lang/String; = "type"

.field public static final TEMPLATE_VERSION:Ljava/lang/String; = "version"

.field public static final UPDATE_REQUEST_NAME:Ljava/lang/String; = "Update"

.field public static final UPDATE_URL:Ljava/lang/String;

.field public static final VALUE_TYPE:Ljava/lang/String;


# direct methods
.method static constructor <clinit>()V
    .locals 2

    .prologue
    .line 8
    const/4 v0, 0x1

    invoke-static {v0}, Ljava/lang/String;->valueOf(I)Ljava/lang/String;

    move-result-object v0

    sput-object v0, Lcom/cyjh/elfin/constant/URLConstant;->VALUE_TYPE:Ljava/lang/String;

    .line 9
    const/4 v0, 0x0

    invoke-static {v0}, Ljava/lang/String;->valueOf(I)Ljava/lang/String;

    move-result-object v0

    sput-object v0, Lcom/cyjh/elfin/constant/URLConstant;->PAY_OR_Free:Ljava/lang/String;

    .line 16
    const-string v0, "auth.51moba.com"

    const-string v1, "Update"

    invoke-static {v0, v1}, Lcom/cyjh/elfin/constant/MyBuildConfig;->getBuilder(Ljava/lang/String;Ljava/lang/String;)Landroid/net/Uri$Builder;

    move-result-object v0

    .line 17
    invoke-virtual {v0}, Landroid/net/Uri$Builder;->build()Landroid/net/Uri;

    move-result-object v0

    invoke-virtual {v0}, Landroid/net/Uri;->toString()Ljava/lang/String;

    move-result-object v0

    sput-object v0, Lcom/cyjh/elfin/constant/URLConstant;->UPDATE_URL:Ljava/lang/String;

    .line 22
    const-string v0, "logapi.mobileanjian.com"

    const-string v1, "SetLog"

    invoke-static {v0, v1}, Lcom/cyjh/elfin/constant/MyBuildConfig;->getBuilder(Ljava/lang/String;Ljava/lang/String;)Landroid/net/Uri$Builder;

    move-result-object v0

    .line 23
    invoke-virtual {v0}, Landroid/net/Uri$Builder;->build()Landroid/net/Uri;

    move-result-object v0

    invoke-virtual {v0}, Landroid/net/Uri;->toString()Ljava/lang/String;

    move-result-object v0

    sput-object v0, Lcom/cyjh/elfin/constant/URLConstant;->LOG_URL:Ljava/lang/String;

    .line 22
    return-void
.end method

.method public constructor <init>()V
    .locals 0

    .prologue
    .line 6
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method
