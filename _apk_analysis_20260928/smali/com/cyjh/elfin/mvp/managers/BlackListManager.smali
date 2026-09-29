.class public Lcom/cyjh/elfin/mvp/managers/BlackListManager;
.super Ljava/lang/Object;
.source "BlackListManager.java"

# interfaces
.implements Lcom/cyjh/elfin/mvp/managers/BaseManager;


# direct methods
.method public constructor <init>()V
    .locals 0

    .prologue
    .line 19
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method

.method private getBlackListUrl(Landroid/content/Context;)Ljava/lang/String;
    .locals 3
    .param p1, "context"    # Landroid/content/Context;

    .prologue
    .line 50
    const-string v0, "api.51moba.com"

    const-string v1, "GetElfBlackList"

    invoke-static {v0, v1}, Lcom/cyjh/elfin/constant/MyBuildConfig;->getBuilder(Ljava/lang/String;Ljava/lang/String;)Landroid/net/Uri$Builder;

    move-result-object v0

    const-string v1, "packagename"

    .line 51
    invoke-virtual {p1}, Landroid/content/Context;->getPackageName()Ljava/lang/String;

    move-result-object v2

    invoke-virtual {v0, v1, v2}, Landroid/net/Uri$Builder;->appendQueryParameter(Ljava/lang/String;Ljava/lang/String;)Landroid/net/Uri$Builder;

    move-result-object v0

    const-string v1, "type"

    sget-object v2, Lcom/cyjh/elfin/constant/URLConstant;->PAY_OR_Free:Ljava/lang/String;

    .line 52
    invoke-virtual {v0, v1, v2}, Landroid/net/Uri$Builder;->appendQueryParameter(Ljava/lang/String;Ljava/lang/String;)Landroid/net/Uri$Builder;

    move-result-object v0

    invoke-virtual {v0}, Landroid/net/Uri$Builder;->build()Landroid/net/Uri;

    move-result-object v0

    invoke-virtual {v0}, Landroid/net/Uri;->toString()Ljava/lang/String;

    move-result-object v0

    .line 50
    return-object v0
.end method


# virtual methods
.method public isSetBlackList(Landroid/content/Context;Ljava/lang/String;Lcom/cyjh/elfin/mvp/managers/Callback;)V
    .locals 2
    .param p1, "context"    # Landroid/content/Context;
    .param p2, "tag"    # Ljava/lang/String;
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "(",
            "Landroid/content/Context;",
            "Ljava/lang/String;",
            "Lcom/cyjh/elfin/mvp/managers/Callback",
            "<",
            "Ljava/lang/String;",
            ">;)V"
        }
    .end annotation

    .prologue
    .line 22
    .local p3, "callback":Lcom/cyjh/elfin/mvp/managers/Callback;, "Lcom/cyjh/elfin/mvp/managers/Callback<Ljava/lang/String;>;"
    invoke-direct {p0, p1}, Lcom/cyjh/elfin/mvp/managers/BlackListManager;->getBlackListUrl(Landroid/content/Context;)Ljava/lang/String;

    move-result-object v0

    new-instance v1, Lcom/cyjh/elfin/mvp/managers/BlackListManager$1;

    invoke-direct {v1, p0, p1, p3, p1}, Lcom/cyjh/elfin/mvp/managers/BlackListManager$1;-><init>(Lcom/cyjh/elfin/mvp/managers/BlackListManager;Landroid/content/Context;Lcom/cyjh/elfin/mvp/managers/Callback;Landroid/content/Context;)V

    invoke-static {v0, p2, v1}, Lcom/cyjh/elfin/net/volley/VolleyManager;->requestStringGet(Ljava/lang/String;Ljava/lang/String;Lcom/cyjh/elfin/net/volley/VolleyRequestManager;)V

    .line 47
    return-void
.end method
