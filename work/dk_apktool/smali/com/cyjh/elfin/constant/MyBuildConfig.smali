.class public Lcom/cyjh/elfin/constant/MyBuildConfig;
.super Ljava/lang/Object;
.source "MyBuildConfig.java"


# static fields
.field public static final API:Ljava/lang/String; = "api"

.field public static final AUTHORITY:Ljava/lang/String; = "api.51moba.com"

.field public static final AUTHORITY_AD:Ljava/lang/String; = "api.51moba.com"

.field public static final AUTHORITY_VERIFY:Ljava/lang/String; = "auth.51moba.com"

.field public static final LOG_AUTHORITY:Ljava/lang/String; = "logapi.mobileanjian.com"

.field private static final SCHEME:Ljava/lang/String; = "http"


# direct methods
.method public constructor <init>()V
    .locals 0

    .prologue
    .line 10
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method

.method public static getBuilder(Ljava/lang/String;Ljava/lang/String;)Landroid/net/Uri$Builder;
    .locals 3
    .param p0, "authority"    # Ljava/lang/String;
    .param p1, "path"    # Ljava/lang/String;

    .prologue
    .line 28
    new-instance v0, Landroid/net/Uri$Builder;

    invoke-direct {v0}, Landroid/net/Uri$Builder;-><init>()V

    .line 29
    .local v0, "builder":Landroid/net/Uri$Builder;
    const-string v1, "http"

    invoke-virtual {v0, v1}, Landroid/net/Uri$Builder;->scheme(Ljava/lang/String;)Landroid/net/Uri$Builder;

    move-result-object v1

    invoke-virtual {v1, p0}, Landroid/net/Uri$Builder;->encodedAuthority(Ljava/lang/String;)Landroid/net/Uri$Builder;

    move-result-object v1

    const-string v2, "api"

    invoke-virtual {v1, v2}, Landroid/net/Uri$Builder;->appendPath(Ljava/lang/String;)Landroid/net/Uri$Builder;

    move-result-object v1

    invoke-virtual {v1, p1}, Landroid/net/Uri$Builder;->appendPath(Ljava/lang/String;)Landroid/net/Uri$Builder;

    move-result-object v1

    return-object v1
.end method

.method public static isOutputLog()Z
    .locals 1

    .prologue
    .line 37
    const/4 v0, 0x0

    return v0
.end method
