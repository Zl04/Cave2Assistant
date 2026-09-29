.class public Lcom/sun/mail/pop3/POP3Folder;
.super Ljavax/mail/Folder;
.source "SourceFile"


# instance fields
.field private doneUidl:Z

.field private exists:Z

.field private message_cache:Ljava/util/Vector;

.field private name:Ljava/lang/String;

.field private opened:Z

.field private port:Lcom/sun/mail/pop3/Protocol;

.field private size:I

.field private total:I


# direct methods
.method constructor <init>(Lcom/sun/mail/pop3/POP3Store;Ljava/lang/String;)V
    .locals 1

    .prologue
    const/4 v0, 0x0

    .line 78
    invoke-direct {p0, p1}, Ljavax/mail/Folder;-><init>(Ljavax/mail/Store;)V

    .line 72
    iput-boolean v0, p0, Lcom/sun/mail/pop3/POP3Folder;->exists:Z

    .line 73
    iput-boolean v0, p0, Lcom/sun/mail/pop3/POP3Folder;->opened:Z

    .line 75
    iput-boolean v0, p0, Lcom/sun/mail/pop3/POP3Folder;->doneUidl:Z

    .line 79
    iput-object p2, p0, Lcom/sun/mail/pop3/POP3Folder;->name:Ljava/lang/String;

    .line 80
    const-string v0, "INBOX"

    invoke-virtual {p2, v0}, Ljava/lang/String;->equalsIgnoreCase(Ljava/lang/String;)Z

    move-result v0

    if-eqz v0, :cond_0

    .line 81
    const/4 v0, 0x1

    iput-boolean v0, p0, Lcom/sun/mail/pop3/POP3Folder;->exists:Z

    .line 82
    :cond_0
    return-void
.end method


# virtual methods
.method public appendMessages([Ljavax/mail/Message;)V
    .locals 2
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljavax/mail/MessagingException;
        }
    .end annotation

    .prologue
    .line 341
    new-instance v0, Ljavax/mail/MethodNotSupportedException;

    const-string v1, "Append not supported"

    invoke-direct {v0, v1}, Ljavax/mail/MethodNotSupportedException;-><init>(Ljava/lang/String;)V

    throw v0
.end method

.method checkClosed()V
    .locals 2
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljava/lang/IllegalStateException;
        }
    .end annotation

    .prologue
    .line 517
    iget-boolean v0, p0, Lcom/sun/mail/pop3/POP3Folder;->opened:Z

    if-eqz v0, :cond_0

    .line 518
    new-instance v0, Ljava/lang/IllegalStateException;

    const-string v1, "Folder is Open"

    invoke-direct {v0, v1}, Ljava/lang/IllegalStateException;-><init>(Ljava/lang/String;)V

    throw v0

    .line 519
    :cond_0
    return-void
.end method

.method checkOpen()V
    .locals 2
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljava/lang/IllegalStateException;
        }
    .end annotation

    .prologue
    .line 511
    iget-boolean v0, p0, Lcom/sun/mail/pop3/POP3Folder;->opened:Z

    if-nez v0, :cond_0

    .line 512
    new-instance v0, Ljava/lang/IllegalStateException;

    const-string v1, "Folder is not Open"

    invoke-direct {v0, v1}, Ljava/lang/IllegalStateException;-><init>(Ljava/lang/String;)V

    throw v0

    .line 513
    :cond_0
    return-void
.end method

.method checkReadable()V
    .locals 2
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljava/lang/IllegalStateException;
        }
    .end annotation

    .prologue
    .line 523
    iget-boolean v0, p0, Lcom/sun/mail/pop3/POP3Folder;->opened:Z

    if-eqz v0, :cond_0

    iget v0, p0, Lcom/sun/mail/pop3/POP3Folder;->mode:I

    const/4 v1, 0x1

    if-eq v0, v1, :cond_1

    iget v0, p0, Lcom/sun/mail/pop3/POP3Folder;->mode:I

    const/4 v1, 0x2

    if-eq v0, v1, :cond_1

    .line 524
    :cond_0
    new-instance v0, Ljava/lang/IllegalStateException;

    const-string v1, "Folder is not Readable"

    invoke-direct {v0, v1}, Ljava/lang/IllegalStateException;-><init>(Ljava/lang/String;)V

    throw v0

    .line 525
    :cond_1
    return-void
.end method

.method checkWritable()V
    .locals 2
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljava/lang/IllegalStateException;
        }
    .end annotation

    .prologue
    .line 529
    iget-boolean v0, p0, Lcom/sun/mail/pop3/POP3Folder;->opened:Z

    if-eqz v0, :cond_0

    iget v0, p0, Lcom/sun/mail/pop3/POP3Folder;->mode:I

    const/4 v1, 0x2

    if-eq v0, v1, :cond_1

    .line 530
    :cond_0
    new-instance v0, Ljava/lang/IllegalStateException;

    const-string v1, "Folder is not Writable"

    invoke-direct {v0, v1}, Ljava/lang/IllegalStateException;-><init>(Ljava/lang/String;)V

    throw v0

    .line 531
    :cond_1
    return-void
.end method

.method public declared-synchronized close(Z)V
    .locals 3
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljavax/mail/MessagingException;
        }
    .end annotation

    .prologue
    const/4 v1, 0x0

    .line 227
    monitor-enter p0

    :try_start_0
    invoke-virtual {p0}, Lcom/sun/mail/pop3/POP3Folder;->checkOpen()V
    :try_end_0
    .catchall {:try_start_0 .. :try_end_0} :catchall_0

    .line 239
    :try_start_1
    iget-object v0, p0, Lcom/sun/mail/pop3/POP3Folder;->store:Ljavax/mail/Store;

    check-cast v0, Lcom/sun/mail/pop3/POP3Store;

    iget-boolean v0, v0, Lcom/sun/mail/pop3/POP3Store;->rsetBeforeQuit:Z

    if-eqz v0, :cond_0

    .line 240
    iget-object v0, p0, Lcom/sun/mail/pop3/POP3Folder;->port:Lcom/sun/mail/pop3/Protocol;

    invoke-virtual {v0}, Lcom/sun/mail/pop3/Protocol;->rset()Z

    .line 241
    :cond_0
    if-eqz p1, :cond_1

    iget v0, p0, Lcom/sun/mail/pop3/POP3Folder;->mode:I

    const/4 v2, 0x2

    if-ne v0, v2, :cond_1

    .line 244
    :goto_0
    iget-object v0, p0, Lcom/sun/mail/pop3/POP3Folder;->message_cache:Ljava/util/Vector;

    invoke-virtual {v0}, Ljava/util/Vector;->size()I

    move-result v0

    if-lt v1, v0, :cond_2

    .line 258
    :cond_1
    iget-object v0, p0, Lcom/sun/mail/pop3/POP3Folder;->port:Lcom/sun/mail/pop3/Protocol;

    invoke-virtual {v0}, Lcom/sun/mail/pop3/Protocol;->quit()Z
    :try_end_1
    .catch Ljava/io/IOException; {:try_start_1 .. :try_end_1} :catch_1
    .catchall {:try_start_1 .. :try_end_1} :catchall_1

    .line 262
    const/4 v0, 0x0

    :try_start_2
    iput-object v0, p0, Lcom/sun/mail/pop3/POP3Folder;->port:Lcom/sun/mail/pop3/Protocol;

    .line 263
    iget-object v0, p0, Lcom/sun/mail/pop3/POP3Folder;->store:Ljavax/mail/Store;

    check-cast v0, Lcom/sun/mail/pop3/POP3Store;

    invoke-virtual {v0, p0}, Lcom/sun/mail/pop3/POP3Store;->closePort(Lcom/sun/mail/pop3/POP3Folder;)V

    .line 264
    const/4 v0, 0x0

    iput-object v0, p0, Lcom/sun/mail/pop3/POP3Folder;->message_cache:Ljava/util/Vector;

    .line 265
    const/4 v0, 0x0

    iput-boolean v0, p0, Lcom/sun/mail/pop3/POP3Folder;->opened:Z

    .line 266
    const/4 v0, 0x3

    invoke-virtual {p0, v0}, Lcom/sun/mail/pop3/POP3Folder;->notifyConnectionListeners(I)V
    :try_end_2
    .catchall {:try_start_2 .. :try_end_2} :catchall_0

    .line 268
    :goto_1
    monitor-exit p0

    return-void

    .line 245
    :cond_2
    :try_start_3
    iget-object v0, p0, Lcom/sun/mail/pop3/POP3Folder;->message_cache:Ljava/util/Vector;

    invoke-virtual {v0, v1}, Ljava/util/Vector;->elementAt(I)Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Lcom/sun/mail/pop3/POP3Message;

    if-eqz v0, :cond_3

    .line 246
    sget-object v2, Ljavax/mail/Flags$Flag;->DELETED:Ljavax/mail/Flags$Flag;

    invoke-virtual {v0, v2}, Lcom/sun/mail/pop3/POP3Message;->isSet(Ljavax/mail/Flags$Flag;)Z
    :try_end_3
    .catch Ljava/io/IOException; {:try_start_3 .. :try_end_3} :catch_1
    .catchall {:try_start_3 .. :try_end_3} :catchall_1

    move-result v0

    if-eqz v0, :cond_3

    .line 248
    :try_start_4
    iget-object v0, p0, Lcom/sun/mail/pop3/POP3Folder;->port:Lcom/sun/mail/pop3/Protocol;

    add-int/lit8 v2, v1, 0x1

    invoke-virtual {v0, v2}, Lcom/sun/mail/pop3/Protocol;->dele(I)Z
    :try_end_4
    .catch Ljava/io/IOException; {:try_start_4 .. :try_end_4} :catch_0
    .catchall {:try_start_4 .. :try_end_4} :catchall_1

    .line 244
    :cond_3
    add-int/lit8 v0, v1, 0x1

    move v1, v0

    goto :goto_0

    .line 249
    :catch_0
    move-exception v0

    .line 250
    :try_start_5
    new-instance v1, Ljavax/mail/MessagingException;

    .line 251
    const-string v2, "Exception deleting messages during close"

    .line 250
    invoke-direct {v1, v2, v0}, Ljavax/mail/MessagingException;-><init>(Ljava/lang/String;Ljava/lang/Exception;)V

    throw v1
    :try_end_5
    .catch Ljava/io/IOException; {:try_start_5 .. :try_end_5} :catch_1
    .catchall {:try_start_5 .. :try_end_5} :catchall_1

    .line 259
    :catch_1
    move-exception v0

    .line 262
    const/4 v0, 0x0

    :try_start_6
    iput-object v0, p0, Lcom/sun/mail/pop3/POP3Folder;->port:Lcom/sun/mail/pop3/Protocol;

    .line 263
    iget-object v0, p0, Lcom/sun/mail/pop3/POP3Folder;->store:Ljavax/mail/Store;

    check-cast v0, Lcom/sun/mail/pop3/POP3Store;

    invoke-virtual {v0, p0}, Lcom/sun/mail/pop3/POP3Store;->closePort(Lcom/sun/mail/pop3/POP3Folder;)V

    .line 264
    const/4 v0, 0x0

    iput-object v0, p0, Lcom/sun/mail/pop3/POP3Folder;->message_cache:Ljava/util/Vector;

    .line 265
    const/4 v0, 0x0

    iput-boolean v0, p0, Lcom/sun/mail/pop3/POP3Folder;->opened:Z

    .line 266
    const/4 v0, 0x3

    invoke-virtual {p0, v0}, Lcom/sun/mail/pop3/POP3Folder;->notifyConnectionListeners(I)V
    :try_end_6
    .catchall {:try_start_6 .. :try_end_6} :catchall_0

    goto :goto_1

    .line 227
    :catchall_0
    move-exception v0

    monitor-exit p0

    throw v0

    .line 261
    :catchall_1
    move-exception v0

    move-object v1, v0

    .line 262
    const/4 v0, 0x0

    :try_start_7
    iput-object v0, p0, Lcom/sun/mail/pop3/POP3Folder;->port:Lcom/sun/mail/pop3/Protocol;

    .line 263
    iget-object v0, p0, Lcom/sun/mail/pop3/POP3Folder;->store:Ljavax/mail/Store;

    check-cast v0, Lcom/sun/mail/pop3/POP3Store;

    invoke-virtual {v0, p0}, Lcom/sun/mail/pop3/POP3Store;->closePort(Lcom/sun/mail/pop3/POP3Folder;)V

    .line 264
    const/4 v0, 0x0

    iput-object v0, p0, Lcom/sun/mail/pop3/POP3Folder;->message_cache:Ljava/util/Vector;

    .line 265
    const/4 v0, 0x0

    iput-boolean v0, p0, Lcom/sun/mail/pop3/POP3Folder;->opened:Z

    .line 266
    const/4 v0, 0x3

    invoke-virtual {p0, v0}, Lcom/sun/mail/pop3/POP3Folder;->notifyConnectionListeners(I)V

    .line 267
    throw v1
    :try_end_7
    .catchall {:try_start_7 .. :try_end_7} :catchall_0
.end method

.method public create(I)Z
    .locals 1
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljavax/mail/MessagingException;
        }
    .end annotation

    .prologue
    .line 141
    const/4 v0, 0x0

    return v0
.end method

.method protected createMessage(Ljavax/mail/Folder;I)Lcom/sun/mail/pop3/POP3Message;
    .locals 5
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljavax/mail/MessagingException;
        }
    .end annotation

    .prologue
    .line 319
    const/4 v1, 0x0

    .line 320
    iget-object v0, p0, Lcom/sun/mail/pop3/POP3Folder;->store:Ljavax/mail/Store;

    check-cast v0, Lcom/sun/mail/pop3/POP3Store;

    iget-object v0, v0, Lcom/sun/mail/pop3/POP3Store;->messageConstructor:Ljava/lang/reflect/Constructor;

    .line 321
    if-eqz v0, :cond_1

    .line 323
    const/4 v2, 0x2

    :try_start_0
    new-array v2, v2, [Ljava/lang/Object;

    const/4 v3, 0x0

    aput-object p0, v2, v3

    const/4 v3, 0x1

    new-instance v4, Ljava/lang/Integer;

    invoke-direct {v4, p2}, Ljava/lang/Integer;-><init>(I)V

    aput-object v4, v2, v3

    .line 324
    invoke-virtual {v0, v2}, Ljava/lang/reflect/Constructor;->newInstance([Ljava/lang/Object;)Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Lcom/sun/mail/pop3/POP3Message;
    :try_end_0
    .catch Ljava/lang/Exception; {:try_start_0 .. :try_end_0} :catch_0

    .line 329
    :goto_0
    if-nez v0, :cond_0

    .line 330
    new-instance v0, Lcom/sun/mail/pop3/POP3Message;

    invoke-direct {v0, p0, p2}, Lcom/sun/mail/pop3/POP3Message;-><init>(Ljavax/mail/Folder;I)V

    .line 331
    :cond_0
    return-object v0

    .line 325
    :catch_0
    move-exception v0

    move-object v0, v1

    goto :goto_0

    :cond_1
    move-object v0, v1

    goto :goto_0
.end method

.method public delete(Z)Z
    .locals 2
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljavax/mail/MessagingException;
        }
    .end annotation

    .prologue
    .line 172
    new-instance v0, Ljavax/mail/MethodNotSupportedException;

    const-string v1, "delete"

    invoke-direct {v0, v1}, Ljavax/mail/MethodNotSupportedException;-><init>(Ljava/lang/String;)V

    throw v0
.end method

.method public exists()Z
    .locals 1

    .prologue
    .line 103
    iget-boolean v0, p0, Lcom/sun/mail/pop3/POP3Folder;->exists:Z

    return v0
.end method

.method public expunge()[Ljavax/mail/Message;
    .locals 2
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljavax/mail/MessagingException;
        }
    .end annotation

    .prologue
    .line 354
    new-instance v0, Ljavax/mail/MethodNotSupportedException;

    const-string v1, "Expunge not supported"

    invoke-direct {v0, v1}, Ljavax/mail/MethodNotSupportedException;-><init>(Ljava/lang/String;)V

    throw v0
.end method

.method public declared-synchronized fetch([Ljavax/mail/Message;Ljavax/mail/FetchProfile;)V
    .locals 5
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljavax/mail/MessagingException;
        }
    .end annotation

    .prologue
    const/4 v1, 0x0

    .line 368
    monitor-enter p0

    :try_start_0
    invoke-virtual {p0}, Lcom/sun/mail/pop3/POP3Folder;->checkReadable()V

    .line 369
    iget-boolean v0, p0, Lcom/sun/mail/pop3/POP3Folder;->doneUidl:Z

    if-nez v0, :cond_2

    sget-object v0, Ljavax/mail/UIDFolder$FetchProfileItem;->UID:Ljavax/mail/UIDFolder$FetchProfileItem;

    invoke-virtual {p2, v0}, Ljavax/mail/FetchProfile;->contains(Ljavax/mail/FetchProfile$Item;)Z

    move-result v0

    if-eqz v0, :cond_2

    .line 378
    iget-object v0, p0, Lcom/sun/mail/pop3/POP3Folder;->message_cache:Ljava/util/Vector;

    invoke-virtual {v0}, Ljava/util/Vector;->size()I

    move-result v0

    new-array v3, v0, [Ljava/lang/String;
    :try_end_0
    .catchall {:try_start_0 .. :try_end_0} :catchall_0

    .line 380
    :try_start_1
    iget-object v0, p0, Lcom/sun/mail/pop3/POP3Folder;->port:Lcom/sun/mail/pop3/Protocol;

    invoke-virtual {v0, v3}, Lcom/sun/mail/pop3/Protocol;->uidl([Ljava/lang/String;)Z
    :try_end_1
    .catch Ljava/io/EOFException; {:try_start_1 .. :try_end_1} :catch_0
    .catch Ljava/io/IOException; {:try_start_1 .. :try_end_1} :catch_1
    .catchall {:try_start_1 .. :try_end_1} :catchall_0

    move-result v0

    if-nez v0, :cond_1

    .line 409
    :cond_0
    monitor-exit p0

    return-void

    .line 382
    :catch_0
    move-exception v0

    .line 383
    const/4 v1, 0x0

    :try_start_2
    invoke-virtual {p0, v1}, Lcom/sun/mail/pop3/POP3Folder;->close(Z)V

    .line 384
    new-instance v1, Ljavax/mail/FolderClosedException;

    invoke-virtual {v0}, Ljava/io/EOFException;->toString()Ljava/lang/String;

    move-result-object v0

    invoke-direct {v1, p0, v0}, Ljavax/mail/FolderClosedException;-><init>(Ljavax/mail/Folder;Ljava/lang/String;)V

    throw v1
    :try_end_2
    .catchall {:try_start_2 .. :try_end_2} :catchall_0

    .line 368
    :catchall_0
    move-exception v0

    monitor-exit p0

    throw v0

    .line 385
    :catch_1
    move-exception v0

    .line 386
    :try_start_3
    new-instance v1, Ljavax/mail/MessagingException;

    const-string v2, "error getting UIDL"

    invoke-direct {v1, v2, v0}, Ljavax/mail/MessagingException;-><init>(Ljava/lang/String;Ljava/lang/Exception;)V

    throw v1

    :cond_1
    move v2, v1

    .line 388
    :goto_0
    array-length v0, v3

    if-lt v2, v0, :cond_3

    .line 394
    const/4 v0, 0x1

    iput-boolean v0, p0, Lcom/sun/mail/pop3/POP3Folder;->doneUidl:Z

    .line 396
    :cond_2
    sget-object v0, Ljavax/mail/FetchProfile$Item;->ENVELOPE:Ljavax/mail/FetchProfile$Item;

    invoke-virtual {p2, v0}, Ljavax/mail/FetchProfile;->contains(Ljavax/mail/FetchProfile$Item;)Z

    move-result v0

    if-eqz v0, :cond_0

    .line 397
    :goto_1
    array-length v0, p1
    :try_end_3
    .catchall {:try_start_3 .. :try_end_3} :catchall_0

    if-ge v1, v0, :cond_0

    .line 399
    :try_start_4
    aget-object v0, p1, v1

    check-cast v0, Lcom/sun/mail/pop3/POP3Message;

    .line 401
    const-string v2, ""

    invoke-virtual {v0, v2}, Lcom/sun/mail/pop3/POP3Message;->getHeader(Ljava/lang/String;)[Ljava/lang/String;

    .line 403
    invoke-virtual {v0}, Lcom/sun/mail/pop3/POP3Message;->getSize()I
    :try_end_4
    .catch Ljavax/mail/MessageRemovedException; {:try_start_4 .. :try_end_4} :catch_2
    .catchall {:try_start_4 .. :try_end_4} :catchall_0

    .line 397
    :goto_2
    add-int/lit8 v0, v1, 0x1

    move v1, v0

    goto :goto_1

    .line 389
    :cond_3
    :try_start_5
    aget-object v0, v3, v2

    if-nez v0, :cond_4

    .line 388
    :goto_3
    add-int/lit8 v0, v2, 0x1

    move v2, v0

    goto :goto_0

    .line 391
    :cond_4
    add-int/lit8 v0, v2, 0x1

    invoke-virtual {p0, v0}, Lcom/sun/mail/pop3/POP3Folder;->getMessage(I)Ljavax/mail/Message;

    move-result-object v0

    check-cast v0, Lcom/sun/mail/pop3/POP3Message;

    .line 392
    aget-object v4, v3, v2

    iput-object v4, v0, Lcom/sun/mail/pop3/POP3Message;->uid:Ljava/lang/String;
    :try_end_5
    .catchall {:try_start_5 .. :try_end_5} :catchall_0

    goto :goto_3

    .line 404
    :catch_2
    move-exception v0

    goto :goto_2
.end method

.method protected finalize()V
    .locals 1
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljava/lang/Throwable;
        }
    .end annotation

    .prologue
    .line 505
    invoke-super {p0}, Ljavax/mail/Folder;->finalize()V

    .line 506
    const/4 v0, 0x0

    invoke-virtual {p0, v0}, Lcom/sun/mail/pop3/POP3Folder;->close(Z)V

    .line 507
    return-void
.end method

.method public getFolder(Ljava/lang/String;)Ljavax/mail/Folder;
    .locals 2
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljavax/mail/MessagingException;
        }
    .end annotation

    .prologue
    .line 161
    new-instance v0, Ljavax/mail/MessagingException;

    const-string v1, "not a directory"

    invoke-direct {v0, v1}, Ljavax/mail/MessagingException;-><init>(Ljava/lang/String;)V

    throw v0
.end method

.method public getFullName()Ljava/lang/String;
    .locals 1

    .prologue
    .line 89
    iget-object v0, p0, Lcom/sun/mail/pop3/POP3Folder;->name:Ljava/lang/String;

    return-object v0
.end method

.method public declared-synchronized getMessage(I)Ljavax/mail/Message;
    .locals 3
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljavax/mail/MessagingException;
        }
    .end annotation

    .prologue
    .line 305
    monitor-enter p0

    :try_start_0
    invoke-virtual {p0}, Lcom/sun/mail/pop3/POP3Folder;->checkOpen()V

    .line 310
    iget-object v0, p0, Lcom/sun/mail/pop3/POP3Folder;->message_cache:Ljava/util/Vector;

    add-int/lit8 v1, p1, -0x1

    invoke-virtual {v0, v1}, Ljava/util/Vector;->elementAt(I)Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Lcom/sun/mail/pop3/POP3Message;

    if-nez v0, :cond_0

    .line 311
    invoke-virtual {p0, p0, p1}, Lcom/sun/mail/pop3/POP3Folder;->createMessage(Ljavax/mail/Folder;I)Lcom/sun/mail/pop3/POP3Message;

    move-result-object v0

    .line 312
    iget-object v1, p0, Lcom/sun/mail/pop3/POP3Folder;->message_cache:Ljava/util/Vector;

    add-int/lit8 v2, p1, -0x1

    invoke-virtual {v1, v0, v2}, Ljava/util/Vector;->setElementAt(Ljava/lang/Object;I)V
    :try_end_0
    .catchall {:try_start_0 .. :try_end_0} :catchall_0

    .line 314
    :cond_0
    monitor-exit p0

    return-object v0

    .line 305
    :catchall_0
    move-exception v0

    monitor-exit p0

    throw v0
.end method

.method public declared-synchronized getMessageCount()I
    .locals 1
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljavax/mail/MessagingException;
        }
    .end annotation

    .prologue
    .line 297
    monitor-enter p0

    :try_start_0
    iget-boolean v0, p0, Lcom/sun/mail/pop3/POP3Folder;->opened:Z
    :try_end_0
    .catchall {:try_start_0 .. :try_end_0} :catchall_0

    if-nez v0, :cond_0

    .line 298
    const/4 v0, -0x1

    .line 300
    :goto_0
    monitor-exit p0

    return v0

    .line 299
    :cond_0
    :try_start_1
    invoke-virtual {p0}, Lcom/sun/mail/pop3/POP3Folder;->checkReadable()V

    .line 300
    iget v0, p0, Lcom/sun/mail/pop3/POP3Folder;->total:I
    :try_end_1
    .catchall {:try_start_1 .. :try_end_1} :catchall_0

    goto :goto_0

    .line 297
    :catchall_0
    move-exception v0

    monitor-exit p0

    throw v0
.end method

.method public getName()Ljava/lang/String;
    .locals 1

    .prologue
    .line 85
    iget-object v0, p0, Lcom/sun/mail/pop3/POP3Folder;->name:Ljava/lang/String;

    return-object v0
.end method

.method public getParent()Ljavax/mail/Folder;
    .locals 2

    .prologue
    .line 93
    new-instance v1, Lcom/sun/mail/pop3/DefaultFolder;

    iget-object v0, p0, Lcom/sun/mail/pop3/POP3Folder;->store:Ljavax/mail/Store;

    check-cast v0, Lcom/sun/mail/pop3/POP3Store;

    invoke-direct {v1, v0}, Lcom/sun/mail/pop3/DefaultFolder;-><init>(Lcom/sun/mail/pop3/POP3Store;)V

    return-object v1
.end method

.method public getPermanentFlags()Ljavax/mail/Flags;
    .locals 1

    .prologue
    .line 288
    new-instance v0, Ljavax/mail/Flags;

    invoke-direct {v0}, Ljavax/mail/Flags;-><init>()V

    return-object v0
.end method

.method getProtocol()Lcom/sun/mail/pop3/Protocol;
    .locals 1
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljavax/mail/MessagingException;
        }
    .end annotation

    .prologue
    .line 539
    invoke-virtual {p0}, Lcom/sun/mail/pop3/POP3Folder;->checkOpen()V

    .line 540
    iget-object v0, p0, Lcom/sun/mail/pop3/POP3Folder;->port:Lcom/sun/mail/pop3/Protocol;

    return-object v0
.end method

.method public getSeparator()C
    .locals 1

    .prologue
    .line 122
    const/4 v0, 0x0

    return v0
.end method

.method public declared-synchronized getSize()I
    .locals 1
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljavax/mail/MessagingException;
        }
    .end annotation

    .prologue
    .line 441
    monitor-enter p0

    :try_start_0
    invoke-virtual {p0}, Lcom/sun/mail/pop3/POP3Folder;->checkOpen()V

    .line 442
    iget v0, p0, Lcom/sun/mail/pop3/POP3Folder;->size:I
    :try_end_0
    .catchall {:try_start_0 .. :try_end_0} :catchall_0

    monitor-exit p0

    return v0

    .line 441
    :catchall_0
    move-exception v0

    monitor-exit p0

    throw v0
.end method

.method public declared-synchronized getSizes()[I
    .locals 7
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljavax/mail/MessagingException;
        }
    .end annotation

    .prologue
    const/4 v1, 0x0

    .line 455
    monitor-enter p0

    :try_start_0
    invoke-virtual {p0}, Lcom/sun/mail/pop3/POP3Folder;->checkOpen()V

    .line 456
    iget v0, p0, Lcom/sun/mail/pop3/POP3Folder;->total:I

    new-array v3, v0, [I
    :try_end_0
    .catchall {:try_start_0 .. :try_end_0} :catchall_1

    .line 460
    :try_start_1
    iget-object v0, p0, Lcom/sun/mail/pop3/POP3Folder;->port:Lcom/sun/mail/pop3/Protocol;

    invoke-virtual {v0}, Lcom/sun/mail/pop3/Protocol;->list()Ljava/io/InputStream;
    :try_end_1
    .catch Ljava/io/IOException; {:try_start_1 .. :try_end_1} :catch_1
    .catchall {:try_start_1 .. :try_end_1} :catchall_0

    move-result-object v2

    .line 461
    :try_start_2
    new-instance v0, Lcom/sun/mail/util/LineInputStream;

    invoke-direct {v0, v2}, Lcom/sun/mail/util/LineInputStream;-><init>(Ljava/io/InputStream;)V
    :try_end_2
    .catch Ljava/io/IOException; {:try_start_2 .. :try_end_2} :catch_8
    .catchall {:try_start_2 .. :try_end_2} :catchall_2

    .line 463
    :cond_0
    :goto_0
    :try_start_3
    invoke-virtual {v0}, Lcom/sun/mail/util/LineInputStream;->readLine()Ljava/lang/String;
    :try_end_3
    .catch Ljava/io/IOException; {:try_start_3 .. :try_end_3} :catch_9
    .catchall {:try_start_3 .. :try_end_3} :catchall_3

    move-result-object v1

    if-nez v1, :cond_3

    .line 477
    if-eqz v0, :cond_1

    .line 478
    :try_start_4
    invoke-virtual {v0}, Lcom/sun/mail/util/LineInputStream;->close()V
    :try_end_4
    .catch Ljava/io/IOException; {:try_start_4 .. :try_end_4} :catch_6
    .catchall {:try_start_4 .. :try_end_4} :catchall_1

    .line 481
    :cond_1
    :goto_1
    if-eqz v2, :cond_2

    .line 482
    :try_start_5
    invoke-virtual {v2}, Ljava/io/InputStream;->close()V
    :try_end_5
    .catch Ljava/io/IOException; {:try_start_5 .. :try_end_5} :catch_7
    .catchall {:try_start_5 .. :try_end_5} :catchall_1

    .line 485
    :cond_2
    :goto_2
    monitor-exit p0

    return-object v3

    .line 465
    :cond_3
    :try_start_6
    new-instance v4, Ljava/util/StringTokenizer;

    invoke-direct {v4, v1}, Ljava/util/StringTokenizer;-><init>(Ljava/lang/String;)V

    .line 466
    invoke-virtual {v4}, Ljava/util/StringTokenizer;->nextToken()Ljava/lang/String;

    move-result-object v1

    invoke-static {v1}, Ljava/lang/Integer;->parseInt(Ljava/lang/String;)I

    move-result v1

    .line 467
    invoke-virtual {v4}, Ljava/util/StringTokenizer;->nextToken()Ljava/lang/String;

    move-result-object v4

    invoke-static {v4}, Ljava/lang/Integer;->parseInt(Ljava/lang/String;)I

    move-result v4

    .line 468
    if-lez v1, :cond_0

    iget v5, p0, Lcom/sun/mail/pop3/POP3Folder;->total:I

    if-gt v1, v5, :cond_0

    .line 469
    add-int/lit8 v1, v1, -0x1

    aput v4, v3, v1
    :try_end_6
    .catch Ljava/lang/Exception; {:try_start_6 .. :try_end_6} :catch_0
    .catch Ljava/io/IOException; {:try_start_6 .. :try_end_6} :catch_9
    .catchall {:try_start_6 .. :try_end_6} :catchall_3

    goto :goto_0

    .line 470
    :catch_0
    move-exception v1

    goto :goto_0

    .line 473
    :catch_1
    move-exception v0

    move-object v0, v1

    .line 477
    :goto_3
    if-eqz v0, :cond_4

    .line 478
    :try_start_7
    invoke-virtual {v0}, Lcom/sun/mail/util/LineInputStream;->close()V
    :try_end_7
    .catch Ljava/io/IOException; {:try_start_7 .. :try_end_7} :catch_3
    .catchall {:try_start_7 .. :try_end_7} :catchall_1

    .line 481
    :cond_4
    :goto_4
    if-eqz v1, :cond_2

    .line 482
    :try_start_8
    invoke-virtual {v1}, Ljava/io/InputStream;->close()V
    :try_end_8
    .catch Ljava/io/IOException; {:try_start_8 .. :try_end_8} :catch_2
    .catchall {:try_start_8 .. :try_end_8} :catchall_1

    goto :goto_2

    .line 483
    :catch_2
    move-exception v0

    goto :goto_2

    .line 475
    :catchall_0
    move-exception v0

    move-object v2, v1

    .line 477
    :goto_5
    if-eqz v1, :cond_5

    .line 478
    :try_start_9
    invoke-virtual {v1}, Lcom/sun/mail/util/LineInputStream;->close()V
    :try_end_9
    .catch Ljava/io/IOException; {:try_start_9 .. :try_end_9} :catch_4
    .catchall {:try_start_9 .. :try_end_9} :catchall_1

    .line 481
    :cond_5
    :goto_6
    if-eqz v2, :cond_6

    .line 482
    :try_start_a
    invoke-virtual {v2}, Ljava/io/InputStream;->close()V
    :try_end_a
    .catch Ljava/io/IOException; {:try_start_a .. :try_end_a} :catch_5
    .catchall {:try_start_a .. :try_end_a} :catchall_1

    .line 484
    :cond_6
    :goto_7
    :try_start_b
    throw v0
    :try_end_b
    .catchall {:try_start_b .. :try_end_b} :catchall_1

    .line 455
    :catchall_1
    move-exception v0

    monitor-exit p0

    throw v0

    .line 479
    :catch_3
    move-exception v0

    goto :goto_4

    :catch_4
    move-exception v1

    goto :goto_6

    .line 483
    :catch_5
    move-exception v1

    goto :goto_7

    .line 479
    :catch_6
    move-exception v0

    goto :goto_1

    .line 483
    :catch_7
    move-exception v0

    goto :goto_2

    .line 475
    :catchall_2
    move-exception v0

    goto :goto_5

    :catchall_3
    move-exception v1

    move-object v6, v1

    move-object v1, v0

    move-object v0, v6

    goto :goto_5

    .line 473
    :catch_8
    move-exception v0

    move-object v0, v1

    move-object v1, v2

    goto :goto_3

    :catch_9
    move-exception v1

    move-object v1, v2

    goto :goto_3
.end method

.method public getType()I
    .locals 1

    .prologue
    .line 131
    const/4 v0, 0x1

    return v0
.end method

.method public declared-synchronized getUID(Ljavax/mail/Message;)Ljava/lang/String;
    .locals 3
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljavax/mail/MessagingException;
        }
    .end annotation

    .prologue
    .line 419
    monitor-enter p0

    :try_start_0
    invoke-virtual {p0}, Lcom/sun/mail/pop3/POP3Folder;->checkOpen()V

    .line 420
    check-cast p1, Lcom/sun/mail/pop3/POP3Message;
    :try_end_0
    .catchall {:try_start_0 .. :try_end_0} :catchall_0

    .line 422
    :try_start_1
    iget-object v0, p1, Lcom/sun/mail/pop3/POP3Message;->uid:Ljava/lang/String;

    const-string v1, "UNKNOWN"

    if-ne v0, v1, :cond_0

    .line 423
    iget-object v0, p0, Lcom/sun/mail/pop3/POP3Folder;->port:Lcom/sun/mail/pop3/Protocol;

    invoke-virtual {p1}, Lcom/sun/mail/pop3/POP3Message;->getMessageNumber()I

    move-result v1

    invoke-virtual {v0, v1}, Lcom/sun/mail/pop3/Protocol;->uidl(I)Ljava/lang/String;

    move-result-object v0

    iput-object v0, p1, Lcom/sun/mail/pop3/POP3Message;->uid:Ljava/lang/String;

    .line 424
    :cond_0
    iget-object v0, p1, Lcom/sun/mail/pop3/POP3Message;->uid:Ljava/lang/String;
    :try_end_1
    .catch Ljava/io/EOFException; {:try_start_1 .. :try_end_1} :catch_0
    .catch Ljava/io/IOException; {:try_start_1 .. :try_end_1} :catch_1
    .catchall {:try_start_1 .. :try_end_1} :catchall_0

    monitor-exit p0

    return-object v0

    .line 425
    :catch_0
    move-exception v0

    .line 426
    const/4 v1, 0x0

    :try_start_2
    invoke-virtual {p0, v1}, Lcom/sun/mail/pop3/POP3Folder;->close(Z)V

    .line 427
    new-instance v1, Ljavax/mail/FolderClosedException;

    invoke-virtual {v0}, Ljava/io/EOFException;->toString()Ljava/lang/String;

    move-result-object v0

    invoke-direct {v1, p0, v0}, Ljavax/mail/FolderClosedException;-><init>(Ljavax/mail/Folder;Ljava/lang/String;)V

    throw v1
    :try_end_2
    .catchall {:try_start_2 .. :try_end_2} :catchall_0

    .line 419
    :catchall_0
    move-exception v0

    monitor-exit p0

    throw v0

    .line 428
    :catch_1
    move-exception v0

    .line 429
    :try_start_3
    new-instance v1, Ljavax/mail/MessagingException;

    const-string v2, "error getting UIDL"

    invoke-direct {v1, v2, v0}, Ljavax/mail/MessagingException;-><init>(Ljava/lang/String;Ljava/lang/Exception;)V

    throw v1
    :try_end_3
    .catchall {:try_start_3 .. :try_end_3} :catchall_0
.end method

.method public hasNewMessages()Z
    .locals 1
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljavax/mail/MessagingException;
        }
    .end annotation

    .prologue
    .line 151
    const/4 v0, 0x0

    return v0
.end method

.method public isOpen()Z
    .locals 2

    .prologue
    const/4 v0, 0x0

    .line 271
    iget-boolean v1, p0, Lcom/sun/mail/pop3/POP3Folder;->opened:Z

    if-nez v1, :cond_0

    .line 278
    :goto_0
    return v0

    .line 273
    :cond_0
    iget-object v1, p0, Lcom/sun/mail/pop3/POP3Folder;->store:Ljavax/mail/Store;

    invoke-virtual {v1}, Ljavax/mail/Store;->isConnected()Z

    move-result v1

    if-eqz v1, :cond_1

    .line 274
    const/4 v0, 0x1

    goto :goto_0

    .line 276
    :cond_1
    const/4 v1, 0x0

    :try_start_0
    invoke-virtual {p0, v1}, Lcom/sun/mail/pop3/POP3Folder;->close(Z)V
    :try_end_0
    .catch Ljavax/mail/MessagingException; {:try_start_0 .. :try_end_0} :catch_0

    goto :goto_0

    .line 277
    :catch_0
    move-exception v1

    goto :goto_0
.end method

.method public list(Ljava/lang/String;)[Ljavax/mail/Folder;
    .locals 2
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljavax/mail/MessagingException;
        }
    .end annotation

    .prologue
    .line 113
    new-instance v0, Ljavax/mail/MessagingException;

    const-string v1, "not a directory"

    invoke-direct {v0, v1}, Ljavax/mail/MessagingException;-><init>(Ljava/lang/String;)V

    throw v0
.end method

.method public declared-synchronized listCommand()Ljava/io/InputStream;
    .locals 1
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljavax/mail/MessagingException;,
            Ljava/io/IOException;
        }
    .end annotation

    .prologue
    .line 497
    monitor-enter p0

    :try_start_0
    invoke-virtual {p0}, Lcom/sun/mail/pop3/POP3Folder;->checkOpen()V

    .line 498
    iget-object v0, p0, Lcom/sun/mail/pop3/POP3Folder;->port:Lcom/sun/mail/pop3/Protocol;

    invoke-virtual {v0}, Lcom/sun/mail/pop3/Protocol;->list()Ljava/io/InputStream;
    :try_end_0
    .catchall {:try_start_0 .. :try_end_0} :catchall_0

    move-result-object v0

    monitor-exit p0

    return-object v0

    .line 497
    :catchall_0
    move-exception v0

    monitor-exit p0

    throw v0
.end method

.method protected notifyMessageChangedListeners(ILjavax/mail/Message;)V
    .locals 0

    .prologue
    .line 547
    invoke-super {p0, p1, p2}, Ljavax/mail/Folder;->notifyMessageChangedListeners(ILjavax/mail/Message;)V

    .line 548
    return-void
.end method

.method public declared-synchronized open(I)V
    .locals 3
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljavax/mail/MessagingException;
        }
    .end annotation

    .prologue
    .line 194
    monitor-enter p0

    :try_start_0
    invoke-virtual {p0}, Lcom/sun/mail/pop3/POP3Folder;->checkClosed()V

    .line 195
    iget-boolean v0, p0, Lcom/sun/mail/pop3/POP3Folder;->exists:Z

    if-nez v0, :cond_0

    .line 196
    new-instance v0, Ljavax/mail/FolderNotFoundException;

    const-string v1, "folder is not INBOX"

    invoke-direct {v0, p0, v1}, Ljavax/mail/FolderNotFoundException;-><init>(Ljavax/mail/Folder;Ljava/lang/String;)V

    throw v0
    :try_end_0
    .catchall {:try_start_0 .. :try_end_0} :catchall_0

    .line 194
    :catchall_0
    move-exception v0

    monitor-exit p0

    throw v0

    .line 199
    :cond_0
    :try_start_1
    iget-object v0, p0, Lcom/sun/mail/pop3/POP3Folder;->store:Ljavax/mail/Store;

    check-cast v0, Lcom/sun/mail/pop3/POP3Store;

    invoke-virtual {v0, p0}, Lcom/sun/mail/pop3/POP3Store;->getPort(Lcom/sun/mail/pop3/POP3Folder;)Lcom/sun/mail/pop3/Protocol;

    move-result-object v0

    iput-object v0, p0, Lcom/sun/mail/pop3/POP3Folder;->port:Lcom/sun/mail/pop3/Protocol;

    .line 200
    iget-object v0, p0, Lcom/sun/mail/pop3/POP3Folder;->port:Lcom/sun/mail/pop3/Protocol;

    invoke-virtual {v0}, Lcom/sun/mail/pop3/Protocol;->stat()Lcom/sun/mail/pop3/Status;

    move-result-object v0

    .line 201
    iget v1, v0, Lcom/sun/mail/pop3/Status;->total:I

    iput v1, p0, Lcom/sun/mail/pop3/POP3Folder;->total:I

    .line 202
    iget v0, v0, Lcom/sun/mail/pop3/Status;->size:I

    iput v0, p0, Lcom/sun/mail/pop3/POP3Folder;->size:I

    .line 203
    iput p1, p0, Lcom/sun/mail/pop3/POP3Folder;->mode:I

    .line 204
    const/4 v0, 0x1

    iput-boolean v0, p0, Lcom/sun/mail/pop3/POP3Folder;->opened:Z
    :try_end_1
    .catch Ljava/io/IOException; {:try_start_1 .. :try_end_1} :catch_0
    .catchall {:try_start_1 .. :try_end_1} :catchall_0

    .line 219
    :try_start_2
    new-instance v0, Ljava/util/Vector;

    iget v1, p0, Lcom/sun/mail/pop3/POP3Folder;->total:I

    invoke-direct {v0, v1}, Ljava/util/Vector;-><init>(I)V

    iput-object v0, p0, Lcom/sun/mail/pop3/POP3Folder;->message_cache:Ljava/util/Vector;

    .line 220
    iget-object v0, p0, Lcom/sun/mail/pop3/POP3Folder;->message_cache:Ljava/util/Vector;

    iget v1, p0, Lcom/sun/mail/pop3/POP3Folder;->total:I

    invoke-virtual {v0, v1}, Ljava/util/Vector;->setSize(I)V

    .line 221
    const/4 v0, 0x0

    iput-boolean v0, p0, Lcom/sun/mail/pop3/POP3Folder;->doneUidl:Z

    .line 223
    const/4 v0, 0x1

    invoke-virtual {p0, v0}, Lcom/sun/mail/pop3/POP3Folder;->notifyConnectionListeners(I)V
    :try_end_2
    .catchall {:try_start_2 .. :try_end_2} :catchall_0

    .line 224
    monitor-exit p0

    return-void

    .line 205
    :catch_0
    move-exception v0

    move-object v1, v0

    .line 207
    :try_start_3
    iget-object v0, p0, Lcom/sun/mail/pop3/POP3Folder;->port:Lcom/sun/mail/pop3/Protocol;

    if-eqz v0, :cond_1

    .line 208
    iget-object v0, p0, Lcom/sun/mail/pop3/POP3Folder;->port:Lcom/sun/mail/pop3/Protocol;

    invoke-virtual {v0}, Lcom/sun/mail/pop3/Protocol;->quit()Z
    :try_end_3
    .catch Ljava/io/IOException; {:try_start_3 .. :try_end_3} :catch_1
    .catchall {:try_start_3 .. :try_end_3} :catchall_1

    .line 212
    :cond_1
    const/4 v0, 0x0

    :try_start_4
    iput-object v0, p0, Lcom/sun/mail/pop3/POP3Folder;->port:Lcom/sun/mail/pop3/Protocol;

    .line 213
    iget-object v0, p0, Lcom/sun/mail/pop3/POP3Folder;->store:Ljavax/mail/Store;

    check-cast v0, Lcom/sun/mail/pop3/POP3Store;

    invoke-virtual {v0, p0}, Lcom/sun/mail/pop3/POP3Store;->closePort(Lcom/sun/mail/pop3/POP3Folder;)V

    .line 215
    :goto_0
    new-instance v0, Ljavax/mail/MessagingException;

    const-string v2, "Open failed"

    invoke-direct {v0, v2, v1}, Ljavax/mail/MessagingException;-><init>(Ljava/lang/String;Ljava/lang/Exception;)V

    throw v0

    .line 209
    :catch_1
    move-exception v0

    .line 212
    const/4 v0, 0x0

    iput-object v0, p0, Lcom/sun/mail/pop3/POP3Folder;->port:Lcom/sun/mail/pop3/Protocol;

    .line 213
    iget-object v0, p0, Lcom/sun/mail/pop3/POP3Folder;->store:Ljavax/mail/Store;

    check-cast v0, Lcom/sun/mail/pop3/POP3Store;

    invoke-virtual {v0, p0}, Lcom/sun/mail/pop3/POP3Store;->closePort(Lcom/sun/mail/pop3/POP3Folder;)V

    goto :goto_0

    .line 211
    :catchall_1
    move-exception v0

    move-object v1, v0

    .line 212
    const/4 v0, 0x0

    iput-object v0, p0, Lcom/sun/mail/pop3/POP3Folder;->port:Lcom/sun/mail/pop3/Protocol;

    .line 213
    iget-object v0, p0, Lcom/sun/mail/pop3/POP3Folder;->store:Ljavax/mail/Store;

    check-cast v0, Lcom/sun/mail/pop3/POP3Store;

    invoke-virtual {v0, p0}, Lcom/sun/mail/pop3/POP3Store;->closePort(Lcom/sun/mail/pop3/POP3Folder;)V

    .line 214
    throw v1
    :try_end_4
    .catchall {:try_start_4 .. :try_end_4} :catchall_0
.end method

.method public renameTo(Ljavax/mail/Folder;)Z
    .locals 2
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljavax/mail/MessagingException;
        }
    .end annotation

    .prologue
    .line 182
    new-instance v0, Ljavax/mail/MethodNotSupportedException;

    const-string v1, "renameTo"

    invoke-direct {v0, v1}, Ljavax/mail/MethodNotSupportedException;-><init>(Ljava/lang/String;)V

    throw v0
.end method
