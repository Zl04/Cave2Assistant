.class public Lorg/apache/harmony/awt/datatransfer/TextFlavor;
.super Ljava/lang/Object;
.source "SourceFile"


# static fields
.field public static final charsetTextClasses:[Ljava/lang/Class;

.field public static final unicodeTextClasses:[Ljava/lang/Class;


# direct methods
.method static constructor <clinit>()V
    .locals 6

    .prologue
    const/4 v5, 0x3

    const/4 v4, 0x2

    const/4 v3, 0x1

    const/4 v2, 0x0

    .line 36
    const/4 v0, 0x4

    new-array v0, v0, [Ljava/lang/Class;

    .line 37
    const-class v1, Ljava/lang/String;

    aput-object v1, v0, v2

    const-class v1, Ljava/io/Reader;

    aput-object v1, v0, v3

    const-class v1, Ljava/nio/CharBuffer;

    aput-object v1, v0, v4

    const-class v1, [C

    aput-object v1, v0, v5

    .line 36
    sput-object v0, Lorg/apache/harmony/awt/datatransfer/TextFlavor;->unicodeTextClasses:[Ljava/lang/Class;

    .line 39
    new-array v0, v5, [Ljava/lang/Class;

    .line 40
    const-class v1, Ljava/io/InputStream;

    aput-object v1, v0, v2

    const-class v1, Ljava/nio/ByteBuffer;

    aput-object v1, v0, v3

    const-class v1, [B

    aput-object v1, v0, v4

    .line 39
    sput-object v0, Lorg/apache/harmony/awt/datatransfer/TextFlavor;->charsetTextClasses:[Ljava/lang/Class;

    .line 34
    return-void
.end method

.method public constructor <init>()V
    .locals 0

    .prologue
    .line 34
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method

.method public static addCharsetClasses(Ljava/awt/datatransfer/SystemFlavorMap;Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;)V
    .locals 6

    .prologue
    .line 59
    const/4 v0, 0x0

    :goto_0
    sget-object v1, Lorg/apache/harmony/awt/datatransfer/TextFlavor;->charsetTextClasses:[Ljava/lang/Class;

    array-length v1, v1

    if-lt v0, v1, :cond_0

    .line 68
    return-void

    .line 60
    :cond_0
    new-instance v1, Ljava/lang/StringBuilder;

    const-string v2, "text/"

    invoke-direct {v1, v2}, Ljava/lang/StringBuilder;-><init>(Ljava/lang/String;)V

    invoke-virtual {v1, p2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v1

    .line 61
    new-instance v2, Ljava/lang/StringBuilder;

    const-string v3, ";class=\""

    invoke-direct {v2, v3}, Ljava/lang/StringBuilder;-><init>(Ljava/lang/String;)V

    .line 62
    sget-object v3, Lorg/apache/harmony/awt/datatransfer/TextFlavor;->charsetTextClasses:[Ljava/lang/Class;

    aget-object v3, v3, v0

    invoke-virtual {v3}, Ljava/lang/Class;->getName()Ljava/lang/String;

    move-result-object v3

    invoke-virtual {v2, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    const-string v3, "\""

    invoke-virtual {v2, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    .line 63
    const-string v3, ";charset=\""

    invoke-virtual {v2, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    invoke-virtual {v2, p3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    const-string v3, "\""

    invoke-virtual {v2, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    .line 61
    invoke-virtual {v2}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v2

    .line 64
    new-instance v3, Ljava/awt/datatransfer/DataFlavor;

    new-instance v4, Ljava/lang/StringBuilder;

    invoke-static {v1}, Ljava/lang/String;->valueOf(Ljava/lang/Object;)Ljava/lang/String;

    move-result-object v5

    invoke-direct {v4, v5}, Ljava/lang/StringBuilder;-><init>(Ljava/lang/String;)V

    invoke-virtual {v4, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    invoke-virtual {v2}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v2

    invoke-direct {v3, v2, v1}, Ljava/awt/datatransfer/DataFlavor;-><init>(Ljava/lang/String;Ljava/lang/String;)V

    .line 65
    invoke-virtual {p0, p1, v3}, Ljava/awt/datatransfer/SystemFlavorMap;->addFlavorForUnencodedNative(Ljava/lang/String;Ljava/awt/datatransfer/DataFlavor;)V

    .line 66
    invoke-virtual {p0, v3, p1}, Ljava/awt/datatransfer/SystemFlavorMap;->addUnencodedNativeForFlavor(Ljava/awt/datatransfer/DataFlavor;Ljava/lang/String;)V

    .line 59
    add-int/lit8 v0, v0, 0x1

    goto :goto_0
.end method

.method public static addUnicodeClasses(Ljava/awt/datatransfer/SystemFlavorMap;Ljava/lang/String;Ljava/lang/String;)V
    .locals 6

    .prologue
    .line 45
    const/4 v0, 0x0

    :goto_0
    sget-object v1, Lorg/apache/harmony/awt/datatransfer/TextFlavor;->unicodeTextClasses:[Ljava/lang/Class;

    array-length v1, v1

    if-lt v0, v1, :cond_0

    .line 53
    return-void

    .line 46
    :cond_0
    new-instance v1, Ljava/lang/StringBuilder;

    const-string v2, "text/"

    invoke-direct {v1, v2}, Ljava/lang/StringBuilder;-><init>(Ljava/lang/String;)V

    invoke-virtual {v1, p2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v1

    .line 47
    new-instance v2, Ljava/lang/StringBuilder;

    const-string v3, ";class=\""

    invoke-direct {v2, v3}, Ljava/lang/StringBuilder;-><init>(Ljava/lang/String;)V

    .line 48
    sget-object v3, Lorg/apache/harmony/awt/datatransfer/TextFlavor;->unicodeTextClasses:[Ljava/lang/Class;

    aget-object v3, v3, v0

    invoke-virtual {v3}, Ljava/lang/Class;->getName()Ljava/lang/String;

    move-result-object v3

    invoke-virtual {v2, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    const-string v3, "\""

    invoke-virtual {v2, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    .line 47
    invoke-virtual {v2}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v2

    .line 49
    new-instance v3, Ljava/awt/datatransfer/DataFlavor;

    new-instance v4, Ljava/lang/StringBuilder;

    invoke-static {v1}, Ljava/lang/String;->valueOf(Ljava/lang/Object;)Ljava/lang/String;

    move-result-object v5

    invoke-direct {v4, v5}, Ljava/lang/StringBuilder;-><init>(Ljava/lang/String;)V

    invoke-virtual {v4, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    invoke-virtual {v2}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v2

    invoke-direct {v3, v2, v1}, Ljava/awt/datatransfer/DataFlavor;-><init>(Ljava/lang/String;Ljava/lang/String;)V

    .line 50
    invoke-virtual {p0, p1, v3}, Ljava/awt/datatransfer/SystemFlavorMap;->addFlavorForUnencodedNative(Ljava/lang/String;Ljava/awt/datatransfer/DataFlavor;)V

    .line 51
    invoke-virtual {p0, v3, p1}, Ljava/awt/datatransfer/SystemFlavorMap;->addUnencodedNativeForFlavor(Ljava/awt/datatransfer/DataFlavor;Ljava/lang/String;)V

    .line 45
    add-int/lit8 v0, v0, 0x1

    goto :goto_0
.end method
