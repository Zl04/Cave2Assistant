.class Lcom/umeng/analytics/pro/h$1;
.super Ljava/lang/Object;
.source "AutoViewPageTracker.java"

# interfaces
.implements Landroid/app/Application$ActivityLifecycleCallbacks;


# annotations
.annotation system Ldalvik/annotation/EnclosingClass;
    value = Lcom/umeng/analytics/pro/h;
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x0
    name = null
.end annotation


# instance fields
.field final synthetic a:Lcom/umeng/analytics/pro/h;


# direct methods
.method constructor <init>(Lcom/umeng/analytics/pro/h;)V
    .locals 0

    .prologue
    .line 114
    iput-object p1, p0, Lcom/umeng/analytics/pro/h$1;->a:Lcom/umeng/analytics/pro/h;

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method


# virtual methods
.method public onActivityCreated(Landroid/app/Activity;Landroid/os/Bundle;)V
    .locals 0

    .prologue
    .line 152
    return-void
.end method

.method public onActivityDestroyed(Landroid/app/Activity;)V
    .locals 0

    .prologue
    .line 148
    return-void
.end method

.method public onActivityPaused(Landroid/app/Activity;)V
    .locals 2

    .prologue
    .line 142
    iget-object v0, p0, Lcom/umeng/analytics/pro/h$1;->a:Lcom/umeng/analytics/pro/h;

    invoke-static {v0, p1}, Lcom/umeng/analytics/pro/h;->b(Lcom/umeng/analytics/pro/h;Landroid/app/Activity;)V

    .line 143
    iget-object v0, p0, Lcom/umeng/analytics/pro/h$1;->a:Lcom/umeng/analytics/pro/h;

    const/4 v1, 0x0

    iput-boolean v1, v0, Lcom/umeng/analytics/pro/h;->c:Z

    .line 144
    return-void
.end method

.method public onActivityResumed(Landroid/app/Activity;)V
    .locals 3

    .prologue
    .line 130
    iget-object v0, p0, Lcom/umeng/analytics/pro/h$1;->a:Lcom/umeng/analytics/pro/h;

    iget-boolean v0, v0, Lcom/umeng/analytics/pro/h;->c:Z

    if-eqz v0, :cond_1

    .line 131
    iget-object v0, p0, Lcom/umeng/analytics/pro/h$1;->a:Lcom/umeng/analytics/pro/h;

    const/4 v1, 0x0

    iput-boolean v1, v0, Lcom/umeng/analytics/pro/h;->c:Z

    .line 132
    sget-object v0, Lcom/umeng/analytics/pro/h;->a:Ljava/lang/String;

    new-instance v1, Ljava/lang/StringBuilder;

    invoke-direct {v1}, Ljava/lang/StringBuilder;-><init>()V

    invoke-virtual {p1}, Landroid/app/Activity;->getPackageName()Ljava/lang/String;

    move-result-object v2

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    const-string v2, "."

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {p1}, Landroid/app/Activity;->getLocalClassName()Ljava/lang/String;

    move-result-object v2

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v1

    invoke-virtual {v0, v1}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v0

    if-nez v0, :cond_0

    .line 133
    iget-object v0, p0, Lcom/umeng/analytics/pro/h$1;->a:Lcom/umeng/analytics/pro/h;

    invoke-static {v0, p1}, Lcom/umeng/analytics/pro/h;->a(Lcom/umeng/analytics/pro/h;Landroid/app/Activity;)V

    .line 138
    :cond_0
    :goto_0
    return-void

    .line 136
    :cond_1
    iget-object v0, p0, Lcom/umeng/analytics/pro/h$1;->a:Lcom/umeng/analytics/pro/h;

    invoke-static {v0, p1}, Lcom/umeng/analytics/pro/h;->a(Lcom/umeng/analytics/pro/h;Landroid/app/Activity;)V

    goto :goto_0
.end method

.method public onActivitySaveInstanceState(Landroid/app/Activity;Landroid/os/Bundle;)V
    .locals 0

    .prologue
    .line 126
    return-void
.end method

.method public onActivityStarted(Landroid/app/Activity;)V
    .locals 0

    .prologue
    .line 122
    return-void
.end method

.method public onActivityStopped(Landroid/app/Activity;)V
    .locals 0

    .prologue
    .line 118
    return-void
.end method
