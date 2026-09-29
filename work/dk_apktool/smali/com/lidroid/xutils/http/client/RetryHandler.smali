.class public Lcom/lidroid/xutils/http/client/RetryHandler;
.super Ljava/lang/Object;
.source "SourceFile"

# interfaces
.implements Lorg/apache/http/client/HttpRequestRetryHandler;


# static fields
.field private static final RETRY_SLEEP_INTERVAL:I = 0x1f4

.field private static exceptionBlackList:Ljava/util/HashSet;
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "Ljava/util/HashSet",
            "<",
            "Ljava/lang/Class",
            "<*>;>;"
        }
    .end annotation
.end field

.field private static exceptionWhiteList:Ljava/util/HashSet;
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "Ljava/util/HashSet",
            "<",
            "Ljava/lang/Class",
            "<*>;>;"
        }
    .end annotation
.end field


# instance fields
.field private final maxRetries:I


# direct methods
.method static constructor <clinit>()V
    .locals 2

    .prologue
    .line 38
    new-instance v0, Ljava/util/HashSet;

    invoke-direct {v0}, Ljava/util/HashSet;-><init>()V

    sput-object v0, Lcom/lidroid/xutils/http/client/RetryHandler;->exceptionWhiteList:Ljava/util/HashSet;

    .line 40
    new-instance v0, Ljava/util/HashSet;

    invoke-direct {v0}, Ljava/util/HashSet;-><init>()V

    sput-object v0, Lcom/lidroid/xutils/http/client/RetryHandler;->exceptionBlackList:Ljava/util/HashSet;

    .line 43
    sget-object v0, Lcom/lidroid/xutils/http/client/RetryHandler;->exceptionWhiteList:Ljava/util/HashSet;

    const-class v1, Lorg/apache/http/NoHttpResponseException;

    invoke-virtual {v0, v1}, Ljava/util/HashSet;->add(Ljava/lang/Object;)Z

    .line 44
    sget-object v0, Lcom/lidroid/xutils/http/client/RetryHandler;->exceptionWhiteList:Ljava/util/HashSet;

    const-class v1, Ljava/net/UnknownHostException;

    invoke-virtual {v0, v1}, Ljava/util/HashSet;->add(Ljava/lang/Object;)Z

    .line 45
    sget-object v0, Lcom/lidroid/xutils/http/client/RetryHandler;->exceptionWhiteList:Ljava/util/HashSet;

    const-class v1, Ljava/net/SocketException;

    invoke-virtual {v0, v1}, Ljava/util/HashSet;->add(Ljava/lang/Object;)Z

    .line 47
    sget-object v0, Lcom/lidroid/xutils/http/client/RetryHandler;->exceptionBlackList:Ljava/util/HashSet;

    const-class v1, Ljava/io/InterruptedIOException;

    invoke-virtual {v0, v1}, Ljava/util/HashSet;->add(Ljava/lang/Object;)Z

    .line 48
    sget-object v0, Lcom/lidroid/xutils/http/client/RetryHandler;->exceptionBlackList:Ljava/util/HashSet;

    const-class v1, Ljavax/net/ssl/SSLHandshakeException;

    invoke-virtual {v0, v1}, Ljava/util/HashSet;->add(Ljava/lang/Object;)Z

    .line 49
    return-void
.end method

.method public constructor <init>(I)V
    .locals 0

    .prologue
    .line 53
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    .line 54
    iput p1, p0, Lcom/lidroid/xutils/http/client/RetryHandler;->maxRetries:I

    .line 55
    return-void
.end method


# virtual methods
.method public retryRequest(Ljava/io/IOException;ILorg/apache/http/protocol/HttpContext;)Z
    .locals 5

    .prologue
    const/4 v2, 0x1

    const/4 v1, 0x0

    .line 59
    .line 61
    if-eqz p1, :cond_0

    if-nez p3, :cond_1

    .line 103
    :cond_0
    :goto_0
    return v1

    .line 65
    :cond_1
    const-string v0, "http.request_sent"

    invoke-interface {p3, v0}, Lorg/apache/http/protocol/HttpContext;->getAttribute(Ljava/lang/String;)Ljava/lang/Object;

    move-result-object v0

    .line 66
    if-nez v0, :cond_3

    move v0, v1

    .line 68
    :goto_1
    iget v3, p0, Lcom/lidroid/xutils/http/client/RetryHandler;->maxRetries:I

    if-le p2, v3, :cond_4

    move v2, v1

    .line 78
    :cond_2
    :goto_2
    if-eqz v2, :cond_8

    .line 80
    :try_start_0
    const-string v0, "http.request"

    invoke-interface {p3, v0}, Lorg/apache/http/protocol/HttpContext;->getAttribute(Ljava/lang/String;)Ljava/lang/Object;

    move-result-object v0

    .line 81
    if-eqz v0, :cond_7

    .line 82
    instance-of v3, v0, Lorg/apache/http/client/methods/HttpRequestBase;

    if-eqz v3, :cond_6

    .line 83
    check-cast v0, Lorg/apache/http/client/methods/HttpRequestBase;

    .line 84
    const-string v2, "GET"

    invoke-virtual {v0}, Lorg/apache/http/client/methods/HttpRequestBase;->getMethod()Ljava/lang/String;

    move-result-object v0

    invoke-virtual {v2, v0}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_0

    move-result v1

    .line 99
    :goto_3
    if-eqz v1, :cond_0

    .line 100
    const-wide/16 v2, 0x1f4

    invoke-static {v2, v3}, Landroid/os/SystemClock;->sleep(J)V

    goto :goto_0

    .line 66
    :cond_3
    check-cast v0, Ljava/lang/Boolean;

    invoke-virtual {v0}, Ljava/lang/Boolean;->booleanValue()Z

    move-result v0

    goto :goto_1

    .line 70
    :cond_4
    sget-object v3, Lcom/lidroid/xutils/http/client/RetryHandler;->exceptionBlackList:Ljava/util/HashSet;

    invoke-virtual {p1}, Ljava/lang/Object;->getClass()Ljava/lang/Class;

    move-result-object v4

    invoke-virtual {v3, v4}, Ljava/util/HashSet;->contains(Ljava/lang/Object;)Z

    move-result v3

    if-eqz v3, :cond_5

    move v2, v1

    .line 72
    goto :goto_2

    :cond_5
    sget-object v3, Lcom/lidroid/xutils/http/client/RetryHandler;->exceptionWhiteList:Ljava/util/HashSet;

    invoke-virtual {p1}, Ljava/lang/Object;->getClass()Ljava/lang/Class;

    move-result-object v4

    invoke-virtual {v3, v4}, Ljava/util/HashSet;->contains(Ljava/lang/Object;)Z

    move-result v3

    if-nez v3, :cond_2

    .line 74
    if-nez v0, :cond_2

    goto :goto_2

    .line 85
    :cond_6
    :try_start_1
    instance-of v3, v0, Lorg/apache/http/impl/client/RequestWrapper;

    if-eqz v3, :cond_8

    .line 86
    check-cast v0, Lorg/apache/http/impl/client/RequestWrapper;

    .line 87
    const-string v2, "GET"

    invoke-virtual {v0}, Lorg/apache/http/impl/client/RequestWrapper;->getMethod()Ljava/lang/String;

    move-result-object v0

    invoke-virtual {v2, v0}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v1

    goto :goto_3

    .line 91
    :cond_7
    const-string v0, "retry error, curr request is null"

    invoke-static {v0}, Lcom/lidroid/xutils/util/LogUtils;->e(Ljava/lang/String;)V
    :try_end_1
    .catch Ljava/lang/Throwable; {:try_start_1 .. :try_end_1} :catch_0

    goto :goto_3

    .line 93
    :catch_0
    move-exception v0

    .line 95
    const-string v2, "retry error"

    invoke-static {v2, v0}, Lcom/lidroid/xutils/util/LogUtils;->e(Ljava/lang/String;Ljava/lang/Throwable;)V

    goto :goto_3

    :cond_8
    move v1, v2

    goto :goto_3
.end method
