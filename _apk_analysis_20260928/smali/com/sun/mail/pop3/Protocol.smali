.class Lcom/sun/mail/pop3/Protocol;
.super Ljava/lang/Object;
.source "SourceFile"


# static fields
.field private static final CRLF:Ljava/lang/String; = "\r\n"

.field private static final POP3_PORT:I = 0x6e

.field private static digits:[C


# instance fields
.field private apopChallenge:Ljava/lang/String;

.field private debug:Z

.field private input:Ljava/io/DataInputStream;

.field private out:Ljava/io/PrintStream;

.field private output:Ljava/io/PrintWriter;

.field private socket:Ljava/net/Socket;


# direct methods
.method static constructor <clinit>()V
    .locals 1

    .prologue
    .line 186
    const/16 v0, 0x10

    new-array v0, v0, [C

    fill-array-data v0, :array_0

    sput-object v0, Lcom/sun/mail/pop3/Protocol;->digits:[C

    .line 66
    return-void

    .line 186
    :array_0
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
        0x61s
        0x62s
        0x63s
        0x64s
        0x65s
        0x66s
    .end array-data
.end method

.method constructor <init>(Ljava/lang/String;IZLjava/io/PrintStream;Ljava/util/Properties;Ljava/lang/String;Z)V
    .locals 7
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljava/io/IOException;
        }
    .end annotation

    .prologue
    const/4 v1, 0x0

    const/4 v0, 0x0

    const/4 v6, -0x1

    .line 79
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    .line 72
    iput-boolean v0, p0, Lcom/sun/mail/pop3/Protocol;->debug:Z

    .line 74
    iput-object v1, p0, Lcom/sun/mail/pop3/Protocol;->apopChallenge:Ljava/lang/String;

    .line 82
    iput-boolean p3, p0, Lcom/sun/mail/pop3/Protocol;->debug:Z

    .line 83
    iput-object p4, p0, Lcom/sun/mail/pop3/Protocol;->out:Ljava/io/PrintStream;

    .line 85
    new-instance v1, Ljava/lang/StringBuilder;

    invoke-static {p6}, Ljava/lang/String;->valueOf(Ljava/lang/Object;)Ljava/lang/String;

    move-result-object v2

    invoke-direct {v1, v2}, Ljava/lang/StringBuilder;-><init>(Ljava/lang/String;)V

    const-string v2, ".apop.enable"

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v1

    invoke-virtual {p5, v1}, Ljava/util/Properties;->getProperty(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v1

    .line 86
    if-eqz v1, :cond_0

    const-string v2, "true"

    invoke-virtual {v1, v2}, Ljava/lang/String;->equalsIgnoreCase(Ljava/lang/String;)Z

    move-result v1

    if-eqz v1, :cond_0

    const/4 v0, 0x1

    .line 88
    :cond_0
    if-ne p2, v6, :cond_1

    .line 89
    const/16 p2, 0x6e

    .line 90
    :cond_1
    if-eqz p3, :cond_2

    .line 91
    :try_start_0
    new-instance v1, Ljava/lang/StringBuilder;

    const-string v2, "DEBUG POP3: connecting to host \""

    invoke-direct {v1, v2}, Ljava/lang/StringBuilder;-><init>(Ljava/lang/String;)V

    invoke-virtual {v1, p1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    .line 92
    const-string v2, "\", port "

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1, p2}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v1

    const-string v2, ", isSSL "

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1, p7}, Ljava/lang/StringBuilder;->append(Z)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v1

    .line 91
    invoke-virtual {p4, v1}, Ljava/io/PrintStream;->println(Ljava/lang/String;)V

    .line 94
    :cond_2
    invoke-static {p1, p2, p5, p6, p7}, Lcom/sun/mail/util/SocketFetcher;->getSocket(Ljava/lang/String;ILjava/util/Properties;Ljava/lang/String;Z)Ljava/net/Socket;

    move-result-object v1

    iput-object v1, p0, Lcom/sun/mail/pop3/Protocol;->socket:Ljava/net/Socket;

    .line 96
    new-instance v1, Ljava/io/DataInputStream;

    .line 97
    new-instance v2, Ljava/io/BufferedInputStream;

    iget-object v3, p0, Lcom/sun/mail/pop3/Protocol;->socket:Ljava/net/Socket;

    invoke-virtual {v3}, Ljava/net/Socket;->getInputStream()Ljava/io/InputStream;

    move-result-object v3

    invoke-direct {v2, v3}, Ljava/io/BufferedInputStream;-><init>(Ljava/io/InputStream;)V

    invoke-direct {v1, v2}, Ljava/io/DataInputStream;-><init>(Ljava/io/InputStream;)V

    .line 96
    iput-object v1, p0, Lcom/sun/mail/pop3/Protocol;->input:Ljava/io/DataInputStream;

    .line 98
    new-instance v1, Ljava/io/PrintWriter;

    .line 99
    new-instance v2, Ljava/io/BufferedWriter;

    .line 100
    new-instance v3, Ljava/io/OutputStreamWriter;

    iget-object v4, p0, Lcom/sun/mail/pop3/Protocol;->socket:Ljava/net/Socket;

    invoke-virtual {v4}, Ljava/net/Socket;->getOutputStream()Ljava/io/OutputStream;

    move-result-object v4

    .line 101
    const-string v5, "iso-8859-1"

    .line 100
    invoke-direct {v3, v4, v5}, Ljava/io/OutputStreamWriter;-><init>(Ljava/io/OutputStream;Ljava/lang/String;)V

    .line 99
    invoke-direct {v2, v3}, Ljava/io/BufferedWriter;-><init>(Ljava/io/Writer;)V

    invoke-direct {v1, v2}, Ljava/io/PrintWriter;-><init>(Ljava/io/Writer;)V

    .line 98
    iput-object v1, p0, Lcom/sun/mail/pop3/Protocol;->output:Ljava/io/PrintWriter;

    .line 104
    const/4 v1, 0x0

    invoke-direct {p0, v1}, Lcom/sun/mail/pop3/Protocol;->simpleCommand(Ljava/lang/String;)Lcom/sun/mail/pop3/Response;
    :try_end_0
    .catch Ljava/io/IOException; {:try_start_0 .. :try_end_0} :catch_0

    move-result-object v1

    .line 113
    iget-boolean v2, v1, Lcom/sun/mail/pop3/Response;->ok:Z

    if-nez v2, :cond_3

    .line 115
    :try_start_1
    iget-object v0, p0, Lcom/sun/mail/pop3/Protocol;->socket:Ljava/net/Socket;

    invoke-virtual {v0}, Ljava/net/Socket;->close()V
    :try_end_1
    .catchall {:try_start_1 .. :try_end_1} :catchall_0

    .line 117
    :goto_0
    new-instance v0, Ljava/io/IOException;

    const-string v1, "Connect failed"

    invoke-direct {v0, v1}, Ljava/io/IOException;-><init>(Ljava/lang/String;)V

    throw v0

    .line 105
    :catch_0
    move-exception v0

    .line 107
    :try_start_2
    iget-object v1, p0, Lcom/sun/mail/pop3/Protocol;->socket:Ljava/net/Socket;

    invoke-virtual {v1}, Ljava/net/Socket;->close()V
    :try_end_2
    .catchall {:try_start_2 .. :try_end_2} :catchall_1

    .line 109
    :goto_1
    throw v0

    .line 120
    :cond_3
    if-eqz v0, :cond_5

    .line 121
    iget-object v0, v1, Lcom/sun/mail/pop3/Response;->data:Ljava/lang/String;

    const/16 v2, 0x3c

    invoke-virtual {v0, v2}, Ljava/lang/String;->indexOf(I)I

    move-result v0

    .line 122
    iget-object v2, v1, Lcom/sun/mail/pop3/Response;->data:Ljava/lang/String;

    const/16 v3, 0x3e

    invoke-virtual {v2, v3, v0}, Ljava/lang/String;->indexOf(II)I

    move-result v2

    .line 123
    if-eq v0, v6, :cond_4

    if-eq v2, v6, :cond_4

    .line 124
    iget-object v1, v1, Lcom/sun/mail/pop3/Response;->data:Ljava/lang/String;

    add-int/lit8 v2, v2, 0x1

    invoke-virtual {v1, v0, v2}, Ljava/lang/String;->substring(II)Ljava/lang/String;

    move-result-object v0

    iput-object v0, p0, Lcom/sun/mail/pop3/Protocol;->apopChallenge:Ljava/lang/String;

    .line 125
    :cond_4
    if-eqz p3, :cond_5

    .line 126
    new-instance v0, Ljava/lang/StringBuilder;

    const-string v1, "DEBUG POP3: APOP challenge: "

    invoke-direct {v0, v1}, Ljava/lang/StringBuilder;-><init>(Ljava/lang/String;)V

    iget-object v1, p0, Lcom/sun/mail/pop3/Protocol;->apopChallenge:Ljava/lang/String;

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-virtual {v0}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v0

    invoke-virtual {p4, v0}, Ljava/io/PrintStream;->println(Ljava/lang/String;)V

    .line 128
    :cond_5
    return-void

    :catchall_0
    move-exception v0

    goto :goto_0

    :catchall_1
    move-exception v1

    goto :goto_1
.end method

.method private getDigest(Ljava/lang/String;)Ljava/lang/String;
    .locals 4

    .prologue
    const/4 v0, 0x0

    .line 173
    new-instance v1, Ljava/lang/StringBuilder;

    iget-object v2, p0, Lcom/sun/mail/pop3/Protocol;->apopChallenge:Ljava/lang/String;

    invoke-static {v2}, Ljava/lang/String;->valueOf(Ljava/lang/Object;)Ljava/lang/String;

    move-result-object v2

    invoke-direct {v1, v2}, Ljava/lang/StringBuilder;-><init>(Ljava/lang/String;)V

    invoke-virtual {v1, p1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v1

    .line 176
    :try_start_0
    const-string v2, "MD5"

    invoke-static {v2}, Ljava/security/MessageDigest;->getInstance(Ljava/lang/String;)Ljava/security/MessageDigest;

    move-result-object v2

    .line 177
    const-string v3, "iso-8859-1"

    invoke-virtual {v1, v3}, Ljava/lang/String;->getBytes(Ljava/lang/String;)[B

    move-result-object v1

    invoke-virtual {v2, v1}, Ljava/security/MessageDigest;->digest([B)[B
    :try_end_0
    .catch Ljava/security/NoSuchAlgorithmException; {:try_start_0 .. :try_end_0} :catch_1
    .catch Ljava/io/UnsupportedEncodingException; {:try_start_0 .. :try_end_0} :catch_0

    move-result-object v0

    .line 183
    invoke-static {v0}, Lcom/sun/mail/pop3/Protocol;->toHex([B)Ljava/lang/String;

    move-result-object v0

    :goto_0
    return-object v0

    .line 180
    :catch_0
    move-exception v1

    goto :goto_0

    .line 178
    :catch_1
    move-exception v1

    goto :goto_0
.end method

.method private multilineCommand(Ljava/lang/String;I)Lcom/sun/mail/pop3/Response;
    .locals 5
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljava/io/IOException;
        }
    .end annotation

    .prologue
    const/16 v1, 0xa

    .line 386
    invoke-direct {p0, p1}, Lcom/sun/mail/pop3/Protocol;->simpleCommand(Ljava/lang/String;)Lcom/sun/mail/pop3/Response;

    move-result-object v3

    .line 387
    iget-boolean v0, v3, Lcom/sun/mail/pop3/Response;->ok:Z

    if-nez v0, :cond_0

    move-object v0, v3

    .line 415
    :goto_0
    return-object v0

    .line 390
    :cond_0
    new-instance v4, Lcom/sun/mail/pop3/SharedByteArrayOutputStream;

    invoke-direct {v4, p2}, Lcom/sun/mail/pop3/SharedByteArrayOutputStream;-><init>(I)V

    move v0, v1

    .line 392
    :cond_1
    :goto_1
    iget-object v2, p0, Lcom/sun/mail/pop3/Protocol;->input:Ljava/io/DataInputStream;

    invoke-virtual {v2}, Ljava/io/DataInputStream;->read()I

    move-result v2

    if-gez v2, :cond_3

    .line 412
    :cond_2
    :goto_2
    if-gez v2, :cond_8

    .line 413
    new-instance v0, Ljava/io/EOFException;

    const-string v1, "EOF on socket"

    invoke-direct {v0, v1}, Ljava/io/EOFException;-><init>(Ljava/lang/String;)V

    throw v0

    .line 393
    :cond_3
    if-ne v0, v1, :cond_6

    const/16 v0, 0x2e

    if-ne v2, v0, :cond_6

    .line 394
    iget-boolean v0, p0, Lcom/sun/mail/pop3/Protocol;->debug:Z

    if-eqz v0, :cond_4

    .line 395
    iget-object v0, p0, Lcom/sun/mail/pop3/Protocol;->out:Ljava/io/PrintStream;

    invoke-virtual {v0, v2}, Ljava/io/PrintStream;->write(I)V

    .line 396
    :cond_4
    iget-object v0, p0, Lcom/sun/mail/pop3/Protocol;->input:Ljava/io/DataInputStream;

    invoke-virtual {v0}, Ljava/io/DataInputStream;->read()I

    move-result v0

    .line 397
    const/16 v2, 0xd

    if-ne v0, v2, :cond_7

    .line 398
    iget-boolean v1, p0, Lcom/sun/mail/pop3/Protocol;->debug:Z

    if-eqz v1, :cond_5

    .line 399
    iget-object v1, p0, Lcom/sun/mail/pop3/Protocol;->out:Ljava/io/PrintStream;

    invoke-virtual {v1, v0}, Ljava/io/PrintStream;->write(I)V

    .line 401
    :cond_5
    iget-object v0, p0, Lcom/sun/mail/pop3/Protocol;->input:Ljava/io/DataInputStream;

    invoke-virtual {v0}, Ljava/io/DataInputStream;->read()I

    move-result v2

    .line 402
    iget-boolean v0, p0, Lcom/sun/mail/pop3/Protocol;->debug:Z

    if-eqz v0, :cond_2

    .line 403
    iget-object v0, p0, Lcom/sun/mail/pop3/Protocol;->out:Ljava/io/PrintStream;

    invoke-virtual {v0, v2}, Ljava/io/PrintStream;->write(I)V

    goto :goto_2

    :cond_6
    move v0, v2

    .line 407
    :cond_7
    invoke-virtual {v4, v0}, Lcom/sun/mail/pop3/SharedByteArrayOutputStream;->write(I)V

    .line 408
    iget-boolean v2, p0, Lcom/sun/mail/pop3/Protocol;->debug:Z

    if-eqz v2, :cond_1

    .line 409
    iget-object v2, p0, Lcom/sun/mail/pop3/Protocol;->out:Ljava/io/PrintStream;

    invoke-virtual {v2, v0}, Ljava/io/PrintStream;->write(I)V

    goto :goto_1

    .line 414
    :cond_8
    invoke-virtual {v4}, Lcom/sun/mail/pop3/SharedByteArrayOutputStream;->toStream()Ljava/io/InputStream;

    move-result-object v0

    iput-object v0, v3, Lcom/sun/mail/pop3/Response;->bytes:Ljava/io/InputStream;

    move-object v0, v3

    .line 415
    goto :goto_0
.end method

.method private simpleCommand(Ljava/lang/String;)Lcom/sun/mail/pop3/Response;
    .locals 4
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljava/io/IOException;
        }
    .end annotation

    .prologue
    .line 351
    iget-object v0, p0, Lcom/sun/mail/pop3/Protocol;->socket:Ljava/net/Socket;

    if-nez v0, :cond_0

    .line 352
    new-instance v0, Ljava/io/IOException;

    const-string v1, "Folder is closed"

    invoke-direct {v0, v1}, Ljava/io/IOException;-><init>(Ljava/lang/String;)V

    throw v0

    .line 353
    :cond_0
    if-eqz p1, :cond_2

    .line 354
    iget-boolean v0, p0, Lcom/sun/mail/pop3/Protocol;->debug:Z

    if-eqz v0, :cond_1

    .line 355
    iget-object v0, p0, Lcom/sun/mail/pop3/Protocol;->out:Ljava/io/PrintStream;

    new-instance v1, Ljava/lang/StringBuilder;

    const-string v2, "C: "

    invoke-direct {v1, v2}, Ljava/lang/StringBuilder;-><init>(Ljava/lang/String;)V

    invoke-virtual {v1, p1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v1

    invoke-virtual {v0, v1}, Ljava/io/PrintStream;->println(Ljava/lang/String;)V

    .line 356
    :cond_1
    new-instance v0, Ljava/lang/StringBuilder;

    invoke-static {p1}, Ljava/lang/String;->valueOf(Ljava/lang/Object;)Ljava/lang/String;

    move-result-object v1

    invoke-direct {v0, v1}, Ljava/lang/StringBuilder;-><init>(Ljava/lang/String;)V

    const-string v1, "\r\n"

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-virtual {v0}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v0

    .line 357
    iget-object v1, p0, Lcom/sun/mail/pop3/Protocol;->output:Ljava/io/PrintWriter;

    invoke-virtual {v1, v0}, Ljava/io/PrintWriter;->print(Ljava/lang/String;)V

    .line 358
    iget-object v0, p0, Lcom/sun/mail/pop3/Protocol;->output:Ljava/io/PrintWriter;

    invoke-virtual {v0}, Ljava/io/PrintWriter;->flush()V

    .line 360
    :cond_2
    iget-object v0, p0, Lcom/sun/mail/pop3/Protocol;->input:Ljava/io/DataInputStream;

    invoke-virtual {v0}, Ljava/io/DataInputStream;->readLine()Ljava/lang/String;

    move-result-object v0

    .line 361
    if-nez v0, :cond_4

    .line 362
    iget-boolean v0, p0, Lcom/sun/mail/pop3/Protocol;->debug:Z

    if-eqz v0, :cond_3

    .line 363
    iget-object v0, p0, Lcom/sun/mail/pop3/Protocol;->out:Ljava/io/PrintStream;

    const-string v1, "S: EOF"

    invoke-virtual {v0, v1}, Ljava/io/PrintStream;->println(Ljava/lang/String;)V

    .line 364
    :cond_3
    new-instance v0, Ljava/io/EOFException;

    const-string v1, "EOF on socket"

    invoke-direct {v0, v1}, Ljava/io/EOFException;-><init>(Ljava/lang/String;)V

    throw v0

    .line 366
    :cond_4
    iget-boolean v1, p0, Lcom/sun/mail/pop3/Protocol;->debug:Z

    if-eqz v1, :cond_5

    .line 367
    iget-object v1, p0, Lcom/sun/mail/pop3/Protocol;->out:Ljava/io/PrintStream;

    new-instance v2, Ljava/lang/StringBuilder;

    const-string v3, "S: "

    invoke-direct {v2, v3}, Ljava/lang/StringBuilder;-><init>(Ljava/lang/String;)V

    invoke-virtual {v2, v0}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    invoke-virtual {v2}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v2

    invoke-virtual {v1, v2}, Ljava/io/PrintStream;->println(Ljava/lang/String;)V

    .line 368
    :cond_5
    new-instance v1, Lcom/sun/mail/pop3/Response;

    invoke-direct {v1}, Lcom/sun/mail/pop3/Response;-><init>()V

    .line 369
    const-string v2, "+OK"

    invoke-virtual {v0, v2}, Ljava/lang/String;->startsWith(Ljava/lang/String;)Z

    move-result v2

    if-eqz v2, :cond_7

    .line 370
    const/4 v2, 0x1

    iput-boolean v2, v1, Lcom/sun/mail/pop3/Response;->ok:Z

    .line 376
    :goto_0
    const/16 v2, 0x20

    invoke-virtual {v0, v2}, Ljava/lang/String;->indexOf(I)I

    move-result v2

    if-ltz v2, :cond_6

    .line 377
    add-int/lit8 v2, v2, 0x1

    invoke-virtual {v0, v2}, Ljava/lang/String;->substring(I)Ljava/lang/String;

    move-result-object v0

    iput-object v0, v1, Lcom/sun/mail/pop3/Response;->data:Ljava/lang/String;

    .line 378
    :cond_6
    return-object v1

    .line 371
    :cond_7
    const-string v2, "-ERR"

    invoke-virtual {v0, v2}, Ljava/lang/String;->startsWith(Ljava/lang/String;)Z

    move-result v2

    if-eqz v2, :cond_8

    .line 372
    const/4 v2, 0x0

    iput-boolean v2, v1, Lcom/sun/mail/pop3/Response;->ok:Z

    goto :goto_0

    .line 374
    :cond_8
    new-instance v1, Ljava/io/IOException;

    new-instance v2, Ljava/lang/StringBuilder;

    const-string v3, "Unexpected response: "

    invoke-direct {v2, v3}, Ljava/lang/StringBuilder;-><init>(Ljava/lang/String;)V

    invoke-virtual {v2, v0}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-virtual {v0}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v0

    invoke-direct {v1, v0}, Ljava/io/IOException;-><init>(Ljava/lang/String;)V

    throw v1
.end method

.method private static toHex([B)Ljava/lang/String;
    .locals 7

    .prologue
    const/4 v0, 0x0

    .line 195
    array-length v1, p0

    mul-int/lit8 v1, v1, 0x2

    new-array v2, v1, [C

    move v1, v0

    .line 197
    :goto_0
    array-length v3, p0

    if-lt v1, v3, :cond_0

    .line 202
    new-instance v0, Ljava/lang/String;

    invoke-direct {v0, v2}, Ljava/lang/String;-><init>([C)V

    return-object v0

    .line 198
    :cond_0
    aget-byte v3, p0, v1

    and-int/lit16 v3, v3, 0xff

    .line 199
    add-int/lit8 v4, v0, 0x1

    sget-object v5, Lcom/sun/mail/pop3/Protocol;->digits:[C

    shr-int/lit8 v6, v3, 0x4

    aget-char v5, v5, v6

    aput-char v5, v2, v0

    .line 200
    add-int/lit8 v0, v4, 0x1

    sget-object v5, Lcom/sun/mail/pop3/Protocol;->digits:[C

    and-int/lit8 v3, v3, 0xf

    aget-char v3, v5, v3

    aput-char v3, v2, v4

    .line 197
    add-int/lit8 v1, v1, 0x1

    goto :goto_0
.end method


# virtual methods
.method declared-synchronized dele(I)Z
    .locals 2
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljava/io/IOException;
        }
    .end annotation

    .prologue
    .line 292
    monitor-enter p0

    :try_start_0
    new-instance v0, Ljava/lang/StringBuilder;

    const-string v1, "DELE "

    invoke-direct {v0, v1}, Ljava/lang/StringBuilder;-><init>(Ljava/lang/String;)V

    invoke-virtual {v0, p1}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-virtual {v0}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v0

    invoke-direct {p0, v0}, Lcom/sun/mail/pop3/Protocol;->simpleCommand(Ljava/lang/String;)Lcom/sun/mail/pop3/Response;

    move-result-object v0

    .line 293
    iget-boolean v0, v0, Lcom/sun/mail/pop3/Response;->ok:Z
    :try_end_0
    .catchall {:try_start_0 .. :try_end_0} :catchall_0

    monitor-exit p0

    return v0

    .line 292
    :catchall_0
    move-exception v0

    monitor-exit p0

    throw v0
.end method

.method protected finalize()V
    .locals 1
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljava/lang/Throwable;
        }
    .end annotation

    .prologue
    .line 131
    invoke-super {p0}, Ljava/lang/Object;->finalize()V

    .line 132
    iget-object v0, p0, Lcom/sun/mail/pop3/Protocol;->socket:Ljava/net/Socket;

    if-eqz v0, :cond_0

    .line 133
    invoke-virtual {p0}, Lcom/sun/mail/pop3/Protocol;->quit()Z

    .line 135
    :cond_0
    return-void
.end method

.method declared-synchronized list(I)I
    .locals 3
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljava/io/IOException;
        }
    .end annotation

    .prologue
    .line 248
    monitor-enter p0

    :try_start_0
    new-instance v0, Ljava/lang/StringBuilder;

    const-string v1, "LIST "

    invoke-direct {v0, v1}, Ljava/lang/StringBuilder;-><init>(Ljava/lang/String;)V

    invoke-virtual {v0, p1}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-virtual {v0}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v0

    invoke-direct {p0, v0}, Lcom/sun/mail/pop3/Protocol;->simpleCommand(Ljava/lang/String;)Lcom/sun/mail/pop3/Response;

    move-result-object v1

    .line 249
    const/4 v0, -0x1

    .line 250
    iget-boolean v2, v1, Lcom/sun/mail/pop3/Response;->ok:Z

    if-eqz v2, :cond_0

    iget-object v2, v1, Lcom/sun/mail/pop3/Response;->data:Ljava/lang/String;
    :try_end_0
    .catchall {:try_start_0 .. :try_end_0} :catchall_0

    if-eqz v2, :cond_0

    .line 252
    :try_start_1
    new-instance v2, Ljava/util/StringTokenizer;

    iget-object v1, v1, Lcom/sun/mail/pop3/Response;->data:Ljava/lang/String;

    invoke-direct {v2, v1}, Ljava/util/StringTokenizer;-><init>(Ljava/lang/String;)V

    .line 253
    invoke-virtual {v2}, Ljava/util/StringTokenizer;->nextToken()Ljava/lang/String;

    .line 254
    invoke-virtual {v2}, Ljava/util/StringTokenizer;->nextToken()Ljava/lang/String;

    move-result-object v1

    invoke-static {v1}, Ljava/lang/Integer;->parseInt(Ljava/lang/String;)I
    :try_end_1
    .catch Ljava/lang/Exception; {:try_start_1 .. :try_end_1} :catch_0
    .catchall {:try_start_1 .. :try_end_1} :catchall_0

    move-result v0

    .line 258
    :cond_0
    :goto_0
    monitor-exit p0

    return v0

    .line 248
    :catchall_0
    move-exception v0

    monitor-exit p0

    throw v0

    .line 255
    :catch_0
    move-exception v1

    goto :goto_0
.end method

.method declared-synchronized list()Ljava/io/InputStream;
    .locals 2
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljava/io/IOException;
        }
    .end annotation

    .prologue
    .line 265
    monitor-enter p0

    :try_start_0
    const-string v0, "LIST"

    const/16 v1, 0x80

    invoke-direct {p0, v0, v1}, Lcom/sun/mail/pop3/Protocol;->multilineCommand(Ljava/lang/String;I)Lcom/sun/mail/pop3/Response;

    move-result-object v0

    .line 266
    iget-object v0, v0, Lcom/sun/mail/pop3/Response;->bytes:Ljava/io/InputStream;
    :try_end_0
    .catchall {:try_start_0 .. :try_end_0} :catchall_0

    monitor-exit p0

    return-object v0

    .line 265
    :catchall_0
    move-exception v0

    monitor-exit p0

    throw v0
.end method

.method declared-synchronized login(Ljava/lang/String;Ljava/lang/String;)Ljava/lang/String;
    .locals 4
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljava/io/IOException;
        }
    .end annotation

    .prologue
    const/4 v0, 0x0

    .line 143
    monitor-enter p0

    .line 144
    :try_start_0
    iget-object v1, p0, Lcom/sun/mail/pop3/Protocol;->apopChallenge:Ljava/lang/String;

    if-eqz v1, :cond_5

    .line 145
    invoke-direct {p0, p2}, Lcom/sun/mail/pop3/Protocol;->getDigest(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v1

    .line 146
    :goto_0
    iget-object v2, p0, Lcom/sun/mail/pop3/Protocol;->apopChallenge:Ljava/lang/String;

    if-eqz v2, :cond_1

    if-eqz v1, :cond_1

    .line 147
    new-instance v2, Ljava/lang/StringBuilder;

    const-string v3, "APOP "

    invoke-direct {v2, v3}, Ljava/lang/StringBuilder;-><init>(Ljava/lang/String;)V

    invoke-virtual {v2, p1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    const-string v3, " "

    invoke-virtual {v2, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    invoke-virtual {v2, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v1

    invoke-direct {p0, v1}, Lcom/sun/mail/pop3/Protocol;->simpleCommand(Ljava/lang/String;)Lcom/sun/mail/pop3/Response;

    move-result-object v1

    .line 154
    :goto_1
    iget-boolean v2, v1, Lcom/sun/mail/pop3/Response;->ok:Z

    if-nez v2, :cond_0

    .line 155
    iget-object v0, v1, Lcom/sun/mail/pop3/Response;->data:Ljava/lang/String;

    if-eqz v0, :cond_4

    iget-object v0, v1, Lcom/sun/mail/pop3/Response;->data:Ljava/lang/String;
    :try_end_0
    .catchall {:try_start_0 .. :try_end_0} :catchall_0

    .line 156
    :cond_0
    :goto_2
    monitor-exit p0

    return-object v0

    .line 149
    :cond_1
    :try_start_1
    new-instance v1, Ljava/lang/StringBuilder;

    const-string v2, "USER "

    invoke-direct {v1, v2}, Ljava/lang/StringBuilder;-><init>(Ljava/lang/String;)V

    invoke-virtual {v1, p1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v1

    invoke-direct {p0, v1}, Lcom/sun/mail/pop3/Protocol;->simpleCommand(Ljava/lang/String;)Lcom/sun/mail/pop3/Response;

    move-result-object v1

    .line 150
    iget-boolean v2, v1, Lcom/sun/mail/pop3/Response;->ok:Z

    if-nez v2, :cond_3

    .line 151
    iget-object v0, v1, Lcom/sun/mail/pop3/Response;->data:Ljava/lang/String;

    if-eqz v0, :cond_2

    iget-object v0, v1, Lcom/sun/mail/pop3/Response;->data:Ljava/lang/String;

    goto :goto_2

    :cond_2
    const-string v0, "USER command failed"

    goto :goto_2

    .line 152
    :cond_3
    new-instance v1, Ljava/lang/StringBuilder;

    const-string v2, "PASS "

    invoke-direct {v1, v2}, Ljava/lang/StringBuilder;-><init>(Ljava/lang/String;)V

    invoke-virtual {v1, p2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v1

    invoke-direct {p0, v1}, Lcom/sun/mail/pop3/Protocol;->simpleCommand(Ljava/lang/String;)Lcom/sun/mail/pop3/Response;

    move-result-object v1

    goto :goto_1

    .line 155
    :cond_4
    const-string v0, "login failed"
    :try_end_1
    .catchall {:try_start_1 .. :try_end_1} :catchall_0

    goto :goto_2

    .line 143
    :catchall_0
    move-exception v0

    monitor-exit p0

    throw v0

    :cond_5
    move-object v1, v0

    goto :goto_0
.end method

.method declared-synchronized noop()Z
    .locals 1
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljava/io/IOException;
        }
    .end annotation

    .prologue
    .line 335
    monitor-enter p0

    :try_start_0
    const-string v0, "NOOP"

    invoke-direct {p0, v0}, Lcom/sun/mail/pop3/Protocol;->simpleCommand(Ljava/lang/String;)Lcom/sun/mail/pop3/Response;

    move-result-object v0

    .line 336
    iget-boolean v0, v0, Lcom/sun/mail/pop3/Response;->ok:Z
    :try_end_0
    .catchall {:try_start_0 .. :try_end_0} :catchall_0

    monitor-exit p0

    return v0

    .line 335
    :catchall_0
    move-exception v0

    monitor-exit p0

    throw v0
.end method

.method declared-synchronized quit()Z
    .locals 2
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljava/io/IOException;
        }
    .end annotation

    .prologue
    .line 210
    monitor-enter p0

    .line 212
    :try_start_0
    const-string v0, "QUIT"

    invoke-direct {p0, v0}, Lcom/sun/mail/pop3/Protocol;->simpleCommand(Ljava/lang/String;)Lcom/sun/mail/pop3/Response;

    move-result-object v0

    .line 213
    iget-boolean v0, v0, Lcom/sun/mail/pop3/Response;->ok:Z
    :try_end_0
    .catchall {:try_start_0 .. :try_end_0} :catchall_0

    .line 216
    :try_start_1
    iget-object v1, p0, Lcom/sun/mail/pop3/Protocol;->socket:Ljava/net/Socket;

    invoke-virtual {v1}, Ljava/net/Socket;->close()V
    :try_end_1
    .catchall {:try_start_1 .. :try_end_1} :catchall_3

    .line 218
    const/4 v1, 0x0

    :try_start_2
    iput-object v1, p0, Lcom/sun/mail/pop3/Protocol;->socket:Ljava/net/Socket;

    .line 219
    const/4 v1, 0x0

    iput-object v1, p0, Lcom/sun/mail/pop3/Protocol;->input:Ljava/io/DataInputStream;

    .line 220
    const/4 v1, 0x0

    iput-object v1, p0, Lcom/sun/mail/pop3/Protocol;->output:Ljava/io/PrintWriter;
    :try_end_2
    .catchall {:try_start_2 .. :try_end_2} :catchall_1

    .line 223
    monitor-exit p0

    return v0

    .line 214
    :catchall_0
    move-exception v0

    .line 216
    :try_start_3
    iget-object v1, p0, Lcom/sun/mail/pop3/Protocol;->socket:Ljava/net/Socket;

    invoke-virtual {v1}, Ljava/net/Socket;->close()V
    :try_end_3
    .catchall {:try_start_3 .. :try_end_3} :catchall_2

    .line 218
    const/4 v1, 0x0

    :try_start_4
    iput-object v1, p0, Lcom/sun/mail/pop3/Protocol;->socket:Ljava/net/Socket;

    .line 219
    const/4 v1, 0x0

    iput-object v1, p0, Lcom/sun/mail/pop3/Protocol;->input:Ljava/io/DataInputStream;

    .line 220
    const/4 v1, 0x0

    iput-object v1, p0, Lcom/sun/mail/pop3/Protocol;->output:Ljava/io/PrintWriter;

    .line 222
    throw v0
    :try_end_4
    .catchall {:try_start_4 .. :try_end_4} :catchall_1

    .line 210
    :catchall_1
    move-exception v0

    monitor-exit p0

    throw v0

    .line 217
    :catchall_2
    move-exception v0

    .line 218
    const/4 v1, 0x0

    :try_start_5
    iput-object v1, p0, Lcom/sun/mail/pop3/Protocol;->socket:Ljava/net/Socket;

    .line 219
    const/4 v1, 0x0

    iput-object v1, p0, Lcom/sun/mail/pop3/Protocol;->input:Ljava/io/DataInputStream;

    .line 220
    const/4 v1, 0x0

    iput-object v1, p0, Lcom/sun/mail/pop3/Protocol;->output:Ljava/io/PrintWriter;

    .line 221
    throw v0

    .line 217
    :catchall_3
    move-exception v0

    .line 218
    const/4 v1, 0x0

    iput-object v1, p0, Lcom/sun/mail/pop3/Protocol;->socket:Ljava/net/Socket;

    .line 219
    const/4 v1, 0x0

    iput-object v1, p0, Lcom/sun/mail/pop3/Protocol;->input:Ljava/io/DataInputStream;

    .line 220
    const/4 v1, 0x0

    iput-object v1, p0, Lcom/sun/mail/pop3/Protocol;->output:Ljava/io/PrintWriter;

    .line 221
    throw v0
    :try_end_5
    .catchall {:try_start_5 .. :try_end_5} :catchall_1
.end method

.method declared-synchronized retr(II)Ljava/io/InputStream;
    .locals 2
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljava/io/IOException;
        }
    .end annotation

    .prologue
    .line 276
    monitor-enter p0

    :try_start_0
    new-instance v0, Ljava/lang/StringBuilder;

    const-string v1, "RETR "

    invoke-direct {v0, v1}, Ljava/lang/StringBuilder;-><init>(Ljava/lang/String;)V

    invoke-virtual {v0, p1}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-virtual {v0}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v0

    invoke-direct {p0, v0, p2}, Lcom/sun/mail/pop3/Protocol;->multilineCommand(Ljava/lang/String;I)Lcom/sun/mail/pop3/Response;

    move-result-object v0

    .line 277
    iget-object v0, v0, Lcom/sun/mail/pop3/Response;->bytes:Ljava/io/InputStream;
    :try_end_0
    .catchall {:try_start_0 .. :try_end_0} :catchall_0

    monitor-exit p0

    return-object v0

    .line 276
    :catchall_0
    move-exception v0

    monitor-exit p0

    throw v0
.end method

.method declared-synchronized rset()Z
    .locals 1
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljava/io/IOException;
        }
    .end annotation

    .prologue
    .line 343
    monitor-enter p0

    :try_start_0
    const-string v0, "RSET"

    invoke-direct {p0, v0}, Lcom/sun/mail/pop3/Protocol;->simpleCommand(Ljava/lang/String;)Lcom/sun/mail/pop3/Response;

    move-result-object v0

    .line 344
    iget-boolean v0, v0, Lcom/sun/mail/pop3/Response;->ok:Z
    :try_end_0
    .catchall {:try_start_0 .. :try_end_0} :catchall_0

    monitor-exit p0

    return v0

    .line 343
    :catchall_0
    move-exception v0

    monitor-exit p0

    throw v0
.end method

.method declared-synchronized stat()Lcom/sun/mail/pop3/Status;
    .locals 3
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljava/io/IOException;
        }
    .end annotation

    .prologue
    .line 231
    monitor-enter p0

    :try_start_0
    const-string v0, "STAT"

    invoke-direct {p0, v0}, Lcom/sun/mail/pop3/Protocol;->simpleCommand(Ljava/lang/String;)Lcom/sun/mail/pop3/Response;

    move-result-object v0

    .line 232
    new-instance v1, Lcom/sun/mail/pop3/Status;

    invoke-direct {v1}, Lcom/sun/mail/pop3/Status;-><init>()V

    .line 233
    iget-boolean v2, v0, Lcom/sun/mail/pop3/Response;->ok:Z

    if-eqz v2, :cond_0

    iget-object v2, v0, Lcom/sun/mail/pop3/Response;->data:Ljava/lang/String;
    :try_end_0
    .catchall {:try_start_0 .. :try_end_0} :catchall_0

    if-eqz v2, :cond_0

    .line 235
    :try_start_1
    new-instance v2, Ljava/util/StringTokenizer;

    iget-object v0, v0, Lcom/sun/mail/pop3/Response;->data:Ljava/lang/String;

    invoke-direct {v2, v0}, Ljava/util/StringTokenizer;-><init>(Ljava/lang/String;)V

    .line 236
    invoke-virtual {v2}, Ljava/util/StringTokenizer;->nextToken()Ljava/lang/String;

    move-result-object v0

    invoke-static {v0}, Ljava/lang/Integer;->parseInt(Ljava/lang/String;)I

    move-result v0

    iput v0, v1, Lcom/sun/mail/pop3/Status;->total:I

    .line 237
    invoke-virtual {v2}, Ljava/util/StringTokenizer;->nextToken()Ljava/lang/String;

    move-result-object v0

    invoke-static {v0}, Ljava/lang/Integer;->parseInt(Ljava/lang/String;)I

    move-result v0

    iput v0, v1, Lcom/sun/mail/pop3/Status;->size:I
    :try_end_1
    .catch Ljava/lang/Exception; {:try_start_1 .. :try_end_1} :catch_0
    .catchall {:try_start_1 .. :try_end_1} :catchall_0

    .line 241
    :cond_0
    :goto_0
    monitor-exit p0

    return-object v1

    .line 231
    :catchall_0
    move-exception v0

    monitor-exit p0

    throw v0

    .line 238
    :catch_0
    move-exception v0

    goto :goto_0
.end method

.method declared-synchronized top(II)Ljava/io/InputStream;
    .locals 2
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljava/io/IOException;
        }
    .end annotation

    .prologue
    .line 284
    monitor-enter p0

    :try_start_0
    new-instance v0, Ljava/lang/StringBuilder;

    const-string v1, "TOP "

    invoke-direct {v0, v1}, Ljava/lang/StringBuilder;-><init>(Ljava/lang/String;)V

    invoke-virtual {v0, p1}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v0

    const-string v1, " "

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-virtual {v0, p2}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-virtual {v0}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v0

    const/4 v1, 0x0

    invoke-direct {p0, v0, v1}, Lcom/sun/mail/pop3/Protocol;->multilineCommand(Ljava/lang/String;I)Lcom/sun/mail/pop3/Response;

    move-result-object v0

    .line 285
    iget-object v0, v0, Lcom/sun/mail/pop3/Response;->bytes:Ljava/io/InputStream;
    :try_end_0
    .catchall {:try_start_0 .. :try_end_0} :catchall_0

    monitor-exit p0

    return-object v0

    .line 284
    :catchall_0
    move-exception v0

    monitor-exit p0

    throw v0
.end method

.method declared-synchronized uidl(I)Ljava/lang/String;
    .locals 4
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljava/io/IOException;
        }
    .end annotation

    .prologue
    const/4 v0, 0x0

    .line 300
    monitor-enter p0

    :try_start_0
    new-instance v1, Ljava/lang/StringBuilder;

    const-string v2, "UIDL "

    invoke-direct {v1, v2}, Ljava/lang/StringBuilder;-><init>(Ljava/lang/String;)V

    invoke-virtual {v1, p1}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v1

    invoke-direct {p0, v1}, Lcom/sun/mail/pop3/Protocol;->simpleCommand(Ljava/lang/String;)Lcom/sun/mail/pop3/Response;

    move-result-object v1

    .line 301
    iget-boolean v2, v1, Lcom/sun/mail/pop3/Response;->ok:Z
    :try_end_0
    .catchall {:try_start_0 .. :try_end_0} :catchall_0

    if-nez v2, :cond_1

    .line 307
    :cond_0
    :goto_0
    monitor-exit p0

    return-object v0

    .line 303
    :cond_1
    :try_start_1
    iget-object v2, v1, Lcom/sun/mail/pop3/Response;->data:Ljava/lang/String;

    const/16 v3, 0x20

    invoke-virtual {v2, v3}, Ljava/lang/String;->indexOf(I)I

    move-result v2

    .line 304
    if-lez v2, :cond_0

    .line 305
    iget-object v0, v1, Lcom/sun/mail/pop3/Response;->data:Ljava/lang/String;

    add-int/lit8 v1, v2, 0x1

    invoke-virtual {v0, v1}, Ljava/lang/String;->substring(I)Ljava/lang/String;
    :try_end_1
    .catchall {:try_start_1 .. :try_end_1} :catchall_0

    move-result-object v0

    goto :goto_0

    .line 300
    :catchall_0
    move-exception v0

    monitor-exit p0

    throw v0
.end method

.method declared-synchronized uidl([Ljava/lang/String;)Z
    .locals 6
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljava/io/IOException;
        }
    .end annotation

    .prologue
    const/4 v1, 0x1

    const/4 v0, 0x0

    .line 315
    monitor-enter p0

    :try_start_0
    const-string v2, "UIDL"

    array-length v3, p1

    mul-int/lit8 v3, v3, 0xf

    invoke-direct {p0, v2, v3}, Lcom/sun/mail/pop3/Protocol;->multilineCommand(Ljava/lang/String;I)Lcom/sun/mail/pop3/Response;

    move-result-object v2

    .line 316
    iget-boolean v3, v2, Lcom/sun/mail/pop3/Response;->ok:Z
    :try_end_0
    .catchall {:try_start_0 .. :try_end_0} :catchall_0

    if-nez v3, :cond_0

    .line 328
    :goto_0
    monitor-exit p0

    return v0

    .line 318
    :cond_0
    :try_start_1
    new-instance v0, Lcom/sun/mail/util/LineInputStream;

    iget-object v2, v2, Lcom/sun/mail/pop3/Response;->bytes:Ljava/io/InputStream;

    invoke-direct {v0, v2}, Lcom/sun/mail/util/LineInputStream;-><init>(Ljava/io/InputStream;)V

    .line 320
    :cond_1
    :goto_1
    invoke-virtual {v0}, Lcom/sun/mail/util/LineInputStream;->readLine()Ljava/lang/String;

    move-result-object v2

    if-nez v2, :cond_2

    move v0, v1

    .line 328
    goto :goto_0

    .line 321
    :cond_2
    const/16 v3, 0x20

    invoke-virtual {v2, v3}, Ljava/lang/String;->indexOf(I)I

    move-result v3

    .line 322
    if-lt v3, v1, :cond_1

    invoke-virtual {v2}, Ljava/lang/String;->length()I

    move-result v4

    if-ge v3, v4, :cond_1

    .line 324
    const/4 v4, 0x0

    invoke-virtual {v2, v4, v3}, Ljava/lang/String;->substring(II)Ljava/lang/String;

    move-result-object v4

    invoke-static {v4}, Ljava/lang/Integer;->parseInt(Ljava/lang/String;)I

    move-result v4

    .line 325
    if-lez v4, :cond_1

    array-length v5, p1

    if-gt v4, v5, :cond_1

    .line 326
    add-int/lit8 v4, v4, -0x1

    add-int/lit8 v3, v3, 0x1

    invoke-virtual {v2, v3}, Ljava/lang/String;->substring(I)Ljava/lang/String;

    move-result-object v2

    aput-object v2, p1, v4
    :try_end_1
    .catchall {:try_start_1 .. :try_end_1} :catchall_0

    goto :goto_1

    .line 315
    :catchall_0
    move-exception v0

    monitor-exit p0

    throw v0
.end method
