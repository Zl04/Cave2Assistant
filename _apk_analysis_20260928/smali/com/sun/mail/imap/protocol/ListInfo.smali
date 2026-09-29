.class public Lcom/sun/mail/imap/protocol/ListInfo;
.super Ljava/lang/Object;
.source "SourceFile"


# static fields
.field public static final CHANGED:I = 0x1

.field public static final INDETERMINATE:I = 0x3

.field public static final UNCHANGED:I = 0x2


# instance fields
.field public attrs:[Ljava/lang/String;

.field public canOpen:Z

.field public changeState:I

.field public hasInferiors:Z

.field public name:Ljava/lang/String;

.field public separator:C


# direct methods
.method public constructor <init>(Lcom/sun/mail/imap/protocol/IMAPResponse;)V
    .locals 8
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Lcom/sun/mail/iap/ParsingException;
        }
    .end annotation

    .prologue
    const/4 v7, 0x2

    const/4 v1, 0x0

    const/4 v6, 0x1

    .line 67
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    .line 56
    const/4 v0, 0x0

    iput-object v0, p0, Lcom/sun/mail/imap/protocol/ListInfo;->name:Ljava/lang/String;

    .line 57
    const/16 v0, 0x2f

    iput-char v0, p0, Lcom/sun/mail/imap/protocol/ListInfo;->separator:C

    .line 58
    iput-boolean v6, p0, Lcom/sun/mail/imap/protocol/ListInfo;->hasInferiors:Z

    .line 59
    iput-boolean v6, p0, Lcom/sun/mail/imap/protocol/ListInfo;->canOpen:Z

    .line 60
    const/4 v0, 0x3

    iput v0, p0, Lcom/sun/mail/imap/protocol/ListInfo;->changeState:I

    .line 68
    invoke-virtual {p1}, Lcom/sun/mail/imap/protocol/IMAPResponse;->readSimpleList()[Ljava/lang/String;

    move-result-object v2

    .line 70
    new-instance v3, Ljava/util/Vector;

    invoke-direct {v3}, Ljava/util/Vector;-><init>()V

    .line 71
    if-eqz v2, :cond_0

    move v0, v1

    .line 73
    :goto_0
    array-length v4, v2

    if-lt v0, v4, :cond_2

    .line 85
    :cond_0
    invoke-virtual {v3}, Ljava/util/Vector;->size()I

    move-result v0

    new-array v0, v0, [Ljava/lang/String;

    iput-object v0, p0, Lcom/sun/mail/imap/protocol/ListInfo;->attrs:[Ljava/lang/String;

    .line 86
    iget-object v0, p0, Lcom/sun/mail/imap/protocol/ListInfo;->attrs:[Ljava/lang/String;

    invoke-virtual {v3, v0}, Ljava/util/Vector;->copyInto([Ljava/lang/Object;)V

    .line 88
    invoke-virtual {p1}, Lcom/sun/mail/imap/protocol/IMAPResponse;->skipSpaces()V

    .line 89
    invoke-virtual {p1}, Lcom/sun/mail/imap/protocol/IMAPResponse;->readByte()B

    move-result v0

    const/16 v1, 0x22

    if-ne v0, v1, :cond_7

    .line 90
    invoke-virtual {p1}, Lcom/sun/mail/imap/protocol/IMAPResponse;->readByte()B

    move-result v0

    int-to-char v0, v0

    iput-char v0, p0, Lcom/sun/mail/imap/protocol/ListInfo;->separator:C

    const/16 v1, 0x5c

    if-ne v0, v1, :cond_1

    .line 92
    invoke-virtual {p1}, Lcom/sun/mail/imap/protocol/IMAPResponse;->readByte()B

    move-result v0

    int-to-char v0, v0

    iput-char v0, p0, Lcom/sun/mail/imap/protocol/ListInfo;->separator:C

    .line 93
    :cond_1
    invoke-virtual {p1, v6}, Lcom/sun/mail/imap/protocol/IMAPResponse;->skip(I)V

    .line 97
    :goto_1
    invoke-virtual {p1}, Lcom/sun/mail/imap/protocol/IMAPResponse;->skipSpaces()V

    .line 98
    invoke-virtual {p1}, Lcom/sun/mail/imap/protocol/IMAPResponse;->readAtomString()Ljava/lang/String;

    move-result-object v0

    iput-object v0, p0, Lcom/sun/mail/imap/protocol/ListInfo;->name:Ljava/lang/String;

    .line 101
    iget-object v0, p0, Lcom/sun/mail/imap/protocol/ListInfo;->name:Ljava/lang/String;

    invoke-static {v0}, Lcom/sun/mail/imap/protocol/BASE64MailboxDecoder;->decode(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v0

    iput-object v0, p0, Lcom/sun/mail/imap/protocol/ListInfo;->name:Ljava/lang/String;

    .line 102
    return-void

    .line 74
    :cond_2
    aget-object v4, v2, v0

    const-string v5, "\\Marked"

    invoke-virtual {v4, v5}, Ljava/lang/String;->equalsIgnoreCase(Ljava/lang/String;)Z

    move-result v4

    if-eqz v4, :cond_4

    .line 75
    iput v6, p0, Lcom/sun/mail/imap/protocol/ListInfo;->changeState:I

    .line 82
    :cond_3
    :goto_2
    aget-object v4, v2, v0

    invoke-virtual {v3, v4}, Ljava/util/Vector;->addElement(Ljava/lang/Object;)V

    .line 73
    add-int/lit8 v0, v0, 0x1

    goto :goto_0

    .line 76
    :cond_4
    aget-object v4, v2, v0

    const-string v5, "\\Unmarked"

    invoke-virtual {v4, v5}, Ljava/lang/String;->equalsIgnoreCase(Ljava/lang/String;)Z

    move-result v4

    if-eqz v4, :cond_5

    .line 77
    iput v7, p0, Lcom/sun/mail/imap/protocol/ListInfo;->changeState:I

    goto :goto_2

    .line 78
    :cond_5
    aget-object v4, v2, v0

    const-string v5, "\\Noselect"

    invoke-virtual {v4, v5}, Ljava/lang/String;->equalsIgnoreCase(Ljava/lang/String;)Z

    move-result v4

    if-eqz v4, :cond_6

    .line 79
    iput-boolean v1, p0, Lcom/sun/mail/imap/protocol/ListInfo;->canOpen:Z

    goto :goto_2

    .line 80
    :cond_6
    aget-object v4, v2, v0

    const-string v5, "\\Noinferiors"

    invoke-virtual {v4, v5}, Ljava/lang/String;->equalsIgnoreCase(Ljava/lang/String;)Z

    move-result v4

    if-eqz v4, :cond_3

    .line 81
    iput-boolean v1, p0, Lcom/sun/mail/imap/protocol/ListInfo;->hasInferiors:Z

    goto :goto_2

    .line 95
    :cond_7
    invoke-virtual {p1, v7}, Lcom/sun/mail/imap/protocol/IMAPResponse;->skip(I)V

    goto :goto_1
.end method
