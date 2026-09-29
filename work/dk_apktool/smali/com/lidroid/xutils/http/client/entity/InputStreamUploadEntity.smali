.class public Lcom/lidroid/xutils/http/client/entity/InputStreamUploadEntity;
.super Lorg/apache/http/entity/AbstractHttpEntity;
.source "SourceFile"

# interfaces
.implements Lcom/lidroid/xutils/http/client/entity/UploadEntity;


# static fields
.field private static final BUFFER_SIZE:I = 0x800


# instance fields
.field private callBackHandler:Lcom/lidroid/xutils/http/callback/RequestCallBackHandler;

.field private final content:Ljava/io/InputStream;

.field private final length:J

.field private uploadedSize:J


# direct methods
.method public constructor <init>(Ljava/io/InputStream;J)V
    .locals 2

    .prologue
    .line 41
    invoke-direct {p0}, Lorg/apache/http/entity/AbstractHttpEntity;-><init>()V

    .line 61
    const-wide/16 v0, 0x0

    iput-wide v0, p0, Lcom/lidroid/xutils/http/client/entity/InputStreamUploadEntity;->uploadedSize:J

    .line 123
    const/4 v0, 0x0

    iput-object v0, p0, Lcom/lidroid/xutils/http/client/entity/InputStreamUploadEntity;->callBackHandler:Lcom/lidroid/xutils/http/callback/RequestCallBackHandler;

    .line 42
    if-nez p1, :cond_0

    .line 43
    new-instance v0, Ljava/lang/IllegalArgumentException;

    const-string v1, "Source input stream may not be null"

    invoke-direct {v0, v1}, Ljava/lang/IllegalArgumentException;-><init>(Ljava/lang/String;)V

    throw v0

    .line 45
    :cond_0
    iput-object p1, p0, Lcom/lidroid/xutils/http/client/entity/InputStreamUploadEntity;->content:Ljava/io/InputStream;

    .line 46
    iput-wide p2, p0, Lcom/lidroid/xutils/http/client/entity/InputStreamUploadEntity;->length:J

    .line 47
    return-void
.end method


# virtual methods
.method public consumeContent()V
    .locals 1
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljava/io/IOException;
        }
    .end annotation

    .prologue
    .line 120
    iget-object v0, p0, Lcom/lidroid/xutils/http/client/entity/InputStreamUploadEntity;->content:Ljava/io/InputStream;

    invoke-virtual {v0}, Ljava/io/InputStream;->close()V

    .line 121
    return-void
.end method

.method public getContent()Ljava/io/InputStream;
    .locals 1
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljava/io/IOException;
        }
    .end annotation

    .prologue
    .line 58
    iget-object v0, p0, Lcom/lidroid/xutils/http/client/entity/InputStreamUploadEntity;->content:Ljava/io/InputStream;

    return-object v0
.end method

.method public getContentLength()J
    .locals 2

    .prologue
    .line 54
    iget-wide v0, p0, Lcom/lidroid/xutils/http/client/entity/InputStreamUploadEntity;->length:J

    return-wide v0
.end method

.method public isRepeatable()Z
    .locals 1

    .prologue
    .line 50
    const/4 v0, 0x0

    return v0
.end method

.method public isStreaming()Z
    .locals 1

    .prologue
    .line 110
    const/4 v0, 0x1

    return v0
.end method

.method public setCallBackHandler(Lcom/lidroid/xutils/http/callback/RequestCallBackHandler;)V
    .locals 0

    .prologue
    .line 127
    iput-object p1, p0, Lcom/lidroid/xutils/http/client/entity/InputStreamUploadEntity;->callBackHandler:Lcom/lidroid/xutils/http/callback/RequestCallBackHandler;

    .line 128
    return-void
.end method

.method public writeTo(Ljava/io/OutputStream;)V
    .locals 14
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljava/io/IOException;
        }
    .end annotation

    .prologue
    const-wide/16 v12, 0x0

    const/4 v11, -0x1

    .line 64
    if-nez p1, :cond_0

    .line 65
    new-instance v0, Ljava/lang/IllegalArgumentException;

    const-string v1, "Output stream may not be null"

    invoke-direct {v0, v1}, Ljava/lang/IllegalArgumentException;-><init>(Ljava/lang/String;)V

    throw v0

    .line 67
    :cond_0
    iget-object v7, p0, Lcom/lidroid/xutils/http/client/entity/InputStreamUploadEntity;->content:Ljava/io/InputStream;

    .line 69
    const/16 v0, 0x800

    :try_start_0
    new-array v10, v0, [B

    .line 71
    iget-wide v0, p0, Lcom/lidroid/xutils/http/client/entity/InputStreamUploadEntity;->length:J

    cmp-long v0, v0, v12

    if-gez v0, :cond_5

    .line 73
    :cond_1
    invoke-virtual {v7, v10}, Ljava/io/InputStream;->read([B)I

    move-result v0

    if-ne v0, v11, :cond_4

    .line 100
    :cond_2
    invoke-virtual {p1}, Ljava/io/OutputStream;->flush()V

    .line 101
    iget-object v0, p0, Lcom/lidroid/xutils/http/client/entity/InputStreamUploadEntity;->callBackHandler:Lcom/lidroid/xutils/http/callback/RequestCallBackHandler;

    if-eqz v0, :cond_3

    .line 102
    iget-object v1, p0, Lcom/lidroid/xutils/http/client/entity/InputStreamUploadEntity;->callBackHandler:Lcom/lidroid/xutils/http/callback/RequestCallBackHandler;

    iget-wide v2, p0, Lcom/lidroid/xutils/http/client/entity/InputStreamUploadEntity;->length:J

    iget-wide v4, p0, Lcom/lidroid/xutils/http/client/entity/InputStreamUploadEntity;->uploadedSize:J

    const/4 v6, 0x1

    invoke-interface/range {v1 .. v6}, Lcom/lidroid/xutils/http/callback/RequestCallBackHandler;->updateProgress(JJZ)Z
    :try_end_0
    .catchall {:try_start_0 .. :try_end_0} :catchall_0

    .line 105
    :cond_3
    invoke-static {v7}, Lcom/lidroid/xutils/util/IOUtils;->closeQuietly(Ljava/io/Closeable;)V

    .line 107
    return-void

    .line 74
    :cond_4
    const/4 v1, 0x0

    :try_start_1
    invoke-virtual {p1, v10, v1, v0}, Ljava/io/OutputStream;->write([BII)V

    .line 75
    iget-wide v2, p0, Lcom/lidroid/xutils/http/client/entity/InputStreamUploadEntity;->uploadedSize:J

    int-to-long v0, v0

    add-long/2addr v0, v2

    iput-wide v0, p0, Lcom/lidroid/xutils/http/client/entity/InputStreamUploadEntity;->uploadedSize:J

    .line 76
    iget-object v0, p0, Lcom/lidroid/xutils/http/client/entity/InputStreamUploadEntity;->callBackHandler:Lcom/lidroid/xutils/http/callback/RequestCallBackHandler;

    if-eqz v0, :cond_1

    .line 77
    iget-object v1, p0, Lcom/lidroid/xutils/http/client/entity/InputStreamUploadEntity;->callBackHandler:Lcom/lidroid/xutils/http/callback/RequestCallBackHandler;

    iget-wide v2, p0, Lcom/lidroid/xutils/http/client/entity/InputStreamUploadEntity;->uploadedSize:J

    const-wide/16 v4, 0x1

    add-long/2addr v2, v4

    iget-wide v4, p0, Lcom/lidroid/xutils/http/client/entity/InputStreamUploadEntity;->uploadedSize:J

    const/4 v6, 0x0

    invoke-interface/range {v1 .. v6}, Lcom/lidroid/xutils/http/callback/RequestCallBackHandler;->updateProgress(JJZ)Z

    move-result v0

    if-nez v0, :cond_1

    .line 78
    new-instance v0, Ljava/io/InterruptedIOException;

    const-string v1, "cancel"

    invoke-direct {v0, v1}, Ljava/io/InterruptedIOException;-><init>(Ljava/lang/String;)V

    throw v0
    :try_end_1
    .catchall {:try_start_1 .. :try_end_1} :catchall_0

    .line 104
    :catchall_0
    move-exception v0

    .line 105
    invoke-static {v7}, Lcom/lidroid/xutils/util/IOUtils;->closeQuietly(Ljava/io/Closeable;)V

    .line 106
    throw v0

    .line 84
    :cond_5
    :try_start_2
    iget-wide v0, p0, Lcom/lidroid/xutils/http/client/entity/InputStreamUploadEntity;->length:J

    .line 85
    :goto_0
    cmp-long v2, v0, v12

    if-lez v2, :cond_2

    .line 86
    const/4 v2, 0x0

    const-wide/16 v4, 0x800

    invoke-static {v4, v5, v0, v1}, Ljava/lang/Math;->min(JJ)J

    move-result-wide v4

    long-to-int v3, v4

    invoke-virtual {v7, v10, v2, v3}, Ljava/io/InputStream;->read([BII)I

    move-result v2

    .line 87
    if-eq v2, v11, :cond_2

    .line 90
    const/4 v3, 0x0

    invoke-virtual {p1, v10, v3, v2}, Ljava/io/OutputStream;->write([BII)V

    .line 91
    int-to-long v4, v2

    sub-long v8, v0, v4

    .line 92
    iget-wide v0, p0, Lcom/lidroid/xutils/http/client/entity/InputStreamUploadEntity;->uploadedSize:J

    int-to-long v2, v2

    add-long/2addr v0, v2

    iput-wide v0, p0, Lcom/lidroid/xutils/http/client/entity/InputStreamUploadEntity;->uploadedSize:J

    .line 93
    iget-object v0, p0, Lcom/lidroid/xutils/http/client/entity/InputStreamUploadEntity;->callBackHandler:Lcom/lidroid/xutils/http/callback/RequestCallBackHandler;

    if-eqz v0, :cond_6

    .line 94
    iget-object v1, p0, Lcom/lidroid/xutils/http/client/entity/InputStreamUploadEntity;->callBackHandler:Lcom/lidroid/xutils/http/callback/RequestCallBackHandler;

    iget-wide v2, p0, Lcom/lidroid/xutils/http/client/entity/InputStreamUploadEntity;->length:J

    iget-wide v4, p0, Lcom/lidroid/xutils/http/client/entity/InputStreamUploadEntity;->uploadedSize:J

    const/4 v6, 0x0

    invoke-interface/range {v1 .. v6}, Lcom/lidroid/xutils/http/callback/RequestCallBackHandler;->updateProgress(JJZ)Z

    move-result v0

    if-nez v0, :cond_6

    .line 95
    new-instance v0, Ljava/io/InterruptedIOException;

    const-string v1, "cancel"

    invoke-direct {v0, v1}, Ljava/io/InterruptedIOException;-><init>(Ljava/lang/String;)V

    throw v0
    :try_end_2
    .catchall {:try_start_2 .. :try_end_2} :catchall_0

    :cond_6
    move-wide v0, v8

    goto :goto_0
.end method
