.class public Lorg/apache/commons/mail/b/a;
.super Ljava/lang/Object;
.source "SourceFile"


# instance fields
.field private final a:Ljavax/mail/internet/MimeMessage;

.field private b:Ljava/lang/String;

.field private c:Ljava/lang/String;

.field private final d:Ljava/util/List;
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "Ljava/util/List",
            "<",
            "Ljavax/activation/DataSource;",
            ">;"
        }
    .end annotation
.end field

.field private final e:Ljava/util/Map;
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "Ljava/util/Map",
            "<",
            "Ljava/lang/String;",
            "Ljavax/activation/DataSource;",
            ">;"
        }
    .end annotation
.end field

.field private f:Z


# direct methods
.method public constructor <init>(Ljavax/mail/internet/MimeMessage;)V
    .locals 1

    .prologue
    .line 81
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    .line 82
    new-instance v0, Ljava/util/ArrayList;

    invoke-direct {v0}, Ljava/util/ArrayList;-><init>()V

    iput-object v0, p0, Lorg/apache/commons/mail/b/a;->d:Ljava/util/List;

    .line 83
    new-instance v0, Ljava/util/HashMap;

    invoke-direct {v0}, Ljava/util/HashMap;-><init>()V

    iput-object v0, p0, Lorg/apache/commons/mail/b/a;->e:Ljava/util/Map;

    .line 84
    iput-object p1, p0, Lorg/apache/commons/mail/b/a;->a:Ljavax/mail/internet/MimeMessage;

    .line 85
    const/4 v0, 0x0

    iput-boolean v0, p0, Lorg/apache/commons/mail/b/a;->f:Z

    .line 86
    return-void
.end method

.method private a(Ljavax/mail/internet/MimePart;Ljava/lang/String;)Z
    .locals 2
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljavax/mail/MessagingException;,
            Ljava/io/IOException;
        }
    .end annotation

    .prologue
    .line 250
    :try_start_0
    new-instance v0, Ljavax/mail/internet/ContentType;

    invoke-interface {p1}, Ljavax/mail/internet/MimePart;->getDataHandler()Ljavax/activation/DataHandler;

    move-result-object v1

    invoke-virtual {v1}, Ljavax/activation/DataHandler;->getContentType()Ljava/lang/String;

    move-result-object v1

    invoke-direct {v0, v1}, Ljavax/mail/internet/ContentType;-><init>(Ljava/lang/String;)V

    .line 251
    invoke-virtual {v0, p2}, Ljavax/mail/internet/ContentType;->match(Ljava/lang/String;)Z
    :try_end_0
    .catch Ljavax/mail/internet/ParseException; {:try_start_0 .. :try_end_0} :catch_0

    move-result v0

    .line 255
    :goto_0
    return v0

    .line 253
    :catch_0
    move-exception v0

    .line 255
    invoke-interface {p1}, Ljavax/mail/internet/MimePart;->getContentType()Ljava/lang/String;

    move-result-object v0

    invoke-virtual {v0, p2}, Ljava/lang/String;->equalsIgnoreCase(Ljava/lang/String;)Z

    move-result v0

    goto :goto_0
.end method

.method private a(Ljava/io/InputStream;)[B
    .locals 5
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljava/io/IOException;
        }
    .end annotation

    .prologue
    .line 426
    new-instance v0, Ljava/io/ByteArrayOutputStream;

    invoke-direct {v0}, Ljava/io/ByteArrayOutputStream;-><init>()V

    .line 427
    new-instance v1, Ljava/io/BufferedInputStream;

    invoke-direct {v1, p1}, Ljava/io/BufferedInputStream;-><init>(Ljava/io/InputStream;)V

    .line 428
    new-instance v2, Ljava/io/BufferedOutputStream;

    invoke-direct {v2, v0}, Ljava/io/BufferedOutputStream;-><init>(Ljava/io/OutputStream;)V

    .line 430
    :goto_0
    invoke-virtual {v1}, Ljava/io/BufferedInputStream;->read()I

    move-result v3

    const/4 v4, -0x1

    if-eq v3, v4, :cond_0

    .line 432
    invoke-virtual {v2, v3}, Ljava/io/BufferedOutputStream;->write(I)V

    goto :goto_0

    .line 435
    :cond_0
    invoke-virtual {v2}, Ljava/io/BufferedOutputStream;->flush()V

    .line 436
    invoke-virtual {v0}, Ljava/io/ByteArrayOutputStream;->toByteArray()[B

    move-result-object v0

    .line 437
    invoke-virtual {v2}, Ljava/io/BufferedOutputStream;->close()V

    .line 439
    return-object v0
.end method

.method private c(Ljava/lang/String;)Ljava/lang/String;
    .locals 3

    .prologue
    .line 226
    if-nez p1, :cond_0

    .line 228
    const/4 v0, 0x0

    .line 230
    :goto_0
    return-object v0

    :cond_0
    invoke-virtual {p1}, Ljava/lang/String;->trim()Ljava/lang/String;

    move-result-object v0

    const-string v1, "[\\<\\>]"

    const-string v2, ""

    invoke-virtual {v0, v1, v2}, Ljava/lang/String;->replaceAll(Ljava/lang/String;Ljava/lang/String;)Ljava/lang/String;

    move-result-object v0

    goto :goto_0
.end method

.method private d(Ljava/lang/String;)Ljava/lang/String;
    .locals 2

    .prologue
    .line 450
    const/16 v0, 0x3b

    invoke-virtual {p1, v0}, Ljava/lang/String;->indexOf(I)I

    move-result v0

    .line 451
    if-ltz v0, :cond_0

    .line 453
    const/4 v1, 0x0

    invoke-virtual {p1, v1, v0}, Ljava/lang/String;->substring(II)Ljava/lang/String;

    move-result-object p1

    .line 455
    :cond_0
    return-object p1
.end method


# virtual methods
.method protected a(Ljavax/mail/Part;Ljavax/activation/DataSource;)Ljava/lang/String;
    .locals 2
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljavax/mail/MessagingException;,
            Ljava/io/UnsupportedEncodingException;
        }
    .end annotation

    .prologue
    .line 394
    invoke-interface {p2}, Ljavax/activation/DataSource;->getName()Ljava/lang/String;

    move-result-object v0

    .line 396
    if-eqz v0, :cond_0

    invoke-virtual {v0}, Ljava/lang/String;->length()I

    move-result v1

    if-nez v1, :cond_1

    .line 398
    :cond_0
    invoke-interface {p1}, Ljavax/mail/Part;->getFileName()Ljava/lang/String;

    move-result-object v0

    .line 401
    :cond_1
    if-eqz v0, :cond_2

    invoke-virtual {v0}, Ljava/lang/String;->length()I

    move-result v1

    if-lez v1, :cond_2

    .line 403
    invoke-static {v0}, Ljavax/mail/internet/MimeUtility;->decodeText(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v0

    .line 410
    :goto_0
    return-object v0

    .line 407
    :cond_2
    const/4 v0, 0x0

    goto :goto_0
.end method

.method public a(Ljava/lang/String;)Ljavax/activation/DataSource;
    .locals 3

    .prologue
    .line 354
    const/4 v0, 0x0

    move v1, v0

    :goto_0
    invoke-virtual {p0}, Lorg/apache/commons/mail/b/a;->k()Ljava/util/List;

    move-result-object v0

    invoke-interface {v0}, Ljava/util/List;->size()I

    move-result v0

    if-ge v1, v0, :cond_1

    .line 356
    invoke-virtual {p0}, Lorg/apache/commons/mail/b/a;->k()Ljava/util/List;

    move-result-object v0

    invoke-interface {v0, v1}, Ljava/util/List;->get(I)Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Ljavax/activation/DataSource;

    .line 357
    invoke-interface {v0}, Ljavax/activation/DataSource;->getName()Ljava/lang/String;

    move-result-object v2

    invoke-virtual {p1, v2}, Ljava/lang/String;->equalsIgnoreCase(Ljava/lang/String;)Z

    move-result v2

    if-eqz v2, :cond_0

    .line 363
    :goto_1
    return-object v0

    .line 354
    :cond_0
    add-int/lit8 v0, v1, 0x1

    move v1, v0

    goto :goto_0

    .line 363
    :cond_1
    const/4 v0, 0x0

    goto :goto_1
.end method

.method public a()Lorg/apache/commons/mail/b/a;
    .locals 2
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljava/lang/Exception;
        }
    .end annotation

    .prologue
    .line 96
    const/4 v0, 0x0

    iget-object v1, p0, Lorg/apache/commons/mail/b/a;->a:Ljavax/mail/internet/MimeMessage;

    invoke-virtual {p0, v0, v1}, Lorg/apache/commons/mail/b/a;->a(Ljavax/mail/Multipart;Ljavax/mail/internet/MimePart;)V

    .line 97
    return-object p0
.end method

.method protected a(Ljavax/mail/Multipart;Ljavax/mail/internet/MimePart;)V
    .locals 4
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljavax/mail/MessagingException;,
            Ljava/io/IOException;
        }
    .end annotation

    .prologue
    .line 178
    const-string v0, "text/plain"

    invoke-direct {p0, p2, v0}, Lorg/apache/commons/mail/b/a;->a(Ljavax/mail/internet/MimePart;Ljava/lang/String;)Z

    move-result v0

    if-eqz v0, :cond_1

    iget-object v0, p0, Lorg/apache/commons/mail/b/a;->b:Ljava/lang/String;

    if-nez v0, :cond_1

    const-string v0, "attachment"

    invoke-interface {p2}, Ljavax/mail/internet/MimePart;->getDisposition()Ljava/lang/String;

    move-result-object v1

    invoke-virtual {v0, v1}, Ljava/lang/String;->equalsIgnoreCase(Ljava/lang/String;)Z

    move-result v0

    if-nez v0, :cond_1

    .line 181
    invoke-interface {p2}, Ljavax/mail/internet/MimePart;->getContent()Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Ljava/lang/String;

    iput-object v0, p0, Lorg/apache/commons/mail/b/a;->b:Ljava/lang/String;

    .line 217
    :cond_0
    :goto_0
    return-void

    .line 185
    :cond_1
    const-string v0, "text/html"

    invoke-direct {p0, p2, v0}, Lorg/apache/commons/mail/b/a;->a(Ljavax/mail/internet/MimePart;Ljava/lang/String;)Z

    move-result v0

    if-eqz v0, :cond_2

    iget-object v0, p0, Lorg/apache/commons/mail/b/a;->c:Ljava/lang/String;

    if-nez v0, :cond_2

    const-string v0, "attachment"

    invoke-interface {p2}, Ljavax/mail/internet/MimePart;->getDisposition()Ljava/lang/String;

    move-result-object v1

    invoke-virtual {v0, v1}, Ljava/lang/String;->equalsIgnoreCase(Ljava/lang/String;)Z

    move-result v0

    if-nez v0, :cond_2

    .line 188
    invoke-interface {p2}, Ljavax/mail/internet/MimePart;->getContent()Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Ljava/lang/String;

    iput-object v0, p0, Lorg/apache/commons/mail/b/a;->c:Ljava/lang/String;

    goto :goto_0

    .line 192
    :cond_2
    const-string v0, "multipart/*"

    invoke-direct {p0, p2, v0}, Lorg/apache/commons/mail/b/a;->a(Ljavax/mail/internet/MimePart;Ljava/lang/String;)Z

    move-result v0

    if-eqz v0, :cond_3

    .line 194
    const/4 v0, 0x1

    iput-boolean v0, p0, Lorg/apache/commons/mail/b/a;->f:Z

    .line 195
    invoke-interface {p2}, Ljavax/mail/internet/MimePart;->getContent()Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Ljavax/mail/Multipart;

    .line 196
    invoke-virtual {v0}, Ljavax/mail/Multipart;->getCount()I

    move-result v3

    .line 200
    const/4 v1, 0x0

    move v2, v1

    :goto_1
    if-ge v2, v3, :cond_0

    .line 202
    invoke-virtual {v0, v2}, Ljavax/mail/Multipart;->getBodyPart(I)Ljavax/mail/BodyPart;

    move-result-object v1

    check-cast v1, Ljavax/mail/internet/MimeBodyPart;

    invoke-virtual {p0, v0, v1}, Lorg/apache/commons/mail/b/a;->a(Ljavax/mail/Multipart;Ljavax/mail/internet/MimePart;)V

    .line 200
    add-int/lit8 v1, v2, 0x1

    move v2, v1

    goto :goto_1

    .line 207
    :cond_3
    invoke-interface {p2}, Ljavax/mail/internet/MimePart;->getContentID()Ljava/lang/String;

    move-result-object v0

    invoke-direct {p0, v0}, Lorg/apache/commons/mail/b/a;->c(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v0

    .line 208
    invoke-virtual {p0, p1, p2}, Lorg/apache/commons/mail/b/a;->b(Ljavax/mail/Multipart;Ljavax/mail/internet/MimePart;)Ljavax/activation/DataSource;

    move-result-object v1

    .line 209
    if-eqz v0, :cond_4

    .line 211
    iget-object v2, p0, Lorg/apache/commons/mail/b/a;->e:Ljava/util/Map;

    invoke-interface {v2, v0, v1}, Ljava/util/Map;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    .line 213
    :cond_4
    iget-object v0, p0, Lorg/apache/commons/mail/b/a;->d:Ljava/util/List;

    invoke-interface {v0, v1}, Ljava/util/List;->add(Ljava/lang/Object;)Z

    goto :goto_0
.end method

.method public b()Ljava/util/List;
    .locals 2
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "()",
            "Ljava/util/List",
            "<",
            "Ljavax/mail/Address;",
            ">;"
        }
    .end annotation

    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljava/lang/Exception;
        }
    .end annotation

    .prologue
    .line 106
    iget-object v0, p0, Lorg/apache/commons/mail/b/a;->a:Ljavax/mail/internet/MimeMessage;

    sget-object v1, Ljavax/mail/Message$RecipientType;->TO:Ljavax/mail/Message$RecipientType;

    invoke-virtual {v0, v1}, Ljavax/mail/internet/MimeMessage;->getRecipients(Ljavax/mail/Message$RecipientType;)[Ljavax/mail/Address;

    move-result-object v0

    .line 107
    if-eqz v0, :cond_0

    invoke-static {v0}, Ljava/util/Arrays;->asList([Ljava/lang/Object;)Ljava/util/List;

    move-result-object v0

    :goto_0
    return-object v0

    :cond_0
    new-instance v0, Ljava/util/ArrayList;

    invoke-direct {v0}, Ljava/util/ArrayList;-><init>()V

    goto :goto_0
.end method

.method public b(Ljava/lang/String;)Ljavax/activation/DataSource;
    .locals 1

    .prologue
    .line 378
    iget-object v0, p0, Lorg/apache/commons/mail/b/a;->e:Ljava/util/Map;

    invoke-interface {v0, p1}, Ljava/util/Map;->get(Ljava/lang/Object;)Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Ljavax/activation/DataSource;

    .line 379
    return-object v0
.end method

.method protected b(Ljavax/mail/Multipart;Ljavax/mail/internet/MimePart;)Ljavax/activation/DataSource;
    .locals 4
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljavax/mail/MessagingException;,
            Ljava/io/IOException;
        }
    .end annotation

    .prologue
    .line 271
    invoke-interface {p2}, Ljavax/mail/internet/MimePart;->getDataHandler()Ljavax/activation/DataHandler;

    move-result-object v0

    .line 272
    invoke-virtual {v0}, Ljavax/activation/DataHandler;->getDataSource()Ljavax/activation/DataSource;

    move-result-object v0

    .line 273
    invoke-interface {v0}, Ljavax/activation/DataSource;->getContentType()Ljava/lang/String;

    move-result-object v1

    invoke-direct {p0, v1}, Lorg/apache/commons/mail/b/a;->d(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v1

    .line 274
    invoke-interface {v0}, Ljavax/activation/DataSource;->getInputStream()Ljava/io/InputStream;

    move-result-object v2

    invoke-direct {p0, v2}, Lorg/apache/commons/mail/b/a;->a(Ljava/io/InputStream;)[B

    move-result-object v2

    .line 275
    new-instance v3, Ljavax/mail/util/ByteArrayDataSource;

    invoke-direct {v3, v2, v1}, Ljavax/mail/util/ByteArrayDataSource;-><init>([BLjava/lang/String;)V

    .line 276
    invoke-virtual {p0, p2, v0}, Lorg/apache/commons/mail/b/a;->a(Ljavax/mail/Part;Ljavax/activation/DataSource;)Ljava/lang/String;

    move-result-object v0

    .line 278
    invoke-virtual {v3, v0}, Ljavax/mail/util/ByteArrayDataSource;->setName(Ljava/lang/String;)V

    .line 279
    return-object v3
.end method

.method public c()Ljava/util/List;
    .locals 2
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "()",
            "Ljava/util/List",
            "<",
            "Ljavax/mail/Address;",
            ">;"
        }
    .end annotation

    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljava/lang/Exception;
        }
    .end annotation

    .prologue
    .line 116
    iget-object v0, p0, Lorg/apache/commons/mail/b/a;->a:Ljavax/mail/internet/MimeMessage;

    sget-object v1, Ljavax/mail/Message$RecipientType;->CC:Ljavax/mail/Message$RecipientType;

    invoke-virtual {v0, v1}, Ljavax/mail/internet/MimeMessage;->getRecipients(Ljavax/mail/Message$RecipientType;)[Ljavax/mail/Address;

    move-result-object v0

    .line 117
    if-eqz v0, :cond_0

    invoke-static {v0}, Ljava/util/Arrays;->asList([Ljava/lang/Object;)Ljava/util/List;

    move-result-object v0

    :goto_0
    return-object v0

    :cond_0
    new-instance v0, Ljava/util/ArrayList;

    invoke-direct {v0}, Ljava/util/ArrayList;-><init>()V

    goto :goto_0
.end method

.method public d()Ljava/util/List;
    .locals 2
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "()",
            "Ljava/util/List",
            "<",
            "Ljavax/mail/Address;",
            ">;"
        }
    .end annotation

    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljava/lang/Exception;
        }
    .end annotation

    .prologue
    .line 126
    iget-object v0, p0, Lorg/apache/commons/mail/b/a;->a:Ljavax/mail/internet/MimeMessage;

    sget-object v1, Ljavax/mail/Message$RecipientType;->BCC:Ljavax/mail/Message$RecipientType;

    invoke-virtual {v0, v1}, Ljavax/mail/internet/MimeMessage;->getRecipients(Ljavax/mail/Message$RecipientType;)[Ljavax/mail/Address;

    move-result-object v0

    .line 127
    if-eqz v0, :cond_0

    invoke-static {v0}, Ljava/util/Arrays;->asList([Ljava/lang/Object;)Ljava/util/List;

    move-result-object v0

    :goto_0
    return-object v0

    :cond_0
    new-instance v0, Ljava/util/ArrayList;

    invoke-direct {v0}, Ljava/util/ArrayList;-><init>()V

    goto :goto_0
.end method

.method public e()Ljava/lang/String;
    .locals 2
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljava/lang/Exception;
        }
    .end annotation

    .prologue
    .line 136
    iget-object v0, p0, Lorg/apache/commons/mail/b/a;->a:Ljavax/mail/internet/MimeMessage;

    invoke-virtual {v0}, Ljavax/mail/internet/MimeMessage;->getFrom()[Ljavax/mail/Address;

    move-result-object v0

    .line 137
    if-eqz v0, :cond_0

    array-length v1, v0

    if-nez v1, :cond_1

    .line 139
    :cond_0
    const/4 v0, 0x0

    .line 141
    :goto_0
    return-object v0

    :cond_1
    const/4 v1, 0x0

    aget-object v0, v0, v1

    check-cast v0, Ljavax/mail/internet/InternetAddress;

    invoke-virtual {v0}, Ljavax/mail/internet/InternetAddress;->getAddress()Ljava/lang/String;

    move-result-object v0

    goto :goto_0
.end method

.method public f()Ljava/lang/String;
    .locals 2
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljava/lang/Exception;
        }
    .end annotation

    .prologue
    .line 150
    iget-object v0, p0, Lorg/apache/commons/mail/b/a;->a:Ljavax/mail/internet/MimeMessage;

    invoke-virtual {v0}, Ljavax/mail/internet/MimeMessage;->getReplyTo()[Ljavax/mail/Address;

    move-result-object v0

    .line 151
    if-eqz v0, :cond_0

    array-length v1, v0

    if-nez v1, :cond_1

    .line 153
    :cond_0
    const/4 v0, 0x0

    .line 155
    :goto_0
    return-object v0

    :cond_1
    const/4 v1, 0x0

    aget-object v0, v0, v1

    check-cast v0, Ljavax/mail/internet/InternetAddress;

    invoke-virtual {v0}, Ljavax/mail/internet/InternetAddress;->getAddress()Ljava/lang/String;

    move-result-object v0

    goto :goto_0
.end method

.method public g()Ljava/lang/String;
    .locals 1
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljava/lang/Exception;
        }
    .end annotation

    .prologue
    .line 164
    iget-object v0, p0, Lorg/apache/commons/mail/b/a;->a:Ljavax/mail/internet/MimeMessage;

    invoke-virtual {v0}, Ljavax/mail/internet/MimeMessage;->getSubject()Ljava/lang/String;

    move-result-object v0

    return-object v0
.end method

.method public h()Ljavax/mail/internet/MimeMessage;
    .locals 1

    .prologue
    .line 285
    iget-object v0, p0, Lorg/apache/commons/mail/b/a;->a:Ljavax/mail/internet/MimeMessage;

    return-object v0
.end method

.method public i()Z
    .locals 1

    .prologue
    .line 291
    iget-boolean v0, p0, Lorg/apache/commons/mail/b/a;->f:Z

    return v0
.end method

.method public j()Ljava/lang/String;
    .locals 1

    .prologue
    .line 297
    iget-object v0, p0, Lorg/apache/commons/mail/b/a;->b:Ljava/lang/String;

    return-object v0
.end method

.method public k()Ljava/util/List;
    .locals 1
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "()",
            "Ljava/util/List",
            "<",
            "Ljavax/activation/DataSource;",
            ">;"
        }
    .end annotation

    .prologue
    .line 303
    iget-object v0, p0, Lorg/apache/commons/mail/b/a;->d:Ljava/util/List;

    return-object v0
.end method

.method public l()Ljava/util/Collection;
    .locals 1
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "()",
            "Ljava/util/Collection",
            "<",
            "Ljava/lang/String;",
            ">;"
        }
    .end annotation

    .prologue
    .line 317
    iget-object v0, p0, Lorg/apache/commons/mail/b/a;->e:Ljava/util/Map;

    invoke-interface {v0}, Ljava/util/Map;->keySet()Ljava/util/Set;

    move-result-object v0

    invoke-static {v0}, Ljava/util/Collections;->unmodifiableSet(Ljava/util/Set;)Ljava/util/Set;

    move-result-object v0

    return-object v0
.end method

.method public m()Ljava/lang/String;
    .locals 1

    .prologue
    .line 323
    iget-object v0, p0, Lorg/apache/commons/mail/b/a;->c:Ljava/lang/String;

    return-object v0
.end method

.method public n()Z
    .locals 1

    .prologue
    .line 329
    iget-object v0, p0, Lorg/apache/commons/mail/b/a;->b:Ljava/lang/String;

    if-eqz v0, :cond_0

    const/4 v0, 0x1

    :goto_0
    return v0

    :cond_0
    const/4 v0, 0x0

    goto :goto_0
.end method

.method public o()Z
    .locals 1

    .prologue
    .line 335
    iget-object v0, p0, Lorg/apache/commons/mail/b/a;->c:Ljava/lang/String;

    if-eqz v0, :cond_0

    const/4 v0, 0x1

    :goto_0
    return v0

    :cond_0
    const/4 v0, 0x0

    goto :goto_0
.end method

.method public p()Z
    .locals 1

    .prologue
    .line 341
    iget-object v0, p0, Lorg/apache/commons/mail/b/a;->d:Ljava/util/List;

    invoke-interface {v0}, Ljava/util/List;->size()I

    move-result v0

    if-lez v0, :cond_0

    const/4 v0, 0x1

    :goto_0
    return v0

    :cond_0
    const/4 v0, 0x0

    goto :goto_0
.end method
