.class final Lcom/b/a/a/e/f;
.super Ljava/lang/Object;
.source "SourceFile"


# instance fields
.field a:I

.field b:I

.field c:[Lcom/b/a/a/e/c;

.field d:I

.field e:I

.field f:I

.field private final g:Lcom/b/b/f;

.field private final h:Z

.field private i:I

.field private j:Z


# direct methods
.method constructor <init>(Lcom/b/b/f;)V
    .locals 1

    .prologue
    .line 392
    const/4 v0, 0x0

    invoke-direct {p0, p1, v0}, Lcom/b/a/a/e/f;-><init>(Lcom/b/b/f;B)V

    .line 393
    return-void
.end method

.method private constructor <init>(Lcom/b/b/f;B)V
    .locals 3

    .prologue
    const/16 v2, 0x1000

    const/4 v1, 0x0

    .line 395
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    .line 378
    const v0, 0x7fffffff

    iput v0, p0, Lcom/b/a/a/e/f;->i:I

    .line 385
    const/16 v0, 0x8

    new-array v0, v0, [Lcom/b/a/a/e/c;

    iput-object v0, p0, Lcom/b/a/a/e/f;->c:[Lcom/b/a/a/e/c;

    .line 387
    iget-object v0, p0, Lcom/b/a/a/e/f;->c:[Lcom/b/a/a/e/c;

    array-length v0, v0

    add-int/lit8 v0, v0, -0x1

    iput v0, p0, Lcom/b/a/a/e/f;->d:I

    .line 388
    iput v1, p0, Lcom/b/a/a/e/f;->e:I

    .line 389
    iput v1, p0, Lcom/b/a/a/e/f;->f:I

    .line 396
    iput v2, p0, Lcom/b/a/a/e/f;->a:I

    .line 397
    iput v2, p0, Lcom/b/a/a/e/f;->b:I

    .line 398
    const/4 v0, 0x1

    iput-boolean v0, p0, Lcom/b/a/a/e/f;->h:Z

    .line 399
    iput-object p1, p0, Lcom/b/a/a/e/f;->g:Lcom/b/b/f;

    .line 400
    return-void
.end method

.method private a()V
    .locals 3

    .prologue
    const/4 v2, 0x0

    .line 403
    iget-object v0, p0, Lcom/b/a/a/e/f;->c:[Lcom/b/a/a/e/c;

    const/4 v1, 0x0

    invoke-static {v0, v1}, Ljava/util/Arrays;->fill([Ljava/lang/Object;Ljava/lang/Object;)V

    .line 404
    iget-object v0, p0, Lcom/b/a/a/e/f;->c:[Lcom/b/a/a/e/c;

    array-length v0, v0

    add-int/lit8 v0, v0, -0x1

    iput v0, p0, Lcom/b/a/a/e/f;->d:I

    .line 405
    iput v2, p0, Lcom/b/a/a/e/f;->e:I

    .line 406
    iput v2, p0, Lcom/b/a/a/e/f;->f:I

    .line 407
    return-void
.end method

.method private a(III)V
    .locals 3

    .prologue
    .line 528
    if-ge p1, p2, :cond_0

    .line 529
    iget-object v0, p0, Lcom/b/a/a/e/f;->g:Lcom/b/b/f;

    or-int v1, p3, p1

    invoke-virtual {v0, v1}, Lcom/b/b/f;->b(I)Lcom/b/b/f;

    .line 544
    :goto_0
    return-void

    .line 534
    :cond_0
    iget-object v0, p0, Lcom/b/a/a/e/f;->g:Lcom/b/b/f;

    or-int v1, p3, p2

    invoke-virtual {v0, v1}, Lcom/b/b/f;->b(I)Lcom/b/b/f;

    .line 535
    sub-int v0, p1, p2

    .line 538
    :goto_1
    const/16 v1, 0x80

    if-lt v0, v1, :cond_1

    .line 539
    and-int/lit8 v1, v0, 0x7f

    .line 540
    iget-object v2, p0, Lcom/b/a/a/e/f;->g:Lcom/b/b/f;

    or-int/lit16 v1, v1, 0x80

    invoke-virtual {v2, v1}, Lcom/b/b/f;->b(I)Lcom/b/b/f;

    .line 541
    ushr-int/lit8 v0, v0, 0x7

    .line 542
    goto :goto_1

    .line 543
    :cond_1
    iget-object v1, p0, Lcom/b/a/a/e/f;->g:Lcom/b/b/f;

    invoke-virtual {v1, v0}, Lcom/b/b/f;->b(I)Lcom/b/b/f;

    goto :goto_0
.end method

.method private a(Lcom/b/a/a/e/c;)V
    .locals 6

    .prologue
    .line 429
    iget v0, p1, Lcom/b/a/a/e/c;->i:I

    .line 432
    iget v1, p0, Lcom/b/a/a/e/f;->b:I

    if-le v0, v1, :cond_0

    .line 433
    invoke-direct {p0}, Lcom/b/a/a/e/f;->a()V

    .line 451
    :goto_0
    return-void

    .line 438
    :cond_0
    iget v1, p0, Lcom/b/a/a/e/f;->f:I

    add-int/2addr v1, v0

    iget v2, p0, Lcom/b/a/a/e/f;->b:I

    sub-int/2addr v1, v2

    .line 439
    invoke-direct {p0, v1}, Lcom/b/a/a/e/f;->b(I)I

    .line 441
    iget v1, p0, Lcom/b/a/a/e/f;->e:I

    add-int/lit8 v1, v1, 0x1

    iget-object v2, p0, Lcom/b/a/a/e/f;->c:[Lcom/b/a/a/e/c;

    array-length v2, v2

    if-le v1, v2, :cond_1

    .line 442
    iget-object v1, p0, Lcom/b/a/a/e/f;->c:[Lcom/b/a/a/e/c;

    array-length v1, v1

    mul-int/lit8 v1, v1, 0x2

    new-array v1, v1, [Lcom/b/a/a/e/c;

    .line 443
    iget-object v2, p0, Lcom/b/a/a/e/f;->c:[Lcom/b/a/a/e/c;

    const/4 v3, 0x0

    iget-object v4, p0, Lcom/b/a/a/e/f;->c:[Lcom/b/a/a/e/c;

    array-length v4, v4

    iget-object v5, p0, Lcom/b/a/a/e/f;->c:[Lcom/b/a/a/e/c;

    array-length v5, v5

    invoke-static {v2, v3, v1, v4, v5}, Ljava/lang/System;->arraycopy(Ljava/lang/Object;ILjava/lang/Object;II)V

    .line 444
    iget-object v2, p0, Lcom/b/a/a/e/f;->c:[Lcom/b/a/a/e/c;

    array-length v2, v2

    add-int/lit8 v2, v2, -0x1

    iput v2, p0, Lcom/b/a/a/e/f;->d:I

    .line 445
    iput-object v1, p0, Lcom/b/a/a/e/f;->c:[Lcom/b/a/a/e/c;

    .line 447
    :cond_1
    iget v1, p0, Lcom/b/a/a/e/f;->d:I

    add-int/lit8 v2, v1, -0x1

    iput v2, p0, Lcom/b/a/a/e/f;->d:I

    .line 448
    iget-object v2, p0, Lcom/b/a/a/e/f;->c:[Lcom/b/a/a/e/c;

    aput-object p1, v2, v1

    .line 449
    iget v1, p0, Lcom/b/a/a/e/f;->e:I

    add-int/lit8 v1, v1, 0x1

    iput v1, p0, Lcom/b/a/a/e/f;->e:I

    .line 450
    iget v1, p0, Lcom/b/a/a/e/f;->f:I

    add-int/2addr v0, v1

    iput v0, p0, Lcom/b/a/a/e/f;->f:I

    goto :goto_0
.end method

.method private a(Lcom/b/b/i;)V
    .locals 4

    .prologue
    const/16 v3, 0x7f

    .line 547
    iget-boolean v0, p0, Lcom/b/a/a/e/f;->h:Z

    if-eqz v0, :cond_0

    invoke-static {}, Lcom/b/a/a/e/ag;->a()Lcom/b/a/a/e/ag;

    invoke-static {p1}, Lcom/b/a/a/e/ag;->a(Lcom/b/b/i;)I

    move-result v0

    invoke-virtual {p1}, Lcom/b/b/i;->g()I

    move-result v1

    if-ge v0, v1, :cond_0

    .line 548
    new-instance v0, Lcom/b/b/f;

    invoke-direct {v0}, Lcom/b/b/f;-><init>()V

    .line 549
    invoke-static {}, Lcom/b/a/a/e/ag;->a()Lcom/b/a/a/e/ag;

    invoke-static {p1, v0}, Lcom/b/a/a/e/ag;->a(Lcom/b/b/i;Lcom/b/b/g;)V

    .line 550
    invoke-virtual {v0}, Lcom/b/b/f;->k()Lcom/b/b/i;

    move-result-object v0

    .line 551
    invoke-virtual {v0}, Lcom/b/b/i;->g()I

    move-result v1

    const/16 v2, 0x80

    invoke-direct {p0, v1, v3, v2}, Lcom/b/a/a/e/f;->a(III)V

    .line 552
    iget-object v1, p0, Lcom/b/a/a/e/f;->g:Lcom/b/b/f;

    invoke-virtual {v1, v0}, Lcom/b/b/f;->a(Lcom/b/b/i;)Lcom/b/b/f;

    .line 557
    :goto_0
    return-void

    .line 554
    :cond_0
    invoke-virtual {p1}, Lcom/b/b/i;->g()I

    move-result v0

    const/4 v1, 0x0

    invoke-direct {p0, v0, v3, v1}, Lcom/b/a/a/e/f;->a(III)V

    .line 555
    iget-object v0, p0, Lcom/b/a/a/e/f;->g:Lcom/b/b/f;

    invoke-virtual {v0, p1}, Lcom/b/b/f;->a(Lcom/b/b/i;)Lcom/b/b/f;

    goto :goto_0
.end method

.method private b(I)I
    .locals 6

    .prologue
    .line 411
    const/4 v1, 0x0

    .line 412
    if-lez p1, :cond_1

    .line 414
    iget-object v0, p0, Lcom/b/a/a/e/f;->c:[Lcom/b/a/a/e/c;

    array-length v0, v0

    add-int/lit8 v0, v0, -0x1

    :goto_0
    iget v2, p0, Lcom/b/a/a/e/f;->d:I

    if-lt v0, v2, :cond_0

    if-lez p1, :cond_0

    .line 415
    iget-object v2, p0, Lcom/b/a/a/e/f;->c:[Lcom/b/a/a/e/c;

    aget-object v2, v2, v0

    iget v2, v2, Lcom/b/a/a/e/c;->i:I

    sub-int/2addr p1, v2

    .line 416
    iget v2, p0, Lcom/b/a/a/e/f;->f:I

    iget-object v3, p0, Lcom/b/a/a/e/f;->c:[Lcom/b/a/a/e/c;

    aget-object v3, v3, v0

    iget v3, v3, Lcom/b/a/a/e/c;->i:I

    sub-int/2addr v2, v3

    iput v2, p0, Lcom/b/a/a/e/f;->f:I

    .line 417
    iget v2, p0, Lcom/b/a/a/e/f;->e:I

    add-int/lit8 v2, v2, -0x1

    iput v2, p0, Lcom/b/a/a/e/f;->e:I

    .line 418
    add-int/lit8 v1, v1, 0x1

    .line 414
    add-int/lit8 v0, v0, -0x1

    goto :goto_0

    .line 420
    :cond_0
    iget-object v0, p0, Lcom/b/a/a/e/f;->c:[Lcom/b/a/a/e/c;

    iget v2, p0, Lcom/b/a/a/e/f;->d:I

    add-int/lit8 v2, v2, 0x1

    iget-object v3, p0, Lcom/b/a/a/e/f;->c:[Lcom/b/a/a/e/c;

    iget v4, p0, Lcom/b/a/a/e/f;->d:I

    add-int/lit8 v4, v4, 0x1

    add-int/2addr v4, v1

    iget v5, p0, Lcom/b/a/a/e/f;->e:I

    invoke-static {v0, v2, v3, v4, v5}, Ljava/lang/System;->arraycopy(Ljava/lang/Object;ILjava/lang/Object;II)V

    .line 422
    iget-object v0, p0, Lcom/b/a/a/e/f;->c:[Lcom/b/a/a/e/c;

    iget v2, p0, Lcom/b/a/a/e/f;->d:I

    add-int/lit8 v2, v2, 0x1

    iget v3, p0, Lcom/b/a/a/e/f;->d:I

    add-int/lit8 v3, v3, 0x1

    add-int/2addr v3, v1

    const/4 v4, 0x0

    invoke-static {v0, v2, v3, v4}, Ljava/util/Arrays;->fill([Ljava/lang/Object;IILjava/lang/Object;)V

    .line 423
    iget v0, p0, Lcom/b/a/a/e/f;->d:I

    add-int/2addr v0, v1

    iput v0, p0, Lcom/b/a/a/e/f;->d:I

    .line 425
    :cond_1
    return v1
.end method


# virtual methods
.method final a(I)V
    .locals 2

    .prologue
    .line 560
    iput p1, p0, Lcom/b/a/a/e/f;->a:I

    .line 561
    const/16 v0, 0x4000

    invoke-static {p1, v0}, Ljava/lang/Math;->min(II)I

    move-result v0

    .line 564
    iget v1, p0, Lcom/b/a/a/e/f;->b:I

    if-ne v1, v0, :cond_1

    .line 1578
    :cond_0
    :goto_0
    return-void

    .line 566
    :cond_1
    iget v1, p0, Lcom/b/a/a/e/f;->b:I

    if-ge v0, v1, :cond_2

    .line 567
    iget v1, p0, Lcom/b/a/a/e/f;->i:I

    invoke-static {v1, v0}, Ljava/lang/Math;->min(II)I

    move-result v1

    iput v1, p0, Lcom/b/a/a/e/f;->i:I

    .line 570
    :cond_2
    const/4 v1, 0x1

    iput-boolean v1, p0, Lcom/b/a/a/e/f;->j:Z

    .line 571
    iput v0, p0, Lcom/b/a/a/e/f;->b:I

    .line 1576
    iget v0, p0, Lcom/b/a/a/e/f;->b:I

    iget v1, p0, Lcom/b/a/a/e/f;->f:I

    if-ge v0, v1, :cond_0

    .line 1577
    iget v0, p0, Lcom/b/a/a/e/f;->b:I

    if-nez v0, :cond_3

    .line 1578
    invoke-direct {p0}, Lcom/b/a/a/e/f;->a()V

    goto :goto_0

    .line 1580
    :cond_3
    iget v0, p0, Lcom/b/a/a/e/f;->f:I

    iget v1, p0, Lcom/b/a/a/e/f;->b:I

    sub-int/2addr v0, v1

    invoke-direct {p0, v0}, Lcom/b/a/a/e/f;->b(I)I

    goto :goto_0
.end method

.method final a(Ljava/util/List;)V
    .locals 13
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "(",
            "Ljava/util/List",
            "<",
            "Lcom/b/a/a/e/c;",
            ">;)V"
        }
    .end annotation

    .prologue
    const/16 v12, 0x40

    const/16 v3, 0x20

    const/16 v2, 0x1f

    const/4 v6, 0x0

    const/4 v4, -0x1

    .line 456
    iget-boolean v0, p0, Lcom/b/a/a/e/f;->j:Z

    if-eqz v0, :cond_1

    .line 457
    iget v0, p0, Lcom/b/a/a/e/f;->i:I

    iget v1, p0, Lcom/b/a/a/e/f;->b:I

    if-ge v0, v1, :cond_0

    .line 459
    iget v0, p0, Lcom/b/a/a/e/f;->i:I

    invoke-direct {p0, v0, v2, v3}, Lcom/b/a/a/e/f;->a(III)V

    .line 461
    :cond_0
    iput-boolean v6, p0, Lcom/b/a/a/e/f;->j:Z

    .line 462
    const v0, 0x7fffffff

    iput v0, p0, Lcom/b/a/a/e/f;->i:I

    .line 463
    iget v0, p0, Lcom/b/a/a/e/f;->b:I

    invoke-direct {p0, v0, v2, v3}, Lcom/b/a/a/e/f;->a(III)V

    .line 466
    :cond_1
    invoke-interface {p1}, Ljava/util/List;->size()I

    move-result v7

    move v5, v6

    :goto_0
    if-ge v5, v7, :cond_9

    .line 467
    invoke-interface {p1, v5}, Ljava/util/List;->get(I)Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Lcom/b/a/a/e/c;

    .line 468
    iget-object v1, v0, Lcom/b/a/a/e/c;->g:Lcom/b/b/i;

    invoke-virtual {v1}, Lcom/b/b/i;->f()Lcom/b/b/i;

    move-result-object v8

    .line 469
    iget-object v9, v0, Lcom/b/a/a/e/c;->h:Lcom/b/b/i;

    .line 473
    sget-object v1, Lcom/b/a/a/e/d;->b:Ljava/util/Map;

    invoke-interface {v1, v8}, Ljava/util/Map;->get(Ljava/lang/Object;)Ljava/lang/Object;

    move-result-object v1

    check-cast v1, Ljava/lang/Integer;

    .line 474
    if-eqz v1, :cond_b

    .line 475
    invoke-virtual {v1}, Ljava/lang/Integer;->intValue()I

    move-result v1

    add-int/lit8 v1, v1, 0x1

    .line 476
    const/4 v2, 0x1

    if-le v1, v2, :cond_a

    const/16 v2, 0x8

    if-ge v1, v2, :cond_a

    .line 481
    sget-object v2, Lcom/b/a/a/e/d;->a:[Lcom/b/a/a/e/c;

    add-int/lit8 v3, v1, -0x1

    aget-object v2, v2, v3

    iget-object v2, v2, Lcom/b/a/a/e/c;->h:Lcom/b/b/i;

    invoke-static {v2, v9}, Lcom/b/a/a/c;->a(Ljava/lang/Object;Ljava/lang/Object;)Z

    move-result v2

    if-eqz v2, :cond_3

    move v2, v1

    .line 489
    :goto_1
    if-ne v2, v4, :cond_2

    .line 490
    iget v3, p0, Lcom/b/a/a/e/f;->d:I

    add-int/lit8 v3, v3, 0x1

    iget-object v10, p0, Lcom/b/a/a/e/f;->c:[Lcom/b/a/a/e/c;

    array-length v10, v10

    :goto_2
    if-ge v3, v10, :cond_2

    .line 491
    iget-object v11, p0, Lcom/b/a/a/e/f;->c:[Lcom/b/a/a/e/c;

    aget-object v11, v11, v3

    iget-object v11, v11, Lcom/b/a/a/e/c;->g:Lcom/b/b/i;

    invoke-static {v11, v8}, Lcom/b/a/a/c;->a(Ljava/lang/Object;Ljava/lang/Object;)Z

    move-result v11

    if-eqz v11, :cond_5

    .line 492
    iget-object v11, p0, Lcom/b/a/a/e/f;->c:[Lcom/b/a/a/e/c;

    aget-object v11, v11, v3

    iget-object v11, v11, Lcom/b/a/a/e/c;->h:Lcom/b/b/i;

    invoke-static {v11, v9}, Lcom/b/a/a/c;->a(Ljava/lang/Object;Ljava/lang/Object;)Z

    move-result v11

    if-eqz v11, :cond_4

    .line 493
    iget v2, p0, Lcom/b/a/a/e/f;->d:I

    sub-int v2, v3, v2

    sget-object v3, Lcom/b/a/a/e/d;->a:[Lcom/b/a/a/e/c;

    array-length v3, v3

    add-int/2addr v2, v3

    .line 502
    :cond_2
    if-eq v2, v4, :cond_6

    .line 504
    const/16 v0, 0x7f

    const/16 v1, 0x80

    invoke-direct {p0, v2, v0, v1}, Lcom/b/a/a/e/f;->a(III)V

    .line 466
    :goto_3
    add-int/lit8 v0, v5, 0x1

    move v5, v0

    goto :goto_0

    .line 483
    :cond_3
    sget-object v2, Lcom/b/a/a/e/d;->a:[Lcom/b/a/a/e/c;

    aget-object v2, v2, v1

    iget-object v2, v2, Lcom/b/a/a/e/c;->h:Lcom/b/b/i;

    invoke-static {v2, v9}, Lcom/b/a/a/c;->a(Ljava/lang/Object;Ljava/lang/Object;)Z

    move-result v2

    if-eqz v2, :cond_a

    .line 484
    add-int/lit8 v2, v1, 0x1

    goto :goto_1

    .line 495
    :cond_4
    if-ne v1, v4, :cond_5

    .line 496
    iget v1, p0, Lcom/b/a/a/e/f;->d:I

    sub-int v1, v3, v1

    sget-object v11, Lcom/b/a/a/e/d;->a:[Lcom/b/a/a/e/c;

    array-length v11, v11

    add-int/2addr v1, v11

    .line 490
    :cond_5
    add-int/lit8 v3, v3, 0x1

    goto :goto_2

    .line 505
    :cond_6
    if-ne v1, v4, :cond_7

    .line 507
    iget-object v1, p0, Lcom/b/a/a/e/f;->g:Lcom/b/b/f;

    invoke-virtual {v1, v12}, Lcom/b/b/f;->b(I)Lcom/b/b/f;

    .line 508
    invoke-direct {p0, v8}, Lcom/b/a/a/e/f;->a(Lcom/b/b/i;)V

    .line 509
    invoke-direct {p0, v9}, Lcom/b/a/a/e/f;->a(Lcom/b/b/i;)V

    .line 510
    invoke-direct {p0, v0}, Lcom/b/a/a/e/f;->a(Lcom/b/a/a/e/c;)V

    goto :goto_3

    .line 511
    :cond_7
    sget-object v2, Lcom/b/a/a/e/c;->a:Lcom/b/b/i;

    .line 1390
    invoke-virtual {v2}, Lcom/b/b/i;->g()I

    move-result v3

    invoke-virtual {v8, v6, v2, v6, v3}, Lcom/b/b/i;->a(ILcom/b/b/i;II)Z

    move-result v2

    .line 511
    if-eqz v2, :cond_8

    sget-object v2, Lcom/b/a/a/e/c;->f:Lcom/b/b/i;

    invoke-virtual {v2, v8}, Lcom/b/b/i;->equals(Ljava/lang/Object;)Z

    move-result v2

    if-nez v2, :cond_8

    .line 514
    const/16 v0, 0xf

    invoke-direct {p0, v1, v0, v6}, Lcom/b/a/a/e/f;->a(III)V

    .line 515
    invoke-direct {p0, v9}, Lcom/b/a/a/e/f;->a(Lcom/b/b/i;)V

    goto :goto_3

    .line 518
    :cond_8
    const/16 v2, 0x3f

    invoke-direct {p0, v1, v2, v12}, Lcom/b/a/a/e/f;->a(III)V

    .line 519
    invoke-direct {p0, v9}, Lcom/b/a/a/e/f;->a(Lcom/b/b/i;)V

    .line 520
    invoke-direct {p0, v0}, Lcom/b/a/a/e/f;->a(Lcom/b/a/a/e/c;)V

    goto :goto_3

    .line 523
    :cond_9
    return-void

    :cond_a
    move v2, v4

    goto/16 :goto_1

    :cond_b
    move v1, v4

    move v2, v4

    goto/16 :goto_1
.end method
