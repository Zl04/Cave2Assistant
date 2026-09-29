.class public Lcom/sun/mail/util/ASCIIUtility;
.super Ljava/lang/Object;
.source "SourceFile"


# direct methods
.method private constructor <init>()V
    .locals 0

    .prologue
    .line 50
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method

.method public static getBytes(Ljava/io/InputStream;)[B
    .locals 6
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljava/io/IOException;
        }
    .end annotation

    .prologue
    const/4 v5, 0x0

    .line 247
    const/16 v0, 0x400

    .line 251
    instance-of v1, p0, Ljava/io/ByteArrayInputStream;

    if-eqz v1, :cond_0

    .line 252
    invoke-virtual {p0}, Ljava/io/InputStream;->available()I

    move-result v1

    .line 253
    new-array v0, v1, [B

    .line 254
    invoke-virtual {p0, v0, v5, v1}, Ljava/io/InputStream;->read([BII)I

    .line 263
    :goto_0
    return-object v0

    .line 257
    :cond_0
    new-instance v1, Ljava/io/ByteArrayOutputStream;

    invoke-direct {v1}, Ljava/io/ByteArrayOutputStream;-><init>()V

    .line 258
    new-array v2, v0, [B

    .line 259
    :goto_1
    invoke-virtual {p0, v2, v5, v0}, Ljava/io/InputStream;->read([BII)I

    move-result v3

    const/4 v4, -0x1

    if-ne v3, v4, :cond_1

    .line 261
    invoke-virtual {v1}, Ljava/io/ByteArrayOutputStream;->toByteArray()[B

    move-result-object v0

    goto :goto_0

    .line 260
    :cond_1
    invoke-virtual {v1, v2, v5, v3}, Ljava/io/ByteArrayOutputStream;->write([BII)V

    goto :goto_1
.end method

.method public static getBytes(Ljava/lang/String;)[B
    .locals 6

    .prologue
    .line 235
    invoke-virtual {p0}, Ljava/lang/String;->toCharArray()[C

    move-result-object v2

    .line 236
    array-length v3, v2

    .line 237
    new-array v4, v3, [B

    .line 239
    const/4 v0, 0x0

    :goto_0
    if-lt v0, v3, :cond_0

    .line 241
    return-object v4

    .line 240
    :cond_0
    add-int/lit8 v1, v0, 0x1

    aget-char v5, v2, v0

    int-to-byte v5, v5

    aput-byte v5, v4, v0

    move v0, v1

    goto :goto_0
.end method

.method public static parseInt([BII)I
    .locals 1
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljava/lang/NumberFormatException;
        }
    .end annotation

    .prologue
    .line 126
    const/16 v0, 0xa

    invoke-static {p0, p1, p2, v0}, Lcom/sun/mail/util/ASCIIUtility;->parseInt([BIII)I

    move-result v0

    return v0
.end method

.method public static parseInt([BIII)I
    .locals 8
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljava/lang/NumberFormatException;
        }
    .end annotation

    .prologue
    const/4 v3, 0x0

    .line 61
    if-nez p0, :cond_0

    .line 62
    new-instance v0, Ljava/lang/NumberFormatException;

    const-string v1, "null"

    invoke-direct {v0, v1}, Ljava/lang/NumberFormatException;-><init>(Ljava/lang/String;)V

    throw v0

    .line 71
    :cond_0
    if-le p2, p1, :cond_7

    .line 72
    aget-byte v0, p0, p1

    const/16 v1, 0x2d

    if-ne v0, v1, :cond_1

    .line 73
    const/4 v2, 0x1

    .line 74
    const/high16 v0, -0x80000000

    .line 75
    add-int/lit8 v1, p1, 0x1

    .line 79
    :goto_0
    div-int v5, v0, p3

    .line 80
    if-ge v1, p2, :cond_a

    .line 81
    add-int/lit8 v3, v1, 0x1

    aget-byte v1, p0, v1

    int-to-char v1, v1

    invoke-static {v1, p3}, Ljava/lang/Character;->digit(CI)I

    move-result v1

    .line 82
    if-gez v1, :cond_2

    .line 83
    new-instance v0, Ljava/lang/NumberFormatException;

    .line 84
    new-instance v1, Ljava/lang/StringBuilder;

    const-string v2, "illegal number: "

    invoke-direct {v1, v2}, Ljava/lang/StringBuilder;-><init>(Ljava/lang/String;)V

    invoke-static {p0, p1, p2}, Lcom/sun/mail/util/ASCIIUtility;->toString([BII)Ljava/lang/String;

    move-result-object v2

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v1

    .line 83
    invoke-direct {v0, v1}, Ljava/lang/NumberFormatException;-><init>(Ljava/lang/String;)V

    throw v0

    .line 77
    :cond_1
    const v0, -0x7fffffff

    move v1, p1

    move v2, v3

    goto :goto_0

    .line 87
    :cond_2
    neg-int v1, v1

    .line 90
    :goto_1
    if-lt v3, p2, :cond_3

    .line 108
    if-eqz v2, :cond_9

    .line 109
    add-int/lit8 v0, p1, 0x1

    if-le v3, v0, :cond_8

    move v0, v1

    .line 115
    :goto_2
    return v0

    .line 92
    :cond_3
    add-int/lit8 v4, v3, 0x1

    aget-byte v3, p0, v3

    int-to-char v3, v3

    invoke-static {v3, p3}, Ljava/lang/Character;->digit(CI)I

    move-result v3

    .line 93
    if-gez v3, :cond_4

    .line 94
    new-instance v0, Ljava/lang/NumberFormatException;

    const-string v1, "illegal number"

    invoke-direct {v0, v1}, Ljava/lang/NumberFormatException;-><init>(Ljava/lang/String;)V

    throw v0

    .line 96
    :cond_4
    if-ge v1, v5, :cond_5

    .line 97
    new-instance v0, Ljava/lang/NumberFormatException;

    const-string v1, "illegal number"

    invoke-direct {v0, v1}, Ljava/lang/NumberFormatException;-><init>(Ljava/lang/String;)V

    throw v0

    .line 99
    :cond_5
    mul-int/2addr v1, p3

    .line 100
    add-int v6, v0, v3

    if-ge v1, v6, :cond_6

    .line 101
    new-instance v0, Ljava/lang/NumberFormatException;

    const-string v1, "illegal number"

    invoke-direct {v0, v1}, Ljava/lang/NumberFormatException;-><init>(Ljava/lang/String;)V

    throw v0

    .line 103
    :cond_6
    sub-int/2addr v1, v3

    move v3, v4

    goto :goto_1

    .line 106
    :cond_7
    new-instance v0, Ljava/lang/NumberFormatException;

    const-string v1, "illegal number"

    invoke-direct {v0, v1}, Ljava/lang/NumberFormatException;-><init>(Ljava/lang/String;)V

    throw v0

    .line 112
    :cond_8
    new-instance v0, Ljava/lang/NumberFormatException;

    const-string v1, "illegal number"

    invoke-direct {v0, v1}, Ljava/lang/NumberFormatException;-><init>(Ljava/lang/String;)V

    throw v0

    .line 115
    :cond_9
    neg-int v0, v1

    goto :goto_2

    :cond_a
    move v7, v1

    move v1, v3

    move v3, v7

    goto :goto_1
.end method

.method public static parseLong([BII)J
    .locals 2
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljava/lang/NumberFormatException;
        }
    .end annotation

    .prologue
    .line 203
    const/16 v0, 0xa

    invoke-static {p0, p1, p2, v0}, Lcom/sun/mail/util/ASCIIUtility;->parseLong([BIII)J

    move-result-wide v0

    return-wide v0
.end method

.method public static parseLong([BIII)J
    .locals 12
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljava/lang/NumberFormatException;
        }
    .end annotation

    .prologue
    .line 138
    if-nez p0, :cond_0

    .line 139
    new-instance v0, Ljava/lang/NumberFormatException;

    const-string v1, "null"

    invoke-direct {v0, v1}, Ljava/lang/NumberFormatException;-><init>(Ljava/lang/String;)V

    throw v0

    .line 141
    :cond_0
    const-wide/16 v4, 0x0

    .line 142
    const/4 v2, 0x0

    .line 148
    if-le p2, p1, :cond_8

    .line 149
    aget-byte v0, p0, p1

    const/16 v1, 0x2d

    if-ne v0, v1, :cond_1

    .line 150
    const/4 v3, 0x1

    .line 151
    const-wide/high16 v0, -0x8000000000000000L

    .line 152
    add-int/lit8 v2, p1, 0x1

    .line 156
    :goto_0
    int-to-long v6, p3

    div-long v8, v0, v6

    .line 157
    if-ge v2, p2, :cond_3

    .line 158
    add-int/lit8 v4, v2, 0x1

    aget-byte v2, p0, v2

    int-to-char v2, v2

    invoke-static {v2, p3}, Ljava/lang/Character;->digit(CI)I

    move-result v2

    .line 159
    if-gez v2, :cond_2

    .line 160
    new-instance v0, Ljava/lang/NumberFormatException;

    .line 161
    new-instance v1, Ljava/lang/StringBuilder;

    const-string v2, "illegal number: "

    invoke-direct {v1, v2}, Ljava/lang/StringBuilder;-><init>(Ljava/lang/String;)V

    invoke-static {p0, p1, p2}, Lcom/sun/mail/util/ASCIIUtility;->toString([BII)Ljava/lang/String;

    move-result-object v2

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v1

    .line 160
    invoke-direct {v0, v1}, Ljava/lang/NumberFormatException;-><init>(Ljava/lang/String;)V

    throw v0

    .line 154
    :cond_1
    const-wide v0, -0x7fffffffffffffffL    # -4.9E-324

    move v3, v2

    move v2, p1

    goto :goto_0

    .line 164
    :cond_2
    neg-int v2, v2

    int-to-long v6, v2

    move v2, v4

    move-wide v4, v6

    .line 167
    :cond_3
    :goto_1
    if-lt v2, p2, :cond_4

    .line 185
    if-eqz v3, :cond_a

    .line 186
    add-int/lit8 v0, p1, 0x1

    if-le v2, v0, :cond_9

    move-wide v0, v4

    .line 192
    :goto_2
    return-wide v0

    .line 169
    :cond_4
    add-int/lit8 v6, v2, 0x1

    aget-byte v2, p0, v2

    int-to-char v2, v2

    invoke-static {v2, p3}, Ljava/lang/Character;->digit(CI)I

    move-result v2

    .line 170
    if-gez v2, :cond_5

    .line 171
    new-instance v0, Ljava/lang/NumberFormatException;

    const-string v1, "illegal number"

    invoke-direct {v0, v1}, Ljava/lang/NumberFormatException;-><init>(Ljava/lang/String;)V

    throw v0

    .line 173
    :cond_5
    cmp-long v7, v4, v8

    if-gez v7, :cond_6

    .line 174
    new-instance v0, Ljava/lang/NumberFormatException;

    const-string v1, "illegal number"

    invoke-direct {v0, v1}, Ljava/lang/NumberFormatException;-><init>(Ljava/lang/String;)V

    throw v0

    .line 176
    :cond_6
    int-to-long v10, p3

    mul-long/2addr v4, v10

    .line 177
    int-to-long v10, v2

    add-long/2addr v10, v0

    cmp-long v7, v4, v10

    if-gez v7, :cond_7

    .line 178
    new-instance v0, Ljava/lang/NumberFormatException;

    const-string v1, "illegal number"

    invoke-direct {v0, v1}, Ljava/lang/NumberFormatException;-><init>(Ljava/lang/String;)V

    throw v0

    .line 180
    :cond_7
    int-to-long v10, v2

    sub-long/2addr v4, v10

    move v2, v6

    goto :goto_1

    .line 183
    :cond_8
    new-instance v0, Ljava/lang/NumberFormatException;

    const-string v1, "illegal number"

    invoke-direct {v0, v1}, Ljava/lang/NumberFormatException;-><init>(Ljava/lang/String;)V

    throw v0

    .line 189
    :cond_9
    new-instance v0, Ljava/lang/NumberFormatException;

    const-string v1, "illegal number"

    invoke-direct {v0, v1}, Ljava/lang/NumberFormatException;-><init>(Ljava/lang/String;)V

    throw v0

    .line 192
    :cond_a
    neg-long v0, v4

    goto :goto_2
.end method

.method public static toString(Ljava/io/ByteArrayInputStream;)Ljava/lang/String;
    .locals 6

    .prologue
    const/4 v0, 0x0

    .line 222
    invoke-virtual {p0}, Ljava/io/ByteArrayInputStream;->available()I

    move-result v2

    .line 223
    new-array v3, v2, [C

    .line 224
    new-array v4, v2, [B

    .line 226
    invoke-virtual {p0, v4, v0, v2}, Ljava/io/ByteArrayInputStream;->read([BII)I

    .line 227
    :goto_0
    if-lt v0, v2, :cond_0

    .line 230
    new-instance v0, Ljava/lang/String;

    invoke-direct {v0, v3}, Ljava/lang/String;-><init>([C)V

    return-object v0

    .line 228
    :cond_0
    add-int/lit8 v1, v0, 0x1

    aget-byte v5, v4, v0

    and-int/lit16 v5, v5, 0xff

    int-to-char v5, v5

    aput-char v5, v3, v0

    move v0, v1

    goto :goto_0
.end method

.method public static toString([BII)Ljava/lang/String;
    .locals 6

    .prologue
    .line 212
    sub-int v3, p2, p1

    .line 213
    new-array v4, v3, [C

    .line 215
    const/4 v0, 0x0

    move v1, v0

    :goto_0
    if-lt v1, v3, :cond_0

    .line 218
    new-instance v0, Ljava/lang/String;

    invoke-direct {v0, v4}, Ljava/lang/String;-><init>([C)V

    return-object v0

    .line 216
    :cond_0
    add-int/lit8 v2, v1, 0x1

    add-int/lit8 v0, p1, 0x1

    aget-byte v5, p0, p1

    and-int/lit16 v5, v5, 0xff

    int-to-char v5, v5

    aput-char v5, v4, v1

    move p1, v0

    move v1, v2

    goto :goto_0
.end method
