.class Lcom/cyjh/mobileanjian/ipc/ui/h$a;
.super Ljava/lang/Object;
.source "SourceFile"

# interfaces
.implements Landroid/text/TextWatcher;


# annotations
.annotation system Ldalvik/annotation/EnclosingClass;
    value = Lcom/cyjh/mobileanjian/ipc/ui/h;
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x2
    name = "a"
.end annotation


# instance fields
.field final synthetic a:Lcom/cyjh/mobileanjian/ipc/ui/h;

.field private b:Ljava/lang/String;


# direct methods
.method public constructor <init>(Lcom/cyjh/mobileanjian/ipc/ui/h;Ljava/lang/String;)V
    .locals 0

    .prologue
    .line 1478
    iput-object p1, p0, Lcom/cyjh/mobileanjian/ipc/ui/h$a;->a:Lcom/cyjh/mobileanjian/ipc/ui/h;

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    .line 1479
    iput-object p2, p0, Lcom/cyjh/mobileanjian/ipc/ui/h$a;->b:Ljava/lang/String;

    .line 1480
    return-void
.end method


# virtual methods
.method public a()Ljava/lang/String;
    .locals 1

    .prologue
    .line 1484
    iget-object v0, p0, Lcom/cyjh/mobileanjian/ipc/ui/h$a;->b:Ljava/lang/String;

    return-object v0
.end method

.method public afterTextChanged(Landroid/text/Editable;)V
    .locals 3

    .prologue
    .line 1502
    invoke-static {}, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$ControlEvent;->newBuilder()Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$ControlEvent$Builder;

    move-result-object v0

    iget-object v1, p0, Lcom/cyjh/mobileanjian/ipc/ui/h$a;->b:Ljava/lang/String;

    .line 1503
    invoke-virtual {v0, v1}, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$ControlEvent$Builder;->setControlId(Ljava/lang/String;)Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$ControlEvent$Builder;

    move-result-object v0

    sget-object v1, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$ControlEvent$Event_Type;->ON_CHANGE:Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$ControlEvent$Event_Type;

    .line 1504
    invoke-virtual {v0, v1}, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$ControlEvent$Builder;->setType(Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$ControlEvent$Event_Type;)Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$ControlEvent$Builder;

    move-result-object v0

    .line 1505
    invoke-virtual {v0}, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$ControlEvent$Builder;->build()Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$ControlEvent;

    move-result-object v0

    .line 1507
    invoke-static {}, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$UiToCommand;->newBuilder()Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$UiToCommand$Builder;

    move-result-object v1

    sget-object v2, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$UiToCommand$Command_Type;->EVENT:Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$UiToCommand$Command_Type;

    .line 1508
    invoke-virtual {v1, v2}, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$UiToCommand$Builder;->setCommand(Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$UiToCommand$Command_Type;)Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$UiToCommand$Builder;

    move-result-object v1

    .line 1509
    invoke-virtual {v1, v0}, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$UiToCommand$Builder;->setEvent(Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$ControlEvent;)Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$UiToCommand$Builder;

    move-result-object v0

    const/4 v1, 0x1

    .line 1510
    invoke-virtual {v0, v1}, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$UiToCommand$Builder;->setIsSuccess(Z)Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$UiToCommand$Builder;

    move-result-object v0

    .line 1511
    invoke-virtual {v0}, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$UiToCommand$Builder;->build()Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$UiToCommand;

    move-result-object v0

    .line 1512
    invoke-static {}, Lcom/cyjh/mobileanjian/ipc/MqRunner;->getInstance()Lcom/cyjh/mobileanjian/ipc/MqRunner;

    move-result-object v1

    invoke-virtual {v0}, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$UiToCommand;->toByteString()Lcom/google/protobuf/ByteString;

    move-result-object v0

    invoke-virtual {v1, v0}, Lcom/cyjh/mobileanjian/ipc/MqRunner;->notifyUiEvent(Lcom/google/protobuf/ByteString;)V

    .line 1513
    iget-object v0, p0, Lcom/cyjh/mobileanjian/ipc/ui/h$a;->a:Lcom/cyjh/mobileanjian/ipc/ui/h;

    invoke-static {v0}, Lcom/cyjh/mobileanjian/ipc/ui/h;->a(Lcom/cyjh/mobileanjian/ipc/ui/h;)[Lcom/cyjh/mobileanjian/ipc/ui/i;

    move-result-object v0

    iget-object v1, p0, Lcom/cyjh/mobileanjian/ipc/ui/h$a;->a:Lcom/cyjh/mobileanjian/ipc/ui/h;

    invoke-static {v1}, Lcom/cyjh/mobileanjian/ipc/ui/h;->b(Lcom/cyjh/mobileanjian/ipc/ui/h;)I

    move-result v1

    aget-object v0, v0, v1

    invoke-virtual {v0}, Lcom/cyjh/mobileanjian/ipc/ui/i;->c()V

    .line 1514
    return-void
.end method

.method public beforeTextChanged(Ljava/lang/CharSequence;III)V
    .locals 0

    .prologue
    .line 1491
    return-void
.end method

.method public onTextChanged(Ljava/lang/CharSequence;III)V
    .locals 0

    .prologue
    .line 1497
    return-void
.end method
