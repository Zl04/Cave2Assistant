.class Lcom/cyjh/elfin/fragment/RecommendGamesFragment$1;
.super Landroid/webkit/WebViewClient;
.source "RecommendGamesFragment.java"


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
    .line 121
    iput-object p1, p0, Lcom/cyjh/elfin/fragment/RecommendGamesFragment$1;->this$0:Lcom/cyjh/elfin/fragment/RecommendGamesFragment;

    invoke-direct {p0}, Landroid/webkit/WebViewClient;-><init>()V

    return-void
.end method


# virtual methods
.method public shouldOverrideUrlLoading(Landroid/webkit/WebView;Ljava/lang/String;)Z
    .locals 1
    .param p1, "view"    # Landroid/webkit/WebView;
    .param p2, "url"    # Ljava/lang/String;

    .prologue
    .line 124
    invoke-virtual {p1, p2}, Landroid/webkit/WebView;->loadUrl(Ljava/lang/String;)V

    .line 125
    const/4 v0, 0x1

    return v0
.end method
