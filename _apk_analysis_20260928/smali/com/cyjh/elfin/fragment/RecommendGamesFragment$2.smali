.class Lcom/cyjh/elfin/fragment/RecommendGamesFragment$2;
.super Ljava/lang/Object;
.source "RecommendGamesFragment.java"

# interfaces
.implements Landroid/webkit/DownloadListener;


# annotations
.annotation system Ldalvik/annotation/EnclosingMethod;
    value = Lcom/cyjh/elfin/fragment/RecommendGamesFragment;->showWebView(Ljava/lang/String;)V
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x0
    name = null
.end annotation


# instance fields
.field final synthetic this$0:Lcom/cyjh/elfin/fragment/RecommendGamesFragment;


# direct methods
.method constructor <init>(Lcom/cyjh/elfin/fragment/RecommendGamesFragment;)V
    .locals 0
    .param p1, "this$0"    # Lcom/cyjh/elfin/fragment/RecommendGamesFragment;

    .prologue
    .line 128
    iput-object p1, p0, Lcom/cyjh/elfin/fragment/RecommendGamesFragment$2;->this$0:Lcom/cyjh/elfin/fragment/RecommendGamesFragment;

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method


# virtual methods
.method public onDownloadStart(Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;J)V
    .locals 5
    .param p1, "url"    # Ljava/lang/String;
    .param p2, "userAgent"    # Ljava/lang/String;
    .param p3, "contentDisposition"    # Ljava/lang/String;
    .param p4, "mimetype"    # Ljava/lang/String;
    .param p5, "contentLength"    # J

    .prologue
    .line 132
    iget-object v1, p0, Lcom/cyjh/elfin/fragment/RecommendGamesFragment$2;->this$0:Lcom/cyjh/elfin/fragment/RecommendGamesFragment;

    iget-object v1, v1, Lcom/cyjh/elfin/fragment/RecommendGamesFragment;->commonLog:Lcom/cyjh/elfin/log/CommonLog;

    new-instance v2, Ljava/lang/StringBuilder;

    invoke-direct {v2}, Ljava/lang/StringBuilder;-><init>()V

    const-string v3, "url:"

    invoke-virtual {v2, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    invoke-virtual {v2, p1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    const-string v3, "--,userAgent:"

    invoke-virtual {v2, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    invoke-virtual {v2, p2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    const-string v3, "--,contentDisposition="

    invoke-virtual {v2, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    .line 133
    invoke-static {p3}, Ljava/net/URLDecoder;->decode(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v3

    invoke-virtual {v2, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    const-string v3, "--,mimetype"

    invoke-virtual {v2, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    invoke-virtual {v2, p4}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    const-string v3, "--,contentLength="

    invoke-virtual {v2, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    invoke-virtual {v2, p5, p6}, Ljava/lang/StringBuilder;->append(J)Ljava/lang/StringBuilder;

    move-result-object v2

    invoke-virtual {v2}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v2

    .line 132
    invoke-virtual {v1, v2}, Lcom/cyjh/elfin/log/CommonLog;->e(Ljava/lang/Object;)V

    .line 134
    iget-object v1, p0, Lcom/cyjh/elfin/fragment/RecommendGamesFragment$2;->this$0:Lcom/cyjh/elfin/fragment/RecommendGamesFragment;

    invoke-static {v1}, Lcom/cyjh/elfin/fragment/RecommendGamesFragment;->access$000(Lcom/cyjh/elfin/fragment/RecommendGamesFragment;)Z

    move-result v1

    if-nez v1, :cond_0

    .line 135
    iget-object v1, p0, Lcom/cyjh/elfin/fragment/RecommendGamesFragment$2;->this$0:Lcom/cyjh/elfin/fragment/RecommendGamesFragment;

    const/4 v2, 0x1

    invoke-static {v1, v2}, Lcom/cyjh/elfin/fragment/RecommendGamesFragment;->access$002(Lcom/cyjh/elfin/fragment/RecommendGamesFragment;Z)Z

    .line 136
    iget-object v1, p0, Lcom/cyjh/elfin/fragment/RecommendGamesFragment$2;->this$0:Lcom/cyjh/elfin/fragment/RecommendGamesFragment;

    iget-object v1, v1, Lcom/cyjh/elfin/fragment/RecommendGamesFragment;->commonLog:Lcom/cyjh/elfin/log/CommonLog;

    new-instance v2, Ljava/lang/StringBuilder;

    invoke-direct {v2}, Ljava/lang/StringBuilder;-><init>()V

    const-string v3, "\u63a8\u8350\u6e38\u620fapk\u4e0b\u8f7d:"

    invoke-virtual {v2, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    iget-object v3, p0, Lcom/cyjh/elfin/fragment/RecommendGamesFragment$2;->this$0:Lcom/cyjh/elfin/fragment/RecommendGamesFragment;

    invoke-static {v3}, Lcom/cyjh/elfin/fragment/RecommendGamesFragment;->access$000(Lcom/cyjh/elfin/fragment/RecommendGamesFragment;)Z

    move-result v3

    invoke-virtual {v2, v3}, Ljava/lang/StringBuilder;->append(Z)Ljava/lang/StringBuilder;

    move-result-object v2

    invoke-virtual {v2}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v2

    invoke-virtual {v1, v2}, Lcom/cyjh/elfin/log/CommonLog;->e(Ljava/lang/Object;)V

    .line 137
    new-instance v0, Landroid/content/Intent;

    iget-object v1, p0, Lcom/cyjh/elfin/fragment/RecommendGamesFragment$2;->this$0:Lcom/cyjh/elfin/fragment/RecommendGamesFragment;

    invoke-virtual {v1}, Lcom/cyjh/elfin/fragment/RecommendGamesFragment;->getActivity()Landroid/support/v4/app/FragmentActivity;

    move-result-object v1

    const-class v2, Lcom/cyjh/elfin/services/DownloadApkService;

    invoke-direct {v0, v1, v2}, Landroid/content/Intent;-><init>(Landroid/content/Context;Ljava/lang/Class;)V

    .line 138
    .local v0, "iDownloadApk":Landroid/content/Intent;
    const-string v1, "games_apk_url"

    invoke-virtual {v0, v1, p1}, Landroid/content/Intent;->putExtra(Ljava/lang/String;Ljava/lang/String;)Landroid/content/Intent;

    .line 139
    iget-object v1, p0, Lcom/cyjh/elfin/fragment/RecommendGamesFragment$2;->this$0:Lcom/cyjh/elfin/fragment/RecommendGamesFragment;

    invoke-virtual {v1}, Lcom/cyjh/elfin/fragment/RecommendGamesFragment;->getActivity()Landroid/support/v4/app/FragmentActivity;

    move-result-object v1

    invoke-virtual {v1, v0}, Landroid/support/v4/app/FragmentActivity;->startService(Landroid/content/Intent;)Landroid/content/ComponentName;

    .line 141
    .end local v0    # "iDownloadApk":Landroid/content/Intent;
    :cond_0
    return-void
.end method
