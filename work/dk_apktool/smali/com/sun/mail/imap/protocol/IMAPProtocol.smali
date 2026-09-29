.class public Lcom/sun/mail/imap/protocol/IMAPProtocol;
.super Lcom/sun/mail/iap/Protocol;
.source "SourceFile"


# static fields
.field private static final CRLF:[B

.field private static final DONE:[B


# instance fields
.field private authenticated:Z

.field private authmechs:Ljava/util/List;

.field private ba:Lcom/sun/mail/iap/ByteArray;

.field private capabilities:Ljava/util/Map;

.field private connected:Z

.field private idleTag:Ljava/lang/String;

.field private name:Ljava/lang/String;

.field private rev1:Z

.field private saslAuthenticator:Lcom/sun/mail/imap/protocol/SaslAuthenticator;

.field private searchCharsets:[Ljava/lang/String;


# direct methods
.method static constructor <clinit>()V
    .locals 1

    .prologue
    .line 90
    const/4 v0, 0x2

    new-array v0, v0, [B

    fill-array-data v0, :array_0

    sput-object v0, Lcom/sun/mail/imap/protocol/IMAPProtocol;->CRLF:[B

    .line 2083
    const/4 v0, 0x6

    new-array v0, v0, [B

    fill-array-data v0, :array_1

    sput-object v0, Lcom/sun/mail/imap/protocol/IMAPProtocol;->DONE:[B

    .line 73
    return-void

    .line 90
    nop

    :array_0
    .array-data 1
        0xdt
        0xat
    .end array-data

    .line 2083
    nop

    :array_1
    .array-data 1
        0x44t
        0x4ft
        0x4et
        0x45t
        0xdt
        0xat
    .end array-data
.end method

.method public constructor <init>(Ljava/lang/String;Ljava/lang/String;IZLjava/io/PrintStream;Ljava/util/Properties;Z)V
    .locals 8
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljava/io/IOException;,
            Lcom/sun/mail/iap/ProtocolException;
        }
    .end annotation

    .prologue
    .line 104
    new-instance v0, Ljava/lang/StringBuilder;

    const-string v1, "mail."

    invoke-direct {v0, v1}, Ljava/lang/StringBuilder;-><init>(Ljava/lang/String;)V

    invoke-virtual {v0, p1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-virtual {v0}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v6

    move-object v0, p0

    move-object v1, p2

    move v2, p3

    move v3, p4

    move-object v4, p5

    move-object v5, p6

    move v7, p7

    invoke-direct/range {v0 .. v7}, Lcom/sun/mail/iap/Protocol;-><init>(Ljava/lang/String;IZLjava/io/PrintStream;Ljava/util/Properties;Ljava/lang/String;Z)V

    .line 75
    const/4 v0, 0x0

    iput-boolean v0, p0, Lcom/sun/mail/imap/protocol/IMAPProtocol;->connected:Z

    .line 76
    const/4 v0, 0x0

    iput-boolean v0, p0, Lcom/sun/mail/imap/protocol/IMAPProtocol;->rev1:Z

    .line 81
    const/4 v0, 0x0

    iput-object v0, p0, Lcom/sun/mail/imap/protocol/IMAPProtocol;->capabilities:Ljava/util/Map;

    .line 82
    const/4 v0, 0x0

    iput-object v0, p0, Lcom/sun/mail/imap/protocol/IMAPProtocol;->authmechs:Ljava/util/List;

    .line 107
    :try_start_0
    iput-object p1, p0, Lcom/sun/mail/imap/protocol/IMAPProtocol;->name:Ljava/lang/String;

    .line 109
    iget-object v0, p0, Lcom/sun/mail/imap/protocol/IMAPProtocol;->capabilities:Ljava/util/Map;

    if-nez v0, :cond_0

    .line 110
    invoke-virtual {p0}, Lcom/sun/mail/imap/protocol/IMAPProtocol;->capability()V

    .line 112
    :cond_0
    const-string v0, "IMAP4rev1"

    invoke-virtual {p0, v0}, Lcom/sun/mail/imap/protocol/IMAPProtocol;->hasCapability(Ljava/lang/String;)Z

    move-result v0

    if-eqz v0, :cond_1

    .line 113
    const/4 v0, 0x1

    iput-boolean v0, p0, Lcom/sun/mail/imap/protocol/IMAPProtocol;->rev1:Z

    .line 115
    :cond_1
    const/4 v0, 0x2

    new-array v0, v0, [Ljava/lang/String;

    iput-object v0, p0, Lcom/sun/mail/imap/protocol/IMAPProtocol;->searchCharsets:[Ljava/lang/String;

    .line 116
    iget-object v0, p0, Lcom/sun/mail/imap/protocol/IMAPProtocol;->searchCharsets:[Ljava/lang/String;

    const/4 v1, 0x0

    const-string v2, "UTF-8"

    aput-object v2, v0, v1

    .line 117
    iget-object v0, p0, Lcom/sun/mail/imap/protocol/IMAPProtocol;->searchCharsets:[Ljava/lang/String;

    const/4 v1, 0x1

    .line 118
    invoke-static {}, Ljavax/mail/internet/MimeUtility;->getDefaultJavaCharset()Ljava/lang/String;

    move-result-object v2

    .line 117
    invoke-static {v2}, Ljavax/mail/internet/MimeUtility;->mimeCharset(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v2

    aput-object v2, v0, v1

    .line 121
    const/4 v0, 0x1

    iput-boolean v0, p0, Lcom/sun/mail/imap/protocol/IMAPProtocol;->connected:Z
    :try_end_0
    .catchall {:try_start_0 .. :try_end_0} :catchall_0

    .line 129
    iget-boolean v0, p0, Lcom/sun/mail/imap/protocol/IMAPProtocol;->connected:Z

    if-nez v0, :cond_2

    .line 130
    invoke-virtual {p0}, Lcom/sun/mail/imap/protocol/IMAPProtocol;->disconnect()V

    .line 132
    :cond_2
    return-void

    .line 122
    :catchall_0
    move-exception v0

    .line 129
    iget-boolean v1, p0, Lcom/sun/mail/imap/protocol/IMAPProtocol;->connected:Z

    if-nez v1, :cond_3

    .line 130
    invoke-virtual {p0}, Lcom/sun/mail/imap/protocol/IMAPProtocol;->disconnect()V

    .line 131
    :cond_3
    throw v0
.end method

.method private copy(Ljava/lang/String;Ljava/lang/String;)V
    .locals 2
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Lcom/sun/mail/iap/ProtocolException;
        }
    .end annotation

    .prologue
    .line 1332
    invoke-static {p2}, Lcom/sun/mail/imap/protocol/BASE64MailboxEncoder;->encode(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v0

    .line 1334
    new-instance v1, Lcom/sun/mail/iap/Argument;

    invoke-direct {v1}, Lcom/sun/mail/iap/Argument;-><init>()V

    .line 1335
    invoke-virtual {v1, p1}, Lcom/sun/mail/iap/Argument;->writeAtom(Ljava/lang/String;)V

    .line 1336
    invoke-virtual {v1, v0}, Lcom/sun/mail/iap/Argument;->writeString(Ljava/lang/String;)V

    .line 1338
    const-string v0, "COPY"

    invoke-virtual {p0, v0, v1}, Lcom/sun/mail/imap/protocol/IMAPProtocol;->simpleCommand(Ljava/lang/String;Lcom/sun/mail/iap/Argument;)V

    .line 1339
    return-void
.end method

.method private createFlagList(Ljavax/mail/Flags;)Ljava/lang/String;
    .locals 8

    .prologue
    const/16 v7, 0x20

    const/4 v1, 0x0

    .line 1379
    new-instance v4, Ljava/lang/StringBuffer;

    invoke-direct {v4}, Ljava/lang/StringBuffer;-><init>()V

    .line 1380
    const-string v0, "("

    invoke-virtual {v4, v0}, Ljava/lang/StringBuffer;->append(Ljava/lang/String;)Ljava/lang/StringBuffer;

    .line 1382
    invoke-virtual {p1}, Ljavax/mail/Flags;->getSystemFlags()[Ljavax/mail/Flags$Flag;

    move-result-object v5

    .line 1383
    const/4 v0, 0x1

    move v2, v0

    move v0, v1

    .line 1384
    :goto_0
    array-length v3, v5

    if-lt v0, v3, :cond_0

    .line 1408
    invoke-virtual {p1}, Ljavax/mail/Flags;->getUserFlags()[Ljava/lang/String;

    move-result-object v3

    move v0, v1

    .line 1409
    :goto_1
    array-length v5, v3

    if-lt v0, v5, :cond_8

    .line 1417
    const-string v0, ")"

    invoke-virtual {v4, v0}, Ljava/lang/StringBuffer;->append(Ljava/lang/String;)Ljava/lang/StringBuffer;

    .line 1418
    invoke-virtual {v4}, Ljava/lang/StringBuffer;->toString()Ljava/lang/String;

    move-result-object v0

    return-object v0

    .line 1386
    :cond_0
    aget-object v3, v5, v0

    .line 1387
    sget-object v6, Ljavax/mail/Flags$Flag;->ANSWERED:Ljavax/mail/Flags$Flag;

    if-ne v3, v6, :cond_2

    .line 1388
    const-string v3, "\\Answered"

    .line 1401
    :goto_2
    if-eqz v2, :cond_7

    move v2, v1

    .line 1405
    :goto_3
    invoke-virtual {v4, v3}, Ljava/lang/StringBuffer;->append(Ljava/lang/String;)Ljava/lang/StringBuffer;

    .line 1384
    :cond_1
    add-int/lit8 v0, v0, 0x1

    goto :goto_0

    .line 1389
    :cond_2
    sget-object v6, Ljavax/mail/Flags$Flag;->DELETED:Ljavax/mail/Flags$Flag;

    if-ne v3, v6, :cond_3

    .line 1390
    const-string v3, "\\Deleted"

    goto :goto_2

    .line 1391
    :cond_3
    sget-object v6, Ljavax/mail/Flags$Flag;->DRAFT:Ljavax/mail/Flags$Flag;

    if-ne v3, v6, :cond_4

    .line 1392
    const-string v3, "\\Draft"

    goto :goto_2

    .line 1393
    :cond_4
    sget-object v6, Ljavax/mail/Flags$Flag;->FLAGGED:Ljavax/mail/Flags$Flag;

    if-ne v3, v6, :cond_5

    .line 1394
    const-string v3, "\\Flagged"

    goto :goto_2

    .line 1395
    :cond_5
    sget-object v6, Ljavax/mail/Flags$Flag;->RECENT:Ljavax/mail/Flags$Flag;

    if-ne v3, v6, :cond_6

    .line 1396
    const-string v3, "\\Recent"

    goto :goto_2

    .line 1397
    :cond_6
    sget-object v6, Ljavax/mail/Flags$Flag;->SEEN:Ljavax/mail/Flags$Flag;

    if-ne v3, v6, :cond_1

    .line 1398
    const-string v3, "\\Seen"

    goto :goto_2

    .line 1404
    :cond_7
    invoke-virtual {v4, v7}, Ljava/lang/StringBuffer;->append(C)Ljava/lang/StringBuffer;

    goto :goto_3

    .line 1410
    :cond_8
    if-eqz v2, :cond_9

    move v2, v1

    .line 1414
    :goto_4
    aget-object v5, v3, v0

    invoke-virtual {v4, v5}, Ljava/lang/StringBuffer;->append(Ljava/lang/String;)Ljava/lang/StringBuffer;

    .line 1409
    add-int/lit8 v0, v0, 0x1

    goto :goto_1

    .line 1413
    :cond_9
    invoke-virtual {v4, v7}, Ljava/lang/StringBuffer;->append(C)Ljava/lang/StringBuffer;

    goto :goto_4
.end method

.method private doList(Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;)[Lcom/sun/mail/imap/protocol/ListInfo;
    .locals 9
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Lcom/sun/mail/iap/ProtocolException;
        }
    .end annotation

    .prologue
    const/4 v1, 0x0

    .line 837
    invoke-static {p2}, Lcom/sun/mail/imap/protocol/BASE64MailboxEncoder;->encode(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v0

    .line 838
    invoke-static {p3}, Lcom/sun/mail/imap/protocol/BASE64MailboxEncoder;->encode(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v2

    .line 840
    new-instance v3, Lcom/sun/mail/iap/Argument;

    invoke-direct {v3}, Lcom/sun/mail/iap/Argument;-><init>()V

    .line 841
    invoke-virtual {v3, v0}, Lcom/sun/mail/iap/Argument;->writeString(Ljava/lang/String;)V

    .line 842
    invoke-virtual {v3, v2}, Lcom/sun/mail/iap/Argument;->writeString(Ljava/lang/String;)V

    .line 844
    invoke-virtual {p0, p1, v3}, Lcom/sun/mail/imap/protocol/IMAPProtocol;->command(Ljava/lang/String;Lcom/sun/mail/iap/Argument;)[Lcom/sun/mail/iap/Response;

    move-result-object v4

    move-object v0, v1

    .line 846
    check-cast v0, [Lcom/sun/mail/imap/protocol/ListInfo;

    .line 847
    array-length v2, v4

    add-int/lit8 v2, v2, -0x1

    aget-object v5, v4, v2

    .line 849
    invoke-virtual {v5}, Lcom/sun/mail/iap/Response;->isOK()Z

    move-result v2

    if-eqz v2, :cond_0

    .line 850
    new-instance v6, Ljava/util/Vector;

    const/4 v2, 0x1

    invoke-direct {v6, v2}, Ljava/util/Vector;-><init>(I)V

    .line 851
    const/4 v2, 0x0

    array-length v7, v4

    move v3, v2

    :goto_0
    if-lt v3, v7, :cond_1

    .line 861
    invoke-virtual {v6}, Ljava/util/Vector;->size()I

    move-result v1

    if-lez v1, :cond_0

    .line 862
    invoke-virtual {v6}, Ljava/util/Vector;->size()I

    move-result v0

    new-array v0, v0, [Lcom/sun/mail/imap/protocol/ListInfo;

    .line 863
    invoke-virtual {v6, v0}, Ljava/util/Vector;->copyInto([Ljava/lang/Object;)V

    .line 868
    :cond_0
    invoke-virtual {p0, v4}, Lcom/sun/mail/imap/protocol/IMAPProtocol;->notifyResponseHandlers([Lcom/sun/mail/iap/Response;)V

    .line 869
    invoke-virtual {p0, v5}, Lcom/sun/mail/imap/protocol/IMAPProtocol;->handleResult(Lcom/sun/mail/iap/Response;)V

    .line 870
    return-object v0

    .line 852
    :cond_1
    aget-object v2, v4, v3

    instance-of v2, v2, Lcom/sun/mail/imap/protocol/IMAPResponse;

    if-nez v2, :cond_3

    .line 851
    :cond_2
    :goto_1
    add-int/lit8 v2, v3, 0x1

    move v3, v2

    goto :goto_0

    .line 855
    :cond_3
    aget-object v2, v4, v3

    check-cast v2, Lcom/sun/mail/imap/protocol/IMAPResponse;

    .line 856
    invoke-virtual {v2, p1}, Lcom/sun/mail/imap/protocol/IMAPResponse;->keyEquals(Ljava/lang/String;)Z

    move-result v8

    if-eqz v8, :cond_2

    .line 857
    new-instance v8, Lcom/sun/mail/imap/protocol/ListInfo;

    invoke-direct {v8, v2}, Lcom/sun/mail/imap/protocol/ListInfo;-><init>(Lcom/sun/mail/imap/protocol/IMAPResponse;)V

    invoke-virtual {v6, v8}, Ljava/util/Vector;->addElement(Ljava/lang/Object;)V

    .line 858
    aput-object v1, v4, v3

    goto :goto_1
.end method

.method private fetch(Ljava/lang/String;Ljava/lang/String;Z)[Lcom/sun/mail/iap/Response;
    .locals 3
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Lcom/sun/mail/iap/ProtocolException;
        }
    .end annotation

    .prologue
    const/4 v2, 0x0

    .line 1309
    if-eqz p3, :cond_0

    .line 1310
    new-instance v0, Ljava/lang/StringBuilder;

    const-string v1, "UID FETCH "

    invoke-direct {v0, v1}, Ljava/lang/StringBuilder;-><init>(Ljava/lang/String;)V

    invoke-virtual {v0, p1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    const-string v1, " ("

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-virtual {v0, p2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    const-string v1, ")"

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-virtual {v0}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v0

    invoke-virtual {p0, v0, v2}, Lcom/sun/mail/imap/protocol/IMAPProtocol;->command(Ljava/lang/String;Lcom/sun/mail/iap/Argument;)[Lcom/sun/mail/iap/Response;

    move-result-object v0

    .line 1312
    :goto_0
    return-object v0

    :cond_0
    new-instance v0, Ljava/lang/StringBuilder;

    const-string v1, "FETCH "

    invoke-direct {v0, v1}, Ljava/lang/StringBuilder;-><init>(Ljava/lang/String;)V

    invoke-virtual {v0, p1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    const-string v1, " ("

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-virtual {v0, p2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    const-string v1, ")"

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-virtual {v0}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v0

    invoke-virtual {p0, v0, v2}, Lcom/sun/mail/imap/protocol/IMAPProtocol;->command(Ljava/lang/String;Lcom/sun/mail/iap/Argument;)[Lcom/sun/mail/iap/Response;

    move-result-object v0

    goto :goto_0
.end method

.method private getAppendUID(Lcom/sun/mail/iap/Response;)Lcom/sun/mail/imap/AppendUID;
    .locals 6

    .prologue
    const/4 v0, 0x0

    .line 944
    invoke-virtual {p1}, Lcom/sun/mail/iap/Response;->isOK()Z

    move-result v1

    if-nez v1, :cond_1

    .line 958
    :cond_0
    :goto_0
    return-object v0

    .line 947
    :cond_1
    invoke-virtual {p1}, Lcom/sun/mail/iap/Response;->readByte()B

    move-result v1

    if-lez v1, :cond_2

    const/16 v2, 0x5b

    if-ne v1, v2, :cond_1

    .line 949
    :cond_2
    if-eqz v1, :cond_0

    .line 952
    invoke-virtual {p1}, Lcom/sun/mail/iap/Response;->readAtom()Ljava/lang/String;

    move-result-object v1

    .line 953
    const-string v2, "APPENDUID"

    invoke-virtual {v1, v2}, Ljava/lang/String;->equalsIgnoreCase(Ljava/lang/String;)Z

    move-result v1

    if-eqz v1, :cond_0

    .line 956
    invoke-virtual {p1}, Lcom/sun/mail/iap/Response;->readLong()J

    move-result-wide v2

    .line 957
    invoke-virtual {p1}, Lcom/sun/mail/iap/Response;->readLong()J

    move-result-wide v4

    .line 958
    new-instance v0, Lcom/sun/mail/imap/AppendUID;

    invoke-direct {v0, v2, v3, v4, v5}, Lcom/sun/mail/imap/AppendUID;-><init>(JJ)V

    goto :goto_0
.end method

.method private issueSearch(Ljava/lang/String;Ljavax/mail/search/SearchTerm;Ljava/lang/String;)[I
    .locals 10
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Lcom/sun/mail/iap/ProtocolException;,
            Ljavax/mail/search/SearchException;,
            Ljava/io/IOException;
        }
    .end annotation

    .prologue
    const/4 v3, 0x0

    const/4 v1, 0x0

    .line 1507
    .line 1508
    if-nez p3, :cond_1

    move-object v0, v1

    .line 1507
    :goto_0
    invoke-static {p2, v0}, Lcom/sun/mail/imap/protocol/SearchSequence;->generateSequence(Ljavax/mail/search/SearchTerm;Ljava/lang/String;)Lcom/sun/mail/iap/Argument;

    move-result-object v0

    .line 1511
    invoke-virtual {v0, p1}, Lcom/sun/mail/iap/Argument;->writeAtom(Ljava/lang/String;)V

    .line 1515
    if-nez p3, :cond_2

    .line 1516
    const-string v2, "SEARCH"

    invoke-virtual {p0, v2, v0}, Lcom/sun/mail/imap/protocol/IMAPProtocol;->command(Ljava/lang/String;Lcom/sun/mail/iap/Argument;)[Lcom/sun/mail/iap/Response;

    move-result-object v0

    move-object v2, v0

    .line 1520
    :goto_1
    array-length v0, v2

    add-int/lit8 v0, v0, -0x1

    aget-object v5, v2, v0

    move-object v0, v1

    .line 1521
    check-cast v0, [I

    .line 1524
    invoke-virtual {v5}, Lcom/sun/mail/iap/Response;->isOK()Z

    move-result v4

    if-eqz v4, :cond_0

    .line 1525
    new-instance v6, Ljava/util/Vector;

    invoke-direct {v6}, Ljava/util/Vector;-><init>()V

    .line 1527
    array-length v7, v2

    move v4, v3

    :goto_2
    if-lt v4, v7, :cond_3

    .line 1541
    invoke-virtual {v6}, Ljava/util/Vector;->size()I

    move-result v4

    .line 1542
    new-array v1, v4, [I

    .line 1543
    :goto_3
    if-lt v3, v4, :cond_7

    move-object v0, v1

    .line 1548
    :cond_0
    invoke-virtual {p0, v2}, Lcom/sun/mail/imap/protocol/IMAPProtocol;->notifyResponseHandlers([Lcom/sun/mail/iap/Response;)V

    .line 1549
    invoke-virtual {p0, v5}, Lcom/sun/mail/imap/protocol/IMAPProtocol;->handleResult(Lcom/sun/mail/iap/Response;)V

    .line 1550
    return-object v0

    .line 1509
    :cond_1
    invoke-static {p3}, Ljavax/mail/internet/MimeUtility;->javaCharset(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v0

    goto :goto_0

    .line 1518
    :cond_2
    new-instance v2, Ljava/lang/StringBuilder;

    const-string v4, "SEARCH CHARSET "

    invoke-direct {v2, v4}, Ljava/lang/StringBuilder;-><init>(Ljava/lang/String;)V

    invoke-virtual {v2, p3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    invoke-virtual {v2}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v2

    invoke-virtual {p0, v2, v0}, Lcom/sun/mail/imap/protocol/IMAPProtocol;->command(Ljava/lang/String;Lcom/sun/mail/iap/Argument;)[Lcom/sun/mail/iap/Response;

    move-result-object v0

    move-object v2, v0

    goto :goto_1

    .line 1528
    :cond_3
    aget-object v0, v2, v4

    instance-of v0, v0, Lcom/sun/mail/imap/protocol/IMAPResponse;

    if-nez v0, :cond_5

    .line 1527
    :cond_4
    :goto_4
    add-int/lit8 v0, v4, 0x1

    move v4, v0

    goto :goto_2

    .line 1531
    :cond_5
    aget-object v0, v2, v4

    check-cast v0, Lcom/sun/mail/imap/protocol/IMAPResponse;

    .line 1533
    const-string v8, "SEARCH"

    invoke-virtual {v0, v8}, Lcom/sun/mail/imap/protocol/IMAPResponse;->keyEquals(Ljava/lang/String;)Z

    move-result v8

    if-eqz v8, :cond_4

    .line 1534
    :goto_5
    invoke-virtual {v0}, Lcom/sun/mail/imap/protocol/IMAPResponse;->readNumber()I

    move-result v8

    const/4 v9, -0x1

    if-ne v8, v9, :cond_6

    .line 1536
    aput-object v1, v2, v4

    goto :goto_4

    .line 1535
    :cond_6
    new-instance v9, Ljava/lang/Integer;

    invoke-direct {v9, v8}, Ljava/lang/Integer;-><init>(I)V

    invoke-virtual {v6, v9}, Ljava/util/Vector;->addElement(Ljava/lang/Object;)V

    goto :goto_5

    .line 1544
    :cond_7
    invoke-virtual {v6, v3}, Ljava/util/Vector;->elementAt(I)Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Ljava/lang/Integer;

    invoke-virtual {v0}, Ljava/lang/Integer;->intValue()I

    move-result v0

    aput v0, v1, v3

    .line 1543
    add-int/lit8 v0, v3, 0x1

    move v3, v0

    goto :goto_3
.end method

.method private parseQuota(Lcom/sun/mail/iap/Response;)Ljavax/mail/Quota;
    .locals 8
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Lcom/sun/mail/iap/ParsingException;
        }
    .end annotation

    .prologue
    .line 1762
    invoke-virtual {p1}, Lcom/sun/mail/iap/Response;->readAtomString()Ljava/lang/String;

    move-result-object v0

    .line 1763
    new-instance v6, Ljavax/mail/Quota;

    invoke-direct {v6, v0}, Ljavax/mail/Quota;-><init>(Ljava/lang/String;)V

    .line 1764
    invoke-virtual {p1}, Lcom/sun/mail/iap/Response;->skipSpaces()V

    .line 1766
    invoke-virtual {p1}, Lcom/sun/mail/iap/Response;->readByte()B

    move-result v0

    const/16 v1, 0x28

    if-eq v0, v1, :cond_0

    .line 1767
    new-instance v0, Lcom/sun/mail/iap/ParsingException;

    const-string v1, "parse error in QUOTA"

    invoke-direct {v0, v1}, Lcom/sun/mail/iap/ParsingException;-><init>(Ljava/lang/String;)V

    throw v0

    .line 1769
    :cond_0
    new-instance v7, Ljava/util/Vector;

    invoke-direct {v7}, Ljava/util/Vector;-><init>()V

    .line 1770
    :cond_1
    :goto_0
    invoke-virtual {p1}, Lcom/sun/mail/iap/Response;->peekByte()B

    move-result v0

    const/16 v1, 0x29

    if-ne v0, v1, :cond_2

    .line 1780
    invoke-virtual {p1}, Lcom/sun/mail/iap/Response;->readByte()B

    .line 1781
    invoke-virtual {v7}, Ljava/util/Vector;->size()I

    move-result v0

    new-array v0, v0, [Ljavax/mail/Quota$Resource;

    iput-object v0, v6, Ljavax/mail/Quota;->resources:[Ljavax/mail/Quota$Resource;

    .line 1782
    iget-object v0, v6, Ljavax/mail/Quota;->resources:[Ljavax/mail/Quota$Resource;

    invoke-virtual {v7, v0}, Ljava/util/Vector;->copyInto([Ljava/lang/Object;)V

    .line 1783
    return-object v6

    .line 1772
    :cond_2
    invoke-virtual {p1}, Lcom/sun/mail/iap/Response;->readAtom()Ljava/lang/String;

    move-result-object v1

    .line 1773
    if-eqz v1, :cond_1

    .line 1774
    invoke-virtual {p1}, Lcom/sun/mail/iap/Response;->readLong()J

    move-result-wide v2

    .line 1775
    invoke-virtual {p1}, Lcom/sun/mail/iap/Response;->readLong()J

    move-result-wide v4

    .line 1776
    new-instance v0, Ljavax/mail/Quota$Resource;

    invoke-direct/range {v0 .. v5}, Ljavax/mail/Quota$Resource;-><init>(Ljava/lang/String;JJ)V

    .line 1777
    invoke-virtual {v7, v0}, Ljava/util/Vector;->addElement(Ljava/lang/Object;)V

    goto :goto_0
.end method

.method private search(Ljava/lang/String;Ljavax/mail/search/SearchTerm;)[I
    .locals 3
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Lcom/sun/mail/iap/ProtocolException;,
            Ljavax/mail/search/SearchException;
        }
    .end annotation

    .prologue
    const/4 v2, 0x0

    .line 1455
    invoke-static {p2}, Lcom/sun/mail/imap/protocol/SearchSequence;->isAscii(Ljavax/mail/search/SearchTerm;)Z

    move-result v0

    if-eqz v0, :cond_0

    .line 1457
    const/4 v0, 0x0

    :try_start_0
    invoke-direct {p0, p1, p2, v0}, Lcom/sun/mail/imap/protocol/IMAPProtocol;->issueSearch(Ljava/lang/String;Ljavax/mail/search/SearchTerm;Ljava/lang/String;)[I
    :try_end_0
    .catch Ljava/io/IOException; {:try_start_0 .. :try_end_0} :catch_0

    move-result-object v0

    .line 1474
    :goto_0
    return-object v0

    .line 1458
    :catch_0
    move-exception v0

    .line 1469
    :cond_0
    const/4 v0, 0x0

    :goto_1
    iget-object v1, p0, Lcom/sun/mail/imap/protocol/IMAPProtocol;->searchCharsets:[Ljava/lang/String;

    array-length v1, v1

    if-lt v0, v1, :cond_1

    .line 1494
    new-instance v0, Ljavax/mail/search/SearchException;

    const-string v1, "Search failed"

    invoke-direct {v0, v1}, Ljavax/mail/search/SearchException;-><init>(Ljava/lang/String;)V

    throw v0

    .line 1470
    :cond_1
    iget-object v1, p0, Lcom/sun/mail/imap/protocol/IMAPProtocol;->searchCharsets:[Ljava/lang/String;

    aget-object v1, v1, v0

    if-nez v1, :cond_2

    .line 1469
    :goto_2
    add-int/lit8 v0, v0, 0x1

    goto :goto_1

    .line 1474
    :cond_2
    :try_start_1
    iget-object v1, p0, Lcom/sun/mail/imap/protocol/IMAPProtocol;->searchCharsets:[Ljava/lang/String;

    aget-object v1, v1, v0

    invoke-direct {p0, p1, p2, v1}, Lcom/sun/mail/imap/protocol/IMAPProtocol;->issueSearch(Ljava/lang/String;Ljavax/mail/search/SearchTerm;Ljava/lang/String;)[I
    :try_end_1
    .catch Lcom/sun/mail/iap/CommandFailedException; {:try_start_1 .. :try_end_1} :catch_1
    .catch Ljava/io/IOException; {:try_start_1 .. :try_end_1} :catch_4
    .catch Lcom/sun/mail/iap/ProtocolException; {:try_start_1 .. :try_end_1} :catch_2
    .catch Ljavax/mail/search/SearchException; {:try_start_1 .. :try_end_1} :catch_3

    move-result-object v0

    goto :goto_0

    .line 1475
    :catch_1
    move-exception v1

    .line 1481
    iget-object v1, p0, Lcom/sun/mail/imap/protocol/IMAPProtocol;->searchCharsets:[Ljava/lang/String;

    aput-object v2, v1, v0

    goto :goto_2

    .line 1486
    :catch_2
    move-exception v0

    .line 1487
    throw v0

    .line 1488
    :catch_3
    move-exception v0

    .line 1489
    throw v0

    .line 1483
    :catch_4
    move-exception v1

    goto :goto_2
.end method

.method private storeFlags(Ljava/lang/String;Ljavax/mail/Flags;Z)V
    .locals 3
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Lcom/sun/mail/iap/ProtocolException;
        }
    .end annotation

    .prologue
    const/4 v2, 0x0

    .line 1363
    if-eqz p3, :cond_0

    .line 1364
    new-instance v0, Ljava/lang/StringBuilder;

    const-string v1, "STORE "

    invoke-direct {v0, v1}, Ljava/lang/StringBuilder;-><init>(Ljava/lang/String;)V

    invoke-virtual {v0, p1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    const-string v1, " +FLAGS "

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    .line 1365
    invoke-direct {p0, p2}, Lcom/sun/mail/imap/protocol/IMAPProtocol;->createFlagList(Ljavax/mail/Flags;)Ljava/lang/String;

    move-result-object v1

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-virtual {v0}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v0

    .line 1364
    invoke-virtual {p0, v0, v2}, Lcom/sun/mail/imap/protocol/IMAPProtocol;->command(Ljava/lang/String;Lcom/sun/mail/iap/Argument;)[Lcom/sun/mail/iap/Response;

    move-result-object v0

    .line 1371
    :goto_0
    invoke-virtual {p0, v0}, Lcom/sun/mail/imap/protocol/IMAPProtocol;->notifyResponseHandlers([Lcom/sun/mail/iap/Response;)V

    .line 1372
    array-length v1, v0

    add-int/lit8 v1, v1, -0x1

    aget-object v0, v0, v1

    invoke-virtual {p0, v0}, Lcom/sun/mail/imap/protocol/IMAPProtocol;->handleResult(Lcom/sun/mail/iap/Response;)V

    .line 1373
    return-void

    .line 1367
    :cond_0
    new-instance v0, Ljava/lang/StringBuilder;

    const-string v1, "STORE "

    invoke-direct {v0, v1}, Ljava/lang/StringBuilder;-><init>(Ljava/lang/String;)V

    invoke-virtual {v0, p1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    const-string v1, " -FLAGS "

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    .line 1368
    invoke-direct {p0, p2}, Lcom/sun/mail/imap/protocol/IMAPProtocol;->createFlagList(Ljavax/mail/Flags;)Ljava/lang/String;

    move-result-object v1

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-virtual {v0}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v0

    .line 1367
    invoke-virtual {p0, v0, v2}, Lcom/sun/mail/imap/protocol/IMAPProtocol;->command(Ljava/lang/String;Lcom/sun/mail/iap/Argument;)[Lcom/sun/mail/iap/Response;

    move-result-object v0

    goto :goto_0
.end method


# virtual methods
.method public append(Ljava/lang/String;Ljavax/mail/Flags;Ljava/util/Date;Lcom/sun/mail/iap/Literal;)V
    .locals 6
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Lcom/sun/mail/iap/ProtocolException;
        }
    .end annotation

    .prologue
    .line 880
    const/4 v5, 0x0

    move-object v0, p0

    move-object v1, p1

    move-object v2, p2

    move-object v3, p3

    move-object v4, p4

    invoke-virtual/range {v0 .. v5}, Lcom/sun/mail/imap/protocol/IMAPProtocol;->appenduid(Ljava/lang/String;Ljavax/mail/Flags;Ljava/util/Date;Lcom/sun/mail/iap/Literal;Z)Lcom/sun/mail/imap/AppendUID;

    .line 881
    return-void
.end method

.method public appenduid(Ljava/lang/String;Ljavax/mail/Flags;Ljava/util/Date;Lcom/sun/mail/iap/Literal;)Lcom/sun/mail/imap/AppendUID;
    .locals 6
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Lcom/sun/mail/iap/ProtocolException;
        }
    .end annotation

    .prologue
    .line 890
    const/4 v5, 0x1

    move-object v0, p0

    move-object v1, p1

    move-object v2, p2

    move-object v3, p3

    move-object v4, p4

    invoke-virtual/range {v0 .. v5}, Lcom/sun/mail/imap/protocol/IMAPProtocol;->appenduid(Ljava/lang/String;Ljavax/mail/Flags;Ljava/util/Date;Lcom/sun/mail/iap/Literal;Z)Lcom/sun/mail/imap/AppendUID;

    move-result-object v0

    return-object v0
.end method

.method public appenduid(Ljava/lang/String;Ljavax/mail/Flags;Ljava/util/Date;Lcom/sun/mail/iap/Literal;Z)Lcom/sun/mail/imap/AppendUID;
    .locals 3
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Lcom/sun/mail/iap/ProtocolException;
        }
    .end annotation

    .prologue
    .line 896
    invoke-static {p1}, Lcom/sun/mail/imap/protocol/BASE64MailboxEncoder;->encode(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v0

    .line 898
    new-instance v1, Lcom/sun/mail/iap/Argument;

    invoke-direct {v1}, Lcom/sun/mail/iap/Argument;-><init>()V

    .line 899
    invoke-virtual {v1, v0}, Lcom/sun/mail/iap/Argument;->writeString(Ljava/lang/String;)V

    .line 901
    if-eqz p2, :cond_1

    .line 903
    sget-object v0, Ljavax/mail/Flags$Flag;->RECENT:Ljavax/mail/Flags$Flag;

    invoke-virtual {p2, v0}, Ljavax/mail/Flags;->contains(Ljavax/mail/Flags$Flag;)Z

    move-result v0

    if-eqz v0, :cond_0

    .line 904
    new-instance v0, Ljavax/mail/Flags;

    invoke-direct {v0, p2}, Ljavax/mail/Flags;-><init>(Ljavax/mail/Flags;)V

    .line 905
    sget-object v2, Ljavax/mail/Flags$Flag;->RECENT:Ljavax/mail/Flags$Flag;

    invoke-virtual {v0, v2}, Ljavax/mail/Flags;->remove(Ljavax/mail/Flags$Flag;)V

    move-object p2, v0

    .line 918
    :cond_0
    invoke-direct {p0, p2}, Lcom/sun/mail/imap/protocol/IMAPProtocol;->createFlagList(Ljavax/mail/Flags;)Ljava/lang/String;

    move-result-object v0

    invoke-virtual {v1, v0}, Lcom/sun/mail/iap/Argument;->writeAtom(Ljava/lang/String;)V

    .line 920
    :cond_1
    if-eqz p3, :cond_2

    .line 921
    invoke-static {p3}, Lcom/sun/mail/imap/protocol/INTERNALDATE;->format(Ljava/util/Date;)Ljava/lang/String;

    move-result-object v0

    invoke-virtual {v1, v0}, Lcom/sun/mail/iap/Argument;->writeString(Ljava/lang/String;)V

    .line 923
    :cond_2
    invoke-virtual {v1, p4}, Lcom/sun/mail/iap/Argument;->writeBytes(Lcom/sun/mail/iap/Literal;)V

    .line 925
    const-string v0, "APPEND"

    invoke-virtual {p0, v0, v1}, Lcom/sun/mail/imap/protocol/IMAPProtocol;->command(Ljava/lang/String;Lcom/sun/mail/iap/Argument;)[Lcom/sun/mail/iap/Response;

    move-result-object v0

    .line 928
    invoke-virtual {p0, v0}, Lcom/sun/mail/imap/protocol/IMAPProtocol;->notifyResponseHandlers([Lcom/sun/mail/iap/Response;)V

    .line 931
    array-length v1, v0

    add-int/lit8 v1, v1, -0x1

    aget-object v1, v0, v1

    invoke-virtual {p0, v1}, Lcom/sun/mail/imap/protocol/IMAPProtocol;->handleResult(Lcom/sun/mail/iap/Response;)V

    .line 933
    if-eqz p5, :cond_3

    .line 934
    array-length v1, v0

    add-int/lit8 v1, v1, -0x1

    aget-object v0, v0, v1

    invoke-direct {p0, v0}, Lcom/sun/mail/imap/protocol/IMAPProtocol;->getAppendUID(Lcom/sun/mail/iap/Response;)Lcom/sun/mail/imap/AppendUID;

    move-result-object v0

    .line 936
    :goto_0
    return-object v0

    :cond_3
    const/4 v0, 0x0

    goto :goto_0
.end method

.method public declared-synchronized authlogin(Ljava/lang/String;Ljava/lang/String;)V
    .locals 11
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Lcom/sun/mail/iap/ProtocolException;
        }
    .end annotation

    .prologue
    const/4 v2, 0x0

    const/4 v1, 0x0

    const/4 v3, 0x1

    .line 350
    monitor-enter p0

    :try_start_0
    new-instance v7, Ljava/util/Vector;

    invoke-direct {v7}, Ljava/util/Vector;-><init>()V
    :try_end_0
    .catchall {:try_start_0 .. :try_end_0} :catchall_0

    .line 356
    :try_start_1
    const-string v0, "AUTHENTICATE LOGIN"

    const/4 v4, 0x0

    invoke-virtual {p0, v0, v4}, Lcom/sun/mail/imap/protocol/IMAPProtocol;->writeCommand(Ljava/lang/String;Lcom/sun/mail/iap/Argument;)Ljava/lang/String;
    :try_end_1
    .catch Ljava/lang/Exception; {:try_start_1 .. :try_end_1} :catch_0
    .catchall {:try_start_1 .. :try_end_1} :catchall_0

    move-result-object v0

    move-object v6, v0

    move v0, v2

    .line 363
    :goto_0
    :try_start_2
    invoke-virtual {p0}, Lcom/sun/mail/imap/protocol/IMAPProtocol;->getOutputStream()Ljava/io/OutputStream;

    move-result-object v8

    .line 381
    new-instance v9, Ljava/io/ByteArrayOutputStream;

    invoke-direct {v9}, Ljava/io/ByteArrayOutputStream;-><init>()V

    .line 382
    new-instance v10, Lcom/sun/mail/util/BASE64EncoderStream;

    const v4, 0x7fffffff

    invoke-direct {v10, v9, v4}, Lcom/sun/mail/util/BASE64EncoderStream;-><init>(Ljava/io/OutputStream;I)V

    move v4, v0

    move-object v0, v1

    move v1, v3

    .line 385
    :goto_1
    if-eqz v4, :cond_0

    .line 425
    invoke-virtual {v7}, Ljava/util/Vector;->size()I

    move-result v1

    new-array v1, v1, [Lcom/sun/mail/iap/Response;

    .line 426
    invoke-virtual {v7, v1}, Ljava/util/Vector;->copyInto([Ljava/lang/Object;)V

    .line 427
    invoke-virtual {p0, v1}, Lcom/sun/mail/imap/protocol/IMAPProtocol;->notifyResponseHandlers([Lcom/sun/mail/iap/Response;)V

    .line 430
    invoke-virtual {p0, v0}, Lcom/sun/mail/imap/protocol/IMAPProtocol;->handleResult(Lcom/sun/mail/iap/Response;)V

    .line 432
    invoke-virtual {p0, v0}, Lcom/sun/mail/imap/protocol/IMAPProtocol;->setCapabilities(Lcom/sun/mail/iap/Response;)V

    .line 434
    const/4 v0, 0x1

    iput-boolean v0, p0, Lcom/sun/mail/imap/protocol/IMAPProtocol;->authenticated:Z
    :try_end_2
    .catchall {:try_start_2 .. :try_end_2} :catchall_0

    .line 435
    monitor-exit p0

    return-void

    .line 357
    :catch_0
    move-exception v0

    .line 359
    :try_start_3
    invoke-static {v0}, Lcom/sun/mail/iap/Response;->byeResponse(Ljava/lang/Exception;)Lcom/sun/mail/iap/Response;
    :try_end_3
    .catchall {:try_start_3 .. :try_end_3} :catchall_0

    move-result-object v0

    move-object v6, v1

    move-object v1, v0

    move v0, v3

    .line 360
    goto :goto_0

    .line 387
    :cond_0
    :try_start_4
    invoke-virtual {p0}, Lcom/sun/mail/imap/protocol/IMAPProtocol;->readResponse()Lcom/sun/mail/iap/Response;

    move-result-object v5

    .line 388
    invoke-virtual {v5}, Lcom/sun/mail/iap/Response;->isContinuation()Z

    move-result v0

    if-eqz v0, :cond_2

    .line 391
    if-eqz v1, :cond_1

    move-object v0, p1

    move v1, v2

    .line 398
    :goto_2
    invoke-static {v0}, Lcom/sun/mail/util/ASCIIUtility;->getBytes(Ljava/lang/String;)[B

    move-result-object v0

    invoke-virtual {v10, v0}, Ljava/io/OutputStream;->write([B)V

    .line 399
    invoke-virtual {v10}, Ljava/io/OutputStream;->flush()V

    .line 401
    sget-object v0, Lcom/sun/mail/imap/protocol/IMAPProtocol;->CRLF:[B

    invoke-virtual {v9, v0}, Ljava/io/ByteArrayOutputStream;->write([B)V

    .line 402
    invoke-virtual {v9}, Ljava/io/ByteArrayOutputStream;->toByteArray()[B

    move-result-object v0

    invoke-virtual {v8, v0}, Ljava/io/OutputStream;->write([B)V

    .line 403
    invoke-virtual {v8}, Ljava/io/OutputStream;->flush()V

    .line 404
    invoke-virtual {v9}, Ljava/io/ByteArrayOutputStream;->reset()V

    move-object v0, v5

    goto :goto_1

    :cond_1
    move-object v0, p2

    .line 395
    goto :goto_2

    .line 405
    :cond_2
    invoke-virtual {v5}, Lcom/sun/mail/iap/Response;->isTagged()Z

    move-result v0

    if-eqz v0, :cond_3

    invoke-virtual {v5}, Lcom/sun/mail/iap/Response;->getTag()Ljava/lang/String;

    move-result-object v0

    invoke-virtual {v0, v6}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v0

    if-eqz v0, :cond_3

    move v4, v3

    move-object v0, v5

    .line 407
    goto :goto_1

    .line 408
    :cond_3
    invoke-virtual {v5}, Lcom/sun/mail/iap/Response;->isBYE()Z

    move-result v0

    if-eqz v0, :cond_4

    move v4, v3

    move-object v0, v5

    .line 409
    goto :goto_1

    .line 411
    :cond_4
    invoke-virtual {v7, v5}, Ljava/util/Vector;->addElement(Ljava/lang/Object;)V
    :try_end_4
    .catch Ljava/lang/Exception; {:try_start_4 .. :try_end_4} :catch_1
    .catchall {:try_start_4 .. :try_end_4} :catchall_0

    move-object v0, v5

    goto :goto_1

    .line 412
    :catch_1
    move-exception v0

    .line 414
    :try_start_5
    invoke-static {v0}, Lcom/sun/mail/iap/Response;->byeResponse(Ljava/lang/Exception;)Lcom/sun/mail/iap/Response;
    :try_end_5
    .catchall {:try_start_5 .. :try_end_5} :catchall_0

    move-result-object v0

    move v4, v3

    .line 415
    goto :goto_1

    .line 350
    :catchall_0
    move-exception v0

    monitor-exit p0

    throw v0
.end method

.method public declared-synchronized authplain(Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;)V
    .locals 10
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Lcom/sun/mail/iap/ProtocolException;
        }
    .end annotation

    .prologue
    const/4 v2, 0x0

    const/4 v1, 0x1

    .line 452
    monitor-enter p0

    :try_start_0
    new-instance v4, Ljava/util/Vector;

    invoke-direct {v4}, Ljava/util/Vector;-><init>()V
    :try_end_0
    .catchall {:try_start_0 .. :try_end_0} :catchall_0

    .line 455
    const/4 v0, 0x0

    .line 458
    :try_start_1
    const-string v3, "AUTHENTICATE PLAIN"

    const/4 v5, 0x0

    invoke-virtual {p0, v3, v5}, Lcom/sun/mail/imap/protocol/IMAPProtocol;->writeCommand(Ljava/lang/String;Lcom/sun/mail/iap/Argument;)Ljava/lang/String;
    :try_end_1
    .catch Ljava/lang/Exception; {:try_start_1 .. :try_end_1} :catch_0
    .catchall {:try_start_1 .. :try_end_1} :catchall_0

    move-result-object v3

    .line 465
    :goto_0
    :try_start_2
    invoke-virtual {p0}, Lcom/sun/mail/imap/protocol/IMAPProtocol;->getOutputStream()Ljava/io/OutputStream;

    move-result-object v5

    .line 483
    new-instance v6, Ljava/io/ByteArrayOutputStream;

    invoke-direct {v6}, Ljava/io/ByteArrayOutputStream;-><init>()V

    .line 484
    new-instance v7, Lcom/sun/mail/util/BASE64EncoderStream;

    const v8, 0x7fffffff

    invoke-direct {v7, v6, v8}, Lcom/sun/mail/util/BASE64EncoderStream;-><init>(Ljava/io/OutputStream;I)V

    .line 486
    :goto_1
    if-eqz v0, :cond_0

    .line 522
    invoke-virtual {v4}, Ljava/util/Vector;->size()I

    move-result v0

    new-array v0, v0, [Lcom/sun/mail/iap/Response;

    .line 523
    invoke-virtual {v4, v0}, Ljava/util/Vector;->copyInto([Ljava/lang/Object;)V

    .line 524
    invoke-virtual {p0, v0}, Lcom/sun/mail/imap/protocol/IMAPProtocol;->notifyResponseHandlers([Lcom/sun/mail/iap/Response;)V

    .line 527
    invoke-virtual {p0, v2}, Lcom/sun/mail/imap/protocol/IMAPProtocol;->handleResult(Lcom/sun/mail/iap/Response;)V

    .line 529
    invoke-virtual {p0, v2}, Lcom/sun/mail/imap/protocol/IMAPProtocol;->setCapabilities(Lcom/sun/mail/iap/Response;)V

    .line 531
    const/4 v0, 0x1

    iput-boolean v0, p0, Lcom/sun/mail/imap/protocol/IMAPProtocol;->authenticated:Z
    :try_end_2
    .catchall {:try_start_2 .. :try_end_2} :catchall_0

    .line 532
    monitor-exit p0

    return-void

    .line 459
    :catch_0
    move-exception v0

    .line 461
    :try_start_3
    invoke-static {v0}, Lcom/sun/mail/iap/Response;->byeResponse(Ljava/lang/Exception;)Lcom/sun/mail/iap/Response;
    :try_end_3
    .catchall {:try_start_3 .. :try_end_3} :catchall_0

    move-result-object v0

    move-object v3, v2

    move-object v2, v0

    move v0, v1

    .line 462
    goto :goto_0

    .line 488
    :cond_0
    :try_start_4
    invoke-virtual {p0}, Lcom/sun/mail/imap/protocol/IMAPProtocol;->readResponse()Lcom/sun/mail/iap/Response;

    move-result-object v2

    .line 489
    invoke-virtual {v2}, Lcom/sun/mail/iap/Response;->isContinuation()Z

    move-result v8

    if-eqz v8, :cond_1

    .line 491
    const-string v8, "\u0000"

    .line 492
    new-instance v8, Ljava/lang/StringBuilder;

    invoke-static {p1}, Ljava/lang/String;->valueOf(Ljava/lang/Object;)Ljava/lang/String;

    move-result-object v9

    invoke-direct {v8, v9}, Ljava/lang/StringBuilder;-><init>(Ljava/lang/String;)V

    const-string v9, "\u0000"

    invoke-virtual {v8, v9}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v8

    invoke-virtual {v8, p2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v8

    const-string v9, "\u0000"

    invoke-virtual {v8, v9}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v8

    invoke-virtual {v8, p3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v8

    invoke-virtual {v8}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v8

    .line 495
    invoke-static {v8}, Lcom/sun/mail/util/ASCIIUtility;->getBytes(Ljava/lang/String;)[B

    move-result-object v8

    invoke-virtual {v7, v8}, Ljava/io/OutputStream;->write([B)V

    .line 496
    invoke-virtual {v7}, Ljava/io/OutputStream;->flush()V

    .line 498
    sget-object v8, Lcom/sun/mail/imap/protocol/IMAPProtocol;->CRLF:[B

    invoke-virtual {v6, v8}, Ljava/io/ByteArrayOutputStream;->write([B)V

    .line 499
    invoke-virtual {v6}, Ljava/io/ByteArrayOutputStream;->toByteArray()[B

    move-result-object v8

    invoke-virtual {v5, v8}, Ljava/io/OutputStream;->write([B)V

    .line 500
    invoke-virtual {v5}, Ljava/io/OutputStream;->flush()V

    .line 501
    invoke-virtual {v6}, Ljava/io/ByteArrayOutputStream;->reset()V
    :try_end_4
    .catch Ljava/lang/Exception; {:try_start_4 .. :try_end_4} :catch_1
    .catchall {:try_start_4 .. :try_end_4} :catchall_0

    goto :goto_1

    .line 509
    :catch_1
    move-exception v0

    .line 511
    :try_start_5
    invoke-static {v0}, Lcom/sun/mail/iap/Response;->byeResponse(Ljava/lang/Exception;)Lcom/sun/mail/iap/Response;
    :try_end_5
    .catchall {:try_start_5 .. :try_end_5} :catchall_0

    move-result-object v0

    move-object v2, v0

    move v0, v1

    .line 512
    goto :goto_1

    .line 502
    :cond_1
    :try_start_6
    invoke-virtual {v2}, Lcom/sun/mail/iap/Response;->isTagged()Z

    move-result v8

    if-eqz v8, :cond_2

    invoke-virtual {v2}, Lcom/sun/mail/iap/Response;->getTag()Ljava/lang/String;

    move-result-object v8

    invoke-virtual {v8, v3}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v8

    if-eqz v8, :cond_2

    move v0, v1

    .line 504
    goto/16 :goto_1

    .line 505
    :cond_2
    invoke-virtual {v2}, Lcom/sun/mail/iap/Response;->isBYE()Z

    move-result v8

    if-eqz v8, :cond_3

    move v0, v1

    .line 506
    goto/16 :goto_1

    .line 508
    :cond_3
    invoke-virtual {v4, v2}, Ljava/util/Vector;->addElement(Ljava/lang/Object;)V
    :try_end_6
    .catch Ljava/lang/Exception; {:try_start_6 .. :try_end_6} :catch_1
    .catchall {:try_start_6 .. :try_end_6} :catchall_0

    goto/16 :goto_1

    .line 452
    :catchall_0
    move-exception v0

    monitor-exit p0

    throw v0
.end method

.method public capability()V
    .locals 5
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Lcom/sun/mail/iap/ProtocolException;
        }
    .end annotation

    .prologue
    .line 141
    const-string v0, "CAPABILITY"

    const/4 v1, 0x0

    invoke-virtual {p0, v0, v1}, Lcom/sun/mail/imap/protocol/IMAPProtocol;->command(Ljava/lang/String;Lcom/sun/mail/iap/Argument;)[Lcom/sun/mail/iap/Response;

    move-result-object v2

    .line 143
    array-length v0, v2

    add-int/lit8 v0, v0, -0x1

    aget-object v0, v2, v0

    invoke-virtual {v0}, Lcom/sun/mail/iap/Response;->isOK()Z

    move-result v0

    if-nez v0, :cond_0

    .line 144
    new-instance v0, Lcom/sun/mail/iap/ProtocolException;

    array-length v1, v2

    add-int/lit8 v1, v1, -0x1

    aget-object v1, v2, v1

    invoke-virtual {v1}, Lcom/sun/mail/iap/Response;->toString()Ljava/lang/String;

    move-result-object v1

    invoke-direct {v0, v1}, Lcom/sun/mail/iap/ProtocolException;-><init>(Ljava/lang/String;)V

    throw v0

    .line 146
    :cond_0
    new-instance v0, Ljava/util/HashMap;

    const/16 v1, 0xa

    invoke-direct {v0, v1}, Ljava/util/HashMap;-><init>(I)V

    iput-object v0, p0, Lcom/sun/mail/imap/protocol/IMAPProtocol;->capabilities:Ljava/util/Map;

    .line 147
    new-instance v0, Ljava/util/ArrayList;

    const/4 v1, 0x5

    invoke-direct {v0, v1}, Ljava/util/ArrayList;-><init>(I)V

    iput-object v0, p0, Lcom/sun/mail/imap/protocol/IMAPProtocol;->authmechs:Ljava/util/List;

    .line 148
    const/4 v0, 0x0

    array-length v3, v2

    move v1, v0

    :goto_0
    if-lt v1, v3, :cond_1

    .line 161
    return-void

    .line 149
    :cond_1
    aget-object v0, v2, v1

    instance-of v0, v0, Lcom/sun/mail/imap/protocol/IMAPResponse;

    if-nez v0, :cond_3

    .line 148
    :cond_2
    :goto_1
    add-int/lit8 v0, v1, 0x1

    move v1, v0

    goto :goto_0

    .line 152
    :cond_3
    aget-object v0, v2, v1

    check-cast v0, Lcom/sun/mail/imap/protocol/IMAPResponse;

    .line 158
    const-string v4, "CAPABILITY"

    invoke-virtual {v0, v4}, Lcom/sun/mail/imap/protocol/IMAPResponse;->keyEquals(Ljava/lang/String;)Z

    move-result v4

    if-eqz v4, :cond_2

    .line 159
    invoke-virtual {p0, v0}, Lcom/sun/mail/imap/protocol/IMAPProtocol;->parseCapabilities(Lcom/sun/mail/iap/Response;)V

    goto :goto_1
.end method

.method public check()V
    .locals 2
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Lcom/sun/mail/iap/ProtocolException;
        }
    .end annotation

    .prologue
    .line 967
    const-string v0, "CHECK"

    const/4 v1, 0x0

    invoke-virtual {p0, v0, v1}, Lcom/sun/mail/imap/protocol/IMAPProtocol;->simpleCommand(Ljava/lang/String;Lcom/sun/mail/iap/Argument;)V

    .line 968
    return-void
.end method

.method public close()V
    .locals 2
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Lcom/sun/mail/iap/ProtocolException;
        }
    .end annotation

    .prologue
    .line 976
    const-string v0, "CLOSE"

    const/4 v1, 0x0

    invoke-virtual {p0, v0, v1}, Lcom/sun/mail/imap/protocol/IMAPProtocol;->simpleCommand(Ljava/lang/String;Lcom/sun/mail/iap/Argument;)V

    .line 977
    return-void
.end method

.method public copy(IILjava/lang/String;)V
    .locals 2
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Lcom/sun/mail/iap/ProtocolException;
        }
    .end annotation

    .prologue
    .line 1325
    new-instance v0, Ljava/lang/StringBuilder;

    invoke-static {p1}, Ljava/lang/String;->valueOf(I)Ljava/lang/String;

    move-result-object v1

    invoke-static {v1}, Ljava/lang/String;->valueOf(Ljava/lang/Object;)Ljava/lang/String;

    move-result-object v1

    invoke-direct {v0, v1}, Ljava/lang/StringBuilder;-><init>(Ljava/lang/String;)V

    const-string v1, ":"

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-static {p2}, Ljava/lang/String;->valueOf(I)Ljava/lang/String;

    move-result-object v1

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-virtual {v0}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v0

    invoke-direct {p0, v0, p3}, Lcom/sun/mail/imap/protocol/IMAPProtocol;->copy(Ljava/lang/String;Ljava/lang/String;)V

    .line 1327
    return-void
.end method

.method public copy([Lcom/sun/mail/imap/protocol/MessageSet;Ljava/lang/String;)V
    .locals 1
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Lcom/sun/mail/iap/ProtocolException;
        }
    .end annotation

    .prologue
    .line 1320
    invoke-static {p1}, Lcom/sun/mail/imap/protocol/MessageSet;->toString([Lcom/sun/mail/imap/protocol/MessageSet;)Ljava/lang/String;

    move-result-object v0

    invoke-direct {p0, v0, p2}, Lcom/sun/mail/imap/protocol/IMAPProtocol;->copy(Ljava/lang/String;Ljava/lang/String;)V

    .line 1321
    return-void
.end method

.method public create(Ljava/lang/String;)V
    .locals 2
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Lcom/sun/mail/iap/ProtocolException;
        }
    .end annotation

    .prologue
    .line 746
    invoke-static {p1}, Lcom/sun/mail/imap/protocol/BASE64MailboxEncoder;->encode(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v0

    .line 748
    new-instance v1, Lcom/sun/mail/iap/Argument;

    invoke-direct {v1}, Lcom/sun/mail/iap/Argument;-><init>()V

    .line 749
    invoke-virtual {v1, v0}, Lcom/sun/mail/iap/Argument;->writeString(Ljava/lang/String;)V

    .line 751
    const-string v0, "CREATE"

    invoke-virtual {p0, v0, v1}, Lcom/sun/mail/imap/protocol/IMAPProtocol;->simpleCommand(Ljava/lang/String;Lcom/sun/mail/iap/Argument;)V

    .line 752
    return-void
.end method

.method public delete(Ljava/lang/String;)V
    .locals 2
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Lcom/sun/mail/iap/ProtocolException;
        }
    .end annotation

    .prologue
    .line 761
    invoke-static {p1}, Lcom/sun/mail/imap/protocol/BASE64MailboxEncoder;->encode(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v0

    .line 763
    new-instance v1, Lcom/sun/mail/iap/Argument;

    invoke-direct {v1}, Lcom/sun/mail/iap/Argument;-><init>()V

    .line 764
    invoke-virtual {v1, v0}, Lcom/sun/mail/iap/Argument;->writeString(Ljava/lang/String;)V

    .line 766
    const-string v0, "DELETE"

    invoke-virtual {p0, v0, v1}, Lcom/sun/mail/imap/protocol/IMAPProtocol;->simpleCommand(Ljava/lang/String;Lcom/sun/mail/iap/Argument;)V

    .line 767
    return-void
.end method

.method public deleteACL(Ljava/lang/String;Ljava/lang/String;)V
    .locals 2
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Lcom/sun/mail/iap/ProtocolException;
        }
    .end annotation

    .prologue
    .line 1822
    const-string v0, "ACL"

    invoke-virtual {p0, v0}, Lcom/sun/mail/imap/protocol/IMAPProtocol;->hasCapability(Ljava/lang/String;)Z

    move-result v0

    if-nez v0, :cond_0

    .line 1823
    new-instance v0, Lcom/sun/mail/iap/BadCommandException;

    const-string v1, "ACL not supported"

    invoke-direct {v0, v1}, Lcom/sun/mail/iap/BadCommandException;-><init>(Ljava/lang/String;)V

    throw v0

    .line 1826
    :cond_0
    invoke-static {p1}, Lcom/sun/mail/imap/protocol/BASE64MailboxEncoder;->encode(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v0

    .line 1828
    new-instance v1, Lcom/sun/mail/iap/Argument;

    invoke-direct {v1}, Lcom/sun/mail/iap/Argument;-><init>()V

    .line 1829
    invoke-virtual {v1, v0}, Lcom/sun/mail/iap/Argument;->writeString(Ljava/lang/String;)V

    .line 1830
    invoke-virtual {v1, p2}, Lcom/sun/mail/iap/Argument;->writeString(Ljava/lang/String;)V

    .line 1832
    const-string v0, "DELETEACL"

    invoke-virtual {p0, v0, v1}, Lcom/sun/mail/imap/protocol/IMAPProtocol;->command(Ljava/lang/String;Lcom/sun/mail/iap/Argument;)[Lcom/sun/mail/iap/Response;

    move-result-object v0

    .line 1833
    array-length v1, v0

    add-int/lit8 v1, v1, -0x1

    aget-object v1, v0, v1

    .line 1836
    invoke-virtual {p0, v0}, Lcom/sun/mail/imap/protocol/IMAPProtocol;->notifyResponseHandlers([Lcom/sun/mail/iap/Response;)V

    .line 1837
    invoke-virtual {p0, v1}, Lcom/sun/mail/imap/protocol/IMAPProtocol;->handleResult(Lcom/sun/mail/iap/Response;)V

    .line 1838
    return-void
.end method

.method public disconnect()V
    .locals 1

    .prologue
    .line 289
    invoke-super {p0}, Lcom/sun/mail/iap/Protocol;->disconnect()V

    .line 290
    const/4 v0, 0x0

    iput-boolean v0, p0, Lcom/sun/mail/imap/protocol/IMAPProtocol;->authenticated:Z

    .line 291
    return-void
.end method

.method public examine(Ljava/lang/String;)Lcom/sun/mail/imap/protocol/MailboxInfo;
    .locals 3
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Lcom/sun/mail/iap/ProtocolException;
        }
    .end annotation

    .prologue
    .line 666
    invoke-static {p1}, Lcom/sun/mail/imap/protocol/BASE64MailboxEncoder;->encode(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v0

    .line 668
    new-instance v1, Lcom/sun/mail/iap/Argument;

    invoke-direct {v1}, Lcom/sun/mail/iap/Argument;-><init>()V

    .line 669
    invoke-virtual {v1, v0}, Lcom/sun/mail/iap/Argument;->writeString(Ljava/lang/String;)V

    .line 671
    const-string v0, "EXAMINE"

    invoke-virtual {p0, v0, v1}, Lcom/sun/mail/imap/protocol/IMAPProtocol;->command(Ljava/lang/String;Lcom/sun/mail/iap/Argument;)[Lcom/sun/mail/iap/Response;

    move-result-object v0

    .line 675
    new-instance v1, Lcom/sun/mail/imap/protocol/MailboxInfo;

    invoke-direct {v1, v0}, Lcom/sun/mail/imap/protocol/MailboxInfo;-><init>([Lcom/sun/mail/iap/Response;)V

    .line 676
    const/4 v2, 0x1

    iput v2, v1, Lcom/sun/mail/imap/protocol/MailboxInfo;->mode:I

    .line 679
    invoke-virtual {p0, v0}, Lcom/sun/mail/imap/protocol/IMAPProtocol;->notifyResponseHandlers([Lcom/sun/mail/iap/Response;)V

    .line 681
    array-length v2, v0

    add-int/lit8 v2, v2, -0x1

    aget-object v0, v0, v2

    invoke-virtual {p0, v0}, Lcom/sun/mail/imap/protocol/IMAPProtocol;->handleResult(Lcom/sun/mail/iap/Response;)V

    .line 682
    return-object v1
.end method

.method public expunge()V
    .locals 2
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Lcom/sun/mail/iap/ProtocolException;
        }
    .end annotation

    .prologue
    .line 985
    const-string v0, "EXPUNGE"

    const/4 v1, 0x0

    invoke-virtual {p0, v0, v1}, Lcom/sun/mail/imap/protocol/IMAPProtocol;->simpleCommand(Ljava/lang/String;Lcom/sun/mail/iap/Argument;)V

    .line 986
    return-void
.end method

.method public fetch(IILjava/lang/String;)[Lcom/sun/mail/iap/Response;
    .locals 2
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Lcom/sun/mail/iap/ProtocolException;
        }
    .end annotation

    .prologue
    .line 1298
    new-instance v0, Ljava/lang/StringBuilder;

    invoke-static {p1}, Ljava/lang/String;->valueOf(I)Ljava/lang/String;

    move-result-object v1

    invoke-static {v1}, Ljava/lang/String;->valueOf(Ljava/lang/Object;)Ljava/lang/String;

    move-result-object v1

    invoke-direct {v0, v1}, Ljava/lang/StringBuilder;-><init>(Ljava/lang/String;)V

    const-string v1, ":"

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-static {p2}, Ljava/lang/String;->valueOf(I)Ljava/lang/String;

    move-result-object v1

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-virtual {v0}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v0

    .line 1299
    const/4 v1, 0x0

    .line 1298
    invoke-direct {p0, v0, p3, v1}, Lcom/sun/mail/imap/protocol/IMAPProtocol;->fetch(Ljava/lang/String;Ljava/lang/String;Z)[Lcom/sun/mail/iap/Response;

    move-result-object v0

    return-object v0
.end method

.method public fetch(ILjava/lang/String;)[Lcom/sun/mail/iap/Response;
    .locals 2
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Lcom/sun/mail/iap/ProtocolException;
        }
    .end annotation

    .prologue
    .line 1304
    invoke-static {p1}, Ljava/lang/String;->valueOf(I)Ljava/lang/String;

    move-result-object v0

    const/4 v1, 0x0

    invoke-direct {p0, v0, p2, v1}, Lcom/sun/mail/imap/protocol/IMAPProtocol;->fetch(Ljava/lang/String;Ljava/lang/String;Z)[Lcom/sun/mail/iap/Response;

    move-result-object v0

    return-object v0
.end method

.method public fetch([Lcom/sun/mail/imap/protocol/MessageSet;Ljava/lang/String;)[Lcom/sun/mail/iap/Response;
    .locals 2
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Lcom/sun/mail/iap/ProtocolException;
        }
    .end annotation

    .prologue
    .line 1293
    invoke-static {p1}, Lcom/sun/mail/imap/protocol/MessageSet;->toString([Lcom/sun/mail/imap/protocol/MessageSet;)Ljava/lang/String;

    move-result-object v0

    const/4 v1, 0x0

    invoke-direct {p0, v0, p2, v1}, Lcom/sun/mail/imap/protocol/IMAPProtocol;->fetch(Ljava/lang/String;Ljava/lang/String;Z)[Lcom/sun/mail/iap/Response;

    move-result-object v0

    return-object v0
.end method

.method public fetchBody(ILjava/lang/String;)Lcom/sun/mail/imap/protocol/BODY;
    .locals 1
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Lcom/sun/mail/iap/ProtocolException;
        }
    .end annotation

    .prologue
    .line 1033
    const/4 v0, 0x0

    invoke-virtual {p0, p1, p2, v0}, Lcom/sun/mail/imap/protocol/IMAPProtocol;->fetchBody(ILjava/lang/String;Z)Lcom/sun/mail/imap/protocol/BODY;

    move-result-object v0

    return-object v0
.end method

.method public fetchBody(ILjava/lang/String;II)Lcom/sun/mail/imap/protocol/BODY;
    .locals 7
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Lcom/sun/mail/iap/ProtocolException;
        }
    .end annotation

    .prologue
    .line 1073
    const/4 v5, 0x0

    const/4 v6, 0x0

    move-object v0, p0

    move v1, p1

    move-object v2, p2

    move v3, p3

    move v4, p4

    invoke-virtual/range {v0 .. v6}, Lcom/sun/mail/imap/protocol/IMAPProtocol;->fetchBody(ILjava/lang/String;IIZLcom/sun/mail/iap/ByteArray;)Lcom/sun/mail/imap/protocol/BODY;

    move-result-object v0

    return-object v0
.end method

.method public fetchBody(ILjava/lang/String;IILcom/sun/mail/iap/ByteArray;)Lcom/sun/mail/imap/protocol/BODY;
    .locals 7
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Lcom/sun/mail/iap/ProtocolException;
        }
    .end annotation

    .prologue
    .line 1089
    const/4 v5, 0x0

    move-object v0, p0

    move v1, p1

    move-object v2, p2

    move v3, p3

    move v4, p4

    move-object v6, p5

    invoke-virtual/range {v0 .. v6}, Lcom/sun/mail/imap/protocol/IMAPProtocol;->fetchBody(ILjava/lang/String;IIZLcom/sun/mail/iap/ByteArray;)Lcom/sun/mail/imap/protocol/BODY;

    move-result-object v0

    return-object v0
.end method

.method protected fetchBody(ILjava/lang/String;IIZLcom/sun/mail/iap/ByteArray;)Lcom/sun/mail/imap/protocol/BODY;
    .locals 4
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Lcom/sun/mail/iap/ProtocolException;
        }
    .end annotation

    .prologue
    const/4 v1, 0x0

    .line 1094
    iput-object p6, p0, Lcom/sun/mail/imap/protocol/IMAPProtocol;->ba:Lcom/sun/mail/iap/ByteArray;

    .line 1096
    new-instance v2, Ljava/lang/StringBuilder;

    if-eqz p5, :cond_0

    const-string v0, "BODY.PEEK["

    :goto_0
    invoke-static {v0}, Ljava/lang/String;->valueOf(Ljava/lang/Object;)Ljava/lang/String;

    move-result-object v0

    invoke-direct {v2, v0}, Ljava/lang/StringBuilder;-><init>(Ljava/lang/String;)V

    .line 1097
    if-nez p2, :cond_1

    const-string v0, "]<"

    :goto_1
    invoke-virtual {v2, v0}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    .line 1098
    invoke-static {p3}, Ljava/lang/String;->valueOf(I)Ljava/lang/String;

    move-result-object v2

    invoke-virtual {v0, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    const-string v2, "."

    invoke-virtual {v0, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    .line 1099
    invoke-static {p4}, Ljava/lang/String;->valueOf(I)Ljava/lang/String;

    move-result-object v2

    invoke-virtual {v0, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    const-string v2, ">"

    invoke-virtual {v0, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-virtual {v0}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v0

    .line 1095
    invoke-virtual {p0, p1, v0}, Lcom/sun/mail/imap/protocol/IMAPProtocol;->fetch(ILjava/lang/String;)[Lcom/sun/mail/iap/Response;

    move-result-object v0

    .line 1102
    invoke-virtual {p0, v0}, Lcom/sun/mail/imap/protocol/IMAPProtocol;->notifyResponseHandlers([Lcom/sun/mail/iap/Response;)V

    .line 1104
    array-length v2, v0

    add-int/lit8 v2, v2, -0x1

    aget-object v2, v0, v2

    .line 1105
    invoke-virtual {v2}, Lcom/sun/mail/iap/Response;->isOK()Z

    move-result v3

    if-eqz v3, :cond_2

    .line 1106
    const-class v1, Lcom/sun/mail/imap/protocol/BODY;

    invoke-static {v0, p1, v1}, Lcom/sun/mail/imap/protocol/FetchResponse;->getItem([Lcom/sun/mail/iap/Response;ILjava/lang/Class;)Lcom/sun/mail/imap/protocol/Item;

    move-result-object v0

    check-cast v0, Lcom/sun/mail/imap/protocol/BODY;

    .line 1111
    :goto_2
    return-object v0

    .line 1096
    :cond_0
    const-string v0, "BODY["

    goto :goto_0

    .line 1097
    :cond_1
    new-instance v0, Ljava/lang/StringBuilder;

    invoke-static {p2}, Ljava/lang/String;->valueOf(Ljava/lang/Object;)Ljava/lang/String;

    move-result-object v3

    invoke-direct {v0, v3}, Ljava/lang/StringBuilder;-><init>(Ljava/lang/String;)V

    const-string v3, "]<"

    invoke-virtual {v0, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-virtual {v0}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v0

    goto :goto_1

    .line 1107
    :cond_2
    invoke-virtual {v2}, Lcom/sun/mail/iap/Response;->isNO()Z

    move-result v0

    if-eqz v0, :cond_3

    move-object v0, v1

    .line 1108
    goto :goto_2

    .line 1110
    :cond_3
    invoke-virtual {p0, v2}, Lcom/sun/mail/imap/protocol/IMAPProtocol;->handleResult(Lcom/sun/mail/iap/Response;)V

    move-object v0, v1

    .line 1111
    goto :goto_2
.end method

.method protected fetchBody(ILjava/lang/String;Z)Lcom/sun/mail/imap/protocol/BODY;
    .locals 4
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Lcom/sun/mail/iap/ProtocolException;
        }
    .end annotation

    .prologue
    const/4 v1, 0x0

    .line 1040
    if-eqz p3, :cond_1

    .line 1042
    new-instance v2, Ljava/lang/StringBuilder;

    const-string v0, "BODY.PEEK["

    invoke-direct {v2, v0}, Ljava/lang/StringBuilder;-><init>(Ljava/lang/String;)V

    if-nez p2, :cond_0

    const-string v0, "]"

    :goto_0
    invoke-virtual {v2, v0}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-virtual {v0}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v0

    .line 1041
    invoke-virtual {p0, p1, v0}, Lcom/sun/mail/imap/protocol/IMAPProtocol;->fetch(ILjava/lang/String;)[Lcom/sun/mail/iap/Response;

    move-result-object v0

    .line 1047
    :goto_1
    invoke-virtual {p0, v0}, Lcom/sun/mail/imap/protocol/IMAPProtocol;->notifyResponseHandlers([Lcom/sun/mail/iap/Response;)V

    .line 1049
    array-length v2, v0

    add-int/lit8 v2, v2, -0x1

    aget-object v2, v0, v2

    .line 1050
    invoke-virtual {v2}, Lcom/sun/mail/iap/Response;->isOK()Z

    move-result v3

    if-eqz v3, :cond_3

    .line 1051
    const-class v1, Lcom/sun/mail/imap/protocol/BODY;

    invoke-static {v0, p1, v1}, Lcom/sun/mail/imap/protocol/FetchResponse;->getItem([Lcom/sun/mail/iap/Response;ILjava/lang/Class;)Lcom/sun/mail/imap/protocol/Item;

    move-result-object v0

    check-cast v0, Lcom/sun/mail/imap/protocol/BODY;

    .line 1056
    :goto_2
    return-object v0

    .line 1042
    :cond_0
    new-instance v0, Ljava/lang/StringBuilder;

    invoke-static {p2}, Ljava/lang/String;->valueOf(Ljava/lang/Object;)Ljava/lang/String;

    move-result-object v3

    invoke-direct {v0, v3}, Ljava/lang/StringBuilder;-><init>(Ljava/lang/String;)V

    const-string v3, "]"

    invoke-virtual {v0, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-virtual {v0}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v0

    goto :goto_0

    .line 1045
    :cond_1
    new-instance v2, Ljava/lang/StringBuilder;

    const-string v0, "BODY["

    invoke-direct {v2, v0}, Ljava/lang/StringBuilder;-><init>(Ljava/lang/String;)V

    if-nez p2, :cond_2

    const-string v0, "]"

    :goto_3
    invoke-virtual {v2, v0}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-virtual {v0}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v0

    .line 1044
    invoke-virtual {p0, p1, v0}, Lcom/sun/mail/imap/protocol/IMAPProtocol;->fetch(ILjava/lang/String;)[Lcom/sun/mail/iap/Response;

    move-result-object v0

    goto :goto_1

    .line 1045
    :cond_2
    new-instance v0, Ljava/lang/StringBuilder;

    invoke-static {p2}, Ljava/lang/String;->valueOf(Ljava/lang/Object;)Ljava/lang/String;

    move-result-object v3

    invoke-direct {v0, v3}, Ljava/lang/StringBuilder;-><init>(Ljava/lang/String;)V

    const-string v3, "]"

    invoke-virtual {v0, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-virtual {v0}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v0

    goto :goto_3

    .line 1052
    :cond_3
    invoke-virtual {v2}, Lcom/sun/mail/iap/Response;->isNO()Z

    move-result v0

    if-eqz v0, :cond_4

    move-object v0, v1

    .line 1053
    goto :goto_2

    .line 1055
    :cond_4
    invoke-virtual {p0, v2}, Lcom/sun/mail/imap/protocol/IMAPProtocol;->handleResult(Lcom/sun/mail/iap/Response;)V

    move-object v0, v1

    .line 1056
    goto :goto_2
.end method

.method public fetchBodyStructure(I)Lcom/sun/mail/imap/protocol/BODYSTRUCTURE;
    .locals 4
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Lcom/sun/mail/iap/ProtocolException;
        }
    .end annotation

    .prologue
    const/4 v0, 0x0

    .line 1004
    const-string v1, "BODYSTRUCTURE"

    invoke-virtual {p0, p1, v1}, Lcom/sun/mail/imap/protocol/IMAPProtocol;->fetch(ILjava/lang/String;)[Lcom/sun/mail/iap/Response;

    move-result-object v1

    .line 1005
    invoke-virtual {p0, v1}, Lcom/sun/mail/imap/protocol/IMAPProtocol;->notifyResponseHandlers([Lcom/sun/mail/iap/Response;)V

    .line 1007
    array-length v2, v1

    add-int/lit8 v2, v2, -0x1

    aget-object v2, v1, v2

    .line 1008
    invoke-virtual {v2}, Lcom/sun/mail/iap/Response;->isOK()Z

    move-result v3

    if-eqz v3, :cond_1

    .line 1010
    const-class v0, Lcom/sun/mail/imap/protocol/BODYSTRUCTURE;

    .line 1009
    invoke-static {v1, p1, v0}, Lcom/sun/mail/imap/protocol/FetchResponse;->getItem([Lcom/sun/mail/iap/Response;ILjava/lang/Class;)Lcom/sun/mail/imap/protocol/Item;

    move-result-object v0

    check-cast v0, Lcom/sun/mail/imap/protocol/BODYSTRUCTURE;

    .line 1015
    :cond_0
    :goto_0
    return-object v0

    .line 1011
    :cond_1
    invoke-virtual {v2}, Lcom/sun/mail/iap/Response;->isNO()Z

    move-result v1

    if-nez v1, :cond_0

    .line 1014
    invoke-virtual {p0, v2}, Lcom/sun/mail/imap/protocol/IMAPProtocol;->handleResult(Lcom/sun/mail/iap/Response;)V

    goto :goto_0
.end method

.method public fetchFlags(I)Ljavax/mail/Flags;
    .locals 6
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Lcom/sun/mail/iap/ProtocolException;
        }
    .end annotation

    .prologue
    const/4 v3, 0x0

    .line 1156
    .line 1157
    const-string v0, "FLAGS"

    invoke-virtual {p0, p1, v0}, Lcom/sun/mail/imap/protocol/IMAPProtocol;->fetch(ILjava/lang/String;)[Lcom/sun/mail/iap/Response;

    move-result-object v4

    .line 1160
    const/4 v0, 0x0

    array-length v5, v4

    move v2, v0

    move-object v1, v3

    :goto_0
    if-lt v2, v5, :cond_0

    move-object v0, v1

    .line 1174
    :goto_1
    invoke-virtual {p0, v4}, Lcom/sun/mail/imap/protocol/IMAPProtocol;->notifyResponseHandlers([Lcom/sun/mail/iap/Response;)V

    .line 1175
    array-length v1, v4

    add-int/lit8 v1, v1, -0x1

    aget-object v1, v4, v1

    invoke-virtual {p0, v1}, Lcom/sun/mail/imap/protocol/IMAPProtocol;->handleResult(Lcom/sun/mail/iap/Response;)V

    .line 1176
    return-object v0

    .line 1161
    :cond_0
    aget-object v0, v4, v2

    if-eqz v0, :cond_3

    .line 1162
    aget-object v0, v4, v2

    instance-of v0, v0, Lcom/sun/mail/imap/protocol/FetchResponse;

    if-eqz v0, :cond_3

    .line 1163
    aget-object v0, v4, v2

    check-cast v0, Lcom/sun/mail/imap/protocol/FetchResponse;

    invoke-virtual {v0}, Lcom/sun/mail/imap/protocol/FetchResponse;->getNumber()I

    move-result v0

    if-eq v0, p1, :cond_2

    move-object v0, v1

    .line 1160
    :cond_1
    :goto_2
    add-int/lit8 v1, v2, 0x1

    move v2, v1

    move-object v1, v0

    goto :goto_0

    .line 1166
    :cond_2
    aget-object v0, v4, v2

    check-cast v0, Lcom/sun/mail/imap/protocol/FetchResponse;

    .line 1167
    const-class v1, Ljavax/mail/Flags;

    invoke-virtual {v0, v1}, Lcom/sun/mail/imap/protocol/FetchResponse;->getItem(Ljava/lang/Class;)Lcom/sun/mail/imap/protocol/Item;

    move-result-object v0

    check-cast v0, Ljavax/mail/Flags;

    if-eqz v0, :cond_1

    .line 1168
    aput-object v3, v4, v2

    goto :goto_1

    :cond_3
    move-object v0, v1

    goto :goto_2
.end method

.method public fetchRFC822(ILjava/lang/String;)Lcom/sun/mail/imap/protocol/RFC822DATA;
    .locals 4
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Lcom/sun/mail/iap/ProtocolException;
        }
    .end annotation

    .prologue
    const/4 v1, 0x0

    .line 1133
    .line 1134
    if-nez p2, :cond_0

    const-string v0, "RFC822"

    .line 1133
    :goto_0
    invoke-virtual {p0, p1, v0}, Lcom/sun/mail/imap/protocol/IMAPProtocol;->fetch(ILjava/lang/String;)[Lcom/sun/mail/iap/Response;

    move-result-object v0

    .line 1138
    invoke-virtual {p0, v0}, Lcom/sun/mail/imap/protocol/IMAPProtocol;->notifyResponseHandlers([Lcom/sun/mail/iap/Response;)V

    .line 1140
    array-length v2, v0

    add-int/lit8 v2, v2, -0x1

    aget-object v2, v0, v2

    .line 1141
    invoke-virtual {v2}, Lcom/sun/mail/iap/Response;->isOK()Z

    move-result v3

    if-eqz v3, :cond_1

    .line 1143
    const-class v1, Lcom/sun/mail/imap/protocol/RFC822DATA;

    .line 1142
    invoke-static {v0, p1, v1}, Lcom/sun/mail/imap/protocol/FetchResponse;->getItem([Lcom/sun/mail/iap/Response;ILjava/lang/Class;)Lcom/sun/mail/imap/protocol/Item;

    move-result-object v0

    check-cast v0, Lcom/sun/mail/imap/protocol/RFC822DATA;

    .line 1148
    :goto_1
    return-object v0

    .line 1134
    :cond_0
    new-instance v0, Ljava/lang/StringBuilder;

    const-string v2, "RFC822."

    invoke-direct {v0, v2}, Ljava/lang/StringBuilder;-><init>(Ljava/lang/String;)V

    invoke-virtual {v0, p2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-virtual {v0}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v0

    goto :goto_0

    .line 1144
    :cond_1
    invoke-virtual {v2}, Lcom/sun/mail/iap/Response;->isNO()Z

    move-result v0

    if-eqz v0, :cond_2

    move-object v0, v1

    .line 1145
    goto :goto_1

    .line 1147
    :cond_2
    invoke-virtual {p0, v2}, Lcom/sun/mail/imap/protocol/IMAPProtocol;->handleResult(Lcom/sun/mail/iap/Response;)V

    move-object v0, v1

    .line 1148
    goto :goto_1
.end method

.method public fetchSequenceNumber(J)Lcom/sun/mail/imap/protocol/UID;
    .locals 9
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Lcom/sun/mail/iap/ProtocolException;
        }
    .end annotation

    .prologue
    const/4 v1, 0x0

    .line 1205
    .line 1206
    invoke-static {p1, p2}, Ljava/lang/String;->valueOf(J)Ljava/lang/String;

    move-result-object v0

    const-string v2, "UID"

    const/4 v3, 0x1

    invoke-direct {p0, v0, v2, v3}, Lcom/sun/mail/imap/protocol/IMAPProtocol;->fetch(Ljava/lang/String;Ljava/lang/String;Z)[Lcom/sun/mail/iap/Response;

    move-result-object v3

    .line 1208
    const/4 v0, 0x0

    array-length v4, v3

    move v2, v0

    move-object v0, v1

    :goto_0
    if-lt v2, v4, :cond_1

    .line 1221
    :cond_0
    invoke-virtual {p0, v3}, Lcom/sun/mail/imap/protocol/IMAPProtocol;->notifyResponseHandlers([Lcom/sun/mail/iap/Response;)V

    .line 1222
    array-length v1, v3

    add-int/lit8 v1, v1, -0x1

    aget-object v1, v3, v1

    invoke-virtual {p0, v1}, Lcom/sun/mail/imap/protocol/IMAPProtocol;->handleResult(Lcom/sun/mail/iap/Response;)V

    .line 1223
    return-object v0

    .line 1209
    :cond_1
    aget-object v5, v3, v2

    if-eqz v5, :cond_2

    aget-object v5, v3, v2

    instance-of v5, v5, Lcom/sun/mail/imap/protocol/FetchResponse;

    if-nez v5, :cond_3

    .line 1208
    :cond_2
    :goto_1
    add-int/lit8 v2, v2, 0x1

    goto :goto_0

    .line 1212
    :cond_3
    aget-object v0, v3, v2

    check-cast v0, Lcom/sun/mail/imap/protocol/FetchResponse;

    .line 1213
    const-class v5, Lcom/sun/mail/imap/protocol/UID;

    invoke-virtual {v0, v5}, Lcom/sun/mail/imap/protocol/FetchResponse;->getItem(Ljava/lang/Class;)Lcom/sun/mail/imap/protocol/Item;

    move-result-object v0

    check-cast v0, Lcom/sun/mail/imap/protocol/UID;

    if-eqz v0, :cond_2

    .line 1214
    iget-wide v6, v0, Lcom/sun/mail/imap/protocol/UID;->uid:J

    cmp-long v5, v6, p1

    if-eqz v5, :cond_0

    move-object v0, v1

    .line 1217
    goto :goto_1
.end method

.method public fetchSequenceNumbers(JJ)[Lcom/sun/mail/imap/protocol/UID;
    .locals 7
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Lcom/sun/mail/iap/ProtocolException;
        }
    .end annotation

    .prologue
    .line 1233
    new-instance v0, Ljava/lang/StringBuilder;

    invoke-static {p1, p2}, Ljava/lang/String;->valueOf(J)Ljava/lang/String;

    move-result-object v1

    invoke-static {v1}, Ljava/lang/String;->valueOf(Ljava/lang/Object;)Ljava/lang/String;

    move-result-object v1

    invoke-direct {v0, v1}, Ljava/lang/StringBuilder;-><init>(Ljava/lang/String;)V

    const-string v1, ":"

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    .line 1234
    const-wide/16 v2, -0x1

    cmp-long v0, p3, v2

    if-nez v0, :cond_0

    const-string v0, "*"

    :goto_0
    invoke-virtual {v1, v0}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-virtual {v0}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v0

    .line 1236
    const-string v1, "UID"

    const/4 v2, 0x1

    .line 1233
    invoke-direct {p0, v0, v1, v2}, Lcom/sun/mail/imap/protocol/IMAPProtocol;->fetch(Ljava/lang/String;Ljava/lang/String;Z)[Lcom/sun/mail/iap/Response;

    move-result-object v2

    .line 1239
    new-instance v3, Ljava/util/Vector;

    invoke-direct {v3}, Ljava/util/Vector;-><init>()V

    .line 1240
    const/4 v0, 0x0

    array-length v4, v2

    move v1, v0

    :goto_1
    if-lt v1, v4, :cond_1

    .line 1249
    invoke-virtual {p0, v2}, Lcom/sun/mail/imap/protocol/IMAPProtocol;->notifyResponseHandlers([Lcom/sun/mail/iap/Response;)V

    .line 1250
    array-length v0, v2

    add-int/lit8 v0, v0, -0x1

    aget-object v0, v2, v0

    invoke-virtual {p0, v0}, Lcom/sun/mail/imap/protocol/IMAPProtocol;->handleResult(Lcom/sun/mail/iap/Response;)V

    .line 1252
    invoke-virtual {v3}, Ljava/util/Vector;->size()I

    move-result v0

    new-array v0, v0, [Lcom/sun/mail/imap/protocol/UID;

    .line 1253
    invoke-virtual {v3, v0}, Ljava/util/Vector;->copyInto([Ljava/lang/Object;)V

    .line 1254
    return-object v0

    .line 1235
    :cond_0
    invoke-static {p3, p4}, Ljava/lang/String;->valueOf(J)Ljava/lang/String;

    move-result-object v0

    goto :goto_0

    .line 1241
    :cond_1
    aget-object v0, v2, v1

    if-eqz v0, :cond_2

    aget-object v0, v2, v1

    instance-of v0, v0, Lcom/sun/mail/imap/protocol/FetchResponse;

    if-nez v0, :cond_3

    .line 1240
    :cond_2
    :goto_2
    add-int/lit8 v0, v1, 0x1

    move v1, v0

    goto :goto_1

    .line 1244
    :cond_3
    aget-object v0, v2, v1

    check-cast v0, Lcom/sun/mail/imap/protocol/FetchResponse;

    .line 1245
    const-class v5, Lcom/sun/mail/imap/protocol/UID;

    invoke-virtual {v0, v5}, Lcom/sun/mail/imap/protocol/FetchResponse;->getItem(Ljava/lang/Class;)Lcom/sun/mail/imap/protocol/Item;

    move-result-object v0

    check-cast v0, Lcom/sun/mail/imap/protocol/UID;

    if-eqz v0, :cond_2

    .line 1246
    invoke-virtual {v3, v0}, Ljava/util/Vector;->addElement(Ljava/lang/Object;)V

    goto :goto_2
.end method

.method public fetchSequenceNumbers([J)[Lcom/sun/mail/imap/protocol/UID;
    .locals 6
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Lcom/sun/mail/iap/ProtocolException;
        }
    .end annotation

    .prologue
    const/4 v1, 0x0

    .line 1263
    new-instance v2, Ljava/lang/StringBuffer;

    invoke-direct {v2}, Ljava/lang/StringBuffer;-><init>()V

    move v0, v1

    .line 1264
    :goto_0
    array-length v3, p1

    if-lt v0, v3, :cond_0

    .line 1270
    invoke-virtual {v2}, Ljava/lang/StringBuffer;->toString()Ljava/lang/String;

    move-result-object v0

    const-string v2, "UID"

    const/4 v3, 0x1

    invoke-direct {p0, v0, v2, v3}, Lcom/sun/mail/imap/protocol/IMAPProtocol;->fetch(Ljava/lang/String;Ljava/lang/String;Z)[Lcom/sun/mail/iap/Response;

    move-result-object v2

    .line 1273
    new-instance v3, Ljava/util/Vector;

    invoke-direct {v3}, Ljava/util/Vector;-><init>()V

    .line 1274
    array-length v4, v2

    :goto_1
    if-lt v1, v4, :cond_2

    .line 1283
    invoke-virtual {p0, v2}, Lcom/sun/mail/imap/protocol/IMAPProtocol;->notifyResponseHandlers([Lcom/sun/mail/iap/Response;)V

    .line 1284
    array-length v0, v2

    add-int/lit8 v0, v0, -0x1

    aget-object v0, v2, v0

    invoke-virtual {p0, v0}, Lcom/sun/mail/imap/protocol/IMAPProtocol;->handleResult(Lcom/sun/mail/iap/Response;)V

    .line 1286
    invoke-virtual {v3}, Ljava/util/Vector;->size()I

    move-result v0

    new-array v0, v0, [Lcom/sun/mail/imap/protocol/UID;

    .line 1287
    invoke-virtual {v3, v0}, Ljava/util/Vector;->copyInto([Ljava/lang/Object;)V

    .line 1288
    return-object v0

    .line 1265
    :cond_0
    if-lez v0, :cond_1

    .line 1266
    const-string v3, ","

    invoke-virtual {v2, v3}, Ljava/lang/StringBuffer;->append(Ljava/lang/String;)Ljava/lang/StringBuffer;

    .line 1267
    :cond_1
    aget-wide v4, p1, v0

    invoke-static {v4, v5}, Ljava/lang/String;->valueOf(J)Ljava/lang/String;

    move-result-object v3

    invoke-virtual {v2, v3}, Ljava/lang/StringBuffer;->append(Ljava/lang/String;)Ljava/lang/StringBuffer;

    .line 1264
    add-int/lit8 v0, v0, 0x1

    goto :goto_0

    .line 1275
    :cond_2
    aget-object v0, v2, v1

    if-eqz v0, :cond_3

    aget-object v0, v2, v1

    instance-of v0, v0, Lcom/sun/mail/imap/protocol/FetchResponse;

    if-nez v0, :cond_4

    .line 1274
    :cond_3
    :goto_2
    add-int/lit8 v1, v1, 0x1

    goto :goto_1

    .line 1278
    :cond_4
    aget-object v0, v2, v1

    check-cast v0, Lcom/sun/mail/imap/protocol/FetchResponse;

    .line 1279
    const-class v5, Lcom/sun/mail/imap/protocol/UID;

    invoke-virtual {v0, v5}, Lcom/sun/mail/imap/protocol/FetchResponse;->getItem(Ljava/lang/Class;)Lcom/sun/mail/imap/protocol/Item;

    move-result-object v0

    check-cast v0, Lcom/sun/mail/imap/protocol/UID;

    if-eqz v0, :cond_3

    .line 1280
    invoke-virtual {v3, v0}, Ljava/util/Vector;->addElement(Ljava/lang/Object;)V

    goto :goto_2
.end method

.method public fetchUID(I)Lcom/sun/mail/imap/protocol/UID;
    .locals 4
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Lcom/sun/mail/iap/ProtocolException;
        }
    .end annotation

    .prologue
    const/4 v0, 0x0

    .line 1183
    const-string v1, "UID"

    invoke-virtual {p0, p1, v1}, Lcom/sun/mail/imap/protocol/IMAPProtocol;->fetch(ILjava/lang/String;)[Lcom/sun/mail/iap/Response;

    move-result-object v1

    .line 1186
    invoke-virtual {p0, v1}, Lcom/sun/mail/imap/protocol/IMAPProtocol;->notifyResponseHandlers([Lcom/sun/mail/iap/Response;)V

    .line 1188
    array-length v2, v1

    add-int/lit8 v2, v2, -0x1

    aget-object v2, v1, v2

    .line 1189
    invoke-virtual {v2}, Lcom/sun/mail/iap/Response;->isOK()Z

    move-result v3

    if-eqz v3, :cond_1

    .line 1190
    const-class v0, Lcom/sun/mail/imap/protocol/UID;

    invoke-static {v1, p1, v0}, Lcom/sun/mail/imap/protocol/FetchResponse;->getItem([Lcom/sun/mail/iap/Response;ILjava/lang/Class;)Lcom/sun/mail/imap/protocol/Item;

    move-result-object v0

    check-cast v0, Lcom/sun/mail/imap/protocol/UID;

    .line 1195
    :cond_0
    :goto_0
    return-object v0

    .line 1191
    :cond_1
    invoke-virtual {v2}, Lcom/sun/mail/iap/Response;->isNO()Z

    move-result v1

    if-nez v1, :cond_0

    .line 1194
    invoke-virtual {p0, v2}, Lcom/sun/mail/imap/protocol/IMAPProtocol;->handleResult(Lcom/sun/mail/iap/Response;)V

    goto :goto_0
.end method

.method public getACL(Ljava/lang/String;)[Lcom/sun/mail/imap/ACL;
    .locals 10
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Lcom/sun/mail/iap/ProtocolException;
        }
    .end annotation

    .prologue
    .line 1846
    const-string v0, "ACL"

    invoke-virtual {p0, v0}, Lcom/sun/mail/imap/protocol/IMAPProtocol;->hasCapability(Ljava/lang/String;)Z

    move-result v0

    if-nez v0, :cond_0

    .line 1847
    new-instance v0, Lcom/sun/mail/iap/BadCommandException;

    const-string v1, "ACL not supported"

    invoke-direct {v0, v1}, Lcom/sun/mail/iap/BadCommandException;-><init>(Ljava/lang/String;)V

    throw v0

    .line 1850
    :cond_0
    invoke-static {p1}, Lcom/sun/mail/imap/protocol/BASE64MailboxEncoder;->encode(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v0

    .line 1852
    new-instance v1, Lcom/sun/mail/iap/Argument;

    invoke-direct {v1}, Lcom/sun/mail/iap/Argument;-><init>()V

    .line 1853
    invoke-virtual {v1, v0}, Lcom/sun/mail/iap/Argument;->writeString(Ljava/lang/String;)V

    .line 1855
    const-string v0, "GETACL"

    invoke-virtual {p0, v0, v1}, Lcom/sun/mail/imap/protocol/IMAPProtocol;->command(Ljava/lang/String;Lcom/sun/mail/iap/Argument;)[Lcom/sun/mail/iap/Response;

    move-result-object v2

    .line 1856
    array-length v0, v2

    add-int/lit8 v0, v0, -0x1

    aget-object v3, v2, v0

    .line 1859
    new-instance v4, Ljava/util/Vector;

    invoke-direct {v4}, Ljava/util/Vector;-><init>()V

    .line 1860
    invoke-virtual {v3}, Lcom/sun/mail/iap/Response;->isOK()Z

    move-result v0

    if-eqz v0, :cond_1

    .line 1861
    const/4 v0, 0x0

    array-length v5, v2

    move v1, v0

    :goto_0
    if-lt v1, v5, :cond_2

    .line 1885
    :cond_1
    invoke-virtual {p0, v2}, Lcom/sun/mail/imap/protocol/IMAPProtocol;->notifyResponseHandlers([Lcom/sun/mail/iap/Response;)V

    .line 1886
    invoke-virtual {p0, v3}, Lcom/sun/mail/imap/protocol/IMAPProtocol;->handleResult(Lcom/sun/mail/iap/Response;)V

    .line 1887
    invoke-virtual {v4}, Ljava/util/Vector;->size()I

    move-result v0

    new-array v0, v0, [Lcom/sun/mail/imap/ACL;

    .line 1888
    invoke-virtual {v4, v0}, Ljava/util/Vector;->copyInto([Ljava/lang/Object;)V

    .line 1889
    return-object v0

    .line 1862
    :cond_2
    aget-object v0, v2, v1

    instance-of v0, v0, Lcom/sun/mail/imap/protocol/IMAPResponse;

    if-nez v0, :cond_4

    .line 1861
    :cond_3
    :goto_1
    add-int/lit8 v0, v1, 0x1

    move v1, v0

    goto :goto_0

    .line 1865
    :cond_4
    aget-object v0, v2, v1

    check-cast v0, Lcom/sun/mail/imap/protocol/IMAPResponse;

    .line 1866
    const-string v6, "ACL"

    invoke-virtual {v0, v6}, Lcom/sun/mail/imap/protocol/IMAPResponse;->keyEquals(Ljava/lang/String;)Z

    move-result v6

    if-eqz v6, :cond_3

    .line 1870
    invoke-virtual {v0}, Lcom/sun/mail/imap/protocol/IMAPResponse;->readAtomString()Ljava/lang/String;

    .line 1872
    :goto_2
    invoke-virtual {v0}, Lcom/sun/mail/imap/protocol/IMAPResponse;->readAtomString()Ljava/lang/String;

    move-result-object v6

    if-nez v6, :cond_6

    .line 1879
    :cond_5
    const/4 v0, 0x0

    aput-object v0, v2, v1

    goto :goto_1

    .line 1873
    :cond_6
    invoke-virtual {v0}, Lcom/sun/mail/imap/protocol/IMAPResponse;->readAtomString()Ljava/lang/String;

    move-result-object v7

    .line 1874
    if-eqz v7, :cond_5

    .line 1876
    new-instance v8, Lcom/sun/mail/imap/ACL;

    new-instance v9, Lcom/sun/mail/imap/Rights;

    invoke-direct {v9, v7}, Lcom/sun/mail/imap/Rights;-><init>(Ljava/lang/String;)V

    invoke-direct {v8, v6, v9}, Lcom/sun/mail/imap/ACL;-><init>(Ljava/lang/String;Lcom/sun/mail/imap/Rights;)V

    .line 1877
    invoke-virtual {v4, v8}, Ljava/util/Vector;->addElement(Ljava/lang/Object;)V

    goto :goto_2
.end method

.method public getCapabilities()Ljava/util/Map;
    .locals 1

    .prologue
    .line 279
    iget-object v0, p0, Lcom/sun/mail/imap/protocol/IMAPProtocol;->capabilities:Ljava/util/Map;

    return-object v0
.end method

.method getIMAPOutputStream()Ljava/io/OutputStream;
    .locals 1

    .prologue
    .line 588
    invoke-virtual {p0}, Lcom/sun/mail/imap/protocol/IMAPProtocol;->getOutputStream()Ljava/io/OutputStream;

    move-result-object v0

    return-object v0
.end method

.method public getQuota(Ljava/lang/String;)[Ljavax/mail/Quota;
    .locals 7
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Lcom/sun/mail/iap/ProtocolException;
        }
    .end annotation

    .prologue
    .line 1663
    const-string v0, "QUOTA"

    invoke-virtual {p0, v0}, Lcom/sun/mail/imap/protocol/IMAPProtocol;->hasCapability(Ljava/lang/String;)Z

    move-result v0

    if-nez v0, :cond_0

    .line 1664
    new-instance v0, Lcom/sun/mail/iap/BadCommandException;

    const-string v1, "QUOTA not supported"

    invoke-direct {v0, v1}, Lcom/sun/mail/iap/BadCommandException;-><init>(Ljava/lang/String;)V

    throw v0

    .line 1666
    :cond_0
    new-instance v0, Lcom/sun/mail/iap/Argument;

    invoke-direct {v0}, Lcom/sun/mail/iap/Argument;-><init>()V

    .line 1667
    invoke-virtual {v0, p1}, Lcom/sun/mail/iap/Argument;->writeString(Ljava/lang/String;)V

    .line 1669
    const-string v1, "GETQUOTA"

    invoke-virtual {p0, v1, v0}, Lcom/sun/mail/imap/protocol/IMAPProtocol;->command(Ljava/lang/String;Lcom/sun/mail/iap/Argument;)[Lcom/sun/mail/iap/Response;

    move-result-object v2

    .line 1672
    new-instance v3, Ljava/util/Vector;

    invoke-direct {v3}, Ljava/util/Vector;-><init>()V

    .line 1673
    array-length v0, v2

    add-int/lit8 v0, v0, -0x1

    aget-object v4, v2, v0

    .line 1676
    invoke-virtual {v4}, Lcom/sun/mail/iap/Response;->isOK()Z

    move-result v0

    if-eqz v0, :cond_1

    .line 1677
    const/4 v0, 0x0

    array-length v5, v2

    move v1, v0

    :goto_0
    if-lt v1, v5, :cond_2

    .line 1691
    :cond_1
    invoke-virtual {p0, v2}, Lcom/sun/mail/imap/protocol/IMAPProtocol;->notifyResponseHandlers([Lcom/sun/mail/iap/Response;)V

    .line 1692
    invoke-virtual {p0, v4}, Lcom/sun/mail/imap/protocol/IMAPProtocol;->handleResult(Lcom/sun/mail/iap/Response;)V

    .line 1693
    invoke-virtual {v3}, Ljava/util/Vector;->size()I

    move-result v0

    new-array v0, v0, [Ljavax/mail/Quota;

    .line 1694
    invoke-virtual {v3, v0}, Ljava/util/Vector;->copyInto([Ljava/lang/Object;)V

    .line 1695
    return-object v0

    .line 1678
    :cond_2
    aget-object v0, v2, v1

    instance-of v0, v0, Lcom/sun/mail/imap/protocol/IMAPResponse;

    if-nez v0, :cond_4

    .line 1677
    :cond_3
    :goto_1
    add-int/lit8 v0, v1, 0x1

    move v1, v0

    goto :goto_0

    .line 1681
    :cond_4
    aget-object v0, v2, v1

    check-cast v0, Lcom/sun/mail/imap/protocol/IMAPResponse;

    .line 1682
    const-string v6, "QUOTA"

    invoke-virtual {v0, v6}, Lcom/sun/mail/imap/protocol/IMAPResponse;->keyEquals(Ljava/lang/String;)Z

    move-result v6

    if-eqz v6, :cond_3

    .line 1683
    invoke-direct {p0, v0}, Lcom/sun/mail/imap/protocol/IMAPProtocol;->parseQuota(Lcom/sun/mail/iap/Response;)Ljavax/mail/Quota;

    move-result-object v0

    .line 1684
    invoke-virtual {v3, v0}, Ljava/util/Vector;->addElement(Ljava/lang/Object;)V

    .line 1685
    const/4 v0, 0x0

    aput-object v0, v2, v1

    goto :goto_1
.end method

.method public getQuotaRoot(Ljava/lang/String;)[Ljavax/mail/Quota;
    .locals 10
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Lcom/sun/mail/iap/ProtocolException;
        }
    .end annotation

    .prologue
    const/4 v9, 0x0

    const/4 v1, 0x0

    .line 1598
    const-string v0, "QUOTA"

    invoke-virtual {p0, v0}, Lcom/sun/mail/imap/protocol/IMAPProtocol;->hasCapability(Ljava/lang/String;)Z

    move-result v0

    if-nez v0, :cond_0

    .line 1599
    new-instance v0, Lcom/sun/mail/iap/BadCommandException;

    const-string v1, "GETQUOTAROOT not supported"

    invoke-direct {v0, v1}, Lcom/sun/mail/iap/BadCommandException;-><init>(Ljava/lang/String;)V

    throw v0

    .line 1602
    :cond_0
    invoke-static {p1}, Lcom/sun/mail/imap/protocol/BASE64MailboxEncoder;->encode(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v0

    .line 1604
    new-instance v2, Lcom/sun/mail/iap/Argument;

    invoke-direct {v2}, Lcom/sun/mail/iap/Argument;-><init>()V

    .line 1605
    invoke-virtual {v2, v0}, Lcom/sun/mail/iap/Argument;->writeString(Ljava/lang/String;)V

    .line 1607
    const-string v0, "GETQUOTAROOT"

    invoke-virtual {p0, v0, v2}, Lcom/sun/mail/imap/protocol/IMAPProtocol;->command(Ljava/lang/String;Lcom/sun/mail/iap/Argument;)[Lcom/sun/mail/iap/Response;

    move-result-object v3

    .line 1609
    array-length v0, v3

    add-int/lit8 v0, v0, -0x1

    aget-object v4, v3, v0

    .line 1611
    new-instance v5, Ljava/util/Hashtable;

    invoke-direct {v5}, Ljava/util/Hashtable;-><init>()V

    .line 1614
    invoke-virtual {v4}, Lcom/sun/mail/iap/Response;->isOK()Z

    move-result v0

    if-eqz v0, :cond_1

    .line 1615
    array-length v6, v3

    move v2, v1

    :goto_0
    if-lt v2, v6, :cond_2

    .line 1644
    :cond_1
    invoke-virtual {p0, v3}, Lcom/sun/mail/imap/protocol/IMAPProtocol;->notifyResponseHandlers([Lcom/sun/mail/iap/Response;)V

    .line 1645
    invoke-virtual {p0, v4}, Lcom/sun/mail/imap/protocol/IMAPProtocol;->handleResult(Lcom/sun/mail/iap/Response;)V

    .line 1647
    invoke-virtual {v5}, Ljava/util/Hashtable;->size()I

    move-result v0

    new-array v2, v0, [Ljavax/mail/Quota;

    .line 1648
    invoke-virtual {v5}, Ljava/util/Hashtable;->elements()Ljava/util/Enumeration;

    move-result-object v3

    .line 1649
    :goto_1
    invoke-interface {v3}, Ljava/util/Enumeration;->hasMoreElements()Z

    move-result v0

    if-nez v0, :cond_8

    .line 1651
    return-object v2

    .line 1616
    :cond_2
    aget-object v0, v3, v2

    instance-of v0, v0, Lcom/sun/mail/imap/protocol/IMAPResponse;

    if-nez v0, :cond_4

    .line 1615
    :cond_3
    :goto_2
    add-int/lit8 v0, v2, 0x1

    move v2, v0

    goto :goto_0

    .line 1619
    :cond_4
    aget-object v0, v3, v2

    check-cast v0, Lcom/sun/mail/imap/protocol/IMAPResponse;

    .line 1620
    const-string v7, "QUOTAROOT"

    invoke-virtual {v0, v7}, Lcom/sun/mail/imap/protocol/IMAPResponse;->keyEquals(Ljava/lang/String;)Z

    move-result v7

    if-eqz v7, :cond_6

    .line 1625
    invoke-virtual {v0}, Lcom/sun/mail/imap/protocol/IMAPResponse;->readAtomString()Ljava/lang/String;

    .line 1628
    :goto_3
    invoke-virtual {v0}, Lcom/sun/mail/imap/protocol/IMAPResponse;->readAtomString()Ljava/lang/String;

    move-result-object v7

    if-nez v7, :cond_5

    .line 1630
    aput-object v9, v3, v2

    goto :goto_2

    .line 1629
    :cond_5
    new-instance v8, Ljavax/mail/Quota;

    invoke-direct {v8, v7}, Ljavax/mail/Quota;-><init>(Ljava/lang/String;)V

    invoke-virtual {v5, v7, v8}, Ljava/util/Hashtable;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    goto :goto_3

    .line 1631
    :cond_6
    const-string v7, "QUOTA"

    invoke-virtual {v0, v7}, Lcom/sun/mail/imap/protocol/IMAPResponse;->keyEquals(Ljava/lang/String;)Z

    move-result v7

    if-eqz v7, :cond_3

    .line 1632
    invoke-direct {p0, v0}, Lcom/sun/mail/imap/protocol/IMAPProtocol;->parseQuota(Lcom/sun/mail/iap/Response;)Ljavax/mail/Quota;

    move-result-object v7

    .line 1633
    iget-object v0, v7, Ljavax/mail/Quota;->quotaRoot:Ljava/lang/String;

    invoke-virtual {v5, v0}, Ljava/util/Hashtable;->get(Ljava/lang/Object;)Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Ljavax/mail/Quota;

    .line 1634
    if-eqz v0, :cond_7

    iget-object v0, v0, Ljavax/mail/Quota;->resources:[Ljavax/mail/Quota$Resource;

    .line 1637
    :cond_7
    iget-object v0, v7, Ljavax/mail/Quota;->quotaRoot:Ljava/lang/String;

    invoke-virtual {v5, v0, v7}, Ljava/util/Hashtable;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    .line 1638
    aput-object v9, v3, v2

    goto :goto_2

    .line 1650
    :cond_8
    invoke-interface {v3}, Ljava/util/Enumeration;->nextElement()Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Ljavax/mail/Quota;

    aput-object v0, v2, v1

    .line 1649
    add-int/lit8 v0, v1, 0x1

    move v1, v0

    goto :goto_1
.end method

.method protected getResponseBuffer()Lcom/sun/mail/iap/ByteArray;
    .locals 2

    .prologue
    .line 1121
    iget-object v0, p0, Lcom/sun/mail/imap/protocol/IMAPProtocol;->ba:Lcom/sun/mail/iap/ByteArray;

    .line 1122
    const/4 v1, 0x0

    iput-object v1, p0, Lcom/sun/mail/imap/protocol/IMAPProtocol;->ba:Lcom/sun/mail/iap/ByteArray;

    .line 1123
    return-object v0
.end method

.method public hasCapability(Ljava/lang/String;)Z
    .locals 2

    .prologue
    .line 270
    iget-object v0, p0, Lcom/sun/mail/imap/protocol/IMAPProtocol;->capabilities:Ljava/util/Map;

    sget-object v1, Ljava/util/Locale;->ENGLISH:Ljava/util/Locale;

    invoke-virtual {p1, v1}, Ljava/lang/String;->toUpperCase(Ljava/util/Locale;)Ljava/lang/String;

    move-result-object v1

    invoke-interface {v0, v1}, Ljava/util/Map;->containsKey(Ljava/lang/Object;)Z

    move-result v0

    return v0
.end method

.method public idleAbort()V
    .locals 2
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Lcom/sun/mail/iap/ProtocolException;
        }
    .end annotation

    .prologue
    .line 2096
    invoke-virtual {p0}, Lcom/sun/mail/imap/protocol/IMAPProtocol;->getOutputStream()Ljava/io/OutputStream;

    move-result-object v0

    .line 2098
    :try_start_0
    sget-object v1, Lcom/sun/mail/imap/protocol/IMAPProtocol;->DONE:[B

    invoke-virtual {v0, v1}, Ljava/io/OutputStream;->write([B)V

    .line 2099
    invoke-virtual {v0}, Ljava/io/OutputStream;->flush()V
    :try_end_0
    .catch Ljava/io/IOException; {:try_start_0 .. :try_end_0} :catch_0

    .line 2103
    :goto_0
    return-void

    .line 2100
    :catch_0
    move-exception v0

    goto :goto_0
.end method

.method public declared-synchronized idleStart()V
    .locals 2
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Lcom/sun/mail/iap/ProtocolException;
        }
    .end annotation

    .prologue
    .line 2011
    monitor-enter p0

    :try_start_0
    const-string v0, "IDLE"

    invoke-virtual {p0, v0}, Lcom/sun/mail/imap/protocol/IMAPProtocol;->hasCapability(Ljava/lang/String;)Z

    move-result v0

    if-nez v0, :cond_0

    .line 2012
    new-instance v0, Lcom/sun/mail/iap/BadCommandException;

    const-string v1, "IDLE not supported"

    invoke-direct {v0, v1}, Lcom/sun/mail/iap/BadCommandException;-><init>(Ljava/lang/String;)V

    throw v0
    :try_end_0
    .catchall {:try_start_0 .. :try_end_0} :catchall_0

    .line 2011
    :catchall_0
    move-exception v0

    monitor-exit p0

    throw v0

    .line 2017
    :cond_0
    :try_start_1
    const-string v0, "IDLE"

    const/4 v1, 0x0

    invoke-virtual {p0, v0, v1}, Lcom/sun/mail/imap/protocol/IMAPProtocol;->writeCommand(Ljava/lang/String;Lcom/sun/mail/iap/Argument;)Ljava/lang/String;

    move-result-object v0

    iput-object v0, p0, Lcom/sun/mail/imap/protocol/IMAPProtocol;->idleTag:Ljava/lang/String;

    .line 2018
    invoke-virtual {p0}, Lcom/sun/mail/imap/protocol/IMAPProtocol;->readResponse()Lcom/sun/mail/iap/Response;
    :try_end_1
    .catch Lcom/sun/mail/iap/LiteralException; {:try_start_1 .. :try_end_1} :catch_0
    .catch Ljava/lang/Exception; {:try_start_1 .. :try_end_1} :catch_1
    .catchall {:try_start_1 .. :try_end_1} :catchall_0

    move-result-object v0

    .line 2026
    :goto_0
    :try_start_2
    invoke-virtual {v0}, Lcom/sun/mail/iap/Response;->isContinuation()Z

    move-result v1

    if-nez v1, :cond_1

    .line 2027
    invoke-virtual {p0, v0}, Lcom/sun/mail/imap/protocol/IMAPProtocol;->handleResult(Lcom/sun/mail/iap/Response;)V
    :try_end_2
    .catchall {:try_start_2 .. :try_end_2} :catchall_0

    .line 2028
    :cond_1
    monitor-exit p0

    return-void

    .line 2019
    :catch_0
    move-exception v0

    .line 2020
    :try_start_3
    invoke-virtual {v0}, Lcom/sun/mail/iap/LiteralException;->getResponse()Lcom/sun/mail/iap/Response;

    move-result-object v0

    goto :goto_0

    .line 2021
    :catch_1
    move-exception v0

    .line 2023
    invoke-static {v0}, Lcom/sun/mail/iap/Response;->byeResponse(Ljava/lang/Exception;)Lcom/sun/mail/iap/Response;
    :try_end_3
    .catchall {:try_start_3 .. :try_end_3} :catchall_0

    move-result-object v0

    goto :goto_0
.end method

.method public isAuthenticated()Z
    .locals 1

    .prologue
    .line 238
    iget-boolean v0, p0, Lcom/sun/mail/imap/protocol/IMAPProtocol;->authenticated:Z

    return v0
.end method

.method public isREV1()Z
    .locals 1

    .prologue
    .line 245
    iget-boolean v0, p0, Lcom/sun/mail/imap/protocol/IMAPProtocol;->rev1:Z

    return v0
.end method

.method public list(Ljava/lang/String;Ljava/lang/String;)[Lcom/sun/mail/imap/protocol/ListInfo;
    .locals 1
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Lcom/sun/mail/iap/ProtocolException;
        }
    .end annotation

    .prologue
    .line 821
    const-string v0, "LIST"

    invoke-direct {p0, v0, p1, p2}, Lcom/sun/mail/imap/protocol/IMAPProtocol;->doList(Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;)[Lcom/sun/mail/imap/protocol/ListInfo;

    move-result-object v0

    return-object v0
.end method

.method public listRights(Ljava/lang/String;Ljava/lang/String;)[Lcom/sun/mail/imap/Rights;
    .locals 8
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Lcom/sun/mail/iap/ProtocolException;
        }
    .end annotation

    .prologue
    .line 1899
    const-string v0, "ACL"

    invoke-virtual {p0, v0}, Lcom/sun/mail/imap/protocol/IMAPProtocol;->hasCapability(Ljava/lang/String;)Z

    move-result v0

    if-nez v0, :cond_0

    .line 1900
    new-instance v0, Lcom/sun/mail/iap/BadCommandException;

    const-string v1, "ACL not supported"

    invoke-direct {v0, v1}, Lcom/sun/mail/iap/BadCommandException;-><init>(Ljava/lang/String;)V

    throw v0

    .line 1903
    :cond_0
    invoke-static {p1}, Lcom/sun/mail/imap/protocol/BASE64MailboxEncoder;->encode(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v0

    .line 1905
    new-instance v1, Lcom/sun/mail/iap/Argument;

    invoke-direct {v1}, Lcom/sun/mail/iap/Argument;-><init>()V

    .line 1906
    invoke-virtual {v1, v0}, Lcom/sun/mail/iap/Argument;->writeString(Ljava/lang/String;)V

    .line 1907
    invoke-virtual {v1, p2}, Lcom/sun/mail/iap/Argument;->writeString(Ljava/lang/String;)V

    .line 1909
    const-string v0, "LISTRIGHTS"

    invoke-virtual {p0, v0, v1}, Lcom/sun/mail/imap/protocol/IMAPProtocol;->command(Ljava/lang/String;Lcom/sun/mail/iap/Argument;)[Lcom/sun/mail/iap/Response;

    move-result-object v2

    .line 1910
    array-length v0, v2

    add-int/lit8 v0, v0, -0x1

    aget-object v3, v2, v0

    .line 1913
    new-instance v4, Ljava/util/Vector;

    invoke-direct {v4}, Ljava/util/Vector;-><init>()V

    .line 1914
    invoke-virtual {v3}, Lcom/sun/mail/iap/Response;->isOK()Z

    move-result v0

    if-eqz v0, :cond_1

    .line 1915
    const/4 v0, 0x0

    array-length v5, v2

    move v1, v0

    :goto_0
    if-lt v1, v5, :cond_2

    .line 1936
    :cond_1
    invoke-virtual {p0, v2}, Lcom/sun/mail/imap/protocol/IMAPProtocol;->notifyResponseHandlers([Lcom/sun/mail/iap/Response;)V

    .line 1937
    invoke-virtual {p0, v3}, Lcom/sun/mail/imap/protocol/IMAPProtocol;->handleResult(Lcom/sun/mail/iap/Response;)V

    .line 1938
    invoke-virtual {v4}, Ljava/util/Vector;->size()I

    move-result v0

    new-array v0, v0, [Lcom/sun/mail/imap/Rights;

    .line 1939
    invoke-virtual {v4, v0}, Ljava/util/Vector;->copyInto([Ljava/lang/Object;)V

    .line 1940
    return-object v0

    .line 1916
    :cond_2
    aget-object v0, v2, v1

    instance-of v0, v0, Lcom/sun/mail/imap/protocol/IMAPResponse;

    if-nez v0, :cond_4

    .line 1915
    :cond_3
    :goto_1
    add-int/lit8 v0, v1, 0x1

    move v1, v0

    goto :goto_0

    .line 1919
    :cond_4
    aget-object v0, v2, v1

    check-cast v0, Lcom/sun/mail/imap/protocol/IMAPResponse;

    .line 1920
    const-string v6, "LISTRIGHTS"

    invoke-virtual {v0, v6}, Lcom/sun/mail/imap/protocol/IMAPResponse;->keyEquals(Ljava/lang/String;)Z

    move-result v6

    if-eqz v6, :cond_3

    .line 1924
    invoke-virtual {v0}, Lcom/sun/mail/imap/protocol/IMAPResponse;->readAtomString()Ljava/lang/String;

    .line 1926
    invoke-virtual {v0}, Lcom/sun/mail/imap/protocol/IMAPResponse;->readAtomString()Ljava/lang/String;

    .line 1928
    :goto_2
    invoke-virtual {v0}, Lcom/sun/mail/imap/protocol/IMAPResponse;->readAtomString()Ljava/lang/String;

    move-result-object v6

    if-nez v6, :cond_5

    .line 1930
    const/4 v0, 0x0

    aput-object v0, v2, v1

    goto :goto_1

    .line 1929
    :cond_5
    new-instance v7, Lcom/sun/mail/imap/Rights;

    invoke-direct {v7, v6}, Lcom/sun/mail/imap/Rights;-><init>(Ljava/lang/String;)V

    invoke-virtual {v4, v7}, Ljava/util/Vector;->addElement(Ljava/lang/Object;)V

    goto :goto_2
.end method

.method public login(Ljava/lang/String;Ljava/lang/String;)V
    .locals 2
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Lcom/sun/mail/iap/ProtocolException;
        }
    .end annotation

    .prologue
    .line 326
    new-instance v0, Lcom/sun/mail/iap/Argument;

    invoke-direct {v0}, Lcom/sun/mail/iap/Argument;-><init>()V

    .line 327
    invoke-virtual {v0, p1}, Lcom/sun/mail/iap/Argument;->writeString(Ljava/lang/String;)V

    .line 328
    invoke-virtual {v0, p2}, Lcom/sun/mail/iap/Argument;->writeString(Ljava/lang/String;)V

    .line 330
    const-string v1, "LOGIN"

    invoke-virtual {p0, v1, v0}, Lcom/sun/mail/imap/protocol/IMAPProtocol;->command(Ljava/lang/String;Lcom/sun/mail/iap/Argument;)[Lcom/sun/mail/iap/Response;

    move-result-object v0

    .line 333
    invoke-virtual {p0, v0}, Lcom/sun/mail/imap/protocol/IMAPProtocol;->notifyResponseHandlers([Lcom/sun/mail/iap/Response;)V

    .line 336
    array-length v1, v0

    add-int/lit8 v1, v1, -0x1

    aget-object v1, v0, v1

    invoke-virtual {p0, v1}, Lcom/sun/mail/imap/protocol/IMAPProtocol;->handleResult(Lcom/sun/mail/iap/Response;)V

    .line 338
    array-length v1, v0

    add-int/lit8 v1, v1, -0x1

    aget-object v0, v0, v1

    invoke-virtual {p0, v0}, Lcom/sun/mail/imap/protocol/IMAPProtocol;->setCapabilities(Lcom/sun/mail/iap/Response;)V

    .line 340
    const/4 v0, 0x1

    iput-boolean v0, p0, Lcom/sun/mail/imap/protocol/IMAPProtocol;->authenticated:Z

    .line 341
    return-void
.end method

.method public logout()V
    .locals 2
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Lcom/sun/mail/iap/ProtocolException;
        }
    .end annotation

    .prologue
    .line 311
    const-string v0, "LOGOUT"

    const/4 v1, 0x0

    invoke-virtual {p0, v0, v1}, Lcom/sun/mail/imap/protocol/IMAPProtocol;->command(Ljava/lang/String;Lcom/sun/mail/iap/Argument;)[Lcom/sun/mail/iap/Response;

    move-result-object v0

    .line 313
    const/4 v1, 0x0

    iput-boolean v1, p0, Lcom/sun/mail/imap/protocol/IMAPProtocol;->authenticated:Z

    .line 316
    invoke-virtual {p0, v0}, Lcom/sun/mail/imap/protocol/IMAPProtocol;->notifyResponseHandlers([Lcom/sun/mail/iap/Response;)V

    .line 317
    invoke-virtual {p0}, Lcom/sun/mail/imap/protocol/IMAPProtocol;->disconnect()V

    .line 318
    return-void
.end method

.method public lsub(Ljava/lang/String;Ljava/lang/String;)[Lcom/sun/mail/imap/protocol/ListInfo;
    .locals 1
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Lcom/sun/mail/iap/ProtocolException;
        }
    .end annotation

    .prologue
    .line 831
    const-string v0, "LSUB"

    invoke-direct {p0, v0, p1, p2}, Lcom/sun/mail/imap/protocol/IMAPProtocol;->doList(Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;)[Lcom/sun/mail/imap/protocol/ListInfo;

    move-result-object v0

    return-object v0
.end method

.method public myRights(Ljava/lang/String;)Lcom/sun/mail/imap/Rights;
    .locals 8
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Lcom/sun/mail/iap/ProtocolException;
        }
    .end annotation

    .prologue
    const/4 v2, 0x0

    .line 1949
    const-string v0, "ACL"

    invoke-virtual {p0, v0}, Lcom/sun/mail/imap/protocol/IMAPProtocol;->hasCapability(Ljava/lang/String;)Z

    move-result v0

    if-nez v0, :cond_0

    .line 1950
    new-instance v0, Lcom/sun/mail/iap/BadCommandException;

    const-string v1, "ACL not supported"

    invoke-direct {v0, v1}, Lcom/sun/mail/iap/BadCommandException;-><init>(Ljava/lang/String;)V

    throw v0

    .line 1953
    :cond_0
    invoke-static {p1}, Lcom/sun/mail/imap/protocol/BASE64MailboxEncoder;->encode(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v0

    .line 1955
    new-instance v1, Lcom/sun/mail/iap/Argument;

    invoke-direct {v1}, Lcom/sun/mail/iap/Argument;-><init>()V

    .line 1956
    invoke-virtual {v1, v0}, Lcom/sun/mail/iap/Argument;->writeString(Ljava/lang/String;)V

    .line 1958
    const-string v0, "MYRIGHTS"

    invoke-virtual {p0, v0, v1}, Lcom/sun/mail/imap/protocol/IMAPProtocol;->command(Ljava/lang/String;Lcom/sun/mail/iap/Argument;)[Lcom/sun/mail/iap/Response;

    move-result-object v4

    .line 1959
    array-length v0, v4

    add-int/lit8 v0, v0, -0x1

    aget-object v5, v4, v0

    .line 1963
    invoke-virtual {v5}, Lcom/sun/mail/iap/Response;->isOK()Z

    move-result v0

    if-eqz v0, :cond_5

    .line 1964
    const/4 v0, 0x0

    array-length v6, v4

    move v3, v0

    move-object v1, v2

    :goto_0
    if-lt v3, v6, :cond_1

    .line 1982
    :goto_1
    invoke-virtual {p0, v4}, Lcom/sun/mail/imap/protocol/IMAPProtocol;->notifyResponseHandlers([Lcom/sun/mail/iap/Response;)V

    .line 1983
    invoke-virtual {p0, v5}, Lcom/sun/mail/imap/protocol/IMAPProtocol;->handleResult(Lcom/sun/mail/iap/Response;)V

    .line 1984
    return-object v1

    .line 1965
    :cond_1
    aget-object v0, v4, v3

    instance-of v0, v0, Lcom/sun/mail/imap/protocol/IMAPResponse;

    if-nez v0, :cond_3

    .line 1964
    :cond_2
    :goto_2
    add-int/lit8 v0, v3, 0x1

    move v3, v0

    goto :goto_0

    .line 1968
    :cond_3
    aget-object v0, v4, v3

    check-cast v0, Lcom/sun/mail/imap/protocol/IMAPResponse;

    .line 1969
    const-string v7, "MYRIGHTS"

    invoke-virtual {v0, v7}, Lcom/sun/mail/imap/protocol/IMAPResponse;->keyEquals(Ljava/lang/String;)Z

    move-result v7

    if-eqz v7, :cond_2

    .line 1972
    invoke-virtual {v0}, Lcom/sun/mail/imap/protocol/IMAPResponse;->readAtomString()Ljava/lang/String;

    .line 1973
    invoke-virtual {v0}, Lcom/sun/mail/imap/protocol/IMAPResponse;->readAtomString()Ljava/lang/String;

    move-result-object v7

    .line 1974
    if-nez v1, :cond_4

    .line 1975
    new-instance v0, Lcom/sun/mail/imap/Rights;

    invoke-direct {v0, v7}, Lcom/sun/mail/imap/Rights;-><init>(Ljava/lang/String;)V

    .line 1976
    :goto_3
    aput-object v2, v4, v3

    move-object v1, v0

    goto :goto_2

    :cond_4
    move-object v0, v1

    goto :goto_3

    :cond_5
    move-object v1, v2

    goto :goto_1
.end method

.method public namespace()Lcom/sun/mail/imap/protocol/Namespaces;
    .locals 8
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Lcom/sun/mail/iap/ProtocolException;
        }
    .end annotation

    .prologue
    const/4 v2, 0x0

    .line 1559
    const-string v0, "NAMESPACE"

    invoke-virtual {p0, v0}, Lcom/sun/mail/imap/protocol/IMAPProtocol;->hasCapability(Ljava/lang/String;)Z

    move-result v0

    if-nez v0, :cond_0

    .line 1560
    new-instance v0, Lcom/sun/mail/iap/BadCommandException;

    const-string v1, "NAMESPACE not supported"

    invoke-direct {v0, v1}, Lcom/sun/mail/iap/BadCommandException;-><init>(Ljava/lang/String;)V

    throw v0

    .line 1562
    :cond_0
    const-string v0, "NAMESPACE"

    invoke-virtual {p0, v0, v2}, Lcom/sun/mail/imap/protocol/IMAPProtocol;->command(Ljava/lang/String;Lcom/sun/mail/iap/Argument;)[Lcom/sun/mail/iap/Response;

    move-result-object v4

    .line 1565
    array-length v0, v4

    add-int/lit8 v0, v0, -0x1

    aget-object v5, v4, v0

    .line 1568
    invoke-virtual {v5}, Lcom/sun/mail/iap/Response;->isOK()Z

    move-result v0

    if-eqz v0, :cond_5

    .line 1569
    const/4 v0, 0x0

    array-length v6, v4

    move v3, v0

    move-object v1, v2

    :goto_0
    if-lt v3, v6, :cond_1

    .line 1583
    :goto_1
    invoke-virtual {p0, v4}, Lcom/sun/mail/imap/protocol/IMAPProtocol;->notifyResponseHandlers([Lcom/sun/mail/iap/Response;)V

    .line 1584
    invoke-virtual {p0, v5}, Lcom/sun/mail/imap/protocol/IMAPProtocol;->handleResult(Lcom/sun/mail/iap/Response;)V

    .line 1585
    return-object v1

    .line 1570
    :cond_1
    aget-object v0, v4, v3

    instance-of v0, v0, Lcom/sun/mail/imap/protocol/IMAPResponse;

    if-nez v0, :cond_3

    .line 1569
    :cond_2
    :goto_2
    add-int/lit8 v0, v3, 0x1

    move v3, v0

    goto :goto_0

    .line 1573
    :cond_3
    aget-object v0, v4, v3

    check-cast v0, Lcom/sun/mail/imap/protocol/IMAPResponse;

    .line 1574
    const-string v7, "NAMESPACE"

    invoke-virtual {v0, v7}, Lcom/sun/mail/imap/protocol/IMAPResponse;->keyEquals(Ljava/lang/String;)Z

    move-result v7

    if-eqz v7, :cond_2

    .line 1575
    if-nez v1, :cond_4

    .line 1576
    new-instance v1, Lcom/sun/mail/imap/protocol/Namespaces;

    invoke-direct {v1, v0}, Lcom/sun/mail/imap/protocol/Namespaces;-><init>(Lcom/sun/mail/iap/Response;)V

    move-object v0, v1

    .line 1577
    :goto_3
    aput-object v2, v4, v3

    move-object v1, v0

    goto :goto_2

    :cond_4
    move-object v0, v1

    goto :goto_3

    :cond_5
    move-object v1, v2

    goto :goto_1
.end method

.method public noop()V
    .locals 2
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Lcom/sun/mail/iap/ProtocolException;
        }
    .end annotation

    .prologue
    .line 299
    iget-boolean v0, p0, Lcom/sun/mail/imap/protocol/IMAPProtocol;->debug:Z

    if-eqz v0, :cond_0

    .line 300
    iget-object v0, p0, Lcom/sun/mail/imap/protocol/IMAPProtocol;->out:Ljava/io/PrintStream;

    const-string v1, "IMAP DEBUG: IMAPProtocol noop"

    invoke-virtual {v0, v1}, Ljava/io/PrintStream;->println(Ljava/lang/String;)V

    .line 301
    :cond_0
    const-string v0, "NOOP"

    const/4 v1, 0x0

    invoke-virtual {p0, v0, v1}, Lcom/sun/mail/imap/protocol/IMAPProtocol;->simpleCommand(Ljava/lang/String;Lcom/sun/mail/iap/Argument;)V

    .line 302
    return-void
.end method

.method protected parseCapabilities(Lcom/sun/mail/iap/Response;)V
    .locals 7

    .prologue
    const/16 v6, 0x5d

    const/4 v2, 0x0

    const/4 v5, 0x5

    .line 188
    :cond_0
    :goto_0
    invoke-virtual {p1, v6}, Lcom/sun/mail/iap/Response;->readAtom(C)Ljava/lang/String;

    move-result-object v0

    if-nez v0, :cond_2

    .line 213
    :cond_1
    return-void

    .line 189
    :cond_2
    invoke-virtual {v0}, Ljava/lang/String;->length()I

    move-result v1

    if-nez v1, :cond_3

    .line 190
    invoke-virtual {p1}, Lcom/sun/mail/iap/Response;->peekByte()B

    move-result v0

    if-eq v0, v6, :cond_1

    .line 203
    invoke-virtual {p1}, Lcom/sun/mail/iap/Response;->skipToken()V

    goto :goto_0

    .line 205
    :cond_3
    iget-object v1, p0, Lcom/sun/mail/imap/protocol/IMAPProtocol;->capabilities:Ljava/util/Map;

    sget-object v3, Ljava/util/Locale;->ENGLISH:Ljava/util/Locale;

    invoke-virtual {v0, v3}, Ljava/lang/String;->toUpperCase(Ljava/util/Locale;)Ljava/lang/String;

    move-result-object v3

    invoke-interface {v1, v3, v0}, Ljava/util/Map;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    .line 206
    const/4 v1, 0x1

    const-string v3, "AUTH="

    move v4, v2

    invoke-virtual/range {v0 .. v5}, Ljava/lang/String;->regionMatches(ZILjava/lang/String;II)Z

    move-result v1

    if-eqz v1, :cond_0

    .line 207
    iget-object v1, p0, Lcom/sun/mail/imap/protocol/IMAPProtocol;->authmechs:Ljava/util/List;

    invoke-virtual {v0, v5}, Ljava/lang/String;->substring(I)Ljava/lang/String;

    move-result-object v3

    invoke-interface {v1, v3}, Ljava/util/List;->add(Ljava/lang/Object;)Z

    .line 208
    iget-boolean v1, p0, Lcom/sun/mail/imap/protocol/IMAPProtocol;->debug:Z

    if-eqz v1, :cond_0

    .line 209
    iget-object v1, p0, Lcom/sun/mail/imap/protocol/IMAPProtocol;->out:Ljava/io/PrintStream;

    new-instance v3, Ljava/lang/StringBuilder;

    const-string v4, "IMAP DEBUG: AUTH: "

    invoke-direct {v3, v4}, Ljava/lang/StringBuilder;-><init>(Ljava/lang/String;)V

    invoke-virtual {v0, v5}, Ljava/lang/String;->substring(I)Ljava/lang/String;

    move-result-object v0

    invoke-virtual {v3, v0}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-virtual {v0}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v0

    invoke-virtual {v1, v0}, Ljava/io/PrintStream;->println(Ljava/lang/String;)V

    goto :goto_0
.end method

.method public peekBody(ILjava/lang/String;)Lcom/sun/mail/imap/protocol/BODY;
    .locals 1
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Lcom/sun/mail/iap/ProtocolException;
        }
    .end annotation

    .prologue
    .line 1025
    const/4 v0, 0x1

    invoke-virtual {p0, p1, p2, v0}, Lcom/sun/mail/imap/protocol/IMAPProtocol;->fetchBody(ILjava/lang/String;Z)Lcom/sun/mail/imap/protocol/BODY;

    move-result-object v0

    return-object v0
.end method

.method public peekBody(ILjava/lang/String;II)Lcom/sun/mail/imap/protocol/BODY;
    .locals 7
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Lcom/sun/mail/iap/ProtocolException;
        }
    .end annotation

    .prologue
    .line 1065
    const/4 v5, 0x1

    const/4 v6, 0x0

    move-object v0, p0

    move v1, p1

    move-object v2, p2

    move v3, p3

    move v4, p4

    invoke-virtual/range {v0 .. v6}, Lcom/sun/mail/imap/protocol/IMAPProtocol;->fetchBody(ILjava/lang/String;IIZLcom/sun/mail/iap/ByteArray;)Lcom/sun/mail/imap/protocol/BODY;

    move-result-object v0

    return-object v0
.end method

.method public peekBody(ILjava/lang/String;IILcom/sun/mail/iap/ByteArray;)Lcom/sun/mail/imap/protocol/BODY;
    .locals 7
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Lcom/sun/mail/iap/ProtocolException;
        }
    .end annotation

    .prologue
    .line 1081
    const/4 v5, 0x1

    move-object v0, p0

    move v1, p1

    move-object v2, p2

    move v3, p3

    move v4, p4

    move-object v6, p5

    invoke-virtual/range {v0 .. v6}, Lcom/sun/mail/imap/protocol/IMAPProtocol;->fetchBody(ILjava/lang/String;IIZLcom/sun/mail/iap/ByteArray;)Lcom/sun/mail/imap/protocol/BODY;

    move-result-object v0

    return-object v0
.end method

.method protected processGreeting(Lcom/sun/mail/iap/Response;)V
    .locals 2
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Lcom/sun/mail/iap/ProtocolException;
        }
    .end annotation

    .prologue
    .line 219
    invoke-super {p0, p1}, Lcom/sun/mail/iap/Protocol;->processGreeting(Lcom/sun/mail/iap/Response;)V

    .line 220
    invoke-virtual {p1}, Lcom/sun/mail/iap/Response;->isOK()Z

    move-result v0

    if-eqz v0, :cond_0

    .line 221
    invoke-virtual {p0, p1}, Lcom/sun/mail/imap/protocol/IMAPProtocol;->setCapabilities(Lcom/sun/mail/iap/Response;)V

    .line 231
    :goto_0
    return-void

    :cond_0
    move-object v0, p1

    .line 225
    check-cast v0, Lcom/sun/mail/imap/protocol/IMAPResponse;

    .line 226
    const-string v1, "PREAUTH"

    invoke-virtual {v0, v1}, Lcom/sun/mail/imap/protocol/IMAPResponse;->keyEquals(Ljava/lang/String;)Z

    move-result v0

    if-eqz v0, :cond_1

    .line 227
    const/4 v0, 0x1

    iput-boolean v0, p0, Lcom/sun/mail/imap/protocol/IMAPProtocol;->authenticated:Z

    .line 228
    invoke-virtual {p0, p1}, Lcom/sun/mail/imap/protocol/IMAPProtocol;->setCapabilities(Lcom/sun/mail/iap/Response;)V

    goto :goto_0

    .line 230
    :cond_1
    new-instance v0, Lcom/sun/mail/iap/ConnectionException;

    invoke-direct {v0, p0, p1}, Lcom/sun/mail/iap/ConnectionException;-><init>(Lcom/sun/mail/iap/Protocol;Lcom/sun/mail/iap/Response;)V

    throw v0
.end method

.method public processIdleResponse(Lcom/sun/mail/iap/Response;)Z
    .locals 5
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Lcom/sun/mail/iap/ProtocolException;
        }
    .end annotation

    .prologue
    const/4 v2, 0x0

    const/4 v1, 0x1

    .line 2063
    new-array v0, v1, [Lcom/sun/mail/iap/Response;

    .line 2064
    aput-object p1, v0, v2

    .line 2066
    invoke-virtual {p0, v0}, Lcom/sun/mail/imap/protocol/IMAPProtocol;->notifyResponseHandlers([Lcom/sun/mail/iap/Response;)V

    .line 2068
    invoke-virtual {p1}, Lcom/sun/mail/iap/Response;->isBYE()Z

    move-result v0

    if-eqz v0, :cond_3

    move v0, v1

    .line 2072
    :goto_0
    invoke-virtual {p1}, Lcom/sun/mail/iap/Response;->isTagged()Z

    move-result v3

    if-eqz v3, :cond_0

    invoke-virtual {p1}, Lcom/sun/mail/iap/Response;->getTag()Ljava/lang/String;

    move-result-object v3

    iget-object v4, p0, Lcom/sun/mail/imap/protocol/IMAPProtocol;->idleTag:Ljava/lang/String;

    invoke-virtual {v3, v4}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v3

    if-eqz v3, :cond_0

    move v0, v1

    .line 2075
    :cond_0
    if-eqz v0, :cond_1

    .line 2076
    const/4 v3, 0x0

    iput-object v3, p0, Lcom/sun/mail/imap/protocol/IMAPProtocol;->idleTag:Ljava/lang/String;

    .line 2078
    :cond_1
    invoke-virtual {p0, p1}, Lcom/sun/mail/imap/protocol/IMAPProtocol;->handleResult(Lcom/sun/mail/iap/Response;)V

    .line 2079
    if-eqz v0, :cond_2

    :goto_1
    return v2

    :cond_2
    move v2, v1

    goto :goto_1

    :cond_3
    move v0, v2

    goto :goto_0
.end method

.method public proxyauth(Ljava/lang/String;)V
    .locals 2
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Lcom/sun/mail/iap/ProtocolException;
        }
    .end annotation

    .prologue
    .line 597
    new-instance v0, Lcom/sun/mail/iap/Argument;

    invoke-direct {v0}, Lcom/sun/mail/iap/Argument;-><init>()V

    .line 598
    invoke-virtual {v0, p1}, Lcom/sun/mail/iap/Argument;->writeString(Ljava/lang/String;)V

    .line 600
    const-string v1, "PROXYAUTH"

    invoke-virtual {p0, v1, v0}, Lcom/sun/mail/imap/protocol/IMAPProtocol;->simpleCommand(Ljava/lang/String;Lcom/sun/mail/iap/Argument;)V

    .line 601
    return-void
.end method

.method public declared-synchronized readIdleResponse()Lcom/sun/mail/iap/Response;
    .locals 1

    .prologue
    .line 2040
    monitor-enter p0

    :try_start_0
    iget-object v0, p0, Lcom/sun/mail/imap/protocol/IMAPProtocol;->idleTag:Ljava/lang/String;
    :try_end_0
    .catchall {:try_start_0 .. :try_end_0} :catchall_0

    if-nez v0, :cond_0

    .line 2041
    const/4 v0, 0x0

    .line 2052
    :goto_0
    monitor-exit p0

    return-object v0

    .line 2044
    :cond_0
    :try_start_1
    invoke-virtual {p0}, Lcom/sun/mail/imap/protocol/IMAPProtocol;->readResponse()Lcom/sun/mail/iap/Response;
    :try_end_1
    .catch Ljava/io/IOException; {:try_start_1 .. :try_end_1} :catch_0
    .catch Lcom/sun/mail/iap/ProtocolException; {:try_start_1 .. :try_end_1} :catch_1
    .catchall {:try_start_1 .. :try_end_1} :catchall_0

    move-result-object v0

    goto :goto_0

    .line 2045
    :catch_0
    move-exception v0

    .line 2047
    :try_start_2
    invoke-static {v0}, Lcom/sun/mail/iap/Response;->byeResponse(Ljava/lang/Exception;)Lcom/sun/mail/iap/Response;

    move-result-object v0

    goto :goto_0

    .line 2048
    :catch_1
    move-exception v0

    .line 2050
    invoke-static {v0}, Lcom/sun/mail/iap/Response;->byeResponse(Ljava/lang/Exception;)Lcom/sun/mail/iap/Response;
    :try_end_2
    .catchall {:try_start_2 .. :try_end_2} :catchall_0

    move-result-object v0

    goto :goto_0

    .line 2040
    :catchall_0
    move-exception v0

    monitor-exit p0

    throw v0
.end method

.method public readResponse()Lcom/sun/mail/iap/Response;
    .locals 1
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljava/io/IOException;,
            Lcom/sun/mail/iap/ProtocolException;
        }
    .end annotation

    .prologue
    .line 261
    invoke-static {p0}, Lcom/sun/mail/imap/protocol/IMAPResponse;->readResponse(Lcom/sun/mail/iap/Protocol;)Lcom/sun/mail/imap/protocol/IMAPResponse;

    move-result-object v0

    return-object v0
.end method

.method public rename(Ljava/lang/String;Ljava/lang/String;)V
    .locals 3
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Lcom/sun/mail/iap/ProtocolException;
        }
    .end annotation

    .prologue
    .line 776
    invoke-static {p1}, Lcom/sun/mail/imap/protocol/BASE64MailboxEncoder;->encode(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v0

    .line 777
    invoke-static {p2}, Lcom/sun/mail/imap/protocol/BASE64MailboxEncoder;->encode(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v1

    .line 779
    new-instance v2, Lcom/sun/mail/iap/Argument;

    invoke-direct {v2}, Lcom/sun/mail/iap/Argument;-><init>()V

    .line 780
    invoke-virtual {v2, v0}, Lcom/sun/mail/iap/Argument;->writeString(Ljava/lang/String;)V

    .line 781
    invoke-virtual {v2, v1}, Lcom/sun/mail/iap/Argument;->writeString(Ljava/lang/String;)V

    .line 783
    const-string v0, "RENAME"

    invoke-virtual {p0, v0, v2}, Lcom/sun/mail/imap/protocol/IMAPProtocol;->simpleCommand(Ljava/lang/String;Lcom/sun/mail/iap/Argument;)V

    .line 784
    return-void
.end method

.method public sasllogin([Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;)V
    .locals 7
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Lcom/sun/mail/iap/ProtocolException;
        }
    .end annotation

    .prologue
    const/4 v6, 0x1

    const/4 v1, 0x0

    .line 539
    iget-object v0, p0, Lcom/sun/mail/imap/protocol/IMAPProtocol;->saslAuthenticator:Lcom/sun/mail/imap/protocol/SaslAuthenticator;

    if-nez v0, :cond_0

    .line 542
    :try_start_0
    const-string v0, "com.sun.mail.imap.protocol.IMAPSaslAuthenticator"

    .line 541
    invoke-static {v0}, Ljava/lang/Class;->forName(Ljava/lang/String;)Ljava/lang/Class;

    move-result-object v0

    .line 543
    const/4 v2, 0x6

    new-array v2, v2, [Ljava/lang/Class;

    const/4 v3, 0x0

    .line 544
    const-class v4, Lcom/sun/mail/imap/protocol/IMAPProtocol;

    aput-object v4, v2, v3

    const/4 v3, 0x1

    .line 545
    const-class v4, Ljava/lang/String;

    aput-object v4, v2, v3

    const/4 v3, 0x2

    .line 546
    const-class v4, Ljava/util/Properties;

    aput-object v4, v2, v3

    const/4 v3, 0x3

    .line 547
    sget-object v4, Ljava/lang/Boolean;->TYPE:Ljava/lang/Class;

    aput-object v4, v2, v3

    const/4 v3, 0x4

    .line 548
    const-class v4, Ljava/io/PrintStream;

    aput-object v4, v2, v3

    const/4 v3, 0x5

    .line 549
    const-class v4, Ljava/lang/String;

    aput-object v4, v2, v3

    .line 543
    invoke-virtual {v0, v2}, Ljava/lang/Class;->getConstructor([Ljava/lang/Class;)Ljava/lang/reflect/Constructor;

    move-result-object v2

    .line 552
    const/4 v0, 0x6

    new-array v3, v0, [Ljava/lang/Object;

    const/4 v0, 0x0

    .line 553
    aput-object p0, v3, v0

    const/4 v0, 0x1

    .line 554
    iget-object v4, p0, Lcom/sun/mail/imap/protocol/IMAPProtocol;->name:Ljava/lang/String;

    aput-object v4, v3, v0

    const/4 v0, 0x2

    .line 555
    iget-object v4, p0, Lcom/sun/mail/imap/protocol/IMAPProtocol;->props:Ljava/util/Properties;

    aput-object v4, v3, v0

    const/4 v4, 0x3

    .line 556
    iget-boolean v0, p0, Lcom/sun/mail/imap/protocol/IMAPProtocol;->debug:Z

    if-eqz v0, :cond_2

    sget-object v0, Ljava/lang/Boolean;->TRUE:Ljava/lang/Boolean;

    :goto_0
    aput-object v0, v3, v4

    const/4 v0, 0x4

    .line 557
    iget-object v4, p0, Lcom/sun/mail/imap/protocol/IMAPProtocol;->out:Ljava/io/PrintStream;

    aput-object v4, v3, v0

    const/4 v0, 0x5

    .line 558
    iget-object v4, p0, Lcom/sun/mail/imap/protocol/IMAPProtocol;->host:Ljava/lang/String;

    aput-object v4, v3, v0

    .line 551
    invoke-virtual {v2, v3}, Ljava/lang/reflect/Constructor;->newInstance([Ljava/lang/Object;)Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Lcom/sun/mail/imap/protocol/SaslAuthenticator;

    iput-object v0, p0, Lcom/sun/mail/imap/protocol/IMAPProtocol;->saslAuthenticator:Lcom/sun/mail/imap/protocol/SaslAuthenticator;
    :try_end_0
    .catch Ljava/lang/Exception; {:try_start_0 .. :try_end_0} :catch_0

    .line 571
    :cond_0
    if-eqz p1, :cond_5

    array-length v0, p1

    if-lez v0, :cond_5

    .line 573
    new-instance v2, Ljava/util/ArrayList;

    array-length v0, p1

    invoke-direct {v2, v0}, Ljava/util/ArrayList;-><init>(I)V

    move v0, v1

    .line 574
    :goto_1
    array-length v1, p1

    if-lt v0, v1, :cond_3

    move-object v0, v2

    .line 581
    :goto_2
    invoke-interface {v0}, Ljava/util/List;->size()I

    move-result v1

    new-array v1, v1, [Ljava/lang/String;

    invoke-interface {v0, v1}, Ljava/util/List;->toArray([Ljava/lang/Object;)[Ljava/lang/Object;

    move-result-object v1

    check-cast v1, [Ljava/lang/String;

    .line 582
    iget-object v0, p0, Lcom/sun/mail/imap/protocol/IMAPProtocol;->saslAuthenticator:Lcom/sun/mail/imap/protocol/SaslAuthenticator;

    move-object v2, p2

    move-object v3, p3

    move-object v4, p4

    move-object v5, p5

    invoke-interface/range {v0 .. v5}, Lcom/sun/mail/imap/protocol/SaslAuthenticator;->authenticate([Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;)Z

    move-result v0

    if-eqz v0, :cond_1

    .line 583
    iput-boolean v6, p0, Lcom/sun/mail/imap/protocol/IMAPProtocol;->authenticated:Z

    .line 584
    :cond_1
    :goto_3
    return-void

    .line 556
    :cond_2
    :try_start_1
    sget-object v0, Ljava/lang/Boolean;->FALSE:Ljava/lang/Boolean;
    :try_end_1
    .catch Ljava/lang/Exception; {:try_start_1 .. :try_end_1} :catch_0

    goto :goto_0

    .line 560
    :catch_0
    move-exception v0

    .line 561
    iget-boolean v1, p0, Lcom/sun/mail/imap/protocol/IMAPProtocol;->debug:Z

    if-eqz v1, :cond_1

    .line 562
    iget-object v1, p0, Lcom/sun/mail/imap/protocol/IMAPProtocol;->out:Ljava/io/PrintStream;

    new-instance v2, Ljava/lang/StringBuilder;

    const-string v3, "IMAP DEBUG: Can\'t load SASL authenticator: "

    invoke-direct {v2, v3}, Ljava/lang/StringBuilder;-><init>(Ljava/lang/String;)V

    .line 563
    invoke-virtual {v2, v0}, Ljava/lang/StringBuilder;->append(Ljava/lang/Object;)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-virtual {v0}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v0

    .line 562
    invoke-virtual {v1, v0}, Ljava/io/PrintStream;->println(Ljava/lang/String;)V

    goto :goto_3

    .line 575
    :cond_3
    iget-object v1, p0, Lcom/sun/mail/imap/protocol/IMAPProtocol;->authmechs:Ljava/util/List;

    aget-object v3, p1, v0

    invoke-interface {v1, v3}, Ljava/util/List;->contains(Ljava/lang/Object;)Z

    move-result v1

    if-eqz v1, :cond_4

    .line 576
    aget-object v1, p1, v0

    invoke-interface {v2, v1}, Ljava/util/List;->add(Ljava/lang/Object;)Z

    .line 574
    :cond_4
    add-int/lit8 v0, v0, 0x1

    goto :goto_1

    .line 579
    :cond_5
    iget-object v0, p0, Lcom/sun/mail/imap/protocol/IMAPProtocol;->authmechs:Ljava/util/List;

    goto :goto_2
.end method

.method public search(Ljavax/mail/search/SearchTerm;)[I
    .locals 1
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Lcom/sun/mail/iap/ProtocolException;,
            Ljavax/mail/search/SearchException;
        }
    .end annotation

    .prologue
    .line 1445
    const-string v0, "ALL"

    invoke-direct {p0, v0, p1}, Lcom/sun/mail/imap/protocol/IMAPProtocol;->search(Ljava/lang/String;Ljavax/mail/search/SearchTerm;)[I

    move-result-object v0

    return-object v0
.end method

.method public search([Lcom/sun/mail/imap/protocol/MessageSet;Ljavax/mail/search/SearchTerm;)[I
    .locals 1
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Lcom/sun/mail/iap/ProtocolException;,
            Ljavax/mail/search/SearchException;
        }
    .end annotation

    .prologue
    .line 1432
    invoke-static {p1}, Lcom/sun/mail/imap/protocol/MessageSet;->toString([Lcom/sun/mail/imap/protocol/MessageSet;)Ljava/lang/String;

    move-result-object v0

    invoke-direct {p0, v0, p2}, Lcom/sun/mail/imap/protocol/IMAPProtocol;->search(Ljava/lang/String;Ljavax/mail/search/SearchTerm;)[I

    move-result-object v0

    return-object v0
.end method

.method public select(Ljava/lang/String;)Lcom/sun/mail/imap/protocol/MailboxInfo;
    .locals 4
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Lcom/sun/mail/iap/ProtocolException;
        }
    .end annotation

    .prologue
    .line 632
    invoke-static {p1}, Lcom/sun/mail/imap/protocol/BASE64MailboxEncoder;->encode(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v0

    .line 634
    new-instance v1, Lcom/sun/mail/iap/Argument;

    invoke-direct {v1}, Lcom/sun/mail/iap/Argument;-><init>()V

    .line 635
    invoke-virtual {v1, v0}, Lcom/sun/mail/iap/Argument;->writeString(Ljava/lang/String;)V

    .line 637
    const-string v0, "SELECT"

    invoke-virtual {p0, v0, v1}, Lcom/sun/mail/imap/protocol/IMAPProtocol;->command(Ljava/lang/String;Lcom/sun/mail/iap/Argument;)[Lcom/sun/mail/iap/Response;

    move-result-object v0

    .line 641
    new-instance v1, Lcom/sun/mail/imap/protocol/MailboxInfo;

    invoke-direct {v1, v0}, Lcom/sun/mail/imap/protocol/MailboxInfo;-><init>([Lcom/sun/mail/iap/Response;)V

    .line 644
    invoke-virtual {p0, v0}, Lcom/sun/mail/imap/protocol/IMAPProtocol;->notifyResponseHandlers([Lcom/sun/mail/iap/Response;)V

    .line 646
    array-length v2, v0

    add-int/lit8 v2, v2, -0x1

    aget-object v0, v0, v2

    .line 648
    invoke-virtual {v0}, Lcom/sun/mail/iap/Response;->isOK()Z

    move-result v2

    if-eqz v2, :cond_0

    .line 649
    invoke-virtual {v0}, Lcom/sun/mail/iap/Response;->toString()Ljava/lang/String;

    move-result-object v2

    const-string v3, "READ-ONLY"

    invoke-virtual {v2, v3}, Ljava/lang/String;->indexOf(Ljava/lang/String;)I

    move-result v2

    const/4 v3, -0x1

    if-eq v2, v3, :cond_1

    .line 650
    const/4 v2, 0x1

    iput v2, v1, Lcom/sun/mail/imap/protocol/MailboxInfo;->mode:I

    .line 655
    :cond_0
    :goto_0
    invoke-virtual {p0, v0}, Lcom/sun/mail/imap/protocol/IMAPProtocol;->handleResult(Lcom/sun/mail/iap/Response;)V

    .line 656
    return-object v1

    .line 652
    :cond_1
    const/4 v2, 0x2

    iput v2, v1, Lcom/sun/mail/imap/protocol/MailboxInfo;->mode:I

    goto :goto_0
.end method

.method public setACL(Ljava/lang/String;CLcom/sun/mail/imap/ACL;)V
    .locals 4
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Lcom/sun/mail/iap/ProtocolException;
        }
    .end annotation

    .prologue
    .line 1794
    const-string v0, "ACL"

    invoke-virtual {p0, v0}, Lcom/sun/mail/imap/protocol/IMAPProtocol;->hasCapability(Ljava/lang/String;)Z

    move-result v0

    if-nez v0, :cond_0

    .line 1795
    new-instance v0, Lcom/sun/mail/iap/BadCommandException;

    const-string v1, "ACL not supported"

    invoke-direct {v0, v1}, Lcom/sun/mail/iap/BadCommandException;-><init>(Ljava/lang/String;)V

    throw v0

    .line 1798
    :cond_0
    invoke-static {p1}, Lcom/sun/mail/imap/protocol/BASE64MailboxEncoder;->encode(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v0

    .line 1800
    new-instance v1, Lcom/sun/mail/iap/Argument;

    invoke-direct {v1}, Lcom/sun/mail/iap/Argument;-><init>()V

    .line 1801
    invoke-virtual {v1, v0}, Lcom/sun/mail/iap/Argument;->writeString(Ljava/lang/String;)V

    .line 1802
    invoke-virtual {p3}, Lcom/sun/mail/imap/ACL;->getName()Ljava/lang/String;

    move-result-object v0

    invoke-virtual {v1, v0}, Lcom/sun/mail/iap/Argument;->writeString(Ljava/lang/String;)V

    .line 1803
    invoke-virtual {p3}, Lcom/sun/mail/imap/ACL;->getRights()Lcom/sun/mail/imap/Rights;

    move-result-object v0

    invoke-virtual {v0}, Lcom/sun/mail/imap/Rights;->toString()Ljava/lang/String;

    move-result-object v0

    .line 1804
    const/16 v2, 0x2b

    if-eq p2, v2, :cond_1

    const/16 v2, 0x2d

    if-ne p2, v2, :cond_2

    .line 1805
    :cond_1
    new-instance v2, Ljava/lang/StringBuilder;

    invoke-static {p2}, Ljava/lang/String;->valueOf(C)Ljava/lang/String;

    move-result-object v3

    invoke-direct {v2, v3}, Ljava/lang/StringBuilder;-><init>(Ljava/lang/String;)V

    invoke-virtual {v2, v0}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-virtual {v0}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v0

    .line 1806
    :cond_2
    invoke-virtual {v1, v0}, Lcom/sun/mail/iap/Argument;->writeString(Ljava/lang/String;)V

    .line 1808
    const-string v0, "SETACL"

    invoke-virtual {p0, v0, v1}, Lcom/sun/mail/imap/protocol/IMAPProtocol;->command(Ljava/lang/String;Lcom/sun/mail/iap/Argument;)[Lcom/sun/mail/iap/Response;

    move-result-object v0

    .line 1809
    array-length v1, v0

    add-int/lit8 v1, v1, -0x1

    aget-object v1, v0, v1

    .line 1812
    invoke-virtual {p0, v0}, Lcom/sun/mail/imap/protocol/IMAPProtocol;->notifyResponseHandlers([Lcom/sun/mail/iap/Response;)V

    .line 1813
    invoke-virtual {p0, v1}, Lcom/sun/mail/imap/protocol/IMAPProtocol;->handleResult(Lcom/sun/mail/iap/Response;)V

    .line 1814
    return-void
.end method

.method protected setCapabilities(Lcom/sun/mail/iap/Response;)V
    .locals 2

    .prologue
    .line 169
    :cond_0
    invoke-virtual {p1}, Lcom/sun/mail/iap/Response;->readByte()B

    move-result v0

    if-lez v0, :cond_1

    const/16 v1, 0x5b

    if-ne v0, v1, :cond_0

    .line 171
    :cond_1
    if-nez v0, :cond_3

    .line 180
    :cond_2
    :goto_0
    return-void

    .line 174
    :cond_3
    invoke-virtual {p1}, Lcom/sun/mail/iap/Response;->readAtom()Ljava/lang/String;

    move-result-object v0

    .line 175
    const-string v1, "CAPABILITY"

    invoke-virtual {v0, v1}, Ljava/lang/String;->equalsIgnoreCase(Ljava/lang/String;)Z

    move-result v0

    if-eqz v0, :cond_2

    .line 177
    new-instance v0, Ljava/util/HashMap;

    const/16 v1, 0xa

    invoke-direct {v0, v1}, Ljava/util/HashMap;-><init>(I)V

    iput-object v0, p0, Lcom/sun/mail/imap/protocol/IMAPProtocol;->capabilities:Ljava/util/Map;

    .line 178
    new-instance v0, Ljava/util/ArrayList;

    const/4 v1, 0x5

    invoke-direct {v0, v1}, Ljava/util/ArrayList;-><init>(I)V

    iput-object v0, p0, Lcom/sun/mail/imap/protocol/IMAPProtocol;->authmechs:Ljava/util/List;

    .line 179
    invoke-virtual {p0, p1}, Lcom/sun/mail/imap/protocol/IMAPProtocol;->parseCapabilities(Lcom/sun/mail/iap/Response;)V

    goto :goto_0
.end method

.method public setQuota(Ljavax/mail/Quota;)V
    .locals 6
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Lcom/sun/mail/iap/ProtocolException;
        }
    .end annotation

    .prologue
    .line 1706
    const-string v0, "QUOTA"

    invoke-virtual {p0, v0}, Lcom/sun/mail/imap/protocol/IMAPProtocol;->hasCapability(Ljava/lang/String;)Z

    move-result v0

    if-nez v0, :cond_0

    .line 1707
    new-instance v0, Lcom/sun/mail/iap/BadCommandException;

    const-string v1, "QUOTA not supported"

    invoke-direct {v0, v1}, Lcom/sun/mail/iap/BadCommandException;-><init>(Ljava/lang/String;)V

    throw v0

    .line 1709
    :cond_0
    new-instance v1, Lcom/sun/mail/iap/Argument;

    invoke-direct {v1}, Lcom/sun/mail/iap/Argument;-><init>()V

    .line 1710
    iget-object v0, p1, Ljavax/mail/Quota;->quotaRoot:Ljava/lang/String;

    invoke-virtual {v1, v0}, Lcom/sun/mail/iap/Argument;->writeString(Ljava/lang/String;)V

    .line 1711
    new-instance v2, Lcom/sun/mail/iap/Argument;

    invoke-direct {v2}, Lcom/sun/mail/iap/Argument;-><init>()V

    .line 1712
    iget-object v0, p1, Ljavax/mail/Quota;->resources:[Ljavax/mail/Quota$Resource;

    if-eqz v0, :cond_1

    .line 1713
    const/4 v0, 0x0

    :goto_0
    iget-object v3, p1, Ljavax/mail/Quota;->resources:[Ljavax/mail/Quota$Resource;

    array-length v3, v3

    if-lt v0, v3, :cond_2

    .line 1718
    :cond_1
    invoke-virtual {v1, v2}, Lcom/sun/mail/iap/Argument;->writeArgument(Lcom/sun/mail/iap/Argument;)V

    .line 1720
    const-string v0, "SETQUOTA"

    invoke-virtual {p0, v0, v1}, Lcom/sun/mail/imap/protocol/IMAPProtocol;->command(Ljava/lang/String;Lcom/sun/mail/iap/Argument;)[Lcom/sun/mail/iap/Response;

    move-result-object v0

    .line 1721
    array-length v1, v0

    add-int/lit8 v1, v1, -0x1

    aget-object v1, v0, v1

    .line 1748
    invoke-virtual {p0, v0}, Lcom/sun/mail/imap/protocol/IMAPProtocol;->notifyResponseHandlers([Lcom/sun/mail/iap/Response;)V

    .line 1749
    invoke-virtual {p0, v1}, Lcom/sun/mail/imap/protocol/IMAPProtocol;->handleResult(Lcom/sun/mail/iap/Response;)V

    .line 1755
    return-void

    .line 1714
    :cond_2
    iget-object v3, p1, Ljavax/mail/Quota;->resources:[Ljavax/mail/Quota$Resource;

    aget-object v3, v3, v0

    iget-object v3, v3, Ljavax/mail/Quota$Resource;->name:Ljava/lang/String;

    invoke-virtual {v2, v3}, Lcom/sun/mail/iap/Argument;->writeAtom(Ljava/lang/String;)V

    .line 1715
    iget-object v3, p1, Ljavax/mail/Quota;->resources:[Ljavax/mail/Quota$Resource;

    aget-object v3, v3, v0

    iget-wide v4, v3, Ljavax/mail/Quota$Resource;->limit:J

    invoke-virtual {v2, v4, v5}, Lcom/sun/mail/iap/Argument;->writeNumber(J)V

    .line 1713
    add-int/lit8 v0, v0, 0x1

    goto :goto_0
.end method

.method public startTLS()V
    .locals 3
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Lcom/sun/mail/iap/ProtocolException;
        }
    .end annotation

    .prologue
    .line 610
    :try_start_0
    const-string v0, "STARTTLS"

    invoke-super {p0, v0}, Lcom/sun/mail/iap/Protocol;->startTLS(Ljava/lang/String;)V
    :try_end_0
    .catch Lcom/sun/mail/iap/ProtocolException; {:try_start_0 .. :try_end_0} :catch_0
    .catch Ljava/lang/Exception; {:try_start_0 .. :try_end_0} :catch_1

    .line 623
    :goto_0
    return-void

    .line 611
    :catch_0
    move-exception v0

    .line 615
    throw v0

    .line 616
    :catch_1
    move-exception v0

    .line 619
    const/4 v1, 0x1

    new-array v1, v1, [Lcom/sun/mail/iap/Response;

    const/4 v2, 0x0

    invoke-static {v0}, Lcom/sun/mail/iap/Response;->byeResponse(Ljava/lang/Exception;)Lcom/sun/mail/iap/Response;

    move-result-object v0

    aput-object v0, v1, v2

    .line 620
    invoke-virtual {p0, v1}, Lcom/sun/mail/imap/protocol/IMAPProtocol;->notifyResponseHandlers([Lcom/sun/mail/iap/Response;)V

    .line 621
    invoke-virtual {p0}, Lcom/sun/mail/imap/protocol/IMAPProtocol;->disconnect()V

    goto :goto_0
.end method

.method public status(Ljava/lang/String;[Ljava/lang/String;)Lcom/sun/mail/imap/protocol/Status;
    .locals 8
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Lcom/sun/mail/iap/ProtocolException;
        }
    .end annotation

    .prologue
    const/4 v2, 0x0

    const/4 v0, 0x0

    .line 692
    invoke-virtual {p0}, Lcom/sun/mail/imap/protocol/IMAPProtocol;->isREV1()Z

    move-result v1

    if-nez v1, :cond_0

    const-string v1, "IMAP4SUNVERSION"

    invoke-virtual {p0, v1}, Lcom/sun/mail/imap/protocol/IMAPProtocol;->hasCapability(Ljava/lang/String;)Z

    move-result v1

    if-nez v1, :cond_0

    .line 695
    new-instance v0, Lcom/sun/mail/iap/BadCommandException;

    const-string v1, "STATUS not supported"

    invoke-direct {v0, v1}, Lcom/sun/mail/iap/BadCommandException;-><init>(Ljava/lang/String;)V

    throw v0

    .line 698
    :cond_0
    invoke-static {p1}, Lcom/sun/mail/imap/protocol/BASE64MailboxEncoder;->encode(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v1

    .line 700
    new-instance v3, Lcom/sun/mail/iap/Argument;

    invoke-direct {v3}, Lcom/sun/mail/iap/Argument;-><init>()V

    .line 701
    invoke-virtual {v3, v1}, Lcom/sun/mail/iap/Argument;->writeString(Ljava/lang/String;)V

    .line 703
    new-instance v4, Lcom/sun/mail/iap/Argument;

    invoke-direct {v4}, Lcom/sun/mail/iap/Argument;-><init>()V

    .line 704
    if-nez p2, :cond_1

    .line 705
    sget-object p2, Lcom/sun/mail/imap/protocol/Status;->standardItems:[Ljava/lang/String;

    .line 707
    :cond_1
    array-length v5, p2

    move v1, v0

    :goto_0
    if-lt v1, v5, :cond_2

    .line 709
    invoke-virtual {v3, v4}, Lcom/sun/mail/iap/Argument;->writeArgument(Lcom/sun/mail/iap/Argument;)V

    .line 711
    const-string v1, "STATUS"

    invoke-virtual {p0, v1, v3}, Lcom/sun/mail/imap/protocol/IMAPProtocol;->command(Ljava/lang/String;Lcom/sun/mail/iap/Argument;)[Lcom/sun/mail/iap/Response;

    move-result-object v4

    .line 714
    array-length v1, v4

    add-int/lit8 v1, v1, -0x1

    aget-object v5, v4, v1

    .line 717
    invoke-virtual {v5}, Lcom/sun/mail/iap/Response;->isOK()Z

    move-result v1

    if-eqz v1, :cond_7

    .line 718
    array-length v6, v4

    move v3, v0

    move-object v1, v2

    :goto_1
    if-lt v3, v6, :cond_3

    .line 734
    :goto_2
    invoke-virtual {p0, v4}, Lcom/sun/mail/imap/protocol/IMAPProtocol;->notifyResponseHandlers([Lcom/sun/mail/iap/Response;)V

    .line 735
    invoke-virtual {p0, v5}, Lcom/sun/mail/imap/protocol/IMAPProtocol;->handleResult(Lcom/sun/mail/iap/Response;)V

    .line 736
    return-object v1

    .line 708
    :cond_2
    aget-object v6, p2, v1

    invoke-virtual {v4, v6}, Lcom/sun/mail/iap/Argument;->writeAtom(Ljava/lang/String;)V

    .line 707
    add-int/lit8 v1, v1, 0x1

    goto :goto_0

    .line 719
    :cond_3
    aget-object v0, v4, v3

    instance-of v0, v0, Lcom/sun/mail/imap/protocol/IMAPResponse;

    if-nez v0, :cond_5

    .line 718
    :cond_4
    :goto_3
    add-int/lit8 v0, v3, 0x1

    move v3, v0

    goto :goto_1

    .line 722
    :cond_5
    aget-object v0, v4, v3

    check-cast v0, Lcom/sun/mail/imap/protocol/IMAPResponse;

    .line 723
    const-string v7, "STATUS"

    invoke-virtual {v0, v7}, Lcom/sun/mail/imap/protocol/IMAPResponse;->keyEquals(Ljava/lang/String;)Z

    move-result v7

    if-eqz v7, :cond_4

    .line 724
    if-nez v1, :cond_6

    .line 725
    new-instance v1, Lcom/sun/mail/imap/protocol/Status;

    invoke-direct {v1, v0}, Lcom/sun/mail/imap/protocol/Status;-><init>(Lcom/sun/mail/iap/Response;)V

    move-object v0, v1

    .line 728
    :goto_4
    aput-object v2, v4, v3

    move-object v1, v0

    goto :goto_3

    .line 727
    :cond_6
    new-instance v7, Lcom/sun/mail/imap/protocol/Status;

    invoke-direct {v7, v0}, Lcom/sun/mail/imap/protocol/Status;-><init>(Lcom/sun/mail/iap/Response;)V

    invoke-static {v1, v7}, Lcom/sun/mail/imap/protocol/Status;->add(Lcom/sun/mail/imap/protocol/Status;Lcom/sun/mail/imap/protocol/Status;)V

    move-object v0, v1

    goto :goto_4

    :cond_7
    move-object v1, v2

    goto :goto_2
.end method

.method public storeFlags(IILjavax/mail/Flags;Z)V
    .locals 2
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Lcom/sun/mail/iap/ProtocolException;
        }
    .end annotation

    .prologue
    .line 1348
    new-instance v0, Ljava/lang/StringBuilder;

    invoke-static {p1}, Ljava/lang/String;->valueOf(I)Ljava/lang/String;

    move-result-object v1

    invoke-static {v1}, Ljava/lang/String;->valueOf(Ljava/lang/Object;)Ljava/lang/String;

    move-result-object v1

    invoke-direct {v0, v1}, Ljava/lang/StringBuilder;-><init>(Ljava/lang/String;)V

    const-string v1, ":"

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-static {p2}, Ljava/lang/String;->valueOf(I)Ljava/lang/String;

    move-result-object v1

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-virtual {v0}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v0

    invoke-direct {p0, v0, p3, p4}, Lcom/sun/mail/imap/protocol/IMAPProtocol;->storeFlags(Ljava/lang/String;Ljavax/mail/Flags;Z)V

    .line 1350
    return-void
.end method

.method public storeFlags(ILjavax/mail/Flags;Z)V
    .locals 1
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Lcom/sun/mail/iap/ProtocolException;
        }
    .end annotation

    .prologue
    .line 1357
    invoke-static {p1}, Ljava/lang/String;->valueOf(I)Ljava/lang/String;

    move-result-object v0

    invoke-direct {p0, v0, p2, p3}, Lcom/sun/mail/imap/protocol/IMAPProtocol;->storeFlags(Ljava/lang/String;Ljavax/mail/Flags;Z)V

    .line 1358
    return-void
.end method

.method public storeFlags([Lcom/sun/mail/imap/protocol/MessageSet;Ljavax/mail/Flags;Z)V
    .locals 1
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Lcom/sun/mail/iap/ProtocolException;
        }
    .end annotation

    .prologue
    .line 1343
    invoke-static {p1}, Lcom/sun/mail/imap/protocol/MessageSet;->toString([Lcom/sun/mail/imap/protocol/MessageSet;)Ljava/lang/String;

    move-result-object v0

    invoke-direct {p0, v0, p2, p3}, Lcom/sun/mail/imap/protocol/IMAPProtocol;->storeFlags(Ljava/lang/String;Ljavax/mail/Flags;Z)V

    .line 1344
    return-void
.end method

.method public subscribe(Ljava/lang/String;)V
    .locals 2
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Lcom/sun/mail/iap/ProtocolException;
        }
    .end annotation

    .prologue
    .line 792
    new-instance v0, Lcom/sun/mail/iap/Argument;

    invoke-direct {v0}, Lcom/sun/mail/iap/Argument;-><init>()V

    .line 794
    invoke-static {p1}, Lcom/sun/mail/imap/protocol/BASE64MailboxEncoder;->encode(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v1

    .line 795
    invoke-virtual {v0, v1}, Lcom/sun/mail/iap/Argument;->writeString(Ljava/lang/String;)V

    .line 797
    const-string v1, "SUBSCRIBE"

    invoke-virtual {p0, v1, v0}, Lcom/sun/mail/imap/protocol/IMAPProtocol;->simpleCommand(Ljava/lang/String;Lcom/sun/mail/iap/Argument;)V

    .line 798
    return-void
.end method

.method protected supportsNonSyncLiterals()Z
    .locals 1

    .prologue
    .line 252
    const-string v0, "LITERAL+"

    invoke-virtual {p0, v0}, Lcom/sun/mail/imap/protocol/IMAPProtocol;->hasCapability(Ljava/lang/String;)Z

    move-result v0

    return v0
.end method

.method public uidexpunge([Lcom/sun/mail/imap/protocol/UIDSet;)V
    .locals 2
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Lcom/sun/mail/iap/ProtocolException;
        }
    .end annotation

    .prologue
    .line 994
    const-string v0, "UIDPLUS"

    invoke-virtual {p0, v0}, Lcom/sun/mail/imap/protocol/IMAPProtocol;->hasCapability(Ljava/lang/String;)Z

    move-result v0

    if-nez v0, :cond_0

    .line 995
    new-instance v0, Lcom/sun/mail/iap/BadCommandException;

    const-string v1, "UID EXPUNGE not supported"

    invoke-direct {v0, v1}, Lcom/sun/mail/iap/BadCommandException;-><init>(Ljava/lang/String;)V

    throw v0

    .line 996
    :cond_0
    new-instance v0, Ljava/lang/StringBuilder;

    const-string v1, "UID EXPUNGE "

    invoke-direct {v0, v1}, Ljava/lang/StringBuilder;-><init>(Ljava/lang/String;)V

    invoke-static {p1}, Lcom/sun/mail/imap/protocol/UIDSet;->toString([Lcom/sun/mail/imap/protocol/UIDSet;)Ljava/lang/String;

    move-result-object v1

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-virtual {v0}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v0

    const/4 v1, 0x0

    invoke-virtual {p0, v0, v1}, Lcom/sun/mail/imap/protocol/IMAPProtocol;->simpleCommand(Ljava/lang/String;Lcom/sun/mail/iap/Argument;)V

    .line 997
    return-void
.end method

.method public unsubscribe(Ljava/lang/String;)V
    .locals 2
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Lcom/sun/mail/iap/ProtocolException;
        }
    .end annotation

    .prologue
    .line 806
    new-instance v0, Lcom/sun/mail/iap/Argument;

    invoke-direct {v0}, Lcom/sun/mail/iap/Argument;-><init>()V

    .line 808
    invoke-static {p1}, Lcom/sun/mail/imap/protocol/BASE64MailboxEncoder;->encode(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v1

    .line 809
    invoke-virtual {v0, v1}, Lcom/sun/mail/iap/Argument;->writeString(Ljava/lang/String;)V

    .line 811
    const-string v1, "UNSUBSCRIBE"

    invoke-virtual {p0, v1, v0}, Lcom/sun/mail/imap/protocol/IMAPProtocol;->simpleCommand(Ljava/lang/String;Lcom/sun/mail/iap/Argument;)V

    .line 812
    return-void
.end method
