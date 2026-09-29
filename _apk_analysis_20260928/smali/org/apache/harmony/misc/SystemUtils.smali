.class public Lorg/apache/harmony/misc/SystemUtils;
.super Ljava/lang/Object;
.source "SourceFile"


# static fields
.field public static final ARC_IA32:I = 0x1

.field public static final ARC_IA64:I = 0x2

.field public static final ARC_UNKNOWN:I = -0x1

.field public static final OS_LINUX:I = 0x2

.field public static final OS_UNKNOWN:I = -0x1

.field public static final OS_WINDOWS:I = 0x1

.field private static arc:I

.field private static os:I


# direct methods
.method static constructor <clinit>()V
    .locals 1

    .prologue
    const/4 v0, 0x0

    .line 36
    sput v0, Lorg/apache/harmony/misc/SystemUtils;->os:I

    .line 37
    sput v0, Lorg/apache/harmony/misc/SystemUtils;->arc:I

    .line 23
    return-void
.end method

.method public constructor <init>()V
    .locals 0

    .prologue
    .line 23
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method

.method public static getOS()I
    .locals 3

    .prologue
    .line 45
    sget v0, Lorg/apache/harmony/misc/SystemUtils;->os:I

    if-nez v0, :cond_0

    .line 46
    const-string v0, "os.name"

    invoke-static {v0}, Ljava/lang/System;->getProperty(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v0

    const/4 v1, 0x0

    const/4 v2, 0x3

    invoke-virtual {v0, v1, v2}, Ljava/lang/String;->substring(II)Ljava/lang/String;

    move-result-object v0

    .line 47
    const-string v1, "win"

    invoke-virtual {v0, v1}, Ljava/lang/String;->compareToIgnoreCase(Ljava/lang/String;)I

    move-result v1

    if-nez v1, :cond_1

    .line 48
    const/4 v0, 0x1

    sput v0, Lorg/apache/harmony/misc/SystemUtils;->os:I

    .line 56
    :cond_0
    :goto_0
    sget v0, Lorg/apache/harmony/misc/SystemUtils;->os:I

    return v0

    .line 50
    :cond_1
    const-string v1, "lin"

    invoke-virtual {v0, v1}, Ljava/lang/String;->compareToIgnoreCase(Ljava/lang/String;)I

    move-result v0

    if-nez v0, :cond_2

    .line 51
    const/4 v0, 0x2

    sput v0, Lorg/apache/harmony/misc/SystemUtils;->os:I

    goto :goto_0

    .line 53
    :cond_2
    const/4 v0, -0x1

    sput v0, Lorg/apache/harmony/misc/SystemUtils;->os:I

    goto :goto_0
.end method
