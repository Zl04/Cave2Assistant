.class final Lcom/cyjh/elfin/mvp/managers/IFLYAdCountStatistics$1;
.super Lcom/cyjh/elfin/net/volley/VolleyRequestManager;
.source "IFLYAdCountStatistics.java"


# annotations
.annotation system Ldalvik/annotation/EnclosingMethod;
    value = Lcom/cyjh/elfin/mvp/managers/IFLYAdCountStatistics;->requestCountStatistics(Landroid/content/Context;I)V
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
    .line 30
    invoke-direct {p0, p1}, Lcom/cyjh/elfin/net/volley/VolleyRequestManager;-><init>(Landroid/content/Context;)V

    return-void
.end method


# virtual methods
.method public onRequestErrorRes(Ljava/lang/String;)V
    .locals 0
    .param p1, "msg"    # Ljava/lang/String;

    .prologue
    .line 39
    return-void
.end method

.method public onRequestSuccessRes(Ljava/lang/String;)V
    .locals 0
    .param p1, "res"    # Ljava/lang/String;

    .prologue
    .line 34
    return-void
.end method
