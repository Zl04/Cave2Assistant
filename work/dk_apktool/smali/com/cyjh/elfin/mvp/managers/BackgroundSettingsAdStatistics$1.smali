.class Lcom/cyjh/elfin/mvp/managers/BackgroundSettingsAdStatistics$1;
.super Lcom/cyjh/elfin/net/volley/VolleyRequestManager;
.source "BackgroundSettingsAdStatistics.java"


# annotations
.annotation system Ldalvik/annotation/EnclosingMethod;
    value = Lcom/cyjh/elfin/mvp/managers/BackgroundSettingsAdStatistics;->backgroundStatisticsAdCount(Landroid/content/Context;Ljava/lang/String;Ljava/lang/String;)V
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x0
    name = null
.end annotation


# instance fields
.field final synthetic this$0:Lcom/cyjh/elfin/mvp/managers/BackgroundSettingsAdStatistics;


# direct methods
.method constructor <init>(Lcom/cyjh/elfin/mvp/managers/BackgroundSettingsAdStatistics;Landroid/content/Context;)V
    .locals 0
    .param p1, "this$0"    # Lcom/cyjh/elfin/mvp/managers/BackgroundSettingsAdStatistics;
    .param p2, "context"    # Landroid/content/Context;

    .prologue
    .line 34
    iput-object p1, p0, Lcom/cyjh/elfin/mvp/managers/BackgroundSettingsAdStatistics$1;->this$0:Lcom/cyjh/elfin/mvp/managers/BackgroundSettingsAdStatistics;

    invoke-direct {p0, p2}, Lcom/cyjh/elfin/net/volley/VolleyRequestManager;-><init>(Landroid/content/Context;)V

    return-void
.end method


# virtual methods
.method public onRequestErrorRes(Ljava/lang/String;)V
    .locals 0
    .param p1, "msg"    # Ljava/lang/String;

    .prologue
    .line 44
    return-void
.end method

.method public onRequestSuccessRes(Ljava/lang/String;)V
    .locals 2
    .param p1, "res"    # Ljava/lang/String;

    .prologue
    .line 38
    new-instance v0, Ljava/lang/StringBuilder;

    invoke-direct {v0}, Ljava/lang/StringBuilder;-><init>()V

    const-string v1, "BackgroundSettingsAdStatistics res"

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-virtual {v0, p1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-virtual {v0}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v0

    const/4 v1, 0x0

    new-array v1, v1, [Ljava/lang/Object;

    invoke-static {v0, v1}, Lcom/orhanobut/logger/Logger;->e(Ljava/lang/String;[Ljava/lang/Object;)V

    .line 39
    return-void
.end method
