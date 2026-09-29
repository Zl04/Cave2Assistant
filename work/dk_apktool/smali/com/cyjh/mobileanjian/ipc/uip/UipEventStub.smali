.class public Lcom/cyjh/mobileanjian/ipc/uip/UipEventStub;
.super Ljava/lang/Object;
.source "SourceFile"


# static fields
.field private static a:Landroid/os/Handler;

.field private static b:Ljava/util/concurrent/ArrayBlockingQueue;
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "Ljava/util/concurrent/ArrayBlockingQueue",
            "<",
            "Lcom/google/protobuf/ByteString;",
            ">;"
        }
    .end annotation
.end field

.field private static c:Ljava/util/concurrent/ArrayBlockingQueue;
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "Ljava/util/concurrent/ArrayBlockingQueue",
            "<",
            "Lcom/google/protobuf/ByteString;",
            ">;"
        }
    .end annotation
.end field


# direct methods
.method static constructor <clinit>()V
    .locals 2

    .prologue
    .line 18
    new-instance v0, Ljava/util/concurrent/ArrayBlockingQueue;

    const/4 v1, 0x1

    invoke-direct {v0, v1}, Ljava/util/concurrent/ArrayBlockingQueue;-><init>(I)V

    sput-object v0, Lcom/cyjh/mobileanjian/ipc/uip/UipEventStub;->b:Ljava/util/concurrent/ArrayBlockingQueue;

    .line 63
    new-instance v0, Ljava/util/concurrent/ArrayBlockingQueue;

    const/16 v1, 0x100

    invoke-direct {v0, v1}, Ljava/util/concurrent/ArrayBlockingQueue;-><init>(I)V

    sput-object v0, Lcom/cyjh/mobileanjian/ipc/uip/UipEventStub;->c:Ljava/util/concurrent/ArrayBlockingQueue;

    return-void
.end method

.method public constructor <init>()V
    .locals 0

    .prologue
    .line 15
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method

.method public static GetUiEvent()[B
    .locals 2

    .prologue
    const/4 v1, 0x0

    .line 67
    const-string v0, "Call GetUiEvent <--"

    invoke-static {v0}, Lcom/cyjh/mobileanjian/ipc/utils/CLog;->i(Ljava/lang/String;)V

    .line 68
    invoke-static {}, Lcom/cyjh/mobileanjian/ipc/uip/UipEventStub;->a()Z

    move-result v0

    if-nez v0, :cond_0

    move-object v0, v1

    .line 78
    :goto_0
    return-object v0

    .line 73
    :cond_0
    :try_start_0
    sget-object v0, Lcom/cyjh/mobileanjian/ipc/uip/UipEventStub;->c:Ljava/util/concurrent/ArrayBlockingQueue;

    invoke-virtual {v0}, Ljava/util/concurrent/ArrayBlockingQueue;->take()Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Lcom/google/protobuf/ByteString;

    invoke-virtual {v0}, Lcom/google/protobuf/ByteString;->toByteArray()[B
    :try_end_0
    .catch Ljava/lang/InterruptedException; {:try_start_0 .. :try_end_0} :catch_0

    move-result-object v0

    goto :goto_0

    .line 74
    :catch_0
    move-exception v0

    .line 76
    invoke-virtual {v0}, Ljava/lang/InterruptedException;->printStackTrace()V

    move-object v0, v1

    .line 78
    goto :goto_0
.end method

.method public static SendUiRequest([B)[B
    .locals 4

    .prologue
    const/4 v1, 0x0

    .line 32
    invoke-static {}, Lcom/cyjh/mobileanjian/ipc/uip/UipEventStub;->a()Z

    move-result v0

    if-nez v0, :cond_0

    move-object v0, v1

    .line 46
    :goto_0
    return-object v0

    .line 36
    :cond_0
    sget-object v0, Lcom/cyjh/mobileanjian/ipc/uip/UipEventStub;->a:Landroid/os/Handler;

    const/4 v2, 0x0

    invoke-static {p0}, Lcom/google/protobuf/ByteString;->copyFrom([B)Lcom/google/protobuf/ByteString;

    move-result-object v3

    invoke-virtual {v0, v2, v3}, Landroid/os/Handler;->obtainMessage(ILjava/lang/Object;)Landroid/os/Message;

    move-result-object v0

    .line 37
    invoke-virtual {v0}, Landroid/os/Message;->sendToTarget()V

    .line 38
    const-string v0, "MQ commit Request"

    invoke-static {v0}, Lcom/cyjh/mobileanjian/ipc/utils/CLog;->d(Ljava/lang/String;)V

    .line 41
    :try_start_0
    sget-object v0, Lcom/cyjh/mobileanjian/ipc/uip/UipEventStub;->b:Ljava/util/concurrent/ArrayBlockingQueue;

    invoke-virtual {v0}, Ljava/util/concurrent/ArrayBlockingQueue;->take()Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Lcom/google/protobuf/ByteString;

    invoke-virtual {v0}, Lcom/google/protobuf/ByteString;->toByteArray()[B
    :try_end_0
    .catch Ljava/lang/InterruptedException; {:try_start_0 .. :try_end_0} :catch_0

    move-result-object v0

    goto :goto_0

    .line 42
    :catch_0
    move-exception v0

    .line 44
    invoke-virtual {v0}, Ljava/lang/InterruptedException;->printStackTrace()V

    move-object v0, v1

    .line 46
    goto :goto_0
.end method

.method public static UiRequestReturn(Lcom/google/protobuf/ByteString;)V
    .locals 1

    .prologue
    .line 53
    :try_start_0
    sget-object v0, Lcom/cyjh/mobileanjian/ipc/uip/UipEventStub;->b:Ljava/util/concurrent/ArrayBlockingQueue;

    invoke-virtual {v0, p0}, Ljava/util/concurrent/ArrayBlockingQueue;->put(Ljava/lang/Object;)V
    :try_end_0
    .catch Ljava/lang/InterruptedException; {:try_start_0 .. :try_end_0} :catch_0

    .line 58
    :goto_0
    const-string v0, "Getdata returned"

    invoke-static {v0}, Lcom/cyjh/mobileanjian/ipc/utils/CLog;->d(Ljava/lang/String;)V

    .line 59
    return-void

    .line 54
    :catch_0
    move-exception v0

    .line 56
    invoke-virtual {v0}, Ljava/lang/InterruptedException;->printStackTrace()V

    goto :goto_0
.end method

.method private static a()Z
    .locals 2

    .prologue
    .line 27
    invoke-static {}, Landroid/os/Process;->myUid()I

    move-result v0

    if-eqz v0, :cond_0

    invoke-static {}, Landroid/os/Process;->myUid()I

    move-result v0

    const/16 v1, 0x7d0

    if-eq v0, v1, :cond_0

    const/4 v0, 0x1

    :goto_0
    return v0

    :cond_0
    const/4 v0, 0x0

    goto :goto_0
.end method

.method public static clear()V
    .locals 1

    .prologue
    .line 95
    sget-object v0, Lcom/cyjh/mobileanjian/ipc/uip/UipEventStub;->c:Ljava/util/concurrent/ArrayBlockingQueue;

    invoke-virtual {v0}, Ljava/util/concurrent/ArrayBlockingQueue;->clear()V

    .line 96
    return-void
.end method

.method public static hasEvent(Lcom/google/protobuf/ByteString;)V
    .locals 2

    .prologue
    .line 85
    :try_start_0
    sget-object v0, Lcom/cyjh/mobileanjian/ipc/uip/UipEventStub;->c:Ljava/util/concurrent/ArrayBlockingQueue;

    invoke-virtual {v0}, Ljava/util/concurrent/ArrayBlockingQueue;->size()I

    move-result v0

    const/16 v1, 0x100

    if-ge v0, v1, :cond_0

    .line 86
    sget-object v0, Lcom/cyjh/mobileanjian/ipc/uip/UipEventStub;->c:Ljava/util/concurrent/ArrayBlockingQueue;

    invoke-virtual {v0, p0}, Ljava/util/concurrent/ArrayBlockingQueue;->put(Ljava/lang/Object;)V
    :try_end_0
    .catch Ljava/lang/InterruptedException; {:try_start_0 .. :try_end_0} :catch_0

    .line 91
    :cond_0
    :goto_0
    return-void

    .line 87
    :catch_0
    move-exception v0

    .line 89
    invoke-virtual {v0}, Ljava/lang/InterruptedException;->printStackTrace()V

    goto :goto_0
.end method

.method public static registerHandler(Landroid/os/Handler;)V
    .locals 0

    .prologue
    .line 22
    sput-object p0, Lcom/cyjh/mobileanjian/ipc/uip/UipEventStub;->a:Landroid/os/Handler;

    .line 23
    return-void
.end method
