.class public final Lcom/google/protobuf/DescriptorProtos$FileDescriptorProto$Builder;
.super Lcom/google/protobuf/GeneratedMessage$Builder;
.source "SourceFile"

# interfaces
.implements Lcom/google/protobuf/DescriptorProtos$FileDescriptorProtoOrBuilder;


# annotations
.annotation system Ldalvik/annotation/EnclosingClass;
    value = Lcom/google/protobuf/DescriptorProtos$FileDescriptorProto;
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x19
    name = "Builder"
.end annotation

.annotation system Ldalvik/annotation/Signature;
    value = {
        "Lcom/google/protobuf/GeneratedMessage$Builder",
        "<",
        "Lcom/google/protobuf/DescriptorProtos$FileDescriptorProto$Builder;",
        ">;",
        "Lcom/google/protobuf/DescriptorProtos$FileDescriptorProtoOrBuilder;"
    }
.end annotation


# instance fields
.field private bitField0_:I

.field private dependency_:Lcom/google/protobuf/LazyStringList;

.field private enumTypeBuilder_:Lcom/google/protobuf/RepeatedFieldBuilder;
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "Lcom/google/protobuf/RepeatedFieldBuilder",
            "<",
            "Lcom/google/protobuf/DescriptorProtos$EnumDescriptorProto;",
            "Lcom/google/protobuf/DescriptorProtos$EnumDescriptorProto$Builder;",
            "Lcom/google/protobuf/DescriptorProtos$EnumDescriptorProtoOrBuilder;",
            ">;"
        }
    .end annotation
.end field

.field private enumType_:Ljava/util/List;
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "Ljava/util/List",
            "<",
            "Lcom/google/protobuf/DescriptorProtos$EnumDescriptorProto;",
            ">;"
        }
    .end annotation
.end field

.field private extensionBuilder_:Lcom/google/protobuf/RepeatedFieldBuilder;
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "Lcom/google/protobuf/RepeatedFieldBuilder",
            "<",
            "Lcom/google/protobuf/DescriptorProtos$FieldDescriptorProto;",
            "Lcom/google/protobuf/DescriptorProtos$FieldDescriptorProto$Builder;",
            "Lcom/google/protobuf/DescriptorProtos$FieldDescriptorProtoOrBuilder;",
            ">;"
        }
    .end annotation
.end field

.field private extension_:Ljava/util/List;
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "Ljava/util/List",
            "<",
            "Lcom/google/protobuf/DescriptorProtos$FieldDescriptorProto;",
            ">;"
        }
    .end annotation
.end field

.field private messageTypeBuilder_:Lcom/google/protobuf/RepeatedFieldBuilder;
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "Lcom/google/protobuf/RepeatedFieldBuilder",
            "<",
            "Lcom/google/protobuf/DescriptorProtos$DescriptorProto;",
            "Lcom/google/protobuf/DescriptorProtos$DescriptorProto$Builder;",
            "Lcom/google/protobuf/DescriptorProtos$DescriptorProtoOrBuilder;",
            ">;"
        }
    .end annotation
.end field

.field private messageType_:Ljava/util/List;
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "Ljava/util/List",
            "<",
            "Lcom/google/protobuf/DescriptorProtos$DescriptorProto;",
            ">;"
        }
    .end annotation
.end field

.field private name_:Ljava/lang/Object;

.field private optionsBuilder_:Lcom/google/protobuf/SingleFieldBuilder;
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "Lcom/google/protobuf/SingleFieldBuilder",
            "<",
            "Lcom/google/protobuf/DescriptorProtos$FileOptions;",
            "Lcom/google/protobuf/DescriptorProtos$FileOptions$Builder;",
            "Lcom/google/protobuf/DescriptorProtos$FileOptionsOrBuilder;",
            ">;"
        }
    .end annotation
.end field

.field private options_:Lcom/google/protobuf/DescriptorProtos$FileOptions;

.field private package_:Ljava/lang/Object;

.field private publicDependency_:Ljava/util/List;
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "Ljava/util/List",
            "<",
            "Ljava/lang/Integer;",
            ">;"
        }
    .end annotation
.end field

.field private serviceBuilder_:Lcom/google/protobuf/RepeatedFieldBuilder;
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "Lcom/google/protobuf/RepeatedFieldBuilder",
            "<",
            "Lcom/google/protobuf/DescriptorProtos$ServiceDescriptorProto;",
            "Lcom/google/protobuf/DescriptorProtos$ServiceDescriptorProto$Builder;",
            "Lcom/google/protobuf/DescriptorProtos$ServiceDescriptorProtoOrBuilder;",
            ">;"
        }
    .end annotation
.end field

.field private service_:Ljava/util/List;
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "Ljava/util/List",
            "<",
            "Lcom/google/protobuf/DescriptorProtos$ServiceDescriptorProto;",
            ">;"
        }
    .end annotation
.end field

.field private sourceCodeInfoBuilder_:Lcom/google/protobuf/SingleFieldBuilder;
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "Lcom/google/protobuf/SingleFieldBuilder",
            "<",
            "Lcom/google/protobuf/DescriptorProtos$SourceCodeInfo;",
            "Lcom/google/protobuf/DescriptorProtos$SourceCodeInfo$Builder;",
            "Lcom/google/protobuf/DescriptorProtos$SourceCodeInfoOrBuilder;",
            ">;"
        }
    .end annotation
.end field

.field private sourceCodeInfo_:Lcom/google/protobuf/DescriptorProtos$SourceCodeInfo;

.field private weakDependency_:Ljava/util/List;
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "Ljava/util/List",
            "<",
            "Ljava/lang/Integer;",
            ">;"
        }
    .end annotation
.end field


# direct methods
.method private constructor <init>()V
    .locals 1

    .prologue
    .line 1157
    invoke-direct {p0}, Lcom/google/protobuf/GeneratedMessage$Builder;-><init>()V

    .line 1656
    const-string v0, ""

    iput-object v0, p0, Lcom/google/protobuf/DescriptorProtos$FileDescriptorProto$Builder;->name_:Ljava/lang/Object;

    .line 1692
    const-string v0, ""

    iput-object v0, p0, Lcom/google/protobuf/DescriptorProtos$FileDescriptorProto$Builder;->package_:Ljava/lang/Object;

    .line 1728
    sget-object v0, Lcom/google/protobuf/LazyStringArrayList;->EMPTY:Lcom/google/protobuf/LazyStringList;

    iput-object v0, p0, Lcom/google/protobuf/DescriptorProtos$FileDescriptorProto$Builder;->dependency_:Lcom/google/protobuf/LazyStringList;

    .line 1784
    invoke-static {}, Ljava/util/Collections;->emptyList()Ljava/util/List;

    move-result-object v0

    iput-object v0, p0, Lcom/google/protobuf/DescriptorProtos$FileDescriptorProto$Builder;->publicDependency_:Ljava/util/List;

    .line 1829
    invoke-static {}, Ljava/util/Collections;->emptyList()Ljava/util/List;

    move-result-object v0

    iput-object v0, p0, Lcom/google/protobuf/DescriptorProtos$FileDescriptorProto$Builder;->weakDependency_:Ljava/util/List;

    .line 1875
    invoke-static {}, Ljava/util/Collections;->emptyList()Ljava/util/List;

    move-result-object v0

    iput-object v0, p0, Lcom/google/protobuf/DescriptorProtos$FileDescriptorProto$Builder;->messageType_:Ljava/util/List;

    .line 2061
    invoke-static {}, Ljava/util/Collections;->emptyList()Ljava/util/List;

    move-result-object v0

    iput-object v0, p0, Lcom/google/protobuf/DescriptorProtos$FileDescriptorProto$Builder;->enumType_:Ljava/util/List;

    .line 2247
    invoke-static {}, Ljava/util/Collections;->emptyList()Ljava/util/List;

    move-result-object v0

    iput-object v0, p0, Lcom/google/protobuf/DescriptorProtos$FileDescriptorProto$Builder;->service_:Ljava/util/List;

    .line 2433
    invoke-static {}, Ljava/util/Collections;->emptyList()Ljava/util/List;

    move-result-object v0

    iput-object v0, p0, Lcom/google/protobuf/DescriptorProtos$FileDescriptorProto$Builder;->extension_:Ljava/util/List;

    .line 2618
    invoke-static {}, Lcom/google/protobuf/DescriptorProtos$FileOptions;->getDefaultInstance()Lcom/google/protobuf/DescriptorProtos$FileOptions;

    move-result-object v0

    iput-object v0, p0, Lcom/google/protobuf/DescriptorProtos$FileDescriptorProto$Builder;->options_:Lcom/google/protobuf/DescriptorProtos$FileOptions;

    .line 2708
    invoke-static {}, Lcom/google/protobuf/DescriptorProtos$SourceCodeInfo;->getDefaultInstance()Lcom/google/protobuf/DescriptorProtos$SourceCodeInfo;

    move-result-object v0

    iput-object v0, p0, Lcom/google/protobuf/DescriptorProtos$FileDescriptorProto$Builder;->sourceCodeInfo_:Lcom/google/protobuf/DescriptorProtos$SourceCodeInfo;

    .line 1158
    invoke-direct {p0}, Lcom/google/protobuf/DescriptorProtos$FileDescriptorProto$Builder;->maybeForceBuilderInitialization()V

    .line 1159
    return-void
.end method

.method private constructor <init>(Lcom/google/protobuf/GeneratedMessage$BuilderParent;)V
    .locals 1

    .prologue
    .line 1162
    invoke-direct {p0, p1}, Lcom/google/protobuf/GeneratedMessage$Builder;-><init>(Lcom/google/protobuf/GeneratedMessage$BuilderParent;)V

    .line 1656
    const-string v0, ""

    iput-object v0, p0, Lcom/google/protobuf/DescriptorProtos$FileDescriptorProto$Builder;->name_:Ljava/lang/Object;

    .line 1692
    const-string v0, ""

    iput-object v0, p0, Lcom/google/protobuf/DescriptorProtos$FileDescriptorProto$Builder;->package_:Ljava/lang/Object;

    .line 1728
    sget-object v0, Lcom/google/protobuf/LazyStringArrayList;->EMPTY:Lcom/google/protobuf/LazyStringList;

    iput-object v0, p0, Lcom/google/protobuf/DescriptorProtos$FileDescriptorProto$Builder;->dependency_:Lcom/google/protobuf/LazyStringList;

    .line 1784
    invoke-static {}, Ljava/util/Collections;->emptyList()Ljava/util/List;

    move-result-object v0

    iput-object v0, p0, Lcom/google/protobuf/DescriptorProtos$FileDescriptorProto$Builder;->publicDependency_:Ljava/util/List;

    .line 1829
    invoke-static {}, Ljava/util/Collections;->emptyList()Ljava/util/List;

    move-result-object v0

    iput-object v0, p0, Lcom/google/protobuf/DescriptorProtos$FileDescriptorProto$Builder;->weakDependency_:Ljava/util/List;

    .line 1875
    invoke-static {}, Ljava/util/Collections;->emptyList()Ljava/util/List;

    move-result-object v0

    iput-object v0, p0, Lcom/google/protobuf/DescriptorProtos$FileDescriptorProto$Builder;->messageType_:Ljava/util/List;

    .line 2061
    invoke-static {}, Ljava/util/Collections;->emptyList()Ljava/util/List;

    move-result-object v0

    iput-object v0, p0, Lcom/google/protobuf/DescriptorProtos$FileDescriptorProto$Builder;->enumType_:Ljava/util/List;

    .line 2247
    invoke-static {}, Ljava/util/Collections;->emptyList()Ljava/util/List;

    move-result-object v0

    iput-object v0, p0, Lcom/google/protobuf/DescriptorProtos$FileDescriptorProto$Builder;->service_:Ljava/util/List;

    .line 2433
    invoke-static {}, Ljava/util/Collections;->emptyList()Ljava/util/List;

    move-result-object v0

    iput-object v0, p0, Lcom/google/protobuf/DescriptorProtos$FileDescriptorProto$Builder;->extension_:Ljava/util/List;

    .line 2618
    invoke-static {}, Lcom/google/protobuf/DescriptorProtos$FileOptions;->getDefaultInstance()Lcom/google/protobuf/DescriptorProtos$FileOptions;

    move-result-object v0

    iput-object v0, p0, Lcom/google/protobuf/DescriptorProtos$FileDescriptorProto$Builder;->options_:Lcom/google/protobuf/DescriptorProtos$FileOptions;

    .line 2708
    invoke-static {}, Lcom/google/protobuf/DescriptorProtos$SourceCodeInfo;->getDefaultInstance()Lcom/google/protobuf/DescriptorProtos$SourceCodeInfo;

    move-result-object v0

    iput-object v0, p0, Lcom/google/protobuf/DescriptorProtos$FileDescriptorProto$Builder;->sourceCodeInfo_:Lcom/google/protobuf/DescriptorProtos$SourceCodeInfo;

    .line 1163
    invoke-direct {p0}, Lcom/google/protobuf/DescriptorProtos$FileDescriptorProto$Builder;->maybeForceBuilderInitialization()V

    .line 1164
    return-void
.end method

.method synthetic constructor <init>(Lcom/google/protobuf/GeneratedMessage$BuilderParent;Lcom/google/protobuf/DescriptorProtos$FileDescriptorProto$Builder;)V
    .locals 0

    .prologue
    .line 1161
    invoke-direct {p0, p1}, Lcom/google/protobuf/DescriptorProtos$FileDescriptorProto$Builder;-><init>(Lcom/google/protobuf/GeneratedMessage$BuilderParent;)V

    return-void
.end method

.method static synthetic access$17(Lcom/google/protobuf/DescriptorProtos$FileDescriptorProto$Builder;)Lcom/google/protobuf/DescriptorProtos$FileDescriptorProto;
    .locals 1
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Lcom/google/protobuf/InvalidProtocolBufferException;
        }
    .end annotation

    .prologue
    .line 1251
    invoke-direct {p0}, Lcom/google/protobuf/DescriptorProtos$FileDescriptorProto$Builder;->buildParsed()Lcom/google/protobuf/DescriptorProtos$FileDescriptorProto;

    move-result-object v0

    return-object v0
.end method

.method static synthetic access$18()Lcom/google/protobuf/DescriptorProtos$FileDescriptorProto$Builder;
    .locals 1

    .prologue
    .line 1175
    invoke-static {}, Lcom/google/protobuf/DescriptorProtos$FileDescriptorProto$Builder;->create()Lcom/google/protobuf/DescriptorProtos$FileDescriptorProto$Builder;

    move-result-object v0

    return-object v0
.end method

.method private buildParsed()Lcom/google/protobuf/DescriptorProtos$FileDescriptorProto;
    .locals 2
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Lcom/google/protobuf/InvalidProtocolBufferException;
        }
    .end annotation

    .prologue
    .line 1253
    invoke-virtual {p0}, Lcom/google/protobuf/DescriptorProtos$FileDescriptorProto$Builder;->buildPartial()Lcom/google/protobuf/DescriptorProtos$FileDescriptorProto;

    move-result-object v0

    .line 1254
    invoke-virtual {v0}, Lcom/google/protobuf/DescriptorProtos$FileDescriptorProto;->isInitialized()Z

    move-result v1

    if-nez v1, :cond_0

    .line 1255
    invoke-static {v0}, Lcom/google/protobuf/DescriptorProtos$FileDescriptorProto$Builder;->newUninitializedMessageException(Lcom/google/protobuf/Message;)Lcom/google/protobuf/UninitializedMessageException;

    move-result-object v0

    .line 1256
    invoke-virtual {v0}, Lcom/google/protobuf/UninitializedMessageException;->asInvalidProtocolBufferException()Lcom/google/protobuf/InvalidProtocolBufferException;

    move-result-object v0

    .line 1255
    throw v0

    .line 1258
    :cond_0
    return-object v0
.end method

.method private static create()Lcom/google/protobuf/DescriptorProtos$FileDescriptorProto$Builder;
    .locals 1

    .prologue
    .line 1176
    new-instance v0, Lcom/google/protobuf/DescriptorProtos$FileDescriptorProto$Builder;

    invoke-direct {v0}, Lcom/google/protobuf/DescriptorProtos$FileDescriptorProto$Builder;-><init>()V

    return-object v0
.end method

.method private ensureDependencyIsMutable()V
    .locals 2

    .prologue
    .line 1730
    iget v0, p0, Lcom/google/protobuf/DescriptorProtos$FileDescriptorProto$Builder;->bitField0_:I

    and-int/lit8 v0, v0, 0x4

    const/4 v1, 0x4

    if-eq v0, v1, :cond_0

    .line 1731
    new-instance v0, Lcom/google/protobuf/LazyStringArrayList;

    iget-object v1, p0, Lcom/google/protobuf/DescriptorProtos$FileDescriptorProto$Builder;->dependency_:Lcom/google/protobuf/LazyStringList;

    invoke-direct {v0, v1}, Lcom/google/protobuf/LazyStringArrayList;-><init>(Lcom/google/protobuf/LazyStringList;)V

    iput-object v0, p0, Lcom/google/protobuf/DescriptorProtos$FileDescriptorProto$Builder;->dependency_:Lcom/google/protobuf/LazyStringList;

    .line 1732
    iget v0, p0, Lcom/google/protobuf/DescriptorProtos$FileDescriptorProto$Builder;->bitField0_:I

    or-int/lit8 v0, v0, 0x4

    iput v0, p0, Lcom/google/protobuf/DescriptorProtos$FileDescriptorProto$Builder;->bitField0_:I

    .line 1734
    :cond_0
    return-void
.end method

.method private ensureEnumTypeIsMutable()V
    .locals 2

    .prologue
    .line 2063
    iget v0, p0, Lcom/google/protobuf/DescriptorProtos$FileDescriptorProto$Builder;->bitField0_:I

    and-int/lit8 v0, v0, 0x40

    const/16 v1, 0x40

    if-eq v0, v1, :cond_0

    .line 2064
    new-instance v0, Ljava/util/ArrayList;

    iget-object v1, p0, Lcom/google/protobuf/DescriptorProtos$FileDescriptorProto$Builder;->enumType_:Ljava/util/List;

    invoke-direct {v0, v1}, Ljava/util/ArrayList;-><init>(Ljava/util/Collection;)V

    iput-object v0, p0, Lcom/google/protobuf/DescriptorProtos$FileDescriptorProto$Builder;->enumType_:Ljava/util/List;

    .line 2065
    iget v0, p0, Lcom/google/protobuf/DescriptorProtos$FileDescriptorProto$Builder;->bitField0_:I

    or-int/lit8 v0, v0, 0x40

    iput v0, p0, Lcom/google/protobuf/DescriptorProtos$FileDescriptorProto$Builder;->bitField0_:I

    .line 2067
    :cond_0
    return-void
.end method

.method private ensureExtensionIsMutable()V
    .locals 2

    .prologue
    .line 2435
    iget v0, p0, Lcom/google/protobuf/DescriptorProtos$FileDescriptorProto$Builder;->bitField0_:I

    and-int/lit16 v0, v0, 0x100

    const/16 v1, 0x100

    if-eq v0, v1, :cond_0

    .line 2436
    new-instance v0, Ljava/util/ArrayList;

    iget-object v1, p0, Lcom/google/protobuf/DescriptorProtos$FileDescriptorProto$Builder;->extension_:Ljava/util/List;

    invoke-direct {v0, v1}, Ljava/util/ArrayList;-><init>(Ljava/util/Collection;)V

    iput-object v0, p0, Lcom/google/protobuf/DescriptorProtos$FileDescriptorProto$Builder;->extension_:Ljava/util/List;

    .line 2437
    iget v0, p0, Lcom/google/protobuf/DescriptorProtos$FileDescriptorProto$Builder;->bitField0_:I

    or-int/lit16 v0, v0, 0x100

    iput v0, p0, Lcom/google/protobuf/DescriptorProtos$FileDescriptorProto$Builder;->bitField0_:I

    .line 2439
    :cond_0
    return-void
.end method

.method private ensureMessageTypeIsMutable()V
    .locals 2

    .prologue
    .line 1877
    iget v0, p0, Lcom/google/protobuf/DescriptorProtos$FileDescriptorProto$Builder;->bitField0_:I

    and-int/lit8 v0, v0, 0x20

    const/16 v1, 0x20

    if-eq v0, v1, :cond_0

    .line 1878
    new-instance v0, Ljava/util/ArrayList;

    iget-object v1, p0, Lcom/google/protobuf/DescriptorProtos$FileDescriptorProto$Builder;->messageType_:Ljava/util/List;

    invoke-direct {v0, v1}, Ljava/util/ArrayList;-><init>(Ljava/util/Collection;)V

    iput-object v0, p0, Lcom/google/protobuf/DescriptorProtos$FileDescriptorProto$Builder;->messageType_:Ljava/util/List;

    .line 1879
    iget v0, p0, Lcom/google/protobuf/DescriptorProtos$FileDescriptorProto$Builder;->bitField0_:I

    or-int/lit8 v0, v0, 0x20

    iput v0, p0, Lcom/google/protobuf/DescriptorProtos$FileDescriptorProto$Builder;->bitField0_:I

    .line 1881
    :cond_0
    return-void
.end method

.method private ensurePublicDependencyIsMutable()V
    .locals 2

    .prologue
    .line 1786
    iget v0, p0, Lcom/google/protobuf/DescriptorProtos$FileDescriptorProto$Builder;->bitField0_:I

    and-int/lit8 v0, v0, 0x8

    const/16 v1, 0x8

    if-eq v0, v1, :cond_0

    .line 1787
    new-instance v0, Ljava/util/ArrayList;

    iget-object v1, p0, Lcom/google/protobuf/DescriptorProtos$FileDescriptorProto$Builder;->publicDependency_:Ljava/util/List;

    invoke-direct {v0, v1}, Ljava/util/ArrayList;-><init>(Ljava/util/Collection;)V

    iput-object v0, p0, Lcom/google/protobuf/DescriptorProtos$FileDescriptorProto$Builder;->publicDependency_:Ljava/util/List;

    .line 1788
    iget v0, p0, Lcom/google/protobuf/DescriptorProtos$FileDescriptorProto$Builder;->bitField0_:I

    or-int/lit8 v0, v0, 0x8

    iput v0, p0, Lcom/google/protobuf/DescriptorProtos$FileDescriptorProto$Builder;->bitField0_:I

    .line 1790
    :cond_0
    return-void
.end method

.method private ensureServiceIsMutable()V
    .locals 2

    .prologue
    .line 2249
    iget v0, p0, Lcom/google/protobuf/DescriptorProtos$FileDescriptorProto$Builder;->bitField0_:I

    and-int/lit16 v0, v0, 0x80

    const/16 v1, 0x80

    if-eq v0, v1, :cond_0

    .line 2250
    new-instance v0, Ljava/util/ArrayList;

    iget-object v1, p0, Lcom/google/protobuf/DescriptorProtos$FileDescriptorProto$Builder;->service_:Ljava/util/List;

    invoke-direct {v0, v1}, Ljava/util/ArrayList;-><init>(Ljava/util/Collection;)V

    iput-object v0, p0, Lcom/google/protobuf/DescriptorProtos$FileDescriptorProto$Builder;->service_:Ljava/util/List;

    .line 2251
    iget v0, p0, Lcom/google/protobuf/DescriptorProtos$FileDescriptorProto$Builder;->bitField0_:I

    or-int/lit16 v0, v0, 0x80

    iput v0, p0, Lcom/google/protobuf/DescriptorProtos$FileDescriptorProto$Builder;->bitField0_:I

    .line 2253
    :cond_0
    return-void
.end method

.method private ensureWeakDependencyIsMutable()V
    .locals 2

    .prologue
    .line 1831
    iget v0, p0, Lcom/google/protobuf/DescriptorProtos$FileDescriptorProto$Builder;->bitField0_:I

    and-int/lit8 v0, v0, 0x10

    const/16 v1, 0x10

    if-eq v0, v1, :cond_0

    .line 1832
    new-instance v0, Ljava/util/ArrayList;

    iget-object v1, p0, Lcom/google/protobuf/DescriptorProtos$FileDescriptorProto$Builder;->weakDependency_:Ljava/util/List;

    invoke-direct {v0, v1}, Ljava/util/ArrayList;-><init>(Ljava/util/Collection;)V

    iput-object v0, p0, Lcom/google/protobuf/DescriptorProtos$FileDescriptorProto$Builder;->weakDependency_:Ljava/util/List;

    .line 1833
    iget v0, p0, Lcom/google/protobuf/DescriptorProtos$FileDescriptorProto$Builder;->bitField0_:I

    or-int/lit8 v0, v0, 0x10

    iput v0, p0, Lcom/google/protobuf/DescriptorProtos$FileDescriptorProto$Builder;->bitField0_:I

    .line 1835
    :cond_0
    return-void
.end method

.method public static final getDescriptor()Lcom/google/protobuf/Descriptors$Descriptor;
    .locals 1

    .prologue
    .line 1148
    invoke-static {}, Lcom/google/protobuf/DescriptorProtos;->access$5()Lcom/google/protobuf/Descriptors$Descriptor;

    move-result-object v0

    return-object v0
.end method

.method private getEnumTypeFieldBuilder()Lcom/google/protobuf/RepeatedFieldBuilder;
    .locals 5
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "()",
            "Lcom/google/protobuf/RepeatedFieldBuilder",
            "<",
            "Lcom/google/protobuf/DescriptorProtos$EnumDescriptorProto;",
            "Lcom/google/protobuf/DescriptorProtos$EnumDescriptorProto$Builder;",
            "Lcom/google/protobuf/DescriptorProtos$EnumDescriptorProtoOrBuilder;",
            ">;"
        }
    .end annotation

    .prologue
    .line 2233
    iget-object v0, p0, Lcom/google/protobuf/DescriptorProtos$FileDescriptorProto$Builder;->enumTypeBuilder_:Lcom/google/protobuf/RepeatedFieldBuilder;

    if-nez v0, :cond_0

    .line 2234
    new-instance v1, Lcom/google/protobuf/RepeatedFieldBuilder;

    .line 2236
    iget-object v2, p0, Lcom/google/protobuf/DescriptorProtos$FileDescriptorProto$Builder;->enumType_:Ljava/util/List;

    .line 2237
    iget v0, p0, Lcom/google/protobuf/DescriptorProtos$FileDescriptorProto$Builder;->bitField0_:I

    and-int/lit8 v0, v0, 0x40

    const/16 v3, 0x40

    if-ne v0, v3, :cond_1

    const/4 v0, 0x1

    .line 2238
    :goto_0
    invoke-virtual {p0}, Lcom/google/protobuf/DescriptorProtos$FileDescriptorProto$Builder;->getParentForChildren()Lcom/google/protobuf/GeneratedMessage$BuilderParent;

    move-result-object v3

    .line 2239
    invoke-virtual {p0}, Lcom/google/protobuf/DescriptorProtos$FileDescriptorProto$Builder;->isClean()Z

    move-result v4

    invoke-direct {v1, v2, v0, v3, v4}, Lcom/google/protobuf/RepeatedFieldBuilder;-><init>(Ljava/util/List;ZLcom/google/protobuf/GeneratedMessage$BuilderParent;Z)V

    .line 2234
    iput-object v1, p0, Lcom/google/protobuf/DescriptorProtos$FileDescriptorProto$Builder;->enumTypeBuilder_:Lcom/google/protobuf/RepeatedFieldBuilder;

    .line 2240
    const/4 v0, 0x0

    iput-object v0, p0, Lcom/google/protobuf/DescriptorProtos$FileDescriptorProto$Builder;->enumType_:Ljava/util/List;

    .line 2242
    :cond_0
    iget-object v0, p0, Lcom/google/protobuf/DescriptorProtos$FileDescriptorProto$Builder;->enumTypeBuilder_:Lcom/google/protobuf/RepeatedFieldBuilder;

    return-object v0

    .line 2237
    :cond_1
    const/4 v0, 0x0

    goto :goto_0
.end method

.method private getExtensionFieldBuilder()Lcom/google/protobuf/RepeatedFieldBuilder;
    .locals 5
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "()",
            "Lcom/google/protobuf/RepeatedFieldBuilder",
            "<",
            "Lcom/google/protobuf/DescriptorProtos$FieldDescriptorProto;",
            "Lcom/google/protobuf/DescriptorProtos$FieldDescriptorProto$Builder;",
            "Lcom/google/protobuf/DescriptorProtos$FieldDescriptorProtoOrBuilder;",
            ">;"
        }
    .end annotation

    .prologue
    .line 2605
    iget-object v0, p0, Lcom/google/protobuf/DescriptorProtos$FileDescriptorProto$Builder;->extensionBuilder_:Lcom/google/protobuf/RepeatedFieldBuilder;

    if-nez v0, :cond_0

    .line 2606
    new-instance v1, Lcom/google/protobuf/RepeatedFieldBuilder;

    .line 2608
    iget-object v2, p0, Lcom/google/protobuf/DescriptorProtos$FileDescriptorProto$Builder;->extension_:Ljava/util/List;

    .line 2609
    iget v0, p0, Lcom/google/protobuf/DescriptorProtos$FileDescriptorProto$Builder;->bitField0_:I

    and-int/lit16 v0, v0, 0x100

    const/16 v3, 0x100

    if-ne v0, v3, :cond_1

    const/4 v0, 0x1

    .line 2610
    :goto_0
    invoke-virtual {p0}, Lcom/google/protobuf/DescriptorProtos$FileDescriptorProto$Builder;->getParentForChildren()Lcom/google/protobuf/GeneratedMessage$BuilderParent;

    move-result-object v3

    .line 2611
    invoke-virtual {p0}, Lcom/google/protobuf/DescriptorProtos$FileDescriptorProto$Builder;->isClean()Z

    move-result v4

    invoke-direct {v1, v2, v0, v3, v4}, Lcom/google/protobuf/RepeatedFieldBuilder;-><init>(Ljava/util/List;ZLcom/google/protobuf/GeneratedMessage$BuilderParent;Z)V

    .line 2606
    iput-object v1, p0, Lcom/google/protobuf/DescriptorProtos$FileDescriptorProto$Builder;->extensionBuilder_:Lcom/google/protobuf/RepeatedFieldBuilder;

    .line 2612
    const/4 v0, 0x0

    iput-object v0, p0, Lcom/google/protobuf/DescriptorProtos$FileDescriptorProto$Builder;->extension_:Ljava/util/List;

    .line 2614
    :cond_0
    iget-object v0, p0, Lcom/google/protobuf/DescriptorProtos$FileDescriptorProto$Builder;->extensionBuilder_:Lcom/google/protobuf/RepeatedFieldBuilder;

    return-object v0

    .line 2609
    :cond_1
    const/4 v0, 0x0

    goto :goto_0
.end method

.method private getMessageTypeFieldBuilder()Lcom/google/protobuf/RepeatedFieldBuilder;
    .locals 5
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "()",
            "Lcom/google/protobuf/RepeatedFieldBuilder",
            "<",
            "Lcom/google/protobuf/DescriptorProtos$DescriptorProto;",
            "Lcom/google/protobuf/DescriptorProtos$DescriptorProto$Builder;",
            "Lcom/google/protobuf/DescriptorProtos$DescriptorProtoOrBuilder;",
            ">;"
        }
    .end annotation

    .prologue
    .line 2047
    iget-object v0, p0, Lcom/google/protobuf/DescriptorProtos$FileDescriptorProto$Builder;->messageTypeBuilder_:Lcom/google/protobuf/RepeatedFieldBuilder;

    if-nez v0, :cond_0

    .line 2048
    new-instance v1, Lcom/google/protobuf/RepeatedFieldBuilder;

    .line 2050
    iget-object v2, p0, Lcom/google/protobuf/DescriptorProtos$FileDescriptorProto$Builder;->messageType_:Ljava/util/List;

    .line 2051
    iget v0, p0, Lcom/google/protobuf/DescriptorProtos$FileDescriptorProto$Builder;->bitField0_:I

    and-int/lit8 v0, v0, 0x20

    const/16 v3, 0x20

    if-ne v0, v3, :cond_1

    const/4 v0, 0x1

    .line 2052
    :goto_0
    invoke-virtual {p0}, Lcom/google/protobuf/DescriptorProtos$FileDescriptorProto$Builder;->getParentForChildren()Lcom/google/protobuf/GeneratedMessage$BuilderParent;

    move-result-object v3

    .line 2053
    invoke-virtual {p0}, Lcom/google/protobuf/DescriptorProtos$FileDescriptorProto$Builder;->isClean()Z

    move-result v4

    invoke-direct {v1, v2, v0, v3, v4}, Lcom/google/protobuf/RepeatedFieldBuilder;-><init>(Ljava/util/List;ZLcom/google/protobuf/GeneratedMessage$BuilderParent;Z)V

    .line 2048
    iput-object v1, p0, Lcom/google/protobuf/DescriptorProtos$FileDescriptorProto$Builder;->messageTypeBuilder_:Lcom/google/protobuf/RepeatedFieldBuilder;

    .line 2054
    const/4 v0, 0x0

    iput-object v0, p0, Lcom/google/protobuf/DescriptorProtos$FileDescriptorProto$Builder;->messageType_:Ljava/util/List;

    .line 2056
    :cond_0
    iget-object v0, p0, Lcom/google/protobuf/DescriptorProtos$FileDescriptorProto$Builder;->messageTypeBuilder_:Lcom/google/protobuf/RepeatedFieldBuilder;

    return-object v0

    .line 2051
    :cond_1
    const/4 v0, 0x0

    goto :goto_0
.end method

.method private getOptionsFieldBuilder()Lcom/google/protobuf/SingleFieldBuilder;
    .locals 4
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "()",
            "Lcom/google/protobuf/SingleFieldBuilder",
            "<",
            "Lcom/google/protobuf/DescriptorProtos$FileOptions;",
            "Lcom/google/protobuf/DescriptorProtos$FileOptions$Builder;",
            "Lcom/google/protobuf/DescriptorProtos$FileOptionsOrBuilder;",
            ">;"
        }
    .end annotation

    .prologue
    .line 2696
    iget-object v0, p0, Lcom/google/protobuf/DescriptorProtos$FileDescriptorProto$Builder;->optionsBuilder_:Lcom/google/protobuf/SingleFieldBuilder;

    if-nez v0, :cond_0

    .line 2697
    new-instance v0, Lcom/google/protobuf/SingleFieldBuilder;

    .line 2699
    iget-object v1, p0, Lcom/google/protobuf/DescriptorProtos$FileDescriptorProto$Builder;->options_:Lcom/google/protobuf/DescriptorProtos$FileOptions;

    .line 2700
    invoke-virtual {p0}, Lcom/google/protobuf/DescriptorProtos$FileDescriptorProto$Builder;->getParentForChildren()Lcom/google/protobuf/GeneratedMessage$BuilderParent;

    move-result-object v2

    .line 2701
    invoke-virtual {p0}, Lcom/google/protobuf/DescriptorProtos$FileDescriptorProto$Builder;->isClean()Z

    move-result v3

    invoke-direct {v0, v1, v2, v3}, Lcom/google/protobuf/SingleFieldBuilder;-><init>(Lcom/google/protobuf/GeneratedMessage;Lcom/google/protobuf/GeneratedMessage$BuilderParent;Z)V

    .line 2697
    iput-object v0, p0, Lcom/google/protobuf/DescriptorProtos$FileDescriptorProto$Builder;->optionsBuilder_:Lcom/google/protobuf/SingleFieldBuilder;

    .line 2702
    const/4 v0, 0x0

    iput-object v0, p0, Lcom/google/protobuf/DescriptorProtos$FileDescriptorProto$Builder;->options_:Lcom/google/protobuf/DescriptorProtos$FileOptions;

    .line 2704
    :cond_0
    iget-object v0, p0, Lcom/google/protobuf/DescriptorProtos$FileDescriptorProto$Builder;->optionsBuilder_:Lcom/google/protobuf/SingleFieldBuilder;

    return-object v0
.end method

.method private getServiceFieldBuilder()Lcom/google/protobuf/RepeatedFieldBuilder;
    .locals 5
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "()",
            "Lcom/google/protobuf/RepeatedFieldBuilder",
            "<",
            "Lcom/google/protobuf/DescriptorProtos$ServiceDescriptorProto;",
            "Lcom/google/protobuf/DescriptorProtos$ServiceDescriptorProto$Builder;",
            "Lcom/google/protobuf/DescriptorProtos$ServiceDescriptorProtoOrBuilder;",
            ">;"
        }
    .end annotation

    .prologue
    .line 2419
    iget-object v0, p0, Lcom/google/protobuf/DescriptorProtos$FileDescriptorProto$Builder;->serviceBuilder_:Lcom/google/protobuf/RepeatedFieldBuilder;

    if-nez v0, :cond_0

    .line 2420
    new-instance v1, Lcom/google/protobuf/RepeatedFieldBuilder;

    .line 2422
    iget-object v2, p0, Lcom/google/protobuf/DescriptorProtos$FileDescriptorProto$Builder;->service_:Ljava/util/List;

    .line 2423
    iget v0, p0, Lcom/google/protobuf/DescriptorProtos$FileDescriptorProto$Builder;->bitField0_:I

    and-int/lit16 v0, v0, 0x80

    const/16 v3, 0x80

    if-ne v0, v3, :cond_1

    const/4 v0, 0x1

    .line 2424
    :goto_0
    invoke-virtual {p0}, Lcom/google/protobuf/DescriptorProtos$FileDescriptorProto$Builder;->getParentForChildren()Lcom/google/protobuf/GeneratedMessage$BuilderParent;

    move-result-object v3

    .line 2425
    invoke-virtual {p0}, Lcom/google/protobuf/DescriptorProtos$FileDescriptorProto$Builder;->isClean()Z

    move-result v4

    invoke-direct {v1, v2, v0, v3, v4}, Lcom/google/protobuf/RepeatedFieldBuilder;-><init>(Ljava/util/List;ZLcom/google/protobuf/GeneratedMessage$BuilderParent;Z)V

    .line 2420
    iput-object v1, p0, Lcom/google/protobuf/DescriptorProtos$FileDescriptorProto$Builder;->serviceBuilder_:Lcom/google/protobuf/RepeatedFieldBuilder;

    .line 2426
    const/4 v0, 0x0

    iput-object v0, p0, Lcom/google/protobuf/DescriptorProtos$FileDescriptorProto$Builder;->service_:Ljava/util/List;

    .line 2428
    :cond_0
    iget-object v0, p0, Lcom/google/protobuf/DescriptorProtos$FileDescriptorProto$Builder;->serviceBuilder_:Lcom/google/protobuf/RepeatedFieldBuilder;

    return-object v0

    .line 2423
    :cond_1
    const/4 v0, 0x0

    goto :goto_0
.end method

.method private getSourceCodeInfoFieldBuilder()Lcom/google/protobuf/SingleFieldBuilder;
    .locals 4
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "()",
            "Lcom/google/protobuf/SingleFieldBuilder",
            "<",
            "Lcom/google/protobuf/DescriptorProtos$SourceCodeInfo;",
            "Lcom/google/protobuf/DescriptorProtos$SourceCodeInfo$Builder;",
            "Lcom/google/protobuf/DescriptorProtos$SourceCodeInfoOrBuilder;",
            ">;"
        }
    .end annotation

    .prologue
    .line 2786
    iget-object v0, p0, Lcom/google/protobuf/DescriptorProtos$FileDescriptorProto$Builder;->sourceCodeInfoBuilder_:Lcom/google/protobuf/SingleFieldBuilder;

    if-nez v0, :cond_0

    .line 2787
    new-instance v0, Lcom/google/protobuf/SingleFieldBuilder;

    .line 2789
    iget-object v1, p0, Lcom/google/protobuf/DescriptorProtos$FileDescriptorProto$Builder;->sourceCodeInfo_:Lcom/google/protobuf/DescriptorProtos$SourceCodeInfo;

    .line 2790
    invoke-virtual {p0}, Lcom/google/protobuf/DescriptorProtos$FileDescriptorProto$Builder;->getParentForChildren()Lcom/google/protobuf/GeneratedMessage$BuilderParent;

    move-result-object v2

    .line 2791
    invoke-virtual {p0}, Lcom/google/protobuf/DescriptorProtos$FileDescriptorProto$Builder;->isClean()Z

    move-result v3

    invoke-direct {v0, v1, v2, v3}, Lcom/google/protobuf/SingleFieldBuilder;-><init>(Lcom/google/protobuf/GeneratedMessage;Lcom/google/protobuf/GeneratedMessage$BuilderParent;Z)V

    .line 2787
    iput-object v0, p0, Lcom/google/protobuf/DescriptorProtos$FileDescriptorProto$Builder;->sourceCodeInfoBuilder_:Lcom/google/protobuf/SingleFieldBuilder;

    .line 2792
    const/4 v0, 0x0

    iput-object v0, p0, Lcom/google/protobuf/DescriptorProtos$FileDescriptorProto$Builder;->sourceCodeInfo_:Lcom/google/protobuf/DescriptorProtos$SourceCodeInfo;

    .line 2794
    :cond_0
    iget-object v0, p0, Lcom/google/protobuf/DescriptorProtos$FileDescriptorProto$Builder;->sourceCodeInfoBuilder_:Lcom/google/protobuf/SingleFieldBuilder;

    return-object v0
.end method

.method private maybeForceBuilderInitialization()V
    .locals 1

    .prologue
    .line 1166
    sget-boolean v0, Lcom/google/protobuf/GeneratedMessage;->alwaysUseFieldBuilders:Z

    if-eqz v0, :cond_0

    .line 1167
    invoke-direct {p0}, Lcom/google/protobuf/DescriptorProtos$FileDescriptorProto$Builder;->getMessageTypeFieldBuilder()Lcom/google/protobuf/RepeatedFieldBuilder;

    .line 1168
    invoke-direct {p0}, Lcom/google/protobuf/DescriptorProtos$FileDescriptorProto$Builder;->getEnumTypeFieldBuilder()Lcom/google/protobuf/RepeatedFieldBuilder;

    .line 1169
    invoke-direct {p0}, Lcom/google/protobuf/DescriptorProtos$FileDescriptorProto$Builder;->getServiceFieldBuilder()Lcom/google/protobuf/RepeatedFieldBuilder;

    .line 1170
    invoke-direct {p0}, Lcom/google/protobuf/DescriptorProtos$FileDescriptorProto$Builder;->getExtensionFieldBuilder()Lcom/google/protobuf/RepeatedFieldBuilder;

    .line 1171
    invoke-direct {p0}, Lcom/google/protobuf/DescriptorProtos$FileDescriptorProto$Builder;->getOptionsFieldBuilder()Lcom/google/protobuf/SingleFieldBuilder;

    .line 1172
    invoke-direct {p0}, Lcom/google/protobuf/DescriptorProtos$FileDescriptorProto$Builder;->getSourceCodeInfoFieldBuilder()Lcom/google/protobuf/SingleFieldBuilder;

    .line 1174
    :cond_0
    return-void
.end method


# virtual methods
.method public addAllDependency(Ljava/lang/Iterable;)Lcom/google/protobuf/DescriptorProtos$FileDescriptorProto$Builder;
    .locals 1
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "(",
            "Ljava/lang/Iterable",
            "<",
            "Ljava/lang/String;",
            ">;)",
            "Lcom/google/protobuf/DescriptorProtos$FileDescriptorProto$Builder;"
        }
    .end annotation

    .prologue
    .line 1766
    invoke-direct {p0}, Lcom/google/protobuf/DescriptorProtos$FileDescriptorProto$Builder;->ensureDependencyIsMutable()V

    .line 1767
    iget-object v0, p0, Lcom/google/protobuf/DescriptorProtos$FileDescriptorProto$Builder;->dependency_:Lcom/google/protobuf/LazyStringList;

    invoke-static {p1, v0}, Lcom/google/protobuf/GeneratedMessage$Builder;->addAll(Ljava/lang/Iterable;Ljava/util/Collection;)V

    .line 1768
    invoke-virtual {p0}, Lcom/google/protobuf/DescriptorProtos$FileDescriptorProto$Builder;->onChanged()V

    .line 1769
    return-object p0
.end method

.method public addAllEnumType(Ljava/lang/Iterable;)Lcom/google/protobuf/DescriptorProtos$FileDescriptorProto$Builder;
    .locals 1
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "(",
            "Ljava/lang/Iterable",
            "<+",
            "Lcom/google/protobuf/DescriptorProtos$EnumDescriptorProto;",
            ">;)",
            "Lcom/google/protobuf/DescriptorProtos$FileDescriptorProto$Builder;"
        }
    .end annotation

    .prologue
    .line 2169
    iget-object v0, p0, Lcom/google/protobuf/DescriptorProtos$FileDescriptorProto$Builder;->enumTypeBuilder_:Lcom/google/protobuf/RepeatedFieldBuilder;

    if-nez v0, :cond_0

    .line 2170
    invoke-direct {p0}, Lcom/google/protobuf/DescriptorProtos$FileDescriptorProto$Builder;->ensureEnumTypeIsMutable()V

    .line 2171
    iget-object v0, p0, Lcom/google/protobuf/DescriptorProtos$FileDescriptorProto$Builder;->enumType_:Ljava/util/List;

    invoke-static {p1, v0}, Lcom/google/protobuf/GeneratedMessage$Builder;->addAll(Ljava/lang/Iterable;Ljava/util/Collection;)V

    .line 2172
    invoke-virtual {p0}, Lcom/google/protobuf/DescriptorProtos$FileDescriptorProto$Builder;->onChanged()V

    .line 2176
    :goto_0
    return-object p0

    .line 2174
    :cond_0
    iget-object v0, p0, Lcom/google/protobuf/DescriptorProtos$FileDescriptorProto$Builder;->enumTypeBuilder_:Lcom/google/protobuf/RepeatedFieldBuilder;

    invoke-virtual {v0, p1}, Lcom/google/protobuf/RepeatedFieldBuilder;->addAllMessages(Ljava/lang/Iterable;)Lcom/google/protobuf/RepeatedFieldBuilder;

    goto :goto_0
.end method

.method public addAllExtension(Ljava/lang/Iterable;)Lcom/google/protobuf/DescriptorProtos$FileDescriptorProto$Builder;
    .locals 1
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "(",
            "Ljava/lang/Iterable",
            "<+",
            "Lcom/google/protobuf/DescriptorProtos$FieldDescriptorProto;",
            ">;)",
            "Lcom/google/protobuf/DescriptorProtos$FileDescriptorProto$Builder;"
        }
    .end annotation

    .prologue
    .line 2541
    iget-object v0, p0, Lcom/google/protobuf/DescriptorProtos$FileDescriptorProto$Builder;->extensionBuilder_:Lcom/google/protobuf/RepeatedFieldBuilder;

    if-nez v0, :cond_0

    .line 2542
    invoke-direct {p0}, Lcom/google/protobuf/DescriptorProtos$FileDescriptorProto$Builder;->ensureExtensionIsMutable()V

    .line 2543
    iget-object v0, p0, Lcom/google/protobuf/DescriptorProtos$FileDescriptorProto$Builder;->extension_:Ljava/util/List;

    invoke-static {p1, v0}, Lcom/google/protobuf/GeneratedMessage$Builder;->addAll(Ljava/lang/Iterable;Ljava/util/Collection;)V

    .line 2544
    invoke-virtual {p0}, Lcom/google/protobuf/DescriptorProtos$FileDescriptorProto$Builder;->onChanged()V

    .line 2548
    :goto_0
    return-object p0

    .line 2546
    :cond_0
    iget-object v0, p0, Lcom/google/protobuf/DescriptorProtos$FileDescriptorProto$Builder;->extensionBuilder_:Lcom/google/protobuf/RepeatedFieldBuilder;

    invoke-virtual {v0, p1}, Lcom/google/protobuf/RepeatedFieldBuilder;->addAllMessages(Ljava/lang/Iterable;)Lcom/google/protobuf/RepeatedFieldBuilder;

    goto :goto_0
.end method

.method public addAllMessageType(Ljava/lang/Iterable;)Lcom/google/protobuf/DescriptorProtos$FileDescriptorProto$Builder;
    .locals 1
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "(",
            "Ljava/lang/Iterable",
            "<+",
            "Lcom/google/protobuf/DescriptorProtos$DescriptorProto;",
            ">;)",
            "Lcom/google/protobuf/DescriptorProtos$FileDescriptorProto$Builder;"
        }
    .end annotation

    .prologue
    .line 1983
    iget-object v0, p0, Lcom/google/protobuf/DescriptorProtos$FileDescriptorProto$Builder;->messageTypeBuilder_:Lcom/google/protobuf/RepeatedFieldBuilder;

    if-nez v0, :cond_0

    .line 1984
    invoke-direct {p0}, Lcom/google/protobuf/DescriptorProtos$FileDescriptorProto$Builder;->ensureMessageTypeIsMutable()V

    .line 1985
    iget-object v0, p0, Lcom/google/protobuf/DescriptorProtos$FileDescriptorProto$Builder;->messageType_:Ljava/util/List;

    invoke-static {p1, v0}, Lcom/google/protobuf/GeneratedMessage$Builder;->addAll(Ljava/lang/Iterable;Ljava/util/Collection;)V

    .line 1986
    invoke-virtual {p0}, Lcom/google/protobuf/DescriptorProtos$FileDescriptorProto$Builder;->onChanged()V

    .line 1990
    :goto_0
    return-object p0

    .line 1988
    :cond_0
    iget-object v0, p0, Lcom/google/protobuf/DescriptorProtos$FileDescriptorProto$Builder;->messageTypeBuilder_:Lcom/google/protobuf/RepeatedFieldBuilder;

    invoke-virtual {v0, p1}, Lcom/google/protobuf/RepeatedFieldBuilder;->addAllMessages(Ljava/lang/Iterable;)Lcom/google/protobuf/RepeatedFieldBuilder;

    goto :goto_0
.end method

.method public addAllPublicDependency(Ljava/lang/Iterable;)Lcom/google/protobuf/DescriptorProtos$FileDescriptorProto$Builder;
    .locals 1
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "(",
            "Ljava/lang/Iterable",
            "<+",
            "Ljava/lang/Integer;",
            ">;)",
            "Lcom/google/protobuf/DescriptorProtos$FileDescriptorProto$Builder;"
        }
    .end annotation

    .prologue
    .line 1816
    invoke-direct {p0}, Lcom/google/protobuf/DescriptorProtos$FileDescriptorProto$Builder;->ensurePublicDependencyIsMutable()V

    .line 1817
    iget-object v0, p0, Lcom/google/protobuf/DescriptorProtos$FileDescriptorProto$Builder;->publicDependency_:Ljava/util/List;

    invoke-static {p1, v0}, Lcom/google/protobuf/GeneratedMessage$Builder;->addAll(Ljava/lang/Iterable;Ljava/util/Collection;)V

    .line 1818
    invoke-virtual {p0}, Lcom/google/protobuf/DescriptorProtos$FileDescriptorProto$Builder;->onChanged()V

    .line 1819
    return-object p0
.end method

.method public addAllService(Ljava/lang/Iterable;)Lcom/google/protobuf/DescriptorProtos$FileDescriptorProto$Builder;
    .locals 1
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "(",
            "Ljava/lang/Iterable",
            "<+",
            "Lcom/google/protobuf/DescriptorProtos$ServiceDescriptorProto;",
            ">;)",
            "Lcom/google/protobuf/DescriptorProtos$FileDescriptorProto$Builder;"
        }
    .end annotation

    .prologue
    .line 2355
    iget-object v0, p0, Lcom/google/protobuf/DescriptorProtos$FileDescriptorProto$Builder;->serviceBuilder_:Lcom/google/protobuf/RepeatedFieldBuilder;

    if-nez v0, :cond_0

    .line 2356
    invoke-direct {p0}, Lcom/google/protobuf/DescriptorProtos$FileDescriptorProto$Builder;->ensureServiceIsMutable()V

    .line 2357
    iget-object v0, p0, Lcom/google/protobuf/DescriptorProtos$FileDescriptorProto$Builder;->service_:Ljava/util/List;

    invoke-static {p1, v0}, Lcom/google/protobuf/GeneratedMessage$Builder;->addAll(Ljava/lang/Iterable;Ljava/util/Collection;)V

    .line 2358
    invoke-virtual {p0}, Lcom/google/protobuf/DescriptorProtos$FileDescriptorProto$Builder;->onChanged()V

    .line 2362
    :goto_0
    return-object p0

    .line 2360
    :cond_0
    iget-object v0, p0, Lcom/google/protobuf/DescriptorProtos$FileDescriptorProto$Builder;->serviceBuilder_:Lcom/google/protobuf/RepeatedFieldBuilder;

    invoke-virtual {v0, p1}, Lcom/google/protobuf/RepeatedFieldBuilder;->addAllMessages(Ljava/lang/Iterable;)Lcom/google/protobuf/RepeatedFieldBuilder;

    goto :goto_0
.end method

.method public addAllWeakDependency(Ljava/lang/Iterable;)Lcom/google/protobuf/DescriptorProtos$FileDescriptorProto$Builder;
    .locals 1
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "(",
            "Ljava/lang/Iterable",
            "<+",
            "Ljava/lang/Integer;",
            ">;)",
            "Lcom/google/protobuf/DescriptorProtos$FileDescriptorProto$Builder;"
        }
    .end annotation

    .prologue
    .line 1861
    invoke-direct {p0}, Lcom/google/protobuf/DescriptorProtos$FileDescriptorProto$Builder;->ensureWeakDependencyIsMutable()V

    .line 1862
    iget-object v0, p0, Lcom/google/protobuf/DescriptorProtos$FileDescriptorProto$Builder;->weakDependency_:Ljava/util/List;

    invoke-static {p1, v0}, Lcom/google/protobuf/GeneratedMessage$Builder;->addAll(Ljava/lang/Iterable;Ljava/util/Collection;)V

    .line 1863
    invoke-virtual {p0}, Lcom/google/protobuf/DescriptorProtos$FileDescriptorProto$Builder;->onChanged()V

    .line 1864
    return-object p0
.end method

.method public addDependency(Ljava/lang/String;)Lcom/google/protobuf/DescriptorProtos$FileDescriptorProto$Builder;
    .locals 1

    .prologue
    .line 1756
    if-nez p1, :cond_0

    .line 1757
    new-instance v0, Ljava/lang/NullPointerException;

    invoke-direct {v0}, Ljava/lang/NullPointerException;-><init>()V

    throw v0

    .line 1759
    :cond_0
    invoke-direct {p0}, Lcom/google/protobuf/DescriptorProtos$FileDescriptorProto$Builder;->ensureDependencyIsMutable()V

    .line 1760
    iget-object v0, p0, Lcom/google/protobuf/DescriptorProtos$FileDescriptorProto$Builder;->dependency_:Lcom/google/protobuf/LazyStringList;

    invoke-interface {v0, p1}, Lcom/google/protobuf/LazyStringList;->add(Ljava/lang/Object;)Z

    .line 1761
    invoke-virtual {p0}, Lcom/google/protobuf/DescriptorProtos$FileDescriptorProto$Builder;->onChanged()V

    .line 1762
    return-object p0
.end method

.method addDependency(Lcom/google/protobuf/ByteString;)V
    .locals 1

    .prologue
    .line 1778
    invoke-direct {p0}, Lcom/google/protobuf/DescriptorProtos$FileDescriptorProto$Builder;->ensureDependencyIsMutable()V

    .line 1779
    iget-object v0, p0, Lcom/google/protobuf/DescriptorProtos$FileDescriptorProto$Builder;->dependency_:Lcom/google/protobuf/LazyStringList;

    invoke-interface {v0, p1}, Lcom/google/protobuf/LazyStringList;->add(Lcom/google/protobuf/ByteString;)V

    .line 1780
    invoke-virtual {p0}, Lcom/google/protobuf/DescriptorProtos$FileDescriptorProto$Builder;->onChanged()V

    .line 1781
    return-void
.end method

.method public addEnumType(ILcom/google/protobuf/DescriptorProtos$EnumDescriptorProto$Builder;)Lcom/google/protobuf/DescriptorProtos$FileDescriptorProto$Builder;
    .locals 2

    .prologue
    .line 2158
    iget-object v0, p0, Lcom/google/protobuf/DescriptorProtos$FileDescriptorProto$Builder;->enumTypeBuilder_:Lcom/google/protobuf/RepeatedFieldBuilder;

    if-nez v0, :cond_0

    .line 2159
    invoke-direct {p0}, Lcom/google/protobuf/DescriptorProtos$FileDescriptorProto$Builder;->ensureEnumTypeIsMutable()V

    .line 2160
    iget-object v0, p0, Lcom/google/protobuf/DescriptorProtos$FileDescriptorProto$Builder;->enumType_:Ljava/util/List;

    invoke-virtual {p2}, Lcom/google/protobuf/DescriptorProtos$EnumDescriptorProto$Builder;->build()Lcom/google/protobuf/DescriptorProtos$EnumDescriptorProto;

    move-result-object v1

    invoke-interface {v0, p1, v1}, Ljava/util/List;->add(ILjava/lang/Object;)V

    .line 2161
    invoke-virtual {p0}, Lcom/google/protobuf/DescriptorProtos$FileDescriptorProto$Builder;->onChanged()V

    .line 2165
    :goto_0
    return-object p0

    .line 2163
    :cond_0
    iget-object v0, p0, Lcom/google/protobuf/DescriptorProtos$FileDescriptorProto$Builder;->enumTypeBuilder_:Lcom/google/protobuf/RepeatedFieldBuilder;

    invoke-virtual {p2}, Lcom/google/protobuf/DescriptorProtos$EnumDescriptorProto$Builder;->build()Lcom/google/protobuf/DescriptorProtos$EnumDescriptorProto;

    move-result-object v1

    invoke-virtual {v0, p1, v1}, Lcom/google/protobuf/RepeatedFieldBuilder;->addMessage(ILcom/google/protobuf/GeneratedMessage;)Lcom/google/protobuf/RepeatedFieldBuilder;

    goto :goto_0
.end method

.method public addEnumType(ILcom/google/protobuf/DescriptorProtos$EnumDescriptorProto;)Lcom/google/protobuf/DescriptorProtos$FileDescriptorProto$Builder;
    .locals 1

    .prologue
    .line 2133
    iget-object v0, p0, Lcom/google/protobuf/DescriptorProtos$FileDescriptorProto$Builder;->enumTypeBuilder_:Lcom/google/protobuf/RepeatedFieldBuilder;

    if-nez v0, :cond_1

    .line 2134
    if-nez p2, :cond_0

    .line 2135
    new-instance v0, Ljava/lang/NullPointerException;

    invoke-direct {v0}, Ljava/lang/NullPointerException;-><init>()V

    throw v0

    .line 2137
    :cond_0
    invoke-direct {p0}, Lcom/google/protobuf/DescriptorProtos$FileDescriptorProto$Builder;->ensureEnumTypeIsMutable()V

    .line 2138
    iget-object v0, p0, Lcom/google/protobuf/DescriptorProtos$FileDescriptorProto$Builder;->enumType_:Ljava/util/List;

    invoke-interface {v0, p1, p2}, Ljava/util/List;->add(ILjava/lang/Object;)V

    .line 2139
    invoke-virtual {p0}, Lcom/google/protobuf/DescriptorProtos$FileDescriptorProto$Builder;->onChanged()V

    .line 2143
    :goto_0
    return-object p0

    .line 2141
    :cond_1
    iget-object v0, p0, Lcom/google/protobuf/DescriptorProtos$FileDescriptorProto$Builder;->enumTypeBuilder_:Lcom/google/protobuf/RepeatedFieldBuilder;

    invoke-virtual {v0, p1, p2}, Lcom/google/protobuf/RepeatedFieldBuilder;->addMessage(ILcom/google/protobuf/GeneratedMessage;)Lcom/google/protobuf/RepeatedFieldBuilder;

    goto :goto_0
.end method

.method public addEnumType(Lcom/google/protobuf/DescriptorProtos$EnumDescriptorProto$Builder;)Lcom/google/protobuf/DescriptorProtos$FileDescriptorProto$Builder;
    .locals 2

    .prologue
    .line 2147
    iget-object v0, p0, Lcom/google/protobuf/DescriptorProtos$FileDescriptorProto$Builder;->enumTypeBuilder_:Lcom/google/protobuf/RepeatedFieldBuilder;

    if-nez v0, :cond_0

    .line 2148
    invoke-direct {p0}, Lcom/google/protobuf/DescriptorProtos$FileDescriptorProto$Builder;->ensureEnumTypeIsMutable()V

    .line 2149
    iget-object v0, p0, Lcom/google/protobuf/DescriptorProtos$FileDescriptorProto$Builder;->enumType_:Ljava/util/List;

    invoke-virtual {p1}, Lcom/google/protobuf/DescriptorProtos$EnumDescriptorProto$Builder;->build()Lcom/google/protobuf/DescriptorProtos$EnumDescriptorProto;

    move-result-object v1

    invoke-interface {v0, v1}, Ljava/util/List;->add(Ljava/lang/Object;)Z

    .line 2150
    invoke-virtual {p0}, Lcom/google/protobuf/DescriptorProtos$FileDescriptorProto$Builder;->onChanged()V

    .line 2154
    :goto_0
    return-object p0

    .line 2152
    :cond_0
    iget-object v0, p0, Lcom/google/protobuf/DescriptorProtos$FileDescriptorProto$Builder;->enumTypeBuilder_:Lcom/google/protobuf/RepeatedFieldBuilder;

    invoke-virtual {p1}, Lcom/google/protobuf/DescriptorProtos$EnumDescriptorProto$Builder;->build()Lcom/google/protobuf/DescriptorProtos$EnumDescriptorProto;

    move-result-object v1

    invoke-virtual {v0, v1}, Lcom/google/protobuf/RepeatedFieldBuilder;->addMessage(Lcom/google/protobuf/GeneratedMessage;)Lcom/google/protobuf/RepeatedFieldBuilder;

    goto :goto_0
.end method

.method public addEnumType(Lcom/google/protobuf/DescriptorProtos$EnumDescriptorProto;)Lcom/google/protobuf/DescriptorProtos$FileDescriptorProto$Builder;
    .locals 1

    .prologue
    .line 2119
    iget-object v0, p0, Lcom/google/protobuf/DescriptorProtos$FileDescriptorProto$Builder;->enumTypeBuilder_:Lcom/google/protobuf/RepeatedFieldBuilder;

    if-nez v0, :cond_1

    .line 2120
    if-nez p1, :cond_0

    .line 2121
    new-instance v0, Ljava/lang/NullPointerException;

    invoke-direct {v0}, Ljava/lang/NullPointerException;-><init>()V

    throw v0

    .line 2123
    :cond_0
    invoke-direct {p0}, Lcom/google/protobuf/DescriptorProtos$FileDescriptorProto$Builder;->ensureEnumTypeIsMutable()V

    .line 2124
    iget-object v0, p0, Lcom/google/protobuf/DescriptorProtos$FileDescriptorProto$Builder;->enumType_:Ljava/util/List;

    invoke-interface {v0, p1}, Ljava/util/List;->add(Ljava/lang/Object;)Z

    .line 2125
    invoke-virtual {p0}, Lcom/google/protobuf/DescriptorProtos$FileDescriptorProto$Builder;->onChanged()V

    .line 2129
    :goto_0
    return-object p0

    .line 2127
    :cond_1
    iget-object v0, p0, Lcom/google/protobuf/DescriptorProtos$FileDescriptorProto$Builder;->enumTypeBuilder_:Lcom/google/protobuf/RepeatedFieldBuilder;

    invoke-virtual {v0, p1}, Lcom/google/protobuf/RepeatedFieldBuilder;->addMessage(Lcom/google/protobuf/GeneratedMessage;)Lcom/google/protobuf/RepeatedFieldBuilder;

    goto :goto_0
.end method

.method public addEnumTypeBuilder()Lcom/google/protobuf/DescriptorProtos$EnumDescriptorProto$Builder;
    .locals 2

    .prologue
    .line 2218
    invoke-direct {p0}, Lcom/google/protobuf/DescriptorProtos$FileDescriptorProto$Builder;->getEnumTypeFieldBuilder()Lcom/google/protobuf/RepeatedFieldBuilder;

    move-result-object v0

    .line 2219
    invoke-static {}, Lcom/google/protobuf/DescriptorProtos$EnumDescriptorProto;->getDefaultInstance()Lcom/google/protobuf/DescriptorProtos$EnumDescriptorProto;

    move-result-object v1

    .line 2218
    invoke-virtual {v0, v1}, Lcom/google/protobuf/RepeatedFieldBuilder;->addBuilder(Lcom/google/protobuf/GeneratedMessage;)Lcom/google/protobuf/GeneratedMessage$Builder;

    move-result-object v0

    check-cast v0, Lcom/google/protobuf/DescriptorProtos$EnumDescriptorProto$Builder;

    return-object v0
.end method

.method public addEnumTypeBuilder(I)Lcom/google/protobuf/DescriptorProtos$EnumDescriptorProto$Builder;
    .locals 2

    .prologue
    .line 2223
    invoke-direct {p0}, Lcom/google/protobuf/DescriptorProtos$FileDescriptorProto$Builder;->getEnumTypeFieldBuilder()Lcom/google/protobuf/RepeatedFieldBuilder;

    move-result-object v0

    .line 2224
    invoke-static {}, Lcom/google/protobuf/DescriptorProtos$EnumDescriptorProto;->getDefaultInstance()Lcom/google/protobuf/DescriptorProtos$EnumDescriptorProto;

    move-result-object v1

    .line 2223
    invoke-virtual {v0, p1, v1}, Lcom/google/protobuf/RepeatedFieldBuilder;->addBuilder(ILcom/google/protobuf/GeneratedMessage;)Lcom/google/protobuf/GeneratedMessage$Builder;

    move-result-object v0

    check-cast v0, Lcom/google/protobuf/DescriptorProtos$EnumDescriptorProto$Builder;

    return-object v0
.end method

.method public addExtension(ILcom/google/protobuf/DescriptorProtos$FieldDescriptorProto$Builder;)Lcom/google/protobuf/DescriptorProtos$FileDescriptorProto$Builder;
    .locals 2

    .prologue
    .line 2530
    iget-object v0, p0, Lcom/google/protobuf/DescriptorProtos$FileDescriptorProto$Builder;->extensionBuilder_:Lcom/google/protobuf/RepeatedFieldBuilder;

    if-nez v0, :cond_0

    .line 2531
    invoke-direct {p0}, Lcom/google/protobuf/DescriptorProtos$FileDescriptorProto$Builder;->ensureExtensionIsMutable()V

    .line 2532
    iget-object v0, p0, Lcom/google/protobuf/DescriptorProtos$FileDescriptorProto$Builder;->extension_:Ljava/util/List;

    invoke-virtual {p2}, Lcom/google/protobuf/DescriptorProtos$FieldDescriptorProto$Builder;->build()Lcom/google/protobuf/DescriptorProtos$FieldDescriptorProto;

    move-result-object v1

    invoke-interface {v0, p1, v1}, Ljava/util/List;->add(ILjava/lang/Object;)V

    .line 2533
    invoke-virtual {p0}, Lcom/google/protobuf/DescriptorProtos$FileDescriptorProto$Builder;->onChanged()V

    .line 2537
    :goto_0
    return-object p0

    .line 2535
    :cond_0
    iget-object v0, p0, Lcom/google/protobuf/DescriptorProtos$FileDescriptorProto$Builder;->extensionBuilder_:Lcom/google/protobuf/RepeatedFieldBuilder;

    invoke-virtual {p2}, Lcom/google/protobuf/DescriptorProtos$FieldDescriptorProto$Builder;->build()Lcom/google/protobuf/DescriptorProtos$FieldDescriptorProto;

    move-result-object v1

    invoke-virtual {v0, p1, v1}, Lcom/google/protobuf/RepeatedFieldBuilder;->addMessage(ILcom/google/protobuf/GeneratedMessage;)Lcom/google/protobuf/RepeatedFieldBuilder;

    goto :goto_0
.end method

.method public addExtension(ILcom/google/protobuf/DescriptorProtos$FieldDescriptorProto;)Lcom/google/protobuf/DescriptorProtos$FileDescriptorProto$Builder;
    .locals 1

    .prologue
    .line 2505
    iget-object v0, p0, Lcom/google/protobuf/DescriptorProtos$FileDescriptorProto$Builder;->extensionBuilder_:Lcom/google/protobuf/RepeatedFieldBuilder;

    if-nez v0, :cond_1

    .line 2506
    if-nez p2, :cond_0

    .line 2507
    new-instance v0, Ljava/lang/NullPointerException;

    invoke-direct {v0}, Ljava/lang/NullPointerException;-><init>()V

    throw v0

    .line 2509
    :cond_0
    invoke-direct {p0}, Lcom/google/protobuf/DescriptorProtos$FileDescriptorProto$Builder;->ensureExtensionIsMutable()V

    .line 2510
    iget-object v0, p0, Lcom/google/protobuf/DescriptorProtos$FileDescriptorProto$Builder;->extension_:Ljava/util/List;

    invoke-interface {v0, p1, p2}, Ljava/util/List;->add(ILjava/lang/Object;)V

    .line 2511
    invoke-virtual {p0}, Lcom/google/protobuf/DescriptorProtos$FileDescriptorProto$Builder;->onChanged()V

    .line 2515
    :goto_0
    return-object p0

    .line 2513
    :cond_1
    iget-object v0, p0, Lcom/google/protobuf/DescriptorProtos$FileDescriptorProto$Builder;->extensionBuilder_:Lcom/google/protobuf/RepeatedFieldBuilder;

    invoke-virtual {v0, p1, p2}, Lcom/google/protobuf/RepeatedFieldBuilder;->addMessage(ILcom/google/protobuf/GeneratedMessage;)Lcom/google/protobuf/RepeatedFieldBuilder;

    goto :goto_0
.end method

.method public addExtension(Lcom/google/protobuf/DescriptorProtos$FieldDescriptorProto$Builder;)Lcom/google/protobuf/DescriptorProtos$FileDescriptorProto$Builder;
    .locals 2

    .prologue
    .line 2519
    iget-object v0, p0, Lcom/google/protobuf/DescriptorProtos$FileDescriptorProto$Builder;->extensionBuilder_:Lcom/google/protobuf/RepeatedFieldBuilder;

    if-nez v0, :cond_0

    .line 2520
    invoke-direct {p0}, Lcom/google/protobuf/DescriptorProtos$FileDescriptorProto$Builder;->ensureExtensionIsMutable()V

    .line 2521
    iget-object v0, p0, Lcom/google/protobuf/DescriptorProtos$FileDescriptorProto$Builder;->extension_:Ljava/util/List;

    invoke-virtual {p1}, Lcom/google/protobuf/DescriptorProtos$FieldDescriptorProto$Builder;->build()Lcom/google/protobuf/DescriptorProtos$FieldDescriptorProto;

    move-result-object v1

    invoke-interface {v0, v1}, Ljava/util/List;->add(Ljava/lang/Object;)Z

    .line 2522
    invoke-virtual {p0}, Lcom/google/protobuf/DescriptorProtos$FileDescriptorProto$Builder;->onChanged()V

    .line 2526
    :goto_0
    return-object p0

    .line 2524
    :cond_0
    iget-object v0, p0, Lcom/google/protobuf/DescriptorProtos$FileDescriptorProto$Builder;->extensionBuilder_:Lcom/google/protobuf/RepeatedFieldBuilder;

    invoke-virtual {p1}, Lcom/google/protobuf/DescriptorProtos$FieldDescriptorProto$Builder;->build()Lcom/google/protobuf/DescriptorProtos$FieldDescriptorProto;

    move-result-object v1

    invoke-virtual {v0, v1}, Lcom/google/protobuf/RepeatedFieldBuilder;->addMessage(Lcom/google/protobuf/GeneratedMessage;)Lcom/google/protobuf/RepeatedFieldBuilder;

    goto :goto_0
.end method

.method public addExtension(Lcom/google/protobuf/DescriptorProtos$FieldDescriptorProto;)Lcom/google/protobuf/DescriptorProtos$FileDescriptorProto$Builder;
    .locals 1

    .prologue
    .line 2491
    iget-object v0, p0, Lcom/google/protobuf/DescriptorProtos$FileDescriptorProto$Builder;->extensionBuilder_:Lcom/google/protobuf/RepeatedFieldBuilder;

    if-nez v0, :cond_1

    .line 2492
    if-nez p1, :cond_0

    .line 2493
    new-instance v0, Ljava/lang/NullPointerException;

    invoke-direct {v0}, Ljava/lang/NullPointerException;-><init>()V

    throw v0

    .line 2495
    :cond_0
    invoke-direct {p0}, Lcom/google/protobuf/DescriptorProtos$FileDescriptorProto$Builder;->ensureExtensionIsMutable()V

    .line 2496
    iget-object v0, p0, Lcom/google/protobuf/DescriptorProtos$FileDescriptorProto$Builder;->extension_:Ljava/util/List;

    invoke-interface {v0, p1}, Ljava/util/List;->add(Ljava/lang/Object;)Z

    .line 2497
    invoke-virtual {p0}, Lcom/google/protobuf/DescriptorProtos$FileDescriptorProto$Builder;->onChanged()V

    .line 2501
    :goto_0
    return-object p0

    .line 2499
    :cond_1
    iget-object v0, p0, Lcom/google/protobuf/DescriptorProtos$FileDescriptorProto$Builder;->extensionBuilder_:Lcom/google/protobuf/RepeatedFieldBuilder;

    invoke-virtual {v0, p1}, Lcom/google/protobuf/RepeatedFieldBuilder;->addMessage(Lcom/google/protobuf/GeneratedMessage;)Lcom/google/protobuf/RepeatedFieldBuilder;

    goto :goto_0
.end method

.method public addExtensionBuilder()Lcom/google/protobuf/DescriptorProtos$FieldDescriptorProto$Builder;
    .locals 2

    .prologue
    .line 2590
    invoke-direct {p0}, Lcom/google/protobuf/DescriptorProtos$FileDescriptorProto$Builder;->getExtensionFieldBuilder()Lcom/google/protobuf/RepeatedFieldBuilder;

    move-result-object v0

    .line 2591
    invoke-static {}, Lcom/google/protobuf/DescriptorProtos$FieldDescriptorProto;->getDefaultInstance()Lcom/google/protobuf/DescriptorProtos$FieldDescriptorProto;

    move-result-object v1

    .line 2590
    invoke-virtual {v0, v1}, Lcom/google/protobuf/RepeatedFieldBuilder;->addBuilder(Lcom/google/protobuf/GeneratedMessage;)Lcom/google/protobuf/GeneratedMessage$Builder;

    move-result-object v0

    check-cast v0, Lcom/google/protobuf/DescriptorProtos$FieldDescriptorProto$Builder;

    return-object v0
.end method

.method public addExtensionBuilder(I)Lcom/google/protobuf/DescriptorProtos$FieldDescriptorProto$Builder;
    .locals 2

    .prologue
    .line 2595
    invoke-direct {p0}, Lcom/google/protobuf/DescriptorProtos$FileDescriptorProto$Builder;->getExtensionFieldBuilder()Lcom/google/protobuf/RepeatedFieldBuilder;

    move-result-object v0

    .line 2596
    invoke-static {}, Lcom/google/protobuf/DescriptorProtos$FieldDescriptorProto;->getDefaultInstance()Lcom/google/protobuf/DescriptorProtos$FieldDescriptorProto;

    move-result-object v1

    .line 2595
    invoke-virtual {v0, p1, v1}, Lcom/google/protobuf/RepeatedFieldBuilder;->addBuilder(ILcom/google/protobuf/GeneratedMessage;)Lcom/google/protobuf/GeneratedMessage$Builder;

    move-result-object v0

    check-cast v0, Lcom/google/protobuf/DescriptorProtos$FieldDescriptorProto$Builder;

    return-object v0
.end method

.method public addMessageType(ILcom/google/protobuf/DescriptorProtos$DescriptorProto$Builder;)Lcom/google/protobuf/DescriptorProtos$FileDescriptorProto$Builder;
    .locals 2

    .prologue
    .line 1972
    iget-object v0, p0, Lcom/google/protobuf/DescriptorProtos$FileDescriptorProto$Builder;->messageTypeBuilder_:Lcom/google/protobuf/RepeatedFieldBuilder;

    if-nez v0, :cond_0

    .line 1973
    invoke-direct {p0}, Lcom/google/protobuf/DescriptorProtos$FileDescriptorProto$Builder;->ensureMessageTypeIsMutable()V

    .line 1974
    iget-object v0, p0, Lcom/google/protobuf/DescriptorProtos$FileDescriptorProto$Builder;->messageType_:Ljava/util/List;

    invoke-virtual {p2}, Lcom/google/protobuf/DescriptorProtos$DescriptorProto$Builder;->build()Lcom/google/protobuf/DescriptorProtos$DescriptorProto;

    move-result-object v1

    invoke-interface {v0, p1, v1}, Ljava/util/List;->add(ILjava/lang/Object;)V

    .line 1975
    invoke-virtual {p0}, Lcom/google/protobuf/DescriptorProtos$FileDescriptorProto$Builder;->onChanged()V

    .line 1979
    :goto_0
    return-object p0

    .line 1977
    :cond_0
    iget-object v0, p0, Lcom/google/protobuf/DescriptorProtos$FileDescriptorProto$Builder;->messageTypeBuilder_:Lcom/google/protobuf/RepeatedFieldBuilder;

    invoke-virtual {p2}, Lcom/google/protobuf/DescriptorProtos$DescriptorProto$Builder;->build()Lcom/google/protobuf/DescriptorProtos$DescriptorProto;

    move-result-object v1

    invoke-virtual {v0, p1, v1}, Lcom/google/protobuf/RepeatedFieldBuilder;->addMessage(ILcom/google/protobuf/GeneratedMessage;)Lcom/google/protobuf/RepeatedFieldBuilder;

    goto :goto_0
.end method

.method public addMessageType(ILcom/google/protobuf/DescriptorProtos$DescriptorProto;)Lcom/google/protobuf/DescriptorProtos$FileDescriptorProto$Builder;
    .locals 1

    .prologue
    .line 1947
    iget-object v0, p0, Lcom/google/protobuf/DescriptorProtos$FileDescriptorProto$Builder;->messageTypeBuilder_:Lcom/google/protobuf/RepeatedFieldBuilder;

    if-nez v0, :cond_1

    .line 1948
    if-nez p2, :cond_0

    .line 1949
    new-instance v0, Ljava/lang/NullPointerException;

    invoke-direct {v0}, Ljava/lang/NullPointerException;-><init>()V

    throw v0

    .line 1951
    :cond_0
    invoke-direct {p0}, Lcom/google/protobuf/DescriptorProtos$FileDescriptorProto$Builder;->ensureMessageTypeIsMutable()V

    .line 1952
    iget-object v0, p0, Lcom/google/protobuf/DescriptorProtos$FileDescriptorProto$Builder;->messageType_:Ljava/util/List;

    invoke-interface {v0, p1, p2}, Ljava/util/List;->add(ILjava/lang/Object;)V

    .line 1953
    invoke-virtual {p0}, Lcom/google/protobuf/DescriptorProtos$FileDescriptorProto$Builder;->onChanged()V

    .line 1957
    :goto_0
    return-object p0

    .line 1955
    :cond_1
    iget-object v0, p0, Lcom/google/protobuf/DescriptorProtos$FileDescriptorProto$Builder;->messageTypeBuilder_:Lcom/google/protobuf/RepeatedFieldBuilder;

    invoke-virtual {v0, p1, p2}, Lcom/google/protobuf/RepeatedFieldBuilder;->addMessage(ILcom/google/protobuf/GeneratedMessage;)Lcom/google/protobuf/RepeatedFieldBuilder;

    goto :goto_0
.end method

.method public addMessageType(Lcom/google/protobuf/DescriptorProtos$DescriptorProto$Builder;)Lcom/google/protobuf/DescriptorProtos$FileDescriptorProto$Builder;
    .locals 2

    .prologue
    .line 1961
    iget-object v0, p0, Lcom/google/protobuf/DescriptorProtos$FileDescriptorProto$Builder;->messageTypeBuilder_:Lcom/google/protobuf/RepeatedFieldBuilder;

    if-nez v0, :cond_0

    .line 1962
    invoke-direct {p0}, Lcom/google/protobuf/DescriptorProtos$FileDescriptorProto$Builder;->ensureMessageTypeIsMutable()V

    .line 1963
    iget-object v0, p0, Lcom/google/protobuf/DescriptorProtos$FileDescriptorProto$Builder;->messageType_:Ljava/util/List;

    invoke-virtual {p1}, Lcom/google/protobuf/DescriptorProtos$DescriptorProto$Builder;->build()Lcom/google/protobuf/DescriptorProtos$DescriptorProto;

    move-result-object v1

    invoke-interface {v0, v1}, Ljava/util/List;->add(Ljava/lang/Object;)Z

    .line 1964
    invoke-virtual {p0}, Lcom/google/protobuf/DescriptorProtos$FileDescriptorProto$Builder;->onChanged()V

    .line 1968
    :goto_0
    return-object p0

    .line 1966
    :cond_0
    iget-object v0, p0, Lcom/google/protobuf/DescriptorProtos$FileDescriptorProto$Builder;->messageTypeBuilder_:Lcom/google/protobuf/RepeatedFieldBuilder;

    invoke-virtual {p1}, Lcom/google/protobuf/DescriptorProtos$DescriptorProto$Builder;->build()Lcom/google/protobuf/DescriptorProtos$DescriptorProto;

    move-result-object v1

    invoke-virtual {v0, v1}, Lcom/google/protobuf/RepeatedFieldBuilder;->addMessage(Lcom/google/protobuf/GeneratedMessage;)Lcom/google/protobuf/RepeatedFieldBuilder;

    goto :goto_0
.end method

.method public addMessageType(Lcom/google/protobuf/DescriptorProtos$DescriptorProto;)Lcom/google/protobuf/DescriptorProtos$FileDescriptorProto$Builder;
    .locals 1

    .prologue
    .line 1933
    iget-object v0, p0, Lcom/google/protobuf/DescriptorProtos$FileDescriptorProto$Builder;->messageTypeBuilder_:Lcom/google/protobuf/RepeatedFieldBuilder;

    if-nez v0, :cond_1

    .line 1934
    if-nez p1, :cond_0

    .line 1935
    new-instance v0, Ljava/lang/NullPointerException;

    invoke-direct {v0}, Ljava/lang/NullPointerException;-><init>()V

    throw v0

    .line 1937
    :cond_0
    invoke-direct {p0}, Lcom/google/protobuf/DescriptorProtos$FileDescriptorProto$Builder;->ensureMessageTypeIsMutable()V

    .line 1938
    iget-object v0, p0, Lcom/google/protobuf/DescriptorProtos$FileDescriptorProto$Builder;->messageType_:Ljava/util/List;

    invoke-interface {v0, p1}, Ljava/util/List;->add(Ljava/lang/Object;)Z

    .line 1939
    invoke-virtual {p0}, Lcom/google/protobuf/DescriptorProtos$FileDescriptorProto$Builder;->onChanged()V

    .line 1943
    :goto_0
    return-object p0

    .line 1941
    :cond_1
    iget-object v0, p0, Lcom/google/protobuf/DescriptorProtos$FileDescriptorProto$Builder;->messageTypeBuilder_:Lcom/google/protobuf/RepeatedFieldBuilder;

    invoke-virtual {v0, p1}, Lcom/google/protobuf/RepeatedFieldBuilder;->addMessage(Lcom/google/protobuf/GeneratedMessage;)Lcom/google/protobuf/RepeatedFieldBuilder;

    goto :goto_0
.end method

.method public addMessageTypeBuilder()Lcom/google/protobuf/DescriptorProtos$DescriptorProto$Builder;
    .locals 2

    .prologue
    .line 2032
    invoke-direct {p0}, Lcom/google/protobuf/DescriptorProtos$FileDescriptorProto$Builder;->getMessageTypeFieldBuilder()Lcom/google/protobuf/RepeatedFieldBuilder;

    move-result-object v0

    .line 2033
    invoke-static {}, Lcom/google/protobuf/DescriptorProtos$DescriptorProto;->getDefaultInstance()Lcom/google/protobuf/DescriptorProtos$DescriptorProto;

    move-result-object v1

    .line 2032
    invoke-virtual {v0, v1}, Lcom/google/protobuf/RepeatedFieldBuilder;->addBuilder(Lcom/google/protobuf/GeneratedMessage;)Lcom/google/protobuf/GeneratedMessage$Builder;

    move-result-object v0

    check-cast v0, Lcom/google/protobuf/DescriptorProtos$DescriptorProto$Builder;

    return-object v0
.end method

.method public addMessageTypeBuilder(I)Lcom/google/protobuf/DescriptorProtos$DescriptorProto$Builder;
    .locals 2

    .prologue
    .line 2037
    invoke-direct {p0}, Lcom/google/protobuf/DescriptorProtos$FileDescriptorProto$Builder;->getMessageTypeFieldBuilder()Lcom/google/protobuf/RepeatedFieldBuilder;

    move-result-object v0

    .line 2038
    invoke-static {}, Lcom/google/protobuf/DescriptorProtos$DescriptorProto;->getDefaultInstance()Lcom/google/protobuf/DescriptorProtos$DescriptorProto;

    move-result-object v1

    .line 2037
    invoke-virtual {v0, p1, v1}, Lcom/google/protobuf/RepeatedFieldBuilder;->addBuilder(ILcom/google/protobuf/GeneratedMessage;)Lcom/google/protobuf/GeneratedMessage$Builder;

    move-result-object v0

    check-cast v0, Lcom/google/protobuf/DescriptorProtos$DescriptorProto$Builder;

    return-object v0
.end method

.method public addPublicDependency(I)Lcom/google/protobuf/DescriptorProtos$FileDescriptorProto$Builder;
    .locals 2

    .prologue
    .line 1809
    invoke-direct {p0}, Lcom/google/protobuf/DescriptorProtos$FileDescriptorProto$Builder;->ensurePublicDependencyIsMutable()V

    .line 1810
    iget-object v0, p0, Lcom/google/protobuf/DescriptorProtos$FileDescriptorProto$Builder;->publicDependency_:Ljava/util/List;

    invoke-static {p1}, Ljava/lang/Integer;->valueOf(I)Ljava/lang/Integer;

    move-result-object v1

    invoke-interface {v0, v1}, Ljava/util/List;->add(Ljava/lang/Object;)Z

    .line 1811
    invoke-virtual {p0}, Lcom/google/protobuf/DescriptorProtos$FileDescriptorProto$Builder;->onChanged()V

    .line 1812
    return-object p0
.end method

.method public addService(ILcom/google/protobuf/DescriptorProtos$ServiceDescriptorProto$Builder;)Lcom/google/protobuf/DescriptorProtos$FileDescriptorProto$Builder;
    .locals 2

    .prologue
    .line 2344
    iget-object v0, p0, Lcom/google/protobuf/DescriptorProtos$FileDescriptorProto$Builder;->serviceBuilder_:Lcom/google/protobuf/RepeatedFieldBuilder;

    if-nez v0, :cond_0

    .line 2345
    invoke-direct {p0}, Lcom/google/protobuf/DescriptorProtos$FileDescriptorProto$Builder;->ensureServiceIsMutable()V

    .line 2346
    iget-object v0, p0, Lcom/google/protobuf/DescriptorProtos$FileDescriptorProto$Builder;->service_:Ljava/util/List;

    invoke-virtual {p2}, Lcom/google/protobuf/DescriptorProtos$ServiceDescriptorProto$Builder;->build()Lcom/google/protobuf/DescriptorProtos$ServiceDescriptorProto;

    move-result-object v1

    invoke-interface {v0, p1, v1}, Ljava/util/List;->add(ILjava/lang/Object;)V

    .line 2347
    invoke-virtual {p0}, Lcom/google/protobuf/DescriptorProtos$FileDescriptorProto$Builder;->onChanged()V

    .line 2351
    :goto_0
    return-object p0

    .line 2349
    :cond_0
    iget-object v0, p0, Lcom/google/protobuf/DescriptorProtos$FileDescriptorProto$Builder;->serviceBuilder_:Lcom/google/protobuf/RepeatedFieldBuilder;

    invoke-virtual {p2}, Lcom/google/protobuf/DescriptorProtos$ServiceDescriptorProto$Builder;->build()Lcom/google/protobuf/DescriptorProtos$ServiceDescriptorProto;

    move-result-object v1

    invoke-virtual {v0, p1, v1}, Lcom/google/protobuf/RepeatedFieldBuilder;->addMessage(ILcom/google/protobuf/GeneratedMessage;)Lcom/google/protobuf/RepeatedFieldBuilder;

    goto :goto_0
.end method

.method public addService(ILcom/google/protobuf/DescriptorProtos$ServiceDescriptorProto;)Lcom/google/protobuf/DescriptorProtos$FileDescriptorProto$Builder;
    .locals 1

    .prologue
    .line 2319
    iget-object v0, p0, Lcom/google/protobuf/DescriptorProtos$FileDescriptorProto$Builder;->serviceBuilder_:Lcom/google/protobuf/RepeatedFieldBuilder;

    if-nez v0, :cond_1

    .line 2320
    if-nez p2, :cond_0

    .line 2321
    new-instance v0, Ljava/lang/NullPointerException;

    invoke-direct {v0}, Ljava/lang/NullPointerException;-><init>()V

    throw v0

    .line 2323
    :cond_0
    invoke-direct {p0}, Lcom/google/protobuf/DescriptorProtos$FileDescriptorProto$Builder;->ensureServiceIsMutable()V

    .line 2324
    iget-object v0, p0, Lcom/google/protobuf/DescriptorProtos$FileDescriptorProto$Builder;->service_:Ljava/util/List;

    invoke-interface {v0, p1, p2}, Ljava/util/List;->add(ILjava/lang/Object;)V

    .line 2325
    invoke-virtual {p0}, Lcom/google/protobuf/DescriptorProtos$FileDescriptorProto$Builder;->onChanged()V

    .line 2329
    :goto_0
    return-object p0

    .line 2327
    :cond_1
    iget-object v0, p0, Lcom/google/protobuf/DescriptorProtos$FileDescriptorProto$Builder;->serviceBuilder_:Lcom/google/protobuf/RepeatedFieldBuilder;

    invoke-virtual {v0, p1, p2}, Lcom/google/protobuf/RepeatedFieldBuilder;->addMessage(ILcom/google/protobuf/GeneratedMessage;)Lcom/google/protobuf/RepeatedFieldBuilder;

    goto :goto_0
.end method

.method public addService(Lcom/google/protobuf/DescriptorProtos$ServiceDescriptorProto$Builder;)Lcom/google/protobuf/DescriptorProtos$FileDescriptorProto$Builder;
    .locals 2

    .prologue
    .line 2333
    iget-object v0, p0, Lcom/google/protobuf/DescriptorProtos$FileDescriptorProto$Builder;->serviceBuilder_:Lcom/google/protobuf/RepeatedFieldBuilder;

    if-nez v0, :cond_0

    .line 2334
    invoke-direct {p0}, Lcom/google/protobuf/DescriptorProtos$FileDescriptorProto$Builder;->ensureServiceIsMutable()V

    .line 2335
    iget-object v0, p0, Lcom/google/protobuf/DescriptorProtos$FileDescriptorProto$Builder;->service_:Ljava/util/List;

    invoke-virtual {p1}, Lcom/google/protobuf/DescriptorProtos$ServiceDescriptorProto$Builder;->build()Lcom/google/protobuf/DescriptorProtos$ServiceDescriptorProto;

    move-result-object v1

    invoke-interface {v0, v1}, Ljava/util/List;->add(Ljava/lang/Object;)Z

    .line 2336
    invoke-virtual {p0}, Lcom/google/protobuf/DescriptorProtos$FileDescriptorProto$Builder;->onChanged()V

    .line 2340
    :goto_0
    return-object p0

    .line 2338
    :cond_0
    iget-object v0, p0, Lcom/google/protobuf/DescriptorProtos$FileDescriptorProto$Builder;->serviceBuilder_:Lcom/google/protobuf/RepeatedFieldBuilder;

    invoke-virtual {p1}, Lcom/google/protobuf/DescriptorProtos$ServiceDescriptorProto$Builder;->build()Lcom/google/protobuf/DescriptorProtos$ServiceDescriptorProto;

    move-result-object v1

    invoke-virtual {v0, v1}, Lcom/google/protobuf/RepeatedFieldBuilder;->addMessage(Lcom/google/protobuf/GeneratedMessage;)Lcom/google/protobuf/RepeatedFieldBuilder;

    goto :goto_0
.end method

.method public addService(Lcom/google/protobuf/DescriptorProtos$ServiceDescriptorProto;)Lcom/google/protobuf/DescriptorProtos$FileDescriptorProto$Builder;
    .locals 1

    .prologue
    .line 2305
    iget-object v0, p0, Lcom/google/protobuf/DescriptorProtos$FileDescriptorProto$Builder;->serviceBuilder_:Lcom/google/protobuf/RepeatedFieldBuilder;

    if-nez v0, :cond_1

    .line 2306
    if-nez p1, :cond_0

    .line 2307
    new-instance v0, Ljava/lang/NullPointerException;

    invoke-direct {v0}, Ljava/lang/NullPointerException;-><init>()V

    throw v0

    .line 2309
    :cond_0
    invoke-direct {p0}, Lcom/google/protobuf/DescriptorProtos$FileDescriptorProto$Builder;->ensureServiceIsMutable()V

    .line 2310
    iget-object v0, p0, Lcom/google/protobuf/DescriptorProtos$FileDescriptorProto$Builder;->service_:Ljava/util/List;

    invoke-interface {v0, p1}, Ljava/util/List;->add(Ljava/lang/Object;)Z

    .line 2311
    invoke-virtual {p0}, Lcom/google/protobuf/DescriptorProtos$FileDescriptorProto$Builder;->onChanged()V

    .line 2315
    :goto_0
    return-object p0

    .line 2313
    :cond_1
    iget-object v0, p0, Lcom/google/protobuf/DescriptorProtos$FileDescriptorProto$Builder;->serviceBuilder_:Lcom/google/protobuf/RepeatedFieldBuilder;

    invoke-virtual {v0, p1}, Lcom/google/protobuf/RepeatedFieldBuilder;->addMessage(Lcom/google/protobuf/GeneratedMessage;)Lcom/google/protobuf/RepeatedFieldBuilder;

    goto :goto_0
.end method

.method public addServiceBuilder()Lcom/google/protobuf/DescriptorProtos$ServiceDescriptorProto$Builder;
    .locals 2

    .prologue
    .line 2404
    invoke-direct {p0}, Lcom/google/protobuf/DescriptorProtos$FileDescriptorProto$Builder;->getServiceFieldBuilder()Lcom/google/protobuf/RepeatedFieldBuilder;

    move-result-object v0

    .line 2405
    invoke-static {}, Lcom/google/protobuf/DescriptorProtos$ServiceDescriptorProto;->getDefaultInstance()Lcom/google/protobuf/DescriptorProtos$ServiceDescriptorProto;

    move-result-object v1

    .line 2404
    invoke-virtual {v0, v1}, Lcom/google/protobuf/RepeatedFieldBuilder;->addBuilder(Lcom/google/protobuf/GeneratedMessage;)Lcom/google/protobuf/GeneratedMessage$Builder;

    move-result-object v0

    check-cast v0, Lcom/google/protobuf/DescriptorProtos$ServiceDescriptorProto$Builder;

    return-object v0
.end method

.method public addServiceBuilder(I)Lcom/google/protobuf/DescriptorProtos$ServiceDescriptorProto$Builder;
    .locals 2

    .prologue
    .line 2409
    invoke-direct {p0}, Lcom/google/protobuf/DescriptorProtos$FileDescriptorProto$Builder;->getServiceFieldBuilder()Lcom/google/protobuf/RepeatedFieldBuilder;

    move-result-object v0

    .line 2410
    invoke-static {}, Lcom/google/protobuf/DescriptorProtos$ServiceDescriptorProto;->getDefaultInstance()Lcom/google/protobuf/DescriptorProtos$ServiceDescriptorProto;

    move-result-object v1

    .line 2409
    invoke-virtual {v0, p1, v1}, Lcom/google/protobuf/RepeatedFieldBuilder;->addBuilder(ILcom/google/protobuf/GeneratedMessage;)Lcom/google/protobuf/GeneratedMessage$Builder;

    move-result-object v0

    check-cast v0, Lcom/google/protobuf/DescriptorProtos$ServiceDescriptorProto$Builder;

    return-object v0
.end method

.method public addWeakDependency(I)Lcom/google/protobuf/DescriptorProtos$FileDescriptorProto$Builder;
    .locals 2

    .prologue
    .line 1854
    invoke-direct {p0}, Lcom/google/protobuf/DescriptorProtos$FileDescriptorProto$Builder;->ensureWeakDependencyIsMutable()V

    .line 1855
    iget-object v0, p0, Lcom/google/protobuf/DescriptorProtos$FileDescriptorProto$Builder;->weakDependency_:Ljava/util/List;

    invoke-static {p1}, Ljava/lang/Integer;->valueOf(I)Ljava/lang/Integer;

    move-result-object v1

    invoke-interface {v0, v1}, Ljava/util/List;->add(Ljava/lang/Object;)Z

    .line 1856
    invoke-virtual {p0}, Lcom/google/protobuf/DescriptorProtos$FileDescriptorProto$Builder;->onChanged()V

    .line 1857
    return-object p0
.end method

.method public build()Lcom/google/protobuf/DescriptorProtos$FileDescriptorProto;
    .locals 2

    .prologue
    .line 1244
    invoke-virtual {p0}, Lcom/google/protobuf/DescriptorProtos$FileDescriptorProto$Builder;->buildPartial()Lcom/google/protobuf/DescriptorProtos$FileDescriptorProto;

    move-result-object v0

    .line 1245
    invoke-virtual {v0}, Lcom/google/protobuf/DescriptorProtos$FileDescriptorProto;->isInitialized()Z

    move-result v1

    if-nez v1, :cond_0

    .line 1246
    invoke-static {v0}, Lcom/google/protobuf/DescriptorProtos$FileDescriptorProto$Builder;->newUninitializedMessageException(Lcom/google/protobuf/Message;)Lcom/google/protobuf/UninitializedMessageException;

    move-result-object v0

    throw v0

    .line 1248
    :cond_0
    return-object v0
.end method

.method public bridge synthetic build()Lcom/google/protobuf/Message;
    .locals 1

    .prologue
    .line 1
    invoke-virtual {p0}, Lcom/google/protobuf/DescriptorProtos$FileDescriptorProto$Builder;->build()Lcom/google/protobuf/DescriptorProtos$FileDescriptorProto;

    move-result-object v0

    return-object v0
.end method

.method public bridge synthetic build()Lcom/google/protobuf/MessageLite;
    .locals 1

    .prologue
    .line 1
    invoke-virtual {p0}, Lcom/google/protobuf/DescriptorProtos$FileDescriptorProto$Builder;->build()Lcom/google/protobuf/DescriptorProtos$FileDescriptorProto;

    move-result-object v0

    return-object v0
.end method

.method public buildPartial()Lcom/google/protobuf/DescriptorProtos$FileDescriptorProto;
    .locals 5

    .prologue
    const/4 v0, 0x1

    .line 1262
    new-instance v2, Lcom/google/protobuf/DescriptorProtos$FileDescriptorProto;

    const/4 v1, 0x0

    invoke-direct {v2, p0, v1}, Lcom/google/protobuf/DescriptorProtos$FileDescriptorProto;-><init>(Lcom/google/protobuf/DescriptorProtos$FileDescriptorProto$Builder;Lcom/google/protobuf/DescriptorProtos$FileDescriptorProto;)V

    .line 1263
    iget v3, p0, Lcom/google/protobuf/DescriptorProtos$FileDescriptorProto$Builder;->bitField0_:I

    .line 1264
    const/4 v1, 0x0

    .line 1265
    and-int/lit8 v4, v3, 0x1

    if-ne v4, v0, :cond_10

    .line 1268
    :goto_0
    iget-object v1, p0, Lcom/google/protobuf/DescriptorProtos$FileDescriptorProto$Builder;->name_:Ljava/lang/Object;

    invoke-static {v2, v1}, Lcom/google/protobuf/DescriptorProtos$FileDescriptorProto;->access$8(Lcom/google/protobuf/DescriptorProtos$FileDescriptorProto;Ljava/lang/Object;)V

    .line 1269
    and-int/lit8 v1, v3, 0x2

    const/4 v4, 0x2

    if-ne v1, v4, :cond_0

    .line 1270
    or-int/lit8 v0, v0, 0x2

    .line 1272
    :cond_0
    iget-object v1, p0, Lcom/google/protobuf/DescriptorProtos$FileDescriptorProto$Builder;->package_:Ljava/lang/Object;

    invoke-static {v2, v1}, Lcom/google/protobuf/DescriptorProtos$FileDescriptorProto;->access$9(Lcom/google/protobuf/DescriptorProtos$FileDescriptorProto;Ljava/lang/Object;)V

    .line 1273
    iget v1, p0, Lcom/google/protobuf/DescriptorProtos$FileDescriptorProto$Builder;->bitField0_:I

    and-int/lit8 v1, v1, 0x4

    const/4 v4, 0x4

    if-ne v1, v4, :cond_1

    .line 1274
    new-instance v1, Lcom/google/protobuf/UnmodifiableLazyStringList;

    .line 1275
    iget-object v4, p0, Lcom/google/protobuf/DescriptorProtos$FileDescriptorProto$Builder;->dependency_:Lcom/google/protobuf/LazyStringList;

    invoke-direct {v1, v4}, Lcom/google/protobuf/UnmodifiableLazyStringList;-><init>(Lcom/google/protobuf/LazyStringList;)V

    .line 1274
    iput-object v1, p0, Lcom/google/protobuf/DescriptorProtos$FileDescriptorProto$Builder;->dependency_:Lcom/google/protobuf/LazyStringList;

    .line 1276
    iget v1, p0, Lcom/google/protobuf/DescriptorProtos$FileDescriptorProto$Builder;->bitField0_:I

    and-int/lit8 v1, v1, -0x5

    iput v1, p0, Lcom/google/protobuf/DescriptorProtos$FileDescriptorProto$Builder;->bitField0_:I

    .line 1278
    :cond_1
    iget-object v1, p0, Lcom/google/protobuf/DescriptorProtos$FileDescriptorProto$Builder;->dependency_:Lcom/google/protobuf/LazyStringList;

    invoke-static {v2, v1}, Lcom/google/protobuf/DescriptorProtos$FileDescriptorProto;->access$10(Lcom/google/protobuf/DescriptorProtos$FileDescriptorProto;Lcom/google/protobuf/LazyStringList;)V

    .line 1279
    iget v1, p0, Lcom/google/protobuf/DescriptorProtos$FileDescriptorProto$Builder;->bitField0_:I

    and-int/lit8 v1, v1, 0x8

    const/16 v4, 0x8

    if-ne v1, v4, :cond_2

    .line 1280
    iget-object v1, p0, Lcom/google/protobuf/DescriptorProtos$FileDescriptorProto$Builder;->publicDependency_:Ljava/util/List;

    invoke-static {v1}, Ljava/util/Collections;->unmodifiableList(Ljava/util/List;)Ljava/util/List;

    move-result-object v1

    iput-object v1, p0, Lcom/google/protobuf/DescriptorProtos$FileDescriptorProto$Builder;->publicDependency_:Ljava/util/List;

    .line 1281
    iget v1, p0, Lcom/google/protobuf/DescriptorProtos$FileDescriptorProto$Builder;->bitField0_:I

    and-int/lit8 v1, v1, -0x9

    iput v1, p0, Lcom/google/protobuf/DescriptorProtos$FileDescriptorProto$Builder;->bitField0_:I

    .line 1283
    :cond_2
    iget-object v1, p0, Lcom/google/protobuf/DescriptorProtos$FileDescriptorProto$Builder;->publicDependency_:Ljava/util/List;

    invoke-static {v2, v1}, Lcom/google/protobuf/DescriptorProtos$FileDescriptorProto;->access$11(Lcom/google/protobuf/DescriptorProtos$FileDescriptorProto;Ljava/util/List;)V

    .line 1284
    iget v1, p0, Lcom/google/protobuf/DescriptorProtos$FileDescriptorProto$Builder;->bitField0_:I

    and-int/lit8 v1, v1, 0x10

    const/16 v4, 0x10

    if-ne v1, v4, :cond_3

    .line 1285
    iget-object v1, p0, Lcom/google/protobuf/DescriptorProtos$FileDescriptorProto$Builder;->weakDependency_:Ljava/util/List;

    invoke-static {v1}, Ljava/util/Collections;->unmodifiableList(Ljava/util/List;)Ljava/util/List;

    move-result-object v1

    iput-object v1, p0, Lcom/google/protobuf/DescriptorProtos$FileDescriptorProto$Builder;->weakDependency_:Ljava/util/List;

    .line 1286
    iget v1, p0, Lcom/google/protobuf/DescriptorProtos$FileDescriptorProto$Builder;->bitField0_:I

    and-int/lit8 v1, v1, -0x11

    iput v1, p0, Lcom/google/protobuf/DescriptorProtos$FileDescriptorProto$Builder;->bitField0_:I

    .line 1288
    :cond_3
    iget-object v1, p0, Lcom/google/protobuf/DescriptorProtos$FileDescriptorProto$Builder;->weakDependency_:Ljava/util/List;

    invoke-static {v2, v1}, Lcom/google/protobuf/DescriptorProtos$FileDescriptorProto;->access$12(Lcom/google/protobuf/DescriptorProtos$FileDescriptorProto;Ljava/util/List;)V

    .line 1289
    iget-object v1, p0, Lcom/google/protobuf/DescriptorProtos$FileDescriptorProto$Builder;->messageTypeBuilder_:Lcom/google/protobuf/RepeatedFieldBuilder;

    if-nez v1, :cond_9

    .line 1290
    iget v1, p0, Lcom/google/protobuf/DescriptorProtos$FileDescriptorProto$Builder;->bitField0_:I

    and-int/lit8 v1, v1, 0x20

    const/16 v4, 0x20

    if-ne v1, v4, :cond_4

    .line 1291
    iget-object v1, p0, Lcom/google/protobuf/DescriptorProtos$FileDescriptorProto$Builder;->messageType_:Ljava/util/List;

    invoke-static {v1}, Ljava/util/Collections;->unmodifiableList(Ljava/util/List;)Ljava/util/List;

    move-result-object v1

    iput-object v1, p0, Lcom/google/protobuf/DescriptorProtos$FileDescriptorProto$Builder;->messageType_:Ljava/util/List;

    .line 1292
    iget v1, p0, Lcom/google/protobuf/DescriptorProtos$FileDescriptorProto$Builder;->bitField0_:I

    and-int/lit8 v1, v1, -0x21

    iput v1, p0, Lcom/google/protobuf/DescriptorProtos$FileDescriptorProto$Builder;->bitField0_:I

    .line 1294
    :cond_4
    iget-object v1, p0, Lcom/google/protobuf/DescriptorProtos$FileDescriptorProto$Builder;->messageType_:Ljava/util/List;

    invoke-static {v2, v1}, Lcom/google/protobuf/DescriptorProtos$FileDescriptorProto;->access$13(Lcom/google/protobuf/DescriptorProtos$FileDescriptorProto;Ljava/util/List;)V

    .line 1298
    :goto_1
    iget-object v1, p0, Lcom/google/protobuf/DescriptorProtos$FileDescriptorProto$Builder;->enumTypeBuilder_:Lcom/google/protobuf/RepeatedFieldBuilder;

    if-nez v1, :cond_a

    .line 1299
    iget v1, p0, Lcom/google/protobuf/DescriptorProtos$FileDescriptorProto$Builder;->bitField0_:I

    and-int/lit8 v1, v1, 0x40

    const/16 v4, 0x40

    if-ne v1, v4, :cond_5

    .line 1300
    iget-object v1, p0, Lcom/google/protobuf/DescriptorProtos$FileDescriptorProto$Builder;->enumType_:Ljava/util/List;

    invoke-static {v1}, Ljava/util/Collections;->unmodifiableList(Ljava/util/List;)Ljava/util/List;

    move-result-object v1

    iput-object v1, p0, Lcom/google/protobuf/DescriptorProtos$FileDescriptorProto$Builder;->enumType_:Ljava/util/List;

    .line 1301
    iget v1, p0, Lcom/google/protobuf/DescriptorProtos$FileDescriptorProto$Builder;->bitField0_:I

    and-int/lit8 v1, v1, -0x41

    iput v1, p0, Lcom/google/protobuf/DescriptorProtos$FileDescriptorProto$Builder;->bitField0_:I

    .line 1303
    :cond_5
    iget-object v1, p0, Lcom/google/protobuf/DescriptorProtos$FileDescriptorProto$Builder;->enumType_:Ljava/util/List;

    invoke-static {v2, v1}, Lcom/google/protobuf/DescriptorProtos$FileDescriptorProto;->access$14(Lcom/google/protobuf/DescriptorProtos$FileDescriptorProto;Ljava/util/List;)V

    .line 1307
    :goto_2
    iget-object v1, p0, Lcom/google/protobuf/DescriptorProtos$FileDescriptorProto$Builder;->serviceBuilder_:Lcom/google/protobuf/RepeatedFieldBuilder;

    if-nez v1, :cond_b

    .line 1308
    iget v1, p0, Lcom/google/protobuf/DescriptorProtos$FileDescriptorProto$Builder;->bitField0_:I

    and-int/lit16 v1, v1, 0x80

    const/16 v4, 0x80

    if-ne v1, v4, :cond_6

    .line 1309
    iget-object v1, p0, Lcom/google/protobuf/DescriptorProtos$FileDescriptorProto$Builder;->service_:Ljava/util/List;

    invoke-static {v1}, Ljava/util/Collections;->unmodifiableList(Ljava/util/List;)Ljava/util/List;

    move-result-object v1

    iput-object v1, p0, Lcom/google/protobuf/DescriptorProtos$FileDescriptorProto$Builder;->service_:Ljava/util/List;

    .line 1310
    iget v1, p0, Lcom/google/protobuf/DescriptorProtos$FileDescriptorProto$Builder;->bitField0_:I

    and-int/lit16 v1, v1, -0x81

    iput v1, p0, Lcom/google/protobuf/DescriptorProtos$FileDescriptorProto$Builder;->bitField0_:I

    .line 1312
    :cond_6
    iget-object v1, p0, Lcom/google/protobuf/DescriptorProtos$FileDescriptorProto$Builder;->service_:Ljava/util/List;

    invoke-static {v2, v1}, Lcom/google/protobuf/DescriptorProtos$FileDescriptorProto;->access$15(Lcom/google/protobuf/DescriptorProtos$FileDescriptorProto;Ljava/util/List;)V

    .line 1316
    :goto_3
    iget-object v1, p0, Lcom/google/protobuf/DescriptorProtos$FileDescriptorProto$Builder;->extensionBuilder_:Lcom/google/protobuf/RepeatedFieldBuilder;

    if-nez v1, :cond_c

    .line 1317
    iget v1, p0, Lcom/google/protobuf/DescriptorProtos$FileDescriptorProto$Builder;->bitField0_:I

    and-int/lit16 v1, v1, 0x100

    const/16 v4, 0x100

    if-ne v1, v4, :cond_7

    .line 1318
    iget-object v1, p0, Lcom/google/protobuf/DescriptorProtos$FileDescriptorProto$Builder;->extension_:Ljava/util/List;

    invoke-static {v1}, Ljava/util/Collections;->unmodifiableList(Ljava/util/List;)Ljava/util/List;

    move-result-object v1

    iput-object v1, p0, Lcom/google/protobuf/DescriptorProtos$FileDescriptorProto$Builder;->extension_:Ljava/util/List;

    .line 1319
    iget v1, p0, Lcom/google/protobuf/DescriptorProtos$FileDescriptorProto$Builder;->bitField0_:I

    and-int/lit16 v1, v1, -0x101

    iput v1, p0, Lcom/google/protobuf/DescriptorProtos$FileDescriptorProto$Builder;->bitField0_:I

    .line 1321
    :cond_7
    iget-object v1, p0, Lcom/google/protobuf/DescriptorProtos$FileDescriptorProto$Builder;->extension_:Ljava/util/List;

    invoke-static {v2, v1}, Lcom/google/protobuf/DescriptorProtos$FileDescriptorProto;->access$16(Lcom/google/protobuf/DescriptorProtos$FileDescriptorProto;Ljava/util/List;)V

    .line 1325
    :goto_4
    and-int/lit16 v1, v3, 0x200

    const/16 v4, 0x200

    if-ne v1, v4, :cond_f

    .line 1326
    or-int/lit8 v0, v0, 0x4

    move v1, v0

    .line 1328
    :goto_5
    iget-object v0, p0, Lcom/google/protobuf/DescriptorProtos$FileDescriptorProto$Builder;->optionsBuilder_:Lcom/google/protobuf/SingleFieldBuilder;

    if-nez v0, :cond_d

    .line 1329
    iget-object v0, p0, Lcom/google/protobuf/DescriptorProtos$FileDescriptorProto$Builder;->options_:Lcom/google/protobuf/DescriptorProtos$FileOptions;

    invoke-static {v2, v0}, Lcom/google/protobuf/DescriptorProtos$FileDescriptorProto;->access$17(Lcom/google/protobuf/DescriptorProtos$FileDescriptorProto;Lcom/google/protobuf/DescriptorProtos$FileOptions;)V

    .line 1333
    :goto_6
    and-int/lit16 v0, v3, 0x400

    const/16 v3, 0x400

    if-ne v0, v3, :cond_8

    .line 1334
    or-int/lit8 v1, v1, 0x8

    .line 1336
    :cond_8
    iget-object v0, p0, Lcom/google/protobuf/DescriptorProtos$FileDescriptorProto$Builder;->sourceCodeInfoBuilder_:Lcom/google/protobuf/SingleFieldBuilder;

    if-nez v0, :cond_e

    .line 1337
    iget-object v0, p0, Lcom/google/protobuf/DescriptorProtos$FileDescriptorProto$Builder;->sourceCodeInfo_:Lcom/google/protobuf/DescriptorProtos$SourceCodeInfo;

    invoke-static {v2, v0}, Lcom/google/protobuf/DescriptorProtos$FileDescriptorProto;->access$18(Lcom/google/protobuf/DescriptorProtos$FileDescriptorProto;Lcom/google/protobuf/DescriptorProtos$SourceCodeInfo;)V

    .line 1341
    :goto_7
    invoke-static {v2, v1}, Lcom/google/protobuf/DescriptorProtos$FileDescriptorProto;->access$19(Lcom/google/protobuf/DescriptorProtos$FileDescriptorProto;I)V

    .line 1342
    invoke-virtual {p0}, Lcom/google/protobuf/DescriptorProtos$FileDescriptorProto$Builder;->onBuilt()V

    .line 1343
    return-object v2

    .line 1296
    :cond_9
    iget-object v1, p0, Lcom/google/protobuf/DescriptorProtos$FileDescriptorProto$Builder;->messageTypeBuilder_:Lcom/google/protobuf/RepeatedFieldBuilder;

    invoke-virtual {v1}, Lcom/google/protobuf/RepeatedFieldBuilder;->build()Ljava/util/List;

    move-result-object v1

    invoke-static {v2, v1}, Lcom/google/protobuf/DescriptorProtos$FileDescriptorProto;->access$13(Lcom/google/protobuf/DescriptorProtos$FileDescriptorProto;Ljava/util/List;)V

    goto/16 :goto_1

    .line 1305
    :cond_a
    iget-object v1, p0, Lcom/google/protobuf/DescriptorProtos$FileDescriptorProto$Builder;->enumTypeBuilder_:Lcom/google/protobuf/RepeatedFieldBuilder;

    invoke-virtual {v1}, Lcom/google/protobuf/RepeatedFieldBuilder;->build()Ljava/util/List;

    move-result-object v1

    invoke-static {v2, v1}, Lcom/google/protobuf/DescriptorProtos$FileDescriptorProto;->access$14(Lcom/google/protobuf/DescriptorProtos$FileDescriptorProto;Ljava/util/List;)V

    goto :goto_2

    .line 1314
    :cond_b
    iget-object v1, p0, Lcom/google/protobuf/DescriptorProtos$FileDescriptorProto$Builder;->serviceBuilder_:Lcom/google/protobuf/RepeatedFieldBuilder;

    invoke-virtual {v1}, Lcom/google/protobuf/RepeatedFieldBuilder;->build()Ljava/util/List;

    move-result-object v1

    invoke-static {v2, v1}, Lcom/google/protobuf/DescriptorProtos$FileDescriptorProto;->access$15(Lcom/google/protobuf/DescriptorProtos$FileDescriptorProto;Ljava/util/List;)V

    goto :goto_3

    .line 1323
    :cond_c
    iget-object v1, p0, Lcom/google/protobuf/DescriptorProtos$FileDescriptorProto$Builder;->extensionBuilder_:Lcom/google/protobuf/RepeatedFieldBuilder;

    invoke-virtual {v1}, Lcom/google/protobuf/RepeatedFieldBuilder;->build()Ljava/util/List;

    move-result-object v1

    invoke-static {v2, v1}, Lcom/google/protobuf/DescriptorProtos$FileDescriptorProto;->access$16(Lcom/google/protobuf/DescriptorProtos$FileDescriptorProto;Ljava/util/List;)V

    goto :goto_4

    .line 1331
    :cond_d
    iget-object v0, p0, Lcom/google/protobuf/DescriptorProtos$FileDescriptorProto$Builder;->optionsBuilder_:Lcom/google/protobuf/SingleFieldBuilder;

    invoke-virtual {v0}, Lcom/google/protobuf/SingleFieldBuilder;->build()Lcom/google/protobuf/GeneratedMessage;

    move-result-object v0

    check-cast v0, Lcom/google/protobuf/DescriptorProtos$FileOptions;

    invoke-static {v2, v0}, Lcom/google/protobuf/DescriptorProtos$FileDescriptorProto;->access$17(Lcom/google/protobuf/DescriptorProtos$FileDescriptorProto;Lcom/google/protobuf/DescriptorProtos$FileOptions;)V

    goto :goto_6

    .line 1339
    :cond_e
    iget-object v0, p0, Lcom/google/protobuf/DescriptorProtos$FileDescriptorProto$Builder;->sourceCodeInfoBuilder_:Lcom/google/protobuf/SingleFieldBuilder;

    invoke-virtual {v0}, Lcom/google/protobuf/SingleFieldBuilder;->build()Lcom/google/protobuf/GeneratedMessage;

    move-result-object v0

    check-cast v0, Lcom/google/protobuf/DescriptorProtos$SourceCodeInfo;

    invoke-static {v2, v0}, Lcom/google/protobuf/DescriptorProtos$FileDescriptorProto;->access$18(Lcom/google/protobuf/DescriptorProtos$FileDescriptorProto;Lcom/google/protobuf/DescriptorProtos$SourceCodeInfo;)V

    goto :goto_7

    :cond_f
    move v1, v0

    goto :goto_5

    :cond_10
    move v0, v1

    goto/16 :goto_0
.end method

.method public bridge synthetic buildPartial()Lcom/google/protobuf/Message;
    .locals 1

    .prologue
    .line 1
    invoke-virtual {p0}, Lcom/google/protobuf/DescriptorProtos$FileDescriptorProto$Builder;->buildPartial()Lcom/google/protobuf/DescriptorProtos$FileDescriptorProto;

    move-result-object v0

    return-object v0
.end method

.method public bridge synthetic buildPartial()Lcom/google/protobuf/MessageLite;
    .locals 1

    .prologue
    .line 1
    invoke-virtual {p0}, Lcom/google/protobuf/DescriptorProtos$FileDescriptorProto$Builder;->buildPartial()Lcom/google/protobuf/DescriptorProtos$FileDescriptorProto;

    move-result-object v0

    return-object v0
.end method

.method public clear()Lcom/google/protobuf/DescriptorProtos$FileDescriptorProto$Builder;
    .locals 1

    .prologue
    .line 1180
    invoke-super {p0}, Lcom/google/protobuf/GeneratedMessage$Builder;->clear()Lcom/google/protobuf/GeneratedMessage$Builder;

    .line 1181
    const-string v0, ""

    iput-object v0, p0, Lcom/google/protobuf/DescriptorProtos$FileDescriptorProto$Builder;->name_:Ljava/lang/Object;

    .line 1182
    iget v0, p0, Lcom/google/protobuf/DescriptorProtos$FileDescriptorProto$Builder;->bitField0_:I

    and-int/lit8 v0, v0, -0x2

    iput v0, p0, Lcom/google/protobuf/DescriptorProtos$FileDescriptorProto$Builder;->bitField0_:I

    .line 1183
    const-string v0, ""

    iput-object v0, p0, Lcom/google/protobuf/DescriptorProtos$FileDescriptorProto$Builder;->package_:Ljava/lang/Object;

    .line 1184
    iget v0, p0, Lcom/google/protobuf/DescriptorProtos$FileDescriptorProto$Builder;->bitField0_:I

    and-int/lit8 v0, v0, -0x3

    iput v0, p0, Lcom/google/protobuf/DescriptorProtos$FileDescriptorProto$Builder;->bitField0_:I

    .line 1185
    sget-object v0, Lcom/google/protobuf/LazyStringArrayList;->EMPTY:Lcom/google/protobuf/LazyStringList;

    iput-object v0, p0, Lcom/google/protobuf/DescriptorProtos$FileDescriptorProto$Builder;->dependency_:Lcom/google/protobuf/LazyStringList;

    .line 1186
    iget v0, p0, Lcom/google/protobuf/DescriptorProtos$FileDescriptorProto$Builder;->bitField0_:I

    and-int/lit8 v0, v0, -0x5

    iput v0, p0, Lcom/google/protobuf/DescriptorProtos$FileDescriptorProto$Builder;->bitField0_:I

    .line 1187
    invoke-static {}, Ljava/util/Collections;->emptyList()Ljava/util/List;

    move-result-object v0

    iput-object v0, p0, Lcom/google/protobuf/DescriptorProtos$FileDescriptorProto$Builder;->publicDependency_:Ljava/util/List;

    .line 1188
    iget v0, p0, Lcom/google/protobuf/DescriptorProtos$FileDescriptorProto$Builder;->bitField0_:I

    and-int/lit8 v0, v0, -0x9

    iput v0, p0, Lcom/google/protobuf/DescriptorProtos$FileDescriptorProto$Builder;->bitField0_:I

    .line 1189
    invoke-static {}, Ljava/util/Collections;->emptyList()Ljava/util/List;

    move-result-object v0

    iput-object v0, p0, Lcom/google/protobuf/DescriptorProtos$FileDescriptorProto$Builder;->weakDependency_:Ljava/util/List;

    .line 1190
    iget v0, p0, Lcom/google/protobuf/DescriptorProtos$FileDescriptorProto$Builder;->bitField0_:I

    and-int/lit8 v0, v0, -0x11

    iput v0, p0, Lcom/google/protobuf/DescriptorProtos$FileDescriptorProto$Builder;->bitField0_:I

    .line 1191
    iget-object v0, p0, Lcom/google/protobuf/DescriptorProtos$FileDescriptorProto$Builder;->messageTypeBuilder_:Lcom/google/protobuf/RepeatedFieldBuilder;

    if-nez v0, :cond_0

    .line 1192
    invoke-static {}, Ljava/util/Collections;->emptyList()Ljava/util/List;

    move-result-object v0

    iput-object v0, p0, Lcom/google/protobuf/DescriptorProtos$FileDescriptorProto$Builder;->messageType_:Ljava/util/List;

    .line 1193
    iget v0, p0, Lcom/google/protobuf/DescriptorProtos$FileDescriptorProto$Builder;->bitField0_:I

    and-int/lit8 v0, v0, -0x21

    iput v0, p0, Lcom/google/protobuf/DescriptorProtos$FileDescriptorProto$Builder;->bitField0_:I

    .line 1197
    :goto_0
    iget-object v0, p0, Lcom/google/protobuf/DescriptorProtos$FileDescriptorProto$Builder;->enumTypeBuilder_:Lcom/google/protobuf/RepeatedFieldBuilder;

    if-nez v0, :cond_1

    .line 1198
    invoke-static {}, Ljava/util/Collections;->emptyList()Ljava/util/List;

    move-result-object v0

    iput-object v0, p0, Lcom/google/protobuf/DescriptorProtos$FileDescriptorProto$Builder;->enumType_:Ljava/util/List;

    .line 1199
    iget v0, p0, Lcom/google/protobuf/DescriptorProtos$FileDescriptorProto$Builder;->bitField0_:I

    and-int/lit8 v0, v0, -0x41

    iput v0, p0, Lcom/google/protobuf/DescriptorProtos$FileDescriptorProto$Builder;->bitField0_:I

    .line 1203
    :goto_1
    iget-object v0, p0, Lcom/google/protobuf/DescriptorProtos$FileDescriptorProto$Builder;->serviceBuilder_:Lcom/google/protobuf/RepeatedFieldBuilder;

    if-nez v0, :cond_2

    .line 1204
    invoke-static {}, Ljava/util/Collections;->emptyList()Ljava/util/List;

    move-result-object v0

    iput-object v0, p0, Lcom/google/protobuf/DescriptorProtos$FileDescriptorProto$Builder;->service_:Ljava/util/List;

    .line 1205
    iget v0, p0, Lcom/google/protobuf/DescriptorProtos$FileDescriptorProto$Builder;->bitField0_:I

    and-int/lit16 v0, v0, -0x81

    iput v0, p0, Lcom/google/protobuf/DescriptorProtos$FileDescriptorProto$Builder;->bitField0_:I

    .line 1209
    :goto_2
    iget-object v0, p0, Lcom/google/protobuf/DescriptorProtos$FileDescriptorProto$Builder;->extensionBuilder_:Lcom/google/protobuf/RepeatedFieldBuilder;

    if-nez v0, :cond_3

    .line 1210
    invoke-static {}, Ljava/util/Collections;->emptyList()Ljava/util/List;

    move-result-object v0

    iput-object v0, p0, Lcom/google/protobuf/DescriptorProtos$FileDescriptorProto$Builder;->extension_:Ljava/util/List;

    .line 1211
    iget v0, p0, Lcom/google/protobuf/DescriptorProtos$FileDescriptorProto$Builder;->bitField0_:I

    and-int/lit16 v0, v0, -0x101

    iput v0, p0, Lcom/google/protobuf/DescriptorProtos$FileDescriptorProto$Builder;->bitField0_:I

    .line 1215
    :goto_3
    iget-object v0, p0, Lcom/google/protobuf/DescriptorProtos$FileDescriptorProto$Builder;->optionsBuilder_:Lcom/google/protobuf/SingleFieldBuilder;

    if-nez v0, :cond_4

    .line 1216
    invoke-static {}, Lcom/google/protobuf/DescriptorProtos$FileOptions;->getDefaultInstance()Lcom/google/protobuf/DescriptorProtos$FileOptions;

    move-result-object v0

    iput-object v0, p0, Lcom/google/protobuf/DescriptorProtos$FileDescriptorProto$Builder;->options_:Lcom/google/protobuf/DescriptorProtos$FileOptions;

    .line 1220
    :goto_4
    iget v0, p0, Lcom/google/protobuf/DescriptorProtos$FileDescriptorProto$Builder;->bitField0_:I

    and-int/lit16 v0, v0, -0x201

    iput v0, p0, Lcom/google/protobuf/DescriptorProtos$FileDescriptorProto$Builder;->bitField0_:I

    .line 1221
    iget-object v0, p0, Lcom/google/protobuf/DescriptorProtos$FileDescriptorProto$Builder;->sourceCodeInfoBuilder_:Lcom/google/protobuf/SingleFieldBuilder;

    if-nez v0, :cond_5

    .line 1222
    invoke-static {}, Lcom/google/protobuf/DescriptorProtos$SourceCodeInfo;->getDefaultInstance()Lcom/google/protobuf/DescriptorProtos$SourceCodeInfo;

    move-result-object v0

    iput-object v0, p0, Lcom/google/protobuf/DescriptorProtos$FileDescriptorProto$Builder;->sourceCodeInfo_:Lcom/google/protobuf/DescriptorProtos$SourceCodeInfo;

    .line 1226
    :goto_5
    iget v0, p0, Lcom/google/protobuf/DescriptorProtos$FileDescriptorProto$Builder;->bitField0_:I

    and-int/lit16 v0, v0, -0x401

    iput v0, p0, Lcom/google/protobuf/DescriptorProtos$FileDescriptorProto$Builder;->bitField0_:I

    .line 1227
    return-object p0

    .line 1195
    :cond_0
    iget-object v0, p0, Lcom/google/protobuf/DescriptorProtos$FileDescriptorProto$Builder;->messageTypeBuilder_:Lcom/google/protobuf/RepeatedFieldBuilder;

    invoke-virtual {v0}, Lcom/google/protobuf/RepeatedFieldBuilder;->clear()V

    goto :goto_0

    .line 1201
    :cond_1
    iget-object v0, p0, Lcom/google/protobuf/DescriptorProtos$FileDescriptorProto$Builder;->enumTypeBuilder_:Lcom/google/protobuf/RepeatedFieldBuilder;

    invoke-virtual {v0}, Lcom/google/protobuf/RepeatedFieldBuilder;->clear()V

    goto :goto_1

    .line 1207
    :cond_2
    iget-object v0, p0, Lcom/google/protobuf/DescriptorProtos$FileDescriptorProto$Builder;->serviceBuilder_:Lcom/google/protobuf/RepeatedFieldBuilder;

    invoke-virtual {v0}, Lcom/google/protobuf/RepeatedFieldBuilder;->clear()V

    goto :goto_2

    .line 1213
    :cond_3
    iget-object v0, p0, Lcom/google/protobuf/DescriptorProtos$FileDescriptorProto$Builder;->extensionBuilder_:Lcom/google/protobuf/RepeatedFieldBuilder;

    invoke-virtual {v0}, Lcom/google/protobuf/RepeatedFieldBuilder;->clear()V

    goto :goto_3

    .line 1218
    :cond_4
    iget-object v0, p0, Lcom/google/protobuf/DescriptorProtos$FileDescriptorProto$Builder;->optionsBuilder_:Lcom/google/protobuf/SingleFieldBuilder;

    invoke-virtual {v0}, Lcom/google/protobuf/SingleFieldBuilder;->clear()Lcom/google/protobuf/SingleFieldBuilder;

    goto :goto_4

    .line 1224
    :cond_5
    iget-object v0, p0, Lcom/google/protobuf/DescriptorProtos$FileDescriptorProto$Builder;->sourceCodeInfoBuilder_:Lcom/google/protobuf/SingleFieldBuilder;

    invoke-virtual {v0}, Lcom/google/protobuf/SingleFieldBuilder;->clear()Lcom/google/protobuf/SingleFieldBuilder;

    goto :goto_5
.end method

.method public bridge synthetic clear()Lcom/google/protobuf/GeneratedMessage$Builder;
    .locals 1

    .prologue
    .line 1
    invoke-virtual {p0}, Lcom/google/protobuf/DescriptorProtos$FileDescriptorProto$Builder;->clear()Lcom/google/protobuf/DescriptorProtos$FileDescriptorProto$Builder;

    move-result-object v0

    return-object v0
.end method

.method public bridge synthetic clear()Lcom/google/protobuf/Message$Builder;
    .locals 1

    .prologue
    .line 1
    invoke-virtual {p0}, Lcom/google/protobuf/DescriptorProtos$FileDescriptorProto$Builder;->clear()Lcom/google/protobuf/DescriptorProtos$FileDescriptorProto$Builder;

    move-result-object v0

    return-object v0
.end method

.method public bridge synthetic clear()Lcom/google/protobuf/MessageLite$Builder;
    .locals 1

    .prologue
    .line 1
    invoke-virtual {p0}, Lcom/google/protobuf/DescriptorProtos$FileDescriptorProto$Builder;->clear()Lcom/google/protobuf/DescriptorProtos$FileDescriptorProto$Builder;

    move-result-object v0

    return-object v0
.end method

.method public clearDependency()Lcom/google/protobuf/DescriptorProtos$FileDescriptorProto$Builder;
    .locals 1

    .prologue
    .line 1772
    sget-object v0, Lcom/google/protobuf/LazyStringArrayList;->EMPTY:Lcom/google/protobuf/LazyStringList;

    iput-object v0, p0, Lcom/google/protobuf/DescriptorProtos$FileDescriptorProto$Builder;->dependency_:Lcom/google/protobuf/LazyStringList;

    .line 1773
    iget v0, p0, Lcom/google/protobuf/DescriptorProtos$FileDescriptorProto$Builder;->bitField0_:I

    and-int/lit8 v0, v0, -0x5

    iput v0, p0, Lcom/google/protobuf/DescriptorProtos$FileDescriptorProto$Builder;->bitField0_:I

    .line 1774
    invoke-virtual {p0}, Lcom/google/protobuf/DescriptorProtos$FileDescriptorProto$Builder;->onChanged()V

    .line 1775
    return-object p0
.end method

.method public clearEnumType()Lcom/google/protobuf/DescriptorProtos$FileDescriptorProto$Builder;
    .locals 1

    .prologue
    .line 2179
    iget-object v0, p0, Lcom/google/protobuf/DescriptorProtos$FileDescriptorProto$Builder;->enumTypeBuilder_:Lcom/google/protobuf/RepeatedFieldBuilder;

    if-nez v0, :cond_0

    .line 2180
    invoke-static {}, Ljava/util/Collections;->emptyList()Ljava/util/List;

    move-result-object v0

    iput-object v0, p0, Lcom/google/protobuf/DescriptorProtos$FileDescriptorProto$Builder;->enumType_:Ljava/util/List;

    .line 2181
    iget v0, p0, Lcom/google/protobuf/DescriptorProtos$FileDescriptorProto$Builder;->bitField0_:I

    and-int/lit8 v0, v0, -0x41

    iput v0, p0, Lcom/google/protobuf/DescriptorProtos$FileDescriptorProto$Builder;->bitField0_:I

    .line 2182
    invoke-virtual {p0}, Lcom/google/protobuf/DescriptorProtos$FileDescriptorProto$Builder;->onChanged()V

    .line 2186
    :goto_0
    return-object p0

    .line 2184
    :cond_0
    iget-object v0, p0, Lcom/google/protobuf/DescriptorProtos$FileDescriptorProto$Builder;->enumTypeBuilder_:Lcom/google/protobuf/RepeatedFieldBuilder;

    invoke-virtual {v0}, Lcom/google/protobuf/RepeatedFieldBuilder;->clear()V

    goto :goto_0
.end method

.method public clearExtension()Lcom/google/protobuf/DescriptorProtos$FileDescriptorProto$Builder;
    .locals 1

    .prologue
    .line 2551
    iget-object v0, p0, Lcom/google/protobuf/DescriptorProtos$FileDescriptorProto$Builder;->extensionBuilder_:Lcom/google/protobuf/RepeatedFieldBuilder;

    if-nez v0, :cond_0

    .line 2552
    invoke-static {}, Ljava/util/Collections;->emptyList()Ljava/util/List;

    move-result-object v0

    iput-object v0, p0, Lcom/google/protobuf/DescriptorProtos$FileDescriptorProto$Builder;->extension_:Ljava/util/List;

    .line 2553
    iget v0, p0, Lcom/google/protobuf/DescriptorProtos$FileDescriptorProto$Builder;->bitField0_:I

    and-int/lit16 v0, v0, -0x101

    iput v0, p0, Lcom/google/protobuf/DescriptorProtos$FileDescriptorProto$Builder;->bitField0_:I

    .line 2554
    invoke-virtual {p0}, Lcom/google/protobuf/DescriptorProtos$FileDescriptorProto$Builder;->onChanged()V

    .line 2558
    :goto_0
    return-object p0

    .line 2556
    :cond_0
    iget-object v0, p0, Lcom/google/protobuf/DescriptorProtos$FileDescriptorProto$Builder;->extensionBuilder_:Lcom/google/protobuf/RepeatedFieldBuilder;

    invoke-virtual {v0}, Lcom/google/protobuf/RepeatedFieldBuilder;->clear()V

    goto :goto_0
.end method

.method public clearMessageType()Lcom/google/protobuf/DescriptorProtos$FileDescriptorProto$Builder;
    .locals 1

    .prologue
    .line 1993
    iget-object v0, p0, Lcom/google/protobuf/DescriptorProtos$FileDescriptorProto$Builder;->messageTypeBuilder_:Lcom/google/protobuf/RepeatedFieldBuilder;

    if-nez v0, :cond_0

    .line 1994
    invoke-static {}, Ljava/util/Collections;->emptyList()Ljava/util/List;

    move-result-object v0

    iput-object v0, p0, Lcom/google/protobuf/DescriptorProtos$FileDescriptorProto$Builder;->messageType_:Ljava/util/List;

    .line 1995
    iget v0, p0, Lcom/google/protobuf/DescriptorProtos$FileDescriptorProto$Builder;->bitField0_:I

    and-int/lit8 v0, v0, -0x21

    iput v0, p0, Lcom/google/protobuf/DescriptorProtos$FileDescriptorProto$Builder;->bitField0_:I

    .line 1996
    invoke-virtual {p0}, Lcom/google/protobuf/DescriptorProtos$FileDescriptorProto$Builder;->onChanged()V

    .line 2000
    :goto_0
    return-object p0

    .line 1998
    :cond_0
    iget-object v0, p0, Lcom/google/protobuf/DescriptorProtos$FileDescriptorProto$Builder;->messageTypeBuilder_:Lcom/google/protobuf/RepeatedFieldBuilder;

    invoke-virtual {v0}, Lcom/google/protobuf/RepeatedFieldBuilder;->clear()V

    goto :goto_0
.end method

.method public clearName()Lcom/google/protobuf/DescriptorProtos$FileDescriptorProto$Builder;
    .locals 1

    .prologue
    .line 1680
    iget v0, p0, Lcom/google/protobuf/DescriptorProtos$FileDescriptorProto$Builder;->bitField0_:I

    and-int/lit8 v0, v0, -0x2

    iput v0, p0, Lcom/google/protobuf/DescriptorProtos$FileDescriptorProto$Builder;->bitField0_:I

    .line 1681
    invoke-static {}, Lcom/google/protobuf/DescriptorProtos$FileDescriptorProto;->getDefaultInstance()Lcom/google/protobuf/DescriptorProtos$FileDescriptorProto;

    move-result-object v0

    invoke-virtual {v0}, Lcom/google/protobuf/DescriptorProtos$FileDescriptorProto;->getName()Ljava/lang/String;

    move-result-object v0

    iput-object v0, p0, Lcom/google/protobuf/DescriptorProtos$FileDescriptorProto$Builder;->name_:Ljava/lang/Object;

    .line 1682
    invoke-virtual {p0}, Lcom/google/protobuf/DescriptorProtos$FileDescriptorProto$Builder;->onChanged()V

    .line 1683
    return-object p0
.end method

.method public clearOptions()Lcom/google/protobuf/DescriptorProtos$FileDescriptorProto$Builder;
    .locals 1

    .prologue
    .line 2672
    iget-object v0, p0, Lcom/google/protobuf/DescriptorProtos$FileDescriptorProto$Builder;->optionsBuilder_:Lcom/google/protobuf/SingleFieldBuilder;

    if-nez v0, :cond_0

    .line 2673
    invoke-static {}, Lcom/google/protobuf/DescriptorProtos$FileOptions;->getDefaultInstance()Lcom/google/protobuf/DescriptorProtos$FileOptions;

    move-result-object v0

    iput-object v0, p0, Lcom/google/protobuf/DescriptorProtos$FileDescriptorProto$Builder;->options_:Lcom/google/protobuf/DescriptorProtos$FileOptions;

    .line 2674
    invoke-virtual {p0}, Lcom/google/protobuf/DescriptorProtos$FileDescriptorProto$Builder;->onChanged()V

    .line 2678
    :goto_0
    iget v0, p0, Lcom/google/protobuf/DescriptorProtos$FileDescriptorProto$Builder;->bitField0_:I

    and-int/lit16 v0, v0, -0x201

    iput v0, p0, Lcom/google/protobuf/DescriptorProtos$FileDescriptorProto$Builder;->bitField0_:I

    .line 2679
    return-object p0

    .line 2676
    :cond_0
    iget-object v0, p0, Lcom/google/protobuf/DescriptorProtos$FileDescriptorProto$Builder;->optionsBuilder_:Lcom/google/protobuf/SingleFieldBuilder;

    invoke-virtual {v0}, Lcom/google/protobuf/SingleFieldBuilder;->clear()Lcom/google/protobuf/SingleFieldBuilder;

    goto :goto_0
.end method

.method public clearPackage()Lcom/google/protobuf/DescriptorProtos$FileDescriptorProto$Builder;
    .locals 1

    .prologue
    .line 1716
    iget v0, p0, Lcom/google/protobuf/DescriptorProtos$FileDescriptorProto$Builder;->bitField0_:I

    and-int/lit8 v0, v0, -0x3

    iput v0, p0, Lcom/google/protobuf/DescriptorProtos$FileDescriptorProto$Builder;->bitField0_:I

    .line 1717
    invoke-static {}, Lcom/google/protobuf/DescriptorProtos$FileDescriptorProto;->getDefaultInstance()Lcom/google/protobuf/DescriptorProtos$FileDescriptorProto;

    move-result-object v0

    invoke-virtual {v0}, Lcom/google/protobuf/DescriptorProtos$FileDescriptorProto;->getPackage()Ljava/lang/String;

    move-result-object v0

    iput-object v0, p0, Lcom/google/protobuf/DescriptorProtos$FileDescriptorProto$Builder;->package_:Ljava/lang/Object;

    .line 1718
    invoke-virtual {p0}, Lcom/google/protobuf/DescriptorProtos$FileDescriptorProto$Builder;->onChanged()V

    .line 1719
    return-object p0
.end method

.method public clearPublicDependency()Lcom/google/protobuf/DescriptorProtos$FileDescriptorProto$Builder;
    .locals 1

    .prologue
    .line 1822
    invoke-static {}, Ljava/util/Collections;->emptyList()Ljava/util/List;

    move-result-object v0

    iput-object v0, p0, Lcom/google/protobuf/DescriptorProtos$FileDescriptorProto$Builder;->publicDependency_:Ljava/util/List;

    .line 1823
    iget v0, p0, Lcom/google/protobuf/DescriptorProtos$FileDescriptorProto$Builder;->bitField0_:I

    and-int/lit8 v0, v0, -0x9

    iput v0, p0, Lcom/google/protobuf/DescriptorProtos$FileDescriptorProto$Builder;->bitField0_:I

    .line 1824
    invoke-virtual {p0}, Lcom/google/protobuf/DescriptorProtos$FileDescriptorProto$Builder;->onChanged()V

    .line 1825
    return-object p0
.end method

.method public clearService()Lcom/google/protobuf/DescriptorProtos$FileDescriptorProto$Builder;
    .locals 1

    .prologue
    .line 2365
    iget-object v0, p0, Lcom/google/protobuf/DescriptorProtos$FileDescriptorProto$Builder;->serviceBuilder_:Lcom/google/protobuf/RepeatedFieldBuilder;

    if-nez v0, :cond_0

    .line 2366
    invoke-static {}, Ljava/util/Collections;->emptyList()Ljava/util/List;

    move-result-object v0

    iput-object v0, p0, Lcom/google/protobuf/DescriptorProtos$FileDescriptorProto$Builder;->service_:Ljava/util/List;

    .line 2367
    iget v0, p0, Lcom/google/protobuf/DescriptorProtos$FileDescriptorProto$Builder;->bitField0_:I

    and-int/lit16 v0, v0, -0x81

    iput v0, p0, Lcom/google/protobuf/DescriptorProtos$FileDescriptorProto$Builder;->bitField0_:I

    .line 2368
    invoke-virtual {p0}, Lcom/google/protobuf/DescriptorProtos$FileDescriptorProto$Builder;->onChanged()V

    .line 2372
    :goto_0
    return-object p0

    .line 2370
    :cond_0
    iget-object v0, p0, Lcom/google/protobuf/DescriptorProtos$FileDescriptorProto$Builder;->serviceBuilder_:Lcom/google/protobuf/RepeatedFieldBuilder;

    invoke-virtual {v0}, Lcom/google/protobuf/RepeatedFieldBuilder;->clear()V

    goto :goto_0
.end method

.method public clearSourceCodeInfo()Lcom/google/protobuf/DescriptorProtos$FileDescriptorProto$Builder;
    .locals 1

    .prologue
    .line 2762
    iget-object v0, p0, Lcom/google/protobuf/DescriptorProtos$FileDescriptorProto$Builder;->sourceCodeInfoBuilder_:Lcom/google/protobuf/SingleFieldBuilder;

    if-nez v0, :cond_0

    .line 2763
    invoke-static {}, Lcom/google/protobuf/DescriptorProtos$SourceCodeInfo;->getDefaultInstance()Lcom/google/protobuf/DescriptorProtos$SourceCodeInfo;

    move-result-object v0

    iput-object v0, p0, Lcom/google/protobuf/DescriptorProtos$FileDescriptorProto$Builder;->sourceCodeInfo_:Lcom/google/protobuf/DescriptorProtos$SourceCodeInfo;

    .line 2764
    invoke-virtual {p0}, Lcom/google/protobuf/DescriptorProtos$FileDescriptorProto$Builder;->onChanged()V

    .line 2768
    :goto_0
    iget v0, p0, Lcom/google/protobuf/DescriptorProtos$FileDescriptorProto$Builder;->bitField0_:I

    and-int/lit16 v0, v0, -0x401

    iput v0, p0, Lcom/google/protobuf/DescriptorProtos$FileDescriptorProto$Builder;->bitField0_:I

    .line 2769
    return-object p0

    .line 2766
    :cond_0
    iget-object v0, p0, Lcom/google/protobuf/DescriptorProtos$FileDescriptorProto$Builder;->sourceCodeInfoBuilder_:Lcom/google/protobuf/SingleFieldBuilder;

    invoke-virtual {v0}, Lcom/google/protobuf/SingleFieldBuilder;->clear()Lcom/google/protobuf/SingleFieldBuilder;

    goto :goto_0
.end method

.method public clearWeakDependency()Lcom/google/protobuf/DescriptorProtos$FileDescriptorProto$Builder;
    .locals 1

    .prologue
    .line 1867
    invoke-static {}, Ljava/util/Collections;->emptyList()Ljava/util/List;

    move-result-object v0

    iput-object v0, p0, Lcom/google/protobuf/DescriptorProtos$FileDescriptorProto$Builder;->weakDependency_:Ljava/util/List;

    .line 1868
    iget v0, p0, Lcom/google/protobuf/DescriptorProtos$FileDescriptorProto$Builder;->bitField0_:I

    and-int/lit8 v0, v0, -0x11

    iput v0, p0, Lcom/google/protobuf/DescriptorProtos$FileDescriptorProto$Builder;->bitField0_:I

    .line 1869
    invoke-virtual {p0}, Lcom/google/protobuf/DescriptorProtos$FileDescriptorProto$Builder;->onChanged()V

    .line 1870
    return-object p0
.end method

.method public clone()Lcom/google/protobuf/DescriptorProtos$FileDescriptorProto$Builder;
    .locals 2

    .prologue
    .line 1231
    invoke-static {}, Lcom/google/protobuf/DescriptorProtos$FileDescriptorProto$Builder;->create()Lcom/google/protobuf/DescriptorProtos$FileDescriptorProto$Builder;

    move-result-object v0

    invoke-virtual {p0}, Lcom/google/protobuf/DescriptorProtos$FileDescriptorProto$Builder;->buildPartial()Lcom/google/protobuf/DescriptorProtos$FileDescriptorProto;

    move-result-object v1

    invoke-virtual {v0, v1}, Lcom/google/protobuf/DescriptorProtos$FileDescriptorProto$Builder;->mergeFrom(Lcom/google/protobuf/DescriptorProtos$FileDescriptorProto;)Lcom/google/protobuf/DescriptorProtos$FileDescriptorProto$Builder;

    move-result-object v0

    return-object v0
.end method

.method public bridge synthetic clone()Lcom/google/protobuf/GeneratedMessage$Builder;
    .locals 1

    .prologue
    .line 1
    invoke-virtual {p0}, Lcom/google/protobuf/DescriptorProtos$FileDescriptorProto$Builder;->clone()Lcom/google/protobuf/DescriptorProtos$FileDescriptorProto$Builder;

    move-result-object v0

    return-object v0
.end method

.method public bridge synthetic clone()Lcom/google/protobuf/Message$Builder;
    .locals 1

    .prologue
    .line 1
    invoke-virtual {p0}, Lcom/google/protobuf/DescriptorProtos$FileDescriptorProto$Builder;->clone()Lcom/google/protobuf/DescriptorProtos$FileDescriptorProto$Builder;

    move-result-object v0

    return-object v0
.end method

.method public bridge synthetic clone()Lcom/google/protobuf/MessageLite$Builder;
    .locals 1

    .prologue
    .line 1
    invoke-virtual {p0}, Lcom/google/protobuf/DescriptorProtos$FileDescriptorProto$Builder;->clone()Lcom/google/protobuf/DescriptorProtos$FileDescriptorProto$Builder;

    move-result-object v0

    return-object v0
.end method

.method public getDefaultInstanceForType()Lcom/google/protobuf/DescriptorProtos$FileDescriptorProto;
    .locals 1

    .prologue
    .line 1240
    invoke-static {}, Lcom/google/protobuf/DescriptorProtos$FileDescriptorProto;->getDefaultInstance()Lcom/google/protobuf/DescriptorProtos$FileDescriptorProto;

    move-result-object v0

    return-object v0
.end method

.method public bridge synthetic getDefaultInstanceForType()Lcom/google/protobuf/Message;
    .locals 1

    .prologue
    .line 1
    invoke-virtual {p0}, Lcom/google/protobuf/DescriptorProtos$FileDescriptorProto$Builder;->getDefaultInstanceForType()Lcom/google/protobuf/DescriptorProtos$FileDescriptorProto;

    move-result-object v0

    return-object v0
.end method

.method public bridge synthetic getDefaultInstanceForType()Lcom/google/protobuf/MessageLite;
    .locals 1

    .prologue
    .line 1
    invoke-virtual {p0}, Lcom/google/protobuf/DescriptorProtos$FileDescriptorProto$Builder;->getDefaultInstanceForType()Lcom/google/protobuf/DescriptorProtos$FileDescriptorProto;

    move-result-object v0

    return-object v0
.end method

.method public getDependency(I)Ljava/lang/String;
    .locals 1

    .prologue
    .line 1743
    iget-object v0, p0, Lcom/google/protobuf/DescriptorProtos$FileDescriptorProto$Builder;->dependency_:Lcom/google/protobuf/LazyStringList;

    invoke-interface {v0, p1}, Lcom/google/protobuf/LazyStringList;->get(I)Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Ljava/lang/String;

    return-object v0
.end method

.method public getDependencyCount()I
    .locals 1

    .prologue
    .line 1740
    iget-object v0, p0, Lcom/google/protobuf/DescriptorProtos$FileDescriptorProto$Builder;->dependency_:Lcom/google/protobuf/LazyStringList;

    invoke-interface {v0}, Lcom/google/protobuf/LazyStringList;->size()I

    move-result v0

    return v0
.end method

.method public getDependencyList()Ljava/util/List;
    .locals 1
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "()",
            "Ljava/util/List",
            "<",
            "Ljava/lang/String;",
            ">;"
        }
    .end annotation

    .prologue
    .line 1737
    iget-object v0, p0, Lcom/google/protobuf/DescriptorProtos$FileDescriptorProto$Builder;->dependency_:Lcom/google/protobuf/LazyStringList;

    invoke-static {v0}, Ljava/util/Collections;->unmodifiableList(Ljava/util/List;)Ljava/util/List;

    move-result-object v0

    return-object v0
.end method

.method public getDescriptorForType()Lcom/google/protobuf/Descriptors$Descriptor;
    .locals 1

    .prologue
    .line 1236
    invoke-static {}, Lcom/google/protobuf/DescriptorProtos$FileDescriptorProto;->getDescriptor()Lcom/google/protobuf/Descriptors$Descriptor;

    move-result-object v0

    return-object v0
.end method

.method public getEnumType(I)Lcom/google/protobuf/DescriptorProtos$EnumDescriptorProto;
    .locals 1

    .prologue
    .line 2087
    iget-object v0, p0, Lcom/google/protobuf/DescriptorProtos$FileDescriptorProto$Builder;->enumTypeBuilder_:Lcom/google/protobuf/RepeatedFieldBuilder;

    if-nez v0, :cond_0

    .line 2088
    iget-object v0, p0, Lcom/google/protobuf/DescriptorProtos$FileDescriptorProto$Builder;->enumType_:Ljava/util/List;

    invoke-interface {v0, p1}, Ljava/util/List;->get(I)Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Lcom/google/protobuf/DescriptorProtos$EnumDescriptorProto;

    .line 2090
    :goto_0
    return-object v0

    :cond_0
    iget-object v0, p0, Lcom/google/protobuf/DescriptorProtos$FileDescriptorProto$Builder;->enumTypeBuilder_:Lcom/google/protobuf/RepeatedFieldBuilder;

    invoke-virtual {v0, p1}, Lcom/google/protobuf/RepeatedFieldBuilder;->getMessage(I)Lcom/google/protobuf/GeneratedMessage;

    move-result-object v0

    check-cast v0, Lcom/google/protobuf/DescriptorProtos$EnumDescriptorProto;

    goto :goto_0
.end method

.method public getEnumTypeBuilder(I)Lcom/google/protobuf/DescriptorProtos$EnumDescriptorProto$Builder;
    .locals 1

    .prologue
    .line 2200
    invoke-direct {p0}, Lcom/google/protobuf/DescriptorProtos$FileDescriptorProto$Builder;->getEnumTypeFieldBuilder()Lcom/google/protobuf/RepeatedFieldBuilder;

    move-result-object v0

    invoke-virtual {v0, p1}, Lcom/google/protobuf/RepeatedFieldBuilder;->getBuilder(I)Lcom/google/protobuf/GeneratedMessage$Builder;

    move-result-object v0

    check-cast v0, Lcom/google/protobuf/DescriptorProtos$EnumDescriptorProto$Builder;

    return-object v0
.end method

.method public getEnumTypeBuilderList()Ljava/util/List;
    .locals 1
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "()",
            "Ljava/util/List",
            "<",
            "Lcom/google/protobuf/DescriptorProtos$EnumDescriptorProto$Builder;",
            ">;"
        }
    .end annotation

    .prologue
    .line 2228
    invoke-direct {p0}, Lcom/google/protobuf/DescriptorProtos$FileDescriptorProto$Builder;->getEnumTypeFieldBuilder()Lcom/google/protobuf/RepeatedFieldBuilder;

    move-result-object v0

    invoke-virtual {v0}, Lcom/google/protobuf/RepeatedFieldBuilder;->getBuilderList()Ljava/util/List;

    move-result-object v0

    return-object v0
.end method

.method public getEnumTypeCount()I
    .locals 1

    .prologue
    .line 2080
    iget-object v0, p0, Lcom/google/protobuf/DescriptorProtos$FileDescriptorProto$Builder;->enumTypeBuilder_:Lcom/google/protobuf/RepeatedFieldBuilder;

    if-nez v0, :cond_0

    .line 2081
    iget-object v0, p0, Lcom/google/protobuf/DescriptorProtos$FileDescriptorProto$Builder;->enumType_:Ljava/util/List;

    invoke-interface {v0}, Ljava/util/List;->size()I

    move-result v0

    .line 2083
    :goto_0
    return v0

    :cond_0
    iget-object v0, p0, Lcom/google/protobuf/DescriptorProtos$FileDescriptorProto$Builder;->enumTypeBuilder_:Lcom/google/protobuf/RepeatedFieldBuilder;

    invoke-virtual {v0}, Lcom/google/protobuf/RepeatedFieldBuilder;->getCount()I

    move-result v0

    goto :goto_0
.end method

.method public getEnumTypeList()Ljava/util/List;
    .locals 1
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "()",
            "Ljava/util/List",
            "<",
            "Lcom/google/protobuf/DescriptorProtos$EnumDescriptorProto;",
            ">;"
        }
    .end annotation

    .prologue
    .line 2073
    iget-object v0, p0, Lcom/google/protobuf/DescriptorProtos$FileDescriptorProto$Builder;->enumTypeBuilder_:Lcom/google/protobuf/RepeatedFieldBuilder;

    if-nez v0, :cond_0

    .line 2074
    iget-object v0, p0, Lcom/google/protobuf/DescriptorProtos$FileDescriptorProto$Builder;->enumType_:Ljava/util/List;

    invoke-static {v0}, Ljava/util/Collections;->unmodifiableList(Ljava/util/List;)Ljava/util/List;

    move-result-object v0

    .line 2076
    :goto_0
    return-object v0

    :cond_0
    iget-object v0, p0, Lcom/google/protobuf/DescriptorProtos$FileDescriptorProto$Builder;->enumTypeBuilder_:Lcom/google/protobuf/RepeatedFieldBuilder;

    invoke-virtual {v0}, Lcom/google/protobuf/RepeatedFieldBuilder;->getMessageList()Ljava/util/List;

    move-result-object v0

    goto :goto_0
.end method

.method public getEnumTypeOrBuilder(I)Lcom/google/protobuf/DescriptorProtos$EnumDescriptorProtoOrBuilder;
    .locals 1

    .prologue
    .line 2204
    iget-object v0, p0, Lcom/google/protobuf/DescriptorProtos$FileDescriptorProto$Builder;->enumTypeBuilder_:Lcom/google/protobuf/RepeatedFieldBuilder;

    if-nez v0, :cond_0

    .line 2205
    iget-object v0, p0, Lcom/google/protobuf/DescriptorProtos$FileDescriptorProto$Builder;->enumType_:Ljava/util/List;

    invoke-interface {v0, p1}, Ljava/util/List;->get(I)Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Lcom/google/protobuf/DescriptorProtos$EnumDescriptorProtoOrBuilder;

    .line 2206
    :goto_0
    return-object v0

    :cond_0
    iget-object v0, p0, Lcom/google/protobuf/DescriptorProtos$FileDescriptorProto$Builder;->enumTypeBuilder_:Lcom/google/protobuf/RepeatedFieldBuilder;

    invoke-virtual {v0, p1}, Lcom/google/protobuf/RepeatedFieldBuilder;->getMessageOrBuilder(I)Lcom/google/protobuf/MessageOrBuilder;

    move-result-object v0

    check-cast v0, Lcom/google/protobuf/DescriptorProtos$EnumDescriptorProtoOrBuilder;

    goto :goto_0
.end method

.method public getEnumTypeOrBuilderList()Ljava/util/List;
    .locals 1
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "()",
            "Ljava/util/List",
            "<+",
            "Lcom/google/protobuf/DescriptorProtos$EnumDescriptorProtoOrBuilder;",
            ">;"
        }
    .end annotation

    .prologue
    .line 2211
    iget-object v0, p0, Lcom/google/protobuf/DescriptorProtos$FileDescriptorProto$Builder;->enumTypeBuilder_:Lcom/google/protobuf/RepeatedFieldBuilder;

    if-eqz v0, :cond_0

    .line 2212
    iget-object v0, p0, Lcom/google/protobuf/DescriptorProtos$FileDescriptorProto$Builder;->enumTypeBuilder_:Lcom/google/protobuf/RepeatedFieldBuilder;

    invoke-virtual {v0}, Lcom/google/protobuf/RepeatedFieldBuilder;->getMessageOrBuilderList()Ljava/util/List;

    move-result-object v0

    .line 2214
    :goto_0
    return-object v0

    :cond_0
    iget-object v0, p0, Lcom/google/protobuf/DescriptorProtos$FileDescriptorProto$Builder;->enumType_:Ljava/util/List;

    invoke-static {v0}, Ljava/util/Collections;->unmodifiableList(Ljava/util/List;)Ljava/util/List;

    move-result-object v0

    goto :goto_0
.end method

.method public getExtension(I)Lcom/google/protobuf/DescriptorProtos$FieldDescriptorProto;
    .locals 1

    .prologue
    .line 2459
    iget-object v0, p0, Lcom/google/protobuf/DescriptorProtos$FileDescriptorProto$Builder;->extensionBuilder_:Lcom/google/protobuf/RepeatedFieldBuilder;

    if-nez v0, :cond_0

    .line 2460
    iget-object v0, p0, Lcom/google/protobuf/DescriptorProtos$FileDescriptorProto$Builder;->extension_:Ljava/util/List;

    invoke-interface {v0, p1}, Ljava/util/List;->get(I)Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Lcom/google/protobuf/DescriptorProtos$FieldDescriptorProto;

    .line 2462
    :goto_0
    return-object v0

    :cond_0
    iget-object v0, p0, Lcom/google/protobuf/DescriptorProtos$FileDescriptorProto$Builder;->extensionBuilder_:Lcom/google/protobuf/RepeatedFieldBuilder;

    invoke-virtual {v0, p1}, Lcom/google/protobuf/RepeatedFieldBuilder;->getMessage(I)Lcom/google/protobuf/GeneratedMessage;

    move-result-object v0

    check-cast v0, Lcom/google/protobuf/DescriptorProtos$FieldDescriptorProto;

    goto :goto_0
.end method

.method public getExtensionBuilder(I)Lcom/google/protobuf/DescriptorProtos$FieldDescriptorProto$Builder;
    .locals 1

    .prologue
    .line 2572
    invoke-direct {p0}, Lcom/google/protobuf/DescriptorProtos$FileDescriptorProto$Builder;->getExtensionFieldBuilder()Lcom/google/protobuf/RepeatedFieldBuilder;

    move-result-object v0

    invoke-virtual {v0, p1}, Lcom/google/protobuf/RepeatedFieldBuilder;->getBuilder(I)Lcom/google/protobuf/GeneratedMessage$Builder;

    move-result-object v0

    check-cast v0, Lcom/google/protobuf/DescriptorProtos$FieldDescriptorProto$Builder;

    return-object v0
.end method

.method public getExtensionBuilderList()Ljava/util/List;
    .locals 1
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "()",
            "Ljava/util/List",
            "<",
            "Lcom/google/protobuf/DescriptorProtos$FieldDescriptorProto$Builder;",
            ">;"
        }
    .end annotation

    .prologue
    .line 2600
    invoke-direct {p0}, Lcom/google/protobuf/DescriptorProtos$FileDescriptorProto$Builder;->getExtensionFieldBuilder()Lcom/google/protobuf/RepeatedFieldBuilder;

    move-result-object v0

    invoke-virtual {v0}, Lcom/google/protobuf/RepeatedFieldBuilder;->getBuilderList()Ljava/util/List;

    move-result-object v0

    return-object v0
.end method

.method public getExtensionCount()I
    .locals 1

    .prologue
    .line 2452
    iget-object v0, p0, Lcom/google/protobuf/DescriptorProtos$FileDescriptorProto$Builder;->extensionBuilder_:Lcom/google/protobuf/RepeatedFieldBuilder;

    if-nez v0, :cond_0

    .line 2453
    iget-object v0, p0, Lcom/google/protobuf/DescriptorProtos$FileDescriptorProto$Builder;->extension_:Ljava/util/List;

    invoke-interface {v0}, Ljava/util/List;->size()I

    move-result v0

    .line 2455
    :goto_0
    return v0

    :cond_0
    iget-object v0, p0, Lcom/google/protobuf/DescriptorProtos$FileDescriptorProto$Builder;->extensionBuilder_:Lcom/google/protobuf/RepeatedFieldBuilder;

    invoke-virtual {v0}, Lcom/google/protobuf/RepeatedFieldBuilder;->getCount()I

    move-result v0

    goto :goto_0
.end method

.method public getExtensionList()Ljava/util/List;
    .locals 1
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "()",
            "Ljava/util/List",
            "<",
            "Lcom/google/protobuf/DescriptorProtos$FieldDescriptorProto;",
            ">;"
        }
    .end annotation

    .prologue
    .line 2445
    iget-object v0, p0, Lcom/google/protobuf/DescriptorProtos$FileDescriptorProto$Builder;->extensionBuilder_:Lcom/google/protobuf/RepeatedFieldBuilder;

    if-nez v0, :cond_0

    .line 2446
    iget-object v0, p0, Lcom/google/protobuf/DescriptorProtos$FileDescriptorProto$Builder;->extension_:Ljava/util/List;

    invoke-static {v0}, Ljava/util/Collections;->unmodifiableList(Ljava/util/List;)Ljava/util/List;

    move-result-object v0

    .line 2448
    :goto_0
    return-object v0

    :cond_0
    iget-object v0, p0, Lcom/google/protobuf/DescriptorProtos$FileDescriptorProto$Builder;->extensionBuilder_:Lcom/google/protobuf/RepeatedFieldBuilder;

    invoke-virtual {v0}, Lcom/google/protobuf/RepeatedFieldBuilder;->getMessageList()Ljava/util/List;

    move-result-object v0

    goto :goto_0
.end method

.method public getExtensionOrBuilder(I)Lcom/google/protobuf/DescriptorProtos$FieldDescriptorProtoOrBuilder;
    .locals 1

    .prologue
    .line 2576
    iget-object v0, p0, Lcom/google/protobuf/DescriptorProtos$FileDescriptorProto$Builder;->extensionBuilder_:Lcom/google/protobuf/RepeatedFieldBuilder;

    if-nez v0, :cond_0

    .line 2577
    iget-object v0, p0, Lcom/google/protobuf/DescriptorProtos$FileDescriptorProto$Builder;->extension_:Ljava/util/List;

    invoke-interface {v0, p1}, Ljava/util/List;->get(I)Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Lcom/google/protobuf/DescriptorProtos$FieldDescriptorProtoOrBuilder;

    .line 2578
    :goto_0
    return-object v0

    :cond_0
    iget-object v0, p0, Lcom/google/protobuf/DescriptorProtos$FileDescriptorProto$Builder;->extensionBuilder_:Lcom/google/protobuf/RepeatedFieldBuilder;

    invoke-virtual {v0, p1}, Lcom/google/protobuf/RepeatedFieldBuilder;->getMessageOrBuilder(I)Lcom/google/protobuf/MessageOrBuilder;

    move-result-object v0

    check-cast v0, Lcom/google/protobuf/DescriptorProtos$FieldDescriptorProtoOrBuilder;

    goto :goto_0
.end method

.method public getExtensionOrBuilderList()Ljava/util/List;
    .locals 1
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "()",
            "Ljava/util/List",
            "<+",
            "Lcom/google/protobuf/DescriptorProtos$FieldDescriptorProtoOrBuilder;",
            ">;"
        }
    .end annotation

    .prologue
    .line 2583
    iget-object v0, p0, Lcom/google/protobuf/DescriptorProtos$FileDescriptorProto$Builder;->extensionBuilder_:Lcom/google/protobuf/RepeatedFieldBuilder;

    if-eqz v0, :cond_0

    .line 2584
    iget-object v0, p0, Lcom/google/protobuf/DescriptorProtos$FileDescriptorProto$Builder;->extensionBuilder_:Lcom/google/protobuf/RepeatedFieldBuilder;

    invoke-virtual {v0}, Lcom/google/protobuf/RepeatedFieldBuilder;->getMessageOrBuilderList()Ljava/util/List;

    move-result-object v0

    .line 2586
    :goto_0
    return-object v0

    :cond_0
    iget-object v0, p0, Lcom/google/protobuf/DescriptorProtos$FileDescriptorProto$Builder;->extension_:Ljava/util/List;

    invoke-static {v0}, Ljava/util/Collections;->unmodifiableList(Ljava/util/List;)Ljava/util/List;

    move-result-object v0

    goto :goto_0
.end method

.method public getMessageType(I)Lcom/google/protobuf/DescriptorProtos$DescriptorProto;
    .locals 1

    .prologue
    .line 1901
    iget-object v0, p0, Lcom/google/protobuf/DescriptorProtos$FileDescriptorProto$Builder;->messageTypeBuilder_:Lcom/google/protobuf/RepeatedFieldBuilder;

    if-nez v0, :cond_0

    .line 1902
    iget-object v0, p0, Lcom/google/protobuf/DescriptorProtos$FileDescriptorProto$Builder;->messageType_:Ljava/util/List;

    invoke-interface {v0, p1}, Ljava/util/List;->get(I)Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Lcom/google/protobuf/DescriptorProtos$DescriptorProto;

    .line 1904
    :goto_0
    return-object v0

    :cond_0
    iget-object v0, p0, Lcom/google/protobuf/DescriptorProtos$FileDescriptorProto$Builder;->messageTypeBuilder_:Lcom/google/protobuf/RepeatedFieldBuilder;

    invoke-virtual {v0, p1}, Lcom/google/protobuf/RepeatedFieldBuilder;->getMessage(I)Lcom/google/protobuf/GeneratedMessage;

    move-result-object v0

    check-cast v0, Lcom/google/protobuf/DescriptorProtos$DescriptorProto;

    goto :goto_0
.end method

.method public getMessageTypeBuilder(I)Lcom/google/protobuf/DescriptorProtos$DescriptorProto$Builder;
    .locals 1

    .prologue
    .line 2014
    invoke-direct {p0}, Lcom/google/protobuf/DescriptorProtos$FileDescriptorProto$Builder;->getMessageTypeFieldBuilder()Lcom/google/protobuf/RepeatedFieldBuilder;

    move-result-object v0

    invoke-virtual {v0, p1}, Lcom/google/protobuf/RepeatedFieldBuilder;->getBuilder(I)Lcom/google/protobuf/GeneratedMessage$Builder;

    move-result-object v0

    check-cast v0, Lcom/google/protobuf/DescriptorProtos$DescriptorProto$Builder;

    return-object v0
.end method

.method public getMessageTypeBuilderList()Ljava/util/List;
    .locals 1
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "()",
            "Ljava/util/List",
            "<",
            "Lcom/google/protobuf/DescriptorProtos$DescriptorProto$Builder;",
            ">;"
        }
    .end annotation

    .prologue
    .line 2042
    invoke-direct {p0}, Lcom/google/protobuf/DescriptorProtos$FileDescriptorProto$Builder;->getMessageTypeFieldBuilder()Lcom/google/protobuf/RepeatedFieldBuilder;

    move-result-object v0

    invoke-virtual {v0}, Lcom/google/protobuf/RepeatedFieldBuilder;->getBuilderList()Ljava/util/List;

    move-result-object v0

    return-object v0
.end method

.method public getMessageTypeCount()I
    .locals 1

    .prologue
    .line 1894
    iget-object v0, p0, Lcom/google/protobuf/DescriptorProtos$FileDescriptorProto$Builder;->messageTypeBuilder_:Lcom/google/protobuf/RepeatedFieldBuilder;

    if-nez v0, :cond_0

    .line 1895
    iget-object v0, p0, Lcom/google/protobuf/DescriptorProtos$FileDescriptorProto$Builder;->messageType_:Ljava/util/List;

    invoke-interface {v0}, Ljava/util/List;->size()I

    move-result v0

    .line 1897
    :goto_0
    return v0

    :cond_0
    iget-object v0, p0, Lcom/google/protobuf/DescriptorProtos$FileDescriptorProto$Builder;->messageTypeBuilder_:Lcom/google/protobuf/RepeatedFieldBuilder;

    invoke-virtual {v0}, Lcom/google/protobuf/RepeatedFieldBuilder;->getCount()I

    move-result v0

    goto :goto_0
.end method

.method public getMessageTypeList()Ljava/util/List;
    .locals 1
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "()",
            "Ljava/util/List",
            "<",
            "Lcom/google/protobuf/DescriptorProtos$DescriptorProto;",
            ">;"
        }
    .end annotation

    .prologue
    .line 1887
    iget-object v0, p0, Lcom/google/protobuf/DescriptorProtos$FileDescriptorProto$Builder;->messageTypeBuilder_:Lcom/google/protobuf/RepeatedFieldBuilder;

    if-nez v0, :cond_0

    .line 1888
    iget-object v0, p0, Lcom/google/protobuf/DescriptorProtos$FileDescriptorProto$Builder;->messageType_:Ljava/util/List;

    invoke-static {v0}, Ljava/util/Collections;->unmodifiableList(Ljava/util/List;)Ljava/util/List;

    move-result-object v0

    .line 1890
    :goto_0
    return-object v0

    :cond_0
    iget-object v0, p0, Lcom/google/protobuf/DescriptorProtos$FileDescriptorProto$Builder;->messageTypeBuilder_:Lcom/google/protobuf/RepeatedFieldBuilder;

    invoke-virtual {v0}, Lcom/google/protobuf/RepeatedFieldBuilder;->getMessageList()Ljava/util/List;

    move-result-object v0

    goto :goto_0
.end method

.method public getMessageTypeOrBuilder(I)Lcom/google/protobuf/DescriptorProtos$DescriptorProtoOrBuilder;
    .locals 1

    .prologue
    .line 2018
    iget-object v0, p0, Lcom/google/protobuf/DescriptorProtos$FileDescriptorProto$Builder;->messageTypeBuilder_:Lcom/google/protobuf/RepeatedFieldBuilder;

    if-nez v0, :cond_0

    .line 2019
    iget-object v0, p0, Lcom/google/protobuf/DescriptorProtos$FileDescriptorProto$Builder;->messageType_:Ljava/util/List;

    invoke-interface {v0, p1}, Ljava/util/List;->get(I)Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Lcom/google/protobuf/DescriptorProtos$DescriptorProtoOrBuilder;

    .line 2020
    :goto_0
    return-object v0

    :cond_0
    iget-object v0, p0, Lcom/google/protobuf/DescriptorProtos$FileDescriptorProto$Builder;->messageTypeBuilder_:Lcom/google/protobuf/RepeatedFieldBuilder;

    invoke-virtual {v0, p1}, Lcom/google/protobuf/RepeatedFieldBuilder;->getMessageOrBuilder(I)Lcom/google/protobuf/MessageOrBuilder;

    move-result-object v0

    check-cast v0, Lcom/google/protobuf/DescriptorProtos$DescriptorProtoOrBuilder;

    goto :goto_0
.end method

.method public getMessageTypeOrBuilderList()Ljava/util/List;
    .locals 1
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "()",
            "Ljava/util/List",
            "<+",
            "Lcom/google/protobuf/DescriptorProtos$DescriptorProtoOrBuilder;",
            ">;"
        }
    .end annotation

    .prologue
    .line 2025
    iget-object v0, p0, Lcom/google/protobuf/DescriptorProtos$FileDescriptorProto$Builder;->messageTypeBuilder_:Lcom/google/protobuf/RepeatedFieldBuilder;

    if-eqz v0, :cond_0

    .line 2026
    iget-object v0, p0, Lcom/google/protobuf/DescriptorProtos$FileDescriptorProto$Builder;->messageTypeBuilder_:Lcom/google/protobuf/RepeatedFieldBuilder;

    invoke-virtual {v0}, Lcom/google/protobuf/RepeatedFieldBuilder;->getMessageOrBuilderList()Ljava/util/List;

    move-result-object v0

    .line 2028
    :goto_0
    return-object v0

    :cond_0
    iget-object v0, p0, Lcom/google/protobuf/DescriptorProtos$FileDescriptorProto$Builder;->messageType_:Ljava/util/List;

    invoke-static {v0}, Ljava/util/Collections;->unmodifiableList(Ljava/util/List;)Ljava/util/List;

    move-result-object v0

    goto :goto_0
.end method

.method public getName()Ljava/lang/String;
    .locals 2

    .prologue
    .line 1661
    iget-object v0, p0, Lcom/google/protobuf/DescriptorProtos$FileDescriptorProto$Builder;->name_:Ljava/lang/Object;

    .line 1662
    instance-of v1, v0, Ljava/lang/String;

    if-nez v1, :cond_0

    .line 1663
    check-cast v0, Lcom/google/protobuf/ByteString;

    invoke-virtual {v0}, Lcom/google/protobuf/ByteString;->toStringUtf8()Ljava/lang/String;

    move-result-object v0

    .line 1664
    iput-object v0, p0, Lcom/google/protobuf/DescriptorProtos$FileDescriptorProto$Builder;->name_:Ljava/lang/Object;

    .line 1667
    :goto_0
    return-object v0

    :cond_0
    check-cast v0, Ljava/lang/String;

    goto :goto_0
.end method

.method public getOptions()Lcom/google/protobuf/DescriptorProtos$FileOptions;
    .locals 1

    .prologue
    .line 2625
    iget-object v0, p0, Lcom/google/protobuf/DescriptorProtos$FileDescriptorProto$Builder;->optionsBuilder_:Lcom/google/protobuf/SingleFieldBuilder;

    if-nez v0, :cond_0

    .line 2626
    iget-object v0, p0, Lcom/google/protobuf/DescriptorProtos$FileDescriptorProto$Builder;->options_:Lcom/google/protobuf/DescriptorProtos$FileOptions;

    .line 2628
    :goto_0
    return-object v0

    :cond_0
    iget-object v0, p0, Lcom/google/protobuf/DescriptorProtos$FileDescriptorProto$Builder;->optionsBuilder_:Lcom/google/protobuf/SingleFieldBuilder;

    invoke-virtual {v0}, Lcom/google/protobuf/SingleFieldBuilder;->getMessage()Lcom/google/protobuf/GeneratedMessage;

    move-result-object v0

    check-cast v0, Lcom/google/protobuf/DescriptorProtos$FileOptions;

    goto :goto_0
.end method

.method public getOptionsBuilder()Lcom/google/protobuf/DescriptorProtos$FileOptions$Builder;
    .locals 1

    .prologue
    .line 2682
    iget v0, p0, Lcom/google/protobuf/DescriptorProtos$FileDescriptorProto$Builder;->bitField0_:I

    or-int/lit16 v0, v0, 0x200

    iput v0, p0, Lcom/google/protobuf/DescriptorProtos$FileDescriptorProto$Builder;->bitField0_:I

    .line 2683
    invoke-virtual {p0}, Lcom/google/protobuf/DescriptorProtos$FileDescriptorProto$Builder;->onChanged()V

    .line 2684
    invoke-direct {p0}, Lcom/google/protobuf/DescriptorProtos$FileDescriptorProto$Builder;->getOptionsFieldBuilder()Lcom/google/protobuf/SingleFieldBuilder;

    move-result-object v0

    invoke-virtual {v0}, Lcom/google/protobuf/SingleFieldBuilder;->getBuilder()Lcom/google/protobuf/GeneratedMessage$Builder;

    move-result-object v0

    check-cast v0, Lcom/google/protobuf/DescriptorProtos$FileOptions$Builder;

    return-object v0
.end method

.method public getOptionsOrBuilder()Lcom/google/protobuf/DescriptorProtos$FileOptionsOrBuilder;
    .locals 1

    .prologue
    .line 2687
    iget-object v0, p0, Lcom/google/protobuf/DescriptorProtos$FileDescriptorProto$Builder;->optionsBuilder_:Lcom/google/protobuf/SingleFieldBuilder;

    if-eqz v0, :cond_0

    .line 2688
    iget-object v0, p0, Lcom/google/protobuf/DescriptorProtos$FileDescriptorProto$Builder;->optionsBuilder_:Lcom/google/protobuf/SingleFieldBuilder;

    invoke-virtual {v0}, Lcom/google/protobuf/SingleFieldBuilder;->getMessageOrBuilder()Lcom/google/protobuf/MessageOrBuilder;

    move-result-object v0

    check-cast v0, Lcom/google/protobuf/DescriptorProtos$FileOptionsOrBuilder;

    .line 2690
    :goto_0
    return-object v0

    :cond_0
    iget-object v0, p0, Lcom/google/protobuf/DescriptorProtos$FileDescriptorProto$Builder;->options_:Lcom/google/protobuf/DescriptorProtos$FileOptions;

    goto :goto_0
.end method

.method public getPackage()Ljava/lang/String;
    .locals 2

    .prologue
    .line 1697
    iget-object v0, p0, Lcom/google/protobuf/DescriptorProtos$FileDescriptorProto$Builder;->package_:Ljava/lang/Object;

    .line 1698
    instance-of v1, v0, Ljava/lang/String;

    if-nez v1, :cond_0

    .line 1699
    check-cast v0, Lcom/google/protobuf/ByteString;

    invoke-virtual {v0}, Lcom/google/protobuf/ByteString;->toStringUtf8()Ljava/lang/String;

    move-result-object v0

    .line 1700
    iput-object v0, p0, Lcom/google/protobuf/DescriptorProtos$FileDescriptorProto$Builder;->package_:Ljava/lang/Object;

    .line 1703
    :goto_0
    return-object v0

    :cond_0
    check-cast v0, Ljava/lang/String;

    goto :goto_0
.end method

.method public getPublicDependency(I)I
    .locals 1

    .prologue
    .line 1799
    iget-object v0, p0, Lcom/google/protobuf/DescriptorProtos$FileDescriptorProto$Builder;->publicDependency_:Ljava/util/List;

    invoke-interface {v0, p1}, Ljava/util/List;->get(I)Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Ljava/lang/Integer;

    invoke-virtual {v0}, Ljava/lang/Integer;->intValue()I

    move-result v0

    return v0
.end method

.method public getPublicDependencyCount()I
    .locals 1

    .prologue
    .line 1796
    iget-object v0, p0, Lcom/google/protobuf/DescriptorProtos$FileDescriptorProto$Builder;->publicDependency_:Ljava/util/List;

    invoke-interface {v0}, Ljava/util/List;->size()I

    move-result v0

    return v0
.end method

.method public getPublicDependencyList()Ljava/util/List;
    .locals 1
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "()",
            "Ljava/util/List",
            "<",
            "Ljava/lang/Integer;",
            ">;"
        }
    .end annotation

    .prologue
    .line 1793
    iget-object v0, p0, Lcom/google/protobuf/DescriptorProtos$FileDescriptorProto$Builder;->publicDependency_:Ljava/util/List;

    invoke-static {v0}, Ljava/util/Collections;->unmodifiableList(Ljava/util/List;)Ljava/util/List;

    move-result-object v0

    return-object v0
.end method

.method public getService(I)Lcom/google/protobuf/DescriptorProtos$ServiceDescriptorProto;
    .locals 1

    .prologue
    .line 2273
    iget-object v0, p0, Lcom/google/protobuf/DescriptorProtos$FileDescriptorProto$Builder;->serviceBuilder_:Lcom/google/protobuf/RepeatedFieldBuilder;

    if-nez v0, :cond_0

    .line 2274
    iget-object v0, p0, Lcom/google/protobuf/DescriptorProtos$FileDescriptorProto$Builder;->service_:Ljava/util/List;

    invoke-interface {v0, p1}, Ljava/util/List;->get(I)Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Lcom/google/protobuf/DescriptorProtos$ServiceDescriptorProto;

    .line 2276
    :goto_0
    return-object v0

    :cond_0
    iget-object v0, p0, Lcom/google/protobuf/DescriptorProtos$FileDescriptorProto$Builder;->serviceBuilder_:Lcom/google/protobuf/RepeatedFieldBuilder;

    invoke-virtual {v0, p1}, Lcom/google/protobuf/RepeatedFieldBuilder;->getMessage(I)Lcom/google/protobuf/GeneratedMessage;

    move-result-object v0

    check-cast v0, Lcom/google/protobuf/DescriptorProtos$ServiceDescriptorProto;

    goto :goto_0
.end method

.method public getServiceBuilder(I)Lcom/google/protobuf/DescriptorProtos$ServiceDescriptorProto$Builder;
    .locals 1

    .prologue
    .line 2386
    invoke-direct {p0}, Lcom/google/protobuf/DescriptorProtos$FileDescriptorProto$Builder;->getServiceFieldBuilder()Lcom/google/protobuf/RepeatedFieldBuilder;

    move-result-object v0

    invoke-virtual {v0, p1}, Lcom/google/protobuf/RepeatedFieldBuilder;->getBuilder(I)Lcom/google/protobuf/GeneratedMessage$Builder;

    move-result-object v0

    check-cast v0, Lcom/google/protobuf/DescriptorProtos$ServiceDescriptorProto$Builder;

    return-object v0
.end method

.method public getServiceBuilderList()Ljava/util/List;
    .locals 1
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "()",
            "Ljava/util/List",
            "<",
            "Lcom/google/protobuf/DescriptorProtos$ServiceDescriptorProto$Builder;",
            ">;"
        }
    .end annotation

    .prologue
    .line 2414
    invoke-direct {p0}, Lcom/google/protobuf/DescriptorProtos$FileDescriptorProto$Builder;->getServiceFieldBuilder()Lcom/google/protobuf/RepeatedFieldBuilder;

    move-result-object v0

    invoke-virtual {v0}, Lcom/google/protobuf/RepeatedFieldBuilder;->getBuilderList()Ljava/util/List;

    move-result-object v0

    return-object v0
.end method

.method public getServiceCount()I
    .locals 1

    .prologue
    .line 2266
    iget-object v0, p0, Lcom/google/protobuf/DescriptorProtos$FileDescriptorProto$Builder;->serviceBuilder_:Lcom/google/protobuf/RepeatedFieldBuilder;

    if-nez v0, :cond_0

    .line 2267
    iget-object v0, p0, Lcom/google/protobuf/DescriptorProtos$FileDescriptorProto$Builder;->service_:Ljava/util/List;

    invoke-interface {v0}, Ljava/util/List;->size()I

    move-result v0

    .line 2269
    :goto_0
    return v0

    :cond_0
    iget-object v0, p0, Lcom/google/protobuf/DescriptorProtos$FileDescriptorProto$Builder;->serviceBuilder_:Lcom/google/protobuf/RepeatedFieldBuilder;

    invoke-virtual {v0}, Lcom/google/protobuf/RepeatedFieldBuilder;->getCount()I

    move-result v0

    goto :goto_0
.end method

.method public getServiceList()Ljava/util/List;
    .locals 1
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "()",
            "Ljava/util/List",
            "<",
            "Lcom/google/protobuf/DescriptorProtos$ServiceDescriptorProto;",
            ">;"
        }
    .end annotation

    .prologue
    .line 2259
    iget-object v0, p0, Lcom/google/protobuf/DescriptorProtos$FileDescriptorProto$Builder;->serviceBuilder_:Lcom/google/protobuf/RepeatedFieldBuilder;

    if-nez v0, :cond_0

    .line 2260
    iget-object v0, p0, Lcom/google/protobuf/DescriptorProtos$FileDescriptorProto$Builder;->service_:Ljava/util/List;

    invoke-static {v0}, Ljava/util/Collections;->unmodifiableList(Ljava/util/List;)Ljava/util/List;

    move-result-object v0

    .line 2262
    :goto_0
    return-object v0

    :cond_0
    iget-object v0, p0, Lcom/google/protobuf/DescriptorProtos$FileDescriptorProto$Builder;->serviceBuilder_:Lcom/google/protobuf/RepeatedFieldBuilder;

    invoke-virtual {v0}, Lcom/google/protobuf/RepeatedFieldBuilder;->getMessageList()Ljava/util/List;

    move-result-object v0

    goto :goto_0
.end method

.method public getServiceOrBuilder(I)Lcom/google/protobuf/DescriptorProtos$ServiceDescriptorProtoOrBuilder;
    .locals 1

    .prologue
    .line 2390
    iget-object v0, p0, Lcom/google/protobuf/DescriptorProtos$FileDescriptorProto$Builder;->serviceBuilder_:Lcom/google/protobuf/RepeatedFieldBuilder;

    if-nez v0, :cond_0

    .line 2391
    iget-object v0, p0, Lcom/google/protobuf/DescriptorProtos$FileDescriptorProto$Builder;->service_:Ljava/util/List;

    invoke-interface {v0, p1}, Ljava/util/List;->get(I)Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Lcom/google/protobuf/DescriptorProtos$ServiceDescriptorProtoOrBuilder;

    .line 2392
    :goto_0
    return-object v0

    :cond_0
    iget-object v0, p0, Lcom/google/protobuf/DescriptorProtos$FileDescriptorProto$Builder;->serviceBuilder_:Lcom/google/protobuf/RepeatedFieldBuilder;

    invoke-virtual {v0, p1}, Lcom/google/protobuf/RepeatedFieldBuilder;->getMessageOrBuilder(I)Lcom/google/protobuf/MessageOrBuilder;

    move-result-object v0

    check-cast v0, Lcom/google/protobuf/DescriptorProtos$ServiceDescriptorProtoOrBuilder;

    goto :goto_0
.end method

.method public getServiceOrBuilderList()Ljava/util/List;
    .locals 1
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "()",
            "Ljava/util/List",
            "<+",
            "Lcom/google/protobuf/DescriptorProtos$ServiceDescriptorProtoOrBuilder;",
            ">;"
        }
    .end annotation

    .prologue
    .line 2397
    iget-object v0, p0, Lcom/google/protobuf/DescriptorProtos$FileDescriptorProto$Builder;->serviceBuilder_:Lcom/google/protobuf/RepeatedFieldBuilder;

    if-eqz v0, :cond_0

    .line 2398
    iget-object v0, p0, Lcom/google/protobuf/DescriptorProtos$FileDescriptorProto$Builder;->serviceBuilder_:Lcom/google/protobuf/RepeatedFieldBuilder;

    invoke-virtual {v0}, Lcom/google/protobuf/RepeatedFieldBuilder;->getMessageOrBuilderList()Ljava/util/List;

    move-result-object v0

    .line 2400
    :goto_0
    return-object v0

    :cond_0
    iget-object v0, p0, Lcom/google/protobuf/DescriptorProtos$FileDescriptorProto$Builder;->service_:Ljava/util/List;

    invoke-static {v0}, Ljava/util/Collections;->unmodifiableList(Ljava/util/List;)Ljava/util/List;

    move-result-object v0

    goto :goto_0
.end method

.method public getSourceCodeInfo()Lcom/google/protobuf/DescriptorProtos$SourceCodeInfo;
    .locals 1

    .prologue
    .line 2715
    iget-object v0, p0, Lcom/google/protobuf/DescriptorProtos$FileDescriptorProto$Builder;->sourceCodeInfoBuilder_:Lcom/google/protobuf/SingleFieldBuilder;

    if-nez v0, :cond_0

    .line 2716
    iget-object v0, p0, Lcom/google/protobuf/DescriptorProtos$FileDescriptorProto$Builder;->sourceCodeInfo_:Lcom/google/protobuf/DescriptorProtos$SourceCodeInfo;

    .line 2718
    :goto_0
    return-object v0

    :cond_0
    iget-object v0, p0, Lcom/google/protobuf/DescriptorProtos$FileDescriptorProto$Builder;->sourceCodeInfoBuilder_:Lcom/google/protobuf/SingleFieldBuilder;

    invoke-virtual {v0}, Lcom/google/protobuf/SingleFieldBuilder;->getMessage()Lcom/google/protobuf/GeneratedMessage;

    move-result-object v0

    check-cast v0, Lcom/google/protobuf/DescriptorProtos$SourceCodeInfo;

    goto :goto_0
.end method

.method public getSourceCodeInfoBuilder()Lcom/google/protobuf/DescriptorProtos$SourceCodeInfo$Builder;
    .locals 1

    .prologue
    .line 2772
    iget v0, p0, Lcom/google/protobuf/DescriptorProtos$FileDescriptorProto$Builder;->bitField0_:I

    or-int/lit16 v0, v0, 0x400

    iput v0, p0, Lcom/google/protobuf/DescriptorProtos$FileDescriptorProto$Builder;->bitField0_:I

    .line 2773
    invoke-virtual {p0}, Lcom/google/protobuf/DescriptorProtos$FileDescriptorProto$Builder;->onChanged()V

    .line 2774
    invoke-direct {p0}, Lcom/google/protobuf/DescriptorProtos$FileDescriptorProto$Builder;->getSourceCodeInfoFieldBuilder()Lcom/google/protobuf/SingleFieldBuilder;

    move-result-object v0

    invoke-virtual {v0}, Lcom/google/protobuf/SingleFieldBuilder;->getBuilder()Lcom/google/protobuf/GeneratedMessage$Builder;

    move-result-object v0

    check-cast v0, Lcom/google/protobuf/DescriptorProtos$SourceCodeInfo$Builder;

    return-object v0
.end method

.method public getSourceCodeInfoOrBuilder()Lcom/google/protobuf/DescriptorProtos$SourceCodeInfoOrBuilder;
    .locals 1

    .prologue
    .line 2777
    iget-object v0, p0, Lcom/google/protobuf/DescriptorProtos$FileDescriptorProto$Builder;->sourceCodeInfoBuilder_:Lcom/google/protobuf/SingleFieldBuilder;

    if-eqz v0, :cond_0

    .line 2778
    iget-object v0, p0, Lcom/google/protobuf/DescriptorProtos$FileDescriptorProto$Builder;->sourceCodeInfoBuilder_:Lcom/google/protobuf/SingleFieldBuilder;

    invoke-virtual {v0}, Lcom/google/protobuf/SingleFieldBuilder;->getMessageOrBuilder()Lcom/google/protobuf/MessageOrBuilder;

    move-result-object v0

    check-cast v0, Lcom/google/protobuf/DescriptorProtos$SourceCodeInfoOrBuilder;

    .line 2780
    :goto_0
    return-object v0

    :cond_0
    iget-object v0, p0, Lcom/google/protobuf/DescriptorProtos$FileDescriptorProto$Builder;->sourceCodeInfo_:Lcom/google/protobuf/DescriptorProtos$SourceCodeInfo;

    goto :goto_0
.end method

.method public getWeakDependency(I)I
    .locals 1

    .prologue
    .line 1844
    iget-object v0, p0, Lcom/google/protobuf/DescriptorProtos$FileDescriptorProto$Builder;->weakDependency_:Ljava/util/List;

    invoke-interface {v0, p1}, Ljava/util/List;->get(I)Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Ljava/lang/Integer;

    invoke-virtual {v0}, Ljava/lang/Integer;->intValue()I

    move-result v0

    return v0
.end method

.method public getWeakDependencyCount()I
    .locals 1

    .prologue
    .line 1841
    iget-object v0, p0, Lcom/google/protobuf/DescriptorProtos$FileDescriptorProto$Builder;->weakDependency_:Ljava/util/List;

    invoke-interface {v0}, Ljava/util/List;->size()I

    move-result v0

    return v0
.end method

.method public getWeakDependencyList()Ljava/util/List;
    .locals 1
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "()",
            "Ljava/util/List",
            "<",
            "Ljava/lang/Integer;",
            ">;"
        }
    .end annotation

    .prologue
    .line 1838
    iget-object v0, p0, Lcom/google/protobuf/DescriptorProtos$FileDescriptorProto$Builder;->weakDependency_:Ljava/util/List;

    invoke-static {v0}, Ljava/util/Collections;->unmodifiableList(Ljava/util/List;)Ljava/util/List;

    move-result-object v0

    return-object v0
.end method

.method public hasName()Z
    .locals 2

    .prologue
    const/4 v0, 0x1

    .line 1658
    iget v1, p0, Lcom/google/protobuf/DescriptorProtos$FileDescriptorProto$Builder;->bitField0_:I

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
    .line 2622
    iget v0, p0, Lcom/google/protobuf/DescriptorProtos$FileDescriptorProto$Builder;->bitField0_:I

    and-int/lit16 v0, v0, 0x200

    const/16 v1, 0x200

    if-ne v0, v1, :cond_0

    const/4 v0, 0x1

    :goto_0
    return v0

    :cond_0
    const/4 v0, 0x0

    goto :goto_0
.end method

.method public hasPackage()Z
    .locals 2

    .prologue
    .line 1694
    iget v0, p0, Lcom/google/protobuf/DescriptorProtos$FileDescriptorProto$Builder;->bitField0_:I

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

.method public hasSourceCodeInfo()Z
    .locals 2

    .prologue
    .line 2712
    iget v0, p0, Lcom/google/protobuf/DescriptorProtos$FileDescriptorProto$Builder;->bitField0_:I

    and-int/lit16 v0, v0, 0x400

    const/16 v1, 0x400

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
    .line 1153
    invoke-static {}, Lcom/google/protobuf/DescriptorProtos;->access$62()Lcom/google/protobuf/GeneratedMessage$FieldAccessorTable;

    move-result-object v0

    return-object v0
.end method

.method public final isInitialized()Z
    .locals 3

    .prologue
    const/4 v1, 0x0

    .line 1508
    move v0, v1

    :goto_0
    invoke-virtual {p0}, Lcom/google/protobuf/DescriptorProtos$FileDescriptorProto$Builder;->getMessageTypeCount()I

    move-result v2

    if-lt v0, v2, :cond_1

    move v0, v1

    .line 1514
    :goto_1
    invoke-virtual {p0}, Lcom/google/protobuf/DescriptorProtos$FileDescriptorProto$Builder;->getEnumTypeCount()I

    move-result v2

    if-lt v0, v2, :cond_2

    move v0, v1

    .line 1520
    :goto_2
    invoke-virtual {p0}, Lcom/google/protobuf/DescriptorProtos$FileDescriptorProto$Builder;->getServiceCount()I

    move-result v2

    if-lt v0, v2, :cond_3

    move v0, v1

    .line 1526
    :goto_3
    invoke-virtual {p0}, Lcom/google/protobuf/DescriptorProtos$FileDescriptorProto$Builder;->getExtensionCount()I

    move-result v2

    if-lt v0, v2, :cond_4

    .line 1532
    invoke-virtual {p0}, Lcom/google/protobuf/DescriptorProtos$FileDescriptorProto$Builder;->hasOptions()Z

    move-result v0

    if-eqz v0, :cond_5

    .line 1533
    invoke-virtual {p0}, Lcom/google/protobuf/DescriptorProtos$FileDescriptorProto$Builder;->getOptions()Lcom/google/protobuf/DescriptorProtos$FileOptions;

    move-result-object v0

    invoke-virtual {v0}, Lcom/google/protobuf/DescriptorProtos$FileOptions;->isInitialized()Z

    move-result v0

    if-nez v0, :cond_5

    .line 1538
    :cond_0
    :goto_4
    return v1

    .line 1509
    :cond_1
    invoke-virtual {p0, v0}, Lcom/google/protobuf/DescriptorProtos$FileDescriptorProto$Builder;->getMessageType(I)Lcom/google/protobuf/DescriptorProtos$DescriptorProto;

    move-result-object v2

    invoke-virtual {v2}, Lcom/google/protobuf/DescriptorProtos$DescriptorProto;->isInitialized()Z

    move-result v2

    if-eqz v2, :cond_0

    .line 1508
    add-int/lit8 v0, v0, 0x1

    goto :goto_0

    .line 1515
    :cond_2
    invoke-virtual {p0, v0}, Lcom/google/protobuf/DescriptorProtos$FileDescriptorProto$Builder;->getEnumType(I)Lcom/google/protobuf/DescriptorProtos$EnumDescriptorProto;

    move-result-object v2

    invoke-virtual {v2}, Lcom/google/protobuf/DescriptorProtos$EnumDescriptorProto;->isInitialized()Z

    move-result v2

    if-eqz v2, :cond_0

    .line 1514
    add-int/lit8 v0, v0, 0x1

    goto :goto_1

    .line 1521
    :cond_3
    invoke-virtual {p0, v0}, Lcom/google/protobuf/DescriptorProtos$FileDescriptorProto$Builder;->getService(I)Lcom/google/protobuf/DescriptorProtos$ServiceDescriptorProto;

    move-result-object v2

    invoke-virtual {v2}, Lcom/google/protobuf/DescriptorProtos$ServiceDescriptorProto;->isInitialized()Z

    move-result v2

    if-eqz v2, :cond_0

    .line 1520
    add-int/lit8 v0, v0, 0x1

    goto :goto_2

    .line 1527
    :cond_4
    invoke-virtual {p0, v0}, Lcom/google/protobuf/DescriptorProtos$FileDescriptorProto$Builder;->getExtension(I)Lcom/google/protobuf/DescriptorProtos$FieldDescriptorProto;

    move-result-object v2

    invoke-virtual {v2}, Lcom/google/protobuf/DescriptorProtos$FieldDescriptorProto;->isInitialized()Z

    move-result v2

    if-eqz v2, :cond_0

    .line 1526
    add-int/lit8 v0, v0, 0x1

    goto :goto_3

    .line 1538
    :cond_5
    const/4 v1, 0x1

    goto :goto_4
.end method

.method public bridge synthetic mergeFrom(Lcom/google/protobuf/CodedInputStream;Lcom/google/protobuf/ExtensionRegistryLite;)Lcom/google/protobuf/AbstractMessage$Builder;
    .locals 1
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljava/io/IOException;
        }
    .end annotation

    .prologue
    .line 1
    invoke-virtual {p0, p1, p2}, Lcom/google/protobuf/DescriptorProtos$FileDescriptorProto$Builder;->mergeFrom(Lcom/google/protobuf/CodedInputStream;Lcom/google/protobuf/ExtensionRegistryLite;)Lcom/google/protobuf/DescriptorProtos$FileDescriptorProto$Builder;

    move-result-object v0

    return-object v0
.end method

.method public bridge synthetic mergeFrom(Lcom/google/protobuf/Message;)Lcom/google/protobuf/AbstractMessage$Builder;
    .locals 1

    .prologue
    .line 1
    invoke-virtual {p0, p1}, Lcom/google/protobuf/DescriptorProtos$FileDescriptorProto$Builder;->mergeFrom(Lcom/google/protobuf/Message;)Lcom/google/protobuf/DescriptorProtos$FileDescriptorProto$Builder;

    move-result-object v0

    return-object v0
.end method

.method public mergeFrom(Lcom/google/protobuf/CodedInputStream;Lcom/google/protobuf/ExtensionRegistryLite;)Lcom/google/protobuf/DescriptorProtos$FileDescriptorProto$Builder;
    .locals 3
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljava/io/IOException;
        }
    .end annotation

    .prologue
    .line 1547
    invoke-virtual {p0}, Lcom/google/protobuf/DescriptorProtos$FileDescriptorProto$Builder;->getUnknownFields()Lcom/google/protobuf/UnknownFieldSet;

    move-result-object v0

    .line 1546
    invoke-static {v0}, Lcom/google/protobuf/UnknownFieldSet;->newBuilder(Lcom/google/protobuf/UnknownFieldSet;)Lcom/google/protobuf/UnknownFieldSet$Builder;

    move-result-object v0

    .line 1549
    :cond_0
    :goto_0
    invoke-virtual {p1}, Lcom/google/protobuf/CodedInputStream;->readTag()I

    move-result v1

    .line 1550
    sparse-switch v1, :sswitch_data_0

    .line 1556
    invoke-virtual {p0, p1, v0, p2, v1}, Lcom/google/protobuf/DescriptorProtos$FileDescriptorProto$Builder;->parseUnknownField(Lcom/google/protobuf/CodedInputStream;Lcom/google/protobuf/UnknownFieldSet$Builder;Lcom/google/protobuf/ExtensionRegistryLite;I)Z

    move-result v1

    if-nez v1, :cond_0

    .line 1558
    invoke-virtual {v0}, Lcom/google/protobuf/UnknownFieldSet$Builder;->build()Lcom/google/protobuf/UnknownFieldSet;

    move-result-object v0

    invoke-virtual {p0, v0}, Lcom/google/protobuf/DescriptorProtos$FileDescriptorProto$Builder;->setUnknownFields(Lcom/google/protobuf/UnknownFieldSet;)Lcom/google/protobuf/GeneratedMessage$Builder;

    .line 1559
    invoke-virtual {p0}, Lcom/google/protobuf/DescriptorProtos$FileDescriptorProto$Builder;->onChanged()V

    .line 1560
    :goto_1
    return-object p0

    .line 1552
    :sswitch_0
    invoke-virtual {v0}, Lcom/google/protobuf/UnknownFieldSet$Builder;->build()Lcom/google/protobuf/UnknownFieldSet;

    move-result-object v0

    invoke-virtual {p0, v0}, Lcom/google/protobuf/DescriptorProtos$FileDescriptorProto$Builder;->setUnknownFields(Lcom/google/protobuf/UnknownFieldSet;)Lcom/google/protobuf/GeneratedMessage$Builder;

    .line 1553
    invoke-virtual {p0}, Lcom/google/protobuf/DescriptorProtos$FileDescriptorProto$Builder;->onChanged()V

    goto :goto_1

    .line 1565
    :sswitch_1
    iget v1, p0, Lcom/google/protobuf/DescriptorProtos$FileDescriptorProto$Builder;->bitField0_:I

    or-int/lit8 v1, v1, 0x1

    iput v1, p0, Lcom/google/protobuf/DescriptorProtos$FileDescriptorProto$Builder;->bitField0_:I

    .line 1566
    invoke-virtual {p1}, Lcom/google/protobuf/CodedInputStream;->readBytes()Lcom/google/protobuf/ByteString;

    move-result-object v1

    iput-object v1, p0, Lcom/google/protobuf/DescriptorProtos$FileDescriptorProto$Builder;->name_:Ljava/lang/Object;

    goto :goto_0

    .line 1570
    :sswitch_2
    iget v1, p0, Lcom/google/protobuf/DescriptorProtos$FileDescriptorProto$Builder;->bitField0_:I

    or-int/lit8 v1, v1, 0x2

    iput v1, p0, Lcom/google/protobuf/DescriptorProtos$FileDescriptorProto$Builder;->bitField0_:I

    .line 1571
    invoke-virtual {p1}, Lcom/google/protobuf/CodedInputStream;->readBytes()Lcom/google/protobuf/ByteString;

    move-result-object v1

    iput-object v1, p0, Lcom/google/protobuf/DescriptorProtos$FileDescriptorProto$Builder;->package_:Ljava/lang/Object;

    goto :goto_0

    .line 1575
    :sswitch_3
    invoke-direct {p0}, Lcom/google/protobuf/DescriptorProtos$FileDescriptorProto$Builder;->ensureDependencyIsMutable()V

    .line 1576
    iget-object v1, p0, Lcom/google/protobuf/DescriptorProtos$FileDescriptorProto$Builder;->dependency_:Lcom/google/protobuf/LazyStringList;

    invoke-virtual {p1}, Lcom/google/protobuf/CodedInputStream;->readBytes()Lcom/google/protobuf/ByteString;

    move-result-object v2

    invoke-interface {v1, v2}, Lcom/google/protobuf/LazyStringList;->add(Lcom/google/protobuf/ByteString;)V

    goto :goto_0

    .line 1580
    :sswitch_4
    invoke-static {}, Lcom/google/protobuf/DescriptorProtos$DescriptorProto;->newBuilder()Lcom/google/protobuf/DescriptorProtos$DescriptorProto$Builder;

    move-result-object v1

    .line 1581
    invoke-virtual {p1, v1, p2}, Lcom/google/protobuf/CodedInputStream;->readMessage(Lcom/google/protobuf/MessageLite$Builder;Lcom/google/protobuf/ExtensionRegistryLite;)V

    .line 1582
    invoke-virtual {v1}, Lcom/google/protobuf/DescriptorProtos$DescriptorProto$Builder;->buildPartial()Lcom/google/protobuf/DescriptorProtos$DescriptorProto;

    move-result-object v1

    invoke-virtual {p0, v1}, Lcom/google/protobuf/DescriptorProtos$FileDescriptorProto$Builder;->addMessageType(Lcom/google/protobuf/DescriptorProtos$DescriptorProto;)Lcom/google/protobuf/DescriptorProtos$FileDescriptorProto$Builder;

    goto :goto_0

    .line 1586
    :sswitch_5
    invoke-static {}, Lcom/google/protobuf/DescriptorProtos$EnumDescriptorProto;->newBuilder()Lcom/google/protobuf/DescriptorProtos$EnumDescriptorProto$Builder;

    move-result-object v1

    .line 1587
    invoke-virtual {p1, v1, p2}, Lcom/google/protobuf/CodedInputStream;->readMessage(Lcom/google/protobuf/MessageLite$Builder;Lcom/google/protobuf/ExtensionRegistryLite;)V

    .line 1588
    invoke-virtual {v1}, Lcom/google/protobuf/DescriptorProtos$EnumDescriptorProto$Builder;->buildPartial()Lcom/google/protobuf/DescriptorProtos$EnumDescriptorProto;

    move-result-object v1

    invoke-virtual {p0, v1}, Lcom/google/protobuf/DescriptorProtos$FileDescriptorProto$Builder;->addEnumType(Lcom/google/protobuf/DescriptorProtos$EnumDescriptorProto;)Lcom/google/protobuf/DescriptorProtos$FileDescriptorProto$Builder;

    goto :goto_0

    .line 1592
    :sswitch_6
    invoke-static {}, Lcom/google/protobuf/DescriptorProtos$ServiceDescriptorProto;->newBuilder()Lcom/google/protobuf/DescriptorProtos$ServiceDescriptorProto$Builder;

    move-result-object v1

    .line 1593
    invoke-virtual {p1, v1, p2}, Lcom/google/protobuf/CodedInputStream;->readMessage(Lcom/google/protobuf/MessageLite$Builder;Lcom/google/protobuf/ExtensionRegistryLite;)V

    .line 1594
    invoke-virtual {v1}, Lcom/google/protobuf/DescriptorProtos$ServiceDescriptorProto$Builder;->buildPartial()Lcom/google/protobuf/DescriptorProtos$ServiceDescriptorProto;

    move-result-object v1

    invoke-virtual {p0, v1}, Lcom/google/protobuf/DescriptorProtos$FileDescriptorProto$Builder;->addService(Lcom/google/protobuf/DescriptorProtos$ServiceDescriptorProto;)Lcom/google/protobuf/DescriptorProtos$FileDescriptorProto$Builder;

    goto :goto_0

    .line 1598
    :sswitch_7
    invoke-static {}, Lcom/google/protobuf/DescriptorProtos$FieldDescriptorProto;->newBuilder()Lcom/google/protobuf/DescriptorProtos$FieldDescriptorProto$Builder;

    move-result-object v1

    .line 1599
    invoke-virtual {p1, v1, p2}, Lcom/google/protobuf/CodedInputStream;->readMessage(Lcom/google/protobuf/MessageLite$Builder;Lcom/google/protobuf/ExtensionRegistryLite;)V

    .line 1600
    invoke-virtual {v1}, Lcom/google/protobuf/DescriptorProtos$FieldDescriptorProto$Builder;->buildPartial()Lcom/google/protobuf/DescriptorProtos$FieldDescriptorProto;

    move-result-object v1

    invoke-virtual {p0, v1}, Lcom/google/protobuf/DescriptorProtos$FileDescriptorProto$Builder;->addExtension(Lcom/google/protobuf/DescriptorProtos$FieldDescriptorProto;)Lcom/google/protobuf/DescriptorProtos$FileDescriptorProto$Builder;

    goto/16 :goto_0

    .line 1604
    :sswitch_8
    invoke-static {}, Lcom/google/protobuf/DescriptorProtos$FileOptions;->newBuilder()Lcom/google/protobuf/DescriptorProtos$FileOptions$Builder;

    move-result-object v1

    .line 1605
    invoke-virtual {p0}, Lcom/google/protobuf/DescriptorProtos$FileDescriptorProto$Builder;->hasOptions()Z

    move-result v2

    if-eqz v2, :cond_1

    .line 1606
    invoke-virtual {p0}, Lcom/google/protobuf/DescriptorProtos$FileDescriptorProto$Builder;->getOptions()Lcom/google/protobuf/DescriptorProtos$FileOptions;

    move-result-object v2

    invoke-virtual {v1, v2}, Lcom/google/protobuf/DescriptorProtos$FileOptions$Builder;->mergeFrom(Lcom/google/protobuf/DescriptorProtos$FileOptions;)Lcom/google/protobuf/DescriptorProtos$FileOptions$Builder;

    .line 1608
    :cond_1
    invoke-virtual {p1, v1, p2}, Lcom/google/protobuf/CodedInputStream;->readMessage(Lcom/google/protobuf/MessageLite$Builder;Lcom/google/protobuf/ExtensionRegistryLite;)V

    .line 1609
    invoke-virtual {v1}, Lcom/google/protobuf/DescriptorProtos$FileOptions$Builder;->buildPartial()Lcom/google/protobuf/DescriptorProtos$FileOptions;

    move-result-object v1

    invoke-virtual {p0, v1}, Lcom/google/protobuf/DescriptorProtos$FileDescriptorProto$Builder;->setOptions(Lcom/google/protobuf/DescriptorProtos$FileOptions;)Lcom/google/protobuf/DescriptorProtos$FileDescriptorProto$Builder;

    goto/16 :goto_0

    .line 1613
    :sswitch_9
    invoke-static {}, Lcom/google/protobuf/DescriptorProtos$SourceCodeInfo;->newBuilder()Lcom/google/protobuf/DescriptorProtos$SourceCodeInfo$Builder;

    move-result-object v1

    .line 1614
    invoke-virtual {p0}, Lcom/google/protobuf/DescriptorProtos$FileDescriptorProto$Builder;->hasSourceCodeInfo()Z

    move-result v2

    if-eqz v2, :cond_2

    .line 1615
    invoke-virtual {p0}, Lcom/google/protobuf/DescriptorProtos$FileDescriptorProto$Builder;->getSourceCodeInfo()Lcom/google/protobuf/DescriptorProtos$SourceCodeInfo;

    move-result-object v2

    invoke-virtual {v1, v2}, Lcom/google/protobuf/DescriptorProtos$SourceCodeInfo$Builder;->mergeFrom(Lcom/google/protobuf/DescriptorProtos$SourceCodeInfo;)Lcom/google/protobuf/DescriptorProtos$SourceCodeInfo$Builder;

    .line 1617
    :cond_2
    invoke-virtual {p1, v1, p2}, Lcom/google/protobuf/CodedInputStream;->readMessage(Lcom/google/protobuf/MessageLite$Builder;Lcom/google/protobuf/ExtensionRegistryLite;)V

    .line 1618
    invoke-virtual {v1}, Lcom/google/protobuf/DescriptorProtos$SourceCodeInfo$Builder;->buildPartial()Lcom/google/protobuf/DescriptorProtos$SourceCodeInfo;

    move-result-object v1

    invoke-virtual {p0, v1}, Lcom/google/protobuf/DescriptorProtos$FileDescriptorProto$Builder;->setSourceCodeInfo(Lcom/google/protobuf/DescriptorProtos$SourceCodeInfo;)Lcom/google/protobuf/DescriptorProtos$FileDescriptorProto$Builder;

    goto/16 :goto_0

    .line 1622
    :sswitch_a
    invoke-direct {p0}, Lcom/google/protobuf/DescriptorProtos$FileDescriptorProto$Builder;->ensurePublicDependencyIsMutable()V

    .line 1623
    iget-object v1, p0, Lcom/google/protobuf/DescriptorProtos$FileDescriptorProto$Builder;->publicDependency_:Ljava/util/List;

    invoke-virtual {p1}, Lcom/google/protobuf/CodedInputStream;->readInt32()I

    move-result v2

    invoke-static {v2}, Ljava/lang/Integer;->valueOf(I)Ljava/lang/Integer;

    move-result-object v2

    invoke-interface {v1, v2}, Ljava/util/List;->add(Ljava/lang/Object;)Z

    goto/16 :goto_0

    .line 1627
    :sswitch_b
    invoke-virtual {p1}, Lcom/google/protobuf/CodedInputStream;->readRawVarint32()I

    move-result v1

    .line 1628
    invoke-virtual {p1, v1}, Lcom/google/protobuf/CodedInputStream;->pushLimit(I)I

    move-result v1

    .line 1629
    :goto_2
    invoke-virtual {p1}, Lcom/google/protobuf/CodedInputStream;->getBytesUntilLimit()I

    move-result v2

    if-gtz v2, :cond_3

    .line 1632
    invoke-virtual {p1, v1}, Lcom/google/protobuf/CodedInputStream;->popLimit(I)V

    goto/16 :goto_0

    .line 1630
    :cond_3
    invoke-virtual {p1}, Lcom/google/protobuf/CodedInputStream;->readInt32()I

    move-result v2

    invoke-virtual {p0, v2}, Lcom/google/protobuf/DescriptorProtos$FileDescriptorProto$Builder;->addPublicDependency(I)Lcom/google/protobuf/DescriptorProtos$FileDescriptorProto$Builder;

    goto :goto_2

    .line 1636
    :sswitch_c
    invoke-direct {p0}, Lcom/google/protobuf/DescriptorProtos$FileDescriptorProto$Builder;->ensureWeakDependencyIsMutable()V

    .line 1637
    iget-object v1, p0, Lcom/google/protobuf/DescriptorProtos$FileDescriptorProto$Builder;->weakDependency_:Ljava/util/List;

    invoke-virtual {p1}, Lcom/google/protobuf/CodedInputStream;->readInt32()I

    move-result v2

    invoke-static {v2}, Ljava/lang/Integer;->valueOf(I)Ljava/lang/Integer;

    move-result-object v2

    invoke-interface {v1, v2}, Ljava/util/List;->add(Ljava/lang/Object;)Z

    goto/16 :goto_0

    .line 1641
    :sswitch_d
    invoke-virtual {p1}, Lcom/google/protobuf/CodedInputStream;->readRawVarint32()I

    move-result v1

    .line 1642
    invoke-virtual {p1, v1}, Lcom/google/protobuf/CodedInputStream;->pushLimit(I)I

    move-result v1

    .line 1643
    :goto_3
    invoke-virtual {p1}, Lcom/google/protobuf/CodedInputStream;->getBytesUntilLimit()I

    move-result v2

    if-gtz v2, :cond_4

    .line 1646
    invoke-virtual {p1, v1}, Lcom/google/protobuf/CodedInputStream;->popLimit(I)V

    goto/16 :goto_0

    .line 1644
    :cond_4
    invoke-virtual {p1}, Lcom/google/protobuf/CodedInputStream;->readInt32()I

    move-result v2

    invoke-virtual {p0, v2}, Lcom/google/protobuf/DescriptorProtos$FileDescriptorProto$Builder;->addWeakDependency(I)Lcom/google/protobuf/DescriptorProtos$FileDescriptorProto$Builder;

    goto :goto_3

    .line 1550
    nop

    :sswitch_data_0
    .sparse-switch
        0x0 -> :sswitch_0
        0xa -> :sswitch_1
        0x12 -> :sswitch_2
        0x1a -> :sswitch_3
        0x22 -> :sswitch_4
        0x2a -> :sswitch_5
        0x32 -> :sswitch_6
        0x3a -> :sswitch_7
        0x42 -> :sswitch_8
        0x4a -> :sswitch_9
        0x50 -> :sswitch_a
        0x52 -> :sswitch_b
        0x58 -> :sswitch_c
        0x5a -> :sswitch_d
    .end sparse-switch
.end method

.method public mergeFrom(Lcom/google/protobuf/DescriptorProtos$FileDescriptorProto;)Lcom/google/protobuf/DescriptorProtos$FileDescriptorProto$Builder;
    .locals 3

    .prologue
    const/4 v1, 0x0

    .line 1356
    invoke-static {}, Lcom/google/protobuf/DescriptorProtos$FileDescriptorProto;->getDefaultInstance()Lcom/google/protobuf/DescriptorProtos$FileDescriptorProto;

    move-result-object v0

    if-ne p1, v0, :cond_0

    .line 1504
    :goto_0
    return-object p0

    .line 1357
    :cond_0
    invoke-virtual {p1}, Lcom/google/protobuf/DescriptorProtos$FileDescriptorProto;->hasName()Z

    move-result v0

    if-eqz v0, :cond_1

    .line 1358
    invoke-virtual {p1}, Lcom/google/protobuf/DescriptorProtos$FileDescriptorProto;->getName()Ljava/lang/String;

    move-result-object v0

    invoke-virtual {p0, v0}, Lcom/google/protobuf/DescriptorProtos$FileDescriptorProto$Builder;->setName(Ljava/lang/String;)Lcom/google/protobuf/DescriptorProtos$FileDescriptorProto$Builder;

    .line 1360
    :cond_1
    invoke-virtual {p1}, Lcom/google/protobuf/DescriptorProtos$FileDescriptorProto;->hasPackage()Z

    move-result v0

    if-eqz v0, :cond_2

    .line 1361
    invoke-virtual {p1}, Lcom/google/protobuf/DescriptorProtos$FileDescriptorProto;->getPackage()Ljava/lang/String;

    move-result-object v0

    invoke-virtual {p0, v0}, Lcom/google/protobuf/DescriptorProtos$FileDescriptorProto$Builder;->setPackage(Ljava/lang/String;)Lcom/google/protobuf/DescriptorProtos$FileDescriptorProto$Builder;

    .line 1363
    :cond_2
    invoke-static {p1}, Lcom/google/protobuf/DescriptorProtos$FileDescriptorProto;->access$20(Lcom/google/protobuf/DescriptorProtos$FileDescriptorProto;)Lcom/google/protobuf/LazyStringList;

    move-result-object v0

    invoke-interface {v0}, Lcom/google/protobuf/LazyStringList;->isEmpty()Z

    move-result v0

    if-nez v0, :cond_3

    .line 1364
    iget-object v0, p0, Lcom/google/protobuf/DescriptorProtos$FileDescriptorProto$Builder;->dependency_:Lcom/google/protobuf/LazyStringList;

    invoke-interface {v0}, Lcom/google/protobuf/LazyStringList;->isEmpty()Z

    move-result v0

    if-eqz v0, :cond_c

    .line 1365
    invoke-static {p1}, Lcom/google/protobuf/DescriptorProtos$FileDescriptorProto;->access$20(Lcom/google/protobuf/DescriptorProtos$FileDescriptorProto;)Lcom/google/protobuf/LazyStringList;

    move-result-object v0

    iput-object v0, p0, Lcom/google/protobuf/DescriptorProtos$FileDescriptorProto$Builder;->dependency_:Lcom/google/protobuf/LazyStringList;

    .line 1366
    iget v0, p0, Lcom/google/protobuf/DescriptorProtos$FileDescriptorProto$Builder;->bitField0_:I

    and-int/lit8 v0, v0, -0x5

    iput v0, p0, Lcom/google/protobuf/DescriptorProtos$FileDescriptorProto$Builder;->bitField0_:I

    .line 1371
    :goto_1
    invoke-virtual {p0}, Lcom/google/protobuf/DescriptorProtos$FileDescriptorProto$Builder;->onChanged()V

    .line 1373
    :cond_3
    invoke-static {p1}, Lcom/google/protobuf/DescriptorProtos$FileDescriptorProto;->access$21(Lcom/google/protobuf/DescriptorProtos$FileDescriptorProto;)Ljava/util/List;

    move-result-object v0

    invoke-interface {v0}, Ljava/util/List;->isEmpty()Z

    move-result v0

    if-nez v0, :cond_4

    .line 1374
    iget-object v0, p0, Lcom/google/protobuf/DescriptorProtos$FileDescriptorProto$Builder;->publicDependency_:Ljava/util/List;

    invoke-interface {v0}, Ljava/util/List;->isEmpty()Z

    move-result v0

    if-eqz v0, :cond_d

    .line 1375
    invoke-static {p1}, Lcom/google/protobuf/DescriptorProtos$FileDescriptorProto;->access$21(Lcom/google/protobuf/DescriptorProtos$FileDescriptorProto;)Ljava/util/List;

    move-result-object v0

    iput-object v0, p0, Lcom/google/protobuf/DescriptorProtos$FileDescriptorProto$Builder;->publicDependency_:Ljava/util/List;

    .line 1376
    iget v0, p0, Lcom/google/protobuf/DescriptorProtos$FileDescriptorProto$Builder;->bitField0_:I

    and-int/lit8 v0, v0, -0x9

    iput v0, p0, Lcom/google/protobuf/DescriptorProtos$FileDescriptorProto$Builder;->bitField0_:I

    .line 1381
    :goto_2
    invoke-virtual {p0}, Lcom/google/protobuf/DescriptorProtos$FileDescriptorProto$Builder;->onChanged()V

    .line 1383
    :cond_4
    invoke-static {p1}, Lcom/google/protobuf/DescriptorProtos$FileDescriptorProto;->access$22(Lcom/google/protobuf/DescriptorProtos$FileDescriptorProto;)Ljava/util/List;

    move-result-object v0

    invoke-interface {v0}, Ljava/util/List;->isEmpty()Z

    move-result v0

    if-nez v0, :cond_5

    .line 1384
    iget-object v0, p0, Lcom/google/protobuf/DescriptorProtos$FileDescriptorProto$Builder;->weakDependency_:Ljava/util/List;

    invoke-interface {v0}, Ljava/util/List;->isEmpty()Z

    move-result v0

    if-eqz v0, :cond_e

    .line 1385
    invoke-static {p1}, Lcom/google/protobuf/DescriptorProtos$FileDescriptorProto;->access$22(Lcom/google/protobuf/DescriptorProtos$FileDescriptorProto;)Ljava/util/List;

    move-result-object v0

    iput-object v0, p0, Lcom/google/protobuf/DescriptorProtos$FileDescriptorProto$Builder;->weakDependency_:Ljava/util/List;

    .line 1386
    iget v0, p0, Lcom/google/protobuf/DescriptorProtos$FileDescriptorProto$Builder;->bitField0_:I

    and-int/lit8 v0, v0, -0x11

    iput v0, p0, Lcom/google/protobuf/DescriptorProtos$FileDescriptorProto$Builder;->bitField0_:I

    .line 1391
    :goto_3
    invoke-virtual {p0}, Lcom/google/protobuf/DescriptorProtos$FileDescriptorProto$Builder;->onChanged()V

    .line 1393
    :cond_5
    iget-object v0, p0, Lcom/google/protobuf/DescriptorProtos$FileDescriptorProto$Builder;->messageTypeBuilder_:Lcom/google/protobuf/RepeatedFieldBuilder;

    if-nez v0, :cond_10

    .line 1394
    invoke-static {p1}, Lcom/google/protobuf/DescriptorProtos$FileDescriptorProto;->access$23(Lcom/google/protobuf/DescriptorProtos$FileDescriptorProto;)Ljava/util/List;

    move-result-object v0

    invoke-interface {v0}, Ljava/util/List;->isEmpty()Z

    move-result v0

    if-nez v0, :cond_6

    .line 1395
    iget-object v0, p0, Lcom/google/protobuf/DescriptorProtos$FileDescriptorProto$Builder;->messageType_:Ljava/util/List;

    invoke-interface {v0}, Ljava/util/List;->isEmpty()Z

    move-result v0

    if-eqz v0, :cond_f

    .line 1396
    invoke-static {p1}, Lcom/google/protobuf/DescriptorProtos$FileDescriptorProto;->access$23(Lcom/google/protobuf/DescriptorProtos$FileDescriptorProto;)Ljava/util/List;

    move-result-object v0

    iput-object v0, p0, Lcom/google/protobuf/DescriptorProtos$FileDescriptorProto$Builder;->messageType_:Ljava/util/List;

    .line 1397
    iget v0, p0, Lcom/google/protobuf/DescriptorProtos$FileDescriptorProto$Builder;->bitField0_:I

    and-int/lit8 v0, v0, -0x21

    iput v0, p0, Lcom/google/protobuf/DescriptorProtos$FileDescriptorProto$Builder;->bitField0_:I

    .line 1402
    :goto_4
    invoke-virtual {p0}, Lcom/google/protobuf/DescriptorProtos$FileDescriptorProto$Builder;->onChanged()V

    .line 1419
    :cond_6
    :goto_5
    iget-object v0, p0, Lcom/google/protobuf/DescriptorProtos$FileDescriptorProto$Builder;->enumTypeBuilder_:Lcom/google/protobuf/RepeatedFieldBuilder;

    if-nez v0, :cond_14

    .line 1420
    invoke-static {p1}, Lcom/google/protobuf/DescriptorProtos$FileDescriptorProto;->access$24(Lcom/google/protobuf/DescriptorProtos$FileDescriptorProto;)Ljava/util/List;

    move-result-object v0

    invoke-interface {v0}, Ljava/util/List;->isEmpty()Z

    move-result v0

    if-nez v0, :cond_7

    .line 1421
    iget-object v0, p0, Lcom/google/protobuf/DescriptorProtos$FileDescriptorProto$Builder;->enumType_:Ljava/util/List;

    invoke-interface {v0}, Ljava/util/List;->isEmpty()Z

    move-result v0

    if-eqz v0, :cond_13

    .line 1422
    invoke-static {p1}, Lcom/google/protobuf/DescriptorProtos$FileDescriptorProto;->access$24(Lcom/google/protobuf/DescriptorProtos$FileDescriptorProto;)Ljava/util/List;

    move-result-object v0

    iput-object v0, p0, Lcom/google/protobuf/DescriptorProtos$FileDescriptorProto$Builder;->enumType_:Ljava/util/List;

    .line 1423
    iget v0, p0, Lcom/google/protobuf/DescriptorProtos$FileDescriptorProto$Builder;->bitField0_:I

    and-int/lit8 v0, v0, -0x41

    iput v0, p0, Lcom/google/protobuf/DescriptorProtos$FileDescriptorProto$Builder;->bitField0_:I

    .line 1428
    :goto_6
    invoke-virtual {p0}, Lcom/google/protobuf/DescriptorProtos$FileDescriptorProto$Builder;->onChanged()V

    .line 1445
    :cond_7
    :goto_7
    iget-object v0, p0, Lcom/google/protobuf/DescriptorProtos$FileDescriptorProto$Builder;->serviceBuilder_:Lcom/google/protobuf/RepeatedFieldBuilder;

    if-nez v0, :cond_18

    .line 1446
    invoke-static {p1}, Lcom/google/protobuf/DescriptorProtos$FileDescriptorProto;->access$25(Lcom/google/protobuf/DescriptorProtos$FileDescriptorProto;)Ljava/util/List;

    move-result-object v0

    invoke-interface {v0}, Ljava/util/List;->isEmpty()Z

    move-result v0

    if-nez v0, :cond_8

    .line 1447
    iget-object v0, p0, Lcom/google/protobuf/DescriptorProtos$FileDescriptorProto$Builder;->service_:Ljava/util/List;

    invoke-interface {v0}, Ljava/util/List;->isEmpty()Z

    move-result v0

    if-eqz v0, :cond_17

    .line 1448
    invoke-static {p1}, Lcom/google/protobuf/DescriptorProtos$FileDescriptorProto;->access$25(Lcom/google/protobuf/DescriptorProtos$FileDescriptorProto;)Ljava/util/List;

    move-result-object v0

    iput-object v0, p0, Lcom/google/protobuf/DescriptorProtos$FileDescriptorProto$Builder;->service_:Ljava/util/List;

    .line 1449
    iget v0, p0, Lcom/google/protobuf/DescriptorProtos$FileDescriptorProto$Builder;->bitField0_:I

    and-int/lit16 v0, v0, -0x81

    iput v0, p0, Lcom/google/protobuf/DescriptorProtos$FileDescriptorProto$Builder;->bitField0_:I

    .line 1454
    :goto_8
    invoke-virtual {p0}, Lcom/google/protobuf/DescriptorProtos$FileDescriptorProto$Builder;->onChanged()V

    .line 1471
    :cond_8
    :goto_9
    iget-object v0, p0, Lcom/google/protobuf/DescriptorProtos$FileDescriptorProto$Builder;->extensionBuilder_:Lcom/google/protobuf/RepeatedFieldBuilder;

    if-nez v0, :cond_1c

    .line 1472
    invoke-static {p1}, Lcom/google/protobuf/DescriptorProtos$FileDescriptorProto;->access$26(Lcom/google/protobuf/DescriptorProtos$FileDescriptorProto;)Ljava/util/List;

    move-result-object v0

    invoke-interface {v0}, Ljava/util/List;->isEmpty()Z

    move-result v0

    if-nez v0, :cond_9

    .line 1473
    iget-object v0, p0, Lcom/google/protobuf/DescriptorProtos$FileDescriptorProto$Builder;->extension_:Ljava/util/List;

    invoke-interface {v0}, Ljava/util/List;->isEmpty()Z

    move-result v0

    if-eqz v0, :cond_1b

    .line 1474
    invoke-static {p1}, Lcom/google/protobuf/DescriptorProtos$FileDescriptorProto;->access$26(Lcom/google/protobuf/DescriptorProtos$FileDescriptorProto;)Ljava/util/List;

    move-result-object v0

    iput-object v0, p0, Lcom/google/protobuf/DescriptorProtos$FileDescriptorProto$Builder;->extension_:Ljava/util/List;

    .line 1475
    iget v0, p0, Lcom/google/protobuf/DescriptorProtos$FileDescriptorProto$Builder;->bitField0_:I

    and-int/lit16 v0, v0, -0x101

    iput v0, p0, Lcom/google/protobuf/DescriptorProtos$FileDescriptorProto$Builder;->bitField0_:I

    .line 1480
    :goto_a
    invoke-virtual {p0}, Lcom/google/protobuf/DescriptorProtos$FileDescriptorProto$Builder;->onChanged()V

    .line 1497
    :cond_9
    :goto_b
    invoke-virtual {p1}, Lcom/google/protobuf/DescriptorProtos$FileDescriptorProto;->hasOptions()Z

    move-result v0

    if-eqz v0, :cond_a

    .line 1498
    invoke-virtual {p1}, Lcom/google/protobuf/DescriptorProtos$FileDescriptorProto;->getOptions()Lcom/google/protobuf/DescriptorProtos$FileOptions;

    move-result-object v0

    invoke-virtual {p0, v0}, Lcom/google/protobuf/DescriptorProtos$FileDescriptorProto$Builder;->mergeOptions(Lcom/google/protobuf/DescriptorProtos$FileOptions;)Lcom/google/protobuf/DescriptorProtos$FileDescriptorProto$Builder;

    .line 1500
    :cond_a
    invoke-virtual {p1}, Lcom/google/protobuf/DescriptorProtos$FileDescriptorProto;->hasSourceCodeInfo()Z

    move-result v0

    if-eqz v0, :cond_b

    .line 1501
    invoke-virtual {p1}, Lcom/google/protobuf/DescriptorProtos$FileDescriptorProto;->getSourceCodeInfo()Lcom/google/protobuf/DescriptorProtos$SourceCodeInfo;

    move-result-object v0

    invoke-virtual {p0, v0}, Lcom/google/protobuf/DescriptorProtos$FileDescriptorProto$Builder;->mergeSourceCodeInfo(Lcom/google/protobuf/DescriptorProtos$SourceCodeInfo;)Lcom/google/protobuf/DescriptorProtos$FileDescriptorProto$Builder;

    .line 1503
    :cond_b
    invoke-virtual {p1}, Lcom/google/protobuf/DescriptorProtos$FileDescriptorProto;->getUnknownFields()Lcom/google/protobuf/UnknownFieldSet;

    move-result-object v0

    invoke-virtual {p0, v0}, Lcom/google/protobuf/DescriptorProtos$FileDescriptorProto$Builder;->mergeUnknownFields(Lcom/google/protobuf/UnknownFieldSet;)Lcom/google/protobuf/GeneratedMessage$Builder;

    goto/16 :goto_0

    .line 1368
    :cond_c
    invoke-direct {p0}, Lcom/google/protobuf/DescriptorProtos$FileDescriptorProto$Builder;->ensureDependencyIsMutable()V

    .line 1369
    iget-object v0, p0, Lcom/google/protobuf/DescriptorProtos$FileDescriptorProto$Builder;->dependency_:Lcom/google/protobuf/LazyStringList;

    invoke-static {p1}, Lcom/google/protobuf/DescriptorProtos$FileDescriptorProto;->access$20(Lcom/google/protobuf/DescriptorProtos$FileDescriptorProto;)Lcom/google/protobuf/LazyStringList;

    move-result-object v2

    invoke-interface {v0, v2}, Lcom/google/protobuf/LazyStringList;->addAll(Ljava/util/Collection;)Z

    goto/16 :goto_1

    .line 1378
    :cond_d
    invoke-direct {p0}, Lcom/google/protobuf/DescriptorProtos$FileDescriptorProto$Builder;->ensurePublicDependencyIsMutable()V

    .line 1379
    iget-object v0, p0, Lcom/google/protobuf/DescriptorProtos$FileDescriptorProto$Builder;->publicDependency_:Ljava/util/List;

    invoke-static {p1}, Lcom/google/protobuf/DescriptorProtos$FileDescriptorProto;->access$21(Lcom/google/protobuf/DescriptorProtos$FileDescriptorProto;)Ljava/util/List;

    move-result-object v2

    invoke-interface {v0, v2}, Ljava/util/List;->addAll(Ljava/util/Collection;)Z

    goto/16 :goto_2

    .line 1388
    :cond_e
    invoke-direct {p0}, Lcom/google/protobuf/DescriptorProtos$FileDescriptorProto$Builder;->ensureWeakDependencyIsMutable()V

    .line 1389
    iget-object v0, p0, Lcom/google/protobuf/DescriptorProtos$FileDescriptorProto$Builder;->weakDependency_:Ljava/util/List;

    invoke-static {p1}, Lcom/google/protobuf/DescriptorProtos$FileDescriptorProto;->access$22(Lcom/google/protobuf/DescriptorProtos$FileDescriptorProto;)Ljava/util/List;

    move-result-object v2

    invoke-interface {v0, v2}, Ljava/util/List;->addAll(Ljava/util/Collection;)Z

    goto/16 :goto_3

    .line 1399
    :cond_f
    invoke-direct {p0}, Lcom/google/protobuf/DescriptorProtos$FileDescriptorProto$Builder;->ensureMessageTypeIsMutable()V

    .line 1400
    iget-object v0, p0, Lcom/google/protobuf/DescriptorProtos$FileDescriptorProto$Builder;->messageType_:Ljava/util/List;

    invoke-static {p1}, Lcom/google/protobuf/DescriptorProtos$FileDescriptorProto;->access$23(Lcom/google/protobuf/DescriptorProtos$FileDescriptorProto;)Ljava/util/List;

    move-result-object v2

    invoke-interface {v0, v2}, Ljava/util/List;->addAll(Ljava/util/Collection;)Z

    goto/16 :goto_4

    .line 1405
    :cond_10
    invoke-static {p1}, Lcom/google/protobuf/DescriptorProtos$FileDescriptorProto;->access$23(Lcom/google/protobuf/DescriptorProtos$FileDescriptorProto;)Ljava/util/List;

    move-result-object v0

    invoke-interface {v0}, Ljava/util/List;->isEmpty()Z

    move-result v0

    if-nez v0, :cond_6

    .line 1406
    iget-object v0, p0, Lcom/google/protobuf/DescriptorProtos$FileDescriptorProto$Builder;->messageTypeBuilder_:Lcom/google/protobuf/RepeatedFieldBuilder;

    invoke-virtual {v0}, Lcom/google/protobuf/RepeatedFieldBuilder;->isEmpty()Z

    move-result v0

    if-eqz v0, :cond_12

    .line 1407
    iget-object v0, p0, Lcom/google/protobuf/DescriptorProtos$FileDescriptorProto$Builder;->messageTypeBuilder_:Lcom/google/protobuf/RepeatedFieldBuilder;

    invoke-virtual {v0}, Lcom/google/protobuf/RepeatedFieldBuilder;->dispose()V

    .line 1408
    iput-object v1, p0, Lcom/google/protobuf/DescriptorProtos$FileDescriptorProto$Builder;->messageTypeBuilder_:Lcom/google/protobuf/RepeatedFieldBuilder;

    .line 1409
    invoke-static {p1}, Lcom/google/protobuf/DescriptorProtos$FileDescriptorProto;->access$23(Lcom/google/protobuf/DescriptorProtos$FileDescriptorProto;)Ljava/util/List;

    move-result-object v0

    iput-object v0, p0, Lcom/google/protobuf/DescriptorProtos$FileDescriptorProto$Builder;->messageType_:Ljava/util/List;

    .line 1410
    iget v0, p0, Lcom/google/protobuf/DescriptorProtos$FileDescriptorProto$Builder;->bitField0_:I

    and-int/lit8 v0, v0, -0x21

    iput v0, p0, Lcom/google/protobuf/DescriptorProtos$FileDescriptorProto$Builder;->bitField0_:I

    .line 1412
    sget-boolean v0, Lcom/google/protobuf/GeneratedMessage;->alwaysUseFieldBuilders:Z

    if-eqz v0, :cond_11

    .line 1413
    invoke-direct {p0}, Lcom/google/protobuf/DescriptorProtos$FileDescriptorProto$Builder;->getMessageTypeFieldBuilder()Lcom/google/protobuf/RepeatedFieldBuilder;

    move-result-object v0

    .line 1411
    :goto_c
    iput-object v0, p0, Lcom/google/protobuf/DescriptorProtos$FileDescriptorProto$Builder;->messageTypeBuilder_:Lcom/google/protobuf/RepeatedFieldBuilder;

    goto/16 :goto_5

    :cond_11
    move-object v0, v1

    .line 1413
    goto :goto_c

    .line 1415
    :cond_12
    iget-object v0, p0, Lcom/google/protobuf/DescriptorProtos$FileDescriptorProto$Builder;->messageTypeBuilder_:Lcom/google/protobuf/RepeatedFieldBuilder;

    invoke-static {p1}, Lcom/google/protobuf/DescriptorProtos$FileDescriptorProto;->access$23(Lcom/google/protobuf/DescriptorProtos$FileDescriptorProto;)Ljava/util/List;

    move-result-object v2

    invoke-virtual {v0, v2}, Lcom/google/protobuf/RepeatedFieldBuilder;->addAllMessages(Ljava/lang/Iterable;)Lcom/google/protobuf/RepeatedFieldBuilder;

    goto/16 :goto_5

    .line 1425
    :cond_13
    invoke-direct {p0}, Lcom/google/protobuf/DescriptorProtos$FileDescriptorProto$Builder;->ensureEnumTypeIsMutable()V

    .line 1426
    iget-object v0, p0, Lcom/google/protobuf/DescriptorProtos$FileDescriptorProto$Builder;->enumType_:Ljava/util/List;

    invoke-static {p1}, Lcom/google/protobuf/DescriptorProtos$FileDescriptorProto;->access$24(Lcom/google/protobuf/DescriptorProtos$FileDescriptorProto;)Ljava/util/List;

    move-result-object v2

    invoke-interface {v0, v2}, Ljava/util/List;->addAll(Ljava/util/Collection;)Z

    goto/16 :goto_6

    .line 1431
    :cond_14
    invoke-static {p1}, Lcom/google/protobuf/DescriptorProtos$FileDescriptorProto;->access$24(Lcom/google/protobuf/DescriptorProtos$FileDescriptorProto;)Ljava/util/List;

    move-result-object v0

    invoke-interface {v0}, Ljava/util/List;->isEmpty()Z

    move-result v0

    if-nez v0, :cond_7

    .line 1432
    iget-object v0, p0, Lcom/google/protobuf/DescriptorProtos$FileDescriptorProto$Builder;->enumTypeBuilder_:Lcom/google/protobuf/RepeatedFieldBuilder;

    invoke-virtual {v0}, Lcom/google/protobuf/RepeatedFieldBuilder;->isEmpty()Z

    move-result v0

    if-eqz v0, :cond_16

    .line 1433
    iget-object v0, p0, Lcom/google/protobuf/DescriptorProtos$FileDescriptorProto$Builder;->enumTypeBuilder_:Lcom/google/protobuf/RepeatedFieldBuilder;

    invoke-virtual {v0}, Lcom/google/protobuf/RepeatedFieldBuilder;->dispose()V

    .line 1434
    iput-object v1, p0, Lcom/google/protobuf/DescriptorProtos$FileDescriptorProto$Builder;->enumTypeBuilder_:Lcom/google/protobuf/RepeatedFieldBuilder;

    .line 1435
    invoke-static {p1}, Lcom/google/protobuf/DescriptorProtos$FileDescriptorProto;->access$24(Lcom/google/protobuf/DescriptorProtos$FileDescriptorProto;)Ljava/util/List;

    move-result-object v0

    iput-object v0, p0, Lcom/google/protobuf/DescriptorProtos$FileDescriptorProto$Builder;->enumType_:Ljava/util/List;

    .line 1436
    iget v0, p0, Lcom/google/protobuf/DescriptorProtos$FileDescriptorProto$Builder;->bitField0_:I

    and-int/lit8 v0, v0, -0x41

    iput v0, p0, Lcom/google/protobuf/DescriptorProtos$FileDescriptorProto$Builder;->bitField0_:I

    .line 1438
    sget-boolean v0, Lcom/google/protobuf/GeneratedMessage;->alwaysUseFieldBuilders:Z

    if-eqz v0, :cond_15

    .line 1439
    invoke-direct {p0}, Lcom/google/protobuf/DescriptorProtos$FileDescriptorProto$Builder;->getEnumTypeFieldBuilder()Lcom/google/protobuf/RepeatedFieldBuilder;

    move-result-object v0

    .line 1437
    :goto_d
    iput-object v0, p0, Lcom/google/protobuf/DescriptorProtos$FileDescriptorProto$Builder;->enumTypeBuilder_:Lcom/google/protobuf/RepeatedFieldBuilder;

    goto/16 :goto_7

    :cond_15
    move-object v0, v1

    .line 1439
    goto :goto_d

    .line 1441
    :cond_16
    iget-object v0, p0, Lcom/google/protobuf/DescriptorProtos$FileDescriptorProto$Builder;->enumTypeBuilder_:Lcom/google/protobuf/RepeatedFieldBuilder;

    invoke-static {p1}, Lcom/google/protobuf/DescriptorProtos$FileDescriptorProto;->access$24(Lcom/google/protobuf/DescriptorProtos$FileDescriptorProto;)Ljava/util/List;

    move-result-object v2

    invoke-virtual {v0, v2}, Lcom/google/protobuf/RepeatedFieldBuilder;->addAllMessages(Ljava/lang/Iterable;)Lcom/google/protobuf/RepeatedFieldBuilder;

    goto/16 :goto_7

    .line 1451
    :cond_17
    invoke-direct {p0}, Lcom/google/protobuf/DescriptorProtos$FileDescriptorProto$Builder;->ensureServiceIsMutable()V

    .line 1452
    iget-object v0, p0, Lcom/google/protobuf/DescriptorProtos$FileDescriptorProto$Builder;->service_:Ljava/util/List;

    invoke-static {p1}, Lcom/google/protobuf/DescriptorProtos$FileDescriptorProto;->access$25(Lcom/google/protobuf/DescriptorProtos$FileDescriptorProto;)Ljava/util/List;

    move-result-object v2

    invoke-interface {v0, v2}, Ljava/util/List;->addAll(Ljava/util/Collection;)Z

    goto/16 :goto_8

    .line 1457
    :cond_18
    invoke-static {p1}, Lcom/google/protobuf/DescriptorProtos$FileDescriptorProto;->access$25(Lcom/google/protobuf/DescriptorProtos$FileDescriptorProto;)Ljava/util/List;

    move-result-object v0

    invoke-interface {v0}, Ljava/util/List;->isEmpty()Z

    move-result v0

    if-nez v0, :cond_8

    .line 1458
    iget-object v0, p0, Lcom/google/protobuf/DescriptorProtos$FileDescriptorProto$Builder;->serviceBuilder_:Lcom/google/protobuf/RepeatedFieldBuilder;

    invoke-virtual {v0}, Lcom/google/protobuf/RepeatedFieldBuilder;->isEmpty()Z

    move-result v0

    if-eqz v0, :cond_1a

    .line 1459
    iget-object v0, p0, Lcom/google/protobuf/DescriptorProtos$FileDescriptorProto$Builder;->serviceBuilder_:Lcom/google/protobuf/RepeatedFieldBuilder;

    invoke-virtual {v0}, Lcom/google/protobuf/RepeatedFieldBuilder;->dispose()V

    .line 1460
    iput-object v1, p0, Lcom/google/protobuf/DescriptorProtos$FileDescriptorProto$Builder;->serviceBuilder_:Lcom/google/protobuf/RepeatedFieldBuilder;

    .line 1461
    invoke-static {p1}, Lcom/google/protobuf/DescriptorProtos$FileDescriptorProto;->access$25(Lcom/google/protobuf/DescriptorProtos$FileDescriptorProto;)Ljava/util/List;

    move-result-object v0

    iput-object v0, p0, Lcom/google/protobuf/DescriptorProtos$FileDescriptorProto$Builder;->service_:Ljava/util/List;

    .line 1462
    iget v0, p0, Lcom/google/protobuf/DescriptorProtos$FileDescriptorProto$Builder;->bitField0_:I

    and-int/lit16 v0, v0, -0x81

    iput v0, p0, Lcom/google/protobuf/DescriptorProtos$FileDescriptorProto$Builder;->bitField0_:I

    .line 1464
    sget-boolean v0, Lcom/google/protobuf/GeneratedMessage;->alwaysUseFieldBuilders:Z

    if-eqz v0, :cond_19

    .line 1465
    invoke-direct {p0}, Lcom/google/protobuf/DescriptorProtos$FileDescriptorProto$Builder;->getServiceFieldBuilder()Lcom/google/protobuf/RepeatedFieldBuilder;

    move-result-object v0

    .line 1463
    :goto_e
    iput-object v0, p0, Lcom/google/protobuf/DescriptorProtos$FileDescriptorProto$Builder;->serviceBuilder_:Lcom/google/protobuf/RepeatedFieldBuilder;

    goto/16 :goto_9

    :cond_19
    move-object v0, v1

    .line 1465
    goto :goto_e

    .line 1467
    :cond_1a
    iget-object v0, p0, Lcom/google/protobuf/DescriptorProtos$FileDescriptorProto$Builder;->serviceBuilder_:Lcom/google/protobuf/RepeatedFieldBuilder;

    invoke-static {p1}, Lcom/google/protobuf/DescriptorProtos$FileDescriptorProto;->access$25(Lcom/google/protobuf/DescriptorProtos$FileDescriptorProto;)Ljava/util/List;

    move-result-object v2

    invoke-virtual {v0, v2}, Lcom/google/protobuf/RepeatedFieldBuilder;->addAllMessages(Ljava/lang/Iterable;)Lcom/google/protobuf/RepeatedFieldBuilder;

    goto/16 :goto_9

    .line 1477
    :cond_1b
    invoke-direct {p0}, Lcom/google/protobuf/DescriptorProtos$FileDescriptorProto$Builder;->ensureExtensionIsMutable()V

    .line 1478
    iget-object v0, p0, Lcom/google/protobuf/DescriptorProtos$FileDescriptorProto$Builder;->extension_:Ljava/util/List;

    invoke-static {p1}, Lcom/google/protobuf/DescriptorProtos$FileDescriptorProto;->access$26(Lcom/google/protobuf/DescriptorProtos$FileDescriptorProto;)Ljava/util/List;

    move-result-object v1

    invoke-interface {v0, v1}, Ljava/util/List;->addAll(Ljava/util/Collection;)Z

    goto/16 :goto_a

    .line 1483
    :cond_1c
    invoke-static {p1}, Lcom/google/protobuf/DescriptorProtos$FileDescriptorProto;->access$26(Lcom/google/protobuf/DescriptorProtos$FileDescriptorProto;)Ljava/util/List;

    move-result-object v0

    invoke-interface {v0}, Ljava/util/List;->isEmpty()Z

    move-result v0

    if-nez v0, :cond_9

    .line 1484
    iget-object v0, p0, Lcom/google/protobuf/DescriptorProtos$FileDescriptorProto$Builder;->extensionBuilder_:Lcom/google/protobuf/RepeatedFieldBuilder;

    invoke-virtual {v0}, Lcom/google/protobuf/RepeatedFieldBuilder;->isEmpty()Z

    move-result v0

    if-eqz v0, :cond_1e

    .line 1485
    iget-object v0, p0, Lcom/google/protobuf/DescriptorProtos$FileDescriptorProto$Builder;->extensionBuilder_:Lcom/google/protobuf/RepeatedFieldBuilder;

    invoke-virtual {v0}, Lcom/google/protobuf/RepeatedFieldBuilder;->dispose()V

    .line 1486
    iput-object v1, p0, Lcom/google/protobuf/DescriptorProtos$FileDescriptorProto$Builder;->extensionBuilder_:Lcom/google/protobuf/RepeatedFieldBuilder;

    .line 1487
    invoke-static {p1}, Lcom/google/protobuf/DescriptorProtos$FileDescriptorProto;->access$26(Lcom/google/protobuf/DescriptorProtos$FileDescriptorProto;)Ljava/util/List;

    move-result-object v0

    iput-object v0, p0, Lcom/google/protobuf/DescriptorProtos$FileDescriptorProto$Builder;->extension_:Ljava/util/List;

    .line 1488
    iget v0, p0, Lcom/google/protobuf/DescriptorProtos$FileDescriptorProto$Builder;->bitField0_:I

    and-int/lit16 v0, v0, -0x101

    iput v0, p0, Lcom/google/protobuf/DescriptorProtos$FileDescriptorProto$Builder;->bitField0_:I

    .line 1490
    sget-boolean v0, Lcom/google/protobuf/GeneratedMessage;->alwaysUseFieldBuilders:Z

    if-eqz v0, :cond_1d

    .line 1491
    invoke-direct {p0}, Lcom/google/protobuf/DescriptorProtos$FileDescriptorProto$Builder;->getExtensionFieldBuilder()Lcom/google/protobuf/RepeatedFieldBuilder;

    move-result-object v1

    .line 1489
    :cond_1d
    iput-object v1, p0, Lcom/google/protobuf/DescriptorProtos$FileDescriptorProto$Builder;->extensionBuilder_:Lcom/google/protobuf/RepeatedFieldBuilder;

    goto/16 :goto_b

    .line 1493
    :cond_1e
    iget-object v0, p0, Lcom/google/protobuf/DescriptorProtos$FileDescriptorProto$Builder;->extensionBuilder_:Lcom/google/protobuf/RepeatedFieldBuilder;

    invoke-static {p1}, Lcom/google/protobuf/DescriptorProtos$FileDescriptorProto;->access$26(Lcom/google/protobuf/DescriptorProtos$FileDescriptorProto;)Ljava/util/List;

    move-result-object v1

    invoke-virtual {v0, v1}, Lcom/google/protobuf/RepeatedFieldBuilder;->addAllMessages(Ljava/lang/Iterable;)Lcom/google/protobuf/RepeatedFieldBuilder;

    goto/16 :goto_b
.end method

.method public mergeFrom(Lcom/google/protobuf/Message;)Lcom/google/protobuf/DescriptorProtos$FileDescriptorProto$Builder;
    .locals 1

    .prologue
    .line 1347
    instance-of v0, p1, Lcom/google/protobuf/DescriptorProtos$FileDescriptorProto;

    if-eqz v0, :cond_0

    .line 1348
    check-cast p1, Lcom/google/protobuf/DescriptorProtos$FileDescriptorProto;

    invoke-virtual {p0, p1}, Lcom/google/protobuf/DescriptorProtos$FileDescriptorProto$Builder;->mergeFrom(Lcom/google/protobuf/DescriptorProtos$FileDescriptorProto;)Lcom/google/protobuf/DescriptorProtos$FileDescriptorProto$Builder;

    move-result-object p0

    .line 1351
    :goto_0
    return-object p0

    .line 1350
    :cond_0
    invoke-super {p0, p1}, Lcom/google/protobuf/GeneratedMessage$Builder;->mergeFrom(Lcom/google/protobuf/Message;)Lcom/google/protobuf/AbstractMessage$Builder;

    goto :goto_0
.end method

.method public bridge synthetic mergeFrom(Lcom/google/protobuf/CodedInputStream;Lcom/google/protobuf/ExtensionRegistryLite;)Lcom/google/protobuf/Message$Builder;
    .locals 1
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljava/io/IOException;
        }
    .end annotation

    .prologue
    .line 1
    invoke-virtual {p0, p1, p2}, Lcom/google/protobuf/DescriptorProtos$FileDescriptorProto$Builder;->mergeFrom(Lcom/google/protobuf/CodedInputStream;Lcom/google/protobuf/ExtensionRegistryLite;)Lcom/google/protobuf/DescriptorProtos$FileDescriptorProto$Builder;

    move-result-object v0

    return-object v0
.end method

.method public bridge synthetic mergeFrom(Lcom/google/protobuf/Message;)Lcom/google/protobuf/Message$Builder;
    .locals 1

    .prologue
    .line 1
    invoke-virtual {p0, p1}, Lcom/google/protobuf/DescriptorProtos$FileDescriptorProto$Builder;->mergeFrom(Lcom/google/protobuf/Message;)Lcom/google/protobuf/DescriptorProtos$FileDescriptorProto$Builder;

    move-result-object v0

    return-object v0
.end method

.method public bridge synthetic mergeFrom(Lcom/google/protobuf/CodedInputStream;Lcom/google/protobuf/ExtensionRegistryLite;)Lcom/google/protobuf/MessageLite$Builder;
    .locals 1
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljava/io/IOException;
        }
    .end annotation

    .prologue
    .line 1
    invoke-virtual {p0, p1, p2}, Lcom/google/protobuf/DescriptorProtos$FileDescriptorProto$Builder;->mergeFrom(Lcom/google/protobuf/CodedInputStream;Lcom/google/protobuf/ExtensionRegistryLite;)Lcom/google/protobuf/DescriptorProtos$FileDescriptorProto$Builder;

    move-result-object v0

    return-object v0
.end method

.method public mergeOptions(Lcom/google/protobuf/DescriptorProtos$FileOptions;)Lcom/google/protobuf/DescriptorProtos$FileDescriptorProto$Builder;
    .locals 2

    .prologue
    .line 2656
    iget-object v0, p0, Lcom/google/protobuf/DescriptorProtos$FileDescriptorProto$Builder;->optionsBuilder_:Lcom/google/protobuf/SingleFieldBuilder;

    if-nez v0, :cond_1

    .line 2657
    iget v0, p0, Lcom/google/protobuf/DescriptorProtos$FileDescriptorProto$Builder;->bitField0_:I

    and-int/lit16 v0, v0, 0x200

    const/16 v1, 0x200

    if-ne v0, v1, :cond_0

    .line 2658
    iget-object v0, p0, Lcom/google/protobuf/DescriptorProtos$FileDescriptorProto$Builder;->options_:Lcom/google/protobuf/DescriptorProtos$FileOptions;

    invoke-static {}, Lcom/google/protobuf/DescriptorProtos$FileOptions;->getDefaultInstance()Lcom/google/protobuf/DescriptorProtos$FileOptions;

    move-result-object v1

    if-eq v0, v1, :cond_0

    .line 2660
    iget-object v0, p0, Lcom/google/protobuf/DescriptorProtos$FileDescriptorProto$Builder;->options_:Lcom/google/protobuf/DescriptorProtos$FileOptions;

    invoke-static {v0}, Lcom/google/protobuf/DescriptorProtos$FileOptions;->newBuilder(Lcom/google/protobuf/DescriptorProtos$FileOptions;)Lcom/google/protobuf/DescriptorProtos$FileOptions$Builder;

    move-result-object v0

    invoke-virtual {v0, p1}, Lcom/google/protobuf/DescriptorProtos$FileOptions$Builder;->mergeFrom(Lcom/google/protobuf/DescriptorProtos$FileOptions;)Lcom/google/protobuf/DescriptorProtos$FileOptions$Builder;

    move-result-object v0

    invoke-virtual {v0}, Lcom/google/protobuf/DescriptorProtos$FileOptions$Builder;->buildPartial()Lcom/google/protobuf/DescriptorProtos$FileOptions;

    move-result-object v0

    .line 2659
    iput-object v0, p0, Lcom/google/protobuf/DescriptorProtos$FileDescriptorProto$Builder;->options_:Lcom/google/protobuf/DescriptorProtos$FileOptions;

    .line 2664
    :goto_0
    invoke-virtual {p0}, Lcom/google/protobuf/DescriptorProtos$FileDescriptorProto$Builder;->onChanged()V

    .line 2668
    :goto_1
    iget v0, p0, Lcom/google/protobuf/DescriptorProtos$FileDescriptorProto$Builder;->bitField0_:I

    or-int/lit16 v0, v0, 0x200

    iput v0, p0, Lcom/google/protobuf/DescriptorProtos$FileDescriptorProto$Builder;->bitField0_:I

    .line 2669
    return-object p0

    .line 2662
    :cond_0
    iput-object p1, p0, Lcom/google/protobuf/DescriptorProtos$FileDescriptorProto$Builder;->options_:Lcom/google/protobuf/DescriptorProtos$FileOptions;

    goto :goto_0

    .line 2666
    :cond_1
    iget-object v0, p0, Lcom/google/protobuf/DescriptorProtos$FileDescriptorProto$Builder;->optionsBuilder_:Lcom/google/protobuf/SingleFieldBuilder;

    invoke-virtual {v0, p1}, Lcom/google/protobuf/SingleFieldBuilder;->mergeFrom(Lcom/google/protobuf/GeneratedMessage;)Lcom/google/protobuf/SingleFieldBuilder;

    goto :goto_1
.end method

.method public mergeSourceCodeInfo(Lcom/google/protobuf/DescriptorProtos$SourceCodeInfo;)Lcom/google/protobuf/DescriptorProtos$FileDescriptorProto$Builder;
    .locals 2

    .prologue
    .line 2746
    iget-object v0, p0, Lcom/google/protobuf/DescriptorProtos$FileDescriptorProto$Builder;->sourceCodeInfoBuilder_:Lcom/google/protobuf/SingleFieldBuilder;

    if-nez v0, :cond_1

    .line 2747
    iget v0, p0, Lcom/google/protobuf/DescriptorProtos$FileDescriptorProto$Builder;->bitField0_:I

    and-int/lit16 v0, v0, 0x400

    const/16 v1, 0x400

    if-ne v0, v1, :cond_0

    .line 2748
    iget-object v0, p0, Lcom/google/protobuf/DescriptorProtos$FileDescriptorProto$Builder;->sourceCodeInfo_:Lcom/google/protobuf/DescriptorProtos$SourceCodeInfo;

    invoke-static {}, Lcom/google/protobuf/DescriptorProtos$SourceCodeInfo;->getDefaultInstance()Lcom/google/protobuf/DescriptorProtos$SourceCodeInfo;

    move-result-object v1

    if-eq v0, v1, :cond_0

    .line 2750
    iget-object v0, p0, Lcom/google/protobuf/DescriptorProtos$FileDescriptorProto$Builder;->sourceCodeInfo_:Lcom/google/protobuf/DescriptorProtos$SourceCodeInfo;

    invoke-static {v0}, Lcom/google/protobuf/DescriptorProtos$SourceCodeInfo;->newBuilder(Lcom/google/protobuf/DescriptorProtos$SourceCodeInfo;)Lcom/google/protobuf/DescriptorProtos$SourceCodeInfo$Builder;

    move-result-object v0

    invoke-virtual {v0, p1}, Lcom/google/protobuf/DescriptorProtos$SourceCodeInfo$Builder;->mergeFrom(Lcom/google/protobuf/DescriptorProtos$SourceCodeInfo;)Lcom/google/protobuf/DescriptorProtos$SourceCodeInfo$Builder;

    move-result-object v0

    invoke-virtual {v0}, Lcom/google/protobuf/DescriptorProtos$SourceCodeInfo$Builder;->buildPartial()Lcom/google/protobuf/DescriptorProtos$SourceCodeInfo;

    move-result-object v0

    .line 2749
    iput-object v0, p0, Lcom/google/protobuf/DescriptorProtos$FileDescriptorProto$Builder;->sourceCodeInfo_:Lcom/google/protobuf/DescriptorProtos$SourceCodeInfo;

    .line 2754
    :goto_0
    invoke-virtual {p0}, Lcom/google/protobuf/DescriptorProtos$FileDescriptorProto$Builder;->onChanged()V

    .line 2758
    :goto_1
    iget v0, p0, Lcom/google/protobuf/DescriptorProtos$FileDescriptorProto$Builder;->bitField0_:I

    or-int/lit16 v0, v0, 0x400

    iput v0, p0, Lcom/google/protobuf/DescriptorProtos$FileDescriptorProto$Builder;->bitField0_:I

    .line 2759
    return-object p0

    .line 2752
    :cond_0
    iput-object p1, p0, Lcom/google/protobuf/DescriptorProtos$FileDescriptorProto$Builder;->sourceCodeInfo_:Lcom/google/protobuf/DescriptorProtos$SourceCodeInfo;

    goto :goto_0

    .line 2756
    :cond_1
    iget-object v0, p0, Lcom/google/protobuf/DescriptorProtos$FileDescriptorProto$Builder;->sourceCodeInfoBuilder_:Lcom/google/protobuf/SingleFieldBuilder;

    invoke-virtual {v0, p1}, Lcom/google/protobuf/SingleFieldBuilder;->mergeFrom(Lcom/google/protobuf/GeneratedMessage;)Lcom/google/protobuf/SingleFieldBuilder;

    goto :goto_1
.end method

.method public removeEnumType(I)Lcom/google/protobuf/DescriptorProtos$FileDescriptorProto$Builder;
    .locals 1

    .prologue
    .line 2189
    iget-object v0, p0, Lcom/google/protobuf/DescriptorProtos$FileDescriptorProto$Builder;->enumTypeBuilder_:Lcom/google/protobuf/RepeatedFieldBuilder;

    if-nez v0, :cond_0

    .line 2190
    invoke-direct {p0}, Lcom/google/protobuf/DescriptorProtos$FileDescriptorProto$Builder;->ensureEnumTypeIsMutable()V

    .line 2191
    iget-object v0, p0, Lcom/google/protobuf/DescriptorProtos$FileDescriptorProto$Builder;->enumType_:Ljava/util/List;

    invoke-interface {v0, p1}, Ljava/util/List;->remove(I)Ljava/lang/Object;

    .line 2192
    invoke-virtual {p0}, Lcom/google/protobuf/DescriptorProtos$FileDescriptorProto$Builder;->onChanged()V

    .line 2196
    :goto_0
    return-object p0

    .line 2194
    :cond_0
    iget-object v0, p0, Lcom/google/protobuf/DescriptorProtos$FileDescriptorProto$Builder;->enumTypeBuilder_:Lcom/google/protobuf/RepeatedFieldBuilder;

    invoke-virtual {v0, p1}, Lcom/google/protobuf/RepeatedFieldBuilder;->remove(I)V

    goto :goto_0
.end method

.method public removeExtension(I)Lcom/google/protobuf/DescriptorProtos$FileDescriptorProto$Builder;
    .locals 1

    .prologue
    .line 2561
    iget-object v0, p0, Lcom/google/protobuf/DescriptorProtos$FileDescriptorProto$Builder;->extensionBuilder_:Lcom/google/protobuf/RepeatedFieldBuilder;

    if-nez v0, :cond_0

    .line 2562
    invoke-direct {p0}, Lcom/google/protobuf/DescriptorProtos$FileDescriptorProto$Builder;->ensureExtensionIsMutable()V

    .line 2563
    iget-object v0, p0, Lcom/google/protobuf/DescriptorProtos$FileDescriptorProto$Builder;->extension_:Ljava/util/List;

    invoke-interface {v0, p1}, Ljava/util/List;->remove(I)Ljava/lang/Object;

    .line 2564
    invoke-virtual {p0}, Lcom/google/protobuf/DescriptorProtos$FileDescriptorProto$Builder;->onChanged()V

    .line 2568
    :goto_0
    return-object p0

    .line 2566
    :cond_0
    iget-object v0, p0, Lcom/google/protobuf/DescriptorProtos$FileDescriptorProto$Builder;->extensionBuilder_:Lcom/google/protobuf/RepeatedFieldBuilder;

    invoke-virtual {v0, p1}, Lcom/google/protobuf/RepeatedFieldBuilder;->remove(I)V

    goto :goto_0
.end method

.method public removeMessageType(I)Lcom/google/protobuf/DescriptorProtos$FileDescriptorProto$Builder;
    .locals 1

    .prologue
    .line 2003
    iget-object v0, p0, Lcom/google/protobuf/DescriptorProtos$FileDescriptorProto$Builder;->messageTypeBuilder_:Lcom/google/protobuf/RepeatedFieldBuilder;

    if-nez v0, :cond_0

    .line 2004
    invoke-direct {p0}, Lcom/google/protobuf/DescriptorProtos$FileDescriptorProto$Builder;->ensureMessageTypeIsMutable()V

    .line 2005
    iget-object v0, p0, Lcom/google/protobuf/DescriptorProtos$FileDescriptorProto$Builder;->messageType_:Ljava/util/List;

    invoke-interface {v0, p1}, Ljava/util/List;->remove(I)Ljava/lang/Object;

    .line 2006
    invoke-virtual {p0}, Lcom/google/protobuf/DescriptorProtos$FileDescriptorProto$Builder;->onChanged()V

    .line 2010
    :goto_0
    return-object p0

    .line 2008
    :cond_0
    iget-object v0, p0, Lcom/google/protobuf/DescriptorProtos$FileDescriptorProto$Builder;->messageTypeBuilder_:Lcom/google/protobuf/RepeatedFieldBuilder;

    invoke-virtual {v0, p1}, Lcom/google/protobuf/RepeatedFieldBuilder;->remove(I)V

    goto :goto_0
.end method

.method public removeService(I)Lcom/google/protobuf/DescriptorProtos$FileDescriptorProto$Builder;
    .locals 1

    .prologue
    .line 2375
    iget-object v0, p0, Lcom/google/protobuf/DescriptorProtos$FileDescriptorProto$Builder;->serviceBuilder_:Lcom/google/protobuf/RepeatedFieldBuilder;

    if-nez v0, :cond_0

    .line 2376
    invoke-direct {p0}, Lcom/google/protobuf/DescriptorProtos$FileDescriptorProto$Builder;->ensureServiceIsMutable()V

    .line 2377
    iget-object v0, p0, Lcom/google/protobuf/DescriptorProtos$FileDescriptorProto$Builder;->service_:Ljava/util/List;

    invoke-interface {v0, p1}, Ljava/util/List;->remove(I)Ljava/lang/Object;

    .line 2378
    invoke-virtual {p0}, Lcom/google/protobuf/DescriptorProtos$FileDescriptorProto$Builder;->onChanged()V

    .line 2382
    :goto_0
    return-object p0

    .line 2380
    :cond_0
    iget-object v0, p0, Lcom/google/protobuf/DescriptorProtos$FileDescriptorProto$Builder;->serviceBuilder_:Lcom/google/protobuf/RepeatedFieldBuilder;

    invoke-virtual {v0, p1}, Lcom/google/protobuf/RepeatedFieldBuilder;->remove(I)V

    goto :goto_0
.end method

.method public setDependency(ILjava/lang/String;)Lcom/google/protobuf/DescriptorProtos$FileDescriptorProto$Builder;
    .locals 1

    .prologue
    .line 1747
    if-nez p2, :cond_0

    .line 1748
    new-instance v0, Ljava/lang/NullPointerException;

    invoke-direct {v0}, Ljava/lang/NullPointerException;-><init>()V

    throw v0

    .line 1750
    :cond_0
    invoke-direct {p0}, Lcom/google/protobuf/DescriptorProtos$FileDescriptorProto$Builder;->ensureDependencyIsMutable()V

    .line 1751
    iget-object v0, p0, Lcom/google/protobuf/DescriptorProtos$FileDescriptorProto$Builder;->dependency_:Lcom/google/protobuf/LazyStringList;

    invoke-interface {v0, p1, p2}, Lcom/google/protobuf/LazyStringList;->set(ILjava/lang/Object;)Ljava/lang/Object;

    .line 1752
    invoke-virtual {p0}, Lcom/google/protobuf/DescriptorProtos$FileDescriptorProto$Builder;->onChanged()V

    .line 1753
    return-object p0
.end method

.method public setEnumType(ILcom/google/protobuf/DescriptorProtos$EnumDescriptorProto$Builder;)Lcom/google/protobuf/DescriptorProtos$FileDescriptorProto$Builder;
    .locals 2

    .prologue
    .line 2109
    iget-object v0, p0, Lcom/google/protobuf/DescriptorProtos$FileDescriptorProto$Builder;->enumTypeBuilder_:Lcom/google/protobuf/RepeatedFieldBuilder;

    if-nez v0, :cond_0

    .line 2110
    invoke-direct {p0}, Lcom/google/protobuf/DescriptorProtos$FileDescriptorProto$Builder;->ensureEnumTypeIsMutable()V

    .line 2111
    iget-object v0, p0, Lcom/google/protobuf/DescriptorProtos$FileDescriptorProto$Builder;->enumType_:Ljava/util/List;

    invoke-virtual {p2}, Lcom/google/protobuf/DescriptorProtos$EnumDescriptorProto$Builder;->build()Lcom/google/protobuf/DescriptorProtos$EnumDescriptorProto;

    move-result-object v1

    invoke-interface {v0, p1, v1}, Ljava/util/List;->set(ILjava/lang/Object;)Ljava/lang/Object;

    .line 2112
    invoke-virtual {p0}, Lcom/google/protobuf/DescriptorProtos$FileDescriptorProto$Builder;->onChanged()V

    .line 2116
    :goto_0
    return-object p0

    .line 2114
    :cond_0
    iget-object v0, p0, Lcom/google/protobuf/DescriptorProtos$FileDescriptorProto$Builder;->enumTypeBuilder_:Lcom/google/protobuf/RepeatedFieldBuilder;

    invoke-virtual {p2}, Lcom/google/protobuf/DescriptorProtos$EnumDescriptorProto$Builder;->build()Lcom/google/protobuf/DescriptorProtos$EnumDescriptorProto;

    move-result-object v1

    invoke-virtual {v0, p1, v1}, Lcom/google/protobuf/RepeatedFieldBuilder;->setMessage(ILcom/google/protobuf/GeneratedMessage;)Lcom/google/protobuf/RepeatedFieldBuilder;

    goto :goto_0
.end method

.method public setEnumType(ILcom/google/protobuf/DescriptorProtos$EnumDescriptorProto;)Lcom/google/protobuf/DescriptorProtos$FileDescriptorProto$Builder;
    .locals 1

    .prologue
    .line 2095
    iget-object v0, p0, Lcom/google/protobuf/DescriptorProtos$FileDescriptorProto$Builder;->enumTypeBuilder_:Lcom/google/protobuf/RepeatedFieldBuilder;

    if-nez v0, :cond_1

    .line 2096
    if-nez p2, :cond_0

    .line 2097
    new-instance v0, Ljava/lang/NullPointerException;

    invoke-direct {v0}, Ljava/lang/NullPointerException;-><init>()V

    throw v0

    .line 2099
    :cond_0
    invoke-direct {p0}, Lcom/google/protobuf/DescriptorProtos$FileDescriptorProto$Builder;->ensureEnumTypeIsMutable()V

    .line 2100
    iget-object v0, p0, Lcom/google/protobuf/DescriptorProtos$FileDescriptorProto$Builder;->enumType_:Ljava/util/List;

    invoke-interface {v0, p1, p2}, Ljava/util/List;->set(ILjava/lang/Object;)Ljava/lang/Object;

    .line 2101
    invoke-virtual {p0}, Lcom/google/protobuf/DescriptorProtos$FileDescriptorProto$Builder;->onChanged()V

    .line 2105
    :goto_0
    return-object p0

    .line 2103
    :cond_1
    iget-object v0, p0, Lcom/google/protobuf/DescriptorProtos$FileDescriptorProto$Builder;->enumTypeBuilder_:Lcom/google/protobuf/RepeatedFieldBuilder;

    invoke-virtual {v0, p1, p2}, Lcom/google/protobuf/RepeatedFieldBuilder;->setMessage(ILcom/google/protobuf/GeneratedMessage;)Lcom/google/protobuf/RepeatedFieldBuilder;

    goto :goto_0
.end method

.method public setExtension(ILcom/google/protobuf/DescriptorProtos$FieldDescriptorProto$Builder;)Lcom/google/protobuf/DescriptorProtos$FileDescriptorProto$Builder;
    .locals 2

    .prologue
    .line 2481
    iget-object v0, p0, Lcom/google/protobuf/DescriptorProtos$FileDescriptorProto$Builder;->extensionBuilder_:Lcom/google/protobuf/RepeatedFieldBuilder;

    if-nez v0, :cond_0

    .line 2482
    invoke-direct {p0}, Lcom/google/protobuf/DescriptorProtos$FileDescriptorProto$Builder;->ensureExtensionIsMutable()V

    .line 2483
    iget-object v0, p0, Lcom/google/protobuf/DescriptorProtos$FileDescriptorProto$Builder;->extension_:Ljava/util/List;

    invoke-virtual {p2}, Lcom/google/protobuf/DescriptorProtos$FieldDescriptorProto$Builder;->build()Lcom/google/protobuf/DescriptorProtos$FieldDescriptorProto;

    move-result-object v1

    invoke-interface {v0, p1, v1}, Ljava/util/List;->set(ILjava/lang/Object;)Ljava/lang/Object;

    .line 2484
    invoke-virtual {p0}, Lcom/google/protobuf/DescriptorProtos$FileDescriptorProto$Builder;->onChanged()V

    .line 2488
    :goto_0
    return-object p0

    .line 2486
    :cond_0
    iget-object v0, p0, Lcom/google/protobuf/DescriptorProtos$FileDescriptorProto$Builder;->extensionBuilder_:Lcom/google/protobuf/RepeatedFieldBuilder;

    invoke-virtual {p2}, Lcom/google/protobuf/DescriptorProtos$FieldDescriptorProto$Builder;->build()Lcom/google/protobuf/DescriptorProtos$FieldDescriptorProto;

    move-result-object v1

    invoke-virtual {v0, p1, v1}, Lcom/google/protobuf/RepeatedFieldBuilder;->setMessage(ILcom/google/protobuf/GeneratedMessage;)Lcom/google/protobuf/RepeatedFieldBuilder;

    goto :goto_0
.end method

.method public setExtension(ILcom/google/protobuf/DescriptorProtos$FieldDescriptorProto;)Lcom/google/protobuf/DescriptorProtos$FileDescriptorProto$Builder;
    .locals 1

    .prologue
    .line 2467
    iget-object v0, p0, Lcom/google/protobuf/DescriptorProtos$FileDescriptorProto$Builder;->extensionBuilder_:Lcom/google/protobuf/RepeatedFieldBuilder;

    if-nez v0, :cond_1

    .line 2468
    if-nez p2, :cond_0

    .line 2469
    new-instance v0, Ljava/lang/NullPointerException;

    invoke-direct {v0}, Ljava/lang/NullPointerException;-><init>()V

    throw v0

    .line 2471
    :cond_0
    invoke-direct {p0}, Lcom/google/protobuf/DescriptorProtos$FileDescriptorProto$Builder;->ensureExtensionIsMutable()V

    .line 2472
    iget-object v0, p0, Lcom/google/protobuf/DescriptorProtos$FileDescriptorProto$Builder;->extension_:Ljava/util/List;

    invoke-interface {v0, p1, p2}, Ljava/util/List;->set(ILjava/lang/Object;)Ljava/lang/Object;

    .line 2473
    invoke-virtual {p0}, Lcom/google/protobuf/DescriptorProtos$FileDescriptorProto$Builder;->onChanged()V

    .line 2477
    :goto_0
    return-object p0

    .line 2475
    :cond_1
    iget-object v0, p0, Lcom/google/protobuf/DescriptorProtos$FileDescriptorProto$Builder;->extensionBuilder_:Lcom/google/protobuf/RepeatedFieldBuilder;

    invoke-virtual {v0, p1, p2}, Lcom/google/protobuf/RepeatedFieldBuilder;->setMessage(ILcom/google/protobuf/GeneratedMessage;)Lcom/google/protobuf/RepeatedFieldBuilder;

    goto :goto_0
.end method

.method public setMessageType(ILcom/google/protobuf/DescriptorProtos$DescriptorProto$Builder;)Lcom/google/protobuf/DescriptorProtos$FileDescriptorProto$Builder;
    .locals 2

    .prologue
    .line 1923
    iget-object v0, p0, Lcom/google/protobuf/DescriptorProtos$FileDescriptorProto$Builder;->messageTypeBuilder_:Lcom/google/protobuf/RepeatedFieldBuilder;

    if-nez v0, :cond_0

    .line 1924
    invoke-direct {p0}, Lcom/google/protobuf/DescriptorProtos$FileDescriptorProto$Builder;->ensureMessageTypeIsMutable()V

    .line 1925
    iget-object v0, p0, Lcom/google/protobuf/DescriptorProtos$FileDescriptorProto$Builder;->messageType_:Ljava/util/List;

    invoke-virtual {p2}, Lcom/google/protobuf/DescriptorProtos$DescriptorProto$Builder;->build()Lcom/google/protobuf/DescriptorProtos$DescriptorProto;

    move-result-object v1

    invoke-interface {v0, p1, v1}, Ljava/util/List;->set(ILjava/lang/Object;)Ljava/lang/Object;

    .line 1926
    invoke-virtual {p0}, Lcom/google/protobuf/DescriptorProtos$FileDescriptorProto$Builder;->onChanged()V

    .line 1930
    :goto_0
    return-object p0

    .line 1928
    :cond_0
    iget-object v0, p0, Lcom/google/protobuf/DescriptorProtos$FileDescriptorProto$Builder;->messageTypeBuilder_:Lcom/google/protobuf/RepeatedFieldBuilder;

    invoke-virtual {p2}, Lcom/google/protobuf/DescriptorProtos$DescriptorProto$Builder;->build()Lcom/google/protobuf/DescriptorProtos$DescriptorProto;

    move-result-object v1

    invoke-virtual {v0, p1, v1}, Lcom/google/protobuf/RepeatedFieldBuilder;->setMessage(ILcom/google/protobuf/GeneratedMessage;)Lcom/google/protobuf/RepeatedFieldBuilder;

    goto :goto_0
.end method

.method public setMessageType(ILcom/google/protobuf/DescriptorProtos$DescriptorProto;)Lcom/google/protobuf/DescriptorProtos$FileDescriptorProto$Builder;
    .locals 1

    .prologue
    .line 1909
    iget-object v0, p0, Lcom/google/protobuf/DescriptorProtos$FileDescriptorProto$Builder;->messageTypeBuilder_:Lcom/google/protobuf/RepeatedFieldBuilder;

    if-nez v0, :cond_1

    .line 1910
    if-nez p2, :cond_0

    .line 1911
    new-instance v0, Ljava/lang/NullPointerException;

    invoke-direct {v0}, Ljava/lang/NullPointerException;-><init>()V

    throw v0

    .line 1913
    :cond_0
    invoke-direct {p0}, Lcom/google/protobuf/DescriptorProtos$FileDescriptorProto$Builder;->ensureMessageTypeIsMutable()V

    .line 1914
    iget-object v0, p0, Lcom/google/protobuf/DescriptorProtos$FileDescriptorProto$Builder;->messageType_:Ljava/util/List;

    invoke-interface {v0, p1, p2}, Ljava/util/List;->set(ILjava/lang/Object;)Ljava/lang/Object;

    .line 1915
    invoke-virtual {p0}, Lcom/google/protobuf/DescriptorProtos$FileDescriptorProto$Builder;->onChanged()V

    .line 1919
    :goto_0
    return-object p0

    .line 1917
    :cond_1
    iget-object v0, p0, Lcom/google/protobuf/DescriptorProtos$FileDescriptorProto$Builder;->messageTypeBuilder_:Lcom/google/protobuf/RepeatedFieldBuilder;

    invoke-virtual {v0, p1, p2}, Lcom/google/protobuf/RepeatedFieldBuilder;->setMessage(ILcom/google/protobuf/GeneratedMessage;)Lcom/google/protobuf/RepeatedFieldBuilder;

    goto :goto_0
.end method

.method public setName(Ljava/lang/String;)Lcom/google/protobuf/DescriptorProtos$FileDescriptorProto$Builder;
    .locals 1

    .prologue
    .line 1671
    if-nez p1, :cond_0

    .line 1672
    new-instance v0, Ljava/lang/NullPointerException;

    invoke-direct {v0}, Ljava/lang/NullPointerException;-><init>()V

    throw v0

    .line 1674
    :cond_0
    iget v0, p0, Lcom/google/protobuf/DescriptorProtos$FileDescriptorProto$Builder;->bitField0_:I

    or-int/lit8 v0, v0, 0x1

    iput v0, p0, Lcom/google/protobuf/DescriptorProtos$FileDescriptorProto$Builder;->bitField0_:I

    .line 1675
    iput-object p1, p0, Lcom/google/protobuf/DescriptorProtos$FileDescriptorProto$Builder;->name_:Ljava/lang/Object;

    .line 1676
    invoke-virtual {p0}, Lcom/google/protobuf/DescriptorProtos$FileDescriptorProto$Builder;->onChanged()V

    .line 1677
    return-object p0
.end method

.method setName(Lcom/google/protobuf/ByteString;)V
    .locals 1

    .prologue
    .line 1686
    iget v0, p0, Lcom/google/protobuf/DescriptorProtos$FileDescriptorProto$Builder;->bitField0_:I

    or-int/lit8 v0, v0, 0x1

    iput v0, p0, Lcom/google/protobuf/DescriptorProtos$FileDescriptorProto$Builder;->bitField0_:I

    .line 1687
    iput-object p1, p0, Lcom/google/protobuf/DescriptorProtos$FileDescriptorProto$Builder;->name_:Ljava/lang/Object;

    .line 1688
    invoke-virtual {p0}, Lcom/google/protobuf/DescriptorProtos$FileDescriptorProto$Builder;->onChanged()V

    .line 1689
    return-void
.end method

.method public setOptions(Lcom/google/protobuf/DescriptorProtos$FileOptions$Builder;)Lcom/google/protobuf/DescriptorProtos$FileDescriptorProto$Builder;
    .locals 2

    .prologue
    .line 2646
    iget-object v0, p0, Lcom/google/protobuf/DescriptorProtos$FileDescriptorProto$Builder;->optionsBuilder_:Lcom/google/protobuf/SingleFieldBuilder;

    if-nez v0, :cond_0

    .line 2647
    invoke-virtual {p1}, Lcom/google/protobuf/DescriptorProtos$FileOptions$Builder;->build()Lcom/google/protobuf/DescriptorProtos$FileOptions;

    move-result-object v0

    iput-object v0, p0, Lcom/google/protobuf/DescriptorProtos$FileDescriptorProto$Builder;->options_:Lcom/google/protobuf/DescriptorProtos$FileOptions;

    .line 2648
    invoke-virtual {p0}, Lcom/google/protobuf/DescriptorProtos$FileDescriptorProto$Builder;->onChanged()V

    .line 2652
    :goto_0
    iget v0, p0, Lcom/google/protobuf/DescriptorProtos$FileDescriptorProto$Builder;->bitField0_:I

    or-int/lit16 v0, v0, 0x200

    iput v0, p0, Lcom/google/protobuf/DescriptorProtos$FileDescriptorProto$Builder;->bitField0_:I

    .line 2653
    return-object p0

    .line 2650
    :cond_0
    iget-object v0, p0, Lcom/google/protobuf/DescriptorProtos$FileDescriptorProto$Builder;->optionsBuilder_:Lcom/google/protobuf/SingleFieldBuilder;

    invoke-virtual {p1}, Lcom/google/protobuf/DescriptorProtos$FileOptions$Builder;->build()Lcom/google/protobuf/DescriptorProtos$FileOptions;

    move-result-object v1

    invoke-virtual {v0, v1}, Lcom/google/protobuf/SingleFieldBuilder;->setMessage(Lcom/google/protobuf/GeneratedMessage;)Lcom/google/protobuf/SingleFieldBuilder;

    goto :goto_0
.end method

.method public setOptions(Lcom/google/protobuf/DescriptorProtos$FileOptions;)Lcom/google/protobuf/DescriptorProtos$FileDescriptorProto$Builder;
    .locals 1

    .prologue
    .line 2632
    iget-object v0, p0, Lcom/google/protobuf/DescriptorProtos$FileDescriptorProto$Builder;->optionsBuilder_:Lcom/google/protobuf/SingleFieldBuilder;

    if-nez v0, :cond_1

    .line 2633
    if-nez p1, :cond_0

    .line 2634
    new-instance v0, Ljava/lang/NullPointerException;

    invoke-direct {v0}, Ljava/lang/NullPointerException;-><init>()V

    throw v0

    .line 2636
    :cond_0
    iput-object p1, p0, Lcom/google/protobuf/DescriptorProtos$FileDescriptorProto$Builder;->options_:Lcom/google/protobuf/DescriptorProtos$FileOptions;

    .line 2637
    invoke-virtual {p0}, Lcom/google/protobuf/DescriptorProtos$FileDescriptorProto$Builder;->onChanged()V

    .line 2641
    :goto_0
    iget v0, p0, Lcom/google/protobuf/DescriptorProtos$FileDescriptorProto$Builder;->bitField0_:I

    or-int/lit16 v0, v0, 0x200

    iput v0, p0, Lcom/google/protobuf/DescriptorProtos$FileDescriptorProto$Builder;->bitField0_:I

    .line 2642
    return-object p0

    .line 2639
    :cond_1
    iget-object v0, p0, Lcom/google/protobuf/DescriptorProtos$FileDescriptorProto$Builder;->optionsBuilder_:Lcom/google/protobuf/SingleFieldBuilder;

    invoke-virtual {v0, p1}, Lcom/google/protobuf/SingleFieldBuilder;->setMessage(Lcom/google/protobuf/GeneratedMessage;)Lcom/google/protobuf/SingleFieldBuilder;

    goto :goto_0
.end method

.method public setPackage(Ljava/lang/String;)Lcom/google/protobuf/DescriptorProtos$FileDescriptorProto$Builder;
    .locals 1

    .prologue
    .line 1707
    if-nez p1, :cond_0

    .line 1708
    new-instance v0, Ljava/lang/NullPointerException;

    invoke-direct {v0}, Ljava/lang/NullPointerException;-><init>()V

    throw v0

    .line 1710
    :cond_0
    iget v0, p0, Lcom/google/protobuf/DescriptorProtos$FileDescriptorProto$Builder;->bitField0_:I

    or-int/lit8 v0, v0, 0x2

    iput v0, p0, Lcom/google/protobuf/DescriptorProtos$FileDescriptorProto$Builder;->bitField0_:I

    .line 1711
    iput-object p1, p0, Lcom/google/protobuf/DescriptorProtos$FileDescriptorProto$Builder;->package_:Ljava/lang/Object;

    .line 1712
    invoke-virtual {p0}, Lcom/google/protobuf/DescriptorProtos$FileDescriptorProto$Builder;->onChanged()V

    .line 1713
    return-object p0
.end method

.method setPackage(Lcom/google/protobuf/ByteString;)V
    .locals 1

    .prologue
    .line 1722
    iget v0, p0, Lcom/google/protobuf/DescriptorProtos$FileDescriptorProto$Builder;->bitField0_:I

    or-int/lit8 v0, v0, 0x2

    iput v0, p0, Lcom/google/protobuf/DescriptorProtos$FileDescriptorProto$Builder;->bitField0_:I

    .line 1723
    iput-object p1, p0, Lcom/google/protobuf/DescriptorProtos$FileDescriptorProto$Builder;->package_:Ljava/lang/Object;

    .line 1724
    invoke-virtual {p0}, Lcom/google/protobuf/DescriptorProtos$FileDescriptorProto$Builder;->onChanged()V

    .line 1725
    return-void
.end method

.method public setPublicDependency(II)Lcom/google/protobuf/DescriptorProtos$FileDescriptorProto$Builder;
    .locals 2

    .prologue
    .line 1803
    invoke-direct {p0}, Lcom/google/protobuf/DescriptorProtos$FileDescriptorProto$Builder;->ensurePublicDependencyIsMutable()V

    .line 1804
    iget-object v0, p0, Lcom/google/protobuf/DescriptorProtos$FileDescriptorProto$Builder;->publicDependency_:Ljava/util/List;

    invoke-static {p2}, Ljava/lang/Integer;->valueOf(I)Ljava/lang/Integer;

    move-result-object v1

    invoke-interface {v0, p1, v1}, Ljava/util/List;->set(ILjava/lang/Object;)Ljava/lang/Object;

    .line 1805
    invoke-virtual {p0}, Lcom/google/protobuf/DescriptorProtos$FileDescriptorProto$Builder;->onChanged()V

    .line 1806
    return-object p0
.end method

.method public setService(ILcom/google/protobuf/DescriptorProtos$ServiceDescriptorProto$Builder;)Lcom/google/protobuf/DescriptorProtos$FileDescriptorProto$Builder;
    .locals 2

    .prologue
    .line 2295
    iget-object v0, p0, Lcom/google/protobuf/DescriptorProtos$FileDescriptorProto$Builder;->serviceBuilder_:Lcom/google/protobuf/RepeatedFieldBuilder;

    if-nez v0, :cond_0

    .line 2296
    invoke-direct {p0}, Lcom/google/protobuf/DescriptorProtos$FileDescriptorProto$Builder;->ensureServiceIsMutable()V

    .line 2297
    iget-object v0, p0, Lcom/google/protobuf/DescriptorProtos$FileDescriptorProto$Builder;->service_:Ljava/util/List;

    invoke-virtual {p2}, Lcom/google/protobuf/DescriptorProtos$ServiceDescriptorProto$Builder;->build()Lcom/google/protobuf/DescriptorProtos$ServiceDescriptorProto;

    move-result-object v1

    invoke-interface {v0, p1, v1}, Ljava/util/List;->set(ILjava/lang/Object;)Ljava/lang/Object;

    .line 2298
    invoke-virtual {p0}, Lcom/google/protobuf/DescriptorProtos$FileDescriptorProto$Builder;->onChanged()V

    .line 2302
    :goto_0
    return-object p0

    .line 2300
    :cond_0
    iget-object v0, p0, Lcom/google/protobuf/DescriptorProtos$FileDescriptorProto$Builder;->serviceBuilder_:Lcom/google/protobuf/RepeatedFieldBuilder;

    invoke-virtual {p2}, Lcom/google/protobuf/DescriptorProtos$ServiceDescriptorProto$Builder;->build()Lcom/google/protobuf/DescriptorProtos$ServiceDescriptorProto;

    move-result-object v1

    invoke-virtual {v0, p1, v1}, Lcom/google/protobuf/RepeatedFieldBuilder;->setMessage(ILcom/google/protobuf/GeneratedMessage;)Lcom/google/protobuf/RepeatedFieldBuilder;

    goto :goto_0
.end method

.method public setService(ILcom/google/protobuf/DescriptorProtos$ServiceDescriptorProto;)Lcom/google/protobuf/DescriptorProtos$FileDescriptorProto$Builder;
    .locals 1

    .prologue
    .line 2281
    iget-object v0, p0, Lcom/google/protobuf/DescriptorProtos$FileDescriptorProto$Builder;->serviceBuilder_:Lcom/google/protobuf/RepeatedFieldBuilder;

    if-nez v0, :cond_1

    .line 2282
    if-nez p2, :cond_0

    .line 2283
    new-instance v0, Ljava/lang/NullPointerException;

    invoke-direct {v0}, Ljava/lang/NullPointerException;-><init>()V

    throw v0

    .line 2285
    :cond_0
    invoke-direct {p0}, Lcom/google/protobuf/DescriptorProtos$FileDescriptorProto$Builder;->ensureServiceIsMutable()V

    .line 2286
    iget-object v0, p0, Lcom/google/protobuf/DescriptorProtos$FileDescriptorProto$Builder;->service_:Ljava/util/List;

    invoke-interface {v0, p1, p2}, Ljava/util/List;->set(ILjava/lang/Object;)Ljava/lang/Object;

    .line 2287
    invoke-virtual {p0}, Lcom/google/protobuf/DescriptorProtos$FileDescriptorProto$Builder;->onChanged()V

    .line 2291
    :goto_0
    return-object p0

    .line 2289
    :cond_1
    iget-object v0, p0, Lcom/google/protobuf/DescriptorProtos$FileDescriptorProto$Builder;->serviceBuilder_:Lcom/google/protobuf/RepeatedFieldBuilder;

    invoke-virtual {v0, p1, p2}, Lcom/google/protobuf/RepeatedFieldBuilder;->setMessage(ILcom/google/protobuf/GeneratedMessage;)Lcom/google/protobuf/RepeatedFieldBuilder;

    goto :goto_0
.end method

.method public setSourceCodeInfo(Lcom/google/protobuf/DescriptorProtos$SourceCodeInfo$Builder;)Lcom/google/protobuf/DescriptorProtos$FileDescriptorProto$Builder;
    .locals 2

    .prologue
    .line 2736
    iget-object v0, p0, Lcom/google/protobuf/DescriptorProtos$FileDescriptorProto$Builder;->sourceCodeInfoBuilder_:Lcom/google/protobuf/SingleFieldBuilder;

    if-nez v0, :cond_0

    .line 2737
    invoke-virtual {p1}, Lcom/google/protobuf/DescriptorProtos$SourceCodeInfo$Builder;->build()Lcom/google/protobuf/DescriptorProtos$SourceCodeInfo;

    move-result-object v0

    iput-object v0, p0, Lcom/google/protobuf/DescriptorProtos$FileDescriptorProto$Builder;->sourceCodeInfo_:Lcom/google/protobuf/DescriptorProtos$SourceCodeInfo;

    .line 2738
    invoke-virtual {p0}, Lcom/google/protobuf/DescriptorProtos$FileDescriptorProto$Builder;->onChanged()V

    .line 2742
    :goto_0
    iget v0, p0, Lcom/google/protobuf/DescriptorProtos$FileDescriptorProto$Builder;->bitField0_:I

    or-int/lit16 v0, v0, 0x400

    iput v0, p0, Lcom/google/protobuf/DescriptorProtos$FileDescriptorProto$Builder;->bitField0_:I

    .line 2743
    return-object p0

    .line 2740
    :cond_0
    iget-object v0, p0, Lcom/google/protobuf/DescriptorProtos$FileDescriptorProto$Builder;->sourceCodeInfoBuilder_:Lcom/google/protobuf/SingleFieldBuilder;

    invoke-virtual {p1}, Lcom/google/protobuf/DescriptorProtos$SourceCodeInfo$Builder;->build()Lcom/google/protobuf/DescriptorProtos$SourceCodeInfo;

    move-result-object v1

    invoke-virtual {v0, v1}, Lcom/google/protobuf/SingleFieldBuilder;->setMessage(Lcom/google/protobuf/GeneratedMessage;)Lcom/google/protobuf/SingleFieldBuilder;

    goto :goto_0
.end method

.method public setSourceCodeInfo(Lcom/google/protobuf/DescriptorProtos$SourceCodeInfo;)Lcom/google/protobuf/DescriptorProtos$FileDescriptorProto$Builder;
    .locals 1

    .prologue
    .line 2722
    iget-object v0, p0, Lcom/google/protobuf/DescriptorProtos$FileDescriptorProto$Builder;->sourceCodeInfoBuilder_:Lcom/google/protobuf/SingleFieldBuilder;

    if-nez v0, :cond_1

    .line 2723
    if-nez p1, :cond_0

    .line 2724
    new-instance v0, Ljava/lang/NullPointerException;

    invoke-direct {v0}, Ljava/lang/NullPointerException;-><init>()V

    throw v0

    .line 2726
    :cond_0
    iput-object p1, p0, Lcom/google/protobuf/DescriptorProtos$FileDescriptorProto$Builder;->sourceCodeInfo_:Lcom/google/protobuf/DescriptorProtos$SourceCodeInfo;

    .line 2727
    invoke-virtual {p0}, Lcom/google/protobuf/DescriptorProtos$FileDescriptorProto$Builder;->onChanged()V

    .line 2731
    :goto_0
    iget v0, p0, Lcom/google/protobuf/DescriptorProtos$FileDescriptorProto$Builder;->bitField0_:I

    or-int/lit16 v0, v0, 0x400

    iput v0, p0, Lcom/google/protobuf/DescriptorProtos$FileDescriptorProto$Builder;->bitField0_:I

    .line 2732
    return-object p0

    .line 2729
    :cond_1
    iget-object v0, p0, Lcom/google/protobuf/DescriptorProtos$FileDescriptorProto$Builder;->sourceCodeInfoBuilder_:Lcom/google/protobuf/SingleFieldBuilder;

    invoke-virtual {v0, p1}, Lcom/google/protobuf/SingleFieldBuilder;->setMessage(Lcom/google/protobuf/GeneratedMessage;)Lcom/google/protobuf/SingleFieldBuilder;

    goto :goto_0
.end method

.method public setWeakDependency(II)Lcom/google/protobuf/DescriptorProtos$FileDescriptorProto$Builder;
    .locals 2

    .prologue
    .line 1848
    invoke-direct {p0}, Lcom/google/protobuf/DescriptorProtos$FileDescriptorProto$Builder;->ensureWeakDependencyIsMutable()V

    .line 1849
    iget-object v0, p0, Lcom/google/protobuf/DescriptorProtos$FileDescriptorProto$Builder;->weakDependency_:Ljava/util/List;

    invoke-static {p2}, Ljava/lang/Integer;->valueOf(I)Ljava/lang/Integer;

    move-result-object v1

    invoke-interface {v0, p1, v1}, Ljava/util/List;->set(ILjava/lang/Object;)Ljava/lang/Object;

    .line 1850
    invoke-virtual {p0}, Lcom/google/protobuf/DescriptorProtos$FileDescriptorProto$Builder;->onChanged()V

    .line 1851
    return-object p0
.end method
