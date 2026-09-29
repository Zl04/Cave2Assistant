.class public final Lcom/b/a/a/a/f;
.super Ljava/lang/Object;
.source "SourceFile"

# interfaces
.implements Ljava/io/Closeable;
.implements Ljava/io/Flushable;


# static fields
.field static final a:Ljava/util/regex/Pattern;

.field static final synthetic j:Z


# instance fields
.field final b:Lcom/b/a/a/f/a;

.field final c:I

.field d:Lcom/b/b/g;

.field final e:Ljava/util/LinkedHashMap;
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "Ljava/util/LinkedHashMap",
            "<",
            "Ljava/lang/String;",
            "Lcom/b/a/a/a/h;",
            ">;"
        }
    .end annotation
.end field

.field f:I

.field g:Z

.field h:Z

.field i:Z

.field private k:J

.field private l:J

.field private final m:Ljava/util/concurrent/Executor;

.field private final n:Ljava/lang/Runnable;


# direct methods
.method static constructor <clinit>()V
    .locals 1

    .prologue
    .line 86
    const-class v0, Lcom/b/a/a/a/f;

    invoke-virtual {v0}, Ljava/lang/Class;->desiredAssertionStatus()Z

    move-result v0

    if-nez v0, :cond_0

    const/4 v0, 0x1

    :goto_0
    sput-boolean v0, Lcom/b/a/a/a/f;->j:Z

    .line 93
    const-string v0, "[a-z0-9_-]{1,120}"

    invoke-static {v0}, Ljava/util/regex/Pattern;->compile(Ljava/lang/String;)Ljava/util/regex/Pattern;

    move-result-object v0

    sput-object v0, Lcom/b/a/a/a/f;->a:Ljava/util/regex/Pattern;

    return-void

    .line 86
    :cond_0
    const/4 v0, 0x0

    goto :goto_0
.end method

.method private a()Z
    .locals 2

    .prologue
    .line 599
    iget v0, p0, Lcom/b/a/a/a/f;->f:I

    const/16 v1, 0x7d0

    if-lt v0, v1, :cond_0

    iget v0, p0, Lcom/b/a/a/a/f;->f:I

    iget-object v1, p0, Lcom/b/a/a/a/f;->e:Ljava/util/LinkedHashMap;

    .line 600
    invoke-virtual {v1}, Ljava/util/LinkedHashMap;->size()I

    move-result v1

    if-lt v0, v1, :cond_0

    const/4 v0, 0x1

    :goto_0
    return v0

    :cond_0
    const/4 v0, 0x0

    .line 599
    goto :goto_0
.end method

.method private a(Lcom/b/a/a/a/h;)Z
    .locals 6

    .prologue
    const/4 v1, 0x0

    .line 622
    iget-object v0, p1, Lcom/b/a/a/a/h;->f:Lcom/b/a/a/a/g;

    if-eqz v0, :cond_1

    .line 623
    iget-object v2, p1, Lcom/b/a/a/a/h;->f:Lcom/b/a/a/a/g;

    .line 1847
    iget-object v0, v2, Lcom/b/a/a/a/g;->a:Lcom/b/a/a/a/h;

    iget-object v0, v0, Lcom/b/a/a/a/h;->f:Lcom/b/a/a/a/g;

    if-ne v0, v2, :cond_1

    move v0, v1

    .line 1848
    :goto_0
    iget-object v3, v2, Lcom/b/a/a/a/g;->b:Lcom/b/a/a/a/f;

    iget v3, v3, Lcom/b/a/a/a/f;->c:I

    if-ge v0, v3, :cond_0

    .line 1850
    :try_start_0
    iget-object v3, v2, Lcom/b/a/a/a/g;->b:Lcom/b/a/a/a/f;

    iget-object v3, v3, Lcom/b/a/a/a/f;->b:Lcom/b/a/a/f/a;

    iget-object v4, v2, Lcom/b/a/a/a/g;->a:Lcom/b/a/a/a/h;

    iget-object v4, v4, Lcom/b/a/a/a/h;->d:[Ljava/io/File;

    aget-object v4, v4, v0

    invoke-interface {v3, v4}, Lcom/b/a/a/f/a;->a(Ljava/io/File;)V
    :try_end_0
    .catch Ljava/io/IOException; {:try_start_0 .. :try_end_0} :catch_0

    .line 1848
    :goto_1
    add-int/lit8 v0, v0, 0x1

    goto :goto_0

    .line 1855
    :cond_0
    iget-object v0, v2, Lcom/b/a/a/a/g;->a:Lcom/b/a/a/a/h;

    const/4 v2, 0x0

    iput-object v2, v0, Lcom/b/a/a/a/h;->f:Lcom/b/a/a/a/g;

    .line 626
    :cond_1
    :goto_2
    iget v0, p0, Lcom/b/a/a/a/f;->c:I

    if-ge v1, v0, :cond_2

    .line 627
    iget-object v0, p0, Lcom/b/a/a/a/f;->b:Lcom/b/a/a/f/a;

    iget-object v2, p1, Lcom/b/a/a/a/h;->c:[Ljava/io/File;

    aget-object v2, v2, v1

    invoke-interface {v0, v2}, Lcom/b/a/a/f/a;->a(Ljava/io/File;)V

    .line 628
    iget-wide v2, p0, Lcom/b/a/a/a/f;->l:J

    iget-object v0, p1, Lcom/b/a/a/a/h;->b:[J

    aget-wide v4, v0, v1

    sub-long/2addr v2, v4

    iput-wide v2, p0, Lcom/b/a/a/a/f;->l:J

    .line 629
    iget-object v0, p1, Lcom/b/a/a/a/h;->b:[J

    const-wide/16 v2, 0x0

    aput-wide v2, v0, v1

    .line 626
    add-int/lit8 v1, v1, 0x1

    goto :goto_2

    .line 632
    :cond_2
    iget v0, p0, Lcom/b/a/a/a/f;->f:I

    add-int/lit8 v0, v0, 0x1

    iput v0, p0, Lcom/b/a/a/a/f;->f:I

    .line 633
    iget-object v0, p0, Lcom/b/a/a/a/f;->d:Lcom/b/b/g;

    const-string v1, "REMOVE"

    invoke-interface {v0, v1}, Lcom/b/b/g;->b(Ljava/lang/String;)Lcom/b/b/g;

    move-result-object v0

    const/16 v1, 0x20

    invoke-interface {v0, v1}, Lcom/b/b/g;->h(I)Lcom/b/b/g;

    move-result-object v0

    iget-object v1, p1, Lcom/b/a/a/a/h;->a:Ljava/lang/String;

    invoke-interface {v0, v1}, Lcom/b/b/g;->b(Ljava/lang/String;)Lcom/b/b/g;

    move-result-object v0

    const/16 v1, 0xa

    invoke-interface {v0, v1}, Lcom/b/b/g;->h(I)Lcom/b/b/g;

    .line 634
    iget-object v0, p0, Lcom/b/a/a/a/f;->e:Ljava/util/LinkedHashMap;

    iget-object v1, p1, Lcom/b/a/a/a/h;->a:Ljava/lang/String;

    invoke-virtual {v0, v1}, Ljava/util/LinkedHashMap;->remove(Ljava/lang/Object;)Ljava/lang/Object;

    .line 636
    invoke-direct {p0}, Lcom/b/a/a/a/f;->a()Z

    move-result v0

    if-eqz v0, :cond_3

    .line 637
    iget-object v0, p0, Lcom/b/a/a/a/f;->m:Ljava/util/concurrent/Executor;

    iget-object v1, p0, Lcom/b/a/a/a/f;->n:Ljava/lang/Runnable;

    invoke-interface {v0, v1}, Ljava/util/concurrent/Executor;->execute(Ljava/lang/Runnable;)V

    .line 640
    :cond_3
    const/4 v0, 0x1

    return v0

    :catch_0
    move-exception v3

    goto :goto_1
.end method

.method private declared-synchronized b()Z
    .locals 1

    .prologue
    .line 645
    monitor-enter p0

    :try_start_0
    iget-boolean v0, p0, Lcom/b/a/a/a/f;->h:Z
    :try_end_0
    .catchall {:try_start_0 .. :try_end_0} :catchall_0

    monitor-exit p0

    return v0

    :catchall_0
    move-exception v0

    monitor-exit p0

    throw v0
.end method

.method private declared-synchronized c()V
    .locals 2

    .prologue
    .line 649
    monitor-enter p0

    :try_start_0
    invoke-direct {p0}, Lcom/b/a/a/a/f;->b()Z

    move-result v0

    if-eqz v0, :cond_0

    .line 650
    new-instance v0, Ljava/lang/IllegalStateException;

    const-string v1, "cache is closed"

    invoke-direct {v0, v1}, Ljava/lang/IllegalStateException;-><init>(Ljava/lang/String;)V

    throw v0
    :try_end_0
    .catchall {:try_start_0 .. :try_end_0} :catchall_0

    .line 649
    :catchall_0
    move-exception v0

    monitor-exit p0

    throw v0

    .line 652
    :cond_0
    monitor-exit p0

    return-void
.end method

.method private d()V
    .locals 4

    .prologue
    .line 682
    :goto_0
    iget-wide v0, p0, Lcom/b/a/a/a/f;->l:J

    iget-wide v2, p0, Lcom/b/a/a/a/f;->k:J

    cmp-long v0, v0, v2

    if-lez v0, :cond_0

    .line 683
    iget-object v0, p0, Lcom/b/a/a/a/f;->e:Ljava/util/LinkedHashMap;

    invoke-virtual {v0}, Ljava/util/LinkedHashMap;->values()Ljava/util/Collection;

    move-result-object v0

    invoke-interface {v0}, Ljava/util/Collection;->iterator()Ljava/util/Iterator;

    move-result-object v0

    invoke-interface {v0}, Ljava/util/Iterator;->next()Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Lcom/b/a/a/a/h;

    .line 684
    invoke-direct {p0, v0}, Lcom/b/a/a/a/f;->a(Lcom/b/a/a/a/h;)Z

    goto :goto_0

    .line 686
    :cond_0
    const/4 v0, 0x0

    iput-boolean v0, p0, Lcom/b/a/a/a/f;->i:Z

    .line 687
    return-void
.end method


# virtual methods
.method final declared-synchronized a(Lcom/b/a/a/a/g;)V
    .locals 4

    .prologue
    .line 534
    monitor-enter p0

    :try_start_0
    iget-object v1, p1, Lcom/b/a/a/a/g;->a:Lcom/b/a/a/a/h;

    .line 535
    iget-object v0, v1, Lcom/b/a/a/a/h;->f:Lcom/b/a/a/a/g;

    if-eq v0, p1, :cond_0

    .line 536
    new-instance v0, Ljava/lang/IllegalStateException;

    invoke-direct {v0}, Ljava/lang/IllegalStateException;-><init>()V

    throw v0
    :try_end_0
    .catchall {:try_start_0 .. :try_end_0} :catchall_0

    .line 534
    :catchall_0
    move-exception v0

    monitor-exit p0

    throw v0

    .line 553
    :cond_0
    const/4 v0, 0x0

    :goto_0
    :try_start_1
    iget v2, p0, Lcom/b/a/a/a/f;->c:I

    if-ge v0, v2, :cond_1

    .line 554
    iget-object v2, v1, Lcom/b/a/a/a/h;->d:[Ljava/io/File;

    aget-object v2, v2, v0

    .line 565
    iget-object v3, p0, Lcom/b/a/a/a/f;->b:Lcom/b/a/a/f/a;

    invoke-interface {v3, v2}, Lcom/b/a/a/f/a;->a(Ljava/io/File;)V

    .line 553
    add-int/lit8 v0, v0, 0x1

    goto :goto_0

    .line 569
    :cond_1
    iget v0, p0, Lcom/b/a/a/a/f;->f:I

    add-int/lit8 v0, v0, 0x1

    iput v0, p0, Lcom/b/a/a/a/f;->f:I

    .line 570
    const/4 v0, 0x0

    iput-object v0, v1, Lcom/b/a/a/a/h;->f:Lcom/b/a/a/a/g;

    .line 571
    iget-boolean v0, v1, Lcom/b/a/a/a/h;->e:Z

    or-int/lit8 v0, v0, 0x0

    if-eqz v0, :cond_4

    .line 572
    const/4 v0, 0x1

    iput-boolean v0, v1, Lcom/b/a/a/a/h;->e:Z

    .line 573
    iget-object v0, p0, Lcom/b/a/a/a/f;->d:Lcom/b/b/g;

    const-string v2, "CLEAN"

    invoke-interface {v0, v2}, Lcom/b/b/g;->b(Ljava/lang/String;)Lcom/b/b/g;

    move-result-object v0

    const/16 v2, 0x20

    invoke-interface {v0, v2}, Lcom/b/b/g;->h(I)Lcom/b/b/g;

    .line 574
    iget-object v0, p0, Lcom/b/a/a/a/f;->d:Lcom/b/b/g;

    iget-object v2, v1, Lcom/b/a/a/a/h;->a:Ljava/lang/String;

    invoke-interface {v0, v2}, Lcom/b/b/g;->b(Ljava/lang/String;)Lcom/b/b/g;

    .line 575
    iget-object v0, p0, Lcom/b/a/a/a/f;->d:Lcom/b/b/g;

    invoke-virtual {v1, v0}, Lcom/b/a/a/a/h;->a(Lcom/b/b/g;)V

    .line 576
    iget-object v0, p0, Lcom/b/a/a/a/f;->d:Lcom/b/b/g;

    const/16 v1, 0xa

    invoke-interface {v0, v1}, Lcom/b/b/g;->h(I)Lcom/b/b/g;

    .line 586
    :goto_1
    iget-object v0, p0, Lcom/b/a/a/a/f;->d:Lcom/b/b/g;

    invoke-interface {v0}, Lcom/b/b/g;->flush()V

    .line 588
    iget-wide v0, p0, Lcom/b/a/a/a/f;->l:J

    iget-wide v2, p0, Lcom/b/a/a/a/f;->k:J

    cmp-long v0, v0, v2

    if-gtz v0, :cond_2

    invoke-direct {p0}, Lcom/b/a/a/a/f;->a()Z

    move-result v0

    if-eqz v0, :cond_3

    .line 589
    :cond_2
    iget-object v0, p0, Lcom/b/a/a/a/f;->m:Ljava/util/concurrent/Executor;

    iget-object v1, p0, Lcom/b/a/a/a/f;->n:Ljava/lang/Runnable;

    invoke-interface {v0, v1}, Ljava/util/concurrent/Executor;->execute(Ljava/lang/Runnable;)V
    :try_end_1
    .catchall {:try_start_1 .. :try_end_1} :catchall_0

    .line 591
    :cond_3
    monitor-exit p0

    return-void

    .line 581
    :cond_4
    :try_start_2
    iget-object v0, p0, Lcom/b/a/a/a/f;->e:Ljava/util/LinkedHashMap;

    iget-object v2, v1, Lcom/b/a/a/a/h;->a:Ljava/lang/String;

    invoke-virtual {v0, v2}, Ljava/util/LinkedHashMap;->remove(Ljava/lang/Object;)Ljava/lang/Object;

    .line 582
    iget-object v0, p0, Lcom/b/a/a/a/f;->d:Lcom/b/b/g;

    const-string v2, "REMOVE"

    invoke-interface {v0, v2}, Lcom/b/b/g;->b(Ljava/lang/String;)Lcom/b/b/g;

    move-result-object v0

    const/16 v2, 0x20

    invoke-interface {v0, v2}, Lcom/b/b/g;->h(I)Lcom/b/b/g;

    .line 583
    iget-object v0, p0, Lcom/b/a/a/a/f;->d:Lcom/b/b/g;

    iget-object v1, v1, Lcom/b/a/a/a/h;->a:Ljava/lang/String;

    invoke-interface {v0, v1}, Lcom/b/b/g;->b(Ljava/lang/String;)Lcom/b/b/g;

    .line 584
    iget-object v0, p0, Lcom/b/a/a/a/f;->d:Lcom/b/b/g;

    const/16 v1, 0xa

    invoke-interface {v0, v1}, Lcom/b/b/g;->h(I)Lcom/b/b/g;
    :try_end_2
    .catchall {:try_start_2 .. :try_end_2} :catchall_0

    goto :goto_1
.end method

.method public final declared-synchronized close()V
    .locals 5

    .prologue
    .line 665
    monitor-enter p0

    :try_start_0
    iget-boolean v0, p0, Lcom/b/a/a/a/f;->g:Z

    if-eqz v0, :cond_0

    iget-boolean v0, p0, Lcom/b/a/a/a/f;->h:Z

    if-eqz v0, :cond_1

    .line 666
    :cond_0
    const/4 v0, 0x1

    iput-boolean v0, p0, Lcom/b/a/a/a/f;->h:Z
    :try_end_0
    .catchall {:try_start_0 .. :try_end_0} :catchall_0

    .line 679
    :goto_0
    monitor-exit p0

    return-void

    .line 670
    :cond_1
    :try_start_1
    iget-object v0, p0, Lcom/b/a/a/a/f;->e:Ljava/util/LinkedHashMap;

    invoke-virtual {v0}, Ljava/util/LinkedHashMap;->values()Ljava/util/Collection;

    move-result-object v0

    iget-object v1, p0, Lcom/b/a/a/a/f;->e:Ljava/util/LinkedHashMap;

    invoke-virtual {v1}, Ljava/util/LinkedHashMap;->size()I

    move-result v1

    new-array v1, v1, [Lcom/b/a/a/a/h;

    invoke-interface {v0, v1}, Ljava/util/Collection;->toArray([Ljava/lang/Object;)[Ljava/lang/Object;

    move-result-object v0

    check-cast v0, [Lcom/b/a/a/a/h;

    array-length v2, v0

    const/4 v1, 0x0

    :goto_1
    if-ge v1, v2, :cond_3

    aget-object v3, v0, v1

    .line 671
    iget-object v4, v3, Lcom/b/a/a/a/h;->f:Lcom/b/a/a/a/g;

    if-eqz v4, :cond_2

    .line 672
    iget-object v3, v3, Lcom/b/a/a/a/h;->f:Lcom/b/a/a/a/g;

    invoke-virtual {v3}, Lcom/b/a/a/a/g;->a()V

    .line 670
    :cond_2
    add-int/lit8 v1, v1, 0x1

    goto :goto_1

    .line 675
    :cond_3
    invoke-direct {p0}, Lcom/b/a/a/a/f;->d()V

    .line 676
    iget-object v0, p0, Lcom/b/a/a/a/f;->d:Lcom/b/b/g;

    invoke-interface {v0}, Lcom/b/b/g;->close()V

    .line 677
    const/4 v0, 0x0

    iput-object v0, p0, Lcom/b/a/a/a/f;->d:Lcom/b/b/g;

    .line 678
    const/4 v0, 0x1

    iput-boolean v0, p0, Lcom/b/a/a/a/f;->h:Z
    :try_end_1
    .catchall {:try_start_1 .. :try_end_1} :catchall_0

    goto :goto_0

    .line 665
    :catchall_0
    move-exception v0

    monitor-exit p0

    throw v0
.end method

.method public final declared-synchronized flush()V
    .locals 1

    .prologue
    .line 656
    monitor-enter p0

    :try_start_0
    iget-boolean v0, p0, Lcom/b/a/a/a/f;->g:Z
    :try_end_0
    .catchall {:try_start_0 .. :try_end_0} :catchall_0

    if-nez v0, :cond_0

    .line 661
    :goto_0
    monitor-exit p0

    return-void

    .line 658
    :cond_0
    :try_start_1
    invoke-direct {p0}, Lcom/b/a/a/a/f;->c()V

    .line 659
    invoke-direct {p0}, Lcom/b/a/a/a/f;->d()V

    .line 660
    iget-object v0, p0, Lcom/b/a/a/a/f;->d:Lcom/b/b/g;

    invoke-interface {v0}, Lcom/b/b/g;->flush()V
    :try_end_1
    .catchall {:try_start_1 .. :try_end_1} :catchall_0

    goto :goto_0

    .line 656
    :catchall_0
    move-exception v0

    monitor-exit p0

    throw v0
.end method
