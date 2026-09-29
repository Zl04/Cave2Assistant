.class public final Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$Padding_Var$Builder;
.super Lcom/google/protobuf/GeneratedMessage$Builder;
.source "SourceFile"

# interfaces
.implements Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$Padding_VarOrBuilder;


# annotations
.annotation system Ldalvik/annotation/EnclosingClass;
    value = Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$Padding_Var;
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x19
    name = "Builder"
.end annotation

.annotation system Ldalvik/annotation/Signature;
    value = {
        "Lcom/google/protobuf/GeneratedMessage$Builder",
        "<",
        "Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$Padding_Var$Builder;",
        ">;",
        "Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$Padding_VarOrBuilder;"
    }
.end annotation


# instance fields
.field private bitField0_:I

.field private bottom_:I

.field private left_:I

.field private right_:I

.field private top_:I


# direct methods
.method private constructor <init>()V
    .locals 0

    .prologue
    .line 397
    invoke-direct {p0}, Lcom/google/protobuf/GeneratedMessage$Builder;-><init>()V

    .line 398
    invoke-direct {p0}, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$Padding_Var$Builder;->maybeForceBuilderInitialization()V

    .line 399
    return-void
.end method

.method private constructor <init>(Lcom/google/protobuf/GeneratedMessage$BuilderParent;)V
    .locals 0

    .prologue
    .line 403
    invoke-direct {p0, p1}, Lcom/google/protobuf/GeneratedMessage$Builder;-><init>(Lcom/google/protobuf/GeneratedMessage$BuilderParent;)V

    .line 404
    invoke-direct {p0}, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$Padding_Var$Builder;->maybeForceBuilderInitialization()V

    .line 405
    return-void
.end method

.method synthetic constructor <init>(Lcom/google/protobuf/GeneratedMessage$BuilderParent;Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$1;)V
    .locals 0

    .prologue
    .line 381
    invoke-direct {p0, p1}, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$Padding_Var$Builder;-><init>(Lcom/google/protobuf/GeneratedMessage$BuilderParent;)V

    return-void
.end method

.method static synthetic access$300()Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$Padding_Var$Builder;
    .locals 1

    .prologue
    .line 381
    invoke-static {}, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$Padding_Var$Builder;->create()Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$Padding_Var$Builder;

    move-result-object v0

    return-object v0
.end method

.method private static create()Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$Padding_Var$Builder;
    .locals 1

    .prologue
    .line 411
    new-instance v0, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$Padding_Var$Builder;

    invoke-direct {v0}, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$Padding_Var$Builder;-><init>()V

    return-object v0
.end method

.method public static final getDescriptor()Lcom/google/protobuf/Descriptors$Descriptor;
    .locals 1

    .prologue
    .line 386
    invoke-static {}, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage;->b()Lcom/google/protobuf/Descriptors$Descriptor;

    move-result-object v0

    return-object v0
.end method

.method private maybeForceBuilderInitialization()V
    .locals 1

    .prologue
    .line 407
    invoke-static {}, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$Padding_Var;->access$500()Z

    move-result v0

    if-eqz v0, :cond_0

    .line 409
    :cond_0
    return-void
.end method


# virtual methods
.method public build()Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$Padding_Var;
    .locals 2

    .prologue
    .line 441
    invoke-virtual {p0}, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$Padding_Var$Builder;->buildPartial()Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$Padding_Var;

    move-result-object v0

    .line 442
    invoke-virtual {v0}, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$Padding_Var;->isInitialized()Z

    move-result v1

    if-nez v1, :cond_0

    .line 443
    invoke-static {v0}, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$Padding_Var$Builder;->newUninitializedMessageException(Lcom/google/protobuf/Message;)Lcom/google/protobuf/UninitializedMessageException;

    move-result-object v0

    throw v0

    .line 445
    :cond_0
    return-object v0
.end method

.method public bridge synthetic build()Lcom/google/protobuf/Message;
    .locals 1

    .prologue
    .line 381
    invoke-virtual {p0}, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$Padding_Var$Builder;->build()Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$Padding_Var;

    move-result-object v0

    return-object v0
.end method

.method public bridge synthetic build()Lcom/google/protobuf/MessageLite;
    .locals 1

    .prologue
    .line 381
    invoke-virtual {p0}, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$Padding_Var$Builder;->build()Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$Padding_Var;

    move-result-object v0

    return-object v0
.end method

.method public buildPartial()Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$Padding_Var;
    .locals 5

    .prologue
    const/4 v0, 0x1

    .line 449
    new-instance v2, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$Padding_Var;

    const/4 v1, 0x0

    invoke-direct {v2, p0, v1}, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$Padding_Var;-><init>(Lcom/google/protobuf/GeneratedMessage$Builder;Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$1;)V

    .line 450
    iget v3, p0, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$Padding_Var$Builder;->bitField0_:I

    .line 451
    const/4 v1, 0x0

    .line 452
    and-int/lit8 v4, v3, 0x1

    if-ne v4, v0, :cond_3

    .line 455
    :goto_0
    iget v1, p0, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$Padding_Var$Builder;->top_:I

    invoke-static {v2, v1}, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$Padding_Var;->access$702(Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$Padding_Var;I)I

    .line 456
    and-int/lit8 v1, v3, 0x2

    const/4 v4, 0x2

    if-ne v1, v4, :cond_0

    .line 457
    or-int/lit8 v0, v0, 0x2

    .line 459
    :cond_0
    iget v1, p0, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$Padding_Var$Builder;->left_:I

    invoke-static {v2, v1}, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$Padding_Var;->access$802(Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$Padding_Var;I)I

    .line 460
    and-int/lit8 v1, v3, 0x4

    const/4 v4, 0x4

    if-ne v1, v4, :cond_1

    .line 461
    or-int/lit8 v0, v0, 0x4

    .line 463
    :cond_1
    iget v1, p0, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$Padding_Var$Builder;->bottom_:I

    invoke-static {v2, v1}, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$Padding_Var;->access$902(Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$Padding_Var;I)I

    .line 464
    and-int/lit8 v1, v3, 0x8

    const/16 v3, 0x8

    if-ne v1, v3, :cond_2

    .line 465
    or-int/lit8 v0, v0, 0x8

    .line 467
    :cond_2
    iget v1, p0, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$Padding_Var$Builder;->right_:I

    invoke-static {v2, v1}, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$Padding_Var;->access$1002(Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$Padding_Var;I)I

    .line 468
    invoke-static {v2, v0}, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$Padding_Var;->access$1102(Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$Padding_Var;I)I

    .line 469
    invoke-virtual {p0}, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$Padding_Var$Builder;->onBuilt()V

    .line 470
    return-object v2

    :cond_3
    move v0, v1

    goto :goto_0
.end method

.method public bridge synthetic buildPartial()Lcom/google/protobuf/Message;
    .locals 1

    .prologue
    .line 381
    invoke-virtual {p0}, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$Padding_Var$Builder;->buildPartial()Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$Padding_Var;

    move-result-object v0

    return-object v0
.end method

.method public bridge synthetic buildPartial()Lcom/google/protobuf/MessageLite;
    .locals 1

    .prologue
    .line 381
    invoke-virtual {p0}, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$Padding_Var$Builder;->buildPartial()Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$Padding_Var;

    move-result-object v0

    return-object v0
.end method

.method public clear()Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$Padding_Var$Builder;
    .locals 2

    .prologue
    const/4 v1, 0x0

    .line 415
    invoke-super {p0}, Lcom/google/protobuf/GeneratedMessage$Builder;->clear()Lcom/google/protobuf/GeneratedMessage$Builder;

    .line 416
    iput v1, p0, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$Padding_Var$Builder;->top_:I

    .line 417
    iget v0, p0, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$Padding_Var$Builder;->bitField0_:I

    and-int/lit8 v0, v0, -0x2

    iput v0, p0, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$Padding_Var$Builder;->bitField0_:I

    .line 418
    iput v1, p0, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$Padding_Var$Builder;->left_:I

    .line 419
    iget v0, p0, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$Padding_Var$Builder;->bitField0_:I

    and-int/lit8 v0, v0, -0x3

    iput v0, p0, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$Padding_Var$Builder;->bitField0_:I

    .line 420
    iput v1, p0, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$Padding_Var$Builder;->bottom_:I

    .line 421
    iget v0, p0, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$Padding_Var$Builder;->bitField0_:I

    and-int/lit8 v0, v0, -0x5

    iput v0, p0, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$Padding_Var$Builder;->bitField0_:I

    .line 422
    iput v1, p0, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$Padding_Var$Builder;->right_:I

    .line 423
    iget v0, p0, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$Padding_Var$Builder;->bitField0_:I

    and-int/lit8 v0, v0, -0x9

    iput v0, p0, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$Padding_Var$Builder;->bitField0_:I

    .line 424
    return-object p0
.end method

.method public bridge synthetic clear()Lcom/google/protobuf/AbstractMessage$Builder;
    .locals 1

    .prologue
    .line 381
    invoke-virtual {p0}, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$Padding_Var$Builder;->clear()Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$Padding_Var$Builder;

    move-result-object v0

    return-object v0
.end method

.method public bridge synthetic clear()Lcom/google/protobuf/GeneratedMessage$Builder;
    .locals 1

    .prologue
    .line 381
    invoke-virtual {p0}, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$Padding_Var$Builder;->clear()Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$Padding_Var$Builder;

    move-result-object v0

    return-object v0
.end method

.method public bridge synthetic clear()Lcom/google/protobuf/Message$Builder;
    .locals 1

    .prologue
    .line 381
    invoke-virtual {p0}, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$Padding_Var$Builder;->clear()Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$Padding_Var$Builder;

    move-result-object v0

    return-object v0
.end method

.method public bridge synthetic clear()Lcom/google/protobuf/MessageLite$Builder;
    .locals 1

    .prologue
    .line 381
    invoke-virtual {p0}, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$Padding_Var$Builder;->clear()Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$Padding_Var$Builder;

    move-result-object v0

    return-object v0
.end method

.method public clearBottom()Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$Padding_Var$Builder;
    .locals 1

    .prologue
    .line 632
    iget v0, p0, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$Padding_Var$Builder;->bitField0_:I

    and-int/lit8 v0, v0, -0x5

    iput v0, p0, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$Padding_Var$Builder;->bitField0_:I

    .line 633
    const/4 v0, 0x0

    iput v0, p0, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$Padding_Var$Builder;->bottom_:I

    .line 634
    invoke-virtual {p0}, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$Padding_Var$Builder;->onChanged()V

    .line 635
    return-object p0
.end method

.method public clearLeft()Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$Padding_Var$Builder;
    .locals 1

    .prologue
    .line 599
    iget v0, p0, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$Padding_Var$Builder;->bitField0_:I

    and-int/lit8 v0, v0, -0x3

    iput v0, p0, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$Padding_Var$Builder;->bitField0_:I

    .line 600
    const/4 v0, 0x0

    iput v0, p0, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$Padding_Var$Builder;->left_:I

    .line 601
    invoke-virtual {p0}, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$Padding_Var$Builder;->onChanged()V

    .line 602
    return-object p0
.end method

.method public clearRight()Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$Padding_Var$Builder;
    .locals 1

    .prologue
    .line 665
    iget v0, p0, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$Padding_Var$Builder;->bitField0_:I

    and-int/lit8 v0, v0, -0x9

    iput v0, p0, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$Padding_Var$Builder;->bitField0_:I

    .line 666
    const/4 v0, 0x0

    iput v0, p0, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$Padding_Var$Builder;->right_:I

    .line 667
    invoke-virtual {p0}, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$Padding_Var$Builder;->onChanged()V

    .line 668
    return-object p0
.end method

.method public clearTop()Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$Padding_Var$Builder;
    .locals 1

    .prologue
    .line 566
    iget v0, p0, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$Padding_Var$Builder;->bitField0_:I

    and-int/lit8 v0, v0, -0x2

    iput v0, p0, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$Padding_Var$Builder;->bitField0_:I

    .line 567
    const/4 v0, 0x0

    iput v0, p0, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$Padding_Var$Builder;->top_:I

    .line 568
    invoke-virtual {p0}, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$Padding_Var$Builder;->onChanged()V

    .line 569
    return-object p0
.end method

.method public clone()Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$Padding_Var$Builder;
    .locals 2

    .prologue
    .line 428
    invoke-static {}, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$Padding_Var$Builder;->create()Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$Padding_Var$Builder;

    move-result-object v0

    invoke-virtual {p0}, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$Padding_Var$Builder;->buildPartial()Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$Padding_Var;

    move-result-object v1

    invoke-virtual {v0, v1}, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$Padding_Var$Builder;->mergeFrom(Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$Padding_Var;)Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$Padding_Var$Builder;

    move-result-object v0

    return-object v0
.end method

.method public bridge synthetic clone()Lcom/google/protobuf/AbstractMessage$Builder;
    .locals 1

    .prologue
    .line 381
    invoke-virtual {p0}, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$Padding_Var$Builder;->clone()Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$Padding_Var$Builder;

    move-result-object v0

    return-object v0
.end method

.method public bridge synthetic clone()Lcom/google/protobuf/AbstractMessageLite$Builder;
    .locals 1

    .prologue
    .line 381
    invoke-virtual {p0}, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$Padding_Var$Builder;->clone()Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$Padding_Var$Builder;

    move-result-object v0

    return-object v0
.end method

.method public bridge synthetic clone()Lcom/google/protobuf/GeneratedMessage$Builder;
    .locals 1

    .prologue
    .line 381
    invoke-virtual {p0}, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$Padding_Var$Builder;->clone()Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$Padding_Var$Builder;

    move-result-object v0

    return-object v0
.end method

.method public bridge synthetic clone()Lcom/google/protobuf/Message$Builder;
    .locals 1

    .prologue
    .line 381
    invoke-virtual {p0}, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$Padding_Var$Builder;->clone()Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$Padding_Var$Builder;

    move-result-object v0

    return-object v0
.end method

.method public bridge synthetic clone()Lcom/google/protobuf/MessageLite$Builder;
    .locals 1

    .prologue
    .line 381
    invoke-virtual {p0}, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$Padding_Var$Builder;->clone()Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$Padding_Var$Builder;

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
    .line 381
    invoke-virtual {p0}, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$Padding_Var$Builder;->clone()Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$Padding_Var$Builder;

    move-result-object v0

    return-object v0
.end method

.method public getBottom()I
    .locals 1

    .prologue
    .line 617
    iget v0, p0, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$Padding_Var$Builder;->bottom_:I

    return v0
.end method

.method public getDefaultInstanceForType()Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$Padding_Var;
    .locals 1

    .prologue
    .line 437
    invoke-static {}, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$Padding_Var;->getDefaultInstance()Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$Padding_Var;

    move-result-object v0

    return-object v0
.end method

.method public bridge synthetic getDefaultInstanceForType()Lcom/google/protobuf/Message;
    .locals 1

    .prologue
    .line 381
    invoke-virtual {p0}, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$Padding_Var$Builder;->getDefaultInstanceForType()Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$Padding_Var;

    move-result-object v0

    return-object v0
.end method

.method public bridge synthetic getDefaultInstanceForType()Lcom/google/protobuf/MessageLite;
    .locals 1

    .prologue
    .line 381
    invoke-virtual {p0}, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$Padding_Var$Builder;->getDefaultInstanceForType()Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$Padding_Var;

    move-result-object v0

    return-object v0
.end method

.method public getDescriptorForType()Lcom/google/protobuf/Descriptors$Descriptor;
    .locals 1

    .prologue
    .line 433
    invoke-static {}, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage;->b()Lcom/google/protobuf/Descriptors$Descriptor;

    move-result-object v0

    return-object v0
.end method

.method public getLeft()I
    .locals 1

    .prologue
    .line 584
    iget v0, p0, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$Padding_Var$Builder;->left_:I

    return v0
.end method

.method public getRight()I
    .locals 1

    .prologue
    .line 650
    iget v0, p0, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$Padding_Var$Builder;->right_:I

    return v0
.end method

.method public getTop()I
    .locals 1

    .prologue
    .line 551
    iget v0, p0, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$Padding_Var$Builder;->top_:I

    return v0
.end method

.method public hasBottom()Z
    .locals 2

    .prologue
    .line 611
    iget v0, p0, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$Padding_Var$Builder;->bitField0_:I

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

.method public hasLeft()Z
    .locals 2

    .prologue
    .line 578
    iget v0, p0, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$Padding_Var$Builder;->bitField0_:I

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

.method public hasRight()Z
    .locals 2

    .prologue
    .line 644
    iget v0, p0, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$Padding_Var$Builder;->bitField0_:I

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

.method public hasTop()Z
    .locals 2

    .prologue
    const/4 v0, 0x1

    .line 545
    iget v1, p0, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$Padding_Var$Builder;->bitField0_:I

    and-int/lit8 v1, v1, 0x1

    if-ne v1, v0, :cond_0

    :goto_0
    return v0

    :cond_0
    const/4 v0, 0x0

    goto :goto_0
.end method

.method protected internalGetFieldAccessorTable()Lcom/google/protobuf/GeneratedMessage$FieldAccessorTable;
    .locals 3

    .prologue
    .line 391
    invoke-static {}, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage;->c()Lcom/google/protobuf/GeneratedMessage$FieldAccessorTable;

    move-result-object v0

    const-class v1, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$Padding_Var;

    const-class v2, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$Padding_Var$Builder;

    .line 392
    invoke-virtual {v0, v1, v2}, Lcom/google/protobuf/GeneratedMessage$FieldAccessorTable;->ensureFieldAccessorsInitialized(Ljava/lang/Class;Ljava/lang/Class;)Lcom/google/protobuf/GeneratedMessage$FieldAccessorTable;

    move-result-object v0

    .line 391
    return-object v0
.end method

.method public final isInitialized()Z
    .locals 2

    .prologue
    const/4 v0, 0x0

    .line 501
    invoke-virtual {p0}, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$Padding_Var$Builder;->hasTop()Z

    move-result v1

    if-nez v1, :cond_1

    .line 517
    :cond_0
    :goto_0
    return v0

    .line 505
    :cond_1
    invoke-virtual {p0}, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$Padding_Var$Builder;->hasLeft()Z

    move-result v1

    if-eqz v1, :cond_0

    .line 509
    invoke-virtual {p0}, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$Padding_Var$Builder;->hasBottom()Z

    move-result v1

    if-eqz v1, :cond_0

    .line 513
    invoke-virtual {p0}, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$Padding_Var$Builder;->hasRight()Z

    move-result v1

    if-eqz v1, :cond_0

    .line 517
    const/4 v0, 0x1

    goto :goto_0
.end method

.method public mergeFrom(Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$Padding_Var;)Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$Padding_Var$Builder;
    .locals 1

    .prologue
    .line 483
    invoke-static {}, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$Padding_Var;->getDefaultInstance()Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$Padding_Var;

    move-result-object v0

    if-ne p1, v0, :cond_0

    .line 497
    :goto_0
    return-object p0

    .line 484
    :cond_0
    invoke-virtual {p1}, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$Padding_Var;->hasTop()Z

    move-result v0

    if-eqz v0, :cond_1

    .line 485
    invoke-virtual {p1}, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$Padding_Var;->getTop()I

    move-result v0

    invoke-virtual {p0, v0}, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$Padding_Var$Builder;->setTop(I)Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$Padding_Var$Builder;

    .line 487
    :cond_1
    invoke-virtual {p1}, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$Padding_Var;->hasLeft()Z

    move-result v0

    if-eqz v0, :cond_2

    .line 488
    invoke-virtual {p1}, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$Padding_Var;->getLeft()I

    move-result v0

    invoke-virtual {p0, v0}, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$Padding_Var$Builder;->setLeft(I)Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$Padding_Var$Builder;

    .line 490
    :cond_2
    invoke-virtual {p1}, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$Padding_Var;->hasBottom()Z

    move-result v0

    if-eqz v0, :cond_3

    .line 491
    invoke-virtual {p1}, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$Padding_Var;->getBottom()I

    move-result v0

    invoke-virtual {p0, v0}, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$Padding_Var$Builder;->setBottom(I)Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$Padding_Var$Builder;

    .line 493
    :cond_3
    invoke-virtual {p1}, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$Padding_Var;->hasRight()Z

    move-result v0

    if-eqz v0, :cond_4

    .line 494
    invoke-virtual {p1}, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$Padding_Var;->getRight()I

    move-result v0

    invoke-virtual {p0, v0}, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$Padding_Var$Builder;->setRight(I)Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$Padding_Var$Builder;

    .line 496
    :cond_4
    invoke-virtual {p1}, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$Padding_Var;->getUnknownFields()Lcom/google/protobuf/UnknownFieldSet;

    move-result-object v0

    invoke-virtual {p0, v0}, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$Padding_Var$Builder;->mergeUnknownFields(Lcom/google/protobuf/UnknownFieldSet;)Lcom/google/protobuf/GeneratedMessage$Builder;

    goto :goto_0
.end method

.method public mergeFrom(Lcom/google/protobuf/CodedInputStream;Lcom/google/protobuf/ExtensionRegistryLite;)Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$Padding_Var$Builder;
    .locals 4
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljava/io/IOException;
        }
    .end annotation

    .prologue
    .line 524
    const/4 v2, 0x0

    .line 526
    :try_start_0
    sget-object v0, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$Padding_Var;->PARSER:Lcom/google/protobuf/Parser;

    invoke-interface {v0, p1, p2}, Lcom/google/protobuf/Parser;->parsePartialFrom(Lcom/google/protobuf/CodedInputStream;Lcom/google/protobuf/ExtensionRegistryLite;)Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$Padding_Var;
    :try_end_0
    .catch Lcom/google/protobuf/InvalidProtocolBufferException; {:try_start_0 .. :try_end_0} :catch_0
    .catchall {:try_start_0 .. :try_end_0} :catchall_1

    .line 531
    if-eqz v0, :cond_0

    .line 532
    invoke-virtual {p0, v0}, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$Padding_Var$Builder;->mergeFrom(Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$Padding_Var;)Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$Padding_Var$Builder;

    .line 535
    :cond_0
    return-object p0

    .line 527
    :catch_0
    move-exception v0

    move-object v1, v0

    .line 528
    :try_start_1
    invoke-virtual {v1}, Lcom/google/protobuf/InvalidProtocolBufferException;->getUnfinishedMessage()Lcom/google/protobuf/MessageLite;

    move-result-object v0

    check-cast v0, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$Padding_Var;
    :try_end_1
    .catchall {:try_start_1 .. :try_end_1} :catchall_1

    .line 529
    :try_start_2
    throw v1
    :try_end_2
    .catchall {:try_start_2 .. :try_end_2} :catchall_0

    .line 531
    :catchall_0
    move-exception v1

    move-object v3, v1

    move-object v1, v0

    move-object v0, v3

    :goto_0
    if-eqz v1, :cond_1

    .line 532
    invoke-virtual {p0, v1}, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$Padding_Var$Builder;->mergeFrom(Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$Padding_Var;)Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$Padding_Var$Builder;

    :cond_1
    throw v0

    .line 531
    :catchall_1
    move-exception v0

    move-object v1, v2

    goto :goto_0
.end method

.method public mergeFrom(Lcom/google/protobuf/Message;)Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$Padding_Var$Builder;
    .locals 1

    .prologue
    .line 474
    instance-of v0, p1, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$Padding_Var;

    if-eqz v0, :cond_0

    .line 475
    check-cast p1, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$Padding_Var;

    invoke-virtual {p0, p1}, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$Padding_Var$Builder;->mergeFrom(Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$Padding_Var;)Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$Padding_Var$Builder;

    move-result-object p0

    .line 478
    :goto_0
    return-object p0

    .line 477
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
    .line 381
    invoke-virtual {p0, p1, p2}, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$Padding_Var$Builder;->mergeFrom(Lcom/google/protobuf/CodedInputStream;Lcom/google/protobuf/ExtensionRegistryLite;)Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$Padding_Var$Builder;

    move-result-object v0

    return-object v0
.end method

.method public bridge synthetic mergeFrom(Lcom/google/protobuf/Message;)Lcom/google/protobuf/AbstractMessage$Builder;
    .locals 1

    .prologue
    .line 381
    invoke-virtual {p0, p1}, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$Padding_Var$Builder;->mergeFrom(Lcom/google/protobuf/Message;)Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$Padding_Var$Builder;

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
    .line 381
    invoke-virtual {p0, p1, p2}, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$Padding_Var$Builder;->mergeFrom(Lcom/google/protobuf/CodedInputStream;Lcom/google/protobuf/ExtensionRegistryLite;)Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$Padding_Var$Builder;

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
    .line 381
    invoke-virtual {p0, p1, p2}, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$Padding_Var$Builder;->mergeFrom(Lcom/google/protobuf/CodedInputStream;Lcom/google/protobuf/ExtensionRegistryLite;)Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$Padding_Var$Builder;

    move-result-object v0

    return-object v0
.end method

.method public bridge synthetic mergeFrom(Lcom/google/protobuf/Message;)Lcom/google/protobuf/Message$Builder;
    .locals 1

    .prologue
    .line 381
    invoke-virtual {p0, p1}, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$Padding_Var$Builder;->mergeFrom(Lcom/google/protobuf/Message;)Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$Padding_Var$Builder;

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
    .line 381
    invoke-virtual {p0, p1, p2}, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$Padding_Var$Builder;->mergeFrom(Lcom/google/protobuf/CodedInputStream;Lcom/google/protobuf/ExtensionRegistryLite;)Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$Padding_Var$Builder;

    move-result-object v0

    return-object v0
.end method

.method public setBottom(I)Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$Padding_Var$Builder;
    .locals 1

    .prologue
    .line 623
    iget v0, p0, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$Padding_Var$Builder;->bitField0_:I

    or-int/lit8 v0, v0, 0x4

    iput v0, p0, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$Padding_Var$Builder;->bitField0_:I

    .line 624
    iput p1, p0, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$Padding_Var$Builder;->bottom_:I

    .line 625
    invoke-virtual {p0}, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$Padding_Var$Builder;->onChanged()V

    .line 626
    return-object p0
.end method

.method public setLeft(I)Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$Padding_Var$Builder;
    .locals 1

    .prologue
    .line 590
    iget v0, p0, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$Padding_Var$Builder;->bitField0_:I

    or-int/lit8 v0, v0, 0x2

    iput v0, p0, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$Padding_Var$Builder;->bitField0_:I

    .line 591
    iput p1, p0, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$Padding_Var$Builder;->left_:I

    .line 592
    invoke-virtual {p0}, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$Padding_Var$Builder;->onChanged()V

    .line 593
    return-object p0
.end method

.method public setRight(I)Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$Padding_Var$Builder;
    .locals 1

    .prologue
    .line 656
    iget v0, p0, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$Padding_Var$Builder;->bitField0_:I

    or-int/lit8 v0, v0, 0x8

    iput v0, p0, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$Padding_Var$Builder;->bitField0_:I

    .line 657
    iput p1, p0, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$Padding_Var$Builder;->right_:I

    .line 658
    invoke-virtual {p0}, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$Padding_Var$Builder;->onChanged()V

    .line 659
    return-object p0
.end method

.method public setTop(I)Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$Padding_Var$Builder;
    .locals 1

    .prologue
    .line 557
    iget v0, p0, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$Padding_Var$Builder;->bitField0_:I

    or-int/lit8 v0, v0, 0x1

    iput v0, p0, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$Padding_Var$Builder;->bitField0_:I

    .line 558
    iput p1, p0, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$Padding_Var$Builder;->top_:I

    .line 559
    invoke-virtual {p0}, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$Padding_Var$Builder;->onChanged()V

    .line 560
    return-object p0
.end method
