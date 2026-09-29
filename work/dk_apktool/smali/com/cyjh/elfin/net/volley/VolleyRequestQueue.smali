.class public Lcom/cyjh/elfin/net/volley/VolleyRequestQueue;
.super Ljava/lang/Object;
.source "VolleyRequestQueue.java"


# direct methods
.method public constructor <init>()V
    .locals 0

    .prologue
    .line 9
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method

.method public static getRequestQueue()Lcom/android/volley/RequestQueue;
    .locals 1

    .prologue
    .line 11
    invoke-static {}, Lcom/cyjh/elfin/AppContext;->getmRequestQueue()Lcom/android/volley/RequestQueue;

    move-result-object v0

    return-object v0
.end method
