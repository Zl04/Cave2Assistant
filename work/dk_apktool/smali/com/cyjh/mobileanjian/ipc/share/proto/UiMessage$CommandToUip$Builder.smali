.class public final Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$CommandToUip$Builder;
.super Lcom/google/protobuf/GeneratedMessage$Builder;
.source "SourceFile"

# interfaces
.implements Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$CommandToUipOrBuilder;


# annotations
.annotation system Ldalvik/annotation/EnclosingClass;
    value = Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$CommandToUip;
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x19
    name = "Builder"
.end annotation

.annotation system Ldalvik/annotation/Signature;
    value = {
        "Lcom/google/protobuf/GeneratedMessage$Builder",
        "<",
        "Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$CommandToUip$Builder;",
        ">;",
        "Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$CommandToUipOrBuilder;"
    }
.end annotation


# instance fields
.field private bitField0_:I

.field private command_:Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$CommandToUip$Command_Type;

.field private controlId_:Ljava/lang/Object;

.field private uipAttributeData_:Ljava/lang/Object;


# direct methods
.method private constructor <init>()V
    .locals 1

    .prologue
    .line 7932
    invoke-direct {p0}, Lcom/google/protobuf/GeneratedMessage$Builder;-><init>()V

    .line 8058
    sget-object v0, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$CommandToUip$Command_Type;->GET_UIP_ATTRIBUTE:Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$CommandToUip$Command_Type;

    iput-object v0, p0, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$CommandToUip$Builder;->command_:Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$CommandToUip$Command_Type;

    .line 8094
    const-string v0, ""

    iput-object v0, p0, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$CommandToUip$Builder;->controlId_:Ljava/lang/Object;

    .line 8168
    const-string v0, ""

    iput-object v0, p0, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$CommandToUip$Builder;->uipAttributeData_:Ljava/lang/Object;

    .line 7933
    invoke-direct {p0}, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$CommandToUip$Builder;->maybeForceBuilderInitialization()V

    .line 7934
    return-void
.end method

.method private constructor <init>(Lcom/google/protobuf/GeneratedMessage$BuilderParent;)V
    .locals 1

    .prologue
    .line 7938
    invoke-direct {p0, p1}, Lcom/google/protobuf/GeneratedMessage$Builder;-><init>(Lcom/google/protobuf/GeneratedMessage$BuilderParent;)V

    .line 8058
    sget-object v0, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$CommandToUip$Command_Type;->GET_UIP_ATTRIBUTE:Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$CommandToUip$Command_Type;

    iput-object v0, p0, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$CommandToUip$Builder;->command_:Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$CommandToUip$Command_Type;

    .line 8094
    const-string v0, ""

    iput-object v0, p0, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$CommandToUip$Builder;->controlId_:Ljava/lang/Object;

    .line 8168
    const-string v0, ""

    iput-object v0, p0, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$CommandToUip$Builder;->uipAttributeData_:Ljava/lang/Object;

    .line 7939
    invoke-direct {p0}, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$CommandToUip$Builder;->maybeForceBuilderInitialization()V

    .line 7940
    return-void
.end method

.method synthetic constructor <init>(Lcom/google/protobuf/GeneratedMessage$BuilderParent;Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$1;)V
    .locals 0

    .prologue
    .line 7916
    invoke-direct {p0, p1}, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$CommandToUip$Builder;-><init>(Lcom/google/protobuf/GeneratedMessage$BuilderParent;)V

    return-void
.end method

.method static synthetic access$8300()Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$CommandToUip$Builder;
    .locals 1

    .prologue
    .line 7916
    invoke-static {}, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$CommandToUip$Builder;->create()Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$CommandToUip$Builder;

    move-result-object v0

    return-object v0
.end method

.method private static create()Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$CommandToUip$Builder;
    .locals 1

    .prologue
    .line 7946
    new-instance v0, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$CommandToUip$Builder;

    invoke-direct {v0}, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$CommandToUip$Builder;-><init>()V

    return-object v0
.end method

.method public static final getDescriptor()Lcom/google/protobuf/Descriptors$Descriptor;
    .locals 1

    .prologue
    .line 7921
    invoke-static {}, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage;->l()Lcom/google/protobuf/Descriptors$Descriptor;

    move-result-object v0

    return-object v0
.end method

.method private maybeForceBuilderInitialization()V
    .locals 1

    .prologue
    .line 7942
    invoke-static {}, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$CommandToUip;->access$8500()Z

    move-result v0

    if-eqz v0, :cond_0

    .line 7944
    :cond_0
    return-void
.end method


# virtual methods
.method public build()Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$CommandToUip;
    .locals 2

    .prologue
    .line 7974
    invoke-virtual {p0}, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$CommandToUip$Builder;->buildPartial()Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$CommandToUip;

    move-result-object v0

    .line 7975
    invoke-virtual {v0}, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$CommandToUip;->isInitialized()Z

    move-result v1

    if-nez v1, :cond_0

    .line 7976
    invoke-static {v0}, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$CommandToUip$Builder;->newUninitializedMessageException(Lcom/google/protobuf/Message;)Lcom/google/protobuf/UninitializedMessageException;

    move-result-object v0

    throw v0

    .line 7978
    :cond_0
    return-object v0
.end method

.method public bridge synthetic build()Lcom/google/protobuf/Message;
    .locals 1

    .prologue
    .line 7916
    invoke-virtual {p0}, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$CommandToUip$Builder;->build()Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$CommandToUip;

    move-result-object v0

    return-object v0
.end method

.method public bridge synthetic build()Lcom/google/protobuf/MessageLite;
    .locals 1

    .prologue
    .line 7916
    invoke-virtual {p0}, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$CommandToUip$Builder;->build()Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$CommandToUip;

    move-result-object v0

    return-object v0
.end method

.method public buildPartial()Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$CommandToUip;
    .locals 5

    .prologue
    const/4 v0, 0x1

    .line 7982
    new-instance v2, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$CommandToUip;

    const/4 v1, 0x0

    invoke-direct {v2, p0, v1}, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$CommandToUip;-><init>(Lcom/google/protobuf/GeneratedMessage$Builder;Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$1;)V

    .line 7983
    iget v3, p0, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$CommandToUip$Builder;->bitField0_:I

    .line 7984
    const/4 v1, 0x0

    .line 7985
    and-int/lit8 v4, v3, 0x1

    if-ne v4, v0, :cond_2

    .line 7988
    :goto_0
    iget-object v1, p0, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$CommandToUip$Builder;->command_:Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$CommandToUip$Command_Type;

    invoke-static {v2, v1}, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$CommandToUip;->access$8702(Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$CommandToUip;Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$CommandToUip$Command_Type;)Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$CommandToUip$Command_Type;

    .line 7989
    and-int/lit8 v1, v3, 0x2

    const/4 v4, 0x2

    if-ne v1, v4, :cond_0

    .line 7990
    or-int/lit8 v0, v0, 0x2

    .line 7992
    :cond_0
    iget-object v1, p0, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$CommandToUip$Builder;->controlId_:Ljava/lang/Object;

    invoke-static {v2, v1}, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$CommandToUip;->access$8802(Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$CommandToUip;Ljava/lang/Object;)Ljava/lang/Object;

    .line 7993
    and-int/lit8 v1, v3, 0x4

    const/4 v3, 0x4

    if-ne v1, v3, :cond_1

    .line 7994
    or-int/lit8 v0, v0, 0x4

    .line 7996
    :cond_1
    iget-object v1, p0, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$CommandToUip$Builder;->uipAttributeData_:Ljava/lang/Object;

    invoke-static {v2, v1}, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$CommandToUip;->access$8902(Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$CommandToUip;Ljava/lang/Object;)Ljava/lang/Object;

    .line 7997
    invoke-static {v2, v0}, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$CommandToUip;->access$9002(Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$CommandToUip;I)I

    .line 7998
    invoke-virtual {p0}, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$CommandToUip$Builder;->onBuilt()V

    .line 7999
    return-object v2

    :cond_2
    move v0, v1

    goto :goto_0
.end method

.method public bridge synthetic buildPartial()Lcom/google/protobuf/Message;
    .locals 1

    .prologue
    .line 7916
    invoke-virtual {p0}, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$CommandToUip$Builder;->buildPartial()Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$CommandToUip;

    move-result-object v0

    return-object v0
.end method

.method public bridge synthetic buildPartial()Lcom/google/protobuf/MessageLite;
    .locals 1

    .prologue
    .line 7916
    invoke-virtual {p0}, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$CommandToUip$Builder;->buildPartial()Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$CommandToUip;

    move-result-object v0

    return-object v0
.end method

.method public clear()Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$CommandToUip$Builder;
    .locals 1

    .prologue
    .line 7950
    invoke-super {p0}, Lcom/google/protobuf/GeneratedMessage$Builder;->clear()Lcom/google/protobuf/GeneratedMessage$Builder;

    .line 7951
    sget-object v0, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$CommandToUip$Command_Type;->GET_UIP_ATTRIBUTE:Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$CommandToUip$Command_Type;

    iput-object v0, p0, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$CommandToUip$Builder;->command_:Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$CommandToUip$Command_Type;

    .line 7952
    iget v0, p0, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$CommandToUip$Builder;->bitField0_:I

    and-int/lit8 v0, v0, -0x2

    iput v0, p0, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$CommandToUip$Builder;->bitField0_:I

    .line 7953
    const-string v0, ""

    iput-object v0, p0, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$CommandToUip$Builder;->controlId_:Ljava/lang/Object;

    .line 7954
    iget v0, p0, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$CommandToUip$Builder;->bitField0_:I

    and-int/lit8 v0, v0, -0x3

    iput v0, p0, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$CommandToUip$Builder;->bitField0_:I

    .line 7955
    const-string v0, ""

    iput-object v0, p0, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$CommandToUip$Builder;->uipAttributeData_:Ljava/lang/Object;

    .line 7956
    iget v0, p0, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$CommandToUip$Builder;->bitField0_:I

    and-int/lit8 v0, v0, -0x5

    iput v0, p0, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$CommandToUip$Builder;->bitField0_:I

    .line 7957
    return-object p0
.end method

.method public bridge synthetic clear()Lcom/google/protobuf/AbstractMessage$Builder;
    .locals 1

    .prologue
    .line 7916
    invoke-virtual {p0}, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$CommandToUip$Builder;->clear()Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$CommandToUip$Builder;

    move-result-object v0

    return-object v0
.end method

.method public bridge synthetic clear()Lcom/google/protobuf/GeneratedMessage$Builder;
    .locals 1

    .prologue
    .line 7916
    invoke-virtual {p0}, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$CommandToUip$Builder;->clear()Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$CommandToUip$Builder;

    move-result-object v0

    return-object v0
.end method

.method public bridge synthetic clear()Lcom/google/protobuf/Message$Builder;
    .locals 1

    .prologue
    .line 7916
    invoke-virtual {p0}, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$CommandToUip$Builder;->clear()Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$CommandToUip$Builder;

    move-result-object v0

    return-object v0
.end method

.method public bridge synthetic clear()Lcom/google/protobuf/MessageLite$Builder;
    .locals 1

    .prologue
    .line 7916
    invoke-virtual {p0}, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$CommandToUip$Builder;->clear()Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$CommandToUip$Builder;

    move-result-object v0

    return-object v0
.end method

.method public clearCommand()Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$CommandToUip$Builder;
    .locals 1

    .prologue
    .line 8087
    iget v0, p0, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$CommandToUip$Builder;->bitField0_:I

    and-int/lit8 v0, v0, -0x2

    iput v0, p0, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$CommandToUip$Builder;->bitField0_:I

    .line 8088
    sget-object v0, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$CommandToUip$Command_Type;->GET_UIP_ATTRIBUTE:Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$CommandToUip$Command_Type;

    iput-object v0, p0, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$CommandToUip$Builder;->command_:Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$CommandToUip$Command_Type;

    .line 8089
    invoke-virtual {p0}, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$CommandToUip$Builder;->onChanged()V

    .line 8090
    return-object p0
.end method

.method public clearControlId()Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$CommandToUip$Builder;
    .locals 1

    .prologue
    .line 8148
    iget v0, p0, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$CommandToUip$Builder;->bitField0_:I

    and-int/lit8 v0, v0, -0x3

    iput v0, p0, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$CommandToUip$Builder;->bitField0_:I

    .line 8149
    invoke-static {}, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$CommandToUip;->getDefaultInstance()Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$CommandToUip;

    move-result-object v0

    invoke-virtual {v0}, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$CommandToUip;->getControlId()Ljava/lang/String;

    move-result-object v0

    iput-object v0, p0, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$CommandToUip$Builder;->controlId_:Ljava/lang/Object;

    .line 8150
    invoke-virtual {p0}, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$CommandToUip$Builder;->onChanged()V

    .line 8151
    return-object p0
.end method

.method public clearUipAttributeData()Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$CommandToUip$Builder;
    .locals 1

    .prologue
    .line 8222
    iget v0, p0, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$CommandToUip$Builder;->bitField0_:I

    and-int/lit8 v0, v0, -0x5

    iput v0, p0, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$CommandToUip$Builder;->bitField0_:I

    .line 8223
    invoke-static {}, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$CommandToUip;->getDefaultInstance()Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$CommandToUip;

    move-result-object v0

    invoke-virtual {v0}, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$CommandToUip;->getUipAttributeData()Ljava/lang/String;

    move-result-object v0

    iput-object v0, p0, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$CommandToUip$Builder;->uipAttributeData_:Ljava/lang/Object;

    .line 8224
    invoke-virtual {p0}, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$CommandToUip$Builder;->onChanged()V

    .line 8225
    return-object p0
.end method

.method public clone()Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$CommandToUip$Builder;
    .locals 2

    .prologue
    .line 7961
    invoke-static {}, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$CommandToUip$Builder;->create()Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$CommandToUip$Builder;

    move-result-object v0

    invoke-virtual {p0}, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$CommandToUip$Builder;->buildPartial()Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$CommandToUip;

    move-result-object v1

    invoke-virtual {v0, v1}, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$CommandToUip$Builder;->mergeFrom(Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$CommandToUip;)Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$CommandToUip$Builder;

    move-result-object v0

    return-object v0
.end method

.method public bridge synthetic clone()Lcom/google/protobuf/AbstractMessage$Builder;
    .locals 1

    .prologue
    .line 7916
    invoke-virtual {p0}, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$CommandToUip$Builder;->clone()Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$CommandToUip$Builder;

    move-result-object v0

    return-object v0
.end method

.method public bridge synthetic clone()Lcom/google/protobuf/AbstractMessageLite$Builder;
    .locals 1

    .prologue
    .line 7916
    invoke-virtual {p0}, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$CommandToUip$Builder;->clone()Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$CommandToUip$Builder;

    move-result-object v0

    return-object v0
.end method

.method public bridge synthetic clone()Lcom/google/protobuf/GeneratedMessage$Builder;
    .locals 1

    .prologue
    .line 7916
    invoke-virtual {p0}, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$CommandToUip$Builder;->clone()Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$CommandToUip$Builder;

    move-result-object v0

    return-object v0
.end method

.method public bridge synthetic clone()Lcom/google/protobuf/Message$Builder;
    .locals 1

    .prologue
    .line 7916
    invoke-virtual {p0}, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$CommandToUip$Builder;->clone()Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$CommandToUip$Builder;

    move-result-object v0

    return-object v0
.end method

.method public bridge synthetic clone()Lcom/google/protobuf/MessageLite$Builder;
    .locals 1

    .prologue
    .line 7916
    invoke-virtual {p0}, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$CommandToUip$Builder;->clone()Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$CommandToUip$Builder;

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
    .line 7916
    invoke-virtual {p0}, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$CommandToUip$Builder;->clone()Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$CommandToUip$Builder;

    move-result-object v0

    return-object v0
.end method

.method public getCommand()Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$CommandToUip$Command_Type;
    .locals 1

    .prologue
    .line 8069
    iget-object v0, p0, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$CommandToUip$Builder;->command_:Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$CommandToUip$Command_Type;

    return-object v0
.end method

.method public getControlId()Ljava/lang/String;
    .locals 2

    .prologue
    .line 8105
    iget-object v0, p0, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$CommandToUip$Builder;->controlId_:Ljava/lang/Object;

    .line 8106
    instance-of v1, v0, Ljava/lang/String;

    if-nez v1, :cond_0

    .line 8107
    check-cast v0, Lcom/google/protobuf/ByteString;

    .line 8108
    invoke-virtual {v0}, Lcom/google/protobuf/ByteString;->toStringUtf8()Ljava/lang/String;

    move-result-object v0

    .line 8109
    iput-object v0, p0, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$CommandToUip$Builder;->controlId_:Ljava/lang/Object;

    .line 8112
    :goto_0
    return-object v0

    :cond_0
    check-cast v0, Ljava/lang/String;

    goto :goto_0
.end method

.method public getControlIdBytes()Lcom/google/protobuf/ByteString;
    .locals 2

    .prologue
    .line 8120
    iget-object v0, p0, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$CommandToUip$Builder;->controlId_:Ljava/lang/Object;

    .line 8121
    instance-of v1, v0, Ljava/lang/String;

    if-eqz v1, :cond_0

    .line 8122
    check-cast v0, Ljava/lang/String;

    .line 8123
    invoke-static {v0}, Lcom/google/protobuf/ByteString;->copyFromUtf8(Ljava/lang/String;)Lcom/google/protobuf/ByteString;

    move-result-object v0

    .line 8125
    iput-object v0, p0, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$CommandToUip$Builder;->controlId_:Ljava/lang/Object;

    .line 8128
    :goto_0
    return-object v0

    :cond_0
    check-cast v0, Lcom/google/protobuf/ByteString;

    goto :goto_0
.end method

.method public getDefaultInstanceForType()Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$CommandToUip;
    .locals 1

    .prologue
    .line 7970
    invoke-static {}, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$CommandToUip;->getDefaultInstance()Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$CommandToUip;

    move-result-object v0

    return-object v0
.end method

.method public bridge synthetic getDefaultInstanceForType()Lcom/google/protobuf/Message;
    .locals 1

    .prologue
    .line 7916
    invoke-virtual {p0}, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$CommandToUip$Builder;->getDefaultInstanceForType()Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$CommandToUip;

    move-result-object v0

    return-object v0
.end method

.method public bridge synthetic getDefaultInstanceForType()Lcom/google/protobuf/MessageLite;
    .locals 1

    .prologue
    .line 7916
    invoke-virtual {p0}, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$CommandToUip$Builder;->getDefaultInstanceForType()Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$CommandToUip;

    move-result-object v0

    return-object v0
.end method

.method public getDescriptorForType()Lcom/google/protobuf/Descriptors$Descriptor;
    .locals 1

    .prologue
    .line 7966
    invoke-static {}, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage;->l()Lcom/google/protobuf/Descriptors$Descriptor;

    move-result-object v0

    return-object v0
.end method

.method public getUipAttributeData()Ljava/lang/String;
    .locals 2

    .prologue
    .line 8179
    iget-object v0, p0, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$CommandToUip$Builder;->uipAttributeData_:Ljava/lang/Object;

    .line 8180
    instance-of v1, v0, Ljava/lang/String;

    if-nez v1, :cond_0

    .line 8181
    check-cast v0, Lcom/google/protobuf/ByteString;

    .line 8182
    invoke-virtual {v0}, Lcom/google/protobuf/ByteString;->toStringUtf8()Ljava/lang/String;

    move-result-object v0

    .line 8183
    iput-object v0, p0, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$CommandToUip$Builder;->uipAttributeData_:Ljava/lang/Object;

    .line 8186
    :goto_0
    return-object v0

    :cond_0
    check-cast v0, Ljava/lang/String;

    goto :goto_0
.end method

.method public getUipAttributeDataBytes()Lcom/google/protobuf/ByteString;
    .locals 2

    .prologue
    .line 8194
    iget-object v0, p0, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$CommandToUip$Builder;->uipAttributeData_:Ljava/lang/Object;

    .line 8195
    instance-of v1, v0, Ljava/lang/String;

    if-eqz v1, :cond_0

    .line 8196
    check-cast v0, Ljava/lang/String;

    .line 8197
    invoke-static {v0}, Lcom/google/protobuf/ByteString;->copyFromUtf8(Ljava/lang/String;)Lcom/google/protobuf/ByteString;

    move-result-object v0

    .line 8199
    iput-object v0, p0, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$CommandToUip$Builder;->uipAttributeData_:Ljava/lang/Object;

    .line 8202
    :goto_0
    return-object v0

    :cond_0
    check-cast v0, Lcom/google/protobuf/ByteString;

    goto :goto_0
.end method

.method public hasCommand()Z
    .locals 2

    .prologue
    const/4 v0, 0x1

    .line 8063
    iget v1, p0, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$CommandToUip$Builder;->bitField0_:I

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
    .line 8099
    iget v0, p0, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$CommandToUip$Builder;->bitField0_:I

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

.method public hasUipAttributeData()Z
    .locals 2

    .prologue
    .line 8173
    iget v0, p0, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$CommandToUip$Builder;->bitField0_:I

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

.method protected internalGetFieldAccessorTable()Lcom/google/protobuf/GeneratedMessage$FieldAccessorTable;
    .locals 3

    .prologue
    .line 7926
    invoke-static {}, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage;->m()Lcom/google/protobuf/GeneratedMessage$FieldAccessorTable;

    move-result-object v0

    const-class v1, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$CommandToUip;

    const-class v2, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$CommandToUip$Builder;

    .line 7927
    invoke-virtual {v0, v1, v2}, Lcom/google/protobuf/GeneratedMessage$FieldAccessorTable;->ensureFieldAccessorsInitialized(Ljava/lang/Class;Ljava/lang/Class;)Lcom/google/protobuf/GeneratedMessage$FieldAccessorTable;

    move-result-object v0

    .line 7926
    return-object v0
.end method

.method public final isInitialized()Z
    .locals 1

    .prologue
    .line 8031
    invoke-virtual {p0}, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$CommandToUip$Builder;->hasCommand()Z

    move-result v0

    if-nez v0, :cond_0

    .line 8033
    const/4 v0, 0x0

    .line 8035
    :goto_0
    return v0

    :cond_0
    const/4 v0, 0x1

    goto :goto_0
.end method

.method public mergeFrom(Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$CommandToUip;)Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$CommandToUip$Builder;
    .locals 1

    .prologue
    .line 8012
    invoke-static {}, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$CommandToUip;->getDefaultInstance()Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$CommandToUip;

    move-result-object v0

    if-ne p1, v0, :cond_0

    .line 8027
    :goto_0
    return-object p0

    .line 8013
    :cond_0
    invoke-virtual {p1}, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$CommandToUip;->hasCommand()Z

    move-result v0

    if-eqz v0, :cond_1

    .line 8014
    invoke-virtual {p1}, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$CommandToUip;->getCommand()Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$CommandToUip$Command_Type;

    move-result-object v0

    invoke-virtual {p0, v0}, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$CommandToUip$Builder;->setCommand(Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$CommandToUip$Command_Type;)Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$CommandToUip$Builder;

    .line 8016
    :cond_1
    invoke-virtual {p1}, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$CommandToUip;->hasControlId()Z

    move-result v0

    if-eqz v0, :cond_2

    .line 8017
    iget v0, p0, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$CommandToUip$Builder;->bitField0_:I

    or-int/lit8 v0, v0, 0x2

    iput v0, p0, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$CommandToUip$Builder;->bitField0_:I

    .line 8018
    invoke-static {p1}, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$CommandToUip;->access$8800(Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$CommandToUip;)Ljava/lang/Object;

    move-result-object v0

    iput-object v0, p0, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$CommandToUip$Builder;->controlId_:Ljava/lang/Object;

    .line 8019
    invoke-virtual {p0}, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$CommandToUip$Builder;->onChanged()V

    .line 8021
    :cond_2
    invoke-virtual {p1}, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$CommandToUip;->hasUipAttributeData()Z

    move-result v0

    if-eqz v0, :cond_3

    .line 8022
    iget v0, p0, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$CommandToUip$Builder;->bitField0_:I

    or-int/lit8 v0, v0, 0x4

    iput v0, p0, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$CommandToUip$Builder;->bitField0_:I

    .line 8023
    invoke-static {p1}, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$CommandToUip;->access$8900(Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$CommandToUip;)Ljava/lang/Object;

    move-result-object v0

    iput-object v0, p0, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$CommandToUip$Builder;->uipAttributeData_:Ljava/lang/Object;

    .line 8024
    invoke-virtual {p0}, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$CommandToUip$Builder;->onChanged()V

    .line 8026
    :cond_3
    invoke-virtual {p1}, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$CommandToUip;->getUnknownFields()Lcom/google/protobuf/UnknownFieldSet;

    move-result-object v0

    invoke-virtual {p0, v0}, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$CommandToUip$Builder;->mergeUnknownFields(Lcom/google/protobuf/UnknownFieldSet;)Lcom/google/protobuf/GeneratedMessage$Builder;

    goto :goto_0
.end method

.method public mergeFrom(Lcom/google/protobuf/CodedInputStream;Lcom/google/protobuf/ExtensionRegistryLite;)Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$CommandToUip$Builder;
    .locals 4
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljava/io/IOException;
        }
    .end annotation

    .prologue
    .line 8042
    const/4 v2, 0x0

    .line 8044
    :try_start_0
    sget-object v0, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$CommandToUip;->PARSER:Lcom/google/protobuf/Parser;

    invoke-interface {v0, p1, p2}, Lcom/google/protobuf/Parser;->parsePartialFrom(Lcom/google/protobuf/CodedInputStream;Lcom/google/protobuf/ExtensionRegistryLite;)Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$CommandToUip;
    :try_end_0
    .catch Lcom/google/protobuf/InvalidProtocolBufferException; {:try_start_0 .. :try_end_0} :catch_0
    .catchall {:try_start_0 .. :try_end_0} :catchall_1

    .line 8049
    if-eqz v0, :cond_0

    .line 8050
    invoke-virtual {p0, v0}, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$CommandToUip$Builder;->mergeFrom(Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$CommandToUip;)Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$CommandToUip$Builder;

    .line 8053
    :cond_0
    return-object p0

    .line 8045
    :catch_0
    move-exception v0

    move-object v1, v0

    .line 8046
    :try_start_1
    invoke-virtual {v1}, Lcom/google/protobuf/InvalidProtocolBufferException;->getUnfinishedMessage()Lcom/google/protobuf/MessageLite;

    move-result-object v0

    check-cast v0, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$CommandToUip;
    :try_end_1
    .catchall {:try_start_1 .. :try_end_1} :catchall_1

    .line 8047
    :try_start_2
    throw v1
    :try_end_2
    .catchall {:try_start_2 .. :try_end_2} :catchall_0

    .line 8049
    :catchall_0
    move-exception v1

    move-object v3, v1

    move-object v1, v0

    move-object v0, v3

    :goto_0
    if-eqz v1, :cond_1

    .line 8050
    invoke-virtual {p0, v1}, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$CommandToUip$Builder;->mergeFrom(Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$CommandToUip;)Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$CommandToUip$Builder;

    :cond_1
    throw v0

    .line 8049
    :catchall_1
    move-exception v0

    move-object v1, v2

    goto :goto_0
.end method

.method public mergeFrom(Lcom/google/protobuf/Message;)Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$CommandToUip$Builder;
    .locals 1

    .prologue
    .line 8003
    instance-of v0, p1, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$CommandToUip;

    if-eqz v0, :cond_0

    .line 8004
    check-cast p1, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$CommandToUip;

    invoke-virtual {p0, p1}, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$CommandToUip$Builder;->mergeFrom(Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$CommandToUip;)Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$CommandToUip$Builder;

    move-result-object p0

    .line 8007
    :goto_0
    return-object p0

    .line 8006
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
    .line 7916
    invoke-virtual {p0, p1, p2}, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$CommandToUip$Builder;->mergeFrom(Lcom/google/protobuf/CodedInputStream;Lcom/google/protobuf/ExtensionRegistryLite;)Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$CommandToUip$Builder;

    move-result-object v0

    return-object v0
.end method

.method public bridge synthetic mergeFrom(Lcom/google/protobuf/Message;)Lcom/google/protobuf/AbstractMessage$Builder;
    .locals 1

    .prologue
    .line 7916
    invoke-virtual {p0, p1}, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$CommandToUip$Builder;->mergeFrom(Lcom/google/protobuf/Message;)Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$CommandToUip$Builder;

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
    .line 7916
    invoke-virtual {p0, p1, p2}, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$CommandToUip$Builder;->mergeFrom(Lcom/google/protobuf/CodedInputStream;Lcom/google/protobuf/ExtensionRegistryLite;)Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$CommandToUip$Builder;

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
    .line 7916
    invoke-virtual {p0, p1, p2}, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$CommandToUip$Builder;->mergeFrom(Lcom/google/protobuf/CodedInputStream;Lcom/google/protobuf/ExtensionRegistryLite;)Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$CommandToUip$Builder;

    move-result-object v0

    return-object v0
.end method

.method public bridge synthetic mergeFrom(Lcom/google/protobuf/Message;)Lcom/google/protobuf/Message$Builder;
    .locals 1

    .prologue
    .line 7916
    invoke-virtual {p0, p1}, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$CommandToUip$Builder;->mergeFrom(Lcom/google/protobuf/Message;)Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$CommandToUip$Builder;

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
    .line 7916
    invoke-virtual {p0, p1, p2}, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$CommandToUip$Builder;->mergeFrom(Lcom/google/protobuf/CodedInputStream;Lcom/google/protobuf/ExtensionRegistryLite;)Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$CommandToUip$Builder;

    move-result-object v0

    return-object v0
.end method

.method public setCommand(Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$CommandToUip$Command_Type;)Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$CommandToUip$Builder;
    .locals 1

    .prologue
    .line 8075
    if-nez p1, :cond_0

    .line 8076
    new-instance v0, Ljava/lang/NullPointerException;

    invoke-direct {v0}, Ljava/lang/NullPointerException;-><init>()V

    throw v0

    .line 8078
    :cond_0
    iget v0, p0, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$CommandToUip$Builder;->bitField0_:I

    or-int/lit8 v0, v0, 0x1

    iput v0, p0, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$CommandToUip$Builder;->bitField0_:I

    .line 8079
    iput-object p1, p0, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$CommandToUip$Builder;->command_:Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$CommandToUip$Command_Type;

    .line 8080
    invoke-virtual {p0}, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$CommandToUip$Builder;->onChanged()V

    .line 8081
    return-object p0
.end method

.method public setControlId(Ljava/lang/String;)Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$CommandToUip$Builder;
    .locals 1

    .prologue
    .line 8136
    if-nez p1, :cond_0

    .line 8137
    new-instance v0, Ljava/lang/NullPointerException;

    invoke-direct {v0}, Ljava/lang/NullPointerException;-><init>()V

    throw v0

    .line 8139
    :cond_0
    iget v0, p0, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$CommandToUip$Builder;->bitField0_:I

    or-int/lit8 v0, v0, 0x2

    iput v0, p0, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$CommandToUip$Builder;->bitField0_:I

    .line 8140
    iput-object p1, p0, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$CommandToUip$Builder;->controlId_:Ljava/lang/Object;

    .line 8141
    invoke-virtual {p0}, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$CommandToUip$Builder;->onChanged()V

    .line 8142
    return-object p0
.end method

.method public setControlIdBytes(Lcom/google/protobuf/ByteString;)Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$CommandToUip$Builder;
    .locals 1

    .prologue
    .line 8158
    if-nez p1, :cond_0

    .line 8159
    new-instance v0, Ljava/lang/NullPointerException;

    invoke-direct {v0}, Ljava/lang/NullPointerException;-><init>()V

    throw v0

    .line 8161
    :cond_0
    iget v0, p0, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$CommandToUip$Builder;->bitField0_:I

    or-int/lit8 v0, v0, 0x2

    iput v0, p0, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$CommandToUip$Builder;->bitField0_:I

    .line 8162
    iput-object p1, p0, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$CommandToUip$Builder;->controlId_:Ljava/lang/Object;

    .line 8163
    invoke-virtual {p0}, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$CommandToUip$Builder;->onChanged()V

    .line 8164
    return-object p0
.end method

.method public setUipAttributeData(Ljava/lang/String;)Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$CommandToUip$Builder;
    .locals 1

    .prologue
    .line 8210
    if-nez p1, :cond_0

    .line 8211
    new-instance v0, Ljava/lang/NullPointerException;

    invoke-direct {v0}, Ljava/lang/NullPointerException;-><init>()V

    throw v0

    .line 8213
    :cond_0
    iget v0, p0, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$CommandToUip$Builder;->bitField0_:I

    or-int/lit8 v0, v0, 0x4

    iput v0, p0, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$CommandToUip$Builder;->bitField0_:I

    .line 8214
    iput-object p1, p0, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$CommandToUip$Builder;->uipAttributeData_:Ljava/lang/Object;

    .line 8215
    invoke-virtual {p0}, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$CommandToUip$Builder;->onChanged()V

    .line 8216
    return-object p0
.end method

.method public setUipAttributeDataBytes(Lcom/google/protobuf/ByteString;)Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$CommandToUip$Builder;
    .locals 1

    .prologue
    .line 8232
    if-nez p1, :cond_0

    .line 8233
    new-instance v0, Ljava/lang/NullPointerException;

    invoke-direct {v0}, Ljava/lang/NullPointerException;-><init>()V

    throw v0

    .line 8235
    :cond_0
    iget v0, p0, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$CommandToUip$Builder;->bitField0_:I

    or-int/lit8 v0, v0, 0x4

    iput v0, p0, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$CommandToUip$Builder;->bitField0_:I

    .line 8236
    iput-object p1, p0, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$CommandToUip$Builder;->uipAttributeData_:Ljava/lang/Object;

    .line 8237
    invoke-virtual {p0}, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$CommandToUip$Builder;->onChanged()V

    .line 8238
    return-object p0
.end method
