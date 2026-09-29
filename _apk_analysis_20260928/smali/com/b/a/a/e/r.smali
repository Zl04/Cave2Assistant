.class public final Lcom/b/a/a/e/r;
.super Ljava/lang/Object;
.source "SourceFile"


# instance fields
.field a:Ljava/net/Socket;

.field b:Ljava/lang/String;

.field c:Lcom/b/b/h;

.field d:Lcom/b/b/g;

.field e:Lcom/b/a/a/e/s;

.field f:Lcom/b/a/a/e/aj;

.field g:Z


# direct methods
.method public constructor <init>()V
    .locals 1

    .prologue
    .line 516
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    .line 508
    sget-object v0, Lcom/b/a/a/e/s;->f:Lcom/b/a/a/e/s;

    iput-object v0, p0, Lcom/b/a/a/e/r;->e:Lcom/b/a/a/e/s;

    .line 509
    sget-object v0, Lcom/b/a/a/e/aj;->a:Lcom/b/a/a/e/aj;

    iput-object v0, p0, Lcom/b/a/a/e/r;->f:Lcom/b/a/a/e/aj;

    .line 517
    const/4 v0, 0x1

    iput-boolean v0, p0, Lcom/b/a/a/e/r;->g:Z

    .line 518
    return-void
.end method


# virtual methods
.method public final a()Lcom/b/a/a/e/j;
    .locals 1

    .prologue
    .line 545
    new-instance v0, Lcom/b/a/a/e/j;

    invoke-direct {v0, p0}, Lcom/b/a/a/e/j;-><init>(Lcom/b/a/a/e/r;)V

    return-object v0
.end method

.method public final a(Lcom/b/a/a/e/s;)Lcom/b/a/a/e/r;
    .locals 0

    .prologue
    .line 535
    iput-object p1, p0, Lcom/b/a/a/e/r;->e:Lcom/b/a/a/e/s;

    .line 536
    return-object p0
.end method

.method public final a(Ljava/net/Socket;Ljava/lang/String;Lcom/b/b/h;Lcom/b/b/g;)Lcom/b/a/a/e/r;
    .locals 0

    .prologue
    .line 527
    iput-object p1, p0, Lcom/b/a/a/e/r;->a:Ljava/net/Socket;

    .line 528
    iput-object p2, p0, Lcom/b/a/a/e/r;->b:Ljava/lang/String;

    .line 529
    iput-object p3, p0, Lcom/b/a/a/e/r;->c:Lcom/b/b/h;

    .line 530
    iput-object p4, p0, Lcom/b/a/a/e/r;->d:Lcom/b/b/g;

    .line 531
    return-object p0
.end method
