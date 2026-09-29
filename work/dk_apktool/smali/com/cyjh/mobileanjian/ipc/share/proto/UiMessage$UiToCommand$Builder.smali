.class public final Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$UiToCommand$Builder;
.super Lcom/google/protobuf/GeneratedMessage$Builder;
.source "SourceFile"

# interfaces
.implements Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$UiToCommandOrBuilder;


# annotations
.annotation system Ldalvik/annotation/EnclosingClass;
    value = Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$UiToCommand;
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x19
    name = "Builder"
.end annotation

.annotation system Ldalvik/annotation/Signature;
    value = {
        "Lcom/google/protobuf/GeneratedMessage$Builder",
        "<",
        "Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$UiToCommand$Builder;",
        ">;",
        "Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$UiToCommandOrBuilder;"
    }
.end annotation


# instance fields
.field private bitField0_:I

.field private command_:Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$UiToCommand$Command_Type;

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

.field private varTableBuilder_:Lcom/google/protobuf/RepeatedFieldBuilder;
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "Lcom/google/protobuf/RepeatedFieldBuilder",
            "<",
            "Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$ControlVar;",
            "Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$ControlVar$Builder;",
            "Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$ControlVarOrBuilder;",
            ">;"
        }
    .end annotation
.end field

.field private varTable_:Ljava/util/List;
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "Ljava/util/List",
            "<",
            "Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$ControlVar;",
            ">;"
        }
    .end annotation
.end field


# direct methods
.method private constructor <init>()V
    .locals 1

    .prologue
    .line 6816
    invoke-direct {p0}, Lcom/google/protobuf/GeneratedMessage$Builder;-><init>()V

    .line 7001
    sget-object v0, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$UiToCommand$Command_Type;->EVENT:Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$UiToCommand$Command_Type;

    iput-object v0, p0, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$UiToCommand$Builder;->command_:Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$UiToCommand$Command_Type;

    .line 7037
    invoke-static {}, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$ControlEvent;->getDefaultInstance()Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$ControlEvent;

    move-result-object v0

    iput-object v0, p0, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$UiToCommand$Builder;->event_:Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$ControlEvent;

    .line 7188
    invoke-static {}, Ljava/util/Collections;->emptyList()Ljava/util/List;

    move-result-object v0

    iput-object v0, p0, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$UiToCommand$Builder;->varTable_:Ljava/util/List;

    .line 6817
    invoke-direct {p0}, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$UiToCommand$Builder;->maybeForceBuilderInitialization()V

    .line 6818
    return-void
.end method

.method private constructor <init>(Lcom/google/protobuf/GeneratedMessage$BuilderParent;)V
    .locals 1

    .prologue
    .line 6822
    invoke-direct {p0, p1}, Lcom/google/protobuf/GeneratedMessage$Builder;-><init>(Lcom/google/protobuf/GeneratedMessage$BuilderParent;)V

    .line 7001
    sget-object v0, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$UiToCommand$Command_Type;->EVENT:Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$UiToCommand$Command_Type;

    iput-object v0, p0, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$UiToCommand$Builder;->command_:Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$UiToCommand$Command_Type;

    .line 7037
    invoke-static {}, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$ControlEvent;->getDefaultInstance()Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$ControlEvent;

    move-result-object v0

    iput-object v0, p0, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$UiToCommand$Builder;->event_:Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$ControlEvent;

    .line 7188
    invoke-static {}, Ljava/util/Collections;->emptyList()Ljava/util/List;

    move-result-object v0

    iput-object v0, p0, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$UiToCommand$Builder;->varTable_:Ljava/util/List;

    .line 6823
    invoke-direct {p0}, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$UiToCommand$Builder;->maybeForceBuilderInitialization()V

    .line 6824
    return-void
.end method

.method synthetic constructor <init>(Lcom/google/protobuf/GeneratedMessage$BuilderParent;Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$1;)V
    .locals 0

    .prologue
    .line 6800
    invoke-direct {p0, p1}, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$UiToCommand$Builder;-><init>(Lcom/google/protobuf/GeneratedMessage$BuilderParent;)V

    return-void
.end method

.method static synthetic access$7000()Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$UiToCommand$Builder;
    .locals 1

    .prologue
    .line 6800
    invoke-static {}, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$UiToCommand$Builder;->create()Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$UiToCommand$Builder;

    move-result-object v0

    return-object v0
.end method

.method private static create()Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$UiToCommand$Builder;
    .locals 1

    .prologue
    .line 6832
    new-instance v0, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$UiToCommand$Builder;

    invoke-direct {v0}, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$UiToCommand$Builder;-><init>()V

    return-object v0
.end method

.method private ensureVarTableIsMutable()V
    .locals 2

    .prologue
    .line 7190
    iget v0, p0, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$UiToCommand$Builder;->bitField0_:I

    and-int/lit8 v0, v0, 0x8

    const/16 v1, 0x8

    if-eq v0, v1, :cond_0

    .line 7191
    new-instance v0, Ljava/util/ArrayList;

    iget-object v1, p0, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$UiToCommand$Builder;->varTable_:Ljava/util/List;

    invoke-direct {v0, v1}, Ljava/util/ArrayList;-><init>(Ljava/util/Collection;)V

    iput-object v0, p0, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$UiToCommand$Builder;->varTable_:Ljava/util/List;

    .line 7192
    iget v0, p0, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$UiToCommand$Builder;->bitField0_:I

    or-int/lit8 v0, v0, 0x8

    iput v0, p0, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$UiToCommand$Builder;->bitField0_:I

    .line 7194
    :cond_0
    return-void
.end method

.method public static final getDescriptor()Lcom/google/protobuf/Descriptors$Descriptor;
    .locals 1

    .prologue
    .line 6805
    invoke-static {}, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage;->j()Lcom/google/protobuf/Descriptors$Descriptor;

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
    .line 7142
    iget-object v0, p0, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$UiToCommand$Builder;->eventBuilder_:Lcom/google/protobuf/SingleFieldBuilder;

    if-nez v0, :cond_0

    .line 7143
    new-instance v0, Lcom/google/protobuf/SingleFieldBuilder;

    iget-object v1, p0, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$UiToCommand$Builder;->event_:Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$ControlEvent;

    .line 7146
    invoke-virtual {p0}, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$UiToCommand$Builder;->getParentForChildren()Lcom/google/protobuf/GeneratedMessage$BuilderParent;

    move-result-object v2

    .line 7147
    invoke-virtual {p0}, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$UiToCommand$Builder;->isClean()Z

    move-result v3

    invoke-direct {v0, v1, v2, v3}, Lcom/google/protobuf/SingleFieldBuilder;-><init>(Lcom/google/protobuf/GeneratedMessage;Lcom/google/protobuf/GeneratedMessage$BuilderParent;Z)V

    iput-object v0, p0, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$UiToCommand$Builder;->eventBuilder_:Lcom/google/protobuf/SingleFieldBuilder;

    .line 7148
    const/4 v0, 0x0

    iput-object v0, p0, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$UiToCommand$Builder;->event_:Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$ControlEvent;

    .line 7150
    :cond_0
    iget-object v0, p0, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$UiToCommand$Builder;->eventBuilder_:Lcom/google/protobuf/SingleFieldBuilder;

    return-object v0
.end method

.method private getVarTableFieldBuilder()Lcom/google/protobuf/RepeatedFieldBuilder;
    .locals 5
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "()",
            "Lcom/google/protobuf/RepeatedFieldBuilder",
            "<",
            "Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$ControlVar;",
            "Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$ControlVar$Builder;",
            "Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$ControlVarOrBuilder;",
            ">;"
        }
    .end annotation

    .prologue
    .line 7414
    iget-object v0, p0, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$UiToCommand$Builder;->varTableBuilder_:Lcom/google/protobuf/RepeatedFieldBuilder;

    if-nez v0, :cond_0

    .line 7415
    new-instance v1, Lcom/google/protobuf/RepeatedFieldBuilder;

    iget-object v2, p0, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$UiToCommand$Builder;->varTable_:Ljava/util/List;

    iget v0, p0, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$UiToCommand$Builder;->bitField0_:I

    and-int/lit8 v0, v0, 0x8

    const/16 v3, 0x8

    if-ne v0, v3, :cond_1

    const/4 v0, 0x1

    .line 7419
    :goto_0
    invoke-virtual {p0}, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$UiToCommand$Builder;->getParentForChildren()Lcom/google/protobuf/GeneratedMessage$BuilderParent;

    move-result-object v3

    .line 7420
    invoke-virtual {p0}, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$UiToCommand$Builder;->isClean()Z

    move-result v4

    invoke-direct {v1, v2, v0, v3, v4}, Lcom/google/protobuf/RepeatedFieldBuilder;-><init>(Ljava/util/List;ZLcom/google/protobuf/GeneratedMessage$BuilderParent;Z)V

    iput-object v1, p0, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$UiToCommand$Builder;->varTableBuilder_:Lcom/google/protobuf/RepeatedFieldBuilder;

    .line 7421
    const/4 v0, 0x0

    iput-object v0, p0, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$UiToCommand$Builder;->varTable_:Ljava/util/List;

    .line 7423
    :cond_0
    iget-object v0, p0, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$UiToCommand$Builder;->varTableBuilder_:Lcom/google/protobuf/RepeatedFieldBuilder;

    return-object v0

    .line 7415
    :cond_1
    const/4 v0, 0x0

    goto :goto_0
.end method

.method private maybeForceBuilderInitialization()V
    .locals 1

    .prologue
    .line 6826
    invoke-static {}, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$UiToCommand;->access$7200()Z

    move-result v0

    if-eqz v0, :cond_0

    .line 6827
    invoke-direct {p0}, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$UiToCommand$Builder;->getEventFieldBuilder()Lcom/google/protobuf/SingleFieldBuilder;

    .line 6828
    invoke-direct {p0}, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$UiToCommand$Builder;->getVarTableFieldBuilder()Lcom/google/protobuf/RepeatedFieldBuilder;

    .line 6830
    :cond_0
    return-void
.end method


# virtual methods
.method public addAllVarTable(Ljava/lang/Iterable;)Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$UiToCommand$Builder;
    .locals 1
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "(",
            "Ljava/lang/Iterable",
            "<+",
            "Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$ControlVar;",
            ">;)",
            "Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$UiToCommand$Builder;"
        }
    .end annotation

    .prologue
    .line 7326
    iget-object v0, p0, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$UiToCommand$Builder;->varTableBuilder_:Lcom/google/protobuf/RepeatedFieldBuilder;

    if-nez v0, :cond_0

    .line 7327
    invoke-direct {p0}, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$UiToCommand$Builder;->ensureVarTableIsMutable()V

    .line 7328
    iget-object v0, p0, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$UiToCommand$Builder;->varTable_:Ljava/util/List;

    invoke-static {p1, v0}, Lcom/google/protobuf/GeneratedMessage$Builder;->addAll(Ljava/lang/Iterable;Ljava/util/Collection;)V

    .line 7329
    invoke-virtual {p0}, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$UiToCommand$Builder;->onChanged()V

    .line 7333
    :goto_0
    return-object p0

    .line 7331
    :cond_0
    iget-object v0, p0, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$UiToCommand$Builder;->varTableBuilder_:Lcom/google/protobuf/RepeatedFieldBuilder;

    invoke-virtual {v0, p1}, Lcom/google/protobuf/RepeatedFieldBuilder;->addAllMessages(Ljava/lang/Iterable;)Lcom/google/protobuf/RepeatedFieldBuilder;

    goto :goto_0
.end method

.method public addVarTable(ILcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$ControlVar$Builder;)Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$UiToCommand$Builder;
    .locals 2

    .prologue
    .line 7312
    iget-object v0, p0, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$UiToCommand$Builder;->varTableBuilder_:Lcom/google/protobuf/RepeatedFieldBuilder;

    if-nez v0, :cond_0

    .line 7313
    invoke-direct {p0}, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$UiToCommand$Builder;->ensureVarTableIsMutable()V

    .line 7314
    iget-object v0, p0, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$UiToCommand$Builder;->varTable_:Ljava/util/List;

    invoke-virtual {p2}, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$ControlVar$Builder;->build()Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$ControlVar;

    move-result-object v1

    invoke-interface {v0, p1, v1}, Ljava/util/List;->add(ILjava/lang/Object;)V

    .line 7315
    invoke-virtual {p0}, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$UiToCommand$Builder;->onChanged()V

    .line 7319
    :goto_0
    return-object p0

    .line 7317
    :cond_0
    iget-object v0, p0, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$UiToCommand$Builder;->varTableBuilder_:Lcom/google/protobuf/RepeatedFieldBuilder;

    invoke-virtual {p2}, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$ControlVar$Builder;->build()Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$ControlVar;

    move-result-object v1

    invoke-virtual {v0, p1, v1}, Lcom/google/protobuf/RepeatedFieldBuilder;->addMessage(ILcom/google/protobuf/GeneratedMessage;)Lcom/google/protobuf/RepeatedFieldBuilder;

    goto :goto_0
.end method

.method public addVarTable(ILcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$ControlVar;)Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$UiToCommand$Builder;
    .locals 1

    .prologue
    .line 7281
    iget-object v0, p0, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$UiToCommand$Builder;->varTableBuilder_:Lcom/google/protobuf/RepeatedFieldBuilder;

    if-nez v0, :cond_1

    .line 7282
    if-nez p2, :cond_0

    .line 7283
    new-instance v0, Ljava/lang/NullPointerException;

    invoke-direct {v0}, Ljava/lang/NullPointerException;-><init>()V

    throw v0

    .line 7285
    :cond_0
    invoke-direct {p0}, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$UiToCommand$Builder;->ensureVarTableIsMutable()V

    .line 7286
    iget-object v0, p0, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$UiToCommand$Builder;->varTable_:Ljava/util/List;

    invoke-interface {v0, p1, p2}, Ljava/util/List;->add(ILjava/lang/Object;)V

    .line 7287
    invoke-virtual {p0}, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$UiToCommand$Builder;->onChanged()V

    .line 7291
    :goto_0
    return-object p0

    .line 7289
    :cond_1
    iget-object v0, p0, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$UiToCommand$Builder;->varTableBuilder_:Lcom/google/protobuf/RepeatedFieldBuilder;

    invoke-virtual {v0, p1, p2}, Lcom/google/protobuf/RepeatedFieldBuilder;->addMessage(ILcom/google/protobuf/GeneratedMessage;)Lcom/google/protobuf/RepeatedFieldBuilder;

    goto :goto_0
.end method

.method public addVarTable(Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$ControlVar$Builder;)Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$UiToCommand$Builder;
    .locals 2

    .prologue
    .line 7298
    iget-object v0, p0, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$UiToCommand$Builder;->varTableBuilder_:Lcom/google/protobuf/RepeatedFieldBuilder;

    if-nez v0, :cond_0

    .line 7299
    invoke-direct {p0}, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$UiToCommand$Builder;->ensureVarTableIsMutable()V

    .line 7300
    iget-object v0, p0, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$UiToCommand$Builder;->varTable_:Ljava/util/List;

    invoke-virtual {p1}, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$ControlVar$Builder;->build()Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$ControlVar;

    move-result-object v1

    invoke-interface {v0, v1}, Ljava/util/List;->add(Ljava/lang/Object;)Z

    .line 7301
    invoke-virtual {p0}, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$UiToCommand$Builder;->onChanged()V

    .line 7305
    :goto_0
    return-object p0

    .line 7303
    :cond_0
    iget-object v0, p0, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$UiToCommand$Builder;->varTableBuilder_:Lcom/google/protobuf/RepeatedFieldBuilder;

    invoke-virtual {p1}, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$ControlVar$Builder;->build()Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$ControlVar;

    move-result-object v1

    invoke-virtual {v0, v1}, Lcom/google/protobuf/RepeatedFieldBuilder;->addMessage(Lcom/google/protobuf/GeneratedMessage;)Lcom/google/protobuf/RepeatedFieldBuilder;

    goto :goto_0
.end method

.method public addVarTable(Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$ControlVar;)Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$UiToCommand$Builder;
    .locals 1

    .prologue
    .line 7264
    iget-object v0, p0, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$UiToCommand$Builder;->varTableBuilder_:Lcom/google/protobuf/RepeatedFieldBuilder;

    if-nez v0, :cond_1

    .line 7265
    if-nez p1, :cond_0

    .line 7266
    new-instance v0, Ljava/lang/NullPointerException;

    invoke-direct {v0}, Ljava/lang/NullPointerException;-><init>()V

    throw v0

    .line 7268
    :cond_0
    invoke-direct {p0}, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$UiToCommand$Builder;->ensureVarTableIsMutable()V

    .line 7269
    iget-object v0, p0, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$UiToCommand$Builder;->varTable_:Ljava/util/List;

    invoke-interface {v0, p1}, Ljava/util/List;->add(Ljava/lang/Object;)Z

    .line 7270
    invoke-virtual {p0}, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$UiToCommand$Builder;->onChanged()V

    .line 7274
    :goto_0
    return-object p0

    .line 7272
    :cond_1
    iget-object v0, p0, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$UiToCommand$Builder;->varTableBuilder_:Lcom/google/protobuf/RepeatedFieldBuilder;

    invoke-virtual {v0, p1}, Lcom/google/protobuf/RepeatedFieldBuilder;->addMessage(Lcom/google/protobuf/GeneratedMessage;)Lcom/google/protobuf/RepeatedFieldBuilder;

    goto :goto_0
.end method

.method public addVarTableBuilder()Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$ControlVar$Builder;
    .locals 2

    .prologue
    .line 7393
    invoke-direct {p0}, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$UiToCommand$Builder;->getVarTableFieldBuilder()Lcom/google/protobuf/RepeatedFieldBuilder;

    move-result-object v0

    .line 7394
    invoke-static {}, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$ControlVar;->getDefaultInstance()Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$ControlVar;

    move-result-object v1

    .line 7393
    invoke-virtual {v0, v1}, Lcom/google/protobuf/RepeatedFieldBuilder;->addBuilder(Lcom/google/protobuf/GeneratedMessage;)Lcom/google/protobuf/GeneratedMessage$Builder;

    move-result-object v0

    check-cast v0, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$ControlVar$Builder;

    return-object v0
.end method

.method public addVarTableBuilder(I)Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$ControlVar$Builder;
    .locals 2

    .prologue
    .line 7401
    invoke-direct {p0}, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$UiToCommand$Builder;->getVarTableFieldBuilder()Lcom/google/protobuf/RepeatedFieldBuilder;

    move-result-object v0

    .line 7402
    invoke-static {}, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$ControlVar;->getDefaultInstance()Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$ControlVar;

    move-result-object v1

    .line 7401
    invoke-virtual {v0, p1, v1}, Lcom/google/protobuf/RepeatedFieldBuilder;->addBuilder(ILcom/google/protobuf/GeneratedMessage;)Lcom/google/protobuf/GeneratedMessage$Builder;

    move-result-object v0

    check-cast v0, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$ControlVar$Builder;

    return-object v0
.end method

.method public build()Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$UiToCommand;
    .locals 2

    .prologue
    .line 6870
    invoke-virtual {p0}, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$UiToCommand$Builder;->buildPartial()Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$UiToCommand;

    move-result-object v0

    .line 6871
    invoke-virtual {v0}, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$UiToCommand;->isInitialized()Z

    move-result v1

    if-nez v1, :cond_0

    .line 6872
    invoke-static {v0}, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$UiToCommand$Builder;->newUninitializedMessageException(Lcom/google/protobuf/Message;)Lcom/google/protobuf/UninitializedMessageException;

    move-result-object v0

    throw v0

    .line 6874
    :cond_0
    return-object v0
.end method

.method public bridge synthetic build()Lcom/google/protobuf/Message;
    .locals 1

    .prologue
    .line 6800
    invoke-virtual {p0}, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$UiToCommand$Builder;->build()Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$UiToCommand;

    move-result-object v0

    return-object v0
.end method

.method public bridge synthetic build()Lcom/google/protobuf/MessageLite;
    .locals 1

    .prologue
    .line 6800
    invoke-virtual {p0}, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$UiToCommand$Builder;->build()Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$UiToCommand;

    move-result-object v0

    return-object v0
.end method

.method public buildPartial()Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$UiToCommand;
    .locals 5

    .prologue
    const/4 v0, 0x1

    .line 6878
    new-instance v2, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$UiToCommand;

    const/4 v1, 0x0

    invoke-direct {v2, p0, v1}, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$UiToCommand;-><init>(Lcom/google/protobuf/GeneratedMessage$Builder;Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$1;)V

    .line 6879
    iget v3, p0, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$UiToCommand$Builder;->bitField0_:I

    .line 6880
    const/4 v1, 0x0

    .line 6881
    and-int/lit8 v4, v3, 0x1

    if-ne v4, v0, :cond_5

    .line 6884
    :goto_0
    iget-object v1, p0, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$UiToCommand$Builder;->command_:Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$UiToCommand$Command_Type;

    invoke-static {v2, v1}, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$UiToCommand;->access$7402(Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$UiToCommand;Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$UiToCommand$Command_Type;)Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$UiToCommand$Command_Type;

    .line 6885
    and-int/lit8 v1, v3, 0x2

    const/4 v4, 0x2

    if-ne v1, v4, :cond_4

    .line 6886
    or-int/lit8 v0, v0, 0x2

    move v1, v0

    .line 6888
    :goto_1
    iget-object v0, p0, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$UiToCommand$Builder;->eventBuilder_:Lcom/google/protobuf/SingleFieldBuilder;

    if-nez v0, :cond_2

    .line 6889
    iget-object v0, p0, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$UiToCommand$Builder;->event_:Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$ControlEvent;

    invoke-static {v2, v0}, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$UiToCommand;->access$7502(Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$UiToCommand;Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$ControlEvent;)Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$ControlEvent;

    .line 6893
    :goto_2
    and-int/lit8 v0, v3, 0x4

    const/4 v3, 0x4

    if-ne v0, v3, :cond_0

    .line 6894
    or-int/lit8 v1, v1, 0x4

    .line 6896
    :cond_0
    iget-boolean v0, p0, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$UiToCommand$Builder;->isSuccess_:Z

    invoke-static {v2, v0}, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$UiToCommand;->access$7602(Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$UiToCommand;Z)Z

    .line 6897
    iget-object v0, p0, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$UiToCommand$Builder;->varTableBuilder_:Lcom/google/protobuf/RepeatedFieldBuilder;

    if-nez v0, :cond_3

    .line 6898
    iget v0, p0, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$UiToCommand$Builder;->bitField0_:I

    and-int/lit8 v0, v0, 0x8

    const/16 v3, 0x8

    if-ne v0, v3, :cond_1

    .line 6899
    iget-object v0, p0, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$UiToCommand$Builder;->varTable_:Ljava/util/List;

    invoke-static {v0}, Ljava/util/Collections;->unmodifiableList(Ljava/util/List;)Ljava/util/List;

    move-result-object v0

    iput-object v0, p0, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$UiToCommand$Builder;->varTable_:Ljava/util/List;

    .line 6900
    iget v0, p0, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$UiToCommand$Builder;->bitField0_:I

    and-int/lit8 v0, v0, -0x9

    iput v0, p0, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$UiToCommand$Builder;->bitField0_:I

    .line 6902
    :cond_1
    iget-object v0, p0, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$UiToCommand$Builder;->varTable_:Ljava/util/List;

    invoke-static {v2, v0}, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$UiToCommand;->access$7702(Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$UiToCommand;Ljava/util/List;)Ljava/util/List;

    .line 6906
    :goto_3
    invoke-static {v2, v1}, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$UiToCommand;->access$7802(Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$UiToCommand;I)I

    .line 6907
    invoke-virtual {p0}, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$UiToCommand$Builder;->onBuilt()V

    .line 6908
    return-object v2

    .line 6891
    :cond_2
    iget-object v0, p0, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$UiToCommand$Builder;->eventBuilder_:Lcom/google/protobuf/SingleFieldBuilder;

    invoke-virtual {v0}, Lcom/google/protobuf/SingleFieldBuilder;->build()Lcom/google/protobuf/GeneratedMessage;

    move-result-object v0

    check-cast v0, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$ControlEvent;

    invoke-static {v2, v0}, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$UiToCommand;->access$7502(Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$UiToCommand;Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$ControlEvent;)Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$ControlEvent;

    goto :goto_2

    .line 6904
    :cond_3
    iget-object v0, p0, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$UiToCommand$Builder;->varTableBuilder_:Lcom/google/protobuf/RepeatedFieldBuilder;

    invoke-virtual {v0}, Lcom/google/protobuf/RepeatedFieldBuilder;->build()Ljava/util/List;

    move-result-object v0

    invoke-static {v2, v0}, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$UiToCommand;->access$7702(Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$UiToCommand;Ljava/util/List;)Ljava/util/List;

    goto :goto_3

    :cond_4
    move v1, v0

    goto :goto_1

    :cond_5
    move v0, v1

    goto :goto_0
.end method

.method public bridge synthetic buildPartial()Lcom/google/protobuf/Message;
    .locals 1

    .prologue
    .line 6800
    invoke-virtual {p0}, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$UiToCommand$Builder;->buildPartial()Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$UiToCommand;

    move-result-object v0

    return-object v0
.end method

.method public bridge synthetic buildPartial()Lcom/google/protobuf/MessageLite;
    .locals 1

    .prologue
    .line 6800
    invoke-virtual {p0}, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$UiToCommand$Builder;->buildPartial()Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$UiToCommand;

    move-result-object v0

    return-object v0
.end method

.method public clear()Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$UiToCommand$Builder;
    .locals 1

    .prologue
    .line 6836
    invoke-super {p0}, Lcom/google/protobuf/GeneratedMessage$Builder;->clear()Lcom/google/protobuf/GeneratedMessage$Builder;

    .line 6837
    sget-object v0, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$UiToCommand$Command_Type;->EVENT:Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$UiToCommand$Command_Type;

    iput-object v0, p0, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$UiToCommand$Builder;->command_:Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$UiToCommand$Command_Type;

    .line 6838
    iget v0, p0, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$UiToCommand$Builder;->bitField0_:I

    and-int/lit8 v0, v0, -0x2

    iput v0, p0, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$UiToCommand$Builder;->bitField0_:I

    .line 6839
    iget-object v0, p0, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$UiToCommand$Builder;->eventBuilder_:Lcom/google/protobuf/SingleFieldBuilder;

    if-nez v0, :cond_0

    .line 6840
    invoke-static {}, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$ControlEvent;->getDefaultInstance()Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$ControlEvent;

    move-result-object v0

    iput-object v0, p0, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$UiToCommand$Builder;->event_:Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$ControlEvent;

    .line 6844
    :goto_0
    iget v0, p0, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$UiToCommand$Builder;->bitField0_:I

    and-int/lit8 v0, v0, -0x3

    iput v0, p0, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$UiToCommand$Builder;->bitField0_:I

    .line 6845
    const/4 v0, 0x0

    iput-boolean v0, p0, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$UiToCommand$Builder;->isSuccess_:Z

    .line 6846
    iget v0, p0, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$UiToCommand$Builder;->bitField0_:I

    and-int/lit8 v0, v0, -0x5

    iput v0, p0, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$UiToCommand$Builder;->bitField0_:I

    .line 6847
    iget-object v0, p0, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$UiToCommand$Builder;->varTableBuilder_:Lcom/google/protobuf/RepeatedFieldBuilder;

    if-nez v0, :cond_1

    .line 6848
    invoke-static {}, Ljava/util/Collections;->emptyList()Ljava/util/List;

    move-result-object v0

    iput-object v0, p0, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$UiToCommand$Builder;->varTable_:Ljava/util/List;

    .line 6849
    iget v0, p0, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$UiToCommand$Builder;->bitField0_:I

    and-int/lit8 v0, v0, -0x9

    iput v0, p0, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$UiToCommand$Builder;->bitField0_:I

    .line 6853
    :goto_1
    return-object p0

    .line 6842
    :cond_0
    iget-object v0, p0, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$UiToCommand$Builder;->eventBuilder_:Lcom/google/protobuf/SingleFieldBuilder;

    invoke-virtual {v0}, Lcom/google/protobuf/SingleFieldBuilder;->clear()Lcom/google/protobuf/SingleFieldBuilder;

    goto :goto_0

    .line 6851
    :cond_1
    iget-object v0, p0, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$UiToCommand$Builder;->varTableBuilder_:Lcom/google/protobuf/RepeatedFieldBuilder;

    invoke-virtual {v0}, Lcom/google/protobuf/RepeatedFieldBuilder;->clear()V

    goto :goto_1
.end method

.method public bridge synthetic clear()Lcom/google/protobuf/AbstractMessage$Builder;
    .locals 1

    .prologue
    .line 6800
    invoke-virtual {p0}, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$UiToCommand$Builder;->clear()Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$UiToCommand$Builder;

    move-result-object v0

    return-object v0
.end method

.method public bridge synthetic clear()Lcom/google/protobuf/GeneratedMessage$Builder;
    .locals 1

    .prologue
    .line 6800
    invoke-virtual {p0}, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$UiToCommand$Builder;->clear()Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$UiToCommand$Builder;

    move-result-object v0

    return-object v0
.end method

.method public bridge synthetic clear()Lcom/google/protobuf/Message$Builder;
    .locals 1

    .prologue
    .line 6800
    invoke-virtual {p0}, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$UiToCommand$Builder;->clear()Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$UiToCommand$Builder;

    move-result-object v0

    return-object v0
.end method

.method public bridge synthetic clear()Lcom/google/protobuf/MessageLite$Builder;
    .locals 1

    .prologue
    .line 6800
    invoke-virtual {p0}, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$UiToCommand$Builder;->clear()Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$UiToCommand$Builder;

    move-result-object v0

    return-object v0
.end method

.method public clearCommand()Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$UiToCommand$Builder;
    .locals 1

    .prologue
    .line 7030
    iget v0, p0, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$UiToCommand$Builder;->bitField0_:I

    and-int/lit8 v0, v0, -0x2

    iput v0, p0, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$UiToCommand$Builder;->bitField0_:I

    .line 7031
    sget-object v0, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$UiToCommand$Command_Type;->EVENT:Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$UiToCommand$Command_Type;

    iput-object v0, p0, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$UiToCommand$Builder;->command_:Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$UiToCommand$Command_Type;

    .line 7032
    invoke-virtual {p0}, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$UiToCommand$Builder;->onChanged()V

    .line 7033
    return-object p0
.end method

.method public clearEvent()Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$UiToCommand$Builder;
    .locals 1

    .prologue
    .line 7109
    iget-object v0, p0, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$UiToCommand$Builder;->eventBuilder_:Lcom/google/protobuf/SingleFieldBuilder;

    if-nez v0, :cond_0

    .line 7110
    invoke-static {}, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$ControlEvent;->getDefaultInstance()Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$ControlEvent;

    move-result-object v0

    iput-object v0, p0, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$UiToCommand$Builder;->event_:Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$ControlEvent;

    .line 7111
    invoke-virtual {p0}, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$UiToCommand$Builder;->onChanged()V

    .line 7115
    :goto_0
    iget v0, p0, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$UiToCommand$Builder;->bitField0_:I

    and-int/lit8 v0, v0, -0x3

    iput v0, p0, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$UiToCommand$Builder;->bitField0_:I

    .line 7116
    return-object p0

    .line 7113
    :cond_0
    iget-object v0, p0, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$UiToCommand$Builder;->eventBuilder_:Lcom/google/protobuf/SingleFieldBuilder;

    invoke-virtual {v0}, Lcom/google/protobuf/SingleFieldBuilder;->clear()Lcom/google/protobuf/SingleFieldBuilder;

    goto :goto_0
.end method

.method public clearIsSuccess()Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$UiToCommand$Builder;
    .locals 1

    .prologue
    .line 7180
    iget v0, p0, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$UiToCommand$Builder;->bitField0_:I

    and-int/lit8 v0, v0, -0x5

    iput v0, p0, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$UiToCommand$Builder;->bitField0_:I

    .line 7181
    const/4 v0, 0x0

    iput-boolean v0, p0, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$UiToCommand$Builder;->isSuccess_:Z

    .line 7182
    invoke-virtual {p0}, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$UiToCommand$Builder;->onChanged()V

    .line 7183
    return-object p0
.end method

.method public clearVarTable()Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$UiToCommand$Builder;
    .locals 1

    .prologue
    .line 7339
    iget-object v0, p0, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$UiToCommand$Builder;->varTableBuilder_:Lcom/google/protobuf/RepeatedFieldBuilder;

    if-nez v0, :cond_0

    .line 7340
    invoke-static {}, Ljava/util/Collections;->emptyList()Ljava/util/List;

    move-result-object v0

    iput-object v0, p0, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$UiToCommand$Builder;->varTable_:Ljava/util/List;

    .line 7341
    iget v0, p0, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$UiToCommand$Builder;->bitField0_:I

    and-int/lit8 v0, v0, -0x9

    iput v0, p0, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$UiToCommand$Builder;->bitField0_:I

    .line 7342
    invoke-virtual {p0}, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$UiToCommand$Builder;->onChanged()V

    .line 7346
    :goto_0
    return-object p0

    .line 7344
    :cond_0
    iget-object v0, p0, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$UiToCommand$Builder;->varTableBuilder_:Lcom/google/protobuf/RepeatedFieldBuilder;

    invoke-virtual {v0}, Lcom/google/protobuf/RepeatedFieldBuilder;->clear()V

    goto :goto_0
.end method

.method public clone()Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$UiToCommand$Builder;
    .locals 2

    .prologue
    .line 6857
    invoke-static {}, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$UiToCommand$Builder;->create()Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$UiToCommand$Builder;

    move-result-object v0

    invoke-virtual {p0}, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$UiToCommand$Builder;->buildPartial()Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$UiToCommand;

    move-result-object v1

    invoke-virtual {v0, v1}, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$UiToCommand$Builder;->mergeFrom(Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$UiToCommand;)Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$UiToCommand$Builder;

    move-result-object v0

    return-object v0
.end method

.method public bridge synthetic clone()Lcom/google/protobuf/AbstractMessage$Builder;
    .locals 1

    .prologue
    .line 6800
    invoke-virtual {p0}, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$UiToCommand$Builder;->clone()Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$UiToCommand$Builder;

    move-result-object v0

    return-object v0
.end method

.method public bridge synthetic clone()Lcom/google/protobuf/AbstractMessageLite$Builder;
    .locals 1

    .prologue
    .line 6800
    invoke-virtual {p0}, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$UiToCommand$Builder;->clone()Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$UiToCommand$Builder;

    move-result-object v0

    return-object v0
.end method

.method public bridge synthetic clone()Lcom/google/protobuf/GeneratedMessage$Builder;
    .locals 1

    .prologue
    .line 6800
    invoke-virtual {p0}, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$UiToCommand$Builder;->clone()Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$UiToCommand$Builder;

    move-result-object v0

    return-object v0
.end method

.method public bridge synthetic clone()Lcom/google/protobuf/Message$Builder;
    .locals 1

    .prologue
    .line 6800
    invoke-virtual {p0}, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$UiToCommand$Builder;->clone()Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$UiToCommand$Builder;

    move-result-object v0

    return-object v0
.end method

.method public bridge synthetic clone()Lcom/google/protobuf/MessageLite$Builder;
    .locals 1

    .prologue
    .line 6800
    invoke-virtual {p0}, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$UiToCommand$Builder;->clone()Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$UiToCommand$Builder;

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
    .line 6800
    invoke-virtual {p0}, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$UiToCommand$Builder;->clone()Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$UiToCommand$Builder;

    move-result-object v0

    return-object v0
.end method

.method public getCommand()Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$UiToCommand$Command_Type;
    .locals 1

    .prologue
    .line 7012
    iget-object v0, p0, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$UiToCommand$Builder;->command_:Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$UiToCommand$Command_Type;

    return-object v0
.end method

.method public getDefaultInstanceForType()Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$UiToCommand;
    .locals 1

    .prologue
    .line 6866
    invoke-static {}, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$UiToCommand;->getDefaultInstance()Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$UiToCommand;

    move-result-object v0

    return-object v0
.end method

.method public bridge synthetic getDefaultInstanceForType()Lcom/google/protobuf/Message;
    .locals 1

    .prologue
    .line 6800
    invoke-virtual {p0}, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$UiToCommand$Builder;->getDefaultInstanceForType()Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$UiToCommand;

    move-result-object v0

    return-object v0
.end method

.method public bridge synthetic getDefaultInstanceForType()Lcom/google/protobuf/MessageLite;
    .locals 1

    .prologue
    .line 6800
    invoke-virtual {p0}, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$UiToCommand$Builder;->getDefaultInstanceForType()Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$UiToCommand;

    move-result-object v0

    return-object v0
.end method

.method public getDescriptorForType()Lcom/google/protobuf/Descriptors$Descriptor;
    .locals 1

    .prologue
    .line 6862
    invoke-static {}, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage;->j()Lcom/google/protobuf/Descriptors$Descriptor;

    move-result-object v0

    return-object v0
.end method

.method public getEvent()Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$ControlEvent;
    .locals 1

    .prologue
    .line 7050
    iget-object v0, p0, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$UiToCommand$Builder;->eventBuilder_:Lcom/google/protobuf/SingleFieldBuilder;

    if-nez v0, :cond_0

    .line 7051
    iget-object v0, p0, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$UiToCommand$Builder;->event_:Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$ControlEvent;

    .line 7053
    :goto_0
    return-object v0

    :cond_0
    iget-object v0, p0, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$UiToCommand$Builder;->eventBuilder_:Lcom/google/protobuf/SingleFieldBuilder;

    invoke-virtual {v0}, Lcom/google/protobuf/SingleFieldBuilder;->getMessage()Lcom/google/protobuf/GeneratedMessage;

    move-result-object v0

    check-cast v0, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$ControlEvent;

    goto :goto_0
.end method

.method public getEventBuilder()Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$ControlEvent$Builder;
    .locals 1

    .prologue
    .line 7122
    iget v0, p0, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$UiToCommand$Builder;->bitField0_:I

    or-int/lit8 v0, v0, 0x2

    iput v0, p0, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$UiToCommand$Builder;->bitField0_:I

    .line 7123
    invoke-virtual {p0}, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$UiToCommand$Builder;->onChanged()V

    .line 7124
    invoke-direct {p0}, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$UiToCommand$Builder;->getEventFieldBuilder()Lcom/google/protobuf/SingleFieldBuilder;

    move-result-object v0

    invoke-virtual {v0}, Lcom/google/protobuf/SingleFieldBuilder;->getBuilder()Lcom/google/protobuf/GeneratedMessage$Builder;

    move-result-object v0

    check-cast v0, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$ControlEvent$Builder;

    return-object v0
.end method

.method public getEventOrBuilder()Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$ControlEventOrBuilder;
    .locals 1

    .prologue
    .line 7130
    iget-object v0, p0, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$UiToCommand$Builder;->eventBuilder_:Lcom/google/protobuf/SingleFieldBuilder;

    if-eqz v0, :cond_0

    .line 7131
    iget-object v0, p0, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$UiToCommand$Builder;->eventBuilder_:Lcom/google/protobuf/SingleFieldBuilder;

    invoke-virtual {v0}, Lcom/google/protobuf/SingleFieldBuilder;->getMessageOrBuilder()Lcom/google/protobuf/MessageOrBuilder;

    move-result-object v0

    check-cast v0, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$ControlEventOrBuilder;

    .line 7133
    :goto_0
    return-object v0

    :cond_0
    iget-object v0, p0, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$UiToCommand$Builder;->event_:Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$ControlEvent;

    goto :goto_0
.end method

.method public getIsSuccess()Z
    .locals 1

    .prologue
    .line 7165
    iget-boolean v0, p0, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$UiToCommand$Builder;->isSuccess_:Z

    return v0
.end method

.method public getVarTable(I)Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$ControlVar;
    .locals 1

    .prologue
    .line 7223
    iget-object v0, p0, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$UiToCommand$Builder;->varTableBuilder_:Lcom/google/protobuf/RepeatedFieldBuilder;

    if-nez v0, :cond_0

    .line 7224
    iget-object v0, p0, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$UiToCommand$Builder;->varTable_:Ljava/util/List;

    invoke-interface {v0, p1}, Ljava/util/List;->get(I)Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$ControlVar;

    .line 7226
    :goto_0
    return-object v0

    :cond_0
    iget-object v0, p0, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$UiToCommand$Builder;->varTableBuilder_:Lcom/google/protobuf/RepeatedFieldBuilder;

    invoke-virtual {v0, p1}, Lcom/google/protobuf/RepeatedFieldBuilder;->getMessage(I)Lcom/google/protobuf/GeneratedMessage;

    move-result-object v0

    check-cast v0, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$ControlVar;

    goto :goto_0
.end method

.method public getVarTableBuilder(I)Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$ControlVar$Builder;
    .locals 1

    .prologue
    .line 7366
    invoke-direct {p0}, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$UiToCommand$Builder;->getVarTableFieldBuilder()Lcom/google/protobuf/RepeatedFieldBuilder;

    move-result-object v0

    invoke-virtual {v0, p1}, Lcom/google/protobuf/RepeatedFieldBuilder;->getBuilder(I)Lcom/google/protobuf/GeneratedMessage$Builder;

    move-result-object v0

    check-cast v0, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$ControlVar$Builder;

    return-object v0
.end method

.method public getVarTableBuilderList()Ljava/util/List;
    .locals 1
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "()",
            "Ljava/util/List",
            "<",
            "Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$ControlVar$Builder;",
            ">;"
        }
    .end annotation

    .prologue
    .line 7409
    invoke-direct {p0}, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$UiToCommand$Builder;->getVarTableFieldBuilder()Lcom/google/protobuf/RepeatedFieldBuilder;

    move-result-object v0

    invoke-virtual {v0}, Lcom/google/protobuf/RepeatedFieldBuilder;->getBuilderList()Ljava/util/List;

    move-result-object v0

    return-object v0
.end method

.method public getVarTableCount()I
    .locals 1

    .prologue
    .line 7213
    iget-object v0, p0, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$UiToCommand$Builder;->varTableBuilder_:Lcom/google/protobuf/RepeatedFieldBuilder;

    if-nez v0, :cond_0

    .line 7214
    iget-object v0, p0, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$UiToCommand$Builder;->varTable_:Ljava/util/List;

    invoke-interface {v0}, Ljava/util/List;->size()I

    move-result v0

    .line 7216
    :goto_0
    return v0

    :cond_0
    iget-object v0, p0, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$UiToCommand$Builder;->varTableBuilder_:Lcom/google/protobuf/RepeatedFieldBuilder;

    invoke-virtual {v0}, Lcom/google/protobuf/RepeatedFieldBuilder;->getCount()I

    move-result v0

    goto :goto_0
.end method

.method public getVarTableList()Ljava/util/List;
    .locals 1
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "()",
            "Ljava/util/List",
            "<",
            "Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$ControlVar;",
            ">;"
        }
    .end annotation

    .prologue
    .line 7203
    iget-object v0, p0, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$UiToCommand$Builder;->varTableBuilder_:Lcom/google/protobuf/RepeatedFieldBuilder;

    if-nez v0, :cond_0

    .line 7204
    iget-object v0, p0, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$UiToCommand$Builder;->varTable_:Ljava/util/List;

    invoke-static {v0}, Ljava/util/Collections;->unmodifiableList(Ljava/util/List;)Ljava/util/List;

    move-result-object v0

    .line 7206
    :goto_0
    return-object v0

    :cond_0
    iget-object v0, p0, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$UiToCommand$Builder;->varTableBuilder_:Lcom/google/protobuf/RepeatedFieldBuilder;

    invoke-virtual {v0}, Lcom/google/protobuf/RepeatedFieldBuilder;->getMessageList()Ljava/util/List;

    move-result-object v0

    goto :goto_0
.end method

.method public getVarTableOrBuilder(I)Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$ControlVarOrBuilder;
    .locals 1

    .prologue
    .line 7373
    iget-object v0, p0, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$UiToCommand$Builder;->varTableBuilder_:Lcom/google/protobuf/RepeatedFieldBuilder;

    if-nez v0, :cond_0

    .line 7374
    iget-object v0, p0, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$UiToCommand$Builder;->varTable_:Ljava/util/List;

    invoke-interface {v0, p1}, Ljava/util/List;->get(I)Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$ControlVarOrBuilder;

    .line 7375
    :goto_0
    return-object v0

    :cond_0
    iget-object v0, p0, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$UiToCommand$Builder;->varTableBuilder_:Lcom/google/protobuf/RepeatedFieldBuilder;

    invoke-virtual {v0, p1}, Lcom/google/protobuf/RepeatedFieldBuilder;->getMessageOrBuilder(I)Lcom/google/protobuf/MessageOrBuilder;

    move-result-object v0

    check-cast v0, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$ControlVarOrBuilder;

    goto :goto_0
.end method

.method public getVarTableOrBuilderList()Ljava/util/List;
    .locals 1
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "()",
            "Ljava/util/List",
            "<+",
            "Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$ControlVarOrBuilder;",
            ">;"
        }
    .end annotation

    .prologue
    .line 7383
    iget-object v0, p0, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$UiToCommand$Builder;->varTableBuilder_:Lcom/google/protobuf/RepeatedFieldBuilder;

    if-eqz v0, :cond_0

    .line 7384
    iget-object v0, p0, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$UiToCommand$Builder;->varTableBuilder_:Lcom/google/protobuf/RepeatedFieldBuilder;

    invoke-virtual {v0}, Lcom/google/protobuf/RepeatedFieldBuilder;->getMessageOrBuilderList()Ljava/util/List;

    move-result-object v0

    .line 7386
    :goto_0
    return-object v0

    :cond_0
    iget-object v0, p0, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$UiToCommand$Builder;->varTable_:Ljava/util/List;

    invoke-static {v0}, Ljava/util/Collections;->unmodifiableList(Ljava/util/List;)Ljava/util/List;

    move-result-object v0

    goto :goto_0
.end method

.method public hasCommand()Z
    .locals 2

    .prologue
    const/4 v0, 0x1

    .line 7006
    iget v1, p0, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$UiToCommand$Builder;->bitField0_:I

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
    .line 7044
    iget v0, p0, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$UiToCommand$Builder;->bitField0_:I

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
    .line 7159
    iget v0, p0, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$UiToCommand$Builder;->bitField0_:I

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
    .line 6810
    invoke-static {}, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage;->k()Lcom/google/protobuf/GeneratedMessage$FieldAccessorTable;

    move-result-object v0

    const-class v1, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$UiToCommand;

    const-class v2, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$UiToCommand$Builder;

    .line 6811
    invoke-virtual {v0, v1, v2}, Lcom/google/protobuf/GeneratedMessage$FieldAccessorTable;->ensureFieldAccessorsInitialized(Ljava/lang/Class;Ljava/lang/Class;)Lcom/google/protobuf/GeneratedMessage$FieldAccessorTable;

    move-result-object v0

    .line 6810
    return-object v0
.end method

.method public final isInitialized()Z
    .locals 3

    .prologue
    const/4 v1, 0x0

    .line 6962
    invoke-virtual {p0}, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$UiToCommand$Builder;->hasCommand()Z

    move-result v0

    if-nez v0, :cond_1

    .line 6978
    :cond_0
    :goto_0
    return v1

    .line 6966
    :cond_1
    invoke-virtual {p0}, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$UiToCommand$Builder;->hasEvent()Z

    move-result v0

    if-eqz v0, :cond_2

    .line 6967
    invoke-virtual {p0}, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$UiToCommand$Builder;->getEvent()Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$ControlEvent;

    move-result-object v0

    invoke-virtual {v0}, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$ControlEvent;->isInitialized()Z

    move-result v0

    if-eqz v0, :cond_0

    :cond_2
    move v0, v1

    .line 6972
    :goto_1
    invoke-virtual {p0}, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$UiToCommand$Builder;->getVarTableCount()I

    move-result v2

    if-ge v0, v2, :cond_3

    .line 6973
    invoke-virtual {p0, v0}, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$UiToCommand$Builder;->getVarTable(I)Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$ControlVar;

    move-result-object v2

    invoke-virtual {v2}, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$ControlVar;->isInitialized()Z

    move-result v2

    if-eqz v2, :cond_0

    .line 6972
    add-int/lit8 v0, v0, 0x1

    goto :goto_1

    .line 6978
    :cond_3
    const/4 v1, 0x1

    goto :goto_0
.end method

.method public mergeEvent(Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$ControlEvent;)Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$UiToCommand$Builder;
    .locals 2

    .prologue
    .line 7090
    iget-object v0, p0, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$UiToCommand$Builder;->eventBuilder_:Lcom/google/protobuf/SingleFieldBuilder;

    if-nez v0, :cond_1

    .line 7091
    iget v0, p0, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$UiToCommand$Builder;->bitField0_:I

    and-int/lit8 v0, v0, 0x2

    const/4 v1, 0x2

    if-ne v0, v1, :cond_0

    iget-object v0, p0, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$UiToCommand$Builder;->event_:Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$ControlEvent;

    .line 7092
    invoke-static {}, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$ControlEvent;->getDefaultInstance()Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$ControlEvent;

    move-result-object v1

    if-eq v0, v1, :cond_0

    .line 7093
    iget-object v0, p0, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$UiToCommand$Builder;->event_:Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$ControlEvent;

    .line 7094
    invoke-static {v0}, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$ControlEvent;->newBuilder(Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$ControlEvent;)Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$ControlEvent$Builder;

    move-result-object v0

    invoke-virtual {v0, p1}, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$ControlEvent$Builder;->mergeFrom(Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$ControlEvent;)Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$ControlEvent$Builder;

    move-result-object v0

    invoke-virtual {v0}, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$ControlEvent$Builder;->buildPartial()Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$ControlEvent;

    move-result-object v0

    iput-object v0, p0, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$UiToCommand$Builder;->event_:Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$ControlEvent;

    .line 7098
    :goto_0
    invoke-virtual {p0}, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$UiToCommand$Builder;->onChanged()V

    .line 7102
    :goto_1
    iget v0, p0, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$UiToCommand$Builder;->bitField0_:I

    or-int/lit8 v0, v0, 0x2

    iput v0, p0, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$UiToCommand$Builder;->bitField0_:I

    .line 7103
    return-object p0

    .line 7096
    :cond_0
    iput-object p1, p0, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$UiToCommand$Builder;->event_:Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$ControlEvent;

    goto :goto_0

    .line 7100
    :cond_1
    iget-object v0, p0, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$UiToCommand$Builder;->eventBuilder_:Lcom/google/protobuf/SingleFieldBuilder;

    invoke-virtual {v0, p1}, Lcom/google/protobuf/SingleFieldBuilder;->mergeFrom(Lcom/google/protobuf/GeneratedMessage;)Lcom/google/protobuf/SingleFieldBuilder;

    goto :goto_1
.end method

.method public mergeFrom(Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$UiToCommand;)Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$UiToCommand$Builder;
    .locals 2

    .prologue
    const/4 v0, 0x0

    .line 6921
    invoke-static {}, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$UiToCommand;->getDefaultInstance()Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$UiToCommand;

    move-result-object v1

    if-ne p1, v1, :cond_0

    .line 6958
    :goto_0
    return-object p0

    .line 6922
    :cond_0
    invoke-virtual {p1}, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$UiToCommand;->hasCommand()Z

    move-result v1

    if-eqz v1, :cond_1

    .line 6923
    invoke-virtual {p1}, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$UiToCommand;->getCommand()Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$UiToCommand$Command_Type;

    move-result-object v1

    invoke-virtual {p0, v1}, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$UiToCommand$Builder;->setCommand(Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$UiToCommand$Command_Type;)Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$UiToCommand$Builder;

    .line 6925
    :cond_1
    invoke-virtual {p1}, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$UiToCommand;->hasEvent()Z

    move-result v1

    if-eqz v1, :cond_2

    .line 6926
    invoke-virtual {p1}, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$UiToCommand;->getEvent()Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$ControlEvent;

    move-result-object v1

    invoke-virtual {p0, v1}, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$UiToCommand$Builder;->mergeEvent(Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$ControlEvent;)Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$UiToCommand$Builder;

    .line 6928
    :cond_2
    invoke-virtual {p1}, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$UiToCommand;->hasIsSuccess()Z

    move-result v1

    if-eqz v1, :cond_3

    .line 6929
    invoke-virtual {p1}, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$UiToCommand;->getIsSuccess()Z

    move-result v1

    invoke-virtual {p0, v1}, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$UiToCommand$Builder;->setIsSuccess(Z)Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$UiToCommand$Builder;

    .line 6931
    :cond_3
    iget-object v1, p0, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$UiToCommand$Builder;->varTableBuilder_:Lcom/google/protobuf/RepeatedFieldBuilder;

    if-nez v1, :cond_6

    .line 6932
    invoke-static {p1}, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$UiToCommand;->access$7700(Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$UiToCommand;)Ljava/util/List;

    move-result-object v0

    invoke-interface {v0}, Ljava/util/List;->isEmpty()Z

    move-result v0

    if-nez v0, :cond_4

    .line 6933
    iget-object v0, p0, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$UiToCommand$Builder;->varTable_:Ljava/util/List;

    invoke-interface {v0}, Ljava/util/List;->isEmpty()Z

    move-result v0

    if-eqz v0, :cond_5

    .line 6934
    invoke-static {p1}, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$UiToCommand;->access$7700(Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$UiToCommand;)Ljava/util/List;

    move-result-object v0

    iput-object v0, p0, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$UiToCommand$Builder;->varTable_:Ljava/util/List;

    .line 6935
    iget v0, p0, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$UiToCommand$Builder;->bitField0_:I

    and-int/lit8 v0, v0, -0x9

    iput v0, p0, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$UiToCommand$Builder;->bitField0_:I

    .line 6940
    :goto_1
    invoke-virtual {p0}, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$UiToCommand$Builder;->onChanged()V

    .line 6957
    :cond_4
    :goto_2
    invoke-virtual {p1}, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$UiToCommand;->getUnknownFields()Lcom/google/protobuf/UnknownFieldSet;

    move-result-object v0

    invoke-virtual {p0, v0}, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$UiToCommand$Builder;->mergeUnknownFields(Lcom/google/protobuf/UnknownFieldSet;)Lcom/google/protobuf/GeneratedMessage$Builder;

    goto :goto_0

    .line 6937
    :cond_5
    invoke-direct {p0}, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$UiToCommand$Builder;->ensureVarTableIsMutable()V

    .line 6938
    iget-object v0, p0, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$UiToCommand$Builder;->varTable_:Ljava/util/List;

    invoke-static {p1}, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$UiToCommand;->access$7700(Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$UiToCommand;)Ljava/util/List;

    move-result-object v1

    invoke-interface {v0, v1}, Ljava/util/List;->addAll(Ljava/util/Collection;)Z

    goto :goto_1

    .line 6943
    :cond_6
    invoke-static {p1}, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$UiToCommand;->access$7700(Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$UiToCommand;)Ljava/util/List;

    move-result-object v1

    invoke-interface {v1}, Ljava/util/List;->isEmpty()Z

    move-result v1

    if-nez v1, :cond_4

    .line 6944
    iget-object v1, p0, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$UiToCommand$Builder;->varTableBuilder_:Lcom/google/protobuf/RepeatedFieldBuilder;

    invoke-virtual {v1}, Lcom/google/protobuf/RepeatedFieldBuilder;->isEmpty()Z

    move-result v1

    if-eqz v1, :cond_8

    .line 6945
    iget-object v1, p0, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$UiToCommand$Builder;->varTableBuilder_:Lcom/google/protobuf/RepeatedFieldBuilder;

    invoke-virtual {v1}, Lcom/google/protobuf/RepeatedFieldBuilder;->dispose()V

    .line 6946
    iput-object v0, p0, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$UiToCommand$Builder;->varTableBuilder_:Lcom/google/protobuf/RepeatedFieldBuilder;

    .line 6947
    invoke-static {p1}, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$UiToCommand;->access$7700(Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$UiToCommand;)Ljava/util/List;

    move-result-object v1

    iput-object v1, p0, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$UiToCommand$Builder;->varTable_:Ljava/util/List;

    .line 6948
    iget v1, p0, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$UiToCommand$Builder;->bitField0_:I

    and-int/lit8 v1, v1, -0x9

    iput v1, p0, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$UiToCommand$Builder;->bitField0_:I

    .line 6950
    invoke-static {}, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$UiToCommand;->access$7900()Z

    move-result v1

    if-eqz v1, :cond_7

    .line 6951
    invoke-direct {p0}, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$UiToCommand$Builder;->getVarTableFieldBuilder()Lcom/google/protobuf/RepeatedFieldBuilder;

    move-result-object v0

    :cond_7
    iput-object v0, p0, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$UiToCommand$Builder;->varTableBuilder_:Lcom/google/protobuf/RepeatedFieldBuilder;

    goto :goto_2

    .line 6953
    :cond_8
    iget-object v0, p0, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$UiToCommand$Builder;->varTableBuilder_:Lcom/google/protobuf/RepeatedFieldBuilder;

    invoke-static {p1}, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$UiToCommand;->access$7700(Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$UiToCommand;)Ljava/util/List;

    move-result-object v1

    invoke-virtual {v0, v1}, Lcom/google/protobuf/RepeatedFieldBuilder;->addAllMessages(Ljava/lang/Iterable;)Lcom/google/protobuf/RepeatedFieldBuilder;

    goto :goto_2
.end method

.method public mergeFrom(Lcom/google/protobuf/CodedInputStream;Lcom/google/protobuf/ExtensionRegistryLite;)Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$UiToCommand$Builder;
    .locals 4
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljava/io/IOException;
        }
    .end annotation

    .prologue
    .line 6985
    const/4 v2, 0x0

    .line 6987
    :try_start_0
    sget-object v0, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$UiToCommand;->PARSER:Lcom/google/protobuf/Parser;

    invoke-interface {v0, p1, p2}, Lcom/google/protobuf/Parser;->parsePartialFrom(Lcom/google/protobuf/CodedInputStream;Lcom/google/protobuf/ExtensionRegistryLite;)Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$UiToCommand;
    :try_end_0
    .catch Lcom/google/protobuf/InvalidProtocolBufferException; {:try_start_0 .. :try_end_0} :catch_0
    .catchall {:try_start_0 .. :try_end_0} :catchall_1

    .line 6992
    if-eqz v0, :cond_0

    .line 6993
    invoke-virtual {p0, v0}, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$UiToCommand$Builder;->mergeFrom(Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$UiToCommand;)Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$UiToCommand$Builder;

    .line 6996
    :cond_0
    return-object p0

    .line 6988
    :catch_0
    move-exception v0

    move-object v1, v0

    .line 6989
    :try_start_1
    invoke-virtual {v1}, Lcom/google/protobuf/InvalidProtocolBufferException;->getUnfinishedMessage()Lcom/google/protobuf/MessageLite;

    move-result-object v0

    check-cast v0, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$UiToCommand;
    :try_end_1
    .catchall {:try_start_1 .. :try_end_1} :catchall_1

    .line 6990
    :try_start_2
    throw v1
    :try_end_2
    .catchall {:try_start_2 .. :try_end_2} :catchall_0

    .line 6992
    :catchall_0
    move-exception v1

    move-object v3, v1

    move-object v1, v0

    move-object v0, v3

    :goto_0
    if-eqz v1, :cond_1

    .line 6993
    invoke-virtual {p0, v1}, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$UiToCommand$Builder;->mergeFrom(Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$UiToCommand;)Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$UiToCommand$Builder;

    :cond_1
    throw v0

    .line 6992
    :catchall_1
    move-exception v0

    move-object v1, v2

    goto :goto_0
.end method

.method public mergeFrom(Lcom/google/protobuf/Message;)Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$UiToCommand$Builder;
    .locals 1

    .prologue
    .line 6912
    instance-of v0, p1, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$UiToCommand;

    if-eqz v0, :cond_0

    .line 6913
    check-cast p1, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$UiToCommand;

    invoke-virtual {p0, p1}, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$UiToCommand$Builder;->mergeFrom(Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$UiToCommand;)Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$UiToCommand$Builder;

    move-result-object p0

    .line 6916
    :goto_0
    return-object p0

    .line 6915
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
    .line 6800
    invoke-virtual {p0, p1, p2}, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$UiToCommand$Builder;->mergeFrom(Lcom/google/protobuf/CodedInputStream;Lcom/google/protobuf/ExtensionRegistryLite;)Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$UiToCommand$Builder;

    move-result-object v0

    return-object v0
.end method

.method public bridge synthetic mergeFrom(Lcom/google/protobuf/Message;)Lcom/google/protobuf/AbstractMessage$Builder;
    .locals 1

    .prologue
    .line 6800
    invoke-virtual {p0, p1}, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$UiToCommand$Builder;->mergeFrom(Lcom/google/protobuf/Message;)Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$UiToCommand$Builder;

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
    .line 6800
    invoke-virtual {p0, p1, p2}, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$UiToCommand$Builder;->mergeFrom(Lcom/google/protobuf/CodedInputStream;Lcom/google/protobuf/ExtensionRegistryLite;)Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$UiToCommand$Builder;

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
    .line 6800
    invoke-virtual {p0, p1, p2}, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$UiToCommand$Builder;->mergeFrom(Lcom/google/protobuf/CodedInputStream;Lcom/google/protobuf/ExtensionRegistryLite;)Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$UiToCommand$Builder;

    move-result-object v0

    return-object v0
.end method

.method public bridge synthetic mergeFrom(Lcom/google/protobuf/Message;)Lcom/google/protobuf/Message$Builder;
    .locals 1

    .prologue
    .line 6800
    invoke-virtual {p0, p1}, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$UiToCommand$Builder;->mergeFrom(Lcom/google/protobuf/Message;)Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$UiToCommand$Builder;

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
    .line 6800
    invoke-virtual {p0, p1, p2}, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$UiToCommand$Builder;->mergeFrom(Lcom/google/protobuf/CodedInputStream;Lcom/google/protobuf/ExtensionRegistryLite;)Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$UiToCommand$Builder;

    move-result-object v0

    return-object v0
.end method

.method public removeVarTable(I)Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$UiToCommand$Builder;
    .locals 1

    .prologue
    .line 7352
    iget-object v0, p0, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$UiToCommand$Builder;->varTableBuilder_:Lcom/google/protobuf/RepeatedFieldBuilder;

    if-nez v0, :cond_0

    .line 7353
    invoke-direct {p0}, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$UiToCommand$Builder;->ensureVarTableIsMutable()V

    .line 7354
    iget-object v0, p0, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$UiToCommand$Builder;->varTable_:Ljava/util/List;

    invoke-interface {v0, p1}, Ljava/util/List;->remove(I)Ljava/lang/Object;

    .line 7355
    invoke-virtual {p0}, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$UiToCommand$Builder;->onChanged()V

    .line 7359
    :goto_0
    return-object p0

    .line 7357
    :cond_0
    iget-object v0, p0, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$UiToCommand$Builder;->varTableBuilder_:Lcom/google/protobuf/RepeatedFieldBuilder;

    invoke-virtual {v0, p1}, Lcom/google/protobuf/RepeatedFieldBuilder;->remove(I)V

    goto :goto_0
.end method

.method public setCommand(Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$UiToCommand$Command_Type;)Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$UiToCommand$Builder;
    .locals 1

    .prologue
    .line 7018
    if-nez p1, :cond_0

    .line 7019
    new-instance v0, Ljava/lang/NullPointerException;

    invoke-direct {v0}, Ljava/lang/NullPointerException;-><init>()V

    throw v0

    .line 7021
    :cond_0
    iget v0, p0, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$UiToCommand$Builder;->bitField0_:I

    or-int/lit8 v0, v0, 0x1

    iput v0, p0, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$UiToCommand$Builder;->bitField0_:I

    .line 7022
    iput-object p1, p0, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$UiToCommand$Builder;->command_:Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$UiToCommand$Command_Type;

    .line 7023
    invoke-virtual {p0}, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$UiToCommand$Builder;->onChanged()V

    .line 7024
    return-object p0
.end method

.method public setEvent(Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$ControlEvent$Builder;)Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$UiToCommand$Builder;
    .locals 2

    .prologue
    .line 7077
    iget-object v0, p0, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$UiToCommand$Builder;->eventBuilder_:Lcom/google/protobuf/SingleFieldBuilder;

    if-nez v0, :cond_0

    .line 7078
    invoke-virtual {p1}, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$ControlEvent$Builder;->build()Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$ControlEvent;

    move-result-object v0

    iput-object v0, p0, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$UiToCommand$Builder;->event_:Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$ControlEvent;

    .line 7079
    invoke-virtual {p0}, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$UiToCommand$Builder;->onChanged()V

    .line 7083
    :goto_0
    iget v0, p0, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$UiToCommand$Builder;->bitField0_:I

    or-int/lit8 v0, v0, 0x2

    iput v0, p0, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$UiToCommand$Builder;->bitField0_:I

    .line 7084
    return-object p0

    .line 7081
    :cond_0
    iget-object v0, p0, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$UiToCommand$Builder;->eventBuilder_:Lcom/google/protobuf/SingleFieldBuilder;

    invoke-virtual {p1}, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$ControlEvent$Builder;->build()Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$ControlEvent;

    move-result-object v1

    invoke-virtual {v0, v1}, Lcom/google/protobuf/SingleFieldBuilder;->setMessage(Lcom/google/protobuf/GeneratedMessage;)Lcom/google/protobuf/SingleFieldBuilder;

    goto :goto_0
.end method

.method public setEvent(Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$ControlEvent;)Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$UiToCommand$Builder;
    .locals 1

    .prologue
    .line 7060
    iget-object v0, p0, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$UiToCommand$Builder;->eventBuilder_:Lcom/google/protobuf/SingleFieldBuilder;

    if-nez v0, :cond_1

    .line 7061
    if-nez p1, :cond_0

    .line 7062
    new-instance v0, Ljava/lang/NullPointerException;

    invoke-direct {v0}, Ljava/lang/NullPointerException;-><init>()V

    throw v0

    .line 7064
    :cond_0
    iput-object p1, p0, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$UiToCommand$Builder;->event_:Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$ControlEvent;

    .line 7065
    invoke-virtual {p0}, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$UiToCommand$Builder;->onChanged()V

    .line 7069
    :goto_0
    iget v0, p0, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$UiToCommand$Builder;->bitField0_:I

    or-int/lit8 v0, v0, 0x2

    iput v0, p0, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$UiToCommand$Builder;->bitField0_:I

    .line 7070
    return-object p0

    .line 7067
    :cond_1
    iget-object v0, p0, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$UiToCommand$Builder;->eventBuilder_:Lcom/google/protobuf/SingleFieldBuilder;

    invoke-virtual {v0, p1}, Lcom/google/protobuf/SingleFieldBuilder;->setMessage(Lcom/google/protobuf/GeneratedMessage;)Lcom/google/protobuf/SingleFieldBuilder;

    goto :goto_0
.end method

.method public setIsSuccess(Z)Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$UiToCommand$Builder;
    .locals 1

    .prologue
    .line 7171
    iget v0, p0, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$UiToCommand$Builder;->bitField0_:I

    or-int/lit8 v0, v0, 0x4

    iput v0, p0, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$UiToCommand$Builder;->bitField0_:I

    .line 7172
    iput-boolean p1, p0, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$UiToCommand$Builder;->isSuccess_:Z

    .line 7173
    invoke-virtual {p0}, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$UiToCommand$Builder;->onChanged()V

    .line 7174
    return-object p0
.end method

.method public setVarTable(ILcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$ControlVar$Builder;)Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$UiToCommand$Builder;
    .locals 2

    .prologue
    .line 7251
    iget-object v0, p0, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$UiToCommand$Builder;->varTableBuilder_:Lcom/google/protobuf/RepeatedFieldBuilder;

    if-nez v0, :cond_0

    .line 7252
    invoke-direct {p0}, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$UiToCommand$Builder;->ensureVarTableIsMutable()V

    .line 7253
    iget-object v0, p0, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$UiToCommand$Builder;->varTable_:Ljava/util/List;

    invoke-virtual {p2}, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$ControlVar$Builder;->build()Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$ControlVar;

    move-result-object v1

    invoke-interface {v0, p1, v1}, Ljava/util/List;->set(ILjava/lang/Object;)Ljava/lang/Object;

    .line 7254
    invoke-virtual {p0}, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$UiToCommand$Builder;->onChanged()V

    .line 7258
    :goto_0
    return-object p0

    .line 7256
    :cond_0
    iget-object v0, p0, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$UiToCommand$Builder;->varTableBuilder_:Lcom/google/protobuf/RepeatedFieldBuilder;

    invoke-virtual {p2}, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$ControlVar$Builder;->build()Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$ControlVar;

    move-result-object v1

    invoke-virtual {v0, p1, v1}, Lcom/google/protobuf/RepeatedFieldBuilder;->setMessage(ILcom/google/protobuf/GeneratedMessage;)Lcom/google/protobuf/RepeatedFieldBuilder;

    goto :goto_0
.end method

.method public setVarTable(ILcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$ControlVar;)Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$UiToCommand$Builder;
    .locals 1

    .prologue
    .line 7234
    iget-object v0, p0, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$UiToCommand$Builder;->varTableBuilder_:Lcom/google/protobuf/RepeatedFieldBuilder;

    if-nez v0, :cond_1

    .line 7235
    if-nez p2, :cond_0

    .line 7236
    new-instance v0, Ljava/lang/NullPointerException;

    invoke-direct {v0}, Ljava/lang/NullPointerException;-><init>()V

    throw v0

    .line 7238
    :cond_0
    invoke-direct {p0}, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$UiToCommand$Builder;->ensureVarTableIsMutable()V

    .line 7239
    iget-object v0, p0, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$UiToCommand$Builder;->varTable_:Ljava/util/List;

    invoke-interface {v0, p1, p2}, Ljava/util/List;->set(ILjava/lang/Object;)Ljava/lang/Object;

    .line 7240
    invoke-virtual {p0}, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$UiToCommand$Builder;->onChanged()V

    .line 7244
    :goto_0
    return-object p0

    .line 7242
    :cond_1
    iget-object v0, p0, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$UiToCommand$Builder;->varTableBuilder_:Lcom/google/protobuf/RepeatedFieldBuilder;

    invoke-virtual {v0, p1, p2}, Lcom/google/protobuf/RepeatedFieldBuilder;->setMessage(ILcom/google/protobuf/GeneratedMessage;)Lcom/google/protobuf/RepeatedFieldBuilder;

    goto :goto_0
.end method
