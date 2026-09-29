.class public Lcom/sun/mail/util/QDecoderStream;
.super Lcom/sun/mail/util/QPDecoderStream;
.source "SourceFile"


# direct methods
.method public constructor <init>(Ljava/io/InputStream;)V
    .locals 0

    .prologue
    .line 59
    invoke-direct {p0, p1}, Lcom/sun/mail/util/QPDecoderStream;-><init>(Ljava/io/InputStream;)V

    .line 60
    return-void
.end method


# virtual methods
.method public read()I
    .locals 4
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljava/io/IOException;
        }
    .end annotation

    .prologue
    const/4 v2, 0x0

    .line 75
    iget-object v0, p0, Lcom/sun/mail/util/QDecoderStream;->in:Ljava/io/InputStream;

    invoke-virtual {v0}, Ljava/io/InputStream;->read()I

    move-result v0

    .line 77
    const/16 v1, 0x5f

    if-ne v0, v1, :cond_1

    .line 78
    const/16 v0, 0x20

    .line 90
    :cond_0
    :goto_0
    return v0

    .line 79
    :cond_1
    const/16 v1, 0x3d

    if-ne v0, v1, :cond_0

    .line 81
    iget-object v0, p0, Lcom/sun/mail/util/QDecoderStream;->ba:[B

    iget-object v1, p0, Lcom/sun/mail/util/QDecoderStream;->in:Ljava/io/InputStream;

    invoke-virtual {v1}, Ljava/io/InputStream;->read()I

    move-result v1

    int-to-byte v1, v1

    aput-byte v1, v0, v2

    .line 82
    iget-object v0, p0, Lcom/sun/mail/util/QDecoderStream;->ba:[B

    const/4 v1, 0x1

    iget-object v2, p0, Lcom/sun/mail/util/QDecoderStream;->in:Ljava/io/InputStream;

    invoke-virtual {v2}, Ljava/io/InputStream;->read()I

    move-result v2

    int-to-byte v2, v2

    aput-byte v2, v0, v1

    .line 85
    :try_start_0
    iget-object v0, p0, Lcom/sun/mail/util/QDecoderStream;->ba:[B

    const/4 v1, 0x0

    const/4 v2, 0x2

    const/16 v3, 0x10

    invoke-static {v0, v1, v2, v3}, Lcom/sun/mail/util/ASCIIUtility;->parseInt([BIII)I
    :try_end_0
    .catch Ljava/lang/NumberFormatException; {:try_start_0 .. :try_end_0} :catch_0

    move-result v0

    goto :goto_0

    .line 86
    :catch_0
    move-exception v0

    .line 87
    new-instance v1, Ljava/io/IOException;

    new-instance v2, Ljava/lang/StringBuilder;

    const-string v3, "Error in QP stream "

    invoke-direct {v2, v3}, Ljava/lang/StringBuilder;-><init>(Ljava/lang/String;)V

    invoke-virtual {v0}, Ljava/lang/NumberFormatException;->getMessage()Ljava/lang/String;

    move-result-object v0

    invoke-virtual {v2, v0}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-virtual {v0}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v0

    invoke-direct {v1, v0}, Ljava/io/IOException;-><init>(Ljava/lang/String;)V

    throw v1
.end method
