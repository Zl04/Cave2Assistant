.class public Lcom/cyjh/mobileanjian/ipc/uip/UisScriptRunner;
.super Ljava/lang/Object;
.source "SourceFile"


# static fields
.field private static a:Lcom/cyjh/mobileanjian/ipc/uip/UisScriptRunner;

.field private static b:Z


# instance fields
.field private c:Lcom/cyjh/mqm/MQUipStub;


# direct methods
.method static constructor <clinit>()V
    .locals 1

    .prologue
    .line 13
    const/4 v0, 0x0

    sput-boolean v0, Lcom/cyjh/mobileanjian/ipc/uip/UisScriptRunner;->b:Z

    return-void
.end method

.method private constructor <init>()V
    .locals 1

    .prologue
    .line 18
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    .line 19
    new-instance v0, Lcom/cyjh/mqm/MQUipStub;

    invoke-direct {v0}, Lcom/cyjh/mqm/MQUipStub;-><init>()V

    iput-object v0, p0, Lcom/cyjh/mobileanjian/ipc/uip/UisScriptRunner;->c:Lcom/cyjh/mqm/MQUipStub;

    .line 20
    return-void
.end method

.method static synthetic a(Lcom/cyjh/mobileanjian/ipc/uip/UisScriptRunner;)Lcom/cyjh/mqm/MQUipStub;
    .locals 1

    .prologue
    .line 10
    iget-object v0, p0, Lcom/cyjh/mobileanjian/ipc/uip/UisScriptRunner;->c:Lcom/cyjh/mqm/MQUipStub;

    return-object v0
.end method

.method private a(J)V
    .locals 1

    .prologue
    .line 79
    :try_start_0
    invoke-static {p1, p2}, Ljava/lang/Thread;->sleep(J)V
    :try_end_0
    .catch Ljava/lang/InterruptedException; {:try_start_0 .. :try_end_0} :catch_0

    .line 84
    :goto_0
    return-void

    .line 80
    :catch_0
    move-exception v0

    .line 82
    invoke-virtual {v0}, Ljava/lang/InterruptedException;->printStackTrace()V

    goto :goto_0
.end method

.method static synthetic a(Z)Z
    .locals 0

    .prologue
    .line 10
    sput-boolean p0, Lcom/cyjh/mobileanjian/ipc/uip/UisScriptRunner;->b:Z

    return p0
.end method

.method public static getInstance()Lcom/cyjh/mobileanjian/ipc/uip/UisScriptRunner;
    .locals 1

    .prologue
    .line 24
    sget-object v0, Lcom/cyjh/mobileanjian/ipc/uip/UisScriptRunner;->a:Lcom/cyjh/mobileanjian/ipc/uip/UisScriptRunner;

    if-nez v0, :cond_0

    .line 26
    new-instance v0, Lcom/cyjh/mobileanjian/ipc/uip/UisScriptRunner;

    invoke-direct {v0}, Lcom/cyjh/mobileanjian/ipc/uip/UisScriptRunner;-><init>()V

    sput-object v0, Lcom/cyjh/mobileanjian/ipc/uip/UisScriptRunner;->a:Lcom/cyjh/mobileanjian/ipc/uip/UisScriptRunner;

    .line 28
    :cond_0
    sget-object v0, Lcom/cyjh/mobileanjian/ipc/uip/UisScriptRunner;->a:Lcom/cyjh/mobileanjian/ipc/uip/UisScriptRunner;

    return-object v0
.end method


# virtual methods
.method public startLoop(Ljava/lang/String;)V
    .locals 2

    .prologue
    .line 33
    sget-boolean v0, Lcom/cyjh/mobileanjian/ipc/uip/UisScriptRunner;->b:Z

    if-eqz v0, :cond_0

    .line 35
    invoke-virtual {p0}, Lcom/cyjh/mobileanjian/ipc/uip/UisScriptRunner;->stopLoop()V

    .line 36
    :goto_0
    sget-boolean v0, Lcom/cyjh/mobileanjian/ipc/uip/UisScriptRunner;->b:Z

    if-eqz v0, :cond_0

    .line 38
    const-wide/16 v0, 0x32

    invoke-direct {p0, v0, v1}, Lcom/cyjh/mobileanjian/ipc/uip/UisScriptRunner;->a(J)V

    goto :goto_0

    .line 42
    :cond_0
    new-instance v0, Lcom/cyjh/mobileanjian/ipc/uip/UisScriptRunner$1;

    invoke-direct {v0, p0, p1}, Lcom/cyjh/mobileanjian/ipc/uip/UisScriptRunner$1;-><init>(Lcom/cyjh/mobileanjian/ipc/uip/UisScriptRunner;Ljava/lang/String;)V

    .line 54
    invoke-virtual {v0}, Lcom/cyjh/mobileanjian/ipc/uip/UisScriptRunner$1;->start()V

    .line 55
    return-void
.end method

.method public stopLoop()V
    .locals 3

    .prologue
    .line 59
    sget-boolean v0, Lcom/cyjh/mobileanjian/ipc/uip/UisScriptRunner;->b:Z

    if-eqz v0, :cond_0

    .line 61
    iget-object v0, p0, Lcom/cyjh/mobileanjian/ipc/uip/UisScriptRunner;->c:Lcom/cyjh/mqm/MQUipStub;

    invoke-virtual {v0}, Lcom/cyjh/mqm/MQUipStub;->StopLoop()V

    .line 62
    invoke-static {}, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$ControlEvent;->newBuilder()Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$ControlEvent$Builder;

    move-result-object v0

    const-string v1, "stop_id"

    .line 63
    invoke-virtual {v0, v1}, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$ControlEvent$Builder;->setControlId(Ljava/lang/String;)Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$ControlEvent$Builder;

    move-result-object v0

    sget-object v1, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$ControlEvent$Event_Type;->ON_CLOSE_EXIT:Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$ControlEvent$Event_Type;

    .line 64
    invoke-virtual {v0, v1}, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$ControlEvent$Builder;->setType(Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$ControlEvent$Event_Type;)Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$ControlEvent$Builder;

    move-result-object v0

    .line 65
    invoke-virtual {v0}, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$ControlEvent$Builder;->build()Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$ControlEvent;

    move-result-object v0

    .line 66
    invoke-static {}, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$UipToCommand;->newBuilder()Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$UipToCommand$Builder;

    move-result-object v1

    sget-object v2, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$UipToCommand$Command_Type;->EVENT:Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$UipToCommand$Command_Type;

    .line 67
    invoke-virtual {v1, v2}, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$UipToCommand$Builder;->setCommand(Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$UipToCommand$Command_Type;)Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$UipToCommand$Builder;

    move-result-object v1

    const/4 v2, 0x1

    .line 68
    invoke-virtual {v1, v2}, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$UipToCommand$Builder;->setIsSuccess(Z)Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$UipToCommand$Builder;

    move-result-object v1

    .line 69
    invoke-virtual {v1, v0}, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$UipToCommand$Builder;->setEvent(Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$ControlEvent;)Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$UipToCommand$Builder;

    move-result-object v0

    invoke-virtual {v0}, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$UipToCommand$Builder;->build()Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$UipToCommand;

    move-result-object v0

    .line 71
    invoke-virtual {v0}, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$UipToCommand;->toByteString()Lcom/google/protobuf/ByteString;

    move-result-object v0

    invoke-static {v0}, Lcom/cyjh/mobileanjian/ipc/uip/UipEventStub;->hasEvent(Lcom/google/protobuf/ByteString;)V

    .line 73
    :cond_0
    return-void
.end method
