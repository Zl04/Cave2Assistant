.class public final Lcom/google/protobuf/DescriptorProtos$FieldOptions;
.super Lcom/google/protobuf/GeneratedMessage$ExtendableMessage;
.source "SourceFile"

# interfaces
.implements Lcom/google/protobuf/DescriptorProtos$FieldOptionsOrBuilder;


# annotations
.annotation system Ldalvik/annotation/EnclosingClass;
    value = Lcom/google/protobuf/DescriptorProtos;
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x19
    name = "FieldOptions"
.end annotation

.annotation system Ldalvik/annotation/MemberClasses;
    value = {
        Lcom/google/protobuf/DescriptorProtos$FieldOptions$Builder;,
        Lcom/google/protobuf/DescriptorProtos$FieldOptions$CType;
    }
.end annotation

.annotation system Ldalvik/annotation/Signature;
    value = {
        "Lcom/google/protobuf/GeneratedMessage$ExtendableMessage",
        "<",
        "Lcom/google/protobuf/DescriptorProtos$FieldOptions;",
        ">;",
        "Lcom/google/protobuf/DescriptorProtos$FieldOptionsOrBuilder;"
    }
.end annotation


# static fields
.field public static final CTYPE_FIELD_NUMBER:I = 0x1

.field public static final DEPRECATED_FIELD_NUMBER:I = 0x3

.field public static final EXPERIMENTAL_MAP_KEY_FIELD_NUMBER:I = 0x9

.field public static final LAZY_FIELD_NUMBER:I = 0x5

.field public static final PACKED_FIELD_NUMBER:I = 0x2

.field public static final UNINTERPRETED_OPTION_FIELD_NUMBER:I = 0x3e7

.field public static final WEAK_FIELD_NUMBER:I = 0xa

.field private static final defaultInstance:Lcom/google/protobuf/DescriptorProtos$FieldOptions;

.field private static final serialVersionUID:J


# instance fields
.field private bitField0_:I

.field private ctype_:Lcom/google/protobuf/DescriptorProtos$FieldOptions$CType;

.field private deprecated_:Z

.field private experimentalMapKey_:Ljava/lang/Object;

.field private lazy_:Z

.field private memoizedIsInitialized:B

.field private memoizedSerializedSize:I

.field private packed_:Z

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

.field private weak_:Z


# direct methods
.method static constructor <clinit>()V
    .locals 2

    .prologue
    .line 12286
    new-instance v0, Lcom/google/protobuf/DescriptorProtos$FieldOptions;

    const/4 v1, 0x1

    invoke-direct {v0, v1}, Lcom/google/protobuf/DescriptorProtos$FieldOptions;-><init>(Z)V

    sput-object v0, Lcom/google/protobuf/DescriptorProtos$FieldOptions;->defaultInstance:Lcom/google/protobuf/DescriptorProtos$FieldOptions;

    .line 12287
    sget-object v0, Lcom/google/protobuf/DescriptorProtos$FieldOptions;->defaultInstance:Lcom/google/protobuf/DescriptorProtos$FieldOptions;

    invoke-direct {v0}, Lcom/google/protobuf/DescriptorProtos$FieldOptions;->initFields()V

    .line 11290
    return-void
.end method

.method private constructor <init>(Lcom/google/protobuf/DescriptorProtos$FieldOptions$Builder;)V
    .locals 1

    .prologue
    const/4 v0, -0x1

    .line 11295
    invoke-direct {p0, p1}, Lcom/google/protobuf/GeneratedMessage$ExtendableMessage;-><init>(Lcom/google/protobuf/GeneratedMessage$ExtendableBuilder;)V

    .line 11503
    iput-byte v0, p0, Lcom/google/protobuf/DescriptorProtos$FieldOptions;->memoizedIsInitialized:B

    .line 11553
    iput v0, p0, Lcom/google/protobuf/DescriptorProtos$FieldOptions;->memoizedSerializedSize:I

    .line 11296
    return-void
.end method

.method synthetic constructor <init>(Lcom/google/protobuf/DescriptorProtos$FieldOptions$Builder;Lcom/google/protobuf/DescriptorProtos$FieldOptions;)V
    .locals 0

    .prologue
    .line 11294
    invoke-direct {p0, p1}, Lcom/google/protobuf/DescriptorProtos$FieldOptions;-><init>(Lcom/google/protobuf/DescriptorProtos$FieldOptions$Builder;)V

    return-void
.end method

.method private constructor <init>(Z)V
    .locals 1

    .prologue
    const/4 v0, -0x1

    .line 11297
    invoke-direct {p0}, Lcom/google/protobuf/GeneratedMessage$ExtendableMessage;-><init>()V

    .line 11503
    iput-byte v0, p0, Lcom/google/protobuf/DescriptorProtos$FieldOptions;->memoizedIsInitialized:B

    .line 11553
    iput v0, p0, Lcom/google/protobuf/DescriptorProtos$FieldOptions;->memoizedSerializedSize:I

    .line 11297
    return-void
.end method

.method static synthetic access$10(Lcom/google/protobuf/DescriptorProtos$FieldOptions;Z)V
    .locals 0

    .prologue
    .line 11413
    iput-boolean p1, p0, Lcom/google/protobuf/DescriptorProtos$FieldOptions;->lazy_:Z

    return-void
.end method

.method static synthetic access$11(Lcom/google/protobuf/DescriptorProtos$FieldOptions;Z)V
    .locals 0

    .prologue
    .line 11423
    iput-boolean p1, p0, Lcom/google/protobuf/DescriptorProtos$FieldOptions;->deprecated_:Z

    return-void
.end method

.method static synthetic access$12(Lcom/google/protobuf/DescriptorProtos$FieldOptions;Ljava/lang/Object;)V
    .locals 0

    .prologue
    .line 11433
    iput-object p1, p0, Lcom/google/protobuf/DescriptorProtos$FieldOptions;->experimentalMapKey_:Ljava/lang/Object;

    return-void
.end method

.method static synthetic access$13(Lcom/google/protobuf/DescriptorProtos$FieldOptions;Z)V
    .locals 0

    .prologue
    .line 11465
    iput-boolean p1, p0, Lcom/google/protobuf/DescriptorProtos$FieldOptions;->weak_:Z

    return-void
.end method

.method static synthetic access$14(Lcom/google/protobuf/DescriptorProtos$FieldOptions;Ljava/util/List;)V
    .locals 0

    .prologue
    .line 11475
    iput-object p1, p0, Lcom/google/protobuf/DescriptorProtos$FieldOptions;->uninterpretedOption_:Ljava/util/List;

    return-void
.end method

.method static synthetic access$15(Lcom/google/protobuf/DescriptorProtos$FieldOptions;I)V
    .locals 0

    .prologue
    .line 11390
    iput p1, p0, Lcom/google/protobuf/DescriptorProtos$FieldOptions;->bitField0_:I

    return-void
.end method

.method static synthetic access$16(Lcom/google/protobuf/DescriptorProtos$FieldOptions;)Ljava/util/List;
    .locals 1

    .prologue
    .line 11475
    iget-object v0, p0, Lcom/google/protobuf/DescriptorProtos$FieldOptions;->uninterpretedOption_:Ljava/util/List;

    return-object v0
.end method

.method static synthetic access$8(Lcom/google/protobuf/DescriptorProtos$FieldOptions;Lcom/google/protobuf/DescriptorProtos$FieldOptions$CType;)V
    .locals 0

    .prologue
    .line 11393
    iput-object p1, p0, Lcom/google/protobuf/DescriptorProtos$FieldOptions;->ctype_:Lcom/google/protobuf/DescriptorProtos$FieldOptions$CType;

    return-void
.end method

.method static synthetic access$9(Lcom/google/protobuf/DescriptorProtos$FieldOptions;Z)V
    .locals 0

    .prologue
    .line 11403
    iput-boolean p1, p0, Lcom/google/protobuf/DescriptorProtos$FieldOptions;->packed_:Z

    return-void
.end method

.method public static getDefaultInstance()Lcom/google/protobuf/DescriptorProtos$FieldOptions;
    .locals 1

    .prologue
    .line 11301
    sget-object v0, Lcom/google/protobuf/DescriptorProtos$FieldOptions;->defaultInstance:Lcom/google/protobuf/DescriptorProtos$FieldOptions;

    return-object v0
.end method

.method public static final getDescriptor()Lcom/google/protobuf/Descriptors$Descriptor;
    .locals 1

    .prologue
    .line 11310
    invoke-static {}, Lcom/google/protobuf/DescriptorProtos;->access$35()Lcom/google/protobuf/Descriptors$Descriptor;

    move-result-object v0

    return-object v0
.end method

.method private getExperimentalMapKeyBytes()Lcom/google/protobuf/ByteString;
    .locals 2

    .prologue
    .line 11452
    iget-object v0, p0, Lcom/google/protobuf/DescriptorProtos$FieldOptions;->experimentalMapKey_:Ljava/lang/Object;

    .line 11453
    instance-of v1, v0, Ljava/lang/String;

    if-eqz v1, :cond_0

    .line 11455
    check-cast v0, Ljava/lang/String;

    invoke-static {v0}, Lcom/google/protobuf/ByteString;->copyFromUtf8(Ljava/lang/String;)Lcom/google/protobuf/ByteString;

    move-result-object v0

    .line 11456
    iput-object v0, p0, Lcom/google/protobuf/DescriptorProtos$FieldOptions;->experimentalMapKey_:Ljava/lang/Object;

    .line 11459
    :goto_0
    return-object v0

    :cond_0
    check-cast v0, Lcom/google/protobuf/ByteString;

    goto :goto_0
.end method

.method private initFields()V
    .locals 2

    .prologue
    const/4 v1, 0x0

    .line 11495
    sget-object v0, Lcom/google/protobuf/DescriptorProtos$FieldOptions$CType;->STRING:Lcom/google/protobuf/DescriptorProtos$FieldOptions$CType;

    iput-object v0, p0, Lcom/google/protobuf/DescriptorProtos$FieldOptions;->ctype_:Lcom/google/protobuf/DescriptorProtos$FieldOptions$CType;

    .line 11496
    iput-boolean v1, p0, Lcom/google/protobuf/DescriptorProtos$FieldOptions;->packed_:Z

    .line 11497
    iput-boolean v1, p0, Lcom/google/protobuf/DescriptorProtos$FieldOptions;->lazy_:Z

    .line 11498
    iput-boolean v1, p0, Lcom/google/protobuf/DescriptorProtos$FieldOptions;->deprecated_:Z

    .line 11499
    const-string v0, ""

    iput-object v0, p0, Lcom/google/protobuf/DescriptorProtos$FieldOptions;->experimentalMapKey_:Ljava/lang/Object;

    .line 11500
    iput-boolean v1, p0, Lcom/google/protobuf/DescriptorProtos$FieldOptions;->weak_:Z

    .line 11501
    invoke-static {}, Ljava/util/Collections;->emptyList()Ljava/util/List;

    move-result-object v0

    iput-object v0, p0, Lcom/google/protobuf/DescriptorProtos$FieldOptions;->uninterpretedOption_:Ljava/util/List;

    .line 11502
    return-void
.end method

.method public static newBuilder()Lcom/google/protobuf/DescriptorProtos$FieldOptions$Builder;
    .locals 1

    .prologue
    .line 11667
    invoke-static {}, Lcom/google/protobuf/DescriptorProtos$FieldOptions$Builder;->access$18()Lcom/google/protobuf/DescriptorProtos$FieldOptions$Builder;

    move-result-object v0

    return-object v0
.end method

.method public static newBuilder(Lcom/google/protobuf/DescriptorProtos$FieldOptions;)Lcom/google/protobuf/DescriptorProtos$FieldOptions$Builder;
    .locals 1

    .prologue
    .line 11670
    invoke-static {}, Lcom/google/protobuf/DescriptorProtos$FieldOptions;->newBuilder()Lcom/google/protobuf/DescriptorProtos$FieldOptions$Builder;

    move-result-object v0

    invoke-virtual {v0, p0}, Lcom/google/protobuf/DescriptorProtos$FieldOptions$Builder;->mergeFrom(Lcom/google/protobuf/DescriptorProtos$FieldOptions;)Lcom/google/protobuf/DescriptorProtos$FieldOptions$Builder;

    move-result-object v0

    return-object v0
.end method

.method public static parseDelimitedFrom(Ljava/io/InputStream;)Lcom/google/protobuf/DescriptorProtos$FieldOptions;
    .locals 2
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljava/io/IOException;
        }
    .end annotation

    .prologue
    .line 11636
    invoke-static {}, Lcom/google/protobuf/DescriptorProtos$FieldOptions;->newBuilder()Lcom/google/protobuf/DescriptorProtos$FieldOptions$Builder;

    move-result-object v0

    .line 11637
    invoke-virtual {v0, p0}, Lcom/google/protobuf/DescriptorProtos$FieldOptions$Builder;->mergeDelimitedFrom(Ljava/io/InputStream;)Z

    move-result v1

    if-eqz v1, :cond_0

    .line 11638
    invoke-static {v0}, Lcom/google/protobuf/DescriptorProtos$FieldOptions$Builder;->access$17(Lcom/google/protobuf/DescriptorProtos$FieldOptions$Builder;)Lcom/google/protobuf/DescriptorProtos$FieldOptions;

    move-result-object v0

    .line 11640
    :goto_0
    return-object v0

    :cond_0
    const/4 v0, 0x0

    goto :goto_0
.end method

.method public static parseDelimitedFrom(Ljava/io/InputStream;Lcom/google/protobuf/ExtensionRegistryLite;)Lcom/google/protobuf/DescriptorProtos$FieldOptions;
    .locals 2
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljava/io/IOException;
        }
    .end annotation

    .prologue
    .line 11647
    invoke-static {}, Lcom/google/protobuf/DescriptorProtos$FieldOptions;->newBuilder()Lcom/google/protobuf/DescriptorProtos$FieldOptions$Builder;

    move-result-object v0

    .line 11648
    invoke-virtual {v0, p0, p1}, Lcom/google/protobuf/DescriptorProtos$FieldOptions$Builder;->mergeDelimitedFrom(Ljava/io/InputStream;Lcom/google/protobuf/ExtensionRegistryLite;)Z

    move-result v1

    if-eqz v1, :cond_0

    .line 11649
    invoke-static {v0}, Lcom/google/protobuf/DescriptorProtos$FieldOptions$Builder;->access$17(Lcom/google/protobuf/DescriptorProtos$FieldOptions$Builder;)Lcom/google/protobuf/DescriptorProtos$FieldOptions;

    move-result-object v0

    .line 11651
    :goto_0
    return-object v0

    :cond_0
    const/4 v0, 0x0

    goto :goto_0
.end method

.method public static parseFrom(Lcom/google/protobuf/ByteString;)Lcom/google/protobuf/DescriptorProtos$FieldOptions;
    .locals 1
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Lcom/google/protobuf/InvalidProtocolBufferException;
        }
    .end annotation

    .prologue
    .line 11603
    invoke-static {}, Lcom/google/protobuf/DescriptorProtos$FieldOptions;->newBuilder()Lcom/google/protobuf/DescriptorProtos$FieldOptions$Builder;

    move-result-object v0

    invoke-virtual {v0, p0}, Lcom/google/protobuf/DescriptorProtos$FieldOptions$Builder;->mergeFrom(Lcom/google/protobuf/ByteString;)Lcom/google/protobuf/AbstractMessage$Builder;

    move-result-object v0

    check-cast v0, Lcom/google/protobuf/DescriptorProtos$FieldOptions$Builder;

    invoke-static {v0}, Lcom/google/protobuf/DescriptorProtos$FieldOptions$Builder;->access$17(Lcom/google/protobuf/DescriptorProtos$FieldOptions$Builder;)Lcom/google/protobuf/DescriptorProtos$FieldOptions;

    move-result-object v0

    return-object v0
.end method

.method public static parseFrom(Lcom/google/protobuf/ByteString;Lcom/google/protobuf/ExtensionRegistryLite;)Lcom/google/protobuf/DescriptorProtos$FieldOptions;
    .locals 1
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Lcom/google/protobuf/InvalidProtocolBufferException;
        }
    .end annotation

    .prologue
    .line 11609
    invoke-static {}, Lcom/google/protobuf/DescriptorProtos$FieldOptions;->newBuilder()Lcom/google/protobuf/DescriptorProtos$FieldOptions$Builder;

    move-result-object v0

    invoke-virtual {v0, p0, p1}, Lcom/google/protobuf/DescriptorProtos$FieldOptions$Builder;->mergeFrom(Lcom/google/protobuf/ByteString;Lcom/google/protobuf/ExtensionRegistryLite;)Lcom/google/protobuf/AbstractMessage$Builder;

    move-result-object v0

    check-cast v0, Lcom/google/protobuf/DescriptorProtos$FieldOptions$Builder;

    .line 11610
    invoke-static {v0}, Lcom/google/protobuf/DescriptorProtos$FieldOptions$Builder;->access$17(Lcom/google/protobuf/DescriptorProtos$FieldOptions$Builder;)Lcom/google/protobuf/DescriptorProtos$FieldOptions;

    move-result-object v0

    .line 11609
    return-object v0
.end method

.method public static parseFrom(Lcom/google/protobuf/CodedInputStream;)Lcom/google/protobuf/DescriptorProtos$FieldOptions;
    .locals 1
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljava/io/IOException;
        }
    .end annotation

    .prologue
    .line 11657
    invoke-static {}, Lcom/google/protobuf/DescriptorProtos$FieldOptions;->newBuilder()Lcom/google/protobuf/DescriptorProtos$FieldOptions$Builder;

    move-result-object v0

    invoke-virtual {v0, p0}, Lcom/google/protobuf/DescriptorProtos$FieldOptions$Builder;->mergeFrom(Lcom/google/protobuf/CodedInputStream;)Lcom/google/protobuf/AbstractMessage$Builder;

    move-result-object v0

    check-cast v0, Lcom/google/protobuf/DescriptorProtos$FieldOptions$Builder;

    invoke-static {v0}, Lcom/google/protobuf/DescriptorProtos$FieldOptions$Builder;->access$17(Lcom/google/protobuf/DescriptorProtos$FieldOptions$Builder;)Lcom/google/protobuf/DescriptorProtos$FieldOptions;

    move-result-object v0

    return-object v0
.end method

.method public static parseFrom(Lcom/google/protobuf/CodedInputStream;Lcom/google/protobuf/ExtensionRegistryLite;)Lcom/google/protobuf/DescriptorProtos$FieldOptions;
    .locals 1
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljava/io/IOException;
        }
    .end annotation

    .prologue
    .line 11663
    invoke-static {}, Lcom/google/protobuf/DescriptorProtos$FieldOptions;->newBuilder()Lcom/google/protobuf/DescriptorProtos$FieldOptions$Builder;

    move-result-object v0

    invoke-virtual {v0, p0, p1}, Lcom/google/protobuf/DescriptorProtos$FieldOptions$Builder;->mergeFrom(Lcom/google/protobuf/CodedInputStream;Lcom/google/protobuf/ExtensionRegistryLite;)Lcom/google/protobuf/DescriptorProtos$FieldOptions$Builder;

    move-result-object v0

    .line 11664
    invoke-static {v0}, Lcom/google/protobuf/DescriptorProtos$FieldOptions$Builder;->access$17(Lcom/google/protobuf/DescriptorProtos$FieldOptions$Builder;)Lcom/google/protobuf/DescriptorProtos$FieldOptions;

    move-result-object v0

    .line 11663
    return-object v0
.end method

.method public static parseFrom(Ljava/io/InputStream;)Lcom/google/protobuf/DescriptorProtos$FieldOptions;
    .locals 1
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljava/io/IOException;
        }
    .end annotation

    .prologue
    .line 11625
    invoke-static {}, Lcom/google/protobuf/DescriptorProtos$FieldOptions;->newBuilder()Lcom/google/protobuf/DescriptorProtos$FieldOptions$Builder;

    move-result-object v0

    invoke-virtual {v0, p0}, Lcom/google/protobuf/DescriptorProtos$FieldOptions$Builder;->mergeFrom(Ljava/io/InputStream;)Lcom/google/protobuf/AbstractMessage$Builder;

    move-result-object v0

    check-cast v0, Lcom/google/protobuf/DescriptorProtos$FieldOptions$Builder;

    invoke-static {v0}, Lcom/google/protobuf/DescriptorProtos$FieldOptions$Builder;->access$17(Lcom/google/protobuf/DescriptorProtos$FieldOptions$Builder;)Lcom/google/protobuf/DescriptorProtos$FieldOptions;

    move-result-object v0

    return-object v0
.end method

.method public static parseFrom(Ljava/io/InputStream;Lcom/google/protobuf/ExtensionRegistryLite;)Lcom/google/protobuf/DescriptorProtos$FieldOptions;
    .locals 1
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljava/io/IOException;
        }
    .end annotation

    .prologue
    .line 11631
    invoke-static {}, Lcom/google/protobuf/DescriptorProtos$FieldOptions;->newBuilder()Lcom/google/protobuf/DescriptorProtos$FieldOptions$Builder;

    move-result-object v0

    invoke-virtual {v0, p0, p1}, Lcom/google/protobuf/DescriptorProtos$FieldOptions$Builder;->mergeFrom(Ljava/io/InputStream;Lcom/google/protobuf/ExtensionRegistryLite;)Lcom/google/protobuf/AbstractMessage$Builder;

    move-result-object v0

    check-cast v0, Lcom/google/protobuf/DescriptorProtos$FieldOptions$Builder;

    .line 11632
    invoke-static {v0}, Lcom/google/protobuf/DescriptorProtos$FieldOptions$Builder;->access$17(Lcom/google/protobuf/DescriptorProtos$FieldOptions$Builder;)Lcom/google/protobuf/DescriptorProtos$FieldOptions;

    move-result-object v0

    .line 11631
    return-object v0
.end method

.method public static parseFrom([B)Lcom/google/protobuf/DescriptorProtos$FieldOptions;
    .locals 1
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Lcom/google/protobuf/InvalidProtocolBufferException;
        }
    .end annotation

    .prologue
    .line 11614
    invoke-static {}, Lcom/google/protobuf/DescriptorProtos$FieldOptions;->newBuilder()Lcom/google/protobuf/DescriptorProtos$FieldOptions$Builder;

    move-result-object v0

    invoke-virtual {v0, p0}, Lcom/google/protobuf/DescriptorProtos$FieldOptions$Builder;->mergeFrom([B)Lcom/google/protobuf/AbstractMessage$Builder;

    move-result-object v0

    check-cast v0, Lcom/google/protobuf/DescriptorProtos$FieldOptions$Builder;

    invoke-static {v0}, Lcom/google/protobuf/DescriptorProtos$FieldOptions$Builder;->access$17(Lcom/google/protobuf/DescriptorProtos$FieldOptions$Builder;)Lcom/google/protobuf/DescriptorProtos$FieldOptions;

    move-result-object v0

    return-object v0
.end method

.method public static parseFrom([BLcom/google/protobuf/ExtensionRegistryLite;)Lcom/google/protobuf/DescriptorProtos$FieldOptions;
    .locals 1
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Lcom/google/protobuf/InvalidProtocolBufferException;
        }
    .end annotation

    .prologue
    .line 11620
    invoke-static {}, Lcom/google/protobuf/DescriptorProtos$FieldOptions;->newBuilder()Lcom/google/protobuf/DescriptorProtos$FieldOptions$Builder;

    move-result-object v0

    invoke-virtual {v0, p0, p1}, Lcom/google/protobuf/DescriptorProtos$FieldOptions$Builder;->mergeFrom([BLcom/google/protobuf/ExtensionRegistryLite;)Lcom/google/protobuf/AbstractMessage$Builder;

    move-result-object v0

    check-cast v0, Lcom/google/protobuf/DescriptorProtos$FieldOptions$Builder;

    .line 11621
    invoke-static {v0}, Lcom/google/protobuf/DescriptorProtos$FieldOptions$Builder;->access$17(Lcom/google/protobuf/DescriptorProtos$FieldOptions$Builder;)Lcom/google/protobuf/DescriptorProtos$FieldOptions;

    move-result-object v0

    .line 11620
    return-object v0
.end method


# virtual methods
.method public getCtype()Lcom/google/protobuf/DescriptorProtos$FieldOptions$CType;
    .locals 1

    .prologue
    .line 11398
    iget-object v0, p0, Lcom/google/protobuf/DescriptorProtos$FieldOptions;->ctype_:Lcom/google/protobuf/DescriptorProtos$FieldOptions$CType;

    return-object v0
.end method

.method public getDefaultInstanceForType()Lcom/google/protobuf/DescriptorProtos$FieldOptions;
    .locals 1

    .prologue
    .line 11305
    sget-object v0, Lcom/google/protobuf/DescriptorProtos$FieldOptions;->defaultInstance:Lcom/google/protobuf/DescriptorProtos$FieldOptions;

    return-object v0
.end method

.method public bridge synthetic getDefaultInstanceForType()Lcom/google/protobuf/Message;
    .locals 1

    .prologue
    .line 1
    invoke-virtual {p0}, Lcom/google/protobuf/DescriptorProtos$FieldOptions;->getDefaultInstanceForType()Lcom/google/protobuf/DescriptorProtos$FieldOptions;

    move-result-object v0

    return-object v0
.end method

.method public bridge synthetic getDefaultInstanceForType()Lcom/google/protobuf/MessageLite;
    .locals 1

    .prologue
    .line 1
    invoke-virtual {p0}, Lcom/google/protobuf/DescriptorProtos$FieldOptions;->getDefaultInstanceForType()Lcom/google/protobuf/DescriptorProtos$FieldOptions;

    move-result-object v0

    return-object v0
.end method

.method public getDeprecated()Z
    .locals 1

    .prologue
    .line 11428
    iget-boolean v0, p0, Lcom/google/protobuf/DescriptorProtos$FieldOptions;->deprecated_:Z

    return v0
.end method

.method public getExperimentalMapKey()Ljava/lang/String;
    .locals 2

    .prologue
    .line 11438
    iget-object v0, p0, Lcom/google/protobuf/DescriptorProtos$FieldOptions;->experimentalMapKey_:Ljava/lang/Object;

    .line 11439
    instance-of v1, v0, Ljava/lang/String;

    if-eqz v1, :cond_0

    .line 11440
    check-cast v0, Ljava/lang/String;

    .line 11448
    :goto_0
    return-object v0

    .line 11443
    :cond_0
    check-cast v0, Lcom/google/protobuf/ByteString;

    .line 11444
    invoke-virtual {v0}, Lcom/google/protobuf/ByteString;->toStringUtf8()Ljava/lang/String;

    move-result-object v1

    .line 11445
    invoke-static {v0}, Lcom/google/protobuf/Internal;->isValidUtf8(Lcom/google/protobuf/ByteString;)Z

    move-result v0

    if-eqz v0, :cond_1

    .line 11446
    iput-object v1, p0, Lcom/google/protobuf/DescriptorProtos$FieldOptions;->experimentalMapKey_:Ljava/lang/Object;

    :cond_1
    move-object v0, v1

    .line 11448
    goto :goto_0
.end method

.method public getLazy()Z
    .locals 1

    .prologue
    .line 11418
    iget-boolean v0, p0, Lcom/google/protobuf/DescriptorProtos$FieldOptions;->lazy_:Z

    return v0
.end method

.method public getPacked()Z
    .locals 1

    .prologue
    .line 11408
    iget-boolean v0, p0, Lcom/google/protobuf/DescriptorProtos$FieldOptions;->packed_:Z

    return v0
.end method

.method public getSerializedSize()I
    .locals 5

    .prologue
    const/4 v4, 0x2

    const/4 v3, 0x1

    const/4 v1, 0x0

    .line 11555
    iget v0, p0, Lcom/google/protobuf/DescriptorProtos$FieldOptions;->memoizedSerializedSize:I

    .line 11556
    const/4 v2, -0x1

    if-eq v0, v2, :cond_0

    .line 11590
    :goto_0
    return v0

    .line 11559
    :cond_0
    iget v0, p0, Lcom/google/protobuf/DescriptorProtos$FieldOptions;->bitField0_:I

    and-int/lit8 v0, v0, 0x1

    if-ne v0, v3, :cond_7

    .line 11561
    iget-object v0, p0, Lcom/google/protobuf/DescriptorProtos$FieldOptions;->ctype_:Lcom/google/protobuf/DescriptorProtos$FieldOptions$CType;

    invoke-virtual {v0}, Lcom/google/protobuf/DescriptorProtos$FieldOptions$CType;->getNumber()I

    move-result v0

    invoke-static {v3, v0}, Lcom/google/protobuf/CodedOutputStream;->computeEnumSize(II)I

    move-result v0

    add-int/2addr v0, v1

    .line 11563
    :goto_1
    iget v2, p0, Lcom/google/protobuf/DescriptorProtos$FieldOptions;->bitField0_:I

    and-int/lit8 v2, v2, 0x2

    if-ne v2, v4, :cond_1

    .line 11565
    iget-boolean v2, p0, Lcom/google/protobuf/DescriptorProtos$FieldOptions;->packed_:Z

    invoke-static {v4, v2}, Lcom/google/protobuf/CodedOutputStream;->computeBoolSize(IZ)I

    move-result v2

    add-int/2addr v0, v2

    .line 11567
    :cond_1
    iget v2, p0, Lcom/google/protobuf/DescriptorProtos$FieldOptions;->bitField0_:I

    and-int/lit8 v2, v2, 0x8

    const/16 v3, 0x8

    if-ne v2, v3, :cond_2

    .line 11569
    const/4 v2, 0x3

    iget-boolean v3, p0, Lcom/google/protobuf/DescriptorProtos$FieldOptions;->deprecated_:Z

    invoke-static {v2, v3}, Lcom/google/protobuf/CodedOutputStream;->computeBoolSize(IZ)I

    move-result v2

    add-int/2addr v0, v2

    .line 11571
    :cond_2
    iget v2, p0, Lcom/google/protobuf/DescriptorProtos$FieldOptions;->bitField0_:I

    and-int/lit8 v2, v2, 0x4

    const/4 v3, 0x4

    if-ne v2, v3, :cond_3

    .line 11573
    const/4 v2, 0x5

    iget-boolean v3, p0, Lcom/google/protobuf/DescriptorProtos$FieldOptions;->lazy_:Z

    invoke-static {v2, v3}, Lcom/google/protobuf/CodedOutputStream;->computeBoolSize(IZ)I

    move-result v2

    add-int/2addr v0, v2

    .line 11575
    :cond_3
    iget v2, p0, Lcom/google/protobuf/DescriptorProtos$FieldOptions;->bitField0_:I

    and-int/lit8 v2, v2, 0x10

    const/16 v3, 0x10

    if-ne v2, v3, :cond_4

    .line 11577
    const/16 v2, 0x9

    invoke-direct {p0}, Lcom/google/protobuf/DescriptorProtos$FieldOptions;->getExperimentalMapKeyBytes()Lcom/google/protobuf/ByteString;

    move-result-object v3

    invoke-static {v2, v3}, Lcom/google/protobuf/CodedOutputStream;->computeBytesSize(ILcom/google/protobuf/ByteString;)I

    move-result v2

    add-int/2addr v0, v2

    .line 11579
    :cond_4
    iget v2, p0, Lcom/google/protobuf/DescriptorProtos$FieldOptions;->bitField0_:I

    and-int/lit8 v2, v2, 0x20

    const/16 v3, 0x20

    if-ne v2, v3, :cond_5

    .line 11581
    const/16 v2, 0xa

    iget-boolean v3, p0, Lcom/google/protobuf/DescriptorProtos$FieldOptions;->weak_:Z

    invoke-static {v2, v3}, Lcom/google/protobuf/CodedOutputStream;->computeBoolSize(IZ)I

    move-result v2

    add-int/2addr v0, v2

    :cond_5
    move v2, v0

    .line 11583
    :goto_2
    iget-object v0, p0, Lcom/google/protobuf/DescriptorProtos$FieldOptions;->uninterpretedOption_:Ljava/util/List;

    invoke-interface {v0}, Ljava/util/List;->size()I

    move-result v0

    if-lt v1, v0, :cond_6

    .line 11587
    invoke-virtual {p0}, Lcom/google/protobuf/DescriptorProtos$FieldOptions;->extensionsSerializedSize()I

    move-result v0

    add-int/2addr v0, v2

    .line 11588
    invoke-virtual {p0}, Lcom/google/protobuf/DescriptorProtos$FieldOptions;->getUnknownFields()Lcom/google/protobuf/UnknownFieldSet;

    move-result-object v1

    invoke-virtual {v1}, Lcom/google/protobuf/UnknownFieldSet;->getSerializedSize()I

    move-result v1

    add-int/2addr v0, v1

    .line 11589
    iput v0, p0, Lcom/google/protobuf/DescriptorProtos$FieldOptions;->memoizedSerializedSize:I

    goto :goto_0

    .line 11585
    :cond_6
    const/16 v3, 0x3e7

    iget-object v0, p0, Lcom/google/protobuf/DescriptorProtos$FieldOptions;->uninterpretedOption_:Ljava/util/List;

    invoke-interface {v0, v1}, Ljava/util/List;->get(I)Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Lcom/google/protobuf/MessageLite;

    invoke-static {v3, v0}, Lcom/google/protobuf/CodedOutputStream;->computeMessageSize(ILcom/google/protobuf/MessageLite;)I

    move-result v0

    add-int/2addr v0, v2

    .line 11583
    add-int/lit8 v1, v1, 0x1

    move v2, v0

    goto :goto_2

    :cond_7
    move v0, v1

    goto :goto_1
.end method

.method public getUninterpretedOption(I)Lcom/google/protobuf/DescriptorProtos$UninterpretedOption;
    .locals 1

    .prologue
    .line 11487
    iget-object v0, p0, Lcom/google/protobuf/DescriptorProtos$FieldOptions;->uninterpretedOption_:Ljava/util/List;

    invoke-interface {v0, p1}, Ljava/util/List;->get(I)Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Lcom/google/protobuf/DescriptorProtos$UninterpretedOption;

    return-object v0
.end method

.method public getUninterpretedOptionCount()I
    .locals 1

    .prologue
    .line 11484
    iget-object v0, p0, Lcom/google/protobuf/DescriptorProtos$FieldOptions;->uninterpretedOption_:Ljava/util/List;

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
    .line 11477
    iget-object v0, p0, Lcom/google/protobuf/DescriptorProtos$FieldOptions;->uninterpretedOption_:Ljava/util/List;

    return-object v0
.end method

.method public getUninterpretedOptionOrBuilder(I)Lcom/google/protobuf/DescriptorProtos$UninterpretedOptionOrBuilder;
    .locals 1

    .prologue
    .line 11491
    iget-object v0, p0, Lcom/google/protobuf/DescriptorProtos$FieldOptions;->uninterpretedOption_:Ljava/util/List;

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
    .line 11481
    iget-object v0, p0, Lcom/google/protobuf/DescriptorProtos$FieldOptions;->uninterpretedOption_:Ljava/util/List;

    return-object v0
.end method

.method public getWeak()Z
    .locals 1

    .prologue
    .line 11470
    iget-boolean v0, p0, Lcom/google/protobuf/DescriptorProtos$FieldOptions;->weak_:Z

    return v0
.end method

.method public hasCtype()Z
    .locals 2

    .prologue
    const/4 v0, 0x1

    .line 11395
    iget v1, p0, Lcom/google/protobuf/DescriptorProtos$FieldOptions;->bitField0_:I

    and-int/lit8 v1, v1, 0x1

    if-ne v1, v0, :cond_0

    :goto_0
    return v0

    :cond_0
    const/4 v0, 0x0

    goto :goto_0
.end method

.method public hasDeprecated()Z
    .locals 2

    .prologue
    .line 11425
    iget v0, p0, Lcom/google/protobuf/DescriptorProtos$FieldOptions;->bitField0_:I

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

.method public hasExperimentalMapKey()Z
    .locals 2

    .prologue
    .line 11435
    iget v0, p0, Lcom/google/protobuf/DescriptorProtos$FieldOptions;->bitField0_:I

    and-int/lit8 v0, v0, 0x10

    const/16 v1, 0x10

    if-ne v0, v1, :cond_0

    const/4 v0, 0x1

    :goto_0
    return v0

    :cond_0
    const/4 v0, 0x0

    goto :goto_0
.end method

.method public hasLazy()Z
    .locals 2

    .prologue
    .line 11415
    iget v0, p0, Lcom/google/protobuf/DescriptorProtos$FieldOptions;->bitField0_:I

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

.method public hasPacked()Z
    .locals 2

    .prologue
    .line 11405
    iget v0, p0, Lcom/google/protobuf/DescriptorProtos$FieldOptions;->bitField0_:I

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

.method public hasWeak()Z
    .locals 2

    .prologue
    .line 11467
    iget v0, p0, Lcom/google/protobuf/DescriptorProtos$FieldOptions;->bitField0_:I

    and-int/lit8 v0, v0, 0x20

    const/16 v1, 0x20

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
    .line 11315
    invoke-static {}, Lcom/google/protobuf/DescriptorProtos;->access$72()Lcom/google/protobuf/GeneratedMessage$FieldAccessorTable;

    move-result-object v0

    return-object v0
.end method

.method public final isInitialized()Z
    .locals 4

    .prologue
    const/4 v2, 0x1

    const/4 v1, 0x0

    .line 11505
    iget-byte v0, p0, Lcom/google/protobuf/DescriptorProtos$FieldOptions;->memoizedIsInitialized:B

    .line 11506
    const/4 v3, -0x1

    if-eq v0, v3, :cond_1

    if-ne v0, v2, :cond_0

    move v1, v2

    .line 11519
    :cond_0
    :goto_0
    return v1

    :cond_1
    move v0, v1

    .line 11508
    :goto_1
    invoke-virtual {p0}, Lcom/google/protobuf/DescriptorProtos$FieldOptions;->getUninterpretedOptionCount()I

    move-result v3

    if-lt v0, v3, :cond_2

    .line 11514
    invoke-virtual {p0}, Lcom/google/protobuf/DescriptorProtos$FieldOptions;->extensionsAreInitialized()Z

    move-result v0

    if-nez v0, :cond_4

    .line 11515
    iput-byte v1, p0, Lcom/google/protobuf/DescriptorProtos$FieldOptions;->memoizedIsInitialized:B

    goto :goto_0

    .line 11509
    :cond_2
    invoke-virtual {p0, v0}, Lcom/google/protobuf/DescriptorProtos$FieldOptions;->getUninterpretedOption(I)Lcom/google/protobuf/DescriptorProtos$UninterpretedOption;

    move-result-object v3

    invoke-virtual {v3}, Lcom/google/protobuf/DescriptorProtos$UninterpretedOption;->isInitialized()Z

    move-result v3

    if-nez v3, :cond_3

    .line 11510
    iput-byte v1, p0, Lcom/google/protobuf/DescriptorProtos$FieldOptions;->memoizedIsInitialized:B

    goto :goto_0

    .line 11508
    :cond_3
    add-int/lit8 v0, v0, 0x1

    goto :goto_1

    .line 11518
    :cond_4
    iput-byte v2, p0, Lcom/google/protobuf/DescriptorProtos$FieldOptions;->memoizedIsInitialized:B

    move v1, v2

    .line 11519
    goto :goto_0
.end method

.method public newBuilderForType()Lcom/google/protobuf/DescriptorProtos$FieldOptions$Builder;
    .locals 1

    .prologue
    .line 11668
    invoke-static {}, Lcom/google/protobuf/DescriptorProtos$FieldOptions;->newBuilder()Lcom/google/protobuf/DescriptorProtos$FieldOptions$Builder;

    move-result-object v0

    return-object v0
.end method

.method protected newBuilderForType(Lcom/google/protobuf/GeneratedMessage$BuilderParent;)Lcom/google/protobuf/DescriptorProtos$FieldOptions$Builder;
    .locals 2

    .prologue
    .line 11677
    new-instance v0, Lcom/google/protobuf/DescriptorProtos$FieldOptions$Builder;

    const/4 v1, 0x0

    invoke-direct {v0, p1, v1}, Lcom/google/protobuf/DescriptorProtos$FieldOptions$Builder;-><init>(Lcom/google/protobuf/GeneratedMessage$BuilderParent;Lcom/google/protobuf/DescriptorProtos$FieldOptions$Builder;)V

    .line 11678
    return-object v0
.end method

.method public bridge synthetic newBuilderForType()Lcom/google/protobuf/Message$Builder;
    .locals 1

    .prologue
    .line 1
    invoke-virtual {p0}, Lcom/google/protobuf/DescriptorProtos$FieldOptions;->newBuilderForType()Lcom/google/protobuf/DescriptorProtos$FieldOptions$Builder;

    move-result-object v0

    return-object v0
.end method

.method protected bridge synthetic newBuilderForType(Lcom/google/protobuf/GeneratedMessage$BuilderParent;)Lcom/google/protobuf/Message$Builder;
    .locals 1

    .prologue
    .line 1
    invoke-virtual {p0, p1}, Lcom/google/protobuf/DescriptorProtos$FieldOptions;->newBuilderForType(Lcom/google/protobuf/GeneratedMessage$BuilderParent;)Lcom/google/protobuf/DescriptorProtos$FieldOptions$Builder;

    move-result-object v0

    return-object v0
.end method

.method public bridge synthetic newBuilderForType()Lcom/google/protobuf/MessageLite$Builder;
    .locals 1

    .prologue
    .line 1
    invoke-virtual {p0}, Lcom/google/protobuf/DescriptorProtos$FieldOptions;->newBuilderForType()Lcom/google/protobuf/DescriptorProtos$FieldOptions$Builder;

    move-result-object v0

    return-object v0
.end method

.method public toBuilder()Lcom/google/protobuf/DescriptorProtos$FieldOptions$Builder;
    .locals 1

    .prologue
    .line 11672
    invoke-static {p0}, Lcom/google/protobuf/DescriptorProtos$FieldOptions;->newBuilder(Lcom/google/protobuf/DescriptorProtos$FieldOptions;)Lcom/google/protobuf/DescriptorProtos$FieldOptions$Builder;

    move-result-object v0

    return-object v0
.end method

.method public bridge synthetic toBuilder()Lcom/google/protobuf/Message$Builder;
    .locals 1

    .prologue
    .line 1
    invoke-virtual {p0}, Lcom/google/protobuf/DescriptorProtos$FieldOptions;->toBuilder()Lcom/google/protobuf/DescriptorProtos$FieldOptions$Builder;

    move-result-object v0

    return-object v0
.end method

.method public bridge synthetic toBuilder()Lcom/google/protobuf/MessageLite$Builder;
    .locals 1

    .prologue
    .line 1
    invoke-virtual {p0}, Lcom/google/protobuf/DescriptorProtos$FieldOptions;->toBuilder()Lcom/google/protobuf/DescriptorProtos$FieldOptions$Builder;

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
    .line 11597
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

    .line 11524
    invoke-virtual {p0}, Lcom/google/protobuf/DescriptorProtos$FieldOptions;->getSerializedSize()I

    .line 11527
    invoke-virtual {p0}, Lcom/google/protobuf/DescriptorProtos$FieldOptions;->newExtensionWriter()Lcom/google/protobuf/GeneratedMessage$ExtendableMessage$ExtensionWriter;

    move-result-object v2

    .line 11528
    iget v0, p0, Lcom/google/protobuf/DescriptorProtos$FieldOptions;->bitField0_:I

    and-int/lit8 v0, v0, 0x1

    if-ne v0, v1, :cond_0

    .line 11529
    iget-object v0, p0, Lcom/google/protobuf/DescriptorProtos$FieldOptions;->ctype_:Lcom/google/protobuf/DescriptorProtos$FieldOptions$CType;

    invoke-virtual {v0}, Lcom/google/protobuf/DescriptorProtos$FieldOptions$CType;->getNumber()I

    move-result v0

    invoke-virtual {p1, v1, v0}, Lcom/google/protobuf/CodedOutputStream;->writeEnum(II)V

    .line 11531
    :cond_0
    iget v0, p0, Lcom/google/protobuf/DescriptorProtos$FieldOptions;->bitField0_:I

    and-int/lit8 v0, v0, 0x2

    if-ne v0, v3, :cond_1

    .line 11532
    iget-boolean v0, p0, Lcom/google/protobuf/DescriptorProtos$FieldOptions;->packed_:Z

    invoke-virtual {p1, v3, v0}, Lcom/google/protobuf/CodedOutputStream;->writeBool(IZ)V

    .line 11534
    :cond_1
    iget v0, p0, Lcom/google/protobuf/DescriptorProtos$FieldOptions;->bitField0_:I

    and-int/lit8 v0, v0, 0x8

    const/16 v1, 0x8

    if-ne v0, v1, :cond_2

    .line 11535
    const/4 v0, 0x3

    iget-boolean v1, p0, Lcom/google/protobuf/DescriptorProtos$FieldOptions;->deprecated_:Z

    invoke-virtual {p1, v0, v1}, Lcom/google/protobuf/CodedOutputStream;->writeBool(IZ)V

    .line 11537
    :cond_2
    iget v0, p0, Lcom/google/protobuf/DescriptorProtos$FieldOptions;->bitField0_:I

    and-int/lit8 v0, v0, 0x4

    const/4 v1, 0x4

    if-ne v0, v1, :cond_3

    .line 11538
    const/4 v0, 0x5

    iget-boolean v1, p0, Lcom/google/protobuf/DescriptorProtos$FieldOptions;->lazy_:Z

    invoke-virtual {p1, v0, v1}, Lcom/google/protobuf/CodedOutputStream;->writeBool(IZ)V

    .line 11540
    :cond_3
    iget v0, p0, Lcom/google/protobuf/DescriptorProtos$FieldOptions;->bitField0_:I

    and-int/lit8 v0, v0, 0x10

    const/16 v1, 0x10

    if-ne v0, v1, :cond_4

    .line 11541
    const/16 v0, 0x9

    invoke-direct {p0}, Lcom/google/protobuf/DescriptorProtos$FieldOptions;->getExperimentalMapKeyBytes()Lcom/google/protobuf/ByteString;

    move-result-object v1

    invoke-virtual {p1, v0, v1}, Lcom/google/protobuf/CodedOutputStream;->writeBytes(ILcom/google/protobuf/ByteString;)V

    .line 11543
    :cond_4
    iget v0, p0, Lcom/google/protobuf/DescriptorProtos$FieldOptions;->bitField0_:I

    and-int/lit8 v0, v0, 0x20

    const/16 v1, 0x20

    if-ne v0, v1, :cond_5

    .line 11544
    const/16 v0, 0xa

    iget-boolean v1, p0, Lcom/google/protobuf/DescriptorProtos$FieldOptions;->weak_:Z

    invoke-virtual {p1, v0, v1}, Lcom/google/protobuf/CodedOutputStream;->writeBool(IZ)V

    .line 11546
    :cond_5
    const/4 v0, 0x0

    move v1, v0

    :goto_0
    iget-object v0, p0, Lcom/google/protobuf/DescriptorProtos$FieldOptions;->uninterpretedOption_:Ljava/util/List;

    invoke-interface {v0}, Ljava/util/List;->size()I

    move-result v0

    if-lt v1, v0, :cond_6

    .line 11549
    const/high16 v0, 0x20000000

    invoke-virtual {v2, v0, p1}, Lcom/google/protobuf/GeneratedMessage$ExtendableMessage$ExtensionWriter;->writeUntil(ILcom/google/protobuf/CodedOutputStream;)V

    .line 11550
    invoke-virtual {p0}, Lcom/google/protobuf/DescriptorProtos$FieldOptions;->getUnknownFields()Lcom/google/protobuf/UnknownFieldSet;

    move-result-object v0

    invoke-virtual {v0, p1}, Lcom/google/protobuf/UnknownFieldSet;->writeTo(Lcom/google/protobuf/CodedOutputStream;)V

    .line 11551
    return-void

    .line 11547
    :cond_6
    const/16 v3, 0x3e7

    iget-object v0, p0, Lcom/google/protobuf/DescriptorProtos$FieldOptions;->uninterpretedOption_:Ljava/util/List;

    invoke-interface {v0, v1}, Ljava/util/List;->get(I)Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Lcom/google/protobuf/MessageLite;

    invoke-virtual {p1, v3, v0}, Lcom/google/protobuf/CodedOutputStream;->writeMessage(ILcom/google/protobuf/MessageLite;)V

    .line 11546
    add-int/lit8 v0, v1, 0x1

    move v1, v0

    goto :goto_0
.end method
