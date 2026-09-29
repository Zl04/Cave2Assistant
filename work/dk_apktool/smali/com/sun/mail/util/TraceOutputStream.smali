.class public Lcom/sun/mail/util/TraceOutputStream;
.super Ljava/io/FilterOutputStream;
.source "SourceFile"


# instance fields
.field private quote:Z

.field private trace:Z

.field private traceOut:Ljava/io/OutputStream;


# direct methods
.method public constructor <init>(Ljava/io/OutputStream;Ljava/io/OutputStream;)V
    .locals 1

    .prologue
    const/4 v0, 0x0

    .line 67
    invoke-direct {p0, p1}, Ljava/io/FilterOutputStream;-><init>(Ljava/io/OutputStream;)V

    .line 55
    iput-boolean v0, p0, Lcom/sun/mail/util/TraceOutputStream;->trace:Z

    .line 56
    iput-boolean v0, p0, Lcom/sun/mail/util/TraceOutputStream;->quote:Z

    .line 68
    iput-object p2, p0, Lcom/sun/mail/util/TraceOutputStream;->traceOut:Ljava/io/OutputStream;

    .line 69
    return-void
.end method

.method private final writeByte(I)V
    .locals 5
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljava/io/IOException;
        }
    .end annotation

    .prologue
    const/16 v4, 0xa

    const/16 v3, 0x5c

    .line 121
    and-int/lit16 v0, p1, 0xff

    .line 122
    const/16 v1, 0x7f

    if-le v0, v1, :cond_0

    .line 123
    iget-object v1, p0, Lcom/sun/mail/util/TraceOutputStream;->traceOut:Ljava/io/OutputStream;

    const/16 v2, 0x4d

    invoke-virtual {v1, v2}, Ljava/io/OutputStream;->write(I)V

    .line 124
    iget-object v1, p0, Lcom/sun/mail/util/TraceOutputStream;->traceOut:Ljava/io/OutputStream;

    const/16 v2, 0x2d

    invoke-virtual {v1, v2}, Ljava/io/OutputStream;->write(I)V

    .line 125
    and-int/lit8 v0, v0, 0x7f

    .line 127
    :cond_0
    const/16 v1, 0xd

    if-ne v0, v1, :cond_1

    .line 128
    iget-object v0, p0, Lcom/sun/mail/util/TraceOutputStream;->traceOut:Ljava/io/OutputStream;

    invoke-virtual {v0, v3}, Ljava/io/OutputStream;->write(I)V

    .line 129
    iget-object v0, p0, Lcom/sun/mail/util/TraceOutputStream;->traceOut:Ljava/io/OutputStream;

    const/16 v1, 0x72

    invoke-virtual {v0, v1}, Ljava/io/OutputStream;->write(I)V

    .line 143
    :goto_0
    return-void

    .line 130
    :cond_1
    if-ne v0, v4, :cond_2

    .line 131
    iget-object v0, p0, Lcom/sun/mail/util/TraceOutputStream;->traceOut:Ljava/io/OutputStream;

    invoke-virtual {v0, v3}, Ljava/io/OutputStream;->write(I)V

    .line 132
    iget-object v0, p0, Lcom/sun/mail/util/TraceOutputStream;->traceOut:Ljava/io/OutputStream;

    const/16 v1, 0x6e

    invoke-virtual {v0, v1}, Ljava/io/OutputStream;->write(I)V

    .line 133
    iget-object v0, p0, Lcom/sun/mail/util/TraceOutputStream;->traceOut:Ljava/io/OutputStream;

    invoke-virtual {v0, v4}, Ljava/io/OutputStream;->write(I)V

    goto :goto_0

    .line 134
    :cond_2
    const/16 v1, 0x9

    if-ne v0, v1, :cond_3

    .line 135
    iget-object v0, p0, Lcom/sun/mail/util/TraceOutputStream;->traceOut:Ljava/io/OutputStream;

    invoke-virtual {v0, v3}, Ljava/io/OutputStream;->write(I)V

    .line 136
    iget-object v0, p0, Lcom/sun/mail/util/TraceOutputStream;->traceOut:Ljava/io/OutputStream;

    const/16 v1, 0x74

    invoke-virtual {v0, v1}, Ljava/io/OutputStream;->write(I)V

    goto :goto_0

    .line 137
    :cond_3
    const/16 v1, 0x20

    if-ge v0, v1, :cond_4

    .line 138
    iget-object v1, p0, Lcom/sun/mail/util/TraceOutputStream;->traceOut:Ljava/io/OutputStream;

    const/16 v2, 0x5e

    invoke-virtual {v1, v2}, Ljava/io/OutputStream;->write(I)V

    .line 139
    iget-object v1, p0, Lcom/sun/mail/util/TraceOutputStream;->traceOut:Ljava/io/OutputStream;

    add-int/lit8 v0, v0, 0x40

    invoke-virtual {v1, v0}, Ljava/io/OutputStream;->write(I)V

    goto :goto_0

    .line 141
    :cond_4
    iget-object v1, p0, Lcom/sun/mail/util/TraceOutputStream;->traceOut:Ljava/io/OutputStream;

    invoke-virtual {v1, v0}, Ljava/io/OutputStream;->write(I)V

    goto :goto_0
.end method


# virtual methods
.method public setQuote(Z)V
    .locals 0

    .prologue
    .line 83
    iput-boolean p1, p0, Lcom/sun/mail/util/TraceOutputStream;->quote:Z

    .line 84
    return-void
.end method

.method public setTrace(Z)V
    .locals 0

    .prologue
    .line 75
    iput-boolean p1, p0, Lcom/sun/mail/util/TraceOutputStream;->trace:Z

    .line 76
    return-void
.end method

.method public write(I)V
    .locals 1
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljava/io/IOException;
        }
    .end annotation

    .prologue
    .line 92
    iget-boolean v0, p0, Lcom/sun/mail/util/TraceOutputStream;->trace:Z

    if-eqz v0, :cond_0

    .line 93
    iget-boolean v0, p0, Lcom/sun/mail/util/TraceOutputStream;->quote:Z

    if-eqz v0, :cond_1

    .line 94
    invoke-direct {p0, p1}, Lcom/sun/mail/util/TraceOutputStream;->writeByte(I)V

    .line 98
    :cond_0
    :goto_0
    iget-object v0, p0, Lcom/sun/mail/util/TraceOutputStream;->out:Ljava/io/OutputStream;

    invoke-virtual {v0, p1}, Ljava/io/OutputStream;->write(I)V

    .line 99
    return-void

    .line 96
    :cond_1
    iget-object v0, p0, Lcom/sun/mail/util/TraceOutputStream;->traceOut:Ljava/io/OutputStream;

    invoke-virtual {v0, p1}, Ljava/io/OutputStream;->write(I)V

    goto :goto_0
.end method

.method public write([BII)V
    .locals 2
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljava/io/IOException;
        }
    .end annotation

    .prologue
    .line 107
    iget-boolean v0, p0, Lcom/sun/mail/util/TraceOutputStream;->trace:Z

    if-eqz v0, :cond_0

    .line 108
    iget-boolean v0, p0, Lcom/sun/mail/util/TraceOutputStream;->quote:Z

    if-eqz v0, :cond_2

    .line 109
    const/4 v0, 0x0

    :goto_0
    if-lt v0, p3, :cond_1

    .line 114
    :cond_0
    :goto_1
    iget-object v0, p0, Lcom/sun/mail/util/TraceOutputStream;->out:Ljava/io/OutputStream;

    invoke-virtual {v0, p1, p2, p3}, Ljava/io/OutputStream;->write([BII)V

    .line 115
    return-void

    .line 110
    :cond_1
    add-int v1, p2, v0

    aget-byte v1, p1, v1

    invoke-direct {p0, v1}, Lcom/sun/mail/util/TraceOutputStream;->writeByte(I)V

    .line 109
    add-int/lit8 v0, v0, 0x1

    goto :goto_0

    .line 112
    :cond_2
    iget-object v0, p0, Lcom/sun/mail/util/TraceOutputStream;->traceOut:Ljava/io/OutputStream;

    invoke-virtual {v0, p1, p2, p3}, Ljava/io/OutputStream;->write([BII)V

    goto :goto_1
.end method
