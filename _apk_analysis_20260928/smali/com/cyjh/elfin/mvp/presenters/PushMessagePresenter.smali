.class public Lcom/cyjh/elfin/mvp/presenters/PushMessagePresenter;
.super Ljava/lang/Object;
.source "PushMessagePresenter.java"

# interfaces
.implements Lcom/cyjh/elfin/mvp/presenters/BasePresenter;


# static fields
.field private static final IS_FREE:Ljava/lang/String; = "1"

.field private static final REQUEST_TAG:Ljava/lang/String; = "PushMessagePresenter.class.getCanonicalName()"


# instance fields
.field private context:Landroid/content/Context;

.field private pushMessageView:Lcom/cyjh/elfin/mvp/views/PushMessageView;


# direct methods
.method public constructor <init>(Lcom/cyjh/elfin/mvp/views/PushMessageView;Landroid/content/Context;)V
    .locals 0
    .param p1, "pushMessageView"    # Lcom/cyjh/elfin/mvp/views/PushMessageView;
    .param p2, "context"    # Landroid/content/Context;

    .prologue
    .line 36
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    .line 37
    iput-object p1, p0, Lcom/cyjh/elfin/mvp/presenters/PushMessagePresenter;->pushMessageView:Lcom/cyjh/elfin/mvp/views/PushMessageView;

    .line 38
    iput-object p2, p0, Lcom/cyjh/elfin/mvp/presenters/PushMessagePresenter;->context:Landroid/content/Context;

    .line 39
    return-void
.end method

.method static synthetic access$000(Lcom/cyjh/elfin/mvp/presenters/PushMessagePresenter;)Lcom/cyjh/elfin/mvp/views/PushMessageView;
    .locals 1
    .param p0, "x0"    # Lcom/cyjh/elfin/mvp/presenters/PushMessagePresenter;

    .prologue
    .line 30
    iget-object v0, p0, Lcom/cyjh/elfin/mvp/presenters/PushMessagePresenter;->pushMessageView:Lcom/cyjh/elfin/mvp/views/PushMessageView;

    return-object v0
.end method


# virtual methods
.method public acquireMessagePush(Ljava/lang/String;)V
    .locals 5
    .param p1, "imie"    # Ljava/lang/String;

    .prologue
    .line 41
    iget-object v2, p0, Lcom/cyjh/elfin/mvp/presenters/PushMessagePresenter;->context:Landroid/content/Context;

    const v3, 0x7f0800bf

    invoke-virtual {v2, v3}, Landroid/content/Context;->getString(I)Ljava/lang/String;

    move-result-object v0

    .line 43
    .local v0, "guid":Ljava/lang/String;
    const-string v2, "api.51moba.com"

    const-string v3, "GetMessage"

    invoke-static {v2, v3}, Lcom/cyjh/elfin/constant/MyBuildConfig;->getBuilder(Ljava/lang/String;Ljava/lang/String;)Landroid/net/Uri$Builder;

    move-result-object v2

    const-string v3, "platforms"

    const-string v4, "android"

    .line 44
    invoke-virtual {v2, v3, v4}, Landroid/net/Uri$Builder;->appendQueryParameter(Ljava/lang/String;Ljava/lang/String;)Landroid/net/Uri$Builder;

    move-result-object v2

    const-string v3, "imie"

    .line 45
    invoke-virtual {v2, v3, p1}, Landroid/net/Uri$Builder;->appendQueryParameter(Ljava/lang/String;Ljava/lang/String;)Landroid/net/Uri$Builder;

    move-result-object v2

    const-string v3, "isfree"

    const-string v4, "1"

    .line 46
    invoke-virtual {v2, v3, v4}, Landroid/net/Uri$Builder;->appendQueryParameter(Ljava/lang/String;Ljava/lang/String;)Landroid/net/Uri$Builder;

    move-result-object v2

    const-string v3, "guid"

    .line 47
    invoke-virtual {v2, v3, v0}, Landroid/net/Uri$Builder;->appendQueryParameter(Ljava/lang/String;Ljava/lang/String;)Landroid/net/Uri$Builder;

    move-result-object v2

    .line 48
    invoke-virtual {v2}, Landroid/net/Uri$Builder;->build()Landroid/net/Uri;

    move-result-object v2

    invoke-virtual {v2}, Landroid/net/Uri;->toString()Ljava/lang/String;

    move-result-object v1

    .line 49
    .local v1, "url":Ljava/lang/String;
    new-instance v2, Ljava/lang/StringBuilder;

    invoke-direct {v2}, Ljava/lang/StringBuilder;-><init>()V

    const-string v3, "imie+url"

    invoke-virtual {v2, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    invoke-virtual {v2, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    invoke-virtual {v2}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v2

    const/4 v3, 0x0

    new-array v3, v3, [Ljava/lang/Object;

    invoke-static {v2, v3}, Lcom/orhanobut/logger/Logger;->e(Ljava/lang/String;[Ljava/lang/Object;)V

    .line 50
    const-string v2, "PushMessagePresenter.class.getCanonicalName()"

    new-instance v3, Lcom/cyjh/elfin/mvp/presenters/PushMessagePresenter$1;

    iget-object v4, p0, Lcom/cyjh/elfin/mvp/presenters/PushMessagePresenter;->context:Landroid/content/Context;

    invoke-direct {v3, p0, v4}, Lcom/cyjh/elfin/mvp/presenters/PushMessagePresenter$1;-><init>(Lcom/cyjh/elfin/mvp/presenters/PushMessagePresenter;Landroid/content/Context;)V

    invoke-static {v1, v2, v3}, Lcom/cyjh/elfin/net/volley/VolleyManager;->requestStringGet(Ljava/lang/String;Ljava/lang/String;Lcom/cyjh/elfin/net/volley/VolleyRequestManager;)V

    .line 80
    return-void
.end method

.method public onStopRequest()V
    .locals 2

    .prologue
    .line 83
    invoke-static {}, Lcom/cyjh/elfin/net/volley/VolleyRequestQueue;->getRequestQueue()Lcom/android/volley/RequestQueue;

    move-result-object v0

    const-string v1, "PushMessagePresenter.class.getCanonicalName()"

    invoke-virtual {v0, v1}, Lcom/android/volley/RequestQueue;->cancelAll(Ljava/lang/Object;)V

    .line 84
    return-void
.end method
