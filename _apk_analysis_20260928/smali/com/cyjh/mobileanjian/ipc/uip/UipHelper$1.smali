.class Lcom/cyjh/mobileanjian/ipc/uip/UipHelper$1;
.super Landroid/os/Handler;
.source "SourceFile"


# annotations
.annotation system Ldalvik/annotation/EnclosingClass;
    value = Lcom/cyjh/mobileanjian/ipc/uip/UipHelper;
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x0
    name = null
.end annotation


# instance fields
.field final synthetic a:Lcom/cyjh/mobileanjian/ipc/uip/UipHelper;


# direct methods
.method constructor <init>(Lcom/cyjh/mobileanjian/ipc/uip/UipHelper;)V
    .locals 0

    .prologue
    .line 588
    iput-object p1, p0, Lcom/cyjh/mobileanjian/ipc/uip/UipHelper$1;->a:Lcom/cyjh/mobileanjian/ipc/uip/UipHelper;

    invoke-direct {p0}, Landroid/os/Handler;-><init>()V

    return-void
.end method


# virtual methods
.method public handleMessage(Landroid/os/Message;)V
    .locals 5

    .prologue
    .line 592
    iget v0, p1, Landroid/os/Message;->what:I

    packed-switch v0, :pswitch_data_0

    .line 619
    :cond_0
    :goto_0
    return-void

    .line 597
    :pswitch_0
    :try_start_0
    iget-object v0, p1, Landroid/os/Message;->obj:Ljava/lang/Object;

    check-cast v0, Lcom/google/protobuf/ByteString;

    invoke-static {v0}, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$CommandToUip;->parseFrom(Lcom/google/protobuf/ByteString;)Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$CommandToUip;

    move-result-object v0

    .line 598
    invoke-virtual {v0}, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$CommandToUip;->getCommand()Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$CommandToUip$Command_Type;

    move-result-object v1

    .line 599
    invoke-virtual {v0}, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$CommandToUip;->getControlId()Ljava/lang/String;

    move-result-object v2

    .line 601
    new-instance v3, Ljava/lang/StringBuilder;

    invoke-direct {v3}, Ljava/lang/StringBuilder;-><init>()V

    const-string v4, "GET UIP Command -->"

    invoke-virtual {v3, v4}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v3

    invoke-virtual {v3, v0}, Ljava/lang/StringBuilder;->append(Ljava/lang/Object;)Ljava/lang/StringBuilder;

    move-result-object v3

    invoke-virtual {v3}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v3

    invoke-static {v3}, Lcom/cyjh/mobileanjian/ipc/utils/CLog;->d(Ljava/lang/String;)V

    .line 602
    sget-object v3, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$CommandToUip$Command_Type;->GET_UIP_ATTRIBUTE:Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$CommandToUip$Command_Type;

    if-ne v1, v3, :cond_1

    .line 604
    iget-object v0, p0, Lcom/cyjh/mobileanjian/ipc/uip/UipHelper$1;->a:Lcom/cyjh/mobileanjian/ipc/uip/UipHelper;

    invoke-static {v0, v2}, Lcom/cyjh/mobileanjian/ipc/uip/UipHelper;->a(Lcom/cyjh/mobileanjian/ipc/uip/UipHelper;Ljava/lang/String;)V
    :try_end_0
    .catch Lcom/google/protobuf/InvalidProtocolBufferException; {:try_start_0 .. :try_end_0} :catch_0
    .catch Lorg/json/JSONException; {:try_start_0 .. :try_end_0} :catch_1

    goto :goto_0

    .line 610
    :catch_0
    move-exception v0

    .line 612
    invoke-virtual {v0}, Lcom/google/protobuf/InvalidProtocolBufferException;->printStackTrace()V

    goto :goto_0

    .line 605
    :cond_1
    :try_start_1
    sget-object v3, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$CommandToUip$Command_Type;->SET_UIP_ATTRIBUTE:Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$CommandToUip$Command_Type;

    if-ne v1, v3, :cond_0

    .line 607
    invoke-virtual {v0}, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$CommandToUip;->getUipAttributeData()Ljava/lang/String;

    move-result-object v0

    .line 608
    iget-object v1, p0, Lcom/cyjh/mobileanjian/ipc/uip/UipHelper$1;->a:Lcom/cyjh/mobileanjian/ipc/uip/UipHelper;

    invoke-static {v1, v2, v0}, Lcom/cyjh/mobileanjian/ipc/uip/UipHelper;->a(Lcom/cyjh/mobileanjian/ipc/uip/UipHelper;Ljava/lang/String;Ljava/lang/String;)V
    :try_end_1
    .catch Lcom/google/protobuf/InvalidProtocolBufferException; {:try_start_1 .. :try_end_1} :catch_0
    .catch Lorg/json/JSONException; {:try_start_1 .. :try_end_1} :catch_1

    goto :goto_0

    .line 613
    :catch_1
    move-exception v0

    .line 615
    invoke-virtual {v0}, Lorg/json/JSONException;->printStackTrace()V

    goto :goto_0

    .line 592
    :pswitch_data_0
    .packed-switch 0x0
        :pswitch_0
    .end packed-switch
.end method
