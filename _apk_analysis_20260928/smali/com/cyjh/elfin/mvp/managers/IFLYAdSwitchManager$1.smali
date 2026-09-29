.class Lcom/cyjh/elfin/mvp/managers/IFLYAdSwitchManager$1;
.super Lcom/cyjh/elfin/net/volley/VolleyRequestManager;
.source "IFLYAdSwitchManager.java"


# annotations
.annotation system Ldalvik/annotation/EnclosingMethod;
    value = Lcom/cyjh/elfin/mvp/managers/IFLYAdSwitchManager;->checkedSwitchAd(Landroid/content/Context;I)V
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x0
    name = null
.end annotation


# instance fields
.field final synthetic this$0:Lcom/cyjh/elfin/mvp/managers/IFLYAdSwitchManager;

.field final synthetic val$site:I


# direct methods
.method constructor <init>(Lcom/cyjh/elfin/mvp/managers/IFLYAdSwitchManager;Landroid/content/Context;I)V
    .locals 0
    .param p1, "this$0"    # Lcom/cyjh/elfin/mvp/managers/IFLYAdSwitchManager;
    .param p2, "context"    # Landroid/content/Context;

    .prologue
    .line 58
    iput-object p1, p0, Lcom/cyjh/elfin/mvp/managers/IFLYAdSwitchManager$1;->this$0:Lcom/cyjh/elfin/mvp/managers/IFLYAdSwitchManager;

    iput p3, p0, Lcom/cyjh/elfin/mvp/managers/IFLYAdSwitchManager$1;->val$site:I

    invoke-direct {p0, p2}, Lcom/cyjh/elfin/net/volley/VolleyRequestManager;-><init>(Landroid/content/Context;)V

    return-void
.end method


# virtual methods
.method public onRequestErrorRes(Ljava/lang/String;)V
    .locals 3
    .param p1, "msg"    # Ljava/lang/String;

    .prologue
    .line 95
    const-string v0, "zzz"

    new-instance v1, Ljava/lang/StringBuilder;

    invoke-direct {v1}, Ljava/lang/StringBuilder;-><init>()V

    const-string v2, "IFLYAdSwitchManager---4"

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1, p1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v1

    invoke-static {v0, v1}, Landroid/util/Log;->e(Ljava/lang/String;Ljava/lang/String;)I

    .line 96
    iget-object v0, p0, Lcom/cyjh/elfin/mvp/managers/IFLYAdSwitchManager$1;->this$0:Lcom/cyjh/elfin/mvp/managers/IFLYAdSwitchManager;

    iget v1, p0, Lcom/cyjh/elfin/mvp/managers/IFLYAdSwitchManager$1;->val$site:I

    invoke-static {v0, v1}, Lcom/cyjh/elfin/mvp/managers/IFLYAdSwitchManager;->access$000(Lcom/cyjh/elfin/mvp/managers/IFLYAdSwitchManager;I)V

    .line 97
    return-void
.end method

.method public onRequestSuccessRes(Ljava/lang/String;)V
    .locals 14
    .param p1, "response"    # Ljava/lang/String;

    .prologue
    .line 61
    const-string v11, "zzz"

    new-instance v12, Ljava/lang/StringBuilder;

    invoke-direct {v12}, Ljava/lang/StringBuilder;-><init>()V

    const-string v13, "IFLYAdSwitchManager--checkedSwitchAd--response--"

    invoke-virtual {v12, v13}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v12

    invoke-virtual {v12, p1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v12

    invoke-virtual {v12}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v12

    invoke-static {v11, v12}, Landroid/util/Log;->e(Ljava/lang/String;Ljava/lang/String;)I

    .line 62
    invoke-static {p1}, Landroid/text/TextUtils;->isEmpty(Ljava/lang/CharSequence;)Z

    move-result v11

    if-nez v11, :cond_3

    .line 64
    :try_start_0
    new-instance v4, Lorg/json/JSONObject;

    invoke-direct {v4, p1}, Lorg/json/JSONObject;-><init>(Ljava/lang/String;)V

    .line 65
    .local v4, "jsonObject":Lorg/json/JSONObject;
    const-string v11, "Code"

    invoke-virtual {v4, v11}, Lorg/json/JSONObject;->getString(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v11

    const-string v12, "1"

    invoke-virtual {v11, v12}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v11

    if-eqz v11, :cond_0

    .line 66
    const-string v11, "Data"

    invoke-virtual {v4, v11}, Lorg/json/JSONObject;->getJSONObject(Ljava/lang/String;)Lorg/json/JSONObject;

    move-result-object v3

    .line 67
    .local v3, "jsonData":Lorg/json/JSONObject;
    const-string v11, "Key"

    invoke-virtual {v3, v11}, Lorg/json/JSONObject;->getString(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v6

    .line 68
    .local v6, "key":Ljava/lang/String;
    const-string v11, "Elf"

    invoke-static {v6, v11}, Landroid/text/TextUtils;->equals(Ljava/lang/CharSequence;Ljava/lang/CharSequence;)Z

    move-result v11

    if-eqz v11, :cond_2

    .line 69
    const-string v11, "Value"

    invoke-virtual {v3, v11}, Lorg/json/JSONObject;->getString(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v2

    .line 70
    .local v2, "json":Ljava/lang/String;
    new-instance v5, Lorg/json/JSONObject;

    invoke-direct {v5, v2}, Lorg/json/JSONObject;-><init>(Ljava/lang/String;)V

    .line 71
    .local v5, "jsonValue":Lorg/json/JSONObject;
    const-string v11, "Status"

    invoke-virtual {v5, v11}, Lorg/json/JSONObject;->getString(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v10

    .line 72
    .local v10, "status":Ljava/lang/String;
    const-string v11, "Probability"

    invoke-virtual {v5, v11}, Lorg/json/JSONObject;->getString(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v7

    .line 73
    .local v7, "probability":Ljava/lang/String;
    new-instance v8, Ljava/util/Random;

    invoke-direct {v8}, Ljava/util/Random;-><init>()V

    .line 75
    .local v8, "random":Ljava/util/Random;
    const/16 v11, 0x64

    invoke-virtual {v8, v11}, Ljava/util/Random;->nextInt(I)I

    move-result v11

    add-int/lit8 v9, v11, 0x1

    .line 76
    .local v9, "randomNumber":I
    invoke-static {v7}, Ljava/lang/Integer;->parseInt(Ljava/lang/String;)I

    move-result v11

    if-gt v9, v11, :cond_1

    const/4 v1, 0x1

    .line 77
    .local v1, "isShow":Z
    :goto_0
    invoke-static {}, Lorg/greenrobot/eventbus/EventBus;->getDefault()Lorg/greenrobot/eventbus/EventBus;

    move-result-object v11

    new-instance v12, Lcom/cyjh/elfin/entity/MsgItem$CheckedSwitchAdEvent;

    iget v13, p0, Lcom/cyjh/elfin/mvp/managers/IFLYAdSwitchManager$1;->val$site:I

    invoke-direct {v12, v10, v1, v13}, Lcom/cyjh/elfin/entity/MsgItem$CheckedSwitchAdEvent;-><init>(Ljava/lang/String;ZI)V

    invoke-virtual {v11, v12}, Lorg/greenrobot/eventbus/EventBus;->post(Ljava/lang/Object;)V

    .line 78
    const-string v11, "xys"

    new-instance v12, Ljava/lang/StringBuilder;

    invoke-direct {v12}, Ljava/lang/StringBuilder;-><init>()V

    const-string v13, "staus:"

    invoke-virtual {v12, v13}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v12

    invoke-virtual {v12, v10}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v12

    const-string v13, "probility:"

    invoke-virtual {v12, v13}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v12

    invoke-virtual {v12, v7}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v12

    const-string v13, "randomNumber:"

    invoke-virtual {v12, v13}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v12

    invoke-virtual {v12, v9}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v12

    invoke-virtual {v12}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v12

    invoke-static {v11, v12}, Landroid/util/Log;->e(Ljava/lang/String;Ljava/lang/String;)I

    .line 92
    .end local v1    # "isShow":Z
    .end local v2    # "json":Ljava/lang/String;
    .end local v3    # "jsonData":Lorg/json/JSONObject;
    .end local v4    # "jsonObject":Lorg/json/JSONObject;
    .end local v5    # "jsonValue":Lorg/json/JSONObject;
    .end local v6    # "key":Ljava/lang/String;
    .end local v7    # "probability":Ljava/lang/String;
    .end local v8    # "random":Ljava/util/Random;
    .end local v9    # "randomNumber":I
    .end local v10    # "status":Ljava/lang/String;
    :cond_0
    :goto_1
    return-void

    .line 76
    .restart local v2    # "json":Ljava/lang/String;
    .restart local v3    # "jsonData":Lorg/json/JSONObject;
    .restart local v4    # "jsonObject":Lorg/json/JSONObject;
    .restart local v5    # "jsonValue":Lorg/json/JSONObject;
    .restart local v6    # "key":Ljava/lang/String;
    .restart local v7    # "probability":Ljava/lang/String;
    .restart local v8    # "random":Ljava/util/Random;
    .restart local v9    # "randomNumber":I
    .restart local v10    # "status":Ljava/lang/String;
    :cond_1
    const/4 v1, 0x0

    goto :goto_0

    .line 80
    .end local v2    # "json":Ljava/lang/String;
    .end local v5    # "jsonValue":Lorg/json/JSONObject;
    .end local v7    # "probability":Ljava/lang/String;
    .end local v8    # "random":Ljava/util/Random;
    .end local v9    # "randomNumber":I
    .end local v10    # "status":Ljava/lang/String;
    :cond_2
    iget-object v11, p0, Lcom/cyjh/elfin/mvp/managers/IFLYAdSwitchManager$1;->this$0:Lcom/cyjh/elfin/mvp/managers/IFLYAdSwitchManager;

    iget v12, p0, Lcom/cyjh/elfin/mvp/managers/IFLYAdSwitchManager$1;->val$site:I

    invoke-static {v11, v12}, Lcom/cyjh/elfin/mvp/managers/IFLYAdSwitchManager;->access$000(Lcom/cyjh/elfin/mvp/managers/IFLYAdSwitchManager;I)V
    :try_end_0
    .catch Lorg/json/JSONException; {:try_start_0 .. :try_end_0} :catch_0

    goto :goto_1

    .line 83
    .end local v3    # "jsonData":Lorg/json/JSONObject;
    .end local v4    # "jsonObject":Lorg/json/JSONObject;
    .end local v6    # "key":Ljava/lang/String;
    :catch_0
    move-exception v0

    .line 84
    .local v0, "e":Lorg/json/JSONException;
    invoke-virtual {v0}, Lorg/json/JSONException;->printStackTrace()V

    .line 85
    const-string v11, "zzz"

    new-instance v12, Ljava/lang/StringBuilder;

    invoke-direct {v12}, Ljava/lang/StringBuilder;-><init>()V

    const-string v13, "IFLYAdSwitchManager---2"

    invoke-virtual {v12, v13}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v12

    invoke-virtual {v0}, Lorg/json/JSONException;->getMessage()Ljava/lang/String;

    move-result-object v13

    invoke-virtual {v12, v13}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v12

    invoke-virtual {v12}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v12

    invoke-static {v11, v12}, Landroid/util/Log;->e(Ljava/lang/String;Ljava/lang/String;)I

    .line 86
    iget-object v11, p0, Lcom/cyjh/elfin/mvp/managers/IFLYAdSwitchManager$1;->this$0:Lcom/cyjh/elfin/mvp/managers/IFLYAdSwitchManager;

    iget v12, p0, Lcom/cyjh/elfin/mvp/managers/IFLYAdSwitchManager$1;->val$site:I

    invoke-static {v11, v12}, Lcom/cyjh/elfin/mvp/managers/IFLYAdSwitchManager;->access$000(Lcom/cyjh/elfin/mvp/managers/IFLYAdSwitchManager;I)V

    goto :goto_1

    .line 89
    .end local v0    # "e":Lorg/json/JSONException;
    :cond_3
    const-string v11, "zzz"

    const-string v12, "IFLYAdSwitchManager---3"

    invoke-static {v11, v12}, Landroid/util/Log;->e(Ljava/lang/String;Ljava/lang/String;)I

    .line 90
    iget-object v11, p0, Lcom/cyjh/elfin/mvp/managers/IFLYAdSwitchManager$1;->this$0:Lcom/cyjh/elfin/mvp/managers/IFLYAdSwitchManager;

    iget v12, p0, Lcom/cyjh/elfin/mvp/managers/IFLYAdSwitchManager$1;->val$site:I

    invoke-static {v11, v12}, Lcom/cyjh/elfin/mvp/managers/IFLYAdSwitchManager;->access$000(Lcom/cyjh/elfin/mvp/managers/IFLYAdSwitchManager;I)V

    goto :goto_1
.end method
