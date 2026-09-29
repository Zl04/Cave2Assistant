.class final Lcom/b/b/b;
.super Ljava/lang/Object;
.source "SourceFile"

# interfaces
.implements Lcom/b/b/w;


# instance fields
.field final synthetic a:Lcom/b/b/w;

.field final synthetic b:Lcom/b/b/a;


# direct methods
.method constructor <init>(Lcom/b/b/a;Lcom/b/b/w;)V
    .locals 0

    .prologue
    .line 159
    iput-object p1, p0, Lcom/b/b/b;->b:Lcom/b/b/a;

    iput-object p2, p0, Lcom/b/b/b;->a:Lcom/b/b/w;

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method


# virtual methods
.method public final a()Lcom/b/b/y;
    .locals 1

    .prologue
    .line 217
    iget-object v0, p0, Lcom/b/b/b;->b:Lcom/b/b/a;

    return-object v0
.end method

.method public final a_(Lcom/b/b/f;J)V
    .locals 8

    .prologue
    const-wide/16 v2, 0x0

    .line 161
    iget-wide v0, p1, Lcom/b/b/f;->b:J

    move-wide v4, p2

    invoke-static/range {v0 .. v5}, Lcom/b/b/aa;->a(JJJ)V

    move-wide v4, p2

    .line 163
    :goto_0
    cmp-long v0, v4, v2

    if-lez v0, :cond_2

    .line 166
    iget-object v0, p1, Lcom/b/b/f;->a:Lcom/b/b/t;

    move-wide v0, v2

    :cond_0
    const-wide/32 v6, 0x10000

    cmp-long v6, v0, v6

    if-gez v6, :cond_1

    .line 167
    iget-object v6, p1, Lcom/b/b/f;->a:Lcom/b/b/t;

    iget v6, v6, Lcom/b/b/t;->c:I

    iget-object v7, p1, Lcom/b/b/f;->a:Lcom/b/b/t;

    iget v7, v7, Lcom/b/b/t;->b:I

    sub-int/2addr v6, v7

    .line 168
    int-to-long v6, v6

    add-long/2addr v0, v6

    .line 169
    cmp-long v6, v0, v4

    if-ltz v6, :cond_0

    move-wide v0, v4

    .line 177
    :cond_1
    iget-object v6, p0, Lcom/b/b/b;->b:Lcom/b/b/a;

    invoke-virtual {v6}, Lcom/b/b/a;->c()V

    .line 179
    :try_start_0
    iget-object v6, p0, Lcom/b/b/b;->a:Lcom/b/b/w;

    invoke-interface {v6, p1, v0, v1}, Lcom/b/b/w;->a_(Lcom/b/b/f;J)V
    :try_end_0
    .catch Ljava/io/IOException; {:try_start_0 .. :try_end_0} :catch_0
    .catchall {:try_start_0 .. :try_end_0} :catchall_0

    .line 180
    sub-long/2addr v4, v0

    .line 185
    iget-object v0, p0, Lcom/b/b/b;->b:Lcom/b/b/a;

    const/4 v1, 0x1

    invoke-virtual {v0, v1}, Lcom/b/b/a;->a(Z)V

    goto :goto_0

    .line 182
    :catch_0
    move-exception v0

    .line 183
    :try_start_1
    iget-object v1, p0, Lcom/b/b/b;->b:Lcom/b/b/a;

    invoke-virtual {v1, v0}, Lcom/b/b/a;->b(Ljava/io/IOException;)Ljava/io/IOException;

    move-result-object v0

    throw v0
    :try_end_1
    .catchall {:try_start_1 .. :try_end_1} :catchall_0

    .line 185
    :catchall_0
    move-exception v0

    iget-object v1, p0, Lcom/b/b/b;->b:Lcom/b/b/a;

    const/4 v2, 0x0

    invoke-virtual {v1, v2}, Lcom/b/b/a;->a(Z)V

    throw v0

    .line 188
    :cond_2
    return-void
.end method

.method public final close()V
    .locals 3

    .prologue
    .line 205
    iget-object v0, p0, Lcom/b/b/b;->b:Lcom/b/b/a;

    invoke-virtual {v0}, Lcom/b/b/a;->c()V

    .line 207
    :try_start_0
    iget-object v0, p0, Lcom/b/b/b;->a:Lcom/b/b/w;

    invoke-interface {v0}, Lcom/b/b/w;->close()V
    :try_end_0
    .catch Ljava/io/IOException; {:try_start_0 .. :try_end_0} :catch_0
    .catchall {:try_start_0 .. :try_end_0} :catchall_0

    .line 212
    iget-object v0, p0, Lcom/b/b/b;->b:Lcom/b/b/a;

    const/4 v1, 0x1

    invoke-virtual {v0, v1}, Lcom/b/b/a;->a(Z)V

    .line 213
    return-void

    .line 209
    :catch_0
    move-exception v0

    .line 210
    :try_start_1
    iget-object v1, p0, Lcom/b/b/b;->b:Lcom/b/b/a;

    invoke-virtual {v1, v0}, Lcom/b/b/a;->b(Ljava/io/IOException;)Ljava/io/IOException;

    move-result-object v0

    throw v0
    :try_end_1
    .catchall {:try_start_1 .. :try_end_1} :catchall_0

    .line 212
    :catchall_0
    move-exception v0

    iget-object v1, p0, Lcom/b/b/b;->b:Lcom/b/b/a;

    const/4 v2, 0x0

    invoke-virtual {v1, v2}, Lcom/b/b/a;->a(Z)V

    throw v0
.end method

.method public final flush()V
    .locals 3

    .prologue
    .line 192
    iget-object v0, p0, Lcom/b/b/b;->b:Lcom/b/b/a;

    invoke-virtual {v0}, Lcom/b/b/a;->c()V

    .line 194
    :try_start_0
    iget-object v0, p0, Lcom/b/b/b;->a:Lcom/b/b/w;

    invoke-interface {v0}, Lcom/b/b/w;->flush()V
    :try_end_0
    .catch Ljava/io/IOException; {:try_start_0 .. :try_end_0} :catch_0
    .catchall {:try_start_0 .. :try_end_0} :catchall_0

    .line 199
    iget-object v0, p0, Lcom/b/b/b;->b:Lcom/b/b/a;

    const/4 v1, 0x1

    invoke-virtual {v0, v1}, Lcom/b/b/a;->a(Z)V

    .line 200
    return-void

    .line 196
    :catch_0
    move-exception v0

    .line 197
    :try_start_1
    iget-object v1, p0, Lcom/b/b/b;->b:Lcom/b/b/a;

    invoke-virtual {v1, v0}, Lcom/b/b/a;->b(Ljava/io/IOException;)Ljava/io/IOException;

    move-result-object v0

    throw v0
    :try_end_1
    .catchall {:try_start_1 .. :try_end_1} :catchall_0

    .line 199
    :catchall_0
    move-exception v0

    iget-object v1, p0, Lcom/b/b/b;->b:Lcom/b/b/a;

    const/4 v2, 0x0

    invoke-virtual {v1, v2}, Lcom/b/b/a;->a(Z)V

    throw v0
.end method

.method public final toString()Ljava/lang/String;
    .locals 2

    .prologue
    .line 221
    new-instance v0, Ljava/lang/StringBuilder;

    const-string v1, "AsyncTimeout.sink("

    invoke-direct {v0, v1}, Ljava/lang/StringBuilder;-><init>(Ljava/lang/String;)V

    iget-object v1, p0, Lcom/b/b/b;->a:Lcom/b/b/w;

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/Object;)Ljava/lang/StringBuilder;

    move-result-object v0

    const-string v1, ")"

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-virtual {v0}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v0

    return-object v0
.end method
