.class public final Lcom/google/protobuf/DescriptorProtos$DescriptorProto$Builder;
.super Lcom/google/protobuf/GeneratedMessage$Builder;
.source "SourceFile"

# interfaces
.implements Lcom/google/protobuf/DescriptorProtos$DescriptorProtoOrBuilder;


# annotations
.annotation system Ldalvik/annotation/EnclosingClass;
    value = Lcom/google/protobuf/DescriptorProtos$DescriptorProto;
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x19
    name = "Builder"
.end annotation

.annotation system Ldalvik/annotation/Signature;
    value = {
        "Lcom/google/protobuf/GeneratedMessage$Builder",
        "<",
        "Lcom/google/protobuf/DescriptorProtos$DescriptorProto$Builder;",
        ">;",
        "Lcom/google/protobuf/DescriptorProtos$DescriptorProtoOrBuilder;"
    }
.end annotation


# instance fields
.field private bitField0_:I

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

.field private extensionRangeBuilder_:Lcom/google/protobuf/RepeatedFieldBuilder;
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "Lcom/google/protobuf/RepeatedFieldBuilder",
            "<",
            "Lcom/google/protobuf/DescriptorProtos$DescriptorProto$ExtensionRange;",
            "Lcom/google/protobuf/DescriptorProtos$DescriptorProto$ExtensionRange$Builder;",
            "Lcom/google/protobuf/DescriptorProtos$DescriptorProto$ExtensionRangeOrBuilder;",
            ">;"
        }
    .end annotation
.end field

.field private extensionRange_:Ljava/util/List;
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "Ljava/util/List",
            "<",
            "Lcom/google/protobuf/DescriptorProtos$DescriptorProto$ExtensionRange;",
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

.field private fieldBuilder_:Lcom/google/protobuf/RepeatedFieldBuilder;
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

.field private field_:Ljava/util/List;
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "Ljava/util/List",
            "<",
            "Lcom/google/protobuf/DescriptorProtos$FieldDescriptorProto;",
            ">;"
        }
    .end annotation
.end field

.field private name_:Ljava/lang/Object;

.field private nestedTypeBuilder_:Lcom/google/protobuf/RepeatedFieldBuilder;
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

.field private nestedType_:Ljava/util/List;
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "Ljava/util/List",
            "<",
            "Lcom/google/protobuf/DescriptorProtos$DescriptorProto;",
            ">;"
        }
    .end annotation
.end field

.field private optionsBuilder_:Lcom/google/protobuf/SingleFieldBuilder;
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "Lcom/google/protobuf/SingleFieldBuilder",
            "<",
            "Lcom/google/protobuf/DescriptorProtos$MessageOptions;",
            "Lcom/google/protobuf/DescriptorProtos$MessageOptions$Builder;",
            "Lcom/google/protobuf/DescriptorProtos$MessageOptionsOrBuilder;",
            ">;"
        }
    .end annotation
.end field

.field private options_:Lcom/google/protobuf/DescriptorProtos$MessageOptions;


# direct methods
.method private constructor <init>()V
    .locals 1

    .prologue
    .line 3659
    invoke-direct {p0}, Lcom/google/protobuf/GeneratedMessage$Builder;-><init>()V

    .line 4080
    const-string v0, ""

    iput-object v0, p0, Lcom/google/protobuf/DescriptorProtos$DescriptorProto$Builder;->name_:Ljava/lang/Object;

    .line 4117
    invoke-static {}, Ljava/util/Collections;->emptyList()Ljava/util/List;

    move-result-object v0

    iput-object v0, p0, Lcom/google/protobuf/DescriptorProtos$DescriptorProto$Builder;->field_:Ljava/util/List;

    .line 4303
    invoke-static {}, Ljava/util/Collections;->emptyList()Ljava/util/List;

    move-result-object v0

    iput-object v0, p0, Lcom/google/protobuf/DescriptorProtos$DescriptorProto$Builder;->extension_:Ljava/util/List;

    .line 4489
    invoke-static {}, Ljava/util/Collections;->emptyList()Ljava/util/List;

    move-result-object v0

    iput-object v0, p0, Lcom/google/protobuf/DescriptorProtos$DescriptorProto$Builder;->nestedType_:Ljava/util/List;

    .line 4675
    invoke-static {}, Ljava/util/Collections;->emptyList()Ljava/util/List;

    move-result-object v0

    iput-object v0, p0, Lcom/google/protobuf/DescriptorProtos$DescriptorProto$Builder;->enumType_:Ljava/util/List;

    .line 4861
    invoke-static {}, Ljava/util/Collections;->emptyList()Ljava/util/List;

    move-result-object v0

    iput-object v0, p0, Lcom/google/protobuf/DescriptorProtos$DescriptorProto$Builder;->extensionRange_:Ljava/util/List;

    .line 5046
    invoke-static {}, Lcom/google/protobuf/DescriptorProtos$MessageOptions;->getDefaultInstance()Lcom/google/protobuf/DescriptorProtos$MessageOptions;

    move-result-object v0

    iput-object v0, p0, Lcom/google/protobuf/DescriptorProtos$DescriptorProto$Builder;->options_:Lcom/google/protobuf/DescriptorProtos$MessageOptions;

    .line 3660
    invoke-direct {p0}, Lcom/google/protobuf/DescriptorProtos$DescriptorProto$Builder;->maybeForceBuilderInitialization()V

    .line 3661
    return-void
.end method

.method private constructor <init>(Lcom/google/protobuf/GeneratedMessage$BuilderParent;)V
    .locals 1

    .prologue
    .line 3664
    invoke-direct {p0, p1}, Lcom/google/protobuf/GeneratedMessage$Builder;-><init>(Lcom/google/protobuf/GeneratedMessage$BuilderParent;)V

    .line 4080
    const-string v0, ""

    iput-object v0, p0, Lcom/google/protobuf/DescriptorProtos$DescriptorProto$Builder;->name_:Ljava/lang/Object;

    .line 4117
    invoke-static {}, Ljava/util/Collections;->emptyList()Ljava/util/List;

    move-result-object v0

    iput-object v0, p0, Lcom/google/protobuf/DescriptorProtos$DescriptorProto$Builder;->field_:Ljava/util/List;

    .line 4303
    invoke-static {}, Ljava/util/Collections;->emptyList()Ljava/util/List;

    move-result-object v0

    iput-object v0, p0, Lcom/google/protobuf/DescriptorProtos$DescriptorProto$Builder;->extension_:Ljava/util/List;

    .line 4489
    invoke-static {}, Ljava/util/Collections;->emptyList()Ljava/util/List;

    move-result-object v0

    iput-object v0, p0, Lcom/google/protobuf/DescriptorProtos$DescriptorProto$Builder;->nestedType_:Ljava/util/List;

    .line 4675
    invoke-static {}, Ljava/util/Collections;->emptyList()Ljava/util/List;

    move-result-object v0

    iput-object v0, p0, Lcom/google/protobuf/DescriptorProtos$DescriptorProto$Builder;->enumType_:Ljava/util/List;

    .line 4861
    invoke-static {}, Ljava/util/Collections;->emptyList()Ljava/util/List;

    move-result-object v0

    iput-object v0, p0, Lcom/google/protobuf/DescriptorProtos$DescriptorProto$Builder;->extensionRange_:Ljava/util/List;

    .line 5046
    invoke-static {}, Lcom/google/protobuf/DescriptorProtos$MessageOptions;->getDefaultInstance()Lcom/google/protobuf/DescriptorProtos$MessageOptions;

    move-result-object v0

    iput-object v0, p0, Lcom/google/protobuf/DescriptorProtos$DescriptorProto$Builder;->options_:Lcom/google/protobuf/DescriptorProtos$MessageOptions;

    .line 3665
    invoke-direct {p0}, Lcom/google/protobuf/DescriptorProtos$DescriptorProto$Builder;->maybeForceBuilderInitialization()V

    .line 3666
    return-void
.end method

.method synthetic constructor <init>(Lcom/google/protobuf/GeneratedMessage$BuilderParent;Lcom/google/protobuf/DescriptorProtos$DescriptorProto$Builder;)V
    .locals 0

    .prologue
    .line 3663
    invoke-direct {p0, p1}, Lcom/google/protobuf/DescriptorProtos$DescriptorProto$Builder;-><init>(Lcom/google/protobuf/GeneratedMessage$BuilderParent;)V

    return-void
.end method

.method static synthetic access$17(Lcom/google/protobuf/DescriptorProtos$DescriptorProto$Builder;)Lcom/google/protobuf/DescriptorProtos$DescriptorProto;
    .locals 1
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Lcom/google/protobuf/InvalidProtocolBufferException;
        }
    .end annotation

    .prologue
    .line 3745
    invoke-direct {p0}, Lcom/google/protobuf/DescriptorProtos$DescriptorProto$Builder;->buildParsed()Lcom/google/protobuf/DescriptorProtos$DescriptorProto;

    move-result-object v0

    return-object v0
.end method

.method static synthetic access$18()Lcom/google/protobuf/DescriptorProtos$DescriptorProto$Builder;
    .locals 1

    .prologue
    .line 3677
    invoke-static {}, Lcom/google/protobuf/DescriptorProtos$DescriptorProto$Builder;->create()Lcom/google/protobuf/DescriptorProtos$DescriptorProto$Builder;

    move-result-object v0

    return-object v0
.end method

.method private buildParsed()Lcom/google/protobuf/DescriptorProtos$DescriptorProto;
    .locals 2
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Lcom/google/protobuf/InvalidProtocolBufferException;
        }
    .end annotation

    .prologue
    .line 3747
    invoke-virtual {p0}, Lcom/google/protobuf/DescriptorProtos$DescriptorProto$Builder;->buildPartial()Lcom/google/protobuf/DescriptorProtos$DescriptorProto;

    move-result-object v0

    .line 3748
    invoke-virtual {v0}, Lcom/google/protobuf/DescriptorProtos$DescriptorProto;->isInitialized()Z

    move-result v1

    if-nez v1, :cond_0

    .line 3749
    invoke-static {v0}, Lcom/google/protobuf/DescriptorProtos$DescriptorProto$Builder;->newUninitializedMessageException(Lcom/google/protobuf/Message;)Lcom/google/protobuf/UninitializedMessageException;

    move-result-object v0

    .line 3750
    invoke-virtual {v0}, Lcom/google/protobuf/UninitializedMessageException;->asInvalidProtocolBufferException()Lcom/google/protobuf/InvalidProtocolBufferException;

    move-result-object v0

    .line 3749
    throw v0

    .line 3752
    :cond_0
    return-object v0
.end method

.method private static create()Lcom/google/protobuf/DescriptorProtos$DescriptorProto$Builder;
    .locals 1

    .prologue
    .line 3678
    new-instance v0, Lcom/google/protobuf/DescriptorProtos$DescriptorProto$Builder;

    invoke-direct {v0}, Lcom/google/protobuf/DescriptorProtos$DescriptorProto$Builder;-><init>()V

    return-object v0
.end method

.method private ensureEnumTypeIsMutable()V
    .locals 2

    .prologue
    .line 4677
    iget v0, p0, Lcom/google/protobuf/DescriptorProtos$DescriptorProto$Builder;->bitField0_:I

    and-int/lit8 v0, v0, 0x10

    const/16 v1, 0x10

    if-eq v0, v1, :cond_0

    .line 4678
    new-instance v0, Ljava/util/ArrayList;

    iget-object v1, p0, Lcom/google/protobuf/DescriptorProtos$DescriptorProto$Builder;->enumType_:Ljava/util/List;

    invoke-direct {v0, v1}, Ljava/util/ArrayList;-><init>(Ljava/util/Collection;)V

    iput-object v0, p0, Lcom/google/protobuf/DescriptorProtos$DescriptorProto$Builder;->enumType_:Ljava/util/List;

    .line 4679
    iget v0, p0, Lcom/google/protobuf/DescriptorProtos$DescriptorProto$Builder;->bitField0_:I

    or-int/lit8 v0, v0, 0x10

    iput v0, p0, Lcom/google/protobuf/DescriptorProtos$DescriptorProto$Builder;->bitField0_:I

    .line 4681
    :cond_0
    return-void
.end method

.method private ensureExtensionIsMutable()V
    .locals 2

    .prologue
    .line 4305
    iget v0, p0, Lcom/google/protobuf/DescriptorProtos$DescriptorProto$Builder;->bitField0_:I

    and-int/lit8 v0, v0, 0x4

    const/4 v1, 0x4

    if-eq v0, v1, :cond_0

    .line 4306
    new-instance v0, Ljava/util/ArrayList;

    iget-object v1, p0, Lcom/google/protobuf/DescriptorProtos$DescriptorProto$Builder;->extension_:Ljava/util/List;

    invoke-direct {v0, v1}, Ljava/util/ArrayList;-><init>(Ljava/util/Collection;)V

    iput-object v0, p0, Lcom/google/protobuf/DescriptorProtos$DescriptorProto$Builder;->extension_:Ljava/util/List;

    .line 4307
    iget v0, p0, Lcom/google/protobuf/DescriptorProtos$DescriptorProto$Builder;->bitField0_:I

    or-int/lit8 v0, v0, 0x4

    iput v0, p0, Lcom/google/protobuf/DescriptorProtos$DescriptorProto$Builder;->bitField0_:I

    .line 4309
    :cond_0
    return-void
.end method

.method private ensureExtensionRangeIsMutable()V
    .locals 2

    .prologue
    .line 4863
    iget v0, p0, Lcom/google/protobuf/DescriptorProtos$DescriptorProto$Builder;->bitField0_:I

    and-int/lit8 v0, v0, 0x20

    const/16 v1, 0x20

    if-eq v0, v1, :cond_0

    .line 4864
    new-instance v0, Ljava/util/ArrayList;

    iget-object v1, p0, Lcom/google/protobuf/DescriptorProtos$DescriptorProto$Builder;->extensionRange_:Ljava/util/List;

    invoke-direct {v0, v1}, Ljava/util/ArrayList;-><init>(Ljava/util/Collection;)V

    iput-object v0, p0, Lcom/google/protobuf/DescriptorProtos$DescriptorProto$Builder;->extensionRange_:Ljava/util/List;

    .line 4865
    iget v0, p0, Lcom/google/protobuf/DescriptorProtos$DescriptorProto$Builder;->bitField0_:I

    or-int/lit8 v0, v0, 0x20

    iput v0, p0, Lcom/google/protobuf/DescriptorProtos$DescriptorProto$Builder;->bitField0_:I

    .line 4867
    :cond_0
    return-void
.end method

.method private ensureFieldIsMutable()V
    .locals 2

    .prologue
    .line 4119
    iget v0, p0, Lcom/google/protobuf/DescriptorProtos$DescriptorProto$Builder;->bitField0_:I

    and-int/lit8 v0, v0, 0x2

    const/4 v1, 0x2

    if-eq v0, v1, :cond_0

    .line 4120
    new-instance v0, Ljava/util/ArrayList;

    iget-object v1, p0, Lcom/google/protobuf/DescriptorProtos$DescriptorProto$Builder;->field_:Ljava/util/List;

    invoke-direct {v0, v1}, Ljava/util/ArrayList;-><init>(Ljava/util/Collection;)V

    iput-object v0, p0, Lcom/google/protobuf/DescriptorProtos$DescriptorProto$Builder;->field_:Ljava/util/List;

    .line 4121
    iget v0, p0, Lcom/google/protobuf/DescriptorProtos$DescriptorProto$Builder;->bitField0_:I

    or-int/lit8 v0, v0, 0x2

    iput v0, p0, Lcom/google/protobuf/DescriptorProtos$DescriptorProto$Builder;->bitField0_:I

    .line 4123
    :cond_0
    return-void
.end method

.method private ensureNestedTypeIsMutable()V
    .locals 2

    .prologue
    .line 4491
    iget v0, p0, Lcom/google/protobuf/DescriptorProtos$DescriptorProto$Builder;->bitField0_:I

    and-int/lit8 v0, v0, 0x8

    const/16 v1, 0x8

    if-eq v0, v1, :cond_0

    .line 4492
    new-instance v0, Ljava/util/ArrayList;

    iget-object v1, p0, Lcom/google/protobuf/DescriptorProtos$DescriptorProto$Builder;->nestedType_:Ljava/util/List;

    invoke-direct {v0, v1}, Ljava/util/ArrayList;-><init>(Ljava/util/Collection;)V

    iput-object v0, p0, Lcom/google/protobuf/DescriptorProtos$DescriptorProto$Builder;->nestedType_:Ljava/util/List;

    .line 4493
    iget v0, p0, Lcom/google/protobuf/DescriptorProtos$DescriptorProto$Builder;->bitField0_:I

    or-int/lit8 v0, v0, 0x8

    iput v0, p0, Lcom/google/protobuf/DescriptorProtos$DescriptorProto$Builder;->bitField0_:I

    .line 4495
    :cond_0
    return-void
.end method

.method public static final getDescriptor()Lcom/google/protobuf/Descriptors$Descriptor;
    .locals 1

    .prologue
    .line 3650
    invoke-static {}, Lcom/google/protobuf/DescriptorProtos;->access$8()Lcom/google/protobuf/Descriptors$Descriptor;

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
    .line 4847
    iget-object v0, p0, Lcom/google/protobuf/DescriptorProtos$DescriptorProto$Builder;->enumTypeBuilder_:Lcom/google/protobuf/RepeatedFieldBuilder;

    if-nez v0, :cond_0

    .line 4848
    new-instance v1, Lcom/google/protobuf/RepeatedFieldBuilder;

    .line 4850
    iget-object v2, p0, Lcom/google/protobuf/DescriptorProtos$DescriptorProto$Builder;->enumType_:Ljava/util/List;

    .line 4851
    iget v0, p0, Lcom/google/protobuf/DescriptorProtos$DescriptorProto$Builder;->bitField0_:I

    and-int/lit8 v0, v0, 0x10

    const/16 v3, 0x10

    if-ne v0, v3, :cond_1

    const/4 v0, 0x1

    .line 4852
    :goto_0
    invoke-virtual {p0}, Lcom/google/protobuf/DescriptorProtos$DescriptorProto$Builder;->getParentForChildren()Lcom/google/protobuf/GeneratedMessage$BuilderParent;

    move-result-object v3

    .line 4853
    invoke-virtual {p0}, Lcom/google/protobuf/DescriptorProtos$DescriptorProto$Builder;->isClean()Z

    move-result v4

    invoke-direct {v1, v2, v0, v3, v4}, Lcom/google/protobuf/RepeatedFieldBuilder;-><init>(Ljava/util/List;ZLcom/google/protobuf/GeneratedMessage$BuilderParent;Z)V

    .line 4848
    iput-object v1, p0, Lcom/google/protobuf/DescriptorProtos$DescriptorProto$Builder;->enumTypeBuilder_:Lcom/google/protobuf/RepeatedFieldBuilder;

    .line 4854
    const/4 v0, 0x0

    iput-object v0, p0, Lcom/google/protobuf/DescriptorProtos$DescriptorProto$Builder;->enumType_:Ljava/util/List;

    .line 4856
    :cond_0
    iget-object v0, p0, Lcom/google/protobuf/DescriptorProtos$DescriptorProto$Builder;->enumTypeBuilder_:Lcom/google/protobuf/RepeatedFieldBuilder;

    return-object v0

    .line 4851
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
    .line 4475
    iget-object v0, p0, Lcom/google/protobuf/DescriptorProtos$DescriptorProto$Builder;->extensionBuilder_:Lcom/google/protobuf/RepeatedFieldBuilder;

    if-nez v0, :cond_0

    .line 4476
    new-instance v1, Lcom/google/protobuf/RepeatedFieldBuilder;

    .line 4478
    iget-object v2, p0, Lcom/google/protobuf/DescriptorProtos$DescriptorProto$Builder;->extension_:Ljava/util/List;

    .line 4479
    iget v0, p0, Lcom/google/protobuf/DescriptorProtos$DescriptorProto$Builder;->bitField0_:I

    and-int/lit8 v0, v0, 0x4

    const/4 v3, 0x4

    if-ne v0, v3, :cond_1

    const/4 v0, 0x1

    .line 4480
    :goto_0
    invoke-virtual {p0}, Lcom/google/protobuf/DescriptorProtos$DescriptorProto$Builder;->getParentForChildren()Lcom/google/protobuf/GeneratedMessage$BuilderParent;

    move-result-object v3

    .line 4481
    invoke-virtual {p0}, Lcom/google/protobuf/DescriptorProtos$DescriptorProto$Builder;->isClean()Z

    move-result v4

    invoke-direct {v1, v2, v0, v3, v4}, Lcom/google/protobuf/RepeatedFieldBuilder;-><init>(Ljava/util/List;ZLcom/google/protobuf/GeneratedMessage$BuilderParent;Z)V

    .line 4476
    iput-object v1, p0, Lcom/google/protobuf/DescriptorProtos$DescriptorProto$Builder;->extensionBuilder_:Lcom/google/protobuf/RepeatedFieldBuilder;

    .line 4482
    const/4 v0, 0x0

    iput-object v0, p0, Lcom/google/protobuf/DescriptorProtos$DescriptorProto$Builder;->extension_:Ljava/util/List;

    .line 4484
    :cond_0
    iget-object v0, p0, Lcom/google/protobuf/DescriptorProtos$DescriptorProto$Builder;->extensionBuilder_:Lcom/google/protobuf/RepeatedFieldBuilder;

    return-object v0

    .line 4479
    :cond_1
    const/4 v0, 0x0

    goto :goto_0
.end method

.method private getExtensionRangeFieldBuilder()Lcom/google/protobuf/RepeatedFieldBuilder;
    .locals 5
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "()",
            "Lcom/google/protobuf/RepeatedFieldBuilder",
            "<",
            "Lcom/google/protobuf/DescriptorProtos$DescriptorProto$ExtensionRange;",
            "Lcom/google/protobuf/DescriptorProtos$DescriptorProto$ExtensionRange$Builder;",
            "Lcom/google/protobuf/DescriptorProtos$DescriptorProto$ExtensionRangeOrBuilder;",
            ">;"
        }
    .end annotation

    .prologue
    .line 5033
    iget-object v0, p0, Lcom/google/protobuf/DescriptorProtos$DescriptorProto$Builder;->extensionRangeBuilder_:Lcom/google/protobuf/RepeatedFieldBuilder;

    if-nez v0, :cond_0

    .line 5034
    new-instance v1, Lcom/google/protobuf/RepeatedFieldBuilder;

    .line 5036
    iget-object v2, p0, Lcom/google/protobuf/DescriptorProtos$DescriptorProto$Builder;->extensionRange_:Ljava/util/List;

    .line 5037
    iget v0, p0, Lcom/google/protobuf/DescriptorProtos$DescriptorProto$Builder;->bitField0_:I

    and-int/lit8 v0, v0, 0x20

    const/16 v3, 0x20

    if-ne v0, v3, :cond_1

    const/4 v0, 0x1

    .line 5038
    :goto_0
    invoke-virtual {p0}, Lcom/google/protobuf/DescriptorProtos$DescriptorProto$Builder;->getParentForChildren()Lcom/google/protobuf/GeneratedMessage$BuilderParent;

    move-result-object v3

    .line 5039
    invoke-virtual {p0}, Lcom/google/protobuf/DescriptorProtos$DescriptorProto$Builder;->isClean()Z

    move-result v4

    invoke-direct {v1, v2, v0, v3, v4}, Lcom/google/protobuf/RepeatedFieldBuilder;-><init>(Ljava/util/List;ZLcom/google/protobuf/GeneratedMessage$BuilderParent;Z)V

    .line 5034
    iput-object v1, p0, Lcom/google/protobuf/DescriptorProtos$DescriptorProto$Builder;->extensionRangeBuilder_:Lcom/google/protobuf/RepeatedFieldBuilder;

    .line 5040
    const/4 v0, 0x0

    iput-object v0, p0, Lcom/google/protobuf/DescriptorProtos$DescriptorProto$Builder;->extensionRange_:Ljava/util/List;

    .line 5042
    :cond_0
    iget-object v0, p0, Lcom/google/protobuf/DescriptorProtos$DescriptorProto$Builder;->extensionRangeBuilder_:Lcom/google/protobuf/RepeatedFieldBuilder;

    return-object v0

    .line 5037
    :cond_1
    const/4 v0, 0x0

    goto :goto_0
.end method

.method private getFieldFieldBuilder()Lcom/google/protobuf/RepeatedFieldBuilder;
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
    .line 4289
    iget-object v0, p0, Lcom/google/protobuf/DescriptorProtos$DescriptorProto$Builder;->fieldBuilder_:Lcom/google/protobuf/RepeatedFieldBuilder;

    if-nez v0, :cond_0

    .line 4290
    new-instance v1, Lcom/google/protobuf/RepeatedFieldBuilder;

    .line 4292
    iget-object v2, p0, Lcom/google/protobuf/DescriptorProtos$DescriptorProto$Builder;->field_:Ljava/util/List;

    .line 4293
    iget v0, p0, Lcom/google/protobuf/DescriptorProtos$DescriptorProto$Builder;->bitField0_:I

    and-int/lit8 v0, v0, 0x2

    const/4 v3, 0x2

    if-ne v0, v3, :cond_1

    const/4 v0, 0x1

    .line 4294
    :goto_0
    invoke-virtual {p0}, Lcom/google/protobuf/DescriptorProtos$DescriptorProto$Builder;->getParentForChildren()Lcom/google/protobuf/GeneratedMessage$BuilderParent;

    move-result-object v3

    .line 4295
    invoke-virtual {p0}, Lcom/google/protobuf/DescriptorProtos$DescriptorProto$Builder;->isClean()Z

    move-result v4

    invoke-direct {v1, v2, v0, v3, v4}, Lcom/google/protobuf/RepeatedFieldBuilder;-><init>(Ljava/util/List;ZLcom/google/protobuf/GeneratedMessage$BuilderParent;Z)V

    .line 4290
    iput-object v1, p0, Lcom/google/protobuf/DescriptorProtos$DescriptorProto$Builder;->fieldBuilder_:Lcom/google/protobuf/RepeatedFieldBuilder;

    .line 4296
    const/4 v0, 0x0

    iput-object v0, p0, Lcom/google/protobuf/DescriptorProtos$DescriptorProto$Builder;->field_:Ljava/util/List;

    .line 4298
    :cond_0
    iget-object v0, p0, Lcom/google/protobuf/DescriptorProtos$DescriptorProto$Builder;->fieldBuilder_:Lcom/google/protobuf/RepeatedFieldBuilder;

    return-object v0

    .line 4293
    :cond_1
    const/4 v0, 0x0

    goto :goto_0
.end method

.method private getNestedTypeFieldBuilder()Lcom/google/protobuf/RepeatedFieldBuilder;
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
    .line 4661
    iget-object v0, p0, Lcom/google/protobuf/DescriptorProtos$DescriptorProto$Builder;->nestedTypeBuilder_:Lcom/google/protobuf/RepeatedFieldBuilder;

    if-nez v0, :cond_0

    .line 4662
    new-instance v1, Lcom/google/protobuf/RepeatedFieldBuilder;

    .line 4664
    iget-object v2, p0, Lcom/google/protobuf/DescriptorProtos$DescriptorProto$Builder;->nestedType_:Ljava/util/List;

    .line 4665
    iget v0, p0, Lcom/google/protobuf/DescriptorProtos$DescriptorProto$Builder;->bitField0_:I

    and-int/lit8 v0, v0, 0x8

    const/16 v3, 0x8

    if-ne v0, v3, :cond_1

    const/4 v0, 0x1

    .line 4666
    :goto_0
    invoke-virtual {p0}, Lcom/google/protobuf/DescriptorProtos$DescriptorProto$Builder;->getParentForChildren()Lcom/google/protobuf/GeneratedMessage$BuilderParent;

    move-result-object v3

    .line 4667
    invoke-virtual {p0}, Lcom/google/protobuf/DescriptorProtos$DescriptorProto$Builder;->isClean()Z

    move-result v4

    invoke-direct {v1, v2, v0, v3, v4}, Lcom/google/protobuf/RepeatedFieldBuilder;-><init>(Ljava/util/List;ZLcom/google/protobuf/GeneratedMessage$BuilderParent;Z)V

    .line 4662
    iput-object v1, p0, Lcom/google/protobuf/DescriptorProtos$DescriptorProto$Builder;->nestedTypeBuilder_:Lcom/google/protobuf/RepeatedFieldBuilder;

    .line 4668
    const/4 v0, 0x0

    iput-object v0, p0, Lcom/google/protobuf/DescriptorProtos$DescriptorProto$Builder;->nestedType_:Ljava/util/List;

    .line 4670
    :cond_0
    iget-object v0, p0, Lcom/google/protobuf/DescriptorProtos$DescriptorProto$Builder;->nestedTypeBuilder_:Lcom/google/protobuf/RepeatedFieldBuilder;

    return-object v0

    .line 4665
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
            "Lcom/google/protobuf/DescriptorProtos$MessageOptions;",
            "Lcom/google/protobuf/DescriptorProtos$MessageOptions$Builder;",
            "Lcom/google/protobuf/DescriptorProtos$MessageOptionsOrBuilder;",
            ">;"
        }
    .end annotation

    .prologue
    .line 5124
    iget-object v0, p0, Lcom/google/protobuf/DescriptorProtos$DescriptorProto$Builder;->optionsBuilder_:Lcom/google/protobuf/SingleFieldBuilder;

    if-nez v0, :cond_0

    .line 5125
    new-instance v0, Lcom/google/protobuf/SingleFieldBuilder;

    .line 5127
    iget-object v1, p0, Lcom/google/protobuf/DescriptorProtos$DescriptorProto$Builder;->options_:Lcom/google/protobuf/DescriptorProtos$MessageOptions;

    .line 5128
    invoke-virtual {p0}, Lcom/google/protobuf/DescriptorProtos$DescriptorProto$Builder;->getParentForChildren()Lcom/google/protobuf/GeneratedMessage$BuilderParent;

    move-result-object v2

    .line 5129
    invoke-virtual {p0}, Lcom/google/protobuf/DescriptorProtos$DescriptorProto$Builder;->isClean()Z

    move-result v3

    invoke-direct {v0, v1, v2, v3}, Lcom/google/protobuf/SingleFieldBuilder;-><init>(Lcom/google/protobuf/GeneratedMessage;Lcom/google/protobuf/GeneratedMessage$BuilderParent;Z)V

    .line 5125
    iput-object v0, p0, Lcom/google/protobuf/DescriptorProtos$DescriptorProto$Builder;->optionsBuilder_:Lcom/google/protobuf/SingleFieldBuilder;

    .line 5130
    const/4 v0, 0x0

    iput-object v0, p0, Lcom/google/protobuf/DescriptorProtos$DescriptorProto$Builder;->options_:Lcom/google/protobuf/DescriptorProtos$MessageOptions;

    .line 5132
    :cond_0
    iget-object v0, p0, Lcom/google/protobuf/DescriptorProtos$DescriptorProto$Builder;->optionsBuilder_:Lcom/google/protobuf/SingleFieldBuilder;

    return-object v0
.end method

.method private maybeForceBuilderInitialization()V
    .locals 1

    .prologue
    .line 3668
    sget-boolean v0, Lcom/google/protobuf/GeneratedMessage;->alwaysUseFieldBuilders:Z

    if-eqz v0, :cond_0

    .line 3669
    invoke-direct {p0}, Lcom/google/protobuf/DescriptorProtos$DescriptorProto$Builder;->getFieldFieldBuilder()Lcom/google/protobuf/RepeatedFieldBuilder;

    .line 3670
    invoke-direct {p0}, Lcom/google/protobuf/DescriptorProtos$DescriptorProto$Builder;->getExtensionFieldBuilder()Lcom/google/protobuf/RepeatedFieldBuilder;

    .line 3671
    invoke-direct {p0}, Lcom/google/protobuf/DescriptorProtos$DescriptorProto$Builder;->getNestedTypeFieldBuilder()Lcom/google/protobuf/RepeatedFieldBuilder;

    .line 3672
    invoke-direct {p0}, Lcom/google/protobuf/DescriptorProtos$DescriptorProto$Builder;->getEnumTypeFieldBuilder()Lcom/google/protobuf/RepeatedFieldBuilder;

    .line 3673
    invoke-direct {p0}, Lcom/google/protobuf/DescriptorProtos$DescriptorProto$Builder;->getExtensionRangeFieldBuilder()Lcom/google/protobuf/RepeatedFieldBuilder;

    .line 3674
    invoke-direct {p0}, Lcom/google/protobuf/DescriptorProtos$DescriptorProto$Builder;->getOptionsFieldBuilder()Lcom/google/protobuf/SingleFieldBuilder;

    .line 3676
    :cond_0
    return-void
.end method


# virtual methods
.method public addAllEnumType(Ljava/lang/Iterable;)Lcom/google/protobuf/DescriptorProtos$DescriptorProto$Builder;
    .locals 1
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "(",
            "Ljava/lang/Iterable",
            "<+",
            "Lcom/google/protobuf/DescriptorProtos$EnumDescriptorProto;",
            ">;)",
            "Lcom/google/protobuf/DescriptorProtos$DescriptorProto$Builder;"
        }
    .end annotation

    .prologue
    .line 4783
    iget-object v0, p0, Lcom/google/protobuf/DescriptorProtos$DescriptorProto$Builder;->enumTypeBuilder_:Lcom/google/protobuf/RepeatedFieldBuilder;

    if-nez v0, :cond_0

    .line 4784
    invoke-direct {p0}, Lcom/google/protobuf/DescriptorProtos$DescriptorProto$Builder;->ensureEnumTypeIsMutable()V

    .line 4785
    iget-object v0, p0, Lcom/google/protobuf/DescriptorProtos$DescriptorProto$Builder;->enumType_:Ljava/util/List;

    invoke-static {p1, v0}, Lcom/google/protobuf/GeneratedMessage$Builder;->addAll(Ljava/lang/Iterable;Ljava/util/Collection;)V

    .line 4786
    invoke-virtual {p0}, Lcom/google/protobuf/DescriptorProtos$DescriptorProto$Builder;->onChanged()V

    .line 4790
    :goto_0
    return-object p0

    .line 4788
    :cond_0
    iget-object v0, p0, Lcom/google/protobuf/DescriptorProtos$DescriptorProto$Builder;->enumTypeBuilder_:Lcom/google/protobuf/RepeatedFieldBuilder;

    invoke-virtual {v0, p1}, Lcom/google/protobuf/RepeatedFieldBuilder;->addAllMessages(Ljava/lang/Iterable;)Lcom/google/protobuf/RepeatedFieldBuilder;

    goto :goto_0
.end method

.method public addAllExtension(Ljava/lang/Iterable;)Lcom/google/protobuf/DescriptorProtos$DescriptorProto$Builder;
    .locals 1
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "(",
            "Ljava/lang/Iterable",
            "<+",
            "Lcom/google/protobuf/DescriptorProtos$FieldDescriptorProto;",
            ">;)",
            "Lcom/google/protobuf/DescriptorProtos$DescriptorProto$Builder;"
        }
    .end annotation

    .prologue
    .line 4411
    iget-object v0, p0, Lcom/google/protobuf/DescriptorProtos$DescriptorProto$Builder;->extensionBuilder_:Lcom/google/protobuf/RepeatedFieldBuilder;

    if-nez v0, :cond_0

    .line 4412
    invoke-direct {p0}, Lcom/google/protobuf/DescriptorProtos$DescriptorProto$Builder;->ensureExtensionIsMutable()V

    .line 4413
    iget-object v0, p0, Lcom/google/protobuf/DescriptorProtos$DescriptorProto$Builder;->extension_:Ljava/util/List;

    invoke-static {p1, v0}, Lcom/google/protobuf/GeneratedMessage$Builder;->addAll(Ljava/lang/Iterable;Ljava/util/Collection;)V

    .line 4414
    invoke-virtual {p0}, Lcom/google/protobuf/DescriptorProtos$DescriptorProto$Builder;->onChanged()V

    .line 4418
    :goto_0
    return-object p0

    .line 4416
    :cond_0
    iget-object v0, p0, Lcom/google/protobuf/DescriptorProtos$DescriptorProto$Builder;->extensionBuilder_:Lcom/google/protobuf/RepeatedFieldBuilder;

    invoke-virtual {v0, p1}, Lcom/google/protobuf/RepeatedFieldBuilder;->addAllMessages(Ljava/lang/Iterable;)Lcom/google/protobuf/RepeatedFieldBuilder;

    goto :goto_0
.end method

.method public addAllExtensionRange(Ljava/lang/Iterable;)Lcom/google/protobuf/DescriptorProtos$DescriptorProto$Builder;
    .locals 1
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "(",
            "Ljava/lang/Iterable",
            "<+",
            "Lcom/google/protobuf/DescriptorProtos$DescriptorProto$ExtensionRange;",
            ">;)",
            "Lcom/google/protobuf/DescriptorProtos$DescriptorProto$Builder;"
        }
    .end annotation

    .prologue
    .line 4969
    iget-object v0, p0, Lcom/google/protobuf/DescriptorProtos$DescriptorProto$Builder;->extensionRangeBuilder_:Lcom/google/protobuf/RepeatedFieldBuilder;

    if-nez v0, :cond_0

    .line 4970
    invoke-direct {p0}, Lcom/google/protobuf/DescriptorProtos$DescriptorProto$Builder;->ensureExtensionRangeIsMutable()V

    .line 4971
    iget-object v0, p0, Lcom/google/protobuf/DescriptorProtos$DescriptorProto$Builder;->extensionRange_:Ljava/util/List;

    invoke-static {p1, v0}, Lcom/google/protobuf/GeneratedMessage$Builder;->addAll(Ljava/lang/Iterable;Ljava/util/Collection;)V

    .line 4972
    invoke-virtual {p0}, Lcom/google/protobuf/DescriptorProtos$DescriptorProto$Builder;->onChanged()V

    .line 4976
    :goto_0
    return-object p0

    .line 4974
    :cond_0
    iget-object v0, p0, Lcom/google/protobuf/DescriptorProtos$DescriptorProto$Builder;->extensionRangeBuilder_:Lcom/google/protobuf/RepeatedFieldBuilder;

    invoke-virtual {v0, p1}, Lcom/google/protobuf/RepeatedFieldBuilder;->addAllMessages(Ljava/lang/Iterable;)Lcom/google/protobuf/RepeatedFieldBuilder;

    goto :goto_0
.end method

.method public addAllField(Ljava/lang/Iterable;)Lcom/google/protobuf/DescriptorProtos$DescriptorProto$Builder;
    .locals 1
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "(",
            "Ljava/lang/Iterable",
            "<+",
            "Lcom/google/protobuf/DescriptorProtos$FieldDescriptorProto;",
            ">;)",
            "Lcom/google/protobuf/DescriptorProtos$DescriptorProto$Builder;"
        }
    .end annotation

    .prologue
    .line 4225
    iget-object v0, p0, Lcom/google/protobuf/DescriptorProtos$DescriptorProto$Builder;->fieldBuilder_:Lcom/google/protobuf/RepeatedFieldBuilder;

    if-nez v0, :cond_0

    .line 4226
    invoke-direct {p0}, Lcom/google/protobuf/DescriptorProtos$DescriptorProto$Builder;->ensureFieldIsMutable()V

    .line 4227
    iget-object v0, p0, Lcom/google/protobuf/DescriptorProtos$DescriptorProto$Builder;->field_:Ljava/util/List;

    invoke-static {p1, v0}, Lcom/google/protobuf/GeneratedMessage$Builder;->addAll(Ljava/lang/Iterable;Ljava/util/Collection;)V

    .line 4228
    invoke-virtual {p0}, Lcom/google/protobuf/DescriptorProtos$DescriptorProto$Builder;->onChanged()V

    .line 4232
    :goto_0
    return-object p0

    .line 4230
    :cond_0
    iget-object v0, p0, Lcom/google/protobuf/DescriptorProtos$DescriptorProto$Builder;->fieldBuilder_:Lcom/google/protobuf/RepeatedFieldBuilder;

    invoke-virtual {v0, p1}, Lcom/google/protobuf/RepeatedFieldBuilder;->addAllMessages(Ljava/lang/Iterable;)Lcom/google/protobuf/RepeatedFieldBuilder;

    goto :goto_0
.end method

.method public addAllNestedType(Ljava/lang/Iterable;)Lcom/google/protobuf/DescriptorProtos$DescriptorProto$Builder;
    .locals 1
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "(",
            "Ljava/lang/Iterable",
            "<+",
            "Lcom/google/protobuf/DescriptorProtos$DescriptorProto;",
            ">;)",
            "Lcom/google/protobuf/DescriptorProtos$DescriptorProto$Builder;"
        }
    .end annotation

    .prologue
    .line 4597
    iget-object v0, p0, Lcom/google/protobuf/DescriptorProtos$DescriptorProto$Builder;->nestedTypeBuilder_:Lcom/google/protobuf/RepeatedFieldBuilder;

    if-nez v0, :cond_0

    .line 4598
    invoke-direct {p0}, Lcom/google/protobuf/DescriptorProtos$DescriptorProto$Builder;->ensureNestedTypeIsMutable()V

    .line 4599
    iget-object v0, p0, Lcom/google/protobuf/DescriptorProtos$DescriptorProto$Builder;->nestedType_:Ljava/util/List;

    invoke-static {p1, v0}, Lcom/google/protobuf/GeneratedMessage$Builder;->addAll(Ljava/lang/Iterable;Ljava/util/Collection;)V

    .line 4600
    invoke-virtual {p0}, Lcom/google/protobuf/DescriptorProtos$DescriptorProto$Builder;->onChanged()V

    .line 4604
    :goto_0
    return-object p0

    .line 4602
    :cond_0
    iget-object v0, p0, Lcom/google/protobuf/DescriptorProtos$DescriptorProto$Builder;->nestedTypeBuilder_:Lcom/google/protobuf/RepeatedFieldBuilder;

    invoke-virtual {v0, p1}, Lcom/google/protobuf/RepeatedFieldBuilder;->addAllMessages(Ljava/lang/Iterable;)Lcom/google/protobuf/RepeatedFieldBuilder;

    goto :goto_0
.end method

.method public addEnumType(ILcom/google/protobuf/DescriptorProtos$EnumDescriptorProto$Builder;)Lcom/google/protobuf/DescriptorProtos$DescriptorProto$Builder;
    .locals 2

    .prologue
    .line 4772
    iget-object v0, p0, Lcom/google/protobuf/DescriptorProtos$DescriptorProto$Builder;->enumTypeBuilder_:Lcom/google/protobuf/RepeatedFieldBuilder;

    if-nez v0, :cond_0

    .line 4773
    invoke-direct {p0}, Lcom/google/protobuf/DescriptorProtos$DescriptorProto$Builder;->ensureEnumTypeIsMutable()V

    .line 4774
    iget-object v0, p0, Lcom/google/protobuf/DescriptorProtos$DescriptorProto$Builder;->enumType_:Ljava/util/List;

    invoke-virtual {p2}, Lcom/google/protobuf/DescriptorProtos$EnumDescriptorProto$Builder;->build()Lcom/google/protobuf/DescriptorProtos$EnumDescriptorProto;

    move-result-object v1

    invoke-interface {v0, p1, v1}, Ljava/util/List;->add(ILjava/lang/Object;)V

    .line 4775
    invoke-virtual {p0}, Lcom/google/protobuf/DescriptorProtos$DescriptorProto$Builder;->onChanged()V

    .line 4779
    :goto_0
    return-object p0

    .line 4777
    :cond_0
    iget-object v0, p0, Lcom/google/protobuf/DescriptorProtos$DescriptorProto$Builder;->enumTypeBuilder_:Lcom/google/protobuf/RepeatedFieldBuilder;

    invoke-virtual {p2}, Lcom/google/protobuf/DescriptorProtos$EnumDescriptorProto$Builder;->build()Lcom/google/protobuf/DescriptorProtos$EnumDescriptorProto;

    move-result-object v1

    invoke-virtual {v0, p1, v1}, Lcom/google/protobuf/RepeatedFieldBuilder;->addMessage(ILcom/google/protobuf/GeneratedMessage;)Lcom/google/protobuf/RepeatedFieldBuilder;

    goto :goto_0
.end method

.method public addEnumType(ILcom/google/protobuf/DescriptorProtos$EnumDescriptorProto;)Lcom/google/protobuf/DescriptorProtos$DescriptorProto$Builder;
    .locals 1

    .prologue
    .line 4747
    iget-object v0, p0, Lcom/google/protobuf/DescriptorProtos$DescriptorProto$Builder;->enumTypeBuilder_:Lcom/google/protobuf/RepeatedFieldBuilder;

    if-nez v0, :cond_1

    .line 4748
    if-nez p2, :cond_0

    .line 4749
    new-instance v0, Ljava/lang/NullPointerException;

    invoke-direct {v0}, Ljava/lang/NullPointerException;-><init>()V

    throw v0

    .line 4751
    :cond_0
    invoke-direct {p0}, Lcom/google/protobuf/DescriptorProtos$DescriptorProto$Builder;->ensureEnumTypeIsMutable()V

    .line 4752
    iget-object v0, p0, Lcom/google/protobuf/DescriptorProtos$DescriptorProto$Builder;->enumType_:Ljava/util/List;

    invoke-interface {v0, p1, p2}, Ljava/util/List;->add(ILjava/lang/Object;)V

    .line 4753
    invoke-virtual {p0}, Lcom/google/protobuf/DescriptorProtos$DescriptorProto$Builder;->onChanged()V

    .line 4757
    :goto_0
    return-object p0

    .line 4755
    :cond_1
    iget-object v0, p0, Lcom/google/protobuf/DescriptorProtos$DescriptorProto$Builder;->enumTypeBuilder_:Lcom/google/protobuf/RepeatedFieldBuilder;

    invoke-virtual {v0, p1, p2}, Lcom/google/protobuf/RepeatedFieldBuilder;->addMessage(ILcom/google/protobuf/GeneratedMessage;)Lcom/google/protobuf/RepeatedFieldBuilder;

    goto :goto_0
.end method

.method public addEnumType(Lcom/google/protobuf/DescriptorProtos$EnumDescriptorProto$Builder;)Lcom/google/protobuf/DescriptorProtos$DescriptorProto$Builder;
    .locals 2

    .prologue
    .line 4761
    iget-object v0, p0, Lcom/google/protobuf/DescriptorProtos$DescriptorProto$Builder;->enumTypeBuilder_:Lcom/google/protobuf/RepeatedFieldBuilder;

    if-nez v0, :cond_0

    .line 4762
    invoke-direct {p0}, Lcom/google/protobuf/DescriptorProtos$DescriptorProto$Builder;->ensureEnumTypeIsMutable()V

    .line 4763
    iget-object v0, p0, Lcom/google/protobuf/DescriptorProtos$DescriptorProto$Builder;->enumType_:Ljava/util/List;

    invoke-virtual {p1}, Lcom/google/protobuf/DescriptorProtos$EnumDescriptorProto$Builder;->build()Lcom/google/protobuf/DescriptorProtos$EnumDescriptorProto;

    move-result-object v1

    invoke-interface {v0, v1}, Ljava/util/List;->add(Ljava/lang/Object;)Z

    .line 4764
    invoke-virtual {p0}, Lcom/google/protobuf/DescriptorProtos$DescriptorProto$Builder;->onChanged()V

    .line 4768
    :goto_0
    return-object p0

    .line 4766
    :cond_0
    iget-object v0, p0, Lcom/google/protobuf/DescriptorProtos$DescriptorProto$Builder;->enumTypeBuilder_:Lcom/google/protobuf/RepeatedFieldBuilder;

    invoke-virtual {p1}, Lcom/google/protobuf/DescriptorProtos$EnumDescriptorProto$Builder;->build()Lcom/google/protobuf/DescriptorProtos$EnumDescriptorProto;

    move-result-object v1

    invoke-virtual {v0, v1}, Lcom/google/protobuf/RepeatedFieldBuilder;->addMessage(Lcom/google/protobuf/GeneratedMessage;)Lcom/google/protobuf/RepeatedFieldBuilder;

    goto :goto_0
.end method

.method public addEnumType(Lcom/google/protobuf/DescriptorProtos$EnumDescriptorProto;)Lcom/google/protobuf/DescriptorProtos$DescriptorProto$Builder;
    .locals 1

    .prologue
    .line 4733
    iget-object v0, p0, Lcom/google/protobuf/DescriptorProtos$DescriptorProto$Builder;->enumTypeBuilder_:Lcom/google/protobuf/RepeatedFieldBuilder;

    if-nez v0, :cond_1

    .line 4734
    if-nez p1, :cond_0

    .line 4735
    new-instance v0, Ljava/lang/NullPointerException;

    invoke-direct {v0}, Ljava/lang/NullPointerException;-><init>()V

    throw v0

    .line 4737
    :cond_0
    invoke-direct {p0}, Lcom/google/protobuf/DescriptorProtos$DescriptorProto$Builder;->ensureEnumTypeIsMutable()V

    .line 4738
    iget-object v0, p0, Lcom/google/protobuf/DescriptorProtos$DescriptorProto$Builder;->enumType_:Ljava/util/List;

    invoke-interface {v0, p1}, Ljava/util/List;->add(Ljava/lang/Object;)Z

    .line 4739
    invoke-virtual {p0}, Lcom/google/protobuf/DescriptorProtos$DescriptorProto$Builder;->onChanged()V

    .line 4743
    :goto_0
    return-object p0

    .line 4741
    :cond_1
    iget-object v0, p0, Lcom/google/protobuf/DescriptorProtos$DescriptorProto$Builder;->enumTypeBuilder_:Lcom/google/protobuf/RepeatedFieldBuilder;

    invoke-virtual {v0, p1}, Lcom/google/protobuf/RepeatedFieldBuilder;->addMessage(Lcom/google/protobuf/GeneratedMessage;)Lcom/google/protobuf/RepeatedFieldBuilder;

    goto :goto_0
.end method

.method public addEnumTypeBuilder()Lcom/google/protobuf/DescriptorProtos$EnumDescriptorProto$Builder;
    .locals 2

    .prologue
    .line 4832
    invoke-direct {p0}, Lcom/google/protobuf/DescriptorProtos$DescriptorProto$Builder;->getEnumTypeFieldBuilder()Lcom/google/protobuf/RepeatedFieldBuilder;

    move-result-object v0

    .line 4833
    invoke-static {}, Lcom/google/protobuf/DescriptorProtos$EnumDescriptorProto;->getDefaultInstance()Lcom/google/protobuf/DescriptorProtos$EnumDescriptorProto;

    move-result-object v1

    .line 4832
    invoke-virtual {v0, v1}, Lcom/google/protobuf/RepeatedFieldBuilder;->addBuilder(Lcom/google/protobuf/GeneratedMessage;)Lcom/google/protobuf/GeneratedMessage$Builder;

    move-result-object v0

    check-cast v0, Lcom/google/protobuf/DescriptorProtos$EnumDescriptorProto$Builder;

    return-object v0
.end method

.method public addEnumTypeBuilder(I)Lcom/google/protobuf/DescriptorProtos$EnumDescriptorProto$Builder;
    .locals 2

    .prologue
    .line 4837
    invoke-direct {p0}, Lcom/google/protobuf/DescriptorProtos$DescriptorProto$Builder;->getEnumTypeFieldBuilder()Lcom/google/protobuf/RepeatedFieldBuilder;

    move-result-object v0

    .line 4838
    invoke-static {}, Lcom/google/protobuf/DescriptorProtos$EnumDescriptorProto;->getDefaultInstance()Lcom/google/protobuf/DescriptorProtos$EnumDescriptorProto;

    move-result-object v1

    .line 4837
    invoke-virtual {v0, p1, v1}, Lcom/google/protobuf/RepeatedFieldBuilder;->addBuilder(ILcom/google/protobuf/GeneratedMessage;)Lcom/google/protobuf/GeneratedMessage$Builder;

    move-result-object v0

    check-cast v0, Lcom/google/protobuf/DescriptorProtos$EnumDescriptorProto$Builder;

    return-object v0
.end method

.method public addExtension(ILcom/google/protobuf/DescriptorProtos$FieldDescriptorProto$Builder;)Lcom/google/protobuf/DescriptorProtos$DescriptorProto$Builder;
    .locals 2

    .prologue
    .line 4400
    iget-object v0, p0, Lcom/google/protobuf/DescriptorProtos$DescriptorProto$Builder;->extensionBuilder_:Lcom/google/protobuf/RepeatedFieldBuilder;

    if-nez v0, :cond_0

    .line 4401
    invoke-direct {p0}, Lcom/google/protobuf/DescriptorProtos$DescriptorProto$Builder;->ensureExtensionIsMutable()V

    .line 4402
    iget-object v0, p0, Lcom/google/protobuf/DescriptorProtos$DescriptorProto$Builder;->extension_:Ljava/util/List;

    invoke-virtual {p2}, Lcom/google/protobuf/DescriptorProtos$FieldDescriptorProto$Builder;->build()Lcom/google/protobuf/DescriptorProtos$FieldDescriptorProto;

    move-result-object v1

    invoke-interface {v0, p1, v1}, Ljava/util/List;->add(ILjava/lang/Object;)V

    .line 4403
    invoke-virtual {p0}, Lcom/google/protobuf/DescriptorProtos$DescriptorProto$Builder;->onChanged()V

    .line 4407
    :goto_0
    return-object p0

    .line 4405
    :cond_0
    iget-object v0, p0, Lcom/google/protobuf/DescriptorProtos$DescriptorProto$Builder;->extensionBuilder_:Lcom/google/protobuf/RepeatedFieldBuilder;

    invoke-virtual {p2}, Lcom/google/protobuf/DescriptorProtos$FieldDescriptorProto$Builder;->build()Lcom/google/protobuf/DescriptorProtos$FieldDescriptorProto;

    move-result-object v1

    invoke-virtual {v0, p1, v1}, Lcom/google/protobuf/RepeatedFieldBuilder;->addMessage(ILcom/google/protobuf/GeneratedMessage;)Lcom/google/protobuf/RepeatedFieldBuilder;

    goto :goto_0
.end method

.method public addExtension(ILcom/google/protobuf/DescriptorProtos$FieldDescriptorProto;)Lcom/google/protobuf/DescriptorProtos$DescriptorProto$Builder;
    .locals 1

    .prologue
    .line 4375
    iget-object v0, p0, Lcom/google/protobuf/DescriptorProtos$DescriptorProto$Builder;->extensionBuilder_:Lcom/google/protobuf/RepeatedFieldBuilder;

    if-nez v0, :cond_1

    .line 4376
    if-nez p2, :cond_0

    .line 4377
    new-instance v0, Ljava/lang/NullPointerException;

    invoke-direct {v0}, Ljava/lang/NullPointerException;-><init>()V

    throw v0

    .line 4379
    :cond_0
    invoke-direct {p0}, Lcom/google/protobuf/DescriptorProtos$DescriptorProto$Builder;->ensureExtensionIsMutable()V

    .line 4380
    iget-object v0, p0, Lcom/google/protobuf/DescriptorProtos$DescriptorProto$Builder;->extension_:Ljava/util/List;

    invoke-interface {v0, p1, p2}, Ljava/util/List;->add(ILjava/lang/Object;)V

    .line 4381
    invoke-virtual {p0}, Lcom/google/protobuf/DescriptorProtos$DescriptorProto$Builder;->onChanged()V

    .line 4385
    :goto_0
    return-object p0

    .line 4383
    :cond_1
    iget-object v0, p0, Lcom/google/protobuf/DescriptorProtos$DescriptorProto$Builder;->extensionBuilder_:Lcom/google/protobuf/RepeatedFieldBuilder;

    invoke-virtual {v0, p1, p2}, Lcom/google/protobuf/RepeatedFieldBuilder;->addMessage(ILcom/google/protobuf/GeneratedMessage;)Lcom/google/protobuf/RepeatedFieldBuilder;

    goto :goto_0
.end method

.method public addExtension(Lcom/google/protobuf/DescriptorProtos$FieldDescriptorProto$Builder;)Lcom/google/protobuf/DescriptorProtos$DescriptorProto$Builder;
    .locals 2

    .prologue
    .line 4389
    iget-object v0, p0, Lcom/google/protobuf/DescriptorProtos$DescriptorProto$Builder;->extensionBuilder_:Lcom/google/protobuf/RepeatedFieldBuilder;

    if-nez v0, :cond_0

    .line 4390
    invoke-direct {p0}, Lcom/google/protobuf/DescriptorProtos$DescriptorProto$Builder;->ensureExtensionIsMutable()V

    .line 4391
    iget-object v0, p0, Lcom/google/protobuf/DescriptorProtos$DescriptorProto$Builder;->extension_:Ljava/util/List;

    invoke-virtual {p1}, Lcom/google/protobuf/DescriptorProtos$FieldDescriptorProto$Builder;->build()Lcom/google/protobuf/DescriptorProtos$FieldDescriptorProto;

    move-result-object v1

    invoke-interface {v0, v1}, Ljava/util/List;->add(Ljava/lang/Object;)Z

    .line 4392
    invoke-virtual {p0}, Lcom/google/protobuf/DescriptorProtos$DescriptorProto$Builder;->onChanged()V

    .line 4396
    :goto_0
    return-object p0

    .line 4394
    :cond_0
    iget-object v0, p0, Lcom/google/protobuf/DescriptorProtos$DescriptorProto$Builder;->extensionBuilder_:Lcom/google/protobuf/RepeatedFieldBuilder;

    invoke-virtual {p1}, Lcom/google/protobuf/DescriptorProtos$FieldDescriptorProto$Builder;->build()Lcom/google/protobuf/DescriptorProtos$FieldDescriptorProto;

    move-result-object v1

    invoke-virtual {v0, v1}, Lcom/google/protobuf/RepeatedFieldBuilder;->addMessage(Lcom/google/protobuf/GeneratedMessage;)Lcom/google/protobuf/RepeatedFieldBuilder;

    goto :goto_0
.end method

.method public addExtension(Lcom/google/protobuf/DescriptorProtos$FieldDescriptorProto;)Lcom/google/protobuf/DescriptorProtos$DescriptorProto$Builder;
    .locals 1

    .prologue
    .line 4361
    iget-object v0, p0, Lcom/google/protobuf/DescriptorProtos$DescriptorProto$Builder;->extensionBuilder_:Lcom/google/protobuf/RepeatedFieldBuilder;

    if-nez v0, :cond_1

    .line 4362
    if-nez p1, :cond_0

    .line 4363
    new-instance v0, Ljava/lang/NullPointerException;

    invoke-direct {v0}, Ljava/lang/NullPointerException;-><init>()V

    throw v0

    .line 4365
    :cond_0
    invoke-direct {p0}, Lcom/google/protobuf/DescriptorProtos$DescriptorProto$Builder;->ensureExtensionIsMutable()V

    .line 4366
    iget-object v0, p0, Lcom/google/protobuf/DescriptorProtos$DescriptorProto$Builder;->extension_:Ljava/util/List;

    invoke-interface {v0, p1}, Ljava/util/List;->add(Ljava/lang/Object;)Z

    .line 4367
    invoke-virtual {p0}, Lcom/google/protobuf/DescriptorProtos$DescriptorProto$Builder;->onChanged()V

    .line 4371
    :goto_0
    return-object p0

    .line 4369
    :cond_1
    iget-object v0, p0, Lcom/google/protobuf/DescriptorProtos$DescriptorProto$Builder;->extensionBuilder_:Lcom/google/protobuf/RepeatedFieldBuilder;

    invoke-virtual {v0, p1}, Lcom/google/protobuf/RepeatedFieldBuilder;->addMessage(Lcom/google/protobuf/GeneratedMessage;)Lcom/google/protobuf/RepeatedFieldBuilder;

    goto :goto_0
.end method

.method public addExtensionBuilder()Lcom/google/protobuf/DescriptorProtos$FieldDescriptorProto$Builder;
    .locals 2

    .prologue
    .line 4460
    invoke-direct {p0}, Lcom/google/protobuf/DescriptorProtos$DescriptorProto$Builder;->getExtensionFieldBuilder()Lcom/google/protobuf/RepeatedFieldBuilder;

    move-result-object v0

    .line 4461
    invoke-static {}, Lcom/google/protobuf/DescriptorProtos$FieldDescriptorProto;->getDefaultInstance()Lcom/google/protobuf/DescriptorProtos$FieldDescriptorProto;

    move-result-object v1

    .line 4460
    invoke-virtual {v0, v1}, Lcom/google/protobuf/RepeatedFieldBuilder;->addBuilder(Lcom/google/protobuf/GeneratedMessage;)Lcom/google/protobuf/GeneratedMessage$Builder;

    move-result-object v0

    check-cast v0, Lcom/google/protobuf/DescriptorProtos$FieldDescriptorProto$Builder;

    return-object v0
.end method

.method public addExtensionBuilder(I)Lcom/google/protobuf/DescriptorProtos$FieldDescriptorProto$Builder;
    .locals 2

    .prologue
    .line 4465
    invoke-direct {p0}, Lcom/google/protobuf/DescriptorProtos$DescriptorProto$Builder;->getExtensionFieldBuilder()Lcom/google/protobuf/RepeatedFieldBuilder;

    move-result-object v0

    .line 4466
    invoke-static {}, Lcom/google/protobuf/DescriptorProtos$FieldDescriptorProto;->getDefaultInstance()Lcom/google/protobuf/DescriptorProtos$FieldDescriptorProto;

    move-result-object v1

    .line 4465
    invoke-virtual {v0, p1, v1}, Lcom/google/protobuf/RepeatedFieldBuilder;->addBuilder(ILcom/google/protobuf/GeneratedMessage;)Lcom/google/protobuf/GeneratedMessage$Builder;

    move-result-object v0

    check-cast v0, Lcom/google/protobuf/DescriptorProtos$FieldDescriptorProto$Builder;

    return-object v0
.end method

.method public addExtensionRange(ILcom/google/protobuf/DescriptorProtos$DescriptorProto$ExtensionRange$Builder;)Lcom/google/protobuf/DescriptorProtos$DescriptorProto$Builder;
    .locals 2

    .prologue
    .line 4958
    iget-object v0, p0, Lcom/google/protobuf/DescriptorProtos$DescriptorProto$Builder;->extensionRangeBuilder_:Lcom/google/protobuf/RepeatedFieldBuilder;

    if-nez v0, :cond_0

    .line 4959
    invoke-direct {p0}, Lcom/google/protobuf/DescriptorProtos$DescriptorProto$Builder;->ensureExtensionRangeIsMutable()V

    .line 4960
    iget-object v0, p0, Lcom/google/protobuf/DescriptorProtos$DescriptorProto$Builder;->extensionRange_:Ljava/util/List;

    invoke-virtual {p2}, Lcom/google/protobuf/DescriptorProtos$DescriptorProto$ExtensionRange$Builder;->build()Lcom/google/protobuf/DescriptorProtos$DescriptorProto$ExtensionRange;

    move-result-object v1

    invoke-interface {v0, p1, v1}, Ljava/util/List;->add(ILjava/lang/Object;)V

    .line 4961
    invoke-virtual {p0}, Lcom/google/protobuf/DescriptorProtos$DescriptorProto$Builder;->onChanged()V

    .line 4965
    :goto_0
    return-object p0

    .line 4963
    :cond_0
    iget-object v0, p0, Lcom/google/protobuf/DescriptorProtos$DescriptorProto$Builder;->extensionRangeBuilder_:Lcom/google/protobuf/RepeatedFieldBuilder;

    invoke-virtual {p2}, Lcom/google/protobuf/DescriptorProtos$DescriptorProto$ExtensionRange$Builder;->build()Lcom/google/protobuf/DescriptorProtos$DescriptorProto$ExtensionRange;

    move-result-object v1

    invoke-virtual {v0, p1, v1}, Lcom/google/protobuf/RepeatedFieldBuilder;->addMessage(ILcom/google/protobuf/GeneratedMessage;)Lcom/google/protobuf/RepeatedFieldBuilder;

    goto :goto_0
.end method

.method public addExtensionRange(ILcom/google/protobuf/DescriptorProtos$DescriptorProto$ExtensionRange;)Lcom/google/protobuf/DescriptorProtos$DescriptorProto$Builder;
    .locals 1

    .prologue
    .line 4933
    iget-object v0, p0, Lcom/google/protobuf/DescriptorProtos$DescriptorProto$Builder;->extensionRangeBuilder_:Lcom/google/protobuf/RepeatedFieldBuilder;

    if-nez v0, :cond_1

    .line 4934
    if-nez p2, :cond_0

    .line 4935
    new-instance v0, Ljava/lang/NullPointerException;

    invoke-direct {v0}, Ljava/lang/NullPointerException;-><init>()V

    throw v0

    .line 4937
    :cond_0
    invoke-direct {p0}, Lcom/google/protobuf/DescriptorProtos$DescriptorProto$Builder;->ensureExtensionRangeIsMutable()V

    .line 4938
    iget-object v0, p0, Lcom/google/protobuf/DescriptorProtos$DescriptorProto$Builder;->extensionRange_:Ljava/util/List;

    invoke-interface {v0, p1, p2}, Ljava/util/List;->add(ILjava/lang/Object;)V

    .line 4939
    invoke-virtual {p0}, Lcom/google/protobuf/DescriptorProtos$DescriptorProto$Builder;->onChanged()V

    .line 4943
    :goto_0
    return-object p0

    .line 4941
    :cond_1
    iget-object v0, p0, Lcom/google/protobuf/DescriptorProtos$DescriptorProto$Builder;->extensionRangeBuilder_:Lcom/google/protobuf/RepeatedFieldBuilder;

    invoke-virtual {v0, p1, p2}, Lcom/google/protobuf/RepeatedFieldBuilder;->addMessage(ILcom/google/protobuf/GeneratedMessage;)Lcom/google/protobuf/RepeatedFieldBuilder;

    goto :goto_0
.end method

.method public addExtensionRange(Lcom/google/protobuf/DescriptorProtos$DescriptorProto$ExtensionRange$Builder;)Lcom/google/protobuf/DescriptorProtos$DescriptorProto$Builder;
    .locals 2

    .prologue
    .line 4947
    iget-object v0, p0, Lcom/google/protobuf/DescriptorProtos$DescriptorProto$Builder;->extensionRangeBuilder_:Lcom/google/protobuf/RepeatedFieldBuilder;

    if-nez v0, :cond_0

    .line 4948
    invoke-direct {p0}, Lcom/google/protobuf/DescriptorProtos$DescriptorProto$Builder;->ensureExtensionRangeIsMutable()V

    .line 4949
    iget-object v0, p0, Lcom/google/protobuf/DescriptorProtos$DescriptorProto$Builder;->extensionRange_:Ljava/util/List;

    invoke-virtual {p1}, Lcom/google/protobuf/DescriptorProtos$DescriptorProto$ExtensionRange$Builder;->build()Lcom/google/protobuf/DescriptorProtos$DescriptorProto$ExtensionRange;

    move-result-object v1

    invoke-interface {v0, v1}, Ljava/util/List;->add(Ljava/lang/Object;)Z

    .line 4950
    invoke-virtual {p0}, Lcom/google/protobuf/DescriptorProtos$DescriptorProto$Builder;->onChanged()V

    .line 4954
    :goto_0
    return-object p0

    .line 4952
    :cond_0
    iget-object v0, p0, Lcom/google/protobuf/DescriptorProtos$DescriptorProto$Builder;->extensionRangeBuilder_:Lcom/google/protobuf/RepeatedFieldBuilder;

    invoke-virtual {p1}, Lcom/google/protobuf/DescriptorProtos$DescriptorProto$ExtensionRange$Builder;->build()Lcom/google/protobuf/DescriptorProtos$DescriptorProto$ExtensionRange;

    move-result-object v1

    invoke-virtual {v0, v1}, Lcom/google/protobuf/RepeatedFieldBuilder;->addMessage(Lcom/google/protobuf/GeneratedMessage;)Lcom/google/protobuf/RepeatedFieldBuilder;

    goto :goto_0
.end method

.method public addExtensionRange(Lcom/google/protobuf/DescriptorProtos$DescriptorProto$ExtensionRange;)Lcom/google/protobuf/DescriptorProtos$DescriptorProto$Builder;
    .locals 1

    .prologue
    .line 4919
    iget-object v0, p0, Lcom/google/protobuf/DescriptorProtos$DescriptorProto$Builder;->extensionRangeBuilder_:Lcom/google/protobuf/RepeatedFieldBuilder;

    if-nez v0, :cond_1

    .line 4920
    if-nez p1, :cond_0

    .line 4921
    new-instance v0, Ljava/lang/NullPointerException;

    invoke-direct {v0}, Ljava/lang/NullPointerException;-><init>()V

    throw v0

    .line 4923
    :cond_0
    invoke-direct {p0}, Lcom/google/protobuf/DescriptorProtos$DescriptorProto$Builder;->ensureExtensionRangeIsMutable()V

    .line 4924
    iget-object v0, p0, Lcom/google/protobuf/DescriptorProtos$DescriptorProto$Builder;->extensionRange_:Ljava/util/List;

    invoke-interface {v0, p1}, Ljava/util/List;->add(Ljava/lang/Object;)Z

    .line 4925
    invoke-virtual {p0}, Lcom/google/protobuf/DescriptorProtos$DescriptorProto$Builder;->onChanged()V

    .line 4929
    :goto_0
    return-object p0

    .line 4927
    :cond_1
    iget-object v0, p0, Lcom/google/protobuf/DescriptorProtos$DescriptorProto$Builder;->extensionRangeBuilder_:Lcom/google/protobuf/RepeatedFieldBuilder;

    invoke-virtual {v0, p1}, Lcom/google/protobuf/RepeatedFieldBuilder;->addMessage(Lcom/google/protobuf/GeneratedMessage;)Lcom/google/protobuf/RepeatedFieldBuilder;

    goto :goto_0
.end method

.method public addExtensionRangeBuilder()Lcom/google/protobuf/DescriptorProtos$DescriptorProto$ExtensionRange$Builder;
    .locals 2

    .prologue
    .line 5018
    invoke-direct {p0}, Lcom/google/protobuf/DescriptorProtos$DescriptorProto$Builder;->getExtensionRangeFieldBuilder()Lcom/google/protobuf/RepeatedFieldBuilder;

    move-result-object v0

    .line 5019
    invoke-static {}, Lcom/google/protobuf/DescriptorProtos$DescriptorProto$ExtensionRange;->getDefaultInstance()Lcom/google/protobuf/DescriptorProtos$DescriptorProto$ExtensionRange;

    move-result-object v1

    .line 5018
    invoke-virtual {v0, v1}, Lcom/google/protobuf/RepeatedFieldBuilder;->addBuilder(Lcom/google/protobuf/GeneratedMessage;)Lcom/google/protobuf/GeneratedMessage$Builder;

    move-result-object v0

    check-cast v0, Lcom/google/protobuf/DescriptorProtos$DescriptorProto$ExtensionRange$Builder;

    return-object v0
.end method

.method public addExtensionRangeBuilder(I)Lcom/google/protobuf/DescriptorProtos$DescriptorProto$ExtensionRange$Builder;
    .locals 2

    .prologue
    .line 5023
    invoke-direct {p0}, Lcom/google/protobuf/DescriptorProtos$DescriptorProto$Builder;->getExtensionRangeFieldBuilder()Lcom/google/protobuf/RepeatedFieldBuilder;

    move-result-object v0

    .line 5024
    invoke-static {}, Lcom/google/protobuf/DescriptorProtos$DescriptorProto$ExtensionRange;->getDefaultInstance()Lcom/google/protobuf/DescriptorProtos$DescriptorProto$ExtensionRange;

    move-result-object v1

    .line 5023
    invoke-virtual {v0, p1, v1}, Lcom/google/protobuf/RepeatedFieldBuilder;->addBuilder(ILcom/google/protobuf/GeneratedMessage;)Lcom/google/protobuf/GeneratedMessage$Builder;

    move-result-object v0

    check-cast v0, Lcom/google/protobuf/DescriptorProtos$DescriptorProto$ExtensionRange$Builder;

    return-object v0
.end method

.method public addField(ILcom/google/protobuf/DescriptorProtos$FieldDescriptorProto$Builder;)Lcom/google/protobuf/DescriptorProtos$DescriptorProto$Builder;
    .locals 2

    .prologue
    .line 4214
    iget-object v0, p0, Lcom/google/protobuf/DescriptorProtos$DescriptorProto$Builder;->fieldBuilder_:Lcom/google/protobuf/RepeatedFieldBuilder;

    if-nez v0, :cond_0

    .line 4215
    invoke-direct {p0}, Lcom/google/protobuf/DescriptorProtos$DescriptorProto$Builder;->ensureFieldIsMutable()V

    .line 4216
    iget-object v0, p0, Lcom/google/protobuf/DescriptorProtos$DescriptorProto$Builder;->field_:Ljava/util/List;

    invoke-virtual {p2}, Lcom/google/protobuf/DescriptorProtos$FieldDescriptorProto$Builder;->build()Lcom/google/protobuf/DescriptorProtos$FieldDescriptorProto;

    move-result-object v1

    invoke-interface {v0, p1, v1}, Ljava/util/List;->add(ILjava/lang/Object;)V

    .line 4217
    invoke-virtual {p0}, Lcom/google/protobuf/DescriptorProtos$DescriptorProto$Builder;->onChanged()V

    .line 4221
    :goto_0
    return-object p0

    .line 4219
    :cond_0
    iget-object v0, p0, Lcom/google/protobuf/DescriptorProtos$DescriptorProto$Builder;->fieldBuilder_:Lcom/google/protobuf/RepeatedFieldBuilder;

    invoke-virtual {p2}, Lcom/google/protobuf/DescriptorProtos$FieldDescriptorProto$Builder;->build()Lcom/google/protobuf/DescriptorProtos$FieldDescriptorProto;

    move-result-object v1

    invoke-virtual {v0, p1, v1}, Lcom/google/protobuf/RepeatedFieldBuilder;->addMessage(ILcom/google/protobuf/GeneratedMessage;)Lcom/google/protobuf/RepeatedFieldBuilder;

    goto :goto_0
.end method

.method public addField(ILcom/google/protobuf/DescriptorProtos$FieldDescriptorProto;)Lcom/google/protobuf/DescriptorProtos$DescriptorProto$Builder;
    .locals 1

    .prologue
    .line 4189
    iget-object v0, p0, Lcom/google/protobuf/DescriptorProtos$DescriptorProto$Builder;->fieldBuilder_:Lcom/google/protobuf/RepeatedFieldBuilder;

    if-nez v0, :cond_1

    .line 4190
    if-nez p2, :cond_0

    .line 4191
    new-instance v0, Ljava/lang/NullPointerException;

    invoke-direct {v0}, Ljava/lang/NullPointerException;-><init>()V

    throw v0

    .line 4193
    :cond_0
    invoke-direct {p0}, Lcom/google/protobuf/DescriptorProtos$DescriptorProto$Builder;->ensureFieldIsMutable()V

    .line 4194
    iget-object v0, p0, Lcom/google/protobuf/DescriptorProtos$DescriptorProto$Builder;->field_:Ljava/util/List;

    invoke-interface {v0, p1, p2}, Ljava/util/List;->add(ILjava/lang/Object;)V

    .line 4195
    invoke-virtual {p0}, Lcom/google/protobuf/DescriptorProtos$DescriptorProto$Builder;->onChanged()V

    .line 4199
    :goto_0
    return-object p0

    .line 4197
    :cond_1
    iget-object v0, p0, Lcom/google/protobuf/DescriptorProtos$DescriptorProto$Builder;->fieldBuilder_:Lcom/google/protobuf/RepeatedFieldBuilder;

    invoke-virtual {v0, p1, p2}, Lcom/google/protobuf/RepeatedFieldBuilder;->addMessage(ILcom/google/protobuf/GeneratedMessage;)Lcom/google/protobuf/RepeatedFieldBuilder;

    goto :goto_0
.end method

.method public addField(Lcom/google/protobuf/DescriptorProtos$FieldDescriptorProto$Builder;)Lcom/google/protobuf/DescriptorProtos$DescriptorProto$Builder;
    .locals 2

    .prologue
    .line 4203
    iget-object v0, p0, Lcom/google/protobuf/DescriptorProtos$DescriptorProto$Builder;->fieldBuilder_:Lcom/google/protobuf/RepeatedFieldBuilder;

    if-nez v0, :cond_0

    .line 4204
    invoke-direct {p0}, Lcom/google/protobuf/DescriptorProtos$DescriptorProto$Builder;->ensureFieldIsMutable()V

    .line 4205
    iget-object v0, p0, Lcom/google/protobuf/DescriptorProtos$DescriptorProto$Builder;->field_:Ljava/util/List;

    invoke-virtual {p1}, Lcom/google/protobuf/DescriptorProtos$FieldDescriptorProto$Builder;->build()Lcom/google/protobuf/DescriptorProtos$FieldDescriptorProto;

    move-result-object v1

    invoke-interface {v0, v1}, Ljava/util/List;->add(Ljava/lang/Object;)Z

    .line 4206
    invoke-virtual {p0}, Lcom/google/protobuf/DescriptorProtos$DescriptorProto$Builder;->onChanged()V

    .line 4210
    :goto_0
    return-object p0

    .line 4208
    :cond_0
    iget-object v0, p0, Lcom/google/protobuf/DescriptorProtos$DescriptorProto$Builder;->fieldBuilder_:Lcom/google/protobuf/RepeatedFieldBuilder;

    invoke-virtual {p1}, Lcom/google/protobuf/DescriptorProtos$FieldDescriptorProto$Builder;->build()Lcom/google/protobuf/DescriptorProtos$FieldDescriptorProto;

    move-result-object v1

    invoke-virtual {v0, v1}, Lcom/google/protobuf/RepeatedFieldBuilder;->addMessage(Lcom/google/protobuf/GeneratedMessage;)Lcom/google/protobuf/RepeatedFieldBuilder;

    goto :goto_0
.end method

.method public addField(Lcom/google/protobuf/DescriptorProtos$FieldDescriptorProto;)Lcom/google/protobuf/DescriptorProtos$DescriptorProto$Builder;
    .locals 1

    .prologue
    .line 4175
    iget-object v0, p0, Lcom/google/protobuf/DescriptorProtos$DescriptorProto$Builder;->fieldBuilder_:Lcom/google/protobuf/RepeatedFieldBuilder;

    if-nez v0, :cond_1

    .line 4176
    if-nez p1, :cond_0

    .line 4177
    new-instance v0, Ljava/lang/NullPointerException;

    invoke-direct {v0}, Ljava/lang/NullPointerException;-><init>()V

    throw v0

    .line 4179
    :cond_0
    invoke-direct {p0}, Lcom/google/protobuf/DescriptorProtos$DescriptorProto$Builder;->ensureFieldIsMutable()V

    .line 4180
    iget-object v0, p0, Lcom/google/protobuf/DescriptorProtos$DescriptorProto$Builder;->field_:Ljava/util/List;

    invoke-interface {v0, p1}, Ljava/util/List;->add(Ljava/lang/Object;)Z

    .line 4181
    invoke-virtual {p0}, Lcom/google/protobuf/DescriptorProtos$DescriptorProto$Builder;->onChanged()V

    .line 4185
    :goto_0
    return-object p0

    .line 4183
    :cond_1
    iget-object v0, p0, Lcom/google/protobuf/DescriptorProtos$DescriptorProto$Builder;->fieldBuilder_:Lcom/google/protobuf/RepeatedFieldBuilder;

    invoke-virtual {v0, p1}, Lcom/google/protobuf/RepeatedFieldBuilder;->addMessage(Lcom/google/protobuf/GeneratedMessage;)Lcom/google/protobuf/RepeatedFieldBuilder;

    goto :goto_0
.end method

.method public addFieldBuilder()Lcom/google/protobuf/DescriptorProtos$FieldDescriptorProto$Builder;
    .locals 2

    .prologue
    .line 4274
    invoke-direct {p0}, Lcom/google/protobuf/DescriptorProtos$DescriptorProto$Builder;->getFieldFieldBuilder()Lcom/google/protobuf/RepeatedFieldBuilder;

    move-result-object v0

    .line 4275
    invoke-static {}, Lcom/google/protobuf/DescriptorProtos$FieldDescriptorProto;->getDefaultInstance()Lcom/google/protobuf/DescriptorProtos$FieldDescriptorProto;

    move-result-object v1

    .line 4274
    invoke-virtual {v0, v1}, Lcom/google/protobuf/RepeatedFieldBuilder;->addBuilder(Lcom/google/protobuf/GeneratedMessage;)Lcom/google/protobuf/GeneratedMessage$Builder;

    move-result-object v0

    check-cast v0, Lcom/google/protobuf/DescriptorProtos$FieldDescriptorProto$Builder;

    return-object v0
.end method

.method public addFieldBuilder(I)Lcom/google/protobuf/DescriptorProtos$FieldDescriptorProto$Builder;
    .locals 2

    .prologue
    .line 4279
    invoke-direct {p0}, Lcom/google/protobuf/DescriptorProtos$DescriptorProto$Builder;->getFieldFieldBuilder()Lcom/google/protobuf/RepeatedFieldBuilder;

    move-result-object v0

    .line 4280
    invoke-static {}, Lcom/google/protobuf/DescriptorProtos$FieldDescriptorProto;->getDefaultInstance()Lcom/google/protobuf/DescriptorProtos$FieldDescriptorProto;

    move-result-object v1

    .line 4279
    invoke-virtual {v0, p1, v1}, Lcom/google/protobuf/RepeatedFieldBuilder;->addBuilder(ILcom/google/protobuf/GeneratedMessage;)Lcom/google/protobuf/GeneratedMessage$Builder;

    move-result-object v0

    check-cast v0, Lcom/google/protobuf/DescriptorProtos$FieldDescriptorProto$Builder;

    return-object v0
.end method

.method public addNestedType(ILcom/google/protobuf/DescriptorProtos$DescriptorProto$Builder;)Lcom/google/protobuf/DescriptorProtos$DescriptorProto$Builder;
    .locals 2

    .prologue
    .line 4586
    iget-object v0, p0, Lcom/google/protobuf/DescriptorProtos$DescriptorProto$Builder;->nestedTypeBuilder_:Lcom/google/protobuf/RepeatedFieldBuilder;

    if-nez v0, :cond_0

    .line 4587
    invoke-direct {p0}, Lcom/google/protobuf/DescriptorProtos$DescriptorProto$Builder;->ensureNestedTypeIsMutable()V

    .line 4588
    iget-object v0, p0, Lcom/google/protobuf/DescriptorProtos$DescriptorProto$Builder;->nestedType_:Ljava/util/List;

    invoke-virtual {p2}, Lcom/google/protobuf/DescriptorProtos$DescriptorProto$Builder;->build()Lcom/google/protobuf/DescriptorProtos$DescriptorProto;

    move-result-object v1

    invoke-interface {v0, p1, v1}, Ljava/util/List;->add(ILjava/lang/Object;)V

    .line 4589
    invoke-virtual {p0}, Lcom/google/protobuf/DescriptorProtos$DescriptorProto$Builder;->onChanged()V

    .line 4593
    :goto_0
    return-object p0

    .line 4591
    :cond_0
    iget-object v0, p0, Lcom/google/protobuf/DescriptorProtos$DescriptorProto$Builder;->nestedTypeBuilder_:Lcom/google/protobuf/RepeatedFieldBuilder;

    invoke-virtual {p2}, Lcom/google/protobuf/DescriptorProtos$DescriptorProto$Builder;->build()Lcom/google/protobuf/DescriptorProtos$DescriptorProto;

    move-result-object v1

    invoke-virtual {v0, p1, v1}, Lcom/google/protobuf/RepeatedFieldBuilder;->addMessage(ILcom/google/protobuf/GeneratedMessage;)Lcom/google/protobuf/RepeatedFieldBuilder;

    goto :goto_0
.end method

.method public addNestedType(ILcom/google/protobuf/DescriptorProtos$DescriptorProto;)Lcom/google/protobuf/DescriptorProtos$DescriptorProto$Builder;
    .locals 1

    .prologue
    .line 4561
    iget-object v0, p0, Lcom/google/protobuf/DescriptorProtos$DescriptorProto$Builder;->nestedTypeBuilder_:Lcom/google/protobuf/RepeatedFieldBuilder;

    if-nez v0, :cond_1

    .line 4562
    if-nez p2, :cond_0

    .line 4563
    new-instance v0, Ljava/lang/NullPointerException;

    invoke-direct {v0}, Ljava/lang/NullPointerException;-><init>()V

    throw v0

    .line 4565
    :cond_0
    invoke-direct {p0}, Lcom/google/protobuf/DescriptorProtos$DescriptorProto$Builder;->ensureNestedTypeIsMutable()V

    .line 4566
    iget-object v0, p0, Lcom/google/protobuf/DescriptorProtos$DescriptorProto$Builder;->nestedType_:Ljava/util/List;

    invoke-interface {v0, p1, p2}, Ljava/util/List;->add(ILjava/lang/Object;)V

    .line 4567
    invoke-virtual {p0}, Lcom/google/protobuf/DescriptorProtos$DescriptorProto$Builder;->onChanged()V

    .line 4571
    :goto_0
    return-object p0

    .line 4569
    :cond_1
    iget-object v0, p0, Lcom/google/protobuf/DescriptorProtos$DescriptorProto$Builder;->nestedTypeBuilder_:Lcom/google/protobuf/RepeatedFieldBuilder;

    invoke-virtual {v0, p1, p2}, Lcom/google/protobuf/RepeatedFieldBuilder;->addMessage(ILcom/google/protobuf/GeneratedMessage;)Lcom/google/protobuf/RepeatedFieldBuilder;

    goto :goto_0
.end method

.method public addNestedType(Lcom/google/protobuf/DescriptorProtos$DescriptorProto$Builder;)Lcom/google/protobuf/DescriptorProtos$DescriptorProto$Builder;
    .locals 2

    .prologue
    .line 4575
    iget-object v0, p0, Lcom/google/protobuf/DescriptorProtos$DescriptorProto$Builder;->nestedTypeBuilder_:Lcom/google/protobuf/RepeatedFieldBuilder;

    if-nez v0, :cond_0

    .line 4576
    invoke-direct {p0}, Lcom/google/protobuf/DescriptorProtos$DescriptorProto$Builder;->ensureNestedTypeIsMutable()V

    .line 4577
    iget-object v0, p0, Lcom/google/protobuf/DescriptorProtos$DescriptorProto$Builder;->nestedType_:Ljava/util/List;

    invoke-virtual {p1}, Lcom/google/protobuf/DescriptorProtos$DescriptorProto$Builder;->build()Lcom/google/protobuf/DescriptorProtos$DescriptorProto;

    move-result-object v1

    invoke-interface {v0, v1}, Ljava/util/List;->add(Ljava/lang/Object;)Z

    .line 4578
    invoke-virtual {p0}, Lcom/google/protobuf/DescriptorProtos$DescriptorProto$Builder;->onChanged()V

    .line 4582
    :goto_0
    return-object p0

    .line 4580
    :cond_0
    iget-object v0, p0, Lcom/google/protobuf/DescriptorProtos$DescriptorProto$Builder;->nestedTypeBuilder_:Lcom/google/protobuf/RepeatedFieldBuilder;

    invoke-virtual {p1}, Lcom/google/protobuf/DescriptorProtos$DescriptorProto$Builder;->build()Lcom/google/protobuf/DescriptorProtos$DescriptorProto;

    move-result-object v1

    invoke-virtual {v0, v1}, Lcom/google/protobuf/RepeatedFieldBuilder;->addMessage(Lcom/google/protobuf/GeneratedMessage;)Lcom/google/protobuf/RepeatedFieldBuilder;

    goto :goto_0
.end method

.method public addNestedType(Lcom/google/protobuf/DescriptorProtos$DescriptorProto;)Lcom/google/protobuf/DescriptorProtos$DescriptorProto$Builder;
    .locals 1

    .prologue
    .line 4547
    iget-object v0, p0, Lcom/google/protobuf/DescriptorProtos$DescriptorProto$Builder;->nestedTypeBuilder_:Lcom/google/protobuf/RepeatedFieldBuilder;

    if-nez v0, :cond_1

    .line 4548
    if-nez p1, :cond_0

    .line 4549
    new-instance v0, Ljava/lang/NullPointerException;

    invoke-direct {v0}, Ljava/lang/NullPointerException;-><init>()V

    throw v0

    .line 4551
    :cond_0
    invoke-direct {p0}, Lcom/google/protobuf/DescriptorProtos$DescriptorProto$Builder;->ensureNestedTypeIsMutable()V

    .line 4552
    iget-object v0, p0, Lcom/google/protobuf/DescriptorProtos$DescriptorProto$Builder;->nestedType_:Ljava/util/List;

    invoke-interface {v0, p1}, Ljava/util/List;->add(Ljava/lang/Object;)Z

    .line 4553
    invoke-virtual {p0}, Lcom/google/protobuf/DescriptorProtos$DescriptorProto$Builder;->onChanged()V

    .line 4557
    :goto_0
    return-object p0

    .line 4555
    :cond_1
    iget-object v0, p0, Lcom/google/protobuf/DescriptorProtos$DescriptorProto$Builder;->nestedTypeBuilder_:Lcom/google/protobuf/RepeatedFieldBuilder;

    invoke-virtual {v0, p1}, Lcom/google/protobuf/RepeatedFieldBuilder;->addMessage(Lcom/google/protobuf/GeneratedMessage;)Lcom/google/protobuf/RepeatedFieldBuilder;

    goto :goto_0
.end method

.method public addNestedTypeBuilder()Lcom/google/protobuf/DescriptorProtos$DescriptorProto$Builder;
    .locals 2

    .prologue
    .line 4646
    invoke-direct {p0}, Lcom/google/protobuf/DescriptorProtos$DescriptorProto$Builder;->getNestedTypeFieldBuilder()Lcom/google/protobuf/RepeatedFieldBuilder;

    move-result-object v0

    .line 4647
    invoke-static {}, Lcom/google/protobuf/DescriptorProtos$DescriptorProto;->getDefaultInstance()Lcom/google/protobuf/DescriptorProtos$DescriptorProto;

    move-result-object v1

    .line 4646
    invoke-virtual {v0, v1}, Lcom/google/protobuf/RepeatedFieldBuilder;->addBuilder(Lcom/google/protobuf/GeneratedMessage;)Lcom/google/protobuf/GeneratedMessage$Builder;

    move-result-object v0

    check-cast v0, Lcom/google/protobuf/DescriptorProtos$DescriptorProto$Builder;

    return-object v0
.end method

.method public addNestedTypeBuilder(I)Lcom/google/protobuf/DescriptorProtos$DescriptorProto$Builder;
    .locals 2

    .prologue
    .line 4651
    invoke-direct {p0}, Lcom/google/protobuf/DescriptorProtos$DescriptorProto$Builder;->getNestedTypeFieldBuilder()Lcom/google/protobuf/RepeatedFieldBuilder;

    move-result-object v0

    .line 4652
    invoke-static {}, Lcom/google/protobuf/DescriptorProtos$DescriptorProto;->getDefaultInstance()Lcom/google/protobuf/DescriptorProtos$DescriptorProto;

    move-result-object v1

    .line 4651
    invoke-virtual {v0, p1, v1}, Lcom/google/protobuf/RepeatedFieldBuilder;->addBuilder(ILcom/google/protobuf/GeneratedMessage;)Lcom/google/protobuf/GeneratedMessage$Builder;

    move-result-object v0

    check-cast v0, Lcom/google/protobuf/DescriptorProtos$DescriptorProto$Builder;

    return-object v0
.end method

.method public build()Lcom/google/protobuf/DescriptorProtos$DescriptorProto;
    .locals 2

    .prologue
    .line 3738
    invoke-virtual {p0}, Lcom/google/protobuf/DescriptorProtos$DescriptorProto$Builder;->buildPartial()Lcom/google/protobuf/DescriptorProtos$DescriptorProto;

    move-result-object v0

    .line 3739
    invoke-virtual {v0}, Lcom/google/protobuf/DescriptorProtos$DescriptorProto;->isInitialized()Z

    move-result v1

    if-nez v1, :cond_0

    .line 3740
    invoke-static {v0}, Lcom/google/protobuf/DescriptorProtos$DescriptorProto$Builder;->newUninitializedMessageException(Lcom/google/protobuf/Message;)Lcom/google/protobuf/UninitializedMessageException;

    move-result-object v0

    throw v0

    .line 3742
    :cond_0
    return-object v0
.end method

.method public bridge synthetic build()Lcom/google/protobuf/Message;
    .locals 1

    .prologue
    .line 1
    invoke-virtual {p0}, Lcom/google/protobuf/DescriptorProtos$DescriptorProto$Builder;->build()Lcom/google/protobuf/DescriptorProtos$DescriptorProto;

    move-result-object v0

    return-object v0
.end method

.method public bridge synthetic build()Lcom/google/protobuf/MessageLite;
    .locals 1

    .prologue
    .line 1
    invoke-virtual {p0}, Lcom/google/protobuf/DescriptorProtos$DescriptorProto$Builder;->build()Lcom/google/protobuf/DescriptorProtos$DescriptorProto;

    move-result-object v0

    return-object v0
.end method

.method public buildPartial()Lcom/google/protobuf/DescriptorProtos$DescriptorProto;
    .locals 5

    .prologue
    const/4 v0, 0x1

    .line 3756
    new-instance v2, Lcom/google/protobuf/DescriptorProtos$DescriptorProto;

    const/4 v1, 0x0

    invoke-direct {v2, p0, v1}, Lcom/google/protobuf/DescriptorProtos$DescriptorProto;-><init>(Lcom/google/protobuf/DescriptorProtos$DescriptorProto$Builder;Lcom/google/protobuf/DescriptorProtos$DescriptorProto;)V

    .line 3757
    iget v3, p0, Lcom/google/protobuf/DescriptorProtos$DescriptorProto$Builder;->bitField0_:I

    .line 3758
    const/4 v1, 0x0

    .line 3759
    and-int/lit8 v4, v3, 0x1

    if-ne v4, v0, :cond_c

    .line 3762
    :goto_0
    iget-object v1, p0, Lcom/google/protobuf/DescriptorProtos$DescriptorProto$Builder;->name_:Ljava/lang/Object;

    invoke-static {v2, v1}, Lcom/google/protobuf/DescriptorProtos$DescriptorProto;->access$8(Lcom/google/protobuf/DescriptorProtos$DescriptorProto;Ljava/lang/Object;)V

    .line 3763
    iget-object v1, p0, Lcom/google/protobuf/DescriptorProtos$DescriptorProto$Builder;->fieldBuilder_:Lcom/google/protobuf/RepeatedFieldBuilder;

    if-nez v1, :cond_5

    .line 3764
    iget v1, p0, Lcom/google/protobuf/DescriptorProtos$DescriptorProto$Builder;->bitField0_:I

    and-int/lit8 v1, v1, 0x2

    const/4 v4, 0x2

    if-ne v1, v4, :cond_0

    .line 3765
    iget-object v1, p0, Lcom/google/protobuf/DescriptorProtos$DescriptorProto$Builder;->field_:Ljava/util/List;

    invoke-static {v1}, Ljava/util/Collections;->unmodifiableList(Ljava/util/List;)Ljava/util/List;

    move-result-object v1

    iput-object v1, p0, Lcom/google/protobuf/DescriptorProtos$DescriptorProto$Builder;->field_:Ljava/util/List;

    .line 3766
    iget v1, p0, Lcom/google/protobuf/DescriptorProtos$DescriptorProto$Builder;->bitField0_:I

    and-int/lit8 v1, v1, -0x3

    iput v1, p0, Lcom/google/protobuf/DescriptorProtos$DescriptorProto$Builder;->bitField0_:I

    .line 3768
    :cond_0
    iget-object v1, p0, Lcom/google/protobuf/DescriptorProtos$DescriptorProto$Builder;->field_:Ljava/util/List;

    invoke-static {v2, v1}, Lcom/google/protobuf/DescriptorProtos$DescriptorProto;->access$9(Lcom/google/protobuf/DescriptorProtos$DescriptorProto;Ljava/util/List;)V

    .line 3772
    :goto_1
    iget-object v1, p0, Lcom/google/protobuf/DescriptorProtos$DescriptorProto$Builder;->extensionBuilder_:Lcom/google/protobuf/RepeatedFieldBuilder;

    if-nez v1, :cond_6

    .line 3773
    iget v1, p0, Lcom/google/protobuf/DescriptorProtos$DescriptorProto$Builder;->bitField0_:I

    and-int/lit8 v1, v1, 0x4

    const/4 v4, 0x4

    if-ne v1, v4, :cond_1

    .line 3774
    iget-object v1, p0, Lcom/google/protobuf/DescriptorProtos$DescriptorProto$Builder;->extension_:Ljava/util/List;

    invoke-static {v1}, Ljava/util/Collections;->unmodifiableList(Ljava/util/List;)Ljava/util/List;

    move-result-object v1

    iput-object v1, p0, Lcom/google/protobuf/DescriptorProtos$DescriptorProto$Builder;->extension_:Ljava/util/List;

    .line 3775
    iget v1, p0, Lcom/google/protobuf/DescriptorProtos$DescriptorProto$Builder;->bitField0_:I

    and-int/lit8 v1, v1, -0x5

    iput v1, p0, Lcom/google/protobuf/DescriptorProtos$DescriptorProto$Builder;->bitField0_:I

    .line 3777
    :cond_1
    iget-object v1, p0, Lcom/google/protobuf/DescriptorProtos$DescriptorProto$Builder;->extension_:Ljava/util/List;

    invoke-static {v2, v1}, Lcom/google/protobuf/DescriptorProtos$DescriptorProto;->access$10(Lcom/google/protobuf/DescriptorProtos$DescriptorProto;Ljava/util/List;)V

    .line 3781
    :goto_2
    iget-object v1, p0, Lcom/google/protobuf/DescriptorProtos$DescriptorProto$Builder;->nestedTypeBuilder_:Lcom/google/protobuf/RepeatedFieldBuilder;

    if-nez v1, :cond_7

    .line 3782
    iget v1, p0, Lcom/google/protobuf/DescriptorProtos$DescriptorProto$Builder;->bitField0_:I

    and-int/lit8 v1, v1, 0x8

    const/16 v4, 0x8

    if-ne v1, v4, :cond_2

    .line 3783
    iget-object v1, p0, Lcom/google/protobuf/DescriptorProtos$DescriptorProto$Builder;->nestedType_:Ljava/util/List;

    invoke-static {v1}, Ljava/util/Collections;->unmodifiableList(Ljava/util/List;)Ljava/util/List;

    move-result-object v1

    iput-object v1, p0, Lcom/google/protobuf/DescriptorProtos$DescriptorProto$Builder;->nestedType_:Ljava/util/List;

    .line 3784
    iget v1, p0, Lcom/google/protobuf/DescriptorProtos$DescriptorProto$Builder;->bitField0_:I

    and-int/lit8 v1, v1, -0x9

    iput v1, p0, Lcom/google/protobuf/DescriptorProtos$DescriptorProto$Builder;->bitField0_:I

    .line 3786
    :cond_2
    iget-object v1, p0, Lcom/google/protobuf/DescriptorProtos$DescriptorProto$Builder;->nestedType_:Ljava/util/List;

    invoke-static {v2, v1}, Lcom/google/protobuf/DescriptorProtos$DescriptorProto;->access$11(Lcom/google/protobuf/DescriptorProtos$DescriptorProto;Ljava/util/List;)V

    .line 3790
    :goto_3
    iget-object v1, p0, Lcom/google/protobuf/DescriptorProtos$DescriptorProto$Builder;->enumTypeBuilder_:Lcom/google/protobuf/RepeatedFieldBuilder;

    if-nez v1, :cond_8

    .line 3791
    iget v1, p0, Lcom/google/protobuf/DescriptorProtos$DescriptorProto$Builder;->bitField0_:I

    and-int/lit8 v1, v1, 0x10

    const/16 v4, 0x10

    if-ne v1, v4, :cond_3

    .line 3792
    iget-object v1, p0, Lcom/google/protobuf/DescriptorProtos$DescriptorProto$Builder;->enumType_:Ljava/util/List;

    invoke-static {v1}, Ljava/util/Collections;->unmodifiableList(Ljava/util/List;)Ljava/util/List;

    move-result-object v1

    iput-object v1, p0, Lcom/google/protobuf/DescriptorProtos$DescriptorProto$Builder;->enumType_:Ljava/util/List;

    .line 3793
    iget v1, p0, Lcom/google/protobuf/DescriptorProtos$DescriptorProto$Builder;->bitField0_:I

    and-int/lit8 v1, v1, -0x11

    iput v1, p0, Lcom/google/protobuf/DescriptorProtos$DescriptorProto$Builder;->bitField0_:I

    .line 3795
    :cond_3
    iget-object v1, p0, Lcom/google/protobuf/DescriptorProtos$DescriptorProto$Builder;->enumType_:Ljava/util/List;

    invoke-static {v2, v1}, Lcom/google/protobuf/DescriptorProtos$DescriptorProto;->access$12(Lcom/google/protobuf/DescriptorProtos$DescriptorProto;Ljava/util/List;)V

    .line 3799
    :goto_4
    iget-object v1, p0, Lcom/google/protobuf/DescriptorProtos$DescriptorProto$Builder;->extensionRangeBuilder_:Lcom/google/protobuf/RepeatedFieldBuilder;

    if-nez v1, :cond_9

    .line 3800
    iget v1, p0, Lcom/google/protobuf/DescriptorProtos$DescriptorProto$Builder;->bitField0_:I

    and-int/lit8 v1, v1, 0x20

    const/16 v4, 0x20

    if-ne v1, v4, :cond_4

    .line 3801
    iget-object v1, p0, Lcom/google/protobuf/DescriptorProtos$DescriptorProto$Builder;->extensionRange_:Ljava/util/List;

    invoke-static {v1}, Ljava/util/Collections;->unmodifiableList(Ljava/util/List;)Ljava/util/List;

    move-result-object v1

    iput-object v1, p0, Lcom/google/protobuf/DescriptorProtos$DescriptorProto$Builder;->extensionRange_:Ljava/util/List;

    .line 3802
    iget v1, p0, Lcom/google/protobuf/DescriptorProtos$DescriptorProto$Builder;->bitField0_:I

    and-int/lit8 v1, v1, -0x21

    iput v1, p0, Lcom/google/protobuf/DescriptorProtos$DescriptorProto$Builder;->bitField0_:I

    .line 3804
    :cond_4
    iget-object v1, p0, Lcom/google/protobuf/DescriptorProtos$DescriptorProto$Builder;->extensionRange_:Ljava/util/List;

    invoke-static {v2, v1}, Lcom/google/protobuf/DescriptorProtos$DescriptorProto;->access$13(Lcom/google/protobuf/DescriptorProtos$DescriptorProto;Ljava/util/List;)V

    .line 3808
    :goto_5
    and-int/lit8 v1, v3, 0x40

    const/16 v3, 0x40

    if-ne v1, v3, :cond_b

    .line 3809
    or-int/lit8 v0, v0, 0x2

    move v1, v0

    .line 3811
    :goto_6
    iget-object v0, p0, Lcom/google/protobuf/DescriptorProtos$DescriptorProto$Builder;->optionsBuilder_:Lcom/google/protobuf/SingleFieldBuilder;

    if-nez v0, :cond_a

    .line 3812
    iget-object v0, p0, Lcom/google/protobuf/DescriptorProtos$DescriptorProto$Builder;->options_:Lcom/google/protobuf/DescriptorProtos$MessageOptions;

    invoke-static {v2, v0}, Lcom/google/protobuf/DescriptorProtos$DescriptorProto;->access$14(Lcom/google/protobuf/DescriptorProtos$DescriptorProto;Lcom/google/protobuf/DescriptorProtos$MessageOptions;)V

    .line 3816
    :goto_7
    invoke-static {v2, v1}, Lcom/google/protobuf/DescriptorProtos$DescriptorProto;->access$15(Lcom/google/protobuf/DescriptorProtos$DescriptorProto;I)V

    .line 3817
    invoke-virtual {p0}, Lcom/google/protobuf/DescriptorProtos$DescriptorProto$Builder;->onBuilt()V

    .line 3818
    return-object v2

    .line 3770
    :cond_5
    iget-object v1, p0, Lcom/google/protobuf/DescriptorProtos$DescriptorProto$Builder;->fieldBuilder_:Lcom/google/protobuf/RepeatedFieldBuilder;

    invoke-virtual {v1}, Lcom/google/protobuf/RepeatedFieldBuilder;->build()Ljava/util/List;

    move-result-object v1

    invoke-static {v2, v1}, Lcom/google/protobuf/DescriptorProtos$DescriptorProto;->access$9(Lcom/google/protobuf/DescriptorProtos$DescriptorProto;Ljava/util/List;)V

    goto/16 :goto_1

    .line 3779
    :cond_6
    iget-object v1, p0, Lcom/google/protobuf/DescriptorProtos$DescriptorProto$Builder;->extensionBuilder_:Lcom/google/protobuf/RepeatedFieldBuilder;

    invoke-virtual {v1}, Lcom/google/protobuf/RepeatedFieldBuilder;->build()Ljava/util/List;

    move-result-object v1

    invoke-static {v2, v1}, Lcom/google/protobuf/DescriptorProtos$DescriptorProto;->access$10(Lcom/google/protobuf/DescriptorProtos$DescriptorProto;Ljava/util/List;)V

    goto/16 :goto_2

    .line 3788
    :cond_7
    iget-object v1, p0, Lcom/google/protobuf/DescriptorProtos$DescriptorProto$Builder;->nestedTypeBuilder_:Lcom/google/protobuf/RepeatedFieldBuilder;

    invoke-virtual {v1}, Lcom/google/protobuf/RepeatedFieldBuilder;->build()Ljava/util/List;

    move-result-object v1

    invoke-static {v2, v1}, Lcom/google/protobuf/DescriptorProtos$DescriptorProto;->access$11(Lcom/google/protobuf/DescriptorProtos$DescriptorProto;Ljava/util/List;)V

    goto :goto_3

    .line 3797
    :cond_8
    iget-object v1, p0, Lcom/google/protobuf/DescriptorProtos$DescriptorProto$Builder;->enumTypeBuilder_:Lcom/google/protobuf/RepeatedFieldBuilder;

    invoke-virtual {v1}, Lcom/google/protobuf/RepeatedFieldBuilder;->build()Ljava/util/List;

    move-result-object v1

    invoke-static {v2, v1}, Lcom/google/protobuf/DescriptorProtos$DescriptorProto;->access$12(Lcom/google/protobuf/DescriptorProtos$DescriptorProto;Ljava/util/List;)V

    goto :goto_4

    .line 3806
    :cond_9
    iget-object v1, p0, Lcom/google/protobuf/DescriptorProtos$DescriptorProto$Builder;->extensionRangeBuilder_:Lcom/google/protobuf/RepeatedFieldBuilder;

    invoke-virtual {v1}, Lcom/google/protobuf/RepeatedFieldBuilder;->build()Ljava/util/List;

    move-result-object v1

    invoke-static {v2, v1}, Lcom/google/protobuf/DescriptorProtos$DescriptorProto;->access$13(Lcom/google/protobuf/DescriptorProtos$DescriptorProto;Ljava/util/List;)V

    goto :goto_5

    .line 3814
    :cond_a
    iget-object v0, p0, Lcom/google/protobuf/DescriptorProtos$DescriptorProto$Builder;->optionsBuilder_:Lcom/google/protobuf/SingleFieldBuilder;

    invoke-virtual {v0}, Lcom/google/protobuf/SingleFieldBuilder;->build()Lcom/google/protobuf/GeneratedMessage;

    move-result-object v0

    check-cast v0, Lcom/google/protobuf/DescriptorProtos$MessageOptions;

    invoke-static {v2, v0}, Lcom/google/protobuf/DescriptorProtos$DescriptorProto;->access$14(Lcom/google/protobuf/DescriptorProtos$DescriptorProto;Lcom/google/protobuf/DescriptorProtos$MessageOptions;)V

    goto :goto_7

    :cond_b
    move v1, v0

    goto :goto_6

    :cond_c
    move v0, v1

    goto/16 :goto_0
.end method

.method public bridge synthetic buildPartial()Lcom/google/protobuf/Message;
    .locals 1

    .prologue
    .line 1
    invoke-virtual {p0}, Lcom/google/protobuf/DescriptorProtos$DescriptorProto$Builder;->buildPartial()Lcom/google/protobuf/DescriptorProtos$DescriptorProto;

    move-result-object v0

    return-object v0
.end method

.method public bridge synthetic buildPartial()Lcom/google/protobuf/MessageLite;
    .locals 1

    .prologue
    .line 1
    invoke-virtual {p0}, Lcom/google/protobuf/DescriptorProtos$DescriptorProto$Builder;->buildPartial()Lcom/google/protobuf/DescriptorProtos$DescriptorProto;

    move-result-object v0

    return-object v0
.end method

.method public clear()Lcom/google/protobuf/DescriptorProtos$DescriptorProto$Builder;
    .locals 1

    .prologue
    .line 3682
    invoke-super {p0}, Lcom/google/protobuf/GeneratedMessage$Builder;->clear()Lcom/google/protobuf/GeneratedMessage$Builder;

    .line 3683
    const-string v0, ""

    iput-object v0, p0, Lcom/google/protobuf/DescriptorProtos$DescriptorProto$Builder;->name_:Ljava/lang/Object;

    .line 3684
    iget v0, p0, Lcom/google/protobuf/DescriptorProtos$DescriptorProto$Builder;->bitField0_:I

    and-int/lit8 v0, v0, -0x2

    iput v0, p0, Lcom/google/protobuf/DescriptorProtos$DescriptorProto$Builder;->bitField0_:I

    .line 3685
    iget-object v0, p0, Lcom/google/protobuf/DescriptorProtos$DescriptorProto$Builder;->fieldBuilder_:Lcom/google/protobuf/RepeatedFieldBuilder;

    if-nez v0, :cond_0

    .line 3686
    invoke-static {}, Ljava/util/Collections;->emptyList()Ljava/util/List;

    move-result-object v0

    iput-object v0, p0, Lcom/google/protobuf/DescriptorProtos$DescriptorProto$Builder;->field_:Ljava/util/List;

    .line 3687
    iget v0, p0, Lcom/google/protobuf/DescriptorProtos$DescriptorProto$Builder;->bitField0_:I

    and-int/lit8 v0, v0, -0x3

    iput v0, p0, Lcom/google/protobuf/DescriptorProtos$DescriptorProto$Builder;->bitField0_:I

    .line 3691
    :goto_0
    iget-object v0, p0, Lcom/google/protobuf/DescriptorProtos$DescriptorProto$Builder;->extensionBuilder_:Lcom/google/protobuf/RepeatedFieldBuilder;

    if-nez v0, :cond_1

    .line 3692
    invoke-static {}, Ljava/util/Collections;->emptyList()Ljava/util/List;

    move-result-object v0

    iput-object v0, p0, Lcom/google/protobuf/DescriptorProtos$DescriptorProto$Builder;->extension_:Ljava/util/List;

    .line 3693
    iget v0, p0, Lcom/google/protobuf/DescriptorProtos$DescriptorProto$Builder;->bitField0_:I

    and-int/lit8 v0, v0, -0x5

    iput v0, p0, Lcom/google/protobuf/DescriptorProtos$DescriptorProto$Builder;->bitField0_:I

    .line 3697
    :goto_1
    iget-object v0, p0, Lcom/google/protobuf/DescriptorProtos$DescriptorProto$Builder;->nestedTypeBuilder_:Lcom/google/protobuf/RepeatedFieldBuilder;

    if-nez v0, :cond_2

    .line 3698
    invoke-static {}, Ljava/util/Collections;->emptyList()Ljava/util/List;

    move-result-object v0

    iput-object v0, p0, Lcom/google/protobuf/DescriptorProtos$DescriptorProto$Builder;->nestedType_:Ljava/util/List;

    .line 3699
    iget v0, p0, Lcom/google/protobuf/DescriptorProtos$DescriptorProto$Builder;->bitField0_:I

    and-int/lit8 v0, v0, -0x9

    iput v0, p0, Lcom/google/protobuf/DescriptorProtos$DescriptorProto$Builder;->bitField0_:I

    .line 3703
    :goto_2
    iget-object v0, p0, Lcom/google/protobuf/DescriptorProtos$DescriptorProto$Builder;->enumTypeBuilder_:Lcom/google/protobuf/RepeatedFieldBuilder;

    if-nez v0, :cond_3

    .line 3704
    invoke-static {}, Ljava/util/Collections;->emptyList()Ljava/util/List;

    move-result-object v0

    iput-object v0, p0, Lcom/google/protobuf/DescriptorProtos$DescriptorProto$Builder;->enumType_:Ljava/util/List;

    .line 3705
    iget v0, p0, Lcom/google/protobuf/DescriptorProtos$DescriptorProto$Builder;->bitField0_:I

    and-int/lit8 v0, v0, -0x11

    iput v0, p0, Lcom/google/protobuf/DescriptorProtos$DescriptorProto$Builder;->bitField0_:I

    .line 3709
    :goto_3
    iget-object v0, p0, Lcom/google/protobuf/DescriptorProtos$DescriptorProto$Builder;->extensionRangeBuilder_:Lcom/google/protobuf/RepeatedFieldBuilder;

    if-nez v0, :cond_4

    .line 3710
    invoke-static {}, Ljava/util/Collections;->emptyList()Ljava/util/List;

    move-result-object v0

    iput-object v0, p0, Lcom/google/protobuf/DescriptorProtos$DescriptorProto$Builder;->extensionRange_:Ljava/util/List;

    .line 3711
    iget v0, p0, Lcom/google/protobuf/DescriptorProtos$DescriptorProto$Builder;->bitField0_:I

    and-int/lit8 v0, v0, -0x21

    iput v0, p0, Lcom/google/protobuf/DescriptorProtos$DescriptorProto$Builder;->bitField0_:I

    .line 3715
    :goto_4
    iget-object v0, p0, Lcom/google/protobuf/DescriptorProtos$DescriptorProto$Builder;->optionsBuilder_:Lcom/google/protobuf/SingleFieldBuilder;

    if-nez v0, :cond_5

    .line 3716
    invoke-static {}, Lcom/google/protobuf/DescriptorProtos$MessageOptions;->getDefaultInstance()Lcom/google/protobuf/DescriptorProtos$MessageOptions;

    move-result-object v0

    iput-object v0, p0, Lcom/google/protobuf/DescriptorProtos$DescriptorProto$Builder;->options_:Lcom/google/protobuf/DescriptorProtos$MessageOptions;

    .line 3720
    :goto_5
    iget v0, p0, Lcom/google/protobuf/DescriptorProtos$DescriptorProto$Builder;->bitField0_:I

    and-int/lit8 v0, v0, -0x41

    iput v0, p0, Lcom/google/protobuf/DescriptorProtos$DescriptorProto$Builder;->bitField0_:I

    .line 3721
    return-object p0

    .line 3689
    :cond_0
    iget-object v0, p0, Lcom/google/protobuf/DescriptorProtos$DescriptorProto$Builder;->fieldBuilder_:Lcom/google/protobuf/RepeatedFieldBuilder;

    invoke-virtual {v0}, Lcom/google/protobuf/RepeatedFieldBuilder;->clear()V

    goto :goto_0

    .line 3695
    :cond_1
    iget-object v0, p0, Lcom/google/protobuf/DescriptorProtos$DescriptorProto$Builder;->extensionBuilder_:Lcom/google/protobuf/RepeatedFieldBuilder;

    invoke-virtual {v0}, Lcom/google/protobuf/RepeatedFieldBuilder;->clear()V

    goto :goto_1

    .line 3701
    :cond_2
    iget-object v0, p0, Lcom/google/protobuf/DescriptorProtos$DescriptorProto$Builder;->nestedTypeBuilder_:Lcom/google/protobuf/RepeatedFieldBuilder;

    invoke-virtual {v0}, Lcom/google/protobuf/RepeatedFieldBuilder;->clear()V

    goto :goto_2

    .line 3707
    :cond_3
    iget-object v0, p0, Lcom/google/protobuf/DescriptorProtos$DescriptorProto$Builder;->enumTypeBuilder_:Lcom/google/protobuf/RepeatedFieldBuilder;

    invoke-virtual {v0}, Lcom/google/protobuf/RepeatedFieldBuilder;->clear()V

    goto :goto_3

    .line 3713
    :cond_4
    iget-object v0, p0, Lcom/google/protobuf/DescriptorProtos$DescriptorProto$Builder;->extensionRangeBuilder_:Lcom/google/protobuf/RepeatedFieldBuilder;

    invoke-virtual {v0}, Lcom/google/protobuf/RepeatedFieldBuilder;->clear()V

    goto :goto_4

    .line 3718
    :cond_5
    iget-object v0, p0, Lcom/google/protobuf/DescriptorProtos$DescriptorProto$Builder;->optionsBuilder_:Lcom/google/protobuf/SingleFieldBuilder;

    invoke-virtual {v0}, Lcom/google/protobuf/SingleFieldBuilder;->clear()Lcom/google/protobuf/SingleFieldBuilder;

    goto :goto_5
.end method

.method public bridge synthetic clear()Lcom/google/protobuf/GeneratedMessage$Builder;
    .locals 1

    .prologue
    .line 1
    invoke-virtual {p0}, Lcom/google/protobuf/DescriptorProtos$DescriptorProto$Builder;->clear()Lcom/google/protobuf/DescriptorProtos$DescriptorProto$Builder;

    move-result-object v0

    return-object v0
.end method

.method public bridge synthetic clear()Lcom/google/protobuf/Message$Builder;
    .locals 1

    .prologue
    .line 1
    invoke-virtual {p0}, Lcom/google/protobuf/DescriptorProtos$DescriptorProto$Builder;->clear()Lcom/google/protobuf/DescriptorProtos$DescriptorProto$Builder;

    move-result-object v0

    return-object v0
.end method

.method public bridge synthetic clear()Lcom/google/protobuf/MessageLite$Builder;
    .locals 1

    .prologue
    .line 1
    invoke-virtual {p0}, Lcom/google/protobuf/DescriptorProtos$DescriptorProto$Builder;->clear()Lcom/google/protobuf/DescriptorProtos$DescriptorProto$Builder;

    move-result-object v0

    return-object v0
.end method

.method public clearEnumType()Lcom/google/protobuf/DescriptorProtos$DescriptorProto$Builder;
    .locals 1

    .prologue
    .line 4793
    iget-object v0, p0, Lcom/google/protobuf/DescriptorProtos$DescriptorProto$Builder;->enumTypeBuilder_:Lcom/google/protobuf/RepeatedFieldBuilder;

    if-nez v0, :cond_0

    .line 4794
    invoke-static {}, Ljava/util/Collections;->emptyList()Ljava/util/List;

    move-result-object v0

    iput-object v0, p0, Lcom/google/protobuf/DescriptorProtos$DescriptorProto$Builder;->enumType_:Ljava/util/List;

    .line 4795
    iget v0, p0, Lcom/google/protobuf/DescriptorProtos$DescriptorProto$Builder;->bitField0_:I

    and-int/lit8 v0, v0, -0x11

    iput v0, p0, Lcom/google/protobuf/DescriptorProtos$DescriptorProto$Builder;->bitField0_:I

    .line 4796
    invoke-virtual {p0}, Lcom/google/protobuf/DescriptorProtos$DescriptorProto$Builder;->onChanged()V

    .line 4800
    :goto_0
    return-object p0

    .line 4798
    :cond_0
    iget-object v0, p0, Lcom/google/protobuf/DescriptorProtos$DescriptorProto$Builder;->enumTypeBuilder_:Lcom/google/protobuf/RepeatedFieldBuilder;

    invoke-virtual {v0}, Lcom/google/protobuf/RepeatedFieldBuilder;->clear()V

    goto :goto_0
.end method

.method public clearExtension()Lcom/google/protobuf/DescriptorProtos$DescriptorProto$Builder;
    .locals 1

    .prologue
    .line 4421
    iget-object v0, p0, Lcom/google/protobuf/DescriptorProtos$DescriptorProto$Builder;->extensionBuilder_:Lcom/google/protobuf/RepeatedFieldBuilder;

    if-nez v0, :cond_0

    .line 4422
    invoke-static {}, Ljava/util/Collections;->emptyList()Ljava/util/List;

    move-result-object v0

    iput-object v0, p0, Lcom/google/protobuf/DescriptorProtos$DescriptorProto$Builder;->extension_:Ljava/util/List;

    .line 4423
    iget v0, p0, Lcom/google/protobuf/DescriptorProtos$DescriptorProto$Builder;->bitField0_:I

    and-int/lit8 v0, v0, -0x5

    iput v0, p0, Lcom/google/protobuf/DescriptorProtos$DescriptorProto$Builder;->bitField0_:I

    .line 4424
    invoke-virtual {p0}, Lcom/google/protobuf/DescriptorProtos$DescriptorProto$Builder;->onChanged()V

    .line 4428
    :goto_0
    return-object p0

    .line 4426
    :cond_0
    iget-object v0, p0, Lcom/google/protobuf/DescriptorProtos$DescriptorProto$Builder;->extensionBuilder_:Lcom/google/protobuf/RepeatedFieldBuilder;

    invoke-virtual {v0}, Lcom/google/protobuf/RepeatedFieldBuilder;->clear()V

    goto :goto_0
.end method

.method public clearExtensionRange()Lcom/google/protobuf/DescriptorProtos$DescriptorProto$Builder;
    .locals 1

    .prologue
    .line 4979
    iget-object v0, p0, Lcom/google/protobuf/DescriptorProtos$DescriptorProto$Builder;->extensionRangeBuilder_:Lcom/google/protobuf/RepeatedFieldBuilder;

    if-nez v0, :cond_0

    .line 4980
    invoke-static {}, Ljava/util/Collections;->emptyList()Ljava/util/List;

    move-result-object v0

    iput-object v0, p0, Lcom/google/protobuf/DescriptorProtos$DescriptorProto$Builder;->extensionRange_:Ljava/util/List;

    .line 4981
    iget v0, p0, Lcom/google/protobuf/DescriptorProtos$DescriptorProto$Builder;->bitField0_:I

    and-int/lit8 v0, v0, -0x21

    iput v0, p0, Lcom/google/protobuf/DescriptorProtos$DescriptorProto$Builder;->bitField0_:I

    .line 4982
    invoke-virtual {p0}, Lcom/google/protobuf/DescriptorProtos$DescriptorProto$Builder;->onChanged()V

    .line 4986
    :goto_0
    return-object p0

    .line 4984
    :cond_0
    iget-object v0, p0, Lcom/google/protobuf/DescriptorProtos$DescriptorProto$Builder;->extensionRangeBuilder_:Lcom/google/protobuf/RepeatedFieldBuilder;

    invoke-virtual {v0}, Lcom/google/protobuf/RepeatedFieldBuilder;->clear()V

    goto :goto_0
.end method

.method public clearField()Lcom/google/protobuf/DescriptorProtos$DescriptorProto$Builder;
    .locals 1

    .prologue
    .line 4235
    iget-object v0, p0, Lcom/google/protobuf/DescriptorProtos$DescriptorProto$Builder;->fieldBuilder_:Lcom/google/protobuf/RepeatedFieldBuilder;

    if-nez v0, :cond_0

    .line 4236
    invoke-static {}, Ljava/util/Collections;->emptyList()Ljava/util/List;

    move-result-object v0

    iput-object v0, p0, Lcom/google/protobuf/DescriptorProtos$DescriptorProto$Builder;->field_:Ljava/util/List;

    .line 4237
    iget v0, p0, Lcom/google/protobuf/DescriptorProtos$DescriptorProto$Builder;->bitField0_:I

    and-int/lit8 v0, v0, -0x3

    iput v0, p0, Lcom/google/protobuf/DescriptorProtos$DescriptorProto$Builder;->bitField0_:I

    .line 4238
    invoke-virtual {p0}, Lcom/google/protobuf/DescriptorProtos$DescriptorProto$Builder;->onChanged()V

    .line 4242
    :goto_0
    return-object p0

    .line 4240
    :cond_0
    iget-object v0, p0, Lcom/google/protobuf/DescriptorProtos$DescriptorProto$Builder;->fieldBuilder_:Lcom/google/protobuf/RepeatedFieldBuilder;

    invoke-virtual {v0}, Lcom/google/protobuf/RepeatedFieldBuilder;->clear()V

    goto :goto_0
.end method

.method public clearName()Lcom/google/protobuf/DescriptorProtos$DescriptorProto$Builder;
    .locals 1

    .prologue
    .line 4104
    iget v0, p0, Lcom/google/protobuf/DescriptorProtos$DescriptorProto$Builder;->bitField0_:I

    and-int/lit8 v0, v0, -0x2

    iput v0, p0, Lcom/google/protobuf/DescriptorProtos$DescriptorProto$Builder;->bitField0_:I

    .line 4105
    invoke-static {}, Lcom/google/protobuf/DescriptorProtos$DescriptorProto;->getDefaultInstance()Lcom/google/protobuf/DescriptorProtos$DescriptorProto;

    move-result-object v0

    invoke-virtual {v0}, Lcom/google/protobuf/DescriptorProtos$DescriptorProto;->getName()Ljava/lang/String;

    move-result-object v0

    iput-object v0, p0, Lcom/google/protobuf/DescriptorProtos$DescriptorProto$Builder;->name_:Ljava/lang/Object;

    .line 4106
    invoke-virtual {p0}, Lcom/google/protobuf/DescriptorProtos$DescriptorProto$Builder;->onChanged()V

    .line 4107
    return-object p0
.end method

.method public clearNestedType()Lcom/google/protobuf/DescriptorProtos$DescriptorProto$Builder;
    .locals 1

    .prologue
    .line 4607
    iget-object v0, p0, Lcom/google/protobuf/DescriptorProtos$DescriptorProto$Builder;->nestedTypeBuilder_:Lcom/google/protobuf/RepeatedFieldBuilder;

    if-nez v0, :cond_0

    .line 4608
    invoke-static {}, Ljava/util/Collections;->emptyList()Ljava/util/List;

    move-result-object v0

    iput-object v0, p0, Lcom/google/protobuf/DescriptorProtos$DescriptorProto$Builder;->nestedType_:Ljava/util/List;

    .line 4609
    iget v0, p0, Lcom/google/protobuf/DescriptorProtos$DescriptorProto$Builder;->bitField0_:I

    and-int/lit8 v0, v0, -0x9

    iput v0, p0, Lcom/google/protobuf/DescriptorProtos$DescriptorProto$Builder;->bitField0_:I

    .line 4610
    invoke-virtual {p0}, Lcom/google/protobuf/DescriptorProtos$DescriptorProto$Builder;->onChanged()V

    .line 4614
    :goto_0
    return-object p0

    .line 4612
    :cond_0
    iget-object v0, p0, Lcom/google/protobuf/DescriptorProtos$DescriptorProto$Builder;->nestedTypeBuilder_:Lcom/google/protobuf/RepeatedFieldBuilder;

    invoke-virtual {v0}, Lcom/google/protobuf/RepeatedFieldBuilder;->clear()V

    goto :goto_0
.end method

.method public clearOptions()Lcom/google/protobuf/DescriptorProtos$DescriptorProto$Builder;
    .locals 1

    .prologue
    .line 5100
    iget-object v0, p0, Lcom/google/protobuf/DescriptorProtos$DescriptorProto$Builder;->optionsBuilder_:Lcom/google/protobuf/SingleFieldBuilder;

    if-nez v0, :cond_0

    .line 5101
    invoke-static {}, Lcom/google/protobuf/DescriptorProtos$MessageOptions;->getDefaultInstance()Lcom/google/protobuf/DescriptorProtos$MessageOptions;

    move-result-object v0

    iput-object v0, p0, Lcom/google/protobuf/DescriptorProtos$DescriptorProto$Builder;->options_:Lcom/google/protobuf/DescriptorProtos$MessageOptions;

    .line 5102
    invoke-virtual {p0}, Lcom/google/protobuf/DescriptorProtos$DescriptorProto$Builder;->onChanged()V

    .line 5106
    :goto_0
    iget v0, p0, Lcom/google/protobuf/DescriptorProtos$DescriptorProto$Builder;->bitField0_:I

    and-int/lit8 v0, v0, -0x41

    iput v0, p0, Lcom/google/protobuf/DescriptorProtos$DescriptorProto$Builder;->bitField0_:I

    .line 5107
    return-object p0

    .line 5104
    :cond_0
    iget-object v0, p0, Lcom/google/protobuf/DescriptorProtos$DescriptorProto$Builder;->optionsBuilder_:Lcom/google/protobuf/SingleFieldBuilder;

    invoke-virtual {v0}, Lcom/google/protobuf/SingleFieldBuilder;->clear()Lcom/google/protobuf/SingleFieldBuilder;

    goto :goto_0
.end method

.method public clone()Lcom/google/protobuf/DescriptorProtos$DescriptorProto$Builder;
    .locals 2

    .prologue
    .line 3725
    invoke-static {}, Lcom/google/protobuf/DescriptorProtos$DescriptorProto$Builder;->create()Lcom/google/protobuf/DescriptorProtos$DescriptorProto$Builder;

    move-result-object v0

    invoke-virtual {p0}, Lcom/google/protobuf/DescriptorProtos$DescriptorProto$Builder;->buildPartial()Lcom/google/protobuf/DescriptorProtos$DescriptorProto;

    move-result-object v1

    invoke-virtual {v0, v1}, Lcom/google/protobuf/DescriptorProtos$DescriptorProto$Builder;->mergeFrom(Lcom/google/protobuf/DescriptorProtos$DescriptorProto;)Lcom/google/protobuf/DescriptorProtos$DescriptorProto$Builder;

    move-result-object v0

    return-object v0
.end method

.method public bridge synthetic clone()Lcom/google/protobuf/GeneratedMessage$Builder;
    .locals 1

    .prologue
    .line 1
    invoke-virtual {p0}, Lcom/google/protobuf/DescriptorProtos$DescriptorProto$Builder;->clone()Lcom/google/protobuf/DescriptorProtos$DescriptorProto$Builder;

    move-result-object v0

    return-object v0
.end method

.method public bridge synthetic clone()Lcom/google/protobuf/Message$Builder;
    .locals 1

    .prologue
    .line 1
    invoke-virtual {p0}, Lcom/google/protobuf/DescriptorProtos$DescriptorProto$Builder;->clone()Lcom/google/protobuf/DescriptorProtos$DescriptorProto$Builder;

    move-result-object v0

    return-object v0
.end method

.method public bridge synthetic clone()Lcom/google/protobuf/MessageLite$Builder;
    .locals 1

    .prologue
    .line 1
    invoke-virtual {p0}, Lcom/google/protobuf/DescriptorProtos$DescriptorProto$Builder;->clone()Lcom/google/protobuf/DescriptorProtos$DescriptorProto$Builder;

    move-result-object v0

    return-object v0
.end method

.method public getDefaultInstanceForType()Lcom/google/protobuf/DescriptorProtos$DescriptorProto;
    .locals 1

    .prologue
    .line 3734
    invoke-static {}, Lcom/google/protobuf/DescriptorProtos$DescriptorProto;->getDefaultInstance()Lcom/google/protobuf/DescriptorProtos$DescriptorProto;

    move-result-object v0

    return-object v0
.end method

.method public bridge synthetic getDefaultInstanceForType()Lcom/google/protobuf/Message;
    .locals 1

    .prologue
    .line 1
    invoke-virtual {p0}, Lcom/google/protobuf/DescriptorProtos$DescriptorProto$Builder;->getDefaultInstanceForType()Lcom/google/protobuf/DescriptorProtos$DescriptorProto;

    move-result-object v0

    return-object v0
.end method

.method public bridge synthetic getDefaultInstanceForType()Lcom/google/protobuf/MessageLite;
    .locals 1

    .prologue
    .line 1
    invoke-virtual {p0}, Lcom/google/protobuf/DescriptorProtos$DescriptorProto$Builder;->getDefaultInstanceForType()Lcom/google/protobuf/DescriptorProtos$DescriptorProto;

    move-result-object v0

    return-object v0
.end method

.method public getDescriptorForType()Lcom/google/protobuf/Descriptors$Descriptor;
    .locals 1

    .prologue
    .line 3730
    invoke-static {}, Lcom/google/protobuf/DescriptorProtos$DescriptorProto;->getDescriptor()Lcom/google/protobuf/Descriptors$Descriptor;

    move-result-object v0

    return-object v0
.end method

.method public getEnumType(I)Lcom/google/protobuf/DescriptorProtos$EnumDescriptorProto;
    .locals 1

    .prologue
    .line 4701
    iget-object v0, p0, Lcom/google/protobuf/DescriptorProtos$DescriptorProto$Builder;->enumTypeBuilder_:Lcom/google/protobuf/RepeatedFieldBuilder;

    if-nez v0, :cond_0

    .line 4702
    iget-object v0, p0, Lcom/google/protobuf/DescriptorProtos$DescriptorProto$Builder;->enumType_:Ljava/util/List;

    invoke-interface {v0, p1}, Ljava/util/List;->get(I)Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Lcom/google/protobuf/DescriptorProtos$EnumDescriptorProto;

    .line 4704
    :goto_0
    return-object v0

    :cond_0
    iget-object v0, p0, Lcom/google/protobuf/DescriptorProtos$DescriptorProto$Builder;->enumTypeBuilder_:Lcom/google/protobuf/RepeatedFieldBuilder;

    invoke-virtual {v0, p1}, Lcom/google/protobuf/RepeatedFieldBuilder;->getMessage(I)Lcom/google/protobuf/GeneratedMessage;

    move-result-object v0

    check-cast v0, Lcom/google/protobuf/DescriptorProtos$EnumDescriptorProto;

    goto :goto_0
.end method

.method public getEnumTypeBuilder(I)Lcom/google/protobuf/DescriptorProtos$EnumDescriptorProto$Builder;
    .locals 1

    .prologue
    .line 4814
    invoke-direct {p0}, Lcom/google/protobuf/DescriptorProtos$DescriptorProto$Builder;->getEnumTypeFieldBuilder()Lcom/google/protobuf/RepeatedFieldBuilder;

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
    .line 4842
    invoke-direct {p0}, Lcom/google/protobuf/DescriptorProtos$DescriptorProto$Builder;->getEnumTypeFieldBuilder()Lcom/google/protobuf/RepeatedFieldBuilder;

    move-result-object v0

    invoke-virtual {v0}, Lcom/google/protobuf/RepeatedFieldBuilder;->getBuilderList()Ljava/util/List;

    move-result-object v0

    return-object v0
.end method

.method public getEnumTypeCount()I
    .locals 1

    .prologue
    .line 4694
    iget-object v0, p0, Lcom/google/protobuf/DescriptorProtos$DescriptorProto$Builder;->enumTypeBuilder_:Lcom/google/protobuf/RepeatedFieldBuilder;

    if-nez v0, :cond_0

    .line 4695
    iget-object v0, p0, Lcom/google/protobuf/DescriptorProtos$DescriptorProto$Builder;->enumType_:Ljava/util/List;

    invoke-interface {v0}, Ljava/util/List;->size()I

    move-result v0

    .line 4697
    :goto_0
    return v0

    :cond_0
    iget-object v0, p0, Lcom/google/protobuf/DescriptorProtos$DescriptorProto$Builder;->enumTypeBuilder_:Lcom/google/protobuf/RepeatedFieldBuilder;

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
    .line 4687
    iget-object v0, p0, Lcom/google/protobuf/DescriptorProtos$DescriptorProto$Builder;->enumTypeBuilder_:Lcom/google/protobuf/RepeatedFieldBuilder;

    if-nez v0, :cond_0

    .line 4688
    iget-object v0, p0, Lcom/google/protobuf/DescriptorProtos$DescriptorProto$Builder;->enumType_:Ljava/util/List;

    invoke-static {v0}, Ljava/util/Collections;->unmodifiableList(Ljava/util/List;)Ljava/util/List;

    move-result-object v0

    .line 4690
    :goto_0
    return-object v0

    :cond_0
    iget-object v0, p0, Lcom/google/protobuf/DescriptorProtos$DescriptorProto$Builder;->enumTypeBuilder_:Lcom/google/protobuf/RepeatedFieldBuilder;

    invoke-virtual {v0}, Lcom/google/protobuf/RepeatedFieldBuilder;->getMessageList()Ljava/util/List;

    move-result-object v0

    goto :goto_0
.end method

.method public getEnumTypeOrBuilder(I)Lcom/google/protobuf/DescriptorProtos$EnumDescriptorProtoOrBuilder;
    .locals 1

    .prologue
    .line 4818
    iget-object v0, p0, Lcom/google/protobuf/DescriptorProtos$DescriptorProto$Builder;->enumTypeBuilder_:Lcom/google/protobuf/RepeatedFieldBuilder;

    if-nez v0, :cond_0

    .line 4819
    iget-object v0, p0, Lcom/google/protobuf/DescriptorProtos$DescriptorProto$Builder;->enumType_:Ljava/util/List;

    invoke-interface {v0, p1}, Ljava/util/List;->get(I)Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Lcom/google/protobuf/DescriptorProtos$EnumDescriptorProtoOrBuilder;

    .line 4820
    :goto_0
    return-object v0

    :cond_0
    iget-object v0, p0, Lcom/google/protobuf/DescriptorProtos$DescriptorProto$Builder;->enumTypeBuilder_:Lcom/google/protobuf/RepeatedFieldBuilder;

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
    .line 4825
    iget-object v0, p0, Lcom/google/protobuf/DescriptorProtos$DescriptorProto$Builder;->enumTypeBuilder_:Lcom/google/protobuf/RepeatedFieldBuilder;

    if-eqz v0, :cond_0

    .line 4826
    iget-object v0, p0, Lcom/google/protobuf/DescriptorProtos$DescriptorProto$Builder;->enumTypeBuilder_:Lcom/google/protobuf/RepeatedFieldBuilder;

    invoke-virtual {v0}, Lcom/google/protobuf/RepeatedFieldBuilder;->getMessageOrBuilderList()Ljava/util/List;

    move-result-object v0

    .line 4828
    :goto_0
    return-object v0

    :cond_0
    iget-object v0, p0, Lcom/google/protobuf/DescriptorProtos$DescriptorProto$Builder;->enumType_:Ljava/util/List;

    invoke-static {v0}, Ljava/util/Collections;->unmodifiableList(Ljava/util/List;)Ljava/util/List;

    move-result-object v0

    goto :goto_0
.end method

.method public getExtension(I)Lcom/google/protobuf/DescriptorProtos$FieldDescriptorProto;
    .locals 1

    .prologue
    .line 4329
    iget-object v0, p0, Lcom/google/protobuf/DescriptorProtos$DescriptorProto$Builder;->extensionBuilder_:Lcom/google/protobuf/RepeatedFieldBuilder;

    if-nez v0, :cond_0

    .line 4330
    iget-object v0, p0, Lcom/google/protobuf/DescriptorProtos$DescriptorProto$Builder;->extension_:Ljava/util/List;

    invoke-interface {v0, p1}, Ljava/util/List;->get(I)Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Lcom/google/protobuf/DescriptorProtos$FieldDescriptorProto;

    .line 4332
    :goto_0
    return-object v0

    :cond_0
    iget-object v0, p0, Lcom/google/protobuf/DescriptorProtos$DescriptorProto$Builder;->extensionBuilder_:Lcom/google/protobuf/RepeatedFieldBuilder;

    invoke-virtual {v0, p1}, Lcom/google/protobuf/RepeatedFieldBuilder;->getMessage(I)Lcom/google/protobuf/GeneratedMessage;

    move-result-object v0

    check-cast v0, Lcom/google/protobuf/DescriptorProtos$FieldDescriptorProto;

    goto :goto_0
.end method

.method public getExtensionBuilder(I)Lcom/google/protobuf/DescriptorProtos$FieldDescriptorProto$Builder;
    .locals 1

    .prologue
    .line 4442
    invoke-direct {p0}, Lcom/google/protobuf/DescriptorProtos$DescriptorProto$Builder;->getExtensionFieldBuilder()Lcom/google/protobuf/RepeatedFieldBuilder;

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
    .line 4470
    invoke-direct {p0}, Lcom/google/protobuf/DescriptorProtos$DescriptorProto$Builder;->getExtensionFieldBuilder()Lcom/google/protobuf/RepeatedFieldBuilder;

    move-result-object v0

    invoke-virtual {v0}, Lcom/google/protobuf/RepeatedFieldBuilder;->getBuilderList()Ljava/util/List;

    move-result-object v0

    return-object v0
.end method

.method public getExtensionCount()I
    .locals 1

    .prologue
    .line 4322
    iget-object v0, p0, Lcom/google/protobuf/DescriptorProtos$DescriptorProto$Builder;->extensionBuilder_:Lcom/google/protobuf/RepeatedFieldBuilder;

    if-nez v0, :cond_0

    .line 4323
    iget-object v0, p0, Lcom/google/protobuf/DescriptorProtos$DescriptorProto$Builder;->extension_:Ljava/util/List;

    invoke-interface {v0}, Ljava/util/List;->size()I

    move-result v0

    .line 4325
    :goto_0
    return v0

    :cond_0
    iget-object v0, p0, Lcom/google/protobuf/DescriptorProtos$DescriptorProto$Builder;->extensionBuilder_:Lcom/google/protobuf/RepeatedFieldBuilder;

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
    .line 4315
    iget-object v0, p0, Lcom/google/protobuf/DescriptorProtos$DescriptorProto$Builder;->extensionBuilder_:Lcom/google/protobuf/RepeatedFieldBuilder;

    if-nez v0, :cond_0

    .line 4316
    iget-object v0, p0, Lcom/google/protobuf/DescriptorProtos$DescriptorProto$Builder;->extension_:Ljava/util/List;

    invoke-static {v0}, Ljava/util/Collections;->unmodifiableList(Ljava/util/List;)Ljava/util/List;

    move-result-object v0

    .line 4318
    :goto_0
    return-object v0

    :cond_0
    iget-object v0, p0, Lcom/google/protobuf/DescriptorProtos$DescriptorProto$Builder;->extensionBuilder_:Lcom/google/protobuf/RepeatedFieldBuilder;

    invoke-virtual {v0}, Lcom/google/protobuf/RepeatedFieldBuilder;->getMessageList()Ljava/util/List;

    move-result-object v0

    goto :goto_0
.end method

.method public getExtensionOrBuilder(I)Lcom/google/protobuf/DescriptorProtos$FieldDescriptorProtoOrBuilder;
    .locals 1

    .prologue
    .line 4446
    iget-object v0, p0, Lcom/google/protobuf/DescriptorProtos$DescriptorProto$Builder;->extensionBuilder_:Lcom/google/protobuf/RepeatedFieldBuilder;

    if-nez v0, :cond_0

    .line 4447
    iget-object v0, p0, Lcom/google/protobuf/DescriptorProtos$DescriptorProto$Builder;->extension_:Ljava/util/List;

    invoke-interface {v0, p1}, Ljava/util/List;->get(I)Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Lcom/google/protobuf/DescriptorProtos$FieldDescriptorProtoOrBuilder;

    .line 4448
    :goto_0
    return-object v0

    :cond_0
    iget-object v0, p0, Lcom/google/protobuf/DescriptorProtos$DescriptorProto$Builder;->extensionBuilder_:Lcom/google/protobuf/RepeatedFieldBuilder;

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
    .line 4453
    iget-object v0, p0, Lcom/google/protobuf/DescriptorProtos$DescriptorProto$Builder;->extensionBuilder_:Lcom/google/protobuf/RepeatedFieldBuilder;

    if-eqz v0, :cond_0

    .line 4454
    iget-object v0, p0, Lcom/google/protobuf/DescriptorProtos$DescriptorProto$Builder;->extensionBuilder_:Lcom/google/protobuf/RepeatedFieldBuilder;

    invoke-virtual {v0}, Lcom/google/protobuf/RepeatedFieldBuilder;->getMessageOrBuilderList()Ljava/util/List;

    move-result-object v0

    .line 4456
    :goto_0
    return-object v0

    :cond_0
    iget-object v0, p0, Lcom/google/protobuf/DescriptorProtos$DescriptorProto$Builder;->extension_:Ljava/util/List;

    invoke-static {v0}, Ljava/util/Collections;->unmodifiableList(Ljava/util/List;)Ljava/util/List;

    move-result-object v0

    goto :goto_0
.end method

.method public getExtensionRange(I)Lcom/google/protobuf/DescriptorProtos$DescriptorProto$ExtensionRange;
    .locals 1

    .prologue
    .line 4887
    iget-object v0, p0, Lcom/google/protobuf/DescriptorProtos$DescriptorProto$Builder;->extensionRangeBuilder_:Lcom/google/protobuf/RepeatedFieldBuilder;

    if-nez v0, :cond_0

    .line 4888
    iget-object v0, p0, Lcom/google/protobuf/DescriptorProtos$DescriptorProto$Builder;->extensionRange_:Ljava/util/List;

    invoke-interface {v0, p1}, Ljava/util/List;->get(I)Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Lcom/google/protobuf/DescriptorProtos$DescriptorProto$ExtensionRange;

    .line 4890
    :goto_0
    return-object v0

    :cond_0
    iget-object v0, p0, Lcom/google/protobuf/DescriptorProtos$DescriptorProto$Builder;->extensionRangeBuilder_:Lcom/google/protobuf/RepeatedFieldBuilder;

    invoke-virtual {v0, p1}, Lcom/google/protobuf/RepeatedFieldBuilder;->getMessage(I)Lcom/google/protobuf/GeneratedMessage;

    move-result-object v0

    check-cast v0, Lcom/google/protobuf/DescriptorProtos$DescriptorProto$ExtensionRange;

    goto :goto_0
.end method

.method public getExtensionRangeBuilder(I)Lcom/google/protobuf/DescriptorProtos$DescriptorProto$ExtensionRange$Builder;
    .locals 1

    .prologue
    .line 5000
    invoke-direct {p0}, Lcom/google/protobuf/DescriptorProtos$DescriptorProto$Builder;->getExtensionRangeFieldBuilder()Lcom/google/protobuf/RepeatedFieldBuilder;

    move-result-object v0

    invoke-virtual {v0, p1}, Lcom/google/protobuf/RepeatedFieldBuilder;->getBuilder(I)Lcom/google/protobuf/GeneratedMessage$Builder;

    move-result-object v0

    check-cast v0, Lcom/google/protobuf/DescriptorProtos$DescriptorProto$ExtensionRange$Builder;

    return-object v0
.end method

.method public getExtensionRangeBuilderList()Ljava/util/List;
    .locals 1
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "()",
            "Ljava/util/List",
            "<",
            "Lcom/google/protobuf/DescriptorProtos$DescriptorProto$ExtensionRange$Builder;",
            ">;"
        }
    .end annotation

    .prologue
    .line 5028
    invoke-direct {p0}, Lcom/google/protobuf/DescriptorProtos$DescriptorProto$Builder;->getExtensionRangeFieldBuilder()Lcom/google/protobuf/RepeatedFieldBuilder;

    move-result-object v0

    invoke-virtual {v0}, Lcom/google/protobuf/RepeatedFieldBuilder;->getBuilderList()Ljava/util/List;

    move-result-object v0

    return-object v0
.end method

.method public getExtensionRangeCount()I
    .locals 1

    .prologue
    .line 4880
    iget-object v0, p0, Lcom/google/protobuf/DescriptorProtos$DescriptorProto$Builder;->extensionRangeBuilder_:Lcom/google/protobuf/RepeatedFieldBuilder;

    if-nez v0, :cond_0

    .line 4881
    iget-object v0, p0, Lcom/google/protobuf/DescriptorProtos$DescriptorProto$Builder;->extensionRange_:Ljava/util/List;

    invoke-interface {v0}, Ljava/util/List;->size()I

    move-result v0

    .line 4883
    :goto_0
    return v0

    :cond_0
    iget-object v0, p0, Lcom/google/protobuf/DescriptorProtos$DescriptorProto$Builder;->extensionRangeBuilder_:Lcom/google/protobuf/RepeatedFieldBuilder;

    invoke-virtual {v0}, Lcom/google/protobuf/RepeatedFieldBuilder;->getCount()I

    move-result v0

    goto :goto_0
.end method

.method public getExtensionRangeList()Ljava/util/List;
    .locals 1
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "()",
            "Ljava/util/List",
            "<",
            "Lcom/google/protobuf/DescriptorProtos$DescriptorProto$ExtensionRange;",
            ">;"
        }
    .end annotation

    .prologue
    .line 4873
    iget-object v0, p0, Lcom/google/protobuf/DescriptorProtos$DescriptorProto$Builder;->extensionRangeBuilder_:Lcom/google/protobuf/RepeatedFieldBuilder;

    if-nez v0, :cond_0

    .line 4874
    iget-object v0, p0, Lcom/google/protobuf/DescriptorProtos$DescriptorProto$Builder;->extensionRange_:Ljava/util/List;

    invoke-static {v0}, Ljava/util/Collections;->unmodifiableList(Ljava/util/List;)Ljava/util/List;

    move-result-object v0

    .line 4876
    :goto_0
    return-object v0

    :cond_0
    iget-object v0, p0, Lcom/google/protobuf/DescriptorProtos$DescriptorProto$Builder;->extensionRangeBuilder_:Lcom/google/protobuf/RepeatedFieldBuilder;

    invoke-virtual {v0}, Lcom/google/protobuf/RepeatedFieldBuilder;->getMessageList()Ljava/util/List;

    move-result-object v0

    goto :goto_0
.end method

.method public getExtensionRangeOrBuilder(I)Lcom/google/protobuf/DescriptorProtos$DescriptorProto$ExtensionRangeOrBuilder;
    .locals 1

    .prologue
    .line 5004
    iget-object v0, p0, Lcom/google/protobuf/DescriptorProtos$DescriptorProto$Builder;->extensionRangeBuilder_:Lcom/google/protobuf/RepeatedFieldBuilder;

    if-nez v0, :cond_0

    .line 5005
    iget-object v0, p0, Lcom/google/protobuf/DescriptorProtos$DescriptorProto$Builder;->extensionRange_:Ljava/util/List;

    invoke-interface {v0, p1}, Ljava/util/List;->get(I)Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Lcom/google/protobuf/DescriptorProtos$DescriptorProto$ExtensionRangeOrBuilder;

    .line 5006
    :goto_0
    return-object v0

    :cond_0
    iget-object v0, p0, Lcom/google/protobuf/DescriptorProtos$DescriptorProto$Builder;->extensionRangeBuilder_:Lcom/google/protobuf/RepeatedFieldBuilder;

    invoke-virtual {v0, p1}, Lcom/google/protobuf/RepeatedFieldBuilder;->getMessageOrBuilder(I)Lcom/google/protobuf/MessageOrBuilder;

    move-result-object v0

    check-cast v0, Lcom/google/protobuf/DescriptorProtos$DescriptorProto$ExtensionRangeOrBuilder;

    goto :goto_0
.end method

.method public getExtensionRangeOrBuilderList()Ljava/util/List;
    .locals 1
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "()",
            "Ljava/util/List",
            "<+",
            "Lcom/google/protobuf/DescriptorProtos$DescriptorProto$ExtensionRangeOrBuilder;",
            ">;"
        }
    .end annotation

    .prologue
    .line 5011
    iget-object v0, p0, Lcom/google/protobuf/DescriptorProtos$DescriptorProto$Builder;->extensionRangeBuilder_:Lcom/google/protobuf/RepeatedFieldBuilder;

    if-eqz v0, :cond_0

    .line 5012
    iget-object v0, p0, Lcom/google/protobuf/DescriptorProtos$DescriptorProto$Builder;->extensionRangeBuilder_:Lcom/google/protobuf/RepeatedFieldBuilder;

    invoke-virtual {v0}, Lcom/google/protobuf/RepeatedFieldBuilder;->getMessageOrBuilderList()Ljava/util/List;

    move-result-object v0

    .line 5014
    :goto_0
    return-object v0

    :cond_0
    iget-object v0, p0, Lcom/google/protobuf/DescriptorProtos$DescriptorProto$Builder;->extensionRange_:Ljava/util/List;

    invoke-static {v0}, Ljava/util/Collections;->unmodifiableList(Ljava/util/List;)Ljava/util/List;

    move-result-object v0

    goto :goto_0
.end method

.method public getField(I)Lcom/google/protobuf/DescriptorProtos$FieldDescriptorProto;
    .locals 1

    .prologue
    .line 4143
    iget-object v0, p0, Lcom/google/protobuf/DescriptorProtos$DescriptorProto$Builder;->fieldBuilder_:Lcom/google/protobuf/RepeatedFieldBuilder;

    if-nez v0, :cond_0

    .line 4144
    iget-object v0, p0, Lcom/google/protobuf/DescriptorProtos$DescriptorProto$Builder;->field_:Ljava/util/List;

    invoke-interface {v0, p1}, Ljava/util/List;->get(I)Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Lcom/google/protobuf/DescriptorProtos$FieldDescriptorProto;

    .line 4146
    :goto_0
    return-object v0

    :cond_0
    iget-object v0, p0, Lcom/google/protobuf/DescriptorProtos$DescriptorProto$Builder;->fieldBuilder_:Lcom/google/protobuf/RepeatedFieldBuilder;

    invoke-virtual {v0, p1}, Lcom/google/protobuf/RepeatedFieldBuilder;->getMessage(I)Lcom/google/protobuf/GeneratedMessage;

    move-result-object v0

    check-cast v0, Lcom/google/protobuf/DescriptorProtos$FieldDescriptorProto;

    goto :goto_0
.end method

.method public getFieldBuilder(I)Lcom/google/protobuf/DescriptorProtos$FieldDescriptorProto$Builder;
    .locals 1

    .prologue
    .line 4256
    invoke-direct {p0}, Lcom/google/protobuf/DescriptorProtos$DescriptorProto$Builder;->getFieldFieldBuilder()Lcom/google/protobuf/RepeatedFieldBuilder;

    move-result-object v0

    invoke-virtual {v0, p1}, Lcom/google/protobuf/RepeatedFieldBuilder;->getBuilder(I)Lcom/google/protobuf/GeneratedMessage$Builder;

    move-result-object v0

    check-cast v0, Lcom/google/protobuf/DescriptorProtos$FieldDescriptorProto$Builder;

    return-object v0
.end method

.method public getFieldBuilderList()Ljava/util/List;
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
    .line 4284
    invoke-direct {p0}, Lcom/google/protobuf/DescriptorProtos$DescriptorProto$Builder;->getFieldFieldBuilder()Lcom/google/protobuf/RepeatedFieldBuilder;

    move-result-object v0

    invoke-virtual {v0}, Lcom/google/protobuf/RepeatedFieldBuilder;->getBuilderList()Ljava/util/List;

    move-result-object v0

    return-object v0
.end method

.method public getFieldCount()I
    .locals 1

    .prologue
    .line 4136
    iget-object v0, p0, Lcom/google/protobuf/DescriptorProtos$DescriptorProto$Builder;->fieldBuilder_:Lcom/google/protobuf/RepeatedFieldBuilder;

    if-nez v0, :cond_0

    .line 4137
    iget-object v0, p0, Lcom/google/protobuf/DescriptorProtos$DescriptorProto$Builder;->field_:Ljava/util/List;

    invoke-interface {v0}, Ljava/util/List;->size()I

    move-result v0

    .line 4139
    :goto_0
    return v0

    :cond_0
    iget-object v0, p0, Lcom/google/protobuf/DescriptorProtos$DescriptorProto$Builder;->fieldBuilder_:Lcom/google/protobuf/RepeatedFieldBuilder;

    invoke-virtual {v0}, Lcom/google/protobuf/RepeatedFieldBuilder;->getCount()I

    move-result v0

    goto :goto_0
.end method

.method public getFieldList()Ljava/util/List;
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
    .line 4129
    iget-object v0, p0, Lcom/google/protobuf/DescriptorProtos$DescriptorProto$Builder;->fieldBuilder_:Lcom/google/protobuf/RepeatedFieldBuilder;

    if-nez v0, :cond_0

    .line 4130
    iget-object v0, p0, Lcom/google/protobuf/DescriptorProtos$DescriptorProto$Builder;->field_:Ljava/util/List;

    invoke-static {v0}, Ljava/util/Collections;->unmodifiableList(Ljava/util/List;)Ljava/util/List;

    move-result-object v0

    .line 4132
    :goto_0
    return-object v0

    :cond_0
    iget-object v0, p0, Lcom/google/protobuf/DescriptorProtos$DescriptorProto$Builder;->fieldBuilder_:Lcom/google/protobuf/RepeatedFieldBuilder;

    invoke-virtual {v0}, Lcom/google/protobuf/RepeatedFieldBuilder;->getMessageList()Ljava/util/List;

    move-result-object v0

    goto :goto_0
.end method

.method public getFieldOrBuilder(I)Lcom/google/protobuf/DescriptorProtos$FieldDescriptorProtoOrBuilder;
    .locals 1

    .prologue
    .line 4260
    iget-object v0, p0, Lcom/google/protobuf/DescriptorProtos$DescriptorProto$Builder;->fieldBuilder_:Lcom/google/protobuf/RepeatedFieldBuilder;

    if-nez v0, :cond_0

    .line 4261
    iget-object v0, p0, Lcom/google/protobuf/DescriptorProtos$DescriptorProto$Builder;->field_:Ljava/util/List;

    invoke-interface {v0, p1}, Ljava/util/List;->get(I)Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Lcom/google/protobuf/DescriptorProtos$FieldDescriptorProtoOrBuilder;

    .line 4262
    :goto_0
    return-object v0

    :cond_0
    iget-object v0, p0, Lcom/google/protobuf/DescriptorProtos$DescriptorProto$Builder;->fieldBuilder_:Lcom/google/protobuf/RepeatedFieldBuilder;

    invoke-virtual {v0, p1}, Lcom/google/protobuf/RepeatedFieldBuilder;->getMessageOrBuilder(I)Lcom/google/protobuf/MessageOrBuilder;

    move-result-object v0

    check-cast v0, Lcom/google/protobuf/DescriptorProtos$FieldDescriptorProtoOrBuilder;

    goto :goto_0
.end method

.method public getFieldOrBuilderList()Ljava/util/List;
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
    .line 4267
    iget-object v0, p0, Lcom/google/protobuf/DescriptorProtos$DescriptorProto$Builder;->fieldBuilder_:Lcom/google/protobuf/RepeatedFieldBuilder;

    if-eqz v0, :cond_0

    .line 4268
    iget-object v0, p0, Lcom/google/protobuf/DescriptorProtos$DescriptorProto$Builder;->fieldBuilder_:Lcom/google/protobuf/RepeatedFieldBuilder;

    invoke-virtual {v0}, Lcom/google/protobuf/RepeatedFieldBuilder;->getMessageOrBuilderList()Ljava/util/List;

    move-result-object v0

    .line 4270
    :goto_0
    return-object v0

    :cond_0
    iget-object v0, p0, Lcom/google/protobuf/DescriptorProtos$DescriptorProto$Builder;->field_:Ljava/util/List;

    invoke-static {v0}, Ljava/util/Collections;->unmodifiableList(Ljava/util/List;)Ljava/util/List;

    move-result-object v0

    goto :goto_0
.end method

.method public getName()Ljava/lang/String;
    .locals 2

    .prologue
    .line 4085
    iget-object v0, p0, Lcom/google/protobuf/DescriptorProtos$DescriptorProto$Builder;->name_:Ljava/lang/Object;

    .line 4086
    instance-of v1, v0, Ljava/lang/String;

    if-nez v1, :cond_0

    .line 4087
    check-cast v0, Lcom/google/protobuf/ByteString;

    invoke-virtual {v0}, Lcom/google/protobuf/ByteString;->toStringUtf8()Ljava/lang/String;

    move-result-object v0

    .line 4088
    iput-object v0, p0, Lcom/google/protobuf/DescriptorProtos$DescriptorProto$Builder;->name_:Ljava/lang/Object;

    .line 4091
    :goto_0
    return-object v0

    :cond_0
    check-cast v0, Ljava/lang/String;

    goto :goto_0
.end method

.method public getNestedType(I)Lcom/google/protobuf/DescriptorProtos$DescriptorProto;
    .locals 1

    .prologue
    .line 4515
    iget-object v0, p0, Lcom/google/protobuf/DescriptorProtos$DescriptorProto$Builder;->nestedTypeBuilder_:Lcom/google/protobuf/RepeatedFieldBuilder;

    if-nez v0, :cond_0

    .line 4516
    iget-object v0, p0, Lcom/google/protobuf/DescriptorProtos$DescriptorProto$Builder;->nestedType_:Ljava/util/List;

    invoke-interface {v0, p1}, Ljava/util/List;->get(I)Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Lcom/google/protobuf/DescriptorProtos$DescriptorProto;

    .line 4518
    :goto_0
    return-object v0

    :cond_0
    iget-object v0, p0, Lcom/google/protobuf/DescriptorProtos$DescriptorProto$Builder;->nestedTypeBuilder_:Lcom/google/protobuf/RepeatedFieldBuilder;

    invoke-virtual {v0, p1}, Lcom/google/protobuf/RepeatedFieldBuilder;->getMessage(I)Lcom/google/protobuf/GeneratedMessage;

    move-result-object v0

    check-cast v0, Lcom/google/protobuf/DescriptorProtos$DescriptorProto;

    goto :goto_0
.end method

.method public getNestedTypeBuilder(I)Lcom/google/protobuf/DescriptorProtos$DescriptorProto$Builder;
    .locals 1

    .prologue
    .line 4628
    invoke-direct {p0}, Lcom/google/protobuf/DescriptorProtos$DescriptorProto$Builder;->getNestedTypeFieldBuilder()Lcom/google/protobuf/RepeatedFieldBuilder;

    move-result-object v0

    invoke-virtual {v0, p1}, Lcom/google/protobuf/RepeatedFieldBuilder;->getBuilder(I)Lcom/google/protobuf/GeneratedMessage$Builder;

    move-result-object v0

    check-cast v0, Lcom/google/protobuf/DescriptorProtos$DescriptorProto$Builder;

    return-object v0
.end method

.method public getNestedTypeBuilderList()Ljava/util/List;
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
    .line 4656
    invoke-direct {p0}, Lcom/google/protobuf/DescriptorProtos$DescriptorProto$Builder;->getNestedTypeFieldBuilder()Lcom/google/protobuf/RepeatedFieldBuilder;

    move-result-object v0

    invoke-virtual {v0}, Lcom/google/protobuf/RepeatedFieldBuilder;->getBuilderList()Ljava/util/List;

    move-result-object v0

    return-object v0
.end method

.method public getNestedTypeCount()I
    .locals 1

    .prologue
    .line 4508
    iget-object v0, p0, Lcom/google/protobuf/DescriptorProtos$DescriptorProto$Builder;->nestedTypeBuilder_:Lcom/google/protobuf/RepeatedFieldBuilder;

    if-nez v0, :cond_0

    .line 4509
    iget-object v0, p0, Lcom/google/protobuf/DescriptorProtos$DescriptorProto$Builder;->nestedType_:Ljava/util/List;

    invoke-interface {v0}, Ljava/util/List;->size()I

    move-result v0

    .line 4511
    :goto_0
    return v0

    :cond_0
    iget-object v0, p0, Lcom/google/protobuf/DescriptorProtos$DescriptorProto$Builder;->nestedTypeBuilder_:Lcom/google/protobuf/RepeatedFieldBuilder;

    invoke-virtual {v0}, Lcom/google/protobuf/RepeatedFieldBuilder;->getCount()I

    move-result v0

    goto :goto_0
.end method

.method public getNestedTypeList()Ljava/util/List;
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
    .line 4501
    iget-object v0, p0, Lcom/google/protobuf/DescriptorProtos$DescriptorProto$Builder;->nestedTypeBuilder_:Lcom/google/protobuf/RepeatedFieldBuilder;

    if-nez v0, :cond_0

    .line 4502
    iget-object v0, p0, Lcom/google/protobuf/DescriptorProtos$DescriptorProto$Builder;->nestedType_:Ljava/util/List;

    invoke-static {v0}, Ljava/util/Collections;->unmodifiableList(Ljava/util/List;)Ljava/util/List;

    move-result-object v0

    .line 4504
    :goto_0
    return-object v0

    :cond_0
    iget-object v0, p0, Lcom/google/protobuf/DescriptorProtos$DescriptorProto$Builder;->nestedTypeBuilder_:Lcom/google/protobuf/RepeatedFieldBuilder;

    invoke-virtual {v0}, Lcom/google/protobuf/RepeatedFieldBuilder;->getMessageList()Ljava/util/List;

    move-result-object v0

    goto :goto_0
.end method

.method public getNestedTypeOrBuilder(I)Lcom/google/protobuf/DescriptorProtos$DescriptorProtoOrBuilder;
    .locals 1

    .prologue
    .line 4632
    iget-object v0, p0, Lcom/google/protobuf/DescriptorProtos$DescriptorProto$Builder;->nestedTypeBuilder_:Lcom/google/protobuf/RepeatedFieldBuilder;

    if-nez v0, :cond_0

    .line 4633
    iget-object v0, p0, Lcom/google/protobuf/DescriptorProtos$DescriptorProto$Builder;->nestedType_:Ljava/util/List;

    invoke-interface {v0, p1}, Ljava/util/List;->get(I)Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Lcom/google/protobuf/DescriptorProtos$DescriptorProtoOrBuilder;

    .line 4634
    :goto_0
    return-object v0

    :cond_0
    iget-object v0, p0, Lcom/google/protobuf/DescriptorProtos$DescriptorProto$Builder;->nestedTypeBuilder_:Lcom/google/protobuf/RepeatedFieldBuilder;

    invoke-virtual {v0, p1}, Lcom/google/protobuf/RepeatedFieldBuilder;->getMessageOrBuilder(I)Lcom/google/protobuf/MessageOrBuilder;

    move-result-object v0

    check-cast v0, Lcom/google/protobuf/DescriptorProtos$DescriptorProtoOrBuilder;

    goto :goto_0
.end method

.method public getNestedTypeOrBuilderList()Ljava/util/List;
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
    .line 4639
    iget-object v0, p0, Lcom/google/protobuf/DescriptorProtos$DescriptorProto$Builder;->nestedTypeBuilder_:Lcom/google/protobuf/RepeatedFieldBuilder;

    if-eqz v0, :cond_0

    .line 4640
    iget-object v0, p0, Lcom/google/protobuf/DescriptorProtos$DescriptorProto$Builder;->nestedTypeBuilder_:Lcom/google/protobuf/RepeatedFieldBuilder;

    invoke-virtual {v0}, Lcom/google/protobuf/RepeatedFieldBuilder;->getMessageOrBuilderList()Ljava/util/List;

    move-result-object v0

    .line 4642
    :goto_0
    return-object v0

    :cond_0
    iget-object v0, p0, Lcom/google/protobuf/DescriptorProtos$DescriptorProto$Builder;->nestedType_:Ljava/util/List;

    invoke-static {v0}, Ljava/util/Collections;->unmodifiableList(Ljava/util/List;)Ljava/util/List;

    move-result-object v0

    goto :goto_0
.end method

.method public getOptions()Lcom/google/protobuf/DescriptorProtos$MessageOptions;
    .locals 1

    .prologue
    .line 5053
    iget-object v0, p0, Lcom/google/protobuf/DescriptorProtos$DescriptorProto$Builder;->optionsBuilder_:Lcom/google/protobuf/SingleFieldBuilder;

    if-nez v0, :cond_0

    .line 5054
    iget-object v0, p0, Lcom/google/protobuf/DescriptorProtos$DescriptorProto$Builder;->options_:Lcom/google/protobuf/DescriptorProtos$MessageOptions;

    .line 5056
    :goto_0
    return-object v0

    :cond_0
    iget-object v0, p0, Lcom/google/protobuf/DescriptorProtos$DescriptorProto$Builder;->optionsBuilder_:Lcom/google/protobuf/SingleFieldBuilder;

    invoke-virtual {v0}, Lcom/google/protobuf/SingleFieldBuilder;->getMessage()Lcom/google/protobuf/GeneratedMessage;

    move-result-object v0

    check-cast v0, Lcom/google/protobuf/DescriptorProtos$MessageOptions;

    goto :goto_0
.end method

.method public getOptionsBuilder()Lcom/google/protobuf/DescriptorProtos$MessageOptions$Builder;
    .locals 1

    .prologue
    .line 5110
    iget v0, p0, Lcom/google/protobuf/DescriptorProtos$DescriptorProto$Builder;->bitField0_:I

    or-int/lit8 v0, v0, 0x40

    iput v0, p0, Lcom/google/protobuf/DescriptorProtos$DescriptorProto$Builder;->bitField0_:I

    .line 5111
    invoke-virtual {p0}, Lcom/google/protobuf/DescriptorProtos$DescriptorProto$Builder;->onChanged()V

    .line 5112
    invoke-direct {p0}, Lcom/google/protobuf/DescriptorProtos$DescriptorProto$Builder;->getOptionsFieldBuilder()Lcom/google/protobuf/SingleFieldBuilder;

    move-result-object v0

    invoke-virtual {v0}, Lcom/google/protobuf/SingleFieldBuilder;->getBuilder()Lcom/google/protobuf/GeneratedMessage$Builder;

    move-result-object v0

    check-cast v0, Lcom/google/protobuf/DescriptorProtos$MessageOptions$Builder;

    return-object v0
.end method

.method public getOptionsOrBuilder()Lcom/google/protobuf/DescriptorProtos$MessageOptionsOrBuilder;
    .locals 1

    .prologue
    .line 5115
    iget-object v0, p0, Lcom/google/protobuf/DescriptorProtos$DescriptorProto$Builder;->optionsBuilder_:Lcom/google/protobuf/SingleFieldBuilder;

    if-eqz v0, :cond_0

    .line 5116
    iget-object v0, p0, Lcom/google/protobuf/DescriptorProtos$DescriptorProto$Builder;->optionsBuilder_:Lcom/google/protobuf/SingleFieldBuilder;

    invoke-virtual {v0}, Lcom/google/protobuf/SingleFieldBuilder;->getMessageOrBuilder()Lcom/google/protobuf/MessageOrBuilder;

    move-result-object v0

    check-cast v0, Lcom/google/protobuf/DescriptorProtos$MessageOptionsOrBuilder;

    .line 5118
    :goto_0
    return-object v0

    :cond_0
    iget-object v0, p0, Lcom/google/protobuf/DescriptorProtos$DescriptorProto$Builder;->options_:Lcom/google/protobuf/DescriptorProtos$MessageOptions;

    goto :goto_0
.end method

.method public hasName()Z
    .locals 2

    .prologue
    const/4 v0, 0x1

    .line 4082
    iget v1, p0, Lcom/google/protobuf/DescriptorProtos$DescriptorProto$Builder;->bitField0_:I

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
    .line 5050
    iget v0, p0, Lcom/google/protobuf/DescriptorProtos$DescriptorProto$Builder;->bitField0_:I

    and-int/lit8 v0, v0, 0x40

    const/16 v1, 0x40

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
    .line 3655
    invoke-static {}, Lcom/google/protobuf/DescriptorProtos;->access$64()Lcom/google/protobuf/GeneratedMessage$FieldAccessorTable;

    move-result-object v0

    return-object v0
.end method

.method public final isInitialized()Z
    .locals 3

    .prologue
    const/4 v1, 0x0

    .line 3973
    move v0, v1

    :goto_0
    invoke-virtual {p0}, Lcom/google/protobuf/DescriptorProtos$DescriptorProto$Builder;->getFieldCount()I

    move-result v2

    if-lt v0, v2, :cond_1

    move v0, v1

    .line 3979
    :goto_1
    invoke-virtual {p0}, Lcom/google/protobuf/DescriptorProtos$DescriptorProto$Builder;->getExtensionCount()I

    move-result v2

    if-lt v0, v2, :cond_2

    move v0, v1

    .line 3985
    :goto_2
    invoke-virtual {p0}, Lcom/google/protobuf/DescriptorProtos$DescriptorProto$Builder;->getNestedTypeCount()I

    move-result v2

    if-lt v0, v2, :cond_3

    move v0, v1

    .line 3991
    :goto_3
    invoke-virtual {p0}, Lcom/google/protobuf/DescriptorProtos$DescriptorProto$Builder;->getEnumTypeCount()I

    move-result v2

    if-lt v0, v2, :cond_4

    .line 3997
    invoke-virtual {p0}, Lcom/google/protobuf/DescriptorProtos$DescriptorProto$Builder;->hasOptions()Z

    move-result v0

    if-eqz v0, :cond_5

    .line 3998
    invoke-virtual {p0}, Lcom/google/protobuf/DescriptorProtos$DescriptorProto$Builder;->getOptions()Lcom/google/protobuf/DescriptorProtos$MessageOptions;

    move-result-object v0

    invoke-virtual {v0}, Lcom/google/protobuf/DescriptorProtos$MessageOptions;->isInitialized()Z

    move-result v0

    if-nez v0, :cond_5

    .line 4003
    :cond_0
    :goto_4
    return v1

    .line 3974
    :cond_1
    invoke-virtual {p0, v0}, Lcom/google/protobuf/DescriptorProtos$DescriptorProto$Builder;->getField(I)Lcom/google/protobuf/DescriptorProtos$FieldDescriptorProto;

    move-result-object v2

    invoke-virtual {v2}, Lcom/google/protobuf/DescriptorProtos$FieldDescriptorProto;->isInitialized()Z

    move-result v2

    if-eqz v2, :cond_0

    .line 3973
    add-int/lit8 v0, v0, 0x1

    goto :goto_0

    .line 3980
    :cond_2
    invoke-virtual {p0, v0}, Lcom/google/protobuf/DescriptorProtos$DescriptorProto$Builder;->getExtension(I)Lcom/google/protobuf/DescriptorProtos$FieldDescriptorProto;

    move-result-object v2

    invoke-virtual {v2}, Lcom/google/protobuf/DescriptorProtos$FieldDescriptorProto;->isInitialized()Z

    move-result v2

    if-eqz v2, :cond_0

    .line 3979
    add-int/lit8 v0, v0, 0x1

    goto :goto_1

    .line 3986
    :cond_3
    invoke-virtual {p0, v0}, Lcom/google/protobuf/DescriptorProtos$DescriptorProto$Builder;->getNestedType(I)Lcom/google/protobuf/DescriptorProtos$DescriptorProto;

    move-result-object v2

    invoke-virtual {v2}, Lcom/google/protobuf/DescriptorProtos$DescriptorProto;->isInitialized()Z

    move-result v2

    if-eqz v2, :cond_0

    .line 3985
    add-int/lit8 v0, v0, 0x1

    goto :goto_2

    .line 3992
    :cond_4
    invoke-virtual {p0, v0}, Lcom/google/protobuf/DescriptorProtos$DescriptorProto$Builder;->getEnumType(I)Lcom/google/protobuf/DescriptorProtos$EnumDescriptorProto;

    move-result-object v2

    invoke-virtual {v2}, Lcom/google/protobuf/DescriptorProtos$EnumDescriptorProto;->isInitialized()Z

    move-result v2

    if-eqz v2, :cond_0

    .line 3991
    add-int/lit8 v0, v0, 0x1

    goto :goto_3

    .line 4003
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
    invoke-virtual {p0, p1, p2}, Lcom/google/protobuf/DescriptorProtos$DescriptorProto$Builder;->mergeFrom(Lcom/google/protobuf/CodedInputStream;Lcom/google/protobuf/ExtensionRegistryLite;)Lcom/google/protobuf/DescriptorProtos$DescriptorProto$Builder;

    move-result-object v0

    return-object v0
.end method

.method public bridge synthetic mergeFrom(Lcom/google/protobuf/Message;)Lcom/google/protobuf/AbstractMessage$Builder;
    .locals 1

    .prologue
    .line 1
    invoke-virtual {p0, p1}, Lcom/google/protobuf/DescriptorProtos$DescriptorProto$Builder;->mergeFrom(Lcom/google/protobuf/Message;)Lcom/google/protobuf/DescriptorProtos$DescriptorProto$Builder;

    move-result-object v0

    return-object v0
.end method

.method public mergeFrom(Lcom/google/protobuf/CodedInputStream;Lcom/google/protobuf/ExtensionRegistryLite;)Lcom/google/protobuf/DescriptorProtos$DescriptorProto$Builder;
    .locals 3
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljava/io/IOException;
        }
    .end annotation

    .prologue
    .line 4012
    invoke-virtual {p0}, Lcom/google/protobuf/DescriptorProtos$DescriptorProto$Builder;->getUnknownFields()Lcom/google/protobuf/UnknownFieldSet;

    move-result-object v0

    .line 4011
    invoke-static {v0}, Lcom/google/protobuf/UnknownFieldSet;->newBuilder(Lcom/google/protobuf/UnknownFieldSet;)Lcom/google/protobuf/UnknownFieldSet$Builder;

    move-result-object v0

    .line 4014
    :cond_0
    :goto_0
    invoke-virtual {p1}, Lcom/google/protobuf/CodedInputStream;->readTag()I

    move-result v1

    .line 4015
    sparse-switch v1, :sswitch_data_0

    .line 4021
    invoke-virtual {p0, p1, v0, p2, v1}, Lcom/google/protobuf/DescriptorProtos$DescriptorProto$Builder;->parseUnknownField(Lcom/google/protobuf/CodedInputStream;Lcom/google/protobuf/UnknownFieldSet$Builder;Lcom/google/protobuf/ExtensionRegistryLite;I)Z

    move-result v1

    if-nez v1, :cond_0

    .line 4023
    invoke-virtual {v0}, Lcom/google/protobuf/UnknownFieldSet$Builder;->build()Lcom/google/protobuf/UnknownFieldSet;

    move-result-object v0

    invoke-virtual {p0, v0}, Lcom/google/protobuf/DescriptorProtos$DescriptorProto$Builder;->setUnknownFields(Lcom/google/protobuf/UnknownFieldSet;)Lcom/google/protobuf/GeneratedMessage$Builder;

    .line 4024
    invoke-virtual {p0}, Lcom/google/protobuf/DescriptorProtos$DescriptorProto$Builder;->onChanged()V

    .line 4025
    :goto_1
    return-object p0

    .line 4017
    :sswitch_0
    invoke-virtual {v0}, Lcom/google/protobuf/UnknownFieldSet$Builder;->build()Lcom/google/protobuf/UnknownFieldSet;

    move-result-object v0

    invoke-virtual {p0, v0}, Lcom/google/protobuf/DescriptorProtos$DescriptorProto$Builder;->setUnknownFields(Lcom/google/protobuf/UnknownFieldSet;)Lcom/google/protobuf/GeneratedMessage$Builder;

    .line 4018
    invoke-virtual {p0}, Lcom/google/protobuf/DescriptorProtos$DescriptorProto$Builder;->onChanged()V

    goto :goto_1

    .line 4030
    :sswitch_1
    iget v1, p0, Lcom/google/protobuf/DescriptorProtos$DescriptorProto$Builder;->bitField0_:I

    or-int/lit8 v1, v1, 0x1

    iput v1, p0, Lcom/google/protobuf/DescriptorProtos$DescriptorProto$Builder;->bitField0_:I

    .line 4031
    invoke-virtual {p1}, Lcom/google/protobuf/CodedInputStream;->readBytes()Lcom/google/protobuf/ByteString;

    move-result-object v1

    iput-object v1, p0, Lcom/google/protobuf/DescriptorProtos$DescriptorProto$Builder;->name_:Ljava/lang/Object;

    goto :goto_0

    .line 4035
    :sswitch_2
    invoke-static {}, Lcom/google/protobuf/DescriptorProtos$FieldDescriptorProto;->newBuilder()Lcom/google/protobuf/DescriptorProtos$FieldDescriptorProto$Builder;

    move-result-object v1

    .line 4036
    invoke-virtual {p1, v1, p2}, Lcom/google/protobuf/CodedInputStream;->readMessage(Lcom/google/protobuf/MessageLite$Builder;Lcom/google/protobuf/ExtensionRegistryLite;)V

    .line 4037
    invoke-virtual {v1}, Lcom/google/protobuf/DescriptorProtos$FieldDescriptorProto$Builder;->buildPartial()Lcom/google/protobuf/DescriptorProtos$FieldDescriptorProto;

    move-result-object v1

    invoke-virtual {p0, v1}, Lcom/google/protobuf/DescriptorProtos$DescriptorProto$Builder;->addField(Lcom/google/protobuf/DescriptorProtos$FieldDescriptorProto;)Lcom/google/protobuf/DescriptorProtos$DescriptorProto$Builder;

    goto :goto_0

    .line 4041
    :sswitch_3
    invoke-static {}, Lcom/google/protobuf/DescriptorProtos$DescriptorProto;->newBuilder()Lcom/google/protobuf/DescriptorProtos$DescriptorProto$Builder;

    move-result-object v1

    .line 4042
    invoke-virtual {p1, v1, p2}, Lcom/google/protobuf/CodedInputStream;->readMessage(Lcom/google/protobuf/MessageLite$Builder;Lcom/google/protobuf/ExtensionRegistryLite;)V

    .line 4043
    invoke-virtual {v1}, Lcom/google/protobuf/DescriptorProtos$DescriptorProto$Builder;->buildPartial()Lcom/google/protobuf/DescriptorProtos$DescriptorProto;

    move-result-object v1

    invoke-virtual {p0, v1}, Lcom/google/protobuf/DescriptorProtos$DescriptorProto$Builder;->addNestedType(Lcom/google/protobuf/DescriptorProtos$DescriptorProto;)Lcom/google/protobuf/DescriptorProtos$DescriptorProto$Builder;

    goto :goto_0

    .line 4047
    :sswitch_4
    invoke-static {}, Lcom/google/protobuf/DescriptorProtos$EnumDescriptorProto;->newBuilder()Lcom/google/protobuf/DescriptorProtos$EnumDescriptorProto$Builder;

    move-result-object v1

    .line 4048
    invoke-virtual {p1, v1, p2}, Lcom/google/protobuf/CodedInputStream;->readMessage(Lcom/google/protobuf/MessageLite$Builder;Lcom/google/protobuf/ExtensionRegistryLite;)V

    .line 4049
    invoke-virtual {v1}, Lcom/google/protobuf/DescriptorProtos$EnumDescriptorProto$Builder;->buildPartial()Lcom/google/protobuf/DescriptorProtos$EnumDescriptorProto;

    move-result-object v1

    invoke-virtual {p0, v1}, Lcom/google/protobuf/DescriptorProtos$DescriptorProto$Builder;->addEnumType(Lcom/google/protobuf/DescriptorProtos$EnumDescriptorProto;)Lcom/google/protobuf/DescriptorProtos$DescriptorProto$Builder;

    goto :goto_0

    .line 4053
    :sswitch_5
    invoke-static {}, Lcom/google/protobuf/DescriptorProtos$DescriptorProto$ExtensionRange;->newBuilder()Lcom/google/protobuf/DescriptorProtos$DescriptorProto$ExtensionRange$Builder;

    move-result-object v1

    .line 4054
    invoke-virtual {p1, v1, p2}, Lcom/google/protobuf/CodedInputStream;->readMessage(Lcom/google/protobuf/MessageLite$Builder;Lcom/google/protobuf/ExtensionRegistryLite;)V

    .line 4055
    invoke-virtual {v1}, Lcom/google/protobuf/DescriptorProtos$DescriptorProto$ExtensionRange$Builder;->buildPartial()Lcom/google/protobuf/DescriptorProtos$DescriptorProto$ExtensionRange;

    move-result-object v1

    invoke-virtual {p0, v1}, Lcom/google/protobuf/DescriptorProtos$DescriptorProto$Builder;->addExtensionRange(Lcom/google/protobuf/DescriptorProtos$DescriptorProto$ExtensionRange;)Lcom/google/protobuf/DescriptorProtos$DescriptorProto$Builder;

    goto :goto_0

    .line 4059
    :sswitch_6
    invoke-static {}, Lcom/google/protobuf/DescriptorProtos$FieldDescriptorProto;->newBuilder()Lcom/google/protobuf/DescriptorProtos$FieldDescriptorProto$Builder;

    move-result-object v1

    .line 4060
    invoke-virtual {p1, v1, p2}, Lcom/google/protobuf/CodedInputStream;->readMessage(Lcom/google/protobuf/MessageLite$Builder;Lcom/google/protobuf/ExtensionRegistryLite;)V

    .line 4061
    invoke-virtual {v1}, Lcom/google/protobuf/DescriptorProtos$FieldDescriptorProto$Builder;->buildPartial()Lcom/google/protobuf/DescriptorProtos$FieldDescriptorProto;

    move-result-object v1

    invoke-virtual {p0, v1}, Lcom/google/protobuf/DescriptorProtos$DescriptorProto$Builder;->addExtension(Lcom/google/protobuf/DescriptorProtos$FieldDescriptorProto;)Lcom/google/protobuf/DescriptorProtos$DescriptorProto$Builder;

    goto :goto_0

    .line 4065
    :sswitch_7
    invoke-static {}, Lcom/google/protobuf/DescriptorProtos$MessageOptions;->newBuilder()Lcom/google/protobuf/DescriptorProtos$MessageOptions$Builder;

    move-result-object v1

    .line 4066
    invoke-virtual {p0}, Lcom/google/protobuf/DescriptorProtos$DescriptorProto$Builder;->hasOptions()Z

    move-result v2

    if-eqz v2, :cond_1

    .line 4067
    invoke-virtual {p0}, Lcom/google/protobuf/DescriptorProtos$DescriptorProto$Builder;->getOptions()Lcom/google/protobuf/DescriptorProtos$MessageOptions;

    move-result-object v2

    invoke-virtual {v1, v2}, Lcom/google/protobuf/DescriptorProtos$MessageOptions$Builder;->mergeFrom(Lcom/google/protobuf/DescriptorProtos$MessageOptions;)Lcom/google/protobuf/DescriptorProtos$MessageOptions$Builder;

    .line 4069
    :cond_1
    invoke-virtual {p1, v1, p2}, Lcom/google/protobuf/CodedInputStream;->readMessage(Lcom/google/protobuf/MessageLite$Builder;Lcom/google/protobuf/ExtensionRegistryLite;)V

    .line 4070
    invoke-virtual {v1}, Lcom/google/protobuf/DescriptorProtos$MessageOptions$Builder;->buildPartial()Lcom/google/protobuf/DescriptorProtos$MessageOptions;

    move-result-object v1

    invoke-virtual {p0, v1}, Lcom/google/protobuf/DescriptorProtos$DescriptorProto$Builder;->setOptions(Lcom/google/protobuf/DescriptorProtos$MessageOptions;)Lcom/google/protobuf/DescriptorProtos$DescriptorProto$Builder;

    goto/16 :goto_0

    .line 4015
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
    .end sparse-switch
.end method

.method public mergeFrom(Lcom/google/protobuf/DescriptorProtos$DescriptorProto;)Lcom/google/protobuf/DescriptorProtos$DescriptorProto$Builder;
    .locals 3

    .prologue
    const/4 v1, 0x0

    .line 3831
    invoke-static {}, Lcom/google/protobuf/DescriptorProtos$DescriptorProto;->getDefaultInstance()Lcom/google/protobuf/DescriptorProtos$DescriptorProto;

    move-result-object v0

    if-ne p1, v0, :cond_0

    .line 3969
    :goto_0
    return-object p0

    .line 3832
    :cond_0
    invoke-virtual {p1}, Lcom/google/protobuf/DescriptorProtos$DescriptorProto;->hasName()Z

    move-result v0

    if-eqz v0, :cond_1

    .line 3833
    invoke-virtual {p1}, Lcom/google/protobuf/DescriptorProtos$DescriptorProto;->getName()Ljava/lang/String;

    move-result-object v0

    invoke-virtual {p0, v0}, Lcom/google/protobuf/DescriptorProtos$DescriptorProto$Builder;->setName(Ljava/lang/String;)Lcom/google/protobuf/DescriptorProtos$DescriptorProto$Builder;

    .line 3835
    :cond_1
    iget-object v0, p0, Lcom/google/protobuf/DescriptorProtos$DescriptorProto$Builder;->fieldBuilder_:Lcom/google/protobuf/RepeatedFieldBuilder;

    if-nez v0, :cond_9

    .line 3836
    invoke-static {p1}, Lcom/google/protobuf/DescriptorProtos$DescriptorProto;->access$16(Lcom/google/protobuf/DescriptorProtos$DescriptorProto;)Ljava/util/List;

    move-result-object v0

    invoke-interface {v0}, Ljava/util/List;->isEmpty()Z

    move-result v0

    if-nez v0, :cond_2

    .line 3837
    iget-object v0, p0, Lcom/google/protobuf/DescriptorProtos$DescriptorProto$Builder;->field_:Ljava/util/List;

    invoke-interface {v0}, Ljava/util/List;->isEmpty()Z

    move-result v0

    if-eqz v0, :cond_8

    .line 3838
    invoke-static {p1}, Lcom/google/protobuf/DescriptorProtos$DescriptorProto;->access$16(Lcom/google/protobuf/DescriptorProtos$DescriptorProto;)Ljava/util/List;

    move-result-object v0

    iput-object v0, p0, Lcom/google/protobuf/DescriptorProtos$DescriptorProto$Builder;->field_:Ljava/util/List;

    .line 3839
    iget v0, p0, Lcom/google/protobuf/DescriptorProtos$DescriptorProto$Builder;->bitField0_:I

    and-int/lit8 v0, v0, -0x3

    iput v0, p0, Lcom/google/protobuf/DescriptorProtos$DescriptorProto$Builder;->bitField0_:I

    .line 3844
    :goto_1
    invoke-virtual {p0}, Lcom/google/protobuf/DescriptorProtos$DescriptorProto$Builder;->onChanged()V

    .line 3861
    :cond_2
    :goto_2
    iget-object v0, p0, Lcom/google/protobuf/DescriptorProtos$DescriptorProto$Builder;->extensionBuilder_:Lcom/google/protobuf/RepeatedFieldBuilder;

    if-nez v0, :cond_d

    .line 3862
    invoke-static {p1}, Lcom/google/protobuf/DescriptorProtos$DescriptorProto;->access$17(Lcom/google/protobuf/DescriptorProtos$DescriptorProto;)Ljava/util/List;

    move-result-object v0

    invoke-interface {v0}, Ljava/util/List;->isEmpty()Z

    move-result v0

    if-nez v0, :cond_3

    .line 3863
    iget-object v0, p0, Lcom/google/protobuf/DescriptorProtos$DescriptorProto$Builder;->extension_:Ljava/util/List;

    invoke-interface {v0}, Ljava/util/List;->isEmpty()Z

    move-result v0

    if-eqz v0, :cond_c

    .line 3864
    invoke-static {p1}, Lcom/google/protobuf/DescriptorProtos$DescriptorProto;->access$17(Lcom/google/protobuf/DescriptorProtos$DescriptorProto;)Ljava/util/List;

    move-result-object v0

    iput-object v0, p0, Lcom/google/protobuf/DescriptorProtos$DescriptorProto$Builder;->extension_:Ljava/util/List;

    .line 3865
    iget v0, p0, Lcom/google/protobuf/DescriptorProtos$DescriptorProto$Builder;->bitField0_:I

    and-int/lit8 v0, v0, -0x5

    iput v0, p0, Lcom/google/protobuf/DescriptorProtos$DescriptorProto$Builder;->bitField0_:I

    .line 3870
    :goto_3
    invoke-virtual {p0}, Lcom/google/protobuf/DescriptorProtos$DescriptorProto$Builder;->onChanged()V

    .line 3887
    :cond_3
    :goto_4
    iget-object v0, p0, Lcom/google/protobuf/DescriptorProtos$DescriptorProto$Builder;->nestedTypeBuilder_:Lcom/google/protobuf/RepeatedFieldBuilder;

    if-nez v0, :cond_11

    .line 3888
    invoke-static {p1}, Lcom/google/protobuf/DescriptorProtos$DescriptorProto;->access$18(Lcom/google/protobuf/DescriptorProtos$DescriptorProto;)Ljava/util/List;

    move-result-object v0

    invoke-interface {v0}, Ljava/util/List;->isEmpty()Z

    move-result v0

    if-nez v0, :cond_4

    .line 3889
    iget-object v0, p0, Lcom/google/protobuf/DescriptorProtos$DescriptorProto$Builder;->nestedType_:Ljava/util/List;

    invoke-interface {v0}, Ljava/util/List;->isEmpty()Z

    move-result v0

    if-eqz v0, :cond_10

    .line 3890
    invoke-static {p1}, Lcom/google/protobuf/DescriptorProtos$DescriptorProto;->access$18(Lcom/google/protobuf/DescriptorProtos$DescriptorProto;)Ljava/util/List;

    move-result-object v0

    iput-object v0, p0, Lcom/google/protobuf/DescriptorProtos$DescriptorProto$Builder;->nestedType_:Ljava/util/List;

    .line 3891
    iget v0, p0, Lcom/google/protobuf/DescriptorProtos$DescriptorProto$Builder;->bitField0_:I

    and-int/lit8 v0, v0, -0x9

    iput v0, p0, Lcom/google/protobuf/DescriptorProtos$DescriptorProto$Builder;->bitField0_:I

    .line 3896
    :goto_5
    invoke-virtual {p0}, Lcom/google/protobuf/DescriptorProtos$DescriptorProto$Builder;->onChanged()V

    .line 3913
    :cond_4
    :goto_6
    iget-object v0, p0, Lcom/google/protobuf/DescriptorProtos$DescriptorProto$Builder;->enumTypeBuilder_:Lcom/google/protobuf/RepeatedFieldBuilder;

    if-nez v0, :cond_15

    .line 3914
    invoke-static {p1}, Lcom/google/protobuf/DescriptorProtos$DescriptorProto;->access$19(Lcom/google/protobuf/DescriptorProtos$DescriptorProto;)Ljava/util/List;

    move-result-object v0

    invoke-interface {v0}, Ljava/util/List;->isEmpty()Z

    move-result v0

    if-nez v0, :cond_5

    .line 3915
    iget-object v0, p0, Lcom/google/protobuf/DescriptorProtos$DescriptorProto$Builder;->enumType_:Ljava/util/List;

    invoke-interface {v0}, Ljava/util/List;->isEmpty()Z

    move-result v0

    if-eqz v0, :cond_14

    .line 3916
    invoke-static {p1}, Lcom/google/protobuf/DescriptorProtos$DescriptorProto;->access$19(Lcom/google/protobuf/DescriptorProtos$DescriptorProto;)Ljava/util/List;

    move-result-object v0

    iput-object v0, p0, Lcom/google/protobuf/DescriptorProtos$DescriptorProto$Builder;->enumType_:Ljava/util/List;

    .line 3917
    iget v0, p0, Lcom/google/protobuf/DescriptorProtos$DescriptorProto$Builder;->bitField0_:I

    and-int/lit8 v0, v0, -0x11

    iput v0, p0, Lcom/google/protobuf/DescriptorProtos$DescriptorProto$Builder;->bitField0_:I

    .line 3922
    :goto_7
    invoke-virtual {p0}, Lcom/google/protobuf/DescriptorProtos$DescriptorProto$Builder;->onChanged()V

    .line 3939
    :cond_5
    :goto_8
    iget-object v0, p0, Lcom/google/protobuf/DescriptorProtos$DescriptorProto$Builder;->extensionRangeBuilder_:Lcom/google/protobuf/RepeatedFieldBuilder;

    if-nez v0, :cond_19

    .line 3940
    invoke-static {p1}, Lcom/google/protobuf/DescriptorProtos$DescriptorProto;->access$20(Lcom/google/protobuf/DescriptorProtos$DescriptorProto;)Ljava/util/List;

    move-result-object v0

    invoke-interface {v0}, Ljava/util/List;->isEmpty()Z

    move-result v0

    if-nez v0, :cond_6

    .line 3941
    iget-object v0, p0, Lcom/google/protobuf/DescriptorProtos$DescriptorProto$Builder;->extensionRange_:Ljava/util/List;

    invoke-interface {v0}, Ljava/util/List;->isEmpty()Z

    move-result v0

    if-eqz v0, :cond_18

    .line 3942
    invoke-static {p1}, Lcom/google/protobuf/DescriptorProtos$DescriptorProto;->access$20(Lcom/google/protobuf/DescriptorProtos$DescriptorProto;)Ljava/util/List;

    move-result-object v0

    iput-object v0, p0, Lcom/google/protobuf/DescriptorProtos$DescriptorProto$Builder;->extensionRange_:Ljava/util/List;

    .line 3943
    iget v0, p0, Lcom/google/protobuf/DescriptorProtos$DescriptorProto$Builder;->bitField0_:I

    and-int/lit8 v0, v0, -0x21

    iput v0, p0, Lcom/google/protobuf/DescriptorProtos$DescriptorProto$Builder;->bitField0_:I

    .line 3948
    :goto_9
    invoke-virtual {p0}, Lcom/google/protobuf/DescriptorProtos$DescriptorProto$Builder;->onChanged()V

    .line 3965
    :cond_6
    :goto_a
    invoke-virtual {p1}, Lcom/google/protobuf/DescriptorProtos$DescriptorProto;->hasOptions()Z

    move-result v0

    if-eqz v0, :cond_7

    .line 3966
    invoke-virtual {p1}, Lcom/google/protobuf/DescriptorProtos$DescriptorProto;->getOptions()Lcom/google/protobuf/DescriptorProtos$MessageOptions;

    move-result-object v0

    invoke-virtual {p0, v0}, Lcom/google/protobuf/DescriptorProtos$DescriptorProto$Builder;->mergeOptions(Lcom/google/protobuf/DescriptorProtos$MessageOptions;)Lcom/google/protobuf/DescriptorProtos$DescriptorProto$Builder;

    .line 3968
    :cond_7
    invoke-virtual {p1}, Lcom/google/protobuf/DescriptorProtos$DescriptorProto;->getUnknownFields()Lcom/google/protobuf/UnknownFieldSet;

    move-result-object v0

    invoke-virtual {p0, v0}, Lcom/google/protobuf/DescriptorProtos$DescriptorProto$Builder;->mergeUnknownFields(Lcom/google/protobuf/UnknownFieldSet;)Lcom/google/protobuf/GeneratedMessage$Builder;

    goto/16 :goto_0

    .line 3841
    :cond_8
    invoke-direct {p0}, Lcom/google/protobuf/DescriptorProtos$DescriptorProto$Builder;->ensureFieldIsMutable()V

    .line 3842
    iget-object v0, p0, Lcom/google/protobuf/DescriptorProtos$DescriptorProto$Builder;->field_:Ljava/util/List;

    invoke-static {p1}, Lcom/google/protobuf/DescriptorProtos$DescriptorProto;->access$16(Lcom/google/protobuf/DescriptorProtos$DescriptorProto;)Ljava/util/List;

    move-result-object v2

    invoke-interface {v0, v2}, Ljava/util/List;->addAll(Ljava/util/Collection;)Z

    goto/16 :goto_1

    .line 3847
    :cond_9
    invoke-static {p1}, Lcom/google/protobuf/DescriptorProtos$DescriptorProto;->access$16(Lcom/google/protobuf/DescriptorProtos$DescriptorProto;)Ljava/util/List;

    move-result-object v0

    invoke-interface {v0}, Ljava/util/List;->isEmpty()Z

    move-result v0

    if-nez v0, :cond_2

    .line 3848
    iget-object v0, p0, Lcom/google/protobuf/DescriptorProtos$DescriptorProto$Builder;->fieldBuilder_:Lcom/google/protobuf/RepeatedFieldBuilder;

    invoke-virtual {v0}, Lcom/google/protobuf/RepeatedFieldBuilder;->isEmpty()Z

    move-result v0

    if-eqz v0, :cond_b

    .line 3849
    iget-object v0, p0, Lcom/google/protobuf/DescriptorProtos$DescriptorProto$Builder;->fieldBuilder_:Lcom/google/protobuf/RepeatedFieldBuilder;

    invoke-virtual {v0}, Lcom/google/protobuf/RepeatedFieldBuilder;->dispose()V

    .line 3850
    iput-object v1, p0, Lcom/google/protobuf/DescriptorProtos$DescriptorProto$Builder;->fieldBuilder_:Lcom/google/protobuf/RepeatedFieldBuilder;

    .line 3851
    invoke-static {p1}, Lcom/google/protobuf/DescriptorProtos$DescriptorProto;->access$16(Lcom/google/protobuf/DescriptorProtos$DescriptorProto;)Ljava/util/List;

    move-result-object v0

    iput-object v0, p0, Lcom/google/protobuf/DescriptorProtos$DescriptorProto$Builder;->field_:Ljava/util/List;

    .line 3852
    iget v0, p0, Lcom/google/protobuf/DescriptorProtos$DescriptorProto$Builder;->bitField0_:I

    and-int/lit8 v0, v0, -0x3

    iput v0, p0, Lcom/google/protobuf/DescriptorProtos$DescriptorProto$Builder;->bitField0_:I

    .line 3854
    sget-boolean v0, Lcom/google/protobuf/GeneratedMessage;->alwaysUseFieldBuilders:Z

    if-eqz v0, :cond_a

    .line 3855
    invoke-direct {p0}, Lcom/google/protobuf/DescriptorProtos$DescriptorProto$Builder;->getFieldFieldBuilder()Lcom/google/protobuf/RepeatedFieldBuilder;

    move-result-object v0

    .line 3853
    :goto_b
    iput-object v0, p0, Lcom/google/protobuf/DescriptorProtos$DescriptorProto$Builder;->fieldBuilder_:Lcom/google/protobuf/RepeatedFieldBuilder;

    goto/16 :goto_2

    :cond_a
    move-object v0, v1

    .line 3855
    goto :goto_b

    .line 3857
    :cond_b
    iget-object v0, p0, Lcom/google/protobuf/DescriptorProtos$DescriptorProto$Builder;->fieldBuilder_:Lcom/google/protobuf/RepeatedFieldBuilder;

    invoke-static {p1}, Lcom/google/protobuf/DescriptorProtos$DescriptorProto;->access$16(Lcom/google/protobuf/DescriptorProtos$DescriptorProto;)Ljava/util/List;

    move-result-object v2

    invoke-virtual {v0, v2}, Lcom/google/protobuf/RepeatedFieldBuilder;->addAllMessages(Ljava/lang/Iterable;)Lcom/google/protobuf/RepeatedFieldBuilder;

    goto/16 :goto_2

    .line 3867
    :cond_c
    invoke-direct {p0}, Lcom/google/protobuf/DescriptorProtos$DescriptorProto$Builder;->ensureExtensionIsMutable()V

    .line 3868
    iget-object v0, p0, Lcom/google/protobuf/DescriptorProtos$DescriptorProto$Builder;->extension_:Ljava/util/List;

    invoke-static {p1}, Lcom/google/protobuf/DescriptorProtos$DescriptorProto;->access$17(Lcom/google/protobuf/DescriptorProtos$DescriptorProto;)Ljava/util/List;

    move-result-object v2

    invoke-interface {v0, v2}, Ljava/util/List;->addAll(Ljava/util/Collection;)Z

    goto/16 :goto_3

    .line 3873
    :cond_d
    invoke-static {p1}, Lcom/google/protobuf/DescriptorProtos$DescriptorProto;->access$17(Lcom/google/protobuf/DescriptorProtos$DescriptorProto;)Ljava/util/List;

    move-result-object v0

    invoke-interface {v0}, Ljava/util/List;->isEmpty()Z

    move-result v0

    if-nez v0, :cond_3

    .line 3874
    iget-object v0, p0, Lcom/google/protobuf/DescriptorProtos$DescriptorProto$Builder;->extensionBuilder_:Lcom/google/protobuf/RepeatedFieldBuilder;

    invoke-virtual {v0}, Lcom/google/protobuf/RepeatedFieldBuilder;->isEmpty()Z

    move-result v0

    if-eqz v0, :cond_f

    .line 3875
    iget-object v0, p0, Lcom/google/protobuf/DescriptorProtos$DescriptorProto$Builder;->extensionBuilder_:Lcom/google/protobuf/RepeatedFieldBuilder;

    invoke-virtual {v0}, Lcom/google/protobuf/RepeatedFieldBuilder;->dispose()V

    .line 3876
    iput-object v1, p0, Lcom/google/protobuf/DescriptorProtos$DescriptorProto$Builder;->extensionBuilder_:Lcom/google/protobuf/RepeatedFieldBuilder;

    .line 3877
    invoke-static {p1}, Lcom/google/protobuf/DescriptorProtos$DescriptorProto;->access$17(Lcom/google/protobuf/DescriptorProtos$DescriptorProto;)Ljava/util/List;

    move-result-object v0

    iput-object v0, p0, Lcom/google/protobuf/DescriptorProtos$DescriptorProto$Builder;->extension_:Ljava/util/List;

    .line 3878
    iget v0, p0, Lcom/google/protobuf/DescriptorProtos$DescriptorProto$Builder;->bitField0_:I

    and-int/lit8 v0, v0, -0x5

    iput v0, p0, Lcom/google/protobuf/DescriptorProtos$DescriptorProto$Builder;->bitField0_:I

    .line 3880
    sget-boolean v0, Lcom/google/protobuf/GeneratedMessage;->alwaysUseFieldBuilders:Z

    if-eqz v0, :cond_e

    .line 3881
    invoke-direct {p0}, Lcom/google/protobuf/DescriptorProtos$DescriptorProto$Builder;->getExtensionFieldBuilder()Lcom/google/protobuf/RepeatedFieldBuilder;

    move-result-object v0

    .line 3879
    :goto_c
    iput-object v0, p0, Lcom/google/protobuf/DescriptorProtos$DescriptorProto$Builder;->extensionBuilder_:Lcom/google/protobuf/RepeatedFieldBuilder;

    goto/16 :goto_4

    :cond_e
    move-object v0, v1

    .line 3881
    goto :goto_c

    .line 3883
    :cond_f
    iget-object v0, p0, Lcom/google/protobuf/DescriptorProtos$DescriptorProto$Builder;->extensionBuilder_:Lcom/google/protobuf/RepeatedFieldBuilder;

    invoke-static {p1}, Lcom/google/protobuf/DescriptorProtos$DescriptorProto;->access$17(Lcom/google/protobuf/DescriptorProtos$DescriptorProto;)Ljava/util/List;

    move-result-object v2

    invoke-virtual {v0, v2}, Lcom/google/protobuf/RepeatedFieldBuilder;->addAllMessages(Ljava/lang/Iterable;)Lcom/google/protobuf/RepeatedFieldBuilder;

    goto/16 :goto_4

    .line 3893
    :cond_10
    invoke-direct {p0}, Lcom/google/protobuf/DescriptorProtos$DescriptorProto$Builder;->ensureNestedTypeIsMutable()V

    .line 3894
    iget-object v0, p0, Lcom/google/protobuf/DescriptorProtos$DescriptorProto$Builder;->nestedType_:Ljava/util/List;

    invoke-static {p1}, Lcom/google/protobuf/DescriptorProtos$DescriptorProto;->access$18(Lcom/google/protobuf/DescriptorProtos$DescriptorProto;)Ljava/util/List;

    move-result-object v2

    invoke-interface {v0, v2}, Ljava/util/List;->addAll(Ljava/util/Collection;)Z

    goto/16 :goto_5

    .line 3899
    :cond_11
    invoke-static {p1}, Lcom/google/protobuf/DescriptorProtos$DescriptorProto;->access$18(Lcom/google/protobuf/DescriptorProtos$DescriptorProto;)Ljava/util/List;

    move-result-object v0

    invoke-interface {v0}, Ljava/util/List;->isEmpty()Z

    move-result v0

    if-nez v0, :cond_4

    .line 3900
    iget-object v0, p0, Lcom/google/protobuf/DescriptorProtos$DescriptorProto$Builder;->nestedTypeBuilder_:Lcom/google/protobuf/RepeatedFieldBuilder;

    invoke-virtual {v0}, Lcom/google/protobuf/RepeatedFieldBuilder;->isEmpty()Z

    move-result v0

    if-eqz v0, :cond_13

    .line 3901
    iget-object v0, p0, Lcom/google/protobuf/DescriptorProtos$DescriptorProto$Builder;->nestedTypeBuilder_:Lcom/google/protobuf/RepeatedFieldBuilder;

    invoke-virtual {v0}, Lcom/google/protobuf/RepeatedFieldBuilder;->dispose()V

    .line 3902
    iput-object v1, p0, Lcom/google/protobuf/DescriptorProtos$DescriptorProto$Builder;->nestedTypeBuilder_:Lcom/google/protobuf/RepeatedFieldBuilder;

    .line 3903
    invoke-static {p1}, Lcom/google/protobuf/DescriptorProtos$DescriptorProto;->access$18(Lcom/google/protobuf/DescriptorProtos$DescriptorProto;)Ljava/util/List;

    move-result-object v0

    iput-object v0, p0, Lcom/google/protobuf/DescriptorProtos$DescriptorProto$Builder;->nestedType_:Ljava/util/List;

    .line 3904
    iget v0, p0, Lcom/google/protobuf/DescriptorProtos$DescriptorProto$Builder;->bitField0_:I

    and-int/lit8 v0, v0, -0x9

    iput v0, p0, Lcom/google/protobuf/DescriptorProtos$DescriptorProto$Builder;->bitField0_:I

    .line 3906
    sget-boolean v0, Lcom/google/protobuf/GeneratedMessage;->alwaysUseFieldBuilders:Z

    if-eqz v0, :cond_12

    .line 3907
    invoke-direct {p0}, Lcom/google/protobuf/DescriptorProtos$DescriptorProto$Builder;->getNestedTypeFieldBuilder()Lcom/google/protobuf/RepeatedFieldBuilder;

    move-result-object v0

    .line 3905
    :goto_d
    iput-object v0, p0, Lcom/google/protobuf/DescriptorProtos$DescriptorProto$Builder;->nestedTypeBuilder_:Lcom/google/protobuf/RepeatedFieldBuilder;

    goto/16 :goto_6

    :cond_12
    move-object v0, v1

    .line 3907
    goto :goto_d

    .line 3909
    :cond_13
    iget-object v0, p0, Lcom/google/protobuf/DescriptorProtos$DescriptorProto$Builder;->nestedTypeBuilder_:Lcom/google/protobuf/RepeatedFieldBuilder;

    invoke-static {p1}, Lcom/google/protobuf/DescriptorProtos$DescriptorProto;->access$18(Lcom/google/protobuf/DescriptorProtos$DescriptorProto;)Ljava/util/List;

    move-result-object v2

    invoke-virtual {v0, v2}, Lcom/google/protobuf/RepeatedFieldBuilder;->addAllMessages(Ljava/lang/Iterable;)Lcom/google/protobuf/RepeatedFieldBuilder;

    goto/16 :goto_6

    .line 3919
    :cond_14
    invoke-direct {p0}, Lcom/google/protobuf/DescriptorProtos$DescriptorProto$Builder;->ensureEnumTypeIsMutable()V

    .line 3920
    iget-object v0, p0, Lcom/google/protobuf/DescriptorProtos$DescriptorProto$Builder;->enumType_:Ljava/util/List;

    invoke-static {p1}, Lcom/google/protobuf/DescriptorProtos$DescriptorProto;->access$19(Lcom/google/protobuf/DescriptorProtos$DescriptorProto;)Ljava/util/List;

    move-result-object v2

    invoke-interface {v0, v2}, Ljava/util/List;->addAll(Ljava/util/Collection;)Z

    goto/16 :goto_7

    .line 3925
    :cond_15
    invoke-static {p1}, Lcom/google/protobuf/DescriptorProtos$DescriptorProto;->access$19(Lcom/google/protobuf/DescriptorProtos$DescriptorProto;)Ljava/util/List;

    move-result-object v0

    invoke-interface {v0}, Ljava/util/List;->isEmpty()Z

    move-result v0

    if-nez v0, :cond_5

    .line 3926
    iget-object v0, p0, Lcom/google/protobuf/DescriptorProtos$DescriptorProto$Builder;->enumTypeBuilder_:Lcom/google/protobuf/RepeatedFieldBuilder;

    invoke-virtual {v0}, Lcom/google/protobuf/RepeatedFieldBuilder;->isEmpty()Z

    move-result v0

    if-eqz v0, :cond_17

    .line 3927
    iget-object v0, p0, Lcom/google/protobuf/DescriptorProtos$DescriptorProto$Builder;->enumTypeBuilder_:Lcom/google/protobuf/RepeatedFieldBuilder;

    invoke-virtual {v0}, Lcom/google/protobuf/RepeatedFieldBuilder;->dispose()V

    .line 3928
    iput-object v1, p0, Lcom/google/protobuf/DescriptorProtos$DescriptorProto$Builder;->enumTypeBuilder_:Lcom/google/protobuf/RepeatedFieldBuilder;

    .line 3929
    invoke-static {p1}, Lcom/google/protobuf/DescriptorProtos$DescriptorProto;->access$19(Lcom/google/protobuf/DescriptorProtos$DescriptorProto;)Ljava/util/List;

    move-result-object v0

    iput-object v0, p0, Lcom/google/protobuf/DescriptorProtos$DescriptorProto$Builder;->enumType_:Ljava/util/List;

    .line 3930
    iget v0, p0, Lcom/google/protobuf/DescriptorProtos$DescriptorProto$Builder;->bitField0_:I

    and-int/lit8 v0, v0, -0x11

    iput v0, p0, Lcom/google/protobuf/DescriptorProtos$DescriptorProto$Builder;->bitField0_:I

    .line 3932
    sget-boolean v0, Lcom/google/protobuf/GeneratedMessage;->alwaysUseFieldBuilders:Z

    if-eqz v0, :cond_16

    .line 3933
    invoke-direct {p0}, Lcom/google/protobuf/DescriptorProtos$DescriptorProto$Builder;->getEnumTypeFieldBuilder()Lcom/google/protobuf/RepeatedFieldBuilder;

    move-result-object v0

    .line 3931
    :goto_e
    iput-object v0, p0, Lcom/google/protobuf/DescriptorProtos$DescriptorProto$Builder;->enumTypeBuilder_:Lcom/google/protobuf/RepeatedFieldBuilder;

    goto/16 :goto_8

    :cond_16
    move-object v0, v1

    .line 3933
    goto :goto_e

    .line 3935
    :cond_17
    iget-object v0, p0, Lcom/google/protobuf/DescriptorProtos$DescriptorProto$Builder;->enumTypeBuilder_:Lcom/google/protobuf/RepeatedFieldBuilder;

    invoke-static {p1}, Lcom/google/protobuf/DescriptorProtos$DescriptorProto;->access$19(Lcom/google/protobuf/DescriptorProtos$DescriptorProto;)Ljava/util/List;

    move-result-object v2

    invoke-virtual {v0, v2}, Lcom/google/protobuf/RepeatedFieldBuilder;->addAllMessages(Ljava/lang/Iterable;)Lcom/google/protobuf/RepeatedFieldBuilder;

    goto/16 :goto_8

    .line 3945
    :cond_18
    invoke-direct {p0}, Lcom/google/protobuf/DescriptorProtos$DescriptorProto$Builder;->ensureExtensionRangeIsMutable()V

    .line 3946
    iget-object v0, p0, Lcom/google/protobuf/DescriptorProtos$DescriptorProto$Builder;->extensionRange_:Ljava/util/List;

    invoke-static {p1}, Lcom/google/protobuf/DescriptorProtos$DescriptorProto;->access$20(Lcom/google/protobuf/DescriptorProtos$DescriptorProto;)Ljava/util/List;

    move-result-object v1

    invoke-interface {v0, v1}, Ljava/util/List;->addAll(Ljava/util/Collection;)Z

    goto/16 :goto_9

    .line 3951
    :cond_19
    invoke-static {p1}, Lcom/google/protobuf/DescriptorProtos$DescriptorProto;->access$20(Lcom/google/protobuf/DescriptorProtos$DescriptorProto;)Ljava/util/List;

    move-result-object v0

    invoke-interface {v0}, Ljava/util/List;->isEmpty()Z

    move-result v0

    if-nez v0, :cond_6

    .line 3952
    iget-object v0, p0, Lcom/google/protobuf/DescriptorProtos$DescriptorProto$Builder;->extensionRangeBuilder_:Lcom/google/protobuf/RepeatedFieldBuilder;

    invoke-virtual {v0}, Lcom/google/protobuf/RepeatedFieldBuilder;->isEmpty()Z

    move-result v0

    if-eqz v0, :cond_1b

    .line 3953
    iget-object v0, p0, Lcom/google/protobuf/DescriptorProtos$DescriptorProto$Builder;->extensionRangeBuilder_:Lcom/google/protobuf/RepeatedFieldBuilder;

    invoke-virtual {v0}, Lcom/google/protobuf/RepeatedFieldBuilder;->dispose()V

    .line 3954
    iput-object v1, p0, Lcom/google/protobuf/DescriptorProtos$DescriptorProto$Builder;->extensionRangeBuilder_:Lcom/google/protobuf/RepeatedFieldBuilder;

    .line 3955
    invoke-static {p1}, Lcom/google/protobuf/DescriptorProtos$DescriptorProto;->access$20(Lcom/google/protobuf/DescriptorProtos$DescriptorProto;)Ljava/util/List;

    move-result-object v0

    iput-object v0, p0, Lcom/google/protobuf/DescriptorProtos$DescriptorProto$Builder;->extensionRange_:Ljava/util/List;

    .line 3956
    iget v0, p0, Lcom/google/protobuf/DescriptorProtos$DescriptorProto$Builder;->bitField0_:I

    and-int/lit8 v0, v0, -0x21

    iput v0, p0, Lcom/google/protobuf/DescriptorProtos$DescriptorProto$Builder;->bitField0_:I

    .line 3958
    sget-boolean v0, Lcom/google/protobuf/GeneratedMessage;->alwaysUseFieldBuilders:Z

    if-eqz v0, :cond_1a

    .line 3959
    invoke-direct {p0}, Lcom/google/protobuf/DescriptorProtos$DescriptorProto$Builder;->getExtensionRangeFieldBuilder()Lcom/google/protobuf/RepeatedFieldBuilder;

    move-result-object v1

    .line 3957
    :cond_1a
    iput-object v1, p0, Lcom/google/protobuf/DescriptorProtos$DescriptorProto$Builder;->extensionRangeBuilder_:Lcom/google/protobuf/RepeatedFieldBuilder;

    goto/16 :goto_a

    .line 3961
    :cond_1b
    iget-object v0, p0, Lcom/google/protobuf/DescriptorProtos$DescriptorProto$Builder;->extensionRangeBuilder_:Lcom/google/protobuf/RepeatedFieldBuilder;

    invoke-static {p1}, Lcom/google/protobuf/DescriptorProtos$DescriptorProto;->access$20(Lcom/google/protobuf/DescriptorProtos$DescriptorProto;)Ljava/util/List;

    move-result-object v1

    invoke-virtual {v0, v1}, Lcom/google/protobuf/RepeatedFieldBuilder;->addAllMessages(Ljava/lang/Iterable;)Lcom/google/protobuf/RepeatedFieldBuilder;

    goto/16 :goto_a
.end method

.method public mergeFrom(Lcom/google/protobuf/Message;)Lcom/google/protobuf/DescriptorProtos$DescriptorProto$Builder;
    .locals 1

    .prologue
    .line 3822
    instance-of v0, p1, Lcom/google/protobuf/DescriptorProtos$DescriptorProto;

    if-eqz v0, :cond_0

    .line 3823
    check-cast p1, Lcom/google/protobuf/DescriptorProtos$DescriptorProto;

    invoke-virtual {p0, p1}, Lcom/google/protobuf/DescriptorProtos$DescriptorProto$Builder;->mergeFrom(Lcom/google/protobuf/DescriptorProtos$DescriptorProto;)Lcom/google/protobuf/DescriptorProtos$DescriptorProto$Builder;

    move-result-object p0

    .line 3826
    :goto_0
    return-object p0

    .line 3825
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
    invoke-virtual {p0, p1, p2}, Lcom/google/protobuf/DescriptorProtos$DescriptorProto$Builder;->mergeFrom(Lcom/google/protobuf/CodedInputStream;Lcom/google/protobuf/ExtensionRegistryLite;)Lcom/google/protobuf/DescriptorProtos$DescriptorProto$Builder;

    move-result-object v0

    return-object v0
.end method

.method public bridge synthetic mergeFrom(Lcom/google/protobuf/Message;)Lcom/google/protobuf/Message$Builder;
    .locals 1

    .prologue
    .line 1
    invoke-virtual {p0, p1}, Lcom/google/protobuf/DescriptorProtos$DescriptorProto$Builder;->mergeFrom(Lcom/google/protobuf/Message;)Lcom/google/protobuf/DescriptorProtos$DescriptorProto$Builder;

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
    invoke-virtual {p0, p1, p2}, Lcom/google/protobuf/DescriptorProtos$DescriptorProto$Builder;->mergeFrom(Lcom/google/protobuf/CodedInputStream;Lcom/google/protobuf/ExtensionRegistryLite;)Lcom/google/protobuf/DescriptorProtos$DescriptorProto$Builder;

    move-result-object v0

    return-object v0
.end method

.method public mergeOptions(Lcom/google/protobuf/DescriptorProtos$MessageOptions;)Lcom/google/protobuf/DescriptorProtos$DescriptorProto$Builder;
    .locals 2

    .prologue
    .line 5084
    iget-object v0, p0, Lcom/google/protobuf/DescriptorProtos$DescriptorProto$Builder;->optionsBuilder_:Lcom/google/protobuf/SingleFieldBuilder;

    if-nez v0, :cond_1

    .line 5085
    iget v0, p0, Lcom/google/protobuf/DescriptorProtos$DescriptorProto$Builder;->bitField0_:I

    and-int/lit8 v0, v0, 0x40

    const/16 v1, 0x40

    if-ne v0, v1, :cond_0

    .line 5086
    iget-object v0, p0, Lcom/google/protobuf/DescriptorProtos$DescriptorProto$Builder;->options_:Lcom/google/protobuf/DescriptorProtos$MessageOptions;

    invoke-static {}, Lcom/google/protobuf/DescriptorProtos$MessageOptions;->getDefaultInstance()Lcom/google/protobuf/DescriptorProtos$MessageOptions;

    move-result-object v1

    if-eq v0, v1, :cond_0

    .line 5088
    iget-object v0, p0, Lcom/google/protobuf/DescriptorProtos$DescriptorProto$Builder;->options_:Lcom/google/protobuf/DescriptorProtos$MessageOptions;

    invoke-static {v0}, Lcom/google/protobuf/DescriptorProtos$MessageOptions;->newBuilder(Lcom/google/protobuf/DescriptorProtos$MessageOptions;)Lcom/google/protobuf/DescriptorProtos$MessageOptions$Builder;

    move-result-object v0

    invoke-virtual {v0, p1}, Lcom/google/protobuf/DescriptorProtos$MessageOptions$Builder;->mergeFrom(Lcom/google/protobuf/DescriptorProtos$MessageOptions;)Lcom/google/protobuf/DescriptorProtos$MessageOptions$Builder;

    move-result-object v0

    invoke-virtual {v0}, Lcom/google/protobuf/DescriptorProtos$MessageOptions$Builder;->buildPartial()Lcom/google/protobuf/DescriptorProtos$MessageOptions;

    move-result-object v0

    .line 5087
    iput-object v0, p0, Lcom/google/protobuf/DescriptorProtos$DescriptorProto$Builder;->options_:Lcom/google/protobuf/DescriptorProtos$MessageOptions;

    .line 5092
    :goto_0
    invoke-virtual {p0}, Lcom/google/protobuf/DescriptorProtos$DescriptorProto$Builder;->onChanged()V

    .line 5096
    :goto_1
    iget v0, p0, Lcom/google/protobuf/DescriptorProtos$DescriptorProto$Builder;->bitField0_:I

    or-int/lit8 v0, v0, 0x40

    iput v0, p0, Lcom/google/protobuf/DescriptorProtos$DescriptorProto$Builder;->bitField0_:I

    .line 5097
    return-object p0

    .line 5090
    :cond_0
    iput-object p1, p0, Lcom/google/protobuf/DescriptorProtos$DescriptorProto$Builder;->options_:Lcom/google/protobuf/DescriptorProtos$MessageOptions;

    goto :goto_0

    .line 5094
    :cond_1
    iget-object v0, p0, Lcom/google/protobuf/DescriptorProtos$DescriptorProto$Builder;->optionsBuilder_:Lcom/google/protobuf/SingleFieldBuilder;

    invoke-virtual {v0, p1}, Lcom/google/protobuf/SingleFieldBuilder;->mergeFrom(Lcom/google/protobuf/GeneratedMessage;)Lcom/google/protobuf/SingleFieldBuilder;

    goto :goto_1
.end method

.method public removeEnumType(I)Lcom/google/protobuf/DescriptorProtos$DescriptorProto$Builder;
    .locals 1

    .prologue
    .line 4803
    iget-object v0, p0, Lcom/google/protobuf/DescriptorProtos$DescriptorProto$Builder;->enumTypeBuilder_:Lcom/google/protobuf/RepeatedFieldBuilder;

    if-nez v0, :cond_0

    .line 4804
    invoke-direct {p0}, Lcom/google/protobuf/DescriptorProtos$DescriptorProto$Builder;->ensureEnumTypeIsMutable()V

    .line 4805
    iget-object v0, p0, Lcom/google/protobuf/DescriptorProtos$DescriptorProto$Builder;->enumType_:Ljava/util/List;

    invoke-interface {v0, p1}, Ljava/util/List;->remove(I)Ljava/lang/Object;

    .line 4806
    invoke-virtual {p0}, Lcom/google/protobuf/DescriptorProtos$DescriptorProto$Builder;->onChanged()V

    .line 4810
    :goto_0
    return-object p0

    .line 4808
    :cond_0
    iget-object v0, p0, Lcom/google/protobuf/DescriptorProtos$DescriptorProto$Builder;->enumTypeBuilder_:Lcom/google/protobuf/RepeatedFieldBuilder;

    invoke-virtual {v0, p1}, Lcom/google/protobuf/RepeatedFieldBuilder;->remove(I)V

    goto :goto_0
.end method

.method public removeExtension(I)Lcom/google/protobuf/DescriptorProtos$DescriptorProto$Builder;
    .locals 1

    .prologue
    .line 4431
    iget-object v0, p0, Lcom/google/protobuf/DescriptorProtos$DescriptorProto$Builder;->extensionBuilder_:Lcom/google/protobuf/RepeatedFieldBuilder;

    if-nez v0, :cond_0

    .line 4432
    invoke-direct {p0}, Lcom/google/protobuf/DescriptorProtos$DescriptorProto$Builder;->ensureExtensionIsMutable()V

    .line 4433
    iget-object v0, p0, Lcom/google/protobuf/DescriptorProtos$DescriptorProto$Builder;->extension_:Ljava/util/List;

    invoke-interface {v0, p1}, Ljava/util/List;->remove(I)Ljava/lang/Object;

    .line 4434
    invoke-virtual {p0}, Lcom/google/protobuf/DescriptorProtos$DescriptorProto$Builder;->onChanged()V

    .line 4438
    :goto_0
    return-object p0

    .line 4436
    :cond_0
    iget-object v0, p0, Lcom/google/protobuf/DescriptorProtos$DescriptorProto$Builder;->extensionBuilder_:Lcom/google/protobuf/RepeatedFieldBuilder;

    invoke-virtual {v0, p1}, Lcom/google/protobuf/RepeatedFieldBuilder;->remove(I)V

    goto :goto_0
.end method

.method public removeExtensionRange(I)Lcom/google/protobuf/DescriptorProtos$DescriptorProto$Builder;
    .locals 1

    .prologue
    .line 4989
    iget-object v0, p0, Lcom/google/protobuf/DescriptorProtos$DescriptorProto$Builder;->extensionRangeBuilder_:Lcom/google/protobuf/RepeatedFieldBuilder;

    if-nez v0, :cond_0

    .line 4990
    invoke-direct {p0}, Lcom/google/protobuf/DescriptorProtos$DescriptorProto$Builder;->ensureExtensionRangeIsMutable()V

    .line 4991
    iget-object v0, p0, Lcom/google/protobuf/DescriptorProtos$DescriptorProto$Builder;->extensionRange_:Ljava/util/List;

    invoke-interface {v0, p1}, Ljava/util/List;->remove(I)Ljava/lang/Object;

    .line 4992
    invoke-virtual {p0}, Lcom/google/protobuf/DescriptorProtos$DescriptorProto$Builder;->onChanged()V

    .line 4996
    :goto_0
    return-object p0

    .line 4994
    :cond_0
    iget-object v0, p0, Lcom/google/protobuf/DescriptorProtos$DescriptorProto$Builder;->extensionRangeBuilder_:Lcom/google/protobuf/RepeatedFieldBuilder;

    invoke-virtual {v0, p1}, Lcom/google/protobuf/RepeatedFieldBuilder;->remove(I)V

    goto :goto_0
.end method

.method public removeField(I)Lcom/google/protobuf/DescriptorProtos$DescriptorProto$Builder;
    .locals 1

    .prologue
    .line 4245
    iget-object v0, p0, Lcom/google/protobuf/DescriptorProtos$DescriptorProto$Builder;->fieldBuilder_:Lcom/google/protobuf/RepeatedFieldBuilder;

    if-nez v0, :cond_0

    .line 4246
    invoke-direct {p0}, Lcom/google/protobuf/DescriptorProtos$DescriptorProto$Builder;->ensureFieldIsMutable()V

    .line 4247
    iget-object v0, p0, Lcom/google/protobuf/DescriptorProtos$DescriptorProto$Builder;->field_:Ljava/util/List;

    invoke-interface {v0, p1}, Ljava/util/List;->remove(I)Ljava/lang/Object;

    .line 4248
    invoke-virtual {p0}, Lcom/google/protobuf/DescriptorProtos$DescriptorProto$Builder;->onChanged()V

    .line 4252
    :goto_0
    return-object p0

    .line 4250
    :cond_0
    iget-object v0, p0, Lcom/google/protobuf/DescriptorProtos$DescriptorProto$Builder;->fieldBuilder_:Lcom/google/protobuf/RepeatedFieldBuilder;

    invoke-virtual {v0, p1}, Lcom/google/protobuf/RepeatedFieldBuilder;->remove(I)V

    goto :goto_0
.end method

.method public removeNestedType(I)Lcom/google/protobuf/DescriptorProtos$DescriptorProto$Builder;
    .locals 1

    .prologue
    .line 4617
    iget-object v0, p0, Lcom/google/protobuf/DescriptorProtos$DescriptorProto$Builder;->nestedTypeBuilder_:Lcom/google/protobuf/RepeatedFieldBuilder;

    if-nez v0, :cond_0

    .line 4618
    invoke-direct {p0}, Lcom/google/protobuf/DescriptorProtos$DescriptorProto$Builder;->ensureNestedTypeIsMutable()V

    .line 4619
    iget-object v0, p0, Lcom/google/protobuf/DescriptorProtos$DescriptorProto$Builder;->nestedType_:Ljava/util/List;

    invoke-interface {v0, p1}, Ljava/util/List;->remove(I)Ljava/lang/Object;

    .line 4620
    invoke-virtual {p0}, Lcom/google/protobuf/DescriptorProtos$DescriptorProto$Builder;->onChanged()V

    .line 4624
    :goto_0
    return-object p0

    .line 4622
    :cond_0
    iget-object v0, p0, Lcom/google/protobuf/DescriptorProtos$DescriptorProto$Builder;->nestedTypeBuilder_:Lcom/google/protobuf/RepeatedFieldBuilder;

    invoke-virtual {v0, p1}, Lcom/google/protobuf/RepeatedFieldBuilder;->remove(I)V

    goto :goto_0
.end method

.method public setEnumType(ILcom/google/protobuf/DescriptorProtos$EnumDescriptorProto$Builder;)Lcom/google/protobuf/DescriptorProtos$DescriptorProto$Builder;
    .locals 2

    .prologue
    .line 4723
    iget-object v0, p0, Lcom/google/protobuf/DescriptorProtos$DescriptorProto$Builder;->enumTypeBuilder_:Lcom/google/protobuf/RepeatedFieldBuilder;

    if-nez v0, :cond_0

    .line 4724
    invoke-direct {p0}, Lcom/google/protobuf/DescriptorProtos$DescriptorProto$Builder;->ensureEnumTypeIsMutable()V

    .line 4725
    iget-object v0, p0, Lcom/google/protobuf/DescriptorProtos$DescriptorProto$Builder;->enumType_:Ljava/util/List;

    invoke-virtual {p2}, Lcom/google/protobuf/DescriptorProtos$EnumDescriptorProto$Builder;->build()Lcom/google/protobuf/DescriptorProtos$EnumDescriptorProto;

    move-result-object v1

    invoke-interface {v0, p1, v1}, Ljava/util/List;->set(ILjava/lang/Object;)Ljava/lang/Object;

    .line 4726
    invoke-virtual {p0}, Lcom/google/protobuf/DescriptorProtos$DescriptorProto$Builder;->onChanged()V

    .line 4730
    :goto_0
    return-object p0

    .line 4728
    :cond_0
    iget-object v0, p0, Lcom/google/protobuf/DescriptorProtos$DescriptorProto$Builder;->enumTypeBuilder_:Lcom/google/protobuf/RepeatedFieldBuilder;

    invoke-virtual {p2}, Lcom/google/protobuf/DescriptorProtos$EnumDescriptorProto$Builder;->build()Lcom/google/protobuf/DescriptorProtos$EnumDescriptorProto;

    move-result-object v1

    invoke-virtual {v0, p1, v1}, Lcom/google/protobuf/RepeatedFieldBuilder;->setMessage(ILcom/google/protobuf/GeneratedMessage;)Lcom/google/protobuf/RepeatedFieldBuilder;

    goto :goto_0
.end method

.method public setEnumType(ILcom/google/protobuf/DescriptorProtos$EnumDescriptorProto;)Lcom/google/protobuf/DescriptorProtos$DescriptorProto$Builder;
    .locals 1

    .prologue
    .line 4709
    iget-object v0, p0, Lcom/google/protobuf/DescriptorProtos$DescriptorProto$Builder;->enumTypeBuilder_:Lcom/google/protobuf/RepeatedFieldBuilder;

    if-nez v0, :cond_1

    .line 4710
    if-nez p2, :cond_0

    .line 4711
    new-instance v0, Ljava/lang/NullPointerException;

    invoke-direct {v0}, Ljava/lang/NullPointerException;-><init>()V

    throw v0

    .line 4713
    :cond_0
    invoke-direct {p0}, Lcom/google/protobuf/DescriptorProtos$DescriptorProto$Builder;->ensureEnumTypeIsMutable()V

    .line 4714
    iget-object v0, p0, Lcom/google/protobuf/DescriptorProtos$DescriptorProto$Builder;->enumType_:Ljava/util/List;

    invoke-interface {v0, p1, p2}, Ljava/util/List;->set(ILjava/lang/Object;)Ljava/lang/Object;

    .line 4715
    invoke-virtual {p0}, Lcom/google/protobuf/DescriptorProtos$DescriptorProto$Builder;->onChanged()V

    .line 4719
    :goto_0
    return-object p0

    .line 4717
    :cond_1
    iget-object v0, p0, Lcom/google/protobuf/DescriptorProtos$DescriptorProto$Builder;->enumTypeBuilder_:Lcom/google/protobuf/RepeatedFieldBuilder;

    invoke-virtual {v0, p1, p2}, Lcom/google/protobuf/RepeatedFieldBuilder;->setMessage(ILcom/google/protobuf/GeneratedMessage;)Lcom/google/protobuf/RepeatedFieldBuilder;

    goto :goto_0
.end method

.method public setExtension(ILcom/google/protobuf/DescriptorProtos$FieldDescriptorProto$Builder;)Lcom/google/protobuf/DescriptorProtos$DescriptorProto$Builder;
    .locals 2

    .prologue
    .line 4351
    iget-object v0, p0, Lcom/google/protobuf/DescriptorProtos$DescriptorProto$Builder;->extensionBuilder_:Lcom/google/protobuf/RepeatedFieldBuilder;

    if-nez v0, :cond_0

    .line 4352
    invoke-direct {p0}, Lcom/google/protobuf/DescriptorProtos$DescriptorProto$Builder;->ensureExtensionIsMutable()V

    .line 4353
    iget-object v0, p0, Lcom/google/protobuf/DescriptorProtos$DescriptorProto$Builder;->extension_:Ljava/util/List;

    invoke-virtual {p2}, Lcom/google/protobuf/DescriptorProtos$FieldDescriptorProto$Builder;->build()Lcom/google/protobuf/DescriptorProtos$FieldDescriptorProto;

    move-result-object v1

    invoke-interface {v0, p1, v1}, Ljava/util/List;->set(ILjava/lang/Object;)Ljava/lang/Object;

    .line 4354
    invoke-virtual {p0}, Lcom/google/protobuf/DescriptorProtos$DescriptorProto$Builder;->onChanged()V

    .line 4358
    :goto_0
    return-object p0

    .line 4356
    :cond_0
    iget-object v0, p0, Lcom/google/protobuf/DescriptorProtos$DescriptorProto$Builder;->extensionBuilder_:Lcom/google/protobuf/RepeatedFieldBuilder;

    invoke-virtual {p2}, Lcom/google/protobuf/DescriptorProtos$FieldDescriptorProto$Builder;->build()Lcom/google/protobuf/DescriptorProtos$FieldDescriptorProto;

    move-result-object v1

    invoke-virtual {v0, p1, v1}, Lcom/google/protobuf/RepeatedFieldBuilder;->setMessage(ILcom/google/protobuf/GeneratedMessage;)Lcom/google/protobuf/RepeatedFieldBuilder;

    goto :goto_0
.end method

.method public setExtension(ILcom/google/protobuf/DescriptorProtos$FieldDescriptorProto;)Lcom/google/protobuf/DescriptorProtos$DescriptorProto$Builder;
    .locals 1

    .prologue
    .line 4337
    iget-object v0, p0, Lcom/google/protobuf/DescriptorProtos$DescriptorProto$Builder;->extensionBuilder_:Lcom/google/protobuf/RepeatedFieldBuilder;

    if-nez v0, :cond_1

    .line 4338
    if-nez p2, :cond_0

    .line 4339
    new-instance v0, Ljava/lang/NullPointerException;

    invoke-direct {v0}, Ljava/lang/NullPointerException;-><init>()V

    throw v0

    .line 4341
    :cond_0
    invoke-direct {p0}, Lcom/google/protobuf/DescriptorProtos$DescriptorProto$Builder;->ensureExtensionIsMutable()V

    .line 4342
    iget-object v0, p0, Lcom/google/protobuf/DescriptorProtos$DescriptorProto$Builder;->extension_:Ljava/util/List;

    invoke-interface {v0, p1, p2}, Ljava/util/List;->set(ILjava/lang/Object;)Ljava/lang/Object;

    .line 4343
    invoke-virtual {p0}, Lcom/google/protobuf/DescriptorProtos$DescriptorProto$Builder;->onChanged()V

    .line 4347
    :goto_0
    return-object p0

    .line 4345
    :cond_1
    iget-object v0, p0, Lcom/google/protobuf/DescriptorProtos$DescriptorProto$Builder;->extensionBuilder_:Lcom/google/protobuf/RepeatedFieldBuilder;

    invoke-virtual {v0, p1, p2}, Lcom/google/protobuf/RepeatedFieldBuilder;->setMessage(ILcom/google/protobuf/GeneratedMessage;)Lcom/google/protobuf/RepeatedFieldBuilder;

    goto :goto_0
.end method

.method public setExtensionRange(ILcom/google/protobuf/DescriptorProtos$DescriptorProto$ExtensionRange$Builder;)Lcom/google/protobuf/DescriptorProtos$DescriptorProto$Builder;
    .locals 2

    .prologue
    .line 4909
    iget-object v0, p0, Lcom/google/protobuf/DescriptorProtos$DescriptorProto$Builder;->extensionRangeBuilder_:Lcom/google/protobuf/RepeatedFieldBuilder;

    if-nez v0, :cond_0

    .line 4910
    invoke-direct {p0}, Lcom/google/protobuf/DescriptorProtos$DescriptorProto$Builder;->ensureExtensionRangeIsMutable()V

    .line 4911
    iget-object v0, p0, Lcom/google/protobuf/DescriptorProtos$DescriptorProto$Builder;->extensionRange_:Ljava/util/List;

    invoke-virtual {p2}, Lcom/google/protobuf/DescriptorProtos$DescriptorProto$ExtensionRange$Builder;->build()Lcom/google/protobuf/DescriptorProtos$DescriptorProto$ExtensionRange;

    move-result-object v1

    invoke-interface {v0, p1, v1}, Ljava/util/List;->set(ILjava/lang/Object;)Ljava/lang/Object;

    .line 4912
    invoke-virtual {p0}, Lcom/google/protobuf/DescriptorProtos$DescriptorProto$Builder;->onChanged()V

    .line 4916
    :goto_0
    return-object p0

    .line 4914
    :cond_0
    iget-object v0, p0, Lcom/google/protobuf/DescriptorProtos$DescriptorProto$Builder;->extensionRangeBuilder_:Lcom/google/protobuf/RepeatedFieldBuilder;

    invoke-virtual {p2}, Lcom/google/protobuf/DescriptorProtos$DescriptorProto$ExtensionRange$Builder;->build()Lcom/google/protobuf/DescriptorProtos$DescriptorProto$ExtensionRange;

    move-result-object v1

    invoke-virtual {v0, p1, v1}, Lcom/google/protobuf/RepeatedFieldBuilder;->setMessage(ILcom/google/protobuf/GeneratedMessage;)Lcom/google/protobuf/RepeatedFieldBuilder;

    goto :goto_0
.end method

.method public setExtensionRange(ILcom/google/protobuf/DescriptorProtos$DescriptorProto$ExtensionRange;)Lcom/google/protobuf/DescriptorProtos$DescriptorProto$Builder;
    .locals 1

    .prologue
    .line 4895
    iget-object v0, p0, Lcom/google/protobuf/DescriptorProtos$DescriptorProto$Builder;->extensionRangeBuilder_:Lcom/google/protobuf/RepeatedFieldBuilder;

    if-nez v0, :cond_1

    .line 4896
    if-nez p2, :cond_0

    .line 4897
    new-instance v0, Ljava/lang/NullPointerException;

    invoke-direct {v0}, Ljava/lang/NullPointerException;-><init>()V

    throw v0

    .line 4899
    :cond_0
    invoke-direct {p0}, Lcom/google/protobuf/DescriptorProtos$DescriptorProto$Builder;->ensureExtensionRangeIsMutable()V

    .line 4900
    iget-object v0, p0, Lcom/google/protobuf/DescriptorProtos$DescriptorProto$Builder;->extensionRange_:Ljava/util/List;

    invoke-interface {v0, p1, p2}, Ljava/util/List;->set(ILjava/lang/Object;)Ljava/lang/Object;

    .line 4901
    invoke-virtual {p0}, Lcom/google/protobuf/DescriptorProtos$DescriptorProto$Builder;->onChanged()V

    .line 4905
    :goto_0
    return-object p0

    .line 4903
    :cond_1
    iget-object v0, p0, Lcom/google/protobuf/DescriptorProtos$DescriptorProto$Builder;->extensionRangeBuilder_:Lcom/google/protobuf/RepeatedFieldBuilder;

    invoke-virtual {v0, p1, p2}, Lcom/google/protobuf/RepeatedFieldBuilder;->setMessage(ILcom/google/protobuf/GeneratedMessage;)Lcom/google/protobuf/RepeatedFieldBuilder;

    goto :goto_0
.end method

.method public setField(ILcom/google/protobuf/DescriptorProtos$FieldDescriptorProto$Builder;)Lcom/google/protobuf/DescriptorProtos$DescriptorProto$Builder;
    .locals 2

    .prologue
    .line 4165
    iget-object v0, p0, Lcom/google/protobuf/DescriptorProtos$DescriptorProto$Builder;->fieldBuilder_:Lcom/google/protobuf/RepeatedFieldBuilder;

    if-nez v0, :cond_0

    .line 4166
    invoke-direct {p0}, Lcom/google/protobuf/DescriptorProtos$DescriptorProto$Builder;->ensureFieldIsMutable()V

    .line 4167
    iget-object v0, p0, Lcom/google/protobuf/DescriptorProtos$DescriptorProto$Builder;->field_:Ljava/util/List;

    invoke-virtual {p2}, Lcom/google/protobuf/DescriptorProtos$FieldDescriptorProto$Builder;->build()Lcom/google/protobuf/DescriptorProtos$FieldDescriptorProto;

    move-result-object v1

    invoke-interface {v0, p1, v1}, Ljava/util/List;->set(ILjava/lang/Object;)Ljava/lang/Object;

    .line 4168
    invoke-virtual {p0}, Lcom/google/protobuf/DescriptorProtos$DescriptorProto$Builder;->onChanged()V

    .line 4172
    :goto_0
    return-object p0

    .line 4170
    :cond_0
    iget-object v0, p0, Lcom/google/protobuf/DescriptorProtos$DescriptorProto$Builder;->fieldBuilder_:Lcom/google/protobuf/RepeatedFieldBuilder;

    invoke-virtual {p2}, Lcom/google/protobuf/DescriptorProtos$FieldDescriptorProto$Builder;->build()Lcom/google/protobuf/DescriptorProtos$FieldDescriptorProto;

    move-result-object v1

    invoke-virtual {v0, p1, v1}, Lcom/google/protobuf/RepeatedFieldBuilder;->setMessage(ILcom/google/protobuf/GeneratedMessage;)Lcom/google/protobuf/RepeatedFieldBuilder;

    goto :goto_0
.end method

.method public setField(ILcom/google/protobuf/DescriptorProtos$FieldDescriptorProto;)Lcom/google/protobuf/DescriptorProtos$DescriptorProto$Builder;
    .locals 1

    .prologue
    .line 4151
    iget-object v0, p0, Lcom/google/protobuf/DescriptorProtos$DescriptorProto$Builder;->fieldBuilder_:Lcom/google/protobuf/RepeatedFieldBuilder;

    if-nez v0, :cond_1

    .line 4152
    if-nez p2, :cond_0

    .line 4153
    new-instance v0, Ljava/lang/NullPointerException;

    invoke-direct {v0}, Ljava/lang/NullPointerException;-><init>()V

    throw v0

    .line 4155
    :cond_0
    invoke-direct {p0}, Lcom/google/protobuf/DescriptorProtos$DescriptorProto$Builder;->ensureFieldIsMutable()V

    .line 4156
    iget-object v0, p0, Lcom/google/protobuf/DescriptorProtos$DescriptorProto$Builder;->field_:Ljava/util/List;

    invoke-interface {v0, p1, p2}, Ljava/util/List;->set(ILjava/lang/Object;)Ljava/lang/Object;

    .line 4157
    invoke-virtual {p0}, Lcom/google/protobuf/DescriptorProtos$DescriptorProto$Builder;->onChanged()V

    .line 4161
    :goto_0
    return-object p0

    .line 4159
    :cond_1
    iget-object v0, p0, Lcom/google/protobuf/DescriptorProtos$DescriptorProto$Builder;->fieldBuilder_:Lcom/google/protobuf/RepeatedFieldBuilder;

    invoke-virtual {v0, p1, p2}, Lcom/google/protobuf/RepeatedFieldBuilder;->setMessage(ILcom/google/protobuf/GeneratedMessage;)Lcom/google/protobuf/RepeatedFieldBuilder;

    goto :goto_0
.end method

.method public setName(Ljava/lang/String;)Lcom/google/protobuf/DescriptorProtos$DescriptorProto$Builder;
    .locals 1

    .prologue
    .line 4095
    if-nez p1, :cond_0

    .line 4096
    new-instance v0, Ljava/lang/NullPointerException;

    invoke-direct {v0}, Ljava/lang/NullPointerException;-><init>()V

    throw v0

    .line 4098
    :cond_0
    iget v0, p0, Lcom/google/protobuf/DescriptorProtos$DescriptorProto$Builder;->bitField0_:I

    or-int/lit8 v0, v0, 0x1

    iput v0, p0, Lcom/google/protobuf/DescriptorProtos$DescriptorProto$Builder;->bitField0_:I

    .line 4099
    iput-object p1, p0, Lcom/google/protobuf/DescriptorProtos$DescriptorProto$Builder;->name_:Ljava/lang/Object;

    .line 4100
    invoke-virtual {p0}, Lcom/google/protobuf/DescriptorProtos$DescriptorProto$Builder;->onChanged()V

    .line 4101
    return-object p0
.end method

.method setName(Lcom/google/protobuf/ByteString;)V
    .locals 1

    .prologue
    .line 4110
    iget v0, p0, Lcom/google/protobuf/DescriptorProtos$DescriptorProto$Builder;->bitField0_:I

    or-int/lit8 v0, v0, 0x1

    iput v0, p0, Lcom/google/protobuf/DescriptorProtos$DescriptorProto$Builder;->bitField0_:I

    .line 4111
    iput-object p1, p0, Lcom/google/protobuf/DescriptorProtos$DescriptorProto$Builder;->name_:Ljava/lang/Object;

    .line 4112
    invoke-virtual {p0}, Lcom/google/protobuf/DescriptorProtos$DescriptorProto$Builder;->onChanged()V

    .line 4113
    return-void
.end method

.method public setNestedType(ILcom/google/protobuf/DescriptorProtos$DescriptorProto$Builder;)Lcom/google/protobuf/DescriptorProtos$DescriptorProto$Builder;
    .locals 2

    .prologue
    .line 4537
    iget-object v0, p0, Lcom/google/protobuf/DescriptorProtos$DescriptorProto$Builder;->nestedTypeBuilder_:Lcom/google/protobuf/RepeatedFieldBuilder;

    if-nez v0, :cond_0

    .line 4538
    invoke-direct {p0}, Lcom/google/protobuf/DescriptorProtos$DescriptorProto$Builder;->ensureNestedTypeIsMutable()V

    .line 4539
    iget-object v0, p0, Lcom/google/protobuf/DescriptorProtos$DescriptorProto$Builder;->nestedType_:Ljava/util/List;

    invoke-virtual {p2}, Lcom/google/protobuf/DescriptorProtos$DescriptorProto$Builder;->build()Lcom/google/protobuf/DescriptorProtos$DescriptorProto;

    move-result-object v1

    invoke-interface {v0, p1, v1}, Ljava/util/List;->set(ILjava/lang/Object;)Ljava/lang/Object;

    .line 4540
    invoke-virtual {p0}, Lcom/google/protobuf/DescriptorProtos$DescriptorProto$Builder;->onChanged()V

    .line 4544
    :goto_0
    return-object p0

    .line 4542
    :cond_0
    iget-object v0, p0, Lcom/google/protobuf/DescriptorProtos$DescriptorProto$Builder;->nestedTypeBuilder_:Lcom/google/protobuf/RepeatedFieldBuilder;

    invoke-virtual {p2}, Lcom/google/protobuf/DescriptorProtos$DescriptorProto$Builder;->build()Lcom/google/protobuf/DescriptorProtos$DescriptorProto;

    move-result-object v1

    invoke-virtual {v0, p1, v1}, Lcom/google/protobuf/RepeatedFieldBuilder;->setMessage(ILcom/google/protobuf/GeneratedMessage;)Lcom/google/protobuf/RepeatedFieldBuilder;

    goto :goto_0
.end method

.method public setNestedType(ILcom/google/protobuf/DescriptorProtos$DescriptorProto;)Lcom/google/protobuf/DescriptorProtos$DescriptorProto$Builder;
    .locals 1

    .prologue
    .line 4523
    iget-object v0, p0, Lcom/google/protobuf/DescriptorProtos$DescriptorProto$Builder;->nestedTypeBuilder_:Lcom/google/protobuf/RepeatedFieldBuilder;

    if-nez v0, :cond_1

    .line 4524
    if-nez p2, :cond_0

    .line 4525
    new-instance v0, Ljava/lang/NullPointerException;

    invoke-direct {v0}, Ljava/lang/NullPointerException;-><init>()V

    throw v0

    .line 4527
    :cond_0
    invoke-direct {p0}, Lcom/google/protobuf/DescriptorProtos$DescriptorProto$Builder;->ensureNestedTypeIsMutable()V

    .line 4528
    iget-object v0, p0, Lcom/google/protobuf/DescriptorProtos$DescriptorProto$Builder;->nestedType_:Ljava/util/List;

    invoke-interface {v0, p1, p2}, Ljava/util/List;->set(ILjava/lang/Object;)Ljava/lang/Object;

    .line 4529
    invoke-virtual {p0}, Lcom/google/protobuf/DescriptorProtos$DescriptorProto$Builder;->onChanged()V

    .line 4533
    :goto_0
    return-object p0

    .line 4531
    :cond_1
    iget-object v0, p0, Lcom/google/protobuf/DescriptorProtos$DescriptorProto$Builder;->nestedTypeBuilder_:Lcom/google/protobuf/RepeatedFieldBuilder;

    invoke-virtual {v0, p1, p2}, Lcom/google/protobuf/RepeatedFieldBuilder;->setMessage(ILcom/google/protobuf/GeneratedMessage;)Lcom/google/protobuf/RepeatedFieldBuilder;

    goto :goto_0
.end method

.method public setOptions(Lcom/google/protobuf/DescriptorProtos$MessageOptions$Builder;)Lcom/google/protobuf/DescriptorProtos$DescriptorProto$Builder;
    .locals 2

    .prologue
    .line 5074
    iget-object v0, p0, Lcom/google/protobuf/DescriptorProtos$DescriptorProto$Builder;->optionsBuilder_:Lcom/google/protobuf/SingleFieldBuilder;

    if-nez v0, :cond_0

    .line 5075
    invoke-virtual {p1}, Lcom/google/protobuf/DescriptorProtos$MessageOptions$Builder;->build()Lcom/google/protobuf/DescriptorProtos$MessageOptions;

    move-result-object v0

    iput-object v0, p0, Lcom/google/protobuf/DescriptorProtos$DescriptorProto$Builder;->options_:Lcom/google/protobuf/DescriptorProtos$MessageOptions;

    .line 5076
    invoke-virtual {p0}, Lcom/google/protobuf/DescriptorProtos$DescriptorProto$Builder;->onChanged()V

    .line 5080
    :goto_0
    iget v0, p0, Lcom/google/protobuf/DescriptorProtos$DescriptorProto$Builder;->bitField0_:I

    or-int/lit8 v0, v0, 0x40

    iput v0, p0, Lcom/google/protobuf/DescriptorProtos$DescriptorProto$Builder;->bitField0_:I

    .line 5081
    return-object p0

    .line 5078
    :cond_0
    iget-object v0, p0, Lcom/google/protobuf/DescriptorProtos$DescriptorProto$Builder;->optionsBuilder_:Lcom/google/protobuf/SingleFieldBuilder;

    invoke-virtual {p1}, Lcom/google/protobuf/DescriptorProtos$MessageOptions$Builder;->build()Lcom/google/protobuf/DescriptorProtos$MessageOptions;

    move-result-object v1

    invoke-virtual {v0, v1}, Lcom/google/protobuf/SingleFieldBuilder;->setMessage(Lcom/google/protobuf/GeneratedMessage;)Lcom/google/protobuf/SingleFieldBuilder;

    goto :goto_0
.end method

.method public setOptions(Lcom/google/protobuf/DescriptorProtos$MessageOptions;)Lcom/google/protobuf/DescriptorProtos$DescriptorProto$Builder;
    .locals 1

    .prologue
    .line 5060
    iget-object v0, p0, Lcom/google/protobuf/DescriptorProtos$DescriptorProto$Builder;->optionsBuilder_:Lcom/google/protobuf/SingleFieldBuilder;

    if-nez v0, :cond_1

    .line 5061
    if-nez p1, :cond_0

    .line 5062
    new-instance v0, Ljava/lang/NullPointerException;

    invoke-direct {v0}, Ljava/lang/NullPointerException;-><init>()V

    throw v0

    .line 5064
    :cond_0
    iput-object p1, p0, Lcom/google/protobuf/DescriptorProtos$DescriptorProto$Builder;->options_:Lcom/google/protobuf/DescriptorProtos$MessageOptions;

    .line 5065
    invoke-virtual {p0}, Lcom/google/protobuf/DescriptorProtos$DescriptorProto$Builder;->onChanged()V

    .line 5069
    :goto_0
    iget v0, p0, Lcom/google/protobuf/DescriptorProtos$DescriptorProto$Builder;->bitField0_:I

    or-int/lit8 v0, v0, 0x40

    iput v0, p0, Lcom/google/protobuf/DescriptorProtos$DescriptorProto$Builder;->bitField0_:I

    .line 5070
    return-object p0

    .line 5067
    :cond_1
    iget-object v0, p0, Lcom/google/protobuf/DescriptorProtos$DescriptorProto$Builder;->optionsBuilder_:Lcom/google/protobuf/SingleFieldBuilder;

    invoke-virtual {v0, p1}, Lcom/google/protobuf/SingleFieldBuilder;->setMessage(Lcom/google/protobuf/GeneratedMessage;)Lcom/google/protobuf/SingleFieldBuilder;

    goto :goto_0
.end method
