.class public final Lcom/b/a/d;
.super Ljava/lang/Object;
.source "SourceFile"

# interfaces
.implements Ljava/io/Closeable;
.implements Ljava/io/Flushable;


# instance fields
.field final a:Lcom/b/a/a/a/i;

.field final b:Lcom/b/a/a/a/f;


# virtual methods
.method public final close()V
    .locals 1

    .prologue
    .line 390
    iget-object v0, p0, Lcom/b/a/d;->b:Lcom/b/a/a/a/f;

    invoke-virtual {v0}, Lcom/b/a/a/a/f;->close()V

    .line 391
    return-void
.end method

.method public final flush()V
    .locals 1

    .prologue
    .line 386
    iget-object v0, p0, Lcom/b/a/d;->b:Lcom/b/a/a/a/f;

    invoke-virtual {v0}, Lcom/b/a/a/a/f;->flush()V

    .line 387
    return-void
.end method
