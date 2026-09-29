.class public Lcom/cyjh/elfin/services/PhoneStateService$PhoneStateReceiver;
.super Landroid/content/BroadcastReceiver;
.source "PhoneStateService.java"


# annotations
.annotation system Ldalvik/annotation/EnclosingClass;
    value = Lcom/cyjh/elfin/services/PhoneStateService;
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x1
    name = "PhoneStateReceiver"
.end annotation


# instance fields
.field final synthetic this$0:Lcom/cyjh/elfin/services/PhoneStateService;


# direct methods
.method public constructor <init>(Lcom/cyjh/elfin/services/PhoneStateService;)V
    .locals 0
    .param p1, "this$0"    # Lcom/cyjh/elfin/services/PhoneStateService;

    .prologue
    .line 86
    iput-object p1, p0, Lcom/cyjh/elfin/services/PhoneStateService$PhoneStateReceiver;->this$0:Lcom/cyjh/elfin/services/PhoneStateService;

    invoke-direct {p0}, Landroid/content/BroadcastReceiver;-><init>()V

    return-void
.end method


# virtual methods
.method public onReceive(Landroid/content/Context;Landroid/content/Intent;)V
    .locals 7
    .param p1, "context"    # Landroid/content/Context;
    .param p2, "intent"    # Landroid/content/Intent;

    .prologue
    const/4 v6, 0x1

    .line 89
    invoke-virtual {p2}, Landroid/content/Intent;->getAction()Ljava/lang/String;

    move-result-object v0

    .line 90
    .local v0, "action":Ljava/lang/String;
    iget-object v3, p0, Lcom/cyjh/elfin/services/PhoneStateService$PhoneStateReceiver;->this$0:Lcom/cyjh/elfin/services/PhoneStateService;

    iget-object v3, v3, Lcom/cyjh/elfin/services/PhoneStateService;->commonLog:Lcom/cyjh/elfin/log/CommonLog;

    const-string v4, ">>>>>>>>>\u7535\u8bdd\u5e7f\u64ad\u76d1\u542c\u5df2\u8fdb\u6765"

    invoke-virtual {v3, v4}, Lcom/cyjh/elfin/log/CommonLog;->e(Ljava/lang/Object;)V

    .line 91
    iget-object v3, p0, Lcom/cyjh/elfin/services/PhoneStateService$PhoneStateReceiver;->this$0:Lcom/cyjh/elfin/services/PhoneStateService;

    iget-object v3, v3, Lcom/cyjh/elfin/services/PhoneStateService;->commonLog:Lcom/cyjh/elfin/log/CommonLog;

    new-instance v4, Ljava/lang/StringBuilder;

    invoke-direct {v4}, Ljava/lang/StringBuilder;-><init>()V

    const-string v5, ">>>>>>action>>>>"

    invoke-virtual {v4, v5}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v4

    invoke-virtual {v4, v0}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v4

    invoke-virtual {v4}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v4

    invoke-virtual {v3, v4}, Lcom/cyjh/elfin/log/CommonLog;->e(Ljava/lang/Object;)V

    .line 92
    const-string v3, "android.intent.action.NEW_OUTGOING_CALL"

    invoke-virtual {v3, v0}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v3

    if-eqz v3, :cond_1

    .line 115
    :cond_0
    :goto_0
    return-void

    .line 94
    :cond_1
    const-string v3, "android.intent.action.PHONE_STATE"

    invoke-virtual {v3, v0}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v3

    if-eqz v3, :cond_0

    .line 96
    const-string v3, "phone"

    invoke-virtual {p1, v3}, Landroid/content/Context;->getSystemService(Ljava/lang/String;)Ljava/lang/Object;

    move-result-object v2

    check-cast v2, Landroid/telephony/TelephonyManager;

    .line 97
    .local v2, "tm":Landroid/telephony/TelephonyManager;
    iget-object v3, p0, Lcom/cyjh/elfin/services/PhoneStateService$PhoneStateReceiver;->this$0:Lcom/cyjh/elfin/services/PhoneStateService;

    iget-object v3, v3, Lcom/cyjh/elfin/services/PhoneStateService;->appContext:Lcom/cyjh/elfin/AppContext;

    iget-object v1, v3, Lcom/cyjh/elfin/AppContext;->sharedPreferences:Landroid/content/SharedPreferences;

    .line 98
    .local v1, "preferences":Landroid/content/SharedPreferences;
    iget-object v3, p0, Lcom/cyjh/elfin/services/PhoneStateService$PhoneStateReceiver;->this$0:Lcom/cyjh/elfin/services/PhoneStateService;

    iget-object v3, v3, Lcom/cyjh/elfin/services/PhoneStateService;->commonLog:Lcom/cyjh/elfin/log/CommonLog;

    new-instance v4, Ljava/lang/StringBuilder;

    invoke-direct {v4}, Ljava/lang/StringBuilder;-><init>()V

    const-string v5, "tm.getCallState()>>>>"

    invoke-virtual {v4, v5}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v4

    invoke-virtual {v2}, Landroid/telephony/TelephonyManager;->getCallState()I

    move-result v5

    invoke-virtual {v4, v5}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v4

    invoke-virtual {v4}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v4

    invoke-virtual {v3, v4}, Lcom/cyjh/elfin/log/CommonLog;->e(Ljava/lang/Object;)V

    .line 99
    invoke-virtual {v2}, Landroid/telephony/TelephonyManager;->getCallState()I

    move-result v3

    packed-switch v3, :pswitch_data_0

    goto :goto_0

    .line 101
    :pswitch_0
    iget-object v3, p0, Lcom/cyjh/elfin/services/PhoneStateService$PhoneStateReceiver;->this$0:Lcom/cyjh/elfin/services/PhoneStateService;

    iget-object v3, v3, Lcom/cyjh/elfin/services/PhoneStateService;->commonLog:Lcom/cyjh/elfin/log/CommonLog;

    new-instance v4, Ljava/lang/StringBuilder;

    invoke-direct {v4}, Ljava/lang/StringBuilder;-><init>()V

    const-string v5, "\u7ee7\u7eed\u9009\u9879>>>"

    invoke-virtual {v4, v5}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v4

    const-string v5, "com.cyjh.elfin.activity.SettingActivity.swtCallStop"

    invoke-interface {v1, v5, v6}, Landroid/content/SharedPreferences;->getBoolean(Ljava/lang/String;Z)Z

    move-result v5

    invoke-virtual {v4, v5}, Ljava/lang/StringBuilder;->append(Z)Ljava/lang/StringBuilder;

    move-result-object v4

    invoke-virtual {v4}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v4

    invoke-virtual {v3, v4}, Lcom/cyjh/elfin/log/CommonLog;->e(Ljava/lang/Object;)V

    .line 102
    const-string v3, "com.cyjh.elfin.activity.SettingActivity.swtCallStop"

    invoke-interface {v1, v3, v6}, Landroid/content/SharedPreferences;->getBoolean(Ljava/lang/String;Z)Z

    move-result v3

    if-eqz v3, :cond_0

    .line 103
    iget-object v3, p0, Lcom/cyjh/elfin/services/PhoneStateService$PhoneStateReceiver;->this$0:Lcom/cyjh/elfin/services/PhoneStateService;

    iget-object v3, v3, Lcom/cyjh/elfin/services/PhoneStateService;->commonLog:Lcom/cyjh/elfin/log/CommonLog;

    const-string v4, "\u505c\u6b62\u811a\u672c>>>>>"

    invoke-virtual {v3, v4}, Lcom/cyjh/elfin/log/CommonLog;->e(Ljava/lang/Object;)V

    .line 104
    invoke-static {}, Lcom/cyjh/mobileanjian/ipc/MqRunner;->getInstance()Lcom/cyjh/mobileanjian/ipc/MqRunner;

    move-result-object v3

    invoke-virtual {v3}, Lcom/cyjh/mobileanjian/ipc/MqRunner;->stop()V

    goto :goto_0

    .line 108
    :pswitch_1
    const-string v3, "com.cyjh.elfin.activity.SettingActivity.swtCallStop"

    invoke-interface {v1, v3, v6}, Landroid/content/SharedPreferences;->getBoolean(Ljava/lang/String;Z)Z

    move-result v3

    if-eqz v3, :cond_0

    .line 109
    invoke-static {}, Lcom/cyjh/mobileanjian/ipc/MqRunner;->getInstance()Lcom/cyjh/mobileanjian/ipc/MqRunner;

    move-result-object v3

    invoke-virtual {v3}, Lcom/cyjh/mobileanjian/ipc/MqRunner;->stop()V

    goto/16 :goto_0

    .line 99
    nop

    :pswitch_data_0
    .packed-switch 0x1
        :pswitch_0
        :pswitch_1
    .end packed-switch
.end method
