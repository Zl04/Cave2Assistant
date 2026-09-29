.class public Lcom/sun/mail/handlers/message_rfc822;
.super Ljava/lang/Object;
.source "SourceFile"

# interfaces
.implements Ljavax/activation/DataContentHandler;


# instance fields
.field ourDataFlavor:Ljavax/activation/ActivationDataFlavor;


# direct methods
.method public constructor <init>()V
    .locals 4

    .prologue
    .line 56
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    .line 58
    new-instance v0, Ljavax/activation/ActivationDataFlavor;

    .line 59
    const-class v1, Ljavax/mail/Message;

    .line 60
    const-string v2, "message/rfc822"

    .line 61
    const-string v3, "Message"

    invoke-direct {v0, v1, v2, v3}, Ljavax/activation/ActivationDataFlavor;-><init>(Ljava/lang/Class;Ljava/lang/String;Ljava/lang/String;)V

    iput-object v0, p0, Lcom/sun/mail/handlers/message_rfc822;->ourDataFlavor:Ljavax/activation/ActivationDataFlavor;

    .line 56
    return-void
.end method


# virtual methods
.method public getContent(Ljavax/activation/DataSource;)Ljava/lang/Object;
    .locals 5
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljava/io/IOException;
        }
    .end annotation

    .prologue
    .line 93
    :try_start_0
    instance-of v1, p1, Ljavax/mail/MessageAware;

    if-eqz v1, :cond_0

    .line 94
    move-object v0, p1

    check-cast v0, Ljavax/mail/MessageAware;

    move-object v1, v0

    invoke-interface {v1}, Ljavax/mail/MessageAware;->getMessageContext()Ljavax/mail/MessageContext;

    move-result-object v1

    .line 95
    invoke-virtual {v1}, Ljavax/mail/MessageContext;->getSession()Ljavax/mail/Session;

    move-result-object v1

    .line 103
    :goto_0
    new-instance v2, Ljavax/mail/internet/MimeMessage;

    invoke-interface {p1}, Ljavax/activation/DataSource;->getInputStream()Ljava/io/InputStream;

    move-result-object v3

    invoke-direct {v2, v1, v3}, Ljavax/mail/internet/MimeMessage;-><init>(Ljavax/mail/Session;Ljava/io/InputStream;)V

    return-object v2

    .line 101
    :cond_0
    new-instance v1, Ljava/util/Properties;

    invoke-direct {v1}, Ljava/util/Properties;-><init>()V

    const/4 v2, 0x0

    invoke-static {v1, v2}, Ljavax/mail/Session;->getDefaultInstance(Ljava/util/Properties;Ljavax/mail/Authenticator;)Ljavax/mail/Session;
    :try_end_0
    .catch Ljavax/mail/MessagingException; {:try_start_0 .. :try_end_0} :catch_0

    move-result-object v1

    goto :goto_0

    .line 104
    :catch_0
    move-exception v1

    .line 105
    new-instance v2, Ljava/io/IOException;

    new-instance v3, Ljava/lang/StringBuilder;

    const-string v4, "Exception creating MimeMessage in message/rfc822 DataContentHandler: "

    invoke-direct {v3, v4}, Ljava/lang/StringBuilder;-><init>(Ljava/lang/String;)V

    .line 106
    invoke-virtual {v1}, Ljavax/mail/MessagingException;->toString()Ljava/lang/String;

    move-result-object v1

    invoke-virtual {v3, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v1

    .line 105
    invoke-direct {v2, v1}, Ljava/io/IOException;-><init>(Ljava/lang/String;)V

    throw v2
.end method

.method public getTransferData(Lmyjava/awt/datatransfer/DataFlavor;Ljavax/activation/DataSource;)Ljava/lang/Object;
    .locals 1
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljava/io/IOException;
        }
    .end annotation

    .prologue
    .line 80
    iget-object v0, p0, Lcom/sun/mail/handlers/message_rfc822;->ourDataFlavor:Ljavax/activation/ActivationDataFlavor;

    invoke-virtual {v0, p1}, Ljavax/activation/ActivationDataFlavor;->equals(Lmyjava/awt/datatransfer/DataFlavor;)Z

    move-result v0

    if-eqz v0, :cond_0

    .line 81
    invoke-virtual {p0, p2}, Lcom/sun/mail/handlers/message_rfc822;->getContent(Ljavax/activation/DataSource;)Ljava/lang/Object;

    move-result-object v0

    .line 83
    :goto_0
    return-object v0

    :cond_0
    const/4 v0, 0x0

    goto :goto_0
.end method

.method public getTransferDataFlavors()[Lmyjava/awt/datatransfer/DataFlavor;
    .locals 3

    .prologue
    .line 68
    const/4 v0, 0x1

    new-array v0, v0, [Lmyjava/awt/datatransfer/DataFlavor;

    const/4 v1, 0x0

    iget-object v2, p0, Lcom/sun/mail/handlers/message_rfc822;->ourDataFlavor:Ljavax/activation/ActivationDataFlavor;

    aput-object v2, v0, v1

    return-object v0
.end method

.method public writeTo(Ljava/lang/Object;Ljava/lang/String;Ljava/io/OutputStream;)V
    .locals 2
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljava/io/IOException;
        }
    .end annotation

    .prologue
    .line 118
    instance-of v0, p1, Ljavax/mail/Message;

    if-eqz v0, :cond_0

    .line 119
    check-cast p1, Ljavax/mail/Message;

    .line 121
    :try_start_0
    invoke-virtual {p1, p3}, Ljavax/mail/Message;->writeTo(Ljava/io/OutputStream;)V
    :try_end_0
    .catch Ljavax/mail/MessagingException; {:try_start_0 .. :try_end_0} :catch_0

    .line 129
    return-void

    .line 122
    :catch_0
    move-exception v0

    .line 123
    new-instance v1, Ljava/io/IOException;

    invoke-virtual {v0}, Ljavax/mail/MessagingException;->toString()Ljava/lang/String;

    move-result-object v0

    invoke-direct {v1, v0}, Ljava/io/IOException;-><init>(Ljava/lang/String;)V

    throw v1

    .line 127
    :cond_0
    new-instance v0, Ljava/io/IOException;

    const-string v1, "unsupported object"

    invoke-direct {v0, v1}, Ljava/io/IOException;-><init>(Ljava/lang/String;)V

    throw v0
.end method
