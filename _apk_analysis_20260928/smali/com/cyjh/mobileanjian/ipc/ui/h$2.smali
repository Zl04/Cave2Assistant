.class Lcom/cyjh/mobileanjian/ipc/ui/h$2;
.super Ljava/lang/Object;
.source "SourceFile"

# interfaces
.implements Landroid/view/View$OnClickListener;


# annotations
.annotation system Ldalvik/annotation/EnclosingMethod;
    value = Lcom/cyjh/mobileanjian/ipc/ui/h;->a(Ljava/lang/String;II)V
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x0
    name = null
.end annotation


# instance fields
.field final synthetic a:Ljava/lang/String;

.field final synthetic b:Lcom/cyjh/mobileanjian/ipc/ui/h;


# direct methods
.method constructor <init>(Lcom/cyjh/mobileanjian/ipc/ui/h;Ljava/lang/String;)V
    .locals 0

    .prologue
    .line 1197
    iput-object p1, p0, Lcom/cyjh/mobileanjian/ipc/ui/h$2;->b:Lcom/cyjh/mobileanjian/ipc/ui/h;

    iput-object p2, p0, Lcom/cyjh/mobileanjian/ipc/ui/h$2;->a:Ljava/lang/String;

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method


# virtual methods
.method public onClick(Landroid/view/View;)V
    .locals 3

    .prologue
    .line 1204
    invoke-static {}, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$ControlEvent;->newBuilder()Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$ControlEvent$Builder;

    move-result-object v0

    iget-object v1, p0, Lcom/cyjh/mobileanjian/ipc/ui/h$2;->a:Ljava/lang/String;

    .line 1205
    invoke-virtual {v0, v1}, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$ControlEvent$Builder;->setControlId(Ljava/lang/String;)Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$ControlEvent$Builder;

    move-result-object v0

    sget-object v1, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$ControlEvent$Event_Type;->ON_CLOSE_EXIT:Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$ControlEvent$Event_Type;

    .line 1206
    invoke-virtual {v0, v1}, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$ControlEvent$Builder;->setType(Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$ControlEvent$Event_Type;)Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$ControlEvent$Builder;

    move-result-object v0

    .line 1207
    invoke-virtual {v0}, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$ControlEvent$Builder;->build()Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$ControlEvent;

    move-result-object v0

    .line 1208
    invoke-static {}, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$UiToCommand;->newBuilder()Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$UiToCommand$Builder;

    move-result-object v1

    sget-object v2, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$UiToCommand$Command_Type;->EVENT:Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$UiToCommand$Command_Type;

    .line 1209
    invoke-virtual {v1, v2}, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$UiToCommand$Builder;->setCommand(Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$UiToCommand$Command_Type;)Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$UiToCommand$Builder;

    move-result-object v1

    .line 1210
    invoke-virtual {v1, v0}, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$UiToCommand$Builder;->setEvent(Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$ControlEvent;)Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$UiToCommand$Builder;

    move-result-object v0

    const/4 v1, 0x1

    .line 1211
    invoke-virtual {v0, v1}, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$UiToCommand$Builder;->setIsSuccess(Z)Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$UiToCommand$Builder;

    move-result-object v0

    .line 1212
    invoke-virtual {v0}, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$UiToCommand$Builder;->build()Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$UiToCommand;

    move-result-object v0

    .line 1213
    invoke-static {}, Lcom/cyjh/mobileanjian/ipc/MqRunner;->getInstance()Lcom/cyjh/mobileanjian/ipc/MqRunner;

    move-result-object v1

    invoke-virtual {v0}, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$UiToCommand;->toByteString()Lcom/google/protobuf/ByteString;

    move-result-object v2

    invoke-virtual {v1, v2}, Lcom/cyjh/mobileanjian/ipc/MqRunner;->notifyUiEvent(Lcom/google/protobuf/ByteString;)V

    .line 1214
    new-instance v1, Ljava/lang/StringBuilder;

    invoke-direct {v1}, Ljava/lang/StringBuilder;-><init>()V

    const-string v2, "exit event: "

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1, v0}, Ljava/lang/StringBuilder;->append(Ljava/lang/Object;)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-virtual {v0}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v0

    invoke-static {v0}, Lcom/cyjh/mobileanjian/ipc/utils/CLog;->i(Ljava/lang/String;)V

    .line 1215
    return-void
.end method
