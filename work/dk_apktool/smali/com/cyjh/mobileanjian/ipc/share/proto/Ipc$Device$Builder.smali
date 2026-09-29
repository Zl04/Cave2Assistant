.class public final Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$Device$Builder;
.super Lcom/google/protobuf/GeneratedMessage$Builder;
.source "SourceFile"

# interfaces
.implements Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$DeviceOrBuilder;


# annotations
.annotation system Ldalvik/annotation/EnclosingClass;
    value = Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$Device;
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x19
    name = "Builder"
.end annotation

.annotation system Ldalvik/annotation/Signature;
    value = {
        "Lcom/google/protobuf/GeneratedMessage$Builder",
        "<",
        "Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$Device$Builder;",
        ">;",
        "Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$DeviceOrBuilder;"
    }
.end annotation


# instance fields
.field private bitField0_:I

.field private imei_:Ljava/lang/Object;

.field private mac_:Ljava/lang/Object;


# direct methods
.method private constructor <init>()V
    .locals 1

    .prologue
    .line 494
    invoke-direct {p0}, Lcom/google/protobuf/GeneratedMessage$Builder;-><init>()V

    .line 607
    const-string v0, ""

    iput-object v0, p0, Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$Device$Builder;->imei_:Ljava/lang/Object;

    .line 681
    const-string v0, ""

    iput-object v0, p0, Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$Device$Builder;->mac_:Ljava/lang/Object;

    .line 495
    invoke-direct {p0}, Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$Device$Builder;->maybeForceBuilderInitialization()V

    .line 496
    return-void
.end method

.method private constructor <init>(Lcom/google/protobuf/GeneratedMessage$BuilderParent;)V
    .locals 1

    .prologue
    .line 500
    invoke-direct {p0, p1}, Lcom/google/protobuf/GeneratedMessage$Builder;-><init>(Lcom/google/protobuf/GeneratedMessage$BuilderParent;)V

    .line 607
    const-string v0, ""

    iput-object v0, p0, Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$Device$Builder;->imei_:Ljava/lang/Object;

    .line 681
    const-string v0, ""

    iput-object v0, p0, Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$Device$Builder;->mac_:Ljava/lang/Object;

    .line 501
    invoke-direct {p0}, Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$Device$Builder;->maybeForceBuilderInitialization()V

    .line 502
    return-void
.end method

.method synthetic constructor <init>(Lcom/google/protobuf/GeneratedMessage$BuilderParent;Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$1;)V
    .locals 0

    .prologue
    .line 478
    invoke-direct {p0, p1}, Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$Device$Builder;-><init>(Lcom/google/protobuf/GeneratedMessage$BuilderParent;)V

    return-void
.end method

.method static synthetic access$300()Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$Device$Builder;
    .locals 1

    .prologue
    .line 478
    invoke-static {}, Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$Device$Builder;->create()Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$Device$Builder;

    move-result-object v0

    return-object v0
.end method

.method private static create()Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$Device$Builder;
    .locals 1

    .prologue
    .line 508
    new-instance v0, Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$Device$Builder;

    invoke-direct {v0}, Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$Device$Builder;-><init>()V

    return-object v0
.end method

.method public static final getDescriptor()Lcom/google/protobuf/Descriptors$Descriptor;
    .locals 1

    .prologue
    .line 483
    invoke-static {}, Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc;->access$000()Lcom/google/protobuf/Descriptors$Descriptor;

    move-result-object v0

    return-object v0
.end method

.method private maybeForceBuilderInitialization()V
    .locals 1

    .prologue
    .line 504
    invoke-static {}, Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$Device;->access$500()Z

    move-result v0

    if-eqz v0, :cond_0

    .line 506
    :cond_0
    return-void
.end method


# virtual methods
.method public build()Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$Device;
    .locals 2

    .prologue
    .line 534
    invoke-virtual {p0}, Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$Device$Builder;->buildPartial()Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$Device;

    move-result-object v0

    .line 535
    invoke-virtual {v0}, Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$Device;->isInitialized()Z

    move-result v1

    if-nez v1, :cond_0

    .line 536
    invoke-static {v0}, Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$Device$Builder;->newUninitializedMessageException(Lcom/google/protobuf/Message;)Lcom/google/protobuf/UninitializedMessageException;

    move-result-object v0

    throw v0

    .line 538
    :cond_0
    return-object v0
.end method

.method public bridge synthetic build()Lcom/google/protobuf/Message;
    .locals 1

    .prologue
    .line 478
    invoke-virtual {p0}, Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$Device$Builder;->build()Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$Device;

    move-result-object v0

    return-object v0
.end method

.method public bridge synthetic build()Lcom/google/protobuf/MessageLite;
    .locals 1

    .prologue
    .line 478
    invoke-virtual {p0}, Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$Device$Builder;->build()Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$Device;

    move-result-object v0

    return-object v0
.end method

.method public buildPartial()Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$Device;
    .locals 5

    .prologue
    const/4 v0, 0x1

    .line 542
    new-instance v2, Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$Device;

    const/4 v1, 0x0

    invoke-direct {v2, p0, v1}, Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$Device;-><init>(Lcom/google/protobuf/GeneratedMessage$Builder;Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$1;)V

    .line 543
    iget v3, p0, Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$Device$Builder;->bitField0_:I

    .line 544
    const/4 v1, 0x0

    .line 545
    and-int/lit8 v4, v3, 0x1

    if-ne v4, v0, :cond_1

    .line 548
    :goto_0
    iget-object v1, p0, Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$Device$Builder;->imei_:Ljava/lang/Object;

    invoke-static {v2, v1}, Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$Device;->access$702(Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$Device;Ljava/lang/Object;)Ljava/lang/Object;

    .line 549
    and-int/lit8 v1, v3, 0x2

    const/4 v3, 0x2

    if-ne v1, v3, :cond_0

    .line 550
    or-int/lit8 v0, v0, 0x2

    .line 552
    :cond_0
    iget-object v1, p0, Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$Device$Builder;->mac_:Ljava/lang/Object;

    invoke-static {v2, v1}, Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$Device;->access$802(Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$Device;Ljava/lang/Object;)Ljava/lang/Object;

    .line 553
    invoke-static {v2, v0}, Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$Device;->access$902(Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$Device;I)I

    .line 554
    invoke-virtual {p0}, Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$Device$Builder;->onBuilt()V

    .line 555
    return-object v2

    :cond_1
    move v0, v1

    goto :goto_0
.end method

.method public bridge synthetic buildPartial()Lcom/google/protobuf/Message;
    .locals 1

    .prologue
    .line 478
    invoke-virtual {p0}, Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$Device$Builder;->buildPartial()Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$Device;

    move-result-object v0

    return-object v0
.end method

.method public bridge synthetic buildPartial()Lcom/google/protobuf/MessageLite;
    .locals 1

    .prologue
    .line 478
    invoke-virtual {p0}, Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$Device$Builder;->buildPartial()Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$Device;

    move-result-object v0

    return-object v0
.end method

.method public clear()Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$Device$Builder;
    .locals 1

    .prologue
    .line 512
    invoke-super {p0}, Lcom/google/protobuf/GeneratedMessage$Builder;->clear()Lcom/google/protobuf/GeneratedMessage$Builder;

    .line 513
    const-string v0, ""

    iput-object v0, p0, Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$Device$Builder;->imei_:Ljava/lang/Object;

    .line 514
    iget v0, p0, Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$Device$Builder;->bitField0_:I

    and-int/lit8 v0, v0, -0x2

    iput v0, p0, Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$Device$Builder;->bitField0_:I

    .line 515
    const-string v0, ""

    iput-object v0, p0, Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$Device$Builder;->mac_:Ljava/lang/Object;

    .line 516
    iget v0, p0, Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$Device$Builder;->bitField0_:I

    and-int/lit8 v0, v0, -0x3

    iput v0, p0, Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$Device$Builder;->bitField0_:I

    .line 517
    return-object p0
.end method

.method public bridge synthetic clear()Lcom/google/protobuf/AbstractMessage$Builder;
    .locals 1

    .prologue
    .line 478
    invoke-virtual {p0}, Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$Device$Builder;->clear()Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$Device$Builder;

    move-result-object v0

    return-object v0
.end method

.method public bridge synthetic clear()Lcom/google/protobuf/GeneratedMessage$Builder;
    .locals 1

    .prologue
    .line 478
    invoke-virtual {p0}, Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$Device$Builder;->clear()Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$Device$Builder;

    move-result-object v0

    return-object v0
.end method

.method public bridge synthetic clear()Lcom/google/protobuf/Message$Builder;
    .locals 1

    .prologue
    .line 478
    invoke-virtual {p0}, Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$Device$Builder;->clear()Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$Device$Builder;

    move-result-object v0

    return-object v0
.end method

.method public bridge synthetic clear()Lcom/google/protobuf/MessageLite$Builder;
    .locals 1

    .prologue
    .line 478
    invoke-virtual {p0}, Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$Device$Builder;->clear()Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$Device$Builder;

    move-result-object v0

    return-object v0
.end method

.method public clearImei()Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$Device$Builder;
    .locals 1

    .prologue
    .line 661
    iget v0, p0, Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$Device$Builder;->bitField0_:I

    and-int/lit8 v0, v0, -0x2

    iput v0, p0, Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$Device$Builder;->bitField0_:I

    .line 662
    invoke-static {}, Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$Device;->getDefaultInstance()Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$Device;

    move-result-object v0

    invoke-virtual {v0}, Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$Device;->getImei()Ljava/lang/String;

    move-result-object v0

    iput-object v0, p0, Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$Device$Builder;->imei_:Ljava/lang/Object;

    .line 663
    invoke-virtual {p0}, Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$Device$Builder;->onChanged()V

    .line 664
    return-object p0
.end method

.method public clearMac()Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$Device$Builder;
    .locals 1

    .prologue
    .line 735
    iget v0, p0, Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$Device$Builder;->bitField0_:I

    and-int/lit8 v0, v0, -0x3

    iput v0, p0, Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$Device$Builder;->bitField0_:I

    .line 736
    invoke-static {}, Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$Device;->getDefaultInstance()Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$Device;

    move-result-object v0

    invoke-virtual {v0}, Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$Device;->getMac()Ljava/lang/String;

    move-result-object v0

    iput-object v0, p0, Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$Device$Builder;->mac_:Ljava/lang/Object;

    .line 737
    invoke-virtual {p0}, Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$Device$Builder;->onChanged()V

    .line 738
    return-object p0
.end method

.method public clone()Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$Device$Builder;
    .locals 2

    .prologue
    .line 521
    invoke-static {}, Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$Device$Builder;->create()Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$Device$Builder;

    move-result-object v0

    invoke-virtual {p0}, Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$Device$Builder;->buildPartial()Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$Device;

    move-result-object v1

    invoke-virtual {v0, v1}, Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$Device$Builder;->mergeFrom(Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$Device;)Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$Device$Builder;

    move-result-object v0

    return-object v0
.end method

.method public bridge synthetic clone()Lcom/google/protobuf/AbstractMessage$Builder;
    .locals 1

    .prologue
    .line 478
    invoke-virtual {p0}, Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$Device$Builder;->clone()Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$Device$Builder;

    move-result-object v0

    return-object v0
.end method

.method public bridge synthetic clone()Lcom/google/protobuf/AbstractMessageLite$Builder;
    .locals 1

    .prologue
    .line 478
    invoke-virtual {p0}, Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$Device$Builder;->clone()Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$Device$Builder;

    move-result-object v0

    return-object v0
.end method

.method public bridge synthetic clone()Lcom/google/protobuf/GeneratedMessage$Builder;
    .locals 1

    .prologue
    .line 478
    invoke-virtual {p0}, Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$Device$Builder;->clone()Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$Device$Builder;

    move-result-object v0

    return-object v0
.end method

.method public bridge synthetic clone()Lcom/google/protobuf/Message$Builder;
    .locals 1

    .prologue
    .line 478
    invoke-virtual {p0}, Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$Device$Builder;->clone()Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$Device$Builder;

    move-result-object v0

    return-object v0
.end method

.method public bridge synthetic clone()Lcom/google/protobuf/MessageLite$Builder;
    .locals 1

    .prologue
    .line 478
    invoke-virtual {p0}, Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$Device$Builder;->clone()Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$Device$Builder;

    move-result-object v0

    return-object v0
.end method

.method public bridge synthetic clone()Ljava/lang/Object;
    .locals 1
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljava/lang/CloneNotSupportedException;
        }
    .end annotation

    .prologue
    .line 478
    invoke-virtual {p0}, Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$Device$Builder;->clone()Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$Device$Builder;

    move-result-object v0

    return-object v0
.end method

.method public getDefaultInstanceForType()Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$Device;
    .locals 1

    .prologue
    .line 530
    invoke-static {}, Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$Device;->getDefaultInstance()Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$Device;

    move-result-object v0

    return-object v0
.end method

.method public bridge synthetic getDefaultInstanceForType()Lcom/google/protobuf/Message;
    .locals 1

    .prologue
    .line 478
    invoke-virtual {p0}, Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$Device$Builder;->getDefaultInstanceForType()Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$Device;

    move-result-object v0

    return-object v0
.end method

.method public bridge synthetic getDefaultInstanceForType()Lcom/google/protobuf/MessageLite;
    .locals 1

    .prologue
    .line 478
    invoke-virtual {p0}, Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$Device$Builder;->getDefaultInstanceForType()Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$Device;

    move-result-object v0

    return-object v0
.end method

.method public getDescriptorForType()Lcom/google/protobuf/Descriptors$Descriptor;
    .locals 1

    .prologue
    .line 526
    invoke-static {}, Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc;->access$000()Lcom/google/protobuf/Descriptors$Descriptor;

    move-result-object v0

    return-object v0
.end method

.method public getImei()Ljava/lang/String;
    .locals 2

    .prologue
    .line 618
    iget-object v0, p0, Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$Device$Builder;->imei_:Ljava/lang/Object;

    .line 619
    instance-of v1, v0, Ljava/lang/String;

    if-nez v1, :cond_0

    .line 620
    check-cast v0, Lcom/google/protobuf/ByteString;

    .line 621
    invoke-virtual {v0}, Lcom/google/protobuf/ByteString;->toStringUtf8()Ljava/lang/String;

    move-result-object v0

    .line 622
    iput-object v0, p0, Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$Device$Builder;->imei_:Ljava/lang/Object;

    .line 625
    :goto_0
    return-object v0

    :cond_0
    check-cast v0, Ljava/lang/String;

    goto :goto_0
.end method

.method public getImeiBytes()Lcom/google/protobuf/ByteString;
    .locals 2

    .prologue
    .line 633
    iget-object v0, p0, Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$Device$Builder;->imei_:Ljava/lang/Object;

    .line 634
    instance-of v1, v0, Ljava/lang/String;

    if-eqz v1, :cond_0

    .line 635
    check-cast v0, Ljava/lang/String;

    .line 636
    invoke-static {v0}, Lcom/google/protobuf/ByteString;->copyFromUtf8(Ljava/lang/String;)Lcom/google/protobuf/ByteString;

    move-result-object v0

    .line 638
    iput-object v0, p0, Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$Device$Builder;->imei_:Ljava/lang/Object;

    .line 641
    :goto_0
    return-object v0

    :cond_0
    check-cast v0, Lcom/google/protobuf/ByteString;

    goto :goto_0
.end method

.method public getMac()Ljava/lang/String;
    .locals 2

    .prologue
    .line 692
    iget-object v0, p0, Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$Device$Builder;->mac_:Ljava/lang/Object;

    .line 693
    instance-of v1, v0, Ljava/lang/String;

    if-nez v1, :cond_0

    .line 694
    check-cast v0, Lcom/google/protobuf/ByteString;

    .line 695
    invoke-virtual {v0}, Lcom/google/protobuf/ByteString;->toStringUtf8()Ljava/lang/String;

    move-result-object v0

    .line 696
    iput-object v0, p0, Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$Device$Builder;->mac_:Ljava/lang/Object;

    .line 699
    :goto_0
    return-object v0

    :cond_0
    check-cast v0, Ljava/lang/String;

    goto :goto_0
.end method

.method public getMacBytes()Lcom/google/protobuf/ByteString;
    .locals 2

    .prologue
    .line 707
    iget-object v0, p0, Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$Device$Builder;->mac_:Ljava/lang/Object;

    .line 708
    instance-of v1, v0, Ljava/lang/String;

    if-eqz v1, :cond_0

    .line 709
    check-cast v0, Ljava/lang/String;

    .line 710
    invoke-static {v0}, Lcom/google/protobuf/ByteString;->copyFromUtf8(Ljava/lang/String;)Lcom/google/protobuf/ByteString;

    move-result-object v0

    .line 712
    iput-object v0, p0, Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$Device$Builder;->mac_:Ljava/lang/Object;

    .line 715
    :goto_0
    return-object v0

    :cond_0
    check-cast v0, Lcom/google/protobuf/ByteString;

    goto :goto_0
.end method

.method public hasImei()Z
    .locals 2

    .prologue
    const/4 v0, 0x1

    .line 612
    iget v1, p0, Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$Device$Builder;->bitField0_:I

    and-int/lit8 v1, v1, 0x1

    if-ne v1, v0, :cond_0

    :goto_0
    return v0

    :cond_0
    const/4 v0, 0x0

    goto :goto_0
.end method

.method public hasMac()Z
    .locals 2

    .prologue
    .line 686
    iget v0, p0, Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$Device$Builder;->bitField0_:I

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
    .locals 3

    .prologue
    .line 488
    invoke-static {}, Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc;->access$100()Lcom/google/protobuf/GeneratedMessage$FieldAccessorTable;

    move-result-object v0

    const-class v1, Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$Device;

    const-class v2, Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$Device$Builder;

    .line 489
    invoke-virtual {v0, v1, v2}, Lcom/google/protobuf/GeneratedMessage$FieldAccessorTable;->ensureFieldAccessorsInitialized(Ljava/lang/Class;Ljava/lang/Class;)Lcom/google/protobuf/GeneratedMessage$FieldAccessorTable;

    move-result-object v0

    .line 488
    return-object v0
.end method

.method public final isInitialized()Z
    .locals 1

    .prologue
    .line 584
    const/4 v0, 0x1

    return v0
.end method

.method public mergeFrom(Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$Device;)Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$Device$Builder;
    .locals 1

    .prologue
    .line 568
    invoke-static {}, Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$Device;->getDefaultInstance()Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$Device;

    move-result-object v0

    if-ne p1, v0, :cond_0

    .line 580
    :goto_0
    return-object p0

    .line 569
    :cond_0
    invoke-virtual {p1}, Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$Device;->hasImei()Z

    move-result v0

    if-eqz v0, :cond_1

    .line 570
    iget v0, p0, Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$Device$Builder;->bitField0_:I

    or-int/lit8 v0, v0, 0x1

    iput v0, p0, Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$Device$Builder;->bitField0_:I

    .line 571
    invoke-static {p1}, Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$Device;->access$700(Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$Device;)Ljava/lang/Object;

    move-result-object v0

    iput-object v0, p0, Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$Device$Builder;->imei_:Ljava/lang/Object;

    .line 572
    invoke-virtual {p0}, Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$Device$Builder;->onChanged()V

    .line 574
    :cond_1
    invoke-virtual {p1}, Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$Device;->hasMac()Z

    move-result v0

    if-eqz v0, :cond_2

    .line 575
    iget v0, p0, Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$Device$Builder;->bitField0_:I

    or-int/lit8 v0, v0, 0x2

    iput v0, p0, Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$Device$Builder;->bitField0_:I

    .line 576
    invoke-static {p1}, Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$Device;->access$800(Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$Device;)Ljava/lang/Object;

    move-result-object v0

    iput-object v0, p0, Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$Device$Builder;->mac_:Ljava/lang/Object;

    .line 577
    invoke-virtual {p0}, Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$Device$Builder;->onChanged()V

    .line 579
    :cond_2
    invoke-virtual {p1}, Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$Device;->getUnknownFields()Lcom/google/protobuf/UnknownFieldSet;

    move-result-object v0

    invoke-virtual {p0, v0}, Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$Device$Builder;->mergeUnknownFields(Lcom/google/protobuf/UnknownFieldSet;)Lcom/google/protobuf/GeneratedMessage$Builder;

    goto :goto_0
.end method

.method public mergeFrom(Lcom/google/protobuf/CodedInputStream;Lcom/google/protobuf/ExtensionRegistryLite;)Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$Device$Builder;
    .locals 4
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljava/io/IOException;
        }
    .end annotation

    .prologue
    .line 591
    const/4 v2, 0x0

    .line 593
    :try_start_0
    sget-object v0, Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$Device;->PARSER:Lcom/google/protobuf/Parser;

    invoke-interface {v0, p1, p2}, Lcom/google/protobuf/Parser;->parsePartialFrom(Lcom/google/protobuf/CodedInputStream;Lcom/google/protobuf/ExtensionRegistryLite;)Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$Device;
    :try_end_0
    .catch Lcom/google/protobuf/InvalidProtocolBufferException; {:try_start_0 .. :try_end_0} :catch_0
    .catchall {:try_start_0 .. :try_end_0} :catchall_1

    .line 598
    if-eqz v0, :cond_0

    .line 599
    invoke-virtual {p0, v0}, Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$Device$Builder;->mergeFrom(Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$Device;)Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$Device$Builder;

    .line 602
    :cond_0
    return-object p0

    .line 594
    :catch_0
    move-exception v0

    move-object v1, v0

    .line 595
    :try_start_1
    invoke-virtual {v1}, Lcom/google/protobuf/InvalidProtocolBufferException;->getUnfinishedMessage()Lcom/google/protobuf/MessageLite;

    move-result-object v0

    check-cast v0, Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$Device;
    :try_end_1
    .catchall {:try_start_1 .. :try_end_1} :catchall_1

    .line 596
    :try_start_2
    throw v1
    :try_end_2
    .catchall {:try_start_2 .. :try_end_2} :catchall_0

    .line 598
    :catchall_0
    move-exception v1

    move-object v3, v1

    move-object v1, v0

    move-object v0, v3

    :goto_0
    if-eqz v1, :cond_1

    .line 599
    invoke-virtual {p0, v1}, Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$Device$Builder;->mergeFrom(Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$Device;)Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$Device$Builder;

    :cond_1
    throw v0

    .line 598
    :catchall_1
    move-exception v0

    move-object v1, v2

    goto :goto_0
.end method

.method public mergeFrom(Lcom/google/protobuf/Message;)Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$Device$Builder;
    .locals 1

    .prologue
    .line 559
    instance-of v0, p1, Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$Device;

    if-eqz v0, :cond_0

    .line 560
    check-cast p1, Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$Device;

    invoke-virtual {p0, p1}, Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$Device$Builder;->mergeFrom(Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$Device;)Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$Device$Builder;

    move-result-object p0

    .line 563
    :goto_0
    return-object p0

    .line 562
    :cond_0
    invoke-super {p0, p1}, Lcom/google/protobuf/GeneratedMessage$Builder;->mergeFrom(Lcom/google/protobuf/Message;)Lcom/google/protobuf/AbstractMessage$Builder;

    goto :goto_0
.end method

.method public bridge synthetic mergeFrom(Lcom/google/protobuf/CodedInputStream;Lcom/google/protobuf/ExtensionRegistryLite;)Lcom/google/protobuf/AbstractMessage$Builder;
    .locals 1
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljava/io/IOException;
        }
    .end annotation

    .prologue
    .line 478
    invoke-virtual {p0, p1, p2}, Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$Device$Builder;->mergeFrom(Lcom/google/protobuf/CodedInputStream;Lcom/google/protobuf/ExtensionRegistryLite;)Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$Device$Builder;

    move-result-object v0

    return-object v0
.end method

.method public bridge synthetic mergeFrom(Lcom/google/protobuf/Message;)Lcom/google/protobuf/AbstractMessage$Builder;
    .locals 1

    .prologue
    .line 478
    invoke-virtual {p0, p1}, Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$Device$Builder;->mergeFrom(Lcom/google/protobuf/Message;)Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$Device$Builder;

    move-result-object v0

    return-object v0
.end method

.method public bridge synthetic mergeFrom(Lcom/google/protobuf/CodedInputStream;Lcom/google/protobuf/ExtensionRegistryLite;)Lcom/google/protobuf/AbstractMessageLite$Builder;
    .locals 1
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljava/io/IOException;
        }
    .end annotation

    .prologue
    .line 478
    invoke-virtual {p0, p1, p2}, Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$Device$Builder;->mergeFrom(Lcom/google/protobuf/CodedInputStream;Lcom/google/protobuf/ExtensionRegistryLite;)Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$Device$Builder;

    move-result-object v0

    return-object v0
.end method

.method public bridge synthetic mergeFrom(Lcom/google/protobuf/CodedInputStream;Lcom/google/protobuf/ExtensionRegistryLite;)Lcom/google/protobuf/Message$Builder;
    .locals 1
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljava/io/IOException;
        }
    .end annotation

    .prologue
    .line 478
    invoke-virtual {p0, p1, p2}, Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$Device$Builder;->mergeFrom(Lcom/google/protobuf/CodedInputStream;Lcom/google/protobuf/ExtensionRegistryLite;)Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$Device$Builder;

    move-result-object v0

    return-object v0
.end method

.method public bridge synthetic mergeFrom(Lcom/google/protobuf/Message;)Lcom/google/protobuf/Message$Builder;
    .locals 1

    .prologue
    .line 478
    invoke-virtual {p0, p1}, Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$Device$Builder;->mergeFrom(Lcom/google/protobuf/Message;)Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$Device$Builder;

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
    .line 478
    invoke-virtual {p0, p1, p2}, Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$Device$Builder;->mergeFrom(Lcom/google/protobuf/CodedInputStream;Lcom/google/protobuf/ExtensionRegistryLite;)Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$Device$Builder;

    move-result-object v0

    return-object v0
.end method

.method public setImei(Ljava/lang/String;)Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$Device$Builder;
    .locals 1

    .prologue
    .line 649
    if-nez p1, :cond_0

    .line 650
    new-instance v0, Ljava/lang/NullPointerException;

    invoke-direct {v0}, Ljava/lang/NullPointerException;-><init>()V

    throw v0

    .line 652
    :cond_0
    iget v0, p0, Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$Device$Builder;->bitField0_:I

    or-int/lit8 v0, v0, 0x1

    iput v0, p0, Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$Device$Builder;->bitField0_:I

    .line 653
    iput-object p1, p0, Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$Device$Builder;->imei_:Ljava/lang/Object;

    .line 654
    invoke-virtual {p0}, Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$Device$Builder;->onChanged()V

    .line 655
    return-object p0
.end method

.method public setImeiBytes(Lcom/google/protobuf/ByteString;)Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$Device$Builder;
    .locals 1

    .prologue
    .line 671
    if-nez p1, :cond_0

    .line 672
    new-instance v0, Ljava/lang/NullPointerException;

    invoke-direct {v0}, Ljava/lang/NullPointerException;-><init>()V

    throw v0

    .line 674
    :cond_0
    iget v0, p0, Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$Device$Builder;->bitField0_:I

    or-int/lit8 v0, v0, 0x1

    iput v0, p0, Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$Device$Builder;->bitField0_:I

    .line 675
    iput-object p1, p0, Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$Device$Builder;->imei_:Ljava/lang/Object;

    .line 676
    invoke-virtual {p0}, Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$Device$Builder;->onChanged()V

    .line 677
    return-object p0
.end method

.method public setMac(Ljava/lang/String;)Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$Device$Builder;
    .locals 1

    .prologue
    .line 723
    if-nez p1, :cond_0

    .line 724
    new-instance v0, Ljava/lang/NullPointerException;

    invoke-direct {v0}, Ljava/lang/NullPointerException;-><init>()V

    throw v0

    .line 726
    :cond_0
    iget v0, p0, Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$Device$Builder;->bitField0_:I

    or-int/lit8 v0, v0, 0x2

    iput v0, p0, Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$Device$Builder;->bitField0_:I

    .line 727
    iput-object p1, p0, Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$Device$Builder;->mac_:Ljava/lang/Object;

    .line 728
    invoke-virtual {p0}, Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$Device$Builder;->onChanged()V

    .line 729
    return-object p0
.end method

.method public setMacBytes(Lcom/google/protobuf/ByteString;)Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$Device$Builder;
    .locals 1

    .prologue
    .line 745
    if-nez p1, :cond_0

    .line 746
    new-instance v0, Ljava/lang/NullPointerException;

    invoke-direct {v0}, Ljava/lang/NullPointerException;-><init>()V

    throw v0

    .line 748
    :cond_0
    iget v0, p0, Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$Device$Builder;->bitField0_:I

    or-int/lit8 v0, v0, 0x2

    iput v0, p0, Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$Device$Builder;->bitField0_:I

    .line 749
    iput-object p1, p0, Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$Device$Builder;->mac_:Ljava/lang/Object;

    .line 750
    invoke-virtual {p0}, Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$Device$Builder;->onChanged()V

    .line 751
    return-object p0
.end method
