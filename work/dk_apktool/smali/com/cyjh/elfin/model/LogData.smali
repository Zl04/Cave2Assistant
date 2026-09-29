.class public Lcom/cyjh/elfin/model/LogData;
.super Ljava/lang/Object;
.source "LogData.java"


# annotations
.annotation system Ldalvik/annotation/MemberClasses;
    value = {
        Lcom/cyjh/elfin/model/LogData$Data;
    }
.end annotation


# static fields
.field private static final DATA:Ljava/lang/String; = "data"

.field private static logData:Lcom/cyjh/elfin/model/LogData;


# instance fields
.field private Data:Lcom/cyjh/elfin/model/LogData$Data;

.field private LogType:Ljava/lang/String;


# direct methods
.method public constructor <init>(Landroid/content/Context;)V
    .locals 1
    .param p1, "context"    # Landroid/content/Context;

    .prologue
    .line 29
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    .line 27
    const-string v0, "3"

    iput-object v0, p0, Lcom/cyjh/elfin/model/LogData;->LogType:Ljava/lang/String;

    .line 30
    new-instance v0, Lcom/cyjh/elfin/model/LogData$Data;

    invoke-direct {v0, p1}, Lcom/cyjh/elfin/model/LogData$Data;-><init>(Landroid/content/Context;)V

    iput-object v0, p0, Lcom/cyjh/elfin/model/LogData;->Data:Lcom/cyjh/elfin/model/LogData$Data;

    .line 31
    return-void
.end method

.method public static getInstance(Landroid/content/Context;)Lcom/cyjh/elfin/model/LogData;
    .locals 1
    .param p0, "context"    # Landroid/content/Context;

    .prologue
    .line 35
    sget-object v0, Lcom/cyjh/elfin/model/LogData;->logData:Lcom/cyjh/elfin/model/LogData;

    if-nez v0, :cond_0

    .line 36
    new-instance v0, Lcom/cyjh/elfin/model/LogData;

    invoke-direct {v0, p0}, Lcom/cyjh/elfin/model/LogData;-><init>(Landroid/content/Context;)V

    sput-object v0, Lcom/cyjh/elfin/model/LogData;->logData:Lcom/cyjh/elfin/model/LogData;

    .line 38
    :cond_0
    sget-object v0, Lcom/cyjh/elfin/model/LogData;->logData:Lcom/cyjh/elfin/model/LogData;

    return-object v0
.end method


# virtual methods
.method public getData()Lcom/cyjh/elfin/model/LogData$Data;
    .locals 1

    .prologue
    .line 51
    iget-object v0, p0, Lcom/cyjh/elfin/model/LogData;->Data:Lcom/cyjh/elfin/model/LogData$Data;

    return-object v0
.end method

.method public getLogType()Ljava/lang/String;
    .locals 1

    .prologue
    .line 43
    iget-object v0, p0, Lcom/cyjh/elfin/model/LogData;->LogType:Ljava/lang/String;

    return-object v0
.end method

.method public sendLog(Landroid/content/Context;Lcom/lidroid/xutils/http/callback/RequestCallBack;)V
    .locals 9
    .param p1, "context"    # Landroid/content/Context;
    .param p2, "requestCallBack"    # Lcom/lidroid/xutils/http/callback/RequestCallBack;

    .prologue
    .line 64
    new-instance v0, Lcom/cyjh/elfin/log/CommonLog;

    invoke-direct {v0}, Lcom/cyjh/elfin/log/CommonLog;-><init>()V

    .line 65
    .local v0, "commonLog":Lcom/cyjh/elfin/log/CommonLog;
    new-instance v3, Lcom/google/gson/GsonBuilder;

    invoke-direct {v3}, Lcom/google/gson/GsonBuilder;-><init>()V

    .line 66
    .local v3, "gsonBuilder":Lcom/google/gson/GsonBuilder;
    invoke-virtual {v3}, Lcom/google/gson/GsonBuilder;->create()Lcom/google/gson/Gson;

    move-result-object v2

    .line 68
    .local v2, "gson":Lcom/google/gson/Gson;
    invoke-virtual {v2, p0}, Lcom/google/gson/Gson;->toJson(Ljava/lang/Object;)Ljava/lang/String;

    move-result-object v1

    .line 69
    .local v1, "dataString":Ljava/lang/String;
    new-instance v6, Ljava/lang/StringBuilder;

    invoke-direct {v6}, Ljava/lang/StringBuilder;-><init>()V

    const-string v7, "dataString>>>>"

    invoke-virtual {v6, v7}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v6

    invoke-virtual {v6, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v6

    invoke-virtual {v6}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v6

    invoke-virtual {v0, v6}, Lcom/cyjh/elfin/log/CommonLog;->e(Ljava/lang/Object;)V

    .line 70
    invoke-static {p1}, Lcom/cyjh/elfin/net/xutils/XUtilsHttpClient;->getInstence(Landroid/content/Context;)Lcom/lidroid/xutils/HttpUtils;

    move-result-object v4

    .line 71
    .local v4, "httpUtils":Lcom/lidroid/xutils/HttpUtils;
    new-instance v5, Lcom/lidroid/xutils/http/RequestParams;

    invoke-direct {v5}, Lcom/lidroid/xutils/http/RequestParams;-><init>()V

    .line 72
    .local v5, "params":Lcom/lidroid/xutils/http/RequestParams;
    const-string v6, "data"

    invoke-virtual {v5, v6, v1}, Lcom/lidroid/xutils/http/RequestParams;->addQueryStringParameter(Ljava/lang/String;Ljava/lang/String;)V

    .line 73
    sget-object v6, Lcom/lidroid/xutils/http/client/HttpRequest$HttpMethod;->GET:Lcom/lidroid/xutils/http/client/HttpRequest$HttpMethod;

    sget-object v7, Lcom/cyjh/elfin/constant/URLConstant;->LOG_URL:Ljava/lang/String;

    new-instance v8, Lcom/cyjh/elfin/model/LogData$1;

    invoke-direct {v8, p0, v0}, Lcom/cyjh/elfin/model/LogData$1;-><init>(Lcom/cyjh/elfin/model/LogData;Lcom/cyjh/elfin/log/CommonLog;)V

    invoke-virtual {v4, v6, v7, v5, v8}, Lcom/lidroid/xutils/HttpUtils;->send(Lcom/lidroid/xutils/http/client/HttpRequest$HttpMethod;Ljava/lang/String;Lcom/lidroid/xutils/http/RequestParams;Lcom/lidroid/xutils/http/callback/RequestCallBack;)Lcom/lidroid/xutils/http/HttpHandler;

    .line 84
    return-void
.end method

.method public setData(Lcom/cyjh/elfin/model/LogData$Data;)V
    .locals 0
    .param p1, "data"    # Lcom/cyjh/elfin/model/LogData$Data;

    .prologue
    .line 55
    iput-object p1, p0, Lcom/cyjh/elfin/model/LogData;->Data:Lcom/cyjh/elfin/model/LogData$Data;

    .line 56
    return-void
.end method

.method public setLogType(Ljava/lang/String;)V
    .locals 0
    .param p1, "logType"    # Ljava/lang/String;

    .prologue
    .line 47
    iput-object p1, p0, Lcom/cyjh/elfin/model/LogData;->LogType:Ljava/lang/String;

    .line 48
    return-void
.end method
