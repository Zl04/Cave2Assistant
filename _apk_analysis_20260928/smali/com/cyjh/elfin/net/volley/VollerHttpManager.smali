.class public Lcom/cyjh/elfin/net/volley/VollerHttpManager;
.super Ljava/lang/Object;
.source "VollerHttpManager.java"


# static fields
.field public static final TAG:Ljava/lang/String; = "VollerHttpManager"

.field private static manager:Lcom/cyjh/elfin/net/volley/VollerHttpManager;


# instance fields
.field private mContextRequestMap:Ljava/util/Map;
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "Ljava/util/Map",
            "<",
            "Landroid/content/Context;",
            "Ljava/util/HashSet",
            "<",
            "Lcom/android/volley/Request;",
            ">;>;"
        }
    .end annotation
.end field

.field private mQueue:Lcom/android/volley/RequestQueue;


# direct methods
.method private constructor <init>()V
    .locals 1

    .prologue
    .line 28
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    .line 26
    new-instance v0, Ljava/util/HashMap;

    invoke-direct {v0}, Ljava/util/HashMap;-><init>()V

    iput-object v0, p0, Lcom/cyjh/elfin/net/volley/VollerHttpManager;->mContextRequestMap:Ljava/util/Map;

    .line 30
    return-void
.end method

.method public static getInstance()Lcom/cyjh/elfin/net/volley/VollerHttpManager;
    .locals 1

    .prologue
    .line 33
    sget-object v0, Lcom/cyjh/elfin/net/volley/VollerHttpManager;->manager:Lcom/cyjh/elfin/net/volley/VollerHttpManager;

    if-nez v0, :cond_0

    .line 34
    new-instance v0, Lcom/cyjh/elfin/net/volley/VollerHttpManager;

    invoke-direct {v0}, Lcom/cyjh/elfin/net/volley/VollerHttpManager;-><init>()V

    sput-object v0, Lcom/cyjh/elfin/net/volley/VollerHttpManager;->manager:Lcom/cyjh/elfin/net/volley/VollerHttpManager;

    .line 36
    :cond_0
    sget-object v0, Lcom/cyjh/elfin/net/volley/VollerHttpManager;->manager:Lcom/cyjh/elfin/net/volley/VollerHttpManager;

    return-object v0
.end method


# virtual methods
.method public addRequest(Landroid/content/Context;Ljava/lang/Object;Lcom/android/volley/Request;)V
    .locals 3
    .param p1, "context"    # Landroid/content/Context;
    .param p2, "tag"    # Ljava/lang/Object;
    .param p3, "request"    # Lcom/android/volley/Request;

    .prologue
    .line 77
    iget-object v1, p0, Lcom/cyjh/elfin/net/volley/VollerHttpManager;->mQueue:Lcom/android/volley/RequestQueue;

    if-eqz v1, :cond_2

    .line 78
    if-eqz p1, :cond_1

    .line 79
    iget-object v1, p0, Lcom/cyjh/elfin/net/volley/VollerHttpManager;->mContextRequestMap:Ljava/util/Map;

    invoke-interface {v1, p1}, Ljava/util/Map;->get(Ljava/lang/Object;)Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Ljava/util/HashSet;

    .line 80
    .local v0, "set":Ljava/util/HashSet;, "Ljava/util/HashSet<Lcom/android/volley/Request;>;"
    if-nez v0, :cond_0

    .line 81
    new-instance v0, Ljava/util/HashSet;

    .end local v0    # "set":Ljava/util/HashSet;, "Ljava/util/HashSet<Lcom/android/volley/Request;>;"
    invoke-direct {v0}, Ljava/util/HashSet;-><init>()V

    .line 83
    .restart local v0    # "set":Ljava/util/HashSet;, "Ljava/util/HashSet<Lcom/android/volley/Request;>;"
    :cond_0
    invoke-virtual {v0, p3}, Ljava/util/HashSet;->add(Ljava/lang/Object;)Z

    .line 85
    .end local v0    # "set":Ljava/util/HashSet;, "Ljava/util/HashSet<Lcom/android/volley/Request;>;"
    :cond_1
    invoke-virtual {p0, p2}, Lcom/cyjh/elfin/net/volley/VollerHttpManager;->stopRequest(Ljava/lang/Object;)V

    .line 86
    invoke-virtual {p3, p2}, Lcom/android/volley/Request;->setTag(Ljava/lang/Object;)Lcom/android/volley/Request;

    .line 87
    iget-object v1, p0, Lcom/cyjh/elfin/net/volley/VollerHttpManager;->mQueue:Lcom/android/volley/RequestQueue;

    invoke-virtual {v1, p3}, Lcom/android/volley/RequestQueue;->add(Lcom/android/volley/Request;)Lcom/android/volley/Request;

    .line 92
    :goto_0
    return-void

    .line 90
    :cond_2
    const-string v1, "VollerHttpManager"

    const-string v2, "\u4f60\u5e94\u8be5\u5728 application\u4e2d\u521d\u59cb\u5316\u961f\u5217"

    invoke-static {v1, v2}, Landroid/util/Log;->i(Ljava/lang/String;Ljava/lang/String;)I

    goto :goto_0
.end method

.method public addRequest(Ljava/lang/Object;Lcom/android/volley/Request;)V
    .locals 2
    .param p1, "tag"    # Ljava/lang/Object;
    .param p2, "request"    # Lcom/android/volley/Request;

    .prologue
    .line 61
    iget-object v0, p0, Lcom/cyjh/elfin/net/volley/VollerHttpManager;->mQueue:Lcom/android/volley/RequestQueue;

    if-eqz v0, :cond_0

    .line 62
    invoke-virtual {p0, p1}, Lcom/cyjh/elfin/net/volley/VollerHttpManager;->stopRequest(Ljava/lang/Object;)V

    .line 63
    invoke-virtual {p2, p1}, Lcom/android/volley/Request;->setTag(Ljava/lang/Object;)Lcom/android/volley/Request;

    .line 64
    iget-object v0, p0, Lcom/cyjh/elfin/net/volley/VollerHttpManager;->mQueue:Lcom/android/volley/RequestQueue;

    invoke-virtual {v0, p2}, Lcom/android/volley/RequestQueue;->add(Lcom/android/volley/Request;)Lcom/android/volley/Request;

    .line 65
    iget-object v0, p0, Lcom/cyjh/elfin/net/volley/VollerHttpManager;->mQueue:Lcom/android/volley/RequestQueue;

    invoke-virtual {v0}, Lcom/android/volley/RequestQueue;->start()V

    .line 69
    :goto_0
    return-void

    .line 67
    :cond_0
    const-string v0, "VollerHttpManager"

    const-string v1, "\u4f60\u5e94\u8be5\u5728 application\u4e2d\u521d\u59cb\u5316\u961f\u5217"

    invoke-static {v0, v1}, Landroid/util/Log;->i(Ljava/lang/String;Ljava/lang/String;)I

    goto :goto_0
.end method

.method public init(Landroid/content/Context;)V
    .locals 1
    .param p1, "context"    # Landroid/content/Context;

    .prologue
    .line 45
    iget-object v0, p0, Lcom/cyjh/elfin/net/volley/VollerHttpManager;->mQueue:Lcom/android/volley/RequestQueue;

    if-nez v0, :cond_0

    .line 46
    invoke-static {p1}, Lcom/android/volley/toolbox/Volley;->newRequestQueue(Landroid/content/Context;)Lcom/android/volley/RequestQueue;

    move-result-object v0

    iput-object v0, p0, Lcom/cyjh/elfin/net/volley/VollerHttpManager;->mQueue:Lcom/android/volley/RequestQueue;

    .line 48
    :cond_0
    return-void
.end method

.method public init(Lcom/android/volley/RequestQueue;)V
    .locals 0
    .param p1, "mQueue"    # Lcom/android/volley/RequestQueue;

    .prologue
    .line 51
    iput-object p1, p0, Lcom/cyjh/elfin/net/volley/VollerHttpManager;->mQueue:Lcom/android/volley/RequestQueue;

    .line 52
    return-void
.end method

.method public stopRequest(Landroid/content/Context;)V
    .locals 5
    .param p1, "context"    # Landroid/content/Context;

    .prologue
    .line 115
    iget-object v2, p0, Lcom/cyjh/elfin/net/volley/VollerHttpManager;->mQueue:Lcom/android/volley/RequestQueue;

    if-eqz v2, :cond_0

    .line 116
    iget-object v2, p0, Lcom/cyjh/elfin/net/volley/VollerHttpManager;->mContextRequestMap:Ljava/util/Map;

    invoke-interface {v2, p1}, Ljava/util/Map;->get(Ljava/lang/Object;)Ljava/lang/Object;

    move-result-object v1

    check-cast v1, Ljava/util/HashSet;

    .line 117
    .local v1, "set":Ljava/util/HashSet;, "Ljava/util/HashSet<Lcom/android/volley/Request;>;"
    if-eqz v1, :cond_1

    .line 118
    invoke-virtual {v1}, Ljava/util/HashSet;->iterator()Ljava/util/Iterator;

    move-result-object v2

    :goto_0
    invoke-interface {v2}, Ljava/util/Iterator;->hasNext()Z

    move-result v3

    if-eqz v3, :cond_1

    invoke-interface {v2}, Ljava/util/Iterator;->next()Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Lcom/android/volley/Request;

    .line 119
    .local v0, "request":Lcom/android/volley/Request;
    iget-object v3, p0, Lcom/cyjh/elfin/net/volley/VollerHttpManager;->mQueue:Lcom/android/volley/RequestQueue;

    invoke-virtual {v0}, Lcom/android/volley/Request;->getTag()Ljava/lang/Object;

    move-result-object v4

    invoke-virtual {v3, v4}, Lcom/android/volley/RequestQueue;->cancelAll(Ljava/lang/Object;)V

    goto :goto_0

    .line 125
    .end local v0    # "request":Lcom/android/volley/Request;
    .end local v1    # "set":Ljava/util/HashSet;, "Ljava/util/HashSet<Lcom/android/volley/Request;>;"
    :cond_0
    const-string v2, "VollerHttpManager"

    const-string v3, "\u4f60\u5e94\u8be5\u5728 application\u4e2d\u521d\u59cb\u5316\u961f\u5217"

    invoke-static {v2, v3}, Landroid/util/Log;->i(Ljava/lang/String;Ljava/lang/String;)I

    .line 127
    :cond_1
    return-void
.end method

.method public stopRequest(Ljava/lang/Object;)V
    .locals 2
    .param p1, "tag"    # Ljava/lang/Object;

    .prologue
    .line 101
    iget-object v0, p0, Lcom/cyjh/elfin/net/volley/VollerHttpManager;->mQueue:Lcom/android/volley/RequestQueue;

    if-eqz v0, :cond_0

    .line 102
    iget-object v0, p0, Lcom/cyjh/elfin/net/volley/VollerHttpManager;->mQueue:Lcom/android/volley/RequestQueue;

    invoke-virtual {v0, p1}, Lcom/android/volley/RequestQueue;->cancelAll(Ljava/lang/Object;)V

    .line 107
    :goto_0
    return-void

    .line 105
    :cond_0
    const-string v0, "VollerHttpManager"

    const-string v1, "\u4f60\u5e94\u8be5\u5728 application\u4e2d\u521d\u59cb\u5316\u961f\u5217"

    invoke-static {v0, v1}, Landroid/util/Log;->i(Ljava/lang/String;Ljava/lang/String;)I

    goto :goto_0
.end method
