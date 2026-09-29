.class Lcom/cyjh/elfin/AppContext$2;
.super Ljava/lang/Object;
.source "AppContext.java"

# interfaces
.implements Ljava/lang/Runnable;


# annotations
.annotation system Ldalvik/annotation/EnclosingMethod;
    value = Lcom/cyjh/elfin/AppContext;->statistics()V
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x0
    name = null
.end annotation


# instance fields
.field final synthetic this$0:Lcom/cyjh/elfin/AppContext;


# direct methods
.method constructor <init>(Lcom/cyjh/elfin/AppContext;)V
    .locals 0
    .param p1, "this$0"    # Lcom/cyjh/elfin/AppContext;

    .prologue
    .line 389
    iput-object p1, p0, Lcom/cyjh/elfin/AppContext$2;->this$0:Lcom/cyjh/elfin/AppContext;

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method


# virtual methods
.method public run()V
    .locals 17

    .prologue
    .line 392
    new-instance v5, Lcom/cyjh/elfin/net/xutils/HttpTools;

    move-object/from16 v0, p0

    iget-object v14, v0, Lcom/cyjh/elfin/AppContext$2;->this$0:Lcom/cyjh/elfin/AppContext;

    invoke-direct {v5, v14}, Lcom/cyjh/elfin/net/xutils/HttpTools;-><init>(Landroid/content/Context;)V

    .line 394
    .local v5, "httpTools":Lcom/cyjh/elfin/net/xutils/HttpTools;
    const-string v12, "http://m.redirect.anjian.com:1311/submitlog.html"

    .line 395
    .local v12, "url":Ljava/lang/String;
    invoke-virtual {v5, v12}, Lcom/cyjh/elfin/net/xutils/HttpTools;->doGet(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v14

    invoke-virtual {v14}, Ljava/lang/String;->trim()Ljava/lang/String;

    move-result-object v10

    .line 396
    .local v10, "statisticsUrl":Ljava/lang/String;
    new-instance v14, Ljava/lang/StringBuilder;

    invoke-direct {v14}, Ljava/lang/StringBuilder;-><init>()V

    const-string v15, "http://"

    invoke-virtual {v14, v15}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v14

    invoke-virtual {v14, v10}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v14

    const-string v15, ":1312/appVisitLog.aspx"

    invoke-virtual {v14, v15}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v14

    invoke-virtual {v14}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v10

    .line 399
    move-object/from16 v0, p0

    iget-object v14, v0, Lcom/cyjh/elfin/AppContext$2;->this$0:Lcom/cyjh/elfin/AppContext;

    const-string v15, "phone"

    invoke-virtual {v14, v15}, Lcom/cyjh/elfin/AppContext;->getSystemService(Ljava/lang/String;)Ljava/lang/Object;

    move-result-object v11

    check-cast v11, Landroid/telephony/TelephonyManager;

    .line 401
    .local v11, "telephonyManager":Landroid/telephony/TelephonyManager;
    invoke-virtual {v11}, Landroid/telephony/TelephonyManager;->getDeviceId()Ljava/lang/String;

    move-result-object v1

    .line 403
    .local v1, "IMEI":Ljava/lang/String;
    move-object/from16 v0, p0

    iget-object v14, v0, Lcom/cyjh/elfin/AppContext$2;->this$0:Lcom/cyjh/elfin/AppContext;

    const-string v15, "wifi"

    invoke-virtual {v14, v15}, Lcom/cyjh/elfin/AppContext;->getSystemService(Ljava/lang/String;)Ljava/lang/Object;

    move-result-object v13

    check-cast v13, Landroid/net/wifi/WifiManager;

    .line 404
    .local v13, "wifiMgr":Landroid/net/wifi/WifiManager;
    invoke-virtual {v13}, Landroid/net/wifi/WifiManager;->getConnectionInfo()Landroid/net/wifi/WifiInfo;

    move-result-object v6

    .line 405
    .local v6, "info":Landroid/net/wifi/WifiInfo;
    invoke-virtual {v6}, Landroid/net/wifi/WifiInfo;->getMacAddress()Ljava/lang/String;

    move-result-object v8

    .line 407
    .local v8, "macAddress":Ljava/lang/String;
    const-string v4, "device_code"

    .line 408
    .local v4, "device_code":Ljava/lang/String;
    const-string v3, "app_packagename"

    .line 409
    .local v3, "app_packagename":Ljava/lang/String;
    const-string v2, "app_name"

    .line 410
    .local v2, "app_name":Ljava/lang/String;
    const-string v7, "log_status"

    .line 412
    .local v7, "log_status":Ljava/lang/String;
    new-instance v9, Ljava/util/ArrayList;

    invoke-direct {v9}, Ljava/util/ArrayList;-><init>()V

    .line 413
    .local v9, "params":Ljava/util/List;, "Ljava/util/List<Lorg/apache/http/NameValuePair;>;"
    new-instance v14, Lorg/apache/http/message/BasicNameValuePair;

    new-instance v15, Ljava/lang/StringBuilder;

    invoke-direct {v15}, Ljava/lang/StringBuilder;-><init>()V

    invoke-virtual {v15, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v15

    const-string v16, "_"

    invoke-virtual/range {v15 .. v16}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v15

    invoke-virtual {v15, v8}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v15

    invoke-virtual {v15}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v15

    invoke-direct {v14, v4, v15}, Lorg/apache/http/message/BasicNameValuePair;-><init>(Ljava/lang/String;Ljava/lang/String;)V

    invoke-interface {v9, v14}, Ljava/util/List;->add(Ljava/lang/Object;)Z

    .line 414
    new-instance v14, Lorg/apache/http/message/BasicNameValuePair;

    move-object/from16 v0, p0

    iget-object v15, v0, Lcom/cyjh/elfin/AppContext$2;->this$0:Lcom/cyjh/elfin/AppContext;

    invoke-virtual {v15}, Lcom/cyjh/elfin/AppContext;->getPackageName()Ljava/lang/String;

    move-result-object v15

    invoke-direct {v14, v3, v15}, Lorg/apache/http/message/BasicNameValuePair;-><init>(Ljava/lang/String;Ljava/lang/String;)V

    invoke-interface {v9, v14}, Ljava/util/List;->add(Ljava/lang/Object;)Z

    .line 415
    new-instance v14, Lorg/apache/http/message/BasicNameValuePair;

    move-object/from16 v0, p0

    iget-object v15, v0, Lcom/cyjh/elfin/AppContext$2;->this$0:Lcom/cyjh/elfin/AppContext;

    const v16, 0x7f08003b

    invoke-virtual/range {v15 .. v16}, Lcom/cyjh/elfin/AppContext;->getString(I)Ljava/lang/String;

    move-result-object v15

    invoke-direct {v14, v2, v15}, Lorg/apache/http/message/BasicNameValuePair;-><init>(Ljava/lang/String;Ljava/lang/String;)V

    invoke-interface {v9, v14}, Ljava/util/List;->add(Ljava/lang/Object;)Z

    .line 416
    new-instance v14, Lorg/apache/http/message/BasicNameValuePair;

    const-string v15, "1"

    invoke-direct {v14, v7, v15}, Lorg/apache/http/message/BasicNameValuePair;-><init>(Ljava/lang/String;Ljava/lang/String;)V

    invoke-interface {v9, v14}, Ljava/util/List;->add(Ljava/lang/Object;)Z

    .line 417
    invoke-virtual {v5, v10, v9}, Lcom/cyjh/elfin/net/xutils/HttpTools;->doPost(Ljava/lang/String;Ljava/util/List;)Ljava/lang/String;

    .line 418
    return-void
.end method
