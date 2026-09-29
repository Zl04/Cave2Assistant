.class public Lcom/cyjh/event/b;
.super Ljava/lang/Object;
.source "SourceFile"


# static fields
.field private static final a:Ljava/lang/Class;

.field private static b:Z

.field private static c:Lcom/google/protobuf/ByteString;

.field private static d:Ljava/util/concurrent/ArrayBlockingQueue;
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "Ljava/util/concurrent/ArrayBlockingQueue",
            "<",
            "Lcom/google/protobuf/ByteString;",
            ">;"
        }
    .end annotation
.end field

.field private static e:Ljava/util/concurrent/ArrayBlockingQueue;
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
    .line 16
    const-class v0, Lcom/cyjh/event/b;

    sput-object v0, Lcom/cyjh/event/b;->a:Ljava/lang/Class;

    .line 17
    const/4 v0, 0x0

    sput-boolean v0, Lcom/cyjh/event/b;->b:Z

    .line 18
    const/4 v0, 0x0

    sput-object v0, Lcom/cyjh/event/b;->c:Lcom/google/protobuf/ByteString;

    .line 19
    new-instance v0, Ljava/util/concurrent/ArrayBlockingQueue;

    const/16 v1, 0x10

    invoke-direct {v0, v1}, Ljava/util/concurrent/ArrayBlockingQueue;-><init>(I)V

    sput-object v0, Lcom/cyjh/event/b;->d:Ljava/util/concurrent/ArrayBlockingQueue;

    .line 70
    new-instance v0, Ljava/util/concurrent/ArrayBlockingQueue;

    const/16 v1, 0x400

    invoke-direct {v0, v1}, Ljava/util/concurrent/ArrayBlockingQueue;-><init>(I)V

    sput-object v0, Lcom/cyjh/event/b;->e:Ljava/util/concurrent/ArrayBlockingQueue;

    return-void
.end method

.method public constructor <init>()V
    .locals 0

    .prologue
    .line 14
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method

.method public static a(Lcom/google/protobuf/ByteString;)V
    .locals 1

    .prologue
    .line 59
    :try_start_0
    sget-object v0, Lcom/cyjh/event/b;->d:Ljava/util/concurrent/ArrayBlockingQueue;

    invoke-virtual {v0, p0}, Ljava/util/concurrent/ArrayBlockingQueue;->put(Ljava/lang/Object;)V
    :try_end_0
    .catch Ljava/lang/InterruptedException; {:try_start_0 .. :try_end_0} :catch_0

    .line 66
    :goto_0
    return-void

    .line 60
    :catch_0
    move-exception v0

    .line 62
    invoke-virtual {v0}, Ljava/lang/InterruptedException;->printStackTrace()V

    goto :goto_0
.end method

.method public static a()[B
    .locals 1

    .prologue
    .line 76
    :try_start_0
    sget-object v0, Lcom/cyjh/event/b;->e:Ljava/util/concurrent/ArrayBlockingQueue;

    invoke-virtual {v0}, Ljava/util/concurrent/ArrayBlockingQueue;->take()Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Lcom/google/protobuf/ByteString;

    invoke-virtual {v0}, Lcom/google/protobuf/ByteString;->toByteArray()[B
    :try_end_0
    .catch Ljava/lang/InterruptedException; {:try_start_0 .. :try_end_0} :catch_0

    move-result-object v0

    .line 81
    :goto_0
    return-object v0

    .line 77
    :catch_0
    move-exception v0

    .line 79
    invoke-virtual {v0}, Ljava/lang/InterruptedException;->printStackTrace()V

    .line 81
    const/4 v0, 0x0

    goto :goto_0
.end method

.method public static a([B)[B
    .locals 4

    .prologue
    const/4 v1, 0x0

    .line 23
    new-instance v0, Ljava/lang/StringBuilder;

    invoke-direct {v0}, Ljava/lang/StringBuilder;-><init>()V

    const-string v2, "size of message: "

    invoke-virtual {v0, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    array-length v2, p0

    invoke-virtual {v0, v2}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-virtual {v0}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v0

    sget-object v2, Lcom/cyjh/event/b;->a:Ljava/lang/Class;

    invoke-static {v0, v2}, Lcom/cyjh/mobileanjian/ipc/engine/utils/CLog;->i(Ljava/lang/String;Ljava/lang/Class;)V

    .line 24
    sput-object v1, Lcom/cyjh/event/b;->c:Lcom/google/protobuf/ByteString;

    .line 25
    const/4 v0, 0x1

    sput-boolean v0, Lcom/cyjh/event/b;->b:Z

    .line 26
    invoke-static {p0}, Lcom/google/protobuf/ByteString;->copyFrom([B)Lcom/google/protobuf/ByteString;

    move-result-object v0

    .line 27
    invoke-static {}, Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$IpcMessage;->newBuilder()Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$IpcMessage$Builder;

    move-result-object v2

    const/16 v3, 0x40

    .line 28
    invoke-virtual {v2, v3}, Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$IpcMessage$Builder;->setCmd(I)Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$IpcMessage$Builder;

    move-result-object v2

    .line 29
    invoke-virtual {v2, v0}, Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$IpcMessage$Builder;->setFileData(Lcom/google/protobuf/ByteString;)Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$IpcMessage$Builder;

    move-result-object v0

    .line 30
    invoke-virtual {v0}, Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$IpcMessage$Builder;->build()Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$IpcMessage;

    move-result-object v0

    .line 31
    invoke-static {}, Lcom/cyjh/mobileanjian/ipc/ClientService;->a()Lcom/cyjh/mobileanjian/ipc/b/b;

    move-result-object v2

    invoke-virtual {v2, v0}, Lcom/cyjh/mobileanjian/ipc/b/b;->a(Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$IpcMessage;)V

    .line 35
    :try_start_0
    sget-object v0, Lcom/cyjh/event/b;->d:Ljava/util/concurrent/ArrayBlockingQueue;

    invoke-virtual {v0}, Ljava/util/concurrent/ArrayBlockingQueue;->take()Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Lcom/google/protobuf/ByteString;

    invoke-virtual {v0}, Lcom/google/protobuf/ByteString;->toByteArray()[B
    :try_end_0
    .catch Ljava/lang/InterruptedException; {:try_start_0 .. :try_end_0} :catch_0

    move-result-object v0

    .line 40
    :goto_0
    return-object v0

    .line 36
    :catch_0
    move-exception v0

    .line 38
    invoke-virtual {v0}, Ljava/lang/InterruptedException;->printStackTrace()V

    move-object v0, v1

    .line 40
    goto :goto_0
.end method

.method public static b()V
    .locals 1

    .prologue
    .line 97
    sget-object v0, Lcom/cyjh/event/b;->e:Ljava/util/concurrent/ArrayBlockingQueue;

    invoke-virtual {v0}, Ljava/util/concurrent/ArrayBlockingQueue;->clear()V

    .line 98
    return-void
.end method

.method public static b(Lcom/google/protobuf/ByteString;)V
    .locals 1

    .prologue
    .line 88
    :try_start_0
    sget-object v0, Lcom/cyjh/event/b;->e:Ljava/util/concurrent/ArrayBlockingQueue;

    invoke-virtual {v0, p0}, Ljava/util/concurrent/ArrayBlockingQueue;->put(Ljava/lang/Object;)V
    :try_end_0
    .catch Ljava/lang/InterruptedException; {:try_start_0 .. :try_end_0} :catch_0

    .line 93
    :goto_0
    return-void

    .line 89
    :catch_0
    move-exception v0

    .line 91
    invoke-virtual {v0}, Ljava/lang/InterruptedException;->printStackTrace()V

    goto :goto_0
.end method
