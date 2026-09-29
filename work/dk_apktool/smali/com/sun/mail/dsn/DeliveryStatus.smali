.class public Lcom/sun/mail/dsn/DeliveryStatus;
.super Ljava/lang/Object;
.source "SourceFile"


# static fields
.field private static debug:Z


# instance fields
.field protected messageDSN:Ljavax/mail/internet/InternetHeaders;

.field protected recipientDSN:[Ljavax/mail/internet/InternetHeaders;


# direct methods
.method static constructor <clinit>()V
    .locals 3

    .prologue
    const/4 v0, 0x0

    .line 58
    sput-boolean v0, Lcom/sun/mail/dsn/DeliveryStatus;->debug:Z

    .line 62
    :try_start_0
    const-string v1, "mail.dsn.debug"

    invoke-static {v1}, Ljava/lang/System;->getProperty(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v1

    .line 64
    if-eqz v1, :cond_0

    const-string v2, "false"

    invoke-virtual {v1, v2}, Ljava/lang/String;->equalsIgnoreCase(Ljava/lang/String;)Z

    move-result v1

    if-nez v1, :cond_0

    const/4 v0, 0x1

    :cond_0
    sput-boolean v0, Lcom/sun/mail/dsn/DeliveryStatus;->debug:Z
    :try_end_0
    .catch Ljava/lang/SecurityException; {:try_start_0 .. :try_end_0} :catch_0

    .line 56
    :goto_0
    return-void

    .line 65
    :catch_0
    move-exception v0

    goto :goto_0
.end method

.method public constructor <init>()V
    .locals 1
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljavax/mail/MessagingException;
        }
    .end annotation

    .prologue
    .line 83
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    .line 84
    new-instance v0, Ljavax/mail/internet/InternetHeaders;

    invoke-direct {v0}, Ljavax/mail/internet/InternetHeaders;-><init>()V

    iput-object v0, p0, Lcom/sun/mail/dsn/DeliveryStatus;->messageDSN:Ljavax/mail/internet/InternetHeaders;

    .line 85
    const/4 v0, 0x0

    new-array v0, v0, [Ljavax/mail/internet/InternetHeaders;

    iput-object v0, p0, Lcom/sun/mail/dsn/DeliveryStatus;->recipientDSN:[Ljavax/mail/internet/InternetHeaders;

    .line 86
    return-void
.end method

.method public constructor <init>(Ljava/io/InputStream;)V
    .locals 4
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljavax/mail/MessagingException;,
            Ljava/io/IOException;
        }
    .end annotation

    .prologue
    .line 92
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    .line 94
    new-instance v0, Ljavax/mail/internet/InternetHeaders;

    invoke-direct {v0, p1}, Ljavax/mail/internet/InternetHeaders;-><init>(Ljava/io/InputStream;)V

    iput-object v0, p0, Lcom/sun/mail/dsn/DeliveryStatus;->messageDSN:Ljavax/mail/internet/InternetHeaders;

    .line 95
    sget-boolean v0, Lcom/sun/mail/dsn/DeliveryStatus;->debug:Z

    if-eqz v0, :cond_0

    .line 96
    sget-object v0, Ljava/lang/System;->out:Ljava/io/PrintStream;

    const-string v1, "DSN: got messageDSN"

    invoke-virtual {v0, v1}, Ljava/io/PrintStream;->println(Ljava/lang/String;)V

    .line 97
    :cond_0
    new-instance v0, Ljava/util/Vector;

    invoke-direct {v0}, Ljava/util/Vector;-><init>()V

    .line 99
    :goto_0
    :try_start_0
    invoke-virtual {p1}, Ljava/io/InputStream;->available()I
    :try_end_0
    .catch Ljava/io/EOFException; {:try_start_0 .. :try_end_0} :catch_0

    move-result v1

    if-gtz v1, :cond_3

    .line 109
    :cond_1
    :goto_1
    sget-boolean v1, Lcom/sun/mail/dsn/DeliveryStatus;->debug:Z

    if-eqz v1, :cond_2

    .line 110
    sget-object v1, Ljava/lang/System;->out:Ljava/io/PrintStream;

    new-instance v2, Ljava/lang/StringBuilder;

    const-string v3, "DSN: recipientDSN size "

    invoke-direct {v2, v3}, Ljava/lang/StringBuilder;-><init>(Ljava/lang/String;)V

    invoke-virtual {v0}, Ljava/util/Vector;->size()I

    move-result v3

    invoke-virtual {v2, v3}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v2

    invoke-virtual {v2}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v2

    invoke-virtual {v1, v2}, Ljava/io/PrintStream;->println(Ljava/lang/String;)V

    .line 111
    :cond_2
    invoke-virtual {v0}, Ljava/util/Vector;->size()I

    move-result v1

    new-array v1, v1, [Ljavax/mail/internet/InternetHeaders;

    iput-object v1, p0, Lcom/sun/mail/dsn/DeliveryStatus;->recipientDSN:[Ljavax/mail/internet/InternetHeaders;

    .line 112
    iget-object v1, p0, Lcom/sun/mail/dsn/DeliveryStatus;->recipientDSN:[Ljavax/mail/internet/InternetHeaders;

    invoke-virtual {v0, v1}, Ljava/util/Vector;->copyInto([Ljava/lang/Object;)V

    .line 113
    return-void

    .line 100
    :cond_3
    :try_start_1
    new-instance v1, Ljavax/mail/internet/InternetHeaders;

    invoke-direct {v1, p1}, Ljavax/mail/internet/InternetHeaders;-><init>(Ljava/io/InputStream;)V

    .line 101
    sget-boolean v2, Lcom/sun/mail/dsn/DeliveryStatus;->debug:Z

    if-eqz v2, :cond_4

    .line 102
    sget-object v2, Ljava/lang/System;->out:Ljava/io/PrintStream;

    const-string v3, "DSN: got recipientDSN"

    invoke-virtual {v2, v3}, Ljava/io/PrintStream;->println(Ljava/lang/String;)V

    .line 103
    :cond_4
    invoke-virtual {v0, v1}, Ljava/util/Vector;->addElement(Ljava/lang/Object;)V
    :try_end_1
    .catch Ljava/io/EOFException; {:try_start_1 .. :try_end_1} :catch_0

    goto :goto_0

    .line 105
    :catch_0
    move-exception v1

    .line 106
    sget-boolean v1, Lcom/sun/mail/dsn/DeliveryStatus;->debug:Z

    if-eqz v1, :cond_1

    .line 107
    sget-object v1, Ljava/lang/System;->out:Ljava/io/PrintStream;

    const-string v2, "DSN: got EOFException"

    invoke-virtual {v1, v2}, Ljava/io/PrintStream;->println(Ljava/lang/String;)V

    goto :goto_1
.end method

.method private static writeInternetHeaders(Ljavax/mail/internet/InternetHeaders;Lcom/sun/mail/util/LineOutputStream;)V
    .locals 4
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljava/io/IOException;
        }
    .end annotation

    .prologue
    .line 188
    invoke-virtual {p0}, Ljavax/mail/internet/InternetHeaders;->getAllHeaderLines()Ljava/util/Enumeration;

    move-result-object v1

    .line 190
    :goto_0
    :try_start_0
    invoke-interface {v1}, Ljava/util/Enumeration;->hasMoreElements()Z

    move-result v0

    if-nez v0, :cond_0

    .line 199
    return-void

    .line 191
    :cond_0
    invoke-interface {v1}, Ljava/util/Enumeration;->nextElement()Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Ljava/lang/String;

    invoke-virtual {p1, v0}, Lcom/sun/mail/util/LineOutputStream;->writeln(Ljava/lang/String;)V
    :try_end_0
    .catch Ljavax/mail/MessagingException; {:try_start_0 .. :try_end_0} :catch_0

    goto :goto_0

    .line 192
    :catch_0
    move-exception v0

    move-object v1, v0

    .line 193
    invoke-virtual {v1}, Ljavax/mail/MessagingException;->getNextException()Ljava/lang/Exception;

    move-result-object v0

    .line 194
    instance-of v2, v0, Ljava/io/IOException;

    if-eqz v2, :cond_1

    .line 195
    check-cast v0, Ljava/io/IOException;

    throw v0

    .line 197
    :cond_1
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
.end method


# virtual methods
.method public addRecipientDSN(Ljavax/mail/internet/InternetHeaders;)V
    .locals 4

    .prologue
    const/4 v3, 0x0

    .line 162
    iget-object v0, p0, Lcom/sun/mail/dsn/DeliveryStatus;->recipientDSN:[Ljavax/mail/internet/InternetHeaders;

    array-length v0, v0

    add-int/lit8 v0, v0, 0x1

    new-array v0, v0, [Ljavax/mail/internet/InternetHeaders;

    .line 163
    iget-object v1, p0, Lcom/sun/mail/dsn/DeliveryStatus;->recipientDSN:[Ljavax/mail/internet/InternetHeaders;

    iget-object v2, p0, Lcom/sun/mail/dsn/DeliveryStatus;->recipientDSN:[Ljavax/mail/internet/InternetHeaders;

    array-length v2, v2

    invoke-static {v1, v3, v0, v3, v2}, Ljava/lang/System;->arraycopy(Ljava/lang/Object;ILjava/lang/Object;II)V

    .line 164
    iput-object v0, p0, Lcom/sun/mail/dsn/DeliveryStatus;->recipientDSN:[Ljavax/mail/internet/InternetHeaders;

    .line 165
    iget-object v0, p0, Lcom/sun/mail/dsn/DeliveryStatus;->recipientDSN:[Ljavax/mail/internet/InternetHeaders;

    iget-object v1, p0, Lcom/sun/mail/dsn/DeliveryStatus;->recipientDSN:[Ljavax/mail/internet/InternetHeaders;

    array-length v1, v1

    add-int/lit8 v1, v1, -0x1

    aput-object p1, v0, v1

    .line 166
    return-void
.end method

.method public getMessageDSN()Ljavax/mail/internet/InternetHeaders;
    .locals 1

    .prologue
    .line 131
    iget-object v0, p0, Lcom/sun/mail/dsn/DeliveryStatus;->messageDSN:Ljavax/mail/internet/InternetHeaders;

    return-object v0
.end method

.method public getRecipientDSN(I)Ljavax/mail/internet/InternetHeaders;
    .locals 1

    .prologue
    .line 154
    iget-object v0, p0, Lcom/sun/mail/dsn/DeliveryStatus;->recipientDSN:[Ljavax/mail/internet/InternetHeaders;

    aget-object v0, v0, p1

    return-object v0
.end method

.method public getRecipientDSNCount()I
    .locals 1

    .prologue
    .line 146
    iget-object v0, p0, Lcom/sun/mail/dsn/DeliveryStatus;->recipientDSN:[Ljavax/mail/internet/InternetHeaders;

    array-length v0, v0

    return v0
.end method

.method public setMessageDSN(Ljavax/mail/internet/InternetHeaders;)V
    .locals 0

    .prologue
    .line 138
    iput-object p1, p0, Lcom/sun/mail/dsn/DeliveryStatus;->messageDSN:Ljavax/mail/internet/InternetHeaders;

    .line 139
    return-void
.end method

.method public toString()Ljava/lang/String;
    .locals 4

    .prologue
    .line 202
    new-instance v0, Ljava/lang/StringBuilder;

    const-string v1, "DeliveryStatus: Reporting-MTA="

    invoke-direct {v0, v1}, Ljava/lang/StringBuilder;-><init>(Ljava/lang/String;)V

    .line 203
    iget-object v1, p0, Lcom/sun/mail/dsn/DeliveryStatus;->messageDSN:Ljavax/mail/internet/InternetHeaders;

    const-string v2, "Reporting-MTA"

    const/4 v3, 0x0

    invoke-virtual {v1, v2, v3}, Ljavax/mail/internet/InternetHeaders;->getHeader(Ljava/lang/String;Ljava/lang/String;)Ljava/lang/String;

    move-result-object v1

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    const-string v1, ", #Recipients="

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    .line 204
    iget-object v1, p0, Lcom/sun/mail/dsn/DeliveryStatus;->recipientDSN:[Ljavax/mail/internet/InternetHeaders;

    array-length v1, v1

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v0

    .line 202
    invoke-virtual {v0}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v0

    return-object v0
.end method

.method public writeTo(Ljava/io/OutputStream;)V
    .locals 2
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljava/io/IOException;,
            Ljavax/mail/MessagingException;
        }
    .end annotation

    .prologue
    .line 171
    .line 172
    instance-of v0, p1, Lcom/sun/mail/util/LineOutputStream;

    if-eqz v0, :cond_0

    .line 173
    check-cast p1, Lcom/sun/mail/util/LineOutputStream;

    .line 178
    :goto_0
    iget-object v0, p0, Lcom/sun/mail/dsn/DeliveryStatus;->messageDSN:Ljavax/mail/internet/InternetHeaders;

    invoke-static {v0, p1}, Lcom/sun/mail/dsn/DeliveryStatus;->writeInternetHeaders(Ljavax/mail/internet/InternetHeaders;Lcom/sun/mail/util/LineOutputStream;)V

    .line 179
    invoke-virtual {p1}, Lcom/sun/mail/util/LineOutputStream;->writeln()V

    .line 180
    const/4 v0, 0x0

    :goto_1
    iget-object v1, p0, Lcom/sun/mail/dsn/DeliveryStatus;->recipientDSN:[Ljavax/mail/internet/InternetHeaders;

    array-length v1, v1

    if-lt v0, v1, :cond_1

    .line 184
    return-void

    .line 175
    :cond_0
    new-instance v0, Lcom/sun/mail/util/LineOutputStream;

    invoke-direct {v0, p1}, Lcom/sun/mail/util/LineOutputStream;-><init>(Ljava/io/OutputStream;)V

    move-object p1, v0

    goto :goto_0

    .line 181
    :cond_1
    iget-object v1, p0, Lcom/sun/mail/dsn/DeliveryStatus;->recipientDSN:[Ljavax/mail/internet/InternetHeaders;

    aget-object v1, v1, v0

    invoke-static {v1, p1}, Lcom/sun/mail/dsn/DeliveryStatus;->writeInternetHeaders(Ljavax/mail/internet/InternetHeaders;Lcom/sun/mail/util/LineOutputStream;)V

    .line 182
    invoke-virtual {p1}, Lcom/sun/mail/util/LineOutputStream;->writeln()V

    .line 180
    add-int/lit8 v0, v0, 0x1

    goto :goto_1
.end method
