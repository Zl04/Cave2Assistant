.class public final Lcom/b/b/k;
.super Lcom/b/b/y;
.source "SourceFile"


# instance fields
.field private a:Lcom/b/b/y;


# direct methods
.method public constructor <init>(Lcom/b/b/y;)V
    .locals 2

    .prologue
    .line 25
    invoke-direct {p0}, Lcom/b/b/y;-><init>()V

    .line 26
    if-nez p1, :cond_0

    new-instance v0, Ljava/lang/IllegalArgumentException;

    const-string v1, "delegate == null"

    invoke-direct {v0, v1}, Ljava/lang/IllegalArgumentException;-><init>(Ljava/lang/String;)V

    throw v0

    .line 27
    :cond_0
    iput-object p1, p0, Lcom/b/b/k;->a:Lcom/b/b/y;

    .line 28
    return-void
.end method


# virtual methods
.method public final a(Lcom/b/b/y;)Lcom/b/b/k;
    .locals 2

    .prologue
    .line 36
    if-nez p1, :cond_0

    new-instance v0, Ljava/lang/IllegalArgumentException;

    const-string v1, "delegate == null"

    invoke-direct {v0, v1}, Ljava/lang/IllegalArgumentException;-><init>(Ljava/lang/String;)V

    throw v0

    .line 37
    :cond_0
    iput-object p1, p0, Lcom/b/b/k;->a:Lcom/b/b/y;

    .line 38
    return-object p0
.end method

.method public final a()Lcom/b/b/y;
    .locals 1

    .prologue
    .line 32
    iget-object v0, p0, Lcom/b/b/k;->a:Lcom/b/b/y;

    return-object v0
.end method

.method public final a(J)Lcom/b/b/y;
    .locals 1

    .prologue
    .line 58
    iget-object v0, p0, Lcom/b/b/k;->a:Lcom/b/b/y;

    invoke-virtual {v0, p1, p2}, Lcom/b/b/y;->a(J)Lcom/b/b/y;

    move-result-object v0

    return-object v0
.end method

.method public final a(JLjava/util/concurrent/TimeUnit;)Lcom/b/b/y;
    .locals 1

    .prologue
    .line 42
    iget-object v0, p0, Lcom/b/b/k;->a:Lcom/b/b/y;

    invoke-virtual {v0, p1, p2, p3}, Lcom/b/b/y;->a(JLjava/util/concurrent/TimeUnit;)Lcom/b/b/y;

    move-result-object v0

    return-object v0
.end method

.method public final b_()J
    .locals 2

    .prologue
    .line 46
    iget-object v0, p0, Lcom/b/b/k;->a:Lcom/b/b/y;

    invoke-virtual {v0}, Lcom/b/b/y;->b_()J

    move-result-wide v0

    return-wide v0
.end method

.method public final c_()Z
    .locals 1

    .prologue
    .line 50
    iget-object v0, p0, Lcom/b/b/k;->a:Lcom/b/b/y;

    invoke-virtual {v0}, Lcom/b/b/y;->c_()Z

    move-result v0

    return v0
.end method

.method public final d()J
    .locals 2

    .prologue
    .line 54
    iget-object v0, p0, Lcom/b/b/k;->a:Lcom/b/b/y;

    invoke-virtual {v0}, Lcom/b/b/y;->d()J

    move-result-wide v0

    return-wide v0
.end method

.method public final d_()Lcom/b/b/y;
    .locals 1

    .prologue
    .line 62
    iget-object v0, p0, Lcom/b/b/k;->a:Lcom/b/b/y;

    invoke-virtual {v0}, Lcom/b/b/y;->d_()Lcom/b/b/y;

    move-result-object v0

    return-object v0
.end method

.method public final e_()Lcom/b/b/y;
    .locals 1

    .prologue
    .line 66
    iget-object v0, p0, Lcom/b/b/k;->a:Lcom/b/b/y;

    invoke-virtual {v0}, Lcom/b/b/y;->e_()Lcom/b/b/y;

    move-result-object v0

    return-object v0
.end method

.method public final f_()V
    .locals 1

    .prologue
    .line 70
    iget-object v0, p0, Lcom/b/b/k;->a:Lcom/b/b/y;

    invoke-virtual {v0}, Lcom/b/b/y;->f_()V

    .line 71
    return-void
.end method
