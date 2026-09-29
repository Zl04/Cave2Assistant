.class public final Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$Device;
.super Lcom/google/protobuf/GeneratedMessage;
.source "SourceFile"

# interfaces
.implements Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$DeviceOrBuilder;


# annotations
.annotation system Ldalvik/annotation/EnclosingClass;
    value = Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc;
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x19
    name = "Device"
.end annotation

.annotation system Ldalvik/annotation/MemberClasses;
    value = {
        Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$Device$Builder;
    }
.end annotation


# static fields
.field public static final IMEI_FIELD_NUMBER:I = 0x1

.field public static final MAC_FIELD_NUMBER:I = 0x2

.field public static PARSER:Lcom/google/protobuf/Parser;
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "Lcom/google/protobuf/Parser",
            "<",
            "Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$Device;",
            ">;"
        }
    .end annotation
.end field

.field private static final defaultInstance:Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$Device;

.field private static final serialVersionUID:J


# instance fields
.field private bitField0_:I

.field private imei_:Ljava/lang/Object;

.field private mac_:Ljava/lang/Object;

.field private memoizedIsInitialized:B

.field private memoizedSerializedSize:I

.field private final unknownFields:Lcom/google/protobuf/UnknownFieldSet;


# direct methods
.method static constructor <clinit>()V
    .locals 2

    .prologue
    .line 256
    new-instance v0, Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$Device$1;

    invoke-direct {v0}, Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$Device$1;-><init>()V

    sput-object v0, Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$Device;->PARSER:Lcom/google/protobuf/Parser;

    .line 758
    new-instance v0, Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$Device;

    const/4 v1, 0x1

    invoke-direct {v0, v1}, Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$Device;-><init>(Z)V

    sput-object v0, Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$Device;->defaultInstance:Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$Device;

    .line 759
    sget-object v0, Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$Device;->defaultInstance:Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$Device;

    invoke-direct {v0}, Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$Device;->initFields()V

    .line 760
    return-void
.end method

.method private constructor <init>(Lcom/google/protobuf/CodedInputStream;Lcom/google/protobuf/ExtensionRegistryLite;)V
    .locals 4
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Lcom/google/protobuf/InvalidProtocolBufferException;
        }
    .end annotation

    .prologue
    const/4 v1, 0x1

    const/4 v0, -0x1

    .line 202
    invoke-direct {p0}, Lcom/google/protobuf/GeneratedMessage;-><init>()V

    .line 362
    iput-byte v0, p0, Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$Device;->memoizedIsInitialized:B

    .line 383
    iput v0, p0, Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$Device;->memoizedSerializedSize:I

    .line 203
    invoke-direct {p0}, Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$Device;->initFields()V

    .line 206
    invoke-static {}, Lcom/google/protobuf/UnknownFieldSet;->newBuilder()Lcom/google/protobuf/UnknownFieldSet$Builder;

    move-result-object v2

    .line 208
    const/4 v0, 0x0

    .line 209
    :cond_0
    :goto_0
    if-nez v0, :cond_1

    .line 210
    :try_start_0
    invoke-virtual {p1}, Lcom/google/protobuf/CodedInputStream;->readTag()I

    move-result v3

    .line 211
    sparse-switch v3, :sswitch_data_0

    .line 216
    invoke-virtual {p0, p1, v2, p2, v3}, Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$Device;->parseUnknownField(Lcom/google/protobuf/CodedInputStream;Lcom/google/protobuf/UnknownFieldSet$Builder;Lcom/google/protobuf/ExtensionRegistryLite;I)Z

    move-result v3

    if-nez v3, :cond_0

    move v0, v1

    .line 218
    goto :goto_0

    :sswitch_0
    move v0, v1

    .line 214
    goto :goto_0

    .line 223
    :sswitch_1
    iget v3, p0, Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$Device;->bitField0_:I

    or-int/lit8 v3, v3, 0x1

    iput v3, p0, Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$Device;->bitField0_:I

    .line 224
    invoke-virtual {p1}, Lcom/google/protobuf/CodedInputStream;->readBytes()Lcom/google/protobuf/ByteString;

    move-result-object v3

    iput-object v3, p0, Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$Device;->imei_:Ljava/lang/Object;
    :try_end_0
    .catch Lcom/google/protobuf/InvalidProtocolBufferException; {:try_start_0 .. :try_end_0} :catch_0
    .catch Ljava/io/IOException; {:try_start_0 .. :try_end_0} :catch_1
    .catchall {:try_start_0 .. :try_end_0} :catchall_0

    goto :goto_0

    .line 234
    :catch_0
    move-exception v0

    .line 235
    :try_start_1
    invoke-virtual {v0, p0}, Lcom/google/protobuf/InvalidProtocolBufferException;->setUnfinishedMessage(Lcom/google/protobuf/MessageLite;)Lcom/google/protobuf/InvalidProtocolBufferException;

    move-result-object v0

    throw v0
    :try_end_1
    .catchall {:try_start_1 .. :try_end_1} :catchall_0

    .line 240
    :catchall_0
    move-exception v0

    invoke-virtual {v2}, Lcom/google/protobuf/UnknownFieldSet$Builder;->build()Lcom/google/protobuf/UnknownFieldSet;

    move-result-object v1

    iput-object v1, p0, Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$Device;->unknownFields:Lcom/google/protobuf/UnknownFieldSet;

    .line 241
    invoke-virtual {p0}, Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$Device;->makeExtensionsImmutable()V

    throw v0

    .line 228
    :sswitch_2
    :try_start_2
    iget v3, p0, Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$Device;->bitField0_:I

    or-int/lit8 v3, v3, 0x2

    iput v3, p0, Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$Device;->bitField0_:I

    .line 229
    invoke-virtual {p1}, Lcom/google/protobuf/CodedInputStream;->readBytes()Lcom/google/protobuf/ByteString;

    move-result-object v3

    iput-object v3, p0, Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$Device;->mac_:Ljava/lang/Object;
    :try_end_2
    .catch Lcom/google/protobuf/InvalidProtocolBufferException; {:try_start_2 .. :try_end_2} :catch_0
    .catch Ljava/io/IOException; {:try_start_2 .. :try_end_2} :catch_1
    .catchall {:try_start_2 .. :try_end_2} :catchall_0

    goto :goto_0

    .line 236
    :catch_1
    move-exception v0

    .line 237
    :try_start_3
    new-instance v1, Lcom/google/protobuf/InvalidProtocolBufferException;

    .line 238
    invoke-virtual {v0}, Ljava/io/IOException;->getMessage()Ljava/lang/String;

    move-result-object v0

    invoke-direct {v1, v0}, Lcom/google/protobuf/InvalidProtocolBufferException;-><init>(Ljava/lang/String;)V

    invoke-virtual {v1, p0}, Lcom/google/protobuf/InvalidProtocolBufferException;->setUnfinishedMessage(Lcom/google/protobuf/MessageLite;)Lcom/google/protobuf/InvalidProtocolBufferException;

    move-result-object v0

    throw v0
    :try_end_3
    .catchall {:try_start_3 .. :try_end_3} :catchall_0

    .line 240
    :cond_1
    invoke-virtual {v2}, Lcom/google/protobuf/UnknownFieldSet$Builder;->build()Lcom/google/protobuf/UnknownFieldSet;

    move-result-object v0

    iput-object v0, p0, Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$Device;->unknownFields:Lcom/google/protobuf/UnknownFieldSet;

    .line 241
    invoke-virtual {p0}, Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$Device;->makeExtensionsImmutable()V

    .line 243
    return-void

    .line 211
    :sswitch_data_0
    .sparse-switch
        0x0 -> :sswitch_0
        0xa -> :sswitch_1
        0x12 -> :sswitch_2
    .end sparse-switch
.end method

.method synthetic constructor <init>(Lcom/google/protobuf/CodedInputStream;Lcom/google/protobuf/ExtensionRegistryLite;Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$1;)V
    .locals 0
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Lcom/google/protobuf/InvalidProtocolBufferException;
        }
    .end annotation

    .prologue
    .line 174
    invoke-direct {p0, p1, p2}, Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$Device;-><init>(Lcom/google/protobuf/CodedInputStream;Lcom/google/protobuf/ExtensionRegistryLite;)V

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

    .line 179
    invoke-direct {p0, p1}, Lcom/google/protobuf/GeneratedMessage;-><init>(Lcom/google/protobuf/GeneratedMessage$Builder;)V

    .line 362
    iput-byte v0, p0, Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$Device;->memoizedIsInitialized:B

    .line 383
    iput v0, p0, Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$Device;->memoizedSerializedSize:I

    .line 180
    invoke-virtual {p1}, Lcom/google/protobuf/GeneratedMessage$Builder;->getUnknownFields()Lcom/google/protobuf/UnknownFieldSet;

    move-result-object v0

    iput-object v0, p0, Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$Device;->unknownFields:Lcom/google/protobuf/UnknownFieldSet;

    .line 181
    return-void
.end method

.method synthetic constructor <init>(Lcom/google/protobuf/GeneratedMessage$Builder;Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$1;)V
    .locals 0

    .prologue
    .line 174
    invoke-direct {p0, p1}, Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$Device;-><init>(Lcom/google/protobuf/GeneratedMessage$Builder;)V

    return-void
.end method

.method private constructor <init>(Z)V
    .locals 1

    .prologue
    const/4 v0, -0x1

    .line 182
    invoke-direct {p0}, Lcom/google/protobuf/GeneratedMessage;-><init>()V

    .line 362
    iput-byte v0, p0, Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$Device;->memoizedIsInitialized:B

    .line 383
    iput v0, p0, Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$Device;->memoizedSerializedSize:I

    .line 182
    invoke-static {}, Lcom/google/protobuf/UnknownFieldSet;->getDefaultInstance()Lcom/google/protobuf/UnknownFieldSet;

    move-result-object v0

    iput-object v0, p0, Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$Device;->unknownFields:Lcom/google/protobuf/UnknownFieldSet;

    return-void
.end method

.method static synthetic access$500()Z
    .locals 1

    .prologue
    .line 174
    sget-boolean v0, Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$Device;->alwaysUseFieldBuilders:Z

    return v0
.end method

.method static synthetic access$700(Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$Device;)Ljava/lang/Object;
    .locals 1

    .prologue
    .line 174
    iget-object v0, p0, Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$Device;->imei_:Ljava/lang/Object;

    return-object v0
.end method

.method static synthetic access$702(Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$Device;Ljava/lang/Object;)Ljava/lang/Object;
    .locals 0

    .prologue
    .line 174
    iput-object p1, p0, Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$Device;->imei_:Ljava/lang/Object;

    return-object p1
.end method

.method static synthetic access$800(Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$Device;)Ljava/lang/Object;
    .locals 1

    .prologue
    .line 174
    iget-object v0, p0, Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$Device;->mac_:Ljava/lang/Object;

    return-object v0
.end method

.method static synthetic access$802(Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$Device;Ljava/lang/Object;)Ljava/lang/Object;
    .locals 0

    .prologue
    .line 174
    iput-object p1, p0, Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$Device;->mac_:Ljava/lang/Object;

    return-object p1
.end method

.method static synthetic access$902(Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$Device;I)I
    .locals 0

    .prologue
    .line 174
    iput p1, p0, Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$Device;->bitField0_:I

    return p1
.end method

.method public static getDefaultInstance()Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$Device;
    .locals 1

    .prologue
    .line 186
    sget-object v0, Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$Device;->defaultInstance:Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$Device;

    return-object v0
.end method

.method public static final getDescriptor()Lcom/google/protobuf/Descriptors$Descriptor;
    .locals 1

    .prologue
    .line 246
    invoke-static {}, Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc;->access$000()Lcom/google/protobuf/Descriptors$Descriptor;

    move-result-object v0

    return-object v0
.end method

.method private initFields()V
    .locals 1

    .prologue
    .line 359
    const-string v0, ""

    iput-object v0, p0, Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$Device;->imei_:Ljava/lang/Object;

    .line 360
    const-string v0, ""

    iput-object v0, p0, Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$Device;->mac_:Ljava/lang/Object;

    .line 361
    return-void
.end method

.method public static newBuilder()Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$Device$Builder;
    .locals 1

    .prologue
    .line 462
    invoke-static {}, Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$Device$Builder;->access$300()Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$Device$Builder;

    move-result-object v0

    return-object v0
.end method

.method public static newBuilder(Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$Device;)Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$Device$Builder;
    .locals 1

    .prologue
    .line 465
    invoke-static {}, Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$Device;->newBuilder()Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$Device$Builder;

    move-result-object v0

    invoke-virtual {v0, p0}, Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$Device$Builder;->mergeFrom(Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$Device;)Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$Device$Builder;

    move-result-object v0

    return-object v0
.end method

.method public static parseDelimitedFrom(Ljava/io/InputStream;)Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$Device;
    .locals 1
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljava/io/IOException;
        }
    .end annotation

    .prologue
    .line 442
    sget-object v0, Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$Device;->PARSER:Lcom/google/protobuf/Parser;

    invoke-interface {v0, p0}, Lcom/google/protobuf/Parser;->parseDelimitedFrom(Ljava/io/InputStream;)Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$Device;

    return-object v0
.end method

.method public static parseDelimitedFrom(Ljava/io/InputStream;Lcom/google/protobuf/ExtensionRegistryLite;)Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$Device;
    .locals 1
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljava/io/IOException;
        }
    .end annotation

    .prologue
    .line 448
    sget-object v0, Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$Device;->PARSER:Lcom/google/protobuf/Parser;

    invoke-interface {v0, p0, p1}, Lcom/google/protobuf/Parser;->parseDelimitedFrom(Ljava/io/InputStream;Lcom/google/protobuf/ExtensionRegistryLite;)Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$Device;

    return-object v0
.end method

.method public static parseFrom(Lcom/google/protobuf/ByteString;)Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$Device;
    .locals 1
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Lcom/google/protobuf/InvalidProtocolBufferException;
        }
    .end annotation

    .prologue
    .line 412
    sget-object v0, Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$Device;->PARSER:Lcom/google/protobuf/Parser;

    invoke-interface {v0, p0}, Lcom/google/protobuf/Parser;->parseFrom(Lcom/google/protobuf/ByteString;)Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$Device;

    return-object v0
.end method

.method public static parseFrom(Lcom/google/protobuf/ByteString;Lcom/google/protobuf/ExtensionRegistryLite;)Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$Device;
    .locals 1
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Lcom/google/protobuf/InvalidProtocolBufferException;
        }
    .end annotation

    .prologue
    .line 418
    sget-object v0, Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$Device;->PARSER:Lcom/google/protobuf/Parser;

    invoke-interface {v0, p0, p1}, Lcom/google/protobuf/Parser;->parseFrom(Lcom/google/protobuf/ByteString;Lcom/google/protobuf/ExtensionRegistryLite;)Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$Device;

    return-object v0
.end method

.method public static parseFrom(Lcom/google/protobuf/CodedInputStream;)Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$Device;
    .locals 1
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljava/io/IOException;
        }
    .end annotation

    .prologue
    .line 453
    sget-object v0, Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$Device;->PARSER:Lcom/google/protobuf/Parser;

    invoke-interface {v0, p0}, Lcom/google/protobuf/Parser;->parseFrom(Lcom/google/protobuf/CodedInputStream;)Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$Device;

    return-object v0
.end method

.method public static parseFrom(Lcom/google/protobuf/CodedInputStream;Lcom/google/protobuf/ExtensionRegistryLite;)Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$Device;
    .locals 1
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljava/io/IOException;
        }
    .end annotation

    .prologue
    .line 459
    sget-object v0, Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$Device;->PARSER:Lcom/google/protobuf/Parser;

    invoke-interface {v0, p0, p1}, Lcom/google/protobuf/Parser;->parseFrom(Lcom/google/protobuf/CodedInputStream;Lcom/google/protobuf/ExtensionRegistryLite;)Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$Device;

    return-object v0
.end method

.method public static parseFrom(Ljava/io/InputStream;)Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$Device;
    .locals 1
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljava/io/IOException;
        }
    .end annotation

    .prologue
    .line 432
    sget-object v0, Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$Device;->PARSER:Lcom/google/protobuf/Parser;

    invoke-interface {v0, p0}, Lcom/google/protobuf/Parser;->parseFrom(Ljava/io/InputStream;)Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$Device;

    return-object v0
.end method

.method public static parseFrom(Ljava/io/InputStream;Lcom/google/protobuf/ExtensionRegistryLite;)Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$Device;
    .locals 1
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljava/io/IOException;
        }
    .end annotation

    .prologue
    .line 438
    sget-object v0, Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$Device;->PARSER:Lcom/google/protobuf/Parser;

    invoke-interface {v0, p0, p1}, Lcom/google/protobuf/Parser;->parseFrom(Ljava/io/InputStream;Lcom/google/protobuf/ExtensionRegistryLite;)Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$Device;

    return-object v0
.end method

.method public static parseFrom([B)Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$Device;
    .locals 1
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Lcom/google/protobuf/InvalidProtocolBufferException;
        }
    .end annotation

    .prologue
    .line 422
    sget-object v0, Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$Device;->PARSER:Lcom/google/protobuf/Parser;

    invoke-interface {v0, p0}, Lcom/google/protobuf/Parser;->parseFrom([B)Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$Device;

    return-object v0
.end method

.method public static parseFrom([BLcom/google/protobuf/ExtensionRegistryLite;)Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$Device;
    .locals 1
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Lcom/google/protobuf/InvalidProtocolBufferException;
        }
    .end annotation

    .prologue
    .line 428
    sget-object v0, Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$Device;->PARSER:Lcom/google/protobuf/Parser;

    invoke-interface {v0, p0, p1}, Lcom/google/protobuf/Parser;->parseFrom([BLcom/google/protobuf/ExtensionRegistryLite;)Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$Device;

    return-object v0
.end method


# virtual methods
.method public getDefaultInstanceForType()Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$Device;
    .locals 1

    .prologue
    .line 190
    sget-object v0, Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$Device;->defaultInstance:Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$Device;

    return-object v0
.end method

.method public bridge synthetic getDefaultInstanceForType()Lcom/google/protobuf/Message;
    .locals 1

    .prologue
    .line 174
    invoke-virtual {p0}, Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$Device;->getDefaultInstanceForType()Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$Device;

    move-result-object v0

    return-object v0
.end method

.method public bridge synthetic getDefaultInstanceForType()Lcom/google/protobuf/MessageLite;
    .locals 1

    .prologue
    .line 174
    invoke-virtual {p0}, Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$Device;->getDefaultInstanceForType()Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$Device;

    move-result-object v0

    return-object v0
.end method

.method public getImei()Ljava/lang/String;
    .locals 2

    .prologue
    .line 285
    iget-object v0, p0, Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$Device;->imei_:Ljava/lang/Object;

    .line 286
    instance-of v1, v0, Ljava/lang/String;

    if-eqz v1, :cond_0

    .line 287
    check-cast v0, Ljava/lang/String;

    .line 295
    :goto_0
    return-object v0

    .line 289
    :cond_0
    check-cast v0, Lcom/google/protobuf/ByteString;

    .line 291
    invoke-virtual {v0}, Lcom/google/protobuf/ByteString;->toStringUtf8()Ljava/lang/String;

    move-result-object v1

    .line 292
    invoke-virtual {v0}, Lcom/google/protobuf/ByteString;->isValidUtf8()Z

    move-result v0

    if-eqz v0, :cond_1

    .line 293
    iput-object v1, p0, Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$Device;->imei_:Ljava/lang/Object;

    :cond_1
    move-object v0, v1

    .line 295
    goto :goto_0
.end method

.method public getImeiBytes()Lcom/google/protobuf/ByteString;
    .locals 2

    .prologue
    .line 303
    iget-object v0, p0, Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$Device;->imei_:Ljava/lang/Object;

    .line 304
    instance-of v1, v0, Ljava/lang/String;

    if-eqz v1, :cond_0

    .line 305
    check-cast v0, Ljava/lang/String;

    .line 306
    invoke-static {v0}, Lcom/google/protobuf/ByteString;->copyFromUtf8(Ljava/lang/String;)Lcom/google/protobuf/ByteString;

    move-result-object v0

    .line 308
    iput-object v0, p0, Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$Device;->imei_:Ljava/lang/Object;

    .line 311
    :goto_0
    return-object v0

    :cond_0
    check-cast v0, Lcom/google/protobuf/ByteString;

    goto :goto_0
.end method

.method public getMac()Ljava/lang/String;
    .locals 2

    .prologue
    .line 328
    iget-object v0, p0, Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$Device;->mac_:Ljava/lang/Object;

    .line 329
    instance-of v1, v0, Ljava/lang/String;

    if-eqz v1, :cond_0

    .line 330
    check-cast v0, Ljava/lang/String;

    .line 338
    :goto_0
    return-object v0

    .line 332
    :cond_0
    check-cast v0, Lcom/google/protobuf/ByteString;

    .line 334
    invoke-virtual {v0}, Lcom/google/protobuf/ByteString;->toStringUtf8()Ljava/lang/String;

    move-result-object v1

    .line 335
    invoke-virtual {v0}, Lcom/google/protobuf/ByteString;->isValidUtf8()Z

    move-result v0

    if-eqz v0, :cond_1

    .line 336
    iput-object v1, p0, Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$Device;->mac_:Ljava/lang/Object;

    :cond_1
    move-object v0, v1

    .line 338
    goto :goto_0
.end method

.method public getMacBytes()Lcom/google/protobuf/ByteString;
    .locals 2

    .prologue
    .line 346
    iget-object v0, p0, Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$Device;->mac_:Ljava/lang/Object;

    .line 347
    instance-of v1, v0, Ljava/lang/String;

    if-eqz v1, :cond_0

    .line 348
    check-cast v0, Ljava/lang/String;

    .line 349
    invoke-static {v0}, Lcom/google/protobuf/ByteString;->copyFromUtf8(Ljava/lang/String;)Lcom/google/protobuf/ByteString;

    move-result-object v0

    .line 351
    iput-object v0, p0, Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$Device;->mac_:Ljava/lang/Object;

    .line 354
    :goto_0
    return-object v0

    :cond_0
    check-cast v0, Lcom/google/protobuf/ByteString;

    goto :goto_0
.end method

.method public getParserForType()Lcom/google/protobuf/Parser;
    .locals 1
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "()",
            "Lcom/google/protobuf/Parser",
            "<",
            "Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$Device;",
            ">;"
        }
    .end annotation

    .prologue
    .line 268
    sget-object v0, Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$Device;->PARSER:Lcom/google/protobuf/Parser;

    return-object v0
.end method

.method public getSerializedSize()I
    .locals 4

    .prologue
    const/4 v3, 0x2

    const/4 v2, 0x1

    .line 385
    iget v0, p0, Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$Device;->memoizedSerializedSize:I

    .line 386
    const/4 v1, -0x1

    if-eq v0, v1, :cond_0

    .line 399
    :goto_0
    return v0

    .line 388
    :cond_0
    const/4 v0, 0x0

    .line 389
    iget v1, p0, Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$Device;->bitField0_:I

    and-int/lit8 v1, v1, 0x1

    if-ne v1, v2, :cond_1

    .line 391
    invoke-virtual {p0}, Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$Device;->getImeiBytes()Lcom/google/protobuf/ByteString;

    move-result-object v1

    invoke-static {v2, v1}, Lcom/google/protobuf/CodedOutputStream;->computeBytesSize(ILcom/google/protobuf/ByteString;)I

    move-result v1

    add-int/2addr v0, v1

    .line 393
    :cond_1
    iget v1, p0, Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$Device;->bitField0_:I

    and-int/lit8 v1, v1, 0x2

    if-ne v1, v3, :cond_2

    .line 395
    invoke-virtual {p0}, Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$Device;->getMacBytes()Lcom/google/protobuf/ByteString;

    move-result-object v1

    invoke-static {v3, v1}, Lcom/google/protobuf/CodedOutputStream;->computeBytesSize(ILcom/google/protobuf/ByteString;)I

    move-result v1

    add-int/2addr v0, v1

    .line 397
    :cond_2
    invoke-virtual {p0}, Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$Device;->getUnknownFields()Lcom/google/protobuf/UnknownFieldSet;

    move-result-object v1

    invoke-virtual {v1}, Lcom/google/protobuf/UnknownFieldSet;->getSerializedSize()I

    move-result v1

    add-int/2addr v0, v1

    .line 398
    iput v0, p0, Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$Device;->memoizedSerializedSize:I

    goto :goto_0
.end method

.method public final getUnknownFields()Lcom/google/protobuf/UnknownFieldSet;
    .locals 1

    .prologue
    .line 197
    iget-object v0, p0, Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$Device;->unknownFields:Lcom/google/protobuf/UnknownFieldSet;

    return-object v0
.end method

.method public hasImei()Z
    .locals 2

    .prologue
    const/4 v0, 0x1

    .line 279
    iget v1, p0, Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$Device;->bitField0_:I

    and-int/lit8 v1, v1, 0x1

    if-ne v1, v0, :cond_0

    :goto_0
    return v0

    :cond_0
    const/4 v0, 0x0

    goto :goto_0
.end method

.method public hasMac()Z
    .locals 2

    .prologue
    .line 322
    iget v0, p0, Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$Device;->bitField0_:I

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
    .line 251
    invoke-static {}, Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc;->access$100()Lcom/google/protobuf/GeneratedMessage$FieldAccessorTable;

    move-result-object v0

    const-class v1, Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$Device;

    const-class v2, Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$Device$Builder;

    .line 252
    invoke-virtual {v0, v1, v2}, Lcom/google/protobuf/GeneratedMessage$FieldAccessorTable;->ensureFieldAccessorsInitialized(Ljava/lang/Class;Ljava/lang/Class;)Lcom/google/protobuf/GeneratedMessage$FieldAccessorTable;

    move-result-object v0

    .line 251
    return-object v0
.end method

.method public final isInitialized()Z
    .locals 3

    .prologue
    const/4 v0, 0x1

    .line 364
    iget-byte v1, p0, Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$Device;->memoizedIsInitialized:B

    .line 365
    const/4 v2, -0x1

    if-eq v1, v2, :cond_1

    if-ne v1, v0, :cond_0

    .line 368
    :goto_0
    return v0

    .line 365
    :cond_0
    const/4 v0, 0x0

    goto :goto_0

    .line 367
    :cond_1
    iput-byte v0, p0, Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$Device;->memoizedIsInitialized:B

    goto :goto_0
.end method

.method public newBuilderForType()Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$Device$Builder;
    .locals 1

    .prologue
    .line 463
    invoke-static {}, Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$Device;->newBuilder()Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$Device$Builder;

    move-result-object v0

    return-object v0
.end method

.method protected newBuilderForType(Lcom/google/protobuf/GeneratedMessage$BuilderParent;)Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$Device$Builder;
    .locals 2

    .prologue
    .line 472
    new-instance v0, Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$Device$Builder;

    const/4 v1, 0x0

    invoke-direct {v0, p1, v1}, Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$Device$Builder;-><init>(Lcom/google/protobuf/GeneratedMessage$BuilderParent;Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$1;)V

    .line 473
    return-object v0
.end method

.method public bridge synthetic newBuilderForType()Lcom/google/protobuf/Message$Builder;
    .locals 1

    .prologue
    .line 174
    invoke-virtual {p0}, Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$Device;->newBuilderForType()Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$Device$Builder;

    move-result-object v0

    return-object v0
.end method

.method protected bridge synthetic newBuilderForType(Lcom/google/protobuf/GeneratedMessage$BuilderParent;)Lcom/google/protobuf/Message$Builder;
    .locals 1

    .prologue
    .line 174
    invoke-virtual {p0, p1}, Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$Device;->newBuilderForType(Lcom/google/protobuf/GeneratedMessage$BuilderParent;)Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$Device$Builder;

    move-result-object v0

    return-object v0
.end method

.method public bridge synthetic newBuilderForType()Lcom/google/protobuf/MessageLite$Builder;
    .locals 1

    .prologue
    .line 174
    invoke-virtual {p0}, Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$Device;->newBuilderForType()Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$Device$Builder;

    move-result-object v0

    return-object v0
.end method

.method public toBuilder()Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$Device$Builder;
    .locals 1

    .prologue
    .line 467
    invoke-static {p0}, Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$Device;->newBuilder(Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$Device;)Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$Device$Builder;

    move-result-object v0

    return-object v0
.end method

.method public bridge synthetic toBuilder()Lcom/google/protobuf/Message$Builder;
    .locals 1

    .prologue
    .line 174
    invoke-virtual {p0}, Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$Device;->toBuilder()Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$Device$Builder;

    move-result-object v0

    return-object v0
.end method

.method public bridge synthetic toBuilder()Lcom/google/protobuf/MessageLite$Builder;
    .locals 1

    .prologue
    .line 174
    invoke-virtual {p0}, Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$Device;->toBuilder()Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$Device$Builder;

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
    .line 406
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

    .line 373
    invoke-virtual {p0}, Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$Device;->getSerializedSize()I

    .line 374
    iget v0, p0, Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$Device;->bitField0_:I

    and-int/lit8 v0, v0, 0x1

    if-ne v0, v1, :cond_0

    .line 375
    invoke-virtual {p0}, Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$Device;->getImeiBytes()Lcom/google/protobuf/ByteString;

    move-result-object v0

    invoke-virtual {p1, v1, v0}, Lcom/google/protobuf/CodedOutputStream;->writeBytes(ILcom/google/protobuf/ByteString;)V

    .line 377
    :cond_0
    iget v0, p0, Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$Device;->bitField0_:I

    and-int/lit8 v0, v0, 0x2

    if-ne v0, v2, :cond_1

    .line 378
    invoke-virtual {p0}, Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$Device;->getMacBytes()Lcom/google/protobuf/ByteString;

    move-result-object v0

    invoke-virtual {p1, v2, v0}, Lcom/google/protobuf/CodedOutputStream;->writeBytes(ILcom/google/protobuf/ByteString;)V

    .line 380
    :cond_1
    invoke-virtual {p0}, Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$Device;->getUnknownFields()Lcom/google/protobuf/UnknownFieldSet;

    move-result-object v0

    invoke-virtual {v0, p1}, Lcom/google/protobuf/UnknownFieldSet;->writeTo(Lcom/google/protobuf/CodedOutputStream;)V

    .line 381
    return-void
.end method
