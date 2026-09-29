.class public abstract Lorg/apache/commons/mail/Email;
.super Ljava/lang/Object;
.source "SourceFile"


# static fields
.field public static final ATTACHMENTS:Ljava/lang/String; = "attachments"
    .annotation runtime Ljava/lang/Deprecated;
    .end annotation
.end field

.field public static final CONTENT_TYPE:Ljava/lang/String; = "content.type"
    .annotation runtime Ljava/lang/Deprecated;
    .end annotation
.end field

.field public static final EMAIL_BODY:Ljava/lang/String; = "email.body"
    .annotation runtime Ljava/lang/Deprecated;
    .end annotation
.end field

.field public static final EMAIL_SUBJECT:Ljava/lang/String; = "email.subject"
    .annotation runtime Ljava/lang/Deprecated;
    .end annotation
.end field

.field public static final FILE_SERVER:Ljava/lang/String; = "file.server"
    .annotation runtime Ljava/lang/Deprecated;
    .end annotation
.end field

.field public static final ISO_8859_1:Ljava/lang/String; = "iso-8859-1"
    .annotation runtime Ljava/lang/Deprecated;
    .end annotation
.end field

.field public static final KOI8_R:Ljava/lang/String; = "koi8-r"
    .annotation runtime Ljava/lang/Deprecated;
    .end annotation
.end field

.field public static final MAIL_DEBUG:Ljava/lang/String; = "mail.debug"
    .annotation runtime Ljava/lang/Deprecated;
    .end annotation
.end field

.field public static final MAIL_HOST:Ljava/lang/String; = "mail.smtp.host"
    .annotation runtime Ljava/lang/Deprecated;
    .end annotation
.end field

.field public static final MAIL_PORT:Ljava/lang/String; = "mail.smtp.port"
    .annotation runtime Ljava/lang/Deprecated;
    .end annotation
.end field

.field public static final MAIL_SMTP_AUTH:Ljava/lang/String; = "mail.smtp.auth"
    .annotation runtime Ljava/lang/Deprecated;
    .end annotation
.end field

.field public static final MAIL_SMTP_CONNECTIONTIMEOUT:Ljava/lang/String; = "mail.smtp.connectiontimeout"
    .annotation runtime Ljava/lang/Deprecated;
    .end annotation
.end field

.field public static final MAIL_SMTP_FROM:Ljava/lang/String; = "mail.smtp.from"
    .annotation runtime Ljava/lang/Deprecated;
    .end annotation
.end field

.field public static final MAIL_SMTP_PASSWORD:Ljava/lang/String; = "mail.smtp.password"
    .annotation runtime Ljava/lang/Deprecated;
    .end annotation
.end field

.field public static final MAIL_SMTP_SOCKET_FACTORY_CLASS:Ljava/lang/String; = "mail.smtp.socketFactory.class"
    .annotation runtime Ljava/lang/Deprecated;
    .end annotation
.end field

.field public static final MAIL_SMTP_SOCKET_FACTORY_FALLBACK:Ljava/lang/String; = "mail.smtp.socketFactory.fallback"
    .annotation runtime Ljava/lang/Deprecated;
    .end annotation
.end field

.field public static final MAIL_SMTP_SOCKET_FACTORY_PORT:Ljava/lang/String; = "mail.smtp.socketFactory.port"
    .annotation runtime Ljava/lang/Deprecated;
    .end annotation
.end field

.field public static final MAIL_SMTP_TIMEOUT:Ljava/lang/String; = "mail.smtp.timeout"
    .annotation runtime Ljava/lang/Deprecated;
    .end annotation
.end field

.field public static final MAIL_SMTP_USER:Ljava/lang/String; = "mail.smtp.user"
    .annotation runtime Ljava/lang/Deprecated;
    .end annotation
.end field

.field public static final MAIL_TRANSPORT_PROTOCOL:Ljava/lang/String; = "mail.transport.protocol"
    .annotation runtime Ljava/lang/Deprecated;
    .end annotation
.end field

.field public static final MAIL_TRANSPORT_TLS:Ljava/lang/String; = "mail.smtp.starttls.enable"
    .annotation runtime Ljava/lang/Deprecated;
    .end annotation
.end field

.field public static final RECEIVER_EMAIL:Ljava/lang/String; = "receiver.email"
    .annotation runtime Ljava/lang/Deprecated;
    .end annotation
.end field

.field public static final RECEIVER_NAME:Ljava/lang/String; = "receiver.name"
    .annotation runtime Ljava/lang/Deprecated;
    .end annotation
.end field

.field public static final SENDER_EMAIL:Ljava/lang/String; = "sender.email"
    .annotation runtime Ljava/lang/Deprecated;
    .end annotation
.end field

.field public static final SENDER_NAME:Ljava/lang/String; = "sender.name"
    .annotation runtime Ljava/lang/Deprecated;
    .end annotation
.end field

.field public static final SMTP:Ljava/lang/String; = "smtp"
    .annotation runtime Ljava/lang/Deprecated;
    .end annotation
.end field

.field public static final TEXT_HTML:Ljava/lang/String; = "text/html"
    .annotation runtime Ljava/lang/Deprecated;
    .end annotation
.end field

.field public static final TEXT_PLAIN:Ljava/lang/String; = "text/plain"
    .annotation runtime Ljava/lang/Deprecated;
    .end annotation
.end field

.field public static final US_ASCII:Ljava/lang/String; = "us-ascii"
    .annotation runtime Ljava/lang/Deprecated;
    .end annotation
.end field


# instance fields
.field protected authenticator:Ljavax/mail/Authenticator;

.field protected bccList:Ljava/util/List;
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "Ljava/util/List",
            "<",
            "Ljavax/mail/internet/InternetAddress;",
            ">;"
        }
    .end annotation
.end field

.field protected bounceAddress:Ljava/lang/String;

.field protected ccList:Ljava/util/List;
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "Ljava/util/List",
            "<",
            "Ljavax/mail/internet/InternetAddress;",
            ">;"
        }
    .end annotation
.end field

.field protected charset:Ljava/lang/String;

.field protected content:Ljava/lang/Object;

.field protected contentType:Ljava/lang/String;

.field protected debug:Z

.field protected emailBody:Ljavax/mail/internet/MimeMultipart;

.field protected fromAddress:Ljavax/mail/internet/InternetAddress;

.field protected headers:Ljava/util/Map;
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "Ljava/util/Map",
            "<",
            "Ljava/lang/String;",
            "Ljava/lang/String;",
            ">;"
        }
    .end annotation
.end field

.field protected hostName:Ljava/lang/String;

.field protected message:Ljavax/mail/internet/MimeMessage;

.field protected popBeforeSmtp:Z

.field protected popHost:Ljava/lang/String;

.field protected popPassword:Ljava/lang/String;

.field protected popUsername:Ljava/lang/String;

.field protected replyList:Ljava/util/List;
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "Ljava/util/List",
            "<",
            "Ljavax/mail/internet/InternetAddress;",
            ">;"
        }
    .end annotation
.end field

.field private sendPartial:Z

.field protected sentDate:Ljava/util/Date;

.field private session:Ljavax/mail/Session;

.field protected smtpPort:Ljava/lang/String;

.field protected socketConnectionTimeout:I

.field protected socketTimeout:I

.field protected ssl:Z
    .annotation runtime Ljava/lang/Deprecated;
    .end annotation
.end field

.field private sslCheckServerIdentity:Z

.field private sslOnConnect:Z

.field protected sslSmtpPort:Ljava/lang/String;

.field private startTlsEnabled:Z

.field private startTlsRequired:Z

.field protected subject:Ljava/lang/String;

.field protected tls:Z
    .annotation runtime Ljava/lang/Deprecated;
    .end annotation
.end field

.field protected toList:Ljava/util/List;
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "Ljava/util/List",
            "<",
            "Ljavax/mail/internet/InternetAddress;",
            ">;"
        }
    .end annotation
.end field


# direct methods
.method public constructor <init>()V
    .locals 2

    .prologue
    const v1, 0xea60

    .line 54
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    .line 215
    const-string v0, "25"

    iput-object v0, p0, Lorg/apache/commons/mail/Email;->smtpPort:Ljava/lang/String;

    .line 221
    const-string v0, "465"

    iput-object v0, p0, Lorg/apache/commons/mail/Email;->sslSmtpPort:Ljava/lang/String;

    .line 224
    new-instance v0, Ljava/util/ArrayList;

    invoke-direct {v0}, Ljava/util/ArrayList;-><init>()V

    iput-object v0, p0, Lorg/apache/commons/mail/Email;->toList:Ljava/util/List;

    .line 227
    new-instance v0, Ljava/util/ArrayList;

    invoke-direct {v0}, Ljava/util/ArrayList;-><init>()V

    iput-object v0, p0, Lorg/apache/commons/mail/Email;->ccList:Ljava/util/List;

    .line 230
    new-instance v0, Ljava/util/ArrayList;

    invoke-direct {v0}, Ljava/util/ArrayList;-><init>()V

    iput-object v0, p0, Lorg/apache/commons/mail/Email;->bccList:Ljava/util/List;

    .line 233
    new-instance v0, Ljava/util/ArrayList;

    invoke-direct {v0}, Ljava/util/ArrayList;-><init>()V

    iput-object v0, p0, Lorg/apache/commons/mail/Email;->replyList:Ljava/util/List;

    .line 250
    new-instance v0, Ljava/util/HashMap;

    invoke-direct {v0}, Ljava/util/HashMap;-><init>()V

    iput-object v0, p0, Lorg/apache/commons/mail/Email;->headers:Ljava/util/Map;

    .line 281
    iput v1, p0, Lorg/apache/commons/mail/Email;->socketTimeout:I

    .line 284
    iput v1, p0, Lorg/apache/commons/mail/Email;->socketConnectionTimeout:I

    return-void
.end method

.method private checkSessionAlreadyInitialized()V
    .locals 2

    .prologue
    .line 1938
    iget-object v0, p0, Lorg/apache/commons/mail/Email;->session:Ljavax/mail/Session;

    if-eqz v0, :cond_0

    .line 1940
    new-instance v0, Ljava/lang/IllegalStateException;

    const-string v1, "The mail session is already initialized"

    invoke-direct {v0, v1}, Ljava/lang/IllegalStateException;-><init>(Ljava/lang/String;)V

    throw v0

    .line 1942
    :cond_0
    return-void
.end method

.method private createFoldedHeaderValue(Ljava/lang/String;Ljava/lang/Object;)Ljava/lang/String;
    .locals 4

    .prologue
    .line 1858
    invoke-static {p1}, Lorg/apache/commons/mail/EmailUtils;->isEmpty(Ljava/lang/String;)Z

    move-result v0

    if-eqz v0, :cond_0

    .line 1860
    new-instance v0, Ljava/lang/IllegalArgumentException;

    const-string v1, "name can not be null or empty"

    invoke-direct {v0, v1}, Ljava/lang/IllegalArgumentException;-><init>(Ljava/lang/String;)V

    throw v0

    .line 1862
    :cond_0
    if-eqz p2, :cond_1

    invoke-virtual {p2}, Ljava/lang/Object;->toString()Ljava/lang/String;

    move-result-object v0

    invoke-static {v0}, Lorg/apache/commons/mail/EmailUtils;->isEmpty(Ljava/lang/String;)Z

    move-result v0

    if-eqz v0, :cond_2

    .line 1864
    :cond_1
    new-instance v0, Ljava/lang/IllegalArgumentException;

    const-string v1, "value can not be null or empty"

    invoke-direct {v0, v1}, Ljava/lang/IllegalArgumentException;-><init>(Ljava/lang/String;)V

    throw v0

    .line 1869
    :cond_2
    :try_start_0
    invoke-virtual {p1}, Ljava/lang/String;->length()I

    move-result v0

    add-int/lit8 v0, v0, 0x2

    invoke-virtual {p2}, Ljava/lang/Object;->toString()Ljava/lang/String;

    move-result-object v1

    iget-object v2, p0, Lorg/apache/commons/mail/Email;->charset:Ljava/lang/String;

    const/4 v3, 0x0

    invoke-static {v1, v2, v3}, Ljavax/mail/internet/MimeUtility;->encodeText(Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;)Ljava/lang/String;

    move-result-object v1

    invoke-static {v0, v1}, Ljavax/mail/internet/MimeUtility;->fold(ILjava/lang/String;)Ljava/lang/String;
    :try_end_0
    .catch Ljava/io/UnsupportedEncodingException; {:try_start_0 .. :try_end_0} :catch_0

    move-result-object v0

    .line 1876
    :goto_0
    return-object v0

    .line 1871
    :catch_0
    move-exception v0

    .line 1873
    invoke-virtual {p2}, Ljava/lang/Object;->toString()Ljava/lang/String;

    move-result-object v0

    goto :goto_0
.end method

.method private createInternetAddress(Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;)Ljavax/mail/internet/InternetAddress;
    .locals 2
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Lorg/apache/commons/mail/EmailException;
        }
    .end annotation

    .prologue
    .line 1891
    .line 1895
    :try_start_0
    new-instance v0, Ljavax/mail/internet/InternetAddress;

    invoke-direct {v0, p1}, Ljavax/mail/internet/InternetAddress;-><init>(Ljava/lang/String;)V

    .line 1898
    invoke-static {p2}, Lorg/apache/commons/mail/EmailUtils;->isNotEmpty(Ljava/lang/String;)Z

    move-result v1

    if-eqz v1, :cond_0

    .line 1901
    invoke-static {p3}, Lorg/apache/commons/mail/EmailUtils;->isEmpty(Ljava/lang/String;)Z

    move-result v1

    if-eqz v1, :cond_1

    .line 1903
    invoke-virtual {v0, p2}, Ljavax/mail/internet/InternetAddress;->setPersonal(Ljava/lang/String;)V

    .line 1916
    :cond_0
    :goto_0
    invoke-virtual {v0}, Ljavax/mail/internet/InternetAddress;->validate()V

    .line 1926
    return-object v0

    .line 1909
    :cond_1
    invoke-static {p3}, Ljava/nio/charset/Charset;->forName(Ljava/lang/String;)Ljava/nio/charset/Charset;

    move-result-object v1

    .line 1910
    invoke-virtual {v1}, Ljava/nio/charset/Charset;->name()Ljava/lang/String;

    move-result-object v1

    invoke-virtual {v0, p2, v1}, Ljavax/mail/internet/InternetAddress;->setPersonal(Ljava/lang/String;Ljava/lang/String;)V
    :try_end_0
    .catch Ljavax/mail/internet/AddressException; {:try_start_0 .. :try_end_0} :catch_0
    .catch Ljava/io/UnsupportedEncodingException; {:try_start_0 .. :try_end_0} :catch_1

    goto :goto_0

    .line 1918
    :catch_0
    move-exception v0

    .line 1920
    new-instance v1, Lorg/apache/commons/mail/EmailException;

    invoke-direct {v1, v0}, Lorg/apache/commons/mail/EmailException;-><init>(Ljava/lang/Throwable;)V

    throw v1

    .line 1922
    :catch_1
    move-exception v0

    .line 1924
    new-instance v1, Lorg/apache/commons/mail/EmailException;

    invoke-direct {v1, v0}, Lorg/apache/commons/mail/EmailException;-><init>(Ljava/lang/Throwable;)V

    throw v1
.end method


# virtual methods
.method public addBcc(Ljava/lang/String;)Lorg/apache/commons/mail/Email;
    .locals 1
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Lorg/apache/commons/mail/EmailException;
        }
    .end annotation

    .prologue
    .line 989
    const/4 v0, 0x0

    invoke-virtual {p0, p1, v0}, Lorg/apache/commons/mail/Email;->addBcc(Ljava/lang/String;Ljava/lang/String;)Lorg/apache/commons/mail/Email;

    move-result-object v0

    return-object v0
.end method

.method public addBcc(Ljava/lang/String;Ljava/lang/String;)Lorg/apache/commons/mail/Email;
    .locals 1
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Lorg/apache/commons/mail/EmailException;
        }
    .end annotation

    .prologue
    .line 1039
    iget-object v0, p0, Lorg/apache/commons/mail/Email;->charset:Ljava/lang/String;

    invoke-virtual {p0, p1, p2, v0}, Lorg/apache/commons/mail/Email;->addBcc(Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;)Lorg/apache/commons/mail/Email;

    move-result-object v0

    return-object v0
.end method

.method public addBcc(Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;)Lorg/apache/commons/mail/Email;
    .locals 2
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Lorg/apache/commons/mail/EmailException;
        }
    .end annotation

    .prologue
    .line 1056
    iget-object v0, p0, Lorg/apache/commons/mail/Email;->bccList:Ljava/util/List;

    invoke-direct {p0, p1, p2, p3}, Lorg/apache/commons/mail/Email;->createInternetAddress(Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;)Ljavax/mail/internet/InternetAddress;

    move-result-object v1

    invoke-interface {v0, v1}, Ljava/util/List;->add(Ljava/lang/Object;)Z

    .line 1057
    return-object p0
.end method

.method public varargs addBcc([Ljava/lang/String;)Lorg/apache/commons/mail/Email;
    .locals 4
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Lorg/apache/commons/mail/EmailException;
        }
    .end annotation

    .prologue
    .line 1009
    if-eqz p1, :cond_0

    array-length v0, p1

    if-nez v0, :cond_1

    .line 1011
    :cond_0
    new-instance v0, Lorg/apache/commons/mail/EmailException;

    const-string v1, "Address List provided was invalid"

    invoke-direct {v0, v1}, Lorg/apache/commons/mail/EmailException;-><init>(Ljava/lang/String;)V

    throw v0

    .line 1014
    :cond_1
    array-length v1, p1

    const/4 v0, 0x0

    :goto_0
    if-ge v0, v1, :cond_2

    aget-object v2, p1, v0

    .line 1016
    const/4 v3, 0x0

    invoke-virtual {p0, v2, v3}, Lorg/apache/commons/mail/Email;->addBcc(Ljava/lang/String;Ljava/lang/String;)Lorg/apache/commons/mail/Email;

    .line 1014
    add-int/lit8 v0, v0, 0x1

    goto :goto_0

    .line 1019
    :cond_2
    return-object p0
.end method

.method public addCc(Ljava/lang/String;)Lorg/apache/commons/mail/Email;
    .locals 1
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Lorg/apache/commons/mail/EmailException;
        }
    .end annotation

    .prologue
    .line 880
    const/4 v0, 0x0

    invoke-virtual {p0, p1, v0}, Lorg/apache/commons/mail/Email;->addCc(Ljava/lang/String;Ljava/lang/String;)Lorg/apache/commons/mail/Email;

    move-result-object v0

    return-object v0
.end method

.method public addCc(Ljava/lang/String;Ljava/lang/String;)Lorg/apache/commons/mail/Email;
    .locals 1
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Lorg/apache/commons/mail/EmailException;
        }
    .end annotation

    .prologue
    .line 930
    iget-object v0, p0, Lorg/apache/commons/mail/Email;->charset:Ljava/lang/String;

    invoke-virtual {p0, p1, p2, v0}, Lorg/apache/commons/mail/Email;->addCc(Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;)Lorg/apache/commons/mail/Email;

    move-result-object v0

    return-object v0
.end method

.method public addCc(Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;)Lorg/apache/commons/mail/Email;
    .locals 2
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Lorg/apache/commons/mail/EmailException;
        }
    .end annotation

    .prologue
    .line 947
    iget-object v0, p0, Lorg/apache/commons/mail/Email;->ccList:Ljava/util/List;

    invoke-direct {p0, p1, p2, p3}, Lorg/apache/commons/mail/Email;->createInternetAddress(Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;)Ljavax/mail/internet/InternetAddress;

    move-result-object v1

    invoke-interface {v0, v1}, Ljava/util/List;->add(Ljava/lang/Object;)Z

    .line 948
    return-object p0
.end method

.method public varargs addCc([Ljava/lang/String;)Lorg/apache/commons/mail/Email;
    .locals 4
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Lorg/apache/commons/mail/EmailException;
        }
    .end annotation

    .prologue
    .line 900
    if-eqz p1, :cond_0

    array-length v0, p1

    if-nez v0, :cond_1

    .line 902
    :cond_0
    new-instance v0, Lorg/apache/commons/mail/EmailException;

    const-string v1, "Address List provided was invalid"

    invoke-direct {v0, v1}, Lorg/apache/commons/mail/EmailException;-><init>(Ljava/lang/String;)V

    throw v0

    .line 905
    :cond_1
    array-length v1, p1

    const/4 v0, 0x0

    :goto_0
    if-ge v0, v1, :cond_2

    aget-object v2, p1, v0

    .line 907
    const/4 v3, 0x0

    invoke-virtual {p0, v2, v3}, Lorg/apache/commons/mail/Email;->addCc(Ljava/lang/String;Ljava/lang/String;)Lorg/apache/commons/mail/Email;

    .line 905
    add-int/lit8 v0, v0, 0x1

    goto :goto_0

    .line 910
    :cond_2
    return-object p0
.end method

.method public addHeader(Ljava/lang/String;Ljava/lang/String;)V
    .locals 2

    .prologue
    .line 1192
    invoke-static {p1}, Lorg/apache/commons/mail/EmailUtils;->isEmpty(Ljava/lang/String;)Z

    move-result v0

    if-eqz v0, :cond_0

    .line 1194
    new-instance v0, Ljava/lang/IllegalArgumentException;

    const-string v1, "name can not be null or empty"

    invoke-direct {v0, v1}, Ljava/lang/IllegalArgumentException;-><init>(Ljava/lang/String;)V

    throw v0

    .line 1196
    :cond_0
    invoke-static {p2}, Lorg/apache/commons/mail/EmailUtils;->isEmpty(Ljava/lang/String;)Z

    move-result v0

    if-eqz v0, :cond_1

    .line 1198
    new-instance v0, Ljava/lang/IllegalArgumentException;

    const-string v1, "value can not be null or empty"

    invoke-direct {v0, v1}, Ljava/lang/IllegalArgumentException;-><init>(Ljava/lang/String;)V

    throw v0

    .line 1201
    :cond_1
    iget-object v0, p0, Lorg/apache/commons/mail/Email;->headers:Ljava/util/Map;

    invoke-interface {v0, p1, p2}, Ljava/util/Map;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    .line 1202
    return-void
.end method

.method public addReplyTo(Ljava/lang/String;)Lorg/apache/commons/mail/Email;
    .locals 1
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Lorg/apache/commons/mail/EmailException;
        }
    .end annotation

    .prologue
    .line 1098
    const/4 v0, 0x0

    invoke-virtual {p0, p1, v0}, Lorg/apache/commons/mail/Email;->addReplyTo(Ljava/lang/String;Ljava/lang/String;)Lorg/apache/commons/mail/Email;

    move-result-object v0

    return-object v0
.end method

.method public addReplyTo(Ljava/lang/String;Ljava/lang/String;)Lorg/apache/commons/mail/Email;
    .locals 1
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Lorg/apache/commons/mail/EmailException;
        }
    .end annotation

    .prologue
    .line 1118
    iget-object v0, p0, Lorg/apache/commons/mail/Email;->charset:Ljava/lang/String;

    invoke-virtual {p0, p1, p2, v0}, Lorg/apache/commons/mail/Email;->addReplyTo(Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;)Lorg/apache/commons/mail/Email;

    move-result-object v0

    return-object v0
.end method

.method public addReplyTo(Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;)Lorg/apache/commons/mail/Email;
    .locals 2
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Lorg/apache/commons/mail/EmailException;
        }
    .end annotation

    .prologue
    .line 1135
    iget-object v0, p0, Lorg/apache/commons/mail/Email;->replyList:Ljava/util/List;

    invoke-direct {p0, p1, p2, p3}, Lorg/apache/commons/mail/Email;->createInternetAddress(Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;)Ljavax/mail/internet/InternetAddress;

    move-result-object v1

    invoke-interface {v0, v1}, Ljava/util/List;->add(Ljava/lang/Object;)Z

    .line 1136
    return-object p0
.end method

.method public addTo(Ljava/lang/String;)Lorg/apache/commons/mail/Email;
    .locals 1
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Lorg/apache/commons/mail/EmailException;
        }
    .end annotation

    .prologue
    .line 770
    const/4 v0, 0x0

    invoke-virtual {p0, p1, v0}, Lorg/apache/commons/mail/Email;->addTo(Ljava/lang/String;Ljava/lang/String;)Lorg/apache/commons/mail/Email;

    move-result-object v0

    return-object v0
.end method

.method public addTo(Ljava/lang/String;Ljava/lang/String;)Lorg/apache/commons/mail/Email;
    .locals 1
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Lorg/apache/commons/mail/EmailException;
        }
    .end annotation

    .prologue
    .line 821
    iget-object v0, p0, Lorg/apache/commons/mail/Email;->charset:Ljava/lang/String;

    invoke-virtual {p0, p1, p2, v0}, Lorg/apache/commons/mail/Email;->addTo(Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;)Lorg/apache/commons/mail/Email;

    move-result-object v0

    return-object v0
.end method

.method public addTo(Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;)Lorg/apache/commons/mail/Email;
    .locals 2
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Lorg/apache/commons/mail/EmailException;
        }
    .end annotation

    .prologue
    .line 838
    iget-object v0, p0, Lorg/apache/commons/mail/Email;->toList:Ljava/util/List;

    invoke-direct {p0, p1, p2, p3}, Lorg/apache/commons/mail/Email;->createInternetAddress(Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;)Ljavax/mail/internet/InternetAddress;

    move-result-object v1

    invoke-interface {v0, v1}, Ljava/util/List;->add(Ljava/lang/Object;)Z

    .line 839
    return-object p0
.end method

.method public varargs addTo([Ljava/lang/String;)Lorg/apache/commons/mail/Email;
    .locals 4
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Lorg/apache/commons/mail/EmailException;
        }
    .end annotation

    .prologue
    .line 790
    if-eqz p1, :cond_0

    array-length v0, p1

    if-nez v0, :cond_1

    .line 792
    :cond_0
    new-instance v0, Lorg/apache/commons/mail/EmailException;

    const-string v1, "Address List provided was invalid"

    invoke-direct {v0, v1}, Lorg/apache/commons/mail/EmailException;-><init>(Ljava/lang/String;)V

    throw v0

    .line 795
    :cond_1
    array-length v1, p1

    const/4 v0, 0x0

    :goto_0
    if-ge v0, v1, :cond_2

    aget-object v2, p1, v0

    .line 797
    const/4 v3, 0x0

    invoke-virtual {p0, v2, v3}, Lorg/apache/commons/mail/Email;->addTo(Ljava/lang/String;Ljava/lang/String;)Lorg/apache/commons/mail/Email;

    .line 795
    add-int/lit8 v0, v0, 0x1

    goto :goto_0

    .line 800
    :cond_2
    return-object p0
.end method

.method public buildMimeMessage()V
    .locals 4
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Lorg/apache/commons/mail/EmailException;
        }
    .end annotation

    .prologue
    .line 1269
    iget-object v0, p0, Lorg/apache/commons/mail/Email;->message:Ljavax/mail/internet/MimeMessage;

    if-eqz v0, :cond_0

    .line 1273
    new-instance v0, Ljava/lang/IllegalStateException;

    const-string v1, "The MimeMessage is already built."

    invoke-direct {v0, v1}, Ljava/lang/IllegalStateException;-><init>(Ljava/lang/String;)V

    throw v0

    .line 1278
    :cond_0
    :try_start_0
    invoke-virtual {p0}, Lorg/apache/commons/mail/Email;->getMailSession()Ljavax/mail/Session;

    move-result-object v0

    invoke-virtual {p0, v0}, Lorg/apache/commons/mail/Email;->createMimeMessage(Ljavax/mail/Session;)Ljavax/mail/internet/MimeMessage;

    move-result-object v0

    iput-object v0, p0, Lorg/apache/commons/mail/Email;->message:Ljavax/mail/internet/MimeMessage;

    .line 1280
    iget-object v0, p0, Lorg/apache/commons/mail/Email;->subject:Ljava/lang/String;

    invoke-static {v0}, Lorg/apache/commons/mail/EmailUtils;->isNotEmpty(Ljava/lang/String;)Z

    move-result v0

    if-eqz v0, :cond_1

    .line 1282
    iget-object v0, p0, Lorg/apache/commons/mail/Email;->charset:Ljava/lang/String;

    invoke-static {v0}, Lorg/apache/commons/mail/EmailUtils;->isNotEmpty(Ljava/lang/String;)Z

    move-result v0

    if-eqz v0, :cond_3

    .line 1284
    iget-object v0, p0, Lorg/apache/commons/mail/Email;->message:Ljavax/mail/internet/MimeMessage;

    iget-object v1, p0, Lorg/apache/commons/mail/Email;->subject:Ljava/lang/String;

    iget-object v2, p0, Lorg/apache/commons/mail/Email;->charset:Ljava/lang/String;

    invoke-virtual {v0, v1, v2}, Ljavax/mail/internet/MimeMessage;->setSubject(Ljava/lang/String;Ljava/lang/String;)V

    .line 1293
    :cond_1
    :goto_0
    iget-object v0, p0, Lorg/apache/commons/mail/Email;->contentType:Ljava/lang/String;

    invoke-virtual {p0, v0}, Lorg/apache/commons/mail/Email;->updateContentType(Ljava/lang/String;)V

    .line 1295
    iget-object v0, p0, Lorg/apache/commons/mail/Email;->content:Ljava/lang/Object;

    if-eqz v0, :cond_5

    .line 1297
    const-string v0, "text/plain"

    iget-object v1, p0, Lorg/apache/commons/mail/Email;->contentType:Ljava/lang/String;

    invoke-virtual {v0, v1}, Ljava/lang/String;->equalsIgnoreCase(Ljava/lang/String;)Z

    move-result v0

    if-eqz v0, :cond_4

    iget-object v0, p0, Lorg/apache/commons/mail/Email;->content:Ljava/lang/Object;

    instance-of v0, v0, Ljava/lang/String;

    if-eqz v0, :cond_4

    .line 1302
    iget-object v0, p0, Lorg/apache/commons/mail/Email;->message:Ljavax/mail/internet/MimeMessage;

    iget-object v1, p0, Lorg/apache/commons/mail/Email;->content:Ljava/lang/Object;

    invoke-virtual {v1}, Ljava/lang/Object;->toString()Ljava/lang/String;

    move-result-object v1

    iget-object v2, p0, Lorg/apache/commons/mail/Email;->charset:Ljava/lang/String;

    invoke-virtual {v0, v1, v2}, Ljavax/mail/internet/MimeMessage;->setText(Ljava/lang/String;Ljava/lang/String;)V

    .line 1325
    :goto_1
    iget-object v0, p0, Lorg/apache/commons/mail/Email;->fromAddress:Ljavax/mail/internet/InternetAddress;

    if-eqz v0, :cond_8

    .line 1327
    iget-object v0, p0, Lorg/apache/commons/mail/Email;->message:Ljavax/mail/internet/MimeMessage;

    iget-object v1, p0, Lorg/apache/commons/mail/Email;->fromAddress:Ljavax/mail/internet/InternetAddress;

    invoke-virtual {v0, v1}, Ljavax/mail/internet/MimeMessage;->setFrom(Ljavax/mail/Address;)V

    .line 1338
    :cond_2
    iget-object v0, p0, Lorg/apache/commons/mail/Email;->toList:Ljava/util/List;

    invoke-interface {v0}, Ljava/util/List;->size()I

    move-result v0

    iget-object v1, p0, Lorg/apache/commons/mail/Email;->ccList:Ljava/util/List;

    invoke-interface {v1}, Ljava/util/List;->size()I

    move-result v1

    add-int/2addr v0, v1

    iget-object v1, p0, Lorg/apache/commons/mail/Email;->bccList:Ljava/util/List;

    invoke-interface {v1}, Ljava/util/List;->size()I

    move-result v1

    add-int/2addr v0, v1

    if-nez v0, :cond_9

    .line 1340
    new-instance v0, Lorg/apache/commons/mail/EmailException;

    const-string v1, "At least one receiver address required"

    invoke-direct {v0, v1}, Lorg/apache/commons/mail/EmailException;-><init>(Ljava/lang/String;)V

    throw v0
    :try_end_0
    .catch Ljavax/mail/MessagingException; {:try_start_0 .. :try_end_0} :catch_0

    .line 1391
    :catch_0
    move-exception v0

    .line 1393
    new-instance v1, Lorg/apache/commons/mail/EmailException;

    invoke-direct {v1, v0}, Lorg/apache/commons/mail/EmailException;-><init>(Ljava/lang/Throwable;)V

    throw v1

    .line 1288
    :cond_3
    :try_start_1
    iget-object v0, p0, Lorg/apache/commons/mail/Email;->message:Ljavax/mail/internet/MimeMessage;

    iget-object v1, p0, Lorg/apache/commons/mail/Email;->subject:Ljava/lang/String;

    invoke-virtual {v0, v1}, Ljavax/mail/internet/MimeMessage;->setSubject(Ljava/lang/String;)V

    goto :goto_0

    .line 1306
    :cond_4
    iget-object v0, p0, Lorg/apache/commons/mail/Email;->message:Ljavax/mail/internet/MimeMessage;

    iget-object v1, p0, Lorg/apache/commons/mail/Email;->content:Ljava/lang/Object;

    iget-object v2, p0, Lorg/apache/commons/mail/Email;->contentType:Ljava/lang/String;

    invoke-virtual {v0, v1, v2}, Ljavax/mail/internet/MimeMessage;->setContent(Ljava/lang/Object;Ljava/lang/String;)V

    goto :goto_1

    .line 1309
    :cond_5
    iget-object v0, p0, Lorg/apache/commons/mail/Email;->emailBody:Ljavax/mail/internet/MimeMultipart;

    if-eqz v0, :cond_7

    .line 1311
    iget-object v0, p0, Lorg/apache/commons/mail/Email;->contentType:Ljava/lang/String;

    if-nez v0, :cond_6

    .line 1313
    iget-object v0, p0, Lorg/apache/commons/mail/Email;->message:Ljavax/mail/internet/MimeMessage;

    iget-object v1, p0, Lorg/apache/commons/mail/Email;->emailBody:Ljavax/mail/internet/MimeMultipart;

    invoke-virtual {v0, v1}, Ljavax/mail/internet/MimeMessage;->setContent(Ljavax/mail/Multipart;)V

    goto :goto_1

    .line 1317
    :cond_6
    iget-object v0, p0, Lorg/apache/commons/mail/Email;->message:Ljavax/mail/internet/MimeMessage;

    iget-object v1, p0, Lorg/apache/commons/mail/Email;->emailBody:Ljavax/mail/internet/MimeMultipart;

    iget-object v2, p0, Lorg/apache/commons/mail/Email;->contentType:Ljava/lang/String;

    invoke-virtual {v0, v1, v2}, Ljavax/mail/internet/MimeMessage;->setContent(Ljava/lang/Object;Ljava/lang/String;)V

    goto :goto_1

    .line 1322
    :cond_7
    iget-object v0, p0, Lorg/apache/commons/mail/Email;->message:Ljavax/mail/internet/MimeMessage;

    const-string v1, ""

    invoke-virtual {v0, v1}, Ljavax/mail/internet/MimeMessage;->setText(Ljava/lang/String;)V

    goto :goto_1

    .line 1331
    :cond_8
    iget-object v0, p0, Lorg/apache/commons/mail/Email;->session:Ljavax/mail/Session;

    const-string v1, "mail.smtp.from"

    invoke-virtual {v0, v1}, Ljavax/mail/Session;->getProperty(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v0

    if-nez v0, :cond_2

    iget-object v0, p0, Lorg/apache/commons/mail/Email;->session:Ljavax/mail/Session;

    const-string v1, "mail.from"

    invoke-virtual {v0, v1}, Ljavax/mail/Session;->getProperty(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v0

    if-nez v0, :cond_2

    .line 1334
    new-instance v0, Lorg/apache/commons/mail/EmailException;

    const-string v1, "From address required"

    invoke-direct {v0, v1}, Lorg/apache/commons/mail/EmailException;-><init>(Ljava/lang/String;)V

    throw v0

    .line 1343
    :cond_9
    iget-object v0, p0, Lorg/apache/commons/mail/Email;->toList:Ljava/util/List;

    invoke-interface {v0}, Ljava/util/List;->size()I

    move-result v0

    if-lez v0, :cond_a

    .line 1345
    iget-object v0, p0, Lorg/apache/commons/mail/Email;->message:Ljavax/mail/internet/MimeMessage;

    sget-object v1, Ljavax/mail/Message$RecipientType;->TO:Ljavax/mail/Message$RecipientType;

    iget-object v2, p0, Lorg/apache/commons/mail/Email;->toList:Ljava/util/List;

    invoke-virtual {p0, v2}, Lorg/apache/commons/mail/Email;->toInternetAddressArray(Ljava/util/List;)[Ljavax/mail/internet/InternetAddress;

    move-result-object v2

    invoke-virtual {v0, v1, v2}, Ljavax/mail/internet/MimeMessage;->setRecipients(Ljavax/mail/Message$RecipientType;[Ljavax/mail/Address;)V

    .line 1350
    :cond_a
    iget-object v0, p0, Lorg/apache/commons/mail/Email;->ccList:Ljava/util/List;

    invoke-interface {v0}, Ljava/util/List;->size()I

    move-result v0

    if-lez v0, :cond_b

    .line 1352
    iget-object v0, p0, Lorg/apache/commons/mail/Email;->message:Ljavax/mail/internet/MimeMessage;

    sget-object v1, Ljavax/mail/Message$RecipientType;->CC:Ljavax/mail/Message$RecipientType;

    iget-object v2, p0, Lorg/apache/commons/mail/Email;->ccList:Ljava/util/List;

    invoke-virtual {p0, v2}, Lorg/apache/commons/mail/Email;->toInternetAddressArray(Ljava/util/List;)[Ljavax/mail/internet/InternetAddress;

    move-result-object v2

    invoke-virtual {v0, v1, v2}, Ljavax/mail/internet/MimeMessage;->setRecipients(Ljavax/mail/Message$RecipientType;[Ljavax/mail/Address;)V

    .line 1357
    :cond_b
    iget-object v0, p0, Lorg/apache/commons/mail/Email;->bccList:Ljava/util/List;

    invoke-interface {v0}, Ljava/util/List;->size()I

    move-result v0

    if-lez v0, :cond_c

    .line 1359
    iget-object v0, p0, Lorg/apache/commons/mail/Email;->message:Ljavax/mail/internet/MimeMessage;

    sget-object v1, Ljavax/mail/Message$RecipientType;->BCC:Ljavax/mail/Message$RecipientType;

    iget-object v2, p0, Lorg/apache/commons/mail/Email;->bccList:Ljava/util/List;

    invoke-virtual {p0, v2}, Lorg/apache/commons/mail/Email;->toInternetAddressArray(Ljava/util/List;)[Ljavax/mail/internet/InternetAddress;

    move-result-object v2

    invoke-virtual {v0, v1, v2}, Ljavax/mail/internet/MimeMessage;->setRecipients(Ljavax/mail/Message$RecipientType;[Ljavax/mail/Address;)V

    .line 1364
    :cond_c
    iget-object v0, p0, Lorg/apache/commons/mail/Email;->replyList:Ljava/util/List;

    invoke-interface {v0}, Ljava/util/List;->size()I

    move-result v0

    if-lez v0, :cond_d

    .line 1366
    iget-object v0, p0, Lorg/apache/commons/mail/Email;->message:Ljavax/mail/internet/MimeMessage;

    iget-object v1, p0, Lorg/apache/commons/mail/Email;->replyList:Ljava/util/List;

    invoke-virtual {p0, v1}, Lorg/apache/commons/mail/Email;->toInternetAddressArray(Ljava/util/List;)[Ljavax/mail/internet/InternetAddress;

    move-result-object v1

    invoke-virtual {v0, v1}, Ljavax/mail/internet/MimeMessage;->setReplyTo([Ljavax/mail/Address;)V

    .line 1371
    :cond_d
    iget-object v0, p0, Lorg/apache/commons/mail/Email;->headers:Ljava/util/Map;

    invoke-interface {v0}, Ljava/util/Map;->size()I

    move-result v0

    if-lez v0, :cond_e

    .line 1373
    iget-object v0, p0, Lorg/apache/commons/mail/Email;->headers:Ljava/util/Map;

    invoke-interface {v0}, Ljava/util/Map;->entrySet()Ljava/util/Set;

    move-result-object v0

    invoke-interface {v0}, Ljava/util/Set;->iterator()Ljava/util/Iterator;

    move-result-object v2

    :goto_2
    invoke-interface {v2}, Ljava/util/Iterator;->hasNext()Z

    move-result v0

    if-eqz v0, :cond_e

    invoke-interface {v2}, Ljava/util/Iterator;->next()Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Ljava/util/Map$Entry;

    .line 1375
    invoke-interface {v0}, Ljava/util/Map$Entry;->getKey()Ljava/lang/Object;

    move-result-object v1

    check-cast v1, Ljava/lang/String;

    invoke-interface {v0}, Ljava/util/Map$Entry;->getValue()Ljava/lang/Object;

    move-result-object v3

    invoke-direct {p0, v1, v3}, Lorg/apache/commons/mail/Email;->createFoldedHeaderValue(Ljava/lang/String;Ljava/lang/Object;)Ljava/lang/String;

    move-result-object v1

    .line 1376
    iget-object v3, p0, Lorg/apache/commons/mail/Email;->message:Ljavax/mail/internet/MimeMessage;

    invoke-interface {v0}, Ljava/util/Map$Entry;->getKey()Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Ljava/lang/String;

    invoke-virtual {v3, v0, v1}, Ljavax/mail/internet/MimeMessage;->addHeader(Ljava/lang/String;Ljava/lang/String;)V

    goto :goto_2

    .line 1380
    :cond_e
    iget-object v0, p0, Lorg/apache/commons/mail/Email;->message:Ljavax/mail/internet/MimeMessage;

    invoke-virtual {v0}, Ljavax/mail/internet/MimeMessage;->getSentDate()Ljava/util/Date;

    move-result-object v0

    if-nez v0, :cond_f

    .line 1382
    iget-object v0, p0, Lorg/apache/commons/mail/Email;->message:Ljavax/mail/internet/MimeMessage;

    invoke-virtual {p0}, Lorg/apache/commons/mail/Email;->getSentDate()Ljava/util/Date;

    move-result-object v1

    invoke-virtual {v0, v1}, Ljavax/mail/internet/MimeMessage;->setSentDate(Ljava/util/Date;)V

    .line 1385
    :cond_f
    iget-boolean v0, p0, Lorg/apache/commons/mail/Email;->popBeforeSmtp:Z

    if-eqz v0, :cond_10

    .line 1387
    iget-object v0, p0, Lorg/apache/commons/mail/Email;->session:Ljavax/mail/Session;

    const-string v1, "pop3"

    invoke-virtual {v0, v1}, Ljavax/mail/Session;->getStore(Ljava/lang/String;)Ljavax/mail/Store;

    move-result-object v0

    .line 1388
    iget-object v1, p0, Lorg/apache/commons/mail/Email;->popHost:Ljava/lang/String;

    iget-object v2, p0, Lorg/apache/commons/mail/Email;->popUsername:Ljava/lang/String;

    iget-object v3, p0, Lorg/apache/commons/mail/Email;->popPassword:Ljava/lang/String;

    invoke-virtual {v0, v1, v2, v3}, Ljavax/mail/Store;->connect(Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;)V
    :try_end_1
    .catch Ljavax/mail/MessagingException; {:try_start_1 .. :try_end_1} :catch_0

    .line 1395
    :cond_10
    return-void
.end method

.method protected createMimeMessage(Ljavax/mail/Session;)Ljavax/mail/internet/MimeMessage;
    .locals 1

    .prologue
    .line 1843
    new-instance v0, Ljavax/mail/internet/MimeMessage;

    invoke-direct {v0, p1}, Ljavax/mail/internet/MimeMessage;-><init>(Ljavax/mail/Session;)V

    return-object v0
.end method

.method public getBccAddresses()Ljava/util/List;
    .locals 1
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "()",
            "Ljava/util/List",
            "<",
            "Ljavax/mail/internet/InternetAddress;",
            ">;"
        }
    .end annotation

    .prologue
    .line 1773
    iget-object v0, p0, Lorg/apache/commons/mail/Email;->bccList:Ljava/util/List;

    return-object v0
.end method

.method public getBounceAddress()Ljava/lang/String;
    .locals 1

    .prologue
    .line 1225
    iget-object v0, p0, Lorg/apache/commons/mail/Email;->bounceAddress:Ljava/lang/String;

    return-object v0
.end method

.method public getCcAddresses()Ljava/util/List;
    .locals 1
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "()",
            "Ljava/util/List",
            "<",
            "Ljavax/mail/internet/InternetAddress;",
            ">;"
        }
    .end annotation

    .prologue
    .line 1763
    iget-object v0, p0, Lorg/apache/commons/mail/Email;->ccList:Ljava/util/List;

    return-object v0
.end method

.method public getFromAddress()Ljavax/mail/internet/InternetAddress;
    .locals 1

    .prologue
    .line 1499
    iget-object v0, p0, Lorg/apache/commons/mail/Email;->fromAddress:Ljavax/mail/internet/InternetAddress;

    return-object v0
.end method

.method public getHostName()Ljava/lang/String;
    .locals 2

    .prologue
    .line 1509
    iget-object v0, p0, Lorg/apache/commons/mail/Email;->session:Ljavax/mail/Session;

    if-eqz v0, :cond_0

    .line 1511
    iget-object v0, p0, Lorg/apache/commons/mail/Email;->session:Ljavax/mail/Session;

    const-string v1, "mail.smtp.host"

    invoke-virtual {v0, v1}, Ljavax/mail/Session;->getProperty(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v0

    .line 1517
    :goto_0
    return-object v0

    .line 1513
    :cond_0
    iget-object v0, p0, Lorg/apache/commons/mail/Email;->hostName:Ljava/lang/String;

    invoke-static {v0}, Lorg/apache/commons/mail/EmailUtils;->isNotEmpty(Ljava/lang/String;)Z

    move-result v0

    if-eqz v0, :cond_1

    .line 1515
    iget-object v0, p0, Lorg/apache/commons/mail/Email;->hostName:Ljava/lang/String;

    goto :goto_0

    .line 1517
    :cond_1
    const/4 v0, 0x0

    goto :goto_0
.end method

.method public getMailSession()Ljavax/mail/Session;
    .locals 3
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Lorg/apache/commons/mail/EmailException;
        }
    .end annotation

    .prologue
    .line 627
    iget-object v0, p0, Lorg/apache/commons/mail/Email;->session:Ljavax/mail/Session;

    if-nez v0, :cond_9

    .line 629
    new-instance v1, Ljava/util/Properties;

    invoke-static {}, Ljava/lang/System;->getProperties()Ljava/util/Properties;

    move-result-object v0

    invoke-direct {v1, v0}, Ljava/util/Properties;-><init>(Ljava/util/Properties;)V

    .line 630
    const-string v0, "mail.transport.protocol"

    const-string v2, "smtp"

    invoke-virtual {v1, v0, v2}, Ljava/util/Properties;->setProperty(Ljava/lang/String;Ljava/lang/String;)Ljava/lang/Object;

    .line 632
    iget-object v0, p0, Lorg/apache/commons/mail/Email;->hostName:Ljava/lang/String;

    invoke-static {v0}, Lorg/apache/commons/mail/EmailUtils;->isEmpty(Ljava/lang/String;)Z

    move-result v0

    if-eqz v0, :cond_0

    .line 634
    const-string v0, "mail.smtp.host"

    invoke-virtual {v1, v0}, Ljava/util/Properties;->getProperty(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v0

    iput-object v0, p0, Lorg/apache/commons/mail/Email;->hostName:Ljava/lang/String;

    .line 637
    :cond_0
    iget-object v0, p0, Lorg/apache/commons/mail/Email;->hostName:Ljava/lang/String;

    invoke-static {v0}, Lorg/apache/commons/mail/EmailUtils;->isEmpty(Ljava/lang/String;)Z

    move-result v0

    if-eqz v0, :cond_1

    .line 639
    new-instance v0, Lorg/apache/commons/mail/EmailException;

    const-string v1, "Cannot find valid hostname for mail session"

    invoke-direct {v0, v1}, Lorg/apache/commons/mail/EmailException;-><init>(Ljava/lang/String;)V

    throw v0

    .line 642
    :cond_1
    const-string v0, "mail.smtp.port"

    iget-object v2, p0, Lorg/apache/commons/mail/Email;->smtpPort:Ljava/lang/String;

    invoke-virtual {v1, v0, v2}, Ljava/util/Properties;->setProperty(Ljava/lang/String;Ljava/lang/String;)Ljava/lang/Object;

    .line 643
    const-string v0, "mail.smtp.host"

    iget-object v2, p0, Lorg/apache/commons/mail/Email;->hostName:Ljava/lang/String;

    invoke-virtual {v1, v0, v2}, Ljava/util/Properties;->setProperty(Ljava/lang/String;Ljava/lang/String;)Ljava/lang/Object;

    .line 644
    const-string v0, "mail.debug"

    iget-boolean v2, p0, Lorg/apache/commons/mail/Email;->debug:Z

    invoke-static {v2}, Ljava/lang/String;->valueOf(Z)Ljava/lang/String;

    move-result-object v2

    invoke-virtual {v1, v0, v2}, Ljava/util/Properties;->setProperty(Ljava/lang/String;Ljava/lang/String;)Ljava/lang/Object;

    .line 646
    const-string v2, "mail.smtp.starttls.enable"

    invoke-virtual {p0}, Lorg/apache/commons/mail/Email;->isStartTLSEnabled()Z

    move-result v0

    if-eqz v0, :cond_a

    const-string v0, "true"

    :goto_0
    invoke-virtual {v1, v2, v0}, Ljava/util/Properties;->setProperty(Ljava/lang/String;Ljava/lang/String;)Ljava/lang/Object;

    .line 648
    const-string v2, "mail.smtp.starttls.required"

    invoke-virtual {p0}, Lorg/apache/commons/mail/Email;->isStartTLSRequired()Z

    move-result v0

    if-eqz v0, :cond_b

    const-string v0, "true"

    :goto_1
    invoke-virtual {v1, v2, v0}, Ljava/util/Properties;->setProperty(Ljava/lang/String;Ljava/lang/String;)Ljava/lang/Object;

    .line 651
    const-string v2, "mail.smtp.sendpartial"

    invoke-virtual {p0}, Lorg/apache/commons/mail/Email;->isSendPartial()Z

    move-result v0

    if-eqz v0, :cond_c

    const-string v0, "true"

    :goto_2
    invoke-virtual {v1, v2, v0}, Ljava/util/Properties;->setProperty(Ljava/lang/String;Ljava/lang/String;)Ljava/lang/Object;

    .line 653
    const-string v2, "mail.smtps.sendpartial"

    invoke-virtual {p0}, Lorg/apache/commons/mail/Email;->isSendPartial()Z

    move-result v0

    if-eqz v0, :cond_d

    const-string v0, "true"

    :goto_3
    invoke-virtual {v1, v2, v0}, Ljava/util/Properties;->setProperty(Ljava/lang/String;Ljava/lang/String;)Ljava/lang/Object;

    .line 656
    iget-object v0, p0, Lorg/apache/commons/mail/Email;->authenticator:Ljavax/mail/Authenticator;

    if-eqz v0, :cond_2

    .line 658
    const-string v0, "mail.smtp.auth"

    const-string v2, "true"

    invoke-virtual {v1, v0, v2}, Ljava/util/Properties;->setProperty(Ljava/lang/String;Ljava/lang/String;)Ljava/lang/Object;

    .line 661
    :cond_2
    invoke-virtual {p0}, Lorg/apache/commons/mail/Email;->isSSLOnConnect()Z

    move-result v0

    if-eqz v0, :cond_3

    .line 663
    const-string v0, "mail.smtp.port"

    iget-object v2, p0, Lorg/apache/commons/mail/Email;->sslSmtpPort:Ljava/lang/String;

    invoke-virtual {v1, v0, v2}, Ljava/util/Properties;->setProperty(Ljava/lang/String;Ljava/lang/String;)Ljava/lang/Object;

    .line 664
    const-string v0, "mail.smtp.socketFactory.port"

    iget-object v2, p0, Lorg/apache/commons/mail/Email;->sslSmtpPort:Ljava/lang/String;

    invoke-virtual {v1, v0, v2}, Ljava/util/Properties;->setProperty(Ljava/lang/String;Ljava/lang/String;)Ljava/lang/Object;

    .line 665
    const-string v0, "mail.smtp.socketFactory.class"

    const-string v2, "javax.net.ssl.SSLSocketFactory"

    invoke-virtual {v1, v0, v2}, Ljava/util/Properties;->setProperty(Ljava/lang/String;Ljava/lang/String;)Ljava/lang/Object;

    .line 666
    const-string v0, "mail.smtp.socketFactory.fallback"

    const-string v2, "false"

    invoke-virtual {v1, v0, v2}, Ljava/util/Properties;->setProperty(Ljava/lang/String;Ljava/lang/String;)Ljava/lang/Object;

    .line 669
    :cond_3
    invoke-virtual {p0}, Lorg/apache/commons/mail/Email;->isSSLOnConnect()Z

    move-result v0

    if-nez v0, :cond_4

    invoke-virtual {p0}, Lorg/apache/commons/mail/Email;->isStartTLSEnabled()Z

    move-result v0

    if-eqz v0, :cond_5

    :cond_4
    invoke-virtual {p0}, Lorg/apache/commons/mail/Email;->isSSLCheckServerIdentity()Z

    move-result v0

    if-eqz v0, :cond_5

    .line 671
    const-string v0, "mail.smtp.ssl.checkserveridentity"

    const-string v2, "true"

    invoke-virtual {v1, v0, v2}, Ljava/util/Properties;->setProperty(Ljava/lang/String;Ljava/lang/String;)Ljava/lang/Object;

    .line 674
    :cond_5
    iget-object v0, p0, Lorg/apache/commons/mail/Email;->bounceAddress:Ljava/lang/String;

    if-eqz v0, :cond_6

    .line 676
    const-string v0, "mail.smtp.from"

    iget-object v2, p0, Lorg/apache/commons/mail/Email;->bounceAddress:Ljava/lang/String;

    invoke-virtual {v1, v0, v2}, Ljava/util/Properties;->setProperty(Ljava/lang/String;Ljava/lang/String;)Ljava/lang/Object;

    .line 679
    :cond_6
    iget v0, p0, Lorg/apache/commons/mail/Email;->socketTimeout:I

    if-lez v0, :cond_7

    .line 681
    const-string v0, "mail.smtp.timeout"

    iget v2, p0, Lorg/apache/commons/mail/Email;->socketTimeout:I

    invoke-static {v2}, Ljava/lang/Integer;->toString(I)Ljava/lang/String;

    move-result-object v2

    invoke-virtual {v1, v0, v2}, Ljava/util/Properties;->setProperty(Ljava/lang/String;Ljava/lang/String;)Ljava/lang/Object;

    .line 684
    :cond_7
    iget v0, p0, Lorg/apache/commons/mail/Email;->socketConnectionTimeout:I

    if-lez v0, :cond_8

    .line 686
    const-string v0, "mail.smtp.connectiontimeout"

    iget v2, p0, Lorg/apache/commons/mail/Email;->socketConnectionTimeout:I

    invoke-static {v2}, Ljava/lang/Integer;->toString(I)Ljava/lang/String;

    move-result-object v2

    invoke-virtual {v1, v0, v2}, Ljava/util/Properties;->setProperty(Ljava/lang/String;Ljava/lang/String;)Ljava/lang/Object;

    .line 691
    :cond_8
    iget-object v0, p0, Lorg/apache/commons/mail/Email;->authenticator:Ljavax/mail/Authenticator;

    invoke-static {v1, v0}, Ljavax/mail/Session;->getInstance(Ljava/util/Properties;Ljavax/mail/Authenticator;)Ljavax/mail/Session;

    move-result-object v0

    iput-object v0, p0, Lorg/apache/commons/mail/Email;->session:Ljavax/mail/Session;

    .line 693
    :cond_9
    iget-object v0, p0, Lorg/apache/commons/mail/Email;->session:Ljavax/mail/Session;

    return-object v0

    .line 646
    :cond_a
    const-string v0, "false"

    goto/16 :goto_0

    .line 648
    :cond_b
    const-string v0, "false"

    goto/16 :goto_1

    .line 651
    :cond_c
    const-string v0, "false"

    goto/16 :goto_2

    .line 653
    :cond_d
    const-string v0, "false"

    goto/16 :goto_3
.end method

.method public getMimeMessage()Ljavax/mail/internet/MimeMessage;
    .locals 1

    .prologue
    .line 1433
    iget-object v0, p0, Lorg/apache/commons/mail/Email;->message:Ljavax/mail/internet/MimeMessage;

    return-object v0
.end method

.method public getReplyToAddresses()Ljava/util/List;
    .locals 1
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "()",
            "Ljava/util/List",
            "<",
            "Ljavax/mail/internet/InternetAddress;",
            ">;"
        }
    .end annotation

    .prologue
    .line 1783
    iget-object v0, p0, Lorg/apache/commons/mail/Email;->replyList:Ljava/util/List;

    return-object v0
.end method

.method public getSentDate()Ljava/util/Date;
    .locals 4

    .prologue
    .line 1475
    iget-object v0, p0, Lorg/apache/commons/mail/Email;->sentDate:Ljava/util/Date;

    if-nez v0, :cond_0

    .line 1477
    new-instance v0, Ljava/util/Date;

    invoke-direct {v0}, Ljava/util/Date;-><init>()V

    .line 1479
    :goto_0
    return-object v0

    :cond_0
    new-instance v0, Ljava/util/Date;

    iget-object v1, p0, Lorg/apache/commons/mail/Email;->sentDate:Ljava/util/Date;

    invoke-virtual {v1}, Ljava/util/Date;->getTime()J

    move-result-wide v2

    invoke-direct {v0, v2, v3}, Ljava/util/Date;-><init>(J)V

    goto :goto_0
.end method

.method public getSmtpPort()Ljava/lang/String;
    .locals 2

    .prologue
    .line 1527
    iget-object v0, p0, Lorg/apache/commons/mail/Email;->session:Ljavax/mail/Session;

    if-eqz v0, :cond_0

    .line 1529
    iget-object v0, p0, Lorg/apache/commons/mail/Email;->session:Ljavax/mail/Session;

    const-string v1, "mail.smtp.port"

    invoke-virtual {v0, v1}, Ljavax/mail/Session;->getProperty(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v0

    .line 1535
    :goto_0
    return-object v0

    .line 1531
    :cond_0
    iget-object v0, p0, Lorg/apache/commons/mail/Email;->smtpPort:Ljava/lang/String;

    invoke-static {v0}, Lorg/apache/commons/mail/EmailUtils;->isNotEmpty(Ljava/lang/String;)Z

    move-result v0

    if-eqz v0, :cond_1

    .line 1533
    iget-object v0, p0, Lorg/apache/commons/mail/Email;->smtpPort:Ljava/lang/String;

    goto :goto_0

    .line 1535
    :cond_1
    const/4 v0, 0x0

    goto :goto_0
.end method

.method public getSocketConnectionTimeout()I
    .locals 1

    .prologue
    .line 1794
    iget v0, p0, Lorg/apache/commons/mail/Email;->socketConnectionTimeout:I

    return v0
.end method

.method public getSocketTimeout()I
    .locals 1

    .prologue
    .line 1818
    iget v0, p0, Lorg/apache/commons/mail/Email;->socketTimeout:I

    return v0
.end method

.method public getSslSmtpPort()Ljava/lang/String;
    .locals 2

    .prologue
    .line 1692
    iget-object v0, p0, Lorg/apache/commons/mail/Email;->session:Ljavax/mail/Session;

    if-eqz v0, :cond_0

    .line 1694
    iget-object v0, p0, Lorg/apache/commons/mail/Email;->session:Ljavax/mail/Session;

    const-string v1, "mail.smtp.socketFactory.port"

    invoke-virtual {v0, v1}, Ljavax/mail/Session;->getProperty(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v0

    .line 1700
    :goto_0
    return-object v0

    .line 1696
    :cond_0
    iget-object v0, p0, Lorg/apache/commons/mail/Email;->sslSmtpPort:Ljava/lang/String;

    invoke-static {v0}, Lorg/apache/commons/mail/EmailUtils;->isNotEmpty(Ljava/lang/String;)Z

    move-result v0

    if-eqz v0, :cond_1

    .line 1698
    iget-object v0, p0, Lorg/apache/commons/mail/Email;->sslSmtpPort:Ljava/lang/String;

    goto :goto_0

    .line 1700
    :cond_1
    const/4 v0, 0x0

    goto :goto_0
.end method

.method public getSubject()Ljava/lang/String;
    .locals 1

    .prologue
    .line 1489
    iget-object v0, p0, Lorg/apache/commons/mail/Email;->subject:Ljava/lang/String;

    return-object v0
.end method

.method public getToAddresses()Ljava/util/List;
    .locals 1
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "()",
            "Ljava/util/List",
            "<",
            "Ljavax/mail/internet/InternetAddress;",
            ">;"
        }
    .end annotation

    .prologue
    .line 1753
    iget-object v0, p0, Lorg/apache/commons/mail/Email;->toList:Ljava/util/List;

    return-object v0
.end method

.method public isSSL()Z
    .locals 1
    .annotation runtime Ljava/lang/Deprecated;
    .end annotation

    .prologue
    .line 1618
    invoke-virtual {p0}, Lorg/apache/commons/mail/Email;->isSSLOnConnect()Z

    move-result v0

    return v0
.end method

.method public isSSLCheckServerIdentity()Z
    .locals 1

    .prologue
    .line 1668
    iget-boolean v0, p0, Lorg/apache/commons/mail/Email;->sslCheckServerIdentity:Z

    return v0
.end method

.method public isSSLOnConnect()Z
    .locals 1

    .prologue
    .line 1629
    iget-boolean v0, p0, Lorg/apache/commons/mail/Email;->sslOnConnect:Z

    if-nez v0, :cond_0

    iget-boolean v0, p0, Lorg/apache/commons/mail/Email;->ssl:Z

    if-eqz v0, :cond_1

    :cond_0
    const/4 v0, 0x1

    :goto_0
    return v0

    :cond_1
    const/4 v0, 0x0

    goto :goto_0
.end method

.method public isSendPartial()Z
    .locals 1

    .prologue
    .line 1723
    iget-boolean v0, p0, Lorg/apache/commons/mail/Email;->sendPartial:Z

    return v0
.end method

.method public isStartTLSEnabled()Z
    .locals 1

    .prologue
    .line 1557
    iget-boolean v0, p0, Lorg/apache/commons/mail/Email;->startTlsEnabled:Z

    if-nez v0, :cond_0

    iget-boolean v0, p0, Lorg/apache/commons/mail/Email;->tls:Z

    if-eqz v0, :cond_1

    :cond_0
    const/4 v0, 0x1

    :goto_0
    return v0

    :cond_1
    const/4 v0, 0x0

    goto :goto_0
.end method

.method public isStartTLSRequired()Z
    .locals 1

    .prologue
    .line 1546
    iget-boolean v0, p0, Lorg/apache/commons/mail/Email;->startTlsRequired:Z

    return v0
.end method

.method public isTLS()Z
    .locals 1
    .annotation runtime Ljava/lang/Deprecated;
    .end annotation

    .prologue
    .line 1571
    invoke-virtual {p0}, Lorg/apache/commons/mail/Email;->isStartTLSEnabled()Z

    move-result v0

    return v0
.end method

.method public send()Ljava/lang/String;
    .locals 1
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Lorg/apache/commons/mail/EmailException;
        }
    .end annotation

    .prologue
    .line 1447
    invoke-virtual {p0}, Lorg/apache/commons/mail/Email;->buildMimeMessage()V

    .line 1448
    invoke-virtual {p0}, Lorg/apache/commons/mail/Email;->sendMimeMessage()Ljava/lang/String;

    move-result-object v0

    return-object v0
.end method

.method public sendMimeMessage()Ljava/lang/String;
    .locals 3
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Lorg/apache/commons/mail/EmailException;
        }
    .end annotation

    .prologue
    .line 1407
    iget-object v0, p0, Lorg/apache/commons/mail/Email;->message:Ljavax/mail/internet/MimeMessage;

    const-string v1, "MimeMessage has not been created yet"

    invoke-static {v0, v1}, Lorg/apache/commons/mail/EmailUtils;->notNull(Ljava/lang/Object;Ljava/lang/String;)V

    .line 1411
    :try_start_0
    iget-object v0, p0, Lorg/apache/commons/mail/Email;->message:Ljavax/mail/internet/MimeMessage;

    invoke-static {v0}, Ljavax/mail/Transport;->send(Ljavax/mail/Message;)V

    .line 1412
    iget-object v0, p0, Lorg/apache/commons/mail/Email;->message:Ljavax/mail/internet/MimeMessage;

    invoke-virtual {v0}, Ljavax/mail/internet/MimeMessage;->getMessageID()Ljava/lang/String;
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_0

    move-result-object v0

    return-object v0

    .line 1414
    :catch_0
    move-exception v0

    .line 1416
    new-instance v1, Ljava/lang/StringBuilder;

    invoke-direct {v1}, Ljava/lang/StringBuilder;-><init>()V

    const-string v2, "Sending the email to the following server failed : "

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {p0}, Lorg/apache/commons/mail/Email;->getHostName()Ljava/lang/String;

    move-result-object v2

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    const-string v2, ":"

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {p0}, Lorg/apache/commons/mail/Email;->getSmtpPort()Ljava/lang/String;

    move-result-object v2

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v1

    .line 1421
    new-instance v2, Lorg/apache/commons/mail/EmailException;

    invoke-direct {v2, v1, v0}, Lorg/apache/commons/mail/EmailException;-><init>(Ljava/lang/String;Ljava/lang/Throwable;)V

    throw v2
.end method

.method public setAuthentication(Ljava/lang/String;Ljava/lang/String;)V
    .locals 1

    .prologue
    .line 353
    new-instance v0, Lorg/apache/commons/mail/DefaultAuthenticator;

    invoke-direct {v0, p1, p2}, Lorg/apache/commons/mail/DefaultAuthenticator;-><init>(Ljava/lang/String;Ljava/lang/String;)V

    invoke-virtual {p0, v0}, Lorg/apache/commons/mail/Email;->setAuthenticator(Ljavax/mail/Authenticator;)V

    .line 354
    return-void
.end method

.method public setAuthenticator(Ljavax/mail/Authenticator;)V
    .locals 0

    .prologue
    .line 369
    iput-object p1, p0, Lorg/apache/commons/mail/Email;->authenticator:Ljavax/mail/Authenticator;

    .line 370
    return-void
.end method

.method public setBcc(Ljava/util/Collection;)Lorg/apache/commons/mail/Email;
    .locals 2
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "(",
            "Ljava/util/Collection",
            "<",
            "Ljavax/mail/internet/InternetAddress;",
            ">;)",
            "Lorg/apache/commons/mail/Email;"
        }
    .end annotation

    .annotation system Ldalvik/annotation/Throws;
        value = {
            Lorg/apache/commons/mail/EmailException;
        }
    .end annotation

    .prologue
    .line 1073
    if-eqz p1, :cond_0

    invoke-interface {p1}, Ljava/util/Collection;->isEmpty()Z

    move-result v0

    if-eqz v0, :cond_1

    .line 1075
    :cond_0
    new-instance v0, Lorg/apache/commons/mail/EmailException;

    const-string v1, "Address List provided was invalid"

    invoke-direct {v0, v1}, Lorg/apache/commons/mail/EmailException;-><init>(Ljava/lang/String;)V

    throw v0

    .line 1078
    :cond_1
    new-instance v0, Ljava/util/ArrayList;

    invoke-direct {v0, p1}, Ljava/util/ArrayList;-><init>(Ljava/util/Collection;)V

    iput-object v0, p0, Lorg/apache/commons/mail/Email;->bccList:Ljava/util/List;

    .line 1079
    return-object p0
.end method

.method public setBounceAddress(Ljava/lang/String;)Lorg/apache/commons/mail/Email;
    .locals 0

    .prologue
    .line 1241
    invoke-direct {p0}, Lorg/apache/commons/mail/Email;->checkSessionAlreadyInitialized()V

    .line 1242
    iput-object p1, p0, Lorg/apache/commons/mail/Email;->bounceAddress:Ljava/lang/String;

    .line 1243
    return-object p0
.end method

.method public setCc(Ljava/util/Collection;)Lorg/apache/commons/mail/Email;
    .locals 2
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "(",
            "Ljava/util/Collection",
            "<",
            "Ljavax/mail/internet/InternetAddress;",
            ">;)",
            "Lorg/apache/commons/mail/Email;"
        }
    .end annotation

    .annotation system Ldalvik/annotation/Throws;
        value = {
            Lorg/apache/commons/mail/EmailException;
        }
    .end annotation

    .prologue
    .line 964
    if-eqz p1, :cond_0

    invoke-interface {p1}, Ljava/util/Collection;->isEmpty()Z

    move-result v0

    if-eqz v0, :cond_1

    .line 966
    :cond_0
    new-instance v0, Lorg/apache/commons/mail/EmailException;

    const-string v1, "Address List provided was invalid"

    invoke-direct {v0, v1}, Lorg/apache/commons/mail/EmailException;-><init>(Ljava/lang/String;)V

    throw v0

    .line 969
    :cond_1
    new-instance v0, Ljava/util/ArrayList;

    invoke-direct {v0, p1}, Ljava/util/ArrayList;-><init>(Ljava/util/Collection;)V

    iput-object v0, p0, Lorg/apache/commons/mail/Email;->ccList:Ljava/util/List;

    .line 970
    return-object p0
.end method

.method public setCharset(Ljava/lang/String;)V
    .locals 1

    .prologue
    .line 384
    invoke-static {p1}, Ljava/nio/charset/Charset;->forName(Ljava/lang/String;)Ljava/nio/charset/Charset;

    move-result-object v0

    .line 385
    invoke-virtual {v0}, Ljava/nio/charset/Charset;->name()Ljava/lang/String;

    move-result-object v0

    iput-object v0, p0, Lorg/apache/commons/mail/Email;->charset:Ljava/lang/String;

    .line 386
    return-void
.end method

.method public setContent(Ljava/lang/Object;Ljava/lang/String;)V
    .locals 0

    .prologue
    .line 408
    iput-object p1, p0, Lorg/apache/commons/mail/Email;->content:Ljava/lang/Object;

    .line 409
    invoke-virtual {p0, p2}, Lorg/apache/commons/mail/Email;->updateContentType(Ljava/lang/String;)V

    .line 410
    return-void
.end method

.method public setContent(Ljavax/mail/internet/MimeMultipart;)V
    .locals 0

    .prologue
    .line 396
    iput-object p1, p0, Lorg/apache/commons/mail/Email;->emailBody:Ljavax/mail/internet/MimeMultipart;

    .line 397
    return-void
.end method

.method public setDebug(Z)V
    .locals 0

    .prologue
    .line 335
    iput-boolean p1, p0, Lorg/apache/commons/mail/Email;->debug:Z

    .line 336
    return-void
.end method

.method public setFrom(Ljava/lang/String;)Lorg/apache/commons/mail/Email;
    .locals 1
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Lorg/apache/commons/mail/EmailException;
        }
    .end annotation

    .prologue
    .line 712
    const/4 v0, 0x0

    invoke-virtual {p0, p1, v0}, Lorg/apache/commons/mail/Email;->setFrom(Ljava/lang/String;Ljava/lang/String;)Lorg/apache/commons/mail/Email;

    move-result-object v0

    return-object v0
.end method

.method public setFrom(Ljava/lang/String;Ljava/lang/String;)Lorg/apache/commons/mail/Email;
    .locals 1
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Lorg/apache/commons/mail/EmailException;
        }
    .end annotation

    .prologue
    .line 732
    iget-object v0, p0, Lorg/apache/commons/mail/Email;->charset:Ljava/lang/String;

    invoke-virtual {p0, p1, p2, v0}, Lorg/apache/commons/mail/Email;->setFrom(Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;)Lorg/apache/commons/mail/Email;

    move-result-object v0

    return-object v0
.end method

.method public setFrom(Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;)Lorg/apache/commons/mail/Email;
    .locals 1
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Lorg/apache/commons/mail/EmailException;
        }
    .end annotation

    .prologue
    .line 749
    invoke-direct {p0, p1, p2, p3}, Lorg/apache/commons/mail/Email;->createInternetAddress(Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;)Ljavax/mail/internet/InternetAddress;

    move-result-object v0

    iput-object v0, p0, Lorg/apache/commons/mail/Email;->fromAddress:Ljavax/mail/internet/InternetAddress;

    .line 750
    return-object p0
.end method

.method public setHeaders(Ljava/util/Map;)V
    .locals 3
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "(",
            "Ljava/util/Map",
            "<",
            "Ljava/lang/String;",
            "Ljava/lang/String;",
            ">;)V"
        }
    .end annotation

    .prologue
    .line 1174
    iget-object v0, p0, Lorg/apache/commons/mail/Email;->headers:Ljava/util/Map;

    invoke-interface {v0}, Ljava/util/Map;->clear()V

    .line 1176
    invoke-interface {p1}, Ljava/util/Map;->entrySet()Ljava/util/Set;

    move-result-object v0

    invoke-interface {v0}, Ljava/util/Set;->iterator()Ljava/util/Iterator;

    move-result-object v2

    :goto_0
    invoke-interface {v2}, Ljava/util/Iterator;->hasNext()Z

    move-result v0

    if-eqz v0, :cond_0

    invoke-interface {v2}, Ljava/util/Iterator;->next()Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Ljava/util/Map$Entry;

    .line 1178
    invoke-interface {v0}, Ljava/util/Map$Entry;->getKey()Ljava/lang/Object;

    move-result-object v1

    check-cast v1, Ljava/lang/String;

    invoke-interface {v0}, Ljava/util/Map$Entry;->getValue()Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Ljava/lang/String;

    invoke-virtual {p0, v1, v0}, Lorg/apache/commons/mail/Email;->addHeader(Ljava/lang/String;Ljava/lang/String;)V

    goto :goto_0

    .line 1180
    :cond_0
    return-void
.end method

.method public setHostName(Ljava/lang/String;)V
    .locals 0

    .prologue
    .line 473
    invoke-direct {p0}, Lorg/apache/commons/mail/Email;->checkSessionAlreadyInitialized()V

    .line 474
    iput-object p1, p0, Lorg/apache/commons/mail/Email;->hostName:Ljava/lang/String;

    .line 475
    return-void
.end method

.method public setMailSession(Ljavax/mail/Session;)V
    .locals 4

    .prologue
    .line 558
    const-string v0, "no mail session supplied"

    invoke-static {p1, v0}, Lorg/apache/commons/mail/EmailUtils;->notNull(Ljava/lang/Object;Ljava/lang/String;)V

    .line 560
    invoke-virtual {p1}, Ljavax/mail/Session;->getProperties()Ljava/util/Properties;

    move-result-object v0

    .line 561
    const-string v1, "mail.smtp.auth"

    invoke-virtual {v0, v1}, Ljava/util/Properties;->getProperty(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v1

    .line 563
    const-string v2, "true"

    invoke-virtual {v2, v1}, Ljava/lang/String;->equalsIgnoreCase(Ljava/lang/String;)Z

    move-result v1

    if-eqz v1, :cond_1

    .line 565
    const-string v1, "mail.smtp.user"

    invoke-virtual {v0, v1}, Ljava/util/Properties;->getProperty(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v1

    .line 566
    const-string v2, "mail.smtp.password"

    invoke-virtual {v0, v2}, Ljava/util/Properties;->getProperty(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v2

    .line 568
    invoke-static {v1}, Lorg/apache/commons/mail/EmailUtils;->isNotEmpty(Ljava/lang/String;)Z

    move-result v3

    if-eqz v3, :cond_0

    invoke-static {v2}, Lorg/apache/commons/mail/EmailUtils;->isNotEmpty(Ljava/lang/String;)Z

    move-result v3

    if-eqz v3, :cond_0

    .line 572
    new-instance v3, Lorg/apache/commons/mail/DefaultAuthenticator;

    invoke-direct {v3, v1, v2}, Lorg/apache/commons/mail/DefaultAuthenticator;-><init>(Ljava/lang/String;Ljava/lang/String;)V

    iput-object v3, p0, Lorg/apache/commons/mail/Email;->authenticator:Ljavax/mail/Authenticator;

    .line 573
    iget-object v1, p0, Lorg/apache/commons/mail/Email;->authenticator:Ljavax/mail/Authenticator;

    invoke-static {v0, v1}, Ljavax/mail/Session;->getInstance(Ljava/util/Properties;Ljavax/mail/Authenticator;)Ljavax/mail/Session;

    move-result-object v0

    iput-object v0, p0, Lorg/apache/commons/mail/Email;->session:Ljavax/mail/Session;

    .line 585
    :goto_0
    return-void

    .line 578
    :cond_0
    iput-object p1, p0, Lorg/apache/commons/mail/Email;->session:Ljavax/mail/Session;

    goto :goto_0

    .line 583
    :cond_1
    iput-object p1, p0, Lorg/apache/commons/mail/Email;->session:Ljavax/mail/Session;

    goto :goto_0
.end method

.method public setMailSessionFromJNDI(Ljava/lang/String;)V
    .locals 2
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljavax/naming/NamingException;
        }
    .end annotation

    .prologue
    .line 598
    invoke-static {p1}, Lorg/apache/commons/mail/EmailUtils;->isEmpty(Ljava/lang/String;)Z

    move-result v0

    if-eqz v0, :cond_0

    .line 600
    new-instance v0, Ljava/lang/IllegalArgumentException;

    const-string v1, "JNDI name missing"

    invoke-direct {v0, v1}, Ljava/lang/IllegalArgumentException;-><init>(Ljava/lang/String;)V

    throw v0

    .line 603
    :cond_0
    const-string v0, "java:"

    invoke-virtual {p1, v0}, Ljava/lang/String;->startsWith(Ljava/lang/String;)Z

    move-result v0

    if-eqz v0, :cond_1

    .line 605
    new-instance v0, Ljavax/naming/InitialContext;

    invoke-direct {v0}, Ljavax/naming/InitialContext;-><init>()V

    .line 612
    :goto_0
    invoke-interface {v0, p1}, Ljavax/naming/Context;->lookup(Ljava/lang/String;)Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Ljavax/mail/Session;

    invoke-virtual {p0, v0}, Lorg/apache/commons/mail/Email;->setMailSession(Ljavax/mail/Session;)V

    .line 613
    return-void

    .line 609
    :cond_1
    new-instance v0, Ljavax/naming/InitialContext;

    invoke-direct {v0}, Ljavax/naming/InitialContext;-><init>()V

    const-string v1, "java:comp/env"

    invoke-virtual {v0, v1}, Ljavax/naming/InitialContext;->lookup(Ljava/lang/String;)Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Ljavax/naming/Context;

    goto :goto_0
.end method

.method public abstract setMsg(Ljava/lang/String;)Lorg/apache/commons/mail/Email;
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Lorg/apache/commons/mail/EmailException;
        }
    .end annotation
.end method

.method public setPopBeforeSmtp(ZLjava/lang/String;Ljava/lang/String;Ljava/lang/String;)V
    .locals 0

    .prologue
    .line 1602
    iput-boolean p1, p0, Lorg/apache/commons/mail/Email;->popBeforeSmtp:Z

    .line 1603
    iput-object p2, p0, Lorg/apache/commons/mail/Email;->popHost:Ljava/lang/String;

    .line 1604
    iput-object p3, p0, Lorg/apache/commons/mail/Email;->popUsername:Ljava/lang/String;

    .line 1605
    iput-object p4, p0, Lorg/apache/commons/mail/Email;->popPassword:Ljava/lang/String;

    .line 1606
    return-void
.end method

.method public setReplyTo(Ljava/util/Collection;)Lorg/apache/commons/mail/Email;
    .locals 2
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "(",
            "Ljava/util/Collection",
            "<",
            "Ljavax/mail/internet/InternetAddress;",
            ">;)",
            "Lorg/apache/commons/mail/Email;"
        }
    .end annotation

    .annotation system Ldalvik/annotation/Throws;
        value = {
            Lorg/apache/commons/mail/EmailException;
        }
    .end annotation

    .prologue
    .line 1152
    if-eqz p1, :cond_0

    invoke-interface {p1}, Ljava/util/Collection;->isEmpty()Z

    move-result v0

    if-eqz v0, :cond_1

    .line 1154
    :cond_0
    new-instance v0, Lorg/apache/commons/mail/EmailException;

    const-string v1, "Address List provided was invalid"

    invoke-direct {v0, v1}, Lorg/apache/commons/mail/EmailException;-><init>(Ljava/lang/String;)V

    throw v0

    .line 1157
    :cond_1
    new-instance v0, Ljava/util/ArrayList;

    invoke-direct {v0, p1}, Ljava/util/ArrayList;-><init>(Ljava/util/Collection;)V

    iput-object v0, p0, Lorg/apache/commons/mail/Email;->replyList:Ljava/util/List;

    .line 1158
    return-object p0
.end method

.method public setSSL(Z)V
    .locals 0
    .annotation runtime Ljava/lang/Deprecated;
    .end annotation

    .prologue
    .line 1642
    invoke-virtual {p0, p1}, Lorg/apache/commons/mail/Email;->setSSLOnConnect(Z)Lorg/apache/commons/mail/Email;

    .line 1643
    return-void
.end method

.method public setSSLCheckServerIdentity(Z)Lorg/apache/commons/mail/Email;
    .locals 0

    .prologue
    .line 1680
    invoke-direct {p0}, Lorg/apache/commons/mail/Email;->checkSessionAlreadyInitialized()V

    .line 1681
    iput-boolean p1, p0, Lorg/apache/commons/mail/Email;->sslCheckServerIdentity:Z

    .line 1682
    return-object p0
.end method

.method public setSSLOnConnect(Z)Lorg/apache/commons/mail/Email;
    .locals 0

    .prologue
    .line 1654
    invoke-direct {p0}, Lorg/apache/commons/mail/Email;->checkSessionAlreadyInitialized()V

    .line 1655
    iput-boolean p1, p0, Lorg/apache/commons/mail/Email;->sslOnConnect:Z

    .line 1656
    iput-boolean p1, p0, Lorg/apache/commons/mail/Email;->ssl:Z

    .line 1657
    return-object p0
.end method

.method public setSendPartial(Z)Lorg/apache/commons/mail/Email;
    .locals 0

    .prologue
    .line 1741
    invoke-direct {p0}, Lorg/apache/commons/mail/Email;->checkSessionAlreadyInitialized()V

    .line 1742
    iput-boolean p1, p0, Lorg/apache/commons/mail/Email;->sendPartial:Z

    .line 1743
    return-object p0
.end method

.method public setSentDate(Ljava/util/Date;)V
    .locals 4

    .prologue
    .line 1460
    if-eqz p1, :cond_0

    .line 1463
    new-instance v0, Ljava/util/Date;

    invoke-virtual {p1}, Ljava/util/Date;->getTime()J

    move-result-wide v2

    invoke-direct {v0, v2, v3}, Ljava/util/Date;-><init>(J)V

    iput-object v0, p0, Lorg/apache/commons/mail/Email;->sentDate:Ljava/util/Date;

    .line 1465
    :cond_0
    return-void
.end method

.method public setSmtpPort(I)V
    .locals 3

    .prologue
    .line 529
    invoke-direct {p0}, Lorg/apache/commons/mail/Email;->checkSessionAlreadyInitialized()V

    .line 531
    const/4 v0, 0x1

    if-ge p1, v0, :cond_0

    .line 533
    new-instance v0, Ljava/lang/IllegalArgumentException;

    new-instance v1, Ljava/lang/StringBuilder;

    invoke-direct {v1}, Ljava/lang/StringBuilder;-><init>()V

    const-string v2, "Cannot connect to a port number that is less than 1 ( "

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1, p1}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v1

    const-string v2, " )"

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v1

    invoke-direct {v0, v1}, Ljava/lang/IllegalArgumentException;-><init>(Ljava/lang/String;)V

    throw v0

    .line 539
    :cond_0
    invoke-static {p1}, Ljava/lang/Integer;->toString(I)Ljava/lang/String;

    move-result-object v0

    iput-object v0, p0, Lorg/apache/commons/mail/Email;->smtpPort:Ljava/lang/String;

    .line 540
    return-void
.end method

.method public setSocketConnectionTimeout(I)V
    .locals 0

    .prologue
    .line 1806
    invoke-direct {p0}, Lorg/apache/commons/mail/Email;->checkSessionAlreadyInitialized()V

    .line 1807
    iput p1, p0, Lorg/apache/commons/mail/Email;->socketConnectionTimeout:I

    .line 1808
    return-void
.end method

.method public setSocketTimeout(I)V
    .locals 0

    .prologue
    .line 1830
    invoke-direct {p0}, Lorg/apache/commons/mail/Email;->checkSessionAlreadyInitialized()V

    .line 1831
    iput p1, p0, Lorg/apache/commons/mail/Email;->socketTimeout:I

    .line 1832
    return-void
.end method

.method public setSslSmtpPort(Ljava/lang/String;)V
    .locals 0

    .prologue
    .line 1711
    invoke-direct {p0}, Lorg/apache/commons/mail/Email;->checkSessionAlreadyInitialized()V

    .line 1712
    iput-object p1, p0, Lorg/apache/commons/mail/Email;->sslSmtpPort:Ljava/lang/String;

    .line 1713
    return-void
.end method

.method public setStartTLSEnabled(Z)Lorg/apache/commons/mail/Email;
    .locals 0

    .prologue
    .line 500
    invoke-direct {p0}, Lorg/apache/commons/mail/Email;->checkSessionAlreadyInitialized()V

    .line 501
    iput-boolean p1, p0, Lorg/apache/commons/mail/Email;->startTlsEnabled:Z

    .line 502
    iput-boolean p1, p0, Lorg/apache/commons/mail/Email;->tls:Z

    .line 503
    return-object p0
.end method

.method public setStartTLSRequired(Z)Lorg/apache/commons/mail/Email;
    .locals 0

    .prologue
    .line 515
    invoke-direct {p0}, Lorg/apache/commons/mail/Email;->checkSessionAlreadyInitialized()V

    .line 516
    iput-boolean p1, p0, Lorg/apache/commons/mail/Email;->startTlsRequired:Z

    .line 517
    return-object p0
.end method

.method public setSubject(Ljava/lang/String;)Lorg/apache/commons/mail/Email;
    .locals 0

    .prologue
    .line 1213
    iput-object p1, p0, Lorg/apache/commons/mail/Email;->subject:Ljava/lang/String;

    .line 1214
    return-object p0
.end method

.method public setTLS(Z)V
    .locals 0
    .annotation runtime Ljava/lang/Deprecated;
    .end annotation

    .prologue
    .line 488
    invoke-virtual {p0, p1}, Lorg/apache/commons/mail/Email;->setStartTLSEnabled(Z)Lorg/apache/commons/mail/Email;

    .line 489
    return-void
.end method

.method public setTo(Ljava/util/Collection;)Lorg/apache/commons/mail/Email;
    .locals 2
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "(",
            "Ljava/util/Collection",
            "<",
            "Ljavax/mail/internet/InternetAddress;",
            ">;)",
            "Lorg/apache/commons/mail/Email;"
        }
    .end annotation

    .annotation system Ldalvik/annotation/Throws;
        value = {
            Lorg/apache/commons/mail/EmailException;
        }
    .end annotation

    .prologue
    .line 855
    if-eqz p1, :cond_0

    invoke-interface {p1}, Ljava/util/Collection;->isEmpty()Z

    move-result v0

    if-eqz v0, :cond_1

    .line 857
    :cond_0
    new-instance v0, Lorg/apache/commons/mail/EmailException;

    const-string v1, "Address List provided was invalid"

    invoke-direct {v0, v1}, Lorg/apache/commons/mail/EmailException;-><init>(Ljava/lang/String;)V

    throw v0

    .line 860
    :cond_1
    new-instance v0, Ljava/util/ArrayList;

    invoke-direct {v0, p1}, Ljava/util/ArrayList;-><init>(Ljava/util/Collection;)V

    iput-object v0, p0, Lorg/apache/commons/mail/Email;->toList:Ljava/util/List;

    .line 861
    return-object p0
.end method

.method protected toInternetAddressArray(Ljava/util/List;)[Ljavax/mail/internet/InternetAddress;
    .locals 1
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "(",
            "Ljava/util/List",
            "<",
            "Ljavax/mail/internet/InternetAddress;",
            ">;)[",
            "Ljavax/mail/internet/InternetAddress;"
        }
    .end annotation

    .prologue
    .line 1584
    invoke-interface {p1}, Ljava/util/List;->size()I

    move-result v0

    new-array v0, v0, [Ljavax/mail/internet/InternetAddress;

    invoke-interface {p1, v0}, Ljava/util/List;->toArray([Ljava/lang/Object;)[Ljava/lang/Object;

    move-result-object v0

    check-cast v0, [Ljavax/mail/internet/InternetAddress;

    return-object v0
.end method

.method public updateContentType(Ljava/lang/String;)V
    .locals 4

    .prologue
    const/4 v3, -0x1

    .line 420
    invoke-static {p1}, Lorg/apache/commons/mail/EmailUtils;->isEmpty(Ljava/lang/String;)Z

    move-result v0

    if-eqz v0, :cond_1

    .line 422
    const/4 v0, 0x0

    iput-object v0, p0, Lorg/apache/commons/mail/Email;->contentType:Ljava/lang/String;

    .line 463
    :cond_0
    :goto_0
    return-void

    .line 427
    :cond_1
    iput-object p1, p0, Lorg/apache/commons/mail/Email;->contentType:Ljava/lang/String;

    .line 430
    const-string v0, "; charset="

    .line 431
    invoke-virtual {p1}, Ljava/lang/String;->toLowerCase()Ljava/lang/String;

    move-result-object v0

    const-string v1, "; charset="

    invoke-virtual {v0, v1}, Ljava/lang/String;->indexOf(Ljava/lang/String;)I

    move-result v0

    .line 433
    if-eq v0, v3, :cond_3

    .line 436
    const-string v1, "; charset="

    invoke-virtual {v1}, Ljava/lang/String;->length()I

    move-result v1

    add-int/2addr v0, v1

    .line 437
    invoke-virtual {p1}, Ljava/lang/String;->toLowerCase()Ljava/lang/String;

    move-result-object v1

    const-string v2, " "

    invoke-virtual {v1, v2, v0}, Ljava/lang/String;->indexOf(Ljava/lang/String;I)I

    move-result v1

    .line 440
    if-eq v1, v3, :cond_2

    .line 442
    invoke-virtual {p1, v0, v1}, Ljava/lang/String;->substring(II)Ljava/lang/String;

    move-result-object v0

    iput-object v0, p0, Lorg/apache/commons/mail/Email;->charset:Ljava/lang/String;

    goto :goto_0

    .line 447
    :cond_2
    invoke-virtual {p1, v0}, Ljava/lang/String;->substring(I)Ljava/lang/String;

    move-result-object v0

    iput-object v0, p0, Lorg/apache/commons/mail/Email;->charset:Ljava/lang/String;

    goto :goto_0

    .line 454
    :cond_3
    iget-object v0, p0, Lorg/apache/commons/mail/Email;->contentType:Ljava/lang/String;

    const-string v1, "text/"

    invoke-virtual {v0, v1}, Ljava/lang/String;->startsWith(Ljava/lang/String;)Z

    move-result v0

    if-eqz v0, :cond_0

    iget-object v0, p0, Lorg/apache/commons/mail/Email;->charset:Ljava/lang/String;

    invoke-static {v0}, Lorg/apache/commons/mail/EmailUtils;->isNotEmpty(Ljava/lang/String;)Z

    move-result v0

    if-eqz v0, :cond_0

    .line 456
    new-instance v0, Ljava/lang/StringBuffer;

    iget-object v1, p0, Lorg/apache/commons/mail/Email;->contentType:Ljava/lang/String;

    invoke-direct {v0, v1}, Ljava/lang/StringBuffer;-><init>(Ljava/lang/String;)V

    .line 457
    const-string v1, "; charset="

    invoke-virtual {v0, v1}, Ljava/lang/StringBuffer;->append(Ljava/lang/String;)Ljava/lang/StringBuffer;

    .line 458
    iget-object v1, p0, Lorg/apache/commons/mail/Email;->charset:Ljava/lang/String;

    invoke-virtual {v0, v1}, Ljava/lang/StringBuffer;->append(Ljava/lang/String;)Ljava/lang/StringBuffer;

    .line 459
    invoke-virtual {v0}, Ljava/lang/StringBuffer;->toString()Ljava/lang/String;

    move-result-object v0

    iput-object v0, p0, Lorg/apache/commons/mail/Email;->contentType:Ljava/lang/String;

    goto :goto_0
.end method
