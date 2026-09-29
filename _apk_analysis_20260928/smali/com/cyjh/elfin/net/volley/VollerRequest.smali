.class public Lcom/cyjh/elfin/net/volley/VollerRequest;
.super Lcom/android/volley/Request;
.source "VollerRequest.java"


# annotations
.annotation system Ldalvik/annotation/Signature;
    value = {
        "Lcom/android/volley/Request",
        "<",
        "Ljava/lang/Object;",
        ">;"
    }
.end annotation


# static fields
.field private static final TIME_OUT:I = 0xc350


# instance fields
.field private mAnalysisJson:Lcom/cyjh/elfin/net/volley/inf/IAnalysisJson;

.field private mListener:Lcom/android/volley/Response$Listener;
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "Lcom/android/volley/Response$Listener",
            "<",
            "Ljava/lang/Object;",
            ">;"
        }
    .end annotation
.end field

.field private map:Ljava/util/Map;
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "Ljava/util/Map",
            "<",
            "Ljava/lang/String;",
            "Ljava/lang/String;",
            ">;"
        }
    .end annotation
.end field


# direct methods
.method public constructor <init>(ILjava/lang/String;Ljava/util/Map;Lcom/android/volley/Response$Listener;Lcom/android/volley/Response$ErrorListener;)V
    .locals 4
    .param p1, "method"    # I
    .param p2, "url"    # Ljava/lang/String;
    .param p5, "errorListener"    # Lcom/android/volley/Response$ErrorListener;
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "(I",
            "Ljava/lang/String;",
            "Ljava/util/Map",
            "<",
            "Ljava/lang/String;",
            "Ljava/lang/String;",
            ">;",
            "Lcom/android/volley/Response$Listener",
            "<",
            "Ljava/lang/Object;",
            ">;",
            "Lcom/android/volley/Response$ErrorListener;",
            ")V"
        }
    .end annotation

    .prologue
    .local p3, "postParams":Ljava/util/Map;, "Ljava/util/Map<Ljava/lang/String;Ljava/lang/String;>;"
    .local p4, "listener":Lcom/android/volley/Response$Listener;, "Lcom/android/volley/Response$Listener<Ljava/lang/Object;>;"
    const/4 v3, 0x0

    .line 43
    invoke-direct {p0, p1, p2, p5}, Lcom/android/volley/Request;-><init>(ILjava/lang/String;Lcom/android/volley/Response$ErrorListener;)V

    .line 44
    iput-object p4, p0, Lcom/cyjh/elfin/net/volley/VollerRequest;->mListener:Lcom/android/volley/Response$Listener;

    .line 45
    iput-object p3, p0, Lcom/cyjh/elfin/net/volley/VollerRequest;->map:Ljava/util/Map;

    .line 47
    new-instance v0, Lcom/android/volley/DefaultRetryPolicy;

    const v1, 0xc350

    const/high16 v2, 0x3f800000    # 1.0f

    invoke-direct {v0, v1, v3, v2}, Lcom/android/volley/DefaultRetryPolicy;-><init>(IIF)V

    invoke-virtual {p0, v0}, Lcom/cyjh/elfin/net/volley/VollerRequest;->setRetryPolicy(Lcom/android/volley/RetryPolicy;)Lcom/android/volley/Request;

    .line 48
    invoke-virtual {p0, v3}, Lcom/cyjh/elfin/net/volley/VollerRequest;->setShouldCache(Z)Lcom/android/volley/Request;

    .line 49
    return-void
.end method

.method public constructor <init>(Ljava/lang/String;Lcom/android/volley/Response$Listener;Lcom/android/volley/Response$ErrorListener;Lcom/cyjh/elfin/net/volley/inf/IAnalysisJson;)V
    .locals 6
    .param p1, "url"    # Ljava/lang/String;
    .param p3, "errorListener"    # Lcom/android/volley/Response$ErrorListener;
    .param p4, "analysisJson"    # Lcom/cyjh/elfin/net/volley/inf/IAnalysisJson;
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "(",
            "Ljava/lang/String;",
            "Lcom/android/volley/Response$Listener",
            "<",
            "Ljava/lang/Object;",
            ">;",
            "Lcom/android/volley/Response$ErrorListener;",
            "Lcom/cyjh/elfin/net/volley/inf/IAnalysisJson;",
            ")V"
        }
    .end annotation

    .prologue
    .line 60
    .local p2, "listener":Lcom/android/volley/Response$Listener;, "Lcom/android/volley/Response$Listener<Ljava/lang/Object;>;"
    const/4 v1, 0x0

    const/4 v3, 0x0

    move-object v0, p0

    move-object v2, p1

    move-object v4, p2

    move-object v5, p3

    invoke-direct/range {v0 .. v5}, Lcom/cyjh/elfin/net/volley/VollerRequest;-><init>(ILjava/lang/String;Ljava/util/Map;Lcom/android/volley/Response$Listener;Lcom/android/volley/Response$ErrorListener;)V

    .line 61
    iput-object p4, p0, Lcom/cyjh/elfin/net/volley/VollerRequest;->mAnalysisJson:Lcom/cyjh/elfin/net/volley/inf/IAnalysisJson;

    .line 62
    return-void
.end method

.method public constructor <init>(Ljava/lang/String;Ljava/util/Map;Lcom/android/volley/Response$Listener;Lcom/android/volley/Response$ErrorListener;Lcom/cyjh/elfin/net/volley/inf/IAnalysisJson;)V
    .locals 6
    .param p1, "url"    # Ljava/lang/String;
    .param p4, "errorListener"    # Lcom/android/volley/Response$ErrorListener;
    .param p5, "analysisJson"    # Lcom/cyjh/elfin/net/volley/inf/IAnalysisJson;
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "(",
            "Ljava/lang/String;",
            "Ljava/util/Map",
            "<",
            "Ljava/lang/String;",
            "Ljava/lang/String;",
            ">;",
            "Lcom/android/volley/Response$Listener",
            "<",
            "Ljava/lang/Object;",
            ">;",
            "Lcom/android/volley/Response$ErrorListener;",
            "Lcom/cyjh/elfin/net/volley/inf/IAnalysisJson;",
            ")V"
        }
    .end annotation

    .prologue
    .line 70
    .local p2, "map":Ljava/util/Map;, "Ljava/util/Map<Ljava/lang/String;Ljava/lang/String;>;"
    .local p3, "listener":Lcom/android/volley/Response$Listener;, "Lcom/android/volley/Response$Listener<Ljava/lang/Object;>;"
    const/4 v1, 0x1

    move-object v0, p0

    move-object v2, p1

    move-object v3, p2

    move-object v4, p3

    move-object v5, p4

    invoke-direct/range {v0 .. v5}, Lcom/cyjh/elfin/net/volley/VollerRequest;-><init>(ILjava/lang/String;Ljava/util/Map;Lcom/android/volley/Response$Listener;Lcom/android/volley/Response$ErrorListener;)V

    .line 71
    iput-object p5, p0, Lcom/cyjh/elfin/net/volley/VollerRequest;->mAnalysisJson:Lcom/cyjh/elfin/net/volley/inf/IAnalysisJson;

    .line 72
    return-void
.end method


# virtual methods
.method protected deliverResponse(Ljava/lang/Object;)V
    .locals 1
    .param p1, "response"    # Ljava/lang/Object;

    .prologue
    .line 102
    iget-object v0, p0, Lcom/cyjh/elfin/net/volley/VollerRequest;->mListener:Lcom/android/volley/Response$Listener;

    if-eqz v0, :cond_0

    .line 103
    iget-object v0, p0, Lcom/cyjh/elfin/net/volley/VollerRequest;->mListener:Lcom/android/volley/Response$Listener;

    invoke-interface {v0, p1}, Lcom/android/volley/Response$Listener;->onResponse(Ljava/lang/Object;)V

    .line 105
    :cond_0
    return-void
.end method

.method protected getParams()Ljava/util/Map;
    .locals 1
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "()",
            "Ljava/util/Map",
            "<",
            "Ljava/lang/String;",
            "Ljava/lang/String;",
            ">;"
        }
    .end annotation

    .annotation system Ldalvik/annotation/Throws;
        value = {
            Lcom/android/volley/AuthFailureError;
        }
    .end annotation

    .prologue
    .line 76
    iget-object v0, p0, Lcom/cyjh/elfin/net/volley/VollerRequest;->map:Ljava/util/Map;

    return-object v0
.end method

.method public getPriority()Lcom/android/volley/Request$Priority;
    .locals 1

    .prologue
    .line 81
    sget-object v0, Lcom/android/volley/Request$Priority;->HIGH:Lcom/android/volley/Request$Priority;

    return-object v0
.end method

.method protected parseNetworkResponse(Lcom/android/volley/NetworkResponse;)Lcom/android/volley/Response;
    .locals 5
    .param p1, "response"    # Lcom/android/volley/NetworkResponse;
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "(",
            "Lcom/android/volley/NetworkResponse;",
            ")",
            "Lcom/android/volley/Response",
            "<",
            "Ljava/lang/Object;",
            ">;"
        }
    .end annotation

    .prologue
    .line 88
    :try_start_0
    new-instance v1, Ljava/lang/String;

    iget-object v3, p1, Lcom/android/volley/NetworkResponse;->data:[B

    const-string v4, "UTF-8"

    invoke-direct {v1, v3, v4}, Ljava/lang/String;-><init>([BLjava/lang/String;)V

    .line 89
    .local v1, "json":Ljava/lang/String;
    iget-object v3, p0, Lcom/cyjh/elfin/net/volley/VollerRequest;->mAnalysisJson:Lcom/cyjh/elfin/net/volley/inf/IAnalysisJson;

    if-eqz v3, :cond_0

    .line 90
    iget-object v3, p0, Lcom/cyjh/elfin/net/volley/VollerRequest;->mAnalysisJson:Lcom/cyjh/elfin/net/volley/inf/IAnalysisJson;

    invoke-interface {v3, v1}, Lcom/cyjh/elfin/net/volley/inf/IAnalysisJson;->getData(Ljava/lang/String;)Ljava/lang/Object;

    move-result-object v2

    .line 91
    .local v2, "object":Ljava/lang/Object;
    invoke-static {p1}, Lcom/android/volley/toolbox/HttpHeaderParser;->parseCacheHeaders(Lcom/android/volley/NetworkResponse;)Lcom/android/volley/Cache$Entry;

    move-result-object v3

    invoke-static {v2, v3}, Lcom/android/volley/Response;->success(Ljava/lang/Object;Lcom/android/volley/Cache$Entry;)Lcom/android/volley/Response;
    :try_end_0
    .catch Ljava/lang/Exception; {:try_start_0 .. :try_end_0} :catch_0

    move-result-object v3

    .line 97
    .end local v1    # "json":Ljava/lang/String;
    .end local v2    # "object":Ljava/lang/Object;
    :goto_0
    return-object v3

    .line 94
    :catch_0
    move-exception v0

    .line 95
    .local v0, "e":Ljava/lang/Exception;
    new-instance v3, Lcom/android/volley/ParseError;

    invoke-direct {v3, v0}, Lcom/android/volley/ParseError;-><init>(Ljava/lang/Throwable;)V

    invoke-static {v3}, Lcom/android/volley/Response;->error(Lcom/android/volley/VolleyError;)Lcom/android/volley/Response;

    move-result-object v3

    goto :goto_0

    .line 97
    .end local v0    # "e":Ljava/lang/Exception;
    .restart local v1    # "json":Ljava/lang/String;
    :cond_0
    const/4 v3, 0x0

    goto :goto_0
.end method
