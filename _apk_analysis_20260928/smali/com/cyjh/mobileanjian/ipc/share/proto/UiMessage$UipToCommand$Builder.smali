.class public final Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$UipToCommand$Builder;
.super Lcom/google/protobuf/GeneratedMessage$Builder;
.source "SourceFile"

# interfaces
.implements Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$UipToCommandOrBuilder;


# annotations
.annotation system Ldalvik/annotation/EnclosingClass;
    value = Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$UipToCommand;
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x19
    name = "Builder"
.end annotation

.annotation system Ldalvik/annotation/Signature;
    value = {
        "Lcom/google/protobuf/GeneratedMessage$Builder",
        "<",
        "Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$UipToCommand$Builder;",
        ">;",
        "Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$UipToCommandOrBuilder;"
    }
.end annotation


# instance fields
.field private bitField0_:I

.field private command_:Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$UipToCommand$Command_Type;

.field private eventBuilder_:Lcom/google/protobuf/SingleFieldBuilder;
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "Lcom/google/protobuf/SingleFieldBuilder",
            "<",
            "Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$ControlEvent;",
            "Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$ControlEvent$Builder;",
            "Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$ControlEventOrBuilder;",
            ">;"
        }
    .end annotation
.end field

.field private event_:Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$ControlEvent;

.field private isSuccess_:Z

.field private uipAttributeData_:Ljava/lang/Object;


# direct methods
.method private constructor <init>()V
    .locals 1

    .prologue
    .line 8770
    invoke-direct {p0}, Lcom/google/protobuf/GeneratedMessage$Builder;-><init>()V

    .line 8918
    sget-object v0, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$UipToCommand$Command_Type;->EVENT:Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$UipToCommand$Command_Type;

    iput-object v0, p0, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$UipToCommand$Builder;->command_:Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$UipToCommand$Command_Type;

    .line 8954
    invoke-static {}, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$ControlEvent;->getDefaultInstance()Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$ControlEvent;

    move-result-object v0

    iput-object v0, p0, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$UipToCommand$Builder;->event_:Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$ControlEvent;

    .line 9104
    const-string v0, ""

    iput-object v0, p0, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$UipToCommand$Builder;->uipAttributeData_:Ljava/lang/Object;

    .line 8771
    invoke-direct {p0}, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$UipToCommand$Builder;->maybeForceBuilderInitialization()V

    .line 8772
    return-void
.end method

.method private constructor <init>(Lcom/google/protobuf/GeneratedMessage$BuilderParent;)V
    .locals 1

    .prologue
    .line 8776
    invoke-direct {p0, p1}, Lcom/google/protobuf/GeneratedMessage$Builder;-><init>(Lcom/google/protobuf/GeneratedMessage$BuilderParent;)V

    .line 8918
    sget-object v0, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$UipToCommand$Command_Type;->EVENT:Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$UipToCommand$Command_Type;

    iput-object v0, p0, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$UipToCommand$Builder;->command_:Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$UipToCommand$Command_Type;

    .line 8954
    invoke-static {}, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$ControlEvent;->getDefaultInstance()Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$ControlEvent;

    move-result-object v0

    iput-object v0, p0, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$UipToCommand$Builder;->event_:Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$ControlEvent;

    .line 9104
    const-string v0, ""

    iput-object v0, p0, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$UipToCommand$Builder;->uipAttributeData_:Ljava/lang/Object;

    .line 8777
    invoke-direct {p0}, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$UipToCommand$Builder;->maybeForceBuilderInitialization()V

    .line 8778
    return-void
.end method

.method synthetic constructor <init>(Lcom/google/protobuf/GeneratedMessage$BuilderParent;Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$1;)V
    .locals 0

    .prologue
    .line 8754
    invoke-direct {p0, p1}, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$UipToCommand$Builder;-><init>(Lcom/google/protobuf/GeneratedMessage$BuilderParent;)V

    return-void
.end method

.method static synthetic access$9400()Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$UipToCommand$Builder;
    .locals 1

    .prologue
    .line 8754
    invoke-static {}, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$UipToCommand$Builder;->create()Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$UipToCommand$Builder;

    move-result-object v0

    return-object v0
.end method

.method private static create()Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$UipToCommand$Builder;
    .locals 1

    .prologue
    .line 8785
    new-instance v0, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$UipToCommand$Builder;

    invoke-direct {v0}, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$UipToCommand$Builder;-><init>()V

    return-object v0
.end method

.method public static final getDescriptor()Lcom/google/protobuf/Descriptors$Descriptor;
    .locals 1

    .prologue
    .line 8759
    invoke-static {}, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage;->n()Lcom/google/protobuf/Descriptors$Descriptor;

    move-result-object v0

    return-object v0
.end method

.method private getEventFieldBuilder()Lcom/google/protobuf/SingleFieldBuilder;
    .locals 4
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "()",
            "Lcom/google/protobuf/SingleFieldBuilder",
            "<",
            "Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$ControlEvent;",
            "Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$ControlEvent$Builder;",
            "Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$ControlEventOrBuilder;",
            ">;"
        }
    .end annotation

    .prologue
    .line 9059
    iget-object v0, p0, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$UipToCommand$Builder;->eventBuilder_:Lcom/google/protobuf/SingleFieldBuilder;

    if-nez v0, :cond_0

    .line 9060
    new-instance v0, Lcom/google/protobuf/SingleFieldBuilder;

    iget-object v1, p0, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$UipToCommand$Builder;->event_:Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$ControlEvent;

    .line 9063
    invoke-virtual {p0}, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$UipToCommand$Builder;->getParentForChildren()Lcom/google/protobuf/GeneratedMessage$BuilderParent;

    move-result-object v2

    .line 9064
    invoke-virtual {p0}, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$UipToCommand$Builder;->isClean()Z

    move-result v3

    invoke-direct {v0, v1, v2, v3}, Lcom/google/protobuf/SingleFieldBuilder;-><init>(Lcom/google/protobuf/GeneratedMessage;Lcom/google/protobuf/GeneratedMessage$BuilderParent;Z)V

    iput-object v0, p0, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$UipToCommand$Builder;->eventBuilder_:Lcom/google/protobuf/SingleFieldBuilder;

    .line 9065
    const/4 v0, 0x0

    iput-object v0, p0, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$UipToCommand$Builder;->event_:Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$ControlEvent;

    .line 9067
    :cond_0
    iget-object v0, p0, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$UipToCommand$Builder;->eventBuilder_:Lcom/google/protobuf/SingleFieldBuilder;

    return-object v0
.end method

.method private maybeForceBuilderInitialization()V
    .locals 1

    .prologue
    .line 8780
    invoke-static {}, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$UipToCommand;->access$9600()Z

    move-result v0

    if-eqz v0, :cond_0

    .line 8781
    invoke-direct {p0}, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$UipToCommand$Builder;->getEventFieldBuilder()Lcom/google/protobuf/SingleFieldBuilder;

    .line 8783
    :cond_0
    return-void
.end method


# virtual methods
.method public build()Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$UipToCommand;
    .locals 2

    .prologue
    .line 8819
    invoke-virtual {p0}, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$UipToCommand$Builder;->buildPartial()Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$UipToCommand;

    move-result-object v0

    .line 8820
    invoke-virtual {v0}, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$UipToCommand;->isInitialized()Z

    move-result v1

    if-nez v1, :cond_0

    .line 8821
    invoke-static {v0}, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$UipToCommand$Builder;->newUninitializedMessageException(Lcom/google/protobuf/Message;)Lcom/google/protobuf/UninitializedMessageException;

    move-result-object v0

    throw v0

    .line 8823
    :cond_0
    return-object v0
.end method

.method public bridge synthetic build()Lcom/google/protobuf/Message;
    .locals 1

    .prologue
    .line 8754
    invoke-virtual {p0}, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$UipToCommand$Builder;->build()Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$UipToCommand;

    move-result-object v0

    return-object v0
.end method

.method public bridge synthetic build()Lcom/google/protobuf/MessageLite;
    .locals 1

    .prologue
    .line 8754
    invoke-virtual {p0}, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$UipToCommand$Builder;->build()Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$UipToCommand;

    move-result-object v0

    return-object v0
.end method

.method public buildPartial()Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$UipToCommand;
    .locals 5

    .prologue
    const/4 v0, 0x1

    .line 8827
    new-instance v2, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$UipToCommand;

    const/4 v1, 0x0

    invoke-direct {v2, p0, v1}, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$UipToCommand;-><init>(Lcom/google/protobuf/GeneratedMessage$Builder;Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$1;)V

    .line 8828
    iget v3, p0, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$UipToCommand$Builder;->bitField0_:I

    .line 8829
    const/4 v1, 0x0

    .line 8830
    and-int/lit8 v4, v3, 0x1

    if-ne v4, v0, :cond_4

    .line 8833
    :goto_0
    iget-object v1, p0, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$UipToCommand$Builder;->command_:Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$UipToCommand$Command_Type;

    invoke-static {v2, v1}, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$UipToCommand;->access$9802(Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$UipToCommand;Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$UipToCommand$Command_Type;)Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$UipToCommand$Command_Type;

    .line 8834
    and-int/lit8 v1, v3, 0x2

    const/4 v4, 0x2

    if-ne v1, v4, :cond_3

    .line 8835
    or-int/lit8 v0, v0, 0x2

    move v1, v0

    .line 8837
    :goto_1
    iget-object v0, p0, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$UipToCommand$Builder;->eventBuilder_:Lcom/google/protobuf/SingleFieldBuilder;

    if-nez v0, :cond_2

    .line 8838
    iget-object v0, p0, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$UipToCommand$Builder;->event_:Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$ControlEvent;

    invoke-static {v2, v0}, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$UipToCommand;->access$9902(Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$UipToCommand;Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$ControlEvent;)Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$ControlEvent;

    .line 8842
    :goto_2
    and-int/lit8 v0, v3, 0x4

    const/4 v4, 0x4

    if-ne v0, v4, :cond_0

    .line 8843
    or-int/lit8 v1, v1, 0x4

    .line 8845
    :cond_0
    iget-boolean v0, p0, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$UipToCommand$Builder;->isSuccess_:Z

    invoke-static {v2, v0}, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$UipToCommand;->access$10002(Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$UipToCommand;Z)Z

    .line 8846
    and-int/lit8 v0, v3, 0x8

    const/16 v3, 0x8

    if-ne v0, v3, :cond_1

    .line 8847
    or-int/lit8 v1, v1, 0x8

    .line 8849
    :cond_1
    iget-object v0, p0, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$UipToCommand$Builder;->uipAttributeData_:Ljava/lang/Object;

    invoke-static {v2, v0}, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$UipToCommand;->access$10102(Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$UipToCommand;Ljava/lang/Object;)Ljava/lang/Object;

    .line 8850
    invoke-static {v2, v1}, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$UipToCommand;->access$10202(Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$UipToCommand;I)I

    .line 8851
    invoke-virtual {p0}, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$UipToCommand$Builder;->onBuilt()V

    .line 8852
    return-object v2

    .line 8840
    :cond_2
    iget-object v0, p0, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$UipToCommand$Builder;->eventBuilder_:Lcom/google/protobuf/SingleFieldBuilder;

    invoke-virtual {v0}, Lcom/google/protobuf/SingleFieldBuilder;->build()Lcom/google/protobuf/GeneratedMessage;

    move-result-object v0

    check-cast v0, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$ControlEvent;

    invoke-static {v2, v0}, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$UipToCommand;->access$9902(Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$UipToCommand;Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$ControlEvent;)Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$ControlEvent;

    goto :goto_2

    :cond_3
    move v1, v0

    goto :goto_1

    :cond_4
    move v0, v1

    goto :goto_0
.end method

.method public bridge synthetic buildPartial()Lcom/google/protobuf/Message;
    .locals 1

    .prologue
    .line 8754
    invoke-virtual {p0}, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$UipToCommand$Builder;->buildPartial()Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$UipToCommand;

    move-result-object v0

    return-object v0
.end method

.method public bridge synthetic buildPartial()Lcom/google/protobuf/MessageLite;
    .locals 1

    .prologue
    .line 8754
    invoke-virtual {p0}, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$UipToCommand$Builder;->buildPartial()Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$UipToCommand;

    move-result-object v0

    return-object v0
.end method

.method public clear()Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$UipToCommand$Builder;
    .locals 1

    .prologue
    .line 8789
    invoke-super {p0}, Lcom/google/protobuf/GeneratedMessage$Builder;->clear()Lcom/google/protobuf/GeneratedMessage$Builder;

    .line 8790
    sget-object v0, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$UipToCommand$Command_Type;->EVENT:Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$UipToCommand$Command_Type;

    iput-object v0, p0, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$UipToCommand$Builder;->command_:Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$UipToCommand$Command_Type;

    .line 8791
    iget v0, p0, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$UipToCommand$Builder;->bitField0_:I

    and-int/lit8 v0, v0, -0x2

    iput v0, p0, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$UipToCommand$Builder;->bitField0_:I

    .line 8792
    iget-object v0, p0, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$UipToCommand$Builder;->eventBuilder_:Lcom/google/protobuf/SingleFieldBuilder;

    if-nez v0, :cond_0

    .line 8793
    invoke-static {}, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$ControlEvent;->getDefaultInstance()Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$ControlEvent;

    move-result-object v0

    iput-object v0, p0, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$UipToCommand$Builder;->event_:Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$ControlEvent;

    .line 8797
    :goto_0
    iget v0, p0, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$UipToCommand$Builder;->bitField0_:I

    and-int/lit8 v0, v0, -0x3

    iput v0, p0, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$UipToCommand$Builder;->bitField0_:I

    .line 8798
    const/4 v0, 0x0

    iput-boolean v0, p0, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$UipToCommand$Builder;->isSuccess_:Z

    .line 8799
    iget v0, p0, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$UipToCommand$Builder;->bitField0_:I

    and-int/lit8 v0, v0, -0x5

    iput v0, p0, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$UipToCommand$Builder;->bitField0_:I

    .line 8800
    const-string v0, ""

    iput-object v0, p0, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$UipToCommand$Builder;->uipAttributeData_:Ljava/lang/Object;

    .line 8801
    iget v0, p0, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$UipToCommand$Builder;->bitField0_:I

    and-int/lit8 v0, v0, -0x9

    iput v0, p0, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$UipToCommand$Builder;->bitField0_:I

    .line 8802
    return-object p0

    .line 8795
    :cond_0
    iget-object v0, p0, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$UipToCommand$Builder;->eventBuilder_:Lcom/google/protobuf/SingleFieldBuilder;

    invoke-virtual {v0}, Lcom/google/protobuf/SingleFieldBuilder;->clear()Lcom/google/protobuf/SingleFieldBuilder;

    goto :goto_0
.end method

.method public bridge synthetic clear()Lcom/google/protobuf/AbstractMessage$Builder;
    .locals 1

    .prologue
    .line 8754
    invoke-virtual {p0}, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$UipToCommand$Builder;->clear()Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$UipToCommand$Builder;

    move-result-object v0

    return-object v0
.end method

.method public bridge synthetic clear()Lcom/google/protobuf/GeneratedMessage$Builder;
    .locals 1

    .prologue
    .line 8754
    invoke-virtual {p0}, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$UipToCommand$Builder;->clear()Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$UipToCommand$Builder;

    move-result-object v0

    return-object v0
.end method

.method public bridge synthetic clear()Lcom/google/protobuf/Message$Builder;
    .locals 1

    .prologue
    .line 8754
    invoke-virtual {p0}, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$UipToCommand$Builder;->clear()Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$UipToCommand$Builder;

    move-result-object v0

    return-object v0
.end method

.method public bridge synthetic clear()Lcom/google/protobuf/MessageLite$Builder;
    .locals 1

    .prologue
    .line 8754
    invoke-virtual {p0}, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$UipToCommand$Builder;->clear()Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$UipToCommand$Builder;

    move-result-object v0

    return-object v0
.end method

.method public clearCommand()Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$UipToCommand$Builder;
    .locals 1

    .prologue
    .line 8947
    iget v0, p0, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$UipToCommand$Builder;->bitField0_:I

    and-int/lit8 v0, v0, -0x2

    iput v0, p0, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$UipToCommand$Builder;->bitField0_:I

    .line 8948
    sget-object v0, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$UipToCommand$Command_Type;->EVENT:Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$UipToCommand$Command_Type;

    iput-object v0, p0, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$UipToCommand$Builder;->command_:Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$UipToCommand$Command_Type;

    .line 8949
    invoke-virtual {p0}, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$UipToCommand$Builder;->onChanged()V

    .line 8950
    return-object p0
.end method

.method public clearEvent()Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$UipToCommand$Builder;
    .locals 1

    .prologue
    .line 9026
    iget-object v0, p0, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$UipToCommand$Builder;->eventBuilder_:Lcom/google/protobuf/SingleFieldBuilder;

    if-nez v0, :cond_0

    .line 9027
    invoke-static {}, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$ControlEvent;->getDefaultInstance()Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$ControlEvent;

    move-result-object v0

    iput-object v0, p0, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$UipToCommand$Builder;->event_:Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$ControlEvent;

    .line 9028
    invoke-virtual {p0}, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$UipToCommand$Builder;->onChanged()V

    .line 9032
    :goto_0
    iget v0, p0, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$UipToCommand$Builder;->bitField0_:I

    and-int/lit8 v0, v0, -0x3

    iput v0, p0, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$UipToCommand$Builder;->bitField0_:I

    .line 9033
    return-object p0

    .line 9030
    :cond_0
    iget-object v0, p0, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$UipToCommand$Builder;->eventBuilder_:Lcom/google/protobuf/SingleFieldBuilder;

    invoke-virtual {v0}, Lcom/google/protobuf/SingleFieldBuilder;->clear()Lcom/google/protobuf/SingleFieldBuilder;

    goto :goto_0
.end method

.method public clearIsSuccess()Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$UipToCommand$Builder;
    .locals 1

    .prologue
    .line 9097
    iget v0, p0, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$UipToCommand$Builder;->bitField0_:I

    and-int/lit8 v0, v0, -0x5

    iput v0, p0, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$UipToCommand$Builder;->bitField0_:I

    .line 9098
    const/4 v0, 0x0

    iput-boolean v0, p0, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$UipToCommand$Builder;->isSuccess_:Z

    .line 9099
    invoke-virtual {p0}, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$UipToCommand$Builder;->onChanged()V

    .line 9100
    return-object p0
.end method

.method public clearUipAttributeData()Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$UipToCommand$Builder;
    .locals 1

    .prologue
    .line 9158
    iget v0, p0, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$UipToCommand$Builder;->bitField0_:I

    and-int/lit8 v0, v0, -0x9

    iput v0, p0, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$UipToCommand$Builder;->bitField0_:I

    .line 9159
    invoke-static {}, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$UipToCommand;->getDefaultInstance()Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$UipToCommand;

    move-result-object v0

    invoke-virtual {v0}, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$UipToCommand;->getUipAttributeData()Ljava/lang/String;

    move-result-object v0

    iput-object v0, p0, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$UipToCommand$Builder;->uipAttributeData_:Ljava/lang/Object;

    .line 9160
    invoke-virtual {p0}, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$UipToCommand$Builder;->onChanged()V

    .line 9161
    return-object p0
.end method

.method public clone()Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$UipToCommand$Builder;
    .locals 2

    .prologue
    .line 8806
    invoke-static {}, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$UipToCommand$Builder;->create()Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$UipToCommand$Builder;

    move-result-object v0

    invoke-virtual {p0}, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$UipToCommand$Builder;->buildPartial()Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$UipToCommand;

    move-result-object v1

    invoke-virtual {v0, v1}, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$UipToCommand$Builder;->mergeFrom(Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$UipToCommand;)Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$UipToCommand$Builder;

    move-result-object v0

    return-object v0
.end method

.method public bridge synthetic clone()Lcom/google/protobuf/AbstractMessage$Builder;
    .locals 1

    .prologue
    .line 8754
    invoke-virtual {p0}, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$UipToCommand$Builder;->clone()Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$UipToCommand$Builder;

    move-result-object v0

    return-object v0
.end method

.method public bridge synthetic clone()Lcom/google/protobuf/AbstractMessageLite$Builder;
    .locals 1

    .prologue
    .line 8754
    invoke-virtual {p0}, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$UipToCommand$Builder;->clone()Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$UipToCommand$Builder;

    move-result-object v0

    return-object v0
.end method

.method public bridge synthetic clone()Lcom/google/protobuf/GeneratedMessage$Builder;
    .locals 1

    .prologue
    .line 8754
    invoke-virtual {p0}, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$UipToCommand$Builder;->clone()Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$UipToCommand$Builder;

    move-result-object v0

    return-object v0
.end method

.method public bridge synthetic clone()Lcom/google/protobuf/Message$Builder;
    .locals 1

    .prologue
    .line 8754
    invoke-virtual {p0}, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$UipToCommand$Builder;->clone()Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$UipToCommand$Builder;

    move-result-object v0

    return-object v0
.end method

.method public bridge synthetic clone()Lcom/google/protobuf/MessageLite$Builder;
    .locals 1

    .prologue
    .line 8754
    invoke-virtual {p0}, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$UipToCommand$Builder;->clone()Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$UipToCommand$Builder;

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
    .line 8754
    invoke-virtual {p0}, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$UipToCommand$Builder;->clone()Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$UipToCommand$Builder;

    move-result-object v0

    return-object v0
.end method

.method public getCommand()Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$UipToCommand$Command_Type;
    .locals 1

    .prologue
    .line 8929
    iget-object v0, p0, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$UipToCommand$Builder;->command_:Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$UipToCommand$Command_Type;

    return-object v0
.end method

.method public getDefaultInstanceForType()Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$UipToCommand;
    .locals 1

    .prologue
    .line 8815
    invoke-static {}, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$UipToCommand;->getDefaultInstance()Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$UipToCommand;

    move-result-object v0

    return-object v0
.end method

.method public bridge synthetic getDefaultInstanceForType()Lcom/google/protobuf/Message;
    .locals 1

    .prologue
    .line 8754
    invoke-virtual {p0}, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$UipToCommand$Builder;->getDefaultInstanceForType()Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$UipToCommand;

    move-result-object v0

    return-object v0
.end method

.method public bridge synthetic getDefaultInstanceForType()Lcom/google/protobuf/MessageLite;
    .locals 1

    .prologue
    .line 8754
    invoke-virtual {p0}, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$UipToCommand$Builder;->getDefaultInstanceForType()Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$UipToCommand;

    move-result-object v0

    return-object v0
.end method

.method public getDescriptorForType()Lcom/google/protobuf/Descriptors$Descriptor;
    .locals 1

    .prologue
    .line 8811
    invoke-static {}, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage;->n()Lcom/google/protobuf/Descriptors$Descriptor;

    move-result-object v0

    return-object v0
.end method

.method public getEvent()Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$ControlEvent;
    .locals 1

    .prologue
    .line 8967
    iget-object v0, p0, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$UipToCommand$Builder;->eventBuilder_:Lcom/google/protobuf/SingleFieldBuilder;

    if-nez v0, :cond_0

    .line 8968
    iget-object v0, p0, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$UipToCommand$Builder;->event_:Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$ControlEvent;

    .line 8970
    :goto_0
    return-object v0

    :cond_0
    iget-object v0, p0, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$UipToCommand$Builder;->eventBuilder_:Lcom/google/protobuf/SingleFieldBuilder;

    invoke-virtual {v0}, Lcom/google/protobuf/SingleFieldBuilder;->getMessage()Lcom/google/protobuf/GeneratedMessage;

    move-result-object v0

    check-cast v0, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$ControlEvent;

    goto :goto_0
.end method

.method public getEventBuilder()Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$ControlEvent$Builder;
    .locals 1

    .prologue
    .line 9039
    iget v0, p0, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$UipToCommand$Builder;->bitField0_:I

    or-int/lit8 v0, v0, 0x2

    iput v0, p0, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$UipToCommand$Builder;->bitField0_:I

    .line 9040
    invoke-virtual {p0}, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$UipToCommand$Builder;->onChanged()V

    .line 9041
    invoke-direct {p0}, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$UipToCommand$Builder;->getEventFieldBuilder()Lcom/google/protobuf/SingleFieldBuilder;

    move-result-object v0

    invoke-virtual {v0}, Lcom/google/protobuf/SingleFieldBuilder;->getBuilder()Lcom/google/protobuf/GeneratedMessage$Builder;

    move-result-object v0

    check-cast v0, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$ControlEvent$Builder;

    return-object v0
.end method

.method public getEventOrBuilder()Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$ControlEventOrBuilder;
    .locals 1

    .prologue
    .line 9047
    iget-object v0, p0, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$UipToCommand$Builder;->eventBuilder_:Lcom/google/protobuf/SingleFieldBuilder;

    if-eqz v0, :cond_0

    .line 9048
    iget-object v0, p0, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$UipToCommand$Builder;->eventBuilder_:Lcom/google/protobuf/SingleFieldBuilder;

    invoke-virtual {v0}, Lcom/google/protobuf/SingleFieldBuilder;->getMessageOrBuilder()Lcom/google/protobuf/MessageOrBuilder;

    move-result-object v0

    check-cast v0, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$ControlEventOrBuilder;

    .line 9050
    :goto_0
    return-object v0

    :cond_0
    iget-object v0, p0, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$UipToCommand$Builder;->event_:Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$ControlEvent;

    goto :goto_0
.end method

.method public getIsSuccess()Z
    .locals 1

    .prologue
    .line 9082
    iget-boolean v0, p0, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$UipToCommand$Builder;->isSuccess_:Z

    return v0
.end method

.method public getUipAttributeData()Ljava/lang/String;
    .locals 2

    .prologue
    .line 9115
    iget-object v0, p0, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$UipToCommand$Builder;->uipAttributeData_:Ljava/lang/Object;

    .line 9116
    instance-of v1, v0, Ljava/lang/String;

    if-nez v1, :cond_0

    .line 9117
    check-cast v0, Lcom/google/protobuf/ByteString;

    .line 9118
    invoke-virtual {v0}, Lcom/google/protobuf/ByteString;->toStringUtf8()Ljava/lang/String;

    move-result-object v0

    .line 9119
    iput-object v0, p0, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$UipToCommand$Builder;->uipAttributeData_:Ljava/lang/Object;

    .line 9122
    :goto_0
    return-object v0

    :cond_0
    check-cast v0, Ljava/lang/String;

    goto :goto_0
.end method

.method public getUipAttributeDataBytes()Lcom/google/protobuf/ByteString;
    .locals 2

    .prologue
    .line 9130
    iget-object v0, p0, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$UipToCommand$Builder;->uipAttributeData_:Ljava/lang/Object;

    .line 9131
    instance-of v1, v0, Ljava/lang/String;

    if-eqz v1, :cond_0

    .line 9132
    check-cast v0, Ljava/lang/String;

    .line 9133
    invoke-static {v0}, Lcom/google/protobuf/ByteString;->copyFromUtf8(Ljava/lang/String;)Lcom/google/protobuf/ByteString;

    move-result-object v0

    .line 9135
    iput-object v0, p0, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$UipToCommand$Builder;->uipAttributeData_:Ljava/lang/Object;

    .line 9138
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

    .line 8923
    iget v1, p0, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$UipToCommand$Builder;->bitField0_:I

    and-int/lit8 v1, v1, 0x1

    if-ne v1, v0, :cond_0

    :goto_0
    return v0

    :cond_0
    const/4 v0, 0x0

    goto :goto_0
.end method

.method public hasEvent()Z
    .locals 2

    .prologue
    .line 8961
    iget v0, p0, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$UipToCommand$Builder;->bitField0_:I

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

.method public hasIsSuccess()Z
    .locals 2

    .prologue
    .line 9076
    iget v0, p0, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$UipToCommand$Builder;->bitField0_:I

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

.method public hasUipAttributeData()Z
    .locals 2

    .prologue
    .line 9109
    iget v0, p0, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$UipToCommand$Builder;->bitField0_:I

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
    .locals 3

    .prologue
    .line 8764
    invoke-static {}, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage;->o()Lcom/google/protobuf/GeneratedMessage$FieldAccessorTable;

    move-result-object v0

    const-class v1, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$UipToCommand;

    const-class v2, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$UipToCommand$Builder;

    .line 8765
    invoke-virtual {v0, v1, v2}, Lcom/google/protobuf/GeneratedMessage$FieldAccessorTable;->ensureFieldAccessorsInitialized(Ljava/lang/Class;Ljava/lang/Class;)Lcom/google/protobuf/GeneratedMessage$FieldAccessorTable;

    move-result-object v0

    .line 8764
    return-object v0
.end method

.method public final isInitialized()Z
    .locals 2

    .prologue
    const/4 v0, 0x0

    .line 8885
    invoke-virtual {p0}, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$UipToCommand$Builder;->hasCommand()Z

    move-result v1

    if-nez v1, :cond_1

    .line 8895
    :cond_0
    :goto_0
    return v0

    .line 8889
    :cond_1
    invoke-virtual {p0}, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$UipToCommand$Builder;->hasEvent()Z

    move-result v1

    if-eqz v1, :cond_2

    .line 8890
    invoke-virtual {p0}, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$UipToCommand$Builder;->getEvent()Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$ControlEvent;

    move-result-object v1

    invoke-virtual {v1}, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$ControlEvent;->isInitialized()Z

    move-result v1

    if-eqz v1, :cond_0

    .line 8895
    :cond_2
    const/4 v0, 0x1

    goto :goto_0
.end method

.method public mergeEvent(Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$ControlEvent;)Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$UipToCommand$Builder;
    .locals 2

    .prologue
    .line 9007
    iget-object v0, p0, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$UipToCommand$Builder;->eventBuilder_:Lcom/google/protobuf/SingleFieldBuilder;

    if-nez v0, :cond_1

    .line 9008
    iget v0, p0, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$UipToCommand$Builder;->bitField0_:I

    and-int/lit8 v0, v0, 0x2

    const/4 v1, 0x2

    if-ne v0, v1, :cond_0

    iget-object v0, p0, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$UipToCommand$Builder;->event_:Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$ControlEvent;

    .line 9009
    invoke-static {}, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$ControlEvent;->getDefaultInstance()Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$ControlEvent;

    move-result-object v1

    if-eq v0, v1, :cond_0

    .line 9010
    iget-object v0, p0, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$UipToCommand$Builder;->event_:Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$ControlEvent;

    .line 9011
    invoke-static {v0}, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$ControlEvent;->newBuilder(Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$ControlEvent;)Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$ControlEvent$Builder;

    move-result-object v0

    invoke-virtual {v0, p1}, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$ControlEvent$Builder;->mergeFrom(Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$ControlEvent;)Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$ControlEvent$Builder;

    move-result-object v0

    invoke-virtual {v0}, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$ControlEvent$Builder;->buildPartial()Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$ControlEvent;

    move-result-object v0

    iput-object v0, p0, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$UipToCommand$Builder;->event_:Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$ControlEvent;

    .line 9015
    :goto_0
    invoke-virtual {p0}, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$UipToCommand$Builder;->onChanged()V

    .line 9019
    :goto_1
    iget v0, p0, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$UipToCommand$Builder;->bitField0_:I

    or-int/lit8 v0, v0, 0x2

    iput v0, p0, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$UipToCommand$Builder;->bitField0_:I

    .line 9020
    return-object p0

    .line 9013
    :cond_0
    iput-object p1, p0, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$UipToCommand$Builder;->event_:Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$ControlEvent;

    goto :goto_0

    .line 9017
    :cond_1
    iget-object v0, p0, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$UipToCommand$Builder;->eventBuilder_:Lcom/google/protobuf/SingleFieldBuilder;

    invoke-virtual {v0, p1}, Lcom/google/protobuf/SingleFieldBuilder;->mergeFrom(Lcom/google/protobuf/GeneratedMessage;)Lcom/google/protobuf/SingleFieldBuilder;

    goto :goto_1
.end method

.method public mergeFrom(Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$UipToCommand;)Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$UipToCommand$Builder;
    .locals 1

    .prologue
    .line 8865
    invoke-static {}, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$UipToCommand;->getDefaultInstance()Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$UipToCommand;

    move-result-object v0

    if-ne p1, v0, :cond_0

    .line 8881
    :goto_0
    return-object p0

    .line 8866
    :cond_0
    invoke-virtual {p1}, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$UipToCommand;->hasCommand()Z

    move-result v0

    if-eqz v0, :cond_1

    .line 8867
    invoke-virtual {p1}, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$UipToCommand;->getCommand()Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$UipToCommand$Command_Type;

    move-result-object v0

    invoke-virtual {p0, v0}, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$UipToCommand$Builder;->setCommand(Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$UipToCommand$Command_Type;)Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$UipToCommand$Builder;

    .line 8869
    :cond_1
    invoke-virtual {p1}, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$UipToCommand;->hasEvent()Z

    move-result v0

    if-eqz v0, :cond_2

    .line 8870
    invoke-virtual {p1}, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$UipToCommand;->getEvent()Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$ControlEvent;

    move-result-object v0

    invoke-virtual {p0, v0}, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$UipToCommand$Builder;->mergeEvent(Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$ControlEvent;)Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$UipToCommand$Builder;

    .line 8872
    :cond_2
    invoke-virtual {p1}, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$UipToCommand;->hasIsSuccess()Z

    move-result v0

    if-eqz v0, :cond_3

    .line 8873
    invoke-virtual {p1}, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$UipToCommand;->getIsSuccess()Z

    move-result v0

    invoke-virtual {p0, v0}, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$UipToCommand$Builder;->setIsSuccess(Z)Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$UipToCommand$Builder;

    .line 8875
    :cond_3
    invoke-virtual {p1}, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$UipToCommand;->hasUipAttributeData()Z

    move-result v0

    if-eqz v0, :cond_4

    .line 8876
    iget v0, p0, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$UipToCommand$Builder;->bitField0_:I

    or-int/lit8 v0, v0, 0x8

    iput v0, p0, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$UipToCommand$Builder;->bitField0_:I

    .line 8877
    invoke-static {p1}, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$UipToCommand;->access$10100(Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$UipToCommand;)Ljava/lang/Object;

    move-result-object v0

    iput-object v0, p0, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$UipToCommand$Builder;->uipAttributeData_:Ljava/lang/Object;

    .line 8878
    invoke-virtual {p0}, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$UipToCommand$Builder;->onChanged()V

    .line 8880
    :cond_4
    invoke-virtual {p1}, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$UipToCommand;->getUnknownFields()Lcom/google/protobuf/UnknownFieldSet;

    move-result-object v0

    invoke-virtual {p0, v0}, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$UipToCommand$Builder;->mergeUnknownFields(Lcom/google/protobuf/UnknownFieldSet;)Lcom/google/protobuf/GeneratedMessage$Builder;

    goto :goto_0
.end method

.method public mergeFrom(Lcom/google/protobuf/CodedInputStream;Lcom/google/protobuf/ExtensionRegistryLite;)Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$UipToCommand$Builder;
    .locals 4
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljava/io/IOException;
        }
    .end annotation

    .prologue
    .line 8902
    const/4 v2, 0x0

    .line 8904
    :try_start_0
    sget-object v0, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$UipToCommand;->PARSER:Lcom/google/protobuf/Parser;

    invoke-interface {v0, p1, p2}, Lcom/google/protobuf/Parser;->parsePartialFrom(Lcom/google/protobuf/CodedInputStream;Lcom/google/protobuf/ExtensionRegistryLite;)Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$UipToCommand;
    :try_end_0
    .catch Lcom/google/protobuf/InvalidProtocolBufferException; {:try_start_0 .. :try_end_0} :catch_0
    .catchall {:try_start_0 .. :try_end_0} :catchall_1

    .line 8909
    if-eqz v0, :cond_0

    .line 8910
    invoke-virtual {p0, v0}, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$UipToCommand$Builder;->mergeFrom(Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$UipToCommand;)Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$UipToCommand$Builder;

    .line 8913
    :cond_0
    return-object p0

    .line 8905
    :catch_0
    move-exception v0

    move-object v1, v0

    .line 8906
    :try_start_1
    invoke-virtual {v1}, Lcom/google/protobuf/InvalidProtocolBufferException;->getUnfinishedMessage()Lcom/google/protobuf/MessageLite;

    move-result-object v0

    check-cast v0, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$UipToCommand;
    :try_end_1
    .catchall {:try_start_1 .. :try_end_1} :catchall_1

    .line 8907
    :try_start_2
    throw v1
    :try_end_2
    .catchall {:try_start_2 .. :try_end_2} :catchall_0

    .line 8909
    :catchall_0
    move-exception v1

    move-object v3, v1

    move-object v1, v0

    move-object v0, v3

    :goto_0
    if-eqz v1, :cond_1

    .line 8910
    invoke-virtual {p0, v1}, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$UipToCommand$Builder;->mergeFrom(Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$UipToCommand;)Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$UipToCommand$Builder;

    :cond_1
    throw v0

    .line 8909
    :catchall_1
    move-exception v0

    move-object v1, v2

    goto :goto_0
.end method

.method public mergeFrom(Lcom/google/protobuf/Message;)Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$UipToCommand$Builder;
    .locals 1

    .prologue
    .line 8856
    instance-of v0, p1, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$UipToCommand;

    if-eqz v0, :cond_0

    .line 8857
    check-cast p1, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$UipToCommand;

    invoke-virtual {p0, p1}, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$UipToCommand$Builder;->mergeFrom(Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$UipToCommand;)Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$UipToCommand$Builder;

    move-result-object p0

    .line 8860
    :goto_0
    return-object p0

    .line 8859
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
    .line 8754
    invoke-virtual {p0, p1, p2}, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$UipToCommand$Builder;->mergeFrom(Lcom/google/protobuf/CodedInputStream;Lcom/google/protobuf/ExtensionRegistryLite;)Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$UipToCommand$Builder;

    move-result-object v0

    return-object v0
.end method

.method public bridge synthetic mergeFrom(Lcom/google/protobuf/Message;)Lcom/google/protobuf/AbstractMessage$Builder;
    .locals 1

    .prologue
    .line 8754
    invoke-virtual {p0, p1}, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$UipToCommand$Builder;->mergeFrom(Lcom/google/protobuf/Message;)Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$UipToCommand$Builder;

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
    .line 8754
    invoke-virtual {p0, p1, p2}, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$UipToCommand$Builder;->mergeFrom(Lcom/google/protobuf/CodedInputStream;Lcom/google/protobuf/ExtensionRegistryLite;)Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$UipToCommand$Builder;

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
    .line 8754
    invoke-virtual {p0, p1, p2}, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$UipToCommand$Builder;->mergeFrom(Lcom/google/protobuf/CodedInputStream;Lcom/google/protobuf/ExtensionRegistryLite;)Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$UipToCommand$Builder;

    move-result-object v0

    return-object v0
.end method

.method public bridge synthetic mergeFrom(Lcom/google/protobuf/Message;)Lcom/google/protobuf/Message$Builder;
    .locals 1

    .prologue
    .line 8754
    invoke-virtual {p0, p1}, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$UipToCommand$Builder;->mergeFrom(Lcom/google/protobuf/Message;)Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$UipToCommand$Builder;

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
    .line 8754
    invoke-virtual {p0, p1, p2}, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$UipToCommand$Builder;->mergeFrom(Lcom/google/protobuf/CodedInputStream;Lcom/google/protobuf/ExtensionRegistryLite;)Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$UipToCommand$Builder;

    move-result-object v0

    return-object v0
.end method

.method public setCommand(Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$UipToCommand$Command_Type;)Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$UipToCommand$Builder;
    .locals 1

    .prologue
    .line 8935
    if-nez p1, :cond_0

    .line 8936
    new-instance v0, Ljava/lang/NullPointerException;

    invoke-direct {v0}, Ljava/lang/NullPointerException;-><init>()V

    throw v0

    .line 8938
    :cond_0
    iget v0, p0, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$UipToCommand$Builder;->bitField0_:I

    or-int/lit8 v0, v0, 0x1

    iput v0, p0, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$UipToCommand$Builder;->bitField0_:I

    .line 8939
    iput-object p1, p0, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$UipToCommand$Builder;->command_:Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$UipToCommand$Command_Type;

    .line 8940
    invoke-virtual {p0}, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$UipToCommand$Builder;->onChanged()V

    .line 8941
    return-object p0
.end method

.method public setEvent(Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$ControlEvent$Builder;)Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$UipToCommand$Builder;
    .locals 2

    .prologue
    .line 8994
    iget-object v0, p0, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$UipToCommand$Builder;->eventBuilder_:Lcom/google/protobuf/SingleFieldBuilder;

    if-nez v0, :cond_0

    .line 8995
    invoke-virtual {p1}, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$ControlEvent$Builder;->build()Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$ControlEvent;

    move-result-object v0

    iput-object v0, p0, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$UipToCommand$Builder;->event_:Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$ControlEvent;

    .line 8996
    invoke-virtual {p0}, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$UipToCommand$Builder;->onChanged()V

    .line 9000
    :goto_0
    iget v0, p0, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$UipToCommand$Builder;->bitField0_:I

    or-int/lit8 v0, v0, 0x2

    iput v0, p0, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$UipToCommand$Builder;->bitField0_:I

    .line 9001
    return-object p0

    .line 8998
    :cond_0
    iget-object v0, p0, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$UipToCommand$Builder;->eventBuilder_:Lcom/google/protobuf/SingleFieldBuilder;

    invoke-virtual {p1}, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$ControlEvent$Builder;->build()Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$ControlEvent;

    move-result-object v1

    invoke-virtual {v0, v1}, Lcom/google/protobuf/SingleFieldBuilder;->setMessage(Lcom/google/protobuf/GeneratedMessage;)Lcom/google/protobuf/SingleFieldBuilder;

    goto :goto_0
.end method

.method public setEvent(Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$ControlEvent;)Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$UipToCommand$Builder;
    .locals 1

    .prologue
    .line 8977
    iget-object v0, p0, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$UipToCommand$Builder;->eventBuilder_:Lcom/google/protobuf/SingleFieldBuilder;

    if-nez v0, :cond_1

    .line 8978
    if-nez p1, :cond_0

    .line 8979
    new-instance v0, Ljava/lang/NullPointerException;

    invoke-direct {v0}, Ljava/lang/NullPointerException;-><init>()V

    throw v0

    .line 8981
    :cond_0
    iput-object p1, p0, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$UipToCommand$Builder;->event_:Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$ControlEvent;

    .line 8982
    invoke-virtual {p0}, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$UipToCommand$Builder;->onChanged()V

    .line 8986
    :goto_0
    iget v0, p0, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$UipToCommand$Builder;->bitField0_:I

    or-int/lit8 v0, v0, 0x2

    iput v0, p0, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$UipToCommand$Builder;->bitField0_:I

    .line 8987
    return-object p0

    .line 8984
    :cond_1
    iget-object v0, p0, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$UipToCommand$Builder;->eventBuilder_:Lcom/google/protobuf/SingleFieldBuilder;

    invoke-virtual {v0, p1}, Lcom/google/protobuf/SingleFieldBuilder;->setMessage(Lcom/google/protobuf/GeneratedMessage;)Lcom/google/protobuf/SingleFieldBuilder;

    goto :goto_0
.end method

.method public setIsSuccess(Z)Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$UipToCommand$Builder;
    .locals 1

    .prologue
    .line 9088
    iget v0, p0, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$UipToCommand$Builder;->bitField0_:I

    or-int/lit8 v0, v0, 0x4

    iput v0, p0, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$UipToCommand$Builder;->bitField0_:I

    .line 9089
    iput-boolean p1, p0, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$UipToCommand$Builder;->isSuccess_:Z

    .line 9090
    invoke-virtual {p0}, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$UipToCommand$Builder;->onChanged()V

    .line 9091
    return-object p0
.end method

.method public setUipAttributeData(Ljava/lang/String;)Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$UipToCommand$Builder;
    .locals 1

    .prologue
    .line 9146
    if-nez p1, :cond_0

    .line 9147
    new-instance v0, Ljava/lang/NullPointerException;

    invoke-direct {v0}, Ljava/lang/NullPointerException;-><init>()V

    throw v0

    .line 9149
    :cond_0
    iget v0, p0, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$UipToCommand$Builder;->bitField0_:I

    or-int/lit8 v0, v0, 0x8

    iput v0, p0, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$UipToCommand$Builder;->bitField0_:I

    .line 9150
    iput-object p1, p0, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$UipToCommand$Builder;->uipAttributeData_:Ljava/lang/Object;

    .line 9151
    invoke-virtual {p0}, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$UipToCommand$Builder;->onChanged()V

    .line 9152
    return-object p0
.end method

.method public setUipAttributeDataBytes(Lcom/google/protobuf/ByteString;)Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$UipToCommand$Builder;
    .locals 1

    .prologue
    .line 9168
    if-nez p1, :cond_0

    .line 9169
    new-instance v0, Ljava/lang/NullPointerException;

    invoke-direct {v0}, Ljava/lang/NullPointerException;-><init>()V

    throw v0

    .line 9171
    :cond_0
    iget v0, p0, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$UipToCommand$Builder;->bitField0_:I

    or-int/lit8 v0, v0, 0x8

    iput v0, p0, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$UipToCommand$Builder;->bitField0_:I

    .line 9172
    iput-object p1, p0, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$UipToCommand$Builder;->uipAttributeData_:Ljava/lang/Object;

    .line 9173
    invoke-virtual {p0}, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$UipToCommand$Builder;->onChanged()V

    .line 9174
    return-object p0
.end method
