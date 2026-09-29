.class public abstract Ljavax/mail/Service;
.super Ljava/lang/Object;
.source "SourceFile"


# annotations
.annotation system Ldalvik/annotation/MemberClasses;
    value = {
        Ljavax/mail/Service$TerminatorEvent;
    }
.end annotation


# instance fields
.field private connected:Z

.field private connectionListeners:Ljava/util/Vector;

.field protected debug:Z

.field private q:Ljavax/mail/EventQueue;

.field private qLock:Ljava/lang/Object;

.field protected session:Ljavax/mail/Session;

.field protected url:Ljavax/mail/URLName;


# direct methods
.method protected constructor <init>(Ljavax/mail/Session;Ljavax/mail/URLName;)V
    .locals 2

    .prologue
    const/4 v1, 0x0

    const/4 v0, 0x0

    .line 89
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    .line 72
    iput-object v1, p0, Ljavax/mail/Service;->url:Ljavax/mail/URLName;

    .line 78
    iput-boolean v0, p0, Ljavax/mail/Service;->debug:Z

    .line 80
    iput-boolean v0, p0, Ljavax/mail/Service;->connected:Z

    .line 81
    iput-object v1, p0, Ljavax/mail/Service;->connectionListeners:Ljava/util/Vector;

    .line 555
    new-instance v0, Ljava/lang/Object;

    invoke-direct {v0}, Ljava/lang/Object;-><init>()V

    iput-object v0, p0, Ljavax/mail/Service;->qLock:Ljava/lang/Object;

    .line 90
    iput-object p1, p0, Ljavax/mail/Service;->session:Ljavax/mail/Session;

    .line 91
    iput-object p2, p0, Ljavax/mail/Service;->url:Ljavax/mail/URLName;

    .line 92
    invoke-virtual {p1}, Ljavax/mail/Session;->getDebug()Z

    move-result v0

    iput-boolean v0, p0, Ljavax/mail/Service;->debug:Z

    .line 93
    return-void
.end method

.method private terminateQueue()V
    .locals 4

    .prologue
    .line 594
    iget-object v1, p0, Ljavax/mail/Service;->qLock:Ljava/lang/Object;

    monitor-enter v1

    .line 595
    :try_start_0
    iget-object v0, p0, Ljavax/mail/Service;->q:Ljavax/mail/EventQueue;

    if-eqz v0, :cond_0

    .line 596
    new-instance v0, Ljava/util/Vector;

    invoke-direct {v0}, Ljava/util/Vector;-><init>()V

    .line 597
    const/4 v2, 0x1

    invoke-virtual {v0, v2}, Ljava/util/Vector;->setSize(I)V

    .line 598
    iget-object v2, p0, Ljavax/mail/Service;->q:Ljavax/mail/EventQueue;

    new-instance v3, Ljavax/mail/Service$TerminatorEvent;

    invoke-direct {v3}, Ljavax/mail/Service$TerminatorEvent;-><init>()V

    invoke-virtual {v2, v3, v0}, Ljavax/mail/EventQueue;->enqueue(Ljavax/mail/event/MailEvent;Ljava/util/Vector;)V

    .line 599
    const/4 v0, 0x0

    iput-object v0, p0, Ljavax/mail/Service;->q:Ljavax/mail/EventQueue;

    .line 594
    :cond_0
    monitor-exit v1

    .line 602
    return-void

    .line 594
    :catchall_0
    move-exception v0

    monitor-exit v1
    :try_end_0
    .catchall {:try_start_0 .. :try_end_0} :catchall_0

    throw v0
.end method


# virtual methods
.method public declared-synchronized addConnectionListener(Ljavax/mail/event/ConnectionListener;)V
    .locals 1

    .prologue
    .line 483
    monitor-enter p0

    :try_start_0
    iget-object v0, p0, Ljavax/mail/Service;->connectionListeners:Ljava/util/Vector;

    if-nez v0, :cond_0

    .line 484
    new-instance v0, Ljava/util/Vector;

    invoke-direct {v0}, Ljava/util/Vector;-><init>()V

    iput-object v0, p0, Ljavax/mail/Service;->connectionListeners:Ljava/util/Vector;

    .line 485
    :cond_0
    iget-object v0, p0, Ljavax/mail/Service;->connectionListeners:Ljava/util/Vector;

    invoke-virtual {v0, p1}, Ljava/util/Vector;->addElement(Ljava/lang/Object;)V
    :try_end_0
    .catchall {:try_start_0 .. :try_end_0} :catchall_0

    .line 486
    monitor-exit p0

    return-void

    .line 483
    :catchall_0
    move-exception v0

    monitor-exit p0

    throw v0
.end method

.method public declared-synchronized close()V
    .locals 1
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljavax/mail/MessagingException;
        }
    .end annotation

    .prologue
    .line 425
    monitor-enter p0

    const/4 v0, 0x0

    :try_start_0
    invoke-virtual {p0, v0}, Ljavax/mail/Service;->setConnected(Z)V

    .line 426
    const/4 v0, 0x3

    invoke-virtual {p0, v0}, Ljavax/mail/Service;->notifyConnectionListeners(I)V
    :try_end_0
    .catchall {:try_start_0 .. :try_end_0} :catchall_0

    .line 427
    monitor-exit p0

    return-void

    .line 425
    :catchall_0
    move-exception v0

    monitor-exit p0

    throw v0
.end method

.method public connect()V
    .locals 1
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljavax/mail/MessagingException;
        }
    .end annotation

    .prologue
    const/4 v0, 0x0

    .line 118
    invoke-virtual {p0, v0, v0, v0}, Ljavax/mail/Service;->connect(Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;)V

    .line 119
    return-void
.end method

.method public declared-synchronized connect(Ljava/lang/String;ILjava/lang/String;Ljava/lang/String;)V
    .locals 15
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljavax/mail/MessagingException;
        }
    .end annotation

    .prologue
    .line 210
    monitor-enter p0

    :try_start_0
    invoke-virtual {p0}, Ljavax/mail/Service;->isConnected()Z

    move-result v1

    if-eqz v1, :cond_0

    .line 211
    new-instance v1, Ljava/lang/IllegalStateException;

    const-string v2, "already connected"

    invoke-direct {v1, v2}, Ljava/lang/IllegalStateException;-><init>(Ljava/lang/String;)V

    throw v1
    :try_end_0
    .catchall {:try_start_0 .. :try_end_0} :catchall_0

    .line 210
    :catchall_0
    move-exception v1

    monitor-exit p0

    throw v1

    .line 214
    :cond_0
    const/4 v13, 0x0

    .line 215
    const/4 v8, 0x0

    .line 216
    const/4 v2, 0x0

    .line 217
    const/4 v5, 0x0

    .line 222
    :try_start_1
    iget-object v1, p0, Ljavax/mail/Service;->url:Ljavax/mail/URLName;

    if-eqz v1, :cond_11

    .line 223
    iget-object v1, p0, Ljavax/mail/Service;->url:Ljavax/mail/URLName;

    invoke-virtual {v1}, Ljavax/mail/URLName;->getProtocol()Ljava/lang/String;

    move-result-object v2

    .line 224
    if-nez p1, :cond_10

    .line 225
    iget-object v1, p0, Ljavax/mail/Service;->url:Ljavax/mail/URLName;

    invoke-virtual {v1}, Ljavax/mail/URLName;->getHost()Ljava/lang/String;

    move-result-object v3

    .line 226
    :goto_0
    const/4 v1, -0x1

    move/from16 v0, p2

    if-ne v0, v1, :cond_f

    .line 227
    iget-object v1, p0, Ljavax/mail/Service;->url:Ljavax/mail/URLName;

    invoke-virtual {v1}, Ljavax/mail/URLName;->getPort()I

    move-result v4

    .line 229
    :goto_1
    if-nez p3, :cond_6

    .line 230
    iget-object v1, p0, Ljavax/mail/Service;->url:Ljavax/mail/URLName;

    invoke-virtual {v1}, Ljavax/mail/URLName;->getUsername()Ljava/lang/String;

    move-result-object p3

    .line 231
    if-nez p4, :cond_e

    .line 232
    iget-object v1, p0, Ljavax/mail/Service;->url:Ljavax/mail/URLName;

    invoke-virtual {v1}, Ljavax/mail/URLName;->getPassword()Ljava/lang/String;

    move-result-object p4

    move-object/from16 v9, p4

    move-object/from16 v6, p3

    .line 239
    :goto_2
    iget-object v1, p0, Ljavax/mail/Service;->url:Ljavax/mail/URLName;

    invoke-virtual {v1}, Ljavax/mail/URLName;->getFile()Ljava/lang/String;

    move-result-object v5

    .line 243
    :goto_3
    if-eqz v2, :cond_2

    .line 244
    if-nez v3, :cond_1

    .line 245
    iget-object v1, p0, Ljavax/mail/Service;->session:Ljavax/mail/Session;

    new-instance v3, Ljava/lang/StringBuilder;

    const-string v7, "mail."

    invoke-direct {v3, v7}, Ljava/lang/StringBuilder;-><init>(Ljava/lang/String;)V

    invoke-virtual {v3, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v3

    const-string v7, ".host"

    invoke-virtual {v3, v7}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v3

    invoke-virtual {v3}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v3

    invoke-virtual {v1, v3}, Ljavax/mail/Session;->getProperty(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v3

    .line 246
    :cond_1
    if-nez v6, :cond_2

    .line 247
    iget-object v1, p0, Ljavax/mail/Service;->session:Ljavax/mail/Session;

    new-instance v6, Ljava/lang/StringBuilder;

    const-string v7, "mail."

    invoke-direct {v6, v7}, Ljava/lang/StringBuilder;-><init>(Ljava/lang/String;)V

    invoke-virtual {v6, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v6

    const-string v7, ".user"

    invoke-virtual {v6, v7}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v6

    invoke-virtual {v6}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v6

    invoke-virtual {v1, v6}, Ljavax/mail/Session;->getProperty(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v6

    .line 251
    :cond_2
    if-nez v3, :cond_3

    .line 252
    iget-object v1, p0, Ljavax/mail/Service;->session:Ljavax/mail/Session;

    const-string v3, "mail.host"

    invoke-virtual {v1, v3}, Ljavax/mail/Session;->getProperty(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v3

    .line 254
    :cond_3
    if-nez v6, :cond_4

    .line 255
    iget-object v1, p0, Ljavax/mail/Service;->session:Ljavax/mail/Session;

    const-string v6, "mail.user"

    invoke-virtual {v1, v6}, Ljavax/mail/Session;->getProperty(Ljava/lang/String;)Ljava/lang/String;
    :try_end_1
    .catchall {:try_start_1 .. :try_end_1} :catchall_0

    move-result-object v6

    .line 258
    :cond_4
    if-nez v6, :cond_5

    .line 260
    :try_start_2
    const-string v1, "user.name"

    invoke-static {v1}, Ljava/lang/System;->getProperty(Ljava/lang/String;)Ljava/lang/String;
    :try_end_2
    .catch Ljava/lang/SecurityException; {:try_start_2 .. :try_end_2} :catch_0
    .catchall {:try_start_2 .. :try_end_2} :catchall_0

    move-result-object v6

    .line 268
    :cond_5
    :goto_4
    if-nez v9, :cond_d

    :try_start_3
    iget-object v1, p0, Ljavax/mail/Service;->url:Ljavax/mail/URLName;

    if-eqz v1, :cond_d

    .line 270
    new-instance v1, Ljavax/mail/URLName;

    const/4 v7, 0x0

    invoke-direct/range {v1 .. v7}, Ljavax/mail/URLName;-><init>(Ljava/lang/String;Ljava/lang/String;ILjava/lang/String;Ljava/lang/String;Ljava/lang/String;)V

    invoke-virtual {p0, v1}, Ljavax/mail/Service;->setURLName(Ljavax/mail/URLName;)V

    .line 271
    iget-object v1, p0, Ljavax/mail/Service;->session:Ljavax/mail/Session;

    invoke-virtual {p0}, Ljavax/mail/Service;->getURLName()Ljavax/mail/URLName;

    move-result-object v7

    invoke-virtual {v1, v7}, Ljavax/mail/Session;->getPasswordAuthentication(Ljavax/mail/URLName;)Ljavax/mail/PasswordAuthentication;

    move-result-object v1

    .line 272
    if-eqz v1, :cond_8

    .line 273
    if-nez v6, :cond_7

    .line 274
    invoke-virtual {v1}, Ljavax/mail/PasswordAuthentication;->getUserName()Ljava/lang/String;

    move-result-object v6

    .line 275
    invoke-virtual {v1}, Ljavax/mail/PasswordAuthentication;->getPassword()Ljava/lang/String;
    :try_end_3
    .catchall {:try_start_3 .. :try_end_3} :catchall_0

    move-result-object v1

    move v12, v8

    move-object v11, v6

    .line 286
    :goto_5
    const/4 v6, 0x0

    .line 288
    :try_start_4
    invoke-virtual {p0, v3, v4, v11, v1}, Ljavax/mail/Service;->protocolConnect(Ljava/lang/String;ILjava/lang/String;Ljava/lang/String;)Z
    :try_end_4
    .catch Ljavax/mail/AuthenticationFailedException; {:try_start_4 .. :try_end_4} :catch_1
    .catchall {:try_start_4 .. :try_end_4} :catchall_0

    move-result v13

    move-object v14, v6

    .line 294
    :goto_6
    if-nez v13, :cond_c

    .line 297
    :try_start_5
    invoke-static {v3}, Ljava/net/InetAddress;->getByName(Ljava/lang/String;)Ljava/net/InetAddress;
    :try_end_5
    .catch Ljava/net/UnknownHostException; {:try_start_5 .. :try_end_5} :catch_2
    .catchall {:try_start_5 .. :try_end_5} :catchall_0

    move-result-object v7

    .line 301
    :goto_7
    :try_start_6
    iget-object v6, p0, Ljavax/mail/Service;->session:Ljavax/mail/Session;

    .line 304
    const/4 v10, 0x0

    move v8, v4

    move-object v9, v2

    .line 301
    invoke-virtual/range {v6 .. v11}, Ljavax/mail/Session;->requestPasswordAuthentication(Ljava/net/InetAddress;ILjava/lang/String;Ljava/lang/String;Ljava/lang/String;)Ljavax/mail/PasswordAuthentication;

    move-result-object v6

    .line 305
    if-eqz v6, :cond_c

    .line 306
    invoke-virtual {v6}, Ljavax/mail/PasswordAuthentication;->getUserName()Ljava/lang/String;

    move-result-object v11

    .line 307
    invoke-virtual {v6}, Ljavax/mail/PasswordAuthentication;->getPassword()Ljava/lang/String;

    move-result-object v7

    .line 310
    invoke-virtual {p0, v3, v4, v11, v7}, Ljavax/mail/Service;->protocolConnect(Ljava/lang/String;ILjava/lang/String;Ljava/lang/String;)Z

    move-result v1

    move-object v6, v11

    .line 315
    :goto_8
    if-nez v1, :cond_a

    .line 316
    if-eqz v14, :cond_9

    .line 317
    throw v14

    .line 234
    :cond_6
    if-nez p4, :cond_e

    iget-object v1, p0, Ljavax/mail/Service;->url:Ljavax/mail/URLName;

    invoke-virtual {v1}, Ljavax/mail/URLName;->getUsername()Ljava/lang/String;

    move-result-object v1

    move-object/from16 v0, p3

    invoke-virtual {v0, v1}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v1

    if-eqz v1, :cond_e

    .line 236
    iget-object v1, p0, Ljavax/mail/Service;->url:Ljavax/mail/URLName;

    invoke-virtual {v1}, Ljavax/mail/URLName;->getPassword()Ljava/lang/String;

    move-result-object p4

    move-object/from16 v9, p4

    move-object/from16 v6, p3

    goto/16 :goto_2

    .line 261
    :catch_0
    move-exception v1

    .line 262
    iget-boolean v7, p0, Ljavax/mail/Service;->debug:Z

    if-eqz v7, :cond_5

    .line 263
    iget-object v7, p0, Ljavax/mail/Service;->session:Ljavax/mail/Session;

    invoke-virtual {v7}, Ljavax/mail/Session;->getDebugOut()Ljava/io/PrintStream;

    move-result-object v7

    invoke-virtual {v1, v7}, Ljava/lang/SecurityException;->printStackTrace(Ljava/io/PrintStream;)V

    goto :goto_4

    .line 276
    :cond_7
    invoke-virtual {v1}, Ljavax/mail/PasswordAuthentication;->getUserName()Ljava/lang/String;

    move-result-object v7

    invoke-virtual {v6, v7}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v7

    if-eqz v7, :cond_d

    .line 277
    invoke-virtual {v1}, Ljavax/mail/PasswordAuthentication;->getPassword()Ljava/lang/String;

    move-result-object v1

    move v12, v8

    move-object v11, v6

    goto :goto_5

    .line 280
    :cond_8
    const/4 v1, 0x1

    move v12, v1

    move-object v11, v6

    move-object v1, v9

    goto :goto_5

    .line 289
    :catch_1
    move-exception v6

    move-object v14, v6

    .line 290
    goto :goto_6

    .line 298
    :catch_2
    move-exception v6

    .line 299
    const/4 v7, 0x0

    goto :goto_7

    .line 319
    :cond_9
    new-instance v1, Ljavax/mail/AuthenticationFailedException;

    invoke-direct {v1}, Ljavax/mail/AuthenticationFailedException;-><init>()V

    throw v1

    .line 322
    :cond_a
    new-instance v1, Ljavax/mail/URLName;

    invoke-direct/range {v1 .. v7}, Ljavax/mail/URLName;-><init>(Ljava/lang/String;Ljava/lang/String;ILjava/lang/String;Ljava/lang/String;Ljava/lang/String;)V

    invoke-virtual {p0, v1}, Ljavax/mail/Service;->setURLName(Ljavax/mail/URLName;)V

    .line 324
    if-eqz v12, :cond_b

    .line 325
    iget-object v1, p0, Ljavax/mail/Service;->session:Ljavax/mail/Session;

    invoke-virtual {p0}, Ljavax/mail/Service;->getURLName()Ljavax/mail/URLName;

    move-result-object v2

    .line 326
    new-instance v3, Ljavax/mail/PasswordAuthentication;

    invoke-direct {v3, v6, v7}, Ljavax/mail/PasswordAuthentication;-><init>(Ljava/lang/String;Ljava/lang/String;)V

    .line 325
    invoke-virtual {v1, v2, v3}, Ljavax/mail/Session;->setPasswordAuthentication(Ljavax/mail/URLName;Ljavax/mail/PasswordAuthentication;)V

    .line 329
    :cond_b
    const/4 v1, 0x1

    invoke-virtual {p0, v1}, Ljavax/mail/Service;->setConnected(Z)V

    .line 332
    const/4 v1, 0x1

    invoke-virtual {p0, v1}, Ljavax/mail/Service;->notifyConnectionListeners(I)V
    :try_end_6
    .catchall {:try_start_6 .. :try_end_6} :catchall_0

    .line 333
    monitor-exit p0

    return-void

    :cond_c
    move-object v7, v1

    move-object v6, v11

    move v1, v13

    goto :goto_8

    :cond_d
    move v12, v8

    move-object v1, v9

    move-object v11, v6

    goto/16 :goto_5

    :cond_e
    move-object/from16 v9, p4

    move-object/from16 v6, p3

    goto/16 :goto_2

    :cond_f
    move/from16 v4, p2

    goto/16 :goto_1

    :cond_10
    move-object/from16 v3, p1

    goto/16 :goto_0

    :cond_11
    move-object/from16 v9, p4

    move-object/from16 v6, p3

    move/from16 v4, p2

    move-object/from16 v3, p1

    goto/16 :goto_3
.end method

.method public connect(Ljava/lang/String;Ljava/lang/String;)V
    .locals 1
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljavax/mail/MessagingException;
        }
    .end annotation

    .prologue
    .line 189
    const/4 v0, 0x0

    invoke-virtual {p0, v0, p1, p2}, Ljavax/mail/Service;->connect(Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;)V

    .line 190
    return-void
.end method

.method public connect(Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;)V
    .locals 1
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljavax/mail/MessagingException;
        }
    .end annotation

    .prologue
    .line 169
    const/4 v0, -0x1

    invoke-virtual {p0, p1, v0, p2, p3}, Ljavax/mail/Service;->connect(Ljava/lang/String;ILjava/lang/String;Ljava/lang/String;)V

    .line 170
    return-void
.end method

.method protected finalize()V
    .locals 0
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljava/lang/Throwable;
        }
    .end annotation

    .prologue
    .line 608
    invoke-super {p0}, Ljava/lang/Object;->finalize()V

    .line 609
    invoke-direct {p0}, Ljavax/mail/Service;->terminateQueue()V

    .line 610
    return-void
.end method

.method public declared-synchronized getURLName()Ljavax/mail/URLName;
    .locals 7

    .prologue
    .line 444
    monitor-enter p0

    :try_start_0
    iget-object v0, p0, Ljavax/mail/Service;->url:Ljavax/mail/URLName;

    if-eqz v0, :cond_1

    iget-object v0, p0, Ljavax/mail/Service;->url:Ljavax/mail/URLName;

    invoke-virtual {v0}, Ljavax/mail/URLName;->getPassword()Ljava/lang/String;

    move-result-object v0

    if-nez v0, :cond_0

    iget-object v0, p0, Ljavax/mail/Service;->url:Ljavax/mail/URLName;

    invoke-virtual {v0}, Ljavax/mail/URLName;->getFile()Ljava/lang/String;

    move-result-object v0

    if-eqz v0, :cond_1

    .line 445
    :cond_0
    new-instance v0, Ljavax/mail/URLName;

    iget-object v1, p0, Ljavax/mail/Service;->url:Ljavax/mail/URLName;

    invoke-virtual {v1}, Ljavax/mail/URLName;->getProtocol()Ljava/lang/String;

    move-result-object v1

    iget-object v2, p0, Ljavax/mail/Service;->url:Ljavax/mail/URLName;

    invoke-virtual {v2}, Ljavax/mail/URLName;->getHost()Ljava/lang/String;

    move-result-object v2

    .line 446
    iget-object v3, p0, Ljavax/mail/Service;->url:Ljavax/mail/URLName;

    invoke-virtual {v3}, Ljavax/mail/URLName;->getPort()I

    move-result v3

    const/4 v4, 0x0

    .line 447
    iget-object v5, p0, Ljavax/mail/Service;->url:Ljavax/mail/URLName;

    invoke-virtual {v5}, Ljavax/mail/URLName;->getUsername()Ljava/lang/String;

    move-result-object v5

    const/4 v6, 0x0

    .line 445
    invoke-direct/range {v0 .. v6}, Ljavax/mail/URLName;-><init>(Ljava/lang/String;Ljava/lang/String;ILjava/lang/String;Ljava/lang/String;Ljava/lang/String;)V
    :try_end_0
    .catchall {:try_start_0 .. :try_end_0} :catchall_0

    .line 449
    :goto_0
    monitor-exit p0

    return-object v0

    :cond_1
    :try_start_1
    iget-object v0, p0, Ljavax/mail/Service;->url:Ljavax/mail/URLName;
    :try_end_1
    .catchall {:try_start_1 .. :try_end_1} :catchall_0

    goto :goto_0

    .line 444
    :catchall_0
    move-exception v0

    monitor-exit p0

    throw v0
.end method

.method public declared-synchronized isConnected()Z
    .locals 1

    .prologue
    .line 385
    monitor-enter p0

    :try_start_0
    iget-boolean v0, p0, Ljavax/mail/Service;->connected:Z
    :try_end_0
    .catchall {:try_start_0 .. :try_end_0} :catchall_0

    monitor-exit p0

    return v0

    :catchall_0
    move-exception v0

    monitor-exit p0

    throw v0
.end method

.method protected declared-synchronized notifyConnectionListeners(I)V
    .locals 2

    .prologue
    .line 513
    monitor-enter p0

    :try_start_0
    iget-object v0, p0, Ljavax/mail/Service;->connectionListeners:Ljava/util/Vector;

    if-eqz v0, :cond_0

    .line 514
    new-instance v0, Ljavax/mail/event/ConnectionEvent;

    invoke-direct {v0, p0, p1}, Ljavax/mail/event/ConnectionEvent;-><init>(Ljava/lang/Object;I)V

    .line 515
    iget-object v1, p0, Ljavax/mail/Service;->connectionListeners:Ljava/util/Vector;

    invoke-virtual {p0, v0, v1}, Ljavax/mail/Service;->queueEvent(Ljavax/mail/event/MailEvent;Ljava/util/Vector;)V

    .line 528
    :cond_0
    const/4 v0, 0x3

    if-ne p1, v0, :cond_1

    .line 529
    invoke-direct {p0}, Ljavax/mail/Service;->terminateQueue()V
    :try_end_0
    .catchall {:try_start_0 .. :try_end_0} :catchall_0

    .line 530
    :cond_1
    monitor-exit p0

    return-void

    .line 513
    :catchall_0
    move-exception v0

    monitor-exit p0

    throw v0
.end method

.method protected protocolConnect(Ljava/lang/String;ILjava/lang/String;Ljava/lang/String;)Z
    .locals 1
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljavax/mail/MessagingException;
        }
    .end annotation

    .prologue
    .line 369
    const/4 v0, 0x0

    return v0
.end method

.method protected queueEvent(Ljavax/mail/event/MailEvent;Ljava/util/Vector;)V
    .locals 2

    .prologue
    .line 562
    iget-object v1, p0, Ljavax/mail/Service;->qLock:Ljava/lang/Object;

    monitor-enter v1

    .line 563
    :try_start_0
    iget-object v0, p0, Ljavax/mail/Service;->q:Ljavax/mail/EventQueue;

    if-nez v0, :cond_0

    .line 564
    new-instance v0, Ljavax/mail/EventQueue;

    invoke-direct {v0}, Ljavax/mail/EventQueue;-><init>()V

    iput-object v0, p0, Ljavax/mail/Service;->q:Ljavax/mail/EventQueue;

    .line 562
    :cond_0
    monitor-exit v1
    :try_end_0
    .catchall {:try_start_0 .. :try_end_0} :catchall_0

    .line 575
    invoke-virtual {p2}, Ljava/util/Vector;->clone()Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Ljava/util/Vector;

    .line 576
    iget-object v1, p0, Ljavax/mail/Service;->q:Ljavax/mail/EventQueue;

    invoke-virtual {v1, p1, v0}, Ljavax/mail/EventQueue;->enqueue(Ljavax/mail/event/MailEvent;Ljava/util/Vector;)V

    .line 577
    return-void

    .line 562
    :catchall_0
    move-exception v0

    :try_start_1
    monitor-exit v1
    :try_end_1
    .catchall {:try_start_1 .. :try_end_1} :catchall_0

    throw v0
.end method

.method public declared-synchronized removeConnectionListener(Ljavax/mail/event/ConnectionListener;)V
    .locals 1

    .prologue
    .line 498
    monitor-enter p0

    :try_start_0
    iget-object v0, p0, Ljavax/mail/Service;->connectionListeners:Ljava/util/Vector;

    if-eqz v0, :cond_0

    .line 499
    iget-object v0, p0, Ljavax/mail/Service;->connectionListeners:Ljava/util/Vector;

    invoke-virtual {v0, p1}, Ljava/util/Vector;->removeElement(Ljava/lang/Object;)Z
    :try_end_0
    .catchall {:try_start_0 .. :try_end_0} :catchall_0

    .line 500
    :cond_0
    monitor-exit p0

    return-void

    .line 498
    :catchall_0
    move-exception v0

    monitor-exit p0

    throw v0
.end method

.method protected declared-synchronized setConnected(Z)V
    .locals 1

    .prologue
    .line 402
    monitor-enter p0

    :try_start_0
    iput-boolean p1, p0, Ljavax/mail/Service;->connected:Z
    :try_end_0
    .catchall {:try_start_0 .. :try_end_0} :catchall_0

    .line 403
    monitor-exit p0

    return-void

    .line 402
    :catchall_0
    move-exception v0

    monitor-exit p0

    throw v0
.end method

.method protected declared-synchronized setURLName(Ljavax/mail/URLName;)V
    .locals 1

    .prologue
    .line 470
    monitor-enter p0

    :try_start_0
    iput-object p1, p0, Ljavax/mail/Service;->url:Ljavax/mail/URLName;
    :try_end_0
    .catchall {:try_start_0 .. :try_end_0} :catchall_0

    .line 471
    monitor-exit p0

    return-void

    .line 470
    :catchall_0
    move-exception v0

    monitor-exit p0

    throw v0
.end method

.method public toString()Ljava/lang/String;
    .locals 1

    .prologue
    .line 537
    invoke-virtual {p0}, Ljavax/mail/Service;->getURLName()Ljavax/mail/URLName;

    move-result-object v0

    .line 538
    if-eqz v0, :cond_0

    .line 539
    invoke-virtual {v0}, Ljavax/mail/URLName;->toString()Ljava/lang/String;

    move-result-object v0

    .line 541
    :goto_0
    return-object v0

    :cond_0
    invoke-super {p0}, Ljava/lang/Object;->toString()Ljava/lang/String;

    move-result-object v0

    goto :goto_0
.end method
