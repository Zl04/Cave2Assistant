.class abstract Lcom/b/a/a/d/b;
.super Ljava/lang/Object;
.source "SourceFile"

# interfaces
.implements Lcom/b/b/x;


# instance fields
.field protected final a:Lcom/b/b/k;

.field protected b:Z

.field final synthetic c:Lcom/b/a/a/d/a;


# direct methods
.method private constructor <init>(Lcom/b/a/a/d/a;)V
    .locals 2

    .prologue
    .line 343
    iput-object p1, p0, Lcom/b/a/a/d/b;->c:Lcom/b/a/a/d/a;

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    .line 344
    new-instance v0, Lcom/b/b/k;

    iget-object v1, p0, Lcom/b/a/a/d/b;->c:Lcom/b/a/a/d/a;

    iget-object v1, v1, Lcom/b/a/a/d/a;->c:Lcom/b/b/h;

    invoke-interface {v1}, Lcom/b/b/h;->a()Lcom/b/b/y;

    move-result-object v1

    invoke-direct {v0, v1}, Lcom/b/b/k;-><init>(Lcom/b/b/y;)V

    iput-object v0, p0, Lcom/b/a/a/d/b;->a:Lcom/b/b/k;

    return-void
.end method

.method synthetic constructor <init>(Lcom/b/a/a/d/a;B)V
    .locals 0

    .prologue
    .line 343
    invoke-direct {p0, p1}, Lcom/b/a/a/d/b;-><init>(Lcom/b/a/a/d/a;)V

    return-void
.end method


# virtual methods
.method public final a()Lcom/b/b/y;
    .locals 1

    .prologue
    .line 348
    iget-object v0, p0, Lcom/b/a/a/d/b;->a:Lcom/b/b/k;

    return-object v0
.end method

.method protected final a(Z)V
    .locals 3

    .prologue
    const/4 v2, 0x6

    .line 356
    iget-object v0, p0, Lcom/b/a/a/d/b;->c:Lcom/b/a/a/d/a;

    iget v0, v0, Lcom/b/a/a/d/a;->e:I

    if-ne v0, v2, :cond_1

    .line 365
    :cond_0
    :goto_0
    return-void

    .line 357
    :cond_1
    iget-object v0, p0, Lcom/b/a/a/d/b;->c:Lcom/b/a/a/d/a;

    iget v0, v0, Lcom/b/a/a/d/a;->e:I

    const/4 v1, 0x5

    if-eq v0, v1, :cond_2

    new-instance v0, Ljava/lang/IllegalStateException;

    new-instance v1, Ljava/lang/StringBuilder;

    const-string v2, "state: "

    invoke-direct {v1, v2}, Ljava/lang/StringBuilder;-><init>(Ljava/lang/String;)V

    iget-object v2, p0, Lcom/b/a/a/d/b;->c:Lcom/b/a/a/d/a;

    iget v2, v2, Lcom/b/a/a/d/a;->e:I

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v1

    invoke-direct {v0, v1}, Ljava/lang/IllegalStateException;-><init>(Ljava/lang/String;)V

    throw v0

    .line 359
    :cond_2
    iget-object v0, p0, Lcom/b/a/a/d/b;->a:Lcom/b/b/k;

    invoke-static {v0}, Lcom/b/a/a/d/a;->a(Lcom/b/b/k;)V

    .line 361
    iget-object v0, p0, Lcom/b/a/a/d/b;->c:Lcom/b/a/a/d/a;

    iput v2, v0, Lcom/b/a/a/d/a;->e:I

    .line 362
    iget-object v0, p0, Lcom/b/a/a/d/b;->c:Lcom/b/a/a/d/a;

    iget-object v0, v0, Lcom/b/a/a/d/a;->b:Lcom/b/a/a/b/g;

    if-eqz v0, :cond_0

    .line 363
    iget-object v0, p0, Lcom/b/a/a/d/b;->c:Lcom/b/a/a/d/a;

    iget-object v1, v0, Lcom/b/a/a/d/a;->b:Lcom/b/a/a/b/g;

    if-nez p1, :cond_3

    const/4 v0, 0x1

    :goto_1
    iget-object v2, p0, Lcom/b/a/a/d/b;->c:Lcom/b/a/a/d/a;

    invoke-virtual {v1, v0, v2}, Lcom/b/a/a/b/g;->a(ZLcom/b/a/a/c/c;)V

    goto :goto_0

    :cond_3
    const/4 v0, 0x0

    goto :goto_1
.end method
