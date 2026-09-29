.class public Lcom/lidroid/xutils/http/client/entity/FileUploadEntity;
.super Lorg/apache/http/entity/FileEntity;
.source "SourceFile"

# interfaces
.implements Lcom/lidroid/xutils/http/client/entity/UploadEntity;


# instance fields
.field private callBackHandler:Lcom/lidroid/xutils/http/callback/RequestCallBackHandler;

.field private fileSize:J

.field private uploadedSize:J


# direct methods
.method public constructor <init>(Ljava/io/File;Ljava/lang/String;)V
    .locals 2

    .prologue
    .line 33
    invoke-direct {p0, p1, p2}, Lorg/apache/http/entity/FileEntity;-><init>(Ljava/io/File;Ljava/lang/String;)V

    .line 38
    const-wide/16 v0, 0x0

    iput-wide v0, p0, Lcom/lidroid/xutils/http/client/entity/FileUploadEntity;->uploadedSize:J

    .line 68
    const/4 v0, 0x0

    iput-object v0, p0, Lcom/lidroid/xutils/http/client/entity/FileUploadEntity;->callBackHandler:Lcom/lidroid/xutils/http/callback/RequestCallBackHandler;

    .line 34
    invoke-virtual {p1}, Ljava/io/File;->length()J

    move-result-wide v0

    iput-wide v0, p0, Lcom/lidroid/xutils/http/client/entity/FileUploadEntity;->fileSize:J

    .line 35
    return-void
.end method


# virtual methods
.method public setCallBackHandler(Lcom/lidroid/xutils/http/callback/RequestCallBackHandler;)V
    .locals 0

    .prologue
    .line 72
    iput-object p1, p0, Lcom/lidroid/xutils/http/client/entity/FileUploadEntity;->callBackHandler:Lcom/lidroid/xutils/http/callback/RequestCallBackHandler;

    .line 73
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
    .line 42
    if-nez p1, :cond_0

    .line 43
    new-instance v0, Ljava/lang/IllegalArgumentException;

    const-string v1, "Output stream may not be null"

    invoke-direct {v0, v1}, Ljava/lang/IllegalArgumentException;-><init>(Ljava/lang/String;)V

    throw v0

    .line 45
    :cond_0
    const/4 v1, 0x0

    .line 47
    :try_start_0
    new-instance v7, Ljava/io/BufferedInputStream;

    new-instance v0, Ljava/io/FileInputStream;

    iget-object v2, p0, Lcom/lidroid/xutils/http/client/entity/FileUploadEntity;->file:Ljava/io/File;

    invoke-direct {v0, v2}, Ljava/io/FileInputStream;-><init>(Ljava/io/File;)V

    invoke-direct {v7, v0}, Ljava/io/BufferedInputStream;-><init>(Ljava/io/InputStream;)V
    :try_end_0
    .catchall {:try_start_0 .. :try_end_0} :catchall_1

    .line 48
    const/16 v0, 0x1000

    :try_start_1
    new-array v0, v0, [B

    .line 50
    :cond_1
    invoke-virtual {v7, v0}, Ljava/io/BufferedInputStream;->read([B)I

    move-result v1

    const/4 v2, -0x1

    if-ne v1, v2, :cond_3

    .line 59
    invoke-virtual {p1}, Ljava/io/OutputStream;->flush()V

    .line 60
    iget-object v0, p0, Lcom/lidroid/xutils/http/client/entity/FileUploadEntity;->callBackHandler:Lcom/lidroid/xutils/http/callback/RequestCallBackHandler;

    if-eqz v0, :cond_2

    .line 61
    iget-object v1, p0, Lcom/lidroid/xutils/http/client/entity/FileUploadEntity;->callBackHandler:Lcom/lidroid/xutils/http/callback/RequestCallBackHandler;

    iget-wide v2, p0, Lcom/lidroid/xutils/http/client/entity/FileUploadEntity;->fileSize:J

    iget-wide v4, p0, Lcom/lidroid/xutils/http/client/entity/FileUploadEntity;->uploadedSize:J

    const/4 v6, 0x1

    invoke-interface/range {v1 .. v6}, Lcom/lidroid/xutils/http/callback/RequestCallBackHandler;->updateProgress(JJZ)Z
    :try_end_1
    .catchall {:try_start_1 .. :try_end_1} :catchall_0

    .line 64
    :cond_2
    invoke-static {v7}, Lcom/lidroid/xutils/util/IOUtils;->closeQuietly(Ljava/io/Closeable;)V

    .line 66
    return-void

    .line 51
    :cond_3
    const/4 v2, 0x0

    :try_start_2
    invoke-virtual {p1, v0, v2, v1}, Ljava/io/OutputStream;->write([BII)V

    .line 52
    iget-wide v2, p0, Lcom/lidroid/xutils/http/client/entity/FileUploadEntity;->uploadedSize:J

    int-to-long v4, v1

    add-long/2addr v2, v4

    iput-wide v2, p0, Lcom/lidroid/xutils/http/client/entity/FileUploadEntity;->uploadedSize:J

    .line 53
    iget-object v1, p0, Lcom/lidroid/xutils/http/client/entity/FileUploadEntity;->callBackHandler:Lcom/lidroid/xutils/http/callback/RequestCallBackHandler;

    if-eqz v1, :cond_1

    .line 54
    iget-object v1, p0, Lcom/lidroid/xutils/http/client/entity/FileUploadEntity;->callBackHandler:Lcom/lidroid/xutils/http/callback/RequestCallBackHandler;

    iget-wide v2, p0, Lcom/lidroid/xutils/http/client/entity/FileUploadEntity;->fileSize:J

    iget-wide v4, p0, Lcom/lidroid/xutils/http/client/entity/FileUploadEntity;->uploadedSize:J

    const/4 v6, 0x0

    invoke-interface/range {v1 .. v6}, Lcom/lidroid/xutils/http/callback/RequestCallBackHandler;->updateProgress(JJZ)Z

    move-result v1

    if-nez v1, :cond_1

    .line 55
    new-instance v0, Ljava/io/InterruptedIOException;

    const-string v1, "cancel"

    invoke-direct {v0, v1}, Ljava/io/InterruptedIOException;-><init>(Ljava/lang/String;)V

    throw v0
    :try_end_2
    .catchall {:try_start_2 .. :try_end_2} :catchall_0

    .line 63
    :catchall_0
    move-exception v0

    move-object v1, v7

    .line 64
    :goto_0
    invoke-static {v1}, Lcom/lidroid/xutils/util/IOUtils;->closeQuietly(Ljava/io/Closeable;)V

    .line 65
    throw v0

    .line 63
    :catchall_1
    move-exception v0

    goto :goto_0
.end method
