.class public final Lcom/google/protobuf/DescriptorProtos$SourceCodeInfo$Location$Builder;
.super Lcom/google/protobuf/GeneratedMessage$Builder;
.source "SourceFile"

# interfaces
.implements Lcom/google/protobuf/DescriptorProtos$SourceCodeInfo$LocationOrBuilder;


# annotations
.annotation system Ldalvik/annotation/EnclosingClass;
    value = Lcom/google/protobuf/DescriptorProtos$SourceCodeInfo$Location;
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x19
    name = "Builder"
.end annotation

.annotation system Ldalvik/annotation/Signature;
    value = {
        "Lcom/google/protobuf/GeneratedMessage$Builder",
        "<",
        "Lcom/google/protobuf/DescriptorProtos$SourceCodeInfo$Location$Builder;",
        ">;",
        "Lcom/google/protobuf/DescriptorProtos$SourceCodeInfo$LocationOrBuilder;"
    }
.end annotation


# instance fields
.field private bitField0_:I

.field private leadingComments_:Ljava/lang/Object;

.field private path_:Ljava/util/List;
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "Ljava/util/List",
            "<",
            "Ljava/lang/Integer;",
            ">;"
        }
    .end annotation
.end field

.field private span_:Ljava/util/List;
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "Ljava/util/List",
            "<",
            "Ljava/lang/Integer;",
            ">;"
        }
    .end annotation
.end field

.field private trailingComments_:Ljava/lang/Object;


# direct methods
.method private constructor <init>()V
    .locals 1

    .prologue
    .line 16472
    invoke-direct {p0}, Lcom/google/protobuf/GeneratedMessage$Builder;-><init>()V

    .line 16672
    invoke-static {}, Ljava/util/Collections;->emptyList()Ljava/util/List;

    move-result-object v0

    iput-object v0, p0, Lcom/google/protobuf/DescriptorProtos$SourceCodeInfo$Location$Builder;->path_:Ljava/util/List;

    .line 16717
    invoke-static {}, Ljava/util/Collections;->emptyList()Ljava/util/List;

    move-result-object v0

    iput-object v0, p0, Lcom/google/protobuf/DescriptorProtos$SourceCodeInfo$Location$Builder;->span_:Ljava/util/List;

    .line 16762
    const-string v0, ""

    iput-object v0, p0, Lcom/google/protobuf/DescriptorProtos$SourceCodeInfo$Location$Builder;->leadingComments_:Ljava/lang/Object;

    .line 16798
    const-string v0, ""

    iput-object v0, p0, Lcom/google/protobuf/DescriptorProtos$SourceCodeInfo$Location$Builder;->trailingComments_:Ljava/lang/Object;

    .line 16473
    invoke-direct {p0}, Lcom/google/protobuf/DescriptorProtos$SourceCodeInfo$Location$Builder;->maybeForceBuilderInitialization()V

    .line 16474
    return-void
.end method

.method private constructor <init>(Lcom/google/protobuf/GeneratedMessage$BuilderParent;)V
    .locals 1

    .prologue
    .line 16477
    invoke-direct {p0, p1}, Lcom/google/protobuf/GeneratedMessage$Builder;-><init>(Lcom/google/protobuf/GeneratedMessage$BuilderParent;)V

    .line 16672
    invoke-static {}, Ljava/util/Collections;->emptyList()Ljava/util/List;

    move-result-object v0

    iput-object v0, p0, Lcom/google/protobuf/DescriptorProtos$SourceCodeInfo$Location$Builder;->path_:Ljava/util/List;

    .line 16717
    invoke-static {}, Ljava/util/Collections;->emptyList()Ljava/util/List;

    move-result-object v0

    iput-object v0, p0, Lcom/google/protobuf/DescriptorProtos$SourceCodeInfo$Location$Builder;->span_:Ljava/util/List;

    .line 16762
    const-string v0, ""

    iput-object v0, p0, Lcom/google/protobuf/DescriptorProtos$SourceCodeInfo$Location$Builder;->leadingComments_:Ljava/lang/Object;

    .line 16798
    const-string v0, ""

    iput-object v0, p0, Lcom/google/protobuf/DescriptorProtos$SourceCodeInfo$Location$Builder;->trailingComments_:Ljava/lang/Object;

    .line 16478
    invoke-direct {p0}, Lcom/google/protobuf/DescriptorProtos$SourceCodeInfo$Location$Builder;->maybeForceBuilderInitialization()V

    .line 16479
    return-void
.end method

.method synthetic constructor <init>(Lcom/google/protobuf/GeneratedMessage$BuilderParent;Lcom/google/protobuf/DescriptorProtos$SourceCodeInfo$Location$Builder;)V
    .locals 0

    .prologue
    .line 16476
    invoke-direct {p0, p1}, Lcom/google/protobuf/DescriptorProtos$SourceCodeInfo$Location$Builder;-><init>(Lcom/google/protobuf/GeneratedMessage$BuilderParent;)V

    return-void
.end method

.method static synthetic access$17(Lcom/google/protobuf/DescriptorProtos$SourceCodeInfo$Location$Builder;)Lcom/google/protobuf/DescriptorProtos$SourceCodeInfo$Location;
    .locals 1
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Lcom/google/protobuf/InvalidProtocolBufferException;
        }
    .end annotation

    .prologue
    .line 16522
    invoke-direct {p0}, Lcom/google/protobuf/DescriptorProtos$SourceCodeInfo$Location$Builder;->buildParsed()Lcom/google/protobuf/DescriptorProtos$SourceCodeInfo$Location;

    move-result-object v0

    return-object v0
.end method

.method static synthetic access$18()Lcom/google/protobuf/DescriptorProtos$SourceCodeInfo$Location$Builder;
    .locals 1

    .prologue
    .line 16484
    invoke-static {}, Lcom/google/protobuf/DescriptorProtos$SourceCodeInfo$Location$Builder;->create()Lcom/google/protobuf/DescriptorProtos$SourceCodeInfo$Location$Builder;

    move-result-object v0

    return-object v0
.end method

.method private buildParsed()Lcom/google/protobuf/DescriptorProtos$SourceCodeInfo$Location;
    .locals 2
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Lcom/google/protobuf/InvalidProtocolBufferException;
        }
    .end annotation

    .prologue
    .line 16524
    invoke-virtual {p0}, Lcom/google/protobuf/DescriptorProtos$SourceCodeInfo$Location$Builder;->buildPartial()Lcom/google/protobuf/DescriptorProtos$SourceCodeInfo$Location;

    move-result-object v0

    .line 16525
    invoke-virtual {v0}, Lcom/google/protobuf/DescriptorProtos$SourceCodeInfo$Location;->isInitialized()Z

    move-result v1

    if-nez v1, :cond_0

    .line 16526
    invoke-static {v0}, Lcom/google/protobuf/DescriptorProtos$SourceCodeInfo$Location$Builder;->newUninitializedMessageException(Lcom/google/protobuf/Message;)Lcom/google/protobuf/UninitializedMessageException;

    move-result-object v0

    .line 16527
    invoke-virtual {v0}, Lcom/google/protobuf/UninitializedMessageException;->asInvalidProtocolBufferException()Lcom/google/protobuf/InvalidProtocolBufferException;

    move-result-object v0

    .line 16526
    throw v0

    .line 16529
    :cond_0
    return-object v0
.end method

.method private static create()Lcom/google/protobuf/DescriptorProtos$SourceCodeInfo$Location$Builder;
    .locals 1

    .prologue
    .line 16485
    new-instance v0, Lcom/google/protobuf/DescriptorProtos$SourceCodeInfo$Location$Builder;

    invoke-direct {v0}, Lcom/google/protobuf/DescriptorProtos$SourceCodeInfo$Location$Builder;-><init>()V

    return-object v0
.end method

.method private ensurePathIsMutable()V
    .locals 2

    .prologue
    .line 16674
    iget v0, p0, Lcom/google/protobuf/DescriptorProtos$SourceCodeInfo$Location$Builder;->bitField0_:I

    and-int/lit8 v0, v0, 0x1

    const/4 v1, 0x1

    if-eq v0, v1, :cond_0

    .line 16675
    new-instance v0, Ljava/util/ArrayList;

    iget-object v1, p0, Lcom/google/protobuf/DescriptorProtos$SourceCodeInfo$Location$Builder;->path_:Ljava/util/List;

    invoke-direct {v0, v1}, Ljava/util/ArrayList;-><init>(Ljava/util/Collection;)V

    iput-object v0, p0, Lcom/google/protobuf/DescriptorProtos$SourceCodeInfo$Location$Builder;->path_:Ljava/util/List;

    .line 16676
    iget v0, p0, Lcom/google/protobuf/DescriptorProtos$SourceCodeInfo$Location$Builder;->bitField0_:I

    or-int/lit8 v0, v0, 0x1

    iput v0, p0, Lcom/google/protobuf/DescriptorProtos$SourceCodeInfo$Location$Builder;->bitField0_:I

    .line 16678
    :cond_0
    return-void
.end method

.method private ensureSpanIsMutable()V
    .locals 2

    .prologue
    .line 16719
    iget v0, p0, Lcom/google/protobuf/DescriptorProtos$SourceCodeInfo$Location$Builder;->bitField0_:I

    and-int/lit8 v0, v0, 0x2

    const/4 v1, 0x2

    if-eq v0, v1, :cond_0

    .line 16720
    new-instance v0, Ljava/util/ArrayList;

    iget-object v1, p0, Lcom/google/protobuf/DescriptorProtos$SourceCodeInfo$Location$Builder;->span_:Ljava/util/List;

    invoke-direct {v0, v1}, Ljava/util/ArrayList;-><init>(Ljava/util/Collection;)V

    iput-object v0, p0, Lcom/google/protobuf/DescriptorProtos$SourceCodeInfo$Location$Builder;->span_:Ljava/util/List;

    .line 16721
    iget v0, p0, Lcom/google/protobuf/DescriptorProtos$SourceCodeInfo$Location$Builder;->bitField0_:I

    or-int/lit8 v0, v0, 0x2

    iput v0, p0, Lcom/google/protobuf/DescriptorProtos$SourceCodeInfo$Location$Builder;->bitField0_:I

    .line 16723
    :cond_0
    return-void
.end method

.method public static final getDescriptor()Lcom/google/protobuf/Descriptors$Descriptor;
    .locals 1

    .prologue
    .line 16463
    invoke-static {}, Lcom/google/protobuf/DescriptorProtos;->access$59()Lcom/google/protobuf/Descriptors$Descriptor;

    move-result-object v0

    return-object v0
.end method

.method private maybeForceBuilderInitialization()V
    .locals 1

    .prologue
    .line 16481
    sget-boolean v0, Lcom/google/protobuf/GeneratedMessage;->alwaysUseFieldBuilders:Z

    .line 16483
    return-void
.end method


# virtual methods
.method public addAllPath(Ljava/lang/Iterable;)Lcom/google/protobuf/DescriptorProtos$SourceCodeInfo$Location$Builder;
    .locals 1
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "(",
            "Ljava/lang/Iterable",
            "<+",
            "Ljava/lang/Integer;",
            ">;)",
            "Lcom/google/protobuf/DescriptorProtos$SourceCodeInfo$Location$Builder;"
        }
    .end annotation

    .prologue
    .line 16704
    invoke-direct {p0}, Lcom/google/protobuf/DescriptorProtos$SourceCodeInfo$Location$Builder;->ensurePathIsMutable()V

    .line 16705
    iget-object v0, p0, Lcom/google/protobuf/DescriptorProtos$SourceCodeInfo$Location$Builder;->path_:Ljava/util/List;

    invoke-static {p1, v0}, Lcom/google/protobuf/GeneratedMessage$Builder;->addAll(Ljava/lang/Iterable;Ljava/util/Collection;)V

    .line 16706
    invoke-virtual {p0}, Lcom/google/protobuf/DescriptorProtos$SourceCodeInfo$Location$Builder;->onChanged()V

    .line 16707
    return-object p0
.end method

.method public addAllSpan(Ljava/lang/Iterable;)Lcom/google/protobuf/DescriptorProtos$SourceCodeInfo$Location$Builder;
    .locals 1
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "(",
            "Ljava/lang/Iterable",
            "<+",
            "Ljava/lang/Integer;",
            ">;)",
            "Lcom/google/protobuf/DescriptorProtos$SourceCodeInfo$Location$Builder;"
        }
    .end annotation

    .prologue
    .line 16749
    invoke-direct {p0}, Lcom/google/protobuf/DescriptorProtos$SourceCodeInfo$Location$Builder;->ensureSpanIsMutable()V

    .line 16750
    iget-object v0, p0, Lcom/google/protobuf/DescriptorProtos$SourceCodeInfo$Location$Builder;->span_:Ljava/util/List;

    invoke-static {p1, v0}, Lcom/google/protobuf/GeneratedMessage$Builder;->addAll(Ljava/lang/Iterable;Ljava/util/Collection;)V

    .line 16751
    invoke-virtual {p0}, Lcom/google/protobuf/DescriptorProtos$SourceCodeInfo$Location$Builder;->onChanged()V

    .line 16752
    return-object p0
.end method

.method public addPath(I)Lcom/google/protobuf/DescriptorProtos$SourceCodeInfo$Location$Builder;
    .locals 2

    .prologue
    .line 16697
    invoke-direct {p0}, Lcom/google/protobuf/DescriptorProtos$SourceCodeInfo$Location$Builder;->ensurePathIsMutable()V

    .line 16698
    iget-object v0, p0, Lcom/google/protobuf/DescriptorProtos$SourceCodeInfo$Location$Builder;->path_:Ljava/util/List;

    invoke-static {p1}, Ljava/lang/Integer;->valueOf(I)Ljava/lang/Integer;

    move-result-object v1

    invoke-interface {v0, v1}, Ljava/util/List;->add(Ljava/lang/Object;)Z

    .line 16699
    invoke-virtual {p0}, Lcom/google/protobuf/DescriptorProtos$SourceCodeInfo$Location$Builder;->onChanged()V

    .line 16700
    return-object p0
.end method

.method public addSpan(I)Lcom/google/protobuf/DescriptorProtos$SourceCodeInfo$Location$Builder;
    .locals 2

    .prologue
    .line 16742
    invoke-direct {p0}, Lcom/google/protobuf/DescriptorProtos$SourceCodeInfo$Location$Builder;->ensureSpanIsMutable()V

    .line 16743
    iget-object v0, p0, Lcom/google/protobuf/DescriptorProtos$SourceCodeInfo$Location$Builder;->span_:Ljava/util/List;

    invoke-static {p1}, Ljava/lang/Integer;->valueOf(I)Ljava/lang/Integer;

    move-result-object v1

    invoke-interface {v0, v1}, Ljava/util/List;->add(Ljava/lang/Object;)Z

    .line 16744
    invoke-virtual {p0}, Lcom/google/protobuf/DescriptorProtos$SourceCodeInfo$Location$Builder;->onChanged()V

    .line 16745
    return-object p0
.end method

.method public build()Lcom/google/protobuf/DescriptorProtos$SourceCodeInfo$Location;
    .locals 2

    .prologue
    .line 16515
    invoke-virtual {p0}, Lcom/google/protobuf/DescriptorProtos$SourceCodeInfo$Location$Builder;->buildPartial()Lcom/google/protobuf/DescriptorProtos$SourceCodeInfo$Location;

    move-result-object v0

    .line 16516
    invoke-virtual {v0}, Lcom/google/protobuf/DescriptorProtos$SourceCodeInfo$Location;->isInitialized()Z

    move-result v1

    if-nez v1, :cond_0

    .line 16517
    invoke-static {v0}, Lcom/google/protobuf/DescriptorProtos$SourceCodeInfo$Location$Builder;->newUninitializedMessageException(Lcom/google/protobuf/Message;)Lcom/google/protobuf/UninitializedMessageException;

    move-result-object v0

    throw v0

    .line 16519
    :cond_0
    return-object v0
.end method

.method public bridge synthetic build()Lcom/google/protobuf/Message;
    .locals 1

    .prologue
    .line 1
    invoke-virtual {p0}, Lcom/google/protobuf/DescriptorProtos$SourceCodeInfo$Location$Builder;->build()Lcom/google/protobuf/DescriptorProtos$SourceCodeInfo$Location;

    move-result-object v0

    return-object v0
.end method

.method public bridge synthetic build()Lcom/google/protobuf/MessageLite;
    .locals 1

    .prologue
    .line 1
    invoke-virtual {p0}, Lcom/google/protobuf/DescriptorProtos$SourceCodeInfo$Location$Builder;->build()Lcom/google/protobuf/DescriptorProtos$SourceCodeInfo$Location;

    move-result-object v0

    return-object v0
.end method

.method public buildPartial()Lcom/google/protobuf/DescriptorProtos$SourceCodeInfo$Location;
    .locals 6

    .prologue
    const/4 v0, 0x1

    .line 16533
    new-instance v2, Lcom/google/protobuf/DescriptorProtos$SourceCodeInfo$Location;

    const/4 v1, 0x0

    invoke-direct {v2, p0, v1}, Lcom/google/protobuf/DescriptorProtos$SourceCodeInfo$Location;-><init>(Lcom/google/protobuf/DescriptorProtos$SourceCodeInfo$Location$Builder;Lcom/google/protobuf/DescriptorProtos$SourceCodeInfo$Location;)V

    .line 16534
    iget v3, p0, Lcom/google/protobuf/DescriptorProtos$SourceCodeInfo$Location$Builder;->bitField0_:I

    .line 16535
    const/4 v1, 0x0

    .line 16536
    iget v4, p0, Lcom/google/protobuf/DescriptorProtos$SourceCodeInfo$Location$Builder;->bitField0_:I

    and-int/lit8 v4, v4, 0x1

    if-ne v4, v0, :cond_0

    .line 16537
    iget-object v4, p0, Lcom/google/protobuf/DescriptorProtos$SourceCodeInfo$Location$Builder;->path_:Ljava/util/List;

    invoke-static {v4}, Ljava/util/Collections;->unmodifiableList(Ljava/util/List;)Ljava/util/List;

    move-result-object v4

    iput-object v4, p0, Lcom/google/protobuf/DescriptorProtos$SourceCodeInfo$Location$Builder;->path_:Ljava/util/List;

    .line 16538
    iget v4, p0, Lcom/google/protobuf/DescriptorProtos$SourceCodeInfo$Location$Builder;->bitField0_:I

    and-int/lit8 v4, v4, -0x2

    iput v4, p0, Lcom/google/protobuf/DescriptorProtos$SourceCodeInfo$Location$Builder;->bitField0_:I

    .line 16540
    :cond_0
    iget-object v4, p0, Lcom/google/protobuf/DescriptorProtos$SourceCodeInfo$Location$Builder;->path_:Ljava/util/List;

    invoke-static {v2, v4}, Lcom/google/protobuf/DescriptorProtos$SourceCodeInfo$Location;->access$8(Lcom/google/protobuf/DescriptorProtos$SourceCodeInfo$Location;Ljava/util/List;)V

    .line 16541
    iget v4, p0, Lcom/google/protobuf/DescriptorProtos$SourceCodeInfo$Location$Builder;->bitField0_:I

    and-int/lit8 v4, v4, 0x2

    const/4 v5, 0x2

    if-ne v4, v5, :cond_1

    .line 16542
    iget-object v4, p0, Lcom/google/protobuf/DescriptorProtos$SourceCodeInfo$Location$Builder;->span_:Ljava/util/List;

    invoke-static {v4}, Ljava/util/Collections;->unmodifiableList(Ljava/util/List;)Ljava/util/List;

    move-result-object v4

    iput-object v4, p0, Lcom/google/protobuf/DescriptorProtos$SourceCodeInfo$Location$Builder;->span_:Ljava/util/List;

    .line 16543
    iget v4, p0, Lcom/google/protobuf/DescriptorProtos$SourceCodeInfo$Location$Builder;->bitField0_:I

    and-int/lit8 v4, v4, -0x3

    iput v4, p0, Lcom/google/protobuf/DescriptorProtos$SourceCodeInfo$Location$Builder;->bitField0_:I

    .line 16545
    :cond_1
    iget-object v4, p0, Lcom/google/protobuf/DescriptorProtos$SourceCodeInfo$Location$Builder;->span_:Ljava/util/List;

    invoke-static {v2, v4}, Lcom/google/protobuf/DescriptorProtos$SourceCodeInfo$Location;->access$9(Lcom/google/protobuf/DescriptorProtos$SourceCodeInfo$Location;Ljava/util/List;)V

    .line 16546
    and-int/lit8 v4, v3, 0x4

    const/4 v5, 0x4

    if-ne v4, v5, :cond_3

    .line 16549
    :goto_0
    iget-object v1, p0, Lcom/google/protobuf/DescriptorProtos$SourceCodeInfo$Location$Builder;->leadingComments_:Ljava/lang/Object;

    invoke-static {v2, v1}, Lcom/google/protobuf/DescriptorProtos$SourceCodeInfo$Location;->access$10(Lcom/google/protobuf/DescriptorProtos$SourceCodeInfo$Location;Ljava/lang/Object;)V

    .line 16550
    and-int/lit8 v1, v3, 0x8

    const/16 v3, 0x8

    if-ne v1, v3, :cond_2

    .line 16551
    or-int/lit8 v0, v0, 0x2

    .line 16553
    :cond_2
    iget-object v1, p0, Lcom/google/protobuf/DescriptorProtos$SourceCodeInfo$Location$Builder;->trailingComments_:Ljava/lang/Object;

    invoke-static {v2, v1}, Lcom/google/protobuf/DescriptorProtos$SourceCodeInfo$Location;->access$11(Lcom/google/protobuf/DescriptorProtos$SourceCodeInfo$Location;Ljava/lang/Object;)V

    .line 16554
    invoke-static {v2, v0}, Lcom/google/protobuf/DescriptorProtos$SourceCodeInfo$Location;->access$12(Lcom/google/protobuf/DescriptorProtos$SourceCodeInfo$Location;I)V

    .line 16555
    invoke-virtual {p0}, Lcom/google/protobuf/DescriptorProtos$SourceCodeInfo$Location$Builder;->onBuilt()V

    .line 16556
    return-object v2

    :cond_3
    move v0, v1

    goto :goto_0
.end method

.method public bridge synthetic buildPartial()Lcom/google/protobuf/Message;
    .locals 1

    .prologue
    .line 1
    invoke-virtual {p0}, Lcom/google/protobuf/DescriptorProtos$SourceCodeInfo$Location$Builder;->buildPartial()Lcom/google/protobuf/DescriptorProtos$SourceCodeInfo$Location;

    move-result-object v0

    return-object v0
.end method

.method public bridge synthetic buildPartial()Lcom/google/protobuf/MessageLite;
    .locals 1

    .prologue
    .line 1
    invoke-virtual {p0}, Lcom/google/protobuf/DescriptorProtos$SourceCodeInfo$Location$Builder;->buildPartial()Lcom/google/protobuf/DescriptorProtos$SourceCodeInfo$Location;

    move-result-object v0

    return-object v0
.end method

.method public clear()Lcom/google/protobuf/DescriptorProtos$SourceCodeInfo$Location$Builder;
    .locals 1

    .prologue
    .line 16489
    invoke-super {p0}, Lcom/google/protobuf/GeneratedMessage$Builder;->clear()Lcom/google/protobuf/GeneratedMessage$Builder;

    .line 16490
    invoke-static {}, Ljava/util/Collections;->emptyList()Ljava/util/List;

    move-result-object v0

    iput-object v0, p0, Lcom/google/protobuf/DescriptorProtos$SourceCodeInfo$Location$Builder;->path_:Ljava/util/List;

    .line 16491
    iget v0, p0, Lcom/google/protobuf/DescriptorProtos$SourceCodeInfo$Location$Builder;->bitField0_:I

    and-int/lit8 v0, v0, -0x2

    iput v0, p0, Lcom/google/protobuf/DescriptorProtos$SourceCodeInfo$Location$Builder;->bitField0_:I

    .line 16492
    invoke-static {}, Ljava/util/Collections;->emptyList()Ljava/util/List;

    move-result-object v0

    iput-object v0, p0, Lcom/google/protobuf/DescriptorProtos$SourceCodeInfo$Location$Builder;->span_:Ljava/util/List;

    .line 16493
    iget v0, p0, Lcom/google/protobuf/DescriptorProtos$SourceCodeInfo$Location$Builder;->bitField0_:I

    and-int/lit8 v0, v0, -0x3

    iput v0, p0, Lcom/google/protobuf/DescriptorProtos$SourceCodeInfo$Location$Builder;->bitField0_:I

    .line 16494
    const-string v0, ""

    iput-object v0, p0, Lcom/google/protobuf/DescriptorProtos$SourceCodeInfo$Location$Builder;->leadingComments_:Ljava/lang/Object;

    .line 16495
    iget v0, p0, Lcom/google/protobuf/DescriptorProtos$SourceCodeInfo$Location$Builder;->bitField0_:I

    and-int/lit8 v0, v0, -0x5

    iput v0, p0, Lcom/google/protobuf/DescriptorProtos$SourceCodeInfo$Location$Builder;->bitField0_:I

    .line 16496
    const-string v0, ""

    iput-object v0, p0, Lcom/google/protobuf/DescriptorProtos$SourceCodeInfo$Location$Builder;->trailingComments_:Ljava/lang/Object;

    .line 16497
    iget v0, p0, Lcom/google/protobuf/DescriptorProtos$SourceCodeInfo$Location$Builder;->bitField0_:I

    and-int/lit8 v0, v0, -0x9

    iput v0, p0, Lcom/google/protobuf/DescriptorProtos$SourceCodeInfo$Location$Builder;->bitField0_:I

    .line 16498
    return-object p0
.end method

.method public bridge synthetic clear()Lcom/google/protobuf/GeneratedMessage$Builder;
    .locals 1

    .prologue
    .line 1
    invoke-virtual {p0}, Lcom/google/protobuf/DescriptorProtos$SourceCodeInfo$Location$Builder;->clear()Lcom/google/protobuf/DescriptorProtos$SourceCodeInfo$Location$Builder;

    move-result-object v0

    return-object v0
.end method

.method public bridge synthetic clear()Lcom/google/protobuf/Message$Builder;
    .locals 1

    .prologue
    .line 1
    invoke-virtual {p0}, Lcom/google/protobuf/DescriptorProtos$SourceCodeInfo$Location$Builder;->clear()Lcom/google/protobuf/DescriptorProtos$SourceCodeInfo$Location$Builder;

    move-result-object v0

    return-object v0
.end method

.method public bridge synthetic clear()Lcom/google/protobuf/MessageLite$Builder;
    .locals 1

    .prologue
    .line 1
    invoke-virtual {p0}, Lcom/google/protobuf/DescriptorProtos$SourceCodeInfo$Location$Builder;->clear()Lcom/google/protobuf/DescriptorProtos$SourceCodeInfo$Location$Builder;

    move-result-object v0

    return-object v0
.end method

.method public clearLeadingComments()Lcom/google/protobuf/DescriptorProtos$SourceCodeInfo$Location$Builder;
    .locals 1

    .prologue
    .line 16786
    iget v0, p0, Lcom/google/protobuf/DescriptorProtos$SourceCodeInfo$Location$Builder;->bitField0_:I

    and-int/lit8 v0, v0, -0x5

    iput v0, p0, Lcom/google/protobuf/DescriptorProtos$SourceCodeInfo$Location$Builder;->bitField0_:I

    .line 16787
    invoke-static {}, Lcom/google/protobuf/DescriptorProtos$SourceCodeInfo$Location;->getDefaultInstance()Lcom/google/protobuf/DescriptorProtos$SourceCodeInfo$Location;

    move-result-object v0

    invoke-virtual {v0}, Lcom/google/protobuf/DescriptorProtos$SourceCodeInfo$Location;->getLeadingComments()Ljava/lang/String;

    move-result-object v0

    iput-object v0, p0, Lcom/google/protobuf/DescriptorProtos$SourceCodeInfo$Location$Builder;->leadingComments_:Ljava/lang/Object;

    .line 16788
    invoke-virtual {p0}, Lcom/google/protobuf/DescriptorProtos$SourceCodeInfo$Location$Builder;->onChanged()V

    .line 16789
    return-object p0
.end method

.method public clearPath()Lcom/google/protobuf/DescriptorProtos$SourceCodeInfo$Location$Builder;
    .locals 1

    .prologue
    .line 16710
    invoke-static {}, Ljava/util/Collections;->emptyList()Ljava/util/List;

    move-result-object v0

    iput-object v0, p0, Lcom/google/protobuf/DescriptorProtos$SourceCodeInfo$Location$Builder;->path_:Ljava/util/List;

    .line 16711
    iget v0, p0, Lcom/google/protobuf/DescriptorProtos$SourceCodeInfo$Location$Builder;->bitField0_:I

    and-int/lit8 v0, v0, -0x2

    iput v0, p0, Lcom/google/protobuf/DescriptorProtos$SourceCodeInfo$Location$Builder;->bitField0_:I

    .line 16712
    invoke-virtual {p0}, Lcom/google/protobuf/DescriptorProtos$SourceCodeInfo$Location$Builder;->onChanged()V

    .line 16713
    return-object p0
.end method

.method public clearSpan()Lcom/google/protobuf/DescriptorProtos$SourceCodeInfo$Location$Builder;
    .locals 1

    .prologue
    .line 16755
    invoke-static {}, Ljava/util/Collections;->emptyList()Ljava/util/List;

    move-result-object v0

    iput-object v0, p0, Lcom/google/protobuf/DescriptorProtos$SourceCodeInfo$Location$Builder;->span_:Ljava/util/List;

    .line 16756
    iget v0, p0, Lcom/google/protobuf/DescriptorProtos$SourceCodeInfo$Location$Builder;->bitField0_:I

    and-int/lit8 v0, v0, -0x3

    iput v0, p0, Lcom/google/protobuf/DescriptorProtos$SourceCodeInfo$Location$Builder;->bitField0_:I

    .line 16757
    invoke-virtual {p0}, Lcom/google/protobuf/DescriptorProtos$SourceCodeInfo$Location$Builder;->onChanged()V

    .line 16758
    return-object p0
.end method

.method public clearTrailingComments()Lcom/google/protobuf/DescriptorProtos$SourceCodeInfo$Location$Builder;
    .locals 1

    .prologue
    .line 16822
    iget v0, p0, Lcom/google/protobuf/DescriptorProtos$SourceCodeInfo$Location$Builder;->bitField0_:I

    and-int/lit8 v0, v0, -0x9

    iput v0, p0, Lcom/google/protobuf/DescriptorProtos$SourceCodeInfo$Location$Builder;->bitField0_:I

    .line 16823
    invoke-static {}, Lcom/google/protobuf/DescriptorProtos$SourceCodeInfo$Location;->getDefaultInstance()Lcom/google/protobuf/DescriptorProtos$SourceCodeInfo$Location;

    move-result-object v0

    invoke-virtual {v0}, Lcom/google/protobuf/DescriptorProtos$SourceCodeInfo$Location;->getTrailingComments()Ljava/lang/String;

    move-result-object v0

    iput-object v0, p0, Lcom/google/protobuf/DescriptorProtos$SourceCodeInfo$Location$Builder;->trailingComments_:Ljava/lang/Object;

    .line 16824
    invoke-virtual {p0}, Lcom/google/protobuf/DescriptorProtos$SourceCodeInfo$Location$Builder;->onChanged()V

    .line 16825
    return-object p0
.end method

.method public clone()Lcom/google/protobuf/DescriptorProtos$SourceCodeInfo$Location$Builder;
    .locals 2

    .prologue
    .line 16502
    invoke-static {}, Lcom/google/protobuf/DescriptorProtos$SourceCodeInfo$Location$Builder;->create()Lcom/google/protobuf/DescriptorProtos$SourceCodeInfo$Location$Builder;

    move-result-object v0

    invoke-virtual {p0}, Lcom/google/protobuf/DescriptorProtos$SourceCodeInfo$Location$Builder;->buildPartial()Lcom/google/protobuf/DescriptorProtos$SourceCodeInfo$Location;

    move-result-object v1

    invoke-virtual {v0, v1}, Lcom/google/protobuf/DescriptorProtos$SourceCodeInfo$Location$Builder;->mergeFrom(Lcom/google/protobuf/DescriptorProtos$SourceCodeInfo$Location;)Lcom/google/protobuf/DescriptorProtos$SourceCodeInfo$Location$Builder;

    move-result-object v0

    return-object v0
.end method

.method public bridge synthetic clone()Lcom/google/protobuf/GeneratedMessage$Builder;
    .locals 1

    .prologue
    .line 1
    invoke-virtual {p0}, Lcom/google/protobuf/DescriptorProtos$SourceCodeInfo$Location$Builder;->clone()Lcom/google/protobuf/DescriptorProtos$SourceCodeInfo$Location$Builder;

    move-result-object v0

    return-object v0
.end method

.method public bridge synthetic clone()Lcom/google/protobuf/Message$Builder;
    .locals 1

    .prologue
    .line 1
    invoke-virtual {p0}, Lcom/google/protobuf/DescriptorProtos$SourceCodeInfo$Location$Builder;->clone()Lcom/google/protobuf/DescriptorProtos$SourceCodeInfo$Location$Builder;

    move-result-object v0

    return-object v0
.end method

.method public bridge synthetic clone()Lcom/google/protobuf/MessageLite$Builder;
    .locals 1

    .prologue
    .line 1
    invoke-virtual {p0}, Lcom/google/protobuf/DescriptorProtos$SourceCodeInfo$Location$Builder;->clone()Lcom/google/protobuf/DescriptorProtos$SourceCodeInfo$Location$Builder;

    move-result-object v0

    return-object v0
.end method

.method public getDefaultInstanceForType()Lcom/google/protobuf/DescriptorProtos$SourceCodeInfo$Location;
    .locals 1

    .prologue
    .line 16511
    invoke-static {}, Lcom/google/protobuf/DescriptorProtos$SourceCodeInfo$Location;->getDefaultInstance()Lcom/google/protobuf/DescriptorProtos$SourceCodeInfo$Location;

    move-result-object v0

    return-object v0
.end method

.method public bridge synthetic getDefaultInstanceForType()Lcom/google/protobuf/Message;
    .locals 1

    .prologue
    .line 1
    invoke-virtual {p0}, Lcom/google/protobuf/DescriptorProtos$SourceCodeInfo$Location$Builder;->getDefaultInstanceForType()Lcom/google/protobuf/DescriptorProtos$SourceCodeInfo$Location;

    move-result-object v0

    return-object v0
.end method

.method public bridge synthetic getDefaultInstanceForType()Lcom/google/protobuf/MessageLite;
    .locals 1

    .prologue
    .line 1
    invoke-virtual {p0}, Lcom/google/protobuf/DescriptorProtos$SourceCodeInfo$Location$Builder;->getDefaultInstanceForType()Lcom/google/protobuf/DescriptorProtos$SourceCodeInfo$Location;

    move-result-object v0

    return-object v0
.end method

.method public getDescriptorForType()Lcom/google/protobuf/Descriptors$Descriptor;
    .locals 1

    .prologue
    .line 16507
    invoke-static {}, Lcom/google/protobuf/DescriptorProtos$SourceCodeInfo$Location;->getDescriptor()Lcom/google/protobuf/Descriptors$Descriptor;

    move-result-object v0

    return-object v0
.end method

.method public getLeadingComments()Ljava/lang/String;
    .locals 2

    .prologue
    .line 16767
    iget-object v0, p0, Lcom/google/protobuf/DescriptorProtos$SourceCodeInfo$Location$Builder;->leadingComments_:Ljava/lang/Object;

    .line 16768
    instance-of v1, v0, Ljava/lang/String;

    if-nez v1, :cond_0

    .line 16769
    check-cast v0, Lcom/google/protobuf/ByteString;

    invoke-virtual {v0}, Lcom/google/protobuf/ByteString;->toStringUtf8()Ljava/lang/String;

    move-result-object v0

    .line 16770
    iput-object v0, p0, Lcom/google/protobuf/DescriptorProtos$SourceCodeInfo$Location$Builder;->leadingComments_:Ljava/lang/Object;

    .line 16773
    :goto_0
    return-object v0

    :cond_0
    check-cast v0, Ljava/lang/String;

    goto :goto_0
.end method

.method public getPath(I)I
    .locals 1

    .prologue
    .line 16687
    iget-object v0, p0, Lcom/google/protobuf/DescriptorProtos$SourceCodeInfo$Location$Builder;->path_:Ljava/util/List;

    invoke-interface {v0, p1}, Ljava/util/List;->get(I)Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Ljava/lang/Integer;

    invoke-virtual {v0}, Ljava/lang/Integer;->intValue()I

    move-result v0

    return v0
.end method

.method public getPathCount()I
    .locals 1

    .prologue
    .line 16684
    iget-object v0, p0, Lcom/google/protobuf/DescriptorProtos$SourceCodeInfo$Location$Builder;->path_:Ljava/util/List;

    invoke-interface {v0}, Ljava/util/List;->size()I

    move-result v0

    return v0
.end method

.method public getPathList()Ljava/util/List;
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
    .line 16681
    iget-object v0, p0, Lcom/google/protobuf/DescriptorProtos$SourceCodeInfo$Location$Builder;->path_:Ljava/util/List;

    invoke-static {v0}, Ljava/util/Collections;->unmodifiableList(Ljava/util/List;)Ljava/util/List;

    move-result-object v0

    return-object v0
.end method

.method public getSpan(I)I
    .locals 1

    .prologue
    .line 16732
    iget-object v0, p0, Lcom/google/protobuf/DescriptorProtos$SourceCodeInfo$Location$Builder;->span_:Ljava/util/List;

    invoke-interface {v0, p1}, Ljava/util/List;->get(I)Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Ljava/lang/Integer;

    invoke-virtual {v0}, Ljava/lang/Integer;->intValue()I

    move-result v0

    return v0
.end method

.method public getSpanCount()I
    .locals 1

    .prologue
    .line 16729
    iget-object v0, p0, Lcom/google/protobuf/DescriptorProtos$SourceCodeInfo$Location$Builder;->span_:Ljava/util/List;

    invoke-interface {v0}, Ljava/util/List;->size()I

    move-result v0

    return v0
.end method

.method public getSpanList()Ljava/util/List;
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
    .line 16726
    iget-object v0, p0, Lcom/google/protobuf/DescriptorProtos$SourceCodeInfo$Location$Builder;->span_:Ljava/util/List;

    invoke-static {v0}, Ljava/util/Collections;->unmodifiableList(Ljava/util/List;)Ljava/util/List;

    move-result-object v0

    return-object v0
.end method

.method public getTrailingComments()Ljava/lang/String;
    .locals 2

    .prologue
    .line 16803
    iget-object v0, p0, Lcom/google/protobuf/DescriptorProtos$SourceCodeInfo$Location$Builder;->trailingComments_:Ljava/lang/Object;

    .line 16804
    instance-of v1, v0, Ljava/lang/String;

    if-nez v1, :cond_0

    .line 16805
    check-cast v0, Lcom/google/protobuf/ByteString;

    invoke-virtual {v0}, Lcom/google/protobuf/ByteString;->toStringUtf8()Ljava/lang/String;

    move-result-object v0

    .line 16806
    iput-object v0, p0, Lcom/google/protobuf/DescriptorProtos$SourceCodeInfo$Location$Builder;->trailingComments_:Ljava/lang/Object;

    .line 16809
    :goto_0
    return-object v0

    :cond_0
    check-cast v0, Ljava/lang/String;

    goto :goto_0
.end method

.method public hasLeadingComments()Z
    .locals 2

    .prologue
    .line 16764
    iget v0, p0, Lcom/google/protobuf/DescriptorProtos$SourceCodeInfo$Location$Builder;->bitField0_:I

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

.method public hasTrailingComments()Z
    .locals 2

    .prologue
    .line 16800
    iget v0, p0, Lcom/google/protobuf/DescriptorProtos$SourceCodeInfo$Location$Builder;->bitField0_:I

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

.method protected internalGetFieldAccessorTable()Lcom/google/protobuf/GeneratedMessage$FieldAccessorTable;
    .locals 1

    .prologue
    .line 16468
    invoke-static {}, Lcom/google/protobuf/DescriptorProtos;->access$79()Lcom/google/protobuf/GeneratedMessage$FieldAccessorTable;

    move-result-object v0

    return-object v0
.end method

.method public final isInitialized()Z
    .locals 1

    .prologue
    .line 16601
    const/4 v0, 0x1

    return v0
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
    invoke-virtual {p0, p1, p2}, Lcom/google/protobuf/DescriptorProtos$SourceCodeInfo$Location$Builder;->mergeFrom(Lcom/google/protobuf/CodedInputStream;Lcom/google/protobuf/ExtensionRegistryLite;)Lcom/google/protobuf/DescriptorProtos$SourceCodeInfo$Location$Builder;

    move-result-object v0

    return-object v0
.end method

.method public bridge synthetic mergeFrom(Lcom/google/protobuf/Message;)Lcom/google/protobuf/AbstractMessage$Builder;
    .locals 1

    .prologue
    .line 1
    invoke-virtual {p0, p1}, Lcom/google/protobuf/DescriptorProtos$SourceCodeInfo$Location$Builder;->mergeFrom(Lcom/google/protobuf/Message;)Lcom/google/protobuf/DescriptorProtos$SourceCodeInfo$Location$Builder;

    move-result-object v0

    return-object v0
.end method

.method public mergeFrom(Lcom/google/protobuf/CodedInputStream;Lcom/google/protobuf/ExtensionRegistryLite;)Lcom/google/protobuf/DescriptorProtos$SourceCodeInfo$Location$Builder;
    .locals 3
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljava/io/IOException;
        }
    .end annotation

    .prologue
    .line 16610
    invoke-virtual {p0}, Lcom/google/protobuf/DescriptorProtos$SourceCodeInfo$Location$Builder;->getUnknownFields()Lcom/google/protobuf/UnknownFieldSet;

    move-result-object v0

    .line 16609
    invoke-static {v0}, Lcom/google/protobuf/UnknownFieldSet;->newBuilder(Lcom/google/protobuf/UnknownFieldSet;)Lcom/google/protobuf/UnknownFieldSet$Builder;

    move-result-object v0

    .line 16612
    :cond_0
    :goto_0
    invoke-virtual {p1}, Lcom/google/protobuf/CodedInputStream;->readTag()I

    move-result v1

    .line 16613
    sparse-switch v1, :sswitch_data_0

    .line 16619
    invoke-virtual {p0, p1, v0, p2, v1}, Lcom/google/protobuf/DescriptorProtos$SourceCodeInfo$Location$Builder;->parseUnknownField(Lcom/google/protobuf/CodedInputStream;Lcom/google/protobuf/UnknownFieldSet$Builder;Lcom/google/protobuf/ExtensionRegistryLite;I)Z

    move-result v1

    if-nez v1, :cond_0

    .line 16621
    invoke-virtual {v0}, Lcom/google/protobuf/UnknownFieldSet$Builder;->build()Lcom/google/protobuf/UnknownFieldSet;

    move-result-object v0

    invoke-virtual {p0, v0}, Lcom/google/protobuf/DescriptorProtos$SourceCodeInfo$Location$Builder;->setUnknownFields(Lcom/google/protobuf/UnknownFieldSet;)Lcom/google/protobuf/GeneratedMessage$Builder;

    .line 16622
    invoke-virtual {p0}, Lcom/google/protobuf/DescriptorProtos$SourceCodeInfo$Location$Builder;->onChanged()V

    .line 16623
    :goto_1
    return-object p0

    .line 16615
    :sswitch_0
    invoke-virtual {v0}, Lcom/google/protobuf/UnknownFieldSet$Builder;->build()Lcom/google/protobuf/UnknownFieldSet;

    move-result-object v0

    invoke-virtual {p0, v0}, Lcom/google/protobuf/DescriptorProtos$SourceCodeInfo$Location$Builder;->setUnknownFields(Lcom/google/protobuf/UnknownFieldSet;)Lcom/google/protobuf/GeneratedMessage$Builder;

    .line 16616
    invoke-virtual {p0}, Lcom/google/protobuf/DescriptorProtos$SourceCodeInfo$Location$Builder;->onChanged()V

    goto :goto_1

    .line 16628
    :sswitch_1
    invoke-direct {p0}, Lcom/google/protobuf/DescriptorProtos$SourceCodeInfo$Location$Builder;->ensurePathIsMutable()V

    .line 16629
    iget-object v1, p0, Lcom/google/protobuf/DescriptorProtos$SourceCodeInfo$Location$Builder;->path_:Ljava/util/List;

    invoke-virtual {p1}, Lcom/google/protobuf/CodedInputStream;->readInt32()I

    move-result v2

    invoke-static {v2}, Ljava/lang/Integer;->valueOf(I)Ljava/lang/Integer;

    move-result-object v2

    invoke-interface {v1, v2}, Ljava/util/List;->add(Ljava/lang/Object;)Z

    goto :goto_0

    .line 16633
    :sswitch_2
    invoke-virtual {p1}, Lcom/google/protobuf/CodedInputStream;->readRawVarint32()I

    move-result v1

    .line 16634
    invoke-virtual {p1, v1}, Lcom/google/protobuf/CodedInputStream;->pushLimit(I)I

    move-result v1

    .line 16635
    :goto_2
    invoke-virtual {p1}, Lcom/google/protobuf/CodedInputStream;->getBytesUntilLimit()I

    move-result v2

    if-gtz v2, :cond_1

    .line 16638
    invoke-virtual {p1, v1}, Lcom/google/protobuf/CodedInputStream;->popLimit(I)V

    goto :goto_0

    .line 16636
    :cond_1
    invoke-virtual {p1}, Lcom/google/protobuf/CodedInputStream;->readInt32()I

    move-result v2

    invoke-virtual {p0, v2}, Lcom/google/protobuf/DescriptorProtos$SourceCodeInfo$Location$Builder;->addPath(I)Lcom/google/protobuf/DescriptorProtos$SourceCodeInfo$Location$Builder;

    goto :goto_2

    .line 16642
    :sswitch_3
    invoke-direct {p0}, Lcom/google/protobuf/DescriptorProtos$SourceCodeInfo$Location$Builder;->ensureSpanIsMutable()V

    .line 16643
    iget-object v1, p0, Lcom/google/protobuf/DescriptorProtos$SourceCodeInfo$Location$Builder;->span_:Ljava/util/List;

    invoke-virtual {p1}, Lcom/google/protobuf/CodedInputStream;->readInt32()I

    move-result v2

    invoke-static {v2}, Ljava/lang/Integer;->valueOf(I)Ljava/lang/Integer;

    move-result-object v2

    invoke-interface {v1, v2}, Ljava/util/List;->add(Ljava/lang/Object;)Z

    goto :goto_0

    .line 16647
    :sswitch_4
    invoke-virtual {p1}, Lcom/google/protobuf/CodedInputStream;->readRawVarint32()I

    move-result v1

    .line 16648
    invoke-virtual {p1, v1}, Lcom/google/protobuf/CodedInputStream;->pushLimit(I)I

    move-result v1

    .line 16649
    :goto_3
    invoke-virtual {p1}, Lcom/google/protobuf/CodedInputStream;->getBytesUntilLimit()I

    move-result v2

    if-gtz v2, :cond_2

    .line 16652
    invoke-virtual {p1, v1}, Lcom/google/protobuf/CodedInputStream;->popLimit(I)V

    goto :goto_0

    .line 16650
    :cond_2
    invoke-virtual {p1}, Lcom/google/protobuf/CodedInputStream;->readInt32()I

    move-result v2

    invoke-virtual {p0, v2}, Lcom/google/protobuf/DescriptorProtos$SourceCodeInfo$Location$Builder;->addSpan(I)Lcom/google/protobuf/DescriptorProtos$SourceCodeInfo$Location$Builder;

    goto :goto_3

    .line 16656
    :sswitch_5
    iget v1, p0, Lcom/google/protobuf/DescriptorProtos$SourceCodeInfo$Location$Builder;->bitField0_:I

    or-int/lit8 v1, v1, 0x4

    iput v1, p0, Lcom/google/protobuf/DescriptorProtos$SourceCodeInfo$Location$Builder;->bitField0_:I

    .line 16657
    invoke-virtual {p1}, Lcom/google/protobuf/CodedInputStream;->readBytes()Lcom/google/protobuf/ByteString;

    move-result-object v1

    iput-object v1, p0, Lcom/google/protobuf/DescriptorProtos$SourceCodeInfo$Location$Builder;->leadingComments_:Ljava/lang/Object;

    goto/16 :goto_0

    .line 16661
    :sswitch_6
    iget v1, p0, Lcom/google/protobuf/DescriptorProtos$SourceCodeInfo$Location$Builder;->bitField0_:I

    or-int/lit8 v1, v1, 0x8

    iput v1, p0, Lcom/google/protobuf/DescriptorProtos$SourceCodeInfo$Location$Builder;->bitField0_:I

    .line 16662
    invoke-virtual {p1}, Lcom/google/protobuf/CodedInputStream;->readBytes()Lcom/google/protobuf/ByteString;

    move-result-object v1

    iput-object v1, p0, Lcom/google/protobuf/DescriptorProtos$SourceCodeInfo$Location$Builder;->trailingComments_:Ljava/lang/Object;

    goto/16 :goto_0

    .line 16613
    nop

    :sswitch_data_0
    .sparse-switch
        0x0 -> :sswitch_0
        0x8 -> :sswitch_1
        0xa -> :sswitch_2
        0x10 -> :sswitch_3
        0x12 -> :sswitch_4
        0x1a -> :sswitch_5
        0x22 -> :sswitch_6
    .end sparse-switch
.end method

.method public mergeFrom(Lcom/google/protobuf/DescriptorProtos$SourceCodeInfo$Location;)Lcom/google/protobuf/DescriptorProtos$SourceCodeInfo$Location$Builder;
    .locals 2

    .prologue
    .line 16569
    invoke-static {}, Lcom/google/protobuf/DescriptorProtos$SourceCodeInfo$Location;->getDefaultInstance()Lcom/google/protobuf/DescriptorProtos$SourceCodeInfo$Location;

    move-result-object v0

    if-ne p1, v0, :cond_0

    .line 16597
    :goto_0
    return-object p0

    .line 16570
    :cond_0
    invoke-static {p1}, Lcom/google/protobuf/DescriptorProtos$SourceCodeInfo$Location;->access$13(Lcom/google/protobuf/DescriptorProtos$SourceCodeInfo$Location;)Ljava/util/List;

    move-result-object v0

    invoke-interface {v0}, Ljava/util/List;->isEmpty()Z

    move-result v0

    if-nez v0, :cond_1

    .line 16571
    iget-object v0, p0, Lcom/google/protobuf/DescriptorProtos$SourceCodeInfo$Location$Builder;->path_:Ljava/util/List;

    invoke-interface {v0}, Ljava/util/List;->isEmpty()Z

    move-result v0

    if-eqz v0, :cond_5

    .line 16572
    invoke-static {p1}, Lcom/google/protobuf/DescriptorProtos$SourceCodeInfo$Location;->access$13(Lcom/google/protobuf/DescriptorProtos$SourceCodeInfo$Location;)Ljava/util/List;

    move-result-object v0

    iput-object v0, p0, Lcom/google/protobuf/DescriptorProtos$SourceCodeInfo$Location$Builder;->path_:Ljava/util/List;

    .line 16573
    iget v0, p0, Lcom/google/protobuf/DescriptorProtos$SourceCodeInfo$Location$Builder;->bitField0_:I

    and-int/lit8 v0, v0, -0x2

    iput v0, p0, Lcom/google/protobuf/DescriptorProtos$SourceCodeInfo$Location$Builder;->bitField0_:I

    .line 16578
    :goto_1
    invoke-virtual {p0}, Lcom/google/protobuf/DescriptorProtos$SourceCodeInfo$Location$Builder;->onChanged()V

    .line 16580
    :cond_1
    invoke-static {p1}, Lcom/google/protobuf/DescriptorProtos$SourceCodeInfo$Location;->access$14(Lcom/google/protobuf/DescriptorProtos$SourceCodeInfo$Location;)Ljava/util/List;

    move-result-object v0

    invoke-interface {v0}, Ljava/util/List;->isEmpty()Z

    move-result v0

    if-nez v0, :cond_2

    .line 16581
    iget-object v0, p0, Lcom/google/protobuf/DescriptorProtos$SourceCodeInfo$Location$Builder;->span_:Ljava/util/List;

    invoke-interface {v0}, Ljava/util/List;->isEmpty()Z

    move-result v0

    if-eqz v0, :cond_6

    .line 16582
    invoke-static {p1}, Lcom/google/protobuf/DescriptorProtos$SourceCodeInfo$Location;->access$14(Lcom/google/protobuf/DescriptorProtos$SourceCodeInfo$Location;)Ljava/util/List;

    move-result-object v0

    iput-object v0, p0, Lcom/google/protobuf/DescriptorProtos$SourceCodeInfo$Location$Builder;->span_:Ljava/util/List;

    .line 16583
    iget v0, p0, Lcom/google/protobuf/DescriptorProtos$SourceCodeInfo$Location$Builder;->bitField0_:I

    and-int/lit8 v0, v0, -0x3

    iput v0, p0, Lcom/google/protobuf/DescriptorProtos$SourceCodeInfo$Location$Builder;->bitField0_:I

    .line 16588
    :goto_2
    invoke-virtual {p0}, Lcom/google/protobuf/DescriptorProtos$SourceCodeInfo$Location$Builder;->onChanged()V

    .line 16590
    :cond_2
    invoke-virtual {p1}, Lcom/google/protobuf/DescriptorProtos$SourceCodeInfo$Location;->hasLeadingComments()Z

    move-result v0

    if-eqz v0, :cond_3

    .line 16591
    invoke-virtual {p1}, Lcom/google/protobuf/DescriptorProtos$SourceCodeInfo$Location;->getLeadingComments()Ljava/lang/String;

    move-result-object v0

    invoke-virtual {p0, v0}, Lcom/google/protobuf/DescriptorProtos$SourceCodeInfo$Location$Builder;->setLeadingComments(Ljava/lang/String;)Lcom/google/protobuf/DescriptorProtos$SourceCodeInfo$Location$Builder;

    .line 16593
    :cond_3
    invoke-virtual {p1}, Lcom/google/protobuf/DescriptorProtos$SourceCodeInfo$Location;->hasTrailingComments()Z

    move-result v0

    if-eqz v0, :cond_4

    .line 16594
    invoke-virtual {p1}, Lcom/google/protobuf/DescriptorProtos$SourceCodeInfo$Location;->getTrailingComments()Ljava/lang/String;

    move-result-object v0

    invoke-virtual {p0, v0}, Lcom/google/protobuf/DescriptorProtos$SourceCodeInfo$Location$Builder;->setTrailingComments(Ljava/lang/String;)Lcom/google/protobuf/DescriptorProtos$SourceCodeInfo$Location$Builder;

    .line 16596
    :cond_4
    invoke-virtual {p1}, Lcom/google/protobuf/DescriptorProtos$SourceCodeInfo$Location;->getUnknownFields()Lcom/google/protobuf/UnknownFieldSet;

    move-result-object v0

    invoke-virtual {p0, v0}, Lcom/google/protobuf/DescriptorProtos$SourceCodeInfo$Location$Builder;->mergeUnknownFields(Lcom/google/protobuf/UnknownFieldSet;)Lcom/google/protobuf/GeneratedMessage$Builder;

    goto :goto_0

    .line 16575
    :cond_5
    invoke-direct {p0}, Lcom/google/protobuf/DescriptorProtos$SourceCodeInfo$Location$Builder;->ensurePathIsMutable()V

    .line 16576
    iget-object v0, p0, Lcom/google/protobuf/DescriptorProtos$SourceCodeInfo$Location$Builder;->path_:Ljava/util/List;

    invoke-static {p1}, Lcom/google/protobuf/DescriptorProtos$SourceCodeInfo$Location;->access$13(Lcom/google/protobuf/DescriptorProtos$SourceCodeInfo$Location;)Ljava/util/List;

    move-result-object v1

    invoke-interface {v0, v1}, Ljava/util/List;->addAll(Ljava/util/Collection;)Z

    goto :goto_1

    .line 16585
    :cond_6
    invoke-direct {p0}, Lcom/google/protobuf/DescriptorProtos$SourceCodeInfo$Location$Builder;->ensureSpanIsMutable()V

    .line 16586
    iget-object v0, p0, Lcom/google/protobuf/DescriptorProtos$SourceCodeInfo$Location$Builder;->span_:Ljava/util/List;

    invoke-static {p1}, Lcom/google/protobuf/DescriptorProtos$SourceCodeInfo$Location;->access$14(Lcom/google/protobuf/DescriptorProtos$SourceCodeInfo$Location;)Ljava/util/List;

    move-result-object v1

    invoke-interface {v0, v1}, Ljava/util/List;->addAll(Ljava/util/Collection;)Z

    goto :goto_2
.end method

.method public mergeFrom(Lcom/google/protobuf/Message;)Lcom/google/protobuf/DescriptorProtos$SourceCodeInfo$Location$Builder;
    .locals 1

    .prologue
    .line 16560
    instance-of v0, p1, Lcom/google/protobuf/DescriptorProtos$SourceCodeInfo$Location;

    if-eqz v0, :cond_0

    .line 16561
    check-cast p1, Lcom/google/protobuf/DescriptorProtos$SourceCodeInfo$Location;

    invoke-virtual {p0, p1}, Lcom/google/protobuf/DescriptorProtos$SourceCodeInfo$Location$Builder;->mergeFrom(Lcom/google/protobuf/DescriptorProtos$SourceCodeInfo$Location;)Lcom/google/protobuf/DescriptorProtos$SourceCodeInfo$Location$Builder;

    move-result-object p0

    .line 16564
    :goto_0
    return-object p0

    .line 16563
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
    invoke-virtual {p0, p1, p2}, Lcom/google/protobuf/DescriptorProtos$SourceCodeInfo$Location$Builder;->mergeFrom(Lcom/google/protobuf/CodedInputStream;Lcom/google/protobuf/ExtensionRegistryLite;)Lcom/google/protobuf/DescriptorProtos$SourceCodeInfo$Location$Builder;

    move-result-object v0

    return-object v0
.end method

.method public bridge synthetic mergeFrom(Lcom/google/protobuf/Message;)Lcom/google/protobuf/Message$Builder;
    .locals 1

    .prologue
    .line 1
    invoke-virtual {p0, p1}, Lcom/google/protobuf/DescriptorProtos$SourceCodeInfo$Location$Builder;->mergeFrom(Lcom/google/protobuf/Message;)Lcom/google/protobuf/DescriptorProtos$SourceCodeInfo$Location$Builder;

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
    invoke-virtual {p0, p1, p2}, Lcom/google/protobuf/DescriptorProtos$SourceCodeInfo$Location$Builder;->mergeFrom(Lcom/google/protobuf/CodedInputStream;Lcom/google/protobuf/ExtensionRegistryLite;)Lcom/google/protobuf/DescriptorProtos$SourceCodeInfo$Location$Builder;

    move-result-object v0

    return-object v0
.end method

.method public setLeadingComments(Ljava/lang/String;)Lcom/google/protobuf/DescriptorProtos$SourceCodeInfo$Location$Builder;
    .locals 1

    .prologue
    .line 16777
    if-nez p1, :cond_0

    .line 16778
    new-instance v0, Ljava/lang/NullPointerException;

    invoke-direct {v0}, Ljava/lang/NullPointerException;-><init>()V

    throw v0

    .line 16780
    :cond_0
    iget v0, p0, Lcom/google/protobuf/DescriptorProtos$SourceCodeInfo$Location$Builder;->bitField0_:I

    or-int/lit8 v0, v0, 0x4

    iput v0, p0, Lcom/google/protobuf/DescriptorProtos$SourceCodeInfo$Location$Builder;->bitField0_:I

    .line 16781
    iput-object p1, p0, Lcom/google/protobuf/DescriptorProtos$SourceCodeInfo$Location$Builder;->leadingComments_:Ljava/lang/Object;

    .line 16782
    invoke-virtual {p0}, Lcom/google/protobuf/DescriptorProtos$SourceCodeInfo$Location$Builder;->onChanged()V

    .line 16783
    return-object p0
.end method

.method setLeadingComments(Lcom/google/protobuf/ByteString;)V
    .locals 1

    .prologue
    .line 16792
    iget v0, p0, Lcom/google/protobuf/DescriptorProtos$SourceCodeInfo$Location$Builder;->bitField0_:I

    or-int/lit8 v0, v0, 0x4

    iput v0, p0, Lcom/google/protobuf/DescriptorProtos$SourceCodeInfo$Location$Builder;->bitField0_:I

    .line 16793
    iput-object p1, p0, Lcom/google/protobuf/DescriptorProtos$SourceCodeInfo$Location$Builder;->leadingComments_:Ljava/lang/Object;

    .line 16794
    invoke-virtual {p0}, Lcom/google/protobuf/DescriptorProtos$SourceCodeInfo$Location$Builder;->onChanged()V

    .line 16795
    return-void
.end method

.method public setPath(II)Lcom/google/protobuf/DescriptorProtos$SourceCodeInfo$Location$Builder;
    .locals 2

    .prologue
    .line 16691
    invoke-direct {p0}, Lcom/google/protobuf/DescriptorProtos$SourceCodeInfo$Location$Builder;->ensurePathIsMutable()V

    .line 16692
    iget-object v0, p0, Lcom/google/protobuf/DescriptorProtos$SourceCodeInfo$Location$Builder;->path_:Ljava/util/List;

    invoke-static {p2}, Ljava/lang/Integer;->valueOf(I)Ljava/lang/Integer;

    move-result-object v1

    invoke-interface {v0, p1, v1}, Ljava/util/List;->set(ILjava/lang/Object;)Ljava/lang/Object;

    .line 16693
    invoke-virtual {p0}, Lcom/google/protobuf/DescriptorProtos$SourceCodeInfo$Location$Builder;->onChanged()V

    .line 16694
    return-object p0
.end method

.method public setSpan(II)Lcom/google/protobuf/DescriptorProtos$SourceCodeInfo$Location$Builder;
    .locals 2

    .prologue
    .line 16736
    invoke-direct {p0}, Lcom/google/protobuf/DescriptorProtos$SourceCodeInfo$Location$Builder;->ensureSpanIsMutable()V

    .line 16737
    iget-object v0, p0, Lcom/google/protobuf/DescriptorProtos$SourceCodeInfo$Location$Builder;->span_:Ljava/util/List;

    invoke-static {p2}, Ljava/lang/Integer;->valueOf(I)Ljava/lang/Integer;

    move-result-object v1

    invoke-interface {v0, p1, v1}, Ljava/util/List;->set(ILjava/lang/Object;)Ljava/lang/Object;

    .line 16738
    invoke-virtual {p0}, Lcom/google/protobuf/DescriptorProtos$SourceCodeInfo$Location$Builder;->onChanged()V

    .line 16739
    return-object p0
.end method

.method public setTrailingComments(Ljava/lang/String;)Lcom/google/protobuf/DescriptorProtos$SourceCodeInfo$Location$Builder;
    .locals 1

    .prologue
    .line 16813
    if-nez p1, :cond_0

    .line 16814
    new-instance v0, Ljava/lang/NullPointerException;

    invoke-direct {v0}, Ljava/lang/NullPointerException;-><init>()V

    throw v0

    .line 16816
    :cond_0
    iget v0, p0, Lcom/google/protobuf/DescriptorProtos$SourceCodeInfo$Location$Builder;->bitField0_:I

    or-int/lit8 v0, v0, 0x8

    iput v0, p0, Lcom/google/protobuf/DescriptorProtos$SourceCodeInfo$Location$Builder;->bitField0_:I

    .line 16817
    iput-object p1, p0, Lcom/google/protobuf/DescriptorProtos$SourceCodeInfo$Location$Builder;->trailingComments_:Ljava/lang/Object;

    .line 16818
    invoke-virtual {p0}, Lcom/google/protobuf/DescriptorProtos$SourceCodeInfo$Location$Builder;->onChanged()V

    .line 16819
    return-object p0
.end method

.method setTrailingComments(Lcom/google/protobuf/ByteString;)V
    .locals 1

    .prologue
    .line 16828
    iget v0, p0, Lcom/google/protobuf/DescriptorProtos$SourceCodeInfo$Location$Builder;->bitField0_:I

    or-int/lit8 v0, v0, 0x8

    iput v0, p0, Lcom/google/protobuf/DescriptorProtos$SourceCodeInfo$Location$Builder;->bitField0_:I

    .line 16829
    iput-object p1, p0, Lcom/google/protobuf/DescriptorProtos$SourceCodeInfo$Location$Builder;->trailingComments_:Ljava/lang/Object;

    .line 16830
    invoke-virtual {p0}, Lcom/google/protobuf/DescriptorProtos$SourceCodeInfo$Location$Builder;->onChanged()V

    .line 16831
    return-void
.end method
