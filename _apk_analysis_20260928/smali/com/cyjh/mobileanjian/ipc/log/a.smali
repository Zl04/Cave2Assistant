.class public abstract Lcom/cyjh/mobileanjian/ipc/log/a;
.super Ljava/lang/Object;
.source "SourceFile"


# instance fields
.field protected a:Landroid/content/Context;

.field protected b:Ljava/lang/String;


# direct methods
.method public constructor <init>(Landroid/content/Context;)V
    .locals 0

    .prologue
    .line 19
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    .line 20
    iput-object p1, p0, Lcom/cyjh/mobileanjian/ipc/log/a;->a:Landroid/content/Context;

    .line 21
    return-void
.end method


# virtual methods
.method protected abstract a()V
.end method

.method protected abstract b()Ljava/lang/String;
.end method

.method public commit()V
    .locals 5

    .prologue
    .line 28
    invoke-virtual {p0}, Lcom/cyjh/mobileanjian/ipc/log/a;->a()V

    .line 30
    new-instance v0, Lcom/lidroid/xutils/HttpUtils;

    invoke-direct {v0}, Lcom/lidroid/xutils/HttpUtils;-><init>()V

    .line 31
    new-instance v1, Lcom/lidroid/xutils/http/RequestParams;

    invoke-direct {v1}, Lcom/lidroid/xutils/http/RequestParams;-><init>()V

    .line 32
    invoke-virtual {p0}, Lcom/cyjh/mobileanjian/ipc/log/a;->b()Ljava/lang/String;

    move-result-object v2

    .line 33
    const-string v3, "Data"

    invoke-virtual {v1, v3, v2}, Lcom/lidroid/xutils/http/RequestParams;->addQueryStringParameter(Ljava/lang/String;Ljava/lang/String;)V

    .line 34
    sget-object v2, Lcom/lidroid/xutils/http/client/HttpRequest$HttpMethod;->GET:Lcom/lidroid/xutils/http/client/HttpRequest$HttpMethod;

    iget-object v3, p0, Lcom/cyjh/mobileanjian/ipc/log/a;->b:Ljava/lang/String;

    const/4 v4, 0x0

    invoke-virtual {v0, v2, v3, v1, v4}, Lcom/lidroid/xutils/HttpUtils;->send(Lcom/lidroid/xutils/http/client/HttpRequest$HttpMethod;Ljava/lang/String;Lcom/lidroid/xutils/http/RequestParams;Lcom/lidroid/xutils/http/callback/RequestCallBack;)Lcom/lidroid/xutils/http/HttpHandler;

    .line 35
    return-void
.end method
