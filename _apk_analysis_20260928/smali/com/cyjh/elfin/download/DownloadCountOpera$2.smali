.class final Lcom/cyjh/elfin/download/DownloadCountOpera$2;
.super Lcom/cyjh/elfin/net/volley/VolleyRequestManager;
.source "DownloadCountOpera.java"


# annotations
.annotation system Ldalvik/annotation/EnclosingMethod;
    value = Lcom/cyjh/elfin/download/DownloadCountOpera;->requestClickerDownloadCount(Ljava/lang/String;Landroid/content/Context;)V
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x8
    name = null
.end annotation


# direct methods
.method constructor <init>(Landroid/content/Context;)V
    .locals 0
    .param p1, "context"    # Landroid/content/Context;

    .prologue
    .line 57
    invoke-direct {p0, p1}, Lcom/cyjh/elfin/net/volley/VolleyRequestManager;-><init>(Landroid/content/Context;)V

    return-void
.end method


# virtual methods
.method public onRequestErrorRes(Ljava/lang/String;)V
    .locals 0
    .param p1, "msg"    # Ljava/lang/String;

    .prologue
    .line 66
    return-void
.end method

.method public onRequestSuccessRes(Ljava/lang/String;)V
    .locals 2
    .param p1, "res"    # Ljava/lang/String;

    .prologue
    .line 60
    new-instance v0, Ljava/lang/StringBuilder;

    invoke-direct {v0}, Ljava/lang/StringBuilder;-><init>()V

    const-string v1, "\u70b9\u51fb\u4e0b\u8f7d\u6309\u94aeres:"

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-virtual {v0, p1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-virtual {v0}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v0

    const/4 v1, 0x0

    new-array v1, v1, [Ljava/lang/Object;

    invoke-static {v0, v1}, Lcom/orhanobut/logger/Logger;->e(Ljava/lang/String;[Ljava/lang/Object;)V

    .line 61
    return-void
.end method
