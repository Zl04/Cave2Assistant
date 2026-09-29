.class final Lcom/b/a/a/e/q;
.super Lcom/b/a/a/b;
.source "SourceFile"


# instance fields
.field final synthetic a:I

.field final synthetic c:Lcom/b/a/a/e/b;

.field final synthetic d:Lcom/b/a/a/e/j;


# direct methods
.method varargs constructor <init>(Lcom/b/a/a/e/j;Ljava/lang/String;[Ljava/lang/Object;ILcom/b/a/a/e/b;)V
    .locals 0

    .prologue
    .line 848
    iput-object p1, p0, Lcom/b/a/a/e/q;->d:Lcom/b/a/a/e/j;

    iput p4, p0, Lcom/b/a/a/e/q;->a:I

    iput-object p5, p0, Lcom/b/a/a/e/q;->c:Lcom/b/a/a/e/b;

    invoke-direct {p0, p2, p3}, Lcom/b/a/a/b;-><init>(Ljava/lang/String;[Ljava/lang/Object;)V

    return-void
.end method


# virtual methods
.method public final b()V
    .locals 3

    .prologue
    .line 850
    iget-object v0, p0, Lcom/b/a/a/e/q;->d:Lcom/b/a/a/e/j;

    iget-object v0, v0, Lcom/b/a/a/e/j;->i:Lcom/b/a/a/e/aj;

    invoke-interface {v0}, Lcom/b/a/a/e/aj;->c()V

    .line 851
    iget-object v1, p0, Lcom/b/a/a/e/q;->d:Lcom/b/a/a/e/j;

    monitor-enter v1

    .line 852
    :try_start_0
    iget-object v0, p0, Lcom/b/a/a/e/q;->d:Lcom/b/a/a/e/j;

    iget-object v0, v0, Lcom/b/a/a/e/j;->r:Ljava/util/Set;

    iget v2, p0, Lcom/b/a/a/e/q;->a:I

    invoke-static {v2}, Ljava/lang/Integer;->valueOf(I)Ljava/lang/Integer;

    move-result-object v2

    invoke-interface {v0, v2}, Ljava/util/Set;->remove(Ljava/lang/Object;)Z

    .line 853
    monitor-exit v1

    return-void

    :catchall_0
    move-exception v0

    monitor-exit v1
    :try_end_0
    .catchall {:try_start_0 .. :try_end_0} :catchall_0

    throw v0
.end method
