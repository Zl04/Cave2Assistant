.class public final Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$CommandToUi$Builder;
.super Lcom/google/protobuf/GeneratedMessage$Builder;
.source "SourceFile"

# interfaces
.implements Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$CommandToUiOrBuilder;


# annotations
.annotation system Ldalvik/annotation/EnclosingClass;
    value = Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$CommandToUi;
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x19
    name = "Builder"
.end annotation

.annotation system Ldalvik/annotation/Signature;
    value = {
        "Lcom/google/protobuf/GeneratedMessage$Builder",
        "<",
        "Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$CommandToUi$Builder;",
        ">;",
        "Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$CommandToUiOrBuilder;"
    }
.end annotation


# instance fields
.field private alignType_:I

.field private bitField0_:I

.field private color_:Ljava/lang/Object;

.field private command_:Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$CommandToUi$Command_Type;

.field private controlId_:Ljava/lang/Object;

.field private defaultCheckStatus_:Z

.field private defaultItemIndex_:I

.field private editInputType_:I

.field private enabledStatus_:Z

.field private fontSize_:I

.field private fontType_:Ljava/lang/Object;

.field private height_:I

.field private itemIndex_:I

.field private itemText_:Lcom/google/protobuf/LazyStringList;

.field private layoutStyle_:I

.field private paddingBuilder_:Lcom/google/protobuf/SingleFieldBuilder;
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "Lcom/google/protobuf/SingleFieldBuilder",
            "<",
            "Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$Padding_Var;",
            "Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$Padding_Var$Builder;",
            "Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$Padding_VarOrBuilder;",
            ">;"
        }
    .end annotation
.end field

.field private padding_:Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$Padding_Var;

.field private parentId_:Ljava/lang/Object;

.field private path_:Ljava/lang/Object;

.field private text_:Ljava/lang/Object;

.field private uipData_:Ljava/lang/Object;

.field private url_:Ljava/lang/Object;

.field private visibleStatus_:I

.field private width_:I


# direct methods
.method private constructor <init>()V
    .locals 1

    .prologue
    .line 2691
    invoke-direct {p0}, Lcom/google/protobuf/GeneratedMessage$Builder;-><init>()V

    .line 3024
    sget-object v0, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$CommandToUi$Command_Type;->NEW_LAYOUT:Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$CommandToUi$Command_Type;

    iput-object v0, p0, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$CommandToUi$Builder;->command_:Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$CommandToUi$Command_Type;

    .line 3060
    const-string v0, ""

    iput-object v0, p0, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$CommandToUi$Builder;->controlId_:Ljava/lang/Object;

    .line 3134
    const-string v0, ""

    iput-object v0, p0, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$CommandToUi$Builder;->parentId_:Ljava/lang/Object;

    .line 3208
    const-string v0, ""

    iput-object v0, p0, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$CommandToUi$Builder;->text_:Ljava/lang/Object;

    .line 3414
    sget-object v0, Lcom/google/protobuf/LazyStringArrayList;->EMPTY:Lcom/google/protobuf/LazyStringList;

    iput-object v0, p0, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$CommandToUi$Builder;->itemText_:Lcom/google/protobuf/LazyStringList;

    .line 3573
    const-string v0, ""

    iput-object v0, p0, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$CommandToUi$Builder;->path_:Ljava/lang/Object;

    .line 3647
    const-string v0, ""

    iput-object v0, p0, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$CommandToUi$Builder;->url_:Ljava/lang/Object;

    .line 3787
    const-string v0, ""

    iput-object v0, p0, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$CommandToUi$Builder;->color_:Ljava/lang/Object;

    .line 3894
    invoke-static {}, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$Padding_Var;->getDefaultInstance()Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$Padding_Var;

    move-result-object v0

    iput-object v0, p0, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$CommandToUi$Builder;->padding_:Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$Padding_Var;

    .line 4011
    const-string v0, ""

    iput-object v0, p0, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$CommandToUi$Builder;->uipData_:Ljava/lang/Object;

    .line 4142
    const-string v0, ""

    iput-object v0, p0, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$CommandToUi$Builder;->fontType_:Ljava/lang/Object;

    .line 2692
    invoke-direct {p0}, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$CommandToUi$Builder;->maybeForceBuilderInitialization()V

    .line 2693
    return-void
.end method

.method private constructor <init>(Lcom/google/protobuf/GeneratedMessage$BuilderParent;)V
    .locals 1

    .prologue
    .line 2697
    invoke-direct {p0, p1}, Lcom/google/protobuf/GeneratedMessage$Builder;-><init>(Lcom/google/protobuf/GeneratedMessage$BuilderParent;)V

    .line 3024
    sget-object v0, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$CommandToUi$Command_Type;->NEW_LAYOUT:Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$CommandToUi$Command_Type;

    iput-object v0, p0, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$CommandToUi$Builder;->command_:Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$CommandToUi$Command_Type;

    .line 3060
    const-string v0, ""

    iput-object v0, p0, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$CommandToUi$Builder;->controlId_:Ljava/lang/Object;

    .line 3134
    const-string v0, ""

    iput-object v0, p0, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$CommandToUi$Builder;->parentId_:Ljava/lang/Object;

    .line 3208
    const-string v0, ""

    iput-object v0, p0, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$CommandToUi$Builder;->text_:Ljava/lang/Object;

    .line 3414
    sget-object v0, Lcom/google/protobuf/LazyStringArrayList;->EMPTY:Lcom/google/protobuf/LazyStringList;

    iput-object v0, p0, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$CommandToUi$Builder;->itemText_:Lcom/google/protobuf/LazyStringList;

    .line 3573
    const-string v0, ""

    iput-object v0, p0, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$CommandToUi$Builder;->path_:Ljava/lang/Object;

    .line 3647
    const-string v0, ""

    iput-object v0, p0, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$CommandToUi$Builder;->url_:Ljava/lang/Object;

    .line 3787
    const-string v0, ""

    iput-object v0, p0, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$CommandToUi$Builder;->color_:Ljava/lang/Object;

    .line 3894
    invoke-static {}, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$Padding_Var;->getDefaultInstance()Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$Padding_Var;

    move-result-object v0

    iput-object v0, p0, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$CommandToUi$Builder;->padding_:Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$Padding_Var;

    .line 4011
    const-string v0, ""

    iput-object v0, p0, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$CommandToUi$Builder;->uipData_:Ljava/lang/Object;

    .line 4142
    const-string v0, ""

    iput-object v0, p0, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$CommandToUi$Builder;->fontType_:Ljava/lang/Object;

    .line 2698
    invoke-direct {p0}, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$CommandToUi$Builder;->maybeForceBuilderInitialization()V

    .line 2699
    return-void
.end method

.method synthetic constructor <init>(Lcom/google/protobuf/GeneratedMessage$BuilderParent;Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$1;)V
    .locals 0

    .prologue
    .line 2675
    invoke-direct {p0, p1}, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$CommandToUi$Builder;-><init>(Lcom/google/protobuf/GeneratedMessage$BuilderParent;)V

    return-void
.end method

.method static synthetic access$1500()Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$CommandToUi$Builder;
    .locals 1

    .prologue
    .line 2675
    invoke-static {}, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$CommandToUi$Builder;->create()Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$CommandToUi$Builder;

    move-result-object v0

    return-object v0
.end method

.method private static create()Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$CommandToUi$Builder;
    .locals 1

    .prologue
    .line 2706
    new-instance v0, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$CommandToUi$Builder;

    invoke-direct {v0}, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$CommandToUi$Builder;-><init>()V

    return-object v0
.end method

.method private ensureItemTextIsMutable()V
    .locals 2

    .prologue
    .line 3416
    iget v0, p0, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$CommandToUi$Builder;->bitField0_:I

    and-int/lit16 v0, v0, 0x100

    const/16 v1, 0x100

    if-eq v0, v1, :cond_0

    .line 3417
    new-instance v0, Lcom/google/protobuf/LazyStringArrayList;

    iget-object v1, p0, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$CommandToUi$Builder;->itemText_:Lcom/google/protobuf/LazyStringList;

    invoke-direct {v0, v1}, Lcom/google/protobuf/LazyStringArrayList;-><init>(Lcom/google/protobuf/LazyStringList;)V

    iput-object v0, p0, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$CommandToUi$Builder;->itemText_:Lcom/google/protobuf/LazyStringList;

    .line 3418
    iget v0, p0, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$CommandToUi$Builder;->bitField0_:I

    or-int/lit16 v0, v0, 0x100

    iput v0, p0, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$CommandToUi$Builder;->bitField0_:I

    .line 3420
    :cond_0
    return-void
.end method

.method public static final getDescriptor()Lcom/google/protobuf/Descriptors$Descriptor;
    .locals 1

    .prologue
    .line 2680
    invoke-static {}, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage;->d()Lcom/google/protobuf/Descriptors$Descriptor;

    move-result-object v0

    return-object v0
.end method

.method private getPaddingFieldBuilder()Lcom/google/protobuf/SingleFieldBuilder;
    .locals 4
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "()",
            "Lcom/google/protobuf/SingleFieldBuilder",
            "<",
            "Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$Padding_Var;",
            "Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$Padding_Var$Builder;",
            "Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$Padding_VarOrBuilder;",
            ">;"
        }
    .end annotation

    .prologue
    .line 3999
    iget-object v0, p0, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$CommandToUi$Builder;->paddingBuilder_:Lcom/google/protobuf/SingleFieldBuilder;

    if-nez v0, :cond_0

    .line 4000
    new-instance v0, Lcom/google/protobuf/SingleFieldBuilder;

    iget-object v1, p0, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$CommandToUi$Builder;->padding_:Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$Padding_Var;

    .line 4003
    invoke-virtual {p0}, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$CommandToUi$Builder;->getParentForChildren()Lcom/google/protobuf/GeneratedMessage$BuilderParent;

    move-result-object v2

    .line 4004
    invoke-virtual {p0}, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$CommandToUi$Builder;->isClean()Z

    move-result v3

    invoke-direct {v0, v1, v2, v3}, Lcom/google/protobuf/SingleFieldBuilder;-><init>(Lcom/google/protobuf/GeneratedMessage;Lcom/google/protobuf/GeneratedMessage$BuilderParent;Z)V

    iput-object v0, p0, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$CommandToUi$Builder;->paddingBuilder_:Lcom/google/protobuf/SingleFieldBuilder;

    .line 4005
    const/4 v0, 0x0

    iput-object v0, p0, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$CommandToUi$Builder;->padding_:Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$Padding_Var;

    .line 4007
    :cond_0
    iget-object v0, p0, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$CommandToUi$Builder;->paddingBuilder_:Lcom/google/protobuf/SingleFieldBuilder;

    return-object v0
.end method

.method private maybeForceBuilderInitialization()V
    .locals 1

    .prologue
    .line 2701
    invoke-static {}, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$CommandToUi;->access$1700()Z

    move-result v0

    if-eqz v0, :cond_0

    .line 2702
    invoke-direct {p0}, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$CommandToUi$Builder;->getPaddingFieldBuilder()Lcom/google/protobuf/SingleFieldBuilder;

    .line 2704
    :cond_0
    return-void
.end method


# virtual methods
.method public addAllItemText(Ljava/lang/Iterable;)Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$CommandToUi$Builder;
    .locals 1
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "(",
            "Ljava/lang/Iterable",
            "<",
            "Ljava/lang/String;",
            ">;)",
            "Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$CommandToUi$Builder;"
        }
    .end annotation

    .prologue
    .line 3478
    invoke-direct {p0}, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$CommandToUi$Builder;->ensureItemTextIsMutable()V

    .line 3479
    iget-object v0, p0, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$CommandToUi$Builder;->itemText_:Lcom/google/protobuf/LazyStringList;

    invoke-static {p1, v0}, Lcom/google/protobuf/GeneratedMessage$Builder;->addAll(Ljava/lang/Iterable;Ljava/util/Collection;)V

    .line 3480
    invoke-virtual {p0}, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$CommandToUi$Builder;->onChanged()V

    .line 3481
    return-object p0
.end method

.method public addItemText(Ljava/lang/String;)Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$CommandToUi$Builder;
    .locals 1

    .prologue
    .line 3465
    if-nez p1, :cond_0

    .line 3466
    new-instance v0, Ljava/lang/NullPointerException;

    invoke-direct {v0}, Ljava/lang/NullPointerException;-><init>()V

    throw v0

    .line 3468
    :cond_0
    invoke-direct {p0}, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$CommandToUi$Builder;->ensureItemTextIsMutable()V

    .line 3469
    iget-object v0, p0, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$CommandToUi$Builder;->itemText_:Lcom/google/protobuf/LazyStringList;

    invoke-interface {v0, p1}, Lcom/google/protobuf/LazyStringList;->add(Ljava/lang/Object;)Z

    .line 3470
    invoke-virtual {p0}, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$CommandToUi$Builder;->onChanged()V

    .line 3471
    return-object p0
.end method

.method public addItemTextBytes(Lcom/google/protobuf/ByteString;)Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$CommandToUi$Builder;
    .locals 1

    .prologue
    .line 3497
    if-nez p1, :cond_0

    .line 3498
    new-instance v0, Ljava/lang/NullPointerException;

    invoke-direct {v0}, Ljava/lang/NullPointerException;-><init>()V

    throw v0

    .line 3500
    :cond_0
    invoke-direct {p0}, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$CommandToUi$Builder;->ensureItemTextIsMutable()V

    .line 3501
    iget-object v0, p0, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$CommandToUi$Builder;->itemText_:Lcom/google/protobuf/LazyStringList;

    invoke-interface {v0, p1}, Lcom/google/protobuf/LazyStringList;->add(Lcom/google/protobuf/ByteString;)V

    .line 3502
    invoke-virtual {p0}, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$CommandToUi$Builder;->onChanged()V

    .line 3503
    return-object p0
.end method

.method public build()Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$CommandToUi;
    .locals 2

    .prologue
    .line 2776
    invoke-virtual {p0}, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$CommandToUi$Builder;->buildPartial()Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$CommandToUi;

    move-result-object v0

    .line 2777
    invoke-virtual {v0}, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$CommandToUi;->isInitialized()Z

    move-result v1

    if-nez v1, :cond_0

    .line 2778
    invoke-static {v0}, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$CommandToUi$Builder;->newUninitializedMessageException(Lcom/google/protobuf/Message;)Lcom/google/protobuf/UninitializedMessageException;

    move-result-object v0

    throw v0

    .line 2780
    :cond_0
    return-object v0
.end method

.method public bridge synthetic build()Lcom/google/protobuf/Message;
    .locals 1

    .prologue
    .line 2675
    invoke-virtual {p0}, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$CommandToUi$Builder;->build()Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$CommandToUi;

    move-result-object v0

    return-object v0
.end method

.method public bridge synthetic build()Lcom/google/protobuf/MessageLite;
    .locals 1

    .prologue
    .line 2675
    invoke-virtual {p0}, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$CommandToUi$Builder;->build()Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$CommandToUi;

    move-result-object v0

    return-object v0
.end method

.method public buildPartial()Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$CommandToUi;
    .locals 10

    .prologue
    const/high16 v9, 0x80000

    const/high16 v8, 0x40000

    const/high16 v7, 0x20000

    const/high16 v6, 0x10000

    const v5, 0x8000

    .line 2784
    new-instance v2, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$CommandToUi;

    const/4 v0, 0x0

    invoke-direct {v2, p0, v0}, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$CommandToUi;-><init>(Lcom/google/protobuf/GeneratedMessage$Builder;Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$1;)V

    .line 2785
    iget v3, p0, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$CommandToUi$Builder;->bitField0_:I

    .line 2786
    const/4 v0, 0x0

    .line 2787
    and-int/lit8 v1, v3, 0x1

    const/4 v4, 0x1

    if-ne v1, v4, :cond_0

    .line 2788
    const/4 v0, 0x1

    .line 2790
    :cond_0
    iget-object v1, p0, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$CommandToUi$Builder;->command_:Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$CommandToUi$Command_Type;

    invoke-static {v2, v1}, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$CommandToUi;->access$1902(Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$CommandToUi;Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$CommandToUi$Command_Type;)Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$CommandToUi$Command_Type;

    .line 2791
    and-int/lit8 v1, v3, 0x2

    const/4 v4, 0x2

    if-ne v1, v4, :cond_1

    .line 2792
    or-int/lit8 v0, v0, 0x2

    .line 2794
    :cond_1
    iget-object v1, p0, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$CommandToUi$Builder;->controlId_:Ljava/lang/Object;

    invoke-static {v2, v1}, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$CommandToUi;->access$2002(Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$CommandToUi;Ljava/lang/Object;)Ljava/lang/Object;

    .line 2795
    and-int/lit8 v1, v3, 0x4

    const/4 v4, 0x4

    if-ne v1, v4, :cond_2

    .line 2796
    or-int/lit8 v0, v0, 0x4

    .line 2798
    :cond_2
    iget-object v1, p0, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$CommandToUi$Builder;->parentId_:Ljava/lang/Object;

    invoke-static {v2, v1}, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$CommandToUi;->access$2102(Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$CommandToUi;Ljava/lang/Object;)Ljava/lang/Object;

    .line 2799
    and-int/lit8 v1, v3, 0x8

    const/16 v4, 0x8

    if-ne v1, v4, :cond_3

    .line 2800
    or-int/lit8 v0, v0, 0x8

    .line 2802
    :cond_3
    iget-object v1, p0, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$CommandToUi$Builder;->text_:Ljava/lang/Object;

    invoke-static {v2, v1}, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$CommandToUi;->access$2202(Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$CommandToUi;Ljava/lang/Object;)Ljava/lang/Object;

    .line 2803
    and-int/lit8 v1, v3, 0x10

    const/16 v4, 0x10

    if-ne v1, v4, :cond_4

    .line 2804
    or-int/lit8 v0, v0, 0x10

    .line 2806
    :cond_4
    iget v1, p0, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$CommandToUi$Builder;->width_:I

    invoke-static {v2, v1}, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$CommandToUi;->access$2302(Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$CommandToUi;I)I

    .line 2807
    and-int/lit8 v1, v3, 0x20

    const/16 v4, 0x20

    if-ne v1, v4, :cond_5

    .line 2808
    or-int/lit8 v0, v0, 0x20

    .line 2810
    :cond_5
    iget v1, p0, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$CommandToUi$Builder;->height_:I

    invoke-static {v2, v1}, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$CommandToUi;->access$2402(Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$CommandToUi;I)I

    .line 2811
    and-int/lit8 v1, v3, 0x40

    const/16 v4, 0x40

    if-ne v1, v4, :cond_6

    .line 2812
    or-int/lit8 v0, v0, 0x40

    .line 2814
    :cond_6
    iget v1, p0, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$CommandToUi$Builder;->layoutStyle_:I

    invoke-static {v2, v1}, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$CommandToUi;->access$2502(Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$CommandToUi;I)I

    .line 2815
    and-int/lit16 v1, v3, 0x80

    const/16 v4, 0x80

    if-ne v1, v4, :cond_7

    .line 2816
    or-int/lit16 v0, v0, 0x80

    .line 2818
    :cond_7
    iget-boolean v1, p0, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$CommandToUi$Builder;->defaultCheckStatus_:Z

    invoke-static {v2, v1}, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$CommandToUi;->access$2602(Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$CommandToUi;Z)Z

    .line 2819
    iget v1, p0, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$CommandToUi$Builder;->bitField0_:I

    and-int/lit16 v1, v1, 0x100

    const/16 v4, 0x100

    if-ne v1, v4, :cond_8

    .line 2820
    new-instance v1, Lcom/google/protobuf/UnmodifiableLazyStringList;

    iget-object v4, p0, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$CommandToUi$Builder;->itemText_:Lcom/google/protobuf/LazyStringList;

    invoke-direct {v1, v4}, Lcom/google/protobuf/UnmodifiableLazyStringList;-><init>(Lcom/google/protobuf/LazyStringList;)V

    iput-object v1, p0, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$CommandToUi$Builder;->itemText_:Lcom/google/protobuf/LazyStringList;

    .line 2822
    iget v1, p0, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$CommandToUi$Builder;->bitField0_:I

    and-int/lit16 v1, v1, -0x101

    iput v1, p0, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$CommandToUi$Builder;->bitField0_:I

    .line 2824
    :cond_8
    iget-object v1, p0, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$CommandToUi$Builder;->itemText_:Lcom/google/protobuf/LazyStringList;

    invoke-static {v2, v1}, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$CommandToUi;->access$2702(Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$CommandToUi;Lcom/google/protobuf/LazyStringList;)Lcom/google/protobuf/LazyStringList;

    .line 2825
    and-int/lit16 v1, v3, 0x200

    const/16 v4, 0x200

    if-ne v1, v4, :cond_9

    .line 2826
    or-int/lit16 v0, v0, 0x100

    .line 2828
    :cond_9
    iget v1, p0, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$CommandToUi$Builder;->itemIndex_:I

    invoke-static {v2, v1}, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$CommandToUi;->access$2802(Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$CommandToUi;I)I

    .line 2829
    and-int/lit16 v1, v3, 0x400

    const/16 v4, 0x400

    if-ne v1, v4, :cond_a

    .line 2830
    or-int/lit16 v0, v0, 0x200

    .line 2832
    :cond_a
    iget v1, p0, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$CommandToUi$Builder;->defaultItemIndex_:I

    invoke-static {v2, v1}, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$CommandToUi;->access$2902(Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$CommandToUi;I)I

    .line 2833
    and-int/lit16 v1, v3, 0x800

    const/16 v4, 0x800

    if-ne v1, v4, :cond_b

    .line 2834
    or-int/lit16 v0, v0, 0x400

    .line 2836
    :cond_b
    iget-object v1, p0, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$CommandToUi$Builder;->path_:Ljava/lang/Object;

    invoke-static {v2, v1}, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$CommandToUi;->access$3002(Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$CommandToUi;Ljava/lang/Object;)Ljava/lang/Object;

    .line 2837
    and-int/lit16 v1, v3, 0x1000

    const/16 v4, 0x1000

    if-ne v1, v4, :cond_c

    .line 2838
    or-int/lit16 v0, v0, 0x800

    .line 2840
    :cond_c
    iget-object v1, p0, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$CommandToUi$Builder;->url_:Ljava/lang/Object;

    invoke-static {v2, v1}, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$CommandToUi;->access$3102(Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$CommandToUi;Ljava/lang/Object;)Ljava/lang/Object;

    .line 2841
    and-int/lit16 v1, v3, 0x2000

    const/16 v4, 0x2000

    if-ne v1, v4, :cond_d

    .line 2842
    or-int/lit16 v0, v0, 0x1000

    .line 2844
    :cond_d
    iget-boolean v1, p0, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$CommandToUi$Builder;->enabledStatus_:Z

    invoke-static {v2, v1}, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$CommandToUi;->access$3202(Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$CommandToUi;Z)Z

    .line 2845
    and-int/lit16 v1, v3, 0x4000

    const/16 v4, 0x4000

    if-ne v1, v4, :cond_e

    .line 2846
    or-int/lit16 v0, v0, 0x2000

    .line 2848
    :cond_e
    iget v1, p0, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$CommandToUi$Builder;->visibleStatus_:I

    invoke-static {v2, v1}, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$CommandToUi;->access$3302(Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$CommandToUi;I)I

    .line 2849
    and-int v1, v3, v5

    if-ne v1, v5, :cond_f

    .line 2850
    or-int/lit16 v0, v0, 0x4000

    .line 2852
    :cond_f
    iget-object v1, p0, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$CommandToUi$Builder;->color_:Ljava/lang/Object;

    invoke-static {v2, v1}, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$CommandToUi;->access$3402(Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$CommandToUi;Ljava/lang/Object;)Ljava/lang/Object;

    .line 2853
    and-int v1, v3, v6

    if-ne v1, v6, :cond_10

    .line 2854
    or-int/2addr v0, v5

    .line 2856
    :cond_10
    iget v1, p0, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$CommandToUi$Builder;->alignType_:I

    invoke-static {v2, v1}, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$CommandToUi;->access$3502(Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$CommandToUi;I)I

    .line 2857
    and-int v1, v3, v7

    if-ne v1, v7, :cond_16

    .line 2858
    or-int/2addr v0, v6

    move v1, v0

    .line 2860
    :goto_0
    iget-object v0, p0, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$CommandToUi$Builder;->paddingBuilder_:Lcom/google/protobuf/SingleFieldBuilder;

    if-nez v0, :cond_15

    .line 2861
    iget-object v0, p0, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$CommandToUi$Builder;->padding_:Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$Padding_Var;

    invoke-static {v2, v0}, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$CommandToUi;->access$3602(Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$CommandToUi;Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$Padding_Var;)Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$Padding_Var;

    .line 2865
    :goto_1
    and-int v0, v3, v8

    if-ne v0, v8, :cond_11

    .line 2866
    or-int/2addr v1, v7

    .line 2868
    :cond_11
    iget-object v0, p0, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$CommandToUi$Builder;->uipData_:Ljava/lang/Object;

    invoke-static {v2, v0}, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$CommandToUi;->access$3702(Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$CommandToUi;Ljava/lang/Object;)Ljava/lang/Object;

    .line 2869
    and-int v0, v3, v9

    if-ne v0, v9, :cond_12

    .line 2870
    or-int/2addr v1, v8

    .line 2872
    :cond_12
    iget v0, p0, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$CommandToUi$Builder;->editInputType_:I

    invoke-static {v2, v0}, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$CommandToUi;->access$3802(Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$CommandToUi;I)I

    .line 2873
    const/high16 v0, 0x100000

    and-int/2addr v0, v3

    const/high16 v4, 0x100000

    if-ne v0, v4, :cond_13

    .line 2874
    or-int/2addr v1, v9

    .line 2876
    :cond_13
    iget-object v0, p0, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$CommandToUi$Builder;->fontType_:Ljava/lang/Object;

    invoke-static {v2, v0}, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$CommandToUi;->access$3902(Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$CommandToUi;Ljava/lang/Object;)Ljava/lang/Object;

    .line 2877
    const/high16 v0, 0x200000

    and-int/2addr v0, v3

    const/high16 v3, 0x200000

    if-ne v0, v3, :cond_14

    .line 2878
    const/high16 v0, 0x100000

    or-int/2addr v1, v0

    .line 2880
    :cond_14
    iget v0, p0, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$CommandToUi$Builder;->fontSize_:I

    invoke-static {v2, v0}, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$CommandToUi;->access$4002(Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$CommandToUi;I)I

    .line 2881
    invoke-static {v2, v1}, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$CommandToUi;->access$4102(Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$CommandToUi;I)I

    .line 2882
    invoke-virtual {p0}, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$CommandToUi$Builder;->onBuilt()V

    .line 2883
    return-object v2

    .line 2863
    :cond_15
    iget-object v0, p0, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$CommandToUi$Builder;->paddingBuilder_:Lcom/google/protobuf/SingleFieldBuilder;

    invoke-virtual {v0}, Lcom/google/protobuf/SingleFieldBuilder;->build()Lcom/google/protobuf/GeneratedMessage;

    move-result-object v0

    check-cast v0, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$Padding_Var;

    invoke-static {v2, v0}, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$CommandToUi;->access$3602(Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$CommandToUi;Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$Padding_Var;)Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$Padding_Var;

    goto :goto_1

    :cond_16
    move v1, v0

    goto :goto_0
.end method

.method public bridge synthetic buildPartial()Lcom/google/protobuf/Message;
    .locals 1

    .prologue
    .line 2675
    invoke-virtual {p0}, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$CommandToUi$Builder;->buildPartial()Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$CommandToUi;

    move-result-object v0

    return-object v0
.end method

.method public bridge synthetic buildPartial()Lcom/google/protobuf/MessageLite;
    .locals 1

    .prologue
    .line 2675
    invoke-virtual {p0}, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$CommandToUi$Builder;->buildPartial()Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$CommandToUi;

    move-result-object v0

    return-object v0
.end method

.method public clear()Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$CommandToUi$Builder;
    .locals 3

    .prologue
    const/4 v2, 0x0

    .line 2710
    invoke-super {p0}, Lcom/google/protobuf/GeneratedMessage$Builder;->clear()Lcom/google/protobuf/GeneratedMessage$Builder;

    .line 2711
    sget-object v0, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$CommandToUi$Command_Type;->NEW_LAYOUT:Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$CommandToUi$Command_Type;

    iput-object v0, p0, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$CommandToUi$Builder;->command_:Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$CommandToUi$Command_Type;

    .line 2712
    iget v0, p0, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$CommandToUi$Builder;->bitField0_:I

    and-int/lit8 v0, v0, -0x2

    iput v0, p0, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$CommandToUi$Builder;->bitField0_:I

    .line 2713
    const-string v0, ""

    iput-object v0, p0, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$CommandToUi$Builder;->controlId_:Ljava/lang/Object;

    .line 2714
    iget v0, p0, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$CommandToUi$Builder;->bitField0_:I

    and-int/lit8 v0, v0, -0x3

    iput v0, p0, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$CommandToUi$Builder;->bitField0_:I

    .line 2715
    const-string v0, ""

    iput-object v0, p0, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$CommandToUi$Builder;->parentId_:Ljava/lang/Object;

    .line 2716
    iget v0, p0, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$CommandToUi$Builder;->bitField0_:I

    and-int/lit8 v0, v0, -0x5

    iput v0, p0, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$CommandToUi$Builder;->bitField0_:I

    .line 2717
    const-string v0, ""

    iput-object v0, p0, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$CommandToUi$Builder;->text_:Ljava/lang/Object;

    .line 2718
    iget v0, p0, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$CommandToUi$Builder;->bitField0_:I

    and-int/lit8 v0, v0, -0x9

    iput v0, p0, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$CommandToUi$Builder;->bitField0_:I

    .line 2719
    iput v2, p0, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$CommandToUi$Builder;->width_:I

    .line 2720
    iget v0, p0, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$CommandToUi$Builder;->bitField0_:I

    and-int/lit8 v0, v0, -0x11

    iput v0, p0, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$CommandToUi$Builder;->bitField0_:I

    .line 2721
    iput v2, p0, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$CommandToUi$Builder;->height_:I

    .line 2722
    iget v0, p0, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$CommandToUi$Builder;->bitField0_:I

    and-int/lit8 v0, v0, -0x21

    iput v0, p0, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$CommandToUi$Builder;->bitField0_:I

    .line 2723
    iput v2, p0, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$CommandToUi$Builder;->layoutStyle_:I

    .line 2724
    iget v0, p0, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$CommandToUi$Builder;->bitField0_:I

    and-int/lit8 v0, v0, -0x41

    iput v0, p0, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$CommandToUi$Builder;->bitField0_:I

    .line 2725
    iput-boolean v2, p0, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$CommandToUi$Builder;->defaultCheckStatus_:Z

    .line 2726
    iget v0, p0, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$CommandToUi$Builder;->bitField0_:I

    and-int/lit16 v0, v0, -0x81

    iput v0, p0, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$CommandToUi$Builder;->bitField0_:I

    .line 2727
    sget-object v0, Lcom/google/protobuf/LazyStringArrayList;->EMPTY:Lcom/google/protobuf/LazyStringList;

    iput-object v0, p0, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$CommandToUi$Builder;->itemText_:Lcom/google/protobuf/LazyStringList;

    .line 2728
    iget v0, p0, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$CommandToUi$Builder;->bitField0_:I

    and-int/lit16 v0, v0, -0x101

    iput v0, p0, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$CommandToUi$Builder;->bitField0_:I

    .line 2729
    iput v2, p0, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$CommandToUi$Builder;->itemIndex_:I

    .line 2730
    iget v0, p0, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$CommandToUi$Builder;->bitField0_:I

    and-int/lit16 v0, v0, -0x201

    iput v0, p0, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$CommandToUi$Builder;->bitField0_:I

    .line 2731
    iput v2, p0, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$CommandToUi$Builder;->defaultItemIndex_:I

    .line 2732
    iget v0, p0, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$CommandToUi$Builder;->bitField0_:I

    and-int/lit16 v0, v0, -0x401

    iput v0, p0, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$CommandToUi$Builder;->bitField0_:I

    .line 2733
    const-string v0, ""

    iput-object v0, p0, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$CommandToUi$Builder;->path_:Ljava/lang/Object;

    .line 2734
    iget v0, p0, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$CommandToUi$Builder;->bitField0_:I

    and-int/lit16 v0, v0, -0x801

    iput v0, p0, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$CommandToUi$Builder;->bitField0_:I

    .line 2735
    const-string v0, ""

    iput-object v0, p0, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$CommandToUi$Builder;->url_:Ljava/lang/Object;

    .line 2736
    iget v0, p0, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$CommandToUi$Builder;->bitField0_:I

    and-int/lit16 v0, v0, -0x1001

    iput v0, p0, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$CommandToUi$Builder;->bitField0_:I

    .line 2737
    iput-boolean v2, p0, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$CommandToUi$Builder;->enabledStatus_:Z

    .line 2738
    iget v0, p0, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$CommandToUi$Builder;->bitField0_:I

    and-int/lit16 v0, v0, -0x2001

    iput v0, p0, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$CommandToUi$Builder;->bitField0_:I

    .line 2739
    iput v2, p0, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$CommandToUi$Builder;->visibleStatus_:I

    .line 2740
    iget v0, p0, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$CommandToUi$Builder;->bitField0_:I

    and-int/lit16 v0, v0, -0x4001

    iput v0, p0, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$CommandToUi$Builder;->bitField0_:I

    .line 2741
    const-string v0, ""

    iput-object v0, p0, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$CommandToUi$Builder;->color_:Ljava/lang/Object;

    .line 2742
    iget v0, p0, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$CommandToUi$Builder;->bitField0_:I

    const v1, -0x8001

    and-int/2addr v0, v1

    iput v0, p0, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$CommandToUi$Builder;->bitField0_:I

    .line 2743
    iput v2, p0, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$CommandToUi$Builder;->alignType_:I

    .line 2744
    iget v0, p0, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$CommandToUi$Builder;->bitField0_:I

    const v1, -0x10001

    and-int/2addr v0, v1

    iput v0, p0, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$CommandToUi$Builder;->bitField0_:I

    .line 2745
    iget-object v0, p0, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$CommandToUi$Builder;->paddingBuilder_:Lcom/google/protobuf/SingleFieldBuilder;

    if-nez v0, :cond_0

    .line 2746
    invoke-static {}, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$Padding_Var;->getDefaultInstance()Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$Padding_Var;

    move-result-object v0

    iput-object v0, p0, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$CommandToUi$Builder;->padding_:Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$Padding_Var;

    .line 2750
    :goto_0
    iget v0, p0, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$CommandToUi$Builder;->bitField0_:I

    const v1, -0x20001

    and-int/2addr v0, v1

    iput v0, p0, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$CommandToUi$Builder;->bitField0_:I

    .line 2751
    const-string v0, ""

    iput-object v0, p0, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$CommandToUi$Builder;->uipData_:Ljava/lang/Object;

    .line 2752
    iget v0, p0, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$CommandToUi$Builder;->bitField0_:I

    const v1, -0x40001

    and-int/2addr v0, v1

    iput v0, p0, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$CommandToUi$Builder;->bitField0_:I

    .line 2753
    iput v2, p0, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$CommandToUi$Builder;->editInputType_:I

    .line 2754
    iget v0, p0, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$CommandToUi$Builder;->bitField0_:I

    const v1, -0x80001

    and-int/2addr v0, v1

    iput v0, p0, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$CommandToUi$Builder;->bitField0_:I

    .line 2755
    const-string v0, ""

    iput-object v0, p0, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$CommandToUi$Builder;->fontType_:Ljava/lang/Object;

    .line 2756
    iget v0, p0, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$CommandToUi$Builder;->bitField0_:I

    const v1, -0x100001

    and-int/2addr v0, v1

    iput v0, p0, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$CommandToUi$Builder;->bitField0_:I

    .line 2757
    iput v2, p0, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$CommandToUi$Builder;->fontSize_:I

    .line 2758
    iget v0, p0, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$CommandToUi$Builder;->bitField0_:I

    const v1, -0x200001

    and-int/2addr v0, v1

    iput v0, p0, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$CommandToUi$Builder;->bitField0_:I

    .line 2759
    return-object p0

    .line 2748
    :cond_0
    iget-object v0, p0, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$CommandToUi$Builder;->paddingBuilder_:Lcom/google/protobuf/SingleFieldBuilder;

    invoke-virtual {v0}, Lcom/google/protobuf/SingleFieldBuilder;->clear()Lcom/google/protobuf/SingleFieldBuilder;

    goto :goto_0
.end method

.method public bridge synthetic clear()Lcom/google/protobuf/AbstractMessage$Builder;
    .locals 1

    .prologue
    .line 2675
    invoke-virtual {p0}, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$CommandToUi$Builder;->clear()Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$CommandToUi$Builder;

    move-result-object v0

    return-object v0
.end method

.method public bridge synthetic clear()Lcom/google/protobuf/GeneratedMessage$Builder;
    .locals 1

    .prologue
    .line 2675
    invoke-virtual {p0}, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$CommandToUi$Builder;->clear()Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$CommandToUi$Builder;

    move-result-object v0

    return-object v0
.end method

.method public bridge synthetic clear()Lcom/google/protobuf/Message$Builder;
    .locals 1

    .prologue
    .line 2675
    invoke-virtual {p0}, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$CommandToUi$Builder;->clear()Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$CommandToUi$Builder;

    move-result-object v0

    return-object v0
.end method

.method public bridge synthetic clear()Lcom/google/protobuf/MessageLite$Builder;
    .locals 1

    .prologue
    .line 2675
    invoke-virtual {p0}, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$CommandToUi$Builder;->clear()Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$CommandToUi$Builder;

    move-result-object v0

    return-object v0
.end method

.method public clearAlignType()Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$CommandToUi$Builder;
    .locals 2

    .prologue
    .line 3887
    iget v0, p0, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$CommandToUi$Builder;->bitField0_:I

    const v1, -0x10001

    and-int/2addr v0, v1

    iput v0, p0, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$CommandToUi$Builder;->bitField0_:I

    .line 3888
    const/4 v0, 0x0

    iput v0, p0, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$CommandToUi$Builder;->alignType_:I

    .line 3889
    invoke-virtual {p0}, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$CommandToUi$Builder;->onChanged()V

    .line 3890
    return-object p0
.end method

.method public clearColor()Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$CommandToUi$Builder;
    .locals 2

    .prologue
    .line 3841
    iget v0, p0, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$CommandToUi$Builder;->bitField0_:I

    const v1, -0x8001

    and-int/2addr v0, v1

    iput v0, p0, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$CommandToUi$Builder;->bitField0_:I

    .line 3842
    invoke-static {}, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$CommandToUi;->getDefaultInstance()Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$CommandToUi;

    move-result-object v0

    invoke-virtual {v0}, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$CommandToUi;->getColor()Ljava/lang/String;

    move-result-object v0

    iput-object v0, p0, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$CommandToUi$Builder;->color_:Ljava/lang/Object;

    .line 3843
    invoke-virtual {p0}, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$CommandToUi$Builder;->onChanged()V

    .line 3844
    return-object p0
.end method

.method public clearCommand()Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$CommandToUi$Builder;
    .locals 1

    .prologue
    .line 3053
    iget v0, p0, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$CommandToUi$Builder;->bitField0_:I

    and-int/lit8 v0, v0, -0x2

    iput v0, p0, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$CommandToUi$Builder;->bitField0_:I

    .line 3054
    sget-object v0, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$CommandToUi$Command_Type;->NEW_LAYOUT:Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$CommandToUi$Command_Type;

    iput-object v0, p0, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$CommandToUi$Builder;->command_:Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$CommandToUi$Command_Type;

    .line 3055
    invoke-virtual {p0}, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$CommandToUi$Builder;->onChanged()V

    .line 3056
    return-object p0
.end method

.method public clearControlId()Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$CommandToUi$Builder;
    .locals 1

    .prologue
    .line 3114
    iget v0, p0, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$CommandToUi$Builder;->bitField0_:I

    and-int/lit8 v0, v0, -0x3

    iput v0, p0, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$CommandToUi$Builder;->bitField0_:I

    .line 3115
    invoke-static {}, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$CommandToUi;->getDefaultInstance()Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$CommandToUi;

    move-result-object v0

    invoke-virtual {v0}, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$CommandToUi;->getControlId()Ljava/lang/String;

    move-result-object v0

    iput-object v0, p0, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$CommandToUi$Builder;->controlId_:Ljava/lang/Object;

    .line 3116
    invoke-virtual {p0}, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$CommandToUi$Builder;->onChanged()V

    .line 3117
    return-object p0
.end method

.method public clearDefaultCheckStatus()Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$CommandToUi$Builder;
    .locals 1

    .prologue
    .line 3407
    iget v0, p0, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$CommandToUi$Builder;->bitField0_:I

    and-int/lit16 v0, v0, -0x81

    iput v0, p0, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$CommandToUi$Builder;->bitField0_:I

    .line 3408
    const/4 v0, 0x0

    iput-boolean v0, p0, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$CommandToUi$Builder;->defaultCheckStatus_:Z

    .line 3409
    invoke-virtual {p0}, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$CommandToUi$Builder;->onChanged()V

    .line 3410
    return-object p0
.end method

.method public clearDefaultItemIndex()Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$CommandToUi$Builder;
    .locals 1

    .prologue
    .line 3566
    iget v0, p0, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$CommandToUi$Builder;->bitField0_:I

    and-int/lit16 v0, v0, -0x401

    iput v0, p0, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$CommandToUi$Builder;->bitField0_:I

    .line 3567
    const/4 v0, 0x0

    iput v0, p0, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$CommandToUi$Builder;->defaultItemIndex_:I

    .line 3568
    invoke-virtual {p0}, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$CommandToUi$Builder;->onChanged()V

    .line 3569
    return-object p0
.end method

.method public clearEditInputType()Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$CommandToUi$Builder;
    .locals 2

    .prologue
    .line 4135
    iget v0, p0, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$CommandToUi$Builder;->bitField0_:I

    const v1, -0x80001

    and-int/2addr v0, v1

    iput v0, p0, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$CommandToUi$Builder;->bitField0_:I

    .line 4136
    const/4 v0, 0x0

    iput v0, p0, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$CommandToUi$Builder;->editInputType_:I

    .line 4137
    invoke-virtual {p0}, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$CommandToUi$Builder;->onChanged()V

    .line 4138
    return-object p0
.end method

.method public clearEnabledStatus()Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$CommandToUi$Builder;
    .locals 1

    .prologue
    .line 3747
    iget v0, p0, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$CommandToUi$Builder;->bitField0_:I

    and-int/lit16 v0, v0, -0x2001

    iput v0, p0, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$CommandToUi$Builder;->bitField0_:I

    .line 3748
    const/4 v0, 0x0

    iput-boolean v0, p0, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$CommandToUi$Builder;->enabledStatus_:Z

    .line 3749
    invoke-virtual {p0}, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$CommandToUi$Builder;->onChanged()V

    .line 3750
    return-object p0
.end method

.method public clearFontSize()Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$CommandToUi$Builder;
    .locals 2

    .prologue
    .line 4242
    iget v0, p0, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$CommandToUi$Builder;->bitField0_:I

    const v1, -0x200001

    and-int/2addr v0, v1

    iput v0, p0, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$CommandToUi$Builder;->bitField0_:I

    .line 4243
    const/4 v0, 0x0

    iput v0, p0, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$CommandToUi$Builder;->fontSize_:I

    .line 4244
    invoke-virtual {p0}, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$CommandToUi$Builder;->onChanged()V

    .line 4245
    return-object p0
.end method

.method public clearFontType()Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$CommandToUi$Builder;
    .locals 2

    .prologue
    .line 4196
    iget v0, p0, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$CommandToUi$Builder;->bitField0_:I

    const v1, -0x100001

    and-int/2addr v0, v1

    iput v0, p0, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$CommandToUi$Builder;->bitField0_:I

    .line 4197
    invoke-static {}, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$CommandToUi;->getDefaultInstance()Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$CommandToUi;

    move-result-object v0

    invoke-virtual {v0}, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$CommandToUi;->getFontType()Ljava/lang/String;

    move-result-object v0

    iput-object v0, p0, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$CommandToUi$Builder;->fontType_:Ljava/lang/Object;

    .line 4198
    invoke-virtual {p0}, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$CommandToUi$Builder;->onChanged()V

    .line 4199
    return-object p0
.end method

.method public clearHeight()Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$CommandToUi$Builder;
    .locals 1

    .prologue
    .line 3341
    iget v0, p0, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$CommandToUi$Builder;->bitField0_:I

    and-int/lit8 v0, v0, -0x21

    iput v0, p0, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$CommandToUi$Builder;->bitField0_:I

    .line 3342
    const/4 v0, 0x0

    iput v0, p0, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$CommandToUi$Builder;->height_:I

    .line 3343
    invoke-virtual {p0}, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$CommandToUi$Builder;->onChanged()V

    .line 3344
    return-object p0
.end method

.method public clearItemIndex()Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$CommandToUi$Builder;
    .locals 1

    .prologue
    .line 3533
    iget v0, p0, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$CommandToUi$Builder;->bitField0_:I

    and-int/lit16 v0, v0, -0x201

    iput v0, p0, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$CommandToUi$Builder;->bitField0_:I

    .line 3534
    const/4 v0, 0x0

    iput v0, p0, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$CommandToUi$Builder;->itemIndex_:I

    .line 3535
    invoke-virtual {p0}, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$CommandToUi$Builder;->onChanged()V

    .line 3536
    return-object p0
.end method

.method public clearItemText()Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$CommandToUi$Builder;
    .locals 1

    .prologue
    .line 3487
    sget-object v0, Lcom/google/protobuf/LazyStringArrayList;->EMPTY:Lcom/google/protobuf/LazyStringList;

    iput-object v0, p0, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$CommandToUi$Builder;->itemText_:Lcom/google/protobuf/LazyStringList;

    .line 3488
    iget v0, p0, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$CommandToUi$Builder;->bitField0_:I

    and-int/lit16 v0, v0, -0x101

    iput v0, p0, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$CommandToUi$Builder;->bitField0_:I

    .line 3489
    invoke-virtual {p0}, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$CommandToUi$Builder;->onChanged()V

    .line 3490
    return-object p0
.end method

.method public clearLayoutStyle()Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$CommandToUi$Builder;
    .locals 1

    .prologue
    .line 3374
    iget v0, p0, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$CommandToUi$Builder;->bitField0_:I

    and-int/lit8 v0, v0, -0x41

    iput v0, p0, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$CommandToUi$Builder;->bitField0_:I

    .line 3375
    const/4 v0, 0x0

    iput v0, p0, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$CommandToUi$Builder;->layoutStyle_:I

    .line 3376
    invoke-virtual {p0}, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$CommandToUi$Builder;->onChanged()V

    .line 3377
    return-object p0
.end method

.method public clearPadding()Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$CommandToUi$Builder;
    .locals 2

    .prologue
    .line 3966
    iget-object v0, p0, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$CommandToUi$Builder;->paddingBuilder_:Lcom/google/protobuf/SingleFieldBuilder;

    if-nez v0, :cond_0

    .line 3967
    invoke-static {}, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$Padding_Var;->getDefaultInstance()Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$Padding_Var;

    move-result-object v0

    iput-object v0, p0, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$CommandToUi$Builder;->padding_:Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$Padding_Var;

    .line 3968
    invoke-virtual {p0}, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$CommandToUi$Builder;->onChanged()V

    .line 3972
    :goto_0
    iget v0, p0, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$CommandToUi$Builder;->bitField0_:I

    const v1, -0x20001

    and-int/2addr v0, v1

    iput v0, p0, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$CommandToUi$Builder;->bitField0_:I

    .line 3973
    return-object p0

    .line 3970
    :cond_0
    iget-object v0, p0, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$CommandToUi$Builder;->paddingBuilder_:Lcom/google/protobuf/SingleFieldBuilder;

    invoke-virtual {v0}, Lcom/google/protobuf/SingleFieldBuilder;->clear()Lcom/google/protobuf/SingleFieldBuilder;

    goto :goto_0
.end method

.method public clearParentId()Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$CommandToUi$Builder;
    .locals 1

    .prologue
    .line 3188
    iget v0, p0, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$CommandToUi$Builder;->bitField0_:I

    and-int/lit8 v0, v0, -0x5

    iput v0, p0, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$CommandToUi$Builder;->bitField0_:I

    .line 3189
    invoke-static {}, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$CommandToUi;->getDefaultInstance()Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$CommandToUi;

    move-result-object v0

    invoke-virtual {v0}, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$CommandToUi;->getParentId()Ljava/lang/String;

    move-result-object v0

    iput-object v0, p0, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$CommandToUi$Builder;->parentId_:Ljava/lang/Object;

    .line 3190
    invoke-virtual {p0}, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$CommandToUi$Builder;->onChanged()V

    .line 3191
    return-object p0
.end method

.method public clearPath()Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$CommandToUi$Builder;
    .locals 1

    .prologue
    .line 3627
    iget v0, p0, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$CommandToUi$Builder;->bitField0_:I

    and-int/lit16 v0, v0, -0x801

    iput v0, p0, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$CommandToUi$Builder;->bitField0_:I

    .line 3628
    invoke-static {}, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$CommandToUi;->getDefaultInstance()Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$CommandToUi;

    move-result-object v0

    invoke-virtual {v0}, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$CommandToUi;->getPath()Ljava/lang/String;

    move-result-object v0

    iput-object v0, p0, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$CommandToUi$Builder;->path_:Ljava/lang/Object;

    .line 3629
    invoke-virtual {p0}, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$CommandToUi$Builder;->onChanged()V

    .line 3630
    return-object p0
.end method

.method public clearText()Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$CommandToUi$Builder;
    .locals 1

    .prologue
    .line 3262
    iget v0, p0, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$CommandToUi$Builder;->bitField0_:I

    and-int/lit8 v0, v0, -0x9

    iput v0, p0, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$CommandToUi$Builder;->bitField0_:I

    .line 3263
    invoke-static {}, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$CommandToUi;->getDefaultInstance()Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$CommandToUi;

    move-result-object v0

    invoke-virtual {v0}, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$CommandToUi;->getText()Ljava/lang/String;

    move-result-object v0

    iput-object v0, p0, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$CommandToUi$Builder;->text_:Ljava/lang/Object;

    .line 3264
    invoke-virtual {p0}, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$CommandToUi$Builder;->onChanged()V

    .line 3265
    return-object p0
.end method

.method public clearUipData()Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$CommandToUi$Builder;
    .locals 2

    .prologue
    .line 4085
    iget v0, p0, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$CommandToUi$Builder;->bitField0_:I

    const v1, -0x40001

    and-int/2addr v0, v1

    iput v0, p0, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$CommandToUi$Builder;->bitField0_:I

    .line 4086
    invoke-static {}, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$CommandToUi;->getDefaultInstance()Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$CommandToUi;

    move-result-object v0

    invoke-virtual {v0}, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$CommandToUi;->getUipData()Ljava/lang/String;

    move-result-object v0

    iput-object v0, p0, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$CommandToUi$Builder;->uipData_:Ljava/lang/Object;

    .line 4087
    invoke-virtual {p0}, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$CommandToUi$Builder;->onChanged()V

    .line 4088
    return-object p0
.end method

.method public clearUrl()Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$CommandToUi$Builder;
    .locals 1

    .prologue
    .line 3701
    iget v0, p0, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$CommandToUi$Builder;->bitField0_:I

    and-int/lit16 v0, v0, -0x1001

    iput v0, p0, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$CommandToUi$Builder;->bitField0_:I

    .line 3702
    invoke-static {}, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$CommandToUi;->getDefaultInstance()Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$CommandToUi;

    move-result-object v0

    invoke-virtual {v0}, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$CommandToUi;->getUrl()Ljava/lang/String;

    move-result-object v0

    iput-object v0, p0, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$CommandToUi$Builder;->url_:Ljava/lang/Object;

    .line 3703
    invoke-virtual {p0}, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$CommandToUi$Builder;->onChanged()V

    .line 3704
    return-object p0
.end method

.method public clearVisibleStatus()Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$CommandToUi$Builder;
    .locals 1

    .prologue
    .line 3780
    iget v0, p0, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$CommandToUi$Builder;->bitField0_:I

    and-int/lit16 v0, v0, -0x4001

    iput v0, p0, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$CommandToUi$Builder;->bitField0_:I

    .line 3781
    const/4 v0, 0x0

    iput v0, p0, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$CommandToUi$Builder;->visibleStatus_:I

    .line 3782
    invoke-virtual {p0}, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$CommandToUi$Builder;->onChanged()V

    .line 3783
    return-object p0
.end method

.method public clearWidth()Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$CommandToUi$Builder;
    .locals 1

    .prologue
    .line 3308
    iget v0, p0, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$CommandToUi$Builder;->bitField0_:I

    and-int/lit8 v0, v0, -0x11

    iput v0, p0, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$CommandToUi$Builder;->bitField0_:I

    .line 3309
    const/4 v0, 0x0

    iput v0, p0, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$CommandToUi$Builder;->width_:I

    .line 3310
    invoke-virtual {p0}, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$CommandToUi$Builder;->onChanged()V

    .line 3311
    return-object p0
.end method

.method public clone()Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$CommandToUi$Builder;
    .locals 2

    .prologue
    .line 2763
    invoke-static {}, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$CommandToUi$Builder;->create()Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$CommandToUi$Builder;

    move-result-object v0

    invoke-virtual {p0}, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$CommandToUi$Builder;->buildPartial()Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$CommandToUi;

    move-result-object v1

    invoke-virtual {v0, v1}, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$CommandToUi$Builder;->mergeFrom(Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$CommandToUi;)Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$CommandToUi$Builder;

    move-result-object v0

    return-object v0
.end method

.method public bridge synthetic clone()Lcom/google/protobuf/AbstractMessage$Builder;
    .locals 1

    .prologue
    .line 2675
    invoke-virtual {p0}, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$CommandToUi$Builder;->clone()Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$CommandToUi$Builder;

    move-result-object v0

    return-object v0
.end method

.method public bridge synthetic clone()Lcom/google/protobuf/AbstractMessageLite$Builder;
    .locals 1

    .prologue
    .line 2675
    invoke-virtual {p0}, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$CommandToUi$Builder;->clone()Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$CommandToUi$Builder;

    move-result-object v0

    return-object v0
.end method

.method public bridge synthetic clone()Lcom/google/protobuf/GeneratedMessage$Builder;
    .locals 1

    .prologue
    .line 2675
    invoke-virtual {p0}, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$CommandToUi$Builder;->clone()Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$CommandToUi$Builder;

    move-result-object v0

    return-object v0
.end method

.method public bridge synthetic clone()Lcom/google/protobuf/Message$Builder;
    .locals 1

    .prologue
    .line 2675
    invoke-virtual {p0}, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$CommandToUi$Builder;->clone()Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$CommandToUi$Builder;

    move-result-object v0

    return-object v0
.end method

.method public bridge synthetic clone()Lcom/google/protobuf/MessageLite$Builder;
    .locals 1

    .prologue
    .line 2675
    invoke-virtual {p0}, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$CommandToUi$Builder;->clone()Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$CommandToUi$Builder;

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
    .line 2675
    invoke-virtual {p0}, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$CommandToUi$Builder;->clone()Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$CommandToUi$Builder;

    move-result-object v0

    return-object v0
.end method

.method public getAlignType()I
    .locals 1

    .prologue
    .line 3872
    iget v0, p0, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$CommandToUi$Builder;->alignType_:I

    return v0
.end method

.method public getColor()Ljava/lang/String;
    .locals 2

    .prologue
    .line 3798
    iget-object v0, p0, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$CommandToUi$Builder;->color_:Ljava/lang/Object;

    .line 3799
    instance-of v1, v0, Ljava/lang/String;

    if-nez v1, :cond_0

    .line 3800
    check-cast v0, Lcom/google/protobuf/ByteString;

    .line 3801
    invoke-virtual {v0}, Lcom/google/protobuf/ByteString;->toStringUtf8()Ljava/lang/String;

    move-result-object v0

    .line 3802
    iput-object v0, p0, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$CommandToUi$Builder;->color_:Ljava/lang/Object;

    .line 3805
    :goto_0
    return-object v0

    :cond_0
    check-cast v0, Ljava/lang/String;

    goto :goto_0
.end method

.method public getColorBytes()Lcom/google/protobuf/ByteString;
    .locals 2

    .prologue
    .line 3813
    iget-object v0, p0, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$CommandToUi$Builder;->color_:Ljava/lang/Object;

    .line 3814
    instance-of v1, v0, Ljava/lang/String;

    if-eqz v1, :cond_0

    .line 3815
    check-cast v0, Ljava/lang/String;

    .line 3816
    invoke-static {v0}, Lcom/google/protobuf/ByteString;->copyFromUtf8(Ljava/lang/String;)Lcom/google/protobuf/ByteString;

    move-result-object v0

    .line 3818
    iput-object v0, p0, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$CommandToUi$Builder;->color_:Ljava/lang/Object;

    .line 3821
    :goto_0
    return-object v0

    :cond_0
    check-cast v0, Lcom/google/protobuf/ByteString;

    goto :goto_0
.end method

.method public getCommand()Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$CommandToUi$Command_Type;
    .locals 1

    .prologue
    .line 3035
    iget-object v0, p0, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$CommandToUi$Builder;->command_:Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$CommandToUi$Command_Type;

    return-object v0
.end method

.method public getControlId()Ljava/lang/String;
    .locals 2

    .prologue
    .line 3071
    iget-object v0, p0, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$CommandToUi$Builder;->controlId_:Ljava/lang/Object;

    .line 3072
    instance-of v1, v0, Ljava/lang/String;

    if-nez v1, :cond_0

    .line 3073
    check-cast v0, Lcom/google/protobuf/ByteString;

    .line 3074
    invoke-virtual {v0}, Lcom/google/protobuf/ByteString;->toStringUtf8()Ljava/lang/String;

    move-result-object v0

    .line 3075
    iput-object v0, p0, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$CommandToUi$Builder;->controlId_:Ljava/lang/Object;

    .line 3078
    :goto_0
    return-object v0

    :cond_0
    check-cast v0, Ljava/lang/String;

    goto :goto_0
.end method

.method public getControlIdBytes()Lcom/google/protobuf/ByteString;
    .locals 2

    .prologue
    .line 3086
    iget-object v0, p0, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$CommandToUi$Builder;->controlId_:Ljava/lang/Object;

    .line 3087
    instance-of v1, v0, Ljava/lang/String;

    if-eqz v1, :cond_0

    .line 3088
    check-cast v0, Ljava/lang/String;

    .line 3089
    invoke-static {v0}, Lcom/google/protobuf/ByteString;->copyFromUtf8(Ljava/lang/String;)Lcom/google/protobuf/ByteString;

    move-result-object v0

    .line 3091
    iput-object v0, p0, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$CommandToUi$Builder;->controlId_:Ljava/lang/Object;

    .line 3094
    :goto_0
    return-object v0

    :cond_0
    check-cast v0, Lcom/google/protobuf/ByteString;

    goto :goto_0
.end method

.method public getDefaultCheckStatus()Z
    .locals 1

    .prologue
    .line 3392
    iget-boolean v0, p0, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$CommandToUi$Builder;->defaultCheckStatus_:Z

    return v0
.end method

.method public getDefaultInstanceForType()Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$CommandToUi;
    .locals 1

    .prologue
    .line 2772
    invoke-static {}, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$CommandToUi;->getDefaultInstance()Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$CommandToUi;

    move-result-object v0

    return-object v0
.end method

.method public bridge synthetic getDefaultInstanceForType()Lcom/google/protobuf/Message;
    .locals 1

    .prologue
    .line 2675
    invoke-virtual {p0}, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$CommandToUi$Builder;->getDefaultInstanceForType()Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$CommandToUi;

    move-result-object v0

    return-object v0
.end method

.method public bridge synthetic getDefaultInstanceForType()Lcom/google/protobuf/MessageLite;
    .locals 1

    .prologue
    .line 2675
    invoke-virtual {p0}, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$CommandToUi$Builder;->getDefaultInstanceForType()Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$CommandToUi;

    move-result-object v0

    return-object v0
.end method

.method public getDefaultItemIndex()I
    .locals 1

    .prologue
    .line 3551
    iget v0, p0, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$CommandToUi$Builder;->defaultItemIndex_:I

    return v0
.end method

.method public getDescriptorForType()Lcom/google/protobuf/Descriptors$Descriptor;
    .locals 1

    .prologue
    .line 2768
    invoke-static {}, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage;->d()Lcom/google/protobuf/Descriptors$Descriptor;

    move-result-object v0

    return-object v0
.end method

.method public getEditInputType()I
    .locals 1

    .prologue
    .line 4120
    iget v0, p0, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$CommandToUi$Builder;->editInputType_:I

    return v0
.end method

.method public getEnabledStatus()Z
    .locals 1

    .prologue
    .line 3732
    iget-boolean v0, p0, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$CommandToUi$Builder;->enabledStatus_:Z

    return v0
.end method

.method public getFontSize()I
    .locals 1

    .prologue
    .line 4227
    iget v0, p0, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$CommandToUi$Builder;->fontSize_:I

    return v0
.end method

.method public getFontType()Ljava/lang/String;
    .locals 2

    .prologue
    .line 4153
    iget-object v0, p0, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$CommandToUi$Builder;->fontType_:Ljava/lang/Object;

    .line 4154
    instance-of v1, v0, Ljava/lang/String;

    if-nez v1, :cond_0

    .line 4155
    check-cast v0, Lcom/google/protobuf/ByteString;

    .line 4156
    invoke-virtual {v0}, Lcom/google/protobuf/ByteString;->toStringUtf8()Ljava/lang/String;

    move-result-object v0

    .line 4157
    iput-object v0, p0, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$CommandToUi$Builder;->fontType_:Ljava/lang/Object;

    .line 4160
    :goto_0
    return-object v0

    :cond_0
    check-cast v0, Ljava/lang/String;

    goto :goto_0
.end method

.method public getFontTypeBytes()Lcom/google/protobuf/ByteString;
    .locals 2

    .prologue
    .line 4168
    iget-object v0, p0, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$CommandToUi$Builder;->fontType_:Ljava/lang/Object;

    .line 4169
    instance-of v1, v0, Ljava/lang/String;

    if-eqz v1, :cond_0

    .line 4170
    check-cast v0, Ljava/lang/String;

    .line 4171
    invoke-static {v0}, Lcom/google/protobuf/ByteString;->copyFromUtf8(Ljava/lang/String;)Lcom/google/protobuf/ByteString;

    move-result-object v0

    .line 4173
    iput-object v0, p0, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$CommandToUi$Builder;->fontType_:Ljava/lang/Object;

    .line 4176
    :goto_0
    return-object v0

    :cond_0
    check-cast v0, Lcom/google/protobuf/ByteString;

    goto :goto_0
.end method

.method public getHeight()I
    .locals 1

    .prologue
    .line 3326
    iget v0, p0, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$CommandToUi$Builder;->height_:I

    return v0
.end method

.method public getItemIndex()I
    .locals 1

    .prologue
    .line 3518
    iget v0, p0, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$CommandToUi$Builder;->itemIndex_:I

    return v0
.end method

.method public getItemText(I)Ljava/lang/String;
    .locals 1

    .prologue
    .line 3438
    iget-object v0, p0, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$CommandToUi$Builder;->itemText_:Lcom/google/protobuf/LazyStringList;

    invoke-interface {v0, p1}, Lcom/google/protobuf/LazyStringList;->get(I)Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Ljava/lang/String;

    return-object v0
.end method

.method public getItemTextBytes(I)Lcom/google/protobuf/ByteString;
    .locals 1

    .prologue
    .line 3445
    iget-object v0, p0, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$CommandToUi$Builder;->itemText_:Lcom/google/protobuf/LazyStringList;

    invoke-interface {v0, p1}, Lcom/google/protobuf/LazyStringList;->getByteString(I)Lcom/google/protobuf/ByteString;

    move-result-object v0

    return-object v0
.end method

.method public getItemTextCount()I
    .locals 1

    .prologue
    .line 3432
    iget-object v0, p0, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$CommandToUi$Builder;->itemText_:Lcom/google/protobuf/LazyStringList;

    invoke-interface {v0}, Lcom/google/protobuf/LazyStringList;->size()I

    move-result v0

    return v0
.end method

.method public getItemTextList()Ljava/util/List;
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
    .line 3426
    iget-object v0, p0, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$CommandToUi$Builder;->itemText_:Lcom/google/protobuf/LazyStringList;

    invoke-static {v0}, Ljava/util/Collections;->unmodifiableList(Ljava/util/List;)Ljava/util/List;

    move-result-object v0

    return-object v0
.end method

.method public getLayoutStyle()I
    .locals 1

    .prologue
    .line 3359
    iget v0, p0, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$CommandToUi$Builder;->layoutStyle_:I

    return v0
.end method

.method public getPadding()Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$Padding_Var;
    .locals 1

    .prologue
    .line 3907
    iget-object v0, p0, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$CommandToUi$Builder;->paddingBuilder_:Lcom/google/protobuf/SingleFieldBuilder;

    if-nez v0, :cond_0

    .line 3908
    iget-object v0, p0, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$CommandToUi$Builder;->padding_:Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$Padding_Var;

    .line 3910
    :goto_0
    return-object v0

    :cond_0
    iget-object v0, p0, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$CommandToUi$Builder;->paddingBuilder_:Lcom/google/protobuf/SingleFieldBuilder;

    invoke-virtual {v0}, Lcom/google/protobuf/SingleFieldBuilder;->getMessage()Lcom/google/protobuf/GeneratedMessage;

    move-result-object v0

    check-cast v0, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$Padding_Var;

    goto :goto_0
.end method

.method public getPaddingBuilder()Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$Padding_Var$Builder;
    .locals 2

    .prologue
    .line 3979
    iget v0, p0, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$CommandToUi$Builder;->bitField0_:I

    const/high16 v1, 0x20000

    or-int/2addr v0, v1

    iput v0, p0, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$CommandToUi$Builder;->bitField0_:I

    .line 3980
    invoke-virtual {p0}, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$CommandToUi$Builder;->onChanged()V

    .line 3981
    invoke-direct {p0}, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$CommandToUi$Builder;->getPaddingFieldBuilder()Lcom/google/protobuf/SingleFieldBuilder;

    move-result-object v0

    invoke-virtual {v0}, Lcom/google/protobuf/SingleFieldBuilder;->getBuilder()Lcom/google/protobuf/GeneratedMessage$Builder;

    move-result-object v0

    check-cast v0, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$Padding_Var$Builder;

    return-object v0
.end method

.method public getPaddingOrBuilder()Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$Padding_VarOrBuilder;
    .locals 1

    .prologue
    .line 3987
    iget-object v0, p0, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$CommandToUi$Builder;->paddingBuilder_:Lcom/google/protobuf/SingleFieldBuilder;

    if-eqz v0, :cond_0

    .line 3988
    iget-object v0, p0, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$CommandToUi$Builder;->paddingBuilder_:Lcom/google/protobuf/SingleFieldBuilder;

    invoke-virtual {v0}, Lcom/google/protobuf/SingleFieldBuilder;->getMessageOrBuilder()Lcom/google/protobuf/MessageOrBuilder;

    move-result-object v0

    check-cast v0, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$Padding_VarOrBuilder;

    .line 3990
    :goto_0
    return-object v0

    :cond_0
    iget-object v0, p0, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$CommandToUi$Builder;->padding_:Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$Padding_Var;

    goto :goto_0
.end method

.method public getParentId()Ljava/lang/String;
    .locals 2

    .prologue
    .line 3145
    iget-object v0, p0, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$CommandToUi$Builder;->parentId_:Ljava/lang/Object;

    .line 3146
    instance-of v1, v0, Ljava/lang/String;

    if-nez v1, :cond_0

    .line 3147
    check-cast v0, Lcom/google/protobuf/ByteString;

    .line 3148
    invoke-virtual {v0}, Lcom/google/protobuf/ByteString;->toStringUtf8()Ljava/lang/String;

    move-result-object v0

    .line 3149
    iput-object v0, p0, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$CommandToUi$Builder;->parentId_:Ljava/lang/Object;

    .line 3152
    :goto_0
    return-object v0

    :cond_0
    check-cast v0, Ljava/lang/String;

    goto :goto_0
.end method

.method public getParentIdBytes()Lcom/google/protobuf/ByteString;
    .locals 2

    .prologue
    .line 3160
    iget-object v0, p0, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$CommandToUi$Builder;->parentId_:Ljava/lang/Object;

    .line 3161
    instance-of v1, v0, Ljava/lang/String;

    if-eqz v1, :cond_0

    .line 3162
    check-cast v0, Ljava/lang/String;

    .line 3163
    invoke-static {v0}, Lcom/google/protobuf/ByteString;->copyFromUtf8(Ljava/lang/String;)Lcom/google/protobuf/ByteString;

    move-result-object v0

    .line 3165
    iput-object v0, p0, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$CommandToUi$Builder;->parentId_:Ljava/lang/Object;

    .line 3168
    :goto_0
    return-object v0

    :cond_0
    check-cast v0, Lcom/google/protobuf/ByteString;

    goto :goto_0
.end method

.method public getPath()Ljava/lang/String;
    .locals 2

    .prologue
    .line 3584
    iget-object v0, p0, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$CommandToUi$Builder;->path_:Ljava/lang/Object;

    .line 3585
    instance-of v1, v0, Ljava/lang/String;

    if-nez v1, :cond_0

    .line 3586
    check-cast v0, Lcom/google/protobuf/ByteString;

    .line 3587
    invoke-virtual {v0}, Lcom/google/protobuf/ByteString;->toStringUtf8()Ljava/lang/String;

    move-result-object v0

    .line 3588
    iput-object v0, p0, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$CommandToUi$Builder;->path_:Ljava/lang/Object;

    .line 3591
    :goto_0
    return-object v0

    :cond_0
    check-cast v0, Ljava/lang/String;

    goto :goto_0
.end method

.method public getPathBytes()Lcom/google/protobuf/ByteString;
    .locals 2

    .prologue
    .line 3599
    iget-object v0, p0, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$CommandToUi$Builder;->path_:Ljava/lang/Object;

    .line 3600
    instance-of v1, v0, Ljava/lang/String;

    if-eqz v1, :cond_0

    .line 3601
    check-cast v0, Ljava/lang/String;

    .line 3602
    invoke-static {v0}, Lcom/google/protobuf/ByteString;->copyFromUtf8(Ljava/lang/String;)Lcom/google/protobuf/ByteString;

    move-result-object v0

    .line 3604
    iput-object v0, p0, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$CommandToUi$Builder;->path_:Ljava/lang/Object;

    .line 3607
    :goto_0
    return-object v0

    :cond_0
    check-cast v0, Lcom/google/protobuf/ByteString;

    goto :goto_0
.end method

.method public getText()Ljava/lang/String;
    .locals 2

    .prologue
    .line 3219
    iget-object v0, p0, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$CommandToUi$Builder;->text_:Ljava/lang/Object;

    .line 3220
    instance-of v1, v0, Ljava/lang/String;

    if-nez v1, :cond_0

    .line 3221
    check-cast v0, Lcom/google/protobuf/ByteString;

    .line 3222
    invoke-virtual {v0}, Lcom/google/protobuf/ByteString;->toStringUtf8()Ljava/lang/String;

    move-result-object v0

    .line 3223
    iput-object v0, p0, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$CommandToUi$Builder;->text_:Ljava/lang/Object;

    .line 3226
    :goto_0
    return-object v0

    :cond_0
    check-cast v0, Ljava/lang/String;

    goto :goto_0
.end method

.method public getTextBytes()Lcom/google/protobuf/ByteString;
    .locals 2

    .prologue
    .line 3234
    iget-object v0, p0, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$CommandToUi$Builder;->text_:Ljava/lang/Object;

    .line 3235
    instance-of v1, v0, Ljava/lang/String;

    if-eqz v1, :cond_0

    .line 3236
    check-cast v0, Ljava/lang/String;

    .line 3237
    invoke-static {v0}, Lcom/google/protobuf/ByteString;->copyFromUtf8(Ljava/lang/String;)Lcom/google/protobuf/ByteString;

    move-result-object v0

    .line 3239
    iput-object v0, p0, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$CommandToUi$Builder;->text_:Ljava/lang/Object;

    .line 3242
    :goto_0
    return-object v0

    :cond_0
    check-cast v0, Lcom/google/protobuf/ByteString;

    goto :goto_0
.end method

.method public getUipData()Ljava/lang/String;
    .locals 2

    .prologue
    .line 4030
    iget-object v0, p0, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$CommandToUi$Builder;->uipData_:Ljava/lang/Object;

    .line 4031
    instance-of v1, v0, Ljava/lang/String;

    if-nez v1, :cond_0

    .line 4032
    check-cast v0, Lcom/google/protobuf/ByteString;

    .line 4033
    invoke-virtual {v0}, Lcom/google/protobuf/ByteString;->toStringUtf8()Ljava/lang/String;

    move-result-object v0

    .line 4034
    iput-object v0, p0, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$CommandToUi$Builder;->uipData_:Ljava/lang/Object;

    .line 4037
    :goto_0
    return-object v0

    :cond_0
    check-cast v0, Ljava/lang/String;

    goto :goto_0
.end method

.method public getUipDataBytes()Lcom/google/protobuf/ByteString;
    .locals 2

    .prologue
    .line 4049
    iget-object v0, p0, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$CommandToUi$Builder;->uipData_:Ljava/lang/Object;

    .line 4050
    instance-of v1, v0, Ljava/lang/String;

    if-eqz v1, :cond_0

    .line 4051
    check-cast v0, Ljava/lang/String;

    .line 4052
    invoke-static {v0}, Lcom/google/protobuf/ByteString;->copyFromUtf8(Ljava/lang/String;)Lcom/google/protobuf/ByteString;

    move-result-object v0

    .line 4054
    iput-object v0, p0, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$CommandToUi$Builder;->uipData_:Ljava/lang/Object;

    .line 4057
    :goto_0
    return-object v0

    :cond_0
    check-cast v0, Lcom/google/protobuf/ByteString;

    goto :goto_0
.end method

.method public getUrl()Ljava/lang/String;
    .locals 2

    .prologue
    .line 3658
    iget-object v0, p0, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$CommandToUi$Builder;->url_:Ljava/lang/Object;

    .line 3659
    instance-of v1, v0, Ljava/lang/String;

    if-nez v1, :cond_0

    .line 3660
    check-cast v0, Lcom/google/protobuf/ByteString;

    .line 3661
    invoke-virtual {v0}, Lcom/google/protobuf/ByteString;->toStringUtf8()Ljava/lang/String;

    move-result-object v0

    .line 3662
    iput-object v0, p0, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$CommandToUi$Builder;->url_:Ljava/lang/Object;

    .line 3665
    :goto_0
    return-object v0

    :cond_0
    check-cast v0, Ljava/lang/String;

    goto :goto_0
.end method

.method public getUrlBytes()Lcom/google/protobuf/ByteString;
    .locals 2

    .prologue
    .line 3673
    iget-object v0, p0, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$CommandToUi$Builder;->url_:Ljava/lang/Object;

    .line 3674
    instance-of v1, v0, Ljava/lang/String;

    if-eqz v1, :cond_0

    .line 3675
    check-cast v0, Ljava/lang/String;

    .line 3676
    invoke-static {v0}, Lcom/google/protobuf/ByteString;->copyFromUtf8(Ljava/lang/String;)Lcom/google/protobuf/ByteString;

    move-result-object v0

    .line 3678
    iput-object v0, p0, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$CommandToUi$Builder;->url_:Ljava/lang/Object;

    .line 3681
    :goto_0
    return-object v0

    :cond_0
    check-cast v0, Lcom/google/protobuf/ByteString;

    goto :goto_0
.end method

.method public getVisibleStatus()I
    .locals 1

    .prologue
    .line 3765
    iget v0, p0, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$CommandToUi$Builder;->visibleStatus_:I

    return v0
.end method

.method public getWidth()I
    .locals 1

    .prologue
    .line 3293
    iget v0, p0, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$CommandToUi$Builder;->width_:I

    return v0
.end method

.method public hasAlignType()Z
    .locals 2

    .prologue
    const/high16 v1, 0x10000

    .line 3866
    iget v0, p0, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$CommandToUi$Builder;->bitField0_:I

    and-int/2addr v0, v1

    if-ne v0, v1, :cond_0

    const/4 v0, 0x1

    :goto_0
    return v0

    :cond_0
    const/4 v0, 0x0

    goto :goto_0
.end method

.method public hasColor()Z
    .locals 2

    .prologue
    const v1, 0x8000

    .line 3792
    iget v0, p0, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$CommandToUi$Builder;->bitField0_:I

    and-int/2addr v0, v1

    if-ne v0, v1, :cond_0

    const/4 v0, 0x1

    :goto_0
    return v0

    :cond_0
    const/4 v0, 0x0

    goto :goto_0
.end method

.method public hasCommand()Z
    .locals 2

    .prologue
    const/4 v0, 0x1

    .line 3029
    iget v1, p0, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$CommandToUi$Builder;->bitField0_:I

    and-int/lit8 v1, v1, 0x1

    if-ne v1, v0, :cond_0

    :goto_0
    return v0

    :cond_0
    const/4 v0, 0x0

    goto :goto_0
.end method

.method public hasControlId()Z
    .locals 2

    .prologue
    .line 3065
    iget v0, p0, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$CommandToUi$Builder;->bitField0_:I

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

.method public hasDefaultCheckStatus()Z
    .locals 2

    .prologue
    .line 3386
    iget v0, p0, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$CommandToUi$Builder;->bitField0_:I

    and-int/lit16 v0, v0, 0x80

    const/16 v1, 0x80

    if-ne v0, v1, :cond_0

    const/4 v0, 0x1

    :goto_0
    return v0

    :cond_0
    const/4 v0, 0x0

    goto :goto_0
.end method

.method public hasDefaultItemIndex()Z
    .locals 2

    .prologue
    .line 3545
    iget v0, p0, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$CommandToUi$Builder;->bitField0_:I

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

.method public hasEditInputType()Z
    .locals 2

    .prologue
    const/high16 v1, 0x80000

    .line 4114
    iget v0, p0, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$CommandToUi$Builder;->bitField0_:I

    and-int/2addr v0, v1

    if-ne v0, v1, :cond_0

    const/4 v0, 0x1

    :goto_0
    return v0

    :cond_0
    const/4 v0, 0x0

    goto :goto_0
.end method

.method public hasEnabledStatus()Z
    .locals 2

    .prologue
    .line 3726
    iget v0, p0, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$CommandToUi$Builder;->bitField0_:I

    and-int/lit16 v0, v0, 0x2000

    const/16 v1, 0x2000

    if-ne v0, v1, :cond_0

    const/4 v0, 0x1

    :goto_0
    return v0

    :cond_0
    const/4 v0, 0x0

    goto :goto_0
.end method

.method public hasFontSize()Z
    .locals 2

    .prologue
    const/high16 v1, 0x200000

    .line 4221
    iget v0, p0, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$CommandToUi$Builder;->bitField0_:I

    and-int/2addr v0, v1

    if-ne v0, v1, :cond_0

    const/4 v0, 0x1

    :goto_0
    return v0

    :cond_0
    const/4 v0, 0x0

    goto :goto_0
.end method

.method public hasFontType()Z
    .locals 2

    .prologue
    const/high16 v1, 0x100000

    .line 4147
    iget v0, p0, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$CommandToUi$Builder;->bitField0_:I

    and-int/2addr v0, v1

    if-ne v0, v1, :cond_0

    const/4 v0, 0x1

    :goto_0
    return v0

    :cond_0
    const/4 v0, 0x0

    goto :goto_0
.end method

.method public hasHeight()Z
    .locals 2

    .prologue
    .line 3320
    iget v0, p0, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$CommandToUi$Builder;->bitField0_:I

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

.method public hasItemIndex()Z
    .locals 2

    .prologue
    .line 3512
    iget v0, p0, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$CommandToUi$Builder;->bitField0_:I

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

.method public hasLayoutStyle()Z
    .locals 2

    .prologue
    .line 3353
    iget v0, p0, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$CommandToUi$Builder;->bitField0_:I

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

.method public hasPadding()Z
    .locals 2

    .prologue
    const/high16 v1, 0x20000

    .line 3901
    iget v0, p0, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$CommandToUi$Builder;->bitField0_:I

    and-int/2addr v0, v1

    if-ne v0, v1, :cond_0

    const/4 v0, 0x1

    :goto_0
    return v0

    :cond_0
    const/4 v0, 0x0

    goto :goto_0
.end method

.method public hasParentId()Z
    .locals 2

    .prologue
    .line 3139
    iget v0, p0, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$CommandToUi$Builder;->bitField0_:I

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

.method public hasPath()Z
    .locals 2

    .prologue
    .line 3578
    iget v0, p0, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$CommandToUi$Builder;->bitField0_:I

    and-int/lit16 v0, v0, 0x800

    const/16 v1, 0x800

    if-ne v0, v1, :cond_0

    const/4 v0, 0x1

    :goto_0
    return v0

    :cond_0
    const/4 v0, 0x0

    goto :goto_0
.end method

.method public hasText()Z
    .locals 2

    .prologue
    .line 3213
    iget v0, p0, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$CommandToUi$Builder;->bitField0_:I

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

.method public hasUipData()Z
    .locals 2

    .prologue
    const/high16 v1, 0x40000

    .line 4020
    iget v0, p0, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$CommandToUi$Builder;->bitField0_:I

    and-int/2addr v0, v1

    if-ne v0, v1, :cond_0

    const/4 v0, 0x1

    :goto_0
    return v0

    :cond_0
    const/4 v0, 0x0

    goto :goto_0
.end method

.method public hasUrl()Z
    .locals 2

    .prologue
    .line 3652
    iget v0, p0, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$CommandToUi$Builder;->bitField0_:I

    and-int/lit16 v0, v0, 0x1000

    const/16 v1, 0x1000

    if-ne v0, v1, :cond_0

    const/4 v0, 0x1

    :goto_0
    return v0

    :cond_0
    const/4 v0, 0x0

    goto :goto_0
.end method

.method public hasVisibleStatus()Z
    .locals 2

    .prologue
    .line 3759
    iget v0, p0, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$CommandToUi$Builder;->bitField0_:I

    and-int/lit16 v0, v0, 0x4000

    const/16 v1, 0x4000

    if-ne v0, v1, :cond_0

    const/4 v0, 0x1

    :goto_0
    return v0

    :cond_0
    const/4 v0, 0x0

    goto :goto_0
.end method

.method public hasWidth()Z
    .locals 2

    .prologue
    .line 3287
    iget v0, p0, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$CommandToUi$Builder;->bitField0_:I

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

.method protected internalGetFieldAccessorTable()Lcom/google/protobuf/GeneratedMessage$FieldAccessorTable;
    .locals 3

    .prologue
    .line 2685
    invoke-static {}, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage;->e()Lcom/google/protobuf/GeneratedMessage$FieldAccessorTable;

    move-result-object v0

    const-class v1, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$CommandToUi;

    const-class v2, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$CommandToUi$Builder;

    .line 2686
    invoke-virtual {v0, v1, v2}, Lcom/google/protobuf/GeneratedMessage$FieldAccessorTable;->ensureFieldAccessorsInitialized(Ljava/lang/Class;Ljava/lang/Class;)Lcom/google/protobuf/GeneratedMessage$FieldAccessorTable;

    move-result-object v0

    .line 2685
    return-object v0
.end method

.method public final isInitialized()Z
    .locals 2

    .prologue
    const/4 v0, 0x0

    .line 2991
    invoke-virtual {p0}, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$CommandToUi$Builder;->hasCommand()Z

    move-result v1

    if-nez v1, :cond_1

    .line 3001
    :cond_0
    :goto_0
    return v0

    .line 2995
    :cond_1
    invoke-virtual {p0}, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$CommandToUi$Builder;->hasPadding()Z

    move-result v1

    if-eqz v1, :cond_2

    .line 2996
    invoke-virtual {p0}, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$CommandToUi$Builder;->getPadding()Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$Padding_Var;

    move-result-object v1

    invoke-virtual {v1}, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$Padding_Var;->isInitialized()Z

    move-result v1

    if-eqz v1, :cond_0

    .line 3001
    :cond_2
    const/4 v0, 0x1

    goto :goto_0
.end method

.method public mergeFrom(Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$CommandToUi;)Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$CommandToUi$Builder;
    .locals 2

    .prologue
    .line 2896
    invoke-static {}, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$CommandToUi;->getDefaultInstance()Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$CommandToUi;

    move-result-object v0

    if-ne p1, v0, :cond_0

    .line 2987
    :goto_0
    return-object p0

    .line 2897
    :cond_0
    invoke-virtual {p1}, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$CommandToUi;->hasCommand()Z

    move-result v0

    if-eqz v0, :cond_1

    .line 2898
    invoke-virtual {p1}, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$CommandToUi;->getCommand()Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$CommandToUi$Command_Type;

    move-result-object v0

    invoke-virtual {p0, v0}, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$CommandToUi$Builder;->setCommand(Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$CommandToUi$Command_Type;)Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$CommandToUi$Builder;

    .line 2900
    :cond_1
    invoke-virtual {p1}, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$CommandToUi;->hasControlId()Z

    move-result v0

    if-eqz v0, :cond_2

    .line 2901
    iget v0, p0, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$CommandToUi$Builder;->bitField0_:I

    or-int/lit8 v0, v0, 0x2

    iput v0, p0, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$CommandToUi$Builder;->bitField0_:I

    .line 2902
    invoke-static {p1}, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$CommandToUi;->access$2000(Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$CommandToUi;)Ljava/lang/Object;

    move-result-object v0

    iput-object v0, p0, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$CommandToUi$Builder;->controlId_:Ljava/lang/Object;

    .line 2903
    invoke-virtual {p0}, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$CommandToUi$Builder;->onChanged()V

    .line 2905
    :cond_2
    invoke-virtual {p1}, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$CommandToUi;->hasParentId()Z

    move-result v0

    if-eqz v0, :cond_3

    .line 2906
    iget v0, p0, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$CommandToUi$Builder;->bitField0_:I

    or-int/lit8 v0, v0, 0x4

    iput v0, p0, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$CommandToUi$Builder;->bitField0_:I

    .line 2907
    invoke-static {p1}, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$CommandToUi;->access$2100(Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$CommandToUi;)Ljava/lang/Object;

    move-result-object v0

    iput-object v0, p0, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$CommandToUi$Builder;->parentId_:Ljava/lang/Object;

    .line 2908
    invoke-virtual {p0}, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$CommandToUi$Builder;->onChanged()V

    .line 2910
    :cond_3
    invoke-virtual {p1}, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$CommandToUi;->hasText()Z

    move-result v0

    if-eqz v0, :cond_4

    .line 2911
    iget v0, p0, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$CommandToUi$Builder;->bitField0_:I

    or-int/lit8 v0, v0, 0x8

    iput v0, p0, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$CommandToUi$Builder;->bitField0_:I

    .line 2912
    invoke-static {p1}, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$CommandToUi;->access$2200(Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$CommandToUi;)Ljava/lang/Object;

    move-result-object v0

    iput-object v0, p0, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$CommandToUi$Builder;->text_:Ljava/lang/Object;

    .line 2913
    invoke-virtual {p0}, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$CommandToUi$Builder;->onChanged()V

    .line 2915
    :cond_4
    invoke-virtual {p1}, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$CommandToUi;->hasWidth()Z

    move-result v0

    if-eqz v0, :cond_5

    .line 2916
    invoke-virtual {p1}, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$CommandToUi;->getWidth()I

    move-result v0

    invoke-virtual {p0, v0}, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$CommandToUi$Builder;->setWidth(I)Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$CommandToUi$Builder;

    .line 2918
    :cond_5
    invoke-virtual {p1}, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$CommandToUi;->hasHeight()Z

    move-result v0

    if-eqz v0, :cond_6

    .line 2919
    invoke-virtual {p1}, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$CommandToUi;->getHeight()I

    move-result v0

    invoke-virtual {p0, v0}, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$CommandToUi$Builder;->setHeight(I)Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$CommandToUi$Builder;

    .line 2921
    :cond_6
    invoke-virtual {p1}, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$CommandToUi;->hasLayoutStyle()Z

    move-result v0

    if-eqz v0, :cond_7

    .line 2922
    invoke-virtual {p1}, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$CommandToUi;->getLayoutStyle()I

    move-result v0

    invoke-virtual {p0, v0}, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$CommandToUi$Builder;->setLayoutStyle(I)Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$CommandToUi$Builder;

    .line 2924
    :cond_7
    invoke-virtual {p1}, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$CommandToUi;->hasDefaultCheckStatus()Z

    move-result v0

    if-eqz v0, :cond_8

    .line 2925
    invoke-virtual {p1}, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$CommandToUi;->getDefaultCheckStatus()Z

    move-result v0

    invoke-virtual {p0, v0}, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$CommandToUi$Builder;->setDefaultCheckStatus(Z)Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$CommandToUi$Builder;

    .line 2927
    :cond_8
    invoke-static {p1}, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$CommandToUi;->access$2700(Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$CommandToUi;)Lcom/google/protobuf/LazyStringList;

    move-result-object v0

    invoke-interface {v0}, Lcom/google/protobuf/LazyStringList;->isEmpty()Z

    move-result v0

    if-nez v0, :cond_9

    .line 2928
    iget-object v0, p0, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$CommandToUi$Builder;->itemText_:Lcom/google/protobuf/LazyStringList;

    invoke-interface {v0}, Lcom/google/protobuf/LazyStringList;->isEmpty()Z

    move-result v0

    if-eqz v0, :cond_17

    .line 2929
    invoke-static {p1}, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$CommandToUi;->access$2700(Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$CommandToUi;)Lcom/google/protobuf/LazyStringList;

    move-result-object v0

    iput-object v0, p0, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$CommandToUi$Builder;->itemText_:Lcom/google/protobuf/LazyStringList;

    .line 2930
    iget v0, p0, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$CommandToUi$Builder;->bitField0_:I

    and-int/lit16 v0, v0, -0x101

    iput v0, p0, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$CommandToUi$Builder;->bitField0_:I

    .line 2935
    :goto_1
    invoke-virtual {p0}, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$CommandToUi$Builder;->onChanged()V

    .line 2937
    :cond_9
    invoke-virtual {p1}, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$CommandToUi;->hasItemIndex()Z

    move-result v0

    if-eqz v0, :cond_a

    .line 2938
    invoke-virtual {p1}, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$CommandToUi;->getItemIndex()I

    move-result v0

    invoke-virtual {p0, v0}, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$CommandToUi$Builder;->setItemIndex(I)Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$CommandToUi$Builder;

    .line 2940
    :cond_a
    invoke-virtual {p1}, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$CommandToUi;->hasDefaultItemIndex()Z

    move-result v0

    if-eqz v0, :cond_b

    .line 2941
    invoke-virtual {p1}, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$CommandToUi;->getDefaultItemIndex()I

    move-result v0

    invoke-virtual {p0, v0}, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$CommandToUi$Builder;->setDefaultItemIndex(I)Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$CommandToUi$Builder;

    .line 2943
    :cond_b
    invoke-virtual {p1}, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$CommandToUi;->hasPath()Z

    move-result v0

    if-eqz v0, :cond_c

    .line 2944
    iget v0, p0, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$CommandToUi$Builder;->bitField0_:I

    or-int/lit16 v0, v0, 0x800

    iput v0, p0, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$CommandToUi$Builder;->bitField0_:I

    .line 2945
    invoke-static {p1}, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$CommandToUi;->access$3000(Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$CommandToUi;)Ljava/lang/Object;

    move-result-object v0

    iput-object v0, p0, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$CommandToUi$Builder;->path_:Ljava/lang/Object;

    .line 2946
    invoke-virtual {p0}, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$CommandToUi$Builder;->onChanged()V

    .line 2948
    :cond_c
    invoke-virtual {p1}, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$CommandToUi;->hasUrl()Z

    move-result v0

    if-eqz v0, :cond_d

    .line 2949
    iget v0, p0, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$CommandToUi$Builder;->bitField0_:I

    or-int/lit16 v0, v0, 0x1000

    iput v0, p0, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$CommandToUi$Builder;->bitField0_:I

    .line 2950
    invoke-static {p1}, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$CommandToUi;->access$3100(Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$CommandToUi;)Ljava/lang/Object;

    move-result-object v0

    iput-object v0, p0, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$CommandToUi$Builder;->url_:Ljava/lang/Object;

    .line 2951
    invoke-virtual {p0}, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$CommandToUi$Builder;->onChanged()V

    .line 2953
    :cond_d
    invoke-virtual {p1}, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$CommandToUi;->hasEnabledStatus()Z

    move-result v0

    if-eqz v0, :cond_e

    .line 2954
    invoke-virtual {p1}, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$CommandToUi;->getEnabledStatus()Z

    move-result v0

    invoke-virtual {p0, v0}, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$CommandToUi$Builder;->setEnabledStatus(Z)Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$CommandToUi$Builder;

    .line 2956
    :cond_e
    invoke-virtual {p1}, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$CommandToUi;->hasVisibleStatus()Z

    move-result v0

    if-eqz v0, :cond_f

    .line 2957
    invoke-virtual {p1}, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$CommandToUi;->getVisibleStatus()I

    move-result v0

    invoke-virtual {p0, v0}, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$CommandToUi$Builder;->setVisibleStatus(I)Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$CommandToUi$Builder;

    .line 2959
    :cond_f
    invoke-virtual {p1}, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$CommandToUi;->hasColor()Z

    move-result v0

    if-eqz v0, :cond_10

    .line 2960
    iget v0, p0, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$CommandToUi$Builder;->bitField0_:I

    const v1, 0x8000

    or-int/2addr v0, v1

    iput v0, p0, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$CommandToUi$Builder;->bitField0_:I

    .line 2961
    invoke-static {p1}, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$CommandToUi;->access$3400(Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$CommandToUi;)Ljava/lang/Object;

    move-result-object v0

    iput-object v0, p0, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$CommandToUi$Builder;->color_:Ljava/lang/Object;

    .line 2962
    invoke-virtual {p0}, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$CommandToUi$Builder;->onChanged()V

    .line 2964
    :cond_10
    invoke-virtual {p1}, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$CommandToUi;->hasAlignType()Z

    move-result v0

    if-eqz v0, :cond_11

    .line 2965
    invoke-virtual {p1}, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$CommandToUi;->getAlignType()I

    move-result v0

    invoke-virtual {p0, v0}, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$CommandToUi$Builder;->setAlignType(I)Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$CommandToUi$Builder;

    .line 2967
    :cond_11
    invoke-virtual {p1}, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$CommandToUi;->hasPadding()Z

    move-result v0

    if-eqz v0, :cond_12

    .line 2968
    invoke-virtual {p1}, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$CommandToUi;->getPadding()Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$Padding_Var;

    move-result-object v0

    invoke-virtual {p0, v0}, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$CommandToUi$Builder;->mergePadding(Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$Padding_Var;)Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$CommandToUi$Builder;

    .line 2970
    :cond_12
    invoke-virtual {p1}, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$CommandToUi;->hasUipData()Z

    move-result v0

    if-eqz v0, :cond_13

    .line 2971
    iget v0, p0, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$CommandToUi$Builder;->bitField0_:I

    const/high16 v1, 0x40000

    or-int/2addr v0, v1

    iput v0, p0, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$CommandToUi$Builder;->bitField0_:I

    .line 2972
    invoke-static {p1}, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$CommandToUi;->access$3700(Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$CommandToUi;)Ljava/lang/Object;

    move-result-object v0

    iput-object v0, p0, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$CommandToUi$Builder;->uipData_:Ljava/lang/Object;

    .line 2973
    invoke-virtual {p0}, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$CommandToUi$Builder;->onChanged()V

    .line 2975
    :cond_13
    invoke-virtual {p1}, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$CommandToUi;->hasEditInputType()Z

    move-result v0

    if-eqz v0, :cond_14

    .line 2976
    invoke-virtual {p1}, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$CommandToUi;->getEditInputType()I

    move-result v0

    invoke-virtual {p0, v0}, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$CommandToUi$Builder;->setEditInputType(I)Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$CommandToUi$Builder;

    .line 2978
    :cond_14
    invoke-virtual {p1}, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$CommandToUi;->hasFontType()Z

    move-result v0

    if-eqz v0, :cond_15

    .line 2979
    iget v0, p0, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$CommandToUi$Builder;->bitField0_:I

    const/high16 v1, 0x100000

    or-int/2addr v0, v1

    iput v0, p0, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$CommandToUi$Builder;->bitField0_:I

    .line 2980
    invoke-static {p1}, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$CommandToUi;->access$3900(Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$CommandToUi;)Ljava/lang/Object;

    move-result-object v0

    iput-object v0, p0, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$CommandToUi$Builder;->fontType_:Ljava/lang/Object;

    .line 2981
    invoke-virtual {p0}, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$CommandToUi$Builder;->onChanged()V

    .line 2983
    :cond_15
    invoke-virtual {p1}, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$CommandToUi;->hasFontSize()Z

    move-result v0

    if-eqz v0, :cond_16

    .line 2984
    invoke-virtual {p1}, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$CommandToUi;->getFontSize()I

    move-result v0

    invoke-virtual {p0, v0}, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$CommandToUi$Builder;->setFontSize(I)Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$CommandToUi$Builder;

    .line 2986
    :cond_16
    invoke-virtual {p1}, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$CommandToUi;->getUnknownFields()Lcom/google/protobuf/UnknownFieldSet;

    move-result-object v0

    invoke-virtual {p0, v0}, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$CommandToUi$Builder;->mergeUnknownFields(Lcom/google/protobuf/UnknownFieldSet;)Lcom/google/protobuf/GeneratedMessage$Builder;

    goto/16 :goto_0

    .line 2932
    :cond_17
    invoke-direct {p0}, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$CommandToUi$Builder;->ensureItemTextIsMutable()V

    .line 2933
    iget-object v0, p0, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$CommandToUi$Builder;->itemText_:Lcom/google/protobuf/LazyStringList;

    invoke-static {p1}, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$CommandToUi;->access$2700(Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$CommandToUi;)Lcom/google/protobuf/LazyStringList;

    move-result-object v1

    invoke-interface {v0, v1}, Lcom/google/protobuf/LazyStringList;->addAll(Ljava/util/Collection;)Z

    goto/16 :goto_1
.end method

.method public mergeFrom(Lcom/google/protobuf/CodedInputStream;Lcom/google/protobuf/ExtensionRegistryLite;)Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$CommandToUi$Builder;
    .locals 4
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljava/io/IOException;
        }
    .end annotation

    .prologue
    .line 3008
    const/4 v2, 0x0

    .line 3010
    :try_start_0
    sget-object v0, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$CommandToUi;->PARSER:Lcom/google/protobuf/Parser;

    invoke-interface {v0, p1, p2}, Lcom/google/protobuf/Parser;->parsePartialFrom(Lcom/google/protobuf/CodedInputStream;Lcom/google/protobuf/ExtensionRegistryLite;)Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$CommandToUi;
    :try_end_0
    .catch Lcom/google/protobuf/InvalidProtocolBufferException; {:try_start_0 .. :try_end_0} :catch_0
    .catchall {:try_start_0 .. :try_end_0} :catchall_1

    .line 3015
    if-eqz v0, :cond_0

    .line 3016
    invoke-virtual {p0, v0}, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$CommandToUi$Builder;->mergeFrom(Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$CommandToUi;)Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$CommandToUi$Builder;

    .line 3019
    :cond_0
    return-object p0

    .line 3011
    :catch_0
    move-exception v0

    move-object v1, v0

    .line 3012
    :try_start_1
    invoke-virtual {v1}, Lcom/google/protobuf/InvalidProtocolBufferException;->getUnfinishedMessage()Lcom/google/protobuf/MessageLite;

    move-result-object v0

    check-cast v0, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$CommandToUi;
    :try_end_1
    .catchall {:try_start_1 .. :try_end_1} :catchall_1

    .line 3013
    :try_start_2
    throw v1
    :try_end_2
    .catchall {:try_start_2 .. :try_end_2} :catchall_0

    .line 3015
    :catchall_0
    move-exception v1

    move-object v3, v1

    move-object v1, v0

    move-object v0, v3

    :goto_0
    if-eqz v1, :cond_1

    .line 3016
    invoke-virtual {p0, v1}, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$CommandToUi$Builder;->mergeFrom(Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$CommandToUi;)Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$CommandToUi$Builder;

    :cond_1
    throw v0

    .line 3015
    :catchall_1
    move-exception v0

    move-object v1, v2

    goto :goto_0
.end method

.method public mergeFrom(Lcom/google/protobuf/Message;)Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$CommandToUi$Builder;
    .locals 1

    .prologue
    .line 2887
    instance-of v0, p1, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$CommandToUi;

    if-eqz v0, :cond_0

    .line 2888
    check-cast p1, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$CommandToUi;

    invoke-virtual {p0, p1}, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$CommandToUi$Builder;->mergeFrom(Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$CommandToUi;)Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$CommandToUi$Builder;

    move-result-object p0

    .line 2891
    :goto_0
    return-object p0

    .line 2890
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
    .line 2675
    invoke-virtual {p0, p1, p2}, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$CommandToUi$Builder;->mergeFrom(Lcom/google/protobuf/CodedInputStream;Lcom/google/protobuf/ExtensionRegistryLite;)Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$CommandToUi$Builder;

    move-result-object v0

    return-object v0
.end method

.method public bridge synthetic mergeFrom(Lcom/google/protobuf/Message;)Lcom/google/protobuf/AbstractMessage$Builder;
    .locals 1

    .prologue
    .line 2675
    invoke-virtual {p0, p1}, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$CommandToUi$Builder;->mergeFrom(Lcom/google/protobuf/Message;)Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$CommandToUi$Builder;

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
    .line 2675
    invoke-virtual {p0, p1, p2}, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$CommandToUi$Builder;->mergeFrom(Lcom/google/protobuf/CodedInputStream;Lcom/google/protobuf/ExtensionRegistryLite;)Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$CommandToUi$Builder;

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
    .line 2675
    invoke-virtual {p0, p1, p2}, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$CommandToUi$Builder;->mergeFrom(Lcom/google/protobuf/CodedInputStream;Lcom/google/protobuf/ExtensionRegistryLite;)Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$CommandToUi$Builder;

    move-result-object v0

    return-object v0
.end method

.method public bridge synthetic mergeFrom(Lcom/google/protobuf/Message;)Lcom/google/protobuf/Message$Builder;
    .locals 1

    .prologue
    .line 2675
    invoke-virtual {p0, p1}, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$CommandToUi$Builder;->mergeFrom(Lcom/google/protobuf/Message;)Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$CommandToUi$Builder;

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
    .line 2675
    invoke-virtual {p0, p1, p2}, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$CommandToUi$Builder;->mergeFrom(Lcom/google/protobuf/CodedInputStream;Lcom/google/protobuf/ExtensionRegistryLite;)Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$CommandToUi$Builder;

    move-result-object v0

    return-object v0
.end method

.method public mergePadding(Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$Padding_Var;)Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$CommandToUi$Builder;
    .locals 3

    .prologue
    const/high16 v2, 0x20000

    .line 3947
    iget-object v0, p0, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$CommandToUi$Builder;->paddingBuilder_:Lcom/google/protobuf/SingleFieldBuilder;

    if-nez v0, :cond_1

    .line 3948
    iget v0, p0, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$CommandToUi$Builder;->bitField0_:I

    and-int/2addr v0, v2

    if-ne v0, v2, :cond_0

    iget-object v0, p0, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$CommandToUi$Builder;->padding_:Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$Padding_Var;

    .line 3949
    invoke-static {}, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$Padding_Var;->getDefaultInstance()Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$Padding_Var;

    move-result-object v1

    if-eq v0, v1, :cond_0

    .line 3950
    iget-object v0, p0, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$CommandToUi$Builder;->padding_:Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$Padding_Var;

    .line 3951
    invoke-static {v0}, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$Padding_Var;->newBuilder(Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$Padding_Var;)Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$Padding_Var$Builder;

    move-result-object v0

    invoke-virtual {v0, p1}, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$Padding_Var$Builder;->mergeFrom(Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$Padding_Var;)Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$Padding_Var$Builder;

    move-result-object v0

    invoke-virtual {v0}, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$Padding_Var$Builder;->buildPartial()Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$Padding_Var;

    move-result-object v0

    iput-object v0, p0, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$CommandToUi$Builder;->padding_:Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$Padding_Var;

    .line 3955
    :goto_0
    invoke-virtual {p0}, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$CommandToUi$Builder;->onChanged()V

    .line 3959
    :goto_1
    iget v0, p0, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$CommandToUi$Builder;->bitField0_:I

    or-int/2addr v0, v2

    iput v0, p0, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$CommandToUi$Builder;->bitField0_:I

    .line 3960
    return-object p0

    .line 3953
    :cond_0
    iput-object p1, p0, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$CommandToUi$Builder;->padding_:Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$Padding_Var;

    goto :goto_0

    .line 3957
    :cond_1
    iget-object v0, p0, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$CommandToUi$Builder;->paddingBuilder_:Lcom/google/protobuf/SingleFieldBuilder;

    invoke-virtual {v0, p1}, Lcom/google/protobuf/SingleFieldBuilder;->mergeFrom(Lcom/google/protobuf/GeneratedMessage;)Lcom/google/protobuf/SingleFieldBuilder;

    goto :goto_1
.end method

.method public setAlignType(I)Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$CommandToUi$Builder;
    .locals 2

    .prologue
    .line 3878
    iget v0, p0, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$CommandToUi$Builder;->bitField0_:I

    const/high16 v1, 0x10000

    or-int/2addr v0, v1

    iput v0, p0, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$CommandToUi$Builder;->bitField0_:I

    .line 3879
    iput p1, p0, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$CommandToUi$Builder;->alignType_:I

    .line 3880
    invoke-virtual {p0}, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$CommandToUi$Builder;->onChanged()V

    .line 3881
    return-object p0
.end method

.method public setColor(Ljava/lang/String;)Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$CommandToUi$Builder;
    .locals 2

    .prologue
    .line 3829
    if-nez p1, :cond_0

    .line 3830
    new-instance v0, Ljava/lang/NullPointerException;

    invoke-direct {v0}, Ljava/lang/NullPointerException;-><init>()V

    throw v0

    .line 3832
    :cond_0
    iget v0, p0, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$CommandToUi$Builder;->bitField0_:I

    const v1, 0x8000

    or-int/2addr v0, v1

    iput v0, p0, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$CommandToUi$Builder;->bitField0_:I

    .line 3833
    iput-object p1, p0, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$CommandToUi$Builder;->color_:Ljava/lang/Object;

    .line 3834
    invoke-virtual {p0}, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$CommandToUi$Builder;->onChanged()V

    .line 3835
    return-object p0
.end method

.method public setColorBytes(Lcom/google/protobuf/ByteString;)Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$CommandToUi$Builder;
    .locals 2

    .prologue
    .line 3851
    if-nez p1, :cond_0

    .line 3852
    new-instance v0, Ljava/lang/NullPointerException;

    invoke-direct {v0}, Ljava/lang/NullPointerException;-><init>()V

    throw v0

    .line 3854
    :cond_0
    iget v0, p0, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$CommandToUi$Builder;->bitField0_:I

    const v1, 0x8000

    or-int/2addr v0, v1

    iput v0, p0, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$CommandToUi$Builder;->bitField0_:I

    .line 3855
    iput-object p1, p0, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$CommandToUi$Builder;->color_:Ljava/lang/Object;

    .line 3856
    invoke-virtual {p0}, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$CommandToUi$Builder;->onChanged()V

    .line 3857
    return-object p0
.end method

.method public setCommand(Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$CommandToUi$Command_Type;)Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$CommandToUi$Builder;
    .locals 1

    .prologue
    .line 3041
    if-nez p1, :cond_0

    .line 3042
    new-instance v0, Ljava/lang/NullPointerException;

    invoke-direct {v0}, Ljava/lang/NullPointerException;-><init>()V

    throw v0

    .line 3044
    :cond_0
    iget v0, p0, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$CommandToUi$Builder;->bitField0_:I

    or-int/lit8 v0, v0, 0x1

    iput v0, p0, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$CommandToUi$Builder;->bitField0_:I

    .line 3045
    iput-object p1, p0, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$CommandToUi$Builder;->command_:Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$CommandToUi$Command_Type;

    .line 3046
    invoke-virtual {p0}, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$CommandToUi$Builder;->onChanged()V

    .line 3047
    return-object p0
.end method

.method public setControlId(Ljava/lang/String;)Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$CommandToUi$Builder;
    .locals 1

    .prologue
    .line 3102
    if-nez p1, :cond_0

    .line 3103
    new-instance v0, Ljava/lang/NullPointerException;

    invoke-direct {v0}, Ljava/lang/NullPointerException;-><init>()V

    throw v0

    .line 3105
    :cond_0
    iget v0, p0, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$CommandToUi$Builder;->bitField0_:I

    or-int/lit8 v0, v0, 0x2

    iput v0, p0, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$CommandToUi$Builder;->bitField0_:I

    .line 3106
    iput-object p1, p0, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$CommandToUi$Builder;->controlId_:Ljava/lang/Object;

    .line 3107
    invoke-virtual {p0}, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$CommandToUi$Builder;->onChanged()V

    .line 3108
    return-object p0
.end method

.method public setControlIdBytes(Lcom/google/protobuf/ByteString;)Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$CommandToUi$Builder;
    .locals 1

    .prologue
    .line 3124
    if-nez p1, :cond_0

    .line 3125
    new-instance v0, Ljava/lang/NullPointerException;

    invoke-direct {v0}, Ljava/lang/NullPointerException;-><init>()V

    throw v0

    .line 3127
    :cond_0
    iget v0, p0, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$CommandToUi$Builder;->bitField0_:I

    or-int/lit8 v0, v0, 0x2

    iput v0, p0, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$CommandToUi$Builder;->bitField0_:I

    .line 3128
    iput-object p1, p0, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$CommandToUi$Builder;->controlId_:Ljava/lang/Object;

    .line 3129
    invoke-virtual {p0}, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$CommandToUi$Builder;->onChanged()V

    .line 3130
    return-object p0
.end method

.method public setDefaultCheckStatus(Z)Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$CommandToUi$Builder;
    .locals 1

    .prologue
    .line 3398
    iget v0, p0, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$CommandToUi$Builder;->bitField0_:I

    or-int/lit16 v0, v0, 0x80

    iput v0, p0, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$CommandToUi$Builder;->bitField0_:I

    .line 3399
    iput-boolean p1, p0, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$CommandToUi$Builder;->defaultCheckStatus_:Z

    .line 3400
    invoke-virtual {p0}, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$CommandToUi$Builder;->onChanged()V

    .line 3401
    return-object p0
.end method

.method public setDefaultItemIndex(I)Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$CommandToUi$Builder;
    .locals 1

    .prologue
    .line 3557
    iget v0, p0, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$CommandToUi$Builder;->bitField0_:I

    or-int/lit16 v0, v0, 0x400

    iput v0, p0, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$CommandToUi$Builder;->bitField0_:I

    .line 3558
    iput p1, p0, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$CommandToUi$Builder;->defaultItemIndex_:I

    .line 3559
    invoke-virtual {p0}, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$CommandToUi$Builder;->onChanged()V

    .line 3560
    return-object p0
.end method

.method public setEditInputType(I)Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$CommandToUi$Builder;
    .locals 2

    .prologue
    .line 4126
    iget v0, p0, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$CommandToUi$Builder;->bitField0_:I

    const/high16 v1, 0x80000

    or-int/2addr v0, v1

    iput v0, p0, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$CommandToUi$Builder;->bitField0_:I

    .line 4127
    iput p1, p0, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$CommandToUi$Builder;->editInputType_:I

    .line 4128
    invoke-virtual {p0}, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$CommandToUi$Builder;->onChanged()V

    .line 4129
    return-object p0
.end method

.method public setEnabledStatus(Z)Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$CommandToUi$Builder;
    .locals 1

    .prologue
    .line 3738
    iget v0, p0, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$CommandToUi$Builder;->bitField0_:I

    or-int/lit16 v0, v0, 0x2000

    iput v0, p0, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$CommandToUi$Builder;->bitField0_:I

    .line 3739
    iput-boolean p1, p0, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$CommandToUi$Builder;->enabledStatus_:Z

    .line 3740
    invoke-virtual {p0}, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$CommandToUi$Builder;->onChanged()V

    .line 3741
    return-object p0
.end method

.method public setFontSize(I)Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$CommandToUi$Builder;
    .locals 2

    .prologue
    .line 4233
    iget v0, p0, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$CommandToUi$Builder;->bitField0_:I

    const/high16 v1, 0x200000

    or-int/2addr v0, v1

    iput v0, p0, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$CommandToUi$Builder;->bitField0_:I

    .line 4234
    iput p1, p0, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$CommandToUi$Builder;->fontSize_:I

    .line 4235
    invoke-virtual {p0}, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$CommandToUi$Builder;->onChanged()V

    .line 4236
    return-object p0
.end method

.method public setFontType(Ljava/lang/String;)Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$CommandToUi$Builder;
    .locals 2

    .prologue
    .line 4184
    if-nez p1, :cond_0

    .line 4185
    new-instance v0, Ljava/lang/NullPointerException;

    invoke-direct {v0}, Ljava/lang/NullPointerException;-><init>()V

    throw v0

    .line 4187
    :cond_0
    iget v0, p0, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$CommandToUi$Builder;->bitField0_:I

    const/high16 v1, 0x100000

    or-int/2addr v0, v1

    iput v0, p0, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$CommandToUi$Builder;->bitField0_:I

    .line 4188
    iput-object p1, p0, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$CommandToUi$Builder;->fontType_:Ljava/lang/Object;

    .line 4189
    invoke-virtual {p0}, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$CommandToUi$Builder;->onChanged()V

    .line 4190
    return-object p0
.end method

.method public setFontTypeBytes(Lcom/google/protobuf/ByteString;)Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$CommandToUi$Builder;
    .locals 2

    .prologue
    .line 4206
    if-nez p1, :cond_0

    .line 4207
    new-instance v0, Ljava/lang/NullPointerException;

    invoke-direct {v0}, Ljava/lang/NullPointerException;-><init>()V

    throw v0

    .line 4209
    :cond_0
    iget v0, p0, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$CommandToUi$Builder;->bitField0_:I

    const/high16 v1, 0x100000

    or-int/2addr v0, v1

    iput v0, p0, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$CommandToUi$Builder;->bitField0_:I

    .line 4210
    iput-object p1, p0, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$CommandToUi$Builder;->fontType_:Ljava/lang/Object;

    .line 4211
    invoke-virtual {p0}, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$CommandToUi$Builder;->onChanged()V

    .line 4212
    return-object p0
.end method

.method public setHeight(I)Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$CommandToUi$Builder;
    .locals 1

    .prologue
    .line 3332
    iget v0, p0, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$CommandToUi$Builder;->bitField0_:I

    or-int/lit8 v0, v0, 0x20

    iput v0, p0, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$CommandToUi$Builder;->bitField0_:I

    .line 3333
    iput p1, p0, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$CommandToUi$Builder;->height_:I

    .line 3334
    invoke-virtual {p0}, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$CommandToUi$Builder;->onChanged()V

    .line 3335
    return-object p0
.end method

.method public setItemIndex(I)Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$CommandToUi$Builder;
    .locals 1

    .prologue
    .line 3524
    iget v0, p0, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$CommandToUi$Builder;->bitField0_:I

    or-int/lit16 v0, v0, 0x200

    iput v0, p0, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$CommandToUi$Builder;->bitField0_:I

    .line 3525
    iput p1, p0, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$CommandToUi$Builder;->itemIndex_:I

    .line 3526
    invoke-virtual {p0}, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$CommandToUi$Builder;->onChanged()V

    .line 3527
    return-object p0
.end method

.method public setItemText(ILjava/lang/String;)Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$CommandToUi$Builder;
    .locals 1

    .prologue
    .line 3452
    if-nez p2, :cond_0

    .line 3453
    new-instance v0, Ljava/lang/NullPointerException;

    invoke-direct {v0}, Ljava/lang/NullPointerException;-><init>()V

    throw v0

    .line 3455
    :cond_0
    invoke-direct {p0}, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$CommandToUi$Builder;->ensureItemTextIsMutable()V

    .line 3456
    iget-object v0, p0, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$CommandToUi$Builder;->itemText_:Lcom/google/protobuf/LazyStringList;

    invoke-interface {v0, p1, p2}, Lcom/google/protobuf/LazyStringList;->set(ILjava/lang/Object;)Ljava/lang/Object;

    .line 3457
    invoke-virtual {p0}, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$CommandToUi$Builder;->onChanged()V

    .line 3458
    return-object p0
.end method

.method public setLayoutStyle(I)Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$CommandToUi$Builder;
    .locals 1

    .prologue
    .line 3365
    iget v0, p0, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$CommandToUi$Builder;->bitField0_:I

    or-int/lit8 v0, v0, 0x40

    iput v0, p0, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$CommandToUi$Builder;->bitField0_:I

    .line 3366
    iput p1, p0, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$CommandToUi$Builder;->layoutStyle_:I

    .line 3367
    invoke-virtual {p0}, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$CommandToUi$Builder;->onChanged()V

    .line 3368
    return-object p0
.end method

.method public setPadding(Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$Padding_Var$Builder;)Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$CommandToUi$Builder;
    .locals 2

    .prologue
    .line 3934
    iget-object v0, p0, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$CommandToUi$Builder;->paddingBuilder_:Lcom/google/protobuf/SingleFieldBuilder;

    if-nez v0, :cond_0

    .line 3935
    invoke-virtual {p1}, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$Padding_Var$Builder;->build()Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$Padding_Var;

    move-result-object v0

    iput-object v0, p0, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$CommandToUi$Builder;->padding_:Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$Padding_Var;

    .line 3936
    invoke-virtual {p0}, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$CommandToUi$Builder;->onChanged()V

    .line 3940
    :goto_0
    iget v0, p0, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$CommandToUi$Builder;->bitField0_:I

    const/high16 v1, 0x20000

    or-int/2addr v0, v1

    iput v0, p0, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$CommandToUi$Builder;->bitField0_:I

    .line 3941
    return-object p0

    .line 3938
    :cond_0
    iget-object v0, p0, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$CommandToUi$Builder;->paddingBuilder_:Lcom/google/protobuf/SingleFieldBuilder;

    invoke-virtual {p1}, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$Padding_Var$Builder;->build()Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$Padding_Var;

    move-result-object v1

    invoke-virtual {v0, v1}, Lcom/google/protobuf/SingleFieldBuilder;->setMessage(Lcom/google/protobuf/GeneratedMessage;)Lcom/google/protobuf/SingleFieldBuilder;

    goto :goto_0
.end method

.method public setPadding(Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$Padding_Var;)Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$CommandToUi$Builder;
    .locals 2

    .prologue
    .line 3917
    iget-object v0, p0, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$CommandToUi$Builder;->paddingBuilder_:Lcom/google/protobuf/SingleFieldBuilder;

    if-nez v0, :cond_1

    .line 3918
    if-nez p1, :cond_0

    .line 3919
    new-instance v0, Ljava/lang/NullPointerException;

    invoke-direct {v0}, Ljava/lang/NullPointerException;-><init>()V

    throw v0

    .line 3921
    :cond_0
    iput-object p1, p0, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$CommandToUi$Builder;->padding_:Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$Padding_Var;

    .line 3922
    invoke-virtual {p0}, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$CommandToUi$Builder;->onChanged()V

    .line 3926
    :goto_0
    iget v0, p0, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$CommandToUi$Builder;->bitField0_:I

    const/high16 v1, 0x20000

    or-int/2addr v0, v1

    iput v0, p0, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$CommandToUi$Builder;->bitField0_:I

    .line 3927
    return-object p0

    .line 3924
    :cond_1
    iget-object v0, p0, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$CommandToUi$Builder;->paddingBuilder_:Lcom/google/protobuf/SingleFieldBuilder;

    invoke-virtual {v0, p1}, Lcom/google/protobuf/SingleFieldBuilder;->setMessage(Lcom/google/protobuf/GeneratedMessage;)Lcom/google/protobuf/SingleFieldBuilder;

    goto :goto_0
.end method

.method public setParentId(Ljava/lang/String;)Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$CommandToUi$Builder;
    .locals 1

    .prologue
    .line 3176
    if-nez p1, :cond_0

    .line 3177
    new-instance v0, Ljava/lang/NullPointerException;

    invoke-direct {v0}, Ljava/lang/NullPointerException;-><init>()V

    throw v0

    .line 3179
    :cond_0
    iget v0, p0, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$CommandToUi$Builder;->bitField0_:I

    or-int/lit8 v0, v0, 0x4

    iput v0, p0, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$CommandToUi$Builder;->bitField0_:I

    .line 3180
    iput-object p1, p0, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$CommandToUi$Builder;->parentId_:Ljava/lang/Object;

    .line 3181
    invoke-virtual {p0}, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$CommandToUi$Builder;->onChanged()V

    .line 3182
    return-object p0
.end method

.method public setParentIdBytes(Lcom/google/protobuf/ByteString;)Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$CommandToUi$Builder;
    .locals 1

    .prologue
    .line 3198
    if-nez p1, :cond_0

    .line 3199
    new-instance v0, Ljava/lang/NullPointerException;

    invoke-direct {v0}, Ljava/lang/NullPointerException;-><init>()V

    throw v0

    .line 3201
    :cond_0
    iget v0, p0, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$CommandToUi$Builder;->bitField0_:I

    or-int/lit8 v0, v0, 0x4

    iput v0, p0, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$CommandToUi$Builder;->bitField0_:I

    .line 3202
    iput-object p1, p0, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$CommandToUi$Builder;->parentId_:Ljava/lang/Object;

    .line 3203
    invoke-virtual {p0}, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$CommandToUi$Builder;->onChanged()V

    .line 3204
    return-object p0
.end method

.method public setPath(Ljava/lang/String;)Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$CommandToUi$Builder;
    .locals 1

    .prologue
    .line 3615
    if-nez p1, :cond_0

    .line 3616
    new-instance v0, Ljava/lang/NullPointerException;

    invoke-direct {v0}, Ljava/lang/NullPointerException;-><init>()V

    throw v0

    .line 3618
    :cond_0
    iget v0, p0, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$CommandToUi$Builder;->bitField0_:I

    or-int/lit16 v0, v0, 0x800

    iput v0, p0, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$CommandToUi$Builder;->bitField0_:I

    .line 3619
    iput-object p1, p0, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$CommandToUi$Builder;->path_:Ljava/lang/Object;

    .line 3620
    invoke-virtual {p0}, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$CommandToUi$Builder;->onChanged()V

    .line 3621
    return-object p0
.end method

.method public setPathBytes(Lcom/google/protobuf/ByteString;)Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$CommandToUi$Builder;
    .locals 1

    .prologue
    .line 3637
    if-nez p1, :cond_0

    .line 3638
    new-instance v0, Ljava/lang/NullPointerException;

    invoke-direct {v0}, Ljava/lang/NullPointerException;-><init>()V

    throw v0

    .line 3640
    :cond_0
    iget v0, p0, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$CommandToUi$Builder;->bitField0_:I

    or-int/lit16 v0, v0, 0x800

    iput v0, p0, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$CommandToUi$Builder;->bitField0_:I

    .line 3641
    iput-object p1, p0, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$CommandToUi$Builder;->path_:Ljava/lang/Object;

    .line 3642
    invoke-virtual {p0}, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$CommandToUi$Builder;->onChanged()V

    .line 3643
    return-object p0
.end method

.method public setText(Ljava/lang/String;)Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$CommandToUi$Builder;
    .locals 1

    .prologue
    .line 3250
    if-nez p1, :cond_0

    .line 3251
    new-instance v0, Ljava/lang/NullPointerException;

    invoke-direct {v0}, Ljava/lang/NullPointerException;-><init>()V

    throw v0

    .line 3253
    :cond_0
    iget v0, p0, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$CommandToUi$Builder;->bitField0_:I

    or-int/lit8 v0, v0, 0x8

    iput v0, p0, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$CommandToUi$Builder;->bitField0_:I

    .line 3254
    iput-object p1, p0, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$CommandToUi$Builder;->text_:Ljava/lang/Object;

    .line 3255
    invoke-virtual {p0}, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$CommandToUi$Builder;->onChanged()V

    .line 3256
    return-object p0
.end method

.method public setTextBytes(Lcom/google/protobuf/ByteString;)Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$CommandToUi$Builder;
    .locals 1

    .prologue
    .line 3272
    if-nez p1, :cond_0

    .line 3273
    new-instance v0, Ljava/lang/NullPointerException;

    invoke-direct {v0}, Ljava/lang/NullPointerException;-><init>()V

    throw v0

    .line 3275
    :cond_0
    iget v0, p0, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$CommandToUi$Builder;->bitField0_:I

    or-int/lit8 v0, v0, 0x8

    iput v0, p0, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$CommandToUi$Builder;->bitField0_:I

    .line 3276
    iput-object p1, p0, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$CommandToUi$Builder;->text_:Ljava/lang/Object;

    .line 3277
    invoke-virtual {p0}, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$CommandToUi$Builder;->onChanged()V

    .line 3278
    return-object p0
.end method

.method public setUipData(Ljava/lang/String;)Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$CommandToUi$Builder;
    .locals 2

    .prologue
    .line 4069
    if-nez p1, :cond_0

    .line 4070
    new-instance v0, Ljava/lang/NullPointerException;

    invoke-direct {v0}, Ljava/lang/NullPointerException;-><init>()V

    throw v0

    .line 4072
    :cond_0
    iget v0, p0, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$CommandToUi$Builder;->bitField0_:I

    const/high16 v1, 0x40000

    or-int/2addr v0, v1

    iput v0, p0, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$CommandToUi$Builder;->bitField0_:I

    .line 4073
    iput-object p1, p0, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$CommandToUi$Builder;->uipData_:Ljava/lang/Object;

    .line 4074
    invoke-virtual {p0}, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$CommandToUi$Builder;->onChanged()V

    .line 4075
    return-object p0
.end method

.method public setUipDataBytes(Lcom/google/protobuf/ByteString;)Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$CommandToUi$Builder;
    .locals 2

    .prologue
    .line 4099
    if-nez p1, :cond_0

    .line 4100
    new-instance v0, Ljava/lang/NullPointerException;

    invoke-direct {v0}, Ljava/lang/NullPointerException;-><init>()V

    throw v0

    .line 4102
    :cond_0
    iget v0, p0, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$CommandToUi$Builder;->bitField0_:I

    const/high16 v1, 0x40000

    or-int/2addr v0, v1

    iput v0, p0, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$CommandToUi$Builder;->bitField0_:I

    .line 4103
    iput-object p1, p0, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$CommandToUi$Builder;->uipData_:Ljava/lang/Object;

    .line 4104
    invoke-virtual {p0}, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$CommandToUi$Builder;->onChanged()V

    .line 4105
    return-object p0
.end method

.method public setUrl(Ljava/lang/String;)Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$CommandToUi$Builder;
    .locals 1

    .prologue
    .line 3689
    if-nez p1, :cond_0

    .line 3690
    new-instance v0, Ljava/lang/NullPointerException;

    invoke-direct {v0}, Ljava/lang/NullPointerException;-><init>()V

    throw v0

    .line 3692
    :cond_0
    iget v0, p0, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$CommandToUi$Builder;->bitField0_:I

    or-int/lit16 v0, v0, 0x1000

    iput v0, p0, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$CommandToUi$Builder;->bitField0_:I

    .line 3693
    iput-object p1, p0, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$CommandToUi$Builder;->url_:Ljava/lang/Object;

    .line 3694
    invoke-virtual {p0}, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$CommandToUi$Builder;->onChanged()V

    .line 3695
    return-object p0
.end method

.method public setUrlBytes(Lcom/google/protobuf/ByteString;)Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$CommandToUi$Builder;
    .locals 1

    .prologue
    .line 3711
    if-nez p1, :cond_0

    .line 3712
    new-instance v0, Ljava/lang/NullPointerException;

    invoke-direct {v0}, Ljava/lang/NullPointerException;-><init>()V

    throw v0

    .line 3714
    :cond_0
    iget v0, p0, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$CommandToUi$Builder;->bitField0_:I

    or-int/lit16 v0, v0, 0x1000

    iput v0, p0, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$CommandToUi$Builder;->bitField0_:I

    .line 3715
    iput-object p1, p0, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$CommandToUi$Builder;->url_:Ljava/lang/Object;

    .line 3716
    invoke-virtual {p0}, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$CommandToUi$Builder;->onChanged()V

    .line 3717
    return-object p0
.end method

.method public setVisibleStatus(I)Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$CommandToUi$Builder;
    .locals 1

    .prologue
    .line 3771
    iget v0, p0, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$CommandToUi$Builder;->bitField0_:I

    or-int/lit16 v0, v0, 0x4000

    iput v0, p0, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$CommandToUi$Builder;->bitField0_:I

    .line 3772
    iput p1, p0, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$CommandToUi$Builder;->visibleStatus_:I

    .line 3773
    invoke-virtual {p0}, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$CommandToUi$Builder;->onChanged()V

    .line 3774
    return-object p0
.end method

.method public setWidth(I)Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$CommandToUi$Builder;
    .locals 1

    .prologue
    .line 3299
    iget v0, p0, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$CommandToUi$Builder;->bitField0_:I

    or-int/lit8 v0, v0, 0x10

    iput v0, p0, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$CommandToUi$Builder;->bitField0_:I

    .line 3300
    iput p1, p0, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$CommandToUi$Builder;->width_:I

    .line 3301
    invoke-virtual {p0}, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$CommandToUi$Builder;->onChanged()V

    .line 3302
    return-object p0
.end method
