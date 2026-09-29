.class public Lcom/sun/mail/handlers/text_plain;
.super Ljava/lang/Object;
.source "SourceFile"

# interfaces
.implements Ljavax/activation/DataContentHandler;


# static fields
.field private static myDF:Ljavax/activation/ActivationDataFlavor;


# direct methods
.method static constructor <clinit>()V
    .locals 4

    .prologue
    .line 54
    new-instance v0, Ljavax/activation/ActivationDataFlavor;

    .line 55
    const-class v1, Ljava/lang/String;

    .line 56
    const-string v2, "text/plain"

    .line 57
    const-string v3, "Text String"

    .line 54
    invoke-direct {v0, v1, v2, v3}, Ljavax/activation/ActivationDataFlavor;-><init>(Ljava/lang/Class;Ljava/lang/String;Ljava/lang/String;)V

    sput-object v0, Lcom/sun/mail/handlers/text_plain;->myDF:Ljavax/activation/ActivationDataFlavor;

    .line 53
    return-void
.end method

.method public constructor <init>()V
    .locals 0

    .prologue
    .line 53
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method

.method private getCharset(Ljava/lang/String;)Ljava/lang/String;
    .locals 2

    .prologue
    .line 169
    :try_start_0
    new-instance v0, Ljavax/mail/internet/ContentType;

    invoke-direct {v0, p1}, Ljavax/mail/internet/ContentType;-><init>(Ljava/lang/String;)V

    .line 170
    const-string v1, "charset"

    invoke-virtual {v0, v1}, Ljavax/mail/internet/ContentType;->getParameter(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v0

    .line 171
    if-nez v0, :cond_0

    .line 173
    const-string v0, "us-ascii"

    .line 174
    :cond_0
    invoke-static {v0}, Ljavax/mail/internet/MimeUtility;->javaCharset(Ljava/lang/String;)Ljava/lang/String;
    :try_end_0
    .catch Ljava/lang/Exception; {:try_start_0 .. :try_end_0} :catch_0

    move-result-object v0

    .line 176
    :goto_0
    return-object v0

    .line 175
    :catch_0
    move-exception v0

    .line 176
    const/4 v0, 0x0

    goto :goto_0
.end method


# virtual methods
.method public getContent(Ljavax/activation/DataSource;)Ljava/lang/Object;
    .locals 8
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljava/io/IOException;
        }
    .end annotation

    .prologue
    const/high16 v6, 0x40000

    const/4 v1, 0x0

    .line 90
    const/4 v0, 0x0

    .line 94
    :try_start_0
    invoke-interface {p1}, Ljavax/activation/DataSource;->getContentType()Ljava/lang/String;

    move-result-object v2

    invoke-direct {p0, v2}, Lcom/sun/mail/handlers/text_plain;->getCharset(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v0

    .line 95
    new-instance v3, Ljava/io/InputStreamReader;

    invoke-interface {p1}, Ljavax/activation/DataSource;->getInputStream()Ljava/io/InputStream;

    move-result-object v2

    invoke-direct {v3, v2, v0}, Ljava/io/InputStreamReader;-><init>(Ljava/io/InputStream;Ljava/lang/String;)V
    :try_end_0
    .catch Ljava/lang/IllegalArgumentException; {:try_start_0 .. :try_end_0} :catch_0

    .line 111
    const/16 v0, 0x400

    :try_start_1
    new-array v0, v0, [C

    move-object v7, v0

    move v0, v1

    move-object v1, v7

    .line 113
    :goto_0
    array-length v2, v1

    sub-int/2addr v2, v0

    invoke-virtual {v3, v1, v0, v2}, Ljava/io/InputStreamReader;->read([CII)I

    move-result v2

    const/4 v4, -0x1

    if-ne v2, v4, :cond_0

    .line 126
    new-instance v2, Ljava/lang/String;

    const/4 v4, 0x0

    invoke-direct {v2, v1, v4, v0}, Ljava/lang/String;-><init>([CII)V
    :try_end_1
    .catchall {:try_start_1 .. :try_end_1} :catchall_0

    .line 129
    :try_start_2
    invoke-virtual {v3}, Ljava/io/InputStreamReader;->close()V
    :try_end_2
    .catch Ljava/io/IOException; {:try_start_2 .. :try_end_2} :catch_1

    .line 126
    :goto_1
    return-object v2

    .line 96
    :catch_0
    move-exception v1

    .line 105
    new-instance v1, Ljava/io/UnsupportedEncodingException;

    invoke-direct {v1, v0}, Ljava/io/UnsupportedEncodingException;-><init>(Ljava/lang/String;)V

    throw v1

    .line 114
    :cond_0
    add-int/2addr v2, v0

    .line 115
    :try_start_3
    array-length v0, v1

    if-lt v2, v0, :cond_2

    .line 116
    array-length v0, v1

    .line 117
    if-ge v0, v6, :cond_1

    .line 118
    add-int/2addr v0, v0

    .line 121
    :goto_2
    new-array v0, v0, [C

    .line 122
    const/4 v4, 0x0

    const/4 v5, 0x0

    invoke-static {v1, v4, v0, v5, v2}, Ljava/lang/System;->arraycopy(Ljava/lang/Object;ILjava/lang/Object;II)V
    :try_end_3
    .catchall {:try_start_3 .. :try_end_3} :catchall_0

    move-object v1, v0

    move v0, v2

    .line 123
    goto :goto_0

    .line 120
    :cond_1
    add-int/2addr v0, v6

    goto :goto_2

    .line 127
    :catchall_0
    move-exception v0

    .line 129
    :try_start_4
    invoke-virtual {v3}, Ljava/io/InputStreamReader;->close()V
    :try_end_4
    .catch Ljava/io/IOException; {:try_start_4 .. :try_end_4} :catch_2

    .line 131
    :goto_3
    throw v0

    .line 130
    :catch_1
    move-exception v0

    goto :goto_1

    :catch_2
    move-exception v1

    goto :goto_3

    :cond_2
    move v0, v2

    goto :goto_0
.end method

.method protected getDF()Ljavax/activation/ActivationDataFlavor;
    .locals 1

    .prologue
    .line 60
    sget-object v0, Lcom/sun/mail/handlers/text_plain;->myDF:Ljavax/activation/ActivationDataFlavor;

    return-object v0
.end method

.method public getTransferData(Lmyjava/awt/datatransfer/DataFlavor;Ljavax/activation/DataSource;)Ljava/lang/Object;
    .locals 1
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljava/io/IOException;
        }
    .end annotation

    .prologue
    .line 83
    invoke-virtual {p0}, Lcom/sun/mail/handlers/text_plain;->getDF()Ljavax/activation/ActivationDataFlavor;

    move-result-object v0

    invoke-virtual {v0, p1}, Ljavax/activation/ActivationDataFlavor;->equals(Lmyjava/awt/datatransfer/DataFlavor;)Z

    move-result v0

    if-eqz v0, :cond_0

    .line 84
    invoke-virtual {p0, p2}, Lcom/sun/mail/handlers/text_plain;->getContent(Ljavax/activation/DataSource;)Ljava/lang/Object;

    move-result-object v0

    .line 86
    :goto_0
    return-object v0

    :cond_0
    const/4 v0, 0x0

    goto :goto_0
.end method

.method public getTransferDataFlavors()[Lmyjava/awt/datatransfer/DataFlavor;
    .locals 3

    .prologue
    .line 69
    const/4 v0, 0x1

    new-array v0, v0, [Lmyjava/awt/datatransfer/DataFlavor;

    const/4 v1, 0x0

    invoke-virtual {p0}, Lcom/sun/mail/handlers/text_plain;->getDF()Ljavax/activation/ActivationDataFlavor;

    move-result-object v2

    aput-object v2, v0, v1

    return-object v0
.end method

.method public writeTo(Ljava/lang/Object;Ljava/lang/String;Ljava/io/OutputStream;)V
    .locals 3
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljava/io/IOException;
        }
    .end annotation

    .prologue
    .line 139
    instance-of v0, p1, Ljava/lang/String;

    if-nez v0, :cond_0

    .line 140
    new-instance v0, Ljava/io/IOException;

    new-instance v1, Ljava/lang/StringBuilder;

    const-string v2, "\""

    invoke-direct {v1, v2}, Ljava/lang/StringBuilder;-><init>(Ljava/lang/String;)V

    invoke-virtual {p0}, Lcom/sun/mail/handlers/text_plain;->getDF()Ljavax/activation/ActivationDataFlavor;

    move-result-object v2

    invoke-virtual {v2}, Ljavax/activation/ActivationDataFlavor;->getMimeType()Ljava/lang/String;

    move-result-object v2

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    .line 141
    const-string v2, "\" DataContentHandler requires String object, "

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    .line 142
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

    .line 140
    invoke-direct {v0, v1}, Ljava/io/IOException;-><init>(Ljava/lang/String;)V

    throw v0

    .line 144
    :cond_0
    const/4 v0, 0x0

    .line 148
    :try_start_0
    invoke-direct {p0, p2}, Lcom/sun/mail/handlers/text_plain;->getCharset(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v0

    .line 149
    new-instance v1, Ljava/io/OutputStreamWriter;

    invoke-direct {v1, p3, v0}, Ljava/io/OutputStreamWriter;-><init>(Ljava/io/OutputStream;Ljava/lang/String;)V
    :try_end_0
    .catch Ljava/lang/IllegalArgumentException; {:try_start_0 .. :try_end_0} :catch_0

    .line 162
    check-cast p1, Ljava/lang/String;

    .line 163
    const/4 v0, 0x0

    invoke-virtual {p1}, Ljava/lang/String;->length()I

    move-result v2

    invoke-virtual {v1, p1, v0, v2}, Ljava/io/OutputStreamWriter;->write(Ljava/lang/String;II)V

    .line 164
    invoke-virtual {v1}, Ljava/io/OutputStreamWriter;->flush()V

    .line 165
    return-void

    .line 150
    :catch_0
    move-exception v1

    .line 159
    new-instance v1, Ljava/io/UnsupportedEncodingException;

    invoke-direct {v1, v0}, Ljava/io/UnsupportedEncodingException;-><init>(Ljava/lang/String;)V

    throw v1
.end method
