.class public Lcom/cyjh/event/a;
.super Ljava/lang/Object;
.source "SourceFile"


# static fields
.field private static final a:Ljava/lang/Class;

.field private static b:Z

.field private static c:Lcom/google/protobuf/ByteString;


# direct methods
.method static constructor <clinit>()V
    .locals 1

    .prologue
    .line 12
    const-class v0, Lcom/cyjh/event/a;

    sput-object v0, Lcom/cyjh/event/a;->a:Ljava/lang/Class;

    .line 13
    const/4 v0, 0x0

    sput-boolean v0, Lcom/cyjh/event/a;->b:Z

    .line 14
    const/4 v0, 0x0

    sput-object v0, Lcom/cyjh/event/a;->c:Lcom/google/protobuf/ByteString;

    return-void
.end method

.method public constructor <init>()V
    .locals 0

    .prologue
    .line 10
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method

.method public static a(Lcom/google/protobuf/ByteString;)V
    .locals 1

    .prologue
    .line 42
    sput-object p0, Lcom/cyjh/event/a;->c:Lcom/google/protobuf/ByteString;

    .line 43
    const/4 v0, 0x0

    sput-boolean v0, Lcom/cyjh/event/a;->b:Z

    .line 44
    return-void
.end method

.method public static a([B)[B
    .locals 4

    .prologue
    const/4 v0, 0x0

    .line 17
    new-instance v1, Ljava/lang/StringBuilder;

    invoke-direct {v1}, Ljava/lang/StringBuilder;-><init>()V

    const-string v2, "deubg message: "

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    array-length v2, p0

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v1

    sget-object v2, Lcom/cyjh/event/a;->a:Ljava/lang/Class;

    invoke-static {v1, v2}, Lcom/cyjh/mobileanjian/ipc/engine/utils/CLog;->i(Ljava/lang/String;Ljava/lang/Class;)V

    .line 18
    sput-object v0, Lcom/cyjh/event/a;->c:Lcom/google/protobuf/ByteString;

    .line 19
    const/4 v1, 0x1

    sput-boolean v1, Lcom/cyjh/event/a;->b:Z

    .line 20
    invoke-static {p0}, Lcom/google/protobuf/ByteString;->copyFrom([B)Lcom/google/protobuf/ByteString;

    move-result-object v1

    .line 21
    invoke-static {}, Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$IpcMessage;->newBuilder()Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$IpcMessage$Builder;

    move-result-object v2

    const/16 v3, 0x101

    .line 22
    invoke-virtual {v2, v3}, Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$IpcMessage$Builder;->setCmd(I)Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$IpcMessage$Builder;

    move-result-object v2

    .line 23
    invoke-virtual {v2, v1}, Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$IpcMessage$Builder;->setFileData(Lcom/google/protobuf/ByteString;)Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$IpcMessage$Builder;

    move-result-object v1

    .line 24
    invoke-virtual {v1}, Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$IpcMessage$Builder;->build()Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$IpcMessage;

    move-result-object v1

    .line 25
    invoke-static {}, Lcom/cyjh/mobileanjian/ipc/ClientService;->a()Lcom/cyjh/mobileanjian/ipc/b/b;

    move-result-object v2

    invoke-virtual {v2, v1}, Lcom/cyjh/mobileanjian/ipc/b/b;->a(Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$IpcMessage;)V

    .line 26
    :goto_0
    invoke-static {}, Lcom/cyjh/mobileanjian/ipc/a/a;->x()Z

    move-result v1

    if-eqz v1, :cond_0

    sget-boolean v1, Lcom/cyjh/event/a;->b:Z

    if-eqz v1, :cond_0

    .line 30
    const-wide/16 v2, 0xa

    :try_start_0
    invoke-static {v2, v3}, Ljava/lang/Thread;->sleep(J)V
    :try_end_0
    .catch Ljava/lang/InterruptedException; {:try_start_0 .. :try_end_0} :catch_0

    goto :goto_0

    .line 32
    :catch_0
    move-exception v1

    .line 34
    invoke-virtual {v1}, Ljava/lang/InterruptedException;->printStackTrace()V

    goto :goto_0

    .line 37
    :cond_0
    sget-object v1, Lcom/cyjh/event/a;->c:Lcom/google/protobuf/ByteString;

    if-nez v1, :cond_1

    :goto_1
    return-object v0

    :cond_1
    sget-object v0, Lcom/cyjh/event/a;->c:Lcom/google/protobuf/ByteString;

    invoke-virtual {v0}, Lcom/google/protobuf/ByteString;->toByteArray()[B

    move-result-object v0

    goto :goto_1
.end method
