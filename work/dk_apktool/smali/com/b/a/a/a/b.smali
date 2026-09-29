.class final Lcom/b/a/a/a/b;
.super Ljava/lang/Object;
.source "SourceFile"

# interfaces
.implements Lcom/b/b/x;


# instance fields
.field a:Z

.field final synthetic b:Lcom/b/b/h;

.field final synthetic c:Lcom/b/a/a/a/c;

.field final synthetic d:Lcom/b/b/g;

.field final synthetic e:Lcom/b/a/a/a/a;


# direct methods
.method constructor <init>(Lcom/b/a/a/a/a;Lcom/b/b/h;Lcom/b/a/a/a/c;Lcom/b/b/g;)V
    .locals 0

    .prologue
    .line 177
    iput-object p1, p0, Lcom/b/a/a/a/b;->e:Lcom/b/a/a/a/a;

    iput-object p2, p0, Lcom/b/a/a/a/b;->b:Lcom/b/b/h;

    iput-object p3, p0, Lcom/b/a/a/a/b;->c:Lcom/b/a/a/a/c;

    iput-object p4, p0, Lcom/b/a/a/a/b;->d:Lcom/b/b/g;

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method


# virtual methods
.method public final a(Lcom/b/b/f;J)J
    .locals 6

    .prologue
    const-wide/16 v0, -0x1

    const/4 v3, 0x1

    .line 183
    :try_start_0
    iget-object v2, p0, Lcom/b/a/a/a/b;->b:Lcom/b/b/h;

    invoke-interface {v2, p1, p2, p3}, Lcom/b/b/h;->a(Lcom/b/b/f;J)J
    :try_end_0
    .catch Ljava/io/IOException; {:try_start_0 .. :try_end_0} :catch_0

    move-result-wide v4

    .line 192
    cmp-long v2, v4, v0

    if-nez v2, :cond_2

    .line 193
    iget-boolean v2, p0, Lcom/b/a/a/a/b;->a:Z

    if-nez v2, :cond_0

    .line 194
    iput-boolean v3, p0, Lcom/b/a/a/a/b;->a:Z

    .line 195
    iget-object v2, p0, Lcom/b/a/a/a/b;->d:Lcom/b/b/g;

    invoke-interface {v2}, Lcom/b/b/g;->close()V

    :cond_0
    move-wide v4, v0

    .line 202
    :goto_0
    return-wide v4

    .line 184
    :catch_0
    move-exception v0

    .line 185
    iget-boolean v1, p0, Lcom/b/a/a/a/b;->a:Z

    if-nez v1, :cond_1

    .line 186
    iput-boolean v3, p0, Lcom/b/a/a/a/b;->a:Z

    .line 189
    :cond_1
    throw v0

    .line 200
    :cond_2
    iget-object v0, p0, Lcom/b/a/a/a/b;->d:Lcom/b/b/g;

    invoke-interface {v0}, Lcom/b/b/g;->c()Lcom/b/b/f;

    move-result-object v1

    invoke-virtual {p1}, Lcom/b/b/f;->b()J

    move-result-wide v2

    sub-long/2addr v2, v4

    move-object v0, p1

    invoke-virtual/range {v0 .. v5}, Lcom/b/b/f;->a(Lcom/b/b/f;JJ)Lcom/b/b/f;

    .line 201
    iget-object v0, p0, Lcom/b/a/a/a/b;->d:Lcom/b/b/g;

    invoke-interface {v0}, Lcom/b/b/g;->p()Lcom/b/b/g;

    goto :goto_0
.end method

.method public final a()Lcom/b/b/y;
    .locals 1

    .prologue
    .line 206
    iget-object v0, p0, Lcom/b/a/a/a/b;->b:Lcom/b/b/h;

    invoke-interface {v0}, Lcom/b/b/h;->a()Lcom/b/b/y;

    move-result-object v0

    return-object v0
.end method

.method public final close()V
    .locals 1

    .prologue
    .line 210
    iget-boolean v0, p0, Lcom/b/a/a/a/b;->a:Z

    if-nez v0, :cond_0

    sget-object v0, Ljava/util/concurrent/TimeUnit;->MILLISECONDS:Ljava/util/concurrent/TimeUnit;

    .line 211
    invoke-static {p0, v0}, Lcom/b/a/a/c;->a(Lcom/b/b/x;Ljava/util/concurrent/TimeUnit;)Z

    move-result v0

    if-nez v0, :cond_0

    .line 212
    const/4 v0, 0x1

    iput-boolean v0, p0, Lcom/b/a/a/a/b;->a:Z

    .line 215
    :cond_0
    iget-object v0, p0, Lcom/b/a/a/a/b;->b:Lcom/b/b/h;

    invoke-interface {v0}, Lcom/b/b/h;->close()V

    .line 216
    return-void
.end method
