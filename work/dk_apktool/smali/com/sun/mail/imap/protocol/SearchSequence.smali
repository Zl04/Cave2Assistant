.class Lcom/sun/mail/imap/protocol/SearchSequence;
.super Ljava/lang/Object;
.source "SourceFile"


# static fields
.field private static cal:Ljava/util/Calendar;

.field private static monthTable:[Ljava/lang/String;


# direct methods
.method static constructor <clinit>()V
    .locals 3

    .prologue
    .line 357
    const/16 v0, 0xc

    new-array v0, v0, [Ljava/lang/String;

    const/4 v1, 0x0

    .line 358
    const-string v2, "Jan"

    aput-object v2, v0, v1

    const/4 v1, 0x1

    const-string v2, "Feb"

    aput-object v2, v0, v1

    const/4 v1, 0x2

    const-string v2, "Mar"

    aput-object v2, v0, v1

    const/4 v1, 0x3

    const-string v2, "Apr"

    aput-object v2, v0, v1

    const/4 v1, 0x4

    const-string v2, "May"

    aput-object v2, v0, v1

    const/4 v1, 0x5

    const-string v2, "Jun"

    aput-object v2, v0, v1

    const/4 v1, 0x6

    .line 359
    const-string v2, "Jul"

    aput-object v2, v0, v1

    const/4 v1, 0x7

    const-string v2, "Aug"

    aput-object v2, v0, v1

    const/16 v1, 0x8

    const-string v2, "Sep"

    aput-object v2, v0, v1

    const/16 v1, 0x9

    const-string v2, "Oct"

    aput-object v2, v0, v1

    const/16 v1, 0xa

    const-string v2, "Nov"

    aput-object v2, v0, v1

    const/16 v1, 0xb

    const-string v2, "Dec"

    aput-object v2, v0, v1

    .line 357
    sput-object v0, Lcom/sun/mail/imap/protocol/SearchSequence;->monthTable:[Ljava/lang/String;

    .line 363
    new-instance v0, Ljava/util/GregorianCalendar;

    invoke-direct {v0}, Ljava/util/GregorianCalendar;-><init>()V

    sput-object v0, Lcom/sun/mail/imap/protocol/SearchSequence;->cal:Ljava/util/Calendar;

    .line 56
    return-void
.end method

.method constructor <init>()V
    .locals 0

    .prologue
    .line 56
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method

.method private static and(Ljavax/mail/search/AndTerm;Ljava/lang/String;)Lcom/sun/mail/iap/Argument;
    .locals 4
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljavax/mail/search/SearchException;,
            Ljava/io/IOException;
        }
    .end annotation

    .prologue
    .line 151
    invoke-virtual {p0}, Ljavax/mail/search/AndTerm;->getTerms()[Ljavax/mail/search/SearchTerm;

    move-result-object v1

    .line 153
    const/4 v0, 0x0

    aget-object v0, v1, v0

    invoke-static {v0, p1}, Lcom/sun/mail/imap/protocol/SearchSequence;->generateSequence(Ljavax/mail/search/SearchTerm;Ljava/lang/String;)Lcom/sun/mail/iap/Argument;

    move-result-object v2

    .line 155
    const/4 v0, 0x1

    :goto_0
    array-length v3, v1

    if-lt v0, v3, :cond_0

    .line 157
    return-object v2

    .line 156
    :cond_0
    aget-object v3, v1, v0

    invoke-static {v3, p1}, Lcom/sun/mail/imap/protocol/SearchSequence;->generateSequence(Ljavax/mail/search/SearchTerm;Ljava/lang/String;)Lcom/sun/mail/iap/Argument;

    move-result-object v3

    invoke-virtual {v2, v3}, Lcom/sun/mail/iap/Argument;->append(Lcom/sun/mail/iap/Argument;)V

    .line 155
    add-int/lit8 v0, v0, 0x1

    goto :goto_0
.end method

.method private static body(Ljavax/mail/search/BodyTerm;Ljava/lang/String;)Lcom/sun/mail/iap/Argument;
    .locals 2
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljavax/mail/search/SearchException;,
            Ljava/io/IOException;
        }
    .end annotation

    .prologue
    .line 319
    new-instance v0, Lcom/sun/mail/iap/Argument;

    invoke-direct {v0}, Lcom/sun/mail/iap/Argument;-><init>()V

    .line 321
    const-string v1, "BODY"

    invoke-virtual {v0, v1}, Lcom/sun/mail/iap/Argument;->writeAtom(Ljava/lang/String;)V

    .line 322
    invoke-virtual {p0}, Ljavax/mail/search/BodyTerm;->getPattern()Ljava/lang/String;

    move-result-object v1

    invoke-virtual {v0, v1, p1}, Lcom/sun/mail/iap/Argument;->writeString(Ljava/lang/String;Ljava/lang/String;)V

    .line 323
    return-object v0
.end method

.method private static flag(Ljavax/mail/search/FlagTerm;)Lcom/sun/mail/iap/Argument;
    .locals 8
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljavax/mail/search/SearchException;
        }
    .end annotation

    .prologue
    const/4 v1, 0x0

    .line 249
    invoke-virtual {p0}, Ljavax/mail/search/FlagTerm;->getTestSet()Z

    move-result v3

    .line 251
    new-instance v4, Lcom/sun/mail/iap/Argument;

    invoke-direct {v4}, Lcom/sun/mail/iap/Argument;-><init>()V

    .line 253
    invoke-virtual {p0}, Ljavax/mail/search/FlagTerm;->getFlags()Ljavax/mail/Flags;

    move-result-object v0

    .line 254
    invoke-virtual {v0}, Ljavax/mail/Flags;->getSystemFlags()[Ljavax/mail/Flags$Flag;

    move-result-object v5

    .line 255
    invoke-virtual {v0}, Ljavax/mail/Flags;->getUserFlags()[Ljava/lang/String;

    move-result-object v6

    .line 256
    array-length v0, v5

    if-nez v0, :cond_0

    array-length v0, v6

    if-nez v0, :cond_0

    .line 257
    new-instance v0, Ljavax/mail/search/SearchException;

    const-string v1, "Invalid FlagTerm"

    invoke-direct {v0, v1}, Ljavax/mail/search/SearchException;-><init>(Ljava/lang/String;)V

    throw v0

    :cond_0
    move v0, v1

    .line 259
    :goto_0
    array-length v2, v5

    if-lt v0, v2, :cond_1

    .line 274
    :goto_1
    array-length v0, v6

    if-lt v1, v0, :cond_e

    .line 279
    return-object v4

    .line 260
    :cond_1
    aget-object v2, v5, v0

    sget-object v7, Ljavax/mail/Flags$Flag;->DELETED:Ljavax/mail/Flags$Flag;

    if-ne v2, v7, :cond_4

    .line 261
    if-eqz v3, :cond_3

    const-string v2, "DELETED"

    :goto_2
    invoke-virtual {v4, v2}, Lcom/sun/mail/iap/Argument;->writeAtom(Ljava/lang/String;)V

    .line 259
    :cond_2
    :goto_3
    add-int/lit8 v0, v0, 0x1

    goto :goto_0

    .line 261
    :cond_3
    const-string v2, "UNDELETED"

    goto :goto_2

    .line 262
    :cond_4
    aget-object v2, v5, v0

    sget-object v7, Ljavax/mail/Flags$Flag;->ANSWERED:Ljavax/mail/Flags$Flag;

    if-ne v2, v7, :cond_6

    .line 263
    if-eqz v3, :cond_5

    const-string v2, "ANSWERED"

    :goto_4
    invoke-virtual {v4, v2}, Lcom/sun/mail/iap/Argument;->writeAtom(Ljava/lang/String;)V

    goto :goto_3

    :cond_5
    const-string v2, "UNANSWERED"

    goto :goto_4

    .line 264
    :cond_6
    aget-object v2, v5, v0

    sget-object v7, Ljavax/mail/Flags$Flag;->DRAFT:Ljavax/mail/Flags$Flag;

    if-ne v2, v7, :cond_8

    .line 265
    if-eqz v3, :cond_7

    const-string v2, "DRAFT"

    :goto_5
    invoke-virtual {v4, v2}, Lcom/sun/mail/iap/Argument;->writeAtom(Ljava/lang/String;)V

    goto :goto_3

    :cond_7
    const-string v2, "UNDRAFT"

    goto :goto_5

    .line 266
    :cond_8
    aget-object v2, v5, v0

    sget-object v7, Ljavax/mail/Flags$Flag;->FLAGGED:Ljavax/mail/Flags$Flag;

    if-ne v2, v7, :cond_a

    .line 267
    if-eqz v3, :cond_9

    const-string v2, "FLAGGED"

    :goto_6
    invoke-virtual {v4, v2}, Lcom/sun/mail/iap/Argument;->writeAtom(Ljava/lang/String;)V

    goto :goto_3

    :cond_9
    const-string v2, "UNFLAGGED"

    goto :goto_6

    .line 268
    :cond_a
    aget-object v2, v5, v0

    sget-object v7, Ljavax/mail/Flags$Flag;->RECENT:Ljavax/mail/Flags$Flag;

    if-ne v2, v7, :cond_c

    .line 269
    if-eqz v3, :cond_b

    const-string v2, "RECENT"

    :goto_7
    invoke-virtual {v4, v2}, Lcom/sun/mail/iap/Argument;->writeAtom(Ljava/lang/String;)V

    goto :goto_3

    :cond_b
    const-string v2, "OLD"

    goto :goto_7

    .line 270
    :cond_c
    aget-object v2, v5, v0

    sget-object v7, Ljavax/mail/Flags$Flag;->SEEN:Ljavax/mail/Flags$Flag;

    if-ne v2, v7, :cond_2

    .line 271
    if-eqz v3, :cond_d

    const-string v2, "SEEN"

    :goto_8
    invoke-virtual {v4, v2}, Lcom/sun/mail/iap/Argument;->writeAtom(Ljava/lang/String;)V

    goto :goto_3

    :cond_d
    const-string v2, "UNSEEN"

    goto :goto_8

    .line 275
    :cond_e
    if-eqz v3, :cond_f

    const-string v0, "KEYWORD"

    :goto_9
    invoke-virtual {v4, v0}, Lcom/sun/mail/iap/Argument;->writeAtom(Ljava/lang/String;)V

    .line 276
    aget-object v0, v6, v1

    invoke-virtual {v4, v0}, Lcom/sun/mail/iap/Argument;->writeAtom(Ljava/lang/String;)V

    .line 274
    add-int/lit8 v1, v1, 0x1

    goto :goto_1

    .line 275
    :cond_f
    const-string v0, "UNKEYWORD"

    goto :goto_9
.end method

.method private static from(Ljava/lang/String;Ljava/lang/String;)Lcom/sun/mail/iap/Argument;
    .locals 2
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljavax/mail/search/SearchException;,
            Ljava/io/IOException;
        }
    .end annotation

    .prologue
    .line 284
    new-instance v0, Lcom/sun/mail/iap/Argument;

    invoke-direct {v0}, Lcom/sun/mail/iap/Argument;-><init>()V

    .line 285
    const-string v1, "FROM"

    invoke-virtual {v0, v1}, Lcom/sun/mail/iap/Argument;->writeAtom(Ljava/lang/String;)V

    .line 286
    invoke-virtual {v0, p0, p1}, Lcom/sun/mail/iap/Argument;->writeString(Ljava/lang/String;Ljava/lang/String;)V

    .line 287
    return-object v0
.end method

.method static generateSequence(Ljavax/mail/search/SearchTerm;Ljava/lang/String;)Lcom/sun/mail/iap/Argument;
    .locals 2
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljavax/mail/search/SearchException;,
            Ljava/io/IOException;
        }
    .end annotation

    .prologue
    .line 66
    instance-of v0, p0, Ljavax/mail/search/AndTerm;

    if-eqz v0, :cond_0

    .line 67
    check-cast p0, Ljavax/mail/search/AndTerm;

    invoke-static {p0, p1}, Lcom/sun/mail/imap/protocol/SearchSequence;->and(Ljavax/mail/search/AndTerm;Ljava/lang/String;)Lcom/sun/mail/iap/Argument;

    move-result-object v0

    .line 107
    :goto_0
    return-object v0

    .line 68
    :cond_0
    instance-of v0, p0, Ljavax/mail/search/OrTerm;

    if-eqz v0, :cond_1

    .line 69
    check-cast p0, Ljavax/mail/search/OrTerm;

    invoke-static {p0, p1}, Lcom/sun/mail/imap/protocol/SearchSequence;->or(Ljavax/mail/search/OrTerm;Ljava/lang/String;)Lcom/sun/mail/iap/Argument;

    move-result-object v0

    goto :goto_0

    .line 70
    :cond_1
    instance-of v0, p0, Ljavax/mail/search/NotTerm;

    if-eqz v0, :cond_2

    .line 71
    check-cast p0, Ljavax/mail/search/NotTerm;

    invoke-static {p0, p1}, Lcom/sun/mail/imap/protocol/SearchSequence;->not(Ljavax/mail/search/NotTerm;Ljava/lang/String;)Lcom/sun/mail/iap/Argument;

    move-result-object v0

    goto :goto_0

    .line 72
    :cond_2
    instance-of v0, p0, Ljavax/mail/search/HeaderTerm;

    if-eqz v0, :cond_3

    .line 73
    check-cast p0, Ljavax/mail/search/HeaderTerm;

    invoke-static {p0, p1}, Lcom/sun/mail/imap/protocol/SearchSequence;->header(Ljavax/mail/search/HeaderTerm;Ljava/lang/String;)Lcom/sun/mail/iap/Argument;

    move-result-object v0

    goto :goto_0

    .line 74
    :cond_3
    instance-of v0, p0, Ljavax/mail/search/FlagTerm;

    if-eqz v0, :cond_4

    .line 75
    check-cast p0, Ljavax/mail/search/FlagTerm;

    invoke-static {p0}, Lcom/sun/mail/imap/protocol/SearchSequence;->flag(Ljavax/mail/search/FlagTerm;)Lcom/sun/mail/iap/Argument;

    move-result-object v0

    goto :goto_0

    .line 76
    :cond_4
    instance-of v0, p0, Ljavax/mail/search/FromTerm;

    if-eqz v0, :cond_5

    .line 77
    check-cast p0, Ljavax/mail/search/FromTerm;

    .line 78
    invoke-virtual {p0}, Ljavax/mail/search/FromTerm;->getAddress()Ljavax/mail/Address;

    move-result-object v0

    invoke-virtual {v0}, Ljavax/mail/Address;->toString()Ljava/lang/String;

    move-result-object v0

    invoke-static {v0, p1}, Lcom/sun/mail/imap/protocol/SearchSequence;->from(Ljava/lang/String;Ljava/lang/String;)Lcom/sun/mail/iap/Argument;

    move-result-object v0

    goto :goto_0

    .line 80
    :cond_5
    instance-of v0, p0, Ljavax/mail/search/FromStringTerm;

    if-eqz v0, :cond_6

    .line 81
    check-cast p0, Ljavax/mail/search/FromStringTerm;

    .line 82
    invoke-virtual {p0}, Ljavax/mail/search/FromStringTerm;->getPattern()Ljava/lang/String;

    move-result-object v0

    invoke-static {v0, p1}, Lcom/sun/mail/imap/protocol/SearchSequence;->from(Ljava/lang/String;Ljava/lang/String;)Lcom/sun/mail/iap/Argument;

    move-result-object v0

    goto :goto_0

    .line 84
    :cond_6
    instance-of v0, p0, Ljavax/mail/search/RecipientTerm;

    if-eqz v0, :cond_7

    .line 85
    check-cast p0, Ljavax/mail/search/RecipientTerm;

    .line 86
    invoke-virtual {p0}, Ljavax/mail/search/RecipientTerm;->getRecipientType()Ljavax/mail/Message$RecipientType;

    move-result-object v0

    .line 87
    invoke-virtual {p0}, Ljavax/mail/search/RecipientTerm;->getAddress()Ljavax/mail/Address;

    move-result-object v1

    invoke-virtual {v1}, Ljavax/mail/Address;->toString()Ljava/lang/String;

    move-result-object v1

    .line 86
    invoke-static {v0, v1, p1}, Lcom/sun/mail/imap/protocol/SearchSequence;->recipient(Ljavax/mail/Message$RecipientType;Ljava/lang/String;Ljava/lang/String;)Lcom/sun/mail/iap/Argument;

    move-result-object v0

    goto :goto_0

    .line 90
    :cond_7
    instance-of v0, p0, Ljavax/mail/search/RecipientStringTerm;

    if-eqz v0, :cond_8

    .line 91
    check-cast p0, Ljavax/mail/search/RecipientStringTerm;

    .line 92
    invoke-virtual {p0}, Ljavax/mail/search/RecipientStringTerm;->getRecipientType()Ljavax/mail/Message$RecipientType;

    move-result-object v0

    .line 93
    invoke-virtual {p0}, Ljavax/mail/search/RecipientStringTerm;->getPattern()Ljava/lang/String;

    move-result-object v1

    .line 92
    invoke-static {v0, v1, p1}, Lcom/sun/mail/imap/protocol/SearchSequence;->recipient(Ljavax/mail/Message$RecipientType;Ljava/lang/String;Ljava/lang/String;)Lcom/sun/mail/iap/Argument;

    move-result-object v0

    goto :goto_0

    .line 96
    :cond_8
    instance-of v0, p0, Ljavax/mail/search/SubjectTerm;

    if-eqz v0, :cond_9

    .line 97
    check-cast p0, Ljavax/mail/search/SubjectTerm;

    invoke-static {p0, p1}, Lcom/sun/mail/imap/protocol/SearchSequence;->subject(Ljavax/mail/search/SubjectTerm;Ljava/lang/String;)Lcom/sun/mail/iap/Argument;

    move-result-object v0

    goto/16 :goto_0

    .line 98
    :cond_9
    instance-of v0, p0, Ljavax/mail/search/BodyTerm;

    if-eqz v0, :cond_a

    .line 99
    check-cast p0, Ljavax/mail/search/BodyTerm;

    invoke-static {p0, p1}, Lcom/sun/mail/imap/protocol/SearchSequence;->body(Ljavax/mail/search/BodyTerm;Ljava/lang/String;)Lcom/sun/mail/iap/Argument;

    move-result-object v0

    goto/16 :goto_0

    .line 100
    :cond_a
    instance-of v0, p0, Ljavax/mail/search/SizeTerm;

    if-eqz v0, :cond_b

    .line 101
    check-cast p0, Ljavax/mail/search/SizeTerm;

    invoke-static {p0}, Lcom/sun/mail/imap/protocol/SearchSequence;->size(Ljavax/mail/search/SizeTerm;)Lcom/sun/mail/iap/Argument;

    move-result-object v0

    goto/16 :goto_0

    .line 102
    :cond_b
    instance-of v0, p0, Ljavax/mail/search/SentDateTerm;

    if-eqz v0, :cond_c

    .line 103
    check-cast p0, Ljavax/mail/search/SentDateTerm;

    invoke-static {p0}, Lcom/sun/mail/imap/protocol/SearchSequence;->sentdate(Ljavax/mail/search/DateTerm;)Lcom/sun/mail/iap/Argument;

    move-result-object v0

    goto/16 :goto_0

    .line 104
    :cond_c
    instance-of v0, p0, Ljavax/mail/search/ReceivedDateTerm;

    if-eqz v0, :cond_d

    .line 105
    check-cast p0, Ljavax/mail/search/ReceivedDateTerm;

    invoke-static {p0}, Lcom/sun/mail/imap/protocol/SearchSequence;->receiveddate(Ljavax/mail/search/DateTerm;)Lcom/sun/mail/iap/Argument;

    move-result-object v0

    goto/16 :goto_0

    .line 106
    :cond_d
    instance-of v0, p0, Ljavax/mail/search/MessageIDTerm;

    if-eqz v0, :cond_e

    .line 107
    check-cast p0, Ljavax/mail/search/MessageIDTerm;

    invoke-static {p0, p1}, Lcom/sun/mail/imap/protocol/SearchSequence;->messageid(Ljavax/mail/search/MessageIDTerm;Ljava/lang/String;)Lcom/sun/mail/iap/Argument;

    move-result-object v0

    goto/16 :goto_0

    .line 109
    :cond_e
    new-instance v0, Ljavax/mail/search/SearchException;

    const-string v1, "Search too complex"

    invoke-direct {v0, v1}, Ljavax/mail/search/SearchException;-><init>(Ljava/lang/String;)V

    throw v0
.end method

.method private static header(Ljavax/mail/search/HeaderTerm;Ljava/lang/String;)Lcom/sun/mail/iap/Argument;
    .locals 2
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljavax/mail/search/SearchException;,
            Ljava/io/IOException;
        }
    .end annotation

    .prologue
    .line 231
    new-instance v0, Lcom/sun/mail/iap/Argument;

    invoke-direct {v0}, Lcom/sun/mail/iap/Argument;-><init>()V

    .line 232
    const-string v1, "HEADER"

    invoke-virtual {v0, v1}, Lcom/sun/mail/iap/Argument;->writeAtom(Ljava/lang/String;)V

    .line 233
    invoke-virtual {p0}, Ljavax/mail/search/HeaderTerm;->getHeaderName()Ljava/lang/String;

    move-result-object v1

    invoke-virtual {v0, v1}, Lcom/sun/mail/iap/Argument;->writeString(Ljava/lang/String;)V

    .line 234
    invoke-virtual {p0}, Ljavax/mail/search/HeaderTerm;->getPattern()Ljava/lang/String;

    move-result-object v1

    invoke-virtual {v0, v1, p1}, Lcom/sun/mail/iap/Argument;->writeString(Ljava/lang/String;Ljava/lang/String;)V

    .line 235
    return-object v0
.end method

.method private static isAscii(Ljava/lang/String;)Z
    .locals 5

    .prologue
    const/4 v0, 0x0

    .line 139
    invoke-virtual {p0}, Ljava/lang/String;->length()I

    move-result v2

    move v1, v0

    .line 141
    :goto_0
    if-lt v1, v2, :cond_1

    .line 145
    const/4 v0, 0x1

    :cond_0
    return v0

    .line 142
    :cond_1
    invoke-virtual {p0, v1}, Ljava/lang/String;->charAt(I)C

    move-result v3

    const/16 v4, 0x7f

    if-gt v3, v4, :cond_0

    .line 141
    add-int/lit8 v1, v1, 0x1

    goto :goto_0
.end method

.method static isAscii(Ljavax/mail/search/SearchTerm;)Z
    .locals 4

    .prologue
    const/4 v2, 0x0

    .line 117
    instance-of v0, p0, Ljavax/mail/search/AndTerm;

    if-nez v0, :cond_0

    instance-of v0, p0, Ljavax/mail/search/OrTerm;

    if-eqz v0, :cond_5

    .line 119
    :cond_0
    instance-of v0, p0, Ljavax/mail/search/AndTerm;

    if-eqz v0, :cond_3

    .line 120
    check-cast p0, Ljavax/mail/search/AndTerm;

    invoke-virtual {p0}, Ljavax/mail/search/AndTerm;->getTerms()[Ljavax/mail/search/SearchTerm;

    move-result-object v0

    :goto_0
    move v1, v2

    .line 124
    :goto_1
    array-length v3, v0

    if-lt v1, v3, :cond_4

    .line 135
    :cond_1
    const/4 v2, 0x1

    :cond_2
    :goto_2
    return v2

    .line 122
    :cond_3
    check-cast p0, Ljavax/mail/search/OrTerm;

    invoke-virtual {p0}, Ljavax/mail/search/OrTerm;->getTerms()[Ljavax/mail/search/SearchTerm;

    move-result-object v0

    goto :goto_0

    .line 125
    :cond_4
    aget-object v3, v0, v1

    invoke-static {v3}, Lcom/sun/mail/imap/protocol/SearchSequence;->isAscii(Ljavax/mail/search/SearchTerm;)Z

    move-result v3

    if-eqz v3, :cond_2

    .line 124
    add-int/lit8 v1, v1, 0x1

    goto :goto_1

    .line 127
    :cond_5
    instance-of v0, p0, Ljavax/mail/search/NotTerm;

    if-eqz v0, :cond_6

    .line 128
    check-cast p0, Ljavax/mail/search/NotTerm;

    invoke-virtual {p0}, Ljavax/mail/search/NotTerm;->getTerm()Ljavax/mail/search/SearchTerm;

    move-result-object v0

    invoke-static {v0}, Lcom/sun/mail/imap/protocol/SearchSequence;->isAscii(Ljavax/mail/search/SearchTerm;)Z

    move-result v2

    goto :goto_2

    .line 129
    :cond_6
    instance-of v0, p0, Ljavax/mail/search/StringTerm;

    if-eqz v0, :cond_7

    .line 130
    check-cast p0, Ljavax/mail/search/StringTerm;

    invoke-virtual {p0}, Ljavax/mail/search/StringTerm;->getPattern()Ljava/lang/String;

    move-result-object v0

    invoke-static {v0}, Lcom/sun/mail/imap/protocol/SearchSequence;->isAscii(Ljava/lang/String;)Z

    move-result v2

    goto :goto_2

    .line 131
    :cond_7
    instance-of v0, p0, Ljavax/mail/search/AddressTerm;

    if-eqz v0, :cond_1

    .line 132
    check-cast p0, Ljavax/mail/search/AddressTerm;

    invoke-virtual {p0}, Ljavax/mail/search/AddressTerm;->getAddress()Ljavax/mail/Address;

    move-result-object v0

    invoke-virtual {v0}, Ljavax/mail/Address;->toString()Ljava/lang/String;

    move-result-object v0

    invoke-static {v0}, Lcom/sun/mail/imap/protocol/SearchSequence;->isAscii(Ljava/lang/String;)Z

    move-result v2

    goto :goto_2
.end method

.method private static messageid(Ljavax/mail/search/MessageIDTerm;Ljava/lang/String;)Lcom/sun/mail/iap/Argument;
    .locals 2
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljavax/mail/search/SearchException;,
            Ljava/io/IOException;
        }
    .end annotation

    .prologue
    .line 240
    new-instance v0, Lcom/sun/mail/iap/Argument;

    invoke-direct {v0}, Lcom/sun/mail/iap/Argument;-><init>()V

    .line 241
    const-string v1, "HEADER"

    invoke-virtual {v0, v1}, Lcom/sun/mail/iap/Argument;->writeAtom(Ljava/lang/String;)V

    .line 242
    const-string v1, "Message-ID"

    invoke-virtual {v0, v1}, Lcom/sun/mail/iap/Argument;->writeString(Ljava/lang/String;)V

    .line 244
    invoke-virtual {p0}, Ljavax/mail/search/MessageIDTerm;->getPattern()Ljava/lang/String;

    move-result-object v1

    invoke-virtual {v0, v1, p1}, Lcom/sun/mail/iap/Argument;->writeString(Ljava/lang/String;Ljava/lang/String;)V

    .line 245
    return-object v0
.end method

.method private static not(Ljavax/mail/search/NotTerm;Ljava/lang/String;)Lcom/sun/mail/iap/Argument;
    .locals 3
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljavax/mail/search/SearchException;,
            Ljava/io/IOException;
        }
    .end annotation

    .prologue
    .line 210
    new-instance v0, Lcom/sun/mail/iap/Argument;

    invoke-direct {v0}, Lcom/sun/mail/iap/Argument;-><init>()V

    .line 213
    const-string v1, "NOT"

    invoke-virtual {v0, v1}, Lcom/sun/mail/iap/Argument;->writeAtom(Ljava/lang/String;)V

    .line 220
    invoke-virtual {p0}, Ljavax/mail/search/NotTerm;->getTerm()Ljavax/mail/search/SearchTerm;

    move-result-object v1

    .line 221
    instance-of v2, v1, Ljavax/mail/search/AndTerm;

    if-nez v2, :cond_0

    instance-of v2, v1, Ljavax/mail/search/FlagTerm;

    if-eqz v2, :cond_1

    .line 222
    :cond_0
    invoke-static {v1, p1}, Lcom/sun/mail/imap/protocol/SearchSequence;->generateSequence(Ljavax/mail/search/SearchTerm;Ljava/lang/String;)Lcom/sun/mail/iap/Argument;

    move-result-object v1

    invoke-virtual {v0, v1}, Lcom/sun/mail/iap/Argument;->writeArgument(Lcom/sun/mail/iap/Argument;)V

    .line 226
    :goto_0
    return-object v0

    .line 224
    :cond_1
    invoke-static {v1, p1}, Lcom/sun/mail/imap/protocol/SearchSequence;->generateSequence(Ljavax/mail/search/SearchTerm;Ljava/lang/String;)Lcom/sun/mail/iap/Argument;

    move-result-object v1

    invoke-virtual {v0, v1}, Lcom/sun/mail/iap/Argument;->append(Lcom/sun/mail/iap/Argument;)V

    goto :goto_0
.end method

.method private static or(Ljavax/mail/search/OrTerm;Ljava/lang/String;)Lcom/sun/mail/iap/Argument;
    .locals 7
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljavax/mail/search/SearchException;,
            Ljava/io/IOException;
        }
    .end annotation

    .prologue
    const/4 v6, 0x0

    const/4 v2, 0x1

    .line 162
    invoke-virtual {p0}, Ljavax/mail/search/OrTerm;->getTerms()[Ljavax/mail/search/SearchTerm;

    move-result-object v4

    .line 168
    array-length v0, v4

    const/4 v1, 0x2

    if-le v0, v1, :cond_7

    .line 169
    aget-object v0, v4, v6

    move v1, v2

    .line 172
    :goto_0
    array-length v3, v4

    if-lt v1, v3, :cond_4

    .line 175
    check-cast v0, Ljavax/mail/search/OrTerm;

    .line 177
    invoke-virtual {v0}, Ljavax/mail/search/OrTerm;->getTerms()[Ljavax/mail/search/SearchTerm;

    move-result-object v0

    .line 181
    :goto_1
    new-instance v1, Lcom/sun/mail/iap/Argument;

    invoke-direct {v1}, Lcom/sun/mail/iap/Argument;-><init>()V

    .line 184
    array-length v3, v0

    if-le v3, v2, :cond_0

    .line 185
    const-string v3, "OR"

    invoke-virtual {v1, v3}, Lcom/sun/mail/iap/Argument;->writeAtom(Ljava/lang/String;)V

    .line 192
    :cond_0
    aget-object v3, v0, v6

    instance-of v3, v3, Ljavax/mail/search/AndTerm;

    if-nez v3, :cond_1

    aget-object v3, v0, v6

    instance-of v3, v3, Ljavax/mail/search/FlagTerm;

    if-eqz v3, :cond_5

    .line 193
    :cond_1
    aget-object v3, v0, v6

    invoke-static {v3, p1}, Lcom/sun/mail/imap/protocol/SearchSequence;->generateSequence(Ljavax/mail/search/SearchTerm;Ljava/lang/String;)Lcom/sun/mail/iap/Argument;

    move-result-object v3

    invoke-virtual {v1, v3}, Lcom/sun/mail/iap/Argument;->writeArgument(Lcom/sun/mail/iap/Argument;)V

    .line 198
    :goto_2
    array-length v3, v0

    if-le v3, v2, :cond_3

    .line 199
    aget-object v3, v0, v2

    instance-of v3, v3, Ljavax/mail/search/AndTerm;

    if-nez v3, :cond_2

    aget-object v3, v0, v2

    instance-of v3, v3, Ljavax/mail/search/FlagTerm;

    if-eqz v3, :cond_6

    .line 200
    :cond_2
    aget-object v0, v0, v2

    invoke-static {v0, p1}, Lcom/sun/mail/imap/protocol/SearchSequence;->generateSequence(Ljavax/mail/search/SearchTerm;Ljava/lang/String;)Lcom/sun/mail/iap/Argument;

    move-result-object v0

    invoke-virtual {v1, v0}, Lcom/sun/mail/iap/Argument;->writeArgument(Lcom/sun/mail/iap/Argument;)V

    .line 205
    :cond_3
    :goto_3
    return-object v1

    .line 173
    :cond_4
    new-instance v3, Ljavax/mail/search/OrTerm;

    aget-object v5, v4, v1

    invoke-direct {v3, v0, v5}, Ljavax/mail/search/OrTerm;-><init>(Ljavax/mail/search/SearchTerm;Ljavax/mail/search/SearchTerm;)V

    .line 172
    add-int/lit8 v0, v1, 0x1

    move v1, v0

    move-object v0, v3

    goto :goto_0

    .line 195
    :cond_5
    aget-object v3, v0, v6

    invoke-static {v3, p1}, Lcom/sun/mail/imap/protocol/SearchSequence;->generateSequence(Ljavax/mail/search/SearchTerm;Ljava/lang/String;)Lcom/sun/mail/iap/Argument;

    move-result-object v3

    invoke-virtual {v1, v3}, Lcom/sun/mail/iap/Argument;->append(Lcom/sun/mail/iap/Argument;)V

    goto :goto_2

    .line 202
    :cond_6
    aget-object v0, v0, v2

    invoke-static {v0, p1}, Lcom/sun/mail/imap/protocol/SearchSequence;->generateSequence(Ljavax/mail/search/SearchTerm;Ljava/lang/String;)Lcom/sun/mail/iap/Argument;

    move-result-object v0

    invoke-virtual {v1, v0}, Lcom/sun/mail/iap/Argument;->append(Lcom/sun/mail/iap/Argument;)V

    goto :goto_3

    :cond_7
    move-object v0, v4

    goto :goto_1
.end method

.method private static receiveddate(Ljavax/mail/search/DateTerm;)Lcom/sun/mail/iap/Argument;
    .locals 4
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljavax/mail/search/SearchException;
        }
    .end annotation

    .prologue
    .line 409
    new-instance v0, Lcom/sun/mail/iap/Argument;

    invoke-direct {v0}, Lcom/sun/mail/iap/Argument;-><init>()V

    .line 410
    invoke-virtual {p0}, Ljavax/mail/search/DateTerm;->getDate()Ljava/util/Date;

    move-result-object v1

    invoke-static {v1}, Lcom/sun/mail/imap/protocol/SearchSequence;->toIMAPDate(Ljava/util/Date;)Ljava/lang/String;

    move-result-object v1

    .line 412
    invoke-virtual {p0}, Ljavax/mail/search/DateTerm;->getComparison()I

    move-result v2

    packed-switch v2, :pswitch_data_0

    .line 432
    new-instance v0, Ljavax/mail/search/SearchException;

    const-string v1, "Cannot handle Date Comparison"

    invoke-direct {v0, v1}, Ljavax/mail/search/SearchException;-><init>(Ljava/lang/String;)V

    throw v0

    .line 414
    :pswitch_0
    new-instance v2, Ljava/lang/StringBuilder;

    const-string v3, "SINCE "

    invoke-direct {v2, v3}, Ljava/lang/StringBuilder;-><init>(Ljava/lang/String;)V

    invoke-virtual {v2, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v1

    invoke-virtual {v0, v1}, Lcom/sun/mail/iap/Argument;->writeAtom(Ljava/lang/String;)V

    .line 435
    :goto_0
    return-object v0

    .line 417
    :pswitch_1
    new-instance v2, Ljava/lang/StringBuilder;

    const-string v3, "ON "

    invoke-direct {v2, v3}, Ljava/lang/StringBuilder;-><init>(Ljava/lang/String;)V

    invoke-virtual {v2, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v1

    invoke-virtual {v0, v1}, Lcom/sun/mail/iap/Argument;->writeAtom(Ljava/lang/String;)V

    goto :goto_0

    .line 420
    :pswitch_2
    new-instance v2, Ljava/lang/StringBuilder;

    const-string v3, "BEFORE "

    invoke-direct {v2, v3}, Ljava/lang/StringBuilder;-><init>(Ljava/lang/String;)V

    invoke-virtual {v2, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v1

    invoke-virtual {v0, v1}, Lcom/sun/mail/iap/Argument;->writeAtom(Ljava/lang/String;)V

    goto :goto_0

    .line 423
    :pswitch_3
    new-instance v2, Ljava/lang/StringBuilder;

    const-string v3, "OR SINCE "

    invoke-direct {v2, v3}, Ljava/lang/StringBuilder;-><init>(Ljava/lang/String;)V

    invoke-virtual {v2, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    const-string v3, " ON "

    invoke-virtual {v2, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    invoke-virtual {v2, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v1

    invoke-virtual {v0, v1}, Lcom/sun/mail/iap/Argument;->writeAtom(Ljava/lang/String;)V

    goto :goto_0

    .line 426
    :pswitch_4
    new-instance v2, Ljava/lang/StringBuilder;

    const-string v3, "OR BEFORE "

    invoke-direct {v2, v3}, Ljava/lang/StringBuilder;-><init>(Ljava/lang/String;)V

    invoke-virtual {v2, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    const-string v3, " ON "

    invoke-virtual {v2, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    invoke-virtual {v2, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v1

    invoke-virtual {v0, v1}, Lcom/sun/mail/iap/Argument;->writeAtom(Ljava/lang/String;)V

    goto :goto_0

    .line 429
    :pswitch_5
    new-instance v2, Ljava/lang/StringBuilder;

    const-string v3, "NOT ON "

    invoke-direct {v2, v3}, Ljava/lang/StringBuilder;-><init>(Ljava/lang/String;)V

    invoke-virtual {v2, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v1

    invoke-virtual {v0, v1}, Lcom/sun/mail/iap/Argument;->writeAtom(Ljava/lang/String;)V

    goto :goto_0

    .line 412
    :pswitch_data_0
    .packed-switch 0x1
        :pswitch_4
        :pswitch_2
        :pswitch_1
        :pswitch_5
        :pswitch_0
        :pswitch_3
    .end packed-switch
.end method

.method private static recipient(Ljavax/mail/Message$RecipientType;Ljava/lang/String;Ljava/lang/String;)Lcom/sun/mail/iap/Argument;
    .locals 2
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljavax/mail/search/SearchException;,
            Ljava/io/IOException;
        }
    .end annotation

    .prologue
    .line 293
    new-instance v0, Lcom/sun/mail/iap/Argument;

    invoke-direct {v0}, Lcom/sun/mail/iap/Argument;-><init>()V

    .line 295
    sget-object v1, Ljavax/mail/Message$RecipientType;->TO:Ljavax/mail/Message$RecipientType;

    if-ne p0, v1, :cond_0

    .line 296
    const-string v1, "TO"

    invoke-virtual {v0, v1}, Lcom/sun/mail/iap/Argument;->writeAtom(Ljava/lang/String;)V

    .line 304
    :goto_0
    invoke-virtual {v0, p1, p2}, Lcom/sun/mail/iap/Argument;->writeString(Ljava/lang/String;Ljava/lang/String;)V

    .line 305
    return-object v0

    .line 297
    :cond_0
    sget-object v1, Ljavax/mail/Message$RecipientType;->CC:Ljavax/mail/Message$RecipientType;

    if-ne p0, v1, :cond_1

    .line 298
    const-string v1, "CC"

    invoke-virtual {v0, v1}, Lcom/sun/mail/iap/Argument;->writeAtom(Ljava/lang/String;)V

    goto :goto_0

    .line 299
    :cond_1
    sget-object v1, Ljavax/mail/Message$RecipientType;->BCC:Ljavax/mail/Message$RecipientType;

    if-ne p0, v1, :cond_2

    .line 300
    const-string v1, "BCC"

    invoke-virtual {v0, v1}, Lcom/sun/mail/iap/Argument;->writeAtom(Ljava/lang/String;)V

    goto :goto_0

    .line 302
    :cond_2
    new-instance v0, Ljavax/mail/search/SearchException;

    const-string v1, "Illegal Recipient type"

    invoke-direct {v0, v1}, Ljavax/mail/search/SearchException;-><init>(Ljava/lang/String;)V

    throw v0
.end method

.method private static sentdate(Ljavax/mail/search/DateTerm;)Lcom/sun/mail/iap/Argument;
    .locals 4
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljavax/mail/search/SearchException;
        }
    .end annotation

    .prologue
    .line 378
    new-instance v0, Lcom/sun/mail/iap/Argument;

    invoke-direct {v0}, Lcom/sun/mail/iap/Argument;-><init>()V

    .line 379
    invoke-virtual {p0}, Ljavax/mail/search/DateTerm;->getDate()Ljava/util/Date;

    move-result-object v1

    invoke-static {v1}, Lcom/sun/mail/imap/protocol/SearchSequence;->toIMAPDate(Ljava/util/Date;)Ljava/lang/String;

    move-result-object v1

    .line 381
    invoke-virtual {p0}, Ljavax/mail/search/DateTerm;->getComparison()I

    move-result v2

    packed-switch v2, :pswitch_data_0

    .line 401
    new-instance v0, Ljavax/mail/search/SearchException;

    const-string v1, "Cannot handle Date Comparison"

    invoke-direct {v0, v1}, Ljavax/mail/search/SearchException;-><init>(Ljava/lang/String;)V

    throw v0

    .line 383
    :pswitch_0
    new-instance v2, Ljava/lang/StringBuilder;

    const-string v3, "SENTSINCE "

    invoke-direct {v2, v3}, Ljava/lang/StringBuilder;-><init>(Ljava/lang/String;)V

    invoke-virtual {v2, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v1

    invoke-virtual {v0, v1}, Lcom/sun/mail/iap/Argument;->writeAtom(Ljava/lang/String;)V

    .line 404
    :goto_0
    return-object v0

    .line 386
    :pswitch_1
    new-instance v2, Ljava/lang/StringBuilder;

    const-string v3, "SENTON "

    invoke-direct {v2, v3}, Ljava/lang/StringBuilder;-><init>(Ljava/lang/String;)V

    invoke-virtual {v2, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v1

    invoke-virtual {v0, v1}, Lcom/sun/mail/iap/Argument;->writeAtom(Ljava/lang/String;)V

    goto :goto_0

    .line 389
    :pswitch_2
    new-instance v2, Ljava/lang/StringBuilder;

    const-string v3, "SENTBEFORE "

    invoke-direct {v2, v3}, Ljava/lang/StringBuilder;-><init>(Ljava/lang/String;)V

    invoke-virtual {v2, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v1

    invoke-virtual {v0, v1}, Lcom/sun/mail/iap/Argument;->writeAtom(Ljava/lang/String;)V

    goto :goto_0

    .line 392
    :pswitch_3
    new-instance v2, Ljava/lang/StringBuilder;

    const-string v3, "OR SENTSINCE "

    invoke-direct {v2, v3}, Ljava/lang/StringBuilder;-><init>(Ljava/lang/String;)V

    invoke-virtual {v2, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    const-string v3, " SENTON "

    invoke-virtual {v2, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    invoke-virtual {v2, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v1

    invoke-virtual {v0, v1}, Lcom/sun/mail/iap/Argument;->writeAtom(Ljava/lang/String;)V

    goto :goto_0

    .line 395
    :pswitch_4
    new-instance v2, Ljava/lang/StringBuilder;

    const-string v3, "OR SENTBEFORE "

    invoke-direct {v2, v3}, Ljava/lang/StringBuilder;-><init>(Ljava/lang/String;)V

    invoke-virtual {v2, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    const-string v3, " SENTON "

    invoke-virtual {v2, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    invoke-virtual {v2, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v1

    invoke-virtual {v0, v1}, Lcom/sun/mail/iap/Argument;->writeAtom(Ljava/lang/String;)V

    goto :goto_0

    .line 398
    :pswitch_5
    new-instance v2, Ljava/lang/StringBuilder;

    const-string v3, "NOT SENTON "

    invoke-direct {v2, v3}, Ljava/lang/StringBuilder;-><init>(Ljava/lang/String;)V

    invoke-virtual {v2, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v1

    invoke-virtual {v0, v1}, Lcom/sun/mail/iap/Argument;->writeAtom(Ljava/lang/String;)V

    goto :goto_0

    .line 381
    :pswitch_data_0
    .packed-switch 0x1
        :pswitch_4
        :pswitch_2
        :pswitch_1
        :pswitch_5
        :pswitch_0
        :pswitch_3
    .end packed-switch
.end method

.method private static size(Ljavax/mail/search/SizeTerm;)Lcom/sun/mail/iap/Argument;
    .locals 2
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljavax/mail/search/SearchException;
        }
    .end annotation

    .prologue
    .line 328
    new-instance v0, Lcom/sun/mail/iap/Argument;

    invoke-direct {v0}, Lcom/sun/mail/iap/Argument;-><init>()V

    .line 330
    invoke-virtual {p0}, Ljavax/mail/search/SizeTerm;->getComparison()I

    move-result v1

    packed-switch v1, :pswitch_data_0

    .line 339
    :pswitch_0
    new-instance v0, Ljavax/mail/search/SearchException;

    const-string v1, "Cannot handle Comparison"

    invoke-direct {v0, v1}, Ljavax/mail/search/SearchException;-><init>(Ljava/lang/String;)V

    throw v0

    .line 332
    :pswitch_1
    const-string v1, "LARGER"

    invoke-virtual {v0, v1}, Lcom/sun/mail/iap/Argument;->writeAtom(Ljava/lang/String;)V

    .line 342
    :goto_0
    invoke-virtual {p0}, Ljavax/mail/search/SizeTerm;->getNumber()I

    move-result v1

    invoke-virtual {v0, v1}, Lcom/sun/mail/iap/Argument;->writeNumber(I)V

    .line 343
    return-object v0

    .line 335
    :pswitch_2
    const-string v1, "SMALLER"

    invoke-virtual {v0, v1}, Lcom/sun/mail/iap/Argument;->writeAtom(Ljava/lang/String;)V

    goto :goto_0

    .line 330
    nop

    :pswitch_data_0
    .packed-switch 0x2
        :pswitch_2
        :pswitch_0
        :pswitch_0
        :pswitch_1
    .end packed-switch
.end method

.method private static subject(Ljavax/mail/search/SubjectTerm;Ljava/lang/String;)Lcom/sun/mail/iap/Argument;
    .locals 2
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljavax/mail/search/SearchException;,
            Ljava/io/IOException;
        }
    .end annotation

    .prologue
    .line 310
    new-instance v0, Lcom/sun/mail/iap/Argument;

    invoke-direct {v0}, Lcom/sun/mail/iap/Argument;-><init>()V

    .line 312
    const-string v1, "SUBJECT"

    invoke-virtual {v0, v1}, Lcom/sun/mail/iap/Argument;->writeAtom(Ljava/lang/String;)V

    .line 313
    invoke-virtual {p0}, Ljavax/mail/search/SubjectTerm;->getPattern()Ljava/lang/String;

    move-result-object v1

    invoke-virtual {v0, v1, p1}, Lcom/sun/mail/iap/Argument;->writeString(Ljava/lang/String;Ljava/lang/String;)V

    .line 314
    return-object v0
.end method

.method private static toIMAPDate(Ljava/util/Date;)Ljava/lang/String;
    .locals 4

    .prologue
    .line 366
    new-instance v0, Ljava/lang/StringBuffer;

    invoke-direct {v0}, Ljava/lang/StringBuffer;-><init>()V

    .line 367
    sget-object v1, Lcom/sun/mail/imap/protocol/SearchSequence;->cal:Ljava/util/Calendar;

    invoke-virtual {v1, p0}, Ljava/util/Calendar;->setTime(Ljava/util/Date;)V

    .line 369
    sget-object v1, Lcom/sun/mail/imap/protocol/SearchSequence;->cal:Ljava/util/Calendar;

    const/4 v2, 0x5

    invoke-virtual {v1, v2}, Ljava/util/Calendar;->get(I)I

    move-result v1

    invoke-virtual {v0, v1}, Ljava/lang/StringBuffer;->append(I)Ljava/lang/StringBuffer;

    move-result-object v1

    const-string v2, "-"

    invoke-virtual {v1, v2}, Ljava/lang/StringBuffer;->append(Ljava/lang/String;)Ljava/lang/StringBuffer;

    .line 370
    sget-object v1, Lcom/sun/mail/imap/protocol/SearchSequence;->monthTable:[Ljava/lang/String;

    sget-object v2, Lcom/sun/mail/imap/protocol/SearchSequence;->cal:Ljava/util/Calendar;

    const/4 v3, 0x2

    invoke-virtual {v2, v3}, Ljava/util/Calendar;->get(I)I

    move-result v2

    aget-object v1, v1, v2

    invoke-virtual {v0, v1}, Ljava/lang/StringBuffer;->append(Ljava/lang/String;)Ljava/lang/StringBuffer;

    move-result-object v1

    const/16 v2, 0x2d

    invoke-virtual {v1, v2}, Ljava/lang/StringBuffer;->append(C)Ljava/lang/StringBuffer;

    .line 371
    sget-object v1, Lcom/sun/mail/imap/protocol/SearchSequence;->cal:Ljava/util/Calendar;

    const/4 v2, 0x1

    invoke-virtual {v1, v2}, Ljava/util/Calendar;->get(I)I

    move-result v1

    invoke-virtual {v0, v1}, Ljava/lang/StringBuffer;->append(I)Ljava/lang/StringBuffer;

    .line 373
    invoke-virtual {v0}, Ljava/lang/StringBuffer;->toString()Ljava/lang/String;

    move-result-object v0

    return-object v0
.end method
