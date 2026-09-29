.class public Lorg/apache/commons/io/EndianUtils;
.super Ljava/lang/Object;
.source "SourceFile"


# direct methods
.method public constructor <init>()V
    .locals 0

    .prologue
    .line 47
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    .line 48
    return-void
.end method

.method private static read(Ljava/io/InputStream;)I
    .locals 2
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljava/io/IOException;
        }
    .end annotation

    .prologue
    .line 474
    invoke-virtual {p0}, Ljava/io/InputStream;->read()I

    move-result v0

    .line 476
    const/4 v1, -0x1

    if-ne v1, v0, :cond_0

    .line 477
    new-instance v0, Ljava/io/EOFException;

    const-string v1, "Unexpected EOF reached"

    invoke-direct {v0, v1}, Ljava/io/EOFException;-><init>(Ljava/lang/String;)V

    throw v0

    .line 480
    :cond_0
    return v0
.end method

.method public static readSwappedDouble(Ljava/io/InputStream;)D
    .locals 2
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljava/io/IOException;
        }
    .end annotation

    .prologue
    .line 462
    invoke-static {p0}, Lorg/apache/commons/io/EndianUtils;->readSwappedLong(Ljava/io/InputStream;)J

    move-result-wide v0

    invoke-static {v0, v1}, Ljava/lang/Double;->longBitsToDouble(J)D

    move-result-wide v0

    return-wide v0
.end method

.method public static readSwappedDouble([BI)D
    .locals 2

    .prologue
    .line 267
    invoke-static {p0, p1}, Lorg/apache/commons/io/EndianUtils;->readSwappedLong([BI)J

    move-result-wide v0

    invoke-static {v0, v1}, Ljava/lang/Double;->longBitsToDouble(J)D

    move-result-wide v0

    return-wide v0
.end method

.method public static readSwappedFloat(Ljava/io/InputStream;)F
    .locals 1
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljava/io/IOException;
        }
    .end annotation

    .prologue
    .line 436
    invoke-static {p0}, Lorg/apache/commons/io/EndianUtils;->readSwappedInteger(Ljava/io/InputStream;)I

    move-result v0

    invoke-static {v0}, Ljava/lang/Float;->intBitsToFloat(I)F

    move-result v0

    return v0
.end method

.method public static readSwappedFloat([BI)F
    .locals 1

    .prologue
    .line 245
    invoke-static {p0, p1}, Lorg/apache/commons/io/EndianUtils;->readSwappedInteger([BI)I

    move-result v0

    invoke-static {v0}, Ljava/lang/Float;->intBitsToFloat(I)F

    move-result v0

    return v0
.end method

.method public static readSwappedInteger(Ljava/io/InputStream;)I
    .locals 4
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljava/io/IOException;
        }
    .end annotation

    .prologue
    .line 341
    invoke-static {p0}, Lorg/apache/commons/io/EndianUtils;->read(Ljava/io/InputStream;)I

    move-result v0

    .line 342
    invoke-static {p0}, Lorg/apache/commons/io/EndianUtils;->read(Ljava/io/InputStream;)I

    move-result v1

    .line 343
    invoke-static {p0}, Lorg/apache/commons/io/EndianUtils;->read(Ljava/io/InputStream;)I

    move-result v2

    .line 344
    invoke-static {p0}, Lorg/apache/commons/io/EndianUtils;->read(Ljava/io/InputStream;)I

    move-result v3

    .line 346
    and-int/lit16 v0, v0, 0xff

    shl-int/lit8 v0, v0, 0x0

    and-int/lit16 v1, v1, 0xff

    shl-int/lit8 v1, v1, 0x8

    add-int/2addr v0, v1

    and-int/lit16 v1, v2, 0xff

    shl-int/lit8 v1, v1, 0x10

    add-int/2addr v0, v1

    and-int/lit16 v1, v3, 0xff

    shl-int/lit8 v1, v1, 0x18

    add-int/2addr v0, v1

    return v0
.end method

.method public static readSwappedInteger([BI)I
    .locals 2

    .prologue
    .line 171
    add-int/lit8 v0, p1, 0x0

    aget-byte v0, p0, v0

    and-int/lit16 v0, v0, 0xff

    shl-int/lit8 v0, v0, 0x0

    add-int/lit8 v1, p1, 0x1

    aget-byte v1, p0, v1

    and-int/lit16 v1, v1, 0xff

    shl-int/lit8 v1, v1, 0x8

    add-int/2addr v0, v1

    add-int/lit8 v1, p1, 0x2

    aget-byte v1, p0, v1

    and-int/lit16 v1, v1, 0xff

    shl-int/lit8 v1, v1, 0x10

    add-int/2addr v0, v1

    add-int/lit8 v1, p1, 0x3

    aget-byte v1, p0, v1

    and-int/lit16 v1, v1, 0xff

    shl-int/lit8 v1, v1, 0x18

    add-int/2addr v0, v1

    return v0
.end method

.method public static readSwappedLong(Ljava/io/InputStream;)J
    .locals 5
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljava/io/IOException;
        }
    .end annotation

    .prologue
    const/16 v4, 0x8

    const/4 v1, 0x0

    .line 406
    new-array v2, v4, [B

    move v0, v1

    .line 407
    :goto_0
    if-ge v0, v4, :cond_0

    .line 408
    invoke-static {p0}, Lorg/apache/commons/io/EndianUtils;->read(Ljava/io/InputStream;)I

    move-result v3

    int-to-byte v3, v3

    aput-byte v3, v2, v0

    .line 407
    add-int/lit8 v0, v0, 0x1

    goto :goto_0

    .line 410
    :cond_0
    invoke-static {v2, v1}, Lorg/apache/commons/io/EndianUtils;->readSwappedLong([BI)J

    move-result-wide v0

    return-wide v0
.end method

.method public static readSwappedLong([BI)J
    .locals 6

    .prologue
    .line 221
    invoke-static {p0, p1}, Lorg/apache/commons/io/EndianUtils;->readSwappedInteger([BI)I

    move-result v0

    int-to-long v0, v0

    .line 222
    add-int/lit8 v2, p1, 0x4

    invoke-static {p0, v2}, Lorg/apache/commons/io/EndianUtils;->readSwappedInteger([BI)I

    move-result v2

    int-to-long v2, v2

    .line 223
    const/16 v4, 0x20

    shl-long/2addr v2, v4

    const-wide v4, 0xffffffffL

    and-long/2addr v0, v4

    add-long/2addr v0, v2

    return-wide v0
.end method

.method public static readSwappedShort(Ljava/io/InputStream;)S
    .locals 2
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljava/io/IOException;
        }
    .end annotation

    .prologue
    .line 294
    invoke-static {p0}, Lorg/apache/commons/io/EndianUtils;->read(Ljava/io/InputStream;)I

    move-result v0

    and-int/lit16 v0, v0, 0xff

    shl-int/lit8 v0, v0, 0x0

    invoke-static {p0}, Lorg/apache/commons/io/EndianUtils;->read(Ljava/io/InputStream;)I

    move-result v1

    and-int/lit16 v1, v1, 0xff

    shl-int/lit8 v1, v1, 0x8

    add-int/2addr v0, v1

    int-to-short v0, v0

    return v0
.end method

.method public static readSwappedShort([BI)S
    .locals 2

    .prologue
    .line 132
    add-int/lit8 v0, p1, 0x0

    aget-byte v0, p0, v0

    and-int/lit16 v0, v0, 0xff

    shl-int/lit8 v0, v0, 0x0

    add-int/lit8 v1, p1, 0x1

    aget-byte v1, p0, v1

    and-int/lit16 v1, v1, 0xff

    shl-int/lit8 v1, v1, 0x8

    add-int/2addr v0, v1

    int-to-short v0, v0

    return v0
.end method

.method public static readSwappedUnsignedInteger(Ljava/io/InputStream;)J
    .locals 6
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljava/io/IOException;
        }
    .end annotation

    .prologue
    .line 362
    invoke-static {p0}, Lorg/apache/commons/io/EndianUtils;->read(Ljava/io/InputStream;)I

    move-result v0

    .line 363
    invoke-static {p0}, Lorg/apache/commons/io/EndianUtils;->read(Ljava/io/InputStream;)I

    move-result v1

    .line 364
    invoke-static {p0}, Lorg/apache/commons/io/EndianUtils;->read(Ljava/io/InputStream;)I

    move-result v2

    .line 365
    invoke-static {p0}, Lorg/apache/commons/io/EndianUtils;->read(Ljava/io/InputStream;)I

    move-result v3

    .line 367
    and-int/lit16 v0, v0, 0xff

    shl-int/lit8 v0, v0, 0x0

    and-int/lit16 v1, v1, 0xff

    shl-int/lit8 v1, v1, 0x8

    add-int/2addr v0, v1

    and-int/lit16 v1, v2, 0xff

    shl-int/lit8 v1, v1, 0x10

    add-int/2addr v0, v1

    int-to-long v0, v0

    .line 371
    and-int/lit16 v2, v3, 0xff

    int-to-long v2, v2

    .line 373
    const/16 v4, 0x18

    shl-long/2addr v2, v4

    const-wide v4, 0xffffffffL

    and-long/2addr v0, v4

    add-long/2addr v0, v2

    return-wide v0
.end method

.method public static readSwappedUnsignedInteger([BI)J
    .locals 6

    .prologue
    .line 186
    add-int/lit8 v0, p1, 0x0

    aget-byte v0, p0, v0

    and-int/lit16 v0, v0, 0xff

    shl-int/lit8 v0, v0, 0x0

    add-int/lit8 v1, p1, 0x1

    aget-byte v1, p0, v1

    and-int/lit16 v1, v1, 0xff

    shl-int/lit8 v1, v1, 0x8

    add-int/2addr v0, v1

    add-int/lit8 v1, p1, 0x2

    aget-byte v1, p0, v1

    and-int/lit16 v1, v1, 0xff

    shl-int/lit8 v1, v1, 0x10

    add-int/2addr v0, v1

    int-to-long v0, v0

    .line 190
    add-int/lit8 v2, p1, 0x3

    aget-byte v2, p0, v2

    and-int/lit16 v2, v2, 0xff

    int-to-long v2, v2

    .line 192
    const/16 v4, 0x18

    shl-long/2addr v2, v4

    const-wide v4, 0xffffffffL

    and-long/2addr v0, v4

    add-long/2addr v0, v2

    return-wide v0
.end method

.method public static readSwappedUnsignedShort(Ljava/io/InputStream;)I
    .locals 2
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljava/io/IOException;
        }
    .end annotation

    .prologue
    .line 308
    invoke-static {p0}, Lorg/apache/commons/io/EndianUtils;->read(Ljava/io/InputStream;)I

    move-result v0

    .line 309
    invoke-static {p0}, Lorg/apache/commons/io/EndianUtils;->read(Ljava/io/InputStream;)I

    move-result v1

    .line 311
    and-int/lit16 v0, v0, 0xff

    shl-int/lit8 v0, v0, 0x0

    and-int/lit16 v1, v1, 0xff

    shl-int/lit8 v1, v1, 0x8

    add-int/2addr v0, v1

    return v0
.end method

.method public static readSwappedUnsignedShort([BI)I
    .locals 2

    .prologue
    .line 145
    add-int/lit8 v0, p1, 0x0

    aget-byte v0, p0, v0

    and-int/lit16 v0, v0, 0xff

    shl-int/lit8 v0, v0, 0x0

    add-int/lit8 v1, p1, 0x1

    aget-byte v1, p0, v1

    and-int/lit16 v1, v1, 0xff

    shl-int/lit8 v1, v1, 0x8

    add-int/2addr v0, v1

    return v0
.end method

.method public static swapDouble(D)D
    .locals 2

    .prologue
    .line 107
    invoke-static {p0, p1}, Ljava/lang/Double;->doubleToLongBits(D)J

    move-result-wide v0

    invoke-static {v0, v1}, Lorg/apache/commons/io/EndianUtils;->swapLong(J)J

    move-result-wide v0

    invoke-static {v0, v1}, Ljava/lang/Double;->longBitsToDouble(J)D

    move-result-wide v0

    return-wide v0
.end method

.method public static swapFloat(F)F
    .locals 1

    .prologue
    .line 98
    invoke-static {p0}, Ljava/lang/Float;->floatToIntBits(F)I

    move-result v0

    invoke-static {v0}, Lorg/apache/commons/io/EndianUtils;->swapInteger(I)I

    move-result v0

    invoke-static {v0}, Ljava/lang/Float;->intBitsToFloat(I)F

    move-result v0

    return v0
.end method

.method public static swapInteger(I)I
    .locals 2

    .prologue
    .line 68
    shr-int/lit8 v0, p0, 0x0

    and-int/lit16 v0, v0, 0xff

    shl-int/lit8 v0, v0, 0x18

    shr-int/lit8 v1, p0, 0x8

    and-int/lit16 v1, v1, 0xff

    shl-int/lit8 v1, v1, 0x10

    add-int/2addr v0, v1

    shr-int/lit8 v1, p0, 0x10

    and-int/lit16 v1, v1, 0xff

    shl-int/lit8 v1, v1, 0x8

    add-int/2addr v0, v1

    shr-int/lit8 v1, p0, 0x18

    and-int/lit16 v1, v1, 0xff

    shl-int/lit8 v1, v1, 0x0

    add-int/2addr v0, v1

    return v0
.end method

.method public static swapLong(J)J
    .locals 12

    .prologue
    const/16 v10, 0x18

    const/16 v9, 0x10

    const/16 v8, 0x8

    const/4 v5, 0x0

    const-wide/16 v6, 0xff

    .line 81
    shr-long v0, p0, v5

    and-long/2addr v0, v6

    const/16 v2, 0x38

    shl-long/2addr v0, v2

    shr-long v2, p0, v8

    and-long/2addr v2, v6

    const/16 v4, 0x30

    shl-long/2addr v2, v4

    add-long/2addr v0, v2

    shr-long v2, p0, v9

    and-long/2addr v2, v6

    const/16 v4, 0x28

    shl-long/2addr v2, v4

    add-long/2addr v0, v2

    shr-long v2, p0, v10

    and-long/2addr v2, v6

    const/16 v4, 0x20

    shl-long/2addr v2, v4

    add-long/2addr v0, v2

    const/16 v2, 0x20

    shr-long v2, p0, v2

    and-long/2addr v2, v6

    shl-long/2addr v2, v10

    add-long/2addr v0, v2

    const/16 v2, 0x28

    shr-long v2, p0, v2

    and-long/2addr v2, v6

    shl-long/2addr v2, v9

    add-long/2addr v0, v2

    const/16 v2, 0x30

    shr-long v2, p0, v2

    and-long/2addr v2, v6

    shl-long/2addr v2, v8

    add-long/2addr v0, v2

    const/16 v2, 0x38

    shr-long v2, p0, v2

    and-long/2addr v2, v6

    shl-long/2addr v2, v5

    add-long/2addr v0, v2

    return-wide v0
.end method

.method public static swapShort(S)S
    .locals 2

    .prologue
    .line 58
    shr-int/lit8 v0, p0, 0x0

    and-int/lit16 v0, v0, 0xff

    shl-int/lit8 v0, v0, 0x8

    shr-int/lit8 v1, p0, 0x8

    and-int/lit16 v1, v1, 0xff

    shl-int/lit8 v1, v1, 0x0

    add-int/2addr v0, v1

    int-to-short v0, v0

    return v0
.end method

.method public static writeSwappedDouble(Ljava/io/OutputStream;D)V
    .locals 3
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljava/io/IOException;
        }
    .end annotation

    .prologue
    .line 449
    invoke-static {p1, p2}, Ljava/lang/Double;->doubleToLongBits(D)J

    move-result-wide v0

    invoke-static {p0, v0, v1}, Lorg/apache/commons/io/EndianUtils;->writeSwappedLong(Ljava/io/OutputStream;J)V

    .line 450
    return-void
.end method

.method public static writeSwappedDouble([BID)V
    .locals 2

    .prologue
    .line 256
    invoke-static {p2, p3}, Ljava/lang/Double;->doubleToLongBits(D)J

    move-result-wide v0

    invoke-static {p0, p1, v0, v1}, Lorg/apache/commons/io/EndianUtils;->writeSwappedLong([BIJ)V

    .line 257
    return-void
.end method

.method public static writeSwappedFloat(Ljava/io/OutputStream;F)V
    .locals 1
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljava/io/IOException;
        }
    .end annotation

    .prologue
    .line 423
    invoke-static {p1}, Ljava/lang/Float;->floatToIntBits(F)I

    move-result v0

    invoke-static {p0, v0}, Lorg/apache/commons/io/EndianUtils;->writeSwappedInteger(Ljava/io/OutputStream;I)V

    .line 424
    return-void
.end method

.method public static writeSwappedFloat([BIF)V
    .locals 1

    .prologue
    .line 234
    invoke-static {p2}, Ljava/lang/Float;->floatToIntBits(F)I

    move-result v0

    invoke-static {p0, p1, v0}, Lorg/apache/commons/io/EndianUtils;->writeSwappedInteger([BII)V

    .line 235
    return-void
.end method

.method public static writeSwappedInteger(Ljava/io/OutputStream;I)V
    .locals 1
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljava/io/IOException;
        }
    .end annotation

    .prologue
    .line 325
    shr-int/lit8 v0, p1, 0x0

    and-int/lit16 v0, v0, 0xff

    int-to-byte v0, v0

    invoke-virtual {p0, v0}, Ljava/io/OutputStream;->write(I)V

    .line 326
    shr-int/lit8 v0, p1, 0x8

    and-int/lit16 v0, v0, 0xff

    int-to-byte v0, v0

    invoke-virtual {p0, v0}, Ljava/io/OutputStream;->write(I)V

    .line 327
    shr-int/lit8 v0, p1, 0x10

    and-int/lit16 v0, v0, 0xff

    int-to-byte v0, v0

    invoke-virtual {p0, v0}, Ljava/io/OutputStream;->write(I)V

    .line 328
    shr-int/lit8 v0, p1, 0x18

    and-int/lit16 v0, v0, 0xff

    int-to-byte v0, v0

    invoke-virtual {p0, v0}, Ljava/io/OutputStream;->write(I)V

    .line 329
    return-void
.end method

.method public static writeSwappedInteger([BII)V
    .locals 2

    .prologue
    .line 157
    add-int/lit8 v0, p1, 0x0

    shr-int/lit8 v1, p2, 0x0

    and-int/lit16 v1, v1, 0xff

    int-to-byte v1, v1

    aput-byte v1, p0, v0

    .line 158
    add-int/lit8 v0, p1, 0x1

    shr-int/lit8 v1, p2, 0x8

    and-int/lit16 v1, v1, 0xff

    int-to-byte v1, v1

    aput-byte v1, p0, v0

    .line 159
    add-int/lit8 v0, p1, 0x2

    shr-int/lit8 v1, p2, 0x10

    and-int/lit16 v1, v1, 0xff

    int-to-byte v1, v1

    aput-byte v1, p0, v0

    .line 160
    add-int/lit8 v0, p1, 0x3

    shr-int/lit8 v1, p2, 0x18

    and-int/lit16 v1, v1, 0xff

    int-to-byte v1, v1

    aput-byte v1, p0, v0

    .line 161
    return-void
.end method

.method public static writeSwappedLong(Ljava/io/OutputStream;J)V
    .locals 5
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljava/io/IOException;
        }
    .end annotation

    .prologue
    const-wide/16 v2, 0xff

    .line 386
    const/4 v0, 0x0

    shr-long v0, p1, v0

    and-long/2addr v0, v2

    long-to-int v0, v0

    int-to-byte v0, v0

    invoke-virtual {p0, v0}, Ljava/io/OutputStream;->write(I)V

    .line 387
    const/16 v0, 0x8

    shr-long v0, p1, v0

    and-long/2addr v0, v2

    long-to-int v0, v0

    int-to-byte v0, v0

    invoke-virtual {p0, v0}, Ljava/io/OutputStream;->write(I)V

    .line 388
    const/16 v0, 0x10

    shr-long v0, p1, v0

    and-long/2addr v0, v2

    long-to-int v0, v0

    int-to-byte v0, v0

    invoke-virtual {p0, v0}, Ljava/io/OutputStream;->write(I)V

    .line 389
    const/16 v0, 0x18

    shr-long v0, p1, v0

    and-long/2addr v0, v2

    long-to-int v0, v0

    int-to-byte v0, v0

    invoke-virtual {p0, v0}, Ljava/io/OutputStream;->write(I)V

    .line 390
    const/16 v0, 0x20

    shr-long v0, p1, v0

    and-long/2addr v0, v2

    long-to-int v0, v0

    int-to-byte v0, v0

    invoke-virtual {p0, v0}, Ljava/io/OutputStream;->write(I)V

    .line 391
    const/16 v0, 0x28

    shr-long v0, p1, v0

    and-long/2addr v0, v2

    long-to-int v0, v0

    int-to-byte v0, v0

    invoke-virtual {p0, v0}, Ljava/io/OutputStream;->write(I)V

    .line 392
    const/16 v0, 0x30

    shr-long v0, p1, v0

    and-long/2addr v0, v2

    long-to-int v0, v0

    int-to-byte v0, v0

    invoke-virtual {p0, v0}, Ljava/io/OutputStream;->write(I)V

    .line 393
    const/16 v0, 0x38

    shr-long v0, p1, v0

    and-long/2addr v0, v2

    long-to-int v0, v0

    int-to-byte v0, v0

    invoke-virtual {p0, v0}, Ljava/io/OutputStream;->write(I)V

    .line 394
    return-void
.end method

.method public static writeSwappedLong([BIJ)V
    .locals 6

    .prologue
    const-wide/16 v4, 0xff

    .line 203
    add-int/lit8 v0, p1, 0x0

    const/4 v1, 0x0

    shr-long v2, p2, v1

    and-long/2addr v2, v4

    long-to-int v1, v2

    int-to-byte v1, v1

    aput-byte v1, p0, v0

    .line 204
    add-int/lit8 v0, p1, 0x1

    const/16 v1, 0x8

    shr-long v2, p2, v1

    and-long/2addr v2, v4

    long-to-int v1, v2

    int-to-byte v1, v1

    aput-byte v1, p0, v0

    .line 205
    add-int/lit8 v0, p1, 0x2

    const/16 v1, 0x10

    shr-long v2, p2, v1

    and-long/2addr v2, v4

    long-to-int v1, v2

    int-to-byte v1, v1

    aput-byte v1, p0, v0

    .line 206
    add-int/lit8 v0, p1, 0x3

    const/16 v1, 0x18

    shr-long v2, p2, v1

    and-long/2addr v2, v4

    long-to-int v1, v2

    int-to-byte v1, v1

    aput-byte v1, p0, v0

    .line 207
    add-int/lit8 v0, p1, 0x4

    const/16 v1, 0x20

    shr-long v2, p2, v1

    and-long/2addr v2, v4

    long-to-int v1, v2

    int-to-byte v1, v1

    aput-byte v1, p0, v0

    .line 208
    add-int/lit8 v0, p1, 0x5

    const/16 v1, 0x28

    shr-long v2, p2, v1

    and-long/2addr v2, v4

    long-to-int v1, v2

    int-to-byte v1, v1

    aput-byte v1, p0, v0

    .line 209
    add-int/lit8 v0, p1, 0x6

    const/16 v1, 0x30

    shr-long v2, p2, v1

    and-long/2addr v2, v4

    long-to-int v1, v2

    int-to-byte v1, v1

    aput-byte v1, p0, v0

    .line 210
    add-int/lit8 v0, p1, 0x7

    const/16 v1, 0x38

    shr-long v2, p2, v1

    and-long/2addr v2, v4

    long-to-int v1, v2

    int-to-byte v1, v1

    aput-byte v1, p0, v0

    .line 211
    return-void
.end method

.method public static writeSwappedShort(Ljava/io/OutputStream;S)V
    .locals 1
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljava/io/IOException;
        }
    .end annotation

    .prologue
    .line 280
    shr-int/lit8 v0, p1, 0x0

    and-int/lit16 v0, v0, 0xff

    int-to-byte v0, v0

    invoke-virtual {p0, v0}, Ljava/io/OutputStream;->write(I)V

    .line 281
    shr-int/lit8 v0, p1, 0x8

    and-int/lit16 v0, v0, 0xff

    int-to-byte v0, v0

    invoke-virtual {p0, v0}, Ljava/io/OutputStream;->write(I)V

    .line 282
    return-void
.end method

.method public static writeSwappedShort([BIS)V
    .locals 2

    .prologue
    .line 120
    add-int/lit8 v0, p1, 0x0

    shr-int/lit8 v1, p2, 0x0

    and-int/lit16 v1, v1, 0xff

    int-to-byte v1, v1

    aput-byte v1, p0, v0

    .line 121
    add-int/lit8 v0, p1, 0x1

    shr-int/lit8 v1, p2, 0x8

    and-int/lit16 v1, v1, 0xff

    int-to-byte v1, v1

    aput-byte v1, p0, v0

    .line 122
    return-void
.end method
