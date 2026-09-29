.class public Lcom/sun/mail/imap/DefaultFolder;
.super Lcom/sun/mail/imap/IMAPFolder;
.source "SourceFile"


# direct methods
.method protected constructor <init>(Lcom/sun/mail/imap/IMAPStore;)V
    .locals 2

    .prologue
    .line 59
    const-string v0, ""

    const v1, 0xffff

    invoke-direct {p0, v0, v1, p1}, Lcom/sun/mail/imap/IMAPFolder;-><init>(Ljava/lang/String;CLcom/sun/mail/imap/IMAPStore;)V

    .line 60
    const/4 v0, 0x1

    iput-boolean v0, p0, Lcom/sun/mail/imap/DefaultFolder;->exists:Z

    .line 61
    const/4 v0, 0x2

    iput v0, p0, Lcom/sun/mail/imap/DefaultFolder;->type:I

    .line 62
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
    .line 130
    new-instance v0, Ljavax/mail/MethodNotSupportedException;

    const-string v1, "Cannot append to Default Folder"

    invoke-direct {v0, v1}, Ljavax/mail/MethodNotSupportedException;-><init>(Ljava/lang/String;)V

    throw v0
.end method

.method public delete(Z)Z
    .locals 2
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljavax/mail/MessagingException;
        }
    .end annotation

    .prologue
    .line 120
    new-instance v0, Ljavax/mail/MethodNotSupportedException;

    const-string v1, "Cannot delete Default Folder"

    invoke-direct {v0, v1}, Ljavax/mail/MethodNotSupportedException;-><init>(Ljava/lang/String;)V

    throw v0
.end method

.method public expunge()[Ljavax/mail/Message;
    .locals 2
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljavax/mail/MessagingException;
        }
    .end annotation

    .prologue
    .line 135
    new-instance v0, Ljavax/mail/MethodNotSupportedException;

    const-string v1, "Cannot expunge Default Folder"

    invoke-direct {v0, v1}, Ljavax/mail/MethodNotSupportedException;-><init>(Ljava/lang/String;)V

    throw v0
.end method

.method public getFolder(Ljava/lang/String;)Ljavax/mail/Folder;
    .locals 3
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljavax/mail/MessagingException;
        }
    .end annotation

    .prologue
    .line 115
    new-instance v1, Lcom/sun/mail/imap/IMAPFolder;

    const v2, 0xffff

    iget-object v0, p0, Lcom/sun/mail/imap/DefaultFolder;->store:Ljavax/mail/Store;

    check-cast v0, Lcom/sun/mail/imap/IMAPStore;

    invoke-direct {v1, p1, v2, v0}, Lcom/sun/mail/imap/IMAPFolder;-><init>(Ljava/lang/String;CLcom/sun/mail/imap/IMAPStore;)V

    return-object v1
.end method

.method public getName()Ljava/lang/String;
    .locals 1

    .prologue
    .line 65
    iget-object v0, p0, Lcom/sun/mail/imap/DefaultFolder;->fullName:Ljava/lang/String;

    return-object v0
.end method

.method public getParent()Ljavax/mail/Folder;
    .locals 1

    .prologue
    .line 69
    const/4 v0, 0x0

    return-object v0
.end method

.method public hasNewMessages()Z
    .locals 1
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljavax/mail/MessagingException;
        }
    .end annotation

    .prologue
    .line 111
    const/4 v0, 0x0

    return v0
.end method

.method public list(Ljava/lang/String;)[Ljavax/mail/Folder;
    .locals 6
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljavax/mail/MessagingException;
        }
    .end annotation

    .prologue
    const/4 v1, 0x0

    .line 73
    const/4 v0, 0x0

    check-cast v0, [Lcom/sun/mail/imap/protocol/ListInfo;

    .line 75
    new-instance v0, Lcom/sun/mail/imap/DefaultFolder$1;

    invoke-direct {v0, p0, p1}, Lcom/sun/mail/imap/DefaultFolder$1;-><init>(Lcom/sun/mail/imap/DefaultFolder;Ljava/lang/String;)V

    invoke-virtual {p0, v0}, Lcom/sun/mail/imap/DefaultFolder;->doCommand(Lcom/sun/mail/imap/IMAPFolder$ProtocolCommand;)Ljava/lang/Object;

    move-result-object v0

    check-cast v0, [Lcom/sun/mail/imap/protocol/ListInfo;

    .line 81
    if-nez v0, :cond_0

    .line 82
    new-array v0, v1, [Ljavax/mail/Folder;

    .line 87
    :goto_0
    return-object v0

    .line 84
    :cond_0
    array-length v2, v0

    new-array v3, v2, [Lcom/sun/mail/imap/IMAPFolder;

    move v2, v1

    .line 85
    :goto_1
    array-length v1, v3

    if-lt v2, v1, :cond_1

    move-object v0, v3

    .line 87
    goto :goto_0

    .line 86
    :cond_1
    new-instance v4, Lcom/sun/mail/imap/IMAPFolder;

    aget-object v5, v0, v2

    iget-object v1, p0, Lcom/sun/mail/imap/DefaultFolder;->store:Ljavax/mail/Store;

    check-cast v1, Lcom/sun/mail/imap/IMAPStore;

    invoke-direct {v4, v5, v1}, Lcom/sun/mail/imap/IMAPFolder;-><init>(Lcom/sun/mail/imap/protocol/ListInfo;Lcom/sun/mail/imap/IMAPStore;)V

    aput-object v4, v3, v2

    .line 85
    add-int/lit8 v1, v2, 0x1

    move v2, v1

    goto :goto_1
.end method

.method public listSubscribed(Ljava/lang/String;)[Ljavax/mail/Folder;
    .locals 6
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljavax/mail/MessagingException;
        }
    .end annotation

    .prologue
    const/4 v1, 0x0

    .line 92
    const/4 v0, 0x0

    check-cast v0, [Lcom/sun/mail/imap/protocol/ListInfo;

    .line 94
    new-instance v0, Lcom/sun/mail/imap/DefaultFolder$2;

    invoke-direct {v0, p0, p1}, Lcom/sun/mail/imap/DefaultFolder$2;-><init>(Lcom/sun/mail/imap/DefaultFolder;Ljava/lang/String;)V

    invoke-virtual {p0, v0}, Lcom/sun/mail/imap/DefaultFolder;->doCommand(Lcom/sun/mail/imap/IMAPFolder$ProtocolCommand;)Ljava/lang/Object;

    move-result-object v0

    check-cast v0, [Lcom/sun/mail/imap/protocol/ListInfo;

    .line 100
    if-nez v0, :cond_0

    .line 101
    new-array v0, v1, [Ljavax/mail/Folder;

    .line 106
    :goto_0
    return-object v0

    .line 103
    :cond_0
    array-length v2, v0

    new-array v3, v2, [Lcom/sun/mail/imap/IMAPFolder;

    move v2, v1

    .line 104
    :goto_1
    array-length v1, v3

    if-lt v2, v1, :cond_1

    move-object v0, v3

    .line 106
    goto :goto_0

    .line 105
    :cond_1
    new-instance v4, Lcom/sun/mail/imap/IMAPFolder;

    aget-object v5, v0, v2

    iget-object v1, p0, Lcom/sun/mail/imap/DefaultFolder;->store:Ljavax/mail/Store;

    check-cast v1, Lcom/sun/mail/imap/IMAPStore;

    invoke-direct {v4, v5, v1}, Lcom/sun/mail/imap/IMAPFolder;-><init>(Lcom/sun/mail/imap/protocol/ListInfo;Lcom/sun/mail/imap/IMAPStore;)V

    aput-object v4, v3, v2

    .line 104
    add-int/lit8 v1, v2, 0x1

    move v2, v1

    goto :goto_1
.end method

.method public renameTo(Ljavax/mail/Folder;)Z
    .locals 2
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljavax/mail/MessagingException;
        }
    .end annotation

    .prologue
    .line 125
    new-instance v0, Ljavax/mail/MethodNotSupportedException;

    const-string v1, "Cannot rename Default Folder"

    invoke-direct {v0, v1}, Ljavax/mail/MethodNotSupportedException;-><init>(Ljava/lang/String;)V

    throw v0
.end method
