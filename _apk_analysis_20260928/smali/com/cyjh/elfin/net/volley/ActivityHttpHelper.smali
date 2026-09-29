.class public Lcom/cyjh/elfin/net/volley/ActivityHttpHelper;
.super Lcom/cyjh/elfin/net/volley/BaseVollerHelper;
.source "ActivityHttpHelper.java"


# instance fields
.field private mAnalysisJson:Lcom/cyjh/elfin/net/volley/inf/IAnalysisJson;

.field private mDataListener:Lcom/cyjh/elfin/net/volley/inf/IUIDataListener;


# direct methods
.method public constructor <init>(Lcom/cyjh/elfin/net/volley/inf/IUIDataListener;)V
    .locals 0
    .param p1, "dataListener"    # Lcom/cyjh/elfin/net/volley/inf/IUIDataListener;

    .prologue
    .line 30
    invoke-direct {p0}, Lcom/cyjh/elfin/net/volley/BaseVollerHelper;-><init>()V

    .line 31
    iput-object p1, p0, Lcom/cyjh/elfin/net/volley/ActivityHttpHelper;->mDataListener:Lcom/cyjh/elfin/net/volley/inf/IUIDataListener;

    .line 32
    return-void
.end method

.method public constructor <init>(Lcom/cyjh/elfin/net/volley/inf/IUIDataListener;Lcom/cyjh/elfin/net/volley/inf/IAnalysisJson;)V
    .locals 0
    .param p1, "dataListener"    # Lcom/cyjh/elfin/net/volley/inf/IUIDataListener;
    .param p2, "analysisJson"    # Lcom/cyjh/elfin/net/volley/inf/IAnalysisJson;

    .prologue
    .line 34
    invoke-direct {p0}, Lcom/cyjh/elfin/net/volley/BaseVollerHelper;-><init>()V

    .line 35
    iput-object p1, p0, Lcom/cyjh/elfin/net/volley/ActivityHttpHelper;->mDataListener:Lcom/cyjh/elfin/net/volley/inf/IUIDataListener;

    .line 36
    iput-object p2, p0, Lcom/cyjh/elfin/net/volley/ActivityHttpHelper;->mAnalysisJson:Lcom/cyjh/elfin/net/volley/inf/IAnalysisJson;

    .line 37
    return-void
.end method


# virtual methods
.method public onErrorResponse(Lcom/android/volley/VolleyError;)V
    .locals 1
    .param p1, "error"    # Lcom/android/volley/VolleyError;

    .prologue
    .line 49
    iget-object v0, p0, Lcom/cyjh/elfin/net/volley/ActivityHttpHelper;->mDataListener:Lcom/cyjh/elfin/net/volley/inf/IUIDataListener;

    if-eqz v0, :cond_0

    .line 50
    iget-object v0, p0, Lcom/cyjh/elfin/net/volley/ActivityHttpHelper;->mDataListener:Lcom/cyjh/elfin/net/volley/inf/IUIDataListener;

    invoke-interface {v0, p1}, Lcom/cyjh/elfin/net/volley/inf/IUIDataListener;->uiDataError(Lcom/android/volley/VolleyError;)V

    .line 52
    :cond_0
    return-void
.end method

.method public onResponse(Ljava/lang/Object;)V
    .locals 1
    .param p1, "response"    # Ljava/lang/Object;

    .prologue
    .line 41
    iget-object v0, p0, Lcom/cyjh/elfin/net/volley/ActivityHttpHelper;->mDataListener:Lcom/cyjh/elfin/net/volley/inf/IUIDataListener;

    if-eqz v0, :cond_0

    .line 42
    iget-object v0, p0, Lcom/cyjh/elfin/net/volley/ActivityHttpHelper;->mDataListener:Lcom/cyjh/elfin/net/volley/inf/IUIDataListener;

    invoke-interface {v0, p1}, Lcom/cyjh/elfin/net/volley/inf/IUIDataListener;->uiDataSuccess(Ljava/lang/Object;)V

    .line 44
    :cond_0
    return-void
.end method

.method public sendGetRequest(Landroid/content/Context;Ljava/lang/Object;Ljava/lang/String;)V
    .locals 1
    .param p1, "context"    # Landroid/content/Context;
    .param p2, "tag"    # Ljava/lang/Object;
    .param p3, "url"    # Ljava/lang/String;

    .prologue
    .line 74
    iget-object v0, p0, Lcom/cyjh/elfin/net/volley/ActivityHttpHelper;->mAnalysisJson:Lcom/cyjh/elfin/net/volley/inf/IAnalysisJson;

    invoke-super {p0, p1, p2, p3, v0}, Lcom/cyjh/elfin/net/volley/BaseVollerHelper;->sendGetRequest(Landroid/content/Context;Ljava/lang/Object;Ljava/lang/String;Lcom/cyjh/elfin/net/volley/inf/IAnalysisJson;)V

    .line 75
    return-void
.end method

.method public sendGetRequest(Landroid/content/Context;Ljava/lang/String;)V
    .locals 0
    .param p1, "context"    # Landroid/content/Context;
    .param p2, "url"    # Ljava/lang/String;

    .prologue
    .line 83
    invoke-virtual {p0, p1, p0, p2}, Lcom/cyjh/elfin/net/volley/ActivityHttpHelper;->sendGetRequest(Landroid/content/Context;Ljava/lang/Object;Ljava/lang/String;)V

    .line 84
    return-void
.end method

.method public sendGetRequest(Ljava/lang/Object;Ljava/lang/String;)V
    .locals 1
    .param p1, "tag"    # Ljava/lang/Object;
    .param p2, "url"    # Ljava/lang/String;

    .prologue
    .line 62
    const/4 v0, 0x0

    invoke-virtual {p0, v0, p1, p2}, Lcom/cyjh/elfin/net/volley/ActivityHttpHelper;->sendGetRequest(Landroid/content/Context;Ljava/lang/Object;Ljava/lang/String;)V

    .line 63
    return-void
.end method

.method public sendPostRequest(Landroid/content/Context;Ljava/lang/Object;Ljava/lang/String;Ljava/util/Map;)V
    .locals 6
    .param p1, "context"    # Landroid/content/Context;
    .param p2, "tag"    # Ljava/lang/Object;
    .param p3, "url"    # Ljava/lang/String;
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
            ">;)V"
        }
    .end annotation

    .prologue
    .line 106
    .local p4, "map":Ljava/util/Map;, "Ljava/util/Map<Ljava/lang/String;Ljava/lang/String;>;"
    iget-object v5, p0, Lcom/cyjh/elfin/net/volley/ActivityHttpHelper;->mAnalysisJson:Lcom/cyjh/elfin/net/volley/inf/IAnalysisJson;

    move-object v0, p0

    move-object v1, p1

    move-object v2, p2

    move-object v3, p3

    move-object v4, p4

    invoke-super/range {v0 .. v5}, Lcom/cyjh/elfin/net/volley/BaseVollerHelper;->sendPostRequest(Landroid/content/Context;Ljava/lang/Object;Ljava/lang/String;Ljava/util/Map;Lcom/cyjh/elfin/net/volley/inf/IAnalysisJson;)V

    .line 107
    return-void
.end method

.method public sendPostRequest(Landroid/content/Context;Ljava/lang/String;Ljava/util/Map;)V
    .locals 0
    .param p1, "context"    # Landroid/content/Context;
    .param p2, "url"    # Ljava/lang/String;
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "(",
            "Landroid/content/Context;",
            "Ljava/lang/String;",
            "Ljava/util/Map",
            "<",
            "Ljava/lang/String;",
            "Ljava/lang/String;",
            ">;)V"
        }
    .end annotation

    .prologue
    .line 116
    .local p3, "map":Ljava/util/Map;, "Ljava/util/Map<Ljava/lang/String;Ljava/lang/String;>;"
    invoke-virtual {p0, p1, p0, p2, p3}, Lcom/cyjh/elfin/net/volley/ActivityHttpHelper;->sendPostRequest(Landroid/content/Context;Ljava/lang/Object;Ljava/lang/String;Ljava/util/Map;)V

    .line 117
    return-void
.end method

.method public sendPostRequest(Ljava/lang/Object;Ljava/lang/String;Ljava/util/Map;)V
    .locals 1
    .param p1, "tag"    # Ljava/lang/Object;
    .param p2, "url"    # Ljava/lang/String;
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "(",
            "Ljava/lang/Object;",
            "Ljava/lang/String;",
            "Ljava/util/Map",
            "<",
            "Ljava/lang/String;",
            "Ljava/lang/String;",
            ">;)V"
        }
    .end annotation

    .prologue
    .line 94
    .local p3, "map":Ljava/util/Map;, "Ljava/util/Map<Ljava/lang/String;Ljava/lang/String;>;"
    const/4 v0, 0x0

    invoke-virtual {p0, v0, p1, p2, p3}, Lcom/cyjh/elfin/net/volley/ActivityHttpHelper;->sendPostRequest(Landroid/content/Context;Ljava/lang/Object;Ljava/lang/String;Ljava/util/Map;)V

    .line 95
    return-void
.end method

.method public stopRequest()V
    .locals 0

    .prologue
    .line 123
    invoke-virtual {p0, p0}, Lcom/cyjh/elfin/net/volley/ActivityHttpHelper;->stopRequest(Ljava/lang/Object;)V

    .line 124
    return-void
.end method

.method public stopRequest(Ljava/lang/Object;)V
    .locals 1
    .param p1, "tag"    # Ljava/lang/Object;

    .prologue
    .line 129
    invoke-static {}, Lcom/cyjh/elfin/net/volley/VollerHttpManager;->getInstance()Lcom/cyjh/elfin/net/volley/VollerHttpManager;

    move-result-object v0

    invoke-virtual {v0, p1}, Lcom/cyjh/elfin/net/volley/VollerHttpManager;->stopRequest(Ljava/lang/Object;)V

    .line 130
    return-void
.end method
