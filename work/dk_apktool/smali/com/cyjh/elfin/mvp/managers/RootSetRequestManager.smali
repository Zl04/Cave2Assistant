.class public Lcom/cyjh/elfin/mvp/managers/RootSetRequestManager;
.super Ljava/lang/Object;
.source "RootSetRequestManager.java"

# interfaces
.implements Lcom/cyjh/elfin/mvp/managers/BaseManager;


# direct methods
.method public constructor <init>()V
    .locals 0

    .prologue
    .line 21
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method


# virtual methods
.method public isRootRequired(Ljava/lang/String;Landroid/content/Context;Ljava/lang/String;)V
    .locals 3
    .param p1, "path"    # Ljava/lang/String;
    .param p2, "context"    # Landroid/content/Context;
    .param p3, "tag"    # Ljava/lang/String;

    .prologue
    .line 24
    const-string v1, "api.51moba.com"

    invoke-static {v1, p1}, Lcom/cyjh/elfin/constant/MyBuildConfig;->getBuilder(Ljava/lang/String;Ljava/lang/String;)Landroid/net/Uri$Builder;

    move-result-object v1

    invoke-virtual {v1}, Landroid/net/Uri$Builder;->build()Landroid/net/Uri;

    move-result-object v1

    invoke-virtual {v1}, Landroid/net/Uri;->toString()Ljava/lang/String;

    move-result-object v0

    .line 25
    .local v0, "url":Ljava/lang/String;
    new-instance v1, Ljava/lang/StringBuilder;

    invoke-direct {v1}, Ljava/lang/StringBuilder;-><init>()V

    const-string v2, "url:"

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1, v0}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v1

    const/4 v2, 0x0

    new-array v2, v2, [Ljava/lang/Object;

    invoke-static {v1, v2}, Lcom/orhanobut/logger/Logger;->e(Ljava/lang/String;[Ljava/lang/Object;)V

    .line 26
    new-instance v1, Lcom/cyjh/elfin/mvp/managers/RootSetRequestManager$1;

    invoke-direct {v1, p0, p2}, Lcom/cyjh/elfin/mvp/managers/RootSetRequestManager$1;-><init>(Lcom/cyjh/elfin/mvp/managers/RootSetRequestManager;Landroid/content/Context;)V

    invoke-static {v0, p3, v1}, Lcom/cyjh/elfin/net/volley/VolleyManager;->requestStringGet(Ljava/lang/String;Ljava/lang/String;Lcom/cyjh/elfin/net/volley/VolleyRequestManager;)V

    .line 41
    return-void
.end method
