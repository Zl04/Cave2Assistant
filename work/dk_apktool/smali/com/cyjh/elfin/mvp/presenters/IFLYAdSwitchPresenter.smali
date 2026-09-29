.class public Lcom/cyjh/elfin/mvp/presenters/IFLYAdSwitchPresenter;
.super Ljava/lang/Object;
.source "IFLYAdSwitchPresenter.java"

# interfaces
.implements Lcom/cyjh/elfin/net/volley/inf/IAnalysisJson;
.implements Lcom/cyjh/elfin/net/volley/inf/IUIDataListener;


# instance fields
.field protected mA:Lcom/cyjh/elfin/net/volley/ActivityHttpHelper;

.field private mContext:Landroid/content/Context;

.field private mViews:Lcom/cyjh/elfin/mvp/views/IFLYAdSwitchViews;

.field private site:I


# direct methods
.method public constructor <init>(Landroid/content/Context;Lcom/cyjh/elfin/mvp/views/IFLYAdSwitchViews;)V
    .locals 1
    .param p1, "context"    # Landroid/content/Context;
    .param p2, "mViews"    # Lcom/cyjh/elfin/mvp/views/IFLYAdSwitchViews;

    .prologue
    .line 35
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    .line 32
    const/4 v0, 0x3

    iput v0, p0, Lcom/cyjh/elfin/mvp/presenters/IFLYAdSwitchPresenter;->site:I

    .line 36
    new-instance v0, Lcom/cyjh/elfin/net/volley/ActivityHttpHelper;

    invoke-direct {v0, p0, p0}, Lcom/cyjh/elfin/net/volley/ActivityHttpHelper;-><init>(Lcom/cyjh/elfin/net/volley/inf/IUIDataListener;Lcom/cyjh/elfin/net/volley/inf/IAnalysisJson;)V

    iput-object v0, p0, Lcom/cyjh/elfin/mvp/presenters/IFLYAdSwitchPresenter;->mA:Lcom/cyjh/elfin/net/volley/ActivityHttpHelper;

    .line 37
    iput-object p1, p0, Lcom/cyjh/elfin/mvp/presenters/IFLYAdSwitchPresenter;->mContext:Landroid/content/Context;

    .line 38
    iput-object p2, p0, Lcom/cyjh/elfin/mvp/presenters/IFLYAdSwitchPresenter;->mViews:Lcom/cyjh/elfin/mvp/views/IFLYAdSwitchViews;

    .line 39
    return-void
.end method


# virtual methods
.method public getData(Ljava/lang/String;)Ljava/lang/Object;
    .locals 0
    .param p1, "json"    # Ljava/lang/String;

    .prologue
    .line 43
    return-object p1
.end method

.method public load(I)V
    .locals 4
    .param p1, "site"    # I

    .prologue
    .line 97
    iput p1, p0, Lcom/cyjh/elfin/mvp/presenters/IFLYAdSwitchPresenter;->site:I

    .line 98
    const-string v1, "api.51moba.com"

    const-string v2, "GetAdvertisementSwitch"

    invoke-static {v1, v2}, Lcom/cyjh/elfin/constant/MyBuildConfig;->getBuilder(Ljava/lang/String;Ljava/lang/String;)Landroid/net/Uri$Builder;

    move-result-object v1

    const-string v2, "key"

    const-string v3, "Elf"

    .line 99
    invoke-virtual {v1, v2, v3}, Landroid/net/Uri$Builder;->appendQueryParameter(Ljava/lang/String;Ljava/lang/String;)Landroid/net/Uri$Builder;

    move-result-object v1

    const-string v2, "site"

    .line 100
    invoke-static {p1}, Ljava/lang/String;->valueOf(I)Ljava/lang/String;

    move-result-object v3

    invoke-virtual {v1, v2, v3}, Landroid/net/Uri$Builder;->appendQueryParameter(Ljava/lang/String;Ljava/lang/String;)Landroid/net/Uri$Builder;

    move-result-object v1

    .line 101
    invoke-virtual {v1}, Landroid/net/Uri$Builder;->build()Landroid/net/Uri;

    move-result-object v1

    invoke-virtual {v1}, Landroid/net/Uri;->toString()Ljava/lang/String;

    move-result-object v0

    .line 102
    .local v0, "url":Ljava/lang/String;
    const-string v1, "zzz"

    new-instance v2, Ljava/lang/StringBuilder;

    invoke-direct {v2}, Ljava/lang/StringBuilder;-><init>()V

    const-string v3, "IFLYAdSwitchPresenter--load--"

    invoke-virtual {v2, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    invoke-virtual {v2, v0}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    invoke-virtual {v2}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v2

    invoke-static {v1, v2}, Landroid/util/Log;->e(Ljava/lang/String;Ljava/lang/String;)I

    .line 103
    iget-object v1, p0, Lcom/cyjh/elfin/mvp/presenters/IFLYAdSwitchPresenter;->mA:Lcom/cyjh/elfin/net/volley/ActivityHttpHelper;

    iget-object v2, p0, Lcom/cyjh/elfin/mvp/presenters/IFLYAdSwitchPresenter;->mContext:Landroid/content/Context;

    invoke-virtual {v1, v2, v0}, Lcom/cyjh/elfin/net/volley/ActivityHttpHelper;->sendGetRequest(Landroid/content/Context;Ljava/lang/String;)V

    .line 104
    return-void
.end method

.method public stop()V
    .locals 1

    .prologue
    .line 107
    iget-object v0, p0, Lcom/cyjh/elfin/mvp/presenters/IFLYAdSwitchPresenter;->mA:Lcom/cyjh/elfin/net/volley/ActivityHttpHelper;

    invoke-virtual {v0}, Lcom/cyjh/elfin/net/volley/ActivityHttpHelper;->stopRequest()V

    .line 108
    return-void
.end method

.method public uiDataError(Lcom/android/volley/VolleyError;)V
    .locals 1
    .param p1, "error"    # Lcom/android/volley/VolleyError;

    .prologue
    .line 93
    iget-object v0, p0, Lcom/cyjh/elfin/mvp/presenters/IFLYAdSwitchPresenter;->mViews:Lcom/cyjh/elfin/mvp/views/IFLYAdSwitchViews;

    invoke-interface {v0}, Lcom/cyjh/elfin/mvp/views/IFLYAdSwitchViews;->onSwitchFail()V

    .line 94
    return-void
.end method

.method public uiDataSuccess(Ljava/lang/Object;)V
    .locals 15
    .param p1, "object"    # Ljava/lang/Object;

    .prologue
    .line 48
    move-object/from16 v10, p1

    check-cast v10, Ljava/lang/String;

    .line 49
    .local v10, "response":Ljava/lang/String;
    const-string v12, "zzz"

    new-instance v13, Ljava/lang/StringBuilder;

    invoke-direct {v13}, Ljava/lang/StringBuilder;-><init>()V

    const-string v14, "IFLYAdSwitchPresenter--load--"

    invoke-virtual {v13, v14}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v13

    invoke-virtual {v13, v10}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v13

    invoke-virtual {v13}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v13

    invoke-static {v12, v13}, Landroid/util/Log;->e(Ljava/lang/String;Ljava/lang/String;)I

    .line 50
    invoke-static {v10}, Landroid/text/TextUtils;->isEmpty(Ljava/lang/CharSequence;)Z

    move-result v12

    if-nez v12, :cond_3

    .line 52
    :try_start_0
    new-instance v4, Lorg/json/JSONObject;

    invoke-direct {v4, v10}, Lorg/json/JSONObject;-><init>(Ljava/lang/String;)V

    .line 53
    .local v4, "jsonObject":Lorg/json/JSONObject;
    const-string v12, "Code"

    invoke-virtual {v4, v12}, Lorg/json/JSONObject;->getString(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v12

    const-string v13, "1"

    invoke-virtual {v12, v13}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v12

    if-eqz v12, :cond_0

    .line 54
    const-string v12, "Data"

    invoke-virtual {v4, v12}, Lorg/json/JSONObject;->getJSONObject(Ljava/lang/String;)Lorg/json/JSONObject;

    move-result-object v3

    .line 55
    .local v3, "jsonData":Lorg/json/JSONObject;
    const-string v12, "Key"

    invoke-virtual {v3, v12}, Lorg/json/JSONObject;->getString(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v6

    .line 56
    .local v6, "key":Ljava/lang/String;
    const-string v12, "Elf"

    invoke-static {v6, v12}, Landroid/text/TextUtils;->equals(Ljava/lang/CharSequence;Ljava/lang/CharSequence;)Z

    move-result v12

    if-eqz v12, :cond_2

    .line 57
    const-string v12, "Value"

    invoke-virtual {v3, v12}, Lorg/json/JSONObject;->getString(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v2

    .line 58
    .local v2, "json":Ljava/lang/String;
    new-instance v5, Lorg/json/JSONObject;

    invoke-direct {v5, v2}, Lorg/json/JSONObject;-><init>(Ljava/lang/String;)V

    .line 59
    .local v5, "jsonValue":Lorg/json/JSONObject;
    const-string v12, "Status"

    invoke-virtual {v5, v12}, Lorg/json/JSONObject;->getString(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v11

    .line 60
    .local v11, "status":Ljava/lang/String;
    const-string v12, "Probability"

    invoke-virtual {v5, v12}, Lorg/json/JSONObject;->getString(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v7

    .line 61
    .local v7, "probability":Ljava/lang/String;
    new-instance v8, Ljava/util/Random;

    invoke-direct {v8}, Ljava/util/Random;-><init>()V

    .line 63
    .local v8, "random":Ljava/util/Random;
    const/16 v12, 0x64

    invoke-virtual {v8, v12}, Ljava/util/Random;->nextInt(I)I

    move-result v12

    add-int/lit8 v9, v12, 0x1

    .line 64
    .local v9, "randomNumber":I
    invoke-static {v7}, Ljava/lang/Integer;->parseInt(Ljava/lang/String;)I

    move-result v12

    if-gt v9, v12, :cond_1

    const/4 v1, 0x1

    .line 66
    .local v1, "isShow":Z
    :goto_0
    const-string v12, "xys"

    new-instance v13, Ljava/lang/StringBuilder;

    invoke-direct {v13}, Ljava/lang/StringBuilder;-><init>()V

    const-string v14, "staus:"

    invoke-virtual {v13, v14}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v13

    invoke-virtual {v13, v11}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v13

    const-string v14, "probility:"

    invoke-virtual {v13, v14}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v13

    invoke-virtual {v13, v7}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v13

    const-string v14, "randomNumber:"

    invoke-virtual {v13, v14}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v13

    invoke-virtual {v13, v9}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v13

    invoke-virtual {v13}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v13

    invoke-static {v12, v13}, Landroid/util/Log;->e(Ljava/lang/String;Ljava/lang/String;)I

    .line 67
    iget-object v12, p0, Lcom/cyjh/elfin/mvp/presenters/IFLYAdSwitchPresenter;->mViews:Lcom/cyjh/elfin/mvp/views/IFLYAdSwitchViews;

    invoke-interface {v12, v11, v1}, Lcom/cyjh/elfin/mvp/views/IFLYAdSwitchViews;->onSwitchSuc(Ljava/lang/String;Z)V

    .line 87
    .end local v1    # "isShow":Z
    .end local v2    # "json":Ljava/lang/String;
    .end local v3    # "jsonData":Lorg/json/JSONObject;
    .end local v4    # "jsonObject":Lorg/json/JSONObject;
    .end local v5    # "jsonValue":Lorg/json/JSONObject;
    .end local v6    # "key":Ljava/lang/String;
    .end local v7    # "probability":Ljava/lang/String;
    .end local v8    # "random":Ljava/util/Random;
    .end local v9    # "randomNumber":I
    .end local v11    # "status":Ljava/lang/String;
    :cond_0
    :goto_1
    return-void

    .line 64
    .restart local v2    # "json":Ljava/lang/String;
    .restart local v3    # "jsonData":Lorg/json/JSONObject;
    .restart local v4    # "jsonObject":Lorg/json/JSONObject;
    .restart local v5    # "jsonValue":Lorg/json/JSONObject;
    .restart local v6    # "key":Ljava/lang/String;
    .restart local v7    # "probability":Ljava/lang/String;
    .restart local v8    # "random":Ljava/util/Random;
    .restart local v9    # "randomNumber":I
    .restart local v11    # "status":Ljava/lang/String;
    :cond_1
    const/4 v1, 0x0

    goto :goto_0

    .line 71
    .end local v2    # "json":Ljava/lang/String;
    .end local v5    # "jsonValue":Lorg/json/JSONObject;
    .end local v7    # "probability":Ljava/lang/String;
    .end local v8    # "random":Ljava/util/Random;
    .end local v9    # "randomNumber":I
    .end local v11    # "status":Ljava/lang/String;
    :cond_2
    iget-object v12, p0, Lcom/cyjh/elfin/mvp/presenters/IFLYAdSwitchPresenter;->mViews:Lcom/cyjh/elfin/mvp/views/IFLYAdSwitchViews;

    invoke-interface {v12}, Lcom/cyjh/elfin/mvp/views/IFLYAdSwitchViews;->onSwitchFail()V
    :try_end_0
    .catch Lorg/json/JSONException; {:try_start_0 .. :try_end_0} :catch_0

    goto :goto_1

    .line 74
    .end local v3    # "jsonData":Lorg/json/JSONObject;
    .end local v4    # "jsonObject":Lorg/json/JSONObject;
    .end local v6    # "key":Ljava/lang/String;
    :catch_0
    move-exception v0

    .line 75
    .local v0, "e":Lorg/json/JSONException;
    invoke-virtual {v0}, Lorg/json/JSONException;->printStackTrace()V

    .line 76
    const-string v12, "zzz"

    new-instance v13, Ljava/lang/StringBuilder;

    invoke-direct {v13}, Ljava/lang/StringBuilder;-><init>()V

    const-string v14, "IFLYAdSwitchManager---2"

    invoke-virtual {v13, v14}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v13

    invoke-virtual {v0}, Lorg/json/JSONException;->getMessage()Ljava/lang/String;

    move-result-object v14

    invoke-virtual {v13, v14}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v13

    invoke-virtual {v13}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v13

    invoke-static {v12, v13}, Landroid/util/Log;->e(Ljava/lang/String;Ljava/lang/String;)I

    .line 79
    iget-object v12, p0, Lcom/cyjh/elfin/mvp/presenters/IFLYAdSwitchPresenter;->mViews:Lcom/cyjh/elfin/mvp/views/IFLYAdSwitchViews;

    invoke-interface {v12}, Lcom/cyjh/elfin/mvp/views/IFLYAdSwitchViews;->onSwitchFail()V

    goto :goto_1

    .line 82
    .end local v0    # "e":Lorg/json/JSONException;
    :cond_3
    const-string v12, "zzz"

    const-string v13, "IFLYAdSwitchManager---3"

    invoke-static {v12, v13}, Landroid/util/Log;->e(Ljava/lang/String;Ljava/lang/String;)I

    .line 85
    iget-object v12, p0, Lcom/cyjh/elfin/mvp/presenters/IFLYAdSwitchPresenter;->mViews:Lcom/cyjh/elfin/mvp/views/IFLYAdSwitchViews;

    invoke-interface {v12}, Lcom/cyjh/elfin/mvp/views/IFLYAdSwitchViews;->onSwitchFail()V

    goto :goto_1
.end method
