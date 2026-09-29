.class public Lcom/sun/mail/imap/protocol/INTERNALDATE;
.super Ljava/lang/Object;
.source "SourceFile"

# interfaces
.implements Lcom/sun/mail/imap/protocol/Item;


# static fields
.field private static df:Ljava/text/SimpleDateFormat;

.field private static mailDateFormat:Ljavax/mail/internet/MailDateFormat;

.field static final name:[C


# instance fields
.field protected date:Ljava/util/Date;

.field public msgno:I


# direct methods
.method static constructor <clinit>()V
    .locals 3

    .prologue
    .line 65
    const/16 v0, 0xc

    new-array v0, v0, [C

    fill-array-data v0, :array_0

    .line 64
    sput-object v0, Lcom/sun/mail/imap/protocol/INTERNALDATE;->name:[C

    .line 76
    new-instance v0, Ljavax/mail/internet/MailDateFormat;

    invoke-direct {v0}, Ljavax/mail/internet/MailDateFormat;-><init>()V

    sput-object v0, Lcom/sun/mail/imap/protocol/INTERNALDATE;->mailDateFormat:Ljavax/mail/internet/MailDateFormat;

    .line 103
    new-instance v0, Ljava/text/SimpleDateFormat;

    const-string v1, "dd-MMM-yyyy HH:mm:ss "

    sget-object v2, Ljava/util/Locale;->US:Ljava/util/Locale;

    invoke-direct {v0, v1, v2}, Ljava/text/SimpleDateFormat;-><init>(Ljava/lang/String;Ljava/util/Locale;)V

    .line 100
    sput-object v0, Lcom/sun/mail/imap/protocol/INTERNALDATE;->df:Ljava/text/SimpleDateFormat;

    .line 62
    return-void

    .line 65
    :array_0
    .array-data 2
        0x49s
        0x4es
        0x54s
        0x45s
        0x52s
        0x4es
        0x41s
        0x4cs
        0x44s
        0x41s
        0x54s
        0x45s
    .end array-data
.end method

.method public constructor <init>(Lcom/sun/mail/imap/protocol/FetchResponse;)V
    .locals 2
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Lcom/sun/mail/iap/ParsingException;
        }
    .end annotation

    .prologue
    .line 81
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    .line 82
    invoke-virtual {p1}, Lcom/sun/mail/imap/protocol/FetchResponse;->getNumber()I

    move-result v0

    iput v0, p0, Lcom/sun/mail/imap/protocol/INTERNALDATE;->msgno:I

    .line 83
    invoke-virtual {p1}, Lcom/sun/mail/imap/protocol/FetchResponse;->skipSpaces()V

    .line 84
    invoke-virtual {p1}, Lcom/sun/mail/imap/protocol/FetchResponse;->readString()Ljava/lang/String;

    move-result-object v0

    .line 85
    if-nez v0, :cond_0

    .line 86
    new-instance v0, Lcom/sun/mail/iap/ParsingException;

    const-string v1, "INTERNALDATE is NIL"

    invoke-direct {v0, v1}, Lcom/sun/mail/iap/ParsingException;-><init>(Ljava/lang/String;)V

    throw v0

    .line 88
    :cond_0
    :try_start_0
    sget-object v1, Lcom/sun/mail/imap/protocol/INTERNALDATE;->mailDateFormat:Ljavax/mail/internet/MailDateFormat;

    invoke-virtual {v1, v0}, Ljavax/mail/internet/MailDateFormat;->parse(Ljava/lang/String;)Ljava/util/Date;

    move-result-object v0

    iput-object v0, p0, Lcom/sun/mail/imap/protocol/INTERNALDATE;->date:Ljava/util/Date;
    :try_end_0
    .catch Ljava/text/ParseException; {:try_start_0 .. :try_end_0} :catch_0

    .line 92
    return-void

    .line 89
    :catch_0
    move-exception v0

    .line 90
    new-instance v0, Lcom/sun/mail/iap/ParsingException;

    const-string v1, "INTERNALDATE parse error"

    invoke-direct {v0, v1}, Lcom/sun/mail/iap/ParsingException;-><init>(Ljava/lang/String;)V

    throw v0
.end method

.method public static format(Ljava/util/Date;)Ljava/lang/String;
    .locals 6

    .prologue
    const/16 v5, 0xa

    .line 120
    new-instance v1, Ljava/lang/StringBuffer;

    invoke-direct {v1}, Ljava/lang/StringBuffer;-><init>()V

    .line 121
    sget-object v2, Lcom/sun/mail/imap/protocol/INTERNALDATE;->df:Ljava/text/SimpleDateFormat;

    monitor-enter v2

    .line 122
    :try_start_0
    sget-object v0, Lcom/sun/mail/imap/protocol/INTERNALDATE;->df:Ljava/text/SimpleDateFormat;

    new-instance v3, Ljava/text/FieldPosition;

    const/4 v4, 0x0

    invoke-direct {v3, v4}, Ljava/text/FieldPosition;-><init>(I)V

    invoke-virtual {v0, p0, v1, v3}, Ljava/text/SimpleDateFormat;->format(Ljava/util/Date;Ljava/lang/StringBuffer;Ljava/text/FieldPosition;)Ljava/lang/StringBuffer;

    .line 121
    monitor-exit v2
    :try_end_0
    .catchall {:try_start_0 .. :try_end_0} :catchall_0

    .line 127
    invoke-virtual {p0}, Ljava/util/Date;->getTimezoneOffset()I

    move-result v0

    neg-int v0, v0

    .line 135
    if-gez v0, :cond_0

    .line 136
    const/16 v2, 0x2d

    invoke-virtual {v1, v2}, Ljava/lang/StringBuffer;->append(C)Ljava/lang/StringBuffer;

    .line 137
    neg-int v0, v0

    .line 141
    :goto_0
    div-int/lit8 v2, v0, 0x3c

    .line 142
    rem-int/lit8 v0, v0, 0x3c

    .line 144
    div-int/lit8 v3, v2, 0xa

    invoke-static {v3, v5}, Ljava/lang/Character;->forDigit(II)C

    move-result v3

    invoke-virtual {v1, v3}, Ljava/lang/StringBuffer;->append(C)Ljava/lang/StringBuffer;

    .line 145
    rem-int/lit8 v2, v2, 0xa

    invoke-static {v2, v5}, Ljava/lang/Character;->forDigit(II)C

    move-result v2

    invoke-virtual {v1, v2}, Ljava/lang/StringBuffer;->append(C)Ljava/lang/StringBuffer;

    .line 146
    div-int/lit8 v2, v0, 0xa

    invoke-static {v2, v5}, Ljava/lang/Character;->forDigit(II)C

    move-result v2

    invoke-virtual {v1, v2}, Ljava/lang/StringBuffer;->append(C)Ljava/lang/StringBuffer;

    .line 147
    rem-int/lit8 v0, v0, 0xa

    invoke-static {v0, v5}, Ljava/lang/Character;->forDigit(II)C

    move-result v0

    invoke-virtual {v1, v0}, Ljava/lang/StringBuffer;->append(C)Ljava/lang/StringBuffer;

    .line 149
    invoke-virtual {v1}, Ljava/lang/StringBuffer;->toString()Ljava/lang/String;

    move-result-object v0

    return-object v0

    .line 121
    :catchall_0
    move-exception v0

    :try_start_1
    monitor-exit v2
    :try_end_1
    .catchall {:try_start_1 .. :try_end_1} :catchall_0

    throw v0

    .line 139
    :cond_0
    const/16 v2, 0x2b

    invoke-virtual {v1, v2}, Ljava/lang/StringBuffer;->append(C)Ljava/lang/StringBuffer;

    goto :goto_0
.end method


# virtual methods
.method public getDate()Ljava/util/Date;
    .locals 1

    .prologue
    .line 95
    iget-object v0, p0, Lcom/sun/mail/imap/protocol/INTERNALDATE;->date:Ljava/util/Date;

    return-object v0
.end method
