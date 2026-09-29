.class public Lcom/kaopu/download/util/DownloadHttpUtil;
.super Ljava/lang/Object;
.source "DownloadHttpUtil.java"


# static fields
.field public static BUFFER_SIZE:I = 0x0

.field public static final HTTP_REQUEST_CANCLE:I = 0x2

.field public static final HTTP_REQUEST_NONE:I = 0x3

.field public static final HTTP_REQUEST_PAUSE:I = 0x1

.field public static final MAX_REQUEST_RETRY_COUNTS:I = 0x3

.field public static final RETRY_SLEEP_TIME:I = 0x7d0


# direct methods
.method static constructor <clinit>()V
    .locals 1

    .prologue
    .line 36
    const/16 v0, 0x800

    sput v0, Lcom/kaopu/download/util/DownloadHttpUtil;->BUFFER_SIZE:I

    return-void
.end method

.method public constructor <init>()V
    .locals 0

    .prologue
    .line 6
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method

.method public static utf8URLencode(Ljava/lang/String;)Ljava/lang/String;
    .locals 8
    .param p0, "url"    # Ljava/lang/String;

    .prologue
    .line 45
    if-nez p0, :cond_0

    .line 46
    const-string v6, ""

    .line 66
    :goto_0
    return-object v6

    .line 47
    :cond_0
    new-instance v5, Ljava/lang/StringBuffer;

    invoke-direct {v5}, Ljava/lang/StringBuffer;-><init>()V

    .line 48
    .local v5, "result":Ljava/lang/StringBuffer;
    const/4 v2, 0x0

    .local v2, "i":I
    :goto_1
    invoke-virtual {p0}, Ljava/lang/String;->length()I

    move-result v6

    if-lt v2, v6, :cond_1

    .line 66
    invoke-virtual {v5}, Ljava/lang/StringBuffer;->toString()Ljava/lang/String;

    move-result-object v6

    goto :goto_0

    .line 49
    :cond_1
    invoke-virtual {p0, v2}, Ljava/lang/String;->charAt(I)C

    move-result v1

    .line 50
    .local v1, "c":C
    if-ltz v1, :cond_3

    const/16 v6, 0xff

    if-gt v1, v6, :cond_3

    .line 51
    invoke-virtual {v5, v1}, Ljava/lang/StringBuffer;->append(C)Ljava/lang/StringBuffer;

    .line 48
    :cond_2
    add-int/lit8 v2, v2, 0x1

    goto :goto_1

    .line 53
    :cond_3
    const/4 v6, 0x0

    new-array v0, v6, [B

    .line 55
    .local v0, "b":[B
    :try_start_0
    invoke-static {v1}, Ljava/lang/Character;->toString(C)Ljava/lang/String;

    move-result-object v6

    const-string v7, "UTF-8"

    invoke-virtual {v6, v7}, Ljava/lang/String;->getBytes(Ljava/lang/String;)[B
    :try_end_0
    .catch Ljava/lang/Exception; {:try_start_0 .. :try_end_0} :catch_0

    move-result-object v0

    .line 58
    :goto_2
    const/4 v3, 0x0

    .local v3, "j":I
    :goto_3
    array-length v6, v0

    if-ge v3, v6, :cond_2

    .line 59
    aget-byte v4, v0, v3

    .line 60
    .local v4, "k":I
    if-gez v4, :cond_4

    .line 61
    add-int/lit16 v4, v4, 0x100

    .line 62
    :cond_4
    new-instance v6, Ljava/lang/StringBuilder;

    const-string v7, "%"

    invoke-direct {v6, v7}, Ljava/lang/StringBuilder;-><init>(Ljava/lang/String;)V

    invoke-static {v4}, Ljava/lang/Integer;->toHexString(I)Ljava/lang/String;

    move-result-object v7

    invoke-virtual {v7}, Ljava/lang/String;->toUpperCase()Ljava/lang/String;

    move-result-object v7

    invoke-virtual {v6, v7}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v6

    invoke-virtual {v6}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v6

    invoke-virtual {v5, v6}, Ljava/lang/StringBuffer;->append(Ljava/lang/String;)Ljava/lang/StringBuffer;

    .line 58
    add-int/lit8 v3, v3, 0x1

    goto :goto_3

    .line 56
    .end local v3    # "j":I
    .end local v4    # "k":I
    :catch_0
    move-exception v6

    goto :goto_2
.end method
