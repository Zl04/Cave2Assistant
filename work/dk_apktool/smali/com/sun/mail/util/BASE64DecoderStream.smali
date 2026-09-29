.class public Lcom/sun/mail/util/BASE64DecoderStream;
.super Ljava/io/FilterInputStream;
.source "SourceFile"


# static fields
.field private static final pem_array:[C

.field private static final pem_convert_array:[B


# instance fields
.field private buffer:[B

.field private bufsize:I

.field private ignoreErrors:Z

.field private index:I

.field private input_buffer:[B

.field private input_len:I

.field private input_pos:I


# direct methods
.method static constructor <clinit>()V
    .locals 4

    .prologue
    const/4 v0, 0x0

    .line 198
    const/16 v1, 0x40

    new-array v1, v1, [C

    fill-array-data v1, :array_0

    sput-object v1, Lcom/sun/mail/util/BASE64DecoderStream;->pem_array:[C

    .line 209
    const/16 v1, 0x100

    new-array v1, v1, [B

    sput-object v1, Lcom/sun/mail/util/BASE64DecoderStream;->pem_convert_array:[B

    move v1, v0

    .line 212
    :goto_0
    const/16 v2, 0xff

    if-lt v1, v2, :cond_0

    .line 214
    :goto_1
    sget-object v1, Lcom/sun/mail/util/BASE64DecoderStream;->pem_array:[C

    array-length v1, v1

    if-lt v0, v1, :cond_1

    .line 55
    return-void

    .line 213
    :cond_0
    sget-object v2, Lcom/sun/mail/util/BASE64DecoderStream;->pem_convert_array:[B

    const/4 v3, -0x1

    aput-byte v3, v2, v1

    .line 212
    add-int/lit8 v1, v1, 0x1

    goto :goto_0

    .line 215
    :cond_1
    sget-object v1, Lcom/sun/mail/util/BASE64DecoderStream;->pem_convert_array:[B

    sget-object v2, Lcom/sun/mail/util/BASE64DecoderStream;->pem_array:[C

    aget-char v2, v2, v0

    int-to-byte v3, v0

    aput-byte v3, v1, v2

    .line 214
    add-int/lit8 v0, v0, 0x1

    goto :goto_1

    .line 198
    nop

    :array_0
    .array-data 2
        0x41s
        0x42s
        0x43s
        0x44s
        0x45s
        0x46s
        0x47s
        0x48s
        0x49s
        0x4as
        0x4bs
        0x4cs
        0x4ds
        0x4es
        0x4fs
        0x50s
        0x51s
        0x52s
        0x53s
        0x54s
        0x55s
        0x56s
        0x57s
        0x58s
        0x59s
        0x5as
        0x61s
        0x62s
        0x63s
        0x64s
        0x65s
        0x66s
        0x67s
        0x68s
        0x69s
        0x6as
        0x6bs
        0x6cs
        0x6ds
        0x6es
        0x6fs
        0x70s
        0x71s
        0x72s
        0x73s
        0x74s
        0x75s
        0x76s
        0x77s
        0x78s
        0x79s
        0x7as
        0x30s
        0x31s
        0x32s
        0x33s
        0x34s
        0x35s
        0x36s
        0x37s
        0x38s
        0x39s
        0x2bs
        0x2fs
    .end array-data
.end method

.method public constructor <init>(Ljava/io/InputStream;)V
    .locals 3

    .prologue
    const/4 v0, 0x0

    .line 78
    invoke-direct {p0, p1}, Ljava/io/FilterInputStream;-><init>(Ljava/io/InputStream;)V

    .line 57
    const/4 v1, 0x3

    new-array v1, v1, [B

    iput-object v1, p0, Lcom/sun/mail/util/BASE64DecoderStream;->buffer:[B

    .line 58
    iput v0, p0, Lcom/sun/mail/util/BASE64DecoderStream;->bufsize:I

    .line 59
    iput v0, p0, Lcom/sun/mail/util/BASE64DecoderStream;->index:I

    .line 63
    const/16 v1, 0x1ffe

    new-array v1, v1, [B

    iput-object v1, p0, Lcom/sun/mail/util/BASE64DecoderStream;->input_buffer:[B

    .line 64
    iput v0, p0, Lcom/sun/mail/util/BASE64DecoderStream;->input_pos:I

    .line 65
    iput v0, p0, Lcom/sun/mail/util/BASE64DecoderStream;->input_len:I

    .line 67
    iput-boolean v0, p0, Lcom/sun/mail/util/BASE64DecoderStream;->ignoreErrors:Z

    .line 80
    :try_start_0
    const-string v1, "mail.mime.base64.ignoreerrors"

    invoke-static {v1}, Ljava/lang/System;->getProperty(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v1

    .line 82
    if-eqz v1, :cond_0

    const-string v2, "false"

    invoke-virtual {v1, v2}, Ljava/lang/String;->equalsIgnoreCase(Ljava/lang/String;)Z

    move-result v1

    if-nez v1, :cond_0

    const/4 v0, 0x1

    :cond_0
    iput-boolean v0, p0, Lcom/sun/mail/util/BASE64DecoderStream;->ignoreErrors:Z
    :try_end_0
    .catch Ljava/lang/SecurityException; {:try_start_0 .. :try_end_0} :catch_0

    .line 86
    :goto_0
    return-void

    .line 83
    :catch_0
    move-exception v0

    goto :goto_0
.end method

.method public constructor <init>(Ljava/io/InputStream;Z)V
    .locals 2

    .prologue
    const/4 v1, 0x0

    .line 95
    invoke-direct {p0, p1}, Ljava/io/FilterInputStream;-><init>(Ljava/io/InputStream;)V

    .line 57
    const/4 v0, 0x3

    new-array v0, v0, [B

    iput-object v0, p0, Lcom/sun/mail/util/BASE64DecoderStream;->buffer:[B

    .line 58
    iput v1, p0, Lcom/sun/mail/util/BASE64DecoderStream;->bufsize:I

    .line 59
    iput v1, p0, Lcom/sun/mail/util/BASE64DecoderStream;->index:I

    .line 63
    const/16 v0, 0x1ffe

    new-array v0, v0, [B

    iput-object v0, p0, Lcom/sun/mail/util/BASE64DecoderStream;->input_buffer:[B

    .line 64
    iput v1, p0, Lcom/sun/mail/util/BASE64DecoderStream;->input_pos:I

    .line 65
    iput v1, p0, Lcom/sun/mail/util/BASE64DecoderStream;->input_len:I

    .line 67
    iput-boolean v1, p0, Lcom/sun/mail/util/BASE64DecoderStream;->ignoreErrors:Z

    .line 96
    iput-boolean p2, p0, Lcom/sun/mail/util/BASE64DecoderStream;->ignoreErrors:Z

    .line 97
    return-void
.end method

.method private decode([BII)I
    .locals 10
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljava/io/IOException;
        }
    .end annotation

    .prologue
    const/4 v9, 0x2

    const/4 v0, 0x1

    const/4 v8, -0x2

    const/4 v1, 0x0

    const/4 v7, -0x1

    .line 233
    move v5, p2

    .line 234
    :goto_0
    const/4 v2, 0x3

    if-ge p3, v2, :cond_0

    .line 334
    sub-int v0, v5, p2

    :goto_1
    return v0

    :cond_0
    move v4, v1

    move v2, v1

    .line 242
    :goto_2
    const/4 v3, 0x4

    if-lt v2, v3, :cond_1

    .line 326
    add-int/lit8 v2, v5, 0x2

    and-int/lit16 v3, v4, 0xff

    int-to-byte v3, v3

    aput-byte v3, p1, v2

    .line 327
    shr-int/lit8 v2, v4, 0x8

    .line 328
    add-int/lit8 v3, v5, 0x1

    and-int/lit16 v4, v2, 0xff

    int-to-byte v4, v4

    aput-byte v4, p1, v3

    .line 329
    shr-int/lit8 v2, v2, 0x8

    .line 330
    and-int/lit16 v2, v2, 0xff

    int-to-byte v2, v2

    aput-byte v2, p1, v5

    .line 331
    add-int/lit8 p3, p3, -0x3

    .line 332
    add-int/lit8 v2, v5, 0x3

    move v5, v2

    goto :goto_0

    .line 243
    :cond_1
    invoke-direct {p0}, Lcom/sun/mail/util/BASE64DecoderStream;->getByte()I

    move-result v6

    .line 244
    if-eq v6, v7, :cond_2

    if-ne v6, v8, :cond_c

    .line 246
    :cond_2
    if-ne v6, v7, :cond_6

    .line 247
    if-nez v2, :cond_3

    .line 248
    sub-int v0, v5, p2

    goto :goto_1

    .line 249
    :cond_3
    iget-boolean v1, p0, Lcom/sun/mail/util/BASE64DecoderStream;->ignoreErrors:Z

    if-nez v1, :cond_4

    .line 250
    new-instance v0, Ljava/io/IOException;

    new-instance v1, Ljava/lang/StringBuilder;

    const-string v3, "Error in encoded stream: needed 4 valid base64 characters but only got "

    invoke-direct {v1, v3}, Ljava/lang/StringBuilder;-><init>(Ljava/lang/String;)V

    .line 252
    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v1

    const-string v2, " before EOF"

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    .line 253
    invoke-direct {p0}, Lcom/sun/mail/util/BASE64DecoderStream;->recentChars()Ljava/lang/String;

    move-result-object v2

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v1

    .line 250
    invoke-direct {v0, v1}, Ljava/io/IOException;-><init>(Ljava/lang/String;)V

    throw v0

    :cond_4
    move v3, v0

    .line 275
    :goto_3
    add-int/lit8 v1, v2, -0x1

    .line 276
    if-nez v1, :cond_d

    .line 280
    :goto_4
    add-int/lit8 v2, v2, 0x1

    .line 281
    shl-int/lit8 v1, v4, 0x6

    .line 283
    :goto_5
    const/4 v4, 0x4

    if-lt v2, v4, :cond_9

    .line 309
    shr-int/lit8 v1, v1, 0x8

    .line 310
    if-ne v0, v9, :cond_5

    .line 311
    add-int/lit8 v2, v5, 0x1

    and-int/lit16 v3, v1, 0xff

    int-to-byte v3, v3

    aput-byte v3, p1, v2

    .line 312
    :cond_5
    shr-int/lit8 v1, v1, 0x8

    .line 313
    and-int/lit16 v1, v1, 0xff

    int-to-byte v1, v1

    aput-byte v1, p1, v5

    .line 315
    add-int/2addr v0, v5

    .line 316
    sub-int/2addr v0, p2

    goto :goto_1

    .line 258
    :cond_6
    if-ge v2, v9, :cond_7

    iget-boolean v3, p0, Lcom/sun/mail/util/BASE64DecoderStream;->ignoreErrors:Z

    if-nez v3, :cond_7

    .line 259
    new-instance v0, Ljava/io/IOException;

    new-instance v1, Ljava/lang/StringBuilder;

    const-string v3, "Error in encoded stream: needed at least 2 valid base64 characters, but only got "

    invoke-direct {v1, v3}, Ljava/lang/StringBuilder;-><init>(Ljava/lang/String;)V

    .line 261
    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v1

    .line 262
    const-string v2, " before padding character (=)"

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    .line 263
    invoke-direct {p0}, Lcom/sun/mail/util/BASE64DecoderStream;->recentChars()Ljava/lang/String;

    move-result-object v2

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v1

    .line 259
    invoke-direct {v0, v1}, Ljava/io/IOException;-><init>(Ljava/lang/String;)V

    throw v0

    .line 266
    :cond_7
    if-nez v2, :cond_8

    .line 267
    sub-int v0, v5, p2

    goto/16 :goto_1

    :cond_8
    move v3, v1

    .line 268
    goto :goto_3

    .line 284
    :cond_9
    if-nez v3, :cond_b

    .line 287
    invoke-direct {p0}, Lcom/sun/mail/util/BASE64DecoderStream;->getByte()I

    move-result v4

    .line 288
    if-ne v4, v7, :cond_a

    .line 289
    iget-boolean v4, p0, Lcom/sun/mail/util/BASE64DecoderStream;->ignoreErrors:Z

    if-nez v4, :cond_b

    .line 290
    new-instance v0, Ljava/io/IOException;

    .line 291
    new-instance v1, Ljava/lang/StringBuilder;

    const-string v2, "Error in encoded stream: hit EOF while looking for padding characters (=)"

    invoke-direct {v1, v2}, Ljava/lang/StringBuilder;-><init>(Ljava/lang/String;)V

    .line 294
    invoke-direct {p0}, Lcom/sun/mail/util/BASE64DecoderStream;->recentChars()Ljava/lang/String;

    move-result-object v2

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    .line 291
    invoke-virtual {v1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v1

    .line 290
    invoke-direct {v0, v1}, Ljava/io/IOException;-><init>(Ljava/lang/String;)V

    throw v0

    .line 295
    :cond_a
    if-eq v4, v8, :cond_b

    .line 296
    iget-boolean v4, p0, Lcom/sun/mail/util/BASE64DecoderStream;->ignoreErrors:Z

    if-nez v4, :cond_b

    .line 297
    new-instance v0, Ljava/io/IOException;

    .line 298
    new-instance v1, Ljava/lang/StringBuilder;

    const-string v2, "Error in encoded stream: found valid base64 character after a padding character (=)"

    invoke-direct {v1, v2}, Ljava/lang/StringBuilder;-><init>(Ljava/lang/String;)V

    .line 301
    invoke-direct {p0}, Lcom/sun/mail/util/BASE64DecoderStream;->recentChars()Ljava/lang/String;

    move-result-object v2

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    .line 298
    invoke-virtual {v1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v1

    .line 297
    invoke-direct {v0, v1}, Ljava/io/IOException;-><init>(Ljava/lang/String;)V

    throw v0

    .line 304
    :cond_b
    shl-int/lit8 v1, v1, 0x6

    .line 305
    add-int/lit8 v2, v2, 0x1

    goto/16 :goto_5

    .line 319
    :cond_c
    shl-int/lit8 v4, v4, 0x6

    .line 320
    add-int/lit8 v3, v2, 0x1

    .line 321
    or-int v2, v4, v6

    move v4, v2

    move v2, v3

    goto/16 :goto_2

    :cond_d
    move v0, v1

    goto/16 :goto_4
.end method

.method public static decode([B)[B
    .locals 10

    .prologue
    const/4 v1, 0x2

    const/4 v2, 0x0

    const/16 v9, 0x3d

    .line 409
    array-length v0, p0

    div-int/lit8 v0, v0, 0x4

    mul-int/lit8 v0, v0, 0x3

    .line 410
    if-nez v0, :cond_0

    .line 448
    :goto_0
    return-object p0

    .line 413
    :cond_0
    array-length v3, p0

    add-int/lit8 v3, v3, -0x1

    aget-byte v3, p0, v3

    if-ne v3, v9, :cond_1

    .line 414
    add-int/lit8 v0, v0, -0x1

    .line 415
    array-length v3, p0

    add-int/lit8 v3, v3, -0x2

    aget-byte v3, p0, v3

    if-ne v3, v9, :cond_1

    .line 416
    add-int/lit8 v0, v0, -0x1

    .line 418
    :cond_1
    new-array v5, v0, [B

    .line 421
    array-length v0, p0

    move v6, v2

    move v7, v0

    .line 422
    :goto_1
    if-gtz v7, :cond_2

    move-object p0, v5

    .line 448
    goto :goto_0

    .line 424
    :cond_2
    const/4 v0, 0x3

    .line 425
    sget-object v3, Lcom/sun/mail/util/BASE64DecoderStream;->pem_convert_array:[B

    add-int/lit8 v8, v2, 0x1

    aget-byte v2, p0, v2

    and-int/lit16 v2, v2, 0xff

    aget-byte v2, v3, v2

    .line 426
    shl-int/lit8 v2, v2, 0x6

    .line 427
    sget-object v3, Lcom/sun/mail/util/BASE64DecoderStream;->pem_convert_array:[B

    add-int/lit8 v4, v8, 0x1

    aget-byte v8, p0, v8

    and-int/lit16 v8, v8, 0xff

    aget-byte v3, v3, v8

    or-int/2addr v2, v3

    .line 428
    shl-int/lit8 v2, v2, 0x6

    .line 429
    aget-byte v3, p0, v4

    if-eq v3, v9, :cond_5

    .line 430
    sget-object v8, Lcom/sun/mail/util/BASE64DecoderStream;->pem_convert_array:[B

    add-int/lit8 v3, v4, 0x1

    aget-byte v4, p0, v4

    and-int/lit16 v4, v4, 0xff

    aget-byte v4, v8, v4

    or-int/2addr v2, v4

    .line 433
    :goto_2
    shl-int/lit8 v2, v2, 0x6

    .line 434
    aget-byte v4, p0, v3

    if-eq v4, v9, :cond_6

    .line 435
    sget-object v8, Lcom/sun/mail/util/BASE64DecoderStream;->pem_convert_array:[B

    add-int/lit8 v4, v3, 0x1

    aget-byte v3, p0, v3

    and-int/lit16 v3, v3, 0xff

    aget-byte v3, v8, v3

    or-int/2addr v2, v3

    move v3, v4

    .line 438
    :goto_3
    if-le v0, v1, :cond_3

    .line 439
    add-int/lit8 v4, v6, 0x2

    and-int/lit16 v8, v2, 0xff

    int-to-byte v8, v8

    aput-byte v8, v5, v4

    .line 440
    :cond_3
    shr-int/lit8 v2, v2, 0x8

    .line 441
    const/4 v4, 0x1

    if-le v0, v4, :cond_4

    .line 442
    add-int/lit8 v4, v6, 0x1

    and-int/lit16 v8, v2, 0xff

    int-to-byte v8, v8

    aput-byte v8, v5, v4

    .line 443
    :cond_4
    shr-int/lit8 v2, v2, 0x8

    .line 444
    and-int/lit16 v2, v2, 0xff

    int-to-byte v2, v2

    aput-byte v2, v5, v6

    .line 445
    add-int/2addr v0, v6

    .line 446
    add-int/lit8 v2, v7, -0x4

    move v6, v0

    move v7, v2

    move v2, v3

    goto :goto_1

    :cond_5
    move v0, v1

    move v3, v4

    .line 432
    goto :goto_2

    .line 437
    :cond_6
    add-int/lit8 v0, v0, -0x1

    goto :goto_3
.end method

.method private getByte()I
    .locals 4
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljava/io/IOException;
        }
    .end annotation

    .prologue
    const/4 v0, -0x1

    .line 348
    :cond_0
    iget v1, p0, Lcom/sun/mail/util/BASE64DecoderStream;->input_pos:I

    iget v2, p0, Lcom/sun/mail/util/BASE64DecoderStream;->input_len:I

    if-lt v1, v2, :cond_2

    .line 350
    :try_start_0
    iget-object v1, p0, Lcom/sun/mail/util/BASE64DecoderStream;->in:Ljava/io/InputStream;

    iget-object v2, p0, Lcom/sun/mail/util/BASE64DecoderStream;->input_buffer:[B

    invoke-virtual {v1, v2}, Ljava/io/InputStream;->read([B)I

    move-result v1

    iput v1, p0, Lcom/sun/mail/util/BASE64DecoderStream;->input_len:I
    :try_end_0
    .catch Ljava/io/EOFException; {:try_start_0 .. :try_end_0} :catch_0

    .line 354
    iget v1, p0, Lcom/sun/mail/util/BASE64DecoderStream;->input_len:I

    if-gtz v1, :cond_1

    .line 367
    :goto_0
    return v0

    .line 356
    :cond_1
    const/4 v1, 0x0

    iput v1, p0, Lcom/sun/mail/util/BASE64DecoderStream;->input_pos:I

    .line 359
    :cond_2
    iget-object v1, p0, Lcom/sun/mail/util/BASE64DecoderStream;->input_buffer:[B

    iget v2, p0, Lcom/sun/mail/util/BASE64DecoderStream;->input_pos:I

    add-int/lit8 v3, v2, 0x1

    iput v3, p0, Lcom/sun/mail/util/BASE64DecoderStream;->input_pos:I

    aget-byte v1, v1, v2

    and-int/lit16 v1, v1, 0xff

    .line 361
    const/16 v2, 0x3d

    if-ne v1, v2, :cond_3

    .line 362
    const/4 v0, -0x2

    goto :goto_0

    .line 364
    :cond_3
    sget-object v2, Lcom/sun/mail/util/BASE64DecoderStream;->pem_convert_array:[B

    aget-byte v1, v2, v1

    .line 366
    if-eq v1, v0, :cond_0

    move v0, v1

    .line 367
    goto :goto_0

    .line 351
    :catch_0
    move-exception v1

    goto :goto_0
.end method

.method private recentChars()Ljava/lang/String;
    .locals 4

    .prologue
    const/16 v1, 0xa

    .line 376
    const-string v0, ""

    .line 377
    iget v2, p0, Lcom/sun/mail/util/BASE64DecoderStream;->input_pos:I

    if-le v2, v1, :cond_1

    move v2, v1

    .line 378
    :goto_0
    if-lez v2, :cond_0

    .line 379
    new-instance v1, Ljava/lang/StringBuilder;

    invoke-static {v0}, Ljava/lang/String;->valueOf(Ljava/lang/Object;)Ljava/lang/String;

    move-result-object v0

    invoke-direct {v1, v0}, Ljava/lang/StringBuilder;-><init>(Ljava/lang/String;)V

    const-string v0, ", the "

    invoke-virtual {v1, v0}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-virtual {v0, v2}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v0

    .line 380
    const-string v1, " most recent characters were: \""

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    .line 379
    invoke-virtual {v0}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v1

    .line 381
    iget v0, p0, Lcom/sun/mail/util/BASE64DecoderStream;->input_pos:I

    sub-int/2addr v0, v2

    :goto_1
    iget v2, p0, Lcom/sun/mail/util/BASE64DecoderStream;->input_pos:I

    if-lt v0, v2, :cond_2

    .line 394
    new-instance v0, Ljava/lang/StringBuilder;

    invoke-static {v1}, Ljava/lang/String;->valueOf(Ljava/lang/Object;)Ljava/lang/String;

    move-result-object v1

    invoke-direct {v0, v1}, Ljava/lang/StringBuilder;-><init>(Ljava/lang/String;)V

    const-string v1, "\""

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-virtual {v0}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v0

    .line 396
    :cond_0
    return-object v0

    .line 377
    :cond_1
    iget v1, p0, Lcom/sun/mail/util/BASE64DecoderStream;->input_pos:I

    move v2, v1

    goto :goto_0

    .line 382
    :cond_2
    iget-object v2, p0, Lcom/sun/mail/util/BASE64DecoderStream;->input_buffer:[B

    aget-byte v2, v2, v0

    and-int/lit16 v2, v2, 0xff

    int-to-char v2, v2

    .line 383
    packed-switch v2, :pswitch_data_0

    .line 388
    :pswitch_0
    const/16 v3, 0x20

    if-lt v2, v3, :cond_3

    const/16 v3, 0x7f

    if-ge v2, v3, :cond_3

    .line 389
    new-instance v3, Ljava/lang/StringBuilder;

    invoke-static {v1}, Ljava/lang/String;->valueOf(Ljava/lang/Object;)Ljava/lang/String;

    move-result-object v1

    invoke-direct {v3, v1}, Ljava/lang/StringBuilder;-><init>(Ljava/lang/String;)V

    invoke-virtual {v3, v2}, Ljava/lang/StringBuilder;->append(C)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v1

    .line 381
    :goto_2
    add-int/lit8 v0, v0, 0x1

    goto :goto_1

    .line 384
    :pswitch_1
    new-instance v2, Ljava/lang/StringBuilder;

    invoke-static {v1}, Ljava/lang/String;->valueOf(Ljava/lang/Object;)Ljava/lang/String;

    move-result-object v1

    invoke-direct {v2, v1}, Ljava/lang/StringBuilder;-><init>(Ljava/lang/String;)V

    const-string v1, "\\r"

    invoke-virtual {v2, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v1

    goto :goto_2

    .line 385
    :pswitch_2
    new-instance v2, Ljava/lang/StringBuilder;

    invoke-static {v1}, Ljava/lang/String;->valueOf(Ljava/lang/Object;)Ljava/lang/String;

    move-result-object v1

    invoke-direct {v2, v1}, Ljava/lang/StringBuilder;-><init>(Ljava/lang/String;)V

    const-string v1, "\\n"

    invoke-virtual {v2, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v1

    goto :goto_2

    .line 386
    :pswitch_3
    new-instance v2, Ljava/lang/StringBuilder;

    invoke-static {v1}, Ljava/lang/String;->valueOf(Ljava/lang/Object;)Ljava/lang/String;

    move-result-object v1

    invoke-direct {v2, v1}, Ljava/lang/StringBuilder;-><init>(Ljava/lang/String;)V

    const-string v1, "\\t"

    invoke-virtual {v2, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v1

    goto :goto_2

    .line 391
    :cond_3
    new-instance v3, Ljava/lang/StringBuilder;

    invoke-static {v1}, Ljava/lang/String;->valueOf(Ljava/lang/Object;)Ljava/lang/String;

    move-result-object v1

    invoke-direct {v3, v1}, Ljava/lang/StringBuilder;-><init>(Ljava/lang/String;)V

    const-string v1, "\\"

    invoke-virtual {v3, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v1

    goto :goto_2

    .line 383
    nop

    :pswitch_data_0
    .packed-switch 0x9
        :pswitch_3
        :pswitch_2
        :pswitch_0
        :pswitch_0
        :pswitch_1
    .end packed-switch
.end method


# virtual methods
.method public available()I
    .locals 3
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljava/io/IOException;
        }
    .end annotation

    .prologue
    .line 191
    iget-object v0, p0, Lcom/sun/mail/util/BASE64DecoderStream;->in:Ljava/io/InputStream;

    invoke-virtual {v0}, Ljava/io/InputStream;->available()I

    move-result v0

    mul-int/lit8 v0, v0, 0x3

    div-int/lit8 v0, v0, 0x4

    iget v1, p0, Lcom/sun/mail/util/BASE64DecoderStream;->bufsize:I

    iget v2, p0, Lcom/sun/mail/util/BASE64DecoderStream;->index:I

    sub-int/2addr v1, v2

    add-int/2addr v0, v1

    return v0
.end method

.method public markSupported()Z
    .locals 1

    .prologue
    .line 179
    const/4 v0, 0x0

    return v0
.end method

.method public read()I
    .locals 3
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljava/io/IOException;
        }
    .end annotation

    .prologue
    const/4 v2, 0x0

    .line 113
    iget v0, p0, Lcom/sun/mail/util/BASE64DecoderStream;->index:I

    iget v1, p0, Lcom/sun/mail/util/BASE64DecoderStream;->bufsize:I

    if-lt v0, v1, :cond_1

    .line 114
    iget-object v0, p0, Lcom/sun/mail/util/BASE64DecoderStream;->buffer:[B

    iget-object v1, p0, Lcom/sun/mail/util/BASE64DecoderStream;->buffer:[B

    array-length v1, v1

    invoke-direct {p0, v0, v2, v1}, Lcom/sun/mail/util/BASE64DecoderStream;->decode([BII)I

    move-result v0

    iput v0, p0, Lcom/sun/mail/util/BASE64DecoderStream;->bufsize:I

    .line 115
    iget v0, p0, Lcom/sun/mail/util/BASE64DecoderStream;->bufsize:I

    if-gtz v0, :cond_0

    .line 116
    const/4 v0, -0x1

    .line 119
    :goto_0
    return v0

    .line 117
    :cond_0
    iput v2, p0, Lcom/sun/mail/util/BASE64DecoderStream;->index:I

    .line 119
    :cond_1
    iget-object v0, p0, Lcom/sun/mail/util/BASE64DecoderStream;->buffer:[B

    iget v1, p0, Lcom/sun/mail/util/BASE64DecoderStream;->index:I

    add-int/lit8 v2, v1, 0x1

    iput v2, p0, Lcom/sun/mail/util/BASE64DecoderStream;->index:I

    aget-byte v0, v0, v1

    and-int/lit16 v0, v0, 0xff

    goto :goto_0
.end method

.method public read([BII)I
    .locals 6
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljava/io/IOException;
        }
    .end annotation

    .prologue
    const/4 v2, -0x1

    .line 138
    move v0, p2

    .line 139
    :goto_0
    iget v1, p0, Lcom/sun/mail/util/BASE64DecoderStream;->index:I

    iget v3, p0, Lcom/sun/mail/util/BASE64DecoderStream;->bufsize:I

    if-ge v1, v3, :cond_0

    if-gtz p3, :cond_2

    .line 143
    :cond_0
    iget v1, p0, Lcom/sun/mail/util/BASE64DecoderStream;->index:I

    iget v3, p0, Lcom/sun/mail/util/BASE64DecoderStream;->bufsize:I

    if-lt v1, v3, :cond_1

    .line 144
    const/4 v1, 0x0

    iput v1, p0, Lcom/sun/mail/util/BASE64DecoderStream;->index:I

    iput v1, p0, Lcom/sun/mail/util/BASE64DecoderStream;->bufsize:I

    .line 146
    :cond_1
    div-int/lit8 v1, p3, 0x3

    mul-int/lit8 v1, v1, 0x3

    .line 147
    if-lez v1, :cond_6

    .line 148
    invoke-direct {p0, p1, v0, v1}, Lcom/sun/mail/util/BASE64DecoderStream;->decode([BII)I

    move-result v3

    .line 149
    add-int/2addr v0, v3

    .line 150
    sub-int/2addr p3, v3

    .line 152
    if-eq v3, v1, :cond_6

    .line 153
    if-ne v0, p2, :cond_3

    move v0, v2

    .line 171
    :goto_1
    return v0

    .line 140
    :cond_2
    add-int/lit8 v1, v0, 0x1

    iget-object v3, p0, Lcom/sun/mail/util/BASE64DecoderStream;->buffer:[B

    iget v4, p0, Lcom/sun/mail/util/BASE64DecoderStream;->index:I

    add-int/lit8 v5, v4, 0x1

    iput v5, p0, Lcom/sun/mail/util/BASE64DecoderStream;->index:I

    aget-byte v3, v3, v4

    aput-byte v3, p1, v0

    .line 141
    add-int/lit8 p3, p3, -0x1

    move v0, v1

    goto :goto_0

    .line 156
    :cond_3
    sub-int/2addr v0, p2

    goto :goto_1

    .line 162
    :cond_4
    invoke-virtual {p0}, Lcom/sun/mail/util/BASE64DecoderStream;->read()I

    move-result v3

    .line 163
    if-ne v3, v2, :cond_5

    .line 168
    :goto_2
    if-ne v0, p2, :cond_7

    move v0, v2

    .line 169
    goto :goto_1

    .line 165
    :cond_5
    add-int/lit8 v1, v0, 0x1

    int-to-byte v3, v3

    aput-byte v3, p1, v0

    .line 161
    add-int/lit8 p3, p3, -0x1

    move v0, v1

    :cond_6
    if-gtz p3, :cond_4

    goto :goto_2

    .line 171
    :cond_7
    sub-int/2addr v0, p2

    goto :goto_1
.end method
