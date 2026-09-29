.class final Lcom/b/a/a/e/w;
.super Lcom/b/a/a/b;
.source "SourceFile"


# instance fields
.field final synthetic a:Lcom/b/a/a/e/u;


# direct methods
.method varargs constructor <init>(Lcom/b/a/a/e/u;Ljava/lang/String;[Ljava/lang/Object;)V
    .locals 0

    .prologue
    .line 677
    iput-object p1, p0, Lcom/b/a/a/e/w;->a:Lcom/b/a/a/e/u;

    invoke-direct {p0, p2, p3}, Lcom/b/a/a/b;-><init>(Ljava/lang/String;[Ljava/lang/Object;)V

    return-void
.end method


# virtual methods
.method public final b()V
    .locals 2

    .prologue
    .line 679
    iget-object v0, p0, Lcom/b/a/a/e/w;->a:Lcom/b/a/a/e/u;

    iget-object v0, v0, Lcom/b/a/a/e/u;->c:Lcom/b/a/a/e/j;

    iget-object v0, v0, Lcom/b/a/a/e/j;->c:Lcom/b/a/a/e/s;

    iget-object v1, p0, Lcom/b/a/a/e/w;->a:Lcom/b/a/a/e/u;

    iget-object v1, v1, Lcom/b/a/a/e/u;->c:Lcom/b/a/a/e/j;

    invoke-virtual {v0, v1}, Lcom/b/a/a/e/s;->a(Lcom/b/a/a/e/j;)V

    .line 680
    return-void
.end method
