.class public final Lcom/google/protobuf/DescriptorProtos$MessageOptions;
.super Lcom/google/protobuf/GeneratedMessage$ExtendableMessage;
.source "SourceFile"

# interfaces
.implements Lcom/google/protobuf/DescriptorProtos$MessageOptionsOrBuilder;


# annotations
.annotation system Ldalvik/annotation/EnclosingClass;
    value = Lcom/google/protobuf/DescriptorProtos;
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x19
    name = "MessageOptions"
.end annotation

.annotation system Ldalvik/annotation/MemberClasses;
    value = {
        Lcom/google/protobuf/DescriptorProtos$MessageOptions$Builder;
    }
.end annotation

.annotation system Ldalvik/annotation/Signature;
    value = {
        "Lcom/google/protobuf/GeneratedMessage$ExtendableMessage",
        "<",
        "Lcom/google/protobuf/DescriptorProtos$MessageOptions;",
        ">;",
        "Lcom/google/protobuf/DescriptorProtos$MessageOptionsOrBuilder;"
    }
.end annotation


# static fields
.field public static final MESSAGE_SET_WIRE_FORMAT_FIELD_NUMBER:I = 0x1

.field public static final NO_STANDARD_DESCRIPTOR_ACCESSOR_FIELD_NUMBER:I = 0x2

.field public static final UNINTERPRETED_OPTION_FIELD_NUMBER:I = 0x3e7

.field private static final defaultInstance:Lcom/google/protobuf/DescriptorProtos$MessageOptions;

.field private static final serialVersionUID:J


# instance fields
.field private bitField0_:I

.field private memoizedIsInitialized:B

.field private memoizedSerializedSize:I

.field private messageSetWireFormat_:Z

.field private noStandardDescriptorAccessor_:Z

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
    .line 11245
    new-instance v0, Lcom/google/protobuf/DescriptorProtos$MessageOptions;

    const/4 v1, 0x1

    invoke-direct {v0, v1}, Lcom/google/protobuf/DescriptorProtos$MessageOptions;-><init>(Z)V

    sput-object v0, Lcom/google/protobuf/DescriptorProtos$MessageOptions;->defaultInstance:Lcom/google/protobuf/DescriptorProtos$MessageOptions;

    .line 11246
    sget-object v0, Lcom/google/protobuf/DescriptorProtos$MessageOptions;->defaultInstance:Lcom/google/protobuf/DescriptorProtos$MessageOptions;

    invoke-direct {v0}, Lcom/google/protobuf/DescriptorProtos$MessageOptions;->initFields()V

    .line 10579
    return-void
.end method

.method private constructor <init>(Lcom/google/protobuf/DescriptorProtos$MessageOptions$Builder;)V
    .locals 1

    .prologue
    const/4 v0, -0x1

    .line 10584
    invoke-direct {p0, p1}, Lcom/google/protobuf/GeneratedMessage$ExtendableMessage;-><init>(Lcom/google/protobuf/GeneratedMessage$ExtendableBuilder;)V

    .line 10654
    iput-byte v0, p0, Lcom/google/protobuf/DescriptorProtos$MessageOptions;->memoizedIsInitialized:B

    .line 10692
    iput v0, p0, Lcom/google/protobuf/DescriptorProtos$MessageOptions;->memoizedSerializedSize:I

    .line 10585
    return-void
.end method

.method synthetic constructor <init>(Lcom/google/protobuf/DescriptorProtos$MessageOptions$Builder;Lcom/google/protobuf/DescriptorProtos$MessageOptions;)V
    .locals 0

    .prologue
    .line 10583
    invoke-direct {p0, p1}, Lcom/google/protobuf/DescriptorProtos$MessageOptions;-><init>(Lcom/google/protobuf/DescriptorProtos$MessageOptions$Builder;)V

    return-void
.end method

.method private constructor <init>(Z)V
    .locals 1

    .prologue
    const/4 v0, -0x1

    .line 10586
    invoke-direct {p0}, Lcom/google/protobuf/GeneratedMessage$ExtendableMessage;-><init>()V

    .line 10654
    iput-byte v0, p0, Lcom/google/protobuf/DescriptorProtos$MessageOptions;->memoizedIsInitialized:B

    .line 10692
    iput v0, p0, Lcom/google/protobuf/DescriptorProtos$MessageOptions;->memoizedSerializedSize:I

    .line 10586
    return-void
.end method

.method static synthetic access$10(Lcom/google/protobuf/DescriptorProtos$MessageOptions;Ljava/util/List;)V
    .locals 0

    .prologue
    .line 10630
    iput-object p1, p0, Lcom/google/protobuf/DescriptorProtos$MessageOptions;->uninterpretedOption_:Ljava/util/List;

    return-void
.end method

.method static synthetic access$11(Lcom/google/protobuf/DescriptorProtos$MessageOptions;I)V
    .locals 0

    .prologue
    .line 10607
    iput p1, p0, Lcom/google/protobuf/DescriptorProtos$MessageOptions;->bitField0_:I

    return-void
.end method

.method static synthetic access$12(Lcom/google/protobuf/DescriptorProtos$MessageOptions;)Ljava/util/List;
    .locals 1

    .prologue
    .line 10630
    iget-object v0, p0, Lcom/google/protobuf/DescriptorProtos$MessageOptions;->uninterpretedOption_:Ljava/util/List;

    return-object v0
.end method

.method static synthetic access$8(Lcom/google/protobuf/DescriptorProtos$MessageOptions;Z)V
    .locals 0

    .prologue
    .line 10610
    iput-boolean p1, p0, Lcom/google/protobuf/DescriptorProtos$MessageOptions;->messageSetWireFormat_:Z

    return-void
.end method

.method static synthetic access$9(Lcom/google/protobuf/DescriptorProtos$MessageOptions;Z)V
    .locals 0

    .prologue
    .line 10620
    iput-boolean p1, p0, Lcom/google/protobuf/DescriptorProtos$MessageOptions;->noStandardDescriptorAccessor_:Z

    return-void
.end method

.method public static getDefaultInstance()Lcom/google/protobuf/DescriptorProtos$MessageOptions;
    .locals 1

    .prologue
    .line 10590
    sget-object v0, Lcom/google/protobuf/DescriptorProtos$MessageOptions;->defaultInstance:Lcom/google/protobuf/DescriptorProtos$MessageOptions;

    return-object v0
.end method

.method public static final getDescriptor()Lcom/google/protobuf/Descriptors$Descriptor;
    .locals 1

    .prologue
    .line 10599
    invoke-static {}, Lcom/google/protobuf/DescriptorProtos;->access$32()Lcom/google/protobuf/Descriptors$Descriptor;

    move-result-object v0

    return-object v0
.end method

.method private initFields()V
    .locals 1

    .prologue
    const/4 v0, 0x0

    .line 10650
    iput-boolean v0, p0, Lcom/google/protobuf/DescriptorProtos$MessageOptions;->messageSetWireFormat_:Z

    .line 10651
    iput-boolean v0, p0, Lcom/google/protobuf/DescriptorProtos$MessageOptions;->noStandardDescriptorAccessor_:Z

    .line 10652
    invoke-static {}, Ljava/util/Collections;->emptyList()Ljava/util/List;

    move-result-object v0

    iput-object v0, p0, Lcom/google/protobuf/DescriptorProtos$MessageOptions;->uninterpretedOption_:Ljava/util/List;

    .line 10653
    return-void
.end method

.method public static newBuilder()Lcom/google/protobuf/DescriptorProtos$MessageOptions$Builder;
    .locals 1

    .prologue
    .line 10790
    invoke-static {}, Lcom/google/protobuf/DescriptorProtos$MessageOptions$Builder;->access$18()Lcom/google/protobuf/DescriptorProtos$MessageOptions$Builder;

    move-result-object v0

    return-object v0
.end method

.method public static newBuilder(Lcom/google/protobuf/DescriptorProtos$MessageOptions;)Lcom/google/protobuf/DescriptorProtos$MessageOptions$Builder;
    .locals 1

    .prologue
    .line 10793
    invoke-static {}, Lcom/google/protobuf/DescriptorProtos$MessageOptions;->newBuilder()Lcom/google/protobuf/DescriptorProtos$MessageOptions$Builder;

    move-result-object v0

    invoke-virtual {v0, p0}, Lcom/google/protobuf/DescriptorProtos$MessageOptions$Builder;->mergeFrom(Lcom/google/protobuf/DescriptorProtos$MessageOptions;)Lcom/google/protobuf/DescriptorProtos$MessageOptions$Builder;

    move-result-object v0

    return-object v0
.end method

.method public static parseDelimitedFrom(Ljava/io/InputStream;)Lcom/google/protobuf/DescriptorProtos$MessageOptions;
    .locals 2
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljava/io/IOException;
        }
    .end annotation

    .prologue
    .line 10759
    invoke-static {}, Lcom/google/protobuf/DescriptorProtos$MessageOptions;->newBuilder()Lcom/google/protobuf/DescriptorProtos$MessageOptions$Builder;

    move-result-object v0

    .line 10760
    invoke-virtual {v0, p0}, Lcom/google/protobuf/DescriptorProtos$MessageOptions$Builder;->mergeDelimitedFrom(Ljava/io/InputStream;)Z

    move-result v1

    if-eqz v1, :cond_0

    .line 10761
    invoke-static {v0}, Lcom/google/protobuf/DescriptorProtos$MessageOptions$Builder;->access$17(Lcom/google/protobuf/DescriptorProtos$MessageOptions$Builder;)Lcom/google/protobuf/DescriptorProtos$MessageOptions;

    move-result-object v0

    .line 10763
    :goto_0
    return-object v0

    :cond_0
    const/4 v0, 0x0

    goto :goto_0
.end method

.method public static parseDelimitedFrom(Ljava/io/InputStream;Lcom/google/protobuf/ExtensionRegistryLite;)Lcom/google/protobuf/DescriptorProtos$MessageOptions;
    .locals 2
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljava/io/IOException;
        }
    .end annotation

    .prologue
    .line 10770
    invoke-static {}, Lcom/google/protobuf/DescriptorProtos$MessageOptions;->newBuilder()Lcom/google/protobuf/DescriptorProtos$MessageOptions$Builder;

    move-result-object v0

    .line 10771
    invoke-virtual {v0, p0, p1}, Lcom/google/protobuf/DescriptorProtos$MessageOptions$Builder;->mergeDelimitedFrom(Ljava/io/InputStream;Lcom/google/protobuf/ExtensionRegistryLite;)Z

    move-result v1

    if-eqz v1, :cond_0

    .line 10772
    invoke-static {v0}, Lcom/google/protobuf/DescriptorProtos$MessageOptions$Builder;->access$17(Lcom/google/protobuf/DescriptorProtos$MessageOptions$Builder;)Lcom/google/protobuf/DescriptorProtos$MessageOptions;

    move-result-object v0

    .line 10774
    :goto_0
    return-object v0

    :cond_0
    const/4 v0, 0x0

    goto :goto_0
.end method

.method public static parseFrom(Lcom/google/protobuf/ByteString;)Lcom/google/protobuf/DescriptorProtos$MessageOptions;
    .locals 1
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Lcom/google/protobuf/InvalidProtocolBufferException;
        }
    .end annotation

    .prologue
    .line 10726
    invoke-static {}, Lcom/google/protobuf/DescriptorProtos$MessageOptions;->newBuilder()Lcom/google/protobuf/DescriptorProtos$MessageOptions$Builder;

    move-result-object v0

    invoke-virtual {v0, p0}, Lcom/google/protobuf/DescriptorProtos$MessageOptions$Builder;->mergeFrom(Lcom/google/protobuf/ByteString;)Lcom/google/protobuf/AbstractMessage$Builder;

    move-result-object v0

    check-cast v0, Lcom/google/protobuf/DescriptorProtos$MessageOptions$Builder;

    invoke-static {v0}, Lcom/google/protobuf/DescriptorProtos$MessageOptions$Builder;->access$17(Lcom/google/protobuf/DescriptorProtos$MessageOptions$Builder;)Lcom/google/protobuf/DescriptorProtos$MessageOptions;

    move-result-object v0

    return-object v0
.end method

.method public static parseFrom(Lcom/google/protobuf/ByteString;Lcom/google/protobuf/ExtensionRegistryLite;)Lcom/google/protobuf/DescriptorProtos$MessageOptions;
    .locals 1
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Lcom/google/protobuf/InvalidProtocolBufferException;
        }
    .end annotation

    .prologue
    .line 10732
    invoke-static {}, Lcom/google/protobuf/DescriptorProtos$MessageOptions;->newBuilder()Lcom/google/protobuf/DescriptorProtos$MessageOptions$Builder;

    move-result-object v0

    invoke-virtual {v0, p0, p1}, Lcom/google/protobuf/DescriptorProtos$MessageOptions$Builder;->mergeFrom(Lcom/google/protobuf/ByteString;Lcom/google/protobuf/ExtensionRegistryLite;)Lcom/google/protobuf/AbstractMessage$Builder;

    move-result-object v0

    check-cast v0, Lcom/google/protobuf/DescriptorProtos$MessageOptions$Builder;

    .line 10733
    invoke-static {v0}, Lcom/google/protobuf/DescriptorProtos$MessageOptions$Builder;->access$17(Lcom/google/protobuf/DescriptorProtos$MessageOptions$Builder;)Lcom/google/protobuf/DescriptorProtos$MessageOptions;

    move-result-object v0

    .line 10732
    return-object v0
.end method

.method public static parseFrom(Lcom/google/protobuf/CodedInputStream;)Lcom/google/protobuf/DescriptorProtos$MessageOptions;
    .locals 1
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljava/io/IOException;
        }
    .end annotation

    .prologue
    .line 10780
    invoke-static {}, Lcom/google/protobuf/DescriptorProtos$MessageOptions;->newBuilder()Lcom/google/protobuf/DescriptorProtos$MessageOptions$Builder;

    move-result-object v0

    invoke-virtual {v0, p0}, Lcom/google/protobuf/DescriptorProtos$MessageOptions$Builder;->mergeFrom(Lcom/google/protobuf/CodedInputStream;)Lcom/google/protobuf/AbstractMessage$Builder;

    move-result-object v0

    check-cast v0, Lcom/google/protobuf/DescriptorProtos$MessageOptions$Builder;

    invoke-static {v0}, Lcom/google/protobuf/DescriptorProtos$MessageOptions$Builder;->access$17(Lcom/google/protobuf/DescriptorProtos$MessageOptions$Builder;)Lcom/google/protobuf/DescriptorProtos$MessageOptions;

    move-result-object v0

    return-object v0
.end method

.method public static parseFrom(Lcom/google/protobuf/CodedInputStream;Lcom/google/protobuf/ExtensionRegistryLite;)Lcom/google/protobuf/DescriptorProtos$MessageOptions;
    .locals 1
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljava/io/IOException;
        }
    .end annotation

    .prologue
    .line 10786
    invoke-static {}, Lcom/google/protobuf/DescriptorProtos$MessageOptions;->newBuilder()Lcom/google/protobuf/DescriptorProtos$MessageOptions$Builder;

    move-result-object v0

    invoke-virtual {v0, p0, p1}, Lcom/google/protobuf/DescriptorProtos$MessageOptions$Builder;->mergeFrom(Lcom/google/protobuf/CodedInputStream;Lcom/google/protobuf/ExtensionRegistryLite;)Lcom/google/protobuf/DescriptorProtos$MessageOptions$Builder;

    move-result-object v0

    .line 10787
    invoke-static {v0}, Lcom/google/protobuf/DescriptorProtos$MessageOptions$Builder;->access$17(Lcom/google/protobuf/DescriptorProtos$MessageOptions$Builder;)Lcom/google/protobuf/DescriptorProtos$MessageOptions;

    move-result-object v0

    .line 10786
    return-object v0
.end method

.method public static parseFrom(Ljava/io/InputStream;)Lcom/google/protobuf/DescriptorProtos$MessageOptions;
    .locals 1
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljava/io/IOException;
        }
    .end annotation

    .prologue
    .line 10748
    invoke-static {}, Lcom/google/protobuf/DescriptorProtos$MessageOptions;->newBuilder()Lcom/google/protobuf/DescriptorProtos$MessageOptions$Builder;

    move-result-object v0

    invoke-virtual {v0, p0}, Lcom/google/protobuf/DescriptorProtos$MessageOptions$Builder;->mergeFrom(Ljava/io/InputStream;)Lcom/google/protobuf/AbstractMessage$Builder;

    move-result-object v0

    check-cast v0, Lcom/google/protobuf/DescriptorProtos$MessageOptions$Builder;

    invoke-static {v0}, Lcom/google/protobuf/DescriptorProtos$MessageOptions$Builder;->access$17(Lcom/google/protobuf/DescriptorProtos$MessageOptions$Builder;)Lcom/google/protobuf/DescriptorProtos$MessageOptions;

    move-result-object v0

    return-object v0
.end method

.method public static parseFrom(Ljava/io/InputStream;Lcom/google/protobuf/ExtensionRegistryLite;)Lcom/google/protobuf/DescriptorProtos$MessageOptions;
    .locals 1
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljava/io/IOException;
        }
    .end annotation

    .prologue
    .line 10754
    invoke-static {}, Lcom/google/protobuf/DescriptorProtos$MessageOptions;->newBuilder()Lcom/google/protobuf/DescriptorProtos$MessageOptions$Builder;

    move-result-object v0

    invoke-virtual {v0, p0, p1}, Lcom/google/protobuf/DescriptorProtos$MessageOptions$Builder;->mergeFrom(Ljava/io/InputStream;Lcom/google/protobuf/ExtensionRegistryLite;)Lcom/google/protobuf/AbstractMessage$Builder;

    move-result-object v0

    check-cast v0, Lcom/google/protobuf/DescriptorProtos$MessageOptions$Builder;

    .line 10755
    invoke-static {v0}, Lcom/google/protobuf/DescriptorProtos$MessageOptions$Builder;->access$17(Lcom/google/protobuf/DescriptorProtos$MessageOptions$Builder;)Lcom/google/protobuf/DescriptorProtos$MessageOptions;

    move-result-object v0

    .line 10754
    return-object v0
.end method

.method public static parseFrom([B)Lcom/google/protobuf/DescriptorProtos$MessageOptions;
    .locals 1
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Lcom/google/protobuf/InvalidProtocolBufferException;
        }
    .end annotation

    .prologue
    .line 10737
    invoke-static {}, Lcom/google/protobuf/DescriptorProtos$MessageOptions;->newBuilder()Lcom/google/protobuf/DescriptorProtos$MessageOptions$Builder;

    move-result-object v0

    invoke-virtual {v0, p0}, Lcom/google/protobuf/DescriptorProtos$MessageOptions$Builder;->mergeFrom([B)Lcom/google/protobuf/AbstractMessage$Builder;

    move-result-object v0

    check-cast v0, Lcom/google/protobuf/DescriptorProtos$MessageOptions$Builder;

    invoke-static {v0}, Lcom/google/protobuf/DescriptorProtos$MessageOptions$Builder;->access$17(Lcom/google/protobuf/DescriptorProtos$MessageOptions$Builder;)Lcom/google/protobuf/DescriptorProtos$MessageOptions;

    move-result-object v0

    return-object v0
.end method

.method public static parseFrom([BLcom/google/protobuf/ExtensionRegistryLite;)Lcom/google/protobuf/DescriptorProtos$MessageOptions;
    .locals 1
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Lcom/google/protobuf/InvalidProtocolBufferException;
        }
    .end annotation

    .prologue
    .line 10743
    invoke-static {}, Lcom/google/protobuf/DescriptorProtos$MessageOptions;->newBuilder()Lcom/google/protobuf/DescriptorProtos$MessageOptions$Builder;

    move-result-object v0

    invoke-virtual {v0, p0, p1}, Lcom/google/protobuf/DescriptorProtos$MessageOptions$Builder;->mergeFrom([BLcom/google/protobuf/ExtensionRegistryLite;)Lcom/google/protobuf/AbstractMessage$Builder;

    move-result-object v0

    check-cast v0, Lcom/google/protobuf/DescriptorProtos$MessageOptions$Builder;

    .line 10744
    invoke-static {v0}, Lcom/google/protobuf/DescriptorProtos$MessageOptions$Builder;->access$17(Lcom/google/protobuf/DescriptorProtos$MessageOptions$Builder;)Lcom/google/protobuf/DescriptorProtos$MessageOptions;

    move-result-object v0

    .line 10743
    return-object v0
.end method


# virtual methods
.method public getDefaultInstanceForType()Lcom/google/protobuf/DescriptorProtos$MessageOptions;
    .locals 1

    .prologue
    .line 10594
    sget-object v0, Lcom/google/protobuf/DescriptorProtos$MessageOptions;->defaultInstance:Lcom/google/protobuf/DescriptorProtos$MessageOptions;

    return-object v0
.end method

.method public bridge synthetic getDefaultInstanceForType()Lcom/google/protobuf/Message;
    .locals 1

    .prologue
    .line 1
    invoke-virtual {p0}, Lcom/google/protobuf/DescriptorProtos$MessageOptions;->getDefaultInstanceForType()Lcom/google/protobuf/DescriptorProtos$MessageOptions;

    move-result-object v0

    return-object v0
.end method

.method public bridge synthetic getDefaultInstanceForType()Lcom/google/protobuf/MessageLite;
    .locals 1

    .prologue
    .line 1
    invoke-virtual {p0}, Lcom/google/protobuf/DescriptorProtos$MessageOptions;->getDefaultInstanceForType()Lcom/google/protobuf/DescriptorProtos$MessageOptions;

    move-result-object v0

    return-object v0
.end method

.method public getMessageSetWireFormat()Z
    .locals 1

    .prologue
    .line 10615
    iget-boolean v0, p0, Lcom/google/protobuf/DescriptorProtos$MessageOptions;->messageSetWireFormat_:Z

    return v0
.end method

.method public getNoStandardDescriptorAccessor()Z
    .locals 1

    .prologue
    .line 10625
    iget-boolean v0, p0, Lcom/google/protobuf/DescriptorProtos$MessageOptions;->noStandardDescriptorAccessor_:Z

    return v0
.end method

.method public getSerializedSize()I
    .locals 5

    .prologue
    const/4 v4, 0x2

    const/4 v3, 0x1

    const/4 v1, 0x0

    .line 10694
    iget v0, p0, Lcom/google/protobuf/DescriptorProtos$MessageOptions;->memoizedSerializedSize:I

    .line 10695
    const/4 v2, -0x1

    if-eq v0, v2, :cond_0

    .line 10713
    :goto_0
    return v0

    .line 10698
    :cond_0
    iget v0, p0, Lcom/google/protobuf/DescriptorProtos$MessageOptions;->bitField0_:I

    and-int/lit8 v0, v0, 0x1

    if-ne v0, v3, :cond_3

    .line 10700
    iget-boolean v0, p0, Lcom/google/protobuf/DescriptorProtos$MessageOptions;->messageSetWireFormat_:Z

    invoke-static {v3, v0}, Lcom/google/protobuf/CodedOutputStream;->computeBoolSize(IZ)I

    move-result v0

    add-int/2addr v0, v1

    .line 10702
    :goto_1
    iget v2, p0, Lcom/google/protobuf/DescriptorProtos$MessageOptions;->bitField0_:I

    and-int/lit8 v2, v2, 0x2

    if-ne v2, v4, :cond_1

    .line 10704
    iget-boolean v2, p0, Lcom/google/protobuf/DescriptorProtos$MessageOptions;->noStandardDescriptorAccessor_:Z

    invoke-static {v4, v2}, Lcom/google/protobuf/CodedOutputStream;->computeBoolSize(IZ)I

    move-result v2

    add-int/2addr v0, v2

    :cond_1
    move v2, v0

    .line 10706
    :goto_2
    iget-object v0, p0, Lcom/google/protobuf/DescriptorProtos$MessageOptions;->uninterpretedOption_:Ljava/util/List;

    invoke-interface {v0}, Ljava/util/List;->size()I

    move-result v0

    if-lt v1, v0, :cond_2

    .line 10710
    invoke-virtual {p0}, Lcom/google/protobuf/DescriptorProtos$MessageOptions;->extensionsSerializedSize()I

    move-result v0

    add-int/2addr v0, v2

    .line 10711
    invoke-virtual {p0}, Lcom/google/protobuf/DescriptorProtos$MessageOptions;->getUnknownFields()Lcom/google/protobuf/UnknownFieldSet;

    move-result-object v1

    invoke-virtual {v1}, Lcom/google/protobuf/UnknownFieldSet;->getSerializedSize()I

    move-result v1

    add-int/2addr v0, v1

    .line 10712
    iput v0, p0, Lcom/google/protobuf/DescriptorProtos$MessageOptions;->memoizedSerializedSize:I

    goto :goto_0

    .line 10708
    :cond_2
    const/16 v3, 0x3e7

    iget-object v0, p0, Lcom/google/protobuf/DescriptorProtos$MessageOptions;->uninterpretedOption_:Ljava/util/List;

    invoke-interface {v0, v1}, Ljava/util/List;->get(I)Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Lcom/google/protobuf/MessageLite;

    invoke-static {v3, v0}, Lcom/google/protobuf/CodedOutputStream;->computeMessageSize(ILcom/google/protobuf/MessageLite;)I

    move-result v0

    add-int/2addr v0, v2

    .line 10706
    add-int/lit8 v1, v1, 0x1

    move v2, v0

    goto :goto_2

    :cond_3
    move v0, v1

    goto :goto_1
.end method

.method public getUninterpretedOption(I)Lcom/google/protobuf/DescriptorProtos$UninterpretedOption;
    .locals 1

    .prologue
    .line 10642
    iget-object v0, p0, Lcom/google/protobuf/DescriptorProtos$MessageOptions;->uninterpretedOption_:Ljava/util/List;

    invoke-interface {v0, p1}, Ljava/util/List;->get(I)Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Lcom/google/protobuf/DescriptorProtos$UninterpretedOption;

    return-object v0
.end method

.method public getUninterpretedOptionCount()I
    .locals 1

    .prologue
    .line 10639
    iget-object v0, p0, Lcom/google/protobuf/DescriptorProtos$MessageOptions;->uninterpretedOption_:Ljava/util/List;

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
    .line 10632
    iget-object v0, p0, Lcom/google/protobuf/DescriptorProtos$MessageOptions;->uninterpretedOption_:Ljava/util/List;

    return-object v0
.end method

.method public getUninterpretedOptionOrBuilder(I)Lcom/google/protobuf/DescriptorProtos$UninterpretedOptionOrBuilder;
    .locals 1

    .prologue
    .line 10646
    iget-object v0, p0, Lcom/google/protobuf/DescriptorProtos$MessageOptions;->uninterpretedOption_:Ljava/util/List;

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
    .line 10636
    iget-object v0, p0, Lcom/google/protobuf/DescriptorProtos$MessageOptions;->uninterpretedOption_:Ljava/util/List;

    return-object v0
.end method

.method public hasMessageSetWireFormat()Z
    .locals 2

    .prologue
    const/4 v0, 0x1

    .line 10612
    iget v1, p0, Lcom/google/protobuf/DescriptorProtos$MessageOptions;->bitField0_:I

    and-int/lit8 v1, v1, 0x1

    if-ne v1, v0, :cond_0

    :goto_0
    return v0

    :cond_0
    const/4 v0, 0x0

    goto :goto_0
.end method

.method public hasNoStandardDescriptorAccessor()Z
    .locals 2

    .prologue
    .line 10622
    iget v0, p0, Lcom/google/protobuf/DescriptorProtos$MessageOptions;->bitField0_:I

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
    .line 10604
    invoke-static {}, Lcom/google/protobuf/DescriptorProtos;->access$71()Lcom/google/protobuf/GeneratedMessage$FieldAccessorTable;

    move-result-object v0

    return-object v0
.end method

.method public final isInitialized()Z
    .locals 4

    .prologue
    const/4 v2, 0x1

    const/4 v1, 0x0

    .line 10656
    iget-byte v0, p0, Lcom/google/protobuf/DescriptorProtos$MessageOptions;->memoizedIsInitialized:B

    .line 10657
    const/4 v3, -0x1

    if-eq v0, v3, :cond_1

    if-ne v0, v2, :cond_0

    move v1, v2

    .line 10670
    :cond_0
    :goto_0
    return v1

    :cond_1
    move v0, v1

    .line 10659
    :goto_1
    invoke-virtual {p0}, Lcom/google/protobuf/DescriptorProtos$MessageOptions;->getUninterpretedOptionCount()I

    move-result v3

    if-lt v0, v3, :cond_2

    .line 10665
    invoke-virtual {p0}, Lcom/google/protobuf/DescriptorProtos$MessageOptions;->extensionsAreInitialized()Z

    move-result v0

    if-nez v0, :cond_4

    .line 10666
    iput-byte v1, p0, Lcom/google/protobuf/DescriptorProtos$MessageOptions;->memoizedIsInitialized:B

    goto :goto_0

    .line 10660
    :cond_2
    invoke-virtual {p0, v0}, Lcom/google/protobuf/DescriptorProtos$MessageOptions;->getUninterpretedOption(I)Lcom/google/protobuf/DescriptorProtos$UninterpretedOption;

    move-result-object v3

    invoke-virtual {v3}, Lcom/google/protobuf/DescriptorProtos$UninterpretedOption;->isInitialized()Z

    move-result v3

    if-nez v3, :cond_3

    .line 10661
    iput-byte v1, p0, Lcom/google/protobuf/DescriptorProtos$MessageOptions;->memoizedIsInitialized:B

    goto :goto_0

    .line 10659
    :cond_3
    add-int/lit8 v0, v0, 0x1

    goto :goto_1

    .line 10669
    :cond_4
    iput-byte v2, p0, Lcom/google/protobuf/DescriptorProtos$MessageOptions;->memoizedIsInitialized:B

    move v1, v2

    .line 10670
    goto :goto_0
.end method

.method public newBuilderForType()Lcom/google/protobuf/DescriptorProtos$MessageOptions$Builder;
    .locals 1

    .prologue
    .line 10791
    invoke-static {}, Lcom/google/protobuf/DescriptorProtos$MessageOptions;->newBuilder()Lcom/google/protobuf/DescriptorProtos$MessageOptions$Builder;

    move-result-object v0

    return-object v0
.end method

.method protected newBuilderForType(Lcom/google/protobuf/GeneratedMessage$BuilderParent;)Lcom/google/protobuf/DescriptorProtos$MessageOptions$Builder;
    .locals 2

    .prologue
    .line 10800
    new-instance v0, Lcom/google/protobuf/DescriptorProtos$MessageOptions$Builder;

    const/4 v1, 0x0

    invoke-direct {v0, p1, v1}, Lcom/google/protobuf/DescriptorProtos$MessageOptions$Builder;-><init>(Lcom/google/protobuf/GeneratedMessage$BuilderParent;Lcom/google/protobuf/DescriptorProtos$MessageOptions$Builder;)V

    .line 10801
    return-object v0
.end method

.method public bridge synthetic newBuilderForType()Lcom/google/protobuf/Message$Builder;
    .locals 1

    .prologue
    .line 1
    invoke-virtual {p0}, Lcom/google/protobuf/DescriptorProtos$MessageOptions;->newBuilderForType()Lcom/google/protobuf/DescriptorProtos$MessageOptions$Builder;

    move-result-object v0

    return-object v0
.end method

.method protected bridge synthetic newBuilderForType(Lcom/google/protobuf/GeneratedMessage$BuilderParent;)Lcom/google/protobuf/Message$Builder;
    .locals 1

    .prologue
    .line 1
    invoke-virtual {p0, p1}, Lcom/google/protobuf/DescriptorProtos$MessageOptions;->newBuilderForType(Lcom/google/protobuf/GeneratedMessage$BuilderParent;)Lcom/google/protobuf/DescriptorProtos$MessageOptions$Builder;

    move-result-object v0

    return-object v0
.end method

.method public bridge synthetic newBuilderForType()Lcom/google/protobuf/MessageLite$Builder;
    .locals 1

    .prologue
    .line 1
    invoke-virtual {p0}, Lcom/google/protobuf/DescriptorProtos$MessageOptions;->newBuilderForType()Lcom/google/protobuf/DescriptorProtos$MessageOptions$Builder;

    move-result-object v0

    return-object v0
.end method

.method public toBuilder()Lcom/google/protobuf/DescriptorProtos$MessageOptions$Builder;
    .locals 1

    .prologue
    .line 10795
    invoke-static {p0}, Lcom/google/protobuf/DescriptorProtos$MessageOptions;->newBuilder(Lcom/google/protobuf/DescriptorProtos$MessageOptions;)Lcom/google/protobuf/DescriptorProtos$MessageOptions$Builder;

    move-result-object v0

    return-object v0
.end method

.method public bridge synthetic toBuilder()Lcom/google/protobuf/Message$Builder;
    .locals 1

    .prologue
    .line 1
    invoke-virtual {p0}, Lcom/google/protobuf/DescriptorProtos$MessageOptions;->toBuilder()Lcom/google/protobuf/DescriptorProtos$MessageOptions$Builder;

    move-result-object v0

    return-object v0
.end method

.method public bridge synthetic toBuilder()Lcom/google/protobuf/MessageLite$Builder;
    .locals 1

    .prologue
    .line 1
    invoke-virtual {p0}, Lcom/google/protobuf/DescriptorProtos$MessageOptions;->toBuilder()Lcom/google/protobuf/DescriptorProtos$MessageOptions$Builder;

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
    .line 10720
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
    const/4 v3, 0x2

    const/4 v1, 0x1

    .line 10675
    invoke-virtual {p0}, Lcom/google/protobuf/DescriptorProtos$MessageOptions;->getSerializedSize()I

    .line 10678
    invoke-virtual {p0}, Lcom/google/protobuf/DescriptorProtos$MessageOptions;->newExtensionWriter()Lcom/google/protobuf/GeneratedMessage$ExtendableMessage$ExtensionWriter;

    move-result-object v2

    .line 10679
    iget v0, p0, Lcom/google/protobuf/DescriptorProtos$MessageOptions;->bitField0_:I

    and-int/lit8 v0, v0, 0x1

    if-ne v0, v1, :cond_0

    .line 10680
    iget-boolean v0, p0, Lcom/google/protobuf/DescriptorProtos$MessageOptions;->messageSetWireFormat_:Z

    invoke-virtual {p1, v1, v0}, Lcom/google/protobuf/CodedOutputStream;->writeBool(IZ)V

    .line 10682
    :cond_0
    iget v0, p0, Lcom/google/protobuf/DescriptorProtos$MessageOptions;->bitField0_:I

    and-int/lit8 v0, v0, 0x2

    if-ne v0, v3, :cond_1

    .line 10683
    iget-boolean v0, p0, Lcom/google/protobuf/DescriptorProtos$MessageOptions;->noStandardDescriptorAccessor_:Z

    invoke-virtual {p1, v3, v0}, Lcom/google/protobuf/CodedOutputStream;->writeBool(IZ)V

    .line 10685
    :cond_1
    const/4 v0, 0x0

    move v1, v0

    :goto_0
    iget-object v0, p0, Lcom/google/protobuf/DescriptorProtos$MessageOptions;->uninterpretedOption_:Ljava/util/List;

    invoke-interface {v0}, Ljava/util/List;->size()I

    move-result v0

    if-lt v1, v0, :cond_2

    .line 10688
    const/high16 v0, 0x20000000

    invoke-virtual {v2, v0, p1}, Lcom/google/protobuf/GeneratedMessage$ExtendableMessage$ExtensionWriter;->writeUntil(ILcom/google/protobuf/CodedOutputStream;)V

    .line 10689
    invoke-virtual {p0}, Lcom/google/protobuf/DescriptorProtos$MessageOptions;->getUnknownFields()Lcom/google/protobuf/UnknownFieldSet;

    move-result-object v0

    invoke-virtual {v0, p1}, Lcom/google/protobuf/UnknownFieldSet;->writeTo(Lcom/google/protobuf/CodedOutputStream;)V

    .line 10690
    return-void

    .line 10686
    :cond_2
    const/16 v3, 0x3e7

    iget-object v0, p0, Lcom/google/protobuf/DescriptorProtos$MessageOptions;->uninterpretedOption_:Ljava/util/List;

    invoke-interface {v0, v1}, Ljava/util/List;->get(I)Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Lcom/google/protobuf/MessageLite;

    invoke-virtual {p1, v3, v0}, Lcom/google/protobuf/CodedOutputStream;->writeMessage(ILcom/google/protobuf/MessageLite;)V

    .line 10685
    add-int/lit8 v0, v1, 0x1

    move v1, v0

    goto :goto_0
.end method
