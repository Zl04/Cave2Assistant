.class public final Lcom/b/a/at;
.super Ljava/lang/Object;
.source "SourceFile"


# instance fields
.field a:Lcom/b/a/ao;

.field b:Lcom/b/a/al;

.field c:I

.field d:Ljava/lang/String;

.field e:Lcom/b/a/z;

.field f:Lcom/b/a/ab;

.field g:Lcom/b/a/au;

.field h:Lcom/b/a/as;

.field i:Lcom/b/a/as;

.field j:Lcom/b/a/as;

.field k:J

.field l:J


# direct methods
.method public constructor <init>()V
    .locals 1

    .prologue
    .line 302
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    .line 291
    const/4 v0, -0x1

    iput v0, p0, Lcom/b/a/at;->c:I

    .line 303
    new-instance v0, Lcom/b/a/ab;

    invoke-direct {v0}, Lcom/b/a/ab;-><init>()V

    iput-object v0, p0, Lcom/b/a/at;->f:Lcom/b/a/ab;

    .line 304
    return-void
.end method

.method constructor <init>(Lcom/b/a/as;)V
    .locals 2

    .prologue
    .line 306
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    .line 291
    const/4 v0, -0x1

    iput v0, p0, Lcom/b/a/at;->c:I

    .line 307
    iget-object v0, p1, Lcom/b/a/as;->a:Lcom/b/a/ao;

    iput-object v0, p0, Lcom/b/a/at;->a:Lcom/b/a/ao;

    .line 308
    iget-object v0, p1, Lcom/b/a/as;->b:Lcom/b/a/al;

    iput-object v0, p0, Lcom/b/a/at;->b:Lcom/b/a/al;

    .line 309
    iget v0, p1, Lcom/b/a/as;->c:I

    iput v0, p0, Lcom/b/a/at;->c:I

    .line 310
    iget-object v0, p1, Lcom/b/a/as;->d:Ljava/lang/String;

    iput-object v0, p0, Lcom/b/a/at;->d:Ljava/lang/String;

    .line 311
    iget-object v0, p1, Lcom/b/a/as;->e:Lcom/b/a/z;

    iput-object v0, p0, Lcom/b/a/at;->e:Lcom/b/a/z;

    .line 312
    iget-object v0, p1, Lcom/b/a/as;->f:Lcom/b/a/aa;

    invoke-virtual {v0}, Lcom/b/a/aa;->b()Lcom/b/a/ab;

    move-result-object v0

    iput-object v0, p0, Lcom/b/a/at;->f:Lcom/b/a/ab;

    .line 313
    iget-object v0, p1, Lcom/b/a/as;->g:Lcom/b/a/au;

    iput-object v0, p0, Lcom/b/a/at;->g:Lcom/b/a/au;

    .line 314
    iget-object v0, p1, Lcom/b/a/as;->h:Lcom/b/a/as;

    iput-object v0, p0, Lcom/b/a/at;->h:Lcom/b/a/as;

    .line 315
    iget-object v0, p1, Lcom/b/a/as;->i:Lcom/b/a/as;

    iput-object v0, p0, Lcom/b/a/at;->i:Lcom/b/a/as;

    .line 316
    iget-object v0, p1, Lcom/b/a/as;->j:Lcom/b/a/as;

    iput-object v0, p0, Lcom/b/a/at;->j:Lcom/b/a/as;

    .line 317
    iget-wide v0, p1, Lcom/b/a/as;->k:J

    iput-wide v0, p0, Lcom/b/a/at;->k:J

    .line 318
    iget-wide v0, p1, Lcom/b/a/as;->l:J

    iput-wide v0, p0, Lcom/b/a/at;->l:J

    .line 319
    return-void
.end method

.method private static a(Ljava/lang/String;Lcom/b/a/as;)V
    .locals 3

    .prologue
    .line 393
    iget-object v0, p1, Lcom/b/a/as;->g:Lcom/b/a/au;

    if-eqz v0, :cond_0

    .line 394
    new-instance v0, Ljava/lang/IllegalArgumentException;

    new-instance v1, Ljava/lang/StringBuilder;

    invoke-direct {v1}, Ljava/lang/StringBuilder;-><init>()V

    invoke-virtual {v1, p0}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    const-string v2, ".body != null"

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v1

    invoke-direct {v0, v1}, Ljava/lang/IllegalArgumentException;-><init>(Ljava/lang/String;)V

    throw v0

    .line 395
    :cond_0
    iget-object v0, p1, Lcom/b/a/as;->h:Lcom/b/a/as;

    if-eqz v0, :cond_1

    .line 396
    new-instance v0, Ljava/lang/IllegalArgumentException;

    new-instance v1, Ljava/lang/StringBuilder;

    invoke-direct {v1}, Ljava/lang/StringBuilder;-><init>()V

    invoke-virtual {v1, p0}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    const-string v2, ".networkResponse != null"

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v1

    invoke-direct {v0, v1}, Ljava/lang/IllegalArgumentException;-><init>(Ljava/lang/String;)V

    throw v0

    .line 397
    :cond_1
    iget-object v0, p1, Lcom/b/a/as;->i:Lcom/b/a/as;

    if-eqz v0, :cond_2

    .line 398
    new-instance v0, Ljava/lang/IllegalArgumentException;

    new-instance v1, Ljava/lang/StringBuilder;

    invoke-direct {v1}, Ljava/lang/StringBuilder;-><init>()V

    invoke-virtual {v1, p0}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    const-string v2, ".cacheResponse != null"

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v1

    invoke-direct {v0, v1}, Ljava/lang/IllegalArgumentException;-><init>(Ljava/lang/String;)V

    throw v0

    .line 399
    :cond_2
    iget-object v0, p1, Lcom/b/a/as;->j:Lcom/b/a/as;

    if-eqz v0, :cond_3

    .line 400
    new-instance v0, Ljava/lang/IllegalArgumentException;

    new-instance v1, Ljava/lang/StringBuilder;

    invoke-direct {v1}, Ljava/lang/StringBuilder;-><init>()V

    invoke-virtual {v1, p0}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    const-string v2, ".priorResponse != null"

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v1

    invoke-direct {v0, v1}, Ljava/lang/IllegalArgumentException;-><init>(Ljava/lang/String;)V

    throw v0

    .line 402
    :cond_3
    return-void
.end method


# virtual methods
.method public final a()Lcom/b/a/as;
    .locals 3

    .prologue
    .line 427
    iget-object v0, p0, Lcom/b/a/at;->a:Lcom/b/a/ao;

    if-nez v0, :cond_0

    new-instance v0, Ljava/lang/IllegalStateException;

    const-string v1, "request == null"

    invoke-direct {v0, v1}, Ljava/lang/IllegalStateException;-><init>(Ljava/lang/String;)V

    throw v0

    .line 428
    :cond_0
    iget-object v0, p0, Lcom/b/a/at;->b:Lcom/b/a/al;

    if-nez v0, :cond_1

    new-instance v0, Ljava/lang/IllegalStateException;

    const-string v1, "protocol == null"

    invoke-direct {v0, v1}, Ljava/lang/IllegalStateException;-><init>(Ljava/lang/String;)V

    throw v0

    .line 429
    :cond_1
    iget v0, p0, Lcom/b/a/at;->c:I

    if-gez v0, :cond_2

    new-instance v0, Ljava/lang/IllegalStateException;

    new-instance v1, Ljava/lang/StringBuilder;

    const-string v2, "code < 0: "

    invoke-direct {v1, v2}, Ljava/lang/StringBuilder;-><init>(Ljava/lang/String;)V

    iget v2, p0, Lcom/b/a/at;->c:I

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v1

    invoke-direct {v0, v1}, Ljava/lang/IllegalStateException;-><init>(Ljava/lang/String;)V

    throw v0

    .line 430
    :cond_2
    new-instance v0, Lcom/b/a/as;

    invoke-direct {v0, p0}, Lcom/b/a/as;-><init>(Lcom/b/a/at;)V

    return-object v0
.end method

.method public final a(I)Lcom/b/a/at;
    .locals 0

    .prologue
    .line 332
    iput p1, p0, Lcom/b/a/at;->c:I

    .line 333
    return-object p0
.end method

.method public final a(J)Lcom/b/a/at;
    .locals 1

    .prologue
    .line 417
    iput-wide p1, p0, Lcom/b/a/at;->k:J

    .line 418
    return-object p0
.end method

.method public final a(Lcom/b/a/aa;)Lcom/b/a/at;
    .locals 1

    .prologue
    .line 371
    invoke-virtual {p1}, Lcom/b/a/aa;->b()Lcom/b/a/ab;

    move-result-object v0

    iput-object v0, p0, Lcom/b/a/at;->f:Lcom/b/a/ab;

    .line 372
    return-object p0
.end method

.method public final a(Lcom/b/a/al;)Lcom/b/a/at;
    .locals 0

    .prologue
    .line 327
    iput-object p1, p0, Lcom/b/a/at;->b:Lcom/b/a/al;

    .line 328
    return-object p0
.end method

.method public final a(Lcom/b/a/ao;)Lcom/b/a/at;
    .locals 0

    .prologue
    .line 322
    iput-object p1, p0, Lcom/b/a/at;->a:Lcom/b/a/ao;

    .line 323
    return-object p0
.end method

.method public final a(Lcom/b/a/as;)Lcom/b/a/at;
    .locals 1

    .prologue
    .line 381
    if-eqz p1, :cond_0

    const-string v0, "networkResponse"

    invoke-static {v0, p1}, Lcom/b/a/at;->a(Ljava/lang/String;Lcom/b/a/as;)V

    .line 382
    :cond_0
    iput-object p1, p0, Lcom/b/a/at;->h:Lcom/b/a/as;

    .line 383
    return-object p0
.end method

.method public final a(Lcom/b/a/au;)Lcom/b/a/at;
    .locals 0

    .prologue
    .line 376
    iput-object p1, p0, Lcom/b/a/at;->g:Lcom/b/a/au;

    .line 377
    return-object p0
.end method

.method public final a(Lcom/b/a/z;)Lcom/b/a/at;
    .locals 0

    .prologue
    .line 342
    iput-object p1, p0, Lcom/b/a/at;->e:Lcom/b/a/z;

    .line 343
    return-object p0
.end method

.method public final a(Ljava/lang/String;)Lcom/b/a/at;
    .locals 0

    .prologue
    .line 337
    iput-object p1, p0, Lcom/b/a/at;->d:Ljava/lang/String;

    .line 338
    return-object p0
.end method

.method public final a(Ljava/lang/String;Ljava/lang/String;)Lcom/b/a/at;
    .locals 1

    .prologue
    .line 360
    iget-object v0, p0, Lcom/b/a/at;->f:Lcom/b/a/ab;

    invoke-virtual {v0, p1, p2}, Lcom/b/a/ab;->a(Ljava/lang/String;Ljava/lang/String;)Lcom/b/a/ab;

    .line 361
    return-object p0
.end method

.method public final b(J)Lcom/b/a/at;
    .locals 1

    .prologue
    .line 422
    iput-wide p1, p0, Lcom/b/a/at;->l:J

    .line 423
    return-object p0
.end method

.method public final b(Lcom/b/a/as;)Lcom/b/a/at;
    .locals 1

    .prologue
    .line 387
    if-eqz p1, :cond_0

    const-string v0, "cacheResponse"

    invoke-static {v0, p1}, Lcom/b/a/at;->a(Ljava/lang/String;Lcom/b/a/as;)V

    .line 388
    :cond_0
    iput-object p1, p0, Lcom/b/a/at;->i:Lcom/b/a/as;

    .line 389
    return-object p0
.end method

.method public final c(Lcom/b/a/as;)Lcom/b/a/at;
    .locals 2

    .prologue
    .line 405
    if-eqz p1, :cond_0

    .line 1411
    iget-object v0, p1, Lcom/b/a/as;->g:Lcom/b/a/au;

    if-eqz v0, :cond_0

    .line 1412
    new-instance v0, Ljava/lang/IllegalArgumentException;

    const-string v1, "priorResponse.body != null"

    invoke-direct {v0, v1}, Ljava/lang/IllegalArgumentException;-><init>(Ljava/lang/String;)V

    throw v0

    .line 406
    :cond_0
    iput-object p1, p0, Lcom/b/a/at;->j:Lcom/b/a/as;

    .line 407
    return-object p0
.end method
