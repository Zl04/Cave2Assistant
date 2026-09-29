.class public final Lcom/google/protobuf/DescriptorProtos$MethodDescriptorProto;
.super Lcom/google/protobuf/GeneratedMessage;
.source "SourceFile"

# interfaces
.implements Lcom/google/protobuf/DescriptorProtos$MethodDescriptorProtoOrBuilder;


# annotations
.annotation system Ldalvik/annotation/EnclosingClass;
    value = Lcom/google/protobuf/DescriptorProtos;
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x19
    name = "MethodDescriptorProto"
.end annotation

.annotation system Ldalvik/annotation/MemberClasses;
    value = {
        Lcom/google/protobuf/DescriptorProtos$MethodDescriptorProto$Builder;
    }
.end annotation


# static fields
.field public static final INPUT_TYPE_FIELD_NUMBER:I = 0x2

.field public static final NAME_FIELD_NUMBER:I = 0x1

.field public static final OPTIONS_FIELD_NUMBER:I = 0x4

.field public static final OUTPUT_TYPE_FIELD_NUMBER:I = 0x3

.field private static final defaultInstance:Lcom/google/protobuf/DescriptorProtos$MethodDescriptorProto;

.field private static final serialVersionUID:J


# instance fields
.field private bitField0_:I

.field private inputType_:Ljava/lang/Object;

.field private memoizedIsInitialized:B

.field private memoizedSerializedSize:I

.field private name_:Ljava/lang/Object;

.field private options_:Lcom/google/protobuf/DescriptorProtos$MethodOptions;

.field private outputType_:Ljava/lang/Object;


# direct methods
.method static constructor <clinit>()V
    .locals 2

    .prologue
    .line 9264
    new-instance v0, Lcom/google/protobuf/DescriptorProtos$MethodDescriptorProto;

    const/4 v1, 0x1

    invoke-direct {v0, v1}, Lcom/google/protobuf/DescriptorProtos$MethodDescriptorProto;-><init>(Z)V

    sput-object v0, Lcom/google/protobuf/DescriptorProtos$MethodDescriptorProto;->defaultInstance:Lcom/google/protobuf/DescriptorProtos$MethodDescriptorProto;

    .line 9265
    sget-object v0, Lcom/google/protobuf/DescriptorProtos$MethodDescriptorProto;->defaultInstance:Lcom/google/protobuf/DescriptorProtos$MethodDescriptorProto;

    invoke-direct {v0}, Lcom/google/protobuf/DescriptorProtos$MethodDescriptorProto;->initFields()V

    .line 8573
    return-void
.end method

.method private constructor <init>(Lcom/google/protobuf/DescriptorProtos$MethodDescriptorProto$Builder;)V
    .locals 1

    .prologue
    const/4 v0, -0x1

    .line 8578
    invoke-direct {p0, p1}, Lcom/google/protobuf/GeneratedMessage;-><init>(Lcom/google/protobuf/GeneratedMessage$Builder;)V

    .line 8717
    iput-byte v0, p0, Lcom/google/protobuf/DescriptorProtos$MethodDescriptorProto;->memoizedIsInitialized:B

    .line 8750
    iput v0, p0, Lcom/google/protobuf/DescriptorProtos$MethodDescriptorProto;->memoizedSerializedSize:I

    .line 8579
    return-void
.end method

.method synthetic constructor <init>(Lcom/google/protobuf/DescriptorProtos$MethodDescriptorProto$Builder;Lcom/google/protobuf/DescriptorProtos$MethodDescriptorProto;)V
    .locals 0

    .prologue
    .line 8577
    invoke-direct {p0, p1}, Lcom/google/protobuf/DescriptorProtos$MethodDescriptorProto;-><init>(Lcom/google/protobuf/DescriptorProtos$MethodDescriptorProto$Builder;)V

    return-void
.end method

.method private constructor <init>(Z)V
    .locals 1

    .prologue
    const/4 v0, -0x1

    .line 8580
    invoke-direct {p0}, Lcom/google/protobuf/GeneratedMessage;-><init>()V

    .line 8717
    iput-byte v0, p0, Lcom/google/protobuf/DescriptorProtos$MethodDescriptorProto;->memoizedIsInitialized:B

    .line 8750
    iput v0, p0, Lcom/google/protobuf/DescriptorProtos$MethodDescriptorProto;->memoizedSerializedSize:I

    .line 8580
    return-void
.end method

.method static synthetic access$10(Lcom/google/protobuf/DescriptorProtos$MethodDescriptorProto;Ljava/lang/Object;)V
    .locals 0

    .prologue
    .line 8668
    iput-object p1, p0, Lcom/google/protobuf/DescriptorProtos$MethodDescriptorProto;->outputType_:Ljava/lang/Object;

    return-void
.end method

.method static synthetic access$11(Lcom/google/protobuf/DescriptorProtos$MethodDescriptorProto;Lcom/google/protobuf/DescriptorProtos$MethodOptions;)V
    .locals 0

    .prologue
    .line 8700
    iput-object p1, p0, Lcom/google/protobuf/DescriptorProtos$MethodDescriptorProto;->options_:Lcom/google/protobuf/DescriptorProtos$MethodOptions;

    return-void
.end method

.method static synthetic access$12(Lcom/google/protobuf/DescriptorProtos$MethodDescriptorProto;I)V
    .locals 0

    .prologue
    .line 8601
    iput p1, p0, Lcom/google/protobuf/DescriptorProtos$MethodDescriptorProto;->bitField0_:I

    return-void
.end method

.method static synthetic access$8(Lcom/google/protobuf/DescriptorProtos$MethodDescriptorProto;Ljava/lang/Object;)V
    .locals 0

    .prologue
    .line 8604
    iput-object p1, p0, Lcom/google/protobuf/DescriptorProtos$MethodDescriptorProto;->name_:Ljava/lang/Object;

    return-void
.end method

.method static synthetic access$9(Lcom/google/protobuf/DescriptorProtos$MethodDescriptorProto;Ljava/lang/Object;)V
    .locals 0

    .prologue
    .line 8636
    iput-object p1, p0, Lcom/google/protobuf/DescriptorProtos$MethodDescriptorProto;->inputType_:Ljava/lang/Object;

    return-void
.end method

.method public static getDefaultInstance()Lcom/google/protobuf/DescriptorProtos$MethodDescriptorProto;
    .locals 1

    .prologue
    .line 8584
    sget-object v0, Lcom/google/protobuf/DescriptorProtos$MethodDescriptorProto;->defaultInstance:Lcom/google/protobuf/DescriptorProtos$MethodDescriptorProto;

    return-object v0
.end method

.method public static final getDescriptor()Lcom/google/protobuf/Descriptors$Descriptor;
    .locals 1

    .prologue
    .line 8593
    invoke-static {}, Lcom/google/protobuf/DescriptorProtos;->access$26()Lcom/google/protobuf/Descriptors$Descriptor;

    move-result-object v0

    return-object v0
.end method

.method private getInputTypeBytes()Lcom/google/protobuf/ByteString;
    .locals 2

    .prologue
    .line 8655
    iget-object v0, p0, Lcom/google/protobuf/DescriptorProtos$MethodDescriptorProto;->inputType_:Ljava/lang/Object;

    .line 8656
    instance-of v1, v0, Ljava/lang/String;

    if-eqz v1, :cond_0

    .line 8658
    check-cast v0, Ljava/lang/String;

    invoke-static {v0}, Lcom/google/protobuf/ByteString;->copyFromUtf8(Ljava/lang/String;)Lcom/google/protobuf/ByteString;

    move-result-object v0

    .line 8659
    iput-object v0, p0, Lcom/google/protobuf/DescriptorProtos$MethodDescriptorProto;->inputType_:Ljava/lang/Object;

    .line 8662
    :goto_0
    return-object v0

    :cond_0
    check-cast v0, Lcom/google/protobuf/ByteString;

    goto :goto_0
.end method

.method private getNameBytes()Lcom/google/protobuf/ByteString;
    .locals 2

    .prologue
    .line 8623
    iget-object v0, p0, Lcom/google/protobuf/DescriptorProtos$MethodDescriptorProto;->name_:Ljava/lang/Object;

    .line 8624
    instance-of v1, v0, Ljava/lang/String;

    if-eqz v1, :cond_0

    .line 8626
    check-cast v0, Ljava/lang/String;

    invoke-static {v0}, Lcom/google/protobuf/ByteString;->copyFromUtf8(Ljava/lang/String;)Lcom/google/protobuf/ByteString;

    move-result-object v0

    .line 8627
    iput-object v0, p0, Lcom/google/protobuf/DescriptorProtos$MethodDescriptorProto;->name_:Ljava/lang/Object;

    .line 8630
    :goto_0
    return-object v0

    :cond_0
    check-cast v0, Lcom/google/protobuf/ByteString;

    goto :goto_0
.end method

.method private getOutputTypeBytes()Lcom/google/protobuf/ByteString;
    .locals 2

    .prologue
    .line 8687
    iget-object v0, p0, Lcom/google/protobuf/DescriptorProtos$MethodDescriptorProto;->outputType_:Ljava/lang/Object;

    .line 8688
    instance-of v1, v0, Ljava/lang/String;

    if-eqz v1, :cond_0

    .line 8690
    check-cast v0, Ljava/lang/String;

    invoke-static {v0}, Lcom/google/protobuf/ByteString;->copyFromUtf8(Ljava/lang/String;)Lcom/google/protobuf/ByteString;

    move-result-object v0

    .line 8691
    iput-object v0, p0, Lcom/google/protobuf/DescriptorProtos$MethodDescriptorProto;->outputType_:Ljava/lang/Object;

    .line 8694
    :goto_0
    return-object v0

    :cond_0
    check-cast v0, Lcom/google/protobuf/ByteString;

    goto :goto_0
.end method

.method private initFields()V
    .locals 1

    .prologue
    .line 8712
    const-string v0, ""

    iput-object v0, p0, Lcom/google/protobuf/DescriptorProtos$MethodDescriptorProto;->name_:Ljava/lang/Object;

    .line 8713
    const-string v0, ""

    iput-object v0, p0, Lcom/google/protobuf/DescriptorProtos$MethodDescriptorProto;->inputType_:Ljava/lang/Object;

    .line 8714
    const-string v0, ""

    iput-object v0, p0, Lcom/google/protobuf/DescriptorProtos$MethodDescriptorProto;->outputType_:Ljava/lang/Object;

    .line 8715
    invoke-static {}, Lcom/google/protobuf/DescriptorProtos$MethodOptions;->getDefaultInstance()Lcom/google/protobuf/DescriptorProtos$MethodOptions;

    move-result-object v0

    iput-object v0, p0, Lcom/google/protobuf/DescriptorProtos$MethodDescriptorProto;->options_:Lcom/google/protobuf/DescriptorProtos$MethodOptions;

    .line 8716
    return-void
.end method

.method public static newBuilder()Lcom/google/protobuf/DescriptorProtos$MethodDescriptorProto$Builder;
    .locals 1

    .prologue
    .line 8851
    invoke-static {}, Lcom/google/protobuf/DescriptorProtos$MethodDescriptorProto$Builder;->access$18()Lcom/google/protobuf/DescriptorProtos$MethodDescriptorProto$Builder;

    move-result-object v0

    return-object v0
.end method

.method public static newBuilder(Lcom/google/protobuf/DescriptorProtos$MethodDescriptorProto;)Lcom/google/protobuf/DescriptorProtos$MethodDescriptorProto$Builder;
    .locals 1

    .prologue
    .line 8854
    invoke-static {}, Lcom/google/protobuf/DescriptorProtos$MethodDescriptorProto;->newBuilder()Lcom/google/protobuf/DescriptorProtos$MethodDescriptorProto$Builder;

    move-result-object v0

    invoke-virtual {v0, p0}, Lcom/google/protobuf/DescriptorProtos$MethodDescriptorProto$Builder;->mergeFrom(Lcom/google/protobuf/DescriptorProtos$MethodDescriptorProto;)Lcom/google/protobuf/DescriptorProtos$MethodDescriptorProto$Builder;

    move-result-object v0

    return-object v0
.end method

.method public static parseDelimitedFrom(Ljava/io/InputStream;)Lcom/google/protobuf/DescriptorProtos$MethodDescriptorProto;
    .locals 2
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljava/io/IOException;
        }
    .end annotation

    .prologue
    .line 8820
    invoke-static {}, Lcom/google/protobuf/DescriptorProtos$MethodDescriptorProto;->newBuilder()Lcom/google/protobuf/DescriptorProtos$MethodDescriptorProto$Builder;

    move-result-object v0

    .line 8821
    invoke-virtual {v0, p0}, Lcom/google/protobuf/DescriptorProtos$MethodDescriptorProto$Builder;->mergeDelimitedFrom(Ljava/io/InputStream;)Z

    move-result v1

    if-eqz v1, :cond_0

    .line 8822
    invoke-static {v0}, Lcom/google/protobuf/DescriptorProtos$MethodDescriptorProto$Builder;->access$17(Lcom/google/protobuf/DescriptorProtos$MethodDescriptorProto$Builder;)Lcom/google/protobuf/DescriptorProtos$MethodDescriptorProto;

    move-result-object v0

    .line 8824
    :goto_0
    return-object v0

    :cond_0
    const/4 v0, 0x0

    goto :goto_0
.end method

.method public static parseDelimitedFrom(Ljava/io/InputStream;Lcom/google/protobuf/ExtensionRegistryLite;)Lcom/google/protobuf/DescriptorProtos$MethodDescriptorProto;
    .locals 2
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljava/io/IOException;
        }
    .end annotation

    .prologue
    .line 8831
    invoke-static {}, Lcom/google/protobuf/DescriptorProtos$MethodDescriptorProto;->newBuilder()Lcom/google/protobuf/DescriptorProtos$MethodDescriptorProto$Builder;

    move-result-object v0

    .line 8832
    invoke-virtual {v0, p0, p1}, Lcom/google/protobuf/DescriptorProtos$MethodDescriptorProto$Builder;->mergeDelimitedFrom(Ljava/io/InputStream;Lcom/google/protobuf/ExtensionRegistryLite;)Z

    move-result v1

    if-eqz v1, :cond_0

    .line 8833
    invoke-static {v0}, Lcom/google/protobuf/DescriptorProtos$MethodDescriptorProto$Builder;->access$17(Lcom/google/protobuf/DescriptorProtos$MethodDescriptorProto$Builder;)Lcom/google/protobuf/DescriptorProtos$MethodDescriptorProto;

    move-result-object v0

    .line 8835
    :goto_0
    return-object v0

    :cond_0
    const/4 v0, 0x0

    goto :goto_0
.end method

.method public static parseFrom(Lcom/google/protobuf/ByteString;)Lcom/google/protobuf/DescriptorProtos$MethodDescriptorProto;
    .locals 1
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Lcom/google/protobuf/InvalidProtocolBufferException;
        }
    .end annotation

    .prologue
    .line 8787
    invoke-static {}, Lcom/google/protobuf/DescriptorProtos$MethodDescriptorProto;->newBuilder()Lcom/google/protobuf/DescriptorProtos$MethodDescriptorProto$Builder;

    move-result-object v0

    invoke-virtual {v0, p0}, Lcom/google/protobuf/DescriptorProtos$MethodDescriptorProto$Builder;->mergeFrom(Lcom/google/protobuf/ByteString;)Lcom/google/protobuf/AbstractMessage$Builder;

    move-result-object v0

    check-cast v0, Lcom/google/protobuf/DescriptorProtos$MethodDescriptorProto$Builder;

    invoke-static {v0}, Lcom/google/protobuf/DescriptorProtos$MethodDescriptorProto$Builder;->access$17(Lcom/google/protobuf/DescriptorProtos$MethodDescriptorProto$Builder;)Lcom/google/protobuf/DescriptorProtos$MethodDescriptorProto;

    move-result-object v0

    return-object v0
.end method

.method public static parseFrom(Lcom/google/protobuf/ByteString;Lcom/google/protobuf/ExtensionRegistryLite;)Lcom/google/protobuf/DescriptorProtos$MethodDescriptorProto;
    .locals 1
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Lcom/google/protobuf/InvalidProtocolBufferException;
        }
    .end annotation

    .prologue
    .line 8793
    invoke-static {}, Lcom/google/protobuf/DescriptorProtos$MethodDescriptorProto;->newBuilder()Lcom/google/protobuf/DescriptorProtos$MethodDescriptorProto$Builder;

    move-result-object v0

    invoke-virtual {v0, p0, p1}, Lcom/google/protobuf/DescriptorProtos$MethodDescriptorProto$Builder;->mergeFrom(Lcom/google/protobuf/ByteString;Lcom/google/protobuf/ExtensionRegistryLite;)Lcom/google/protobuf/AbstractMessage$Builder;

    move-result-object v0

    check-cast v0, Lcom/google/protobuf/DescriptorProtos$MethodDescriptorProto$Builder;

    .line 8794
    invoke-static {v0}, Lcom/google/protobuf/DescriptorProtos$MethodDescriptorProto$Builder;->access$17(Lcom/google/protobuf/DescriptorProtos$MethodDescriptorProto$Builder;)Lcom/google/protobuf/DescriptorProtos$MethodDescriptorProto;

    move-result-object v0

    .line 8793
    return-object v0
.end method

.method public static parseFrom(Lcom/google/protobuf/CodedInputStream;)Lcom/google/protobuf/DescriptorProtos$MethodDescriptorProto;
    .locals 1
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljava/io/IOException;
        }
    .end annotation

    .prologue
    .line 8841
    invoke-static {}, Lcom/google/protobuf/DescriptorProtos$MethodDescriptorProto;->newBuilder()Lcom/google/protobuf/DescriptorProtos$MethodDescriptorProto$Builder;

    move-result-object v0

    invoke-virtual {v0, p0}, Lcom/google/protobuf/DescriptorProtos$MethodDescriptorProto$Builder;->mergeFrom(Lcom/google/protobuf/CodedInputStream;)Lcom/google/protobuf/AbstractMessage$Builder;

    move-result-object v0

    check-cast v0, Lcom/google/protobuf/DescriptorProtos$MethodDescriptorProto$Builder;

    invoke-static {v0}, Lcom/google/protobuf/DescriptorProtos$MethodDescriptorProto$Builder;->access$17(Lcom/google/protobuf/DescriptorProtos$MethodDescriptorProto$Builder;)Lcom/google/protobuf/DescriptorProtos$MethodDescriptorProto;

    move-result-object v0

    return-object v0
.end method

.method public static parseFrom(Lcom/google/protobuf/CodedInputStream;Lcom/google/protobuf/ExtensionRegistryLite;)Lcom/google/protobuf/DescriptorProtos$MethodDescriptorProto;
    .locals 1
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljava/io/IOException;
        }
    .end annotation

    .prologue
    .line 8847
    invoke-static {}, Lcom/google/protobuf/DescriptorProtos$MethodDescriptorProto;->newBuilder()Lcom/google/protobuf/DescriptorProtos$MethodDescriptorProto$Builder;

    move-result-object v0

    invoke-virtual {v0, p0, p1}, Lcom/google/protobuf/DescriptorProtos$MethodDescriptorProto$Builder;->mergeFrom(Lcom/google/protobuf/CodedInputStream;Lcom/google/protobuf/ExtensionRegistryLite;)Lcom/google/protobuf/DescriptorProtos$MethodDescriptorProto$Builder;

    move-result-object v0

    .line 8848
    invoke-static {v0}, Lcom/google/protobuf/DescriptorProtos$MethodDescriptorProto$Builder;->access$17(Lcom/google/protobuf/DescriptorProtos$MethodDescriptorProto$Builder;)Lcom/google/protobuf/DescriptorProtos$MethodDescriptorProto;

    move-result-object v0

    .line 8847
    return-object v0
.end method

.method public static parseFrom(Ljava/io/InputStream;)Lcom/google/protobuf/DescriptorProtos$MethodDescriptorProto;
    .locals 1
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljava/io/IOException;
        }
    .end annotation

    .prologue
    .line 8809
    invoke-static {}, Lcom/google/protobuf/DescriptorProtos$MethodDescriptorProto;->newBuilder()Lcom/google/protobuf/DescriptorProtos$MethodDescriptorProto$Builder;

    move-result-object v0

    invoke-virtual {v0, p0}, Lcom/google/protobuf/DescriptorProtos$MethodDescriptorProto$Builder;->mergeFrom(Ljava/io/InputStream;)Lcom/google/protobuf/AbstractMessage$Builder;

    move-result-object v0

    check-cast v0, Lcom/google/protobuf/DescriptorProtos$MethodDescriptorProto$Builder;

    invoke-static {v0}, Lcom/google/protobuf/DescriptorProtos$MethodDescriptorProto$Builder;->access$17(Lcom/google/protobuf/DescriptorProtos$MethodDescriptorProto$Builder;)Lcom/google/protobuf/DescriptorProtos$MethodDescriptorProto;

    move-result-object v0

    return-object v0
.end method

.method public static parseFrom(Ljava/io/InputStream;Lcom/google/protobuf/ExtensionRegistryLite;)Lcom/google/protobuf/DescriptorProtos$MethodDescriptorProto;
    .locals 1
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljava/io/IOException;
        }
    .end annotation

    .prologue
    .line 8815
    invoke-static {}, Lcom/google/protobuf/DescriptorProtos$MethodDescriptorProto;->newBuilder()Lcom/google/protobuf/DescriptorProtos$MethodDescriptorProto$Builder;

    move-result-object v0

    invoke-virtual {v0, p0, p1}, Lcom/google/protobuf/DescriptorProtos$MethodDescriptorProto$Builder;->mergeFrom(Ljava/io/InputStream;Lcom/google/protobuf/ExtensionRegistryLite;)Lcom/google/protobuf/AbstractMessage$Builder;

    move-result-object v0

    check-cast v0, Lcom/google/protobuf/DescriptorProtos$MethodDescriptorProto$Builder;

    .line 8816
    invoke-static {v0}, Lcom/google/protobuf/DescriptorProtos$MethodDescriptorProto$Builder;->access$17(Lcom/google/protobuf/DescriptorProtos$MethodDescriptorProto$Builder;)Lcom/google/protobuf/DescriptorProtos$MethodDescriptorProto;

    move-result-object v0

    .line 8815
    return-object v0
.end method

.method public static parseFrom([B)Lcom/google/protobuf/DescriptorProtos$MethodDescriptorProto;
    .locals 1
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Lcom/google/protobuf/InvalidProtocolBufferException;
        }
    .end annotation

    .prologue
    .line 8798
    invoke-static {}, Lcom/google/protobuf/DescriptorProtos$MethodDescriptorProto;->newBuilder()Lcom/google/protobuf/DescriptorProtos$MethodDescriptorProto$Builder;

    move-result-object v0

    invoke-virtual {v0, p0}, Lcom/google/protobuf/DescriptorProtos$MethodDescriptorProto$Builder;->mergeFrom([B)Lcom/google/protobuf/AbstractMessage$Builder;

    move-result-object v0

    check-cast v0, Lcom/google/protobuf/DescriptorProtos$MethodDescriptorProto$Builder;

    invoke-static {v0}, Lcom/google/protobuf/DescriptorProtos$MethodDescriptorProto$Builder;->access$17(Lcom/google/protobuf/DescriptorProtos$MethodDescriptorProto$Builder;)Lcom/google/protobuf/DescriptorProtos$MethodDescriptorProto;

    move-result-object v0

    return-object v0
.end method

.method public static parseFrom([BLcom/google/protobuf/ExtensionRegistryLite;)Lcom/google/protobuf/DescriptorProtos$MethodDescriptorProto;
    .locals 1
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Lcom/google/protobuf/InvalidProtocolBufferException;
        }
    .end annotation

    .prologue
    .line 8804
    invoke-static {}, Lcom/google/protobuf/DescriptorProtos$MethodDescriptorProto;->newBuilder()Lcom/google/protobuf/DescriptorProtos$MethodDescriptorProto$Builder;

    move-result-object v0

    invoke-virtual {v0, p0, p1}, Lcom/google/protobuf/DescriptorProtos$MethodDescriptorProto$Builder;->mergeFrom([BLcom/google/protobuf/ExtensionRegistryLite;)Lcom/google/protobuf/AbstractMessage$Builder;

    move-result-object v0

    check-cast v0, Lcom/google/protobuf/DescriptorProtos$MethodDescriptorProto$Builder;

    .line 8805
    invoke-static {v0}, Lcom/google/protobuf/DescriptorProtos$MethodDescriptorProto$Builder;->access$17(Lcom/google/protobuf/DescriptorProtos$MethodDescriptorProto$Builder;)Lcom/google/protobuf/DescriptorProtos$MethodDescriptorProto;

    move-result-object v0

    .line 8804
    return-object v0
.end method


# virtual methods
.method public getDefaultInstanceForType()Lcom/google/protobuf/DescriptorProtos$MethodDescriptorProto;
    .locals 1

    .prologue
    .line 8588
    sget-object v0, Lcom/google/protobuf/DescriptorProtos$MethodDescriptorProto;->defaultInstance:Lcom/google/protobuf/DescriptorProtos$MethodDescriptorProto;

    return-object v0
.end method

.method public bridge synthetic getDefaultInstanceForType()Lcom/google/protobuf/Message;
    .locals 1

    .prologue
    .line 1
    invoke-virtual {p0}, Lcom/google/protobuf/DescriptorProtos$MethodDescriptorProto;->getDefaultInstanceForType()Lcom/google/protobuf/DescriptorProtos$MethodDescriptorProto;

    move-result-object v0

    return-object v0
.end method

.method public bridge synthetic getDefaultInstanceForType()Lcom/google/protobuf/MessageLite;
    .locals 1

    .prologue
    .line 1
    invoke-virtual {p0}, Lcom/google/protobuf/DescriptorProtos$MethodDescriptorProto;->getDefaultInstanceForType()Lcom/google/protobuf/DescriptorProtos$MethodDescriptorProto;

    move-result-object v0

    return-object v0
.end method

.method public getInputType()Ljava/lang/String;
    .locals 2

    .prologue
    .line 8641
    iget-object v0, p0, Lcom/google/protobuf/DescriptorProtos$MethodDescriptorProto;->inputType_:Ljava/lang/Object;

    .line 8642
    instance-of v1, v0, Ljava/lang/String;

    if-eqz v1, :cond_0

    .line 8643
    check-cast v0, Ljava/lang/String;

    .line 8651
    :goto_0
    return-object v0

    .line 8646
    :cond_0
    check-cast v0, Lcom/google/protobuf/ByteString;

    .line 8647
    invoke-virtual {v0}, Lcom/google/protobuf/ByteString;->toStringUtf8()Ljava/lang/String;

    move-result-object v1

    .line 8648
    invoke-static {v0}, Lcom/google/protobuf/Internal;->isValidUtf8(Lcom/google/protobuf/ByteString;)Z

    move-result v0

    if-eqz v0, :cond_1

    .line 8649
    iput-object v1, p0, Lcom/google/protobuf/DescriptorProtos$MethodDescriptorProto;->inputType_:Ljava/lang/Object;

    :cond_1
    move-object v0, v1

    .line 8651
    goto :goto_0
.end method

.method public getName()Ljava/lang/String;
    .locals 2

    .prologue
    .line 8609
    iget-object v0, p0, Lcom/google/protobuf/DescriptorProtos$MethodDescriptorProto;->name_:Ljava/lang/Object;

    .line 8610
    instance-of v1, v0, Ljava/lang/String;

    if-eqz v1, :cond_0

    .line 8611
    check-cast v0, Ljava/lang/String;

    .line 8619
    :goto_0
    return-object v0

    .line 8614
    :cond_0
    check-cast v0, Lcom/google/protobuf/ByteString;

    .line 8615
    invoke-virtual {v0}, Lcom/google/protobuf/ByteString;->toStringUtf8()Ljava/lang/String;

    move-result-object v1

    .line 8616
    invoke-static {v0}, Lcom/google/protobuf/Internal;->isValidUtf8(Lcom/google/protobuf/ByteString;)Z

    move-result v0

    if-eqz v0, :cond_1

    .line 8617
    iput-object v1, p0, Lcom/google/protobuf/DescriptorProtos$MethodDescriptorProto;->name_:Ljava/lang/Object;

    :cond_1
    move-object v0, v1

    .line 8619
    goto :goto_0
.end method

.method public getOptions()Lcom/google/protobuf/DescriptorProtos$MethodOptions;
    .locals 1

    .prologue
    .line 8705
    iget-object v0, p0, Lcom/google/protobuf/DescriptorProtos$MethodDescriptorProto;->options_:Lcom/google/protobuf/DescriptorProtos$MethodOptions;

    return-object v0
.end method

.method public getOptionsOrBuilder()Lcom/google/protobuf/DescriptorProtos$MethodOptionsOrBuilder;
    .locals 1

    .prologue
    .line 8708
    iget-object v0, p0, Lcom/google/protobuf/DescriptorProtos$MethodDescriptorProto;->options_:Lcom/google/protobuf/DescriptorProtos$MethodOptions;

    return-object v0
.end method

.method public getOutputType()Ljava/lang/String;
    .locals 2

    .prologue
    .line 8673
    iget-object v0, p0, Lcom/google/protobuf/DescriptorProtos$MethodDescriptorProto;->outputType_:Ljava/lang/Object;

    .line 8674
    instance-of v1, v0, Ljava/lang/String;

    if-eqz v1, :cond_0

    .line 8675
    check-cast v0, Ljava/lang/String;

    .line 8683
    :goto_0
    return-object v0

    .line 8678
    :cond_0
    check-cast v0, Lcom/google/protobuf/ByteString;

    .line 8679
    invoke-virtual {v0}, Lcom/google/protobuf/ByteString;->toStringUtf8()Ljava/lang/String;

    move-result-object v1

    .line 8680
    invoke-static {v0}, Lcom/google/protobuf/Internal;->isValidUtf8(Lcom/google/protobuf/ByteString;)Z

    move-result v0

    if-eqz v0, :cond_1

    .line 8681
    iput-object v1, p0, Lcom/google/protobuf/DescriptorProtos$MethodDescriptorProto;->outputType_:Ljava/lang/Object;

    :cond_1
    move-object v0, v1

    .line 8683
    goto :goto_0
.end method

.method public getSerializedSize()I
    .locals 5

    .prologue
    const/4 v4, 0x4

    const/4 v3, 0x2

    const/4 v2, 0x1

    .line 8752
    iget v0, p0, Lcom/google/protobuf/DescriptorProtos$MethodDescriptorProto;->memoizedSerializedSize:I

    .line 8753
    const/4 v1, -0x1

    if-eq v0, v1, :cond_0

    .line 8774
    :goto_0
    return v0

    .line 8755
    :cond_0
    const/4 v0, 0x0

    .line 8756
    iget v1, p0, Lcom/google/protobuf/DescriptorProtos$MethodDescriptorProto;->bitField0_:I

    and-int/lit8 v1, v1, 0x1

    if-ne v1, v2, :cond_1

    .line 8758
    invoke-direct {p0}, Lcom/google/protobuf/DescriptorProtos$MethodDescriptorProto;->getNameBytes()Lcom/google/protobuf/ByteString;

    move-result-object v1

    invoke-static {v2, v1}, Lcom/google/protobuf/CodedOutputStream;->computeBytesSize(ILcom/google/protobuf/ByteString;)I

    move-result v1

    add-int/2addr v0, v1

    .line 8760
    :cond_1
    iget v1, p0, Lcom/google/protobuf/DescriptorProtos$MethodDescriptorProto;->bitField0_:I

    and-int/lit8 v1, v1, 0x2

    if-ne v1, v3, :cond_2

    .line 8762
    invoke-direct {p0}, Lcom/google/protobuf/DescriptorProtos$MethodDescriptorProto;->getInputTypeBytes()Lcom/google/protobuf/ByteString;

    move-result-object v1

    invoke-static {v3, v1}, Lcom/google/protobuf/CodedOutputStream;->computeBytesSize(ILcom/google/protobuf/ByteString;)I

    move-result v1

    add-int/2addr v0, v1

    .line 8764
    :cond_2
    iget v1, p0, Lcom/google/protobuf/DescriptorProtos$MethodDescriptorProto;->bitField0_:I

    and-int/lit8 v1, v1, 0x4

    if-ne v1, v4, :cond_3

    .line 8766
    const/4 v1, 0x3

    invoke-direct {p0}, Lcom/google/protobuf/DescriptorProtos$MethodDescriptorProto;->getOutputTypeBytes()Lcom/google/protobuf/ByteString;

    move-result-object v2

    invoke-static {v1, v2}, Lcom/google/protobuf/CodedOutputStream;->computeBytesSize(ILcom/google/protobuf/ByteString;)I

    move-result v1

    add-int/2addr v0, v1

    .line 8768
    :cond_3
    iget v1, p0, Lcom/google/protobuf/DescriptorProtos$MethodDescriptorProto;->bitField0_:I

    and-int/lit8 v1, v1, 0x8

    const/16 v2, 0x8

    if-ne v1, v2, :cond_4

    .line 8770
    iget-object v1, p0, Lcom/google/protobuf/DescriptorProtos$MethodDescriptorProto;->options_:Lcom/google/protobuf/DescriptorProtos$MethodOptions;

    invoke-static {v4, v1}, Lcom/google/protobuf/CodedOutputStream;->computeMessageSize(ILcom/google/protobuf/MessageLite;)I

    move-result v1

    add-int/2addr v0, v1

    .line 8772
    :cond_4
    invoke-virtual {p0}, Lcom/google/protobuf/DescriptorProtos$MethodDescriptorProto;->getUnknownFields()Lcom/google/protobuf/UnknownFieldSet;

    move-result-object v1

    invoke-virtual {v1}, Lcom/google/protobuf/UnknownFieldSet;->getSerializedSize()I

    move-result v1

    add-int/2addr v0, v1

    .line 8773
    iput v0, p0, Lcom/google/protobuf/DescriptorProtos$MethodDescriptorProto;->memoizedSerializedSize:I

    goto :goto_0
.end method

.method public hasInputType()Z
    .locals 2

    .prologue
    .line 8638
    iget v0, p0, Lcom/google/protobuf/DescriptorProtos$MethodDescriptorProto;->bitField0_:I

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

.method public hasName()Z
    .locals 2

    .prologue
    const/4 v0, 0x1

    .line 8606
    iget v1, p0, Lcom/google/protobuf/DescriptorProtos$MethodDescriptorProto;->bitField0_:I

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
    .line 8702
    iget v0, p0, Lcom/google/protobuf/DescriptorProtos$MethodDescriptorProto;->bitField0_:I

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

.method public hasOutputType()Z
    .locals 2

    .prologue
    .line 8670
    iget v0, p0, Lcom/google/protobuf/DescriptorProtos$MethodDescriptorProto;->bitField0_:I

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
    .locals 1

    .prologue
    .line 8598
    invoke-static {}, Lcom/google/protobuf/DescriptorProtos;->access$69()Lcom/google/protobuf/GeneratedMessage$FieldAccessorTable;

    move-result-object v0

    return-object v0
.end method

.method public final isInitialized()Z
    .locals 4

    .prologue
    const/4 v1, 0x0

    const/4 v0, 0x1

    .line 8719
    iget-byte v2, p0, Lcom/google/protobuf/DescriptorProtos$MethodDescriptorProto;->memoizedIsInitialized:B

    .line 8720
    const/4 v3, -0x1

    if-eq v2, v3, :cond_1

    if-ne v2, v0, :cond_0

    .line 8729
    :goto_0
    return v0

    :cond_0
    move v0, v1

    .line 8720
    goto :goto_0

    .line 8722
    :cond_1
    invoke-virtual {p0}, Lcom/google/protobuf/DescriptorProtos$MethodDescriptorProto;->hasOptions()Z

    move-result v2

    if-eqz v2, :cond_2

    .line 8723
    invoke-virtual {p0}, Lcom/google/protobuf/DescriptorProtos$MethodDescriptorProto;->getOptions()Lcom/google/protobuf/DescriptorProtos$MethodOptions;

    move-result-object v2

    invoke-virtual {v2}, Lcom/google/protobuf/DescriptorProtos$MethodOptions;->isInitialized()Z

    move-result v2

    if-nez v2, :cond_2

    .line 8724
    iput-byte v1, p0, Lcom/google/protobuf/DescriptorProtos$MethodDescriptorProto;->memoizedIsInitialized:B

    move v0, v1

    .line 8725
    goto :goto_0

    .line 8728
    :cond_2
    iput-byte v0, p0, Lcom/google/protobuf/DescriptorProtos$MethodDescriptorProto;->memoizedIsInitialized:B

    goto :goto_0
.end method

.method public newBuilderForType()Lcom/google/protobuf/DescriptorProtos$MethodDescriptorProto$Builder;
    .locals 1

    .prologue
    .line 8852
    invoke-static {}, Lcom/google/protobuf/DescriptorProtos$MethodDescriptorProto;->newBuilder()Lcom/google/protobuf/DescriptorProtos$MethodDescriptorProto$Builder;

    move-result-object v0

    return-object v0
.end method

.method protected newBuilderForType(Lcom/google/protobuf/GeneratedMessage$BuilderParent;)Lcom/google/protobuf/DescriptorProtos$MethodDescriptorProto$Builder;
    .locals 2

    .prologue
    .line 8861
    new-instance v0, Lcom/google/protobuf/DescriptorProtos$MethodDescriptorProto$Builder;

    const/4 v1, 0x0

    invoke-direct {v0, p1, v1}, Lcom/google/protobuf/DescriptorProtos$MethodDescriptorProto$Builder;-><init>(Lcom/google/protobuf/GeneratedMessage$BuilderParent;Lcom/google/protobuf/DescriptorProtos$MethodDescriptorProto$Builder;)V

    .line 8862
    return-object v0
.end method

.method public bridge synthetic newBuilderForType()Lcom/google/protobuf/Message$Builder;
    .locals 1

    .prologue
    .line 1
    invoke-virtual {p0}, Lcom/google/protobuf/DescriptorProtos$MethodDescriptorProto;->newBuilderForType()Lcom/google/protobuf/DescriptorProtos$MethodDescriptorProto$Builder;

    move-result-object v0

    return-object v0
.end method

.method protected bridge synthetic newBuilderForType(Lcom/google/protobuf/GeneratedMessage$BuilderParent;)Lcom/google/protobuf/Message$Builder;
    .locals 1

    .prologue
    .line 1
    invoke-virtual {p0, p1}, Lcom/google/protobuf/DescriptorProtos$MethodDescriptorProto;->newBuilderForType(Lcom/google/protobuf/GeneratedMessage$BuilderParent;)Lcom/google/protobuf/DescriptorProtos$MethodDescriptorProto$Builder;

    move-result-object v0

    return-object v0
.end method

.method public bridge synthetic newBuilderForType()Lcom/google/protobuf/MessageLite$Builder;
    .locals 1

    .prologue
    .line 1
    invoke-virtual {p0}, Lcom/google/protobuf/DescriptorProtos$MethodDescriptorProto;->newBuilderForType()Lcom/google/protobuf/DescriptorProtos$MethodDescriptorProto$Builder;

    move-result-object v0

    return-object v0
.end method

.method public toBuilder()Lcom/google/protobuf/DescriptorProtos$MethodDescriptorProto$Builder;
    .locals 1

    .prologue
    .line 8856
    invoke-static {p0}, Lcom/google/protobuf/DescriptorProtos$MethodDescriptorProto;->newBuilder(Lcom/google/protobuf/DescriptorProtos$MethodDescriptorProto;)Lcom/google/protobuf/DescriptorProtos$MethodDescriptorProto$Builder;

    move-result-object v0

    return-object v0
.end method

.method public bridge synthetic toBuilder()Lcom/google/protobuf/Message$Builder;
    .locals 1

    .prologue
    .line 1
    invoke-virtual {p0}, Lcom/google/protobuf/DescriptorProtos$MethodDescriptorProto;->toBuilder()Lcom/google/protobuf/DescriptorProtos$MethodDescriptorProto$Builder;

    move-result-object v0

    return-object v0
.end method

.method public bridge synthetic toBuilder()Lcom/google/protobuf/MessageLite$Builder;
    .locals 1

    .prologue
    .line 1
    invoke-virtual {p0}, Lcom/google/protobuf/DescriptorProtos$MethodDescriptorProto;->toBuilder()Lcom/google/protobuf/DescriptorProtos$MethodDescriptorProto$Builder;

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
    .line 8781
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

    .line 8734
    invoke-virtual {p0}, Lcom/google/protobuf/DescriptorProtos$MethodDescriptorProto;->getSerializedSize()I

    .line 8735
    iget v0, p0, Lcom/google/protobuf/DescriptorProtos$MethodDescriptorProto;->bitField0_:I

    and-int/lit8 v0, v0, 0x1

    if-ne v0, v1, :cond_0

    .line 8736
    invoke-direct {p0}, Lcom/google/protobuf/DescriptorProtos$MethodDescriptorProto;->getNameBytes()Lcom/google/protobuf/ByteString;

    move-result-object v0

    invoke-virtual {p1, v1, v0}, Lcom/google/protobuf/CodedOutputStream;->writeBytes(ILcom/google/protobuf/ByteString;)V

    .line 8738
    :cond_0
    iget v0, p0, Lcom/google/protobuf/DescriptorProtos$MethodDescriptorProto;->bitField0_:I

    and-int/lit8 v0, v0, 0x2

    if-ne v0, v2, :cond_1

    .line 8739
    invoke-direct {p0}, Lcom/google/protobuf/DescriptorProtos$MethodDescriptorProto;->getInputTypeBytes()Lcom/google/protobuf/ByteString;

    move-result-object v0

    invoke-virtual {p1, v2, v0}, Lcom/google/protobuf/CodedOutputStream;->writeBytes(ILcom/google/protobuf/ByteString;)V

    .line 8741
    :cond_1
    iget v0, p0, Lcom/google/protobuf/DescriptorProtos$MethodDescriptorProto;->bitField0_:I

    and-int/lit8 v0, v0, 0x4

    if-ne v0, v3, :cond_2

    .line 8742
    const/4 v0, 0x3

    invoke-direct {p0}, Lcom/google/protobuf/DescriptorProtos$MethodDescriptorProto;->getOutputTypeBytes()Lcom/google/protobuf/ByteString;

    move-result-object v1

    invoke-virtual {p1, v0, v1}, Lcom/google/protobuf/CodedOutputStream;->writeBytes(ILcom/google/protobuf/ByteString;)V

    .line 8744
    :cond_2
    iget v0, p0, Lcom/google/protobuf/DescriptorProtos$MethodDescriptorProto;->bitField0_:I

    and-int/lit8 v0, v0, 0x8

    const/16 v1, 0x8

    if-ne v0, v1, :cond_3

    .line 8745
    iget-object v0, p0, Lcom/google/protobuf/DescriptorProtos$MethodDescriptorProto;->options_:Lcom/google/protobuf/DescriptorProtos$MethodOptions;

    invoke-virtual {p1, v3, v0}, Lcom/google/protobuf/CodedOutputStream;->writeMessage(ILcom/google/protobuf/MessageLite;)V

    .line 8747
    :cond_3
    invoke-virtual {p0}, Lcom/google/protobuf/DescriptorProtos$MethodDescriptorProto;->getUnknownFields()Lcom/google/protobuf/UnknownFieldSet;

    move-result-object v0

    invoke-virtual {v0, p1}, Lcom/google/protobuf/UnknownFieldSet;->writeTo(Lcom/google/protobuf/CodedOutputStream;)V

    .line 8748
    return-void
.end method
