.class final Lcom/b/a/am;
.super Ljava/lang/Object;
.source "SourceFile"

# interfaces
.implements Lcom/b/a/g;


# instance fields
.field final a:Lcom/b/a/ai;

.field final b:Lcom/b/a/a/c/k;

.field final c:Lcom/b/a/ao;

.field final d:Z

.field private e:Z


# direct methods
.method constructor <init>(Lcom/b/a/ai;Lcom/b/a/ao;Z)V
    .locals 1

    .prologue
    .line 44
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    .line 45
    iput-object p1, p0, Lcom/b/a/am;->a:Lcom/b/a/ai;

    .line 46
    iput-object p2, p0, Lcom/b/a/am;->c:Lcom/b/a/ao;

    .line 47
    iput-boolean p3, p0, Lcom/b/a/am;->d:Z

    .line 48
    new-instance v0, Lcom/b/a/a/c/k;

    invoke-direct {v0, p1, p3}, Lcom/b/a/a/c/k;-><init>(Lcom/b/a/ai;Z)V

    iput-object v0, p0, Lcom/b/a/am;->b:Lcom/b/a/a/c/k;

    .line 49
    return-void
.end method

.method private d()V
    .locals 2

    .prologue
    .line 72
    invoke-static {}, Lcom/b/a/a/g/h;->b()Lcom/b/a/a/g/h;

    move-result-object v0

    const-string v1, "response.body().close()"

    invoke-virtual {v0, v1}, Lcom/b/a/a/g/h;->a(Ljava/lang/String;)Ljava/lang/Object;

    move-result-object v0

    .line 73
    iget-object v1, p0, Lcom/b/a/am;->b:Lcom/b/a/a/c/k;

    invoke-virtual {v1, v0}, Lcom/b/a/a/c/k;->a(Ljava/lang/Object;)V

    .line 74
    return-void
.end method


# virtual methods
.method public final a()Lcom/b/a/as;
    .locals 2

    .prologue
    .line 56
    monitor-enter p0

    .line 57
    :try_start_0
    iget-boolean v0, p0, Lcom/b/a/am;->e:Z

    if-eqz v0, :cond_0

    new-instance v0, Ljava/lang/IllegalStateException;

    const-string v1, "Already Executed"

    invoke-direct {v0, v1}, Ljava/lang/IllegalStateException;-><init>(Ljava/lang/String;)V

    throw v0

    .line 59
    :catchall_0
    move-exception v0

    monitor-exit p0
    :try_end_0
    .catchall {:try_start_0 .. :try_end_0} :catchall_0

    throw v0

    .line 58
    :cond_0
    const/4 v0, 0x1

    :try_start_1
    iput-boolean v0, p0, Lcom/b/a/am;->e:Z

    .line 59
    monitor-exit p0
    :try_end_1
    .catchall {:try_start_1 .. :try_end_1} :catchall_0

    .line 60
    invoke-direct {p0}, Lcom/b/a/am;->d()V

    .line 62
    :try_start_2
    iget-object v0, p0, Lcom/b/a/am;->a:Lcom/b/a/ai;

    .line 1374
    iget-object v0, v0, Lcom/b/a/ai;->c:Lcom/b/a/u;

    .line 62
    invoke-virtual {v0, p0}, Lcom/b/a/u;->a(Lcom/b/a/am;)V

    .line 63
    invoke-virtual {p0}, Lcom/b/a/am;->c()Lcom/b/a/as;

    move-result-object v0

    .line 64
    if-nez v0, :cond_1

    new-instance v0, Ljava/io/IOException;

    const-string v1, "Canceled"

    invoke-direct {v0, v1}, Ljava/io/IOException;-><init>(Ljava/lang/String;)V

    throw v0
    :try_end_2
    .catchall {:try_start_2 .. :try_end_2} :catchall_1

    .line 67
    :catchall_1
    move-exception v0

    iget-object v1, p0, Lcom/b/a/am;->a:Lcom/b/a/ai;

    .line 3374
    iget-object v1, v1, Lcom/b/a/ai;->c:Lcom/b/a/u;

    .line 67
    invoke-virtual {v1, p0}, Lcom/b/a/u;->b(Lcom/b/a/am;)V

    throw v0

    :cond_1
    iget-object v1, p0, Lcom/b/a/am;->a:Lcom/b/a/ai;

    .line 2374
    iget-object v1, v1, Lcom/b/a/ai;->c:Lcom/b/a/u;

    .line 67
    invoke-virtual {v1, p0}, Lcom/b/a/u;->b(Lcom/b/a/am;)V

    .line 65
    return-object v0
.end method

.method public final a(Lcom/b/a/h;)V
    .locals 2

    .prologue
    .line 77
    monitor-enter p0

    .line 78
    :try_start_0
    iget-boolean v0, p0, Lcom/b/a/am;->e:Z

    if-eqz v0, :cond_0

    new-instance v0, Ljava/lang/IllegalStateException;

    const-string v1, "Already Executed"

    invoke-direct {v0, v1}, Ljava/lang/IllegalStateException;-><init>(Ljava/lang/String;)V

    throw v0

    .line 80
    :catchall_0
    move-exception v0

    monitor-exit p0
    :try_end_0
    .catchall {:try_start_0 .. :try_end_0} :catchall_0

    throw v0

    .line 79
    :cond_0
    const/4 v0, 0x1

    :try_start_1
    iput-boolean v0, p0, Lcom/b/a/am;->e:Z

    .line 80
    monitor-exit p0
    :try_end_1
    .catchall {:try_start_1 .. :try_end_1} :catchall_0

    .line 81
    invoke-direct {p0}, Lcom/b/a/am;->d()V

    .line 82
    iget-object v0, p0, Lcom/b/a/am;->a:Lcom/b/a/ai;

    .line 4374
    iget-object v0, v0, Lcom/b/a/ai;->c:Lcom/b/a/u;

    .line 82
    new-instance v1, Lcom/b/a/an;

    invoke-direct {v1, p0, p1}, Lcom/b/a/an;-><init>(Lcom/b/a/am;Lcom/b/a/h;)V

    invoke-virtual {v0, v1}, Lcom/b/a/u;->a(Lcom/b/a/an;)V

    .line 83
    return-void
.end method

.method final b()Ljava/lang/String;
    .locals 7

    .prologue
    const/4 v5, 0x1

    const/4 v2, 0x0

    .line 161
    iget-object v0, p0, Lcom/b/a/am;->c:Lcom/b/a/ao;

    .line 5045
    iget-object v0, v0, Lcom/b/a/ao;->a:Lcom/b/a/ac;

    .line 5850
    const-string v1, "/..."

    invoke-virtual {v0, v1}, Lcom/b/a/ac;->d(Ljava/lang/String;)Lcom/b/a/ad;

    move-result-object v6

    const-string v0, ""

    .line 5977
    const-string v1, " \"\':;<=>@[]^`{}|/\\?#"

    move v3, v2

    move v4, v2

    invoke-static/range {v0 .. v5}, Lcom/b/a/ac;->a(Ljava/lang/String;Ljava/lang/String;ZZZZ)Ljava/lang/String;

    move-result-object v0

    iput-object v0, v6, Lcom/b/a/ad;->b:Ljava/lang/String;

    .line 5851
    const-string v0, ""

    .line 5990
    const-string v1, " \"\':;<=>@[]^`{}|/\\?#"

    move v3, v2

    move v4, v2

    invoke-static/range {v0 .. v5}, Lcom/b/a/ac;->a(Ljava/lang/String;Ljava/lang/String;ZZZZ)Ljava/lang/String;

    move-result-object v0

    iput-object v0, v6, Lcom/b/a/ad;->c:Ljava/lang/String;

    .line 5853
    invoke-virtual {v6}, Lcom/b/a/ad;->b()Lcom/b/a/ac;

    move-result-object v0

    .line 5854
    invoke-virtual {v0}, Lcom/b/a/ac;->toString()Ljava/lang/String;

    move-result-object v0

    .line 161
    return-object v0
.end method

.method final c()Lcom/b/a/as;
    .locals 7

    .prologue
    const/4 v2, 0x0

    .line 166
    new-instance v1, Ljava/util/ArrayList;

    invoke-direct {v1}, Ljava/util/ArrayList;-><init>()V

    .line 167
    iget-object v0, p0, Lcom/b/a/am;->a:Lcom/b/a/ai;

    .line 6391
    iget-object v0, v0, Lcom/b/a/ai;->g:Ljava/util/List;

    .line 167
    invoke-interface {v1, v0}, Ljava/util/List;->addAll(Ljava/util/Collection;)Z

    .line 168
    iget-object v0, p0, Lcom/b/a/am;->b:Lcom/b/a/a/c/k;

    invoke-interface {v1, v0}, Ljava/util/List;->add(Ljava/lang/Object;)Z

    .line 169
    new-instance v0, Lcom/b/a/a/c/a;

    iget-object v3, p0, Lcom/b/a/am;->a:Lcom/b/a/ai;

    .line 7318
    iget-object v3, v3, Lcom/b/a/ai;->j:Lcom/b/a/s;

    .line 169
    invoke-direct {v0, v3}, Lcom/b/a/a/c/a;-><init>(Lcom/b/a/s;)V

    invoke-interface {v1, v0}, Ljava/util/List;->add(Ljava/lang/Object;)Z

    .line 170
    new-instance v3, Lcom/b/a/a/a/a;

    iget-object v0, p0, Lcom/b/a/am;->a:Lcom/b/a/ai;

    .line 7326
    iget-object v4, v0, Lcom/b/a/ai;->k:Lcom/b/a/d;

    if-eqz v4, :cond_1

    iget-object v0, v0, Lcom/b/a/ai;->k:Lcom/b/a/d;

    iget-object v0, v0, Lcom/b/a/d;->a:Lcom/b/a/a/a/i;

    .line 170
    :goto_0
    invoke-direct {v3, v0}, Lcom/b/a/a/a/a;-><init>(Lcom/b/a/a/a/i;)V

    invoke-interface {v1, v3}, Ljava/util/List;->add(Ljava/lang/Object;)Z

    .line 171
    new-instance v0, Lcom/b/a/a/b/a;

    iget-object v3, p0, Lcom/b/a/am;->a:Lcom/b/a/ai;

    invoke-direct {v0, v3}, Lcom/b/a/a/b/a;-><init>(Lcom/b/a/ai;)V

    invoke-interface {v1, v0}, Ljava/util/List;->add(Ljava/lang/Object;)Z

    .line 172
    iget-boolean v0, p0, Lcom/b/a/am;->d:Z

    if-nez v0, :cond_0

    .line 173
    iget-object v0, p0, Lcom/b/a/am;->a:Lcom/b/a/ai;

    .line 7400
    iget-object v0, v0, Lcom/b/a/ai;->h:Ljava/util/List;

    .line 173
    invoke-interface {v1, v0}, Ljava/util/List;->addAll(Ljava/util/Collection;)Z

    .line 175
    :cond_0
    new-instance v0, Lcom/b/a/a/c/b;

    iget-boolean v3, p0, Lcom/b/a/am;->d:Z

    invoke-direct {v0, v3}, Lcom/b/a/a/c/b;-><init>(Z)V

    invoke-interface {v1, v0}, Ljava/util/List;->add(Ljava/lang/Object;)Z

    .line 177
    new-instance v0, Lcom/b/a/a/c/h;

    const/4 v5, 0x0

    iget-object v6, p0, Lcom/b/a/am;->c:Lcom/b/a/ao;

    move-object v3, v2

    move-object v4, v2

    invoke-direct/range {v0 .. v6}, Lcom/b/a/a/c/h;-><init>(Ljava/util/List;Lcom/b/a/a/b/g;Lcom/b/a/a/c/c;Lcom/b/a/m;ILcom/b/a/ao;)V

    .line 179
    iget-object v1, p0, Lcom/b/a/am;->c:Lcom/b/a/ao;

    invoke-interface {v0, v1}, Lcom/b/a/ag;->a(Lcom/b/a/ao;)Lcom/b/a/as;

    move-result-object v0

    return-object v0

    .line 7326
    :cond_1
    iget-object v0, v0, Lcom/b/a/ai;->l:Lcom/b/a/a/a/i;

    goto :goto_0
.end method

.method public final synthetic clone()Ljava/lang/Object;
    .locals 4

    .prologue
    .line 33
    .line 8099
    new-instance v0, Lcom/b/a/am;

    iget-object v1, p0, Lcom/b/a/am;->a:Lcom/b/a/ai;

    iget-object v2, p0, Lcom/b/a/am;->c:Lcom/b/a/ao;

    iget-boolean v3, p0, Lcom/b/a/am;->d:Z

    invoke-direct {v0, v1, v2, v3}, Lcom/b/a/am;-><init>(Lcom/b/a/ai;Lcom/b/a/ao;Z)V

    .line 33
    return-object v0
.end method
