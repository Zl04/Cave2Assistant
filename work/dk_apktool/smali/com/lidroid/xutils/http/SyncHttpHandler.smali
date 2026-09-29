.class public Lcom/lidroid/xutils/http/SyncHttpHandler;
.super Ljava/lang/Object;
.source "SourceFile"


# instance fields
.field private charset:Ljava/lang/String;

.field private final client:Lorg/apache/http/impl/client/AbstractHttpClient;

.field private final context:Lorg/apache/http/protocol/HttpContext;

.field private expiry:J

.field private httpRedirectHandler:Lcom/lidroid/xutils/http/callback/HttpRedirectHandler;

.field private requestMethod:Ljava/lang/String;

.field private requestUrl:Ljava/lang/String;

.field private retriedTimes:I


# direct methods
.method public constructor <init>(Lorg/apache/http/impl/client/AbstractHttpClient;Lorg/apache/http/protocol/HttpContext;Ljava/lang/String;)V
    .locals 2

    .prologue
    .line 49
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    .line 47
    const/4 v0, 0x0

    iput v0, p0, Lcom/lidroid/xutils/http/SyncHttpHandler;->retriedTimes:I

    .line 56
    invoke-static {}, Lcom/lidroid/xutils/http/HttpCache;->getDefaultExpiryTime()J

    move-result-wide v0

    iput-wide v0, p0, Lcom/lidroid/xutils/http/SyncHttpHandler;->expiry:J

    .line 50
    iput-object p1, p0, Lcom/lidroid/xutils/http/SyncHttpHandler;->client:Lorg/apache/http/impl/client/AbstractHttpClient;

    .line 51
    iput-object p2, p0, Lcom/lidroid/xutils/http/SyncHttpHandler;->context:Lorg/apache/http/protocol/HttpContext;

    .line 52
    iput-object p3, p0, Lcom/lidroid/xutils/http/SyncHttpHandler;->charset:Ljava/lang/String;

    .line 53
    return-void
.end method

.method private handleResponse(Lorg/apache/http/HttpResponse;)Lcom/lidroid/xutils/http/ResponseStream;
    .locals 6
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Lcom/lidroid/xutils/exception/HttpException;,
            Ljava/io/IOException;
        }
    .end annotation

    .prologue
    .line 104
    if-nez p1, :cond_0

    .line 105
    new-instance v0, Lcom/lidroid/xutils/exception/HttpException;

    const-string v1, "response is null"

    invoke-direct {v0, v1}, Lcom/lidroid/xutils/exception/HttpException;-><init>(Ljava/lang/String;)V

    throw v0

    .line 107
    :cond_0
    invoke-interface {p1}, Lorg/apache/http/HttpResponse;->getStatusLine()Lorg/apache/http/StatusLine;

    move-result-object v0

    .line 108
    invoke-interface {v0}, Lorg/apache/http/StatusLine;->getStatusCode()I

    move-result v1

    .line 109
    const/16 v2, 0x12c

    if-ge v1, v2, :cond_1

    .line 110
    new-instance v0, Lcom/lidroid/xutils/http/ResponseStream;

    iget-object v2, p0, Lcom/lidroid/xutils/http/SyncHttpHandler;->charset:Ljava/lang/String;

    iget-object v3, p0, Lcom/lidroid/xutils/http/SyncHttpHandler;->requestUrl:Ljava/lang/String;

    iget-wide v4, p0, Lcom/lidroid/xutils/http/SyncHttpHandler;->expiry:J

    move-object v1, p1

    invoke-direct/range {v0 .. v5}, Lcom/lidroid/xutils/http/ResponseStream;-><init>(Lorg/apache/http/HttpResponse;Ljava/lang/String;Ljava/lang/String;J)V

    .line 111
    iget-object v1, p0, Lcom/lidroid/xutils/http/SyncHttpHandler;->requestMethod:Ljava/lang/String;

    invoke-virtual {v0, v1}, Lcom/lidroid/xutils/http/ResponseStream;->setRequestMethod(Ljava/lang/String;)V

    .line 126
    :goto_0
    return-object v0

    .line 113
    :cond_1
    const/16 v2, 0x12d

    if-eq v1, v2, :cond_2

    const/16 v2, 0x12e

    if-ne v1, v2, :cond_4

    .line 114
    :cond_2
    iget-object v0, p0, Lcom/lidroid/xutils/http/SyncHttpHandler;->httpRedirectHandler:Lcom/lidroid/xutils/http/callback/HttpRedirectHandler;

    if-nez v0, :cond_3

    .line 115
    new-instance v0, Lcom/lidroid/xutils/http/callback/DefaultHttpRedirectHandler;

    invoke-direct {v0}, Lcom/lidroid/xutils/http/callback/DefaultHttpRedirectHandler;-><init>()V

    iput-object v0, p0, Lcom/lidroid/xutils/http/SyncHttpHandler;->httpRedirectHandler:Lcom/lidroid/xutils/http/callback/HttpRedirectHandler;

    .line 117
    :cond_3
    iget-object v0, p0, Lcom/lidroid/xutils/http/SyncHttpHandler;->httpRedirectHandler:Lcom/lidroid/xutils/http/callback/HttpRedirectHandler;

    invoke-interface {v0, p1}, Lcom/lidroid/xutils/http/callback/HttpRedirectHandler;->getDirectRequest(Lorg/apache/http/HttpResponse;)Lorg/apache/http/client/methods/HttpRequestBase;

    move-result-object v0

    .line 118
    if-eqz v0, :cond_6

    .line 119
    invoke-virtual {p0, v0}, Lcom/lidroid/xutils/http/SyncHttpHandler;->sendRequest(Lorg/apache/http/client/methods/HttpRequestBase;)Lcom/lidroid/xutils/http/ResponseStream;

    move-result-object v0

    goto :goto_0

    .line 121
    :cond_4
    const/16 v2, 0x1a0

    if-ne v1, v2, :cond_5

    .line 122
    new-instance v0, Lcom/lidroid/xutils/exception/HttpException;

    const-string v2, "maybe the file has downloaded completely"

    invoke-direct {v0, v1, v2}, Lcom/lidroid/xutils/exception/HttpException;-><init>(ILjava/lang/String;)V

    throw v0

    .line 124
    :cond_5
    new-instance v2, Lcom/lidroid/xutils/exception/HttpException;

    invoke-interface {v0}, Lorg/apache/http/StatusLine;->getReasonPhrase()Ljava/lang/String;

    move-result-object v0

    invoke-direct {v2, v1, v0}, Lcom/lidroid/xutils/exception/HttpException;-><init>(ILjava/lang/String;)V

    throw v2

    .line 126
    :cond_6
    const/4 v0, 0x0

    goto :goto_0
.end method


# virtual methods
.method public sendRequest(Lorg/apache/http/client/methods/HttpRequestBase;)Lcom/lidroid/xutils/http/ResponseStream;
    .locals 5
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Lcom/lidroid/xutils/exception/HttpException;
        }
    .end annotation

    .prologue
    .line 64
    iget-object v0, p0, Lcom/lidroid/xutils/http/SyncHttpHandler;->client:Lorg/apache/http/impl/client/AbstractHttpClient;

    invoke-virtual {v0}, Lorg/apache/http/impl/client/AbstractHttpClient;->getHttpRequestRetryHandler()Lorg/apache/http/client/HttpRequestRetryHandler;

    move-result-object v2

    .line 69
    :cond_0
    :try_start_0
    invoke-virtual {p1}, Lorg/apache/http/client/methods/HttpRequestBase;->getURI()Ljava/net/URI;

    move-result-object v0

    invoke-virtual {v0}, Ljava/net/URI;->toString()Ljava/lang/String;

    move-result-object v0

    iput-object v0, p0, Lcom/lidroid/xutils/http/SyncHttpHandler;->requestUrl:Ljava/lang/String;

    .line 70
    invoke-virtual {p1}, Lorg/apache/http/client/methods/HttpRequestBase;->getMethod()Ljava/lang/String;

    move-result-object v0

    iput-object v0, p0, Lcom/lidroid/xutils/http/SyncHttpHandler;->requestMethod:Ljava/lang/String;

    .line 71
    sget-object v0, Lcom/lidroid/xutils/HttpUtils;->sHttpCache:Lcom/lidroid/xutils/http/HttpCache;

    iget-object v1, p0, Lcom/lidroid/xutils/http/SyncHttpHandler;->requestMethod:Ljava/lang/String;

    invoke-virtual {v0, v1}, Lcom/lidroid/xutils/http/HttpCache;->isEnabled(Ljava/lang/String;)Z

    move-result v0

    if-eqz v0, :cond_1

    .line 72
    sget-object v0, Lcom/lidroid/xutils/HttpUtils;->sHttpCache:Lcom/lidroid/xutils/http/HttpCache;

    iget-object v1, p0, Lcom/lidroid/xutils/http/SyncHttpHandler;->requestUrl:Ljava/lang/String;

    invoke-virtual {v0, v1}, Lcom/lidroid/xutils/http/HttpCache;->get(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v1

    .line 73
    if-eqz v1, :cond_1

    .line 74
    new-instance v0, Lcom/lidroid/xutils/http/ResponseStream;

    invoke-direct {v0, v1}, Lcom/lidroid/xutils/http/ResponseStream;-><init>(Ljava/lang/String;)V

    .line 79
    :goto_0
    return-object v0

    .line 78
    :cond_1
    iget-object v0, p0, Lcom/lidroid/xutils/http/SyncHttpHandler;->client:Lorg/apache/http/impl/client/AbstractHttpClient;

    iget-object v1, p0, Lcom/lidroid/xutils/http/SyncHttpHandler;->context:Lorg/apache/http/protocol/HttpContext;

    invoke-virtual {v0, p1, v1}, Lorg/apache/http/impl/client/AbstractHttpClient;->execute(Lorg/apache/http/client/methods/HttpUriRequest;Lorg/apache/http/protocol/HttpContext;)Lorg/apache/http/HttpResponse;

    move-result-object v0

    .line 79
    invoke-direct {p0, v0}, Lcom/lidroid/xutils/http/SyncHttpHandler;->handleResponse(Lorg/apache/http/HttpResponse;)Lcom/lidroid/xutils/http/ResponseStream;
    :try_end_0
    .catch Ljava/net/UnknownHostException; {:try_start_0 .. :try_end_0} :catch_0
    .catch Ljava/io/IOException; {:try_start_0 .. :try_end_0} :catch_1
    .catch Ljava/lang/NullPointerException; {:try_start_0 .. :try_end_0} :catch_2
    .catch Lcom/lidroid/xutils/exception/HttpException; {:try_start_0 .. :try_end_0} :catch_3
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_4

    move-result-object v0

    goto :goto_0

    .line 80
    :catch_0
    move-exception v0

    .line 82
    iget v1, p0, Lcom/lidroid/xutils/http/SyncHttpHandler;->retriedTimes:I

    add-int/lit8 v1, v1, 0x1

    iput v1, p0, Lcom/lidroid/xutils/http/SyncHttpHandler;->retriedTimes:I

    iget-object v3, p0, Lcom/lidroid/xutils/http/SyncHttpHandler;->context:Lorg/apache/http/protocol/HttpContext;

    invoke-interface {v2, v0, v1, v3}, Lorg/apache/http/client/HttpRequestRetryHandler;->retryRequest(Ljava/io/IOException;ILorg/apache/http/protocol/HttpContext;)Z

    move-result v1

    .line 97
    :goto_1
    if-nez v1, :cond_0

    .line 98
    new-instance v1, Lcom/lidroid/xutils/exception/HttpException;

    invoke-direct {v1, v0}, Lcom/lidroid/xutils/exception/HttpException;-><init>(Ljava/lang/Throwable;)V

    throw v1

    .line 83
    :catch_1
    move-exception v0

    .line 85
    iget v1, p0, Lcom/lidroid/xutils/http/SyncHttpHandler;->retriedTimes:I

    add-int/lit8 v1, v1, 0x1

    iput v1, p0, Lcom/lidroid/xutils/http/SyncHttpHandler;->retriedTimes:I

    iget-object v3, p0, Lcom/lidroid/xutils/http/SyncHttpHandler;->context:Lorg/apache/http/protocol/HttpContext;

    invoke-interface {v2, v0, v1, v3}, Lorg/apache/http/client/HttpRequestRetryHandler;->retryRequest(Ljava/io/IOException;ILorg/apache/http/protocol/HttpContext;)Z

    move-result v1

    goto :goto_1

    .line 86
    :catch_2
    move-exception v0

    .line 87
    new-instance v1, Ljava/io/IOException;

    invoke-virtual {v0}, Ljava/lang/NullPointerException;->getMessage()Ljava/lang/String;

    move-result-object v3

    invoke-direct {v1, v3}, Ljava/io/IOException;-><init>(Ljava/lang/String;)V

    .line 88
    invoke-virtual {v1, v0}, Ljava/io/IOException;->initCause(Ljava/lang/Throwable;)Ljava/lang/Throwable;

    .line 89
    iget v0, p0, Lcom/lidroid/xutils/http/SyncHttpHandler;->retriedTimes:I

    add-int/lit8 v0, v0, 0x1

    iput v0, p0, Lcom/lidroid/xutils/http/SyncHttpHandler;->retriedTimes:I

    iget-object v3, p0, Lcom/lidroid/xutils/http/SyncHttpHandler;->context:Lorg/apache/http/protocol/HttpContext;

    invoke-interface {v2, v1, v0, v3}, Lorg/apache/http/client/HttpRequestRetryHandler;->retryRequest(Ljava/io/IOException;ILorg/apache/http/protocol/HttpContext;)Z

    move-result v0

    move-object v4, v1

    move v1, v0

    move-object v0, v4

    goto :goto_1

    .line 90
    :catch_3
    move-exception v0

    .line 91
    throw v0

    .line 92
    :catch_4
    move-exception v0

    .line 93
    new-instance v1, Ljava/io/IOException;

    invoke-virtual {v0}, Ljava/lang/Throwable;->getMessage()Ljava/lang/String;

    move-result-object v3

    invoke-direct {v1, v3}, Ljava/io/IOException;-><init>(Ljava/lang/String;)V

    .line 94
    invoke-virtual {v1, v0}, Ljava/io/IOException;->initCause(Ljava/lang/Throwable;)Ljava/lang/Throwable;

    .line 95
    iget v0, p0, Lcom/lidroid/xutils/http/SyncHttpHandler;->retriedTimes:I

    add-int/lit8 v0, v0, 0x1

    iput v0, p0, Lcom/lidroid/xutils/http/SyncHttpHandler;->retriedTimes:I

    iget-object v3, p0, Lcom/lidroid/xutils/http/SyncHttpHandler;->context:Lorg/apache/http/protocol/HttpContext;

    invoke-interface {v2, v1, v0, v3}, Lorg/apache/http/client/HttpRequestRetryHandler;->retryRequest(Ljava/io/IOException;ILorg/apache/http/protocol/HttpContext;)Z

    move-result v0

    move-object v4, v1

    move v1, v0

    move-object v0, v4

    goto :goto_1
.end method

.method public setExpiry(J)V
    .locals 1

    .prologue
    .line 59
    iput-wide p1, p0, Lcom/lidroid/xutils/http/SyncHttpHandler;->expiry:J

    .line 60
    return-void
.end method

.method public setHttpRedirectHandler(Lcom/lidroid/xutils/http/callback/HttpRedirectHandler;)V
    .locals 0

    .prologue
    .line 40
    iput-object p1, p0, Lcom/lidroid/xutils/http/SyncHttpHandler;->httpRedirectHandler:Lcom/lidroid/xutils/http/callback/HttpRedirectHandler;

    .line 41
    return-void
.end method
