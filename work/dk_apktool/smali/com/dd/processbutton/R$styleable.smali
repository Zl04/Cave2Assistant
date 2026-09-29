.class public final Lcom/dd/processbutton/R$styleable;
.super Ljava/lang/Object;
.source "R.java"


# annotations
.annotation system Ldalvik/annotation/EnclosingClass;
    value = Lcom/dd/processbutton/R;
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x19
    name = "styleable"
.end annotation


# static fields
.field public static final FlatButton:[I

.field public static final FlatButton_pb_colorNormal:I = 0x1

.field public static final FlatButton_pb_colorPressed:I = 0x0

.field public static final FlatButton_pb_cornerRadius:I = 0x2

.field public static final ProcessButton:[I

.field public static final ProcessButton_pb_colorComplete:I = 0x4

.field public static final ProcessButton_pb_colorError:I = 0x5

.field public static final ProcessButton_pb_colorProgress:I = 0x3

.field public static final ProcessButton_pb_textComplete:I = 0x1

.field public static final ProcessButton_pb_textError:I = 0x2

.field public static final ProcessButton_pb_textProgress:I


# direct methods
.method static constructor <clinit>()V
    .locals 1

    .prologue
    .line 56
    const/4 v0, 0x3

    new-array v0, v0, [I

    fill-array-data v0, :array_0

    sput-object v0, Lcom/dd/processbutton/R$styleable;->FlatButton:[I

    .line 60
    const/4 v0, 0x6

    new-array v0, v0, [I

    fill-array-data v0, :array_1

    sput-object v0, Lcom/dd/processbutton/R$styleable;->ProcessButton:[I

    return-void

    .line 56
    nop

    :array_0
    .array-data 4
        0x7f01004a
        0x7f01004b
        0x7f01004c
    .end array-data

    .line 60
    :array_1
    .array-data 4
        0x7f010062
        0x7f010063
        0x7f010064
        0x7f010065
        0x7f010066
        0x7f010067
    .end array-data
.end method

.method public constructor <init>()V
    .locals 0

    .prologue
    .line 55
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method
