.class final Lcom/b/a/a/e/z;
.super Ljava/lang/Object;
.source "SourceFile"

# interfaces
.implements Lcom/b/b/x;


# instance fields
.field a:I

.field b:B

.field c:I

.field d:I

.field e:S

.field private final f:Lcom/b/b/h;


# direct methods
.method public constructor <init>(Lcom/b/b/h;)V
    .locals 0

    .prologue
    .line 357
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    .line 358
    iput-object p1, p0, Lcom/b/a/a/e/z;->f:Lcom/b/b/h;

    .line 359
    return-void
.end method


# virtual methods
.method public final a(Lcom/b/b/f;J)J
    .locals 10

    .prologue
    const/4 v9, 0x1

    const-wide/16 v0, -0x1

    const/4 v8, 0x0

    .line 362
    :cond_0
    iget v2, p0, Lcom/b/a/a/e/z;->d:I

    if-nez v2, :cond_5

    .line 363
    iget-object v2, p0, Lcom/b/a/a/e/z;->f:Lcom/b/b/h;

    iget-short v3, p0, Lcom/b/a/a/e/z;->e:S

    int-to-long v4, v3

    invoke-interface {v2, v4, v5}, Lcom/b/b/h;->f(J)V

    .line 364
    iput-short v8, p0, Lcom/b/a/a/e/z;->e:S

    .line 365
    iget-byte v2, p0, Lcom/b/a/a/e/z;->b:B

    and-int/lit8 v2, v2, 0x4

    if-eqz v2, :cond_2

    .line 373
    :cond_1
    :goto_0
    return-wide v0

    .line 1384
    :cond_2
    iget v2, p0, Lcom/b/a/a/e/z;->c:I

    .line 1386
    iget-object v3, p0, Lcom/b/a/a/e/z;->f:Lcom/b/b/h;

    invoke-static {v3}, Lcom/b/a/a/e/y;->a(Lcom/b/b/h;)I

    move-result v3

    iput v3, p0, Lcom/b/a/a/e/z;->d:I

    iput v3, p0, Lcom/b/a/a/e/z;->a:I

    .line 1387
    iget-object v3, p0, Lcom/b/a/a/e/z;->f:Lcom/b/b/h;

    invoke-interface {v3}, Lcom/b/b/h;->e()B

    move-result v3

    and-int/lit16 v3, v3, 0xff

    int-to-byte v3, v3

    .line 1388
    iget-object v4, p0, Lcom/b/a/a/e/z;->f:Lcom/b/b/h;

    invoke-interface {v4}, Lcom/b/b/h;->e()B

    move-result v4

    and-int/lit16 v4, v4, 0xff

    int-to-byte v4, v4

    iput-byte v4, p0, Lcom/b/a/a/e/z;->b:B

    .line 1389
    sget-object v4, Lcom/b/a/a/e/y;->a:Ljava/util/logging/Logger;

    sget-object v5, Ljava/util/logging/Level;->FINE:Ljava/util/logging/Level;

    invoke-virtual {v4, v5}, Ljava/util/logging/Logger;->isLoggable(Ljava/util/logging/Level;)Z

    move-result v4

    if-eqz v4, :cond_3

    sget-object v4, Lcom/b/a/a/e/y;->a:Ljava/util/logging/Logger;

    iget v5, p0, Lcom/b/a/a/e/z;->c:I

    iget v6, p0, Lcom/b/a/a/e/z;->a:I

    iget-byte v7, p0, Lcom/b/a/a/e/z;->b:B

    invoke-static {v9, v5, v6, v3, v7}, Lcom/b/a/a/e/g;->a(ZIIBB)Ljava/lang/String;

    move-result-object v5

    invoke-virtual {v4, v5}, Ljava/util/logging/Logger;->fine(Ljava/lang/String;)V

    .line 1390
    :cond_3
    iget-object v4, p0, Lcom/b/a/a/e/z;->f:Lcom/b/b/h;

    invoke-interface {v4}, Lcom/b/b/h;->g()I

    move-result v4

    const v5, 0x7fffffff

    and-int/2addr v4, v5

    iput v4, p0, Lcom/b/a/a/e/z;->c:I

    .line 1391
    const/16 v4, 0x9

    if-eq v3, v4, :cond_4

    const-string v0, "%s != TYPE_CONTINUATION"

    new-array v1, v9, [Ljava/lang/Object;

    invoke-static {v3}, Ljava/lang/Byte;->valueOf(B)Ljava/lang/Byte;

    move-result-object v2

    aput-object v2, v1, v8

    invoke-static {v0, v1}, Lcom/b/a/a/e/g;->b(Ljava/lang/String;[Ljava/lang/Object;)Ljava/io/IOException;

    move-result-object v0

    throw v0

    .line 1392
    :cond_4
    iget v3, p0, Lcom/b/a/a/e/z;->c:I

    if-eq v3, v2, :cond_0

    const-string v0, "TYPE_CONTINUATION streamId changed"

    new-array v1, v8, [Ljava/lang/Object;

    invoke-static {v0, v1}, Lcom/b/a/a/e/g;->b(Ljava/lang/String;[Ljava/lang/Object;)Ljava/io/IOException;

    move-result-object v0

    throw v0

    .line 370
    :cond_5
    iget-object v2, p0, Lcom/b/a/a/e/z;->f:Lcom/b/b/h;

    iget v3, p0, Lcom/b/a/a/e/z;->d:I

    int-to-long v4, v3

    invoke-static {p2, p3, v4, v5}, Ljava/lang/Math;->min(JJ)J

    move-result-wide v4

    invoke-interface {v2, p1, v4, v5}, Lcom/b/b/h;->a(Lcom/b/b/f;J)J

    move-result-wide v2

    .line 371
    cmp-long v4, v2, v0

    if-eqz v4, :cond_1

    .line 372
    iget v0, p0, Lcom/b/a/a/e/z;->d:I

    int-to-long v0, v0

    sub-long/2addr v0, v2

    long-to-int v0, v0

    iput v0, p0, Lcom/b/a/a/e/z;->d:I

    move-wide v0, v2

    .line 373
    goto :goto_0
.end method

.method public final a()Lcom/b/b/y;
    .locals 1

    .prologue
    .line 377
    iget-object v0, p0, Lcom/b/a/a/e/z;->f:Lcom/b/b/h;

    invoke-interface {v0}, Lcom/b/b/h;->a()Lcom/b/b/y;

    move-result-object v0

    return-object v0
.end method

.method public final close()V
    .locals 0

    .prologue
    .line 381
    return-void
.end method
