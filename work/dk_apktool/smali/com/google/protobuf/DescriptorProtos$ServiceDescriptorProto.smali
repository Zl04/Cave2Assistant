.class public final Lcom/google/protobuf/DescriptorProtos$ServiceDescriptorProto;
.super Lcom/google/protobuf/GeneratedMessage;
.source "SourceFile"

# interfaces
.implements Lcom/google/protobuf/DescriptorProtos$ServiceDescriptorProtoOrBuilder;


# annotations
.annotation system Ldalvik/annotation/EnclosingClass;
    value = Lcom/google/protobuf/DescriptorProtos;
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x19
    name = "ServiceDescriptorProto"
.end annotation

.annotation system Ldalvik/annotation/MemberClasses;
    value = {
        Lcom/google/protobuf/DescriptorProtos$ServiceDescriptorProto$Builder;
    }
.end annotation


# static fields
.field public static final METHOD_FIELD_NUMBER:I = 0x2

.field public static final NAME_FIELD_NUMBER:I = 0x1

.field public static final OPTIONS_FIELD_NUMBER:I = 0x3

.field private static final defaultInstance:Lcom/google/protobuf/DescriptorProtos$ServiceDescriptorProto;

.field private static final serialVersionUID:J


# instance fields
.field private bitField0_:I

.field private memoizedIsInitialized:B

.field private memoizedSerializedSize:I

.field private method_:Ljava/util/List;
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "Ljava/util/List",
            "<",
            "Lcom/google/protobuf/DescriptorProtos$MethodDescriptorProto;",
            ">;"
        }
    .end annotation
.end field

.field private name_:Ljava/lang/Object;

.field private options_:Lcom/google/protobuf/DescriptorProtos$ServiceOptions;


# direct methods
.method static constructor <clinit>()V
    .locals 2

    .prologue
    .line 8546
    new-instance v0, Lcom/google/protobuf/DescriptorProtos$ServiceDescriptorProto;

    const/4 v1, 0x1

    invoke-direct {v0, v1}, Lcom/google/protobuf/DescriptorProtos$ServiceDescriptorProto;-><init>(Z)V

    sput-object v0, Lcom/google/protobuf/DescriptorProtos$ServiceDescriptorProto;->defaultInstance:Lcom/google/protobuf/DescriptorProtos$ServiceDescriptorProto;

    .line 8547
    sget-object v0, Lcom/google/protobuf/DescriptorProtos$ServiceDescriptorProto;->defaultInstance:Lcom/google/protobuf/DescriptorProtos$ServiceDescriptorProto;

    invoke-direct {v0}, Lcom/google/protobuf/DescriptorProtos$ServiceDescriptorProto;->initFields()V

    .line 7760
    return-void
.end method

.method private constructor <init>(Lcom/google/protobuf/DescriptorProtos$ServiceDescriptorProto$Builder;)V
    .locals 1

    .prologue
    const/4 v0, -0x1

    .line 7765
    invoke-direct {p0, p1}, Lcom/google/protobuf/GeneratedMessage;-><init>(Lcom/google/protobuf/GeneratedMessage$Builder;)V

    .line 7860
    iput-byte v0, p0, Lcom/google/protobuf/DescriptorProtos$ServiceDescriptorProto;->memoizedIsInitialized:B

    .line 7896
    iput v0, p0, Lcom/google/protobuf/DescriptorProtos$ServiceDescriptorProto;->memoizedSerializedSize:I

    .line 7766
    return-void
.end method

.method synthetic constructor <init>(Lcom/google/protobuf/DescriptorProtos$ServiceDescriptorProto$Builder;Lcom/google/protobuf/DescriptorProtos$ServiceDescriptorProto;)V
    .locals 0

    .prologue
    .line 7764
    invoke-direct {p0, p1}, Lcom/google/protobuf/DescriptorProtos$ServiceDescriptorProto;-><init>(Lcom/google/protobuf/DescriptorProtos$ServiceDescriptorProto$Builder;)V

    return-void
.end method

.method private constructor <init>(Z)V
    .locals 1

    .prologue
    const/4 v0, -0x1

    .line 7767
    invoke-direct {p0}, Lcom/google/protobuf/GeneratedMessage;-><init>()V

    .line 7860
    iput-byte v0, p0, Lcom/google/protobuf/DescriptorProtos$ServiceDescriptorProto;->memoizedIsInitialized:B

    .line 7896
    iput v0, p0, Lcom/google/protobuf/DescriptorProtos$ServiceDescriptorProto;->memoizedSerializedSize:I

    .line 7767
    return-void
.end method

.method static synthetic access$10(Lcom/google/protobuf/DescriptorProtos$ServiceDescriptorProto;Lcom/google/protobuf/DescriptorProtos$ServiceOptions;)V
    .locals 0

    .prologue
    .line 7844
    iput-object p1, p0, Lcom/google/protobuf/DescriptorProtos$ServiceDescriptorProto;->options_:Lcom/google/protobuf/DescriptorProtos$ServiceOptions;

    return-void
.end method

.method static synthetic access$11(Lcom/google/protobuf/DescriptorProtos$ServiceDescriptorProto;I)V
    .locals 0

    .prologue
    .line 7788
    iput p1, p0, Lcom/google/protobuf/DescriptorProtos$ServiceDescriptorProto;->bitField0_:I

    return-void
.end method

.method static synthetic access$12(Lcom/google/protobuf/DescriptorProtos$ServiceDescriptorProto;)Ljava/util/List;
    .locals 1

    .prologue
    .line 7823
    iget-object v0, p0, Lcom/google/protobuf/DescriptorProtos$ServiceDescriptorProto;->method_:Ljava/util/List;

    return-object v0
.end method

.method static synthetic access$8(Lcom/google/protobuf/DescriptorProtos$ServiceDescriptorProto;Ljava/lang/Object;)V
    .locals 0

    .prologue
    .line 7791
    iput-object p1, p0, Lcom/google/protobuf/DescriptorProtos$ServiceDescriptorProto;->name_:Ljava/lang/Object;

    return-void
.end method

.method static synthetic access$9(Lcom/google/protobuf/DescriptorProtos$ServiceDescriptorProto;Ljava/util/List;)V
    .locals 0

    .prologue
    .line 7823
    iput-object p1, p0, Lcom/google/protobuf/DescriptorProtos$ServiceDescriptorProto;->method_:Ljava/util/List;

    return-void
.end method

.method public static getDefaultInstance()Lcom/google/protobuf/DescriptorProtos$ServiceDescriptorProto;
    .locals 1

    .prologue
    .line 7771
    sget-object v0, Lcom/google/protobuf/DescriptorProtos$ServiceDescriptorProto;->defaultInstance:Lcom/google/protobuf/DescriptorProtos$ServiceDescriptorProto;

    return-object v0
.end method

.method public static final getDescriptor()Lcom/google/protobuf/Descriptors$Descriptor;
    .locals 1

    .prologue
    .line 7780
    invoke-static {}, Lcom/google/protobuf/DescriptorProtos;->access$23()Lcom/google/protobuf/Descriptors$Descriptor;

    move-result-object v0

    return-object v0
.end method

.method private getNameBytes()Lcom/google/protobuf/ByteString;
    .locals 2

    .prologue
    .line 7810
    iget-object v0, p0, Lcom/google/protobuf/DescriptorProtos$ServiceDescriptorProto;->name_:Ljava/lang/Object;

    .line 7811
    instance-of v1, v0, Ljava/lang/String;

    if-eqz v1, :cond_0

    .line 7813
    check-cast v0, Ljava/lang/String;

    invoke-static {v0}, Lcom/google/protobuf/ByteString;->copyFromUtf8(Ljava/lang/String;)Lcom/google/protobuf/ByteString;

    move-result-object v0

    .line 7814
    iput-object v0, p0, Lcom/google/protobuf/DescriptorProtos$ServiceDescriptorProto;->name_:Ljava/lang/Object;

    .line 7817
    :goto_0
    return-object v0

    :cond_0
    check-cast v0, Lcom/google/protobuf/ByteString;

    goto :goto_0
.end method

.method private initFields()V
    .locals 1

    .prologue
    .line 7856
    const-string v0, ""

    iput-object v0, p0, Lcom/google/protobuf/DescriptorProtos$ServiceDescriptorProto;->name_:Ljava/lang/Object;

    .line 7857
    invoke-static {}, Ljava/util/Collections;->emptyList()Ljava/util/List;

    move-result-object v0

    iput-object v0, p0, Lcom/google/protobuf/DescriptorProtos$ServiceDescriptorProto;->method_:Ljava/util/List;

    .line 7858
    invoke-static {}, Lcom/google/protobuf/DescriptorProtos$ServiceOptions;->getDefaultInstance()Lcom/google/protobuf/DescriptorProtos$ServiceOptions;

    move-result-object v0

    iput-object v0, p0, Lcom/google/protobuf/DescriptorProtos$ServiceDescriptorProto;->options_:Lcom/google/protobuf/DescriptorProtos$ServiceOptions;

    .line 7859
    return-void
.end method

.method public static newBuilder()Lcom/google/protobuf/DescriptorProtos$ServiceDescriptorProto$Builder;
    .locals 1

    .prologue
    .line 7993
    invoke-static {}, Lcom/google/protobuf/DescriptorProtos$ServiceDescriptorProto$Builder;->access$18()Lcom/google/protobuf/DescriptorProtos$ServiceDescriptorProto$Builder;

    move-result-object v0

    return-object v0
.end method

.method public static newBuilder(Lcom/google/protobuf/DescriptorProtos$ServiceDescriptorProto;)Lcom/google/protobuf/DescriptorProtos$ServiceDescriptorProto$Builder;
    .locals 1

    .prologue
    .line 7996
    invoke-static {}, Lcom/google/protobuf/DescriptorProtos$ServiceDescriptorProto;->newBuilder()Lcom/google/protobuf/DescriptorProtos$ServiceDescriptorProto$Builder;

    move-result-object v0

    invoke-virtual {v0, p0}, Lcom/google/protobuf/DescriptorProtos$ServiceDescriptorProto$Builder;->mergeFrom(Lcom/google/protobuf/DescriptorProtos$ServiceDescriptorProto;)Lcom/google/protobuf/DescriptorProtos$ServiceDescriptorProto$Builder;

    move-result-object v0

    return-object v0
.end method

.method public static parseDelimitedFrom(Ljava/io/InputStream;)Lcom/google/protobuf/DescriptorProtos$ServiceDescriptorProto;
    .locals 2
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljava/io/IOException;
        }
    .end annotation

    .prologue
    .line 7962
    invoke-static {}, Lcom/google/protobuf/DescriptorProtos$ServiceDescriptorProto;->newBuilder()Lcom/google/protobuf/DescriptorProtos$ServiceDescriptorProto$Builder;

    move-result-object v0

    .line 7963
    invoke-virtual {v0, p0}, Lcom/google/protobuf/DescriptorProtos$ServiceDescriptorProto$Builder;->mergeDelimitedFrom(Ljava/io/InputStream;)Z

    move-result v1

    if-eqz v1, :cond_0

    .line 7964
    invoke-static {v0}, Lcom/google/protobuf/DescriptorProtos$ServiceDescriptorProto$Builder;->access$17(Lcom/google/protobuf/DescriptorProtos$ServiceDescriptorProto$Builder;)Lcom/google/protobuf/DescriptorProtos$ServiceDescriptorProto;

    move-result-object v0

    .line 7966
    :goto_0
    return-object v0

    :cond_0
    const/4 v0, 0x0

    goto :goto_0
.end method

.method public static parseDelimitedFrom(Ljava/io/InputStream;Lcom/google/protobuf/ExtensionRegistryLite;)Lcom/google/protobuf/DescriptorProtos$ServiceDescriptorProto;
    .locals 2
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljava/io/IOException;
        }
    .end annotation

    .prologue
    .line 7973
    invoke-static {}, Lcom/google/protobuf/DescriptorProtos$ServiceDescriptorProto;->newBuilder()Lcom/google/protobuf/DescriptorProtos$ServiceDescriptorProto$Builder;

    move-result-object v0

    .line 7974
    invoke-virtual {v0, p0, p1}, Lcom/google/protobuf/DescriptorProtos$ServiceDescriptorProto$Builder;->mergeDelimitedFrom(Ljava/io/InputStream;Lcom/google/protobuf/ExtensionRegistryLite;)Z

    move-result v1

    if-eqz v1, :cond_0

    .line 7975
    invoke-static {v0}, Lcom/google/protobuf/DescriptorProtos$ServiceDescriptorProto$Builder;->access$17(Lcom/google/protobuf/DescriptorProtos$ServiceDescriptorProto$Builder;)Lcom/google/protobuf/DescriptorProtos$ServiceDescriptorProto;

    move-result-object v0

    .line 7977
    :goto_0
    return-object v0

    :cond_0
    const/4 v0, 0x0

    goto :goto_0
.end method

.method public static parseFrom(Lcom/google/protobuf/ByteString;)Lcom/google/protobuf/DescriptorProtos$ServiceDescriptorProto;
    .locals 1
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Lcom/google/protobuf/InvalidProtocolBufferException;
        }
    .end annotation

    .prologue
    .line 7929
    invoke-static {}, Lcom/google/protobuf/DescriptorProtos$ServiceDescriptorProto;->newBuilder()Lcom/google/protobuf/DescriptorProtos$ServiceDescriptorProto$Builder;

    move-result-object v0

    invoke-virtual {v0, p0}, Lcom/google/protobuf/DescriptorProtos$ServiceDescriptorProto$Builder;->mergeFrom(Lcom/google/protobuf/ByteString;)Lcom/google/protobuf/AbstractMessage$Builder;

    move-result-object v0

    check-cast v0, Lcom/google/protobuf/DescriptorProtos$ServiceDescriptorProto$Builder;

    invoke-static {v0}, Lcom/google/protobuf/DescriptorProtos$ServiceDescriptorProto$Builder;->access$17(Lcom/google/protobuf/DescriptorProtos$ServiceDescriptorProto$Builder;)Lcom/google/protobuf/DescriptorProtos$ServiceDescriptorProto;

    move-result-object v0

    return-object v0
.end method

.method public static parseFrom(Lcom/google/protobuf/ByteString;Lcom/google/protobuf/ExtensionRegistryLite;)Lcom/google/protobuf/DescriptorProtos$ServiceDescriptorProto;
    .locals 1
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Lcom/google/protobuf/InvalidProtocolBufferException;
        }
    .end annotation

    .prologue
    .line 7935
    invoke-static {}, Lcom/google/protobuf/DescriptorProtos$ServiceDescriptorProto;->newBuilder()Lcom/google/protobuf/DescriptorProtos$ServiceDescriptorProto$Builder;

    move-result-object v0

    invoke-virtual {v0, p0, p1}, Lcom/google/protobuf/DescriptorProtos$ServiceDescriptorProto$Builder;->mergeFrom(Lcom/google/protobuf/ByteString;Lcom/google/protobuf/ExtensionRegistryLite;)Lcom/google/protobuf/AbstractMessage$Builder;

    move-result-object v0

    check-cast v0, Lcom/google/protobuf/DescriptorProtos$ServiceDescriptorProto$Builder;

    .line 7936
    invoke-static {v0}, Lcom/google/protobuf/DescriptorProtos$ServiceDescriptorProto$Builder;->access$17(Lcom/google/protobuf/DescriptorProtos$ServiceDescriptorProto$Builder;)Lcom/google/protobuf/DescriptorProtos$ServiceDescriptorProto;

    move-result-object v0

    .line 7935
    return-object v0
.end method

.method public static parseFrom(Lcom/google/protobuf/CodedInputStream;)Lcom/google/protobuf/DescriptorProtos$ServiceDescriptorProto;
    .locals 1
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljava/io/IOException;
        }
    .end annotation

    .prologue
    .line 7983
    invoke-static {}, Lcom/google/protobuf/DescriptorProtos$ServiceDescriptorProto;->newBuilder()Lcom/google/protobuf/DescriptorProtos$ServiceDescriptorProto$Builder;

    move-result-object v0

    invoke-virtual {v0, p0}, Lcom/google/protobuf/DescriptorProtos$ServiceDescriptorProto$Builder;->mergeFrom(Lcom/google/protobuf/CodedInputStream;)Lcom/google/protobuf/AbstractMessage$Builder;

    move-result-object v0

    check-cast v0, Lcom/google/protobuf/DescriptorProtos$ServiceDescriptorProto$Builder;

    invoke-static {v0}, Lcom/google/protobuf/DescriptorProtos$ServiceDescriptorProto$Builder;->access$17(Lcom/google/protobuf/DescriptorProtos$ServiceDescriptorProto$Builder;)Lcom/google/protobuf/DescriptorProtos$ServiceDescriptorProto;

    move-result-object v0

    return-object v0
.end method

.method public static parseFrom(Lcom/google/protobuf/CodedInputStream;Lcom/google/protobuf/ExtensionRegistryLite;)Lcom/google/protobuf/DescriptorProtos$ServiceDescriptorProto;
    .locals 1
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljava/io/IOException;
        }
    .end annotation

    .prologue
    .line 7989
    invoke-static {}, Lcom/google/protobuf/DescriptorProtos$ServiceDescriptorProto;->newBuilder()Lcom/google/protobuf/DescriptorProtos$ServiceDescriptorProto$Builder;

    move-result-object v0

    invoke-virtual {v0, p0, p1}, Lcom/google/protobuf/DescriptorProtos$ServiceDescriptorProto$Builder;->mergeFrom(Lcom/google/protobuf/CodedInputStream;Lcom/google/protobuf/ExtensionRegistryLite;)Lcom/google/protobuf/DescriptorProtos$ServiceDescriptorProto$Builder;

    move-result-object v0

    .line 7990
    invoke-static {v0}, Lcom/google/protobuf/DescriptorProtos$ServiceDescriptorProto$Builder;->access$17(Lcom/google/protobuf/DescriptorProtos$ServiceDescriptorProto$Builder;)Lcom/google/protobuf/DescriptorProtos$ServiceDescriptorProto;

    move-result-object v0

    .line 7989
    return-object v0
.end method

.method public static parseFrom(Ljava/io/InputStream;)Lcom/google/protobuf/DescriptorProtos$ServiceDescriptorProto;
    .locals 1
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljava/io/IOException;
        }
    .end annotation

    .prologue
    .line 7951
    invoke-static {}, Lcom/google/protobuf/DescriptorProtos$ServiceDescriptorProto;->newBuilder()Lcom/google/protobuf/DescriptorProtos$ServiceDescriptorProto$Builder;

    move-result-object v0

    invoke-virtual {v0, p0}, Lcom/google/protobuf/DescriptorProtos$ServiceDescriptorProto$Builder;->mergeFrom(Ljava/io/InputStream;)Lcom/google/protobuf/AbstractMessage$Builder;

    move-result-object v0

    check-cast v0, Lcom/google/protobuf/DescriptorProtos$ServiceDescriptorProto$Builder;

    invoke-static {v0}, Lcom/google/protobuf/DescriptorProtos$ServiceDescriptorProto$Builder;->access$17(Lcom/google/protobuf/DescriptorProtos$ServiceDescriptorProto$Builder;)Lcom/google/protobuf/DescriptorProtos$ServiceDescriptorProto;

    move-result-object v0

    return-object v0
.end method

.method public static parseFrom(Ljava/io/InputStream;Lcom/google/protobuf/ExtensionRegistryLite;)Lcom/google/protobuf/DescriptorProtos$ServiceDescriptorProto;
    .locals 1
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljava/io/IOException;
        }
    .end annotation

    .prologue
    .line 7957
    invoke-static {}, Lcom/google/protobuf/DescriptorProtos$ServiceDescriptorProto;->newBuilder()Lcom/google/protobuf/DescriptorProtos$ServiceDescriptorProto$Builder;

    move-result-object v0

    invoke-virtual {v0, p0, p1}, Lcom/google/protobuf/DescriptorProtos$ServiceDescriptorProto$Builder;->mergeFrom(Ljava/io/InputStream;Lcom/google/protobuf/ExtensionRegistryLite;)Lcom/google/protobuf/AbstractMessage$Builder;

    move-result-object v0

    check-cast v0, Lcom/google/protobuf/DescriptorProtos$ServiceDescriptorProto$Builder;

    .line 7958
    invoke-static {v0}, Lcom/google/protobuf/DescriptorProtos$ServiceDescriptorProto$Builder;->access$17(Lcom/google/protobuf/DescriptorProtos$ServiceDescriptorProto$Builder;)Lcom/google/protobuf/DescriptorProtos$ServiceDescriptorProto;

    move-result-object v0

    .line 7957
    return-object v0
.end method

.method public static parseFrom([B)Lcom/google/protobuf/DescriptorProtos$ServiceDescriptorProto;
    .locals 1
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Lcom/google/protobuf/InvalidProtocolBufferException;
        }
    .end annotation

    .prologue
    .line 7940
    invoke-static {}, Lcom/google/protobuf/DescriptorProtos$ServiceDescriptorProto;->newBuilder()Lcom/google/protobuf/DescriptorProtos$ServiceDescriptorProto$Builder;

    move-result-object v0

    invoke-virtual {v0, p0}, Lcom/google/protobuf/DescriptorProtos$ServiceDescriptorProto$Builder;->mergeFrom([B)Lcom/google/protobuf/AbstractMessage$Builder;

    move-result-object v0

    check-cast v0, Lcom/google/protobuf/DescriptorProtos$ServiceDescriptorProto$Builder;

    invoke-static {v0}, Lcom/google/protobuf/DescriptorProtos$ServiceDescriptorProto$Builder;->access$17(Lcom/google/protobuf/DescriptorProtos$ServiceDescriptorProto$Builder;)Lcom/google/protobuf/DescriptorProtos$ServiceDescriptorProto;

    move-result-object v0

    return-object v0
.end method

.method public static parseFrom([BLcom/google/protobuf/ExtensionRegistryLite;)Lcom/google/protobuf/DescriptorProtos$ServiceDescriptorProto;
    .locals 1
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Lcom/google/protobuf/InvalidProtocolBufferException;
        }
    .end annotation

    .prologue
    .line 7946
    invoke-static {}, Lcom/google/protobuf/DescriptorProtos$ServiceDescriptorProto;->newBuilder()Lcom/google/protobuf/DescriptorProtos$ServiceDescriptorProto$Builder;

    move-result-object v0

    invoke-virtual {v0, p0, p1}, Lcom/google/protobuf/DescriptorProtos$ServiceDescriptorProto$Builder;->mergeFrom([BLcom/google/protobuf/ExtensionRegistryLite;)Lcom/google/protobuf/AbstractMessage$Builder;

    move-result-object v0

    check-cast v0, Lcom/google/protobuf/DescriptorProtos$ServiceDescriptorProto$Builder;

    .line 7947
    invoke-static {v0}, Lcom/google/protobuf/DescriptorProtos$ServiceDescriptorProto$Builder;->access$17(Lcom/google/protobuf/DescriptorProtos$ServiceDescriptorProto$Builder;)Lcom/google/protobuf/DescriptorProtos$ServiceDescriptorProto;

    move-result-object v0

    .line 7946
    return-object v0
.end method


# virtual methods
.method public getDefaultInstanceForType()Lcom/google/protobuf/DescriptorProtos$ServiceDescriptorProto;
    .locals 1

    .prologue
    .line 7775
    sget-object v0, Lcom/google/protobuf/DescriptorProtos$ServiceDescriptorProto;->defaultInstance:Lcom/google/protobuf/DescriptorProtos$ServiceDescriptorProto;

    return-object v0
.end method

.method public bridge synthetic getDefaultInstanceForType()Lcom/google/protobuf/Message;
    .locals 1

    .prologue
    .line 1
    invoke-virtual {p0}, Lcom/google/protobuf/DescriptorProtos$ServiceDescriptorProto;->getDefaultInstanceForType()Lcom/google/protobuf/DescriptorProtos$ServiceDescriptorProto;

    move-result-object v0

    return-object v0
.end method

.method public bridge synthetic getDefaultInstanceForType()Lcom/google/protobuf/MessageLite;
    .locals 1

    .prologue
    .line 1
    invoke-virtual {p0}, Lcom/google/protobuf/DescriptorProtos$ServiceDescriptorProto;->getDefaultInstanceForType()Lcom/google/protobuf/DescriptorProtos$ServiceDescriptorProto;

    move-result-object v0

    return-object v0
.end method

.method public getMethod(I)Lcom/google/protobuf/DescriptorProtos$MethodDescriptorProto;
    .locals 1

    .prologue
    .line 7835
    iget-object v0, p0, Lcom/google/protobuf/DescriptorProtos$ServiceDescriptorProto;->method_:Ljava/util/List;

    invoke-interface {v0, p1}, Ljava/util/List;->get(I)Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Lcom/google/protobuf/DescriptorProtos$MethodDescriptorProto;

    return-object v0
.end method

.method public getMethodCount()I
    .locals 1

    .prologue
    .line 7832
    iget-object v0, p0, Lcom/google/protobuf/DescriptorProtos$ServiceDescriptorProto;->method_:Ljava/util/List;

    invoke-interface {v0}, Ljava/util/List;->size()I

    move-result v0

    return v0
.end method

.method public getMethodList()Ljava/util/List;
    .locals 1
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "()",
            "Ljava/util/List",
            "<",
            "Lcom/google/protobuf/DescriptorProtos$MethodDescriptorProto;",
            ">;"
        }
    .end annotation

    .prologue
    .line 7825
    iget-object v0, p0, Lcom/google/protobuf/DescriptorProtos$ServiceDescriptorProto;->method_:Ljava/util/List;

    return-object v0
.end method

.method public getMethodOrBuilder(I)Lcom/google/protobuf/DescriptorProtos$MethodDescriptorProtoOrBuilder;
    .locals 1

    .prologue
    .line 7839
    iget-object v0, p0, Lcom/google/protobuf/DescriptorProtos$ServiceDescriptorProto;->method_:Ljava/util/List;

    invoke-interface {v0, p1}, Ljava/util/List;->get(I)Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Lcom/google/protobuf/DescriptorProtos$MethodDescriptorProtoOrBuilder;

    return-object v0
.end method

.method public getMethodOrBuilderList()Ljava/util/List;
    .locals 1
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "()",
            "Ljava/util/List",
            "<+",
            "Lcom/google/protobuf/DescriptorProtos$MethodDescriptorProtoOrBuilder;",
            ">;"
        }
    .end annotation

    .prologue
    .line 7829
    iget-object v0, p0, Lcom/google/protobuf/DescriptorProtos$ServiceDescriptorProto;->method_:Ljava/util/List;

    return-object v0
.end method

.method public getName()Ljava/lang/String;
    .locals 2

    .prologue
    .line 7796
    iget-object v0, p0, Lcom/google/protobuf/DescriptorProtos$ServiceDescriptorProto;->name_:Ljava/lang/Object;

    .line 7797
    instance-of v1, v0, Ljava/lang/String;

    if-eqz v1, :cond_0

    .line 7798
    check-cast v0, Ljava/lang/String;

    .line 7806
    :goto_0
    return-object v0

    .line 7801
    :cond_0
    check-cast v0, Lcom/google/protobuf/ByteString;

    .line 7802
    invoke-virtual {v0}, Lcom/google/protobuf/ByteString;->toStringUtf8()Ljava/lang/String;

    move-result-object v1

    .line 7803
    invoke-static {v0}, Lcom/google/protobuf/Internal;->isValidUtf8(Lcom/google/protobuf/ByteString;)Z

    move-result v0

    if-eqz v0, :cond_1

    .line 7804
    iput-object v1, p0, Lcom/google/protobuf/DescriptorProtos$ServiceDescriptorProto;->name_:Ljava/lang/Object;

    :cond_1
    move-object v0, v1

    .line 7806
    goto :goto_0
.end method

.method public getOptions()Lcom/google/protobuf/DescriptorProtos$ServiceOptions;
    .locals 1

    .prologue
    .line 7849
    iget-object v0, p0, Lcom/google/protobuf/DescriptorProtos$ServiceDescriptorProto;->options_:Lcom/google/protobuf/DescriptorProtos$ServiceOptions;

    return-object v0
.end method

.method public getOptionsOrBuilder()Lcom/google/protobuf/DescriptorProtos$ServiceOptionsOrBuilder;
    .locals 1

    .prologue
    .line 7852
    iget-object v0, p0, Lcom/google/protobuf/DescriptorProtos$ServiceDescriptorProto;->options_:Lcom/google/protobuf/DescriptorProtos$ServiceOptions;

    return-object v0
.end method

.method public getSerializedSize()I
    .locals 5

    .prologue
    const/4 v4, 0x2

    const/4 v3, 0x1

    const/4 v1, 0x0

    .line 7898
    iget v0, p0, Lcom/google/protobuf/DescriptorProtos$ServiceDescriptorProto;->memoizedSerializedSize:I

    .line 7899
    const/4 v2, -0x1

    if-eq v0, v2, :cond_0

    .line 7916
    :goto_0
    return v0

    .line 7902
    :cond_0
    iget v0, p0, Lcom/google/protobuf/DescriptorProtos$ServiceDescriptorProto;->bitField0_:I

    and-int/lit8 v0, v0, 0x1

    if-ne v0, v3, :cond_3

    .line 7904
    invoke-direct {p0}, Lcom/google/protobuf/DescriptorProtos$ServiceDescriptorProto;->getNameBytes()Lcom/google/protobuf/ByteString;

    move-result-object v0

    invoke-static {v3, v0}, Lcom/google/protobuf/CodedOutputStream;->computeBytesSize(ILcom/google/protobuf/ByteString;)I

    move-result v0

    add-int/2addr v0, v1

    :goto_1
    move v2, v0

    .line 7906
    :goto_2
    iget-object v0, p0, Lcom/google/protobuf/DescriptorProtos$ServiceDescriptorProto;->method_:Ljava/util/List;

    invoke-interface {v0}, Ljava/util/List;->size()I

    move-result v0

    if-lt v1, v0, :cond_2

    .line 7910
    iget v0, p0, Lcom/google/protobuf/DescriptorProtos$ServiceDescriptorProto;->bitField0_:I

    and-int/lit8 v0, v0, 0x2

    if-ne v0, v4, :cond_1

    .line 7912
    const/4 v0, 0x3

    iget-object v1, p0, Lcom/google/protobuf/DescriptorProtos$ServiceDescriptorProto;->options_:Lcom/google/protobuf/DescriptorProtos$ServiceOptions;

    invoke-static {v0, v1}, Lcom/google/protobuf/CodedOutputStream;->computeMessageSize(ILcom/google/protobuf/MessageLite;)I

    move-result v0

    add-int/2addr v2, v0

    .line 7914
    :cond_1
    invoke-virtual {p0}, Lcom/google/protobuf/DescriptorProtos$ServiceDescriptorProto;->getUnknownFields()Lcom/google/protobuf/UnknownFieldSet;

    move-result-object v0

    invoke-virtual {v0}, Lcom/google/protobuf/UnknownFieldSet;->getSerializedSize()I

    move-result v0

    add-int/2addr v0, v2

    .line 7915
    iput v0, p0, Lcom/google/protobuf/DescriptorProtos$ServiceDescriptorProto;->memoizedSerializedSize:I

    goto :goto_0

    .line 7908
    :cond_2
    iget-object v0, p0, Lcom/google/protobuf/DescriptorProtos$ServiceDescriptorProto;->method_:Ljava/util/List;

    invoke-interface {v0, v1}, Ljava/util/List;->get(I)Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Lcom/google/protobuf/MessageLite;

    invoke-static {v4, v0}, Lcom/google/protobuf/CodedOutputStream;->computeMessageSize(ILcom/google/protobuf/MessageLite;)I

    move-result v0

    add-int/2addr v0, v2

    .line 7906
    add-int/lit8 v1, v1, 0x1

    move v2, v0

    goto :goto_2

    :cond_3
    move v0, v1

    goto :goto_1
.end method

.method public hasName()Z
    .locals 2

    .prologue
    const/4 v0, 0x1

    .line 7793
    iget v1, p0, Lcom/google/protobuf/DescriptorProtos$ServiceDescriptorProto;->bitField0_:I

    and-int/lit8 v1, v1, 0x1

    if-ne v1, v0, :cond_0

    :goto_0
    return v0

    :cond_0
    const/4 v0, 0x0

    goto :goto_0
.end method

.method public hasOptions()Z
    .locals 2

    .prologue
    .line 7846
    iget v0, p0, Lcom/google/protobuf/DescriptorProtos$ServiceDescriptorProto;->bitField0_:I

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
    .locals 1

    .prologue
    .line 7785
    invoke-static {}, Lcom/google/protobuf/DescriptorProtos;->access$68()Lcom/google/protobuf/GeneratedMessage$FieldAccessorTable;

    move-result-object v0

    return-object v0
.end method

.method public final isInitialized()Z
    .locals 4

    .prologue
    const/4 v2, 0x1

    const/4 v1, 0x0

    .line 7862
    iget-byte v0, p0, Lcom/google/protobuf/DescriptorProtos$ServiceDescriptorProto;->memoizedIsInitialized:B

    .line 7863
    const/4 v3, -0x1

    if-eq v0, v3, :cond_1

    if-ne v0, v2, :cond_0

    move v1, v2

    .line 7878
    :cond_0
    :goto_0
    return v1

    :cond_1
    move v0, v1

    .line 7865
    :goto_1
    invoke-virtual {p0}, Lcom/google/protobuf/DescriptorProtos$ServiceDescriptorProto;->getMethodCount()I

    move-result v3

    if-lt v0, v3, :cond_2

    .line 7871
    invoke-virtual {p0}, Lcom/google/protobuf/DescriptorProtos$ServiceDescriptorProto;->hasOptions()Z

    move-result v0

    if-eqz v0, :cond_4

    .line 7872
    invoke-virtual {p0}, Lcom/google/protobuf/DescriptorProtos$ServiceDescriptorProto;->getOptions()Lcom/google/protobuf/DescriptorProtos$ServiceOptions;

    move-result-object v0

    invoke-virtual {v0}, Lcom/google/protobuf/DescriptorProtos$ServiceOptions;->isInitialized()Z

    move-result v0

    if-nez v0, :cond_4

    .line 7873
    iput-byte v1, p0, Lcom/google/protobuf/DescriptorProtos$ServiceDescriptorProto;->memoizedIsInitialized:B

    goto :goto_0

    .line 7866
    :cond_2
    invoke-virtual {p0, v0}, Lcom/google/protobuf/DescriptorProtos$ServiceDescriptorProto;->getMethod(I)Lcom/google/protobuf/DescriptorProtos$MethodDescriptorProto;

    move-result-object v3

    invoke-virtual {v3}, Lcom/google/protobuf/DescriptorProtos$MethodDescriptorProto;->isInitialized()Z

    move-result v3

    if-nez v3, :cond_3

    .line 7867
    iput-byte v1, p0, Lcom/google/protobuf/DescriptorProtos$ServiceDescriptorProto;->memoizedIsInitialized:B

    goto :goto_0

    .line 7865
    :cond_3
    add-int/lit8 v0, v0, 0x1

    goto :goto_1

    .line 7877
    :cond_4
    iput-byte v2, p0, Lcom/google/protobuf/DescriptorProtos$ServiceDescriptorProto;->memoizedIsInitialized:B

    move v1, v2

    .line 7878
    goto :goto_0
.end method

.method public newBuilderForType()Lcom/google/protobuf/DescriptorProtos$ServiceDescriptorProto$Builder;
    .locals 1

    .prologue
    .line 7994
    invoke-static {}, Lcom/google/protobuf/DescriptorProtos$ServiceDescriptorProto;->newBuilder()Lcom/google/protobuf/DescriptorProtos$ServiceDescriptorProto$Builder;

    move-result-object v0

    return-object v0
.end method

.method protected newBuilderForType(Lcom/google/protobuf/GeneratedMessage$BuilderParent;)Lcom/google/protobuf/DescriptorProtos$ServiceDescriptorProto$Builder;
    .locals 2

    .prologue
    .line 8003
    new-instance v0, Lcom/google/protobuf/DescriptorProtos$ServiceDescriptorProto$Builder;

    const/4 v1, 0x0

    invoke-direct {v0, p1, v1}, Lcom/google/protobuf/DescriptorProtos$ServiceDescriptorProto$Builder;-><init>(Lcom/google/protobuf/GeneratedMessage$BuilderParent;Lcom/google/protobuf/DescriptorProtos$ServiceDescriptorProto$Builder;)V

    .line 8004
    return-object v0
.end method

.method public bridge synthetic newBuilderForType()Lcom/google/protobuf/Message$Builder;
    .locals 1

    .prologue
    .line 1
    invoke-virtual {p0}, Lcom/google/protobuf/DescriptorProtos$ServiceDescriptorProto;->newBuilderForType()Lcom/google/protobuf/DescriptorProtos$ServiceDescriptorProto$Builder;

    move-result-object v0

    return-object v0
.end method

.method protected bridge synthetic newBuilderForType(Lcom/google/protobuf/GeneratedMessage$BuilderParent;)Lcom/google/protobuf/Message$Builder;
    .locals 1

    .prologue
    .line 1
    invoke-virtual {p0, p1}, Lcom/google/protobuf/DescriptorProtos$ServiceDescriptorProto;->newBuilderForType(Lcom/google/protobuf/GeneratedMessage$BuilderParent;)Lcom/google/protobuf/DescriptorProtos$ServiceDescriptorProto$Builder;

    move-result-object v0

    return-object v0
.end method

.method public bridge synthetic newBuilderForType()Lcom/google/protobuf/MessageLite$Builder;
    .locals 1

    .prologue
    .line 1
    invoke-virtual {p0}, Lcom/google/protobuf/DescriptorProtos$ServiceDescriptorProto;->newBuilderForType()Lcom/google/protobuf/DescriptorProtos$ServiceDescriptorProto$Builder;

    move-result-object v0

    return-object v0
.end method

.method public toBuilder()Lcom/google/protobuf/DescriptorProtos$ServiceDescriptorProto$Builder;
    .locals 1

    .prologue
    .line 7998
    invoke-static {p0}, Lcom/google/protobuf/DescriptorProtos$ServiceDescriptorProto;->newBuilder(Lcom/google/protobuf/DescriptorProtos$ServiceDescriptorProto;)Lcom/google/protobuf/DescriptorProtos$ServiceDescriptorProto$Builder;

    move-result-object v0

    return-object v0
.end method

.method public bridge synthetic toBuilder()Lcom/google/protobuf/Message$Builder;
    .locals 1

    .prologue
    .line 1
    invoke-virtual {p0}, Lcom/google/protobuf/DescriptorProtos$ServiceDescriptorProto;->toBuilder()Lcom/google/protobuf/DescriptorProtos$ServiceDescriptorProto$Builder;

    move-result-object v0

    return-object v0
.end method

.method public bridge synthetic toBuilder()Lcom/google/protobuf/MessageLite$Builder;
    .locals 1

    .prologue
    .line 1
    invoke-virtual {p0}, Lcom/google/protobuf/DescriptorProtos$ServiceDescriptorProto;->toBuilder()Lcom/google/protobuf/DescriptorProtos$ServiceDescriptorProto$Builder;

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
    .line 7923
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

    .line 7883
    invoke-virtual {p0}, Lcom/google/protobuf/DescriptorProtos$ServiceDescriptorProto;->getSerializedSize()I

    .line 7884
    iget v0, p0, Lcom/google/protobuf/DescriptorProtos$ServiceDescriptorProto;->bitField0_:I

    and-int/lit8 v0, v0, 0x1

    if-ne v0, v1, :cond_0

    .line 7885
    invoke-direct {p0}, Lcom/google/protobuf/DescriptorProtos$ServiceDescriptorProto;->getNameBytes()Lcom/google/protobuf/ByteString;

    move-result-object v0

    invoke-virtual {p1, v1, v0}, Lcom/google/protobuf/CodedOutputStream;->writeBytes(ILcom/google/protobuf/ByteString;)V

    .line 7887
    :cond_0
    const/4 v0, 0x0

    move v1, v0

    :goto_0
    iget-object v0, p0, Lcom/google/protobuf/DescriptorProtos$ServiceDescriptorProto;->method_:Ljava/util/List;

    invoke-interface {v0}, Ljava/util/List;->size()I

    move-result v0

    if-lt v1, v0, :cond_2

    .line 7890
    iget v0, p0, Lcom/google/protobuf/DescriptorProtos$ServiceDescriptorProto;->bitField0_:I

    and-int/lit8 v0, v0, 0x2

    if-ne v0, v2, :cond_1

    .line 7891
    const/4 v0, 0x3

    iget-object v1, p0, Lcom/google/protobuf/DescriptorProtos$ServiceDescriptorProto;->options_:Lcom/google/protobuf/DescriptorProtos$ServiceOptions;

    invoke-virtual {p1, v0, v1}, Lcom/google/protobuf/CodedOutputStream;->writeMessage(ILcom/google/protobuf/MessageLite;)V

    .line 7893
    :cond_1
    invoke-virtual {p0}, Lcom/google/protobuf/DescriptorProtos$ServiceDescriptorProto;->getUnknownFields()Lcom/google/protobuf/UnknownFieldSet;

    move-result-object v0

    invoke-virtual {v0, p1}, Lcom/google/protobuf/UnknownFieldSet;->writeTo(Lcom/google/protobuf/CodedOutputStream;)V

    .line 7894
    return-void

    .line 7888
    :cond_2
    iget-object v0, p0, Lcom/google/protobuf/DescriptorProtos$ServiceDescriptorProto;->method_:Ljava/util/List;

    invoke-interface {v0, v1}, Ljava/util/List;->get(I)Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Lcom/google/protobuf/MessageLite;

    invoke-virtual {p1, v2, v0}, Lcom/google/protobuf/CodedOutputStream;->writeMessage(ILcom/google/protobuf/MessageLite;)V

    .line 7887
    add-int/lit8 v0, v1, 0x1

    move v1, v0

    goto :goto_0
.end method
