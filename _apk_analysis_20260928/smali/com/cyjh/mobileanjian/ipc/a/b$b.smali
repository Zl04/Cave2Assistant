.class Lcom/cyjh/mobileanjian/ipc/a/b$b;
.super Ljava/lang/Thread;
.source "SourceFile"


# annotations
.annotation system Ldalvik/annotation/EnclosingClass;
    value = Lcom/cyjh/mobileanjian/ipc/a/b;
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x2
    name = "b"
.end annotation


# instance fields
.field final synthetic a:Lcom/cyjh/mobileanjian/ipc/a/b;

.field private b:I


# direct methods
.method public constructor <init>(Lcom/cyjh/mobileanjian/ipc/a/b;I)V
    .locals 0

    .prologue
    .line 347
    iput-object p1, p0, Lcom/cyjh/mobileanjian/ipc/a/b$b;->a:Lcom/cyjh/mobileanjian/ipc/a/b;

    invoke-direct {p0}, Ljava/lang/Thread;-><init>()V

    .line 348
    iput p2, p0, Lcom/cyjh/mobileanjian/ipc/a/b$b;->b:I

    .line 349
    return-void
.end method


# virtual methods
.method public run()V
    .locals 7

    .prologue
    const/4 v2, 0x0

    .line 353
    iget v0, p0, Lcom/cyjh/mobileanjian/ipc/a/b$b;->b:I

    const/4 v1, 0x2

    filled-new-array {v0, v1}, [I

    move-result-object v0

    sget-object v1, Ljava/lang/Integer;->TYPE:Ljava/lang/Class;

    invoke-static {v1, v0}, Ljava/lang/reflect/Array;->newInstance(Ljava/lang/Class;[I)Ljava/lang/Object;

    move-result-object v0

    check-cast v0, [[I

    .line 354
    iget v1, p0, Lcom/cyjh/mobileanjian/ipc/a/b$b;->b:I

    new-array v3, v1, [Lcom/google/protobuf/ByteString;

    move v1, v2

    .line 356
    :goto_0
    iget v4, p0, Lcom/cyjh/mobileanjian/ipc/a/b$b;->b:I

    if-ge v1, v4, :cond_0

    .line 358
    iget-object v4, p0, Lcom/cyjh/mobileanjian/ipc/a/b$b;->a:Lcom/cyjh/mobileanjian/ipc/a/b;

    invoke-static {v4}, Lcom/cyjh/mobileanjian/ipc/a/b;->a(Lcom/cyjh/mobileanjian/ipc/a/b;)Lcom/cyjh/mqm/MQLanguageStub$MQAuxiliary;

    move-result-object v4

    aget-object v5, v0, v1

    invoke-virtual {v4, v5}, Lcom/cyjh/mqm/MQLanguageStub$MQAuxiliary;->ScreenCap([I)[B

    move-result-object v4

    invoke-static {v4}, Lcom/google/protobuf/ByteString;->copyFrom([B)Lcom/google/protobuf/ByteString;

    move-result-object v4

    aput-object v4, v3, v1

    .line 356
    add-int/lit8 v1, v1, 0x1

    goto :goto_0

    :cond_0
    move v1, v2

    .line 361
    :goto_1
    iget v4, p0, Lcom/cyjh/mobileanjian/ipc/a/b$b;->b:I

    if-ge v1, v4, :cond_1

    .line 362
    invoke-static {}, Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$IpcMessage;->newBuilder()Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$IpcMessage$Builder;

    move-result-object v4

    const/16 v5, 0x19

    .line 363
    invoke-virtual {v4, v5}, Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$IpcMessage$Builder;->setCmd(I)Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$IpcMessage$Builder;

    move-result-object v4

    aget-object v5, v0, v1

    aget v5, v5, v2

    .line 364
    invoke-virtual {v4, v5}, Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$IpcMessage$Builder;->addArg1(I)Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$IpcMessage$Builder;

    move-result-object v4

    aget-object v5, v0, v1

    const/4 v6, 0x1

    aget v5, v5, v6

    .line 365
    invoke-virtual {v4, v5}, Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$IpcMessage$Builder;->addArg1(I)Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$IpcMessage$Builder;

    move-result-object v4

    iget v5, p0, Lcom/cyjh/mobileanjian/ipc/a/b$b;->b:I

    sub-int/2addr v5, v1

    add-int/lit8 v5, v5, -0x1

    .line 366
    invoke-virtual {v4, v5}, Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$IpcMessage$Builder;->addArg1(I)Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$IpcMessage$Builder;

    move-result-object v4

    aget-object v5, v3, v1

    .line 367
    invoke-virtual {v4, v5}, Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$IpcMessage$Builder;->setFileData(Lcom/google/protobuf/ByteString;)Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$IpcMessage$Builder;

    move-result-object v4

    .line 368
    invoke-virtual {v4}, Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$IpcMessage$Builder;->build()Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$IpcMessage;

    move-result-object v4

    .line 369
    iget-object v5, p0, Lcom/cyjh/mobileanjian/ipc/a/b$b;->a:Lcom/cyjh/mobileanjian/ipc/a/b;

    invoke-static {v5}, Lcom/cyjh/mobileanjian/ipc/a/b;->b(Lcom/cyjh/mobileanjian/ipc/a/b;)Lcom/cyjh/mobileanjian/ipc/b/b;

    move-result-object v5

    invoke-virtual {v5, v4}, Lcom/cyjh/mobileanjian/ipc/b/b;->a(Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$IpcMessage;)V

    .line 361
    add-int/lit8 v1, v1, 0x1

    goto :goto_1

    .line 371
    :cond_1
    return-void
.end method
