.class Lcom/cyjh/elfin/mvp/presenters/PushMessagePresenter$1;
.super Lcom/cyjh/elfin/net/volley/VolleyRequestManager;
.source "PushMessagePresenter.java"


# annotations
.annotation system Ldalvik/annotation/EnclosingMethod;
    value = Lcom/cyjh/elfin/mvp/presenters/PushMessagePresenter;->acquireMessagePush(Ljava/lang/String;)V
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x0
    name = null
.end annotation


# instance fields
.field final synthetic this$0:Lcom/cyjh/elfin/mvp/presenters/PushMessagePresenter;


# direct methods
.method constructor <init>(Lcom/cyjh/elfin/mvp/presenters/PushMessagePresenter;Landroid/content/Context;)V
    .locals 0
    .param p1, "this$0"    # Lcom/cyjh/elfin/mvp/presenters/PushMessagePresenter;
    .param p2, "context"    # Landroid/content/Context;

    .prologue
    .line 50
    iput-object p1, p0, Lcom/cyjh/elfin/mvp/presenters/PushMessagePresenter$1;->this$0:Lcom/cyjh/elfin/mvp/presenters/PushMessagePresenter;

    invoke-direct {p0, p2}, Lcom/cyjh/elfin/net/volley/VolleyRequestManager;-><init>(Landroid/content/Context;)V

    return-void
.end method


# virtual methods
.method public onRequestErrorRes(Ljava/lang/String;)V
    .locals 2
    .param p1, "msg"    # Ljava/lang/String;

    .prologue
    .line 77
    new-instance v0, Ljava/lang/StringBuilder;

    invoke-direct {v0}, Ljava/lang/StringBuilder;-><init>()V

    invoke-virtual {v0, p1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    const-string v1, "\u8bf7\u6c42\u5931\u8d25"

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-virtual {v0}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v0

    const/4 v1, 0x0

    new-array v1, v1, [Ljava/lang/Object;

    invoke-static {v0, v1}, Lcom/orhanobut/logger/Logger;->e(Ljava/lang/String;[Ljava/lang/Object;)V

    .line 78
    return-void
.end method

.method public onRequestSuccessRes(Ljava/lang/String;)V
    .locals 8
    .param p1, "res"    # Ljava/lang/String;

    .prologue
    .line 53
    invoke-static {p1}, Landroid/text/TextUtils;->isEmpty(Ljava/lang/CharSequence;)Z

    move-result v6

    if-nez v6, :cond_0

    .line 55
    :try_start_0
    new-instance v3, Lorg/json/JSONObject;

    invoke-direct {v3, p1}, Lorg/json/JSONObject;-><init>(Ljava/lang/String;)V

    .line 56
    .local v3, "jsonObject":Lorg/json/JSONObject;
    const-string v6, "Data"

    invoke-virtual {v3, v6}, Lorg/json/JSONObject;->has(Ljava/lang/String;)Z

    move-result v6

    if-eqz v6, :cond_0

    .line 57
    const-string v6, "Data"

    invoke-virtual {v3, v6}, Lorg/json/JSONObject;->getJSONObject(Ljava/lang/String;)Lorg/json/JSONObject;

    move-result-object v4

    .line 58
    .local v4, "jsonObject1":Lorg/json/JSONObject;
    const-string v6, "rdata"

    invoke-virtual {v4, v6}, Lorg/json/JSONObject;->has(Ljava/lang/String;)Z

    move-result v6

    if-eqz v6, :cond_0

    .line 59
    const-string v6, "rdata"

    invoke-virtual {v4, v6}, Lorg/json/JSONObject;->getJSONArray(Ljava/lang/String;)Lorg/json/JSONArray;

    move-result-object v2

    .line 60
    .local v2, "jsonArray":Lorg/json/JSONArray;
    invoke-virtual {v2}, Lorg/json/JSONArray;->length()I

    move-result v6

    if-eqz v6, :cond_0

    .line 61
    new-instance v1, Lcom/google/gson/Gson;

    invoke-direct {v1}, Lcom/google/gson/Gson;-><init>()V

    .line 62
    .local v1, "gson":Lcom/google/gson/Gson;
    invoke-virtual {v2}, Lorg/json/JSONArray;->toString()Ljava/lang/String;

    move-result-object v6

    const-class v7, [Lcom/cyjh/elfin/entity/NotifyMsgBean;

    invoke-virtual {v1, v6, v7}, Lcom/google/gson/Gson;->fromJson(Ljava/lang/String;Ljava/lang/Class;)Ljava/lang/Object;

    move-result-object v5

    check-cast v5, [Lcom/cyjh/elfin/entity/NotifyMsgBean;

    .line 63
    .local v5, "notifyMsgBeans":[Lcom/cyjh/elfin/entity/NotifyMsgBean;
    array-length v6, v5

    if-lez v6, :cond_0

    .line 64
    iget-object v6, p0, Lcom/cyjh/elfin/mvp/presenters/PushMessagePresenter$1;->this$0:Lcom/cyjh/elfin/mvp/presenters/PushMessagePresenter;

    invoke-static {v6}, Lcom/cyjh/elfin/mvp/presenters/PushMessagePresenter;->access$000(Lcom/cyjh/elfin/mvp/presenters/PushMessagePresenter;)Lcom/cyjh/elfin/mvp/views/PushMessageView;

    move-result-object v6

    invoke-static {v5}, Ljava/util/Arrays;->asList([Ljava/lang/Object;)Ljava/util/List;

    move-result-object v7

    invoke-interface {v6, v7}, Lcom/cyjh/elfin/mvp/views/PushMessageView;->onSuccessfulAcquireNews(Ljava/util/List;)V
    :try_end_0
    .catch Lorg/json/JSONException; {:try_start_0 .. :try_end_0} :catch_0

    .line 73
    .end local v1    # "gson":Lcom/google/gson/Gson;
    .end local v2    # "jsonArray":Lorg/json/JSONArray;
    .end local v3    # "jsonObject":Lorg/json/JSONObject;
    .end local v4    # "jsonObject1":Lorg/json/JSONObject;
    .end local v5    # "notifyMsgBeans":[Lcom/cyjh/elfin/entity/NotifyMsgBean;
    :cond_0
    :goto_0
    return-void

    .line 69
    :catch_0
    move-exception v0

    .line 70
    .local v0, "e":Lorg/json/JSONException;
    invoke-virtual {v0}, Lorg/json/JSONException;->printStackTrace()V

    goto :goto_0
.end method
