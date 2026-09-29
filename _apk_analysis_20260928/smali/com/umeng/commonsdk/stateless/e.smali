.class public Lcom/umeng/commonsdk/stateless/e;
.super Ljava/lang/Object;
.source "UMSLNetWorkSenderHelper.java"


# instance fields
.field private a:Ljava/lang/String;

.field private b:I

.field private c:Landroid/content/Context;


# direct methods
.method public constructor <init>(Landroid/content/Context;)V
    .locals 1

    .prologue
    .line 42
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    .line 37
    const-string v0, "10.0.0.172"

    iput-object v0, p0, Lcom/umeng/commonsdk/stateless/e;->a:Ljava/lang/String;

    .line 38
    const/16 v0, 0x50

    iput v0, p0, Lcom/umeng/commonsdk/stateless/e;->b:I

    .line 43
    iput-object p1, p0, Lcom/umeng/commonsdk/stateless/e;->c:Landroid/content/Context;

    .line 44
    return-void
.end method

.method private a()Z
    .locals 5

    .prologue
    const/4 v2, 0x1

    const/4 v1, 0x0

    .line 47
    iget-object v0, p0, Lcom/umeng/commonsdk/stateless/e;->c:Landroid/content/Context;

    if-eqz v0, :cond_3

    .line 48
    iget-object v0, p0, Lcom/umeng/commonsdk/stateless/e;->c:Landroid/content/Context;

    invoke-virtual {v0}, Landroid/content/Context;->getPackageManager()Landroid/content/pm/PackageManager;

    move-result-object v0

    .line 49
    const-string v3, "android.permission.ACCESS_NETWORK_STATE"

    iget-object v4, p0, Lcom/umeng/commonsdk/stateless/e;->c:Landroid/content/Context;

    .line 50
    invoke-virtual {v4}, Landroid/content/Context;->getPackageName()Ljava/lang/String;

    move-result-object v4

    .line 49
    invoke-virtual {v0, v3, v4}, Landroid/content/pm/PackageManager;->checkPermission(Ljava/lang/String;Ljava/lang/String;)I

    move-result v0

    if-eqz v0, :cond_0

    move v0, v1

    .line 72
    :goto_0
    return v0

    .line 54
    :cond_0
    :try_start_0
    iget-object v0, p0, Lcom/umeng/commonsdk/stateless/e;->c:Landroid/content/Context;

    const-string v3, "connectivity"

    .line 55
    invoke-virtual {v0, v3}, Landroid/content/Context;->getSystemService(Ljava/lang/String;)Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Landroid/net/ConnectivityManager;

    .line 56
    iget-object v3, p0, Lcom/umeng/commonsdk/stateless/e;->c:Landroid/content/Context;

    const-string v4, "android.permission.ACCESS_NETWORK_STATE"

    invoke-static {v3, v4}, Lcom/umeng/commonsdk/statistics/common/DeviceConfig;->checkPermission(Landroid/content/Context;Ljava/lang/String;)Z

    move-result v3

    if-nez v3, :cond_1

    move v0, v1

    .line 57
    goto :goto_0

    .line 59
    :cond_1
    invoke-virtual {v0}, Landroid/net/ConnectivityManager;->getActiveNetworkInfo()Landroid/net/NetworkInfo;

    move-result-object v0

    .line 60
    if-eqz v0, :cond_3

    invoke-virtual {v0}, Landroid/net/NetworkInfo;->getType()I

    move-result v3

    if-eq v3, v2, :cond_3

    .line 61
    invoke-virtual {v0}, Landroid/net/NetworkInfo;->getExtraInfo()Ljava/lang/String;

    move-result-object v0

    .line 62
    if-eqz v0, :cond_3

    const-string v3, "cmwap"

    .line 63
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

    .line 64
    goto :goto_0

    .line 67
    :catch_0
    move-exception v0

    .line 68
    iget-object v2, p0, Lcom/umeng/commonsdk/stateless/e;->c:Landroid/content/Context;

    invoke-static {v2, v0}, Lcom/umeng/commonsdk/proguard/e;->a(Landroid/content/Context;Ljava/lang/Throwable;)V

    :cond_3
    move v0, v1

    .line 72
    goto :goto_0
.end method


# virtual methods
.method public a([BLjava/lang/String;)Z
    .locals 8

    .prologue
    const/4 v2, 0x0

    const/4 v4, 0x1

    const/4 v1, 0x0

    .line 77
    if-eqz p1, :cond_0

    if-nez p2, :cond_2

    .line 78
    :cond_0
    const-string v0, "walle"

    new-array v2, v4, [Ljava/lang/Object;

    const-string v3, "[stateless] sendMessage, envelopeByte == null || path == null "

    aput-object v3, v2, v1

    invoke-static {v0, v2}, Lcom/umeng/commonsdk/statistics/common/e;->a(Ljava/lang/String;[Ljava/lang/Object;)V

    move v0, v1

    .line 154
    :cond_1
    :goto_0
    return v0

    .line 87
    :cond_2
    :try_start_0
    invoke-direct {p0}, Lcom/umeng/commonsdk/stateless/e;->a()Z

    move-result v0

    if-eqz v0, :cond_4

    .line 88
    new-instance v0, Ljava/net/Proxy;

    sget-object v3, Ljava/net/Proxy$Type;->HTTP:Ljava/net/Proxy$Type;

    new-instance v5, Ljava/net/InetSocketAddress;

    iget-object v6, p0, Lcom/umeng/commonsdk/stateless/e;->a:Ljava/lang/String;

    iget v7, p0, Lcom/umeng/commonsdk/stateless/e;->b:I

    invoke-direct {v5, v6, v7}, Ljava/net/InetSocketAddress;-><init>(Ljava/lang/String;I)V

    invoke-direct {v0, v3, v5}, Ljava/net/Proxy;-><init>(Ljava/net/Proxy$Type;Ljava/net/SocketAddress;)V

    .line 89
    new-instance v3, Ljava/net/URL;

    new-instance v5, Ljava/lang/StringBuilder;

    invoke-direct {v5}, Ljava/lang/StringBuilder;-><init>()V

    const-string v6, "https://plbslog.umeng.com/"

    invoke-virtual {v5, v6}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v5

    invoke-virtual {v5, p2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v5

    invoke-virtual {v5}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v5

    invoke-direct {v3, v5}, Ljava/net/URL;-><init>(Ljava/lang/String;)V

    invoke-virtual {v3, v0}, Ljava/net/URL;->openConnection(Ljava/net/Proxy;)Ljava/net/URLConnection;

    move-result-object v0

    check-cast v0, Ljavax/net/ssl/HttpsURLConnection;
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_0
    .catchall {:try_start_0 .. :try_end_0} :catchall_0

    move-object v3, v0

    .line 95
    :goto_1
    :try_start_1
    new-instance v0, Lcom/umeng/commonsdk/stateless/e$1;

    invoke-direct {v0, p0}, Lcom/umeng/commonsdk/stateless/e$1;-><init>(Lcom/umeng/commonsdk/stateless/e;)V

    invoke-static {v0}, Ljavax/net/ssl/HttpsURLConnection;->setDefaultHostnameVerifier(Ljavax/net/ssl/HostnameVerifier;)V

    .line 113
    const-string v0, "TLS"

    invoke-static {v0}, Ljavax/net/ssl/SSLContext;->getInstance(Ljava/lang/String;)Ljavax/net/ssl/SSLContext;

    move-result-object v0

    .line 114
    const/4 v5, 0x0

    const/4 v6, 0x0

    new-instance v7, Ljava/security/SecureRandom;

    invoke-direct {v7}, Ljava/security/SecureRandom;-><init>()V

    invoke-virtual {v0, v5, v6, v7}, Ljavax/net/ssl/SSLContext;->init([Ljavax/net/ssl/KeyManager;[Ljavax/net/ssl/TrustManager;Ljava/security/SecureRandom;)V

    .line 115
    invoke-virtual {v0}, Ljavax/net/ssl/SSLContext;->getSocketFactory()Ljavax/net/ssl/SSLSocketFactory;

    move-result-object v0

    invoke-static {v0}, Ljavax/net/ssl/HttpsURLConnection;->setDefaultSSLSocketFactory(Ljavax/net/ssl/SSLSocketFactory;)V

    .line 118
    const-string v0, "X-Umeng-UTC"

    invoke-static {}, Ljava/lang/System;->currentTimeMillis()J

    move-result-wide v6

    invoke-static {v6, v7}, Ljava/lang/String;->valueOf(J)Ljava/lang/String;

    move-result-object v5

    invoke-virtual {v3, v0, v5}, Ljavax/net/ssl/HttpsURLConnection;->setRequestProperty(Ljava/lang/String;Ljava/lang/String;)V

    .line 119
    const-string v0, "Msg-Type"

    const-string v5, "envelope/json"

    invoke-virtual {v3, v0, v5}, Ljavax/net/ssl/HttpsURLConnection;->setRequestProperty(Ljava/lang/String;Ljava/lang/String;)V

    .line 121
    const/16 v0, 0x7530

    invoke-virtual {v3, v0}, Ljavax/net/ssl/HttpsURLConnection;->setConnectTimeout(I)V

    .line 122
    const/16 v0, 0x7530

    invoke-virtual {v3, v0}, Ljavax/net/ssl/HttpsURLConnection;->setReadTimeout(I)V

    .line 123
    const-string v0, "POST"

    invoke-virtual {v3, v0}, Ljavax/net/ssl/HttpsURLConnection;->setRequestMethod(Ljava/lang/String;)V

    .line 125
    const/4 v0, 0x1

    invoke-virtual {v3, v0}, Ljavax/net/ssl/HttpsURLConnection;->setDoOutput(Z)V

    .line 126
    const/4 v0, 0x1

    invoke-virtual {v3, v0}, Ljavax/net/ssl/HttpsURLConnection;->setDoInput(Z)V

    .line 127
    const/4 v0, 0x0

    invoke-virtual {v3, v0}, Ljavax/net/ssl/HttpsURLConnection;->setUseCaches(Z)V

    .line 129
    invoke-virtual {v3}, Ljavax/net/ssl/HttpsURLConnection;->getOutputStream()Ljava/io/OutputStream;

    move-result-object v2

    .line 130
    invoke-virtual {v2, p1}, Ljava/io/OutputStream;->write([B)V

    .line 131
    invoke-virtual {v2}, Ljava/io/OutputStream;->flush()V

    .line 133
    invoke-virtual {v3}, Ljavax/net/ssl/HttpsURLConnection;->connect()V

    .line 135
    invoke-virtual {v3}, Ljavax/net/ssl/HttpsURLConnection;->getResponseCode()I
    :try_end_1
    .catch Ljava/lang/Throwable; {:try_start_1 .. :try_end_1} :catch_4
    .catchall {:try_start_1 .. :try_end_1} :catchall_1

    move-result v0

    .line 137
    const/16 v5, 0xc8

    if-ne v0, v5, :cond_9

    move v0, v4

    .line 144
    :goto_2
    if-eqz v2, :cond_3

    .line 146
    :try_start_2
    invoke-virtual {v2}, Ljava/io/OutputStream;->close()V
    :try_end_2
    .catch Ljava/lang/Exception; {:try_start_2 .. :try_end_2} :catch_1

    .line 150
    :cond_3
    :goto_3
    if-eqz v3, :cond_1

    .line 151
    invoke-virtual {v3}, Ljavax/net/ssl/HttpsURLConnection;->disconnect()V

    goto/16 :goto_0

    .line 91
    :cond_4
    :try_start_3
    new-instance v0, Ljava/net/URL;

    new-instance v3, Ljava/lang/StringBuilder;

    invoke-direct {v3}, Ljava/lang/StringBuilder;-><init>()V

    const-string v5, "https://plbslog.umeng.com/"

    invoke-virtual {v3, v5}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v3

    invoke-virtual {v3, p2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v3

    invoke-virtual {v3}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v3

    invoke-direct {v0, v3}, Ljava/net/URL;-><init>(Ljava/lang/String;)V

    invoke-virtual {v0}, Ljava/net/URL;->openConnection()Ljava/net/URLConnection;

    move-result-object v0

    check-cast v0, Ljavax/net/ssl/HttpsURLConnection;
    :try_end_3
    .catch Ljava/lang/Throwable; {:try_start_3 .. :try_end_3} :catch_0
    .catchall {:try_start_3 .. :try_end_3} :catchall_0

    move-object v3, v0

    goto/16 :goto_1

    .line 141
    :catch_0
    move-exception v0

    move-object v3, v2

    .line 142
    :goto_4
    :try_start_4
    iget-object v4, p0, Lcom/umeng/commonsdk/stateless/e;->c:Landroid/content/Context;

    invoke-static {v4, v0}, Lcom/umeng/commonsdk/proguard/e;->a(Landroid/content/Context;Ljava/lang/Throwable;)V
    :try_end_4
    .catchall {:try_start_4 .. :try_end_4} :catchall_1

    .line 144
    if-eqz v2, :cond_5

    .line 146
    :try_start_5
    invoke-virtual {v2}, Ljava/io/OutputStream;->close()V
    :try_end_5
    .catch Ljava/lang/Exception; {:try_start_5 .. :try_end_5} :catch_2

    .line 150
    :cond_5
    :goto_5
    if-eqz v3, :cond_8

    .line 151
    invoke-virtual {v3}, Ljavax/net/ssl/HttpsURLConnection;->disconnect()V

    move v0, v1

    goto/16 :goto_0

    .line 144
    :catchall_0
    move-exception v0

    move-object v3, v2

    :goto_6
    if-eqz v2, :cond_6

    .line 146
    :try_start_6
    invoke-virtual {v2}, Ljava/io/OutputStream;->close()V
    :try_end_6
    .catch Ljava/lang/Exception; {:try_start_6 .. :try_end_6} :catch_3

    .line 150
    :cond_6
    :goto_7
    if-eqz v3, :cond_7

    .line 151
    invoke-virtual {v3}, Ljavax/net/ssl/HttpsURLConnection;->disconnect()V

    :cond_7
    throw v0

    .line 147
    :catch_1
    move-exception v1

    goto :goto_3

    :catch_2
    move-exception v0

    goto :goto_5

    :catch_3
    move-exception v1

    goto :goto_7

    .line 144
    :catchall_1
    move-exception v0

    goto :goto_6

    .line 141
    :catch_4
    move-exception v0

    goto :goto_4

    :cond_8
    move v0, v1

    goto/16 :goto_0

    :cond_9
    move v0, v1

    goto :goto_2
.end method

.method public b([BLjava/lang/String;)Z
    .locals 8

    .prologue
    const/4 v2, 0x0

    const/4 v4, 0x1

    const/4 v1, 0x0

    .line 158
    if-eqz p1, :cond_0

    if-nez p2, :cond_2

    :cond_0
    move v0, v1

    .line 212
    :cond_1
    :goto_0
    return v0

    .line 167
    :cond_2
    :try_start_0
    invoke-direct {p0}, Lcom/umeng/commonsdk/stateless/e;->a()Z

    move-result v0

    if-eqz v0, :cond_4

    .line 168
    new-instance v0, Ljava/net/Proxy;

    sget-object v3, Ljava/net/Proxy$Type;->HTTP:Ljava/net/Proxy$Type;

    new-instance v5, Ljava/net/InetSocketAddress;

    iget-object v6, p0, Lcom/umeng/commonsdk/stateless/e;->a:Ljava/lang/String;

    iget v7, p0, Lcom/umeng/commonsdk/stateless/e;->b:I

    invoke-direct {v5, v6, v7}, Ljava/net/InetSocketAddress;-><init>(Ljava/lang/String;I)V

    invoke-direct {v0, v3, v5}, Ljava/net/Proxy;-><init>(Ljava/net/Proxy$Type;Ljava/net/SocketAddress;)V

    .line 169
    new-instance v3, Ljava/net/URL;

    new-instance v5, Ljava/lang/StringBuilder;

    invoke-direct {v5}, Ljava/lang/StringBuilder;-><init>()V

    const-string v6, "https://plbslog.umeng.com/"

    invoke-virtual {v5, v6}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v5

    invoke-virtual {v5, p2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v5

    invoke-virtual {v5}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v5

    invoke-direct {v3, v5}, Ljava/net/URL;-><init>(Ljava/lang/String;)V

    invoke-virtual {v3, v0}, Ljava/net/URL;->openConnection(Ljava/net/Proxy;)Ljava/net/URLConnection;

    move-result-object v0

    check-cast v0, Ljava/net/HttpURLConnection;
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_0
    .catchall {:try_start_0 .. :try_end_0} :catchall_0

    move-object v3, v0

    .line 175
    :goto_1
    :try_start_1
    const-string v0, "X-Umeng-UTC"

    invoke-static {}, Ljava/lang/System;->currentTimeMillis()J

    move-result-wide v6

    invoke-static {v6, v7}, Ljava/lang/String;->valueOf(J)Ljava/lang/String;

    move-result-object v5

    invoke-virtual {v3, v0, v5}, Ljava/net/HttpURLConnection;->setRequestProperty(Ljava/lang/String;Ljava/lang/String;)V

    .line 176
    const-string v0, "Msg-Type"

    const-string v5, "envelope/json"

    invoke-virtual {v3, v0, v5}, Ljava/net/HttpURLConnection;->setRequestProperty(Ljava/lang/String;Ljava/lang/String;)V

    .line 178
    const/16 v0, 0x7530

    invoke-virtual {v3, v0}, Ljava/net/HttpURLConnection;->setConnectTimeout(I)V

    .line 179
    const/16 v0, 0x7530

    invoke-virtual {v3, v0}, Ljava/net/HttpURLConnection;->setReadTimeout(I)V

    .line 180
    const-string v0, "POST"

    invoke-virtual {v3, v0}, Ljava/net/HttpURLConnection;->setRequestMethod(Ljava/lang/String;)V

    .line 182
    const/4 v0, 0x1

    invoke-virtual {v3, v0}, Ljava/net/HttpURLConnection;->setDoOutput(Z)V

    .line 183
    const/4 v0, 0x1

    invoke-virtual {v3, v0}, Ljava/net/HttpURLConnection;->setDoInput(Z)V

    .line 184
    const/4 v0, 0x0

    invoke-virtual {v3, v0}, Ljava/net/HttpURLConnection;->setUseCaches(Z)V

    .line 187
    invoke-virtual {v3}, Ljava/net/HttpURLConnection;->getOutputStream()Ljava/io/OutputStream;

    move-result-object v2

    .line 188
    invoke-virtual {v2, p1}, Ljava/io/OutputStream;->write([B)V

    .line 189
    invoke-virtual {v2}, Ljava/io/OutputStream;->flush()V

    .line 191
    invoke-virtual {v3}, Ljava/net/HttpURLConnection;->connect()V

    .line 193
    invoke-virtual {v3}, Ljava/net/HttpURLConnection;->getResponseCode()I
    :try_end_1
    .catch Ljava/lang/Throwable; {:try_start_1 .. :try_end_1} :catch_4
    .catchall {:try_start_1 .. :try_end_1} :catchall_1

    move-result v0

    .line 195
    const/16 v5, 0xc8

    if-ne v0, v5, :cond_9

    move v0, v4

    .line 202
    :goto_2
    if-eqz v2, :cond_3

    .line 204
    :try_start_2
    invoke-virtual {v2}, Ljava/io/OutputStream;->close()V
    :try_end_2
    .catch Ljava/lang/Exception; {:try_start_2 .. :try_end_2} :catch_1

    .line 208
    :cond_3
    :goto_3
    if-eqz v3, :cond_1

    .line 209
    invoke-virtual {v3}, Ljava/net/HttpURLConnection;->disconnect()V

    goto/16 :goto_0

    .line 171
    :cond_4
    :try_start_3
    new-instance v0, Ljava/net/URL;

    new-instance v3, Ljava/lang/StringBuilder;

    invoke-direct {v3}, Ljava/lang/StringBuilder;-><init>()V

    const-string v5, "https://plbslog.umeng.com/"

    invoke-virtual {v3, v5}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v3

    invoke-virtual {v3, p2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v3

    invoke-virtual {v3}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v3

    invoke-direct {v0, v3}, Ljava/net/URL;-><init>(Ljava/lang/String;)V

    invoke-virtual {v0}, Ljava/net/URL;->openConnection()Ljava/net/URLConnection;

    move-result-object v0

    check-cast v0, Ljava/net/HttpURLConnection;
    :try_end_3
    .catch Ljava/lang/Throwable; {:try_start_3 .. :try_end_3} :catch_0
    .catchall {:try_start_3 .. :try_end_3} :catchall_0

    move-object v3, v0

    goto :goto_1

    .line 199
    :catch_0
    move-exception v0

    move-object v3, v2

    .line 200
    :goto_4
    :try_start_4
    iget-object v4, p0, Lcom/umeng/commonsdk/stateless/e;->c:Landroid/content/Context;

    invoke-static {v4, v0}, Lcom/umeng/commonsdk/proguard/e;->a(Landroid/content/Context;Ljava/lang/Throwable;)V
    :try_end_4
    .catchall {:try_start_4 .. :try_end_4} :catchall_1

    .line 202
    if-eqz v2, :cond_5

    .line 204
    :try_start_5
    invoke-virtual {v2}, Ljava/io/OutputStream;->close()V
    :try_end_5
    .catch Ljava/lang/Exception; {:try_start_5 .. :try_end_5} :catch_2

    .line 208
    :cond_5
    :goto_5
    if-eqz v3, :cond_8

    .line 209
    invoke-virtual {v3}, Ljava/net/HttpURLConnection;->disconnect()V

    move v0, v1

    goto/16 :goto_0

    .line 202
    :catchall_0
    move-exception v0

    move-object v3, v2

    :goto_6
    if-eqz v2, :cond_6

    .line 204
    :try_start_6
    invoke-virtual {v2}, Ljava/io/OutputStream;->close()V
    :try_end_6
    .catch Ljava/lang/Exception; {:try_start_6 .. :try_end_6} :catch_3

    .line 208
    :cond_6
    :goto_7
    if-eqz v3, :cond_7

    .line 209
    invoke-virtual {v3}, Ljava/net/HttpURLConnection;->disconnect()V

    :cond_7
    throw v0

    .line 205
    :catch_1
    move-exception v1

    goto :goto_3

    :catch_2
    move-exception v0

    goto :goto_5

    :catch_3
    move-exception v1

    goto :goto_7

    .line 202
    :catchall_1
    move-exception v0

    goto :goto_6

    .line 199
    :catch_4
    move-exception v0

    goto :goto_4

    :cond_8
    move v0, v1

    goto/16 :goto_0

    :cond_9
    move v0, v1

    goto :goto_2
.end method
