.class public final Lcom/google/protobuf/DescriptorProtos$FileDescriptorSet;
.super Lcom/google/protobuf/GeneratedMessage;
.source "SourceFile"

# interfaces
.implements Lcom/google/protobuf/DescriptorProtos$FileDescriptorSetOrBuilder;


# annotations
.annotation system Ldalvik/annotation/EnclosingClass;
    value = Lcom/google/protobuf/DescriptorProtos;
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x19
    name = "FileDescriptorSet"
.end annotation

.annotation system Ldalvik/annotation/MemberClasses;
    value = {
        Lcom/google/protobuf/DescriptorProtos$FileDescriptorSet$Builder;
    }
.end annotation


# static fields
.field public static final FILE_FIELD_NUMBER:I = 0x1

.field private static final defaultInstance:Lcom/google/protobuf/DescriptorProtos$FileDescriptorSet;

.field private static final serialVersionUID:J


# instance fields
.field private file_:Ljava/util/List;
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "Ljava/util/List",
            "<",
            "Lcom/google/protobuf/DescriptorProtos$FileDescriptorProto;",
            ">;"
        }
    .end annotation
.end field

.field private memoizedIsInitialized:B

.field private memoizedSerializedSize:I


# direct methods
.method static constructor <clinit>()V
    .locals 2

    .prologue
    .line 567
    new-instance v0, Lcom/google/protobuf/DescriptorProtos$FileDescriptorSet;

    const/4 v1, 0x1

    invoke-direct {v0, v1}, Lcom/google/protobuf/DescriptorProtos$FileDescriptorSet;-><init>(Z)V

    sput-object v0, Lcom/google/protobuf/DescriptorProtos$FileDescriptorSet;->defaultInstance:Lcom/google/protobuf/DescriptorProtos$FileDescriptorSet;

    .line 568
    sget-object v0, Lcom/google/protobuf/DescriptorProtos$FileDescriptorSet;->defaultInstance:Lcom/google/protobuf/DescriptorProtos$FileDescriptorSet;

    invoke-direct {v0}, Lcom/google/protobuf/DescriptorProtos$FileDescriptorSet;->initFields()V

    .line 24
    return-void
.end method

.method private constructor <init>(Lcom/google/protobuf/DescriptorProtos$FileDescriptorSet$Builder;)V
    .locals 1

    .prologue
    const/4 v0, -0x1

    .line 29
    invoke-direct {p0, p1}, Lcom/google/protobuf/GeneratedMessage;-><init>(Lcom/google/protobuf/GeneratedMessage$Builder;)V

    .line 76
    iput-byte v0, p0, Lcom/google/protobuf/DescriptorProtos$FileDescriptorSet;->memoizedIsInitialized:B

    .line 100
    iput v0, p0, Lcom/google/protobuf/DescriptorProtos$FileDescriptorSet;->memoizedSerializedSize:I

    .line 30
    return-void
.end method

.method synthetic constructor <init>(Lcom/google/protobuf/DescriptorProtos$FileDescriptorSet$Builder;Lcom/google/protobuf/DescriptorProtos$FileDescriptorSet;)V
    .locals 0

    .prologue
    .line 28
    invoke-direct {p0, p1}, Lcom/google/protobuf/DescriptorProtos$FileDescriptorSet;-><init>(Lcom/google/protobuf/DescriptorProtos$FileDescriptorSet$Builder;)V

    return-void
.end method

.method private constructor <init>(Z)V
    .locals 1

    .prologue
    const/4 v0, -0x1

    .line 31
    invoke-direct {p0}, Lcom/google/protobuf/GeneratedMessage;-><init>()V

    .line 76
    iput-byte v0, p0, Lcom/google/protobuf/DescriptorProtos$FileDescriptorSet;->memoizedIsInitialized:B

    .line 100
    iput v0, p0, Lcom/google/protobuf/DescriptorProtos$FileDescriptorSet;->memoizedSerializedSize:I

    .line 31
    return-void
.end method

.method static synthetic access$8(Lcom/google/protobuf/DescriptorProtos$FileDescriptorSet;Ljava/util/List;)V
    .locals 0

    .prologue
    .line 54
    iput-object p1, p0, Lcom/google/protobuf/DescriptorProtos$FileDescriptorSet;->file_:Ljava/util/List;

    return-void
.end method

.method static synthetic access$9(Lcom/google/protobuf/DescriptorProtos$FileDescriptorSet;)Ljava/util/List;
    .locals 1

    .prologue
    .line 54
    iget-object v0, p0, Lcom/google/protobuf/DescriptorProtos$FileDescriptorSet;->file_:Ljava/util/List;

    return-object v0
.end method

.method public static getDefaultInstance()Lcom/google/protobuf/DescriptorProtos$FileDescriptorSet;
    .locals 1

    .prologue
    .line 35
    sget-object v0, Lcom/google/protobuf/DescriptorProtos$FileDescriptorSet;->defaultInstance:Lcom/google/protobuf/DescriptorProtos$FileDescriptorSet;

    return-object v0
.end method

.method public static final getDescriptor()Lcom/google/protobuf/Descriptors$Descriptor;
    .locals 1

    .prologue
    .line 44
    invoke-static {}, Lcom/google/protobuf/DescriptorProtos;->access$2()Lcom/google/protobuf/Descriptors$Descriptor;

    move-result-object v0

    return-object v0
.end method

.method private initFields()V
    .locals 1

    .prologue
    .line 74
    invoke-static {}, Ljava/util/Collections;->emptyList()Ljava/util/List;

    move-result-object v0

    iput-object v0, p0, Lcom/google/protobuf/DescriptorProtos$FileDescriptorSet;->file_:Ljava/util/List;

    .line 75
    return-void
.end method

.method public static newBuilder()Lcom/google/protobuf/DescriptorProtos$FileDescriptorSet$Builder;
    .locals 1

    .prologue
    .line 189
    invoke-static {}, Lcom/google/protobuf/DescriptorProtos$FileDescriptorSet$Builder;->access$18()Lcom/google/protobuf/DescriptorProtos$FileDescriptorSet$Builder;

    move-result-object v0

    return-object v0
.end method

.method public static newBuilder(Lcom/google/protobuf/DescriptorProtos$FileDescriptorSet;)Lcom/google/protobuf/DescriptorProtos$FileDescriptorSet$Builder;
    .locals 1

    .prologue
    .line 192
    invoke-static {}, Lcom/google/protobuf/DescriptorProtos$FileDescriptorSet;->newBuilder()Lcom/google/protobuf/DescriptorProtos$FileDescriptorSet$Builder;

    move-result-object v0

    invoke-virtual {v0, p0}, Lcom/google/protobuf/DescriptorProtos$FileDescriptorSet$Builder;->mergeFrom(Lcom/google/protobuf/DescriptorProtos$FileDescriptorSet;)Lcom/google/protobuf/DescriptorProtos$FileDescriptorSet$Builder;

    move-result-object v0

    return-object v0
.end method

.method public static parseDelimitedFrom(Ljava/io/InputStream;)Lcom/google/protobuf/DescriptorProtos$FileDescriptorSet;
    .locals 2
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljava/io/IOException;
        }
    .end annotation

    .prologue
    .line 158
    invoke-static {}, Lcom/google/protobuf/DescriptorProtos$FileDescriptorSet;->newBuilder()Lcom/google/protobuf/DescriptorProtos$FileDescriptorSet$Builder;

    move-result-object v0

    .line 159
    invoke-virtual {v0, p0}, Lcom/google/protobuf/DescriptorProtos$FileDescriptorSet$Builder;->mergeDelimitedFrom(Ljava/io/InputStream;)Z

    move-result v1

    if-eqz v1, :cond_0

    .line 160
    invoke-static {v0}, Lcom/google/protobuf/DescriptorProtos$FileDescriptorSet$Builder;->access$17(Lcom/google/protobuf/DescriptorProtos$FileDescriptorSet$Builder;)Lcom/google/protobuf/DescriptorProtos$FileDescriptorSet;

    move-result-object v0

    .line 162
    :goto_0
    return-object v0

    :cond_0
    const/4 v0, 0x0

    goto :goto_0
.end method

.method public static parseDelimitedFrom(Ljava/io/InputStream;Lcom/google/protobuf/ExtensionRegistryLite;)Lcom/google/protobuf/DescriptorProtos$FileDescriptorSet;
    .locals 2
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljava/io/IOException;
        }
    .end annotation

    .prologue
    .line 169
    invoke-static {}, Lcom/google/protobuf/DescriptorProtos$FileDescriptorSet;->newBuilder()Lcom/google/protobuf/DescriptorProtos$FileDescriptorSet$Builder;

    move-result-object v0

    .line 170
    invoke-virtual {v0, p0, p1}, Lcom/google/protobuf/DescriptorProtos$FileDescriptorSet$Builder;->mergeDelimitedFrom(Ljava/io/InputStream;Lcom/google/protobuf/ExtensionRegistryLite;)Z

    move-result v1

    if-eqz v1, :cond_0

    .line 171
    invoke-static {v0}, Lcom/google/protobuf/DescriptorProtos$FileDescriptorSet$Builder;->access$17(Lcom/google/protobuf/DescriptorProtos$FileDescriptorSet$Builder;)Lcom/google/protobuf/DescriptorProtos$FileDescriptorSet;

    move-result-object v0

    .line 173
    :goto_0
    return-object v0

    :cond_0
    const/4 v0, 0x0

    goto :goto_0
.end method

.method public static parseFrom(Lcom/google/protobuf/ByteString;)Lcom/google/protobuf/DescriptorProtos$FileDescriptorSet;
    .locals 1
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Lcom/google/protobuf/InvalidProtocolBufferException;
        }
    .end annotation

    .prologue
    .line 125
    invoke-static {}, Lcom/google/protobuf/DescriptorProtos$FileDescriptorSet;->newBuilder()Lcom/google/protobuf/DescriptorProtos$FileDescriptorSet$Builder;

    move-result-object v0

    invoke-virtual {v0, p0}, Lcom/google/protobuf/DescriptorProtos$FileDescriptorSet$Builder;->mergeFrom(Lcom/google/protobuf/ByteString;)Lcom/google/protobuf/AbstractMessage$Builder;

    move-result-object v0

    check-cast v0, Lcom/google/protobuf/DescriptorProtos$FileDescriptorSet$Builder;

    invoke-static {v0}, Lcom/google/protobuf/DescriptorProtos$FileDescriptorSet$Builder;->access$17(Lcom/google/protobuf/DescriptorProtos$FileDescriptorSet$Builder;)Lcom/google/protobuf/DescriptorProtos$FileDescriptorSet;

    move-result-object v0

    return-object v0
.end method

.method public static parseFrom(Lcom/google/protobuf/ByteString;Lcom/google/protobuf/ExtensionRegistryLite;)Lcom/google/protobuf/DescriptorProtos$FileDescriptorSet;
    .locals 1
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Lcom/google/protobuf/InvalidProtocolBufferException;
        }
    .end annotation

    .prologue
    .line 131
    invoke-static {}, Lcom/google/protobuf/DescriptorProtos$FileDescriptorSet;->newBuilder()Lcom/google/protobuf/DescriptorProtos$FileDescriptorSet$Builder;

    move-result-object v0

    invoke-virtual {v0, p0, p1}, Lcom/google/protobuf/DescriptorProtos$FileDescriptorSet$Builder;->mergeFrom(Lcom/google/protobuf/ByteString;Lcom/google/protobuf/ExtensionRegistryLite;)Lcom/google/protobuf/AbstractMessage$Builder;

    move-result-object v0

    check-cast v0, Lcom/google/protobuf/DescriptorProtos$FileDescriptorSet$Builder;

    .line 132
    invoke-static {v0}, Lcom/google/protobuf/DescriptorProtos$FileDescriptorSet$Builder;->access$17(Lcom/google/protobuf/DescriptorProtos$FileDescriptorSet$Builder;)Lcom/google/protobuf/DescriptorProtos$FileDescriptorSet;

    move-result-object v0

    .line 131
    return-object v0
.end method

.method public static parseFrom(Lcom/google/protobuf/CodedInputStream;)Lcom/google/protobuf/DescriptorProtos$FileDescriptorSet;
    .locals 1
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljava/io/IOException;
        }
    .end annotation

    .prologue
    .line 179
    invoke-static {}, Lcom/google/protobuf/DescriptorProtos$FileDescriptorSet;->newBuilder()Lcom/google/protobuf/DescriptorProtos$FileDescriptorSet$Builder;

    move-result-object v0

    invoke-virtual {v0, p0}, Lcom/google/protobuf/DescriptorProtos$FileDescriptorSet$Builder;->mergeFrom(Lcom/google/protobuf/CodedInputStream;)Lcom/google/protobuf/AbstractMessage$Builder;

    move-result-object v0

    check-cast v0, Lcom/google/protobuf/DescriptorProtos$FileDescriptorSet$Builder;

    invoke-static {v0}, Lcom/google/protobuf/DescriptorProtos$FileDescriptorSet$Builder;->access$17(Lcom/google/protobuf/DescriptorProtos$FileDescriptorSet$Builder;)Lcom/google/protobuf/DescriptorProtos$FileDescriptorSet;

    move-result-object v0

    return-object v0
.end method

.method public static parseFrom(Lcom/google/protobuf/CodedInputStream;Lcom/google/protobuf/ExtensionRegistryLite;)Lcom/google/protobuf/DescriptorProtos$FileDescriptorSet;
    .locals 1
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljava/io/IOException;
        }
    .end annotation

    .prologue
    .line 185
    invoke-static {}, Lcom/google/protobuf/DescriptorProtos$FileDescriptorSet;->newBuilder()Lcom/google/protobuf/DescriptorProtos$FileDescriptorSet$Builder;

    move-result-object v0

    invoke-virtual {v0, p0, p1}, Lcom/google/protobuf/DescriptorProtos$FileDescriptorSet$Builder;->mergeFrom(Lcom/google/protobuf/CodedInputStream;Lcom/google/protobuf/ExtensionRegistryLite;)Lcom/google/protobuf/DescriptorProtos$FileDescriptorSet$Builder;

    move-result-object v0

    .line 186
    invoke-static {v0}, Lcom/google/protobuf/DescriptorProtos$FileDescriptorSet$Builder;->access$17(Lcom/google/protobuf/DescriptorProtos$FileDescriptorSet$Builder;)Lcom/google/protobuf/DescriptorProtos$FileDescriptorSet;

    move-result-object v0

    .line 185
    return-object v0
.end method

.method public static parseFrom(Ljava/io/InputStream;)Lcom/google/protobuf/DescriptorProtos$FileDescriptorSet;
    .locals 1
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljava/io/IOException;
        }
    .end annotation

    .prologue
    .line 147
    invoke-static {}, Lcom/google/protobuf/DescriptorProtos$FileDescriptorSet;->newBuilder()Lcom/google/protobuf/DescriptorProtos$FileDescriptorSet$Builder;

    move-result-object v0

    invoke-virtual {v0, p0}, Lcom/google/protobuf/DescriptorProtos$FileDescriptorSet$Builder;->mergeFrom(Ljava/io/InputStream;)Lcom/google/protobuf/AbstractMessage$Builder;

    move-result-object v0

    check-cast v0, Lcom/google/protobuf/DescriptorProtos$FileDescriptorSet$Builder;

    invoke-static {v0}, Lcom/google/protobuf/DescriptorProtos$FileDescriptorSet$Builder;->access$17(Lcom/google/protobuf/DescriptorProtos$FileDescriptorSet$Builder;)Lcom/google/protobuf/DescriptorProtos$FileDescriptorSet;

    move-result-object v0

    return-object v0
.end method

.method public static parseFrom(Ljava/io/InputStream;Lcom/google/protobuf/ExtensionRegistryLite;)Lcom/google/protobuf/DescriptorProtos$FileDescriptorSet;
    .locals 1
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljava/io/IOException;
        }
    .end annotation

    .prologue
    .line 153
    invoke-static {}, Lcom/google/protobuf/DescriptorProtos$FileDescriptorSet;->newBuilder()Lcom/google/protobuf/DescriptorProtos$FileDescriptorSet$Builder;

    move-result-object v0

    invoke-virtual {v0, p0, p1}, Lcom/google/protobuf/DescriptorProtos$FileDescriptorSet$Builder;->mergeFrom(Ljava/io/InputStream;Lcom/google/protobuf/ExtensionRegistryLite;)Lcom/google/protobuf/AbstractMessage$Builder;

    move-result-object v0

    check-cast v0, Lcom/google/protobuf/DescriptorProtos$FileDescriptorSet$Builder;

    .line 154
    invoke-static {v0}, Lcom/google/protobuf/DescriptorProtos$FileDescriptorSet$Builder;->access$17(Lcom/google/protobuf/DescriptorProtos$FileDescriptorSet$Builder;)Lcom/google/protobuf/DescriptorProtos$FileDescriptorSet;

    move-result-object v0

    .line 153
    return-object v0
.end method

.method public static parseFrom([B)Lcom/google/protobuf/DescriptorProtos$FileDescriptorSet;
    .locals 1
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Lcom/google/protobuf/InvalidProtocolBufferException;
        }
    .end annotation

    .prologue
    .line 136
    invoke-static {}, Lcom/google/protobuf/DescriptorProtos$FileDescriptorSet;->newBuilder()Lcom/google/protobuf/DescriptorProtos$FileDescriptorSet$Builder;

    move-result-object v0

    invoke-virtual {v0, p0}, Lcom/google/protobuf/DescriptorProtos$FileDescriptorSet$Builder;->mergeFrom([B)Lcom/google/protobuf/AbstractMessage$Builder;

    move-result-object v0

    check-cast v0, Lcom/google/protobuf/DescriptorProtos$FileDescriptorSet$Builder;

    invoke-static {v0}, Lcom/google/protobuf/DescriptorProtos$FileDescriptorSet$Builder;->access$17(Lcom/google/protobuf/DescriptorProtos$FileDescriptorSet$Builder;)Lcom/google/protobuf/DescriptorProtos$FileDescriptorSet;

    move-result-object v0

    return-object v0
.end method

.method public static parseFrom([BLcom/google/protobuf/ExtensionRegistryLite;)Lcom/google/protobuf/DescriptorProtos$FileDescriptorSet;
    .locals 1
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Lcom/google/protobuf/InvalidProtocolBufferException;
        }
    .end annotation

    .prologue
    .line 142
    invoke-static {}, Lcom/google/protobuf/DescriptorProtos$FileDescriptorSet;->newBuilder()Lcom/google/protobuf/DescriptorProtos$FileDescriptorSet$Builder;

    move-result-object v0

    invoke-virtual {v0, p0, p1}, Lcom/google/protobuf/DescriptorProtos$FileDescriptorSet$Builder;->mergeFrom([BLcom/google/protobuf/ExtensionRegistryLite;)Lcom/google/protobuf/AbstractMessage$Builder;

    move-result-object v0

    check-cast v0, Lcom/google/protobuf/DescriptorProtos$FileDescriptorSet$Builder;

    .line 143
    invoke-static {v0}, Lcom/google/protobuf/DescriptorProtos$FileDescriptorSet$Builder;->access$17(Lcom/google/protobuf/DescriptorProtos$FileDescriptorSet$Builder;)Lcom/google/protobuf/DescriptorProtos$FileDescriptorSet;

    move-result-object v0

    .line 142
    return-object v0
.end method


# virtual methods
.method public getDefaultInstanceForType()Lcom/google/protobuf/DescriptorProtos$FileDescriptorSet;
    .locals 1

    .prologue
    .line 39
    sget-object v0, Lcom/google/protobuf/DescriptorProtos$FileDescriptorSet;->defaultInstance:Lcom/google/protobuf/DescriptorProtos$FileDescriptorSet;

    return-object v0
.end method

.method public bridge synthetic getDefaultInstanceForType()Lcom/google/protobuf/Message;
    .locals 1

    .prologue
    .line 1
    invoke-virtual {p0}, Lcom/google/protobuf/DescriptorProtos$FileDescriptorSet;->getDefaultInstanceForType()Lcom/google/protobuf/DescriptorProtos$FileDescriptorSet;

    move-result-object v0

    return-object v0
.end method

.method public bridge synthetic getDefaultInstanceForType()Lcom/google/protobuf/MessageLite;
    .locals 1

    .prologue
    .line 1
    invoke-virtual {p0}, Lcom/google/protobuf/DescriptorProtos$FileDescriptorSet;->getDefaultInstanceForType()Lcom/google/protobuf/DescriptorProtos$FileDescriptorSet;

    move-result-object v0

    return-object v0
.end method

.method public getFile(I)Lcom/google/protobuf/DescriptorProtos$FileDescriptorProto;
    .locals 1

    .prologue
    .line 66
    iget-object v0, p0, Lcom/google/protobuf/DescriptorProtos$FileDescriptorSet;->file_:Ljava/util/List;

    invoke-interface {v0, p1}, Ljava/util/List;->get(I)Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Lcom/google/protobuf/DescriptorProtos$FileDescriptorProto;

    return-object v0
.end method

.method public getFileCount()I
    .locals 1

    .prologue
    .line 63
    iget-object v0, p0, Lcom/google/protobuf/DescriptorProtos$FileDescriptorSet;->file_:Ljava/util/List;

    invoke-interface {v0}, Ljava/util/List;->size()I

    move-result v0

    return v0
.end method

.method public getFileList()Ljava/util/List;
    .locals 1
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "()",
            "Ljava/util/List",
            "<",
            "Lcom/google/protobuf/DescriptorProtos$FileDescriptorProto;",
            ">;"
        }
    .end annotation

    .prologue
    .line 56
    iget-object v0, p0, Lcom/google/protobuf/DescriptorProtos$FileDescriptorSet;->file_:Ljava/util/List;

    return-object v0
.end method

.method public getFileOrBuilder(I)Lcom/google/protobuf/DescriptorProtos$FileDescriptorProtoOrBuilder;
    .locals 1

    .prologue
    .line 70
    iget-object v0, p0, Lcom/google/protobuf/DescriptorProtos$FileDescriptorSet;->file_:Ljava/util/List;

    invoke-interface {v0, p1}, Ljava/util/List;->get(I)Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Lcom/google/protobuf/DescriptorProtos$FileDescriptorProtoOrBuilder;

    return-object v0
.end method

.method public getFileOrBuilderList()Ljava/util/List;
    .locals 1
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "()",
            "Ljava/util/List",
            "<+",
            "Lcom/google/protobuf/DescriptorProtos$FileDescriptorProtoOrBuilder;",
            ">;"
        }
    .end annotation

    .prologue
    .line 60
    iget-object v0, p0, Lcom/google/protobuf/DescriptorProtos$FileDescriptorSet;->file_:Ljava/util/List;

    return-object v0
.end method

.method public getSerializedSize()I
    .locals 4

    .prologue
    const/4 v0, 0x0

    .line 102
    iget v1, p0, Lcom/google/protobuf/DescriptorProtos$FileDescriptorSet;->memoizedSerializedSize:I

    .line 103
    const/4 v2, -0x1

    if-eq v1, v2, :cond_0

    move v0, v1

    .line 112
    :goto_0
    return v0

    :cond_0
    move v1, v0

    move v2, v0

    .line 106
    :goto_1
    iget-object v0, p0, Lcom/google/protobuf/DescriptorProtos$FileDescriptorSet;->file_:Ljava/util/List;

    invoke-interface {v0}, Ljava/util/List;->size()I

    move-result v0

    if-lt v1, v0, :cond_1

    .line 110
    invoke-virtual {p0}, Lcom/google/protobuf/DescriptorProtos$FileDescriptorSet;->getUnknownFields()Lcom/google/protobuf/UnknownFieldSet;

    move-result-object v0

    invoke-virtual {v0}, Lcom/google/protobuf/UnknownFieldSet;->getSerializedSize()I

    move-result v0

    add-int/2addr v0, v2

    .line 111
    iput v0, p0, Lcom/google/protobuf/DescriptorProtos$FileDescriptorSet;->memoizedSerializedSize:I

    goto :goto_0

    .line 108
    :cond_1
    const/4 v3, 0x1

    iget-object v0, p0, Lcom/google/protobuf/DescriptorProtos$FileDescriptorSet;->file_:Ljava/util/List;

    invoke-interface {v0, v1}, Ljava/util/List;->get(I)Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Lcom/google/protobuf/MessageLite;

    invoke-static {v3, v0}, Lcom/google/protobuf/CodedOutputStream;->computeMessageSize(ILcom/google/protobuf/MessageLite;)I

    move-result v0

    add-int/2addr v2, v0

    .line 106
    add-int/lit8 v0, v1, 0x1

    move v1, v0

    goto :goto_1
.end method

.method protected internalGetFieldAccessorTable()Lcom/google/protobuf/GeneratedMessage$FieldAccessorTable;
    .locals 1

    .prologue
    .line 49
    invoke-static {}, Lcom/google/protobuf/DescriptorProtos;->access$61()Lcom/google/protobuf/GeneratedMessage$FieldAccessorTable;

    move-result-object v0

    return-object v0
.end method

.method public final isInitialized()Z
    .locals 4

    .prologue
    const/4 v2, 0x1

    const/4 v1, 0x0

    .line 78
    iget-byte v0, p0, Lcom/google/protobuf/DescriptorProtos$FileDescriptorSet;->memoizedIsInitialized:B

    .line 79
    const/4 v3, -0x1

    if-eq v0, v3, :cond_1

    if-ne v0, v2, :cond_0

    move v1, v2

    .line 88
    :cond_0
    :goto_0
    return v1

    :cond_1
    move v0, v1

    .line 81
    :goto_1
    invoke-virtual {p0}, Lcom/google/protobuf/DescriptorProtos$FileDescriptorSet;->getFileCount()I

    move-result v3

    if-lt v0, v3, :cond_2

    .line 87
    iput-byte v2, p0, Lcom/google/protobuf/DescriptorProtos$FileDescriptorSet;->memoizedIsInitialized:B

    move v1, v2

    .line 88
    goto :goto_0

    .line 82
    :cond_2
    invoke-virtual {p0, v0}, Lcom/google/protobuf/DescriptorProtos$FileDescriptorSet;->getFile(I)Lcom/google/protobuf/DescriptorProtos$FileDescriptorProto;

    move-result-object v3

    invoke-virtual {v3}, Lcom/google/protobuf/DescriptorProtos$FileDescriptorProto;->isInitialized()Z

    move-result v3

    if-nez v3, :cond_3

    .line 83
    iput-byte v1, p0, Lcom/google/protobuf/DescriptorProtos$FileDescriptorSet;->memoizedIsInitialized:B

    goto :goto_0

    .line 81
    :cond_3
    add-int/lit8 v0, v0, 0x1

    goto :goto_1
.end method

.method public newBuilderForType()Lcom/google/protobuf/DescriptorProtos$FileDescriptorSet$Builder;
    .locals 1

    .prologue
    .line 190
    invoke-static {}, Lcom/google/protobuf/DescriptorProtos$FileDescriptorSet;->newBuilder()Lcom/google/protobuf/DescriptorProtos$FileDescriptorSet$Builder;

    move-result-object v0

    return-object v0
.end method

.method protected newBuilderForType(Lcom/google/protobuf/GeneratedMessage$BuilderParent;)Lcom/google/protobuf/DescriptorProtos$FileDescriptorSet$Builder;
    .locals 2

    .prologue
    .line 199
    new-instance v0, Lcom/google/protobuf/DescriptorProtos$FileDescriptorSet$Builder;

    const/4 v1, 0x0

    invoke-direct {v0, p1, v1}, Lcom/google/protobuf/DescriptorProtos$FileDescriptorSet$Builder;-><init>(Lcom/google/protobuf/GeneratedMessage$BuilderParent;Lcom/google/protobuf/DescriptorProtos$FileDescriptorSet$Builder;)V

    .line 200
    return-object v0
.end method

.method public bridge synthetic newBuilderForType()Lcom/google/protobuf/Message$Builder;
    .locals 1

    .prologue
    .line 1
    invoke-virtual {p0}, Lcom/google/protobuf/DescriptorProtos$FileDescriptorSet;->newBuilderForType()Lcom/google/protobuf/DescriptorProtos$FileDescriptorSet$Builder;

    move-result-object v0

    return-object v0
.end method

.method protected bridge synthetic newBuilderForType(Lcom/google/protobuf/GeneratedMessage$BuilderParent;)Lcom/google/protobuf/Message$Builder;
    .locals 1

    .prologue
    .line 1
    invoke-virtual {p0, p1}, Lcom/google/protobuf/DescriptorProtos$FileDescriptorSet;->newBuilderForType(Lcom/google/protobuf/GeneratedMessage$BuilderParent;)Lcom/google/protobuf/DescriptorProtos$FileDescriptorSet$Builder;

    move-result-object v0

    return-object v0
.end method

.method public bridge synthetic newBuilderForType()Lcom/google/protobuf/MessageLite$Builder;
    .locals 1

    .prologue
    .line 1
    invoke-virtual {p0}, Lcom/google/protobuf/DescriptorProtos$FileDescriptorSet;->newBuilderForType()Lcom/google/protobuf/DescriptorProtos$FileDescriptorSet$Builder;

    move-result-object v0

    return-object v0
.end method

.method public toBuilder()Lcom/google/protobuf/DescriptorProtos$FileDescriptorSet$Builder;
    .locals 1

    .prologue
    .line 194
    invoke-static {p0}, Lcom/google/protobuf/DescriptorProtos$FileDescriptorSet;->newBuilder(Lcom/google/protobuf/DescriptorProtos$FileDescriptorSet;)Lcom/google/protobuf/DescriptorProtos$FileDescriptorSet$Builder;

    move-result-object v0

    return-object v0
.end method

.method public bridge synthetic toBuilder()Lcom/google/protobuf/Message$Builder;
    .locals 1

    .prologue
    .line 1
    invoke-virtual {p0}, Lcom/google/protobuf/DescriptorProtos$FileDescriptorSet;->toBuilder()Lcom/google/protobuf/DescriptorProtos$FileDescriptorSet$Builder;

    move-result-object v0

    return-object v0
.end method

.method public bridge synthetic toBuilder()Lcom/google/protobuf/MessageLite$Builder;
    .locals 1

    .prologue
    .line 1
    invoke-virtual {p0}, Lcom/google/protobuf/DescriptorProtos$FileDescriptorSet;->toBuilder()Lcom/google/protobuf/DescriptorProtos$FileDescriptorSet$Builder;

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
    .line 119
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
    .line 93
    invoke-virtual {p0}, Lcom/google/protobuf/DescriptorProtos$FileDescriptorSet;->getSerializedSize()I

    .line 94
    const/4 v0, 0x0

    move v1, v0

    :goto_0
    iget-object v0, p0, Lcom/google/protobuf/DescriptorProtos$FileDescriptorSet;->file_:Ljava/util/List;

    invoke-interface {v0}, Ljava/util/List;->size()I

    move-result v0

    if-lt v1, v0, :cond_0

    .line 97
    invoke-virtual {p0}, Lcom/google/protobuf/DescriptorProtos$FileDescriptorSet;->getUnknownFields()Lcom/google/protobuf/UnknownFieldSet;

    move-result-object v0

    invoke-virtual {v0, p1}, Lcom/google/protobuf/UnknownFieldSet;->writeTo(Lcom/google/protobuf/CodedOutputStream;)V

    .line 98
    return-void

    .line 95
    :cond_0
    const/4 v2, 0x1

    iget-object v0, p0, Lcom/google/protobuf/DescriptorProtos$FileDescriptorSet;->file_:Ljava/util/List;

    invoke-interface {v0, v1}, Ljava/util/List;->get(I)Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Lcom/google/protobuf/MessageLite;

    invoke-virtual {p1, v2, v0}, Lcom/google/protobuf/CodedOutputStream;->writeMessage(ILcom/google/protobuf/MessageLite;)V

    .line 94
    add-int/lit8 v0, v1, 0x1

    move v1, v0

    goto :goto_0
.end method
