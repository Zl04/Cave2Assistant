.class public Lcom/sun/mail/util/LineInputStream;
.super Ljava/io/FilterInputStream;
.source "SourceFile"


# instance fields
.field private lineBuffer:[C


# direct methods
.method public constructor <init>(Ljava/io/InputStream;)V
    .locals 1

    .prologue
    .line 63
    invoke-direct {p0, p1}, Ljava/io/FilterInputStream;-><init>(Ljava/io/InputStream;)V

    .line 60
    const/4 v0, 0x0

    iput-object v0, p0, Lcom/sun/mail/util/LineInputStream;->lineBuffer:[C

    .line 64
    return-void
.end method


# virtual methods
.method public readLine()Ljava/lang/String;
    .locals 10
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljava/io/IOException;
        }
    .end annotation

    .prologue
    const/16 v9, 0xd

    const/16 v8, 0xa

    const/4 v7, -0x1

    const/4 v2, 0x0

    .line 78
    iget-object v5, p0, Lcom/sun/mail/util/LineInputStream;->in:Ljava/io/InputStream;

    .line 79
    iget-object v0, p0, Lcom/sun/mail/util/LineInputStream;->lineBuffer:[C

    .line 81
    if-nez v0, :cond_0

    .line 82
    const/16 v0, 0x80

    new-array v0, v0, [C

    iput-object v0, p0, Lcom/sun/mail/util/LineInputStream;->lineBuffer:[C

    .line 85
    :cond_0
    array-length v1, v0

    move-object v3, v0

    move v0, v1

    move v1, v2

    .line 88
    :goto_0
    invoke-virtual {v5}, Ljava/io/InputStream;->read()I

    move-result v6

    if-ne v6, v7, :cond_2

    .line 116
    :cond_1
    :goto_1
    if-ne v6, v7, :cond_4

    if-nez v1, :cond_4

    .line 117
    const/4 v0, 0x0

    .line 119
    :goto_2
    return-object v0

    .line 89
    :cond_2
    if-eq v6, v8, :cond_1

    .line 91
    if-ne v6, v9, :cond_3

    .line 93
    invoke-virtual {v5}, Ljava/io/InputStream;->read()I

    move-result v0

    .line 94
    if-ne v0, v9, :cond_7

    .line 95
    invoke-virtual {v5}, Ljava/io/InputStream;->read()I

    move-result v0

    move v4, v0

    .line 96
    :goto_3
    if-eq v4, v8, :cond_1

    .line 98
    instance-of v0, v5, Ljava/io/PushbackInputStream;

    if-nez v0, :cond_6

    .line 99
    new-instance v0, Ljava/io/PushbackInputStream;

    invoke-direct {v0, v5}, Ljava/io/PushbackInputStream;-><init>(Ljava/io/InputStream;)V

    iput-object v0, p0, Lcom/sun/mail/util/LineInputStream;->in:Ljava/io/InputStream;

    .line 100
    :goto_4
    check-cast v0, Ljava/io/PushbackInputStream;

    invoke-virtual {v0, v4}, Ljava/io/PushbackInputStream;->unread(I)V

    goto :goto_1

    .line 107
    :cond_3
    add-int/lit8 v0, v0, -0x1

    if-gez v0, :cond_5

    .line 108
    add-int/lit16 v0, v1, 0x80

    new-array v4, v0, [C

    .line 109
    array-length v0, v4

    sub-int/2addr v0, v1

    add-int/lit8 v3, v0, -0x1

    .line 110
    iget-object v0, p0, Lcom/sun/mail/util/LineInputStream;->lineBuffer:[C

    invoke-static {v0, v2, v4, v2, v1}, Ljava/lang/System;->arraycopy(Ljava/lang/Object;ILjava/lang/Object;II)V

    .line 111
    iput-object v4, p0, Lcom/sun/mail/util/LineInputStream;->lineBuffer:[C

    .line 113
    :goto_5
    add-int/lit8 v0, v1, 0x1

    int-to-char v6, v6

    aput-char v6, v4, v1

    move v1, v0

    move v0, v3

    move-object v3, v4

    goto :goto_0

    .line 119
    :cond_4
    invoke-static {v3, v2, v1}, Ljava/lang/String;->copyValueOf([CII)Ljava/lang/String;

    move-result-object v0

    goto :goto_2

    :cond_5
    move-object v4, v3

    move v3, v0

    goto :goto_5

    :cond_6
    move-object v0, v5

    goto :goto_4

    :cond_7
    move v4, v0

    goto :goto_3
.end method
