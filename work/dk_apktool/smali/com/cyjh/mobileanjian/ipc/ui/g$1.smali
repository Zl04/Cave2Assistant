.class Lcom/cyjh/mobileanjian/ipc/ui/g$1;
.super Landroid/webkit/WebViewClient;
.source "SourceFile"


# annotations
.annotation system Ldalvik/annotation/EnclosingMethod;
    value = Lcom/cyjh/mobileanjian/ipc/ui/g;->a(ILjava/lang/String;IILjava/lang/String;)Landroid/webkit/WebView;
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x0
    name = null
.end annotation


# instance fields
.field final synthetic a:Lcom/cyjh/mobileanjian/ipc/ui/g;


# direct methods
.method constructor <init>(Lcom/cyjh/mobileanjian/ipc/ui/g;)V
    .locals 0

    .prologue
    .line 226
    iput-object p1, p0, Lcom/cyjh/mobileanjian/ipc/ui/g$1;->a:Lcom/cyjh/mobileanjian/ipc/ui/g;

    invoke-direct {p0}, Landroid/webkit/WebViewClient;-><init>()V

    return-void
.end method


# virtual methods
.method public shouldOverrideUrlLoading(Landroid/webkit/WebView;Ljava/lang/String;)Z
    .locals 1

    .prologue
    .line 230
    invoke-virtual {p1, p2}, Landroid/webkit/WebView;->loadUrl(Ljava/lang/String;)V

    .line 231
    const/4 v0, 0x1

    return v0
.end method
