.class public Lcom/sun/mail/imap/IMAPStore;
.super Ljavax/mail/Store;
.source "SourceFile"

# interfaces
.implements Lcom/sun/mail/iap/ResponseHandler;
.implements Ljavax/mail/QuotaAwareStore;


# annotations
.annotation system Ldalvik/annotation/MemberClasses;
    value = {
        Lcom/sun/mail/imap/IMAPStore$ConnectionPool;
    }
.end annotation


# static fields
.field static final synthetic $assertionsDisabled:Z

.field public static final RESPONSE:I = 0x3e8


# instance fields
.field private appendBufferSize:I

.field private authorizationID:Ljava/lang/String;

.field private blksize:I

.field private volatile connected:Z

.field private defaultPort:I

.field private disableAuthLogin:Z

.field private disableAuthPlain:Z

.field private enableImapEvents:Z

.field private enableSASL:Z

.field private enableStartTLS:Z

.field private forcePasswordRefresh:Z

.field private host:Ljava/lang/String;

.field private isSSL:Z

.field private minIdleTime:I

.field private name:Ljava/lang/String;

.field private namespaces:Lcom/sun/mail/imap/protocol/Namespaces;

.field private out:Ljava/io/PrintStream;

.field private password:Ljava/lang/String;

.field private pool:Lcom/sun/mail/imap/IMAPStore$ConnectionPool;

.field private port:I

.field private proxyAuthUser:Ljava/lang/String;

.field private saslMechanisms:[Ljava/lang/String;

.field private saslRealm:Ljava/lang/String;

.field private statusCacheTimeout:I

.field private user:Ljava/lang/String;


# direct methods
.method static constructor <clinit>()V
    .locals 1

    .prologue
    .line 133
    const-class v0, Lcom/sun/mail/imap/IMAPStore;

    invoke-virtual {v0}, Ljava/lang/Class;->desiredAssertionStatus()Z

    move-result v0

    if-nez v0, :cond_0

    const/4 v0, 0x1

    :goto_0
    sput-boolean v0, Lcom/sun/mail/imap/IMAPStore;->$assertionsDisabled:Z

    return-void

    :cond_0
    const/4 v0, 0x0

    goto :goto_0
.end method

.method public constructor <init>(Ljavax/mail/Session;Ljavax/mail/URLName;)V
    .locals 6

    .prologue
    .line 279
    const-string v3, "imap"

    const/16 v4, 0x8f

    const/4 v5, 0x0

    move-object v0, p0

    move-object v1, p1

    move-object v2, p2

    invoke-direct/range {v0 .. v5}, Lcom/sun/mail/imap/IMAPStore;-><init>(Ljavax/mail/Session;Ljavax/mail/URLName;Ljava/lang/String;IZ)V

    .line 280
    return-void
.end method

.method protected constructor <init>(Ljavax/mail/Session;Ljavax/mail/URLName;Ljava/lang/String;IZ)V
    .locals 6

    .prologue
    const/4 v5, -0x1

    const/4 v4, 0x1

    const/4 v1, 0x0

    .line 287
    invoke-direct {p0, p1, p2}, Ljavax/mail/Store;-><init>(Ljavax/mail/Session;Ljavax/mail/URLName;)V

    .line 143
    const-string v0, "imap"

    iput-object v0, p0, Lcom/sun/mail/imap/IMAPStore;->name:Ljava/lang/String;

    .line 144
    const/16 v0, 0x8f

    iput v0, p0, Lcom/sun/mail/imap/IMAPStore;->defaultPort:I

    .line 145
    iput-boolean v1, p0, Lcom/sun/mail/imap/IMAPStore;->isSSL:Z

    .line 147
    iput v5, p0, Lcom/sun/mail/imap/IMAPStore;->port:I

    .line 148
    const/16 v0, 0x4000

    iput v0, p0, Lcom/sun/mail/imap/IMAPStore;->blksize:I

    .line 152
    const/16 v0, 0x3e8

    iput v0, p0, Lcom/sun/mail/imap/IMAPStore;->statusCacheTimeout:I

    .line 154
    iput v5, p0, Lcom/sun/mail/imap/IMAPStore;->appendBufferSize:I

    .line 156
    const/16 v0, 0xa

    iput v0, p0, Lcom/sun/mail/imap/IMAPStore;->minIdleTime:I

    .line 168
    iput-boolean v1, p0, Lcom/sun/mail/imap/IMAPStore;->disableAuthLogin:Z

    .line 169
    iput-boolean v1, p0, Lcom/sun/mail/imap/IMAPStore;->disableAuthPlain:Z

    .line 170
    iput-boolean v1, p0, Lcom/sun/mail/imap/IMAPStore;->enableStartTLS:Z

    .line 171
    iput-boolean v1, p0, Lcom/sun/mail/imap/IMAPStore;->enableSASL:Z

    .line 173
    iput-boolean v1, p0, Lcom/sun/mail/imap/IMAPStore;->forcePasswordRefresh:Z

    .line 175
    iput-boolean v1, p0, Lcom/sun/mail/imap/IMAPStore;->enableImapEvents:Z

    .line 183
    iput-boolean v1, p0, Lcom/sun/mail/imap/IMAPStore;->connected:Z

    .line 271
    new-instance v0, Lcom/sun/mail/imap/IMAPStore$ConnectionPool;

    invoke-direct {v0}, Lcom/sun/mail/imap/IMAPStore$ConnectionPool;-><init>()V

    iput-object v0, p0, Lcom/sun/mail/imap/IMAPStore;->pool:Lcom/sun/mail/imap/IMAPStore$ConnectionPool;

    .line 288
    if-eqz p2, :cond_0

    .line 289
    invoke-virtual {p2}, Ljavax/mail/URLName;->getProtocol()Ljava/lang/String;

    move-result-object p3

    .line 290
    :cond_0
    iput-object p3, p0, Lcom/sun/mail/imap/IMAPStore;->name:Ljava/lang/String;

    .line 291
    iput p4, p0, Lcom/sun/mail/imap/IMAPStore;->defaultPort:I

    .line 292
    iput-boolean p5, p0, Lcom/sun/mail/imap/IMAPStore;->isSSL:Z

    .line 294
    iget-object v0, p0, Lcom/sun/mail/imap/IMAPStore;->pool:Lcom/sun/mail/imap/IMAPStore$ConnectionPool;

    invoke-static {}, Ljava/lang/System;->currentTimeMillis()J

    move-result-wide v2

    invoke-static {v0, v2, v3}, Lcom/sun/mail/imap/IMAPStore$ConnectionPool;->access$0(Lcom/sun/mail/imap/IMAPStore$ConnectionPool;J)V

    .line 296
    invoke-virtual {p1}, Ljavax/mail/Session;->getDebug()Z

    move-result v0

    iput-boolean v0, p0, Lcom/sun/mail/imap/IMAPStore;->debug:Z

    .line 297
    invoke-virtual {p1}, Ljavax/mail/Session;->getDebugOut()Ljava/io/PrintStream;

    move-result-object v0

    iput-object v0, p0, Lcom/sun/mail/imap/IMAPStore;->out:Ljava/io/PrintStream;

    .line 298
    iget-object v0, p0, Lcom/sun/mail/imap/IMAPStore;->out:Ljava/io/PrintStream;

    if-nez v0, :cond_1

    .line 299
    sget-object v0, Ljava/lang/System;->out:Ljava/io/PrintStream;

    iput-object v0, p0, Lcom/sun/mail/imap/IMAPStore;->out:Ljava/io/PrintStream;

    .line 302
    :cond_1
    new-instance v0, Ljava/lang/StringBuilder;

    const-string v1, "mail."

    invoke-direct {v0, v1}, Ljava/lang/StringBuilder;-><init>(Ljava/lang/String;)V

    invoke-virtual {v0, p3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    const-string v1, ".connectionpool.debug"

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-virtual {v0}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v0

    .line 301
    invoke-virtual {p1, v0}, Ljavax/mail/Session;->getProperty(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v0

    .line 304
    if-eqz v0, :cond_2

    const-string v1, "true"

    invoke-virtual {v0, v1}, Ljava/lang/String;->equalsIgnoreCase(Ljava/lang/String;)Z

    move-result v0

    if-eqz v0, :cond_2

    .line 305
    iget-object v0, p0, Lcom/sun/mail/imap/IMAPStore;->pool:Lcom/sun/mail/imap/IMAPStore$ConnectionPool;

    invoke-static {v0, v4}, Lcom/sun/mail/imap/IMAPStore$ConnectionPool;->access$1(Lcom/sun/mail/imap/IMAPStore$ConnectionPool;Z)V

    .line 307
    :cond_2
    new-instance v0, Ljava/lang/StringBuilder;

    const-string v1, "mail."

    invoke-direct {v0, v1}, Ljava/lang/StringBuilder;-><init>(Ljava/lang/String;)V

    invoke-virtual {v0, p3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    const-string v1, ".partialfetch"

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-virtual {v0}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v0

    invoke-virtual {p1, v0}, Ljavax/mail/Session;->getProperty(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v0

    .line 309
    if-eqz v0, :cond_21

    const-string v1, "false"

    invoke-virtual {v0, v1}, Ljava/lang/String;->equalsIgnoreCase(Ljava/lang/String;)Z

    move-result v0

    if-eqz v0, :cond_21

    .line 311
    iput v5, p0, Lcom/sun/mail/imap/IMAPStore;->blksize:I

    .line 312
    iget-boolean v0, p0, Lcom/sun/mail/imap/IMAPStore;->debug:Z

    if-eqz v0, :cond_3

    .line 313
    iget-object v0, p0, Lcom/sun/mail/imap/IMAPStore;->out:Ljava/io/PrintStream;

    const-string v1, "DEBUG: mail.imap.partialfetch: false"

    invoke-virtual {v0, v1}, Ljava/io/PrintStream;->println(Ljava/lang/String;)V

    .line 323
    :cond_3
    :goto_0
    new-instance v0, Ljava/lang/StringBuilder;

    const-string v1, "mail."

    invoke-direct {v0, v1}, Ljava/lang/StringBuilder;-><init>(Ljava/lang/String;)V

    invoke-virtual {v0, p3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    const-string v1, ".statuscachetimeout"

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-virtual {v0}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v0

    invoke-virtual {p1, v0}, Ljavax/mail/Session;->getProperty(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v0

    .line 324
    if-eqz v0, :cond_4

    .line 325
    invoke-static {v0}, Ljava/lang/Integer;->parseInt(Ljava/lang/String;)I

    move-result v0

    iput v0, p0, Lcom/sun/mail/imap/IMAPStore;->statusCacheTimeout:I

    .line 326
    iget-boolean v0, p0, Lcom/sun/mail/imap/IMAPStore;->debug:Z

    if-eqz v0, :cond_4

    .line 327
    iget-object v0, p0, Lcom/sun/mail/imap/IMAPStore;->out:Ljava/io/PrintStream;

    new-instance v1, Ljava/lang/StringBuilder;

    const-string v2, "DEBUG: mail.imap.statuscachetimeout: "

    invoke-direct {v1, v2}, Ljava/lang/StringBuilder;-><init>(Ljava/lang/String;)V

    .line 328
    iget v2, p0, Lcom/sun/mail/imap/IMAPStore;->statusCacheTimeout:I

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v1

    .line 327
    invoke-virtual {v0, v1}, Ljava/io/PrintStream;->println(Ljava/lang/String;)V

    .line 330
    :cond_4
    new-instance v0, Ljava/lang/StringBuilder;

    const-string v1, "mail."

    invoke-direct {v0, v1}, Ljava/lang/StringBuilder;-><init>(Ljava/lang/String;)V

    invoke-virtual {v0, p3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    const-string v1, ".appendbuffersize"

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-virtual {v0}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v0

    invoke-virtual {p1, v0}, Ljavax/mail/Session;->getProperty(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v0

    .line 331
    if-eqz v0, :cond_5

    .line 332
    invoke-static {v0}, Ljava/lang/Integer;->parseInt(Ljava/lang/String;)I

    move-result v0

    iput v0, p0, Lcom/sun/mail/imap/IMAPStore;->appendBufferSize:I

    .line 333
    iget-boolean v0, p0, Lcom/sun/mail/imap/IMAPStore;->debug:Z

    if-eqz v0, :cond_5

    .line 334
    iget-object v0, p0, Lcom/sun/mail/imap/IMAPStore;->out:Ljava/io/PrintStream;

    new-instance v1, Ljava/lang/StringBuilder;

    const-string v2, "DEBUG: mail.imap.appendbuffersize: "

    invoke-direct {v1, v2}, Ljava/lang/StringBuilder;-><init>(Ljava/lang/String;)V

    .line 335
    iget v2, p0, Lcom/sun/mail/imap/IMAPStore;->appendBufferSize:I

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v1

    .line 334
    invoke-virtual {v0, v1}, Ljava/io/PrintStream;->println(Ljava/lang/String;)V

    .line 337
    :cond_5
    new-instance v0, Ljava/lang/StringBuilder;

    const-string v1, "mail."

    invoke-direct {v0, v1}, Ljava/lang/StringBuilder;-><init>(Ljava/lang/String;)V

    invoke-virtual {v0, p3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    const-string v1, ".minidletime"

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-virtual {v0}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v0

    invoke-virtual {p1, v0}, Ljavax/mail/Session;->getProperty(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v0

    .line 338
    if-eqz v0, :cond_6

    .line 339
    invoke-static {v0}, Ljava/lang/Integer;->parseInt(Ljava/lang/String;)I

    move-result v0

    iput v0, p0, Lcom/sun/mail/imap/IMAPStore;->minIdleTime:I

    .line 340
    iget-boolean v0, p0, Lcom/sun/mail/imap/IMAPStore;->debug:Z

    if-eqz v0, :cond_6

    .line 341
    iget-object v0, p0, Lcom/sun/mail/imap/IMAPStore;->out:Ljava/io/PrintStream;

    new-instance v1, Ljava/lang/StringBuilder;

    const-string v2, "DEBUG: mail.imap.minidletime: "

    invoke-direct {v1, v2}, Ljava/lang/StringBuilder;-><init>(Ljava/lang/String;)V

    iget v2, p0, Lcom/sun/mail/imap/IMAPStore;->minIdleTime:I

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v1

    invoke-virtual {v0, v1}, Ljava/io/PrintStream;->println(Ljava/lang/String;)V

    .line 345
    :cond_6
    new-instance v0, Ljava/lang/StringBuilder;

    const-string v1, "mail."

    invoke-direct {v0, v1}, Ljava/lang/StringBuilder;-><init>(Ljava/lang/String;)V

    invoke-virtual {v0, p3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    const-string v1, ".connectionpoolsize"

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-virtual {v0}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v0

    invoke-virtual {p1, v0}, Ljavax/mail/Session;->getProperty(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v0

    .line 346
    if-eqz v0, :cond_8

    .line 348
    :try_start_0
    invoke-static {v0}, Ljava/lang/Integer;->parseInt(Ljava/lang/String;)I

    move-result v0

    .line 349
    if-lez v0, :cond_7

    .line 350
    iget-object v1, p0, Lcom/sun/mail/imap/IMAPStore;->pool:Lcom/sun/mail/imap/IMAPStore$ConnectionPool;

    invoke-static {v1, v0}, Lcom/sun/mail/imap/IMAPStore$ConnectionPool;->access$2(Lcom/sun/mail/imap/IMAPStore$ConnectionPool;I)V
    :try_end_0
    .catch Ljava/lang/NumberFormatException; {:try_start_0 .. :try_end_0} :catch_2

    .line 353
    :cond_7
    :goto_1
    iget-object v0, p0, Lcom/sun/mail/imap/IMAPStore;->pool:Lcom/sun/mail/imap/IMAPStore$ConnectionPool;

    invoke-static {v0}, Lcom/sun/mail/imap/IMAPStore$ConnectionPool;->access$3(Lcom/sun/mail/imap/IMAPStore$ConnectionPool;)Z

    move-result v0

    if-eqz v0, :cond_8

    .line 354
    iget-object v0, p0, Lcom/sun/mail/imap/IMAPStore;->out:Ljava/io/PrintStream;

    new-instance v1, Ljava/lang/StringBuilder;

    const-string v2, "DEBUG: mail.imap.connectionpoolsize: "

    invoke-direct {v1, v2}, Ljava/lang/StringBuilder;-><init>(Ljava/lang/String;)V

    .line 355
    iget-object v2, p0, Lcom/sun/mail/imap/IMAPStore;->pool:Lcom/sun/mail/imap/IMAPStore$ConnectionPool;

    invoke-static {v2}, Lcom/sun/mail/imap/IMAPStore$ConnectionPool;->access$4(Lcom/sun/mail/imap/IMAPStore$ConnectionPool;)I

    move-result v2

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v1

    .line 354
    invoke-virtual {v0, v1}, Ljava/io/PrintStream;->println(Ljava/lang/String;)V

    .line 360
    :cond_8
    new-instance v0, Ljava/lang/StringBuilder;

    const-string v1, "mail."

    invoke-direct {v0, v1}, Ljava/lang/StringBuilder;-><init>(Ljava/lang/String;)V

    invoke-virtual {v0, p3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    const-string v1, ".connectionpooltimeout"

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-virtual {v0}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v0

    invoke-virtual {p1, v0}, Ljavax/mail/Session;->getProperty(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v0

    .line 361
    if-eqz v0, :cond_a

    .line 363
    :try_start_1
    invoke-static {v0}, Ljava/lang/Integer;->parseInt(Ljava/lang/String;)I

    move-result v0

    .line 364
    if-lez v0, :cond_9

    .line 365
    iget-object v1, p0, Lcom/sun/mail/imap/IMAPStore;->pool:Lcom/sun/mail/imap/IMAPStore$ConnectionPool;

    int-to-long v2, v0

    invoke-static {v1, v2, v3}, Lcom/sun/mail/imap/IMAPStore$ConnectionPool;->access$5(Lcom/sun/mail/imap/IMAPStore$ConnectionPool;J)V
    :try_end_1
    .catch Ljava/lang/NumberFormatException; {:try_start_1 .. :try_end_1} :catch_1

    .line 368
    :cond_9
    :goto_2
    iget-object v0, p0, Lcom/sun/mail/imap/IMAPStore;->pool:Lcom/sun/mail/imap/IMAPStore$ConnectionPool;

    invoke-static {v0}, Lcom/sun/mail/imap/IMAPStore$ConnectionPool;->access$3(Lcom/sun/mail/imap/IMAPStore$ConnectionPool;)Z

    move-result v0

    if-eqz v0, :cond_a

    .line 369
    iget-object v0, p0, Lcom/sun/mail/imap/IMAPStore;->out:Ljava/io/PrintStream;

    new-instance v1, Ljava/lang/StringBuilder;

    const-string v2, "DEBUG: mail.imap.connectionpooltimeout: "

    invoke-direct {v1, v2}, Ljava/lang/StringBuilder;-><init>(Ljava/lang/String;)V

    .line 370
    iget-object v2, p0, Lcom/sun/mail/imap/IMAPStore;->pool:Lcom/sun/mail/imap/IMAPStore$ConnectionPool;

    invoke-static {v2}, Lcom/sun/mail/imap/IMAPStore$ConnectionPool;->access$6(Lcom/sun/mail/imap/IMAPStore$ConnectionPool;)J

    move-result-wide v2

    invoke-virtual {v1, v2, v3}, Ljava/lang/StringBuilder;->append(J)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v1

    .line 369
    invoke-virtual {v0, v1}, Ljava/io/PrintStream;->println(Ljava/lang/String;)V

    .line 374
    :cond_a
    new-instance v0, Ljava/lang/StringBuilder;

    const-string v1, "mail."

    invoke-direct {v0, v1}, Ljava/lang/StringBuilder;-><init>(Ljava/lang/String;)V

    invoke-virtual {v0, p3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    const-string v1, ".servertimeout"

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-virtual {v0}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v0

    invoke-virtual {p1, v0}, Ljavax/mail/Session;->getProperty(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v0

    .line 375
    if-eqz v0, :cond_c

    .line 377
    :try_start_2
    invoke-static {v0}, Ljava/lang/Integer;->parseInt(Ljava/lang/String;)I

    move-result v0

    .line 378
    if-lez v0, :cond_b

    .line 379
    iget-object v1, p0, Lcom/sun/mail/imap/IMAPStore;->pool:Lcom/sun/mail/imap/IMAPStore$ConnectionPool;

    int-to-long v2, v0

    invoke-static {v1, v2, v3}, Lcom/sun/mail/imap/IMAPStore$ConnectionPool;->access$7(Lcom/sun/mail/imap/IMAPStore$ConnectionPool;J)V
    :try_end_2
    .catch Ljava/lang/NumberFormatException; {:try_start_2 .. :try_end_2} :catch_0

    .line 382
    :cond_b
    :goto_3
    iget-object v0, p0, Lcom/sun/mail/imap/IMAPStore;->pool:Lcom/sun/mail/imap/IMAPStore$ConnectionPool;

    invoke-static {v0}, Lcom/sun/mail/imap/IMAPStore$ConnectionPool;->access$3(Lcom/sun/mail/imap/IMAPStore$ConnectionPool;)Z

    move-result v0

    if-eqz v0, :cond_c

    .line 383
    iget-object v0, p0, Lcom/sun/mail/imap/IMAPStore;->out:Ljava/io/PrintStream;

    new-instance v1, Ljava/lang/StringBuilder;

    const-string v2, "DEBUG: mail.imap.servertimeout: "

    invoke-direct {v1, v2}, Ljava/lang/StringBuilder;-><init>(Ljava/lang/String;)V

    .line 384
    iget-object v2, p0, Lcom/sun/mail/imap/IMAPStore;->pool:Lcom/sun/mail/imap/IMAPStore$ConnectionPool;

    invoke-static {v2}, Lcom/sun/mail/imap/IMAPStore$ConnectionPool;->access$8(Lcom/sun/mail/imap/IMAPStore$ConnectionPool;)J

    move-result-wide v2

    invoke-virtual {v1, v2, v3}, Ljava/lang/StringBuilder;->append(J)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v1

    .line 383
    invoke-virtual {v0, v1}, Ljava/io/PrintStream;->println(Ljava/lang/String;)V

    .line 389
    :cond_c
    new-instance v0, Ljava/lang/StringBuilder;

    const-string v1, "mail."

    invoke-direct {v0, v1}, Ljava/lang/StringBuilder;-><init>(Ljava/lang/String;)V

    invoke-virtual {v0, p3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    const-string v1, ".separatestoreconnection"

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-virtual {v0}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v0

    invoke-virtual {p1, v0}, Ljavax/mail/Session;->getProperty(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v0

    .line 390
    if-eqz v0, :cond_e

    const-string v1, "true"

    invoke-virtual {v0, v1}, Ljava/lang/String;->equalsIgnoreCase(Ljava/lang/String;)Z

    move-result v0

    if-eqz v0, :cond_e

    .line 391
    iget-object v0, p0, Lcom/sun/mail/imap/IMAPStore;->pool:Lcom/sun/mail/imap/IMAPStore$ConnectionPool;

    invoke-static {v0}, Lcom/sun/mail/imap/IMAPStore$ConnectionPool;->access$3(Lcom/sun/mail/imap/IMAPStore$ConnectionPool;)Z

    move-result v0

    if-eqz v0, :cond_d

    .line 392
    iget-object v0, p0, Lcom/sun/mail/imap/IMAPStore;->out:Ljava/io/PrintStream;

    const-string v1, "DEBUG: dedicate a store connection"

    invoke-virtual {v0, v1}, Ljava/io/PrintStream;->println(Ljava/lang/String;)V

    .line 393
    :cond_d
    iget-object v0, p0, Lcom/sun/mail/imap/IMAPStore;->pool:Lcom/sun/mail/imap/IMAPStore$ConnectionPool;

    invoke-static {v0, v4}, Lcom/sun/mail/imap/IMAPStore$ConnectionPool;->access$9(Lcom/sun/mail/imap/IMAPStore$ConnectionPool;Z)V

    .line 397
    :cond_e
    new-instance v0, Ljava/lang/StringBuilder;

    const-string v1, "mail."

    invoke-direct {v0, v1}, Ljava/lang/StringBuilder;-><init>(Ljava/lang/String;)V

    invoke-virtual {v0, p3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    const-string v1, ".proxyauth.user"

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-virtual {v0}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v0

    invoke-virtual {p1, v0}, Ljavax/mail/Session;->getProperty(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v0

    .line 398
    if-eqz v0, :cond_f

    .line 399
    iput-object v0, p0, Lcom/sun/mail/imap/IMAPStore;->proxyAuthUser:Ljava/lang/String;

    .line 400
    iget-boolean v0, p0, Lcom/sun/mail/imap/IMAPStore;->debug:Z

    if-eqz v0, :cond_f

    .line 401
    iget-object v0, p0, Lcom/sun/mail/imap/IMAPStore;->out:Ljava/io/PrintStream;

    new-instance v1, Ljava/lang/StringBuilder;

    const-string v2, "DEBUG: mail.imap.proxyauth.user: "

    invoke-direct {v1, v2}, Ljava/lang/StringBuilder;-><init>(Ljava/lang/String;)V

    .line 402
    iget-object v2, p0, Lcom/sun/mail/imap/IMAPStore;->proxyAuthUser:Ljava/lang/String;

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v1

    .line 401
    invoke-virtual {v0, v1}, Ljava/io/PrintStream;->println(Ljava/lang/String;)V

    .line 406
    :cond_f
    new-instance v0, Ljava/lang/StringBuilder;

    const-string v1, "mail."

    invoke-direct {v0, v1}, Ljava/lang/StringBuilder;-><init>(Ljava/lang/String;)V

    invoke-virtual {v0, p3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    const-string v1, ".auth.login.disable"

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-virtual {v0}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v0

    invoke-virtual {p1, v0}, Ljavax/mail/Session;->getProperty(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v0

    .line 407
    if-eqz v0, :cond_11

    const-string v1, "true"

    invoke-virtual {v0, v1}, Ljava/lang/String;->equalsIgnoreCase(Ljava/lang/String;)Z

    move-result v0

    if-eqz v0, :cond_11

    .line 408
    iget-boolean v0, p0, Lcom/sun/mail/imap/IMAPStore;->debug:Z

    if-eqz v0, :cond_10

    .line 409
    iget-object v0, p0, Lcom/sun/mail/imap/IMAPStore;->out:Ljava/io/PrintStream;

    const-string v1, "DEBUG: disable AUTH=LOGIN"

    invoke-virtual {v0, v1}, Ljava/io/PrintStream;->println(Ljava/lang/String;)V

    .line 410
    :cond_10
    iput-boolean v4, p0, Lcom/sun/mail/imap/IMAPStore;->disableAuthLogin:Z

    .line 414
    :cond_11
    new-instance v0, Ljava/lang/StringBuilder;

    const-string v1, "mail."

    invoke-direct {v0, v1}, Ljava/lang/StringBuilder;-><init>(Ljava/lang/String;)V

    invoke-virtual {v0, p3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    const-string v1, ".auth.plain.disable"

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-virtual {v0}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v0

    invoke-virtual {p1, v0}, Ljavax/mail/Session;->getProperty(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v0

    .line 415
    if-eqz v0, :cond_13

    const-string v1, "true"

    invoke-virtual {v0, v1}, Ljava/lang/String;->equalsIgnoreCase(Ljava/lang/String;)Z

    move-result v0

    if-eqz v0, :cond_13

    .line 416
    iget-boolean v0, p0, Lcom/sun/mail/imap/IMAPStore;->debug:Z

    if-eqz v0, :cond_12

    .line 417
    iget-object v0, p0, Lcom/sun/mail/imap/IMAPStore;->out:Ljava/io/PrintStream;

    const-string v1, "DEBUG: disable AUTH=PLAIN"

    invoke-virtual {v0, v1}, Ljava/io/PrintStream;->println(Ljava/lang/String;)V

    .line 418
    :cond_12
    iput-boolean v4, p0, Lcom/sun/mail/imap/IMAPStore;->disableAuthPlain:Z

    .line 422
    :cond_13
    new-instance v0, Ljava/lang/StringBuilder;

    const-string v1, "mail."

    invoke-direct {v0, v1}, Ljava/lang/StringBuilder;-><init>(Ljava/lang/String;)V

    invoke-virtual {v0, p3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    const-string v1, ".starttls.enable"

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-virtual {v0}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v0

    invoke-virtual {p1, v0}, Ljavax/mail/Session;->getProperty(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v0

    .line 423
    if-eqz v0, :cond_15

    const-string v1, "true"

    invoke-virtual {v0, v1}, Ljava/lang/String;->equalsIgnoreCase(Ljava/lang/String;)Z

    move-result v0

    if-eqz v0, :cond_15

    .line 424
    iget-boolean v0, p0, Lcom/sun/mail/imap/IMAPStore;->debug:Z

    if-eqz v0, :cond_14

    .line 425
    iget-object v0, p0, Lcom/sun/mail/imap/IMAPStore;->out:Ljava/io/PrintStream;

    const-string v1, "DEBUG: enable STARTTLS"

    invoke-virtual {v0, v1}, Ljava/io/PrintStream;->println(Ljava/lang/String;)V

    .line 426
    :cond_14
    iput-boolean v4, p0, Lcom/sun/mail/imap/IMAPStore;->enableStartTLS:Z

    .line 430
    :cond_15
    new-instance v0, Ljava/lang/StringBuilder;

    const-string v1, "mail."

    invoke-direct {v0, v1}, Ljava/lang/StringBuilder;-><init>(Ljava/lang/String;)V

    invoke-virtual {v0, p3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    const-string v1, ".sasl.enable"

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-virtual {v0}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v0

    invoke-virtual {p1, v0}, Ljavax/mail/Session;->getProperty(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v0

    .line 431
    if-eqz v0, :cond_17

    const-string v1, "true"

    invoke-virtual {v0, v1}, Ljava/lang/String;->equalsIgnoreCase(Ljava/lang/String;)Z

    move-result v0

    if-eqz v0, :cond_17

    .line 432
    iget-boolean v0, p0, Lcom/sun/mail/imap/IMAPStore;->debug:Z

    if-eqz v0, :cond_16

    .line 433
    iget-object v0, p0, Lcom/sun/mail/imap/IMAPStore;->out:Ljava/io/PrintStream;

    const-string v1, "DEBUG: enable SASL"

    invoke-virtual {v0, v1}, Ljava/io/PrintStream;->println(Ljava/lang/String;)V

    .line 434
    :cond_16
    iput-boolean v4, p0, Lcom/sun/mail/imap/IMAPStore;->enableSASL:Z

    .line 438
    :cond_17
    iget-boolean v0, p0, Lcom/sun/mail/imap/IMAPStore;->enableSASL:Z

    if-eqz v0, :cond_1a

    .line 439
    new-instance v0, Ljava/lang/StringBuilder;

    const-string v1, "mail."

    invoke-direct {v0, v1}, Ljava/lang/StringBuilder;-><init>(Ljava/lang/String;)V

    invoke-virtual {v0, p3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    const-string v1, ".sasl.mechanisms"

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-virtual {v0}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v0

    invoke-virtual {p1, v0}, Ljavax/mail/Session;->getProperty(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v0

    .line 440
    if-eqz v0, :cond_1a

    invoke-virtual {v0}, Ljava/lang/String;->length()I

    move-result v1

    if-lez v1, :cond_1a

    .line 441
    iget-boolean v1, p0, Lcom/sun/mail/imap/IMAPStore;->debug:Z

    if-eqz v1, :cond_18

    .line 442
    iget-object v1, p0, Lcom/sun/mail/imap/IMAPStore;->out:Ljava/io/PrintStream;

    new-instance v2, Ljava/lang/StringBuilder;

    const-string v3, "DEBUG: SASL mechanisms allowed: "

    invoke-direct {v2, v3}, Ljava/lang/StringBuilder;-><init>(Ljava/lang/String;)V

    invoke-virtual {v2, v0}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    invoke-virtual {v2}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v2

    invoke-virtual {v1, v2}, Ljava/io/PrintStream;->println(Ljava/lang/String;)V

    .line 443
    :cond_18
    new-instance v1, Ljava/util/Vector;

    const/4 v2, 0x5

    invoke-direct {v1, v2}, Ljava/util/Vector;-><init>(I)V

    .line 444
    new-instance v2, Ljava/util/StringTokenizer;

    const-string v3, " ,"

    invoke-direct {v2, v0, v3}, Ljava/util/StringTokenizer;-><init>(Ljava/lang/String;Ljava/lang/String;)V

    .line 445
    :cond_19
    :goto_4
    invoke-virtual {v2}, Ljava/util/StringTokenizer;->hasMoreTokens()Z

    move-result v0

    if-nez v0, :cond_23

    .line 450
    invoke-virtual {v1}, Ljava/util/Vector;->size()I

    move-result v0

    new-array v0, v0, [Ljava/lang/String;

    iput-object v0, p0, Lcom/sun/mail/imap/IMAPStore;->saslMechanisms:[Ljava/lang/String;

    .line 451
    iget-object v0, p0, Lcom/sun/mail/imap/IMAPStore;->saslMechanisms:[Ljava/lang/String;

    invoke-virtual {v1, v0}, Ljava/util/Vector;->copyInto([Ljava/lang/Object;)V

    .line 456
    :cond_1a
    new-instance v0, Ljava/lang/StringBuilder;

    const-string v1, "mail."

    invoke-direct {v0, v1}, Ljava/lang/StringBuilder;-><init>(Ljava/lang/String;)V

    invoke-virtual {v0, p3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    const-string v1, ".sasl.authorizationid"

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-virtual {v0}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v0

    invoke-virtual {p1, v0}, Ljavax/mail/Session;->getProperty(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v0

    .line 457
    if-eqz v0, :cond_1b

    .line 458
    iput-object v0, p0, Lcom/sun/mail/imap/IMAPStore;->authorizationID:Ljava/lang/String;

    .line 459
    iget-boolean v0, p0, Lcom/sun/mail/imap/IMAPStore;->debug:Z

    if-eqz v0, :cond_1b

    .line 460
    iget-object v0, p0, Lcom/sun/mail/imap/IMAPStore;->out:Ljava/io/PrintStream;

    new-instance v1, Ljava/lang/StringBuilder;

    const-string v2, "DEBUG: mail.imap.sasl.authorizationid: "

    invoke-direct {v1, v2}, Ljava/lang/StringBuilder;-><init>(Ljava/lang/String;)V

    .line 461
    iget-object v2, p0, Lcom/sun/mail/imap/IMAPStore;->authorizationID:Ljava/lang/String;

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v1

    .line 460
    invoke-virtual {v0, v1}, Ljava/io/PrintStream;->println(Ljava/lang/String;)V

    .line 465
    :cond_1b
    new-instance v0, Ljava/lang/StringBuilder;

    const-string v1, "mail."

    invoke-direct {v0, v1}, Ljava/lang/StringBuilder;-><init>(Ljava/lang/String;)V

    invoke-virtual {v0, p3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    const-string v1, ".sasl.realm"

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-virtual {v0}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v0

    invoke-virtual {p1, v0}, Ljavax/mail/Session;->getProperty(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v0

    .line 466
    if-eqz v0, :cond_1c

    .line 467
    iput-object v0, p0, Lcom/sun/mail/imap/IMAPStore;->saslRealm:Ljava/lang/String;

    .line 468
    iget-boolean v0, p0, Lcom/sun/mail/imap/IMAPStore;->debug:Z

    if-eqz v0, :cond_1c

    .line 469
    iget-object v0, p0, Lcom/sun/mail/imap/IMAPStore;->out:Ljava/io/PrintStream;

    new-instance v1, Ljava/lang/StringBuilder;

    const-string v2, "DEBUG: mail.imap.sasl.realm: "

    invoke-direct {v1, v2}, Ljava/lang/StringBuilder;-><init>(Ljava/lang/String;)V

    iget-object v2, p0, Lcom/sun/mail/imap/IMAPStore;->saslRealm:Ljava/lang/String;

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v1

    invoke-virtual {v0, v1}, Ljava/io/PrintStream;->println(Ljava/lang/String;)V

    .line 473
    :cond_1c
    new-instance v0, Ljava/lang/StringBuilder;

    const-string v1, "mail."

    invoke-direct {v0, v1}, Ljava/lang/StringBuilder;-><init>(Ljava/lang/String;)V

    invoke-virtual {v0, p3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    const-string v1, ".forcepasswordrefresh"

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-virtual {v0}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v0

    invoke-virtual {p1, v0}, Ljavax/mail/Session;->getProperty(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v0

    .line 474
    if-eqz v0, :cond_1e

    const-string v1, "true"

    invoke-virtual {v0, v1}, Ljava/lang/String;->equalsIgnoreCase(Ljava/lang/String;)Z

    move-result v0

    if-eqz v0, :cond_1e

    .line 475
    iget-boolean v0, p0, Lcom/sun/mail/imap/IMAPStore;->debug:Z

    if-eqz v0, :cond_1d

    .line 476
    iget-object v0, p0, Lcom/sun/mail/imap/IMAPStore;->out:Ljava/io/PrintStream;

    const-string v1, "DEBUG: enable forcePasswordRefresh"

    invoke-virtual {v0, v1}, Ljava/io/PrintStream;->println(Ljava/lang/String;)V

    .line 477
    :cond_1d
    iput-boolean v4, p0, Lcom/sun/mail/imap/IMAPStore;->forcePasswordRefresh:Z

    .line 481
    :cond_1e
    new-instance v0, Ljava/lang/StringBuilder;

    const-string v1, "mail."

    invoke-direct {v0, v1}, Ljava/lang/StringBuilder;-><init>(Ljava/lang/String;)V

    invoke-virtual {v0, p3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    const-string v1, ".enableimapevents"

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-virtual {v0}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v0

    invoke-virtual {p1, v0}, Ljavax/mail/Session;->getProperty(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v0

    .line 482
    if-eqz v0, :cond_20

    const-string v1, "true"

    invoke-virtual {v0, v1}, Ljava/lang/String;->equalsIgnoreCase(Ljava/lang/String;)Z

    move-result v0

    if-eqz v0, :cond_20

    .line 483
    iget-boolean v0, p0, Lcom/sun/mail/imap/IMAPStore;->debug:Z

    if-eqz v0, :cond_1f

    .line 484
    iget-object v0, p0, Lcom/sun/mail/imap/IMAPStore;->out:Ljava/io/PrintStream;

    const-string v1, "DEBUG: enable IMAP events"

    invoke-virtual {v0, v1}, Ljava/io/PrintStream;->println(Ljava/lang/String;)V

    .line 485
    :cond_1f
    iput-boolean v4, p0, Lcom/sun/mail/imap/IMAPStore;->enableImapEvents:Z

    .line 487
    :cond_20
    return-void

    .line 315
    :cond_21
    new-instance v0, Ljava/lang/StringBuilder;

    const-string v1, "mail."

    invoke-direct {v0, v1}, Ljava/lang/StringBuilder;-><init>(Ljava/lang/String;)V

    invoke-virtual {v0, p3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    const-string v1, ".fetchsize"

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-virtual {v0}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v0

    invoke-virtual {p1, v0}, Ljavax/mail/Session;->getProperty(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v0

    if-eqz v0, :cond_22

    .line 318
    invoke-static {v0}, Ljava/lang/Integer;->parseInt(Ljava/lang/String;)I

    move-result v0

    iput v0, p0, Lcom/sun/mail/imap/IMAPStore;->blksize:I

    .line 319
    :cond_22
    iget-boolean v0, p0, Lcom/sun/mail/imap/IMAPStore;->debug:Z

    if-eqz v0, :cond_3

    .line 320
    iget-object v0, p0, Lcom/sun/mail/imap/IMAPStore;->out:Ljava/io/PrintStream;

    new-instance v1, Ljava/lang/StringBuilder;

    const-string v2, "DEBUG: mail.imap.fetchsize: "

    invoke-direct {v1, v2}, Ljava/lang/StringBuilder;-><init>(Ljava/lang/String;)V

    iget v2, p0, Lcom/sun/mail/imap/IMAPStore;->blksize:I

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v1

    invoke-virtual {v0, v1}, Ljava/io/PrintStream;->println(Ljava/lang/String;)V

    goto/16 :goto_0

    .line 446
    :cond_23
    invoke-virtual {v2}, Ljava/util/StringTokenizer;->nextToken()Ljava/lang/String;

    move-result-object v0

    .line 447
    invoke-virtual {v0}, Ljava/lang/String;->length()I

    move-result v3

    if-lez v3, :cond_19

    .line 448
    invoke-virtual {v1, v0}, Ljava/util/Vector;->addElement(Ljava/lang/Object;)V

    goto/16 :goto_4

    .line 380
    :catch_0
    move-exception v0

    goto/16 :goto_3

    .line 366
    :catch_1
    move-exception v0

    goto/16 :goto_2

    .line 351
    :catch_2
    move-exception v0

    goto/16 :goto_1
.end method

.method private checkConnected()V
    .locals 2

    .prologue
    .line 1490
    sget-boolean v0, Lcom/sun/mail/imap/IMAPStore;->$assertionsDisabled:Z

    if-nez v0, :cond_0

    invoke-static {p0}, Ljava/lang/Thread;->holdsLock(Ljava/lang/Object;)Z

    move-result v0

    if-nez v0, :cond_0

    new-instance v0, Ljava/lang/AssertionError;

    invoke-direct {v0}, Ljava/lang/AssertionError;-><init>()V

    throw v0

    .line 1491
    :cond_0
    iget-boolean v0, p0, Lcom/sun/mail/imap/IMAPStore;->connected:Z

    if-nez v0, :cond_1

    .line 1492
    const/4 v0, 0x0

    invoke-super {p0, v0}, Ljavax/mail/Store;->setConnected(Z)V

    .line 1493
    new-instance v0, Ljava/lang/IllegalStateException;

    const-string v1, "Not connected"

    invoke-direct {v0, v1}, Ljava/lang/IllegalStateException;-><init>(Ljava/lang/String;)V

    throw v0

    .line 1495
    :cond_1
    return-void
.end method

.method private cleanup()V
    .locals 1

    .prologue
    .line 1234
    const/4 v0, 0x0

    invoke-direct {p0, v0}, Lcom/sun/mail/imap/IMAPStore;->cleanup(Z)V

    .line 1235
    return-void
.end method

.method private cleanup(Z)V
    .locals 8

    .prologue
    const/4 v0, 0x0

    const/4 v3, 0x0

    .line 1246
    iget-boolean v1, p0, Lcom/sun/mail/imap/IMAPStore;->debug:Z

    if-eqz v1, :cond_0

    .line 1247
    iget-object v1, p0, Lcom/sun/mail/imap/IMAPStore;->out:Ljava/io/PrintStream;

    new-instance v2, Ljava/lang/StringBuilder;

    const-string v4, "DEBUG: IMAPStore cleanup, force "

    invoke-direct {v2, v4}, Ljava/lang/StringBuilder;-><init>(Ljava/lang/String;)V

    invoke-virtual {v2, p1}, Ljava/lang/StringBuilder;->append(Z)Ljava/lang/StringBuilder;

    move-result-object v2

    invoke-virtual {v2}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v2

    invoke-virtual {v1, v2}, Ljava/io/PrintStream;->println(Ljava/lang/String;)V

    .line 1262
    :cond_0
    :goto_0
    iget-object v2, p0, Lcom/sun/mail/imap/IMAPStore;->pool:Lcom/sun/mail/imap/IMAPStore$ConnectionPool;

    monitor-enter v2

    .line 1263
    :try_start_0
    iget-object v1, p0, Lcom/sun/mail/imap/IMAPStore;->pool:Lcom/sun/mail/imap/IMAPStore$ConnectionPool;

    invoke-static {v1}, Lcom/sun/mail/imap/IMAPStore$ConnectionPool;->access$13(Lcom/sun/mail/imap/IMAPStore$ConnectionPool;)Ljava/util/Vector;

    move-result-object v1

    if-eqz v1, :cond_2

    .line 1265
    iget-object v0, p0, Lcom/sun/mail/imap/IMAPStore;->pool:Lcom/sun/mail/imap/IMAPStore$ConnectionPool;

    invoke-static {v0}, Lcom/sun/mail/imap/IMAPStore$ConnectionPool;->access$13(Lcom/sun/mail/imap/IMAPStore$ConnectionPool;)Ljava/util/Vector;

    move-result-object v1

    .line 1266
    iget-object v0, p0, Lcom/sun/mail/imap/IMAPStore;->pool:Lcom/sun/mail/imap/IMAPStore$ConnectionPool;

    const/4 v4, 0x0

    invoke-static {v0, v4}, Lcom/sun/mail/imap/IMAPStore$ConnectionPool;->access$14(Lcom/sun/mail/imap/IMAPStore$ConnectionPool;Ljava/util/Vector;)V

    move v0, v3

    .line 1262
    :goto_1
    monitor-exit v2
    :try_end_0
    .catchall {:try_start_0 .. :try_end_0} :catchall_0

    .line 1271
    if-eqz v0, :cond_3

    .line 1300
    iget-object v1, p0, Lcom/sun/mail/imap/IMAPStore;->pool:Lcom/sun/mail/imap/IMAPStore$ConnectionPool;

    monitor-enter v1

    .line 1301
    :try_start_1
    invoke-direct {p0, p1}, Lcom/sun/mail/imap/IMAPStore;->emptyConnectionPool(Z)V

    .line 1300
    monitor-exit v1
    :try_end_1
    .catchall {:try_start_1 .. :try_end_1} :catchall_1

    .line 1304
    iput-boolean v3, p0, Lcom/sun/mail/imap/IMAPStore;->connected:Z

    .line 1305
    const/4 v0, 0x3

    invoke-virtual {p0, v0}, Lcom/sun/mail/imap/IMAPStore;->notifyConnectionListeners(I)V

    .line 1306
    iget-boolean v0, p0, Lcom/sun/mail/imap/IMAPStore;->debug:Z

    if-eqz v0, :cond_1

    .line 1307
    iget-object v0, p0, Lcom/sun/mail/imap/IMAPStore;->out:Ljava/io/PrintStream;

    const-string v1, "DEBUG: IMAPStore cleanup done"

    invoke-virtual {v0, v1}, Ljava/io/PrintStream;->println(Ljava/lang/String;)V

    .line 1308
    :cond_1
    return-void

    .line 1268
    :cond_2
    const/4 v1, 0x1

    move v7, v1

    move-object v1, v0

    move v0, v7

    goto :goto_1

    .line 1262
    :catchall_0
    move-exception v0

    :try_start_2
    monitor-exit v2
    :try_end_2
    .catchall {:try_start_2 .. :try_end_2} :catchall_0

    throw v0

    .line 1275
    :cond_3
    invoke-virtual {v1}, Ljava/util/Vector;->size()I

    move-result v4

    move v2, v3

    :goto_2
    if-lt v2, v4, :cond_4

    move-object v0, v1

    .line 1259
    goto :goto_0

    .line 1276
    :cond_4
    invoke-virtual {v1, v2}, Ljava/util/Vector;->elementAt(I)Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Lcom/sun/mail/imap/IMAPFolder;

    .line 1279
    if-eqz p1, :cond_6

    .line 1280
    :try_start_3
    iget-boolean v5, p0, Lcom/sun/mail/imap/IMAPStore;->debug:Z

    if-eqz v5, :cond_5

    .line 1281
    iget-object v5, p0, Lcom/sun/mail/imap/IMAPStore;->out:Ljava/io/PrintStream;

    const-string v6, "DEBUG: force folder to close"

    invoke-virtual {v5, v6}, Ljava/io/PrintStream;->println(Ljava/lang/String;)V

    .line 1285
    :cond_5
    invoke-virtual {v0}, Lcom/sun/mail/imap/IMAPFolder;->forceClose()V

    .line 1275
    :goto_3
    add-int/lit8 v0, v2, 0x1

    move v2, v0

    goto :goto_2

    .line 1287
    :cond_6
    iget-boolean v5, p0, Lcom/sun/mail/imap/IMAPStore;->debug:Z

    if-eqz v5, :cond_7

    .line 1288
    iget-object v5, p0, Lcom/sun/mail/imap/IMAPStore;->out:Ljava/io/PrintStream;

    const-string v6, "DEBUG: close folder"

    invoke-virtual {v5, v6}, Ljava/io/PrintStream;->println(Ljava/lang/String;)V

    .line 1289
    :cond_7
    const/4 v5, 0x0

    invoke-virtual {v0, v5}, Lcom/sun/mail/imap/IMAPFolder;->close(Z)V
    :try_end_3
    .catch Ljavax/mail/MessagingException; {:try_start_3 .. :try_end_3} :catch_0
    .catch Ljava/lang/IllegalStateException; {:try_start_3 .. :try_end_3} :catch_1

    goto :goto_3

    .line 1291
    :catch_0
    move-exception v0

    goto :goto_3

    .line 1300
    :catchall_1
    move-exception v0

    :try_start_4
    monitor-exit v1
    :try_end_4
    .catchall {:try_start_4 .. :try_end_4} :catchall_1

    throw v0

    .line 1293
    :catch_1
    move-exception v0

    goto :goto_3
.end method

.method private emptyConnectionPool(Z)V
    .locals 3

    .prologue
    .line 979
    iget-object v2, p0, Lcom/sun/mail/imap/IMAPStore;->pool:Lcom/sun/mail/imap/IMAPStore$ConnectionPool;

    monitor-enter v2

    .line 980
    :try_start_0
    iget-object v0, p0, Lcom/sun/mail/imap/IMAPStore;->pool:Lcom/sun/mail/imap/IMAPStore$ConnectionPool;

    invoke-static {v0}, Lcom/sun/mail/imap/IMAPStore$ConnectionPool;->access$10(Lcom/sun/mail/imap/IMAPStore$ConnectionPool;)Ljava/util/Vector;

    move-result-object v0

    invoke-virtual {v0}, Ljava/util/Vector;->size()I

    move-result v0

    add-int/lit8 v0, v0, -0x1

    move v1, v0

    .line 981
    :goto_0
    if-gez v1, :cond_1

    .line 993
    iget-object v0, p0, Lcom/sun/mail/imap/IMAPStore;->pool:Lcom/sun/mail/imap/IMAPStore$ConnectionPool;

    invoke-static {v0}, Lcom/sun/mail/imap/IMAPStore$ConnectionPool;->access$10(Lcom/sun/mail/imap/IMAPStore$ConnectionPool;)Ljava/util/Vector;

    move-result-object v0

    invoke-virtual {v0}, Ljava/util/Vector;->removeAllElements()V

    .line 979
    monitor-exit v2
    :try_end_0
    .catchall {:try_start_0 .. :try_end_0} :catchall_0

    .line 996
    iget-object v0, p0, Lcom/sun/mail/imap/IMAPStore;->pool:Lcom/sun/mail/imap/IMAPStore$ConnectionPool;

    invoke-static {v0}, Lcom/sun/mail/imap/IMAPStore$ConnectionPool;->access$3(Lcom/sun/mail/imap/IMAPStore$ConnectionPool;)Z

    move-result v0

    if-eqz v0, :cond_0

    .line 997
    iget-object v0, p0, Lcom/sun/mail/imap/IMAPStore;->out:Ljava/io/PrintStream;

    const-string v1, "DEBUG: removed all authenticated connections"

    invoke-virtual {v0, v1}, Ljava/io/PrintStream;->println(Ljava/lang/String;)V

    .line 998
    :cond_0
    return-void

    .line 984
    :cond_1
    :try_start_1
    iget-object v0, p0, Lcom/sun/mail/imap/IMAPStore;->pool:Lcom/sun/mail/imap/IMAPStore$ConnectionPool;

    invoke-static {v0}, Lcom/sun/mail/imap/IMAPStore$ConnectionPool;->access$10(Lcom/sun/mail/imap/IMAPStore$ConnectionPool;)Ljava/util/Vector;

    move-result-object v0

    invoke-virtual {v0, v1}, Ljava/util/Vector;->elementAt(I)Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Lcom/sun/mail/imap/protocol/IMAPProtocol;

    .line 985
    invoke-virtual {v0, p0}, Lcom/sun/mail/imap/protocol/IMAPProtocol;->removeResponseHandler(Lcom/sun/mail/iap/ResponseHandler;)V

    .line 986
    if-eqz p1, :cond_2

    .line 987
    invoke-virtual {v0}, Lcom/sun/mail/imap/protocol/IMAPProtocol;->disconnect()V

    .line 981
    :goto_1
    add-int/lit8 v0, v1, -0x1

    move v1, v0

    goto :goto_0

    .line 989
    :cond_2
    invoke-virtual {v0}, Lcom/sun/mail/imap/protocol/IMAPProtocol;->logout()V
    :try_end_1
    .catch Lcom/sun/mail/iap/ProtocolException; {:try_start_1 .. :try_end_1} :catch_0
    .catchall {:try_start_1 .. :try_end_1} :catchall_0

    goto :goto_1

    .line 990
    :catch_0
    move-exception v0

    goto :goto_1

    .line 979
    :catchall_0
    move-exception v0

    :try_start_2
    monitor-exit v2
    :try_end_2
    .catchall {:try_start_2 .. :try_end_2} :catchall_0

    throw v0
.end method

.method private declared-synchronized getNamespaces()Lcom/sun/mail/imap/protocol/Namespaces;
    .locals 5
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljavax/mail/MessagingException;
        }
    .end annotation

    .prologue
    .line 1374
    monitor-enter p0

    :try_start_0
    invoke-direct {p0}, Lcom/sun/mail/imap/IMAPStore;->checkConnected()V

    .line 1376
    const/4 v0, 0x0

    .line 1378
    iget-object v1, p0, Lcom/sun/mail/imap/IMAPStore;->namespaces:Lcom/sun/mail/imap/protocol/Namespaces;
    :try_end_0
    .catchall {:try_start_0 .. :try_end_0} :catchall_0

    if-nez v1, :cond_0

    .line 1380
    :try_start_1
    invoke-virtual {p0}, Lcom/sun/mail/imap/IMAPStore;->getStoreProtocol()Lcom/sun/mail/imap/protocol/IMAPProtocol;
    :try_end_1
    .catch Lcom/sun/mail/iap/BadCommandException; {:try_start_1 .. :try_end_1} :catch_0
    .catch Lcom/sun/mail/iap/ConnectionException; {:try_start_1 .. :try_end_1} :catch_1
    .catch Lcom/sun/mail/iap/ProtocolException; {:try_start_1 .. :try_end_1} :catch_2
    .catchall {:try_start_1 .. :try_end_1} :catchall_2

    move-result-object v0

    .line 1381
    :try_start_2
    invoke-virtual {v0}, Lcom/sun/mail/imap/protocol/IMAPProtocol;->namespace()Lcom/sun/mail/imap/protocol/Namespaces;

    move-result-object v1

    iput-object v1, p0, Lcom/sun/mail/imap/IMAPStore;->namespaces:Lcom/sun/mail/imap/protocol/Namespaces;
    :try_end_2
    .catch Lcom/sun/mail/iap/BadCommandException; {:try_start_2 .. :try_end_2} :catch_0
    .catch Lcom/sun/mail/iap/ConnectionException; {:try_start_2 .. :try_end_2} :catch_4
    .catch Lcom/sun/mail/iap/ProtocolException; {:try_start_2 .. :try_end_2} :catch_3
    .catchall {:try_start_2 .. :try_end_2} :catchall_3

    .line 1389
    :try_start_3
    invoke-virtual {p0, v0}, Lcom/sun/mail/imap/IMAPStore;->releaseStoreProtocol(Lcom/sun/mail/imap/protocol/IMAPProtocol;)V

    .line 1390
    if-nez v0, :cond_0

    .line 1392
    invoke-direct {p0}, Lcom/sun/mail/imap/IMAPStore;->cleanup()V

    .line 1396
    :cond_0
    :goto_0
    iget-object v0, p0, Lcom/sun/mail/imap/IMAPStore;->namespaces:Lcom/sun/mail/imap/protocol/Namespaces;
    :try_end_3
    .catchall {:try_start_3 .. :try_end_3} :catchall_0

    monitor-exit p0

    return-object v0

    .line 1382
    :catch_0
    move-exception v1

    .line 1389
    :try_start_4
    invoke-virtual {p0, v0}, Lcom/sun/mail/imap/IMAPStore;->releaseStoreProtocol(Lcom/sun/mail/imap/protocol/IMAPProtocol;)V

    .line 1390
    if-nez v0, :cond_0

    .line 1392
    invoke-direct {p0}, Lcom/sun/mail/imap/IMAPStore;->cleanup()V
    :try_end_4
    .catchall {:try_start_4 .. :try_end_4} :catchall_0

    goto :goto_0

    .line 1374
    :catchall_0
    move-exception v0

    monitor-exit p0

    throw v0

    .line 1384
    :catch_1
    move-exception v1

    move-object v4, v1

    move-object v1, v0

    move-object v0, v4

    .line 1385
    :goto_1
    :try_start_5
    new-instance v2, Ljavax/mail/StoreClosedException;

    invoke-virtual {v0}, Lcom/sun/mail/iap/ConnectionException;->getMessage()Ljava/lang/String;

    move-result-object v0

    invoke-direct {v2, p0, v0}, Ljavax/mail/StoreClosedException;-><init>(Ljavax/mail/Store;Ljava/lang/String;)V

    throw v2
    :try_end_5
    .catchall {:try_start_5 .. :try_end_5} :catchall_1

    .line 1388
    :catchall_1
    move-exception v0

    .line 1389
    :goto_2
    :try_start_6
    invoke-virtual {p0, v1}, Lcom/sun/mail/imap/IMAPStore;->releaseStoreProtocol(Lcom/sun/mail/imap/protocol/IMAPProtocol;)V

    .line 1390
    if-nez v1, :cond_1

    .line 1392
    invoke-direct {p0}, Lcom/sun/mail/imap/IMAPStore;->cleanup()V

    .line 1394
    :cond_1
    throw v0
    :try_end_6
    .catchall {:try_start_6 .. :try_end_6} :catchall_0

    .line 1386
    :catch_2
    move-exception v1

    move-object v4, v1

    move-object v1, v0

    move-object v0, v4

    .line 1387
    :goto_3
    :try_start_7
    new-instance v2, Ljavax/mail/MessagingException;

    invoke-virtual {v0}, Lcom/sun/mail/iap/ProtocolException;->getMessage()Ljava/lang/String;

    move-result-object v3

    invoke-direct {v2, v3, v0}, Ljavax/mail/MessagingException;-><init>(Ljava/lang/String;Ljava/lang/Exception;)V

    throw v2
    :try_end_7
    .catchall {:try_start_7 .. :try_end_7} :catchall_1

    .line 1388
    :catchall_2
    move-exception v1

    move-object v4, v1

    move-object v1, v0

    move-object v0, v4

    goto :goto_2

    :catchall_3
    move-exception v1

    move-object v4, v1

    move-object v1, v0

    move-object v0, v4

    goto :goto_2

    .line 1386
    :catch_3
    move-exception v1

    move-object v4, v1

    move-object v1, v0

    move-object v0, v4

    goto :goto_3

    .line 1384
    :catch_4
    move-exception v1

    move-object v4, v1

    move-object v1, v0

    move-object v0, v4

    goto :goto_1
.end method

.method private login(Lcom/sun/mail/imap/protocol/IMAPProtocol;Ljava/lang/String;Ljava/lang/String;)V
    .locals 6
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Lcom/sun/mail/iap/ProtocolException;
        }
    .end annotation

    .prologue
    .line 582
    iget-boolean v0, p0, Lcom/sun/mail/imap/IMAPStore;->enableStartTLS:Z

    if-eqz v0, :cond_0

    const-string v0, "STARTTLS"

    invoke-virtual {p1, v0}, Lcom/sun/mail/imap/protocol/IMAPProtocol;->hasCapability(Ljava/lang/String;)Z

    move-result v0

    if-eqz v0, :cond_0

    .line 583
    invoke-virtual {p1}, Lcom/sun/mail/imap/protocol/IMAPProtocol;->startTLS()V

    .line 585
    invoke-virtual {p1}, Lcom/sun/mail/imap/protocol/IMAPProtocol;->capability()V

    .line 587
    :cond_0
    invoke-virtual {p1}, Lcom/sun/mail/imap/protocol/IMAPProtocol;->isAuthenticated()Z

    move-result v0

    if-eqz v0, :cond_2

    .line 636
    :cond_1
    :goto_0
    return-void

    .line 595
    :cond_2
    invoke-virtual {p1}, Lcom/sun/mail/imap/protocol/IMAPProtocol;->getCapabilities()Ljava/util/Map;

    move-result-object v0

    const-string v1, "__PRELOGIN__"

    const-string v2, ""

    invoke-interface {v0, v1, v2}, Ljava/util/Map;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    .line 597
    iget-object v0, p0, Lcom/sun/mail/imap/IMAPStore;->authorizationID:Ljava/lang/String;

    if-eqz v0, :cond_5

    .line 598
    iget-object v3, p0, Lcom/sun/mail/imap/IMAPStore;->authorizationID:Ljava/lang/String;

    .line 604
    :goto_1
    iget-boolean v0, p0, Lcom/sun/mail/imap/IMAPStore;->enableSASL:Z

    if-eqz v0, :cond_3

    .line 605
    iget-object v1, p0, Lcom/sun/mail/imap/IMAPStore;->saslMechanisms:[Ljava/lang/String;

    iget-object v2, p0, Lcom/sun/mail/imap/IMAPStore;->saslRealm:Ljava/lang/String;

    move-object v0, p1

    move-object v4, p2

    move-object v5, p3

    invoke-virtual/range {v0 .. v5}, Lcom/sun/mail/imap/protocol/IMAPProtocol;->sasllogin([Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;)V

    .line 607
    :cond_3
    invoke-virtual {p1}, Lcom/sun/mail/imap/protocol/IMAPProtocol;->isAuthenticated()Z

    move-result v0

    if-eqz v0, :cond_7

    .line 619
    :goto_2
    iget-object v0, p0, Lcom/sun/mail/imap/IMAPStore;->proxyAuthUser:Ljava/lang/String;

    if-eqz v0, :cond_4

    .line 620
    iget-object v0, p0, Lcom/sun/mail/imap/IMAPStore;->proxyAuthUser:Ljava/lang/String;

    invoke-virtual {p1, v0}, Lcom/sun/mail/imap/protocol/IMAPProtocol;->proxyauth(Ljava/lang/String;)V

    .line 626
    :cond_4
    const-string v0, "__PRELOGIN__"

    invoke-virtual {p1, v0}, Lcom/sun/mail/imap/protocol/IMAPProtocol;->hasCapability(Ljava/lang/String;)Z

    move-result v0

    if-eqz v0, :cond_1

    .line 628
    :try_start_0
    invoke-virtual {p1}, Lcom/sun/mail/imap/protocol/IMAPProtocol;->capability()V
    :try_end_0
    .catch Lcom/sun/mail/iap/ConnectionException; {:try_start_0 .. :try_end_0} :catch_0
    .catch Lcom/sun/mail/iap/ProtocolException; {:try_start_0 .. :try_end_0} :catch_1

    goto :goto_0

    .line 629
    :catch_0
    move-exception v0

    .line 630
    throw v0

    .line 599
    :cond_5
    iget-object v0, p0, Lcom/sun/mail/imap/IMAPStore;->proxyAuthUser:Ljava/lang/String;

    if-eqz v0, :cond_6

    .line 600
    iget-object v3, p0, Lcom/sun/mail/imap/IMAPStore;->proxyAuthUser:Ljava/lang/String;

    goto :goto_1

    :cond_6
    move-object v3, p2

    .line 602
    goto :goto_1

    .line 609
    :cond_7
    const-string v0, "AUTH=PLAIN"

    invoke-virtual {p1, v0}, Lcom/sun/mail/imap/protocol/IMAPProtocol;->hasCapability(Ljava/lang/String;)Z

    move-result v0

    if-eqz v0, :cond_8

    iget-boolean v0, p0, Lcom/sun/mail/imap/IMAPStore;->disableAuthPlain:Z

    if-nez v0, :cond_8

    .line 610
    invoke-virtual {p1, v3, p2, p3}, Lcom/sun/mail/imap/protocol/IMAPProtocol;->authplain(Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;)V

    goto :goto_2

    .line 611
    :cond_8
    const-string v0, "AUTH-LOGIN"

    invoke-virtual {p1, v0}, Lcom/sun/mail/imap/protocol/IMAPProtocol;->hasCapability(Ljava/lang/String;)Z

    move-result v0

    if-nez v0, :cond_9

    .line 612
    const-string v0, "AUTH=LOGIN"

    invoke-virtual {p1, v0}, Lcom/sun/mail/imap/protocol/IMAPProtocol;->hasCapability(Ljava/lang/String;)Z

    move-result v0

    if-eqz v0, :cond_a

    :cond_9
    iget-boolean v0, p0, Lcom/sun/mail/imap/IMAPStore;->disableAuthLogin:Z

    if-nez v0, :cond_a

    .line 613
    invoke-virtual {p1, p2, p3}, Lcom/sun/mail/imap/protocol/IMAPProtocol;->authlogin(Ljava/lang/String;Ljava/lang/String;)V

    goto :goto_2

    .line 614
    :cond_a
    const-string v0, "LOGINDISABLED"

    invoke-virtual {p1, v0}, Lcom/sun/mail/imap/protocol/IMAPProtocol;->hasCapability(Ljava/lang/String;)Z

    move-result v0

    if-nez v0, :cond_b

    .line 615
    invoke-virtual {p1, p2, p3}, Lcom/sun/mail/imap/protocol/IMAPProtocol;->login(Ljava/lang/String;Ljava/lang/String;)V

    goto :goto_2

    .line 617
    :cond_b
    new-instance v0, Lcom/sun/mail/iap/ProtocolException;

    const-string v1, "No login methods supported!"

    invoke-direct {v0, v1}, Lcom/sun/mail/iap/ProtocolException;-><init>(Ljava/lang/String;)V

    throw v0

    .line 632
    :catch_1
    move-exception v0

    goto/16 :goto_0
.end method

.method private namespaceToFolders([Lcom/sun/mail/imap/protocol/Namespaces$Namespace;Ljava/lang/String;)[Ljavax/mail/Folder;
    .locals 7

    .prologue
    const/4 v1, 0x0

    .line 1401
    array-length v0, p1

    new-array v4, v0, [Ljavax/mail/Folder;

    move v0, v1

    .line 1402
    :goto_0
    array-length v2, v4

    if-lt v0, v2, :cond_0

    .line 1415
    return-object v4

    .line 1403
    :cond_0
    aget-object v2, p1, v0

    iget-object v2, v2, Lcom/sun/mail/imap/protocol/Namespaces$Namespace;->prefix:Ljava/lang/String;

    .line 1404
    if-nez p2, :cond_2

    .line 1406
    invoke-virtual {v2}, Ljava/lang/String;->length()I

    move-result v3

    .line 1407
    if-lez v3, :cond_1

    add-int/lit8 v5, v3, -0x1

    invoke-virtual {v2, v5}, Ljava/lang/String;->charAt(I)C

    move-result v5

    aget-object v6, p1, v0

    iget-char v6, v6, Lcom/sun/mail/imap/protocol/Namespaces$Namespace;->delimiter:C

    if-ne v5, v6, :cond_1

    .line 1408
    add-int/lit8 v3, v3, -0x1

    invoke-virtual {v2, v1, v3}, Ljava/lang/String;->substring(II)Ljava/lang/String;

    move-result-object v2

    .line 1413
    :cond_1
    :goto_1
    new-instance v5, Lcom/sun/mail/imap/IMAPFolder;

    aget-object v3, p1, v0

    iget-char v6, v3, Lcom/sun/mail/imap/protocol/Namespaces$Namespace;->delimiter:C

    if-nez p2, :cond_3

    const/4 v3, 0x1

    :goto_2
    invoke-direct {v5, v2, v6, p0, v3}, Lcom/sun/mail/imap/IMAPFolder;-><init>(Ljava/lang/String;CLcom/sun/mail/imap/IMAPStore;Z)V

    aput-object v5, v4, v0

    .line 1402
    add-int/lit8 v0, v0, 0x1

    goto :goto_0

    .line 1411
    :cond_2
    new-instance v3, Ljava/lang/StringBuilder;

    invoke-static {v2}, Ljava/lang/String;->valueOf(Ljava/lang/Object;)Ljava/lang/String;

    move-result-object v2

    invoke-direct {v3, v2}, Ljava/lang/StringBuilder;-><init>(Ljava/lang/String;)V

    invoke-virtual {v3, p2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    invoke-virtual {v2}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v2

    goto :goto_1

    :cond_3
    move v3, v1

    .line 1413
    goto :goto_2
.end method

.method private timeoutConnections()V
    .locals 10

    .prologue
    .line 1005
    iget-object v2, p0, Lcom/sun/mail/imap/IMAPStore;->pool:Lcom/sun/mail/imap/IMAPStore$ConnectionPool;

    monitor-enter v2

    .line 1009
    :try_start_0
    invoke-static {}, Ljava/lang/System;->currentTimeMillis()J

    move-result-wide v0

    iget-object v3, p0, Lcom/sun/mail/imap/IMAPStore;->pool:Lcom/sun/mail/imap/IMAPStore$ConnectionPool;

    invoke-static {v3}, Lcom/sun/mail/imap/IMAPStore$ConnectionPool;->access$16(Lcom/sun/mail/imap/IMAPStore$ConnectionPool;)J

    move-result-wide v4

    sub-long/2addr v0, v4

    .line 1010
    iget-object v3, p0, Lcom/sun/mail/imap/IMAPStore;->pool:Lcom/sun/mail/imap/IMAPStore$ConnectionPool;

    invoke-static {v3}, Lcom/sun/mail/imap/IMAPStore$ConnectionPool;->access$17(Lcom/sun/mail/imap/IMAPStore$ConnectionPool;)J

    move-result-wide v4

    cmp-long v0, v0, v4

    if-lez v0, :cond_1

    .line 1011
    iget-object v0, p0, Lcom/sun/mail/imap/IMAPStore;->pool:Lcom/sun/mail/imap/IMAPStore$ConnectionPool;

    invoke-static {v0}, Lcom/sun/mail/imap/IMAPStore$ConnectionPool;->access$10(Lcom/sun/mail/imap/IMAPStore$ConnectionPool;)Ljava/util/Vector;

    move-result-object v0

    invoke-virtual {v0}, Ljava/util/Vector;->size()I

    move-result v0

    const/4 v1, 0x1

    if-le v0, v1, :cond_1

    .line 1013
    iget-object v0, p0, Lcom/sun/mail/imap/IMAPStore;->pool:Lcom/sun/mail/imap/IMAPStore$ConnectionPool;

    invoke-static {v0}, Lcom/sun/mail/imap/IMAPStore$ConnectionPool;->access$3(Lcom/sun/mail/imap/IMAPStore$ConnectionPool;)Z

    move-result v0

    if-eqz v0, :cond_0

    .line 1014
    iget-object v0, p0, Lcom/sun/mail/imap/IMAPStore;->out:Ljava/io/PrintStream;

    new-instance v1, Ljava/lang/StringBuilder;

    const-string v3, "DEBUG: checking for connections to prune: "

    invoke-direct {v1, v3}, Ljava/lang/StringBuilder;-><init>(Ljava/lang/String;)V

    .line 1016
    invoke-static {}, Ljava/lang/System;->currentTimeMillis()J

    move-result-wide v4

    iget-object v3, p0, Lcom/sun/mail/imap/IMAPStore;->pool:Lcom/sun/mail/imap/IMAPStore$ConnectionPool;

    invoke-static {v3}, Lcom/sun/mail/imap/IMAPStore$ConnectionPool;->access$16(Lcom/sun/mail/imap/IMAPStore$ConnectionPool;)J

    move-result-wide v6

    sub-long/2addr v4, v6

    invoke-virtual {v1, v4, v5}, Ljava/lang/StringBuilder;->append(J)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v1

    .line 1014
    invoke-virtual {v0, v1}, Ljava/io/PrintStream;->println(Ljava/lang/String;)V

    .line 1017
    iget-object v0, p0, Lcom/sun/mail/imap/IMAPStore;->out:Ljava/io/PrintStream;

    new-instance v1, Ljava/lang/StringBuilder;

    const-string v3, "DEBUG: clientTimeoutInterval: "

    invoke-direct {v1, v3}, Ljava/lang/StringBuilder;-><init>(Ljava/lang/String;)V

    .line 1018
    iget-object v3, p0, Lcom/sun/mail/imap/IMAPStore;->pool:Lcom/sun/mail/imap/IMAPStore$ConnectionPool;

    invoke-static {v3}, Lcom/sun/mail/imap/IMAPStore$ConnectionPool;->access$6(Lcom/sun/mail/imap/IMAPStore$ConnectionPool;)J

    move-result-wide v4

    invoke-virtual {v1, v4, v5}, Ljava/lang/StringBuilder;->append(J)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v1

    .line 1017
    invoke-virtual {v0, v1}, Ljava/io/PrintStream;->println(Ljava/lang/String;)V

    .line 1026
    :cond_0
    iget-object v0, p0, Lcom/sun/mail/imap/IMAPStore;->pool:Lcom/sun/mail/imap/IMAPStore$ConnectionPool;

    invoke-static {v0}, Lcom/sun/mail/imap/IMAPStore$ConnectionPool;->access$10(Lcom/sun/mail/imap/IMAPStore$ConnectionPool;)Ljava/util/Vector;

    move-result-object v0

    invoke-virtual {v0}, Ljava/util/Vector;->size()I

    move-result v0

    add-int/lit8 v0, v0, -0x1

    move v1, v0

    .line 1027
    :goto_0
    if-gtz v1, :cond_2

    .line 1052
    iget-object v0, p0, Lcom/sun/mail/imap/IMAPStore;->pool:Lcom/sun/mail/imap/IMAPStore$ConnectionPool;

    invoke-static {}, Ljava/lang/System;->currentTimeMillis()J

    move-result-wide v4

    invoke-static {v0, v4, v5}, Lcom/sun/mail/imap/IMAPStore$ConnectionPool;->access$0(Lcom/sun/mail/imap/IMAPStore$ConnectionPool;J)V

    .line 1005
    :cond_1
    monitor-exit v2

    .line 1055
    return-void

    .line 1028
    :cond_2
    iget-object v0, p0, Lcom/sun/mail/imap/IMAPStore;->pool:Lcom/sun/mail/imap/IMAPStore$ConnectionPool;

    invoke-static {v0}, Lcom/sun/mail/imap/IMAPStore$ConnectionPool;->access$10(Lcom/sun/mail/imap/IMAPStore$ConnectionPool;)Ljava/util/Vector;

    move-result-object v0

    .line 1029
    invoke-virtual {v0, v1}, Ljava/util/Vector;->elementAt(I)Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Lcom/sun/mail/imap/protocol/IMAPProtocol;

    .line 1030
    iget-object v3, p0, Lcom/sun/mail/imap/IMAPStore;->pool:Lcom/sun/mail/imap/IMAPStore$ConnectionPool;

    invoke-static {v3}, Lcom/sun/mail/imap/IMAPStore$ConnectionPool;->access$3(Lcom/sun/mail/imap/IMAPStore$ConnectionPool;)Z

    move-result v3

    if-eqz v3, :cond_3

    .line 1031
    iget-object v3, p0, Lcom/sun/mail/imap/IMAPStore;->out:Ljava/io/PrintStream;

    new-instance v4, Ljava/lang/StringBuilder;

    const-string v5, "DEBUG: protocol last used: "

    invoke-direct {v4, v5}, Ljava/lang/StringBuilder;-><init>(Ljava/lang/String;)V

    .line 1032
    invoke-static {}, Ljava/lang/System;->currentTimeMillis()J

    move-result-wide v6

    invoke-virtual {v0}, Lcom/sun/mail/imap/protocol/IMAPProtocol;->getTimestamp()J

    move-result-wide v8

    sub-long/2addr v6, v8

    invoke-virtual {v4, v6, v7}, Ljava/lang/StringBuilder;->append(J)Ljava/lang/StringBuilder;

    move-result-object v4

    invoke-virtual {v4}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v4

    .line 1031
    invoke-virtual {v3, v4}, Ljava/io/PrintStream;->println(Ljava/lang/String;)V

    .line 1034
    :cond_3
    invoke-static {}, Ljava/lang/System;->currentTimeMillis()J

    move-result-wide v4

    invoke-virtual {v0}, Lcom/sun/mail/imap/protocol/IMAPProtocol;->getTimestamp()J

    move-result-wide v6

    sub-long/2addr v4, v6

    .line 1035
    iget-object v3, p0, Lcom/sun/mail/imap/IMAPStore;->pool:Lcom/sun/mail/imap/IMAPStore$ConnectionPool;

    invoke-static {v3}, Lcom/sun/mail/imap/IMAPStore$ConnectionPool;->access$6(Lcom/sun/mail/imap/IMAPStore$ConnectionPool;)J

    move-result-wide v6

    cmp-long v3, v4, v6

    if-lez v3, :cond_5

    .line 1037
    iget-object v3, p0, Lcom/sun/mail/imap/IMAPStore;->pool:Lcom/sun/mail/imap/IMAPStore$ConnectionPool;

    invoke-static {v3}, Lcom/sun/mail/imap/IMAPStore$ConnectionPool;->access$3(Lcom/sun/mail/imap/IMAPStore$ConnectionPool;)Z

    move-result v3

    if-eqz v3, :cond_4

    .line 1038
    iget-object v3, p0, Lcom/sun/mail/imap/IMAPStore;->out:Ljava/io/PrintStream;

    const-string v4, "DEBUG: authenticated connection timed out"

    invoke-virtual {v3, v4}, Ljava/io/PrintStream;->println(Ljava/lang/String;)V

    .line 1040
    iget-object v3, p0, Lcom/sun/mail/imap/IMAPStore;->out:Ljava/io/PrintStream;

    const-string v4, "DEBUG: logging out the connection"

    invoke-virtual {v3, v4}, Ljava/io/PrintStream;->println(Ljava/lang/String;)V

    .line 1044
    :cond_4
    invoke-virtual {v0, p0}, Lcom/sun/mail/imap/protocol/IMAPProtocol;->removeResponseHandler(Lcom/sun/mail/iap/ResponseHandler;)V

    .line 1045
    iget-object v3, p0, Lcom/sun/mail/imap/IMAPStore;->pool:Lcom/sun/mail/imap/IMAPStore$ConnectionPool;

    invoke-static {v3}, Lcom/sun/mail/imap/IMAPStore$ConnectionPool;->access$10(Lcom/sun/mail/imap/IMAPStore$ConnectionPool;)Ljava/util/Vector;

    move-result-object v3

    invoke-virtual {v3, v1}, Ljava/util/Vector;->removeElementAt(I)V
    :try_end_0
    .catchall {:try_start_0 .. :try_end_0} :catchall_0

    .line 1048
    :try_start_1
    invoke-virtual {v0}, Lcom/sun/mail/imap/protocol/IMAPProtocol;->logout()V
    :try_end_1
    .catch Lcom/sun/mail/iap/ProtocolException; {:try_start_1 .. :try_end_1} :catch_0
    .catchall {:try_start_1 .. :try_end_1} :catchall_0

    .line 1027
    :cond_5
    :goto_1
    add-int/lit8 v0, v1, -0x1

    move v1, v0

    goto :goto_0

    .line 1005
    :catchall_0
    move-exception v0

    :try_start_2
    monitor-exit v2
    :try_end_2
    .catchall {:try_start_2 .. :try_end_2} :catchall_0

    throw v0

    .line 1049
    :catch_0
    move-exception v0

    goto :goto_1
.end method

.method private waitIfIdle()V
    .locals 2
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Lcom/sun/mail/iap/ProtocolException;
        }
    .end annotation

    .prologue
    .line 1640
    sget-boolean v0, Lcom/sun/mail/imap/IMAPStore;->$assertionsDisabled:Z

    if-nez v0, :cond_2

    iget-object v0, p0, Lcom/sun/mail/imap/IMAPStore;->pool:Lcom/sun/mail/imap/IMAPStore$ConnectionPool;

    invoke-static {v0}, Ljava/lang/Thread;->holdsLock(Ljava/lang/Object;)Z

    move-result v0

    if-nez v0, :cond_2

    new-instance v0, Ljava/lang/AssertionError;

    invoke-direct {v0}, Ljava/lang/AssertionError;-><init>()V

    throw v0

    .line 1642
    :cond_0
    iget-object v0, p0, Lcom/sun/mail/imap/IMAPStore;->pool:Lcom/sun/mail/imap/IMAPStore$ConnectionPool;

    invoke-static {v0}, Lcom/sun/mail/imap/IMAPStore$ConnectionPool;->access$19(Lcom/sun/mail/imap/IMAPStore$ConnectionPool;)I

    move-result v0

    const/4 v1, 0x1

    if-ne v0, v1, :cond_1

    .line 1643
    iget-object v0, p0, Lcom/sun/mail/imap/IMAPStore;->pool:Lcom/sun/mail/imap/IMAPStore$ConnectionPool;

    invoke-static {v0}, Lcom/sun/mail/imap/IMAPStore$ConnectionPool;->access$21(Lcom/sun/mail/imap/IMAPStore$ConnectionPool;)Lcom/sun/mail/imap/protocol/IMAPProtocol;

    move-result-object v0

    invoke-virtual {v0}, Lcom/sun/mail/imap/protocol/IMAPProtocol;->idleAbort()V

    .line 1644
    iget-object v0, p0, Lcom/sun/mail/imap/IMAPStore;->pool:Lcom/sun/mail/imap/IMAPStore$ConnectionPool;

    const/4 v1, 0x2

    invoke-static {v0, v1}, Lcom/sun/mail/imap/IMAPStore$ConnectionPool;->access$20(Lcom/sun/mail/imap/IMAPStore$ConnectionPool;I)V

    .line 1648
    :cond_1
    :try_start_0
    iget-object v0, p0, Lcom/sun/mail/imap/IMAPStore;->pool:Lcom/sun/mail/imap/IMAPStore$ConnectionPool;

    invoke-virtual {v0}, Ljava/lang/Object;->wait()V
    :try_end_0
    .catch Ljava/lang/InterruptedException; {:try_start_0 .. :try_end_0} :catch_0

    .line 1641
    :cond_2
    :goto_0
    iget-object v0, p0, Lcom/sun/mail/imap/IMAPStore;->pool:Lcom/sun/mail/imap/IMAPStore$ConnectionPool;

    invoke-static {v0}, Lcom/sun/mail/imap/IMAPStore$ConnectionPool;->access$19(Lcom/sun/mail/imap/IMAPStore$ConnectionPool;)I

    move-result v0

    if-nez v0, :cond_0

    .line 1651
    return-void

    .line 1649
    :catch_0
    move-exception v0

    goto :goto_0
.end method


# virtual methods
.method allowReadOnlySelect()Z
    .locals 3

    .prologue
    .line 887
    iget-object v0, p0, Lcom/sun/mail/imap/IMAPStore;->session:Ljavax/mail/Session;

    new-instance v1, Ljava/lang/StringBuilder;

    const-string v2, "mail."

    invoke-direct {v1, v2}, Ljava/lang/StringBuilder;-><init>(Ljava/lang/String;)V

    iget-object v2, p0, Lcom/sun/mail/imap/IMAPStore;->name:Ljava/lang/String;

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    .line 888
    const-string v2, ".allowreadonlyselect"

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v1

    .line 887
    invoke-virtual {v0, v1}, Ljavax/mail/Session;->getProperty(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v0

    .line 889
    if-eqz v0, :cond_0

    const-string v1, "true"

    invoke-virtual {v0, v1}, Ljava/lang/String;->equalsIgnoreCase(Ljava/lang/String;)Z

    move-result v0

    if-eqz v0, :cond_0

    const/4 v0, 0x1

    :goto_0
    return v0

    :cond_0
    const/4 v0, 0x0

    goto :goto_0
.end method

.method public declared-synchronized close()V
    .locals 4
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljavax/mail/MessagingException;
        }
    .end annotation

    .prologue
    .line 1165
    monitor-enter p0

    :try_start_0
    invoke-super {p0}, Ljavax/mail/Store;->isConnected()Z
    :try_end_0
    .catchall {:try_start_0 .. :try_end_0} :catchall_0

    move-result v0

    if-nez v0, :cond_0

    .line 1225
    :goto_0
    monitor-exit p0

    return-void

    .line 1168
    :cond_0
    const/4 v1, 0x0

    .line 1171
    :try_start_1
    iget-object v2, p0, Lcom/sun/mail/imap/IMAPStore;->pool:Lcom/sun/mail/imap/IMAPStore$ConnectionPool;

    monitor-enter v2
    :try_end_1
    .catch Lcom/sun/mail/iap/ProtocolException; {:try_start_1 .. :try_end_1} :catch_0
    .catchall {:try_start_1 .. :try_end_1} :catchall_2

    .line 1174
    :try_start_2
    iget-object v0, p0, Lcom/sun/mail/imap/IMAPStore;->pool:Lcom/sun/mail/imap/IMAPStore$ConnectionPool;

    invoke-static {v0}, Lcom/sun/mail/imap/IMAPStore$ConnectionPool;->access$10(Lcom/sun/mail/imap/IMAPStore$ConnectionPool;)Ljava/util/Vector;

    move-result-object v0

    invoke-virtual {v0}, Ljava/util/Vector;->isEmpty()Z

    move-result v0

    .line 1171
    monitor-exit v2
    :try_end_2
    .catchall {:try_start_2 .. :try_end_2} :catchall_1

    .line 1185
    if-eqz v0, :cond_2

    .line 1186
    :try_start_3
    iget-object v0, p0, Lcom/sun/mail/imap/IMAPStore;->pool:Lcom/sun/mail/imap/IMAPStore$ConnectionPool;

    invoke-static {v0}, Lcom/sun/mail/imap/IMAPStore$ConnectionPool;->access$3(Lcom/sun/mail/imap/IMAPStore$ConnectionPool;)Z

    move-result v0

    if-eqz v0, :cond_1

    .line 1187
    iget-object v0, p0, Lcom/sun/mail/imap/IMAPStore;->out:Ljava/io/PrintStream;

    const-string v2, "DEBUG: close() - no connections "

    invoke-virtual {v0, v2}, Ljava/io/PrintStream;->println(Ljava/lang/String;)V

    .line 1188
    :cond_1
    invoke-direct {p0}, Lcom/sun/mail/imap/IMAPStore;->cleanup()V
    :try_end_3
    .catch Lcom/sun/mail/iap/ProtocolException; {:try_start_3 .. :try_end_3} :catch_0
    .catchall {:try_start_3 .. :try_end_3} :catchall_2

    .line 1223
    :try_start_4
    invoke-virtual {p0, v1}, Lcom/sun/mail/imap/IMAPStore;->releaseStoreProtocol(Lcom/sun/mail/imap/protocol/IMAPProtocol;)V
    :try_end_4
    .catchall {:try_start_4 .. :try_end_4} :catchall_0

    goto :goto_0

    .line 1165
    :catchall_0
    move-exception v0

    monitor-exit p0

    throw v0

    .line 1171
    :catchall_1
    move-exception v0

    :try_start_5
    monitor-exit v2
    :try_end_5
    .catchall {:try_start_5 .. :try_end_5} :catchall_1

    :try_start_6
    throw v0
    :try_end_6
    .catch Lcom/sun/mail/iap/ProtocolException; {:try_start_6 .. :try_end_6} :catch_0
    .catchall {:try_start_6 .. :try_end_6} :catchall_2

    .line 1218
    :catch_0
    move-exception v0

    .line 1220
    :try_start_7
    invoke-direct {p0}, Lcom/sun/mail/imap/IMAPStore;->cleanup()V

    .line 1221
    new-instance v2, Ljavax/mail/MessagingException;

    invoke-virtual {v0}, Lcom/sun/mail/iap/ProtocolException;->getMessage()Ljava/lang/String;

    move-result-object v3

    invoke-direct {v2, v3, v0}, Ljavax/mail/MessagingException;-><init>(Ljava/lang/String;Ljava/lang/Exception;)V

    throw v2
    :try_end_7
    .catchall {:try_start_7 .. :try_end_7} :catchall_2

    .line 1222
    :catchall_2
    move-exception v0

    .line 1223
    :try_start_8
    invoke-virtual {p0, v1}, Lcom/sun/mail/imap/IMAPStore;->releaseStoreProtocol(Lcom/sun/mail/imap/protocol/IMAPProtocol;)V

    .line 1224
    throw v0
    :try_end_8
    .catchall {:try_start_8 .. :try_end_8} :catchall_0

    .line 1192
    :cond_2
    :try_start_9
    invoke-virtual {p0}, Lcom/sun/mail/imap/IMAPStore;->getStoreProtocol()Lcom/sun/mail/imap/protocol/IMAPProtocol;

    move-result-object v1

    .line 1199
    iget-object v2, p0, Lcom/sun/mail/imap/IMAPStore;->pool:Lcom/sun/mail/imap/IMAPStore$ConnectionPool;

    monitor-enter v2
    :try_end_9
    .catch Lcom/sun/mail/iap/ProtocolException; {:try_start_9 .. :try_end_9} :catch_0
    .catchall {:try_start_9 .. :try_end_9} :catchall_2

    .line 1200
    :try_start_a
    iget-object v0, p0, Lcom/sun/mail/imap/IMAPStore;->pool:Lcom/sun/mail/imap/IMAPStore$ConnectionPool;

    invoke-static {v0}, Lcom/sun/mail/imap/IMAPStore$ConnectionPool;->access$10(Lcom/sun/mail/imap/IMAPStore$ConnectionPool;)Ljava/util/Vector;

    move-result-object v0

    invoke-virtual {v0, v1}, Ljava/util/Vector;->removeElement(Ljava/lang/Object;)Z

    .line 1199
    monitor-exit v2
    :try_end_a
    .catchall {:try_start_a .. :try_end_a} :catchall_3

    .line 1217
    :try_start_b
    invoke-virtual {v1}, Lcom/sun/mail/imap/protocol/IMAPProtocol;->logout()V
    :try_end_b
    .catch Lcom/sun/mail/iap/ProtocolException; {:try_start_b .. :try_end_b} :catch_0
    .catchall {:try_start_b .. :try_end_b} :catchall_2

    .line 1223
    :try_start_c
    invoke-virtual {p0, v1}, Lcom/sun/mail/imap/IMAPStore;->releaseStoreProtocol(Lcom/sun/mail/imap/protocol/IMAPProtocol;)V
    :try_end_c
    .catchall {:try_start_c .. :try_end_c} :catchall_0

    goto :goto_0

    .line 1199
    :catchall_3
    move-exception v0

    :try_start_d
    monitor-exit v2
    :try_end_d
    .catchall {:try_start_d .. :try_end_d} :catchall_3

    :try_start_e
    throw v0
    :try_end_e
    .catch Lcom/sun/mail/iap/ProtocolException; {:try_start_e .. :try_end_e} :catch_0
    .catchall {:try_start_e .. :try_end_e} :catchall_2
.end method

.method protected finalize()V
    .locals 0
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljava/lang/Throwable;
        }
    .end annotation

    .prologue
    .line 1228
    invoke-super {p0}, Ljavax/mail/Store;->finalize()V

    .line 1229
    invoke-virtual {p0}, Lcom/sun/mail/imap/IMAPStore;->close()V

    .line 1230
    return-void
.end method

.method getAppendBufferSize()I
    .locals 1

    .prologue
    .line 1082
    iget v0, p0, Lcom/sun/mail/imap/IMAPStore;->appendBufferSize:I

    return v0
.end method

.method getConnectionPoolDebug()Z
    .locals 1

    .prologue
    .line 903
    iget-object v0, p0, Lcom/sun/mail/imap/IMAPStore;->pool:Lcom/sun/mail/imap/IMAPStore$ConnectionPool;

    invoke-static {v0}, Lcom/sun/mail/imap/IMAPStore$ConnectionPool;->access$3(Lcom/sun/mail/imap/IMAPStore$ConnectionPool;)Z

    move-result v0

    return v0
.end method

.method public declared-synchronized getDefaultFolder()Ljavax/mail/Folder;
    .locals 1
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljavax/mail/MessagingException;
        }
    .end annotation

    .prologue
    .line 1315
    monitor-enter p0

    :try_start_0
    invoke-direct {p0}, Lcom/sun/mail/imap/IMAPStore;->checkConnected()V

    .line 1316
    new-instance v0, Lcom/sun/mail/imap/DefaultFolder;

    invoke-direct {v0, p0}, Lcom/sun/mail/imap/DefaultFolder;-><init>(Lcom/sun/mail/imap/IMAPStore;)V
    :try_end_0
    .catchall {:try_start_0 .. :try_end_0} :catchall_0

    monitor-exit p0

    return-object v0

    .line 1315
    :catchall_0
    move-exception v0

    monitor-exit p0

    throw v0
.end method

.method getFetchBlockSize()I
    .locals 1

    .prologue
    .line 1061
    iget v0, p0, Lcom/sun/mail/imap/IMAPStore;->blksize:I

    return v0
.end method

.method public declared-synchronized getFolder(Ljava/lang/String;)Ljavax/mail/Folder;
    .locals 2
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljavax/mail/MessagingException;
        }
    .end annotation

    .prologue
    .line 1324
    monitor-enter p0

    :try_start_0
    invoke-direct {p0}, Lcom/sun/mail/imap/IMAPStore;->checkConnected()V

    .line 1325
    new-instance v0, Lcom/sun/mail/imap/IMAPFolder;

    const v1, 0xffff

    invoke-direct {v0, p1, v1, p0}, Lcom/sun/mail/imap/IMAPFolder;-><init>(Ljava/lang/String;CLcom/sun/mail/imap/IMAPStore;)V
    :try_end_0
    .catchall {:try_start_0 .. :try_end_0} :catchall_0

    monitor-exit p0

    return-object v0

    .line 1324
    :catchall_0
    move-exception v0

    monitor-exit p0

    throw v0
.end method

.method public declared-synchronized getFolder(Ljavax/mail/URLName;)Ljavax/mail/Folder;
    .locals 3
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljavax/mail/MessagingException;
        }
    .end annotation

    .prologue
    .line 1333
    monitor-enter p0

    :try_start_0
    invoke-direct {p0}, Lcom/sun/mail/imap/IMAPStore;->checkConnected()V

    .line 1334
    new-instance v0, Lcom/sun/mail/imap/IMAPFolder;

    invoke-virtual {p1}, Ljavax/mail/URLName;->getFile()Ljava/lang/String;

    move-result-object v1

    .line 1335
    const v2, 0xffff

    .line 1334
    invoke-direct {v0, v1, v2, p0}, Lcom/sun/mail/imap/IMAPFolder;-><init>(Ljava/lang/String;CLcom/sun/mail/imap/IMAPStore;)V
    :try_end_0
    .catchall {:try_start_0 .. :try_end_0} :catchall_0

    monitor-exit p0

    return-object v0

    .line 1333
    :catchall_0
    move-exception v0

    monitor-exit p0

    throw v0
.end method

.method getMinIdleTime()I
    .locals 1

    .prologue
    .line 1089
    iget v0, p0, Lcom/sun/mail/imap/IMAPStore;->minIdleTime:I

    return v0
.end method

.method public getPersonalNamespaces()[Ljavax/mail/Folder;
    .locals 2
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljavax/mail/MessagingException;
        }
    .end annotation

    .prologue
    .line 1344
    invoke-direct {p0}, Lcom/sun/mail/imap/IMAPStore;->getNamespaces()Lcom/sun/mail/imap/protocol/Namespaces;

    move-result-object v0

    .line 1345
    if-eqz v0, :cond_0

    iget-object v1, v0, Lcom/sun/mail/imap/protocol/Namespaces;->personal:[Lcom/sun/mail/imap/protocol/Namespaces$Namespace;

    if-nez v1, :cond_1

    .line 1346
    :cond_0
    invoke-super {p0}, Ljavax/mail/Store;->getPersonalNamespaces()[Ljavax/mail/Folder;

    move-result-object v0

    .line 1347
    :goto_0
    return-object v0

    :cond_1
    iget-object v0, v0, Lcom/sun/mail/imap/protocol/Namespaces;->personal:[Lcom/sun/mail/imap/protocol/Namespaces$Namespace;

    const/4 v1, 0x0

    invoke-direct {p0, v0, v1}, Lcom/sun/mail/imap/IMAPStore;->namespaceToFolders([Lcom/sun/mail/imap/protocol/Namespaces$Namespace;Ljava/lang/String;)[Ljavax/mail/Folder;

    move-result-object v0

    goto :goto_0
.end method

.method getProtocol(Lcom/sun/mail/imap/IMAPFolder;)Lcom/sun/mail/imap/protocol/IMAPProtocol;
    .locals 11
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljavax/mail/MessagingException;
        }
    .end annotation

    .prologue
    const/4 v9, 0x0

    .line 678
    move-object v8, v9

    .line 681
    :goto_0
    if-eqz v8, :cond_0

    .line 788
    return-object v8

    .line 689
    :cond_0
    iget-object v10, p0, Lcom/sun/mail/imap/IMAPStore;->pool:Lcom/sun/mail/imap/IMAPStore$ConnectionPool;

    monitor-enter v10

    .line 693
    :try_start_0
    iget-object v0, p0, Lcom/sun/mail/imap/IMAPStore;->pool:Lcom/sun/mail/imap/IMAPStore$ConnectionPool;

    invoke-static {v0}, Lcom/sun/mail/imap/IMAPStore$ConnectionPool;->access$10(Lcom/sun/mail/imap/IMAPStore$ConnectionPool;)Ljava/util/Vector;

    move-result-object v0

    invoke-virtual {v0}, Ljava/util/Vector;->isEmpty()Z

    move-result v0

    if-nez v0, :cond_1

    .line 694
    iget-object v0, p0, Lcom/sun/mail/imap/IMAPStore;->pool:Lcom/sun/mail/imap/IMAPStore$ConnectionPool;

    invoke-static {v0}, Lcom/sun/mail/imap/IMAPStore$ConnectionPool;->access$10(Lcom/sun/mail/imap/IMAPStore$ConnectionPool;)Ljava/util/Vector;

    move-result-object v0

    invoke-virtual {v0}, Ljava/util/Vector;->size()I

    move-result v0

    const/4 v1, 0x1

    if-ne v0, v1, :cond_5

    .line 695
    iget-object v0, p0, Lcom/sun/mail/imap/IMAPStore;->pool:Lcom/sun/mail/imap/IMAPStore$ConnectionPool;

    invoke-static {v0}, Lcom/sun/mail/imap/IMAPStore$ConnectionPool;->access$11(Lcom/sun/mail/imap/IMAPStore$ConnectionPool;)Z

    move-result v0

    if-nez v0, :cond_1

    iget-object v0, p0, Lcom/sun/mail/imap/IMAPStore;->pool:Lcom/sun/mail/imap/IMAPStore$ConnectionPool;

    invoke-static {v0}, Lcom/sun/mail/imap/IMAPStore$ConnectionPool;->access$12(Lcom/sun/mail/imap/IMAPStore$ConnectionPool;)Z

    move-result v0

    if-eqz v0, :cond_5

    .line 697
    :cond_1
    iget-boolean v0, p0, Lcom/sun/mail/imap/IMAPStore;->debug:Z

    if-eqz v0, :cond_2

    .line 698
    iget-object v0, p0, Lcom/sun/mail/imap/IMAPStore;->out:Ljava/io/PrintStream;

    const-string v1, "DEBUG: no connections in the pool, creating a new one"

    invoke-virtual {v0, v1}, Ljava/io/PrintStream;->println(Ljava/lang/String;)V
    :try_end_0
    .catchall {:try_start_0 .. :try_end_0} :catchall_0

    .line 709
    :cond_2
    :try_start_1
    iget-boolean v0, p0, Lcom/sun/mail/imap/IMAPStore;->forcePasswordRefresh:Z
    :try_end_1
    .catch Ljava/lang/Exception; {:try_start_1 .. :try_end_1} :catch_4
    .catchall {:try_start_1 .. :try_end_1} :catchall_0

    if-eqz v0, :cond_3

    .line 712
    :try_start_2
    iget-object v0, p0, Lcom/sun/mail/imap/IMAPStore;->host:Ljava/lang/String;

    invoke-static {v0}, Ljava/net/InetAddress;->getByName(Ljava/lang/String;)Ljava/net/InetAddress;
    :try_end_2
    .catch Ljava/net/UnknownHostException; {:try_start_2 .. :try_end_2} :catch_0
    .catch Ljava/lang/Exception; {:try_start_2 .. :try_end_2} :catch_4
    .catchall {:try_start_2 .. :try_end_2} :catchall_0

    move-result-object v1

    .line 717
    :goto_1
    :try_start_3
    iget-object v0, p0, Lcom/sun/mail/imap/IMAPStore;->session:Ljavax/mail/Session;

    iget v2, p0, Lcom/sun/mail/imap/IMAPStore;->port:I

    .line 718
    iget-object v3, p0, Lcom/sun/mail/imap/IMAPStore;->name:Ljava/lang/String;

    const/4 v4, 0x0

    iget-object v5, p0, Lcom/sun/mail/imap/IMAPStore;->user:Ljava/lang/String;

    .line 717
    invoke-virtual/range {v0 .. v5}, Ljavax/mail/Session;->requestPasswordAuthentication(Ljava/net/InetAddress;ILjava/lang/String;Ljava/lang/String;Ljava/lang/String;)Ljavax/mail/PasswordAuthentication;

    move-result-object v0

    .line 719
    if-eqz v0, :cond_3

    .line 720
    invoke-virtual {v0}, Ljavax/mail/PasswordAuthentication;->getUserName()Ljava/lang/String;

    move-result-object v1

    iput-object v1, p0, Lcom/sun/mail/imap/IMAPStore;->user:Ljava/lang/String;

    .line 721
    invoke-virtual {v0}, Ljavax/mail/PasswordAuthentication;->getPassword()Ljava/lang/String;

    move-result-object v0

    iput-object v0, p0, Lcom/sun/mail/imap/IMAPStore;->password:Ljava/lang/String;

    .line 725
    :cond_3
    new-instance v0, Lcom/sun/mail/imap/protocol/IMAPProtocol;

    iget-object v1, p0, Lcom/sun/mail/imap/IMAPStore;->name:Ljava/lang/String;

    iget-object v2, p0, Lcom/sun/mail/imap/IMAPStore;->host:Ljava/lang/String;

    iget v3, p0, Lcom/sun/mail/imap/IMAPStore;->port:I

    .line 726
    iget-object v4, p0, Lcom/sun/mail/imap/IMAPStore;->session:Ljavax/mail/Session;

    invoke-virtual {v4}, Ljavax/mail/Session;->getDebug()Z

    move-result v4

    .line 727
    iget-object v5, p0, Lcom/sun/mail/imap/IMAPStore;->session:Ljavax/mail/Session;

    invoke-virtual {v5}, Ljavax/mail/Session;->getDebugOut()Ljava/io/PrintStream;

    move-result-object v5

    .line 728
    iget-object v6, p0, Lcom/sun/mail/imap/IMAPStore;->session:Ljavax/mail/Session;

    invoke-virtual {v6}, Ljavax/mail/Session;->getProperties()Ljava/util/Properties;

    move-result-object v6

    .line 729
    iget-boolean v7, p0, Lcom/sun/mail/imap/IMAPStore;->isSSL:Z

    .line 725
    invoke-direct/range {v0 .. v7}, Lcom/sun/mail/imap/protocol/IMAPProtocol;-><init>(Ljava/lang/String;Ljava/lang/String;IZLjava/io/PrintStream;Ljava/util/Properties;Z)V
    :try_end_3
    .catch Ljava/lang/Exception; {:try_start_3 .. :try_end_3} :catch_4
    .catchall {:try_start_3 .. :try_end_3} :catchall_0

    .line 732
    :try_start_4
    iget-object v1, p0, Lcom/sun/mail/imap/IMAPStore;->user:Ljava/lang/String;

    iget-object v2, p0, Lcom/sun/mail/imap/IMAPStore;->password:Ljava/lang/String;

    invoke-direct {p0, v0, v1, v2}, Lcom/sun/mail/imap/IMAPStore;->login(Lcom/sun/mail/imap/protocol/IMAPProtocol;Ljava/lang/String;Ljava/lang/String;)V
    :try_end_4
    .catch Ljava/lang/Exception; {:try_start_4 .. :try_end_4} :catch_1
    .catchall {:try_start_4 .. :try_end_4} :catchall_0

    move-object v8, v0

    .line 741
    :goto_2
    if-nez v8, :cond_8

    .line 742
    :try_start_5
    new-instance v0, Ljavax/mail/MessagingException;

    const-string v1, "connection failure"

    invoke-direct {v0, v1}, Ljavax/mail/MessagingException;-><init>(Ljava/lang/String;)V

    throw v0

    .line 689
    :catchall_0
    move-exception v0

    monitor-exit v10
    :try_end_5
    .catchall {:try_start_5 .. :try_end_5} :catchall_0

    throw v0

    .line 713
    :catch_0
    move-exception v0

    move-object v1, v9

    .line 714
    goto :goto_1

    .line 733
    :catch_1
    move-exception v1

    .line 734
    :goto_3
    if-eqz v0, :cond_4

    .line 736
    :try_start_6
    invoke-virtual {v0}, Lcom/sun/mail/imap/protocol/IMAPProtocol;->disconnect()V
    :try_end_6
    .catch Ljava/lang/Exception; {:try_start_6 .. :try_end_6} :catch_3
    .catchall {:try_start_6 .. :try_end_6} :catchall_0

    :cond_4
    :goto_4
    move-object v8, v9

    .line 738
    goto :goto_2

    .line 744
    :cond_5
    :try_start_7
    iget-boolean v0, p0, Lcom/sun/mail/imap/IMAPStore;->debug:Z

    if-eqz v0, :cond_6

    .line 745
    iget-object v0, p0, Lcom/sun/mail/imap/IMAPStore;->out:Ljava/io/PrintStream;

    new-instance v1, Ljava/lang/StringBuilder;

    const-string v2, "DEBUG: connection available -- size: "

    invoke-direct {v1, v2}, Ljava/lang/StringBuilder;-><init>(Ljava/lang/String;)V

    .line 746
    iget-object v2, p0, Lcom/sun/mail/imap/IMAPStore;->pool:Lcom/sun/mail/imap/IMAPStore$ConnectionPool;

    invoke-static {v2}, Lcom/sun/mail/imap/IMAPStore$ConnectionPool;->access$10(Lcom/sun/mail/imap/IMAPStore$ConnectionPool;)Ljava/util/Vector;

    move-result-object v2

    invoke-virtual {v2}, Ljava/util/Vector;->size()I

    move-result v2

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v1

    .line 745
    invoke-virtual {v0, v1}, Ljava/io/PrintStream;->println(Ljava/lang/String;)V

    .line 749
    :cond_6
    iget-object v0, p0, Lcom/sun/mail/imap/IMAPStore;->pool:Lcom/sun/mail/imap/IMAPStore$ConnectionPool;

    invoke-static {v0}, Lcom/sun/mail/imap/IMAPStore$ConnectionPool;->access$10(Lcom/sun/mail/imap/IMAPStore$ConnectionPool;)Ljava/util/Vector;

    move-result-object v0

    invoke-virtual {v0}, Ljava/util/Vector;->lastElement()Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Lcom/sun/mail/imap/protocol/IMAPProtocol;

    .line 750
    iget-object v1, p0, Lcom/sun/mail/imap/IMAPStore;->pool:Lcom/sun/mail/imap/IMAPStore$ConnectionPool;

    invoke-static {v1}, Lcom/sun/mail/imap/IMAPStore$ConnectionPool;->access$10(Lcom/sun/mail/imap/IMAPStore$ConnectionPool;)Ljava/util/Vector;

    move-result-object v1

    invoke-virtual {v1, v0}, Ljava/util/Vector;->removeElement(Ljava/lang/Object;)Z

    .line 753
    invoke-static {}, Ljava/lang/System;->currentTimeMillis()J

    move-result-wide v2

    invoke-virtual {v0}, Lcom/sun/mail/imap/protocol/IMAPProtocol;->getTimestamp()J

    move-result-wide v4

    sub-long/2addr v2, v4

    .line 754
    iget-object v1, p0, Lcom/sun/mail/imap/IMAPStore;->pool:Lcom/sun/mail/imap/IMAPStore$ConnectionPool;

    invoke-static {v1}, Lcom/sun/mail/imap/IMAPStore$ConnectionPool;->access$8(Lcom/sun/mail/imap/IMAPStore$ConnectionPool;)J
    :try_end_7
    .catchall {:try_start_7 .. :try_end_7} :catchall_0

    move-result-wide v4

    cmp-long v1, v2, v4

    if-lez v1, :cond_7

    .line 758
    :try_start_8
    invoke-virtual {v0}, Lcom/sun/mail/imap/protocol/IMAPProtocol;->noop()V
    :try_end_8
    .catch Lcom/sun/mail/iap/ProtocolException; {:try_start_8 .. :try_end_8} :catch_2
    .catchall {:try_start_8 .. :try_end_8} :catchall_0

    .line 772
    :cond_7
    :try_start_9
    invoke-virtual {v0, p0}, Lcom/sun/mail/imap/protocol/IMAPProtocol;->removeResponseHandler(Lcom/sun/mail/iap/ResponseHandler;)V

    move-object v8, v0

    .line 776
    :cond_8
    invoke-direct {p0}, Lcom/sun/mail/imap/IMAPStore;->timeoutConnections()V

    .line 779
    if-eqz p1, :cond_a

    .line 780
    iget-object v0, p0, Lcom/sun/mail/imap/IMAPStore;->pool:Lcom/sun/mail/imap/IMAPStore$ConnectionPool;

    invoke-static {v0}, Lcom/sun/mail/imap/IMAPStore$ConnectionPool;->access$13(Lcom/sun/mail/imap/IMAPStore$ConnectionPool;)Ljava/util/Vector;

    move-result-object v0

    if-nez v0, :cond_9

    .line 781
    iget-object v0, p0, Lcom/sun/mail/imap/IMAPStore;->pool:Lcom/sun/mail/imap/IMAPStore$ConnectionPool;

    new-instance v1, Ljava/util/Vector;

    invoke-direct {v1}, Ljava/util/Vector;-><init>()V

    invoke-static {v0, v1}, Lcom/sun/mail/imap/IMAPStore$ConnectionPool;->access$14(Lcom/sun/mail/imap/IMAPStore$ConnectionPool;Ljava/util/Vector;)V

    .line 782
    :cond_9
    iget-object v0, p0, Lcom/sun/mail/imap/IMAPStore;->pool:Lcom/sun/mail/imap/IMAPStore$ConnectionPool;

    invoke-static {v0}, Lcom/sun/mail/imap/IMAPStore$ConnectionPool;->access$13(Lcom/sun/mail/imap/IMAPStore$ConnectionPool;)Ljava/util/Vector;

    move-result-object v0

    invoke-virtual {v0, p1}, Ljava/util/Vector;->addElement(Ljava/lang/Object;)V

    .line 689
    :cond_a
    monitor-exit v10
    :try_end_9
    .catchall {:try_start_9 .. :try_end_9} :catchall_0

    goto/16 :goto_0

    .line 759
    :catch_2
    move-exception v1

    .line 761
    :try_start_a
    invoke-virtual {v0, p0}, Lcom/sun/mail/imap/protocol/IMAPProtocol;->removeResponseHandler(Lcom/sun/mail/iap/ResponseHandler;)V

    .line 762
    invoke-virtual {v0}, Lcom/sun/mail/imap/protocol/IMAPProtocol;->disconnect()V
    :try_end_a
    .catchall {:try_start_a .. :try_end_a} :catchall_1

    .line 766
    :goto_5
    :try_start_b
    monitor-exit v10
    :try_end_b
    .catchall {:try_start_b .. :try_end_b} :catchall_0

    move-object v8, v9

    goto/16 :goto_0

    .line 737
    :catch_3
    move-exception v0

    goto/16 :goto_4

    :catchall_1
    move-exception v0

    goto :goto_5

    .line 733
    :catch_4
    move-exception v0

    move-object v0, v8

    goto/16 :goto_3
.end method

.method public declared-synchronized getQuota(Ljava/lang/String;)[Ljavax/mail/Quota;
    .locals 4
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljavax/mail/MessagingException;
        }
    .end annotation

    .prologue
    const/4 v1, 0x0

    .line 1436
    monitor-enter p0

    :try_start_0
    invoke-direct {p0}, Lcom/sun/mail/imap/IMAPStore;->checkConnected()V

    .line 1437
    const/4 v0, 0x0

    check-cast v0, [Ljavax/mail/Quota;
    :try_end_0
    .catchall {:try_start_0 .. :try_end_0} :catchall_1

    .line 1441
    :try_start_1
    invoke-virtual {p0}, Lcom/sun/mail/imap/IMAPStore;->getStoreProtocol()Lcom/sun/mail/imap/protocol/IMAPProtocol;

    move-result-object v1

    .line 1442
    invoke-virtual {v1, p1}, Lcom/sun/mail/imap/protocol/IMAPProtocol;->getQuotaRoot(Ljava/lang/String;)[Ljavax/mail/Quota;
    :try_end_1
    .catch Lcom/sun/mail/iap/BadCommandException; {:try_start_1 .. :try_end_1} :catch_0
    .catch Lcom/sun/mail/iap/ConnectionException; {:try_start_1 .. :try_end_1} :catch_1
    .catch Lcom/sun/mail/iap/ProtocolException; {:try_start_1 .. :try_end_1} :catch_2
    .catchall {:try_start_1 .. :try_end_1} :catchall_0

    move-result-object v0

    .line 1450
    :try_start_2
    invoke-virtual {p0, v1}, Lcom/sun/mail/imap/IMAPStore;->releaseStoreProtocol(Lcom/sun/mail/imap/protocol/IMAPProtocol;)V

    .line 1451
    if-nez v1, :cond_0

    .line 1453
    invoke-direct {p0}, Lcom/sun/mail/imap/IMAPStore;->cleanup()V
    :try_end_2
    .catchall {:try_start_2 .. :try_end_2} :catchall_1

    .line 1456
    :cond_0
    monitor-exit p0

    return-object v0

    .line 1443
    :catch_0
    move-exception v0

    .line 1444
    :try_start_3
    new-instance v2, Ljavax/mail/MessagingException;

    const-string v3, "QUOTA not supported"

    invoke-direct {v2, v3, v0}, Ljavax/mail/MessagingException;-><init>(Ljava/lang/String;Ljava/lang/Exception;)V

    throw v2
    :try_end_3
    .catchall {:try_start_3 .. :try_end_3} :catchall_0

    .line 1449
    :catchall_0
    move-exception v0

    .line 1450
    :try_start_4
    invoke-virtual {p0, v1}, Lcom/sun/mail/imap/IMAPStore;->releaseStoreProtocol(Lcom/sun/mail/imap/protocol/IMAPProtocol;)V

    .line 1451
    if-nez v1, :cond_1

    .line 1453
    invoke-direct {p0}, Lcom/sun/mail/imap/IMAPStore;->cleanup()V

    .line 1455
    :cond_1
    throw v0
    :try_end_4
    .catchall {:try_start_4 .. :try_end_4} :catchall_1

    .line 1436
    :catchall_1
    move-exception v0

    monitor-exit p0

    throw v0

    .line 1445
    :catch_1
    move-exception v0

    .line 1446
    :try_start_5
    new-instance v2, Ljavax/mail/StoreClosedException;

    invoke-virtual {v0}, Lcom/sun/mail/iap/ConnectionException;->getMessage()Ljava/lang/String;

    move-result-object v0

    invoke-direct {v2, p0, v0}, Ljavax/mail/StoreClosedException;-><init>(Ljavax/mail/Store;Ljava/lang/String;)V

    throw v2

    .line 1447
    :catch_2
    move-exception v0

    .line 1448
    new-instance v2, Ljavax/mail/MessagingException;

    invoke-virtual {v0}, Lcom/sun/mail/iap/ProtocolException;->getMessage()Ljava/lang/String;

    move-result-object v3

    invoke-direct {v2, v3, v0}, Ljavax/mail/MessagingException;-><init>(Ljava/lang/String;Ljava/lang/Exception;)V

    throw v2
    :try_end_5
    .catchall {:try_start_5 .. :try_end_5} :catchall_0
.end method

.method getSession()Ljavax/mail/Session;
    .locals 1

    .prologue
    .line 1068
    iget-object v0, p0, Lcom/sun/mail/imap/IMAPStore;->session:Ljavax/mail/Session;

    return-object v0
.end method

.method public getSharedNamespaces()[Ljavax/mail/Folder;
    .locals 2
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljavax/mail/MessagingException;
        }
    .end annotation

    .prologue
    .line 1367
    invoke-direct {p0}, Lcom/sun/mail/imap/IMAPStore;->getNamespaces()Lcom/sun/mail/imap/protocol/Namespaces;

    move-result-object v0

    .line 1368
    if-eqz v0, :cond_0

    iget-object v1, v0, Lcom/sun/mail/imap/protocol/Namespaces;->shared:[Lcom/sun/mail/imap/protocol/Namespaces$Namespace;

    if-nez v1, :cond_1

    .line 1369
    :cond_0
    invoke-super {p0}, Ljavax/mail/Store;->getSharedNamespaces()[Ljavax/mail/Folder;

    move-result-object v0

    .line 1370
    :goto_0
    return-object v0

    :cond_1
    iget-object v0, v0, Lcom/sun/mail/imap/protocol/Namespaces;->shared:[Lcom/sun/mail/imap/protocol/Namespaces$Namespace;

    const/4 v1, 0x0

    invoke-direct {p0, v0, v1}, Lcom/sun/mail/imap/IMAPStore;->namespaceToFolders([Lcom/sun/mail/imap/protocol/Namespaces$Namespace;Ljava/lang/String;)[Ljavax/mail/Folder;

    move-result-object v0

    goto :goto_0
.end method

.method getStatusCacheTimeout()I
    .locals 1

    .prologue
    .line 1075
    iget v0, p0, Lcom/sun/mail/imap/IMAPStore;->statusCacheTimeout:I

    return v0
.end method

.method getStoreProtocol()Lcom/sun/mail/imap/protocol/IMAPProtocol;
    .locals 11
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Lcom/sun/mail/iap/ProtocolException;
        }
    .end annotation

    .prologue
    const/4 v9, 0x0

    .line 814
    move-object v8, v9

    .line 816
    :goto_0
    if-eqz v8, :cond_0

    .line 878
    return-object v8

    .line 817
    :cond_0
    iget-object v10, p0, Lcom/sun/mail/imap/IMAPStore;->pool:Lcom/sun/mail/imap/IMAPStore$ConnectionPool;

    monitor-enter v10

    .line 818
    :try_start_0
    invoke-direct {p0}, Lcom/sun/mail/imap/IMAPStore;->waitIfIdle()V

    .line 822
    iget-object v0, p0, Lcom/sun/mail/imap/IMAPStore;->pool:Lcom/sun/mail/imap/IMAPStore$ConnectionPool;

    invoke-static {v0}, Lcom/sun/mail/imap/IMAPStore$ConnectionPool;->access$10(Lcom/sun/mail/imap/IMAPStore$ConnectionPool;)Ljava/util/Vector;

    move-result-object v0

    invoke-virtual {v0}, Ljava/util/Vector;->isEmpty()Z

    move-result v0

    if-eqz v0, :cond_5

    .line 823
    iget-object v0, p0, Lcom/sun/mail/imap/IMAPStore;->pool:Lcom/sun/mail/imap/IMAPStore$ConnectionPool;

    invoke-static {v0}, Lcom/sun/mail/imap/IMAPStore$ConnectionPool;->access$3(Lcom/sun/mail/imap/IMAPStore$ConnectionPool;)Z

    move-result v0

    if-eqz v0, :cond_1

    .line 824
    iget-object v0, p0, Lcom/sun/mail/imap/IMAPStore;->out:Ljava/io/PrintStream;

    const-string v1, "DEBUG: getStoreProtocol() - no connections in the pool, creating a new one"

    invoke-virtual {v0, v1}, Ljava/io/PrintStream;->println(Ljava/lang/String;)V
    :try_end_0
    .catchall {:try_start_0 .. :try_end_0} :catchall_0

    .line 828
    :cond_1
    :try_start_1
    new-instance v0, Lcom/sun/mail/imap/protocol/IMAPProtocol;

    iget-object v1, p0, Lcom/sun/mail/imap/IMAPStore;->name:Ljava/lang/String;

    iget-object v2, p0, Lcom/sun/mail/imap/IMAPStore;->host:Ljava/lang/String;

    iget v3, p0, Lcom/sun/mail/imap/IMAPStore;->port:I

    .line 829
    iget-object v4, p0, Lcom/sun/mail/imap/IMAPStore;->session:Ljavax/mail/Session;

    invoke-virtual {v4}, Ljavax/mail/Session;->getDebug()Z

    move-result v4

    .line 830
    iget-object v5, p0, Lcom/sun/mail/imap/IMAPStore;->session:Ljavax/mail/Session;

    invoke-virtual {v5}, Ljavax/mail/Session;->getDebugOut()Ljava/io/PrintStream;

    move-result-object v5

    .line 831
    iget-object v6, p0, Lcom/sun/mail/imap/IMAPStore;->session:Ljavax/mail/Session;

    invoke-virtual {v6}, Ljavax/mail/Session;->getProperties()Ljava/util/Properties;

    move-result-object v6

    .line 832
    iget-boolean v7, p0, Lcom/sun/mail/imap/IMAPStore;->isSSL:Z

    .line 828
    invoke-direct/range {v0 .. v7}, Lcom/sun/mail/imap/protocol/IMAPProtocol;-><init>(Ljava/lang/String;Ljava/lang/String;IZLjava/io/PrintStream;Ljava/util/Properties;Z)V
    :try_end_1
    .catch Ljava/lang/Exception; {:try_start_1 .. :try_end_1} :catch_3
    .catchall {:try_start_1 .. :try_end_1} :catchall_0

    .line 835
    :try_start_2
    iget-object v1, p0, Lcom/sun/mail/imap/IMAPStore;->user:Ljava/lang/String;

    iget-object v2, p0, Lcom/sun/mail/imap/IMAPStore;->password:Ljava/lang/String;

    invoke-direct {p0, v0, v1, v2}, Lcom/sun/mail/imap/IMAPStore;->login(Lcom/sun/mail/imap/protocol/IMAPProtocol;Ljava/lang/String;Ljava/lang/String;)V
    :try_end_2
    .catch Ljava/lang/Exception; {:try_start_2 .. :try_end_2} :catch_0
    .catchall {:try_start_2 .. :try_end_2} :catchall_0

    move-object v8, v0

    .line 844
    :goto_1
    if-nez v8, :cond_3

    .line 845
    :try_start_3
    new-instance v0, Lcom/sun/mail/iap/ConnectionException;

    .line 846
    const-string v1, "failed to create new store connection"

    .line 845
    invoke-direct {v0, v1}, Lcom/sun/mail/iap/ConnectionException;-><init>(Ljava/lang/String;)V

    throw v0

    .line 817
    :catchall_0
    move-exception v0

    monitor-exit v10
    :try_end_3
    .catchall {:try_start_3 .. :try_end_3} :catchall_0

    throw v0

    .line 836
    :catch_0
    move-exception v1

    .line 837
    :goto_2
    if-eqz v0, :cond_2

    .line 839
    :try_start_4
    invoke-virtual {v0}, Lcom/sun/mail/imap/protocol/IMAPProtocol;->logout()V
    :try_end_4
    .catch Ljava/lang/Exception; {:try_start_4 .. :try_end_4} :catch_2
    .catchall {:try_start_4 .. :try_end_4} :catchall_0

    :cond_2
    :goto_3
    move-object v8, v9

    .line 841
    goto :goto_1

    .line 848
    :cond_3
    :try_start_5
    invoke-virtual {v8, p0}, Lcom/sun/mail/imap/protocol/IMAPProtocol;->addResponseHandler(Lcom/sun/mail/iap/ResponseHandler;)V

    .line 849
    iget-object v0, p0, Lcom/sun/mail/imap/IMAPStore;->pool:Lcom/sun/mail/imap/IMAPStore$ConnectionPool;

    invoke-static {v0}, Lcom/sun/mail/imap/IMAPStore$ConnectionPool;->access$10(Lcom/sun/mail/imap/IMAPStore$ConnectionPool;)Ljava/util/Vector;

    move-result-object v0

    invoke-virtual {v0, v8}, Ljava/util/Vector;->addElement(Ljava/lang/Object;)V

    .line 860
    :goto_4
    iget-object v0, p0, Lcom/sun/mail/imap/IMAPStore;->pool:Lcom/sun/mail/imap/IMAPStore$ConnectionPool;

    invoke-static {v0}, Lcom/sun/mail/imap/IMAPStore$ConnectionPool;->access$12(Lcom/sun/mail/imap/IMAPStore$ConnectionPool;)Z
    :try_end_5
    .catchall {:try_start_5 .. :try_end_5} :catchall_0

    move-result v0

    if-eqz v0, :cond_7

    .line 865
    :try_start_6
    iget-object v0, p0, Lcom/sun/mail/imap/IMAPStore;->pool:Lcom/sun/mail/imap/IMAPStore$ConnectionPool;

    invoke-virtual {v0}, Ljava/lang/Object;->wait()V
    :try_end_6
    .catch Ljava/lang/InterruptedException; {:try_start_6 .. :try_end_6} :catch_1
    .catchall {:try_start_6 .. :try_end_6} :catchall_0

    move-object v8, v9

    .line 875
    :cond_4
    :goto_5
    :try_start_7
    invoke-direct {p0}, Lcom/sun/mail/imap/IMAPStore;->timeoutConnections()V

    .line 817
    monitor-exit v10

    goto :goto_0

    .line 853
    :cond_5
    iget-object v0, p0, Lcom/sun/mail/imap/IMAPStore;->pool:Lcom/sun/mail/imap/IMAPStore$ConnectionPool;

    invoke-static {v0}, Lcom/sun/mail/imap/IMAPStore$ConnectionPool;->access$3(Lcom/sun/mail/imap/IMAPStore$ConnectionPool;)Z

    move-result v0

    if-eqz v0, :cond_6

    .line 854
    iget-object v0, p0, Lcom/sun/mail/imap/IMAPStore;->out:Ljava/io/PrintStream;

    new-instance v1, Ljava/lang/StringBuilder;

    const-string v2, "DEBUG: getStoreProtocol() - connection available -- size: "

    invoke-direct {v1, v2}, Ljava/lang/StringBuilder;-><init>(Ljava/lang/String;)V

    .line 856
    iget-object v2, p0, Lcom/sun/mail/imap/IMAPStore;->pool:Lcom/sun/mail/imap/IMAPStore$ConnectionPool;

    invoke-static {v2}, Lcom/sun/mail/imap/IMAPStore$ConnectionPool;->access$10(Lcom/sun/mail/imap/IMAPStore$ConnectionPool;)Ljava/util/Vector;

    move-result-object v2

    invoke-virtual {v2}, Ljava/util/Vector;->size()I

    move-result v2

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v1

    .line 854
    invoke-virtual {v0, v1}, Ljava/io/PrintStream;->println(Ljava/lang/String;)V

    .line 857
    :cond_6
    iget-object v0, p0, Lcom/sun/mail/imap/IMAPStore;->pool:Lcom/sun/mail/imap/IMAPStore$ConnectionPool;

    invoke-static {v0}, Lcom/sun/mail/imap/IMAPStore$ConnectionPool;->access$10(Lcom/sun/mail/imap/IMAPStore$ConnectionPool;)Ljava/util/Vector;

    move-result-object v0

    invoke-virtual {v0}, Ljava/util/Vector;->firstElement()Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Lcom/sun/mail/imap/protocol/IMAPProtocol;

    move-object v8, v0

    goto :goto_4

    .line 866
    :catch_1
    move-exception v0

    move-object v8, v9

    goto :goto_5

    .line 868
    :cond_7
    iget-object v0, p0, Lcom/sun/mail/imap/IMAPStore;->pool:Lcom/sun/mail/imap/IMAPStore$ConnectionPool;

    const/4 v1, 0x1

    invoke-static {v0, v1}, Lcom/sun/mail/imap/IMAPStore$ConnectionPool;->access$15(Lcom/sun/mail/imap/IMAPStore$ConnectionPool;Z)V

    .line 870
    iget-object v0, p0, Lcom/sun/mail/imap/IMAPStore;->pool:Lcom/sun/mail/imap/IMAPStore$ConnectionPool;

    invoke-static {v0}, Lcom/sun/mail/imap/IMAPStore$ConnectionPool;->access$3(Lcom/sun/mail/imap/IMAPStore$ConnectionPool;)Z

    move-result v0

    if-eqz v0, :cond_4

    .line 871
    iget-object v0, p0, Lcom/sun/mail/imap/IMAPStore;->out:Ljava/io/PrintStream;

    const-string v1, "DEBUG: getStoreProtocol() -- storeConnectionInUse"

    invoke-virtual {v0, v1}, Ljava/io/PrintStream;->println(Ljava/lang/String;)V
    :try_end_7
    .catchall {:try_start_7 .. :try_end_7} :catchall_0

    goto :goto_5

    .line 840
    :catch_2
    move-exception v0

    goto :goto_3

    .line 836
    :catch_3
    move-exception v0

    move-object v0, v8

    goto :goto_2
.end method

.method public getUserNamespaces(Ljava/lang/String;)[Ljavax/mail/Folder;
    .locals 2
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljavax/mail/MessagingException;
        }
    .end annotation

    .prologue
    .line 1356
    invoke-direct {p0}, Lcom/sun/mail/imap/IMAPStore;->getNamespaces()Lcom/sun/mail/imap/protocol/Namespaces;

    move-result-object v0

    .line 1357
    if-eqz v0, :cond_0

    iget-object v1, v0, Lcom/sun/mail/imap/protocol/Namespaces;->otherUsers:[Lcom/sun/mail/imap/protocol/Namespaces$Namespace;

    if-nez v1, :cond_1

    .line 1358
    :cond_0
    invoke-super {p0, p1}, Ljavax/mail/Store;->getUserNamespaces(Ljava/lang/String;)[Ljavax/mail/Folder;

    move-result-object v0

    .line 1359
    :goto_0
    return-object v0

    :cond_1
    iget-object v0, v0, Lcom/sun/mail/imap/protocol/Namespaces;->otherUsers:[Lcom/sun/mail/imap/protocol/Namespaces$Namespace;

    invoke-direct {p0, v0, p1}, Lcom/sun/mail/imap/IMAPStore;->namespaceToFolders([Lcom/sun/mail/imap/protocol/Namespaces$Namespace;Ljava/lang/String;)[Ljavax/mail/Folder;

    move-result-object v0

    goto :goto_0
.end method

.method public handleResponse(Lcom/sun/mail/iap/Response;)V
    .locals 2

    .prologue
    .line 1502
    invoke-virtual {p1}, Lcom/sun/mail/iap/Response;->isOK()Z

    move-result v0

    if-nez v0, :cond_0

    invoke-virtual {p1}, Lcom/sun/mail/iap/Response;->isNO()Z

    move-result v0

    if-nez v0, :cond_0

    invoke-virtual {p1}, Lcom/sun/mail/iap/Response;->isBAD()Z

    move-result v0

    if-nez v0, :cond_0

    invoke-virtual {p1}, Lcom/sun/mail/iap/Response;->isBYE()Z

    move-result v0

    if-eqz v0, :cond_1

    .line 1503
    :cond_0
    invoke-virtual {p0, p1}, Lcom/sun/mail/imap/IMAPStore;->handleResponseCode(Lcom/sun/mail/iap/Response;)V

    .line 1504
    :cond_1
    invoke-virtual {p1}, Lcom/sun/mail/iap/Response;->isBYE()Z

    move-result v0

    if-eqz v0, :cond_3

    .line 1505
    iget-boolean v0, p0, Lcom/sun/mail/imap/IMAPStore;->debug:Z

    if-eqz v0, :cond_2

    .line 1506
    iget-object v0, p0, Lcom/sun/mail/imap/IMAPStore;->out:Ljava/io/PrintStream;

    const-string v1, "DEBUG: IMAPStore connection dead"

    invoke-virtual {v0, v1}, Ljava/io/PrintStream;->println(Ljava/lang/String;)V

    .line 1508
    :cond_2
    iget-boolean v0, p0, Lcom/sun/mail/imap/IMAPStore;->connected:Z

    if-eqz v0, :cond_3

    .line 1509
    invoke-virtual {p1}, Lcom/sun/mail/iap/Response;->isSynthetic()Z

    move-result v0

    invoke-direct {p0, v0}, Lcom/sun/mail/imap/IMAPStore;->cleanup(Z)V

    .line 1512
    :cond_3
    return-void
.end method

.method handleResponseCode(Lcom/sun/mail/iap/Response;)V
    .locals 6

    .prologue
    const/4 v1, 0x1

    const/4 v0, 0x0

    .line 1658
    invoke-virtual {p1}, Lcom/sun/mail/iap/Response;->getRest()Ljava/lang/String;

    move-result-object v2

    .line 1660
    const-string v3, "["

    invoke-virtual {v2, v3}, Ljava/lang/String;->startsWith(Ljava/lang/String;)Z

    move-result v3

    if-eqz v3, :cond_1

    .line 1661
    const/16 v3, 0x5d

    invoke-virtual {v2, v3}, Ljava/lang/String;->indexOf(I)I

    move-result v3

    .line 1663
    if-lez v3, :cond_0

    add-int/lit8 v4, v3, 0x1

    invoke-virtual {v2, v0, v4}, Ljava/lang/String;->substring(II)Ljava/lang/String;

    move-result-object v4

    const-string v5, "[ALERT]"

    invoke-virtual {v4, v5}, Ljava/lang/String;->equalsIgnoreCase(Ljava/lang/String;)Z

    move-result v4

    if-eqz v4, :cond_0

    move v0, v1

    .line 1666
    :cond_0
    add-int/lit8 v3, v3, 0x1

    invoke-virtual {v2, v3}, Ljava/lang/String;->substring(I)Ljava/lang/String;

    move-result-object v2

    invoke-virtual {v2}, Ljava/lang/String;->trim()Ljava/lang/String;

    move-result-object v2

    .line 1668
    :cond_1
    if-eqz v0, :cond_3

    .line 1669
    invoke-virtual {p0, v1, v2}, Lcom/sun/mail/imap/IMAPStore;->notifyStoreListeners(ILjava/lang/String;)V

    .line 1675
    :cond_2
    :goto_0
    return-void

    .line 1670
    :cond_3
    invoke-virtual {p1}, Lcom/sun/mail/iap/Response;->isUnTagged()Z

    move-result v0

    if-eqz v0, :cond_2

    invoke-virtual {v2}, Ljava/lang/String;->length()I

    move-result v0

    if-lez v0, :cond_2

    .line 1674
    const/4 v0, 0x2

    invoke-virtual {p0, v0, v2}, Lcom/sun/mail/imap/IMAPStore;->notifyStoreListeners(ILjava/lang/String;)V

    goto :goto_0
.end method

.method public declared-synchronized hasCapability(Ljava/lang/String;)Z
    .locals 4
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljavax/mail/MessagingException;
        }
    .end annotation

    .prologue
    .line 1100
    monitor-enter p0

    const/4 v1, 0x0

    .line 1102
    :try_start_0
    invoke-virtual {p0}, Lcom/sun/mail/imap/IMAPStore;->getStoreProtocol()Lcom/sun/mail/imap/protocol/IMAPProtocol;

    move-result-object v1

    .line 1103
    invoke-virtual {v1, p1}, Lcom/sun/mail/imap/protocol/IMAPProtocol;->hasCapability(Ljava/lang/String;)Z
    :try_end_0
    .catch Lcom/sun/mail/iap/ProtocolException; {:try_start_0 .. :try_end_0} :catch_0
    .catchall {:try_start_0 .. :try_end_0} :catchall_0

    move-result v0

    .line 1111
    :try_start_1
    invoke-virtual {p0, v1}, Lcom/sun/mail/imap/IMAPStore;->releaseStoreProtocol(Lcom/sun/mail/imap/protocol/IMAPProtocol;)V
    :try_end_1
    .catchall {:try_start_1 .. :try_end_1} :catchall_1

    .line 1103
    monitor-exit p0

    return v0

    .line 1104
    :catch_0
    move-exception v0

    .line 1105
    if-nez v1, :cond_0

    .line 1107
    :try_start_2
    invoke-direct {p0}, Lcom/sun/mail/imap/IMAPStore;->cleanup()V

    .line 1109
    :cond_0
    new-instance v2, Ljavax/mail/MessagingException;

    invoke-virtual {v0}, Lcom/sun/mail/iap/ProtocolException;->getMessage()Ljava/lang/String;

    move-result-object v3

    invoke-direct {v2, v3, v0}, Ljavax/mail/MessagingException;-><init>(Ljava/lang/String;Ljava/lang/Exception;)V

    throw v2
    :try_end_2
    .catchall {:try_start_2 .. :try_end_2} :catchall_0

    .line 1110
    :catchall_0
    move-exception v0

    .line 1111
    :try_start_3
    invoke-virtual {p0, v1}, Lcom/sun/mail/imap/IMAPStore;->releaseStoreProtocol(Lcom/sun/mail/imap/protocol/IMAPProtocol;)V

    .line 1112
    throw v0
    :try_end_3
    .catchall {:try_start_3 .. :try_end_3} :catchall_1

    .line 1100
    :catchall_1
    move-exception v0

    monitor-exit p0

    throw v0
.end method

.method hasSeparateStoreConnection()Z
    .locals 1

    .prologue
    .line 896
    iget-object v0, p0, Lcom/sun/mail/imap/IMAPStore;->pool:Lcom/sun/mail/imap/IMAPStore$ConnectionPool;

    invoke-static {v0}, Lcom/sun/mail/imap/IMAPStore$ConnectionPool;->access$11(Lcom/sun/mail/imap/IMAPStore$ConnectionPool;)Z

    move-result v0

    return v0
.end method

.method public idle()V
    .locals 5
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljavax/mail/MessagingException;
        }
    .end annotation

    .prologue
    const/4 v1, 0x0

    .line 1551
    .line 1554
    sget-boolean v0, Lcom/sun/mail/imap/IMAPStore;->$assertionsDisabled:Z

    if-nez v0, :cond_0

    iget-object v0, p0, Lcom/sun/mail/imap/IMAPStore;->pool:Lcom/sun/mail/imap/IMAPStore$ConnectionPool;

    invoke-static {v0}, Ljava/lang/Thread;->holdsLock(Ljava/lang/Object;)Z

    move-result v0

    if-eqz v0, :cond_0

    new-instance v0, Ljava/lang/AssertionError;

    invoke-direct {v0}, Ljava/lang/AssertionError;-><init>()V

    throw v0

    .line 1555
    :cond_0
    monitor-enter p0

    .line 1556
    :try_start_0
    invoke-direct {p0}, Lcom/sun/mail/imap/IMAPStore;->checkConnected()V

    .line 1555
    monitor-exit p0
    :try_end_0
    .catchall {:try_start_0 .. :try_end_0} :catchall_0

    .line 1559
    :try_start_1
    iget-object v2, p0, Lcom/sun/mail/imap/IMAPStore;->pool:Lcom/sun/mail/imap/IMAPStore$ConnectionPool;

    monitor-enter v2
    :try_end_1
    .catch Lcom/sun/mail/iap/BadCommandException; {:try_start_1 .. :try_end_1} :catch_0
    .catch Lcom/sun/mail/iap/ConnectionException; {:try_start_1 .. :try_end_1} :catch_1
    .catch Lcom/sun/mail/iap/ProtocolException; {:try_start_1 .. :try_end_1} :catch_2
    .catchall {:try_start_1 .. :try_end_1} :catchall_3

    .line 1560
    :try_start_2
    invoke-virtual {p0}, Lcom/sun/mail/imap/IMAPStore;->getStoreProtocol()Lcom/sun/mail/imap/protocol/IMAPProtocol;

    move-result-object v1

    .line 1561
    iget-object v0, p0, Lcom/sun/mail/imap/IMAPStore;->pool:Lcom/sun/mail/imap/IMAPStore$ConnectionPool;

    invoke-static {v0}, Lcom/sun/mail/imap/IMAPStore$ConnectionPool;->access$19(Lcom/sun/mail/imap/IMAPStore$ConnectionPool;)I

    move-result v0

    if-nez v0, :cond_5

    .line 1562
    invoke-virtual {v1}, Lcom/sun/mail/imap/protocol/IMAPProtocol;->idleStart()V

    .line 1563
    iget-object v0, p0, Lcom/sun/mail/imap/IMAPStore;->pool:Lcom/sun/mail/imap/IMAPStore$ConnectionPool;

    const/4 v3, 0x1

    invoke-static {v0, v3}, Lcom/sun/mail/imap/IMAPStore$ConnectionPool;->access$20(Lcom/sun/mail/imap/IMAPStore$ConnectionPool;I)V

    .line 1574
    iget-object v0, p0, Lcom/sun/mail/imap/IMAPStore;->pool:Lcom/sun/mail/imap/IMAPStore$ConnectionPool;

    invoke-static {v0, v1}, Lcom/sun/mail/imap/IMAPStore$ConnectionPool;->access$18(Lcom/sun/mail/imap/IMAPStore$ConnectionPool;Lcom/sun/mail/imap/protocol/IMAPProtocol;)V

    .line 1559
    monitor-exit v2
    :try_end_2
    .catchall {:try_start_2 .. :try_end_2} :catchall_2

    .line 1591
    :cond_1
    :goto_0
    :try_start_3
    invoke-virtual {v1}, Lcom/sun/mail/imap/protocol/IMAPProtocol;->readIdleResponse()Lcom/sun/mail/iap/Response;

    move-result-object v0

    .line 1592
    iget-object v2, p0, Lcom/sun/mail/imap/IMAPStore;->pool:Lcom/sun/mail/imap/IMAPStore$ConnectionPool;

    monitor-enter v2
    :try_end_3
    .catch Lcom/sun/mail/iap/BadCommandException; {:try_start_3 .. :try_end_3} :catch_0
    .catch Lcom/sun/mail/iap/ConnectionException; {:try_start_3 .. :try_end_3} :catch_1
    .catch Lcom/sun/mail/iap/ProtocolException; {:try_start_3 .. :try_end_3} :catch_2
    .catchall {:try_start_3 .. :try_end_3} :catchall_3

    .line 1593
    if-eqz v0, :cond_2

    :try_start_4
    invoke-virtual {v1, v0}, Lcom/sun/mail/imap/protocol/IMAPProtocol;->processIdleResponse(Lcom/sun/mail/iap/Response;)Z

    move-result v3

    if-nez v3, :cond_7

    .line 1594
    :cond_2
    iget-object v0, p0, Lcom/sun/mail/imap/IMAPStore;->pool:Lcom/sun/mail/imap/IMAPStore$ConnectionPool;

    const/4 v3, 0x0

    invoke-static {v0, v3}, Lcom/sun/mail/imap/IMAPStore$ConnectionPool;->access$20(Lcom/sun/mail/imap/IMAPStore$ConnectionPool;I)V

    .line 1595
    iget-object v0, p0, Lcom/sun/mail/imap/IMAPStore;->pool:Lcom/sun/mail/imap/IMAPStore$ConnectionPool;

    invoke-virtual {v0}, Ljava/lang/Object;->notifyAll()V

    .line 1596
    monitor-exit v2
    :try_end_4
    .catchall {:try_start_4 .. :try_end_4} :catchall_4

    .line 1609
    :try_start_5
    invoke-virtual {p0}, Lcom/sun/mail/imap/IMAPStore;->getMinIdleTime()I
    :try_end_5
    .catch Lcom/sun/mail/iap/BadCommandException; {:try_start_5 .. :try_end_5} :catch_0
    .catch Lcom/sun/mail/iap/ConnectionException; {:try_start_5 .. :try_end_5} :catch_1
    .catch Lcom/sun/mail/iap/ProtocolException; {:try_start_5 .. :try_end_5} :catch_2
    .catchall {:try_start_5 .. :try_end_5} :catchall_3

    move-result v0

    .line 1610
    if-lez v0, :cond_3

    .line 1612
    int-to-long v2, v0

    :try_start_6
    invoke-static {v2, v3}, Ljava/lang/Thread;->sleep(J)V
    :try_end_6
    .catch Ljava/lang/InterruptedException; {:try_start_6 .. :try_end_6} :catch_3
    .catch Lcom/sun/mail/iap/BadCommandException; {:try_start_6 .. :try_end_6} :catch_0
    .catch Lcom/sun/mail/iap/ConnectionException; {:try_start_6 .. :try_end_6} :catch_1
    .catch Lcom/sun/mail/iap/ProtocolException; {:try_start_6 .. :try_end_6} :catch_2
    .catchall {:try_start_6 .. :try_end_6} :catchall_3

    .line 1623
    :cond_3
    :goto_1
    iget-object v2, p0, Lcom/sun/mail/imap/IMAPStore;->pool:Lcom/sun/mail/imap/IMAPStore$ConnectionPool;

    monitor-enter v2

    .line 1624
    :try_start_7
    iget-object v0, p0, Lcom/sun/mail/imap/IMAPStore;->pool:Lcom/sun/mail/imap/IMAPStore$ConnectionPool;

    const/4 v3, 0x0

    invoke-static {v0, v3}, Lcom/sun/mail/imap/IMAPStore$ConnectionPool;->access$18(Lcom/sun/mail/imap/IMAPStore$ConnectionPool;Lcom/sun/mail/imap/protocol/IMAPProtocol;)V

    .line 1623
    monitor-exit v2
    :try_end_7
    .catchall {:try_start_7 .. :try_end_7} :catchall_6

    .line 1626
    invoke-virtual {p0, v1}, Lcom/sun/mail/imap/IMAPStore;->releaseStoreProtocol(Lcom/sun/mail/imap/protocol/IMAPProtocol;)V

    .line 1627
    if-nez v1, :cond_4

    .line 1629
    invoke-direct {p0}, Lcom/sun/mail/imap/IMAPStore;->cleanup()V

    .line 1632
    :cond_4
    :goto_2
    return-void

    .line 1555
    :catchall_0
    move-exception v0

    :try_start_8
    monitor-exit p0
    :try_end_8
    .catchall {:try_start_8 .. :try_end_8} :catchall_0

    throw v0

    .line 1570
    :cond_5
    :try_start_9
    iget-object v0, p0, Lcom/sun/mail/imap/IMAPStore;->pool:Lcom/sun/mail/imap/IMAPStore$ConnectionPool;

    invoke-virtual {v0}, Ljava/lang/Object;->wait()V
    :try_end_9
    .catch Ljava/lang/InterruptedException; {:try_start_9 .. :try_end_9} :catch_4
    .catchall {:try_start_9 .. :try_end_9} :catchall_2

    .line 1572
    :goto_3
    :try_start_a
    monitor-exit v2
    :try_end_a
    .catchall {:try_start_a .. :try_end_a} :catchall_2

    .line 1623
    iget-object v2, p0, Lcom/sun/mail/imap/IMAPStore;->pool:Lcom/sun/mail/imap/IMAPStore$ConnectionPool;

    monitor-enter v2

    .line 1624
    :try_start_b
    iget-object v0, p0, Lcom/sun/mail/imap/IMAPStore;->pool:Lcom/sun/mail/imap/IMAPStore$ConnectionPool;

    const/4 v3, 0x0

    invoke-static {v0, v3}, Lcom/sun/mail/imap/IMAPStore$ConnectionPool;->access$18(Lcom/sun/mail/imap/IMAPStore$ConnectionPool;Lcom/sun/mail/imap/protocol/IMAPProtocol;)V

    .line 1623
    monitor-exit v2
    :try_end_b
    .catchall {:try_start_b .. :try_end_b} :catchall_1

    .line 1626
    invoke-virtual {p0, v1}, Lcom/sun/mail/imap/IMAPStore;->releaseStoreProtocol(Lcom/sun/mail/imap/protocol/IMAPProtocol;)V

    .line 1627
    if-nez v1, :cond_4

    .line 1629
    invoke-direct {p0}, Lcom/sun/mail/imap/IMAPStore;->cleanup()V

    goto :goto_2

    .line 1623
    :catchall_1
    move-exception v0

    :try_start_c
    monitor-exit v2
    :try_end_c
    .catchall {:try_start_c .. :try_end_c} :catchall_1

    throw v0

    .line 1559
    :catchall_2
    move-exception v0

    :try_start_d
    monitor-exit v2
    :try_end_d
    .catchall {:try_start_d .. :try_end_d} :catchall_2

    :try_start_e
    throw v0
    :try_end_e
    .catch Lcom/sun/mail/iap/BadCommandException; {:try_start_e .. :try_end_e} :catch_0
    .catch Lcom/sun/mail/iap/ConnectionException; {:try_start_e .. :try_end_e} :catch_1
    .catch Lcom/sun/mail/iap/ProtocolException; {:try_start_e .. :try_end_e} :catch_2
    .catchall {:try_start_e .. :try_end_e} :catchall_3

    .line 1616
    :catch_0
    move-exception v0

    .line 1617
    :try_start_f
    new-instance v2, Ljavax/mail/MessagingException;

    const-string v3, "IDLE not supported"

    invoke-direct {v2, v3, v0}, Ljavax/mail/MessagingException;-><init>(Ljava/lang/String;Ljava/lang/Exception;)V

    throw v2
    :try_end_f
    .catchall {:try_start_f .. :try_end_f} :catchall_3

    .line 1622
    :catchall_3
    move-exception v0

    .line 1623
    iget-object v2, p0, Lcom/sun/mail/imap/IMAPStore;->pool:Lcom/sun/mail/imap/IMAPStore$ConnectionPool;

    monitor-enter v2

    .line 1624
    :try_start_10
    iget-object v3, p0, Lcom/sun/mail/imap/IMAPStore;->pool:Lcom/sun/mail/imap/IMAPStore$ConnectionPool;

    const/4 v4, 0x0

    invoke-static {v3, v4}, Lcom/sun/mail/imap/IMAPStore$ConnectionPool;->access$18(Lcom/sun/mail/imap/IMAPStore$ConnectionPool;Lcom/sun/mail/imap/protocol/IMAPProtocol;)V

    .line 1623
    monitor-exit v2
    :try_end_10
    .catchall {:try_start_10 .. :try_end_10} :catchall_5

    .line 1626
    invoke-virtual {p0, v1}, Lcom/sun/mail/imap/IMAPStore;->releaseStoreProtocol(Lcom/sun/mail/imap/protocol/IMAPProtocol;)V

    .line 1627
    if-nez v1, :cond_6

    .line 1629
    invoke-direct {p0}, Lcom/sun/mail/imap/IMAPStore;->cleanup()V

    .line 1631
    :cond_6
    throw v0

    .line 1592
    :cond_7
    :try_start_11
    monitor-exit v2
    :try_end_11
    .catchall {:try_start_11 .. :try_end_11} :catchall_4

    .line 1599
    :try_start_12
    iget-boolean v2, p0, Lcom/sun/mail/imap/IMAPStore;->enableImapEvents:Z

    if-eqz v2, :cond_1

    invoke-virtual {v0}, Lcom/sun/mail/iap/Response;->isUnTagged()Z

    move-result v2

    if-eqz v2, :cond_1

    .line 1600
    const/16 v2, 0x3e8

    invoke-virtual {v0}, Lcom/sun/mail/iap/Response;->toString()Ljava/lang/String;

    move-result-object v0

    invoke-virtual {p0, v2, v0}, Lcom/sun/mail/imap/IMAPStore;->notifyStoreListeners(ILjava/lang/String;)V
    :try_end_12
    .catch Lcom/sun/mail/iap/BadCommandException; {:try_start_12 .. :try_end_12} :catch_0
    .catch Lcom/sun/mail/iap/ConnectionException; {:try_start_12 .. :try_end_12} :catch_1
    .catch Lcom/sun/mail/iap/ProtocolException; {:try_start_12 .. :try_end_12} :catch_2
    .catchall {:try_start_12 .. :try_end_12} :catchall_3

    goto/16 :goto_0

    .line 1618
    :catch_1
    move-exception v0

    .line 1619
    :try_start_13
    new-instance v2, Ljavax/mail/StoreClosedException;

    invoke-virtual {v0}, Lcom/sun/mail/iap/ConnectionException;->getMessage()Ljava/lang/String;

    move-result-object v0

    invoke-direct {v2, p0, v0}, Ljavax/mail/StoreClosedException;-><init>(Ljavax/mail/Store;Ljava/lang/String;)V

    throw v2
    :try_end_13
    .catchall {:try_start_13 .. :try_end_13} :catchall_3

    .line 1592
    :catchall_4
    move-exception v0

    :try_start_14
    monitor-exit v2
    :try_end_14
    .catchall {:try_start_14 .. :try_end_14} :catchall_4

    :try_start_15
    throw v0
    :try_end_15
    .catch Lcom/sun/mail/iap/BadCommandException; {:try_start_15 .. :try_end_15} :catch_0
    .catch Lcom/sun/mail/iap/ConnectionException; {:try_start_15 .. :try_end_15} :catch_1
    .catch Lcom/sun/mail/iap/ProtocolException; {:try_start_15 .. :try_end_15} :catch_2
    .catchall {:try_start_15 .. :try_end_15} :catchall_3

    .line 1620
    :catch_2
    move-exception v0

    .line 1621
    :try_start_16
    new-instance v2, Ljavax/mail/MessagingException;

    invoke-virtual {v0}, Lcom/sun/mail/iap/ProtocolException;->getMessage()Ljava/lang/String;

    move-result-object v3

    invoke-direct {v2, v3, v0}, Ljavax/mail/MessagingException;-><init>(Ljava/lang/String;Ljava/lang/Exception;)V

    throw v2
    :try_end_16
    .catchall {:try_start_16 .. :try_end_16} :catchall_3

    .line 1623
    :catchall_5
    move-exception v0

    :try_start_17
    monitor-exit v2
    :try_end_17
    .catchall {:try_start_17 .. :try_end_17} :catchall_5

    throw v0

    :catchall_6
    move-exception v0

    :try_start_18
    monitor-exit v2
    :try_end_18
    .catchall {:try_start_18 .. :try_end_18} :catchall_6

    throw v0

    .line 1613
    :catch_3
    move-exception v0

    goto/16 :goto_1

    .line 1571
    :catch_4
    move-exception v0

    goto :goto_3
.end method

.method public declared-synchronized isConnected()Z
    .locals 3

    .prologue
    const/4 v0, 0x0

    .line 1120
    monitor-enter p0

    :try_start_0
    iget-boolean v1, p0, Lcom/sun/mail/imap/IMAPStore;->connected:Z

    if-nez v1, :cond_0

    .line 1123
    const/4 v1, 0x0

    invoke-super {p0, v1}, Ljavax/mail/Store;->setConnected(Z)V
    :try_end_0
    .catchall {:try_start_0 .. :try_end_0} :catchall_0

    .line 1158
    :goto_0
    monitor-exit p0

    return v0

    .line 1143
    :cond_0
    const/4 v0, 0x0

    .line 1145
    :try_start_1
    invoke-virtual {p0}, Lcom/sun/mail/imap/IMAPStore;->getStoreProtocol()Lcom/sun/mail/imap/protocol/IMAPProtocol;
    :try_end_1
    .catch Lcom/sun/mail/iap/ProtocolException; {:try_start_1 .. :try_end_1} :catch_0
    .catchall {:try_start_1 .. :try_end_1} :catchall_1

    move-result-object v0

    .line 1146
    :try_start_2
    invoke-virtual {v0}, Lcom/sun/mail/imap/protocol/IMAPProtocol;->noop()V
    :try_end_2
    .catch Lcom/sun/mail/iap/ProtocolException; {:try_start_2 .. :try_end_2} :catch_0
    .catchall {:try_start_2 .. :try_end_2} :catchall_2

    .line 1154
    :try_start_3
    invoke-virtual {p0, v0}, Lcom/sun/mail/imap/IMAPStore;->releaseStoreProtocol(Lcom/sun/mail/imap/protocol/IMAPProtocol;)V

    .line 1158
    :goto_1
    invoke-super {p0}, Ljavax/mail/Store;->isConnected()Z
    :try_end_3
    .catchall {:try_start_3 .. :try_end_3} :catchall_0

    move-result v0

    goto :goto_0

    .line 1147
    :catch_0
    move-exception v1

    .line 1148
    if-nez v0, :cond_1

    .line 1150
    :try_start_4
    invoke-direct {p0}, Lcom/sun/mail/imap/IMAPStore;->cleanup()V
    :try_end_4
    .catchall {:try_start_4 .. :try_end_4} :catchall_2

    .line 1154
    :cond_1
    :try_start_5
    invoke-virtual {p0, v0}, Lcom/sun/mail/imap/IMAPStore;->releaseStoreProtocol(Lcom/sun/mail/imap/protocol/IMAPProtocol;)V
    :try_end_5
    .catchall {:try_start_5 .. :try_end_5} :catchall_0

    goto :goto_1

    .line 1120
    :catchall_0
    move-exception v0

    monitor-exit p0

    throw v0

    .line 1153
    :catchall_1
    move-exception v1

    move-object v2, v1

    move-object v1, v0

    move-object v0, v2

    .line 1154
    :goto_2
    :try_start_6
    invoke-virtual {p0, v1}, Lcom/sun/mail/imap/IMAPStore;->releaseStoreProtocol(Lcom/sun/mail/imap/protocol/IMAPProtocol;)V

    .line 1155
    throw v0
    :try_end_6
    .catchall {:try_start_6 .. :try_end_6} :catchall_0

    .line 1153
    :catchall_2
    move-exception v1

    move-object v2, v1

    move-object v1, v0

    move-object v0, v2

    goto :goto_2
.end method

.method isConnectionPoolFull()Z
    .locals 4

    .prologue
    .line 911
    iget-object v1, p0, Lcom/sun/mail/imap/IMAPStore;->pool:Lcom/sun/mail/imap/IMAPStore$ConnectionPool;

    monitor-enter v1

    .line 912
    :try_start_0
    iget-object v0, p0, Lcom/sun/mail/imap/IMAPStore;->pool:Lcom/sun/mail/imap/IMAPStore$ConnectionPool;

    invoke-static {v0}, Lcom/sun/mail/imap/IMAPStore$ConnectionPool;->access$3(Lcom/sun/mail/imap/IMAPStore$ConnectionPool;)Z

    move-result v0

    if-eqz v0, :cond_0

    .line 913
    iget-object v0, p0, Lcom/sun/mail/imap/IMAPStore;->out:Ljava/io/PrintStream;

    new-instance v2, Ljava/lang/StringBuilder;

    const-string v3, "DEBUG: current size: "

    invoke-direct {v2, v3}, Ljava/lang/StringBuilder;-><init>(Ljava/lang/String;)V

    .line 914
    iget-object v3, p0, Lcom/sun/mail/imap/IMAPStore;->pool:Lcom/sun/mail/imap/IMAPStore$ConnectionPool;

    invoke-static {v3}, Lcom/sun/mail/imap/IMAPStore$ConnectionPool;->access$10(Lcom/sun/mail/imap/IMAPStore$ConnectionPool;)Ljava/util/Vector;

    move-result-object v3

    invoke-virtual {v3}, Ljava/util/Vector;->size()I

    move-result v3

    invoke-virtual {v2, v3}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v2

    .line 915
    const-string v3, "   pool size: "

    invoke-virtual {v2, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    iget-object v3, p0, Lcom/sun/mail/imap/IMAPStore;->pool:Lcom/sun/mail/imap/IMAPStore$ConnectionPool;

    invoke-static {v3}, Lcom/sun/mail/imap/IMAPStore$ConnectionPool;->access$4(Lcom/sun/mail/imap/IMAPStore$ConnectionPool;)I

    move-result v3

    invoke-virtual {v2, v3}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v2

    invoke-virtual {v2}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v2

    .line 913
    invoke-virtual {v0, v2}, Ljava/io/PrintStream;->println(Ljava/lang/String;)V

    .line 917
    :cond_0
    iget-object v0, p0, Lcom/sun/mail/imap/IMAPStore;->pool:Lcom/sun/mail/imap/IMAPStore$ConnectionPool;

    invoke-static {v0}, Lcom/sun/mail/imap/IMAPStore$ConnectionPool;->access$10(Lcom/sun/mail/imap/IMAPStore$ConnectionPool;)Ljava/util/Vector;

    move-result-object v0

    invoke-virtual {v0}, Ljava/util/Vector;->size()I

    move-result v0

    iget-object v2, p0, Lcom/sun/mail/imap/IMAPStore;->pool:Lcom/sun/mail/imap/IMAPStore$ConnectionPool;

    invoke-static {v2}, Lcom/sun/mail/imap/IMAPStore$ConnectionPool;->access$4(Lcom/sun/mail/imap/IMAPStore$ConnectionPool;)I

    move-result v2

    if-lt v0, v2, :cond_1

    const/4 v0, 0x1

    :goto_0
    monitor-exit v1

    return v0

    :cond_1
    const/4 v0, 0x0

    goto :goto_0

    .line 911
    :catchall_0
    move-exception v0

    monitor-exit v1
    :try_end_0
    .catchall {:try_start_0 .. :try_end_0} :catchall_0

    throw v0
.end method

.method protected declared-synchronized protocolConnect(Ljava/lang/String;ILjava/lang/String;Ljava/lang/String;)Z
    .locals 11
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljavax/mail/MessagingException;
        }
    .end annotation

    .prologue
    const/4 v8, 0x1

    const/4 v3, -0x1

    .line 503
    monitor-enter p0

    const/4 v9, 0x0

    .line 506
    if-eqz p1, :cond_0

    if-eqz p4, :cond_0

    if-nez p3, :cond_3

    .line 507
    :cond_0
    :try_start_0
    iget-boolean v0, p0, Lcom/sun/mail/imap/IMAPStore;->debug:Z

    if-eqz v0, :cond_1

    .line 508
    iget-object v1, p0, Lcom/sun/mail/imap/IMAPStore;->out:Ljava/io/PrintStream;

    new-instance v0, Ljava/lang/StringBuilder;

    const-string v2, "DEBUG: protocolConnect returning false, host="

    invoke-direct {v0, v2}, Ljava/lang/StringBuilder;-><init>(Ljava/lang/String;)V

    .line 509
    invoke-virtual {v0, p1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    .line 510
    const-string v2, ", user="

    invoke-virtual {v0, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-virtual {v0, p3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    .line 511
    const-string v2, ", password="

    invoke-virtual {v0, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    if-eqz p4, :cond_2

    .line 512
    const-string v0, "<non-null>"

    :goto_0
    invoke-virtual {v2, v0}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-virtual {v0}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v0

    .line 508
    invoke-virtual {v1, v0}, Ljava/io/PrintStream;->println(Ljava/lang/String;)V
    :try_end_0
    .catchall {:try_start_0 .. :try_end_0} :catchall_0

    .line 513
    :cond_1
    const/4 v0, 0x0

    .line 575
    :goto_1
    monitor-exit p0

    return v0

    .line 512
    :cond_2
    :try_start_1
    const-string v0, "<null>"

    goto :goto_0

    .line 517
    :cond_3
    if-eq p2, v3, :cond_8

    .line 518
    iput p2, p0, Lcom/sun/mail/imap/IMAPStore;->port:I

    .line 527
    :cond_4
    :goto_2
    iget v0, p0, Lcom/sun/mail/imap/IMAPStore;->port:I

    if-ne v0, v3, :cond_5

    .line 528
    iget v0, p0, Lcom/sun/mail/imap/IMAPStore;->defaultPort:I

    iput v0, p0, Lcom/sun/mail/imap/IMAPStore;->port:I
    :try_end_1
    .catchall {:try_start_1 .. :try_end_1} :catchall_0

    .line 533
    :cond_5
    :try_start_2
    iget-object v1, p0, Lcom/sun/mail/imap/IMAPStore;->pool:Lcom/sun/mail/imap/IMAPStore$ConnectionPool;

    monitor-enter v1
    :try_end_2
    .catch Lcom/sun/mail/iap/CommandFailedException; {:try_start_2 .. :try_end_2} :catch_0
    .catch Lcom/sun/mail/iap/ProtocolException; {:try_start_2 .. :try_end_2} :catch_2
    .catch Ljava/io/IOException; {:try_start_2 .. :try_end_2} :catch_3
    .catchall {:try_start_2 .. :try_end_2} :catchall_0

    .line 534
    :try_start_3
    iget-object v0, p0, Lcom/sun/mail/imap/IMAPStore;->pool:Lcom/sun/mail/imap/IMAPStore$ConnectionPool;

    invoke-static {v0}, Lcom/sun/mail/imap/IMAPStore$ConnectionPool;->access$10(Lcom/sun/mail/imap/IMAPStore$ConnectionPool;)Ljava/util/Vector;

    move-result-object v0

    invoke-virtual {v0}, Ljava/util/Vector;->isEmpty()Z

    move-result v0

    .line 533
    monitor-exit v1
    :try_end_3
    .catchall {:try_start_3 .. :try_end_3} :catchall_1

    .line 537
    if-eqz v0, :cond_7

    .line 538
    :try_start_4
    new-instance v0, Lcom/sun/mail/imap/protocol/IMAPProtocol;

    iget-object v1, p0, Lcom/sun/mail/imap/IMAPStore;->name:Ljava/lang/String;

    iget v3, p0, Lcom/sun/mail/imap/IMAPStore;->port:I

    .line 539
    iget-object v2, p0, Lcom/sun/mail/imap/IMAPStore;->session:Ljavax/mail/Session;

    invoke-virtual {v2}, Ljavax/mail/Session;->getDebug()Z

    move-result v4

    .line 540
    iget-object v2, p0, Lcom/sun/mail/imap/IMAPStore;->session:Ljavax/mail/Session;

    invoke-virtual {v2}, Ljavax/mail/Session;->getDebugOut()Ljava/io/PrintStream;

    move-result-object v5

    .line 541
    iget-object v2, p0, Lcom/sun/mail/imap/IMAPStore;->session:Ljavax/mail/Session;

    invoke-virtual {v2}, Ljavax/mail/Session;->getProperties()Ljava/util/Properties;

    move-result-object v6

    .line 542
    iget-boolean v7, p0, Lcom/sun/mail/imap/IMAPStore;->isSSL:Z

    move-object v2, p1

    .line 538
    invoke-direct/range {v0 .. v7}, Lcom/sun/mail/imap/protocol/IMAPProtocol;-><init>(Ljava/lang/String;Ljava/lang/String;IZLjava/io/PrintStream;Ljava/util/Properties;Z)V
    :try_end_4
    .catch Lcom/sun/mail/iap/CommandFailedException; {:try_start_4 .. :try_end_4} :catch_0
    .catch Lcom/sun/mail/iap/ProtocolException; {:try_start_4 .. :try_end_4} :catch_2
    .catch Ljava/io/IOException; {:try_start_4 .. :try_end_4} :catch_3
    .catchall {:try_start_4 .. :try_end_4} :catchall_0

    .line 544
    :try_start_5
    iget-boolean v1, p0, Lcom/sun/mail/imap/IMAPStore;->debug:Z

    if-eqz v1, :cond_6

    .line 545
    iget-object v1, p0, Lcom/sun/mail/imap/IMAPStore;->out:Ljava/io/PrintStream;

    new-instance v2, Ljava/lang/StringBuilder;

    const-string v3, "DEBUG: protocolConnect login, host="

    invoke-direct {v2, v3}, Ljava/lang/StringBuilder;-><init>(Ljava/lang/String;)V

    .line 546
    invoke-virtual {v2, p1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    .line 547
    const-string v3, ", user="

    invoke-virtual {v2, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    invoke-virtual {v2, p3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    .line 548
    const-string v3, ", password=<non-null>"

    invoke-virtual {v2, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    invoke-virtual {v2}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v2

    .line 545
    invoke-virtual {v1, v2}, Ljava/io/PrintStream;->println(Ljava/lang/String;)V

    .line 549
    :cond_6
    invoke-direct {p0, v0, p3, p4}, Lcom/sun/mail/imap/IMAPStore;->login(Lcom/sun/mail/imap/protocol/IMAPProtocol;Ljava/lang/String;Ljava/lang/String;)V

    .line 551
    invoke-virtual {v0, p0}, Lcom/sun/mail/imap/protocol/IMAPProtocol;->addResponseHandler(Lcom/sun/mail/iap/ResponseHandler;)V

    .line 553
    iput-object p1, p0, Lcom/sun/mail/imap/IMAPStore;->host:Ljava/lang/String;

    .line 554
    iput-object p3, p0, Lcom/sun/mail/imap/IMAPStore;->user:Ljava/lang/String;

    .line 555
    iput-object p4, p0, Lcom/sun/mail/imap/IMAPStore;->password:Ljava/lang/String;

    .line 557
    iget-object v2, p0, Lcom/sun/mail/imap/IMAPStore;->pool:Lcom/sun/mail/imap/IMAPStore$ConnectionPool;

    monitor-enter v2
    :try_end_5
    .catch Lcom/sun/mail/iap/CommandFailedException; {:try_start_5 .. :try_end_5} :catch_1
    .catch Lcom/sun/mail/iap/ProtocolException; {:try_start_5 .. :try_end_5} :catch_2
    .catch Ljava/io/IOException; {:try_start_5 .. :try_end_5} :catch_3
    .catchall {:try_start_5 .. :try_end_5} :catchall_0

    .line 558
    :try_start_6
    iget-object v1, p0, Lcom/sun/mail/imap/IMAPStore;->pool:Lcom/sun/mail/imap/IMAPStore$ConnectionPool;

    invoke-static {v1}, Lcom/sun/mail/imap/IMAPStore$ConnectionPool;->access$10(Lcom/sun/mail/imap/IMAPStore$ConnectionPool;)Ljava/util/Vector;

    move-result-object v1

    invoke-virtual {v1, v0}, Ljava/util/Vector;->addElement(Ljava/lang/Object;)V

    .line 557
    monitor-exit v2
    :try_end_6
    .catchall {:try_start_6 .. :try_end_6} :catchall_2

    .line 574
    :cond_7
    const/4 v0, 0x1

    :try_start_7
    iput-boolean v0, p0, Lcom/sun/mail/imap/IMAPStore;->connected:Z

    move v0, v8

    .line 575
    goto/16 :goto_1

    .line 520
    :cond_8
    iget-object v0, p0, Lcom/sun/mail/imap/IMAPStore;->session:Ljavax/mail/Session;

    new-instance v1, Ljava/lang/StringBuilder;

    const-string v2, "mail."

    invoke-direct {v1, v2}, Ljava/lang/StringBuilder;-><init>(Ljava/lang/String;)V

    iget-object v2, p0, Lcom/sun/mail/imap/IMAPStore;->name:Ljava/lang/String;

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    const-string v2, ".port"

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v1

    invoke-virtual {v0, v1}, Ljavax/mail/Session;->getProperty(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v0

    .line 521
    if-eqz v0, :cond_4

    .line 522
    invoke-static {v0}, Ljava/lang/Integer;->parseInt(Ljava/lang/String;)I

    move-result v0

    iput v0, p0, Lcom/sun/mail/imap/IMAPStore;->port:I
    :try_end_7
    .catchall {:try_start_7 .. :try_end_7} :catchall_0

    goto/16 :goto_2

    .line 503
    :catchall_0
    move-exception v0

    monitor-exit p0

    throw v0

    .line 533
    :catchall_1
    move-exception v0

    :try_start_8
    monitor-exit v1
    :try_end_8
    .catchall {:try_start_8 .. :try_end_8} :catchall_1

    :try_start_9
    throw v0
    :try_end_9
    .catch Lcom/sun/mail/iap/CommandFailedException; {:try_start_9 .. :try_end_9} :catch_0
    .catch Lcom/sun/mail/iap/ProtocolException; {:try_start_9 .. :try_end_9} :catch_2
    .catch Ljava/io/IOException; {:try_start_9 .. :try_end_9} :catch_3
    .catchall {:try_start_9 .. :try_end_9} :catchall_0

    .line 561
    :catch_0
    move-exception v0

    move-object v1, v9

    .line 563
    :goto_3
    if-eqz v1, :cond_9

    .line 564
    :try_start_a
    invoke-virtual {v1}, Lcom/sun/mail/imap/protocol/IMAPProtocol;->disconnect()V

    .line 566
    :cond_9
    new-instance v1, Ljavax/mail/AuthenticationFailedException;

    .line 567
    invoke-virtual {v0}, Lcom/sun/mail/iap/CommandFailedException;->getResponse()Lcom/sun/mail/iap/Response;

    move-result-object v0

    invoke-virtual {v0}, Lcom/sun/mail/iap/Response;->getRest()Ljava/lang/String;

    move-result-object v0

    .line 566
    invoke-direct {v1, v0}, Ljavax/mail/AuthenticationFailedException;-><init>(Ljava/lang/String;)V

    throw v1
    :try_end_a
    .catchall {:try_start_a .. :try_end_a} :catchall_0

    .line 557
    :catchall_2
    move-exception v1

    :try_start_b
    monitor-exit v2
    :try_end_b
    .catchall {:try_start_b .. :try_end_b} :catchall_2

    :try_start_c
    throw v1
    :try_end_c
    .catch Lcom/sun/mail/iap/CommandFailedException; {:try_start_c .. :try_end_c} :catch_1
    .catch Lcom/sun/mail/iap/ProtocolException; {:try_start_c .. :try_end_c} :catch_2
    .catch Ljava/io/IOException; {:try_start_c .. :try_end_c} :catch_3
    .catchall {:try_start_c .. :try_end_c} :catchall_0

    .line 561
    :catch_1
    move-exception v1

    move-object v10, v1

    move-object v1, v0

    move-object v0, v10

    goto :goto_3

    .line 568
    :catch_2
    move-exception v0

    .line 569
    :try_start_d
    new-instance v1, Ljavax/mail/MessagingException;

    invoke-virtual {v0}, Lcom/sun/mail/iap/ProtocolException;->getMessage()Ljava/lang/String;

    move-result-object v2

    invoke-direct {v1, v2, v0}, Ljavax/mail/MessagingException;-><init>(Ljava/lang/String;Ljava/lang/Exception;)V

    throw v1

    .line 570
    :catch_3
    move-exception v0

    .line 571
    new-instance v1, Ljavax/mail/MessagingException;

    invoke-virtual {v0}, Ljava/io/IOException;->getMessage()Ljava/lang/String;

    move-result-object v2

    invoke-direct {v1, v2, v0}, Ljavax/mail/MessagingException;-><init>(Ljava/lang/String;Ljava/lang/Exception;)V

    throw v1
    :try_end_d
    .catchall {:try_start_d .. :try_end_d} :catchall_0
.end method

.method releaseProtocol(Lcom/sun/mail/imap/IMAPFolder;Lcom/sun/mail/imap/protocol/IMAPProtocol;)V
    .locals 4

    .prologue
    .line 927
    iget-object v1, p0, Lcom/sun/mail/imap/IMAPStore;->pool:Lcom/sun/mail/imap/IMAPStore$ConnectionPool;

    monitor-enter v1

    .line 928
    if-eqz p2, :cond_0

    .line 931
    :try_start_0
    invoke-virtual {p0}, Lcom/sun/mail/imap/IMAPStore;->isConnectionPoolFull()Z

    move-result v0

    if-nez v0, :cond_2

    .line 932
    invoke-virtual {p2, p0}, Lcom/sun/mail/imap/protocol/IMAPProtocol;->addResponseHandler(Lcom/sun/mail/iap/ResponseHandler;)V

    .line 933
    iget-object v0, p0, Lcom/sun/mail/imap/IMAPStore;->pool:Lcom/sun/mail/imap/IMAPStore$ConnectionPool;

    invoke-static {v0}, Lcom/sun/mail/imap/IMAPStore$ConnectionPool;->access$10(Lcom/sun/mail/imap/IMAPStore$ConnectionPool;)Ljava/util/Vector;

    move-result-object v0

    invoke-virtual {v0, p2}, Ljava/util/Vector;->addElement(Ljava/lang/Object;)V

    .line 935
    iget-boolean v0, p0, Lcom/sun/mail/imap/IMAPStore;->debug:Z

    if-eqz v0, :cond_0

    .line 936
    iget-object v0, p0, Lcom/sun/mail/imap/IMAPStore;->out:Ljava/io/PrintStream;

    new-instance v2, Ljava/lang/StringBuilder;

    const-string v3, "DEBUG: added an Authenticated connection -- size: "

    invoke-direct {v2, v3}, Ljava/lang/StringBuilder;-><init>(Ljava/lang/String;)V

    .line 938
    iget-object v3, p0, Lcom/sun/mail/imap/IMAPStore;->pool:Lcom/sun/mail/imap/IMAPStore$ConnectionPool;

    invoke-static {v3}, Lcom/sun/mail/imap/IMAPStore$ConnectionPool;->access$10(Lcom/sun/mail/imap/IMAPStore$ConnectionPool;)Ljava/util/Vector;

    move-result-object v3

    invoke-virtual {v3}, Ljava/util/Vector;->size()I

    move-result v3

    invoke-virtual {v2, v3}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v2

    invoke-virtual {v2}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v2

    .line 936
    invoke-virtual {v0, v2}, Ljava/io/PrintStream;->println(Ljava/lang/String;)V

    .line 949
    :cond_0
    :goto_0
    iget-object v0, p0, Lcom/sun/mail/imap/IMAPStore;->pool:Lcom/sun/mail/imap/IMAPStore$ConnectionPool;

    invoke-static {v0}, Lcom/sun/mail/imap/IMAPStore$ConnectionPool;->access$13(Lcom/sun/mail/imap/IMAPStore$ConnectionPool;)Ljava/util/Vector;

    move-result-object v0

    if-eqz v0, :cond_1

    .line 950
    iget-object v0, p0, Lcom/sun/mail/imap/IMAPStore;->pool:Lcom/sun/mail/imap/IMAPStore$ConnectionPool;

    invoke-static {v0}, Lcom/sun/mail/imap/IMAPStore$ConnectionPool;->access$13(Lcom/sun/mail/imap/IMAPStore$ConnectionPool;)Ljava/util/Vector;

    move-result-object v0

    invoke-virtual {v0, p1}, Ljava/util/Vector;->removeElement(Ljava/lang/Object;)Z

    .line 952
    :cond_1
    invoke-direct {p0}, Lcom/sun/mail/imap/IMAPStore;->timeoutConnections()V

    .line 927
    monitor-exit v1

    .line 954
    return-void

    .line 940
    :cond_2
    iget-boolean v0, p0, Lcom/sun/mail/imap/IMAPStore;->debug:Z

    if-eqz v0, :cond_3

    .line 941
    iget-object v0, p0, Lcom/sun/mail/imap/IMAPStore;->out:Ljava/io/PrintStream;

    const-string v2, "DEBUG: pool is full, not adding an Authenticated connection"

    invoke-virtual {v0, v2}, Ljava/io/PrintStream;->println(Ljava/lang/String;)V
    :try_end_0
    .catchall {:try_start_0 .. :try_end_0} :catchall_0

    .line 944
    :cond_3
    :try_start_1
    invoke-virtual {p2}, Lcom/sun/mail/imap/protocol/IMAPProtocol;->logout()V
    :try_end_1
    .catch Lcom/sun/mail/iap/ProtocolException; {:try_start_1 .. :try_end_1} :catch_0
    .catchall {:try_start_1 .. :try_end_1} :catchall_0

    goto :goto_0

    .line 945
    :catch_0
    move-exception v0

    goto :goto_0

    .line 927
    :catchall_0
    move-exception v0

    :try_start_2
    monitor-exit v1
    :try_end_2
    .catchall {:try_start_2 .. :try_end_2} :catchall_0

    throw v0
.end method

.method releaseStoreProtocol(Lcom/sun/mail/imap/protocol/IMAPProtocol;)V
    .locals 3

    .prologue
    .line 961
    if-nez p1, :cond_0

    .line 972
    :goto_0
    return-void

    .line 963
    :cond_0
    iget-object v1, p0, Lcom/sun/mail/imap/IMAPStore;->pool:Lcom/sun/mail/imap/IMAPStore$ConnectionPool;

    monitor-enter v1

    .line 964
    :try_start_0
    iget-object v0, p0, Lcom/sun/mail/imap/IMAPStore;->pool:Lcom/sun/mail/imap/IMAPStore$ConnectionPool;

    const/4 v2, 0x0

    invoke-static {v0, v2}, Lcom/sun/mail/imap/IMAPStore$ConnectionPool;->access$15(Lcom/sun/mail/imap/IMAPStore$ConnectionPool;Z)V

    .line 965
    iget-object v0, p0, Lcom/sun/mail/imap/IMAPStore;->pool:Lcom/sun/mail/imap/IMAPStore$ConnectionPool;

    invoke-virtual {v0}, Ljava/lang/Object;->notifyAll()V

    .line 967
    iget-object v0, p0, Lcom/sun/mail/imap/IMAPStore;->pool:Lcom/sun/mail/imap/IMAPStore$ConnectionPool;

    invoke-static {v0}, Lcom/sun/mail/imap/IMAPStore$ConnectionPool;->access$3(Lcom/sun/mail/imap/IMAPStore$ConnectionPool;)Z

    move-result v0

    if-eqz v0, :cond_1

    .line 968
    iget-object v0, p0, Lcom/sun/mail/imap/IMAPStore;->out:Ljava/io/PrintStream;

    const-string v2, "DEBUG: releaseStoreProtocol()"

    invoke-virtual {v0, v2}, Ljava/io/PrintStream;->println(Ljava/lang/String;)V

    .line 970
    :cond_1
    invoke-direct {p0}, Lcom/sun/mail/imap/IMAPStore;->timeoutConnections()V

    .line 963
    monitor-exit v1

    goto :goto_0

    :catchall_0
    move-exception v0

    monitor-exit v1
    :try_end_0
    .catchall {:try_start_0 .. :try_end_0} :catchall_0

    throw v0
.end method

.method public declared-synchronized setPassword(Ljava/lang/String;)V
    .locals 1

    .prologue
    .line 668
    monitor-enter p0

    :try_start_0
    iput-object p1, p0, Lcom/sun/mail/imap/IMAPStore;->password:Ljava/lang/String;
    :try_end_0
    .catchall {:try_start_0 .. :try_end_0} :catchall_0

    .line 669
    monitor-exit p0

    return-void

    .line 668
    :catchall_0
    move-exception v0

    monitor-exit p0

    throw v0
.end method

.method public declared-synchronized setQuota(Ljavax/mail/Quota;)V
    .locals 4
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljavax/mail/MessagingException;
        }
    .end annotation

    .prologue
    .line 1469
    monitor-enter p0

    :try_start_0
    invoke-direct {p0}, Lcom/sun/mail/imap/IMAPStore;->checkConnected()V
    :try_end_0
    .catchall {:try_start_0 .. :try_end_0} :catchall_1

    .line 1470
    const/4 v1, 0x0

    .line 1472
    :try_start_1
    invoke-virtual {p0}, Lcom/sun/mail/imap/IMAPStore;->getStoreProtocol()Lcom/sun/mail/imap/protocol/IMAPProtocol;

    move-result-object v1

    .line 1473
    invoke-virtual {v1, p1}, Lcom/sun/mail/imap/protocol/IMAPProtocol;->setQuota(Ljavax/mail/Quota;)V
    :try_end_1
    .catch Lcom/sun/mail/iap/BadCommandException; {:try_start_1 .. :try_end_1} :catch_0
    .catch Lcom/sun/mail/iap/ConnectionException; {:try_start_1 .. :try_end_1} :catch_1
    .catch Lcom/sun/mail/iap/ProtocolException; {:try_start_1 .. :try_end_1} :catch_2
    .catchall {:try_start_1 .. :try_end_1} :catchall_0

    .line 1481
    :try_start_2
    invoke-virtual {p0, v1}, Lcom/sun/mail/imap/IMAPStore;->releaseStoreProtocol(Lcom/sun/mail/imap/protocol/IMAPProtocol;)V

    .line 1482
    if-nez v1, :cond_0

    .line 1484
    invoke-direct {p0}, Lcom/sun/mail/imap/IMAPStore;->cleanup()V
    :try_end_2
    .catchall {:try_start_2 .. :try_end_2} :catchall_1

    .line 1487
    :cond_0
    monitor-exit p0

    return-void

    .line 1474
    :catch_0
    move-exception v0

    .line 1475
    :try_start_3
    new-instance v2, Ljavax/mail/MessagingException;

    const-string v3, "QUOTA not supported"

    invoke-direct {v2, v3, v0}, Ljavax/mail/MessagingException;-><init>(Ljava/lang/String;Ljava/lang/Exception;)V

    throw v2
    :try_end_3
    .catchall {:try_start_3 .. :try_end_3} :catchall_0

    .line 1480
    :catchall_0
    move-exception v0

    .line 1481
    :try_start_4
    invoke-virtual {p0, v1}, Lcom/sun/mail/imap/IMAPStore;->releaseStoreProtocol(Lcom/sun/mail/imap/protocol/IMAPProtocol;)V

    .line 1482
    if-nez v1, :cond_1

    .line 1484
    invoke-direct {p0}, Lcom/sun/mail/imap/IMAPStore;->cleanup()V

    .line 1486
    :cond_1
    throw v0
    :try_end_4
    .catchall {:try_start_4 .. :try_end_4} :catchall_1

    .line 1469
    :catchall_1
    move-exception v0

    monitor-exit p0

    throw v0

    .line 1476
    :catch_1
    move-exception v0

    .line 1477
    :try_start_5
    new-instance v2, Ljavax/mail/StoreClosedException;

    invoke-virtual {v0}, Lcom/sun/mail/iap/ConnectionException;->getMessage()Ljava/lang/String;

    move-result-object v0

    invoke-direct {v2, p0, v0}, Ljavax/mail/StoreClosedException;-><init>(Ljavax/mail/Store;Ljava/lang/String;)V

    throw v2

    .line 1478
    :catch_2
    move-exception v0

    .line 1479
    new-instance v2, Ljavax/mail/MessagingException;

    invoke-virtual {v0}, Lcom/sun/mail/iap/ProtocolException;->getMessage()Ljava/lang/String;

    move-result-object v3

    invoke-direct {v2, v3, v0}, Ljavax/mail/MessagingException;-><init>(Ljava/lang/String;Ljava/lang/Exception;)V

    throw v2
    :try_end_5
    .catchall {:try_start_5 .. :try_end_5} :catchall_0
.end method

.method public declared-synchronized setUsername(Ljava/lang/String;)V
    .locals 1

    .prologue
    .line 654
    monitor-enter p0

    :try_start_0
    iput-object p1, p0, Lcom/sun/mail/imap/IMAPStore;->user:Ljava/lang/String;
    :try_end_0
    .catchall {:try_start_0 .. :try_end_0} :catchall_0

    .line 655
    monitor-exit p0

    return-void

    .line 654
    :catchall_0
    move-exception v0

    monitor-exit p0

    throw v0
.end method
