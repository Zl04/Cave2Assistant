.class public final Lcom/b/a/as;
.super Ljava/lang/Object;
.source "SourceFile"

# interfaces
.implements Ljava/io/Closeable;


# instance fields
.field final a:Lcom/b/a/ao;

.field final b:Lcom/b/a/al;

.field final c:I

.field final d:Ljava/lang/String;

.field final e:Lcom/b/a/z;

.field final f:Lcom/b/a/aa;

.field final g:Lcom/b/a/au;

.field final h:Lcom/b/a/as;

.field final i:Lcom/b/a/as;

.field final j:Lcom/b/a/as;

.field final k:J

.field final l:J

.field private volatile m:Lcom/b/a/e;


# direct methods
.method constructor <init>(Lcom/b/a/at;)V
    .locals 2

    .prologue
    .line 58
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    .line 59
    iget-object v0, p1, Lcom/b/a/at;->a:Lcom/b/a/ao;

    iput-object v0, p0, Lcom/b/a/as;->a:Lcom/b/a/ao;

    .line 60
    iget-object v0, p1, Lcom/b/a/at;->b:Lcom/b/a/al;

    iput-object v0, p0, Lcom/b/a/as;->b:Lcom/b/a/al;

    .line 61
    iget v0, p1, Lcom/b/a/at;->c:I

    iput v0, p0, Lcom/b/a/as;->c:I

    .line 62
    iget-object v0, p1, Lcom/b/a/at;->d:Ljava/lang/String;

    iput-object v0, p0, Lcom/b/a/as;->d:Ljava/lang/String;

    .line 63
    iget-object v0, p1, Lcom/b/a/at;->e:Lcom/b/a/z;

    iput-object v0, p0, Lcom/b/a/as;->e:Lcom/b/a/z;

    .line 64
    iget-object v0, p1, Lcom/b/a/at;->f:Lcom/b/a/ab;

    invoke-virtual {v0}, Lcom/b/a/ab;->a()Lcom/b/a/aa;

    move-result-object v0

    iput-object v0, p0, Lcom/b/a/as;->f:Lcom/b/a/aa;

    .line 65
    iget-object v0, p1, Lcom/b/a/at;->g:Lcom/b/a/au;

    iput-object v0, p0, Lcom/b/a/as;->g:Lcom/b/a/au;

    .line 66
    iget-object v0, p1, Lcom/b/a/at;->h:Lcom/b/a/as;

    iput-object v0, p0, Lcom/b/a/as;->h:Lcom/b/a/as;

    .line 67
    iget-object v0, p1, Lcom/b/a/at;->i:Lcom/b/a/as;

    iput-object v0, p0, Lcom/b/a/as;->i:Lcom/b/a/as;

    .line 68
    iget-object v0, p1, Lcom/b/a/at;->j:Lcom/b/a/as;

    iput-object v0, p0, Lcom/b/a/as;->j:Lcom/b/a/as;

    .line 69
    iget-wide v0, p1, Lcom/b/a/at;->k:J

    iput-wide v0, p0, Lcom/b/a/as;->k:J

    .line 70
    iget-wide v0, p1, Lcom/b/a/at;->l:J

    iput-wide v0, p0, Lcom/b/a/as;->l:J

    .line 71
    return-void
.end method


# virtual methods
.method public final a()Lcom/b/a/ao;
    .locals 1

    .prologue
    .line 85
    iget-object v0, p0, Lcom/b/a/as;->a:Lcom/b/a/ao;

    return-object v0
.end method

.method public final a(Ljava/lang/String;)Ljava/lang/String;
    .locals 1

    .prologue
    .line 126
    .line 1130
    iget-object v0, p0, Lcom/b/a/as;->f:Lcom/b/a/aa;

    invoke-virtual {v0, p1}, Lcom/b/a/aa;->a(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v0

    .line 1131
    if-eqz v0, :cond_0

    :goto_0
    return-object v0

    :cond_0
    const/4 v0, 0x0

    .line 126
    goto :goto_0
.end method

.method public final b()I
    .locals 1

    .prologue
    .line 97
    iget v0, p0, Lcom/b/a/as;->c:I

    return v0
.end method

.method public final c()Lcom/b/a/z;
    .locals 1

    .prologue
    .line 118
    iget-object v0, p0, Lcom/b/a/as;->e:Lcom/b/a/z;

    return-object v0
.end method

.method public final close()V
    .locals 1

    .prologue
    .line 273
    iget-object v0, p0, Lcom/b/a/as;->g:Lcom/b/a/au;

    invoke-virtual {v0}, Lcom/b/a/au;->close()V

    .line 274
    return-void
.end method

.method public final d()Lcom/b/a/aa;
    .locals 1

    .prologue
    .line 135
    iget-object v0, p0, Lcom/b/a/as;->f:Lcom/b/a/aa;

    return-object v0
.end method

.method public final e()Lcom/b/a/au;
    .locals 1

    .prologue
    .line 176
    iget-object v0, p0, Lcom/b/a/as;->g:Lcom/b/a/au;

    return-object v0
.end method

.method public final f()Lcom/b/a/at;
    .locals 1

    .prologue
    .line 180
    new-instance v0, Lcom/b/a/at;

    invoke-direct {v0, p0}, Lcom/b/a/at;-><init>(Lcom/b/a/as;)V

    return-object v0
.end method

.method public final g()Lcom/b/a/e;
    .locals 1

    .prologue
    .line 249
    iget-object v0, p0, Lcom/b/a/as;->m:Lcom/b/a/e;

    .line 250
    if-eqz v0, :cond_0

    :goto_0
    return-object v0

    :cond_0
    iget-object v0, p0, Lcom/b/a/as;->f:Lcom/b/a/aa;

    invoke-static {v0}, Lcom/b/a/e;->a(Lcom/b/a/aa;)Lcom/b/a/e;

    move-result-object v0

    iput-object v0, p0, Lcom/b/a/as;->m:Lcom/b/a/e;

    goto :goto_0
.end method

.method public final h()J
    .locals 2

    .prologue
    .line 259
    iget-wide v0, p0, Lcom/b/a/as;->k:J

    return-wide v0
.end method

.method public final i()J
    .locals 2

    .prologue
    .line 268
    iget-wide v0, p0, Lcom/b/a/as;->l:J

    return-wide v0
.end method

.method public final toString()Ljava/lang/String;
    .locals 2

    .prologue
    .line 277
    new-instance v0, Ljava/lang/StringBuilder;

    const-string v1, "Response{protocol="

    invoke-direct {v0, v1}, Ljava/lang/StringBuilder;-><init>(Ljava/lang/String;)V

    iget-object v1, p0, Lcom/b/a/as;->b:Lcom/b/a/al;

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/Object;)Ljava/lang/StringBuilder;

    move-result-object v0

    const-string v1, ", code="

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    iget v1, p0, Lcom/b/a/as;->c:I

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v0

    const-string v1, ", message="

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    iget-object v1, p0, Lcom/b/a/as;->d:Ljava/lang/String;

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    const-string v1, ", url="

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    iget-object v1, p0, Lcom/b/a/as;->a:Lcom/b/a/ao;

    .line 2045
    iget-object v1, v1, Lcom/b/a/ao;->a:Lcom/b/a/ac;

    .line 284
    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/Object;)Ljava/lang/StringBuilder;

    move-result-object v0

    const/16 v1, 0x7d

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(C)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-virtual {v0}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v0

    .line 277
    return-object v0
.end method
