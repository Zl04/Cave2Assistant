.class public Lcom/cyjh/elfin/net/volley/VolleyManager;
.super Ljava/lang/Object;
.source "VolleyManager.java"


# static fields
.field public static final DEFAULT_REQUEST_TIMEOUT:I = 0xbb8

.field private static final TAG:Ljava/lang/String;

.field private static mStringRequest:Lcom/android/volley/toolbox/StringRequest;


# direct methods
.method static constructor <clinit>()V
    .locals 1

    .prologue
    .line 18
    const-class v0, Lcom/cyjh/elfin/net/volley/VolleyManager;

    invoke-virtual {v0}, Ljava/lang/Class;->getCanonicalName()Ljava/lang/String;

    move-result-object v0

    sput-object v0, Lcom/cyjh/elfin/net/volley/VolleyManager;->TAG:Ljava/lang/String;

    return-void
.end method

.method public constructor <init>()V
    .locals 0

    .prologue
    .line 15
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method

.method public static cancelAllReq()V
    .locals 2

    .prologue
    .line 36
    invoke-static {}, Lcom/cyjh/elfin/net/volley/VolleyRequestQueue;->getRequestQueue()Lcom/android/volley/RequestQueue;

    move-result-object v0

    sget-object v1, Lcom/cyjh/elfin/net/volley/VolleyManager;->TAG:Ljava/lang/String;

    invoke-virtual {v0, v1}, Lcom/android/volley/RequestQueue;->cancelAll(Ljava/lang/Object;)V

    .line 37
    return-void
.end method

.method public static requestStringGet(Ljava/lang/String;Ljava/lang/String;Lcom/cyjh/elfin/net/volley/VolleyRequestManager;)V
    .locals 5
    .param p0, "url"    # Ljava/lang/String;
    .param p1, "tag"    # Ljava/lang/String;
    .param p2, "volleyRequest"    # Lcom/cyjh/elfin/net/volley/VolleyRequestManager;

    .prologue
    const/4 v4, 0x0

    .line 27
    new-instance v1, Lcom/android/volley/toolbox/StringRequest;

    iget-object v2, p2, Lcom/cyjh/elfin/net/volley/VolleyRequestManager;->mVolleySuccessListener:Lcom/cyjh/elfin/net/volley/VolleyRequestManager$OnRequestSuccessListener;

    iget-object v3, p2, Lcom/cyjh/elfin/net/volley/VolleyRequestManager;->mVolleyErrorListener:Lcom/cyjh/elfin/net/volley/VolleyRequestManager$OnRequestErrorListener;

    invoke-direct {v1, v4, p0, v2, v3}, Lcom/android/volley/toolbox/StringRequest;-><init>(ILjava/lang/String;Lcom/android/volley/Response$Listener;Lcom/android/volley/Response$ErrorListener;)V

    sput-object v1, Lcom/cyjh/elfin/net/volley/VolleyManager;->mStringRequest:Lcom/android/volley/toolbox/StringRequest;

    .line 28
    sget-object v1, Lcom/cyjh/elfin/net/volley/VolleyManager;->mStringRequest:Lcom/android/volley/toolbox/StringRequest;

    sget-object v2, Lcom/cyjh/elfin/net/volley/VolleyManager;->TAG:Ljava/lang/String;

    invoke-virtual {v1, v2}, Lcom/android/volley/toolbox/StringRequest;->setTag(Ljava/lang/Object;)Lcom/android/volley/Request;

    .line 29
    new-instance v0, Lcom/android/volley/DefaultRetryPolicy;

    const/16 v1, 0xbb8

    const/4 v2, 0x1

    const/high16 v3, 0x3f800000    # 1.0f

    invoke-direct {v0, v1, v2, v3}, Lcom/android/volley/DefaultRetryPolicy;-><init>(IIF)V

    .line 30
    .local v0, "retryPolicy":Lcom/android/volley/RetryPolicy;
    sget-object v1, Lcom/cyjh/elfin/net/volley/VolleyManager;->mStringRequest:Lcom/android/volley/toolbox/StringRequest;

    invoke-virtual {v1, v0}, Lcom/android/volley/toolbox/StringRequest;->setRetryPolicy(Lcom/android/volley/RetryPolicy;)Lcom/android/volley/Request;

    .line 31
    sget-object v1, Lcom/cyjh/elfin/net/volley/VolleyManager;->mStringRequest:Lcom/android/volley/toolbox/StringRequest;

    invoke-virtual {v1, v4}, Lcom/android/volley/toolbox/StringRequest;->setShouldCache(Z)Lcom/android/volley/Request;

    .line 32
    invoke-static {}, Lcom/cyjh/elfin/net/volley/VolleyRequestQueue;->getRequestQueue()Lcom/android/volley/RequestQueue;

    move-result-object v1

    sget-object v2, Lcom/cyjh/elfin/net/volley/VolleyManager;->mStringRequest:Lcom/android/volley/toolbox/StringRequest;

    invoke-virtual {v1, v2}, Lcom/android/volley/RequestQueue;->add(Lcom/android/volley/Request;)Lcom/android/volley/Request;

    .line 33
    return-void
.end method

.method public static requestStringGet(Ljava/lang/String;Ljava/lang/String;Lcom/cyjh/elfin/net/volley/VolleyRequestManager;I)V
    .locals 5
    .param p0, "url"    # Ljava/lang/String;
    .param p1, "tag"    # Ljava/lang/String;
    .param p2, "volleyRequest"    # Lcom/cyjh/elfin/net/volley/VolleyRequestManager;
    .param p3, "countReq"    # I

    .prologue
    const/4 v4, 0x0

    .line 40
    invoke-static {}, Lcom/cyjh/elfin/net/volley/VolleyRequestQueue;->getRequestQueue()Lcom/android/volley/RequestQueue;

    move-result-object v1

    invoke-virtual {v1, p1}, Lcom/android/volley/RequestQueue;->cancelAll(Ljava/lang/Object;)V

    .line 41
    new-instance v1, Lcom/android/volley/toolbox/StringRequest;

    iget-object v2, p2, Lcom/cyjh/elfin/net/volley/VolleyRequestManager;->mVolleySuccessListener:Lcom/cyjh/elfin/net/volley/VolleyRequestManager$OnRequestSuccessListener;

    iget-object v3, p2, Lcom/cyjh/elfin/net/volley/VolleyRequestManager;->mVolleyErrorListener:Lcom/cyjh/elfin/net/volley/VolleyRequestManager$OnRequestErrorListener;

    invoke-direct {v1, v4, p0, v2, v3}, Lcom/android/volley/toolbox/StringRequest;-><init>(ILjava/lang/String;Lcom/android/volley/Response$Listener;Lcom/android/volley/Response$ErrorListener;)V

    sput-object v1, Lcom/cyjh/elfin/net/volley/VolleyManager;->mStringRequest:Lcom/android/volley/toolbox/StringRequest;

    .line 42
    sget-object v1, Lcom/cyjh/elfin/net/volley/VolleyManager;->mStringRequest:Lcom/android/volley/toolbox/StringRequest;

    invoke-virtual {v1, p1}, Lcom/android/volley/toolbox/StringRequest;->setTag(Ljava/lang/Object;)Lcom/android/volley/Request;

    .line 43
    new-instance v0, Lcom/android/volley/DefaultRetryPolicy;

    const/16 v1, 0xbb8

    const/4 v2, 0x1

    const/high16 v3, 0x3f800000    # 1.0f

    invoke-direct {v0, v1, v2, v3}, Lcom/android/volley/DefaultRetryPolicy;-><init>(IIF)V

    .line 44
    .local v0, "retryPolicy":Lcom/android/volley/RetryPolicy;
    sget-object v1, Lcom/cyjh/elfin/net/volley/VolleyManager;->mStringRequest:Lcom/android/volley/toolbox/StringRequest;

    invoke-virtual {v1, v0}, Lcom/android/volley/toolbox/StringRequest;->setRetryPolicy(Lcom/android/volley/RetryPolicy;)Lcom/android/volley/Request;

    .line 45
    sget-object v1, Lcom/cyjh/elfin/net/volley/VolleyManager;->mStringRequest:Lcom/android/volley/toolbox/StringRequest;

    invoke-virtual {v1, v4}, Lcom/android/volley/toolbox/StringRequest;->setShouldCache(Z)Lcom/android/volley/Request;

    .line 46
    invoke-static {}, Lcom/cyjh/elfin/net/volley/VolleyRequestQueue;->getRequestQueue()Lcom/android/volley/RequestQueue;

    move-result-object v1

    sget-object v2, Lcom/cyjh/elfin/net/volley/VolleyManager;->mStringRequest:Lcom/android/volley/toolbox/StringRequest;

    invoke-virtual {v1, v2}, Lcom/android/volley/RequestQueue;->add(Lcom/android/volley/Request;)Lcom/android/volley/Request;

    .line 47
    return-void
.end method

.method public static requestStringGet(Ljava/lang/String;Ljava/lang/String;Lcom/cyjh/elfin/net/volley/VolleyRequestManager;Ljava/lang/String;)V
    .locals 7
    .param p0, "url"    # Ljava/lang/String;
    .param p1, "tag"    # Ljava/lang/String;
    .param p2, "volleyRequest"    # Lcom/cyjh/elfin/net/volley/VolleyRequestManager;
    .param p3, "ua"    # Ljava/lang/String;

    .prologue
    const/4 v1, 0x0

    .line 50
    invoke-static {}, Lcom/cyjh/elfin/net/volley/VolleyRequestQueue;->getRequestQueue()Lcom/android/volley/RequestQueue;

    move-result-object v0

    invoke-virtual {v0, p1}, Lcom/android/volley/RequestQueue;->cancelAll(Ljava/lang/Object;)V

    .line 51
    new-instance v0, Lcom/cyjh/elfin/net/volley/VolleyManager$1;

    iget-object v3, p2, Lcom/cyjh/elfin/net/volley/VolleyRequestManager;->mVolleySuccessListener:Lcom/cyjh/elfin/net/volley/VolleyRequestManager$OnRequestSuccessListener;

    iget-object v4, p2, Lcom/cyjh/elfin/net/volley/VolleyRequestManager;->mVolleyErrorListener:Lcom/cyjh/elfin/net/volley/VolleyRequestManager$OnRequestErrorListener;

    move-object v2, p0

    move-object v5, p3

    invoke-direct/range {v0 .. v5}, Lcom/cyjh/elfin/net/volley/VolleyManager$1;-><init>(ILjava/lang/String;Lcom/android/volley/Response$Listener;Lcom/android/volley/Response$ErrorListener;Ljava/lang/String;)V

    sput-object v0, Lcom/cyjh/elfin/net/volley/VolleyManager;->mStringRequest:Lcom/android/volley/toolbox/StringRequest;

    .line 62
    sget-object v0, Lcom/cyjh/elfin/net/volley/VolleyManager;->mStringRequest:Lcom/android/volley/toolbox/StringRequest;

    invoke-virtual {v0, p1}, Lcom/android/volley/toolbox/StringRequest;->setTag(Ljava/lang/Object;)Lcom/android/volley/Request;

    .line 63
    new-instance v6, Lcom/android/volley/DefaultRetryPolicy;

    const/16 v0, 0xbb8

    const/4 v2, 0x1

    const/high16 v3, 0x3f800000    # 1.0f

    invoke-direct {v6, v0, v2, v3}, Lcom/android/volley/DefaultRetryPolicy;-><init>(IIF)V

    .line 64
    .local v6, "retryPolicy":Lcom/android/volley/RetryPolicy;
    sget-object v0, Lcom/cyjh/elfin/net/volley/VolleyManager;->mStringRequest:Lcom/android/volley/toolbox/StringRequest;

    invoke-virtual {v0, v6}, Lcom/android/volley/toolbox/StringRequest;->setRetryPolicy(Lcom/android/volley/RetryPolicy;)Lcom/android/volley/Request;

    .line 65
    sget-object v0, Lcom/cyjh/elfin/net/volley/VolleyManager;->mStringRequest:Lcom/android/volley/toolbox/StringRequest;

    invoke-virtual {v0, v1}, Lcom/android/volley/toolbox/StringRequest;->setShouldCache(Z)Lcom/android/volley/Request;

    .line 66
    invoke-static {}, Lcom/cyjh/elfin/net/volley/VolleyRequestQueue;->getRequestQueue()Lcom/android/volley/RequestQueue;

    move-result-object v0

    sget-object v1, Lcom/cyjh/elfin/net/volley/VolleyManager;->mStringRequest:Lcom/android/volley/toolbox/StringRequest;

    invoke-virtual {v0, v1}, Lcom/android/volley/RequestQueue;->add(Lcom/android/volley/Request;)Lcom/android/volley/Request;

    .line 67
    return-void
.end method
