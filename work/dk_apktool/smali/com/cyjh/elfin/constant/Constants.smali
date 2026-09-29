.class public Lcom/cyjh/elfin/constant/Constants;
.super Ljava/lang/Object;
.source "Constants.java"


# static fields
.field public static final AD_DESCRIPTION_IS_CLICKER:Ljava/lang/String; = "is_clicker_description"

.field public static final AD_DESCRIPTION_REQUEST_ID:Ljava/lang/String; = "id_description"

.field public static final AD_IS_FIRST:Ljava/lang/String; = "ad_is_first"

.field public static final AD_NEW_ID:Ljava/lang/String; = "ad_new_id"

.field public static final AD_NEW_JUMP_LINK:Ljava/lang/String; = "new_jump_link"

.field public static final AD_NEW_TOUCH_CLICKER:Ljava/lang/String; = "is_touch_clicker"

.field public static final AD_OLD_ID:Ljava/lang/String; = "ad_old_id"

.field public static final AD_OLD_JUMP_LINK:Ljava/lang/String; = "old_jump_link"

.field public static final AD_OLD_TOUCH_CLICKER:Ljava/lang/String; = "is_touch_clicker"

.field public static final ANDROID:Ljava/lang/String; = "android"

.field public static final DATABASE_TABLE_MSG:Ljava/lang/String; = "Message"

.field public static final DEFAULT_ENTRY_GAMES:Ljava/lang/String; = "default_entry_games"

.field public static final DOWNLOAD_APK_NAME:Ljava/lang/String; = "youxifengwo.apk"

.field public static final DOWNLOAD_APP:Ljava/lang/String; = "APP"

.field public static final DOWNLOAD_URL_HONEYCOMB:Ljava/lang/String; = "http://m.anjian.com/help/jiaoben/youxifengwo-xiaojl.apk"

.field public static final HONEYCOMB_PACAKGE:Ljava/lang/String; = "com.cyjh.gundam"

.field public static final ISEXIST_NETWORK_REQ_FILE:Ljava/lang/String; = "network_file_is_exist"

.field public static final LAST_AD_ID:Ljava/lang/String; = "last_ad_id"

.field public static final LAST_AD_IMG_URL:Ljava/lang/String; = "last_ad_link_url"

.field public static final LAST_AD_JUMP_LINKURL:Ljava/lang/String; = "last_ad_jump_linkurl"

.field public static final LAST_AD_LINK_TYPE:Ljava/lang/String; = "last_ad_link_type"

.field public static final LAST_AD_TITLE:Ljava/lang/String; = "last_ad_title"

.field public static final MESSAGE_WHAT_GET_ROOT_LEAD_URL_SUCCEED:I = 0x1

.field public static final MSG_DATA:Ljava/lang/String; = "msg_data"

.field public static final NETWORK_RES_MESSAGE_TIME:Ljava/lang/String; = "save_network_message"

.field public static final RECOMMEND_GAMES_LINK:Ljava/lang/String; = "recommend_games_link"

.field public static final RED_DOT_FLAG:Ljava/lang/String; = "red_dot_flag"

.field public static ROOT_TYPE:I = 0x0

.field public static final ROOT_TYPE_ELFIN:I = 0x2

.field public static final SERVER_TIME:Ljava/lang/String; = "server_time"

.field public static final SERVER_TIME_SUCCESSFUL:Ljava/lang/String; = "server_time_successful"

.field public static final SINGLE_APK_REQ_TIME:Ljava/lang/String; = "single_apk_req"

.field public static final SMALL_RED_DOT:Ljava/lang/String; = "small_red_dot"

.field public static final TEMPLATE_APK_REQ_TIME:Ljava/lang/String; = "template_apk_req"


# direct methods
.method static constructor <clinit>()V
    .locals 1

    .prologue
    .line 25
    const/4 v0, 0x2

    sput v0, Lcom/cyjh/elfin/constant/Constants;->ROOT_TYPE:I

    return-void
.end method

.method public constructor <init>()V
    .locals 0

    .prologue
    .line 11
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method

.method public static final getApkPath(Landroid/content/Context;)Ljava/lang/String;
    .locals 2
    .param p0, "context"    # Landroid/content/Context;

    .prologue
    .line 75
    new-instance v0, Ljava/lang/StringBuilder;

    invoke-direct {v0}, Ljava/lang/StringBuilder;-><init>()V

    invoke-static {}, Landroid/os/Environment;->getExternalStorageDirectory()Ljava/io/File;

    move-result-object v1

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/Object;)Ljava/lang/StringBuilder;

    move-result-object v0

    sget-object v1, Ljava/io/File;->separator:Ljava/lang/String;

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-virtual {p0}, Landroid/content/Context;->getPackageName()Ljava/lang/String;

    move-result-object v1

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-virtual {v0}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v0

    return-object v0
.end method

.method public static getCacheImg(Landroid/content/Context;)Ljava/io/File;
    .locals 4
    .param p0, "context"    # Landroid/content/Context;

    .prologue
    .line 45
    invoke-static {}, Landroid/os/Environment;->getExternalStorageState()Ljava/lang/String;

    move-result-object v2

    const-string v3, "mounted"

    invoke-virtual {v2, v3}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v2

    if-eqz v2, :cond_1

    .line 46
    new-instance v1, Ljava/io/File;

    invoke-static {p0}, Lcom/cyjh/elfin/constant/Constants;->getApkPath(Landroid/content/Context;)Ljava/lang/String;

    move-result-object v2

    const-string v3, "adimg"

    invoke-direct {v1, v2, v3}, Ljava/io/File;-><init>(Ljava/lang/String;Ljava/lang/String;)V

    .line 47
    .local v1, "logDir":Ljava/io/File;
    invoke-virtual {v1}, Ljava/io/File;->exists()Z

    move-result v2

    if-nez v2, :cond_0

    .line 48
    invoke-virtual {v1}, Ljava/io/File;->mkdirs()Z

    .line 50
    :cond_0
    new-instance v0, Ljava/io/File;

    const-string v2, "pic"

    invoke-direct {v0, v1, v2}, Ljava/io/File;-><init>(Ljava/io/File;Ljava/lang/String;)V

    .line 53
    .end local v1    # "logDir":Ljava/io/File;
    :goto_0
    return-object v0

    :cond_1
    const/4 v0, 0x0

    goto :goto_0
.end method

.method public static getNetworkErrorLogFile(Landroid/content/Context;)Ljava/io/File;
    .locals 4
    .param p0, "context"    # Landroid/content/Context;

    .prologue
    .line 58
    invoke-static {}, Landroid/os/Environment;->getExternalStorageState()Ljava/lang/String;

    move-result-object v2

    const-string v3, "mounted"

    invoke-virtual {v2, v3}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v2

    if-eqz v2, :cond_1

    .line 59
    new-instance v1, Ljava/io/File;

    invoke-static {p0}, Lcom/cyjh/elfin/constant/Constants;->getApkPath(Landroid/content/Context;)Ljava/lang/String;

    move-result-object v2

    const-string v3, "NetworkMessage"

    invoke-direct {v1, v2, v3}, Ljava/io/File;-><init>(Ljava/lang/String;Ljava/lang/String;)V

    .line 60
    .local v1, "logDir":Ljava/io/File;
    invoke-virtual {v1}, Ljava/io/File;->exists()Z

    move-result v2

    if-nez v2, :cond_0

    .line 61
    invoke-virtual {v1}, Ljava/io/File;->mkdirs()Z

    .line 63
    :cond_0
    new-instance v0, Ljava/io/File;

    const-string v2, "NetworkReqLog.txt"

    invoke-direct {v0, v1, v2}, Ljava/io/File;-><init>(Ljava/io/File;Ljava/lang/String;)V

    .line 66
    .end local v1    # "logDir":Ljava/io/File;
    :goto_0
    return-object v0

    :cond_1
    const/4 v0, 0x0

    goto :goto_0
.end method
