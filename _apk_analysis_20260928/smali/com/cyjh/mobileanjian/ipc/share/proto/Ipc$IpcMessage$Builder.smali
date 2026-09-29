.class public final Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$IpcMessage$Builder;
.super Lcom/google/protobuf/GeneratedMessage$Builder;
.source "SourceFile"

# interfaces
.implements Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$IpcMessageOrBuilder;


# annotations
.annotation system Ldalvik/annotation/EnclosingClass;
    value = Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$IpcMessage;
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x19
    name = "Builder"
.end annotation

.annotation system Ldalvik/annotation/Signature;
    value = {
        "Lcom/google/protobuf/GeneratedMessage$Builder",
        "<",
        "Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$IpcMessage$Builder;",
        ">;",
        "Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$IpcMessageOrBuilder;"
    }
.end annotation


# instance fields
.field private arg1_:Ljava/util/List;
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "Ljava/util/List",
            "<",
            "Ljava/lang/Integer;",
            ">;"
        }
    .end annotation
.end field

.field private arg2_:Lcom/google/protobuf/LazyStringList;

.field private arg3_:Ljava/util/List;
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "Ljava/util/List",
            "<",
            "Ljava/lang/Float;",
            ">;"
        }
    .end annotation
.end field

.field private arg4_:Ljava/util/List;
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "Ljava/util/List",
            "<",
            "Ljava/lang/Long;",
            ">;"
        }
    .end annotation
.end field

.field private bitField0_:I

.field private className_:Ljava/lang/Object;

.field private cmd_:I

.field private encrypt_:Z

.field private fileData_:Lcom/google/protobuf/ByteString;

.field private isDebug_:Z

.field private isSyncCall_:Z

.field private methodName_:Ljava/lang/Object;

.field private params_:Lcom/google/protobuf/LazyStringList;

.field private pkgName_:Ljava/lang/Object;

.field private retValueBuilder_:Lcom/google/protobuf/SingleFieldBuilder;
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "Lcom/google/protobuf/SingleFieldBuilder",
            "<",
            "Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$ReturnValue;",
            "Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$ReturnValue$Builder;",
            "Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$ReturnValueOrBuilder;",
            ">;"
        }
    .end annotation
.end field

.field private retValue_:Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$ReturnValue;

.field private types_:Lcom/google/protobuf/LazyStringList;

.field private waitId_:I


# direct methods
.method private constructor <init>()V
    .locals 1

    .prologue
    .line 2930
    invoke-direct {p0}, Lcom/google/protobuf/GeneratedMessage$Builder;-><init>()V

    .line 3264
    invoke-static {}, Ljava/util/Collections;->emptyList()Ljava/util/List;

    move-result-object v0

    iput-object v0, p0, Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$IpcMessage$Builder;->arg1_:Ljava/util/List;

    .line 3330
    sget-object v0, Lcom/google/protobuf/LazyStringArrayList;->EMPTY:Lcom/google/protobuf/LazyStringList;

    iput-object v0, p0, Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$IpcMessage$Builder;->arg2_:Lcom/google/protobuf/LazyStringList;

    .line 3423
    invoke-static {}, Ljava/util/Collections;->emptyList()Ljava/util/List;

    move-result-object v0

    iput-object v0, p0, Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$IpcMessage$Builder;->arg3_:Ljava/util/List;

    .line 3489
    sget-object v0, Lcom/google/protobuf/ByteString;->EMPTY:Lcom/google/protobuf/ByteString;

    iput-object v0, p0, Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$IpcMessage$Builder;->fileData_:Lcom/google/protobuf/ByteString;

    .line 3525
    invoke-static {}, Ljava/util/Collections;->emptyList()Ljava/util/List;

    move-result-object v0

    iput-object v0, p0, Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$IpcMessage$Builder;->arg4_:Ljava/util/List;

    .line 3591
    const-string v0, ""

    iput-object v0, p0, Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$IpcMessage$Builder;->pkgName_:Ljava/lang/Object;

    .line 3689
    const-string v0, ""

    iput-object v0, p0, Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$IpcMessage$Builder;->className_:Ljava/lang/Object;

    .line 3763
    const-string v0, ""

    iput-object v0, p0, Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$IpcMessage$Builder;->methodName_:Ljava/lang/Object;

    .line 3837
    sget-object v0, Lcom/google/protobuf/LazyStringArrayList;->EMPTY:Lcom/google/protobuf/LazyStringList;

    iput-object v0, p0, Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$IpcMessage$Builder;->types_:Lcom/google/protobuf/LazyStringList;

    .line 3930
    sget-object v0, Lcom/google/protobuf/LazyStringArrayList;->EMPTY:Lcom/google/protobuf/LazyStringList;

    iput-object v0, p0, Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$IpcMessage$Builder;->params_:Lcom/google/protobuf/LazyStringList;

    .line 4089
    invoke-static {}, Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$ReturnValue;->getDefaultInstance()Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$ReturnValue;

    move-result-object v0

    iput-object v0, p0, Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$IpcMessage$Builder;->retValue_:Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$ReturnValue;

    .line 2931
    invoke-direct {p0}, Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$IpcMessage$Builder;->maybeForceBuilderInitialization()V

    .line 2932
    return-void
.end method

.method private constructor <init>(Lcom/google/protobuf/GeneratedMessage$BuilderParent;)V
    .locals 1

    .prologue
    .line 2936
    invoke-direct {p0, p1}, Lcom/google/protobuf/GeneratedMessage$Builder;-><init>(Lcom/google/protobuf/GeneratedMessage$BuilderParent;)V

    .line 3264
    invoke-static {}, Ljava/util/Collections;->emptyList()Ljava/util/List;

    move-result-object v0

    iput-object v0, p0, Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$IpcMessage$Builder;->arg1_:Ljava/util/List;

    .line 3330
    sget-object v0, Lcom/google/protobuf/LazyStringArrayList;->EMPTY:Lcom/google/protobuf/LazyStringList;

    iput-object v0, p0, Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$IpcMessage$Builder;->arg2_:Lcom/google/protobuf/LazyStringList;

    .line 3423
    invoke-static {}, Ljava/util/Collections;->emptyList()Ljava/util/List;

    move-result-object v0

    iput-object v0, p0, Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$IpcMessage$Builder;->arg3_:Ljava/util/List;

    .line 3489
    sget-object v0, Lcom/google/protobuf/ByteString;->EMPTY:Lcom/google/protobuf/ByteString;

    iput-object v0, p0, Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$IpcMessage$Builder;->fileData_:Lcom/google/protobuf/ByteString;

    .line 3525
    invoke-static {}, Ljava/util/Collections;->emptyList()Ljava/util/List;

    move-result-object v0

    iput-object v0, p0, Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$IpcMessage$Builder;->arg4_:Ljava/util/List;

    .line 3591
    const-string v0, ""

    iput-object v0, p0, Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$IpcMessage$Builder;->pkgName_:Ljava/lang/Object;

    .line 3689
    const-string v0, ""

    iput-object v0, p0, Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$IpcMessage$Builder;->className_:Ljava/lang/Object;

    .line 3763
    const-string v0, ""

    iput-object v0, p0, Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$IpcMessage$Builder;->methodName_:Ljava/lang/Object;

    .line 3837
    sget-object v0, Lcom/google/protobuf/LazyStringArrayList;->EMPTY:Lcom/google/protobuf/LazyStringList;

    iput-object v0, p0, Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$IpcMessage$Builder;->types_:Lcom/google/protobuf/LazyStringList;

    .line 3930
    sget-object v0, Lcom/google/protobuf/LazyStringArrayList;->EMPTY:Lcom/google/protobuf/LazyStringList;

    iput-object v0, p0, Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$IpcMessage$Builder;->params_:Lcom/google/protobuf/LazyStringList;

    .line 4089
    invoke-static {}, Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$ReturnValue;->getDefaultInstance()Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$ReturnValue;

    move-result-object v0

    iput-object v0, p0, Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$IpcMessage$Builder;->retValue_:Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$ReturnValue;

    .line 2937
    invoke-direct {p0}, Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$IpcMessage$Builder;->maybeForceBuilderInitialization()V

    .line 2938
    return-void
.end method

.method synthetic constructor <init>(Lcom/google/protobuf/GeneratedMessage$BuilderParent;Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$1;)V
    .locals 0

    .prologue
    .line 2914
    invoke-direct {p0, p1}, Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$IpcMessage$Builder;-><init>(Lcom/google/protobuf/GeneratedMessage$BuilderParent;)V

    return-void
.end method

.method static synthetic access$2800()Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$IpcMessage$Builder;
    .locals 1

    .prologue
    .line 2914
    invoke-static {}, Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$IpcMessage$Builder;->create()Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$IpcMessage$Builder;

    move-result-object v0

    return-object v0
.end method

.method private static create()Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$IpcMessage$Builder;
    .locals 1

    .prologue
    .line 2945
    new-instance v0, Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$IpcMessage$Builder;

    invoke-direct {v0}, Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$IpcMessage$Builder;-><init>()V

    return-object v0
.end method

.method private ensureArg1IsMutable()V
    .locals 2

    .prologue
    .line 3266
    iget v0, p0, Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$IpcMessage$Builder;->bitField0_:I

    and-int/lit8 v0, v0, 0x2

    const/4 v1, 0x2

    if-eq v0, v1, :cond_0

    .line 3267
    new-instance v0, Ljava/util/ArrayList;

    iget-object v1, p0, Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$IpcMessage$Builder;->arg1_:Ljava/util/List;

    invoke-direct {v0, v1}, Ljava/util/ArrayList;-><init>(Ljava/util/Collection;)V

    iput-object v0, p0, Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$IpcMessage$Builder;->arg1_:Ljava/util/List;

    .line 3268
    iget v0, p0, Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$IpcMessage$Builder;->bitField0_:I

    or-int/lit8 v0, v0, 0x2

    iput v0, p0, Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$IpcMessage$Builder;->bitField0_:I

    .line 3270
    :cond_0
    return-void
.end method

.method private ensureArg2IsMutable()V
    .locals 2

    .prologue
    .line 3332
    iget v0, p0, Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$IpcMessage$Builder;->bitField0_:I

    and-int/lit8 v0, v0, 0x4

    const/4 v1, 0x4

    if-eq v0, v1, :cond_0

    .line 3333
    new-instance v0, Lcom/google/protobuf/LazyStringArrayList;

    iget-object v1, p0, Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$IpcMessage$Builder;->arg2_:Lcom/google/protobuf/LazyStringList;

    invoke-direct {v0, v1}, Lcom/google/protobuf/LazyStringArrayList;-><init>(Lcom/google/protobuf/LazyStringList;)V

    iput-object v0, p0, Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$IpcMessage$Builder;->arg2_:Lcom/google/protobuf/LazyStringList;

    .line 3334
    iget v0, p0, Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$IpcMessage$Builder;->bitField0_:I

    or-int/lit8 v0, v0, 0x4

    iput v0, p0, Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$IpcMessage$Builder;->bitField0_:I

    .line 3336
    :cond_0
    return-void
.end method

.method private ensureArg3IsMutable()V
    .locals 2

    .prologue
    .line 3425
    iget v0, p0, Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$IpcMessage$Builder;->bitField0_:I

    and-int/lit8 v0, v0, 0x8

    const/16 v1, 0x8

    if-eq v0, v1, :cond_0

    .line 3426
    new-instance v0, Ljava/util/ArrayList;

    iget-object v1, p0, Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$IpcMessage$Builder;->arg3_:Ljava/util/List;

    invoke-direct {v0, v1}, Ljava/util/ArrayList;-><init>(Ljava/util/Collection;)V

    iput-object v0, p0, Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$IpcMessage$Builder;->arg3_:Ljava/util/List;

    .line 3427
    iget v0, p0, Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$IpcMessage$Builder;->bitField0_:I

    or-int/lit8 v0, v0, 0x8

    iput v0, p0, Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$IpcMessage$Builder;->bitField0_:I

    .line 3429
    :cond_0
    return-void
.end method

.method private ensureArg4IsMutable()V
    .locals 2

    .prologue
    .line 3527
    iget v0, p0, Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$IpcMessage$Builder;->bitField0_:I

    and-int/lit8 v0, v0, 0x20

    const/16 v1, 0x20

    if-eq v0, v1, :cond_0

    .line 3528
    new-instance v0, Ljava/util/ArrayList;

    iget-object v1, p0, Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$IpcMessage$Builder;->arg4_:Ljava/util/List;

    invoke-direct {v0, v1}, Ljava/util/ArrayList;-><init>(Ljava/util/Collection;)V

    iput-object v0, p0, Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$IpcMessage$Builder;->arg4_:Ljava/util/List;

    .line 3529
    iget v0, p0, Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$IpcMessage$Builder;->bitField0_:I

    or-int/lit8 v0, v0, 0x20

    iput v0, p0, Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$IpcMessage$Builder;->bitField0_:I

    .line 3531
    :cond_0
    return-void
.end method

.method private ensureParamsIsMutable()V
    .locals 2

    .prologue
    .line 3932
    iget v0, p0, Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$IpcMessage$Builder;->bitField0_:I

    and-int/lit16 v0, v0, 0x400

    const/16 v1, 0x400

    if-eq v0, v1, :cond_0

    .line 3933
    new-instance v0, Lcom/google/protobuf/LazyStringArrayList;

    iget-object v1, p0, Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$IpcMessage$Builder;->params_:Lcom/google/protobuf/LazyStringList;

    invoke-direct {v0, v1}, Lcom/google/protobuf/LazyStringArrayList;-><init>(Lcom/google/protobuf/LazyStringList;)V

    iput-object v0, p0, Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$IpcMessage$Builder;->params_:Lcom/google/protobuf/LazyStringList;

    .line 3934
    iget v0, p0, Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$IpcMessage$Builder;->bitField0_:I

    or-int/lit16 v0, v0, 0x400

    iput v0, p0, Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$IpcMessage$Builder;->bitField0_:I

    .line 3936
    :cond_0
    return-void
.end method

.method private ensureTypesIsMutable()V
    .locals 2

    .prologue
    .line 3839
    iget v0, p0, Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$IpcMessage$Builder;->bitField0_:I

    and-int/lit16 v0, v0, 0x200

    const/16 v1, 0x200

    if-eq v0, v1, :cond_0

    .line 3840
    new-instance v0, Lcom/google/protobuf/LazyStringArrayList;

    iget-object v1, p0, Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$IpcMessage$Builder;->types_:Lcom/google/protobuf/LazyStringList;

    invoke-direct {v0, v1}, Lcom/google/protobuf/LazyStringArrayList;-><init>(Lcom/google/protobuf/LazyStringList;)V

    iput-object v0, p0, Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$IpcMessage$Builder;->types_:Lcom/google/protobuf/LazyStringList;

    .line 3841
    iget v0, p0, Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$IpcMessage$Builder;->bitField0_:I

    or-int/lit16 v0, v0, 0x200

    iput v0, p0, Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$IpcMessage$Builder;->bitField0_:I

    .line 3843
    :cond_0
    return-void
.end method

.method public static final getDescriptor()Lcom/google/protobuf/Descriptors$Descriptor;
    .locals 1

    .prologue
    .line 2919
    invoke-static {}, Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc;->access$2500()Lcom/google/protobuf/Descriptors$Descriptor;

    move-result-object v0

    return-object v0
.end method

.method private getRetValueFieldBuilder()Lcom/google/protobuf/SingleFieldBuilder;
    .locals 4
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "()",
            "Lcom/google/protobuf/SingleFieldBuilder",
            "<",
            "Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$ReturnValue;",
            "Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$ReturnValue$Builder;",
            "Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$ReturnValueOrBuilder;",
            ">;"
        }
    .end annotation

    .prologue
    .line 4194
    iget-object v0, p0, Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$IpcMessage$Builder;->retValueBuilder_:Lcom/google/protobuf/SingleFieldBuilder;

    if-nez v0, :cond_0

    .line 4195
    new-instance v0, Lcom/google/protobuf/SingleFieldBuilder;

    iget-object v1, p0, Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$IpcMessage$Builder;->retValue_:Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$ReturnValue;

    .line 4198
    invoke-virtual {p0}, Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$IpcMessage$Builder;->getParentForChildren()Lcom/google/protobuf/GeneratedMessage$BuilderParent;

    move-result-object v2

    .line 4199
    invoke-virtual {p0}, Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$IpcMessage$Builder;->isClean()Z

    move-result v3

    invoke-direct {v0, v1, v2, v3}, Lcom/google/protobuf/SingleFieldBuilder;-><init>(Lcom/google/protobuf/GeneratedMessage;Lcom/google/protobuf/GeneratedMessage$BuilderParent;Z)V

    iput-object v0, p0, Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$IpcMessage$Builder;->retValueBuilder_:Lcom/google/protobuf/SingleFieldBuilder;

    .line 4200
    const/4 v0, 0x0

    iput-object v0, p0, Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$IpcMessage$Builder;->retValue_:Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$ReturnValue;

    .line 4202
    :cond_0
    iget-object v0, p0, Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$IpcMessage$Builder;->retValueBuilder_:Lcom/google/protobuf/SingleFieldBuilder;

    return-object v0
.end method

.method private maybeForceBuilderInitialization()V
    .locals 1

    .prologue
    .line 2940
    invoke-static {}, Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$IpcMessage;->access$3000()Z

    move-result v0

    if-eqz v0, :cond_0

    .line 2941
    invoke-direct {p0}, Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$IpcMessage$Builder;->getRetValueFieldBuilder()Lcom/google/protobuf/SingleFieldBuilder;

    .line 2943
    :cond_0
    return-void
.end method


# virtual methods
.method public addAllArg1(Ljava/lang/Iterable;)Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$IpcMessage$Builder;
    .locals 1
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "(",
            "Ljava/lang/Iterable",
            "<+",
            "Ljava/lang/Integer;",
            ">;)",
            "Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$IpcMessage$Builder;"
        }
    .end annotation

    .prologue
    .line 3314
    invoke-direct {p0}, Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$IpcMessage$Builder;->ensureArg1IsMutable()V

    .line 3315
    iget-object v0, p0, Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$IpcMessage$Builder;->arg1_:Ljava/util/List;

    invoke-static {p1, v0}, Lcom/google/protobuf/GeneratedMessage$Builder;->addAll(Ljava/lang/Iterable;Ljava/util/Collection;)V

    .line 3316
    invoke-virtual {p0}, Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$IpcMessage$Builder;->onChanged()V

    .line 3317
    return-object p0
.end method

.method public addAllArg2(Ljava/lang/Iterable;)Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$IpcMessage$Builder;
    .locals 1
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "(",
            "Ljava/lang/Iterable",
            "<",
            "Ljava/lang/String;",
            ">;)",
            "Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$IpcMessage$Builder;"
        }
    .end annotation

    .prologue
    .line 3394
    invoke-direct {p0}, Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$IpcMessage$Builder;->ensureArg2IsMutable()V

    .line 3395
    iget-object v0, p0, Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$IpcMessage$Builder;->arg2_:Lcom/google/protobuf/LazyStringList;

    invoke-static {p1, v0}, Lcom/google/protobuf/GeneratedMessage$Builder;->addAll(Ljava/lang/Iterable;Ljava/util/Collection;)V

    .line 3396
    invoke-virtual {p0}, Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$IpcMessage$Builder;->onChanged()V

    .line 3397
    return-object p0
.end method

.method public addAllArg3(Ljava/lang/Iterable;)Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$IpcMessage$Builder;
    .locals 1
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "(",
            "Ljava/lang/Iterable",
            "<+",
            "Ljava/lang/Float;",
            ">;)",
            "Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$IpcMessage$Builder;"
        }
    .end annotation

    .prologue
    .line 3473
    invoke-direct {p0}, Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$IpcMessage$Builder;->ensureArg3IsMutable()V

    .line 3474
    iget-object v0, p0, Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$IpcMessage$Builder;->arg3_:Ljava/util/List;

    invoke-static {p1, v0}, Lcom/google/protobuf/GeneratedMessage$Builder;->addAll(Ljava/lang/Iterable;Ljava/util/Collection;)V

    .line 3475
    invoke-virtual {p0}, Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$IpcMessage$Builder;->onChanged()V

    .line 3476
    return-object p0
.end method

.method public addAllArg4(Ljava/lang/Iterable;)Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$IpcMessage$Builder;
    .locals 1
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "(",
            "Ljava/lang/Iterable",
            "<+",
            "Ljava/lang/Long;",
            ">;)",
            "Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$IpcMessage$Builder;"
        }
    .end annotation

    .prologue
    .line 3575
    invoke-direct {p0}, Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$IpcMessage$Builder;->ensureArg4IsMutable()V

    .line 3576
    iget-object v0, p0, Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$IpcMessage$Builder;->arg4_:Ljava/util/List;

    invoke-static {p1, v0}, Lcom/google/protobuf/GeneratedMessage$Builder;->addAll(Ljava/lang/Iterable;Ljava/util/Collection;)V

    .line 3577
    invoke-virtual {p0}, Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$IpcMessage$Builder;->onChanged()V

    .line 3578
    return-object p0
.end method

.method public addAllParams(Ljava/lang/Iterable;)Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$IpcMessage$Builder;
    .locals 1
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "(",
            "Ljava/lang/Iterable",
            "<",
            "Ljava/lang/String;",
            ">;)",
            "Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$IpcMessage$Builder;"
        }
    .end annotation

    .prologue
    .line 3994
    invoke-direct {p0}, Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$IpcMessage$Builder;->ensureParamsIsMutable()V

    .line 3995
    iget-object v0, p0, Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$IpcMessage$Builder;->params_:Lcom/google/protobuf/LazyStringList;

    invoke-static {p1, v0}, Lcom/google/protobuf/GeneratedMessage$Builder;->addAll(Ljava/lang/Iterable;Ljava/util/Collection;)V

    .line 3996
    invoke-virtual {p0}, Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$IpcMessage$Builder;->onChanged()V

    .line 3997
    return-object p0
.end method

.method public addAllTypes(Ljava/lang/Iterable;)Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$IpcMessage$Builder;
    .locals 1
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "(",
            "Ljava/lang/Iterable",
            "<",
            "Ljava/lang/String;",
            ">;)",
            "Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$IpcMessage$Builder;"
        }
    .end annotation

    .prologue
    .line 3901
    invoke-direct {p0}, Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$IpcMessage$Builder;->ensureTypesIsMutable()V

    .line 3902
    iget-object v0, p0, Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$IpcMessage$Builder;->types_:Lcom/google/protobuf/LazyStringList;

    invoke-static {p1, v0}, Lcom/google/protobuf/GeneratedMessage$Builder;->addAll(Ljava/lang/Iterable;Ljava/util/Collection;)V

    .line 3903
    invoke-virtual {p0}, Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$IpcMessage$Builder;->onChanged()V

    .line 3904
    return-object p0
.end method

.method public addArg1(I)Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$IpcMessage$Builder;
    .locals 2

    .prologue
    .line 3304
    invoke-direct {p0}, Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$IpcMessage$Builder;->ensureArg1IsMutable()V

    .line 3305
    iget-object v0, p0, Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$IpcMessage$Builder;->arg1_:Ljava/util/List;

    invoke-static {p1}, Ljava/lang/Integer;->valueOf(I)Ljava/lang/Integer;

    move-result-object v1

    invoke-interface {v0, v1}, Ljava/util/List;->add(Ljava/lang/Object;)Z

    .line 3306
    invoke-virtual {p0}, Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$IpcMessage$Builder;->onChanged()V

    .line 3307
    return-object p0
.end method

.method public addArg2(Ljava/lang/String;)Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$IpcMessage$Builder;
    .locals 1

    .prologue
    .line 3381
    if-nez p1, :cond_0

    .line 3382
    new-instance v0, Ljava/lang/NullPointerException;

    invoke-direct {v0}, Ljava/lang/NullPointerException;-><init>()V

    throw v0

    .line 3384
    :cond_0
    invoke-direct {p0}, Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$IpcMessage$Builder;->ensureArg2IsMutable()V

    .line 3385
    iget-object v0, p0, Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$IpcMessage$Builder;->arg2_:Lcom/google/protobuf/LazyStringList;

    invoke-interface {v0, p1}, Lcom/google/protobuf/LazyStringList;->add(Ljava/lang/Object;)Z

    .line 3386
    invoke-virtual {p0}, Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$IpcMessage$Builder;->onChanged()V

    .line 3387
    return-object p0
.end method

.method public addArg2Bytes(Lcom/google/protobuf/ByteString;)Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$IpcMessage$Builder;
    .locals 1

    .prologue
    .line 3413
    if-nez p1, :cond_0

    .line 3414
    new-instance v0, Ljava/lang/NullPointerException;

    invoke-direct {v0}, Ljava/lang/NullPointerException;-><init>()V

    throw v0

    .line 3416
    :cond_0
    invoke-direct {p0}, Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$IpcMessage$Builder;->ensureArg2IsMutable()V

    .line 3417
    iget-object v0, p0, Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$IpcMessage$Builder;->arg2_:Lcom/google/protobuf/LazyStringList;

    invoke-interface {v0, p1}, Lcom/google/protobuf/LazyStringList;->add(Lcom/google/protobuf/ByteString;)V

    .line 3418
    invoke-virtual {p0}, Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$IpcMessage$Builder;->onChanged()V

    .line 3419
    return-object p0
.end method

.method public addArg3(F)Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$IpcMessage$Builder;
    .locals 2

    .prologue
    .line 3463
    invoke-direct {p0}, Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$IpcMessage$Builder;->ensureArg3IsMutable()V

    .line 3464
    iget-object v0, p0, Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$IpcMessage$Builder;->arg3_:Ljava/util/List;

    invoke-static {p1}, Ljava/lang/Float;->valueOf(F)Ljava/lang/Float;

    move-result-object v1

    invoke-interface {v0, v1}, Ljava/util/List;->add(Ljava/lang/Object;)Z

    .line 3465
    invoke-virtual {p0}, Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$IpcMessage$Builder;->onChanged()V

    .line 3466
    return-object p0
.end method

.method public addArg4(J)Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$IpcMessage$Builder;
    .locals 3

    .prologue
    .line 3565
    invoke-direct {p0}, Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$IpcMessage$Builder;->ensureArg4IsMutable()V

    .line 3566
    iget-object v0, p0, Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$IpcMessage$Builder;->arg4_:Ljava/util/List;

    invoke-static {p1, p2}, Ljava/lang/Long;->valueOf(J)Ljava/lang/Long;

    move-result-object v1

    invoke-interface {v0, v1}, Ljava/util/List;->add(Ljava/lang/Object;)Z

    .line 3567
    invoke-virtual {p0}, Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$IpcMessage$Builder;->onChanged()V

    .line 3568
    return-object p0
.end method

.method public addParams(Ljava/lang/String;)Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$IpcMessage$Builder;
    .locals 1

    .prologue
    .line 3981
    if-nez p1, :cond_0

    .line 3982
    new-instance v0, Ljava/lang/NullPointerException;

    invoke-direct {v0}, Ljava/lang/NullPointerException;-><init>()V

    throw v0

    .line 3984
    :cond_0
    invoke-direct {p0}, Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$IpcMessage$Builder;->ensureParamsIsMutable()V

    .line 3985
    iget-object v0, p0, Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$IpcMessage$Builder;->params_:Lcom/google/protobuf/LazyStringList;

    invoke-interface {v0, p1}, Lcom/google/protobuf/LazyStringList;->add(Ljava/lang/Object;)Z

    .line 3986
    invoke-virtual {p0}, Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$IpcMessage$Builder;->onChanged()V

    .line 3987
    return-object p0
.end method

.method public addParamsBytes(Lcom/google/protobuf/ByteString;)Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$IpcMessage$Builder;
    .locals 1

    .prologue
    .line 4013
    if-nez p1, :cond_0

    .line 4014
    new-instance v0, Ljava/lang/NullPointerException;

    invoke-direct {v0}, Ljava/lang/NullPointerException;-><init>()V

    throw v0

    .line 4016
    :cond_0
    invoke-direct {p0}, Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$IpcMessage$Builder;->ensureParamsIsMutable()V

    .line 4017
    iget-object v0, p0, Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$IpcMessage$Builder;->params_:Lcom/google/protobuf/LazyStringList;

    invoke-interface {v0, p1}, Lcom/google/protobuf/LazyStringList;->add(Lcom/google/protobuf/ByteString;)V

    .line 4018
    invoke-virtual {p0}, Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$IpcMessage$Builder;->onChanged()V

    .line 4019
    return-object p0
.end method

.method public addTypes(Ljava/lang/String;)Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$IpcMessage$Builder;
    .locals 1

    .prologue
    .line 3888
    if-nez p1, :cond_0

    .line 3889
    new-instance v0, Ljava/lang/NullPointerException;

    invoke-direct {v0}, Ljava/lang/NullPointerException;-><init>()V

    throw v0

    .line 3891
    :cond_0
    invoke-direct {p0}, Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$IpcMessage$Builder;->ensureTypesIsMutable()V

    .line 3892
    iget-object v0, p0, Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$IpcMessage$Builder;->types_:Lcom/google/protobuf/LazyStringList;

    invoke-interface {v0, p1}, Lcom/google/protobuf/LazyStringList;->add(Ljava/lang/Object;)Z

    .line 3893
    invoke-virtual {p0}, Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$IpcMessage$Builder;->onChanged()V

    .line 3894
    return-object p0
.end method

.method public addTypesBytes(Lcom/google/protobuf/ByteString;)Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$IpcMessage$Builder;
    .locals 1

    .prologue
    .line 3920
    if-nez p1, :cond_0

    .line 3921
    new-instance v0, Ljava/lang/NullPointerException;

    invoke-direct {v0}, Ljava/lang/NullPointerException;-><init>()V

    throw v0

    .line 3923
    :cond_0
    invoke-direct {p0}, Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$IpcMessage$Builder;->ensureTypesIsMutable()V

    .line 3924
    iget-object v0, p0, Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$IpcMessage$Builder;->types_:Lcom/google/protobuf/LazyStringList;

    invoke-interface {v0, p1}, Lcom/google/protobuf/LazyStringList;->add(Lcom/google/protobuf/ByteString;)V

    .line 3925
    invoke-virtual {p0}, Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$IpcMessage$Builder;->onChanged()V

    .line 3926
    return-object p0
.end method

.method public build()Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$IpcMessage;
    .locals 2

    .prologue
    .line 3003
    invoke-virtual {p0}, Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$IpcMessage$Builder;->buildPartial()Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$IpcMessage;

    move-result-object v0

    .line 3004
    invoke-virtual {v0}, Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$IpcMessage;->isInitialized()Z

    move-result v1

    if-nez v1, :cond_0

    .line 3005
    invoke-static {v0}, Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$IpcMessage$Builder;->newUninitializedMessageException(Lcom/google/protobuf/Message;)Lcom/google/protobuf/UninitializedMessageException;

    move-result-object v0

    throw v0

    .line 3007
    :cond_0
    return-object v0
.end method

.method public bridge synthetic build()Lcom/google/protobuf/Message;
    .locals 1

    .prologue
    .line 2914
    invoke-virtual {p0}, Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$IpcMessage$Builder;->build()Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$IpcMessage;

    move-result-object v0

    return-object v0
.end method

.method public bridge synthetic build()Lcom/google/protobuf/MessageLite;
    .locals 1

    .prologue
    .line 2914
    invoke-virtual {p0}, Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$IpcMessage$Builder;->build()Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$IpcMessage;

    move-result-object v0

    return-object v0
.end method

.method public buildPartial()Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$IpcMessage;
    .locals 6

    .prologue
    const v5, 0x8000

    const/4 v0, 0x1

    .line 3011
    new-instance v2, Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$IpcMessage;

    const/4 v1, 0x0

    invoke-direct {v2, p0, v1}, Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$IpcMessage;-><init>(Lcom/google/protobuf/GeneratedMessage$Builder;Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$1;)V

    .line 3012
    iget v3, p0, Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$IpcMessage$Builder;->bitField0_:I

    .line 3013
    const/4 v1, 0x0

    .line 3014
    and-int/lit8 v4, v3, 0x1

    if-ne v4, v0, :cond_10

    .line 3017
    :goto_0
    iget v1, p0, Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$IpcMessage$Builder;->cmd_:I

    invoke-static {v2, v1}, Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$IpcMessage;->access$3202(Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$IpcMessage;I)I

    .line 3018
    iget v1, p0, Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$IpcMessage$Builder;->bitField0_:I

    and-int/lit8 v1, v1, 0x2

    const/4 v4, 0x2

    if-ne v1, v4, :cond_0

    .line 3019
    iget-object v1, p0, Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$IpcMessage$Builder;->arg1_:Ljava/util/List;

    invoke-static {v1}, Ljava/util/Collections;->unmodifiableList(Ljava/util/List;)Ljava/util/List;

    move-result-object v1

    iput-object v1, p0, Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$IpcMessage$Builder;->arg1_:Ljava/util/List;

    .line 3020
    iget v1, p0, Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$IpcMessage$Builder;->bitField0_:I

    and-int/lit8 v1, v1, -0x3

    iput v1, p0, Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$IpcMessage$Builder;->bitField0_:I

    .line 3022
    :cond_0
    iget-object v1, p0, Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$IpcMessage$Builder;->arg1_:Ljava/util/List;

    invoke-static {v2, v1}, Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$IpcMessage;->access$3302(Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$IpcMessage;Ljava/util/List;)Ljava/util/List;

    .line 3023
    iget v1, p0, Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$IpcMessage$Builder;->bitField0_:I

    and-int/lit8 v1, v1, 0x4

    const/4 v4, 0x4

    if-ne v1, v4, :cond_1

    .line 3024
    new-instance v1, Lcom/google/protobuf/UnmodifiableLazyStringList;

    iget-object v4, p0, Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$IpcMessage$Builder;->arg2_:Lcom/google/protobuf/LazyStringList;

    invoke-direct {v1, v4}, Lcom/google/protobuf/UnmodifiableLazyStringList;-><init>(Lcom/google/protobuf/LazyStringList;)V

    iput-object v1, p0, Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$IpcMessage$Builder;->arg2_:Lcom/google/protobuf/LazyStringList;

    .line 3026
    iget v1, p0, Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$IpcMessage$Builder;->bitField0_:I

    and-int/lit8 v1, v1, -0x5

    iput v1, p0, Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$IpcMessage$Builder;->bitField0_:I

    .line 3028
    :cond_1
    iget-object v1, p0, Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$IpcMessage$Builder;->arg2_:Lcom/google/protobuf/LazyStringList;

    invoke-static {v2, v1}, Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$IpcMessage;->access$3402(Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$IpcMessage;Lcom/google/protobuf/LazyStringList;)Lcom/google/protobuf/LazyStringList;

    .line 3029
    iget v1, p0, Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$IpcMessage$Builder;->bitField0_:I

    and-int/lit8 v1, v1, 0x8

    const/16 v4, 0x8

    if-ne v1, v4, :cond_2

    .line 3030
    iget-object v1, p0, Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$IpcMessage$Builder;->arg3_:Ljava/util/List;

    invoke-static {v1}, Ljava/util/Collections;->unmodifiableList(Ljava/util/List;)Ljava/util/List;

    move-result-object v1

    iput-object v1, p0, Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$IpcMessage$Builder;->arg3_:Ljava/util/List;

    .line 3031
    iget v1, p0, Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$IpcMessage$Builder;->bitField0_:I

    and-int/lit8 v1, v1, -0x9

    iput v1, p0, Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$IpcMessage$Builder;->bitField0_:I

    .line 3033
    :cond_2
    iget-object v1, p0, Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$IpcMessage$Builder;->arg3_:Ljava/util/List;

    invoke-static {v2, v1}, Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$IpcMessage;->access$3502(Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$IpcMessage;Ljava/util/List;)Ljava/util/List;

    .line 3034
    and-int/lit8 v1, v3, 0x10

    const/16 v4, 0x10

    if-ne v1, v4, :cond_3

    .line 3035
    or-int/lit8 v0, v0, 0x2

    .line 3037
    :cond_3
    iget-object v1, p0, Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$IpcMessage$Builder;->fileData_:Lcom/google/protobuf/ByteString;

    invoke-static {v2, v1}, Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$IpcMessage;->access$3602(Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$IpcMessage;Lcom/google/protobuf/ByteString;)Lcom/google/protobuf/ByteString;

    .line 3038
    iget v1, p0, Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$IpcMessage$Builder;->bitField0_:I

    and-int/lit8 v1, v1, 0x20

    const/16 v4, 0x20

    if-ne v1, v4, :cond_4

    .line 3039
    iget-object v1, p0, Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$IpcMessage$Builder;->arg4_:Ljava/util/List;

    invoke-static {v1}, Ljava/util/Collections;->unmodifiableList(Ljava/util/List;)Ljava/util/List;

    move-result-object v1

    iput-object v1, p0, Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$IpcMessage$Builder;->arg4_:Ljava/util/List;

    .line 3040
    iget v1, p0, Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$IpcMessage$Builder;->bitField0_:I

    and-int/lit8 v1, v1, -0x21

    iput v1, p0, Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$IpcMessage$Builder;->bitField0_:I

    .line 3042
    :cond_4
    iget-object v1, p0, Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$IpcMessage$Builder;->arg4_:Ljava/util/List;

    invoke-static {v2, v1}, Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$IpcMessage;->access$3702(Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$IpcMessage;Ljava/util/List;)Ljava/util/List;

    .line 3043
    and-int/lit8 v1, v3, 0x40

    const/16 v4, 0x40

    if-ne v1, v4, :cond_5

    .line 3044
    or-int/lit8 v0, v0, 0x4

    .line 3046
    :cond_5
    iget-object v1, p0, Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$IpcMessage$Builder;->pkgName_:Ljava/lang/Object;

    invoke-static {v2, v1}, Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$IpcMessage;->access$3802(Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$IpcMessage;Ljava/lang/Object;)Ljava/lang/Object;

    .line 3047
    and-int/lit16 v1, v3, 0x80

    const/16 v4, 0x80

    if-ne v1, v4, :cond_6

    .line 3048
    or-int/lit8 v0, v0, 0x8

    .line 3050
    :cond_6
    iget-object v1, p0, Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$IpcMessage$Builder;->className_:Ljava/lang/Object;

    invoke-static {v2, v1}, Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$IpcMessage;->access$3902(Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$IpcMessage;Ljava/lang/Object;)Ljava/lang/Object;

    .line 3051
    and-int/lit16 v1, v3, 0x100

    const/16 v4, 0x100

    if-ne v1, v4, :cond_7

    .line 3052
    or-int/lit8 v0, v0, 0x10

    .line 3054
    :cond_7
    iget-object v1, p0, Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$IpcMessage$Builder;->methodName_:Ljava/lang/Object;

    invoke-static {v2, v1}, Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$IpcMessage;->access$4002(Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$IpcMessage;Ljava/lang/Object;)Ljava/lang/Object;

    .line 3055
    iget v1, p0, Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$IpcMessage$Builder;->bitField0_:I

    and-int/lit16 v1, v1, 0x200

    const/16 v4, 0x200

    if-ne v1, v4, :cond_8

    .line 3056
    new-instance v1, Lcom/google/protobuf/UnmodifiableLazyStringList;

    iget-object v4, p0, Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$IpcMessage$Builder;->types_:Lcom/google/protobuf/LazyStringList;

    invoke-direct {v1, v4}, Lcom/google/protobuf/UnmodifiableLazyStringList;-><init>(Lcom/google/protobuf/LazyStringList;)V

    iput-object v1, p0, Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$IpcMessage$Builder;->types_:Lcom/google/protobuf/LazyStringList;

    .line 3058
    iget v1, p0, Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$IpcMessage$Builder;->bitField0_:I

    and-int/lit16 v1, v1, -0x201

    iput v1, p0, Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$IpcMessage$Builder;->bitField0_:I

    .line 3060
    :cond_8
    iget-object v1, p0, Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$IpcMessage$Builder;->types_:Lcom/google/protobuf/LazyStringList;

    invoke-static {v2, v1}, Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$IpcMessage;->access$4102(Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$IpcMessage;Lcom/google/protobuf/LazyStringList;)Lcom/google/protobuf/LazyStringList;

    .line 3061
    iget v1, p0, Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$IpcMessage$Builder;->bitField0_:I

    and-int/lit16 v1, v1, 0x400

    const/16 v4, 0x400

    if-ne v1, v4, :cond_9

    .line 3062
    new-instance v1, Lcom/google/protobuf/UnmodifiableLazyStringList;

    iget-object v4, p0, Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$IpcMessage$Builder;->params_:Lcom/google/protobuf/LazyStringList;

    invoke-direct {v1, v4}, Lcom/google/protobuf/UnmodifiableLazyStringList;-><init>(Lcom/google/protobuf/LazyStringList;)V

    iput-object v1, p0, Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$IpcMessage$Builder;->params_:Lcom/google/protobuf/LazyStringList;

    .line 3064
    iget v1, p0, Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$IpcMessage$Builder;->bitField0_:I

    and-int/lit16 v1, v1, -0x401

    iput v1, p0, Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$IpcMessage$Builder;->bitField0_:I

    .line 3066
    :cond_9
    iget-object v1, p0, Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$IpcMessage$Builder;->params_:Lcom/google/protobuf/LazyStringList;

    invoke-static {v2, v1}, Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$IpcMessage;->access$4202(Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$IpcMessage;Lcom/google/protobuf/LazyStringList;)Lcom/google/protobuf/LazyStringList;

    .line 3067
    and-int/lit16 v1, v3, 0x800

    const/16 v4, 0x800

    if-ne v1, v4, :cond_a

    .line 3068
    or-int/lit8 v0, v0, 0x20

    .line 3070
    :cond_a
    iget-boolean v1, p0, Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$IpcMessage$Builder;->isSyncCall_:Z

    invoke-static {v2, v1}, Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$IpcMessage;->access$4302(Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$IpcMessage;Z)Z

    .line 3071
    and-int/lit16 v1, v3, 0x1000

    const/16 v4, 0x1000

    if-ne v1, v4, :cond_b

    .line 3072
    or-int/lit8 v0, v0, 0x40

    .line 3074
    :cond_b
    iget v1, p0, Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$IpcMessage$Builder;->waitId_:I

    invoke-static {v2, v1}, Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$IpcMessage;->access$4402(Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$IpcMessage;I)I

    .line 3075
    and-int/lit16 v1, v3, 0x2000

    const/16 v4, 0x2000

    if-ne v1, v4, :cond_f

    .line 3076
    or-int/lit16 v0, v0, 0x80

    move v1, v0

    .line 3078
    :goto_1
    iget-object v0, p0, Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$IpcMessage$Builder;->retValueBuilder_:Lcom/google/protobuf/SingleFieldBuilder;

    if-nez v0, :cond_e

    .line 3079
    iget-object v0, p0, Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$IpcMessage$Builder;->retValue_:Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$ReturnValue;

    invoke-static {v2, v0}, Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$IpcMessage;->access$4502(Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$IpcMessage;Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$ReturnValue;)Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$ReturnValue;

    .line 3083
    :goto_2
    and-int/lit16 v0, v3, 0x4000

    const/16 v4, 0x4000

    if-ne v0, v4, :cond_c

    .line 3084
    or-int/lit16 v1, v1, 0x100

    .line 3086
    :cond_c
    iget-boolean v0, p0, Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$IpcMessage$Builder;->encrypt_:Z

    invoke-static {v2, v0}, Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$IpcMessage;->access$4602(Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$IpcMessage;Z)Z

    .line 3087
    and-int v0, v3, v5

    if-ne v0, v5, :cond_d

    .line 3088
    or-int/lit16 v1, v1, 0x200

    .line 3090
    :cond_d
    iget-boolean v0, p0, Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$IpcMessage$Builder;->isDebug_:Z

    invoke-static {v2, v0}, Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$IpcMessage;->access$4702(Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$IpcMessage;Z)Z

    .line 3091
    invoke-static {v2, v1}, Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$IpcMessage;->access$4802(Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$IpcMessage;I)I

    .line 3092
    invoke-virtual {p0}, Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$IpcMessage$Builder;->onBuilt()V

    .line 3093
    return-object v2

    .line 3081
    :cond_e
    iget-object v0, p0, Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$IpcMessage$Builder;->retValueBuilder_:Lcom/google/protobuf/SingleFieldBuilder;

    invoke-virtual {v0}, Lcom/google/protobuf/SingleFieldBuilder;->build()Lcom/google/protobuf/GeneratedMessage;

    move-result-object v0

    check-cast v0, Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$ReturnValue;

    invoke-static {v2, v0}, Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$IpcMessage;->access$4502(Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$IpcMessage;Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$ReturnValue;)Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$ReturnValue;

    goto :goto_2

    :cond_f
    move v1, v0

    goto :goto_1

    :cond_10
    move v0, v1

    goto/16 :goto_0
.end method

.method public bridge synthetic buildPartial()Lcom/google/protobuf/Message;
    .locals 1

    .prologue
    .line 2914
    invoke-virtual {p0}, Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$IpcMessage$Builder;->buildPartial()Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$IpcMessage;

    move-result-object v0

    return-object v0
.end method

.method public bridge synthetic buildPartial()Lcom/google/protobuf/MessageLite;
    .locals 1

    .prologue
    .line 2914
    invoke-virtual {p0}, Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$IpcMessage$Builder;->buildPartial()Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$IpcMessage;

    move-result-object v0

    return-object v0
.end method

.method public clear()Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$IpcMessage$Builder;
    .locals 2

    .prologue
    const/4 v1, 0x0

    .line 2949
    invoke-super {p0}, Lcom/google/protobuf/GeneratedMessage$Builder;->clear()Lcom/google/protobuf/GeneratedMessage$Builder;

    .line 2950
    iput v1, p0, Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$IpcMessage$Builder;->cmd_:I

    .line 2951
    iget v0, p0, Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$IpcMessage$Builder;->bitField0_:I

    and-int/lit8 v0, v0, -0x2

    iput v0, p0, Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$IpcMessage$Builder;->bitField0_:I

    .line 2952
    invoke-static {}, Ljava/util/Collections;->emptyList()Ljava/util/List;

    move-result-object v0

    iput-object v0, p0, Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$IpcMessage$Builder;->arg1_:Ljava/util/List;

    .line 2953
    iget v0, p0, Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$IpcMessage$Builder;->bitField0_:I

    and-int/lit8 v0, v0, -0x3

    iput v0, p0, Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$IpcMessage$Builder;->bitField0_:I

    .line 2954
    sget-object v0, Lcom/google/protobuf/LazyStringArrayList;->EMPTY:Lcom/google/protobuf/LazyStringList;

    iput-object v0, p0, Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$IpcMessage$Builder;->arg2_:Lcom/google/protobuf/LazyStringList;

    .line 2955
    iget v0, p0, Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$IpcMessage$Builder;->bitField0_:I

    and-int/lit8 v0, v0, -0x5

    iput v0, p0, Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$IpcMessage$Builder;->bitField0_:I

    .line 2956
    invoke-static {}, Ljava/util/Collections;->emptyList()Ljava/util/List;

    move-result-object v0

    iput-object v0, p0, Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$IpcMessage$Builder;->arg3_:Ljava/util/List;

    .line 2957
    iget v0, p0, Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$IpcMessage$Builder;->bitField0_:I

    and-int/lit8 v0, v0, -0x9

    iput v0, p0, Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$IpcMessage$Builder;->bitField0_:I

    .line 2958
    sget-object v0, Lcom/google/protobuf/ByteString;->EMPTY:Lcom/google/protobuf/ByteString;

    iput-object v0, p0, Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$IpcMessage$Builder;->fileData_:Lcom/google/protobuf/ByteString;

    .line 2959
    iget v0, p0, Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$IpcMessage$Builder;->bitField0_:I

    and-int/lit8 v0, v0, -0x11

    iput v0, p0, Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$IpcMessage$Builder;->bitField0_:I

    .line 2960
    invoke-static {}, Ljava/util/Collections;->emptyList()Ljava/util/List;

    move-result-object v0

    iput-object v0, p0, Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$IpcMessage$Builder;->arg4_:Ljava/util/List;

    .line 2961
    iget v0, p0, Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$IpcMessage$Builder;->bitField0_:I

    and-int/lit8 v0, v0, -0x21

    iput v0, p0, Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$IpcMessage$Builder;->bitField0_:I

    .line 2962
    const-string v0, ""

    iput-object v0, p0, Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$IpcMessage$Builder;->pkgName_:Ljava/lang/Object;

    .line 2963
    iget v0, p0, Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$IpcMessage$Builder;->bitField0_:I

    and-int/lit8 v0, v0, -0x41

    iput v0, p0, Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$IpcMessage$Builder;->bitField0_:I

    .line 2964
    const-string v0, ""

    iput-object v0, p0, Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$IpcMessage$Builder;->className_:Ljava/lang/Object;

    .line 2965
    iget v0, p0, Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$IpcMessage$Builder;->bitField0_:I

    and-int/lit16 v0, v0, -0x81

    iput v0, p0, Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$IpcMessage$Builder;->bitField0_:I

    .line 2966
    const-string v0, ""

    iput-object v0, p0, Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$IpcMessage$Builder;->methodName_:Ljava/lang/Object;

    .line 2967
    iget v0, p0, Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$IpcMessage$Builder;->bitField0_:I

    and-int/lit16 v0, v0, -0x101

    iput v0, p0, Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$IpcMessage$Builder;->bitField0_:I

    .line 2968
    sget-object v0, Lcom/google/protobuf/LazyStringArrayList;->EMPTY:Lcom/google/protobuf/LazyStringList;

    iput-object v0, p0, Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$IpcMessage$Builder;->types_:Lcom/google/protobuf/LazyStringList;

    .line 2969
    iget v0, p0, Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$IpcMessage$Builder;->bitField0_:I

    and-int/lit16 v0, v0, -0x201

    iput v0, p0, Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$IpcMessage$Builder;->bitField0_:I

    .line 2970
    sget-object v0, Lcom/google/protobuf/LazyStringArrayList;->EMPTY:Lcom/google/protobuf/LazyStringList;

    iput-object v0, p0, Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$IpcMessage$Builder;->params_:Lcom/google/protobuf/LazyStringList;

    .line 2971
    iget v0, p0, Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$IpcMessage$Builder;->bitField0_:I

    and-int/lit16 v0, v0, -0x401

    iput v0, p0, Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$IpcMessage$Builder;->bitField0_:I

    .line 2972
    iput-boolean v1, p0, Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$IpcMessage$Builder;->isSyncCall_:Z

    .line 2973
    iget v0, p0, Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$IpcMessage$Builder;->bitField0_:I

    and-int/lit16 v0, v0, -0x801

    iput v0, p0, Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$IpcMessage$Builder;->bitField0_:I

    .line 2974
    iput v1, p0, Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$IpcMessage$Builder;->waitId_:I

    .line 2975
    iget v0, p0, Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$IpcMessage$Builder;->bitField0_:I

    and-int/lit16 v0, v0, -0x1001

    iput v0, p0, Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$IpcMessage$Builder;->bitField0_:I

    .line 2976
    iget-object v0, p0, Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$IpcMessage$Builder;->retValueBuilder_:Lcom/google/protobuf/SingleFieldBuilder;

    if-nez v0, :cond_0

    .line 2977
    invoke-static {}, Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$ReturnValue;->getDefaultInstance()Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$ReturnValue;

    move-result-object v0

    iput-object v0, p0, Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$IpcMessage$Builder;->retValue_:Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$ReturnValue;

    .line 2981
    :goto_0
    iget v0, p0, Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$IpcMessage$Builder;->bitField0_:I

    and-int/lit16 v0, v0, -0x2001

    iput v0, p0, Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$IpcMessage$Builder;->bitField0_:I

    .line 2982
    iput-boolean v1, p0, Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$IpcMessage$Builder;->encrypt_:Z

    .line 2983
    iget v0, p0, Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$IpcMessage$Builder;->bitField0_:I

    and-int/lit16 v0, v0, -0x4001

    iput v0, p0, Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$IpcMessage$Builder;->bitField0_:I

    .line 2984
    iput-boolean v1, p0, Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$IpcMessage$Builder;->isDebug_:Z

    .line 2985
    iget v0, p0, Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$IpcMessage$Builder;->bitField0_:I

    const v1, -0x8001

    and-int/2addr v0, v1

    iput v0, p0, Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$IpcMessage$Builder;->bitField0_:I

    .line 2986
    return-object p0

    .line 2979
    :cond_0
    iget-object v0, p0, Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$IpcMessage$Builder;->retValueBuilder_:Lcom/google/protobuf/SingleFieldBuilder;

    invoke-virtual {v0}, Lcom/google/protobuf/SingleFieldBuilder;->clear()Lcom/google/protobuf/SingleFieldBuilder;

    goto :goto_0
.end method

.method public bridge synthetic clear()Lcom/google/protobuf/AbstractMessage$Builder;
    .locals 1

    .prologue
    .line 2914
    invoke-virtual {p0}, Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$IpcMessage$Builder;->clear()Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$IpcMessage$Builder;

    move-result-object v0

    return-object v0
.end method

.method public bridge synthetic clear()Lcom/google/protobuf/GeneratedMessage$Builder;
    .locals 1

    .prologue
    .line 2914
    invoke-virtual {p0}, Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$IpcMessage$Builder;->clear()Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$IpcMessage$Builder;

    move-result-object v0

    return-object v0
.end method

.method public bridge synthetic clear()Lcom/google/protobuf/Message$Builder;
    .locals 1

    .prologue
    .line 2914
    invoke-virtual {p0}, Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$IpcMessage$Builder;->clear()Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$IpcMessage$Builder;

    move-result-object v0

    return-object v0
.end method

.method public bridge synthetic clear()Lcom/google/protobuf/MessageLite$Builder;
    .locals 1

    .prologue
    .line 2914
    invoke-virtual {p0}, Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$IpcMessage$Builder;->clear()Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$IpcMessage$Builder;

    move-result-object v0

    return-object v0
.end method

.method public clearArg1()Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$IpcMessage$Builder;
    .locals 1

    .prologue
    .line 3323
    invoke-static {}, Ljava/util/Collections;->emptyList()Ljava/util/List;

    move-result-object v0

    iput-object v0, p0, Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$IpcMessage$Builder;->arg1_:Ljava/util/List;

    .line 3324
    iget v0, p0, Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$IpcMessage$Builder;->bitField0_:I

    and-int/lit8 v0, v0, -0x3

    iput v0, p0, Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$IpcMessage$Builder;->bitField0_:I

    .line 3325
    invoke-virtual {p0}, Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$IpcMessage$Builder;->onChanged()V

    .line 3326
    return-object p0
.end method

.method public clearArg2()Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$IpcMessage$Builder;
    .locals 1

    .prologue
    .line 3403
    sget-object v0, Lcom/google/protobuf/LazyStringArrayList;->EMPTY:Lcom/google/protobuf/LazyStringList;

    iput-object v0, p0, Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$IpcMessage$Builder;->arg2_:Lcom/google/protobuf/LazyStringList;

    .line 3404
    iget v0, p0, Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$IpcMessage$Builder;->bitField0_:I

    and-int/lit8 v0, v0, -0x5

    iput v0, p0, Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$IpcMessage$Builder;->bitField0_:I

    .line 3405
    invoke-virtual {p0}, Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$IpcMessage$Builder;->onChanged()V

    .line 3406
    return-object p0
.end method

.method public clearArg3()Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$IpcMessage$Builder;
    .locals 1

    .prologue
    .line 3482
    invoke-static {}, Ljava/util/Collections;->emptyList()Ljava/util/List;

    move-result-object v0

    iput-object v0, p0, Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$IpcMessage$Builder;->arg3_:Ljava/util/List;

    .line 3483
    iget v0, p0, Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$IpcMessage$Builder;->bitField0_:I

    and-int/lit8 v0, v0, -0x9

    iput v0, p0, Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$IpcMessage$Builder;->bitField0_:I

    .line 3484
    invoke-virtual {p0}, Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$IpcMessage$Builder;->onChanged()V

    .line 3485
    return-object p0
.end method

.method public clearArg4()Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$IpcMessage$Builder;
    .locals 1

    .prologue
    .line 3584
    invoke-static {}, Ljava/util/Collections;->emptyList()Ljava/util/List;

    move-result-object v0

    iput-object v0, p0, Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$IpcMessage$Builder;->arg4_:Ljava/util/List;

    .line 3585
    iget v0, p0, Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$IpcMessage$Builder;->bitField0_:I

    and-int/lit8 v0, v0, -0x21

    iput v0, p0, Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$IpcMessage$Builder;->bitField0_:I

    .line 3586
    invoke-virtual {p0}, Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$IpcMessage$Builder;->onChanged()V

    .line 3587
    return-object p0
.end method

.method public clearClassName()Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$IpcMessage$Builder;
    .locals 1

    .prologue
    .line 3743
    iget v0, p0, Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$IpcMessage$Builder;->bitField0_:I

    and-int/lit16 v0, v0, -0x81

    iput v0, p0, Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$IpcMessage$Builder;->bitField0_:I

    .line 3744
    invoke-static {}, Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$IpcMessage;->getDefaultInstance()Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$IpcMessage;

    move-result-object v0

    invoke-virtual {v0}, Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$IpcMessage;->getClassName()Ljava/lang/String;

    move-result-object v0

    iput-object v0, p0, Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$IpcMessage$Builder;->className_:Ljava/lang/Object;

    .line 3745
    invoke-virtual {p0}, Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$IpcMessage$Builder;->onChanged()V

    .line 3746
    return-object p0
.end method

.method public clearCmd()Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$IpcMessage$Builder;
    .locals 1

    .prologue
    .line 3257
    iget v0, p0, Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$IpcMessage$Builder;->bitField0_:I

    and-int/lit8 v0, v0, -0x2

    iput v0, p0, Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$IpcMessage$Builder;->bitField0_:I

    .line 3258
    const/4 v0, 0x0

    iput v0, p0, Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$IpcMessage$Builder;->cmd_:I

    .line 3259
    invoke-virtual {p0}, Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$IpcMessage$Builder;->onChanged()V

    .line 3260
    return-object p0
.end method

.method public clearEncrypt()Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$IpcMessage$Builder;
    .locals 1

    .prologue
    .line 4248
    iget v0, p0, Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$IpcMessage$Builder;->bitField0_:I

    and-int/lit16 v0, v0, -0x4001

    iput v0, p0, Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$IpcMessage$Builder;->bitField0_:I

    .line 4249
    const/4 v0, 0x0

    iput-boolean v0, p0, Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$IpcMessage$Builder;->encrypt_:Z

    .line 4250
    invoke-virtual {p0}, Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$IpcMessage$Builder;->onChanged()V

    .line 4251
    return-object p0
.end method

.method public clearFileData()Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$IpcMessage$Builder;
    .locals 1

    .prologue
    .line 3518
    iget v0, p0, Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$IpcMessage$Builder;->bitField0_:I

    and-int/lit8 v0, v0, -0x11

    iput v0, p0, Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$IpcMessage$Builder;->bitField0_:I

    .line 3519
    invoke-static {}, Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$IpcMessage;->getDefaultInstance()Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$IpcMessage;

    move-result-object v0

    invoke-virtual {v0}, Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$IpcMessage;->getFileData()Lcom/google/protobuf/ByteString;

    move-result-object v0

    iput-object v0, p0, Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$IpcMessage$Builder;->fileData_:Lcom/google/protobuf/ByteString;

    .line 3520
    invoke-virtual {p0}, Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$IpcMessage$Builder;->onChanged()V

    .line 3521
    return-object p0
.end method

.method public clearIsDebug()Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$IpcMessage$Builder;
    .locals 2

    .prologue
    .line 4281
    iget v0, p0, Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$IpcMessage$Builder;->bitField0_:I

    const v1, -0x8001

    and-int/2addr v0, v1

    iput v0, p0, Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$IpcMessage$Builder;->bitField0_:I

    .line 4282
    const/4 v0, 0x0

    iput-boolean v0, p0, Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$IpcMessage$Builder;->isDebug_:Z

    .line 4283
    invoke-virtual {p0}, Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$IpcMessage$Builder;->onChanged()V

    .line 4284
    return-object p0
.end method

.method public clearIsSyncCall()Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$IpcMessage$Builder;
    .locals 1

    .prologue
    .line 4049
    iget v0, p0, Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$IpcMessage$Builder;->bitField0_:I

    and-int/lit16 v0, v0, -0x801

    iput v0, p0, Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$IpcMessage$Builder;->bitField0_:I

    .line 4050
    const/4 v0, 0x0

    iput-boolean v0, p0, Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$IpcMessage$Builder;->isSyncCall_:Z

    .line 4051
    invoke-virtual {p0}, Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$IpcMessage$Builder;->onChanged()V

    .line 4052
    return-object p0
.end method

.method public clearMethodName()Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$IpcMessage$Builder;
    .locals 1

    .prologue
    .line 3817
    iget v0, p0, Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$IpcMessage$Builder;->bitField0_:I

    and-int/lit16 v0, v0, -0x101

    iput v0, p0, Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$IpcMessage$Builder;->bitField0_:I

    .line 3818
    invoke-static {}, Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$IpcMessage;->getDefaultInstance()Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$IpcMessage;

    move-result-object v0

    invoke-virtual {v0}, Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$IpcMessage;->getMethodName()Ljava/lang/String;

    move-result-object v0

    iput-object v0, p0, Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$IpcMessage$Builder;->methodName_:Ljava/lang/Object;

    .line 3819
    invoke-virtual {p0}, Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$IpcMessage$Builder;->onChanged()V

    .line 3820
    return-object p0
.end method

.method public clearParams()Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$IpcMessage$Builder;
    .locals 1

    .prologue
    .line 4003
    sget-object v0, Lcom/google/protobuf/LazyStringArrayList;->EMPTY:Lcom/google/protobuf/LazyStringList;

    iput-object v0, p0, Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$IpcMessage$Builder;->params_:Lcom/google/protobuf/LazyStringList;

    .line 4004
    iget v0, p0, Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$IpcMessage$Builder;->bitField0_:I

    and-int/lit16 v0, v0, -0x401

    iput v0, p0, Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$IpcMessage$Builder;->bitField0_:I

    .line 4005
    invoke-virtual {p0}, Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$IpcMessage$Builder;->onChanged()V

    .line 4006
    return-object p0
.end method

.method public clearPkgName()Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$IpcMessage$Builder;
    .locals 1

    .prologue
    .line 3665
    iget v0, p0, Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$IpcMessage$Builder;->bitField0_:I

    and-int/lit8 v0, v0, -0x41

    iput v0, p0, Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$IpcMessage$Builder;->bitField0_:I

    .line 3666
    invoke-static {}, Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$IpcMessage;->getDefaultInstance()Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$IpcMessage;

    move-result-object v0

    invoke-virtual {v0}, Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$IpcMessage;->getPkgName()Ljava/lang/String;

    move-result-object v0

    iput-object v0, p0, Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$IpcMessage$Builder;->pkgName_:Ljava/lang/Object;

    .line 3667
    invoke-virtual {p0}, Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$IpcMessage$Builder;->onChanged()V

    .line 3668
    return-object p0
.end method

.method public clearRetValue()Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$IpcMessage$Builder;
    .locals 1

    .prologue
    .line 4161
    iget-object v0, p0, Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$IpcMessage$Builder;->retValueBuilder_:Lcom/google/protobuf/SingleFieldBuilder;

    if-nez v0, :cond_0

    .line 4162
    invoke-static {}, Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$ReturnValue;->getDefaultInstance()Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$ReturnValue;

    move-result-object v0

    iput-object v0, p0, Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$IpcMessage$Builder;->retValue_:Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$ReturnValue;

    .line 4163
    invoke-virtual {p0}, Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$IpcMessage$Builder;->onChanged()V

    .line 4167
    :goto_0
    iget v0, p0, Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$IpcMessage$Builder;->bitField0_:I

    and-int/lit16 v0, v0, -0x2001

    iput v0, p0, Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$IpcMessage$Builder;->bitField0_:I

    .line 4168
    return-object p0

    .line 4165
    :cond_0
    iget-object v0, p0, Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$IpcMessage$Builder;->retValueBuilder_:Lcom/google/protobuf/SingleFieldBuilder;

    invoke-virtual {v0}, Lcom/google/protobuf/SingleFieldBuilder;->clear()Lcom/google/protobuf/SingleFieldBuilder;

    goto :goto_0
.end method

.method public clearTypes()Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$IpcMessage$Builder;
    .locals 1

    .prologue
    .line 3910
    sget-object v0, Lcom/google/protobuf/LazyStringArrayList;->EMPTY:Lcom/google/protobuf/LazyStringList;

    iput-object v0, p0, Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$IpcMessage$Builder;->types_:Lcom/google/protobuf/LazyStringList;

    .line 3911
    iget v0, p0, Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$IpcMessage$Builder;->bitField0_:I

    and-int/lit16 v0, v0, -0x201

    iput v0, p0, Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$IpcMessage$Builder;->bitField0_:I

    .line 3912
    invoke-virtual {p0}, Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$IpcMessage$Builder;->onChanged()V

    .line 3913
    return-object p0
.end method

.method public clearWaitId()Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$IpcMessage$Builder;
    .locals 1

    .prologue
    .line 4082
    iget v0, p0, Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$IpcMessage$Builder;->bitField0_:I

    and-int/lit16 v0, v0, -0x1001

    iput v0, p0, Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$IpcMessage$Builder;->bitField0_:I

    .line 4083
    const/4 v0, 0x0

    iput v0, p0, Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$IpcMessage$Builder;->waitId_:I

    .line 4084
    invoke-virtual {p0}, Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$IpcMessage$Builder;->onChanged()V

    .line 4085
    return-object p0
.end method

.method public clone()Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$IpcMessage$Builder;
    .locals 2

    .prologue
    .line 2990
    invoke-static {}, Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$IpcMessage$Builder;->create()Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$IpcMessage$Builder;

    move-result-object v0

    invoke-virtual {p0}, Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$IpcMessage$Builder;->buildPartial()Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$IpcMessage;

    move-result-object v1

    invoke-virtual {v0, v1}, Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$IpcMessage$Builder;->mergeFrom(Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$IpcMessage;)Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$IpcMessage$Builder;

    move-result-object v0

    return-object v0
.end method

.method public bridge synthetic clone()Lcom/google/protobuf/AbstractMessage$Builder;
    .locals 1

    .prologue
    .line 2914
    invoke-virtual {p0}, Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$IpcMessage$Builder;->clone()Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$IpcMessage$Builder;

    move-result-object v0

    return-object v0
.end method

.method public bridge synthetic clone()Lcom/google/protobuf/AbstractMessageLite$Builder;
    .locals 1

    .prologue
    .line 2914
    invoke-virtual {p0}, Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$IpcMessage$Builder;->clone()Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$IpcMessage$Builder;

    move-result-object v0

    return-object v0
.end method

.method public bridge synthetic clone()Lcom/google/protobuf/GeneratedMessage$Builder;
    .locals 1

    .prologue
    .line 2914
    invoke-virtual {p0}, Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$IpcMessage$Builder;->clone()Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$IpcMessage$Builder;

    move-result-object v0

    return-object v0
.end method

.method public bridge synthetic clone()Lcom/google/protobuf/Message$Builder;
    .locals 1

    .prologue
    .line 2914
    invoke-virtual {p0}, Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$IpcMessage$Builder;->clone()Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$IpcMessage$Builder;

    move-result-object v0

    return-object v0
.end method

.method public bridge synthetic clone()Lcom/google/protobuf/MessageLite$Builder;
    .locals 1

    .prologue
    .line 2914
    invoke-virtual {p0}, Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$IpcMessage$Builder;->clone()Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$IpcMessage$Builder;

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
    .line 2914
    invoke-virtual {p0}, Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$IpcMessage$Builder;->clone()Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$IpcMessage$Builder;

    move-result-object v0

    return-object v0
.end method

.method public getArg1(I)I
    .locals 1

    .prologue
    .line 3288
    iget-object v0, p0, Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$IpcMessage$Builder;->arg1_:Ljava/util/List;

    invoke-interface {v0, p1}, Ljava/util/List;->get(I)Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Ljava/lang/Integer;

    invoke-virtual {v0}, Ljava/lang/Integer;->intValue()I

    move-result v0

    return v0
.end method

.method public getArg1Count()I
    .locals 1

    .prologue
    .line 3282
    iget-object v0, p0, Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$IpcMessage$Builder;->arg1_:Ljava/util/List;

    invoke-interface {v0}, Ljava/util/List;->size()I

    move-result v0

    return v0
.end method

.method public getArg1List()Ljava/util/List;
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
    .line 3276
    iget-object v0, p0, Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$IpcMessage$Builder;->arg1_:Ljava/util/List;

    invoke-static {v0}, Ljava/util/Collections;->unmodifiableList(Ljava/util/List;)Ljava/util/List;

    move-result-object v0

    return-object v0
.end method

.method public getArg2(I)Ljava/lang/String;
    .locals 1

    .prologue
    .line 3354
    iget-object v0, p0, Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$IpcMessage$Builder;->arg2_:Lcom/google/protobuf/LazyStringList;

    invoke-interface {v0, p1}, Lcom/google/protobuf/LazyStringList;->get(I)Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Ljava/lang/String;

    return-object v0
.end method

.method public getArg2Bytes(I)Lcom/google/protobuf/ByteString;
    .locals 1

    .prologue
    .line 3361
    iget-object v0, p0, Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$IpcMessage$Builder;->arg2_:Lcom/google/protobuf/LazyStringList;

    invoke-interface {v0, p1}, Lcom/google/protobuf/LazyStringList;->getByteString(I)Lcom/google/protobuf/ByteString;

    move-result-object v0

    return-object v0
.end method

.method public getArg2Count()I
    .locals 1

    .prologue
    .line 3348
    iget-object v0, p0, Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$IpcMessage$Builder;->arg2_:Lcom/google/protobuf/LazyStringList;

    invoke-interface {v0}, Lcom/google/protobuf/LazyStringList;->size()I

    move-result v0

    return v0
.end method

.method public getArg2List()Ljava/util/List;
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
    .line 3342
    iget-object v0, p0, Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$IpcMessage$Builder;->arg2_:Lcom/google/protobuf/LazyStringList;

    invoke-static {v0}, Ljava/util/Collections;->unmodifiableList(Ljava/util/List;)Ljava/util/List;

    move-result-object v0

    return-object v0
.end method

.method public getArg3(I)F
    .locals 1

    .prologue
    .line 3447
    iget-object v0, p0, Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$IpcMessage$Builder;->arg3_:Ljava/util/List;

    invoke-interface {v0, p1}, Ljava/util/List;->get(I)Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Ljava/lang/Float;

    invoke-virtual {v0}, Ljava/lang/Float;->floatValue()F

    move-result v0

    return v0
.end method

.method public getArg3Count()I
    .locals 1

    .prologue
    .line 3441
    iget-object v0, p0, Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$IpcMessage$Builder;->arg3_:Ljava/util/List;

    invoke-interface {v0}, Ljava/util/List;->size()I

    move-result v0

    return v0
.end method

.method public getArg3List()Ljava/util/List;
    .locals 1
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "()",
            "Ljava/util/List",
            "<",
            "Ljava/lang/Float;",
            ">;"
        }
    .end annotation

    .prologue
    .line 3435
    iget-object v0, p0, Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$IpcMessage$Builder;->arg3_:Ljava/util/List;

    invoke-static {v0}, Ljava/util/Collections;->unmodifiableList(Ljava/util/List;)Ljava/util/List;

    move-result-object v0

    return-object v0
.end method

.method public getArg4(I)J
    .locals 2

    .prologue
    .line 3549
    iget-object v0, p0, Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$IpcMessage$Builder;->arg4_:Ljava/util/List;

    invoke-interface {v0, p1}, Ljava/util/List;->get(I)Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Ljava/lang/Long;

    invoke-virtual {v0}, Ljava/lang/Long;->longValue()J

    move-result-wide v0

    return-wide v0
.end method

.method public getArg4Count()I
    .locals 1

    .prologue
    .line 3543
    iget-object v0, p0, Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$IpcMessage$Builder;->arg4_:Ljava/util/List;

    invoke-interface {v0}, Ljava/util/List;->size()I

    move-result v0

    return v0
.end method

.method public getArg4List()Ljava/util/List;
    .locals 1
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "()",
            "Ljava/util/List",
            "<",
            "Ljava/lang/Long;",
            ">;"
        }
    .end annotation

    .prologue
    .line 3537
    iget-object v0, p0, Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$IpcMessage$Builder;->arg4_:Ljava/util/List;

    invoke-static {v0}, Ljava/util/Collections;->unmodifiableList(Ljava/util/List;)Ljava/util/List;

    move-result-object v0

    return-object v0
.end method

.method public getClassName()Ljava/lang/String;
    .locals 2

    .prologue
    .line 3700
    iget-object v0, p0, Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$IpcMessage$Builder;->className_:Ljava/lang/Object;

    .line 3701
    instance-of v1, v0, Ljava/lang/String;

    if-nez v1, :cond_0

    .line 3702
    check-cast v0, Lcom/google/protobuf/ByteString;

    .line 3703
    invoke-virtual {v0}, Lcom/google/protobuf/ByteString;->toStringUtf8()Ljava/lang/String;

    move-result-object v0

    .line 3704
    iput-object v0, p0, Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$IpcMessage$Builder;->className_:Ljava/lang/Object;

    .line 3707
    :goto_0
    return-object v0

    :cond_0
    check-cast v0, Ljava/lang/String;

    goto :goto_0
.end method

.method public getClassNameBytes()Lcom/google/protobuf/ByteString;
    .locals 2

    .prologue
    .line 3715
    iget-object v0, p0, Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$IpcMessage$Builder;->className_:Ljava/lang/Object;

    .line 3716
    instance-of v1, v0, Ljava/lang/String;

    if-eqz v1, :cond_0

    .line 3717
    check-cast v0, Ljava/lang/String;

    .line 3718
    invoke-static {v0}, Lcom/google/protobuf/ByteString;->copyFromUtf8(Ljava/lang/String;)Lcom/google/protobuf/ByteString;

    move-result-object v0

    .line 3720
    iput-object v0, p0, Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$IpcMessage$Builder;->className_:Ljava/lang/Object;

    .line 3723
    :goto_0
    return-object v0

    :cond_0
    check-cast v0, Lcom/google/protobuf/ByteString;

    goto :goto_0
.end method

.method public getCmd()I
    .locals 1

    .prologue
    .line 3242
    iget v0, p0, Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$IpcMessage$Builder;->cmd_:I

    return v0
.end method

.method public getDefaultInstanceForType()Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$IpcMessage;
    .locals 1

    .prologue
    .line 2999
    invoke-static {}, Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$IpcMessage;->getDefaultInstance()Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$IpcMessage;

    move-result-object v0

    return-object v0
.end method

.method public bridge synthetic getDefaultInstanceForType()Lcom/google/protobuf/Message;
    .locals 1

    .prologue
    .line 2914
    invoke-virtual {p0}, Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$IpcMessage$Builder;->getDefaultInstanceForType()Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$IpcMessage;

    move-result-object v0

    return-object v0
.end method

.method public bridge synthetic getDefaultInstanceForType()Lcom/google/protobuf/MessageLite;
    .locals 1

    .prologue
    .line 2914
    invoke-virtual {p0}, Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$IpcMessage$Builder;->getDefaultInstanceForType()Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$IpcMessage;

    move-result-object v0

    return-object v0
.end method

.method public getDescriptorForType()Lcom/google/protobuf/Descriptors$Descriptor;
    .locals 1

    .prologue
    .line 2995
    invoke-static {}, Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc;->access$2500()Lcom/google/protobuf/Descriptors$Descriptor;

    move-result-object v0

    return-object v0
.end method

.method public getEncrypt()Z
    .locals 1

    .prologue
    .line 4225
    iget-boolean v0, p0, Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$IpcMessage$Builder;->encrypt_:Z

    return v0
.end method

.method public getFileData()Lcom/google/protobuf/ByteString;
    .locals 1

    .prologue
    .line 3500
    iget-object v0, p0, Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$IpcMessage$Builder;->fileData_:Lcom/google/protobuf/ByteString;

    return-object v0
.end method

.method public getIsDebug()Z
    .locals 1

    .prologue
    .line 4266
    iget-boolean v0, p0, Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$IpcMessage$Builder;->isDebug_:Z

    return v0
.end method

.method public getIsSyncCall()Z
    .locals 1

    .prologue
    .line 4034
    iget-boolean v0, p0, Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$IpcMessage$Builder;->isSyncCall_:Z

    return v0
.end method

.method public getMethodName()Ljava/lang/String;
    .locals 2

    .prologue
    .line 3774
    iget-object v0, p0, Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$IpcMessage$Builder;->methodName_:Ljava/lang/Object;

    .line 3775
    instance-of v1, v0, Ljava/lang/String;

    if-nez v1, :cond_0

    .line 3776
    check-cast v0, Lcom/google/protobuf/ByteString;

    .line 3777
    invoke-virtual {v0}, Lcom/google/protobuf/ByteString;->toStringUtf8()Ljava/lang/String;

    move-result-object v0

    .line 3778
    iput-object v0, p0, Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$IpcMessage$Builder;->methodName_:Ljava/lang/Object;

    .line 3781
    :goto_0
    return-object v0

    :cond_0
    check-cast v0, Ljava/lang/String;

    goto :goto_0
.end method

.method public getMethodNameBytes()Lcom/google/protobuf/ByteString;
    .locals 2

    .prologue
    .line 3789
    iget-object v0, p0, Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$IpcMessage$Builder;->methodName_:Ljava/lang/Object;

    .line 3790
    instance-of v1, v0, Ljava/lang/String;

    if-eqz v1, :cond_0

    .line 3791
    check-cast v0, Ljava/lang/String;

    .line 3792
    invoke-static {v0}, Lcom/google/protobuf/ByteString;->copyFromUtf8(Ljava/lang/String;)Lcom/google/protobuf/ByteString;

    move-result-object v0

    .line 3794
    iput-object v0, p0, Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$IpcMessage$Builder;->methodName_:Ljava/lang/Object;

    .line 3797
    :goto_0
    return-object v0

    :cond_0
    check-cast v0, Lcom/google/protobuf/ByteString;

    goto :goto_0
.end method

.method public getParams(I)Ljava/lang/String;
    .locals 1

    .prologue
    .line 3954
    iget-object v0, p0, Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$IpcMessage$Builder;->params_:Lcom/google/protobuf/LazyStringList;

    invoke-interface {v0, p1}, Lcom/google/protobuf/LazyStringList;->get(I)Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Ljava/lang/String;

    return-object v0
.end method

.method public getParamsBytes(I)Lcom/google/protobuf/ByteString;
    .locals 1

    .prologue
    .line 3961
    iget-object v0, p0, Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$IpcMessage$Builder;->params_:Lcom/google/protobuf/LazyStringList;

    invoke-interface {v0, p1}, Lcom/google/protobuf/LazyStringList;->getByteString(I)Lcom/google/protobuf/ByteString;

    move-result-object v0

    return-object v0
.end method

.method public getParamsCount()I
    .locals 1

    .prologue
    .line 3948
    iget-object v0, p0, Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$IpcMessage$Builder;->params_:Lcom/google/protobuf/LazyStringList;

    invoke-interface {v0}, Lcom/google/protobuf/LazyStringList;->size()I

    move-result v0

    return v0
.end method

.method public getParamsList()Ljava/util/List;
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
    .line 3942
    iget-object v0, p0, Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$IpcMessage$Builder;->params_:Lcom/google/protobuf/LazyStringList;

    invoke-static {v0}, Ljava/util/Collections;->unmodifiableList(Ljava/util/List;)Ljava/util/List;

    move-result-object v0

    return-object v0
.end method

.method public getPkgName()Ljava/lang/String;
    .locals 2

    .prologue
    .line 3610
    iget-object v0, p0, Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$IpcMessage$Builder;->pkgName_:Ljava/lang/Object;

    .line 3611
    instance-of v1, v0, Ljava/lang/String;

    if-nez v1, :cond_0

    .line 3612
    check-cast v0, Lcom/google/protobuf/ByteString;

    .line 3613
    invoke-virtual {v0}, Lcom/google/protobuf/ByteString;->toStringUtf8()Ljava/lang/String;

    move-result-object v0

    .line 3614
    iput-object v0, p0, Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$IpcMessage$Builder;->pkgName_:Ljava/lang/Object;

    .line 3617
    :goto_0
    return-object v0

    :cond_0
    check-cast v0, Ljava/lang/String;

    goto :goto_0
.end method

.method public getPkgNameBytes()Lcom/google/protobuf/ByteString;
    .locals 2

    .prologue
    .line 3629
    iget-object v0, p0, Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$IpcMessage$Builder;->pkgName_:Ljava/lang/Object;

    .line 3630
    instance-of v1, v0, Ljava/lang/String;

    if-eqz v1, :cond_0

    .line 3631
    check-cast v0, Ljava/lang/String;

    .line 3632
    invoke-static {v0}, Lcom/google/protobuf/ByteString;->copyFromUtf8(Ljava/lang/String;)Lcom/google/protobuf/ByteString;

    move-result-object v0

    .line 3634
    iput-object v0, p0, Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$IpcMessage$Builder;->pkgName_:Ljava/lang/Object;

    .line 3637
    :goto_0
    return-object v0

    :cond_0
    check-cast v0, Lcom/google/protobuf/ByteString;

    goto :goto_0
.end method

.method public getRetValue()Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$ReturnValue;
    .locals 1

    .prologue
    .line 4102
    iget-object v0, p0, Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$IpcMessage$Builder;->retValueBuilder_:Lcom/google/protobuf/SingleFieldBuilder;

    if-nez v0, :cond_0

    .line 4103
    iget-object v0, p0, Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$IpcMessage$Builder;->retValue_:Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$ReturnValue;

    .line 4105
    :goto_0
    return-object v0

    :cond_0
    iget-object v0, p0, Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$IpcMessage$Builder;->retValueBuilder_:Lcom/google/protobuf/SingleFieldBuilder;

    invoke-virtual {v0}, Lcom/google/protobuf/SingleFieldBuilder;->getMessage()Lcom/google/protobuf/GeneratedMessage;

    move-result-object v0

    check-cast v0, Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$ReturnValue;

    goto :goto_0
.end method

.method public getRetValueBuilder()Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$ReturnValue$Builder;
    .locals 1

    .prologue
    .line 4174
    iget v0, p0, Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$IpcMessage$Builder;->bitField0_:I

    or-int/lit16 v0, v0, 0x2000

    iput v0, p0, Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$IpcMessage$Builder;->bitField0_:I

    .line 4175
    invoke-virtual {p0}, Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$IpcMessage$Builder;->onChanged()V

    .line 4176
    invoke-direct {p0}, Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$IpcMessage$Builder;->getRetValueFieldBuilder()Lcom/google/protobuf/SingleFieldBuilder;

    move-result-object v0

    invoke-virtual {v0}, Lcom/google/protobuf/SingleFieldBuilder;->getBuilder()Lcom/google/protobuf/GeneratedMessage$Builder;

    move-result-object v0

    check-cast v0, Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$ReturnValue$Builder;

    return-object v0
.end method

.method public getRetValueOrBuilder()Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$ReturnValueOrBuilder;
    .locals 1

    .prologue
    .line 4182
    iget-object v0, p0, Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$IpcMessage$Builder;->retValueBuilder_:Lcom/google/protobuf/SingleFieldBuilder;

    if-eqz v0, :cond_0

    .line 4183
    iget-object v0, p0, Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$IpcMessage$Builder;->retValueBuilder_:Lcom/google/protobuf/SingleFieldBuilder;

    invoke-virtual {v0}, Lcom/google/protobuf/SingleFieldBuilder;->getMessageOrBuilder()Lcom/google/protobuf/MessageOrBuilder;

    move-result-object v0

    check-cast v0, Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$ReturnValueOrBuilder;

    .line 4185
    :goto_0
    return-object v0

    :cond_0
    iget-object v0, p0, Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$IpcMessage$Builder;->retValue_:Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$ReturnValue;

    goto :goto_0
.end method

.method public getTypes(I)Ljava/lang/String;
    .locals 1

    .prologue
    .line 3861
    iget-object v0, p0, Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$IpcMessage$Builder;->types_:Lcom/google/protobuf/LazyStringList;

    invoke-interface {v0, p1}, Lcom/google/protobuf/LazyStringList;->get(I)Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Ljava/lang/String;

    return-object v0
.end method

.method public getTypesBytes(I)Lcom/google/protobuf/ByteString;
    .locals 1

    .prologue
    .line 3868
    iget-object v0, p0, Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$IpcMessage$Builder;->types_:Lcom/google/protobuf/LazyStringList;

    invoke-interface {v0, p1}, Lcom/google/protobuf/LazyStringList;->getByteString(I)Lcom/google/protobuf/ByteString;

    move-result-object v0

    return-object v0
.end method

.method public getTypesCount()I
    .locals 1

    .prologue
    .line 3855
    iget-object v0, p0, Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$IpcMessage$Builder;->types_:Lcom/google/protobuf/LazyStringList;

    invoke-interface {v0}, Lcom/google/protobuf/LazyStringList;->size()I

    move-result v0

    return v0
.end method

.method public getTypesList()Ljava/util/List;
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
    .line 3849
    iget-object v0, p0, Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$IpcMessage$Builder;->types_:Lcom/google/protobuf/LazyStringList;

    invoke-static {v0}, Ljava/util/Collections;->unmodifiableList(Ljava/util/List;)Ljava/util/List;

    move-result-object v0

    return-object v0
.end method

.method public getWaitId()I
    .locals 1

    .prologue
    .line 4067
    iget v0, p0, Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$IpcMessage$Builder;->waitId_:I

    return v0
.end method

.method public hasClassName()Z
    .locals 2

    .prologue
    .line 3694
    iget v0, p0, Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$IpcMessage$Builder;->bitField0_:I

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

.method public hasCmd()Z
    .locals 2

    .prologue
    const/4 v0, 0x1

    .line 3236
    iget v1, p0, Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$IpcMessage$Builder;->bitField0_:I

    and-int/lit8 v1, v1, 0x1

    if-ne v1, v0, :cond_0

    :goto_0
    return v0

    :cond_0
    const/4 v0, 0x0

    goto :goto_0
.end method

.method public hasEncrypt()Z
    .locals 2

    .prologue
    .line 4215
    iget v0, p0, Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$IpcMessage$Builder;->bitField0_:I

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

.method public hasFileData()Z
    .locals 2

    .prologue
    .line 3494
    iget v0, p0, Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$IpcMessage$Builder;->bitField0_:I

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

.method public hasIsDebug()Z
    .locals 2

    .prologue
    const v1, 0x8000

    .line 4260
    iget v0, p0, Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$IpcMessage$Builder;->bitField0_:I

    and-int/2addr v0, v1

    if-ne v0, v1, :cond_0

    const/4 v0, 0x1

    :goto_0
    return v0

    :cond_0
    const/4 v0, 0x0

    goto :goto_0
.end method

.method public hasIsSyncCall()Z
    .locals 2

    .prologue
    .line 4028
    iget v0, p0, Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$IpcMessage$Builder;->bitField0_:I

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

.method public hasMethodName()Z
    .locals 2

    .prologue
    .line 3768
    iget v0, p0, Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$IpcMessage$Builder;->bitField0_:I

    and-int/lit16 v0, v0, 0x100

    const/16 v1, 0x100

    if-ne v0, v1, :cond_0

    const/4 v0, 0x1

    :goto_0
    return v0

    :cond_0
    const/4 v0, 0x0

    goto :goto_0
.end method

.method public hasPkgName()Z
    .locals 2

    .prologue
    .line 3600
    iget v0, p0, Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$IpcMessage$Builder;->bitField0_:I

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

.method public hasRetValue()Z
    .locals 2

    .prologue
    .line 4096
    iget v0, p0, Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$IpcMessage$Builder;->bitField0_:I

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

.method public hasWaitId()Z
    .locals 2

    .prologue
    .line 4061
    iget v0, p0, Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$IpcMessage$Builder;->bitField0_:I

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

.method protected internalGetFieldAccessorTable()Lcom/google/protobuf/GeneratedMessage$FieldAccessorTable;
    .locals 3

    .prologue
    .line 2924
    invoke-static {}, Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc;->access$2600()Lcom/google/protobuf/GeneratedMessage$FieldAccessorTable;

    move-result-object v0

    const-class v1, Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$IpcMessage;

    const-class v2, Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$IpcMessage$Builder;

    .line 2925
    invoke-virtual {v0, v1, v2}, Lcom/google/protobuf/GeneratedMessage$FieldAccessorTable;->ensureFieldAccessorsInitialized(Ljava/lang/Class;Ljava/lang/Class;)Lcom/google/protobuf/GeneratedMessage$FieldAccessorTable;

    move-result-object v0

    .line 2924
    return-object v0
.end method

.method public final isInitialized()Z
    .locals 1

    .prologue
    .line 3208
    const/4 v0, 0x1

    return v0
.end method

.method public mergeFrom(Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$IpcMessage;)Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$IpcMessage$Builder;
    .locals 2

    .prologue
    .line 3106
    invoke-static {}, Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$IpcMessage;->getDefaultInstance()Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$IpcMessage;

    move-result-object v0

    if-ne p1, v0, :cond_0

    .line 3204
    :goto_0
    return-object p0

    .line 3107
    :cond_0
    invoke-virtual {p1}, Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$IpcMessage;->hasCmd()Z

    move-result v0

    if-eqz v0, :cond_1

    .line 3108
    invoke-virtual {p1}, Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$IpcMessage;->getCmd()I

    move-result v0

    invoke-virtual {p0, v0}, Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$IpcMessage$Builder;->setCmd(I)Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$IpcMessage$Builder;

    .line 3110
    :cond_1
    invoke-static {p1}, Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$IpcMessage;->access$3300(Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$IpcMessage;)Ljava/util/List;

    move-result-object v0

    invoke-interface {v0}, Ljava/util/List;->isEmpty()Z

    move-result v0

    if-nez v0, :cond_2

    .line 3111
    iget-object v0, p0, Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$IpcMessage$Builder;->arg1_:Ljava/util/List;

    invoke-interface {v0}, Ljava/util/List;->isEmpty()Z

    move-result v0

    if-eqz v0, :cond_11

    .line 3112
    invoke-static {p1}, Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$IpcMessage;->access$3300(Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$IpcMessage;)Ljava/util/List;

    move-result-object v0

    iput-object v0, p0, Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$IpcMessage$Builder;->arg1_:Ljava/util/List;

    .line 3113
    iget v0, p0, Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$IpcMessage$Builder;->bitField0_:I

    and-int/lit8 v0, v0, -0x3

    iput v0, p0, Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$IpcMessage$Builder;->bitField0_:I

    .line 3118
    :goto_1
    invoke-virtual {p0}, Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$IpcMessage$Builder;->onChanged()V

    .line 3120
    :cond_2
    invoke-static {p1}, Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$IpcMessage;->access$3400(Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$IpcMessage;)Lcom/google/protobuf/LazyStringList;

    move-result-object v0

    invoke-interface {v0}, Lcom/google/protobuf/LazyStringList;->isEmpty()Z

    move-result v0

    if-nez v0, :cond_3

    .line 3121
    iget-object v0, p0, Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$IpcMessage$Builder;->arg2_:Lcom/google/protobuf/LazyStringList;

    invoke-interface {v0}, Lcom/google/protobuf/LazyStringList;->isEmpty()Z

    move-result v0

    if-eqz v0, :cond_12

    .line 3122
    invoke-static {p1}, Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$IpcMessage;->access$3400(Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$IpcMessage;)Lcom/google/protobuf/LazyStringList;

    move-result-object v0

    iput-object v0, p0, Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$IpcMessage$Builder;->arg2_:Lcom/google/protobuf/LazyStringList;

    .line 3123
    iget v0, p0, Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$IpcMessage$Builder;->bitField0_:I

    and-int/lit8 v0, v0, -0x5

    iput v0, p0, Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$IpcMessage$Builder;->bitField0_:I

    .line 3128
    :goto_2
    invoke-virtual {p0}, Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$IpcMessage$Builder;->onChanged()V

    .line 3130
    :cond_3
    invoke-static {p1}, Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$IpcMessage;->access$3500(Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$IpcMessage;)Ljava/util/List;

    move-result-object v0

    invoke-interface {v0}, Ljava/util/List;->isEmpty()Z

    move-result v0

    if-nez v0, :cond_4

    .line 3131
    iget-object v0, p0, Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$IpcMessage$Builder;->arg3_:Ljava/util/List;

    invoke-interface {v0}, Ljava/util/List;->isEmpty()Z

    move-result v0

    if-eqz v0, :cond_13

    .line 3132
    invoke-static {p1}, Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$IpcMessage;->access$3500(Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$IpcMessage;)Ljava/util/List;

    move-result-object v0

    iput-object v0, p0, Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$IpcMessage$Builder;->arg3_:Ljava/util/List;

    .line 3133
    iget v0, p0, Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$IpcMessage$Builder;->bitField0_:I

    and-int/lit8 v0, v0, -0x9

    iput v0, p0, Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$IpcMessage$Builder;->bitField0_:I

    .line 3138
    :goto_3
    invoke-virtual {p0}, Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$IpcMessage$Builder;->onChanged()V

    .line 3140
    :cond_4
    invoke-virtual {p1}, Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$IpcMessage;->hasFileData()Z

    move-result v0

    if-eqz v0, :cond_5

    .line 3141
    invoke-virtual {p1}, Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$IpcMessage;->getFileData()Lcom/google/protobuf/ByteString;

    move-result-object v0

    invoke-virtual {p0, v0}, Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$IpcMessage$Builder;->setFileData(Lcom/google/protobuf/ByteString;)Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$IpcMessage$Builder;

    .line 3143
    :cond_5
    invoke-static {p1}, Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$IpcMessage;->access$3700(Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$IpcMessage;)Ljava/util/List;

    move-result-object v0

    invoke-interface {v0}, Ljava/util/List;->isEmpty()Z

    move-result v0

    if-nez v0, :cond_6

    .line 3144
    iget-object v0, p0, Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$IpcMessage$Builder;->arg4_:Ljava/util/List;

    invoke-interface {v0}, Ljava/util/List;->isEmpty()Z

    move-result v0

    if-eqz v0, :cond_14

    .line 3145
    invoke-static {p1}, Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$IpcMessage;->access$3700(Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$IpcMessage;)Ljava/util/List;

    move-result-object v0

    iput-object v0, p0, Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$IpcMessage$Builder;->arg4_:Ljava/util/List;

    .line 3146
    iget v0, p0, Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$IpcMessage$Builder;->bitField0_:I

    and-int/lit8 v0, v0, -0x21

    iput v0, p0, Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$IpcMessage$Builder;->bitField0_:I

    .line 3151
    :goto_4
    invoke-virtual {p0}, Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$IpcMessage$Builder;->onChanged()V

    .line 3153
    :cond_6
    invoke-virtual {p1}, Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$IpcMessage;->hasPkgName()Z

    move-result v0

    if-eqz v0, :cond_7

    .line 3154
    iget v0, p0, Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$IpcMessage$Builder;->bitField0_:I

    or-int/lit8 v0, v0, 0x40

    iput v0, p0, Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$IpcMessage$Builder;->bitField0_:I

    .line 3155
    invoke-static {p1}, Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$IpcMessage;->access$3800(Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$IpcMessage;)Ljava/lang/Object;

    move-result-object v0

    iput-object v0, p0, Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$IpcMessage$Builder;->pkgName_:Ljava/lang/Object;

    .line 3156
    invoke-virtual {p0}, Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$IpcMessage$Builder;->onChanged()V

    .line 3158
    :cond_7
    invoke-virtual {p1}, Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$IpcMessage;->hasClassName()Z

    move-result v0

    if-eqz v0, :cond_8

    .line 3159
    iget v0, p0, Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$IpcMessage$Builder;->bitField0_:I

    or-int/lit16 v0, v0, 0x80

    iput v0, p0, Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$IpcMessage$Builder;->bitField0_:I

    .line 3160
    invoke-static {p1}, Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$IpcMessage;->access$3900(Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$IpcMessage;)Ljava/lang/Object;

    move-result-object v0

    iput-object v0, p0, Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$IpcMessage$Builder;->className_:Ljava/lang/Object;

    .line 3161
    invoke-virtual {p0}, Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$IpcMessage$Builder;->onChanged()V

    .line 3163
    :cond_8
    invoke-virtual {p1}, Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$IpcMessage;->hasMethodName()Z

    move-result v0

    if-eqz v0, :cond_9

    .line 3164
    iget v0, p0, Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$IpcMessage$Builder;->bitField0_:I

    or-int/lit16 v0, v0, 0x100

    iput v0, p0, Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$IpcMessage$Builder;->bitField0_:I

    .line 3165
    invoke-static {p1}, Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$IpcMessage;->access$4000(Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$IpcMessage;)Ljava/lang/Object;

    move-result-object v0

    iput-object v0, p0, Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$IpcMessage$Builder;->methodName_:Ljava/lang/Object;

    .line 3166
    invoke-virtual {p0}, Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$IpcMessage$Builder;->onChanged()V

    .line 3168
    :cond_9
    invoke-static {p1}, Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$IpcMessage;->access$4100(Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$IpcMessage;)Lcom/google/protobuf/LazyStringList;

    move-result-object v0

    invoke-interface {v0}, Lcom/google/protobuf/LazyStringList;->isEmpty()Z

    move-result v0

    if-nez v0, :cond_a

    .line 3169
    iget-object v0, p0, Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$IpcMessage$Builder;->types_:Lcom/google/protobuf/LazyStringList;

    invoke-interface {v0}, Lcom/google/protobuf/LazyStringList;->isEmpty()Z

    move-result v0

    if-eqz v0, :cond_15

    .line 3170
    invoke-static {p1}, Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$IpcMessage;->access$4100(Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$IpcMessage;)Lcom/google/protobuf/LazyStringList;

    move-result-object v0

    iput-object v0, p0, Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$IpcMessage$Builder;->types_:Lcom/google/protobuf/LazyStringList;

    .line 3171
    iget v0, p0, Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$IpcMessage$Builder;->bitField0_:I

    and-int/lit16 v0, v0, -0x201

    iput v0, p0, Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$IpcMessage$Builder;->bitField0_:I

    .line 3176
    :goto_5
    invoke-virtual {p0}, Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$IpcMessage$Builder;->onChanged()V

    .line 3178
    :cond_a
    invoke-static {p1}, Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$IpcMessage;->access$4200(Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$IpcMessage;)Lcom/google/protobuf/LazyStringList;

    move-result-object v0

    invoke-interface {v0}, Lcom/google/protobuf/LazyStringList;->isEmpty()Z

    move-result v0

    if-nez v0, :cond_b

    .line 3179
    iget-object v0, p0, Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$IpcMessage$Builder;->params_:Lcom/google/protobuf/LazyStringList;

    invoke-interface {v0}, Lcom/google/protobuf/LazyStringList;->isEmpty()Z

    move-result v0

    if-eqz v0, :cond_16

    .line 3180
    invoke-static {p1}, Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$IpcMessage;->access$4200(Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$IpcMessage;)Lcom/google/protobuf/LazyStringList;

    move-result-object v0

    iput-object v0, p0, Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$IpcMessage$Builder;->params_:Lcom/google/protobuf/LazyStringList;

    .line 3181
    iget v0, p0, Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$IpcMessage$Builder;->bitField0_:I

    and-int/lit16 v0, v0, -0x401

    iput v0, p0, Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$IpcMessage$Builder;->bitField0_:I

    .line 3186
    :goto_6
    invoke-virtual {p0}, Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$IpcMessage$Builder;->onChanged()V

    .line 3188
    :cond_b
    invoke-virtual {p1}, Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$IpcMessage;->hasIsSyncCall()Z

    move-result v0

    if-eqz v0, :cond_c

    .line 3189
    invoke-virtual {p1}, Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$IpcMessage;->getIsSyncCall()Z

    move-result v0

    invoke-virtual {p0, v0}, Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$IpcMessage$Builder;->setIsSyncCall(Z)Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$IpcMessage$Builder;

    .line 3191
    :cond_c
    invoke-virtual {p1}, Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$IpcMessage;->hasWaitId()Z

    move-result v0

    if-eqz v0, :cond_d

    .line 3192
    invoke-virtual {p1}, Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$IpcMessage;->getWaitId()I

    move-result v0

    invoke-virtual {p0, v0}, Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$IpcMessage$Builder;->setWaitId(I)Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$IpcMessage$Builder;

    .line 3194
    :cond_d
    invoke-virtual {p1}, Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$IpcMessage;->hasRetValue()Z

    move-result v0

    if-eqz v0, :cond_e

    .line 3195
    invoke-virtual {p1}, Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$IpcMessage;->getRetValue()Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$ReturnValue;

    move-result-object v0

    invoke-virtual {p0, v0}, Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$IpcMessage$Builder;->mergeRetValue(Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$ReturnValue;)Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$IpcMessage$Builder;

    .line 3197
    :cond_e
    invoke-virtual {p1}, Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$IpcMessage;->hasEncrypt()Z

    move-result v0

    if-eqz v0, :cond_f

    .line 3198
    invoke-virtual {p1}, Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$IpcMessage;->getEncrypt()Z

    move-result v0

    invoke-virtual {p0, v0}, Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$IpcMessage$Builder;->setEncrypt(Z)Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$IpcMessage$Builder;

    .line 3200
    :cond_f
    invoke-virtual {p1}, Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$IpcMessage;->hasIsDebug()Z

    move-result v0

    if-eqz v0, :cond_10

    .line 3201
    invoke-virtual {p1}, Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$IpcMessage;->getIsDebug()Z

    move-result v0

    invoke-virtual {p0, v0}, Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$IpcMessage$Builder;->setIsDebug(Z)Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$IpcMessage$Builder;

    .line 3203
    :cond_10
    invoke-virtual {p1}, Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$IpcMessage;->getUnknownFields()Lcom/google/protobuf/UnknownFieldSet;

    move-result-object v0

    invoke-virtual {p0, v0}, Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$IpcMessage$Builder;->mergeUnknownFields(Lcom/google/protobuf/UnknownFieldSet;)Lcom/google/protobuf/GeneratedMessage$Builder;

    goto/16 :goto_0

    .line 3115
    :cond_11
    invoke-direct {p0}, Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$IpcMessage$Builder;->ensureArg1IsMutable()V

    .line 3116
    iget-object v0, p0, Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$IpcMessage$Builder;->arg1_:Ljava/util/List;

    invoke-static {p1}, Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$IpcMessage;->access$3300(Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$IpcMessage;)Ljava/util/List;

    move-result-object v1

    invoke-interface {v0, v1}, Ljava/util/List;->addAll(Ljava/util/Collection;)Z

    goto/16 :goto_1

    .line 3125
    :cond_12
    invoke-direct {p0}, Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$IpcMessage$Builder;->ensureArg2IsMutable()V

    .line 3126
    iget-object v0, p0, Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$IpcMessage$Builder;->arg2_:Lcom/google/protobuf/LazyStringList;

    invoke-static {p1}, Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$IpcMessage;->access$3400(Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$IpcMessage;)Lcom/google/protobuf/LazyStringList;

    move-result-object v1

    invoke-interface {v0, v1}, Lcom/google/protobuf/LazyStringList;->addAll(Ljava/util/Collection;)Z

    goto/16 :goto_2

    .line 3135
    :cond_13
    invoke-direct {p0}, Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$IpcMessage$Builder;->ensureArg3IsMutable()V

    .line 3136
    iget-object v0, p0, Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$IpcMessage$Builder;->arg3_:Ljava/util/List;

    invoke-static {p1}, Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$IpcMessage;->access$3500(Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$IpcMessage;)Ljava/util/List;

    move-result-object v1

    invoke-interface {v0, v1}, Ljava/util/List;->addAll(Ljava/util/Collection;)Z

    goto/16 :goto_3

    .line 3148
    :cond_14
    invoke-direct {p0}, Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$IpcMessage$Builder;->ensureArg4IsMutable()V

    .line 3149
    iget-object v0, p0, Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$IpcMessage$Builder;->arg4_:Ljava/util/List;

    invoke-static {p1}, Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$IpcMessage;->access$3700(Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$IpcMessage;)Ljava/util/List;

    move-result-object v1

    invoke-interface {v0, v1}, Ljava/util/List;->addAll(Ljava/util/Collection;)Z

    goto/16 :goto_4

    .line 3173
    :cond_15
    invoke-direct {p0}, Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$IpcMessage$Builder;->ensureTypesIsMutable()V

    .line 3174
    iget-object v0, p0, Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$IpcMessage$Builder;->types_:Lcom/google/protobuf/LazyStringList;

    invoke-static {p1}, Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$IpcMessage;->access$4100(Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$IpcMessage;)Lcom/google/protobuf/LazyStringList;

    move-result-object v1

    invoke-interface {v0, v1}, Lcom/google/protobuf/LazyStringList;->addAll(Ljava/util/Collection;)Z

    goto/16 :goto_5

    .line 3183
    :cond_16
    invoke-direct {p0}, Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$IpcMessage$Builder;->ensureParamsIsMutable()V

    .line 3184
    iget-object v0, p0, Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$IpcMessage$Builder;->params_:Lcom/google/protobuf/LazyStringList;

    invoke-static {p1}, Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$IpcMessage;->access$4200(Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$IpcMessage;)Lcom/google/protobuf/LazyStringList;

    move-result-object v1

    invoke-interface {v0, v1}, Lcom/google/protobuf/LazyStringList;->addAll(Ljava/util/Collection;)Z

    goto/16 :goto_6
.end method

.method public mergeFrom(Lcom/google/protobuf/CodedInputStream;Lcom/google/protobuf/ExtensionRegistryLite;)Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$IpcMessage$Builder;
    .locals 4
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljava/io/IOException;
        }
    .end annotation

    .prologue
    .line 3215
    const/4 v2, 0x0

    .line 3217
    :try_start_0
    sget-object v0, Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$IpcMessage;->PARSER:Lcom/google/protobuf/Parser;

    invoke-interface {v0, p1, p2}, Lcom/google/protobuf/Parser;->parsePartialFrom(Lcom/google/protobuf/CodedInputStream;Lcom/google/protobuf/ExtensionRegistryLite;)Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$IpcMessage;
    :try_end_0
    .catch Lcom/google/protobuf/InvalidProtocolBufferException; {:try_start_0 .. :try_end_0} :catch_0
    .catchall {:try_start_0 .. :try_end_0} :catchall_1

    .line 3222
    if-eqz v0, :cond_0

    .line 3223
    invoke-virtual {p0, v0}, Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$IpcMessage$Builder;->mergeFrom(Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$IpcMessage;)Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$IpcMessage$Builder;

    .line 3226
    :cond_0
    return-object p0

    .line 3218
    :catch_0
    move-exception v0

    move-object v1, v0

    .line 3219
    :try_start_1
    invoke-virtual {v1}, Lcom/google/protobuf/InvalidProtocolBufferException;->getUnfinishedMessage()Lcom/google/protobuf/MessageLite;

    move-result-object v0

    check-cast v0, Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$IpcMessage;
    :try_end_1
    .catchall {:try_start_1 .. :try_end_1} :catchall_1

    .line 3220
    :try_start_2
    throw v1
    :try_end_2
    .catchall {:try_start_2 .. :try_end_2} :catchall_0

    .line 3222
    :catchall_0
    move-exception v1

    move-object v3, v1

    move-object v1, v0

    move-object v0, v3

    :goto_0
    if-eqz v1, :cond_1

    .line 3223
    invoke-virtual {p0, v1}, Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$IpcMessage$Builder;->mergeFrom(Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$IpcMessage;)Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$IpcMessage$Builder;

    :cond_1
    throw v0

    .line 3222
    :catchall_1
    move-exception v0

    move-object v1, v2

    goto :goto_0
.end method

.method public mergeFrom(Lcom/google/protobuf/Message;)Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$IpcMessage$Builder;
    .locals 1

    .prologue
    .line 3097
    instance-of v0, p1, Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$IpcMessage;

    if-eqz v0, :cond_0

    .line 3098
    check-cast p1, Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$IpcMessage;

    invoke-virtual {p0, p1}, Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$IpcMessage$Builder;->mergeFrom(Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$IpcMessage;)Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$IpcMessage$Builder;

    move-result-object p0

    .line 3101
    :goto_0
    return-object p0

    .line 3100
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
    .line 2914
    invoke-virtual {p0, p1, p2}, Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$IpcMessage$Builder;->mergeFrom(Lcom/google/protobuf/CodedInputStream;Lcom/google/protobuf/ExtensionRegistryLite;)Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$IpcMessage$Builder;

    move-result-object v0

    return-object v0
.end method

.method public bridge synthetic mergeFrom(Lcom/google/protobuf/Message;)Lcom/google/protobuf/AbstractMessage$Builder;
    .locals 1

    .prologue
    .line 2914
    invoke-virtual {p0, p1}, Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$IpcMessage$Builder;->mergeFrom(Lcom/google/protobuf/Message;)Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$IpcMessage$Builder;

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
    .line 2914
    invoke-virtual {p0, p1, p2}, Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$IpcMessage$Builder;->mergeFrom(Lcom/google/protobuf/CodedInputStream;Lcom/google/protobuf/ExtensionRegistryLite;)Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$IpcMessage$Builder;

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
    .line 2914
    invoke-virtual {p0, p1, p2}, Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$IpcMessage$Builder;->mergeFrom(Lcom/google/protobuf/CodedInputStream;Lcom/google/protobuf/ExtensionRegistryLite;)Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$IpcMessage$Builder;

    move-result-object v0

    return-object v0
.end method

.method public bridge synthetic mergeFrom(Lcom/google/protobuf/Message;)Lcom/google/protobuf/Message$Builder;
    .locals 1

    .prologue
    .line 2914
    invoke-virtual {p0, p1}, Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$IpcMessage$Builder;->mergeFrom(Lcom/google/protobuf/Message;)Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$IpcMessage$Builder;

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
    .line 2914
    invoke-virtual {p0, p1, p2}, Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$IpcMessage$Builder;->mergeFrom(Lcom/google/protobuf/CodedInputStream;Lcom/google/protobuf/ExtensionRegistryLite;)Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$IpcMessage$Builder;

    move-result-object v0

    return-object v0
.end method

.method public mergeRetValue(Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$ReturnValue;)Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$IpcMessage$Builder;
    .locals 2

    .prologue
    .line 4142
    iget-object v0, p0, Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$IpcMessage$Builder;->retValueBuilder_:Lcom/google/protobuf/SingleFieldBuilder;

    if-nez v0, :cond_1

    .line 4143
    iget v0, p0, Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$IpcMessage$Builder;->bitField0_:I

    and-int/lit16 v0, v0, 0x2000

    const/16 v1, 0x2000

    if-ne v0, v1, :cond_0

    iget-object v0, p0, Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$IpcMessage$Builder;->retValue_:Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$ReturnValue;

    .line 4144
    invoke-static {}, Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$ReturnValue;->getDefaultInstance()Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$ReturnValue;

    move-result-object v1

    if-eq v0, v1, :cond_0

    .line 4145
    iget-object v0, p0, Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$IpcMessage$Builder;->retValue_:Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$ReturnValue;

    .line 4146
    invoke-static {v0}, Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$ReturnValue;->newBuilder(Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$ReturnValue;)Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$ReturnValue$Builder;

    move-result-object v0

    invoke-virtual {v0, p1}, Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$ReturnValue$Builder;->mergeFrom(Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$ReturnValue;)Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$ReturnValue$Builder;

    move-result-object v0

    invoke-virtual {v0}, Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$ReturnValue$Builder;->buildPartial()Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$ReturnValue;

    move-result-object v0

    iput-object v0, p0, Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$IpcMessage$Builder;->retValue_:Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$ReturnValue;

    .line 4150
    :goto_0
    invoke-virtual {p0}, Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$IpcMessage$Builder;->onChanged()V

    .line 4154
    :goto_1
    iget v0, p0, Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$IpcMessage$Builder;->bitField0_:I

    or-int/lit16 v0, v0, 0x2000

    iput v0, p0, Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$IpcMessage$Builder;->bitField0_:I

    .line 4155
    return-object p0

    .line 4148
    :cond_0
    iput-object p1, p0, Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$IpcMessage$Builder;->retValue_:Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$ReturnValue;

    goto :goto_0

    .line 4152
    :cond_1
    iget-object v0, p0, Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$IpcMessage$Builder;->retValueBuilder_:Lcom/google/protobuf/SingleFieldBuilder;

    invoke-virtual {v0, p1}, Lcom/google/protobuf/SingleFieldBuilder;->mergeFrom(Lcom/google/protobuf/GeneratedMessage;)Lcom/google/protobuf/SingleFieldBuilder;

    goto :goto_1
.end method

.method public setArg1(II)Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$IpcMessage$Builder;
    .locals 2

    .prologue
    .line 3295
    invoke-direct {p0}, Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$IpcMessage$Builder;->ensureArg1IsMutable()V

    .line 3296
    iget-object v0, p0, Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$IpcMessage$Builder;->arg1_:Ljava/util/List;

    invoke-static {p2}, Ljava/lang/Integer;->valueOf(I)Ljava/lang/Integer;

    move-result-object v1

    invoke-interface {v0, p1, v1}, Ljava/util/List;->set(ILjava/lang/Object;)Ljava/lang/Object;

    .line 3297
    invoke-virtual {p0}, Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$IpcMessage$Builder;->onChanged()V

    .line 3298
    return-object p0
.end method

.method public setArg2(ILjava/lang/String;)Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$IpcMessage$Builder;
    .locals 1

    .prologue
    .line 3368
    if-nez p2, :cond_0

    .line 3369
    new-instance v0, Ljava/lang/NullPointerException;

    invoke-direct {v0}, Ljava/lang/NullPointerException;-><init>()V

    throw v0

    .line 3371
    :cond_0
    invoke-direct {p0}, Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$IpcMessage$Builder;->ensureArg2IsMutable()V

    .line 3372
    iget-object v0, p0, Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$IpcMessage$Builder;->arg2_:Lcom/google/protobuf/LazyStringList;

    invoke-interface {v0, p1, p2}, Lcom/google/protobuf/LazyStringList;->set(ILjava/lang/Object;)Ljava/lang/Object;

    .line 3373
    invoke-virtual {p0}, Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$IpcMessage$Builder;->onChanged()V

    .line 3374
    return-object p0
.end method

.method public setArg3(IF)Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$IpcMessage$Builder;
    .locals 2

    .prologue
    .line 3454
    invoke-direct {p0}, Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$IpcMessage$Builder;->ensureArg3IsMutable()V

    .line 3455
    iget-object v0, p0, Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$IpcMessage$Builder;->arg3_:Ljava/util/List;

    invoke-static {p2}, Ljava/lang/Float;->valueOf(F)Ljava/lang/Float;

    move-result-object v1

    invoke-interface {v0, p1, v1}, Ljava/util/List;->set(ILjava/lang/Object;)Ljava/lang/Object;

    .line 3456
    invoke-virtual {p0}, Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$IpcMessage$Builder;->onChanged()V

    .line 3457
    return-object p0
.end method

.method public setArg4(IJ)Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$IpcMessage$Builder;
    .locals 2

    .prologue
    .line 3556
    invoke-direct {p0}, Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$IpcMessage$Builder;->ensureArg4IsMutable()V

    .line 3557
    iget-object v0, p0, Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$IpcMessage$Builder;->arg4_:Ljava/util/List;

    invoke-static {p2, p3}, Ljava/lang/Long;->valueOf(J)Ljava/lang/Long;

    move-result-object v1

    invoke-interface {v0, p1, v1}, Ljava/util/List;->set(ILjava/lang/Object;)Ljava/lang/Object;

    .line 3558
    invoke-virtual {p0}, Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$IpcMessage$Builder;->onChanged()V

    .line 3559
    return-object p0
.end method

.method public setClassName(Ljava/lang/String;)Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$IpcMessage$Builder;
    .locals 1

    .prologue
    .line 3731
    if-nez p1, :cond_0

    .line 3732
    new-instance v0, Ljava/lang/NullPointerException;

    invoke-direct {v0}, Ljava/lang/NullPointerException;-><init>()V

    throw v0

    .line 3734
    :cond_0
    iget v0, p0, Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$IpcMessage$Builder;->bitField0_:I

    or-int/lit16 v0, v0, 0x80

    iput v0, p0, Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$IpcMessage$Builder;->bitField0_:I

    .line 3735
    iput-object p1, p0, Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$IpcMessage$Builder;->className_:Ljava/lang/Object;

    .line 3736
    invoke-virtual {p0}, Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$IpcMessage$Builder;->onChanged()V

    .line 3737
    return-object p0
.end method

.method public setClassNameBytes(Lcom/google/protobuf/ByteString;)Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$IpcMessage$Builder;
    .locals 1

    .prologue
    .line 3753
    if-nez p1, :cond_0

    .line 3754
    new-instance v0, Ljava/lang/NullPointerException;

    invoke-direct {v0}, Ljava/lang/NullPointerException;-><init>()V

    throw v0

    .line 3756
    :cond_0
    iget v0, p0, Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$IpcMessage$Builder;->bitField0_:I

    or-int/lit16 v0, v0, 0x80

    iput v0, p0, Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$IpcMessage$Builder;->bitField0_:I

    .line 3757
    iput-object p1, p0, Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$IpcMessage$Builder;->className_:Ljava/lang/Object;

    .line 3758
    invoke-virtual {p0}, Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$IpcMessage$Builder;->onChanged()V

    .line 3759
    return-object p0
.end method

.method public setCmd(I)Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$IpcMessage$Builder;
    .locals 1

    .prologue
    .line 3248
    iget v0, p0, Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$IpcMessage$Builder;->bitField0_:I

    or-int/lit8 v0, v0, 0x1

    iput v0, p0, Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$IpcMessage$Builder;->bitField0_:I

    .line 3249
    iput p1, p0, Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$IpcMessage$Builder;->cmd_:I

    .line 3250
    invoke-virtual {p0}, Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$IpcMessage$Builder;->onChanged()V

    .line 3251
    return-object p0
.end method

.method public setEncrypt(Z)Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$IpcMessage$Builder;
    .locals 1

    .prologue
    .line 4235
    iget v0, p0, Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$IpcMessage$Builder;->bitField0_:I

    or-int/lit16 v0, v0, 0x4000

    iput v0, p0, Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$IpcMessage$Builder;->bitField0_:I

    .line 4236
    iput-boolean p1, p0, Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$IpcMessage$Builder;->encrypt_:Z

    .line 4237
    invoke-virtual {p0}, Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$IpcMessage$Builder;->onChanged()V

    .line 4238
    return-object p0
.end method

.method public setFileData(Lcom/google/protobuf/ByteString;)Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$IpcMessage$Builder;
    .locals 1

    .prologue
    .line 3506
    if-nez p1, :cond_0

    .line 3507
    new-instance v0, Ljava/lang/NullPointerException;

    invoke-direct {v0}, Ljava/lang/NullPointerException;-><init>()V

    throw v0

    .line 3509
    :cond_0
    iget v0, p0, Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$IpcMessage$Builder;->bitField0_:I

    or-int/lit8 v0, v0, 0x10

    iput v0, p0, Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$IpcMessage$Builder;->bitField0_:I

    .line 3510
    iput-object p1, p0, Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$IpcMessage$Builder;->fileData_:Lcom/google/protobuf/ByteString;

    .line 3511
    invoke-virtual {p0}, Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$IpcMessage$Builder;->onChanged()V

    .line 3512
    return-object p0
.end method

.method public setIsDebug(Z)Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$IpcMessage$Builder;
    .locals 2

    .prologue
    .line 4272
    iget v0, p0, Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$IpcMessage$Builder;->bitField0_:I

    const v1, 0x8000

    or-int/2addr v0, v1

    iput v0, p0, Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$IpcMessage$Builder;->bitField0_:I

    .line 4273
    iput-boolean p1, p0, Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$IpcMessage$Builder;->isDebug_:Z

    .line 4274
    invoke-virtual {p0}, Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$IpcMessage$Builder;->onChanged()V

    .line 4275
    return-object p0
.end method

.method public setIsSyncCall(Z)Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$IpcMessage$Builder;
    .locals 1

    .prologue
    .line 4040
    iget v0, p0, Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$IpcMessage$Builder;->bitField0_:I

    or-int/lit16 v0, v0, 0x800

    iput v0, p0, Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$IpcMessage$Builder;->bitField0_:I

    .line 4041
    iput-boolean p1, p0, Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$IpcMessage$Builder;->isSyncCall_:Z

    .line 4042
    invoke-virtual {p0}, Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$IpcMessage$Builder;->onChanged()V

    .line 4043
    return-object p0
.end method

.method public setMethodName(Ljava/lang/String;)Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$IpcMessage$Builder;
    .locals 1

    .prologue
    .line 3805
    if-nez p1, :cond_0

    .line 3806
    new-instance v0, Ljava/lang/NullPointerException;

    invoke-direct {v0}, Ljava/lang/NullPointerException;-><init>()V

    throw v0

    .line 3808
    :cond_0
    iget v0, p0, Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$IpcMessage$Builder;->bitField0_:I

    or-int/lit16 v0, v0, 0x100

    iput v0, p0, Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$IpcMessage$Builder;->bitField0_:I

    .line 3809
    iput-object p1, p0, Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$IpcMessage$Builder;->methodName_:Ljava/lang/Object;

    .line 3810
    invoke-virtual {p0}, Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$IpcMessage$Builder;->onChanged()V

    .line 3811
    return-object p0
.end method

.method public setMethodNameBytes(Lcom/google/protobuf/ByteString;)Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$IpcMessage$Builder;
    .locals 1

    .prologue
    .line 3827
    if-nez p1, :cond_0

    .line 3828
    new-instance v0, Ljava/lang/NullPointerException;

    invoke-direct {v0}, Ljava/lang/NullPointerException;-><init>()V

    throw v0

    .line 3830
    :cond_0
    iget v0, p0, Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$IpcMessage$Builder;->bitField0_:I

    or-int/lit16 v0, v0, 0x100

    iput v0, p0, Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$IpcMessage$Builder;->bitField0_:I

    .line 3831
    iput-object p1, p0, Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$IpcMessage$Builder;->methodName_:Ljava/lang/Object;

    .line 3832
    invoke-virtual {p0}, Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$IpcMessage$Builder;->onChanged()V

    .line 3833
    return-object p0
.end method

.method public setParams(ILjava/lang/String;)Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$IpcMessage$Builder;
    .locals 1

    .prologue
    .line 3968
    if-nez p2, :cond_0

    .line 3969
    new-instance v0, Ljava/lang/NullPointerException;

    invoke-direct {v0}, Ljava/lang/NullPointerException;-><init>()V

    throw v0

    .line 3971
    :cond_0
    invoke-direct {p0}, Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$IpcMessage$Builder;->ensureParamsIsMutable()V

    .line 3972
    iget-object v0, p0, Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$IpcMessage$Builder;->params_:Lcom/google/protobuf/LazyStringList;

    invoke-interface {v0, p1, p2}, Lcom/google/protobuf/LazyStringList;->set(ILjava/lang/Object;)Ljava/lang/Object;

    .line 3973
    invoke-virtual {p0}, Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$IpcMessage$Builder;->onChanged()V

    .line 3974
    return-object p0
.end method

.method public setPkgName(Ljava/lang/String;)Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$IpcMessage$Builder;
    .locals 1

    .prologue
    .line 3649
    if-nez p1, :cond_0

    .line 3650
    new-instance v0, Ljava/lang/NullPointerException;

    invoke-direct {v0}, Ljava/lang/NullPointerException;-><init>()V

    throw v0

    .line 3652
    :cond_0
    iget v0, p0, Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$IpcMessage$Builder;->bitField0_:I

    or-int/lit8 v0, v0, 0x40

    iput v0, p0, Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$IpcMessage$Builder;->bitField0_:I

    .line 3653
    iput-object p1, p0, Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$IpcMessage$Builder;->pkgName_:Ljava/lang/Object;

    .line 3654
    invoke-virtual {p0}, Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$IpcMessage$Builder;->onChanged()V

    .line 3655
    return-object p0
.end method

.method public setPkgNameBytes(Lcom/google/protobuf/ByteString;)Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$IpcMessage$Builder;
    .locals 1

    .prologue
    .line 3679
    if-nez p1, :cond_0

    .line 3680
    new-instance v0, Ljava/lang/NullPointerException;

    invoke-direct {v0}, Ljava/lang/NullPointerException;-><init>()V

    throw v0

    .line 3682
    :cond_0
    iget v0, p0, Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$IpcMessage$Builder;->bitField0_:I

    or-int/lit8 v0, v0, 0x40

    iput v0, p0, Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$IpcMessage$Builder;->bitField0_:I

    .line 3683
    iput-object p1, p0, Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$IpcMessage$Builder;->pkgName_:Ljava/lang/Object;

    .line 3684
    invoke-virtual {p0}, Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$IpcMessage$Builder;->onChanged()V

    .line 3685
    return-object p0
.end method

.method public setRetValue(Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$ReturnValue$Builder;)Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$IpcMessage$Builder;
    .locals 2

    .prologue
    .line 4129
    iget-object v0, p0, Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$IpcMessage$Builder;->retValueBuilder_:Lcom/google/protobuf/SingleFieldBuilder;

    if-nez v0, :cond_0

    .line 4130
    invoke-virtual {p1}, Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$ReturnValue$Builder;->build()Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$ReturnValue;

    move-result-object v0

    iput-object v0, p0, Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$IpcMessage$Builder;->retValue_:Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$ReturnValue;

    .line 4131
    invoke-virtual {p0}, Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$IpcMessage$Builder;->onChanged()V

    .line 4135
    :goto_0
    iget v0, p0, Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$IpcMessage$Builder;->bitField0_:I

    or-int/lit16 v0, v0, 0x2000

    iput v0, p0, Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$IpcMessage$Builder;->bitField0_:I

    .line 4136
    return-object p0

    .line 4133
    :cond_0
    iget-object v0, p0, Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$IpcMessage$Builder;->retValueBuilder_:Lcom/google/protobuf/SingleFieldBuilder;

    invoke-virtual {p1}, Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$ReturnValue$Builder;->build()Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$ReturnValue;

    move-result-object v1

    invoke-virtual {v0, v1}, Lcom/google/protobuf/SingleFieldBuilder;->setMessage(Lcom/google/protobuf/GeneratedMessage;)Lcom/google/protobuf/SingleFieldBuilder;

    goto :goto_0
.end method

.method public setRetValue(Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$ReturnValue;)Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$IpcMessage$Builder;
    .locals 1

    .prologue
    .line 4112
    iget-object v0, p0, Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$IpcMessage$Builder;->retValueBuilder_:Lcom/google/protobuf/SingleFieldBuilder;

    if-nez v0, :cond_1

    .line 4113
    if-nez p1, :cond_0

    .line 4114
    new-instance v0, Ljava/lang/NullPointerException;

    invoke-direct {v0}, Ljava/lang/NullPointerException;-><init>()V

    throw v0

    .line 4116
    :cond_0
    iput-object p1, p0, Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$IpcMessage$Builder;->retValue_:Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$ReturnValue;

    .line 4117
    invoke-virtual {p0}, Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$IpcMessage$Builder;->onChanged()V

    .line 4121
    :goto_0
    iget v0, p0, Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$IpcMessage$Builder;->bitField0_:I

    or-int/lit16 v0, v0, 0x2000

    iput v0, p0, Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$IpcMessage$Builder;->bitField0_:I

    .line 4122
    return-object p0

    .line 4119
    :cond_1
    iget-object v0, p0, Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$IpcMessage$Builder;->retValueBuilder_:Lcom/google/protobuf/SingleFieldBuilder;

    invoke-virtual {v0, p1}, Lcom/google/protobuf/SingleFieldBuilder;->setMessage(Lcom/google/protobuf/GeneratedMessage;)Lcom/google/protobuf/SingleFieldBuilder;

    goto :goto_0
.end method

.method public setTypes(ILjava/lang/String;)Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$IpcMessage$Builder;
    .locals 1

    .prologue
    .line 3875
    if-nez p2, :cond_0

    .line 3876
    new-instance v0, Ljava/lang/NullPointerException;

    invoke-direct {v0}, Ljava/lang/NullPointerException;-><init>()V

    throw v0

    .line 3878
    :cond_0
    invoke-direct {p0}, Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$IpcMessage$Builder;->ensureTypesIsMutable()V

    .line 3879
    iget-object v0, p0, Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$IpcMessage$Builder;->types_:Lcom/google/protobuf/LazyStringList;

    invoke-interface {v0, p1, p2}, Lcom/google/protobuf/LazyStringList;->set(ILjava/lang/Object;)Ljava/lang/Object;

    .line 3880
    invoke-virtual {p0}, Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$IpcMessage$Builder;->onChanged()V

    .line 3881
    return-object p0
.end method

.method public setWaitId(I)Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$IpcMessage$Builder;
    .locals 1

    .prologue
    .line 4073
    iget v0, p0, Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$IpcMessage$Builder;->bitField0_:I

    or-int/lit16 v0, v0, 0x1000

    iput v0, p0, Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$IpcMessage$Builder;->bitField0_:I

    .line 4074
    iput p1, p0, Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$IpcMessage$Builder;->waitId_:I

    .line 4075
    invoke-virtual {p0}, Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$IpcMessage$Builder;->onChanged()V

    .line 4076
    return-object p0
.end method
