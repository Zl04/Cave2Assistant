.class public Lcom/b/a/ai;
.super Ljava/lang/Object;
.source "SourceFile"

# interfaces
.implements Ljava/lang/Cloneable;


# static fields
.field static final a:Ljava/util/List;
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "Ljava/util/List",
            "<",
            "Lcom/b/a/al;",
            ">;"
        }
    .end annotation
.end field

.field static final b:Ljava/util/List;
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "Ljava/util/List",
            "<",
            "Lcom/b/a/p;",
            ">;"
        }
    .end annotation
.end field


# instance fields
.field final A:I

.field final B:I

.field final c:Lcom/b/a/u;

.field final d:Ljava/net/Proxy;

.field final e:Ljava/util/List;
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "Ljava/util/List",
            "<",
            "Lcom/b/a/al;",
            ">;"
        }
    .end annotation
.end field

.field final f:Ljava/util/List;
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "Ljava/util/List",
            "<",
            "Lcom/b/a/p;",
            ">;"
        }
    .end annotation
.end field

.field final g:Ljava/util/List;
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "Ljava/util/List",
            "<",
            "Lcom/b/a/af;",
            ">;"
        }
    .end annotation
.end field

.field final h:Ljava/util/List;
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "Ljava/util/List",
            "<",
            "Lcom/b/a/af;",
            ">;"
        }
    .end annotation
.end field

.field final i:Ljava/net/ProxySelector;

.field final j:Lcom/b/a/s;

.field final k:Lcom/b/a/d;

.field final l:Lcom/b/a/a/a/i;

.field final m:Ljavax/net/SocketFactory;

.field final n:Ljavax/net/ssl/SSLSocketFactory;

.field final o:Lcom/b/a/a/h/b;

.field final p:Ljavax/net/ssl/HostnameVerifier;

.field final q:Lcom/b/a/i;

.field final r:Lcom/b/a/b;

.field final s:Lcom/b/a/b;

.field final t:Lcom/b/a/n;

.field final u:Lcom/b/a/v;

.field final v:Z

.field final w:Z

.field final x:Z

.field final y:I

.field final z:I


# direct methods
.method static constructor <clinit>()V
    .locals 5

    .prologue
    const/4 v4, 0x2

    const/4 v3, 0x1

    const/4 v2, 0x0

    .line 122
    new-array v0, v4, [Lcom/b/a/al;

    sget-object v1, Lcom/b/a/al;->d:Lcom/b/a/al;

    aput-object v1, v0, v2

    sget-object v1, Lcom/b/a/al;->b:Lcom/b/a/al;

    aput-object v1, v0, v3

    invoke-static {v0}, Lcom/b/a/a/c;->a([Ljava/lang/Object;)Ljava/util/List;

    move-result-object v0

    sput-object v0, Lcom/b/a/ai;->a:Ljava/util/List;

    .line 125
    const/4 v0, 0x3

    new-array v0, v0, [Lcom/b/a/p;

    sget-object v1, Lcom/b/a/p;->a:Lcom/b/a/p;

    aput-object v1, v0, v2

    sget-object v1, Lcom/b/a/p;->b:Lcom/b/a/p;

    aput-object v1, v0, v3

    sget-object v1, Lcom/b/a/p;->c:Lcom/b/a/p;

    aput-object v1, v0, v4

    invoke-static {v0}, Lcom/b/a/a/c;->a([Ljava/lang/Object;)Ljava/util/List;

    move-result-object v0

    sput-object v0, Lcom/b/a/ai;->b:Ljava/util/List;

    .line 129
    new-instance v0, Lcom/b/a/aj;

    invoke-direct {v0}, Lcom/b/a/aj;-><init>()V

    sput-object v0, Lcom/b/a/a/a;->a:Lcom/b/a/a/a;

    .line 187
    return-void
.end method

.method public constructor <init>()V
    .locals 1

    .prologue
    .line 217
    new-instance v0, Lcom/b/a/ak;

    invoke-direct {v0}, Lcom/b/a/ak;-><init>()V

    invoke-direct {p0, v0}, Lcom/b/a/ai;-><init>(Lcom/b/a/ak;)V

    .line 218
    return-void
.end method

.method private constructor <init>(Lcom/b/a/ak;)V
    .locals 4

    .prologue
    const/4 v2, 0x0

    .line 220
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    .line 221
    iget-object v0, p1, Lcom/b/a/ak;->a:Lcom/b/a/u;

    iput-object v0, p0, Lcom/b/a/ai;->c:Lcom/b/a/u;

    .line 222
    iget-object v0, p1, Lcom/b/a/ak;->b:Ljava/net/Proxy;

    iput-object v0, p0, Lcom/b/a/ai;->d:Ljava/net/Proxy;

    .line 223
    iget-object v0, p1, Lcom/b/a/ak;->c:Ljava/util/List;

    iput-object v0, p0, Lcom/b/a/ai;->e:Ljava/util/List;

    .line 224
    iget-object v0, p1, Lcom/b/a/ak;->d:Ljava/util/List;

    iput-object v0, p0, Lcom/b/a/ai;->f:Ljava/util/List;

    .line 225
    iget-object v0, p1, Lcom/b/a/ak;->e:Ljava/util/List;

    invoke-static {v0}, Lcom/b/a/a/c;->a(Ljava/util/List;)Ljava/util/List;

    move-result-object v0

    iput-object v0, p0, Lcom/b/a/ai;->g:Ljava/util/List;

    .line 226
    iget-object v0, p1, Lcom/b/a/ak;->f:Ljava/util/List;

    invoke-static {v0}, Lcom/b/a/a/c;->a(Ljava/util/List;)Ljava/util/List;

    move-result-object v0

    iput-object v0, p0, Lcom/b/a/ai;->h:Ljava/util/List;

    .line 227
    iget-object v0, p1, Lcom/b/a/ak;->g:Ljava/net/ProxySelector;

    iput-object v0, p0, Lcom/b/a/ai;->i:Ljava/net/ProxySelector;

    .line 228
    iget-object v0, p1, Lcom/b/a/ak;->h:Lcom/b/a/s;

    iput-object v0, p0, Lcom/b/a/ai;->j:Lcom/b/a/s;

    .line 229
    iget-object v0, p1, Lcom/b/a/ak;->i:Lcom/b/a/d;

    iput-object v0, p0, Lcom/b/a/ai;->k:Lcom/b/a/d;

    .line 230
    iget-object v0, p1, Lcom/b/a/ak;->j:Lcom/b/a/a/a/i;

    iput-object v0, p0, Lcom/b/a/ai;->l:Lcom/b/a/a/a/i;

    .line 231
    iget-object v0, p1, Lcom/b/a/ak;->k:Ljavax/net/SocketFactory;

    iput-object v0, p0, Lcom/b/a/ai;->m:Ljavax/net/SocketFactory;

    .line 234
    iget-object v0, p0, Lcom/b/a/ai;->f:Ljava/util/List;

    invoke-interface {v0}, Ljava/util/List;->iterator()Ljava/util/Iterator;

    move-result-object v3

    move v1, v2

    :goto_0
    invoke-interface {v3}, Ljava/util/Iterator;->hasNext()Z

    move-result v0

    if-eqz v0, :cond_2

    invoke-interface {v3}, Ljava/util/Iterator;->next()Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Lcom/b/a/p;

    .line 235
    if-nez v1, :cond_0

    .line 1096
    iget-boolean v0, v0, Lcom/b/a/p;->d:Z

    .line 235
    if-eqz v0, :cond_1

    :cond_0
    const/4 v0, 0x1

    :goto_1
    move v1, v0

    .line 236
    goto :goto_0

    :cond_1
    move v0, v2

    .line 235
    goto :goto_1

    .line 238
    :cond_2
    iget-object v0, p1, Lcom/b/a/ak;->l:Ljavax/net/ssl/SSLSocketFactory;

    if-nez v0, :cond_3

    if-nez v1, :cond_4

    .line 239
    :cond_3
    iget-object v0, p1, Lcom/b/a/ak;->l:Ljavax/net/ssl/SSLSocketFactory;

    iput-object v0, p0, Lcom/b/a/ai;->n:Ljavax/net/ssl/SSLSocketFactory;

    .line 240
    iget-object v0, p1, Lcom/b/a/ak;->m:Lcom/b/a/a/h/b;

    iput-object v0, p0, Lcom/b/a/ai;->o:Lcom/b/a/a/h/b;

    .line 247
    :goto_2
    iget-object v0, p1, Lcom/b/a/ak;->n:Ljavax/net/ssl/HostnameVerifier;

    iput-object v0, p0, Lcom/b/a/ai;->p:Ljavax/net/ssl/HostnameVerifier;

    .line 248
    iget-object v0, p1, Lcom/b/a/ak;->o:Lcom/b/a/i;

    iget-object v1, p0, Lcom/b/a/ai;->o:Lcom/b/a/a/h/b;

    invoke-virtual {v0, v1}, Lcom/b/a/i;->a(Lcom/b/a/a/h/b;)Lcom/b/a/i;

    move-result-object v0

    iput-object v0, p0, Lcom/b/a/ai;->q:Lcom/b/a/i;

    .line 250
    iget-object v0, p1, Lcom/b/a/ak;->p:Lcom/b/a/b;

    iput-object v0, p0, Lcom/b/a/ai;->r:Lcom/b/a/b;

    .line 251
    iget-object v0, p1, Lcom/b/a/ak;->q:Lcom/b/a/b;

    iput-object v0, p0, Lcom/b/a/ai;->s:Lcom/b/a/b;

    .line 252
    iget-object v0, p1, Lcom/b/a/ak;->r:Lcom/b/a/n;

    iput-object v0, p0, Lcom/b/a/ai;->t:Lcom/b/a/n;

    .line 253
    iget-object v0, p1, Lcom/b/a/ak;->s:Lcom/b/a/v;

    iput-object v0, p0, Lcom/b/a/ai;->u:Lcom/b/a/v;

    .line 254
    iget-boolean v0, p1, Lcom/b/a/ak;->t:Z

    iput-boolean v0, p0, Lcom/b/a/ai;->v:Z

    .line 255
    iget-boolean v0, p1, Lcom/b/a/ak;->u:Z

    iput-boolean v0, p0, Lcom/b/a/ai;->w:Z

    .line 256
    iget-boolean v0, p1, Lcom/b/a/ak;->v:Z

    iput-boolean v0, p0, Lcom/b/a/ai;->x:Z

    .line 257
    iget v0, p1, Lcom/b/a/ak;->w:I

    iput v0, p0, Lcom/b/a/ai;->y:I

    .line 258
    iget v0, p1, Lcom/b/a/ak;->x:I

    iput v0, p0, Lcom/b/a/ai;->z:I

    .line 259
    iget v0, p1, Lcom/b/a/ak;->y:I

    iput v0, p0, Lcom/b/a/ai;->A:I

    .line 260
    iget v0, p1, Lcom/b/a/ak;->z:I

    iput v0, p0, Lcom/b/a/ai;->B:I

    .line 261
    return-void

    .line 242
    :cond_4
    invoke-static {}, Lcom/b/a/ai;->t()Ljavax/net/ssl/X509TrustManager;

    move-result-object v0

    .line 243
    invoke-static {v0}, Lcom/b/a/ai;->a(Ljavax/net/ssl/X509TrustManager;)Ljavax/net/ssl/SSLSocketFactory;

    move-result-object v1

    iput-object v1, p0, Lcom/b/a/ai;->n:Ljavax/net/ssl/SSLSocketFactory;

    .line 2041
    invoke-static {}, Lcom/b/a/a/g/h;->b()Lcom/b/a/a/g/h;

    move-result-object v1

    invoke-virtual {v1, v0}, Lcom/b/a/a/g/h;->a(Ljavax/net/ssl/X509TrustManager;)Lcom/b/a/a/h/b;

    move-result-object v0

    .line 244
    iput-object v0, p0, Lcom/b/a/ai;->o:Lcom/b/a/a/h/b;

    goto :goto_2
.end method

.method private static a(Ljavax/net/ssl/X509TrustManager;)Ljavax/net/ssl/SSLSocketFactory;
    .locals 4

    .prologue
    .line 281
    :try_start_0
    const-string v0, "TLS"

    invoke-static {v0}, Ljavax/net/ssl/SSLContext;->getInstance(Ljava/lang/String;)Ljavax/net/ssl/SSLContext;

    move-result-object v0

    .line 282
    const/4 v1, 0x0

    const/4 v2, 0x1

    new-array v2, v2, [Ljavax/net/ssl/TrustManager;

    const/4 v3, 0x0

    aput-object p0, v2, v3

    const/4 v3, 0x0

    invoke-virtual {v0, v1, v2, v3}, Ljavax/net/ssl/SSLContext;->init([Ljavax/net/ssl/KeyManager;[Ljavax/net/ssl/TrustManager;Ljava/security/SecureRandom;)V

    .line 283
    invoke-virtual {v0}, Ljavax/net/ssl/SSLContext;->getSocketFactory()Ljavax/net/ssl/SSLSocketFactory;
    :try_end_0
    .catch Ljava/security/GeneralSecurityException; {:try_start_0 .. :try_end_0} :catch_0

    move-result-object v0

    return-object v0

    .line 285
    :catch_0
    move-exception v0

    new-instance v0, Ljava/lang/AssertionError;

    invoke-direct {v0}, Ljava/lang/AssertionError;-><init>()V

    throw v0
.end method

.method private static t()Ljavax/net/ssl/X509TrustManager;
    .locals 4

    .prologue
    .line 266
    :try_start_0
    invoke-static {}, Ljavax/net/ssl/TrustManagerFactory;->getDefaultAlgorithm()Ljava/lang/String;

    move-result-object v0

    .line 265
    invoke-static {v0}, Ljavax/net/ssl/TrustManagerFactory;->getInstance(Ljava/lang/String;)Ljavax/net/ssl/TrustManagerFactory;

    move-result-object v0

    .line 267
    const/4 v1, 0x0

    invoke-virtual {v0, v1}, Ljavax/net/ssl/TrustManagerFactory;->init(Ljava/security/KeyStore;)V

    .line 268
    invoke-virtual {v0}, Ljavax/net/ssl/TrustManagerFactory;->getTrustManagers()[Ljavax/net/ssl/TrustManager;

    move-result-object v0

    .line 269
    array-length v1, v0

    const/4 v2, 0x1

    if-ne v1, v2, :cond_0

    const/4 v1, 0x0

    aget-object v1, v0, v1

    instance-of v1, v1, Ljavax/net/ssl/X509TrustManager;

    if-nez v1, :cond_1

    .line 270
    :cond_0
    new-instance v1, Ljava/lang/IllegalStateException;

    new-instance v2, Ljava/lang/StringBuilder;

    const-string v3, "Unexpected default trust managers:"

    invoke-direct {v2, v3}, Ljava/lang/StringBuilder;-><init>(Ljava/lang/String;)V

    .line 271
    invoke-static {v0}, Ljava/util/Arrays;->toString([Ljava/lang/Object;)Ljava/lang/String;

    move-result-object v0

    invoke-virtual {v2, v0}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-virtual {v0}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v0

    invoke-direct {v1, v0}, Ljava/lang/IllegalStateException;-><init>(Ljava/lang/String;)V

    throw v1
    :try_end_0
    .catch Ljava/security/GeneralSecurityException; {:try_start_0 .. :try_end_0} :catch_0

    .line 275
    :catch_0
    move-exception v0

    new-instance v0, Ljava/lang/AssertionError;

    invoke-direct {v0}, Ljava/lang/AssertionError;-><init>()V

    throw v0

    .line 273
    :cond_1
    const/4 v1, 0x0

    :try_start_1
    aget-object v0, v0, v1

    check-cast v0, Ljavax/net/ssl/X509TrustManager;
    :try_end_1
    .catch Ljava/security/GeneralSecurityException; {:try_start_1 .. :try_end_1} :catch_0

    return-object v0
.end method


# virtual methods
.method public final a()I
    .locals 1

    .prologue
    .line 291
    iget v0, p0, Lcom/b/a/ai;->y:I

    return v0
.end method

.method public final a(Lcom/b/a/ao;)Lcom/b/a/g;
    .locals 2

    .prologue
    .line 407
    new-instance v0, Lcom/b/a/am;

    const/4 v1, 0x0

    invoke-direct {v0, p0, p1, v1}, Lcom/b/a/am;-><init>(Lcom/b/a/ai;Lcom/b/a/ao;Z)V

    return-object v0
.end method

.method public final b()I
    .locals 1

    .prologue
    .line 296
    iget v0, p0, Lcom/b/a/ai;->z:I

    return v0
.end method

.method public final c()I
    .locals 1

    .prologue
    .line 301
    iget v0, p0, Lcom/b/a/ai;->A:I

    return v0
.end method

.method public final d()Ljava/net/Proxy;
    .locals 1

    .prologue
    .line 310
    iget-object v0, p0, Lcom/b/a/ai;->d:Ljava/net/Proxy;

    return-object v0
.end method

.method public final e()Ljava/net/ProxySelector;
    .locals 1

    .prologue
    .line 314
    iget-object v0, p0, Lcom/b/a/ai;->i:Ljava/net/ProxySelector;

    return-object v0
.end method

.method public final f()Lcom/b/a/s;
    .locals 1

    .prologue
    .line 318
    iget-object v0, p0, Lcom/b/a/ai;->j:Lcom/b/a/s;

    return-object v0
.end method

.method public final g()Lcom/b/a/v;
    .locals 1

    .prologue
    .line 330
    iget-object v0, p0, Lcom/b/a/ai;->u:Lcom/b/a/v;

    return-object v0
.end method

.method public final h()Ljavax/net/SocketFactory;
    .locals 1

    .prologue
    .line 334
    iget-object v0, p0, Lcom/b/a/ai;->m:Ljavax/net/SocketFactory;

    return-object v0
.end method

.method public final i()Ljavax/net/ssl/SSLSocketFactory;
    .locals 1

    .prologue
    .line 338
    iget-object v0, p0, Lcom/b/a/ai;->n:Ljavax/net/ssl/SSLSocketFactory;

    return-object v0
.end method

.method public final j()Ljavax/net/ssl/HostnameVerifier;
    .locals 1

    .prologue
    .line 342
    iget-object v0, p0, Lcom/b/a/ai;->p:Ljavax/net/ssl/HostnameVerifier;

    return-object v0
.end method

.method public final k()Lcom/b/a/i;
    .locals 1

    .prologue
    .line 346
    iget-object v0, p0, Lcom/b/a/ai;->q:Lcom/b/a/i;

    return-object v0
.end method

.method public final l()Lcom/b/a/b;
    .locals 1

    .prologue
    .line 350
    iget-object v0, p0, Lcom/b/a/ai;->s:Lcom/b/a/b;

    return-object v0
.end method

.method public final m()Lcom/b/a/b;
    .locals 1

    .prologue
    .line 354
    iget-object v0, p0, Lcom/b/a/ai;->r:Lcom/b/a/b;

    return-object v0
.end method

.method public final n()Lcom/b/a/n;
    .locals 1

    .prologue
    .line 358
    iget-object v0, p0, Lcom/b/a/ai;->t:Lcom/b/a/n;

    return-object v0
.end method

.method public final o()Z
    .locals 1

    .prologue
    .line 362
    iget-boolean v0, p0, Lcom/b/a/ai;->v:Z

    return v0
.end method

.method public final p()Z
    .locals 1

    .prologue
    .line 366
    iget-boolean v0, p0, Lcom/b/a/ai;->w:Z

    return v0
.end method

.method public final q()Z
    .locals 1

    .prologue
    .line 370
    iget-boolean v0, p0, Lcom/b/a/ai;->x:Z

    return v0
.end method

.method public final r()Ljava/util/List;
    .locals 1
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "()",
            "Ljava/util/List",
            "<",
            "Lcom/b/a/al;",
            ">;"
        }
    .end annotation

    .prologue
    .line 378
    iget-object v0, p0, Lcom/b/a/ai;->e:Ljava/util/List;

    return-object v0
.end method

.method public final s()Ljava/util/List;
    .locals 1
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "()",
            "Ljava/util/List",
            "<",
            "Lcom/b/a/p;",
            ">;"
        }
    .end annotation

    .prologue
    .line 382
    iget-object v0, p0, Lcom/b/a/ai;->f:Ljava/util/List;

    return-object v0
.end method
