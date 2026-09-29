.class Lcom/kaopu/download/abst/ADownloadDisplayHelper$DownloadViewNotifyBroadcastReceiver;
.super Landroid/content/BroadcastReceiver;
.source "ADownloadDisplayHelper.java"


# annotations
.annotation system Ldalvik/annotation/EnclosingClass;
    value = Lcom/kaopu/download/abst/ADownloadDisplayHelper;
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x2
    name = "DownloadViewNotifyBroadcastReceiver"
.end annotation


# instance fields
.field final synthetic this$0:Lcom/kaopu/download/abst/ADownloadDisplayHelper;


# direct methods
.method private constructor <init>(Lcom/kaopu/download/abst/ADownloadDisplayHelper;)V
    .locals 0

    .prologue
    .line 57
    iput-object p1, p0, Lcom/kaopu/download/abst/ADownloadDisplayHelper$DownloadViewNotifyBroadcastReceiver;->this$0:Lcom/kaopu/download/abst/ADownloadDisplayHelper;

    invoke-direct {p0}, Landroid/content/BroadcastReceiver;-><init>()V

    return-void
.end method

.method synthetic constructor <init>(Lcom/kaopu/download/abst/ADownloadDisplayHelper;Lcom/kaopu/download/abst/ADownloadDisplayHelper$DownloadViewNotifyBroadcastReceiver;)V
    .locals 0

    .prologue
    .line 57
    invoke-direct {p0, p1}, Lcom/kaopu/download/abst/ADownloadDisplayHelper$DownloadViewNotifyBroadcastReceiver;-><init>(Lcom/kaopu/download/abst/ADownloadDisplayHelper;)V

    return-void
.end method


# virtual methods
.method public onReceive(Landroid/content/Context;Landroid/content/Intent;)V
    .locals 1
    .param p1, "context"    # Landroid/content/Context;
    .param p2, "intent"    # Landroid/content/Intent;

    .prologue
    .line 61
    iget-object v0, p0, Lcom/kaopu/download/abst/ADownloadDisplayHelper$DownloadViewNotifyBroadcastReceiver;->this$0:Lcom/kaopu/download/abst/ADownloadDisplayHelper;

    invoke-virtual {v0, p1, p2}, Lcom/kaopu/download/abst/ADownloadDisplayHelper;->onReceiveResult(Landroid/content/Context;Landroid/content/Intent;)V

    .line 62
    return-void
.end method
