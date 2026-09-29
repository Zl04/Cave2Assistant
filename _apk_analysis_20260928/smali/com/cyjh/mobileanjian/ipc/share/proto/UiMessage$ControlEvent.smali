.class public final Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$ControlEvent;
.super Lcom/google/protobuf/GeneratedMessage;
.source "SourceFile"

# interfaces
.implements Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$ControlEventOrBuilder;


# annotations
.annotation system Ldalvik/annotation/EnclosingClass;
    value = Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage;
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x19
    name = "ControlEvent"
.end annotation

.annotation system Ldalvik/annotation/MemberClasses;
    value = {
        Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$ControlEvent$Builder;,
        Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$ControlEvent$Event_Type;
    }
.end annotation


# static fields
.field public static final CONTROL_ID_FIELD_NUMBER:I = 0x1

.field public static final EVENT_ARGS_FIELD_NUMBER:I = 0x3

.field public static final EVENT_FUNCTION_NAME_FIELD_NUMBER:I = 0x4

.field public static PARSER:Lcom/google/protobuf/Parser; = null
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "Lcom/google/protobuf/Parser",
            "<",
            "Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$ControlEvent;",
            ">;"
        }
    .end annotation
.end field

.field public static final TYPE_FIELD_NUMBER:I = 0x2

.field private static final defaultInstance:Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$ControlEvent;

.field private static final serialVersionUID:J


# instance fields
.field private bitField0_:I

.field private controlId_:Ljava/lang/Object;

.field private eventArgs_:Ljava/lang/Object;

.field private eventFunctionName_:Ljava/lang/Object;

.field private memoizedIsInitialized:B

.field private memoizedSerializedSize:I

.field private type_:Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$ControlEvent$Event_Type;

.field private final unknownFields:Lcom/google/protobuf/UnknownFieldSet;


# direct methods
.method static constructor <clinit>()V
    .locals 2

    .prologue
    .line 4430
    new-instance v0, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$ControlEvent$1;

    invoke-direct {v0}, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$ControlEvent$1;-><init>()V

    sput-object v0, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$ControlEvent;->PARSER:Lcom/google/protobuf/Parser;

    .line 5298
    new-instance v0, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$ControlEvent;

    const/4 v1, 0x1

    invoke-direct {v0, v1}, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$ControlEvent;-><init>(Z)V

    sput-object v0, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$ControlEvent;->defaultInstance:Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$ControlEvent;

    .line 5299
    sget-object v0, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$ControlEvent;->defaultInstance:Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$ControlEvent;

    invoke-direct {v0}, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$ControlEvent;->initFields()V

    .line 5300
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

    .line 4360
    invoke-direct {p0}, Lcom/google/protobuf/GeneratedMessage;-><init>()V

    .line 4718
    iput-byte v0, p0, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$ControlEvent;->memoizedIsInitialized:B

    .line 4753
    iput v0, p0, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$ControlEvent;->memoizedSerializedSize:I

    .line 4361
    invoke-direct {p0}, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$ControlEvent;->initFields()V

    .line 4364
    invoke-static {}, Lcom/google/protobuf/UnknownFieldSet;->newBuilder()Lcom/google/protobuf/UnknownFieldSet$Builder;

    move-result-object v2

    .line 4366
    const/4 v0, 0x0

    .line 4367
    :cond_0
    :goto_0
    if-nez v0, :cond_2

    .line 4368
    :try_start_0
    invoke-virtual {p1}, Lcom/google/protobuf/CodedInputStream;->readTag()I

    move-result v3

    .line 4369
    sparse-switch v3, :sswitch_data_0

    .line 4374
    invoke-virtual {p0, p1, v2, p2, v3}, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$ControlEvent;->parseUnknownField(Lcom/google/protobuf/CodedInputStream;Lcom/google/protobuf/UnknownFieldSet$Builder;Lcom/google/protobuf/ExtensionRegistryLite;I)Z

    move-result v3

    if-nez v3, :cond_0

    move v0, v1

    .line 4376
    goto :goto_0

    :sswitch_0
    move v0, v1

    .line 4372
    goto :goto_0

    .line 4381
    :sswitch_1
    iget v3, p0, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$ControlEvent;->bitField0_:I

    or-int/lit8 v3, v3, 0x1

    iput v3, p0, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$ControlEvent;->bitField0_:I

    .line 4382
    invoke-virtual {p1}, Lcom/google/protobuf/CodedInputStream;->readBytes()Lcom/google/protobuf/ByteString;

    move-result-object v3

    iput-object v3, p0, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$ControlEvent;->controlId_:Ljava/lang/Object;
    :try_end_0
    .catch Lcom/google/protobuf/InvalidProtocolBufferException; {:try_start_0 .. :try_end_0} :catch_0
    .catch Ljava/io/IOException; {:try_start_0 .. :try_end_0} :catch_1
    .catchall {:try_start_0 .. :try_end_0} :catchall_0

    goto :goto_0

    .line 4408
    :catch_0
    move-exception v0

    .line 4409
    :try_start_1
    invoke-virtual {v0, p0}, Lcom/google/protobuf/InvalidProtocolBufferException;->setUnfinishedMessage(Lcom/google/protobuf/MessageLite;)Lcom/google/protobuf/InvalidProtocolBufferException;

    move-result-object v0

    throw v0
    :try_end_1
    .catchall {:try_start_1 .. :try_end_1} :catchall_0

    .line 4414
    :catchall_0
    move-exception v0

    invoke-virtual {v2}, Lcom/google/protobuf/UnknownFieldSet$Builder;->build()Lcom/google/protobuf/UnknownFieldSet;

    move-result-object v1

    iput-object v1, p0, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$ControlEvent;->unknownFields:Lcom/google/protobuf/UnknownFieldSet;

    .line 4415
    invoke-virtual {p0}, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$ControlEvent;->makeExtensionsImmutable()V

    throw v0

    .line 4386
    :sswitch_2
    :try_start_2
    invoke-virtual {p1}, Lcom/google/protobuf/CodedInputStream;->readEnum()I

    move-result v3

    .line 4387
    invoke-static {v3}, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$ControlEvent$Event_Type;->valueOf(I)Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$ControlEvent$Event_Type;

    move-result-object v4

    .line 4388
    if-nez v4, :cond_1

    .line 4389
    const/4 v4, 0x2

    invoke-virtual {v2, v4, v3}, Lcom/google/protobuf/UnknownFieldSet$Builder;->mergeVarintField(II)Lcom/google/protobuf/UnknownFieldSet$Builder;
    :try_end_2
    .catch Lcom/google/protobuf/InvalidProtocolBufferException; {:try_start_2 .. :try_end_2} :catch_0
    .catch Ljava/io/IOException; {:try_start_2 .. :try_end_2} :catch_1
    .catchall {:try_start_2 .. :try_end_2} :catchall_0

    goto :goto_0

    .line 4410
    :catch_1
    move-exception v0

    .line 4411
    :try_start_3
    new-instance v1, Lcom/google/protobuf/InvalidProtocolBufferException;

    .line 4412
    invoke-virtual {v0}, Ljava/io/IOException;->getMessage()Ljava/lang/String;

    move-result-object v0

    invoke-direct {v1, v0}, Lcom/google/protobuf/InvalidProtocolBufferException;-><init>(Ljava/lang/String;)V

    invoke-virtual {v1, p0}, Lcom/google/protobuf/InvalidProtocolBufferException;->setUnfinishedMessage(Lcom/google/protobuf/MessageLite;)Lcom/google/protobuf/InvalidProtocolBufferException;

    move-result-object v0

    throw v0
    :try_end_3
    .catchall {:try_start_3 .. :try_end_3} :catchall_0

    .line 4391
    :cond_1
    :try_start_4
    iget v3, p0, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$ControlEvent;->bitField0_:I

    or-int/lit8 v3, v3, 0x2

    iput v3, p0, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$ControlEvent;->bitField0_:I

    .line 4392
    iput-object v4, p0, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$ControlEvent;->type_:Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$ControlEvent$Event_Type;

    goto :goto_0

    .line 4397
    :sswitch_3
    iget v3, p0, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$ControlEvent;->bitField0_:I

    or-int/lit8 v3, v3, 0x4

    iput v3, p0, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$ControlEvent;->bitField0_:I

    .line 4398
    invoke-virtual {p1}, Lcom/google/protobuf/CodedInputStream;->readBytes()Lcom/google/protobuf/ByteString;

    move-result-object v3

    iput-object v3, p0, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$ControlEvent;->eventArgs_:Ljava/lang/Object;

    goto :goto_0

    .line 4402
    :sswitch_4
    iget v3, p0, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$ControlEvent;->bitField0_:I

    or-int/lit8 v3, v3, 0x8

    iput v3, p0, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$ControlEvent;->bitField0_:I

    .line 4403
    invoke-virtual {p1}, Lcom/google/protobuf/CodedInputStream;->readBytes()Lcom/google/protobuf/ByteString;

    move-result-object v3

    iput-object v3, p0, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$ControlEvent;->eventFunctionName_:Ljava/lang/Object;
    :try_end_4
    .catch Lcom/google/protobuf/InvalidProtocolBufferException; {:try_start_4 .. :try_end_4} :catch_0
    .catch Ljava/io/IOException; {:try_start_4 .. :try_end_4} :catch_1
    .catchall {:try_start_4 .. :try_end_4} :catchall_0

    goto :goto_0

    .line 4414
    :cond_2
    invoke-virtual {v2}, Lcom/google/protobuf/UnknownFieldSet$Builder;->build()Lcom/google/protobuf/UnknownFieldSet;

    move-result-object v0

    iput-object v0, p0, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$ControlEvent;->unknownFields:Lcom/google/protobuf/UnknownFieldSet;

    .line 4415
    invoke-virtual {p0}, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$ControlEvent;->makeExtensionsImmutable()V

    .line 4417
    return-void

    .line 4369
    nop

    :sswitch_data_0
    .sparse-switch
        0x0 -> :sswitch_0
        0xa -> :sswitch_1
        0x10 -> :sswitch_2
        0x1a -> :sswitch_3
        0x22 -> :sswitch_4
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
    .line 4332
    invoke-direct {p0, p1, p2}, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$ControlEvent;-><init>(Lcom/google/protobuf/CodedInputStream;Lcom/google/protobuf/ExtensionRegistryLite;)V

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

    .line 4337
    invoke-direct {p0, p1}, Lcom/google/protobuf/GeneratedMessage;-><init>(Lcom/google/protobuf/GeneratedMessage$Builder;)V

    .line 4718
    iput-byte v0, p0, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$ControlEvent;->memoizedIsInitialized:B

    .line 4753
    iput v0, p0, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$ControlEvent;->memoizedSerializedSize:I

    .line 4338
    invoke-virtual {p1}, Lcom/google/protobuf/GeneratedMessage$Builder;->getUnknownFields()Lcom/google/protobuf/UnknownFieldSet;

    move-result-object v0

    iput-object v0, p0, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$ControlEvent;->unknownFields:Lcom/google/protobuf/UnknownFieldSet;

    .line 4339
    return-void
.end method

.method synthetic constructor <init>(Lcom/google/protobuf/GeneratedMessage$Builder;Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$1;)V
    .locals 0

    .prologue
    .line 4332
    invoke-direct {p0, p1}, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$ControlEvent;-><init>(Lcom/google/protobuf/GeneratedMessage$Builder;)V

    return-void
.end method

.method private constructor <init>(Z)V
    .locals 1

    .prologue
    const/4 v0, -0x1

    .line 4340
    invoke-direct {p0}, Lcom/google/protobuf/GeneratedMessage;-><init>()V

    .line 4718
    iput-byte v0, p0, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$ControlEvent;->memoizedIsInitialized:B

    .line 4753
    iput v0, p0, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$ControlEvent;->memoizedSerializedSize:I

    .line 4340
    invoke-static {}, Lcom/google/protobuf/UnknownFieldSet;->getDefaultInstance()Lcom/google/protobuf/UnknownFieldSet;

    move-result-object v0

    iput-object v0, p0, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$ControlEvent;->unknownFields:Lcom/google/protobuf/UnknownFieldSet;

    return-void
.end method

.method static synthetic access$4700()Z
    .locals 1

    .prologue
    .line 4332
    sget-boolean v0, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$ControlEvent;->alwaysUseFieldBuilders:Z

    return v0
.end method

.method static synthetic access$4900(Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$ControlEvent;)Ljava/lang/Object;
    .locals 1

    .prologue
    .line 4332
    iget-object v0, p0, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$ControlEvent;->controlId_:Ljava/lang/Object;

    return-object v0
.end method

.method static synthetic access$4902(Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$ControlEvent;Ljava/lang/Object;)Ljava/lang/Object;
    .locals 0

    .prologue
    .line 4332
    iput-object p1, p0, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$ControlEvent;->controlId_:Ljava/lang/Object;

    return-object p1
.end method

.method static synthetic access$5002(Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$ControlEvent;Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$ControlEvent$Event_Type;)Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$ControlEvent$Event_Type;
    .locals 0

    .prologue
    .line 4332
    iput-object p1, p0, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$ControlEvent;->type_:Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$ControlEvent$Event_Type;

    return-object p1
.end method

.method static synthetic access$5100(Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$ControlEvent;)Ljava/lang/Object;
    .locals 1

    .prologue
    .line 4332
    iget-object v0, p0, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$ControlEvent;->eventArgs_:Ljava/lang/Object;

    return-object v0
.end method

.method static synthetic access$5102(Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$ControlEvent;Ljava/lang/Object;)Ljava/lang/Object;
    .locals 0

    .prologue
    .line 4332
    iput-object p1, p0, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$ControlEvent;->eventArgs_:Ljava/lang/Object;

    return-object p1
.end method

.method static synthetic access$5200(Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$ControlEvent;)Ljava/lang/Object;
    .locals 1

    .prologue
    .line 4332
    iget-object v0, p0, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$ControlEvent;->eventFunctionName_:Ljava/lang/Object;

    return-object v0
.end method

.method static synthetic access$5202(Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$ControlEvent;Ljava/lang/Object;)Ljava/lang/Object;
    .locals 0

    .prologue
    .line 4332
    iput-object p1, p0, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$ControlEvent;->eventFunctionName_:Ljava/lang/Object;

    return-object p1
.end method

.method static synthetic access$5302(Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$ControlEvent;I)I
    .locals 0

    .prologue
    .line 4332
    iput p1, p0, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$ControlEvent;->bitField0_:I

    return p1
.end method

.method public static getDefaultInstance()Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$ControlEvent;
    .locals 1

    .prologue
    .line 4344
    sget-object v0, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$ControlEvent;->defaultInstance:Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$ControlEvent;

    return-object v0
.end method

.method public static final getDescriptor()Lcom/google/protobuf/Descriptors$Descriptor;
    .locals 1

    .prologue
    .line 4420
    invoke-static {}, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage;->f()Lcom/google/protobuf/Descriptors$Descriptor;

    move-result-object v0

    return-object v0
.end method

.method private initFields()V
    .locals 1

    .prologue
    .line 4713
    const-string v0, ""

    iput-object v0, p0, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$ControlEvent;->controlId_:Ljava/lang/Object;

    .line 4714
    sget-object v0, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$ControlEvent$Event_Type;->ON_CHANGE:Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$ControlEvent$Event_Type;

    iput-object v0, p0, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$ControlEvent;->type_:Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$ControlEvent$Event_Type;

    .line 4715
    const-string v0, ""

    iput-object v0, p0, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$ControlEvent;->eventArgs_:Ljava/lang/Object;

    .line 4716
    const-string v0, ""

    iput-object v0, p0, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$ControlEvent;->eventFunctionName_:Ljava/lang/Object;

    .line 4717
    return-void
.end method

.method public static newBuilder()Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$ControlEvent$Builder;
    .locals 1

    .prologue
    .line 4840
    invoke-static {}, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$ControlEvent$Builder;->access$4500()Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$ControlEvent$Builder;

    move-result-object v0

    return-object v0
.end method

.method public static newBuilder(Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$ControlEvent;)Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$ControlEvent$Builder;
    .locals 1

    .prologue
    .line 4843
    invoke-static {}, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$ControlEvent;->newBuilder()Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$ControlEvent$Builder;

    move-result-object v0

    invoke-virtual {v0, p0}, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$ControlEvent$Builder;->mergeFrom(Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$ControlEvent;)Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$ControlEvent$Builder;

    move-result-object v0

    return-object v0
.end method

.method public static parseDelimitedFrom(Ljava/io/InputStream;)Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$ControlEvent;
    .locals 1
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljava/io/IOException;
        }
    .end annotation

    .prologue
    .line 4820
    sget-object v0, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$ControlEvent;->PARSER:Lcom/google/protobuf/Parser;

    invoke-interface {v0, p0}, Lcom/google/protobuf/Parser;->parseDelimitedFrom(Ljava/io/InputStream;)Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$ControlEvent;

    return-object v0
.end method

.method public static parseDelimitedFrom(Ljava/io/InputStream;Lcom/google/protobuf/ExtensionRegistryLite;)Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$ControlEvent;
    .locals 1
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljava/io/IOException;
        }
    .end annotation

    .prologue
    .line 4826
    sget-object v0, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$ControlEvent;->PARSER:Lcom/google/protobuf/Parser;

    invoke-interface {v0, p0, p1}, Lcom/google/protobuf/Parser;->parseDelimitedFrom(Ljava/io/InputStream;Lcom/google/protobuf/ExtensionRegistryLite;)Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$ControlEvent;

    return-object v0
.end method

.method public static parseFrom(Lcom/google/protobuf/ByteString;)Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$ControlEvent;
    .locals 1
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Lcom/google/protobuf/InvalidProtocolBufferException;
        }
    .end annotation

    .prologue
    .line 4790
    sget-object v0, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$ControlEvent;->PARSER:Lcom/google/protobuf/Parser;

    invoke-interface {v0, p0}, Lcom/google/protobuf/Parser;->parseFrom(Lcom/google/protobuf/ByteString;)Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$ControlEvent;

    return-object v0
.end method

.method public static parseFrom(Lcom/google/protobuf/ByteString;Lcom/google/protobuf/ExtensionRegistryLite;)Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$ControlEvent;
    .locals 1
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Lcom/google/protobuf/InvalidProtocolBufferException;
        }
    .end annotation

    .prologue
    .line 4796
    sget-object v0, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$ControlEvent;->PARSER:Lcom/google/protobuf/Parser;

    invoke-interface {v0, p0, p1}, Lcom/google/protobuf/Parser;->parseFrom(Lcom/google/protobuf/ByteString;Lcom/google/protobuf/ExtensionRegistryLite;)Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$ControlEvent;

    return-object v0
.end method

.method public static parseFrom(Lcom/google/protobuf/CodedInputStream;)Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$ControlEvent;
    .locals 1
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljava/io/IOException;
        }
    .end annotation

    .prologue
    .line 4831
    sget-object v0, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$ControlEvent;->PARSER:Lcom/google/protobuf/Parser;

    invoke-interface {v0, p0}, Lcom/google/protobuf/Parser;->parseFrom(Lcom/google/protobuf/CodedInputStream;)Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$ControlEvent;

    return-object v0
.end method

.method public static parseFrom(Lcom/google/protobuf/CodedInputStream;Lcom/google/protobuf/ExtensionRegistryLite;)Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$ControlEvent;
    .locals 1
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljava/io/IOException;
        }
    .end annotation

    .prologue
    .line 4837
    sget-object v0, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$ControlEvent;->PARSER:Lcom/google/protobuf/Parser;

    invoke-interface {v0, p0, p1}, Lcom/google/protobuf/Parser;->parseFrom(Lcom/google/protobuf/CodedInputStream;Lcom/google/protobuf/ExtensionRegistryLite;)Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$ControlEvent;

    return-object v0
.end method

.method public static parseFrom(Ljava/io/InputStream;)Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$ControlEvent;
    .locals 1
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljava/io/IOException;
        }
    .end annotation

    .prologue
    .line 4810
    sget-object v0, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$ControlEvent;->PARSER:Lcom/google/protobuf/Parser;

    invoke-interface {v0, p0}, Lcom/google/protobuf/Parser;->parseFrom(Ljava/io/InputStream;)Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$ControlEvent;

    return-object v0
.end method

.method public static parseFrom(Ljava/io/InputStream;Lcom/google/protobuf/ExtensionRegistryLite;)Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$ControlEvent;
    .locals 1
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljava/io/IOException;
        }
    .end annotation

    .prologue
    .line 4816
    sget-object v0, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$ControlEvent;->PARSER:Lcom/google/protobuf/Parser;

    invoke-interface {v0, p0, p1}, Lcom/google/protobuf/Parser;->parseFrom(Ljava/io/InputStream;Lcom/google/protobuf/ExtensionRegistryLite;)Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$ControlEvent;

    return-object v0
.end method

.method public static parseFrom([B)Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$ControlEvent;
    .locals 1
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Lcom/google/protobuf/InvalidProtocolBufferException;
        }
    .end annotation

    .prologue
    .line 4800
    sget-object v0, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$ControlEvent;->PARSER:Lcom/google/protobuf/Parser;

    invoke-interface {v0, p0}, Lcom/google/protobuf/Parser;->parseFrom([B)Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$ControlEvent;

    return-object v0
.end method

.method public static parseFrom([BLcom/google/protobuf/ExtensionRegistryLite;)Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$ControlEvent;
    .locals 1
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Lcom/google/protobuf/InvalidProtocolBufferException;
        }
    .end annotation

    .prologue
    .line 4806
    sget-object v0, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$ControlEvent;->PARSER:Lcom/google/protobuf/Parser;

    invoke-interface {v0, p0, p1}, Lcom/google/protobuf/Parser;->parseFrom([BLcom/google/protobuf/ExtensionRegistryLite;)Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$ControlEvent;

    return-object v0
.end method


# virtual methods
.method public getControlId()Ljava/lang/String;
    .locals 2

    .prologue
    .line 4568
    iget-object v0, p0, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$ControlEvent;->controlId_:Ljava/lang/Object;

    .line 4569
    instance-of v1, v0, Ljava/lang/String;

    if-eqz v1, :cond_0

    .line 4570
    check-cast v0, Ljava/lang/String;

    .line 4578
    :goto_0
    return-object v0

    .line 4572
    :cond_0
    check-cast v0, Lcom/google/protobuf/ByteString;

    .line 4574
    invoke-virtual {v0}, Lcom/google/protobuf/ByteString;->toStringUtf8()Ljava/lang/String;

    move-result-object v1

    .line 4575
    invoke-virtual {v0}, Lcom/google/protobuf/ByteString;->isValidUtf8()Z

    move-result v0

    if-eqz v0, :cond_1

    .line 4576
    iput-object v1, p0, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$ControlEvent;->controlId_:Ljava/lang/Object;

    :cond_1
    move-object v0, v1

    .line 4578
    goto :goto_0
.end method

.method public getControlIdBytes()Lcom/google/protobuf/ByteString;
    .locals 2

    .prologue
    .line 4586
    iget-object v0, p0, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$ControlEvent;->controlId_:Ljava/lang/Object;

    .line 4587
    instance-of v1, v0, Ljava/lang/String;

    if-eqz v1, :cond_0

    .line 4588
    check-cast v0, Ljava/lang/String;

    .line 4589
    invoke-static {v0}, Lcom/google/protobuf/ByteString;->copyFromUtf8(Ljava/lang/String;)Lcom/google/protobuf/ByteString;

    move-result-object v0

    .line 4591
    iput-object v0, p0, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$ControlEvent;->controlId_:Ljava/lang/Object;

    .line 4594
    :goto_0
    return-object v0

    :cond_0
    check-cast v0, Lcom/google/protobuf/ByteString;

    goto :goto_0
.end method

.method public getDefaultInstanceForType()Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$ControlEvent;
    .locals 1

    .prologue
    .line 4348
    sget-object v0, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$ControlEvent;->defaultInstance:Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$ControlEvent;

    return-object v0
.end method

.method public bridge synthetic getDefaultInstanceForType()Lcom/google/protobuf/Message;
    .locals 1

    .prologue
    .line 4332
    invoke-virtual {p0}, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$ControlEvent;->getDefaultInstanceForType()Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$ControlEvent;

    move-result-object v0

    return-object v0
.end method

.method public bridge synthetic getDefaultInstanceForType()Lcom/google/protobuf/MessageLite;
    .locals 1

    .prologue
    .line 4332
    invoke-virtual {p0}, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$ControlEvent;->getDefaultInstanceForType()Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$ControlEvent;

    move-result-object v0

    return-object v0
.end method

.method public getEventArgs()Ljava/lang/String;
    .locals 2

    .prologue
    .line 4627
    iget-object v0, p0, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$ControlEvent;->eventArgs_:Ljava/lang/Object;

    .line 4628
    instance-of v1, v0, Ljava/lang/String;

    if-eqz v1, :cond_0

    .line 4629
    check-cast v0, Ljava/lang/String;

    .line 4637
    :goto_0
    return-object v0

    .line 4631
    :cond_0
    check-cast v0, Lcom/google/protobuf/ByteString;

    .line 4633
    invoke-virtual {v0}, Lcom/google/protobuf/ByteString;->toStringUtf8()Ljava/lang/String;

    move-result-object v1

    .line 4634
    invoke-virtual {v0}, Lcom/google/protobuf/ByteString;->isValidUtf8()Z

    move-result v0

    if-eqz v0, :cond_1

    .line 4635
    iput-object v1, p0, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$ControlEvent;->eventArgs_:Ljava/lang/Object;

    :cond_1
    move-object v0, v1

    .line 4637
    goto :goto_0
.end method

.method public getEventArgsBytes()Lcom/google/protobuf/ByteString;
    .locals 2

    .prologue
    .line 4645
    iget-object v0, p0, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$ControlEvent;->eventArgs_:Ljava/lang/Object;

    .line 4646
    instance-of v1, v0, Ljava/lang/String;

    if-eqz v1, :cond_0

    .line 4647
    check-cast v0, Ljava/lang/String;

    .line 4648
    invoke-static {v0}, Lcom/google/protobuf/ByteString;->copyFromUtf8(Ljava/lang/String;)Lcom/google/protobuf/ByteString;

    move-result-object v0

    .line 4650
    iput-object v0, p0, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$ControlEvent;->eventArgs_:Ljava/lang/Object;

    .line 4653
    :goto_0
    return-object v0

    :cond_0
    check-cast v0, Lcom/google/protobuf/ByteString;

    goto :goto_0
.end method

.method public getEventFunctionName()Ljava/lang/String;
    .locals 2

    .prologue
    .line 4678
    iget-object v0, p0, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$ControlEvent;->eventFunctionName_:Ljava/lang/Object;

    .line 4679
    instance-of v1, v0, Ljava/lang/String;

    if-eqz v1, :cond_0

    .line 4680
    check-cast v0, Ljava/lang/String;

    .line 4688
    :goto_0
    return-object v0

    .line 4682
    :cond_0
    check-cast v0, Lcom/google/protobuf/ByteString;

    .line 4684
    invoke-virtual {v0}, Lcom/google/protobuf/ByteString;->toStringUtf8()Ljava/lang/String;

    move-result-object v1

    .line 4685
    invoke-virtual {v0}, Lcom/google/protobuf/ByteString;->isValidUtf8()Z

    move-result v0

    if-eqz v0, :cond_1

    .line 4686
    iput-object v1, p0, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$ControlEvent;->eventFunctionName_:Ljava/lang/Object;

    :cond_1
    move-object v0, v1

    .line 4688
    goto :goto_0
.end method

.method public getEventFunctionNameBytes()Lcom/google/protobuf/ByteString;
    .locals 2

    .prologue
    .line 4700
    iget-object v0, p0, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$ControlEvent;->eventFunctionName_:Ljava/lang/Object;

    .line 4701
    instance-of v1, v0, Ljava/lang/String;

    if-eqz v1, :cond_0

    .line 4702
    check-cast v0, Ljava/lang/String;

    .line 4703
    invoke-static {v0}, Lcom/google/protobuf/ByteString;->copyFromUtf8(Ljava/lang/String;)Lcom/google/protobuf/ByteString;

    move-result-object v0

    .line 4705
    iput-object v0, p0, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$ControlEvent;->eventFunctionName_:Ljava/lang/Object;

    .line 4708
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
            "Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$ControlEvent;",
            ">;"
        }
    .end annotation

    .prologue
    .line 4442
    sget-object v0, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$ControlEvent;->PARSER:Lcom/google/protobuf/Parser;

    return-object v0
.end method

.method public getSerializedSize()I
    .locals 5

    .prologue
    const/4 v4, 0x4

    const/4 v3, 0x2

    const/4 v2, 0x1

    .line 4755
    iget v0, p0, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$ControlEvent;->memoizedSerializedSize:I

    .line 4756
    const/4 v1, -0x1

    if-eq v0, v1, :cond_0

    .line 4777
    :goto_0
    return v0

    .line 4758
    :cond_0
    const/4 v0, 0x0

    .line 4759
    iget v1, p0, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$ControlEvent;->bitField0_:I

    and-int/lit8 v1, v1, 0x1

    if-ne v1, v2, :cond_1

    .line 4761
    invoke-virtual {p0}, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$ControlEvent;->getControlIdBytes()Lcom/google/protobuf/ByteString;

    move-result-object v1

    invoke-static {v2, v1}, Lcom/google/protobuf/CodedOutputStream;->computeBytesSize(ILcom/google/protobuf/ByteString;)I

    move-result v1

    add-int/2addr v0, v1

    .line 4763
    :cond_1
    iget v1, p0, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$ControlEvent;->bitField0_:I

    and-int/lit8 v1, v1, 0x2

    if-ne v1, v3, :cond_2

    .line 4764
    iget-object v1, p0, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$ControlEvent;->type_:Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$ControlEvent$Event_Type;

    .line 4765
    invoke-virtual {v1}, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$ControlEvent$Event_Type;->getNumber()I

    move-result v1

    invoke-static {v3, v1}, Lcom/google/protobuf/CodedOutputStream;->computeEnumSize(II)I

    move-result v1

    add-int/2addr v0, v1

    .line 4767
    :cond_2
    iget v1, p0, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$ControlEvent;->bitField0_:I

    and-int/lit8 v1, v1, 0x4

    if-ne v1, v4, :cond_3

    .line 4768
    const/4 v1, 0x3

    .line 4769
    invoke-virtual {p0}, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$ControlEvent;->getEventArgsBytes()Lcom/google/protobuf/ByteString;

    move-result-object v2

    invoke-static {v1, v2}, Lcom/google/protobuf/CodedOutputStream;->computeBytesSize(ILcom/google/protobuf/ByteString;)I

    move-result v1

    add-int/2addr v0, v1

    .line 4771
    :cond_3
    iget v1, p0, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$ControlEvent;->bitField0_:I

    and-int/lit8 v1, v1, 0x8

    const/16 v2, 0x8

    if-ne v1, v2, :cond_4

    .line 4773
    invoke-virtual {p0}, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$ControlEvent;->getEventFunctionNameBytes()Lcom/google/protobuf/ByteString;

    move-result-object v1

    invoke-static {v4, v1}, Lcom/google/protobuf/CodedOutputStream;->computeBytesSize(ILcom/google/protobuf/ByteString;)I

    move-result v1

    add-int/2addr v0, v1

    .line 4775
    :cond_4
    invoke-virtual {p0}, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$ControlEvent;->getUnknownFields()Lcom/google/protobuf/UnknownFieldSet;

    move-result-object v1

    invoke-virtual {v1}, Lcom/google/protobuf/UnknownFieldSet;->getSerializedSize()I

    move-result v1

    add-int/2addr v0, v1

    .line 4776
    iput v0, p0, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$ControlEvent;->memoizedSerializedSize:I

    goto :goto_0
.end method

.method public getType()Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$ControlEvent$Event_Type;
    .locals 1

    .prologue
    .line 4611
    iget-object v0, p0, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$ControlEvent;->type_:Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$ControlEvent$Event_Type;

    return-object v0
.end method

.method public final getUnknownFields()Lcom/google/protobuf/UnknownFieldSet;
    .locals 1

    .prologue
    .line 4355
    iget-object v0, p0, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$ControlEvent;->unknownFields:Lcom/google/protobuf/UnknownFieldSet;

    return-object v0
.end method

.method public hasControlId()Z
    .locals 2

    .prologue
    const/4 v0, 0x1

    .line 4562
    iget v1, p0, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$ControlEvent;->bitField0_:I

    and-int/lit8 v1, v1, 0x1

    if-ne v1, v0, :cond_0

    :goto_0
    return v0

    :cond_0
    const/4 v0, 0x0

    goto :goto_0
.end method

.method public hasEventArgs()Z
    .locals 2

    .prologue
    .line 4621
    iget v0, p0, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$ControlEvent;->bitField0_:I

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

.method public hasEventFunctionName()Z
    .locals 2

    .prologue
    .line 4668
    iget v0, p0, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$ControlEvent;->bitField0_:I

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

.method public hasType()Z
    .locals 2

    .prologue
    .line 4605
    iget v0, p0, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$ControlEvent;->bitField0_:I

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
    .line 4425
    invoke-static {}, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage;->g()Lcom/google/protobuf/GeneratedMessage$FieldAccessorTable;

    move-result-object v0

    const-class v1, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$ControlEvent;

    const-class v2, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$ControlEvent$Builder;

    .line 4426
    invoke-virtual {v0, v1, v2}, Lcom/google/protobuf/GeneratedMessage$FieldAccessorTable;->ensureFieldAccessorsInitialized(Ljava/lang/Class;Ljava/lang/Class;)Lcom/google/protobuf/GeneratedMessage$FieldAccessorTable;

    move-result-object v0

    .line 4425
    return-object v0
.end method

.method public final isInitialized()Z
    .locals 4

    .prologue
    const/4 v0, 0x1

    const/4 v1, 0x0

    .line 4720
    iget-byte v2, p0, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$ControlEvent;->memoizedIsInitialized:B

    .line 4721
    const/4 v3, -0x1

    if-eq v2, v3, :cond_1

    if-ne v2, v0, :cond_0

    .line 4732
    :goto_0
    return v0

    :cond_0
    move v0, v1

    .line 4721
    goto :goto_0

    .line 4723
    :cond_1
    invoke-virtual {p0}, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$ControlEvent;->hasControlId()Z

    move-result v2

    if-nez v2, :cond_2

    .line 4724
    iput-byte v1, p0, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$ControlEvent;->memoizedIsInitialized:B

    move v0, v1

    .line 4725
    goto :goto_0

    .line 4727
    :cond_2
    invoke-virtual {p0}, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$ControlEvent;->hasType()Z

    move-result v2

    if-nez v2, :cond_3

    .line 4728
    iput-byte v1, p0, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$ControlEvent;->memoizedIsInitialized:B

    move v0, v1

    .line 4729
    goto :goto_0

    .line 4731
    :cond_3
    iput-byte v0, p0, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$ControlEvent;->memoizedIsInitialized:B

    goto :goto_0
.end method

.method public newBuilderForType()Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$ControlEvent$Builder;
    .locals 1

    .prologue
    .line 4841
    invoke-static {}, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$ControlEvent;->newBuilder()Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$ControlEvent$Builder;

    move-result-object v0

    return-object v0
.end method

.method protected newBuilderForType(Lcom/google/protobuf/GeneratedMessage$BuilderParent;)Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$ControlEvent$Builder;
    .locals 2

    .prologue
    .line 4850
    new-instance v0, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$ControlEvent$Builder;

    const/4 v1, 0x0

    invoke-direct {v0, p1, v1}, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$ControlEvent$Builder;-><init>(Lcom/google/protobuf/GeneratedMessage$BuilderParent;Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$1;)V

    .line 4851
    return-object v0
.end method

.method public bridge synthetic newBuilderForType()Lcom/google/protobuf/Message$Builder;
    .locals 1

    .prologue
    .line 4332
    invoke-virtual {p0}, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$ControlEvent;->newBuilderForType()Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$ControlEvent$Builder;

    move-result-object v0

    return-object v0
.end method

.method protected bridge synthetic newBuilderForType(Lcom/google/protobuf/GeneratedMessage$BuilderParent;)Lcom/google/protobuf/Message$Builder;
    .locals 1

    .prologue
    .line 4332
    invoke-virtual {p0, p1}, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$ControlEvent;->newBuilderForType(Lcom/google/protobuf/GeneratedMessage$BuilderParent;)Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$ControlEvent$Builder;

    move-result-object v0

    return-object v0
.end method

.method public bridge synthetic newBuilderForType()Lcom/google/protobuf/MessageLite$Builder;
    .locals 1

    .prologue
    .line 4332
    invoke-virtual {p0}, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$ControlEvent;->newBuilderForType()Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$ControlEvent$Builder;

    move-result-object v0

    return-object v0
.end method

.method public toBuilder()Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$ControlEvent$Builder;
    .locals 1

    .prologue
    .line 4845
    invoke-static {p0}, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$ControlEvent;->newBuilder(Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$ControlEvent;)Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$ControlEvent$Builder;

    move-result-object v0

    return-object v0
.end method

.method public bridge synthetic toBuilder()Lcom/google/protobuf/Message$Builder;
    .locals 1

    .prologue
    .line 4332
    invoke-virtual {p0}, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$ControlEvent;->toBuilder()Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$ControlEvent$Builder;

    move-result-object v0

    return-object v0
.end method

.method public bridge synthetic toBuilder()Lcom/google/protobuf/MessageLite$Builder;
    .locals 1

    .prologue
    .line 4332
    invoke-virtual {p0}, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$ControlEvent;->toBuilder()Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$ControlEvent$Builder;

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
    .line 4784
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

    .line 4737
    invoke-virtual {p0}, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$ControlEvent;->getSerializedSize()I

    .line 4738
    iget v0, p0, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$ControlEvent;->bitField0_:I

    and-int/lit8 v0, v0, 0x1

    if-ne v0, v1, :cond_0

    .line 4739
    invoke-virtual {p0}, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$ControlEvent;->getControlIdBytes()Lcom/google/protobuf/ByteString;

    move-result-object v0

    invoke-virtual {p1, v1, v0}, Lcom/google/protobuf/CodedOutputStream;->writeBytes(ILcom/google/protobuf/ByteString;)V

    .line 4741
    :cond_0
    iget v0, p0, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$ControlEvent;->bitField0_:I

    and-int/lit8 v0, v0, 0x2

    if-ne v0, v2, :cond_1

    .line 4742
    iget-object v0, p0, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$ControlEvent;->type_:Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$ControlEvent$Event_Type;

    invoke-virtual {v0}, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$ControlEvent$Event_Type;->getNumber()I

    move-result v0

    invoke-virtual {p1, v2, v0}, Lcom/google/protobuf/CodedOutputStream;->writeEnum(II)V

    .line 4744
    :cond_1
    iget v0, p0, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$ControlEvent;->bitField0_:I

    and-int/lit8 v0, v0, 0x4

    if-ne v0, v3, :cond_2

    .line 4745
    const/4 v0, 0x3

    invoke-virtual {p0}, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$ControlEvent;->getEventArgsBytes()Lcom/google/protobuf/ByteString;

    move-result-object v1

    invoke-virtual {p1, v0, v1}, Lcom/google/protobuf/CodedOutputStream;->writeBytes(ILcom/google/protobuf/ByteString;)V

    .line 4747
    :cond_2
    iget v0, p0, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$ControlEvent;->bitField0_:I

    and-int/lit8 v0, v0, 0x8

    const/16 v1, 0x8

    if-ne v0, v1, :cond_3

    .line 4748
    invoke-virtual {p0}, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$ControlEvent;->getEventFunctionNameBytes()Lcom/google/protobuf/ByteString;

    move-result-object v0

    invoke-virtual {p1, v3, v0}, Lcom/google/protobuf/CodedOutputStream;->writeBytes(ILcom/google/protobuf/ByteString;)V

    .line 4750
    :cond_3
    invoke-virtual {p0}, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$ControlEvent;->getUnknownFields()Lcom/google/protobuf/UnknownFieldSet;

    move-result-object v0

    invoke-virtual {v0, p1}, Lcom/google/protobuf/UnknownFieldSet;->writeTo(Lcom/google/protobuf/CodedOutputStream;)V

    .line 4751
    return-void
.end method
