.class public final Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$ControlVar;
.super Lcom/google/protobuf/GeneratedMessage;
.source "SourceFile"

# interfaces
.implements Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$ControlVarOrBuilder;


# annotations
.annotation system Ldalvik/annotation/EnclosingClass;
    value = Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage;
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x19
    name = "ControlVar"
.end annotation

.annotation system Ldalvik/annotation/MemberClasses;
    value = {
        Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$ControlVar$Builder;,
        Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$ControlVar$Data_Type;
    }
.end annotation


# static fields
.field public static final BOOL_VALUE_FIELD_NUMBER:I = 0x3

.field public static final CONTROL_ID_FIELD_NUMBER:I = 0x1

.field public static final INT_VALUE_FIELD_NUMBER:I = 0x4

.field public static PARSER:Lcom/google/protobuf/Parser; = null
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "Lcom/google/protobuf/Parser",
            "<",
            "Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$ControlVar;",
            ">;"
        }
    .end annotation
.end field

.field public static final STRING_VALUE_FIELD_NUMBER:I = 0x5

.field public static final TYPE_FIELD_NUMBER:I = 0x2

.field private static final defaultInstance:Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$ControlVar;

.field private static final serialVersionUID:J


# instance fields
.field private bitField0_:I

.field private boolValue_:Z

.field private controlId_:Ljava/lang/Object;

.field private intValue_:I

.field private memoizedIsInitialized:B

.field private memoizedSerializedSize:I

.field private stringValue_:Ljava/lang/Object;

.field private type_:Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$ControlVar$Data_Type;

.field private final unknownFields:Lcom/google/protobuf/UnknownFieldSet;


# direct methods
.method static constructor <clinit>()V
    .locals 2

    .prologue
    .line 5474
    new-instance v0, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$ControlVar$1;

    invoke-direct {v0}, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$ControlVar$1;-><init>()V

    sput-object v0, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$ControlVar;->PARSER:Lcom/google/protobuf/Parser;

    .line 6276
    new-instance v0, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$ControlVar;

    const/4 v1, 0x1

    invoke-direct {v0, v1}, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$ControlVar;-><init>(Z)V

    sput-object v0, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$ControlVar;->defaultInstance:Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$ControlVar;

    .line 6277
    sget-object v0, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$ControlVar;->defaultInstance:Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$ControlVar;

    invoke-direct {v0}, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$ControlVar;->initFields()V

    .line 6278
    return-void
.end method

.method private constructor <init>(Lcom/google/protobuf/CodedInputStream;Lcom/google/protobuf/ExtensionRegistryLite;)V
    .locals 5
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Lcom/google/protobuf/InvalidProtocolBufferException;
        }
    .end annotation

    .prologue
    const/4 v1, 0x1

    const/4 v0, -0x1

    .line 5399
    invoke-direct {p0}, Lcom/google/protobuf/GeneratedMessage;-><init>()V

    .line 5722
    iput-byte v0, p0, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$ControlVar;->memoizedIsInitialized:B

    .line 5756
    iput v0, p0, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$ControlVar;->memoizedSerializedSize:I

    .line 5400
    invoke-direct {p0}, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$ControlVar;->initFields()V

    .line 5403
    invoke-static {}, Lcom/google/protobuf/UnknownFieldSet;->newBuilder()Lcom/google/protobuf/UnknownFieldSet$Builder;

    move-result-object v2

    .line 5405
    const/4 v0, 0x0

    .line 5406
    :cond_0
    :goto_0
    if-nez v0, :cond_2

    .line 5407
    :try_start_0
    invoke-virtual {p1}, Lcom/google/protobuf/CodedInputStream;->readTag()I

    move-result v3

    .line 5408
    sparse-switch v3, :sswitch_data_0

    .line 5413
    invoke-virtual {p0, p1, v2, p2, v3}, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$ControlVar;->parseUnknownField(Lcom/google/protobuf/CodedInputStream;Lcom/google/protobuf/UnknownFieldSet$Builder;Lcom/google/protobuf/ExtensionRegistryLite;I)Z

    move-result v3

    if-nez v3, :cond_0

    move v0, v1

    .line 5415
    goto :goto_0

    :sswitch_0
    move v0, v1

    .line 5411
    goto :goto_0

    .line 5420
    :sswitch_1
    iget v3, p0, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$ControlVar;->bitField0_:I

    or-int/lit8 v3, v3, 0x1

    iput v3, p0, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$ControlVar;->bitField0_:I

    .line 5421
    invoke-virtual {p1}, Lcom/google/protobuf/CodedInputStream;->readBytes()Lcom/google/protobuf/ByteString;

    move-result-object v3

    iput-object v3, p0, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$ControlVar;->controlId_:Ljava/lang/Object;
    :try_end_0
    .catch Lcom/google/protobuf/InvalidProtocolBufferException; {:try_start_0 .. :try_end_0} :catch_0
    .catch Ljava/io/IOException; {:try_start_0 .. :try_end_0} :catch_1
    .catchall {:try_start_0 .. :try_end_0} :catchall_0

    goto :goto_0

    .line 5452
    :catch_0
    move-exception v0

    .line 5453
    :try_start_1
    invoke-virtual {v0, p0}, Lcom/google/protobuf/InvalidProtocolBufferException;->setUnfinishedMessage(Lcom/google/protobuf/MessageLite;)Lcom/google/protobuf/InvalidProtocolBufferException;

    move-result-object v0

    throw v0
    :try_end_1
    .catchall {:try_start_1 .. :try_end_1} :catchall_0

    .line 5458
    :catchall_0
    move-exception v0

    invoke-virtual {v2}, Lcom/google/protobuf/UnknownFieldSet$Builder;->build()Lcom/google/protobuf/UnknownFieldSet;

    move-result-object v1

    iput-object v1, p0, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$ControlVar;->unknownFields:Lcom/google/protobuf/UnknownFieldSet;

    .line 5459
    invoke-virtual {p0}, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$ControlVar;->makeExtensionsImmutable()V

    throw v0

    .line 5425
    :sswitch_2
    :try_start_2
    invoke-virtual {p1}, Lcom/google/protobuf/CodedInputStream;->readEnum()I

    move-result v3

    .line 5426
    invoke-static {v3}, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$ControlVar$Data_Type;->valueOf(I)Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$ControlVar$Data_Type;

    move-result-object v4

    .line 5427
    if-nez v4, :cond_1

    .line 5428
    const/4 v4, 0x2

    invoke-virtual {v2, v4, v3}, Lcom/google/protobuf/UnknownFieldSet$Builder;->mergeVarintField(II)Lcom/google/protobuf/UnknownFieldSet$Builder;
    :try_end_2
    .catch Lcom/google/protobuf/InvalidProtocolBufferException; {:try_start_2 .. :try_end_2} :catch_0
    .catch Ljava/io/IOException; {:try_start_2 .. :try_end_2} :catch_1
    .catchall {:try_start_2 .. :try_end_2} :catchall_0

    goto :goto_0

    .line 5454
    :catch_1
    move-exception v0

    .line 5455
    :try_start_3
    new-instance v1, Lcom/google/protobuf/InvalidProtocolBufferException;

    .line 5456
    invoke-virtual {v0}, Ljava/io/IOException;->getMessage()Ljava/lang/String;

    move-result-object v0

    invoke-direct {v1, v0}, Lcom/google/protobuf/InvalidProtocolBufferException;-><init>(Ljava/lang/String;)V

    invoke-virtual {v1, p0}, Lcom/google/protobuf/InvalidProtocolBufferException;->setUnfinishedMessage(Lcom/google/protobuf/MessageLite;)Lcom/google/protobuf/InvalidProtocolBufferException;

    move-result-object v0

    throw v0
    :try_end_3
    .catchall {:try_start_3 .. :try_end_3} :catchall_0

    .line 5430
    :cond_1
    :try_start_4
    iget v3, p0, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$ControlVar;->bitField0_:I

    or-int/lit8 v3, v3, 0x2

    iput v3, p0, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$ControlVar;->bitField0_:I

    .line 5431
    iput-object v4, p0, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$ControlVar;->type_:Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$ControlVar$Data_Type;

    goto :goto_0

    .line 5436
    :sswitch_3
    iget v3, p0, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$ControlVar;->bitField0_:I

    or-int/lit8 v3, v3, 0x4

    iput v3, p0, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$ControlVar;->bitField0_:I

    .line 5437
    invoke-virtual {p1}, Lcom/google/protobuf/CodedInputStream;->readBool()Z

    move-result v3

    iput-boolean v3, p0, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$ControlVar;->boolValue_:Z

    goto :goto_0

    .line 5441
    :sswitch_4
    iget v3, p0, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$ControlVar;->bitField0_:I

    or-int/lit8 v3, v3, 0x8

    iput v3, p0, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$ControlVar;->bitField0_:I

    .line 5442
    invoke-virtual {p1}, Lcom/google/protobuf/CodedInputStream;->readInt32()I

    move-result v3

    iput v3, p0, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$ControlVar;->intValue_:I

    goto :goto_0

    .line 5446
    :sswitch_5
    iget v3, p0, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$ControlVar;->bitField0_:I

    or-int/lit8 v3, v3, 0x10

    iput v3, p0, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$ControlVar;->bitField0_:I

    .line 5447
    invoke-virtual {p1}, Lcom/google/protobuf/CodedInputStream;->readBytes()Lcom/google/protobuf/ByteString;

    move-result-object v3

    iput-object v3, p0, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$ControlVar;->stringValue_:Ljava/lang/Object;
    :try_end_4
    .catch Lcom/google/protobuf/InvalidProtocolBufferException; {:try_start_4 .. :try_end_4} :catch_0
    .catch Ljava/io/IOException; {:try_start_4 .. :try_end_4} :catch_1
    .catchall {:try_start_4 .. :try_end_4} :catchall_0

    goto :goto_0

    .line 5458
    :cond_2
    invoke-virtual {v2}, Lcom/google/protobuf/UnknownFieldSet$Builder;->build()Lcom/google/protobuf/UnknownFieldSet;

    move-result-object v0

    iput-object v0, p0, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$ControlVar;->unknownFields:Lcom/google/protobuf/UnknownFieldSet;

    .line 5459
    invoke-virtual {p0}, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$ControlVar;->makeExtensionsImmutable()V

    .line 5461
    return-void

    .line 5408
    :sswitch_data_0
    .sparse-switch
        0x0 -> :sswitch_0
        0xa -> :sswitch_1
        0x10 -> :sswitch_2
        0x18 -> :sswitch_3
        0x20 -> :sswitch_4
        0x2a -> :sswitch_5
    .end sparse-switch
.end method

.method synthetic constructor <init>(Lcom/google/protobuf/CodedInputStream;Lcom/google/protobuf/ExtensionRegistryLite;Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$1;)V
    .locals 0
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Lcom/google/protobuf/InvalidProtocolBufferException;
        }
    .end annotation

    .prologue
    .line 5371
    invoke-direct {p0, p1, p2}, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$ControlVar;-><init>(Lcom/google/protobuf/CodedInputStream;Lcom/google/protobuf/ExtensionRegistryLite;)V

    return-void
.end method

.method private constructor <init>(Lcom/google/protobuf/GeneratedMessage$Builder;)V
    .locals 1
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "(",
            "Lcom/google/protobuf/GeneratedMessage$Builder",
            "<*>;)V"
        }
    .end annotation

    .prologue
    const/4 v0, -0x1

    .line 5376
    invoke-direct {p0, p1}, Lcom/google/protobuf/GeneratedMessage;-><init>(Lcom/google/protobuf/GeneratedMessage$Builder;)V

    .line 5722
    iput-byte v0, p0, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$ControlVar;->memoizedIsInitialized:B

    .line 5756
    iput v0, p0, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$ControlVar;->memoizedSerializedSize:I

    .line 5377
    invoke-virtual {p1}, Lcom/google/protobuf/GeneratedMessage$Builder;->getUnknownFields()Lcom/google/protobuf/UnknownFieldSet;

    move-result-object v0

    iput-object v0, p0, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$ControlVar;->unknownFields:Lcom/google/protobuf/UnknownFieldSet;

    .line 5378
    return-void
.end method

.method synthetic constructor <init>(Lcom/google/protobuf/GeneratedMessage$Builder;Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$1;)V
    .locals 0

    .prologue
    .line 5371
    invoke-direct {p0, p1}, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$ControlVar;-><init>(Lcom/google/protobuf/GeneratedMessage$Builder;)V

    return-void
.end method

.method private constructor <init>(Z)V
    .locals 1

    .prologue
    const/4 v0, -0x1

    .line 5379
    invoke-direct {p0}, Lcom/google/protobuf/GeneratedMessage;-><init>()V

    .line 5722
    iput-byte v0, p0, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$ControlVar;->memoizedIsInitialized:B

    .line 5756
    iput v0, p0, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$ControlVar;->memoizedSerializedSize:I

    .line 5379
    invoke-static {}, Lcom/google/protobuf/UnknownFieldSet;->getDefaultInstance()Lcom/google/protobuf/UnknownFieldSet;

    move-result-object v0

    iput-object v0, p0, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$ControlVar;->unknownFields:Lcom/google/protobuf/UnknownFieldSet;

    return-void
.end method

.method static synthetic access$5900()Z
    .locals 1

    .prologue
    .line 5371
    sget-boolean v0, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$ControlVar;->alwaysUseFieldBuilders:Z

    return v0
.end method

.method static synthetic access$6100(Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$ControlVar;)Ljava/lang/Object;
    .locals 1

    .prologue
    .line 5371
    iget-object v0, p0, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$ControlVar;->controlId_:Ljava/lang/Object;

    return-object v0
.end method

.method static synthetic access$6102(Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$ControlVar;Ljava/lang/Object;)Ljava/lang/Object;
    .locals 0

    .prologue
    .line 5371
    iput-object p1, p0, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$ControlVar;->controlId_:Ljava/lang/Object;

    return-object p1
.end method

.method static synthetic access$6202(Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$ControlVar;Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$ControlVar$Data_Type;)Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$ControlVar$Data_Type;
    .locals 0

    .prologue
    .line 5371
    iput-object p1, p0, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$ControlVar;->type_:Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$ControlVar$Data_Type;

    return-object p1
.end method

.method static synthetic access$6302(Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$ControlVar;Z)Z
    .locals 0

    .prologue
    .line 5371
    iput-boolean p1, p0, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$ControlVar;->boolValue_:Z

    return p1
.end method

.method static synthetic access$6402(Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$ControlVar;I)I
    .locals 0

    .prologue
    .line 5371
    iput p1, p0, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$ControlVar;->intValue_:I

    return p1
.end method

.method static synthetic access$6500(Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$ControlVar;)Ljava/lang/Object;
    .locals 1

    .prologue
    .line 5371
    iget-object v0, p0, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$ControlVar;->stringValue_:Ljava/lang/Object;

    return-object v0
.end method

.method static synthetic access$6502(Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$ControlVar;Ljava/lang/Object;)Ljava/lang/Object;
    .locals 0

    .prologue
    .line 5371
    iput-object p1, p0, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$ControlVar;->stringValue_:Ljava/lang/Object;

    return-object p1
.end method

.method static synthetic access$6602(Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$ControlVar;I)I
    .locals 0

    .prologue
    .line 5371
    iput p1, p0, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$ControlVar;->bitField0_:I

    return p1
.end method

.method public static getDefaultInstance()Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$ControlVar;
    .locals 1

    .prologue
    .line 5383
    sget-object v0, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$ControlVar;->defaultInstance:Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$ControlVar;

    return-object v0
.end method

.method public static final getDescriptor()Lcom/google/protobuf/Descriptors$Descriptor;
    .locals 1

    .prologue
    .line 5464
    invoke-static {}, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage;->h()Lcom/google/protobuf/Descriptors$Descriptor;

    move-result-object v0

    return-object v0
.end method

.method private initFields()V
    .locals 2

    .prologue
    const/4 v1, 0x0

    .line 5716
    const-string v0, ""

    iput-object v0, p0, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$ControlVar;->controlId_:Ljava/lang/Object;

    .line 5717
    sget-object v0, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$ControlVar$Data_Type;->BOOL:Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$ControlVar$Data_Type;

    iput-object v0, p0, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$ControlVar;->type_:Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$ControlVar$Data_Type;

    .line 5718
    iput-boolean v1, p0, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$ControlVar;->boolValue_:Z

    .line 5719
    iput v1, p0, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$ControlVar;->intValue_:I

    .line 5720
    const-string v0, ""

    iput-object v0, p0, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$ControlVar;->stringValue_:Ljava/lang/Object;

    .line 5721
    return-void
.end method

.method public static newBuilder()Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$ControlVar$Builder;
    .locals 1

    .prologue
    .line 5847
    invoke-static {}, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$ControlVar$Builder;->access$5700()Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$ControlVar$Builder;

    move-result-object v0

    return-object v0
.end method

.method public static newBuilder(Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$ControlVar;)Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$ControlVar$Builder;
    .locals 1

    .prologue
    .line 5850
    invoke-static {}, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$ControlVar;->newBuilder()Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$ControlVar$Builder;

    move-result-object v0

    invoke-virtual {v0, p0}, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$ControlVar$Builder;->mergeFrom(Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$ControlVar;)Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$ControlVar$Builder;

    move-result-object v0

    return-object v0
.end method

.method public static parseDelimitedFrom(Ljava/io/InputStream;)Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$ControlVar;
    .locals 1
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljava/io/IOException;
        }
    .end annotation

    .prologue
    .line 5827
    sget-object v0, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$ControlVar;->PARSER:Lcom/google/protobuf/Parser;

    invoke-interface {v0, p0}, Lcom/google/protobuf/Parser;->parseDelimitedFrom(Ljava/io/InputStream;)Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$ControlVar;

    return-object v0
.end method

.method public static parseDelimitedFrom(Ljava/io/InputStream;Lcom/google/protobuf/ExtensionRegistryLite;)Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$ControlVar;
    .locals 1
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljava/io/IOException;
        }
    .end annotation

    .prologue
    .line 5833
    sget-object v0, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$ControlVar;->PARSER:Lcom/google/protobuf/Parser;

    invoke-interface {v0, p0, p1}, Lcom/google/protobuf/Parser;->parseDelimitedFrom(Ljava/io/InputStream;Lcom/google/protobuf/ExtensionRegistryLite;)Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$ControlVar;

    return-object v0
.end method

.method public static parseFrom(Lcom/google/protobuf/ByteString;)Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$ControlVar;
    .locals 1
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Lcom/google/protobuf/InvalidProtocolBufferException;
        }
    .end annotation

    .prologue
    .line 5797
    sget-object v0, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$ControlVar;->PARSER:Lcom/google/protobuf/Parser;

    invoke-interface {v0, p0}, Lcom/google/protobuf/Parser;->parseFrom(Lcom/google/protobuf/ByteString;)Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$ControlVar;

    return-object v0
.end method

.method public static parseFrom(Lcom/google/protobuf/ByteString;Lcom/google/protobuf/ExtensionRegistryLite;)Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$ControlVar;
    .locals 1
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Lcom/google/protobuf/InvalidProtocolBufferException;
        }
    .end annotation

    .prologue
    .line 5803
    sget-object v0, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$ControlVar;->PARSER:Lcom/google/protobuf/Parser;

    invoke-interface {v0, p0, p1}, Lcom/google/protobuf/Parser;->parseFrom(Lcom/google/protobuf/ByteString;Lcom/google/protobuf/ExtensionRegistryLite;)Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$ControlVar;

    return-object v0
.end method

.method public static parseFrom(Lcom/google/protobuf/CodedInputStream;)Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$ControlVar;
    .locals 1
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljava/io/IOException;
        }
    .end annotation

    .prologue
    .line 5838
    sget-object v0, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$ControlVar;->PARSER:Lcom/google/protobuf/Parser;

    invoke-interface {v0, p0}, Lcom/google/protobuf/Parser;->parseFrom(Lcom/google/protobuf/CodedInputStream;)Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$ControlVar;

    return-object v0
.end method

.method public static parseFrom(Lcom/google/protobuf/CodedInputStream;Lcom/google/protobuf/ExtensionRegistryLite;)Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$ControlVar;
    .locals 1
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljava/io/IOException;
        }
    .end annotation

    .prologue
    .line 5844
    sget-object v0, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$ControlVar;->PARSER:Lcom/google/protobuf/Parser;

    invoke-interface {v0, p0, p1}, Lcom/google/protobuf/Parser;->parseFrom(Lcom/google/protobuf/CodedInputStream;Lcom/google/protobuf/ExtensionRegistryLite;)Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$ControlVar;

    return-object v0
.end method

.method public static parseFrom(Ljava/io/InputStream;)Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$ControlVar;
    .locals 1
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljava/io/IOException;
        }
    .end annotation

    .prologue
    .line 5817
    sget-object v0, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$ControlVar;->PARSER:Lcom/google/protobuf/Parser;

    invoke-interface {v0, p0}, Lcom/google/protobuf/Parser;->parseFrom(Ljava/io/InputStream;)Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$ControlVar;

    return-object v0
.end method

.method public static parseFrom(Ljava/io/InputStream;Lcom/google/protobuf/ExtensionRegistryLite;)Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$ControlVar;
    .locals 1
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljava/io/IOException;
        }
    .end annotation

    .prologue
    .line 5823
    sget-object v0, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$ControlVar;->PARSER:Lcom/google/protobuf/Parser;

    invoke-interface {v0, p0, p1}, Lcom/google/protobuf/Parser;->parseFrom(Ljava/io/InputStream;Lcom/google/protobuf/ExtensionRegistryLite;)Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$ControlVar;

    return-object v0
.end method

.method public static parseFrom([B)Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$ControlVar;
    .locals 1
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Lcom/google/protobuf/InvalidProtocolBufferException;
        }
    .end annotation

    .prologue
    .line 5807
    sget-object v0, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$ControlVar;->PARSER:Lcom/google/protobuf/Parser;

    invoke-interface {v0, p0}, Lcom/google/protobuf/Parser;->parseFrom([B)Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$ControlVar;

    return-object v0
.end method

.method public static parseFrom([BLcom/google/protobuf/ExtensionRegistryLite;)Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$ControlVar;
    .locals 1
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Lcom/google/protobuf/InvalidProtocolBufferException;
        }
    .end annotation

    .prologue
    .line 5813
    sget-object v0, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$ControlVar;->PARSER:Lcom/google/protobuf/Parser;

    invoke-interface {v0, p0, p1}, Lcom/google/protobuf/Parser;->parseFrom([BLcom/google/protobuf/ExtensionRegistryLite;)Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$ControlVar;

    return-object v0
.end method


# virtual methods
.method public getBoolValue()Z
    .locals 1

    .prologue
    .line 5653
    iget-boolean v0, p0, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$ControlVar;->boolValue_:Z

    return v0
.end method

.method public getControlId()Ljava/lang/String;
    .locals 2

    .prologue
    .line 5594
    iget-object v0, p0, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$ControlVar;->controlId_:Ljava/lang/Object;

    .line 5595
    instance-of v1, v0, Ljava/lang/String;

    if-eqz v1, :cond_0

    .line 5596
    check-cast v0, Ljava/lang/String;

    .line 5604
    :goto_0
    return-object v0

    .line 5598
    :cond_0
    check-cast v0, Lcom/google/protobuf/ByteString;

    .line 5600
    invoke-virtual {v0}, Lcom/google/protobuf/ByteString;->toStringUtf8()Ljava/lang/String;

    move-result-object v1

    .line 5601
    invoke-virtual {v0}, Lcom/google/protobuf/ByteString;->isValidUtf8()Z

    move-result v0

    if-eqz v0, :cond_1

    .line 5602
    iput-object v1, p0, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$ControlVar;->controlId_:Ljava/lang/Object;

    :cond_1
    move-object v0, v1

    .line 5604
    goto :goto_0
.end method

.method public getControlIdBytes()Lcom/google/protobuf/ByteString;
    .locals 2

    .prologue
    .line 5612
    iget-object v0, p0, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$ControlVar;->controlId_:Ljava/lang/Object;

    .line 5613
    instance-of v1, v0, Ljava/lang/String;

    if-eqz v1, :cond_0

    .line 5614
    check-cast v0, Ljava/lang/String;

    .line 5615
    invoke-static {v0}, Lcom/google/protobuf/ByteString;->copyFromUtf8(Ljava/lang/String;)Lcom/google/protobuf/ByteString;

    move-result-object v0

    .line 5617
    iput-object v0, p0, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$ControlVar;->controlId_:Ljava/lang/Object;

    .line 5620
    :goto_0
    return-object v0

    :cond_0
    check-cast v0, Lcom/google/protobuf/ByteString;

    goto :goto_0
.end method

.method public getDefaultInstanceForType()Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$ControlVar;
    .locals 1

    .prologue
    .line 5387
    sget-object v0, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$ControlVar;->defaultInstance:Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$ControlVar;

    return-object v0
.end method

.method public bridge synthetic getDefaultInstanceForType()Lcom/google/protobuf/Message;
    .locals 1

    .prologue
    .line 5371
    invoke-virtual {p0}, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$ControlVar;->getDefaultInstanceForType()Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$ControlVar;

    move-result-object v0

    return-object v0
.end method

.method public bridge synthetic getDefaultInstanceForType()Lcom/google/protobuf/MessageLite;
    .locals 1

    .prologue
    .line 5371
    invoke-virtual {p0}, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$ControlVar;->getDefaultInstanceForType()Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$ControlVar;

    move-result-object v0

    return-object v0
.end method

.method public getIntValue()I
    .locals 1

    .prologue
    .line 5669
    iget v0, p0, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$ControlVar;->intValue_:I

    return v0
.end method

.method public getParserForType()Lcom/google/protobuf/Parser;
    .locals 1
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "()",
            "Lcom/google/protobuf/Parser",
            "<",
            "Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$ControlVar;",
            ">;"
        }
    .end annotation

    .prologue
    .line 5486
    sget-object v0, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$ControlVar;->PARSER:Lcom/google/protobuf/Parser;

    return-object v0
.end method

.method public getSerializedSize()I
    .locals 5

    .prologue
    const/4 v4, 0x4

    const/4 v3, 0x2

    const/4 v2, 0x1

    .line 5758
    iget v0, p0, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$ControlVar;->memoizedSerializedSize:I

    .line 5759
    const/4 v1, -0x1

    if-eq v0, v1, :cond_0

    .line 5784
    :goto_0
    return v0

    .line 5761
    :cond_0
    const/4 v0, 0x0

    .line 5762
    iget v1, p0, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$ControlVar;->bitField0_:I

    and-int/lit8 v1, v1, 0x1

    if-ne v1, v2, :cond_1

    .line 5764
    invoke-virtual {p0}, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$ControlVar;->getControlIdBytes()Lcom/google/protobuf/ByteString;

    move-result-object v1

    invoke-static {v2, v1}, Lcom/google/protobuf/CodedOutputStream;->computeBytesSize(ILcom/google/protobuf/ByteString;)I

    move-result v1

    add-int/2addr v0, v1

    .line 5766
    :cond_1
    iget v1, p0, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$ControlVar;->bitField0_:I

    and-int/lit8 v1, v1, 0x2

    if-ne v1, v3, :cond_2

    .line 5767
    iget-object v1, p0, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$ControlVar;->type_:Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$ControlVar$Data_Type;

    .line 5768
    invoke-virtual {v1}, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$ControlVar$Data_Type;->getNumber()I

    move-result v1

    invoke-static {v3, v1}, Lcom/google/protobuf/CodedOutputStream;->computeEnumSize(II)I

    move-result v1

    add-int/2addr v0, v1

    .line 5770
    :cond_2
    iget v1, p0, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$ControlVar;->bitField0_:I

    and-int/lit8 v1, v1, 0x4

    if-ne v1, v4, :cond_3

    .line 5771
    const/4 v1, 0x3

    iget-boolean v2, p0, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$ControlVar;->boolValue_:Z

    .line 5772
    invoke-static {v1, v2}, Lcom/google/protobuf/CodedOutputStream;->computeBoolSize(IZ)I

    move-result v1

    add-int/2addr v0, v1

    .line 5774
    :cond_3
    iget v1, p0, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$ControlVar;->bitField0_:I

    and-int/lit8 v1, v1, 0x8

    const/16 v2, 0x8

    if-ne v1, v2, :cond_4

    .line 5775
    iget v1, p0, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$ControlVar;->intValue_:I

    .line 5776
    invoke-static {v4, v1}, Lcom/google/protobuf/CodedOutputStream;->computeInt32Size(II)I

    move-result v1

    add-int/2addr v0, v1

    .line 5778
    :cond_4
    iget v1, p0, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$ControlVar;->bitField0_:I

    and-int/lit8 v1, v1, 0x10

    const/16 v2, 0x10

    if-ne v1, v2, :cond_5

    .line 5779
    const/4 v1, 0x5

    .line 5780
    invoke-virtual {p0}, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$ControlVar;->getStringValueBytes()Lcom/google/protobuf/ByteString;

    move-result-object v2

    invoke-static {v1, v2}, Lcom/google/protobuf/CodedOutputStream;->computeBytesSize(ILcom/google/protobuf/ByteString;)I

    move-result v1

    add-int/2addr v0, v1

    .line 5782
    :cond_5
    invoke-virtual {p0}, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$ControlVar;->getUnknownFields()Lcom/google/protobuf/UnknownFieldSet;

    move-result-object v1

    invoke-virtual {v1}, Lcom/google/protobuf/UnknownFieldSet;->getSerializedSize()I

    move-result v1

    add-int/2addr v0, v1

    .line 5783
    iput v0, p0, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$ControlVar;->memoizedSerializedSize:I

    goto :goto_0
.end method

.method public getStringValue()Ljava/lang/String;
    .locals 2

    .prologue
    .line 5685
    iget-object v0, p0, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$ControlVar;->stringValue_:Ljava/lang/Object;

    .line 5686
    instance-of v1, v0, Ljava/lang/String;

    if-eqz v1, :cond_0

    .line 5687
    check-cast v0, Ljava/lang/String;

    .line 5695
    :goto_0
    return-object v0

    .line 5689
    :cond_0
    check-cast v0, Lcom/google/protobuf/ByteString;

    .line 5691
    invoke-virtual {v0}, Lcom/google/protobuf/ByteString;->toStringUtf8()Ljava/lang/String;

    move-result-object v1

    .line 5692
    invoke-virtual {v0}, Lcom/google/protobuf/ByteString;->isValidUtf8()Z

    move-result v0

    if-eqz v0, :cond_1

    .line 5693
    iput-object v1, p0, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$ControlVar;->stringValue_:Ljava/lang/Object;

    :cond_1
    move-object v0, v1

    .line 5695
    goto :goto_0
.end method

.method public getStringValueBytes()Lcom/google/protobuf/ByteString;
    .locals 2

    .prologue
    .line 5703
    iget-object v0, p0, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$ControlVar;->stringValue_:Ljava/lang/Object;

    .line 5704
    instance-of v1, v0, Ljava/lang/String;

    if-eqz v1, :cond_0

    .line 5705
    check-cast v0, Ljava/lang/String;

    .line 5706
    invoke-static {v0}, Lcom/google/protobuf/ByteString;->copyFromUtf8(Ljava/lang/String;)Lcom/google/protobuf/ByteString;

    move-result-object v0

    .line 5708
    iput-object v0, p0, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$ControlVar;->stringValue_:Ljava/lang/Object;

    .line 5711
    :goto_0
    return-object v0

    :cond_0
    check-cast v0, Lcom/google/protobuf/ByteString;

    goto :goto_0
.end method

.method public getType()Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$ControlVar$Data_Type;
    .locals 1

    .prologue
    .line 5637
    iget-object v0, p0, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$ControlVar;->type_:Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$ControlVar$Data_Type;

    return-object v0
.end method

.method public final getUnknownFields()Lcom/google/protobuf/UnknownFieldSet;
    .locals 1

    .prologue
    .line 5394
    iget-object v0, p0, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$ControlVar;->unknownFields:Lcom/google/protobuf/UnknownFieldSet;

    return-object v0
.end method

.method public hasBoolValue()Z
    .locals 2

    .prologue
    .line 5647
    iget v0, p0, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$ControlVar;->bitField0_:I

    and-int/lit8 v0, v0, 0x4

    const/4 v1, 0x4

    if-ne v0, v1, :cond_0

    const/4 v0, 0x1

    :goto_0
    return v0

    :cond_0
    const/4 v0, 0x0

    goto :goto_0
.end method

.method public hasControlId()Z
    .locals 2

    .prologue
    const/4 v0, 0x1

    .line 5588
    iget v1, p0, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$ControlVar;->bitField0_:I

    and-int/lit8 v1, v1, 0x1

    if-ne v1, v0, :cond_0

    :goto_0
    return v0

    :cond_0
    const/4 v0, 0x0

    goto :goto_0
.end method

.method public hasIntValue()Z
    .locals 2

    .prologue
    .line 5663
    iget v0, p0, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$ControlVar;->bitField0_:I

    and-int/lit8 v0, v0, 0x8

    const/16 v1, 0x8

    if-ne v0, v1, :cond_0

    const/4 v0, 0x1

    :goto_0
    return v0

    :cond_0
    const/4 v0, 0x0

    goto :goto_0
.end method

.method public hasStringValue()Z
    .locals 2

    .prologue
    .line 5679
    iget v0, p0, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$ControlVar;->bitField0_:I

    and-int/lit8 v0, v0, 0x10

    const/16 v1, 0x10

    if-ne v0, v1, :cond_0

    const/4 v0, 0x1

    :goto_0
    return v0

    :cond_0
    const/4 v0, 0x0

    goto :goto_0
.end method

.method public hasType()Z
    .locals 2

    .prologue
    .line 5631
    iget v0, p0, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$ControlVar;->bitField0_:I

    and-int/lit8 v0, v0, 0x2

    const/4 v1, 0x2

    if-ne v0, v1, :cond_0

    const/4 v0, 0x1

    :goto_0
    return v0

    :cond_0
    const/4 v0, 0x0

    goto :goto_0
.end method

.method protected internalGetFieldAccessorTable()Lcom/google/protobuf/GeneratedMessage$FieldAccessorTable;
    .locals 3

    .prologue
    .line 5469
    invoke-static {}, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage;->i()Lcom/google/protobuf/GeneratedMessage$FieldAccessorTable;

    move-result-object v0

    const-class v1, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$ControlVar;

    const-class v2, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$ControlVar$Builder;

    .line 5470
    invoke-virtual {v0, v1, v2}, Lcom/google/protobuf/GeneratedMessage$FieldAccessorTable;->ensureFieldAccessorsInitialized(Ljava/lang/Class;Ljava/lang/Class;)Lcom/google/protobuf/GeneratedMessage$FieldAccessorTable;

    move-result-object v0

    .line 5469
    return-object v0
.end method

.method public final isInitialized()Z
    .locals 4

    .prologue
    const/4 v1, 0x0

    const/4 v0, 0x1

    .line 5724
    iget-byte v2, p0, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$ControlVar;->memoizedIsInitialized:B

    .line 5725
    const/4 v3, -0x1

    if-eq v2, v3, :cond_1

    if-ne v2, v0, :cond_0

    .line 5732
    :goto_0
    return v0

    :cond_0
    move v0, v1

    .line 5725
    goto :goto_0

    .line 5727
    :cond_1
    invoke-virtual {p0}, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$ControlVar;->hasControlId()Z

    move-result v2

    if-nez v2, :cond_2

    .line 5728
    iput-byte v1, p0, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$ControlVar;->memoizedIsInitialized:B

    move v0, v1

    .line 5729
    goto :goto_0

    .line 5731
    :cond_2
    iput-byte v0, p0, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$ControlVar;->memoizedIsInitialized:B

    goto :goto_0
.end method

.method public newBuilderForType()Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$ControlVar$Builder;
    .locals 1

    .prologue
    .line 5848
    invoke-static {}, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$ControlVar;->newBuilder()Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$ControlVar$Builder;

    move-result-object v0

    return-object v0
.end method

.method protected newBuilderForType(Lcom/google/protobuf/GeneratedMessage$BuilderParent;)Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$ControlVar$Builder;
    .locals 2

    .prologue
    .line 5857
    new-instance v0, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$ControlVar$Builder;

    const/4 v1, 0x0

    invoke-direct {v0, p1, v1}, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$ControlVar$Builder;-><init>(Lcom/google/protobuf/GeneratedMessage$BuilderParent;Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$1;)V

    .line 5858
    return-object v0
.end method

.method public bridge synthetic newBuilderForType()Lcom/google/protobuf/Message$Builder;
    .locals 1

    .prologue
    .line 5371
    invoke-virtual {p0}, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$ControlVar;->newBuilderForType()Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$ControlVar$Builder;

    move-result-object v0

    return-object v0
.end method

.method protected bridge synthetic newBuilderForType(Lcom/google/protobuf/GeneratedMessage$BuilderParent;)Lcom/google/protobuf/Message$Builder;
    .locals 1

    .prologue
    .line 5371
    invoke-virtual {p0, p1}, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$ControlVar;->newBuilderForType(Lcom/google/protobuf/GeneratedMessage$BuilderParent;)Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$ControlVar$Builder;

    move-result-object v0

    return-object v0
.end method

.method public bridge synthetic newBuilderForType()Lcom/google/protobuf/MessageLite$Builder;
    .locals 1

    .prologue
    .line 5371
    invoke-virtual {p0}, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$ControlVar;->newBuilderForType()Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$ControlVar$Builder;

    move-result-object v0

    return-object v0
.end method

.method public toBuilder()Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$ControlVar$Builder;
    .locals 1

    .prologue
    .line 5852
    invoke-static {p0}, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$ControlVar;->newBuilder(Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$ControlVar;)Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$ControlVar$Builder;

    move-result-object v0

    return-object v0
.end method

.method public bridge synthetic toBuilder()Lcom/google/protobuf/Message$Builder;
    .locals 1

    .prologue
    .line 5371
    invoke-virtual {p0}, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$ControlVar;->toBuilder()Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$ControlVar$Builder;

    move-result-object v0

    return-object v0
.end method

.method public bridge synthetic toBuilder()Lcom/google/protobuf/MessageLite$Builder;
    .locals 1

    .prologue
    .line 5371
    invoke-virtual {p0}, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$ControlVar;->toBuilder()Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$ControlVar$Builder;

    move-result-object v0

    return-object v0
.end method

.method protected writeReplace()Ljava/lang/Object;
    .locals 1
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljava/io/ObjectStreamException;
        }
    .end annotation

    .prologue
    .line 5791
    invoke-super {p0}, Lcom/google/protobuf/GeneratedMessage;->writeReplace()Ljava/lang/Object;

    move-result-object v0

    return-object v0
.end method

.method public writeTo(Lcom/google/protobuf/CodedOutputStream;)V
    .locals 4
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljava/io/IOException;
        }
    .end annotation

    .prologue
    const/4 v3, 0x4

    const/4 v2, 0x2

    const/4 v1, 0x1

    .line 5737
    invoke-virtual {p0}, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$ControlVar;->getSerializedSize()I

    .line 5738
    iget v0, p0, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$ControlVar;->bitField0_:I

    and-int/lit8 v0, v0, 0x1

    if-ne v0, v1, :cond_0

    .line 5739
    invoke-virtual {p0}, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$ControlVar;->getControlIdBytes()Lcom/google/protobuf/ByteString;

    move-result-object v0

    invoke-virtual {p1, v1, v0}, Lcom/google/protobuf/CodedOutputStream;->writeBytes(ILcom/google/protobuf/ByteString;)V

    .line 5741
    :cond_0
    iget v0, p0, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$ControlVar;->bitField0_:I

    and-int/lit8 v0, v0, 0x2

    if-ne v0, v2, :cond_1

    .line 5742
    iget-object v0, p0, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$ControlVar;->type_:Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$ControlVar$Data_Type;

    invoke-virtual {v0}, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$ControlVar$Data_Type;->getNumber()I

    move-result v0

    invoke-virtual {p1, v2, v0}, Lcom/google/protobuf/CodedOutputStream;->writeEnum(II)V

    .line 5744
    :cond_1
    iget v0, p0, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$ControlVar;->bitField0_:I

    and-int/lit8 v0, v0, 0x4

    if-ne v0, v3, :cond_2

    .line 5745
    const/4 v0, 0x3

    iget-boolean v1, p0, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$ControlVar;->boolValue_:Z

    invoke-virtual {p1, v0, v1}, Lcom/google/protobuf/CodedOutputStream;->writeBool(IZ)V

    .line 5747
    :cond_2
    iget v0, p0, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$ControlVar;->bitField0_:I

    and-int/lit8 v0, v0, 0x8

    const/16 v1, 0x8

    if-ne v0, v1, :cond_3

    .line 5748
    iget v0, p0, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$ControlVar;->intValue_:I

    invoke-virtual {p1, v3, v0}, Lcom/google/protobuf/CodedOutputStream;->writeInt32(II)V

    .line 5750
    :cond_3
    iget v0, p0, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$ControlVar;->bitField0_:I

    and-int/lit8 v0, v0, 0x10

    const/16 v1, 0x10

    if-ne v0, v1, :cond_4

    .line 5751
    const/4 v0, 0x5

    invoke-virtual {p0}, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$ControlVar;->getStringValueBytes()Lcom/google/protobuf/ByteString;

    move-result-object v1

    invoke-virtual {p1, v0, v1}, Lcom/google/protobuf/CodedOutputStream;->writeBytes(ILcom/google/protobuf/ByteString;)V

    .line 5753
    :cond_4
    invoke-virtual {p0}, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$ControlVar;->getUnknownFields()Lcom/google/protobuf/UnknownFieldSet;

    move-result-object v0

    invoke-virtual {v0, p1}, Lcom/google/protobuf/UnknownFieldSet;->writeTo(Lcom/google/protobuf/CodedOutputStream;)V

    .line 5754
    return-void
.end method
