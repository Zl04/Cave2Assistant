.class public Lcom/umeng/commonsdk/statistics/internal/c;
.super Ljava/lang/Object;
.source "NetworkHelper.java"


# static fields
.field private static e:Z


# instance fields
.field private a:Ljava/lang/String;

.field private b:I

.field private c:Landroid/content/Context;

.field private d:Lcom/umeng/commonsdk/statistics/internal/b;


# direct methods
.method static constructor <clinit>()V
    .locals 1

    .prologue
    .line 63
    const/4 v0, 0x0

    sput-boolean v0, Lcom/umeng/commonsdk/statistics/internal/c;->e:Z

    return-void
.end method

.method public constructor <init>(Landroid/content/Context;)V
    .locals 1

    .prologue
    .line 65
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    .line 57
    const-string v0, "10.0.0.172"

    iput-object v0, p0, Lcom/umeng/commonsdk/statistics/internal/c;->a:Ljava/lang/String;

    .line 58
    const/16 v0, 0x50

    iput v0, p0, Lcom/umeng/commonsdk/statistics/internal/c;->b:I

    .line 66
    iput-object p1, p0, Lcom/umeng/commonsdk/statistics/internal/c;->c:Landroid/content/Context;

    .line 68
    return-void
.end method

.method private a()V
    .locals 7

    .prologue
    const/4 v6, 0x2

    const/4 v5, 0x0

    const/4 v4, 0x1

    .line 86
    iget-object v0, p0, Lcom/umeng/commonsdk/statistics/internal/c;->c:Landroid/content/Context;

    const-string v1, "domain_p"

    const-string v2, ""

    invoke-static {v0, v1, v2}, Lcom/umeng/commonsdk/framework/UMEnvelopeBuild;->imprintProperty(Landroid/content/Context;Ljava/lang/String;Ljava/lang/String;)Ljava/lang/String;

    move-result-object v0

    .line 87
    iget-object v1, p0, Lcom/umeng/commonsdk/statistics/internal/c;->c:Landroid/content/Context;

    const-string v2, "domain_s"

    const-string v3, ""

    invoke-static {v1, v2, v3}, Lcom/umeng/commonsdk/framework/UMEnvelopeBuild;->imprintProperty(Landroid/content/Context;Ljava/lang/String;Ljava/lang/String;)Ljava/lang/String;

    move-result-object v1

    .line 89
    invoke-static {v0}, Landroid/text/TextUtils;->isEmpty(Ljava/lang/CharSequence;)Z

    move-result v2

    if-nez v2, :cond_0

    .line 91
    invoke-static {v0}, Lcom/umeng/commonsdk/statistics/common/DataHelper;->assembleURL(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v0

    sput-object v0, Lcom/umeng/commonsdk/statistics/UMServerURL;->DEFAULT_URL:Ljava/lang/String;

    .line 93
    :cond_0
    invoke-static {v1}, Landroid/text/TextUtils;->isEmpty(Ljava/lang/CharSequence;)Z

    move-result v0

    if-nez v0, :cond_1

    .line 95
    invoke-static {v1}, Lcom/umeng/commonsdk/statistics/common/DataHelper;->assembleURL(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v0

    sput-object v0, Lcom/umeng/commonsdk/statistics/UMServerURL;->SECONDARY_URL:Ljava/lang/String;

    .line 97
    :cond_1
    new-array v0, v6, [Ljava/lang/String;

    sget-object v1, Lcom/umeng/commonsdk/statistics/UMServerURL;->DEFAULT_URL:Ljava/lang/String;

    aput-object v1, v0, v5

    sget-object v1, Lcom/umeng/commonsdk/statistics/UMServerURL;->SECONDARY_URL:Ljava/lang/String;

    aput-object v1, v0, v4

    sput-object v0, Lcom/umeng/commonsdk/statistics/b;->e:[Ljava/lang/String;

    .line 99
    iget-object v0, p0, Lcom/umeng/commonsdk/statistics/internal/c;->c:Landroid/content/Context;

    invoke-static {v0}, Lcom/umeng/commonsdk/statistics/noise/ABTest;->getService(Landroid/content/Context;)Lcom/umeng/commonsdk/statistics/noise/ABTest;

    move-result-object v0

    invoke-virtual {v0}, Lcom/umeng/commonsdk/statistics/noise/ABTest;->getTestPolicy()I

    move-result v0

    .line 101
    const/4 v1, -0x1

    if-eq v0, v1, :cond_2

    .line 103
    if-nez v0, :cond_3

    .line 104
    new-array v0, v6, [Ljava/lang/String;

    sget-object v1, Lcom/umeng/commonsdk/statistics/UMServerURL;->DEFAULT_URL:Ljava/lang/String;

    aput-object v1, v0, v5

    sget-object v1, Lcom/umeng/commonsdk/statistics/UMServerURL;->SECONDARY_URL:Ljava/lang/String;

    aput-object v1, v0, v4

    sput-object v0, Lcom/umeng/commonsdk/statistics/b;->e:[Ljava/lang/String;

    .line 111
    :cond_2
    :goto_0
    return-void

    .line 106
    :cond_3
    if-ne v0, v4, :cond_2

    .line 107
    new-array v0, v6, [Ljava/lang/String;

    sget-object v1, Lcom/umeng/commonsdk/statistics/UMServerURL;->SECONDARY_URL:Ljava/lang/String;

    aput-object v1, v0, v5

    sget-object v1, Lcom/umeng/commonsdk/statistics/UMServerURL;->DEFAULT_URL:Ljava/lang/String;

    aput-object v1, v0, v4

    sput-object v0, Lcom/umeng/commonsdk/statistics/b;->e:[Ljava/lang/String;

    goto :goto_0
.end method

.method private b()Z
    .locals 5

    .prologue
    const/4 v2, 0x1

    const/4 v1, 0x0

    .line 140
    iget-object v0, p0, Lcom/umeng/commonsdk/statistics/internal/c;->c:Landroid/content/Context;

    invoke-virtual {v0}, Landroid/content/Context;->getPackageManager()Landroid/content/pm/PackageManager;

    move-result-object v0

    .line 141
    const-string v3, "android.permission.ACCESS_NETWORK_STATE"

    iget-object v4, p0, Lcom/umeng/commonsdk/statistics/internal/c;->c:Landroid/content/Context;

    .line 142
    invoke-virtual {v4}, Landroid/content/Context;->getPackageName()Ljava/lang/String;

    move-result-object v4

    .line 141
    invoke-virtual {v0, v3, v4}, Landroid/content/pm/PackageManager;->checkPermission(Ljava/lang/String;Ljava/lang/String;)I

    move-result v0

    if-eqz v0, :cond_0

    move v0, v1

    .line 165
    :goto_0
    return v0

    .line 146
    :cond_0
    :try_start_0
    iget-object v0, p0, Lcom/umeng/commonsdk/statistics/internal/c;->c:Landroid/content/Context;

    const-string v3, "connectivity"

    .line 147
    invoke-virtual {v0, v3}, Landroid/content/Context;->getSystemService(Ljava/lang/String;)Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Landroid/net/ConnectivityManager;

    .line 148
    iget-object v3, p0, Lcom/umeng/commonsdk/statistics/internal/c;->c:Landroid/content/Context;

    const-string v4, "android.permission.ACCESS_NETWORK_STATE"

    invoke-static {v3, v4}, Lcom/umeng/commonsdk/statistics/common/DeviceConfig;->checkPermission(Landroid/content/Context;Ljava/lang/String;)Z

    move-result v3

    if-nez v3, :cond_1

    move v0, v1

    .line 149
    goto :goto_0

    .line 151
    :cond_1
    invoke-virtual {v0}, Landroid/net/ConnectivityManager;->getActiveNetworkInfo()Landroid/net/NetworkInfo;

    move-result-object v0

    .line 153
    if-eqz v0, :cond_3

    invoke-virtual {v0}, Landroid/net/NetworkInfo;->getType()I

    move-result v3

    if-eq v3, v2, :cond_3

    .line 154
    invoke-virtual {v0}, Landroid/net/NetworkInfo;->getExtraInfo()Ljava/lang/String;

    move-result-object v0

    .line 156
    if-eqz v0, :cond_3

    const-string v3, "cmwap"

    .line 157
    invoke-virtual {v0, v3}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v3

    if-nez v3, :cond_2

    const-string v3, "3gwap"

    invoke-virtual {v0, v3}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v3

    if-nez v3, :cond_2

    const-string v3, "uniwap"

    invoke-virtual {v0, v3}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_0

    move-result v0

    if-eqz v0, :cond_3

    :cond_2
    move v0, v2

    .line 158
    goto :goto_0

    .line 161
    :catch_0
    move-exception v0

    .line 162
    iget-object v2, p0, Lcom/umeng/commonsdk/statistics/internal/c;->c:Landroid/content/Context;

    invoke-static {v2, v0}, Lcom/umeng/commonsdk/proguard/e;->a(Landroid/content/Context;Ljava/lang/Throwable;)V

    :cond_3
    move v0, v1

    .line 165
    goto :goto_0
.end method


# virtual methods
.method public a(Lcom/umeng/commonsdk/statistics/internal/b;)V
    .locals 0

    .prologue
    .line 71
    iput-object p1, p0, Lcom/umeng/commonsdk/statistics/internal/c;->d:Lcom/umeng/commonsdk/statistics/internal/b;

    .line 72
    return-void
.end method

.method public a([BLjava/lang/String;)[B
    .locals 8

    .prologue
    const/4 v5, 0x0

    const/4 v4, 0x1

    const/4 v1, 0x0

    .line 282
    .line 285
    :try_start_0
    iget-object v0, p0, Lcom/umeng/commonsdk/statistics/internal/c;->d:Lcom/umeng/commonsdk/statistics/internal/b;

    if-eqz v0, :cond_0

    .line 286
    iget-object v0, p0, Lcom/umeng/commonsdk/statistics/internal/c;->d:Lcom/umeng/commonsdk/statistics/internal/b;

    invoke-interface {v0}, Lcom/umeng/commonsdk/statistics/internal/b;->onRequestStart()V

    .line 288
    :cond_0
    invoke-direct {p0}, Lcom/umeng/commonsdk/statistics/internal/c;->b()Z

    move-result v0

    if-eqz v0, :cond_6

    .line 289
    new-instance v0, Ljava/net/Proxy;

    sget-object v2, Ljava/net/Proxy$Type;->HTTP:Ljava/net/Proxy$Type;

    new-instance v3, Ljava/net/InetSocketAddress;

    iget-object v6, p0, Lcom/umeng/commonsdk/statistics/internal/c;->a:Ljava/lang/String;

    iget v7, p0, Lcom/umeng/commonsdk/statistics/internal/c;->b:I

    invoke-direct {v3, v6, v7}, Ljava/net/InetSocketAddress;-><init>(Ljava/lang/String;I)V

    invoke-direct {v0, v2, v3}, Ljava/net/Proxy;-><init>(Ljava/net/Proxy$Type;Ljava/net/SocketAddress;)V

    .line 290
    new-instance v2, Ljava/net/URL;

    invoke-direct {v2, p2}, Ljava/net/URL;-><init>(Ljava/lang/String;)V

    invoke-virtual {v2, v0}, Ljava/net/URL;->openConnection(Ljava/net/Proxy;)Ljava/net/URLConnection;

    move-result-object v0

    check-cast v0, Ljavax/net/ssl/HttpsURLConnection;
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_5
    .catchall {:try_start_0 .. :try_end_0} :catchall_1

    move-object v3, v0

    .line 296
    :goto_0
    :try_start_1
    sget-boolean v0, Lcom/umeng/commonsdk/statistics/internal/c;->e:Z

    if-nez v0, :cond_1

    .line 297
    new-instance v0, Lcom/umeng/commonsdk/statistics/internal/c$1;

    invoke-direct {v0, p0}, Lcom/umeng/commonsdk/statistics/internal/c$1;-><init>(Lcom/umeng/commonsdk/statistics/internal/c;)V

    invoke-static {v0}, Ljavax/net/ssl/HttpsURLConnection;->setDefaultHostnameVerifier(Ljavax/net/ssl/HostnameVerifier;)V

    .line 315
    const-string v0, "TLS"

    invoke-static {v0}, Ljavax/net/ssl/SSLContext;->getInstance(Ljava/lang/String;)Ljavax/net/ssl/SSLContext;

    move-result-object v0

    .line 316
    const/4 v2, 0x0

    const/4 v6, 0x0

    new-instance v7, Ljava/security/SecureRandom;

    invoke-direct {v7}, Ljava/security/SecureRandom;-><init>()V

    invoke-virtual {v0, v2, v6, v7}, Ljavax/net/ssl/SSLContext;->init([Ljavax/net/ssl/KeyManager;[Ljavax/net/ssl/TrustManager;Ljava/security/SecureRandom;)V

    .line 317
    invoke-virtual {v0}, Ljavax/net/ssl/SSLContext;->getSocketFactory()Ljavax/net/ssl/SSLSocketFactory;

    move-result-object v0

    invoke-static {v0}, Ljavax/net/ssl/HttpsURLConnection;->setDefaultSSLSocketFactory(Ljavax/net/ssl/SSLSocketFactory;)V

    .line 318
    const/4 v0, 0x1

    sput-boolean v0, Lcom/umeng/commonsdk/statistics/internal/c;->e:Z

    .line 322
    :cond_1
    const-string v0, "X-Umeng-UTC"

    invoke-static {}, Ljava/lang/System;->currentTimeMillis()J

    move-result-wide v6

    invoke-static {v6, v7}, Ljava/lang/String;->valueOf(J)Ljava/lang/String;

    move-result-object v2

    invoke-virtual {v3, v0, v2}, Ljavax/net/ssl/HttpsURLConnection;->setRequestProperty(Ljava/lang/String;Ljava/lang/String;)V

    .line 323
    const-string v0, "X-Umeng-Sdk"

    iget-object v2, p0, Lcom/umeng/commonsdk/statistics/internal/c;->c:Landroid/content/Context;

    invoke-static {v2}, Lcom/umeng/commonsdk/statistics/internal/a;->a(Landroid/content/Context;)Lcom/umeng/commonsdk/statistics/internal/a;

    move-result-object v2

    invoke-virtual {v2}, Lcom/umeng/commonsdk/statistics/internal/a;->b()Ljava/lang/String;

    move-result-object v2

    invoke-virtual {v3, v0, v2}, Ljavax/net/ssl/HttpsURLConnection;->setRequestProperty(Ljava/lang/String;Ljava/lang/String;)V

    .line 324
    const-string v0, "Content-Type"

    iget-object v2, p0, Lcom/umeng/commonsdk/statistics/internal/c;->c:Landroid/content/Context;

    invoke-static {v2}, Lcom/umeng/commonsdk/statistics/internal/a;->a(Landroid/content/Context;)Lcom/umeng/commonsdk/statistics/internal/a;

    move-result-object v2

    invoke-virtual {v2}, Lcom/umeng/commonsdk/statistics/internal/a;->a()Ljava/lang/String;

    move-result-object v2

    invoke-virtual {v3, v0, v2}, Ljavax/net/ssl/HttpsURLConnection;->setRequestProperty(Ljava/lang/String;Ljava/lang/String;)V

    .line 325
    const-string v0, "Msg-Type"

    const-string v2, "envelope/json"

    invoke-virtual {v3, v0, v2}, Ljavax/net/ssl/HttpsURLConnection;->setRequestProperty(Ljava/lang/String;Ljava/lang/String;)V

    .line 335
    const/16 v0, 0x7530

    invoke-virtual {v3, v0}, Ljavax/net/ssl/HttpsURLConnection;->setConnectTimeout(I)V

    .line 336
    const/16 v0, 0x7530

    invoke-virtual {v3, v0}, Ljavax/net/ssl/HttpsURLConnection;->setReadTimeout(I)V

    .line 337
    const-string v0, "POST"

    invoke-virtual {v3, v0}, Ljavax/net/ssl/HttpsURLConnection;->setRequestMethod(Ljava/lang/String;)V

    .line 339
    const/4 v0, 0x1

    invoke-virtual {v3, v0}, Ljavax/net/ssl/HttpsURLConnection;->setDoOutput(Z)V

    .line 340
    const/4 v0, 0x1

    invoke-virtual {v3, v0}, Ljavax/net/ssl/HttpsURLConnection;->setDoInput(Z)V

    .line 341
    const/4 v0, 0x0

    invoke-virtual {v3, v0}, Ljavax/net/ssl/HttpsURLConnection;->setUseCaches(Z)V

    .line 344
    invoke-virtual {v3}, Ljavax/net/ssl/HttpsURLConnection;->getOutputStream()Ljava/io/OutputStream;
    :try_end_1
    .catch Ljava/lang/Throwable; {:try_start_1 .. :try_end_1} :catch_6
    .catchall {:try_start_1 .. :try_end_1} :catchall_2

    move-result-object v2

    .line 345
    :try_start_2
    invoke-virtual {v2, p1}, Ljava/io/OutputStream;->write([B)V

    .line 346
    invoke-virtual {v2}, Ljava/io/OutputStream;->flush()V

    .line 348
    invoke-virtual {v3}, Ljavax/net/ssl/HttpsURLConnection;->connect()V

    .line 351
    iget-object v0, p0, Lcom/umeng/commonsdk/statistics/internal/c;->d:Lcom/umeng/commonsdk/statistics/internal/b;

    if-eqz v0, :cond_2

    .line 352
    iget-object v0, p0, Lcom/umeng/commonsdk/statistics/internal/c;->d:Lcom/umeng/commonsdk/statistics/internal/b;

    invoke-interface {v0}, Lcom/umeng/commonsdk/statistics/internal/b;->onRequestEnd()V

    .line 354
    :cond_2
    invoke-virtual {v3}, Ljavax/net/ssl/HttpsURLConnection;->getResponseCode()I

    move-result v6

    .line 355
    const-string v0, "Content-Type"

    invoke-virtual {v3, v0}, Ljavax/net/ssl/HttpsURLConnection;->getHeaderField(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v0

    .line 357
    invoke-static {v0}, Landroid/text/TextUtils;->isEmpty(Ljava/lang/CharSequence;)Z

    move-result v7

    if-nez v7, :cond_e

    const-string v7, "application/thrift"

    invoke-virtual {v0, v7}, Ljava/lang/String;->equalsIgnoreCase(Ljava/lang/String;)Z

    move-result v0

    if-eqz v0, :cond_e

    move v0, v4

    .line 360
    :goto_1
    sget-boolean v4, Lcom/umeng/commonsdk/statistics/b;->f:Z

    if-eqz v4, :cond_3

    .line 361
    new-instance v4, Ljava/lang/StringBuilder;

    invoke-direct {v4}, Ljava/lang/StringBuilder;-><init>()V

    const-string v5, "status code : "

    invoke-virtual {v4, v5}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v4

    invoke-virtual {v4, v6}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v4

    const-string v5, "; isThrifit:"

    invoke-virtual {v4, v5}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v4

    invoke-virtual {v4, v0}, Ljava/lang/StringBuilder;->append(Z)Ljava/lang/StringBuilder;

    move-result-object v4

    invoke-virtual {v4}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v4

    invoke-static {v4}, Lcom/umeng/commonsdk/statistics/common/MLog;->d(Ljava/lang/String;)V

    .line 363
    :cond_3
    const/16 v4, 0xc8

    if-ne v6, v4, :cond_9

    if-eqz v0, :cond_9

    .line 364
    new-instance v0, Ljava/lang/StringBuilder;

    invoke-direct {v0}, Ljava/lang/StringBuilder;-><init>()V

    const-string v4, "Send message to server. status code is: "

    invoke-virtual {v0, v4}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-virtual {v0, v6}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-virtual {v0}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v0

    invoke-static {v0}, Lcom/umeng/commonsdk/statistics/common/MLog;->i(Ljava/lang/String;)V

    .line 366
    invoke-virtual {v3}, Ljavax/net/ssl/HttpsURLConnection;->getInputStream()Ljava/io/InputStream;
    :try_end_2
    .catch Ljava/lang/Throwable; {:try_start_2 .. :try_end_2} :catch_0
    .catchall {:try_start_2 .. :try_end_2} :catchall_3

    move-result-object v4

    .line 369
    :try_start_3
    invoke-static {v4}, Lcom/umeng/commonsdk/statistics/common/HelperUtils;->readStreamToByteArray(Ljava/io/InputStream;)[B
    :try_end_3
    .catchall {:try_start_3 .. :try_end_3} :catchall_0

    move-result-object v0

    .line 371
    :try_start_4
    invoke-static {v4}, Lcom/umeng/commonsdk/statistics/common/HelperUtils;->safeClose(Ljava/io/InputStream;)V
    :try_end_4
    .catch Ljava/lang/Throwable; {:try_start_4 .. :try_end_4} :catch_0
    .catchall {:try_start_4 .. :try_end_4} :catchall_3

    .line 380
    if-eqz v2, :cond_4

    .line 382
    :try_start_5
    invoke-virtual {v2}, Ljava/io/OutputStream;->close()V
    :try_end_5
    .catch Ljava/lang/Exception; {:try_start_5 .. :try_end_5} :catch_1

    .line 386
    :cond_4
    :goto_2
    if-eqz v3, :cond_5

    .line 387
    invoke-virtual {v3}, Ljavax/net/ssl/HttpsURLConnection;->disconnect()V

    .line 390
    :cond_5
    :goto_3
    return-object v0

    .line 292
    :cond_6
    :try_start_6
    new-instance v0, Ljava/net/URL;

    invoke-direct {v0, p2}, Ljava/net/URL;-><init>(Ljava/lang/String;)V

    invoke-virtual {v0}, Ljava/net/URL;->openConnection()Ljava/net/URLConnection;

    move-result-object v0

    check-cast v0, Ljavax/net/ssl/HttpsURLConnection;
    :try_end_6
    .catch Ljava/lang/Throwable; {:try_start_6 .. :try_end_6} :catch_5
    .catchall {:try_start_6 .. :try_end_6} :catchall_1

    move-object v3, v0

    goto/16 :goto_0

    .line 371
    :catchall_0
    move-exception v0

    :try_start_7
    invoke-static {v4}, Lcom/umeng/commonsdk/statistics/common/HelperUtils;->safeClose(Ljava/io/InputStream;)V

    throw v0
    :try_end_7
    .catch Ljava/lang/Throwable; {:try_start_7 .. :try_end_7} :catch_0
    .catchall {:try_start_7 .. :try_end_7} :catchall_3

    .line 375
    :catch_0
    move-exception v0

    .line 376
    :goto_4
    :try_start_8
    const-string v4, "IOException,Failed to send message."

    invoke-static {v4, v0}, Lcom/umeng/commonsdk/statistics/common/MLog;->e(Ljava/lang/String;Ljava/lang/Throwable;)V

    .line 377
    iget-object v4, p0, Lcom/umeng/commonsdk/statistics/internal/c;->c:Landroid/content/Context;

    invoke-static {v4, v0}, Lcom/umeng/commonsdk/proguard/e;->a(Landroid/content/Context;Ljava/lang/Throwable;)V
    :try_end_8
    .catchall {:try_start_8 .. :try_end_8} :catchall_3

    .line 380
    if-eqz v2, :cond_7

    .line 382
    :try_start_9
    invoke-virtual {v2}, Ljava/io/OutputStream;->close()V
    :try_end_9
    .catch Ljava/lang/Exception; {:try_start_9 .. :try_end_9} :catch_3

    .line 386
    :cond_7
    :goto_5
    if-eqz v3, :cond_8

    .line 387
    invoke-virtual {v3}, Ljavax/net/ssl/HttpsURLConnection;->disconnect()V

    :cond_8
    move-object v0, v1

    goto :goto_3

    .line 380
    :cond_9
    if-eqz v2, :cond_a

    .line 382
    :try_start_a
    invoke-virtual {v2}, Ljava/io/OutputStream;->close()V
    :try_end_a
    .catch Ljava/lang/Exception; {:try_start_a .. :try_end_a} :catch_2

    .line 386
    :cond_a
    :goto_6
    if-eqz v3, :cond_b

    .line 387
    invoke-virtual {v3}, Ljavax/net/ssl/HttpsURLConnection;->disconnect()V

    :cond_b
    move-object v0, v1

    .line 390
    goto :goto_3

    .line 380
    :catchall_1
    move-exception v0

    move-object v3, v1

    :goto_7
    if-eqz v1, :cond_c

    .line 382
    :try_start_b
    invoke-virtual {v1}, Ljava/io/OutputStream;->close()V
    :try_end_b
    .catch Ljava/lang/Exception; {:try_start_b .. :try_end_b} :catch_4

    .line 386
    :cond_c
    :goto_8
    if-eqz v3, :cond_d

    .line 387
    invoke-virtual {v3}, Ljavax/net/ssl/HttpsURLConnection;->disconnect()V

    :cond_d
    throw v0

    .line 383
    :catch_1
    move-exception v1

    goto :goto_2

    :catch_2
    move-exception v0

    goto :goto_6

    :catch_3
    move-exception v0

    goto :goto_5

    :catch_4
    move-exception v1

    goto :goto_8

    .line 380
    :catchall_2
    move-exception v0

    goto :goto_7

    :catchall_3
    move-exception v0

    move-object v1, v2

    goto :goto_7

    .line 375
    :catch_5
    move-exception v0

    move-object v2, v1

    move-object v3, v1

    goto :goto_4

    :catch_6
    move-exception v0

    move-object v2, v1

    goto :goto_4

    :cond_e
    move v0, v5

    goto/16 :goto_1
.end method

.method public a([BZ)[B
    .locals 3

    .prologue
    .line 121
    const/4 v1, 0x0

    .line 122
    invoke-direct {p0}, Lcom/umeng/commonsdk/statistics/internal/c;->a()V

    .line 123
    const/4 v0, 0x0

    :goto_0
    sget-object v2, Lcom/umeng/commonsdk/statistics/b;->e:[Ljava/lang/String;

    array-length v2, v2

    if-ge v0, v2, :cond_0

    .line 124
    sget-object v1, Lcom/umeng/commonsdk/statistics/b;->e:[Ljava/lang/String;

    aget-object v1, v1, v0

    invoke-virtual {p0, p1, v1}, Lcom/umeng/commonsdk/statistics/internal/c;->a([BLjava/lang/String;)[B

    move-result-object v1

    .line 126
    if-eqz v1, :cond_1

    .line 127
    iget-object v0, p0, Lcom/umeng/commonsdk/statistics/internal/c;->d:Lcom/umeng/commonsdk/statistics/internal/b;

    if-eqz v0, :cond_0

    .line 128
    iget-object v0, p0, Lcom/umeng/commonsdk/statistics/internal/c;->d:Lcom/umeng/commonsdk/statistics/internal/b;

    invoke-interface {v0, p2}, Lcom/umeng/commonsdk/statistics/internal/b;->onRequestSucceed(Z)V

    .line 136
    :cond_0
    return-object v1

    .line 132
    :cond_1
    iget-object v2, p0, Lcom/umeng/commonsdk/statistics/internal/c;->d:Lcom/umeng/commonsdk/statistics/internal/b;

    if-eqz v2, :cond_2

    .line 133
    iget-object v2, p0, Lcom/umeng/commonsdk/statistics/internal/c;->d:Lcom/umeng/commonsdk/statistics/internal/b;

    invoke-interface {v2}, Lcom/umeng/commonsdk/statistics/internal/b;->onRequestFailed()V

    .line 123
    :cond_2
    add-int/lit8 v0, v0, 0x1

    goto :goto_0
.end method
