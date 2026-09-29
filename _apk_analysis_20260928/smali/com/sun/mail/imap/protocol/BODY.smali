.class public Lcom/sun/mail/imap/protocol/BODY;
.super Ljava/lang/Object;
.source "SourceFile"

# interfaces
.implements Lcom/sun/mail/imap/protocol/Item;


# static fields
.field static final name:[C


# instance fields
.field public data:Lcom/sun/mail/iap/ByteArray;

.field public msgno:I

.field public origin:I

.field public section:Ljava/lang/String;


# direct methods
.method static constructor <clinit>()V
    .locals 1

    .prologue
    .line 56
    const/4 v0, 0x4

    new-array v0, v0, [C

    fill-array-data v0, :array_0

    sput-object v0, Lcom/sun/mail/imap/protocol/BODY;->name:[C

    .line 54
    return-void

    .line 56
    nop

    :array_0
    .array-data 2
        0x42s
        0x4fs
        0x44s
        0x59s
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
    .line 66
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    .line 61
    const/4 v0, 0x0

    iput v0, p0, Lcom/sun/mail/imap/protocol/BODY;->origin:I

    .line 67
    invoke-virtual {p1}, Lcom/sun/mail/imap/protocol/FetchResponse;->getNumber()I

    move-result v0

    iput v0, p0, Lcom/sun/mail/imap/protocol/BODY;->msgno:I

    .line 69
    invoke-virtual {p1}, Lcom/sun/mail/imap/protocol/FetchResponse;->skipSpaces()V

    .line 72
    :cond_0
    invoke-virtual {p1}, Lcom/sun/mail/imap/protocol/FetchResponse;->readByte()B

    move-result v0

    const/16 v1, 0x5d

    if-ne v0, v1, :cond_2

    .line 79
    invoke-virtual {p1}, Lcom/sun/mail/imap/protocol/FetchResponse;->readByte()B

    move-result v0

    const/16 v1, 0x3c

    if-ne v0, v1, :cond_1

    .line 80
    invoke-virtual {p1}, Lcom/sun/mail/imap/protocol/FetchResponse;->readNumber()I

    move-result v0

    iput v0, p0, Lcom/sun/mail/imap/protocol/BODY;->origin:I

    .line 81
    const/4 v0, 0x1

    invoke-virtual {p1, v0}, Lcom/sun/mail/imap/protocol/FetchResponse;->skip(I)V

    .line 84
    :cond_1
    invoke-virtual {p1}, Lcom/sun/mail/imap/protocol/FetchResponse;->readByteArray()Lcom/sun/mail/iap/ByteArray;

    move-result-object v0

    iput-object v0, p0, Lcom/sun/mail/imap/protocol/BODY;->data:Lcom/sun/mail/iap/ByteArray;

    .line 85
    return-void

    .line 73
    :cond_2
    if-nez v0, :cond_0

    .line 74
    new-instance v0, Lcom/sun/mail/iap/ParsingException;

    .line 75
    const-string v1, "BODY parse error: missing ``]\'\' at section end"

    .line 74
    invoke-direct {v0, v1}, Lcom/sun/mail/iap/ParsingException;-><init>(Ljava/lang/String;)V

    throw v0
.end method


# virtual methods
.method public getByteArray()Lcom/sun/mail/iap/ByteArray;
    .locals 1

    .prologue
    .line 88
    iget-object v0, p0, Lcom/sun/mail/imap/protocol/BODY;->data:Lcom/sun/mail/iap/ByteArray;

    return-object v0
.end method

.method public getByteArrayInputStream()Ljava/io/ByteArrayInputStream;
    .locals 1

    .prologue
    .line 92
    iget-object v0, p0, Lcom/sun/mail/imap/protocol/BODY;->data:Lcom/sun/mail/iap/ByteArray;

    if-eqz v0, :cond_0

    .line 93
    iget-object v0, p0, Lcom/sun/mail/imap/protocol/BODY;->data:Lcom/sun/mail/iap/ByteArray;

    invoke-virtual {v0}, Lcom/sun/mail/iap/ByteArray;->toByteArrayInputStream()Ljava/io/ByteArrayInputStream;

    move-result-object v0

    .line 95
    :goto_0
    return-object v0

    :cond_0
    const/4 v0, 0x0

    goto :goto_0
.end method
