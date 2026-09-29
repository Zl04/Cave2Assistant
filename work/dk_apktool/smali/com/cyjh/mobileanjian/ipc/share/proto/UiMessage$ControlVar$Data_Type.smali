.class public final enum Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$ControlVar$Data_Type;
.super Ljava/lang/Enum;
.source "SourceFile"

# interfaces
.implements Lcom/google/protobuf/ProtocolMessageEnum;


# annotations
.annotation system Ldalvik/annotation/EnclosingClass;
    value = Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$ControlVar;
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x4019
    name = "Data_Type"
.end annotation

.annotation system Ldalvik/annotation/Signature;
    value = {
        "Ljava/lang/Enum",
        "<",
        "Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$ControlVar$Data_Type;",
        ">;",
        "Lcom/google/protobuf/ProtocolMessageEnum;"
    }
.end annotation


# static fields
.field private static final synthetic $VALUES:[Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$ControlVar$Data_Type;

.field public static final enum BOOL:Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$ControlVar$Data_Type;

.field public static final BOOL_VALUE:I = 0x1

.field public static final enum INT:Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$ControlVar$Data_Type;

.field public static final INT_VALUE:I = 0x2

.field public static final enum STRING:Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$ControlVar$Data_Type;

.field public static final STRING_VALUE:I = 0x3

.field private static final VALUES:[Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$ControlVar$Data_Type;

.field private static internalValueMap:Lcom/google/protobuf/Internal$EnumLiteMap;
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "Lcom/google/protobuf/Internal$EnumLiteMap",
            "<",
            "Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$ControlVar$Data_Type;",
            ">;"
        }
    .end annotation
.end field


# instance fields
.field private final index:I

.field private final value:I


# direct methods
.method static constructor <clinit>()V
    .locals 6

    .prologue
    const/4 v5, 0x3

    const/4 v4, 0x0

    const/4 v3, 0x2

    const/4 v2, 0x1

    .line 5497
    new-instance v0, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$ControlVar$Data_Type;

    const-string v1, "BOOL"

    invoke-direct {v0, v1, v4, v4, v2}, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$ControlVar$Data_Type;-><init>(Ljava/lang/String;III)V

    sput-object v0, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$ControlVar$Data_Type;->BOOL:Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$ControlVar$Data_Type;

    .line 5501
    new-instance v0, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$ControlVar$Data_Type;

    const-string v1, "INT"

    invoke-direct {v0, v1, v2, v2, v3}, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$ControlVar$Data_Type;-><init>(Ljava/lang/String;III)V

    sput-object v0, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$ControlVar$Data_Type;->INT:Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$ControlVar$Data_Type;

    .line 5505
    new-instance v0, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$ControlVar$Data_Type;

    const-string v1, "STRING"

    invoke-direct {v0, v1, v3, v3, v5}, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$ControlVar$Data_Type;-><init>(Ljava/lang/String;III)V

    sput-object v0, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$ControlVar$Data_Type;->STRING:Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$ControlVar$Data_Type;

    .line 5492
    new-array v0, v5, [Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$ControlVar$Data_Type;

    sget-object v1, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$ControlVar$Data_Type;->BOOL:Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$ControlVar$Data_Type;

    aput-object v1, v0, v4

    sget-object v1, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$ControlVar$Data_Type;->INT:Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$ControlVar$Data_Type;

    aput-object v1, v0, v2

    sget-object v1, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$ControlVar$Data_Type;->STRING:Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$ControlVar$Data_Type;

    aput-object v1, v0, v3

    sput-object v0, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$ControlVar$Data_Type;->$VALUES:[Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$ControlVar$Data_Type;

    .line 5538
    new-instance v0, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$ControlVar$Data_Type$1;

    invoke-direct {v0}, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$ControlVar$Data_Type$1;-><init>()V

    sput-object v0, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$ControlVar$Data_Type;->internalValueMap:Lcom/google/protobuf/Internal$EnumLiteMap;

    .line 5558
    invoke-static {}, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$ControlVar$Data_Type;->values()[Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$ControlVar$Data_Type;

    move-result-object v0

    sput-object v0, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$ControlVar$Data_Type;->VALUES:[Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$ControlVar$Data_Type;

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
    .line 5572
    invoke-direct {p0, p1, p2}, Ljava/lang/Enum;-><init>(Ljava/lang/String;I)V

    .line 5573
    iput p3, p0, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$ControlVar$Data_Type;->index:I

    .line 5574
    iput p4, p0, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$ControlVar$Data_Type;->value:I

    .line 5575
    return-void
.end method

.method public static final getDescriptor()Lcom/google/protobuf/Descriptors$EnumDescriptor;
    .locals 2

    .prologue
    .line 5555
    invoke-static {}, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$ControlVar;->getDescriptor()Lcom/google/protobuf/Descriptors$Descriptor;

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
            "Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$ControlVar$Data_Type;",
            ">;"
        }
    .end annotation

    .prologue
    .line 5535
    sget-object v0, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$ControlVar$Data_Type;->internalValueMap:Lcom/google/protobuf/Internal$EnumLiteMap;

    return-object v0
.end method

.method public static valueOf(I)Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$ControlVar$Data_Type;
    .locals 1

    .prologue
    .line 5525
    packed-switch p0, :pswitch_data_0

    .line 5529
    const/4 v0, 0x0

    :goto_0
    return-object v0

    .line 5526
    :pswitch_0
    sget-object v0, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$ControlVar$Data_Type;->BOOL:Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$ControlVar$Data_Type;

    goto :goto_0

    .line 5527
    :pswitch_1
    sget-object v0, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$ControlVar$Data_Type;->INT:Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$ControlVar$Data_Type;

    goto :goto_0

    .line 5528
    :pswitch_2
    sget-object v0, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$ControlVar$Data_Type;->STRING:Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$ControlVar$Data_Type;

    goto :goto_0

    .line 5525
    :pswitch_data_0
    .packed-switch 0x1
        :pswitch_0
        :pswitch_1
        :pswitch_2
    .end packed-switch
.end method

.method public static valueOf(Lcom/google/protobuf/Descriptors$EnumValueDescriptor;)Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$ControlVar$Data_Type;
    .locals 2

    .prologue
    .line 5562
    invoke-virtual {p0}, Lcom/google/protobuf/Descriptors$EnumValueDescriptor;->getType()Lcom/google/protobuf/Descriptors$EnumDescriptor;

    move-result-object v0

    invoke-static {}, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$ControlVar$Data_Type;->getDescriptor()Lcom/google/protobuf/Descriptors$EnumDescriptor;

    move-result-object v1

    if-eq v0, v1, :cond_0

    .line 5563
    new-instance v0, Ljava/lang/IllegalArgumentException;

    const-string v1, "EnumValueDescriptor is not for this type."

    invoke-direct {v0, v1}, Ljava/lang/IllegalArgumentException;-><init>(Ljava/lang/String;)V

    throw v0

    .line 5566
    :cond_0
    sget-object v0, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$ControlVar$Data_Type;->VALUES:[Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$ControlVar$Data_Type;

    invoke-virtual {p0}, Lcom/google/protobuf/Descriptors$EnumValueDescriptor;->getIndex()I

    move-result v1

    aget-object v0, v0, v1

    return-object v0
.end method

.method public static valueOf(Ljava/lang/String;)Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$ControlVar$Data_Type;
    .locals 1

    .prologue
    .line 5492
    const-class v0, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$ControlVar$Data_Type;

    invoke-static {v0, p0}, Ljava/lang/Enum;->valueOf(Ljava/lang/Class;Ljava/lang/String;)Ljava/lang/Enum;

    move-result-object v0

    check-cast v0, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$ControlVar$Data_Type;

    return-object v0
.end method

.method public static values()[Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$ControlVar$Data_Type;
    .locals 1

    .prologue
    .line 5492
    sget-object v0, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$ControlVar$Data_Type;->$VALUES:[Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$ControlVar$Data_Type;

    invoke-virtual {v0}, [Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$ControlVar$Data_Type;->clone()Ljava/lang/Object;

    move-result-object v0

    check-cast v0, [Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$ControlVar$Data_Type;

    return-object v0
.end method


# virtual methods
.method public final getDescriptorForType()Lcom/google/protobuf/Descriptors$EnumDescriptor;
    .locals 1

    .prologue
    .line 5551
    invoke-static {}, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$ControlVar$Data_Type;->getDescriptor()Lcom/google/protobuf/Descriptors$EnumDescriptor;

    move-result-object v0

    return-object v0
.end method

.method public final getNumber()I
    .locals 1

    .prologue
    .line 5522
    iget v0, p0, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$ControlVar$Data_Type;->value:I

    return v0
.end method

.method public final getValueDescriptor()Lcom/google/protobuf/Descriptors$EnumValueDescriptor;
    .locals 2

    .prologue
    .line 5547
    invoke-static {}, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$ControlVar$Data_Type;->getDescriptor()Lcom/google/protobuf/Descriptors$EnumDescriptor;

    move-result-object v0

    invoke-virtual {v0}, Lcom/google/protobuf/Descriptors$EnumDescriptor;->getValues()Ljava/util/List;

    move-result-object v0

    iget v1, p0, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$ControlVar$Data_Type;->index:I

    invoke-interface {v0, v1}, Ljava/util/List;->get(I)Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Lcom/google/protobuf/Descriptors$EnumValueDescriptor;

    return-object v0
.end method
