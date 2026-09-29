.class public Lcom/sun/mail/util/CRLFOutputStream;
.super Ljava/io/FilterOutputStream;
.source "SourceFile"


# static fields
.field private static final newline:[B


# instance fields
.field protected atBOL:Z

.field protected lastb:I


# direct methods
.method static constructor <clinit>()V
    .locals 1

    .prologue
    .line 55
    const/4 v0, 0x2

    new-array v0, v0, [B

    fill-array-data v0, :array_0

    sput-object v0, Lcom/sun/mail/util/CRLFOutputStream;->newline:[B

    .line 52
    return-void

    .line 55
    nop

    :array_0
    .array-data 1
        0xdt
        0xat
    .end array-data
.end method

.method public constructor <init>(Ljava/io/OutputStream;)V
    .locals 1

    .prologue
    .line 58
    invoke-direct {p0, p1}, Ljava/io/FilterOutputStream;-><init>(Ljava/io/OutputStream;)V

    .line 53
    const/4 v0, -0x1

    iput v0, p0, Lcom/sun/mail/util/CRLFOutputStream;->lastb:I

    .line 54
    const/4 v0, 0x1

    iput-boolean v0, p0, Lcom/sun/mail/util/CRLFOutputStream;->atBOL:Z

    .line 59
    return-void
.end method


# virtual methods
.method public write(I)V
    .locals 2
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljava/io/IOException;
        }
    .end annotation

    .prologue
    const/16 v1, 0xd

    .line 62
    if-ne p1, v1, :cond_1

    .line 63
    invoke-virtual {p0}, Lcom/sun/mail/util/CRLFOutputStream;->writeln()V

    .line 71
    :cond_0
    :goto_0
    iput p1, p0, Lcom/sun/mail/util/CRLFOutputStream;->lastb:I

    .line 72
    return-void

    .line 64
    :cond_1
    const/16 v0, 0xa

    if-ne p1, v0, :cond_2

    .line 65
    iget v0, p0, Lcom/sun/mail/util/CRLFOutputStream;->lastb:I

    if-eq v0, v1, :cond_0

    .line 66
    invoke-virtual {p0}, Lcom/sun/mail/util/CRLFOutputStream;->writeln()V

    goto :goto_0

    .line 68
    :cond_2
    iget-object v0, p0, Lcom/sun/mail/util/CRLFOutputStream;->out:Ljava/io/OutputStream;

    invoke-virtual {v0, p1}, Ljava/io/OutputStream;->write(I)V

    .line 69
    const/4 v0, 0x0

    iput-boolean v0, p0, Lcom/sun/mail/util/CRLFOutputStream;->atBOL:Z

    goto :goto_0
.end method

.method public write([B)V
    .locals 2
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljava/io/IOException;
        }
    .end annotation

    .prologue
    .line 75
    const/4 v0, 0x0

    array-length v1, p1

    invoke-virtual {p0, p1, v0, v1}, Lcom/sun/mail/util/CRLFOutputStream;->write([BII)V

    .line 76
    return-void
.end method

.method public write([BII)V
    .locals 5
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljava/io/IOException;
        }
    .end annotation

    .prologue
    const/16 v4, 0xd

    .line 79
    .line 81
    add-int v1, p3, p2

    move v0, p2

    .line 82
    :goto_0
    if-lt p2, v1, :cond_1

    .line 96
    sub-int v2, v1, v0

    if-lez v2, :cond_0

    .line 97
    iget-object v2, p0, Lcom/sun/mail/util/CRLFOutputStream;->out:Ljava/io/OutputStream;

    sub-int/2addr v1, v0

    invoke-virtual {v2, p1, v0, v1}, Ljava/io/OutputStream;->write([BII)V

    .line 98
    const/4 v0, 0x0

    iput-boolean v0, p0, Lcom/sun/mail/util/CRLFOutputStream;->atBOL:Z

    .line 100
    :cond_0
    return-void

    .line 83
    :cond_1
    aget-byte v2, p1, p2

    if-ne v2, v4, :cond_3

    .line 84
    iget-object v2, p0, Lcom/sun/mail/util/CRLFOutputStream;->out:Ljava/io/OutputStream;

    sub-int v3, p2, v0

    invoke-virtual {v2, p1, v0, v3}, Ljava/io/OutputStream;->write([BII)V

    .line 85
    invoke-virtual {p0}, Lcom/sun/mail/util/CRLFOutputStream;->writeln()V

    .line 86
    add-int/lit8 v0, p2, 0x1

    .line 94
    :cond_2
    :goto_1
    aget-byte v2, p1, p2

    iput v2, p0, Lcom/sun/mail/util/CRLFOutputStream;->lastb:I

    .line 82
    add-int/lit8 p2, p2, 0x1

    goto :goto_0

    .line 87
    :cond_3
    aget-byte v2, p1, p2

    const/16 v3, 0xa

    if-ne v2, v3, :cond_2

    .line 88
    iget v2, p0, Lcom/sun/mail/util/CRLFOutputStream;->lastb:I

    if-eq v2, v4, :cond_4

    .line 89
    iget-object v2, p0, Lcom/sun/mail/util/CRLFOutputStream;->out:Ljava/io/OutputStream;

    sub-int v3, p2, v0

    invoke-virtual {v2, p1, v0, v3}, Ljava/io/OutputStream;->write([BII)V

    .line 90
    invoke-virtual {p0}, Lcom/sun/mail/util/CRLFOutputStream;->writeln()V

    .line 92
    :cond_4
    add-int/lit8 v0, p2, 0x1

    goto :goto_1
.end method

.method public writeln()V
    .locals 2
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljava/io/IOException;
        }
    .end annotation

    .prologue
    .line 106
    iget-object v0, p0, Lcom/sun/mail/util/CRLFOutputStream;->out:Ljava/io/OutputStream;

    sget-object v1, Lcom/sun/mail/util/CRLFOutputStream;->newline:[B

    invoke-virtual {v0, v1}, Ljava/io/OutputStream;->write([B)V

    .line 107
    const/4 v0, 0x1

    iput-boolean v0, p0, Lcom/sun/mail/util/CRLFOutputStream;->atBOL:Z

    .line 108
    return-void
.end method
