.class Lcom/cyjh/elfin/dialog/DownloadDialogFragment$1;
.super Ljava/lang/Thread;
.source "DownloadDialogFragment.java"


# annotations
.annotation system Ldalvik/annotation/EnclosingMethod;
    value = Lcom/cyjh/elfin/dialog/DownloadDialogFragment;->onActivityCreated(Landroid/os/Bundle;)V
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x0
    name = null
.end annotation


# instance fields
.field final synthetic this$0:Lcom/cyjh/elfin/dialog/DownloadDialogFragment;


# direct methods
.method constructor <init>(Lcom/cyjh/elfin/dialog/DownloadDialogFragment;)V
    .locals 0
    .param p1, "this$0"    # Lcom/cyjh/elfin/dialog/DownloadDialogFragment;

    .prologue
    .line 131
    iput-object p1, p0, Lcom/cyjh/elfin/dialog/DownloadDialogFragment$1;->this$0:Lcom/cyjh/elfin/dialog/DownloadDialogFragment;

    invoke-direct {p0}, Ljava/lang/Thread;-><init>()V

    return-void
.end method


# virtual methods
.method public run()V
    .locals 5

    .prologue
    .line 135
    :try_start_0
    new-instance v2, Ljava/net/URL;

    iget-object v3, p0, Lcom/cyjh/elfin/dialog/DownloadDialogFragment$1;->this$0:Lcom/cyjh/elfin/dialog/DownloadDialogFragment;

    iget-object v3, v3, Lcom/cyjh/elfin/dialog/DownloadDialogFragment;->apkDownloadUrl:Ljava/lang/String;

    invoke-direct {v2, v3}, Ljava/net/URL;-><init>(Ljava/lang/String;)V

    .line 136
    .local v2, "url":Ljava/net/URL;
    invoke-virtual {v2}, Ljava/net/URL;->openConnection()Ljava/net/URLConnection;

    move-result-object v0

    check-cast v0, Ljava/net/HttpURLConnection;

    .line 137
    .local v0, "connection":Ljava/net/HttpURLConnection;
    invoke-virtual {v0}, Ljava/net/HttpURLConnection;->getResponseCode()I

    move-result v3

    const/16 v4, 0xc8

    if-ne v3, v4, :cond_0

    .line 138
    iget-object v3, p0, Lcom/cyjh/elfin/dialog/DownloadDialogFragment$1;->this$0:Lcom/cyjh/elfin/dialog/DownloadDialogFragment;

    invoke-virtual {v0}, Ljava/net/HttpURLConnection;->getContentLength()I

    move-result v4

    invoke-static {v3, v4}, Lcom/cyjh/elfin/dialog/DownloadDialogFragment;->access$002(Lcom/cyjh/elfin/dialog/DownloadDialogFragment;I)I

    .line 139
    iget-object v3, p0, Lcom/cyjh/elfin/dialog/DownloadDialogFragment$1;->this$0:Lcom/cyjh/elfin/dialog/DownloadDialogFragment;

    invoke-static {v3}, Lcom/cyjh/elfin/dialog/DownloadDialogFragment;->access$100(Lcom/cyjh/elfin/dialog/DownloadDialogFragment;)Landroid/os/Handler;

    move-result-object v3

    const/16 v4, 0x3e9

    invoke-virtual {v3, v4}, Landroid/os/Handler;->sendEmptyMessage(I)Z
    :try_end_0
    .catch Ljava/net/MalformedURLException; {:try_start_0 .. :try_end_0} :catch_0
    .catch Ljava/io/IOException; {:try_start_0 .. :try_end_0} :catch_1

    .line 146
    .end local v0    # "connection":Ljava/net/HttpURLConnection;
    .end local v2    # "url":Ljava/net/URL;
    :cond_0
    :goto_0
    return-void

    .line 141
    :catch_0
    move-exception v1

    .line 142
    .local v1, "e":Ljava/net/MalformedURLException;
    invoke-virtual {v1}, Ljava/net/MalformedURLException;->printStackTrace()V

    goto :goto_0

    .line 143
    .end local v1    # "e":Ljava/net/MalformedURLException;
    :catch_1
    move-exception v3

    goto :goto_0
.end method
