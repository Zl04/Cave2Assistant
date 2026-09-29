.class public final Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$UipToCommand;
.super Lcom/google/protobuf/GeneratedMessage;
.source "SourceFile"

# interfaces
.implements Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$UipToCommandOrBuilder;


# annotations
.annotation system Ldalvik/annotation/EnclosingClass;
    value = Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage;
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x19
    name = "UipToCommand"
.end annotation

.annotation system Ldalvik/annotation/MemberClasses;
    value = {
        Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$UipToCommand$Builder;,
        Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$UipToCommand$Command_Type;
    }
.end annotation


# static fields
.field public static final COMMAND_FIELD_NUMBER:I = 0x1

.field public static final EVENT_FIELD_NUMBER:I = 0x2

.field public static final ISSUCCESS_FIELD_NUMBER:I = 0x3

.field public static PARSER:Lcom/google/protobuf/Parser; = null
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "Lcom/google/protobuf/Parser",
            "<",
            "Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$UipToCommand;",
            ">;"
        }
    .end annotation
.end field

.field public static final UIP_ATTRIBUTE_DATA_FIELD_NUMBER:I = 0x4

.field private static final defaultInstance:Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$UipToCommand;

.field private static final serialVersionUID:J


# instance fields
.field private bitField0_:I

.field private command_:Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$UipToCommand$Command_Type;

.field private event_:Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$ControlEvent;

.field private isSuccess_:Z

.field private memoizedIsInitialized:B

.field private memoizedSerializedSize:I

.field private uipAttributeData_:Ljava/lang/Object;

.field private final unknownFields:Lcom/google/protobuf/UnknownFieldSet;


# direct methods
.method static constructor <clinit>()V
    .locals 2

    .prologue
    .line 8413
    new-instance v0, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$UipToCommand$1;

    invoke-direct {v0}, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$UipToCommand$1;-><init>()V

    sput-object v0, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$UipToCommand;->PARSER:Lcom/google/protobuf/Parser;

    .line 9181
    new-instance v0, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$UipToCommand;

    const/4 v1, 0x1

    invoke-direct {v0, v1}, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$UipToCommand;-><init>(Z)V

    sput-object v0, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$UipToCommand;->defaultInstance:Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$UipToCommand;

    .line 9182
    sget-object v0, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$UipToCommand;->defaultInstance:Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$UipToCommand;

    invoke-direct {v0}, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$UipToCommand;->initFields()V

    .line 9183
    return-void
.end method

.method private constructor <init>(Lcom/google/protobuf/CodedInputStream;Lcom/google/protobuf/ExtensionRegistryLite;)V
    .locals 6
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Lcom/google/protobuf/InvalidProtocolBufferException;
        }
    .end annotation

    .prologue
    const/4 v0, -0x1

    const/4 v1, 0x1

    .line 8335
    invoke-direct {p0}, Lcom/google/protobuf/GeneratedMessage;-><init>()V

    .line 8614
    iput-byte v0, p0, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$UipToCommand;->memoizedIsInitialized:B

    .line 8651
    iput v0, p0, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$UipToCommand;->memoizedSerializedSize:I

    .line 8336
    invoke-direct {p0}, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$UipToCommand;->initFields()V

    .line 8339
    invoke-static {}, Lcom/google/protobuf/UnknownFieldSet;->newBuilder()Lcom/google/protobuf/UnknownFieldSet$Builder;

    move-result-object v4

    .line 8341
    const/4 v2, 0x0

    .line 8342
    :goto_0
    if-nez v2, :cond_3

    .line 8343
    :try_start_0
    invoke-virtual {p1}, Lcom/google/protobuf/CodedInputStream;->readTag()I

    move-result v0

    .line 8344
    sparse-switch v0, :sswitch_data_0

    .line 8349
    invoke-virtual {p0, p1, v4, p2, v0}, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$UipToCommand;->parseUnknownField(Lcom/google/protobuf/CodedInputStream;Lcom/google/protobuf/UnknownFieldSet$Builder;Lcom/google/protobuf/ExtensionRegistryLite;I)Z

    move-result v0

    if-nez v0, :cond_2

    move v0, v1

    :goto_1
    move v2, v0

    .line 8390
    goto :goto_0

    :sswitch_0
    move v0, v1

    .line 8347
    goto :goto_1

    .line 8356
    :sswitch_1
    invoke-virtual {p1}, Lcom/google/protobuf/CodedInputStream;->readEnum()I

    move-result v0

    .line 8357
    invoke-static {v0}, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$UipToCommand$Command_Type;->valueOf(I)Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$UipToCommand$Command_Type;

    move-result-object v3

    .line 8358
    if-nez v3, :cond_0

    .line 8359
    const/4 v3, 0x1

    invoke-virtual {v4, v3, v0}, Lcom/google/protobuf/UnknownFieldSet$Builder;->mergeVarintField(II)Lcom/google/protobuf/UnknownFieldSet$Builder;

    move v0, v2

    goto :goto_1

    .line 8361
    :cond_0
    iget v0, p0, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$UipToCommand;->bitField0_:I

    or-int/lit8 v0, v0, 0x1

    iput v0, p0, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$UipToCommand;->bitField0_:I

    .line 8362
    iput-object v3, p0, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$UipToCommand;->command_:Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$UipToCommand$Command_Type;

    move v0, v2

    .line 8364
    goto :goto_1

    .line 8367
    :sswitch_2
    const/4 v0, 0x0

    .line 8368
    iget v3, p0, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$UipToCommand;->bitField0_:I

    and-int/lit8 v3, v3, 0x2

    const/4 v5, 0x2

    if-ne v3, v5, :cond_4

    .line 8369
    iget-object v0, p0, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$UipToCommand;->event_:Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$ControlEvent;

    invoke-virtual {v0}, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$ControlEvent;->toBuilder()Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$ControlEvent$Builder;

    move-result-object v0

    move-object v3, v0

    .line 8371
    :goto_2
    sget-object v0, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$ControlEvent;->PARSER:Lcom/google/protobuf/Parser;

    invoke-virtual {p1, v0, p2}, Lcom/google/protobuf/CodedInputStream;->readMessage(Lcom/google/protobuf/Parser;Lcom/google/protobuf/ExtensionRegistryLite;)Lcom/google/protobuf/MessageLite;

    move-result-object v0

    check-cast v0, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$ControlEvent;

    iput-object v0, p0, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$UipToCommand;->event_:Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$ControlEvent;

    .line 8372
    if-eqz v3, :cond_1

    .line 8373
    iget-object v0, p0, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$UipToCommand;->event_:Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$ControlEvent;

    invoke-virtual {v3, v0}, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$ControlEvent$Builder;->mergeFrom(Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$ControlEvent;)Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$ControlEvent$Builder;

    .line 8374
    invoke-virtual {v3}, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$ControlEvent$Builder;->buildPartial()Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$ControlEvent;

    move-result-object v0

    iput-object v0, p0, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$UipToCommand;->event_:Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$ControlEvent;

    .line 8376
    :cond_1
    iget v0, p0, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$UipToCommand;->bitField0_:I

    or-int/lit8 v0, v0, 0x2

    iput v0, p0, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$UipToCommand;->bitField0_:I

    move v0, v2

    .line 8377
    goto :goto_1

    .line 8380
    :sswitch_3
    iget v0, p0, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$UipToCommand;->bitField0_:I

    or-int/lit8 v0, v0, 0x4

    iput v0, p0, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$UipToCommand;->bitField0_:I

    .line 8381
    invoke-virtual {p1}, Lcom/google/protobuf/CodedInputStream;->readBool()Z

    move-result v0

    iput-boolean v0, p0, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$UipToCommand;->isSuccess_:Z

    move v0, v2

    .line 8382
    goto :goto_1

    .line 8385
    :sswitch_4
    iget v0, p0, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$UipToCommand;->bitField0_:I

    or-int/lit8 v0, v0, 0x8

    iput v0, p0, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$UipToCommand;->bitField0_:I

    .line 8386
    invoke-virtual {p1}, Lcom/google/protobuf/CodedInputStream;->readBytes()Lcom/google/protobuf/ByteString;

    move-result-object v0

    iput-object v0, p0, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$UipToCommand;->uipAttributeData_:Ljava/lang/Object;
    :try_end_0
    .catch Lcom/google/protobuf/InvalidProtocolBufferException; {:try_start_0 .. :try_end_0} :catch_0
    .catch Ljava/io/IOException; {:try_start_0 .. :try_end_0} :catch_1
    .catchall {:try_start_0 .. :try_end_0} :catchall_0

    :cond_2
    move v0, v2

    goto :goto_1

    .line 8397
    :cond_3
    invoke-virtual {v4}, Lcom/google/protobuf/UnknownFieldSet$Builder;->build()Lcom/google/protobuf/UnknownFieldSet;

    move-result-object v0

    iput-object v0, p0, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$UipToCommand;->unknownFields:Lcom/google/protobuf/UnknownFieldSet;

    .line 8398
    invoke-virtual {p0}, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$UipToCommand;->makeExtensionsImmutable()V

    .line 8400
    return-void

    .line 8391
    :catch_0
    move-exception v0

    .line 8392
    :try_start_1
    invoke-virtual {v0, p0}, Lcom/google/protobuf/InvalidProtocolBufferException;->setUnfinishedMessage(Lcom/google/protobuf/MessageLite;)Lcom/google/protobuf/InvalidProtocolBufferException;

    move-result-object v0

    throw v0
    :try_end_1
    .catchall {:try_start_1 .. :try_end_1} :catchall_0

    .line 8397
    :catchall_0
    move-exception v0

    invoke-virtual {v4}, Lcom/google/protobuf/UnknownFieldSet$Builder;->build()Lcom/google/protobuf/UnknownFieldSet;

    move-result-object v1

    iput-object v1, p0, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$UipToCommand;->unknownFields:Lcom/google/protobuf/UnknownFieldSet;

    .line 8398
    invoke-virtual {p0}, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$UipToCommand;->makeExtensionsImmutable()V

    throw v0

    .line 8393
    :catch_1
    move-exception v0

    .line 8394
    :try_start_2
    new-instance v1, Lcom/google/protobuf/InvalidProtocolBufferException;

    .line 8395
    invoke-virtual {v0}, Ljava/io/IOException;->getMessage()Ljava/lang/String;

    move-result-object v0

    invoke-direct {v1, v0}, Lcom/google/protobuf/InvalidProtocolBufferException;-><init>(Ljava/lang/String;)V

    invoke-virtual {v1, p0}, Lcom/google/protobuf/InvalidProtocolBufferException;->setUnfinishedMessage(Lcom/google/protobuf/MessageLite;)Lcom/google/protobuf/InvalidProtocolBufferException;

    move-result-object v0

    throw v0
    :try_end_2
    .catchall {:try_start_2 .. :try_end_2} :catchall_0

    :cond_4
    move-object v3, v0

    goto :goto_2

    .line 8344
    nop

    :sswitch_data_0
    .sparse-switch
        0x0 -> :sswitch_0
        0x8 -> :sswitch_1
        0x12 -> :sswitch_2
        0x18 -> :sswitch_3
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
    .line 8307
    invoke-direct {p0, p1, p2}, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$UipToCommand;-><init>(Lcom/google/protobuf/CodedInputStream;Lcom/google/protobuf/ExtensionRegistryLite;)V

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

    .line 8312
    invoke-direct {p0, p1}, Lcom/google/protobuf/GeneratedMessage;-><init>(Lcom/google/protobuf/GeneratedMessage$Builder;)V

    .line 8614
    iput-byte v0, p0, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$UipToCommand;->memoizedIsInitialized:B

    .line 8651
    iput v0, p0, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$UipToCommand;->memoizedSerializedSize:I

    .line 8313
    invoke-virtual {p1}, Lcom/google/protobuf/GeneratedMessage$Builder;->getUnknownFields()Lcom/google/protobuf/UnknownFieldSet;

    move-result-object v0

    iput-object v0, p0, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$UipToCommand;->unknownFields:Lcom/google/protobuf/UnknownFieldSet;

    .line 8314
    return-void
.end method

.method synthetic constructor <init>(Lcom/google/protobuf/GeneratedMessage$Builder;Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$1;)V
    .locals 0

    .prologue
    .line 8307
    invoke-direct {p0, p1}, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$UipToCommand;-><init>(Lcom/google/protobuf/GeneratedMessage$Builder;)V

    return-void
.end method

.method private constructor <init>(Z)V
    .locals 1

    .prologue
    const/4 v0, -0x1

    .line 8315
    invoke-direct {p0}, Lcom/google/protobuf/GeneratedMessage;-><init>()V

    .line 8614
    iput-byte v0, p0, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$UipToCommand;->memoizedIsInitialized:B

    .line 8651
    iput v0, p0, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$UipToCommand;->memoizedSerializedSize:I

    .line 8315
    invoke-static {}, Lcom/google/protobuf/UnknownFieldSet;->getDefaultInstance()Lcom/google/protobuf/UnknownFieldSet;

    move-result-object v0

    iput-object v0, p0, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$UipToCommand;->unknownFields:Lcom/google/protobuf/UnknownFieldSet;

    return-void
.end method

.method static synthetic access$10002(Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$UipToCommand;Z)Z
    .locals 0

    .prologue
    .line 8307
    iput-boolean p1, p0, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$UipToCommand;->isSuccess_:Z

    return p1
.end method

.method static synthetic access$10100(Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$UipToCommand;)Ljava/lang/Object;
    .locals 1

    .prologue
    .line 8307
    iget-object v0, p0, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$UipToCommand;->uipAttributeData_:Ljava/lang/Object;

    return-object v0
.end method

.method static synthetic access$10102(Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$UipToCommand;Ljava/lang/Object;)Ljava/lang/Object;
    .locals 0

    .prologue
    .line 8307
    iput-object p1, p0, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$UipToCommand;->uipAttributeData_:Ljava/lang/Object;

    return-object p1
.end method

.method static synthetic access$10202(Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$UipToCommand;I)I
    .locals 0

    .prologue
    .line 8307
    iput p1, p0, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$UipToCommand;->bitField0_:I

    return p1
.end method

.method static synthetic access$9600()Z
    .locals 1

    .prologue
    .line 8307
    sget-boolean v0, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$UipToCommand;->alwaysUseFieldBuilders:Z

    return v0
.end method

.method static synthetic access$9802(Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$UipToCommand;Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$UipToCommand$Command_Type;)Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$UipToCommand$Command_Type;
    .locals 0

    .prologue
    .line 8307
    iput-object p1, p0, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$UipToCommand;->command_:Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$UipToCommand$Command_Type;

    return-object p1
.end method

.method static synthetic access$9902(Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$UipToCommand;Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$ControlEvent;)Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$ControlEvent;
    .locals 0

    .prologue
    .line 8307
    iput-object p1, p0, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$UipToCommand;->event_:Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$ControlEvent;

    return-object p1
.end method

.method public static getDefaultInstance()Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$UipToCommand;
    .locals 1

    .prologue
    .line 8319
    sget-object v0, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$UipToCommand;->defaultInstance:Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$UipToCommand;

    return-object v0
.end method

.method public static final getDescriptor()Lcom/google/protobuf/Descriptors$Descriptor;
    .locals 1

    .prologue
    .line 8403
    invoke-static {}, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage;->n()Lcom/google/protobuf/Descriptors$Descriptor;

    move-result-object v0

    return-object v0
.end method

.method private initFields()V
    .locals 1

    .prologue
    .line 8609
    sget-object v0, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$UipToCommand$Command_Type;->EVENT:Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$UipToCommand$Command_Type;

    iput-object v0, p0, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$UipToCommand;->command_:Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$UipToCommand$Command_Type;

    .line 8610
    invoke-static {}, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$ControlEvent;->getDefaultInstance()Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$ControlEvent;

    move-result-object v0

    iput-object v0, p0, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$UipToCommand;->event_:Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$ControlEvent;

    .line 8611
    const/4 v0, 0x0

    iput-boolean v0, p0, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$UipToCommand;->isSuccess_:Z

    .line 8612
    const-string v0, ""

    iput-object v0, p0, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$UipToCommand;->uipAttributeData_:Ljava/lang/Object;

    .line 8613
    return-void
.end method

.method public static newBuilder()Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$UipToCommand$Builder;
    .locals 1

    .prologue
    .line 8738
    invoke-static {}, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$UipToCommand$Builder;->access$9400()Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$UipToCommand$Builder;

    move-result-object v0

    return-object v0
.end method

.method public static newBuilder(Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$UipToCommand;)Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$UipToCommand$Builder;
    .locals 1

    .prologue
    .line 8741
    invoke-static {}, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$UipToCommand;->newBuilder()Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$UipToCommand$Builder;

    move-result-object v0

    invoke-virtual {v0, p0}, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$UipToCommand$Builder;->mergeFrom(Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$UipToCommand;)Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$UipToCommand$Builder;

    move-result-object v0

    return-object v0
.end method

.method public static parseDelimitedFrom(Ljava/io/InputStream;)Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$UipToCommand;
    .locals 1
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljava/io/IOException;
        }
    .end annotation

    .prologue
    .line 8718
    sget-object v0, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$UipToCommand;->PARSER:Lcom/google/protobuf/Parser;

    invoke-interface {v0, p0}, Lcom/google/protobuf/Parser;->parseDelimitedFrom(Ljava/io/InputStream;)Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$UipToCommand;

    return-object v0
.end method

.method public static parseDelimitedFrom(Ljava/io/InputStream;Lcom/google/protobuf/ExtensionRegistryLite;)Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$UipToCommand;
    .locals 1
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljava/io/IOException;
        }
    .end annotation

    .prologue
    .line 8724
    sget-object v0, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$UipToCommand;->PARSER:Lcom/google/protobuf/Parser;

    invoke-interface {v0, p0, p1}, Lcom/google/protobuf/Parser;->parseDelimitedFrom(Ljava/io/InputStream;Lcom/google/protobuf/ExtensionRegistryLite;)Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$UipToCommand;

    return-object v0
.end method

.method public static parseFrom(Lcom/google/protobuf/ByteString;)Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$UipToCommand;
    .locals 1
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Lcom/google/protobuf/InvalidProtocolBufferException;
        }
    .end annotation

    .prologue
    .line 8688
    sget-object v0, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$UipToCommand;->PARSER:Lcom/google/protobuf/Parser;

    invoke-interface {v0, p0}, Lcom/google/protobuf/Parser;->parseFrom(Lcom/google/protobuf/ByteString;)Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$UipToCommand;

    return-object v0
.end method

.method public static parseFrom(Lcom/google/protobuf/ByteString;Lcom/google/protobuf/ExtensionRegistryLite;)Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$UipToCommand;
    .locals 1
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Lcom/google/protobuf/InvalidProtocolBufferException;
        }
    .end annotation

    .prologue
    .line 8694
    sget-object v0, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$UipToCommand;->PARSER:Lcom/google/protobuf/Parser;

    invoke-interface {v0, p0, p1}, Lcom/google/protobuf/Parser;->parseFrom(Lcom/google/protobuf/ByteString;Lcom/google/protobuf/ExtensionRegistryLite;)Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$UipToCommand;

    return-object v0
.end method

.method public static parseFrom(Lcom/google/protobuf/CodedInputStream;)Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$UipToCommand;
    .locals 1
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljava/io/IOException;
        }
    .end annotation

    .prologue
    .line 8729
    sget-object v0, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$UipToCommand;->PARSER:Lcom/google/protobuf/Parser;

    invoke-interface {v0, p0}, Lcom/google/protobuf/Parser;->parseFrom(Lcom/google/protobuf/CodedInputStream;)Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$UipToCommand;

    return-object v0
.end method

.method public static parseFrom(Lcom/google/protobuf/CodedInputStream;Lcom/google/protobuf/ExtensionRegistryLite;)Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$UipToCommand;
    .locals 1
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljava/io/IOException;
        }
    .end annotation

    .prologue
    .line 8735
    sget-object v0, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$UipToCommand;->PARSER:Lcom/google/protobuf/Parser;

    invoke-interface {v0, p0, p1}, Lcom/google/protobuf/Parser;->parseFrom(Lcom/google/protobuf/CodedInputStream;Lcom/google/protobuf/ExtensionRegistryLite;)Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$UipToCommand;

    return-object v0
.end method

.method public static parseFrom(Ljava/io/InputStream;)Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$UipToCommand;
    .locals 1
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljava/io/IOException;
        }
    .end annotation

    .prologue
    .line 8708
    sget-object v0, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$UipToCommand;->PARSER:Lcom/google/protobuf/Parser;

    invoke-interface {v0, p0}, Lcom/google/protobuf/Parser;->parseFrom(Ljava/io/InputStream;)Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$UipToCommand;

    return-object v0
.end method

.method public static parseFrom(Ljava/io/InputStream;Lcom/google/protobuf/ExtensionRegistryLite;)Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$UipToCommand;
    .locals 1
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljava/io/IOException;
        }
    .end annotation

    .prologue
    .line 8714
    sget-object v0, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$UipToCommand;->PARSER:Lcom/google/protobuf/Parser;

    invoke-interface {v0, p0, p1}, Lcom/google/protobuf/Parser;->parseFrom(Ljava/io/InputStream;Lcom/google/protobuf/ExtensionRegistryLite;)Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$UipToCommand;

    return-object v0
.end method

.method public static parseFrom([B)Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$UipToCommand;
    .locals 1
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Lcom/google/protobuf/InvalidProtocolBufferException;
        }
    .end annotation

    .prologue
    .line 8698
    sget-object v0, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$UipToCommand;->PARSER:Lcom/google/protobuf/Parser;

    invoke-interface {v0, p0}, Lcom/google/protobuf/Parser;->parseFrom([B)Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$UipToCommand;

    return-object v0
.end method

.method public static parseFrom([BLcom/google/protobuf/ExtensionRegistryLite;)Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$UipToCommand;
    .locals 1
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Lcom/google/protobuf/InvalidProtocolBufferException;
        }
    .end annotation

    .prologue
    .line 8704
    sget-object v0, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$UipToCommand;->PARSER:Lcom/google/protobuf/Parser;

    invoke-interface {v0, p0, p1}, Lcom/google/protobuf/Parser;->parseFrom([BLcom/google/protobuf/ExtensionRegistryLite;)Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$UipToCommand;

    return-object v0
.end method


# virtual methods
.method public getCommand()Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$UipToCommand$Command_Type;
    .locals 1

    .prologue
    .line 8524
    iget-object v0, p0, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$UipToCommand;->command_:Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$UipToCommand$Command_Type;

    return-object v0
.end method

.method public getDefaultInstanceForType()Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$UipToCommand;
    .locals 1

    .prologue
    .line 8323
    sget-object v0, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$UipToCommand;->defaultInstance:Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$UipToCommand;

    return-object v0
.end method

.method public bridge synthetic getDefaultInstanceForType()Lcom/google/protobuf/Message;
    .locals 1

    .prologue
    .line 8307
    invoke-virtual {p0}, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$UipToCommand;->getDefaultInstanceForType()Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$UipToCommand;

    move-result-object v0

    return-object v0
.end method

.method public bridge synthetic getDefaultInstanceForType()Lcom/google/protobuf/MessageLite;
    .locals 1

    .prologue
    .line 8307
    invoke-virtual {p0}, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$UipToCommand;->getDefaultInstanceForType()Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$UipToCommand;

    move-result-object v0

    return-object v0
.end method

.method public getEvent()Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$ControlEvent;
    .locals 1

    .prologue
    .line 8540
    iget-object v0, p0, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$UipToCommand;->event_:Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$ControlEvent;

    return-object v0
.end method

.method public getEventOrBuilder()Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$ControlEventOrBuilder;
    .locals 1

    .prologue
    .line 8546
    iget-object v0, p0, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$UipToCommand;->event_:Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$ControlEvent;

    return-object v0
.end method

.method public getIsSuccess()Z
    .locals 1

    .prologue
    .line 8562
    iget-boolean v0, p0, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$UipToCommand;->isSuccess_:Z

    return v0
.end method

.method public getParserForType()Lcom/google/protobuf/Parser;
    .locals 1
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "()",
            "Lcom/google/protobuf/Parser",
            "<",
            "Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$UipToCommand;",
            ">;"
        }
    .end annotation

    .prologue
    .line 8425
    sget-object v0, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$UipToCommand;->PARSER:Lcom/google/protobuf/Parser;

    return-object v0
.end method

.method public getSerializedSize()I
    .locals 5

    .prologue
    const/4 v4, 0x4

    const/4 v3, 0x2

    const/4 v2, 0x1

    .line 8653
    iget v0, p0, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$UipToCommand;->memoizedSerializedSize:I

    .line 8654
    const/4 v1, -0x1

    if-eq v0, v1, :cond_0

    .line 8675
    :goto_0
    return v0

    .line 8656
    :cond_0
    const/4 v0, 0x0

    .line 8657
    iget v1, p0, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$UipToCommand;->bitField0_:I

    and-int/lit8 v1, v1, 0x1

    if-ne v1, v2, :cond_1

    .line 8658
    iget-object v1, p0, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$UipToCommand;->command_:Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$UipToCommand$Command_Type;

    .line 8659
    invoke-virtual {v1}, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$UipToCommand$Command_Type;->getNumber()I

    move-result v1

    invoke-static {v2, v1}, Lcom/google/protobuf/CodedOutputStream;->computeEnumSize(II)I

    move-result v1

    add-int/2addr v0, v1

    .line 8661
    :cond_1
    iget v1, p0, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$UipToCommand;->bitField0_:I

    and-int/lit8 v1, v1, 0x2

    if-ne v1, v3, :cond_2

    .line 8662
    iget-object v1, p0, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$UipToCommand;->event_:Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$ControlEvent;

    .line 8663
    invoke-static {v3, v1}, Lcom/google/protobuf/CodedOutputStream;->computeMessageSize(ILcom/google/protobuf/MessageLite;)I

    move-result v1

    add-int/2addr v0, v1

    .line 8665
    :cond_2
    iget v1, p0, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$UipToCommand;->bitField0_:I

    and-int/lit8 v1, v1, 0x4

    if-ne v1, v4, :cond_3

    .line 8666
    const/4 v1, 0x3

    iget-boolean v2, p0, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$UipToCommand;->isSuccess_:Z

    .line 8667
    invoke-static {v1, v2}, Lcom/google/protobuf/CodedOutputStream;->computeBoolSize(IZ)I

    move-result v1

    add-int/2addr v0, v1

    .line 8669
    :cond_3
    iget v1, p0, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$UipToCommand;->bitField0_:I

    and-int/lit8 v1, v1, 0x8

    const/16 v2, 0x8

    if-ne v1, v2, :cond_4

    .line 8671
    invoke-virtual {p0}, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$UipToCommand;->getUipAttributeDataBytes()Lcom/google/protobuf/ByteString;

    move-result-object v1

    invoke-static {v4, v1}, Lcom/google/protobuf/CodedOutputStream;->computeBytesSize(ILcom/google/protobuf/ByteString;)I

    move-result v1

    add-int/2addr v0, v1

    .line 8673
    :cond_4
    invoke-virtual {p0}, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$UipToCommand;->getUnknownFields()Lcom/google/protobuf/UnknownFieldSet;

    move-result-object v1

    invoke-virtual {v1}, Lcom/google/protobuf/UnknownFieldSet;->getSerializedSize()I

    move-result v1

    add-int/2addr v0, v1

    .line 8674
    iput v0, p0, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$UipToCommand;->memoizedSerializedSize:I

    goto :goto_0
.end method

.method public getUipAttributeData()Ljava/lang/String;
    .locals 2

    .prologue
    .line 8578
    iget-object v0, p0, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$UipToCommand;->uipAttributeData_:Ljava/lang/Object;

    .line 8579
    instance-of v1, v0, Ljava/lang/String;

    if-eqz v1, :cond_0

    .line 8580
    check-cast v0, Ljava/lang/String;

    .line 8588
    :goto_0
    return-object v0

    .line 8582
    :cond_0
    check-cast v0, Lcom/google/protobuf/ByteString;

    .line 8584
    invoke-virtual {v0}, Lcom/google/protobuf/ByteString;->toStringUtf8()Ljava/lang/String;

    move-result-object v1

    .line 8585
    invoke-virtual {v0}, Lcom/google/protobuf/ByteString;->isValidUtf8()Z

    move-result v0

    if-eqz v0, :cond_1

    .line 8586
    iput-object v1, p0, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$UipToCommand;->uipAttributeData_:Ljava/lang/Object;

    :cond_1
    move-object v0, v1

    .line 8588
    goto :goto_0
.end method

.method public getUipAttributeDataBytes()Lcom/google/protobuf/ByteString;
    .locals 2

    .prologue
    .line 8596
    iget-object v0, p0, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$UipToCommand;->uipAttributeData_:Ljava/lang/Object;

    .line 8597
    instance-of v1, v0, Ljava/lang/String;

    if-eqz v1, :cond_0

    .line 8598
    check-cast v0, Ljava/lang/String;

    .line 8599
    invoke-static {v0}, Lcom/google/protobuf/ByteString;->copyFromUtf8(Ljava/lang/String;)Lcom/google/protobuf/ByteString;

    move-result-object v0

    .line 8601
    iput-object v0, p0, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$UipToCommand;->uipAttributeData_:Ljava/lang/Object;

    .line 8604
    :goto_0
    return-object v0

    :cond_0
    check-cast v0, Lcom/google/protobuf/ByteString;

    goto :goto_0
.end method

.method public final getUnknownFields()Lcom/google/protobuf/UnknownFieldSet;
    .locals 1

    .prologue
    .line 8330
    iget-object v0, p0, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$UipToCommand;->unknownFields:Lcom/google/protobuf/UnknownFieldSet;

    return-object v0
.end method

.method public hasCommand()Z
    .locals 2

    .prologue
    const/4 v0, 0x1

    .line 8518
    iget v1, p0, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$UipToCommand;->bitField0_:I

    and-int/lit8 v1, v1, 0x1

    if-ne v1, v0, :cond_0

    :goto_0
    return v0

    :cond_0
    const/4 v0, 0x0

    goto :goto_0
.end method

.method public hasEvent()Z
    .locals 2

    .prologue
    .line 8534
    iget v0, p0, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$UipToCommand;->bitField0_:I

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

.method public hasIsSuccess()Z
    .locals 2

    .prologue
    .line 8556
    iget v0, p0, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$UipToCommand;->bitField0_:I

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

.method public hasUipAttributeData()Z
    .locals 2

    .prologue
    .line 8572
    iget v0, p0, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$UipToCommand;->bitField0_:I

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

.method protected internalGetFieldAccessorTable()Lcom/google/protobuf/GeneratedMessage$FieldAccessorTable;
    .locals 3

    .prologue
    .line 8408
    invoke-static {}, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage;->o()Lcom/google/protobuf/GeneratedMessage$FieldAccessorTable;

    move-result-object v0

    const-class v1, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$UipToCommand;

    const-class v2, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$UipToCommand$Builder;

    .line 8409
    invoke-virtual {v0, v1, v2}, Lcom/google/protobuf/GeneratedMessage$FieldAccessorTable;->ensureFieldAccessorsInitialized(Ljava/lang/Class;Ljava/lang/Class;)Lcom/google/protobuf/GeneratedMessage$FieldAccessorTable;

    move-result-object v0

    .line 8408
    return-object v0
.end method

.method public final isInitialized()Z
    .locals 4

    .prologue
    const/4 v0, 0x1

    const/4 v1, 0x0

    .line 8616
    iget-byte v2, p0, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$UipToCommand;->memoizedIsInitialized:B

    .line 8617
    const/4 v3, -0x1

    if-eq v2, v3, :cond_1

    if-ne v2, v0, :cond_0

    .line 8630
    :goto_0
    return v0

    :cond_0
    move v0, v1

    .line 8617
    goto :goto_0

    .line 8619
    :cond_1
    invoke-virtual {p0}, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$UipToCommand;->hasCommand()Z

    move-result v2

    if-nez v2, :cond_2

    .line 8620
    iput-byte v1, p0, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$UipToCommand;->memoizedIsInitialized:B

    move v0, v1

    .line 8621
    goto :goto_0

    .line 8623
    :cond_2
    invoke-virtual {p0}, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$UipToCommand;->hasEvent()Z

    move-result v2

    if-eqz v2, :cond_3

    .line 8624
    invoke-virtual {p0}, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$UipToCommand;->getEvent()Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$ControlEvent;

    move-result-object v2

    invoke-virtual {v2}, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$ControlEvent;->isInitialized()Z

    move-result v2

    if-nez v2, :cond_3

    .line 8625
    iput-byte v1, p0, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$UipToCommand;->memoizedIsInitialized:B

    move v0, v1

    .line 8626
    goto :goto_0

    .line 8629
    :cond_3
    iput-byte v0, p0, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$UipToCommand;->memoizedIsInitialized:B

    goto :goto_0
.end method

.method public newBuilderForType()Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$UipToCommand$Builder;
    .locals 1

    .prologue
    .line 8739
    invoke-static {}, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$UipToCommand;->newBuilder()Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$UipToCommand$Builder;

    move-result-object v0

    return-object v0
.end method

.method protected newBuilderForType(Lcom/google/protobuf/GeneratedMessage$BuilderParent;)Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$UipToCommand$Builder;
    .locals 2

    .prologue
    .line 8748
    new-instance v0, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$UipToCommand$Builder;

    const/4 v1, 0x0

    invoke-direct {v0, p1, v1}, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$UipToCommand$Builder;-><init>(Lcom/google/protobuf/GeneratedMessage$BuilderParent;Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$1;)V

    .line 8749
    return-object v0
.end method

.method public bridge synthetic newBuilderForType()Lcom/google/protobuf/Message$Builder;
    .locals 1

    .prologue
    .line 8307
    invoke-virtual {p0}, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$UipToCommand;->newBuilderForType()Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$UipToCommand$Builder;

    move-result-object v0

    return-object v0
.end method

.method protected bridge synthetic newBuilderForType(Lcom/google/protobuf/GeneratedMessage$BuilderParent;)Lcom/google/protobuf/Message$Builder;
    .locals 1

    .prologue
    .line 8307
    invoke-virtual {p0, p1}, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$UipToCommand;->newBuilderForType(Lcom/google/protobuf/GeneratedMessage$BuilderParent;)Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$UipToCommand$Builder;

    move-result-object v0

    return-object v0
.end method

.method public bridge synthetic newBuilderForType()Lcom/google/protobuf/MessageLite$Builder;
    .locals 1

    .prologue
    .line 8307
    invoke-virtual {p0}, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$UipToCommand;->newBuilderForType()Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$UipToCommand$Builder;

    move-result-object v0

    return-object v0
.end method

.method public toBuilder()Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$UipToCommand$Builder;
    .locals 1

    .prologue
    .line 8743
    invoke-static {p0}, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$UipToCommand;->newBuilder(Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$UipToCommand;)Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$UipToCommand$Builder;

    move-result-object v0

    return-object v0
.end method

.method public bridge synthetic toBuilder()Lcom/google/protobuf/Message$Builder;
    .locals 1

    .prologue
    .line 8307
    invoke-virtual {p0}, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$UipToCommand;->toBuilder()Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$UipToCommand$Builder;

    move-result-object v0

    return-object v0
.end method

.method public bridge synthetic toBuilder()Lcom/google/protobuf/MessageLite$Builder;
    .locals 1

    .prologue
    .line 8307
    invoke-virtual {p0}, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$UipToCommand;->toBuilder()Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$UipToCommand$Builder;

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
    .line 8682
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

    .line 8635
    invoke-virtual {p0}, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$UipToCommand;->getSerializedSize()I

    .line 8636
    iget v0, p0, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$UipToCommand;->bitField0_:I

    and-int/lit8 v0, v0, 0x1

    if-ne v0, v1, :cond_0

    .line 8637
    iget-object v0, p0, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$UipToCommand;->command_:Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$UipToCommand$Command_Type;

    invoke-virtual {v0}, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$UipToCommand$Command_Type;->getNumber()I

    move-result v0

    invoke-virtual {p1, v1, v0}, Lcom/google/protobuf/CodedOutputStream;->writeEnum(II)V

    .line 8639
    :cond_0
    iget v0, p0, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$UipToCommand;->bitField0_:I

    and-int/lit8 v0, v0, 0x2

    if-ne v0, v2, :cond_1

    .line 8640
    iget-object v0, p0, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$UipToCommand;->event_:Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$ControlEvent;

    invoke-virtual {p1, v2, v0}, Lcom/google/protobuf/CodedOutputStream;->writeMessage(ILcom/google/protobuf/MessageLite;)V

    .line 8642
    :cond_1
    iget v0, p0, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$UipToCommand;->bitField0_:I

    and-int/lit8 v0, v0, 0x4

    if-ne v0, v3, :cond_2

    .line 8643
    const/4 v0, 0x3

    iget-boolean v1, p0, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$UipToCommand;->isSuccess_:Z

    invoke-virtual {p1, v0, v1}, Lcom/google/protobuf/CodedOutputStream;->writeBool(IZ)V

    .line 8645
    :cond_2
    iget v0, p0, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$UipToCommand;->bitField0_:I

    and-int/lit8 v0, v0, 0x8

    const/16 v1, 0x8

    if-ne v0, v1, :cond_3

    .line 8646
    invoke-virtual {p0}, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$UipToCommand;->getUipAttributeDataBytes()Lcom/google/protobuf/ByteString;

    move-result-object v0

    invoke-virtual {p1, v3, v0}, Lcom/google/protobuf/CodedOutputStream;->writeBytes(ILcom/google/protobuf/ByteString;)V

    .line 8648
    :cond_3
    invoke-virtual {p0}, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$UipToCommand;->getUnknownFields()Lcom/google/protobuf/UnknownFieldSet;

    move-result-object v0

    invoke-virtual {v0, p1}, Lcom/google/protobuf/UnknownFieldSet;->writeTo(Lcom/google/protobuf/CodedOutputStream;)V

    .line 8649
    return-void
.end method
