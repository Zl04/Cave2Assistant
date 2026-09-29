.class public final Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$CommandToUi;
.super Lcom/google/protobuf/GeneratedMessage;
.source "SourceFile"

# interfaces
.implements Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$CommandToUiOrBuilder;


# annotations
.annotation system Ldalvik/annotation/EnclosingClass;
    value = Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage;
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x19
    name = "CommandToUi"
.end annotation

.annotation system Ldalvik/annotation/MemberClasses;
    value = {
        Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$CommandToUi$Builder;,
        Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$CommandToUi$Command_Type;
    }
.end annotation


# static fields
.field public static final ALIGNTYPE_FIELD_NUMBER:I = 0x11

.field public static final COLOR_FIELD_NUMBER:I = 0x10

.field public static final COMMAND_FIELD_NUMBER:I = 0x1

.field public static final CONTROL_ID_FIELD_NUMBER:I = 0x2

.field public static final DEFAULT_CHECK_STATUS_FIELD_NUMBER:I = 0x8

.field public static final DEFAULT_ITEM_INDEX_FIELD_NUMBER:I = 0xb

.field public static final EDIT_INPUT_TYPE_FIELD_NUMBER:I = 0x14

.field public static final ENABLED_STATUS_FIELD_NUMBER:I = 0xe

.field public static final FONT_SIZE_FIELD_NUMBER:I = 0x16

.field public static final FONT_TYPE_FIELD_NUMBER:I = 0x15

.field public static final HEIGHT_FIELD_NUMBER:I = 0x6

.field public static final ITEM_INDEX_FIELD_NUMBER:I = 0xa

.field public static final ITEM_TEXT_FIELD_NUMBER:I = 0x9

.field public static final LAYOUT_STYLE_FIELD_NUMBER:I = 0x7

.field public static final PADDING_FIELD_NUMBER:I = 0x12

.field public static final PARENT_ID_FIELD_NUMBER:I = 0x3

.field public static PARSER:Lcom/google/protobuf/Parser; = null
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "Lcom/google/protobuf/Parser",
            "<",
            "Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$CommandToUi;",
            ">;"
        }
    .end annotation
.end field

.field public static final PATH_FIELD_NUMBER:I = 0xc

.field public static final TEXT_FIELD_NUMBER:I = 0x4

.field public static final UIP_DATA_FIELD_NUMBER:I = 0x13

.field public static final URL_FIELD_NUMBER:I = 0xd

.field public static final VISIBLE_STATUS_FIELD_NUMBER:I = 0xf

.field public static final WIDTH_FIELD_NUMBER:I = 0x5

.field private static final defaultInstance:Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$CommandToUi;

.field private static final serialVersionUID:J


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

.field private memoizedIsInitialized:B

.field private memoizedSerializedSize:I

.field private padding_:Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$Padding_Var;

.field private parentId_:Ljava/lang/Object;

.field private path_:Ljava/lang/Object;

.field private text_:Ljava/lang/Object;

.field private uipData_:Ljava/lang/Object;

.field private final unknownFields:Lcom/google/protobuf/UnknownFieldSet;

.field private url_:Ljava/lang/Object;

.field private visibleStatus_:I

.field private width_:I


# direct methods
.method static constructor <clinit>()V
    .locals 2

    .prologue
    .line 1176
    new-instance v0, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$CommandToUi$1;

    invoke-direct {v0}, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$CommandToUi$1;-><init>()V

    sput-object v0, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$CommandToUi;->PARSER:Lcom/google/protobuf/Parser;

    .line 4252
    new-instance v0, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$CommandToUi;

    const/4 v1, 0x1

    invoke-direct {v0, v1}, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$CommandToUi;-><init>(Z)V

    sput-object v0, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$CommandToUi;->defaultInstance:Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$CommandToUi;

    .line 4253
    sget-object v0, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$CommandToUi;->defaultInstance:Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$CommandToUi;

    invoke-direct {v0}, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$CommandToUi;->initFields()V

    .line 4254
    return-void
.end method

.method private constructor <init>(Lcom/google/protobuf/CodedInputStream;Lcom/google/protobuf/ExtensionRegistryLite;)V
    .locals 9
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Lcom/google/protobuf/InvalidProtocolBufferException;
        }
    .end annotation

    .prologue
    const/4 v2, 0x0

    const/4 v0, -0x1

    const/high16 v7, 0x10000

    const/16 v6, 0x100

    const/4 v1, 0x1

    .line 1002
    invoke-direct {p0}, Lcom/google/protobuf/GeneratedMessage;-><init>()V

    .line 2404
    iput-byte v0, p0, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$CommandToUi;->memoizedIsInitialized:B

    .line 2495
    iput v0, p0, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$CommandToUi;->memoizedSerializedSize:I

    .line 1003
    invoke-direct {p0}, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$CommandToUi;->initFields()V

    .line 1006
    invoke-static {}, Lcom/google/protobuf/UnknownFieldSet;->newBuilder()Lcom/google/protobuf/UnknownFieldSet$Builder;

    move-result-object v5

    move v3, v2

    .line 1009
    :goto_0
    if-nez v2, :cond_3

    .line 1010
    :try_start_0
    invoke-virtual {p1}, Lcom/google/protobuf/CodedInputStream;->readTag()I

    move-result v0

    .line 1011
    sparse-switch v0, :sswitch_data_0

    .line 1016
    invoke-virtual {p0, p1, v5, p2, v0}, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$CommandToUi;->parseUnknownField(Lcom/google/protobuf/CodedInputStream;Lcom/google/protobuf/UnknownFieldSet$Builder;Lcom/google/protobuf/ExtensionRegistryLite;I)Z

    move-result v0

    if-nez v0, :cond_2

    move v0, v1

    move v2, v3

    :goto_1
    move v3, v2

    move v2, v0

    .line 1150
    goto :goto_0

    :sswitch_0
    move v0, v1

    move v2, v3

    .line 1014
    goto :goto_1

    .line 1023
    :sswitch_1
    invoke-virtual {p1}, Lcom/google/protobuf/CodedInputStream;->readEnum()I

    move-result v0

    .line 1024
    invoke-static {v0}, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$CommandToUi$Command_Type;->valueOf(I)Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$CommandToUi$Command_Type;

    move-result-object v4

    .line 1025
    if-nez v4, :cond_0

    .line 1026
    const/4 v4, 0x1

    invoke-virtual {v5, v4, v0}, Lcom/google/protobuf/UnknownFieldSet$Builder;->mergeVarintField(II)Lcom/google/protobuf/UnknownFieldSet$Builder;

    move v0, v2

    move v2, v3

    goto :goto_1

    .line 1028
    :cond_0
    iget v0, p0, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$CommandToUi;->bitField0_:I

    or-int/lit8 v0, v0, 0x1

    iput v0, p0, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$CommandToUi;->bitField0_:I

    .line 1029
    iput-object v4, p0, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$CommandToUi;->command_:Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$CommandToUi$Command_Type;

    move v0, v2

    move v2, v3

    .line 1031
    goto :goto_1

    .line 1034
    :sswitch_2
    iget v0, p0, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$CommandToUi;->bitField0_:I

    or-int/lit8 v0, v0, 0x2

    iput v0, p0, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$CommandToUi;->bitField0_:I

    .line 1035
    invoke-virtual {p1}, Lcom/google/protobuf/CodedInputStream;->readBytes()Lcom/google/protobuf/ByteString;

    move-result-object v0

    iput-object v0, p0, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$CommandToUi;->controlId_:Ljava/lang/Object;

    move v0, v2

    move v2, v3

    .line 1036
    goto :goto_1

    .line 1039
    :sswitch_3
    iget v0, p0, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$CommandToUi;->bitField0_:I

    or-int/lit8 v0, v0, 0x4

    iput v0, p0, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$CommandToUi;->bitField0_:I

    .line 1040
    invoke-virtual {p1}, Lcom/google/protobuf/CodedInputStream;->readBytes()Lcom/google/protobuf/ByteString;

    move-result-object v0

    iput-object v0, p0, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$CommandToUi;->parentId_:Ljava/lang/Object;

    move v0, v2

    move v2, v3

    .line 1041
    goto :goto_1

    .line 1044
    :sswitch_4
    iget v0, p0, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$CommandToUi;->bitField0_:I

    or-int/lit8 v0, v0, 0x8

    iput v0, p0, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$CommandToUi;->bitField0_:I

    .line 1045
    invoke-virtual {p1}, Lcom/google/protobuf/CodedInputStream;->readBytes()Lcom/google/protobuf/ByteString;

    move-result-object v0

    iput-object v0, p0, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$CommandToUi;->text_:Ljava/lang/Object;

    move v0, v2

    move v2, v3

    .line 1046
    goto :goto_1

    .line 1049
    :sswitch_5
    iget v0, p0, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$CommandToUi;->bitField0_:I

    or-int/lit8 v0, v0, 0x10

    iput v0, p0, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$CommandToUi;->bitField0_:I

    .line 1050
    invoke-virtual {p1}, Lcom/google/protobuf/CodedInputStream;->readInt32()I

    move-result v0

    iput v0, p0, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$CommandToUi;->width_:I

    move v0, v2

    move v2, v3

    .line 1051
    goto :goto_1

    .line 1054
    :sswitch_6
    iget v0, p0, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$CommandToUi;->bitField0_:I

    or-int/lit8 v0, v0, 0x20

    iput v0, p0, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$CommandToUi;->bitField0_:I

    .line 1055
    invoke-virtual {p1}, Lcom/google/protobuf/CodedInputStream;->readInt32()I

    move-result v0

    iput v0, p0, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$CommandToUi;->height_:I

    move v0, v2

    move v2, v3

    .line 1056
    goto :goto_1

    .line 1059
    :sswitch_7
    iget v0, p0, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$CommandToUi;->bitField0_:I

    or-int/lit8 v0, v0, 0x40

    iput v0, p0, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$CommandToUi;->bitField0_:I

    .line 1060
    invoke-virtual {p1}, Lcom/google/protobuf/CodedInputStream;->readInt32()I

    move-result v0

    iput v0, p0, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$CommandToUi;->layoutStyle_:I

    move v0, v2

    move v2, v3

    .line 1061
    goto :goto_1

    .line 1064
    :sswitch_8
    iget v0, p0, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$CommandToUi;->bitField0_:I

    or-int/lit16 v0, v0, 0x80

    iput v0, p0, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$CommandToUi;->bitField0_:I

    .line 1065
    invoke-virtual {p1}, Lcom/google/protobuf/CodedInputStream;->readBool()Z

    move-result v0

    iput-boolean v0, p0, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$CommandToUi;->defaultCheckStatus_:Z

    move v0, v2

    move v2, v3

    .line 1066
    goto/16 :goto_1

    .line 1069
    :sswitch_9
    and-int/lit16 v0, v3, 0x100

    if-eq v0, v6, :cond_7

    .line 1070
    new-instance v0, Lcom/google/protobuf/LazyStringArrayList;

    invoke-direct {v0}, Lcom/google/protobuf/LazyStringArrayList;-><init>()V

    iput-object v0, p0, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$CommandToUi;->itemText_:Lcom/google/protobuf/LazyStringList;
    :try_end_0
    .catch Lcom/google/protobuf/InvalidProtocolBufferException; {:try_start_0 .. :try_end_0} :catch_0
    .catch Ljava/io/IOException; {:try_start_0 .. :try_end_0} :catch_1
    .catchall {:try_start_0 .. :try_end_0} :catchall_0

    .line 1071
    or-int/lit16 v0, v3, 0x100

    .line 1073
    :goto_2
    :try_start_1
    iget-object v3, p0, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$CommandToUi;->itemText_:Lcom/google/protobuf/LazyStringList;

    invoke-virtual {p1}, Lcom/google/protobuf/CodedInputStream;->readBytes()Lcom/google/protobuf/ByteString;

    move-result-object v4

    invoke-interface {v3, v4}, Lcom/google/protobuf/LazyStringList;->add(Lcom/google/protobuf/ByteString;)V
    :try_end_1
    .catch Lcom/google/protobuf/InvalidProtocolBufferException; {:try_start_1 .. :try_end_1} :catch_3
    .catch Ljava/io/IOException; {:try_start_1 .. :try_end_1} :catch_2
    .catchall {:try_start_1 .. :try_end_1} :catchall_1

    move v8, v2

    move v2, v0

    move v0, v8

    .line 1074
    goto/16 :goto_1

    .line 1077
    :sswitch_a
    :try_start_2
    iget v0, p0, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$CommandToUi;->bitField0_:I

    or-int/lit16 v0, v0, 0x100

    iput v0, p0, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$CommandToUi;->bitField0_:I

    .line 1078
    invoke-virtual {p1}, Lcom/google/protobuf/CodedInputStream;->readInt32()I

    move-result v0

    iput v0, p0, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$CommandToUi;->itemIndex_:I

    move v0, v2

    move v2, v3

    .line 1079
    goto/16 :goto_1

    .line 1082
    :sswitch_b
    iget v0, p0, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$CommandToUi;->bitField0_:I

    or-int/lit16 v0, v0, 0x200

    iput v0, p0, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$CommandToUi;->bitField0_:I

    .line 1083
    invoke-virtual {p1}, Lcom/google/protobuf/CodedInputStream;->readInt32()I

    move-result v0

    iput v0, p0, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$CommandToUi;->defaultItemIndex_:I

    move v0, v2

    move v2, v3

    .line 1084
    goto/16 :goto_1

    .line 1087
    :sswitch_c
    iget v0, p0, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$CommandToUi;->bitField0_:I

    or-int/lit16 v0, v0, 0x400

    iput v0, p0, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$CommandToUi;->bitField0_:I

    .line 1088
    invoke-virtual {p1}, Lcom/google/protobuf/CodedInputStream;->readBytes()Lcom/google/protobuf/ByteString;

    move-result-object v0

    iput-object v0, p0, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$CommandToUi;->path_:Ljava/lang/Object;

    move v0, v2

    move v2, v3

    .line 1089
    goto/16 :goto_1

    .line 1092
    :sswitch_d
    iget v0, p0, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$CommandToUi;->bitField0_:I

    or-int/lit16 v0, v0, 0x800

    iput v0, p0, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$CommandToUi;->bitField0_:I

    .line 1093
    invoke-virtual {p1}, Lcom/google/protobuf/CodedInputStream;->readBytes()Lcom/google/protobuf/ByteString;

    move-result-object v0

    iput-object v0, p0, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$CommandToUi;->url_:Ljava/lang/Object;

    move v0, v2

    move v2, v3

    .line 1094
    goto/16 :goto_1

    .line 1097
    :sswitch_e
    iget v0, p0, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$CommandToUi;->bitField0_:I

    or-int/lit16 v0, v0, 0x1000

    iput v0, p0, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$CommandToUi;->bitField0_:I

    .line 1098
    invoke-virtual {p1}, Lcom/google/protobuf/CodedInputStream;->readBool()Z

    move-result v0

    iput-boolean v0, p0, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$CommandToUi;->enabledStatus_:Z

    move v0, v2

    move v2, v3

    .line 1099
    goto/16 :goto_1

    .line 1102
    :sswitch_f
    iget v0, p0, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$CommandToUi;->bitField0_:I

    or-int/lit16 v0, v0, 0x2000

    iput v0, p0, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$CommandToUi;->bitField0_:I

    .line 1103
    invoke-virtual {p1}, Lcom/google/protobuf/CodedInputStream;->readInt32()I

    move-result v0

    iput v0, p0, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$CommandToUi;->visibleStatus_:I

    move v0, v2

    move v2, v3

    .line 1104
    goto/16 :goto_1

    .line 1107
    :sswitch_10
    iget v0, p0, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$CommandToUi;->bitField0_:I

    or-int/lit16 v0, v0, 0x4000

    iput v0, p0, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$CommandToUi;->bitField0_:I

    .line 1108
    invoke-virtual {p1}, Lcom/google/protobuf/CodedInputStream;->readBytes()Lcom/google/protobuf/ByteString;

    move-result-object v0

    iput-object v0, p0, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$CommandToUi;->color_:Ljava/lang/Object;

    move v0, v2

    move v2, v3

    .line 1109
    goto/16 :goto_1

    .line 1112
    :sswitch_11
    iget v0, p0, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$CommandToUi;->bitField0_:I

    const v4, 0x8000

    or-int/2addr v0, v4

    iput v0, p0, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$CommandToUi;->bitField0_:I

    .line 1113
    invoke-virtual {p1}, Lcom/google/protobuf/CodedInputStream;->readInt32()I

    move-result v0

    iput v0, p0, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$CommandToUi;->alignType_:I

    move v0, v2

    move v2, v3

    .line 1114
    goto/16 :goto_1

    .line 1117
    :sswitch_12
    const/4 v0, 0x0

    .line 1118
    iget v4, p0, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$CommandToUi;->bitField0_:I

    and-int/2addr v4, v7

    if-ne v4, v7, :cond_6

    .line 1119
    iget-object v0, p0, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$CommandToUi;->padding_:Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$Padding_Var;

    invoke-virtual {v0}, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$Padding_Var;->toBuilder()Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$Padding_Var$Builder;

    move-result-object v0

    move-object v4, v0

    .line 1121
    :goto_3
    sget-object v0, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$Padding_Var;->PARSER:Lcom/google/protobuf/Parser;

    invoke-virtual {p1, v0, p2}, Lcom/google/protobuf/CodedInputStream;->readMessage(Lcom/google/protobuf/Parser;Lcom/google/protobuf/ExtensionRegistryLite;)Lcom/google/protobuf/MessageLite;

    move-result-object v0

    check-cast v0, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$Padding_Var;

    iput-object v0, p0, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$CommandToUi;->padding_:Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$Padding_Var;

    .line 1122
    if-eqz v4, :cond_1

    .line 1123
    iget-object v0, p0, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$CommandToUi;->padding_:Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$Padding_Var;

    invoke-virtual {v4, v0}, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$Padding_Var$Builder;->mergeFrom(Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$Padding_Var;)Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$Padding_Var$Builder;

    .line 1124
    invoke-virtual {v4}, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$Padding_Var$Builder;->buildPartial()Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$Padding_Var;

    move-result-object v0

    iput-object v0, p0, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$CommandToUi;->padding_:Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$Padding_Var;

    .line 1126
    :cond_1
    iget v0, p0, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$CommandToUi;->bitField0_:I

    or-int/2addr v0, v7

    iput v0, p0, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$CommandToUi;->bitField0_:I

    move v0, v2

    move v2, v3

    .line 1127
    goto/16 :goto_1

    .line 1130
    :sswitch_13
    iget v0, p0, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$CommandToUi;->bitField0_:I

    const/high16 v4, 0x20000

    or-int/2addr v0, v4

    iput v0, p0, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$CommandToUi;->bitField0_:I

    .line 1131
    invoke-virtual {p1}, Lcom/google/protobuf/CodedInputStream;->readBytes()Lcom/google/protobuf/ByteString;

    move-result-object v0

    iput-object v0, p0, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$CommandToUi;->uipData_:Ljava/lang/Object;

    move v0, v2

    move v2, v3

    .line 1132
    goto/16 :goto_1

    .line 1135
    :sswitch_14
    iget v0, p0, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$CommandToUi;->bitField0_:I

    const/high16 v4, 0x40000

    or-int/2addr v0, v4

    iput v0, p0, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$CommandToUi;->bitField0_:I

    .line 1136
    invoke-virtual {p1}, Lcom/google/protobuf/CodedInputStream;->readInt32()I

    move-result v0

    iput v0, p0, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$CommandToUi;->editInputType_:I

    move v0, v2

    move v2, v3

    .line 1137
    goto/16 :goto_1

    .line 1140
    :sswitch_15
    iget v0, p0, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$CommandToUi;->bitField0_:I

    const/high16 v4, 0x80000

    or-int/2addr v0, v4

    iput v0, p0, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$CommandToUi;->bitField0_:I

    .line 1141
    invoke-virtual {p1}, Lcom/google/protobuf/CodedInputStream;->readBytes()Lcom/google/protobuf/ByteString;

    move-result-object v0

    iput-object v0, p0, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$CommandToUi;->fontType_:Ljava/lang/Object;

    move v0, v2

    move v2, v3

    .line 1142
    goto/16 :goto_1

    .line 1145
    :sswitch_16
    iget v0, p0, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$CommandToUi;->bitField0_:I

    const/high16 v4, 0x100000

    or-int/2addr v0, v4

    iput v0, p0, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$CommandToUi;->bitField0_:I

    .line 1146
    invoke-virtual {p1}, Lcom/google/protobuf/CodedInputStream;->readInt32()I

    move-result v0

    iput v0, p0, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$CommandToUi;->fontSize_:I
    :try_end_2
    .catch Lcom/google/protobuf/InvalidProtocolBufferException; {:try_start_2 .. :try_end_2} :catch_0
    .catch Ljava/io/IOException; {:try_start_2 .. :try_end_2} :catch_1
    .catchall {:try_start_2 .. :try_end_2} :catchall_0

    :cond_2
    move v0, v2

    move v2, v3

    goto/16 :goto_1

    .line 1157
    :cond_3
    and-int/lit16 v0, v3, 0x100

    if-ne v0, v6, :cond_4

    .line 1158
    new-instance v0, Lcom/google/protobuf/UnmodifiableLazyStringList;

    iget-object v1, p0, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$CommandToUi;->itemText_:Lcom/google/protobuf/LazyStringList;

    invoke-direct {v0, v1}, Lcom/google/protobuf/UnmodifiableLazyStringList;-><init>(Lcom/google/protobuf/LazyStringList;)V

    iput-object v0, p0, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$CommandToUi;->itemText_:Lcom/google/protobuf/LazyStringList;

    .line 1160
    :cond_4
    invoke-virtual {v5}, Lcom/google/protobuf/UnknownFieldSet$Builder;->build()Lcom/google/protobuf/UnknownFieldSet;

    move-result-object v0

    iput-object v0, p0, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$CommandToUi;->unknownFields:Lcom/google/protobuf/UnknownFieldSet;

    .line 1161
    invoke-virtual {p0}, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$CommandToUi;->makeExtensionsImmutable()V

    .line 1163
    return-void

    .line 1151
    :catch_0
    move-exception v0

    .line 1152
    :goto_4
    :try_start_3
    invoke-virtual {v0, p0}, Lcom/google/protobuf/InvalidProtocolBufferException;->setUnfinishedMessage(Lcom/google/protobuf/MessageLite;)Lcom/google/protobuf/InvalidProtocolBufferException;

    move-result-object v0

    throw v0
    :try_end_3
    .catchall {:try_start_3 .. :try_end_3} :catchall_0

    .line 1157
    :catchall_0
    move-exception v0

    :goto_5
    and-int/lit16 v1, v3, 0x100

    if-ne v1, v6, :cond_5

    .line 1158
    new-instance v1, Lcom/google/protobuf/UnmodifiableLazyStringList;

    iget-object v2, p0, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$CommandToUi;->itemText_:Lcom/google/protobuf/LazyStringList;

    invoke-direct {v1, v2}, Lcom/google/protobuf/UnmodifiableLazyStringList;-><init>(Lcom/google/protobuf/LazyStringList;)V

    iput-object v1, p0, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$CommandToUi;->itemText_:Lcom/google/protobuf/LazyStringList;

    .line 1160
    :cond_5
    invoke-virtual {v5}, Lcom/google/protobuf/UnknownFieldSet$Builder;->build()Lcom/google/protobuf/UnknownFieldSet;

    move-result-object v1

    iput-object v1, p0, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$CommandToUi;->unknownFields:Lcom/google/protobuf/UnknownFieldSet;

    .line 1161
    invoke-virtual {p0}, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$CommandToUi;->makeExtensionsImmutable()V

    throw v0

    .line 1153
    :catch_1
    move-exception v0

    .line 1154
    :goto_6
    :try_start_4
    new-instance v1, Lcom/google/protobuf/InvalidProtocolBufferException;

    .line 1155
    invoke-virtual {v0}, Ljava/io/IOException;->getMessage()Ljava/lang/String;

    move-result-object v0

    invoke-direct {v1, v0}, Lcom/google/protobuf/InvalidProtocolBufferException;-><init>(Ljava/lang/String;)V

    invoke-virtual {v1, p0}, Lcom/google/protobuf/InvalidProtocolBufferException;->setUnfinishedMessage(Lcom/google/protobuf/MessageLite;)Lcom/google/protobuf/InvalidProtocolBufferException;

    move-result-object v0

    throw v0
    :try_end_4
    .catchall {:try_start_4 .. :try_end_4} :catchall_0

    .line 1157
    :catchall_1
    move-exception v1

    move v3, v0

    move-object v0, v1

    goto :goto_5

    .line 1153
    :catch_2
    move-exception v1

    move v3, v0

    move-object v0, v1

    goto :goto_6

    .line 1151
    :catch_3
    move-exception v1

    move v3, v0

    move-object v0, v1

    goto :goto_4

    :cond_6
    move-object v4, v0

    goto/16 :goto_3

    :cond_7
    move v0, v3

    goto/16 :goto_2

    .line 1011
    nop

    :sswitch_data_0
    .sparse-switch
        0x0 -> :sswitch_0
        0x8 -> :sswitch_1
        0x12 -> :sswitch_2
        0x1a -> :sswitch_3
        0x22 -> :sswitch_4
        0x28 -> :sswitch_5
        0x30 -> :sswitch_6
        0x38 -> :sswitch_7
        0x40 -> :sswitch_8
        0x4a -> :sswitch_9
        0x50 -> :sswitch_a
        0x58 -> :sswitch_b
        0x62 -> :sswitch_c
        0x6a -> :sswitch_d
        0x70 -> :sswitch_e
        0x78 -> :sswitch_f
        0x82 -> :sswitch_10
        0x88 -> :sswitch_11
        0x92 -> :sswitch_12
        0x9a -> :sswitch_13
        0xa0 -> :sswitch_14
        0xaa -> :sswitch_15
        0xb0 -> :sswitch_16
    .end sparse-switch
.end method

.method synthetic constructor <init>(Lcom/google/protobuf/CodedInputStream;Lcom/google/protobuf/ExtensionRegistryLite;Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$1;)V
    .locals 0
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Lcom/google/protobuf/InvalidProtocolBufferException;
        }
    .end annotation

    .prologue
    .line 974
    invoke-direct {p0, p1, p2}, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$CommandToUi;-><init>(Lcom/google/protobuf/CodedInputStream;Lcom/google/protobuf/ExtensionRegistryLite;)V

    return-void
.end method

.method private constructor <init>(Lcom/google/protobuf/GeneratedMessage$Builder;)V
    .locals 1
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "(",
            "Lcom/google/protobuf/GeneratedMessage$Builder",
            "<*>;)V"
        }
    .end annotation

    .prologue
    const/4 v0, -0x1

    .line 979
    invoke-direct {p0, p1}, Lcom/google/protobuf/GeneratedMessage;-><init>(Lcom/google/protobuf/GeneratedMessage$Builder;)V

    .line 2404
    iput-byte v0, p0, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$CommandToUi;->memoizedIsInitialized:B

    .line 2495
    iput v0, p0, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$CommandToUi;->memoizedSerializedSize:I

    .line 980
    invoke-virtual {p1}, Lcom/google/protobuf/GeneratedMessage$Builder;->getUnknownFields()Lcom/google/protobuf/UnknownFieldSet;

    move-result-object v0

    iput-object v0, p0, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$CommandToUi;->unknownFields:Lcom/google/protobuf/UnknownFieldSet;

    .line 981
    return-void
.end method

.method synthetic constructor <init>(Lcom/google/protobuf/GeneratedMessage$Builder;Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$1;)V
    .locals 0

    .prologue
    .line 974
    invoke-direct {p0, p1}, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$CommandToUi;-><init>(Lcom/google/protobuf/GeneratedMessage$Builder;)V

    return-void
.end method

.method private constructor <init>(Z)V
    .locals 1

    .prologue
    const/4 v0, -0x1

    .line 982
    invoke-direct {p0}, Lcom/google/protobuf/GeneratedMessage;-><init>()V

    .line 2404
    iput-byte v0, p0, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$CommandToUi;->memoizedIsInitialized:B

    .line 2495
    iput v0, p0, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$CommandToUi;->memoizedSerializedSize:I

    .line 982
    invoke-static {}, Lcom/google/protobuf/UnknownFieldSet;->getDefaultInstance()Lcom/google/protobuf/UnknownFieldSet;

    move-result-object v0

    iput-object v0, p0, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$CommandToUi;->unknownFields:Lcom/google/protobuf/UnknownFieldSet;

    return-void
.end method

.method static synthetic access$1700()Z
    .locals 1

    .prologue
    .line 974
    sget-boolean v0, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$CommandToUi;->alwaysUseFieldBuilders:Z

    return v0
.end method

.method static synthetic access$1902(Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$CommandToUi;Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$CommandToUi$Command_Type;)Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$CommandToUi$Command_Type;
    .locals 0

    .prologue
    .line 974
    iput-object p1, p0, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$CommandToUi;->command_:Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$CommandToUi$Command_Type;

    return-object p1
.end method

.method static synthetic access$2000(Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$CommandToUi;)Ljava/lang/Object;
    .locals 1

    .prologue
    .line 974
    iget-object v0, p0, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$CommandToUi;->controlId_:Ljava/lang/Object;

    return-object v0
.end method

.method static synthetic access$2002(Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$CommandToUi;Ljava/lang/Object;)Ljava/lang/Object;
    .locals 0

    .prologue
    .line 974
    iput-object p1, p0, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$CommandToUi;->controlId_:Ljava/lang/Object;

    return-object p1
.end method

.method static synthetic access$2100(Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$CommandToUi;)Ljava/lang/Object;
    .locals 1

    .prologue
    .line 974
    iget-object v0, p0, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$CommandToUi;->parentId_:Ljava/lang/Object;

    return-object v0
.end method

.method static synthetic access$2102(Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$CommandToUi;Ljava/lang/Object;)Ljava/lang/Object;
    .locals 0

    .prologue
    .line 974
    iput-object p1, p0, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$CommandToUi;->parentId_:Ljava/lang/Object;

    return-object p1
.end method

.method static synthetic access$2200(Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$CommandToUi;)Ljava/lang/Object;
    .locals 1

    .prologue
    .line 974
    iget-object v0, p0, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$CommandToUi;->text_:Ljava/lang/Object;

    return-object v0
.end method

.method static synthetic access$2202(Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$CommandToUi;Ljava/lang/Object;)Ljava/lang/Object;
    .locals 0

    .prologue
    .line 974
    iput-object p1, p0, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$CommandToUi;->text_:Ljava/lang/Object;

    return-object p1
.end method

.method static synthetic access$2302(Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$CommandToUi;I)I
    .locals 0

    .prologue
    .line 974
    iput p1, p0, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$CommandToUi;->width_:I

    return p1
.end method

.method static synthetic access$2402(Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$CommandToUi;I)I
    .locals 0

    .prologue
    .line 974
    iput p1, p0, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$CommandToUi;->height_:I

    return p1
.end method

.method static synthetic access$2502(Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$CommandToUi;I)I
    .locals 0

    .prologue
    .line 974
    iput p1, p0, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$CommandToUi;->layoutStyle_:I

    return p1
.end method

.method static synthetic access$2602(Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$CommandToUi;Z)Z
    .locals 0

    .prologue
    .line 974
    iput-boolean p1, p0, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$CommandToUi;->defaultCheckStatus_:Z

    return p1
.end method

.method static synthetic access$2700(Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$CommandToUi;)Lcom/google/protobuf/LazyStringList;
    .locals 1

    .prologue
    .line 974
    iget-object v0, p0, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$CommandToUi;->itemText_:Lcom/google/protobuf/LazyStringList;

    return-object v0
.end method

.method static synthetic access$2702(Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$CommandToUi;Lcom/google/protobuf/LazyStringList;)Lcom/google/protobuf/LazyStringList;
    .locals 0

    .prologue
    .line 974
    iput-object p1, p0, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$CommandToUi;->itemText_:Lcom/google/protobuf/LazyStringList;

    return-object p1
.end method

.method static synthetic access$2802(Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$CommandToUi;I)I
    .locals 0

    .prologue
    .line 974
    iput p1, p0, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$CommandToUi;->itemIndex_:I

    return p1
.end method

.method static synthetic access$2902(Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$CommandToUi;I)I
    .locals 0

    .prologue
    .line 974
    iput p1, p0, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$CommandToUi;->defaultItemIndex_:I

    return p1
.end method

.method static synthetic access$3000(Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$CommandToUi;)Ljava/lang/Object;
    .locals 1

    .prologue
    .line 974
    iget-object v0, p0, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$CommandToUi;->path_:Ljava/lang/Object;

    return-object v0
.end method

.method static synthetic access$3002(Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$CommandToUi;Ljava/lang/Object;)Ljava/lang/Object;
    .locals 0

    .prologue
    .line 974
    iput-object p1, p0, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$CommandToUi;->path_:Ljava/lang/Object;

    return-object p1
.end method

.method static synthetic access$3100(Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$CommandToUi;)Ljava/lang/Object;
    .locals 1

    .prologue
    .line 974
    iget-object v0, p0, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$CommandToUi;->url_:Ljava/lang/Object;

    return-object v0
.end method

.method static synthetic access$3102(Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$CommandToUi;Ljava/lang/Object;)Ljava/lang/Object;
    .locals 0

    .prologue
    .line 974
    iput-object p1, p0, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$CommandToUi;->url_:Ljava/lang/Object;

    return-object p1
.end method

.method static synthetic access$3202(Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$CommandToUi;Z)Z
    .locals 0

    .prologue
    .line 974
    iput-boolean p1, p0, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$CommandToUi;->enabledStatus_:Z

    return p1
.end method

.method static synthetic access$3302(Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$CommandToUi;I)I
    .locals 0

    .prologue
    .line 974
    iput p1, p0, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$CommandToUi;->visibleStatus_:I

    return p1
.end method

.method static synthetic access$3400(Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$CommandToUi;)Ljava/lang/Object;
    .locals 1

    .prologue
    .line 974
    iget-object v0, p0, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$CommandToUi;->color_:Ljava/lang/Object;

    return-object v0
.end method

.method static synthetic access$3402(Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$CommandToUi;Ljava/lang/Object;)Ljava/lang/Object;
    .locals 0

    .prologue
    .line 974
    iput-object p1, p0, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$CommandToUi;->color_:Ljava/lang/Object;

    return-object p1
.end method

.method static synthetic access$3502(Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$CommandToUi;I)I
    .locals 0

    .prologue
    .line 974
    iput p1, p0, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$CommandToUi;->alignType_:I

    return p1
.end method

.method static synthetic access$3602(Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$CommandToUi;Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$Padding_Var;)Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$Padding_Var;
    .locals 0

    .prologue
    .line 974
    iput-object p1, p0, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$CommandToUi;->padding_:Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$Padding_Var;

    return-object p1
.end method

.method static synthetic access$3700(Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$CommandToUi;)Ljava/lang/Object;
    .locals 1

    .prologue
    .line 974
    iget-object v0, p0, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$CommandToUi;->uipData_:Ljava/lang/Object;

    return-object v0
.end method

.method static synthetic access$3702(Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$CommandToUi;Ljava/lang/Object;)Ljava/lang/Object;
    .locals 0

    .prologue
    .line 974
    iput-object p1, p0, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$CommandToUi;->uipData_:Ljava/lang/Object;

    return-object p1
.end method

.method static synthetic access$3802(Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$CommandToUi;I)I
    .locals 0

    .prologue
    .line 974
    iput p1, p0, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$CommandToUi;->editInputType_:I

    return p1
.end method

.method static synthetic access$3900(Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$CommandToUi;)Ljava/lang/Object;
    .locals 1

    .prologue
    .line 974
    iget-object v0, p0, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$CommandToUi;->fontType_:Ljava/lang/Object;

    return-object v0
.end method

.method static synthetic access$3902(Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$CommandToUi;Ljava/lang/Object;)Ljava/lang/Object;
    .locals 0

    .prologue
    .line 974
    iput-object p1, p0, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$CommandToUi;->fontType_:Ljava/lang/Object;

    return-object p1
.end method

.method static synthetic access$4002(Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$CommandToUi;I)I
    .locals 0

    .prologue
    .line 974
    iput p1, p0, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$CommandToUi;->fontSize_:I

    return p1
.end method

.method static synthetic access$4102(Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$CommandToUi;I)I
    .locals 0

    .prologue
    .line 974
    iput p1, p0, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$CommandToUi;->bitField0_:I

    return p1
.end method

.method public static getDefaultInstance()Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$CommandToUi;
    .locals 1

    .prologue
    .line 986
    sget-object v0, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$CommandToUi;->defaultInstance:Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$CommandToUi;

    return-object v0
.end method

.method public static final getDescriptor()Lcom/google/protobuf/Descriptors$Descriptor;
    .locals 1

    .prologue
    .line 1166
    invoke-static {}, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage;->d()Lcom/google/protobuf/Descriptors$Descriptor;

    move-result-object v0

    return-object v0
.end method

.method private initFields()V
    .locals 2

    .prologue
    const/4 v1, 0x0

    .line 2381
    sget-object v0, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$CommandToUi$Command_Type;->NEW_LAYOUT:Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$CommandToUi$Command_Type;

    iput-object v0, p0, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$CommandToUi;->command_:Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$CommandToUi$Command_Type;

    .line 2382
    const-string v0, ""

    iput-object v0, p0, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$CommandToUi;->controlId_:Ljava/lang/Object;

    .line 2383
    const-string v0, ""

    iput-object v0, p0, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$CommandToUi;->parentId_:Ljava/lang/Object;

    .line 2384
    const-string v0, ""

    iput-object v0, p0, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$CommandToUi;->text_:Ljava/lang/Object;

    .line 2385
    iput v1, p0, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$CommandToUi;->width_:I

    .line 2386
    iput v1, p0, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$CommandToUi;->height_:I

    .line 2387
    iput v1, p0, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$CommandToUi;->layoutStyle_:I

    .line 2388
    iput-boolean v1, p0, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$CommandToUi;->defaultCheckStatus_:Z

    .line 2389
    sget-object v0, Lcom/google/protobuf/LazyStringArrayList;->EMPTY:Lcom/google/protobuf/LazyStringList;

    iput-object v0, p0, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$CommandToUi;->itemText_:Lcom/google/protobuf/LazyStringList;

    .line 2390
    iput v1, p0, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$CommandToUi;->itemIndex_:I

    .line 2391
    iput v1, p0, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$CommandToUi;->defaultItemIndex_:I

    .line 2392
    const-string v0, ""

    iput-object v0, p0, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$CommandToUi;->path_:Ljava/lang/Object;

    .line 2393
    const-string v0, ""

    iput-object v0, p0, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$CommandToUi;->url_:Ljava/lang/Object;

    .line 2394
    iput-boolean v1, p0, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$CommandToUi;->enabledStatus_:Z

    .line 2395
    iput v1, p0, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$CommandToUi;->visibleStatus_:I

    .line 2396
    const-string v0, ""

    iput-object v0, p0, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$CommandToUi;->color_:Ljava/lang/Object;

    .line 2397
    iput v1, p0, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$CommandToUi;->alignType_:I

    .line 2398
    invoke-static {}, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$Padding_Var;->getDefaultInstance()Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$Padding_Var;

    move-result-object v0

    iput-object v0, p0, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$CommandToUi;->padding_:Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$Padding_Var;

    .line 2399
    const-string v0, ""

    iput-object v0, p0, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$CommandToUi;->uipData_:Ljava/lang/Object;

    .line 2400
    iput v1, p0, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$CommandToUi;->editInputType_:I

    .line 2401
    const-string v0, ""

    iput-object v0, p0, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$CommandToUi;->fontType_:Ljava/lang/Object;

    .line 2402
    iput v1, p0, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$CommandToUi;->fontSize_:I

    .line 2403
    return-void
.end method

.method public static newBuilder()Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$CommandToUi$Builder;
    .locals 1

    .prologue
    .line 2659
    invoke-static {}, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$CommandToUi$Builder;->access$1500()Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$CommandToUi$Builder;

    move-result-object v0

    return-object v0
.end method

.method public static newBuilder(Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$CommandToUi;)Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$CommandToUi$Builder;
    .locals 1

    .prologue
    .line 2662
    invoke-static {}, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$CommandToUi;->newBuilder()Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$CommandToUi$Builder;

    move-result-object v0

    invoke-virtual {v0, p0}, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$CommandToUi$Builder;->mergeFrom(Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$CommandToUi;)Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$CommandToUi$Builder;

    move-result-object v0

    return-object v0
.end method

.method public static parseDelimitedFrom(Ljava/io/InputStream;)Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$CommandToUi;
    .locals 1
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljava/io/IOException;
        }
    .end annotation

    .prologue
    .line 2639
    sget-object v0, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$CommandToUi;->PARSER:Lcom/google/protobuf/Parser;

    invoke-interface {v0, p0}, Lcom/google/protobuf/Parser;->parseDelimitedFrom(Ljava/io/InputStream;)Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$CommandToUi;

    return-object v0
.end method

.method public static parseDelimitedFrom(Ljava/io/InputStream;Lcom/google/protobuf/ExtensionRegistryLite;)Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$CommandToUi;
    .locals 1
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljava/io/IOException;
        }
    .end annotation

    .prologue
    .line 2645
    sget-object v0, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$CommandToUi;->PARSER:Lcom/google/protobuf/Parser;

    invoke-interface {v0, p0, p1}, Lcom/google/protobuf/Parser;->parseDelimitedFrom(Ljava/io/InputStream;Lcom/google/protobuf/ExtensionRegistryLite;)Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$CommandToUi;

    return-object v0
.end method

.method public static parseFrom(Lcom/google/protobuf/ByteString;)Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$CommandToUi;
    .locals 1
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Lcom/google/protobuf/InvalidProtocolBufferException;
        }
    .end annotation

    .prologue
    .line 2609
    sget-object v0, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$CommandToUi;->PARSER:Lcom/google/protobuf/Parser;

    invoke-interface {v0, p0}, Lcom/google/protobuf/Parser;->parseFrom(Lcom/google/protobuf/ByteString;)Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$CommandToUi;

    return-object v0
.end method

.method public static parseFrom(Lcom/google/protobuf/ByteString;Lcom/google/protobuf/ExtensionRegistryLite;)Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$CommandToUi;
    .locals 1
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Lcom/google/protobuf/InvalidProtocolBufferException;
        }
    .end annotation

    .prologue
    .line 2615
    sget-object v0, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$CommandToUi;->PARSER:Lcom/google/protobuf/Parser;

    invoke-interface {v0, p0, p1}, Lcom/google/protobuf/Parser;->parseFrom(Lcom/google/protobuf/ByteString;Lcom/google/protobuf/ExtensionRegistryLite;)Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$CommandToUi;

    return-object v0
.end method

.method public static parseFrom(Lcom/google/protobuf/CodedInputStream;)Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$CommandToUi;
    .locals 1
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljava/io/IOException;
        }
    .end annotation

    .prologue
    .line 2650
    sget-object v0, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$CommandToUi;->PARSER:Lcom/google/protobuf/Parser;

    invoke-interface {v0, p0}, Lcom/google/protobuf/Parser;->parseFrom(Lcom/google/protobuf/CodedInputStream;)Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$CommandToUi;

    return-object v0
.end method

.method public static parseFrom(Lcom/google/protobuf/CodedInputStream;Lcom/google/protobuf/ExtensionRegistryLite;)Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$CommandToUi;
    .locals 1
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljava/io/IOException;
        }
    .end annotation

    .prologue
    .line 2656
    sget-object v0, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$CommandToUi;->PARSER:Lcom/google/protobuf/Parser;

    invoke-interface {v0, p0, p1}, Lcom/google/protobuf/Parser;->parseFrom(Lcom/google/protobuf/CodedInputStream;Lcom/google/protobuf/ExtensionRegistryLite;)Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$CommandToUi;

    return-object v0
.end method

.method public static parseFrom(Ljava/io/InputStream;)Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$CommandToUi;
    .locals 1
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljava/io/IOException;
        }
    .end annotation

    .prologue
    .line 2629
    sget-object v0, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$CommandToUi;->PARSER:Lcom/google/protobuf/Parser;

    invoke-interface {v0, p0}, Lcom/google/protobuf/Parser;->parseFrom(Ljava/io/InputStream;)Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$CommandToUi;

    return-object v0
.end method

.method public static parseFrom(Ljava/io/InputStream;Lcom/google/protobuf/ExtensionRegistryLite;)Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$CommandToUi;
    .locals 1
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljava/io/IOException;
        }
    .end annotation

    .prologue
    .line 2635
    sget-object v0, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$CommandToUi;->PARSER:Lcom/google/protobuf/Parser;

    invoke-interface {v0, p0, p1}, Lcom/google/protobuf/Parser;->parseFrom(Ljava/io/InputStream;Lcom/google/protobuf/ExtensionRegistryLite;)Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$CommandToUi;

    return-object v0
.end method

.method public static parseFrom([B)Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$CommandToUi;
    .locals 1
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Lcom/google/protobuf/InvalidProtocolBufferException;
        }
    .end annotation

    .prologue
    .line 2619
    sget-object v0, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$CommandToUi;->PARSER:Lcom/google/protobuf/Parser;

    invoke-interface {v0, p0}, Lcom/google/protobuf/Parser;->parseFrom([B)Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$CommandToUi;

    return-object v0
.end method

.method public static parseFrom([BLcom/google/protobuf/ExtensionRegistryLite;)Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$CommandToUi;
    .locals 1
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Lcom/google/protobuf/InvalidProtocolBufferException;
        }
    .end annotation

    .prologue
    .line 2625
    sget-object v0, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$CommandToUi;->PARSER:Lcom/google/protobuf/Parser;

    invoke-interface {v0, p0, p1}, Lcom/google/protobuf/Parser;->parseFrom([BLcom/google/protobuf/ExtensionRegistryLite;)Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$CommandToUi;

    return-object v0
.end method


# virtual methods
.method public getAlignType()I
    .locals 1

    .prologue
    .line 2225
    iget v0, p0, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$CommandToUi;->alignType_:I

    return v0
.end method

.method public getColor()Ljava/lang/String;
    .locals 2

    .prologue
    .line 2182
    iget-object v0, p0, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$CommandToUi;->color_:Ljava/lang/Object;

    .line 2183
    instance-of v1, v0, Ljava/lang/String;

    if-eqz v1, :cond_0

    .line 2184
    check-cast v0, Ljava/lang/String;

    .line 2192
    :goto_0
    return-object v0

    .line 2186
    :cond_0
    check-cast v0, Lcom/google/protobuf/ByteString;

    .line 2188
    invoke-virtual {v0}, Lcom/google/protobuf/ByteString;->toStringUtf8()Ljava/lang/String;

    move-result-object v1

    .line 2189
    invoke-virtual {v0}, Lcom/google/protobuf/ByteString;->isValidUtf8()Z

    move-result v0

    if-eqz v0, :cond_1

    .line 2190
    iput-object v1, p0, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$CommandToUi;->color_:Ljava/lang/Object;

    :cond_1
    move-object v0, v1

    .line 2192
    goto :goto_0
.end method

.method public getColorBytes()Lcom/google/protobuf/ByteString;
    .locals 2

    .prologue
    .line 2200
    iget-object v0, p0, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$CommandToUi;->color_:Ljava/lang/Object;

    .line 2201
    instance-of v1, v0, Ljava/lang/String;

    if-eqz v1, :cond_0

    .line 2202
    check-cast v0, Ljava/lang/String;

    .line 2203
    invoke-static {v0}, Lcom/google/protobuf/ByteString;->copyFromUtf8(Ljava/lang/String;)Lcom/google/protobuf/ByteString;

    move-result-object v0

    .line 2205
    iput-object v0, p0, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$CommandToUi;->color_:Ljava/lang/Object;

    .line 2208
    :goto_0
    return-object v0

    :cond_0
    check-cast v0, Lcom/google/protobuf/ByteString;

    goto :goto_0
.end method

.method public getCommand()Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$CommandToUi$Command_Type;
    .locals 1

    .prologue
    .line 1793
    iget-object v0, p0, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$CommandToUi;->command_:Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$CommandToUi$Command_Type;

    return-object v0
.end method

.method public getControlId()Ljava/lang/String;
    .locals 2

    .prologue
    .line 1809
    iget-object v0, p0, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$CommandToUi;->controlId_:Ljava/lang/Object;

    .line 1810
    instance-of v1, v0, Ljava/lang/String;

    if-eqz v1, :cond_0

    .line 1811
    check-cast v0, Ljava/lang/String;

    .line 1819
    :goto_0
    return-object v0

    .line 1813
    :cond_0
    check-cast v0, Lcom/google/protobuf/ByteString;

    .line 1815
    invoke-virtual {v0}, Lcom/google/protobuf/ByteString;->toStringUtf8()Ljava/lang/String;

    move-result-object v1

    .line 1816
    invoke-virtual {v0}, Lcom/google/protobuf/ByteString;->isValidUtf8()Z

    move-result v0

    if-eqz v0, :cond_1

    .line 1817
    iput-object v1, p0, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$CommandToUi;->controlId_:Ljava/lang/Object;

    :cond_1
    move-object v0, v1

    .line 1819
    goto :goto_0
.end method

.method public getControlIdBytes()Lcom/google/protobuf/ByteString;
    .locals 2

    .prologue
    .line 1827
    iget-object v0, p0, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$CommandToUi;->controlId_:Ljava/lang/Object;

    .line 1828
    instance-of v1, v0, Ljava/lang/String;

    if-eqz v1, :cond_0

    .line 1829
    check-cast v0, Ljava/lang/String;

    .line 1830
    invoke-static {v0}, Lcom/google/protobuf/ByteString;->copyFromUtf8(Ljava/lang/String;)Lcom/google/protobuf/ByteString;

    move-result-object v0

    .line 1832
    iput-object v0, p0, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$CommandToUi;->controlId_:Ljava/lang/Object;

    .line 1835
    :goto_0
    return-object v0

    :cond_0
    check-cast v0, Lcom/google/protobuf/ByteString;

    goto :goto_0
.end method

.method public getDefaultCheckStatus()Z
    .locals 1

    .prologue
    .line 1986
    iget-boolean v0, p0, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$CommandToUi;->defaultCheckStatus_:Z

    return v0
.end method

.method public getDefaultInstanceForType()Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$CommandToUi;
    .locals 1

    .prologue
    .line 990
    sget-object v0, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$CommandToUi;->defaultInstance:Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$CommandToUi;

    return-object v0
.end method

.method public bridge synthetic getDefaultInstanceForType()Lcom/google/protobuf/Message;
    .locals 1

    .prologue
    .line 974
    invoke-virtual {p0}, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$CommandToUi;->getDefaultInstanceForType()Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$CommandToUi;

    move-result-object v0

    return-object v0
.end method

.method public bridge synthetic getDefaultInstanceForType()Lcom/google/protobuf/MessageLite;
    .locals 1

    .prologue
    .line 974
    invoke-virtual {p0}, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$CommandToUi;->getDefaultInstanceForType()Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$CommandToUi;

    move-result-object v0

    return-object v0
.end method

.method public getDefaultItemIndex()I
    .locals 1

    .prologue
    .line 2048
    iget v0, p0, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$CommandToUi;->defaultItemIndex_:I

    return v0
.end method

.method public getEditInputType()I
    .locals 1

    .prologue
    .line 2318
    iget v0, p0, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$CommandToUi;->editInputType_:I

    return v0
.end method

.method public getEnabledStatus()Z
    .locals 1

    .prologue
    .line 2150
    iget-boolean v0, p0, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$CommandToUi;->enabledStatus_:Z

    return v0
.end method

.method public getFontSize()I
    .locals 1

    .prologue
    .line 2377
    iget v0, p0, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$CommandToUi;->fontSize_:I

    return v0
.end method

.method public getFontType()Ljava/lang/String;
    .locals 2

    .prologue
    .line 2334
    iget-object v0, p0, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$CommandToUi;->fontType_:Ljava/lang/Object;

    .line 2335
    instance-of v1, v0, Ljava/lang/String;

    if-eqz v1, :cond_0

    .line 2336
    check-cast v0, Ljava/lang/String;

    .line 2344
    :goto_0
    return-object v0

    .line 2338
    :cond_0
    check-cast v0, Lcom/google/protobuf/ByteString;

    .line 2340
    invoke-virtual {v0}, Lcom/google/protobuf/ByteString;->toStringUtf8()Ljava/lang/String;

    move-result-object v1

    .line 2341
    invoke-virtual {v0}, Lcom/google/protobuf/ByteString;->isValidUtf8()Z

    move-result v0

    if-eqz v0, :cond_1

    .line 2342
    iput-object v1, p0, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$CommandToUi;->fontType_:Ljava/lang/Object;

    :cond_1
    move-object v0, v1

    .line 2344
    goto :goto_0
.end method

.method public getFontTypeBytes()Lcom/google/protobuf/ByteString;
    .locals 2

    .prologue
    .line 2352
    iget-object v0, p0, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$CommandToUi;->fontType_:Ljava/lang/Object;

    .line 2353
    instance-of v1, v0, Ljava/lang/String;

    if-eqz v1, :cond_0

    .line 2354
    check-cast v0, Ljava/lang/String;

    .line 2355
    invoke-static {v0}, Lcom/google/protobuf/ByteString;->copyFromUtf8(Ljava/lang/String;)Lcom/google/protobuf/ByteString;

    move-result-object v0

    .line 2357
    iput-object v0, p0, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$CommandToUi;->fontType_:Ljava/lang/Object;

    .line 2360
    :goto_0
    return-object v0

    :cond_0
    check-cast v0, Lcom/google/protobuf/ByteString;

    goto :goto_0
.end method

.method public getHeight()I
    .locals 1

    .prologue
    .line 1954
    iget v0, p0, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$CommandToUi;->height_:I

    return v0
.end method

.method public getItemIndex()I
    .locals 1

    .prologue
    .line 2032
    iget v0, p0, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$CommandToUi;->itemIndex_:I

    return v0
.end method

.method public getItemText(I)Ljava/lang/String;
    .locals 1

    .prologue
    .line 2009
    iget-object v0, p0, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$CommandToUi;->itemText_:Lcom/google/protobuf/LazyStringList;

    invoke-interface {v0, p1}, Lcom/google/protobuf/LazyStringList;->get(I)Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Ljava/lang/String;

    return-object v0
.end method

.method public getItemTextBytes(I)Lcom/google/protobuf/ByteString;
    .locals 1

    .prologue
    .line 2016
    iget-object v0, p0, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$CommandToUi;->itemText_:Lcom/google/protobuf/LazyStringList;

    invoke-interface {v0, p1}, Lcom/google/protobuf/LazyStringList;->getByteString(I)Lcom/google/protobuf/ByteString;

    move-result-object v0

    return-object v0
.end method

.method public getItemTextCount()I
    .locals 1

    .prologue
    .line 2003
    iget-object v0, p0, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$CommandToUi;->itemText_:Lcom/google/protobuf/LazyStringList;

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
    .line 1997
    iget-object v0, p0, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$CommandToUi;->itemText_:Lcom/google/protobuf/LazyStringList;

    return-object v0
.end method

.method public getLayoutStyle()I
    .locals 1

    .prologue
    .line 1970
    iget v0, p0, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$CommandToUi;->layoutStyle_:I

    return v0
.end method

.method public getPadding()Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$Padding_Var;
    .locals 1

    .prologue
    .line 2241
    iget-object v0, p0, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$CommandToUi;->padding_:Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$Padding_Var;

    return-object v0
.end method

.method public getPaddingOrBuilder()Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$Padding_VarOrBuilder;
    .locals 1

    .prologue
    .line 2247
    iget-object v0, p0, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$CommandToUi;->padding_:Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$Padding_Var;

    return-object v0
.end method

.method public getParentId()Ljava/lang/String;
    .locals 2

    .prologue
    .line 1852
    iget-object v0, p0, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$CommandToUi;->parentId_:Ljava/lang/Object;

    .line 1853
    instance-of v1, v0, Ljava/lang/String;

    if-eqz v1, :cond_0

    .line 1854
    check-cast v0, Ljava/lang/String;

    .line 1862
    :goto_0
    return-object v0

    .line 1856
    :cond_0
    check-cast v0, Lcom/google/protobuf/ByteString;

    .line 1858
    invoke-virtual {v0}, Lcom/google/protobuf/ByteString;->toStringUtf8()Ljava/lang/String;

    move-result-object v1

    .line 1859
    invoke-virtual {v0}, Lcom/google/protobuf/ByteString;->isValidUtf8()Z

    move-result v0

    if-eqz v0, :cond_1

    .line 1860
    iput-object v1, p0, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$CommandToUi;->parentId_:Ljava/lang/Object;

    :cond_1
    move-object v0, v1

    .line 1862
    goto :goto_0
.end method

.method public getParentIdBytes()Lcom/google/protobuf/ByteString;
    .locals 2

    .prologue
    .line 1870
    iget-object v0, p0, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$CommandToUi;->parentId_:Ljava/lang/Object;

    .line 1871
    instance-of v1, v0, Ljava/lang/String;

    if-eqz v1, :cond_0

    .line 1872
    check-cast v0, Ljava/lang/String;

    .line 1873
    invoke-static {v0}, Lcom/google/protobuf/ByteString;->copyFromUtf8(Ljava/lang/String;)Lcom/google/protobuf/ByteString;

    move-result-object v0

    .line 1875
    iput-object v0, p0, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$CommandToUi;->parentId_:Ljava/lang/Object;

    .line 1878
    :goto_0
    return-object v0

    :cond_0
    check-cast v0, Lcom/google/protobuf/ByteString;

    goto :goto_0
.end method

.method public getParserForType()Lcom/google/protobuf/Parser;
    .locals 1
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "()",
            "Lcom/google/protobuf/Parser",
            "<",
            "Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$CommandToUi;",
            ">;"
        }
    .end annotation

    .prologue
    .line 1188
    sget-object v0, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$CommandToUi;->PARSER:Lcom/google/protobuf/Parser;

    return-object v0
.end method

.method public getPath()Ljava/lang/String;
    .locals 2

    .prologue
    .line 2064
    iget-object v0, p0, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$CommandToUi;->path_:Ljava/lang/Object;

    .line 2065
    instance-of v1, v0, Ljava/lang/String;

    if-eqz v1, :cond_0

    .line 2066
    check-cast v0, Ljava/lang/String;

    .line 2074
    :goto_0
    return-object v0

    .line 2068
    :cond_0
    check-cast v0, Lcom/google/protobuf/ByteString;

    .line 2070
    invoke-virtual {v0}, Lcom/google/protobuf/ByteString;->toStringUtf8()Ljava/lang/String;

    move-result-object v1

    .line 2071
    invoke-virtual {v0}, Lcom/google/protobuf/ByteString;->isValidUtf8()Z

    move-result v0

    if-eqz v0, :cond_1

    .line 2072
    iput-object v1, p0, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$CommandToUi;->path_:Ljava/lang/Object;

    :cond_1
    move-object v0, v1

    .line 2074
    goto :goto_0
.end method

.method public getPathBytes()Lcom/google/protobuf/ByteString;
    .locals 2

    .prologue
    .line 2082
    iget-object v0, p0, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$CommandToUi;->path_:Ljava/lang/Object;

    .line 2083
    instance-of v1, v0, Ljava/lang/String;

    if-eqz v1, :cond_0

    .line 2084
    check-cast v0, Ljava/lang/String;

    .line 2085
    invoke-static {v0}, Lcom/google/protobuf/ByteString;->copyFromUtf8(Ljava/lang/String;)Lcom/google/protobuf/ByteString;

    move-result-object v0

    .line 2087
    iput-object v0, p0, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$CommandToUi;->path_:Ljava/lang/Object;

    .line 2090
    :goto_0
    return-object v0

    :cond_0
    check-cast v0, Lcom/google/protobuf/ByteString;

    goto :goto_0
.end method

.method public getSerializedSize()I
    .locals 7

    .prologue
    const/16 v6, 0x8

    const/4 v5, 0x4

    const/4 v4, 0x2

    const/4 v3, 0x1

    const/4 v1, 0x0

    .line 2497
    iget v0, p0, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$CommandToUi;->memoizedSerializedSize:I

    .line 2498
    const/4 v2, -0x1

    if-eq v0, v2, :cond_0

    .line 2596
    :goto_0
    return v0

    .line 2501
    :cond_0
    iget v0, p0, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$CommandToUi;->bitField0_:I

    and-int/lit8 v0, v0, 0x1

    if-ne v0, v3, :cond_16

    .line 2502
    iget-object v0, p0, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$CommandToUi;->command_:Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$CommandToUi$Command_Type;

    .line 2503
    invoke-virtual {v0}, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$CommandToUi$Command_Type;->getNumber()I

    move-result v0

    invoke-static {v3, v0}, Lcom/google/protobuf/CodedOutputStream;->computeEnumSize(II)I

    move-result v0

    add-int/2addr v0, v1

    .line 2505
    :goto_1
    iget v2, p0, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$CommandToUi;->bitField0_:I

    and-int/lit8 v2, v2, 0x2

    if-ne v2, v4, :cond_1

    .line 2507
    invoke-virtual {p0}, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$CommandToUi;->getControlIdBytes()Lcom/google/protobuf/ByteString;

    move-result-object v2

    invoke-static {v4, v2}, Lcom/google/protobuf/CodedOutputStream;->computeBytesSize(ILcom/google/protobuf/ByteString;)I

    move-result v2

    add-int/2addr v0, v2

    .line 2509
    :cond_1
    iget v2, p0, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$CommandToUi;->bitField0_:I

    and-int/lit8 v2, v2, 0x4

    if-ne v2, v5, :cond_2

    .line 2510
    const/4 v2, 0x3

    .line 2511
    invoke-virtual {p0}, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$CommandToUi;->getParentIdBytes()Lcom/google/protobuf/ByteString;

    move-result-object v3

    invoke-static {v2, v3}, Lcom/google/protobuf/CodedOutputStream;->computeBytesSize(ILcom/google/protobuf/ByteString;)I

    move-result v2

    add-int/2addr v0, v2

    .line 2513
    :cond_2
    iget v2, p0, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$CommandToUi;->bitField0_:I

    and-int/lit8 v2, v2, 0x8

    if-ne v2, v6, :cond_3

    .line 2515
    invoke-virtual {p0}, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$CommandToUi;->getTextBytes()Lcom/google/protobuf/ByteString;

    move-result-object v2

    invoke-static {v5, v2}, Lcom/google/protobuf/CodedOutputStream;->computeBytesSize(ILcom/google/protobuf/ByteString;)I

    move-result v2

    add-int/2addr v0, v2

    .line 2517
    :cond_3
    iget v2, p0, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$CommandToUi;->bitField0_:I

    and-int/lit8 v2, v2, 0x10

    const/16 v3, 0x10

    if-ne v2, v3, :cond_4

    .line 2518
    const/4 v2, 0x5

    iget v3, p0, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$CommandToUi;->width_:I

    .line 2519
    invoke-static {v2, v3}, Lcom/google/protobuf/CodedOutputStream;->computeInt32Size(II)I

    move-result v2

    add-int/2addr v0, v2

    .line 2521
    :cond_4
    iget v2, p0, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$CommandToUi;->bitField0_:I

    and-int/lit8 v2, v2, 0x20

    const/16 v3, 0x20

    if-ne v2, v3, :cond_5

    .line 2522
    const/4 v2, 0x6

    iget v3, p0, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$CommandToUi;->height_:I

    .line 2523
    invoke-static {v2, v3}, Lcom/google/protobuf/CodedOutputStream;->computeInt32Size(II)I

    move-result v2

    add-int/2addr v0, v2

    .line 2525
    :cond_5
    iget v2, p0, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$CommandToUi;->bitField0_:I

    and-int/lit8 v2, v2, 0x40

    const/16 v3, 0x40

    if-ne v2, v3, :cond_6

    .line 2526
    const/4 v2, 0x7

    iget v3, p0, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$CommandToUi;->layoutStyle_:I

    .line 2527
    invoke-static {v2, v3}, Lcom/google/protobuf/CodedOutputStream;->computeInt32Size(II)I

    move-result v2

    add-int/2addr v0, v2

    .line 2529
    :cond_6
    iget v2, p0, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$CommandToUi;->bitField0_:I

    and-int/lit16 v2, v2, 0x80

    const/16 v3, 0x80

    if-ne v2, v3, :cond_7

    .line 2530
    iget-boolean v2, p0, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$CommandToUi;->defaultCheckStatus_:Z

    .line 2531
    invoke-static {v6, v2}, Lcom/google/protobuf/CodedOutputStream;->computeBoolSize(IZ)I

    move-result v2

    add-int/2addr v0, v2

    :cond_7
    move v2, v1

    .line 2535
    :goto_2
    iget-object v3, p0, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$CommandToUi;->itemText_:Lcom/google/protobuf/LazyStringList;

    invoke-interface {v3}, Lcom/google/protobuf/LazyStringList;->size()I

    move-result v3

    if-ge v1, v3, :cond_8

    .line 2536
    iget-object v3, p0, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$CommandToUi;->itemText_:Lcom/google/protobuf/LazyStringList;

    .line 2537
    invoke-interface {v3, v1}, Lcom/google/protobuf/LazyStringList;->getByteString(I)Lcom/google/protobuf/ByteString;

    move-result-object v3

    invoke-static {v3}, Lcom/google/protobuf/CodedOutputStream;->computeBytesSizeNoTag(Lcom/google/protobuf/ByteString;)I

    move-result v3

    add-int/2addr v2, v3

    .line 2535
    add-int/lit8 v1, v1, 0x1

    goto :goto_2

    .line 2539
    :cond_8
    add-int/2addr v0, v2

    .line 2540
    invoke-virtual {p0}, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$CommandToUi;->getItemTextList()Ljava/util/List;

    move-result-object v1

    invoke-interface {v1}, Ljava/util/List;->size()I

    move-result v1

    mul-int/lit8 v1, v1, 0x1

    add-int/2addr v0, v1

    .line 2542
    iget v1, p0, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$CommandToUi;->bitField0_:I

    and-int/lit16 v1, v1, 0x100

    const/16 v2, 0x100

    if-ne v1, v2, :cond_9

    .line 2543
    const/16 v1, 0xa

    iget v2, p0, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$CommandToUi;->itemIndex_:I

    .line 2544
    invoke-static {v1, v2}, Lcom/google/protobuf/CodedOutputStream;->computeInt32Size(II)I

    move-result v1

    add-int/2addr v0, v1

    .line 2546
    :cond_9
    iget v1, p0, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$CommandToUi;->bitField0_:I

    and-int/lit16 v1, v1, 0x200

    const/16 v2, 0x200

    if-ne v1, v2, :cond_a

    .line 2547
    const/16 v1, 0xb

    iget v2, p0, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$CommandToUi;->defaultItemIndex_:I

    .line 2548
    invoke-static {v1, v2}, Lcom/google/protobuf/CodedOutputStream;->computeInt32Size(II)I

    move-result v1

    add-int/2addr v0, v1

    .line 2550
    :cond_a
    iget v1, p0, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$CommandToUi;->bitField0_:I

    and-int/lit16 v1, v1, 0x400

    const/16 v2, 0x400

    if-ne v1, v2, :cond_b

    .line 2551
    const/16 v1, 0xc

    .line 2552
    invoke-virtual {p0}, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$CommandToUi;->getPathBytes()Lcom/google/protobuf/ByteString;

    move-result-object v2

    invoke-static {v1, v2}, Lcom/google/protobuf/CodedOutputStream;->computeBytesSize(ILcom/google/protobuf/ByteString;)I

    move-result v1

    add-int/2addr v0, v1

    .line 2554
    :cond_b
    iget v1, p0, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$CommandToUi;->bitField0_:I

    and-int/lit16 v1, v1, 0x800

    const/16 v2, 0x800

    if-ne v1, v2, :cond_c

    .line 2555
    const/16 v1, 0xd

    .line 2556
    invoke-virtual {p0}, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$CommandToUi;->getUrlBytes()Lcom/google/protobuf/ByteString;

    move-result-object v2

    invoke-static {v1, v2}, Lcom/google/protobuf/CodedOutputStream;->computeBytesSize(ILcom/google/protobuf/ByteString;)I

    move-result v1

    add-int/2addr v0, v1

    .line 2558
    :cond_c
    iget v1, p0, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$CommandToUi;->bitField0_:I

    and-int/lit16 v1, v1, 0x1000

    const/16 v2, 0x1000

    if-ne v1, v2, :cond_d

    .line 2559
    const/16 v1, 0xe

    iget-boolean v2, p0, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$CommandToUi;->enabledStatus_:Z

    .line 2560
    invoke-static {v1, v2}, Lcom/google/protobuf/CodedOutputStream;->computeBoolSize(IZ)I

    move-result v1

    add-int/2addr v0, v1

    .line 2562
    :cond_d
    iget v1, p0, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$CommandToUi;->bitField0_:I

    and-int/lit16 v1, v1, 0x2000

    const/16 v2, 0x2000

    if-ne v1, v2, :cond_e

    .line 2563
    const/16 v1, 0xf

    iget v2, p0, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$CommandToUi;->visibleStatus_:I

    .line 2564
    invoke-static {v1, v2}, Lcom/google/protobuf/CodedOutputStream;->computeInt32Size(II)I

    move-result v1

    add-int/2addr v0, v1

    .line 2566
    :cond_e
    iget v1, p0, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$CommandToUi;->bitField0_:I

    and-int/lit16 v1, v1, 0x4000

    const/16 v2, 0x4000

    if-ne v1, v2, :cond_f

    .line 2567
    const/16 v1, 0x10

    .line 2568
    invoke-virtual {p0}, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$CommandToUi;->getColorBytes()Lcom/google/protobuf/ByteString;

    move-result-object v2

    invoke-static {v1, v2}, Lcom/google/protobuf/CodedOutputStream;->computeBytesSize(ILcom/google/protobuf/ByteString;)I

    move-result v1

    add-int/2addr v0, v1

    .line 2570
    :cond_f
    iget v1, p0, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$CommandToUi;->bitField0_:I

    const v2, 0x8000

    and-int/2addr v1, v2

    const v2, 0x8000

    if-ne v1, v2, :cond_10

    .line 2571
    const/16 v1, 0x11

    iget v2, p0, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$CommandToUi;->alignType_:I

    .line 2572
    invoke-static {v1, v2}, Lcom/google/protobuf/CodedOutputStream;->computeInt32Size(II)I

    move-result v1

    add-int/2addr v0, v1

    .line 2574
    :cond_10
    iget v1, p0, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$CommandToUi;->bitField0_:I

    const/high16 v2, 0x10000

    and-int/2addr v1, v2

    const/high16 v2, 0x10000

    if-ne v1, v2, :cond_11

    .line 2575
    const/16 v1, 0x12

    iget-object v2, p0, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$CommandToUi;->padding_:Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$Padding_Var;

    .line 2576
    invoke-static {v1, v2}, Lcom/google/protobuf/CodedOutputStream;->computeMessageSize(ILcom/google/protobuf/MessageLite;)I

    move-result v1

    add-int/2addr v0, v1

    .line 2578
    :cond_11
    iget v1, p0, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$CommandToUi;->bitField0_:I

    const/high16 v2, 0x20000

    and-int/2addr v1, v2

    const/high16 v2, 0x20000

    if-ne v1, v2, :cond_12

    .line 2579
    const/16 v1, 0x13

    .line 2580
    invoke-virtual {p0}, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$CommandToUi;->getUipDataBytes()Lcom/google/protobuf/ByteString;

    move-result-object v2

    invoke-static {v1, v2}, Lcom/google/protobuf/CodedOutputStream;->computeBytesSize(ILcom/google/protobuf/ByteString;)I

    move-result v1

    add-int/2addr v0, v1

    .line 2582
    :cond_12
    iget v1, p0, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$CommandToUi;->bitField0_:I

    const/high16 v2, 0x40000

    and-int/2addr v1, v2

    const/high16 v2, 0x40000

    if-ne v1, v2, :cond_13

    .line 2583
    const/16 v1, 0x14

    iget v2, p0, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$CommandToUi;->editInputType_:I

    .line 2584
    invoke-static {v1, v2}, Lcom/google/protobuf/CodedOutputStream;->computeInt32Size(II)I

    move-result v1

    add-int/2addr v0, v1

    .line 2586
    :cond_13
    iget v1, p0, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$CommandToUi;->bitField0_:I

    const/high16 v2, 0x80000

    and-int/2addr v1, v2

    const/high16 v2, 0x80000

    if-ne v1, v2, :cond_14

    .line 2587
    const/16 v1, 0x15

    .line 2588
    invoke-virtual {p0}, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$CommandToUi;->getFontTypeBytes()Lcom/google/protobuf/ByteString;

    move-result-object v2

    invoke-static {v1, v2}, Lcom/google/protobuf/CodedOutputStream;->computeBytesSize(ILcom/google/protobuf/ByteString;)I

    move-result v1

    add-int/2addr v0, v1

    .line 2590
    :cond_14
    iget v1, p0, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$CommandToUi;->bitField0_:I

    const/high16 v2, 0x100000

    and-int/2addr v1, v2

    const/high16 v2, 0x100000

    if-ne v1, v2, :cond_15

    .line 2591
    const/16 v1, 0x16

    iget v2, p0, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$CommandToUi;->fontSize_:I

    .line 2592
    invoke-static {v1, v2}, Lcom/google/protobuf/CodedOutputStream;->computeInt32Size(II)I

    move-result v1

    add-int/2addr v0, v1

    .line 2594
    :cond_15
    invoke-virtual {p0}, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$CommandToUi;->getUnknownFields()Lcom/google/protobuf/UnknownFieldSet;

    move-result-object v1

    invoke-virtual {v1}, Lcom/google/protobuf/UnknownFieldSet;->getSerializedSize()I

    move-result v1

    add-int/2addr v0, v1

    .line 2595
    iput v0, p0, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$CommandToUi;->memoizedSerializedSize:I

    goto/16 :goto_0

    :cond_16
    move v0, v1

    goto/16 :goto_1
.end method

.method public getText()Ljava/lang/String;
    .locals 2

    .prologue
    .line 1895
    iget-object v0, p0, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$CommandToUi;->text_:Ljava/lang/Object;

    .line 1896
    instance-of v1, v0, Ljava/lang/String;

    if-eqz v1, :cond_0

    .line 1897
    check-cast v0, Ljava/lang/String;

    .line 1905
    :goto_0
    return-object v0

    .line 1899
    :cond_0
    check-cast v0, Lcom/google/protobuf/ByteString;

    .line 1901
    invoke-virtual {v0}, Lcom/google/protobuf/ByteString;->toStringUtf8()Ljava/lang/String;

    move-result-object v1

    .line 1902
    invoke-virtual {v0}, Lcom/google/protobuf/ByteString;->isValidUtf8()Z

    move-result v0

    if-eqz v0, :cond_1

    .line 1903
    iput-object v1, p0, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$CommandToUi;->text_:Ljava/lang/Object;

    :cond_1
    move-object v0, v1

    .line 1905
    goto :goto_0
.end method

.method public getTextBytes()Lcom/google/protobuf/ByteString;
    .locals 2

    .prologue
    .line 1913
    iget-object v0, p0, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$CommandToUi;->text_:Ljava/lang/Object;

    .line 1914
    instance-of v1, v0, Ljava/lang/String;

    if-eqz v1, :cond_0

    .line 1915
    check-cast v0, Ljava/lang/String;

    .line 1916
    invoke-static {v0}, Lcom/google/protobuf/ByteString;->copyFromUtf8(Ljava/lang/String;)Lcom/google/protobuf/ByteString;

    move-result-object v0

    .line 1918
    iput-object v0, p0, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$CommandToUi;->text_:Ljava/lang/Object;

    .line 1921
    :goto_0
    return-object v0

    :cond_0
    check-cast v0, Lcom/google/protobuf/ByteString;

    goto :goto_0
.end method

.method public getUipData()Ljava/lang/String;
    .locals 2

    .prologue
    .line 2271
    iget-object v0, p0, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$CommandToUi;->uipData_:Ljava/lang/Object;

    .line 2272
    instance-of v1, v0, Ljava/lang/String;

    if-eqz v1, :cond_0

    .line 2273
    check-cast v0, Ljava/lang/String;

    .line 2281
    :goto_0
    return-object v0

    .line 2275
    :cond_0
    check-cast v0, Lcom/google/protobuf/ByteString;

    .line 2277
    invoke-virtual {v0}, Lcom/google/protobuf/ByteString;->toStringUtf8()Ljava/lang/String;

    move-result-object v1

    .line 2278
    invoke-virtual {v0}, Lcom/google/protobuf/ByteString;->isValidUtf8()Z

    move-result v0

    if-eqz v0, :cond_1

    .line 2279
    iput-object v1, p0, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$CommandToUi;->uipData_:Ljava/lang/Object;

    :cond_1
    move-object v0, v1

    .line 2281
    goto :goto_0
.end method

.method public getUipDataBytes()Lcom/google/protobuf/ByteString;
    .locals 2

    .prologue
    .line 2293
    iget-object v0, p0, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$CommandToUi;->uipData_:Ljava/lang/Object;

    .line 2294
    instance-of v1, v0, Ljava/lang/String;

    if-eqz v1, :cond_0

    .line 2295
    check-cast v0, Ljava/lang/String;

    .line 2296
    invoke-static {v0}, Lcom/google/protobuf/ByteString;->copyFromUtf8(Ljava/lang/String;)Lcom/google/protobuf/ByteString;

    move-result-object v0

    .line 2298
    iput-object v0, p0, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$CommandToUi;->uipData_:Ljava/lang/Object;

    .line 2301
    :goto_0
    return-object v0

    :cond_0
    check-cast v0, Lcom/google/protobuf/ByteString;

    goto :goto_0
.end method

.method public final getUnknownFields()Lcom/google/protobuf/UnknownFieldSet;
    .locals 1

    .prologue
    .line 997
    iget-object v0, p0, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$CommandToUi;->unknownFields:Lcom/google/protobuf/UnknownFieldSet;

    return-object v0
.end method

.method public getUrl()Ljava/lang/String;
    .locals 2

    .prologue
    .line 2107
    iget-object v0, p0, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$CommandToUi;->url_:Ljava/lang/Object;

    .line 2108
    instance-of v1, v0, Ljava/lang/String;

    if-eqz v1, :cond_0

    .line 2109
    check-cast v0, Ljava/lang/String;

    .line 2117
    :goto_0
    return-object v0

    .line 2111
    :cond_0
    check-cast v0, Lcom/google/protobuf/ByteString;

    .line 2113
    invoke-virtual {v0}, Lcom/google/protobuf/ByteString;->toStringUtf8()Ljava/lang/String;

    move-result-object v1

    .line 2114
    invoke-virtual {v0}, Lcom/google/protobuf/ByteString;->isValidUtf8()Z

    move-result v0

    if-eqz v0, :cond_1

    .line 2115
    iput-object v1, p0, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$CommandToUi;->url_:Ljava/lang/Object;

    :cond_1
    move-object v0, v1

    .line 2117
    goto :goto_0
.end method

.method public getUrlBytes()Lcom/google/protobuf/ByteString;
    .locals 2

    .prologue
    .line 2125
    iget-object v0, p0, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$CommandToUi;->url_:Ljava/lang/Object;

    .line 2126
    instance-of v1, v0, Ljava/lang/String;

    if-eqz v1, :cond_0

    .line 2127
    check-cast v0, Ljava/lang/String;

    .line 2128
    invoke-static {v0}, Lcom/google/protobuf/ByteString;->copyFromUtf8(Ljava/lang/String;)Lcom/google/protobuf/ByteString;

    move-result-object v0

    .line 2130
    iput-object v0, p0, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$CommandToUi;->url_:Ljava/lang/Object;

    .line 2133
    :goto_0
    return-object v0

    :cond_0
    check-cast v0, Lcom/google/protobuf/ByteString;

    goto :goto_0
.end method

.method public getVisibleStatus()I
    .locals 1

    .prologue
    .line 2166
    iget v0, p0, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$CommandToUi;->visibleStatus_:I

    return v0
.end method

.method public getWidth()I
    .locals 1

    .prologue
    .line 1938
    iget v0, p0, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$CommandToUi;->width_:I

    return v0
.end method

.method public hasAlignType()Z
    .locals 2

    .prologue
    const v1, 0x8000

    .line 2219
    iget v0, p0, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$CommandToUi;->bitField0_:I

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
    .line 2176
    iget v0, p0, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$CommandToUi;->bitField0_:I

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

.method public hasCommand()Z
    .locals 2

    .prologue
    const/4 v0, 0x1

    .line 1787
    iget v1, p0, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$CommandToUi;->bitField0_:I

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
    .line 1803
    iget v0, p0, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$CommandToUi;->bitField0_:I

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
    .line 1980
    iget v0, p0, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$CommandToUi;->bitField0_:I

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
    .line 2042
    iget v0, p0, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$CommandToUi;->bitField0_:I

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

.method public hasEditInputType()Z
    .locals 2

    .prologue
    const/high16 v1, 0x40000

    .line 2312
    iget v0, p0, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$CommandToUi;->bitField0_:I

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
    .line 2144
    iget v0, p0, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$CommandToUi;->bitField0_:I

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

.method public hasFontSize()Z
    .locals 2

    .prologue
    const/high16 v1, 0x100000

    .line 2371
    iget v0, p0, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$CommandToUi;->bitField0_:I

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
    const/high16 v1, 0x80000

    .line 2328
    iget v0, p0, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$CommandToUi;->bitField0_:I

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
    .line 1948
    iget v0, p0, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$CommandToUi;->bitField0_:I

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
    .line 2026
    iget v0, p0, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$CommandToUi;->bitField0_:I

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

.method public hasLayoutStyle()Z
    .locals 2

    .prologue
    .line 1964
    iget v0, p0, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$CommandToUi;->bitField0_:I

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
    const/high16 v1, 0x10000

    .line 2235
    iget v0, p0, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$CommandToUi;->bitField0_:I

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
    .line 1846
    iget v0, p0, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$CommandToUi;->bitField0_:I

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
    .line 2058
    iget v0, p0, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$CommandToUi;->bitField0_:I

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

.method public hasText()Z
    .locals 2

    .prologue
    .line 1889
    iget v0, p0, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$CommandToUi;->bitField0_:I

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
    const/high16 v1, 0x20000

    .line 2261
    iget v0, p0, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$CommandToUi;->bitField0_:I

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
    .line 2101
    iget v0, p0, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$CommandToUi;->bitField0_:I

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

.method public hasVisibleStatus()Z
    .locals 2

    .prologue
    .line 2160
    iget v0, p0, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$CommandToUi;->bitField0_:I

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

.method public hasWidth()Z
    .locals 2

    .prologue
    .line 1932
    iget v0, p0, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$CommandToUi;->bitField0_:I

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
    .line 1171
    invoke-static {}, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage;->e()Lcom/google/protobuf/GeneratedMessage$FieldAccessorTable;

    move-result-object v0

    const-class v1, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$CommandToUi;

    const-class v2, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$CommandToUi$Builder;

    .line 1172
    invoke-virtual {v0, v1, v2}, Lcom/google/protobuf/GeneratedMessage$FieldAccessorTable;->ensureFieldAccessorsInitialized(Ljava/lang/Class;Ljava/lang/Class;)Lcom/google/protobuf/GeneratedMessage$FieldAccessorTable;

    move-result-object v0

    .line 1171
    return-object v0
.end method

.method public final isInitialized()Z
    .locals 4

    .prologue
    const/4 v0, 0x1

    const/4 v1, 0x0

    .line 2406
    iget-byte v2, p0, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$CommandToUi;->memoizedIsInitialized:B

    .line 2407
    const/4 v3, -0x1

    if-eq v2, v3, :cond_1

    if-ne v2, v0, :cond_0

    .line 2420
    :goto_0
    return v0

    :cond_0
    move v0, v1

    .line 2407
    goto :goto_0

    .line 2409
    :cond_1
    invoke-virtual {p0}, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$CommandToUi;->hasCommand()Z

    move-result v2

    if-nez v2, :cond_2

    .line 2410
    iput-byte v1, p0, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$CommandToUi;->memoizedIsInitialized:B

    move v0, v1

    .line 2411
    goto :goto_0

    .line 2413
    :cond_2
    invoke-virtual {p0}, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$CommandToUi;->hasPadding()Z

    move-result v2

    if-eqz v2, :cond_3

    .line 2414
    invoke-virtual {p0}, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$CommandToUi;->getPadding()Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$Padding_Var;

    move-result-object v2

    invoke-virtual {v2}, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$Padding_Var;->isInitialized()Z

    move-result v2

    if-nez v2, :cond_3

    .line 2415
    iput-byte v1, p0, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$CommandToUi;->memoizedIsInitialized:B

    move v0, v1

    .line 2416
    goto :goto_0

    .line 2419
    :cond_3
    iput-byte v0, p0, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$CommandToUi;->memoizedIsInitialized:B

    goto :goto_0
.end method

.method public newBuilderForType()Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$CommandToUi$Builder;
    .locals 1

    .prologue
    .line 2660
    invoke-static {}, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$CommandToUi;->newBuilder()Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$CommandToUi$Builder;

    move-result-object v0

    return-object v0
.end method

.method protected newBuilderForType(Lcom/google/protobuf/GeneratedMessage$BuilderParent;)Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$CommandToUi$Builder;
    .locals 2

    .prologue
    .line 2669
    new-instance v0, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$CommandToUi$Builder;

    const/4 v1, 0x0

    invoke-direct {v0, p1, v1}, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$CommandToUi$Builder;-><init>(Lcom/google/protobuf/GeneratedMessage$BuilderParent;Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$1;)V

    .line 2670
    return-object v0
.end method

.method public bridge synthetic newBuilderForType()Lcom/google/protobuf/Message$Builder;
    .locals 1

    .prologue
    .line 974
    invoke-virtual {p0}, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$CommandToUi;->newBuilderForType()Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$CommandToUi$Builder;

    move-result-object v0

    return-object v0
.end method

.method protected bridge synthetic newBuilderForType(Lcom/google/protobuf/GeneratedMessage$BuilderParent;)Lcom/google/protobuf/Message$Builder;
    .locals 1

    .prologue
    .line 974
    invoke-virtual {p0, p1}, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$CommandToUi;->newBuilderForType(Lcom/google/protobuf/GeneratedMessage$BuilderParent;)Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$CommandToUi$Builder;

    move-result-object v0

    return-object v0
.end method

.method public bridge synthetic newBuilderForType()Lcom/google/protobuf/MessageLite$Builder;
    .locals 1

    .prologue
    .line 974
    invoke-virtual {p0}, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$CommandToUi;->newBuilderForType()Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$CommandToUi$Builder;

    move-result-object v0

    return-object v0
.end method

.method public toBuilder()Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$CommandToUi$Builder;
    .locals 1

    .prologue
    .line 2664
    invoke-static {p0}, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$CommandToUi;->newBuilder(Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$CommandToUi;)Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$CommandToUi$Builder;

    move-result-object v0

    return-object v0
.end method

.method public bridge synthetic toBuilder()Lcom/google/protobuf/Message$Builder;
    .locals 1

    .prologue
    .line 974
    invoke-virtual {p0}, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$CommandToUi;->toBuilder()Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$CommandToUi$Builder;

    move-result-object v0

    return-object v0
.end method

.method public bridge synthetic toBuilder()Lcom/google/protobuf/MessageLite$Builder;
    .locals 1

    .prologue
    .line 974
    invoke-virtual {p0}, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$CommandToUi;->toBuilder()Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$CommandToUi$Builder;

    move-result-object v0

    return-object v0
.end method

.method protected writeReplace()Ljava/lang/Object;
    .locals 1
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljava/io/ObjectStreamException;
        }
    .end annotation

    .prologue
    .line 2603
    invoke-super {p0}, Lcom/google/protobuf/GeneratedMessage;->writeReplace()Ljava/lang/Object;

    move-result-object v0

    return-object v0
.end method

.method public writeTo(Lcom/google/protobuf/CodedOutputStream;)V
    .locals 6
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljava/io/IOException;
        }
    .end annotation

    .prologue
    const/16 v5, 0x10

    const/16 v4, 0x8

    const/4 v3, 0x4

    const/4 v2, 0x2

    const/4 v1, 0x1

    .line 2425
    invoke-virtual {p0}, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$CommandToUi;->getSerializedSize()I

    .line 2426
    iget v0, p0, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$CommandToUi;->bitField0_:I

    and-int/lit8 v0, v0, 0x1

    if-ne v0, v1, :cond_0

    .line 2427
    iget-object v0, p0, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$CommandToUi;->command_:Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$CommandToUi$Command_Type;

    invoke-virtual {v0}, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$CommandToUi$Command_Type;->getNumber()I

    move-result v0

    invoke-virtual {p1, v1, v0}, Lcom/google/protobuf/CodedOutputStream;->writeEnum(II)V

    .line 2429
    :cond_0
    iget v0, p0, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$CommandToUi;->bitField0_:I

    and-int/lit8 v0, v0, 0x2

    if-ne v0, v2, :cond_1

    .line 2430
    invoke-virtual {p0}, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$CommandToUi;->getControlIdBytes()Lcom/google/protobuf/ByteString;

    move-result-object v0

    invoke-virtual {p1, v2, v0}, Lcom/google/protobuf/CodedOutputStream;->writeBytes(ILcom/google/protobuf/ByteString;)V

    .line 2432
    :cond_1
    iget v0, p0, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$CommandToUi;->bitField0_:I

    and-int/lit8 v0, v0, 0x4

    if-ne v0, v3, :cond_2

    .line 2433
    const/4 v0, 0x3

    invoke-virtual {p0}, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$CommandToUi;->getParentIdBytes()Lcom/google/protobuf/ByteString;

    move-result-object v1

    invoke-virtual {p1, v0, v1}, Lcom/google/protobuf/CodedOutputStream;->writeBytes(ILcom/google/protobuf/ByteString;)V

    .line 2435
    :cond_2
    iget v0, p0, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$CommandToUi;->bitField0_:I

    and-int/lit8 v0, v0, 0x8

    if-ne v0, v4, :cond_3

    .line 2436
    invoke-virtual {p0}, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$CommandToUi;->getTextBytes()Lcom/google/protobuf/ByteString;

    move-result-object v0

    invoke-virtual {p1, v3, v0}, Lcom/google/protobuf/CodedOutputStream;->writeBytes(ILcom/google/protobuf/ByteString;)V

    .line 2438
    :cond_3
    iget v0, p0, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$CommandToUi;->bitField0_:I

    and-int/lit8 v0, v0, 0x10

    if-ne v0, v5, :cond_4

    .line 2439
    const/4 v0, 0x5

    iget v1, p0, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$CommandToUi;->width_:I

    invoke-virtual {p1, v0, v1}, Lcom/google/protobuf/CodedOutputStream;->writeInt32(II)V

    .line 2441
    :cond_4
    iget v0, p0, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$CommandToUi;->bitField0_:I

    and-int/lit8 v0, v0, 0x20

    const/16 v1, 0x20

    if-ne v0, v1, :cond_5

    .line 2442
    const/4 v0, 0x6

    iget v1, p0, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$CommandToUi;->height_:I

    invoke-virtual {p1, v0, v1}, Lcom/google/protobuf/CodedOutputStream;->writeInt32(II)V

    .line 2444
    :cond_5
    iget v0, p0, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$CommandToUi;->bitField0_:I

    and-int/lit8 v0, v0, 0x40

    const/16 v1, 0x40

    if-ne v0, v1, :cond_6

    .line 2445
    const/4 v0, 0x7

    iget v1, p0, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$CommandToUi;->layoutStyle_:I

    invoke-virtual {p1, v0, v1}, Lcom/google/protobuf/CodedOutputStream;->writeInt32(II)V

    .line 2447
    :cond_6
    iget v0, p0, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$CommandToUi;->bitField0_:I

    and-int/lit16 v0, v0, 0x80

    const/16 v1, 0x80

    if-ne v0, v1, :cond_7

    .line 2448
    iget-boolean v0, p0, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$CommandToUi;->defaultCheckStatus_:Z

    invoke-virtual {p1, v4, v0}, Lcom/google/protobuf/CodedOutputStream;->writeBool(IZ)V

    .line 2450
    :cond_7
    const/4 v0, 0x0

    :goto_0
    iget-object v1, p0, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$CommandToUi;->itemText_:Lcom/google/protobuf/LazyStringList;

    invoke-interface {v1}, Lcom/google/protobuf/LazyStringList;->size()I

    move-result v1

    if-ge v0, v1, :cond_8

    .line 2451
    const/16 v1, 0x9

    iget-object v2, p0, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$CommandToUi;->itemText_:Lcom/google/protobuf/LazyStringList;

    invoke-interface {v2, v0}, Lcom/google/protobuf/LazyStringList;->getByteString(I)Lcom/google/protobuf/ByteString;

    move-result-object v2

    invoke-virtual {p1, v1, v2}, Lcom/google/protobuf/CodedOutputStream;->writeBytes(ILcom/google/protobuf/ByteString;)V

    .line 2450
    add-int/lit8 v0, v0, 0x1

    goto :goto_0

    .line 2453
    :cond_8
    iget v0, p0, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$CommandToUi;->bitField0_:I

    and-int/lit16 v0, v0, 0x100

    const/16 v1, 0x100

    if-ne v0, v1, :cond_9

    .line 2454
    const/16 v0, 0xa

    iget v1, p0, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$CommandToUi;->itemIndex_:I

    invoke-virtual {p1, v0, v1}, Lcom/google/protobuf/CodedOutputStream;->writeInt32(II)V

    .line 2456
    :cond_9
    iget v0, p0, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$CommandToUi;->bitField0_:I

    and-int/lit16 v0, v0, 0x200

    const/16 v1, 0x200

    if-ne v0, v1, :cond_a

    .line 2457
    const/16 v0, 0xb

    iget v1, p0, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$CommandToUi;->defaultItemIndex_:I

    invoke-virtual {p1, v0, v1}, Lcom/google/protobuf/CodedOutputStream;->writeInt32(II)V

    .line 2459
    :cond_a
    iget v0, p0, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$CommandToUi;->bitField0_:I

    and-int/lit16 v0, v0, 0x400

    const/16 v1, 0x400

    if-ne v0, v1, :cond_b

    .line 2460
    const/16 v0, 0xc

    invoke-virtual {p0}, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$CommandToUi;->getPathBytes()Lcom/google/protobuf/ByteString;

    move-result-object v1

    invoke-virtual {p1, v0, v1}, Lcom/google/protobuf/CodedOutputStream;->writeBytes(ILcom/google/protobuf/ByteString;)V

    .line 2462
    :cond_b
    iget v0, p0, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$CommandToUi;->bitField0_:I

    and-int/lit16 v0, v0, 0x800

    const/16 v1, 0x800

    if-ne v0, v1, :cond_c

    .line 2463
    const/16 v0, 0xd

    invoke-virtual {p0}, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$CommandToUi;->getUrlBytes()Lcom/google/protobuf/ByteString;

    move-result-object v1

    invoke-virtual {p1, v0, v1}, Lcom/google/protobuf/CodedOutputStream;->writeBytes(ILcom/google/protobuf/ByteString;)V

    .line 2465
    :cond_c
    iget v0, p0, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$CommandToUi;->bitField0_:I

    and-int/lit16 v0, v0, 0x1000

    const/16 v1, 0x1000

    if-ne v0, v1, :cond_d

    .line 2466
    const/16 v0, 0xe

    iget-boolean v1, p0, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$CommandToUi;->enabledStatus_:Z

    invoke-virtual {p1, v0, v1}, Lcom/google/protobuf/CodedOutputStream;->writeBool(IZ)V

    .line 2468
    :cond_d
    iget v0, p0, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$CommandToUi;->bitField0_:I

    and-int/lit16 v0, v0, 0x2000

    const/16 v1, 0x2000

    if-ne v0, v1, :cond_e

    .line 2469
    const/16 v0, 0xf

    iget v1, p0, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$CommandToUi;->visibleStatus_:I

    invoke-virtual {p1, v0, v1}, Lcom/google/protobuf/CodedOutputStream;->writeInt32(II)V

    .line 2471
    :cond_e
    iget v0, p0, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$CommandToUi;->bitField0_:I

    and-int/lit16 v0, v0, 0x4000

    const/16 v1, 0x4000

    if-ne v0, v1, :cond_f

    .line 2472
    invoke-virtual {p0}, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$CommandToUi;->getColorBytes()Lcom/google/protobuf/ByteString;

    move-result-object v0

    invoke-virtual {p1, v5, v0}, Lcom/google/protobuf/CodedOutputStream;->writeBytes(ILcom/google/protobuf/ByteString;)V

    .line 2474
    :cond_f
    iget v0, p0, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$CommandToUi;->bitField0_:I

    const v1, 0x8000

    and-int/2addr v0, v1

    const v1, 0x8000

    if-ne v0, v1, :cond_10

    .line 2475
    const/16 v0, 0x11

    iget v1, p0, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$CommandToUi;->alignType_:I

    invoke-virtual {p1, v0, v1}, Lcom/google/protobuf/CodedOutputStream;->writeInt32(II)V

    .line 2477
    :cond_10
    iget v0, p0, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$CommandToUi;->bitField0_:I

    const/high16 v1, 0x10000

    and-int/2addr v0, v1

    const/high16 v1, 0x10000

    if-ne v0, v1, :cond_11

    .line 2478
    const/16 v0, 0x12

    iget-object v1, p0, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$CommandToUi;->padding_:Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$Padding_Var;

    invoke-virtual {p1, v0, v1}, Lcom/google/protobuf/CodedOutputStream;->writeMessage(ILcom/google/protobuf/MessageLite;)V

    .line 2480
    :cond_11
    iget v0, p0, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$CommandToUi;->bitField0_:I

    const/high16 v1, 0x20000

    and-int/2addr v0, v1

    const/high16 v1, 0x20000

    if-ne v0, v1, :cond_12

    .line 2481
    const/16 v0, 0x13

    invoke-virtual {p0}, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$CommandToUi;->getUipDataBytes()Lcom/google/protobuf/ByteString;

    move-result-object v1

    invoke-virtual {p1, v0, v1}, Lcom/google/protobuf/CodedOutputStream;->writeBytes(ILcom/google/protobuf/ByteString;)V

    .line 2483
    :cond_12
    iget v0, p0, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$CommandToUi;->bitField0_:I

    const/high16 v1, 0x40000

    and-int/2addr v0, v1

    const/high16 v1, 0x40000

    if-ne v0, v1, :cond_13

    .line 2484
    const/16 v0, 0x14

    iget v1, p0, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$CommandToUi;->editInputType_:I

    invoke-virtual {p1, v0, v1}, Lcom/google/protobuf/CodedOutputStream;->writeInt32(II)V

    .line 2486
    :cond_13
    iget v0, p0, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$CommandToUi;->bitField0_:I

    const/high16 v1, 0x80000

    and-int/2addr v0, v1

    const/high16 v1, 0x80000

    if-ne v0, v1, :cond_14

    .line 2487
    const/16 v0, 0x15

    invoke-virtual {p0}, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$CommandToUi;->getFontTypeBytes()Lcom/google/protobuf/ByteString;

    move-result-object v1

    invoke-virtual {p1, v0, v1}, Lcom/google/protobuf/CodedOutputStream;->writeBytes(ILcom/google/protobuf/ByteString;)V

    .line 2489
    :cond_14
    iget v0, p0, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$CommandToUi;->bitField0_:I

    const/high16 v1, 0x100000

    and-int/2addr v0, v1

    const/high16 v1, 0x100000

    if-ne v0, v1, :cond_15

    .line 2490
    const/16 v0, 0x16

    iget v1, p0, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$CommandToUi;->fontSize_:I

    invoke-virtual {p1, v0, v1}, Lcom/google/protobuf/CodedOutputStream;->writeInt32(II)V

    .line 2492
    :cond_15
    invoke-virtual {p0}, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$CommandToUi;->getUnknownFields()Lcom/google/protobuf/UnknownFieldSet;

    move-result-object v0

    invoke-virtual {v0, p1}, Lcom/google/protobuf/UnknownFieldSet;->writeTo(Lcom/google/protobuf/CodedOutputStream;)V

    .line 2493
    return-void
.end method
