.class Lcom/cyjh/elfin/mvp/managers/TemplateManager$1;
.super Lcom/cyjh/elfin/net/volley/VolleyRequestManager;
.source "TemplateManager.java"


# annotations
.annotation system Ldalvik/annotation/EnclosingMethod;
    value = Lcom/cyjh/elfin/mvp/managers/TemplateManager;->templateChecked(Ljava/lang/String;Lcom/cyjh/elfin/mvp/managers/Callback;Landroid/content/Context;Ljava/lang/String;)V
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x0
    name = null
.end annotation


# instance fields
.field final synthetic this$0:Lcom/cyjh/elfin/mvp/managers/TemplateManager;

.field final synthetic val$callback:Lcom/cyjh/elfin/mvp/managers/Callback;


# direct methods
.method constructor <init>(Lcom/cyjh/elfin/mvp/managers/TemplateManager;Landroid/content/Context;Lcom/cyjh/elfin/mvp/managers/Callback;)V
    .locals 0
    .param p1, "this$0"    # Lcom/cyjh/elfin/mvp/managers/TemplateManager;
    .param p2, "context"    # Landroid/content/Context;

    .prologue
    .line 32
    iput-object p1, p0, Lcom/cyjh/elfin/mvp/managers/TemplateManager$1;->this$0:Lcom/cyjh/elfin/mvp/managers/TemplateManager;

    iput-object p3, p0, Lcom/cyjh/elfin/mvp/managers/TemplateManager$1;->val$callback:Lcom/cyjh/elfin/mvp/managers/Callback;

    invoke-direct {p0, p2}, Lcom/cyjh/elfin/net/volley/VolleyRequestManager;-><init>(Landroid/content/Context;)V

    return-void
.end method


# virtual methods
.method public onRequestErrorRes(Ljava/lang/String;)V
    .locals 1
    .param p1, "msg"    # Ljava/lang/String;

    .prologue
    .line 50
    iget-object v0, p0, Lcom/cyjh/elfin/mvp/managers/TemplateManager$1;->val$callback:Lcom/cyjh/elfin/mvp/managers/Callback;

    invoke-interface {v0, p1}, Lcom/cyjh/elfin/mvp/managers/Callback;->error(Ljava/lang/String;)V

    .line 51
    return-void
.end method

.method public onRequestSuccessRes(Ljava/lang/String;)V
    .locals 7
    .param p1, "res"    # Ljava/lang/String;

    .prologue
    .line 35
    new-instance v4, Ljava/lang/StringBuilder;

    invoke-direct {v4}, Ljava/lang/StringBuilder;-><init>()V

    const-string v5, "\u8fd4\u56de\u7684\u6570\u636e\uff1a"

    invoke-virtual {v4, v5}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v4

    invoke-virtual {v4, p1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v4

    invoke-virtual {v4}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v4

    const/4 v5, 0x0

    new-array v5, v5, [Ljava/lang/Object;

    invoke-static {v4, v5}, Lcom/orhanobut/logger/Logger;->e(Ljava/lang/String;[Ljava/lang/Object;)V

    .line 37
    :try_start_0
    new-instance v1, Lorg/json/JSONObject;

    invoke-direct {v1, p1}, Lorg/json/JSONObject;-><init>(Ljava/lang/String;)V

    .line 38
    .local v1, "jsonObject":Lorg/json/JSONObject;
    const-string v4, "Data"

    invoke-virtual {v1, v4}, Lorg/json/JSONObject;->getJSONObject(Ljava/lang/String;)Lorg/json/JSONObject;

    move-result-object v2

    .line 39
    .local v2, "jsonObjectData":Lorg/json/JSONObject;
    new-instance v3, Lcom/cyjh/elfin/entity/TemplateStatus;

    invoke-direct {v3}, Lcom/cyjh/elfin/entity/TemplateStatus;-><init>()V

    .line 40
    .local v3, "templateStatus":Lcom/cyjh/elfin/entity/TemplateStatus;
    const-string v4, "Code"

    invoke-virtual {v2, v4}, Lorg/json/JSONObject;->getString(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v4

    iput-object v4, v3, Lcom/cyjh/elfin/entity/TemplateStatus;->status:Ljava/lang/String;

    .line 41
    const-string v4, "Remark"

    invoke-virtual {v2, v4}, Lorg/json/JSONObject;->getString(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v4

    iput-object v4, v3, Lcom/cyjh/elfin/entity/TemplateStatus;->remark:Ljava/lang/String;

    .line 42
    iget-object v4, p0, Lcom/cyjh/elfin/mvp/managers/TemplateManager$1;->val$callback:Lcom/cyjh/elfin/mvp/managers/Callback;

    invoke-interface {v4, v3}, Lcom/cyjh/elfin/mvp/managers/Callback;->finish(Ljava/lang/Object;)V
    :try_end_0
    .catch Lorg/json/JSONException; {:try_start_0 .. :try_end_0} :catch_0

    .line 47
    .end local v1    # "jsonObject":Lorg/json/JSONObject;
    .end local v2    # "jsonObjectData":Lorg/json/JSONObject;
    .end local v3    # "templateStatus":Lcom/cyjh/elfin/entity/TemplateStatus;
    :goto_0
    return-void

    .line 43
    :catch_0
    move-exception v0

    .line 44
    .local v0, "e":Lorg/json/JSONException;
    invoke-virtual {v0}, Lorg/json/JSONException;->printStackTrace()V

    .line 45
    iget-object v4, p0, Lcom/cyjh/elfin/mvp/managers/TemplateManager$1;->val$callback:Lcom/cyjh/elfin/mvp/managers/Callback;

    new-instance v5, Ljava/lang/StringBuilder;

    invoke-direct {v5}, Ljava/lang/StringBuilder;-><init>()V

    const-string v6, "\u7f51\u7edc\u8bf7\u6c42\u8dd1\u7684\u5f02\u5e38\uff1a"

    invoke-virtual {v5, v6}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v5

    invoke-virtual {v0}, Lorg/json/JSONException;->getMessage()Ljava/lang/String;

    move-result-object v6

    invoke-virtual {v5, v6}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v5

    invoke-virtual {v5}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v5

    invoke-interface {v4, v5}, Lcom/cyjh/elfin/mvp/managers/Callback;->error(Ljava/lang/String;)V

    goto :goto_0
.end method
