.class public final Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc;
.super Ljava/lang/Object;
.source "SourceFile"


# annotations
.annotation system Ldalvik/annotation/MemberClasses;
    value = {
        Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$IpcMessage;,
        Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$IpcMessageOrBuilder;,
        Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$ReturnValue;,
        Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$ReturnValueOrBuilder;,
        Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$Device;,
        Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$DeviceOrBuilder;,
        Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$FundType;
    }
.end annotation


# static fields
.field private static descriptor:Lcom/google/protobuf/Descriptors$FileDescriptor;

.field private static internal_static_JCPattern_Device_descriptor:Lcom/google/protobuf/Descriptors$Descriptor;

.field private static internal_static_JCPattern_Device_fieldAccessorTable:Lcom/google/protobuf/GeneratedMessage$FieldAccessorTable;

.field private static internal_static_JCPattern_IpcMessage_descriptor:Lcom/google/protobuf/Descriptors$Descriptor;

.field private static internal_static_JCPattern_IpcMessage_fieldAccessorTable:Lcom/google/protobuf/GeneratedMessage$FieldAccessorTable;

.field private static internal_static_JCPattern_ReturnValue_descriptor:Lcom/google/protobuf/Descriptors$Descriptor;

.field private static internal_static_JCPattern_ReturnValue_fieldAccessorTable:Lcom/google/protobuf/GeneratedMessage$FieldAccessorTable;


# direct methods
.method static constructor <clinit>()V
    .locals 4

    .prologue
    const/4 v3, 0x0

    .line 4321
    const/4 v0, 0x2

    new-array v0, v0, [Ljava/lang/String;

    const-string v1, "\n\tipc.proto\u0012\tJCPattern\"#\n\u0006Device\u0012\u000c\n\u0004imei\u0018\u0001 \u0001(\t\u0012\u000b\n\u0003mac\u0018\u0002 \u0001(\t\"\u00a3\u0001\n\u000bReturnValue\u0012\'\n\u0004type\u0018\u0001 \u0001(\u000e2\u0013.JCPattern.FundType:\u0004VOID\u0012\u0012\n\nvalBoolean\u0018\u0002 \u0001(\u0008\u0012\u000e\n\u0006valInt\u0018\u0003 \u0001(\u0005\u0012\u000f\n\u0007valLong\u0018\u0004 \u0001(\u0003\u0012\u0010\n\u0008valFloat\u0018\u0005 \u0001(\u0002\u0012\u0011\n\tvalDouble\u0018\u0006 \u0001(\u0001\u0012\u0011\n\tvalString\u0018\u0007 \u0001(\t\"\u00c5\u0002\n\nIpcMessage\u0012\u000e\n\u0003cmd\u0018\u0001 \u0001(\u0005:\u00010\u0012\u000c\n\u0004arg1\u0018\u0002 \u0003(\u0005\u0012\u000c\n\u0004arg2\u0018\u0003 \u0003(\t\u0012\u000c\n\u0004arg3\u0018\u0004 \u0003(\u0002\u0012\u0010\n\u0008fileData\u0018\u0005 \u0001(\u000c\u0012\u000c\n\u0004arg4\u0018\u0006 \u0003(\u0003\u0012\u000f\n\u0007pkgName\u0018\u0007 \u0001(\t\u0012\u0011\n\tclassName\u0018\u0008 \u0001(\t\u0012\u0012\n\nmethodName\u0018\t \u0001(\t\u0012\r\n\u0005types\u0018\n \u0003("

    aput-object v1, v0, v3

    const/4 v1, 0x1

    const-string v2, "\t\u0012\u000e\n\u0006params\u0018\u000b \u0003(\t\u0012\u0019\n\nisSyncCall\u0018\u000c \u0001(\u0008:\u0005false\u0012\u0011\n\u0006waitId\u0018\r \u0001(\u0005:\u00010\u0012(\n\u0008retValue\u0018\u000e \u0001(\u000b2\u0016.JCPattern.ReturnValue\u0012\u0016\n\u0007encrypt\u0018\u000f \u0001(\u0008:\u0005false\u0012\u0016\n\u0007isDebug\u0018\u0010 \u0001(\u0008:\u0005false*W\n\u0008FundType\u0012\u0008\n\u0004VOID\u0010\u0001\u0012\u000b\n\u0007BOOLEAN\u0010\u0002\u0012\u0007\n\u0003INT\u0010\u0003\u0012\u0008\n\u0004LONG\u0010\u0004\u0012\t\n\u0005FLOAT\u0010\u0005\u0012\n\n\u0006DOUBLE\u0010\u0006\u0012\n\n\u0006STRING\u0010\u0007B&\n\u001fcom.cyjh.mobileanjian.ipc.protoB\u0003Ipc"

    aput-object v2, v0, v1

    .line 4341
    new-instance v1, Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$1;

    invoke-direct {v1}, Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$1;-><init>()V

    .line 4367
    new-array v2, v3, [Lcom/google/protobuf/Descriptors$FileDescriptor;

    .line 4368
    invoke-static {v0, v2, v1}, Lcom/google/protobuf/Descriptors$FileDescriptor;->internalBuildGeneratedFileFrom([Ljava/lang/String;[Lcom/google/protobuf/Descriptors$FileDescriptor;Lcom/google/protobuf/Descriptors$FileDescriptor$InternalDescriptorAssigner;)V

    .line 4371
    return-void
.end method

.method private constructor <init>()V
    .locals 0

    .prologue
    .line 7
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method

.method static synthetic access$000()Lcom/google/protobuf/Descriptors$Descriptor;
    .locals 1

    .prologue
    .line 6
    sget-object v0, Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc;->internal_static_JCPattern_Device_descriptor:Lcom/google/protobuf/Descriptors$Descriptor;

    return-object v0
.end method

.method static synthetic access$002(Lcom/google/protobuf/Descriptors$Descriptor;)Lcom/google/protobuf/Descriptors$Descriptor;
    .locals 0

    .prologue
    .line 6
    sput-object p0, Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc;->internal_static_JCPattern_Device_descriptor:Lcom/google/protobuf/Descriptors$Descriptor;

    return-object p0
.end method

.method static synthetic access$100()Lcom/google/protobuf/GeneratedMessage$FieldAccessorTable;
    .locals 1

    .prologue
    .line 6
    sget-object v0, Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc;->internal_static_JCPattern_Device_fieldAccessorTable:Lcom/google/protobuf/GeneratedMessage$FieldAccessorTable;

    return-object v0
.end method

.method static synthetic access$1000()Lcom/google/protobuf/Descriptors$Descriptor;
    .locals 1

    .prologue
    .line 6
    sget-object v0, Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc;->internal_static_JCPattern_ReturnValue_descriptor:Lcom/google/protobuf/Descriptors$Descriptor;

    return-object v0
.end method

.method static synthetic access$1002(Lcom/google/protobuf/Descriptors$Descriptor;)Lcom/google/protobuf/Descriptors$Descriptor;
    .locals 0

    .prologue
    .line 6
    sput-object p0, Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc;->internal_static_JCPattern_ReturnValue_descriptor:Lcom/google/protobuf/Descriptors$Descriptor;

    return-object p0
.end method

.method static synthetic access$102(Lcom/google/protobuf/GeneratedMessage$FieldAccessorTable;)Lcom/google/protobuf/GeneratedMessage$FieldAccessorTable;
    .locals 0

    .prologue
    .line 6
    sput-object p0, Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc;->internal_static_JCPattern_Device_fieldAccessorTable:Lcom/google/protobuf/GeneratedMessage$FieldAccessorTable;

    return-object p0
.end method

.method static synthetic access$1100()Lcom/google/protobuf/GeneratedMessage$FieldAccessorTable;
    .locals 1

    .prologue
    .line 6
    sget-object v0, Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc;->internal_static_JCPattern_ReturnValue_fieldAccessorTable:Lcom/google/protobuf/GeneratedMessage$FieldAccessorTable;

    return-object v0
.end method

.method static synthetic access$1102(Lcom/google/protobuf/GeneratedMessage$FieldAccessorTable;)Lcom/google/protobuf/GeneratedMessage$FieldAccessorTable;
    .locals 0

    .prologue
    .line 6
    sput-object p0, Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc;->internal_static_JCPattern_ReturnValue_fieldAccessorTable:Lcom/google/protobuf/GeneratedMessage$FieldAccessorTable;

    return-object p0
.end method

.method static synthetic access$2500()Lcom/google/protobuf/Descriptors$Descriptor;
    .locals 1

    .prologue
    .line 6
    sget-object v0, Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc;->internal_static_JCPattern_IpcMessage_descriptor:Lcom/google/protobuf/Descriptors$Descriptor;

    return-object v0
.end method

.method static synthetic access$2502(Lcom/google/protobuf/Descriptors$Descriptor;)Lcom/google/protobuf/Descriptors$Descriptor;
    .locals 0

    .prologue
    .line 6
    sput-object p0, Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc;->internal_static_JCPattern_IpcMessage_descriptor:Lcom/google/protobuf/Descriptors$Descriptor;

    return-object p0
.end method

.method static synthetic access$2600()Lcom/google/protobuf/GeneratedMessage$FieldAccessorTable;
    .locals 1

    .prologue
    .line 6
    sget-object v0, Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc;->internal_static_JCPattern_IpcMessage_fieldAccessorTable:Lcom/google/protobuf/GeneratedMessage$FieldAccessorTable;

    return-object v0
.end method

.method static synthetic access$2602(Lcom/google/protobuf/GeneratedMessage$FieldAccessorTable;)Lcom/google/protobuf/GeneratedMessage$FieldAccessorTable;
    .locals 0

    .prologue
    .line 6
    sput-object p0, Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc;->internal_static_JCPattern_IpcMessage_fieldAccessorTable:Lcom/google/protobuf/GeneratedMessage$FieldAccessorTable;

    return-object p0
.end method

.method static synthetic access$4902(Lcom/google/protobuf/Descriptors$FileDescriptor;)Lcom/google/protobuf/Descriptors$FileDescriptor;
    .locals 0

    .prologue
    .line 6
    sput-object p0, Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc;->descriptor:Lcom/google/protobuf/Descriptors$FileDescriptor;

    return-object p0
.end method

.method public static getDescriptor()Lcom/google/protobuf/Descriptors$FileDescriptor;
    .locals 1

    .prologue
    .line 4316
    sget-object v0, Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc;->descriptor:Lcom/google/protobuf/Descriptors$FileDescriptor;

    return-object v0
.end method

.method public static registerAllExtensions(Lcom/google/protobuf/ExtensionRegistry;)V
    .locals 0

    .prologue
    .line 10
    return-void
.end method
