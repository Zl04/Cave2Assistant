.class final Lcom/b/a/a/d/d;
.super Lcom/b/a/a/d/b;
.source "SourceFile"


# instance fields
.field final synthetic d:Lcom/b/a/a/d/a;

.field private final e:Lcom/b/a/ac;

.field private f:J

.field private g:Z


# direct methods
.method constructor <init>(Lcom/b/a/a/d/a;Lcom/b/a/ac;)V
    .locals 2

    .prologue
    .line 415
    iput-object p1, p0, Lcom/b/a/a/d/d;->d:Lcom/b/a/a/d/a;

    const/4 v0, 0x0

    invoke-direct {p0, p1, v0}, Lcom/b/a/a/d/b;-><init>(Lcom/b/a/a/d/a;B)V

    .line 412
    const-wide/16 v0, -0x1

    iput-wide v0, p0, Lcom/b/a/a/d/d;->f:J

    .line 413
    const/4 v0, 0x1

    iput-boolean v0, p0, Lcom/b/a/a/d/d;->g:Z

    .line 416
    iput-object p2, p0, Lcom/b/a/a/d/d;->e:Lcom/b/a/ac;

    .line 417
    return-void
.end method


# virtual methods
.method public final a(Lcom/b/b/f;J)J
    .locals 10

    .prologue
    const/4 v8, 0x0

    const-wide/16 v6, 0x0

    const-wide/16 v0, -0x1

    .line 420
    cmp-long v2, p2, v6

    if-gez v2, :cond_0

    new-instance v0, Ljava/lang/IllegalArgumentException;

    new-instance v1, Ljava/lang/StringBuilder;

    const-string v2, "byteCount < 0: "

    invoke-direct {v1, v2}, Ljava/lang/StringBuilder;-><init>(Ljava/lang/String;)V

    invoke-virtual {v1, p2, p3}, Ljava/lang/StringBuilder;->append(J)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v1

    invoke-direct {v0, v1}, Ljava/lang/IllegalArgumentException;-><init>(Ljava/lang/String;)V

    throw v0

    .line 421
    :cond_0
    iget-boolean v2, p0, Lcom/b/a/a/d/d;->b:Z

    if-eqz v2, :cond_1

    new-instance v0, Ljava/lang/IllegalStateException;

    const-string v1, "closed"

    invoke-direct {v0, v1}, Ljava/lang/IllegalStateException;-><init>(Ljava/lang/String;)V

    throw v0

    .line 422
    :cond_1
    iget-boolean v2, p0, Lcom/b/a/a/d/d;->g:Z

    if-nez v2, :cond_3

    .line 435
    :cond_2
    :goto_0
    return-wide v0

    .line 424
    :cond_3
    iget-wide v2, p0, Lcom/b/a/a/d/d;->f:J

    cmp-long v2, v2, v6

    if-eqz v2, :cond_4

    iget-wide v2, p0, Lcom/b/a/a/d/d;->f:J

    cmp-long v2, v2, v0

    if-nez v2, :cond_9

    .line 1440
    :cond_4
    iget-wide v2, p0, Lcom/b/a/a/d/d;->f:J

    cmp-long v2, v2, v0

    if-eqz v2, :cond_5

    .line 1441
    iget-object v2, p0, Lcom/b/a/a/d/d;->d:Lcom/b/a/a/d/a;

    iget-object v2, v2, Lcom/b/a/a/d/a;->c:Lcom/b/b/h;

    invoke-interface {v2}, Lcom/b/b/h;->m()Ljava/lang/String;

    .line 1444
    :cond_5
    :try_start_0
    iget-object v2, p0, Lcom/b/a/a/d/d;->d:Lcom/b/a/a/d/a;

    iget-object v2, v2, Lcom/b/a/a/d/a;->c:Lcom/b/b/h;

    invoke-interface {v2}, Lcom/b/b/h;->j()J

    move-result-wide v2

    iput-wide v2, p0, Lcom/b/a/a/d/d;->f:J

    .line 1445
    iget-object v2, p0, Lcom/b/a/a/d/d;->d:Lcom/b/a/a/d/a;

    iget-object v2, v2, Lcom/b/a/a/d/a;->c:Lcom/b/b/h;

    invoke-interface {v2}, Lcom/b/b/h;->m()Ljava/lang/String;

    move-result-object v2

    invoke-virtual {v2}, Ljava/lang/String;->trim()Ljava/lang/String;

    move-result-object v2

    .line 1446
    iget-wide v4, p0, Lcom/b/a/a/d/d;->f:J

    cmp-long v3, v4, v6

    if-ltz v3, :cond_6

    invoke-virtual {v2}, Ljava/lang/String;->isEmpty()Z

    move-result v3

    if-nez v3, :cond_7

    const-string v3, ";"

    invoke-virtual {v2, v3}, Ljava/lang/String;->startsWith(Ljava/lang/String;)Z

    move-result v3

    if-nez v3, :cond_7

    .line 1447
    :cond_6
    new-instance v0, Ljava/net/ProtocolException;

    new-instance v1, Ljava/lang/StringBuilder;

    const-string v3, "expected chunk size and optional extensions but was \""

    invoke-direct {v1, v3}, Ljava/lang/StringBuilder;-><init>(Ljava/lang/String;)V

    iget-wide v4, p0, Lcom/b/a/a/d/d;->f:J

    invoke-virtual {v1, v4, v5}, Ljava/lang/StringBuilder;->append(J)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    const-string v2, "\""

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v1

    invoke-direct {v0, v1}, Ljava/net/ProtocolException;-><init>(Ljava/lang/String;)V

    throw v0
    :try_end_0
    .catch Ljava/lang/NumberFormatException; {:try_start_0 .. :try_end_0} :catch_0

    .line 1450
    :catch_0
    move-exception v0

    .line 1451
    new-instance v1, Ljava/net/ProtocolException;

    invoke-virtual {v0}, Ljava/lang/NumberFormatException;->getMessage()Ljava/lang/String;

    move-result-object v0

    invoke-direct {v1, v0}, Ljava/net/ProtocolException;-><init>(Ljava/lang/String;)V

    throw v1

    .line 1453
    :cond_7
    iget-wide v2, p0, Lcom/b/a/a/d/d;->f:J

    cmp-long v2, v2, v6

    if-nez v2, :cond_8

    .line 1454
    iput-boolean v8, p0, Lcom/b/a/a/d/d;->g:Z

    .line 1455
    iget-object v2, p0, Lcom/b/a/a/d/d;->d:Lcom/b/a/a/d/a;

    iget-object v2, v2, Lcom/b/a/a/d/a;->a:Lcom/b/a/ai;

    invoke-virtual {v2}, Lcom/b/a/ai;->f()Lcom/b/a/s;

    move-result-object v2

    iget-object v3, p0, Lcom/b/a/a/d/d;->e:Lcom/b/a/ac;

    iget-object v4, p0, Lcom/b/a/a/d/d;->d:Lcom/b/a/a/d/a;

    invoke-virtual {v4}, Lcom/b/a/a/d/a;->c()Lcom/b/a/aa;

    move-result-object v4

    invoke-static {v2, v3, v4}, Lcom/b/a/a/c/f;->a(Lcom/b/a/s;Lcom/b/a/ac;Lcom/b/a/aa;)V

    .line 1456
    const/4 v2, 0x1

    invoke-virtual {p0, v2}, Lcom/b/a/a/d/d;->a(Z)V

    .line 426
    :cond_8
    iget-boolean v2, p0, Lcom/b/a/a/d/d;->g:Z

    if-eqz v2, :cond_2

    .line 429
    :cond_9
    iget-object v2, p0, Lcom/b/a/a/d/d;->d:Lcom/b/a/a/d/a;

    iget-object v2, v2, Lcom/b/a/a/d/a;->c:Lcom/b/b/h;

    iget-wide v4, p0, Lcom/b/a/a/d/d;->f:J

    invoke-static {p2, p3, v4, v5}, Ljava/lang/Math;->min(JJ)J

    move-result-wide v4

    invoke-interface {v2, p1, v4, v5}, Lcom/b/b/h;->a(Lcom/b/b/f;J)J

    move-result-wide v2

    .line 430
    cmp-long v0, v2, v0

    if-nez v0, :cond_a

    .line 431
    invoke-virtual {p0, v8}, Lcom/b/a/a/d/d;->a(Z)V

    .line 432
    new-instance v0, Ljava/net/ProtocolException;

    const-string v1, "unexpected end of stream"

    invoke-direct {v0, v1}, Ljava/net/ProtocolException;-><init>(Ljava/lang/String;)V

    throw v0

    .line 434
    :cond_a
    iget-wide v0, p0, Lcom/b/a/a/d/d;->f:J

    sub-long/2addr v0, v2

    iput-wide v0, p0, Lcom/b/a/a/d/d;->f:J

    move-wide v0, v2

    .line 435
    goto/16 :goto_0
.end method

.method public final close()V
    .locals 1

    .prologue
    .line 461
    iget-boolean v0, p0, Lcom/b/a/a/d/d;->b:Z

    if-eqz v0, :cond_0

    .line 466
    :goto_0
    return-void

    .line 462
    :cond_0
    iget-boolean v0, p0, Lcom/b/a/a/d/d;->g:Z

    if-eqz v0, :cond_1

    sget-object v0, Ljava/util/concurrent/TimeUnit;->MILLISECONDS:Ljava/util/concurrent/TimeUnit;

    invoke-static {p0, v0}, Lcom/b/a/a/c;->a(Lcom/b/b/x;Ljava/util/concurrent/TimeUnit;)Z

    move-result v0

    if-nez v0, :cond_1

    .line 463
    const/4 v0, 0x0

    invoke-virtual {p0, v0}, Lcom/b/a/a/d/d;->a(Z)V

    .line 465
    :cond_1
    const/4 v0, 0x1

    iput-boolean v0, p0, Lcom/b/a/a/d/d;->b:Z

    goto :goto_0
.end method
