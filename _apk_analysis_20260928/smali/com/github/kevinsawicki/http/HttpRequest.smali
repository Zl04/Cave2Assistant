.class public Lcom/github/kevinsawicki/http/HttpRequest;
.super Ljava/lang/Object;
.source "SourceFile"


# annotations
.annotation system Ldalvik/annotation/MemberClasses;
    value = {
        Lcom/github/kevinsawicki/http/HttpRequest$RequestOutputStream;,
        Lcom/github/kevinsawicki/http/HttpRequest$FlushOperation;,
        Lcom/github/kevinsawicki/http/HttpRequest$CloseOperation;,
        Lcom/github/kevinsawicki/http/HttpRequest$Operation;,
        Lcom/github/kevinsawicki/http/HttpRequest$HttpRequestException;,
        Lcom/github/kevinsawicki/http/HttpRequest$Base64;,
        Lcom/github/kevinsawicki/http/HttpRequest$UploadProgress;,
        Lcom/github/kevinsawicki/http/HttpRequest$ConnectionFactory;
    }
.end annotation


# static fields
.field private static final BOUNDARY:Ljava/lang/String; = "00content0boundary00"

.field public static final CHARSET_UTF8:Ljava/lang/String; = "UTF-8"

.field private static CONNECTION_FACTORY:Lcom/github/kevinsawicki/http/HttpRequest$ConnectionFactory; = null

.field public static final CONTENT_TYPE_FORM:Ljava/lang/String; = "application/x-www-form-urlencoded"

.field public static final CONTENT_TYPE_JSON:Ljava/lang/String; = "application/json"

.field private static final CONTENT_TYPE_MULTIPART:Ljava/lang/String; = "multipart/form-data; boundary=00content0boundary00"

.field private static final CRLF:Ljava/lang/String; = "\r\n"

.field private static final EMPTY_STRINGS:[Ljava/lang/String;

.field public static final ENCODING_GZIP:Ljava/lang/String; = "gzip"

.field public static final HEADER_ACCEPT:Ljava/lang/String; = "Accept"

.field public static final HEADER_ACCEPT_CHARSET:Ljava/lang/String; = "Accept-Charset"

.field public static final HEADER_ACCEPT_ENCODING:Ljava/lang/String; = "Accept-Encoding"

.field public static final HEADER_AUTHORIZATION:Ljava/lang/String; = "Authorization"

.field public static final HEADER_CACHE_CONTROL:Ljava/lang/String; = "Cache-Control"

.field public static final HEADER_CONTENT_ENCODING:Ljava/lang/String; = "Content-Encoding"

.field public static final HEADER_CONTENT_LENGTH:Ljava/lang/String; = "Content-Length"

.field public static final HEADER_CONTENT_TYPE:Ljava/lang/String; = "Content-Type"

.field public static final HEADER_DATE:Ljava/lang/String; = "Date"

.field public static final HEADER_ETAG:Ljava/lang/String; = "ETag"

.field public static final HEADER_EXPIRES:Ljava/lang/String; = "Expires"

.field public static final HEADER_IF_NONE_MATCH:Ljava/lang/String; = "If-None-Match"

.field public static final HEADER_LAST_MODIFIED:Ljava/lang/String; = "Last-Modified"

.field public static final HEADER_LOCATION:Ljava/lang/String; = "Location"

.field public static final HEADER_PROXY_AUTHORIZATION:Ljava/lang/String; = "Proxy-Authorization"

.field public static final HEADER_REFERER:Ljava/lang/String; = "Referer"

.field public static final HEADER_SERVER:Ljava/lang/String; = "Server"

.field public static final HEADER_USER_AGENT:Ljava/lang/String; = "User-Agent"

.field public static final METHOD_DELETE:Ljava/lang/String; = "DELETE"

.field public static final METHOD_GET:Ljava/lang/String; = "GET"

.field public static final METHOD_HEAD:Ljava/lang/String; = "HEAD"

.field public static final METHOD_OPTIONS:Ljava/lang/String; = "OPTIONS"

.field public static final METHOD_POST:Ljava/lang/String; = "POST"

.field public static final METHOD_PUT:Ljava/lang/String; = "PUT"

.field public static final METHOD_TRACE:Ljava/lang/String; = "TRACE"

.field public static final PARAM_CHARSET:Ljava/lang/String; = "charset"

.field private static TRUSTED_FACTORY:Ljavax/net/ssl/SSLSocketFactory;

.field private static TRUSTED_VERIFIER:Ljavax/net/ssl/HostnameVerifier;


# instance fields
.field private bufferSize:I

.field private connection:Ljava/net/HttpURLConnection;

.field private form:Z

.field private httpProxyHost:Ljava/lang/String;

.field private httpProxyPort:I

.field private ignoreCloseExceptions:Z

.field private multipart:Z

.field private output:Lcom/github/kevinsawicki/http/HttpRequest$RequestOutputStream;

.field private progress:Lcom/github/kevinsawicki/http/HttpRequest$UploadProgress;

.field private final requestMethod:Ljava/lang/String;

.field private totalSize:J

.field private totalWritten:J

.field private uncompress:Z

.field private final url:Ljava/net/URL;


# direct methods
.method static constructor <clinit>()V
    .locals 1

    .prologue
    .line 257
    const/4 v0, 0x0

    new-array v0, v0, [Ljava/lang/String;

    sput-object v0, Lcom/github/kevinsawicki/http/HttpRequest;->EMPTY_STRINGS:[Ljava/lang/String;

    .line 398
    sget-object v0, Lcom/github/kevinsawicki/http/HttpRequest$ConnectionFactory;->DEFAULT:Lcom/github/kevinsawicki/http/HttpRequest$ConnectionFactory;

    sput-object v0, Lcom/github/kevinsawicki/http/HttpRequest;->CONNECTION_FACTORY:Lcom/github/kevinsawicki/http/HttpRequest$ConnectionFactory;

    return-void
.end method

.method public constructor <init>(Ljava/lang/CharSequence;Ljava/lang/String;)V
    .locals 2
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Lcom/github/kevinsawicki/http/HttpRequest$HttpRequestException;
        }
    .end annotation

    .prologue
    .line 1471
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    .line 1435
    const/4 v0, 0x0

    iput-object v0, p0, Lcom/github/kevinsawicki/http/HttpRequest;->connection:Ljava/net/HttpURLConnection;

    .line 1447
    const/4 v0, 0x1

    iput-boolean v0, p0, Lcom/github/kevinsawicki/http/HttpRequest;->ignoreCloseExceptions:Z

    .line 1449
    const/4 v0, 0x0

    iput-boolean v0, p0, Lcom/github/kevinsawicki/http/HttpRequest;->uncompress:Z

    .line 1451
    const/16 v0, 0x2000

    iput v0, p0, Lcom/github/kevinsawicki/http/HttpRequest;->bufferSize:I

    .line 1453
    const-wide/16 v0, -0x1

    iput-wide v0, p0, Lcom/github/kevinsawicki/http/HttpRequest;->totalSize:J

    .line 1455
    const-wide/16 v0, 0x0

    iput-wide v0, p0, Lcom/github/kevinsawicki/http/HttpRequest;->totalWritten:J

    .line 1461
    sget-object v0, Lcom/github/kevinsawicki/http/HttpRequest$UploadProgress;->DEFAULT:Lcom/github/kevinsawicki/http/HttpRequest$UploadProgress;

    iput-object v0, p0, Lcom/github/kevinsawicki/http/HttpRequest;->progress:Lcom/github/kevinsawicki/http/HttpRequest$UploadProgress;

    .line 1473
    :try_start_0
    new-instance v0, Ljava/net/URL;

    invoke-interface {p1}, Ljava/lang/CharSequence;->toString()Ljava/lang/String;

    move-result-object v1

    invoke-direct {v0, v1}, Ljava/net/URL;-><init>(Ljava/lang/String;)V

    iput-object v0, p0, Lcom/github/kevinsawicki/http/HttpRequest;->url:Ljava/net/URL;
    :try_end_0
    .catch Ljava/net/MalformedURLException; {:try_start_0 .. :try_end_0} :catch_0

    .line 1477
    iput-object p2, p0, Lcom/github/kevinsawicki/http/HttpRequest;->requestMethod:Ljava/lang/String;

    .line 1478
    return-void

    .line 1474
    :catch_0
    move-exception v0

    .line 1475
    new-instance v1, Lcom/github/kevinsawicki/http/HttpRequest$HttpRequestException;

    invoke-direct {v1, v0}, Lcom/github/kevinsawicki/http/HttpRequest$HttpRequestException;-><init>(Ljava/io/IOException;)V

    throw v1
.end method

.method public constructor <init>(Ljava/net/URL;Ljava/lang/String;)V
    .locals 2
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Lcom/github/kevinsawicki/http/HttpRequest$HttpRequestException;
        }
    .end annotation

    .prologue
    .line 1488
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    .line 1435
    const/4 v0, 0x0

    iput-object v0, p0, Lcom/github/kevinsawicki/http/HttpRequest;->connection:Ljava/net/HttpURLConnection;

    .line 1447
    const/4 v0, 0x1

    iput-boolean v0, p0, Lcom/github/kevinsawicki/http/HttpRequest;->ignoreCloseExceptions:Z

    .line 1449
    const/4 v0, 0x0

    iput-boolean v0, p0, Lcom/github/kevinsawicki/http/HttpRequest;->uncompress:Z

    .line 1451
    const/16 v0, 0x2000

    iput v0, p0, Lcom/github/kevinsawicki/http/HttpRequest;->bufferSize:I

    .line 1453
    const-wide/16 v0, -0x1

    iput-wide v0, p0, Lcom/github/kevinsawicki/http/HttpRequest;->totalSize:J

    .line 1455
    const-wide/16 v0, 0x0

    iput-wide v0, p0, Lcom/github/kevinsawicki/http/HttpRequest;->totalWritten:J

    .line 1461
    sget-object v0, Lcom/github/kevinsawicki/http/HttpRequest$UploadProgress;->DEFAULT:Lcom/github/kevinsawicki/http/HttpRequest$UploadProgress;

    iput-object v0, p0, Lcom/github/kevinsawicki/http/HttpRequest;->progress:Lcom/github/kevinsawicki/http/HttpRequest$UploadProgress;

    .line 1489
    iput-object p1, p0, Lcom/github/kevinsawicki/http/HttpRequest;->url:Ljava/net/URL;

    .line 1490
    iput-object p2, p0, Lcom/github/kevinsawicki/http/HttpRequest;->requestMethod:Ljava/lang/String;

    .line 1491
    return-void
.end method

.method static synthetic access$000(Ljava/lang/String;)Ljava/lang/String;
    .locals 1

    .prologue
    .line 98
    invoke-static {p0}, Lcom/github/kevinsawicki/http/HttpRequest;->getValidCharset(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v0

    return-object v0
.end method

.method static synthetic access$100(Lcom/github/kevinsawicki/http/HttpRequest;)I
    .locals 1

    .prologue
    .line 98
    iget v0, p0, Lcom/github/kevinsawicki/http/HttpRequest;->bufferSize:I

    return v0
.end method

.method static synthetic access$200(Lcom/github/kevinsawicki/http/HttpRequest;)J
    .locals 2

    .prologue
    .line 98
    iget-wide v0, p0, Lcom/github/kevinsawicki/http/HttpRequest;->totalWritten:J

    return-wide v0
.end method

.method static synthetic access$202(Lcom/github/kevinsawicki/http/HttpRequest;J)J
    .locals 1

    .prologue
    .line 98
    iput-wide p1, p0, Lcom/github/kevinsawicki/http/HttpRequest;->totalWritten:J

    return-wide p1
.end method

.method static synthetic access$300(Lcom/github/kevinsawicki/http/HttpRequest;)J
    .locals 2

    .prologue
    .line 98
    iget-wide v0, p0, Lcom/github/kevinsawicki/http/HttpRequest;->totalSize:J

    return-wide v0
.end method

.method static synthetic access$400(Lcom/github/kevinsawicki/http/HttpRequest;)Lcom/github/kevinsawicki/http/HttpRequest$UploadProgress;
    .locals 1

    .prologue
    .line 98
    iget-object v0, p0, Lcom/github/kevinsawicki/http/HttpRequest;->progress:Lcom/github/kevinsawicki/http/HttpRequest$UploadProgress;

    return-object v0
.end method

.method private static addParam(Ljava/lang/Object;Ljava/lang/Object;Ljava/lang/StringBuilder;)Ljava/lang/StringBuilder;
    .locals 2

    .prologue
    .line 339
    if-eqz p1, :cond_4

    invoke-virtual {p1}, Ljava/lang/Object;->getClass()Ljava/lang/Class;

    move-result-object v0

    invoke-virtual {v0}, Ljava/lang/Class;->isArray()Z

    move-result v0

    if-eqz v0, :cond_4

    .line 340
    invoke-static {p1}, Lcom/github/kevinsawicki/http/HttpRequest;->arrayToList(Ljava/lang/Object;)Ljava/util/List;

    move-result-object p1

    move-object v0, p1

    .line 342
    :goto_0
    instance-of v1, v0, Ljava/lang/Iterable;

    if-eqz v1, :cond_2

    .line 343
    check-cast v0, Ljava/lang/Iterable;

    invoke-interface {v0}, Ljava/lang/Iterable;->iterator()Ljava/util/Iterator;

    move-result-object v0

    .line 344
    :cond_0
    :goto_1
    invoke-interface {v0}, Ljava/util/Iterator;->hasNext()Z

    move-result v1

    if-eqz v1, :cond_3

    .line 345
    invoke-virtual {p2, p0}, Ljava/lang/StringBuilder;->append(Ljava/lang/Object;)Ljava/lang/StringBuilder;

    .line 346
    const-string v1, "[]="

    invoke-virtual {p2, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    .line 347
    invoke-interface {v0}, Ljava/util/Iterator;->next()Ljava/lang/Object;

    move-result-object v1

    .line 348
    if-eqz v1, :cond_1

    .line 349
    invoke-virtual {p2, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/Object;)Ljava/lang/StringBuilder;

    .line 350
    :cond_1
    invoke-interface {v0}, Ljava/util/Iterator;->hasNext()Z

    move-result v1

    if-eqz v1, :cond_0

    .line 351
    const-string v1, "&"

    invoke-virtual {p2, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    goto :goto_1

    .line 354
    :cond_2
    invoke-virtual {p2, p0}, Ljava/lang/StringBuilder;->append(Ljava/lang/Object;)Ljava/lang/StringBuilder;

    .line 355
    const-string v1, "="

    invoke-virtual {p2, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    .line 356
    if-eqz v0, :cond_3

    .line 357
    invoke-virtual {p2, v0}, Ljava/lang/StringBuilder;->append(Ljava/lang/Object;)Ljava/lang/StringBuilder;

    .line 360
    :cond_3
    return-object p2

    :cond_4
    move-object v0, p1

    goto :goto_0
.end method

.method private static addParamPrefix(Ljava/lang/String;Ljava/lang/StringBuilder;)Ljava/lang/StringBuilder;
    .locals 5

    .prologue
    const/16 v4, 0x3f

    const/16 v3, 0x26

    .line 328
    invoke-virtual {p0, v4}, Ljava/lang/String;->indexOf(I)I

    move-result v0

    .line 329
    invoke-virtual {p1}, Ljava/lang/StringBuilder;->length()I

    move-result v1

    add-int/lit8 v1, v1, -0x1

    .line 330
    const/4 v2, -0x1

    if-ne v0, v2, :cond_1

    .line 331
    invoke-virtual {p1, v4}, Ljava/lang/StringBuilder;->append(C)Ljava/lang/StringBuilder;

    .line 334
    :cond_0
    :goto_0
    return-object p1

    .line 332
    :cond_1
    if-ge v0, v1, :cond_0

    invoke-virtual {p0, v1}, Ljava/lang/String;->charAt(I)C

    move-result v0

    if-eq v0, v3, :cond_0

    .line 333
    invoke-virtual {p1, v3}, Ljava/lang/StringBuilder;->append(C)Ljava/lang/StringBuilder;

    goto :goto_0
.end method

.method private static addPathSeparator(Ljava/lang/String;Ljava/lang/StringBuilder;)Ljava/lang/StringBuilder;
    .locals 3

    .prologue
    const/16 v2, 0x2f

    .line 320
    const/16 v0, 0x3a

    invoke-virtual {p0, v0}, Ljava/lang/String;->indexOf(I)I

    move-result v0

    add-int/lit8 v0, v0, 0x2

    invoke-virtual {p0, v2}, Ljava/lang/String;->lastIndexOf(I)I

    move-result v1

    if-ne v0, v1, :cond_0

    .line 321
    invoke-virtual {p1, v2}, Ljava/lang/StringBuilder;->append(C)Ljava/lang/StringBuilder;

    .line 322
    :cond_0
    return-object p1
.end method

.method public static append(Ljava/lang/CharSequence;Ljava/util/Map;)Ljava/lang/String;
    .locals 4
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "(",
            "Ljava/lang/CharSequence;",
            "Ljava/util/Map",
            "<**>;)",
            "Ljava/lang/String;"
        }
    .end annotation

    .prologue
    .line 913
    invoke-interface {p0}, Ljava/lang/CharSequence;->toString()Ljava/lang/String;

    move-result-object v0

    .line 914
    if-eqz p1, :cond_0

    invoke-interface {p1}, Ljava/util/Map;->isEmpty()Z

    move-result v1

    if-eqz v1, :cond_1

    .line 933
    :cond_0
    :goto_0
    return-object v0

    .line 917
    :cond_1
    new-instance v1, Ljava/lang/StringBuilder;

    invoke-direct {v1, v0}, Ljava/lang/StringBuilder;-><init>(Ljava/lang/String;)V

    .line 919
    invoke-static {v0, v1}, Lcom/github/kevinsawicki/http/HttpRequest;->addPathSeparator(Ljava/lang/String;Ljava/lang/StringBuilder;)Ljava/lang/StringBuilder;

    .line 920
    invoke-static {v0, v1}, Lcom/github/kevinsawicki/http/HttpRequest;->addParamPrefix(Ljava/lang/String;Ljava/lang/StringBuilder;)Ljava/lang/StringBuilder;

    .line 923
    invoke-interface {p1}, Ljava/util/Map;->entrySet()Ljava/util/Set;

    move-result-object v0

    invoke-interface {v0}, Ljava/util/Set;->iterator()Ljava/util/Iterator;

    move-result-object v2

    .line 924
    invoke-interface {v2}, Ljava/util/Iterator;->next()Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Ljava/util/Map$Entry;

    .line 925
    invoke-interface {v0}, Ljava/util/Map$Entry;->getKey()Ljava/lang/Object;

    move-result-object v3

    invoke-virtual {v3}, Ljava/lang/Object;->toString()Ljava/lang/String;

    move-result-object v3

    invoke-interface {v0}, Ljava/util/Map$Entry;->getValue()Ljava/lang/Object;

    move-result-object v0

    invoke-static {v3, v0, v1}, Lcom/github/kevinsawicki/http/HttpRequest;->addParam(Ljava/lang/Object;Ljava/lang/Object;Ljava/lang/StringBuilder;)Ljava/lang/StringBuilder;

    .line 927
    :goto_1
    invoke-interface {v2}, Ljava/util/Iterator;->hasNext()Z

    move-result v0

    if-eqz v0, :cond_2

    .line 928
    const/16 v0, 0x26

    invoke-virtual {v1, v0}, Ljava/lang/StringBuilder;->append(C)Ljava/lang/StringBuilder;

    .line 929
    invoke-interface {v2}, Ljava/util/Iterator;->next()Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Ljava/util/Map$Entry;

    .line 930
    invoke-interface {v0}, Ljava/util/Map$Entry;->getKey()Ljava/lang/Object;

    move-result-object v3

    invoke-virtual {v3}, Ljava/lang/Object;->toString()Ljava/lang/String;

    move-result-object v3

    invoke-interface {v0}, Ljava/util/Map$Entry;->getValue()Ljava/lang/Object;

    move-result-object v0

    invoke-static {v3, v0, v1}, Lcom/github/kevinsawicki/http/HttpRequest;->addParam(Ljava/lang/Object;Ljava/lang/Object;Ljava/lang/StringBuilder;)Ljava/lang/StringBuilder;

    goto :goto_1

    .line 933
    :cond_2
    invoke-virtual {v1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v0

    goto :goto_0
.end method

.method public static varargs append(Ljava/lang/CharSequence;[Ljava/lang/Object;)Ljava/lang/String;
    .locals 4

    .prologue
    .line 948
    invoke-interface {p0}, Ljava/lang/CharSequence;->toString()Ljava/lang/String;

    move-result-object v0

    .line 949
    if-eqz p1, :cond_0

    array-length v1, p1

    if-nez v1, :cond_1

    .line 968
    :cond_0
    :goto_0
    return-object v0

    .line 952
    :cond_1
    array-length v1, p1

    rem-int/lit8 v1, v1, 0x2

    if-eqz v1, :cond_2

    .line 953
    new-instance v0, Ljava/lang/IllegalArgumentException;

    const-string v1, "Must specify an even number of parameter names/values"

    invoke-direct {v0, v1}, Ljava/lang/IllegalArgumentException;-><init>(Ljava/lang/String;)V

    throw v0

    .line 956
    :cond_2
    new-instance v1, Ljava/lang/StringBuilder;

    invoke-direct {v1, v0}, Ljava/lang/StringBuilder;-><init>(Ljava/lang/String;)V

    .line 958
    invoke-static {v0, v1}, Lcom/github/kevinsawicki/http/HttpRequest;->addPathSeparator(Ljava/lang/String;Ljava/lang/StringBuilder;)Ljava/lang/StringBuilder;

    .line 959
    invoke-static {v0, v1}, Lcom/github/kevinsawicki/http/HttpRequest;->addParamPrefix(Ljava/lang/String;Ljava/lang/StringBuilder;)Ljava/lang/StringBuilder;

    .line 961
    const/4 v0, 0x0

    aget-object v0, p1, v0

    const/4 v2, 0x1

    aget-object v2, p1, v2

    invoke-static {v0, v2, v1}, Lcom/github/kevinsawicki/http/HttpRequest;->addParam(Ljava/lang/Object;Ljava/lang/Object;Ljava/lang/StringBuilder;)Ljava/lang/StringBuilder;

    .line 963
    const/4 v0, 0x2

    :goto_1
    array-length v2, p1

    if-ge v0, v2, :cond_3

    .line 964
    const/16 v2, 0x26

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(C)Ljava/lang/StringBuilder;

    .line 965
    aget-object v2, p1, v0

    add-int/lit8 v3, v0, 0x1

    aget-object v3, p1, v3

    invoke-static {v2, v3, v1}, Lcom/github/kevinsawicki/http/HttpRequest;->addParam(Ljava/lang/Object;Ljava/lang/Object;Ljava/lang/StringBuilder;)Ljava/lang/StringBuilder;

    .line 963
    add-int/lit8 v0, v0, 0x2

    goto :goto_1

    .line 968
    :cond_3
    invoke-virtual {v1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v0

    goto :goto_0
.end method

.method private static arrayToList(Ljava/lang/Object;)Ljava/util/List;
    .locals 6
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "(",
            "Ljava/lang/Object;",
            ")",
            "Ljava/util/List",
            "<",
            "Ljava/lang/Object;",
            ">;"
        }
    .end annotation

    .prologue
    const/4 v1, 0x0

    .line 836
    instance-of v0, p0, [Ljava/lang/Object;

    if-eqz v0, :cond_1

    .line 837
    check-cast p0, [Ljava/lang/Object;

    check-cast p0, [Ljava/lang/Object;

    invoke-static {p0}, Ljava/util/Arrays;->asList([Ljava/lang/Object;)Ljava/util/List;

    move-result-object v0

    .line 857
    :cond_0
    return-object v0

    .line 839
    :cond_1
    new-instance v0, Ljava/util/ArrayList;

    invoke-direct {v0}, Ljava/util/ArrayList;-><init>()V

    .line 841
    instance-of v2, p0, [I

    if-eqz v2, :cond_2

    .line 842
    check-cast p0, [I

    check-cast p0, [I

    array-length v2, p0

    :goto_0
    if-ge v1, v2, :cond_0

    aget v3, p0, v1

    invoke-static {v3}, Ljava/lang/Integer;->valueOf(I)Ljava/lang/Integer;

    move-result-object v3

    invoke-interface {v0, v3}, Ljava/util/List;->add(Ljava/lang/Object;)Z

    add-int/lit8 v1, v1, 0x1

    goto :goto_0

    .line 843
    :cond_2
    instance-of v2, p0, [Z

    if-eqz v2, :cond_3

    .line 844
    check-cast p0, [Z

    check-cast p0, [Z

    array-length v2, p0

    :goto_1
    if-ge v1, v2, :cond_0

    aget-boolean v3, p0, v1

    invoke-static {v3}, Ljava/lang/Boolean;->valueOf(Z)Ljava/lang/Boolean;

    move-result-object v3

    invoke-interface {v0, v3}, Ljava/util/List;->add(Ljava/lang/Object;)Z

    add-int/lit8 v1, v1, 0x1

    goto :goto_1

    .line 845
    :cond_3
    instance-of v2, p0, [J

    if-eqz v2, :cond_4

    .line 846
    check-cast p0, [J

    check-cast p0, [J

    array-length v2, p0

    :goto_2
    if-ge v1, v2, :cond_0

    aget-wide v4, p0, v1

    invoke-static {v4, v5}, Ljava/lang/Long;->valueOf(J)Ljava/lang/Long;

    move-result-object v3

    invoke-interface {v0, v3}, Ljava/util/List;->add(Ljava/lang/Object;)Z

    add-int/lit8 v1, v1, 0x1

    goto :goto_2

    .line 847
    :cond_4
    instance-of v2, p0, [F

    if-eqz v2, :cond_5

    .line 848
    check-cast p0, [F

    check-cast p0, [F

    array-length v2, p0

    :goto_3
    if-ge v1, v2, :cond_0

    aget v3, p0, v1

    invoke-static {v3}, Ljava/lang/Float;->valueOf(F)Ljava/lang/Float;

    move-result-object v3

    invoke-interface {v0, v3}, Ljava/util/List;->add(Ljava/lang/Object;)Z

    add-int/lit8 v1, v1, 0x1

    goto :goto_3

    .line 849
    :cond_5
    instance-of v2, p0, [D

    if-eqz v2, :cond_6

    .line 850
    check-cast p0, [D

    check-cast p0, [D

    array-length v2, p0

    :goto_4
    if-ge v1, v2, :cond_0

    aget-wide v4, p0, v1

    invoke-static {v4, v5}, Ljava/lang/Double;->valueOf(D)Ljava/lang/Double;

    move-result-object v3

    invoke-interface {v0, v3}, Ljava/util/List;->add(Ljava/lang/Object;)Z

    add-int/lit8 v1, v1, 0x1

    goto :goto_4

    .line 851
    :cond_6
    instance-of v2, p0, [S

    if-eqz v2, :cond_7

    .line 852
    check-cast p0, [S

    check-cast p0, [S

    array-length v2, p0

    :goto_5
    if-ge v1, v2, :cond_0

    aget-short v3, p0, v1

    invoke-static {v3}, Ljava/lang/Short;->valueOf(S)Ljava/lang/Short;

    move-result-object v3

    invoke-interface {v0, v3}, Ljava/util/List;->add(Ljava/lang/Object;)Z

    add-int/lit8 v1, v1, 0x1

    goto :goto_5

    .line 853
    :cond_7
    instance-of v2, p0, [B

    if-eqz v2, :cond_8

    .line 854
    check-cast p0, [B

    check-cast p0, [B

    array-length v2, p0

    :goto_6
    if-ge v1, v2, :cond_0

    aget-byte v3, p0, v1

    invoke-static {v3}, Ljava/lang/Byte;->valueOf(B)Ljava/lang/Byte;

    move-result-object v3

    invoke-interface {v0, v3}, Ljava/util/List;->add(Ljava/lang/Object;)Z

    add-int/lit8 v1, v1, 0x1

    goto :goto_6

    .line 855
    :cond_8
    instance-of v2, p0, [C

    if-eqz v2, :cond_0

    .line 856
    check-cast p0, [C

    check-cast p0, [C

    array-length v2, p0

    :goto_7
    if-ge v1, v2, :cond_0

    aget-char v3, p0, v1

    invoke-static {v3}, Ljava/lang/Character;->valueOf(C)Ljava/lang/Character;

    move-result-object v3

    invoke-interface {v0, v3}, Ljava/util/List;->add(Ljava/lang/Object;)Z

    add-int/lit8 v1, v1, 0x1

    goto :goto_7
.end method

.method private createConnection()Ljava/net/HttpURLConnection;
    .locals 3

    .prologue
    .line 1500
    :try_start_0
    iget-object v0, p0, Lcom/github/kevinsawicki/http/HttpRequest;->httpProxyHost:Ljava/lang/String;

    if-eqz v0, :cond_0

    .line 1501
    sget-object v0, Lcom/github/kevinsawicki/http/HttpRequest;->CONNECTION_FACTORY:Lcom/github/kevinsawicki/http/HttpRequest$ConnectionFactory;

    iget-object v1, p0, Lcom/github/kevinsawicki/http/HttpRequest;->url:Ljava/net/URL;

    invoke-direct {p0}, Lcom/github/kevinsawicki/http/HttpRequest;->createProxy()Ljava/net/Proxy;

    move-result-object v2

    invoke-interface {v0, v1, v2}, Lcom/github/kevinsawicki/http/HttpRequest$ConnectionFactory;->create(Ljava/net/URL;Ljava/net/Proxy;)Ljava/net/HttpURLConnection;

    move-result-object v0

    .line 1504
    :goto_0
    iget-object v1, p0, Lcom/github/kevinsawicki/http/HttpRequest;->requestMethod:Ljava/lang/String;

    invoke-virtual {v0, v1}, Ljava/net/HttpURLConnection;->setRequestMethod(Ljava/lang/String;)V

    .line 1505
    return-object v0

    .line 1503
    :cond_0
    sget-object v0, Lcom/github/kevinsawicki/http/HttpRequest;->CONNECTION_FACTORY:Lcom/github/kevinsawicki/http/HttpRequest$ConnectionFactory;

    iget-object v1, p0, Lcom/github/kevinsawicki/http/HttpRequest;->url:Ljava/net/URL;

    invoke-interface {v0, v1}, Lcom/github/kevinsawicki/http/HttpRequest$ConnectionFactory;->create(Ljava/net/URL;)Ljava/net/HttpURLConnection;
    :try_end_0
    .catch Ljava/io/IOException; {:try_start_0 .. :try_end_0} :catch_0

    move-result-object v0

    goto :goto_0

    .line 1506
    :catch_0
    move-exception v0

    .line 1507
    new-instance v1, Lcom/github/kevinsawicki/http/HttpRequest$HttpRequestException;

    invoke-direct {v1, v0}, Lcom/github/kevinsawicki/http/HttpRequest$HttpRequestException;-><init>(Ljava/io/IOException;)V

    throw v1
.end method

.method private createProxy()Ljava/net/Proxy;
    .locals 5

    .prologue
    .line 1494
    new-instance v0, Ljava/net/Proxy;

    sget-object v1, Ljava/net/Proxy$Type;->HTTP:Ljava/net/Proxy$Type;

    new-instance v2, Ljava/net/InetSocketAddress;

    iget-object v3, p0, Lcom/github/kevinsawicki/http/HttpRequest;->httpProxyHost:Ljava/lang/String;

    iget v4, p0, Lcom/github/kevinsawicki/http/HttpRequest;->httpProxyPort:I

    invoke-direct {v2, v3, v4}, Ljava/net/InetSocketAddress;-><init>(Ljava/lang/String;I)V

    invoke-direct {v0, v1, v2}, Ljava/net/Proxy;-><init>(Ljava/net/Proxy$Type;Ljava/net/SocketAddress;)V

    return-object v0
.end method

.method public static delete(Ljava/lang/CharSequence;)Lcom/github/kevinsawicki/http/HttpRequest;
    .locals 2
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Lcom/github/kevinsawicki/http/HttpRequest$HttpRequestException;
        }
    .end annotation

    .prologue
    .line 1172
    new-instance v0, Lcom/github/kevinsawicki/http/HttpRequest;

    const-string v1, "DELETE"

    invoke-direct {v0, p0, v1}, Lcom/github/kevinsawicki/http/HttpRequest;-><init>(Ljava/lang/CharSequence;Ljava/lang/String;)V

    return-object v0
.end method

.method public static delete(Ljava/lang/CharSequence;Ljava/util/Map;Z)Lcom/github/kevinsawicki/http/HttpRequest;
    .locals 1
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "(",
            "Ljava/lang/CharSequence;",
            "Ljava/util/Map",
            "<**>;Z)",
            "Lcom/github/kevinsawicki/http/HttpRequest;"
        }
    .end annotation

    .prologue
    .line 1202
    invoke-static {p0, p1}, Lcom/github/kevinsawicki/http/HttpRequest;->append(Ljava/lang/CharSequence;Ljava/util/Map;)Ljava/lang/String;

    move-result-object v0

    .line 1203
    if-eqz p2, :cond_0

    invoke-static {v0}, Lcom/github/kevinsawicki/http/HttpRequest;->encode(Ljava/lang/CharSequence;)Ljava/lang/String;

    move-result-object v0

    :cond_0
    invoke-static {v0}, Lcom/github/kevinsawicki/http/HttpRequest;->delete(Ljava/lang/CharSequence;)Lcom/github/kevinsawicki/http/HttpRequest;

    move-result-object v0

    return-object v0
.end method

.method public static varargs delete(Ljava/lang/CharSequence;Z[Ljava/lang/Object;)Lcom/github/kevinsawicki/http/HttpRequest;
    .locals 1

    .prologue
    .line 1223
    invoke-static {p0, p2}, Lcom/github/kevinsawicki/http/HttpRequest;->append(Ljava/lang/CharSequence;[Ljava/lang/Object;)Ljava/lang/String;

    move-result-object v0

    .line 1224
    if-eqz p1, :cond_0

    invoke-static {v0}, Lcom/github/kevinsawicki/http/HttpRequest;->encode(Ljava/lang/CharSequence;)Ljava/lang/String;

    move-result-object v0

    :cond_0
    invoke-static {v0}, Lcom/github/kevinsawicki/http/HttpRequest;->delete(Ljava/lang/CharSequence;)Lcom/github/kevinsawicki/http/HttpRequest;

    move-result-object v0

    return-object v0
.end method

.method public static delete(Ljava/net/URL;)Lcom/github/kevinsawicki/http/HttpRequest;
    .locals 2
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Lcom/github/kevinsawicki/http/HttpRequest$HttpRequestException;
        }
    .end annotation

    .prologue
    .line 1183
    new-instance v0, Lcom/github/kevinsawicki/http/HttpRequest;

    const-string v1, "DELETE"

    invoke-direct {v0, p0, v1}, Lcom/github/kevinsawicki/http/HttpRequest;-><init>(Ljava/net/URL;Ljava/lang/String;)V

    return-object v0
.end method

.method public static encode(Ljava/lang/CharSequence;)Ljava/lang/String;
    .locals 6
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Lcom/github/kevinsawicki/http/HttpRequest$HttpRequestException;
        }
    .end annotation

    .prologue
    .line 877
    :try_start_0
    new-instance v4, Ljava/net/URL;

    invoke-interface {p0}, Ljava/lang/CharSequence;->toString()Ljava/lang/String;

    move-result-object v0

    invoke-direct {v4, v0}, Ljava/net/URL;-><init>(Ljava/lang/String;)V
    :try_end_0
    .catch Ljava/io/IOException; {:try_start_0 .. :try_end_0} :catch_0

    .line 882
    invoke-virtual {v4}, Ljava/net/URL;->getHost()Ljava/lang/String;

    move-result-object v2

    .line 883
    invoke-virtual {v4}, Ljava/net/URL;->getPort()I

    move-result v0

    .line 884
    const/4 v1, -0x1

    if-eq v0, v1, :cond_0

    .line 885
    new-instance v1, Ljava/lang/StringBuilder;

    invoke-direct {v1}, Ljava/lang/StringBuilder;-><init>()V

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    const/16 v2, 0x3a

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(C)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-static {v0}, Ljava/lang/Integer;->toString(I)Ljava/lang/String;

    move-result-object v0

    invoke-virtual {v1, v0}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-virtual {v0}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v2

    .line 888
    :cond_0
    :try_start_1
    new-instance v0, Ljava/net/URI;

    invoke-virtual {v4}, Ljava/net/URL;->getProtocol()Ljava/lang/String;

    move-result-object v1

    invoke-virtual {v4}, Ljava/net/URL;->getPath()Ljava/lang/String;

    move-result-object v3

    .line 889
    invoke-virtual {v4}, Ljava/net/URL;->getQuery()Ljava/lang/String;

    move-result-object v4

    const/4 v5, 0x0

    invoke-direct/range {v0 .. v5}, Ljava/net/URI;-><init>(Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;)V

    invoke-virtual {v0}, Ljava/net/URI;->toASCIIString()Ljava/lang/String;

    move-result-object v0

    .line 890
    const/16 v1, 0x3f

    invoke-virtual {v0, v1}, Ljava/lang/String;->indexOf(I)I

    move-result v1

    .line 891
    if-lez v1, :cond_1

    add-int/lit8 v2, v1, 0x1

    invoke-virtual {v0}, Ljava/lang/String;->length()I

    move-result v3

    if-ge v2, v3, :cond_1

    .line 892
    new-instance v2, Ljava/lang/StringBuilder;

    invoke-direct {v2}, Ljava/lang/StringBuilder;-><init>()V

    const/4 v3, 0x0

    add-int/lit8 v4, v1, 0x1

    invoke-virtual {v0, v3, v4}, Ljava/lang/String;->substring(II)Ljava/lang/String;

    move-result-object v3

    invoke-virtual {v2, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    add-int/lit8 v1, v1, 0x1

    .line 893
    invoke-virtual {v0, v1}, Ljava/lang/String;->substring(I)Ljava/lang/String;

    move-result-object v0

    const-string v1, "+"

    const-string v3, "%2B"

    invoke-virtual {v0, v1, v3}, Ljava/lang/String;->replace(Ljava/lang/CharSequence;Ljava/lang/CharSequence;)Ljava/lang/String;

    move-result-object v0

    invoke-virtual {v2, v0}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-virtual {v0}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;
    :try_end_1
    .catch Ljava/net/URISyntaxException; {:try_start_1 .. :try_end_1} :catch_1

    move-result-object v0

    .line 894
    :cond_1
    return-object v0

    .line 878
    :catch_0
    move-exception v0

    .line 879
    new-instance v1, Lcom/github/kevinsawicki/http/HttpRequest$HttpRequestException;

    invoke-direct {v1, v0}, Lcom/github/kevinsawicki/http/HttpRequest$HttpRequestException;-><init>(Ljava/io/IOException;)V

    throw v1

    .line 895
    :catch_1
    move-exception v0

    .line 896
    new-instance v1, Ljava/io/IOException;

    const-string v2, "Parsing URI failed"

    invoke-direct {v1, v2}, Ljava/io/IOException;-><init>(Ljava/lang/String;)V

    .line 897
    invoke-virtual {v1, v0}, Ljava/io/IOException;->initCause(Ljava/lang/Throwable;)Ljava/lang/Throwable;

    .line 898
    new-instance v0, Lcom/github/kevinsawicki/http/HttpRequest$HttpRequestException;

    invoke-direct {v0, v1}, Lcom/github/kevinsawicki/http/HttpRequest$HttpRequestException;-><init>(Ljava/io/IOException;)V

    throw v0
.end method

.method public static get(Ljava/lang/CharSequence;)Lcom/github/kevinsawicki/http/HttpRequest;
    .locals 2
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Lcom/github/kevinsawicki/http/HttpRequest$HttpRequestException;
        }
    .end annotation

    .prologue
    .line 980
    new-instance v0, Lcom/github/kevinsawicki/http/HttpRequest;

    const-string v1, "GET"

    invoke-direct {v0, p0, v1}, Lcom/github/kevinsawicki/http/HttpRequest;-><init>(Ljava/lang/CharSequence;Ljava/lang/String;)V

    return-object v0
.end method

.method public static get(Ljava/lang/CharSequence;Ljava/util/Map;Z)Lcom/github/kevinsawicki/http/HttpRequest;
    .locals 1
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "(",
            "Ljava/lang/CharSequence;",
            "Ljava/util/Map",
            "<**>;Z)",
            "Lcom/github/kevinsawicki/http/HttpRequest;"
        }
    .end annotation

    .prologue
    .line 1010
    invoke-static {p0, p1}, Lcom/github/kevinsawicki/http/HttpRequest;->append(Ljava/lang/CharSequence;Ljava/util/Map;)Ljava/lang/String;

    move-result-object v0

    .line 1011
    if-eqz p2, :cond_0

    invoke-static {v0}, Lcom/github/kevinsawicki/http/HttpRequest;->encode(Ljava/lang/CharSequence;)Ljava/lang/String;

    move-result-object v0

    :cond_0
    invoke-static {v0}, Lcom/github/kevinsawicki/http/HttpRequest;->get(Ljava/lang/CharSequence;)Lcom/github/kevinsawicki/http/HttpRequest;

    move-result-object v0

    return-object v0
.end method

.method public static varargs get(Ljava/lang/CharSequence;Z[Ljava/lang/Object;)Lcom/github/kevinsawicki/http/HttpRequest;
    .locals 1

    .prologue
    .line 1031
    invoke-static {p0, p2}, Lcom/github/kevinsawicki/http/HttpRequest;->append(Ljava/lang/CharSequence;[Ljava/lang/Object;)Ljava/lang/String;

    move-result-object v0

    .line 1032
    if-eqz p1, :cond_0

    invoke-static {v0}, Lcom/github/kevinsawicki/http/HttpRequest;->encode(Ljava/lang/CharSequence;)Ljava/lang/String;

    move-result-object v0

    :cond_0
    invoke-static {v0}, Lcom/github/kevinsawicki/http/HttpRequest;->get(Ljava/lang/CharSequence;)Lcom/github/kevinsawicki/http/HttpRequest;

    move-result-object v0

    return-object v0
.end method

.method public static get(Ljava/net/URL;)Lcom/github/kevinsawicki/http/HttpRequest;
    .locals 2
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Lcom/github/kevinsawicki/http/HttpRequest$HttpRequestException;
        }
    .end annotation

    .prologue
    .line 991
    new-instance v0, Lcom/github/kevinsawicki/http/HttpRequest;

    const-string v1, "GET"

    invoke-direct {v0, p0, v1}, Lcom/github/kevinsawicki/http/HttpRequest;-><init>(Ljava/net/URL;Ljava/lang/String;)V

    return-object v0
.end method

.method private static getTrustedFactory()Ljavax/net/ssl/SSLSocketFactory;
    .locals 4
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Lcom/github/kevinsawicki/http/HttpRequest$HttpRequestException;
        }
    .end annotation

    .prologue
    .line 272
    sget-object v0, Lcom/github/kevinsawicki/http/HttpRequest;->TRUSTED_FACTORY:Ljavax/net/ssl/SSLSocketFactory;

    if-nez v0, :cond_0

    .line 273
    const/4 v0, 0x1

    new-array v0, v0, [Ljavax/net/ssl/TrustManager;

    const/4 v1, 0x0

    new-instance v2, Lcom/github/kevinsawicki/http/HttpRequest$1;

    invoke-direct {v2}, Lcom/github/kevinsawicki/http/HttpRequest$1;-><init>()V

    aput-object v2, v0, v1

    .line 288
    :try_start_0
    const-string v1, "TLS"

    invoke-static {v1}, Ljavax/net/ssl/SSLContext;->getInstance(Ljava/lang/String;)Ljavax/net/ssl/SSLContext;

    move-result-object v1

    .line 289
    const/4 v2, 0x0

    new-instance v3, Ljava/security/SecureRandom;

    invoke-direct {v3}, Ljava/security/SecureRandom;-><init>()V

    invoke-virtual {v1, v2, v0, v3}, Ljavax/net/ssl/SSLContext;->init([Ljavax/net/ssl/KeyManager;[Ljavax/net/ssl/TrustManager;Ljava/security/SecureRandom;)V

    .line 290
    invoke-virtual {v1}, Ljavax/net/ssl/SSLContext;->getSocketFactory()Ljavax/net/ssl/SSLSocketFactory;

    move-result-object v0

    sput-object v0, Lcom/github/kevinsawicki/http/HttpRequest;->TRUSTED_FACTORY:Ljavax/net/ssl/SSLSocketFactory;
    :try_end_0
    .catch Ljava/security/GeneralSecurityException; {:try_start_0 .. :try_end_0} :catch_0

    .line 299
    :cond_0
    sget-object v0, Lcom/github/kevinsawicki/http/HttpRequest;->TRUSTED_FACTORY:Ljavax/net/ssl/SSLSocketFactory;

    return-object v0

    .line 291
    :catch_0
    move-exception v0

    .line 292
    new-instance v1, Ljava/io/IOException;

    const-string v2, "Security exception configuring SSL context"

    invoke-direct {v1, v2}, Ljava/io/IOException;-><init>(Ljava/lang/String;)V

    .line 294
    invoke-virtual {v1, v0}, Ljava/io/IOException;->initCause(Ljava/lang/Throwable;)Ljava/lang/Throwable;

    .line 295
    new-instance v0, Lcom/github/kevinsawicki/http/HttpRequest$HttpRequestException;

    invoke-direct {v0, v1}, Lcom/github/kevinsawicki/http/HttpRequest$HttpRequestException;-><init>(Ljava/io/IOException;)V

    throw v0
.end method

.method private static getTrustedVerifier()Ljavax/net/ssl/HostnameVerifier;
    .locals 1

    .prologue
    .line 303
    sget-object v0, Lcom/github/kevinsawicki/http/HttpRequest;->TRUSTED_VERIFIER:Ljavax/net/ssl/HostnameVerifier;

    if-nez v0, :cond_0

    .line 304
    new-instance v0, Lcom/github/kevinsawicki/http/HttpRequest$2;

    invoke-direct {v0}, Lcom/github/kevinsawicki/http/HttpRequest$2;-><init>()V

    sput-object v0, Lcom/github/kevinsawicki/http/HttpRequest;->TRUSTED_VERIFIER:Ljavax/net/ssl/HostnameVerifier;

    .line 311
    :cond_0
    sget-object v0, Lcom/github/kevinsawicki/http/HttpRequest;->TRUSTED_VERIFIER:Ljavax/net/ssl/HostnameVerifier;

    return-object v0
.end method

.method private static getValidCharset(Ljava/lang/String;)Ljava/lang/String;
    .locals 1

    .prologue
    .line 264
    if-eqz p0, :cond_0

    invoke-virtual {p0}, Ljava/lang/String;->length()I

    move-result v0

    if-lez v0, :cond_0

    .line 267
    :goto_0
    return-object p0

    :cond_0
    const-string p0, "UTF-8"

    goto :goto_0
.end method

.method public static head(Ljava/lang/CharSequence;)Lcom/github/kevinsawicki/http/HttpRequest;
    .locals 2
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Lcom/github/kevinsawicki/http/HttpRequest$HttpRequestException;
        }
    .end annotation

    .prologue
    .line 1236
    new-instance v0, Lcom/github/kevinsawicki/http/HttpRequest;

    const-string v1, "HEAD"

    invoke-direct {v0, p0, v1}, Lcom/github/kevinsawicki/http/HttpRequest;-><init>(Ljava/lang/CharSequence;Ljava/lang/String;)V

    return-object v0
.end method

.method public static head(Ljava/lang/CharSequence;Ljava/util/Map;Z)Lcom/github/kevinsawicki/http/HttpRequest;
    .locals 1
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "(",
            "Ljava/lang/CharSequence;",
            "Ljava/util/Map",
            "<**>;Z)",
            "Lcom/github/kevinsawicki/http/HttpRequest;"
        }
    .end annotation

    .prologue
    .line 1266
    invoke-static {p0, p1}, Lcom/github/kevinsawicki/http/HttpRequest;->append(Ljava/lang/CharSequence;Ljava/util/Map;)Ljava/lang/String;

    move-result-object v0

    .line 1267
    if-eqz p2, :cond_0

    invoke-static {v0}, Lcom/github/kevinsawicki/http/HttpRequest;->encode(Ljava/lang/CharSequence;)Ljava/lang/String;

    move-result-object v0

    :cond_0
    invoke-static {v0}, Lcom/github/kevinsawicki/http/HttpRequest;->head(Ljava/lang/CharSequence;)Lcom/github/kevinsawicki/http/HttpRequest;

    move-result-object v0

    return-object v0
.end method

.method public static varargs head(Ljava/lang/CharSequence;Z[Ljava/lang/Object;)Lcom/github/kevinsawicki/http/HttpRequest;
    .locals 1

    .prologue
    .line 1287
    invoke-static {p0, p2}, Lcom/github/kevinsawicki/http/HttpRequest;->append(Ljava/lang/CharSequence;[Ljava/lang/Object;)Ljava/lang/String;

    move-result-object v0

    .line 1288
    if-eqz p1, :cond_0

    invoke-static {v0}, Lcom/github/kevinsawicki/http/HttpRequest;->encode(Ljava/lang/CharSequence;)Ljava/lang/String;

    move-result-object v0

    :cond_0
    invoke-static {v0}, Lcom/github/kevinsawicki/http/HttpRequest;->head(Ljava/lang/CharSequence;)Lcom/github/kevinsawicki/http/HttpRequest;

    move-result-object v0

    return-object v0
.end method

.method public static head(Ljava/net/URL;)Lcom/github/kevinsawicki/http/HttpRequest;
    .locals 2
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Lcom/github/kevinsawicki/http/HttpRequest$HttpRequestException;
        }
    .end annotation

    .prologue
    .line 1247
    new-instance v0, Lcom/github/kevinsawicki/http/HttpRequest;

    const-string v1, "HEAD"

    invoke-direct {v0, p0, v1}, Lcom/github/kevinsawicki/http/HttpRequest;-><init>(Ljava/net/URL;Ljava/lang/String;)V

    return-object v0
.end method

.method private incrementTotalSize(J)Lcom/github/kevinsawicki/http/HttpRequest;
    .locals 5

    .prologue
    .line 2670
    iget-wide v0, p0, Lcom/github/kevinsawicki/http/HttpRequest;->totalSize:J

    const-wide/16 v2, -0x1

    cmp-long v0, v0, v2

    if-nez v0, :cond_0

    .line 2671
    const-wide/16 v0, 0x0

    iput-wide v0, p0, Lcom/github/kevinsawicki/http/HttpRequest;->totalSize:J

    .line 2672
    :cond_0
    iget-wide v0, p0, Lcom/github/kevinsawicki/http/HttpRequest;->totalSize:J

    add-long/2addr v0, p1

    iput-wide v0, p0, Lcom/github/kevinsawicki/http/HttpRequest;->totalSize:J

    .line 2673
    return-object p0
.end method

.method public static keepAlive(Z)V
    .locals 2

    .prologue
    .line 1345
    const-string v0, "http.keepAlive"

    invoke-static {p0}, Ljava/lang/Boolean;->toString(Z)Ljava/lang/String;

    move-result-object v1

    invoke-static {v0, v1}, Lcom/github/kevinsawicki/http/HttpRequest;->setProperty(Ljava/lang/String;Ljava/lang/String;)Ljava/lang/String;

    .line 1346
    return-void
.end method

.method public static maxConnections(I)V
    .locals 2

    .prologue
    .line 1356
    const-string v0, "http.maxConnections"

    invoke-static {p0}, Ljava/lang/Integer;->toString(I)Ljava/lang/String;

    move-result-object v1

    invoke-static {v0, v1}, Lcom/github/kevinsawicki/http/HttpRequest;->setProperty(Ljava/lang/String;Ljava/lang/String;)Ljava/lang/String;

    .line 1357
    return-void
.end method

.method public static varargs nonProxyHosts([Ljava/lang/String;)V
    .locals 5

    .prologue
    .line 1396
    if-eqz p0, :cond_1

    array-length v0, p0

    if-lez v0, :cond_1

    .line 1397
    new-instance v1, Ljava/lang/StringBuilder;

    invoke-direct {v1}, Ljava/lang/StringBuilder;-><init>()V

    .line 1398
    array-length v0, p0

    add-int/lit8 v2, v0, -0x1

    .line 1399
    const/4 v0, 0x0

    :goto_0
    if-ge v0, v2, :cond_0

    .line 1400
    aget-object v3, p0, v0

    invoke-virtual {v1, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v3

    const/16 v4, 0x7c

    invoke-virtual {v3, v4}, Ljava/lang/StringBuilder;->append(C)Ljava/lang/StringBuilder;

    .line 1399
    add-int/lit8 v0, v0, 0x1

    goto :goto_0

    .line 1401
    :cond_0
    aget-object v0, p0, v2

    invoke-virtual {v1, v0}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    .line 1402
    const-string v0, "http.nonProxyHosts"

    invoke-virtual {v1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v1

    invoke-static {v0, v1}, Lcom/github/kevinsawicki/http/HttpRequest;->setProperty(Ljava/lang/String;Ljava/lang/String;)Ljava/lang/String;

    .line 1405
    :goto_1
    return-void

    .line 1404
    :cond_1
    const-string v0, "http.nonProxyHosts"

    const/4 v1, 0x0

    invoke-static {v0, v1}, Lcom/github/kevinsawicki/http/HttpRequest;->setProperty(Ljava/lang/String;Ljava/lang/String;)Ljava/lang/String;

    goto :goto_1
.end method

.method public static options(Ljava/lang/CharSequence;)Lcom/github/kevinsawicki/http/HttpRequest;
    .locals 2
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Lcom/github/kevinsawicki/http/HttpRequest$HttpRequestException;
        }
    .end annotation

    .prologue
    .line 1300
    new-instance v0, Lcom/github/kevinsawicki/http/HttpRequest;

    const-string v1, "OPTIONS"

    invoke-direct {v0, p0, v1}, Lcom/github/kevinsawicki/http/HttpRequest;-><init>(Ljava/lang/CharSequence;Ljava/lang/String;)V

    return-object v0
.end method

.method public static options(Ljava/net/URL;)Lcom/github/kevinsawicki/http/HttpRequest;
    .locals 2
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Lcom/github/kevinsawicki/http/HttpRequest$HttpRequestException;
        }
    .end annotation

    .prologue
    .line 1311
    new-instance v0, Lcom/github/kevinsawicki/http/HttpRequest;

    const-string v1, "OPTIONS"

    invoke-direct {v0, p0, v1}, Lcom/github/kevinsawicki/http/HttpRequest;-><init>(Ljava/net/URL;Ljava/lang/String;)V

    return-object v0
.end method

.method public static post(Ljava/lang/CharSequence;)Lcom/github/kevinsawicki/http/HttpRequest;
    .locals 2
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Lcom/github/kevinsawicki/http/HttpRequest$HttpRequestException;
        }
    .end annotation

    .prologue
    .line 1044
    new-instance v0, Lcom/github/kevinsawicki/http/HttpRequest;

    const-string v1, "POST"

    invoke-direct {v0, p0, v1}, Lcom/github/kevinsawicki/http/HttpRequest;-><init>(Ljava/lang/CharSequence;Ljava/lang/String;)V

    return-object v0
.end method

.method public static post(Ljava/lang/CharSequence;Ljava/util/Map;Z)Lcom/github/kevinsawicki/http/HttpRequest;
    .locals 1
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "(",
            "Ljava/lang/CharSequence;",
            "Ljava/util/Map",
            "<**>;Z)",
            "Lcom/github/kevinsawicki/http/HttpRequest;"
        }
    .end annotation

    .prologue
    .line 1074
    invoke-static {p0, p1}, Lcom/github/kevinsawicki/http/HttpRequest;->append(Ljava/lang/CharSequence;Ljava/util/Map;)Ljava/lang/String;

    move-result-object v0

    .line 1075
    if-eqz p2, :cond_0

    invoke-static {v0}, Lcom/github/kevinsawicki/http/HttpRequest;->encode(Ljava/lang/CharSequence;)Ljava/lang/String;

    move-result-object v0

    :cond_0
    invoke-static {v0}, Lcom/github/kevinsawicki/http/HttpRequest;->post(Ljava/lang/CharSequence;)Lcom/github/kevinsawicki/http/HttpRequest;

    move-result-object v0

    return-object v0
.end method

.method public static varargs post(Ljava/lang/CharSequence;Z[Ljava/lang/Object;)Lcom/github/kevinsawicki/http/HttpRequest;
    .locals 1

    .prologue
    .line 1095
    invoke-static {p0, p2}, Lcom/github/kevinsawicki/http/HttpRequest;->append(Ljava/lang/CharSequence;[Ljava/lang/Object;)Ljava/lang/String;

    move-result-object v0

    .line 1096
    if-eqz p1, :cond_0

    invoke-static {v0}, Lcom/github/kevinsawicki/http/HttpRequest;->encode(Ljava/lang/CharSequence;)Ljava/lang/String;

    move-result-object v0

    :cond_0
    invoke-static {v0}, Lcom/github/kevinsawicki/http/HttpRequest;->post(Ljava/lang/CharSequence;)Lcom/github/kevinsawicki/http/HttpRequest;

    move-result-object v0

    return-object v0
.end method

.method public static post(Ljava/net/URL;)Lcom/github/kevinsawicki/http/HttpRequest;
    .locals 2
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Lcom/github/kevinsawicki/http/HttpRequest$HttpRequestException;
        }
    .end annotation

    .prologue
    .line 1055
    new-instance v0, Lcom/github/kevinsawicki/http/HttpRequest;

    const-string v1, "POST"

    invoke-direct {v0, p0, v1}, Lcom/github/kevinsawicki/http/HttpRequest;-><init>(Ljava/net/URL;Ljava/lang/String;)V

    return-object v0
.end method

.method public static proxyHost(Ljava/lang/String;)V
    .locals 1

    .prologue
    .line 1368
    const-string v0, "http.proxyHost"

    invoke-static {v0, p0}, Lcom/github/kevinsawicki/http/HttpRequest;->setProperty(Ljava/lang/String;Ljava/lang/String;)Ljava/lang/String;

    .line 1369
    const-string v0, "https.proxyHost"

    invoke-static {v0, p0}, Lcom/github/kevinsawicki/http/HttpRequest;->setProperty(Ljava/lang/String;Ljava/lang/String;)Ljava/lang/String;

    .line 1370
    return-void
.end method

.method public static proxyPort(I)V
    .locals 2

    .prologue
    .line 1381
    invoke-static {p0}, Ljava/lang/Integer;->toString(I)Ljava/lang/String;

    move-result-object v0

    .line 1382
    const-string v1, "http.proxyPort"

    invoke-static {v1, v0}, Lcom/github/kevinsawicki/http/HttpRequest;->setProperty(Ljava/lang/String;Ljava/lang/String;)Ljava/lang/String;

    .line 1383
    const-string v1, "https.proxyPort"

    invoke-static {v1, v0}, Lcom/github/kevinsawicki/http/HttpRequest;->setProperty(Ljava/lang/String;Ljava/lang/String;)Ljava/lang/String;

    .line 1384
    return-void
.end method

.method public static put(Ljava/lang/CharSequence;)Lcom/github/kevinsawicki/http/HttpRequest;
    .locals 2
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Lcom/github/kevinsawicki/http/HttpRequest$HttpRequestException;
        }
    .end annotation

    .prologue
    .line 1108
    new-instance v0, Lcom/github/kevinsawicki/http/HttpRequest;

    const-string v1, "PUT"

    invoke-direct {v0, p0, v1}, Lcom/github/kevinsawicki/http/HttpRequest;-><init>(Ljava/lang/CharSequence;Ljava/lang/String;)V

    return-object v0
.end method

.method public static put(Ljava/lang/CharSequence;Ljava/util/Map;Z)Lcom/github/kevinsawicki/http/HttpRequest;
    .locals 1
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "(",
            "Ljava/lang/CharSequence;",
            "Ljava/util/Map",
            "<**>;Z)",
            "Lcom/github/kevinsawicki/http/HttpRequest;"
        }
    .end annotation

    .prologue
    .line 1138
    invoke-static {p0, p1}, Lcom/github/kevinsawicki/http/HttpRequest;->append(Ljava/lang/CharSequence;Ljava/util/Map;)Ljava/lang/String;

    move-result-object v0

    .line 1139
    if-eqz p2, :cond_0

    invoke-static {v0}, Lcom/github/kevinsawicki/http/HttpRequest;->encode(Ljava/lang/CharSequence;)Ljava/lang/String;

    move-result-object v0

    :cond_0
    invoke-static {v0}, Lcom/github/kevinsawicki/http/HttpRequest;->put(Ljava/lang/CharSequence;)Lcom/github/kevinsawicki/http/HttpRequest;

    move-result-object v0

    return-object v0
.end method

.method public static varargs put(Ljava/lang/CharSequence;Z[Ljava/lang/Object;)Lcom/github/kevinsawicki/http/HttpRequest;
    .locals 1

    .prologue
    .line 1159
    invoke-static {p0, p2}, Lcom/github/kevinsawicki/http/HttpRequest;->append(Ljava/lang/CharSequence;[Ljava/lang/Object;)Ljava/lang/String;

    move-result-object v0

    .line 1160
    if-eqz p1, :cond_0

    invoke-static {v0}, Lcom/github/kevinsawicki/http/HttpRequest;->encode(Ljava/lang/CharSequence;)Ljava/lang/String;

    move-result-object v0

    :cond_0
    invoke-static {v0}, Lcom/github/kevinsawicki/http/HttpRequest;->put(Ljava/lang/CharSequence;)Lcom/github/kevinsawicki/http/HttpRequest;

    move-result-object v0

    return-object v0
.end method

.method public static put(Ljava/net/URL;)Lcom/github/kevinsawicki/http/HttpRequest;
    .locals 2
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Lcom/github/kevinsawicki/http/HttpRequest$HttpRequestException;
        }
    .end annotation

    .prologue
    .line 1119
    new-instance v0, Lcom/github/kevinsawicki/http/HttpRequest;

    const-string v1, "PUT"

    invoke-direct {v0, p0, v1}, Lcom/github/kevinsawicki/http/HttpRequest;-><init>(Ljava/net/URL;Ljava/lang/String;)V

    return-object v0
.end method

.method public static setConnectionFactory(Lcom/github/kevinsawicki/http/HttpRequest$ConnectionFactory;)V
    .locals 1

    .prologue
    .line 404
    if-nez p0, :cond_0

    .line 405
    sget-object v0, Lcom/github/kevinsawicki/http/HttpRequest$ConnectionFactory;->DEFAULT:Lcom/github/kevinsawicki/http/HttpRequest$ConnectionFactory;

    sput-object v0, Lcom/github/kevinsawicki/http/HttpRequest;->CONNECTION_FACTORY:Lcom/github/kevinsawicki/http/HttpRequest$ConnectionFactory;

    .line 408
    :goto_0
    return-void

    .line 407
    :cond_0
    sput-object p0, Lcom/github/kevinsawicki/http/HttpRequest;->CONNECTION_FACTORY:Lcom/github/kevinsawicki/http/HttpRequest$ConnectionFactory;

    goto :goto_0
.end method

.method private static setProperty(Ljava/lang/String;Ljava/lang/String;)Ljava/lang/String;
    .locals 1

    .prologue
    .line 1418
    if-eqz p1, :cond_0

    .line 1419
    new-instance v0, Lcom/github/kevinsawicki/http/HttpRequest$3;

    invoke-direct {v0, p0, p1}, Lcom/github/kevinsawicki/http/HttpRequest$3;-><init>(Ljava/lang/String;Ljava/lang/String;)V

    .line 1432
    :goto_0
    invoke-static {v0}, Ljava/security/AccessController;->doPrivileged(Ljava/security/PrivilegedAction;)Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Ljava/lang/String;

    return-object v0

    .line 1426
    :cond_0
    new-instance v0, Lcom/github/kevinsawicki/http/HttpRequest$4;

    invoke-direct {v0, p0}, Lcom/github/kevinsawicki/http/HttpRequest$4;-><init>(Ljava/lang/String;)V

    goto :goto_0
.end method

.method public static trace(Ljava/lang/CharSequence;)Lcom/github/kevinsawicki/http/HttpRequest;
    .locals 2
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Lcom/github/kevinsawicki/http/HttpRequest$HttpRequestException;
        }
    .end annotation

    .prologue
    .line 1323
    new-instance v0, Lcom/github/kevinsawicki/http/HttpRequest;

    const-string v1, "TRACE"

    invoke-direct {v0, p0, v1}, Lcom/github/kevinsawicki/http/HttpRequest;-><init>(Ljava/lang/CharSequence;Ljava/lang/String;)V

    return-object v0
.end method

.method public static trace(Ljava/net/URL;)Lcom/github/kevinsawicki/http/HttpRequest;
    .locals 2
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Lcom/github/kevinsawicki/http/HttpRequest$HttpRequestException;
        }
    .end annotation

    .prologue
    .line 1334
    new-instance v0, Lcom/github/kevinsawicki/http/HttpRequest;

    const-string v1, "TRACE"

    invoke-direct {v0, p0, v1}, Lcom/github/kevinsawicki/http/HttpRequest;-><init>(Ljava/net/URL;Ljava/lang/String;)V

    return-object v0
.end method


# virtual methods
.method public accept(Ljava/lang/String;)Lcom/github/kevinsawicki/http/HttpRequest;
    .locals 1

    .prologue
    .line 2591
    const-string v0, "Accept"

    invoke-virtual {p0, v0, p1}, Lcom/github/kevinsawicki/http/HttpRequest;->header(Ljava/lang/String;Ljava/lang/String;)Lcom/github/kevinsawicki/http/HttpRequest;

    move-result-object v0

    return-object v0
.end method

.method public acceptCharset(Ljava/lang/String;)Lcom/github/kevinsawicki/http/HttpRequest;
    .locals 1

    .prologue
    .line 2380
    const-string v0, "Accept-Charset"

    invoke-virtual {p0, v0, p1}, Lcom/github/kevinsawicki/http/HttpRequest;->header(Ljava/lang/String;Ljava/lang/String;)Lcom/github/kevinsawicki/http/HttpRequest;

    move-result-object v0

    return-object v0
.end method

.method public acceptEncoding(Ljava/lang/String;)Lcom/github/kevinsawicki/http/HttpRequest;
    .locals 1

    .prologue
    .line 2360
    const-string v0, "Accept-Encoding"

    invoke-virtual {p0, v0, p1}, Lcom/github/kevinsawicki/http/HttpRequest;->header(Ljava/lang/String;Ljava/lang/String;)Lcom/github/kevinsawicki/http/HttpRequest;

    move-result-object v0

    return-object v0
.end method

.method public acceptGzipEncoding()Lcom/github/kevinsawicki/http/HttpRequest;
    .locals 1

    .prologue
    .line 2370
    const-string v0, "gzip"

    invoke-virtual {p0, v0}, Lcom/github/kevinsawicki/http/HttpRequest;->acceptEncoding(Ljava/lang/String;)Lcom/github/kevinsawicki/http/HttpRequest;

    move-result-object v0

    return-object v0
.end method

.method public acceptJson()Lcom/github/kevinsawicki/http/HttpRequest;
    .locals 1

    .prologue
    .line 2600
    const-string v0, "application/json"

    invoke-virtual {p0, v0}, Lcom/github/kevinsawicki/http/HttpRequest;->accept(Ljava/lang/String;)Lcom/github/kevinsawicki/http/HttpRequest;

    move-result-object v0

    return-object v0
.end method

.method public authorization(Ljava/lang/String;)Lcom/github/kevinsawicki/http/HttpRequest;
    .locals 1

    .prologue
    .line 2462
    const-string v0, "Authorization"

    invoke-virtual {p0, v0, p1}, Lcom/github/kevinsawicki/http/HttpRequest;->header(Ljava/lang/String;Ljava/lang/String;)Lcom/github/kevinsawicki/http/HttpRequest;

    move-result-object v0

    return-object v0
.end method

.method public badRequest()Z
    .locals 2
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Lcom/github/kevinsawicki/http/HttpRequest$HttpRequestException;
        }
    .end annotation

    .prologue
    .line 1627
    const/16 v0, 0x190

    invoke-virtual {p0}, Lcom/github/kevinsawicki/http/HttpRequest;->code()I

    move-result v1

    if-ne v0, v1, :cond_0

    const/4 v0, 0x1

    :goto_0
    return v0

    :cond_0
    const/4 v0, 0x0

    goto :goto_0
.end method

.method public basic(Ljava/lang/String;Ljava/lang/String;)Lcom/github/kevinsawicki/http/HttpRequest;
    .locals 3

    .prologue
    .line 2484
    new-instance v0, Ljava/lang/StringBuilder;

    invoke-direct {v0}, Ljava/lang/StringBuilder;-><init>()V

    const-string v1, "Basic "

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    new-instance v1, Ljava/lang/StringBuilder;

    invoke-direct {v1}, Ljava/lang/StringBuilder;-><init>()V

    invoke-virtual {v1, p1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    const/16 v2, 0x3a

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(C)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1, p2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v1

    invoke-static {v1}, Lcom/github/kevinsawicki/http/HttpRequest$Base64;->encode(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v1

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-virtual {v0}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v0

    invoke-virtual {p0, v0}, Lcom/github/kevinsawicki/http/HttpRequest;->authorization(Ljava/lang/String;)Lcom/github/kevinsawicki/http/HttpRequest;

    move-result-object v0

    return-object v0
.end method

.method public body(Ljava/util/concurrent/atomic/AtomicReference;)Lcom/github/kevinsawicki/http/HttpRequest;
    .locals 1
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "(",
            "Ljava/util/concurrent/atomic/AtomicReference",
            "<",
            "Ljava/lang/String;",
            ">;)",
            "Lcom/github/kevinsawicki/http/HttpRequest;"
        }
    .end annotation

    .annotation system Ldalvik/annotation/Throws;
        value = {
            Lcom/github/kevinsawicki/http/HttpRequest$HttpRequestException;
        }
    .end annotation

    .prologue
    .line 1791
    invoke-virtual {p0}, Lcom/github/kevinsawicki/http/HttpRequest;->body()Ljava/lang/String;

    move-result-object v0

    invoke-virtual {p1, v0}, Ljava/util/concurrent/atomic/AtomicReference;->set(Ljava/lang/Object;)V

    .line 1792
    return-object p0
.end method

.method public body(Ljava/util/concurrent/atomic/AtomicReference;Ljava/lang/String;)Lcom/github/kevinsawicki/http/HttpRequest;
    .locals 1
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "(",
            "Ljava/util/concurrent/atomic/AtomicReference",
            "<",
            "Ljava/lang/String;",
            ">;",
            "Ljava/lang/String;",
            ")",
            "Lcom/github/kevinsawicki/http/HttpRequest;"
        }
    .end annotation

    .annotation system Ldalvik/annotation/Throws;
        value = {
            Lcom/github/kevinsawicki/http/HttpRequest$HttpRequestException;
        }
    .end annotation

    .prologue
    .line 1805
    invoke-virtual {p0, p2}, Lcom/github/kevinsawicki/http/HttpRequest;->body(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v0

    invoke-virtual {p1, v0}, Ljava/util/concurrent/atomic/AtomicReference;->set(Ljava/lang/Object;)V

    .line 1806
    return-object p0
.end method

.method public body()Ljava/lang/String;
    .locals 1
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Lcom/github/kevinsawicki/http/HttpRequest$HttpRequestException;
        }
    .end annotation

    .prologue
    .line 1779
    invoke-virtual {p0}, Lcom/github/kevinsawicki/http/HttpRequest;->charset()Ljava/lang/String;

    move-result-object v0

    invoke-virtual {p0, v0}, Lcom/github/kevinsawicki/http/HttpRequest;->body(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v0

    return-object v0
.end method

.method public body(Ljava/lang/String;)Ljava/lang/String;
    .locals 2
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Lcom/github/kevinsawicki/http/HttpRequest$HttpRequestException;
        }
    .end annotation

    .prologue
    .line 1762
    invoke-virtual {p0}, Lcom/github/kevinsawicki/http/HttpRequest;->byteStream()Ljava/io/ByteArrayOutputStream;

    move-result-object v0

    .line 1764
    :try_start_0
    invoke-virtual {p0}, Lcom/github/kevinsawicki/http/HttpRequest;->buffer()Ljava/io/BufferedInputStream;

    move-result-object v1

    invoke-virtual {p0, v1, v0}, Lcom/github/kevinsawicki/http/HttpRequest;->copy(Ljava/io/InputStream;Ljava/io/OutputStream;)Lcom/github/kevinsawicki/http/HttpRequest;

    .line 1765
    invoke-static {p1}, Lcom/github/kevinsawicki/http/HttpRequest;->getValidCharset(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v1

    invoke-virtual {v0, v1}, Ljava/io/ByteArrayOutputStream;->toString(Ljava/lang/String;)Ljava/lang/String;
    :try_end_0
    .catch Ljava/io/IOException; {:try_start_0 .. :try_end_0} :catch_0

    move-result-object v0

    return-object v0

    .line 1766
    :catch_0
    move-exception v0

    .line 1767
    new-instance v1, Lcom/github/kevinsawicki/http/HttpRequest$HttpRequestException;

    invoke-direct {v1, v0}, Lcom/github/kevinsawicki/http/HttpRequest$HttpRequestException;-><init>(Ljava/io/IOException;)V

    throw v1
.end method

.method public buffer()Ljava/io/BufferedInputStream;
    .locals 3
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Lcom/github/kevinsawicki/http/HttpRequest$HttpRequestException;
        }
    .end annotation

    .prologue
    .line 1844
    new-instance v0, Ljava/io/BufferedInputStream;

    invoke-virtual {p0}, Lcom/github/kevinsawicki/http/HttpRequest;->stream()Ljava/io/InputStream;

    move-result-object v1

    iget v2, p0, Lcom/github/kevinsawicki/http/HttpRequest;->bufferSize:I

    invoke-direct {v0, v1, v2}, Ljava/io/BufferedInputStream;-><init>(Ljava/io/InputStream;I)V

    return-object v0
.end method

.method public bufferSize()I
    .locals 1

    .prologue
    .line 1712
    iget v0, p0, Lcom/github/kevinsawicki/http/HttpRequest;->bufferSize:I

    return v0
.end method

.method public bufferSize(I)Lcom/github/kevinsawicki/http/HttpRequest;
    .locals 2

    .prologue
    .line 1698
    const/4 v0, 0x1

    if-ge p1, v0, :cond_0

    .line 1699
    new-instance v0, Ljava/lang/IllegalArgumentException;

    const-string v1, "Size must be greater than zero"

    invoke-direct {v0, v1}, Ljava/lang/IllegalArgumentException;-><init>(Ljava/lang/String;)V

    throw v0

    .line 1700
    :cond_0
    iput p1, p0, Lcom/github/kevinsawicki/http/HttpRequest;->bufferSize:I

    .line 1701
    return-object p0
.end method

.method public bufferedReader()Ljava/io/BufferedReader;
    .locals 1
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Lcom/github/kevinsawicki/http/HttpRequest$HttpRequestException;
        }
    .end annotation

    .prologue
    .line 1938
    invoke-virtual {p0}, Lcom/github/kevinsawicki/http/HttpRequest;->charset()Ljava/lang/String;

    move-result-object v0

    invoke-virtual {p0, v0}, Lcom/github/kevinsawicki/http/HttpRequest;->bufferedReader(Ljava/lang/String;)Ljava/io/BufferedReader;

    move-result-object v0

    return-object v0
.end method

.method public bufferedReader(Ljava/lang/String;)Ljava/io/BufferedReader;
    .locals 3
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Lcom/github/kevinsawicki/http/HttpRequest$HttpRequestException;
        }
    .end annotation

    .prologue
    .line 1926
    new-instance v0, Ljava/io/BufferedReader;

    invoke-virtual {p0, p1}, Lcom/github/kevinsawicki/http/HttpRequest;->reader(Ljava/lang/String;)Ljava/io/InputStreamReader;

    move-result-object v1

    iget v2, p0, Lcom/github/kevinsawicki/http/HttpRequest;->bufferSize:I

    invoke-direct {v0, v1, v2}, Ljava/io/BufferedReader;-><init>(Ljava/io/Reader;I)V

    return-object v0
.end method

.method protected byteStream()Ljava/io/ByteArrayOutputStream;
    .locals 2

    .prologue
    .line 1744
    invoke-virtual {p0}, Lcom/github/kevinsawicki/http/HttpRequest;->contentLength()I

    move-result v1

    .line 1745
    if-lez v1, :cond_0

    .line 1746
    new-instance v0, Ljava/io/ByteArrayOutputStream;

    invoke-direct {v0, v1}, Ljava/io/ByteArrayOutputStream;-><init>(I)V

    .line 1748
    :goto_0
    return-object v0

    :cond_0
    new-instance v0, Ljava/io/ByteArrayOutputStream;

    invoke-direct {v0}, Ljava/io/ByteArrayOutputStream;-><init>()V

    goto :goto_0
.end method

.method public bytes()[B
    .locals 2
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Lcom/github/kevinsawicki/http/HttpRequest$HttpRequestException;
        }
    .end annotation

    .prologue
    .line 1827
    invoke-virtual {p0}, Lcom/github/kevinsawicki/http/HttpRequest;->byteStream()Ljava/io/ByteArrayOutputStream;

    move-result-object v0

    .line 1829
    :try_start_0
    invoke-virtual {p0}, Lcom/github/kevinsawicki/http/HttpRequest;->buffer()Ljava/io/BufferedInputStream;

    move-result-object v1

    invoke-virtual {p0, v1, v0}, Lcom/github/kevinsawicki/http/HttpRequest;->copy(Ljava/io/InputStream;Ljava/io/OutputStream;)Lcom/github/kevinsawicki/http/HttpRequest;
    :try_end_0
    .catch Ljava/io/IOException; {:try_start_0 .. :try_end_0} :catch_0

    .line 1833
    invoke-virtual {v0}, Ljava/io/ByteArrayOutputStream;->toByteArray()[B

    move-result-object v0

    return-object v0

    .line 1830
    :catch_0
    move-exception v0

    .line 1831
    new-instance v1, Lcom/github/kevinsawicki/http/HttpRequest$HttpRequestException;

    invoke-direct {v1, v0}, Lcom/github/kevinsawicki/http/HttpRequest$HttpRequestException;-><init>(Ljava/io/IOException;)V

    throw v1
.end method

.method public cacheControl()Ljava/lang/String;
    .locals 1

    .prologue
    .line 2416
    const-string v0, "Cache-Control"

    invoke-virtual {p0, v0}, Lcom/github/kevinsawicki/http/HttpRequest;->header(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v0

    return-object v0
.end method

.method public charset()Ljava/lang/String;
    .locals 2

    .prologue
    .line 2319
    const-string v0, "Content-Type"

    const-string v1, "charset"

    invoke-virtual {p0, v0, v1}, Lcom/github/kevinsawicki/http/HttpRequest;->parameter(Ljava/lang/String;Ljava/lang/String;)Ljava/lang/String;

    move-result-object v0

    return-object v0
.end method

.method public chunk(I)Lcom/github/kevinsawicki/http/HttpRequest;
    .locals 1

    .prologue
    .line 1682
    invoke-virtual {p0}, Lcom/github/kevinsawicki/http/HttpRequest;->getConnection()Ljava/net/HttpURLConnection;

    move-result-object v0

    invoke-virtual {v0, p1}, Ljava/net/HttpURLConnection;->setChunkedStreamingMode(I)V

    .line 1683
    return-object p0
.end method

.method protected closeOutput()Lcom/github/kevinsawicki/http/HttpRequest;
    .locals 3
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljava/io/IOException;
        }
    .end annotation

    .prologue
    const/4 v2, 0x0

    .line 2684
    invoke-virtual {p0, v2}, Lcom/github/kevinsawicki/http/HttpRequest;->progress(Lcom/github/kevinsawicki/http/HttpRequest$UploadProgress;)Lcom/github/kevinsawicki/http/HttpRequest;

    .line 2685
    iget-object v0, p0, Lcom/github/kevinsawicki/http/HttpRequest;->output:Lcom/github/kevinsawicki/http/HttpRequest$RequestOutputStream;

    if-nez v0, :cond_0

    .line 2698
    :goto_0
    return-object p0

    .line 2687
    :cond_0
    iget-boolean v0, p0, Lcom/github/kevinsawicki/http/HttpRequest;->multipart:Z

    if-eqz v0, :cond_1

    .line 2688
    iget-object v0, p0, Lcom/github/kevinsawicki/http/HttpRequest;->output:Lcom/github/kevinsawicki/http/HttpRequest$RequestOutputStream;

    const-string v1, "\r\n--00content0boundary00--\r\n"

    invoke-virtual {v0, v1}, Lcom/github/kevinsawicki/http/HttpRequest$RequestOutputStream;->write(Ljava/lang/String;)Lcom/github/kevinsawicki/http/HttpRequest$RequestOutputStream;

    .line 2689
    :cond_1
    iget-boolean v0, p0, Lcom/github/kevinsawicki/http/HttpRequest;->ignoreCloseExceptions:Z

    if-eqz v0, :cond_2

    .line 2691
    :try_start_0
    iget-object v0, p0, Lcom/github/kevinsawicki/http/HttpRequest;->output:Lcom/github/kevinsawicki/http/HttpRequest$RequestOutputStream;

    invoke-virtual {v0}, Lcom/github/kevinsawicki/http/HttpRequest$RequestOutputStream;->close()V
    :try_end_0
    .catch Ljava/io/IOException; {:try_start_0 .. :try_end_0} :catch_0

    .line 2697
    :goto_1
    iput-object v2, p0, Lcom/github/kevinsawicki/http/HttpRequest;->output:Lcom/github/kevinsawicki/http/HttpRequest$RequestOutputStream;

    goto :goto_0

    .line 2696
    :cond_2
    iget-object v0, p0, Lcom/github/kevinsawicki/http/HttpRequest;->output:Lcom/github/kevinsawicki/http/HttpRequest$RequestOutputStream;

    invoke-virtual {v0}, Lcom/github/kevinsawicki/http/HttpRequest$RequestOutputStream;->close()V

    goto :goto_1

    .line 2692
    :catch_0
    move-exception v0

    goto :goto_1
.end method

.method protected closeOutputQuietly()Lcom/github/kevinsawicki/http/HttpRequest;
    .locals 2
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Lcom/github/kevinsawicki/http/HttpRequest$HttpRequestException;
        }
    .end annotation

    .prologue
    .line 2710
    :try_start_0
    invoke-virtual {p0}, Lcom/github/kevinsawicki/http/HttpRequest;->closeOutput()Lcom/github/kevinsawicki/http/HttpRequest;
    :try_end_0
    .catch Ljava/io/IOException; {:try_start_0 .. :try_end_0} :catch_0

    move-result-object v0

    return-object v0

    .line 2711
    :catch_0
    move-exception v0

    .line 2712
    new-instance v1, Lcom/github/kevinsawicki/http/HttpRequest$HttpRequestException;

    invoke-direct {v1, v0}, Lcom/github/kevinsawicki/http/HttpRequest$HttpRequestException;-><init>(Ljava/io/IOException;)V

    throw v1
.end method

.method public code()I
    .locals 2
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Lcom/github/kevinsawicki/http/HttpRequest$HttpRequestException;
        }
    .end annotation

    .prologue
    .line 1559
    :try_start_0
    invoke-virtual {p0}, Lcom/github/kevinsawicki/http/HttpRequest;->closeOutput()Lcom/github/kevinsawicki/http/HttpRequest;

    .line 1560
    invoke-virtual {p0}, Lcom/github/kevinsawicki/http/HttpRequest;->getConnection()Ljava/net/HttpURLConnection;

    move-result-object v0

    invoke-virtual {v0}, Ljava/net/HttpURLConnection;->getResponseCode()I
    :try_end_0
    .catch Ljava/io/IOException; {:try_start_0 .. :try_end_0} :catch_0

    move-result v0

    return v0

    .line 1561
    :catch_0
    move-exception v0

    .line 1562
    new-instance v1, Lcom/github/kevinsawicki/http/HttpRequest$HttpRequestException;

    invoke-direct {v1, v0}, Lcom/github/kevinsawicki/http/HttpRequest$HttpRequestException;-><init>(Ljava/io/IOException;)V

    throw v1
.end method

.method public code(Ljava/util/concurrent/atomic/AtomicInteger;)Lcom/github/kevinsawicki/http/HttpRequest;
    .locals 1
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Lcom/github/kevinsawicki/http/HttpRequest$HttpRequestException;
        }
    .end annotation

    .prologue
    .line 1576
    invoke-virtual {p0}, Lcom/github/kevinsawicki/http/HttpRequest;->code()I

    move-result v0

    invoke-virtual {p1, v0}, Ljava/util/concurrent/atomic/AtomicInteger;->set(I)V

    .line 1577
    return-object p0
.end method

.method public connectTimeout(I)Lcom/github/kevinsawicki/http/HttpRequest;
    .locals 1

    .prologue
    .line 2054
    invoke-virtual {p0}, Lcom/github/kevinsawicki/http/HttpRequest;->getConnection()Ljava/net/HttpURLConnection;

    move-result-object v0

    invoke-virtual {v0, p1}, Ljava/net/HttpURLConnection;->setConnectTimeout(I)V

    .line 2055
    return-object p0
.end method

.method public contentEncoding()Ljava/lang/String;
    .locals 1

    .prologue
    .line 2389
    const-string v0, "Content-Encoding"

    invoke-virtual {p0, v0}, Lcom/github/kevinsawicki/http/HttpRequest;->header(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v0

    return-object v0
.end method

.method public contentLength()I
    .locals 1

    .prologue
    .line 2560
    const-string v0, "Content-Length"

    invoke-virtual {p0, v0}, Lcom/github/kevinsawicki/http/HttpRequest;->intHeader(Ljava/lang/String;)I

    move-result v0

    return v0
.end method

.method public contentLength(I)Lcom/github/kevinsawicki/http/HttpRequest;
    .locals 1

    .prologue
    .line 2580
    invoke-virtual {p0}, Lcom/github/kevinsawicki/http/HttpRequest;->getConnection()Ljava/net/HttpURLConnection;

    move-result-object v0

    invoke-virtual {v0, p1}, Ljava/net/HttpURLConnection;->setFixedLengthStreamingMode(I)V

    .line 2581
    return-object p0
.end method

.method public contentLength(Ljava/lang/String;)Lcom/github/kevinsawicki/http/HttpRequest;
    .locals 1

    .prologue
    .line 2570
    invoke-static {p1}, Ljava/lang/Integer;->parseInt(Ljava/lang/String;)I

    move-result v0

    invoke-virtual {p0, v0}, Lcom/github/kevinsawicki/http/HttpRequest;->contentLength(I)Lcom/github/kevinsawicki/http/HttpRequest;

    move-result-object v0

    return-object v0
.end method

.method public contentType(Ljava/lang/String;)Lcom/github/kevinsawicki/http/HttpRequest;
    .locals 1

    .prologue
    .line 2527
    const/4 v0, 0x0

    invoke-virtual {p0, p1, v0}, Lcom/github/kevinsawicki/http/HttpRequest;->contentType(Ljava/lang/String;Ljava/lang/String;)Lcom/github/kevinsawicki/http/HttpRequest;

    move-result-object v0

    return-object v0
.end method

.method public contentType(Ljava/lang/String;Ljava/lang/String;)Lcom/github/kevinsawicki/http/HttpRequest;
    .locals 3

    .prologue
    .line 2538
    if-eqz p2, :cond_0

    invoke-virtual {p2}, Ljava/lang/String;->length()I

    move-result v0

    if-lez v0, :cond_0

    .line 2539
    const-string v0, "; charset="

    .line 2540
    const-string v0, "Content-Type"

    new-instance v1, Ljava/lang/StringBuilder;

    invoke-direct {v1}, Ljava/lang/StringBuilder;-><init>()V

    invoke-virtual {v1, p1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    const-string v2, "; charset="

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1, p2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v1

    invoke-virtual {p0, v0, v1}, Lcom/github/kevinsawicki/http/HttpRequest;->header(Ljava/lang/String;Ljava/lang/String;)Lcom/github/kevinsawicki/http/HttpRequest;

    move-result-object v0

    .line 2542
    :goto_0
    return-object v0

    :cond_0
    const-string v0, "Content-Type"

    invoke-virtual {p0, v0, p1}, Lcom/github/kevinsawicki/http/HttpRequest;->header(Ljava/lang/String;Ljava/lang/String;)Lcom/github/kevinsawicki/http/HttpRequest;

    move-result-object v0

    goto :goto_0
.end method

.method public contentType()Ljava/lang/String;
    .locals 1

    .prologue
    .line 2551
    const-string v0, "Content-Type"

    invoke-virtual {p0, v0}, Lcom/github/kevinsawicki/http/HttpRequest;->header(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v0

    return-object v0
.end method

.method protected copy(Ljava/io/InputStream;Ljava/io/OutputStream;)Lcom/github/kevinsawicki/http/HttpRequest;
    .locals 6
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljava/io/IOException;
        }
    .end annotation

    .prologue
    .line 2613
    new-instance v0, Lcom/github/kevinsawicki/http/HttpRequest$8;

    iget-boolean v3, p0, Lcom/github/kevinsawicki/http/HttpRequest;->ignoreCloseExceptions:Z

    move-object v1, p0

    move-object v2, p1

    move-object v4, p1

    move-object v5, p2

    invoke-direct/range {v0 .. v5}, Lcom/github/kevinsawicki/http/HttpRequest$8;-><init>(Lcom/github/kevinsawicki/http/HttpRequest;Ljava/io/Closeable;ZLjava/io/InputStream;Ljava/io/OutputStream;)V

    .line 2626
    invoke-virtual {v0}, Lcom/github/kevinsawicki/http/HttpRequest$8;->call()Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Lcom/github/kevinsawicki/http/HttpRequest;

    return-object v0
.end method

.method protected copy(Ljava/io/Reader;Ljava/io/Writer;)Lcom/github/kevinsawicki/http/HttpRequest;
    .locals 6
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljava/io/IOException;
        }
    .end annotation

    .prologue
    .line 2639
    new-instance v0, Lcom/github/kevinsawicki/http/HttpRequest$9;

    iget-boolean v3, p0, Lcom/github/kevinsawicki/http/HttpRequest;->ignoreCloseExceptions:Z

    move-object v1, p0

    move-object v2, p1

    move-object v4, p1

    move-object v5, p2

    invoke-direct/range {v0 .. v5}, Lcom/github/kevinsawicki/http/HttpRequest$9;-><init>(Lcom/github/kevinsawicki/http/HttpRequest;Ljava/io/Closeable;ZLjava/io/Reader;Ljava/io/Writer;)V

    .line 2652
    invoke-virtual {v0}, Lcom/github/kevinsawicki/http/HttpRequest$9;->call()Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Lcom/github/kevinsawicki/http/HttpRequest;

    return-object v0
.end method

.method public created()Z
    .locals 2
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Lcom/github/kevinsawicki/http/HttpRequest$HttpRequestException;
        }
    .end annotation

    .prologue
    .line 1597
    const/16 v0, 0xc9

    invoke-virtual {p0}, Lcom/github/kevinsawicki/http/HttpRequest;->code()I

    move-result v1

    if-ne v0, v1, :cond_0

    const/4 v0, 0x1

    :goto_0
    return v0

    :cond_0
    const/4 v0, 0x0

    goto :goto_0
.end method

.method public date()J
    .locals 2

    .prologue
    .line 2407
    const-string v0, "Date"

    invoke-virtual {p0, v0}, Lcom/github/kevinsawicki/http/HttpRequest;->dateHeader(Ljava/lang/String;)J

    move-result-wide v0

    return-wide v0
.end method

.method public dateHeader(Ljava/lang/String;)J
    .locals 2
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Lcom/github/kevinsawicki/http/HttpRequest$HttpRequestException;
        }
    .end annotation

    .prologue
    .line 2137
    const-wide/16 v0, -0x1

    invoke-virtual {p0, p1, v0, v1}, Lcom/github/kevinsawicki/http/HttpRequest;->dateHeader(Ljava/lang/String;J)J

    move-result-wide v0

    return-wide v0
.end method

.method public dateHeader(Ljava/lang/String;J)J
    .locals 2
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Lcom/github/kevinsawicki/http/HttpRequest$HttpRequestException;
        }
    .end annotation

    .prologue
    .line 2151
    invoke-virtual {p0}, Lcom/github/kevinsawicki/http/HttpRequest;->closeOutputQuietly()Lcom/github/kevinsawicki/http/HttpRequest;

    .line 2152
    invoke-virtual {p0}, Lcom/github/kevinsawicki/http/HttpRequest;->getConnection()Ljava/net/HttpURLConnection;

    move-result-object v0

    invoke-virtual {v0, p1, p2, p3}, Ljava/net/HttpURLConnection;->getHeaderFieldDate(Ljava/lang/String;J)J

    move-result-wide v0

    return-wide v0
.end method

.method public disconnect()Lcom/github/kevinsawicki/http/HttpRequest;
    .locals 1

    .prologue
    .line 1671
    invoke-virtual {p0}, Lcom/github/kevinsawicki/http/HttpRequest;->getConnection()Ljava/net/HttpURLConnection;

    move-result-object v0

    invoke-virtual {v0}, Ljava/net/HttpURLConnection;->disconnect()V

    .line 1672
    return-object p0
.end method

.method public eTag()Ljava/lang/String;
    .locals 1

    .prologue
    .line 2425
    const-string v0, "ETag"

    invoke-virtual {p0, v0}, Lcom/github/kevinsawicki/http/HttpRequest;->header(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v0

    return-object v0
.end method

.method public expires()J
    .locals 2

    .prologue
    .line 2434
    const-string v0, "Expires"

    invoke-virtual {p0, v0}, Lcom/github/kevinsawicki/http/HttpRequest;->dateHeader(Ljava/lang/String;)J

    move-result-wide v0

    return-wide v0
.end method

.method public followRedirects(Z)Lcom/github/kevinsawicki/http/HttpRequest;
    .locals 1

    .prologue
    .line 3256
    invoke-virtual {p0}, Lcom/github/kevinsawicki/http/HttpRequest;->getConnection()Ljava/net/HttpURLConnection;

    move-result-object v0

    invoke-virtual {v0, p1}, Ljava/net/HttpURLConnection;->setInstanceFollowRedirects(Z)V

    .line 3257
    return-object p0
.end method

.method public form(Ljava/lang/Object;Ljava/lang/Object;)Lcom/github/kevinsawicki/http/HttpRequest;
    .locals 1
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Lcom/github/kevinsawicki/http/HttpRequest$HttpRequestException;
        }
    .end annotation

    .prologue
    .line 3127
    const-string v0, "UTF-8"

    invoke-virtual {p0, p1, p2, v0}, Lcom/github/kevinsawicki/http/HttpRequest;->form(Ljava/lang/Object;Ljava/lang/Object;Ljava/lang/String;)Lcom/github/kevinsawicki/http/HttpRequest;

    move-result-object v0

    return-object v0
.end method

.method public form(Ljava/lang/Object;Ljava/lang/Object;Ljava/lang/String;)Lcom/github/kevinsawicki/http/HttpRequest;
    .locals 3
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Lcom/github/kevinsawicki/http/HttpRequest$HttpRequestException;
        }
    .end annotation

    .prologue
    const/4 v1, 0x1

    .line 3144
    iget-boolean v0, p0, Lcom/github/kevinsawicki/http/HttpRequest;->form:Z

    if-nez v0, :cond_3

    move v0, v1

    .line 3145
    :goto_0
    if-eqz v0, :cond_0

    .line 3146
    const-string v2, "application/x-www-form-urlencoded"

    invoke-virtual {p0, v2, p3}, Lcom/github/kevinsawicki/http/HttpRequest;->contentType(Ljava/lang/String;Ljava/lang/String;)Lcom/github/kevinsawicki/http/HttpRequest;

    .line 3147
    iput-boolean v1, p0, Lcom/github/kevinsawicki/http/HttpRequest;->form:Z

    .line 3149
    :cond_0
    invoke-static {p3}, Lcom/github/kevinsawicki/http/HttpRequest;->getValidCharset(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v1

    .line 3151
    :try_start_0
    invoke-virtual {p0}, Lcom/github/kevinsawicki/http/HttpRequest;->openOutput()Lcom/github/kevinsawicki/http/HttpRequest;

    .line 3152
    if-nez v0, :cond_1

    .line 3153
    iget-object v0, p0, Lcom/github/kevinsawicki/http/HttpRequest;->output:Lcom/github/kevinsawicki/http/HttpRequest$RequestOutputStream;

    const/16 v2, 0x26

    invoke-virtual {v0, v2}, Lcom/github/kevinsawicki/http/HttpRequest$RequestOutputStream;->write(I)V

    .line 3154
    :cond_1
    iget-object v0, p0, Lcom/github/kevinsawicki/http/HttpRequest;->output:Lcom/github/kevinsawicki/http/HttpRequest$RequestOutputStream;

    invoke-virtual {p1}, Ljava/lang/Object;->toString()Ljava/lang/String;

    move-result-object v2

    invoke-static {v2, v1}, Ljava/net/URLEncoder;->encode(Ljava/lang/String;Ljava/lang/String;)Ljava/lang/String;

    move-result-object v2

    invoke-virtual {v0, v2}, Lcom/github/kevinsawicki/http/HttpRequest$RequestOutputStream;->write(Ljava/lang/String;)Lcom/github/kevinsawicki/http/HttpRequest$RequestOutputStream;

    .line 3155
    iget-object v0, p0, Lcom/github/kevinsawicki/http/HttpRequest;->output:Lcom/github/kevinsawicki/http/HttpRequest$RequestOutputStream;

    const/16 v2, 0x3d

    invoke-virtual {v0, v2}, Lcom/github/kevinsawicki/http/HttpRequest$RequestOutputStream;->write(I)V

    .line 3156
    if-eqz p2, :cond_2

    .line 3157
    iget-object v0, p0, Lcom/github/kevinsawicki/http/HttpRequest;->output:Lcom/github/kevinsawicki/http/HttpRequest$RequestOutputStream;

    invoke-virtual {p2}, Ljava/lang/Object;->toString()Ljava/lang/String;

    move-result-object v2

    invoke-static {v2, v1}, Ljava/net/URLEncoder;->encode(Ljava/lang/String;Ljava/lang/String;)Ljava/lang/String;

    move-result-object v1

    invoke-virtual {v0, v1}, Lcom/github/kevinsawicki/http/HttpRequest$RequestOutputStream;->write(Ljava/lang/String;)Lcom/github/kevinsawicki/http/HttpRequest$RequestOutputStream;
    :try_end_0
    .catch Ljava/io/IOException; {:try_start_0 .. :try_end_0} :catch_0

    .line 3161
    :cond_2
    return-object p0

    .line 3144
    :cond_3
    const/4 v0, 0x0

    goto :goto_0

    .line 3158
    :catch_0
    move-exception v0

    .line 3159
    new-instance v1, Lcom/github/kevinsawicki/http/HttpRequest$HttpRequestException;

    invoke-direct {v1, v0}, Lcom/github/kevinsawicki/http/HttpRequest$HttpRequestException;-><init>(Ljava/io/IOException;)V

    throw v1
.end method

.method public form(Ljava/util/Map$Entry;)Lcom/github/kevinsawicki/http/HttpRequest;
    .locals 1
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "(",
            "Ljava/util/Map$Entry",
            "<**>;)",
            "Lcom/github/kevinsawicki/http/HttpRequest;"
        }
    .end annotation

    .annotation system Ldalvik/annotation/Throws;
        value = {
            Lcom/github/kevinsawicki/http/HttpRequest$HttpRequestException;
        }
    .end annotation

    .prologue
    .line 3095
    const-string v0, "UTF-8"

    invoke-virtual {p0, p1, v0}, Lcom/github/kevinsawicki/http/HttpRequest;->form(Ljava/util/Map$Entry;Ljava/lang/String;)Lcom/github/kevinsawicki/http/HttpRequest;

    move-result-object v0

    return-object v0
.end method

.method public form(Ljava/util/Map$Entry;Ljava/lang/String;)Lcom/github/kevinsawicki/http/HttpRequest;
    .locals 2
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "(",
            "Ljava/util/Map$Entry",
            "<**>;",
            "Ljava/lang/String;",
            ")",
            "Lcom/github/kevinsawicki/http/HttpRequest;"
        }
    .end annotation

    .annotation system Ldalvik/annotation/Throws;
        value = {
            Lcom/github/kevinsawicki/http/HttpRequest$HttpRequestException;
        }
    .end annotation

    .prologue
    .line 3111
    invoke-interface {p1}, Ljava/util/Map$Entry;->getKey()Ljava/lang/Object;

    move-result-object v0

    invoke-interface {p1}, Ljava/util/Map$Entry;->getValue()Ljava/lang/Object;

    move-result-object v1

    invoke-virtual {p0, v0, v1, p2}, Lcom/github/kevinsawicki/http/HttpRequest;->form(Ljava/lang/Object;Ljava/lang/Object;Ljava/lang/String;)Lcom/github/kevinsawicki/http/HttpRequest;

    move-result-object v0

    return-object v0
.end method

.method public form(Ljava/util/Map;)Lcom/github/kevinsawicki/http/HttpRequest;
    .locals 1
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "(",
            "Ljava/util/Map",
            "<**>;)",
            "Lcom/github/kevinsawicki/http/HttpRequest;"
        }
    .end annotation

    .annotation system Ldalvik/annotation/Throws;
        value = {
            Lcom/github/kevinsawicki/http/HttpRequest$HttpRequestException;
        }
    .end annotation

    .prologue
    .line 3081
    const-string v0, "UTF-8"

    invoke-virtual {p0, p1, v0}, Lcom/github/kevinsawicki/http/HttpRequest;->form(Ljava/util/Map;Ljava/lang/String;)Lcom/github/kevinsawicki/http/HttpRequest;

    move-result-object v0

    return-object v0
.end method

.method public form(Ljava/util/Map;Ljava/lang/String;)Lcom/github/kevinsawicki/http/HttpRequest;
    .locals 2
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "(",
            "Ljava/util/Map",
            "<**>;",
            "Ljava/lang/String;",
            ")",
            "Lcom/github/kevinsawicki/http/HttpRequest;"
        }
    .end annotation

    .annotation system Ldalvik/annotation/Throws;
        value = {
            Lcom/github/kevinsawicki/http/HttpRequest$HttpRequestException;
        }
    .end annotation

    .prologue
    .line 3174
    invoke-interface {p1}, Ljava/util/Map;->isEmpty()Z

    move-result v0

    if-nez v0, :cond_0

    .line 3175
    invoke-interface {p1}, Ljava/util/Map;->entrySet()Ljava/util/Set;

    move-result-object v0

    invoke-interface {v0}, Ljava/util/Set;->iterator()Ljava/util/Iterator;

    move-result-object v1

    :goto_0
    invoke-interface {v1}, Ljava/util/Iterator;->hasNext()Z

    move-result v0

    if-eqz v0, :cond_0

    invoke-interface {v1}, Ljava/util/Iterator;->next()Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Ljava/util/Map$Entry;

    .line 3176
    invoke-virtual {p0, v0, p2}, Lcom/github/kevinsawicki/http/HttpRequest;->form(Ljava/util/Map$Entry;Ljava/lang/String;)Lcom/github/kevinsawicki/http/HttpRequest;

    goto :goto_0

    .line 3177
    :cond_0
    return-object p0
.end method

.method public getConnection()Ljava/net/HttpURLConnection;
    .locals 1

    .prologue
    .line 1522
    iget-object v0, p0, Lcom/github/kevinsawicki/http/HttpRequest;->connection:Ljava/net/HttpURLConnection;

    if-nez v0, :cond_0

    .line 1523
    invoke-direct {p0}, Lcom/github/kevinsawicki/http/HttpRequest;->createConnection()Ljava/net/HttpURLConnection;

    move-result-object v0

    iput-object v0, p0, Lcom/github/kevinsawicki/http/HttpRequest;->connection:Ljava/net/HttpURLConnection;

    .line 1524
    :cond_0
    iget-object v0, p0, Lcom/github/kevinsawicki/http/HttpRequest;->connection:Ljava/net/HttpURLConnection;

    return-object v0
.end method

.method protected getParam(Ljava/lang/String;Ljava/lang/String;)Ljava/lang/String;
    .locals 9

    .prologue
    const/16 v7, 0x22

    const/4 v2, 0x0

    const/16 v6, 0x3b

    const/4 v5, -0x1

    .line 2278
    if-eqz p1, :cond_0

    invoke-virtual {p1}, Ljava/lang/String;->length()I

    move-result v0

    if-nez v0, :cond_2

    :cond_0
    move-object v0, v2

    .line 2310
    :cond_1
    :goto_0
    return-object v0

    .line 2281
    :cond_2
    invoke-virtual {p1}, Ljava/lang/String;->length()I

    move-result v1

    .line 2282
    invoke-virtual {p1, v6}, Ljava/lang/String;->indexOf(I)I

    move-result v0

    add-int/lit8 v3, v0, 0x1

    .line 2283
    if-eqz v3, :cond_3

    if-ne v3, v1, :cond_4

    :cond_3
    move-object v0, v2

    .line 2284
    goto :goto_0

    .line 2286
    :cond_4
    invoke-virtual {p1, v6, v3}, Ljava/lang/String;->indexOf(II)I

    move-result v0

    .line 2287
    if-ne v0, v5, :cond_8

    move v0, v3

    move v3, v1

    .line 2290
    :goto_1
    if-ge v0, v3, :cond_7

    .line 2291
    const/16 v4, 0x3d

    invoke-virtual {p1, v4, v0}, Ljava/lang/String;->indexOf(II)I

    move-result v4

    .line 2292
    if-eq v4, v5, :cond_5

    if-ge v4, v3, :cond_5

    .line 2293
    invoke-virtual {p1, v0, v4}, Ljava/lang/String;->substring(II)Ljava/lang/String;

    move-result-object v0

    invoke-virtual {v0}, Ljava/lang/String;->trim()Ljava/lang/String;

    move-result-object v0

    invoke-virtual {p2, v0}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v0

    if-eqz v0, :cond_5

    .line 2294
    add-int/lit8 v0, v4, 0x1

    invoke-virtual {p1, v0, v3}, Ljava/lang/String;->substring(II)Ljava/lang/String;

    move-result-object v0

    invoke-virtual {v0}, Ljava/lang/String;->trim()Ljava/lang/String;

    move-result-object v0

    .line 2295
    invoke-virtual {v0}, Ljava/lang/String;->length()I

    move-result v4

    .line 2296
    if-eqz v4, :cond_5

    .line 2297
    const/4 v1, 0x2

    if-le v4, v1, :cond_1

    const/4 v1, 0x0

    invoke-virtual {v0, v1}, Ljava/lang/String;->charAt(I)C

    move-result v1

    if-ne v7, v1, :cond_1

    add-int/lit8 v1, v4, -0x1

    .line 2298
    invoke-virtual {v0, v1}, Ljava/lang/String;->charAt(I)C

    move-result v1

    if-ne v7, v1, :cond_1

    .line 2299
    const/4 v1, 0x1

    add-int/lit8 v2, v4, -0x1

    invoke-virtual {v0, v1, v2}, Ljava/lang/String;->substring(II)Ljava/lang/String;

    move-result-object v0

    goto :goto_0

    .line 2304
    :cond_5
    add-int/lit8 v3, v3, 0x1

    .line 2305
    invoke-virtual {p1, v6, v3}, Ljava/lang/String;->indexOf(II)I

    move-result v0

    .line 2306
    if-ne v0, v5, :cond_6

    move v0, v1

    :cond_6
    move v8, v0

    move v0, v3

    move v3, v8

    .line 2308
    goto :goto_1

    :cond_7
    move-object v0, v2

    .line 2310
    goto :goto_0

    :cond_8
    move v8, v0

    move v0, v3

    move v3, v8

    goto :goto_1
.end method

.method protected getParams(Ljava/lang/String;)Ljava/util/Map;
    .locals 10
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "(",
            "Ljava/lang/String;",
            ")",
            "Ljava/util/Map",
            "<",
            "Ljava/lang/String;",
            "Ljava/lang/String;",
            ">;"
        }
    .end annotation

    .prologue
    const/16 v9, 0x22

    const/16 v8, 0x3b

    const/4 v7, -0x1

    .line 2232
    if-eqz p1, :cond_0

    invoke-virtual {p1}, Ljava/lang/String;->length()I

    move-result v0

    if-nez v0, :cond_1

    .line 2233
    :cond_0
    invoke-static {}, Ljava/util/Collections;->emptyMap()Ljava/util/Map;

    move-result-object v0

    .line 2267
    :goto_0
    return-object v0

    .line 2235
    :cond_1
    invoke-virtual {p1}, Ljava/lang/String;->length()I

    move-result v1

    .line 2236
    invoke-virtual {p1, v8}, Ljava/lang/String;->indexOf(I)I

    move-result v0

    add-int/lit8 v3, v0, 0x1

    .line 2237
    if-eqz v3, :cond_2

    if-ne v3, v1, :cond_3

    .line 2238
    :cond_2
    invoke-static {}, Ljava/util/Collections;->emptyMap()Ljava/util/Map;

    move-result-object v0

    goto :goto_0

    .line 2240
    :cond_3
    invoke-virtual {p1, v8, v3}, Ljava/lang/String;->indexOf(II)I

    move-result v0

    .line 2241
    if-ne v0, v7, :cond_4

    move v0, v1

    .line 2244
    :cond_4
    new-instance v2, Ljava/util/LinkedHashMap;

    invoke-direct {v2}, Ljava/util/LinkedHashMap;-><init>()V

    .line 2245
    :cond_5
    :goto_1
    if-ge v3, v0, :cond_8

    .line 2246
    const/16 v4, 0x3d

    invoke-virtual {p1, v4, v3}, Ljava/lang/String;->indexOf(II)I

    move-result v4

    .line 2247
    if-eq v4, v7, :cond_6

    if-ge v4, v0, :cond_6

    .line 2248
    invoke-virtual {p1, v3, v4}, Ljava/lang/String;->substring(II)Ljava/lang/String;

    move-result-object v3

    invoke-virtual {v3}, Ljava/lang/String;->trim()Ljava/lang/String;

    move-result-object v3

    .line 2249
    invoke-virtual {v3}, Ljava/lang/String;->length()I

    move-result v5

    if-lez v5, :cond_6

    .line 2250
    add-int/lit8 v4, v4, 0x1

    invoke-virtual {p1, v4, v0}, Ljava/lang/String;->substring(II)Ljava/lang/String;

    move-result-object v4

    invoke-virtual {v4}, Ljava/lang/String;->trim()Ljava/lang/String;

    move-result-object v4

    .line 2251
    invoke-virtual {v4}, Ljava/lang/String;->length()I

    move-result v5

    .line 2252
    if-eqz v5, :cond_6

    .line 2253
    const/4 v6, 0x2

    if-le v5, v6, :cond_7

    const/4 v6, 0x0

    invoke-virtual {v4, v6}, Ljava/lang/String;->charAt(I)C

    move-result v6

    if-ne v9, v6, :cond_7

    add-int/lit8 v6, v5, -0x1

    .line 2254
    invoke-virtual {v4, v6}, Ljava/lang/String;->charAt(I)C

    move-result v6

    if-ne v9, v6, :cond_7

    .line 2255
    const/4 v6, 0x1

    add-int/lit8 v5, v5, -0x1

    invoke-virtual {v4, v6, v5}, Ljava/lang/String;->substring(II)Ljava/lang/String;

    move-result-object v4

    invoke-interface {v2, v3, v4}, Ljava/util/Map;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    .line 2261
    :cond_6
    :goto_2
    add-int/lit8 v3, v0, 0x1

    .line 2262
    invoke-virtual {p1, v8, v3}, Ljava/lang/String;->indexOf(II)I

    move-result v0

    .line 2263
    if-ne v0, v7, :cond_5

    move v0, v1

    .line 2264
    goto :goto_1

    .line 2257
    :cond_7
    invoke-interface {v2, v3, v4}, Ljava/util/Map;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    goto :goto_2

    :cond_8
    move-object v0, v2

    .line 2267
    goto :goto_0
.end method

.method public header(Ljava/lang/String;Ljava/lang/Number;)Lcom/github/kevinsawicki/http/HttpRequest;
    .locals 1

    .prologue
    .line 2078
    if-eqz p2, :cond_0

    invoke-virtual {p2}, Ljava/lang/Object;->toString()Ljava/lang/String;

    move-result-object v0

    :goto_0
    invoke-virtual {p0, p1, v0}, Lcom/github/kevinsawicki/http/HttpRequest;->header(Ljava/lang/String;Ljava/lang/String;)Lcom/github/kevinsawicki/http/HttpRequest;

    move-result-object v0

    return-object v0

    :cond_0
    const/4 v0, 0x0

    goto :goto_0
.end method

.method public header(Ljava/lang/String;Ljava/lang/String;)Lcom/github/kevinsawicki/http/HttpRequest;
    .locals 1

    .prologue
    .line 2066
    invoke-virtual {p0}, Lcom/github/kevinsawicki/http/HttpRequest;->getConnection()Ljava/net/HttpURLConnection;

    move-result-object v0

    invoke-virtual {v0, p1, p2}, Ljava/net/HttpURLConnection;->setRequestProperty(Ljava/lang/String;Ljava/lang/String;)V

    .line 2067
    return-object p0
.end method

.method public header(Ljava/util/Map$Entry;)Lcom/github/kevinsawicki/http/HttpRequest;
    .locals 2
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "(",
            "Ljava/util/Map$Entry",
            "<",
            "Ljava/lang/String;",
            "Ljava/lang/String;",
            ">;)",
            "Lcom/github/kevinsawicki/http/HttpRequest;"
        }
    .end annotation

    .prologue
    .line 2102
    invoke-interface {p1}, Ljava/util/Map$Entry;->getKey()Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Ljava/lang/String;

    invoke-interface {p1}, Ljava/util/Map$Entry;->getValue()Ljava/lang/Object;

    move-result-object v1

    check-cast v1, Ljava/lang/String;

    invoke-virtual {p0, v0, v1}, Lcom/github/kevinsawicki/http/HttpRequest;->header(Ljava/lang/String;Ljava/lang/String;)Lcom/github/kevinsawicki/http/HttpRequest;

    move-result-object v0

    return-object v0
.end method

.method public header(Ljava/lang/String;)Ljava/lang/String;
    .locals 1
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Lcom/github/kevinsawicki/http/HttpRequest$HttpRequestException;
        }
    .end annotation

    .prologue
    .line 2113
    invoke-virtual {p0}, Lcom/github/kevinsawicki/http/HttpRequest;->closeOutputQuietly()Lcom/github/kevinsawicki/http/HttpRequest;

    .line 2114
    invoke-virtual {p0}, Lcom/github/kevinsawicki/http/HttpRequest;->getConnection()Ljava/net/HttpURLConnection;

    move-result-object v0

    invoke-virtual {v0, p1}, Ljava/net/HttpURLConnection;->getHeaderField(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v0

    return-object v0
.end method

.method public headers(Ljava/util/Map;)Lcom/github/kevinsawicki/http/HttpRequest;
    .locals 2
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "(",
            "Ljava/util/Map",
            "<",
            "Ljava/lang/String;",
            "Ljava/lang/String;",
            ">;)",
            "Lcom/github/kevinsawicki/http/HttpRequest;"
        }
    .end annotation

    .prologue
    .line 2089
    invoke-interface {p1}, Ljava/util/Map;->isEmpty()Z

    move-result v0

    if-nez v0, :cond_0

    .line 2090
    invoke-interface {p1}, Ljava/util/Map;->entrySet()Ljava/util/Set;

    move-result-object v0

    invoke-interface {v0}, Ljava/util/Set;->iterator()Ljava/util/Iterator;

    move-result-object v1

    :goto_0
    invoke-interface {v1}, Ljava/util/Iterator;->hasNext()Z

    move-result v0

    if-eqz v0, :cond_0

    invoke-interface {v1}, Ljava/util/Iterator;->next()Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Ljava/util/Map$Entry;

    .line 2091
    invoke-virtual {p0, v0}, Lcom/github/kevinsawicki/http/HttpRequest;->header(Ljava/util/Map$Entry;)Lcom/github/kevinsawicki/http/HttpRequest;

    goto :goto_0

    .line 2092
    :cond_0
    return-object p0
.end method

.method public headers()Ljava/util/Map;
    .locals 1
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "()",
            "Ljava/util/Map",
            "<",
            "Ljava/lang/String;",
            "Ljava/util/List",
            "<",
            "Ljava/lang/String;",
            ">;>;"
        }
    .end annotation

    .annotation system Ldalvik/annotation/Throws;
        value = {
            Lcom/github/kevinsawicki/http/HttpRequest$HttpRequestException;
        }
    .end annotation

    .prologue
    .line 2124
    invoke-virtual {p0}, Lcom/github/kevinsawicki/http/HttpRequest;->closeOutputQuietly()Lcom/github/kevinsawicki/http/HttpRequest;

    .line 2125
    invoke-virtual {p0}, Lcom/github/kevinsawicki/http/HttpRequest;->getConnection()Ljava/net/HttpURLConnection;

    move-result-object v0

    invoke-virtual {v0}, Ljava/net/HttpURLConnection;->getHeaderFields()Ljava/util/Map;

    move-result-object v0

    return-object v0
.end method

.method public headers(Ljava/lang/String;)[Ljava/lang/String;
    .locals 2

    .prologue
    .line 2190
    invoke-virtual {p0}, Lcom/github/kevinsawicki/http/HttpRequest;->headers()Ljava/util/Map;

    move-result-object v0

    .line 2191
    if-eqz v0, :cond_0

    invoke-interface {v0}, Ljava/util/Map;->isEmpty()Z

    move-result v1

    if-eqz v1, :cond_1

    .line 2192
    :cond_0
    sget-object v0, Lcom/github/kevinsawicki/http/HttpRequest;->EMPTY_STRINGS:[Ljava/lang/String;

    .line 2198
    :goto_0
    return-object v0

    .line 2194
    :cond_1
    invoke-interface {v0, p1}, Ljava/util/Map;->get(Ljava/lang/Object;)Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Ljava/util/List;

    .line 2195
    if-eqz v0, :cond_2

    invoke-interface {v0}, Ljava/util/List;->isEmpty()Z

    move-result v1

    if-nez v1, :cond_2

    .line 2196
    invoke-interface {v0}, Ljava/util/List;->size()I

    move-result v1

    new-array v1, v1, [Ljava/lang/String;

    invoke-interface {v0, v1}, Ljava/util/List;->toArray([Ljava/lang/Object;)[Ljava/lang/Object;

    move-result-object v0

    check-cast v0, [Ljava/lang/String;

    goto :goto_0

    .line 2198
    :cond_2
    sget-object v0, Lcom/github/kevinsawicki/http/HttpRequest;->EMPTY_STRINGS:[Ljava/lang/String;

    goto :goto_0
.end method

.method public ifModifiedSince(J)Lcom/github/kevinsawicki/http/HttpRequest;
    .locals 1

    .prologue
    .line 2506
    invoke-virtual {p0}, Lcom/github/kevinsawicki/http/HttpRequest;->getConnection()Ljava/net/HttpURLConnection;

    move-result-object v0

    invoke-virtual {v0, p1, p2}, Ljava/net/HttpURLConnection;->setIfModifiedSince(J)V

    .line 2507
    return-object p0
.end method

.method public ifNoneMatch(Ljava/lang/String;)Lcom/github/kevinsawicki/http/HttpRequest;
    .locals 1

    .prologue
    .line 2517
    const-string v0, "If-None-Match"

    invoke-virtual {p0, v0, p1}, Lcom/github/kevinsawicki/http/HttpRequest;->header(Ljava/lang/String;Ljava/lang/String;)Lcom/github/kevinsawicki/http/HttpRequest;

    move-result-object v0

    return-object v0
.end method

.method public ignoreCloseExceptions(Z)Lcom/github/kevinsawicki/http/HttpRequest;
    .locals 0

    .prologue
    .line 1537
    iput-boolean p1, p0, Lcom/github/kevinsawicki/http/HttpRequest;->ignoreCloseExceptions:Z

    .line 1538
    return-object p0
.end method

.method public ignoreCloseExceptions()Z
    .locals 1

    .prologue
    .line 1548
    iget-boolean v0, p0, Lcom/github/kevinsawicki/http/HttpRequest;->ignoreCloseExceptions:Z

    return v0
.end method

.method public intHeader(Ljava/lang/String;)I
    .locals 1
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Lcom/github/kevinsawicki/http/HttpRequest$HttpRequestException;
        }
    .end annotation

    .prologue
    .line 2164
    const/4 v0, -0x1

    invoke-virtual {p0, p1, v0}, Lcom/github/kevinsawicki/http/HttpRequest;->intHeader(Ljava/lang/String;I)I

    move-result v0

    return v0
.end method

.method public intHeader(Ljava/lang/String;I)I
    .locals 1
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Lcom/github/kevinsawicki/http/HttpRequest$HttpRequestException;
        }
    .end annotation

    .prologue
    .line 2179
    invoke-virtual {p0}, Lcom/github/kevinsawicki/http/HttpRequest;->closeOutputQuietly()Lcom/github/kevinsawicki/http/HttpRequest;

    .line 2180
    invoke-virtual {p0}, Lcom/github/kevinsawicki/http/HttpRequest;->getConnection()Ljava/net/HttpURLConnection;

    move-result-object v0

    invoke-virtual {v0, p1, p2}, Ljava/net/HttpURLConnection;->getHeaderFieldInt(Ljava/lang/String;I)I

    move-result v0

    return v0
.end method

.method public isBodyEmpty()Z
    .locals 1
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Lcom/github/kevinsawicki/http/HttpRequest$HttpRequestException;
        }
    .end annotation

    .prologue
    .line 1817
    invoke-virtual {p0}, Lcom/github/kevinsawicki/http/HttpRequest;->contentLength()I

    move-result v0

    if-nez v0, :cond_0

    const/4 v0, 0x1

    :goto_0
    return v0

    :cond_0
    const/4 v0, 0x0

    goto :goto_0
.end method

.method public lastModified()J
    .locals 2

    .prologue
    .line 2443
    const-string v0, "Last-Modified"

    invoke-virtual {p0, v0}, Lcom/github/kevinsawicki/http/HttpRequest;->dateHeader(Ljava/lang/String;)J

    move-result-wide v0

    return-wide v0
.end method

.method public location()Ljava/lang/String;
    .locals 1

    .prologue
    .line 2452
    const-string v0, "Location"

    invoke-virtual {p0, v0}, Lcom/github/kevinsawicki/http/HttpRequest;->header(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v0

    return-object v0
.end method

.method public message()Ljava/lang/String;
    .locals 2
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Lcom/github/kevinsawicki/http/HttpRequest$HttpRequestException;
        }
    .end annotation

    .prologue
    .line 1658
    :try_start_0
    invoke-virtual {p0}, Lcom/github/kevinsawicki/http/HttpRequest;->closeOutput()Lcom/github/kevinsawicki/http/HttpRequest;

    .line 1659
    invoke-virtual {p0}, Lcom/github/kevinsawicki/http/HttpRequest;->getConnection()Ljava/net/HttpURLConnection;

    move-result-object v0

    invoke-virtual {v0}, Ljava/net/HttpURLConnection;->getResponseMessage()Ljava/lang/String;
    :try_end_0
    .catch Ljava/io/IOException; {:try_start_0 .. :try_end_0} :catch_0

    move-result-object v0

    return-object v0

    .line 1660
    :catch_0
    move-exception v0

    .line 1661
    new-instance v1, Lcom/github/kevinsawicki/http/HttpRequest$HttpRequestException;

    invoke-direct {v1, v0}, Lcom/github/kevinsawicki/http/HttpRequest$HttpRequestException;-><init>(Ljava/io/IOException;)V

    throw v1
.end method

.method public method()Ljava/lang/String;
    .locals 1

    .prologue
    .line 3228
    invoke-virtual {p0}, Lcom/github/kevinsawicki/http/HttpRequest;->getConnection()Ljava/net/HttpURLConnection;

    move-result-object v0

    invoke-virtual {v0}, Ljava/net/HttpURLConnection;->getRequestMethod()Ljava/lang/String;

    move-result-object v0

    return-object v0
.end method

.method public noContent()Z
    .locals 2
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Lcom/github/kevinsawicki/http/HttpRequest$HttpRequestException;
        }
    .end annotation

    .prologue
    .line 1607
    const/16 v0, 0xcc

    invoke-virtual {p0}, Lcom/github/kevinsawicki/http/HttpRequest;->code()I

    move-result v1

    if-ne v0, v1, :cond_0

    const/4 v0, 0x1

    :goto_0
    return v0

    :cond_0
    const/4 v0, 0x0

    goto :goto_0
.end method

.method public notFound()Z
    .locals 2
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Lcom/github/kevinsawicki/http/HttpRequest$HttpRequestException;
        }
    .end annotation

    .prologue
    .line 1637
    const/16 v0, 0x194

    invoke-virtual {p0}, Lcom/github/kevinsawicki/http/HttpRequest;->code()I

    move-result v1

    if-ne v0, v1, :cond_0

    const/4 v0, 0x1

    :goto_0
    return v0

    :cond_0
    const/4 v0, 0x0

    goto :goto_0
.end method

.method public notModified()Z
    .locals 2
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Lcom/github/kevinsawicki/http/HttpRequest$HttpRequestException;
        }
    .end annotation

    .prologue
    .line 1647
    const/16 v0, 0x130

    invoke-virtual {p0}, Lcom/github/kevinsawicki/http/HttpRequest;->code()I

    move-result v1

    if-ne v0, v1, :cond_0

    const/4 v0, 0x1

    :goto_0
    return v0

    :cond_0
    const/4 v0, 0x0

    goto :goto_0
.end method

.method public ok()Z
    .locals 2
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Lcom/github/kevinsawicki/http/HttpRequest$HttpRequestException;
        }
    .end annotation

    .prologue
    .line 1587
    const/16 v0, 0xc8

    invoke-virtual {p0}, Lcom/github/kevinsawicki/http/HttpRequest;->code()I

    move-result v1

    if-ne v0, v1, :cond_0

    const/4 v0, 0x1

    :goto_0
    return v0

    :cond_0
    const/4 v0, 0x0

    goto :goto_0
.end method

.method protected openOutput()Lcom/github/kevinsawicki/http/HttpRequest;
    .locals 4
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljava/io/IOException;
        }
    .end annotation

    .prologue
    .line 2723
    iget-object v0, p0, Lcom/github/kevinsawicki/http/HttpRequest;->output:Lcom/github/kevinsawicki/http/HttpRequest$RequestOutputStream;

    if-eqz v0, :cond_0

    .line 2730
    :goto_0
    return-object p0

    .line 2725
    :cond_0
    invoke-virtual {p0}, Lcom/github/kevinsawicki/http/HttpRequest;->getConnection()Ljava/net/HttpURLConnection;

    move-result-object v0

    const/4 v1, 0x1

    invoke-virtual {v0, v1}, Ljava/net/HttpURLConnection;->setDoOutput(Z)V

    .line 2727
    invoke-virtual {p0}, Lcom/github/kevinsawicki/http/HttpRequest;->getConnection()Ljava/net/HttpURLConnection;

    move-result-object v0

    const-string v1, "Content-Type"

    invoke-virtual {v0, v1}, Ljava/net/HttpURLConnection;->getRequestProperty(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v0

    const-string v1, "charset"

    .line 2726
    invoke-virtual {p0, v0, v1}, Lcom/github/kevinsawicki/http/HttpRequest;->getParam(Ljava/lang/String;Ljava/lang/String;)Ljava/lang/String;

    move-result-object v0

    .line 2728
    new-instance v1, Lcom/github/kevinsawicki/http/HttpRequest$RequestOutputStream;

    invoke-virtual {p0}, Lcom/github/kevinsawicki/http/HttpRequest;->getConnection()Ljava/net/HttpURLConnection;

    move-result-object v2

    invoke-virtual {v2}, Ljava/net/HttpURLConnection;->getOutputStream()Ljava/io/OutputStream;

    move-result-object v2

    iget v3, p0, Lcom/github/kevinsawicki/http/HttpRequest;->bufferSize:I

    invoke-direct {v1, v2, v0, v3}, Lcom/github/kevinsawicki/http/HttpRequest$RequestOutputStream;-><init>(Ljava/io/OutputStream;Ljava/lang/String;I)V

    iput-object v1, p0, Lcom/github/kevinsawicki/http/HttpRequest;->output:Lcom/github/kevinsawicki/http/HttpRequest$RequestOutputStream;

    goto :goto_0
.end method

.method public parameter(Ljava/lang/String;Ljava/lang/String;)Ljava/lang/String;
    .locals 1

    .prologue
    .line 2209
    invoke-virtual {p0, p1}, Lcom/github/kevinsawicki/http/HttpRequest;->header(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v0

    invoke-virtual {p0, v0, p2}, Lcom/github/kevinsawicki/http/HttpRequest;->getParam(Ljava/lang/String;Ljava/lang/String;)Ljava/lang/String;

    move-result-object v0

    return-object v0
.end method

.method public parameters(Ljava/lang/String;)Ljava/util/Map;
    .locals 1
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "(",
            "Ljava/lang/String;",
            ")",
            "Ljava/util/Map",
            "<",
            "Ljava/lang/String;",
            "Ljava/lang/String;",
            ">;"
        }
    .end annotation

    .prologue
    .line 2222
    invoke-virtual {p0, p1}, Lcom/github/kevinsawicki/http/HttpRequest;->header(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v0

    invoke-virtual {p0, v0}, Lcom/github/kevinsawicki/http/HttpRequest;->getParams(Ljava/lang/String;)Ljava/util/Map;

    move-result-object v0

    return-object v0
.end method

.method public part(Ljava/lang/String;Ljava/io/File;)Lcom/github/kevinsawicki/http/HttpRequest;
    .locals 1
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Lcom/github/kevinsawicki/http/HttpRequest$HttpRequestException;
        }
    .end annotation

    .prologue
    .line 2869
    const/4 v0, 0x0

    invoke-virtual {p0, p1, v0, p2}, Lcom/github/kevinsawicki/http/HttpRequest;->part(Ljava/lang/String;Ljava/lang/String;Ljava/io/File;)Lcom/github/kevinsawicki/http/HttpRequest;

    move-result-object v0

    return-object v0
.end method

.method public part(Ljava/lang/String;Ljava/io/InputStream;)Lcom/github/kevinsawicki/http/HttpRequest;
    .locals 1
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Lcom/github/kevinsawicki/http/HttpRequest$HttpRequestException;
        }
    .end annotation

    .prologue
    const/4 v0, 0x0

    .line 2919
    invoke-virtual {p0, p1, v0, v0, p2}, Lcom/github/kevinsawicki/http/HttpRequest;->part(Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;Ljava/io/InputStream;)Lcom/github/kevinsawicki/http/HttpRequest;

    move-result-object v0

    return-object v0
.end method

.method public part(Ljava/lang/String;Ljava/lang/Number;)Lcom/github/kevinsawicki/http/HttpRequest;
    .locals 1
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Lcom/github/kevinsawicki/http/HttpRequest$HttpRequestException;
        }
    .end annotation

    .prologue
    .line 2842
    const/4 v0, 0x0

    invoke-virtual {p0, p1, v0, p2}, Lcom/github/kevinsawicki/http/HttpRequest;->part(Ljava/lang/String;Ljava/lang/String;Ljava/lang/Number;)Lcom/github/kevinsawicki/http/HttpRequest;

    move-result-object v0

    return-object v0
.end method

.method public part(Ljava/lang/String;Ljava/lang/String;)Lcom/github/kevinsawicki/http/HttpRequest;
    .locals 1

    .prologue
    .line 2792
    const/4 v0, 0x0

    invoke-virtual {p0, p1, v0, p2}, Lcom/github/kevinsawicki/http/HttpRequest;->part(Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;)Lcom/github/kevinsawicki/http/HttpRequest;

    move-result-object v0

    return-object v0
.end method

.method public part(Ljava/lang/String;Ljava/lang/String;Ljava/io/File;)Lcom/github/kevinsawicki/http/HttpRequest;
    .locals 1
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Lcom/github/kevinsawicki/http/HttpRequest$HttpRequestException;
        }
    .end annotation

    .prologue
    .line 2883
    const/4 v0, 0x0

    invoke-virtual {p0, p1, p2, v0, p3}, Lcom/github/kevinsawicki/http/HttpRequest;->part(Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;Ljava/io/File;)Lcom/github/kevinsawicki/http/HttpRequest;

    move-result-object v0

    return-object v0
.end method

.method public part(Ljava/lang/String;Ljava/lang/String;Ljava/lang/Number;)Lcom/github/kevinsawicki/http/HttpRequest;
    .locals 1
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Lcom/github/kevinsawicki/http/HttpRequest$HttpRequestException;
        }
    .end annotation

    .prologue
    .line 2856
    if-eqz p3, :cond_0

    invoke-virtual {p3}, Ljava/lang/Object;->toString()Ljava/lang/String;

    move-result-object v0

    :goto_0
    invoke-virtual {p0, p1, p2, v0}, Lcom/github/kevinsawicki/http/HttpRequest;->part(Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;)Lcom/github/kevinsawicki/http/HttpRequest;

    move-result-object v0

    return-object v0

    :cond_0
    const/4 v0, 0x0

    goto :goto_0
.end method

.method public part(Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;)Lcom/github/kevinsawicki/http/HttpRequest;
    .locals 1
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Lcom/github/kevinsawicki/http/HttpRequest$HttpRequestException;
        }
    .end annotation

    .prologue
    .line 2806
    const/4 v0, 0x0

    invoke-virtual {p0, p1, p2, v0, p3}, Lcom/github/kevinsawicki/http/HttpRequest;->part(Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;)Lcom/github/kevinsawicki/http/HttpRequest;

    move-result-object v0

    return-object v0
.end method

.method public part(Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;Ljava/io/File;)Lcom/github/kevinsawicki/http/HttpRequest;
    .locals 4
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Lcom/github/kevinsawicki/http/HttpRequest$HttpRequestException;
        }
    .end annotation

    .prologue
    .line 2901
    :try_start_0
    new-instance v0, Ljava/io/BufferedInputStream;

    new-instance v1, Ljava/io/FileInputStream;

    invoke-direct {v1, p4}, Ljava/io/FileInputStream;-><init>(Ljava/io/File;)V

    invoke-direct {v0, v1}, Ljava/io/BufferedInputStream;-><init>(Ljava/io/InputStream;)V

    .line 2902
    invoke-virtual {p4}, Ljava/io/File;->length()J

    move-result-wide v2

    invoke-direct {p0, v2, v3}, Lcom/github/kevinsawicki/http/HttpRequest;->incrementTotalSize(J)Lcom/github/kevinsawicki/http/HttpRequest;
    :try_end_0
    .catch Ljava/io/IOException; {:try_start_0 .. :try_end_0} :catch_0

    .line 2906
    invoke-virtual {p0, p1, p2, p3, v0}, Lcom/github/kevinsawicki/http/HttpRequest;->part(Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;Ljava/io/InputStream;)Lcom/github/kevinsawicki/http/HttpRequest;

    move-result-object v0

    return-object v0

    .line 2903
    :catch_0
    move-exception v0

    .line 2904
    new-instance v1, Lcom/github/kevinsawicki/http/HttpRequest$HttpRequestException;

    invoke-direct {v1, v0}, Lcom/github/kevinsawicki/http/HttpRequest$HttpRequestException;-><init>(Ljava/io/IOException;)V

    throw v1
.end method

.method public part(Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;Ljava/io/InputStream;)Lcom/github/kevinsawicki/http/HttpRequest;
    .locals 2
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Lcom/github/kevinsawicki/http/HttpRequest$HttpRequestException;
        }
    .end annotation

    .prologue
    .line 2937
    :try_start_0
    invoke-virtual {p0}, Lcom/github/kevinsawicki/http/HttpRequest;->startPart()Lcom/github/kevinsawicki/http/HttpRequest;

    .line 2938
    invoke-virtual {p0, p1, p2, p3}, Lcom/github/kevinsawicki/http/HttpRequest;->writePartHeader(Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;)Lcom/github/kevinsawicki/http/HttpRequest;

    .line 2939
    iget-object v0, p0, Lcom/github/kevinsawicki/http/HttpRequest;->output:Lcom/github/kevinsawicki/http/HttpRequest$RequestOutputStream;

    invoke-virtual {p0, p4, v0}, Lcom/github/kevinsawicki/http/HttpRequest;->copy(Ljava/io/InputStream;Ljava/io/OutputStream;)Lcom/github/kevinsawicki/http/HttpRequest;
    :try_end_0
    .catch Ljava/io/IOException; {:try_start_0 .. :try_end_0} :catch_0

    .line 2943
    return-object p0

    .line 2940
    :catch_0
    move-exception v0

    .line 2941
    new-instance v1, Lcom/github/kevinsawicki/http/HttpRequest$HttpRequestException;

    invoke-direct {v1, v0}, Lcom/github/kevinsawicki/http/HttpRequest$HttpRequestException;-><init>(Ljava/io/IOException;)V

    throw v1
.end method

.method public part(Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;)Lcom/github/kevinsawicki/http/HttpRequest;
    .locals 2
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Lcom/github/kevinsawicki/http/HttpRequest$HttpRequestException;
        }
    .end annotation

    .prologue
    .line 2823
    :try_start_0
    invoke-virtual {p0}, Lcom/github/kevinsawicki/http/HttpRequest;->startPart()Lcom/github/kevinsawicki/http/HttpRequest;

    .line 2824
    invoke-virtual {p0, p1, p2, p3}, Lcom/github/kevinsawicki/http/HttpRequest;->writePartHeader(Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;)Lcom/github/kevinsawicki/http/HttpRequest;

    .line 2825
    iget-object v0, p0, Lcom/github/kevinsawicki/http/HttpRequest;->output:Lcom/github/kevinsawicki/http/HttpRequest$RequestOutputStream;

    invoke-virtual {v0, p4}, Lcom/github/kevinsawicki/http/HttpRequest$RequestOutputStream;->write(Ljava/lang/String;)Lcom/github/kevinsawicki/http/HttpRequest$RequestOutputStream;
    :try_end_0
    .catch Ljava/io/IOException; {:try_start_0 .. :try_end_0} :catch_0

    .line 2829
    return-object p0

    .line 2826
    :catch_0
    move-exception v0

    .line 2827
    new-instance v1, Lcom/github/kevinsawicki/http/HttpRequest$HttpRequestException;

    invoke-direct {v1, v0}, Lcom/github/kevinsawicki/http/HttpRequest$HttpRequestException;-><init>(Ljava/io/IOException;)V

    throw v1
.end method

.method public partHeader(Ljava/lang/String;Ljava/lang/String;)Lcom/github/kevinsawicki/http/HttpRequest;
    .locals 2
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Lcom/github/kevinsawicki/http/HttpRequest$HttpRequestException;
        }
    .end annotation

    .prologue
    .line 2956
    invoke-virtual {p0, p1}, Lcom/github/kevinsawicki/http/HttpRequest;->send(Ljava/lang/CharSequence;)Lcom/github/kevinsawicki/http/HttpRequest;

    move-result-object v0

    const-string v1, ": "

    invoke-virtual {v0, v1}, Lcom/github/kevinsawicki/http/HttpRequest;->send(Ljava/lang/CharSequence;)Lcom/github/kevinsawicki/http/HttpRequest;

    move-result-object v0

    invoke-virtual {v0, p2}, Lcom/github/kevinsawicki/http/HttpRequest;->send(Ljava/lang/CharSequence;)Lcom/github/kevinsawicki/http/HttpRequest;

    move-result-object v0

    const-string v1, "\r\n"

    invoke-virtual {v0, v1}, Lcom/github/kevinsawicki/http/HttpRequest;->send(Ljava/lang/CharSequence;)Lcom/github/kevinsawicki/http/HttpRequest;

    move-result-object v0

    return-object v0
.end method

.method public progress(Lcom/github/kevinsawicki/http/HttpRequest$UploadProgress;)Lcom/github/kevinsawicki/http/HttpRequest;
    .locals 1

    .prologue
    .line 2662
    if-nez p1, :cond_0

    .line 2663
    sget-object v0, Lcom/github/kevinsawicki/http/HttpRequest$UploadProgress;->DEFAULT:Lcom/github/kevinsawicki/http/HttpRequest$UploadProgress;

    iput-object v0, p0, Lcom/github/kevinsawicki/http/HttpRequest;->progress:Lcom/github/kevinsawicki/http/HttpRequest$UploadProgress;

    .line 2666
    :goto_0
    return-object p0

    .line 2665
    :cond_0
    iput-object p1, p0, Lcom/github/kevinsawicki/http/HttpRequest;->progress:Lcom/github/kevinsawicki/http/HttpRequest$UploadProgress;

    goto :goto_0
.end method

.method public proxyAuthorization(Ljava/lang/String;)Lcom/github/kevinsawicki/http/HttpRequest;
    .locals 1

    .prologue
    .line 2472
    const-string v0, "Proxy-Authorization"

    invoke-virtual {p0, v0, p1}, Lcom/github/kevinsawicki/http/HttpRequest;->header(Ljava/lang/String;Ljava/lang/String;)Lcom/github/kevinsawicki/http/HttpRequest;

    move-result-object v0

    return-object v0
.end method

.method public proxyBasic(Ljava/lang/String;Ljava/lang/String;)Lcom/github/kevinsawicki/http/HttpRequest;
    .locals 3

    .prologue
    .line 2496
    new-instance v0, Ljava/lang/StringBuilder;

    invoke-direct {v0}, Ljava/lang/StringBuilder;-><init>()V

    const-string v1, "Basic "

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    new-instance v1, Ljava/lang/StringBuilder;

    invoke-direct {v1}, Ljava/lang/StringBuilder;-><init>()V

    invoke-virtual {v1, p1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    const/16 v2, 0x3a

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(C)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1, p2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v1

    invoke-static {v1}, Lcom/github/kevinsawicki/http/HttpRequest$Base64;->encode(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v1

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-virtual {v0}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v0

    invoke-virtual {p0, v0}, Lcom/github/kevinsawicki/http/HttpRequest;->proxyAuthorization(Ljava/lang/String;)Lcom/github/kevinsawicki/http/HttpRequest;

    move-result-object v0

    return-object v0
.end method

.method public readTimeout(I)Lcom/github/kevinsawicki/http/HttpRequest;
    .locals 1

    .prologue
    .line 2043
    invoke-virtual {p0}, Lcom/github/kevinsawicki/http/HttpRequest;->getConnection()Ljava/net/HttpURLConnection;

    move-result-object v0

    invoke-virtual {v0, p1}, Ljava/net/HttpURLConnection;->setReadTimeout(I)V

    .line 2044
    return-object p0
.end method

.method public reader()Ljava/io/InputStreamReader;
    .locals 1
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Lcom/github/kevinsawicki/http/HttpRequest$HttpRequestException;
        }
    .end annotation

    .prologue
    .line 1911
    invoke-virtual {p0}, Lcom/github/kevinsawicki/http/HttpRequest;->charset()Ljava/lang/String;

    move-result-object v0

    invoke-virtual {p0, v0}, Lcom/github/kevinsawicki/http/HttpRequest;->reader(Ljava/lang/String;)Ljava/io/InputStreamReader;

    move-result-object v0

    return-object v0
.end method

.method public reader(Ljava/lang/String;)Ljava/io/InputStreamReader;
    .locals 3
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Lcom/github/kevinsawicki/http/HttpRequest$HttpRequestException;
        }
    .end annotation

    .prologue
    .line 1897
    :try_start_0
    new-instance v0, Ljava/io/InputStreamReader;

    invoke-virtual {p0}, Lcom/github/kevinsawicki/http/HttpRequest;->stream()Ljava/io/InputStream;

    move-result-object v1

    invoke-static {p1}, Lcom/github/kevinsawicki/http/HttpRequest;->getValidCharset(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v2

    invoke-direct {v0, v1, v2}, Ljava/io/InputStreamReader;-><init>(Ljava/io/InputStream;Ljava/lang/String;)V
    :try_end_0
    .catch Ljava/io/UnsupportedEncodingException; {:try_start_0 .. :try_end_0} :catch_0

    return-object v0

    .line 1898
    :catch_0
    move-exception v0

    .line 1899
    new-instance v1, Lcom/github/kevinsawicki/http/HttpRequest$HttpRequestException;

    invoke-direct {v1, v0}, Lcom/github/kevinsawicki/http/HttpRequest$HttpRequestException;-><init>(Ljava/io/IOException;)V

    throw v1
.end method

.method public receive(Ljava/io/File;)Lcom/github/kevinsawicki/http/HttpRequest;
    .locals 3
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Lcom/github/kevinsawicki/http/HttpRequest$HttpRequestException;
        }
    .end annotation

    .prologue
    .line 1951
    :try_start_0
    new-instance v0, Ljava/io/BufferedOutputStream;

    new-instance v1, Ljava/io/FileOutputStream;

    invoke-direct {v1, p1}, Ljava/io/FileOutputStream;-><init>(Ljava/io/File;)V

    iget v2, p0, Lcom/github/kevinsawicki/http/HttpRequest;->bufferSize:I

    invoke-direct {v0, v1, v2}, Ljava/io/BufferedOutputStream;-><init>(Ljava/io/OutputStream;I)V
    :try_end_0
    .catch Ljava/io/FileNotFoundException; {:try_start_0 .. :try_end_0} :catch_0

    .line 1955
    new-instance v1, Lcom/github/kevinsawicki/http/HttpRequest$5;

    iget-boolean v2, p0, Lcom/github/kevinsawicki/http/HttpRequest;->ignoreCloseExceptions:Z

    invoke-direct {v1, p0, v0, v2, v0}, Lcom/github/kevinsawicki/http/HttpRequest$5;-><init>(Lcom/github/kevinsawicki/http/HttpRequest;Ljava/io/Closeable;ZLjava/io/OutputStream;)V

    .line 1961
    invoke-virtual {v1}, Lcom/github/kevinsawicki/http/HttpRequest$5;->call()Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Lcom/github/kevinsawicki/http/HttpRequest;

    return-object v0

    .line 1952
    :catch_0
    move-exception v0

    .line 1953
    new-instance v1, Lcom/github/kevinsawicki/http/HttpRequest$HttpRequestException;

    invoke-direct {v1, v0}, Lcom/github/kevinsawicki/http/HttpRequest$HttpRequestException;-><init>(Ljava/io/IOException;)V

    throw v1
.end method

.method public receive(Ljava/io/OutputStream;)Lcom/github/kevinsawicki/http/HttpRequest;
    .locals 2
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Lcom/github/kevinsawicki/http/HttpRequest$HttpRequestException;
        }
    .end annotation

    .prologue
    .line 1974
    :try_start_0
    invoke-virtual {p0}, Lcom/github/kevinsawicki/http/HttpRequest;->buffer()Ljava/io/BufferedInputStream;

    move-result-object v0

    invoke-virtual {p0, v0, p1}, Lcom/github/kevinsawicki/http/HttpRequest;->copy(Ljava/io/InputStream;Ljava/io/OutputStream;)Lcom/github/kevinsawicki/http/HttpRequest;
    :try_end_0
    .catch Ljava/io/IOException; {:try_start_0 .. :try_end_0} :catch_0

    move-result-object v0

    return-object v0

    .line 1975
    :catch_0
    move-exception v0

    .line 1976
    new-instance v1, Lcom/github/kevinsawicki/http/HttpRequest$HttpRequestException;

    invoke-direct {v1, v0}, Lcom/github/kevinsawicki/http/HttpRequest$HttpRequestException;-><init>(Ljava/io/IOException;)V

    throw v1
.end method

.method public receive(Ljava/io/PrintStream;)Lcom/github/kevinsawicki/http/HttpRequest;
    .locals 1
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Lcom/github/kevinsawicki/http/HttpRequest$HttpRequestException;
        }
    .end annotation

    .prologue
    .line 1989
    invoke-virtual {p0, p1}, Lcom/github/kevinsawicki/http/HttpRequest;->receive(Ljava/io/OutputStream;)Lcom/github/kevinsawicki/http/HttpRequest;

    move-result-object v0

    return-object v0
.end method

.method public receive(Ljava/io/Writer;)Lcom/github/kevinsawicki/http/HttpRequest;
    .locals 6
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Lcom/github/kevinsawicki/http/HttpRequest$HttpRequestException;
        }
    .end annotation

    .prologue
    .line 2026
    invoke-virtual {p0}, Lcom/github/kevinsawicki/http/HttpRequest;->bufferedReader()Ljava/io/BufferedReader;

    move-result-object v2

    .line 2027
    new-instance v0, Lcom/github/kevinsawicki/http/HttpRequest$7;

    iget-boolean v3, p0, Lcom/github/kevinsawicki/http/HttpRequest;->ignoreCloseExceptions:Z

    move-object v1, p0

    move-object v4, v2

    move-object v5, p1

    invoke-direct/range {v0 .. v5}, Lcom/github/kevinsawicki/http/HttpRequest$7;-><init>(Lcom/github/kevinsawicki/http/HttpRequest;Ljava/io/Closeable;ZLjava/io/BufferedReader;Ljava/io/Writer;)V

    .line 2033
    invoke-virtual {v0}, Lcom/github/kevinsawicki/http/HttpRequest$7;->call()Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Lcom/github/kevinsawicki/http/HttpRequest;

    return-object v0
.end method

.method public receive(Ljava/lang/Appendable;)Lcom/github/kevinsawicki/http/HttpRequest;
    .locals 6
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Lcom/github/kevinsawicki/http/HttpRequest$HttpRequestException;
        }
    .end annotation

    .prologue
    .line 2001
    invoke-virtual {p0}, Lcom/github/kevinsawicki/http/HttpRequest;->bufferedReader()Ljava/io/BufferedReader;

    move-result-object v2

    .line 2002
    new-instance v0, Lcom/github/kevinsawicki/http/HttpRequest$6;

    iget-boolean v3, p0, Lcom/github/kevinsawicki/http/HttpRequest;->ignoreCloseExceptions:Z

    move-object v1, p0

    move-object v4, v2

    move-object v5, p1

    invoke-direct/range {v0 .. v5}, Lcom/github/kevinsawicki/http/HttpRequest$6;-><init>(Lcom/github/kevinsawicki/http/HttpRequest;Ljava/io/Closeable;ZLjava/io/BufferedReader;Ljava/lang/Appendable;)V

    .line 2015
    invoke-virtual {v0}, Lcom/github/kevinsawicki/http/HttpRequest$6;->call()Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Lcom/github/kevinsawicki/http/HttpRequest;

    return-object v0
.end method

.method public referer(Ljava/lang/String;)Lcom/github/kevinsawicki/http/HttpRequest;
    .locals 1

    .prologue
    .line 2339
    const-string v0, "Referer"

    invoke-virtual {p0, v0, p1}, Lcom/github/kevinsawicki/http/HttpRequest;->header(Ljava/lang/String;Ljava/lang/String;)Lcom/github/kevinsawicki/http/HttpRequest;

    move-result-object v0

    return-object v0
.end method

.method public send(Ljava/io/File;)Lcom/github/kevinsawicki/http/HttpRequest;
    .locals 4
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Lcom/github/kevinsawicki/http/HttpRequest$HttpRequestException;
        }
    .end annotation

    .prologue
    .line 2969
    :try_start_0
    new-instance v0, Ljava/io/BufferedInputStream;

    new-instance v1, Ljava/io/FileInputStream;

    invoke-direct {v1, p1}, Ljava/io/FileInputStream;-><init>(Ljava/io/File;)V

    invoke-direct {v0, v1}, Ljava/io/BufferedInputStream;-><init>(Ljava/io/InputStream;)V

    .line 2970
    invoke-virtual {p1}, Ljava/io/File;->length()J

    move-result-wide v2

    invoke-direct {p0, v2, v3}, Lcom/github/kevinsawicki/http/HttpRequest;->incrementTotalSize(J)Lcom/github/kevinsawicki/http/HttpRequest;
    :try_end_0
    .catch Ljava/io/FileNotFoundException; {:try_start_0 .. :try_end_0} :catch_0

    .line 2974
    invoke-virtual {p0, v0}, Lcom/github/kevinsawicki/http/HttpRequest;->send(Ljava/io/InputStream;)Lcom/github/kevinsawicki/http/HttpRequest;

    move-result-object v0

    return-object v0

    .line 2971
    :catch_0
    move-exception v0

    .line 2972
    new-instance v1, Lcom/github/kevinsawicki/http/HttpRequest$HttpRequestException;

    invoke-direct {v1, v0}, Lcom/github/kevinsawicki/http/HttpRequest$HttpRequestException;-><init>(Ljava/io/IOException;)V

    throw v1
.end method

.method public send(Ljava/io/InputStream;)Lcom/github/kevinsawicki/http/HttpRequest;
    .locals 2
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Lcom/github/kevinsawicki/http/HttpRequest$HttpRequestException;
        }
    .end annotation

    .prologue
    .line 3001
    :try_start_0
    invoke-virtual {p0}, Lcom/github/kevinsawicki/http/HttpRequest;->openOutput()Lcom/github/kevinsawicki/http/HttpRequest;

    .line 3002
    iget-object v0, p0, Lcom/github/kevinsawicki/http/HttpRequest;->output:Lcom/github/kevinsawicki/http/HttpRequest$RequestOutputStream;

    invoke-virtual {p0, p1, v0}, Lcom/github/kevinsawicki/http/HttpRequest;->copy(Ljava/io/InputStream;Ljava/io/OutputStream;)Lcom/github/kevinsawicki/http/HttpRequest;
    :try_end_0
    .catch Ljava/io/IOException; {:try_start_0 .. :try_end_0} :catch_0

    .line 3006
    return-object p0

    .line 3003
    :catch_0
    move-exception v0

    .line 3004
    new-instance v1, Lcom/github/kevinsawicki/http/HttpRequest$HttpRequestException;

    invoke-direct {v1, v0}, Lcom/github/kevinsawicki/http/HttpRequest$HttpRequestException;-><init>(Ljava/io/IOException;)V

    throw v1
.end method

.method public send(Ljava/io/Reader;)Lcom/github/kevinsawicki/http/HttpRequest;
    .locals 3
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Lcom/github/kevinsawicki/http/HttpRequest$HttpRequestException;
        }
    .end annotation

    .prologue
    .line 3020
    :try_start_0
    invoke-virtual {p0}, Lcom/github/kevinsawicki/http/HttpRequest;->openOutput()Lcom/github/kevinsawicki/http/HttpRequest;
    :try_end_0
    .catch Ljava/io/IOException; {:try_start_0 .. :try_end_0} :catch_0

    .line 3024
    new-instance v0, Ljava/io/OutputStreamWriter;

    iget-object v1, p0, Lcom/github/kevinsawicki/http/HttpRequest;->output:Lcom/github/kevinsawicki/http/HttpRequest$RequestOutputStream;

    iget-object v2, p0, Lcom/github/kevinsawicki/http/HttpRequest;->output:Lcom/github/kevinsawicki/http/HttpRequest$RequestOutputStream;

    .line 3025
    invoke-static {v2}, Lcom/github/kevinsawicki/http/HttpRequest$RequestOutputStream;->access$500(Lcom/github/kevinsawicki/http/HttpRequest$RequestOutputStream;)Ljava/nio/charset/CharsetEncoder;

    move-result-object v2

    invoke-virtual {v2}, Ljava/nio/charset/CharsetEncoder;->charset()Ljava/nio/charset/Charset;

    move-result-object v2

    invoke-direct {v0, v1, v2}, Ljava/io/OutputStreamWriter;-><init>(Ljava/io/OutputStream;Ljava/nio/charset/Charset;)V

    .line 3026
    new-instance v1, Lcom/github/kevinsawicki/http/HttpRequest$10;

    invoke-direct {v1, p0, v0, p1, v0}, Lcom/github/kevinsawicki/http/HttpRequest$10;-><init>(Lcom/github/kevinsawicki/http/HttpRequest;Ljava/io/Flushable;Ljava/io/Reader;Ljava/io/Writer;)V

    .line 3032
    invoke-virtual {v1}, Lcom/github/kevinsawicki/http/HttpRequest$10;->call()Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Lcom/github/kevinsawicki/http/HttpRequest;

    return-object v0

    .line 3021
    :catch_0
    move-exception v0

    .line 3022
    new-instance v1, Lcom/github/kevinsawicki/http/HttpRequest$HttpRequestException;

    invoke-direct {v1, v0}, Lcom/github/kevinsawicki/http/HttpRequest$HttpRequestException;-><init>(Ljava/io/IOException;)V

    throw v1
.end method

.method public send(Ljava/lang/CharSequence;)Lcom/github/kevinsawicki/http/HttpRequest;
    .locals 2
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Lcom/github/kevinsawicki/http/HttpRequest$HttpRequestException;
        }
    .end annotation

    .prologue
    .line 3047
    :try_start_0
    invoke-virtual {p0}, Lcom/github/kevinsawicki/http/HttpRequest;->openOutput()Lcom/github/kevinsawicki/http/HttpRequest;

    .line 3048
    iget-object v0, p0, Lcom/github/kevinsawicki/http/HttpRequest;->output:Lcom/github/kevinsawicki/http/HttpRequest$RequestOutputStream;

    invoke-interface {p1}, Ljava/lang/CharSequence;->toString()Ljava/lang/String;

    move-result-object v1

    invoke-virtual {v0, v1}, Lcom/github/kevinsawicki/http/HttpRequest$RequestOutputStream;->write(Ljava/lang/String;)Lcom/github/kevinsawicki/http/HttpRequest$RequestOutputStream;
    :try_end_0
    .catch Ljava/io/IOException; {:try_start_0 .. :try_end_0} :catch_0

    .line 3052
    return-object p0

    .line 3049
    :catch_0
    move-exception v0

    .line 3050
    new-instance v1, Lcom/github/kevinsawicki/http/HttpRequest$HttpRequestException;

    invoke-direct {v1, v0}, Lcom/github/kevinsawicki/http/HttpRequest$HttpRequestException;-><init>(Ljava/io/IOException;)V

    throw v1
.end method

.method public send([B)Lcom/github/kevinsawicki/http/HttpRequest;
    .locals 2
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Lcom/github/kevinsawicki/http/HttpRequest$HttpRequestException;
        }
    .end annotation

    .prologue
    .line 2985
    if-eqz p1, :cond_0

    .line 2986
    array-length v0, p1

    int-to-long v0, v0

    invoke-direct {p0, v0, v1}, Lcom/github/kevinsawicki/http/HttpRequest;->incrementTotalSize(J)Lcom/github/kevinsawicki/http/HttpRequest;

    .line 2987
    :cond_0
    new-instance v0, Ljava/io/ByteArrayInputStream;

    invoke-direct {v0, p1}, Ljava/io/ByteArrayInputStream;-><init>([B)V

    invoke-virtual {p0, v0}, Lcom/github/kevinsawicki/http/HttpRequest;->send(Ljava/io/InputStream;)Lcom/github/kevinsawicki/http/HttpRequest;

    move-result-object v0

    return-object v0
.end method

.method public server()Ljava/lang/String;
    .locals 1

    .prologue
    .line 2398
    const-string v0, "Server"

    invoke-virtual {p0, v0}, Lcom/github/kevinsawicki/http/HttpRequest;->header(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v0

    return-object v0
.end method

.method public serverError()Z
    .locals 2
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Lcom/github/kevinsawicki/http/HttpRequest$HttpRequestException;
        }
    .end annotation

    .prologue
    .line 1617
    const/16 v0, 0x1f4

    invoke-virtual {p0}, Lcom/github/kevinsawicki/http/HttpRequest;->code()I

    move-result v1

    if-ne v0, v1, :cond_0

    const/4 v0, 0x1

    :goto_0
    return v0

    :cond_0
    const/4 v0, 0x0

    goto :goto_0
.end method

.method protected startPart()Lcom/github/kevinsawicki/http/HttpRequest;
    .locals 2
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljava/io/IOException;
        }
    .end annotation

    .prologue
    .line 2740
    iget-boolean v0, p0, Lcom/github/kevinsawicki/http/HttpRequest;->multipart:Z

    if-nez v0, :cond_0

    .line 2741
    const/4 v0, 0x1

    iput-boolean v0, p0, Lcom/github/kevinsawicki/http/HttpRequest;->multipart:Z

    .line 2742
    const-string v0, "multipart/form-data; boundary=00content0boundary00"

    invoke-virtual {p0, v0}, Lcom/github/kevinsawicki/http/HttpRequest;->contentType(Ljava/lang/String;)Lcom/github/kevinsawicki/http/HttpRequest;

    move-result-object v0

    invoke-virtual {v0}, Lcom/github/kevinsawicki/http/HttpRequest;->openOutput()Lcom/github/kevinsawicki/http/HttpRequest;

    .line 2743
    iget-object v0, p0, Lcom/github/kevinsawicki/http/HttpRequest;->output:Lcom/github/kevinsawicki/http/HttpRequest$RequestOutputStream;

    const-string v1, "--00content0boundary00\r\n"

    invoke-virtual {v0, v1}, Lcom/github/kevinsawicki/http/HttpRequest$RequestOutputStream;->write(Ljava/lang/String;)Lcom/github/kevinsawicki/http/HttpRequest$RequestOutputStream;

    .line 2746
    :goto_0
    return-object p0

    .line 2745
    :cond_0
    iget-object v0, p0, Lcom/github/kevinsawicki/http/HttpRequest;->output:Lcom/github/kevinsawicki/http/HttpRequest$RequestOutputStream;

    const-string v1, "\r\n--00content0boundary00\r\n"

    invoke-virtual {v0, v1}, Lcom/github/kevinsawicki/http/HttpRequest$RequestOutputStream;->write(Ljava/lang/String;)Lcom/github/kevinsawicki/http/HttpRequest$RequestOutputStream;

    goto :goto_0
.end method

.method public stream()Ljava/io/InputStream;
    .locals 3
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Lcom/github/kevinsawicki/http/HttpRequest$HttpRequestException;
        }
    .end annotation

    .prologue
    .line 1855
    invoke-virtual {p0}, Lcom/github/kevinsawicki/http/HttpRequest;->code()I

    move-result v0

    const/16 v1, 0x190

    if-ge v0, v1, :cond_2

    .line 1857
    :try_start_0
    invoke-virtual {p0}, Lcom/github/kevinsawicki/http/HttpRequest;->getConnection()Ljava/net/HttpURLConnection;

    move-result-object v0

    invoke-virtual {v0}, Ljava/net/HttpURLConnection;->getInputStream()Ljava/io/InputStream;
    :try_end_0
    .catch Ljava/io/IOException; {:try_start_0 .. :try_end_0} :catch_0

    move-result-object v0

    .line 1874
    :cond_0
    :goto_0
    iget-boolean v1, p0, Lcom/github/kevinsawicki/http/HttpRequest;->uncompress:Z

    if-eqz v1, :cond_1

    const-string v1, "gzip"

    invoke-virtual {p0}, Lcom/github/kevinsawicki/http/HttpRequest;->contentEncoding()Ljava/lang/String;

    move-result-object v2

    invoke-virtual {v1, v2}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v1

    if-nez v1, :cond_4

    .line 1878
    :cond_1
    :goto_1
    return-object v0

    .line 1858
    :catch_0
    move-exception v0

    .line 1859
    new-instance v1, Lcom/github/kevinsawicki/http/HttpRequest$HttpRequestException;

    invoke-direct {v1, v0}, Lcom/github/kevinsawicki/http/HttpRequest$HttpRequestException;-><init>(Ljava/io/IOException;)V

    throw v1

    .line 1862
    :cond_2
    invoke-virtual {p0}, Lcom/github/kevinsawicki/http/HttpRequest;->getConnection()Ljava/net/HttpURLConnection;

    move-result-object v0

    invoke-virtual {v0}, Ljava/net/HttpURLConnection;->getErrorStream()Ljava/io/InputStream;

    move-result-object v0

    .line 1863
    if-nez v0, :cond_0

    .line 1865
    :try_start_1
    invoke-virtual {p0}, Lcom/github/kevinsawicki/http/HttpRequest;->getConnection()Ljava/net/HttpURLConnection;

    move-result-object v0

    invoke-virtual {v0}, Ljava/net/HttpURLConnection;->getInputStream()Ljava/io/InputStream;
    :try_end_1
    .catch Ljava/io/IOException; {:try_start_1 .. :try_end_1} :catch_1

    move-result-object v0

    goto :goto_0

    .line 1866
    :catch_1
    move-exception v0

    .line 1867
    invoke-virtual {p0}, Lcom/github/kevinsawicki/http/HttpRequest;->contentLength()I

    move-result v1

    if-lez v1, :cond_3

    .line 1868
    new-instance v1, Lcom/github/kevinsawicki/http/HttpRequest$HttpRequestException;

    invoke-direct {v1, v0}, Lcom/github/kevinsawicki/http/HttpRequest$HttpRequestException;-><init>(Ljava/io/IOException;)V

    throw v1

    .line 1870
    :cond_3
    new-instance v0, Ljava/io/ByteArrayInputStream;

    const/4 v1, 0x0

    new-array v1, v1, [B

    invoke-direct {v0, v1}, Ljava/io/ByteArrayInputStream;-><init>([B)V

    goto :goto_0

    .line 1878
    :cond_4
    :try_start_2
    new-instance v1, Ljava/util/zip/GZIPInputStream;

    invoke-direct {v1, v0}, Ljava/util/zip/GZIPInputStream;-><init>(Ljava/io/InputStream;)V
    :try_end_2
    .catch Ljava/io/IOException; {:try_start_2 .. :try_end_2} :catch_2

    move-object v0, v1

    goto :goto_1

    .line 1879
    :catch_2
    move-exception v0

    .line 1880
    new-instance v1, Lcom/github/kevinsawicki/http/HttpRequest$HttpRequestException;

    invoke-direct {v1, v0}, Lcom/github/kevinsawicki/http/HttpRequest$HttpRequestException;-><init>(Ljava/io/IOException;)V

    throw v1
.end method

.method public toString()Ljava/lang/String;
    .locals 2

    .prologue
    .line 1513
    new-instance v0, Ljava/lang/StringBuilder;

    invoke-direct {v0}, Ljava/lang/StringBuilder;-><init>()V

    invoke-virtual {p0}, Lcom/github/kevinsawicki/http/HttpRequest;->method()Ljava/lang/String;

    move-result-object v1

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    const/16 v1, 0x20

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(C)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-virtual {p0}, Lcom/github/kevinsawicki/http/HttpRequest;->url()Ljava/net/URL;

    move-result-object v1

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/Object;)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-virtual {v0}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v0

    return-object v0
.end method

.method public trustAllCerts()Lcom/github/kevinsawicki/http/HttpRequest;
    .locals 2
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Lcom/github/kevinsawicki/http/HttpRequest$HttpRequestException;
        }
    .end annotation

    .prologue
    .line 3189
    invoke-virtual {p0}, Lcom/github/kevinsawicki/http/HttpRequest;->getConnection()Ljava/net/HttpURLConnection;

    move-result-object v0

    .line 3190
    instance-of v1, v0, Ljavax/net/ssl/HttpsURLConnection;

    if-eqz v1, :cond_0

    .line 3191
    check-cast v0, Ljavax/net/ssl/HttpsURLConnection;

    .line 3192
    invoke-static {}, Lcom/github/kevinsawicki/http/HttpRequest;->getTrustedFactory()Ljavax/net/ssl/SSLSocketFactory;

    move-result-object v1

    invoke-virtual {v0, v1}, Ljavax/net/ssl/HttpsURLConnection;->setSSLSocketFactory(Ljavax/net/ssl/SSLSocketFactory;)V

    .line 3193
    :cond_0
    return-object p0
.end method

.method public trustAllHosts()Lcom/github/kevinsawicki/http/HttpRequest;
    .locals 2

    .prologue
    .line 3206
    invoke-virtual {p0}, Lcom/github/kevinsawicki/http/HttpRequest;->getConnection()Ljava/net/HttpURLConnection;

    move-result-object v0

    .line 3207
    instance-of v1, v0, Ljavax/net/ssl/HttpsURLConnection;

    if-eqz v1, :cond_0

    .line 3208
    check-cast v0, Ljavax/net/ssl/HttpsURLConnection;

    .line 3209
    invoke-static {}, Lcom/github/kevinsawicki/http/HttpRequest;->getTrustedVerifier()Ljavax/net/ssl/HostnameVerifier;

    move-result-object v1

    invoke-virtual {v0, v1}, Ljavax/net/ssl/HttpsURLConnection;->setHostnameVerifier(Ljavax/net/ssl/HostnameVerifier;)V

    .line 3210
    :cond_0
    return-object p0
.end method

.method public uncompress(Z)Lcom/github/kevinsawicki/http/HttpRequest;
    .locals 0

    .prologue
    .line 1734
    iput-boolean p1, p0, Lcom/github/kevinsawicki/http/HttpRequest;->uncompress:Z

    .line 1735
    return-object p0
.end method

.method public url()Ljava/net/URL;
    .locals 1

    .prologue
    .line 3219
    invoke-virtual {p0}, Lcom/github/kevinsawicki/http/HttpRequest;->getConnection()Ljava/net/HttpURLConnection;

    move-result-object v0

    invoke-virtual {v0}, Ljava/net/HttpURLConnection;->getURL()Ljava/net/URL;

    move-result-object v0

    return-object v0
.end method

.method public useCaches(Z)Lcom/github/kevinsawicki/http/HttpRequest;
    .locals 1

    .prologue
    .line 2349
    invoke-virtual {p0}, Lcom/github/kevinsawicki/http/HttpRequest;->getConnection()Ljava/net/HttpURLConnection;

    move-result-object v0

    invoke-virtual {v0, p1}, Ljava/net/HttpURLConnection;->setUseCaches(Z)V

    .line 2350
    return-object p0
.end method

.method public useProxy(Ljava/lang/String;I)Lcom/github/kevinsawicki/http/HttpRequest;
    .locals 2

    .prologue
    .line 3240
    iget-object v0, p0, Lcom/github/kevinsawicki/http/HttpRequest;->connection:Ljava/net/HttpURLConnection;

    if-eqz v0, :cond_0

    .line 3241
    new-instance v0, Ljava/lang/IllegalStateException;

    const-string v1, "The connection has already been created. This method must be called before reading or writing to the request."

    invoke-direct {v0, v1}, Ljava/lang/IllegalStateException;-><init>(Ljava/lang/String;)V

    throw v0

    .line 3243
    :cond_0
    iput-object p1, p0, Lcom/github/kevinsawicki/http/HttpRequest;->httpProxyHost:Ljava/lang/String;

    .line 3244
    iput p2, p0, Lcom/github/kevinsawicki/http/HttpRequest;->httpProxyPort:I

    .line 3245
    return-object p0
.end method

.method public userAgent(Ljava/lang/String;)Lcom/github/kevinsawicki/http/HttpRequest;
    .locals 1

    .prologue
    .line 2329
    const-string v0, "User-Agent"

    invoke-virtual {p0, v0, p1}, Lcom/github/kevinsawicki/http/HttpRequest;->header(Ljava/lang/String;Ljava/lang/String;)Lcom/github/kevinsawicki/http/HttpRequest;

    move-result-object v0

    return-object v0
.end method

.method protected writePartHeader(Ljava/lang/String;Ljava/lang/String;)Lcom/github/kevinsawicki/http/HttpRequest;
    .locals 1
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljava/io/IOException;
        }
    .end annotation

    .prologue
    .line 2759
    const/4 v0, 0x0

    invoke-virtual {p0, p1, p2, v0}, Lcom/github/kevinsawicki/http/HttpRequest;->writePartHeader(Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;)Lcom/github/kevinsawicki/http/HttpRequest;

    move-result-object v0

    return-object v0
.end method

.method protected writePartHeader(Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;)Lcom/github/kevinsawicki/http/HttpRequest;
    .locals 2
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljava/io/IOException;
        }
    .end annotation

    .prologue
    .line 2773
    new-instance v0, Ljava/lang/StringBuilder;

    invoke-direct {v0}, Ljava/lang/StringBuilder;-><init>()V

    .line 2774
    const-string v1, "form-data; name=\""

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1, p1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    .line 2775
    if-eqz p2, :cond_0

    .line 2776
    const-string v1, "\"; filename=\""

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1, p2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    .line 2777
    :cond_0
    const/16 v1, 0x22

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(C)Ljava/lang/StringBuilder;

    .line 2778
    const-string v1, "Content-Disposition"

    invoke-virtual {v0}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v0

    invoke-virtual {p0, v1, v0}, Lcom/github/kevinsawicki/http/HttpRequest;->partHeader(Ljava/lang/String;Ljava/lang/String;)Lcom/github/kevinsawicki/http/HttpRequest;

    .line 2779
    if-eqz p3, :cond_1

    .line 2780
    const-string v0, "Content-Type"

    invoke-virtual {p0, v0, p3}, Lcom/github/kevinsawicki/http/HttpRequest;->partHeader(Ljava/lang/String;Ljava/lang/String;)Lcom/github/kevinsawicki/http/HttpRequest;

    .line 2781
    :cond_1
    const-string v0, "\r\n"

    invoke-virtual {p0, v0}, Lcom/github/kevinsawicki/http/HttpRequest;->send(Ljava/lang/CharSequence;)Lcom/github/kevinsawicki/http/HttpRequest;

    move-result-object v0

    return-object v0
.end method

.method public writer()Ljava/io/OutputStreamWriter;
    .locals 3
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Lcom/github/kevinsawicki/http/HttpRequest$HttpRequestException;
        }
    .end annotation

    .prologue
    .line 3063
    :try_start_0
    invoke-virtual {p0}, Lcom/github/kevinsawicki/http/HttpRequest;->openOutput()Lcom/github/kevinsawicki/http/HttpRequest;

    .line 3064
    new-instance v0, Ljava/io/OutputStreamWriter;

    iget-object v1, p0, Lcom/github/kevinsawicki/http/HttpRequest;->output:Lcom/github/kevinsawicki/http/HttpRequest$RequestOutputStream;

    iget-object v2, p0, Lcom/github/kevinsawicki/http/HttpRequest;->output:Lcom/github/kevinsawicki/http/HttpRequest$RequestOutputStream;

    invoke-static {v2}, Lcom/github/kevinsawicki/http/HttpRequest$RequestOutputStream;->access$500(Lcom/github/kevinsawicki/http/HttpRequest$RequestOutputStream;)Ljava/nio/charset/CharsetEncoder;

    move-result-object v2

    invoke-virtual {v2}, Ljava/nio/charset/CharsetEncoder;->charset()Ljava/nio/charset/Charset;

    move-result-object v2

    invoke-direct {v0, v1, v2}, Ljava/io/OutputStreamWriter;-><init>(Ljava/io/OutputStream;Ljava/nio/charset/Charset;)V
    :try_end_0
    .catch Ljava/io/IOException; {:try_start_0 .. :try_end_0} :catch_0

    return-object v0

    .line 3065
    :catch_0
    move-exception v0

    .line 3066
    new-instance v1, Lcom/github/kevinsawicki/http/HttpRequest$HttpRequestException;

    invoke-direct {v1, v0}, Lcom/github/kevinsawicki/http/HttpRequest$HttpRequestException;-><init>(Ljava/io/IOException;)V

    throw v1
.end method
