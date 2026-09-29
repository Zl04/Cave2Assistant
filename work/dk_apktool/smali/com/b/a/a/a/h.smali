.class final Lcom/b/a/a/a/h;
.super Ljava/lang/Object;
.source "SourceFile"


# instance fields
.field final a:Ljava/lang/String;

.field final b:[J

.field final c:[Ljava/io/File;

.field final d:[Ljava/io/File;

.field e:Z

.field f:Lcom/b/a/a/a/g;


# virtual methods
.method final a(Lcom/b/b/g;)V
    .locals 6

    .prologue
    .line 1009
    iget-object v1, p0, Lcom/b/a/a/a/h;->b:[J

    array-length v2, v1

    const/4 v0, 0x0

    :goto_0
    if-ge v0, v2, :cond_0

    aget-wide v4, v1, v0

    .line 1010
    const/16 v3, 0x20

    invoke-interface {p1, v3}, Lcom/b/b/g;->h(I)Lcom/b/b/g;

    move-result-object v3

    invoke-interface {v3, v4, v5}, Lcom/b/b/g;->j(J)Lcom/b/b/g;

    .line 1009
    add-int/lit8 v0, v0, 0x1

    goto :goto_0

    .line 1012
    :cond_0
    return-void
.end method
