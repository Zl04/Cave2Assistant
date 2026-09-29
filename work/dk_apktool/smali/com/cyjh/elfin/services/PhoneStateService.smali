.class public Lcom/cyjh/elfin/services/PhoneStateService;
.super Lcom/cyjh/elfin/services/BaseService;
.source "PhoneStateService.java"


# annotations
.annotation system Ldalvik/annotation/MemberClasses;
    value = {
        Lcom/cyjh/elfin/services/PhoneStateService$PhoneStateReceiver;
    }
.end annotation


# static fields
.field private static mInstate:Lcom/cyjh/elfin/services/PhoneStateService;


# instance fields
.field private final PHONE_STATE:Ljava/lang/String;

.field private phoneStatReceiver:Lcom/cyjh/elfin/services/PhoneStateService$PhoneStateReceiver;


# direct methods
.method public constructor <init>()V
    .locals 1

    .prologue
    .line 32
    invoke-direct {p0}, Lcom/cyjh/elfin/services/BaseService;-><init>()V

    .line 38
    const-string v0, "android.intent.action.PHONE_STATE"

    iput-object v0, p0, Lcom/cyjh/elfin/services/PhoneStateService;->PHONE_STATE:Ljava/lang/String;

    return-void
.end method

.method private initNotification()V
    .locals 8

    .prologue
    const v7, 0x7f08003b

    const v5, 0x7f020098

    const/4 v6, 0x0

    .line 54
    new-instance v1, Landroid/content/Intent;

    const-class v4, Lcom/cyjh/elfin/activity/SplashActivity;

    invoke-direct {v1, p0, v4}, Landroid/content/Intent;-><init>(Landroid/content/Context;Ljava/lang/Class;)V

    .line 55
    .local v1, "intentNotification":Landroid/content/Intent;
    const-string v4, "android.intent.action.MAIN"

    invoke-virtual {v1, v4}, Landroid/content/Intent;->setAction(Ljava/lang/String;)Landroid/content/Intent;

    .line 56
    const-string v4, "android.intent.category.LAUNCHER"

    invoke-virtual {v1, v4}, Landroid/content/Intent;->addCategory(Ljava/lang/String;)Landroid/content/Intent;

    .line 58
    const/high16 v4, 0x8000000

    invoke-static {p0, v6, v1, v4}, Landroid/app/PendingIntent;->getActivity(Landroid/content/Context;ILandroid/content/Intent;I)Landroid/app/PendingIntent;

    move-result-object v3

    .line 60
    .local v3, "pendingIntent":Landroid/app/PendingIntent;
    new-instance v0, Landroid/support/v4/app/NotificationCompat$Builder;

    invoke-direct {v0, p0}, Landroid/support/v4/app/NotificationCompat$Builder;-><init>(Landroid/content/Context;)V

    .line 61
    .local v0, "builder":Landroid/support/v4/app/NotificationCompat$Builder;
    invoke-virtual {v0, v3}, Landroid/support/v4/app/NotificationCompat$Builder;->setContentIntent(Landroid/app/PendingIntent;)Landroid/support/v4/app/NotificationCompat$Builder;

    .line 62
    invoke-virtual {v0, v5}, Landroid/support/v4/app/NotificationCompat$Builder;->setSmallIcon(I)Landroid/support/v4/app/NotificationCompat$Builder;

    .line 63
    invoke-virtual {p0}, Lcom/cyjh/elfin/services/PhoneStateService;->getResources()Landroid/content/res/Resources;

    move-result-object v4

    invoke-static {v4, v5}, Landroid/graphics/BitmapFactory;->decodeResource(Landroid/content/res/Resources;I)Landroid/graphics/Bitmap;

    move-result-object v4

    invoke-virtual {v0, v4}, Landroid/support/v4/app/NotificationCompat$Builder;->setLargeIcon(Landroid/graphics/Bitmap;)Landroid/support/v4/app/NotificationCompat$Builder;

    .line 65
    invoke-static {}, Ljava/lang/System;->currentTimeMillis()J

    move-result-wide v4

    invoke-virtual {v0, v4, v5}, Landroid/support/v4/app/NotificationCompat$Builder;->setWhen(J)Landroid/support/v4/app/NotificationCompat$Builder;

    .line 66
    invoke-virtual {v0, v6}, Landroid/support/v4/app/NotificationCompat$Builder;->setAutoCancel(Z)Landroid/support/v4/app/NotificationCompat$Builder;

    .line 67
    invoke-virtual {p0, v7}, Lcom/cyjh/elfin/services/PhoneStateService;->getString(I)Ljava/lang/String;

    move-result-object v4

    invoke-virtual {v0, v4}, Landroid/support/v4/app/NotificationCompat$Builder;->setContentTitle(Ljava/lang/CharSequence;)Landroid/support/v4/app/NotificationCompat$Builder;

    .line 68
    new-instance v4, Ljava/lang/StringBuilder;

    invoke-direct {v4}, Ljava/lang/StringBuilder;-><init>()V

    invoke-virtual {p0, v7}, Lcom/cyjh/elfin/services/PhoneStateService;->getString(I)Ljava/lang/String;

    move-result-object v5

    invoke-virtual {v4, v5}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v4

    const v5, 0x7f0800ae

    invoke-virtual {p0, v5}, Lcom/cyjh/elfin/services/PhoneStateService;->getString(I)Ljava/lang/String;

    move-result-object v5

    invoke-virtual {v4, v5}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v4

    invoke-virtual {v4}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v4

    invoke-virtual {v0, v4}, Landroid/support/v4/app/NotificationCompat$Builder;->setContentText(Ljava/lang/CharSequence;)Landroid/support/v4/app/NotificationCompat$Builder;

    .line 69
    invoke-virtual {v0}, Landroid/support/v4/app/NotificationCompat$Builder;->build()Landroid/app/Notification;

    move-result-object v2

    .line 71
    .local v2, "notification":Landroid/app/Notification;
    invoke-virtual {p0}, Lcom/cyjh/elfin/services/PhoneStateService;->getResources()Landroid/content/res/Resources;

    move-result-object v4

    const v5, 0x7f0c0005

    invoke-virtual {v4, v5}, Landroid/content/res/Resources;->getInteger(I)I

    move-result v4

    invoke-virtual {p0, v4, v2}, Lcom/cyjh/elfin/services/PhoneStateService;->startForeground(ILandroid/app/Notification;)V

    .line 78
    return-void
.end method


# virtual methods
.method public onCreate()V
    .locals 2

    .prologue
    .line 42
    invoke-super {p0}, Lcom/cyjh/elfin/services/BaseService;->onCreate()V

    .line 45
    new-instance v1, Lcom/cyjh/elfin/services/PhoneStateService$PhoneStateReceiver;

    invoke-direct {v1, p0}, Lcom/cyjh/elfin/services/PhoneStateService$PhoneStateReceiver;-><init>(Lcom/cyjh/elfin/services/PhoneStateService;)V

    iput-object v1, p0, Lcom/cyjh/elfin/services/PhoneStateService;->phoneStatReceiver:Lcom/cyjh/elfin/services/PhoneStateService$PhoneStateReceiver;

    .line 46
    new-instance v0, Landroid/content/IntentFilter;

    invoke-direct {v0}, Landroid/content/IntentFilter;-><init>()V

    .line 47
    .local v0, "filter":Landroid/content/IntentFilter;
    const-string v1, "android.intent.action.NEW_OUTGOING_CALL"

    invoke-virtual {v0, v1}, Landroid/content/IntentFilter;->addAction(Ljava/lang/String;)V

    .line 48
    const-string v1, "android.intent.action.PHONE_STATE"

    invoke-virtual {v0, v1}, Landroid/content/IntentFilter;->addAction(Ljava/lang/String;)V

    .line 49
    iget-object v1, p0, Lcom/cyjh/elfin/services/PhoneStateService;->phoneStatReceiver:Lcom/cyjh/elfin/services/PhoneStateService$PhoneStateReceiver;

    invoke-virtual {p0, v1, v0}, Lcom/cyjh/elfin/services/PhoneStateService;->registerReceiver(Landroid/content/BroadcastReceiver;Landroid/content/IntentFilter;)Landroid/content/Intent;

    .line 50
    invoke-direct {p0}, Lcom/cyjh/elfin/services/PhoneStateService;->initNotification()V

    .line 51
    return-void
.end method

.method public onDestroy()V
    .locals 1

    .prologue
    .line 121
    iget-object v0, p0, Lcom/cyjh/elfin/services/PhoneStateService;->phoneStatReceiver:Lcom/cyjh/elfin/services/PhoneStateService$PhoneStateReceiver;

    invoke-virtual {p0, v0}, Lcom/cyjh/elfin/services/PhoneStateService;->unregisterReceiver(Landroid/content/BroadcastReceiver;)V

    .line 123
    invoke-super {p0}, Lcom/cyjh/elfin/services/BaseService;->onDestroy()V

    .line 124
    return-void
.end method

.method public onStartCommand(Landroid/content/Intent;II)I
    .locals 1
    .param p1, "intent"    # Landroid/content/Intent;
    .param p2, "flags"    # I
    .param p3, "startId"    # I

    .prologue
    .line 82
    invoke-super {p0, p1, p2, p3}, Lcom/cyjh/elfin/services/BaseService;->onStartCommand(Landroid/content/Intent;II)I

    move-result v0

    return v0
.end method
