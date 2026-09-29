.class public abstract Lcom/cyjh/elfin/net/volley/BaseVollerHelper;
.super Ljava/lang/Object;
.source "BaseVollerHelper.java"

# interfaces
.implements Lcom/android/volley/Response$Listener;
.implements Lcom/android/volley/Response$ErrorListener;


# annotations
.annotation system Ldalvik/annotation/Signature;
    value = {
        "Ljava/lang/Object;",
        "Lcom/android/volley/Response$Listener",
        "<",
        "Ljava/lang/Object;",
        ">;",
        "Lcom/android/volley/Response$ErrorListener;"
    }
.end annotation


# direct methods
.method public constructor <init>()V
    .locals 0

    .prologue
    .line 16
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method


# virtual methods
.method public getRequestForGPost(Ljava/lang/String;Ljava/util/Map;Lcom/cyjh/elfin/net/volley/inf/IAnalysisJson;)Lcom/cyjh/elfin/net/volley/VollerRequest;
    .locals 6
    .param p1, "url"    # Ljava/lang/String;
    .param p3, "analysisJson"    # Lcom/cyjh/elfin/net/volley/inf/IAnalysisJson;
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "(",
            "Ljava/lang/String;",
            "Ljava/util/Map",
            "<",
            "Ljava/lang/String;",
            "Ljava/lang/String;",
            ">;",
            "Lcom/cyjh/elfin/net/volley/inf/IAnalysisJson;",
            ")",
            "Lcom/cyjh/elfin/net/volley/VollerRequest;"
        }
    .end annotation

    .prologue
    .line 38
    .local p2, "map":Ljava/util/Map;, "Ljava/util/Map<Ljava/lang/String;Ljava/lang/String;>;"
    new-instance v0, Lcom/cyjh/elfin/net/volley/VollerRequest;

    move-object v1, p1

    move-object v2, p2

    move-object v3, p0

    move-object v4, p0

    move-object v5, p3

    invoke-direct/range {v0 .. v5}, Lcom/cyjh/elfin/net/volley/VollerRequest;-><init>(Ljava/lang/String;Ljava/util/Map;Lcom/android/volley/Response$Listener;Lcom/android/volley/Response$ErrorListener;Lcom/cyjh/elfin/net/volley/inf/IAnalysisJson;)V

    return-object v0
.end method

.method public getRequestForGet(Ljava/lang/String;Lcom/cyjh/elfin/net/volley/inf/IAnalysisJson;)Lcom/cyjh/elfin/net/volley/VollerRequest;
    .locals 1
    .param p1, "url"    # Ljava/lang/String;
    .param p2, "analysisJson"    # Lcom/cyjh/elfin/net/volley/inf/IAnalysisJson;

    .prologue
    .line 26
    new-instance v0, Lcom/cyjh/elfin/net/volley/VollerRequest;

    invoke-direct {v0, p1, p0, p0, p2}, Lcom/cyjh/elfin/net/volley/VollerRequest;-><init>(Ljava/lang/String;Lcom/android/volley/Response$Listener;Lcom/android/volley/Response$ErrorListener;Lcom/cyjh/elfin/net/volley/inf/IAnalysisJson;)V

    return-object v0
.end method

.method public sendGetRequest(Landroid/content/Context;Ljava/lang/Object;Ljava/lang/String;Lcom/cyjh/elfin/net/volley/inf/IAnalysisJson;)V
    .locals 2
    .param p1, "context"    # Landroid/content/Context;
    .param p2, "tag"    # Ljava/lang/Object;
    .param p3, "url"    # Ljava/lang/String;
    .param p4, "analysisJson"    # Lcom/cyjh/elfin/net/volley/inf/IAnalysisJson;

    .prologue
    .line 51
    invoke-static {}, Lcom/cyjh/elfin/net/volley/VollerHttpManager;->getInstance()Lcom/cyjh/elfin/net/volley/VollerHttpManager;

    move-result-object v0

    invoke-virtual {p0, p3, p4}, Lcom/cyjh/elfin/net/volley/BaseVollerHelper;->getRequestForGet(Ljava/lang/String;Lcom/cyjh/elfin/net/volley/inf/IAnalysisJson;)Lcom/cyjh/elfin/net/volley/VollerRequest;

    move-result-object v1

    invoke-virtual {v0, p1, p2, v1}, Lcom/cyjh/elfin/net/volley/VollerHttpManager;->addRequest(Landroid/content/Context;Ljava/lang/Object;Lcom/android/volley/Request;)V

    .line 53
    return-void
.end method

.method public sendPostRequest(Landroid/content/Context;Ljava/lang/Object;Ljava/lang/String;Ljava/util/Map;Lcom/cyjh/elfin/net/volley/inf/IAnalysisJson;)V
    .locals 2
    .param p1, "context"    # Landroid/content/Context;
    .param p2, "tag"    # Ljava/lang/Object;
    .param p3, "url"    # Ljava/lang/String;
    .param p5, "analysisJson"    # Lcom/cyjh/elfin/net/volley/inf/IAnalysisJson;
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "(",
            "Landroid/content/Context;",
            "Ljava/lang/Object;",
            "Ljava/lang/String;",
            "Ljava/util/Map",
            "<",
            "Ljava/lang/String;",
            "Ljava/lang/String;",
            ">;",
            "Lcom/cyjh/elfin/net/volley/inf/IAnalysisJson;",
            ")V"
        }
    .end annotation

    .prologue
    .line 64
    .local p4, "map":Ljava/util/Map;, "Ljava/util/Map<Ljava/lang/String;Ljava/lang/String;>;"
    invoke-static {}, Lcom/cyjh/elfin/net/volley/VollerHttpManager;->getInstance()Lcom/cyjh/elfin/net/volley/VollerHttpManager;

    move-result-object v0

    invoke-virtual {p0, p3, p4, p5}, Lcom/cyjh/elfin/net/volley/BaseVollerHelper;->getRequestForGPost(Ljava/lang/String;Ljava/util/Map;Lcom/cyjh/elfin/net/volley/inf/IAnalysisJson;)Lcom/cyjh/elfin/net/volley/VollerRequest;

    move-result-object v1

    invoke-virtual {v0, p1, p2, v1}, Lcom/cyjh/elfin/net/volley/VollerHttpManager;->addRequest(Landroid/content/Context;Ljava/lang/Object;Lcom/android/volley/Request;)V

    .line 66
    return-void
.end method
