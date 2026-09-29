.class public Lcom/cyjh/elfin/mvp/managers/GetServerTimeManager;
.super Ljava/lang/Object;
.source "GetServerTimeManager.java"

# interfaces
.implements Lcom/cyjh/elfin/mvp/managers/BaseManager;


# direct methods
.method public constructor <init>()V
    .locals 0

    .prologue
    .line 18
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method


# virtual methods
.method public getServerTime(Landroid/content/Context;)V
    .locals 3
    .param p1, "context"    # Landroid/content/Context;

    .prologue
    .line 20
    const-string v1, "api.51moba.com"

    const-string v2, "GetDateTime"

    invoke-static {v1, v2}, Lcom/cyjh/elfin/constant/MyBuildConfig;->getBuilder(Ljava/lang/String;Ljava/lang/String;)Landroid/net/Uri$Builder;

    move-result-object v1

    .line 21
    invoke-virtual {v1}, Landroid/net/Uri$Builder;->build()Landroid/net/Uri;

    move-result-object v1

    invoke-virtual {v1}, Landroid/net/Uri;->toString()Ljava/lang/String;

    move-result-object v0

    .line 22
    .local v0, "serverTimeUrl":Ljava/lang/String;
    const-class v1, Lcom/cyjh/elfin/mvp/managers/GetServerTimeManager;

    invoke-virtual {v1}, Ljava/lang/Class;->getCanonicalName()Ljava/lang/String;

    move-result-object v1

    new-instance v2, Lcom/cyjh/elfin/mvp/managers/GetServerTimeManager$1;

    invoke-direct {v2, p0, p1}, Lcom/cyjh/elfin/mvp/managers/GetServerTimeManager$1;-><init>(Lcom/cyjh/elfin/mvp/managers/GetServerTimeManager;Landroid/content/Context;)V

    invoke-static {v0, v1, v2}, Lcom/cyjh/elfin/net/volley/VolleyManager;->requestStringGet(Ljava/lang/String;Ljava/lang/String;Lcom/cyjh/elfin/net/volley/VolleyRequestManager;)V

    .line 34
    return-void
.end method
