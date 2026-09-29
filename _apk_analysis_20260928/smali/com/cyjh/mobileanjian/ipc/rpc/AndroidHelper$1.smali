.class final Lcom/cyjh/mobileanjian/ipc/rpc/AndroidHelper$1;
.super Landroid/content/BroadcastReceiver;
.source "SourceFile"


# annotations
.annotation system Ldalvik/annotation/EnclosingMethod;
    value = Lcom/cyjh/mobileanjian/ipc/rpc/AndroidHelper;->batteryLevel()Ljava/lang/String;
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x8
    name = null
.end annotation


# direct methods
.method constructor <init>()V
    .locals 0

    .prologue
    .line 250
    invoke-direct {p0}, Landroid/content/BroadcastReceiver;-><init>()V

    return-void
.end method


# virtual methods
.method public onReceive(Landroid/content/Context;Landroid/content/Intent;)V
    .locals 3

    .prologue
    const/4 v2, -0x1

    .line 253
    invoke-virtual {p1, p0}, Landroid/content/Context;->unregisterReceiver(Landroid/content/BroadcastReceiver;)V

    .line 254
    const-string v0, "level"

    invoke-virtual {p2, v0, v2}, Landroid/content/Intent;->getIntExtra(Ljava/lang/String;I)I

    move-result v0

    .line 255
    const-string v1, "scale"

    invoke-virtual {p2, v1, v2}, Landroid/content/Intent;->getIntExtra(Ljava/lang/String;I)I

    move-result v1

    .line 256
    if-ltz v0, :cond_0

    if-lez v1, :cond_0

    .line 258
    mul-int/lit8 v0, v0, 0x64

    div-int/2addr v0, v1

    invoke-static {v0}, Lcom/cyjh/mobileanjian/ipc/rpc/AndroidHelper;->a(I)I

    .line 260
    :cond_0
    const/4 v0, 0x1

    invoke-static {v0}, Lcom/cyjh/mobileanjian/ipc/rpc/AndroidHelper;->a(Z)Z

    .line 261
    return-void
.end method
