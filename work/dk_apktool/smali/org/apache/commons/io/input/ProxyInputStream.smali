.class public abstract Lorg/apache/commons/io/input/ProxyInputStream;
.super Ljava/io/FilterInputStream;
.source "SourceFile"


# direct methods
.method public constructor <init>(Ljava/io/InputStream;)V
    .locals 0

    .prologue
    .line 47
    invoke-direct {p0, p1}, Ljava/io/FilterInputStream;-><init>(Ljava/io/InputStream;)V

    .line 49
    return-void
.end method


# virtual methods
.method protected afterRead(I)V
    .locals 0
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljava/io/IOException;
        }
    .end annotation

    .prologue
    .line 225
    return-void
.end method

.method public available()I
    .locals 1
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljava/io/IOException;
        }
    .end annotation

    .prologue
    .line 133
    :try_start_0
    invoke-super {p0}, Ljava/io/FilterInputStream;->available()I
    :try_end_0
    .catch Ljava/io/IOException; {:try_start_0 .. :try_end_0} :catch_0

    move-result v0

    .line 136
    :goto_0
    return v0

    .line 134
    :catch_0
    move-exception v0

    .line 135
    invoke-virtual {p0, v0}, Lorg/apache/commons/io/input/ProxyInputStream;->handleIOException(Ljava/io/IOException;)V

    .line 136
    const/4 v0, 0x0

    goto :goto_0
.end method

.method protected beforeRead(I)V
    .locals 0
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljava/io/IOException;
        }
    .end annotation

    .prologue
    .line 204
    return-void
.end method

.method public close()V
    .locals 1
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljava/io/IOException;
        }
    .end annotation

    .prologue
    .line 147
    :try_start_0
    iget-object v0, p0, Lorg/apache/commons/io/input/ProxyInputStream;->in:Ljava/io/InputStream;

    invoke-virtual {v0}, Ljava/io/InputStream;->close()V
    :try_end_0
    .catch Ljava/io/IOException; {:try_start_0 .. :try_end_0} :catch_0

    .line 151
    :goto_0
    return-void

    .line 148
    :catch_0
    move-exception v0

    .line 149
    invoke-virtual {p0, v0}, Lorg/apache/commons/io/input/ProxyInputStream;->handleIOException(Ljava/io/IOException;)V

    goto :goto_0
.end method

.method protected handleIOException(Ljava/io/IOException;)V
    .locals 0
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljava/io/IOException;
        }
    .end annotation

    .prologue
    .line 237
    throw p1
.end method

.method public declared-synchronized mark(I)V
    .locals 1

    .prologue
    .line 159
    monitor-enter p0

    :try_start_0
    iget-object v0, p0, Lorg/apache/commons/io/input/ProxyInputStream;->in:Ljava/io/InputStream;

    invoke-virtual {v0, p1}, Ljava/io/InputStream;->mark(I)V
    :try_end_0
    .catchall {:try_start_0 .. :try_end_0} :catchall_0

    .line 160
    monitor-exit p0

    return-void

    .line 159
    :catchall_0
    move-exception v0

    monitor-exit p0

    throw v0
.end method

.method public markSupported()Z
    .locals 1

    .prologue
    .line 181
    iget-object v0, p0, Lorg/apache/commons/io/input/ProxyInputStream;->in:Ljava/io/InputStream;

    invoke-virtual {v0}, Ljava/io/InputStream;->markSupported()Z

    move-result v0

    return v0
.end method

.method public read()I
    .locals 3
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljava/io/IOException;
        }
    .end annotation

    .prologue
    const/4 v2, 0x1

    const/4 v1, -0x1

    .line 59
    const/4 v0, 0x1

    :try_start_0
    invoke-virtual {p0, v0}, Lorg/apache/commons/io/input/ProxyInputStream;->beforeRead(I)V

    .line 60
    iget-object v0, p0, Lorg/apache/commons/io/input/ProxyInputStream;->in:Ljava/io/InputStream;

    invoke-virtual {v0}, Ljava/io/InputStream;->read()I

    move-result v0

    .line 61
    if-eq v0, v1, :cond_0

    :goto_0
    invoke-virtual {p0, v2}, Lorg/apache/commons/io/input/ProxyInputStream;->afterRead(I)V
    :try_end_0
    .catch Ljava/io/IOException; {:try_start_0 .. :try_end_0} :catch_0

    .line 65
    :goto_1
    return v0

    :cond_0
    move v2, v1

    .line 61
    goto :goto_0

    .line 63
    :catch_0
    move-exception v0

    .line 64
    invoke-virtual {p0, v0}, Lorg/apache/commons/io/input/ProxyInputStream;->handleIOException(Ljava/io/IOException;)V

    move v0, v1

    .line 65
    goto :goto_1
.end method

.method public read([B)I
    .locals 1
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljava/io/IOException;
        }
    .end annotation

    .prologue
    .line 78
    if-eqz p1, :cond_0

    :try_start_0
    array-length v0, p1

    :goto_0
    invoke-virtual {p0, v0}, Lorg/apache/commons/io/input/ProxyInputStream;->beforeRead(I)V

    .line 79
    iget-object v0, p0, Lorg/apache/commons/io/input/ProxyInputStream;->in:Ljava/io/InputStream;

    invoke-virtual {v0, p1}, Ljava/io/InputStream;->read([B)I

    move-result v0

    .line 80
    invoke-virtual {p0, v0}, Lorg/apache/commons/io/input/ProxyInputStream;->afterRead(I)V
    :try_end_0
    .catch Ljava/io/IOException; {:try_start_0 .. :try_end_0} :catch_0

    .line 84
    :goto_1
    return v0

    .line 78
    :cond_0
    const/4 v0, 0x0

    goto :goto_0

    .line 82
    :catch_0
    move-exception v0

    .line 83
    invoke-virtual {p0, v0}, Lorg/apache/commons/io/input/ProxyInputStream;->handleIOException(Ljava/io/IOException;)V

    .line 84
    const/4 v0, -0x1

    goto :goto_1
.end method

.method public read([BII)I
    .locals 1
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljava/io/IOException;
        }
    .end annotation

    .prologue
    .line 99
    :try_start_0
    invoke-virtual {p0, p3}, Lorg/apache/commons/io/input/ProxyInputStream;->beforeRead(I)V

    .line 100
    iget-object v0, p0, Lorg/apache/commons/io/input/ProxyInputStream;->in:Ljava/io/InputStream;

    invoke-virtual {v0, p1, p2, p3}, Ljava/io/InputStream;->read([BII)I

    move-result v0

    .line 101
    invoke-virtual {p0, v0}, Lorg/apache/commons/io/input/ProxyInputStream;->afterRead(I)V
    :try_end_0
    .catch Ljava/io/IOException; {:try_start_0 .. :try_end_0} :catch_0

    .line 105
    :goto_0
    return v0

    .line 103
    :catch_0
    move-exception v0

    .line 104
    invoke-virtual {p0, v0}, Lorg/apache/commons/io/input/ProxyInputStream;->handleIOException(Ljava/io/IOException;)V

    .line 105
    const/4 v0, -0x1

    goto :goto_0
.end method

.method public declared-synchronized reset()V
    .locals 1
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljava/io/IOException;
        }
    .end annotation

    .prologue
    .line 169
    monitor-enter p0

    :try_start_0
    iget-object v0, p0, Lorg/apache/commons/io/input/ProxyInputStream;->in:Ljava/io/InputStream;

    invoke-virtual {v0}, Ljava/io/InputStream;->reset()V
    :try_end_0
    .catch Ljava/io/IOException; {:try_start_0 .. :try_end_0} :catch_0
    .catchall {:try_start_0 .. :try_end_0} :catchall_0

    .line 173
    :goto_0
    monitor-exit p0

    return-void

    .line 170
    :catch_0
    move-exception v0

    .line 171
    :try_start_1
    invoke-virtual {p0, v0}, Lorg/apache/commons/io/input/ProxyInputStream;->handleIOException(Ljava/io/IOException;)V
    :try_end_1
    .catchall {:try_start_1 .. :try_end_1} :catchall_0

    goto :goto_0

    .line 169
    :catchall_0
    move-exception v0

    monitor-exit p0

    throw v0
.end method

.method public skip(J)J
    .locals 3
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljava/io/IOException;
        }
    .end annotation

    .prologue
    .line 118
    :try_start_0
    iget-object v0, p0, Lorg/apache/commons/io/input/ProxyInputStream;->in:Ljava/io/InputStream;

    invoke-virtual {v0, p1, p2}, Ljava/io/InputStream;->skip(J)J
    :try_end_0
    .catch Ljava/io/IOException; {:try_start_0 .. :try_end_0} :catch_0

    move-result-wide v0

    .line 121
    :goto_0
    return-wide v0

    .line 119
    :catch_0
    move-exception v0

    .line 120
    invoke-virtual {p0, v0}, Lorg/apache/commons/io/input/ProxyInputStream;->handleIOException(Ljava/io/IOException;)V

    .line 121
    const-wide/16 v0, 0x0

    goto :goto_0
.end method
