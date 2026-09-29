.class final Lcom/b/a/a/e/v;
.super Lcom/b/a/a/b;
.source "SourceFile"


# instance fields
.field final synthetic a:Lcom/b/a/a/e/ab;

.field final synthetic c:Lcom/b/a/a/e/u;


# direct methods
.method varargs constructor <init>(Lcom/b/a/a/e/u;Ljava/lang/String;[Ljava/lang/Object;Lcom/b/a/a/e/ab;)V
    .locals 0

    .prologue
    .line 625
    iput-object p1, p0, Lcom/b/a/a/e/v;->c:Lcom/b/a/a/e/u;

    iput-object p4, p0, Lcom/b/a/a/e/v;->a:Lcom/b/a/a/e/ab;

    invoke-direct {p0, p2, p3}, Lcom/b/a/a/b;-><init>(Ljava/lang/String;[Ljava/lang/Object;)V

    return-void
.end method


# virtual methods
.method public final b()V
    .locals 5

    .prologue
    .line 628
    :try_start_0
    iget-object v0, p0, Lcom/b/a/a/e/v;->c:Lcom/b/a/a/e/u;

    iget-object v0, v0, Lcom/b/a/a/e/u;->c:Lcom/b/a/a/e/j;

    iget-object v0, v0, Lcom/b/a/a/e/j;->c:Lcom/b/a/a/e/s;

    iget-object v1, p0, Lcom/b/a/a/e/v;->a:Lcom/b/a/a/e/ab;

    invoke-virtual {v0, v1}, Lcom/b/a/a/e/s;->a(Lcom/b/a/a/e/ab;)V
    :try_end_0
    .catch Ljava/io/IOException; {:try_start_0 .. :try_end_0} :catch_0

    .line 636
    :goto_0
    return-void

    .line 629
    :catch_0
    move-exception v0

    .line 630
    invoke-static {}, Lcom/b/a/a/g/h;->b()Lcom/b/a/a/g/h;

    move-result-object v1

    const/4 v2, 0x4

    new-instance v3, Ljava/lang/StringBuilder;

    const-string v4, "Http2Connection.Listener failure for "

    invoke-direct {v3, v4}, Ljava/lang/StringBuilder;-><init>(Ljava/lang/String;)V

    iget-object v4, p0, Lcom/b/a/a/e/v;->c:Lcom/b/a/a/e/u;

    iget-object v4, v4, Lcom/b/a/a/e/u;->c:Lcom/b/a/a/e/j;

    iget-object v4, v4, Lcom/b/a/a/e/j;->e:Ljava/lang/String;

    invoke-virtual {v3, v4}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v3

    invoke-virtual {v3}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v3

    invoke-virtual {v1, v2, v3, v0}, Lcom/b/a/a/g/h;->a(ILjava/lang/String;Ljava/lang/Throwable;)V

    .line 632
    :try_start_1
    iget-object v0, p0, Lcom/b/a/a/e/v;->a:Lcom/b/a/a/e/ab;

    sget-object v1, Lcom/b/a/a/e/b;->b:Lcom/b/a/a/e/b;

    invoke-virtual {v0, v1}, Lcom/b/a/a/e/ab;->a(Lcom/b/a/a/e/b;)V
    :try_end_1
    .catch Ljava/io/IOException; {:try_start_1 .. :try_end_1} :catch_1

    goto :goto_0

    .line 636
    :catch_1
    move-exception v0

    goto :goto_0
.end method
