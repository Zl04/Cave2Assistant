.class public Lcom/sun/mail/dsn/text_rfc822headers;
.super Ljava/lang/Object;
.source "SourceFile"

# interfaces
.implements Ljavax/activation/DataContentHandler;


# static fields
.field private static myDF:Ljavax/activation/ActivationDataFlavor;

.field private static myDFs:Ljavax/activation/ActivationDataFlavor;


# direct methods
.method static constructor <clinit>()V
    .locals 4

    .prologue
    .line 55
    new-instance v0, Ljavax/activation/ActivationDataFlavor;

    .line 56
    const-class v1, Lcom/sun/mail/dsn/MessageHeaders;

    .line 57
    const-string v2, "text/rfc822-headers"

    .line 58
    const-string v3, "RFC822 headers"

    .line 55
    invoke-direct {v0, v1, v2, v3}, Ljavax/activation/ActivationDataFlavor;-><init>(Ljava/lang/Class;Ljava/lang/String;Ljava/lang/String;)V

    sput-object v0, Lcom/sun/mail/dsn/text_rfc822headers;->myDF:Ljavax/activation/ActivationDataFlavor;

    .line 59
    new-instance v0, Ljavax/activation/ActivationDataFlavor;

    .line 60
    const-class v1, Ljava/lang/String;

    .line 61
    const-string v2, "text/rfc822-headers"

    .line 62
    const-string v3, "RFC822 headers"

    .line 59
    invoke-direct {v0, v1, v2, v3}, Ljavax/activation/ActivationDataFlavor;-><init>(Ljava/lang/Class;Ljava/lang/String;Ljava/lang/String;)V

    sput-object v0, Lcom/sun/mail/dsn/text_rfc822headers;->myDFs:Ljavax/activation/ActivationDataFlavor;

    .line 54
    return-void
.end method

.method public constructor <init>()V
    .locals 0

    .prologue
    .line 54
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method

.method private getCharset(Ljava/lang/String;)Ljava/lang/String;
    .locals 2

    .prologue
    .line 188
    :try_start_0
    new-instance v0, Ljavax/mail/internet/ContentType;

    invoke-direct {v0, p1}, Ljavax/mail/internet/ContentType;-><init>(Ljava/lang/String;)V

    .line 189
    const-string v1, "charset"

    invoke-virtual {v0, v1}, Ljavax/mail/internet/ContentType;->getParameter(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v0

    .line 190
    if-nez v0, :cond_0

    .line 192
    const-string v0, "us-ascii"

    .line 193
    :cond_0
    invoke-static {v0}, Ljavax/mail/internet/MimeUtility;->javaCharset(Ljava/lang/String;)Ljava/lang/String;
    :try_end_0
    .catch Ljava/lang/Exception; {:try_start_0 .. :try_end_0} :catch_0

    move-result-object v0

    .line 195
    :goto_0
    return-object v0

    .line 194
    :catch_0
    move-exception v0

    .line 195
    const/4 v0, 0x0

    goto :goto_0
.end method

.method private getStringContent(Ljavax/activation/DataSource;)Ljava/lang/Object;
    .locals 7
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljava/io/IOException;
        }
    .end annotation

    .prologue
    const/high16 v6, 0x40000

    const/4 v2, 0x0

    .line 102
    const/4 v0, 0x0

    .line 106
    :try_start_0
    invoke-interface {p1}, Ljavax/activation/DataSource;->getContentType()Ljava/lang/String;

    move-result-object v1

    invoke-direct {p0, v1}, Lcom/sun/mail/dsn/text_rfc822headers;->getCharset(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v0

    .line 107
    new-instance v4, Ljava/io/InputStreamReader;

    invoke-interface {p1}, Ljavax/activation/DataSource;->getInputStream()Ljava/io/InputStream;

    move-result-object v1

    invoke-direct {v4, v1, v0}, Ljava/io/InputStreamReader;-><init>(Ljava/io/InputStream;Ljava/lang/String;)V
    :try_end_0
    .catch Ljava/lang/IllegalArgumentException; {:try_start_0 .. :try_end_0} :catch_0

    .line 122
    const/16 v0, 0x400

    new-array v0, v0, [C

    move v1, v2

    .line 124
    :goto_0
    array-length v3, v0

    sub-int/2addr v3, v1

    invoke-virtual {v4, v0, v1, v3}, Ljava/io/InputStreamReader;->read([CII)I

    move-result v3

    const/4 v5, -0x1

    if-ne v3, v5, :cond_0

    .line 137
    new-instance v3, Ljava/lang/String;

    invoke-direct {v3, v0, v2, v1}, Ljava/lang/String;-><init>([CII)V

    return-object v3

    .line 108
    :catch_0
    move-exception v1

    .line 117
    new-instance v1, Ljava/io/UnsupportedEncodingException;

    invoke-direct {v1, v0}, Ljava/io/UnsupportedEncodingException;-><init>(Ljava/lang/String;)V

    throw v1

    .line 125
    :cond_0
    add-int/2addr v3, v1

    .line 126
    array-length v1, v0

    if-lt v3, v1, :cond_2

    .line 127
    array-length v1, v0

    .line 128
    if-ge v1, v6, :cond_1

    .line 129
    add-int/2addr v1, v1

    .line 132
    :goto_1
    new-array v1, v1, [C

    .line 133
    invoke-static {v0, v2, v1, v2, v3}, Ljava/lang/System;->arraycopy(Ljava/lang/Object;ILjava/lang/Object;II)V

    move-object v0, v1

    move v1, v3

    .line 134
    goto :goto_0

    .line 131
    :cond_1
    add-int/2addr v1, v6

    goto :goto_1

    :cond_2
    move v1, v3

    goto :goto_0
.end method


# virtual methods
.method public getContent(Ljavax/activation/DataSource;)Ljava/lang/Object;
    .locals 4
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljava/io/IOException;
        }
    .end annotation

    .prologue
    .line 94
    :try_start_0
    new-instance v0, Lcom/sun/mail/dsn/MessageHeaders;

    invoke-interface {p1}, Ljavax/activation/DataSource;->getInputStream()Ljava/io/InputStream;

    move-result-object v1

    invoke-direct {v0, v1}, Lcom/sun/mail/dsn/MessageHeaders;-><init>(Ljava/io/InputStream;)V
    :try_end_0
    .catch Ljavax/mail/MessagingException; {:try_start_0 .. :try_end_0} :catch_0

    return-object v0

    .line 95
    :catch_0
    move-exception v0

    .line 97
    new-instance v1, Ljava/io/IOException;

    new-instance v2, Ljava/lang/StringBuilder;

    const-string v3, "Exception creating MessageHeaders: "

    invoke-direct {v2, v3}, Ljava/lang/StringBuilder;-><init>(Ljava/lang/String;)V

    invoke-virtual {v2, v0}, Ljava/lang/StringBuilder;->append(Ljava/lang/Object;)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-virtual {v0}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v0

    invoke-direct {v1, v0}, Ljava/io/IOException;-><init>(Ljava/lang/String;)V

    throw v1
.end method

.method public getTransferData(Lmyjava/awt/datatransfer/DataFlavor;Ljavax/activation/DataSource;)Ljava/lang/Object;
    .locals 1
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljava/io/IOException;
        }
    .end annotation

    .prologue
    .line 84
    sget-object v0, Lcom/sun/mail/dsn/text_rfc822headers;->myDF:Ljavax/activation/ActivationDataFlavor;

    invoke-virtual {v0, p1}, Ljavax/activation/ActivationDataFlavor;->equals(Lmyjava/awt/datatransfer/DataFlavor;)Z

    move-result v0

    if-eqz v0, :cond_0

    .line 85
    invoke-virtual {p0, p2}, Lcom/sun/mail/dsn/text_rfc822headers;->getContent(Ljavax/activation/DataSource;)Ljava/lang/Object;

    move-result-object v0

    .line 89
    :goto_0
    return-object v0

    .line 86
    :cond_0
    sget-object v0, Lcom/sun/mail/dsn/text_rfc822headers;->myDFs:Ljavax/activation/ActivationDataFlavor;

    invoke-virtual {v0, p1}, Ljavax/activation/ActivationDataFlavor;->equals(Lmyjava/awt/datatransfer/DataFlavor;)Z

    move-result v0

    if-eqz v0, :cond_1

    .line 87
    invoke-direct {p0, p2}, Lcom/sun/mail/dsn/text_rfc822headers;->getStringContent(Ljavax/activation/DataSource;)Ljava/lang/Object;

    move-result-object v0

    goto :goto_0

    .line 89
    :cond_1
    const/4 v0, 0x0

    goto :goto_0
.end method

.method public getTransferDataFlavors()[Lmyjava/awt/datatransfer/DataFlavor;
    .locals 3

    .prologue
    .line 70
    const/4 v0, 0x2

    new-array v0, v0, [Lmyjava/awt/datatransfer/DataFlavor;

    const/4 v1, 0x0

    sget-object v2, Lcom/sun/mail/dsn/text_rfc822headers;->myDF:Ljavax/activation/ActivationDataFlavor;

    aput-object v2, v0, v1

    const/4 v1, 0x1

    sget-object v2, Lcom/sun/mail/dsn/text_rfc822headers;->myDFs:Ljavax/activation/ActivationDataFlavor;

    aput-object v2, v0, v1

    return-object v0
.end method

.method public writeTo(Ljava/lang/Object;Ljava/lang/String;Ljava/io/OutputStream;)V
    .locals 4
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljava/io/IOException;
        }
    .end annotation

    .prologue
    .line 145
    instance-of v0, p1, Lcom/sun/mail/dsn/MessageHeaders;

    if-eqz v0, :cond_1

    .line 146
    check-cast p1, Lcom/sun/mail/dsn/MessageHeaders;

    .line 148
    :try_start_0
    invoke-virtual {p1, p3}, Lcom/sun/mail/dsn/MessageHeaders;->writeTo(Ljava/io/OutputStream;)V
    :try_end_0
    .catch Ljavax/mail/MessagingException; {:try_start_0 .. :try_end_0} :catch_0

    .line 184
    :goto_0
    return-void

    .line 149
    :catch_0
    move-exception v1

    .line 150
    invoke-virtual {v1}, Ljavax/mail/MessagingException;->getNextException()Ljava/lang/Exception;

    move-result-object v0

    .line 151
    instance-of v2, v0, Ljava/io/IOException;

    if-eqz v2, :cond_0

    .line 152
    check-cast v0, Ljava/io/IOException;

    throw v0

    .line 154
    :cond_0
    new-instance v0, Ljava/io/IOException;

    new-instance v2, Ljava/lang/StringBuilder;

    const-string v3, "Exception writing headers: "

    invoke-direct {v2, v3}, Ljava/lang/StringBuilder;-><init>(Ljava/lang/String;)V

    invoke-virtual {v2, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/Object;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v1

    invoke-direct {v0, v1}, Ljava/io/IOException;-><init>(Ljava/lang/String;)V

    throw v0

    .line 158
    :cond_1
    instance-of v0, p1, Ljava/lang/String;

    if-nez v0, :cond_2

    .line 159
    new-instance v0, Ljava/io/IOException;

    new-instance v1, Ljava/lang/StringBuilder;

    const-string v2, "\""

    invoke-direct {v1, v2}, Ljava/lang/StringBuilder;-><init>(Ljava/lang/String;)V

    sget-object v2, Lcom/sun/mail/dsn/text_rfc822headers;->myDFs:Ljavax/activation/ActivationDataFlavor;

    invoke-virtual {v2}, Ljavax/activation/ActivationDataFlavor;->getMimeType()Ljava/lang/String;

    move-result-object v2

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    .line 160
    const-string v2, "\" DataContentHandler requires String object, "

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    .line 161
    const-string v2, "was given object of type "

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {p1}, Ljava/lang/Object;->getClass()Ljava/lang/Class;

    move-result-object v2

    invoke-virtual {v2}, Ljava/lang/Class;->toString()Ljava/lang/String;

    move-result-object v2

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v1

    .line 159
    invoke-direct {v0, v1}, Ljava/io/IOException;-><init>(Ljava/lang/String;)V

    throw v0

    .line 163
    :cond_2
    const/4 v0, 0x0

    .line 167
    :try_start_1
    invoke-direct {p0, p2}, Lcom/sun/mail/dsn/text_rfc822headers;->getCharset(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v0

    .line 168
    new-instance v1, Ljava/io/OutputStreamWriter;

    invoke-direct {v1, p3, v0}, Ljava/io/OutputStreamWriter;-><init>(Ljava/io/OutputStream;Ljava/lang/String;)V
    :try_end_1
    .catch Ljava/lang/IllegalArgumentException; {:try_start_1 .. :try_end_1} :catch_1

    .line 181
    check-cast p1, Ljava/lang/String;

    .line 182
    const/4 v0, 0x0

    invoke-virtual {p1}, Ljava/lang/String;->length()I

    move-result v2

    invoke-virtual {v1, p1, v0, v2}, Ljava/io/OutputStreamWriter;->write(Ljava/lang/String;II)V

    .line 183
    invoke-virtual {v1}, Ljava/io/OutputStreamWriter;->flush()V

    goto :goto_0

    .line 169
    :catch_1
    move-exception v1

    .line 178
    new-instance v1, Ljava/io/UnsupportedEncodingException;

    invoke-direct {v1, v0}, Ljava/io/UnsupportedEncodingException;-><init>(Ljava/lang/String;)V

    throw v1
.end method
