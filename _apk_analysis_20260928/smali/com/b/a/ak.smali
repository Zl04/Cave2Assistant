.class public final Lcom/b/a/ak;
.super Ljava/lang/Object;
.source "SourceFile"


# instance fields
.field a:Lcom/b/a/u;

.field b:Ljava/net/Proxy;

.field c:Ljava/util/List;
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "Ljava/util/List",
            "<",
            "Lcom/b/a/al;",
            ">;"
        }
    .end annotation
.end field

.field d:Ljava/util/List;
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "Ljava/util/List",
            "<",
            "Lcom/b/a/p;",
            ">;"
        }
    .end annotation
.end field

.field final e:Ljava/util/List;
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "Ljava/util/List",
            "<",
            "Lcom/b/a/af;",
            ">;"
        }
    .end annotation
.end field

.field final f:Ljava/util/List;
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "Ljava/util/List",
            "<",
            "Lcom/b/a/af;",
            ">;"
        }
    .end annotation
.end field

.field g:Ljava/net/ProxySelector;

.field h:Lcom/b/a/s;

.field i:Lcom/b/a/d;

.field j:Lcom/b/a/a/a/i;

.field k:Ljavax/net/SocketFactory;

.field l:Ljavax/net/ssl/SSLSocketFactory;

.field m:Lcom/b/a/a/h/b;

.field n:Ljavax/net/ssl/HostnameVerifier;

.field o:Lcom/b/a/i;

.field p:Lcom/b/a/b;

.field q:Lcom/b/a/b;

.field r:Lcom/b/a/n;

.field s:Lcom/b/a/v;

.field t:Z

.field u:Z

.field v:Z

.field w:I

.field x:I

.field y:I

.field z:I


# direct methods
.method public constructor <init>()V
    .locals 3

    .prologue
    const/16 v2, 0x2710

    const/4 v1, 0x1

    .line 451
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    .line 428
    new-instance v0, Ljava/util/ArrayList;

    invoke-direct {v0}, Ljava/util/ArrayList;-><init>()V

    iput-object v0, p0, Lcom/b/a/ak;->e:Ljava/util/List;

    .line 429
    new-instance v0, Ljava/util/ArrayList;

    invoke-direct {v0}, Ljava/util/ArrayList;-><init>()V

    iput-object v0, p0, Lcom/b/a/ak;->f:Ljava/util/List;

    .line 452
    new-instance v0, Lcom/b/a/u;

    invoke-direct {v0}, Lcom/b/a/u;-><init>()V

    iput-object v0, p0, Lcom/b/a/ak;->a:Lcom/b/a/u;

    .line 453
    sget-object v0, Lcom/b/a/ai;->a:Ljava/util/List;

    iput-object v0, p0, Lcom/b/a/ak;->c:Ljava/util/List;

    .line 454
    sget-object v0, Lcom/b/a/ai;->b:Ljava/util/List;

    iput-object v0, p0, Lcom/b/a/ak;->d:Ljava/util/List;

    .line 455
    invoke-static {}, Ljava/net/ProxySelector;->getDefault()Ljava/net/ProxySelector;

    move-result-object v0

    iput-object v0, p0, Lcom/b/a/ak;->g:Ljava/net/ProxySelector;

    .line 456
    sget-object v0, Lcom/b/a/s;->a:Lcom/b/a/s;

    iput-object v0, p0, Lcom/b/a/ak;->h:Lcom/b/a/s;

    .line 457
    invoke-static {}, Ljavax/net/SocketFactory;->getDefault()Ljavax/net/SocketFactory;

    move-result-object v0

    iput-object v0, p0, Lcom/b/a/ak;->k:Ljavax/net/SocketFactory;

    .line 458
    sget-object v0, Lcom/b/a/a/h/d;->a:Lcom/b/a/a/h/d;

    iput-object v0, p0, Lcom/b/a/ak;->n:Ljavax/net/ssl/HostnameVerifier;

    .line 459
    sget-object v0, Lcom/b/a/i;->a:Lcom/b/a/i;

    iput-object v0, p0, Lcom/b/a/ak;->o:Lcom/b/a/i;

    .line 460
    sget-object v0, Lcom/b/a/b;->a:Lcom/b/a/b;

    iput-object v0, p0, Lcom/b/a/ak;->p:Lcom/b/a/b;

    .line 461
    sget-object v0, Lcom/b/a/b;->a:Lcom/b/a/b;

    iput-object v0, p0, Lcom/b/a/ak;->q:Lcom/b/a/b;

    .line 462
    new-instance v0, Lcom/b/a/n;

    invoke-direct {v0}, Lcom/b/a/n;-><init>()V

    iput-object v0, p0, Lcom/b/a/ak;->r:Lcom/b/a/n;

    .line 463
    sget-object v0, Lcom/b/a/v;->a:Lcom/b/a/v;

    iput-object v0, p0, Lcom/b/a/ak;->s:Lcom/b/a/v;

    .line 464
    iput-boolean v1, p0, Lcom/b/a/ak;->t:Z

    .line 465
    iput-boolean v1, p0, Lcom/b/a/ak;->u:Z

    .line 466
    iput-boolean v1, p0, Lcom/b/a/ak;->v:Z

    .line 467
    iput v2, p0, Lcom/b/a/ak;->w:I

    .line 468
    iput v2, p0, Lcom/b/a/ak;->x:I

    .line 469
    iput v2, p0, Lcom/b/a/ak;->y:I

    .line 470
    const/4 v0, 0x0

    iput v0, p0, Lcom/b/a/ak;->z:I

    .line 471
    return-void
.end method
