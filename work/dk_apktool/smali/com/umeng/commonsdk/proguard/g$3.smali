.class Lcom/umeng/commonsdk/proguard/g$3;
.super Ljava/util/TimerTask;
.source "UMSysLocation.java"


# annotations
.annotation system Ldalvik/annotation/EnclosingMethod;
    value = Lcom/umeng/commonsdk/proguard/g;->a(Lcom/umeng/commonsdk/proguard/i;)V
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x0
    name = null
.end annotation


# instance fields
.field final synthetic a:Ljava/util/Timer;

.field final synthetic b:Lcom/umeng/commonsdk/proguard/g;


# direct methods
.method constructor <init>(Lcom/umeng/commonsdk/proguard/g;Ljava/util/Timer;)V
    .locals 0

    .prologue
    .line 148
    iput-object p1, p0, Lcom/umeng/commonsdk/proguard/g$3;->b:Lcom/umeng/commonsdk/proguard/g;

    iput-object p2, p0, Lcom/umeng/commonsdk/proguard/g$3;->a:Ljava/util/Timer;

    invoke-direct {p0}, Ljava/util/TimerTask;-><init>()V

    return-void
.end method


# virtual methods
.method public run()V
    .locals 4

    .prologue
    .line 152
    :try_start_0
    const-string v0, "UMSysLocation"

    const/4 v1, 0x1

    new-array v1, v1, [Ljava/lang/Object;

    const/4 v2, 0x0

    const-string v3, "GPS_PROVIDER runing"

    aput-object v3, v1, v2

    invoke-static {v0, v1}, Lcom/umeng/commonsdk/statistics/common/e;->a(Ljava/lang/String;[Ljava/lang/Object;)V

    .line 153
    iget-object v0, p0, Lcom/umeng/commonsdk/proguard/g$3;->a:Ljava/util/Timer;

    if-eqz v0, :cond_0

    .line 154
    iget-object v0, p0, Lcom/umeng/commonsdk/proguard/g$3;->a:Ljava/util/Timer;

    invoke-virtual {v0}, Ljava/util/Timer;->cancel()V

    .line 156
    :cond_0
    iget-object v0, p0, Lcom/umeng/commonsdk/proguard/g$3;->b:Lcom/umeng/commonsdk/proguard/g;

    invoke-static {v0}, Lcom/umeng/commonsdk/proguard/g;->c(Lcom/umeng/commonsdk/proguard/g;)Z

    move-result v0

    if-eqz v0, :cond_2

    .line 157
    iget-object v0, p0, Lcom/umeng/commonsdk/proguard/g$3;->b:Lcom/umeng/commonsdk/proguard/g;

    invoke-static {v0}, Lcom/umeng/commonsdk/proguard/g;->d(Lcom/umeng/commonsdk/proguard/g;)Landroid/location/LocationManager;

    move-result-object v0

    if-eqz v0, :cond_1

    iget-object v0, p0, Lcom/umeng/commonsdk/proguard/g$3;->b:Lcom/umeng/commonsdk/proguard/g;

    invoke-static {v0}, Lcom/umeng/commonsdk/proguard/g;->e(Lcom/umeng/commonsdk/proguard/g;)Landroid/location/LocationListener;
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_0

    move-result-object v0

    if-eqz v0, :cond_1

    .line 159
    :try_start_1
    iget-object v0, p0, Lcom/umeng/commonsdk/proguard/g$3;->b:Lcom/umeng/commonsdk/proguard/g;

    invoke-static {v0}, Lcom/umeng/commonsdk/proguard/g;->d(Lcom/umeng/commonsdk/proguard/g;)Landroid/location/LocationManager;

    move-result-object v0

    iget-object v1, p0, Lcom/umeng/commonsdk/proguard/g$3;->b:Lcom/umeng/commonsdk/proguard/g;

    invoke-static {v1}, Lcom/umeng/commonsdk/proguard/g;->e(Lcom/umeng/commonsdk/proguard/g;)Landroid/location/LocationListener;

    move-result-object v1

    invoke-virtual {v0, v1}, Landroid/location/LocationManager;->removeUpdates(Landroid/location/LocationListener;)V
    :try_end_1
    .catch Ljava/lang/RuntimeException; {:try_start_1 .. :try_end_1} :catch_2
    .catch Ljava/lang/Throwable; {:try_start_1 .. :try_end_1} :catch_1

    .line 166
    :cond_1
    :goto_0
    :try_start_2
    iget-object v0, p0, Lcom/umeng/commonsdk/proguard/g$3;->b:Lcom/umeng/commonsdk/proguard/g;

    invoke-static {v0}, Lcom/umeng/commonsdk/proguard/g;->a(Lcom/umeng/commonsdk/proguard/g;)Lcom/umeng/commonsdk/proguard/i;

    move-result-object v0

    if-eqz v0, :cond_2

    .line 167
    iget-object v0, p0, Lcom/umeng/commonsdk/proguard/g$3;->b:Lcom/umeng/commonsdk/proguard/g;

    invoke-static {v0}, Lcom/umeng/commonsdk/proguard/g;->a(Lcom/umeng/commonsdk/proguard/g;)Lcom/umeng/commonsdk/proguard/i;

    move-result-object v0

    const/4 v1, 0x0

    invoke-virtual {v0, v1}, Lcom/umeng/commonsdk/proguard/i;->a(Landroid/location/Location;)V
    :try_end_2
    .catch Ljava/lang/Throwable; {:try_start_2 .. :try_end_2} :catch_0

    .line 173
    :cond_2
    :goto_1
    return-void

    .line 170
    :catch_0
    move-exception v0

    .line 171
    iget-object v1, p0, Lcom/umeng/commonsdk/proguard/g$3;->b:Lcom/umeng/commonsdk/proguard/g;

    invoke-static {v1}, Lcom/umeng/commonsdk/proguard/g;->b(Lcom/umeng/commonsdk/proguard/g;)Landroid/content/Context;

    move-result-object v1

    invoke-static {v1, v0}, Lcom/umeng/commonsdk/proguard/e;->a(Landroid/content/Context;Ljava/lang/Throwable;)V

    goto :goto_1

    .line 162
    :catch_1
    move-exception v0

    goto :goto_0

    .line 160
    :catch_2
    move-exception v0

    goto :goto_0
.end method
