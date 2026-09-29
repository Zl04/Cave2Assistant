.class final Lcom/b/a/a/d/c;
.super Ljava/lang/Object;
.source "SourceFile"

# interfaces
.implements Lcom/b/b/w;


# instance fields
.field final synthetic a:Lcom/b/a/a/d/a;

.field private final b:Lcom/b/b/k;

.field private c:Z


# direct methods
.method constructor <init>(Lcom/b/a/a/d/a;)V
    .locals 2

    .prologue
    .line 312
    iput-object p1, p0, Lcom/b/a/a/d/c;->a:Lcom/b/a/a/d/a;

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    .line 309
    new-instance v0, Lcom/b/b/k;

    iget-object v1, p0, Lcom/b/a/a/d/c;->a:Lcom/b/a/a/d/a;

    iget-object v1, v1, Lcom/b/a/a/d/a;->d:Lcom/b/b/g;

    invoke-interface {v1}, Lcom/b/b/g;->a()Lcom/b/b/y;

    move-result-object v1

    invoke-direct {v0, v1}, Lcom/b/b/k;-><init>(Lcom/b/b/y;)V

    iput-object v0, p0, Lcom/b/a/a/d/c;->b:Lcom/b/b/k;

    .line 313
    return-void
.end method


# virtual methods
.method public final a()Lcom/b/b/y;
    .locals 1

    .prologue
    .line 316
    iget-object v0, p0, Lcom/b/a/a/d/c;->b:Lcom/b/b/k;

    return-object v0
.end method

.method public final a_(Lcom/b/b/f;J)V
    .locals 2

    .prologue
    .line 320
    iget-boolean v0, p0, Lcom/b/a/a/d/c;->c:Z

    if-eqz v0, :cond_0

    new-instance v0, Ljava/lang/IllegalStateException;

    const-string v1, "closed"

    invoke-direct {v0, v1}, Ljava/lang/IllegalStateException;-><init>(Ljava/lang/String;)V

    throw v0

    .line 321
    :cond_0
    const-wide/16 v0, 0x0

    cmp-long v0, p2, v0

    if-nez v0, :cond_1

    .line 327
    :goto_0
    return-void

    .line 323
    :cond_1
    iget-object v0, p0, Lcom/b/a/a/d/c;->a:Lcom/b/a/a/d/a;

    iget-object v0, v0, Lcom/b/a/a/d/a;->d:Lcom/b/b/g;

    invoke-interface {v0, p2, p3}, Lcom/b/b/g;->i(J)Lcom/b/b/g;

    .line 324
    iget-object v0, p0, Lcom/b/a/a/d/c;->a:Lcom/b/a/a/d/a;

    iget-object v0, v0, Lcom/b/a/a/d/a;->d:Lcom/b/b/g;

    const-string v1, "\r\n"

    invoke-interface {v0, v1}, Lcom/b/b/g;->b(Ljava/lang/String;)Lcom/b/b/g;

    .line 325
    iget-object v0, p0, Lcom/b/a/a/d/c;->a:Lcom/b/a/a/d/a;

    iget-object v0, v0, Lcom/b/a/a/d/a;->d:Lcom/b/b/g;

    invoke-interface {v0, p1, p2, p3}, Lcom/b/b/g;->a_(Lcom/b/b/f;J)V

    .line 326
    iget-object v0, p0, Lcom/b/a/a/d/c;->a:Lcom/b/a/a/d/a;

    iget-object v0, v0, Lcom/b/a/a/d/a;->d:Lcom/b/b/g;

    const-string v1, "\r\n"

    invoke-interface {v0, v1}, Lcom/b/b/g;->b(Ljava/lang/String;)Lcom/b/b/g;

    goto :goto_0
.end method

.method public final declared-synchronized close()V
    .locals 2

    .prologue
    .line 335
    monitor-enter p0

    :try_start_0
    iget-boolean v0, p0, Lcom/b/a/a/d/c;->c:Z
    :try_end_0
    .catchall {:try_start_0 .. :try_end_0} :catchall_0

    if-eqz v0, :cond_0

    .line 340
    :goto_0
    monitor-exit p0

    return-void

    .line 336
    :cond_0
    const/4 v0, 0x1

    :try_start_1
    iput-boolean v0, p0, Lcom/b/a/a/d/c;->c:Z

    .line 337
    iget-object v0, p0, Lcom/b/a/a/d/c;->a:Lcom/b/a/a/d/a;

    iget-object v0, v0, Lcom/b/a/a/d/a;->d:Lcom/b/b/g;

    const-string v1, "0\r\n\r\n"

    invoke-interface {v0, v1}, Lcom/b/b/g;->b(Ljava/lang/String;)Lcom/b/b/g;

    .line 338
    iget-object v0, p0, Lcom/b/a/a/d/c;->b:Lcom/b/b/k;

    invoke-static {v0}, Lcom/b/a/a/d/a;->a(Lcom/b/b/k;)V

    .line 339
    iget-object v0, p0, Lcom/b/a/a/d/c;->a:Lcom/b/a/a/d/a;

    const/4 v1, 0x3

    iput v1, v0, Lcom/b/a/a/d/a;->e:I
    :try_end_1
    .catchall {:try_start_1 .. :try_end_1} :catchall_0

    goto :goto_0

    .line 335
    :catchall_0
    move-exception v0

    monitor-exit p0

    throw v0
.end method

.method public final declared-synchronized flush()V
    .locals 1

    .prologue
    .line 330
    monitor-enter p0

    :try_start_0
    iget-boolean v0, p0, Lcom/b/a/a/d/c;->c:Z
    :try_end_0
    .catchall {:try_start_0 .. :try_end_0} :catchall_0

    if-eqz v0, :cond_0

    .line 332
    :goto_0
    monitor-exit p0

    return-void

    .line 331
    :cond_0
    :try_start_1
    iget-object v0, p0, Lcom/b/a/a/d/c;->a:Lcom/b/a/a/d/a;

    iget-object v0, v0, Lcom/b/a/a/d/a;->d:Lcom/b/b/g;

    invoke-interface {v0}, Lcom/b/b/g;->flush()V
    :try_end_1
    .catchall {:try_start_1 .. :try_end_1} :catchall_0

    goto :goto_0

    .line 330
    :catchall_0
    move-exception v0

    monitor-exit p0

    throw v0
.end method
