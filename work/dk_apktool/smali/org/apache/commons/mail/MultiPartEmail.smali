.class public Lorg/apache/commons/mail/MultiPartEmail;
.super Lorg/apache/commons/mail/Email;
.source "SourceFile"


# instance fields
.field private boolHasAttachments:Z

.field private container:Ljavax/mail/internet/MimeMultipart;

.field private initialized:Z

.field private primaryBodyPart:Ljavax/mail/BodyPart;

.field private subType:Ljava/lang/String;


# direct methods
.method public constructor <init>()V
    .locals 0

    .prologue
    .line 49
    invoke-direct {p0}, Lorg/apache/commons/mail/Email;-><init>()V

    return-void
.end method


# virtual methods
.method public addPart(Ljava/lang/String;Ljava/lang/String;)Lorg/apache/commons/mail/Email;
    .locals 2
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Lorg/apache/commons/mail/EmailException;
        }
    .end annotation

    .prologue
    .line 101
    invoke-virtual {p0}, Lorg/apache/commons/mail/MultiPartEmail;->createBodyPart()Ljavax/mail/BodyPart;

    move-result-object v0

    .line 104
    :try_start_0
    invoke-virtual {v0, p1, p2}, Ljavax/mail/BodyPart;->setContent(Ljava/lang/Object;Ljava/lang/String;)V

    .line 105
    invoke-virtual {p0}, Lorg/apache/commons/mail/MultiPartEmail;->getContainer()Ljavax/mail/internet/MimeMultipart;

    move-result-object v1

    invoke-virtual {v1, v0}, Ljavax/mail/internet/MimeMultipart;->addBodyPart(Ljavax/mail/BodyPart;)V
    :try_end_0
    .catch Ljavax/mail/MessagingException; {:try_start_0 .. :try_end_0} :catch_0

    .line 112
    return-object p0

    .line 107
    :catch_0
    move-exception v0

    .line 109
    new-instance v1, Lorg/apache/commons/mail/EmailException;

    invoke-direct {v1, v0}, Lorg/apache/commons/mail/EmailException;-><init>(Ljava/lang/Throwable;)V

    throw v1
.end method

.method public addPart(Ljavax/mail/internet/MimeMultipart;)Lorg/apache/commons/mail/Email;
    .locals 2
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Lorg/apache/commons/mail/EmailException;
        }
    .end annotation

    .prologue
    .line 128
    :try_start_0
    invoke-virtual {p0}, Lorg/apache/commons/mail/MultiPartEmail;->getContainer()Ljavax/mail/internet/MimeMultipart;

    move-result-object v0

    invoke-virtual {v0}, Ljavax/mail/internet/MimeMultipart;->getCount()I

    move-result v0

    invoke-virtual {p0, p1, v0}, Lorg/apache/commons/mail/MultiPartEmail;->addPart(Ljavax/mail/internet/MimeMultipart;I)Lorg/apache/commons/mail/Email;
    :try_end_0
    .catch Ljavax/mail/MessagingException; {:try_start_0 .. :try_end_0} :catch_0

    move-result-object v0

    return-object v0

    .line 130
    :catch_0
    move-exception v0

    .line 132
    new-instance v1, Lorg/apache/commons/mail/EmailException;

    invoke-direct {v1, v0}, Lorg/apache/commons/mail/EmailException;-><init>(Ljava/lang/Throwable;)V

    throw v1
.end method

.method public addPart(Ljavax/mail/internet/MimeMultipart;I)Lorg/apache/commons/mail/Email;
    .locals 2
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Lorg/apache/commons/mail/EmailException;
        }
    .end annotation

    .prologue
    .line 147
    invoke-virtual {p0}, Lorg/apache/commons/mail/MultiPartEmail;->createBodyPart()Ljavax/mail/BodyPart;

    move-result-object v0

    .line 150
    :try_start_0
    invoke-virtual {v0, p1}, Ljavax/mail/BodyPart;->setContent(Ljavax/mail/Multipart;)V

    .line 151
    invoke-virtual {p0}, Lorg/apache/commons/mail/MultiPartEmail;->getContainer()Ljavax/mail/internet/MimeMultipart;

    move-result-object v1

    invoke-virtual {v1, v0, p2}, Ljavax/mail/internet/MimeMultipart;->addBodyPart(Ljavax/mail/BodyPart;I)V
    :try_end_0
    .catch Ljavax/mail/MessagingException; {:try_start_0 .. :try_end_0} :catch_0

    .line 158
    return-object p0

    .line 153
    :catch_0
    move-exception v0

    .line 155
    new-instance v1, Lorg/apache/commons/mail/EmailException;

    invoke-direct {v1, v0}, Lorg/apache/commons/mail/EmailException;-><init>(Ljava/lang/Throwable;)V

    throw v1
.end method

.method public attach(Ljava/io/File;)Lorg/apache/commons/mail/MultiPartEmail;
    .locals 5
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Lorg/apache/commons/mail/EmailException;
        }
    .end annotation

    .prologue
    .line 274
    invoke-virtual {p1}, Ljava/io/File;->getAbsolutePath()Ljava/lang/String;

    move-result-object v1

    .line 278
    :try_start_0
    invoke-virtual {p1}, Ljava/io/File;->exists()Z

    move-result v0

    if-nez v0, :cond_0

    .line 280
    new-instance v0, Ljava/io/IOException;

    new-instance v2, Ljava/lang/StringBuilder;

    invoke-direct {v2}, Ljava/lang/StringBuilder;-><init>()V

    const-string v3, "\""

    invoke-virtual {v2, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    invoke-virtual {v2, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    const-string v3, "\" does not exist"

    invoke-virtual {v2, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    invoke-virtual {v2}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v2

    invoke-direct {v0, v2}, Ljava/io/IOException;-><init>(Ljava/lang/String;)V

    throw v0
    :try_end_0
    .catch Ljava/io/IOException; {:try_start_0 .. :try_end_0} :catch_0

    .line 287
    :catch_0
    move-exception v0

    .line 289
    new-instance v2, Lorg/apache/commons/mail/EmailException;

    new-instance v3, Ljava/lang/StringBuilder;

    invoke-direct {v3}, Ljava/lang/StringBuilder;-><init>()V

    const-string v4, "Cannot attach file \""

    invoke-virtual {v3, v4}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v3

    invoke-virtual {v3, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    const-string v3, "\""

    invoke-virtual {v1, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v1

    invoke-direct {v2, v1, v0}, Lorg/apache/commons/mail/EmailException;-><init>(Ljava/lang/String;Ljava/lang/Throwable;)V

    throw v2

    .line 283
    :cond_0
    :try_start_1
    new-instance v0, Ljavax/activation/FileDataSource;

    invoke-direct {v0, p1}, Ljavax/activation/FileDataSource;-><init>(Ljava/io/File;)V

    .line 285
    invoke-virtual {p1}, Ljava/io/File;->getName()Ljava/lang/String;

    move-result-object v2

    const/4 v3, 0x0

    const-string v4, "attachment"

    invoke-virtual {p0, v0, v2, v3, v4}, Lorg/apache/commons/mail/MultiPartEmail;->attach(Ljavax/activation/DataSource;Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;)Lorg/apache/commons/mail/MultiPartEmail;
    :try_end_1
    .catch Ljava/io/IOException; {:try_start_1 .. :try_end_1} :catch_0

    move-result-object v0

    return-object v0
.end method

.method public attach(Ljava/net/URL;Ljava/lang/String;Ljava/lang/String;)Lorg/apache/commons/mail/MultiPartEmail;
    .locals 1
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Lorg/apache/commons/mail/EmailException;
        }
    .end annotation

    .prologue
    .line 365
    const-string v0, "attachment"

    invoke-virtual {p0, p1, p2, p3, v0}, Lorg/apache/commons/mail/MultiPartEmail;->attach(Ljava/net/URL;Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;)Lorg/apache/commons/mail/MultiPartEmail;

    move-result-object v0

    return-object v0
.end method

.method public attach(Ljava/net/URL;Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;)Lorg/apache/commons/mail/MultiPartEmail;
    .locals 4
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Lorg/apache/commons/mail/EmailException;
        }
    .end annotation

    .prologue
    .line 390
    :try_start_0
    invoke-virtual {p1}, Ljava/net/URL;->openStream()Ljava/io/InputStream;

    move-result-object v0

    .line 391
    invoke-virtual {v0}, Ljava/io/InputStream;->close()V
    :try_end_0
    .catch Ljava/io/IOException; {:try_start_0 .. :try_end_0} :catch_0

    .line 398
    new-instance v0, Ljavax/activation/URLDataSource;

    invoke-direct {v0, p1}, Ljavax/activation/URLDataSource;-><init>(Ljava/net/URL;)V

    invoke-virtual {p0, v0, p2, p3, p4}, Lorg/apache/commons/mail/MultiPartEmail;->attach(Ljavax/activation/DataSource;Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;)Lorg/apache/commons/mail/MultiPartEmail;

    move-result-object v0

    return-object v0

    .line 393
    :catch_0
    move-exception v0

    .line 395
    new-instance v1, Lorg/apache/commons/mail/EmailException;

    new-instance v2, Ljava/lang/StringBuilder;

    invoke-direct {v2}, Ljava/lang/StringBuilder;-><init>()V

    const-string v3, "Invalid URL set:"

    invoke-virtual {v2, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    invoke-virtual {v2, p1}, Ljava/lang/StringBuilder;->append(Ljava/lang/Object;)Ljava/lang/StringBuilder;

    move-result-object v2

    invoke-virtual {v2}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v2

    invoke-direct {v1, v2, v0}, Lorg/apache/commons/mail/EmailException;-><init>(Ljava/lang/String;Ljava/lang/Throwable;)V

    throw v1
.end method

.method public attach(Ljavax/activation/DataSource;Ljava/lang/String;Ljava/lang/String;)Lorg/apache/commons/mail/MultiPartEmail;
    .locals 3
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Lorg/apache/commons/mail/EmailException;
        }
    .end annotation

    .prologue
    .line 421
    if-eqz p1, :cond_1

    :try_start_0
    invoke-interface {p1}, Ljavax/activation/DataSource;->getInputStream()Ljava/io/InputStream;

    move-result-object v0

    .line 422
    :goto_0
    if-eqz v0, :cond_0

    .line 425
    invoke-virtual {v0}, Ljava/io/InputStream;->close()V

    .line 428
    :cond_0
    if-nez v0, :cond_2

    .line 430
    new-instance v0, Lorg/apache/commons/mail/EmailException;

    const-string v1, "Invalid Datasource"

    invoke-direct {v0, v1}, Lorg/apache/commons/mail/EmailException;-><init>(Ljava/lang/String;)V

    throw v0
    :try_end_0
    .catch Ljava/io/IOException; {:try_start_0 .. :try_end_0} :catch_0

    .line 433
    :catch_0
    move-exception v0

    .line 435
    new-instance v1, Lorg/apache/commons/mail/EmailException;

    const-string v2, "Invalid Datasource"

    invoke-direct {v1, v2, v0}, Lorg/apache/commons/mail/EmailException;-><init>(Ljava/lang/String;Ljava/lang/Throwable;)V

    throw v1

    .line 421
    :cond_1
    const/4 v0, 0x0

    goto :goto_0

    .line 438
    :cond_2
    const-string v0, "attachment"

    invoke-virtual {p0, p1, p2, p3, v0}, Lorg/apache/commons/mail/MultiPartEmail;->attach(Ljavax/activation/DataSource;Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;)Lorg/apache/commons/mail/MultiPartEmail;

    move-result-object v0

    return-object v0
.end method

.method public attach(Ljavax/activation/DataSource;Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;)Lorg/apache/commons/mail/MultiPartEmail;
    .locals 2
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Lorg/apache/commons/mail/EmailException;
        }
    .end annotation

    .prologue
    .line 460
    invoke-static {p2}, Lorg/apache/commons/mail/EmailUtils;->isEmpty(Ljava/lang/String;)Z

    move-result v0

    if-eqz v0, :cond_0

    .line 462
    invoke-interface {p1}, Ljavax/activation/DataSource;->getName()Ljava/lang/String;

    move-result-object p2

    .line 464
    :cond_0
    invoke-virtual {p0}, Lorg/apache/commons/mail/MultiPartEmail;->createBodyPart()Ljavax/mail/BodyPart;

    move-result-object v0

    .line 467
    :try_start_0
    invoke-virtual {v0, p4}, Ljavax/mail/BodyPart;->setDisposition(Ljava/lang/String;)V

    .line 468
    invoke-static {p2}, Ljavax/mail/internet/MimeUtility;->encodeText(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v1

    invoke-virtual {v0, v1}, Ljavax/mail/BodyPart;->setFileName(Ljava/lang/String;)V

    .line 469
    invoke-virtual {v0, p3}, Ljavax/mail/BodyPart;->setDescription(Ljava/lang/String;)V

    .line 470
    new-instance v1, Ljavax/activation/DataHandler;

    invoke-direct {v1, p1}, Ljavax/activation/DataHandler;-><init>(Ljavax/activation/DataSource;)V

    invoke-virtual {v0, v1}, Ljavax/mail/BodyPart;->setDataHandler(Ljavax/activation/DataHandler;)V

    .line 472
    invoke-virtual {p0}, Lorg/apache/commons/mail/MultiPartEmail;->getContainer()Ljavax/mail/internet/MimeMultipart;

    move-result-object v1

    invoke-virtual {v1, v0}, Ljavax/mail/internet/MimeMultipart;->addBodyPart(Ljavax/mail/BodyPart;)V
    :try_end_0
    .catch Ljava/io/UnsupportedEncodingException; {:try_start_0 .. :try_end_0} :catch_0
    .catch Ljavax/mail/MessagingException; {:try_start_0 .. :try_end_0} :catch_1

    .line 483
    const/4 v0, 0x1

    invoke-virtual {p0, v0}, Lorg/apache/commons/mail/MultiPartEmail;->setBoolHasAttachments(Z)V

    .line 485
    return-object p0

    .line 474
    :catch_0
    move-exception v0

    .line 477
    new-instance v1, Lorg/apache/commons/mail/EmailException;

    invoke-direct {v1, v0}, Lorg/apache/commons/mail/EmailException;-><init>(Ljava/lang/Throwable;)V

    throw v1

    .line 479
    :catch_1
    move-exception v0

    .line 481
    new-instance v1, Lorg/apache/commons/mail/EmailException;

    invoke-direct {v1, v0}, Lorg/apache/commons/mail/EmailException;-><init>(Ljava/lang/Throwable;)V

    throw v1
.end method

.method public attach(Lorg/apache/commons/mail/EmailAttachment;)Lorg/apache/commons/mail/MultiPartEmail;
    .locals 5
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Lorg/apache/commons/mail/EmailException;
        }
    .end annotation

    .prologue
    .line 305
    .line 307
    if-nez p1, :cond_0

    .line 309
    new-instance v0, Lorg/apache/commons/mail/EmailException;

    const-string v1, "Invalid attachment supplied"

    invoke-direct {v0, v1}, Lorg/apache/commons/mail/EmailException;-><init>(Ljava/lang/String;)V

    throw v0

    .line 312
    :cond_0
    invoke-virtual {p1}, Lorg/apache/commons/mail/EmailAttachment;->getURL()Ljava/net/URL;

    move-result-object v0

    .line 314
    if-nez v0, :cond_2

    .line 316
    const/4 v1, 0x0

    .line 319
    :try_start_0
    invoke-virtual {p1}, Lorg/apache/commons/mail/EmailAttachment;->getPath()Ljava/lang/String;

    move-result-object v1

    .line 320
    new-instance v0, Ljava/io/File;

    invoke-direct {v0, v1}, Ljava/io/File;-><init>(Ljava/lang/String;)V

    .line 321
    invoke-virtual {v0}, Ljava/io/File;->exists()Z

    move-result v2

    if-nez v2, :cond_1

    .line 323
    new-instance v0, Ljava/io/IOException;

    new-instance v2, Ljava/lang/StringBuilder;

    invoke-direct {v2}, Ljava/lang/StringBuilder;-><init>()V

    const-string v3, "\""

    invoke-virtual {v2, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    invoke-virtual {v2, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    const-string v3, "\" does not exist"

    invoke-virtual {v2, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    invoke-virtual {v2}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v2

    invoke-direct {v0, v2}, Ljava/io/IOException;-><init>(Ljava/lang/String;)V

    throw v0
    :try_end_0
    .catch Ljava/io/IOException; {:try_start_0 .. :try_end_0} :catch_0

    .line 332
    :catch_0
    move-exception v0

    .line 334
    new-instance v2, Lorg/apache/commons/mail/EmailException;

    new-instance v3, Ljava/lang/StringBuilder;

    invoke-direct {v3}, Ljava/lang/StringBuilder;-><init>()V

    const-string v4, "Cannot attach file \""

    invoke-virtual {v3, v4}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v3

    invoke-virtual {v3, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    const-string v3, "\""

    invoke-virtual {v1, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v1

    invoke-direct {v2, v1, v0}, Lorg/apache/commons/mail/EmailException;-><init>(Ljava/lang/String;Ljava/lang/Throwable;)V

    throw v2

    .line 325
    :cond_1
    :try_start_1
    new-instance v2, Ljavax/activation/FileDataSource;

    invoke-direct {v2, v0}, Ljavax/activation/FileDataSource;-><init>(Ljava/io/File;)V

    invoke-virtual {p1}, Lorg/apache/commons/mail/EmailAttachment;->getName()Ljava/lang/String;

    move-result-object v0

    invoke-virtual {p1}, Lorg/apache/commons/mail/EmailAttachment;->getDescription()Ljava/lang/String;

    move-result-object v3

    invoke-virtual {p1}, Lorg/apache/commons/mail/EmailAttachment;->getDisposition()Ljava/lang/String;

    move-result-object v4

    invoke-virtual {p0, v2, v0, v3, v4}, Lorg/apache/commons/mail/MultiPartEmail;->attach(Ljavax/activation/DataSource;Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;)Lorg/apache/commons/mail/MultiPartEmail;
    :try_end_1
    .catch Ljava/io/IOException; {:try_start_1 .. :try_end_1} :catch_0

    move-result-object v0

    .line 347
    :goto_0
    return-object v0

    .line 339
    :cond_2
    invoke-virtual {p1}, Lorg/apache/commons/mail/EmailAttachment;->getName()Ljava/lang/String;

    move-result-object v1

    invoke-virtual {p1}, Lorg/apache/commons/mail/EmailAttachment;->getDescription()Ljava/lang/String;

    move-result-object v2

    invoke-virtual {p1}, Lorg/apache/commons/mail/EmailAttachment;->getDisposition()Ljava/lang/String;

    move-result-object v3

    invoke-virtual {p0, v0, v1, v2, v3}, Lorg/apache/commons/mail/MultiPartEmail;->attach(Ljava/net/URL;Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;)Lorg/apache/commons/mail/MultiPartEmail;

    move-result-object v0

    goto :goto_0
.end method

.method public buildMimeMessage()V
    .locals 2
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Lorg/apache/commons/mail/EmailException;
        }
    .end annotation

    .prologue
    .line 229
    :try_start_0
    iget-object v0, p0, Lorg/apache/commons/mail/MultiPartEmail;->primaryBodyPart:Ljavax/mail/BodyPart;

    if-eqz v0, :cond_0

    .line 235
    invoke-virtual {p0}, Lorg/apache/commons/mail/MultiPartEmail;->getPrimaryBodyPart()Ljavax/mail/BodyPart;
    :try_end_0
    .catch Ljavax/mail/MessagingException; {:try_start_0 .. :try_end_0} :catch_0

    move-result-object v0

    .line 238
    :try_start_1
    invoke-virtual {v0}, Ljavax/mail/BodyPart;->getContent()Ljava/lang/Object;
    :try_end_1
    .catch Ljava/io/IOException; {:try_start_1 .. :try_end_1} :catch_1
    .catch Ljavax/mail/MessagingException; {:try_start_1 .. :try_end_1} :catch_0

    .line 249
    :cond_0
    :goto_0
    :try_start_2
    iget-object v0, p0, Lorg/apache/commons/mail/MultiPartEmail;->subType:Ljava/lang/String;

    if-eqz v0, :cond_1

    .line 251
    invoke-virtual {p0}, Lorg/apache/commons/mail/MultiPartEmail;->getContainer()Ljavax/mail/internet/MimeMultipart;

    move-result-object v0

    iget-object v1, p0, Lorg/apache/commons/mail/MultiPartEmail;->subType:Ljava/lang/String;

    invoke-virtual {v0, v1}, Ljavax/mail/internet/MimeMultipart;->setSubType(Ljava/lang/String;)V

    .line 254
    :cond_1
    invoke-super {p0}, Lorg/apache/commons/mail/Email;->buildMimeMessage()V
    :try_end_2
    .catch Ljavax/mail/MessagingException; {:try_start_2 .. :try_end_2} :catch_0

    .line 260
    return-void

    .line 256
    :catch_0
    move-exception v0

    .line 258
    new-instance v1, Lorg/apache/commons/mail/EmailException;

    invoke-direct {v1, v0}, Lorg/apache/commons/mail/EmailException;-><init>(Ljava/lang/Throwable;)V

    throw v1

    .line 240
    :catch_1
    move-exception v0

    goto :goto_0
.end method

.method protected createBodyPart()Ljavax/mail/BodyPart;
    .locals 1

    .prologue
    .line 535
    new-instance v0, Ljavax/mail/internet/MimeBodyPart;

    invoke-direct {v0}, Ljavax/mail/internet/MimeBodyPart;-><init>()V

    return-object v0
.end method

.method protected createMimeMultipart()Ljavax/mail/internet/MimeMultipart;
    .locals 1

    .prologue
    .line 545
    new-instance v0, Ljavax/mail/internet/MimeMultipart;

    invoke-direct {v0}, Ljavax/mail/internet/MimeMultipart;-><init>()V

    return-object v0
.end method

.method protected getContainer()Ljavax/mail/internet/MimeMultipart;
    .locals 1

    .prologue
    .line 520
    iget-boolean v0, p0, Lorg/apache/commons/mail/MultiPartEmail;->initialized:Z

    if-nez v0, :cond_0

    .line 522
    invoke-virtual {p0}, Lorg/apache/commons/mail/MultiPartEmail;->init()V

    .line 524
    :cond_0
    iget-object v0, p0, Lorg/apache/commons/mail/MultiPartEmail;->container:Ljavax/mail/internet/MimeMultipart;

    return-object v0
.end method

.method protected getPrimaryBodyPart()Ljavax/mail/BodyPart;
    .locals 3
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljavax/mail/MessagingException;
        }
    .end annotation

    .prologue
    .line 497
    iget-boolean v0, p0, Lorg/apache/commons/mail/MultiPartEmail;->initialized:Z

    if-nez v0, :cond_0

    .line 499
    invoke-virtual {p0}, Lorg/apache/commons/mail/MultiPartEmail;->init()V

    .line 503
    :cond_0
    iget-object v0, p0, Lorg/apache/commons/mail/MultiPartEmail;->primaryBodyPart:Ljavax/mail/BodyPart;

    if-nez v0, :cond_1

    .line 505
    invoke-virtual {p0}, Lorg/apache/commons/mail/MultiPartEmail;->createBodyPart()Ljavax/mail/BodyPart;

    move-result-object v0

    iput-object v0, p0, Lorg/apache/commons/mail/MultiPartEmail;->primaryBodyPart:Ljavax/mail/BodyPart;

    .line 506
    invoke-virtual {p0}, Lorg/apache/commons/mail/MultiPartEmail;->getContainer()Ljavax/mail/internet/MimeMultipart;

    move-result-object v0

    iget-object v1, p0, Lorg/apache/commons/mail/MultiPartEmail;->primaryBodyPart:Ljavax/mail/BodyPart;

    const/4 v2, 0x0

    invoke-virtual {v0, v1, v2}, Ljavax/mail/internet/MimeMultipart;->addBodyPart(Ljavax/mail/BodyPart;I)V

    .line 509
    :cond_1
    iget-object v0, p0, Lorg/apache/commons/mail/MultiPartEmail;->primaryBodyPart:Ljavax/mail/BodyPart;

    return-object v0
.end method

.method public getSubType()Ljava/lang/String;
    .locals 1

    .prologue
    .line 85
    iget-object v0, p0, Lorg/apache/commons/mail/MultiPartEmail;->subType:Ljava/lang/String;

    return-object v0
.end method

.method protected init()V
    .locals 2

    .prologue
    .line 167
    iget-boolean v0, p0, Lorg/apache/commons/mail/MultiPartEmail;->initialized:Z

    if-eqz v0, :cond_0

    .line 169
    new-instance v0, Ljava/lang/IllegalStateException;

    const-string v1, "Already initialized"

    invoke-direct {v0, v1}, Ljava/lang/IllegalStateException;-><init>(Ljava/lang/String;)V

    throw v0

    .line 172
    :cond_0
    invoke-virtual {p0}, Lorg/apache/commons/mail/MultiPartEmail;->createMimeMultipart()Ljavax/mail/internet/MimeMultipart;

    move-result-object v0

    iput-object v0, p0, Lorg/apache/commons/mail/MultiPartEmail;->container:Ljavax/mail/internet/MimeMultipart;

    .line 173
    iget-object v0, p0, Lorg/apache/commons/mail/MultiPartEmail;->container:Ljavax/mail/internet/MimeMultipart;

    invoke-super {p0, v0}, Lorg/apache/commons/mail/Email;->setContent(Ljavax/mail/internet/MimeMultipart;)V

    .line 175
    const/4 v0, 0x1

    iput-boolean v0, p0, Lorg/apache/commons/mail/MultiPartEmail;->initialized:Z

    .line 176
    return-void
.end method

.method public isBoolHasAttachments()Z
    .locals 1

    .prologue
    .line 556
    iget-boolean v0, p0, Lorg/apache/commons/mail/MultiPartEmail;->boolHasAttachments:Z

    return v0
.end method

.method protected isInitialized()Z
    .locals 1

    .prologue
    .line 577
    iget-boolean v0, p0, Lorg/apache/commons/mail/MultiPartEmail;->initialized:Z

    return v0
.end method

.method public setBoolHasAttachments(Z)V
    .locals 0

    .prologue
    .line 567
    iput-boolean p1, p0, Lorg/apache/commons/mail/MultiPartEmail;->boolHasAttachments:Z

    .line 568
    return-void
.end method

.method protected setInitialized(Z)V
    .locals 0

    .prologue
    .line 587
    iput-boolean p1, p0, Lorg/apache/commons/mail/MultiPartEmail;->initialized:Z

    .line 588
    return-void
.end method

.method public setMsg(Ljava/lang/String;)Lorg/apache/commons/mail/Email;
    .locals 2
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Lorg/apache/commons/mail/EmailException;
        }
    .end annotation

    .prologue
    .line 191
    invoke-static {p1}, Lorg/apache/commons/mail/EmailUtils;->isEmpty(Ljava/lang/String;)Z

    move-result v0

    if-eqz v0, :cond_0

    .line 193
    new-instance v0, Lorg/apache/commons/mail/EmailException;

    const-string v1, "Invalid message supplied"

    invoke-direct {v0, v1}, Lorg/apache/commons/mail/EmailException;-><init>(Ljava/lang/String;)V

    throw v0

    .line 197
    :cond_0
    :try_start_0
    invoke-virtual {p0}, Lorg/apache/commons/mail/MultiPartEmail;->getPrimaryBodyPart()Ljavax/mail/BodyPart;

    move-result-object v0

    .line 199
    instance-of v1, v0, Ljavax/mail/internet/MimePart;

    if-eqz v1, :cond_1

    iget-object v1, p0, Lorg/apache/commons/mail/MultiPartEmail;->charset:Ljava/lang/String;

    invoke-static {v1}, Lorg/apache/commons/mail/EmailUtils;->isNotEmpty(Ljava/lang/String;)Z

    move-result v1

    if-eqz v1, :cond_1

    .line 201
    check-cast v0, Ljavax/mail/internet/MimePart;

    iget-object v1, p0, Lorg/apache/commons/mail/MultiPartEmail;->charset:Ljava/lang/String;

    invoke-interface {v0, p1, v1}, Ljavax/mail/internet/MimePart;->setText(Ljava/lang/String;Ljava/lang/String;)V

    .line 212
    :goto_0
    return-object p0

    .line 205
    :cond_1
    invoke-virtual {v0, p1}, Ljavax/mail/BodyPart;->setText(Ljava/lang/String;)V
    :try_end_0
    .catch Ljavax/mail/MessagingException; {:try_start_0 .. :try_end_0} :catch_0

    goto :goto_0

    .line 208
    :catch_0
    move-exception v0

    .line 210
    new-instance v1, Lorg/apache/commons/mail/EmailException;

    invoke-direct {v1, v0}, Lorg/apache/commons/mail/EmailException;-><init>(Ljava/lang/Throwable;)V

    throw v1
.end method

.method public setSubType(Ljava/lang/String;)V
    .locals 0

    .prologue
    .line 74
    iput-object p1, p0, Lorg/apache/commons/mail/MultiPartEmail;->subType:Ljava/lang/String;

    .line 75
    return-void
.end method
