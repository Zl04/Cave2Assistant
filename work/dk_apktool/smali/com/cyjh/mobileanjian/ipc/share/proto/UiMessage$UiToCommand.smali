.class public final Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$UiToCommand;
.super Lcom/google/protobuf/GeneratedMessage;
.source "SourceFile"

# interfaces
.implements Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$UiToCommandOrBuilder;


# annotations
.annotation system Ldalvik/annotation/EnclosingClass;
    value = Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage;
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x19
    name = "UiToCommand"
.end annotation

.annotation system Ldalvik/annotation/MemberClasses;
    value = {
        Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$UiToCommand$Builder;,
        Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$UiToCommand$Command_Type;
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
            "Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$UiToCommand;",
            ">;"
        }
    .end annotation
.end field

.field public static final VARTABLE_FIELD_NUMBER:I = 0x4

.field private static final defaultInstance:Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$UiToCommand;

.field private static final serialVersionUID:J


# instance fields
.field private bitField0_:I

.field private command_:Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$UiToCommand$Command_Type;

.field private event_:Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$ControlEvent;

.field private isSuccess_:Z

.field private memoizedIsInitialized:B

.field private memoizedSerializedSize:I

.field private final unknownFields:Lcom/google/protobuf/UnknownFieldSet;

.field private varTable_:Ljava/util/List;
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "Ljava/util/List",
            "<",
            "Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$ControlVar;",
            ">;"
        }
    .end annotation
.end field


# direct methods
.method static constructor <clinit>()V
    .locals 2

    .prologue
    .line 6460
    new-instance v0, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$UiToCommand$1;

    invoke-direct {v0}, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$UiToCommand$1;-><init>()V

    sput-object v0, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$UiToCommand;->PARSER:Lcom/google/protobuf/Parser;

    .line 7430
    new-instance v0, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$UiToCommand;

    const/4 v1, 0x1

    invoke-direct {v0, v1}, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$UiToCommand;-><init>(Z)V

    sput-object v0, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$UiToCommand;->defaultInstance:Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$UiToCommand;

    .line 7431
    sget-object v0, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$UiToCommand;->defaultInstance:Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$UiToCommand;

    invoke-direct {v0}, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$UiToCommand;->initFields()V

    .line 7432
    return-void
.end method

.method private constructor <init>(Lcom/google/protobuf/CodedInputStream;Lcom/google/protobuf/ExtensionRegistryLite;)V
    .locals 9
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Lcom/google/protobuf/InvalidProtocolBufferException;
        }
    .end annotation

    .prologue
    const/4 v2, 0x0

    const/4 v0, -0x1

    const/16 v7, 0x8

    const/4 v1, 0x1

    .line 6376
    invoke-direct {p0}, Lcom/google/protobuf/GeneratedMessage;-><init>()V

    .line 6654
    iput-byte v0, p0, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$UiToCommand;->memoizedIsInitialized:B

    .line 6697
    iput v0, p0, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$UiToCommand;->memoizedSerializedSize:I

    .line 6377
    invoke-direct {p0}, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$UiToCommand;->initFields()V

    .line 6380
    invoke-static {}, Lcom/google/protobuf/UnknownFieldSet;->newBuilder()Lcom/google/protobuf/UnknownFieldSet$Builder;

    move-result-object v5

    move v3, v2

    .line 6383
    :goto_0
    if-nez v2, :cond_2

    .line 6384
    :try_start_0
    invoke-virtual {p1}, Lcom/google/protobuf/CodedInputStream;->readTag()I

    move-result v0

    .line 6385
    sparse-switch v0, :sswitch_data_0

    .line 6390
    invoke-virtual {p0, p1, v5, p2, v0}, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$UiToCommand;->parseUnknownField(Lcom/google/protobuf/CodedInputStream;Lcom/google/protobuf/UnknownFieldSet$Builder;Lcom/google/protobuf/ExtensionRegistryLite;I)Z

    move-result v0

    if-nez v0, :cond_7

    move v0, v1

    move v2, v3

    :goto_1
    move v3, v2

    move v2, v0

    .line 6434
    goto :goto_0

    :sswitch_0
    move v0, v1

    move v2, v3

    .line 6388
    goto :goto_1

    .line 6397
    :sswitch_1
    invoke-virtual {p1}, Lcom/google/protobuf/CodedInputStream;->readEnum()I

    move-result v0

    .line 6398
    invoke-static {v0}, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$UiToCommand$Command_Type;->valueOf(I)Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$UiToCommand$Command_Type;

    move-result-object v4

    .line 6399
    if-nez v4, :cond_0

    .line 6400
    const/4 v4, 0x1

    invoke-virtual {v5, v4, v0}, Lcom/google/protobuf/UnknownFieldSet$Builder;->mergeVarintField(II)Lcom/google/protobuf/UnknownFieldSet$Builder;

    move v0, v2

    move v2, v3

    goto :goto_1

    .line 6402
    :cond_0
    iget v0, p0, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$UiToCommand;->bitField0_:I

    or-int/lit8 v0, v0, 0x1

    iput v0, p0, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$UiToCommand;->bitField0_:I

    .line 6403
    iput-object v4, p0, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$UiToCommand;->command_:Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$UiToCommand$Command_Type;

    move v0, v2

    move v2, v3

    .line 6405
    goto :goto_1

    .line 6408
    :sswitch_2
    const/4 v0, 0x0

    .line 6409
    iget v4, p0, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$UiToCommand;->bitField0_:I

    and-int/lit8 v4, v4, 0x2

    const/4 v6, 0x2

    if-ne v4, v6, :cond_6

    .line 6410
    iget-object v0, p0, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$UiToCommand;->event_:Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$ControlEvent;

    invoke-virtual {v0}, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$ControlEvent;->toBuilder()Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$ControlEvent$Builder;

    move-result-object v0

    move-object v4, v0

    .line 6412
    :goto_2
    sget-object v0, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$ControlEvent;->PARSER:Lcom/google/protobuf/Parser;

    invoke-virtual {p1, v0, p2}, Lcom/google/protobuf/CodedInputStream;->readMessage(Lcom/google/protobuf/Parser;Lcom/google/protobuf/ExtensionRegistryLite;)Lcom/google/protobuf/MessageLite;

    move-result-object v0

    check-cast v0, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$ControlEvent;

    iput-object v0, p0, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$UiToCommand;->event_:Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$ControlEvent;

    .line 6413
    if-eqz v4, :cond_1

    .line 6414
    iget-object v0, p0, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$UiToCommand;->event_:Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$ControlEvent;

    invoke-virtual {v4, v0}, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$ControlEvent$Builder;->mergeFrom(Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$ControlEvent;)Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$ControlEvent$Builder;

    .line 6415
    invoke-virtual {v4}, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$ControlEvent$Builder;->buildPartial()Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$ControlEvent;

    move-result-object v0

    iput-object v0, p0, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$UiToCommand;->event_:Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$ControlEvent;

    .line 6417
    :cond_1
    iget v0, p0, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$UiToCommand;->bitField0_:I

    or-int/lit8 v0, v0, 0x2

    iput v0, p0, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$UiToCommand;->bitField0_:I

    move v0, v2

    move v2, v3

    .line 6418
    goto :goto_1

    .line 6421
    :sswitch_3
    iget v0, p0, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$UiToCommand;->bitField0_:I

    or-int/lit8 v0, v0, 0x4

    iput v0, p0, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$UiToCommand;->bitField0_:I

    .line 6422
    invoke-virtual {p1}, Lcom/google/protobuf/CodedInputStream;->readBool()Z

    move-result v0

    iput-boolean v0, p0, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$UiToCommand;->isSuccess_:Z

    move v0, v2

    move v2, v3

    .line 6423
    goto :goto_1

    .line 6426
    :sswitch_4
    and-int/lit8 v0, v3, 0x8

    if-eq v0, v7, :cond_5

    .line 6427
    new-instance v0, Ljava/util/ArrayList;

    invoke-direct {v0}, Ljava/util/ArrayList;-><init>()V

    iput-object v0, p0, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$UiToCommand;->varTable_:Ljava/util/List;
    :try_end_0
    .catch Lcom/google/protobuf/InvalidProtocolBufferException; {:try_start_0 .. :try_end_0} :catch_0
    .catch Ljava/io/IOException; {:try_start_0 .. :try_end_0} :catch_1
    .catchall {:try_start_0 .. :try_end_0} :catchall_0

    .line 6428
    or-int/lit8 v0, v3, 0x8

    .line 6430
    :goto_3
    :try_start_1
    iget-object v3, p0, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$UiToCommand;->varTable_:Ljava/util/List;

    sget-object v4, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$ControlVar;->PARSER:Lcom/google/protobuf/Parser;

    invoke-virtual {p1, v4, p2}, Lcom/google/protobuf/CodedInputStream;->readMessage(Lcom/google/protobuf/Parser;Lcom/google/protobuf/ExtensionRegistryLite;)Lcom/google/protobuf/MessageLite;

    move-result-object v4

    invoke-interface {v3, v4}, Ljava/util/List;->add(Ljava/lang/Object;)Z
    :try_end_1
    .catch Lcom/google/protobuf/InvalidProtocolBufferException; {:try_start_1 .. :try_end_1} :catch_3
    .catch Ljava/io/IOException; {:try_start_1 .. :try_end_1} :catch_2
    .catchall {:try_start_1 .. :try_end_1} :catchall_1

    move v8, v2

    move v2, v0

    move v0, v8

    goto :goto_1

    .line 6441
    :cond_2
    and-int/lit8 v0, v3, 0x8

    if-ne v0, v7, :cond_3

    .line 6442
    iget-object v0, p0, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$UiToCommand;->varTable_:Ljava/util/List;

    invoke-static {v0}, Ljava/util/Collections;->unmodifiableList(Ljava/util/List;)Ljava/util/List;

    move-result-object v0

    iput-object v0, p0, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$UiToCommand;->varTable_:Ljava/util/List;

    .line 6444
    :cond_3
    invoke-virtual {v5}, Lcom/google/protobuf/UnknownFieldSet$Builder;->build()Lcom/google/protobuf/UnknownFieldSet;

    move-result-object v0

    iput-object v0, p0, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$UiToCommand;->unknownFields:Lcom/google/protobuf/UnknownFieldSet;

    .line 6445
    invoke-virtual {p0}, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$UiToCommand;->makeExtensionsImmutable()V

    .line 6447
    return-void

    .line 6435
    :catch_0
    move-exception v0

    .line 6436
    :goto_4
    :try_start_2
    invoke-virtual {v0, p0}, Lcom/google/protobuf/InvalidProtocolBufferException;->setUnfinishedMessage(Lcom/google/protobuf/MessageLite;)Lcom/google/protobuf/InvalidProtocolBufferException;

    move-result-object v0

    throw v0
    :try_end_2
    .catchall {:try_start_2 .. :try_end_2} :catchall_0

    .line 6441
    :catchall_0
    move-exception v0

    :goto_5
    and-int/lit8 v1, v3, 0x8

    if-ne v1, v7, :cond_4

    .line 6442
    iget-object v1, p0, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$UiToCommand;->varTable_:Ljava/util/List;

    invoke-static {v1}, Ljava/util/Collections;->unmodifiableList(Ljava/util/List;)Ljava/util/List;

    move-result-object v1

    iput-object v1, p0, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$UiToCommand;->varTable_:Ljava/util/List;

    .line 6444
    :cond_4
    invoke-virtual {v5}, Lcom/google/protobuf/UnknownFieldSet$Builder;->build()Lcom/google/protobuf/UnknownFieldSet;

    move-result-object v1

    iput-object v1, p0, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$UiToCommand;->unknownFields:Lcom/google/protobuf/UnknownFieldSet;

    .line 6445
    invoke-virtual {p0}, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$UiToCommand;->makeExtensionsImmutable()V

    throw v0

    .line 6437
    :catch_1
    move-exception v0

    .line 6438
    :goto_6
    :try_start_3
    new-instance v1, Lcom/google/protobuf/InvalidProtocolBufferException;

    .line 6439
    invoke-virtual {v0}, Ljava/io/IOException;->getMessage()Ljava/lang/String;

    move-result-object v0

    invoke-direct {v1, v0}, Lcom/google/protobuf/InvalidProtocolBufferException;-><init>(Ljava/lang/String;)V

    invoke-virtual {v1, p0}, Lcom/google/protobuf/InvalidProtocolBufferException;->setUnfinishedMessage(Lcom/google/protobuf/MessageLite;)Lcom/google/protobuf/InvalidProtocolBufferException;

    move-result-object v0

    throw v0
    :try_end_3
    .catchall {:try_start_3 .. :try_end_3} :catchall_0

    .line 6441
    :catchall_1
    move-exception v1

    move v3, v0

    move-object v0, v1

    goto :goto_5

    .line 6437
    :catch_2
    move-exception v1

    move v3, v0

    move-object v0, v1

    goto :goto_6

    .line 6435
    :catch_3
    move-exception v1

    move v3, v0

    move-object v0, v1

    goto :goto_4

    :cond_5
    move v0, v3

    goto :goto_3

    :cond_6
    move-object v4, v0

    goto/16 :goto_2

    :cond_7
    move v0, v2

    move v2, v3

    goto/16 :goto_1

    .line 6385
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
    .line 6348
    invoke-direct {p0, p1, p2}, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$UiToCommand;-><init>(Lcom/google/protobuf/CodedInputStream;Lcom/google/protobuf/ExtensionRegistryLite;)V

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

    .line 6353
    invoke-direct {p0, p1}, Lcom/google/protobuf/GeneratedMessage;-><init>(Lcom/google/protobuf/GeneratedMessage$Builder;)V

    .line 6654
    iput-byte v0, p0, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$UiToCommand;->memoizedIsInitialized:B

    .line 6697
    iput v0, p0, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$UiToCommand;->memoizedSerializedSize:I

    .line 6354
    invoke-virtual {p1}, Lcom/google/protobuf/GeneratedMessage$Builder;->getUnknownFields()Lcom/google/protobuf/UnknownFieldSet;

    move-result-object v0

    iput-object v0, p0, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$UiToCommand;->unknownFields:Lcom/google/protobuf/UnknownFieldSet;

    .line 6355
    return-void
.end method

.method synthetic constructor <init>(Lcom/google/protobuf/GeneratedMessage$Builder;Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$1;)V
    .locals 0

    .prologue
    .line 6348
    invoke-direct {p0, p1}, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$UiToCommand;-><init>(Lcom/google/protobuf/GeneratedMessage$Builder;)V

    return-void
.end method

.method private constructor <init>(Z)V
    .locals 1

    .prologue
    const/4 v0, -0x1

    .line 6356
    invoke-direct {p0}, Lcom/google/protobuf/GeneratedMessage;-><init>()V

    .line 6654
    iput-byte v0, p0, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$UiToCommand;->memoizedIsInitialized:B

    .line 6697
    iput v0, p0, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$UiToCommand;->memoizedSerializedSize:I

    .line 6356
    invoke-static {}, Lcom/google/protobuf/UnknownFieldSet;->getDefaultInstance()Lcom/google/protobuf/UnknownFieldSet;

    move-result-object v0

    iput-object v0, p0, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$UiToCommand;->unknownFields:Lcom/google/protobuf/UnknownFieldSet;

    return-void
.end method

.method static synthetic access$7200()Z
    .locals 1

    .prologue
    .line 6348
    sget-boolean v0, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$UiToCommand;->alwaysUseFieldBuilders:Z

    return v0
.end method

.method static synthetic access$7402(Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$UiToCommand;Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$UiToCommand$Command_Type;)Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$UiToCommand$Command_Type;
    .locals 0

    .prologue
    .line 6348
    iput-object p1, p0, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$UiToCommand;->command_:Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$UiToCommand$Command_Type;

    return-object p1
.end method

.method static synthetic access$7502(Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$UiToCommand;Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$ControlEvent;)Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$ControlEvent;
    .locals 0

    .prologue
    .line 6348
    iput-object p1, p0, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$UiToCommand;->event_:Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$ControlEvent;

    return-object p1
.end method

.method static synthetic access$7602(Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$UiToCommand;Z)Z
    .locals 0

    .prologue
    .line 6348
    iput-boolean p1, p0, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$UiToCommand;->isSuccess_:Z

    return p1
.end method

.method static synthetic access$7700(Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$UiToCommand;)Ljava/util/List;
    .locals 1

    .prologue
    .line 6348
    iget-object v0, p0, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$UiToCommand;->varTable_:Ljava/util/List;

    return-object v0
.end method

.method static synthetic access$7702(Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$UiToCommand;Ljava/util/List;)Ljava/util/List;
    .locals 0

    .prologue
    .line 6348
    iput-object p1, p0, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$UiToCommand;->varTable_:Ljava/util/List;

    return-object p1
.end method

.method static synthetic access$7802(Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$UiToCommand;I)I
    .locals 0

    .prologue
    .line 6348
    iput p1, p0, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$UiToCommand;->bitField0_:I

    return p1
.end method

.method static synthetic access$7900()Z
    .locals 1

    .prologue
    .line 6348
    sget-boolean v0, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$UiToCommand;->alwaysUseFieldBuilders:Z

    return v0
.end method

.method public static getDefaultInstance()Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$UiToCommand;
    .locals 1

    .prologue
    .line 6360
    sget-object v0, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$UiToCommand;->defaultInstance:Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$UiToCommand;

    return-object v0
.end method

.method public static final getDescriptor()Lcom/google/protobuf/Descriptors$Descriptor;
    .locals 1

    .prologue
    .line 6450
    invoke-static {}, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage;->j()Lcom/google/protobuf/Descriptors$Descriptor;

    move-result-object v0

    return-object v0
.end method

.method private initFields()V
    .locals 1

    .prologue
    .line 6649
    sget-object v0, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$UiToCommand$Command_Type;->EVENT:Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$UiToCommand$Command_Type;

    iput-object v0, p0, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$UiToCommand;->command_:Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$UiToCommand$Command_Type;

    .line 6650
    invoke-static {}, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$ControlEvent;->getDefaultInstance()Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$ControlEvent;

    move-result-object v0

    iput-object v0, p0, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$UiToCommand;->event_:Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$ControlEvent;

    .line 6651
    const/4 v0, 0x0

    iput-boolean v0, p0, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$UiToCommand;->isSuccess_:Z

    .line 6652
    invoke-static {}, Ljava/util/Collections;->emptyList()Ljava/util/List;

    move-result-object v0

    iput-object v0, p0, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$UiToCommand;->varTable_:Ljava/util/List;

    .line 6653
    return-void
.end method

.method public static newBuilder()Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$UiToCommand$Builder;
    .locals 1

    .prologue
    .line 6784
    invoke-static {}, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$UiToCommand$Builder;->access$7000()Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$UiToCommand$Builder;

    move-result-object v0

    return-object v0
.end method

.method public static newBuilder(Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$UiToCommand;)Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$UiToCommand$Builder;
    .locals 1

    .prologue
    .line 6787
    invoke-static {}, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$UiToCommand;->newBuilder()Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$UiToCommand$Builder;

    move-result-object v0

    invoke-virtual {v0, p0}, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$UiToCommand$Builder;->mergeFrom(Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$UiToCommand;)Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$UiToCommand$Builder;

    move-result-object v0

    return-object v0
.end method

.method public static parseDelimitedFrom(Ljava/io/InputStream;)Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$UiToCommand;
    .locals 1
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljava/io/IOException;
        }
    .end annotation

    .prologue
    .line 6764
    sget-object v0, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$UiToCommand;->PARSER:Lcom/google/protobuf/Parser;

    invoke-interface {v0, p0}, Lcom/google/protobuf/Parser;->parseDelimitedFrom(Ljava/io/InputStream;)Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$UiToCommand;

    return-object v0
.end method

.method public static parseDelimitedFrom(Ljava/io/InputStream;Lcom/google/protobuf/ExtensionRegistryLite;)Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$UiToCommand;
    .locals 1
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljava/io/IOException;
        }
    .end annotation

    .prologue
    .line 6770
    sget-object v0, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$UiToCommand;->PARSER:Lcom/google/protobuf/Parser;

    invoke-interface {v0, p0, p1}, Lcom/google/protobuf/Parser;->parseDelimitedFrom(Ljava/io/InputStream;Lcom/google/protobuf/ExtensionRegistryLite;)Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$UiToCommand;

    return-object v0
.end method

.method public static parseFrom(Lcom/google/protobuf/ByteString;)Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$UiToCommand;
    .locals 1
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Lcom/google/protobuf/InvalidProtocolBufferException;
        }
    .end annotation

    .prologue
    .line 6734
    sget-object v0, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$UiToCommand;->PARSER:Lcom/google/protobuf/Parser;

    invoke-interface {v0, p0}, Lcom/google/protobuf/Parser;->parseFrom(Lcom/google/protobuf/ByteString;)Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$UiToCommand;

    return-object v0
.end method

.method public static parseFrom(Lcom/google/protobuf/ByteString;Lcom/google/protobuf/ExtensionRegistryLite;)Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$UiToCommand;
    .locals 1
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Lcom/google/protobuf/InvalidProtocolBufferException;
        }
    .end annotation

    .prologue
    .line 6740
    sget-object v0, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$UiToCommand;->PARSER:Lcom/google/protobuf/Parser;

    invoke-interface {v0, p0, p1}, Lcom/google/protobuf/Parser;->parseFrom(Lcom/google/protobuf/ByteString;Lcom/google/protobuf/ExtensionRegistryLite;)Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$UiToCommand;

    return-object v0
.end method

.method public static parseFrom(Lcom/google/protobuf/CodedInputStream;)Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$UiToCommand;
    .locals 1
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljava/io/IOException;
        }
    .end annotation

    .prologue
    .line 6775
    sget-object v0, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$UiToCommand;->PARSER:Lcom/google/protobuf/Parser;

    invoke-interface {v0, p0}, Lcom/google/protobuf/Parser;->parseFrom(Lcom/google/protobuf/CodedInputStream;)Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$UiToCommand;

    return-object v0
.end method

.method public static parseFrom(Lcom/google/protobuf/CodedInputStream;Lcom/google/protobuf/ExtensionRegistryLite;)Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$UiToCommand;
    .locals 1
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljava/io/IOException;
        }
    .end annotation

    .prologue
    .line 6781
    sget-object v0, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$UiToCommand;->PARSER:Lcom/google/protobuf/Parser;

    invoke-interface {v0, p0, p1}, Lcom/google/protobuf/Parser;->parseFrom(Lcom/google/protobuf/CodedInputStream;Lcom/google/protobuf/ExtensionRegistryLite;)Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$UiToCommand;

    return-object v0
.end method

.method public static parseFrom(Ljava/io/InputStream;)Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$UiToCommand;
    .locals 1
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljava/io/IOException;
        }
    .end annotation

    .prologue
    .line 6754
    sget-object v0, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$UiToCommand;->PARSER:Lcom/google/protobuf/Parser;

    invoke-interface {v0, p0}, Lcom/google/protobuf/Parser;->parseFrom(Ljava/io/InputStream;)Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$UiToCommand;

    return-object v0
.end method

.method public static parseFrom(Ljava/io/InputStream;Lcom/google/protobuf/ExtensionRegistryLite;)Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$UiToCommand;
    .locals 1
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljava/io/IOException;
        }
    .end annotation

    .prologue
    .line 6760
    sget-object v0, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$UiToCommand;->PARSER:Lcom/google/protobuf/Parser;

    invoke-interface {v0, p0, p1}, Lcom/google/protobuf/Parser;->parseFrom(Ljava/io/InputStream;Lcom/google/protobuf/ExtensionRegistryLite;)Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$UiToCommand;

    return-object v0
.end method

.method public static parseFrom([B)Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$UiToCommand;
    .locals 1
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Lcom/google/protobuf/InvalidProtocolBufferException;
        }
    .end annotation

    .prologue
    .line 6744
    sget-object v0, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$UiToCommand;->PARSER:Lcom/google/protobuf/Parser;

    invoke-interface {v0, p0}, Lcom/google/protobuf/Parser;->parseFrom([B)Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$UiToCommand;

    return-object v0
.end method

.method public static parseFrom([BLcom/google/protobuf/ExtensionRegistryLite;)Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$UiToCommand;
    .locals 1
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Lcom/google/protobuf/InvalidProtocolBufferException;
        }
    .end annotation

    .prologue
    .line 6750
    sget-object v0, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$UiToCommand;->PARSER:Lcom/google/protobuf/Parser;

    invoke-interface {v0, p0, p1}, Lcom/google/protobuf/Parser;->parseFrom([BLcom/google/protobuf/ExtensionRegistryLite;)Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$UiToCommand;

    return-object v0
.end method


# virtual methods
.method public getCommand()Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$UiToCommand$Command_Type;
    .locals 1

    .prologue
    .line 6571
    iget-object v0, p0, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$UiToCommand;->command_:Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$UiToCommand$Command_Type;

    return-object v0
.end method

.method public getDefaultInstanceForType()Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$UiToCommand;
    .locals 1

    .prologue
    .line 6364
    sget-object v0, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$UiToCommand;->defaultInstance:Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$UiToCommand;

    return-object v0
.end method

.method public bridge synthetic getDefaultInstanceForType()Lcom/google/protobuf/Message;
    .locals 1

    .prologue
    .line 6348
    invoke-virtual {p0}, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$UiToCommand;->getDefaultInstanceForType()Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$UiToCommand;

    move-result-object v0

    return-object v0
.end method

.method public bridge synthetic getDefaultInstanceForType()Lcom/google/protobuf/MessageLite;
    .locals 1

    .prologue
    .line 6348
    invoke-virtual {p0}, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$UiToCommand;->getDefaultInstanceForType()Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$UiToCommand;

    move-result-object v0

    return-object v0
.end method

.method public getEvent()Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$ControlEvent;
    .locals 1

    .prologue
    .line 6587
    iget-object v0, p0, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$UiToCommand;->event_:Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$ControlEvent;

    return-object v0
.end method

.method public getEventOrBuilder()Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$ControlEventOrBuilder;
    .locals 1

    .prologue
    .line 6593
    iget-object v0, p0, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$UiToCommand;->event_:Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$ControlEvent;

    return-object v0
.end method

.method public getIsSuccess()Z
    .locals 1

    .prologue
    .line 6609
    iget-boolean v0, p0, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$UiToCommand;->isSuccess_:Z

    return v0
.end method

.method public getParserForType()Lcom/google/protobuf/Parser;
    .locals 1
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "()",
            "Lcom/google/protobuf/Parser",
            "<",
            "Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$UiToCommand;",
            ">;"
        }
    .end annotation

    .prologue
    .line 6472
    sget-object v0, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$UiToCommand;->PARSER:Lcom/google/protobuf/Parser;

    return-object v0
.end method

.method public getSerializedSize()I
    .locals 6

    .prologue
    const/4 v5, 0x4

    const/4 v4, 0x2

    const/4 v3, 0x1

    const/4 v1, 0x0

    .line 6699
    iget v0, p0, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$UiToCommand;->memoizedSerializedSize:I

    .line 6700
    const/4 v2, -0x1

    if-eq v0, v2, :cond_0

    .line 6721
    :goto_0
    return v0

    .line 6703
    :cond_0
    iget v0, p0, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$UiToCommand;->bitField0_:I

    and-int/lit8 v0, v0, 0x1

    if-ne v0, v3, :cond_4

    .line 6704
    iget-object v0, p0, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$UiToCommand;->command_:Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$UiToCommand$Command_Type;

    .line 6705
    invoke-virtual {v0}, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$UiToCommand$Command_Type;->getNumber()I

    move-result v0

    invoke-static {v3, v0}, Lcom/google/protobuf/CodedOutputStream;->computeEnumSize(II)I

    move-result v0

    add-int/2addr v0, v1

    .line 6707
    :goto_1
    iget v2, p0, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$UiToCommand;->bitField0_:I

    and-int/lit8 v2, v2, 0x2

    if-ne v2, v4, :cond_1

    .line 6708
    iget-object v2, p0, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$UiToCommand;->event_:Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$ControlEvent;

    .line 6709
    invoke-static {v4, v2}, Lcom/google/protobuf/CodedOutputStream;->computeMessageSize(ILcom/google/protobuf/MessageLite;)I

    move-result v2

    add-int/2addr v0, v2

    .line 6711
    :cond_1
    iget v2, p0, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$UiToCommand;->bitField0_:I

    and-int/lit8 v2, v2, 0x4

    if-ne v2, v5, :cond_2

    .line 6712
    const/4 v2, 0x3

    iget-boolean v3, p0, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$UiToCommand;->isSuccess_:Z

    .line 6713
    invoke-static {v2, v3}, Lcom/google/protobuf/CodedOutputStream;->computeBoolSize(IZ)I

    move-result v2

    add-int/2addr v0, v2

    :cond_2
    move v2, v0

    .line 6715
    :goto_2
    iget-object v0, p0, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$UiToCommand;->varTable_:Ljava/util/List;

    invoke-interface {v0}, Ljava/util/List;->size()I

    move-result v0

    if-ge v1, v0, :cond_3

    .line 6716
    iget-object v0, p0, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$UiToCommand;->varTable_:Ljava/util/List;

    .line 6717
    invoke-interface {v0, v1}, Ljava/util/List;->get(I)Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Lcom/google/protobuf/MessageLite;

    invoke-static {v5, v0}, Lcom/google/protobuf/CodedOutputStream;->computeMessageSize(ILcom/google/protobuf/MessageLite;)I

    move-result v0

    add-int/2addr v0, v2

    .line 6715
    add-int/lit8 v1, v1, 0x1

    move v2, v0

    goto :goto_2

    .line 6719
    :cond_3
    invoke-virtual {p0}, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$UiToCommand;->getUnknownFields()Lcom/google/protobuf/UnknownFieldSet;

    move-result-object v0

    invoke-virtual {v0}, Lcom/google/protobuf/UnknownFieldSet;->getSerializedSize()I

    move-result v0

    add-int/2addr v0, v2

    .line 6720
    iput v0, p0, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$UiToCommand;->memoizedSerializedSize:I

    goto :goto_0

    :cond_4
    move v0, v1

    goto :goto_1
.end method

.method public final getUnknownFields()Lcom/google/protobuf/UnknownFieldSet;
    .locals 1

    .prologue
    .line 6371
    iget-object v0, p0, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$UiToCommand;->unknownFields:Lcom/google/protobuf/UnknownFieldSet;

    return-object v0
.end method

.method public getVarTable(I)Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$ControlVar;
    .locals 1

    .prologue
    .line 6638
    iget-object v0, p0, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$UiToCommand;->varTable_:Ljava/util/List;

    invoke-interface {v0, p1}, Ljava/util/List;->get(I)Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$ControlVar;

    return-object v0
.end method

.method public getVarTableCount()I
    .locals 1

    .prologue
    .line 6632
    iget-object v0, p0, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$UiToCommand;->varTable_:Ljava/util/List;

    invoke-interface {v0}, Ljava/util/List;->size()I

    move-result v0

    return v0
.end method

.method public getVarTableList()Ljava/util/List;
    .locals 1
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "()",
            "Ljava/util/List",
            "<",
            "Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$ControlVar;",
            ">;"
        }
    .end annotation

    .prologue
    .line 6619
    iget-object v0, p0, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$UiToCommand;->varTable_:Ljava/util/List;

    return-object v0
.end method

.method public getVarTableOrBuilder(I)Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$ControlVarOrBuilder;
    .locals 1

    .prologue
    .line 6645
    iget-object v0, p0, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$UiToCommand;->varTable_:Ljava/util/List;

    invoke-interface {v0, p1}, Ljava/util/List;->get(I)Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$ControlVarOrBuilder;

    return-object v0
.end method

.method public getVarTableOrBuilderList()Ljava/util/List;
    .locals 1
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "()",
            "Ljava/util/List",
            "<+",
            "Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$ControlVarOrBuilder;",
            ">;"
        }
    .end annotation

    .prologue
    .line 6626
    iget-object v0, p0, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$UiToCommand;->varTable_:Ljava/util/List;

    return-object v0
.end method

.method public hasCommand()Z
    .locals 2

    .prologue
    const/4 v0, 0x1

    .line 6565
    iget v1, p0, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$UiToCommand;->bitField0_:I

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
    .line 6581
    iget v0, p0, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$UiToCommand;->bitField0_:I

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
    .line 6603
    iget v0, p0, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$UiToCommand;->bitField0_:I

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
    .line 6455
    invoke-static {}, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage;->k()Lcom/google/protobuf/GeneratedMessage$FieldAccessorTable;

    move-result-object v0

    const-class v1, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$UiToCommand;

    const-class v2, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$UiToCommand$Builder;

    .line 6456
    invoke-virtual {v0, v1, v2}, Lcom/google/protobuf/GeneratedMessage$FieldAccessorTable;->ensureFieldAccessorsInitialized(Ljava/lang/Class;Ljava/lang/Class;)Lcom/google/protobuf/GeneratedMessage$FieldAccessorTable;

    move-result-object v0

    .line 6455
    return-object v0
.end method

.method public final isInitialized()Z
    .locals 4

    .prologue
    const/4 v0, 0x1

    const/4 v1, 0x0

    .line 6656
    iget-byte v2, p0, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$UiToCommand;->memoizedIsInitialized:B

    .line 6657
    const/4 v3, -0x1

    if-eq v2, v3, :cond_1

    if-ne v2, v0, :cond_0

    :goto_0
    move v1, v0

    .line 6676
    :goto_1
    return v1

    :cond_0
    move v0, v1

    .line 6657
    goto :goto_0

    .line 6659
    :cond_1
    invoke-virtual {p0}, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$UiToCommand;->hasCommand()Z

    move-result v2

    if-nez v2, :cond_2

    .line 6660
    iput-byte v1, p0, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$UiToCommand;->memoizedIsInitialized:B

    goto :goto_1

    .line 6663
    :cond_2
    invoke-virtual {p0}, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$UiToCommand;->hasEvent()Z

    move-result v2

    if-eqz v2, :cond_3

    .line 6664
    invoke-virtual {p0}, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$UiToCommand;->getEvent()Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$ControlEvent;

    move-result-object v2

    invoke-virtual {v2}, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$ControlEvent;->isInitialized()Z

    move-result v2

    if-nez v2, :cond_3

    .line 6665
    iput-byte v1, p0, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$UiToCommand;->memoizedIsInitialized:B

    goto :goto_1

    :cond_3
    move v2, v1

    .line 6669
    :goto_2
    invoke-virtual {p0}, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$UiToCommand;->getVarTableCount()I

    move-result v3

    if-ge v2, v3, :cond_5

    .line 6670
    invoke-virtual {p0, v2}, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$UiToCommand;->getVarTable(I)Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$ControlVar;

    move-result-object v3

    invoke-virtual {v3}, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$ControlVar;->isInitialized()Z

    move-result v3

    if-nez v3, :cond_4

    .line 6671
    iput-byte v1, p0, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$UiToCommand;->memoizedIsInitialized:B

    goto :goto_1

    .line 6669
    :cond_4
    add-int/lit8 v2, v2, 0x1

    goto :goto_2

    .line 6675
    :cond_5
    iput-byte v0, p0, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$UiToCommand;->memoizedIsInitialized:B

    move v1, v0

    .line 6676
    goto :goto_1
.end method

.method public newBuilderForType()Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$UiToCommand$Builder;
    .locals 1

    .prologue
    .line 6785
    invoke-static {}, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$UiToCommand;->newBuilder()Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$UiToCommand$Builder;

    move-result-object v0

    return-object v0
.end method

.method protected newBuilderForType(Lcom/google/protobuf/GeneratedMessage$BuilderParent;)Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$UiToCommand$Builder;
    .locals 2

    .prologue
    .line 6794
    new-instance v0, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$UiToCommand$Builder;

    const/4 v1, 0x0

    invoke-direct {v0, p1, v1}, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$UiToCommand$Builder;-><init>(Lcom/google/protobuf/GeneratedMessage$BuilderParent;Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$1;)V

    .line 6795
    return-object v0
.end method

.method public bridge synthetic newBuilderForType()Lcom/google/protobuf/Message$Builder;
    .locals 1

    .prologue
    .line 6348
    invoke-virtual {p0}, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$UiToCommand;->newBuilderForType()Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$UiToCommand$Builder;

    move-result-object v0

    return-object v0
.end method

.method protected bridge synthetic newBuilderForType(Lcom/google/protobuf/GeneratedMessage$BuilderParent;)Lcom/google/protobuf/Message$Builder;
    .locals 1

    .prologue
    .line 6348
    invoke-virtual {p0, p1}, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$UiToCommand;->newBuilderForType(Lcom/google/protobuf/GeneratedMessage$BuilderParent;)Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$UiToCommand$Builder;

    move-result-object v0

    return-object v0
.end method

.method public bridge synthetic newBuilderForType()Lcom/google/protobuf/MessageLite$Builder;
    .locals 1

    .prologue
    .line 6348
    invoke-virtual {p0}, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$UiToCommand;->newBuilderForType()Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$UiToCommand$Builder;

    move-result-object v0

    return-object v0
.end method

.method public toBuilder()Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$UiToCommand$Builder;
    .locals 1

    .prologue
    .line 6789
    invoke-static {p0}, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$UiToCommand;->newBuilder(Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$UiToCommand;)Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$UiToCommand$Builder;

    move-result-object v0

    return-object v0
.end method

.method public bridge synthetic toBuilder()Lcom/google/protobuf/Message$Builder;
    .locals 1

    .prologue
    .line 6348
    invoke-virtual {p0}, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$UiToCommand;->toBuilder()Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$UiToCommand$Builder;

    move-result-object v0

    return-object v0
.end method

.method public bridge synthetic toBuilder()Lcom/google/protobuf/MessageLite$Builder;
    .locals 1

    .prologue
    .line 6348
    invoke-virtual {p0}, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$UiToCommand;->toBuilder()Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$UiToCommand$Builder;

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
    .line 6728
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

    .line 6681
    invoke-virtual {p0}, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$UiToCommand;->getSerializedSize()I

    .line 6682
    iget v0, p0, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$UiToCommand;->bitField0_:I

    and-int/lit8 v0, v0, 0x1

    if-ne v0, v1, :cond_0

    .line 6683
    iget-object v0, p0, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$UiToCommand;->command_:Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$UiToCommand$Command_Type;

    invoke-virtual {v0}, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$UiToCommand$Command_Type;->getNumber()I

    move-result v0

    invoke-virtual {p1, v1, v0}, Lcom/google/protobuf/CodedOutputStream;->writeEnum(II)V

    .line 6685
    :cond_0
    iget v0, p0, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$UiToCommand;->bitField0_:I

    and-int/lit8 v0, v0, 0x2

    if-ne v0, v2, :cond_1

    .line 6686
    iget-object v0, p0, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$UiToCommand;->event_:Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$ControlEvent;

    invoke-virtual {p1, v2, v0}, Lcom/google/protobuf/CodedOutputStream;->writeMessage(ILcom/google/protobuf/MessageLite;)V

    .line 6688
    :cond_1
    iget v0, p0, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$UiToCommand;->bitField0_:I

    and-int/lit8 v0, v0, 0x4

    if-ne v0, v3, :cond_2

    .line 6689
    const/4 v0, 0x3

    iget-boolean v1, p0, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$UiToCommand;->isSuccess_:Z

    invoke-virtual {p1, v0, v1}, Lcom/google/protobuf/CodedOutputStream;->writeBool(IZ)V

    .line 6691
    :cond_2
    const/4 v0, 0x0

    move v1, v0

    :goto_0
    iget-object v0, p0, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$UiToCommand;->varTable_:Ljava/util/List;

    invoke-interface {v0}, Ljava/util/List;->size()I

    move-result v0

    if-ge v1, v0, :cond_3

    .line 6692
    iget-object v0, p0, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$UiToCommand;->varTable_:Ljava/util/List;

    invoke-interface {v0, v1}, Ljava/util/List;->get(I)Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Lcom/google/protobuf/MessageLite;

    invoke-virtual {p1, v3, v0}, Lcom/google/protobuf/CodedOutputStream;->writeMessage(ILcom/google/protobuf/MessageLite;)V

    .line 6691
    add-int/lit8 v0, v1, 0x1

    move v1, v0

    goto :goto_0

    .line 6694
    :cond_3
    invoke-virtual {p0}, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$UiToCommand;->getUnknownFields()Lcom/google/protobuf/UnknownFieldSet;

    move-result-object v0

    invoke-virtual {v0, p1}, Lcom/google/protobuf/UnknownFieldSet;->writeTo(Lcom/google/protobuf/CodedOutputStream;)V

    .line 6695
    return-void
.end method
