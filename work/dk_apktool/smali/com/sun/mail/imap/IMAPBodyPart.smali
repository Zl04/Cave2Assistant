.class public Lcom/sun/mail/imap/IMAPBodyPart;
.super Ljavax/mail/internet/MimeBodyPart;
.source "SourceFile"


# instance fields
.field private bs:Lcom/sun/mail/imap/protocol/BODYSTRUCTURE;

.field private description:Ljava/lang/String;

.field private headersLoaded:Z

.field private message:Lcom/sun/mail/imap/IMAPMessage;

.field private sectionId:Ljava/lang/String;

.field private type:Ljava/lang/String;


# direct methods
.method protected constructor <init>(Lcom/sun/mail/imap/protocol/BODYSTRUCTURE;Ljava/lang/String;Lcom/sun/mail/imap/IMAPMessage;)V
    .locals 4

    .prologue
    .line 73
    invoke-direct {p0}, Ljavax/mail/internet/MimeBodyPart;-><init>()V

    .line 70
    const/4 v0, 0x0

    iput-boolean v0, p0, Lcom/sun/mail/imap/IMAPBodyPart;->headersLoaded:Z

    .line 74
    iput-object p1, p0, Lcom/sun/mail/imap/IMAPBodyPart;->bs:Lcom/sun/mail/imap/protocol/BODYSTRUCTURE;

    .line 75
    iput-object p2, p0, Lcom/sun/mail/imap/IMAPBodyPart;->sectionId:Ljava/lang/String;

    .line 76
    iput-object p3, p0, Lcom/sun/mail/imap/IMAPBodyPart;->message:Lcom/sun/mail/imap/IMAPMessage;

    .line 78
    new-instance v0, Ljavax/mail/internet/ContentType;

    iget-object v1, p1, Lcom/sun/mail/imap/protocol/BODYSTRUCTURE;->type:Ljava/lang/String;

    iget-object v2, p1, Lcom/sun/mail/imap/protocol/BODYSTRUCTURE;->subtype:Ljava/lang/String;

    iget-object v3, p1, Lcom/sun/mail/imap/protocol/BODYSTRUCTURE;->cParams:Ljavax/mail/internet/ParameterList;

    invoke-direct {v0, v1, v2, v3}, Ljavax/mail/internet/ContentType;-><init>(Ljava/lang/String;Ljava/lang/String;Ljavax/mail/internet/ParameterList;)V

    .line 79
    invoke-virtual {v0}, Ljavax/mail/internet/ContentType;->toString()Ljava/lang/String;

    move-result-object v0

    iput-object v0, p0, Lcom/sun/mail/imap/IMAPBodyPart;->type:Ljava/lang/String;

    .line 80
    return-void
.end method

.method private declared-synchronized loadHeaders()V
    .locals 5
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljavax/mail/MessagingException;
        }
    .end annotation

    .prologue
    .line 291
    monitor-enter p0

    :try_start_0
    iget-boolean v0, p0, Lcom/sun/mail/imap/IMAPBodyPart;->headersLoaded:Z
    :try_end_0
    .catchall {:try_start_0 .. :try_end_0} :catchall_1

    if-eqz v0, :cond_0

    .line 349
    :goto_0
    monitor-exit p0

    return-void

    .line 294
    :cond_0
    :try_start_1
    iget-object v0, p0, Lcom/sun/mail/imap/IMAPBodyPart;->headers:Ljavax/mail/internet/InternetHeaders;

    if-nez v0, :cond_1

    .line 295
    new-instance v0, Ljavax/mail/internet/InternetHeaders;

    invoke-direct {v0}, Ljavax/mail/internet/InternetHeaders;-><init>()V

    iput-object v0, p0, Lcom/sun/mail/imap/IMAPBodyPart;->headers:Ljavax/mail/internet/InternetHeaders;

    .line 300
    :cond_1
    iget-object v0, p0, Lcom/sun/mail/imap/IMAPBodyPart;->message:Lcom/sun/mail/imap/IMAPMessage;

    invoke-virtual {v0}, Lcom/sun/mail/imap/IMAPMessage;->getMessageCacheLock()Ljava/lang/Object;

    move-result-object v1

    monitor-enter v1
    :try_end_1
    .catchall {:try_start_1 .. :try_end_1} :catchall_1

    .line 302
    :try_start_2
    iget-object v0, p0, Lcom/sun/mail/imap/IMAPBodyPart;->message:Lcom/sun/mail/imap/IMAPMessage;

    invoke-virtual {v0}, Lcom/sun/mail/imap/IMAPMessage;->getProtocol()Lcom/sun/mail/imap/protocol/IMAPProtocol;

    move-result-object v0

    .line 305
    iget-object v2, p0, Lcom/sun/mail/imap/IMAPBodyPart;->message:Lcom/sun/mail/imap/IMAPMessage;

    invoke-virtual {v2}, Lcom/sun/mail/imap/IMAPMessage;->checkExpunged()V

    .line 307
    invoke-virtual {v0}, Lcom/sun/mail/imap/protocol/IMAPProtocol;->isREV1()Z

    move-result v2

    if-eqz v2, :cond_5

    .line 308
    iget-object v2, p0, Lcom/sun/mail/imap/IMAPBodyPart;->message:Lcom/sun/mail/imap/IMAPMessage;

    invoke-virtual {v2}, Lcom/sun/mail/imap/IMAPMessage;->getSequenceNumber()I

    move-result v2

    .line 309
    new-instance v3, Ljava/lang/StringBuilder;

    iget-object v4, p0, Lcom/sun/mail/imap/IMAPBodyPart;->sectionId:Ljava/lang/String;

    invoke-static {v4}, Ljava/lang/String;->valueOf(Ljava/lang/Object;)Ljava/lang/String;

    move-result-object v4

    invoke-direct {v3, v4}, Ljava/lang/StringBuilder;-><init>(Ljava/lang/String;)V

    const-string v4, ".MIME"

    invoke-virtual {v3, v4}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v3

    invoke-virtual {v3}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v3

    invoke-virtual {v0, v2, v3}, Lcom/sun/mail/imap/protocol/IMAPProtocol;->peekBody(ILjava/lang/String;)Lcom/sun/mail/imap/protocol/BODY;

    move-result-object v0

    .line 311
    if-nez v0, :cond_2

    .line 312
    new-instance v0, Ljavax/mail/MessagingException;

    const-string v2, "Failed to fetch headers"

    invoke-direct {v0, v2}, Ljavax/mail/MessagingException;-><init>(Ljava/lang/String;)V

    throw v0
    :try_end_2
    .catch Lcom/sun/mail/iap/ConnectionException; {:try_start_2 .. :try_end_2} :catch_0
    .catch Lcom/sun/mail/iap/ProtocolException; {:try_start_2 .. :try_end_2} :catch_1
    .catchall {:try_start_2 .. :try_end_2} :catchall_0

    .line 341
    :catch_0
    move-exception v0

    .line 342
    :try_start_3
    new-instance v2, Ljavax/mail/FolderClosedException;

    .line 343
    iget-object v3, p0, Lcom/sun/mail/imap/IMAPBodyPart;->message:Lcom/sun/mail/imap/IMAPMessage;

    invoke-virtual {v3}, Lcom/sun/mail/imap/IMAPMessage;->getFolder()Ljavax/mail/Folder;

    move-result-object v3

    invoke-virtual {v0}, Lcom/sun/mail/iap/ConnectionException;->getMessage()Ljava/lang/String;

    move-result-object v0

    .line 342
    invoke-direct {v2, v3, v0}, Ljavax/mail/FolderClosedException;-><init>(Ljavax/mail/Folder;Ljava/lang/String;)V

    throw v2

    .line 300
    :catchall_0
    move-exception v0

    monitor-exit v1
    :try_end_3
    .catchall {:try_start_3 .. :try_end_3} :catchall_0

    :try_start_4
    throw v0
    :try_end_4
    .catchall {:try_start_4 .. :try_end_4} :catchall_1

    .line 291
    :catchall_1
    move-exception v0

    monitor-exit p0

    throw v0

    .line 314
    :cond_2
    :try_start_5
    invoke-virtual {v0}, Lcom/sun/mail/imap/protocol/BODY;->getByteArrayInputStream()Ljava/io/ByteArrayInputStream;

    move-result-object v0

    .line 315
    if-nez v0, :cond_3

    .line 316
    new-instance v0, Ljavax/mail/MessagingException;

    const-string v2, "Failed to fetch headers"

    invoke-direct {v0, v2}, Ljavax/mail/MessagingException;-><init>(Ljava/lang/String;)V

    throw v0
    :try_end_5
    .catch Lcom/sun/mail/iap/ConnectionException; {:try_start_5 .. :try_end_5} :catch_0
    .catch Lcom/sun/mail/iap/ProtocolException; {:try_start_5 .. :try_end_5} :catch_1
    .catchall {:try_start_5 .. :try_end_5} :catchall_0

    .line 344
    :catch_1
    move-exception v0

    .line 345
    :try_start_6
    new-instance v2, Ljavax/mail/MessagingException;

    invoke-virtual {v0}, Lcom/sun/mail/iap/ProtocolException;->getMessage()Ljava/lang/String;

    move-result-object v3

    invoke-direct {v2, v3, v0}, Ljavax/mail/MessagingException;-><init>(Ljava/lang/String;Ljava/lang/Exception;)V

    throw v2
    :try_end_6
    .catchall {:try_start_6 .. :try_end_6} :catchall_0

    .line 318
    :cond_3
    :try_start_7
    iget-object v2, p0, Lcom/sun/mail/imap/IMAPBodyPart;->headers:Ljavax/mail/internet/InternetHeaders;

    invoke-virtual {v2, v0}, Ljavax/mail/internet/InternetHeaders;->load(Ljava/io/InputStream;)V
    :try_end_7
    .catch Lcom/sun/mail/iap/ConnectionException; {:try_start_7 .. :try_end_7} :catch_0
    .catch Lcom/sun/mail/iap/ProtocolException; {:try_start_7 .. :try_end_7} :catch_1
    .catchall {:try_start_7 .. :try_end_7} :catchall_0

    .line 300
    :cond_4
    :goto_1
    :try_start_8
    monitor-exit v1
    :try_end_8
    .catchall {:try_start_8 .. :try_end_8} :catchall_0

    .line 348
    const/4 v0, 0x1

    :try_start_9
    iput-boolean v0, p0, Lcom/sun/mail/imap/IMAPBodyPart;->headersLoaded:Z
    :try_end_9
    .catchall {:try_start_9 .. :try_end_9} :catchall_1

    goto/16 :goto_0

    .line 327
    :cond_5
    :try_start_a
    iget-object v0, p0, Lcom/sun/mail/imap/IMAPBodyPart;->headers:Ljavax/mail/internet/InternetHeaders;

    const-string v2, "Content-Type"

    iget-object v3, p0, Lcom/sun/mail/imap/IMAPBodyPart;->type:Ljava/lang/String;

    invoke-virtual {v0, v2, v3}, Ljavax/mail/internet/InternetHeaders;->addHeader(Ljava/lang/String;Ljava/lang/String;)V

    .line 329
    iget-object v0, p0, Lcom/sun/mail/imap/IMAPBodyPart;->headers:Ljavax/mail/internet/InternetHeaders;

    const-string v2, "Content-Transfer-Encoding"

    iget-object v3, p0, Lcom/sun/mail/imap/IMAPBodyPart;->bs:Lcom/sun/mail/imap/protocol/BODYSTRUCTURE;

    iget-object v3, v3, Lcom/sun/mail/imap/protocol/BODYSTRUCTURE;->encoding:Ljava/lang/String;

    invoke-virtual {v0, v2, v3}, Ljavax/mail/internet/InternetHeaders;->addHeader(Ljava/lang/String;Ljava/lang/String;)V

    .line 331
    iget-object v0, p0, Lcom/sun/mail/imap/IMAPBodyPart;->bs:Lcom/sun/mail/imap/protocol/BODYSTRUCTURE;

    iget-object v0, v0, Lcom/sun/mail/imap/protocol/BODYSTRUCTURE;->description:Ljava/lang/String;

    if-eqz v0, :cond_6

    .line 332
    iget-object v0, p0, Lcom/sun/mail/imap/IMAPBodyPart;->headers:Ljavax/mail/internet/InternetHeaders;

    const-string v2, "Content-Description"

    .line 333
    iget-object v3, p0, Lcom/sun/mail/imap/IMAPBodyPart;->bs:Lcom/sun/mail/imap/protocol/BODYSTRUCTURE;

    iget-object v3, v3, Lcom/sun/mail/imap/protocol/BODYSTRUCTURE;->description:Ljava/lang/String;

    .line 332
    invoke-virtual {v0, v2, v3}, Ljavax/mail/internet/InternetHeaders;->addHeader(Ljava/lang/String;Ljava/lang/String;)V

    .line 335
    :cond_6
    iget-object v0, p0, Lcom/sun/mail/imap/IMAPBodyPart;->bs:Lcom/sun/mail/imap/protocol/BODYSTRUCTURE;

    iget-object v0, v0, Lcom/sun/mail/imap/protocol/BODYSTRUCTURE;->id:Ljava/lang/String;

    if-eqz v0, :cond_7

    .line 336
    iget-object v0, p0, Lcom/sun/mail/imap/IMAPBodyPart;->headers:Ljavax/mail/internet/InternetHeaders;

    const-string v2, "Content-ID"

    iget-object v3, p0, Lcom/sun/mail/imap/IMAPBodyPart;->bs:Lcom/sun/mail/imap/protocol/BODYSTRUCTURE;

    iget-object v3, v3, Lcom/sun/mail/imap/protocol/BODYSTRUCTURE;->id:Ljava/lang/String;

    invoke-virtual {v0, v2, v3}, Ljavax/mail/internet/InternetHeaders;->addHeader(Ljava/lang/String;Ljava/lang/String;)V

    .line 338
    :cond_7
    iget-object v0, p0, Lcom/sun/mail/imap/IMAPBodyPart;->bs:Lcom/sun/mail/imap/protocol/BODYSTRUCTURE;

    iget-object v0, v0, Lcom/sun/mail/imap/protocol/BODYSTRUCTURE;->md5:Ljava/lang/String;

    if-eqz v0, :cond_4

    .line 339
    iget-object v0, p0, Lcom/sun/mail/imap/IMAPBodyPart;->headers:Ljavax/mail/internet/InternetHeaders;

    const-string v2, "Content-MD5"

    iget-object v3, p0, Lcom/sun/mail/imap/IMAPBodyPart;->bs:Lcom/sun/mail/imap/protocol/BODYSTRUCTURE;

    iget-object v3, v3, Lcom/sun/mail/imap/protocol/BODYSTRUCTURE;->md5:Ljava/lang/String;

    invoke-virtual {v0, v2, v3}, Ljavax/mail/internet/InternetHeaders;->addHeader(Ljava/lang/String;Ljava/lang/String;)V
    :try_end_a
    .catch Lcom/sun/mail/iap/ConnectionException; {:try_start_a .. :try_end_a} :catch_0
    .catch Lcom/sun/mail/iap/ProtocolException; {:try_start_a .. :try_end_a} :catch_1
    .catchall {:try_start_a .. :try_end_a} :catchall_0

    goto :goto_1
.end method


# virtual methods
.method public addHeader(Ljava/lang/String;Ljava/lang/String;)V
    .locals 2
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljavax/mail/MessagingException;
        }
    .end annotation

    .prologue
    .line 245
    new-instance v0, Ljavax/mail/IllegalWriteException;

    const-string v1, "IMAPBodyPart is read-only"

    invoke-direct {v0, v1}, Ljavax/mail/IllegalWriteException;-><init>(Ljava/lang/String;)V

    throw v0
.end method

.method public addHeaderLine(Ljava/lang/String;)V
    .locals 2
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljavax/mail/MessagingException;
        }
    .end annotation

    .prologue
    .line 270
    new-instance v0, Ljavax/mail/IllegalWriteException;

    const-string v1, "IMAPBodyPart is read-only"

    invoke-direct {v0, v1}, Ljavax/mail/IllegalWriteException;-><init>(Ljava/lang/String;)V

    throw v0
.end method

.method public getAllHeaderLines()Ljava/util/Enumeration;
    .locals 1
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljavax/mail/MessagingException;
        }
    .end annotation

    .prologue
    .line 274
    invoke-direct {p0}, Lcom/sun/mail/imap/IMAPBodyPart;->loadHeaders()V

    .line 275
    invoke-super {p0}, Ljavax/mail/internet/MimeBodyPart;->getAllHeaderLines()Ljava/util/Enumeration;

    move-result-object v0

    return-object v0
.end method

.method public getAllHeaders()Ljava/util/Enumeration;
    .locals 1
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljavax/mail/MessagingException;
        }
    .end annotation

    .prologue
    .line 253
    invoke-direct {p0}, Lcom/sun/mail/imap/IMAPBodyPart;->loadHeaders()V

    .line 254
    invoke-super {p0}, Ljavax/mail/internet/MimeBodyPart;->getAllHeaders()Ljava/util/Enumeration;

    move-result-object v0

    return-object v0
.end method

.method public getContentID()Ljava/lang/String;
    .locals 1
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljavax/mail/MessagingException;
        }
    .end annotation

    .prologue
    .line 116
    iget-object v0, p0, Lcom/sun/mail/imap/IMAPBodyPart;->bs:Lcom/sun/mail/imap/protocol/BODYSTRUCTURE;

    iget-object v0, v0, Lcom/sun/mail/imap/protocol/BODYSTRUCTURE;->id:Ljava/lang/String;

    return-object v0
.end method

.method public getContentMD5()Ljava/lang/String;
    .locals 1
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljavax/mail/MessagingException;
        }
    .end annotation

    .prologue
    .line 120
    iget-object v0, p0, Lcom/sun/mail/imap/IMAPBodyPart;->bs:Lcom/sun/mail/imap/protocol/BODYSTRUCTURE;

    iget-object v0, v0, Lcom/sun/mail/imap/protocol/BODYSTRUCTURE;->md5:Ljava/lang/String;

    return-object v0
.end method

.method protected getContentStream()Ljava/io/InputStream;
    .locals 6
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljavax/mail/MessagingException;
        }
    .end annotation

    .prologue
    .line 162
    const/4 v0, 0x0

    .line 163
    iget-object v1, p0, Lcom/sun/mail/imap/IMAPBodyPart;->message:Lcom/sun/mail/imap/IMAPMessage;

    invoke-virtual {v1}, Lcom/sun/mail/imap/IMAPMessage;->getPeek()Z

    move-result v1

    .line 166
    iget-object v2, p0, Lcom/sun/mail/imap/IMAPBodyPart;->message:Lcom/sun/mail/imap/IMAPMessage;

    invoke-virtual {v2}, Lcom/sun/mail/imap/IMAPMessage;->getMessageCacheLock()Ljava/lang/Object;

    move-result-object v2

    monitor-enter v2

    .line 168
    :try_start_0
    iget-object v3, p0, Lcom/sun/mail/imap/IMAPBodyPart;->message:Lcom/sun/mail/imap/IMAPMessage;

    invoke-virtual {v3}, Lcom/sun/mail/imap/IMAPMessage;->getProtocol()Lcom/sun/mail/imap/protocol/IMAPProtocol;

    move-result-object v3

    .line 171
    iget-object v4, p0, Lcom/sun/mail/imap/IMAPBodyPart;->message:Lcom/sun/mail/imap/IMAPMessage;

    invoke-virtual {v4}, Lcom/sun/mail/imap/IMAPMessage;->checkExpunged()V

    .line 173
    invoke-virtual {v3}, Lcom/sun/mail/imap/protocol/IMAPProtocol;->isREV1()Z

    move-result v4

    if-eqz v4, :cond_1

    iget-object v4, p0, Lcom/sun/mail/imap/IMAPBodyPart;->message:Lcom/sun/mail/imap/IMAPMessage;

    invoke-virtual {v4}, Lcom/sun/mail/imap/IMAPMessage;->getFetchBlockSize()I

    move-result v4

    const/4 v5, -0x1

    if-eq v4, v5, :cond_1

    .line 174
    new-instance v0, Lcom/sun/mail/imap/IMAPInputStream;

    iget-object v3, p0, Lcom/sun/mail/imap/IMAPBodyPart;->message:Lcom/sun/mail/imap/IMAPMessage;

    iget-object v4, p0, Lcom/sun/mail/imap/IMAPBodyPart;->sectionId:Ljava/lang/String;

    iget-object v5, p0, Lcom/sun/mail/imap/IMAPBodyPart;->bs:Lcom/sun/mail/imap/protocol/BODYSTRUCTURE;

    iget v5, v5, Lcom/sun/mail/imap/protocol/BODYSTRUCTURE;->size:I

    invoke-direct {v0, v3, v4, v5, v1}, Lcom/sun/mail/imap/IMAPInputStream;-><init>(Lcom/sun/mail/imap/IMAPMessage;Ljava/lang/String;IZ)V
    :try_end_0
    .catch Lcom/sun/mail/iap/ConnectionException; {:try_start_0 .. :try_end_0} :catch_0
    .catch Lcom/sun/mail/iap/ProtocolException; {:try_start_0 .. :try_end_0} :catch_1
    .catchall {:try_start_0 .. :try_end_0} :catchall_0

    :try_start_1
    monitor-exit v2
    :try_end_1
    .catchall {:try_start_1 .. :try_end_1} :catchall_0

    .line 197
    :cond_0
    return-object v0

    .line 178
    :cond_1
    :try_start_2
    iget-object v4, p0, Lcom/sun/mail/imap/IMAPBodyPart;->message:Lcom/sun/mail/imap/IMAPMessage;

    invoke-virtual {v4}, Lcom/sun/mail/imap/IMAPMessage;->getSequenceNumber()I

    move-result v4

    .line 180
    if-eqz v1, :cond_3

    .line 181
    iget-object v1, p0, Lcom/sun/mail/imap/IMAPBodyPart;->sectionId:Ljava/lang/String;

    invoke-virtual {v3, v4, v1}, Lcom/sun/mail/imap/protocol/IMAPProtocol;->peekBody(ILjava/lang/String;)Lcom/sun/mail/imap/protocol/BODY;

    move-result-object v1

    .line 184
    :goto_0
    if-eqz v1, :cond_2

    .line 185
    invoke-virtual {v1}, Lcom/sun/mail/imap/protocol/BODY;->getByteArrayInputStream()Ljava/io/ByteArrayInputStream;
    :try_end_2
    .catch Lcom/sun/mail/iap/ConnectionException; {:try_start_2 .. :try_end_2} :catch_0
    .catch Lcom/sun/mail/iap/ProtocolException; {:try_start_2 .. :try_end_2} :catch_1
    .catchall {:try_start_2 .. :try_end_2} :catchall_0

    move-result-object v0

    .line 166
    :cond_2
    :try_start_3
    monitor-exit v2
    :try_end_3
    .catchall {:try_start_3 .. :try_end_3} :catchall_0

    .line 194
    if-nez v0, :cond_0

    .line 195
    new-instance v0, Ljavax/mail/MessagingException;

    const-string v1, "No content"

    invoke-direct {v0, v1}, Ljavax/mail/MessagingException;-><init>(Ljava/lang/String;)V

    throw v0

    .line 183
    :cond_3
    :try_start_4
    iget-object v1, p0, Lcom/sun/mail/imap/IMAPBodyPart;->sectionId:Ljava/lang/String;

    invoke-virtual {v3, v4, v1}, Lcom/sun/mail/imap/protocol/IMAPProtocol;->fetchBody(ILjava/lang/String;)Lcom/sun/mail/imap/protocol/BODY;
    :try_end_4
    .catch Lcom/sun/mail/iap/ConnectionException; {:try_start_4 .. :try_end_4} :catch_0
    .catch Lcom/sun/mail/iap/ProtocolException; {:try_start_4 .. :try_end_4} :catch_1
    .catchall {:try_start_4 .. :try_end_4} :catchall_0

    move-result-object v1

    goto :goto_0

    .line 186
    :catch_0
    move-exception v0

    .line 187
    :try_start_5
    new-instance v1, Ljavax/mail/FolderClosedException;

    .line 188
    iget-object v3, p0, Lcom/sun/mail/imap/IMAPBodyPart;->message:Lcom/sun/mail/imap/IMAPMessage;

    invoke-virtual {v3}, Lcom/sun/mail/imap/IMAPMessage;->getFolder()Ljavax/mail/Folder;

    move-result-object v3

    invoke-virtual {v0}, Lcom/sun/mail/iap/ConnectionException;->getMessage()Ljava/lang/String;

    move-result-object v0

    .line 187
    invoke-direct {v1, v3, v0}, Ljavax/mail/FolderClosedException;-><init>(Ljavax/mail/Folder;Ljava/lang/String;)V

    throw v1

    .line 166
    :catchall_0
    move-exception v0

    monitor-exit v2
    :try_end_5
    .catchall {:try_start_5 .. :try_end_5} :catchall_0

    throw v0

    .line 189
    :catch_1
    move-exception v0

    .line 190
    :try_start_6
    new-instance v1, Ljavax/mail/MessagingException;

    invoke-virtual {v0}, Lcom/sun/mail/iap/ProtocolException;->getMessage()Ljava/lang/String;

    move-result-object v3

    invoke-direct {v1, v3, v0}, Ljavax/mail/MessagingException;-><init>(Ljava/lang/String;Ljava/lang/Exception;)V

    throw v1
    :try_end_6
    .catchall {:try_start_6 .. :try_end_6} :catchall_0
.end method

.method public getContentType()Ljava/lang/String;
    .locals 1
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljavax/mail/MessagingException;
        }
    .end annotation

    .prologue
    .line 100
    iget-object v0, p0, Lcom/sun/mail/imap/IMAPBodyPart;->type:Ljava/lang/String;

    return-object v0
.end method

.method public declared-synchronized getDataHandler()Ljavax/activation/DataHandler;
    .locals 6
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljavax/mail/MessagingException;
        }
    .end annotation

    .prologue
    .line 202
    monitor-enter p0

    :try_start_0
    iget-object v0, p0, Lcom/sun/mail/imap/IMAPBodyPart;->dh:Ljavax/activation/DataHandler;

    if-nez v0, :cond_0

    .line 203
    iget-object v0, p0, Lcom/sun/mail/imap/IMAPBodyPart;->bs:Lcom/sun/mail/imap/protocol/BODYSTRUCTURE;

    invoke-virtual {v0}, Lcom/sun/mail/imap/protocol/BODYSTRUCTURE;->isMulti()Z

    move-result v0

    if-eqz v0, :cond_1

    .line 204
    new-instance v0, Ljavax/activation/DataHandler;

    .line 205
    new-instance v1, Lcom/sun/mail/imap/IMAPMultipartDataSource;

    .line 206
    iget-object v2, p0, Lcom/sun/mail/imap/IMAPBodyPart;->bs:Lcom/sun/mail/imap/protocol/BODYSTRUCTURE;

    iget-object v2, v2, Lcom/sun/mail/imap/protocol/BODYSTRUCTURE;->bodies:[Lcom/sun/mail/imap/protocol/BODYSTRUCTURE;

    iget-object v3, p0, Lcom/sun/mail/imap/IMAPBodyPart;->sectionId:Ljava/lang/String;

    iget-object v4, p0, Lcom/sun/mail/imap/IMAPBodyPart;->message:Lcom/sun/mail/imap/IMAPMessage;

    .line 205
    invoke-direct {v1, p0, v2, v3, v4}, Lcom/sun/mail/imap/IMAPMultipartDataSource;-><init>(Ljavax/mail/internet/MimePart;[Lcom/sun/mail/imap/protocol/BODYSTRUCTURE;Ljava/lang/String;Lcom/sun/mail/imap/IMAPMessage;)V

    invoke-direct {v0, v1}, Ljavax/activation/DataHandler;-><init>(Ljavax/activation/DataSource;)V

    .line 204
    iput-object v0, p0, Lcom/sun/mail/imap/IMAPBodyPart;->dh:Ljavax/activation/DataHandler;

    .line 218
    :cond_0
    :goto_0
    invoke-super {p0}, Ljavax/mail/internet/MimeBodyPart;->getDataHandler()Ljavax/activation/DataHandler;
    :try_end_0
    .catchall {:try_start_0 .. :try_end_0} :catchall_0

    move-result-object v0

    monitor-exit p0

    return-object v0

    .line 208
    :cond_1
    :try_start_1
    iget-object v0, p0, Lcom/sun/mail/imap/IMAPBodyPart;->bs:Lcom/sun/mail/imap/protocol/BODYSTRUCTURE;

    invoke-virtual {v0}, Lcom/sun/mail/imap/protocol/BODYSTRUCTURE;->isNested()Z

    move-result v0

    if-eqz v0, :cond_0

    iget-object v0, p0, Lcom/sun/mail/imap/IMAPBodyPart;->message:Lcom/sun/mail/imap/IMAPMessage;

    invoke-virtual {v0}, Lcom/sun/mail/imap/IMAPMessage;->isREV1()Z

    move-result v0

    if-eqz v0, :cond_0

    .line 209
    new-instance v0, Ljavax/activation/DataHandler;

    .line 210
    new-instance v1, Lcom/sun/mail/imap/IMAPNestedMessage;

    iget-object v2, p0, Lcom/sun/mail/imap/IMAPBodyPart;->message:Lcom/sun/mail/imap/IMAPMessage;

    .line 211
    iget-object v3, p0, Lcom/sun/mail/imap/IMAPBodyPart;->bs:Lcom/sun/mail/imap/protocol/BODYSTRUCTURE;

    iget-object v3, v3, Lcom/sun/mail/imap/protocol/BODYSTRUCTURE;->bodies:[Lcom/sun/mail/imap/protocol/BODYSTRUCTURE;

    const/4 v4, 0x0

    aget-object v3, v3, v4

    .line 212
    iget-object v4, p0, Lcom/sun/mail/imap/IMAPBodyPart;->bs:Lcom/sun/mail/imap/protocol/BODYSTRUCTURE;

    iget-object v4, v4, Lcom/sun/mail/imap/protocol/BODYSTRUCTURE;->envelope:Lcom/sun/mail/imap/protocol/ENVELOPE;

    .line 213
    iget-object v5, p0, Lcom/sun/mail/imap/IMAPBodyPart;->sectionId:Ljava/lang/String;

    .line 210
    invoke-direct {v1, v2, v3, v4, v5}, Lcom/sun/mail/imap/IMAPNestedMessage;-><init>(Lcom/sun/mail/imap/IMAPMessage;Lcom/sun/mail/imap/protocol/BODYSTRUCTURE;Lcom/sun/mail/imap/protocol/ENVELOPE;Ljava/lang/String;)V

    .line 214
    iget-object v2, p0, Lcom/sun/mail/imap/IMAPBodyPart;->type:Ljava/lang/String;

    invoke-direct {v0, v1, v2}, Ljavax/activation/DataHandler;-><init>(Ljava/lang/Object;Ljava/lang/String;)V

    .line 209
    iput-object v0, p0, Lcom/sun/mail/imap/IMAPBodyPart;->dh:Ljavax/activation/DataHandler;
    :try_end_1
    .catchall {:try_start_1 .. :try_end_1} :catchall_0

    goto :goto_0

    .line 202
    :catchall_0
    move-exception v0

    monitor-exit p0

    throw v0
.end method

.method public getDescription()Ljava/lang/String;
    .locals 1
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljavax/mail/MessagingException;
        }
    .end annotation

    .prologue
    .line 128
    iget-object v0, p0, Lcom/sun/mail/imap/IMAPBodyPart;->description:Ljava/lang/String;

    if-eqz v0, :cond_0

    .line 129
    iget-object v0, p0, Lcom/sun/mail/imap/IMAPBodyPart;->description:Ljava/lang/String;

    .line 140
    :goto_0
    return-object v0

    .line 131
    :cond_0
    iget-object v0, p0, Lcom/sun/mail/imap/IMAPBodyPart;->bs:Lcom/sun/mail/imap/protocol/BODYSTRUCTURE;

    iget-object v0, v0, Lcom/sun/mail/imap/protocol/BODYSTRUCTURE;->description:Ljava/lang/String;

    if-nez v0, :cond_1

    .line 132
    const/4 v0, 0x0

    goto :goto_0

    .line 135
    :cond_1
    :try_start_0
    iget-object v0, p0, Lcom/sun/mail/imap/IMAPBodyPart;->bs:Lcom/sun/mail/imap/protocol/BODYSTRUCTURE;

    iget-object v0, v0, Lcom/sun/mail/imap/protocol/BODYSTRUCTURE;->description:Ljava/lang/String;

    invoke-static {v0}, Ljavax/mail/internet/MimeUtility;->decodeText(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v0

    iput-object v0, p0, Lcom/sun/mail/imap/IMAPBodyPart;->description:Ljava/lang/String;
    :try_end_0
    .catch Ljava/io/UnsupportedEncodingException; {:try_start_0 .. :try_end_0} :catch_0

    .line 140
    :goto_1
    iget-object v0, p0, Lcom/sun/mail/imap/IMAPBodyPart;->description:Ljava/lang/String;

    goto :goto_0

    .line 136
    :catch_0
    move-exception v0

    .line 137
    iget-object v0, p0, Lcom/sun/mail/imap/IMAPBodyPart;->bs:Lcom/sun/mail/imap/protocol/BODYSTRUCTURE;

    iget-object v0, v0, Lcom/sun/mail/imap/protocol/BODYSTRUCTURE;->description:Ljava/lang/String;

    iput-object v0, p0, Lcom/sun/mail/imap/IMAPBodyPart;->description:Ljava/lang/String;

    goto :goto_1
.end method

.method public getDisposition()Ljava/lang/String;
    .locals 1
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljavax/mail/MessagingException;
        }
    .end annotation

    .prologue
    .line 104
    iget-object v0, p0, Lcom/sun/mail/imap/IMAPBodyPart;->bs:Lcom/sun/mail/imap/protocol/BODYSTRUCTURE;

    iget-object v0, v0, Lcom/sun/mail/imap/protocol/BODYSTRUCTURE;->disposition:Ljava/lang/String;

    return-object v0
.end method

.method public getEncoding()Ljava/lang/String;
    .locals 1
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljavax/mail/MessagingException;
        }
    .end annotation

    .prologue
    .line 112
    iget-object v0, p0, Lcom/sun/mail/imap/IMAPBodyPart;->bs:Lcom/sun/mail/imap/protocol/BODYSTRUCTURE;

    iget-object v0, v0, Lcom/sun/mail/imap/protocol/BODYSTRUCTURE;->encoding:Ljava/lang/String;

    return-object v0
.end method

.method public getFileName()Ljava/lang/String;
    .locals 2
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljavax/mail/MessagingException;
        }
    .end annotation

    .prologue
    .line 149
    const/4 v0, 0x0

    .line 150
    iget-object v1, p0, Lcom/sun/mail/imap/IMAPBodyPart;->bs:Lcom/sun/mail/imap/protocol/BODYSTRUCTURE;

    iget-object v1, v1, Lcom/sun/mail/imap/protocol/BODYSTRUCTURE;->dParams:Ljavax/mail/internet/ParameterList;

    if-eqz v1, :cond_0

    .line 151
    iget-object v0, p0, Lcom/sun/mail/imap/IMAPBodyPart;->bs:Lcom/sun/mail/imap/protocol/BODYSTRUCTURE;

    iget-object v0, v0, Lcom/sun/mail/imap/protocol/BODYSTRUCTURE;->dParams:Ljavax/mail/internet/ParameterList;

    const-string v1, "filename"

    invoke-virtual {v0, v1}, Ljavax/mail/internet/ParameterList;->get(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v0

    .line 152
    :cond_0
    if-nez v0, :cond_1

    iget-object v1, p0, Lcom/sun/mail/imap/IMAPBodyPart;->bs:Lcom/sun/mail/imap/protocol/BODYSTRUCTURE;

    iget-object v1, v1, Lcom/sun/mail/imap/protocol/BODYSTRUCTURE;->cParams:Ljavax/mail/internet/ParameterList;

    if-eqz v1, :cond_1

    .line 153
    iget-object v0, p0, Lcom/sun/mail/imap/IMAPBodyPart;->bs:Lcom/sun/mail/imap/protocol/BODYSTRUCTURE;

    iget-object v0, v0, Lcom/sun/mail/imap/protocol/BODYSTRUCTURE;->cParams:Ljavax/mail/internet/ParameterList;

    const-string v1, "name"

    invoke-virtual {v0, v1}, Ljavax/mail/internet/ParameterList;->get(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v0

    .line 154
    :cond_1
    return-object v0
.end method

.method public getHeader(Ljava/lang/String;)[Ljava/lang/String;
    .locals 1
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljavax/mail/MessagingException;
        }
    .end annotation

    .prologue
    .line 234
    invoke-direct {p0}, Lcom/sun/mail/imap/IMAPBodyPart;->loadHeaders()V

    .line 235
    invoke-super {p0, p1}, Ljavax/mail/internet/MimeBodyPart;->getHeader(Ljava/lang/String;)[Ljava/lang/String;

    move-result-object v0

    return-object v0
.end method

.method public getLineCount()I
    .locals 1
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljavax/mail/MessagingException;
        }
    .end annotation

    .prologue
    .line 96
    iget-object v0, p0, Lcom/sun/mail/imap/IMAPBodyPart;->bs:Lcom/sun/mail/imap/protocol/BODYSTRUCTURE;

    iget v0, v0, Lcom/sun/mail/imap/protocol/BODYSTRUCTURE;->lines:I

    return v0
.end method

.method public getMatchingHeaderLines([Ljava/lang/String;)Ljava/util/Enumeration;
    .locals 1
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljavax/mail/MessagingException;
        }
    .end annotation

    .prologue
    .line 280
    invoke-direct {p0}, Lcom/sun/mail/imap/IMAPBodyPart;->loadHeaders()V

    .line 281
    invoke-super {p0, p1}, Ljavax/mail/internet/MimeBodyPart;->getMatchingHeaderLines([Ljava/lang/String;)Ljava/util/Enumeration;

    move-result-object v0

    return-object v0
.end method

.method public getMatchingHeaders([Ljava/lang/String;)Ljava/util/Enumeration;
    .locals 1
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljavax/mail/MessagingException;
        }
    .end annotation

    .prologue
    .line 259
    invoke-direct {p0}, Lcom/sun/mail/imap/IMAPBodyPart;->loadHeaders()V

    .line 260
    invoke-super {p0, p1}, Ljavax/mail/internet/MimeBodyPart;->getMatchingHeaders([Ljava/lang/String;)Ljava/util/Enumeration;

    move-result-object v0

    return-object v0
.end method

.method public getNonMatchingHeaderLines([Ljava/lang/String;)Ljava/util/Enumeration;
    .locals 1
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljavax/mail/MessagingException;
        }
    .end annotation

    .prologue
    .line 286
    invoke-direct {p0}, Lcom/sun/mail/imap/IMAPBodyPart;->loadHeaders()V

    .line 287
    invoke-super {p0, p1}, Ljavax/mail/internet/MimeBodyPart;->getNonMatchingHeaderLines([Ljava/lang/String;)Ljava/util/Enumeration;

    move-result-object v0

    return-object v0
.end method

.method public getNonMatchingHeaders([Ljava/lang/String;)Ljava/util/Enumeration;
    .locals 1
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljavax/mail/MessagingException;
        }
    .end annotation

    .prologue
    .line 265
    invoke-direct {p0}, Lcom/sun/mail/imap/IMAPBodyPart;->loadHeaders()V

    .line 266
    invoke-super {p0, p1}, Ljavax/mail/internet/MimeBodyPart;->getNonMatchingHeaders([Ljava/lang/String;)Ljava/util/Enumeration;

    move-result-object v0

    return-object v0
.end method

.method public getSize()I
    .locals 1
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljavax/mail/MessagingException;
        }
    .end annotation

    .prologue
    .line 92
    iget-object v0, p0, Lcom/sun/mail/imap/IMAPBodyPart;->bs:Lcom/sun/mail/imap/protocol/BODYSTRUCTURE;

    iget v0, v0, Lcom/sun/mail/imap/protocol/BODYSTRUCTURE;->size:I

    return v0
.end method

.method public removeHeader(Ljava/lang/String;)V
    .locals 2
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljavax/mail/MessagingException;
        }
    .end annotation

    .prologue
    .line 249
    new-instance v0, Ljavax/mail/IllegalWriteException;

    const-string v1, "IMAPBodyPart is read-only"

    invoke-direct {v0, v1}, Ljavax/mail/IllegalWriteException;-><init>(Ljava/lang/String;)V

    throw v0
.end method

.method public setContent(Ljava/lang/Object;Ljava/lang/String;)V
    .locals 2
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljavax/mail/MessagingException;
        }
    .end annotation

    .prologue
    .line 226
    new-instance v0, Ljavax/mail/IllegalWriteException;

    const-string v1, "IMAPBodyPart is read-only"

    invoke-direct {v0, v1}, Ljavax/mail/IllegalWriteException;-><init>(Ljava/lang/String;)V

    throw v0
.end method

.method public setContent(Ljavax/mail/Multipart;)V
    .locals 2
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljavax/mail/MessagingException;
        }
    .end annotation

    .prologue
    .line 230
    new-instance v0, Ljavax/mail/IllegalWriteException;

    const-string v1, "IMAPBodyPart is read-only"

    invoke-direct {v0, v1}, Ljavax/mail/IllegalWriteException;-><init>(Ljava/lang/String;)V

    throw v0
.end method

.method public setContentMD5(Ljava/lang/String;)V
    .locals 2
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljavax/mail/MessagingException;
        }
    .end annotation

    .prologue
    .line 124
    new-instance v0, Ljavax/mail/IllegalWriteException;

    const-string v1, "IMAPBodyPart is read-only"

    invoke-direct {v0, v1}, Ljavax/mail/IllegalWriteException;-><init>(Ljava/lang/String;)V

    throw v0
.end method

.method public setDataHandler(Ljavax/activation/DataHandler;)V
    .locals 2
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljavax/mail/MessagingException;
        }
    .end annotation

    .prologue
    .line 222
    new-instance v0, Ljavax/mail/IllegalWriteException;

    const-string v1, "IMAPBodyPart is read-only"

    invoke-direct {v0, v1}, Ljavax/mail/IllegalWriteException;-><init>(Ljava/lang/String;)V

    throw v0
.end method

.method public setDescription(Ljava/lang/String;Ljava/lang/String;)V
    .locals 2
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljavax/mail/MessagingException;
        }
    .end annotation

    .prologue
    .line 145
    new-instance v0, Ljavax/mail/IllegalWriteException;

    const-string v1, "IMAPBodyPart is read-only"

    invoke-direct {v0, v1}, Ljavax/mail/IllegalWriteException;-><init>(Ljava/lang/String;)V

    throw v0
.end method

.method public setDisposition(Ljava/lang/String;)V
    .locals 2
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljavax/mail/MessagingException;
        }
    .end annotation

    .prologue
    .line 108
    new-instance v0, Ljavax/mail/IllegalWriteException;

    const-string v1, "IMAPBodyPart is read-only"

    invoke-direct {v0, v1}, Ljavax/mail/IllegalWriteException;-><init>(Ljava/lang/String;)V

    throw v0
.end method

.method public setFileName(Ljava/lang/String;)V
    .locals 2
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljavax/mail/MessagingException;
        }
    .end annotation

    .prologue
    .line 158
    new-instance v0, Ljavax/mail/IllegalWriteException;

    const-string v1, "IMAPBodyPart is read-only"

    invoke-direct {v0, v1}, Ljavax/mail/IllegalWriteException;-><init>(Ljava/lang/String;)V

    throw v0
.end method

.method public setHeader(Ljava/lang/String;Ljava/lang/String;)V
    .locals 2
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljavax/mail/MessagingException;
        }
    .end annotation

    .prologue
    .line 240
    new-instance v0, Ljavax/mail/IllegalWriteException;

    const-string v1, "IMAPBodyPart is read-only"

    invoke-direct {v0, v1}, Ljavax/mail/IllegalWriteException;-><init>(Ljava/lang/String;)V

    throw v0
.end method

.method protected updateHeaders()V
    .locals 0

    .prologue
    .line 88
    return-void
.end method
