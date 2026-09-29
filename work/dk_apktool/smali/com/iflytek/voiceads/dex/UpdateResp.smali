.class public Lcom/iflytek/voiceads/dex/UpdateResp;
.super Ljava/lang/Object;
.source "UpdateResp.java"


# static fields
.field private static final UPLOAD_DATA:Ljava/lang/String; = "data"

.field private static final UPLOAD_RE:Ljava/lang/String; = "re"

.field private static final UPLOAD_SUBVERSION:Ljava/lang/String; = "sub_version"

.field private static final UPLOAD_URL:Ljava/lang/String; = "url"

.field private static final UPLOAD_VERSION:Ljava/lang/String; = "version"


# instance fields
.field private re:Z

.field private remoteSubversion:Ljava/lang/String;

.field private remoteUrl:Ljava/lang/String;

.field private remoteVersion:Ljava/lang/String;


# direct methods
.method constructor <init>(Ljava/lang/String;)V
    .locals 5
    .param p1, "str"    # Ljava/lang/String;

    .prologue
    .line 35
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    .line 38
    :try_start_0
    new-instance v2, Lorg/json/JSONObject;

    invoke-direct {v2, p1}, Lorg/json/JSONObject;-><init>(Ljava/lang/String;)V

    .line 39
    .local v2, "resp":Lorg/json/JSONObject;
    const-string v3, "re"

    invoke-virtual {v2, v3}, Lorg/json/JSONObject;->getBoolean(Ljava/lang/String;)Z

    move-result v3

    iput-boolean v3, p0, Lcom/iflytek/voiceads/dex/UpdateResp;->re:Z

    .line 40
    iget-boolean v3, p0, Lcom/iflytek/voiceads/dex/UpdateResp;->re:Z

    if-nez v3, :cond_0

    .line 50
    .end local v2    # "resp":Lorg/json/JSONObject;
    :goto_0
    return-void

    .line 43
    .restart local v2    # "resp":Lorg/json/JSONObject;
    :cond_0
    const-string v3, "data"

    invoke-virtual {v2, v3}, Lorg/json/JSONObject;->getJSONObject(Ljava/lang/String;)Lorg/json/JSONObject;

    move-result-object v1

    .line 44
    .local v1, "remoteVersionData":Lorg/json/JSONObject;
    const-string v3, "version"

    invoke-virtual {v1, v3}, Lorg/json/JSONObject;->getString(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v3

    iput-object v3, p0, Lcom/iflytek/voiceads/dex/UpdateResp;->remoteVersion:Ljava/lang/String;

    .line 45
    const-string v3, "url"

    invoke-virtual {v1, v3}, Lorg/json/JSONObject;->getString(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v3

    iput-object v3, p0, Lcom/iflytek/voiceads/dex/UpdateResp;->remoteUrl:Ljava/lang/String;

    .line 46
    new-instance v3, Ljava/lang/StringBuilder;

    invoke-direct {v3}, Ljava/lang/StringBuilder;-><init>()V

    const-string v4, "AdDex."

    invoke-virtual {v3, v4}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v3

    const-string v4, "sub_version"

    invoke-virtual {v1, v4}, Lorg/json/JSONObject;->getString(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v4

    invoke-virtual {v3, v4}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v3

    const-string v4, ".dex"

    invoke-virtual {v3, v4}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v3

    invoke-virtual {v3}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v3

    iput-object v3, p0, Lcom/iflytek/voiceads/dex/UpdateResp;->remoteSubversion:Ljava/lang/String;
    :try_end_0
    .catch Lorg/json/JSONException; {:try_start_0 .. :try_end_0} :catch_0

    goto :goto_0

    .line 47
    .end local v1    # "remoteVersionData":Lorg/json/JSONObject;
    .end local v2    # "resp":Lorg/json/JSONObject;
    :catch_0
    move-exception v0

    .line 48
    .local v0, "e":Lorg/json/JSONException;
    invoke-virtual {v0}, Lorg/json/JSONException;->printStackTrace()V

    goto :goto_0
.end method

.method static parseData(Ljava/lang/String;)Lcom/iflytek/voiceads/dex/UpdateResp;
    .locals 1
    .param p0, "str"    # Ljava/lang/String;

    .prologue
    .line 53
    new-instance v0, Lcom/iflytek/voiceads/dex/UpdateResp;

    invoke-direct {v0, p0}, Lcom/iflytek/voiceads/dex/UpdateResp;-><init>(Ljava/lang/String;)V

    return-object v0
.end method


# virtual methods
.method public getRemoteSubversion()Ljava/lang/String;
    .locals 1

    .prologue
    .line 27
    iget-object v0, p0, Lcom/iflytek/voiceads/dex/UpdateResp;->remoteSubversion:Ljava/lang/String;

    return-object v0
.end method

.method public getRemoteUrl()Ljava/lang/String;
    .locals 1

    .prologue
    .line 23
    iget-object v0, p0, Lcom/iflytek/voiceads/dex/UpdateResp;->remoteUrl:Ljava/lang/String;

    return-object v0
.end method

.method public getRemoteVersion()Ljava/lang/String;
    .locals 1

    .prologue
    .line 19
    iget-object v0, p0, Lcom/iflytek/voiceads/dex/UpdateResp;->remoteVersion:Ljava/lang/String;

    return-object v0
.end method

.method public isRe()Z
    .locals 1

    .prologue
    .line 15
    iget-boolean v0, p0, Lcom/iflytek/voiceads/dex/UpdateResp;->re:Z

    return v0
.end method
