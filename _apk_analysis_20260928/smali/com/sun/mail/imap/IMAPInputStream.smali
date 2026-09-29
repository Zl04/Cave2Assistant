.class public Lcom/sun/mail/imap/IMAPInputStream;
.super Ljava/io/InputStream;
.source "SourceFile"


# static fields
.field private static final slop:I = 0x40


# instance fields
.field private blksize:I

.field private buf:[B

.field private bufcount:I

.field private bufpos:I

.field private max:I

.field private msg:Lcom/sun/mail/imap/IMAPMessage;

.field private peek:Z

.field private pos:I

.field private readbuf:Lcom/sun/mail/iap/ByteArray;

.field private section:Ljava/lang/String;


# direct methods
.method public constructor <init>(Lcom/sun/mail/imap/IMAPMessage;Ljava/lang/String;IZ)V
    .locals 1

    .prologue
    .line 77
    invoke-direct {p0}, Ljava/io/InputStream;-><init>()V

    .line 79
    iput-object p1, p0, Lcom/sun/mail/imap/IMAPInputStream;->msg:Lcom/sun/mail/imap/IMAPMessage;

    .line 80
    iput-object p2, p0, Lcom/sun/mail/imap/IMAPInputStream;->section:Ljava/lang/String;

    .line 81
    iput p3, p0, Lcom/sun/mail/imap/IMAPInputStream;->max:I

    .line 82
    iput-boolean p4, p0, Lcom/sun/mail/imap/IMAPInputStream;->peek:Z

    .line 83
    const/4 v0, 0x0

    iput v0, p0, Lcom/sun/mail/imap/IMAPInputStream;->pos:I

    .line 84
    invoke-virtual {p1}, Lcom/sun/mail/imap/IMAPMessage;->getFetchBlockSize()I

    move-result v0

    iput v0, p0, Lcom/sun/mail/imap/IMAPInputStream;->blksize:I

    .line 85
    return-void
.end method

.method private checkSeen()V
    .locals 3

    .prologue
    const/4 v1, 0x1

    .line 253
    iget-boolean v0, p0, Lcom/sun/mail/imap/IMAPInputStream;->peek:Z

    if-eqz v0, :cond_1

    .line 263
    :cond_0
    :goto_0
    return-void

    .line 256
    :cond_1
    :try_start_0
    iget-object v0, p0, Lcom/sun/mail/imap/IMAPInputStream;->msg:Lcom/sun/mail/imap/IMAPMessage;

    invoke-virtual {v0}, Lcom/sun/mail/imap/IMAPMessage;->getFolder()Ljavax/mail/Folder;

    move-result-object v0

    .line 257
    if-eqz v0, :cond_0

    invoke-virtual {v0}, Ljavax/mail/Folder;->getMode()I

    move-result v0

    if-eq v0, v1, :cond_0

    .line 258
    iget-object v0, p0, Lcom/sun/mail/imap/IMAPInputStream;->msg:Lcom/sun/mail/imap/IMAPMessage;

    sget-object v1, Ljavax/mail/Flags$Flag;->SEEN:Ljavax/mail/Flags$Flag;

    invoke-virtual {v0, v1}, Lcom/sun/mail/imap/IMAPMessage;->isSet(Ljavax/mail/Flags$Flag;)Z

    move-result v0

    if-nez v0, :cond_0

    .line 259
    iget-object v0, p0, Lcom/sun/mail/imap/IMAPInputStream;->msg:Lcom/sun/mail/imap/IMAPMessage;

    sget-object v1, Ljavax/mail/Flags$Flag;->SEEN:Ljavax/mail/Flags$Flag;

    const/4 v2, 0x1

    invoke-virtual {v0, v1, v2}, Lcom/sun/mail/imap/IMAPMessage;->setFlag(Ljavax/mail/Flags$Flag;Z)V
    :try_end_0
    .catch Ljavax/mail/MessagingException; {:try_start_0 .. :try_end_0} :catch_0

    goto :goto_0

    .line 260
    :catch_0
    move-exception v0

    goto :goto_0
.end method

.method private fill()V
    .locals 7
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljava/io/IOException;
        }
    .end annotation

    .prologue
    const/4 v3, -0x1

    .line 119
    iget v0, p0, Lcom/sun/mail/imap/IMAPInputStream;->max:I

    if-eq v0, v3, :cond_1

    iget v0, p0, Lcom/sun/mail/imap/IMAPInputStream;->pos:I

    iget v1, p0, Lcom/sun/mail/imap/IMAPInputStream;->max:I

    if-lt v0, v1, :cond_1

    .line 120
    iget v0, p0, Lcom/sun/mail/imap/IMAPInputStream;->pos:I

    if-nez v0, :cond_0

    .line 121
    invoke-direct {p0}, Lcom/sun/mail/imap/IMAPInputStream;->checkSeen()V

    .line 122
    :cond_0
    const/4 v0, 0x0

    iput-object v0, p0, Lcom/sun/mail/imap/IMAPInputStream;->readbuf:Lcom/sun/mail/iap/ByteArray;

    .line 174
    :goto_0
    return-void

    .line 127
    :cond_1
    iget-object v0, p0, Lcom/sun/mail/imap/IMAPInputStream;->readbuf:Lcom/sun/mail/iap/ByteArray;

    if-nez v0, :cond_2

    .line 128
    new-instance v0, Lcom/sun/mail/iap/ByteArray;

    iget v1, p0, Lcom/sun/mail/imap/IMAPInputStream;->blksize:I

    add-int/lit8 v1, v1, 0x40

    invoke-direct {v0, v1}, Lcom/sun/mail/iap/ByteArray;-><init>(I)V

    iput-object v0, p0, Lcom/sun/mail/imap/IMAPInputStream;->readbuf:Lcom/sun/mail/iap/ByteArray;

    .line 132
    :cond_2
    iget-object v0, p0, Lcom/sun/mail/imap/IMAPInputStream;->msg:Lcom/sun/mail/imap/IMAPMessage;

    invoke-virtual {v0}, Lcom/sun/mail/imap/IMAPMessage;->getMessageCacheLock()Ljava/lang/Object;

    move-result-object v6

    monitor-enter v6

    .line 134
    :try_start_0
    iget-object v0, p0, Lcom/sun/mail/imap/IMAPInputStream;->msg:Lcom/sun/mail/imap/IMAPMessage;

    invoke-virtual {v0}, Lcom/sun/mail/imap/IMAPMessage;->getProtocol()Lcom/sun/mail/imap/protocol/IMAPProtocol;

    move-result-object v0

    .line 137
    iget-object v1, p0, Lcom/sun/mail/imap/IMAPInputStream;->msg:Lcom/sun/mail/imap/IMAPMessage;

    invoke-virtual {v1}, Lcom/sun/mail/imap/IMAPMessage;->isExpunged()Z

    move-result v1

    if-eqz v1, :cond_3

    .line 138
    new-instance v0, Lcom/sun/mail/util/MessageRemovedIOException;

    .line 139
    const-string v1, "No content for expunged message"

    .line 138
    invoke-direct {v0, v1}, Lcom/sun/mail/util/MessageRemovedIOException;-><init>(Ljava/lang/String;)V

    throw v0
    :try_end_0
    .catch Lcom/sun/mail/iap/ProtocolException; {:try_start_0 .. :try_end_0} :catch_0
    .catch Ljavax/mail/FolderClosedException; {:try_start_0 .. :try_end_0} :catch_1
    .catchall {:try_start_0 .. :try_end_0} :catchall_0

    .line 149
    :catch_0
    move-exception v0

    .line 150
    :try_start_1
    invoke-direct {p0}, Lcom/sun/mail/imap/IMAPInputStream;->forceCheckExpunged()V

    .line 151
    new-instance v1, Ljava/io/IOException;

    invoke-virtual {v0}, Lcom/sun/mail/iap/ProtocolException;->getMessage()Ljava/lang/String;

    move-result-object v0

    invoke-direct {v1, v0}, Ljava/io/IOException;-><init>(Ljava/lang/String;)V

    throw v1

    .line 132
    :catchall_0
    move-exception v0

    monitor-exit v6
    :try_end_1
    .catchall {:try_start_1 .. :try_end_1} :catchall_0

    throw v0

    .line 141
    :cond_3
    :try_start_2
    iget-object v1, p0, Lcom/sun/mail/imap/IMAPInputStream;->msg:Lcom/sun/mail/imap/IMAPMessage;

    invoke-virtual {v1}, Lcom/sun/mail/imap/IMAPMessage;->getSequenceNumber()I

    move-result v1

    .line 142
    iget v4, p0, Lcom/sun/mail/imap/IMAPInputStream;->blksize:I

    .line 143
    iget v2, p0, Lcom/sun/mail/imap/IMAPInputStream;->max:I

    if-eq v2, v3, :cond_4

    iget v2, p0, Lcom/sun/mail/imap/IMAPInputStream;->pos:I

    iget v3, p0, Lcom/sun/mail/imap/IMAPInputStream;->blksize:I

    add-int/2addr v2, v3

    iget v3, p0, Lcom/sun/mail/imap/IMAPInputStream;->max:I

    if-le v2, v3, :cond_4

    .line 144
    iget v2, p0, Lcom/sun/mail/imap/IMAPInputStream;->max:I

    iget v3, p0, Lcom/sun/mail/imap/IMAPInputStream;->pos:I

    sub-int v4, v2, v3

    .line 145
    :cond_4
    iget-boolean v2, p0, Lcom/sun/mail/imap/IMAPInputStream;->peek:Z

    if-eqz v2, :cond_6

    .line 146
    iget-object v2, p0, Lcom/sun/mail/imap/IMAPInputStream;->section:Ljava/lang/String;

    iget v3, p0, Lcom/sun/mail/imap/IMAPInputStream;->pos:I

    iget-object v5, p0, Lcom/sun/mail/imap/IMAPInputStream;->readbuf:Lcom/sun/mail/iap/ByteArray;

    invoke-virtual/range {v0 .. v5}, Lcom/sun/mail/imap/protocol/IMAPProtocol;->peekBody(ILjava/lang/String;IILcom/sun/mail/iap/ByteArray;)Lcom/sun/mail/imap/protocol/BODY;
    :try_end_2
    .catch Lcom/sun/mail/iap/ProtocolException; {:try_start_2 .. :try_end_2} :catch_0
    .catch Ljavax/mail/FolderClosedException; {:try_start_2 .. :try_end_2} :catch_1
    .catchall {:try_start_2 .. :try_end_2} :catchall_0

    move-result-object v0

    .line 157
    :goto_1
    if-eqz v0, :cond_5

    :try_start_3
    invoke-virtual {v0}, Lcom/sun/mail/imap/protocol/BODY;->getByteArray()Lcom/sun/mail/iap/ByteArray;

    move-result-object v0

    if-nez v0, :cond_7

    .line 158
    :cond_5
    invoke-direct {p0}, Lcom/sun/mail/imap/IMAPInputStream;->forceCheckExpunged()V

    .line 159
    new-instance v0, Ljava/io/IOException;

    const-string v1, "No content"

    invoke-direct {v0, v1}, Ljava/io/IOException;-><init>(Ljava/lang/String;)V

    throw v0
    :try_end_3
    .catchall {:try_start_3 .. :try_end_3} :catchall_0

    .line 148
    :cond_6
    :try_start_4
    iget-object v2, p0, Lcom/sun/mail/imap/IMAPInputStream;->section:Ljava/lang/String;

    iget v3, p0, Lcom/sun/mail/imap/IMAPInputStream;->pos:I

    iget-object v5, p0, Lcom/sun/mail/imap/IMAPInputStream;->readbuf:Lcom/sun/mail/iap/ByteArray;

    invoke-virtual/range {v0 .. v5}, Lcom/sun/mail/imap/protocol/IMAPProtocol;->fetchBody(ILjava/lang/String;IILcom/sun/mail/iap/ByteArray;)Lcom/sun/mail/imap/protocol/BODY;
    :try_end_4
    .catch Lcom/sun/mail/iap/ProtocolException; {:try_start_4 .. :try_end_4} :catch_0
    .catch Ljavax/mail/FolderClosedException; {:try_start_4 .. :try_end_4} :catch_1
    .catchall {:try_start_4 .. :try_end_4} :catchall_0

    move-result-object v0

    goto :goto_1

    .line 152
    :catch_1
    move-exception v0

    .line 153
    :try_start_5
    new-instance v1, Lcom/sun/mail/util/FolderClosedIOException;

    invoke-virtual {v0}, Ljavax/mail/FolderClosedException;->getFolder()Ljavax/mail/Folder;

    move-result-object v2

    .line 154
    invoke-virtual {v0}, Ljavax/mail/FolderClosedException;->getMessage()Ljava/lang/String;

    move-result-object v0

    .line 153
    invoke-direct {v1, v2, v0}, Lcom/sun/mail/util/FolderClosedIOException;-><init>(Ljavax/mail/Folder;Ljava/lang/String;)V

    throw v1

    .line 132
    :cond_7
    monitor-exit v6
    :try_end_5
    .catchall {:try_start_5 .. :try_end_5} :catchall_0

    .line 164
    iget v1, p0, Lcom/sun/mail/imap/IMAPInputStream;->pos:I

    if-nez v1, :cond_8

    .line 165
    invoke-direct {p0}, Lcom/sun/mail/imap/IMAPInputStream;->checkSeen()V

    .line 168
    :cond_8
    invoke-virtual {v0}, Lcom/sun/mail/iap/ByteArray;->getBytes()[B

    move-result-object v1

    iput-object v1, p0, Lcom/sun/mail/imap/IMAPInputStream;->buf:[B

    .line 169
    invoke-virtual {v0}, Lcom/sun/mail/iap/ByteArray;->getStart()I

    move-result v1

    iput v1, p0, Lcom/sun/mail/imap/IMAPInputStream;->bufpos:I

    .line 170
    invoke-virtual {v0}, Lcom/sun/mail/iap/ByteArray;->getCount()I

    move-result v0

    .line 172
    iget v1, p0, Lcom/sun/mail/imap/IMAPInputStream;->bufpos:I

    add-int/2addr v1, v0

    iput v1, p0, Lcom/sun/mail/imap/IMAPInputStream;->bufcount:I

    .line 173
    iget v1, p0, Lcom/sun/mail/imap/IMAPInputStream;->pos:I

    add-int/2addr v0, v1

    iput v0, p0, Lcom/sun/mail/imap/IMAPInputStream;->pos:I

    goto/16 :goto_0
.end method

.method private forceCheckExpunged()V
    .locals 4
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Lcom/sun/mail/util/MessageRemovedIOException;,
            Lcom/sun/mail/util/FolderClosedIOException;
        }
    .end annotation

    .prologue
    .line 93
    iget-object v0, p0, Lcom/sun/mail/imap/IMAPInputStream;->msg:Lcom/sun/mail/imap/IMAPMessage;

    invoke-virtual {v0}, Lcom/sun/mail/imap/IMAPMessage;->getMessageCacheLock()Ljava/lang/Object;

    move-result-object v1

    monitor-enter v1

    .line 95
    :try_start_0
    iget-object v0, p0, Lcom/sun/mail/imap/IMAPInputStream;->msg:Lcom/sun/mail/imap/IMAPMessage;

    invoke-virtual {v0}, Lcom/sun/mail/imap/IMAPMessage;->getProtocol()Lcom/sun/mail/imap/protocol/IMAPProtocol;

    move-result-object v0

    invoke-virtual {v0}, Lcom/sun/mail/imap/protocol/IMAPProtocol;->noop()V
    :try_end_0
    .catch Lcom/sun/mail/iap/ConnectionException; {:try_start_0 .. :try_end_0} :catch_0
    .catch Ljavax/mail/FolderClosedException; {:try_start_0 .. :try_end_0} :catch_1
    .catch Lcom/sun/mail/iap/ProtocolException; {:try_start_0 .. :try_end_0} :catch_2
    .catchall {:try_start_0 .. :try_end_0} :catchall_0

    .line 93
    :goto_0
    :try_start_1
    monitor-exit v1
    :try_end_1
    .catchall {:try_start_1 .. :try_end_1} :catchall_0

    .line 106
    iget-object v0, p0, Lcom/sun/mail/imap/IMAPInputStream;->msg:Lcom/sun/mail/imap/IMAPMessage;

    invoke-virtual {v0}, Lcom/sun/mail/imap/IMAPMessage;->isExpunged()Z

    move-result v0

    if-eqz v0, :cond_0

    .line 107
    new-instance v0, Lcom/sun/mail/util/MessageRemovedIOException;

    invoke-direct {v0}, Lcom/sun/mail/util/MessageRemovedIOException;-><init>()V

    throw v0

    .line 96
    :catch_0
    move-exception v0

    .line 97
    :try_start_2
    new-instance v2, Lcom/sun/mail/util/FolderClosedIOException;

    iget-object v3, p0, Lcom/sun/mail/imap/IMAPInputStream;->msg:Lcom/sun/mail/imap/IMAPMessage;

    invoke-virtual {v3}, Lcom/sun/mail/imap/IMAPMessage;->getFolder()Ljavax/mail/Folder;

    move-result-object v3

    .line 98
    invoke-virtual {v0}, Lcom/sun/mail/iap/ConnectionException;->getMessage()Ljava/lang/String;

    move-result-object v0

    .line 97
    invoke-direct {v2, v3, v0}, Lcom/sun/mail/util/FolderClosedIOException;-><init>(Ljavax/mail/Folder;Ljava/lang/String;)V

    throw v2

    .line 93
    :catchall_0
    move-exception v0

    monitor-exit v1
    :try_end_2
    .catchall {:try_start_2 .. :try_end_2} :catchall_0

    throw v0

    .line 99
    :catch_1
    move-exception v0

    .line 100
    :try_start_3
    new-instance v2, Lcom/sun/mail/util/FolderClosedIOException;

    invoke-virtual {v0}, Ljavax/mail/FolderClosedException;->getFolder()Ljavax/mail/Folder;

    move-result-object v3

    .line 101
    invoke-virtual {v0}, Ljavax/mail/FolderClosedException;->getMessage()Ljava/lang/String;

    move-result-object v0

    .line 100
    invoke-direct {v2, v3, v0}, Lcom/sun/mail/util/FolderClosedIOException;-><init>(Ljavax/mail/Folder;Ljava/lang/String;)V

    throw v2
    :try_end_3
    .catchall {:try_start_3 .. :try_end_3} :catchall_0

    .line 108
    :cond_0
    return-void

    .line 102
    :catch_2
    move-exception v0

    goto :goto_0
.end method


# virtual methods
.method public declared-synchronized available()I
    .locals 2
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljava/io/IOException;
        }
    .end annotation

    .prologue
    .line 242
    monitor-enter p0

    :try_start_0
    iget v0, p0, Lcom/sun/mail/imap/IMAPInputStream;->bufcount:I

    iget v1, p0, Lcom/sun/mail/imap/IMAPInputStream;->bufpos:I
    :try_end_0
    .catchall {:try_start_0 .. :try_end_0} :catchall_0

    sub-int/2addr v0, v1

    monitor-exit p0

    return v0

    :catchall_0
    move-exception v0

    monitor-exit p0

    throw v0
.end method

.method public declared-synchronized read()I
    .locals 3
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljava/io/IOException;
        }
    .end annotation

    .prologue
    .line 181
    monitor-enter p0

    :try_start_0
    iget v0, p0, Lcom/sun/mail/imap/IMAPInputStream;->bufpos:I

    iget v1, p0, Lcom/sun/mail/imap/IMAPInputStream;->bufcount:I

    if-lt v0, v1, :cond_0

    .line 182
    invoke-direct {p0}, Lcom/sun/mail/imap/IMAPInputStream;->fill()V

    .line 183
    iget v0, p0, Lcom/sun/mail/imap/IMAPInputStream;->bufpos:I

    iget v1, p0, Lcom/sun/mail/imap/IMAPInputStream;->bufcount:I
    :try_end_0
    .catchall {:try_start_0 .. :try_end_0} :catchall_0

    if-lt v0, v1, :cond_0

    .line 184
    const/4 v0, -0x1

    .line 186
    :goto_0
    monitor-exit p0

    return v0

    :cond_0
    :try_start_1
    iget-object v0, p0, Lcom/sun/mail/imap/IMAPInputStream;->buf:[B

    iget v1, p0, Lcom/sun/mail/imap/IMAPInputStream;->bufpos:I

    add-int/lit8 v2, v1, 0x1

    iput v2, p0, Lcom/sun/mail/imap/IMAPInputStream;->bufpos:I

    aget-byte v0, v0, v1
    :try_end_1
    .catchall {:try_start_1 .. :try_end_1} :catchall_0

    and-int/lit16 v0, v0, 0xff

    goto :goto_0

    .line 181
    :catchall_0
    move-exception v0

    monitor-exit p0

    throw v0
.end method

.method public read([B)I
    .locals 2
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljava/io/IOException;
        }
    .end annotation

    .prologue
    .line 234
    const/4 v0, 0x0

    array-length v1, p1

    invoke-virtual {p0, p1, v0, v1}, Lcom/sun/mail/imap/IMAPInputStream;->read([BII)I

    move-result v0

    return v0
.end method

.method public declared-synchronized read([BII)I
    .locals 3
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljava/io/IOException;
        }
    .end annotation

    .prologue
    .line 206
    monitor-enter p0

    :try_start_0
    iget v0, p0, Lcom/sun/mail/imap/IMAPInputStream;->bufcount:I

    iget v1, p0, Lcom/sun/mail/imap/IMAPInputStream;->bufpos:I

    sub-int/2addr v0, v1

    .line 207
    if-gtz v0, :cond_0

    .line 208
    invoke-direct {p0}, Lcom/sun/mail/imap/IMAPInputStream;->fill()V

    .line 209
    iget v0, p0, Lcom/sun/mail/imap/IMAPInputStream;->bufcount:I

    iget v1, p0, Lcom/sun/mail/imap/IMAPInputStream;->bufpos:I
    :try_end_0
    .catchall {:try_start_0 .. :try_end_0} :catchall_0

    sub-int/2addr v0, v1

    .line 210
    if-gtz v0, :cond_0

    .line 211
    const/4 v0, -0x1

    .line 216
    :goto_0
    monitor-exit p0

    return v0

    .line 213
    :cond_0
    if-ge v0, p3, :cond_1

    .line 214
    :goto_1
    :try_start_1
    iget-object v1, p0, Lcom/sun/mail/imap/IMAPInputStream;->buf:[B

    iget v2, p0, Lcom/sun/mail/imap/IMAPInputStream;->bufpos:I

    invoke-static {v1, v2, p1, p2, v0}, Ljava/lang/System;->arraycopy(Ljava/lang/Object;ILjava/lang/Object;II)V

    .line 215
    iget v1, p0, Lcom/sun/mail/imap/IMAPInputStream;->bufpos:I

    add-int/2addr v1, v0

    iput v1, p0, Lcom/sun/mail/imap/IMAPInputStream;->bufpos:I
    :try_end_1
    .catchall {:try_start_1 .. :try_end_1} :catchall_0

    goto :goto_0

    .line 206
    :catchall_0
    move-exception v0

    monitor-exit p0

    throw v0

    :cond_1
    move v0, p3

    .line 213
    goto :goto_1
.end method
