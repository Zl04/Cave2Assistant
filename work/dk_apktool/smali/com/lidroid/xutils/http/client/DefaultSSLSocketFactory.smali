.class public Lcom/lidroid/xutils/http/client/DefaultSSLSocketFactory;
.super Lorg/apache/http/conn/ssl/SSLSocketFactory;
.source "SourceFile"


# static fields
.field private static instance:Lcom/lidroid/xutils/http/client/DefaultSSLSocketFactory;

.field private static trustStore:Ljava/security/KeyStore;


# instance fields
.field private sslContext:Ljavax/net/ssl/SSLContext;


# direct methods
.method static constructor <clinit>()V
    .locals 3

    .prologue
    .line 24
    :try_start_0
    invoke-static {}, Ljava/security/KeyStore;->getDefaultType()Ljava/lang/String;

    move-result-object v0

    invoke-static {v0}, Ljava/security/KeyStore;->getInstance(Ljava/lang/String;)Ljava/security/KeyStore;

    move-result-object v0

    sput-object v0, Lcom/lidroid/xutils/http/client/DefaultSSLSocketFactory;->trustStore:Ljava/security/KeyStore;

    .line 25
    sget-object v0, Lcom/lidroid/xutils/http/client/DefaultSSLSocketFactory;->trustStore:Ljava/security/KeyStore;

    const/4 v1, 0x0

    const/4 v2, 0x0

    invoke-virtual {v0, v1, v2}, Ljava/security/KeyStore;->load(Ljava/io/InputStream;[C)V
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_0

    .line 31
    :goto_0
    return-void

    .line 26
    :catch_0
    move-exception v0

    .line 27
    invoke-virtual {v0}, Ljava/lang/Throwable;->getMessage()Ljava/lang/String;

    move-result-object v1

    invoke-static {v1, v0}, Lcom/lidroid/xutils/util/LogUtils;->e(Ljava/lang/String;Ljava/lang/Throwable;)V

    goto :goto_0
.end method

.method private constructor <init>()V
    .locals 5
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljava/security/UnrecoverableKeyException;,
            Ljava/security/NoSuchAlgorithmException;,
            Ljava/security/KeyStoreException;,
            Ljava/security/KeyManagementException;
        }
    .end annotation

    .prologue
    const/4 v4, 0x0

    .line 49
    sget-object v0, Lcom/lidroid/xutils/http/client/DefaultSSLSocketFactory;->trustStore:Ljava/security/KeyStore;

    invoke-direct {p0, v0}, Lorg/apache/http/conn/ssl/SSLSocketFactory;-><init>(Ljava/security/KeyStore;)V

    .line 18
    const-string v0, "TLS"

    invoke-static {v0}, Ljavax/net/ssl/SSLContext;->getInstance(Ljava/lang/String;)Ljavax/net/ssl/SSLContext;

    move-result-object v0

    iput-object v0, p0, Lcom/lidroid/xutils/http/client/DefaultSSLSocketFactory;->sslContext:Ljavax/net/ssl/SSLContext;

    .line 51
    new-instance v0, Lcom/lidroid/xutils/http/client/DefaultSSLSocketFactory$1;

    invoke-direct {v0, p0}, Lcom/lidroid/xutils/http/client/DefaultSSLSocketFactory$1;-><init>(Lcom/lidroid/xutils/http/client/DefaultSSLSocketFactory;)V

    .line 68
    iget-object v1, p0, Lcom/lidroid/xutils/http/client/DefaultSSLSocketFactory;->sslContext:Ljavax/net/ssl/SSLContext;

    const/4 v2, 0x1

    new-array v2, v2, [Ljavax/net/ssl/TrustManager;

    const/4 v3, 0x0

    aput-object v0, v2, v3

    invoke-virtual {v1, v4, v2, v4}, Ljavax/net/ssl/SSLContext;->init([Ljavax/net/ssl/KeyManager;[Ljavax/net/ssl/TrustManager;Ljava/security/SecureRandom;)V

    .line 70
    sget-object v0, Lorg/apache/http/conn/ssl/SSLSocketFactory;->ALLOW_ALL_HOSTNAME_VERIFIER:Lorg/apache/http/conn/ssl/X509HostnameVerifier;

    invoke-virtual {p0, v0}, Lcom/lidroid/xutils/http/client/DefaultSSLSocketFactory;->setHostnameVerifier(Lorg/apache/http/conn/ssl/X509HostnameVerifier;)V

    .line 71
    return-void
.end method

.method public static getSocketFactory()Lcom/lidroid/xutils/http/client/DefaultSSLSocketFactory;
    .locals 2

    .prologue
    .line 34
    sget-object v0, Lcom/lidroid/xutils/http/client/DefaultSSLSocketFactory;->instance:Lcom/lidroid/xutils/http/client/DefaultSSLSocketFactory;

    if-nez v0, :cond_0

    .line 36
    :try_start_0
    new-instance v0, Lcom/lidroid/xutils/http/client/DefaultSSLSocketFactory;

    invoke-direct {v0}, Lcom/lidroid/xutils/http/client/DefaultSSLSocketFactory;-><init>()V

    sput-object v0, Lcom/lidroid/xutils/http/client/DefaultSSLSocketFactory;->instance:Lcom/lidroid/xutils/http/client/DefaultSSLSocketFactory;
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_0

    .line 41
    :cond_0
    :goto_0
    sget-object v0, Lcom/lidroid/xutils/http/client/DefaultSSLSocketFactory;->instance:Lcom/lidroid/xutils/http/client/DefaultSSLSocketFactory;

    return-object v0

    .line 37
    :catch_0
    move-exception v0

    .line 38
    invoke-virtual {v0}, Ljava/lang/Throwable;->getMessage()Ljava/lang/String;

    move-result-object v1

    invoke-static {v1, v0}, Lcom/lidroid/xutils/util/LogUtils;->e(Ljava/lang/String;Ljava/lang/Throwable;)V

    goto :goto_0
.end method

.method public static bridge synthetic getSocketFactory()Lorg/apache/http/conn/ssl/SSLSocketFactory;
    .locals 1

    .prologue
    .line 1
    invoke-static {}, Lcom/lidroid/xutils/http/client/DefaultSSLSocketFactory;->getSocketFactory()Lcom/lidroid/xutils/http/client/DefaultSSLSocketFactory;

    move-result-object v0

    return-object v0
.end method


# virtual methods
.method public createSocket()Ljava/net/Socket;
    .locals 1
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljava/io/IOException;
        }
    .end annotation

    .prologue
    .line 80
    iget-object v0, p0, Lcom/lidroid/xutils/http/client/DefaultSSLSocketFactory;->sslContext:Ljavax/net/ssl/SSLContext;

    invoke-virtual {v0}, Ljavax/net/ssl/SSLContext;->getSocketFactory()Ljavax/net/ssl/SSLSocketFactory;

    move-result-object v0

    invoke-virtual {v0}, Ljavax/net/ssl/SSLSocketFactory;->createSocket()Ljava/net/Socket;

    move-result-object v0

    return-object v0
.end method

.method public createSocket(Ljava/net/Socket;Ljava/lang/String;IZ)Ljava/net/Socket;
    .locals 1
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljava/io/IOException;
        }
    .end annotation

    .prologue
    .line 75
    iget-object v0, p0, Lcom/lidroid/xutils/http/client/DefaultSSLSocketFactory;->sslContext:Ljavax/net/ssl/SSLContext;

    invoke-virtual {v0}, Ljavax/net/ssl/SSLContext;->getSocketFactory()Ljavax/net/ssl/SSLSocketFactory;

    move-result-object v0

    invoke-virtual {v0, p1, p2, p3, p4}, Ljavax/net/ssl/SSLSocketFactory;->createSocket(Ljava/net/Socket;Ljava/lang/String;IZ)Ljava/net/Socket;

    move-result-object v0

    return-object v0
.end method
