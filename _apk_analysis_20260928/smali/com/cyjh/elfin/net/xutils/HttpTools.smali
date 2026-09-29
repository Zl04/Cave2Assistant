.class public Lcom/cyjh/elfin/net/xutils/HttpTools;
.super Ljava/lang/Object;
.source "HttpTools.java"


# static fields
.field public static final ACTION_ADDUSER:Ljava/lang/String; = "adduser"

.field public static final ACTION_CHECKEMAIL:Ljava/lang/String; = "checkemail"

.field public static final ACTION_CHECKNAME:Ljava/lang/String; = "checkname"

.field public static final ACTION_CHECKUSERLOGIN:Ljava/lang/String; = "checkuserlogin"

.field public static final APID:Ljava/lang/String; = "MQ1CHS"

.field public static final APKEY:Ljava/lang/String; = "516cf79ca36f66e28a9caa8ad8a4c7bc"

.field public static final DATEKEY:Ljava/lang/String; = "YuFjNTBhMn"

.field public static final ERRCODE_EMAILEXIST:I = -0x6

.field public static final ERRCODE_EMAILFORMAT:I = -0x4

.field public static final ERRCODE_EMAILILLEGAL:I = -0x5

.field public static final ERRCODE_USERNAMEEXIST:I = -0x3

.field public static final ERRCODE_USERNAMEFORMAT:I = -0x1

.field public static final ERRCODE_USERNAMEORPASSWORD:I = -0x2

.field public static final HTTP_END:Ljava/lang/String; = "&id=MQ1CHS"

.field public static final HTTP_HEAD:Ljava/lang/String; = "http://bbs.anjian.com/api.php?mod=u&egg="

.field public static final HTTP_TIME:Ljava/lang/String; = "http://bbs.anjian.com/api.php?mod=u&gt"

.field public static final JSON_HTTPRESULT_BOOM:Ljava/lang/String; = "boom"

.field public static final JSON_HTTPRESULT_ERRCODE:Ljava/lang/String; = "errcode"

.field public static final JSON_HTTPRESULT_RET:Ljava/lang/String; = "ret"

.field public static final JSON_USER_UID:Ljava/lang/String; = "uid"

.field public static final JSON_USER_USERNAME:Ljava/lang/String; = "username"

.field public static final REQUEST_SUCCEED:I = 0x3e8

.field public static final RET_ERROR:I = 0x2

.field public static final RET_REFUSE:I = 0x1

.field public static final RET_SUCCEED:I = 0x0

.field public static final SC_UNKNOW:I = -0x63


# instance fields
.field private final HTTPSTATUS_INTERNAL_SERVER_ERROR:Ljava/lang/String;

.field private final HTTPSTATUS_REQUEST_TIMEOUT:Ljava/lang/String;

.field private final REQUESTEXCEPTION_CLIENTPROTOCOL:Ljava/lang/String;

.field private final REQUESTEXCEPTION_CONNECTTIMEOUT:Ljava/lang/String;

.field private final REQUESTEXCEPTION_IO:Ljava/lang/String;

.field private final REQUESTEXCEPTION_UNKNOW:Ljava/lang/String;

.field private final REQUESTEXCEPTION_UNKNOWNHOST:Ljava/lang/String;

.field private androidHttpClient:Landroid/net/http/AndroidHttpClient;

.field private commonLog:Lcom/cyjh/elfin/log/CommonLog;

.field private context:Landroid/content/Context;

.field public httpstatus:I

.field private strResult:Ljava/lang/String;


# direct methods
.method public constructor <init>()V
    .locals 1

    .prologue
    .line 99
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    .line 36
    new-instance v0, Lcom/cyjh/elfin/log/CommonLog;

    invoke-direct {v0}, Lcom/cyjh/elfin/log/CommonLog;-><init>()V

    iput-object v0, p0, Lcom/cyjh/elfin/net/xutils/HttpTools;->commonLog:Lcom/cyjh/elfin/log/CommonLog;

    .line 46
    const-string v0, "\u672a\u77e5\u9519\u8bef\uff0c\u8bf7\u68c0\u67e5\u7f51\u7edc\u540e\u8bbf\u95ee\uff01"

    iput-object v0, p0, Lcom/cyjh/elfin/net/xutils/HttpTools;->REQUESTEXCEPTION_UNKNOW:Ljava/lang/String;

    .line 47
    const-string v0, "\u8fde\u63a5\u8d85\u65f6\uff01"

    iput-object v0, p0, Lcom/cyjh/elfin/net/xutils/HttpTools;->REQUESTEXCEPTION_CONNECTTIMEOUT:Ljava/lang/String;

    .line 48
    const-string v0, "\u534f\u8bae\u9519\u8bef\uff01"

    iput-object v0, p0, Lcom/cyjh/elfin/net/xutils/HttpTools;->REQUESTEXCEPTION_CLIENTPROTOCOL:Ljava/lang/String;

    .line 49
    const-string v0, "\u8bbf\u95ee\u4e0d\u5230\u670d\u52a1\u5668\uff0c\u8bf7\u68c0\u67e5\u7f51\u7edc\uff01"

    iput-object v0, p0, Lcom/cyjh/elfin/net/xutils/HttpTools;->REQUESTEXCEPTION_UNKNOWNHOST:Ljava/lang/String;

    .line 50
    const-string v0, "IO\u5f02\u5e38\uff01"

    iput-object v0, p0, Lcom/cyjh/elfin/net/xutils/HttpTools;->REQUESTEXCEPTION_IO:Ljava/lang/String;

    .line 52
    const-string v0, "\u8bf7\u6c42\u8d85\u65f6\uff01"

    iput-object v0, p0, Lcom/cyjh/elfin/net/xutils/HttpTools;->HTTPSTATUS_REQUEST_TIMEOUT:Ljava/lang/String;

    .line 53
    const-string v0, "\u670d\u52a1\u5668\u5185\u90e8\u9519\u8bef\uff01"

    iput-object v0, p0, Lcom/cyjh/elfin/net/xutils/HttpTools;->HTTPSTATUS_INTERNAL_SERVER_ERROR:Ljava/lang/String;

    .line 100
    return-void
.end method

.method public constructor <init>(Landroid/content/Context;)V
    .locals 0
    .param p1, "context"    # Landroid/content/Context;

    .prologue
    .line 103
    invoke-direct {p0}, Lcom/cyjh/elfin/net/xutils/HttpTools;-><init>()V

    .line 104
    iput-object p1, p0, Lcom/cyjh/elfin/net/xutils/HttpTools;->context:Landroid/content/Context;

    .line 105
    return-void
.end method

.method public static generateUrl(Ljava/lang/String;Ljava/util/List;)Ljava/lang/String;
    .locals 8
    .param p0, "url"    # Ljava/lang/String;
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "(",
            "Ljava/lang/String;",
            "Ljava/util/List",
            "<",
            "Lorg/apache/http/NameValuePair;",
            ">;)",
            "Ljava/lang/String;"
        }
    .end annotation

    .prologue
    .line 297
    .local p1, "params":Ljava/util/List;, "Ljava/util/List<Lorg/apache/http/NameValuePair;>;"
    const-string v2, ""

    .line 298
    .local v2, "paramStr":Ljava/lang/String;
    if-nez p1, :cond_0

    .line 299
    new-instance p1, Ljava/util/ArrayList;

    .end local p1    # "params":Ljava/util/List;, "Ljava/util/List<Lorg/apache/http/NameValuePair;>;"
    invoke-direct {p1}, Ljava/util/ArrayList;-><init>()V

    .line 301
    .restart local p1    # "params":Ljava/util/List;, "Ljava/util/List<Lorg/apache/http/NameValuePair;>;"
    :cond_0
    invoke-interface {p1}, Ljava/util/List;->iterator()Ljava/util/Iterator;

    move-result-object v3

    :goto_0
    invoke-interface {v3}, Ljava/util/Iterator;->hasNext()Z

    move-result v4

    if-eqz v4, :cond_1

    invoke-interface {v3}, Ljava/util/Iterator;->next()Ljava/lang/Object;

    move-result-object v1

    check-cast v1, Lorg/apache/http/NameValuePair;

    .line 303
    .local v1, "obj":Lorg/apache/http/NameValuePair;
    :try_start_0
    new-instance v4, Ljava/lang/StringBuilder;

    invoke-direct {v4}, Ljava/lang/StringBuilder;-><init>()V

    invoke-virtual {v4, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v4

    new-instance v5, Ljava/lang/StringBuilder;

    invoke-direct {v5}, Ljava/lang/StringBuilder;-><init>()V

    const-string v6, "&"

    invoke-virtual {v5, v6}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v5

    invoke-interface {v1}, Lorg/apache/http/NameValuePair;->getName()Ljava/lang/String;

    move-result-object v6

    invoke-virtual {v5, v6}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v5

    const-string v6, "="

    invoke-virtual {v5, v6}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v5

    invoke-interface {v1}, Lorg/apache/http/NameValuePair;->getValue()Ljava/lang/String;

    move-result-object v6

    const-string v7, "UTF-8"

    invoke-static {v6, v7}, Ljava/net/URLEncoder;->encode(Ljava/lang/String;Ljava/lang/String;)Ljava/lang/String;

    move-result-object v6

    invoke-virtual {v5, v6}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v5

    invoke-virtual {v5}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v2

    invoke-virtual {v4, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v4

    invoke-virtual {v4}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;
    :try_end_0
    .catch Ljava/io/UnsupportedEncodingException; {:try_start_0 .. :try_end_0} :catch_0

    move-result-object v2

    goto :goto_0

    .line 304
    :catch_0
    move-exception v0

    .line 305
    .local v0, "e":Ljava/io/UnsupportedEncodingException;
    invoke-virtual {v0}, Ljava/io/UnsupportedEncodingException;->printStackTrace()V

    goto :goto_0

    .line 308
    .end local v0    # "e":Ljava/io/UnsupportedEncodingException;
    .end local v1    # "obj":Lorg/apache/http/NameValuePair;
    :cond_1
    const-string v3, ""

    invoke-virtual {v2, v3}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v3

    if-nez v3, :cond_2

    .line 309
    const-string v3, "&"

    const-string v4, "?"

    invoke-virtual {v2, v3, v4}, Ljava/lang/String;->replaceFirst(Ljava/lang/String;Ljava/lang/String;)Ljava/lang/String;

    move-result-object v2

    .line 310
    new-instance v3, Ljava/lang/StringBuilder;

    invoke-direct {v3}, Ljava/lang/StringBuilder;-><init>()V

    invoke-virtual {v3, p0}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v3

    invoke-virtual {v3, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v3

    invoke-virtual {v3}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object p0

    .line 313
    :cond_2
    return-object p0
.end method


# virtual methods
.method public doGet(Ljava/lang/String;)Ljava/lang/String;
    .locals 9
    .param p1, "url"    # Ljava/lang/String;

    .prologue
    const/16 v8, 0x1f4

    const/16 v7, 0x198

    const/16 v6, 0x12e

    const/16 v5, 0xc8

    .line 134
    iget-object v4, p0, Lcom/cyjh/elfin/net/xutils/HttpTools;->androidHttpClient:Landroid/net/http/AndroidHttpClient;

    if-nez v4, :cond_0

    .line 135
    const-string v4, "Android"

    invoke-static {v4}, Landroid/net/http/AndroidHttpClient;->newInstance(Ljava/lang/String;)Landroid/net/http/AndroidHttpClient;

    move-result-object v4

    iput-object v4, p0, Lcom/cyjh/elfin/net/xutils/HttpTools;->androidHttpClient:Landroid/net/http/AndroidHttpClient;

    .line 138
    :cond_0
    new-instance v2, Lorg/apache/http/client/methods/HttpGet;

    invoke-direct {v2, p1}, Lorg/apache/http/client/methods/HttpGet;-><init>(Ljava/lang/String;)V

    .line 141
    .local v2, "httpRequest":Lorg/apache/http/client/methods/HttpGet;
    :try_start_0
    iget-object v4, p0, Lcom/cyjh/elfin/net/xutils/HttpTools;->androidHttpClient:Landroid/net/http/AndroidHttpClient;

    invoke-virtual {v4, v2}, Landroid/net/http/AndroidHttpClient;->execute(Lorg/apache/http/client/methods/HttpUriRequest;)Lorg/apache/http/HttpResponse;

    move-result-object v3

    .line 143
    .local v3, "httpResponse":Lorg/apache/http/HttpResponse;
    invoke-interface {v3}, Lorg/apache/http/HttpResponse;->getStatusLine()Lorg/apache/http/StatusLine;

    move-result-object v4

    invoke-interface {v4}, Lorg/apache/http/StatusLine;->getStatusCode()I

    move-result v4

    if-ne v4, v5, :cond_1

    .line 145
    const/16 v4, 0xc8

    iput v4, p0, Lcom/cyjh/elfin/net/xutils/HttpTools;->httpstatus:I

    .line 146
    invoke-interface {v3}, Lorg/apache/http/HttpResponse;->getEntity()Lorg/apache/http/HttpEntity;

    move-result-object v4

    invoke-static {v4}, Lorg/apache/http/util/EntityUtils;->toString(Lorg/apache/http/HttpEntity;)Ljava/lang/String;

    move-result-object v4

    iput-object v4, p0, Lcom/cyjh/elfin/net/xutils/HttpTools;->strResult:Ljava/lang/String;

    .line 147
    iget-object v4, p0, Lcom/cyjh/elfin/net/xutils/HttpTools;->commonLog:Lcom/cyjh/elfin/log/CommonLog;

    new-instance v5, Ljava/lang/StringBuilder;

    invoke-direct {v5}, Ljava/lang/StringBuilder;-><init>()V

    const-string v6, "\u8fd4\u56de\u7ed3\u679cOK>>>>"

    invoke-virtual {v5, v6}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v5

    iget-object v6, p0, Lcom/cyjh/elfin/net/xutils/HttpTools;->strResult:Ljava/lang/String;

    invoke-virtual {v5, v6}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v5

    invoke-virtual {v5}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v5

    invoke-virtual {v4, v5}, Lcom/cyjh/elfin/log/CommonLog;->e(Ljava/lang/Object;)V
    :try_end_0
    .catch Lorg/apache/http/conn/ConnectTimeoutException; {:try_start_0 .. :try_end_0} :catch_0
    .catch Lorg/apache/http/client/ClientProtocolException; {:try_start_0 .. :try_end_0} :catch_1
    .catch Ljava/net/UnknownHostException; {:try_start_0 .. :try_end_0} :catch_2
    .catch Ljava/io/IOException; {:try_start_0 .. :try_end_0} :catch_3
    .catch Ljava/lang/Exception; {:try_start_0 .. :try_end_0} :catch_4
    .catchall {:try_start_0 .. :try_end_0} :catchall_0

    .line 199
    :goto_0
    invoke-virtual {v2}, Lorg/apache/http/client/methods/HttpGet;->abort()V

    .line 200
    invoke-virtual {p0}, Lcom/cyjh/elfin/net/xutils/HttpTools;->shutdownHttpClient()V

    .line 202
    .end local v3    # "httpResponse":Lorg/apache/http/HttpResponse;
    :goto_1
    iget-object v4, p0, Lcom/cyjh/elfin/net/xutils/HttpTools;->commonLog:Lcom/cyjh/elfin/log/CommonLog;

    new-instance v5, Ljava/lang/StringBuilder;

    invoke-direct {v5}, Ljava/lang/StringBuilder;-><init>()V

    const-string v6, "\u8fd4\u56de\u7ed3\u679c>>>>"

    invoke-virtual {v5, v6}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v5

    iget-object v6, p0, Lcom/cyjh/elfin/net/xutils/HttpTools;->strResult:Ljava/lang/String;

    invoke-virtual {v5, v6}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v5

    invoke-virtual {v5}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v5

    invoke-virtual {v4, v5}, Lcom/cyjh/elfin/log/CommonLog;->e(Ljava/lang/Object;)V

    .line 203
    iget-object v4, p0, Lcom/cyjh/elfin/net/xutils/HttpTools;->strResult:Ljava/lang/String;

    return-object v4

    .line 149
    .restart local v3    # "httpResponse":Lorg/apache/http/HttpResponse;
    :cond_1
    :try_start_1
    invoke-interface {v3}, Lorg/apache/http/HttpResponse;->getStatusLine()Lorg/apache/http/StatusLine;

    move-result-object v4

    invoke-interface {v4}, Lorg/apache/http/StatusLine;->getStatusCode()I

    move-result v4

    if-ne v4, v8, :cond_2

    .line 150
    const/16 v4, 0x1f4

    iput v4, p0, Lcom/cyjh/elfin/net/xutils/HttpTools;->httpstatus:I

    .line 151
    const-string v4, "\u670d\u52a1\u5668\u5185\u90e8\u9519\u8bef\uff01"

    iput-object v4, p0, Lcom/cyjh/elfin/net/xutils/HttpTools;->strResult:Ljava/lang/String;

    .line 152
    iget-object v4, p0, Lcom/cyjh/elfin/net/xutils/HttpTools;->commonLog:Lcom/cyjh/elfin/log/CommonLog;

    new-instance v5, Ljava/lang/StringBuilder;

    invoke-direct {v5}, Ljava/lang/StringBuilder;-><init>()V

    const-string v6, "\u670d\u52a1\u5668\u5185\u90e8\u9519\u8bef>>>"

    invoke-virtual {v5, v6}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v5

    iget-object v6, p0, Lcom/cyjh/elfin/net/xutils/HttpTools;->strResult:Ljava/lang/String;

    invoke-virtual {v5, v6}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v5

    invoke-virtual {v5}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v5

    invoke-virtual {v4, v5}, Lcom/cyjh/elfin/log/CommonLog;->e(Ljava/lang/Object;)V
    :try_end_1
    .catch Lorg/apache/http/conn/ConnectTimeoutException; {:try_start_1 .. :try_end_1} :catch_0
    .catch Lorg/apache/http/client/ClientProtocolException; {:try_start_1 .. :try_end_1} :catch_1
    .catch Ljava/net/UnknownHostException; {:try_start_1 .. :try_end_1} :catch_2
    .catch Ljava/io/IOException; {:try_start_1 .. :try_end_1} :catch_3
    .catch Ljava/lang/Exception; {:try_start_1 .. :try_end_1} :catch_4
    .catchall {:try_start_1 .. :try_end_1} :catchall_0

    goto :goto_0

    .line 173
    .end local v3    # "httpResponse":Lorg/apache/http/HttpResponse;
    :catch_0
    move-exception v0

    .line 174
    .local v0, "e":Lorg/apache/http/conn/ConnectTimeoutException;
    :try_start_2
    invoke-virtual {v0}, Lorg/apache/http/conn/ConnectTimeoutException;->getMessage()Ljava/lang/String;

    move-result-object v4

    iput-object v4, p0, Lcom/cyjh/elfin/net/xutils/HttpTools;->strResult:Ljava/lang/String;

    .line 175
    iget-object v4, p0, Lcom/cyjh/elfin/net/xutils/HttpTools;->commonLog:Lcom/cyjh/elfin/log/CommonLog;

    new-instance v5, Ljava/lang/StringBuilder;

    invoke-direct {v5}, Ljava/lang/StringBuilder;-><init>()V

    const-string v6, "ConnectTimeoutException>>>"

    invoke-virtual {v5, v6}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v5

    iget-object v6, p0, Lcom/cyjh/elfin/net/xutils/HttpTools;->strResult:Ljava/lang/String;

    invoke-virtual {v5, v6}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v5

    invoke-virtual {v5}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v5

    invoke-virtual {v4, v5}, Lcom/cyjh/elfin/log/CommonLog;->e(Ljava/lang/Object;)V

    .line 176
    const-string v4, "\u8fde\u63a5\u8d85\u65f6\uff01"

    iput-object v4, p0, Lcom/cyjh/elfin/net/xutils/HttpTools;->strResult:Ljava/lang/String;

    .line 177
    iget-object v4, p0, Lcom/cyjh/elfin/net/xutils/HttpTools;->commonLog:Lcom/cyjh/elfin/log/CommonLog;

    new-instance v5, Ljava/lang/StringBuilder;

    invoke-direct {v5}, Ljava/lang/StringBuilder;-><init>()V

    const-string v6, "ConnectTimeoutException>>>"

    invoke-virtual {v5, v6}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v5

    iget-object v6, p0, Lcom/cyjh/elfin/net/xutils/HttpTools;->strResult:Ljava/lang/String;

    invoke-virtual {v5, v6}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v5

    invoke-virtual {v5}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v5

    invoke-virtual {v4, v5}, Lcom/cyjh/elfin/log/CommonLog;->e(Ljava/lang/Object;)V
    :try_end_2
    .catchall {:try_start_2 .. :try_end_2} :catchall_0

    .line 199
    invoke-virtual {v2}, Lorg/apache/http/client/methods/HttpGet;->abort()V

    .line 200
    invoke-virtual {p0}, Lcom/cyjh/elfin/net/xutils/HttpTools;->shutdownHttpClient()V

    goto/16 :goto_1

    .line 154
    .end local v0    # "e":Lorg/apache/http/conn/ConnectTimeoutException;
    .restart local v3    # "httpResponse":Lorg/apache/http/HttpResponse;
    :cond_2
    :try_start_3
    invoke-interface {v3}, Lorg/apache/http/HttpResponse;->getStatusLine()Lorg/apache/http/StatusLine;

    move-result-object v4

    invoke-interface {v4}, Lorg/apache/http/StatusLine;->getStatusCode()I

    move-result v4

    if-ne v4, v7, :cond_3

    .line 155
    const/16 v4, 0x198

    iput v4, p0, Lcom/cyjh/elfin/net/xutils/HttpTools;->httpstatus:I

    .line 156
    const-string v4, "\u8bf7\u6c42\u8d85\u65f6\uff01"

    iput-object v4, p0, Lcom/cyjh/elfin/net/xutils/HttpTools;->strResult:Ljava/lang/String;

    .line 157
    iget-object v4, p0, Lcom/cyjh/elfin/net/xutils/HttpTools;->commonLog:Lcom/cyjh/elfin/log/CommonLog;

    new-instance v5, Ljava/lang/StringBuilder;

    invoke-direct {v5}, Ljava/lang/StringBuilder;-><init>()V

    const-string v6, " \u8bf7\u6c42\u8d85\u65f6>>>"

    invoke-virtual {v5, v6}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v5

    iget-object v6, p0, Lcom/cyjh/elfin/net/xutils/HttpTools;->strResult:Ljava/lang/String;

    invoke-virtual {v5, v6}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v5

    invoke-virtual {v5}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v5

    invoke-virtual {v4, v5}, Lcom/cyjh/elfin/log/CommonLog;->e(Ljava/lang/Object;)V
    :try_end_3
    .catch Lorg/apache/http/conn/ConnectTimeoutException; {:try_start_3 .. :try_end_3} :catch_0
    .catch Lorg/apache/http/client/ClientProtocolException; {:try_start_3 .. :try_end_3} :catch_1
    .catch Ljava/net/UnknownHostException; {:try_start_3 .. :try_end_3} :catch_2
    .catch Ljava/io/IOException; {:try_start_3 .. :try_end_3} :catch_3
    .catch Ljava/lang/Exception; {:try_start_3 .. :try_end_3} :catch_4
    .catchall {:try_start_3 .. :try_end_3} :catchall_0

    goto/16 :goto_0

    .line 178
    .end local v3    # "httpResponse":Lorg/apache/http/HttpResponse;
    :catch_1
    move-exception v0

    .line 179
    .local v0, "e":Lorg/apache/http/client/ClientProtocolException;
    :try_start_4
    invoke-virtual {v0}, Lorg/apache/http/client/ClientProtocolException;->getMessage()Ljava/lang/String;

    move-result-object v4

    iput-object v4, p0, Lcom/cyjh/elfin/net/xutils/HttpTools;->strResult:Ljava/lang/String;

    .line 180
    iget-object v4, p0, Lcom/cyjh/elfin/net/xutils/HttpTools;->commonLog:Lcom/cyjh/elfin/log/CommonLog;

    new-instance v5, Ljava/lang/StringBuilder;

    invoke-direct {v5}, Ljava/lang/StringBuilder;-><init>()V

    const-string v6, "ClientProtocolException>>>"

    invoke-virtual {v5, v6}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v5

    iget-object v6, p0, Lcom/cyjh/elfin/net/xutils/HttpTools;->strResult:Ljava/lang/String;

    invoke-virtual {v5, v6}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v5

    invoke-virtual {v5}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v5

    invoke-virtual {v4, v5}, Lcom/cyjh/elfin/log/CommonLog;->e(Ljava/lang/Object;)V

    .line 181
    const-string v4, "\u534f\u8bae\u9519\u8bef\uff01"

    iput-object v4, p0, Lcom/cyjh/elfin/net/xutils/HttpTools;->strResult:Ljava/lang/String;

    .line 182
    iget-object v4, p0, Lcom/cyjh/elfin/net/xutils/HttpTools;->commonLog:Lcom/cyjh/elfin/log/CommonLog;

    new-instance v5, Ljava/lang/StringBuilder;

    invoke-direct {v5}, Ljava/lang/StringBuilder;-><init>()V

    const-string v6, "ClientProtocolException>>>"

    invoke-virtual {v5, v6}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v5

    iget-object v6, p0, Lcom/cyjh/elfin/net/xutils/HttpTools;->strResult:Ljava/lang/String;

    invoke-virtual {v5, v6}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v5

    invoke-virtual {v5}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v5

    invoke-virtual {v4, v5}, Lcom/cyjh/elfin/log/CommonLog;->e(Ljava/lang/Object;)V
    :try_end_4
    .catchall {:try_start_4 .. :try_end_4} :catchall_0

    .line 199
    invoke-virtual {v2}, Lorg/apache/http/client/methods/HttpGet;->abort()V

    .line 200
    invoke-virtual {p0}, Lcom/cyjh/elfin/net/xutils/HttpTools;->shutdownHttpClient()V

    goto/16 :goto_1

    .line 159
    .end local v0    # "e":Lorg/apache/http/client/ClientProtocolException;
    .restart local v3    # "httpResponse":Lorg/apache/http/HttpResponse;
    :cond_3
    :try_start_5
    invoke-interface {v3}, Lorg/apache/http/HttpResponse;->getStatusLine()Lorg/apache/http/StatusLine;

    move-result-object v4

    invoke-interface {v4}, Lorg/apache/http/StatusLine;->getStatusCode()I

    move-result v4

    if-ne v4, v6, :cond_4

    .line 162
    const/16 v4, 0x12e

    iput v4, p0, Lcom/cyjh/elfin/net/xutils/HttpTools;->httpstatus:I

    .line 163
    const-string v4, "Location"

    invoke-interface {v3, v4}, Lorg/apache/http/HttpResponse;->getLastHeader(Ljava/lang/String;)Lorg/apache/http/Header;

    move-result-object v1

    .line 164
    .local v1, "header":Lorg/apache/http/Header;
    invoke-virtual {v1}, Ljava/lang/Object;->toString()Ljava/lang/String;

    move-result-object v4

    const/16 v5, 0x9

    invoke-virtual {v4, v5}, Ljava/lang/String;->substring(I)Ljava/lang/String;

    move-result-object v4

    invoke-virtual {v4}, Ljava/lang/String;->trim()Ljava/lang/String;

    move-result-object v4

    iput-object v4, p0, Lcom/cyjh/elfin/net/xutils/HttpTools;->strResult:Ljava/lang/String;

    .line 165
    iget-object v4, p0, Lcom/cyjh/elfin/net/xutils/HttpTools;->commonLog:Lcom/cyjh/elfin/log/CommonLog;

    new-instance v5, Ljava/lang/StringBuilder;

    invoke-direct {v5}, Ljava/lang/StringBuilder;-><init>()V

    const-string v6, "strResult>>>"

    invoke-virtual {v5, v6}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v5

    iget-object v6, p0, Lcom/cyjh/elfin/net/xutils/HttpTools;->strResult:Ljava/lang/String;

    invoke-virtual {v5, v6}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v5

    invoke-virtual {v5}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v5

    invoke-virtual {v4, v5}, Lcom/cyjh/elfin/log/CommonLog;->e(Ljava/lang/Object;)V
    :try_end_5
    .catch Lorg/apache/http/conn/ConnectTimeoutException; {:try_start_5 .. :try_end_5} :catch_0
    .catch Lorg/apache/http/client/ClientProtocolException; {:try_start_5 .. :try_end_5} :catch_1
    .catch Ljava/net/UnknownHostException; {:try_start_5 .. :try_end_5} :catch_2
    .catch Ljava/io/IOException; {:try_start_5 .. :try_end_5} :catch_3
    .catch Ljava/lang/Exception; {:try_start_5 .. :try_end_5} :catch_4
    .catchall {:try_start_5 .. :try_end_5} :catchall_0

    goto/16 :goto_0

    .line 183
    .end local v1    # "header":Lorg/apache/http/Header;
    .end local v3    # "httpResponse":Lorg/apache/http/HttpResponse;
    :catch_2
    move-exception v0

    .line 184
    .local v0, "e":Ljava/net/UnknownHostException;
    :try_start_6
    invoke-virtual {v0}, Ljava/net/UnknownHostException;->getMessage()Ljava/lang/String;

    move-result-object v4

    iput-object v4, p0, Lcom/cyjh/elfin/net/xutils/HttpTools;->strResult:Ljava/lang/String;

    .line 185
    iget-object v4, p0, Lcom/cyjh/elfin/net/xutils/HttpTools;->commonLog:Lcom/cyjh/elfin/log/CommonLog;

    new-instance v5, Ljava/lang/StringBuilder;

    invoke-direct {v5}, Ljava/lang/StringBuilder;-><init>()V

    const-string v6, "UnknownHostException>>>"

    invoke-virtual {v5, v6}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v5

    iget-object v6, p0, Lcom/cyjh/elfin/net/xutils/HttpTools;->strResult:Ljava/lang/String;

    invoke-virtual {v5, v6}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v5

    invoke-virtual {v5}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v5

    invoke-virtual {v4, v5}, Lcom/cyjh/elfin/log/CommonLog;->e(Ljava/lang/Object;)V

    .line 186
    const-string v4, "\u8bbf\u95ee\u4e0d\u5230\u670d\u52a1\u5668\uff0c\u8bf7\u68c0\u67e5\u7f51\u7edc\uff01"

    iput-object v4, p0, Lcom/cyjh/elfin/net/xutils/HttpTools;->strResult:Ljava/lang/String;

    .line 187
    iget-object v4, p0, Lcom/cyjh/elfin/net/xutils/HttpTools;->commonLog:Lcom/cyjh/elfin/log/CommonLog;

    new-instance v5, Ljava/lang/StringBuilder;

    invoke-direct {v5}, Ljava/lang/StringBuilder;-><init>()V

    const-string v6, "UnknownHostException>>>"

    invoke-virtual {v5, v6}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v5

    iget-object v6, p0, Lcom/cyjh/elfin/net/xutils/HttpTools;->strResult:Ljava/lang/String;

    invoke-virtual {v5, v6}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v5

    invoke-virtual {v5}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v5

    invoke-virtual {v4, v5}, Lcom/cyjh/elfin/log/CommonLog;->e(Ljava/lang/Object;)V
    :try_end_6
    .catchall {:try_start_6 .. :try_end_6} :catchall_0

    .line 199
    invoke-virtual {v2}, Lorg/apache/http/client/methods/HttpGet;->abort()V

    .line 200
    invoke-virtual {p0}, Lcom/cyjh/elfin/net/xutils/HttpTools;->shutdownHttpClient()V

    goto/16 :goto_1

    .line 167
    .end local v0    # "e":Ljava/net/UnknownHostException;
    .restart local v3    # "httpResponse":Lorg/apache/http/HttpResponse;
    :cond_4
    const/16 v4, -0x63

    :try_start_7
    iput v4, p0, Lcom/cyjh/elfin/net/xutils/HttpTools;->httpstatus:I

    .line 168
    new-instance v4, Ljava/lang/StringBuilder;

    invoke-direct {v4}, Ljava/lang/StringBuilder;-><init>()V

    const-string v5, "\u8bf7\u6c42\u9519\u8bef>>>> "

    invoke-virtual {v4, v5}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v4

    invoke-interface {v3}, Lorg/apache/http/HttpResponse;->getStatusLine()Lorg/apache/http/StatusLine;

    move-result-object v5

    invoke-virtual {v5}, Ljava/lang/Object;->toString()Ljava/lang/String;

    move-result-object v5

    invoke-virtual {v4, v5}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v4

    invoke-virtual {v4}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v4

    iput-object v4, p0, Lcom/cyjh/elfin/net/xutils/HttpTools;->strResult:Ljava/lang/String;

    .line 170
    const-string v4, "\u672a\u77e5\u9519\u8bef\uff0c\u8bf7\u68c0\u67e5\u7f51\u7edc\u540e\u8bbf\u95ee\uff01"

    iput-object v4, p0, Lcom/cyjh/elfin/net/xutils/HttpTools;->strResult:Ljava/lang/String;
    :try_end_7
    .catch Lorg/apache/http/conn/ConnectTimeoutException; {:try_start_7 .. :try_end_7} :catch_0
    .catch Lorg/apache/http/client/ClientProtocolException; {:try_start_7 .. :try_end_7} :catch_1
    .catch Ljava/net/UnknownHostException; {:try_start_7 .. :try_end_7} :catch_2
    .catch Ljava/io/IOException; {:try_start_7 .. :try_end_7} :catch_3
    .catch Ljava/lang/Exception; {:try_start_7 .. :try_end_7} :catch_4
    .catchall {:try_start_7 .. :try_end_7} :catchall_0

    goto/16 :goto_0

    .line 188
    .end local v3    # "httpResponse":Lorg/apache/http/HttpResponse;
    :catch_3
    move-exception v0

    .line 189
    .local v0, "e":Ljava/io/IOException;
    :try_start_8
    invoke-virtual {v0}, Ljava/io/IOException;->getMessage()Ljava/lang/String;

    move-result-object v4

    iput-object v4, p0, Lcom/cyjh/elfin/net/xutils/HttpTools;->strResult:Ljava/lang/String;

    .line 190
    iget-object v4, p0, Lcom/cyjh/elfin/net/xutils/HttpTools;->commonLog:Lcom/cyjh/elfin/log/CommonLog;

    new-instance v5, Ljava/lang/StringBuilder;

    invoke-direct {v5}, Ljava/lang/StringBuilder;-><init>()V

    const-string v6, "IOException>>>"

    invoke-virtual {v5, v6}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v5

    iget-object v6, p0, Lcom/cyjh/elfin/net/xutils/HttpTools;->strResult:Ljava/lang/String;

    invoke-virtual {v5, v6}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v5

    invoke-virtual {v5}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v5

    invoke-virtual {v4, v5}, Lcom/cyjh/elfin/log/CommonLog;->e(Ljava/lang/Object;)V

    .line 191
    const-string v4, "IO\u5f02\u5e38\uff01"

    iput-object v4, p0, Lcom/cyjh/elfin/net/xutils/HttpTools;->strResult:Ljava/lang/String;

    .line 192
    iget-object v4, p0, Lcom/cyjh/elfin/net/xutils/HttpTools;->commonLog:Lcom/cyjh/elfin/log/CommonLog;

    new-instance v5, Ljava/lang/StringBuilder;

    invoke-direct {v5}, Ljava/lang/StringBuilder;-><init>()V

    const-string v6, "IOException>>>"

    invoke-virtual {v5, v6}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v5

    iget-object v6, p0, Lcom/cyjh/elfin/net/xutils/HttpTools;->strResult:Ljava/lang/String;

    invoke-virtual {v5, v6}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v5

    invoke-virtual {v5}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v5

    invoke-virtual {v4, v5}, Lcom/cyjh/elfin/log/CommonLog;->e(Ljava/lang/Object;)V
    :try_end_8
    .catchall {:try_start_8 .. :try_end_8} :catchall_0

    .line 199
    invoke-virtual {v2}, Lorg/apache/http/client/methods/HttpGet;->abort()V

    .line 200
    invoke-virtual {p0}, Lcom/cyjh/elfin/net/xutils/HttpTools;->shutdownHttpClient()V

    goto/16 :goto_1

    .line 193
    .end local v0    # "e":Ljava/io/IOException;
    :catch_4
    move-exception v0

    .line 194
    .local v0, "e":Ljava/lang/Exception;
    :try_start_9
    invoke-virtual {v0}, Ljava/lang/Exception;->getMessage()Ljava/lang/String;

    move-result-object v4

    iput-object v4, p0, Lcom/cyjh/elfin/net/xutils/HttpTools;->strResult:Ljava/lang/String;

    .line 195
    iget-object v4, p0, Lcom/cyjh/elfin/net/xutils/HttpTools;->commonLog:Lcom/cyjh/elfin/log/CommonLog;

    new-instance v5, Ljava/lang/StringBuilder;

    invoke-direct {v5}, Ljava/lang/StringBuilder;-><init>()V

    const-string v6, "Exception>>>"

    invoke-virtual {v5, v6}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v5

    iget-object v6, p0, Lcom/cyjh/elfin/net/xutils/HttpTools;->strResult:Ljava/lang/String;

    invoke-virtual {v5, v6}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v5

    invoke-virtual {v5}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v5

    invoke-virtual {v4, v5}, Lcom/cyjh/elfin/log/CommonLog;->e(Ljava/lang/Object;)V

    .line 196
    const-string v4, "\u672a\u77e5\u9519\u8bef\uff0c\u8bf7\u68c0\u67e5\u7f51\u7edc\u540e\u8bbf\u95ee\uff01"

    iput-object v4, p0, Lcom/cyjh/elfin/net/xutils/HttpTools;->strResult:Ljava/lang/String;

    .line 197
    iget-object v4, p0, Lcom/cyjh/elfin/net/xutils/HttpTools;->commonLog:Lcom/cyjh/elfin/log/CommonLog;

    new-instance v5, Ljava/lang/StringBuilder;

    invoke-direct {v5}, Ljava/lang/StringBuilder;-><init>()V

    const-string v6, "Exception>>>"

    invoke-virtual {v5, v6}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v5

    iget-object v6, p0, Lcom/cyjh/elfin/net/xutils/HttpTools;->strResult:Ljava/lang/String;

    invoke-virtual {v5, v6}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v5

    invoke-virtual {v5}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v5

    invoke-virtual {v4, v5}, Lcom/cyjh/elfin/log/CommonLog;->e(Ljava/lang/Object;)V
    :try_end_9
    .catchall {:try_start_9 .. :try_end_9} :catchall_0

    .line 199
    invoke-virtual {v2}, Lorg/apache/http/client/methods/HttpGet;->abort()V

    .line 200
    invoke-virtual {p0}, Lcom/cyjh/elfin/net/xutils/HttpTools;->shutdownHttpClient()V

    goto/16 :goto_1

    .line 199
    .end local v0    # "e":Ljava/lang/Exception;
    :catchall_0
    move-exception v4

    invoke-virtual {v2}, Lorg/apache/http/client/methods/HttpGet;->abort()V

    .line 200
    invoke-virtual {p0}, Lcom/cyjh/elfin/net/xutils/HttpTools;->shutdownHttpClient()V

    throw v4
.end method

.method public doGet(Ljava/lang/String;Ljava/util/List;)Ljava/lang/String;
    .locals 1
    .param p1, "url"    # Ljava/lang/String;
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "(",
            "Ljava/lang/String;",
            "Ljava/util/List",
            "<",
            "Lorg/apache/http/NameValuePair;",
            ">;)",
            "Ljava/lang/String;"
        }
    .end annotation

    .prologue
    .line 120
    .local p2, "params":Ljava/util/List;, "Ljava/util/List<Lorg/apache/http/NameValuePair;>;"
    invoke-static {p1, p2}, Lcom/cyjh/elfin/net/xutils/HttpTools;->generateUrl(Ljava/lang/String;Ljava/util/List;)Ljava/lang/String;

    move-result-object v0

    invoke-virtual {p0, v0}, Lcom/cyjh/elfin/net/xutils/HttpTools;->doGet(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v0

    return-object v0
.end method

.method public doPost(Ljava/lang/String;Ljava/util/List;)Ljava/lang/String;
    .locals 11
    .param p1, "url"    # Ljava/lang/String;
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "(",
            "Ljava/lang/String;",
            "Ljava/util/List",
            "<",
            "Lorg/apache/http/NameValuePair;",
            ">;)",
            "Ljava/lang/String;"
        }
    .end annotation

    .prologue
    .local p2, "params":Ljava/util/List;, "Ljava/util/List<Lorg/apache/http/NameValuePair;>;"
    const/16 v10, 0x1f4

    const/16 v9, 0x198

    const/16 v8, 0xc8

    .line 217
    iget-object v5, p0, Lcom/cyjh/elfin/net/xutils/HttpTools;->androidHttpClient:Landroid/net/http/AndroidHttpClient;

    if-nez v5, :cond_0

    .line 218
    const-string v5, "Android"

    invoke-static {v5}, Landroid/net/http/AndroidHttpClient;->newInstance(Ljava/lang/String;)Landroid/net/http/AndroidHttpClient;

    move-result-object v5

    iput-object v5, p0, Lcom/cyjh/elfin/net/xutils/HttpTools;->androidHttpClient:Landroid/net/http/AndroidHttpClient;

    .line 221
    :cond_0
    new-instance v1, Lorg/apache/http/client/methods/HttpPost;

    invoke-direct {v1, p1}, Lorg/apache/http/client/methods/HttpPost;-><init>(Ljava/lang/String;)V

    .line 224
    .local v1, "httpPost":Lorg/apache/http/client/methods/HttpPost;
    :try_start_0
    new-instance v3, Lorg/apache/http/client/entity/UrlEncodedFormEntity;

    const-string v5, "GBK"

    invoke-direct {v3, p2, v5}, Lorg/apache/http/client/entity/UrlEncodedFormEntity;-><init>(Ljava/util/List;Ljava/lang/String;)V

    .line 226
    .local v3, "httpentity":Lorg/apache/http/HttpEntity;
    invoke-virtual {v1, v3}, Lorg/apache/http/client/methods/HttpPost;->setEntity(Lorg/apache/http/HttpEntity;)V

    .line 228
    iget-object v5, p0, Lcom/cyjh/elfin/net/xutils/HttpTools;->androidHttpClient:Landroid/net/http/AndroidHttpClient;

    invoke-virtual {v5, v1}, Landroid/net/http/AndroidHttpClient;->execute(Lorg/apache/http/client/methods/HttpUriRequest;)Lorg/apache/http/HttpResponse;

    move-result-object v2

    .line 229
    .local v2, "httpResponse":Lorg/apache/http/HttpResponse;
    invoke-interface {v2}, Lorg/apache/http/HttpResponse;->getStatusLine()Lorg/apache/http/StatusLine;

    move-result-object v5

    invoke-interface {v5}, Lorg/apache/http/StatusLine;->getStatusCode()I

    move-result v4

    .line 230
    .local v4, "statusCode":I
    iget-object v5, p0, Lcom/cyjh/elfin/net/xutils/HttpTools;->commonLog:Lcom/cyjh/elfin/log/CommonLog;

    new-instance v6, Ljava/lang/StringBuilder;

    invoke-direct {v6}, Ljava/lang/StringBuilder;-><init>()V

    const-string v7, "statusCode>>>"

    invoke-virtual {v6, v7}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v6

    invoke-virtual {v6, v4}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v6

    invoke-virtual {v6}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v6

    invoke-virtual {v5, v6}, Lcom/cyjh/elfin/log/CommonLog;->e(Ljava/lang/Object;)V

    .line 231
    if-ne v4, v8, :cond_1

    .line 233
    const/16 v5, 0xc8

    iput v5, p0, Lcom/cyjh/elfin/net/xutils/HttpTools;->httpstatus:I

    .line 234
    invoke-interface {v2}, Lorg/apache/http/HttpResponse;->getEntity()Lorg/apache/http/HttpEntity;

    move-result-object v5

    invoke-static {v5}, Lorg/apache/http/util/EntityUtils;->toString(Lorg/apache/http/HttpEntity;)Ljava/lang/String;

    move-result-object v5

    iput-object v5, p0, Lcom/cyjh/elfin/net/xutils/HttpTools;->strResult:Ljava/lang/String;
    :try_end_0
    .catch Lorg/apache/http/conn/ConnectTimeoutException; {:try_start_0 .. :try_end_0} :catch_0
    .catch Lorg/apache/http/client/ClientProtocolException; {:try_start_0 .. :try_end_0} :catch_1
    .catch Ljava/net/UnknownHostException; {:try_start_0 .. :try_end_0} :catch_2
    .catch Ljava/io/IOException; {:try_start_0 .. :try_end_0} :catch_3
    .catch Ljava/lang/Exception; {:try_start_0 .. :try_end_0} :catch_4
    .catchall {:try_start_0 .. :try_end_0} :catchall_0

    .line 279
    :goto_0
    invoke-virtual {v1}, Lorg/apache/http/client/methods/HttpPost;->abort()V

    .line 280
    invoke-virtual {p0}, Lcom/cyjh/elfin/net/xutils/HttpTools;->shutdownHttpClient()V

    .line 283
    .end local v2    # "httpResponse":Lorg/apache/http/HttpResponse;
    .end local v3    # "httpentity":Lorg/apache/http/HttpEntity;
    .end local v4    # "statusCode":I
    :goto_1
    iget-object v5, p0, Lcom/cyjh/elfin/net/xutils/HttpTools;->strResult:Ljava/lang/String;

    return-object v5

    .line 237
    .restart local v2    # "httpResponse":Lorg/apache/http/HttpResponse;
    .restart local v3    # "httpentity":Lorg/apache/http/HttpEntity;
    .restart local v4    # "statusCode":I
    :cond_1
    if-ne v4, v10, :cond_2

    .line 238
    const/16 v5, 0x1f4

    :try_start_1
    iput v5, p0, Lcom/cyjh/elfin/net/xutils/HttpTools;->httpstatus:I

    .line 239
    const-string v5, "\u670d\u52a1\u5668\u5185\u90e8\u9519\u8bef\uff01"

    iput-object v5, p0, Lcom/cyjh/elfin/net/xutils/HttpTools;->strResult:Ljava/lang/String;

    .line 240
    iget-object v5, p0, Lcom/cyjh/elfin/net/xutils/HttpTools;->commonLog:Lcom/cyjh/elfin/log/CommonLog;

    new-instance v6, Ljava/lang/StringBuilder;

    invoke-direct {v6}, Ljava/lang/StringBuilder;-><init>()V

    const-string v7, "\u670d\u52a1\u5668\u5185\u90e8\u9519\u8bef>>>"

    invoke-virtual {v6, v7}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v6

    iget-object v7, p0, Lcom/cyjh/elfin/net/xutils/HttpTools;->strResult:Ljava/lang/String;

    invoke-virtual {v6, v7}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v6

    invoke-virtual {v6}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v6

    invoke-virtual {v5, v6}, Lcom/cyjh/elfin/log/CommonLog;->e(Ljava/lang/Object;)V
    :try_end_1
    .catch Lorg/apache/http/conn/ConnectTimeoutException; {:try_start_1 .. :try_end_1} :catch_0
    .catch Lorg/apache/http/client/ClientProtocolException; {:try_start_1 .. :try_end_1} :catch_1
    .catch Ljava/net/UnknownHostException; {:try_start_1 .. :try_end_1} :catch_2
    .catch Ljava/io/IOException; {:try_start_1 .. :try_end_1} :catch_3
    .catch Ljava/lang/Exception; {:try_start_1 .. :try_end_1} :catch_4
    .catchall {:try_start_1 .. :try_end_1} :catchall_0

    goto :goto_0

    .line 253
    .end local v2    # "httpResponse":Lorg/apache/http/HttpResponse;
    .end local v3    # "httpentity":Lorg/apache/http/HttpEntity;
    .end local v4    # "statusCode":I
    :catch_0
    move-exception v0

    .line 254
    .local v0, "e":Lorg/apache/http/conn/ConnectTimeoutException;
    :try_start_2
    invoke-virtual {v0}, Lorg/apache/http/conn/ConnectTimeoutException;->getMessage()Ljava/lang/String;

    move-result-object v5

    iput-object v5, p0, Lcom/cyjh/elfin/net/xutils/HttpTools;->strResult:Ljava/lang/String;

    .line 255
    iget-object v5, p0, Lcom/cyjh/elfin/net/xutils/HttpTools;->commonLog:Lcom/cyjh/elfin/log/CommonLog;

    new-instance v6, Ljava/lang/StringBuilder;

    invoke-direct {v6}, Ljava/lang/StringBuilder;-><init>()V

    const-string v7, "ConnectTimeoutException>>>"

    invoke-virtual {v6, v7}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v6

    iget-object v7, p0, Lcom/cyjh/elfin/net/xutils/HttpTools;->strResult:Ljava/lang/String;

    invoke-virtual {v6, v7}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v6

    invoke-virtual {v6}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v6

    invoke-virtual {v5, v6}, Lcom/cyjh/elfin/log/CommonLog;->e(Ljava/lang/Object;)V

    .line 256
    const-string v5, "\u8fde\u63a5\u8d85\u65f6\uff01"

    iput-object v5, p0, Lcom/cyjh/elfin/net/xutils/HttpTools;->strResult:Ljava/lang/String;

    .line 257
    iget-object v5, p0, Lcom/cyjh/elfin/net/xutils/HttpTools;->commonLog:Lcom/cyjh/elfin/log/CommonLog;

    new-instance v6, Ljava/lang/StringBuilder;

    invoke-direct {v6}, Ljava/lang/StringBuilder;-><init>()V

    const-string v7, "ConnectTimeoutException>>>"

    invoke-virtual {v6, v7}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v6

    iget-object v7, p0, Lcom/cyjh/elfin/net/xutils/HttpTools;->strResult:Ljava/lang/String;

    invoke-virtual {v6, v7}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v6

    invoke-virtual {v6}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v6

    invoke-virtual {v5, v6}, Lcom/cyjh/elfin/log/CommonLog;->e(Ljava/lang/Object;)V
    :try_end_2
    .catchall {:try_start_2 .. :try_end_2} :catchall_0

    .line 279
    invoke-virtual {v1}, Lorg/apache/http/client/methods/HttpPost;->abort()V

    .line 280
    invoke-virtual {p0}, Lcom/cyjh/elfin/net/xutils/HttpTools;->shutdownHttpClient()V

    goto :goto_1

    .line 242
    .end local v0    # "e":Lorg/apache/http/conn/ConnectTimeoutException;
    .restart local v2    # "httpResponse":Lorg/apache/http/HttpResponse;
    .restart local v3    # "httpentity":Lorg/apache/http/HttpEntity;
    .restart local v4    # "statusCode":I
    :cond_2
    if-ne v4, v9, :cond_3

    .line 243
    const/16 v5, 0x198

    :try_start_3
    iput v5, p0, Lcom/cyjh/elfin/net/xutils/HttpTools;->httpstatus:I

    .line 244
    const-string v5, "\u8bf7\u6c42\u8d85\u65f6\uff01"

    iput-object v5, p0, Lcom/cyjh/elfin/net/xutils/HttpTools;->strResult:Ljava/lang/String;

    .line 245
    iget-object v5, p0, Lcom/cyjh/elfin/net/xutils/HttpTools;->commonLog:Lcom/cyjh/elfin/log/CommonLog;

    new-instance v6, Ljava/lang/StringBuilder;

    invoke-direct {v6}, Ljava/lang/StringBuilder;-><init>()V

    const-string v7, " \u8bf7\u6c42\u8d85\u65f6>>>"

    invoke-virtual {v6, v7}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v6

    iget-object v7, p0, Lcom/cyjh/elfin/net/xutils/HttpTools;->strResult:Ljava/lang/String;

    invoke-virtual {v6, v7}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v6

    invoke-virtual {v6}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v6

    invoke-virtual {v5, v6}, Lcom/cyjh/elfin/log/CommonLog;->e(Ljava/lang/Object;)V
    :try_end_3
    .catch Lorg/apache/http/conn/ConnectTimeoutException; {:try_start_3 .. :try_end_3} :catch_0
    .catch Lorg/apache/http/client/ClientProtocolException; {:try_start_3 .. :try_end_3} :catch_1
    .catch Ljava/net/UnknownHostException; {:try_start_3 .. :try_end_3} :catch_2
    .catch Ljava/io/IOException; {:try_start_3 .. :try_end_3} :catch_3
    .catch Ljava/lang/Exception; {:try_start_3 .. :try_end_3} :catch_4
    .catchall {:try_start_3 .. :try_end_3} :catchall_0

    goto/16 :goto_0

    .line 258
    .end local v2    # "httpResponse":Lorg/apache/http/HttpResponse;
    .end local v3    # "httpentity":Lorg/apache/http/HttpEntity;
    .end local v4    # "statusCode":I
    :catch_1
    move-exception v0

    .line 259
    .local v0, "e":Lorg/apache/http/client/ClientProtocolException;
    :try_start_4
    invoke-virtual {v0}, Lorg/apache/http/client/ClientProtocolException;->getMessage()Ljava/lang/String;

    move-result-object v5

    iput-object v5, p0, Lcom/cyjh/elfin/net/xutils/HttpTools;->strResult:Ljava/lang/String;

    .line 260
    iget-object v5, p0, Lcom/cyjh/elfin/net/xutils/HttpTools;->commonLog:Lcom/cyjh/elfin/log/CommonLog;

    new-instance v6, Ljava/lang/StringBuilder;

    invoke-direct {v6}, Ljava/lang/StringBuilder;-><init>()V

    const-string v7, "ClientProtocolException>>>"

    invoke-virtual {v6, v7}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v6

    iget-object v7, p0, Lcom/cyjh/elfin/net/xutils/HttpTools;->strResult:Ljava/lang/String;

    invoke-virtual {v6, v7}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v6

    invoke-virtual {v6}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v6

    invoke-virtual {v5, v6}, Lcom/cyjh/elfin/log/CommonLog;->e(Ljava/lang/Object;)V

    .line 261
    const-string v5, "\u534f\u8bae\u9519\u8bef\uff01"

    iput-object v5, p0, Lcom/cyjh/elfin/net/xutils/HttpTools;->strResult:Ljava/lang/String;

    .line 262
    iget-object v5, p0, Lcom/cyjh/elfin/net/xutils/HttpTools;->commonLog:Lcom/cyjh/elfin/log/CommonLog;

    new-instance v6, Ljava/lang/StringBuilder;

    invoke-direct {v6}, Ljava/lang/StringBuilder;-><init>()V

    const-string v7, "ClientProtocolException>>>"

    invoke-virtual {v6, v7}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v6

    iget-object v7, p0, Lcom/cyjh/elfin/net/xutils/HttpTools;->strResult:Ljava/lang/String;

    invoke-virtual {v6, v7}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v6

    invoke-virtual {v6}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v6

    invoke-virtual {v5, v6}, Lcom/cyjh/elfin/log/CommonLog;->e(Ljava/lang/Object;)V
    :try_end_4
    .catchall {:try_start_4 .. :try_end_4} :catchall_0

    .line 279
    invoke-virtual {v1}, Lorg/apache/http/client/methods/HttpPost;->abort()V

    .line 280
    invoke-virtual {p0}, Lcom/cyjh/elfin/net/xutils/HttpTools;->shutdownHttpClient()V

    goto/16 :goto_1

    .line 247
    .end local v0    # "e":Lorg/apache/http/client/ClientProtocolException;
    .restart local v2    # "httpResponse":Lorg/apache/http/HttpResponse;
    .restart local v3    # "httpentity":Lorg/apache/http/HttpEntity;
    .restart local v4    # "statusCode":I
    :cond_3
    const/16 v5, -0x63

    :try_start_5
    iput v5, p0, Lcom/cyjh/elfin/net/xutils/HttpTools;->httpstatus:I

    .line 248
    new-instance v5, Ljava/lang/StringBuilder;

    invoke-direct {v5}, Ljava/lang/StringBuilder;-><init>()V

    const-string v6, "\u8bf7\u6c42\u9519\u8bef>>>> "

    invoke-virtual {v5, v6}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v5

    invoke-interface {v2}, Lorg/apache/http/HttpResponse;->getStatusLine()Lorg/apache/http/StatusLine;

    move-result-object v6

    invoke-virtual {v6}, Ljava/lang/Object;->toString()Ljava/lang/String;

    move-result-object v6

    invoke-virtual {v5, v6}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v5

    invoke-virtual {v5}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v5

    iput-object v5, p0, Lcom/cyjh/elfin/net/xutils/HttpTools;->strResult:Ljava/lang/String;

    .line 249
    iget-object v5, p0, Lcom/cyjh/elfin/net/xutils/HttpTools;->commonLog:Lcom/cyjh/elfin/log/CommonLog;

    new-instance v6, Ljava/lang/StringBuilder;

    invoke-direct {v6}, Ljava/lang/StringBuilder;-><init>()V

    const-string v7, "else>>>"

    invoke-virtual {v6, v7}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v6

    iget-object v7, p0, Lcom/cyjh/elfin/net/xutils/HttpTools;->strResult:Ljava/lang/String;

    invoke-virtual {v6, v7}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v6

    invoke-virtual {v6}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v6

    invoke-virtual {v5, v6}, Lcom/cyjh/elfin/log/CommonLog;->e(Ljava/lang/Object;)V

    .line 250
    const-string v5, "\u672a\u77e5\u9519\u8bef\uff0c\u8bf7\u68c0\u67e5\u7f51\u7edc\u540e\u8bbf\u95ee\uff01"

    iput-object v5, p0, Lcom/cyjh/elfin/net/xutils/HttpTools;->strResult:Ljava/lang/String;

    .line 251
    iget-object v5, p0, Lcom/cyjh/elfin/net/xutils/HttpTools;->commonLog:Lcom/cyjh/elfin/log/CommonLog;

    new-instance v6, Ljava/lang/StringBuilder;

    invoke-direct {v6}, Ljava/lang/StringBuilder;-><init>()V

    const-string v7, "else>>>"

    invoke-virtual {v6, v7}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v6

    iget-object v7, p0, Lcom/cyjh/elfin/net/xutils/HttpTools;->strResult:Ljava/lang/String;

    invoke-virtual {v6, v7}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v6

    invoke-virtual {v6}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v6

    invoke-virtual {v5, v6}, Lcom/cyjh/elfin/log/CommonLog;->e(Ljava/lang/Object;)V
    :try_end_5
    .catch Lorg/apache/http/conn/ConnectTimeoutException; {:try_start_5 .. :try_end_5} :catch_0
    .catch Lorg/apache/http/client/ClientProtocolException; {:try_start_5 .. :try_end_5} :catch_1
    .catch Ljava/net/UnknownHostException; {:try_start_5 .. :try_end_5} :catch_2
    .catch Ljava/io/IOException; {:try_start_5 .. :try_end_5} :catch_3
    .catch Ljava/lang/Exception; {:try_start_5 .. :try_end_5} :catch_4
    .catchall {:try_start_5 .. :try_end_5} :catchall_0

    goto/16 :goto_0

    .line 263
    .end local v2    # "httpResponse":Lorg/apache/http/HttpResponse;
    .end local v3    # "httpentity":Lorg/apache/http/HttpEntity;
    .end local v4    # "statusCode":I
    :catch_2
    move-exception v0

    .line 264
    .local v0, "e":Ljava/net/UnknownHostException;
    :try_start_6
    invoke-virtual {v0}, Ljava/net/UnknownHostException;->getMessage()Ljava/lang/String;

    move-result-object v5

    iput-object v5, p0, Lcom/cyjh/elfin/net/xutils/HttpTools;->strResult:Ljava/lang/String;

    .line 265
    iget-object v5, p0, Lcom/cyjh/elfin/net/xutils/HttpTools;->commonLog:Lcom/cyjh/elfin/log/CommonLog;

    new-instance v6, Ljava/lang/StringBuilder;

    invoke-direct {v6}, Ljava/lang/StringBuilder;-><init>()V

    const-string v7, "UnknownHostException>>>"

    invoke-virtual {v6, v7}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v6

    iget-object v7, p0, Lcom/cyjh/elfin/net/xutils/HttpTools;->strResult:Ljava/lang/String;

    invoke-virtual {v6, v7}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v6

    invoke-virtual {v6}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v6

    invoke-virtual {v5, v6}, Lcom/cyjh/elfin/log/CommonLog;->e(Ljava/lang/Object;)V

    .line 266
    const-string v5, "\u8bbf\u95ee\u4e0d\u5230\u670d\u52a1\u5668\uff0c\u8bf7\u68c0\u67e5\u7f51\u7edc\uff01"

    iput-object v5, p0, Lcom/cyjh/elfin/net/xutils/HttpTools;->strResult:Ljava/lang/String;

    .line 267
    iget-object v5, p0, Lcom/cyjh/elfin/net/xutils/HttpTools;->commonLog:Lcom/cyjh/elfin/log/CommonLog;

    new-instance v6, Ljava/lang/StringBuilder;

    invoke-direct {v6}, Ljava/lang/StringBuilder;-><init>()V

    const-string v7, "UnknownHostException>>>"

    invoke-virtual {v6, v7}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v6

    iget-object v7, p0, Lcom/cyjh/elfin/net/xutils/HttpTools;->strResult:Ljava/lang/String;

    invoke-virtual {v6, v7}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v6

    invoke-virtual {v6}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v6

    invoke-virtual {v5, v6}, Lcom/cyjh/elfin/log/CommonLog;->e(Ljava/lang/Object;)V
    :try_end_6
    .catchall {:try_start_6 .. :try_end_6} :catchall_0

    .line 279
    invoke-virtual {v1}, Lorg/apache/http/client/methods/HttpPost;->abort()V

    .line 280
    invoke-virtual {p0}, Lcom/cyjh/elfin/net/xutils/HttpTools;->shutdownHttpClient()V

    goto/16 :goto_1

    .line 268
    .end local v0    # "e":Ljava/net/UnknownHostException;
    :catch_3
    move-exception v0

    .line 269
    .local v0, "e":Ljava/io/IOException;
    :try_start_7
    invoke-virtual {v0}, Ljava/io/IOException;->getMessage()Ljava/lang/String;

    move-result-object v5

    iput-object v5, p0, Lcom/cyjh/elfin/net/xutils/HttpTools;->strResult:Ljava/lang/String;

    .line 270
    iget-object v5, p0, Lcom/cyjh/elfin/net/xutils/HttpTools;->commonLog:Lcom/cyjh/elfin/log/CommonLog;

    new-instance v6, Ljava/lang/StringBuilder;

    invoke-direct {v6}, Ljava/lang/StringBuilder;-><init>()V

    const-string v7, "IOException>>>"

    invoke-virtual {v6, v7}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v6

    iget-object v7, p0, Lcom/cyjh/elfin/net/xutils/HttpTools;->strResult:Ljava/lang/String;

    invoke-virtual {v6, v7}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v6

    invoke-virtual {v6}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v6

    invoke-virtual {v5, v6}, Lcom/cyjh/elfin/log/CommonLog;->e(Ljava/lang/Object;)V

    .line 271
    const-string v5, "IO\u5f02\u5e38\uff01"

    iput-object v5, p0, Lcom/cyjh/elfin/net/xutils/HttpTools;->strResult:Ljava/lang/String;

    .line 272
    iget-object v5, p0, Lcom/cyjh/elfin/net/xutils/HttpTools;->commonLog:Lcom/cyjh/elfin/log/CommonLog;

    new-instance v6, Ljava/lang/StringBuilder;

    invoke-direct {v6}, Ljava/lang/StringBuilder;-><init>()V

    const-string v7, "IOException>>>"

    invoke-virtual {v6, v7}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v6

    iget-object v7, p0, Lcom/cyjh/elfin/net/xutils/HttpTools;->strResult:Ljava/lang/String;

    invoke-virtual {v6, v7}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v6

    invoke-virtual {v6}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v6

    invoke-virtual {v5, v6}, Lcom/cyjh/elfin/log/CommonLog;->e(Ljava/lang/Object;)V
    :try_end_7
    .catchall {:try_start_7 .. :try_end_7} :catchall_0

    .line 279
    invoke-virtual {v1}, Lorg/apache/http/client/methods/HttpPost;->abort()V

    .line 280
    invoke-virtual {p0}, Lcom/cyjh/elfin/net/xutils/HttpTools;->shutdownHttpClient()V

    goto/16 :goto_1

    .line 273
    .end local v0    # "e":Ljava/io/IOException;
    :catch_4
    move-exception v0

    .line 274
    .local v0, "e":Ljava/lang/Exception;
    :try_start_8
    invoke-virtual {v0}, Ljava/lang/Exception;->getMessage()Ljava/lang/String;

    move-result-object v5

    iput-object v5, p0, Lcom/cyjh/elfin/net/xutils/HttpTools;->strResult:Ljava/lang/String;

    .line 275
    iget-object v5, p0, Lcom/cyjh/elfin/net/xutils/HttpTools;->commonLog:Lcom/cyjh/elfin/log/CommonLog;

    new-instance v6, Ljava/lang/StringBuilder;

    invoke-direct {v6}, Ljava/lang/StringBuilder;-><init>()V

    const-string v7, "Exception>>>"

    invoke-virtual {v6, v7}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v6

    iget-object v7, p0, Lcom/cyjh/elfin/net/xutils/HttpTools;->strResult:Ljava/lang/String;

    invoke-virtual {v6, v7}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v6

    invoke-virtual {v6}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v6

    invoke-virtual {v5, v6}, Lcom/cyjh/elfin/log/CommonLog;->e(Ljava/lang/Object;)V

    .line 276
    const-string v5, "\u672a\u77e5\u9519\u8bef\uff0c\u8bf7\u68c0\u67e5\u7f51\u7edc\u540e\u8bbf\u95ee\uff01"

    iput-object v5, p0, Lcom/cyjh/elfin/net/xutils/HttpTools;->strResult:Ljava/lang/String;

    .line 277
    iget-object v5, p0, Lcom/cyjh/elfin/net/xutils/HttpTools;->commonLog:Lcom/cyjh/elfin/log/CommonLog;

    new-instance v6, Ljava/lang/StringBuilder;

    invoke-direct {v6}, Ljava/lang/StringBuilder;-><init>()V

    const-string v7, "Exception>>>"

    invoke-virtual {v6, v7}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v6

    iget-object v7, p0, Lcom/cyjh/elfin/net/xutils/HttpTools;->strResult:Ljava/lang/String;

    invoke-virtual {v6, v7}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v6

    invoke-virtual {v6}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v6

    invoke-virtual {v5, v6}, Lcom/cyjh/elfin/log/CommonLog;->e(Ljava/lang/Object;)V
    :try_end_8
    .catchall {:try_start_8 .. :try_end_8} :catchall_0

    .line 279
    invoke-virtual {v1}, Lorg/apache/http/client/methods/HttpPost;->abort()V

    .line 280
    invoke-virtual {p0}, Lcom/cyjh/elfin/net/xutils/HttpTools;->shutdownHttpClient()V

    goto/16 :goto_1

    .line 279
    .end local v0    # "e":Ljava/lang/Exception;
    :catchall_0
    move-exception v5

    invoke-virtual {v1}, Lorg/apache/http/client/methods/HttpPost;->abort()V

    .line 280
    invoke-virtual {p0}, Lcom/cyjh/elfin/net/xutils/HttpTools;->shutdownHttpClient()V

    throw v5
.end method

.method public shutdownHttpClient()V
    .locals 1

    .prologue
    .line 323
    iget-object v0, p0, Lcom/cyjh/elfin/net/xutils/HttpTools;->androidHttpClient:Landroid/net/http/AndroidHttpClient;

    if-eqz v0, :cond_1

    .line 324
    iget-object v0, p0, Lcom/cyjh/elfin/net/xutils/HttpTools;->androidHttpClient:Landroid/net/http/AndroidHttpClient;

    invoke-virtual {v0}, Landroid/net/http/AndroidHttpClient;->getConnectionManager()Lorg/apache/http/conn/ClientConnectionManager;

    move-result-object v0

    if-eqz v0, :cond_0

    .line 325
    iget-object v0, p0, Lcom/cyjh/elfin/net/xutils/HttpTools;->androidHttpClient:Landroid/net/http/AndroidHttpClient;

    invoke-virtual {v0}, Landroid/net/http/AndroidHttpClient;->getConnectionManager()Lorg/apache/http/conn/ClientConnectionManager;

    move-result-object v0

    invoke-interface {v0}, Lorg/apache/http/conn/ClientConnectionManager;->shutdown()V

    .line 327
    :cond_0
    iget-object v0, p0, Lcom/cyjh/elfin/net/xutils/HttpTools;->androidHttpClient:Landroid/net/http/AndroidHttpClient;

    invoke-virtual {v0}, Landroid/net/http/AndroidHttpClient;->close()V

    .line 328
    const/4 v0, 0x0

    iput-object v0, p0, Lcom/cyjh/elfin/net/xutils/HttpTools;->androidHttpClient:Landroid/net/http/AndroidHttpClient;

    .line 330
    :cond_1
    return-void
.end method
