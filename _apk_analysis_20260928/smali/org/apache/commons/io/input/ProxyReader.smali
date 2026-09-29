.class public abstract Lorg/apache/commons/io/input/ProxyReader;
.super Ljava/io/FilterReader;
.source "SourceFile"


# direct methods
.method public constructor <init>(Ljava/io/Reader;)V
    .locals 0

    .prologue
    .line 45
    invoke-direct {p0, p1}, Ljava/io/FilterReader;-><init>(Ljava/io/Reader;)V

    .line 47
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
    .line 246
    return-void
.end method

.method protected beforeRead(I)V
    .locals 0
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljava/io/IOException;
        }
    .end annotation

    .prologue
    .line 226
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
    .line 165
    :try_start_0
    iget-object v0, p0, Lorg/apache/commons/io/input/ProxyReader;->in:Ljava/io/Reader;

    invoke-virtual {v0}, Ljava/io/Reader;->close()V
    :try_end_0
    .catch Ljava/io/IOException; {:try_start_0 .. :try_end_0} :catch_0

    .line 169
    :goto_0
    return-void

    .line 166
    :catch_0
    move-exception v0

    .line 167
    invoke-virtual {p0, v0}, Lorg/apache/commons/io/input/ProxyReader;->handleIOException(Ljava/io/IOException;)V

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
    .line 258
    throw p1
.end method

.method public declared-synchronized mark(I)V
    .locals 1
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljava/io/IOException;
        }
    .end annotation

    .prologue
    .line 179
    monitor-enter p0

    :try_start_0
    iget-object v0, p0, Lorg/apache/commons/io/input/ProxyReader;->in:Ljava/io/Reader;

    invoke-virtual {v0, p1}, Ljava/io/Reader;->mark(I)V
    :try_end_0
    .catch Ljava/io/IOException; {:try_start_0 .. :try_end_0} :catch_0
    .catchall {:try_start_0 .. :try_end_0} :catchall_0

    .line 183
    :goto_0
    monitor-exit p0

    return-void

    .line 180
    :catch_0
    move-exception v0

    .line 181
    :try_start_1
    invoke-virtual {p0, v0}, Lorg/apache/commons/io/input/ProxyReader;->handleIOException(Ljava/io/IOException;)V
    :try_end_1
    .catchall {:try_start_1 .. :try_end_1} :catchall_0

    goto :goto_0

    .line 179
    :catchall_0
    move-exception v0

    monitor-exit p0

    throw v0
.end method

.method public markSupported()Z
    .locals 1

    .prologue
    .line 204
    iget-object v0, p0, Lorg/apache/commons/io/input/ProxyReader;->in:Ljava/io/Reader;

    invoke-virtual {v0}, Ljava/io/Reader;->markSupported()Z

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

    .line 57
    const/4 v0, 0x1

    :try_start_0
    invoke-virtual {p0, v0}, Lorg/apache/commons/io/input/ProxyReader;->beforeRead(I)V

    .line 58
    iget-object v0, p0, Lorg/apache/commons/io/input/ProxyReader;->in:Ljava/io/Reader;

    invoke-virtual {v0}, Ljava/io/Reader;->read()I

    move-result v0

    .line 59
    if-eq v0, v1, :cond_0

    :goto_0
    invoke-virtual {p0, v2}, Lorg/apache/commons/io/input/ProxyReader;->afterRead(I)V
    :try_end_0
    .catch Ljava/io/IOException; {:try_start_0 .. :try_end_0} :catch_0

    .line 63
    :goto_1
    return v0

    :cond_0
    move v2, v1

    .line 59
    goto :goto_0

    .line 61
    :catch_0
    move-exception v0

    .line 62
    invoke-virtual {p0, v0}, Lorg/apache/commons/io/input/ProxyReader;->handleIOException(Ljava/io/IOException;)V

    move v0, v1

    .line 63
    goto :goto_1
.end method

.method public read(Ljava/nio/CharBuffer;)I
    .locals 1
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljava/io/IOException;
        }
    .end annotation

    .prologue
    .line 117
    if-eqz p1, :cond_0

    :try_start_0
    invoke-virtual {p1}, Ljava/nio/CharBuffer;->length()I

    move-result v0

    :goto_0
    invoke-virtual {p0, v0}, Lorg/apache/commons/io/input/ProxyReader;->beforeRead(I)V

    .line 118
    iget-object v0, p0, Lorg/apache/commons/io/input/ProxyReader;->in:Ljava/io/Reader;

    invoke-virtual {v0, p1}, Ljava/io/Reader;->read(Ljava/nio/CharBuffer;)I

    move-result v0

    .line 119
    invoke-virtual {p0, v0}, Lorg/apache/commons/io/input/ProxyReader;->afterRead(I)V
    :try_end_0
    .catch Ljava/io/IOException; {:try_start_0 .. :try_end_0} :catch_0

    .line 123
    :goto_1
    return v0

    .line 117
    :cond_0
    const/4 v0, 0x0

    goto :goto_0

    .line 121
    :catch_0
    move-exception v0

    .line 122
    invoke-virtual {p0, v0}, Lorg/apache/commons/io/input/ProxyReader;->handleIOException(Ljava/io/IOException;)V

    .line 123
    const/4 v0, -0x1

    goto :goto_1
.end method

.method public read([C)I
    .locals 1
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljava/io/IOException;
        }
    .end annotation

    .prologue
    .line 76
    if-eqz p1, :cond_0

    :try_start_0
    array-length v0, p1

    :goto_0
    invoke-virtual {p0, v0}, Lorg/apache/commons/io/input/ProxyReader;->beforeRead(I)V

    .line 77
    iget-object v0, p0, Lorg/apache/commons/io/input/ProxyReader;->in:Ljava/io/Reader;

    invoke-virtual {v0, p1}, Ljava/io/Reader;->read([C)I

    move-result v0

    .line 78
    invoke-virtual {p0, v0}, Lorg/apache/commons/io/input/ProxyReader;->afterRead(I)V
    :try_end_0
    .catch Ljava/io/IOException; {:try_start_0 .. :try_end_0} :catch_0

    .line 82
    :goto_1
    return v0

    .line 76
    :cond_0
    const/4 v0, 0x0

    goto :goto_0

    .line 80
    :catch_0
    move-exception v0

    .line 81
    invoke-virtual {p0, v0}, Lorg/apache/commons/io/input/ProxyReader;->handleIOException(Ljava/io/IOException;)V

    .line 82
    const/4 v0, -0x1

    goto :goto_1
.end method

.method public read([CII)I
    .locals 1
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljava/io/IOException;
        }
    .end annotation

    .prologue
    .line 97
    :try_start_0
    invoke-virtual {p0, p3}, Lorg/apache/commons/io/input/ProxyReader;->beforeRead(I)V

    .line 98
    iget-object v0, p0, Lorg/apache/commons/io/input/ProxyReader;->in:Ljava/io/Reader;

    invoke-virtual {v0, p1, p2, p3}, Ljava/io/Reader;->read([CII)I

    move-result v0

    .line 99
    invoke-virtual {p0, v0}, Lorg/apache/commons/io/input/ProxyReader;->afterRead(I)V
    :try_end_0
    .catch Ljava/io/IOException; {:try_start_0 .. :try_end_0} :catch_0

    .line 103
    :goto_0
    return v0

    .line 101
    :catch_0
    move-exception v0

    .line 102
    invoke-virtual {p0, v0}, Lorg/apache/commons/io/input/ProxyReader;->handleIOException(Ljava/io/IOException;)V

    .line 103
    const/4 v0, -0x1

    goto :goto_0
.end method

.method public ready()Z
    .locals 1
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljava/io/IOException;
        }
    .end annotation

    .prologue
    .line 151
    :try_start_0
    iget-object v0, p0, Lorg/apache/commons/io/input/ProxyReader;->in:Ljava/io/Reader;

    invoke-virtual {v0}, Ljava/io/Reader;->ready()Z
    :try_end_0
    .catch Ljava/io/IOException; {:try_start_0 .. :try_end_0} :catch_0

    move-result v0

    .line 154
    :goto_0
    return v0

    .line 152
    :catch_0
    move-exception v0

    .line 153
    invoke-virtual {p0, v0}, Lorg/apache/commons/io/input/ProxyReader;->handleIOException(Ljava/io/IOException;)V

    .line 154
    const/4 v0, 0x0

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
    .line 192
    monitor-enter p0

    :try_start_0
    iget-object v0, p0, Lorg/apache/commons/io/input/ProxyReader;->in:Ljava/io/Reader;

    invoke-virtual {v0}, Ljava/io/Reader;->reset()V
    :try_end_0
    .catch Ljava/io/IOException; {:try_start_0 .. :try_end_0} :catch_0
    .catchall {:try_start_0 .. :try_end_0} :catchall_0

    .line 196
    :goto_0
    monitor-exit p0

    return-void

    .line 193
    :catch_0
    move-exception v0

    .line 194
    :try_start_1
    invoke-virtual {p0, v0}, Lorg/apache/commons/io/input/ProxyReader;->handleIOException(Ljava/io/IOException;)V
    :try_end_1
    .catchall {:try_start_1 .. :try_end_1} :catchall_0

    goto :goto_0

    .line 192
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
    .line 136
    :try_start_0
    iget-object v0, p0, Lorg/apache/commons/io/input/ProxyReader;->in:Ljava/io/Reader;

    invoke-virtual {v0, p1, p2}, Ljava/io/Reader;->skip(J)J
    :try_end_0
    .catch Ljava/io/IOException; {:try_start_0 .. :try_end_0} :catch_0

    move-result-wide v0

    .line 139
    :goto_0
    return-wide v0

    .line 137
    :catch_0
    move-exception v0

    .line 138
    invoke-virtual {p0, v0}, Lorg/apache/commons/io/input/ProxyReader;->handleIOException(Ljava/io/IOException;)V

    .line 139
    const-wide/16 v0, 0x0

    goto :goto_0
.end method
