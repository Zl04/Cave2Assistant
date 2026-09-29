.class public Lcom/cyjh/elfin/mvp/presenters/UpdateVersionPresenter;
.super Ljava/lang/Object;
.source "UpdateVersionPresenter.java"

# interfaces
.implements Lcom/cyjh/elfin/mvp/presenters/BasePresenter;


# static fields
.field private static final EMPTY_VALUE_NULL:Ljava/lang/String; = "null"


# instance fields
.field private commonLog:Lcom/cyjh/elfin/log/CommonLog;

.field private mContext:Landroid/content/Context;

.field private updateVersionView:Lcom/cyjh/elfin/mvp/views/UpdateVersionView;


# direct methods
.method public constructor <init>(Landroid/content/Context;Lcom/cyjh/elfin/mvp/views/UpdateVersionView;)V
    .locals 1
    .param p1, "mContext"    # Landroid/content/Context;
    .param p2, "updateVersionView"    # Lcom/cyjh/elfin/mvp/views/UpdateVersionView;

    .prologue
    .line 32
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    .line 33
    iput-object p1, p0, Lcom/cyjh/elfin/mvp/presenters/UpdateVersionPresenter;->mContext:Landroid/content/Context;

    .line 34
    new-instance v0, Lcom/cyjh/elfin/log/CommonLog;

    invoke-direct {v0}, Lcom/cyjh/elfin/log/CommonLog;-><init>()V

    iput-object v0, p0, Lcom/cyjh/elfin/mvp/presenters/UpdateVersionPresenter;->commonLog:Lcom/cyjh/elfin/log/CommonLog;

    .line 35
    iput-object p2, p0, Lcom/cyjh/elfin/mvp/presenters/UpdateVersionPresenter;->updateVersionView:Lcom/cyjh/elfin/mvp/views/UpdateVersionView;

    .line 36
    return-void
.end method

.method static synthetic access$000(Lcom/cyjh/elfin/mvp/presenters/UpdateVersionPresenter;)Lcom/cyjh/elfin/mvp/views/UpdateVersionView;
    .locals 1
    .param p0, "x0"    # Lcom/cyjh/elfin/mvp/presenters/UpdateVersionPresenter;

    .prologue
    .line 27
    iget-object v0, p0, Lcom/cyjh/elfin/mvp/presenters/UpdateVersionPresenter;->updateVersionView:Lcom/cyjh/elfin/mvp/views/UpdateVersionView;

    return-object v0
.end method

.method static synthetic access$100(Lcom/cyjh/elfin/mvp/presenters/UpdateVersionPresenter;)Lcom/cyjh/elfin/log/CommonLog;
    .locals 1
    .param p0, "x0"    # Lcom/cyjh/elfin/mvp/presenters/UpdateVersionPresenter;

    .prologue
    .line 27
    iget-object v0, p0, Lcom/cyjh/elfin/mvp/presenters/UpdateVersionPresenter;->commonLog:Lcom/cyjh/elfin/log/CommonLog;

    return-object v0
.end method


# virtual methods
.method public updateVersion(ZLandroid/content/Context;)V
    .locals 8
    .param p1, "isToast"    # Z
    .param p2, "context"    # Landroid/content/Context;

    .prologue
    .line 39
    iget-object v4, p0, Lcom/cyjh/elfin/mvp/presenters/UpdateVersionPresenter;->mContext:Landroid/content/Context;

    const v5, 0x7f0800bf

    invoke-virtual {v4, v5}, Landroid/content/Context;->getString(I)Ljava/lang/String;

    move-result-object v0

    .line 40
    .local v0, "appid":Ljava/lang/String;
    iget-object v4, p0, Lcom/cyjh/elfin/mvp/presenters/UpdateVersionPresenter;->mContext:Landroid/content/Context;

    invoke-virtual {v4}, Landroid/content/Context;->getPackageName()Ljava/lang/String;

    move-result-object v1

    .line 41
    .local v1, "packageName":Ljava/lang/String;
    iget-object v4, p0, Lcom/cyjh/elfin/mvp/presenters/UpdateVersionPresenter;->mContext:Landroid/content/Context;

    const v5, 0x7f0800c9

    invoke-virtual {v4, v5}, Landroid/content/Context;->getString(I)Ljava/lang/String;

    move-result-object v3

    .line 42
    .local v3, "version":Ljava/lang/String;
    iget-object v4, p0, Lcom/cyjh/elfin/mvp/presenters/UpdateVersionPresenter;->commonLog:Lcom/cyjh/elfin/log/CommonLog;

    new-instance v5, Ljava/lang/StringBuilder;

    invoke-direct {v5}, Ljava/lang/StringBuilder;-><init>()V

    const-string v6, "appid>>>"

    invoke-virtual {v5, v6}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v5

    invoke-virtual {v5, v0}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v5

    invoke-virtual {v5}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v5

    invoke-virtual {v4, v5}, Lcom/cyjh/elfin/log/CommonLog;->e(Ljava/lang/Object;)V

    .line 43
    iget-object v4, p0, Lcom/cyjh/elfin/mvp/presenters/UpdateVersionPresenter;->commonLog:Lcom/cyjh/elfin/log/CommonLog;

    new-instance v5, Ljava/lang/StringBuilder;

    invoke-direct {v5}, Ljava/lang/StringBuilder;-><init>()V

    const-string v6, "packageName>>>"

    invoke-virtual {v5, v6}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v5

    invoke-virtual {v5, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v5

    invoke-virtual {v5}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v5

    invoke-virtual {v4, v5}, Lcom/cyjh/elfin/log/CommonLog;->e(Ljava/lang/Object;)V

    .line 44
    iget-object v4, p0, Lcom/cyjh/elfin/mvp/presenters/UpdateVersionPresenter;->commonLog:Lcom/cyjh/elfin/log/CommonLog;

    new-instance v5, Ljava/lang/StringBuilder;

    invoke-direct {v5}, Ljava/lang/StringBuilder;-><init>()V

    const-string v6, "version>>>"

    invoke-virtual {v5, v6}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v5

    invoke-virtual {v5, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v5

    invoke-virtual {v5}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v5

    invoke-virtual {v4, v5}, Lcom/cyjh/elfin/log/CommonLog;->e(Ljava/lang/Object;)V

    .line 45
    iget-object v4, p0, Lcom/cyjh/elfin/mvp/presenters/UpdateVersionPresenter;->commonLog:Lcom/cyjh/elfin/log/CommonLog;

    new-instance v5, Ljava/lang/StringBuilder;

    invoke-direct {v5}, Ljava/lang/StringBuilder;-><init>()V

    const-string v6, "appid:"

    invoke-virtual {v5, v6}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v5

    invoke-virtual {v5, v0}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v5

    const-string v6, ",packageName="

    invoke-virtual {v5, v6}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v5

    invoke-virtual {v5, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v5

    const-string v6, ",version:"

    invoke-virtual {v5, v6}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v5

    invoke-virtual {v5, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v5

    invoke-virtual {v5}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v5

    invoke-virtual {v4, v5}, Lcom/cyjh/elfin/log/CommonLog;->e(Ljava/lang/Object;)V

    .line 46
    new-instance v2, Lcom/lidroid/xutils/http/RequestParams;

    invoke-direct {v2}, Lcom/lidroid/xutils/http/RequestParams;-><init>()V

    .line 47
    .local v2, "params":Lcom/lidroid/xutils/http/RequestParams;
    const-string v4, "AppId"

    invoke-virtual {v2, v4, v0}, Lcom/lidroid/xutils/http/RequestParams;->addQueryStringParameter(Ljava/lang/String;Ljava/lang/String;)V

    .line 48
    const-string v4, "PackageName"

    invoke-virtual {v2, v4, v1}, Lcom/lidroid/xutils/http/RequestParams;->addQueryStringParameter(Ljava/lang/String;Ljava/lang/String;)V

    .line 49
    const-string v4, "Version"

    invoke-virtual {v2, v4, v3}, Lcom/lidroid/xutils/http/RequestParams;->addQueryStringParameter(Ljava/lang/String;Ljava/lang/String;)V

    .line 50
    iget-object v4, p0, Lcom/cyjh/elfin/mvp/presenters/UpdateVersionPresenter;->mContext:Landroid/content/Context;

    invoke-static {v4}, Lcom/cyjh/elfin/net/xutils/XUtilsHttpClient;->getInstence(Landroid/content/Context;)Lcom/lidroid/xutils/HttpUtils;

    move-result-object v4

    sget-object v5, Lcom/lidroid/xutils/http/client/HttpRequest$HttpMethod;->GET:Lcom/lidroid/xutils/http/client/HttpRequest$HttpMethod;

    sget-object v6, Lcom/cyjh/elfin/constant/URLConstant;->UPDATE_URL:Ljava/lang/String;

    new-instance v7, Lcom/cyjh/elfin/mvp/presenters/UpdateVersionPresenter$1;

    invoke-direct {v7, p0, p1, p2}, Lcom/cyjh/elfin/mvp/presenters/UpdateVersionPresenter$1;-><init>(Lcom/cyjh/elfin/mvp/presenters/UpdateVersionPresenter;ZLandroid/content/Context;)V

    invoke-virtual {v4, v5, v6, v2, v7}, Lcom/lidroid/xutils/HttpUtils;->send(Lcom/lidroid/xutils/http/client/HttpRequest$HttpMethod;Ljava/lang/String;Lcom/lidroid/xutils/http/RequestParams;Lcom/lidroid/xutils/http/callback/RequestCallBack;)Lcom/lidroid/xutils/http/HttpHandler;

    .line 77
    return-void
.end method
