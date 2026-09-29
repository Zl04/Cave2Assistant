.class public final Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage;
.super Ljava/lang/Object;
.source "SourceFile"


# annotations
.annotation system Ldalvik/annotation/MemberClasses;
    value = {
        Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$UipToCommand;,
        Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$UipToCommandOrBuilder;,
        Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$CommandToUip;,
        Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$CommandToUipOrBuilder;,
        Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$UiToCommand;,
        Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$UiToCommandOrBuilder;,
        Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$ControlVar;,
        Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$ControlVarOrBuilder;,
        Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$ControlEvent;,
        Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$ControlEventOrBuilder;,
        Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$CommandToUi;,
        Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$CommandToUiOrBuilder;,
        Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$Padding_Var;,
        Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$Padding_VarOrBuilder;
    }
.end annotation


# static fields
.field private static a:Lcom/google/protobuf/Descriptors$Descriptor;

.field private static b:Lcom/google/protobuf/GeneratedMessage$FieldAccessorTable;

.field private static c:Lcom/google/protobuf/Descriptors$Descriptor;

.field private static d:Lcom/google/protobuf/GeneratedMessage$FieldAccessorTable;

.field private static e:Lcom/google/protobuf/Descriptors$Descriptor;

.field private static f:Lcom/google/protobuf/GeneratedMessage$FieldAccessorTable;

.field private static g:Lcom/google/protobuf/Descriptors$Descriptor;

.field private static h:Lcom/google/protobuf/GeneratedMessage$FieldAccessorTable;

.field private static i:Lcom/google/protobuf/Descriptors$Descriptor;

.field private static j:Lcom/google/protobuf/GeneratedMessage$FieldAccessorTable;

.field private static k:Lcom/google/protobuf/Descriptors$Descriptor;

.field private static l:Lcom/google/protobuf/GeneratedMessage$FieldAccessorTable;

.field private static m:Lcom/google/protobuf/Descriptors$Descriptor;

.field private static n:Lcom/google/protobuf/GeneratedMessage$FieldAccessorTable;

.field private static o:Lcom/google/protobuf/Descriptors$FileDescriptor;


# direct methods
.method static constructor <clinit>()V
    .locals 4

    .prologue
    const/4 v3, 0x0

    .line 9231
    const/4 v0, 0x7

    new-array v0, v0, [Ljava/lang/String;

    const-string v1, "\n\u000fUiMessage.proto\"G\n\u000bPadding_Var\u0012\u000b\n\u0003Top\u0018\u0001 \u0002(\u0005\u0012\u000c\n\u0004Left\u0018\u0002 \u0002(\u0005\u0012\u000e\n\u0006Bottom\u0018\u0003 \u0002(\u0005\u0012\r\n\u0005Right\u0018\u0004 \u0002(\u0005\"\u00cf\u000b\n\u000bCommandToUi\u0012*\n\u0007Command\u0018\u0001 \u0002(\u000e2\u0019.CommandToUi.Command_Type\u0012\u0012\n\nControl_Id\u0018\u0002 \u0001(\t\u0012\u0011\n\tParent_Id\u0018\u0003 \u0001(\t\u0012\u000c\n\u0004Text\u0018\u0004 \u0001(\t\u0012\r\n\u0005Width\u0018\u0005 \u0001(\u0005\u0012\u000e\n\u0006Height\u0018\u0006 \u0001(\u0005\u0012\u0014\n\u000cLayout_Style\u0018\u0007 \u0001(\u0005\u0012\u001c\n\u0014Default_Check_Status\u0018\u0008 \u0001(\u0008\u0012\u0011\n\tItem_Text\u0018\t \u0003(\t\u0012\u0012\n\nItem_Index\u0018\n \u0001(\u0005\u0012\u001a\n\u0012Default_Item_Index\u0018\u000b \u0001(\u0005\u0012\u000c\n\u0004Path\u0018\u000c \u0001(\t\u0012\u000b\n\u0003Url\u0018\r \u0001(\t\u0012\u0016\n\u000eEnabled_Status\u0018\u000e"

    aput-object v1, v0, v3

    const/4 v1, 0x1

    const-string v2, " \u0001(\u0008\u0012\u0016\n\u000eVisible_Status\u0018\u000f \u0001(\u0005\u0012\r\n\u0005Color\u0018\u0010 \u0001(\t\u0012\u0011\n\tAlignType\u0018\u0011 \u0001(\u0005\u0012\u001d\n\u0007Padding\u0018\u0012 \u0001(\u000b2\u000c.Padding_Var\u0012\u0010\n\u0008Uip_Data\u0018\u0013 \u0001(\t\u0012\u0017\n\u000fEdit_Input_Type\u0018\u0014 \u0001(\u0005\u0012\u0011\n\tFont_Type\u0018\u0015 \u0001(\t\u0012\u0011\n\tFont_Size\u0018\u0016 \u0001(\u0005\"\u00eb\u0007\n\u000cCommand_Type\u0012\u000e\n\nNEW_LAYOUT\u0010\u0001\u0012\u000f\n\u000bSHOW_LAYOUT\u0010\u0002\u0012\u0010\n\u000cCLOSE_LAYOUT\u0010\u0003\u0012\u000b\n\u0007NEW_ROW\u0010d\u0012\u0011\n\rADD_TEXT_VIEW\u0010e\u0012\u0011\n\rADD_EDIT_TEXT\u0010f\u0012\u000e\n\nADD_BUTTON\u0010g\u0012\u0013\n\u000fADD_RADIO_GROUP\u0010h\u0012\u0011\n\rADD_CHECK_BOX\u0010i\u0012\u0012\n\u000eADD_IMAGE_VIEW\u0010j\u0012\u000f\n\u000bADD_SPINNER\u0010k\u0012\u0010\n\u000cADD_TAB_HO"

    aput-object v2, v0, v1

    const/4 v1, 0x2

    const-string v2, "ST\u0010l\u0012\u000b\n\u0007ADD_TAB\u0010m\u0012\u0010\n\u000cADD_WEB_VIEW\u0010n\u0012\u000c\n\u0008ADD_LINE\u0010o\u0012\u0012\n\rSET_TEXT_VIEW\u0010\u00c9\u0001\u0012\u0012\n\rSET_EDIT_TEXT\u0010\u00ca\u0001\u0012\u000f\n\nSET_BOTTON\u0010\u00cb\u0001\u0012\u0014\n\u000fSET_RADIO_GROUP\u0010\u00cc\u0001\u0012\u0012\n\rSET_CHECK_BOX\u0010\u00cd\u0001\u0012\u0013\n\u000eSET_IMAGE_VIEW\u0010\u00ce\u0001\u0012\u0010\n\u000bSET_SPINNER\u0010\u00cf\u0001\u0012\u000c\n\u0007SET_TAB\u0010\u00d0\u0001\u0012\u0011\n\u000cSET_WEB_VIEW\u0010\u00d1\u0001\u0012\r\n\u0008SET_LINE\u0010\u00d2\u0001\u0012\u0018\n\u0013SET_EDIT_INPUT_TYPE\u0010\u00d3\u0001\u0012\r\n\u0008SET_FONT\u0010\u00d4\u0001\u0012\u0010\n\u000bSET_ENABLED\u0010\u00ad\u0002\u0012\u0010\n\u000bSET_VISIBLE\u0010\u00ae\u0002\u0012\u0013\n\u000eSET_TITLE_TEXT\u0010\u00af\u0002\u0012\r\n\u0008SET_TEXT\u0010\u00b0\u0002\u0012\u0012\n\rSET_BACKCOLOR\u0010\u00b1\u0002\u0012\u0018\n\u0013SET_TITLE_BACKCOLOR\u0010\u00b2\u0002\u0012\u0012\n\rSE"

    aput-object v2, v0, v1

    const/4 v1, 0x3

    const-string v2, "T_TEXTCOLOR\u0010\u00b3\u0002\u0012\u0010\n\u000bGET_ENABLED\u0010\u0091\u0003\u0012\u0010\n\u000bGET_VISIBLE\u0010\u0092\u0003\u0012\u0013\n\u000eGET_TITLE_TEXT\u0010\u0093\u0003\u0012\r\n\u0008GET_TEXT\u0010\u0094\u0003\u0012\u0012\n\rGET_BACKCOLOR\u0010\u0095\u0003\u0012\u0018\n\u0013GET_TITLE_BACKCOLOR\u0010\u0096\u0003\u0012\u0012\n\rGET_TEXTCOLOR\u0010\u0097\u0003\u0012\u000e\n\tGET_VALUE\u0010\u0098\u0003\u0012\u0017\n\u0012SET_WINDOW_GRAVITY\u0010\u00f5\u0003\u0012\u0018\n\u0013SET_CONTROL_GRAVITY\u0010\u00f6\u0003\u0012\u0010\n\u000bSET_PADDING\u0010\u00f7\u0003\u0012\u0013\n\u000eSET_FULLSCREEN\u0010\u00f8\u0003\u0012\u0011\n\u000cLOAD_PROFILE\u0010\u00d9\u0004\u0012\u0011\n\u000cSAVE_PROFILE\u0010\u00da\u0004\u0012\u0011\n\u000cGET_UIP_DATA\u0010\u00bd\u0005\u0012\u0011\n\u000cSET_UIP_DATA\u0010\u00be\u0005\u0012\u0017\n\u0012CLOSE_CONTINUE_ACK\u0010\u00a1\u0006\u0012\u0013\n\u000eCLOSE_EXIT_ACK\u0010\u00a2\u0006\"\u00dd\u0001\n\u000cControlEvent\u0012\u0012\n"

    aput-object v2, v0, v1

    const/4 v1, 0x4

    const-string v2, "\nControl_Id\u0018\u0001 \u0002(\t\u0012&\n\u0004Type\u0018\u0002 \u0002(\u000e2\u0018.ControlEvent.Event_Type\u0012\u0012\n\nEvent_Args\u0018\u0003 \u0001(\t\u0012\u001b\n\u0013Event_Function_Name\u0018\u0004 \u0001(\t\"`\n\nEvent_Type\u0012\r\n\tON_CHANGE\u0010\u0001\u0012\u000c\n\u0008ON_CLICK\u0010\u0002\u0012\u000b\n\u0007ON_SHOW\u0010\u0003\u0012\u0015\n\u0011ON_CLOSE_CONTINUE\u0010\u0004\u0012\u0011\n\rON_CLOSE_EXIT\u0010\u0005\"\u00ae\u0001\n\nControlVar\u0012\u0012\n\nControl_Id\u0018\u0001 \u0002(\t\u0012#\n\u0004Type\u0018\u0002 \u0001(\u000e2\u0015.ControlVar.Data_Type\u0012\u0012\n\nBool_Value\u0018\u0003 \u0001(\u0008\u0012\u0011\n\tInt_Value\u0018\u0004 \u0001(\u0005\u0012\u0014\n\u000cString_Value\u0018\u0005 \u0001(\t\"*\n\tData_Type\u0012\u0008\n\u0004BOOL\u0010\u0001\u0012\u0007\n\u0003INT\u0010\u0002\u0012\n\n\u0006STRING\u0010\u0003\"\u00b1\u0001\n\u000bUiToCommand\u0012*\n"

    aput-object v2, v0, v1

    const/4 v1, 0x5

    const-string v2, "\u0007Command\u0018\u0001 \u0002(\u000e2\u0019.UiToCommand.Command_Type\u0012\u001c\n\u0005Event\u0018\u0002 \u0001(\u000b2\r.ControlEvent\u0012\u0011\n\tIsSuccess\u0018\u0003 \u0001(\u0008\u0012\u001d\n\u0008VarTable\u0018\u0004 \u0003(\u000b2\u000b.ControlVar\"&\n\u000cCommand_Type\u0012\t\n\u0005EVENT\u0010\u0001\u0012\u000b\n\u0007RSP_MSG\u0010\u0002\"\u00a9\u0001\n\u000cCommandToUip\u0012+\n\u0007Command\u0018\u0001 \u0002(\u000e2\u001a.CommandToUip.Command_Type\u0012\u0012\n\nControl_Id\u0018\u0002 \u0001(\t\u0012\u001a\n\u0012Uip_Attribute_Data\u0018\u0003 \u0001(\t\"<\n\u000cCommand_Type\u0012\u0015\n\u0011GET_UIP_ATTRIBUTE\u0010e\u0012\u0015\n\u0011SET_UIP_ATTRIBUTE\u0010f\"\u00b0\u0001\n\u000cUipToCommand\u0012+\n\u0007Command\u0018\u0001 \u0002(\u000e2\u001a.UipToCommand.Command_Type\u0012\u001c\n\u0005E"

    aput-object v2, v0, v1

    const/4 v1, 0x6

    const-string v2, "vent\u0018\u0002 \u0001(\u000b2\r.ControlEvent\u0012\u0011\n\tIsSuccess\u0018\u0003 \u0001(\u0008\u0012\u001a\n\u0012Uip_Attribute_Data\u0018\u0004 \u0001(\t\"&\n\u000cCommand_Type\u0012\t\n\u0005EVENT\u0010\u0001\u0012\u000b\n\u0007RSP_MSG\u0010\u0002B2\n%com.cyjh.mobileanjian.ipc.share.protoB\tUiMessage"

    aput-object v2, v0, v1

    .line 9298
    new-instance v1, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$1;

    invoke-direct {v1}, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage$1;-><init>()V

    .line 9348
    new-array v2, v3, [Lcom/google/protobuf/Descriptors$FileDescriptor;

    .line 9349
    invoke-static {v0, v2, v1}, Lcom/google/protobuf/Descriptors$FileDescriptor;->internalBuildGeneratedFileFrom([Ljava/lang/String;[Lcom/google/protobuf/Descriptors$FileDescriptor;Lcom/google/protobuf/Descriptors$FileDescriptor$InternalDescriptorAssigner;)V

    .line 9352
    return-void
.end method

.method private constructor <init>()V
    .locals 0

    .prologue
    .line 7
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method

.method static synthetic a(Lcom/google/protobuf/Descriptors$Descriptor;)Lcom/google/protobuf/Descriptors$Descriptor;
    .locals 0

    .prologue
    .line 6
    sput-object p0, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage;->a:Lcom/google/protobuf/Descriptors$Descriptor;

    return-object p0
.end method

.method public static a()Lcom/google/protobuf/Descriptors$FileDescriptor;
    .locals 1

    .prologue
    .line 9226
    sget-object v0, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage;->o:Lcom/google/protobuf/Descriptors$FileDescriptor;

    return-object v0
.end method

.method static synthetic a(Lcom/google/protobuf/Descriptors$FileDescriptor;)Lcom/google/protobuf/Descriptors$FileDescriptor;
    .locals 0

    .prologue
    .line 6
    sput-object p0, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage;->o:Lcom/google/protobuf/Descriptors$FileDescriptor;

    return-object p0
.end method

.method static synthetic a(Lcom/google/protobuf/GeneratedMessage$FieldAccessorTable;)Lcom/google/protobuf/GeneratedMessage$FieldAccessorTable;
    .locals 0

    .prologue
    .line 6
    sput-object p0, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage;->b:Lcom/google/protobuf/GeneratedMessage$FieldAccessorTable;

    return-object p0
.end method

.method public static a(Lcom/google/protobuf/ExtensionRegistry;)V
    .locals 0

    .prologue
    .line 10
    return-void
.end method

.method static synthetic b()Lcom/google/protobuf/Descriptors$Descriptor;
    .locals 1

    .prologue
    .line 6
    sget-object v0, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage;->a:Lcom/google/protobuf/Descriptors$Descriptor;

    return-object v0
.end method

.method static synthetic b(Lcom/google/protobuf/Descriptors$Descriptor;)Lcom/google/protobuf/Descriptors$Descriptor;
    .locals 0

    .prologue
    .line 6
    sput-object p0, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage;->c:Lcom/google/protobuf/Descriptors$Descriptor;

    return-object p0
.end method

.method static synthetic b(Lcom/google/protobuf/GeneratedMessage$FieldAccessorTable;)Lcom/google/protobuf/GeneratedMessage$FieldAccessorTable;
    .locals 0

    .prologue
    .line 6
    sput-object p0, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage;->d:Lcom/google/protobuf/GeneratedMessage$FieldAccessorTable;

    return-object p0
.end method

.method static synthetic c(Lcom/google/protobuf/Descriptors$Descriptor;)Lcom/google/protobuf/Descriptors$Descriptor;
    .locals 0

    .prologue
    .line 6
    sput-object p0, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage;->e:Lcom/google/protobuf/Descriptors$Descriptor;

    return-object p0
.end method

.method static synthetic c()Lcom/google/protobuf/GeneratedMessage$FieldAccessorTable;
    .locals 1

    .prologue
    .line 6
    sget-object v0, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage;->b:Lcom/google/protobuf/GeneratedMessage$FieldAccessorTable;

    return-object v0
.end method

.method static synthetic c(Lcom/google/protobuf/GeneratedMessage$FieldAccessorTable;)Lcom/google/protobuf/GeneratedMessage$FieldAccessorTable;
    .locals 0

    .prologue
    .line 6
    sput-object p0, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage;->f:Lcom/google/protobuf/GeneratedMessage$FieldAccessorTable;

    return-object p0
.end method

.method static synthetic d()Lcom/google/protobuf/Descriptors$Descriptor;
    .locals 1

    .prologue
    .line 6
    sget-object v0, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage;->c:Lcom/google/protobuf/Descriptors$Descriptor;

    return-object v0
.end method

.method static synthetic d(Lcom/google/protobuf/Descriptors$Descriptor;)Lcom/google/protobuf/Descriptors$Descriptor;
    .locals 0

    .prologue
    .line 6
    sput-object p0, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage;->g:Lcom/google/protobuf/Descriptors$Descriptor;

    return-object p0
.end method

.method static synthetic d(Lcom/google/protobuf/GeneratedMessage$FieldAccessorTable;)Lcom/google/protobuf/GeneratedMessage$FieldAccessorTable;
    .locals 0

    .prologue
    .line 6
    sput-object p0, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage;->h:Lcom/google/protobuf/GeneratedMessage$FieldAccessorTable;

    return-object p0
.end method

.method static synthetic e(Lcom/google/protobuf/Descriptors$Descriptor;)Lcom/google/protobuf/Descriptors$Descriptor;
    .locals 0

    .prologue
    .line 6
    sput-object p0, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage;->i:Lcom/google/protobuf/Descriptors$Descriptor;

    return-object p0
.end method

.method static synthetic e()Lcom/google/protobuf/GeneratedMessage$FieldAccessorTable;
    .locals 1

    .prologue
    .line 6
    sget-object v0, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage;->d:Lcom/google/protobuf/GeneratedMessage$FieldAccessorTable;

    return-object v0
.end method

.method static synthetic e(Lcom/google/protobuf/GeneratedMessage$FieldAccessorTable;)Lcom/google/protobuf/GeneratedMessage$FieldAccessorTable;
    .locals 0

    .prologue
    .line 6
    sput-object p0, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage;->j:Lcom/google/protobuf/GeneratedMessage$FieldAccessorTable;

    return-object p0
.end method

.method static synthetic f()Lcom/google/protobuf/Descriptors$Descriptor;
    .locals 1

    .prologue
    .line 6
    sget-object v0, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage;->e:Lcom/google/protobuf/Descriptors$Descriptor;

    return-object v0
.end method

.method static synthetic f(Lcom/google/protobuf/Descriptors$Descriptor;)Lcom/google/protobuf/Descriptors$Descriptor;
    .locals 0

    .prologue
    .line 6
    sput-object p0, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage;->k:Lcom/google/protobuf/Descriptors$Descriptor;

    return-object p0
.end method

.method static synthetic f(Lcom/google/protobuf/GeneratedMessage$FieldAccessorTable;)Lcom/google/protobuf/GeneratedMessage$FieldAccessorTable;
    .locals 0

    .prologue
    .line 6
    sput-object p0, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage;->l:Lcom/google/protobuf/GeneratedMessage$FieldAccessorTable;

    return-object p0
.end method

.method static synthetic g(Lcom/google/protobuf/Descriptors$Descriptor;)Lcom/google/protobuf/Descriptors$Descriptor;
    .locals 0

    .prologue
    .line 6
    sput-object p0, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage;->m:Lcom/google/protobuf/Descriptors$Descriptor;

    return-object p0
.end method

.method static synthetic g()Lcom/google/protobuf/GeneratedMessage$FieldAccessorTable;
    .locals 1

    .prologue
    .line 6
    sget-object v0, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage;->f:Lcom/google/protobuf/GeneratedMessage$FieldAccessorTable;

    return-object v0
.end method

.method static synthetic g(Lcom/google/protobuf/GeneratedMessage$FieldAccessorTable;)Lcom/google/protobuf/GeneratedMessage$FieldAccessorTable;
    .locals 0

    .prologue
    .line 6
    sput-object p0, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage;->n:Lcom/google/protobuf/GeneratedMessage$FieldAccessorTable;

    return-object p0
.end method

.method static synthetic h()Lcom/google/protobuf/Descriptors$Descriptor;
    .locals 1

    .prologue
    .line 6
    sget-object v0, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage;->g:Lcom/google/protobuf/Descriptors$Descriptor;

    return-object v0
.end method

.method static synthetic i()Lcom/google/protobuf/GeneratedMessage$FieldAccessorTable;
    .locals 1

    .prologue
    .line 6
    sget-object v0, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage;->h:Lcom/google/protobuf/GeneratedMessage$FieldAccessorTable;

    return-object v0
.end method

.method static synthetic j()Lcom/google/protobuf/Descriptors$Descriptor;
    .locals 1

    .prologue
    .line 6
    sget-object v0, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage;->i:Lcom/google/protobuf/Descriptors$Descriptor;

    return-object v0
.end method

.method static synthetic k()Lcom/google/protobuf/GeneratedMessage$FieldAccessorTable;
    .locals 1

    .prologue
    .line 6
    sget-object v0, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage;->j:Lcom/google/protobuf/GeneratedMessage$FieldAccessorTable;

    return-object v0
.end method

.method static synthetic l()Lcom/google/protobuf/Descriptors$Descriptor;
    .locals 1

    .prologue
    .line 6
    sget-object v0, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage;->k:Lcom/google/protobuf/Descriptors$Descriptor;

    return-object v0
.end method

.method static synthetic m()Lcom/google/protobuf/GeneratedMessage$FieldAccessorTable;
    .locals 1

    .prologue
    .line 6
    sget-object v0, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage;->l:Lcom/google/protobuf/GeneratedMessage$FieldAccessorTable;

    return-object v0
.end method

.method static synthetic n()Lcom/google/protobuf/Descriptors$Descriptor;
    .locals 1

    .prologue
    .line 6
    sget-object v0, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage;->m:Lcom/google/protobuf/Descriptors$Descriptor;

    return-object v0
.end method

.method static synthetic o()Lcom/google/protobuf/GeneratedMessage$FieldAccessorTable;
    .locals 1

    .prologue
    .line 6
    sget-object v0, Lcom/cyjh/mobileanjian/ipc/share/proto/UiMessage;->n:Lcom/google/protobuf/GeneratedMessage$FieldAccessorTable;

    return-object v0
.end method
