.class public final Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$Padding_Var;
.super Lcom/google/protobuf/GeneratedMessage;
.source "SourceFile"

# interfaces
.implements Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$Padding_VarOrBuilder;


# annotations
.annotation system Ldalvik/annotation/EnclosingClass;
    value = Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage;
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x19
    name = "Padding_Var"
.end annotation

.annotation system Ldalvik/annotation/MemberClasses;
    value = {
        Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$Padding_Var$Builder;
    }
.end annotation


# static fields
.field public static final BOTTOM_FIELD_NUMBER:I = 0x3

.field public static final LEFT_FIELD_NUMBER:I = 0x2

.field public static PARSER:Lcom/google/protobuf/Parser; = null
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "Lcom/google/protobuf/Parser",
            "<",
            "Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$Padding_Var;",
            ">;"
        }
    .end annotation
.end field

.field public static final RIGHT_FIELD_NUMBER:I = 0x4

.field public static final TOP_FIELD_NUMBER:I = 0x1

.field private static final defaultInstance:Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$Padding_Var;

.field private static final serialVersionUID:J


# instance fields
.field private bitField0_:I

.field private bottom_:I

.field private left_:I

.field private memoizedIsInitialized:B

.field private memoizedSerializedSize:I

.field private right_:I

.field private top_:I

.field private final unknownFields:Lcom/google/protobuf/UnknownFieldSet;


# direct methods
.method static constructor <clinit>()V
    .locals 2

    .prologue
    .line 149
    new-instance v0, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$Padding_Var$1;

    invoke-direct {v0}, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$Padding_Var$1;-><init>()V

    sput-object v0, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$Padding_Var;->PARSER:Lcom/google/protobuf/Parser;

    .line 675
    new-instance v0, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$Padding_Var;

    const/4 v1, 0x1

    invoke-direct {v0, v1}, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$Padding_Var;-><init>(Z)V

    sput-object v0, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$Padding_Var;->defaultInstance:Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$Padding_Var;

    .line 676
    sget-object v0, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$Padding_Var;->defaultInstance:Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$Padding_Var;

    invoke-direct {v0}, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$Padding_Var;->initFields()V

    .line 677
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

    .line 85
    invoke-direct {p0}, Lcom/google/protobuf/GeneratedMessage;-><init>()V

    .line 235
    iput-byte v0, p0, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$Padding_Var;->memoizedIsInitialized:B

    .line 278
    iput v0, p0, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$Padding_Var;->memoizedSerializedSize:I

    .line 86
    invoke-direct {p0}, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$Padding_Var;->initFields()V

    .line 89
    invoke-static {}, Lcom/google/protobuf/UnknownFieldSet;->newBuilder()Lcom/google/protobuf/UnknownFieldSet$Builder;

    move-result-object v2

    .line 91
    const/4 v0, 0x0

    .line 92
    :cond_0
    :goto_0
    if-nez v0, :cond_1

    .line 93
    :try_start_0
    invoke-virtual {p1}, Lcom/google/protobuf/CodedInputStream;->readTag()I

    move-result v3

    .line 94
    sparse-switch v3, :sswitch_data_0

    .line 99
    invoke-virtual {p0, p1, v2, p2, v3}, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$Padding_Var;->parseUnknownField(Lcom/google/protobuf/CodedInputStream;Lcom/google/protobuf/UnknownFieldSet$Builder;Lcom/google/protobuf/ExtensionRegistryLite;I)Z

    move-result v3

    if-nez v3, :cond_0

    move v0, v1

    .line 101
    goto :goto_0

    :sswitch_0
    move v0, v1

    .line 97
    goto :goto_0

    .line 106
    :sswitch_1
    iget v3, p0, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$Padding_Var;->bitField0_:I

    or-int/lit8 v3, v3, 0x1

    iput v3, p0, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$Padding_Var;->bitField0_:I

    .line 107
    invoke-virtual {p1}, Lcom/google/protobuf/CodedInputStream;->readInt32()I

    move-result v3

    iput v3, p0, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$Padding_Var;->top_:I
    :try_end_0
    .catch Lcom/google/protobuf/InvalidProtocolBufferException; {:try_start_0 .. :try_end_0} :catch_0
    .catch Ljava/io/IOException; {:try_start_0 .. :try_end_0} :catch_1
    .catchall {:try_start_0 .. :try_end_0} :catchall_0

    goto :goto_0

    .line 127
    :catch_0
    move-exception v0

    .line 128
    :try_start_1
    invoke-virtual {v0, p0}, Lcom/google/protobuf/InvalidProtocolBufferException;->setUnfinishedMessage(Lcom/google/protobuf/MessageLite;)Lcom/google/protobuf/InvalidProtocolBufferException;

    move-result-object v0

    throw v0
    :try_end_1
    .catchall {:try_start_1 .. :try_end_1} :catchall_0

    .line 133
    :catchall_0
    move-exception v0

    invoke-virtual {v2}, Lcom/google/protobuf/UnknownFieldSet$Builder;->build()Lcom/google/protobuf/UnknownFieldSet;

    move-result-object v1

    iput-object v1, p0, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$Padding_Var;->unknownFields:Lcom/google/protobuf/UnknownFieldSet;

    .line 134
    invoke-virtual {p0}, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$Padding_Var;->makeExtensionsImmutable()V

    throw v0

    .line 111
    :sswitch_2
    :try_start_2
    iget v3, p0, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$Padding_Var;->bitField0_:I

    or-int/lit8 v3, v3, 0x2

    iput v3, p0, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$Padding_Var;->bitField0_:I

    .line 112
    invoke-virtual {p1}, Lcom/google/protobuf/CodedInputStream;->readInt32()I

    move-result v3

    iput v3, p0, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$Padding_Var;->left_:I
    :try_end_2
    .catch Lcom/google/protobuf/InvalidProtocolBufferException; {:try_start_2 .. :try_end_2} :catch_0
    .catch Ljava/io/IOException; {:try_start_2 .. :try_end_2} :catch_1
    .catchall {:try_start_2 .. :try_end_2} :catchall_0

    goto :goto_0

    .line 129
    :catch_1
    move-exception v0

    .line 130
    :try_start_3
    new-instance v1, Lcom/google/protobuf/InvalidProtocolBufferException;

    .line 131
    invoke-virtual {v0}, Ljava/io/IOException;->getMessage()Ljava/lang/String;

    move-result-object v0

    invoke-direct {v1, v0}, Lcom/google/protobuf/InvalidProtocolBufferException;-><init>(Ljava/lang/String;)V

    invoke-virtual {v1, p0}, Lcom/google/protobuf/InvalidProtocolBufferException;->setUnfinishedMessage(Lcom/google/protobuf/MessageLite;)Lcom/google/protobuf/InvalidProtocolBufferException;

    move-result-object v0

    throw v0
    :try_end_3
    .catchall {:try_start_3 .. :try_end_3} :catchall_0

    .line 116
    :sswitch_3
    :try_start_4
    iget v3, p0, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$Padding_Var;->bitField0_:I

    or-int/lit8 v3, v3, 0x4

    iput v3, p0, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$Padding_Var;->bitField0_:I

    .line 117
    invoke-virtual {p1}, Lcom/google/protobuf/CodedInputStream;->readInt32()I

    move-result v3

    iput v3, p0, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$Padding_Var;->bottom_:I

    goto :goto_0

    .line 121
    :sswitch_4
    iget v3, p0, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$Padding_Var;->bitField0_:I

    or-int/lit8 v3, v3, 0x8

    iput v3, p0, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$Padding_Var;->bitField0_:I

    .line 122
    invoke-virtual {p1}, Lcom/google/protobuf/CodedInputStream;->readInt32()I

    move-result v3

    iput v3, p0, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$Padding_Var;->right_:I
    :try_end_4
    .catch Lcom/google/protobuf/InvalidProtocolBufferException; {:try_start_4 .. :try_end_4} :catch_0
    .catch Ljava/io/IOException; {:try_start_4 .. :try_end_4} :catch_1
    .catchall {:try_start_4 .. :try_end_4} :catchall_0

    goto :goto_0

    .line 133
    :cond_1
    invoke-virtual {v2}, Lcom/google/protobuf/UnknownFieldSet$Builder;->build()Lcom/google/protobuf/UnknownFieldSet;

    move-result-object v0

    iput-object v0, p0, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$Padding_Var;->unknownFields:Lcom/google/protobuf/UnknownFieldSet;

    .line 134
    invoke-virtual {p0}, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$Padding_Var;->makeExtensionsImmutable()V

    .line 136
    return-void

    .line 94
    :sswitch_data_0
    .sparse-switch
        0x0 -> :sswitch_0
        0x8 -> :sswitch_1
        0x10 -> :sswitch_2
        0x18 -> :sswitch_3
        0x20 -> :sswitch_4
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
    .line 57
    invoke-direct {p0, p1, p2}, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$Padding_Var;-><init>(Lcom/google/protobuf/CodedInputStream;Lcom/google/protobuf/ExtensionRegistryLite;)V

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

    .line 62
    invoke-direct {p0, p1}, Lcom/google/protobuf/GeneratedMessage;-><init>(Lcom/google/protobuf/GeneratedMessage$Builder;)V

    .line 235
    iput-byte v0, p0, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$Padding_Var;->memoizedIsInitialized:B

    .line 278
    iput v0, p0, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$Padding_Var;->memoizedSerializedSize:I

    .line 63
    invoke-virtual {p1}, Lcom/google/protobuf/GeneratedMessage$Builder;->getUnknownFields()Lcom/google/protobuf/UnknownFieldSet;

    move-result-object v0

    iput-object v0, p0, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$Padding_Var;->unknownFields:Lcom/google/protobuf/UnknownFieldSet;

    .line 64
    return-void
.end method

.method synthetic constructor <init>(Lcom/google/protobuf/GeneratedMessage$Builder;Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$1;)V
    .locals 0

    .prologue
    .line 57
    invoke-direct {p0, p1}, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$Padding_Var;-><init>(Lcom/google/protobuf/GeneratedMessage$Builder;)V

    return-void
.end method

.method private constructor <init>(Z)V
    .locals 1

    .prologue
    const/4 v0, -0x1

    .line 65
    invoke-direct {p0}, Lcom/google/protobuf/GeneratedMessage;-><init>()V

    .line 235
    iput-byte v0, p0, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$Padding_Var;->memoizedIsInitialized:B

    .line 278
    iput v0, p0, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$Padding_Var;->memoizedSerializedSize:I

    .line 65
    invoke-static {}, Lcom/google/protobuf/UnknownFieldSet;->getDefaultInstance()Lcom/google/protobuf/UnknownFieldSet;

    move-result-object v0

    iput-object v0, p0, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$Padding_Var;->unknownFields:Lcom/google/protobuf/UnknownFieldSet;

    return-void
.end method

.method static synthetic access$1002(Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$Padding_Var;I)I
    .locals 0

    .prologue
    .line 57
    iput p1, p0, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$Padding_Var;->right_:I

    return p1
.end method

.method static synthetic access$1102(Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$Padding_Var;I)I
    .locals 0

    .prologue
    .line 57
    iput p1, p0, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$Padding_Var;->bitField0_:I

    return p1
.end method

.method static synthetic access$500()Z
    .locals 1

    .prologue
    .line 57
    sget-boolean v0, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$Padding_Var;->alwaysUseFieldBuilders:Z

    return v0
.end method

.method static synthetic access$702(Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$Padding_Var;I)I
    .locals 0

    .prologue
    .line 57
    iput p1, p0, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$Padding_Var;->top_:I

    return p1
.end method

.method static synthetic access$802(Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$Padding_Var;I)I
    .locals 0

    .prologue
    .line 57
    iput p1, p0, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$Padding_Var;->left_:I

    return p1
.end method

.method static synthetic access$902(Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$Padding_Var;I)I
    .locals 0

    .prologue
    .line 57
    iput p1, p0, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$Padding_Var;->bottom_:I

    return p1
.end method

.method public static getDefaultInstance()Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$Padding_Var;
    .locals 1

    .prologue
    .line 69
    sget-object v0, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$Padding_Var;->defaultInstance:Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$Padding_Var;

    return-object v0
.end method

.method public static final getDescriptor()Lcom/google/protobuf/Descriptors$Descriptor;
    .locals 1

    .prologue
    .line 139
    invoke-static {}, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage;->b()Lcom/google/protobuf/Descriptors$Descriptor;

    move-result-object v0

    return-object v0
.end method

.method private initFields()V
    .locals 1

    .prologue
    const/4 v0, 0x0

    .line 230
    iput v0, p0, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$Padding_Var;->top_:I

    .line 231
    iput v0, p0, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$Padding_Var;->left_:I

    .line 232
    iput v0, p0, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$Padding_Var;->bottom_:I

    .line 233
    iput v0, p0, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$Padding_Var;->right_:I

    .line 234
    return-void
.end method

.method public static newBuilder()Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$Padding_Var$Builder;
    .locals 1

    .prologue
    .line 365
    invoke-static {}, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$Padding_Var$Builder;->access$300()Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$Padding_Var$Builder;

    move-result-object v0

    return-object v0
.end method

.method public static newBuilder(Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$Padding_Var;)Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$Padding_Var$Builder;
    .locals 1

    .prologue
    .line 368
    invoke-static {}, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$Padding_Var;->newBuilder()Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$Padding_Var$Builder;

    move-result-object v0

    invoke-virtual {v0, p0}, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$Padding_Var$Builder;->mergeFrom(Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$Padding_Var;)Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$Padding_Var$Builder;

    move-result-object v0

    return-object v0
.end method

.method public static parseDelimitedFrom(Ljava/io/InputStream;)Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$Padding_Var;
    .locals 1
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljava/io/IOException;
        }
    .end annotation

    .prologue
    .line 345
    sget-object v0, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$Padding_Var;->PARSER:Lcom/google/protobuf/Parser;

    invoke-interface {v0, p0}, Lcom/google/protobuf/Parser;->parseDelimitedFrom(Ljava/io/InputStream;)Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$Padding_Var;

    return-object v0
.end method

.method public static parseDelimitedFrom(Ljava/io/InputStream;Lcom/google/protobuf/ExtensionRegistryLite;)Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$Padding_Var;
    .locals 1
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljava/io/IOException;
        }
    .end annotation

    .prologue
    .line 351
    sget-object v0, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$Padding_Var;->PARSER:Lcom/google/protobuf/Parser;

    invoke-interface {v0, p0, p1}, Lcom/google/protobuf/Parser;->parseDelimitedFrom(Ljava/io/InputStream;Lcom/google/protobuf/ExtensionRegistryLite;)Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$Padding_Var;

    return-object v0
.end method

.method public static parseFrom(Lcom/google/protobuf/ByteString;)Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$Padding_Var;
    .locals 1
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Lcom/google/protobuf/InvalidProtocolBufferException;
        }
    .end annotation

    .prologue
    .line 315
    sget-object v0, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$Padding_Var;->PARSER:Lcom/google/protobuf/Parser;

    invoke-interface {v0, p0}, Lcom/google/protobuf/Parser;->parseFrom(Lcom/google/protobuf/ByteString;)Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$Padding_Var;

    return-object v0
.end method

.method public static parseFrom(Lcom/google/protobuf/ByteString;Lcom/google/protobuf/ExtensionRegistryLite;)Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$Padding_Var;
    .locals 1
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Lcom/google/protobuf/InvalidProtocolBufferException;
        }
    .end annotation

    .prologue
    .line 321
    sget-object v0, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$Padding_Var;->PARSER:Lcom/google/protobuf/Parser;

    invoke-interface {v0, p0, p1}, Lcom/google/protobuf/Parser;->parseFrom(Lcom/google/protobuf/ByteString;Lcom/google/protobuf/ExtensionRegistryLite;)Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$Padding_Var;

    return-object v0
.end method

.method public static parseFrom(Lcom/google/protobuf/CodedInputStream;)Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$Padding_Var;
    .locals 1
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljava/io/IOException;
        }
    .end annotation

    .prologue
    .line 356
    sget-object v0, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$Padding_Var;->PARSER:Lcom/google/protobuf/Parser;

    invoke-interface {v0, p0}, Lcom/google/protobuf/Parser;->parseFrom(Lcom/google/protobuf/CodedInputStream;)Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$Padding_Var;

    return-object v0
.end method

.method public static parseFrom(Lcom/google/protobuf/CodedInputStream;Lcom/google/protobuf/ExtensionRegistryLite;)Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$Padding_Var;
    .locals 1
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljava/io/IOException;
        }
    .end annotation

    .prologue
    .line 362
    sget-object v0, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$Padding_Var;->PARSER:Lcom/google/protobuf/Parser;

    invoke-interface {v0, p0, p1}, Lcom/google/protobuf/Parser;->parseFrom(Lcom/google/protobuf/CodedInputStream;Lcom/google/protobuf/ExtensionRegistryLite;)Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$Padding_Var;

    return-object v0
.end method

.method public static parseFrom(Ljava/io/InputStream;)Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$Padding_Var;
    .locals 1
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljava/io/IOException;
        }
    .end annotation

    .prologue
    .line 335
    sget-object v0, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$Padding_Var;->PARSER:Lcom/google/protobuf/Parser;

    invoke-interface {v0, p0}, Lcom/google/protobuf/Parser;->parseFrom(Ljava/io/InputStream;)Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$Padding_Var;

    return-object v0
.end method

.method public static parseFrom(Ljava/io/InputStream;Lcom/google/protobuf/ExtensionRegistryLite;)Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$Padding_Var;
    .locals 1
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljava/io/IOException;
        }
    .end annotation

    .prologue
    .line 341
    sget-object v0, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$Padding_Var;->PARSER:Lcom/google/protobuf/Parser;

    invoke-interface {v0, p0, p1}, Lcom/google/protobuf/Parser;->parseFrom(Ljava/io/InputStream;Lcom/google/protobuf/ExtensionRegistryLite;)Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$Padding_Var;

    return-object v0
.end method

.method public static parseFrom([B)Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$Padding_Var;
    .locals 1
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Lcom/google/protobuf/InvalidProtocolBufferException;
        }
    .end annotation

    .prologue
    .line 325
    sget-object v0, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$Padding_Var;->PARSER:Lcom/google/protobuf/Parser;

    invoke-interface {v0, p0}, Lcom/google/protobuf/Parser;->parseFrom([B)Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$Padding_Var;

    return-object v0
.end method

.method public static parseFrom([BLcom/google/protobuf/ExtensionRegistryLite;)Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$Padding_Var;
    .locals 1
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Lcom/google/protobuf/InvalidProtocolBufferException;
        }
    .end annotation

    .prologue
    .line 331
    sget-object v0, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$Padding_Var;->PARSER:Lcom/google/protobuf/Parser;

    invoke-interface {v0, p0, p1}, Lcom/google/protobuf/Parser;->parseFrom([BLcom/google/protobuf/ExtensionRegistryLite;)Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$Padding_Var;

    return-object v0
.end method


# virtual methods
.method public getBottom()I
    .locals 1

    .prologue
    .line 210
    iget v0, p0, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$Padding_Var;->bottom_:I

    return v0
.end method

.method public getDefaultInstanceForType()Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$Padding_Var;
    .locals 1

    .prologue
    .line 73
    sget-object v0, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$Padding_Var;->defaultInstance:Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$Padding_Var;

    return-object v0
.end method

.method public bridge synthetic getDefaultInstanceForType()Lcom/google/protobuf/Message;
    .locals 1

    .prologue
    .line 57
    invoke-virtual {p0}, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$Padding_Var;->getDefaultInstanceForType()Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$Padding_Var;

    move-result-object v0

    return-object v0
.end method

.method public bridge synthetic getDefaultInstanceForType()Lcom/google/protobuf/MessageLite;
    .locals 1

    .prologue
    .line 57
    invoke-virtual {p0}, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$Padding_Var;->getDefaultInstanceForType()Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$Padding_Var;

    move-result-object v0

    return-object v0
.end method

.method public getLeft()I
    .locals 1

    .prologue
    .line 194
    iget v0, p0, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$Padding_Var;->left_:I

    return v0
.end method

.method public getParserForType()Lcom/google/protobuf/Parser;
    .locals 1
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "()",
            "Lcom/google/protobuf/Parser",
            "<",
            "Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$Padding_Var;",
            ">;"
        }
    .end annotation

    .prologue
    .line 161
    sget-object v0, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$Padding_Var;->PARSER:Lcom/google/protobuf/Parser;

    return-object v0
.end method

.method public getRight()I
    .locals 1

    .prologue
    .line 226
    iget v0, p0, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$Padding_Var;->right_:I

    return v0
.end method

.method public getSerializedSize()I
    .locals 5

    .prologue
    const/4 v4, 0x4

    const/4 v3, 0x2

    const/4 v2, 0x1

    .line 280
    iget v0, p0, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$Padding_Var;->memoizedSerializedSize:I

    .line 281
    const/4 v1, -0x1

    if-eq v0, v1, :cond_0

    .line 302
    :goto_0
    return v0

    .line 283
    :cond_0
    const/4 v0, 0x0

    .line 284
    iget v1, p0, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$Padding_Var;->bitField0_:I

    and-int/lit8 v1, v1, 0x1

    if-ne v1, v2, :cond_1

    .line 285
    iget v1, p0, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$Padding_Var;->top_:I

    .line 286
    invoke-static {v2, v1}, Lcom/google/protobuf/CodedOutputStream;->computeInt32Size(II)I

    move-result v1

    add-int/2addr v0, v1

    .line 288
    :cond_1
    iget v1, p0, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$Padding_Var;->bitField0_:I

    and-int/lit8 v1, v1, 0x2

    if-ne v1, v3, :cond_2

    .line 289
    iget v1, p0, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$Padding_Var;->left_:I

    .line 290
    invoke-static {v3, v1}, Lcom/google/protobuf/CodedOutputStream;->computeInt32Size(II)I

    move-result v1

    add-int/2addr v0, v1

    .line 292
    :cond_2
    iget v1, p0, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$Padding_Var;->bitField0_:I

    and-int/lit8 v1, v1, 0x4

    if-ne v1, v4, :cond_3

    .line 293
    const/4 v1, 0x3

    iget v2, p0, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$Padding_Var;->bottom_:I

    .line 294
    invoke-static {v1, v2}, Lcom/google/protobuf/CodedOutputStream;->computeInt32Size(II)I

    move-result v1

    add-int/2addr v0, v1

    .line 296
    :cond_3
    iget v1, p0, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$Padding_Var;->bitField0_:I

    and-int/lit8 v1, v1, 0x8

    const/16 v2, 0x8

    if-ne v1, v2, :cond_4

    .line 297
    iget v1, p0, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$Padding_Var;->right_:I

    .line 298
    invoke-static {v4, v1}, Lcom/google/protobuf/CodedOutputStream;->computeInt32Size(II)I

    move-result v1

    add-int/2addr v0, v1

    .line 300
    :cond_4
    invoke-virtual {p0}, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$Padding_Var;->getUnknownFields()Lcom/google/protobuf/UnknownFieldSet;

    move-result-object v1

    invoke-virtual {v1}, Lcom/google/protobuf/UnknownFieldSet;->getSerializedSize()I

    move-result v1

    add-int/2addr v0, v1

    .line 301
    iput v0, p0, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$Padding_Var;->memoizedSerializedSize:I

    goto :goto_0
.end method

.method public getTop()I
    .locals 1

    .prologue
    .line 178
    iget v0, p0, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$Padding_Var;->top_:I

    return v0
.end method

.method public final getUnknownFields()Lcom/google/protobuf/UnknownFieldSet;
    .locals 1

    .prologue
    .line 80
    iget-object v0, p0, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$Padding_Var;->unknownFields:Lcom/google/protobuf/UnknownFieldSet;

    return-object v0
.end method

.method public hasBottom()Z
    .locals 2

    .prologue
    .line 204
    iget v0, p0, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$Padding_Var;->bitField0_:I

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

.method public hasLeft()Z
    .locals 2

    .prologue
    .line 188
    iget v0, p0, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$Padding_Var;->bitField0_:I

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

.method public hasRight()Z
    .locals 2

    .prologue
    .line 220
    iget v0, p0, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$Padding_Var;->bitField0_:I

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

.method public hasTop()Z
    .locals 2

    .prologue
    const/4 v0, 0x1

    .line 172
    iget v1, p0, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$Padding_Var;->bitField0_:I

    and-int/lit8 v1, v1, 0x1

    if-ne v1, v0, :cond_0

    :goto_0
    return v0

    :cond_0
    const/4 v0, 0x0

    goto :goto_0
.end method

.method protected internalGetFieldAccessorTable()Lcom/google/protobuf/GeneratedMessage$FieldAccessorTable;
    .locals 3

    .prologue
    .line 144
    invoke-static {}, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage;->c()Lcom/google/protobuf/GeneratedMessage$FieldAccessorTable;

    move-result-object v0

    const-class v1, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$Padding_Var;

    const-class v2, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$Padding_Var$Builder;

    .line 145
    invoke-virtual {v0, v1, v2}, Lcom/google/protobuf/GeneratedMessage$FieldAccessorTable;->ensureFieldAccessorsInitialized(Ljava/lang/Class;Ljava/lang/Class;)Lcom/google/protobuf/GeneratedMessage$FieldAccessorTable;

    move-result-object v0

    .line 144
    return-object v0
.end method

.method public final isInitialized()Z
    .locals 4

    .prologue
    const/4 v0, 0x1

    const/4 v1, 0x0

    .line 237
    iget-byte v2, p0, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$Padding_Var;->memoizedIsInitialized:B

    .line 238
    const/4 v3, -0x1

    if-eq v2, v3, :cond_1

    if-ne v2, v0, :cond_0

    :goto_0
    move v1, v0

    .line 257
    :goto_1
    return v1

    :cond_0
    move v0, v1

    .line 238
    goto :goto_0

    .line 240
    :cond_1
    invoke-virtual {p0}, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$Padding_Var;->hasTop()Z

    move-result v2

    if-nez v2, :cond_2

    .line 241
    iput-byte v1, p0, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$Padding_Var;->memoizedIsInitialized:B

    goto :goto_1

    .line 244
    :cond_2
    invoke-virtual {p0}, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$Padding_Var;->hasLeft()Z

    move-result v2

    if-nez v2, :cond_3

    .line 245
    iput-byte v1, p0, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$Padding_Var;->memoizedIsInitialized:B

    goto :goto_1

    .line 248
    :cond_3
    invoke-virtual {p0}, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$Padding_Var;->hasBottom()Z

    move-result v2

    if-nez v2, :cond_4

    .line 249
    iput-byte v1, p0, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$Padding_Var;->memoizedIsInitialized:B

    goto :goto_1

    .line 252
    :cond_4
    invoke-virtual {p0}, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$Padding_Var;->hasRight()Z

    move-result v2

    if-nez v2, :cond_5

    .line 253
    iput-byte v1, p0, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$Padding_Var;->memoizedIsInitialized:B

    goto :goto_1

    .line 256
    :cond_5
    iput-byte v0, p0, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$Padding_Var;->memoizedIsInitialized:B

    move v1, v0

    .line 257
    goto :goto_1
.end method

.method public newBuilderForType()Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$Padding_Var$Builder;
    .locals 1

    .prologue
    .line 366
    invoke-static {}, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$Padding_Var;->newBuilder()Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$Padding_Var$Builder;

    move-result-object v0

    return-object v0
.end method

.method protected newBuilderForType(Lcom/google/protobuf/GeneratedMessage$BuilderParent;)Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$Padding_Var$Builder;
    .locals 2

    .prologue
    .line 375
    new-instance v0, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$Padding_Var$Builder;

    const/4 v1, 0x0

    invoke-direct {v0, p1, v1}, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$Padding_Var$Builder;-><init>(Lcom/google/protobuf/GeneratedMessage$BuilderParent;Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$1;)V

    .line 376
    return-object v0
.end method

.method public bridge synthetic newBuilderForType()Lcom/google/protobuf/Message$Builder;
    .locals 1

    .prologue
    .line 57
    invoke-virtual {p0}, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$Padding_Var;->newBuilderForType()Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$Padding_Var$Builder;

    move-result-object v0

    return-object v0
.end method

.method protected bridge synthetic newBuilderForType(Lcom/google/protobuf/GeneratedMessage$BuilderParent;)Lcom/google/protobuf/Message$Builder;
    .locals 1

    .prologue
    .line 57
    invoke-virtual {p0, p1}, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$Padding_Var;->newBuilderForType(Lcom/google/protobuf/GeneratedMessage$BuilderParent;)Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$Padding_Var$Builder;

    move-result-object v0

    return-object v0
.end method

.method public bridge synthetic newBuilderForType()Lcom/google/protobuf/MessageLite$Builder;
    .locals 1

    .prologue
    .line 57
    invoke-virtual {p0}, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$Padding_Var;->newBuilderForType()Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$Padding_Var$Builder;

    move-result-object v0

    return-object v0
.end method

.method public toBuilder()Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$Padding_Var$Builder;
    .locals 1

    .prologue
    .line 370
    invoke-static {p0}, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$Padding_Var;->newBuilder(Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$Padding_Var;)Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$Padding_Var$Builder;

    move-result-object v0

    return-object v0
.end method

.method public bridge synthetic toBuilder()Lcom/google/protobuf/Message$Builder;
    .locals 1

    .prologue
    .line 57
    invoke-virtual {p0}, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$Padding_Var;->toBuilder()Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$Padding_Var$Builder;

    move-result-object v0

    return-object v0
.end method

.method public bridge synthetic toBuilder()Lcom/google/protobuf/MessageLite$Builder;
    .locals 1

    .prologue
    .line 57
    invoke-virtual {p0}, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$Padding_Var;->toBuilder()Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$Padding_Var$Builder;

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
    .line 309
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

    .line 262
    invoke-virtual {p0}, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$Padding_Var;->getSerializedSize()I

    .line 263
    iget v0, p0, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$Padding_Var;->bitField0_:I

    and-int/lit8 v0, v0, 0x1

    if-ne v0, v1, :cond_0

    .line 264
    iget v0, p0, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$Padding_Var;->top_:I

    invoke-virtual {p1, v1, v0}, Lcom/google/protobuf/CodedOutputStream;->writeInt32(II)V

    .line 266
    :cond_0
    iget v0, p0, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$Padding_Var;->bitField0_:I

    and-int/lit8 v0, v0, 0x2

    if-ne v0, v2, :cond_1

    .line 267
    iget v0, p0, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$Padding_Var;->left_:I

    invoke-virtual {p1, v2, v0}, Lcom/google/protobuf/CodedOutputStream;->writeInt32(II)V

    .line 269
    :cond_1
    iget v0, p0, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$Padding_Var;->bitField0_:I

    and-int/lit8 v0, v0, 0x4

    if-ne v0, v3, :cond_2

    .line 270
    const/4 v0, 0x3

    iget v1, p0, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$Padding_Var;->bottom_:I

    invoke-virtual {p1, v0, v1}, Lcom/google/protobuf/CodedOutputStream;->writeInt32(II)V

    .line 272
    :cond_2
    iget v0, p0, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$Padding_Var;->bitField0_:I

    and-int/lit8 v0, v0, 0x8

    const/16 v1, 0x8

    if-ne v0, v1, :cond_3

    .line 273
    iget v0, p0, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$Padding_Var;->right_:I

    invoke-virtual {p1, v3, v0}, Lcom/google/protobuf/CodedOutputStream;->writeInt32(II)V

    .line 275
    :cond_3
    invoke-virtual {p0}, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$Padding_Var;->getUnknownFields()Lcom/google/protobuf/UnknownFieldSet;

    move-result-object v0

    invoke-virtual {v0, p1}, Lcom/google/protobuf/UnknownFieldSet;->writeTo(Lcom/google/protobuf/CodedOutputStream;)V

    .line 276
    return-void
.end method
