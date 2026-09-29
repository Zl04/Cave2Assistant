.class public Lcom/cyjh/elfin/receiver/InstallAndRemoveAppSuccessReceive;
.super Landroid/content/BroadcastReceiver;
.source "InstallAndRemoveAppSuccessReceive.java"


# direct methods
.method public constructor <init>()V
    .locals 0

    .prologue
    .line 20
    invoke-direct {p0}, Landroid/content/BroadcastReceiver;-><init>()V

    return-void
.end method


# virtual methods
.method public onReceive(Landroid/content/Context;Landroid/content/Intent;)V
    .locals 3
    .param p1, "context"    # Landroid/content/Context;
    .param p2, "intent"    # Landroid/content/Intent;

    .prologue
    .line 25
    invoke-virtual {p2}, Landroid/content/Intent;->getAction()Ljava/lang/String;

    move-result-object v1

    const-string v2, "android.intent.action.PACKAGE_ADDED"

    invoke-virtual {v1, v2}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v1

    if-eqz v1, :cond_0

    .line 26
    invoke-virtual {p2}, Landroid/content/Intent;->getDataString()Ljava/lang/String;

    move-result-object v0

    .line 28
    .local v0, "packageName":Ljava/lang/String;
    invoke-static {}, Lorg/greenrobot/eventbus/EventBus;->getDefault()Lorg/greenrobot/eventbus/EventBus;

    move-result-object v1

    new-instance v2, Lcom/cyjh/elfin/entity/AbNormalGameEvent$InstallAppSuccessEvent;

    invoke-direct {v2, v0}, Lcom/cyjh/elfin/entity/AbNormalGameEvent$InstallAppSuccessEvent;-><init>(Ljava/lang/String;)V

    invoke-virtual {v1, v2}, Lorg/greenrobot/eventbus/EventBus;->post(Ljava/lang/Object;)V

    .line 32
    .end local v0    # "packageName":Ljava/lang/String;
    :cond_0
    invoke-virtual {p2}, Landroid/content/Intent;->getAction()Ljava/lang/String;

    move-result-object v1

    const-string v2, "android.intent.action.PACKAGE_REMOVED"

    invoke-virtual {v1, v2}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v1

    if-eqz v1, :cond_1

    .line 33
    invoke-virtual {p2}, Landroid/content/Intent;->getDataString()Ljava/lang/String;

    move-result-object v0

    .line 35
    .restart local v0    # "packageName":Ljava/lang/String;
    invoke-static {}, Lorg/greenrobot/eventbus/EventBus;->getDefault()Lorg/greenrobot/eventbus/EventBus;

    move-result-object v1

    new-instance v2, Lcom/cyjh/elfin/entity/AbNormalGameEvent$RemoveAppSuccessEvent;

    invoke-direct {v2, v0}, Lcom/cyjh/elfin/entity/AbNormalGameEvent$RemoveAppSuccessEvent;-><init>(Ljava/lang/String;)V

    invoke-virtual {v1, v2}, Lorg/greenrobot/eventbus/EventBus;->post(Ljava/lang/Object;)V

    .line 37
    .end local v0    # "packageName":Ljava/lang/String;
    :cond_1
    return-void
.end method
