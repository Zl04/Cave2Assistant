.class public final Lcom/sun/mail/imap/Utility;
.super Ljava/lang/Object;
.source "SourceFile"


# annotations
.annotation system Ldalvik/annotation/MemberClasses;
    value = {
        Lcom/sun/mail/imap/Utility$Condition;
    }
.end annotation


# direct methods
.method private constructor <init>()V
    .locals 0

    .prologue
    .line 62
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method

.method public static toMessageSet([Ljavax/mail/Message;Lcom/sun/mail/imap/Utility$Condition;)[Lcom/sun/mail/imap/protocol/MessageSet;
    .locals 6

    .prologue
    .line 76
    new-instance v4, Ljava/util/Vector;

    const/4 v0, 0x1

    invoke-direct {v4, v0}, Ljava/util/Vector;-><init>(I)V

    .line 80
    const/4 v0, 0x0

    move v1, v0

    :goto_0
    array-length v0, p0

    if-lt v1, v0, :cond_0

    .line 120
    invoke-virtual {v4}, Ljava/util/Vector;->isEmpty()Z

    move-result v0

    if-eqz v0, :cond_9

    .line 121
    const/4 v0, 0x0

    .line 125
    :goto_1
    return-object v0

    .line 81
    :cond_0
    aget-object v0, p0, v1

    check-cast v0, Lcom/sun/mail/imap/IMAPMessage;

    .line 82
    invoke-virtual {v0}, Lcom/sun/mail/imap/IMAPMessage;->isExpunged()Z

    move-result v2

    if-eqz v2, :cond_2

    .line 80
    :cond_1
    :goto_2
    add-int/lit8 v0, v1, 0x1

    move v1, v0

    goto :goto_0

    .line 85
    :cond_2
    invoke-virtual {v0}, Lcom/sun/mail/imap/IMAPMessage;->getSequenceNumber()I

    move-result v2

    .line 87
    if-eqz p1, :cond_3

    invoke-interface {p1, v0}, Lcom/sun/mail/imap/Utility$Condition;->test(Lcom/sun/mail/imap/IMAPMessage;)Z

    move-result v0

    if-eqz v0, :cond_1

    .line 90
    :cond_3
    new-instance v5, Lcom/sun/mail/imap/protocol/MessageSet;

    invoke-direct {v5}, Lcom/sun/mail/imap/protocol/MessageSet;-><init>()V

    .line 91
    iput v2, v5, Lcom/sun/mail/imap/protocol/MessageSet;->start:I

    .line 94
    add-int/lit8 v0, v1, 0x1

    move v1, v0

    :goto_3
    array-length v0, p0

    if-lt v1, v0, :cond_4

    .line 116
    :goto_4
    iput v2, v5, Lcom/sun/mail/imap/protocol/MessageSet;->end:I

    .line 117
    invoke-virtual {v4, v5}, Ljava/util/Vector;->addElement(Ljava/lang/Object;)V

    goto :goto_2

    .line 96
    :cond_4
    aget-object v0, p0, v1

    check-cast v0, Lcom/sun/mail/imap/IMAPMessage;

    .line 98
    invoke-virtual {v0}, Lcom/sun/mail/imap/IMAPMessage;->isExpunged()Z

    move-result v3

    if-eqz v3, :cond_6

    .line 94
    :cond_5
    :goto_5
    add-int/lit8 v0, v1, 0x1

    move v1, v0

    goto :goto_3

    .line 100
    :cond_6
    invoke-virtual {v0}, Lcom/sun/mail/imap/IMAPMessage;->getSequenceNumber()I

    move-result v3

    .line 103
    if-eqz p1, :cond_7

    invoke-interface {p1, v0}, Lcom/sun/mail/imap/Utility$Condition;->test(Lcom/sun/mail/imap/IMAPMessage;)Z

    move-result v0

    if-eqz v0, :cond_5

    .line 106
    :cond_7
    add-int/lit8 v0, v2, 0x1

    if-ne v3, v0, :cond_8

    move v2, v3

    .line 107
    goto :goto_5

    .line 112
    :cond_8
    add-int/lit8 v1, v1, -0x1

    .line 113
    goto :goto_4

    .line 123
    :cond_9
    invoke-virtual {v4}, Ljava/util/Vector;->size()I

    move-result v0

    new-array v0, v0, [Lcom/sun/mail/imap/protocol/MessageSet;

    .line 124
    invoke-virtual {v4, v0}, Ljava/util/Vector;->copyInto([Ljava/lang/Object;)V

    goto :goto_1
.end method

.method public static toUIDSet([Ljavax/mail/Message;)[Lcom/sun/mail/imap/protocol/UIDSet;
    .locals 10

    .prologue
    .line 134
    new-instance v6, Ljava/util/Vector;

    const/4 v0, 0x1

    invoke-direct {v6, v0}, Ljava/util/Vector;-><init>(I)V

    .line 138
    const/4 v0, 0x0

    move v1, v0

    :goto_0
    array-length v0, p0

    if-lt v1, v0, :cond_0

    .line 171
    invoke-virtual {v6}, Ljava/util/Vector;->isEmpty()Z

    move-result v0

    if-eqz v0, :cond_5

    .line 172
    const/4 v0, 0x0

    .line 176
    :goto_1
    return-object v0

    .line 139
    :cond_0
    aget-object v0, p0, v1

    check-cast v0, Lcom/sun/mail/imap/IMAPMessage;

    .line 140
    invoke-virtual {v0}, Lcom/sun/mail/imap/IMAPMessage;->isExpunged()Z

    move-result v2

    if-eqz v2, :cond_1

    .line 138
    :goto_2
    add-int/lit8 v0, v1, 0x1

    move v1, v0

    goto :goto_0

    .line 143
    :cond_1
    invoke-virtual {v0}, Lcom/sun/mail/imap/IMAPMessage;->getUID()J

    move-result-wide v2

    .line 145
    new-instance v7, Lcom/sun/mail/imap/protocol/UIDSet;

    invoke-direct {v7}, Lcom/sun/mail/imap/protocol/UIDSet;-><init>()V

    .line 146
    iput-wide v2, v7, Lcom/sun/mail/imap/protocol/UIDSet;->start:J

    .line 149
    add-int/lit8 v0, v1, 0x1

    move v1, v0

    :goto_3
    array-length v0, p0

    if-lt v1, v0, :cond_2

    .line 167
    :goto_4
    iput-wide v2, v7, Lcom/sun/mail/imap/protocol/UIDSet;->end:J

    .line 168
    invoke-virtual {v6, v7}, Ljava/util/Vector;->addElement(Ljava/lang/Object;)V

    goto :goto_2

    .line 151
    :cond_2
    aget-object v0, p0, v1

    check-cast v0, Lcom/sun/mail/imap/IMAPMessage;

    .line 153
    invoke-virtual {v0}, Lcom/sun/mail/imap/IMAPMessage;->isExpunged()Z

    move-result v4

    if-eqz v4, :cond_3

    .line 149
    :goto_5
    add-int/lit8 v0, v1, 0x1

    move v1, v0

    goto :goto_3

    .line 155
    :cond_3
    invoke-virtual {v0}, Lcom/sun/mail/imap/IMAPMessage;->getUID()J

    move-result-wide v4

    .line 157
    const-wide/16 v8, 0x1

    add-long/2addr v8, v2

    cmp-long v0, v4, v8

    if-nez v0, :cond_4

    move-wide v2, v4

    .line 158
    goto :goto_5

    .line 163
    :cond_4
    add-int/lit8 v1, v1, -0x1

    .line 164
    goto :goto_4

    .line 174
    :cond_5
    invoke-virtual {v6}, Ljava/util/Vector;->size()I

    move-result v0

    new-array v0, v0, [Lcom/sun/mail/imap/protocol/UIDSet;

    .line 175
    invoke-virtual {v6, v0}, Ljava/util/Vector;->copyInto([Ljava/lang/Object;)V

    goto :goto_1
.end method
