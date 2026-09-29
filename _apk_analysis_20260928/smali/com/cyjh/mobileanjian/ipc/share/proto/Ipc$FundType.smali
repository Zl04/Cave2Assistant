.class public final enum Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$FundType;
.super Ljava/lang/Enum;
.source "SourceFile"

# interfaces
.implements Lcom/google/protobuf/ProtocolMessageEnum;


# annotations
.annotation system Ldalvik/annotation/EnclosingClass;
    value = Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc;
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x4019
    name = "FundType"
.end annotation

.annotation system Ldalvik/annotation/Signature;
    value = {
        "Ljava/lang/Enum",
        "<",
        "Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$FundType;",
        ">;",
        "Lcom/google/protobuf/ProtocolMessageEnum;"
    }
.end annotation


# static fields
.field private static final synthetic $VALUES:[Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$FundType;

.field public static final enum BOOLEAN:Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$FundType;

.field public static final BOOLEAN_VALUE:I = 0x2

.field public static final enum DOUBLE:Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$FundType;

.field public static final DOUBLE_VALUE:I = 0x6

.field public static final enum FLOAT:Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$FundType;

.field public static final FLOAT_VALUE:I = 0x5

.field public static final enum INT:Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$FundType;

.field public static final INT_VALUE:I = 0x3

.field public static final enum LONG:Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$FundType;

.field public static final LONG_VALUE:I = 0x4

.field public static final enum STRING:Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$FundType;

.field public static final STRING_VALUE:I = 0x7

.field private static final VALUES:[Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$FundType;

.field public static final enum VOID:Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$FundType;

.field public static final VOID_VALUE:I = 0x1

.field private static internalValueMap:Lcom/google/protobuf/Internal$EnumLiteMap;
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "Lcom/google/protobuf/Internal$EnumLiteMap",
            "<",
            "Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$FundType;",
            ">;"
        }
    .end annotation
.end field


# instance fields
.field private final index:I

.field private final value:I


# direct methods
.method static constructor <clinit>()V
    .locals 10

    .prologue
    const/4 v9, 0x5

    const/4 v8, 0x4

    const/4 v7, 0x3

    const/4 v6, 0x2

    const/4 v5, 0x1

    .line 19
    new-instance v0, Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$FundType;

    const-string v1, "VOID"

    const/4 v2, 0x0

    const/4 v3, 0x0

    invoke-direct {v0, v1, v2, v3, v5}, Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$FundType;-><init>(Ljava/lang/String;III)V

    sput-object v0, Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$FundType;->VOID:Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$FundType;

    .line 23
    new-instance v0, Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$FundType;

    const-string v1, "BOOLEAN"

    invoke-direct {v0, v1, v5, v5, v6}, Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$FundType;-><init>(Ljava/lang/String;III)V

    sput-object v0, Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$FundType;->BOOLEAN:Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$FundType;

    .line 27
    new-instance v0, Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$FundType;

    const-string v1, "INT"

    invoke-direct {v0, v1, v6, v6, v7}, Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$FundType;-><init>(Ljava/lang/String;III)V

    sput-object v0, Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$FundType;->INT:Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$FundType;

    .line 31
    new-instance v0, Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$FundType;

    const-string v1, "LONG"

    invoke-direct {v0, v1, v7, v7, v8}, Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$FundType;-><init>(Ljava/lang/String;III)V

    sput-object v0, Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$FundType;->LONG:Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$FundType;

    .line 35
    new-instance v0, Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$FundType;

    const-string v1, "FLOAT"

    invoke-direct {v0, v1, v8, v8, v9}, Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$FundType;-><init>(Ljava/lang/String;III)V

    sput-object v0, Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$FundType;->FLOAT:Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$FundType;

    .line 39
    new-instance v0, Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$FundType;

    const-string v1, "DOUBLE"

    const/4 v2, 0x6

    invoke-direct {v0, v1, v9, v9, v2}, Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$FundType;-><init>(Ljava/lang/String;III)V

    sput-object v0, Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$FundType;->DOUBLE:Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$FundType;

    .line 43
    new-instance v0, Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$FundType;

    const-string v1, "STRING"

    const/4 v2, 0x6

    const/4 v3, 0x6

    const/4 v4, 0x7

    invoke-direct {v0, v1, v2, v3, v4}, Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$FundType;-><init>(Ljava/lang/String;III)V

    sput-object v0, Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$FundType;->STRING:Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$FundType;

    .line 14
    const/4 v0, 0x7

    new-array v0, v0, [Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$FundType;

    const/4 v1, 0x0

    sget-object v2, Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$FundType;->VOID:Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$FundType;

    aput-object v2, v0, v1

    sget-object v1, Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$FundType;->BOOLEAN:Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$FundType;

    aput-object v1, v0, v5

    sget-object v1, Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$FundType;->INT:Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$FundType;

    aput-object v1, v0, v6

    sget-object v1, Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$FundType;->LONG:Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$FundType;

    aput-object v1, v0, v7

    sget-object v1, Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$FundType;->FLOAT:Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$FundType;

    aput-object v1, v0, v8

    sget-object v1, Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$FundType;->DOUBLE:Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$FundType;

    aput-object v1, v0, v9

    const/4 v1, 0x6

    sget-object v2, Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$FundType;->STRING:Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$FundType;

    aput-object v2, v0, v1

    sput-object v0, Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$FundType;->$VALUES:[Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$FundType;

    .line 96
    new-instance v0, Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$FundType$1;

    invoke-direct {v0}, Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$FundType$1;-><init>()V

    sput-object v0, Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$FundType;->internalValueMap:Lcom/google/protobuf/Internal$EnumLiteMap;

    .line 116
    invoke-static {}, Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$FundType;->values()[Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$FundType;

    move-result-object v0

    sput-object v0, Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$FundType;->VALUES:[Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$FundType;

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
    .line 130
    invoke-direct {p0, p1, p2}, Ljava/lang/Enum;-><init>(Ljava/lang/String;I)V

    .line 131
    iput p3, p0, Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$FundType;->index:I

    .line 132
    iput p4, p0, Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$FundType;->value:I

    .line 133
    return-void
.end method

.method public static final getDescriptor()Lcom/google/protobuf/Descriptors$EnumDescriptor;
    .locals 2

    .prologue
    .line 113
    invoke-static {}, Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc;->getDescriptor()Lcom/google/protobuf/Descriptors$FileDescriptor;

    move-result-object v0

    invoke-virtual {v0}, Lcom/google/protobuf/Descriptors$FileDescriptor;->getEnumTypes()Ljava/util/List;

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
            "Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$FundType;",
            ">;"
        }
    .end annotation

    .prologue
    .line 93
    sget-object v0, Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$FundType;->internalValueMap:Lcom/google/protobuf/Internal$EnumLiteMap;

    return-object v0
.end method

.method public static valueOf(I)Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$FundType;
    .locals 1

    .prologue
    .line 79
    packed-switch p0, :pswitch_data_0

    .line 87
    const/4 v0, 0x0

    :goto_0
    return-object v0

    .line 80
    :pswitch_0
    sget-object v0, Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$FundType;->VOID:Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$FundType;

    goto :goto_0

    .line 81
    :pswitch_1
    sget-object v0, Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$FundType;->BOOLEAN:Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$FundType;

    goto :goto_0

    .line 82
    :pswitch_2
    sget-object v0, Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$FundType;->INT:Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$FundType;

    goto :goto_0

    .line 83
    :pswitch_3
    sget-object v0, Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$FundType;->LONG:Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$FundType;

    goto :goto_0

    .line 84
    :pswitch_4
    sget-object v0, Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$FundType;->FLOAT:Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$FundType;

    goto :goto_0

    .line 85
    :pswitch_5
    sget-object v0, Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$FundType;->DOUBLE:Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$FundType;

    goto :goto_0

    .line 86
    :pswitch_6
    sget-object v0, Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$FundType;->STRING:Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$FundType;

    goto :goto_0

    .line 79
    :pswitch_data_0
    .packed-switch 0x1
        :pswitch_0
        :pswitch_1
        :pswitch_2
        :pswitch_3
        :pswitch_4
        :pswitch_5
        :pswitch_6
    .end packed-switch
.end method

.method public static valueOf(Lcom/google/protobuf/Descriptors$EnumValueDescriptor;)Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$FundType;
    .locals 2

    .prologue
    .line 120
    invoke-virtual {p0}, Lcom/google/protobuf/Descriptors$EnumValueDescriptor;->getType()Lcom/google/protobuf/Descriptors$EnumDescriptor;

    move-result-object v0

    invoke-static {}, Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$FundType;->getDescriptor()Lcom/google/protobuf/Descriptors$EnumDescriptor;

    move-result-object v1

    if-eq v0, v1, :cond_0

    .line 121
    new-instance v0, Ljava/lang/IllegalArgumentException;

    const-string v1, "EnumValueDescriptor is not for this type."

    invoke-direct {v0, v1}, Ljava/lang/IllegalArgumentException;-><init>(Ljava/lang/String;)V

    throw v0

    .line 124
    :cond_0
    sget-object v0, Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$FundType;->VALUES:[Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$FundType;

    invoke-virtual {p0}, Lcom/google/protobuf/Descriptors$EnumValueDescriptor;->getIndex()I

    move-result v1

    aget-object v0, v0, v1

    return-object v0
.end method

.method public static valueOf(Ljava/lang/String;)Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$FundType;
    .locals 1

    .prologue
    .line 14
    const-class v0, Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$FundType;

    invoke-static {v0, p0}, Ljava/lang/Enum;->valueOf(Ljava/lang/Class;Ljava/lang/String;)Ljava/lang/Enum;

    move-result-object v0

    check-cast v0, Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$FundType;

    return-object v0
.end method

.method public static values()[Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$FundType;
    .locals 1

    .prologue
    .line 14
    sget-object v0, Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$FundType;->$VALUES:[Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$FundType;

    invoke-virtual {v0}, [Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$FundType;->clone()Ljava/lang/Object;

    move-result-object v0

    check-cast v0, [Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$FundType;

    return-object v0
.end method


# virtual methods
.method public final getDescriptorForType()Lcom/google/protobuf/Descriptors$EnumDescriptor;
    .locals 1

    .prologue
    .line 109
    invoke-static {}, Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$FundType;->getDescriptor()Lcom/google/protobuf/Descriptors$EnumDescriptor;

    move-result-object v0

    return-object v0
.end method

.method public final getNumber()I
    .locals 1

    .prologue
    .line 76
    iget v0, p0, Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$FundType;->value:I

    return v0
.end method

.method public final getValueDescriptor()Lcom/google/protobuf/Descriptors$EnumValueDescriptor;
    .locals 2

    .prologue
    .line 105
    invoke-static {}, Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$FundType;->getDescriptor()Lcom/google/protobuf/Descriptors$EnumDescriptor;

    move-result-object v0

    invoke-virtual {v0}, Lcom/google/protobuf/Descriptors$EnumDescriptor;->getValues()Ljava/util/List;

    move-result-object v0

    iget v1, p0, Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$FundType;->index:I

    invoke-interface {v0, v1}, Ljava/util/List;->get(I)Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Lcom/google/protobuf/Descriptors$EnumValueDescriptor;

    return-object v0
.end method
