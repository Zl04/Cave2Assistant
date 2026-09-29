.class public final Lcom/b/a/a/a/g;
.super Ljava/lang/Object;
.source "SourceFile"


# instance fields
.field final a:Lcom/b/a/a/a/h;

.field final synthetic b:Lcom/b/a/a/a/f;

.field private c:Z


# virtual methods
.method public final a()V
    .locals 2

    .prologue
    .line 933
    iget-object v1, p0, Lcom/b/a/a/a/g;->b:Lcom/b/a/a/a/f;

    monitor-enter v1

    .line 934
    :try_start_0
    iget-boolean v0, p0, Lcom/b/a/a/a/g;->c:Z

    if-eqz v0, :cond_0

    .line 935
    new-instance v0, Ljava/lang/IllegalStateException;

    invoke-direct {v0}, Ljava/lang/IllegalStateException;-><init>()V

    throw v0

    .line 941
    :catchall_0
    move-exception v0

    monitor-exit v1
    :try_end_0
    .catchall {:try_start_0 .. :try_end_0} :catchall_0

    throw v0

    .line 937
    :cond_0
    :try_start_1
    iget-object v0, p0, Lcom/b/a/a/a/g;->a:Lcom/b/a/a/a/h;

    iget-object v0, v0, Lcom/b/a/a/a/h;->f:Lcom/b/a/a/a/g;

    if-ne v0, p0, :cond_1

    .line 938
    iget-object v0, p0, Lcom/b/a/a/a/g;->b:Lcom/b/a/a/a/f;

    invoke-virtual {v0, p0}, Lcom/b/a/a/a/f;->a(Lcom/b/a/a/a/g;)V

    .line 940
    :cond_1
    const/4 v0, 0x1

    iput-boolean v0, p0, Lcom/b/a/a/a/g;->c:Z

    .line 941
    monitor-exit v1
    :try_end_1
    .catchall {:try_start_1 .. :try_end_1} :catchall_0

    return-void
.end method
