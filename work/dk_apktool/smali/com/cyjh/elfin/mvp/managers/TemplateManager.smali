.class public Lcom/cyjh/elfin/mvp/managers/TemplateManager;
.super Ljava/lang/Object;
.source "TemplateManager.java"

# interfaces
.implements Lcom/cyjh/elfin/mvp/managers/BaseManager;


# instance fields
.field private callback:Lcom/cyjh/elfin/mvp/managers/Callback;
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "Lcom/cyjh/elfin/mvp/managers/Callback",
            "<",
            "Lcom/cyjh/elfin/entity/TemplateStatus;",
            ">;"
        }
    .end annotation
.end field


# direct methods
.method public constructor <init>()V
    .locals 0

    .prologue
    .line 20
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method

.method private templateChecked(Ljava/lang/String;Lcom/cyjh/elfin/mvp/managers/Callback;Landroid/content/Context;Ljava/lang/String;)V
    .locals 1
    .param p1, "tag"    # Ljava/lang/String;
    .param p3, "context"    # Landroid/content/Context;
    .param p4, "url"    # Ljava/lang/String;
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "(",
            "Ljava/lang/String;",
            "Lcom/cyjh/elfin/mvp/managers/Callback",
            "<",
            "Lcom/cyjh/elfin/entity/TemplateStatus;",
            ">;",
            "Landroid/content/Context;",
            "Ljava/lang/String;",
            ")V"
        }
    .end annotation

    .prologue
    .line 31
    .local p2, "callback":Lcom/cyjh/elfin/mvp/managers/Callback;, "Lcom/cyjh/elfin/mvp/managers/Callback<Lcom/cyjh/elfin/entity/TemplateStatus;>;"
    iput-object p2, p0, Lcom/cyjh/elfin/mvp/managers/TemplateManager;->callback:Lcom/cyjh/elfin/mvp/managers/Callback;

    .line 32
    new-instance v0, Lcom/cyjh/elfin/mvp/managers/TemplateManager$1;

    invoke-direct {v0, p0, p3, p2}, Lcom/cyjh/elfin/mvp/managers/TemplateManager$1;-><init>(Lcom/cyjh/elfin/mvp/managers/TemplateManager;Landroid/content/Context;Lcom/cyjh/elfin/mvp/managers/Callback;)V

    invoke-static {p4, p1, v0}, Lcom/cyjh/elfin/net/volley/VolleyManager;->requestStringGet(Ljava/lang/String;Ljava/lang/String;Lcom/cyjh/elfin/net/volley/VolleyRequestManager;)V

    .line 53
    return-void
.end method


# virtual methods
.method public singleApkOrTemplateChecked(Ljava/lang/String;Lcom/cyjh/elfin/mvp/managers/Callback;Landroid/content/Context;Ljava/lang/String;)V
    .locals 5
    .param p1, "tag"    # Ljava/lang/String;
    .param p3, "context"    # Landroid/content/Context;
    .param p4, "interfaceName"    # Ljava/lang/String;
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "(",
            "Ljava/lang/String;",
            "Lcom/cyjh/elfin/mvp/managers/Callback",
            "<",
            "Lcom/cyjh/elfin/entity/TemplateStatus;",
            ">;",
            "Landroid/content/Context;",
            "Ljava/lang/String;",
            ")V"
        }
    .end annotation

    .prologue
    .line 62
    .local p2, "callback":Lcom/cyjh/elfin/mvp/managers/Callback;, "Lcom/cyjh/elfin/mvp/managers/Callback<Lcom/cyjh/elfin/entity/TemplateStatus;>;"
    const/4 v0, 0x0

    .line 63
    .local v0, "mBuilder":Landroid/net/Uri$Builder;
    const-string v2, "GetMonomerInstallationPackage"

    invoke-virtual {p4, v2}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v2

    if-eqz v2, :cond_0

    .line 66
    const-string v2, "auth.51moba.com"

    invoke-static {v2, p4}, Lcom/cyjh/elfin/constant/MyBuildConfig;->getBuilder(Ljava/lang/String;Ljava/lang/String;)Landroid/net/Uri$Builder;

    move-result-object v2

    const-string v3, "packagename"

    .line 67
    invoke-virtual {p3}, Landroid/content/Context;->getPackageName()Ljava/lang/String;

    move-result-object v4

    invoke-virtual {v2, v3, v4}, Landroid/net/Uri$Builder;->appendQueryParameter(Ljava/lang/String;Ljava/lang/String;)Landroid/net/Uri$Builder;

    move-result-object v0

    .line 73
    :goto_0
    const-string v2, "type"

    sget-object v3, Lcom/cyjh/elfin/constant/URLConstant;->PAY_OR_Free:Ljava/lang/String;

    invoke-virtual {v0, v2, v3}, Landroid/net/Uri$Builder;->appendQueryParameter(Ljava/lang/String;Ljava/lang/String;)Landroid/net/Uri$Builder;

    move-result-object v2

    const-string v3, "version"

    .line 74
    invoke-static {p3}, Lcom/cyjh/elfin/util/AppDeviceUtils;->getVersionName(Landroid/content/Context;)Ljava/lang/String;

    move-result-object v4

    invoke-virtual {v2, v3, v4}, Landroid/net/Uri$Builder;->appendQueryParameter(Ljava/lang/String;Ljava/lang/String;)Landroid/net/Uri$Builder;

    move-result-object v2

    .line 75
    invoke-virtual {v2}, Landroid/net/Uri$Builder;->build()Landroid/net/Uri;

    move-result-object v2

    invoke-virtual {v2}, Landroid/net/Uri;->toString()Ljava/lang/String;

    move-result-object v1

    .line 76
    .local v1, "templateOrSingleApkUrl":Ljava/lang/String;
    new-instance v2, Ljava/lang/StringBuilder;

    invoke-direct {v2}, Ljava/lang/StringBuilder;-><init>()V

    const-string v3, "\u6a21\u677furl:"

    invoke-virtual {v2, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    invoke-virtual {v2, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    invoke-virtual {v2}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v2

    const/4 v3, 0x0

    new-array v3, v3, [Ljava/lang/Object;

    invoke-static {v2, v3}, Lcom/orhanobut/logger/Logger;->e(Ljava/lang/String;[Ljava/lang/Object;)V

    .line 77
    invoke-direct {p0, p1, p2, p3, v1}, Lcom/cyjh/elfin/mvp/managers/TemplateManager;->templateChecked(Ljava/lang/String;Lcom/cyjh/elfin/mvp/managers/Callback;Landroid/content/Context;Ljava/lang/String;)V

    .line 78
    return-void

    .line 71
    .end local v1    # "templateOrSingleApkUrl":Ljava/lang/String;
    :cond_0
    const-string v2, "auth.51moba.com"

    invoke-static {v2, p4}, Lcom/cyjh/elfin/constant/MyBuildConfig;->getBuilder(Ljava/lang/String;Ljava/lang/String;)Landroid/net/Uri$Builder;

    move-result-object v0

    goto :goto_0
.end method
