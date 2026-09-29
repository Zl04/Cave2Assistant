.class abstract Lcom/lidroid/xutils/http/client/entity/DecompressingEntity;
.super Lorg/apache/http/entity/HttpEntityWrapper;
.source "SourceFile"

# interfaces
.implements Lcom/lidroid/xutils/http/client/entity/UploadEntity;


# instance fields
.field private callBackHandler:Lcom/lidroid/xutils/http/callback/RequestCallBackHandler;

.field private content:Ljava/io/InputStream;

.field private uncompressedLength:J

.field private uploadedSize:J


# direct methods
.method public constructor <init>(Lorg/apache/http/HttpEntity;)V
    .locals 2

    .prologue
    .line 47
    invoke-direct {p0, p1}, Lorg/apache/http/entity/HttpEntityWrapper;-><init>(Lorg/apache/http/HttpEntity;)V

    .line 87
    const-wide/16 v0, 0x0

    iput-wide v0, p0, Lcom/lidroid/xutils/http/client/entity/DecompressingEntity;->uploadedSize:J

    .line 121
    const/4 v0, 0x0

    iput-object v0, p0, Lcom/lidroid/xutils/http/client/entity/DecompressingEntity;->callBackHandler:Lcom/lidroid/xutils/http/callback/RequestCallBackHandler;

    .line 48
    invoke-interface {p1}, Lorg/apache/http/HttpEntity;->getContentLength()J

    move-result-wide v0

    iput-wide v0, p0, Lcom/lidroid/xutils/http/client/entity/DecompressingEntity;->uncompressedLength:J

    .line 49
    return-void
.end method

.method private getDecompressingStream()Ljava/io/InputStream;
    .locals 2
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljava/io/IOException;
        }
    .end annotation

    .prologue
    .line 54
    const/4 v1, 0x0

    .line 56
    :try_start_0
    iget-object v0, p0, Lcom/lidroid/xutils/http/client/entity/DecompressingEntity;->wrappedEntity:Lorg/apache/http/HttpEntity;

    invoke-interface {v0}, Lorg/apache/http/HttpEntity;->getContent()Ljava/io/InputStream;

    move-result-object v1

    .line 57
    invoke-virtual {p0, v1}, Lcom/lidroid/xutils/http/client/entity/DecompressingEntity;->decorate(Ljava/io/InputStream;)Ljava/io/InputStream;
    :try_end_0
    .catch Ljava/io/IOException; {:try_start_0 .. :try_end_0} :catch_0

    move-result-object v0

    return-object v0

    .line 58
    :catch_0
    move-exception v0

    .line 59
    invoke-static {v1}, Lcom/lidroid/xutils/util/IOUtils;->closeQuietly(Ljava/io/Closeable;)V

    .line 60
    throw v0
.end method


# virtual methods
.method abstract decorate(Ljava/io/InputStream;)Ljava/io/InputStream;
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljava/io/IOException;
        }
    .end annotation
.end method

.method public getContent()Ljava/io/InputStream;
    .locals 1
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljava/io/IOException;
        }
    .end annotation

    .prologue
    .line 69
    iget-object v0, p0, Lcom/lidroid/xutils/http/client/entity/DecompressingEntity;->wrappedEntity:Lorg/apache/http/HttpEntity;

    invoke-interface {v0}, Lorg/apache/http/HttpEntity;->isStreaming()Z

    move-result v0

    if-eqz v0, :cond_1

    .line 70
    iget-object v0, p0, Lcom/lidroid/xutils/http/client/entity/DecompressingEntity;->content:Ljava/io/InputStream;

    if-nez v0, :cond_0

    .line 71
    invoke-direct {p0}, Lcom/lidroid/xutils/http/client/entity/DecompressingEntity;->getDecompressingStream()Ljava/io/InputStream;

    move-result-object v0

    iput-object v0, p0, Lcom/lidroid/xutils/http/client/entity/DecompressingEntity;->content:Ljava/io/InputStream;

    .line 73
    :cond_0
    iget-object v0, p0, Lcom/lidroid/xutils/http/client/entity/DecompressingEntity;->content:Ljava/io/InputStream;

    .line 75
    :goto_0
    return-object v0

    :cond_1
    invoke-direct {p0}, Lcom/lidroid/xutils/http/client/entity/DecompressingEntity;->getDecompressingStream()Ljava/io/InputStream;

    move-result-object v0

    goto :goto_0
.end method

.method public getContentLength()J
    .locals 2

    .prologue
    .line 84
    const-wide/16 v0, -0x1

    return-wide v0
.end method

.method public setCallBackHandler(Lcom/lidroid/xutils/http/callback/RequestCallBackHandler;)V
    .locals 0

    .prologue
    .line 125
    iput-object p1, p0, Lcom/lidroid/xutils/http/client/entity/DecompressingEntity;->callBackHandler:Lcom/lidroid/xutils/http/callback/RequestCallBackHandler;

    .line 126
    return-void
.end method

.method public writeTo(Ljava/io/OutputStream;)V
    .locals 8
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljava/io/IOException;
        }
    .end annotation

    .prologue
    .line 94
    if-nez p1, :cond_0

    .line 95
    new-instance v0, Ljava/lang/IllegalArgumentException;

    const-string v1, "Output stream may not be null"

    invoke-direct {v0, v1}, Ljava/lang/IllegalArgumentException;-><init>(Ljava/lang/String;)V

    throw v0

    .line 97
    :cond_0
    const/4 v1, 0x0

    .line 99
    :try_start_0
    invoke-virtual {p0}, Lcom/lidroid/xutils/http/client/entity/DecompressingEntity;->getContent()Ljava/io/InputStream;
    :try_end_0
    .catchall {:try_start_0 .. :try_end_0} :catchall_1

    move-result-object v7

    .line 101
    const/16 v0, 0x1000

    :try_start_1
    new-array v0, v0, [B

    .line 103
    :cond_1
    invoke-virtual {v7, v0}, Ljava/io/InputStream;->read([B)I

    move-result v1

    const/4 v2, -0x1

    if-ne v1, v2, :cond_3

    .line 112
    invoke-virtual {p1}, Ljava/io/OutputStream;->flush()V

    .line 113
    iget-object v0, p0, Lcom/lidroid/xutils/http/client/entity/DecompressingEntity;->callBackHandler:Lcom/lidroid/xutils/http/callback/RequestCallBackHandler;

    if-eqz v0, :cond_2

    .line 114
    iget-object v1, p0, Lcom/lidroid/xutils/http/client/entity/DecompressingEntity;->callBackHandler:Lcom/lidroid/xutils/http/callback/RequestCallBackHandler;

    iget-wide v2, p0, Lcom/lidroid/xutils/http/client/entity/DecompressingEntity;->uncompressedLength:J

    iget-wide v4, p0, Lcom/lidroid/xutils/http/client/entity/DecompressingEntity;->uploadedSize:J

    const/4 v6, 0x1

    invoke-interface/range {v1 .. v6}, Lcom/lidroid/xutils/http/callback/RequestCallBackHandler;->updateProgress(JJZ)Z
    :try_end_1
    .catchall {:try_start_1 .. :try_end_1} :catchall_0

    .line 117
    :cond_2
    invoke-static {v7}, Lcom/lidroid/xutils/util/IOUtils;->closeQuietly(Ljava/io/Closeable;)V

    .line 119
    return-void

    .line 104
    :cond_3
    const/4 v2, 0x0

    :try_start_2
    invoke-virtual {p1, v0, v2, v1}, Ljava/io/OutputStream;->write([BII)V

    .line 105
    iget-wide v2, p0, Lcom/lidroid/xutils/http/client/entity/DecompressingEntity;->uploadedSize:J

    int-to-long v4, v1

    add-long/2addr v2, v4

    iput-wide v2, p0, Lcom/lidroid/xutils/http/client/entity/DecompressingEntity;->uploadedSize:J

    .line 106
    iget-object v1, p0, Lcom/lidroid/xutils/http/client/entity/DecompressingEntity;->callBackHandler:Lcom/lidroid/xutils/http/callback/RequestCallBackHandler;

    if-eqz v1, :cond_1

    .line 107
    iget-object v1, p0, Lcom/lidroid/xutils/http/client/entity/DecompressingEntity;->callBackHandler:Lcom/lidroid/xutils/http/callback/RequestCallBackHandler;

    iget-wide v2, p0, Lcom/lidroid/xutils/http/client/entity/DecompressingEntity;->uncompressedLength:J

    iget-wide v4, p0, Lcom/lidroid/xutils/http/client/entity/DecompressingEntity;->uploadedSize:J

    const/4 v6, 0x0

    invoke-interface/range {v1 .. v6}, Lcom/lidroid/xutils/http/callback/RequestCallBackHandler;->updateProgress(JJZ)Z

    move-result v1

    if-nez v1, :cond_1

    .line 108
    new-instance v0, Ljava/io/InterruptedIOException;

    const-string v1, "cancel"

    invoke-direct {v0, v1}, Ljava/io/InterruptedIOException;-><init>(Ljava/lang/String;)V

    throw v0
    :try_end_2
    .catchall {:try_start_2 .. :try_end_2} :catchall_0

    .line 116
    :catchall_0
    move-exception v0

    move-object v1, v7

    .line 117
    :goto_0
    invoke-static {v1}, Lcom/lidroid/xutils/util/IOUtils;->closeQuietly(Ljava/io/Closeable;)V

    .line 118
    throw v0

    .line 116
    :catchall_1
    move-exception v0

    goto :goto_0
.end method
