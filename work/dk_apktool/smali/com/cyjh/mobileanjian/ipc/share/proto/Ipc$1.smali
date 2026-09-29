.class final Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$1;
.super Ljava/lang/Object;
.source "SourceFile"

# interfaces
.implements Lcom/google/protobuf/Descriptors$FileDescriptor$InternalDescriptorAssigner;


# annotations
.annotation system Ldalvik/annotation/EnclosingClass;
    value = Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc;
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x8
    name = null
.end annotation


# direct methods
.method constructor <init>()V
    .locals 0

    .prologue
    .line 4342
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method


# virtual methods
.method public assignDescriptors(Lcom/google/protobuf/Descriptors$FileDescriptor;)Lcom/google/protobuf/ExtensionRegistry;
    .locals 10

    .prologue
    const/4 v9, 0x4

    const/4 v8, 0x3

    const/4 v7, 0x2

    const/4 v6, 0x1

    const/4 v5, 0x0

    .line 4345
    invoke-static {p1}, Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc;->access$4902(Lcom/google/protobuf/Descriptors$FileDescriptor;)Lcom/google/protobuf/Descriptors$FileDescriptor;

    .line 4347
    invoke-static {}, Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc;->getDescriptor()Lcom/google/protobuf/Descriptors$FileDescriptor;

    move-result-object v0

    invoke-virtual {v0}, Lcom/google/protobuf/Descriptors$FileDescriptor;->getMessageTypes()Ljava/util/List;

    move-result-object v0

    invoke-interface {v0, v5}, Ljava/util/List;->get(I)Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Lcom/google/protobuf/Descriptors$Descriptor;

    .line 4346
    invoke-static {v0}, Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc;->access$002(Lcom/google/protobuf/Descriptors$Descriptor;)Lcom/google/protobuf/Descriptors$Descriptor;

    .line 4348
    new-instance v0, Lcom/google/protobuf/GeneratedMessage$FieldAccessorTable;

    .line 4350
    invoke-static {}, Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc;->access$000()Lcom/google/protobuf/Descriptors$Descriptor;

    move-result-object v1

    new-array v2, v7, [Ljava/lang/String;

    const-string v3, "Imei"

    aput-object v3, v2, v5

    const-string v3, "Mac"

    aput-object v3, v2, v6

    invoke-direct {v0, v1, v2}, Lcom/google/protobuf/GeneratedMessage$FieldAccessorTable;-><init>(Lcom/google/protobuf/Descriptors$Descriptor;[Ljava/lang/String;)V

    .line 4348
    invoke-static {v0}, Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc;->access$102(Lcom/google/protobuf/GeneratedMessage$FieldAccessorTable;)Lcom/google/protobuf/GeneratedMessage$FieldAccessorTable;

    .line 4353
    invoke-static {}, Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc;->getDescriptor()Lcom/google/protobuf/Descriptors$FileDescriptor;

    move-result-object v0

    invoke-virtual {v0}, Lcom/google/protobuf/Descriptors$FileDescriptor;->getMessageTypes()Ljava/util/List;

    move-result-object v0

    invoke-interface {v0, v6}, Ljava/util/List;->get(I)Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Lcom/google/protobuf/Descriptors$Descriptor;

    .line 4352
    invoke-static {v0}, Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc;->access$1002(Lcom/google/protobuf/Descriptors$Descriptor;)Lcom/google/protobuf/Descriptors$Descriptor;

    .line 4354
    new-instance v0, Lcom/google/protobuf/GeneratedMessage$FieldAccessorTable;

    .line 4356
    invoke-static {}, Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc;->access$1000()Lcom/google/protobuf/Descriptors$Descriptor;

    move-result-object v1

    const/4 v2, 0x7

    new-array v2, v2, [Ljava/lang/String;

    const-string v3, "Type"

    aput-object v3, v2, v5

    const-string v3, "ValBoolean"

    aput-object v3, v2, v6

    const-string v3, "ValInt"

    aput-object v3, v2, v7

    const-string v3, "ValLong"

    aput-object v3, v2, v8

    const-string v3, "ValFloat"

    aput-object v3, v2, v9

    const/4 v3, 0x5

    const-string v4, "ValDouble"

    aput-object v4, v2, v3

    const/4 v3, 0x6

    const-string v4, "ValString"

    aput-object v4, v2, v3

    invoke-direct {v0, v1, v2}, Lcom/google/protobuf/GeneratedMessage$FieldAccessorTable;-><init>(Lcom/google/protobuf/Descriptors$Descriptor;[Ljava/lang/String;)V

    .line 4354
    invoke-static {v0}, Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc;->access$1102(Lcom/google/protobuf/GeneratedMessage$FieldAccessorTable;)Lcom/google/protobuf/GeneratedMessage$FieldAccessorTable;

    .line 4359
    invoke-static {}, Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc;->getDescriptor()Lcom/google/protobuf/Descriptors$FileDescriptor;

    move-result-object v0

    invoke-virtual {v0}, Lcom/google/protobuf/Descriptors$FileDescriptor;->getMessageTypes()Ljava/util/List;

    move-result-object v0

    invoke-interface {v0, v7}, Ljava/util/List;->get(I)Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Lcom/google/protobuf/Descriptors$Descriptor;

    .line 4358
    invoke-static {v0}, Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc;->access$2502(Lcom/google/protobuf/Descriptors$Descriptor;)Lcom/google/protobuf/Descriptors$Descriptor;

    .line 4360
    new-instance v0, Lcom/google/protobuf/GeneratedMessage$FieldAccessorTable;

    .line 4362
    invoke-static {}, Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc;->access$2500()Lcom/google/protobuf/Descriptors$Descriptor;

    move-result-object v1

    const/16 v2, 0x10

    new-array v2, v2, [Ljava/lang/String;

    const-string v3, "Cmd"

    aput-object v3, v2, v5

    const-string v3, "Arg1"

    aput-object v3, v2, v6

    const-string v3, "Arg2"

    aput-object v3, v2, v7

    const-string v3, "Arg3"

    aput-object v3, v2, v8

    const-string v3, "FileData"

    aput-object v3, v2, v9

    const/4 v3, 0x5

    const-string v4, "Arg4"

    aput-object v4, v2, v3

    const/4 v3, 0x6

    const-string v4, "PkgName"

    aput-object v4, v2, v3

    const/4 v3, 0x7

    const-string v4, "ClassName"

    aput-object v4, v2, v3

    const/16 v3, 0x8

    const-string v4, "MethodName"

    aput-object v4, v2, v3

    const/16 v3, 0x9

    const-string v4, "Types"

    aput-object v4, v2, v3

    const/16 v3, 0xa

    const-string v4, "Params"

    aput-object v4, v2, v3

    const/16 v3, 0xb

    const-string v4, "IsSyncCall"

    aput-object v4, v2, v3

    const/16 v3, 0xc

    const-string v4, "WaitId"

    aput-object v4, v2, v3

    const/16 v3, 0xd

    const-string v4, "RetValue"

    aput-object v4, v2, v3

    const/16 v3, 0xe

    const-string v4, "Encrypt"

    aput-object v4, v2, v3

    const/16 v3, 0xf

    const-string v4, "IsDebug"

    aput-object v4, v2, v3

    invoke-direct {v0, v1, v2}, Lcom/google/protobuf/GeneratedMessage$FieldAccessorTable;-><init>(Lcom/google/protobuf/Descriptors$Descriptor;[Ljava/lang/String;)V

    .line 4360
    invoke-static {v0}, Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc;->access$2602(Lcom/google/protobuf/GeneratedMessage$FieldAccessorTable;)Lcom/google/protobuf/GeneratedMessage$FieldAccessorTable;

    .line 4364
    const/4 v0, 0x0

    return-object v0
.end method
