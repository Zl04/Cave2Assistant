.class public Lorg/apache/commons/io/input/Tailer;
.super Ljava/lang/Object;
.source "SourceFile"

# interfaces
.implements Ljava/lang/Runnable;


# static fields
.field private static final DEFAULT_BUFSIZE:I = 0x1000

.field private static final DEFAULT_CHARSET:Ljava/nio/charset/Charset;

.field private static final DEFAULT_DELAY_MILLIS:I = 0x3e8

.field private static final RAF_MODE:Ljava/lang/String; = "r"


# instance fields
.field private final cset:Ljava/nio/charset/Charset;

.field private final delayMillis:J

.field private final end:Z

.field private final file:Ljava/io/File;

.field private final inbuf:[B

.field private final listener:Lorg/apache/commons/io/input/TailerListener;

.field private final reOpen:Z

.field private volatile run:Z


# direct methods
.method static constructor <clinit>()V
    .locals 1

    .prologue
    .line 130
    invoke-static {}, Ljava/nio/charset/Charset;->defaultCharset()Ljava/nio/charset/Charset;

    move-result-object v0

    sput-object v0, Lorg/apache/commons/io/input/Tailer;->DEFAULT_CHARSET:Ljava/nio/charset/Charset;

    return-void
.end method

.method public constructor <init>(Ljava/io/File;Ljava/nio/charset/Charset;Lorg/apache/commons/io/input/TailerListener;JZZI)V
    .locals 2

    .prologue
    .line 254
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    .line 170
    const/4 v0, 0x1

    iput-boolean v0, p0, Lorg/apache/commons/io/input/Tailer;->run:Z

    .line 255
    iput-object p1, p0, Lorg/apache/commons/io/input/Tailer;->file:Ljava/io/File;

    .line 256
    iput-wide p4, p0, Lorg/apache/commons/io/input/Tailer;->delayMillis:J

    .line 257
    iput-boolean p6, p0, Lorg/apache/commons/io/input/Tailer;->end:Z

    .line 259
    new-array v0, p8, [B

    iput-object v0, p0, Lorg/apache/commons/io/input/Tailer;->inbuf:[B

    .line 262
    iput-object p3, p0, Lorg/apache/commons/io/input/Tailer;->listener:Lorg/apache/commons/io/input/TailerListener;

    .line 263
    invoke-interface {p3, p0}, Lorg/apache/commons/io/input/TailerListener;->init(Lorg/apache/commons/io/input/Tailer;)V

    .line 264
    iput-boolean p7, p0, Lorg/apache/commons/io/input/Tailer;->reOpen:Z

    .line 265
    iput-object p2, p0, Lorg/apache/commons/io/input/Tailer;->cset:Ljava/nio/charset/Charset;

    .line 266
    return-void
.end method

.method public constructor <init>(Ljava/io/File;Lorg/apache/commons/io/input/TailerListener;)V
    .locals 2

    .prologue
    .line 178
    const-wide/16 v0, 0x3e8

    invoke-direct {p0, p1, p2, v0, v1}, Lorg/apache/commons/io/input/Tailer;-><init>(Ljava/io/File;Lorg/apache/commons/io/input/TailerListener;J)V

    .line 179
    return-void
.end method

.method public constructor <init>(Ljava/io/File;Lorg/apache/commons/io/input/TailerListener;J)V
    .locals 7

    .prologue
    .line 188
    const/4 v6, 0x0

    move-object v1, p0

    move-object v2, p1

    move-object v3, p2

    move-wide v4, p3

    invoke-direct/range {v1 .. v6}, Lorg/apache/commons/io/input/Tailer;-><init>(Ljava/io/File;Lorg/apache/commons/io/input/TailerListener;JZ)V

    .line 189
    return-void
.end method

.method public constructor <init>(Ljava/io/File;Lorg/apache/commons/io/input/TailerListener;JZ)V
    .locals 9

    .prologue
    .line 199
    const/16 v7, 0x1000

    move-object v1, p0

    move-object v2, p1

    move-object v3, p2

    move-wide v4, p3

    move v6, p5

    invoke-direct/range {v1 .. v7}, Lorg/apache/commons/io/input/Tailer;-><init>(Ljava/io/File;Lorg/apache/commons/io/input/TailerListener;JZI)V

    .line 200
    return-void
.end method

.method public constructor <init>(Ljava/io/File;Lorg/apache/commons/io/input/TailerListener;JZI)V
    .locals 9

    .prologue
    .line 225
    const/4 v7, 0x0

    move-object v1, p0

    move-object v2, p1

    move-object v3, p2

    move-wide v4, p3

    move v6, p5

    move v8, p6

    invoke-direct/range {v1 .. v8}, Lorg/apache/commons/io/input/Tailer;-><init>(Ljava/io/File;Lorg/apache/commons/io/input/TailerListener;JZZI)V

    .line 226
    return-void
.end method

.method public constructor <init>(Ljava/io/File;Lorg/apache/commons/io/input/TailerListener;JZZ)V
    .locals 9

    .prologue
    .line 212
    const/16 v8, 0x1000

    move-object v1, p0

    move-object v2, p1

    move-object v3, p2

    move-wide v4, p3

    move v6, p5

    move v7, p6

    invoke-direct/range {v1 .. v8}, Lorg/apache/commons/io/input/Tailer;-><init>(Ljava/io/File;Lorg/apache/commons/io/input/TailerListener;JZZI)V

    .line 213
    return-void
.end method

.method public constructor <init>(Ljava/io/File;Lorg/apache/commons/io/input/TailerListener;JZZI)V
    .locals 9

    .prologue
    .line 239
    sget-object v2, Lorg/apache/commons/io/input/Tailer;->DEFAULT_CHARSET:Ljava/nio/charset/Charset;

    move-object v0, p0

    move-object v1, p1

    move-object v3, p2

    move-wide v4, p3

    move v6, p5

    move v7, p6

    move/from16 v8, p7

    invoke-direct/range {v0 .. v8}, Lorg/apache/commons/io/input/Tailer;-><init>(Ljava/io/File;Ljava/nio/charset/Charset;Lorg/apache/commons/io/input/TailerListener;JZZI)V

    .line 240
    return-void
.end method

.method public static create(Ljava/io/File;Ljava/nio/charset/Charset;Lorg/apache/commons/io/input/TailerListener;JZZI)Lorg/apache/commons/io/input/Tailer;
    .locals 9

    .prologue
    .line 315
    new-instance v0, Lorg/apache/commons/io/input/Tailer;

    move-object v1, p0

    move-object v2, p1

    move-object v3, p2

    move-wide v4, p3

    move v6, p5

    move v7, p6

    move/from16 v8, p7

    invoke-direct/range {v0 .. v8}, Lorg/apache/commons/io/input/Tailer;-><init>(Ljava/io/File;Ljava/nio/charset/Charset;Lorg/apache/commons/io/input/TailerListener;JZZI)V

    .line 316
    new-instance v1, Ljava/lang/Thread;

    invoke-direct {v1, v0}, Ljava/lang/Thread;-><init>(Ljava/lang/Runnable;)V

    .line 317
    const/4 v2, 0x1

    invoke-virtual {v1, v2}, Ljava/lang/Thread;->setDaemon(Z)V

    .line 318
    invoke-virtual {v1}, Ljava/lang/Thread;->start()V

    .line 319
    return-object v0
.end method

.method public static create(Ljava/io/File;Lorg/apache/commons/io/input/TailerListener;)Lorg/apache/commons/io/input/Tailer;
    .locals 3

    .prologue
    .line 372
    const-wide/16 v0, 0x3e8

    const/4 v2, 0x0

    invoke-static {p0, p1, v0, v1, v2}, Lorg/apache/commons/io/input/Tailer;->create(Ljava/io/File;Lorg/apache/commons/io/input/TailerListener;JZ)Lorg/apache/commons/io/input/Tailer;

    move-result-object v0

    return-object v0
.end method

.method public static create(Ljava/io/File;Lorg/apache/commons/io/input/TailerListener;J)Lorg/apache/commons/io/input/Tailer;
    .locals 2

    .prologue
    .line 360
    const/4 v0, 0x0

    invoke-static {p0, p1, p2, p3, v0}, Lorg/apache/commons/io/input/Tailer;->create(Ljava/io/File;Lorg/apache/commons/io/input/TailerListener;JZ)Lorg/apache/commons/io/input/Tailer;

    move-result-object v0

    return-object v0
.end method

.method public static create(Ljava/io/File;Lorg/apache/commons/io/input/TailerListener;JZ)Lorg/apache/commons/io/input/Tailer;
    .locals 6

    .prologue
    .line 333
    const/16 v5, 0x1000

    move-object v0, p0

    move-object v1, p1

    move-wide v2, p2

    move v4, p4

    invoke-static/range {v0 .. v5}, Lorg/apache/commons/io/input/Tailer;->create(Ljava/io/File;Lorg/apache/commons/io/input/TailerListener;JZI)Lorg/apache/commons/io/input/Tailer;

    move-result-object v0

    return-object v0
.end method

.method public static create(Ljava/io/File;Lorg/apache/commons/io/input/TailerListener;JZI)Lorg/apache/commons/io/input/Tailer;
    .locals 8

    .prologue
    .line 280
    const/4 v5, 0x0

    move-object v0, p0

    move-object v1, p1

    move-wide v2, p2

    move v4, p4

    move v6, p5

    invoke-static/range {v0 .. v6}, Lorg/apache/commons/io/input/Tailer;->create(Ljava/io/File;Lorg/apache/commons/io/input/TailerListener;JZZI)Lorg/apache/commons/io/input/Tailer;

    move-result-object v0

    return-object v0
.end method

.method public static create(Ljava/io/File;Lorg/apache/commons/io/input/TailerListener;JZZ)Lorg/apache/commons/io/input/Tailer;
    .locals 8

    .prologue
    .line 348
    const/16 v6, 0x1000

    move-object v0, p0

    move-object v1, p1

    move-wide v2, p2

    move v4, p4

    move v5, p5

    invoke-static/range {v0 .. v6}, Lorg/apache/commons/io/input/Tailer;->create(Ljava/io/File;Lorg/apache/commons/io/input/TailerListener;JZZI)Lorg/apache/commons/io/input/Tailer;

    move-result-object v0

    return-object v0
.end method

.method public static create(Ljava/io/File;Lorg/apache/commons/io/input/TailerListener;JZZI)Lorg/apache/commons/io/input/Tailer;
    .locals 10

    .prologue
    .line 297
    sget-object v2, Lorg/apache/commons/io/input/Tailer;->DEFAULT_CHARSET:Ljava/nio/charset/Charset;

    move-object v1, p0

    move-object v3, p1

    move-wide v4, p2

    move v6, p4

    move v7, p5

    move/from16 v8, p6

    invoke-static/range {v1 .. v8}, Lorg/apache/commons/io/input/Tailer;->create(Ljava/io/File;Ljava/nio/charset/Charset;Lorg/apache/commons/io/input/TailerListener;JZZI)Lorg/apache/commons/io/input/Tailer;

    move-result-object v0

    return-object v0
.end method

.method private readLines(Ljava/io/RandomAccessFile;)J
    .locals 14
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljava/io/IOException;
        }
    .end annotation

    .prologue
    const-wide/16 v12, 0x1

    const/4 v1, 0x0

    .line 517
    new-instance v7, Ljava/io/ByteArrayOutputStream;

    const/16 v0, 0x40

    invoke-direct {v7, v0}, Ljava/io/ByteArrayOutputStream;-><init>(I)V

    .line 518
    invoke-virtual {p1}, Ljava/io/RandomAccessFile;->getFilePointer()J

    move-result-wide v2

    move v0, v1

    move-wide v4, v2

    .line 522
    :goto_0
    invoke-virtual {p0}, Lorg/apache/commons/io/input/Tailer;->getRun()Z

    move-result v6

    if-eqz v6, :cond_3

    iget-object v6, p0, Lorg/apache/commons/io/input/Tailer;->inbuf:[B

    invoke-virtual {p1, v6}, Ljava/io/RandomAccessFile;->read([B)I

    move-result v8

    const/4 v6, -0x1

    if-eq v8, v6, :cond_3

    move v6, v1

    .line 523
    :goto_1
    if-ge v6, v8, :cond_2

    .line 524
    iget-object v9, p0, Lorg/apache/commons/io/input/Tailer;->inbuf:[B

    aget-byte v9, v9, v6

    .line 525
    packed-switch v9, :pswitch_data_0

    .line 539
    :pswitch_0
    if-eqz v0, :cond_0

    .line 541
    iget-object v0, p0, Lorg/apache/commons/io/input/Tailer;->listener:Lorg/apache/commons/io/input/TailerListener;

    new-instance v2, Ljava/lang/String;

    invoke-virtual {v7}, Ljava/io/ByteArrayOutputStream;->toByteArray()[B

    move-result-object v3

    iget-object v10, p0, Lorg/apache/commons/io/input/Tailer;->cset:Ljava/nio/charset/Charset;

    invoke-direct {v2, v3, v10}, Ljava/lang/String;-><init>([BLjava/nio/charset/Charset;)V

    invoke-interface {v0, v2}, Lorg/apache/commons/io/input/TailerListener;->handle(Ljava/lang/String;)V

    .line 542
    invoke-virtual {v7}, Ljava/io/ByteArrayOutputStream;->reset()V

    .line 543
    int-to-long v2, v6

    add-long/2addr v2, v4

    add-long/2addr v2, v12

    move v0, v1

    .line 545
    :cond_0
    invoke-virtual {v7, v9}, Ljava/io/ByteArrayOutputStream;->write(I)V

    .line 523
    :goto_2
    add-int/lit8 v6, v6, 0x1

    goto :goto_1

    .line 528
    :pswitch_1
    iget-object v0, p0, Lorg/apache/commons/io/input/Tailer;->listener:Lorg/apache/commons/io/input/TailerListener;

    new-instance v2, Ljava/lang/String;

    invoke-virtual {v7}, Ljava/io/ByteArrayOutputStream;->toByteArray()[B

    move-result-object v3

    iget-object v9, p0, Lorg/apache/commons/io/input/Tailer;->cset:Ljava/nio/charset/Charset;

    invoke-direct {v2, v3, v9}, Ljava/lang/String;-><init>([BLjava/nio/charset/Charset;)V

    invoke-interface {v0, v2}, Lorg/apache/commons/io/input/TailerListener;->handle(Ljava/lang/String;)V

    .line 529
    invoke-virtual {v7}, Ljava/io/ByteArrayOutputStream;->reset()V

    .line 530
    int-to-long v2, v6

    add-long/2addr v2, v4

    add-long/2addr v2, v12

    move v0, v1

    .line 531
    goto :goto_2

    .line 533
    :pswitch_2
    if-eqz v0, :cond_1

    .line 534
    const/16 v0, 0xd

    invoke-virtual {v7, v0}, Ljava/io/ByteArrayOutputStream;->write(I)V

    .line 536
    :cond_1
    const/4 v0, 0x1

    .line 537
    goto :goto_2

    .line 548
    :cond_2
    invoke-virtual {p1}, Ljava/io/RandomAccessFile;->getFilePointer()J

    move-result-wide v4

    goto :goto_0

    .line 550
    :cond_3
    invoke-static {v7}, Lorg/apache/commons/io/IOUtils;->closeQuietly(Ljava/io/OutputStream;)V

    .line 551
    invoke-virtual {p1, v2, v3}, Ljava/io/RandomAccessFile;->seek(J)V

    .line 553
    iget-object v0, p0, Lorg/apache/commons/io/input/Tailer;->listener:Lorg/apache/commons/io/input/TailerListener;

    instance-of v0, v0, Lorg/apache/commons/io/input/TailerListenerAdapter;

    if-eqz v0, :cond_4

    .line 554
    iget-object v0, p0, Lorg/apache/commons/io/input/Tailer;->listener:Lorg/apache/commons/io/input/TailerListener;

    check-cast v0, Lorg/apache/commons/io/input/TailerListenerAdapter;

    invoke-virtual {v0}, Lorg/apache/commons/io/input/TailerListenerAdapter;->endOfFileReached()V

    .line 557
    :cond_4
    return-wide v2

    .line 525
    :pswitch_data_0
    .packed-switch 0xa
        :pswitch_1
        :pswitch_0
        :pswitch_0
        :pswitch_2
    .end packed-switch
.end method

.method private stop(Ljava/lang/Exception;)V
    .locals 1

    .prologue
    .line 498
    iget-object v0, p0, Lorg/apache/commons/io/input/Tailer;->listener:Lorg/apache/commons/io/input/TailerListener;

    invoke-interface {v0, p1}, Lorg/apache/commons/io/input/TailerListener;->handle(Ljava/lang/Exception;)V

    .line 499
    invoke-virtual {p0}, Lorg/apache/commons/io/input/Tailer;->stop()V

    .line 500
    return-void
.end method


# virtual methods
.method public getDelay()J
    .locals 2

    .prologue
    .line 400
    iget-wide v0, p0, Lorg/apache/commons/io/input/Tailer;->delayMillis:J

    return-wide v0
.end method

.method public getFile()Ljava/io/File;
    .locals 1

    .prologue
    .line 381
    iget-object v0, p0, Lorg/apache/commons/io/input/Tailer;->file:Ljava/io/File;

    return-object v0
.end method

.method protected getRun()Z
    .locals 1

    .prologue
    .line 391
    iget-boolean v0, p0, Lorg/apache/commons/io/input/Tailer;->run:Z

    return v0
.end method

.method public run()V
    .locals 13

    .prologue
    const-wide/16 v4, 0x0

    .line 407
    const/4 v1, 0x0

    move-wide v2, v4

    move-wide v6, v4

    .line 412
    :goto_0
    :try_start_0
    invoke-virtual {p0}, Lorg/apache/commons/io/input/Tailer;->getRun()Z
    :try_end_0
    .catch Ljava/lang/InterruptedException; {:try_start_0 .. :try_end_0} :catch_0
    .catch Ljava/lang/Exception; {:try_start_0 .. :try_end_0} :catch_2
    .catchall {:try_start_0 .. :try_end_0} :catchall_0

    move-result v0

    if-eqz v0, :cond_2

    if-nez v1, :cond_2

    .line 414
    :try_start_1
    new-instance v0, Ljava/io/RandomAccessFile;

    iget-object v8, p0, Lorg/apache/commons/io/input/Tailer;->file:Ljava/io/File;

    const-string v9, "r"

    invoke-direct {v0, v8, v9}, Ljava/io/RandomAccessFile;-><init>(Ljava/io/File;Ljava/lang/String;)V
    :try_end_1
    .catch Ljava/io/FileNotFoundException; {:try_start_1 .. :try_end_1} :catch_1
    .catch Ljava/lang/InterruptedException; {:try_start_1 .. :try_end_1} :catch_0
    .catch Ljava/lang/Exception; {:try_start_1 .. :try_end_1} :catch_2
    .catchall {:try_start_1 .. :try_end_1} :catchall_0

    move-object v1, v0

    .line 418
    :goto_1
    if-nez v1, :cond_0

    .line 419
    :try_start_2
    iget-wide v8, p0, Lorg/apache/commons/io/input/Tailer;->delayMillis:J

    invoke-static {v8, v9}, Ljava/lang/Thread;->sleep(J)V
    :try_end_2
    .catch Ljava/lang/InterruptedException; {:try_start_2 .. :try_end_2} :catch_0
    .catch Ljava/lang/Exception; {:try_start_2 .. :try_end_2} :catch_2
    .catchall {:try_start_2 .. :try_end_2} :catchall_0

    goto :goto_0

    .line 483
    :catch_0
    move-exception v0

    .line 484
    :goto_2
    :try_start_3
    invoke-static {}, Ljava/lang/Thread;->currentThread()Ljava/lang/Thread;

    move-result-object v2

    invoke-virtual {v2}, Ljava/lang/Thread;->interrupt()V

    .line 485
    invoke-direct {p0, v0}, Lorg/apache/commons/io/input/Tailer;->stop(Ljava/lang/Exception;)V
    :try_end_3
    .catchall {:try_start_3 .. :try_end_3} :catchall_0

    .line 489
    invoke-static {v1}, Lorg/apache/commons/io/IOUtils;->closeQuietly(Ljava/io/Closeable;)V

    .line 491
    :goto_3
    return-void

    .line 415
    :catch_1
    move-exception v0

    .line 416
    :try_start_4
    iget-object v0, p0, Lorg/apache/commons/io/input/Tailer;->listener:Lorg/apache/commons/io/input/TailerListener;

    invoke-interface {v0}, Lorg/apache/commons/io/input/TailerListener;->fileNotFound()V
    :try_end_4
    .catch Ljava/lang/InterruptedException; {:try_start_4 .. :try_end_4} :catch_0
    .catch Ljava/lang/Exception; {:try_start_4 .. :try_end_4} :catch_2
    .catchall {:try_start_4 .. :try_end_4} :catchall_0

    goto :goto_1

    .line 486
    :catch_2
    move-exception v0

    .line 487
    :goto_4
    :try_start_5
    invoke-direct {p0, v0}, Lorg/apache/commons/io/input/Tailer;->stop(Ljava/lang/Exception;)V
    :try_end_5
    .catchall {:try_start_5 .. :try_end_5} :catchall_0

    .line 489
    invoke-static {v1}, Lorg/apache/commons/io/IOUtils;->closeQuietly(Ljava/io/Closeable;)V

    goto :goto_3

    .line 422
    :cond_0
    :try_start_6
    iget-boolean v0, p0, Lorg/apache/commons/io/input/Tailer;->end:Z

    if-eqz v0, :cond_1

    iget-object v0, p0, Lorg/apache/commons/io/input/Tailer;->file:Ljava/io/File;

    invoke-virtual {v0}, Ljava/io/File;->length()J

    move-result-wide v2

    .line 423
    :goto_5
    iget-object v0, p0, Lorg/apache/commons/io/input/Tailer;->file:Ljava/io/File;

    invoke-virtual {v0}, Ljava/io/File;->lastModified()J

    move-result-wide v6

    .line 424
    invoke-virtual {v1, v2, v3}, Ljava/io/RandomAccessFile;->seek(J)V
    :try_end_6
    .catch Ljava/lang/InterruptedException; {:try_start_6 .. :try_end_6} :catch_0
    .catch Ljava/lang/Exception; {:try_start_6 .. :try_end_6} :catch_2
    .catchall {:try_start_6 .. :try_end_6} :catchall_0

    goto :goto_0

    .line 489
    :catchall_0
    move-exception v0

    :goto_6
    invoke-static {v1}, Lorg/apache/commons/io/IOUtils;->closeQuietly(Ljava/io/Closeable;)V

    throw v0

    :cond_1
    move-wide v2, v4

    .line 422
    goto :goto_5

    .line 427
    :cond_2
    :goto_7
    :try_start_7
    invoke-virtual {p0}, Lorg/apache/commons/io/input/Tailer;->getRun()Z

    move-result v0

    if-eqz v0, :cond_7

    .line 428
    iget-object v0, p0, Lorg/apache/commons/io/input/Tailer;->file:Ljava/io/File;

    invoke-static {v0, v6, v7}, Lorg/apache/commons/io/FileUtils;->isFileNewer(Ljava/io/File;J)Z

    move-result v0

    .line 430
    iget-object v8, p0, Lorg/apache/commons/io/input/Tailer;->file:Ljava/io/File;

    invoke-virtual {v8}, Ljava/io/File;->length()J

    move-result-wide v8

    .line 431
    cmp-long v10, v8, v2

    if-gez v10, :cond_3

    .line 433
    iget-object v0, p0, Lorg/apache/commons/io/input/Tailer;->listener:Lorg/apache/commons/io/input/TailerListener;

    invoke-interface {v0}, Lorg/apache/commons/io/input/TailerListener;->fileRotated()V
    :try_end_7
    .catch Ljava/lang/InterruptedException; {:try_start_7 .. :try_end_7} :catch_0
    .catch Ljava/lang/Exception; {:try_start_7 .. :try_end_7} :catch_2
    .catchall {:try_start_7 .. :try_end_7} :catchall_0

    .line 438
    :try_start_8
    new-instance v0, Ljava/io/RandomAccessFile;

    iget-object v8, p0, Lorg/apache/commons/io/input/Tailer;->file:Ljava/io/File;

    const-string v9, "r"

    invoke-direct {v0, v8, v9}, Ljava/io/RandomAccessFile;-><init>(Ljava/io/File;Ljava/lang/String;)V
    :try_end_8
    .catch Ljava/io/FileNotFoundException; {:try_start_8 .. :try_end_8} :catch_b
    .catch Ljava/lang/InterruptedException; {:try_start_8 .. :try_end_8} :catch_0
    .catch Ljava/lang/Exception; {:try_start_8 .. :try_end_8} :catch_2
    .catchall {:try_start_8 .. :try_end_8} :catchall_0

    .line 442
    :try_start_9
    invoke-direct {p0, v1}, Lorg/apache/commons/io/input/Tailer;->readLines(Ljava/io/RandomAccessFile;)J
    :try_end_9
    .catch Ljava/io/IOException; {:try_start_9 .. :try_end_9} :catch_3
    .catch Ljava/io/FileNotFoundException; {:try_start_9 .. :try_end_9} :catch_4
    .catch Ljava/lang/InterruptedException; {:try_start_9 .. :try_end_9} :catch_8
    .catch Ljava/lang/Exception; {:try_start_9 .. :try_end_9} :catch_5
    .catchall {:try_start_9 .. :try_end_9} :catchall_1

    .line 448
    :goto_8
    :try_start_a
    invoke-static {v1}, Lorg/apache/commons/io/IOUtils;->closeQuietly(Ljava/io/Closeable;)V
    :try_end_a
    .catch Ljava/io/FileNotFoundException; {:try_start_a .. :try_end_a} :catch_c
    .catch Ljava/lang/InterruptedException; {:try_start_a .. :try_end_a} :catch_8
    .catch Ljava/lang/Exception; {:try_start_a .. :try_end_a} :catch_5
    .catchall {:try_start_a .. :try_end_a} :catchall_1

    move-wide v2, v4

    move-object v1, v0

    .line 452
    goto :goto_7

    .line 443
    :catch_3
    move-exception v8

    .line 444
    :try_start_b
    iget-object v9, p0, Lorg/apache/commons/io/input/Tailer;->listener:Lorg/apache/commons/io/input/TailerListener;

    invoke-interface {v9, v8}, Lorg/apache/commons/io/input/TailerListener;->handle(Ljava/lang/Exception;)V
    :try_end_b
    .catch Ljava/io/FileNotFoundException; {:try_start_b .. :try_end_b} :catch_4
    .catch Ljava/lang/InterruptedException; {:try_start_b .. :try_end_b} :catch_8
    .catch Ljava/lang/Exception; {:try_start_b .. :try_end_b} :catch_5
    .catchall {:try_start_b .. :try_end_b} :catchall_1

    goto :goto_8

    .line 449
    :catch_4
    move-exception v1

    move-wide v11, v2

    move-object v2, v0

    move-wide v0, v11

    .line 451
    :goto_9
    :try_start_c
    iget-object v3, p0, Lorg/apache/commons/io/input/Tailer;->listener:Lorg/apache/commons/io/input/TailerListener;

    invoke-interface {v3}, Lorg/apache/commons/io/input/TailerListener;->fileNotFound()V
    :try_end_c
    .catch Ljava/lang/InterruptedException; {:try_start_c .. :try_end_c} :catch_9
    .catch Ljava/lang/Exception; {:try_start_c .. :try_end_c} :catch_6
    .catchall {:try_start_c .. :try_end_c} :catchall_2

    move-wide v11, v0

    move-object v1, v2

    move-wide v2, v11

    .line 453
    goto :goto_7

    .line 457
    :cond_3
    cmp-long v8, v8, v2

    if-lez v8, :cond_6

    .line 459
    :try_start_d
    invoke-direct {p0, v1}, Lorg/apache/commons/io/input/Tailer;->readLines(Ljava/io/RandomAccessFile;)J

    move-result-wide v2

    .line 460
    iget-object v0, p0, Lorg/apache/commons/io/input/Tailer;->file:Ljava/io/File;

    invoke-virtual {v0}, Ljava/io/File;->lastModified()J

    move-result-wide v6

    .line 474
    :cond_4
    :goto_a
    iget-boolean v0, p0, Lorg/apache/commons/io/input/Tailer;->reOpen:Z

    if-eqz v0, :cond_5

    .line 475
    invoke-static {v1}, Lorg/apache/commons/io/IOUtils;->closeQuietly(Ljava/io/Closeable;)V

    .line 477
    :cond_5
    iget-wide v8, p0, Lorg/apache/commons/io/input/Tailer;->delayMillis:J

    invoke-static {v8, v9}, Ljava/lang/Thread;->sleep(J)V

    .line 478
    invoke-virtual {p0}, Lorg/apache/commons/io/input/Tailer;->getRun()Z

    move-result v0

    if-eqz v0, :cond_8

    iget-boolean v0, p0, Lorg/apache/commons/io/input/Tailer;->reOpen:Z

    if-eqz v0, :cond_8

    .line 479
    new-instance v0, Ljava/io/RandomAccessFile;

    iget-object v8, p0, Lorg/apache/commons/io/input/Tailer;->file:Ljava/io/File;

    const-string v9, "r"

    invoke-direct {v0, v8, v9}, Ljava/io/RandomAccessFile;-><init>(Ljava/io/File;Ljava/lang/String;)V
    :try_end_d
    .catch Ljava/lang/InterruptedException; {:try_start_d .. :try_end_d} :catch_0
    .catch Ljava/lang/Exception; {:try_start_d .. :try_end_d} :catch_2
    .catchall {:try_start_d .. :try_end_d} :catchall_0

    .line 480
    :try_start_e
    invoke-virtual {v0, v2, v3}, Ljava/io/RandomAccessFile;->seek(J)V
    :try_end_e
    .catch Ljava/lang/InterruptedException; {:try_start_e .. :try_end_e} :catch_a
    .catch Ljava/lang/Exception; {:try_start_e .. :try_end_e} :catch_7
    .catchall {:try_start_e .. :try_end_e} :catchall_3

    :goto_b
    move-object v1, v0

    .line 482
    goto :goto_7

    .line 461
    :cond_6
    if-eqz v0, :cond_4

    .line 466
    const-wide/16 v2, 0x0

    .line 467
    :try_start_f
    invoke-virtual {v1, v2, v3}, Ljava/io/RandomAccessFile;->seek(J)V

    .line 470
    invoke-direct {p0, v1}, Lorg/apache/commons/io/input/Tailer;->readLines(Ljava/io/RandomAccessFile;)J

    move-result-wide v2

    .line 471
    iget-object v0, p0, Lorg/apache/commons/io/input/Tailer;->file:Ljava/io/File;

    invoke-virtual {v0}, Ljava/io/File;->lastModified()J
    :try_end_f
    .catch Ljava/lang/InterruptedException; {:try_start_f .. :try_end_f} :catch_0
    .catch Ljava/lang/Exception; {:try_start_f .. :try_end_f} :catch_2
    .catchall {:try_start_f .. :try_end_f} :catchall_0

    move-result-wide v6

    goto :goto_a

    .line 489
    :cond_7
    invoke-static {v1}, Lorg/apache/commons/io/IOUtils;->closeQuietly(Ljava/io/Closeable;)V

    goto/16 :goto_3

    :catchall_1
    move-exception v1

    move-object v11, v1

    move-object v1, v0

    move-object v0, v11

    goto/16 :goto_6

    :catchall_2
    move-exception v0

    move-object v1, v2

    goto/16 :goto_6

    :catchall_3
    move-exception v1

    move-object v11, v1

    move-object v1, v0

    move-object v0, v11

    goto/16 :goto_6

    .line 486
    :catch_5
    move-exception v1

    move-object v11, v1

    move-object v1, v0

    move-object v0, v11

    goto/16 :goto_4

    :catch_6
    move-exception v0

    move-object v1, v2

    goto/16 :goto_4

    :catch_7
    move-exception v1

    move-object v11, v1

    move-object v1, v0

    move-object v0, v11

    goto/16 :goto_4

    .line 483
    :catch_8
    move-exception v1

    move-object v11, v1

    move-object v1, v0

    move-object v0, v11

    goto/16 :goto_2

    :catch_9
    move-exception v0

    move-object v1, v2

    goto/16 :goto_2

    :catch_a
    move-exception v1

    move-object v11, v1

    move-object v1, v0

    move-object v0, v11

    goto/16 :goto_2

    .line 449
    :catch_b
    move-exception v0

    move-wide v11, v2

    move-object v2, v1

    move-wide v0, v11

    goto/16 :goto_9

    :catch_c
    move-exception v1

    move-object v2, v0

    move-wide v0, v4

    goto/16 :goto_9

    :cond_8
    move-object v0, v1

    goto :goto_b
.end method

.method public stop()V
    .locals 1

    .prologue
    .line 506
    const/4 v0, 0x0

    iput-boolean v0, p0, Lorg/apache/commons/io/input/Tailer;->run:Z

    .line 507
    return-void
.end method
