.class public Lorg/apache/commons/io/output/ChunkedOutputStream;
.super Ljava/io/FilterOutputStream;
.source "SourceFile"


# static fields
.field private static final DEFAULT_CHUNK_SIZE:I = 0x1000


# instance fields
.field private final chunkSize:I


# direct methods
.method public constructor <init>(Ljava/io/OutputStream;)V
    .locals 1

    .prologue
    .line 63
    const/16 v0, 0x1000

    invoke-direct {p0, p1, v0}, Lorg/apache/commons/io/output/ChunkedOutputStream;-><init>(Ljava/io/OutputStream;I)V

    .line 64
    return-void
.end method

.method public constructor <init>(Ljava/io/OutputStream;I)V
    .locals 1

    .prologue
    .line 50
    invoke-direct {p0, p1}, Ljava/io/FilterOutputStream;-><init>(Ljava/io/OutputStream;)V

    .line 51
    if-gtz p2, :cond_0

    .line 52
    new-instance v0, Ljava/lang/IllegalArgumentException;

    invoke-direct {v0}, Ljava/lang/IllegalArgumentException;-><init>()V

    throw v0

    .line 54
    :cond_0
    iput p2, p0, Lorg/apache/commons/io/output/ChunkedOutputStream;->chunkSize:I

    .line 55
    return-void
.end method


# virtual methods
.method public write([BII)V
    .locals 2
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljava/io/IOException;
        }
    .end annotation

    .prologue
    .line 77
    .line 79
    :goto_0
    if-lez p3, :cond_0

    .line 80
    iget v0, p0, Lorg/apache/commons/io/output/ChunkedOutputStream;->chunkSize:I

    invoke-static {p3, v0}, Ljava/lang/Math;->min(II)I

    move-result v0

    .line 81
    iget-object v1, p0, Lorg/apache/commons/io/output/ChunkedOutputStream;->out:Ljava/io/OutputStream;

    invoke-virtual {v1, p1, p2, v0}, Ljava/io/OutputStream;->write([BII)V

    .line 82
    sub-int/2addr p3, v0

    .line 83
    add-int/2addr p2, v0

    .line 84
    goto :goto_0

    .line 85
    :cond_0
    return-void
.end method
