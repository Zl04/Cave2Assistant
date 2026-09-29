.class public final Lcom/b/a/ao;
.super Ljava/lang/Object;
.source "SourceFile"


# instance fields
.field final a:Lcom/b/a/ac;

.field final b:Ljava/lang/String;

.field final c:Lcom/b/a/aa;

.field final d:Lcom/b/a/aq;

.field final e:Ljava/lang/Object;

.field private volatile f:Lcom/b/a/e;


# direct methods
.method constructor <init>(Lcom/b/a/ap;)V
    .locals 1

    .prologue
    .line 36
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    .line 37
    iget-object v0, p1, Lcom/b/a/ap;->a:Lcom/b/a/ac;

    iput-object v0, p0, Lcom/b/a/ao;->a:Lcom/b/a/ac;

    .line 38
    iget-object v0, p1, Lcom/b/a/ap;->b:Ljava/lang/String;

    iput-object v0, p0, Lcom/b/a/ao;->b:Ljava/lang/String;

    .line 39
    iget-object v0, p1, Lcom/b/a/ap;->c:Lcom/b/a/ab;

    invoke-virtual {v0}, Lcom/b/a/ab;->a()Lcom/b/a/aa;

    move-result-object v0

    iput-object v0, p0, Lcom/b/a/ao;->c:Lcom/b/a/aa;

    .line 40
    iget-object v0, p1, Lcom/b/a/ap;->d:Lcom/b/a/aq;

    iput-object v0, p0, Lcom/b/a/ao;->d:Lcom/b/a/aq;

    .line 41
    iget-object v0, p1, Lcom/b/a/ap;->e:Ljava/lang/Object;

    if-eqz v0, :cond_0

    iget-object v0, p1, Lcom/b/a/ap;->e:Ljava/lang/Object;

    :goto_0
    iput-object v0, p0, Lcom/b/a/ao;->e:Ljava/lang/Object;

    .line 42
    return-void

    :cond_0
    move-object v0, p0

    .line 41
    goto :goto_0
.end method


# virtual methods
.method public final a()Lcom/b/a/ac;
    .locals 1

    .prologue
    .line 45
    iget-object v0, p0, Lcom/b/a/ao;->a:Lcom/b/a/ac;

    return-object v0
.end method

.method public final a(Ljava/lang/String;)Ljava/lang/String;
    .locals 1

    .prologue
    .line 57
    iget-object v0, p0, Lcom/b/a/ao;->c:Lcom/b/a/aa;

    invoke-virtual {v0, p1}, Lcom/b/a/aa;->a(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v0

    return-object v0
.end method

.method public final b()Ljava/lang/String;
    .locals 1

    .prologue
    .line 49
    iget-object v0, p0, Lcom/b/a/ao;->b:Ljava/lang/String;

    return-object v0
.end method

.method public final c()Lcom/b/a/aa;
    .locals 1

    .prologue
    .line 53
    iget-object v0, p0, Lcom/b/a/ao;->c:Lcom/b/a/aa;

    return-object v0
.end method

.method public final d()Lcom/b/a/aq;
    .locals 1

    .prologue
    .line 65
    iget-object v0, p0, Lcom/b/a/ao;->d:Lcom/b/a/aq;

    return-object v0
.end method

.method public final e()Lcom/b/a/ap;
    .locals 1

    .prologue
    .line 73
    new-instance v0, Lcom/b/a/ap;

    invoke-direct {v0, p0}, Lcom/b/a/ap;-><init>(Lcom/b/a/ao;)V

    return-object v0
.end method

.method public final f()Lcom/b/a/e;
    .locals 1

    .prologue
    .line 81
    iget-object v0, p0, Lcom/b/a/ao;->f:Lcom/b/a/e;

    .line 82
    if-eqz v0, :cond_0

    :goto_0
    return-object v0

    :cond_0
    iget-object v0, p0, Lcom/b/a/ao;->c:Lcom/b/a/aa;

    invoke-static {v0}, Lcom/b/a/e;->a(Lcom/b/a/aa;)Lcom/b/a/e;

    move-result-object v0

    iput-object v0, p0, Lcom/b/a/ao;->f:Lcom/b/a/e;

    goto :goto_0
.end method

.method public final g()Z
    .locals 1

    .prologue
    .line 86
    iget-object v0, p0, Lcom/b/a/ao;->a:Lcom/b/a/ac;

    invoke-virtual {v0}, Lcom/b/a/ac;->c()Z

    move-result v0

    return v0
.end method

.method public final toString()Ljava/lang/String;
    .locals 2

    .prologue
    .line 90
    new-instance v0, Ljava/lang/StringBuilder;

    const-string v1, "Request{method="

    invoke-direct {v0, v1}, Ljava/lang/StringBuilder;-><init>(Ljava/lang/String;)V

    iget-object v1, p0, Lcom/b/a/ao;->b:Ljava/lang/String;

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    const-string v1, ", url="

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    iget-object v1, p0, Lcom/b/a/ao;->a:Lcom/b/a/ac;

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/Object;)Ljava/lang/StringBuilder;

    move-result-object v0

    const-string v1, ", tag="

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    iget-object v0, p0, Lcom/b/a/ao;->e:Ljava/lang/Object;

    if-eq v0, p0, :cond_0

    iget-object v0, p0, Lcom/b/a/ao;->e:Ljava/lang/Object;

    :goto_0
    invoke-virtual {v1, v0}, Ljava/lang/StringBuilder;->append(Ljava/lang/Object;)Ljava/lang/StringBuilder;

    move-result-object v0

    const/16 v1, 0x7d

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(C)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-virtual {v0}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v0

    return-object v0

    :cond_0
    const/4 v0, 0x0

    goto :goto_0
.end method
