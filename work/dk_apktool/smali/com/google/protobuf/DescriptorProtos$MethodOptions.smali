.class public final Lcom/google/protobuf/DescriptorProtos$MethodOptions;
.super Lcom/google/protobuf/GeneratedMessage$ExtendableMessage;
.source "SourceFile"

# interfaces
.implements Lcom/google/protobuf/DescriptorProtos$MethodOptionsOrBuilder;


# annotations
.annotation system Ldalvik/annotation/EnclosingClass;
    value = Lcom/google/protobuf/DescriptorProtos;
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x19
    name = "MethodOptions"
.end annotation

.annotation system Ldalvik/annotation/MemberClasses;
    value = {
        Lcom/google/protobuf/DescriptorProtos$MethodOptions$Builder;
    }
.end annotation

.annotation system Ldalvik/annotation/Signature;
    value = {
        "Lcom/google/protobuf/GeneratedMessage$ExtendableMessage",
        "<",
        "Lcom/google/protobuf/DescriptorProtos$MethodOptions;",
        ">;",
        "Lcom/google/protobuf/DescriptorProtos$MethodOptionsOrBuilder;"
    }
.end annotation


# static fields
.field public static final UNINTERPRETED_OPTION_FIELD_NUMBER:I = 0x3e7

.field private static final defaultInstance:Lcom/google/protobuf/DescriptorProtos$MethodOptions;

.field private static final serialVersionUID:J


# instance fields
.field private memoizedIsInitialized:B

.field private memoizedSerializedSize:I

.field private uninterpretedOption_:Ljava/util/List;
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "Ljava/util/List",
            "<",
            "Lcom/google/protobuf/DescriptorProtos$UninterpretedOption;",
            ">;"
        }
    .end annotation
.end field


# direct methods
.method static constructor <clinit>()V
    .locals 2

    .prologue
    .line 14658
    new-instance v0, Lcom/google/protobuf/DescriptorProtos$MethodOptions;

    const/4 v1, 0x1

    invoke-direct {v0, v1}, Lcom/google/protobuf/DescriptorProtos$MethodOptions;-><init>(Z)V

    sput-object v0, Lcom/google/protobuf/DescriptorProtos$MethodOptions;->defaultInstance:Lcom/google/protobuf/DescriptorProtos$MethodOptions;

    .line 14659
    sget-object v0, Lcom/google/protobuf/DescriptorProtos$MethodOptions;->defaultInstance:Lcom/google/protobuf/DescriptorProtos$MethodOptions;

    invoke-direct {v0}, Lcom/google/protobuf/DescriptorProtos$MethodOptions;->initFields()V

    .line 14101
    return-void
.end method

.method private constructor <init>(Lcom/google/protobuf/DescriptorProtos$MethodOptions$Builder;)V
    .locals 1

    .prologue
    const/4 v0, -0x1

    .line 14106
    invoke-direct {p0, p1}, Lcom/google/protobuf/GeneratedMessage$ExtendableMessage;-><init>(Lcom/google/protobuf/GeneratedMessage$ExtendableBuilder;)V

    .line 14153
    iput-byte v0, p0, Lcom/google/protobuf/DescriptorProtos$MethodOptions;->memoizedIsInitialized:B

    .line 14185
    iput v0, p0, Lcom/google/protobuf/DescriptorProtos$MethodOptions;->memoizedSerializedSize:I

    .line 14107
    return-void
.end method

.method synthetic constructor <init>(Lcom/google/protobuf/DescriptorProtos$MethodOptions$Builder;Lcom/google/protobuf/DescriptorProtos$MethodOptions;)V
    .locals 0

    .prologue
    .line 14105
    invoke-direct {p0, p1}, Lcom/google/protobuf/DescriptorProtos$MethodOptions;-><init>(Lcom/google/protobuf/DescriptorProtos$MethodOptions$Builder;)V

    return-void
.end method

.method private constructor <init>(Z)V
    .locals 1

    .prologue
    const/4 v0, -0x1

    .line 14108
    invoke-direct {p0}, Lcom/google/protobuf/GeneratedMessage$ExtendableMessage;-><init>()V

    .line 14153
    iput-byte v0, p0, Lcom/google/protobuf/DescriptorProtos$MethodOptions;->memoizedIsInitialized:B

    .line 14185
    iput v0, p0, Lcom/google/protobuf/DescriptorProtos$MethodOptions;->memoizedSerializedSize:I

    .line 14108
    return-void
.end method

.method static synthetic access$8(Lcom/google/protobuf/DescriptorProtos$MethodOptions;Ljava/util/List;)V
    .locals 0

    .prologue
    .line 14131
    iput-object p1, p0, Lcom/google/protobuf/DescriptorProtos$MethodOptions;->uninterpretedOption_:Ljava/util/List;

    return-void
.end method

.method static synthetic access$9(Lcom/google/protobuf/DescriptorProtos$MethodOptions;)Ljava/util/List;
    .locals 1

    .prologue
    .line 14131
    iget-object v0, p0, Lcom/google/protobuf/DescriptorProtos$MethodOptions;->uninterpretedOption_:Ljava/util/List;

    return-object v0
.end method

.method public static getDefaultInstance()Lcom/google/protobuf/DescriptorProtos$MethodOptions;
    .locals 1

    .prologue
    .line 14112
    sget-object v0, Lcom/google/protobuf/DescriptorProtos$MethodOptions;->defaultInstance:Lcom/google/protobuf/DescriptorProtos$MethodOptions;

    return-object v0
.end method

.method public static final getDescriptor()Lcom/google/protobuf/Descriptors$Descriptor;
    .locals 1

    .prologue
    .line 14121
    invoke-static {}, Lcom/google/protobuf/DescriptorProtos;->access$47()Lcom/google/protobuf/Descriptors$Descriptor;

    move-result-object v0

    return-object v0
.end method

.method private initFields()V
    .locals 1

    .prologue
    .line 14151
    invoke-static {}, Ljava/util/Collections;->emptyList()Ljava/util/List;

    move-result-object v0

    iput-object v0, p0, Lcom/google/protobuf/DescriptorProtos$MethodOptions;->uninterpretedOption_:Ljava/util/List;

    .line 14152
    return-void
.end method

.method public static newBuilder()Lcom/google/protobuf/DescriptorProtos$MethodOptions$Builder;
    .locals 1

    .prologue
    .line 14275
    invoke-static {}, Lcom/google/protobuf/DescriptorProtos$MethodOptions$Builder;->access$18()Lcom/google/protobuf/DescriptorProtos$MethodOptions$Builder;

    move-result-object v0

    return-object v0
.end method

.method public static newBuilder(Lcom/google/protobuf/DescriptorProtos$MethodOptions;)Lcom/google/protobuf/DescriptorProtos$MethodOptions$Builder;
    .locals 1

    .prologue
    .line 14278
    invoke-static {}, Lcom/google/protobuf/DescriptorProtos$MethodOptions;->newBuilder()Lcom/google/protobuf/DescriptorProtos$MethodOptions$Builder;

    move-result-object v0

    invoke-virtual {v0, p0}, Lcom/google/protobuf/DescriptorProtos$MethodOptions$Builder;->mergeFrom(Lcom/google/protobuf/DescriptorProtos$MethodOptions;)Lcom/google/protobuf/DescriptorProtos$MethodOptions$Builder;

    move-result-object v0

    return-object v0
.end method

.method public static parseDelimitedFrom(Ljava/io/InputStream;)Lcom/google/protobuf/DescriptorProtos$MethodOptions;
    .locals 2
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljava/io/IOException;
        }
    .end annotation

    .prologue
    .line 14244
    invoke-static {}, Lcom/google/protobuf/DescriptorProtos$MethodOptions;->newBuilder()Lcom/google/protobuf/DescriptorProtos$MethodOptions$Builder;

    move-result-object v0

    .line 14245
    invoke-virtual {v0, p0}, Lcom/google/protobuf/DescriptorProtos$MethodOptions$Builder;->mergeDelimitedFrom(Ljava/io/InputStream;)Z

    move-result v1

    if-eqz v1, :cond_0

    .line 14246
    invoke-static {v0}, Lcom/google/protobuf/DescriptorProtos$MethodOptions$Builder;->access$17(Lcom/google/protobuf/DescriptorProtos$MethodOptions$Builder;)Lcom/google/protobuf/DescriptorProtos$MethodOptions;

    move-result-object v0

    .line 14248
    :goto_0
    return-object v0

    :cond_0
    const/4 v0, 0x0

    goto :goto_0
.end method

.method public static parseDelimitedFrom(Ljava/io/InputStream;Lcom/google/protobuf/ExtensionRegistryLite;)Lcom/google/protobuf/DescriptorProtos$MethodOptions;
    .locals 2
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljava/io/IOException;
        }
    .end annotation

    .prologue
    .line 14255
    invoke-static {}, Lcom/google/protobuf/DescriptorProtos$MethodOptions;->newBuilder()Lcom/google/protobuf/DescriptorProtos$MethodOptions$Builder;

    move-result-object v0

    .line 14256
    invoke-virtual {v0, p0, p1}, Lcom/google/protobuf/DescriptorProtos$MethodOptions$Builder;->mergeDelimitedFrom(Ljava/io/InputStream;Lcom/google/protobuf/ExtensionRegistryLite;)Z

    move-result v1

    if-eqz v1, :cond_0

    .line 14257
    invoke-static {v0}, Lcom/google/protobuf/DescriptorProtos$MethodOptions$Builder;->access$17(Lcom/google/protobuf/DescriptorProtos$MethodOptions$Builder;)Lcom/google/protobuf/DescriptorProtos$MethodOptions;

    move-result-object v0

    .line 14259
    :goto_0
    return-object v0

    :cond_0
    const/4 v0, 0x0

    goto :goto_0
.end method

.method public static parseFrom(Lcom/google/protobuf/ByteString;)Lcom/google/protobuf/DescriptorProtos$MethodOptions;
    .locals 1
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Lcom/google/protobuf/InvalidProtocolBufferException;
        }
    .end annotation

    .prologue
    .line 14211
    invoke-static {}, Lcom/google/protobuf/DescriptorProtos$MethodOptions;->newBuilder()Lcom/google/protobuf/DescriptorProtos$MethodOptions$Builder;

    move-result-object v0

    invoke-virtual {v0, p0}, Lcom/google/protobuf/DescriptorProtos$MethodOptions$Builder;->mergeFrom(Lcom/google/protobuf/ByteString;)Lcom/google/protobuf/AbstractMessage$Builder;

    move-result-object v0

    check-cast v0, Lcom/google/protobuf/DescriptorProtos$MethodOptions$Builder;

    invoke-static {v0}, Lcom/google/protobuf/DescriptorProtos$MethodOptions$Builder;->access$17(Lcom/google/protobuf/DescriptorProtos$MethodOptions$Builder;)Lcom/google/protobuf/DescriptorProtos$MethodOptions;

    move-result-object v0

    return-object v0
.end method

.method public static parseFrom(Lcom/google/protobuf/ByteString;Lcom/google/protobuf/ExtensionRegistryLite;)Lcom/google/protobuf/DescriptorProtos$MethodOptions;
    .locals 1
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Lcom/google/protobuf/InvalidProtocolBufferException;
        }
    .end annotation

    .prologue
    .line 14217
    invoke-static {}, Lcom/google/protobuf/DescriptorProtos$MethodOptions;->newBuilder()Lcom/google/protobuf/DescriptorProtos$MethodOptions$Builder;

    move-result-object v0

    invoke-virtual {v0, p0, p1}, Lcom/google/protobuf/DescriptorProtos$MethodOptions$Builder;->mergeFrom(Lcom/google/protobuf/ByteString;Lcom/google/protobuf/ExtensionRegistryLite;)Lcom/google/protobuf/AbstractMessage$Builder;

    move-result-object v0

    check-cast v0, Lcom/google/protobuf/DescriptorProtos$MethodOptions$Builder;

    .line 14218
    invoke-static {v0}, Lcom/google/protobuf/DescriptorProtos$MethodOptions$Builder;->access$17(Lcom/google/protobuf/DescriptorProtos$MethodOptions$Builder;)Lcom/google/protobuf/DescriptorProtos$MethodOptions;

    move-result-object v0

    .line 14217
    return-object v0
.end method

.method public static parseFrom(Lcom/google/protobuf/CodedInputStream;)Lcom/google/protobuf/DescriptorProtos$MethodOptions;
    .locals 1
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljava/io/IOException;
        }
    .end annotation

    .prologue
    .line 14265
    invoke-static {}, Lcom/google/protobuf/DescriptorProtos$MethodOptions;->newBuilder()Lcom/google/protobuf/DescriptorProtos$MethodOptions$Builder;

    move-result-object v0

    invoke-virtual {v0, p0}, Lcom/google/protobuf/DescriptorProtos$MethodOptions$Builder;->mergeFrom(Lcom/google/protobuf/CodedInputStream;)Lcom/google/protobuf/AbstractMessage$Builder;

    move-result-object v0

    check-cast v0, Lcom/google/protobuf/DescriptorProtos$MethodOptions$Builder;

    invoke-static {v0}, Lcom/google/protobuf/DescriptorProtos$MethodOptions$Builder;->access$17(Lcom/google/protobuf/DescriptorProtos$MethodOptions$Builder;)Lcom/google/protobuf/DescriptorProtos$MethodOptions;

    move-result-object v0

    return-object v0
.end method

.method public static parseFrom(Lcom/google/protobuf/CodedInputStream;Lcom/google/protobuf/ExtensionRegistryLite;)Lcom/google/protobuf/DescriptorProtos$MethodOptions;
    .locals 1
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljava/io/IOException;
        }
    .end annotation

    .prologue
    .line 14271
    invoke-static {}, Lcom/google/protobuf/DescriptorProtos$MethodOptions;->newBuilder()Lcom/google/protobuf/DescriptorProtos$MethodOptions$Builder;

    move-result-object v0

    invoke-virtual {v0, p0, p1}, Lcom/google/protobuf/DescriptorProtos$MethodOptions$Builder;->mergeFrom(Lcom/google/protobuf/CodedInputStream;Lcom/google/protobuf/ExtensionRegistryLite;)Lcom/google/protobuf/DescriptorProtos$MethodOptions$Builder;

    move-result-object v0

    .line 14272
    invoke-static {v0}, Lcom/google/protobuf/DescriptorProtos$MethodOptions$Builder;->access$17(Lcom/google/protobuf/DescriptorProtos$MethodOptions$Builder;)Lcom/google/protobuf/DescriptorProtos$MethodOptions;

    move-result-object v0

    .line 14271
    return-object v0
.end method

.method public static parseFrom(Ljava/io/InputStream;)Lcom/google/protobuf/DescriptorProtos$MethodOptions;
    .locals 1
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljava/io/IOException;
        }
    .end annotation

    .prologue
    .line 14233
    invoke-static {}, Lcom/google/protobuf/DescriptorProtos$MethodOptions;->newBuilder()Lcom/google/protobuf/DescriptorProtos$MethodOptions$Builder;

    move-result-object v0

    invoke-virtual {v0, p0}, Lcom/google/protobuf/DescriptorProtos$MethodOptions$Builder;->mergeFrom(Ljava/io/InputStream;)Lcom/google/protobuf/AbstractMessage$Builder;

    move-result-object v0

    check-cast v0, Lcom/google/protobuf/DescriptorProtos$MethodOptions$Builder;

    invoke-static {v0}, Lcom/google/protobuf/DescriptorProtos$MethodOptions$Builder;->access$17(Lcom/google/protobuf/DescriptorProtos$MethodOptions$Builder;)Lcom/google/protobuf/DescriptorProtos$MethodOptions;

    move-result-object v0

    return-object v0
.end method

.method public static parseFrom(Ljava/io/InputStream;Lcom/google/protobuf/ExtensionRegistryLite;)Lcom/google/protobuf/DescriptorProtos$MethodOptions;
    .locals 1
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljava/io/IOException;
        }
    .end annotation

    .prologue
    .line 14239
    invoke-static {}, Lcom/google/protobuf/DescriptorProtos$MethodOptions;->newBuilder()Lcom/google/protobuf/DescriptorProtos$MethodOptions$Builder;

    move-result-object v0

    invoke-virtual {v0, p0, p1}, Lcom/google/protobuf/DescriptorProtos$MethodOptions$Builder;->mergeFrom(Ljava/io/InputStream;Lcom/google/protobuf/ExtensionRegistryLite;)Lcom/google/protobuf/AbstractMessage$Builder;

    move-result-object v0

    check-cast v0, Lcom/google/protobuf/DescriptorProtos$MethodOptions$Builder;

    .line 14240
    invoke-static {v0}, Lcom/google/protobuf/DescriptorProtos$MethodOptions$Builder;->access$17(Lcom/google/protobuf/DescriptorProtos$MethodOptions$Builder;)Lcom/google/protobuf/DescriptorProtos$MethodOptions;

    move-result-object v0

    .line 14239
    return-object v0
.end method

.method public static parseFrom([B)Lcom/google/protobuf/DescriptorProtos$MethodOptions;
    .locals 1
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Lcom/google/protobuf/InvalidProtocolBufferException;
        }
    .end annotation

    .prologue
    .line 14222
    invoke-static {}, Lcom/google/protobuf/DescriptorProtos$MethodOptions;->newBuilder()Lcom/google/protobuf/DescriptorProtos$MethodOptions$Builder;

    move-result-object v0

    invoke-virtual {v0, p0}, Lcom/google/protobuf/DescriptorProtos$MethodOptions$Builder;->mergeFrom([B)Lcom/google/protobuf/AbstractMessage$Builder;

    move-result-object v0

    check-cast v0, Lcom/google/protobuf/DescriptorProtos$MethodOptions$Builder;

    invoke-static {v0}, Lcom/google/protobuf/DescriptorProtos$MethodOptions$Builder;->access$17(Lcom/google/protobuf/DescriptorProtos$MethodOptions$Builder;)Lcom/google/protobuf/DescriptorProtos$MethodOptions;

    move-result-object v0

    return-object v0
.end method

.method public static parseFrom([BLcom/google/protobuf/ExtensionRegistryLite;)Lcom/google/protobuf/DescriptorProtos$MethodOptions;
    .locals 1
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Lcom/google/protobuf/InvalidProtocolBufferException;
        }
    .end annotation

    .prologue
    .line 14228
    invoke-static {}, Lcom/google/protobuf/DescriptorProtos$MethodOptions;->newBuilder()Lcom/google/protobuf/DescriptorProtos$MethodOptions$Builder;

    move-result-object v0

    invoke-virtual {v0, p0, p1}, Lcom/google/protobuf/DescriptorProtos$MethodOptions$Builder;->mergeFrom([BLcom/google/protobuf/ExtensionRegistryLite;)Lcom/google/protobuf/AbstractMessage$Builder;

    move-result-object v0

    check-cast v0, Lcom/google/protobuf/DescriptorProtos$MethodOptions$Builder;

    .line 14229
    invoke-static {v0}, Lcom/google/protobuf/DescriptorProtos$MethodOptions$Builder;->access$17(Lcom/google/protobuf/DescriptorProtos$MethodOptions$Builder;)Lcom/google/protobuf/DescriptorProtos$MethodOptions;

    move-result-object v0

    .line 14228
    return-object v0
.end method


# virtual methods
.method public getDefaultInstanceForType()Lcom/google/protobuf/DescriptorProtos$MethodOptions;
    .locals 1

    .prologue
    .line 14116
    sget-object v0, Lcom/google/protobuf/DescriptorProtos$MethodOptions;->defaultInstance:Lcom/google/protobuf/DescriptorProtos$MethodOptions;

    return-object v0
.end method

.method public bridge synthetic getDefaultInstanceForType()Lcom/google/protobuf/Message;
    .locals 1

    .prologue
    .line 1
    invoke-virtual {p0}, Lcom/google/protobuf/DescriptorProtos$MethodOptions;->getDefaultInstanceForType()Lcom/google/protobuf/DescriptorProtos$MethodOptions;

    move-result-object v0

    return-object v0
.end method

.method public bridge synthetic getDefaultInstanceForType()Lcom/google/protobuf/MessageLite;
    .locals 1

    .prologue
    .line 1
    invoke-virtual {p0}, Lcom/google/protobuf/DescriptorProtos$MethodOptions;->getDefaultInstanceForType()Lcom/google/protobuf/DescriptorProtos$MethodOptions;

    move-result-object v0

    return-object v0
.end method

.method public getSerializedSize()I
    .locals 4

    .prologue
    const/4 v0, 0x0

    .line 14187
    iget v1, p0, Lcom/google/protobuf/DescriptorProtos$MethodOptions;->memoizedSerializedSize:I

    .line 14188
    const/4 v2, -0x1

    if-eq v1, v2, :cond_0

    move v0, v1

    .line 14198
    :goto_0
    return v0

    :cond_0
    move v1, v0

    move v2, v0

    .line 14191
    :goto_1
    iget-object v0, p0, Lcom/google/protobuf/DescriptorProtos$MethodOptions;->uninterpretedOption_:Ljava/util/List;

    invoke-interface {v0}, Ljava/util/List;->size()I

    move-result v0

    if-lt v1, v0, :cond_1

    .line 14195
    invoke-virtual {p0}, Lcom/google/protobuf/DescriptorProtos$MethodOptions;->extensionsSerializedSize()I

    move-result v0

    add-int/2addr v0, v2

    .line 14196
    invoke-virtual {p0}, Lcom/google/protobuf/DescriptorProtos$MethodOptions;->getUnknownFields()Lcom/google/protobuf/UnknownFieldSet;

    move-result-object v1

    invoke-virtual {v1}, Lcom/google/protobuf/UnknownFieldSet;->getSerializedSize()I

    move-result v1

    add-int/2addr v0, v1

    .line 14197
    iput v0, p0, Lcom/google/protobuf/DescriptorProtos$MethodOptions;->memoizedSerializedSize:I

    goto :goto_0

    .line 14193
    :cond_1
    const/16 v3, 0x3e7

    iget-object v0, p0, Lcom/google/protobuf/DescriptorProtos$MethodOptions;->uninterpretedOption_:Ljava/util/List;

    invoke-interface {v0, v1}, Ljava/util/List;->get(I)Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Lcom/google/protobuf/MessageLite;

    invoke-static {v3, v0}, Lcom/google/protobuf/CodedOutputStream;->computeMessageSize(ILcom/google/protobuf/MessageLite;)I

    move-result v0

    add-int/2addr v2, v0

    .line 14191
    add-int/lit8 v0, v1, 0x1

    move v1, v0

    goto :goto_1
.end method

.method public getUninterpretedOption(I)Lcom/google/protobuf/DescriptorProtos$UninterpretedOption;
    .locals 1

    .prologue
    .line 14143
    iget-object v0, p0, Lcom/google/protobuf/DescriptorProtos$MethodOptions;->uninterpretedOption_:Ljava/util/List;

    invoke-interface {v0, p1}, Ljava/util/List;->get(I)Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Lcom/google/protobuf/DescriptorProtos$UninterpretedOption;

    return-object v0
.end method

.method public getUninterpretedOptionCount()I
    .locals 1

    .prologue
    .line 14140
    iget-object v0, p0, Lcom/google/protobuf/DescriptorProtos$MethodOptions;->uninterpretedOption_:Ljava/util/List;

    invoke-interface {v0}, Ljava/util/List;->size()I

    move-result v0

    return v0
.end method

.method public getUninterpretedOptionList()Ljava/util/List;
    .locals 1
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "()",
            "Ljava/util/List",
            "<",
            "Lcom/google/protobuf/DescriptorProtos$UninterpretedOption;",
            ">;"
        }
    .end annotation

    .prologue
    .line 14133
    iget-object v0, p0, Lcom/google/protobuf/DescriptorProtos$MethodOptions;->uninterpretedOption_:Ljava/util/List;

    return-object v0
.end method

.method public getUninterpretedOptionOrBuilder(I)Lcom/google/protobuf/DescriptorProtos$UninterpretedOptionOrBuilder;
    .locals 1

    .prologue
    .line 14147
    iget-object v0, p0, Lcom/google/protobuf/DescriptorProtos$MethodOptions;->uninterpretedOption_:Ljava/util/List;

    invoke-interface {v0, p1}, Ljava/util/List;->get(I)Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Lcom/google/protobuf/DescriptorProtos$UninterpretedOptionOrBuilder;

    return-object v0
.end method

.method public getUninterpretedOptionOrBuilderList()Ljava/util/List;
    .locals 1
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "()",
            "Ljava/util/List",
            "<+",
            "Lcom/google/protobuf/DescriptorProtos$UninterpretedOptionOrBuilder;",
            ">;"
        }
    .end annotation

    .prologue
    .line 14137
    iget-object v0, p0, Lcom/google/protobuf/DescriptorProtos$MethodOptions;->uninterpretedOption_:Ljava/util/List;

    return-object v0
.end method

.method protected internalGetFieldAccessorTable()Lcom/google/protobuf/GeneratedMessage$FieldAccessorTable;
    .locals 1

    .prologue
    .line 14126
    invoke-static {}, Lcom/google/protobuf/DescriptorProtos;->access$76()Lcom/google/protobuf/GeneratedMessage$FieldAccessorTable;

    move-result-object v0

    return-object v0
.end method

.method public final isInitialized()Z
    .locals 4

    .prologue
    const/4 v2, 0x1

    const/4 v1, 0x0

    .line 14155
    iget-byte v0, p0, Lcom/google/protobuf/DescriptorProtos$MethodOptions;->memoizedIsInitialized:B

    .line 14156
    const/4 v3, -0x1

    if-eq v0, v3, :cond_1

    if-ne v0, v2, :cond_0

    move v1, v2

    .line 14169
    :cond_0
    :goto_0
    return v1

    :cond_1
    move v0, v1

    .line 14158
    :goto_1
    invoke-virtual {p0}, Lcom/google/protobuf/DescriptorProtos$MethodOptions;->getUninterpretedOptionCount()I

    move-result v3

    if-lt v0, v3, :cond_2

    .line 14164
    invoke-virtual {p0}, Lcom/google/protobuf/DescriptorProtos$MethodOptions;->extensionsAreInitialized()Z

    move-result v0

    if-nez v0, :cond_4

    .line 14165
    iput-byte v1, p0, Lcom/google/protobuf/DescriptorProtos$MethodOptions;->memoizedIsInitialized:B

    goto :goto_0

    .line 14159
    :cond_2
    invoke-virtual {p0, v0}, Lcom/google/protobuf/DescriptorProtos$MethodOptions;->getUninterpretedOption(I)Lcom/google/protobuf/DescriptorProtos$UninterpretedOption;

    move-result-object v3

    invoke-virtual {v3}, Lcom/google/protobuf/DescriptorProtos$UninterpretedOption;->isInitialized()Z

    move-result v3

    if-nez v3, :cond_3

    .line 14160
    iput-byte v1, p0, Lcom/google/protobuf/DescriptorProtos$MethodOptions;->memoizedIsInitialized:B

    goto :goto_0

    .line 14158
    :cond_3
    add-int/lit8 v0, v0, 0x1

    goto :goto_1

    .line 14168
    :cond_4
    iput-byte v2, p0, Lcom/google/protobuf/DescriptorProtos$MethodOptions;->memoizedIsInitialized:B

    move v1, v2

    .line 14169
    goto :goto_0
.end method

.method public newBuilderForType()Lcom/google/protobuf/DescriptorProtos$MethodOptions$Builder;
    .locals 1

    .prologue
    .line 14276
    invoke-static {}, Lcom/google/protobuf/DescriptorProtos$MethodOptions;->newBuilder()Lcom/google/protobuf/DescriptorProtos$MethodOptions$Builder;

    move-result-object v0

    return-object v0
.end method

.method protected newBuilderForType(Lcom/google/protobuf/GeneratedMessage$BuilderParent;)Lcom/google/protobuf/DescriptorProtos$MethodOptions$Builder;
    .locals 2

    .prologue
    .line 14285
    new-instance v0, Lcom/google/protobuf/DescriptorProtos$MethodOptions$Builder;

    const/4 v1, 0x0

    invoke-direct {v0, p1, v1}, Lcom/google/protobuf/DescriptorProtos$MethodOptions$Builder;-><init>(Lcom/google/protobuf/GeneratedMessage$BuilderParent;Lcom/google/protobuf/DescriptorProtos$MethodOptions$Builder;)V

    .line 14286
    return-object v0
.end method

.method public bridge synthetic newBuilderForType()Lcom/google/protobuf/Message$Builder;
    .locals 1

    .prologue
    .line 1
    invoke-virtual {p0}, Lcom/google/protobuf/DescriptorProtos$MethodOptions;->newBuilderForType()Lcom/google/protobuf/DescriptorProtos$MethodOptions$Builder;

    move-result-object v0

    return-object v0
.end method

.method protected bridge synthetic newBuilderForType(Lcom/google/protobuf/GeneratedMessage$BuilderParent;)Lcom/google/protobuf/Message$Builder;
    .locals 1

    .prologue
    .line 1
    invoke-virtual {p0, p1}, Lcom/google/protobuf/DescriptorProtos$MethodOptions;->newBuilderForType(Lcom/google/protobuf/GeneratedMessage$BuilderParent;)Lcom/google/protobuf/DescriptorProtos$MethodOptions$Builder;

    move-result-object v0

    return-object v0
.end method

.method public bridge synthetic newBuilderForType()Lcom/google/protobuf/MessageLite$Builder;
    .locals 1

    .prologue
    .line 1
    invoke-virtual {p0}, Lcom/google/protobuf/DescriptorProtos$MethodOptions;->newBuilderForType()Lcom/google/protobuf/DescriptorProtos$MethodOptions$Builder;

    move-result-object v0

    return-object v0
.end method

.method public toBuilder()Lcom/google/protobuf/DescriptorProtos$MethodOptions$Builder;
    .locals 1

    .prologue
    .line 14280
    invoke-static {p0}, Lcom/google/protobuf/DescriptorProtos$MethodOptions;->newBuilder(Lcom/google/protobuf/DescriptorProtos$MethodOptions;)Lcom/google/protobuf/DescriptorProtos$MethodOptions$Builder;

    move-result-object v0

    return-object v0
.end method

.method public bridge synthetic toBuilder()Lcom/google/protobuf/Message$Builder;
    .locals 1

    .prologue
    .line 1
    invoke-virtual {p0}, Lcom/google/protobuf/DescriptorProtos$MethodOptions;->toBuilder()Lcom/google/protobuf/DescriptorProtos$MethodOptions$Builder;

    move-result-object v0

    return-object v0
.end method

.method public bridge synthetic toBuilder()Lcom/google/protobuf/MessageLite$Builder;
    .locals 1

    .prologue
    .line 1
    invoke-virtual {p0}, Lcom/google/protobuf/DescriptorProtos$MethodOptions;->toBuilder()Lcom/google/protobuf/DescriptorProtos$MethodOptions$Builder;

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
    .line 14205
    invoke-super {p0}, Lcom/google/protobuf/GeneratedMessage$ExtendableMessage;->writeReplace()Ljava/lang/Object;

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
    .line 14174
    invoke-virtual {p0}, Lcom/google/protobuf/DescriptorProtos$MethodOptions;->getSerializedSize()I

    .line 14177
    invoke-virtual {p0}, Lcom/google/protobuf/DescriptorProtos$MethodOptions;->newExtensionWriter()Lcom/google/protobuf/GeneratedMessage$ExtendableMessage$ExtensionWriter;

    move-result-object v2

    .line 14178
    const/4 v0, 0x0

    move v1, v0

    :goto_0
    iget-object v0, p0, Lcom/google/protobuf/DescriptorProtos$MethodOptions;->uninterpretedOption_:Ljava/util/List;

    invoke-interface {v0}, Ljava/util/List;->size()I

    move-result v0

    if-lt v1, v0, :cond_0

    .line 14181
    const/high16 v0, 0x20000000

    invoke-virtual {v2, v0, p1}, Lcom/google/protobuf/GeneratedMessage$ExtendableMessage$ExtensionWriter;->writeUntil(ILcom/google/protobuf/CodedOutputStream;)V

    .line 14182
    invoke-virtual {p0}, Lcom/google/protobuf/DescriptorProtos$MethodOptions;->getUnknownFields()Lcom/google/protobuf/UnknownFieldSet;

    move-result-object v0

    invoke-virtual {v0, p1}, Lcom/google/protobuf/UnknownFieldSet;->writeTo(Lcom/google/protobuf/CodedOutputStream;)V

    .line 14183
    return-void

    .line 14179
    :cond_0
    const/16 v3, 0x3e7

    iget-object v0, p0, Lcom/google/protobuf/DescriptorProtos$MethodOptions;->uninterpretedOption_:Ljava/util/List;

    invoke-interface {v0, v1}, Ljava/util/List;->get(I)Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Lcom/google/protobuf/MessageLite;

    invoke-virtual {p1, v3, v0}, Lcom/google/protobuf/CodedOutputStream;->writeMessage(ILcom/google/protobuf/MessageLite;)V

    .line 14178
    add-int/lit8 v0, v1, 0x1

    move v1, v0

    goto :goto_0
.end method
