.class public final Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$CommandToUip;
.super Lcom/google/protobuf/GeneratedMessage;
.source "SourceFile"

# interfaces
.implements Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$CommandToUipOrBuilder;


# annotations
.annotation system Ldalvik/annotation/EnclosingClass;
    value = Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage;
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x19
    name = "CommandToUip"
.end annotation

.annotation system Ldalvik/annotation/MemberClasses;
    value = {
        Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$CommandToUip$Builder;,
        Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$CommandToUip$Command_Type;
    }
.end annotation


# static fields
.field public static final COMMAND_FIELD_NUMBER:I = 0x1

.field public static final CONTROL_ID_FIELD_NUMBER:I = 0x2

.field public static PARSER:Lcom/google/protobuf/Parser; = null
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "Lcom/google/protobuf/Parser",
            "<",
            "Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$CommandToUip;",
            ">;"
        }
    .end annotation
.end field

.field public static final UIP_ATTRIBUTE_DATA_FIELD_NUMBER:I = 0x3

.field private static final defaultInstance:Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$CommandToUip;

.field private static final serialVersionUID:J


# instance fields
.field private bitField0_:I

.field private command_:Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$CommandToUip$Command_Type;

.field private controlId_:Ljava/lang/Object;

.field private memoizedIsInitialized:B

.field private memoizedSerializedSize:I

.field private uipAttributeData_:Ljava/lang/Object;

.field private final unknownFields:Lcom/google/protobuf/UnknownFieldSet;


# direct methods
.method static constructor <clinit>()V
    .locals 2

    .prologue
    .line 7576
    new-instance v0, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$CommandToUip$1;

    invoke-direct {v0}, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$CommandToUip$1;-><init>()V

    sput-object v0, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$CommandToUip;->PARSER:Lcom/google/protobuf/Parser;

    .line 8245
    new-instance v0, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$CommandToUip;

    const/4 v1, 0x1

    invoke-direct {v0, v1}, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$CommandToUip;-><init>(Z)V

    sput-object v0, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$CommandToUip;->defaultInstance:Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$CommandToUip;

    .line 8246
    sget-object v0, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$CommandToUip;->defaultInstance:Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$CommandToUip;

    invoke-direct {v0}, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$CommandToUip;->initFields()V

    .line 8247
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
    const/4 v0, -0x1

    const/4 v1, 0x1

    .line 7511
    invoke-direct {p0}, Lcom/google/protobuf/GeneratedMessage;-><init>()V

    .line 7789
    iput-byte v0, p0, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$CommandToUip;->memoizedIsInitialized:B

    .line 7817
    iput v0, p0, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$CommandToUip;->memoizedSerializedSize:I

    .line 7512
    invoke-direct {p0}, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$CommandToUip;->initFields()V

    .line 7515
    invoke-static {}, Lcom/google/protobuf/UnknownFieldSet;->newBuilder()Lcom/google/protobuf/UnknownFieldSet$Builder;

    move-result-object v2

    .line 7517
    const/4 v0, 0x0

    .line 7518
    :cond_0
    :goto_0
    if-nez v0, :cond_2

    .line 7519
    :try_start_0
    invoke-virtual {p1}, Lcom/google/protobuf/CodedInputStream;->readTag()I

    move-result v3

    .line 7520
    sparse-switch v3, :sswitch_data_0

    .line 7525
    invoke-virtual {p0, p1, v2, p2, v3}, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$CommandToUip;->parseUnknownField(Lcom/google/protobuf/CodedInputStream;Lcom/google/protobuf/UnknownFieldSet$Builder;Lcom/google/protobuf/ExtensionRegistryLite;I)Z

    move-result v3

    if-nez v3, :cond_0

    move v0, v1

    .line 7527
    goto :goto_0

    :sswitch_0
    move v0, v1

    .line 7523
    goto :goto_0

    .line 7532
    :sswitch_1
    invoke-virtual {p1}, Lcom/google/protobuf/CodedInputStream;->readEnum()I

    move-result v3

    .line 7533
    invoke-static {v3}, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$CommandToUip$Command_Type;->valueOf(I)Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$CommandToUip$Command_Type;

    move-result-object v4

    .line 7534
    if-nez v4, :cond_1

    .line 7535
    const/4 v4, 0x1

    invoke-virtual {v2, v4, v3}, Lcom/google/protobuf/UnknownFieldSet$Builder;->mergeVarintField(II)Lcom/google/protobuf/UnknownFieldSet$Builder;
    :try_end_0
    .catch Lcom/google/protobuf/InvalidProtocolBufferException; {:try_start_0 .. :try_end_0} :catch_0
    .catch Ljava/io/IOException; {:try_start_0 .. :try_end_0} :catch_1
    .catchall {:try_start_0 .. :try_end_0} :catchall_0

    goto :goto_0

    .line 7554
    :catch_0
    move-exception v0

    .line 7555
    :try_start_1
    invoke-virtual {v0, p0}, Lcom/google/protobuf/InvalidProtocolBufferException;->setUnfinishedMessage(Lcom/google/protobuf/MessageLite;)Lcom/google/protobuf/InvalidProtocolBufferException;

    move-result-object v0

    throw v0
    :try_end_1
    .catchall {:try_start_1 .. :try_end_1} :catchall_0

    .line 7560
    :catchall_0
    move-exception v0

    invoke-virtual {v2}, Lcom/google/protobuf/UnknownFieldSet$Builder;->build()Lcom/google/protobuf/UnknownFieldSet;

    move-result-object v1

    iput-object v1, p0, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$CommandToUip;->unknownFields:Lcom/google/protobuf/UnknownFieldSet;

    .line 7561
    invoke-virtual {p0}, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$CommandToUip;->makeExtensionsImmutable()V

    throw v0

    .line 7537
    :cond_1
    :try_start_2
    iget v3, p0, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$CommandToUip;->bitField0_:I

    or-int/lit8 v3, v3, 0x1

    iput v3, p0, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$CommandToUip;->bitField0_:I

    .line 7538
    iput-object v4, p0, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$CommandToUip;->command_:Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$CommandToUip$Command_Type;
    :try_end_2
    .catch Lcom/google/protobuf/InvalidProtocolBufferException; {:try_start_2 .. :try_end_2} :catch_0
    .catch Ljava/io/IOException; {:try_start_2 .. :try_end_2} :catch_1
    .catchall {:try_start_2 .. :try_end_2} :catchall_0

    goto :goto_0

    .line 7556
    :catch_1
    move-exception v0

    .line 7557
    :try_start_3
    new-instance v1, Lcom/google/protobuf/InvalidProtocolBufferException;

    .line 7558
    invoke-virtual {v0}, Ljava/io/IOException;->getMessage()Ljava/lang/String;

    move-result-object v0

    invoke-direct {v1, v0}, Lcom/google/protobuf/InvalidProtocolBufferException;-><init>(Ljava/lang/String;)V

    invoke-virtual {v1, p0}, Lcom/google/protobuf/InvalidProtocolBufferException;->setUnfinishedMessage(Lcom/google/protobuf/MessageLite;)Lcom/google/protobuf/InvalidProtocolBufferException;

    move-result-object v0

    throw v0
    :try_end_3
    .catchall {:try_start_3 .. :try_end_3} :catchall_0

    .line 7543
    :sswitch_2
    :try_start_4
    iget v3, p0, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$CommandToUip;->bitField0_:I

    or-int/lit8 v3, v3, 0x2

    iput v3, p0, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$CommandToUip;->bitField0_:I

    .line 7544
    invoke-virtual {p1}, Lcom/google/protobuf/CodedInputStream;->readBytes()Lcom/google/protobuf/ByteString;

    move-result-object v3

    iput-object v3, p0, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$CommandToUip;->controlId_:Ljava/lang/Object;

    goto :goto_0

    .line 7548
    :sswitch_3
    iget v3, p0, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$CommandToUip;->bitField0_:I

    or-int/lit8 v3, v3, 0x4

    iput v3, p0, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$CommandToUip;->bitField0_:I

    .line 7549
    invoke-virtual {p1}, Lcom/google/protobuf/CodedInputStream;->readBytes()Lcom/google/protobuf/ByteString;

    move-result-object v3

    iput-object v3, p0, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$CommandToUip;->uipAttributeData_:Ljava/lang/Object;
    :try_end_4
    .catch Lcom/google/protobuf/InvalidProtocolBufferException; {:try_start_4 .. :try_end_4} :catch_0
    .catch Ljava/io/IOException; {:try_start_4 .. :try_end_4} :catch_1
    .catchall {:try_start_4 .. :try_end_4} :catchall_0

    goto :goto_0

    .line 7560
    :cond_2
    invoke-virtual {v2}, Lcom/google/protobuf/UnknownFieldSet$Builder;->build()Lcom/google/protobuf/UnknownFieldSet;

    move-result-object v0

    iput-object v0, p0, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$CommandToUip;->unknownFields:Lcom/google/protobuf/UnknownFieldSet;

    .line 7561
    invoke-virtual {p0}, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$CommandToUip;->makeExtensionsImmutable()V

    .line 7563
    return-void

    .line 7520
    :sswitch_data_0
    .sparse-switch
        0x0 -> :sswitch_0
        0x8 -> :sswitch_1
        0x12 -> :sswitch_2
        0x1a -> :sswitch_3
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
    .line 7483
    invoke-direct {p0, p1, p2}, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$CommandToUip;-><init>(Lcom/google/protobuf/CodedInputStream;Lcom/google/protobuf/ExtensionRegistryLite;)V

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

    .line 7488
    invoke-direct {p0, p1}, Lcom/google/protobuf/GeneratedMessage;-><init>(Lcom/google/protobuf/GeneratedMessage$Builder;)V

    .line 7789
    iput-byte v0, p0, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$CommandToUip;->memoizedIsInitialized:B

    .line 7817
    iput v0, p0, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$CommandToUip;->memoizedSerializedSize:I

    .line 7489
    invoke-virtual {p1}, Lcom/google/protobuf/GeneratedMessage$Builder;->getUnknownFields()Lcom/google/protobuf/UnknownFieldSet;

    move-result-object v0

    iput-object v0, p0, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$CommandToUip;->unknownFields:Lcom/google/protobuf/UnknownFieldSet;

    .line 7490
    return-void
.end method

.method synthetic constructor <init>(Lcom/google/protobuf/GeneratedMessage$Builder;Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$1;)V
    .locals 0

    .prologue
    .line 7483
    invoke-direct {p0, p1}, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$CommandToUip;-><init>(Lcom/google/protobuf/GeneratedMessage$Builder;)V

    return-void
.end method

.method private constructor <init>(Z)V
    .locals 1

    .prologue
    const/4 v0, -0x1

    .line 7491
    invoke-direct {p0}, Lcom/google/protobuf/GeneratedMessage;-><init>()V

    .line 7789
    iput-byte v0, p0, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$CommandToUip;->memoizedIsInitialized:B

    .line 7817
    iput v0, p0, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$CommandToUip;->memoizedSerializedSize:I

    .line 7491
    invoke-static {}, Lcom/google/protobuf/UnknownFieldSet;->getDefaultInstance()Lcom/google/protobuf/UnknownFieldSet;

    move-result-object v0

    iput-object v0, p0, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$CommandToUip;->unknownFields:Lcom/google/protobuf/UnknownFieldSet;

    return-void
.end method

.method static synthetic access$8500()Z
    .locals 1

    .prologue
    .line 7483
    sget-boolean v0, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$CommandToUip;->alwaysUseFieldBuilders:Z

    return v0
.end method

.method static synthetic access$8702(Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$CommandToUip;Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$CommandToUip$Command_Type;)Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$CommandToUip$Command_Type;
    .locals 0

    .prologue
    .line 7483
    iput-object p1, p0, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$CommandToUip;->command_:Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$CommandToUip$Command_Type;

    return-object p1
.end method

.method static synthetic access$8800(Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$CommandToUip;)Ljava/lang/Object;
    .locals 1

    .prologue
    .line 7483
    iget-object v0, p0, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$CommandToUip;->controlId_:Ljava/lang/Object;

    return-object v0
.end method

.method static synthetic access$8802(Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$CommandToUip;Ljava/lang/Object;)Ljava/lang/Object;
    .locals 0

    .prologue
    .line 7483
    iput-object p1, p0, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$CommandToUip;->controlId_:Ljava/lang/Object;

    return-object p1
.end method

.method static synthetic access$8900(Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$CommandToUip;)Ljava/lang/Object;
    .locals 1

    .prologue
    .line 7483
    iget-object v0, p0, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$CommandToUip;->uipAttributeData_:Ljava/lang/Object;

    return-object v0
.end method

.method static synthetic access$8902(Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$CommandToUip;Ljava/lang/Object;)Ljava/lang/Object;
    .locals 0

    .prologue
    .line 7483
    iput-object p1, p0, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$CommandToUip;->uipAttributeData_:Ljava/lang/Object;

    return-object p1
.end method

.method static synthetic access$9002(Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$CommandToUip;I)I
    .locals 0

    .prologue
    .line 7483
    iput p1, p0, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$CommandToUip;->bitField0_:I

    return p1
.end method

.method public static getDefaultInstance()Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$CommandToUip;
    .locals 1

    .prologue
    .line 7495
    sget-object v0, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$CommandToUip;->defaultInstance:Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$CommandToUip;

    return-object v0
.end method

.method public static final getDescriptor()Lcom/google/protobuf/Descriptors$Descriptor;
    .locals 1

    .prologue
    .line 7566
    invoke-static {}, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage;->l()Lcom/google/protobuf/Descriptors$Descriptor;

    move-result-object v0

    return-object v0
.end method

.method private initFields()V
    .locals 1

    .prologue
    .line 7785
    sget-object v0, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$CommandToUip$Command_Type;->GET_UIP_ATTRIBUTE:Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$CommandToUip$Command_Type;

    iput-object v0, p0, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$CommandToUip;->command_:Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$CommandToUip$Command_Type;

    .line 7786
    const-string v0, ""

    iput-object v0, p0, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$CommandToUip;->controlId_:Ljava/lang/Object;

    .line 7787
    const-string v0, ""

    iput-object v0, p0, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$CommandToUip;->uipAttributeData_:Ljava/lang/Object;

    .line 7788
    return-void
.end method

.method public static newBuilder()Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$CommandToUip$Builder;
    .locals 1

    .prologue
    .line 7900
    invoke-static {}, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$CommandToUip$Builder;->access$8300()Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$CommandToUip$Builder;

    move-result-object v0

    return-object v0
.end method

.method public static newBuilder(Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$CommandToUip;)Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$CommandToUip$Builder;
    .locals 1

    .prologue
    .line 7903
    invoke-static {}, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$CommandToUip;->newBuilder()Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$CommandToUip$Builder;

    move-result-object v0

    invoke-virtual {v0, p0}, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$CommandToUip$Builder;->mergeFrom(Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$CommandToUip;)Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$CommandToUip$Builder;

    move-result-object v0

    return-object v0
.end method

.method public static parseDelimitedFrom(Ljava/io/InputStream;)Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$CommandToUip;
    .locals 1
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljava/io/IOException;
        }
    .end annotation

    .prologue
    .line 7880
    sget-object v0, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$CommandToUip;->PARSER:Lcom/google/protobuf/Parser;

    invoke-interface {v0, p0}, Lcom/google/protobuf/Parser;->parseDelimitedFrom(Ljava/io/InputStream;)Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$CommandToUip;

    return-object v0
.end method

.method public static parseDelimitedFrom(Ljava/io/InputStream;Lcom/google/protobuf/ExtensionRegistryLite;)Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$CommandToUip;
    .locals 1
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljava/io/IOException;
        }
    .end annotation

    .prologue
    .line 7886
    sget-object v0, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$CommandToUip;->PARSER:Lcom/google/protobuf/Parser;

    invoke-interface {v0, p0, p1}, Lcom/google/protobuf/Parser;->parseDelimitedFrom(Ljava/io/InputStream;Lcom/google/protobuf/ExtensionRegistryLite;)Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$CommandToUip;

    return-object v0
.end method

.method public static parseFrom(Lcom/google/protobuf/ByteString;)Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$CommandToUip;
    .locals 1
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Lcom/google/protobuf/InvalidProtocolBufferException;
        }
    .end annotation

    .prologue
    .line 7850
    sget-object v0, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$CommandToUip;->PARSER:Lcom/google/protobuf/Parser;

    invoke-interface {v0, p0}, Lcom/google/protobuf/Parser;->parseFrom(Lcom/google/protobuf/ByteString;)Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$CommandToUip;

    return-object v0
.end method

.method public static parseFrom(Lcom/google/protobuf/ByteString;Lcom/google/protobuf/ExtensionRegistryLite;)Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$CommandToUip;
    .locals 1
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Lcom/google/protobuf/InvalidProtocolBufferException;
        }
    .end annotation

    .prologue
    .line 7856
    sget-object v0, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$CommandToUip;->PARSER:Lcom/google/protobuf/Parser;

    invoke-interface {v0, p0, p1}, Lcom/google/protobuf/Parser;->parseFrom(Lcom/google/protobuf/ByteString;Lcom/google/protobuf/ExtensionRegistryLite;)Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$CommandToUip;

    return-object v0
.end method

.method public static parseFrom(Lcom/google/protobuf/CodedInputStream;)Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$CommandToUip;
    .locals 1
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljava/io/IOException;
        }
    .end annotation

    .prologue
    .line 7891
    sget-object v0, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$CommandToUip;->PARSER:Lcom/google/protobuf/Parser;

    invoke-interface {v0, p0}, Lcom/google/protobuf/Parser;->parseFrom(Lcom/google/protobuf/CodedInputStream;)Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$CommandToUip;

    return-object v0
.end method

.method public static parseFrom(Lcom/google/protobuf/CodedInputStream;Lcom/google/protobuf/ExtensionRegistryLite;)Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$CommandToUip;
    .locals 1
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljava/io/IOException;
        }
    .end annotation

    .prologue
    .line 7897
    sget-object v0, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$CommandToUip;->PARSER:Lcom/google/protobuf/Parser;

    invoke-interface {v0, p0, p1}, Lcom/google/protobuf/Parser;->parseFrom(Lcom/google/protobuf/CodedInputStream;Lcom/google/protobuf/ExtensionRegistryLite;)Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$CommandToUip;

    return-object v0
.end method

.method public static parseFrom(Ljava/io/InputStream;)Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$CommandToUip;
    .locals 1
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljava/io/IOException;
        }
    .end annotation

    .prologue
    .line 7870
    sget-object v0, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$CommandToUip;->PARSER:Lcom/google/protobuf/Parser;

    invoke-interface {v0, p0}, Lcom/google/protobuf/Parser;->parseFrom(Ljava/io/InputStream;)Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$CommandToUip;

    return-object v0
.end method

.method public static parseFrom(Ljava/io/InputStream;Lcom/google/protobuf/ExtensionRegistryLite;)Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$CommandToUip;
    .locals 1
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljava/io/IOException;
        }
    .end annotation

    .prologue
    .line 7876
    sget-object v0, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$CommandToUip;->PARSER:Lcom/google/protobuf/Parser;

    invoke-interface {v0, p0, p1}, Lcom/google/protobuf/Parser;->parseFrom(Ljava/io/InputStream;Lcom/google/protobuf/ExtensionRegistryLite;)Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$CommandToUip;

    return-object v0
.end method

.method public static parseFrom([B)Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$CommandToUip;
    .locals 1
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Lcom/google/protobuf/InvalidProtocolBufferException;
        }
    .end annotation

    .prologue
    .line 7860
    sget-object v0, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$CommandToUip;->PARSER:Lcom/google/protobuf/Parser;

    invoke-interface {v0, p0}, Lcom/google/protobuf/Parser;->parseFrom([B)Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$CommandToUip;

    return-object v0
.end method

.method public static parseFrom([BLcom/google/protobuf/ExtensionRegistryLite;)Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$CommandToUip;
    .locals 1
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Lcom/google/protobuf/InvalidProtocolBufferException;
        }
    .end annotation

    .prologue
    .line 7866
    sget-object v0, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$CommandToUip;->PARSER:Lcom/google/protobuf/Parser;

    invoke-interface {v0, p0, p1}, Lcom/google/protobuf/Parser;->parseFrom([BLcom/google/protobuf/ExtensionRegistryLite;)Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$CommandToUip;

    return-object v0
.end method


# virtual methods
.method public getCommand()Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$CommandToUip$Command_Type;
    .locals 1

    .prologue
    .line 7695
    iget-object v0, p0, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$CommandToUip;->command_:Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$CommandToUip$Command_Type;

    return-object v0
.end method

.method public getControlId()Ljava/lang/String;
    .locals 2

    .prologue
    .line 7711
    iget-object v0, p0, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$CommandToUip;->controlId_:Ljava/lang/Object;

    .line 7712
    instance-of v1, v0, Ljava/lang/String;

    if-eqz v1, :cond_0

    .line 7713
    check-cast v0, Ljava/lang/String;

    .line 7721
    :goto_0
    return-object v0

    .line 7715
    :cond_0
    check-cast v0, Lcom/google/protobuf/ByteString;

    .line 7717
    invoke-virtual {v0}, Lcom/google/protobuf/ByteString;->toStringUtf8()Ljava/lang/String;

    move-result-object v1

    .line 7718
    invoke-virtual {v0}, Lcom/google/protobuf/ByteString;->isValidUtf8()Z

    move-result v0

    if-eqz v0, :cond_1

    .line 7719
    iput-object v1, p0, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$CommandToUip;->controlId_:Ljava/lang/Object;

    :cond_1
    move-object v0, v1

    .line 7721
    goto :goto_0
.end method

.method public getControlIdBytes()Lcom/google/protobuf/ByteString;
    .locals 2

    .prologue
    .line 7729
    iget-object v0, p0, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$CommandToUip;->controlId_:Ljava/lang/Object;

    .line 7730
    instance-of v1, v0, Ljava/lang/String;

    if-eqz v1, :cond_0

    .line 7731
    check-cast v0, Ljava/lang/String;

    .line 7732
    invoke-static {v0}, Lcom/google/protobuf/ByteString;->copyFromUtf8(Ljava/lang/String;)Lcom/google/protobuf/ByteString;

    move-result-object v0

    .line 7734
    iput-object v0, p0, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$CommandToUip;->controlId_:Ljava/lang/Object;

    .line 7737
    :goto_0
    return-object v0

    :cond_0
    check-cast v0, Lcom/google/protobuf/ByteString;

    goto :goto_0
.end method

.method public getDefaultInstanceForType()Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$CommandToUip;
    .locals 1

    .prologue
    .line 7499
    sget-object v0, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$CommandToUip;->defaultInstance:Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$CommandToUip;

    return-object v0
.end method

.method public bridge synthetic getDefaultInstanceForType()Lcom/google/protobuf/Message;
    .locals 1

    .prologue
    .line 7483
    invoke-virtual {p0}, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$CommandToUip;->getDefaultInstanceForType()Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$CommandToUip;

    move-result-object v0

    return-object v0
.end method

.method public bridge synthetic getDefaultInstanceForType()Lcom/google/protobuf/MessageLite;
    .locals 1

    .prologue
    .line 7483
    invoke-virtual {p0}, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$CommandToUip;->getDefaultInstanceForType()Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$CommandToUip;

    move-result-object v0

    return-object v0
.end method

.method public getParserForType()Lcom/google/protobuf/Parser;
    .locals 1
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "()",
            "Lcom/google/protobuf/Parser",
            "<",
            "Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$CommandToUip;",
            ">;"
        }
    .end annotation

    .prologue
    .line 7588
    sget-object v0, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$CommandToUip;->PARSER:Lcom/google/protobuf/Parser;

    return-object v0
.end method

.method public getSerializedSize()I
    .locals 4

    .prologue
    const/4 v3, 0x2

    const/4 v2, 0x1

    .line 7819
    iget v0, p0, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$CommandToUip;->memoizedSerializedSize:I

    .line 7820
    const/4 v1, -0x1

    if-eq v0, v1, :cond_0

    .line 7837
    :goto_0
    return v0

    .line 7822
    :cond_0
    const/4 v0, 0x0

    .line 7823
    iget v1, p0, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$CommandToUip;->bitField0_:I

    and-int/lit8 v1, v1, 0x1

    if-ne v1, v2, :cond_1

    .line 7824
    iget-object v1, p0, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$CommandToUip;->command_:Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$CommandToUip$Command_Type;

    .line 7825
    invoke-virtual {v1}, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$CommandToUip$Command_Type;->getNumber()I

    move-result v1

    invoke-static {v2, v1}, Lcom/google/protobuf/CodedOutputStream;->computeEnumSize(II)I

    move-result v1

    add-int/2addr v0, v1

    .line 7827
    :cond_1
    iget v1, p0, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$CommandToUip;->bitField0_:I

    and-int/lit8 v1, v1, 0x2

    if-ne v1, v3, :cond_2

    .line 7829
    invoke-virtual {p0}, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$CommandToUip;->getControlIdBytes()Lcom/google/protobuf/ByteString;

    move-result-object v1

    invoke-static {v3, v1}, Lcom/google/protobuf/CodedOutputStream;->computeBytesSize(ILcom/google/protobuf/ByteString;)I

    move-result v1

    add-int/2addr v0, v1

    .line 7831
    :cond_2
    iget v1, p0, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$CommandToUip;->bitField0_:I

    and-int/lit8 v1, v1, 0x4

    const/4 v2, 0x4

    if-ne v1, v2, :cond_3

    .line 7832
    const/4 v1, 0x3

    .line 7833
    invoke-virtual {p0}, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$CommandToUip;->getUipAttributeDataBytes()Lcom/google/protobuf/ByteString;

    move-result-object v2

    invoke-static {v1, v2}, Lcom/google/protobuf/CodedOutputStream;->computeBytesSize(ILcom/google/protobuf/ByteString;)I

    move-result v1

    add-int/2addr v0, v1

    .line 7835
    :cond_3
    invoke-virtual {p0}, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$CommandToUip;->getUnknownFields()Lcom/google/protobuf/UnknownFieldSet;

    move-result-object v1

    invoke-virtual {v1}, Lcom/google/protobuf/UnknownFieldSet;->getSerializedSize()I

    move-result v1

    add-int/2addr v0, v1

    .line 7836
    iput v0, p0, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$CommandToUip;->memoizedSerializedSize:I

    goto :goto_0
.end method

.method public getUipAttributeData()Ljava/lang/String;
    .locals 2

    .prologue
    .line 7754
    iget-object v0, p0, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$CommandToUip;->uipAttributeData_:Ljava/lang/Object;

    .line 7755
    instance-of v1, v0, Ljava/lang/String;

    if-eqz v1, :cond_0

    .line 7756
    check-cast v0, Ljava/lang/String;

    .line 7764
    :goto_0
    return-object v0

    .line 7758
    :cond_0
    check-cast v0, Lcom/google/protobuf/ByteString;

    .line 7760
    invoke-virtual {v0}, Lcom/google/protobuf/ByteString;->toStringUtf8()Ljava/lang/String;

    move-result-object v1

    .line 7761
    invoke-virtual {v0}, Lcom/google/protobuf/ByteString;->isValidUtf8()Z

    move-result v0

    if-eqz v0, :cond_1

    .line 7762
    iput-object v1, p0, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$CommandToUip;->uipAttributeData_:Ljava/lang/Object;

    :cond_1
    move-object v0, v1

    .line 7764
    goto :goto_0
.end method

.method public getUipAttributeDataBytes()Lcom/google/protobuf/ByteString;
    .locals 2

    .prologue
    .line 7772
    iget-object v0, p0, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$CommandToUip;->uipAttributeData_:Ljava/lang/Object;

    .line 7773
    instance-of v1, v0, Ljava/lang/String;

    if-eqz v1, :cond_0

    .line 7774
    check-cast v0, Ljava/lang/String;

    .line 7775
    invoke-static {v0}, Lcom/google/protobuf/ByteString;->copyFromUtf8(Ljava/lang/String;)Lcom/google/protobuf/ByteString;

    move-result-object v0

    .line 7777
    iput-object v0, p0, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$CommandToUip;->uipAttributeData_:Ljava/lang/Object;

    .line 7780
    :goto_0
    return-object v0

    :cond_0
    check-cast v0, Lcom/google/protobuf/ByteString;

    goto :goto_0
.end method

.method public final getUnknownFields()Lcom/google/protobuf/UnknownFieldSet;
    .locals 1

    .prologue
    .line 7506
    iget-object v0, p0, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$CommandToUip;->unknownFields:Lcom/google/protobuf/UnknownFieldSet;

    return-object v0
.end method

.method public hasCommand()Z
    .locals 2

    .prologue
    const/4 v0, 0x1

    .line 7689
    iget v1, p0, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$CommandToUip;->bitField0_:I

    and-int/lit8 v1, v1, 0x1

    if-ne v1, v0, :cond_0

    :goto_0
    return v0

    :cond_0
    const/4 v0, 0x0

    goto :goto_0
.end method

.method public hasControlId()Z
    .locals 2

    .prologue
    .line 7705
    iget v0, p0, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$CommandToUip;->bitField0_:I

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

.method public hasUipAttributeData()Z
    .locals 2

    .prologue
    .line 7748
    iget v0, p0, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$CommandToUip;->bitField0_:I

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

.method protected internalGetFieldAccessorTable()Lcom/google/protobuf/GeneratedMessage$FieldAccessorTable;
    .locals 3

    .prologue
    .line 7571
    invoke-static {}, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage;->m()Lcom/google/protobuf/GeneratedMessage$FieldAccessorTable;

    move-result-object v0

    const-class v1, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$CommandToUip;

    const-class v2, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$CommandToUip$Builder;

    .line 7572
    invoke-virtual {v0, v1, v2}, Lcom/google/protobuf/GeneratedMessage$FieldAccessorTable;->ensureFieldAccessorsInitialized(Ljava/lang/Class;Ljava/lang/Class;)Lcom/google/protobuf/GeneratedMessage$FieldAccessorTable;

    move-result-object v0

    .line 7571
    return-object v0
.end method

.method public final isInitialized()Z
    .locals 4

    .prologue
    const/4 v1, 0x0

    const/4 v0, 0x1

    .line 7791
    iget-byte v2, p0, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$CommandToUip;->memoizedIsInitialized:B

    .line 7792
    const/4 v3, -0x1

    if-eq v2, v3, :cond_1

    if-ne v2, v0, :cond_0

    .line 7799
    :goto_0
    return v0

    :cond_0
    move v0, v1

    .line 7792
    goto :goto_0

    .line 7794
    :cond_1
    invoke-virtual {p0}, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$CommandToUip;->hasCommand()Z

    move-result v2

    if-nez v2, :cond_2

    .line 7795
    iput-byte v1, p0, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$CommandToUip;->memoizedIsInitialized:B

    move v0, v1

    .line 7796
    goto :goto_0

    .line 7798
    :cond_2
    iput-byte v0, p0, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$CommandToUip;->memoizedIsInitialized:B

    goto :goto_0
.end method

.method public newBuilderForType()Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$CommandToUip$Builder;
    .locals 1

    .prologue
    .line 7901
    invoke-static {}, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$CommandToUip;->newBuilder()Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$CommandToUip$Builder;

    move-result-object v0

    return-object v0
.end method

.method protected newBuilderForType(Lcom/google/protobuf/GeneratedMessage$BuilderParent;)Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$CommandToUip$Builder;
    .locals 2

    .prologue
    .line 7910
    new-instance v0, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$CommandToUip$Builder;

    const/4 v1, 0x0

    invoke-direct {v0, p1, v1}, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$CommandToUip$Builder;-><init>(Lcom/google/protobuf/GeneratedMessage$BuilderParent;Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$1;)V

    .line 7911
    return-object v0
.end method

.method public bridge synthetic newBuilderForType()Lcom/google/protobuf/Message$Builder;
    .locals 1

    .prologue
    .line 7483
    invoke-virtual {p0}, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$CommandToUip;->newBuilderForType()Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$CommandToUip$Builder;

    move-result-object v0

    return-object v0
.end method

.method protected bridge synthetic newBuilderForType(Lcom/google/protobuf/GeneratedMessage$BuilderParent;)Lcom/google/protobuf/Message$Builder;
    .locals 1

    .prologue
    .line 7483
    invoke-virtual {p0, p1}, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$CommandToUip;->newBuilderForType(Lcom/google/protobuf/GeneratedMessage$BuilderParent;)Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$CommandToUip$Builder;

    move-result-object v0

    return-object v0
.end method

.method public bridge synthetic newBuilderForType()Lcom/google/protobuf/MessageLite$Builder;
    .locals 1

    .prologue
    .line 7483
    invoke-virtual {p0}, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$CommandToUip;->newBuilderForType()Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$CommandToUip$Builder;

    move-result-object v0

    return-object v0
.end method

.method public toBuilder()Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$CommandToUip$Builder;
    .locals 1

    .prologue
    .line 7905
    invoke-static {p0}, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$CommandToUip;->newBuilder(Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$CommandToUip;)Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$CommandToUip$Builder;

    move-result-object v0

    return-object v0
.end method

.method public bridge synthetic toBuilder()Lcom/google/protobuf/Message$Builder;
    .locals 1

    .prologue
    .line 7483
    invoke-virtual {p0}, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$CommandToUip;->toBuilder()Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$CommandToUip$Builder;

    move-result-object v0

    return-object v0
.end method

.method public bridge synthetic toBuilder()Lcom/google/protobuf/MessageLite$Builder;
    .locals 1

    .prologue
    .line 7483
    invoke-virtual {p0}, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$CommandToUip;->toBuilder()Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$CommandToUip$Builder;

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
    .line 7844
    invoke-super {p0}, Lcom/google/protobuf/GeneratedMessage;->writeReplace()Ljava/lang/Object;

    move-result-object v0

    return-object v0
.end method

.method public writeTo(Lcom/google/protobuf/CodedOutputStream;)V
    .locals 3
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljava/io/IOException;
        }
    .end annotation

    .prologue
    const/4 v2, 0x2

    const/4 v1, 0x1

    .line 7804
    invoke-virtual {p0}, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$CommandToUip;->getSerializedSize()I

    .line 7805
    iget v0, p0, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$CommandToUip;->bitField0_:I

    and-int/lit8 v0, v0, 0x1

    if-ne v0, v1, :cond_0

    .line 7806
    iget-object v0, p0, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$CommandToUip;->command_:Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$CommandToUip$Command_Type;

    invoke-virtual {v0}, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$CommandToUip$Command_Type;->getNumber()I

    move-result v0

    invoke-virtual {p1, v1, v0}, Lcom/google/protobuf/CodedOutputStream;->writeEnum(II)V

    .line 7808
    :cond_0
    iget v0, p0, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$CommandToUip;->bitField0_:I

    and-int/lit8 v0, v0, 0x2

    if-ne v0, v2, :cond_1

    .line 7809
    invoke-virtual {p0}, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$CommandToUip;->getControlIdBytes()Lcom/google/protobuf/ByteString;

    move-result-object v0

    invoke-virtual {p1, v2, v0}, Lcom/google/protobuf/CodedOutputStream;->writeBytes(ILcom/google/protobuf/ByteString;)V

    .line 7811
    :cond_1
    iget v0, p0, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$CommandToUip;->bitField0_:I

    and-int/lit8 v0, v0, 0x4

    const/4 v1, 0x4

    if-ne v0, v1, :cond_2

    .line 7812
    const/4 v0, 0x3

    invoke-virtual {p0}, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$CommandToUip;->getUipAttributeDataBytes()Lcom/google/protobuf/ByteString;

    move-result-object v1

    invoke-virtual {p1, v0, v1}, Lcom/google/protobuf/CodedOutputStream;->writeBytes(ILcom/google/protobuf/ByteString;)V

    .line 7814
    :cond_2
    invoke-virtual {p0}, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$CommandToUip;->getUnknownFields()Lcom/google/protobuf/UnknownFieldSet;

    move-result-object v0

    invoke-virtual {v0, p1}, Lcom/google/protobuf/UnknownFieldSet;->writeTo(Lcom/google/protobuf/CodedOutputStream;)V

    .line 7815
    return-void
.end method
