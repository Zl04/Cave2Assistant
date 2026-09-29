.class public Lcom/sun/mail/smtp/SMTPTransport;
.super Ljavax/mail/Transport;
.source "SourceFile"


# static fields
.field static final synthetic $assertionsDisabled:Z

.field private static final CRLF:[B

.field private static final UNKNOWN:Ljava/lang/String; = "UNKNOWN"

.field private static hexchar:[C

.field private static final ignoreList:[Ljava/lang/String;


# instance fields
.field private addresses:[Ljavax/mail/Address;

.field private dataStream:Lcom/sun/mail/smtp/SMTPOutputStream;

.field private defaultPort:I

.field private exception:Ljavax/mail/MessagingException;

.field private extMap:Ljava/util/Hashtable;

.field private invalidAddr:[Ljavax/mail/Address;

.field private isSSL:Z

.field private lastReturnCode:I

.field private lastServerResponse:Ljava/lang/String;

.field private lineInputStream:Lcom/sun/mail/util/LineInputStream;

.field private localHostName:Ljava/lang/String;

.field private md5support:Lcom/sun/mail/smtp/DigestMD5;

.field private message:Ljavax/mail/internet/MimeMessage;

.field private name:Ljava/lang/String;

.field private out:Ljava/io/PrintStream;

.field private quitWait:Z

.field private reportSuccess:Z

.field private saslRealm:Ljava/lang/String;

.field private sendPartiallyFailed:Z

.field private serverInput:Ljava/io/BufferedInputStream;

.field private serverOutput:Ljava/io/OutputStream;

.field private serverSocket:Ljava/net/Socket;

.field private useRset:Z

.field private useStartTLS:Z

.field private validSentAddr:[Ljavax/mail/Address;

.field private validUnsentAddr:[Ljavax/mail/Address;


# direct methods
.method static constructor <clinit>()V
    .locals 5

    .prologue
    const/4 v4, 0x2

    const/4 v1, 0x1

    const/4 v2, 0x0

    .line 85
    const-class v0, Lcom/sun/mail/smtp/SMTPTransport;

    invoke-virtual {v0}, Ljava/lang/Class;->desiredAssertionStatus()Z

    move-result v0

    if-nez v0, :cond_0

    move v0, v1

    :goto_0
    sput-boolean v0, Lcom/sun/mail/smtp/SMTPTransport;->$assertionsDisabled:Z

    .line 119
    new-array v0, v4, [Ljava/lang/String;

    const-string v3, "Bcc"

    aput-object v3, v0, v2

    const-string v2, "Content-Length"

    aput-object v2, v0, v1

    sput-object v0, Lcom/sun/mail/smtp/SMTPTransport;->ignoreList:[Ljava/lang/String;

    .line 120
    new-array v0, v4, [B

    fill-array-data v0, :array_0

    sput-object v0, Lcom/sun/mail/smtp/SMTPTransport;->CRLF:[B

    .line 1737
    const/16 v0, 0x10

    new-array v0, v0, [C

    fill-array-data v0, :array_1

    sput-object v0, Lcom/sun/mail/smtp/SMTPTransport;->hexchar:[C

    return-void

    :cond_0
    move v0, v2

    .line 85
    goto :goto_0

    .line 120
    nop

    :array_0
    .array-data 1
        0xdt
        0xat
    .end array-data

    .line 1737
    nop

    :array_1
    .array-data 2
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
        0x41s
        0x42s
        0x43s
        0x44s
        0x45s
        0x46s
    .end array-data
.end method

.method public constructor <init>(Ljavax/mail/Session;Ljavax/mail/URLName;)V
    .locals 6

    .prologue
    .line 128
    const-string v3, "smtp"

    const/16 v4, 0x19

    const/4 v5, 0x0

    move-object v0, p0

    move-object v1, p1

    move-object v2, p2

    invoke-direct/range {v0 .. v5}, Lcom/sun/mail/smtp/SMTPTransport;-><init>(Ljavax/mail/Session;Ljavax/mail/URLName;Ljava/lang/String;IZ)V

    .line 129
    return-void
.end method

.method protected constructor <init>(Ljavax/mail/Session;Ljavax/mail/URLName;Ljava/lang/String;IZ)V
    .locals 4

    .prologue
    const/4 v2, 0x1

    const/4 v1, 0x0

    .line 136
    invoke-direct {p0, p1, p2}, Ljavax/mail/Transport;-><init>(Ljavax/mail/Session;Ljavax/mail/URLName;)V

    .line 87
    const-string v0, "smtp"

    iput-object v0, p0, Lcom/sun/mail/smtp/SMTPTransport;->name:Ljava/lang/String;

    .line 88
    const/16 v0, 0x19

    iput v0, p0, Lcom/sun/mail/smtp/SMTPTransport;->defaultPort:I

    .line 89
    iput-boolean v1, p0, Lcom/sun/mail/smtp/SMTPTransport;->isSSL:Z

    .line 97
    iput-boolean v1, p0, Lcom/sun/mail/smtp/SMTPTransport;->sendPartiallyFailed:Z

    .line 106
    iput-boolean v1, p0, Lcom/sun/mail/smtp/SMTPTransport;->quitWait:Z

    .line 107
    const-string v0, "UNKNOWN"

    iput-object v0, p0, Lcom/sun/mail/smtp/SMTPTransport;->saslRealm:Ljava/lang/String;

    .line 137
    if-eqz p2, :cond_0

    .line 138
    invoke-virtual {p2}, Ljavax/mail/URLName;->getProtocol()Ljava/lang/String;

    move-result-object p3

    .line 139
    :cond_0
    iput-object p3, p0, Lcom/sun/mail/smtp/SMTPTransport;->name:Ljava/lang/String;

    .line 140
    iput p4, p0, Lcom/sun/mail/smtp/SMTPTransport;->defaultPort:I

    .line 141
    iput-boolean p5, p0, Lcom/sun/mail/smtp/SMTPTransport;->isSSL:Z

    .line 143
    invoke-virtual {p1}, Ljavax/mail/Session;->getDebugOut()Ljava/io/PrintStream;

    move-result-object v0

    iput-object v0, p0, Lcom/sun/mail/smtp/SMTPTransport;->out:Ljava/io/PrintStream;

    .line 147
    new-instance v0, Ljava/lang/StringBuilder;

    const-string v3, "mail."

    invoke-direct {v0, v3}, Ljava/lang/StringBuilder;-><init>(Ljava/lang/String;)V

    invoke-virtual {v0, p3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    const-string v3, ".quitwait"

    invoke-virtual {v0, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-virtual {v0}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v0

    invoke-virtual {p1, v0}, Ljavax/mail/Session;->getProperty(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v0

    .line 148
    if-eqz v0, :cond_1

    const-string v3, "true"

    invoke-virtual {v0, v3}, Ljava/lang/String;->equalsIgnoreCase(Ljava/lang/String;)Z

    move-result v0

    if-nez v0, :cond_1

    move v0, v1

    :goto_0
    iput-boolean v0, p0, Lcom/sun/mail/smtp/SMTPTransport;->quitWait:Z

    .line 151
    new-instance v0, Ljava/lang/StringBuilder;

    const-string v3, "mail."

    invoke-direct {v0, v3}, Ljava/lang/StringBuilder;-><init>(Ljava/lang/String;)V

    invoke-virtual {v0, p3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    const-string v3, ".reportsuccess"

    invoke-virtual {v0, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-virtual {v0}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v0

    invoke-virtual {p1, v0}, Ljavax/mail/Session;->getProperty(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v0

    .line 152
    if-eqz v0, :cond_2

    const-string v3, "true"

    invoke-virtual {v0, v3}, Ljava/lang/String;->equalsIgnoreCase(Ljava/lang/String;)Z

    move-result v0

    if-eqz v0, :cond_2

    move v0, v2

    :goto_1
    iput-boolean v0, p0, Lcom/sun/mail/smtp/SMTPTransport;->reportSuccess:Z

    .line 155
    new-instance v0, Ljava/lang/StringBuilder;

    const-string v3, "mail."

    invoke-direct {v0, v3}, Ljava/lang/StringBuilder;-><init>(Ljava/lang/String;)V

    invoke-virtual {v0, p3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    const-string v3, ".starttls.enable"

    invoke-virtual {v0, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-virtual {v0}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v0

    invoke-virtual {p1, v0}, Ljavax/mail/Session;->getProperty(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v0

    .line 156
    if-eqz v0, :cond_3

    const-string v3, "true"

    invoke-virtual {v0, v3}, Ljava/lang/String;->equalsIgnoreCase(Ljava/lang/String;)Z

    move-result v0

    if-eqz v0, :cond_3

    move v0, v2

    :goto_2
    iput-boolean v0, p0, Lcom/sun/mail/smtp/SMTPTransport;->useStartTLS:Z

    .line 160
    new-instance v0, Ljava/lang/StringBuilder;

    const-string v3, "mail."

    invoke-direct {v0, v3}, Ljava/lang/StringBuilder;-><init>(Ljava/lang/String;)V

    invoke-virtual {v0, p3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    const-string v3, ".userset"

    invoke-virtual {v0, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-virtual {v0}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v0

    invoke-virtual {p1, v0}, Ljavax/mail/Session;->getProperty(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v0

    .line 161
    if-eqz v0, :cond_4

    const-string v3, "true"

    invoke-virtual {v0, v3}, Ljava/lang/String;->equalsIgnoreCase(Ljava/lang/String;)Z

    move-result v0

    if-eqz v0, :cond_4

    :goto_3
    iput-boolean v2, p0, Lcom/sun/mail/smtp/SMTPTransport;->useRset:Z

    .line 162
    return-void

    :cond_1
    move v0, v2

    .line 148
    goto :goto_0

    :cond_2
    move v0, v1

    .line 152
    goto :goto_1

    :cond_3
    move v0, v1

    .line 156
    goto :goto_2

    :cond_4
    move v2, v1

    .line 161
    goto :goto_3
.end method

.method private closeConnection()V
    .locals 4
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljavax/mail/MessagingException;
        }
    .end annotation

    .prologue
    const/4 v3, 0x0

    .line 710
    :try_start_0
    iget-object v0, p0, Lcom/sun/mail/smtp/SMTPTransport;->serverSocket:Ljava/net/Socket;

    if-eqz v0, :cond_0

    .line 711
    iget-object v0, p0, Lcom/sun/mail/smtp/SMTPTransport;->serverSocket:Ljava/net/Socket;

    invoke-virtual {v0}, Ljava/net/Socket;->close()V
    :try_end_0
    .catch Ljava/io/IOException; {:try_start_0 .. :try_end_0} :catch_0
    .catchall {:try_start_0 .. :try_end_0} :catchall_0

    .line 715
    :cond_0
    iput-object v3, p0, Lcom/sun/mail/smtp/SMTPTransport;->serverSocket:Ljava/net/Socket;

    .line 716
    iput-object v3, p0, Lcom/sun/mail/smtp/SMTPTransport;->serverOutput:Ljava/io/OutputStream;

    .line 717
    iput-object v3, p0, Lcom/sun/mail/smtp/SMTPTransport;->serverInput:Ljava/io/BufferedInputStream;

    .line 718
    iput-object v3, p0, Lcom/sun/mail/smtp/SMTPTransport;->lineInputStream:Lcom/sun/mail/util/LineInputStream;

    .line 719
    invoke-super {p0}, Ljavax/mail/Transport;->isConnected()Z

    move-result v0

    if-eqz v0, :cond_1

    .line 720
    invoke-super {p0}, Ljavax/mail/Transport;->close()V

    .line 722
    :cond_1
    return-void

    .line 712
    :catch_0
    move-exception v0

    .line 713
    :try_start_1
    new-instance v1, Ljavax/mail/MessagingException;

    const-string v2, "Server Close Failed"

    invoke-direct {v1, v2, v0}, Ljavax/mail/MessagingException;-><init>(Ljava/lang/String;Ljava/lang/Exception;)V

    throw v1
    :try_end_1
    .catchall {:try_start_1 .. :try_end_1} :catchall_0

    .line 714
    :catchall_0
    move-exception v0

    .line 715
    iput-object v3, p0, Lcom/sun/mail/smtp/SMTPTransport;->serverSocket:Ljava/net/Socket;

    .line 716
    iput-object v3, p0, Lcom/sun/mail/smtp/SMTPTransport;->serverOutput:Ljava/io/OutputStream;

    .line 717
    iput-object v3, p0, Lcom/sun/mail/smtp/SMTPTransport;->serverInput:Ljava/io/BufferedInputStream;

    .line 718
    iput-object v3, p0, Lcom/sun/mail/smtp/SMTPTransport;->lineInputStream:Lcom/sun/mail/util/LineInputStream;

    .line 719
    invoke-super {p0}, Ljavax/mail/Transport;->isConnected()Z

    move-result v1

    if-eqz v1, :cond_2

    .line 720
    invoke-super {p0}, Ljavax/mail/Transport;->close()V

    .line 721
    :cond_2
    throw v0
.end method

.method private convertTo8Bit(Ljavax/mail/internet/MimePart;)Z
    .locals 6

    .prologue
    const/4 v2, 0x1

    const/4 v3, 0x0

    .line 818
    .line 820
    :try_start_0
    const-string v0, "text/*"

    invoke-interface {p1, v0}, Ljavax/mail/internet/MimePart;->isMimeType(Ljava/lang/String;)Z

    move-result v0

    if-eqz v0, :cond_1

    .line 821
    invoke-interface {p1}, Ljavax/mail/internet/MimePart;->getEncoding()Ljava/lang/String;

    move-result-object v0

    .line 822
    if-eqz v0, :cond_4

    const-string v1, "quoted-printable"

    invoke-virtual {v0, v1}, Ljava/lang/String;->equalsIgnoreCase(Ljava/lang/String;)Z

    move-result v1

    if-nez v1, :cond_0

    .line 823
    const-string v1, "base64"

    invoke-virtual {v0, v1}, Ljava/lang/String;->equalsIgnoreCase(Ljava/lang/String;)Z

    move-result v0

    if-eqz v0, :cond_4

    .line 824
    :cond_0
    invoke-interface {p1}, Ljavax/mail/internet/MimePart;->getInputStream()Ljava/io/InputStream;

    move-result-object v0

    .line 825
    invoke-direct {p0, v0}, Lcom/sun/mail/smtp/SMTPTransport;->is8Bit(Ljava/io/InputStream;)Z

    move-result v0

    if-eqz v0, :cond_4

    .line 835
    invoke-interface {p1}, Ljavax/mail/internet/MimePart;->getContent()Ljava/lang/Object;

    move-result-object v0

    .line 836
    invoke-interface {p1}, Ljavax/mail/internet/MimePart;->getContentType()Ljava/lang/String;

    move-result-object v1

    .line 835
    invoke-interface {p1, v0, v1}, Ljavax/mail/internet/MimePart;->setContent(Ljava/lang/Object;Ljava/lang/String;)V

    .line 837
    const-string v0, "Content-Transfer-Encoding"

    const-string v1, "8bit"

    invoke-interface {p1, v0, v1}, Ljavax/mail/internet/MimePart;->setHeader(Ljava/lang/String;Ljava/lang/String;)V

    .line 854
    :goto_0
    return v2

    .line 841
    :cond_1
    const-string v0, "multipart/*"

    invoke-interface {p1, v0}, Ljavax/mail/internet/MimePart;->isMimeType(Ljava/lang/String;)Z

    move-result v0

    if-eqz v0, :cond_4

    .line 842
    invoke-interface {p1}, Ljavax/mail/internet/MimePart;->getContent()Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Ljavax/mail/internet/MimeMultipart;

    .line 843
    invoke-virtual {v0}, Ljavax/mail/internet/MimeMultipart;->getCount()I

    move-result v5

    move v4, v3

    .line 844
    :goto_1
    if-lt v4, v5, :cond_2

    move v2, v3

    goto :goto_0

    .line 845
    :cond_2
    invoke-virtual {v0, v4}, Ljavax/mail/internet/MimeMultipart;->getBodyPart(I)Ljavax/mail/BodyPart;

    move-result-object v1

    check-cast v1, Ljavax/mail/internet/MimePart;

    invoke-direct {p0, v1}, Lcom/sun/mail/smtp/SMTPTransport;->convertTo8Bit(Ljavax/mail/internet/MimePart;)Z
    :try_end_0
    .catch Ljava/io/IOException; {:try_start_0 .. :try_end_0} :catch_1
    .catch Ljavax/mail/MessagingException; {:try_start_0 .. :try_end_0} :catch_0

    move-result v1

    if-eqz v1, :cond_3

    move v1, v2

    .line 844
    :goto_2
    add-int/lit8 v3, v4, 0x1

    move v4, v3

    move v3, v1

    goto :goto_1

    .line 851
    :catch_0
    move-exception v0

    move v2, v3

    goto :goto_0

    .line 849
    :catch_1
    move-exception v0

    move v2, v3

    goto :goto_0

    :cond_3
    move v1, v3

    goto :goto_2

    :cond_4
    move v2, v3

    goto :goto_0
.end method

.method private expandGroups()V
    .locals 7

    .prologue
    const/4 v3, 0x0

    .line 770
    const/4 v1, 0x0

    move v2, v3

    .line 771
    :goto_0
    iget-object v0, p0, Lcom/sun/mail/smtp/SMTPTransport;->addresses:[Ljavax/mail/Address;

    array-length v0, v0

    if-lt v2, v0, :cond_1

    .line 800
    if-eqz v1, :cond_0

    .line 801
    invoke-virtual {v1}, Ljava/util/Vector;->size()I

    move-result v0

    new-array v0, v0, [Ljavax/mail/internet/InternetAddress;

    .line 802
    invoke-virtual {v1, v0}, Ljava/util/Vector;->copyInto([Ljava/lang/Object;)V

    .line 803
    iput-object v0, p0, Lcom/sun/mail/smtp/SMTPTransport;->addresses:[Ljavax/mail/Address;

    .line 805
    :cond_0
    return-void

    .line 772
    :cond_1
    iget-object v0, p0, Lcom/sun/mail/smtp/SMTPTransport;->addresses:[Ljavax/mail/Address;

    aget-object v0, v0, v2

    check-cast v0, Ljavax/mail/internet/InternetAddress;

    .line 773
    invoke-virtual {v0}, Ljavax/mail/internet/InternetAddress;->isGroup()Z

    move-result v4

    if-eqz v4, :cond_6

    .line 774
    if-nez v1, :cond_2

    .line 776
    new-instance v1, Ljava/util/Vector;

    invoke-direct {v1}, Ljava/util/Vector;-><init>()V

    move v4, v3

    .line 777
    :goto_1
    if-lt v4, v2, :cond_3

    .line 782
    :cond_2
    const/4 v4, 0x1

    :try_start_0
    invoke-virtual {v0, v4}, Ljavax/mail/internet/InternetAddress;->getGroup(Z)[Ljavax/mail/internet/InternetAddress;

    move-result-object v5

    .line 783
    if-eqz v5, :cond_5

    move v4, v3

    .line 784
    :goto_2
    array-length v6, v5
    :try_end_0
    .catch Ljavax/mail/internet/ParseException; {:try_start_0 .. :try_end_0} :catch_0

    if-lt v4, v6, :cond_4

    move-object v0, v1

    .line 771
    :goto_3
    add-int/lit8 v1, v2, 0x1

    move v2, v1

    move-object v1, v0

    goto :goto_0

    .line 778
    :cond_3
    iget-object v5, p0, Lcom/sun/mail/smtp/SMTPTransport;->addresses:[Ljavax/mail/Address;

    aget-object v5, v5, v4

    invoke-virtual {v1, v5}, Ljava/util/Vector;->addElement(Ljava/lang/Object;)V

    .line 777
    add-int/lit8 v4, v4, 0x1

    goto :goto_1

    .line 785
    :cond_4
    :try_start_1
    aget-object v6, v5, v4

    invoke-virtual {v1, v6}, Ljava/util/Vector;->addElement(Ljava/lang/Object;)V

    .line 784
    add-int/lit8 v4, v4, 0x1

    goto :goto_2

    .line 787
    :cond_5
    invoke-virtual {v1, v0}, Ljava/util/Vector;->addElement(Ljava/lang/Object;)V
    :try_end_1
    .catch Ljavax/mail/internet/ParseException; {:try_start_1 .. :try_end_1} :catch_0

    move-object v0, v1

    goto :goto_3

    .line 788
    :catch_0
    move-exception v4

    .line 790
    invoke-virtual {v1, v0}, Ljava/util/Vector;->addElement(Ljava/lang/Object;)V

    move-object v0, v1

    goto :goto_3

    .line 794
    :cond_6
    if-eqz v1, :cond_7

    .line 795
    invoke-virtual {v1, v0}, Ljava/util/Vector;->addElement(Ljava/lang/Object;)V

    :cond_7
    move-object v0, v1

    goto :goto_3
.end method

.method private declared-synchronized getMD5()Lcom/sun/mail/smtp/DigestMD5;
    .locals 2

    .prologue
    .line 346
    monitor-enter p0

    :try_start_0
    iget-object v0, p0, Lcom/sun/mail/smtp/SMTPTransport;->md5support:Lcom/sun/mail/smtp/DigestMD5;

    if-nez v0, :cond_0

    .line 347
    new-instance v1, Lcom/sun/mail/smtp/DigestMD5;

    iget-boolean v0, p0, Lcom/sun/mail/smtp/SMTPTransport;->debug:Z

    if-eqz v0, :cond_1

    iget-object v0, p0, Lcom/sun/mail/smtp/SMTPTransport;->out:Ljava/io/PrintStream;

    :goto_0
    invoke-direct {v1, v0}, Lcom/sun/mail/smtp/DigestMD5;-><init>(Ljava/io/PrintStream;)V

    iput-object v1, p0, Lcom/sun/mail/smtp/SMTPTransport;->md5support:Lcom/sun/mail/smtp/DigestMD5;

    .line 348
    :cond_0
    iget-object v0, p0, Lcom/sun/mail/smtp/SMTPTransport;->md5support:Lcom/sun/mail/smtp/DigestMD5;
    :try_end_0
    .catchall {:try_start_0 .. :try_end_0} :catchall_0

    monitor-exit p0

    return-object v0

    .line 347
    :cond_1
    const/4 v0, 0x0

    goto :goto_0

    .line 346
    :catchall_0
    move-exception v0

    monitor-exit p0

    throw v0
.end method

.method private initStreams()V
    .locals 6
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljava/io/IOException;
        }
    .end annotation

    .prologue
    .line 1441
    iget-object v0, p0, Lcom/sun/mail/smtp/SMTPTransport;->session:Ljavax/mail/Session;

    invoke-virtual {v0}, Ljavax/mail/Session;->getProperties()Ljava/util/Properties;

    move-result-object v0

    .line 1442
    iget-object v1, p0, Lcom/sun/mail/smtp/SMTPTransport;->session:Ljavax/mail/Session;

    invoke-virtual {v1}, Ljavax/mail/Session;->getDebugOut()Ljava/io/PrintStream;

    move-result-object v1

    .line 1443
    iget-object v2, p0, Lcom/sun/mail/smtp/SMTPTransport;->session:Ljavax/mail/Session;

    invoke-virtual {v2}, Ljavax/mail/Session;->getDebug()Z

    move-result v2

    .line 1445
    const-string v3, "mail.debug.quote"

    invoke-virtual {v0, v3}, Ljava/util/Properties;->getProperty(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v0

    .line 1446
    if-eqz v0, :cond_0

    const-string v3, "true"

    invoke-virtual {v0, v3}, Ljava/lang/String;->equalsIgnoreCase(Ljava/lang/String;)Z

    move-result v0

    if-eqz v0, :cond_0

    const/4 v0, 0x1

    .line 1449
    :goto_0
    new-instance v3, Lcom/sun/mail/util/TraceInputStream;

    iget-object v4, p0, Lcom/sun/mail/smtp/SMTPTransport;->serverSocket:Ljava/net/Socket;

    invoke-virtual {v4}, Ljava/net/Socket;->getInputStream()Ljava/io/InputStream;

    move-result-object v4

    invoke-direct {v3, v4, v1}, Lcom/sun/mail/util/TraceInputStream;-><init>(Ljava/io/InputStream;Ljava/io/OutputStream;)V

    .line 1450
    invoke-virtual {v3, v2}, Lcom/sun/mail/util/TraceInputStream;->setTrace(Z)V

    .line 1451
    invoke-virtual {v3, v0}, Lcom/sun/mail/util/TraceInputStream;->setQuote(Z)V

    .line 1454
    new-instance v4, Lcom/sun/mail/util/TraceOutputStream;

    iget-object v5, p0, Lcom/sun/mail/smtp/SMTPTransport;->serverSocket:Ljava/net/Socket;

    invoke-virtual {v5}, Ljava/net/Socket;->getOutputStream()Ljava/io/OutputStream;

    move-result-object v5

    invoke-direct {v4, v5, v1}, Lcom/sun/mail/util/TraceOutputStream;-><init>(Ljava/io/OutputStream;Ljava/io/OutputStream;)V

    .line 1455
    invoke-virtual {v4, v2}, Lcom/sun/mail/util/TraceOutputStream;->setTrace(Z)V

    .line 1456
    invoke-virtual {v4, v0}, Lcom/sun/mail/util/TraceOutputStream;->setQuote(Z)V

    .line 1459
    new-instance v0, Ljava/io/BufferedOutputStream;

    invoke-direct {v0, v4}, Ljava/io/BufferedOutputStream;-><init>(Ljava/io/OutputStream;)V

    .line 1458
    iput-object v0, p0, Lcom/sun/mail/smtp/SMTPTransport;->serverOutput:Ljava/io/OutputStream;

    .line 1461
    new-instance v0, Ljava/io/BufferedInputStream;

    invoke-direct {v0, v3}, Ljava/io/BufferedInputStream;-><init>(Ljava/io/InputStream;)V

    .line 1460
    iput-object v0, p0, Lcom/sun/mail/smtp/SMTPTransport;->serverInput:Ljava/io/BufferedInputStream;

    .line 1462
    new-instance v0, Lcom/sun/mail/util/LineInputStream;

    iget-object v1, p0, Lcom/sun/mail/smtp/SMTPTransport;->serverInput:Ljava/io/BufferedInputStream;

    invoke-direct {v0, v1}, Lcom/sun/mail/util/LineInputStream;-><init>(Ljava/io/InputStream;)V

    iput-object v0, p0, Lcom/sun/mail/smtp/SMTPTransport;->lineInputStream:Lcom/sun/mail/util/LineInputStream;

    .line 1463
    return-void

    .line 1446
    :cond_0
    const/4 v0, 0x0

    goto :goto_0
.end method

.method private is8Bit(Ljava/io/InputStream;)Z
    .locals 5

    .prologue
    const/4 v0, 0x0

    .line 866
    move v1, v0

    move v2, v0

    .line 869
    :cond_0
    :goto_0
    :try_start_0
    invoke-virtual {p1}, Ljava/io/InputStream;->read()I
    :try_end_0
    .catch Ljava/io/IOException; {:try_start_0 .. :try_end_0} :catch_0

    move-result v3

    if-gez v3, :cond_3

    .line 886
    iget-boolean v0, p0, Lcom/sun/mail/smtp/SMTPTransport;->debug:Z

    if-eqz v0, :cond_1

    if-eqz v1, :cond_1

    .line 887
    iget-object v0, p0, Lcom/sun/mail/smtp/SMTPTransport;->out:Ljava/io/PrintStream;

    const-string v2, "DEBUG SMTP: found an 8bit part"

    invoke-virtual {v0, v2}, Ljava/io/PrintStream;->println(Ljava/lang/String;)V

    :cond_1
    move v0, v1

    .line 888
    :cond_2
    :goto_1
    return v0

    .line 870
    :cond_3
    and-int/lit16 v3, v3, 0xff

    .line 871
    const/16 v4, 0xd

    if-eq v3, v4, :cond_4

    const/16 v4, 0xa

    if-ne v3, v4, :cond_6

    :cond_4
    move v2, v0

    .line 880
    :cond_5
    const/16 v4, 0x7f

    if-le v3, v4, :cond_0

    .line 881
    const/4 v1, 0x1

    goto :goto_0

    .line 873
    :cond_6
    if-eqz v3, :cond_2

    .line 876
    add-int/lit8 v2, v2, 0x1

    .line 877
    const/16 v4, 0x3e6

    if-le v2, v4, :cond_5

    goto :goto_1

    .line 883
    :catch_0
    move-exception v1

    goto :goto_1
.end method

.method private isNotLastLine(Ljava/lang/String;)Z
    .locals 2

    .prologue
    .line 1669
    if-eqz p1, :cond_0

    invoke-virtual {p1}, Ljava/lang/String;->length()I

    move-result v0

    const/4 v1, 0x4

    if-lt v0, v1, :cond_0

    const/4 v0, 0x3

    invoke-virtual {p1, v0}, Ljava/lang/String;->charAt(I)C

    move-result v0

    const/16 v1, 0x2d

    if-ne v0, v1, :cond_0

    const/4 v0, 0x1

    :goto_0
    return v0

    :cond_0
    const/4 v0, 0x0

    goto :goto_0
.end method

.method private issueSendCommand(Ljava/lang/String;I)V
    .locals 8
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljavax/mail/MessagingException;
        }
    .end annotation

    .prologue
    const/4 v1, 0x0

    .line 1489
    invoke-virtual {p0, p1}, Lcom/sun/mail/smtp/SMTPTransport;->sendCommand(Ljava/lang/String;)V

    .line 1494
    invoke-virtual {p0}, Lcom/sun/mail/smtp/SMTPTransport;->readServerResponse()I

    move-result v2

    if-eq v2, p2, :cond_6

    .line 1497
    iget-object v0, p0, Lcom/sun/mail/smtp/SMTPTransport;->validSentAddr:[Ljavax/mail/Address;

    if-nez v0, :cond_4

    move v0, v1

    .line 1498
    :goto_0
    iget-object v3, p0, Lcom/sun/mail/smtp/SMTPTransport;->validUnsentAddr:[Ljavax/mail/Address;

    if-nez v3, :cond_5

    move v3, v1

    .line 1499
    :goto_1
    add-int v4, v0, v3

    new-array v4, v4, [Ljavax/mail/Address;

    .line 1500
    if-lez v0, :cond_0

    .line 1501
    iget-object v5, p0, Lcom/sun/mail/smtp/SMTPTransport;->validSentAddr:[Ljavax/mail/Address;

    invoke-static {v5, v1, v4, v1, v0}, Ljava/lang/System;->arraycopy(Ljava/lang/Object;ILjava/lang/Object;II)V

    .line 1502
    :cond_0
    if-lez v3, :cond_1

    .line 1503
    iget-object v5, p0, Lcom/sun/mail/smtp/SMTPTransport;->validUnsentAddr:[Ljavax/mail/Address;

    invoke-static {v5, v1, v4, v0, v3}, Ljava/lang/System;->arraycopy(Ljava/lang/Object;ILjava/lang/Object;II)V

    .line 1504
    :cond_1
    const/4 v0, 0x0

    iput-object v0, p0, Lcom/sun/mail/smtp/SMTPTransport;->validSentAddr:[Ljavax/mail/Address;

    .line 1505
    iput-object v4, p0, Lcom/sun/mail/smtp/SMTPTransport;->validUnsentAddr:[Ljavax/mail/Address;

    .line 1506
    iget-boolean v0, p0, Lcom/sun/mail/smtp/SMTPTransport;->debug:Z

    if-eqz v0, :cond_2

    .line 1507
    iget-object v0, p0, Lcom/sun/mail/smtp/SMTPTransport;->out:Ljava/io/PrintStream;

    new-instance v1, Ljava/lang/StringBuilder;

    const-string v3, "DEBUG SMTP: got response code "

    invoke-direct {v1, v3}, Ljava/lang/StringBuilder;-><init>(Ljava/lang/String;)V

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v1

    .line 1508
    const-string v3, ", with response: "

    invoke-virtual {v1, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    iget-object v3, p0, Lcom/sun/mail/smtp/SMTPTransport;->lastServerResponse:Ljava/lang/String;

    invoke-virtual {v1, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v1

    .line 1507
    invoke-virtual {v0, v1}, Ljava/io/PrintStream;->println(Ljava/lang/String;)V

    .line 1509
    :cond_2
    iget-object v0, p0, Lcom/sun/mail/smtp/SMTPTransport;->lastServerResponse:Ljava/lang/String;

    .line 1510
    iget v1, p0, Lcom/sun/mail/smtp/SMTPTransport;->lastReturnCode:I

    .line 1511
    iget-object v3, p0, Lcom/sun/mail/smtp/SMTPTransport;->serverSocket:Ljava/net/Socket;

    if-eqz v3, :cond_3

    .line 1512
    const-string v3, "RSET"

    const/16 v4, 0xfa

    invoke-virtual {p0, v3, v4}, Lcom/sun/mail/smtp/SMTPTransport;->issueCommand(Ljava/lang/String;I)V

    .line 1513
    :cond_3
    iput-object v0, p0, Lcom/sun/mail/smtp/SMTPTransport;->lastServerResponse:Ljava/lang/String;

    .line 1514
    iput v1, p0, Lcom/sun/mail/smtp/SMTPTransport;->lastReturnCode:I

    .line 1515
    new-instance v0, Lcom/sun/mail/smtp/SMTPSendFailedException;

    iget-object v3, p0, Lcom/sun/mail/smtp/SMTPTransport;->lastServerResponse:Ljava/lang/String;

    .line 1516
    iget-object v4, p0, Lcom/sun/mail/smtp/SMTPTransport;->exception:Ljavax/mail/MessagingException;

    iget-object v5, p0, Lcom/sun/mail/smtp/SMTPTransport;->validSentAddr:[Ljavax/mail/Address;

    iget-object v6, p0, Lcom/sun/mail/smtp/SMTPTransport;->validUnsentAddr:[Ljavax/mail/Address;

    iget-object v7, p0, Lcom/sun/mail/smtp/SMTPTransport;->invalidAddr:[Ljavax/mail/Address;

    move-object v1, p1

    .line 1515
    invoke-direct/range {v0 .. v7}, Lcom/sun/mail/smtp/SMTPSendFailedException;-><init>(Ljava/lang/String;ILjava/lang/String;Ljava/lang/Exception;[Ljavax/mail/Address;[Ljavax/mail/Address;[Ljavax/mail/Address;)V

    throw v0

    .line 1497
    :cond_4
    iget-object v0, p0, Lcom/sun/mail/smtp/SMTPTransport;->validSentAddr:[Ljavax/mail/Address;

    array-length v0, v0

    goto :goto_0

    .line 1498
    :cond_5
    iget-object v3, p0, Lcom/sun/mail/smtp/SMTPTransport;->validUnsentAddr:[Ljavax/mail/Address;

    array-length v3, v3

    goto :goto_1

    .line 1518
    :cond_6
    return-void
.end method

.method private normalizeAddress(Ljava/lang/String;)Ljava/lang/String;
    .locals 2

    .prologue
    .line 1674
    const-string v0, "<"

    invoke-virtual {p1, v0}, Ljava/lang/String;->startsWith(Ljava/lang/String;)Z

    move-result v0

    if-nez v0, :cond_0

    const-string v0, ">"

    invoke-virtual {p1, v0}, Ljava/lang/String;->endsWith(Ljava/lang/String;)Z

    move-result v0

    if-nez v0, :cond_0

    .line 1675
    new-instance v0, Ljava/lang/StringBuilder;

    const-string v1, "<"

    invoke-direct {v0, v1}, Ljava/lang/StringBuilder;-><init>(Ljava/lang/String;)V

    invoke-virtual {v0, p1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    const-string v1, ">"

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-virtual {v0}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object p1

    .line 1677
    :cond_0
    return-object p1
.end method

.method private openServer()V
    .locals 6
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljavax/mail/MessagingException;
        }
    .end annotation

    .prologue
    .line 1401
    const/4 v2, -0x1

    .line 1402
    const-string v1, "UNKNOWN"

    .line 1404
    :try_start_0
    iget-object v0, p0, Lcom/sun/mail/smtp/SMTPTransport;->serverSocket:Ljava/net/Socket;

    invoke-virtual {v0}, Ljava/net/Socket;->getPort()I

    move-result v2

    .line 1405
    iget-object v0, p0, Lcom/sun/mail/smtp/SMTPTransport;->serverSocket:Ljava/net/Socket;

    invoke-virtual {v0}, Ljava/net/Socket;->getInetAddress()Ljava/net/InetAddress;

    move-result-object v0

    invoke-virtual {v0}, Ljava/net/InetAddress;->getHostName()Ljava/lang/String;

    move-result-object v1

    .line 1406
    iget-boolean v0, p0, Lcom/sun/mail/smtp/SMTPTransport;->debug:Z

    if-eqz v0, :cond_0

    .line 1407
    iget-object v0, p0, Lcom/sun/mail/smtp/SMTPTransport;->out:Ljava/io/PrintStream;

    new-instance v3, Ljava/lang/StringBuilder;

    const-string v4, "DEBUG SMTP: starting protocol to host \""

    invoke-direct {v3, v4}, Ljava/lang/StringBuilder;-><init>(Ljava/lang/String;)V

    .line 1408
    invoke-virtual {v3, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v3

    const-string v4, "\", port "

    invoke-virtual {v3, v4}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v3

    invoke-virtual {v3, v2}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v3

    invoke-virtual {v3}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v3

    .line 1407
    invoke-virtual {v0, v3}, Ljava/io/PrintStream;->println(Ljava/lang/String;)V

    .line 1410
    :cond_0
    invoke-direct {p0}, Lcom/sun/mail/smtp/SMTPTransport;->initStreams()V

    .line 1413
    invoke-virtual {p0}, Lcom/sun/mail/smtp/SMTPTransport;->readServerResponse()I

    move-result v0

    const/16 v3, 0xdc

    if-eq v0, v3, :cond_2

    .line 1414
    iget-object v3, p0, Lcom/sun/mail/smtp/SMTPTransport;->serverSocket:Ljava/net/Socket;

    invoke-virtual {v3}, Ljava/net/Socket;->close()V

    .line 1415
    const/4 v3, 0x0

    iput-object v3, p0, Lcom/sun/mail/smtp/SMTPTransport;->serverSocket:Ljava/net/Socket;

    .line 1416
    const/4 v3, 0x0

    iput-object v3, p0, Lcom/sun/mail/smtp/SMTPTransport;->serverOutput:Ljava/io/OutputStream;

    .line 1417
    const/4 v3, 0x0

    iput-object v3, p0, Lcom/sun/mail/smtp/SMTPTransport;->serverInput:Ljava/io/BufferedInputStream;

    .line 1418
    const/4 v3, 0x0

    iput-object v3, p0, Lcom/sun/mail/smtp/SMTPTransport;->lineInputStream:Lcom/sun/mail/util/LineInputStream;

    .line 1419
    iget-boolean v3, p0, Lcom/sun/mail/smtp/SMTPTransport;->debug:Z

    if-eqz v3, :cond_1

    .line 1420
    iget-object v3, p0, Lcom/sun/mail/smtp/SMTPTransport;->out:Ljava/io/PrintStream;

    new-instance v4, Ljava/lang/StringBuilder;

    const-string v5, "DEBUG SMTP: got bad greeting from host \""

    invoke-direct {v4, v5}, Ljava/lang/StringBuilder;-><init>(Ljava/lang/String;)V

    .line 1421
    invoke-virtual {v4, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v4

    const-string v5, "\", port: "

    invoke-virtual {v4, v5}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v4

    invoke-virtual {v4, v2}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v4

    .line 1422
    const-string v5, ", response: "

    invoke-virtual {v4, v5}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v4

    invoke-virtual {v4, v0}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v4

    const-string v5, "\n"

    invoke-virtual {v4, v5}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v4

    invoke-virtual {v4}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v4

    .line 1420
    invoke-virtual {v3, v4}, Ljava/io/PrintStream;->println(Ljava/lang/String;)V

    .line 1423
    :cond_1
    new-instance v3, Ljavax/mail/MessagingException;

    .line 1424
    new-instance v4, Ljava/lang/StringBuilder;

    const-string v5, "Got bad greeting from SMTP host: "

    invoke-direct {v4, v5}, Ljava/lang/StringBuilder;-><init>(Ljava/lang/String;)V

    invoke-virtual {v4, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v4

    .line 1425
    const-string v5, ", port: "

    invoke-virtual {v4, v5}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v4

    invoke-virtual {v4, v2}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v4

    .line 1426
    const-string v5, ", response: "

    invoke-virtual {v4, v5}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v4

    invoke-virtual {v4, v0}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v0

    .line 1424
    invoke-virtual {v0}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v0

    .line 1423
    invoke-direct {v3, v0}, Ljavax/mail/MessagingException;-><init>(Ljava/lang/String;)V

    throw v3
    :try_end_0
    .catch Ljava/io/IOException; {:try_start_0 .. :try_end_0} :catch_0

    .line 1432
    :catch_0
    move-exception v0

    .line 1433
    new-instance v3, Ljavax/mail/MessagingException;

    .line 1434
    new-instance v4, Ljava/lang/StringBuilder;

    const-string v5, "Could not start protocol to SMTP host: "

    invoke-direct {v4, v5}, Ljava/lang/StringBuilder;-><init>(Ljava/lang/String;)V

    .line 1435
    invoke-virtual {v4, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    const-string v4, ", port: "

    invoke-virtual {v1, v4}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v1

    .line 1434
    invoke-virtual {v1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v1

    .line 1433
    invoke-direct {v3, v1, v0}, Ljavax/mail/MessagingException;-><init>(Ljava/lang/String;Ljava/lang/Exception;)V

    throw v3

    .line 1428
    :cond_2
    :try_start_1
    iget-boolean v0, p0, Lcom/sun/mail/smtp/SMTPTransport;->debug:Z

    if-eqz v0, :cond_3

    .line 1429
    iget-object v0, p0, Lcom/sun/mail/smtp/SMTPTransport;->out:Ljava/io/PrintStream;

    new-instance v3, Ljava/lang/StringBuilder;

    const-string v4, "DEBUG SMTP: protocol started to host \""

    invoke-direct {v3, v4}, Ljava/lang/StringBuilder;-><init>(Ljava/lang/String;)V

    .line 1430
    invoke-virtual {v3, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v3

    const-string v4, "\", port: "

    invoke-virtual {v3, v4}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v3

    invoke-virtual {v3, v2}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v3

    const-string v4, "\n"

    invoke-virtual {v3, v4}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v3

    invoke-virtual {v3}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v3

    .line 1429
    invoke-virtual {v0, v3}, Ljava/io/PrintStream;->println(Ljava/lang/String;)V
    :try_end_1
    .catch Ljava/io/IOException; {:try_start_1 .. :try_end_1} :catch_0

    .line 1437
    :cond_3
    return-void
.end method

.method private openServer(Ljava/lang/String;I)V
    .locals 4
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljavax/mail/MessagingException;
        }
    .end annotation

    .prologue
    .line 1352
    iget-boolean v0, p0, Lcom/sun/mail/smtp/SMTPTransport;->debug:Z

    if-eqz v0, :cond_0

    .line 1353
    iget-object v0, p0, Lcom/sun/mail/smtp/SMTPTransport;->out:Ljava/io/PrintStream;

    new-instance v1, Ljava/lang/StringBuilder;

    const-string v2, "DEBUG SMTP: trying to connect to host \""

    invoke-direct {v1, v2}, Ljava/lang/StringBuilder;-><init>(Ljava/lang/String;)V

    invoke-virtual {v1, p1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    .line 1354
    const-string v2, "\", port "

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1, p2}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v1

    const-string v2, ", isSSL "

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    iget-boolean v2, p0, Lcom/sun/mail/smtp/SMTPTransport;->isSSL:Z

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Z)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v1

    .line 1353
    invoke-virtual {v0, v1}, Ljava/io/PrintStream;->println(Ljava/lang/String;)V

    .line 1357
    :cond_0
    :try_start_0
    iget-object v0, p0, Lcom/sun/mail/smtp/SMTPTransport;->session:Ljavax/mail/Session;

    invoke-virtual {v0}, Ljavax/mail/Session;->getProperties()Ljava/util/Properties;

    move-result-object v0

    .line 1360
    new-instance v1, Ljava/lang/StringBuilder;

    const-string v2, "mail."

    invoke-direct {v1, v2}, Ljava/lang/StringBuilder;-><init>(Ljava/lang/String;)V

    iget-object v2, p0, Lcom/sun/mail/smtp/SMTPTransport;->name:Ljava/lang/String;

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v1

    iget-boolean v2, p0, Lcom/sun/mail/smtp/SMTPTransport;->isSSL:Z

    .line 1359
    invoke-static {p1, p2, v0, v1, v2}, Lcom/sun/mail/util/SocketFetcher;->getSocket(Ljava/lang/String;ILjava/util/Properties;Ljava/lang/String;Z)Ljava/net/Socket;

    move-result-object v0

    iput-object v0, p0, Lcom/sun/mail/smtp/SMTPTransport;->serverSocket:Ljava/net/Socket;

    .line 1364
    iget-object v0, p0, Lcom/sun/mail/smtp/SMTPTransport;->serverSocket:Ljava/net/Socket;

    invoke-virtual {v0}, Ljava/net/Socket;->getPort()I

    move-result p2

    .line 1366
    invoke-direct {p0}, Lcom/sun/mail/smtp/SMTPTransport;->initStreams()V

    .line 1369
    invoke-virtual {p0}, Lcom/sun/mail/smtp/SMTPTransport;->readServerResponse()I

    move-result v0

    const/16 v1, 0xdc

    if-eq v0, v1, :cond_2

    .line 1370
    iget-object v1, p0, Lcom/sun/mail/smtp/SMTPTransport;->serverSocket:Ljava/net/Socket;

    invoke-virtual {v1}, Ljava/net/Socket;->close()V

    .line 1371
    const/4 v1, 0x0

    iput-object v1, p0, Lcom/sun/mail/smtp/SMTPTransport;->serverSocket:Ljava/net/Socket;

    .line 1372
    const/4 v1, 0x0

    iput-object v1, p0, Lcom/sun/mail/smtp/SMTPTransport;->serverOutput:Ljava/io/OutputStream;

    .line 1373
    const/4 v1, 0x0

    iput-object v1, p0, Lcom/sun/mail/smtp/SMTPTransport;->serverInput:Ljava/io/BufferedInputStream;

    .line 1374
    const/4 v1, 0x0

    iput-object v1, p0, Lcom/sun/mail/smtp/SMTPTransport;->lineInputStream:Lcom/sun/mail/util/LineInputStream;

    .line 1375
    iget-boolean v1, p0, Lcom/sun/mail/smtp/SMTPTransport;->debug:Z

    if-eqz v1, :cond_1

    .line 1376
    iget-object v1, p0, Lcom/sun/mail/smtp/SMTPTransport;->out:Ljava/io/PrintStream;

    new-instance v2, Ljava/lang/StringBuilder;

    const-string v3, "DEBUG SMTP: could not connect to host \""

    invoke-direct {v2, v3}, Ljava/lang/StringBuilder;-><init>(Ljava/lang/String;)V

    .line 1377
    invoke-virtual {v2, p1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    const-string v3, "\", port: "

    invoke-virtual {v2, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    invoke-virtual {v2, p2}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v2

    .line 1378
    const-string v3, ", response: "

    invoke-virtual {v2, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    invoke-virtual {v2, v0}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v2

    const-string v3, "\n"

    invoke-virtual {v2, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    invoke-virtual {v2}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v2

    .line 1376
    invoke-virtual {v1, v2}, Ljava/io/PrintStream;->println(Ljava/lang/String;)V

    .line 1379
    :cond_1
    new-instance v1, Ljavax/mail/MessagingException;

    .line 1380
    new-instance v2, Ljava/lang/StringBuilder;

    const-string v3, "Could not connect to SMTP host: "

    invoke-direct {v2, v3}, Ljava/lang/StringBuilder;-><init>(Ljava/lang/String;)V

    invoke-virtual {v2, p1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    .line 1381
    const-string v3, ", port: "

    invoke-virtual {v2, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    invoke-virtual {v2, p2}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v2

    .line 1382
    const-string v3, ", response: "

    invoke-virtual {v2, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    invoke-virtual {v2, v0}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v0

    .line 1380
    invoke-virtual {v0}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v0

    .line 1379
    invoke-direct {v1, v0}, Ljavax/mail/MessagingException;-><init>(Ljava/lang/String;)V

    throw v1
    :try_end_0
    .catch Ljava/net/UnknownHostException; {:try_start_0 .. :try_end_0} :catch_0
    .catch Ljava/io/IOException; {:try_start_0 .. :try_end_0} :catch_1

    .line 1388
    :catch_0
    move-exception v0

    .line 1389
    new-instance v1, Ljavax/mail/MessagingException;

    new-instance v2, Ljava/lang/StringBuilder;

    const-string v3, "Unknown SMTP host: "

    invoke-direct {v2, v3}, Ljava/lang/StringBuilder;-><init>(Ljava/lang/String;)V

    invoke-virtual {v2, p1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    invoke-virtual {v2}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v2

    invoke-direct {v1, v2, v0}, Ljavax/mail/MessagingException;-><init>(Ljava/lang/String;Ljava/lang/Exception;)V

    throw v1

    .line 1384
    :cond_2
    :try_start_1
    iget-boolean v0, p0, Lcom/sun/mail/smtp/SMTPTransport;->debug:Z

    if-eqz v0, :cond_3

    .line 1385
    iget-object v0, p0, Lcom/sun/mail/smtp/SMTPTransport;->out:Ljava/io/PrintStream;

    new-instance v1, Ljava/lang/StringBuilder;

    const-string v2, "DEBUG SMTP: connected to host \""

    invoke-direct {v1, v2}, Ljava/lang/StringBuilder;-><init>(Ljava/lang/String;)V

    .line 1386
    invoke-virtual {v1, p1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    const-string v2, "\", port: "

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1, p2}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v1

    const-string v2, "\n"

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v1

    .line 1385
    invoke-virtual {v0, v1}, Ljava/io/PrintStream;->println(Ljava/lang/String;)V
    :try_end_1
    .catch Ljava/net/UnknownHostException; {:try_start_1 .. :try_end_1} :catch_0
    .catch Ljava/io/IOException; {:try_start_1 .. :try_end_1} :catch_1

    .line 1394
    :cond_3
    return-void

    .line 1390
    :catch_1
    move-exception v0

    .line 1391
    new-instance v1, Ljavax/mail/MessagingException;

    new-instance v2, Ljava/lang/StringBuilder;

    const-string v3, "Could not connect to SMTP host: "

    invoke-direct {v2, v3}, Ljava/lang/StringBuilder;-><init>(Ljava/lang/String;)V

    .line 1392
    invoke-virtual {v2, p1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    const-string v3, ", port: "

    invoke-virtual {v2, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    invoke-virtual {v2, p2}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v2

    invoke-virtual {v2}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v2

    .line 1391
    invoke-direct {v1, v2, v0}, Ljavax/mail/MessagingException;-><init>(Ljava/lang/String;Ljava/lang/Exception;)V

    throw v1
.end method

.method private sendCommand([B)V
    .locals 3
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljavax/mail/MessagingException;
        }
    .end annotation

    .prologue
    .line 1555
    sget-boolean v0, Lcom/sun/mail/smtp/SMTPTransport;->$assertionsDisabled:Z

    if-nez v0, :cond_0

    invoke-static {p0}, Ljava/lang/Thread;->holdsLock(Ljava/lang/Object;)Z

    move-result v0

    if-nez v0, :cond_0

    new-instance v0, Ljava/lang/AssertionError;

    invoke-direct {v0}, Ljava/lang/AssertionError;-><init>()V

    throw v0

    .line 1560
    :cond_0
    :try_start_0
    iget-object v0, p0, Lcom/sun/mail/smtp/SMTPTransport;->serverOutput:Ljava/io/OutputStream;

    invoke-virtual {v0, p1}, Ljava/io/OutputStream;->write([B)V

    .line 1561
    iget-object v0, p0, Lcom/sun/mail/smtp/SMTPTransport;->serverOutput:Ljava/io/OutputStream;

    sget-object v1, Lcom/sun/mail/smtp/SMTPTransport;->CRLF:[B

    invoke-virtual {v0, v1}, Ljava/io/OutputStream;->write([B)V

    .line 1562
    iget-object v0, p0, Lcom/sun/mail/smtp/SMTPTransport;->serverOutput:Ljava/io/OutputStream;

    invoke-virtual {v0}, Ljava/io/OutputStream;->flush()V
    :try_end_0
    .catch Ljava/io/IOException; {:try_start_0 .. :try_end_0} :catch_0

    .line 1566
    return-void

    .line 1563
    :catch_0
    move-exception v0

    .line 1564
    new-instance v1, Ljavax/mail/MessagingException;

    const-string v2, "Can\'t send command to SMTP host"

    invoke-direct {v1, v2, v0}, Ljavax/mail/MessagingException;-><init>(Ljava/lang/String;Ljava/lang/Exception;)V

    throw v1
.end method

.method protected static xtext(Ljava/lang/String;)Ljava/lang/String;
    .locals 7

    .prologue
    const/16 v6, 0x2b

    const/4 v2, 0x0

    .line 1761
    const/4 v0, 0x0

    move v1, v2

    .line 1762
    :goto_0
    invoke-virtual {p0}, Ljava/lang/String;->length()I

    move-result v3

    if-lt v1, v3, :cond_1

    .line 1780
    if-eqz v0, :cond_0

    invoke-virtual {v0}, Ljava/lang/StringBuffer;->toString()Ljava/lang/String;

    move-result-object p0

    :cond_0
    return-object p0

    .line 1763
    :cond_1
    invoke-virtual {p0, v1}, Ljava/lang/String;->charAt(I)C

    move-result v3

    .line 1764
    const/16 v4, 0x80

    if-lt v3, v4, :cond_2

    .line 1765
    new-instance v0, Ljava/lang/IllegalArgumentException;

    .line 1766
    new-instance v1, Ljava/lang/StringBuilder;

    const-string v2, "Non-ASCII character in SMTP submitter: "

    invoke-direct {v1, v2}, Ljava/lang/StringBuilder;-><init>(Ljava/lang/String;)V

    invoke-virtual {v1, p0}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v1

    .line 1765
    invoke-direct {v0, v1}, Ljava/lang/IllegalArgumentException;-><init>(Ljava/lang/String;)V

    throw v0

    .line 1767
    :cond_2
    const/16 v4, 0x21

    if-lt v3, v4, :cond_3

    const/16 v4, 0x7e

    if-gt v3, v4, :cond_3

    if-eq v3, v6, :cond_3

    const/16 v4, 0x3d

    if-ne v3, v4, :cond_6

    .line 1768
    :cond_3
    if-nez v0, :cond_4

    .line 1769
    new-instance v0, Ljava/lang/StringBuffer;

    invoke-virtual {p0}, Ljava/lang/String;->length()I

    move-result v4

    add-int/lit8 v4, v4, 0x4

    invoke-direct {v0, v4}, Ljava/lang/StringBuffer;-><init>(I)V

    .line 1770
    invoke-virtual {p0, v2, v1}, Ljava/lang/String;->substring(II)Ljava/lang/String;

    move-result-object v4

    invoke-virtual {v0, v4}, Ljava/lang/StringBuffer;->append(Ljava/lang/String;)Ljava/lang/StringBuffer;

    .line 1772
    :cond_4
    invoke-virtual {v0, v6}, Ljava/lang/StringBuffer;->append(C)Ljava/lang/StringBuffer;

    .line 1773
    sget-object v4, Lcom/sun/mail/smtp/SMTPTransport;->hexchar:[C

    and-int/lit16 v5, v3, 0xf0

    shr-int/lit8 v5, v5, 0x4

    aget-char v4, v4, v5

    invoke-virtual {v0, v4}, Ljava/lang/StringBuffer;->append(C)Ljava/lang/StringBuffer;

    .line 1774
    sget-object v4, Lcom/sun/mail/smtp/SMTPTransport;->hexchar:[C

    and-int/lit8 v3, v3, 0xf

    aget-char v3, v4, v3

    invoke-virtual {v0, v3}, Ljava/lang/StringBuffer;->append(C)Ljava/lang/StringBuffer;

    .line 1762
    :cond_5
    :goto_1
    add-int/lit8 v1, v1, 0x1

    goto :goto_0

    .line 1776
    :cond_6
    if-eqz v0, :cond_5

    .line 1777
    invoke-virtual {v0, v3}, Ljava/lang/StringBuffer;->append(C)Ljava/lang/StringBuffer;

    goto :goto_1
.end method


# virtual methods
.method protected checkConnected()V
    .locals 2

    .prologue
    .line 1663
    invoke-super {p0}, Ljavax/mail/Transport;->isConnected()Z

    move-result v0

    if-nez v0, :cond_0

    .line 1664
    new-instance v0, Ljava/lang/IllegalStateException;

    const-string v1, "Not connected"

    invoke-direct {v0, v1}, Ljava/lang/IllegalStateException;-><init>(Ljava/lang/String;)V

    throw v0

    .line 1665
    :cond_0
    return-void
.end method

.method public declared-synchronized close()V
    .locals 4
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljavax/mail/MessagingException;
        }
    .end annotation

    .prologue
    .line 692
    monitor-enter p0

    :try_start_0
    invoke-super {p0}, Ljavax/mail/Transport;->isConnected()Z
    :try_end_0
    .catchall {:try_start_0 .. :try_end_0} :catchall_0

    move-result v0

    if-nez v0, :cond_0

    .line 706
    :goto_0
    monitor-exit p0

    return-void

    .line 695
    :cond_0
    :try_start_1
    iget-object v0, p0, Lcom/sun/mail/smtp/SMTPTransport;->serverSocket:Ljava/net/Socket;

    if-eqz v0, :cond_1

    .line 696
    const-string v0, "QUIT"

    invoke-virtual {p0, v0}, Lcom/sun/mail/smtp/SMTPTransport;->sendCommand(Ljava/lang/String;)V

    .line 697
    iget-boolean v0, p0, Lcom/sun/mail/smtp/SMTPTransport;->quitWait:Z

    if-eqz v0, :cond_1

    .line 698
    invoke-virtual {p0}, Lcom/sun/mail/smtp/SMTPTransport;->readServerResponse()I

    move-result v0

    .line 699
    const/16 v1, 0xdd

    if-eq v0, v1, :cond_1

    const/4 v1, -0x1

    if-eq v0, v1, :cond_1

    .line 700
    iget-object v1, p0, Lcom/sun/mail/smtp/SMTPTransport;->out:Ljava/io/PrintStream;

    new-instance v2, Ljava/lang/StringBuilder;

    const-string v3, "DEBUG SMTP: QUIT failed with "

    invoke-direct {v2, v3}, Ljava/lang/StringBuilder;-><init>(Ljava/lang/String;)V

    invoke-virtual {v2, v0}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-virtual {v0}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v0

    invoke-virtual {v1, v0}, Ljava/io/PrintStream;->println(Ljava/lang/String;)V
    :try_end_1
    .catchall {:try_start_1 .. :try_end_1} :catchall_1

    .line 704
    :cond_1
    :try_start_2
    invoke-direct {p0}, Lcom/sun/mail/smtp/SMTPTransport;->closeConnection()V
    :try_end_2
    .catchall {:try_start_2 .. :try_end_2} :catchall_0

    goto :goto_0

    .line 692
    :catchall_0
    move-exception v0

    monitor-exit p0

    throw v0

    .line 703
    :catchall_1
    move-exception v0

    .line 704
    :try_start_3
    invoke-direct {p0}, Lcom/sun/mail/smtp/SMTPTransport;->closeConnection()V

    .line 705
    throw v0
    :try_end_3
    .catchall {:try_start_3 .. :try_end_3} :catchall_0
.end method

.method public declared-synchronized connect(Ljava/net/Socket;)V
    .locals 1
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljavax/mail/MessagingException;
        }
    .end annotation

    .prologue
    .line 209
    monitor-enter p0

    :try_start_0
    iput-object p1, p0, Lcom/sun/mail/smtp/SMTPTransport;->serverSocket:Ljava/net/Socket;

    .line 210
    invoke-super {p0}, Ljavax/mail/Transport;->connect()V
    :try_end_0
    .catchall {:try_start_0 .. :try_end_0} :catchall_0

    .line 211
    monitor-exit p0

    return-void

    .line 209
    :catchall_0
    move-exception v0

    monitor-exit p0

    throw v0
.end method

.method protected data()Ljava/io/OutputStream;
    .locals 2
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljavax/mail/MessagingException;
        }
    .end annotation

    .prologue
    .line 1307
    sget-boolean v0, Lcom/sun/mail/smtp/SMTPTransport;->$assertionsDisabled:Z

    if-nez v0, :cond_0

    invoke-static {p0}, Ljava/lang/Thread;->holdsLock(Ljava/lang/Object;)Z

    move-result v0

    if-nez v0, :cond_0

    new-instance v0, Ljava/lang/AssertionError;

    invoke-direct {v0}, Ljava/lang/AssertionError;-><init>()V

    throw v0

    .line 1308
    :cond_0
    const-string v0, "DATA"

    const/16 v1, 0x162

    invoke-direct {p0, v0, v1}, Lcom/sun/mail/smtp/SMTPTransport;->issueSendCommand(Ljava/lang/String;I)V

    .line 1309
    new-instance v0, Lcom/sun/mail/smtp/SMTPOutputStream;

    iget-object v1, p0, Lcom/sun/mail/smtp/SMTPTransport;->serverOutput:Ljava/io/OutputStream;

    invoke-direct {v0, v1}, Lcom/sun/mail/smtp/SMTPOutputStream;-><init>(Ljava/io/OutputStream;)V

    iput-object v0, p0, Lcom/sun/mail/smtp/SMTPTransport;->dataStream:Lcom/sun/mail/smtp/SMTPOutputStream;

    .line 1310
    iget-object v0, p0, Lcom/sun/mail/smtp/SMTPTransport;->dataStream:Lcom/sun/mail/smtp/SMTPOutputStream;

    return-object v0
.end method

.method protected ehlo(Ljava/lang/String;)Z
    .locals 11
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljavax/mail/MessagingException;
        }
    .end annotation

    .prologue
    const/16 v10, 0xfa

    const/4 v1, 0x1

    const/4 v2, 0x0

    .line 931
    if-eqz p1, :cond_2

    .line 932
    new-instance v0, Ljava/lang/StringBuilder;

    const-string v3, "EHLO "

    invoke-direct {v0, v3}, Ljava/lang/StringBuilder;-><init>(Ljava/lang/String;)V

    invoke-virtual {v0, p1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-virtual {v0}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v0

    .line 935
    :goto_0
    invoke-virtual {p0, v0}, Lcom/sun/mail/smtp/SMTPTransport;->sendCommand(Ljava/lang/String;)V

    .line 936
    invoke-virtual {p0}, Lcom/sun/mail/smtp/SMTPTransport;->readServerResponse()I

    move-result v5

    .line 937
    if-ne v5, v10, :cond_1

    .line 940
    new-instance v6, Ljava/io/BufferedReader;

    new-instance v0, Ljava/io/StringReader;

    iget-object v3, p0, Lcom/sun/mail/smtp/SMTPTransport;->lastServerResponse:Ljava/lang/String;

    invoke-direct {v0, v3}, Ljava/io/StringReader;-><init>(Ljava/lang/String;)V

    invoke-direct {v6, v0}, Ljava/io/BufferedReader;-><init>(Ljava/io/Reader;)V

    .line 942
    new-instance v0, Ljava/util/Hashtable;

    invoke-direct {v0}, Ljava/util/Hashtable;-><init>()V

    iput-object v0, p0, Lcom/sun/mail/smtp/SMTPTransport;->extMap:Ljava/util/Hashtable;

    move v4, v1

    .line 945
    :cond_0
    :goto_1
    :try_start_0
    invoke-virtual {v6}, Ljava/io/BufferedReader;->readLine()Ljava/lang/String;
    :try_end_0
    .catch Ljava/io/IOException; {:try_start_0 .. :try_end_0} :catch_0

    move-result-object v0

    if-nez v0, :cond_3

    .line 966
    :cond_1
    :goto_2
    if-ne v5, v10, :cond_7

    move v0, v1

    :goto_3
    return v0

    .line 934
    :cond_2
    const-string v0, "EHLO"

    goto :goto_0

    .line 946
    :cond_3
    if-eqz v4, :cond_4

    move v4, v2

    .line 948
    goto :goto_1

    .line 950
    :cond_4
    :try_start_1
    invoke-virtual {v0}, Ljava/lang/String;->length()I

    move-result v3

    const/4 v7, 0x5

    if-lt v3, v7, :cond_0

    .line 952
    const/4 v3, 0x4

    invoke-virtual {v0, v3}, Ljava/lang/String;->substring(I)Ljava/lang/String;

    move-result-object v3

    .line 953
    const/16 v0, 0x20

    invoke-virtual {v3, v0}, Ljava/lang/String;->indexOf(I)I

    move-result v7

    .line 954
    const-string v0, ""

    .line 955
    if-lez v7, :cond_5

    .line 956
    add-int/lit8 v0, v7, 0x1

    invoke-virtual {v3, v0}, Ljava/lang/String;->substring(I)Ljava/lang/String;

    move-result-object v0

    .line 957
    const/4 v8, 0x0

    invoke-virtual {v3, v8, v7}, Ljava/lang/String;->substring(II)Ljava/lang/String;

    move-result-object v3

    .line 959
    :cond_5
    iget-boolean v7, p0, Lcom/sun/mail/smtp/SMTPTransport;->debug:Z

    if-eqz v7, :cond_6

    .line 960
    iget-object v7, p0, Lcom/sun/mail/smtp/SMTPTransport;->out:Ljava/io/PrintStream;

    new-instance v8, Ljava/lang/StringBuilder;

    const-string v9, "DEBUG SMTP: Found extension \""

    invoke-direct {v8, v9}, Ljava/lang/StringBuilder;-><init>(Ljava/lang/String;)V

    .line 961
    invoke-virtual {v8, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v8

    const-string v9, "\", arg \""

    invoke-virtual {v8, v9}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v8

    invoke-virtual {v8, v0}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v8

    const-string v9, "\""

    invoke-virtual {v8, v9}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v8

    invoke-virtual {v8}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v8

    .line 960
    invoke-virtual {v7, v8}, Ljava/io/PrintStream;->println(Ljava/lang/String;)V

    .line 962
    :cond_6
    iget-object v7, p0, Lcom/sun/mail/smtp/SMTPTransport;->extMap:Ljava/util/Hashtable;

    sget-object v8, Ljava/util/Locale;->ENGLISH:Ljava/util/Locale;

    invoke-virtual {v3, v8}, Ljava/lang/String;->toUpperCase(Ljava/util/Locale;)Ljava/lang/String;

    move-result-object v3

    invoke-virtual {v7, v3, v0}, Ljava/util/Hashtable;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;
    :try_end_1
    .catch Ljava/io/IOException; {:try_start_1 .. :try_end_1} :catch_0

    goto :goto_1

    .line 964
    :catch_0
    move-exception v0

    goto :goto_2

    :cond_7
    move v0, v2

    .line 966
    goto :goto_3
.end method

.method protected finalize()V
    .locals 1
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljava/lang/Throwable;
        }
    .end annotation

    .prologue
    .line 892
    invoke-super {p0}, Ljavax/mail/Transport;->finalize()V

    .line 894
    :try_start_0
    invoke-direct {p0}, Lcom/sun/mail/smtp/SMTPTransport;->closeConnection()V
    :try_end_0
    .catch Ljavax/mail/MessagingException; {:try_start_0 .. :try_end_0} :catch_0

    .line 896
    :goto_0
    return-void

    .line 895
    :catch_0
    move-exception v0

    goto :goto_0
.end method

.method protected finishData()V
    .locals 2
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljava/io/IOException;,
            Ljavax/mail/MessagingException;
        }
    .end annotation

    .prologue
    .line 1319
    sget-boolean v0, Lcom/sun/mail/smtp/SMTPTransport;->$assertionsDisabled:Z

    if-nez v0, :cond_0

    invoke-static {p0}, Ljava/lang/Thread;->holdsLock(Ljava/lang/Object;)Z

    move-result v0

    if-nez v0, :cond_0

    new-instance v0, Ljava/lang/AssertionError;

    invoke-direct {v0}, Ljava/lang/AssertionError;-><init>()V

    throw v0

    .line 1320
    :cond_0
    iget-object v0, p0, Lcom/sun/mail/smtp/SMTPTransport;->dataStream:Lcom/sun/mail/smtp/SMTPOutputStream;

    invoke-virtual {v0}, Lcom/sun/mail/smtp/SMTPOutputStream;->ensureAtBOL()V

    .line 1321
    const-string v0, "."

    const/16 v1, 0xfa

    invoke-direct {p0, v0, v1}, Lcom/sun/mail/smtp/SMTPTransport;->issueSendCommand(Ljava/lang/String;I)V

    .line 1322
    return-void
.end method

.method public getExtensionParameter(Ljava/lang/String;)Ljava/lang/String;
    .locals 2

    .prologue
    .line 1707
    iget-object v0, p0, Lcom/sun/mail/smtp/SMTPTransport;->extMap:Ljava/util/Hashtable;

    if-nez v0, :cond_0

    const/4 v0, 0x0

    :goto_0
    return-object v0

    .line 1708
    :cond_0
    iget-object v0, p0, Lcom/sun/mail/smtp/SMTPTransport;->extMap:Ljava/util/Hashtable;

    sget-object v1, Ljava/util/Locale;->ENGLISH:Ljava/util/Locale;

    invoke-virtual {p1, v1}, Ljava/lang/String;->toUpperCase(Ljava/util/Locale;)Ljava/lang/String;

    move-result-object v1

    invoke-virtual {v0, v1}, Ljava/util/Hashtable;->get(Ljava/lang/Object;)Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Ljava/lang/String;

    goto :goto_0
.end method

.method public declared-synchronized getLastReturnCode()I
    .locals 1

    .prologue
    .line 340
    monitor-enter p0

    :try_start_0
    iget v0, p0, Lcom/sun/mail/smtp/SMTPTransport;->lastReturnCode:I
    :try_end_0
    .catchall {:try_start_0 .. :try_end_0} :catchall_0

    monitor-exit p0

    return v0

    :catchall_0
    move-exception v0

    monitor-exit p0

    throw v0
.end method

.method public declared-synchronized getLastServerResponse()Ljava/lang/String;
    .locals 1

    .prologue
    .line 329
    monitor-enter p0

    :try_start_0
    iget-object v0, p0, Lcom/sun/mail/smtp/SMTPTransport;->lastServerResponse:Ljava/lang/String;
    :try_end_0
    .catchall {:try_start_0 .. :try_end_0} :catchall_0

    monitor-exit p0

    return-object v0

    :catchall_0
    move-exception v0

    monitor-exit p0

    throw v0
.end method

.method public declared-synchronized getLocalHost()Ljava/lang/String;
    .locals 3

    .prologue
    .line 172
    monitor-enter p0

    :try_start_0
    iget-object v0, p0, Lcom/sun/mail/smtp/SMTPTransport;->localHostName:Ljava/lang/String;

    if-eqz v0, :cond_0

    iget-object v0, p0, Lcom/sun/mail/smtp/SMTPTransport;->localHostName:Ljava/lang/String;

    invoke-virtual {v0}, Ljava/lang/String;->length()I

    move-result v0

    if-gtz v0, :cond_1

    .line 174
    :cond_0
    iget-object v0, p0, Lcom/sun/mail/smtp/SMTPTransport;->session:Ljavax/mail/Session;

    new-instance v1, Ljava/lang/StringBuilder;

    const-string v2, "mail."

    invoke-direct {v1, v2}, Ljava/lang/StringBuilder;-><init>(Ljava/lang/String;)V

    iget-object v2, p0, Lcom/sun/mail/smtp/SMTPTransport;->name:Ljava/lang/String;

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    const-string v2, ".localhost"

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v1

    invoke-virtual {v0, v1}, Ljavax/mail/Session;->getProperty(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v0

    .line 173
    iput-object v0, p0, Lcom/sun/mail/smtp/SMTPTransport;->localHostName:Ljava/lang/String;

    .line 175
    :cond_1
    iget-object v0, p0, Lcom/sun/mail/smtp/SMTPTransport;->localHostName:Ljava/lang/String;

    if-eqz v0, :cond_2

    iget-object v0, p0, Lcom/sun/mail/smtp/SMTPTransport;->localHostName:Ljava/lang/String;

    invoke-virtual {v0}, Ljava/lang/String;->length()I

    move-result v0

    if-gtz v0, :cond_3

    .line 177
    :cond_2
    iget-object v0, p0, Lcom/sun/mail/smtp/SMTPTransport;->session:Ljavax/mail/Session;

    new-instance v1, Ljava/lang/StringBuilder;

    const-string v2, "mail."

    invoke-direct {v1, v2}, Ljava/lang/StringBuilder;-><init>(Ljava/lang/String;)V

    iget-object v2, p0, Lcom/sun/mail/smtp/SMTPTransport;->name:Ljava/lang/String;

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    const-string v2, ".localaddress"

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v1

    invoke-virtual {v0, v1}, Ljavax/mail/Session;->getProperty(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v0

    .line 176
    iput-object v0, p0, Lcom/sun/mail/smtp/SMTPTransport;->localHostName:Ljava/lang/String;

    .line 178
    :cond_3
    iget-object v0, p0, Lcom/sun/mail/smtp/SMTPTransport;->localHostName:Ljava/lang/String;

    if-eqz v0, :cond_4

    iget-object v0, p0, Lcom/sun/mail/smtp/SMTPTransport;->localHostName:Ljava/lang/String;

    invoke-virtual {v0}, Ljava/lang/String;->length()I

    move-result v0

    if-gtz v0, :cond_5

    .line 179
    :cond_4
    invoke-static {}, Ljava/net/InetAddress;->getLocalHost()Ljava/net/InetAddress;

    move-result-object v0

    .line 180
    invoke-virtual {v0}, Ljava/net/InetAddress;->getHostName()Ljava/lang/String;

    move-result-object v1

    iput-object v1, p0, Lcom/sun/mail/smtp/SMTPTransport;->localHostName:Ljava/lang/String;

    .line 182
    iget-object v1, p0, Lcom/sun/mail/smtp/SMTPTransport;->localHostName:Ljava/lang/String;

    if-nez v1, :cond_5

    .line 184
    new-instance v1, Ljava/lang/StringBuilder;

    const-string v2, "["

    invoke-direct {v1, v2}, Ljava/lang/StringBuilder;-><init>(Ljava/lang/String;)V

    invoke-virtual {v0}, Ljava/net/InetAddress;->getHostAddress()Ljava/lang/String;

    move-result-object v0

    invoke-virtual {v1, v0}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    const-string v1, "]"

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-virtual {v0}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v0

    iput-object v0, p0, Lcom/sun/mail/smtp/SMTPTransport;->localHostName:Ljava/lang/String;
    :try_end_0
    .catch Ljava/net/UnknownHostException; {:try_start_0 .. :try_end_0} :catch_0
    .catchall {:try_start_0 .. :try_end_0} :catchall_0

    .line 188
    :cond_5
    :goto_0
    :try_start_1
    iget-object v0, p0, Lcom/sun/mail/smtp/SMTPTransport;->localHostName:Ljava/lang/String;
    :try_end_1
    .catchall {:try_start_1 .. :try_end_1} :catchall_0

    monitor-exit p0

    return-object v0

    .line 172
    :catchall_0
    move-exception v0

    monitor-exit p0

    throw v0

    .line 186
    :catch_0
    move-exception v0

    goto :goto_0
.end method

.method public declared-synchronized getReportSuccess()Z
    .locals 1

    .prologue
    .line 255
    monitor-enter p0

    :try_start_0
    iget-boolean v0, p0, Lcom/sun/mail/smtp/SMTPTransport;->reportSuccess:Z
    :try_end_0
    .catchall {:try_start_0 .. :try_end_0} :catchall_0

    monitor-exit p0

    return v0

    :catchall_0
    move-exception v0

    monitor-exit p0

    throw v0
.end method

.method public declared-synchronized getSASLRealm()Ljava/lang/String;
    .locals 3

    .prologue
    .line 221
    monitor-enter p0

    :try_start_0
    iget-object v0, p0, Lcom/sun/mail/smtp/SMTPTransport;->saslRealm:Ljava/lang/String;

    const-string v1, "UNKNOWN"

    if-ne v0, v1, :cond_0

    .line 222
    iget-object v0, p0, Lcom/sun/mail/smtp/SMTPTransport;->session:Ljavax/mail/Session;

    new-instance v1, Ljava/lang/StringBuilder;

    const-string v2, "mail."

    invoke-direct {v1, v2}, Ljava/lang/StringBuilder;-><init>(Ljava/lang/String;)V

    iget-object v2, p0, Lcom/sun/mail/smtp/SMTPTransport;->name:Ljava/lang/String;

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    const-string v2, ".sasl.realm"

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v1

    invoke-virtual {v0, v1}, Ljavax/mail/Session;->getProperty(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v0

    iput-object v0, p0, Lcom/sun/mail/smtp/SMTPTransport;->saslRealm:Ljava/lang/String;

    .line 223
    iget-object v0, p0, Lcom/sun/mail/smtp/SMTPTransport;->saslRealm:Ljava/lang/String;

    if-nez v0, :cond_0

    .line 224
    iget-object v0, p0, Lcom/sun/mail/smtp/SMTPTransport;->session:Ljavax/mail/Session;

    new-instance v1, Ljava/lang/StringBuilder;

    const-string v2, "mail."

    invoke-direct {v1, v2}, Ljava/lang/StringBuilder;-><init>(Ljava/lang/String;)V

    iget-object v2, p0, Lcom/sun/mail/smtp/SMTPTransport;->name:Ljava/lang/String;

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    const-string v2, ".saslrealm"

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v1

    invoke-virtual {v0, v1}, Ljavax/mail/Session;->getProperty(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v0

    iput-object v0, p0, Lcom/sun/mail/smtp/SMTPTransport;->saslRealm:Ljava/lang/String;

    .line 226
    :cond_0
    iget-object v0, p0, Lcom/sun/mail/smtp/SMTPTransport;->saslRealm:Ljava/lang/String;
    :try_end_0
    .catchall {:try_start_0 .. :try_end_0} :catchall_0

    monitor-exit p0

    return-object v0

    .line 221
    :catchall_0
    move-exception v0

    monitor-exit p0

    throw v0
.end method

.method public declared-synchronized getStartTLS()Z
    .locals 1

    .prologue
    .line 279
    monitor-enter p0

    :try_start_0
    iget-boolean v0, p0, Lcom/sun/mail/smtp/SMTPTransport;->useStartTLS:Z
    :try_end_0
    .catchall {:try_start_0 .. :try_end_0} :catchall_0

    monitor-exit p0

    return v0

    :catchall_0
    move-exception v0

    monitor-exit p0

    throw v0
.end method

.method public declared-synchronized getUseRset()Z
    .locals 1

    .prologue
    .line 302
    monitor-enter p0

    :try_start_0
    iget-boolean v0, p0, Lcom/sun/mail/smtp/SMTPTransport;->useRset:Z
    :try_end_0
    .catchall {:try_start_0 .. :try_end_0} :catchall_0

    monitor-exit p0

    return v0

    :catchall_0
    move-exception v0

    monitor-exit p0

    throw v0
.end method

.method protected helo(Ljava/lang/String;)V
    .locals 3
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljavax/mail/MessagingException;
        }
    .end annotation

    .prologue
    const/16 v2, 0xfa

    .line 914
    if-eqz p1, :cond_0

    .line 915
    new-instance v0, Ljava/lang/StringBuilder;

    const-string v1, "HELO "

    invoke-direct {v0, v1}, Ljava/lang/StringBuilder;-><init>(Ljava/lang/String;)V

    invoke-virtual {v0, p1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-virtual {v0}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v0

    invoke-virtual {p0, v0, v2}, Lcom/sun/mail/smtp/SMTPTransport;->issueCommand(Ljava/lang/String;I)V

    .line 918
    :goto_0
    return-void

    .line 917
    :cond_0
    const-string v0, "HELO"

    invoke-virtual {p0, v0, v2}, Lcom/sun/mail/smtp/SMTPTransport;->issueCommand(Ljava/lang/String;I)V

    goto :goto_0
.end method

.method public declared-synchronized isConnected()Z
    .locals 3

    .prologue
    const/4 v0, 0x0

    .line 729
    monitor-enter p0

    :try_start_0
    invoke-super {p0}, Ljavax/mail/Transport;->isConnected()Z
    :try_end_0
    .catchall {:try_start_0 .. :try_end_0} :catchall_0

    move-result v1

    if-nez v1, :cond_0

    .line 762
    :goto_0
    monitor-exit p0

    return v0

    .line 736
    :cond_0
    :try_start_1
    iget-boolean v1, p0, Lcom/sun/mail/smtp/SMTPTransport;->useRset:Z

    if-eqz v1, :cond_1

    .line 737
    const-string v1, "RSET"

    invoke-virtual {p0, v1}, Lcom/sun/mail/smtp/SMTPTransport;->sendCommand(Ljava/lang/String;)V

    .line 740
    :goto_1
    invoke-virtual {p0}, Lcom/sun/mail/smtp/SMTPTransport;->readServerResponse()I

    move-result v1

    .line 750
    if-ltz v1, :cond_2

    const/16 v2, 0x1a5

    if-eq v1, v2, :cond_2

    .line 751
    const/4 v0, 0x1

    goto :goto_0

    .line 739
    :cond_1
    const-string v1, "NOOP"

    invoke-virtual {p0, v1}, Lcom/sun/mail/smtp/SMTPTransport;->sendCommand(Ljava/lang/String;)V
    :try_end_1
    .catch Ljava/lang/Exception; {:try_start_1 .. :try_end_1} :catch_0
    .catchall {:try_start_1 .. :try_end_1} :catchall_0

    goto :goto_1

    .line 758
    :catch_0
    move-exception v1

    .line 760
    :try_start_2
    invoke-direct {p0}, Lcom/sun/mail/smtp/SMTPTransport;->closeConnection()V
    :try_end_2
    .catch Ljavax/mail/MessagingException; {:try_start_2 .. :try_end_2} :catch_1
    .catchall {:try_start_2 .. :try_end_2} :catchall_0

    goto :goto_0

    .line 761
    :catch_1
    move-exception v1

    goto :goto_0

    .line 754
    :cond_2
    :try_start_3
    invoke-direct {p0}, Lcom/sun/mail/smtp/SMTPTransport;->closeConnection()V
    :try_end_3
    .catch Ljavax/mail/MessagingException; {:try_start_3 .. :try_end_3} :catch_2
    .catch Ljava/lang/Exception; {:try_start_3 .. :try_end_3} :catch_0
    .catchall {:try_start_3 .. :try_end_3} :catchall_0

    goto :goto_0

    .line 755
    :catch_2
    move-exception v1

    goto :goto_0

    .line 729
    :catchall_0
    move-exception v0

    monitor-exit p0

    throw v0
.end method

.method public declared-synchronized issueCommand(Ljava/lang/String;I)V
    .locals 2
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljavax/mail/MessagingException;
        }
    .end annotation

    .prologue
    .line 1476
    monitor-enter p0

    :try_start_0
    invoke-virtual {p0, p1}, Lcom/sun/mail/smtp/SMTPTransport;->sendCommand(Ljava/lang/String;)V

    .line 1480
    invoke-virtual {p0}, Lcom/sun/mail/smtp/SMTPTransport;->readServerResponse()I

    move-result v0

    if-eq v0, p2, :cond_0

    .line 1481
    new-instance v0, Ljavax/mail/MessagingException;

    iget-object v1, p0, Lcom/sun/mail/smtp/SMTPTransport;->lastServerResponse:Ljava/lang/String;

    invoke-direct {v0, v1}, Ljavax/mail/MessagingException;-><init>(Ljava/lang/String;)V

    throw v0
    :try_end_0
    .catchall {:try_start_0 .. :try_end_0} :catchall_0

    .line 1476
    :catchall_0
    move-exception v0

    monitor-exit p0

    throw v0

    .line 1482
    :cond_0
    monitor-exit p0

    return-void
.end method

.method protected mailFrom()V
    .locals 7
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljavax/mail/MessagingException;
        }
    .end annotation

    .prologue
    const/4 v2, 0x0

    .line 984
    .line 985
    iget-object v0, p0, Lcom/sun/mail/smtp/SMTPTransport;->message:Ljavax/mail/internet/MimeMessage;

    instance-of v0, v0, Lcom/sun/mail/smtp/SMTPMessage;

    if-eqz v0, :cond_f

    .line 986
    iget-object v0, p0, Lcom/sun/mail/smtp/SMTPTransport;->message:Ljavax/mail/internet/MimeMessage;

    check-cast v0, Lcom/sun/mail/smtp/SMTPMessage;

    invoke-virtual {v0}, Lcom/sun/mail/smtp/SMTPMessage;->getEnvelopeFrom()Ljava/lang/String;

    move-result-object v0

    .line 987
    :goto_0
    if-eqz v0, :cond_0

    invoke-virtual {v0}, Ljava/lang/String;->length()I

    move-result v1

    if-gtz v1, :cond_1

    .line 988
    :cond_0
    iget-object v0, p0, Lcom/sun/mail/smtp/SMTPTransport;->session:Ljavax/mail/Session;

    new-instance v1, Ljava/lang/StringBuilder;

    const-string v3, "mail."

    invoke-direct {v1, v3}, Ljava/lang/StringBuilder;-><init>(Ljava/lang/String;)V

    iget-object v3, p0, Lcom/sun/mail/smtp/SMTPTransport;->name:Ljava/lang/String;

    invoke-virtual {v1, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    const-string v3, ".from"

    invoke-virtual {v1, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v1

    invoke-virtual {v0, v1}, Ljavax/mail/Session;->getProperty(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v0

    .line 989
    :cond_1
    if-eqz v0, :cond_2

    invoke-virtual {v0}, Ljava/lang/String;->length()I

    move-result v1

    if-gtz v1, :cond_3

    .line 992
    :cond_2
    iget-object v0, p0, Lcom/sun/mail/smtp/SMTPTransport;->message:Ljavax/mail/internet/MimeMessage;

    if-eqz v0, :cond_9

    iget-object v0, p0, Lcom/sun/mail/smtp/SMTPTransport;->message:Ljavax/mail/internet/MimeMessage;

    invoke-virtual {v0}, Ljavax/mail/internet/MimeMessage;->getFrom()[Ljavax/mail/Address;

    move-result-object v0

    if-eqz v0, :cond_9

    .line 993
    array-length v1, v0

    if-lez v1, :cond_9

    .line 994
    const/4 v1, 0x0

    aget-object v0, v0, v1

    .line 998
    :goto_1
    if-eqz v0, :cond_a

    .line 999
    check-cast v0, Ljavax/mail/internet/InternetAddress;

    invoke-virtual {v0}, Ljavax/mail/internet/InternetAddress;->getAddress()Ljava/lang/String;

    move-result-object v0

    .line 1005
    :cond_3
    new-instance v1, Ljava/lang/StringBuilder;

    const-string v3, "MAIL FROM:"

    invoke-direct {v1, v3}, Ljava/lang/StringBuilder;-><init>(Ljava/lang/String;)V

    invoke-direct {p0, v0}, Lcom/sun/mail/smtp/SMTPTransport;->normalizeAddress(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v0

    invoke-virtual {v1, v0}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-virtual {v0}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v1

    .line 1008
    const-string v0, "DSN"

    invoke-virtual {p0, v0}, Lcom/sun/mail/smtp/SMTPTransport;->supportsExtension(Ljava/lang/String;)Z

    move-result v0

    if-eqz v0, :cond_5

    .line 1010
    iget-object v0, p0, Lcom/sun/mail/smtp/SMTPTransport;->message:Ljavax/mail/internet/MimeMessage;

    instance-of v0, v0, Lcom/sun/mail/smtp/SMTPMessage;

    if-eqz v0, :cond_e

    .line 1011
    iget-object v0, p0, Lcom/sun/mail/smtp/SMTPTransport;->message:Ljavax/mail/internet/MimeMessage;

    check-cast v0, Lcom/sun/mail/smtp/SMTPMessage;

    invoke-virtual {v0}, Lcom/sun/mail/smtp/SMTPMessage;->getDSNRet()Ljava/lang/String;

    move-result-object v0

    .line 1012
    :goto_2
    if-nez v0, :cond_4

    .line 1013
    iget-object v0, p0, Lcom/sun/mail/smtp/SMTPTransport;->session:Ljavax/mail/Session;

    new-instance v3, Ljava/lang/StringBuilder;

    const-string v4, "mail."

    invoke-direct {v3, v4}, Ljava/lang/StringBuilder;-><init>(Ljava/lang/String;)V

    iget-object v4, p0, Lcom/sun/mail/smtp/SMTPTransport;->name:Ljava/lang/String;

    invoke-virtual {v3, v4}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v3

    const-string v4, ".dsn.ret"

    invoke-virtual {v3, v4}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v3

    invoke-virtual {v3}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v3

    invoke-virtual {v0, v3}, Ljavax/mail/Session;->getProperty(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v0

    .line 1015
    :cond_4
    if-eqz v0, :cond_5

    .line 1016
    new-instance v3, Ljava/lang/StringBuilder;

    invoke-static {v1}, Ljava/lang/String;->valueOf(Ljava/lang/Object;)Ljava/lang/String;

    move-result-object v1

    invoke-direct {v3, v1}, Ljava/lang/StringBuilder;-><init>(Ljava/lang/String;)V

    const-string v1, " RET="

    invoke-virtual {v3, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1, v0}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-virtual {v0}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v0

    move-object v1, v0

    .line 1024
    :cond_5
    const-string v0, "AUTH"

    invoke-virtual {p0, v0}, Lcom/sun/mail/smtp/SMTPTransport;->supportsExtension(Ljava/lang/String;)Z

    move-result v0

    if-eqz v0, :cond_6

    .line 1026
    iget-object v0, p0, Lcom/sun/mail/smtp/SMTPTransport;->message:Ljavax/mail/internet/MimeMessage;

    instance-of v0, v0, Lcom/sun/mail/smtp/SMTPMessage;

    if-eqz v0, :cond_d

    .line 1027
    iget-object v0, p0, Lcom/sun/mail/smtp/SMTPTransport;->message:Ljavax/mail/internet/MimeMessage;

    check-cast v0, Lcom/sun/mail/smtp/SMTPMessage;

    invoke-virtual {v0}, Lcom/sun/mail/smtp/SMTPMessage;->getSubmitter()Ljava/lang/String;

    move-result-object v0

    .line 1028
    :goto_3
    if-nez v0, :cond_c

    .line 1029
    iget-object v0, p0, Lcom/sun/mail/smtp/SMTPTransport;->session:Ljavax/mail/Session;

    new-instance v3, Ljava/lang/StringBuilder;

    const-string v4, "mail."

    invoke-direct {v3, v4}, Ljava/lang/StringBuilder;-><init>(Ljava/lang/String;)V

    iget-object v4, p0, Lcom/sun/mail/smtp/SMTPTransport;->name:Ljava/lang/String;

    invoke-virtual {v3, v4}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v3

    const-string v4, ".submitter"

    invoke-virtual {v3, v4}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v3

    invoke-virtual {v3}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v3

    invoke-virtual {v0, v3}, Ljavax/mail/Session;->getProperty(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v0

    move-object v3, v0

    .line 1031
    :goto_4
    if-eqz v3, :cond_6

    .line 1033
    :try_start_0
    invoke-static {v3}, Lcom/sun/mail/smtp/SMTPTransport;->xtext(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v0

    .line 1034
    new-instance v4, Ljava/lang/StringBuilder;

    invoke-static {v1}, Ljava/lang/String;->valueOf(Ljava/lang/Object;)Ljava/lang/String;

    move-result-object v5

    invoke-direct {v4, v5}, Ljava/lang/StringBuilder;-><init>(Ljava/lang/String;)V

    const-string v5, " AUTH="

    invoke-virtual {v4, v5}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v4

    invoke-virtual {v4, v0}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-virtual {v0}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;
    :try_end_0
    .catch Ljava/lang/IllegalArgumentException; {:try_start_0 .. :try_end_0} :catch_0

    move-result-object v1

    .line 1047
    :cond_6
    :goto_5
    iget-object v0, p0, Lcom/sun/mail/smtp/SMTPTransport;->message:Ljavax/mail/internet/MimeMessage;

    instance-of v0, v0, Lcom/sun/mail/smtp/SMTPMessage;

    if-eqz v0, :cond_b

    .line 1048
    iget-object v0, p0, Lcom/sun/mail/smtp/SMTPTransport;->message:Ljavax/mail/internet/MimeMessage;

    check-cast v0, Lcom/sun/mail/smtp/SMTPMessage;

    invoke-virtual {v0}, Lcom/sun/mail/smtp/SMTPMessage;->getMailExtension()Ljava/lang/String;

    move-result-object v0

    .line 1049
    :goto_6
    if-nez v0, :cond_7

    .line 1050
    iget-object v0, p0, Lcom/sun/mail/smtp/SMTPTransport;->session:Ljavax/mail/Session;

    new-instance v2, Ljava/lang/StringBuilder;

    const-string v3, "mail."

    invoke-direct {v2, v3}, Ljava/lang/StringBuilder;-><init>(Ljava/lang/String;)V

    iget-object v3, p0, Lcom/sun/mail/smtp/SMTPTransport;->name:Ljava/lang/String;

    invoke-virtual {v2, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    const-string v3, ".mailextension"

    invoke-virtual {v2, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    invoke-virtual {v2}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v2

    invoke-virtual {v0, v2}, Ljavax/mail/Session;->getProperty(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v0

    .line 1051
    :cond_7
    if-eqz v0, :cond_8

    invoke-virtual {v0}, Ljava/lang/String;->length()I

    move-result v2

    if-lez v2, :cond_8

    .line 1052
    new-instance v2, Ljava/lang/StringBuilder;

    invoke-static {v1}, Ljava/lang/String;->valueOf(Ljava/lang/Object;)Ljava/lang/String;

    move-result-object v1

    invoke-direct {v2, v1}, Ljava/lang/StringBuilder;-><init>(Ljava/lang/String;)V

    const-string v1, " "

    invoke-virtual {v2, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1, v0}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-virtual {v0}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v1

    .line 1054
    :cond_8
    const/16 v0, 0xfa

    invoke-direct {p0, v1, v0}, Lcom/sun/mail/smtp/SMTPTransport;->issueSendCommand(Ljava/lang/String;I)V

    .line 1055
    return-void

    .line 996
    :cond_9
    iget-object v0, p0, Lcom/sun/mail/smtp/SMTPTransport;->session:Ljavax/mail/Session;

    invoke-static {v0}, Ljavax/mail/internet/InternetAddress;->getLocalAddress(Ljavax/mail/Session;)Ljavax/mail/internet/InternetAddress;

    move-result-object v0

    goto/16 :goto_1

    .line 1001
    :cond_a
    new-instance v0, Ljavax/mail/MessagingException;

    .line 1002
    const-string v1, "can\'t determine local email address"

    .line 1001
    invoke-direct {v0, v1}, Ljavax/mail/MessagingException;-><init>(Ljava/lang/String;)V

    throw v0

    .line 1035
    :catch_0
    move-exception v0

    .line 1036
    iget-boolean v4, p0, Lcom/sun/mail/smtp/SMTPTransport;->debug:Z

    if-eqz v4, :cond_6

    .line 1037
    iget-object v4, p0, Lcom/sun/mail/smtp/SMTPTransport;->out:Ljava/io/PrintStream;

    new-instance v5, Ljava/lang/StringBuilder;

    const-string v6, "DEBUG SMTP: ignoring invalid submitter: "

    invoke-direct {v5, v6}, Ljava/lang/StringBuilder;-><init>(Ljava/lang/String;)V

    .line 1038
    invoke-virtual {v5, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v3

    const-string v5, ", Exception: "

    invoke-virtual {v3, v5}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v3

    invoke-virtual {v3, v0}, Ljava/lang/StringBuilder;->append(Ljava/lang/Object;)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-virtual {v0}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v0

    .line 1037
    invoke-virtual {v4, v0}, Ljava/io/PrintStream;->println(Ljava/lang/String;)V

    goto/16 :goto_5

    :cond_b
    move-object v0, v2

    goto :goto_6

    :cond_c
    move-object v3, v0

    goto/16 :goto_4

    :cond_d
    move-object v0, v2

    goto/16 :goto_3

    :cond_e
    move-object v0, v2

    goto/16 :goto_2

    :cond_f
    move-object v0, v2

    goto/16 :goto_0
.end method

.method protected protocolConnect(Ljava/lang/String;ILjava/lang/String;Ljava/lang/String;)Z
    .locals 8
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljavax/mail/MessagingException;
        }
    .end annotation

    .prologue
    .line 372
    iget-object v0, p0, Lcom/sun/mail/smtp/SMTPTransport;->session:Ljavax/mail/Session;

    new-instance v1, Ljava/lang/StringBuilder;

    const-string v2, "mail."

    invoke-direct {v1, v2}, Ljava/lang/StringBuilder;-><init>(Ljava/lang/String;)V

    iget-object v2, p0, Lcom/sun/mail/smtp/SMTPTransport;->name:Ljava/lang/String;

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    const-string v2, ".ehlo"

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v1

    invoke-virtual {v0, v1}, Ljavax/mail/Session;->getProperty(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v0

    .line 373
    if-eqz v0, :cond_2

    const-string v1, "false"

    invoke-virtual {v0, v1}, Ljava/lang/String;->equalsIgnoreCase(Ljava/lang/String;)Z

    move-result v0

    if-eqz v0, :cond_2

    const/4 v0, 0x0

    .line 375
    :goto_0
    iget-object v1, p0, Lcom/sun/mail/smtp/SMTPTransport;->session:Ljavax/mail/Session;

    new-instance v2, Ljava/lang/StringBuilder;

    const-string v3, "mail."

    invoke-direct {v2, v3}, Ljava/lang/StringBuilder;-><init>(Ljava/lang/String;)V

    iget-object v3, p0, Lcom/sun/mail/smtp/SMTPTransport;->name:Ljava/lang/String;

    invoke-virtual {v2, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    const-string v3, ".auth"

    invoke-virtual {v2, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    invoke-virtual {v2}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v2

    invoke-virtual {v1, v2}, Ljavax/mail/Session;->getProperty(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v1

    .line 376
    if-eqz v1, :cond_3

    const-string v2, "true"

    invoke-virtual {v1, v2}, Ljava/lang/String;->equalsIgnoreCase(Ljava/lang/String;)Z

    move-result v1

    if-eqz v1, :cond_3

    const/4 v1, 0x1

    move v2, v1

    .line 378
    :goto_1
    iget-boolean v1, p0, Lcom/sun/mail/smtp/SMTPTransport;->debug:Z

    if-eqz v1, :cond_0

    .line 379
    iget-object v1, p0, Lcom/sun/mail/smtp/SMTPTransport;->out:Ljava/io/PrintStream;

    new-instance v3, Ljava/lang/StringBuilder;

    const-string v4, "DEBUG SMTP: useEhlo "

    invoke-direct {v3, v4}, Ljava/lang/StringBuilder;-><init>(Ljava/lang/String;)V

    invoke-virtual {v3, v0}, Ljava/lang/StringBuilder;->append(Z)Ljava/lang/StringBuilder;

    move-result-object v3

    .line 380
    const-string v4, ", useAuth "

    invoke-virtual {v3, v4}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v3

    invoke-virtual {v3, v2}, Ljava/lang/StringBuilder;->append(Z)Ljava/lang/StringBuilder;

    move-result-object v3

    invoke-virtual {v3}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v3

    .line 379
    invoke-virtual {v1, v3}, Ljava/io/PrintStream;->println(Ljava/lang/String;)V

    .line 388
    :cond_0
    if-eqz v2, :cond_4

    if-eqz p3, :cond_1

    if-nez p4, :cond_4

    .line 389
    :cond_1
    const/4 v0, 0x0

    .line 548
    :goto_2
    return v0

    .line 373
    :cond_2
    const/4 v0, 0x1

    goto :goto_0

    .line 376
    :cond_3
    const/4 v1, 0x0

    move v2, v1

    goto :goto_1

    .line 395
    :cond_4
    const/4 v1, -0x1

    if-ne p2, v1, :cond_5

    .line 396
    iget-object v1, p0, Lcom/sun/mail/smtp/SMTPTransport;->session:Ljavax/mail/Session;

    new-instance v3, Ljava/lang/StringBuilder;

    const-string v4, "mail."

    invoke-direct {v3, v4}, Ljava/lang/StringBuilder;-><init>(Ljava/lang/String;)V

    iget-object v4, p0, Lcom/sun/mail/smtp/SMTPTransport;->name:Ljava/lang/String;

    invoke-virtual {v3, v4}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v3

    const-string v4, ".port"

    invoke-virtual {v3, v4}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v3

    invoke-virtual {v3}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v3

    invoke-virtual {v1, v3}, Ljavax/mail/Session;->getProperty(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v1

    .line 397
    if-eqz v1, :cond_10

    .line 398
    invoke-static {v1}, Ljava/lang/Integer;->parseInt(Ljava/lang/String;)I

    move-result p2

    .line 404
    :cond_5
    :goto_3
    if-eqz p1, :cond_6

    invoke-virtual {p1}, Ljava/lang/String;->length()I

    move-result v1

    if-nez v1, :cond_1e

    .line 405
    :cond_6
    const-string v1, "localhost"

    .line 407
    :goto_4
    const/4 v3, 0x0

    .line 409
    iget-object v4, p0, Lcom/sun/mail/smtp/SMTPTransport;->serverSocket:Ljava/net/Socket;

    if-eqz v4, :cond_11

    .line 410
    invoke-direct {p0}, Lcom/sun/mail/smtp/SMTPTransport;->openServer()V

    .line 414
    :goto_5
    if-eqz v0, :cond_1d

    .line 415
    invoke-virtual {p0}, Lcom/sun/mail/smtp/SMTPTransport;->getLocalHost()Ljava/lang/String;

    move-result-object v0

    invoke-virtual {p0, v0}, Lcom/sun/mail/smtp/SMTPTransport;->ehlo(Ljava/lang/String;)Z

    move-result v0

    .line 416
    :goto_6
    if-nez v0, :cond_7

    .line 417
    invoke-virtual {p0}, Lcom/sun/mail/smtp/SMTPTransport;->getLocalHost()Ljava/lang/String;

    move-result-object v0

    invoke-virtual {p0, v0}, Lcom/sun/mail/smtp/SMTPTransport;->helo(Ljava/lang/String;)V

    .line 419
    :cond_7
    iget-boolean v0, p0, Lcom/sun/mail/smtp/SMTPTransport;->useStartTLS:Z

    if-eqz v0, :cond_8

    const-string v0, "STARTTLS"

    invoke-virtual {p0, v0}, Lcom/sun/mail/smtp/SMTPTransport;->supportsExtension(Ljava/lang/String;)Z

    move-result v0

    if-eqz v0, :cond_8

    .line 420
    invoke-virtual {p0}, Lcom/sun/mail/smtp/SMTPTransport;->startTLS()V

    .line 426
    invoke-virtual {p0}, Lcom/sun/mail/smtp/SMTPTransport;->getLocalHost()Ljava/lang/String;

    move-result-object v0

    invoke-virtual {p0, v0}, Lcom/sun/mail/smtp/SMTPTransport;->ehlo(Ljava/lang/String;)Z

    .line 429
    :cond_8
    if-nez v2, :cond_9

    if-eqz p3, :cond_1a

    if-eqz p4, :cond_1a

    .line 430
    :cond_9
    const-string v0, "AUTH"

    invoke-virtual {p0, v0}, Lcom/sun/mail/smtp/SMTPTransport;->supportsExtension(Ljava/lang/String;)Z

    move-result v0

    if-nez v0, :cond_a

    const-string v0, "AUTH=LOGIN"

    invoke-virtual {p0, v0}, Lcom/sun/mail/smtp/SMTPTransport;->supportsExtension(Ljava/lang/String;)Z

    move-result v0

    if-eqz v0, :cond_1a

    .line 431
    :cond_a
    iget-boolean v0, p0, Lcom/sun/mail/smtp/SMTPTransport;->debug:Z

    if-eqz v0, :cond_b

    .line 432
    iget-object v0, p0, Lcom/sun/mail/smtp/SMTPTransport;->out:Ljava/io/PrintStream;

    const-string v2, "DEBUG SMTP: Attempt to authenticate"

    invoke-virtual {v0, v2}, Ljava/io/PrintStream;->println(Ljava/lang/String;)V

    .line 433
    const-string v0, "LOGIN"

    invoke-virtual {p0, v0}, Lcom/sun/mail/smtp/SMTPTransport;->supportsAuthentication(Ljava/lang/String;)Z

    move-result v0

    if-nez v0, :cond_b

    .line 434
    const-string v0, "AUTH=LOGIN"

    invoke-virtual {p0, v0}, Lcom/sun/mail/smtp/SMTPTransport;->supportsExtension(Ljava/lang/String;)Z

    move-result v0

    if-eqz v0, :cond_b

    .line 435
    iget-object v0, p0, Lcom/sun/mail/smtp/SMTPTransport;->out:Ljava/io/PrintStream;

    const-string v2, "DEBUG SMTP: use AUTH=LOGIN hack"

    invoke-virtual {v0, v2}, Ljava/io/PrintStream;->println(Ljava/lang/String;)V

    .line 438
    :cond_b
    const-string v0, "LOGIN"

    invoke-virtual {p0, v0}, Lcom/sun/mail/smtp/SMTPTransport;->supportsAuthentication(Ljava/lang/String;)Z

    move-result v0

    if-nez v0, :cond_c

    .line 439
    const-string v0, "AUTH=LOGIN"

    invoke-virtual {p0, v0}, Lcom/sun/mail/smtp/SMTPTransport;->supportsExtension(Ljava/lang/String;)Z

    move-result v0

    if-eqz v0, :cond_13

    .line 441
    :cond_c
    const-string v0, "AUTH LOGIN"

    invoke-virtual {p0, v0}, Lcom/sun/mail/smtp/SMTPTransport;->simpleCommand(Ljava/lang/String;)I

    move-result v0

    .line 447
    const/16 v1, 0x212

    if-ne v0, v1, :cond_d

    .line 448
    invoke-virtual {p0}, Lcom/sun/mail/smtp/SMTPTransport;->startTLS()V

    .line 449
    const-string v0, "AUTH LOGIN"

    invoke-virtual {p0, v0}, Lcom/sun/mail/smtp/SMTPTransport;->simpleCommand(Ljava/lang/String;)I

    move-result v0

    .line 462
    :cond_d
    :try_start_0
    new-instance v1, Ljava/io/ByteArrayOutputStream;

    invoke-direct {v1}, Ljava/io/ByteArrayOutputStream;-><init>()V

    .line 464
    new-instance v2, Lcom/sun/mail/util/BASE64EncoderStream;

    const v3, 0x7fffffff

    invoke-direct {v2, v1, v3}, Lcom/sun/mail/util/BASE64EncoderStream;-><init>(Ljava/io/OutputStream;I)V

    .line 466
    const/16 v3, 0x14e

    if-ne v0, v3, :cond_e

    .line 468
    invoke-static {p3}, Lcom/sun/mail/util/ASCIIUtility;->getBytes(Ljava/lang/String;)[B

    move-result-object v3

    invoke-virtual {v2, v3}, Ljava/io/OutputStream;->write([B)V

    .line 469
    invoke-virtual {v2}, Ljava/io/OutputStream;->flush()V

    .line 472
    invoke-virtual {v1}, Ljava/io/ByteArrayOutputStream;->toByteArray()[B

    move-result-object v3

    invoke-virtual {p0, v3}, Lcom/sun/mail/smtp/SMTPTransport;->simpleCommand([B)I

    move-result v0

    .line 473
    invoke-virtual {v1}, Ljava/io/ByteArrayOutputStream;->reset()V

    .line 475
    :cond_e
    const/16 v3, 0x14e

    if-ne v0, v3, :cond_f

    .line 477
    invoke-static {p4}, Lcom/sun/mail/util/ASCIIUtility;->getBytes(Ljava/lang/String;)[B

    move-result-object v3

    invoke-virtual {v2, v3}, Ljava/io/OutputStream;->write([B)V

    .line 478
    invoke-virtual {v2}, Ljava/io/OutputStream;->flush()V

    .line 481
    invoke-virtual {v1}, Ljava/io/ByteArrayOutputStream;->toByteArray()[B

    move-result-object v2

    invoke-virtual {p0, v2}, Lcom/sun/mail/smtp/SMTPTransport;->simpleCommand([B)I

    move-result v0

    .line 482
    invoke-virtual {v1}, Ljava/io/ByteArrayOutputStream;->reset()V
    :try_end_0
    .catch Ljava/io/IOException; {:try_start_0 .. :try_end_0} :catch_0
    .catchall {:try_start_0 .. :try_end_0} :catchall_0

    .line 486
    :cond_f
    const/16 v1, 0xeb

    if-eq v0, v1, :cond_1a

    .line 487
    invoke-direct {p0}, Lcom/sun/mail/smtp/SMTPTransport;->closeConnection()V

    .line 488
    const/4 v0, 0x0

    goto/16 :goto_2

    .line 400
    :cond_10
    iget p2, p0, Lcom/sun/mail/smtp/SMTPTransport;->defaultPort:I

    goto/16 :goto_3

    .line 412
    :cond_11
    invoke-direct {p0, v1, p2}, Lcom/sun/mail/smtp/SMTPTransport;->openServer(Ljava/lang/String;I)V

    goto/16 :goto_5

    .line 484
    :catch_0
    move-exception v1

    .line 486
    const/16 v1, 0xeb

    if-eq v0, v1, :cond_1a

    .line 487
    invoke-direct {p0}, Lcom/sun/mail/smtp/SMTPTransport;->closeConnection()V

    .line 488
    const/4 v0, 0x0

    goto/16 :goto_2

    .line 485
    :catchall_0
    move-exception v1

    move-object v7, v1

    move v1, v0

    move-object v0, v7

    .line 486
    const/16 v2, 0xeb

    if-eq v1, v2, :cond_12

    .line 487
    invoke-direct {p0}, Lcom/sun/mail/smtp/SMTPTransport;->closeConnection()V

    .line 488
    const/4 v0, 0x0

    goto/16 :goto_2

    .line 490
    :cond_12
    throw v0

    .line 491
    :cond_13
    const-string v0, "PLAIN"

    invoke-virtual {p0, v0}, Lcom/sun/mail/smtp/SMTPTransport;->supportsAuthentication(Ljava/lang/String;)Z

    move-result v0

    if-eqz v0, :cond_15

    .line 493
    const-string v0, "AUTH PLAIN"

    invoke-virtual {p0, v0}, Lcom/sun/mail/smtp/SMTPTransport;->simpleCommand(Ljava/lang/String;)I

    move-result v1

    .line 495
    :try_start_1
    new-instance v0, Ljava/io/ByteArrayOutputStream;

    invoke-direct {v0}, Ljava/io/ByteArrayOutputStream;-><init>()V

    .line 497
    new-instance v2, Lcom/sun/mail/util/BASE64EncoderStream;

    const v3, 0x7fffffff

    invoke-direct {v2, v0, v3}, Lcom/sun/mail/util/BASE64EncoderStream;-><init>(Ljava/io/OutputStream;I)V

    .line 498
    const/16 v3, 0x14e

    if-ne v1, v3, :cond_1c

    .line 501
    const/4 v3, 0x0

    invoke-virtual {v2, v3}, Ljava/io/OutputStream;->write(I)V

    .line 502
    invoke-static {p3}, Lcom/sun/mail/util/ASCIIUtility;->getBytes(Ljava/lang/String;)[B

    move-result-object v3

    invoke-virtual {v2, v3}, Ljava/io/OutputStream;->write([B)V

    .line 503
    const/4 v3, 0x0

    invoke-virtual {v2, v3}, Ljava/io/OutputStream;->write(I)V

    .line 504
    invoke-static {p4}, Lcom/sun/mail/util/ASCIIUtility;->getBytes(Ljava/lang/String;)[B

    move-result-object v3

    invoke-virtual {v2, v3}, Ljava/io/OutputStream;->write([B)V

    .line 505
    invoke-virtual {v2}, Ljava/io/OutputStream;->flush()V

    .line 508
    invoke-virtual {v0}, Ljava/io/ByteArrayOutputStream;->toByteArray()[B

    move-result-object v0

    invoke-virtual {p0, v0}, Lcom/sun/mail/smtp/SMTPTransport;->simpleCommand([B)I
    :try_end_1
    .catch Ljava/io/IOException; {:try_start_1 .. :try_end_1} :catch_1
    .catchall {:try_start_1 .. :try_end_1} :catchall_1

    move-result v0

    .line 512
    :goto_7
    const/16 v1, 0xeb

    if-eq v0, v1, :cond_1a

    .line 513
    invoke-direct {p0}, Lcom/sun/mail/smtp/SMTPTransport;->closeConnection()V

    .line 514
    const/4 v0, 0x0

    goto/16 :goto_2

    .line 510
    :catch_1
    move-exception v0

    .line 512
    const/16 v0, 0xeb

    if-eq v1, v0, :cond_1a

    .line 513
    invoke-direct {p0}, Lcom/sun/mail/smtp/SMTPTransport;->closeConnection()V

    .line 514
    const/4 v0, 0x0

    goto/16 :goto_2

    .line 511
    :catchall_1
    move-exception v0

    .line 512
    const/16 v2, 0xeb

    if-eq v1, v2, :cond_14

    .line 513
    invoke-direct {p0}, Lcom/sun/mail/smtp/SMTPTransport;->closeConnection()V

    .line 514
    const/4 v0, 0x0

    goto/16 :goto_2

    .line 516
    :cond_14
    throw v0

    .line 517
    :cond_15
    const-string v0, "DIGEST-MD5"

    invoke-virtual {p0, v0}, Lcom/sun/mail/smtp/SMTPTransport;->supportsAuthentication(Ljava/lang/String;)Z

    move-result v0

    if-eqz v0, :cond_1a

    .line 518
    invoke-direct {p0}, Lcom/sun/mail/smtp/SMTPTransport;->getMD5()Lcom/sun/mail/smtp/DigestMD5;

    move-result-object v0

    if-eqz v0, :cond_1a

    .line 519
    const-string v2, "AUTH DIGEST-MD5"

    invoke-virtual {p0, v2}, Lcom/sun/mail/smtp/SMTPTransport;->simpleCommand(Ljava/lang/String;)I

    move-result v6

    .line 521
    const/16 v2, 0x14e

    if-ne v6, v2, :cond_1b

    .line 523
    :try_start_2
    invoke-virtual {p0}, Lcom/sun/mail/smtp/SMTPTransport;->getSASLRealm()Ljava/lang/String;

    move-result-object v4

    iget-object v5, p0, Lcom/sun/mail/smtp/SMTPTransport;->lastServerResponse:Ljava/lang/String;

    move-object v2, p3

    move-object v3, p4

    .line 522
    invoke-virtual/range {v0 .. v5}, Lcom/sun/mail/smtp/DigestMD5;->authClient(Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;)[B

    move-result-object v1

    .line 524
    invoke-virtual {p0, v1}, Lcom/sun/mail/smtp/SMTPTransport;->simpleCommand([B)I
    :try_end_2
    .catch Ljava/lang/Exception; {:try_start_2 .. :try_end_2} :catch_2
    .catchall {:try_start_2 .. :try_end_2} :catchall_2

    move-result v1

    .line 525
    const/16 v2, 0x14e

    if-ne v1, v2, :cond_16

    .line 526
    :try_start_3
    iget-object v2, p0, Lcom/sun/mail/smtp/SMTPTransport;->lastServerResponse:Ljava/lang/String;

    invoke-virtual {v0, v2}, Lcom/sun/mail/smtp/DigestMD5;->authServer(Ljava/lang/String;)Z
    :try_end_3
    .catch Ljava/lang/Exception; {:try_start_3 .. :try_end_3} :catch_3
    .catchall {:try_start_3 .. :try_end_3} :catchall_3

    move-result v0

    if-nez v0, :cond_17

    .line 528
    const/4 v1, -0x1

    .line 539
    :cond_16
    :goto_8
    const/16 v0, 0xeb

    if-eq v1, v0, :cond_1a

    .line 540
    invoke-direct {p0}, Lcom/sun/mail/smtp/SMTPTransport;->closeConnection()V

    .line 541
    const/4 v0, 0x0

    goto/16 :goto_2

    .line 531
    :cond_17
    const/4 v0, 0x0

    :try_start_4
    new-array v0, v0, [B

    invoke-virtual {p0, v0}, Lcom/sun/mail/smtp/SMTPTransport;->simpleCommand([B)I
    :try_end_4
    .catch Ljava/lang/Exception; {:try_start_4 .. :try_end_4} :catch_3
    .catchall {:try_start_4 .. :try_end_4} :catchall_3

    move-result v1

    goto :goto_8

    .line 535
    :catch_2
    move-exception v0

    move v1, v6

    .line 536
    :goto_9
    :try_start_5
    iget-boolean v2, p0, Lcom/sun/mail/smtp/SMTPTransport;->debug:Z

    if-eqz v2, :cond_18

    .line 537
    iget-object v2, p0, Lcom/sun/mail/smtp/SMTPTransport;->out:Ljava/io/PrintStream;

    new-instance v3, Ljava/lang/StringBuilder;

    const-string v4, "DEBUG SMTP: DIGEST-MD5: "

    invoke-direct {v3, v4}, Ljava/lang/StringBuilder;-><init>(Ljava/lang/String;)V

    invoke-virtual {v3, v0}, Ljava/lang/StringBuilder;->append(Ljava/lang/Object;)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-virtual {v0}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v0

    invoke-virtual {v2, v0}, Ljava/io/PrintStream;->println(Ljava/lang/String;)V
    :try_end_5
    .catchall {:try_start_5 .. :try_end_5} :catchall_3

    .line 539
    :cond_18
    const/16 v0, 0xeb

    if-eq v1, v0, :cond_1a

    .line 540
    invoke-direct {p0}, Lcom/sun/mail/smtp/SMTPTransport;->closeConnection()V

    .line 541
    const/4 v0, 0x0

    goto/16 :goto_2

    .line 538
    :catchall_2
    move-exception v0

    move v1, v6

    .line 539
    :goto_a
    const/16 v2, 0xeb

    if-eq v1, v2, :cond_19

    .line 540
    invoke-direct {p0}, Lcom/sun/mail/smtp/SMTPTransport;->closeConnection()V

    .line 541
    const/4 v0, 0x0

    goto/16 :goto_2

    .line 543
    :cond_19
    throw v0

    .line 548
    :cond_1a
    const/4 v0, 0x1

    goto/16 :goto_2

    .line 538
    :catchall_3
    move-exception v0

    goto :goto_a

    .line 535
    :catch_3
    move-exception v0

    goto :goto_9

    :cond_1b
    move v1, v6

    goto :goto_8

    :cond_1c
    move v0, v1

    goto/16 :goto_7

    :cond_1d
    move v0, v3

    goto/16 :goto_6

    :cond_1e
    move-object v1, p1

    goto/16 :goto_4
.end method

.method protected rcptTo()V
    .locals 14
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljavax/mail/MessagingException;
        }
    .end annotation

    .prologue
    .line 1079
    new-instance v9, Ljava/util/Vector;

    invoke-direct {v9}, Ljava/util/Vector;-><init>()V

    .line 1080
    new-instance v10, Ljava/util/Vector;

    invoke-direct {v10}, Ljava/util/Vector;-><init>()V

    .line 1081
    new-instance v11, Ljava/util/Vector;

    invoke-direct {v11}, Ljava/util/Vector;-><init>()V

    .line 1083
    const/4 v6, 0x0

    .line 1084
    const/4 v4, 0x0

    .line 1086
    const/4 v0, 0x0

    iput-object v0, p0, Lcom/sun/mail/smtp/SMTPTransport;->invalidAddr:[Ljavax/mail/Address;

    iput-object v0, p0, Lcom/sun/mail/smtp/SMTPTransport;->validUnsentAddr:[Ljavax/mail/Address;

    iput-object v0, p0, Lcom/sun/mail/smtp/SMTPTransport;->validSentAddr:[Ljavax/mail/Address;

    .line 1087
    const/4 v0, 0x0

    .line 1088
    iget-object v1, p0, Lcom/sun/mail/smtp/SMTPTransport;->message:Ljavax/mail/internet/MimeMessage;

    instance-of v1, v1, Lcom/sun/mail/smtp/SMTPMessage;

    if-eqz v1, :cond_0

    .line 1089
    iget-object v0, p0, Lcom/sun/mail/smtp/SMTPTransport;->message:Ljavax/mail/internet/MimeMessage;

    check-cast v0, Lcom/sun/mail/smtp/SMTPMessage;

    invoke-virtual {v0}, Lcom/sun/mail/smtp/SMTPMessage;->getSendPartial()Z

    move-result v0

    .line 1090
    :cond_0
    if-nez v0, :cond_25

    .line 1091
    iget-object v0, p0, Lcom/sun/mail/smtp/SMTPTransport;->session:Ljavax/mail/Session;

    new-instance v1, Ljava/lang/StringBuilder;

    const-string v2, "mail."

    invoke-direct {v1, v2}, Ljava/lang/StringBuilder;-><init>(Ljava/lang/String;)V

    iget-object v2, p0, Lcom/sun/mail/smtp/SMTPTransport;->name:Ljava/lang/String;

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    const-string v2, ".sendpartial"

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v1

    invoke-virtual {v0, v1}, Ljavax/mail/Session;->getProperty(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v0

    .line 1092
    if-eqz v0, :cond_a

    const-string v1, "true"

    invoke-virtual {v0, v1}, Ljava/lang/String;->equalsIgnoreCase(Ljava/lang/String;)Z

    move-result v0

    if-eqz v0, :cond_a

    const/4 v0, 0x1

    :goto_0
    move v1, v0

    .line 1094
    :goto_1
    iget-boolean v0, p0, Lcom/sun/mail/smtp/SMTPTransport;->debug:Z

    if-eqz v0, :cond_1

    if-eqz v1, :cond_1

    .line 1095
    iget-object v0, p0, Lcom/sun/mail/smtp/SMTPTransport;->out:Ljava/io/PrintStream;

    const-string v2, "DEBUG SMTP: sendPartial set"

    invoke-virtual {v0, v2}, Ljava/io/PrintStream;->println(Ljava/lang/String;)V

    .line 1097
    :cond_1
    const/4 v2, 0x0

    .line 1098
    const/4 v0, 0x0

    .line 1099
    const-string v3, "DSN"

    invoke-virtual {p0, v3}, Lcom/sun/mail/smtp/SMTPTransport;->supportsExtension(Ljava/lang/String;)Z

    move-result v3

    if-eqz v3, :cond_24

    .line 1100
    iget-object v3, p0, Lcom/sun/mail/smtp/SMTPTransport;->message:Ljavax/mail/internet/MimeMessage;

    instance-of v3, v3, Lcom/sun/mail/smtp/SMTPMessage;

    if-eqz v3, :cond_2

    .line 1101
    iget-object v0, p0, Lcom/sun/mail/smtp/SMTPTransport;->message:Ljavax/mail/internet/MimeMessage;

    check-cast v0, Lcom/sun/mail/smtp/SMTPMessage;

    invoke-virtual {v0}, Lcom/sun/mail/smtp/SMTPMessage;->getDSNNotify()Ljava/lang/String;

    move-result-object v0

    .line 1102
    :cond_2
    if-nez v0, :cond_3

    .line 1103
    iget-object v0, p0, Lcom/sun/mail/smtp/SMTPTransport;->session:Ljavax/mail/Session;

    new-instance v3, Ljava/lang/StringBuilder;

    const-string v5, "mail."

    invoke-direct {v3, v5}, Ljava/lang/StringBuilder;-><init>(Ljava/lang/String;)V

    iget-object v5, p0, Lcom/sun/mail/smtp/SMTPTransport;->name:Ljava/lang/String;

    invoke-virtual {v3, v5}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v3

    const-string v5, ".dsn.notify"

    invoke-virtual {v3, v5}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v3

    invoke-virtual {v3}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v3

    invoke-virtual {v0, v3}, Ljavax/mail/Session;->getProperty(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v0

    .line 1105
    :cond_3
    if-eqz v0, :cond_23

    .line 1106
    const/4 v2, 0x1

    move v3, v2

    move-object v2, v0

    .line 1110
    :goto_2
    const/4 v0, 0x0

    move v7, v0

    :goto_3
    iget-object v0, p0, Lcom/sun/mail/smtp/SMTPTransport;->addresses:[Ljavax/mail/Address;

    array-length v0, v0

    if-lt v7, v0, :cond_b

    .line 1204
    if-eqz v1, :cond_4

    invoke-virtual {v9}, Ljava/util/Vector;->size()I

    move-result v0

    if-nez v0, :cond_4

    .line 1205
    const/4 v4, 0x1

    .line 1208
    :cond_4
    if-eqz v4, :cond_1a

    .line 1210
    invoke-virtual {v11}, Ljava/util/Vector;->size()I

    move-result v0

    new-array v0, v0, [Ljavax/mail/Address;

    iput-object v0, p0, Lcom/sun/mail/smtp/SMTPTransport;->invalidAddr:[Ljavax/mail/Address;

    .line 1211
    iget-object v0, p0, Lcom/sun/mail/smtp/SMTPTransport;->invalidAddr:[Ljavax/mail/Address;

    invoke-virtual {v11, v0}, Ljava/util/Vector;->copyInto([Ljava/lang/Object;)V

    .line 1214
    invoke-virtual {v9}, Ljava/util/Vector;->size()I

    move-result v0

    invoke-virtual {v10}, Ljava/util/Vector;->size()I

    move-result v1

    add-int/2addr v0, v1

    new-array v0, v0, [Ljavax/mail/Address;

    iput-object v0, p0, Lcom/sun/mail/smtp/SMTPTransport;->validUnsentAddr:[Ljavax/mail/Address;

    .line 1215
    const/4 v1, 0x0

    .line 1216
    const/4 v0, 0x0

    move v2, v1

    move v1, v0

    :goto_4
    invoke-virtual {v9}, Ljava/util/Vector;->size()I

    move-result v0

    if-lt v1, v0, :cond_18

    .line 1218
    const/4 v0, 0x0

    move v1, v0

    :goto_5
    invoke-virtual {v10}, Ljava/util/Vector;->size()I

    move-result v0

    if-lt v1, v0, :cond_19

    .line 1244
    :goto_6
    iget-boolean v0, p0, Lcom/sun/mail/smtp/SMTPTransport;->debug:Z

    if-eqz v0, :cond_7

    .line 1245
    iget-object v0, p0, Lcom/sun/mail/smtp/SMTPTransport;->validSentAddr:[Ljavax/mail/Address;

    if-eqz v0, :cond_5

    iget-object v0, p0, Lcom/sun/mail/smtp/SMTPTransport;->validSentAddr:[Ljavax/mail/Address;

    array-length v0, v0

    if-lez v0, :cond_5

    .line 1246
    iget-object v0, p0, Lcom/sun/mail/smtp/SMTPTransport;->out:Ljava/io/PrintStream;

    const-string v1, "DEBUG SMTP: Verified Addresses"

    invoke-virtual {v0, v1}, Ljava/io/PrintStream;->println(Ljava/lang/String;)V

    .line 1247
    const/4 v0, 0x0

    :goto_7
    iget-object v1, p0, Lcom/sun/mail/smtp/SMTPTransport;->validSentAddr:[Ljavax/mail/Address;

    array-length v1, v1

    if-lt v0, v1, :cond_1d

    .line 1251
    :cond_5
    iget-object v0, p0, Lcom/sun/mail/smtp/SMTPTransport;->validUnsentAddr:[Ljavax/mail/Address;

    if-eqz v0, :cond_6

    iget-object v0, p0, Lcom/sun/mail/smtp/SMTPTransport;->validUnsentAddr:[Ljavax/mail/Address;

    array-length v0, v0

    if-lez v0, :cond_6

    .line 1252
    iget-object v0, p0, Lcom/sun/mail/smtp/SMTPTransport;->out:Ljava/io/PrintStream;

    const-string v1, "DEBUG SMTP: Valid Unsent Addresses"

    invoke-virtual {v0, v1}, Ljava/io/PrintStream;->println(Ljava/lang/String;)V

    .line 1253
    const/4 v0, 0x0

    :goto_8
    iget-object v1, p0, Lcom/sun/mail/smtp/SMTPTransport;->validUnsentAddr:[Ljavax/mail/Address;

    array-length v1, v1

    if-lt v0, v1, :cond_1e

    .line 1257
    :cond_6
    iget-object v0, p0, Lcom/sun/mail/smtp/SMTPTransport;->invalidAddr:[Ljavax/mail/Address;

    if-eqz v0, :cond_7

    iget-object v0, p0, Lcom/sun/mail/smtp/SMTPTransport;->invalidAddr:[Ljavax/mail/Address;

    array-length v0, v0

    if-lez v0, :cond_7

    .line 1258
    iget-object v0, p0, Lcom/sun/mail/smtp/SMTPTransport;->out:Ljava/io/PrintStream;

    const-string v1, "DEBUG SMTP: Invalid Addresses"

    invoke-virtual {v0, v1}, Ljava/io/PrintStream;->println(Ljava/lang/String;)V

    .line 1259
    const/4 v0, 0x0

    :goto_9
    iget-object v1, p0, Lcom/sun/mail/smtp/SMTPTransport;->invalidAddr:[Ljavax/mail/Address;

    array-length v1, v1

    if-lt v0, v1, :cond_1f

    .line 1266
    :cond_7
    if-eqz v4, :cond_21

    .line 1267
    iget-boolean v0, p0, Lcom/sun/mail/smtp/SMTPTransport;->debug:Z

    if-eqz v0, :cond_8

    .line 1268
    iget-object v0, p0, Lcom/sun/mail/smtp/SMTPTransport;->out:Ljava/io/PrintStream;

    const-string v1, "DEBUG SMTP: Sending failed because of invalid destination addresses"

    invoke-virtual {v0, v1}, Ljava/io/PrintStream;->println(Ljava/lang/String;)V

    .line 1270
    :cond_8
    const/4 v1, 0x2

    .line 1271
    iget-object v2, p0, Lcom/sun/mail/smtp/SMTPTransport;->validSentAddr:[Ljavax/mail/Address;

    iget-object v3, p0, Lcom/sun/mail/smtp/SMTPTransport;->validUnsentAddr:[Ljavax/mail/Address;

    .line 1272
    iget-object v4, p0, Lcom/sun/mail/smtp/SMTPTransport;->invalidAddr:[Ljavax/mail/Address;

    iget-object v5, p0, Lcom/sun/mail/smtp/SMTPTransport;->message:Ljavax/mail/internet/MimeMessage;

    move-object v0, p0

    .line 1270
    invoke-virtual/range {v0 .. v5}, Lcom/sun/mail/smtp/SMTPTransport;->notifyTransportListeners(I[Ljavax/mail/Address;[Ljavax/mail/Address;[Ljavax/mail/Address;Ljavax/mail/Message;)V

    .line 1275
    iget-object v1, p0, Lcom/sun/mail/smtp/SMTPTransport;->lastServerResponse:Ljava/lang/String;

    .line 1276
    iget v2, p0, Lcom/sun/mail/smtp/SMTPTransport;->lastReturnCode:I

    .line 1278
    :try_start_0
    iget-object v0, p0, Lcom/sun/mail/smtp/SMTPTransport;->serverSocket:Ljava/net/Socket;

    if-eqz v0, :cond_9

    .line 1279
    const-string v0, "RSET"

    const/16 v3, 0xfa

    invoke-virtual {p0, v0, v3}, Lcom/sun/mail/smtp/SMTPTransport;->issueCommand(Ljava/lang/String;I)V
    :try_end_0
    .catch Ljavax/mail/MessagingException; {:try_start_0 .. :try_end_0} :catch_0
    .catchall {:try_start_0 .. :try_end_0} :catchall_0

    .line 1290
    :cond_9
    iput-object v1, p0, Lcom/sun/mail/smtp/SMTPTransport;->lastServerResponse:Ljava/lang/String;

    .line 1291
    iput v2, p0, Lcom/sun/mail/smtp/SMTPTransport;->lastReturnCode:I

    .line 1294
    :goto_a
    new-instance v0, Ljavax/mail/SendFailedException;

    const-string v1, "Invalid Addresses"

    .line 1295
    iget-object v3, p0, Lcom/sun/mail/smtp/SMTPTransport;->validSentAddr:[Ljavax/mail/Address;

    .line 1296
    iget-object v4, p0, Lcom/sun/mail/smtp/SMTPTransport;->validUnsentAddr:[Ljavax/mail/Address;

    iget-object v5, p0, Lcom/sun/mail/smtp/SMTPTransport;->invalidAddr:[Ljavax/mail/Address;

    move-object v2, v6

    .line 1294
    invoke-direct/range {v0 .. v5}, Ljavax/mail/SendFailedException;-><init>(Ljava/lang/String;Ljava/lang/Exception;[Ljavax/mail/Address;[Ljavax/mail/Address;[Ljavax/mail/Address;)V

    throw v0

    .line 1092
    :cond_a
    const/4 v0, 0x0

    goto/16 :goto_0

    .line 1113
    :cond_b
    iget-object v0, p0, Lcom/sun/mail/smtp/SMTPTransport;->addresses:[Ljavax/mail/Address;

    aget-object v0, v0, v7

    check-cast v0, Ljavax/mail/internet/InternetAddress;

    .line 1114
    new-instance v5, Ljava/lang/StringBuilder;

    const-string v8, "RCPT TO:"

    invoke-direct {v5, v8}, Ljava/lang/StringBuilder;-><init>(Ljava/lang/String;)V

    invoke-virtual {v0}, Ljavax/mail/internet/InternetAddress;->getAddress()Ljava/lang/String;

    move-result-object v8

    invoke-direct {p0, v8}, Lcom/sun/mail/smtp/SMTPTransport;->normalizeAddress(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v8

    invoke-virtual {v5, v8}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v5

    invoke-virtual {v5}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v5

    .line 1115
    if-eqz v3, :cond_22

    .line 1116
    new-instance v8, Ljava/lang/StringBuilder;

    invoke-static {v5}, Ljava/lang/String;->valueOf(Ljava/lang/Object;)Ljava/lang/String;

    move-result-object v5

    invoke-direct {v8, v5}, Ljava/lang/StringBuilder;-><init>(Ljava/lang/String;)V

    const-string v5, " NOTIFY="

    invoke-virtual {v8, v5}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v5

    invoke-virtual {v5, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v5

    invoke-virtual {v5}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v5

    move-object v8, v5

    .line 1118
    :goto_b
    invoke-virtual {p0, v8}, Lcom/sun/mail/smtp/SMTPTransport;->sendCommand(Ljava/lang/String;)V

    .line 1120
    invoke-virtual {p0}, Lcom/sun/mail/smtp/SMTPTransport;->readServerResponse()I

    move-result v12

    .line 1121
    sparse-switch v12, :sswitch_data_0

    .line 1169
    const/16 v5, 0x190

    if-lt v12, v5, :cond_13

    const/16 v5, 0x1f3

    if-gt v12, v5, :cond_13

    .line 1171
    invoke-virtual {v10, v0}, Ljava/util/Vector;->addElement(Ljava/lang/Object;)V

    .line 1189
    :goto_c
    if-nez v1, :cond_c

    .line 1190
    const/4 v4, 0x1

    .line 1192
    :cond_c
    new-instance v5, Lcom/sun/mail/smtp/SMTPAddressFailedException;

    .line 1193
    iget-object v13, p0, Lcom/sun/mail/smtp/SMTPTransport;->lastServerResponse:Ljava/lang/String;

    .line 1192
    invoke-direct {v5, v0, v8, v12, v13}, Lcom/sun/mail/smtp/SMTPAddressFailedException;-><init>(Ljavax/mail/internet/InternetAddress;Ljava/lang/String;ILjava/lang/String;)V

    .line 1194
    if-nez v6, :cond_17

    move v0, v4

    move-object v4, v5

    .line 1110
    :goto_d
    add-int/lit8 v5, v7, 0x1

    move v7, v5

    move-object v6, v4

    move v4, v0

    goto/16 :goto_3

    .line 1123
    :sswitch_0
    invoke-virtual {v9, v0}, Ljava/util/Vector;->addElement(Ljava/lang/Object;)V

    .line 1124
    iget-boolean v5, p0, Lcom/sun/mail/smtp/SMTPTransport;->reportSuccess:Z

    if-nez v5, :cond_d

    move v0, v4

    move-object v4, v6

    .line 1125
    goto :goto_d

    .line 1131
    :cond_d
    new-instance v5, Lcom/sun/mail/smtp/SMTPAddressSucceededException;

    .line 1132
    iget-object v13, p0, Lcom/sun/mail/smtp/SMTPTransport;->lastServerResponse:Ljava/lang/String;

    .line 1131
    invoke-direct {v5, v0, v8, v12, v13}, Lcom/sun/mail/smtp/SMTPAddressSucceededException;-><init>(Ljavax/mail/internet/InternetAddress;Ljava/lang/String;ILjava/lang/String;)V

    .line 1133
    if-nez v6, :cond_e

    move v0, v4

    move-object v4, v5

    .line 1134
    goto :goto_d

    .line 1136
    :cond_e
    invoke-virtual {v6, v5}, Ljavax/mail/MessagingException;->setNextException(Ljava/lang/Exception;)Z

    move v0, v4

    move-object v4, v6

    .line 1137
    goto :goto_d

    .line 1141
    :sswitch_1
    if-nez v1, :cond_f

    .line 1142
    const/4 v4, 0x1

    .line 1143
    :cond_f
    invoke-virtual {v11, v0}, Ljava/util/Vector;->addElement(Ljava/lang/Object;)V

    .line 1145
    new-instance v5, Lcom/sun/mail/smtp/SMTPAddressFailedException;

    .line 1146
    iget-object v13, p0, Lcom/sun/mail/smtp/SMTPTransport;->lastServerResponse:Ljava/lang/String;

    .line 1145
    invoke-direct {v5, v0, v8, v12, v13}, Lcom/sun/mail/smtp/SMTPAddressFailedException;-><init>(Ljavax/mail/internet/InternetAddress;Ljava/lang/String;ILjava/lang/String;)V

    .line 1147
    if-nez v6, :cond_10

    move v0, v4

    move-object v4, v5

    .line 1148
    goto :goto_d

    .line 1150
    :cond_10
    invoke-virtual {v6, v5}, Ljavax/mail/MessagingException;->setNextException(Ljava/lang/Exception;)Z

    move v0, v4

    move-object v4, v6

    .line 1151
    goto :goto_d

    .line 1155
    :sswitch_2
    if-nez v1, :cond_11

    .line 1156
    const/4 v4, 0x1

    .line 1157
    :cond_11
    invoke-virtual {v10, v0}, Ljava/util/Vector;->addElement(Ljava/lang/Object;)V

    .line 1159
    new-instance v5, Lcom/sun/mail/smtp/SMTPAddressFailedException;

    .line 1160
    iget-object v13, p0, Lcom/sun/mail/smtp/SMTPTransport;->lastServerResponse:Ljava/lang/String;

    .line 1159
    invoke-direct {v5, v0, v8, v12, v13}, Lcom/sun/mail/smtp/SMTPAddressFailedException;-><init>(Ljavax/mail/internet/InternetAddress;Ljava/lang/String;ILjava/lang/String;)V

    .line 1161
    if-nez v6, :cond_12

    move v0, v4

    move-object v4, v5

    .line 1162
    goto :goto_d

    .line 1164
    :cond_12
    invoke-virtual {v6, v5}, Ljavax/mail/MessagingException;->setNextException(Ljava/lang/Exception;)Z

    move v0, v4

    move-object v4, v6

    .line 1165
    goto :goto_d

    .line 1172
    :cond_13
    const/16 v5, 0x1f4

    if-lt v12, v5, :cond_14

    const/16 v5, 0x257

    if-gt v12, v5, :cond_14

    .line 1174
    invoke-virtual {v11, v0}, Ljava/util/Vector;->addElement(Ljava/lang/Object;)V

    goto :goto_c

    .line 1177
    :cond_14
    iget-boolean v1, p0, Lcom/sun/mail/smtp/SMTPTransport;->debug:Z

    if-eqz v1, :cond_15

    .line 1178
    iget-object v1, p0, Lcom/sun/mail/smtp/SMTPTransport;->out:Ljava/io/PrintStream;

    new-instance v2, Ljava/lang/StringBuilder;

    const-string v3, "DEBUG SMTP: got response code "

    invoke-direct {v2, v3}, Ljava/lang/StringBuilder;-><init>(Ljava/lang/String;)V

    invoke-virtual {v2, v12}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v2

    .line 1179
    const-string v3, ", with response: "

    invoke-virtual {v2, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    iget-object v3, p0, Lcom/sun/mail/smtp/SMTPTransport;->lastServerResponse:Ljava/lang/String;

    invoke-virtual {v2, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    invoke-virtual {v2}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v2

    .line 1178
    invoke-virtual {v1, v2}, Ljava/io/PrintStream;->println(Ljava/lang/String;)V

    .line 1180
    :cond_15
    iget-object v1, p0, Lcom/sun/mail/smtp/SMTPTransport;->lastServerResponse:Ljava/lang/String;

    .line 1181
    iget v2, p0, Lcom/sun/mail/smtp/SMTPTransport;->lastReturnCode:I

    .line 1182
    iget-object v3, p0, Lcom/sun/mail/smtp/SMTPTransport;->serverSocket:Ljava/net/Socket;

    if-eqz v3, :cond_16

    .line 1183
    const-string v3, "RSET"

    const/16 v4, 0xfa

    invoke-virtual {p0, v3, v4}, Lcom/sun/mail/smtp/SMTPTransport;->issueCommand(Ljava/lang/String;I)V

    .line 1184
    :cond_16
    iput-object v1, p0, Lcom/sun/mail/smtp/SMTPTransport;->lastServerResponse:Ljava/lang/String;

    .line 1185
    iput v2, p0, Lcom/sun/mail/smtp/SMTPTransport;->lastReturnCode:I

    .line 1186
    new-instance v2, Lcom/sun/mail/smtp/SMTPAddressFailedException;

    invoke-direct {v2, v0, v8, v12, v1}, Lcom/sun/mail/smtp/SMTPAddressFailedException;-><init>(Ljavax/mail/internet/InternetAddress;Ljava/lang/String;ILjava/lang/String;)V

    throw v2

    .line 1197
    :cond_17
    invoke-virtual {v6, v5}, Ljavax/mail/MessagingException;->setNextException(Ljava/lang/Exception;)Z

    move v0, v4

    move-object v4, v6

    goto/16 :goto_d

    .line 1217
    :cond_18
    iget-object v5, p0, Lcom/sun/mail/smtp/SMTPTransport;->validUnsentAddr:[Ljavax/mail/Address;

    add-int/lit8 v3, v2, 0x1

    invoke-virtual {v9, v1}, Ljava/util/Vector;->elementAt(I)Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Ljavax/mail/Address;

    aput-object v0, v5, v2

    .line 1216
    add-int/lit8 v0, v1, 0x1

    move v1, v0

    move v2, v3

    goto/16 :goto_4

    .line 1219
    :cond_19
    iget-object v5, p0, Lcom/sun/mail/smtp/SMTPTransport;->validUnsentAddr:[Ljavax/mail/Address;

    add-int/lit8 v3, v2, 0x1

    invoke-virtual {v10, v1}, Ljava/util/Vector;->elementAt(I)Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Ljavax/mail/Address;

    aput-object v0, v5, v2

    .line 1218
    add-int/lit8 v0, v1, 0x1

    move v1, v0

    move v2, v3

    goto/16 :goto_5

    .line 1220
    :cond_1a
    iget-boolean v0, p0, Lcom/sun/mail/smtp/SMTPTransport;->reportSuccess:Z

    if-nez v0, :cond_1b

    if-eqz v1, :cond_1c

    .line 1221
    invoke-virtual {v11}, Ljava/util/Vector;->size()I

    move-result v0

    if-gtz v0, :cond_1b

    invoke-virtual {v10}, Ljava/util/Vector;->size()I

    move-result v0

    if-lez v0, :cond_1c

    .line 1224
    :cond_1b
    const/4 v0, 0x1

    iput-boolean v0, p0, Lcom/sun/mail/smtp/SMTPTransport;->sendPartiallyFailed:Z

    .line 1225
    iput-object v6, p0, Lcom/sun/mail/smtp/SMTPTransport;->exception:Ljavax/mail/MessagingException;

    .line 1228
    invoke-virtual {v11}, Ljava/util/Vector;->size()I

    move-result v0

    new-array v0, v0, [Ljavax/mail/Address;

    iput-object v0, p0, Lcom/sun/mail/smtp/SMTPTransport;->invalidAddr:[Ljavax/mail/Address;

    .line 1229
    iget-object v0, p0, Lcom/sun/mail/smtp/SMTPTransport;->invalidAddr:[Ljavax/mail/Address;

    invoke-virtual {v11, v0}, Ljava/util/Vector;->copyInto([Ljava/lang/Object;)V

    .line 1232
    invoke-virtual {v10}, Ljava/util/Vector;->size()I

    move-result v0

    new-array v0, v0, [Ljavax/mail/Address;

    iput-object v0, p0, Lcom/sun/mail/smtp/SMTPTransport;->validUnsentAddr:[Ljavax/mail/Address;

    .line 1233
    iget-object v0, p0, Lcom/sun/mail/smtp/SMTPTransport;->validUnsentAddr:[Ljavax/mail/Address;

    invoke-virtual {v10, v0}, Ljava/util/Vector;->copyInto([Ljava/lang/Object;)V

    .line 1236
    invoke-virtual {v9}, Ljava/util/Vector;->size()I

    move-result v0

    new-array v0, v0, [Ljavax/mail/Address;

    iput-object v0, p0, Lcom/sun/mail/smtp/SMTPTransport;->validSentAddr:[Ljavax/mail/Address;

    .line 1237
    iget-object v0, p0, Lcom/sun/mail/smtp/SMTPTransport;->validSentAddr:[Ljavax/mail/Address;

    invoke-virtual {v9, v0}, Ljava/util/Vector;->copyInto([Ljava/lang/Object;)V

    goto/16 :goto_6

    .line 1239
    :cond_1c
    iget-object v0, p0, Lcom/sun/mail/smtp/SMTPTransport;->addresses:[Ljavax/mail/Address;

    iput-object v0, p0, Lcom/sun/mail/smtp/SMTPTransport;->validSentAddr:[Ljavax/mail/Address;

    goto/16 :goto_6

    .line 1248
    :cond_1d
    iget-object v1, p0, Lcom/sun/mail/smtp/SMTPTransport;->out:Ljava/io/PrintStream;

    new-instance v2, Ljava/lang/StringBuilder;

    const-string v3, "DEBUG SMTP:   "

    invoke-direct {v2, v3}, Ljava/lang/StringBuilder;-><init>(Ljava/lang/String;)V

    iget-object v3, p0, Lcom/sun/mail/smtp/SMTPTransport;->validSentAddr:[Ljavax/mail/Address;

    aget-object v3, v3, v0

    invoke-virtual {v2, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/Object;)Ljava/lang/StringBuilder;

    move-result-object v2

    invoke-virtual {v2}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v2

    invoke-virtual {v1, v2}, Ljava/io/PrintStream;->println(Ljava/lang/String;)V

    .line 1247
    add-int/lit8 v0, v0, 0x1

    goto/16 :goto_7

    .line 1254
    :cond_1e
    iget-object v1, p0, Lcom/sun/mail/smtp/SMTPTransport;->out:Ljava/io/PrintStream;

    new-instance v2, Ljava/lang/StringBuilder;

    const-string v3, "DEBUG SMTP:   "

    invoke-direct {v2, v3}, Ljava/lang/StringBuilder;-><init>(Ljava/lang/String;)V

    iget-object v3, p0, Lcom/sun/mail/smtp/SMTPTransport;->validUnsentAddr:[Ljavax/mail/Address;

    aget-object v3, v3, v0

    invoke-virtual {v2, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/Object;)Ljava/lang/StringBuilder;

    move-result-object v2

    invoke-virtual {v2}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v2

    invoke-virtual {v1, v2}, Ljava/io/PrintStream;->println(Ljava/lang/String;)V

    .line 1253
    add-int/lit8 v0, v0, 0x1

    goto/16 :goto_8

    .line 1260
    :cond_1f
    iget-object v1, p0, Lcom/sun/mail/smtp/SMTPTransport;->out:Ljava/io/PrintStream;

    new-instance v2, Ljava/lang/StringBuilder;

    const-string v3, "DEBUG SMTP:   "

    invoke-direct {v2, v3}, Ljava/lang/StringBuilder;-><init>(Ljava/lang/String;)V

    iget-object v3, p0, Lcom/sun/mail/smtp/SMTPTransport;->invalidAddr:[Ljavax/mail/Address;

    aget-object v3, v3, v0

    invoke-virtual {v2, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/Object;)Ljava/lang/StringBuilder;

    move-result-object v2

    invoke-virtual {v2}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v2

    invoke-virtual {v1, v2}, Ljava/io/PrintStream;->println(Ljava/lang/String;)V

    .line 1259
    add-int/lit8 v0, v0, 0x1

    goto/16 :goto_9

    .line 1280
    :catch_0
    move-exception v0

    .line 1283
    :try_start_1
    invoke-virtual {p0}, Lcom/sun/mail/smtp/SMTPTransport;->close()V
    :try_end_1
    .catch Ljavax/mail/MessagingException; {:try_start_1 .. :try_end_1} :catch_1
    .catchall {:try_start_1 .. :try_end_1} :catchall_0

    .line 1290
    :cond_20
    :goto_e
    iput-object v1, p0, Lcom/sun/mail/smtp/SMTPTransport;->lastServerResponse:Ljava/lang/String;

    .line 1291
    iput v2, p0, Lcom/sun/mail/smtp/SMTPTransport;->lastReturnCode:I

    goto/16 :goto_a

    .line 1284
    :catch_1
    move-exception v0

    .line 1286
    :try_start_2
    iget-boolean v3, p0, Lcom/sun/mail/smtp/SMTPTransport;->debug:Z

    if-eqz v3, :cond_20

    .line 1287
    iget-object v3, p0, Lcom/sun/mail/smtp/SMTPTransport;->out:Ljava/io/PrintStream;

    invoke-virtual {v0, v3}, Ljavax/mail/MessagingException;->printStackTrace(Ljava/io/PrintStream;)V
    :try_end_2
    .catchall {:try_start_2 .. :try_end_2} :catchall_0

    goto :goto_e

    .line 1289
    :catchall_0
    move-exception v0

    .line 1290
    iput-object v1, p0, Lcom/sun/mail/smtp/SMTPTransport;->lastServerResponse:Ljava/lang/String;

    .line 1291
    iput v2, p0, Lcom/sun/mail/smtp/SMTPTransport;->lastReturnCode:I

    .line 1292
    throw v0

    .line 1298
    :cond_21
    return-void

    :cond_22
    move-object v8, v5

    goto/16 :goto_b

    :cond_23
    move v3, v2

    move-object v2, v0

    goto/16 :goto_2

    :cond_24
    move v3, v2

    move-object v2, v0

    goto/16 :goto_2

    :cond_25
    move v1, v0

    goto/16 :goto_1

    .line 1121
    nop

    :sswitch_data_0
    .sparse-switch
        0xfa -> :sswitch_0
        0xfb -> :sswitch_0
        0x1c2 -> :sswitch_2
        0x1c3 -> :sswitch_2
        0x1c4 -> :sswitch_2
        0x1f5 -> :sswitch_1
        0x1f7 -> :sswitch_1
        0x226 -> :sswitch_1
        0x227 -> :sswitch_1
        0x228 -> :sswitch_2
        0x229 -> :sswitch_1
    .end sparse-switch
.end method

.method protected readServerResponse()I
    .locals 6
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljavax/mail/MessagingException;
        }
    .end annotation

    .prologue
    const/4 v4, 0x3

    const/4 v5, 0x0

    const/4 v0, -0x1

    .line 1578
    sget-boolean v1, Lcom/sun/mail/smtp/SMTPTransport;->$assertionsDisabled:Z

    if-nez v1, :cond_0

    invoke-static {p0}, Ljava/lang/Thread;->holdsLock(Ljava/lang/Object;)Z

    move-result v1

    if-nez v1, :cond_0

    new-instance v0, Ljava/lang/AssertionError;

    invoke-direct {v0}, Ljava/lang/AssertionError;-><init>()V

    throw v0

    .line 1579
    :cond_0
    const-string v1, ""

    .line 1581
    new-instance v1, Ljava/lang/StringBuffer;

    const/16 v2, 0x64

    invoke-direct {v1, v2}, Ljava/lang/StringBuffer;-><init>(I)V

    .line 1589
    :cond_1
    :try_start_0
    iget-object v2, p0, Lcom/sun/mail/smtp/SMTPTransport;->lineInputStream:Lcom/sun/mail/util/LineInputStream;

    invoke-virtual {v2}, Lcom/sun/mail/util/LineInputStream;->readLine()Ljava/lang/String;

    move-result-object v2

    .line 1590
    if-nez v2, :cond_4

    .line 1591
    invoke-virtual {v1}, Ljava/lang/StringBuffer;->toString()Ljava/lang/String;

    move-result-object v1

    .line 1592
    invoke-virtual {v1}, Ljava/lang/String;->length()I

    move-result v2

    if-nez v2, :cond_2

    .line 1593
    const-string v1, "[EOF]"

    .line 1594
    :cond_2
    iput-object v1, p0, Lcom/sun/mail/smtp/SMTPTransport;->lastServerResponse:Ljava/lang/String;

    .line 1595
    const/4 v2, -0x1

    iput v2, p0, Lcom/sun/mail/smtp/SMTPTransport;->lastReturnCode:I

    .line 1596
    iget-boolean v2, p0, Lcom/sun/mail/smtp/SMTPTransport;->debug:Z

    if-eqz v2, :cond_3

    .line 1597
    iget-object v2, p0, Lcom/sun/mail/smtp/SMTPTransport;->out:Ljava/io/PrintStream;

    new-instance v3, Ljava/lang/StringBuilder;

    const-string v4, "DEBUG SMTP: EOF: "

    invoke-direct {v3, v4}, Ljava/lang/StringBuilder;-><init>(Ljava/lang/String;)V

    invoke-virtual {v3, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v1

    invoke-virtual {v2, v1}, Ljava/io/PrintStream;->println(Ljava/lang/String;)V

    .line 1651
    :cond_3
    :goto_0
    return v0

    .line 1600
    :cond_4
    invoke-virtual {v1, v2}, Ljava/lang/StringBuffer;->append(Ljava/lang/String;)Ljava/lang/StringBuffer;

    .line 1601
    const-string v3, "\n"

    invoke-virtual {v1, v3}, Ljava/lang/StringBuffer;->append(Ljava/lang/String;)Ljava/lang/StringBuffer;

    .line 1602
    invoke-direct {p0, v2}, Lcom/sun/mail/smtp/SMTPTransport;->isNotLastLine(Ljava/lang/String;)Z

    move-result v2

    .line 1588
    if-nez v2, :cond_1

    .line 1604
    invoke-virtual {v1}, Ljava/lang/StringBuffer;->toString()Ljava/lang/String;
    :try_end_0
    .catch Ljava/io/IOException; {:try_start_0 .. :try_end_0} :catch_0

    move-result-object v2

    .line 1620
    if-eqz v2, :cond_9

    invoke-virtual {v2}, Ljava/lang/String;->length()I

    move-result v1

    if-lt v1, v4, :cond_9

    .line 1622
    const/4 v1, 0x0

    const/4 v3, 0x3

    :try_start_1
    invoke-virtual {v2, v1, v3}, Ljava/lang/String;->substring(II)Ljava/lang/String;

    move-result-object v1

    invoke-static {v1}, Ljava/lang/Integer;->parseInt(Ljava/lang/String;)I
    :try_end_1
    .catch Ljava/lang/NumberFormatException; {:try_start_1 .. :try_end_1} :catch_1
    .catch Ljava/lang/StringIndexOutOfBoundsException; {:try_start_1 .. :try_end_1} :catch_3

    move-result v1

    .line 1646
    :goto_1
    if-ne v1, v0, :cond_5

    iget-boolean v0, p0, Lcom/sun/mail/smtp/SMTPTransport;->debug:Z

    if-eqz v0, :cond_5

    .line 1647
    iget-object v0, p0, Lcom/sun/mail/smtp/SMTPTransport;->out:Ljava/io/PrintStream;

    new-instance v3, Ljava/lang/StringBuilder;

    const-string v4, "DEBUG SMTP: bad server response: "

    invoke-direct {v3, v4}, Ljava/lang/StringBuilder;-><init>(Ljava/lang/String;)V

    invoke-virtual {v3, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v3

    invoke-virtual {v3}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v3

    invoke-virtual {v0, v3}, Ljava/io/PrintStream;->println(Ljava/lang/String;)V

    .line 1649
    :cond_5
    iput-object v2, p0, Lcom/sun/mail/smtp/SMTPTransport;->lastServerResponse:Ljava/lang/String;

    .line 1650
    iput v1, p0, Lcom/sun/mail/smtp/SMTPTransport;->lastReturnCode:I

    move v0, v1

    .line 1651
    goto :goto_0

    .line 1605
    :catch_0
    move-exception v0

    .line 1606
    iget-boolean v1, p0, Lcom/sun/mail/smtp/SMTPTransport;->debug:Z

    if-eqz v1, :cond_6

    .line 1607
    iget-object v1, p0, Lcom/sun/mail/smtp/SMTPTransport;->out:Ljava/io/PrintStream;

    new-instance v2, Ljava/lang/StringBuilder;

    const-string v3, "DEBUG SMTP: exception reading response: "

    invoke-direct {v2, v3}, Ljava/lang/StringBuilder;-><init>(Ljava/lang/String;)V

    invoke-virtual {v2, v0}, Ljava/lang/StringBuilder;->append(Ljava/lang/Object;)Ljava/lang/StringBuilder;

    move-result-object v2

    invoke-virtual {v2}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v2

    invoke-virtual {v1, v2}, Ljava/io/PrintStream;->println(Ljava/lang/String;)V

    .line 1609
    :cond_6
    const-string v1, ""

    iput-object v1, p0, Lcom/sun/mail/smtp/SMTPTransport;->lastServerResponse:Ljava/lang/String;

    .line 1610
    iput v5, p0, Lcom/sun/mail/smtp/SMTPTransport;->lastReturnCode:I

    .line 1611
    new-instance v1, Ljavax/mail/MessagingException;

    const-string v2, "Exception reading response"

    invoke-direct {v1, v2, v0}, Ljavax/mail/MessagingException;-><init>(Ljava/lang/String;Ljava/lang/Exception;)V

    throw v1

    .line 1623
    :catch_1
    move-exception v1

    .line 1625
    :try_start_2
    invoke-virtual {p0}, Lcom/sun/mail/smtp/SMTPTransport;->close()V
    :try_end_2
    .catch Ljavax/mail/MessagingException; {:try_start_2 .. :try_end_2} :catch_2

    :cond_7
    :goto_2
    move v1, v0

    .line 1631
    goto :goto_1

    .line 1626
    :catch_2
    move-exception v1

    .line 1628
    iget-boolean v3, p0, Lcom/sun/mail/smtp/SMTPTransport;->debug:Z

    if-eqz v3, :cond_7

    .line 1629
    iget-object v3, p0, Lcom/sun/mail/smtp/SMTPTransport;->out:Ljava/io/PrintStream;

    invoke-virtual {v1, v3}, Ljavax/mail/MessagingException;->printStackTrace(Ljava/io/PrintStream;)V

    goto :goto_2

    .line 1632
    :catch_3
    move-exception v1

    .line 1635
    :try_start_3
    invoke-virtual {p0}, Lcom/sun/mail/smtp/SMTPTransport;->close()V
    :try_end_3
    .catch Ljavax/mail/MessagingException; {:try_start_3 .. :try_end_3} :catch_4

    :cond_8
    :goto_3
    move v1, v0

    .line 1641
    goto :goto_1

    .line 1636
    :catch_4
    move-exception v1

    .line 1638
    iget-boolean v3, p0, Lcom/sun/mail/smtp/SMTPTransport;->debug:Z

    if-eqz v3, :cond_8

    .line 1639
    iget-object v3, p0, Lcom/sun/mail/smtp/SMTPTransport;->out:Ljava/io/PrintStream;

    invoke-virtual {v1, v3}, Ljavax/mail/MessagingException;->printStackTrace(Ljava/io/PrintStream;)V

    goto :goto_3

    :cond_9
    move v1, v0

    .line 1644
    goto :goto_1
.end method

.method protected sendCommand(Ljava/lang/String;)V
    .locals 1
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljavax/mail/MessagingException;
        }
    .end annotation

    .prologue
    .line 1551
    invoke-static {p1}, Lcom/sun/mail/util/ASCIIUtility;->getBytes(Ljava/lang/String;)[B

    move-result-object v0

    invoke-direct {p0, v0}, Lcom/sun/mail/smtp/SMTPTransport;->sendCommand([B)V

    .line 1552
    return-void
.end method

.method public declared-synchronized sendMessage(Ljavax/mail/Message;[Ljavax/mail/Address;)V
    .locals 9
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljavax/mail/MessagingException;,
            Ljavax/mail/SendFailedException;
        }
    .end annotation

    .prologue
    const/4 v2, 0x1

    const/4 v3, 0x0

    .line 590
    monitor-enter p0

    :try_start_0
    invoke-virtual {p0}, Lcom/sun/mail/smtp/SMTPTransport;->checkConnected()V

    .line 594
    instance-of v1, p1, Ljavax/mail/internet/MimeMessage;

    if-nez v1, :cond_1

    .line 595
    iget-boolean v1, p0, Lcom/sun/mail/smtp/SMTPTransport;->debug:Z

    if-eqz v1, :cond_0

    .line 596
    iget-object v1, p0, Lcom/sun/mail/smtp/SMTPTransport;->out:Ljava/io/PrintStream;

    const-string v2, "DEBUG SMTP: Can only send RFC822 msgs"

    invoke-virtual {v1, v2}, Ljava/io/PrintStream;->println(Ljava/lang/String;)V

    .line 597
    :cond_0
    new-instance v1, Ljavax/mail/MessagingException;

    const-string v2, "SMTP can only send RFC822 messages"

    invoke-direct {v1, v2}, Ljavax/mail/MessagingException;-><init>(Ljava/lang/String;)V

    throw v1
    :try_end_0
    .catchall {:try_start_0 .. :try_end_0} :catchall_0

    .line 590
    :catchall_0
    move-exception v1

    monitor-exit p0

    throw v1

    :cond_1
    move v1, v3

    .line 599
    :goto_0
    :try_start_1
    array-length v4, p2

    if-lt v1, v4, :cond_7

    .line 606
    move-object v0, p1

    check-cast v0, Ljavax/mail/internet/MimeMessage;

    move-object v1, v0

    iput-object v1, p0, Lcom/sun/mail/smtp/SMTPTransport;->message:Ljavax/mail/internet/MimeMessage;

    .line 607
    iput-object p2, p0, Lcom/sun/mail/smtp/SMTPTransport;->addresses:[Ljavax/mail/Address;

    .line 608
    iput-object p2, p0, Lcom/sun/mail/smtp/SMTPTransport;->validUnsentAddr:[Ljavax/mail/Address;

    .line 609
    invoke-direct {p0}, Lcom/sun/mail/smtp/SMTPTransport;->expandGroups()V

    .line 612
    instance-of v1, p1, Lcom/sun/mail/smtp/SMTPMessage;

    if-eqz v1, :cond_c

    .line 613
    check-cast p1, Lcom/sun/mail/smtp/SMTPMessage;

    invoke-virtual {p1}, Lcom/sun/mail/smtp/SMTPMessage;->getAllow8bitMIME()Z

    move-result v1

    .line 614
    :goto_1
    if-nez v1, :cond_2

    .line 616
    iget-object v1, p0, Lcom/sun/mail/smtp/SMTPTransport;->session:Ljavax/mail/Session;

    new-instance v4, Ljava/lang/StringBuilder;

    const-string v5, "mail."

    invoke-direct {v4, v5}, Ljava/lang/StringBuilder;-><init>(Ljava/lang/String;)V

    iget-object v5, p0, Lcom/sun/mail/smtp/SMTPTransport;->name:Ljava/lang/String;

    invoke-virtual {v4, v5}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v4

    const-string v5, ".allow8bitmime"

    invoke-virtual {v4, v5}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v4

    invoke-virtual {v4}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v4

    invoke-virtual {v1, v4}, Ljavax/mail/Session;->getProperty(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v1

    .line 617
    if-eqz v1, :cond_9

    const-string v4, "true"

    invoke-virtual {v1, v4}, Ljava/lang/String;->equalsIgnoreCase(Ljava/lang/String;)Z

    move-result v1

    if-eqz v1, :cond_9

    move v1, v2

    .line 619
    :cond_2
    :goto_2
    iget-boolean v2, p0, Lcom/sun/mail/smtp/SMTPTransport;->debug:Z

    if-eqz v2, :cond_3

    .line 620
    iget-object v2, p0, Lcom/sun/mail/smtp/SMTPTransport;->out:Ljava/io/PrintStream;

    new-instance v3, Ljava/lang/StringBuilder;

    const-string v4, "DEBUG SMTP: use8bit "

    invoke-direct {v3, v4}, Ljava/lang/StringBuilder;-><init>(Ljava/lang/String;)V

    invoke-virtual {v3, v1}, Ljava/lang/StringBuilder;->append(Z)Ljava/lang/StringBuilder;

    move-result-object v3

    invoke-virtual {v3}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v3

    invoke-virtual {v2, v3}, Ljava/io/PrintStream;->println(Ljava/lang/String;)V

    .line 621
    :cond_3
    if-eqz v1, :cond_4

    const-string v1, "8BITMIME"

    invoke-virtual {p0, v1}, Lcom/sun/mail/smtp/SMTPTransport;->supportsExtension(Ljava/lang/String;)Z

    move-result v1

    if-eqz v1, :cond_4

    .line 622
    iget-object v1, p0, Lcom/sun/mail/smtp/SMTPTransport;->message:Ljavax/mail/internet/MimeMessage;

    invoke-direct {p0, v1}, Lcom/sun/mail/smtp/SMTPTransport;->convertTo8Bit(Ljavax/mail/internet/MimePart;)Z
    :try_end_1
    .catchall {:try_start_1 .. :try_end_1} :catchall_0

    move-result v1

    if-eqz v1, :cond_4

    .line 626
    :try_start_2
    iget-object v1, p0, Lcom/sun/mail/smtp/SMTPTransport;->message:Ljavax/mail/internet/MimeMessage;

    invoke-virtual {v1}, Ljavax/mail/internet/MimeMessage;->saveChanges()V
    :try_end_2
    .catch Ljavax/mail/MessagingException; {:try_start_2 .. :try_end_2} :catch_3
    .catchall {:try_start_2 .. :try_end_2} :catchall_0

    .line 634
    :cond_4
    :goto_3
    :try_start_3
    invoke-virtual {p0}, Lcom/sun/mail/smtp/SMTPTransport;->mailFrom()V

    .line 635
    invoke-virtual {p0}, Lcom/sun/mail/smtp/SMTPTransport;->rcptTo()V

    .line 636
    iget-object v1, p0, Lcom/sun/mail/smtp/SMTPTransport;->message:Ljavax/mail/internet/MimeMessage;

    invoke-virtual {p0}, Lcom/sun/mail/smtp/SMTPTransport;->data()Ljava/io/OutputStream;

    move-result-object v2

    sget-object v3, Lcom/sun/mail/smtp/SMTPTransport;->ignoreList:[Ljava/lang/String;

    invoke-virtual {v1, v2, v3}, Ljavax/mail/internet/MimeMessage;->writeTo(Ljava/io/OutputStream;[Ljava/lang/String;)V

    .line 637
    invoke-virtual {p0}, Lcom/sun/mail/smtp/SMTPTransport;->finishData()V

    .line 638
    iget-boolean v1, p0, Lcom/sun/mail/smtp/SMTPTransport;->sendPartiallyFailed:Z

    if-eqz v1, :cond_a

    .line 641
    iget-boolean v1, p0, Lcom/sun/mail/smtp/SMTPTransport;->debug:Z

    if-eqz v1, :cond_5

    .line 642
    iget-object v1, p0, Lcom/sun/mail/smtp/SMTPTransport;->out:Ljava/io/PrintStream;

    const-string v2, "DEBUG SMTP: Sending partially failed because of invalid destination addresses"

    invoke-virtual {v1, v2}, Ljava/io/PrintStream;->println(Ljava/lang/String;)V

    .line 645
    :cond_5
    const/4 v2, 0x3

    .line 646
    iget-object v3, p0, Lcom/sun/mail/smtp/SMTPTransport;->validSentAddr:[Ljavax/mail/Address;

    iget-object v4, p0, Lcom/sun/mail/smtp/SMTPTransport;->validUnsentAddr:[Ljavax/mail/Address;

    iget-object v5, p0, Lcom/sun/mail/smtp/SMTPTransport;->invalidAddr:[Ljavax/mail/Address;

    .line 647
    iget-object v6, p0, Lcom/sun/mail/smtp/SMTPTransport;->message:Ljavax/mail/internet/MimeMessage;

    move-object v1, p0

    .line 644
    invoke-virtual/range {v1 .. v6}, Lcom/sun/mail/smtp/SMTPTransport;->notifyTransportListeners(I[Ljavax/mail/Address;[Ljavax/mail/Address;[Ljavax/mail/Address;Ljavax/mail/Message;)V

    .line 649
    new-instance v1, Lcom/sun/mail/smtp/SMTPSendFailedException;

    const-string v2, "."

    iget v3, p0, Lcom/sun/mail/smtp/SMTPTransport;->lastReturnCode:I

    .line 650
    iget-object v4, p0, Lcom/sun/mail/smtp/SMTPTransport;->lastServerResponse:Ljava/lang/String;

    iget-object v5, p0, Lcom/sun/mail/smtp/SMTPTransport;->exception:Ljavax/mail/MessagingException;

    .line 651
    iget-object v6, p0, Lcom/sun/mail/smtp/SMTPTransport;->validSentAddr:[Ljavax/mail/Address;

    iget-object v7, p0, Lcom/sun/mail/smtp/SMTPTransport;->validUnsentAddr:[Ljavax/mail/Address;

    iget-object v8, p0, Lcom/sun/mail/smtp/SMTPTransport;->invalidAddr:[Ljavax/mail/Address;

    .line 649
    invoke-direct/range {v1 .. v8}, Lcom/sun/mail/smtp/SMTPSendFailedException;-><init>(Ljava/lang/String;ILjava/lang/String;Ljava/lang/Exception;[Ljavax/mail/Address;[Ljavax/mail/Address;[Ljavax/mail/Address;)V

    throw v1
    :try_end_3
    .catch Ljavax/mail/MessagingException; {:try_start_3 .. :try_end_3} :catch_0
    .catch Ljava/io/IOException; {:try_start_3 .. :try_end_3} :catch_1
    .catchall {:try_start_3 .. :try_end_3} :catchall_1

    .line 656
    :catch_0
    move-exception v1

    move-object v7, v1

    .line 657
    :try_start_4
    iget-boolean v1, p0, Lcom/sun/mail/smtp/SMTPTransport;->debug:Z

    if-eqz v1, :cond_6

    .line 658
    iget-object v1, p0, Lcom/sun/mail/smtp/SMTPTransport;->out:Ljava/io/PrintStream;

    invoke-virtual {v7, v1}, Ljavax/mail/MessagingException;->printStackTrace(Ljava/io/PrintStream;)V

    .line 659
    :cond_6
    const/4 v2, 0x2

    .line 660
    iget-object v3, p0, Lcom/sun/mail/smtp/SMTPTransport;->validSentAddr:[Ljavax/mail/Address;

    iget-object v4, p0, Lcom/sun/mail/smtp/SMTPTransport;->validUnsentAddr:[Ljavax/mail/Address;

    .line 661
    iget-object v5, p0, Lcom/sun/mail/smtp/SMTPTransport;->invalidAddr:[Ljavax/mail/Address;

    iget-object v6, p0, Lcom/sun/mail/smtp/SMTPTransport;->message:Ljavax/mail/internet/MimeMessage;

    move-object v1, p0

    .line 659
    invoke-virtual/range {v1 .. v6}, Lcom/sun/mail/smtp/SMTPTransport;->notifyTransportListeners(I[Ljavax/mail/Address;[Ljavax/mail/Address;[Ljavax/mail/Address;Ljavax/mail/Message;)V

    .line 663
    throw v7
    :try_end_4
    .catchall {:try_start_4 .. :try_end_4} :catchall_1

    .line 678
    :catchall_1
    move-exception v1

    .line 680
    const/4 v2, 0x0

    :try_start_5
    iput-object v2, p0, Lcom/sun/mail/smtp/SMTPTransport;->invalidAddr:[Ljavax/mail/Address;

    iput-object v2, p0, Lcom/sun/mail/smtp/SMTPTransport;->validUnsentAddr:[Ljavax/mail/Address;

    iput-object v2, p0, Lcom/sun/mail/smtp/SMTPTransport;->validSentAddr:[Ljavax/mail/Address;

    .line 681
    const/4 v2, 0x0

    iput-object v2, p0, Lcom/sun/mail/smtp/SMTPTransport;->addresses:[Ljavax/mail/Address;

    .line 682
    const/4 v2, 0x0

    iput-object v2, p0, Lcom/sun/mail/smtp/SMTPTransport;->message:Ljavax/mail/internet/MimeMessage;

    .line 683
    const/4 v2, 0x0

    iput-object v2, p0, Lcom/sun/mail/smtp/SMTPTransport;->exception:Ljavax/mail/MessagingException;

    .line 684
    const/4 v2, 0x0

    iput-boolean v2, p0, Lcom/sun/mail/smtp/SMTPTransport;->sendPartiallyFailed:Z

    .line 685
    throw v1

    .line 600
    :cond_7
    aget-object v4, p2, v1

    instance-of v4, v4, Ljavax/mail/internet/InternetAddress;

    if-nez v4, :cond_8

    .line 601
    new-instance v2, Ljavax/mail/MessagingException;

    new-instance v3, Ljava/lang/StringBuilder;

    invoke-direct {v3}, Ljava/lang/StringBuilder;-><init>()V

    aget-object v1, p2, v1

    invoke-virtual {v3, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/Object;)Ljava/lang/StringBuilder;

    move-result-object v1

    .line 602
    const-string v3, " is not an InternetAddress"

    invoke-virtual {v1, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v1

    .line 601
    invoke-direct {v2, v1}, Ljavax/mail/MessagingException;-><init>(Ljava/lang/String;)V

    throw v2
    :try_end_5
    .catchall {:try_start_5 .. :try_end_5} :catchall_0

    .line 599
    :cond_8
    add-int/lit8 v1, v1, 0x1

    goto/16 :goto_0

    :cond_9
    move v1, v3

    .line 617
    goto/16 :goto_2

    .line 653
    :cond_a
    const/4 v2, 0x1

    .line 654
    :try_start_6
    iget-object v3, p0, Lcom/sun/mail/smtp/SMTPTransport;->validSentAddr:[Ljavax/mail/Address;

    iget-object v4, p0, Lcom/sun/mail/smtp/SMTPTransport;->validUnsentAddr:[Ljavax/mail/Address;

    .line 655
    iget-object v5, p0, Lcom/sun/mail/smtp/SMTPTransport;->invalidAddr:[Ljavax/mail/Address;

    iget-object v6, p0, Lcom/sun/mail/smtp/SMTPTransport;->message:Ljavax/mail/internet/MimeMessage;

    move-object v1, p0

    .line 653
    invoke-virtual/range {v1 .. v6}, Lcom/sun/mail/smtp/SMTPTransport;->notifyTransportListeners(I[Ljavax/mail/Address;[Ljavax/mail/Address;[Ljavax/mail/Address;Ljavax/mail/Message;)V
    :try_end_6
    .catch Ljavax/mail/MessagingException; {:try_start_6 .. :try_end_6} :catch_0
    .catch Ljava/io/IOException; {:try_start_6 .. :try_end_6} :catch_1
    .catchall {:try_start_6 .. :try_end_6} :catchall_1

    .line 680
    const/4 v1, 0x0

    :try_start_7
    iput-object v1, p0, Lcom/sun/mail/smtp/SMTPTransport;->invalidAddr:[Ljavax/mail/Address;

    iput-object v1, p0, Lcom/sun/mail/smtp/SMTPTransport;->validUnsentAddr:[Ljavax/mail/Address;

    iput-object v1, p0, Lcom/sun/mail/smtp/SMTPTransport;->validSentAddr:[Ljavax/mail/Address;

    .line 681
    const/4 v1, 0x0

    iput-object v1, p0, Lcom/sun/mail/smtp/SMTPTransport;->addresses:[Ljavax/mail/Address;

    .line 682
    const/4 v1, 0x0

    iput-object v1, p0, Lcom/sun/mail/smtp/SMTPTransport;->message:Ljavax/mail/internet/MimeMessage;

    .line 683
    const/4 v1, 0x0

    iput-object v1, p0, Lcom/sun/mail/smtp/SMTPTransport;->exception:Ljavax/mail/MessagingException;

    .line 684
    const/4 v1, 0x0

    iput-boolean v1, p0, Lcom/sun/mail/smtp/SMTPTransport;->sendPartiallyFailed:Z
    :try_end_7
    .catchall {:try_start_7 .. :try_end_7} :catchall_0

    .line 686
    monitor-exit p0

    return-void

    .line 664
    :catch_1
    move-exception v1

    move-object v7, v1

    .line 665
    :try_start_8
    iget-boolean v1, p0, Lcom/sun/mail/smtp/SMTPTransport;->debug:Z

    if-eqz v1, :cond_b

    .line 666
    iget-object v1, p0, Lcom/sun/mail/smtp/SMTPTransport;->out:Ljava/io/PrintStream;

    invoke-virtual {v7, v1}, Ljava/io/IOException;->printStackTrace(Ljava/io/PrintStream;)V
    :try_end_8
    .catchall {:try_start_8 .. :try_end_8} :catchall_1

    .line 670
    :cond_b
    :try_start_9
    invoke-direct {p0}, Lcom/sun/mail/smtp/SMTPTransport;->closeConnection()V
    :try_end_9
    .catch Ljavax/mail/MessagingException; {:try_start_9 .. :try_end_9} :catch_2
    .catchall {:try_start_9 .. :try_end_9} :catchall_1

    .line 672
    :goto_4
    const/4 v2, 0x2

    .line 673
    :try_start_a
    iget-object v3, p0, Lcom/sun/mail/smtp/SMTPTransport;->validSentAddr:[Ljavax/mail/Address;

    iget-object v4, p0, Lcom/sun/mail/smtp/SMTPTransport;->validUnsentAddr:[Ljavax/mail/Address;

    .line 674
    iget-object v5, p0, Lcom/sun/mail/smtp/SMTPTransport;->invalidAddr:[Ljavax/mail/Address;

    iget-object v6, p0, Lcom/sun/mail/smtp/SMTPTransport;->message:Ljavax/mail/internet/MimeMessage;

    move-object v1, p0

    .line 672
    invoke-virtual/range {v1 .. v6}, Lcom/sun/mail/smtp/SMTPTransport;->notifyTransportListeners(I[Ljavax/mail/Address;[Ljavax/mail/Address;[Ljavax/mail/Address;Ljavax/mail/Message;)V

    .line 676
    new-instance v1, Ljavax/mail/MessagingException;

    const-string v2, "IOException while sending message"

    invoke-direct {v1, v2, v7}, Ljavax/mail/MessagingException;-><init>(Ljava/lang/String;Ljava/lang/Exception;)V

    throw v1
    :try_end_a
    .catchall {:try_start_a .. :try_end_a} :catchall_1

    .line 671
    :catch_2
    move-exception v1

    goto :goto_4

    .line 627
    :catch_3
    move-exception v1

    goto/16 :goto_3

    :cond_c
    move v1, v3

    goto/16 :goto_1
.end method

.method public declared-synchronized setLocalHost(Ljava/lang/String;)V
    .locals 1

    .prologue
    .line 197
    monitor-enter p0

    :try_start_0
    iput-object p1, p0, Lcom/sun/mail/smtp/SMTPTransport;->localHostName:Ljava/lang/String;
    :try_end_0
    .catchall {:try_start_0 .. :try_end_0} :catchall_0

    .line 198
    monitor-exit p0

    return-void

    .line 197
    :catchall_0
    move-exception v0

    monitor-exit p0

    throw v0
.end method

.method public declared-synchronized setReportSuccess(Z)V
    .locals 1

    .prologue
    .line 267
    monitor-enter p0

    :try_start_0
    iput-boolean p1, p0, Lcom/sun/mail/smtp/SMTPTransport;->reportSuccess:Z
    :try_end_0
    .catchall {:try_start_0 .. :try_end_0} :catchall_0

    .line 268
    monitor-exit p0

    return-void

    .line 267
    :catchall_0
    move-exception v0

    monitor-exit p0

    throw v0
.end method

.method public declared-synchronized setSASLRealm(Ljava/lang/String;)V
    .locals 1

    .prologue
    .line 238
    monitor-enter p0

    :try_start_0
    iput-object p1, p0, Lcom/sun/mail/smtp/SMTPTransport;->saslRealm:Ljava/lang/String;
    :try_end_0
    .catchall {:try_start_0 .. :try_end_0} :catchall_0

    .line 239
    monitor-exit p0

    return-void

    .line 238
    :catchall_0
    move-exception v0

    monitor-exit p0

    throw v0
.end method

.method public declared-synchronized setStartTLS(Z)V
    .locals 1

    .prologue
    .line 290
    monitor-enter p0

    :try_start_0
    iput-boolean p1, p0, Lcom/sun/mail/smtp/SMTPTransport;->useStartTLS:Z
    :try_end_0
    .catchall {:try_start_0 .. :try_end_0} :catchall_0

    .line 291
    monitor-exit p0

    return-void

    .line 290
    :catchall_0
    move-exception v0

    monitor-exit p0

    throw v0
.end method

.method public declared-synchronized setUseRset(Z)V
    .locals 1

    .prologue
    .line 314
    monitor-enter p0

    :try_start_0
    iput-boolean p1, p0, Lcom/sun/mail/smtp/SMTPTransport;->useRset:Z
    :try_end_0
    .catchall {:try_start_0 .. :try_end_0} :catchall_0

    .line 315
    monitor-exit p0

    return-void

    .line 314
    :catchall_0
    move-exception v0

    monitor-exit p0

    throw v0
.end method

.method public declared-synchronized simpleCommand(Ljava/lang/String;)I
    .locals 1
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljavax/mail/MessagingException;
        }
    .end annotation

    .prologue
    .line 1528
    monitor-enter p0

    :try_start_0
    invoke-virtual {p0, p1}, Lcom/sun/mail/smtp/SMTPTransport;->sendCommand(Ljava/lang/String;)V

    .line 1529
    invoke-virtual {p0}, Lcom/sun/mail/smtp/SMTPTransport;->readServerResponse()I
    :try_end_0
    .catchall {:try_start_0 .. :try_end_0} :catchall_0

    move-result v0

    monitor-exit p0

    return v0

    .line 1528
    :catchall_0
    move-exception v0

    monitor-exit p0

    throw v0
.end method

.method protected simpleCommand([B)I
    .locals 1
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljavax/mail/MessagingException;
        }
    .end annotation

    .prologue
    .line 1539
    sget-boolean v0, Lcom/sun/mail/smtp/SMTPTransport;->$assertionsDisabled:Z

    if-nez v0, :cond_0

    invoke-static {p0}, Ljava/lang/Thread;->holdsLock(Ljava/lang/Object;)Z

    move-result v0

    if-nez v0, :cond_0

    new-instance v0, Ljava/lang/AssertionError;

    invoke-direct {v0}, Ljava/lang/AssertionError;-><init>()V

    throw v0

    .line 1540
    :cond_0
    invoke-direct {p0, p1}, Lcom/sun/mail/smtp/SMTPTransport;->sendCommand([B)V

    .line 1541
    invoke-virtual {p0}, Lcom/sun/mail/smtp/SMTPTransport;->readServerResponse()I

    move-result v0

    return v0
.end method

.method protected startTLS()V
    .locals 4
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljavax/mail/MessagingException;
        }
    .end annotation

    .prologue
    .line 1331
    const-string v0, "STARTTLS"

    const/16 v1, 0xdc

    invoke-virtual {p0, v0, v1}, Lcom/sun/mail/smtp/SMTPTransport;->issueCommand(Ljava/lang/String;I)V

    .line 1334
    :try_start_0
    iget-object v0, p0, Lcom/sun/mail/smtp/SMTPTransport;->serverSocket:Ljava/net/Socket;

    .line 1335
    iget-object v1, p0, Lcom/sun/mail/smtp/SMTPTransport;->session:Ljavax/mail/Session;

    invoke-virtual {v1}, Ljavax/mail/Session;->getProperties()Ljava/util/Properties;

    move-result-object v1

    new-instance v2, Ljava/lang/StringBuilder;

    const-string v3, "mail."

    invoke-direct {v2, v3}, Ljava/lang/StringBuilder;-><init>(Ljava/lang/String;)V

    iget-object v3, p0, Lcom/sun/mail/smtp/SMTPTransport;->name:Ljava/lang/String;

    invoke-virtual {v2, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    invoke-virtual {v2}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v2

    .line 1334
    invoke-static {v0, v1, v2}, Lcom/sun/mail/util/SocketFetcher;->startTLS(Ljava/net/Socket;Ljava/util/Properties;Ljava/lang/String;)Ljava/net/Socket;

    move-result-object v0

    iput-object v0, p0, Lcom/sun/mail/smtp/SMTPTransport;->serverSocket:Ljava/net/Socket;

    .line 1336
    invoke-direct {p0}, Lcom/sun/mail/smtp/SMTPTransport;->initStreams()V
    :try_end_0
    .catch Ljava/io/IOException; {:try_start_0 .. :try_end_0} :catch_0

    .line 1342
    return-void

    .line 1337
    :catch_0
    move-exception v0

    .line 1338
    invoke-direct {p0}, Lcom/sun/mail/smtp/SMTPTransport;->closeConnection()V

    .line 1339
    new-instance v1, Ljavax/mail/MessagingException;

    const-string v2, "Could not convert socket to TLS"

    invoke-direct {v1, v2, v0}, Ljavax/mail/MessagingException;-><init>(Ljava/lang/String;Ljava/lang/Exception;)V

    throw v1
.end method

.method protected supportsAuthentication(Ljava/lang/String;)Z
    .locals 3

    .prologue
    const/4 v1, 0x0

    .line 1722
    sget-boolean v0, Lcom/sun/mail/smtp/SMTPTransport;->$assertionsDisabled:Z

    if-nez v0, :cond_0

    invoke-static {p0}, Ljava/lang/Thread;->holdsLock(Ljava/lang/Object;)Z

    move-result v0

    if-nez v0, :cond_0

    new-instance v0, Ljava/lang/AssertionError;

    invoke-direct {v0}, Ljava/lang/AssertionError;-><init>()V

    throw v0

    .line 1723
    :cond_0
    iget-object v0, p0, Lcom/sun/mail/smtp/SMTPTransport;->extMap:Ljava/util/Hashtable;

    if-nez v0, :cond_1

    move v0, v1

    .line 1734
    :goto_0
    return v0

    .line 1725
    :cond_1
    iget-object v0, p0, Lcom/sun/mail/smtp/SMTPTransport;->extMap:Ljava/util/Hashtable;

    const-string v2, "AUTH"

    invoke-virtual {v0, v2}, Ljava/util/Hashtable;->get(Ljava/lang/Object;)Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Ljava/lang/String;

    .line 1726
    if-nez v0, :cond_2

    move v0, v1

    .line 1727
    goto :goto_0

    .line 1728
    :cond_2
    new-instance v2, Ljava/util/StringTokenizer;

    invoke-direct {v2, v0}, Ljava/util/StringTokenizer;-><init>(Ljava/lang/String;)V

    .line 1729
    :cond_3
    invoke-virtual {v2}, Ljava/util/StringTokenizer;->hasMoreTokens()Z

    move-result v0

    if-nez v0, :cond_4

    move v0, v1

    .line 1734
    goto :goto_0

    .line 1730
    :cond_4
    invoke-virtual {v2}, Ljava/util/StringTokenizer;->nextToken()Ljava/lang/String;

    move-result-object v0

    .line 1731
    invoke-virtual {v0, p1}, Ljava/lang/String;->equalsIgnoreCase(Ljava/lang/String;)Z

    move-result v0

    if-eqz v0, :cond_3

    .line 1732
    const/4 v0, 0x1

    goto :goto_0
.end method

.method public supportsExtension(Ljava/lang/String;)Z
    .locals 2

    .prologue
    .line 1693
    iget-object v0, p0, Lcom/sun/mail/smtp/SMTPTransport;->extMap:Ljava/util/Hashtable;

    if-eqz v0, :cond_0

    .line 1694
    iget-object v0, p0, Lcom/sun/mail/smtp/SMTPTransport;->extMap:Ljava/util/Hashtable;

    sget-object v1, Ljava/util/Locale;->ENGLISH:Ljava/util/Locale;

    invoke-virtual {p1, v1}, Ljava/lang/String;->toUpperCase(Ljava/util/Locale;)Ljava/lang/String;

    move-result-object v1

    invoke-virtual {v0, v1}, Ljava/util/Hashtable;->get(Ljava/lang/Object;)Ljava/lang/Object;

    move-result-object v0

    if-eqz v0, :cond_0

    const/4 v0, 0x1

    :goto_0
    return v0

    :cond_0
    const/4 v0, 0x0

    .line 1693
    goto :goto_0
.end method
