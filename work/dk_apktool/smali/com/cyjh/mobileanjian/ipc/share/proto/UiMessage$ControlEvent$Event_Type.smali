.class public final enum Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$ControlEvent$Event_Type;
.super Ljava/lang/Enum;
.source "SourceFile"

# interfaces
.implements Lcom/google/protobuf/ProtocolMessageEnum;


# annotations
.annotation system Ldalvik/annotation/EnclosingClass;
    value = Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$ControlEvent;
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x4019
    name = "Event_Type"
.end annotation

.annotation system Ldalvik/annotation/Signature;
    value = {
        "Ljava/lang/Enum",
        "<",
        "Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$ControlEvent$Event_Type;",
        ">;",
        "Lcom/google/protobuf/ProtocolMessageEnum;"
    }
.end annotation


# static fields
.field private static final synthetic $VALUES:[Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$ControlEvent$Event_Type;

.field public static final enum ON_CHANGE:Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$ControlEvent$Event_Type;

.field public static final ON_CHANGE_VALUE:I = 0x1

.field public static final enum ON_CLICK:Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$ControlEvent$Event_Type;

.field public static final ON_CLICK_VALUE:I = 0x2

.field public static final enum ON_CLOSE_CONTINUE:Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$ControlEvent$Event_Type;

.field public static final ON_CLOSE_CONTINUE_VALUE:I = 0x4

.field public static final enum ON_CLOSE_EXIT:Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$ControlEvent$Event_Type;

.field public static final ON_CLOSE_EXIT_VALUE:I = 0x5

.field public static final enum ON_SHOW:Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$ControlEvent$Event_Type;

.field public static final ON_SHOW_VALUE:I = 0x3

.field private static final VALUES:[Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$ControlEvent$Event_Type;

.field private static internalValueMap:Lcom/google/protobuf/Internal$EnumLiteMap;
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "Lcom/google/protobuf/Internal$EnumLiteMap",
            "<",
            "Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$ControlEvent$Event_Type;",
            ">;"
        }
    .end annotation
.end field


# instance fields
.field private final index:I

.field private final value:I


# direct methods
.method static constructor <clinit>()V
    .locals 8

    .prologue
    const/4 v7, 0x0

    const/4 v6, 0x4

    const/4 v5, 0x3

    const/4 v4, 0x2

    const/4 v3, 0x1

    .line 4453
    new-instance v0, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$ControlEvent$Event_Type;

    const-string v1, "ON_CHANGE"

    invoke-direct {v0, v1, v7, v7, v3}, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$ControlEvent$Event_Type;-><init>(Ljava/lang/String;III)V

    sput-object v0, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$ControlEvent$Event_Type;->ON_CHANGE:Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$ControlEvent$Event_Type;

    .line 4457
    new-instance v0, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$ControlEvent$Event_Type;

    const-string v1, "ON_CLICK"

    invoke-direct {v0, v1, v3, v3, v4}, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$ControlEvent$Event_Type;-><init>(Ljava/lang/String;III)V

    sput-object v0, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$ControlEvent$Event_Type;->ON_CLICK:Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$ControlEvent$Event_Type;

    .line 4461
    new-instance v0, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$ControlEvent$Event_Type;

    const-string v1, "ON_SHOW"

    invoke-direct {v0, v1, v4, v4, v5}, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$ControlEvent$Event_Type;-><init>(Ljava/lang/String;III)V

    sput-object v0, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$ControlEvent$Event_Type;->ON_SHOW:Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$ControlEvent$Event_Type;

    .line 4465
    new-instance v0, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$ControlEvent$Event_Type;

    const-string v1, "ON_CLOSE_CONTINUE"

    invoke-direct {v0, v1, v5, v5, v6}, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$ControlEvent$Event_Type;-><init>(Ljava/lang/String;III)V

    sput-object v0, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$ControlEvent$Event_Type;->ON_CLOSE_CONTINUE:Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$ControlEvent$Event_Type;

    .line 4469
    new-instance v0, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$ControlEvent$Event_Type;

    const-string v1, "ON_CLOSE_EXIT"

    const/4 v2, 0x5

    invoke-direct {v0, v1, v6, v6, v2}, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$ControlEvent$Event_Type;-><init>(Ljava/lang/String;III)V

    sput-object v0, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$ControlEvent$Event_Type;->ON_CLOSE_EXIT:Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$ControlEvent$Event_Type;

    .line 4448
    const/4 v0, 0x5

    new-array v0, v0, [Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$ControlEvent$Event_Type;

    sget-object v1, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$ControlEvent$Event_Type;->ON_CHANGE:Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$ControlEvent$Event_Type;

    aput-object v1, v0, v7

    sget-object v1, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$ControlEvent$Event_Type;->ON_CLICK:Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$ControlEvent$Event_Type;

    aput-object v1, v0, v3

    sget-object v1, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$ControlEvent$Event_Type;->ON_SHOW:Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$ControlEvent$Event_Type;

    aput-object v1, v0, v4

    sget-object v1, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$ControlEvent$Event_Type;->ON_CLOSE_CONTINUE:Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$ControlEvent$Event_Type;

    aput-object v1, v0, v5

    sget-object v1, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$ControlEvent$Event_Type;->ON_CLOSE_EXIT:Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$ControlEvent$Event_Type;

    aput-object v1, v0, v6

    sput-object v0, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$ControlEvent$Event_Type;->$VALUES:[Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$ControlEvent$Event_Type;

    .line 4512
    new-instance v0, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$ControlEvent$Event_Type$1;

    invoke-direct {v0}, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$ControlEvent$Event_Type$1;-><init>()V

    sput-object v0, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$ControlEvent$Event_Type;->internalValueMap:Lcom/google/protobuf/Internal$EnumLiteMap;

    .line 4532
    invoke-static {}, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$ControlEvent$Event_Type;->values()[Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$ControlEvent$Event_Type;

    move-result-object v0

    sput-object v0, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$ControlEvent$Event_Type;->VALUES:[Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$ControlEvent$Event_Type;

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
    .line 4546
    invoke-direct {p0, p1, p2}, Ljava/lang/Enum;-><init>(Ljava/lang/String;I)V

    .line 4547
    iput p3, p0, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$ControlEvent$Event_Type;->index:I

    .line 4548
    iput p4, p0, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$ControlEvent$Event_Type;->value:I

    .line 4549
    return-void
.end method

.method public static final getDescriptor()Lcom/google/protobuf/Descriptors$EnumDescriptor;
    .locals 2

    .prologue
    .line 4529
    invoke-static {}, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$ControlEvent;->getDescriptor()Lcom/google/protobuf/Descriptors$Descriptor;

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
            "Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$ControlEvent$Event_Type;",
            ">;"
        }
    .end annotation

    .prologue
    .line 4509
    sget-object v0, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$ControlEvent$Event_Type;->internalValueMap:Lcom/google/protobuf/Internal$EnumLiteMap;

    return-object v0
.end method

.method public static valueOf(I)Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$ControlEvent$Event_Type;
    .locals 1

    .prologue
    .line 4497
    packed-switch p0, :pswitch_data_0

    .line 4503
    const/4 v0, 0x0

    :goto_0
    return-object v0

    .line 4498
    :pswitch_0
    sget-object v0, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$ControlEvent$Event_Type;->ON_CHANGE:Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$ControlEvent$Event_Type;

    goto :goto_0

    .line 4499
    :pswitch_1
    sget-object v0, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$ControlEvent$Event_Type;->ON_CLICK:Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$ControlEvent$Event_Type;

    goto :goto_0

    .line 4500
    :pswitch_2
    sget-object v0, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$ControlEvent$Event_Type;->ON_SHOW:Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$ControlEvent$Event_Type;

    goto :goto_0

    .line 4501
    :pswitch_3
    sget-object v0, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$ControlEvent$Event_Type;->ON_CLOSE_CONTINUE:Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$ControlEvent$Event_Type;

    goto :goto_0

    .line 4502
    :pswitch_4
    sget-object v0, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$ControlEvent$Event_Type;->ON_CLOSE_EXIT:Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$ControlEvent$Event_Type;

    goto :goto_0

    .line 4497
    :pswitch_data_0
    .packed-switch 0x1
        :pswitch_0
        :pswitch_1
        :pswitch_2
        :pswitch_3
        :pswitch_4
    .end packed-switch
.end method

.method public static valueOf(Lcom/google/protobuf/Descriptors$EnumValueDescriptor;)Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$ControlEvent$Event_Type;
    .locals 2

    .prologue
    .line 4536
    invoke-virtual {p0}, Lcom/google/protobuf/Descriptors$EnumValueDescriptor;->getType()Lcom/google/protobuf/Descriptors$EnumDescriptor;

    move-result-object v0

    invoke-static {}, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$ControlEvent$Event_Type;->getDescriptor()Lcom/google/protobuf/Descriptors$EnumDescriptor;

    move-result-object v1

    if-eq v0, v1, :cond_0

    .line 4537
    new-instance v0, Ljava/lang/IllegalArgumentException;

    const-string v1, "EnumValueDescriptor is not for this type."

    invoke-direct {v0, v1}, Ljava/lang/IllegalArgumentException;-><init>(Ljava/lang/String;)V

    throw v0

    .line 4540
    :cond_0
    sget-object v0, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$ControlEvent$Event_Type;->VALUES:[Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$ControlEvent$Event_Type;

    invoke-virtual {p0}, Lcom/google/protobuf/Descriptors$EnumValueDescriptor;->getIndex()I

    move-result v1

    aget-object v0, v0, v1

    return-object v0
.end method

.method public static valueOf(Ljava/lang/String;)Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$ControlEvent$Event_Type;
    .locals 1

    .prologue
    .line 4448
    const-class v0, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$ControlEvent$Event_Type;

    invoke-static {v0, p0}, Ljava/lang/Enum;->valueOf(Ljava/lang/Class;Ljava/lang/String;)Ljava/lang/Enum;

    move-result-object v0

    check-cast v0, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$ControlEvent$Event_Type;

    return-object v0
.end method

.method public static values()[Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$ControlEvent$Event_Type;
    .locals 1

    .prologue
    .line 4448
    sget-object v0, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$ControlEvent$Event_Type;->$VALUES:[Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$ControlEvent$Event_Type;

    invoke-virtual {v0}, [Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$ControlEvent$Event_Type;->clone()Ljava/lang/Object;

    move-result-object v0

    check-cast v0, [Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$ControlEvent$Event_Type;

    return-object v0
.end method


# virtual methods
.method public final getDescriptorForType()Lcom/google/protobuf/Descriptors$EnumDescriptor;
    .locals 1

    .prologue
    .line 4525
    invoke-static {}, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$ControlEvent$Event_Type;->getDescriptor()Lcom/google/protobuf/Descriptors$EnumDescriptor;

    move-result-object v0

    return-object v0
.end method

.method public final getNumber()I
    .locals 1

    .prologue
    .line 4494
    iget v0, p0, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$ControlEvent$Event_Type;->value:I

    return v0
.end method

.method public final getValueDescriptor()Lcom/google/protobuf/Descriptors$EnumValueDescriptor;
    .locals 2

    .prologue
    .line 4521
    invoke-static {}, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$ControlEvent$Event_Type;->getDescriptor()Lcom/google/protobuf/Descriptors$EnumDescriptor;

    move-result-object v0

    invoke-virtual {v0}, Lcom/google/protobuf/Descriptors$EnumDescriptor;->getValues()Ljava/util/List;

    move-result-object v0

    iget v1, p0, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$ControlEvent$Event_Type;->index:I

    invoke-interface {v0, v1}, Ljava/util/List;->get(I)Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Lcom/google/protobuf/Descriptors$EnumValueDescriptor;

    return-object v0
.end method
