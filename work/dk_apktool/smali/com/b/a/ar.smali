.class final Lcom/b/a/ar;
.super Lcom/b/a/aq;
.source "SourceFile"


# instance fields
.field final synthetic a:Lcom/b/a/ah;

.field final synthetic b:I

.field final synthetic c:[B

.field final synthetic d:I


# direct methods
.method constructor <init>(I[B)V
    .locals 1

    .prologue
    .line 86
    const/4 v0, 0x0

    iput-object v0, p0, Lcom/b/a/ar;->a:Lcom/b/a/ah;

    iput p1, p0, Lcom/b/a/ar;->b:I

    iput-object p2, p0, Lcom/b/a/ar;->c:[B

    const/4 v0, 0x0

    iput v0, p0, Lcom/b/a/ar;->d:I

    invoke-direct {p0}, Lcom/b/a/aq;-><init>()V

    return-void
.end method


# virtual methods
.method public final a()Lcom/b/a/ah;
    .locals 1

    .prologue
    .line 88
    iget-object v0, p0, Lcom/b/a/ar;->a:Lcom/b/a/ah;

    return-object v0
.end method

.method public final a(Lcom/b/b/g;)V
    .locals 3

    .prologue
    .line 96
    iget-object v0, p0, Lcom/b/a/ar;->c:[B

    iget v1, p0, Lcom/b/a/ar;->d:I

    iget v2, p0, Lcom/b/a/ar;->b:I

    invoke-interface {p1, v0, v1, v2}, Lcom/b/b/g;->b([BII)Lcom/b/b/g;

    .line 97
    return-void
.end method

.method public final b()J
    .locals 2

    .prologue
    .line 92
    iget v0, p0, Lcom/b/a/ar;->b:I

    int-to-long v0, v0

    return-wide v0
.end method
