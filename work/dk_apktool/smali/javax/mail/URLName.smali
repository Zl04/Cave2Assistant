.class public Ljavax/mail/URLName;
.super Ljava/lang/Object;
.source "SourceFile"


# static fields
.field static final caseDiff:I = 0x20

.field private static doEncode:Z

.field static dontNeedEncoding:Ljava/util/BitSet;


# instance fields
.field private file:Ljava/lang/String;

.field protected fullURL:Ljava/lang/String;

.field private hashCode:I

.field private host:Ljava/lang/String;

.field private hostAddress:Ljava/net/InetAddress;

.field private hostAddressKnown:Z

.field private password:Ljava/lang/String;

.field private port:I

.field private protocol:Ljava/lang/String;

.field private ref:Ljava/lang/String;

.field private username:Ljava/lang/String;


# direct methods
.method static constructor <clinit>()V
    .locals 2

    .prologue
    const/4 v0, 0x1

    .line 124
    sput-boolean v0, Ljavax/mail/URLName;->doEncode:Z

    .line 128
    :try_start_0
    const-string v1, "mail.URLName.dontencode"

    invoke-static {v1}, Ljava/lang/Boolean;->getBoolean(Ljava/lang/String;)Z

    move-result v1

    if-eqz v1, :cond_0

    const/4 v0, 0x0

    :cond_0
    sput-boolean v0, Ljavax/mail/URLName;->doEncode:Z
    :try_end_0
    .catch Ljava/lang/Exception; {:try_start_0 .. :try_end_0} :catch_0

    .line 524
    :goto_0
    new-instance v0, Ljava/util/BitSet;

    const/16 v1, 0x100

    invoke-direct {v0, v1}, Ljava/util/BitSet;-><init>(I)V

    sput-object v0, Ljavax/mail/URLName;->dontNeedEncoding:Ljava/util/BitSet;

    .line 526
    const/16 v0, 0x61

    :goto_1
    const/16 v1, 0x7a

    if-le v0, v1, :cond_1

    .line 529
    const/16 v0, 0x41

    :goto_2
    const/16 v1, 0x5a

    if-le v0, v1, :cond_2

    .line 532
    const/16 v0, 0x30

    :goto_3
    const/16 v1, 0x39

    if-le v0, v1, :cond_3

    .line 536
    sget-object v0, Ljavax/mail/URLName;->dontNeedEncoding:Ljava/util/BitSet;

    const/16 v1, 0x20

    invoke-virtual {v0, v1}, Ljava/util/BitSet;->set(I)V

    .line 537
    sget-object v0, Ljavax/mail/URLName;->dontNeedEncoding:Ljava/util/BitSet;

    const/16 v1, 0x2d

    invoke-virtual {v0, v1}, Ljava/util/BitSet;->set(I)V

    .line 538
    sget-object v0, Ljavax/mail/URLName;->dontNeedEncoding:Ljava/util/BitSet;

    const/16 v1, 0x5f

    invoke-virtual {v0, v1}, Ljava/util/BitSet;->set(I)V

    .line 539
    sget-object v0, Ljavax/mail/URLName;->dontNeedEncoding:Ljava/util/BitSet;

    const/16 v1, 0x2e

    invoke-virtual {v0, v1}, Ljava/util/BitSet;->set(I)V

    .line 540
    sget-object v0, Ljavax/mail/URLName;->dontNeedEncoding:Ljava/util/BitSet;

    const/16 v1, 0x2a

    invoke-virtual {v0, v1}, Ljava/util/BitSet;->set(I)V

    .line 67
    return-void

    .line 527
    :cond_1
    sget-object v1, Ljavax/mail/URLName;->dontNeedEncoding:Ljava/util/BitSet;

    invoke-virtual {v1, v0}, Ljava/util/BitSet;->set(I)V

    .line 526
    add-int/lit8 v0, v0, 0x1

    goto :goto_1

    .line 530
    :cond_2
    sget-object v1, Ljavax/mail/URLName;->dontNeedEncoding:Ljava/util/BitSet;

    invoke-virtual {v1, v0}, Ljava/util/BitSet;->set(I)V

    .line 529
    add-int/lit8 v0, v0, 0x1

    goto :goto_2

    .line 533
    :cond_3
    sget-object v1, Ljavax/mail/URLName;->dontNeedEncoding:Ljava/util/BitSet;

    invoke-virtual {v1, v0}, Ljava/util/BitSet;->set(I)V

    .line 532
    add-int/lit8 v0, v0, 0x1

    goto :goto_3

    .line 129
    :catch_0
    move-exception v0

    goto :goto_0
.end method

.method public constructor <init>(Ljava/lang/String;)V
    .locals 2

    .prologue
    const/4 v1, 0x0

    .line 175
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    .line 99
    iput-boolean v1, p0, Ljavax/mail/URLName;->hostAddressKnown:Z

    .line 104
    const/4 v0, -0x1

    iput v0, p0, Ljavax/mail/URLName;->port:I

    .line 119
    iput v1, p0, Ljavax/mail/URLName;->hashCode:I

    .line 176
    invoke-virtual {p0, p1}, Ljavax/mail/URLName;->parseString(Ljava/lang/String;)V

    .line 177
    return-void
.end method

.method public constructor <init>(Ljava/lang/String;Ljava/lang/String;ILjava/lang/String;Ljava/lang/String;Ljava/lang/String;)V
    .locals 3

    .prologue
    const/4 v2, -0x1

    const/4 v1, 0x0

    .line 140
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    .line 99
    iput-boolean v1, p0, Ljavax/mail/URLName;->hostAddressKnown:Z

    .line 104
    iput v2, p0, Ljavax/mail/URLName;->port:I

    .line 119
    iput v1, p0, Ljavax/mail/URLName;->hashCode:I

    .line 149
    iput-object p1, p0, Ljavax/mail/URLName;->protocol:Ljava/lang/String;

    .line 150
    iput-object p2, p0, Ljavax/mail/URLName;->host:Ljava/lang/String;

    .line 151
    iput p3, p0, Ljavax/mail/URLName;->port:I

    .line 153
    if-eqz p4, :cond_2

    const/16 v0, 0x23

    invoke-virtual {p4, v0}, Ljava/lang/String;->indexOf(I)I

    move-result v0

    if-eq v0, v2, :cond_2

    .line 154
    invoke-virtual {p4, v1, v0}, Ljava/lang/String;->substring(II)Ljava/lang/String;

    move-result-object v1

    iput-object v1, p0, Ljavax/mail/URLName;->file:Ljava/lang/String;

    .line 155
    add-int/lit8 v0, v0, 0x1

    invoke-virtual {p4, v0}, Ljava/lang/String;->substring(I)Ljava/lang/String;

    move-result-object v0

    iput-object v0, p0, Ljavax/mail/URLName;->ref:Ljava/lang/String;

    .line 160
    :goto_0
    sget-boolean v0, Ljavax/mail/URLName;->doEncode:Z

    if-eqz v0, :cond_0

    invoke-static {p5}, Ljavax/mail/URLName;->encode(Ljava/lang/String;)Ljava/lang/String;

    move-result-object p5

    :cond_0
    iput-object p5, p0, Ljavax/mail/URLName;->username:Ljava/lang/String;

    .line 161
    sget-boolean v0, Ljavax/mail/URLName;->doEncode:Z

    if-eqz v0, :cond_1

    invoke-static {p6}, Ljavax/mail/URLName;->encode(Ljava/lang/String;)Ljava/lang/String;

    move-result-object p6

    :cond_1
    iput-object p6, p0, Ljavax/mail/URLName;->password:Ljava/lang/String;

    .line 162
    return-void

    .line 157
    :cond_2
    iput-object p4, p0, Ljavax/mail/URLName;->file:Ljava/lang/String;

    .line 158
    const/4 v0, 0x0

    iput-object v0, p0, Ljavax/mail/URLName;->ref:Ljava/lang/String;

    goto :goto_0
.end method

.method public constructor <init>(Ljava/net/URL;)V
    .locals 1

    .prologue
    .line 168
    invoke-virtual {p1}, Ljava/net/URL;->toString()Ljava/lang/String;

    move-result-object v0

    invoke-direct {p0, v0}, Ljavax/mail/URLName;-><init>(Ljava/lang/String;)V

    .line 169
    return-void
.end method

.method private static _encode(Ljava/lang/String;)Ljava/lang/String;
    .locals 10

    .prologue
    const/16 v9, 0x10

    const/4 v1, 0x0

    .line 562
    const/16 v0, 0xa

    .line 563
    new-instance v4, Ljava/lang/StringBuffer;

    invoke-virtual {p0}, Ljava/lang/String;->length()I

    move-result v2

    invoke-direct {v4, v2}, Ljava/lang/StringBuffer;-><init>(I)V

    .line 564
    new-instance v5, Ljava/io/ByteArrayOutputStream;

    invoke-direct {v5, v0}, Ljava/io/ByteArrayOutputStream;-><init>(I)V

    .line 565
    new-instance v6, Ljava/io/OutputStreamWriter;

    invoke-direct {v6, v5}, Ljava/io/OutputStreamWriter;-><init>(Ljava/io/OutputStream;)V

    move v0, v1

    .line 567
    :goto_0
    invoke-virtual {p0}, Ljava/lang/String;->length()I

    move-result v2

    if-lt v0, v2, :cond_0

    .line 603
    invoke-virtual {v4}, Ljava/lang/StringBuffer;->toString()Ljava/lang/String;

    move-result-object v0

    return-object v0

    .line 568
    :cond_0
    invoke-virtual {p0, v0}, Ljava/lang/String;->charAt(I)C

    move-result v2

    .line 569
    sget-object v3, Ljavax/mail/URLName;->dontNeedEncoding:Ljava/util/BitSet;

    invoke-virtual {v3, v2}, Ljava/util/BitSet;->get(I)Z

    move-result v3

    if-eqz v3, :cond_2

    .line 570
    const/16 v3, 0x20

    if-ne v2, v3, :cond_1

    .line 571
    const/16 v2, 0x2b

    .line 573
    :cond_1
    int-to-char v2, v2

    invoke-virtual {v4, v2}, Ljava/lang/StringBuffer;->append(C)Ljava/lang/StringBuffer;

    .line 567
    :goto_1
    add-int/lit8 v0, v0, 0x1

    goto :goto_0

    .line 577
    :cond_2
    :try_start_0
    invoke-virtual {v6, v2}, Ljava/io/OutputStreamWriter;->write(I)V

    .line 578
    invoke-virtual {v6}, Ljava/io/OutputStreamWriter;->flush()V
    :try_end_0
    .catch Ljava/io/IOException; {:try_start_0 .. :try_end_0} :catch_0

    .line 583
    invoke-virtual {v5}, Ljava/io/ByteArrayOutputStream;->toByteArray()[B

    move-result-object v7

    move v2, v1

    .line 584
    :goto_2
    array-length v3, v7

    if-lt v2, v3, :cond_3

    .line 599
    invoke-virtual {v5}, Ljava/io/ByteArrayOutputStream;->reset()V

    goto :goto_1

    .line 579
    :catch_0
    move-exception v2

    .line 580
    invoke-virtual {v5}, Ljava/io/ByteArrayOutputStream;->reset()V

    goto :goto_1

    .line 585
    :cond_3
    const/16 v3, 0x25

    invoke-virtual {v4, v3}, Ljava/lang/StringBuffer;->append(C)Ljava/lang/StringBuffer;

    .line 586
    aget-byte v3, v7, v2

    shr-int/lit8 v3, v3, 0x4

    and-int/lit8 v3, v3, 0xf

    invoke-static {v3, v9}, Ljava/lang/Character;->forDigit(II)C

    move-result v3

    .line 589
    invoke-static {v3}, Ljava/lang/Character;->isLetter(C)Z

    move-result v8

    if-eqz v8, :cond_4

    .line 590
    add-int/lit8 v3, v3, -0x20

    int-to-char v3, v3

    .line 592
    :cond_4
    invoke-virtual {v4, v3}, Ljava/lang/StringBuffer;->append(C)Ljava/lang/StringBuffer;

    .line 593
    aget-byte v3, v7, v2

    and-int/lit8 v3, v3, 0xf

    invoke-static {v3, v9}, Ljava/lang/Character;->forDigit(II)C

    move-result v3

    .line 594
    invoke-static {v3}, Ljava/lang/Character;->isLetter(C)Z

    move-result v8

    if-eqz v8, :cond_5

    .line 595
    add-int/lit8 v3, v3, -0x20

    int-to-char v3, v3

    .line 597
    :cond_5
    invoke-virtual {v4, v3}, Ljava/lang/StringBuffer;->append(C)Ljava/lang/StringBuffer;

    .line 584
    add-int/lit8 v2, v2, 0x1

    goto :goto_2
.end method

.method static decode(Ljava/lang/String;)Ljava/lang/String;
    .locals 4

    .prologue
    .line 638
    if-nez p0, :cond_1

    .line 639
    const/4 p0, 0x0

    .line 672
    :cond_0
    :goto_0
    return-object p0

    .line 640
    :cond_1
    const-string v0, "+%"

    invoke-static {p0, v0}, Ljavax/mail/URLName;->indexOfAny(Ljava/lang/String;Ljava/lang/String;)I

    move-result v0

    const/4 v1, -0x1

    if-eq v0, v1, :cond_0

    .line 643
    new-instance v1, Ljava/lang/StringBuffer;

    invoke-direct {v1}, Ljava/lang/StringBuffer;-><init>()V

    .line 644
    const/4 v0, 0x0

    :goto_1
    invoke-virtual {p0}, Ljava/lang/String;->length()I

    move-result v2

    if-lt v0, v2, :cond_2

    .line 665
    invoke-virtual {v1}, Ljava/lang/StringBuffer;->toString()Ljava/lang/String;

    move-result-object v1

    .line 667
    :try_start_0
    const-string v0, "8859_1"

    invoke-virtual {v1, v0}, Ljava/lang/String;->getBytes(Ljava/lang/String;)[B

    move-result-object v2

    .line 668
    new-instance v0, Ljava/lang/String;

    invoke-direct {v0, v2}, Ljava/lang/String;-><init>([B)V
    :try_end_0
    .catch Ljava/io/UnsupportedEncodingException; {:try_start_0 .. :try_end_0} :catch_1

    :goto_2
    move-object p0, v0

    .line 672
    goto :goto_0

    .line 645
    :cond_2
    invoke-virtual {p0, v0}, Ljava/lang/String;->charAt(I)C

    move-result v2

    .line 646
    sparse-switch v2, :sswitch_data_0

    .line 660
    invoke-virtual {v1, v2}, Ljava/lang/StringBuffer;->append(C)Ljava/lang/StringBuffer;

    .line 644
    :goto_3
    add-int/lit8 v0, v0, 0x1

    goto :goto_1

    .line 648
    :sswitch_0
    const/16 v2, 0x20

    invoke-virtual {v1, v2}, Ljava/lang/StringBuffer;->append(C)Ljava/lang/StringBuffer;

    goto :goto_3

    .line 653
    :sswitch_1
    add-int/lit8 v2, v0, 0x1

    add-int/lit8 v3, v0, 0x3

    :try_start_1
    invoke-virtual {p0, v2, v3}, Ljava/lang/String;->substring(II)Ljava/lang/String;

    move-result-object v2

    const/16 v3, 0x10

    .line 652
    invoke-static {v2, v3}, Ljava/lang/Integer;->parseInt(Ljava/lang/String;I)I

    move-result v2

    int-to-char v2, v2

    invoke-virtual {v1, v2}, Ljava/lang/StringBuffer;->append(C)Ljava/lang/StringBuffer;
    :try_end_1
    .catch Ljava/lang/NumberFormatException; {:try_start_1 .. :try_end_1} :catch_0

    .line 657
    add-int/lit8 v0, v0, 0x2

    .line 658
    goto :goto_3

    .line 654
    :catch_0
    move-exception v0

    .line 655
    new-instance v0, Ljava/lang/IllegalArgumentException;

    invoke-direct {v0}, Ljava/lang/IllegalArgumentException;-><init>()V

    throw v0

    .line 669
    :catch_1
    move-exception v0

    move-object v0, v1

    goto :goto_2

    .line 646
    :sswitch_data_0
    .sparse-switch
        0x25 -> :sswitch_1
        0x2b -> :sswitch_0
    .end sparse-switch
.end method

.method static encode(Ljava/lang/String;)Ljava/lang/String;
    .locals 3

    .prologue
    .line 550
    if-nez p0, :cond_1

    .line 551
    const/4 p0, 0x0

    .line 558
    :cond_0
    :goto_0
    return-object p0

    .line 553
    :cond_1
    const/4 v0, 0x0

    :goto_1
    invoke-virtual {p0}, Ljava/lang/String;->length()I

    move-result v1

    if-ge v0, v1, :cond_0

    .line 554
    invoke-virtual {p0, v0}, Ljava/lang/String;->charAt(I)C

    move-result v1

    .line 555
    const/16 v2, 0x20

    if-eq v1, v2, :cond_2

    sget-object v2, Ljavax/mail/URLName;->dontNeedEncoding:Ljava/util/BitSet;

    invoke-virtual {v2, v1}, Ljava/util/BitSet;->get(I)Z

    move-result v1

    if-nez v1, :cond_3

    .line 556
    :cond_2
    invoke-static {p0}, Ljavax/mail/URLName;->_encode(Ljava/lang/String;)Ljava/lang/String;

    move-result-object p0

    goto :goto_0

    .line 553
    :cond_3
    add-int/lit8 v0, v0, 0x1

    goto :goto_1
.end method

.method private declared-synchronized getHostAddress()Ljava/net/InetAddress;
    .locals 2

    .prologue
    const/4 v0, 0x0

    .line 482
    monitor-enter p0

    :try_start_0
    iget-boolean v1, p0, Ljavax/mail/URLName;->hostAddressKnown:Z

    if-eqz v1, :cond_1

    .line 483
    iget-object v0, p0, Ljavax/mail/URLName;->hostAddress:Ljava/net/InetAddress;
    :try_end_0
    .catchall {:try_start_0 .. :try_end_0} :catchall_0

    .line 492
    :cond_0
    :goto_0
    monitor-exit p0

    return-object v0

    .line 484
    :cond_1
    :try_start_1
    iget-object v1, p0, Ljavax/mail/URLName;->host:Ljava/lang/String;
    :try_end_1
    .catchall {:try_start_1 .. :try_end_1} :catchall_0

    if-eqz v1, :cond_0

    .line 487
    :try_start_2
    iget-object v0, p0, Ljavax/mail/URLName;->host:Ljava/lang/String;

    invoke-static {v0}, Ljava/net/InetAddress;->getByName(Ljava/lang/String;)Ljava/net/InetAddress;

    move-result-object v0

    iput-object v0, p0, Ljavax/mail/URLName;->hostAddress:Ljava/net/InetAddress;
    :try_end_2
    .catch Ljava/net/UnknownHostException; {:try_start_2 .. :try_end_2} :catch_0
    .catchall {:try_start_2 .. :try_end_2} :catchall_0

    .line 491
    :goto_1
    const/4 v0, 0x1

    :try_start_3
    iput-boolean v0, p0, Ljavax/mail/URLName;->hostAddressKnown:Z

    .line 492
    iget-object v0, p0, Ljavax/mail/URLName;->hostAddress:Ljava/net/InetAddress;

    goto :goto_0

    .line 488
    :catch_0
    move-exception v0

    .line 489
    const/4 v0, 0x0

    iput-object v0, p0, Ljavax/mail/URLName;->hostAddress:Ljava/net/InetAddress;
    :try_end_3
    .catchall {:try_start_3 .. :try_end_3} :catchall_0

    goto :goto_1

    .line 482
    :catchall_0
    move-exception v0

    monitor-exit p0

    throw v0
.end method

.method private static indexOfAny(Ljava/lang/String;Ljava/lang/String;)I
    .locals 1

    .prologue
    .line 682
    const/4 v0, 0x0

    invoke-static {p0, p1, v0}, Ljavax/mail/URLName;->indexOfAny(Ljava/lang/String;Ljava/lang/String;I)I

    move-result v0

    return v0
.end method

.method private static indexOfAny(Ljava/lang/String;Ljava/lang/String;I)I
    .locals 4

    .prologue
    const/4 v1, -0x1

    .line 687
    :try_start_0
    invoke-virtual {p0}, Ljava/lang/String;->length()I

    move-result v2

    move v0, p2

    .line 688
    :goto_0
    if-lt v0, v2, :cond_1

    move v0, v1

    .line 694
    :cond_0
    :goto_1
    return v0

    .line 689
    :cond_1
    invoke-virtual {p0, v0}, Ljava/lang/String;->charAt(I)C

    move-result v3

    invoke-virtual {p1, v3}, Ljava/lang/String;->indexOf(I)I
    :try_end_0
    .catch Ljava/lang/StringIndexOutOfBoundsException; {:try_start_0 .. :try_end_0} :catch_0

    move-result v3

    if-gez v3, :cond_0

    .line 688
    add-int/lit8 v0, v0, 0x1

    goto :goto_0

    .line 693
    :catch_0
    move-exception v0

    move v0, v1

    .line 694
    goto :goto_1
.end method


# virtual methods
.method public equals(Ljava/lang/Object;)Z
    .locals 3

    .prologue
    const/4 v2, 0x0

    .line 408
    instance-of v0, p1, Ljavax/mail/URLName;

    if-nez v0, :cond_0

    move v0, v2

    .line 452
    :goto_0
    return v0

    .line 410
    :cond_0
    check-cast p1, Ljavax/mail/URLName;

    .line 413
    iget-object v0, p1, Ljavax/mail/URLName;->protocol:Ljava/lang/String;

    if-eqz v0, :cond_1

    iget-object v0, p1, Ljavax/mail/URLName;->protocol:Ljava/lang/String;

    iget-object v1, p0, Ljavax/mail/URLName;->protocol:Ljava/lang/String;

    invoke-virtual {v0, v1}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v0

    if-nez v0, :cond_2

    :cond_1
    move v0, v2

    .line 414
    goto :goto_0

    .line 417
    :cond_2
    invoke-direct {p0}, Ljavax/mail/URLName;->getHostAddress()Ljava/net/InetAddress;

    move-result-object v0

    invoke-direct {p1}, Ljavax/mail/URLName;->getHostAddress()Ljava/net/InetAddress;

    move-result-object v1

    .line 419
    if-eqz v0, :cond_3

    if-eqz v1, :cond_3

    .line 420
    invoke-virtual {v0, v1}, Ljava/net/InetAddress;->equals(Ljava/lang/Object;)Z

    move-result v0

    if-nez v0, :cond_5

    move v0, v2

    .line 421
    goto :goto_0

    .line 423
    :cond_3
    iget-object v0, p0, Ljavax/mail/URLName;->host:Ljava/lang/String;

    if-eqz v0, :cond_4

    iget-object v0, p1, Ljavax/mail/URLName;->host:Ljava/lang/String;

    if-eqz v0, :cond_4

    .line 424
    iget-object v0, p0, Ljavax/mail/URLName;->host:Ljava/lang/String;

    iget-object v1, p1, Ljavax/mail/URLName;->host:Ljava/lang/String;

    invoke-virtual {v0, v1}, Ljava/lang/String;->equalsIgnoreCase(Ljava/lang/String;)Z

    move-result v0

    if-nez v0, :cond_5

    move v0, v2

    .line 425
    goto :goto_0

    .line 427
    :cond_4
    iget-object v0, p0, Ljavax/mail/URLName;->host:Ljava/lang/String;

    iget-object v1, p1, Ljavax/mail/URLName;->host:Ljava/lang/String;

    if-eq v0, v1, :cond_5

    move v0, v2

    .line 428
    goto :goto_0

    .line 433
    :cond_5
    iget-object v0, p0, Ljavax/mail/URLName;->username:Ljava/lang/String;

    iget-object v1, p1, Ljavax/mail/URLName;->username:Ljava/lang/String;

    if-eq v0, v1, :cond_7

    .line 434
    iget-object v0, p0, Ljavax/mail/URLName;->username:Ljava/lang/String;

    if-eqz v0, :cond_6

    iget-object v0, p0, Ljavax/mail/URLName;->username:Ljava/lang/String;

    iget-object v1, p1, Ljavax/mail/URLName;->username:Ljava/lang/String;

    invoke-virtual {v0, v1}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v0

    if-nez v0, :cond_7

    :cond_6
    move v0, v2

    .line 435
    goto :goto_0

    .line 441
    :cond_7
    iget-object v0, p0, Ljavax/mail/URLName;->file:Ljava/lang/String;

    if-nez v0, :cond_8

    const-string v0, ""

    .line 442
    :goto_1
    iget-object v1, p1, Ljavax/mail/URLName;->file:Ljava/lang/String;

    if-nez v1, :cond_9

    const-string v1, ""

    .line 444
    :goto_2
    invoke-virtual {v0, v1}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v0

    if-nez v0, :cond_a

    move v0, v2

    .line 445
    goto :goto_0

    .line 441
    :cond_8
    iget-object v0, p0, Ljavax/mail/URLName;->file:Ljava/lang/String;

    goto :goto_1

    .line 442
    :cond_9
    iget-object v1, p1, Ljavax/mail/URLName;->file:Ljava/lang/String;

    goto :goto_2

    .line 448
    :cond_a
    iget v0, p0, Ljavax/mail/URLName;->port:I

    iget v1, p1, Ljavax/mail/URLName;->port:I

    if-eq v0, v1, :cond_b

    move v0, v2

    .line 449
    goto :goto_0

    .line 452
    :cond_b
    const/4 v0, 0x1

    goto :goto_0
.end method

.method public getFile()Ljava/lang/String;
    .locals 1

    .prologue
    .line 344
    iget-object v0, p0, Ljavax/mail/URLName;->file:Ljava/lang/String;

    return-object v0
.end method

.method public getHost()Ljava/lang/String;
    .locals 1

    .prologue
    .line 360
    iget-object v0, p0, Ljavax/mail/URLName;->host:Ljava/lang/String;

    return-object v0
.end method

.method public getPassword()Ljava/lang/String;
    .locals 1

    .prologue
    .line 376
    sget-boolean v0, Ljavax/mail/URLName;->doEncode:Z

    if-eqz v0, :cond_0

    iget-object v0, p0, Ljavax/mail/URLName;->password:Ljava/lang/String;

    invoke-static {v0}, Ljavax/mail/URLName;->decode(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v0

    :goto_0
    return-object v0

    :cond_0
    iget-object v0, p0, Ljavax/mail/URLName;->password:Ljava/lang/String;

    goto :goto_0
.end method

.method public getPort()I
    .locals 1

    .prologue
    .line 328
    iget v0, p0, Ljavax/mail/URLName;->port:I

    return v0
.end method

.method public getProtocol()Ljava/lang/String;
    .locals 1

    .prologue
    .line 336
    iget-object v0, p0, Ljavax/mail/URLName;->protocol:Ljava/lang/String;

    return-object v0
.end method

.method public getRef()Ljava/lang/String;
    .locals 1

    .prologue
    .line 352
    iget-object v0, p0, Ljavax/mail/URLName;->ref:Ljava/lang/String;

    return-object v0
.end method

.method public getURL()Ljava/net/URL;
    .locals 5
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljava/net/MalformedURLException;
        }
    .end annotation

    .prologue
    .line 383
    new-instance v0, Ljava/net/URL;

    invoke-virtual {p0}, Ljavax/mail/URLName;->getProtocol()Ljava/lang/String;

    move-result-object v1

    invoke-virtual {p0}, Ljavax/mail/URLName;->getHost()Ljava/lang/String;

    move-result-object v2

    invoke-virtual {p0}, Ljavax/mail/URLName;->getPort()I

    move-result v3

    invoke-virtual {p0}, Ljavax/mail/URLName;->getFile()Ljava/lang/String;

    move-result-object v4

    invoke-direct {v0, v1, v2, v3, v4}, Ljava/net/URL;-><init>(Ljava/lang/String;Ljava/lang/String;ILjava/lang/String;)V

    return-object v0
.end method

.method public getUsername()Ljava/lang/String;
    .locals 1

    .prologue
    .line 368
    sget-boolean v0, Ljavax/mail/URLName;->doEncode:Z

    if-eqz v0, :cond_0

    iget-object v0, p0, Ljavax/mail/URLName;->username:Ljava/lang/String;

    invoke-static {v0}, Ljavax/mail/URLName;->decode(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v0

    :goto_0
    return-object v0

    :cond_0
    iget-object v0, p0, Ljavax/mail/URLName;->username:Ljava/lang/String;

    goto :goto_0
.end method

.method public hashCode()I
    .locals 3

    .prologue
    .line 459
    iget v0, p0, Ljavax/mail/URLName;->hashCode:I

    if-eqz v0, :cond_0

    .line 460
    iget v0, p0, Ljavax/mail/URLName;->hashCode:I

    .line 473
    :goto_0
    return v0

    .line 461
    :cond_0
    iget-object v0, p0, Ljavax/mail/URLName;->protocol:Ljava/lang/String;

    if-eqz v0, :cond_1

    .line 462
    iget v0, p0, Ljavax/mail/URLName;->hashCode:I

    iget-object v1, p0, Ljavax/mail/URLName;->protocol:Ljava/lang/String;

    invoke-virtual {v1}, Ljava/lang/String;->hashCode()I

    move-result v1

    add-int/2addr v0, v1

    iput v0, p0, Ljavax/mail/URLName;->hashCode:I

    .line 463
    :cond_1
    invoke-direct {p0}, Ljavax/mail/URLName;->getHostAddress()Ljava/net/InetAddress;

    move-result-object v0

    .line 464
    if-eqz v0, :cond_5

    .line 465
    iget v1, p0, Ljavax/mail/URLName;->hashCode:I

    invoke-virtual {v0}, Ljava/net/InetAddress;->hashCode()I

    move-result v0

    add-int/2addr v0, v1

    iput v0, p0, Ljavax/mail/URLName;->hashCode:I

    .line 468
    :cond_2
    :goto_1
    iget-object v0, p0, Ljavax/mail/URLName;->username:Ljava/lang/String;

    if-eqz v0, :cond_3

    .line 469
    iget v0, p0, Ljavax/mail/URLName;->hashCode:I

    iget-object v1, p0, Ljavax/mail/URLName;->username:Ljava/lang/String;

    invoke-virtual {v1}, Ljava/lang/String;->hashCode()I

    move-result v1

    add-int/2addr v0, v1

    iput v0, p0, Ljavax/mail/URLName;->hashCode:I

    .line 470
    :cond_3
    iget-object v0, p0, Ljavax/mail/URLName;->file:Ljava/lang/String;

    if-eqz v0, :cond_4

    .line 471
    iget v0, p0, Ljavax/mail/URLName;->hashCode:I

    iget-object v1, p0, Ljavax/mail/URLName;->file:Ljava/lang/String;

    invoke-virtual {v1}, Ljava/lang/String;->hashCode()I

    move-result v1

    add-int/2addr v0, v1

    iput v0, p0, Ljavax/mail/URLName;->hashCode:I

    .line 472
    :cond_4
    iget v0, p0, Ljavax/mail/URLName;->hashCode:I

    iget v1, p0, Ljavax/mail/URLName;->port:I

    add-int/2addr v0, v1

    iput v0, p0, Ljavax/mail/URLName;->hashCode:I

    .line 473
    iget v0, p0, Ljavax/mail/URLName;->hashCode:I

    goto :goto_0

    .line 466
    :cond_5
    iget-object v0, p0, Ljavax/mail/URLName;->host:Ljava/lang/String;

    if-eqz v0, :cond_2

    .line 467
    iget v0, p0, Ljavax/mail/URLName;->hashCode:I

    iget-object v1, p0, Ljavax/mail/URLName;->host:Ljava/lang/String;

    sget-object v2, Ljava/util/Locale;->ENGLISH:Ljava/util/Locale;

    invoke-virtual {v1, v2}, Ljava/lang/String;->toLowerCase(Ljava/util/Locale;)Ljava/lang/String;

    move-result-object v1

    invoke-virtual {v1}, Ljava/lang/String;->hashCode()I

    move-result v1

    add-int/2addr v0, v1

    iput v0, p0, Ljavax/mail/URLName;->hashCode:I

    goto :goto_1
.end method

.method protected parseString(Ljava/lang/String;)V
    .locals 8

    .prologue
    const/16 v7, 0x3a

    const/4 v6, 0x0

    const/4 v5, -0x1

    .line 246
    const/4 v0, 0x0

    iput-object v0, p0, Ljavax/mail/URLName;->password:Ljava/lang/String;

    iput-object v0, p0, Ljavax/mail/URLName;->username:Ljava/lang/String;

    iput-object v0, p0, Ljavax/mail/URLName;->host:Ljava/lang/String;

    iput-object v0, p0, Ljavax/mail/URLName;->ref:Ljava/lang/String;

    iput-object v0, p0, Ljavax/mail/URLName;->file:Ljava/lang/String;

    iput-object v0, p0, Ljavax/mail/URLName;->protocol:Ljava/lang/String;

    .line 247
    iput v5, p0, Ljavax/mail/URLName;->port:I

    .line 249
    invoke-virtual {p1}, Ljava/lang/String;->length()I

    move-result v1

    .line 254
    invoke-virtual {p1, v7}, Ljava/lang/String;->indexOf(I)I

    move-result v0

    .line 255
    if-eq v0, v5, :cond_0

    .line 256
    invoke-virtual {p1, v6, v0}, Ljava/lang/String;->substring(II)Ljava/lang/String;

    move-result-object v2

    iput-object v2, p0, Ljavax/mail/URLName;->protocol:Ljava/lang/String;

    .line 259
    :cond_0
    add-int/lit8 v2, v0, 0x1

    const-string v3, "//"

    const/4 v4, 0x2

    invoke-virtual {p1, v2, v3, v6, v4}, Ljava/lang/String;->regionMatches(ILjava/lang/String;II)Z

    move-result v2

    if-eqz v2, :cond_a

    .line 262
    const/16 v2, 0x2f

    add-int/lit8 v3, v0, 0x3

    invoke-virtual {p1, v2, v3}, Ljava/lang/String;->indexOf(II)I

    move-result v2

    .line 263
    if-eq v2, v5, :cond_6

    .line 264
    add-int/lit8 v0, v0, 0x3

    invoke-virtual {p1, v0, v2}, Ljava/lang/String;->substring(II)Ljava/lang/String;

    move-result-object v0

    .line 265
    add-int/lit8 v3, v2, 0x1

    if-ge v3, v1, :cond_5

    .line 266
    add-int/lit8 v1, v2, 0x1

    invoke-virtual {p1, v1}, Ljava/lang/String;->substring(I)Ljava/lang/String;

    move-result-object v1

    iput-object v1, p0, Ljavax/mail/URLName;->file:Ljava/lang/String;

    .line 273
    :goto_0
    const/16 v1, 0x40

    invoke-virtual {v0, v1}, Ljava/lang/String;->indexOf(I)I

    move-result v1

    .line 274
    if-eq v1, v5, :cond_1

    .line 275
    invoke-virtual {v0, v6, v1}, Ljava/lang/String;->substring(II)Ljava/lang/String;

    move-result-object v2

    .line 276
    add-int/lit8 v1, v1, 0x1

    invoke-virtual {v0, v1}, Ljava/lang/String;->substring(I)Ljava/lang/String;

    move-result-object v0

    .line 279
    invoke-virtual {v2, v7}, Ljava/lang/String;->indexOf(I)I

    move-result v1

    .line 280
    if-eq v1, v5, :cond_7

    .line 281
    invoke-virtual {v2, v6, v1}, Ljava/lang/String;->substring(II)Ljava/lang/String;

    move-result-object v3

    iput-object v3, p0, Ljavax/mail/URLName;->username:Ljava/lang/String;

    .line 282
    add-int/lit8 v1, v1, 0x1

    invoke-virtual {v2, v1}, Ljava/lang/String;->substring(I)Ljava/lang/String;

    move-result-object v1

    iput-object v1, p0, Ljavax/mail/URLName;->password:Ljava/lang/String;

    .line 290
    :cond_1
    :goto_1
    invoke-virtual {v0}, Ljava/lang/String;->length()I

    move-result v1

    if-lez v1, :cond_8

    invoke-virtual {v0, v6}, Ljava/lang/String;->charAt(I)C

    move-result v1

    const/16 v2, 0x5b

    if-ne v1, v2, :cond_8

    .line 292
    const/16 v1, 0x5d

    invoke-virtual {v0, v1}, Ljava/lang/String;->indexOf(I)I

    move-result v1

    invoke-virtual {v0, v7, v1}, Ljava/lang/String;->indexOf(II)I

    move-result v1

    .line 296
    :goto_2
    if-eq v1, v5, :cond_9

    .line 297
    add-int/lit8 v2, v1, 0x1

    invoke-virtual {v0, v2}, Ljava/lang/String;->substring(I)Ljava/lang/String;

    move-result-object v2

    .line 298
    invoke-virtual {v2}, Ljava/lang/String;->length()I

    move-result v3

    if-lez v3, :cond_2

    .line 300
    :try_start_0
    invoke-static {v2}, Ljava/lang/Integer;->parseInt(Ljava/lang/String;)I

    move-result v2

    iput v2, p0, Ljavax/mail/URLName;->port:I
    :try_end_0
    .catch Ljava/lang/NumberFormatException; {:try_start_0 .. :try_end_0} :catch_0

    .line 306
    :cond_2
    :goto_3
    invoke-virtual {v0, v6, v1}, Ljava/lang/String;->substring(II)Ljava/lang/String;

    move-result-object v0

    iput-object v0, p0, Ljavax/mail/URLName;->host:Ljava/lang/String;

    .line 317
    :cond_3
    :goto_4
    iget-object v0, p0, Ljavax/mail/URLName;->file:Ljava/lang/String;

    if-eqz v0, :cond_4

    iget-object v0, p0, Ljavax/mail/URLName;->file:Ljava/lang/String;

    const/16 v1, 0x23

    invoke-virtual {v0, v1}, Ljava/lang/String;->indexOf(I)I

    move-result v0

    if-eq v0, v5, :cond_4

    .line 318
    iget-object v1, p0, Ljavax/mail/URLName;->file:Ljava/lang/String;

    add-int/lit8 v2, v0, 0x1

    invoke-virtual {v1, v2}, Ljava/lang/String;->substring(I)Ljava/lang/String;

    move-result-object v1

    iput-object v1, p0, Ljavax/mail/URLName;->ref:Ljava/lang/String;

    .line 319
    iget-object v1, p0, Ljavax/mail/URLName;->file:Ljava/lang/String;

    invoke-virtual {v1, v6, v0}, Ljava/lang/String;->substring(II)Ljava/lang/String;

    move-result-object v0

    iput-object v0, p0, Ljavax/mail/URLName;->file:Ljava/lang/String;

    .line 321
    :cond_4
    return-void

    .line 268
    :cond_5
    const-string v1, ""

    iput-object v1, p0, Ljavax/mail/URLName;->file:Ljava/lang/String;

    goto :goto_0

    .line 270
    :cond_6
    add-int/lit8 v0, v0, 0x3

    invoke-virtual {p1, v0}, Ljava/lang/String;->substring(I)Ljava/lang/String;

    move-result-object v0

    goto/16 :goto_0

    .line 284
    :cond_7
    iput-object v2, p0, Ljavax/mail/URLName;->username:Ljava/lang/String;

    goto :goto_1

    .line 294
    :cond_8
    invoke-virtual {v0, v7}, Ljava/lang/String;->indexOf(I)I

    move-result v1

    goto :goto_2

    .line 301
    :catch_0
    move-exception v2

    .line 302
    iput v5, p0, Ljavax/mail/URLName;->port:I

    goto :goto_3

    .line 308
    :cond_9
    iput-object v0, p0, Ljavax/mail/URLName;->host:Ljava/lang/String;

    goto :goto_4

    .line 311
    :cond_a
    add-int/lit8 v2, v0, 0x1

    if-ge v2, v1, :cond_3

    .line 312
    add-int/lit8 v0, v0, 0x1

    invoke-virtual {p1, v0}, Ljava/lang/String;->substring(I)Ljava/lang/String;

    move-result-object v0

    iput-object v0, p0, Ljavax/mail/URLName;->file:Ljava/lang/String;

    goto :goto_4
.end method

.method public toString()Ljava/lang/String;
    .locals 3

    .prologue
    .line 183
    iget-object v0, p0, Ljavax/mail/URLName;->fullURL:Ljava/lang/String;

    if-nez v0, :cond_9

    .line 185
    new-instance v0, Ljava/lang/StringBuffer;

    invoke-direct {v0}, Ljava/lang/StringBuffer;-><init>()V

    .line 186
    iget-object v1, p0, Ljavax/mail/URLName;->protocol:Ljava/lang/String;

    if-eqz v1, :cond_0

    .line 187
    iget-object v1, p0, Ljavax/mail/URLName;->protocol:Ljava/lang/String;

    invoke-virtual {v0, v1}, Ljava/lang/StringBuffer;->append(Ljava/lang/String;)Ljava/lang/StringBuffer;

    .line 188
    const-string v1, ":"

    invoke-virtual {v0, v1}, Ljava/lang/StringBuffer;->append(Ljava/lang/String;)Ljava/lang/StringBuffer;

    .line 191
    :cond_0
    iget-object v1, p0, Ljavax/mail/URLName;->username:Ljava/lang/String;

    if-nez v1, :cond_1

    iget-object v1, p0, Ljavax/mail/URLName;->host:Ljava/lang/String;

    if-eqz v1, :cond_6

    .line 193
    :cond_1
    const-string v1, "//"

    invoke-virtual {v0, v1}, Ljava/lang/StringBuffer;->append(Ljava/lang/String;)Ljava/lang/StringBuffer;

    .line 197
    iget-object v1, p0, Ljavax/mail/URLName;->username:Ljava/lang/String;

    if-eqz v1, :cond_3

    .line 198
    iget-object v1, p0, Ljavax/mail/URLName;->username:Ljava/lang/String;

    invoke-virtual {v0, v1}, Ljava/lang/StringBuffer;->append(Ljava/lang/String;)Ljava/lang/StringBuffer;

    .line 200
    iget-object v1, p0, Ljavax/mail/URLName;->password:Ljava/lang/String;

    if-eqz v1, :cond_2

    .line 201
    const-string v1, ":"

    invoke-virtual {v0, v1}, Ljava/lang/StringBuffer;->append(Ljava/lang/String;)Ljava/lang/StringBuffer;

    .line 202
    iget-object v1, p0, Ljavax/mail/URLName;->password:Ljava/lang/String;

    invoke-virtual {v0, v1}, Ljava/lang/StringBuffer;->append(Ljava/lang/String;)Ljava/lang/StringBuffer;

    .line 205
    :cond_2
    const-string v1, "@"

    invoke-virtual {v0, v1}, Ljava/lang/StringBuffer;->append(Ljava/lang/String;)Ljava/lang/StringBuffer;

    .line 209
    :cond_3
    iget-object v1, p0, Ljavax/mail/URLName;->host:Ljava/lang/String;

    if-eqz v1, :cond_4

    .line 210
    iget-object v1, p0, Ljavax/mail/URLName;->host:Ljava/lang/String;

    invoke-virtual {v0, v1}, Ljava/lang/StringBuffer;->append(Ljava/lang/String;)Ljava/lang/StringBuffer;

    .line 214
    :cond_4
    iget v1, p0, Ljavax/mail/URLName;->port:I

    const/4 v2, -0x1

    if-eq v1, v2, :cond_5

    .line 215
    const-string v1, ":"

    invoke-virtual {v0, v1}, Ljava/lang/StringBuffer;->append(Ljava/lang/String;)Ljava/lang/StringBuffer;

    .line 216
    iget v1, p0, Ljavax/mail/URLName;->port:I

    invoke-static {v1}, Ljava/lang/Integer;->toString(I)Ljava/lang/String;

    move-result-object v1

    invoke-virtual {v0, v1}, Ljava/lang/StringBuffer;->append(Ljava/lang/String;)Ljava/lang/StringBuffer;

    .line 218
    :cond_5
    iget-object v1, p0, Ljavax/mail/URLName;->file:Ljava/lang/String;

    if-eqz v1, :cond_6

    .line 219
    const-string v1, "/"

    invoke-virtual {v0, v1}, Ljava/lang/StringBuffer;->append(Ljava/lang/String;)Ljava/lang/StringBuffer;

    .line 223
    :cond_6
    iget-object v1, p0, Ljavax/mail/URLName;->file:Ljava/lang/String;

    if-eqz v1, :cond_7

    .line 224
    iget-object v1, p0, Ljavax/mail/URLName;->file:Ljava/lang/String;

    invoke-virtual {v0, v1}, Ljava/lang/StringBuffer;->append(Ljava/lang/String;)Ljava/lang/StringBuffer;

    .line 228
    :cond_7
    iget-object v1, p0, Ljavax/mail/URLName;->ref:Ljava/lang/String;

    if-eqz v1, :cond_8

    .line 229
    const-string v1, "#"

    invoke-virtual {v0, v1}, Ljava/lang/StringBuffer;->append(Ljava/lang/String;)Ljava/lang/StringBuffer;

    .line 230
    iget-object v1, p0, Ljavax/mail/URLName;->ref:Ljava/lang/String;

    invoke-virtual {v0, v1}, Ljava/lang/StringBuffer;->append(Ljava/lang/String;)Ljava/lang/StringBuffer;

    .line 234
    :cond_8
    invoke-virtual {v0}, Ljava/lang/StringBuffer;->toString()Ljava/lang/String;

    move-result-object v0

    iput-object v0, p0, Ljavax/mail/URLName;->fullURL:Ljava/lang/String;

    .line 237
    :cond_9
    iget-object v0, p0, Ljavax/mail/URLName;->fullURL:Ljava/lang/String;

    return-object v0
.end method
