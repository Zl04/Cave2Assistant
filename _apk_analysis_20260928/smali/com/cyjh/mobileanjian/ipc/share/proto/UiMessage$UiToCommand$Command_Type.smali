.class public final enum Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$UiToCommand$Command_Type;
.super Ljava/lang/Enum;
.source "SourceFile"

# interfaces
.implements Lcom/google/protobuf/ProtocolMessageEnum;


# annotations
.annotation system Ldalvik/annotation/EnclosingClass;
    value = Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$UiToCommand;
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x4019
    name = "Command_Type"
.end annotation

.annotation system Ldalvik/annotation/Signature;
    value = {
        "Ljava/lang/Enum",
        "<",
        "Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$UiToCommand$Command_Type;",
        ">;",
        "Lcom/google/protobuf/ProtocolMessageEnum;"
    }
.end annotation


# static fields
.field private static final synthetic $VALUES:[Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$UiToCommand$Command_Type;

.field public static final enum EVENT:Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$UiToCommand$Command_Type;

.field public static final EVENT_VALUE:I = 0x1

.field public static final enum RSP_MSG:Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$UiToCommand$Command_Type;

.field public static final RSP_MSG_VALUE:I = 0x2

.field private static final VALUES:[Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$UiToCommand$Command_Type;

.field private static internalValueMap:Lcom/google/protobuf/Internal$EnumLiteMap;
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "Lcom/google/protobuf/Internal$EnumLiteMap",
            "<",
            "Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$UiToCommand$Command_Type;",
            ">;"
        }
    .end annotation
.end field


# instance fields
.field private final index:I

.field private final value:I


# direct methods
.method static constructor <clinit>()V
    .locals 5

    .prologue
    const/4 v4, 0x2

    const/4 v3, 0x0

    const/4 v2, 0x1

    .line 6483
    new-instance v0, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$UiToCommand$Command_Type;

    const-string v1, "EVENT"

    invoke-direct {v0, v1, v3, v3, v2}, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$UiToCommand$Command_Type;-><init>(Ljava/lang/String;III)V

    sput-object v0, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$UiToCommand$Command_Type;->EVENT:Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$UiToCommand$Command_Type;

    .line 6487
    new-instance v0, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$UiToCommand$Command_Type;

    const-string v1, "RSP_MSG"

    invoke-direct {v0, v1, v2, v2, v4}, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$UiToCommand$Command_Type;-><init>(Ljava/lang/String;III)V

    sput-object v0, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$UiToCommand$Command_Type;->RSP_MSG:Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$UiToCommand$Command_Type;

    .line 6478
    new-array v0, v4, [Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$UiToCommand$Command_Type;

    sget-object v1, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$UiToCommand$Command_Type;->EVENT:Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$UiToCommand$Command_Type;

    aput-object v1, v0, v3

    sget-object v1, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$UiToCommand$Command_Type;->RSP_MSG:Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$UiToCommand$Command_Type;

    aput-object v1, v0, v2

    sput-object v0, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$UiToCommand$Command_Type;->$VALUES:[Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$UiToCommand$Command_Type;

    .line 6515
    new-instance v0, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$UiToCommand$Command_Type$1;

    invoke-direct {v0}, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$UiToCommand$Command_Type$1;-><init>()V

    sput-object v0, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$UiToCommand$Command_Type;->internalValueMap:Lcom/google/protobuf/Internal$EnumLiteMap;

    .line 6535
    invoke-static {}, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$UiToCommand$Command_Type;->values()[Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$UiToCommand$Command_Type;

    move-result-object v0

    sput-object v0, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$UiToCommand$Command_Type;->VALUES:[Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$UiToCommand$Command_Type;

    return-void
.end method

.method private constructor <init>(Ljava/lang/String;III)V
    .locals 0
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "(II)V"
        }
    .end annotation

    .prologue
    .line 6549
    invoke-direct {p0, p1, p2}, Ljava/lang/Enum;-><init>(Ljava/lang/String;I)V

    .line 6550
    iput p3, p0, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$UiToCommand$Command_Type;->index:I

    .line 6551
    iput p4, p0, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$UiToCommand$Command_Type;->value:I

    .line 6552
    return-void
.end method

.method public static final getDescriptor()Lcom/google/protobuf/Descriptors$EnumDescriptor;
    .locals 2

    .prologue
    .line 6532
    invoke-static {}, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$UiToCommand;->getDescriptor()Lcom/google/protobuf/Descriptors$Descriptor;

    move-result-object v0

    invoke-virtual {v0}, Lcom/google/protobuf/Descriptors$Descriptor;->getEnumTypes()Ljava/util/List;

    move-result-object v0

    const/4 v1, 0x0

    invoke-interface {v0, v1}, Ljava/util/List;->get(I)Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Lcom/google/protobuf/Descriptors$EnumDescriptor;

    return-object v0
.end method

.method public static internalGetValueMap()Lcom/google/protobuf/Internal$EnumLiteMap;
    .locals 1
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "()",
            "Lcom/google/protobuf/Internal$EnumLiteMap",
            "<",
            "Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$UiToCommand$Command_Type;",
            ">;"
        }
    .end annotation

    .prologue
    .line 6512
    sget-object v0, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$UiToCommand$Command_Type;->internalValueMap:Lcom/google/protobuf/Internal$EnumLiteMap;

    return-object v0
.end method

.method public static valueOf(I)Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$UiToCommand$Command_Type;
    .locals 1

    .prologue
    .line 6503
    packed-switch p0, :pswitch_data_0

    .line 6506
    const/4 v0, 0x0

    :goto_0
    return-object v0

    .line 6504
    :pswitch_0
    sget-object v0, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$UiToCommand$Command_Type;->EVENT:Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$UiToCommand$Command_Type;

    goto :goto_0

    .line 6505
    :pswitch_1
    sget-object v0, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$UiToCommand$Command_Type;->RSP_MSG:Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$UiToCommand$Command_Type;

    goto :goto_0

    .line 6503
    nop

    :pswitch_data_0
    .packed-switch 0x1
        :pswitch_0
        :pswitch_1
    .end packed-switch
.end method

.method public static valueOf(Lcom/google/protobuf/Descriptors$EnumValueDescriptor;)Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$UiToCommand$Command_Type;
    .locals 2

    .prologue
    .line 6539
    invoke-virtual {p0}, Lcom/google/protobuf/Descriptors$EnumValueDescriptor;->getType()Lcom/google/protobuf/Descriptors$EnumDescriptor;

    move-result-object v0

    invoke-static {}, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$UiToCommand$Command_Type;->getDescriptor()Lcom/google/protobuf/Descriptors$EnumDescriptor;

    move-result-object v1

    if-eq v0, v1, :cond_0

    .line 6540
    new-instance v0, Ljava/lang/IllegalArgumentException;

    const-string v1, "EnumValueDescriptor is not for this type."

    invoke-direct {v0, v1}, Ljava/lang/IllegalArgumentException;-><init>(Ljava/lang/String;)V

    throw v0

    .line 6543
    :cond_0
    sget-object v0, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$UiToCommand$Command_Type;->VALUES:[Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$UiToCommand$Command_Type;

    invoke-virtual {p0}, Lcom/google/protobuf/Descriptors$EnumValueDescriptor;->getIndex()I

    move-result v1

    aget-object v0, v0, v1

    return-object v0
.end method

.method public static valueOf(Ljava/lang/String;)Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$UiToCommand$Command_Type;
    .locals 1

    .prologue
    .line 6478
    const-class v0, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$UiToCommand$Command_Type;

    invoke-static {v0, p0}, Ljava/lang/Enum;->valueOf(Ljava/lang/Class;Ljava/lang/String;)Ljava/lang/Enum;

    move-result-object v0

    check-cast v0, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$UiToCommand$Command_Type;

    return-object v0
.end method

.method public static values()[Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$UiToCommand$Command_Type;
    .locals 1

    .prologue
    .line 6478
    sget-object v0, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$UiToCommand$Command_Type;->$VALUES:[Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$UiToCommand$Command_Type;

    invoke-virtual {v0}, [Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$UiToCommand$Command_Type;->clone()Ljava/lang/Object;

    move-result-object v0

    check-cast v0, [Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$UiToCommand$Command_Type;

    return-object v0
.end method


# virtual methods
.method public final getDescriptorForType()Lcom/google/protobuf/Descriptors$EnumDescriptor;
    .locals 1

    .prologue
    .line 6528
    invoke-static {}, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$UiToCommand$Command_Type;->getDescriptor()Lcom/google/protobuf/Descriptors$EnumDescriptor;

    move-result-object v0

    return-object v0
.end method

.method public final getNumber()I
    .locals 1

    .prologue
    .line 6500
    iget v0, p0, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$UiToCommand$Command_Type;->value:I

    return v0
.end method

.method public final getValueDescriptor()Lcom/google/protobuf/Descriptors$EnumValueDescriptor;
    .locals 2

    .prologue
    .line 6524
    invoke-static {}, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$UiToCommand$Command_Type;->getDescriptor()Lcom/google/protobuf/Descriptors$EnumDescriptor;

    move-result-object v0

    invoke-virtual {v0}, Lcom/google/protobuf/Descriptors$EnumDescriptor;->getValues()Ljava/util/List;

    move-result-object v0

    iget v1, p0, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$UiToCommand$Command_Type;->index:I

    invoke-interface {v0, v1}, Ljava/util/List;->get(I)Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Lcom/google/protobuf/Descriptors$EnumValueDescriptor;

    return-object v0
.end method
