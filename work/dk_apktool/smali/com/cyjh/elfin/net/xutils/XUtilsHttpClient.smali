.class public Lcom/cyjh/elfin/net/xutils/XUtilsHttpClient;
.super Ljava/lang/Object;
.source "XUtilsHttpClient.java"


# static fields
.field private static final DEFAULT_CONNECTION_TIMEOUT:I = 0x2710

.field private static final DEFAULT_SOCKET_TIMEOUT:I = 0x2710

.field public static final PROTOCOL_HTTP:Ljava/lang/String; = "http"

.field private static httpUtils:Lcom/lidroid/xutils/HttpUtils;


# direct methods
.method public constructor <init>()V
    .locals 0

    .prologue
    .line 13
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method

.method public static declared-synchronized getInstence(Landroid/content/Context;)Lcom/lidroid/xutils/HttpUtils;
    .locals 4
    .param p0, "context"    # Landroid/content/Context;

    .prologue
    .line 27
    const-class v2, Lcom/cyjh/elfin/net/xutils/XUtilsHttpClient;

    monitor-enter v2

    :try_start_0
    sget-object v1, Lcom/cyjh/elfin/net/xutils/XUtilsHttpClient;->httpUtils:Lcom/lidroid/xutils/HttpUtils;

    if-nez v1, :cond_0

    .line 29
    new-instance v1, Lcom/lidroid/xutils/HttpUtils;

    const/16 v3, 0x2710

    invoke-direct {v1, v3}, Lcom/lidroid/xutils/HttpUtils;-><init>(I)V

    sput-object v1, Lcom/cyjh/elfin/net/xutils/XUtilsHttpClient;->httpUtils:Lcom/lidroid/xutils/HttpUtils;

    .line 30
    sget-object v1, Lcom/cyjh/elfin/net/xutils/XUtilsHttpClient;->httpUtils:Lcom/lidroid/xutils/HttpUtils;

    const/16 v3, 0x2710

    invoke-virtual {v1, v3}, Lcom/lidroid/xutils/HttpUtils;->configSoTimeout(I)Lcom/lidroid/xutils/HttpUtils;

    .line 31
    sget-object v1, Lcom/cyjh/elfin/net/xutils/XUtilsHttpClient;->httpUtils:Lcom/lidroid/xutils/HttpUtils;

    const-string v3, "UTF-8"

    invoke-virtual {v1, v3}, Lcom/lidroid/xutils/HttpUtils;->configResponseTextCharset(Ljava/lang/String;)Lcom/lidroid/xutils/HttpUtils;

    .line 33
    new-instance v0, Lcom/lidroid/xutils/util/PreferencesCookieStore;

    invoke-virtual {p0}, Landroid/content/Context;->getApplicationContext()Landroid/content/Context;

    move-result-object v1

    invoke-direct {v0, v1}, Lcom/lidroid/xutils/util/PreferencesCookieStore;-><init>(Landroid/content/Context;)V

    .line 34
    .local v0, "cookieStore":Lcom/lidroid/xutils/util/PreferencesCookieStore;
    invoke-virtual {v0}, Lcom/lidroid/xutils/util/PreferencesCookieStore;->clear()V

    .line 35
    sget-object v1, Lcom/cyjh/elfin/net/xutils/XUtilsHttpClient;->httpUtils:Lcom/lidroid/xutils/HttpUtils;

    invoke-virtual {v1, v0}, Lcom/lidroid/xutils/HttpUtils;->configCookieStore(Lorg/apache/http/client/CookieStore;)Lcom/lidroid/xutils/HttpUtils;

    .line 37
    .end local v0    # "cookieStore":Lcom/lidroid/xutils/util/PreferencesCookieStore;
    :cond_0
    sget-object v1, Lcom/cyjh/elfin/net/xutils/XUtilsHttpClient;->httpUtils:Lcom/lidroid/xutils/HttpUtils;
    :try_end_0
    .catchall {:try_start_0 .. :try_end_0} :catchall_0

    monitor-exit v2

    return-object v1

    .line 27
    :catchall_0
    move-exception v1

    monitor-exit v2

    throw v1
.end method

.method public static getURL(Ljava/lang/String;Ljava/lang/String;ILjava/lang/String;)Ljava/lang/String;
    .locals 8
    .param p0, "protocol"    # Ljava/lang/String;
    .param p1, "host"    # Ljava/lang/String;
    .param p2, "port"    # I
    .param p3, "path"    # Ljava/lang/String;

    .prologue
    .line 41
    const/4 v7, 0x0

    .line 43
    .local v7, "url":Ljava/lang/String;
    const/4 v4, 0x0

    const/4 v5, 0x0

    move-object v0, p0

    move-object v1, p1

    move v2, p2

    move-object v3, p3

    :try_start_0
    invoke-static/range {v0 .. v5}, Lorg/apache/http/client/utils/URIUtils;->createURI(Ljava/lang/String;Ljava/lang/String;ILjava/lang/String;Ljava/lang/String;Ljava/lang/String;)Ljava/net/URI;

    move-result-object v0

    invoke-virtual {v0}, Ljava/net/URI;->toString()Ljava/lang/String;
    :try_end_0
    .catch Ljava/net/URISyntaxException; {:try_start_0 .. :try_end_0} :catch_0
    .catch Ljava/lang/Exception; {:try_start_0 .. :try_end_0} :catch_1

    move-result-object v7

    .line 49
    :goto_0
    return-object v7

    .line 44
    :catch_0
    move-exception v6

    .line 45
    .local v6, "e":Ljava/net/URISyntaxException;
    invoke-virtual {v6}, Ljava/net/URISyntaxException;->printStackTrace()V

    goto :goto_0

    .line 46
    .end local v6    # "e":Ljava/net/URISyntaxException;
    :catch_1
    move-exception v6

    .line 47
    .local v6, "e":Ljava/lang/Exception;
    invoke-virtual {v6}, Ljava/lang/Exception;->printStackTrace()V

    goto :goto_0
.end method
