.class Lcom/umeng/commonsdk/proguard/g$1;
.super Ljava/lang/Object;
.source "UMSysLocation.java"

# interfaces
.implements Landroid/location/LocationListener;


# annotations
.annotation system Ldalvik/annotation/EnclosingClass;
    value = Lcom/umeng/commonsdk/proguard/g;
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x0
    name = null
.end annotation


# instance fields
.field final synthetic a:Lcom/umeng/commonsdk/proguard/g;


# direct methods
.method constructor <init>(Lcom/umeng/commonsdk/proguard/g;)V
    .locals 0

    .prologue
    .line 59
    iput-object p1, p0, Lcom/umeng/commonsdk/proguard/g$1;->a:Lcom/umeng/commonsdk/proguard/g;

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method


# virtual methods
.method public onLocationChanged(Landroid/location/Location;)V
    .locals 4

    .prologue
    const/4 v3, 0x0

    .line 74
    const-string v0, "UMSysLocation"

    const/4 v1, 0x1

    new-array v1, v1, [Ljava/lang/Object;

    const-string v2, "onLocationChanged"

    aput-object v2, v1, v3

    invoke-static {v0, v1}, Lcom/umeng/commonsdk/statistics/common/e;->a(Ljava/lang/String;[Ljava/lang/Object;)V

    .line 76
    :try_start_0
    iget-object v0, p0, Lcom/umeng/commonsdk/proguard/g$1;->a:Lcom/umeng/commonsdk/proguard/g;

    const/4 v1, 0x0

    invoke-static {v0, v1}, Lcom/umeng/commonsdk/proguard/g;->a(Lcom/umeng/commonsdk/proguard/g;Z)Z

    .line 77
    iget-object v0, p0, Lcom/umeng/commonsdk/proguard/g$1;->a:Lcom/umeng/commonsdk/proguard/g;

    invoke-static {v0}, Lcom/umeng/commonsdk/proguard/g;->a(Lcom/umeng/commonsdk/proguard/g;)Lcom/umeng/commonsdk/proguard/i;

    move-result-object v0

    if-eqz v0, :cond_0

    .line 78
    iget-object v0, p0, Lcom/umeng/commonsdk/proguard/g$1;->a:Lcom/umeng/commonsdk/proguard/g;

    invoke-static {v0}, Lcom/umeng/commonsdk/proguard/g;->a(Lcom/umeng/commonsdk/proguard/g;)Lcom/umeng/commonsdk/proguard/i;

    move-result-object v0

    invoke-virtual {v0, p1}, Lcom/umeng/commonsdk/proguard/i;->a(Landroid/location/Location;)V
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_0

    .line 83
    :cond_0
    :goto_0
    return-void

    .line 80
    :catch_0
    move-exception v0

    .line 81
    iget-object v1, p0, Lcom/umeng/commonsdk/proguard/g$1;->a:Lcom/umeng/commonsdk/proguard/g;

    invoke-static {v1}, Lcom/umeng/commonsdk/proguard/g;->b(Lcom/umeng/commonsdk/proguard/g;)Landroid/content/Context;

    move-result-object v1

    invoke-static {v1, v0}, Lcom/umeng/commonsdk/proguard/e;->a(Landroid/content/Context;Ljava/lang/Throwable;)V

    goto :goto_0
.end method

.method public onProviderDisabled(Ljava/lang/String;)V
    .locals 0

    .prologue
    .line 70
    return-void
.end method

.method public onProviderEnabled(Ljava/lang/String;)V
    .locals 0

    .prologue
    .line 66
    return-void
.end method

.method public onStatusChanged(Ljava/lang/String;ILandroid/os/Bundle;)V
    .locals 0

    .prologue
    .line 62
    return-void
.end method
