.class public Lcom/cyjh/elfin/services/BaseService;
.super Landroid/app/Service;
.source "BaseService.java"

# interfaces
.implements Lcom/cyjh/elfin/constant/APPConstant;


# instance fields
.field protected appContext:Lcom/cyjh/elfin/AppContext;

.field protected commonLog:Lcom/cyjh/elfin/log/CommonLog;


# direct methods
.method public constructor <init>()V
    .locals 1

    .prologue
    .line 27
    invoke-direct {p0}, Landroid/app/Service;-><init>()V

    .line 28
    new-instance v0, Lcom/cyjh/elfin/log/CommonLog;

    invoke-direct {v0}, Lcom/cyjh/elfin/log/CommonLog;-><init>()V

    iput-object v0, p0, Lcom/cyjh/elfin/services/BaseService;->commonLog:Lcom/cyjh/elfin/log/CommonLog;

    return-void
.end method


# virtual methods
.method public onBind(Landroid/content/Intent;)Landroid/os/IBinder;
    .locals 1
    .param p1, "intent"    # Landroid/content/Intent;

    .prologue
    .line 34
    const/4 v0, 0x0

    return-object v0
.end method

.method public onCreate()V
    .locals 1

    .prologue
    .line 39
    invoke-super {p0}, Landroid/app/Service;->onCreate()V

    .line 40
    invoke-virtual {p0}, Lcom/cyjh/elfin/services/BaseService;->getApplicationContext()Landroid/content/Context;

    move-result-object v0

    check-cast v0, Lcom/cyjh/elfin/AppContext;

    iput-object v0, p0, Lcom/cyjh/elfin/services/BaseService;->appContext:Lcom/cyjh/elfin/AppContext;

    .line 41
    return-void
.end method

.method public onStartCommand(Landroid/content/Intent;II)I
    .locals 1
    .param p1, "intent"    # Landroid/content/Intent;
    .param p2, "flags"    # I
    .param p3, "startId"    # I

    .prologue
    .line 45
    invoke-super {p0, p1, p2, p3}, Landroid/app/Service;->onStartCommand(Landroid/content/Intent;II)I

    move-result v0

    return v0
.end method
