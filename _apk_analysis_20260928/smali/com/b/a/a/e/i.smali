.class final Lcom/b/a/a/e/i;
.super Lcom/b/b/j;
.source "SourceFile"


# instance fields
.field final synthetic a:Lcom/b/a/a/e/h;


# direct methods
.method public constructor <init>(Lcom/b/a/a/e/h;Lcom/b/b/x;)V
    .locals 0

    .prologue
    .line 193
    iput-object p1, p0, Lcom/b/a/a/e/i;->a:Lcom/b/a/a/e/h;

    .line 194
    invoke-direct {p0, p2}, Lcom/b/b/j;-><init>(Lcom/b/b/x;)V

    .line 195
    return-void
.end method


# virtual methods
.method public final close()V
    .locals 3

    .prologue
    .line 198
    iget-object v0, p0, Lcom/b/a/a/e/i;->a:Lcom/b/a/a/e/h;

    iget-object v0, v0, Lcom/b/a/a/e/h;->a:Lcom/b/a/a/b/g;

    const/4 v1, 0x0

    iget-object v2, p0, Lcom/b/a/a/e/i;->a:Lcom/b/a/a/e/h;

    invoke-virtual {v0, v1, v2}, Lcom/b/a/a/b/g;->a(ZLcom/b/a/a/c/c;)V

    .line 199
    invoke-super {p0}, Lcom/b/b/j;->close()V

    .line 200
    return-void
.end method
