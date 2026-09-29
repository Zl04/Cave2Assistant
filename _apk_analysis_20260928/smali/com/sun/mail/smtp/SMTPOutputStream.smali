.class public Lcom/sun/mail/smtp/SMTPOutputStream;
.super Lcom/sun/mail/util/CRLFOutputStream;
.source "SourceFile"


# direct methods
.method public constructor <init>(Ljava/io/OutputStream;)V
    .locals 0

    .prologue
    .line 57
    invoke-direct {p0, p1}, Lcom/sun/mail/util/CRLFOutputStream;-><init>(Ljava/io/OutputStream;)V

    .line 58
    return-void
.end method


# virtual methods
.method public ensureAtBOL()V
    .locals 1
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljava/io/IOException;
        }
    .end annotation

    .prologue
    .line 111
    iget-boolean v0, p0, Lcom/sun/mail/smtp/SMTPOutputStream;->atBOL:Z

    if-nez v0, :cond_0

    .line 112
    invoke-super {p0}, Lcom/sun/mail/util/CRLFOutputStream;->writeln()V

    .line 113
    :cond_0
    return-void
.end method

.method public flush()V
    .locals 0

    .prologue
    .line 104
    return-void
.end method

.method public write(I)V
    .locals 3
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljava/io/IOException;
        }
    .end annotation

    .prologue
    const/16 v2, 0x2e

    .line 63
    iget v0, p0, Lcom/sun/mail/smtp/SMTPOutputStream;->lastb:I

    const/16 v1, 0xa

    if-eq v0, v1, :cond_0

    iget v0, p0, Lcom/sun/mail/smtp/SMTPOutputStream;->lastb:I

    const/16 v1, 0xd

    if-eq v0, v1, :cond_0

    iget v0, p0, Lcom/sun/mail/smtp/SMTPOutputStream;->lastb:I

    const/4 v1, -0x1

    if-ne v0, v1, :cond_1

    :cond_0
    if-ne p1, v2, :cond_1

    .line 64
    iget-object v0, p0, Lcom/sun/mail/smtp/SMTPOutputStream;->out:Ljava/io/OutputStream;

    invoke-virtual {v0, v2}, Ljava/io/OutputStream;->write(I)V

    .line 67
    :cond_1
    invoke-super {p0, p1}, Lcom/sun/mail/util/CRLFOutputStream;->write(I)V

    .line 68
    return-void
.end method

.method public write([BII)V
    .locals 7
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljava/io/IOException;
        }
    .end annotation

    .prologue
    const/16 v6, 0x2e

    const/16 v1, 0xa

    .line 74
    iget v0, p0, Lcom/sun/mail/smtp/SMTPOutputStream;->lastb:I

    const/4 v2, -0x1

    if-ne v0, v2, :cond_1

    move v0, v1

    .line 77
    :goto_0
    add-int v4, p3, p2

    move v2, p2

    move v3, v0

    move v0, p2

    .line 78
    :goto_1
    if-lt v2, v4, :cond_2

    .line 86
    sub-int v1, v4, v0

    if-lez v1, :cond_0

    .line 87
    sub-int v1, v4, v0

    invoke-super {p0, p1, v0, v1}, Lcom/sun/mail/util/CRLFOutputStream;->write([BII)V

    .line 88
    :cond_0
    return-void

    .line 74
    :cond_1
    iget v0, p0, Lcom/sun/mail/smtp/SMTPOutputStream;->lastb:I

    goto :goto_0

    .line 79
    :cond_2
    if-eq v3, v1, :cond_3

    const/16 v5, 0xd

    if-ne v3, v5, :cond_4

    :cond_3
    aget-byte v3, p1, v2

    if-ne v3, v6, :cond_4

    .line 80
    sub-int v3, v2, v0

    invoke-super {p0, p1, v0, v3}, Lcom/sun/mail/util/CRLFOutputStream;->write([BII)V

    .line 81
    iget-object v0, p0, Lcom/sun/mail/smtp/SMTPOutputStream;->out:Ljava/io/OutputStream;

    invoke-virtual {v0, v6}, Ljava/io/OutputStream;->write(I)V

    move v0, v2

    .line 84
    :cond_4
    aget-byte v3, p1, v2

    .line 78
    add-int/lit8 v2, v2, 0x1

    goto :goto_1
.end method
