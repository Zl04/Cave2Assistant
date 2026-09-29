.class Lcom/cyjh/elfin/mvp/managers/BlackListManager$1;
.super Lcom/cyjh/elfin/net/volley/VolleyRequestManager;
.source "BlackListManager.java"


# annotations
.annotation system Ldalvik/annotation/EnclosingMethod;
    value = Lcom/cyjh/elfin/mvp/managers/BlackListManager;->isSetBlackList(Landroid/content/Context;Ljava/lang/String;Lcom/cyjh/elfin/mvp/managers/Callback;)V
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x0
    name = null
.end annotation


# instance fields
.field final synthetic this$0:Lcom/cyjh/elfin/mvp/managers/BlackListManager;

.field final synthetic val$callback:Lcom/cyjh/elfin/mvp/managers/Callback;

.field final synthetic val$context:Landroid/content/Context;


# direct methods
.method constructor <init>(Lcom/cyjh/elfin/mvp/managers/BlackListManager;Landroid/content/Context;Lcom/cyjh/elfin/mvp/managers/Callback;Landroid/content/Context;)V
    .locals 0
    .param p1, "this$0"    # Lcom/cyjh/elfin/mvp/managers/BlackListManager;
    .param p2, "context"    # Landroid/content/Context;

    .prologue
    .line 22
    iput-object p1, p0, Lcom/cyjh/elfin/mvp/managers/BlackListManager$1;->this$0:Lcom/cyjh/elfin/mvp/managers/BlackListManager;

    iput-object p3, p0, Lcom/cyjh/elfin/mvp/managers/BlackListManager$1;->val$callback:Lcom/cyjh/elfin/mvp/managers/Callback;

    iput-object p4, p0, Lcom/cyjh/elfin/mvp/managers/BlackListManager$1;->val$context:Landroid/content/Context;

    invoke-direct {p0, p2}, Lcom/cyjh/elfin/net/volley/VolleyRequestManager;-><init>(Landroid/content/Context;)V

    return-void
.end method


# virtual methods
.method public onRequestErrorRes(Ljava/lang/String;)V
    .locals 1
    .param p1, "msg"    # Ljava/lang/String;

    .prologue
    .line 42
    invoke-static {p1}, Landroid/text/TextUtils;->isEmpty(Ljava/lang/CharSequence;)Z

    move-result v0

    if-nez v0, :cond_0

    .line 43
    iget-object v0, p0, Lcom/cyjh/elfin/mvp/managers/BlackListManager$1;->val$context:Landroid/content/Context;

    invoke-static {v0, p1}, Lcom/cyjh/elfin/util/ToastUtils;->showToastLong(Landroid/content/Context;Ljava/lang/String;)V

    .line 45
    :cond_0
    return-void
.end method

.method public onRequestSuccessRes(Ljava/lang/String;)V
    .locals 7
    .param p1, "res"    # Ljava/lang/String;

    .prologue
    const/4 v6, 0x0

    .line 25
    new-instance v4, Ljava/lang/StringBuilder;

    invoke-direct {v4}, Ljava/lang/StringBuilder;-><init>()V

    const-string v5, "BlackListResult\uff1a"

    invoke-virtual {v4, v5}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v4

    invoke-virtual {v4, p1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v4

    invoke-virtual {v4}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v4

    new-array v5, v6, [Ljava/lang/Object;

    invoke-static {v4, v5}, Lcom/orhanobut/logger/Logger;->e(Ljava/lang/String;[Ljava/lang/Object;)V

    .line 26
    const/4 v0, 0x0

    .line 28
    .local v0, "code":Ljava/lang/String;
    :try_start_0
    new-instance v2, Lorg/json/JSONObject;

    invoke-direct {v2, p1}, Lorg/json/JSONObject;-><init>(Ljava/lang/String;)V

    .line 29
    .local v2, "jsonObject":Lorg/json/JSONObject;
    const-string v4, "Code"

    invoke-virtual {v2, v4}, Lorg/json/JSONObject;->getString(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v3

    .line 30
    .local v3, "temp":Ljava/lang/String;
    new-instance v4, Ljava/lang/StringBuilder;

    invoke-direct {v4}, Ljava/lang/StringBuilder;-><init>()V

    const-string v5, "Code="

    invoke-virtual {v4, v5}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v4

    invoke-virtual {v4, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v4

    invoke-virtual {v4}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v4

    const/4 v5, 0x0

    new-array v5, v5, [Ljava/lang/Object;

    invoke-static {v4, v5}, Lcom/orhanobut/logger/Logger;->e(Ljava/lang/String;[Ljava/lang/Object;)V

    .line 31
    sget-object v4, Lcom/cyjh/elfin/constant/URLConstant;->VALUE_TYPE:Ljava/lang/String;

    invoke-virtual {v3, v4}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z
    :try_end_0
    .catch Lorg/json/JSONException; {:try_start_0 .. :try_end_0} :catch_0

    move-result v4

    if-eqz v4, :cond_0

    .line 32
    move-object v0, v3

    .line 37
    .end local v2    # "jsonObject":Lorg/json/JSONObject;
    .end local v3    # "temp":Ljava/lang/String;
    :cond_0
    :goto_0
    iget-object v4, p0, Lcom/cyjh/elfin/mvp/managers/BlackListManager$1;->val$callback:Lcom/cyjh/elfin/mvp/managers/Callback;

    invoke-interface {v4, v0}, Lcom/cyjh/elfin/mvp/managers/Callback;->finish(Ljava/lang/Object;)V

    .line 38
    return-void

    .line 34
    :catch_0
    move-exception v1

    .line 35
    .local v1, "e":Lorg/json/JSONException;
    invoke-virtual {v1}, Lorg/json/JSONException;->printStackTrace()V

    goto :goto_0
.end method
