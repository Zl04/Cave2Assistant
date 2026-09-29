.class final Lcom/b/b/c;
.super Ljava/lang/Object;
.source "SourceFile"

# interfaces
.implements Lcom/b/b/x;


# instance fields
.field final synthetic a:Lcom/b/b/x;

.field final synthetic b:Lcom/b/b/a;


# direct methods
.method constructor <init>(Lcom/b/b/a;Lcom/b/b/x;)V
    .locals 0

    .prologue
    .line 231
    iput-object p1, p0, Lcom/b/b/c;->b:Lcom/b/b/a;

    iput-object p2, p0, Lcom/b/b/c;->a:Lcom/b/b/x;

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method


# virtual methods
.method public final a(Lcom/b/b/f;J)J
    .locals 4

    .prologue
    .line 233
    const/4 v1, 0x0

    .line 234
    iget-object v0, p0, Lcom/b/b/c;->b:Lcom/b/b/a;

    invoke-virtual {v0}, Lcom/b/b/a;->c()V

    .line 236
    :try_start_0
    iget-object v0, p0, Lcom/b/b/c;->a:Lcom/b/b/x;

    invoke-interface {v0, p1, p2, p3}, Lcom/b/b/x;->a(Lcom/b/b/f;J)J
    :try_end_0
    .catch Ljava/io/IOException; {:try_start_0 .. :try_end_0} :catch_0
    .catchall {:try_start_0 .. :try_end_0} :catchall_0

    move-result-wide v0

    .line 242
    iget-object v2, p0, Lcom/b/b/c;->b:Lcom/b/b/a;

    const/4 v3, 0x1

    invoke-virtual {v2, v3}, Lcom/b/b/a;->a(Z)V

    .line 238
    return-wide v0

    .line 239
    :catch_0
    move-exception v0

    .line 240
    :try_start_1
    iget-object v2, p0, Lcom/b/b/c;->b:Lcom/b/b/a;

    invoke-virtual {v2, v0}, Lcom/b/b/a;->b(Ljava/io/IOException;)Ljava/io/IOException;

    move-result-object v0

    throw v0
    :try_end_1
    .catchall {:try_start_1 .. :try_end_1} :catchall_0

    .line 242
    :catchall_0
    move-exception v0

    iget-object v2, p0, Lcom/b/b/c;->b:Lcom/b/b/a;

    invoke-virtual {v2, v1}, Lcom/b/b/a;->a(Z)V

    throw v0
.end method

.method public final a()Lcom/b/b/y;
    .locals 1

    .prologue
    .line 259
    iget-object v0, p0, Lcom/b/b/c;->b:Lcom/b/b/a;

    return-object v0
.end method

.method public final close()V
    .locals 3

    .prologue
    .line 249
    :try_start_0
    iget-object v0, p0, Lcom/b/b/c;->a:Lcom/b/b/x;

    invoke-interface {v0}, Lcom/b/b/x;->close()V
    :try_end_0
    .catch Ljava/io/IOException; {:try_start_0 .. :try_end_0} :catch_0
    .catchall {:try_start_0 .. :try_end_0} :catchall_0

    .line 254
    iget-object v0, p0, Lcom/b/b/c;->b:Lcom/b/b/a;

    const/4 v1, 0x1

    invoke-virtual {v0, v1}, Lcom/b/b/a;->a(Z)V

    .line 255
    return-void

    .line 251
    :catch_0
    move-exception v0

    .line 252
    :try_start_1
    iget-object v1, p0, Lcom/b/b/c;->b:Lcom/b/b/a;

    invoke-virtual {v1, v0}, Lcom/b/b/a;->b(Ljava/io/IOException;)Ljava/io/IOException;

    move-result-object v0

    throw v0
    :try_end_1
    .catchall {:try_start_1 .. :try_end_1} :catchall_0

    .line 254
    :catchall_0
    move-exception v0

    iget-object v1, p0, Lcom/b/b/c;->b:Lcom/b/b/a;

    const/4 v2, 0x0

    invoke-virtual {v1, v2}, Lcom/b/b/a;->a(Z)V

    throw v0
.end method

.method public final toString()Ljava/lang/String;
    .locals 2

    .prologue
    .line 263
    new-instance v0, Ljava/lang/StringBuilder;

    const-string v1, "AsyncTimeout.source("

    invoke-direct {v0, v1}, Ljava/lang/StringBuilder;-><init>(Ljava/lang/String;)V

    iget-object v1, p0, Lcom/b/b/c;->a:Lcom/b/b/x;

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/Object;)Ljava/lang/StringBuilder;

    move-result-object v0

    const-string v1, ")"

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-virtual {v0}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v0

    return-object v0
.end method
