.class public final Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$ControlVar$Builder;
.super Lcom/google/protobuf/GeneratedMessage$Builder;
.source "SourceFile"

# interfaces
.implements Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$ControlVarOrBuilder;


# annotations
.annotation system Ldalvik/annotation/EnclosingClass;
    value = Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$ControlVar;
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x19
    name = "Builder"
.end annotation

.annotation system Ldalvik/annotation/Signature;
    value = {
        "Lcom/google/protobuf/GeneratedMessage$Builder",
        "<",
        "Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$ControlVar$Builder;",
        ">;",
        "Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$ControlVarOrBuilder;"
    }
.end annotation


# instance fields
.field private bitField0_:I

.field private boolValue_:Z

.field private controlId_:Ljava/lang/Object;

.field private intValue_:I

.field private stringValue_:Ljava/lang/Object;

.field private type_:Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$ControlVar$Data_Type;


# direct methods
.method private constructor <init>()V
    .locals 1

    .prologue
    .line 5879
    invoke-direct {p0}, Lcom/google/protobuf/GeneratedMessage$Builder;-><init>()V

    .line 6023
    const-string v0, ""

    iput-object v0, p0, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$ControlVar$Builder;->controlId_:Ljava/lang/Object;

    .line 6097
    sget-object v0, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$ControlVar$Data_Type;->BOOL:Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$ControlVar$Data_Type;

    iput-object v0, p0, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$ControlVar$Builder;->type_:Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$ControlVar$Data_Type;

    .line 6199
    const-string v0, ""

    iput-object v0, p0, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$ControlVar$Builder;->stringValue_:Ljava/lang/Object;

    .line 5880
    invoke-direct {p0}, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$ControlVar$Builder;->maybeForceBuilderInitialization()V

    .line 5881
    return-void
.end method

.method private constructor <init>(Lcom/google/protobuf/GeneratedMessage$BuilderParent;)V
    .locals 1

    .prologue
    .line 5885
    invoke-direct {p0, p1}, Lcom/google/protobuf/GeneratedMessage$Builder;-><init>(Lcom/google/protobuf/GeneratedMessage$BuilderParent;)V

    .line 6023
    const-string v0, ""

    iput-object v0, p0, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$ControlVar$Builder;->controlId_:Ljava/lang/Object;

    .line 6097
    sget-object v0, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$ControlVar$Data_Type;->BOOL:Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$ControlVar$Data_Type;

    iput-object v0, p0, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$ControlVar$Builder;->type_:Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$ControlVar$Data_Type;

    .line 6199
    const-string v0, ""

    iput-object v0, p0, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$ControlVar$Builder;->stringValue_:Ljava/lang/Object;

    .line 5886
    invoke-direct {p0}, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$ControlVar$Builder;->maybeForceBuilderInitialization()V

    .line 5887
    return-void
.end method

.method synthetic constructor <init>(Lcom/google/protobuf/GeneratedMessage$BuilderParent;Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$1;)V
    .locals 0

    .prologue
    .line 5863
    invoke-direct {p0, p1}, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$ControlVar$Builder;-><init>(Lcom/google/protobuf/GeneratedMessage$BuilderParent;)V

    return-void
.end method

.method static synthetic access$5700()Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$ControlVar$Builder;
    .locals 1

    .prologue
    .line 5863
    invoke-static {}, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$ControlVar$Builder;->create()Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$ControlVar$Builder;

    move-result-object v0

    return-object v0
.end method

.method private static create()Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$ControlVar$Builder;
    .locals 1

    .prologue
    .line 5893
    new-instance v0, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$ControlVar$Builder;

    invoke-direct {v0}, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$ControlVar$Builder;-><init>()V

    return-object v0
.end method

.method public static final getDescriptor()Lcom/google/protobuf/Descriptors$Descriptor;
    .locals 1

    .prologue
    .line 5868
    invoke-static {}, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage;->h()Lcom/google/protobuf/Descriptors$Descriptor;

    move-result-object v0

    return-object v0
.end method

.method private maybeForceBuilderInitialization()V
    .locals 1

    .prologue
    .line 5889
    invoke-static {}, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$ControlVar;->access$5900()Z

    move-result v0

    if-eqz v0, :cond_0

    .line 5891
    :cond_0
    return-void
.end method


# virtual methods
.method public build()Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$ControlVar;
    .locals 2

    .prologue
    .line 5925
    invoke-virtual {p0}, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$ControlVar$Builder;->buildPartial()Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$ControlVar;

    move-result-object v0

    .line 5926
    invoke-virtual {v0}, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$ControlVar;->isInitialized()Z

    move-result v1

    if-nez v1, :cond_0

    .line 5927
    invoke-static {v0}, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$ControlVar$Builder;->newUninitializedMessageException(Lcom/google/protobuf/Message;)Lcom/google/protobuf/UninitializedMessageException;

    move-result-object v0

    throw v0

    .line 5929
    :cond_0
    return-object v0
.end method

.method public bridge synthetic build()Lcom/google/protobuf/Message;
    .locals 1

    .prologue
    .line 5863
    invoke-virtual {p0}, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$ControlVar$Builder;->build()Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$ControlVar;

    move-result-object v0

    return-object v0
.end method

.method public bridge synthetic build()Lcom/google/protobuf/MessageLite;
    .locals 1

    .prologue
    .line 5863
    invoke-virtual {p0}, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$ControlVar$Builder;->build()Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$ControlVar;

    move-result-object v0

    return-object v0
.end method

.method public buildPartial()Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$ControlVar;
    .locals 5

    .prologue
    const/4 v0, 0x1

    .line 5933
    new-instance v2, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$ControlVar;

    const/4 v1, 0x0

    invoke-direct {v2, p0, v1}, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$ControlVar;-><init>(Lcom/google/protobuf/GeneratedMessage$Builder;Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$1;)V

    .line 5934
    iget v3, p0, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$ControlVar$Builder;->bitField0_:I

    .line 5935
    const/4 v1, 0x0

    .line 5936
    and-int/lit8 v4, v3, 0x1

    if-ne v4, v0, :cond_4

    .line 5939
    :goto_0
    iget-object v1, p0, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$ControlVar$Builder;->controlId_:Ljava/lang/Object;

    invoke-static {v2, v1}, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$ControlVar;->access$6102(Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$ControlVar;Ljava/lang/Object;)Ljava/lang/Object;

    .line 5940
    and-int/lit8 v1, v3, 0x2

    const/4 v4, 0x2

    if-ne v1, v4, :cond_0

    .line 5941
    or-int/lit8 v0, v0, 0x2

    .line 5943
    :cond_0
    iget-object v1, p0, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$ControlVar$Builder;->type_:Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$ControlVar$Data_Type;

    invoke-static {v2, v1}, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$ControlVar;->access$6202(Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$ControlVar;Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$ControlVar$Data_Type;)Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$ControlVar$Data_Type;

    .line 5944
    and-int/lit8 v1, v3, 0x4

    const/4 v4, 0x4

    if-ne v1, v4, :cond_1

    .line 5945
    or-int/lit8 v0, v0, 0x4

    .line 5947
    :cond_1
    iget-boolean v1, p0, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$ControlVar$Builder;->boolValue_:Z

    invoke-static {v2, v1}, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$ControlVar;->access$6302(Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$ControlVar;Z)Z

    .line 5948
    and-int/lit8 v1, v3, 0x8

    const/16 v4, 0x8

    if-ne v1, v4, :cond_2

    .line 5949
    or-int/lit8 v0, v0, 0x8

    .line 5951
    :cond_2
    iget v1, p0, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$ControlVar$Builder;->intValue_:I

    invoke-static {v2, v1}, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$ControlVar;->access$6402(Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$ControlVar;I)I

    .line 5952
    and-int/lit8 v1, v3, 0x10

    const/16 v3, 0x10

    if-ne v1, v3, :cond_3

    .line 5953
    or-int/lit8 v0, v0, 0x10

    .line 5955
    :cond_3
    iget-object v1, p0, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$ControlVar$Builder;->stringValue_:Ljava/lang/Object;

    invoke-static {v2, v1}, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$ControlVar;->access$6502(Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$ControlVar;Ljava/lang/Object;)Ljava/lang/Object;

    .line 5956
    invoke-static {v2, v0}, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$ControlVar;->access$6602(Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$ControlVar;I)I

    .line 5957
    invoke-virtual {p0}, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$ControlVar$Builder;->onBuilt()V

    .line 5958
    return-object v2

    :cond_4
    move v0, v1

    goto :goto_0
.end method

.method public bridge synthetic buildPartial()Lcom/google/protobuf/Message;
    .locals 1

    .prologue
    .line 5863
    invoke-virtual {p0}, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$ControlVar$Builder;->buildPartial()Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$ControlVar;

    move-result-object v0

    return-object v0
.end method

.method public bridge synthetic buildPartial()Lcom/google/protobuf/MessageLite;
    .locals 1

    .prologue
    .line 5863
    invoke-virtual {p0}, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$ControlVar$Builder;->buildPartial()Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$ControlVar;

    move-result-object v0

    return-object v0
.end method

.method public clear()Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$ControlVar$Builder;
    .locals 2

    .prologue
    const/4 v1, 0x0

    .line 5897
    invoke-super {p0}, Lcom/google/protobuf/GeneratedMessage$Builder;->clear()Lcom/google/protobuf/GeneratedMessage$Builder;

    .line 5898
    const-string v0, ""

    iput-object v0, p0, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$ControlVar$Builder;->controlId_:Ljava/lang/Object;

    .line 5899
    iget v0, p0, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$ControlVar$Builder;->bitField0_:I

    and-int/lit8 v0, v0, -0x2

    iput v0, p0, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$ControlVar$Builder;->bitField0_:I

    .line 5900
    sget-object v0, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$ControlVar$Data_Type;->BOOL:Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$ControlVar$Data_Type;

    iput-object v0, p0, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$ControlVar$Builder;->type_:Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$ControlVar$Data_Type;

    .line 5901
    iget v0, p0, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$ControlVar$Builder;->bitField0_:I

    and-int/lit8 v0, v0, -0x3

    iput v0, p0, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$ControlVar$Builder;->bitField0_:I

    .line 5902
    iput-boolean v1, p0, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$ControlVar$Builder;->boolValue_:Z

    .line 5903
    iget v0, p0, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$ControlVar$Builder;->bitField0_:I

    and-int/lit8 v0, v0, -0x5

    iput v0, p0, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$ControlVar$Builder;->bitField0_:I

    .line 5904
    iput v1, p0, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$ControlVar$Builder;->intValue_:I

    .line 5905
    iget v0, p0, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$ControlVar$Builder;->bitField0_:I

    and-int/lit8 v0, v0, -0x9

    iput v0, p0, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$ControlVar$Builder;->bitField0_:I

    .line 5906
    const-string v0, ""

    iput-object v0, p0, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$ControlVar$Builder;->stringValue_:Ljava/lang/Object;

    .line 5907
    iget v0, p0, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$ControlVar$Builder;->bitField0_:I

    and-int/lit8 v0, v0, -0x11

    iput v0, p0, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$ControlVar$Builder;->bitField0_:I

    .line 5908
    return-object p0
.end method

.method public bridge synthetic clear()Lcom/google/protobuf/AbstractMessage$Builder;
    .locals 1

    .prologue
    .line 5863
    invoke-virtual {p0}, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$ControlVar$Builder;->clear()Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$ControlVar$Builder;

    move-result-object v0

    return-object v0
.end method

.method public bridge synthetic clear()Lcom/google/protobuf/GeneratedMessage$Builder;
    .locals 1

    .prologue
    .line 5863
    invoke-virtual {p0}, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$ControlVar$Builder;->clear()Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$ControlVar$Builder;

    move-result-object v0

    return-object v0
.end method

.method public bridge synthetic clear()Lcom/google/protobuf/Message$Builder;
    .locals 1

    .prologue
    .line 5863
    invoke-virtual {p0}, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$ControlVar$Builder;->clear()Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$ControlVar$Builder;

    move-result-object v0

    return-object v0
.end method

.method public bridge synthetic clear()Lcom/google/protobuf/MessageLite$Builder;
    .locals 1

    .prologue
    .line 5863
    invoke-virtual {p0}, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$ControlVar$Builder;->clear()Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$ControlVar$Builder;

    move-result-object v0

    return-object v0
.end method

.method public clearBoolValue()Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$ControlVar$Builder;
    .locals 1

    .prologue
    .line 6159
    iget v0, p0, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$ControlVar$Builder;->bitField0_:I

    and-int/lit8 v0, v0, -0x5

    iput v0, p0, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$ControlVar$Builder;->bitField0_:I

    .line 6160
    const/4 v0, 0x0

    iput-boolean v0, p0, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$ControlVar$Builder;->boolValue_:Z

    .line 6161
    invoke-virtual {p0}, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$ControlVar$Builder;->onChanged()V

    .line 6162
    return-object p0
.end method

.method public clearControlId()Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$ControlVar$Builder;
    .locals 1

    .prologue
    .line 6077
    iget v0, p0, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$ControlVar$Builder;->bitField0_:I

    and-int/lit8 v0, v0, -0x2

    iput v0, p0, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$ControlVar$Builder;->bitField0_:I

    .line 6078
    invoke-static {}, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$ControlVar;->getDefaultInstance()Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$ControlVar;

    move-result-object v0

    invoke-virtual {v0}, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$ControlVar;->getControlId()Ljava/lang/String;

    move-result-object v0

    iput-object v0, p0, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$ControlVar$Builder;->controlId_:Ljava/lang/Object;

    .line 6079
    invoke-virtual {p0}, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$ControlVar$Builder;->onChanged()V

    .line 6080
    return-object p0
.end method

.method public clearIntValue()Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$ControlVar$Builder;
    .locals 1

    .prologue
    .line 6192
    iget v0, p0, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$ControlVar$Builder;->bitField0_:I

    and-int/lit8 v0, v0, -0x9

    iput v0, p0, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$ControlVar$Builder;->bitField0_:I

    .line 6193
    const/4 v0, 0x0

    iput v0, p0, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$ControlVar$Builder;->intValue_:I

    .line 6194
    invoke-virtual {p0}, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$ControlVar$Builder;->onChanged()V

    .line 6195
    return-object p0
.end method

.method public clearStringValue()Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$ControlVar$Builder;
    .locals 1

    .prologue
    .line 6253
    iget v0, p0, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$ControlVar$Builder;->bitField0_:I

    and-int/lit8 v0, v0, -0x11

    iput v0, p0, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$ControlVar$Builder;->bitField0_:I

    .line 6254
    invoke-static {}, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$ControlVar;->getDefaultInstance()Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$ControlVar;

    move-result-object v0

    invoke-virtual {v0}, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$ControlVar;->getStringValue()Ljava/lang/String;

    move-result-object v0

    iput-object v0, p0, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$ControlVar$Builder;->stringValue_:Ljava/lang/Object;

    .line 6255
    invoke-virtual {p0}, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$ControlVar$Builder;->onChanged()V

    .line 6256
    return-object p0
.end method

.method public clearType()Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$ControlVar$Builder;
    .locals 1

    .prologue
    .line 6126
    iget v0, p0, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$ControlVar$Builder;->bitField0_:I

    and-int/lit8 v0, v0, -0x3

    iput v0, p0, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$ControlVar$Builder;->bitField0_:I

    .line 6127
    sget-object v0, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$ControlVar$Data_Type;->BOOL:Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$ControlVar$Data_Type;

    iput-object v0, p0, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$ControlVar$Builder;->type_:Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$ControlVar$Data_Type;

    .line 6128
    invoke-virtual {p0}, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$ControlVar$Builder;->onChanged()V

    .line 6129
    return-object p0
.end method

.method public clone()Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$ControlVar$Builder;
    .locals 2

    .prologue
    .line 5912
    invoke-static {}, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$ControlVar$Builder;->create()Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$ControlVar$Builder;

    move-result-object v0

    invoke-virtual {p0}, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$ControlVar$Builder;->buildPartial()Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$ControlVar;

    move-result-object v1

    invoke-virtual {v0, v1}, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$ControlVar$Builder;->mergeFrom(Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$ControlVar;)Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$ControlVar$Builder;

    move-result-object v0

    return-object v0
.end method

.method public bridge synthetic clone()Lcom/google/protobuf/AbstractMessage$Builder;
    .locals 1

    .prologue
    .line 5863
    invoke-virtual {p0}, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$ControlVar$Builder;->clone()Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$ControlVar$Builder;

    move-result-object v0

    return-object v0
.end method

.method public bridge synthetic clone()Lcom/google/protobuf/AbstractMessageLite$Builder;
    .locals 1

    .prologue
    .line 5863
    invoke-virtual {p0}, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$ControlVar$Builder;->clone()Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$ControlVar$Builder;

    move-result-object v0

    return-object v0
.end method

.method public bridge synthetic clone()Lcom/google/protobuf/GeneratedMessage$Builder;
    .locals 1

    .prologue
    .line 5863
    invoke-virtual {p0}, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$ControlVar$Builder;->clone()Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$ControlVar$Builder;

    move-result-object v0

    return-object v0
.end method

.method public bridge synthetic clone()Lcom/google/protobuf/Message$Builder;
    .locals 1

    .prologue
    .line 5863
    invoke-virtual {p0}, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$ControlVar$Builder;->clone()Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$ControlVar$Builder;

    move-result-object v0

    return-object v0
.end method

.method public bridge synthetic clone()Lcom/google/protobuf/MessageLite$Builder;
    .locals 1

    .prologue
    .line 5863
    invoke-virtual {p0}, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$ControlVar$Builder;->clone()Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$ControlVar$Builder;

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
    .line 5863
    invoke-virtual {p0}, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$ControlVar$Builder;->clone()Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$ControlVar$Builder;

    move-result-object v0

    return-object v0
.end method

.method public getBoolValue()Z
    .locals 1

    .prologue
    .line 6144
    iget-boolean v0, p0, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$ControlVar$Builder;->boolValue_:Z

    return v0
.end method

.method public getControlId()Ljava/lang/String;
    .locals 2

    .prologue
    .line 6034
    iget-object v0, p0, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$ControlVar$Builder;->controlId_:Ljava/lang/Object;

    .line 6035
    instance-of v1, v0, Ljava/lang/String;

    if-nez v1, :cond_0

    .line 6036
    check-cast v0, Lcom/google/protobuf/ByteString;

    .line 6037
    invoke-virtual {v0}, Lcom/google/protobuf/ByteString;->toStringUtf8()Ljava/lang/String;

    move-result-object v0

    .line 6038
    iput-object v0, p0, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$ControlVar$Builder;->controlId_:Ljava/lang/Object;

    .line 6041
    :goto_0
    return-object v0

    :cond_0
    check-cast v0, Ljava/lang/String;

    goto :goto_0
.end method

.method public getControlIdBytes()Lcom/google/protobuf/ByteString;
    .locals 2

    .prologue
    .line 6049
    iget-object v0, p0, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$ControlVar$Builder;->controlId_:Ljava/lang/Object;

    .line 6050
    instance-of v1, v0, Ljava/lang/String;

    if-eqz v1, :cond_0

    .line 6051
    check-cast v0, Ljava/lang/String;

    .line 6052
    invoke-static {v0}, Lcom/google/protobuf/ByteString;->copyFromUtf8(Ljava/lang/String;)Lcom/google/protobuf/ByteString;

    move-result-object v0

    .line 6054
    iput-object v0, p0, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$ControlVar$Builder;->controlId_:Ljava/lang/Object;

    .line 6057
    :goto_0
    return-object v0

    :cond_0
    check-cast v0, Lcom/google/protobuf/ByteString;

    goto :goto_0
.end method

.method public getDefaultInstanceForType()Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$ControlVar;
    .locals 1

    .prologue
    .line 5921
    invoke-static {}, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$ControlVar;->getDefaultInstance()Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$ControlVar;

    move-result-object v0

    return-object v0
.end method

.method public bridge synthetic getDefaultInstanceForType()Lcom/google/protobuf/Message;
    .locals 1

    .prologue
    .line 5863
    invoke-virtual {p0}, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$ControlVar$Builder;->getDefaultInstanceForType()Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$ControlVar;

    move-result-object v0

    return-object v0
.end method

.method public bridge synthetic getDefaultInstanceForType()Lcom/google/protobuf/MessageLite;
    .locals 1

    .prologue
    .line 5863
    invoke-virtual {p0}, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$ControlVar$Builder;->getDefaultInstanceForType()Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$ControlVar;

    move-result-object v0

    return-object v0
.end method

.method public getDescriptorForType()Lcom/google/protobuf/Descriptors$Descriptor;
    .locals 1

    .prologue
    .line 5917
    invoke-static {}, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage;->h()Lcom/google/protobuf/Descriptors$Descriptor;

    move-result-object v0

    return-object v0
.end method

.method public getIntValue()I
    .locals 1

    .prologue
    .line 6177
    iget v0, p0, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$ControlVar$Builder;->intValue_:I

    return v0
.end method

.method public getStringValue()Ljava/lang/String;
    .locals 2

    .prologue
    .line 6210
    iget-object v0, p0, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$ControlVar$Builder;->stringValue_:Ljava/lang/Object;

    .line 6211
    instance-of v1, v0, Ljava/lang/String;

    if-nez v1, :cond_0

    .line 6212
    check-cast v0, Lcom/google/protobuf/ByteString;

    .line 6213
    invoke-virtual {v0}, Lcom/google/protobuf/ByteString;->toStringUtf8()Ljava/lang/String;

    move-result-object v0

    .line 6214
    iput-object v0, p0, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$ControlVar$Builder;->stringValue_:Ljava/lang/Object;

    .line 6217
    :goto_0
    return-object v0

    :cond_0
    check-cast v0, Ljava/lang/String;

    goto :goto_0
.end method

.method public getStringValueBytes()Lcom/google/protobuf/ByteString;
    .locals 2

    .prologue
    .line 6225
    iget-object v0, p0, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$ControlVar$Builder;->stringValue_:Ljava/lang/Object;

    .line 6226
    instance-of v1, v0, Ljava/lang/String;

    if-eqz v1, :cond_0

    .line 6227
    check-cast v0, Ljava/lang/String;

    .line 6228
    invoke-static {v0}, Lcom/google/protobuf/ByteString;->copyFromUtf8(Ljava/lang/String;)Lcom/google/protobuf/ByteString;

    move-result-object v0

    .line 6230
    iput-object v0, p0, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$ControlVar$Builder;->stringValue_:Ljava/lang/Object;

    .line 6233
    :goto_0
    return-object v0

    :cond_0
    check-cast v0, Lcom/google/protobuf/ByteString;

    goto :goto_0
.end method

.method public getType()Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$ControlVar$Data_Type;
    .locals 1

    .prologue
    .line 6108
    iget-object v0, p0, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$ControlVar$Builder;->type_:Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$ControlVar$Data_Type;

    return-object v0
.end method

.method public hasBoolValue()Z
    .locals 2

    .prologue
    .line 6138
    iget v0, p0, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$ControlVar$Builder;->bitField0_:I

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

.method public hasControlId()Z
    .locals 2

    .prologue
    const/4 v0, 0x1

    .line 6028
    iget v1, p0, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$ControlVar$Builder;->bitField0_:I

    and-int/lit8 v1, v1, 0x1

    if-ne v1, v0, :cond_0

    :goto_0
    return v0

    :cond_0
    const/4 v0, 0x0

    goto :goto_0
.end method

.method public hasIntValue()Z
    .locals 2

    .prologue
    .line 6171
    iget v0, p0, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$ControlVar$Builder;->bitField0_:I

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

.method public hasStringValue()Z
    .locals 2

    .prologue
    .line 6204
    iget v0, p0, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$ControlVar$Builder;->bitField0_:I

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

.method public hasType()Z
    .locals 2

    .prologue
    .line 6102
    iget v0, p0, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$ControlVar$Builder;->bitField0_:I

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
    .line 5873
    invoke-static {}, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage;->i()Lcom/google/protobuf/GeneratedMessage$FieldAccessorTable;

    move-result-object v0

    const-class v1, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$ControlVar;

    const-class v2, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$ControlVar$Builder;

    .line 5874
    invoke-virtual {v0, v1, v2}, Lcom/google/protobuf/GeneratedMessage$FieldAccessorTable;->ensureFieldAccessorsInitialized(Ljava/lang/Class;Ljava/lang/Class;)Lcom/google/protobuf/GeneratedMessage$FieldAccessorTable;

    move-result-object v0

    .line 5873
    return-object v0
.end method

.method public final isInitialized()Z
    .locals 1

    .prologue
    .line 5996
    invoke-virtual {p0}, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$ControlVar$Builder;->hasControlId()Z

    move-result v0

    if-nez v0, :cond_0

    .line 5998
    const/4 v0, 0x0

    .line 6000
    :goto_0
    return v0

    :cond_0
    const/4 v0, 0x1

    goto :goto_0
.end method

.method public mergeFrom(Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$ControlVar;)Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$ControlVar$Builder;
    .locals 1

    .prologue
    .line 5971
    invoke-static {}, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$ControlVar;->getDefaultInstance()Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$ControlVar;

    move-result-object v0

    if-ne p1, v0, :cond_0

    .line 5992
    :goto_0
    return-object p0

    .line 5972
    :cond_0
    invoke-virtual {p1}, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$ControlVar;->hasControlId()Z

    move-result v0

    if-eqz v0, :cond_1

    .line 5973
    iget v0, p0, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$ControlVar$Builder;->bitField0_:I

    or-int/lit8 v0, v0, 0x1

    iput v0, p0, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$ControlVar$Builder;->bitField0_:I

    .line 5974
    invoke-static {p1}, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$ControlVar;->access$6100(Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$ControlVar;)Ljava/lang/Object;

    move-result-object v0

    iput-object v0, p0, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$ControlVar$Builder;->controlId_:Ljava/lang/Object;

    .line 5975
    invoke-virtual {p0}, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$ControlVar$Builder;->onChanged()V

    .line 5977
    :cond_1
    invoke-virtual {p1}, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$ControlVar;->hasType()Z

    move-result v0

    if-eqz v0, :cond_2

    .line 5978
    invoke-virtual {p1}, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$ControlVar;->getType()Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$ControlVar$Data_Type;

    move-result-object v0

    invoke-virtual {p0, v0}, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$ControlVar$Builder;->setType(Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$ControlVar$Data_Type;)Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$ControlVar$Builder;

    .line 5980
    :cond_2
    invoke-virtual {p1}, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$ControlVar;->hasBoolValue()Z

    move-result v0

    if-eqz v0, :cond_3

    .line 5981
    invoke-virtual {p1}, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$ControlVar;->getBoolValue()Z

    move-result v0

    invoke-virtual {p0, v0}, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$ControlVar$Builder;->setBoolValue(Z)Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$ControlVar$Builder;

    .line 5983
    :cond_3
    invoke-virtual {p1}, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$ControlVar;->hasIntValue()Z

    move-result v0

    if-eqz v0, :cond_4

    .line 5984
    invoke-virtual {p1}, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$ControlVar;->getIntValue()I

    move-result v0

    invoke-virtual {p0, v0}, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$ControlVar$Builder;->setIntValue(I)Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$ControlVar$Builder;

    .line 5986
    :cond_4
    invoke-virtual {p1}, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$ControlVar;->hasStringValue()Z

    move-result v0

    if-eqz v0, :cond_5

    .line 5987
    iget v0, p0, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$ControlVar$Builder;->bitField0_:I

    or-int/lit8 v0, v0, 0x10

    iput v0, p0, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$ControlVar$Builder;->bitField0_:I

    .line 5988
    invoke-static {p1}, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$ControlVar;->access$6500(Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$ControlVar;)Ljava/lang/Object;

    move-result-object v0

    iput-object v0, p0, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$ControlVar$Builder;->stringValue_:Ljava/lang/Object;

    .line 5989
    invoke-virtual {p0}, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$ControlVar$Builder;->onChanged()V

    .line 5991
    :cond_5
    invoke-virtual {p1}, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$ControlVar;->getUnknownFields()Lcom/google/protobuf/UnknownFieldSet;

    move-result-object v0

    invoke-virtual {p0, v0}, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$ControlVar$Builder;->mergeUnknownFields(Lcom/google/protobuf/UnknownFieldSet;)Lcom/google/protobuf/GeneratedMessage$Builder;

    goto :goto_0
.end method

.method public mergeFrom(Lcom/google/protobuf/CodedInputStream;Lcom/google/protobuf/ExtensionRegistryLite;)Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$ControlVar$Builder;
    .locals 4
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljava/io/IOException;
        }
    .end annotation

    .prologue
    .line 6007
    const/4 v2, 0x0

    .line 6009
    :try_start_0
    sget-object v0, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$ControlVar;->PARSER:Lcom/google/protobuf/Parser;

    invoke-interface {v0, p1, p2}, Lcom/google/protobuf/Parser;->parsePartialFrom(Lcom/google/protobuf/CodedInputStream;Lcom/google/protobuf/ExtensionRegistryLite;)Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$ControlVar;
    :try_end_0
    .catch Lcom/google/protobuf/InvalidProtocolBufferException; {:try_start_0 .. :try_end_0} :catch_0
    .catchall {:try_start_0 .. :try_end_0} :catchall_1

    .line 6014
    if-eqz v0, :cond_0

    .line 6015
    invoke-virtual {p0, v0}, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$ControlVar$Builder;->mergeFrom(Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$ControlVar;)Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$ControlVar$Builder;

    .line 6018
    :cond_0
    return-object p0

    .line 6010
    :catch_0
    move-exception v0

    move-object v1, v0

    .line 6011
    :try_start_1
    invoke-virtual {v1}, Lcom/google/protobuf/InvalidProtocolBufferException;->getUnfinishedMessage()Lcom/google/protobuf/MessageLite;

    move-result-object v0

    check-cast v0, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$ControlVar;
    :try_end_1
    .catchall {:try_start_1 .. :try_end_1} :catchall_1

    .line 6012
    :try_start_2
    throw v1
    :try_end_2
    .catchall {:try_start_2 .. :try_end_2} :catchall_0

    .line 6014
    :catchall_0
    move-exception v1

    move-object v3, v1

    move-object v1, v0

    move-object v0, v3

    :goto_0
    if-eqz v1, :cond_1

    .line 6015
    invoke-virtual {p0, v1}, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$ControlVar$Builder;->mergeFrom(Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$ControlVar;)Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$ControlVar$Builder;

    :cond_1
    throw v0

    .line 6014
    :catchall_1
    move-exception v0

    move-object v1, v2

    goto :goto_0
.end method

.method public mergeFrom(Lcom/google/protobuf/Message;)Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$ControlVar$Builder;
    .locals 1

    .prologue
    .line 5962
    instance-of v0, p1, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$ControlVar;

    if-eqz v0, :cond_0

    .line 5963
    check-cast p1, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$ControlVar;

    invoke-virtual {p0, p1}, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$ControlVar$Builder;->mergeFrom(Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$ControlVar;)Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$ControlVar$Builder;

    move-result-object p0

    .line 5966
    :goto_0
    return-object p0

    .line 5965
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
    .line 5863
    invoke-virtual {p0, p1, p2}, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$ControlVar$Builder;->mergeFrom(Lcom/google/protobuf/CodedInputStream;Lcom/google/protobuf/ExtensionRegistryLite;)Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$ControlVar$Builder;

    move-result-object v0

    return-object v0
.end method

.method public bridge synthetic mergeFrom(Lcom/google/protobuf/Message;)Lcom/google/protobuf/AbstractMessage$Builder;
    .locals 1

    .prologue
    .line 5863
    invoke-virtual {p0, p1}, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$ControlVar$Builder;->mergeFrom(Lcom/google/protobuf/Message;)Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$ControlVar$Builder;

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
    .line 5863
    invoke-virtual {p0, p1, p2}, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$ControlVar$Builder;->mergeFrom(Lcom/google/protobuf/CodedInputStream;Lcom/google/protobuf/ExtensionRegistryLite;)Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$ControlVar$Builder;

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
    .line 5863
    invoke-virtual {p0, p1, p2}, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$ControlVar$Builder;->mergeFrom(Lcom/google/protobuf/CodedInputStream;Lcom/google/protobuf/ExtensionRegistryLite;)Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$ControlVar$Builder;

    move-result-object v0

    return-object v0
.end method

.method public bridge synthetic mergeFrom(Lcom/google/protobuf/Message;)Lcom/google/protobuf/Message$Builder;
    .locals 1

    .prologue
    .line 5863
    invoke-virtual {p0, p1}, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$ControlVar$Builder;->mergeFrom(Lcom/google/protobuf/Message;)Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$ControlVar$Builder;

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
    .line 5863
    invoke-virtual {p0, p1, p2}, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$ControlVar$Builder;->mergeFrom(Lcom/google/protobuf/CodedInputStream;Lcom/google/protobuf/ExtensionRegistryLite;)Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$ControlVar$Builder;

    move-result-object v0

    return-object v0
.end method

.method public setBoolValue(Z)Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$ControlVar$Builder;
    .locals 1

    .prologue
    .line 6150
    iget v0, p0, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$ControlVar$Builder;->bitField0_:I

    or-int/lit8 v0, v0, 0x4

    iput v0, p0, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$ControlVar$Builder;->bitField0_:I

    .line 6151
    iput-boolean p1, p0, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$ControlVar$Builder;->boolValue_:Z

    .line 6152
    invoke-virtual {p0}, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$ControlVar$Builder;->onChanged()V

    .line 6153
    return-object p0
.end method

.method public setControlId(Ljava/lang/String;)Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$ControlVar$Builder;
    .locals 1

    .prologue
    .line 6065
    if-nez p1, :cond_0

    .line 6066
    new-instance v0, Ljava/lang/NullPointerException;

    invoke-direct {v0}, Ljava/lang/NullPointerException;-><init>()V

    throw v0

    .line 6068
    :cond_0
    iget v0, p0, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$ControlVar$Builder;->bitField0_:I

    or-int/lit8 v0, v0, 0x1

    iput v0, p0, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$ControlVar$Builder;->bitField0_:I

    .line 6069
    iput-object p1, p0, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$ControlVar$Builder;->controlId_:Ljava/lang/Object;

    .line 6070
    invoke-virtual {p0}, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$ControlVar$Builder;->onChanged()V

    .line 6071
    return-object p0
.end method

.method public setControlIdBytes(Lcom/google/protobuf/ByteString;)Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$ControlVar$Builder;
    .locals 1

    .prologue
    .line 6087
    if-nez p1, :cond_0

    .line 6088
    new-instance v0, Ljava/lang/NullPointerException;

    invoke-direct {v0}, Ljava/lang/NullPointerException;-><init>()V

    throw v0

    .line 6090
    :cond_0
    iget v0, p0, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$ControlVar$Builder;->bitField0_:I

    or-int/lit8 v0, v0, 0x1

    iput v0, p0, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$ControlVar$Builder;->bitField0_:I

    .line 6091
    iput-object p1, p0, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$ControlVar$Builder;->controlId_:Ljava/lang/Object;

    .line 6092
    invoke-virtual {p0}, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$ControlVar$Builder;->onChanged()V

    .line 6093
    return-object p0
.end method

.method public setIntValue(I)Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$ControlVar$Builder;
    .locals 1

    .prologue
    .line 6183
    iget v0, p0, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$ControlVar$Builder;->bitField0_:I

    or-int/lit8 v0, v0, 0x8

    iput v0, p0, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$ControlVar$Builder;->bitField0_:I

    .line 6184
    iput p1, p0, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$ControlVar$Builder;->intValue_:I

    .line 6185
    invoke-virtual {p0}, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$ControlVar$Builder;->onChanged()V

    .line 6186
    return-object p0
.end method

.method public setStringValue(Ljava/lang/String;)Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$ControlVar$Builder;
    .locals 1

    .prologue
    .line 6241
    if-nez p1, :cond_0

    .line 6242
    new-instance v0, Ljava/lang/NullPointerException;

    invoke-direct {v0}, Ljava/lang/NullPointerException;-><init>()V

    throw v0

    .line 6244
    :cond_0
    iget v0, p0, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$ControlVar$Builder;->bitField0_:I

    or-int/lit8 v0, v0, 0x10

    iput v0, p0, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$ControlVar$Builder;->bitField0_:I

    .line 6245
    iput-object p1, p0, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$ControlVar$Builder;->stringValue_:Ljava/lang/Object;

    .line 6246
    invoke-virtual {p0}, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$ControlVar$Builder;->onChanged()V

    .line 6247
    return-object p0
.end method

.method public setStringValueBytes(Lcom/google/protobuf/ByteString;)Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$ControlVar$Builder;
    .locals 1

    .prologue
    .line 6263
    if-nez p1, :cond_0

    .line 6264
    new-instance v0, Ljava/lang/NullPointerException;

    invoke-direct {v0}, Ljava/lang/NullPointerException;-><init>()V

    throw v0

    .line 6266
    :cond_0
    iget v0, p0, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$ControlVar$Builder;->bitField0_:I

    or-int/lit8 v0, v0, 0x10

    iput v0, p0, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$ControlVar$Builder;->bitField0_:I

    .line 6267
    iput-object p1, p0, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$ControlVar$Builder;->stringValue_:Ljava/lang/Object;

    .line 6268
    invoke-virtual {p0}, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$ControlVar$Builder;->onChanged()V

    .line 6269
    return-object p0
.end method

.method public setType(Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$ControlVar$Data_Type;)Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$ControlVar$Builder;
    .locals 1

    .prologue
    .line 6114
    if-nez p1, :cond_0

    .line 6115
    new-instance v0, Ljava/lang/NullPointerException;

    invoke-direct {v0}, Ljava/lang/NullPointerException;-><init>()V

    throw v0

    .line 6117
    :cond_0
    iget v0, p0, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$ControlVar$Builder;->bitField0_:I

    or-int/lit8 v0, v0, 0x2

    iput v0, p0, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$ControlVar$Builder;->bitField0_:I

    .line 6118
    iput-object p1, p0, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$ControlVar$Builder;->type_:Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$ControlVar$Data_Type;

    .line 6119
    invoke-virtual {p0}, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$ControlVar$Builder;->onChanged()V

    .line 6120
    return-object p0
.end method
