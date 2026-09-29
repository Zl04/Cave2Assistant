.class public abstract Ljavax/mail/Message;
.super Ljava/lang/Object;
.source "SourceFile"

# interfaces
.implements Ljavax/mail/Part;


# annotations
.annotation system Ldalvik/annotation/MemberClasses;
    value = {
        Ljavax/mail/Message$RecipientType;
    }
.end annotation


# instance fields
.field protected expunged:Z

.field protected folder:Ljavax/mail/Folder;

.field protected msgnum:I

.field protected session:Ljavax/mail/Session;


# direct methods
.method protected constructor <init>()V
    .locals 2

    .prologue
    const/4 v1, 0x0

    const/4 v0, 0x0

    .line 109
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    .line 89
    iput v0, p0, Ljavax/mail/Message;->msgnum:I

    .line 94
    iput-boolean v0, p0, Ljavax/mail/Message;->expunged:Z

    .line 99
    iput-object v1, p0, Ljavax/mail/Message;->folder:Ljavax/mail/Folder;

    .line 104
    iput-object v1, p0, Ljavax/mail/Message;->session:Ljavax/mail/Session;

    .line 109
    return-void
.end method

.method protected constructor <init>(Ljavax/mail/Folder;I)V
    .locals 2

    .prologue
    const/4 v1, 0x0

    const/4 v0, 0x0

    .line 118
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    .line 89
    iput v0, p0, Ljavax/mail/Message;->msgnum:I

    .line 94
    iput-boolean v0, p0, Ljavax/mail/Message;->expunged:Z

    .line 99
    iput-object v1, p0, Ljavax/mail/Message;->folder:Ljavax/mail/Folder;

    .line 104
    iput-object v1, p0, Ljavax/mail/Message;->session:Ljavax/mail/Session;

    .line 119
    iput-object p1, p0, Ljavax/mail/Message;->folder:Ljavax/mail/Folder;

    .line 120
    iput p2, p0, Ljavax/mail/Message;->msgnum:I

    .line 121
    iget-object v0, p1, Ljavax/mail/Folder;->store:Ljavax/mail/Store;

    iget-object v0, v0, Ljavax/mail/Store;->session:Ljavax/mail/Session;

    iput-object v0, p0, Ljavax/mail/Message;->session:Ljavax/mail/Session;

    .line 122
    return-void
.end method

.method protected constructor <init>(Ljavax/mail/Session;)V
    .locals 2

    .prologue
    const/4 v1, 0x0

    const/4 v0, 0x0

    .line 130
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    .line 89
    iput v0, p0, Ljavax/mail/Message;->msgnum:I

    .line 94
    iput-boolean v0, p0, Ljavax/mail/Message;->expunged:Z

    .line 99
    iput-object v1, p0, Ljavax/mail/Message;->folder:Ljavax/mail/Folder;

    .line 104
    iput-object v1, p0, Ljavax/mail/Message;->session:Ljavax/mail/Session;

    .line 131
    iput-object p1, p0, Ljavax/mail/Message;->session:Ljavax/mail/Session;

    .line 132
    return-void
.end method


# virtual methods
.method public abstract addFrom([Ljavax/mail/Address;)V
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljavax/mail/MessagingException;
        }
    .end annotation
.end method

.method public addRecipient(Ljavax/mail/Message$RecipientType;Ljavax/mail/Address;)V
    .locals 2
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljavax/mail/MessagingException;
        }
    .end annotation

    .prologue
    .line 398
    const/4 v0, 0x1

    new-array v0, v0, [Ljavax/mail/Address;

    .line 399
    const/4 v1, 0x0

    aput-object p2, v0, v1

    .line 400
    invoke-virtual {p0, p1, v0}, Ljavax/mail/Message;->addRecipients(Ljavax/mail/Message$RecipientType;[Ljavax/mail/Address;)V

    .line 401
    return-void
.end method

.method public abstract addRecipients(Ljavax/mail/Message$RecipientType;[Ljavax/mail/Address;)V
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljavax/mail/MessagingException;
        }
    .end annotation
.end method

.method public getAllRecipients()[Ljavax/mail/Address;
    .locals 6
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljavax/mail/MessagingException;
        }
    .end annotation

    .prologue
    const/4 v1, 0x0

    .line 305
    sget-object v0, Ljavax/mail/Message$RecipientType;->TO:Ljavax/mail/Message$RecipientType;

    invoke-virtual {p0, v0}, Ljavax/mail/Message;->getRecipients(Ljavax/mail/Message$RecipientType;)[Ljavax/mail/Address;

    move-result-object v2

    .line 306
    sget-object v0, Ljavax/mail/Message$RecipientType;->CC:Ljavax/mail/Message$RecipientType;

    invoke-virtual {p0, v0}, Ljavax/mail/Message;->getRecipients(Ljavax/mail/Message$RecipientType;)[Ljavax/mail/Address;

    move-result-object v4

    .line 307
    sget-object v0, Ljavax/mail/Message$RecipientType;->BCC:Ljavax/mail/Message$RecipientType;

    invoke-virtual {p0, v0}, Ljavax/mail/Message;->getRecipients(Ljavax/mail/Message$RecipientType;)[Ljavax/mail/Address;

    move-result-object v5

    .line 309
    if-nez v4, :cond_1

    if-nez v5, :cond_1

    move-object v0, v2

    .line 330
    :cond_0
    :goto_0
    return-object v0

    .line 313
    :cond_1
    if-eqz v2, :cond_3

    array-length v0, v2

    move v3, v0

    .line 314
    :goto_1
    if-eqz v4, :cond_4

    array-length v0, v4

    .line 313
    :goto_2
    add-int/2addr v3, v0

    .line 315
    if-eqz v5, :cond_5

    array-length v0, v5

    .line 313
    :goto_3
    add-int/2addr v0, v3

    .line 316
    new-array v0, v0, [Ljavax/mail/Address;

    .line 318
    if-eqz v2, :cond_6

    .line 319
    array-length v3, v2

    invoke-static {v2, v1, v0, v1, v3}, Ljava/lang/System;->arraycopy(Ljava/lang/Object;ILjava/lang/Object;II)V

    .line 320
    array-length v2, v2

    add-int/2addr v2, v1

    .line 322
    :goto_4
    if-eqz v4, :cond_2

    .line 323
    array-length v3, v4

    invoke-static {v4, v1, v0, v2, v3}, Ljava/lang/System;->arraycopy(Ljava/lang/Object;ILjava/lang/Object;II)V

    .line 324
    array-length v3, v4

    add-int/2addr v2, v3

    .line 326
    :cond_2
    if-eqz v5, :cond_0

    .line 327
    array-length v3, v5

    invoke-static {v5, v1, v0, v2, v3}, Ljava/lang/System;->arraycopy(Ljava/lang/Object;ILjava/lang/Object;II)V

    .line 328
    array-length v1, v5

    add-int/2addr v1, v2

    goto :goto_0

    :cond_3
    move v3, v1

    .line 313
    goto :goto_1

    :cond_4
    move v0, v1

    .line 314
    goto :goto_2

    :cond_5
    move v0, v1

    .line 315
    goto :goto_3

    :cond_6
    move v2, v1

    goto :goto_4
.end method

.method public abstract getFlags()Ljavax/mail/Flags;
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljavax/mail/MessagingException;
        }
    .end annotation
.end method

.method public getFolder()Ljavax/mail/Folder;
    .locals 1

    .prologue
    .line 614
    iget-object v0, p0, Ljavax/mail/Message;->folder:Ljavax/mail/Folder;

    return-object v0
.end method

.method public abstract getFrom()[Ljavax/mail/Address;
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljavax/mail/MessagingException;
        }
    .end annotation
.end method

.method public getMessageNumber()I
    .locals 1

    .prologue
    .line 595
    iget v0, p0, Ljavax/mail/Message;->msgnum:I

    return v0
.end method

.method public abstract getReceivedDate()Ljava/util/Date;
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljavax/mail/MessagingException;
        }
    .end annotation
.end method

.method public abstract getRecipients(Ljavax/mail/Message$RecipientType;)[Ljavax/mail/Address;
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljavax/mail/MessagingException;
        }
    .end annotation
.end method

.method public getReplyTo()[Ljavax/mail/Address;
    .locals 1
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljavax/mail/MessagingException;
        }
    .end annotation

    .prologue
    .line 420
    invoke-virtual {p0}, Ljavax/mail/Message;->getFrom()[Ljavax/mail/Address;

    move-result-object v0

    return-object v0
.end method

.method public abstract getSentDate()Ljava/util/Date;
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljavax/mail/MessagingException;
        }
    .end annotation
.end method

.method public abstract getSubject()Ljava/lang/String;
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljavax/mail/MessagingException;
        }
    .end annotation
.end method

.method public isExpunged()Z
    .locals 1

    .prologue
    .line 635
    iget-boolean v0, p0, Ljavax/mail/Message;->expunged:Z

    return v0
.end method

.method public isSet(Ljavax/mail/Flags$Flag;)Z
    .locals 1
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljavax/mail/MessagingException;
        }
    .end annotation

    .prologue
    .line 531
    invoke-virtual {p0}, Ljavax/mail/Message;->getFlags()Ljavax/mail/Flags;

    move-result-object v0

    invoke-virtual {v0, p1}, Ljavax/mail/Flags;->contains(Ljavax/mail/Flags$Flag;)Z

    move-result v0

    return v0
.end method

.method public match(Ljavax/mail/search/SearchTerm;)Z
    .locals 1
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljavax/mail/MessagingException;
        }
    .end annotation

    .prologue
    .line 705
    invoke-virtual {p1, p0}, Ljavax/mail/search/SearchTerm;->match(Ljavax/mail/Message;)Z

    move-result v0

    return v0
.end method

.method public abstract reply(Z)Ljavax/mail/Message;
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljavax/mail/MessagingException;
        }
    .end annotation
.end method

.method public abstract saveChanges()V
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljavax/mail/MessagingException;
        }
    .end annotation
.end method

.method protected setExpunged(Z)V
    .locals 0

    .prologue
    .line 645
    iput-boolean p1, p0, Ljavax/mail/Message;->expunged:Z

    .line 646
    return-void
.end method

.method public setFlag(Ljavax/mail/Flags$Flag;Z)V
    .locals 1
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljavax/mail/MessagingException;
        }
    .end annotation

    .prologue
    .line 577
    new-instance v0, Ljavax/mail/Flags;

    invoke-direct {v0, p1}, Ljavax/mail/Flags;-><init>(Ljavax/mail/Flags$Flag;)V

    .line 578
    invoke-virtual {p0, v0, p2}, Ljavax/mail/Message;->setFlags(Ljavax/mail/Flags;Z)V

    .line 579
    return-void
.end method

.method public abstract setFlags(Ljavax/mail/Flags;Z)V
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljavax/mail/MessagingException;
        }
    .end annotation
.end method

.method public abstract setFrom()V
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljavax/mail/MessagingException;
        }
    .end annotation
.end method

.method public abstract setFrom(Ljavax/mail/Address;)V
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljavax/mail/MessagingException;
        }
    .end annotation
.end method

.method protected setMessageNumber(I)V
    .locals 0

    .prologue
    .line 603
    iput p1, p0, Ljavax/mail/Message;->msgnum:I

    .line 604
    return-void
.end method

.method public setRecipient(Ljavax/mail/Message$RecipientType;Ljavax/mail/Address;)V
    .locals 2
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljavax/mail/MessagingException;
        }
    .end annotation

    .prologue
    .line 364
    const/4 v0, 0x1

    new-array v0, v0, [Ljavax/mail/Address;

    .line 365
    const/4 v1, 0x0

    aput-object p2, v0, v1

    .line 366
    invoke-virtual {p0, p1, v0}, Ljavax/mail/Message;->setRecipients(Ljavax/mail/Message$RecipientType;[Ljavax/mail/Address;)V

    .line 367
    return-void
.end method

.method public abstract setRecipients(Ljavax/mail/Message$RecipientType;[Ljavax/mail/Address;)V
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljavax/mail/MessagingException;
        }
    .end annotation
.end method

.method public setReplyTo([Ljavax/mail/Address;)V
    .locals 2
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljavax/mail/MessagingException;
        }
    .end annotation

    .prologue
    .line 444
    new-instance v0, Ljavax/mail/MethodNotSupportedException;

    const-string v1, "setReplyTo not supported"

    invoke-direct {v0, v1}, Ljavax/mail/MethodNotSupportedException;-><init>(Ljava/lang/String;)V

    throw v0
.end method

.method public abstract setSentDate(Ljava/util/Date;)V
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljavax/mail/MessagingException;
        }
    .end annotation
.end method

.method public abstract setSubject(Ljava/lang/String;)V
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljavax/mail/MessagingException;
        }
    .end annotation
.end method
