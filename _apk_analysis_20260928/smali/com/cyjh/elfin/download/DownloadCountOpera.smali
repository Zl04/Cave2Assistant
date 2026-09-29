.class public Lcom/cyjh/elfin/download/DownloadCountOpera;
.super Ljava/lang/Object;
.source "DownloadCountOpera.java"


# direct methods
.method public constructor <init>()V
    .locals 0

    .prologue
    .line 19
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method

.method public static requestClickerDownloadCount(Ljava/lang/String;Landroid/content/Context;)V
    .locals 4
    .param p0, "id"    # Ljava/lang/String;
    .param p1, "context"    # Landroid/content/Context;

    .prologue
    .line 52
    const-string v1, "api.51moba.com"

    const-string v2, "SetElfAbnormalGameDownLoadCount"

    invoke-static {v1, v2}, Lcom/cyjh/elfin/constant/MyBuildConfig;->getBuilder(Ljava/lang/String;Ljava/lang/String;)Landroid/net/Uri$Builder;

    move-result-object v1

    const-string v2, "id"

    .line 53
    invoke-virtual {v1, v2, p0}, Landroid/net/Uri$Builder;->appendQueryParameter(Ljava/lang/String;Ljava/lang/String;)Landroid/net/Uri$Builder;

    move-result-object v1

    const-string v2, "type"

    const-string v3, "1"

    .line 54
    invoke-virtual {v1, v2, v3}, Landroid/net/Uri$Builder;->appendQueryParameter(Ljava/lang/String;Ljava/lang/String;)Landroid/net/Uri$Builder;

    move-result-object v1

    .line 55
    invoke-virtual {v1}, Landroid/net/Uri$Builder;->build()Landroid/net/Uri;

    move-result-object v1

    invoke-virtual {v1}, Landroid/net/Uri;->toString()Ljava/lang/String;

    move-result-object v0

    .line 56
    .local v0, "url":Ljava/lang/String;
    new-instance v1, Ljava/lang/StringBuilder;

    invoke-direct {v1}, Ljava/lang/StringBuilder;-><init>()V

    const-string v2, "requestClickerDownloadCount:"

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1, v0}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v1

    const/4 v2, 0x0

    new-array v2, v2, [Ljava/lang/Object;

    invoke-static {v1, v2}, Lcom/orhanobut/logger/Logger;->e(Ljava/lang/String;[Ljava/lang/Object;)V

    .line 57
    const-class v1, Lcom/cyjh/elfin/download/DownloadCountOpera;

    invoke-virtual {v1}, Ljava/lang/Class;->getCanonicalName()Ljava/lang/String;

    move-result-object v1

    new-instance v2, Lcom/cyjh/elfin/download/DownloadCountOpera$2;

    invoke-direct {v2, p1}, Lcom/cyjh/elfin/download/DownloadCountOpera$2;-><init>(Landroid/content/Context;)V

    invoke-static {v0, v1, v2}, Lcom/cyjh/elfin/net/volley/VolleyManager;->requestStringGet(Ljava/lang/String;Ljava/lang/String;Lcom/cyjh/elfin/net/volley/VolleyRequestManager;)V

    .line 68
    return-void
.end method

.method public static requestDownloadCompleteCount(Ljava/lang/String;Landroid/content/Context;)V
    .locals 4
    .param p0, "id"    # Ljava/lang/String;
    .param p1, "context"    # Landroid/content/Context;

    .prologue
    .line 27
    const-string v1, "api.51moba.com"

    const-string v2, "SetElfAbnormalGameDownLoadCount"

    invoke-static {v1, v2}, Lcom/cyjh/elfin/constant/MyBuildConfig;->getBuilder(Ljava/lang/String;Ljava/lang/String;)Landroid/net/Uri$Builder;

    move-result-object v1

    const-string v2, "id"

    .line 28
    invoke-virtual {v1, v2, p0}, Landroid/net/Uri$Builder;->appendQueryParameter(Ljava/lang/String;Ljava/lang/String;)Landroid/net/Uri$Builder;

    move-result-object v1

    const-string v2, "type"

    const-string v3, "2"

    .line 29
    invoke-virtual {v1, v2, v3}, Landroid/net/Uri$Builder;->appendQueryParameter(Ljava/lang/String;Ljava/lang/String;)Landroid/net/Uri$Builder;

    move-result-object v1

    .line 30
    invoke-virtual {v1}, Landroid/net/Uri$Builder;->build()Landroid/net/Uri;

    move-result-object v1

    invoke-virtual {v1}, Landroid/net/Uri;->toString()Ljava/lang/String;

    move-result-object v0

    .line 31
    .local v0, "url":Ljava/lang/String;
    new-instance v1, Ljava/lang/StringBuilder;

    invoke-direct {v1}, Ljava/lang/StringBuilder;-><init>()V

    const-string v2, "requestDownloadCompleteCount:"

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1, v0}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v1

    const/4 v2, 0x0

    new-array v2, v2, [Ljava/lang/Object;

    invoke-static {v1, v2}, Lcom/orhanobut/logger/Logger;->e(Ljava/lang/String;[Ljava/lang/Object;)V

    .line 32
    const-class v1, Lcom/cyjh/elfin/download/DownloadCountOpera;

    invoke-virtual {v1}, Ljava/lang/Class;->getCanonicalName()Ljava/lang/String;

    move-result-object v1

    new-instance v2, Lcom/cyjh/elfin/download/DownloadCountOpera$1;

    invoke-direct {v2, p1}, Lcom/cyjh/elfin/download/DownloadCountOpera$1;-><init>(Landroid/content/Context;)V

    invoke-static {v0, v1, v2}, Lcom/cyjh/elfin/net/volley/VolleyManager;->requestStringGet(Ljava/lang/String;Ljava/lang/String;Lcom/cyjh/elfin/net/volley/VolleyRequestManager;)V

    .line 43
    return-void
.end method

.method public static requestEntranceGameCount(Landroid/content/Context;)V
    .locals 3
    .param p0, "context"    # Landroid/content/Context;

    .prologue
    .line 75
    const-string v1, "api.51moba.com"

    const-string v2, "SetElfEntranceOpenCount"

    invoke-static {v1, v2}, Lcom/cyjh/elfin/constant/MyBuildConfig;->getBuilder(Ljava/lang/String;Ljava/lang/String;)Landroid/net/Uri$Builder;

    move-result-object v1

    .line 76
    invoke-virtual {v1}, Landroid/net/Uri$Builder;->build()Landroid/net/Uri;

    move-result-object v1

    invoke-virtual {v1}, Landroid/net/Uri;->toString()Ljava/lang/String;

    move-result-object v0

    .line 77
    .local v0, "url":Ljava/lang/String;
    new-instance v1, Ljava/lang/StringBuilder;

    invoke-direct {v1}, Ljava/lang/StringBuilder;-><init>()V

    const-string v2, "requestEntranceGameCout:"

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1, v0}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v1

    const/4 v2, 0x0

    new-array v2, v2, [Ljava/lang/Object;

    invoke-static {v1, v2}, Lcom/orhanobut/logger/Logger;->e(Ljava/lang/String;[Ljava/lang/Object;)V

    .line 78
    const-class v1, Lcom/cyjh/elfin/download/DownloadCountOpera;

    invoke-virtual {v1}, Ljava/lang/Class;->getName()Ljava/lang/String;

    move-result-object v1

    new-instance v2, Lcom/cyjh/elfin/download/DownloadCountOpera$3;

    invoke-direct {v2, p0}, Lcom/cyjh/elfin/download/DownloadCountOpera$3;-><init>(Landroid/content/Context;)V

    invoke-static {v0, v1, v2}, Lcom/cyjh/elfin/net/volley/VolleyManager;->requestStringGet(Ljava/lang/String;Ljava/lang/String;Lcom/cyjh/elfin/net/volley/VolleyRequestManager;)V

    .line 89
    return-void
.end method
