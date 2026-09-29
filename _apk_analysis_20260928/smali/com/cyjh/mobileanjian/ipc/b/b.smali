.class public Lcom/cyjh/mobileanjian/ipc/b/b;
.super Lcom/cyjh/mobileanjian/ipc/b/a;
.source "SourceFile"


# static fields
.field private static final a:Ljava/lang/Class;


# instance fields
.field private b:Z


# direct methods
.method static constructor <clinit>()V
    .locals 1

    .prologue
    .line 15
    const-class v0, Lcom/cyjh/mobileanjian/ipc/b/a;

    sput-object v0, Lcom/cyjh/mobileanjian/ipc/b/b;->a:Ljava/lang/Class;

    return-void
.end method

.method public constructor <init>(Landroid/net/LocalSocket;)V
    .locals 1

    .prologue
    .line 24
    invoke-direct {p0, p1}, Lcom/cyjh/mobileanjian/ipc/b/a;-><init>(Landroid/net/LocalSocket;)V

    .line 16
    const/4 v0, 0x1

    iput-boolean v0, p0, Lcom/cyjh/mobileanjian/ipc/b/b;->b:Z

    .line 25
    return-void
.end method

.method public constructor <init>(Ljava/net/Socket;)V
    .locals 1

    .prologue
    .line 19
    invoke-direct {p0, p1}, Lcom/cyjh/mobileanjian/ipc/b/a;-><init>(Ljava/net/Socket;)V

    .line 16
    const/4 v0, 0x1

    iput-boolean v0, p0, Lcom/cyjh/mobileanjian/ipc/b/b;->b:Z

    .line 20
    return-void
.end method

.method private d()I
    .locals 2

    .prologue
    .line 29
    const/4 v0, 0x4

    new-array v0, v0, [B

    .line 30
    invoke-virtual {p0, v0}, Lcom/cyjh/mobileanjian/ipc/b/b;->b([B)I

    move-result v1

    if-gez v1, :cond_0

    .line 31
    const/4 v0, -0x1

    .line 32
    :goto_0
    return v0

    :cond_0
    invoke-static {v0}, Ljava/nio/ByteBuffer;->wrap([B)Ljava/nio/ByteBuffer;

    move-result-object v0

    invoke-virtual {v0}, Ljava/nio/ByteBuffer;->getInt()I

    move-result v0

    goto :goto_0
.end method

.method private e()Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$IpcMessage;
    .locals 3

    .prologue
    const/4 v0, 0x0

    .line 37
    .line 38
    invoke-direct {p0}, Lcom/cyjh/mobileanjian/ipc/b/b;->d()I

    move-result v1

    .line 39
    if-gez v1, :cond_0

    .line 41
    invoke-virtual {p0}, Lcom/cyjh/mobileanjian/ipc/b/b;->a()V

    .line 59
    :goto_0
    return-object v0

    .line 45
    :cond_0
    new-array v1, v1, [B

    .line 46
    invoke-virtual {p0, v1}, Lcom/cyjh/mobileanjian/ipc/b/b;->b([B)I

    move-result v2

    if-gez v2, :cond_1

    .line 48
    invoke-virtual {p0}, Lcom/cyjh/mobileanjian/ipc/b/b;->a()V

    goto :goto_0

    .line 54
    :cond_1
    :try_start_0
    invoke-static {v1}, Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$IpcMessage;->parseFrom([B)Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$IpcMessage;
    :try_end_0
    .catch Lcom/google/protobuf/InvalidProtocolBufferException; {:try_start_0 .. :try_end_0} :catch_0

    move-result-object v0

    goto :goto_0

    .line 55
    :catch_0
    move-exception v1

    .line 57
    invoke-virtual {v1}, Lcom/google/protobuf/InvalidProtocolBufferException;->printStackTrace()V

    goto :goto_0
.end method


# virtual methods
.method public a()V
    .locals 1

    .prologue
    .line 92
    invoke-super {p0}, Lcom/cyjh/mobileanjian/ipc/b/a;->a()V

    .line 93
    const/4 v0, 0x0

    iput-boolean v0, p0, Lcom/cyjh/mobileanjian/ipc/b/b;->b:Z

    .line 94
    return-void
.end method

.method public declared-synchronized a(Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$IpcMessage;)V
    .locals 1

    .prologue
    .line 68
    monitor-enter p0

    :try_start_0
    new-instance v0, Lcom/cyjh/mobileanjian/ipc/share/proto/c;

    invoke-direct {v0, p1}, Lcom/cyjh/mobileanjian/ipc/share/proto/c;-><init>(Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$IpcMessage;)V

    .line 69
    invoke-virtual {v0}, Lcom/cyjh/mobileanjian/ipc/share/proto/c;->b()Ljava/nio/ByteBuffer;

    move-result-object v0

    invoke-virtual {p0, v0}, Lcom/cyjh/mobileanjian/ipc/b/b;->a(Ljava/nio/ByteBuffer;)V
    :try_end_0
    .catchall {:try_start_0 .. :try_end_0} :catchall_0

    .line 70
    monitor-exit p0

    return-void

    .line 68
    :catchall_0
    move-exception v0

    monitor-exit p0

    throw v0
.end method

.method public b()V
    .locals 2

    .prologue
    .line 77
    new-instance v0, Lcom/cyjh/mobileanjian/ipc/a/b;

    invoke-direct {v0, p0}, Lcom/cyjh/mobileanjian/ipc/a/b;-><init>(Lcom/cyjh/mobileanjian/ipc/b/b;)V

    .line 78
    :goto_0
    invoke-virtual {p0}, Lcom/cyjh/mobileanjian/ipc/b/b;->c()Z

    move-result v1

    if-eqz v1, :cond_0

    .line 80
    invoke-direct {p0}, Lcom/cyjh/mobileanjian/ipc/b/b;->e()Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$IpcMessage;

    move-result-object v1

    .line 81
    invoke-virtual {v0, v1}, Lcom/cyjh/mobileanjian/ipc/a/b;->a(Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$IpcMessage;)V

    goto :goto_0

    .line 83
    :cond_0
    invoke-virtual {v0}, Lcom/cyjh/mobileanjian/ipc/a/b;->a()V

    .line 84
    return-void
.end method

.method public c()Z
    .locals 1

    .prologue
    .line 98
    iget-boolean v0, p0, Lcom/cyjh/mobileanjian/ipc/b/b;->b:Z

    return v0
.end method
