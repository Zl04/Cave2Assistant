.class public final Lcom/b/a/a/b/c;
.super Lcom/b/a/a/e/s;
.source "SourceFile"

# interfaces
.implements Lcom/b/a/m;


# instance fields
.field public a:Z

.field public b:I

.field public c:I

.field public final d:Ljava/util/List;
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "Ljava/util/List",
            "<",
            "Ljava/lang/ref/Reference",
            "<",
            "Lcom/b/a/a/b/g;",
            ">;>;"
        }
    .end annotation
.end field

.field public e:J

.field private final g:Lcom/b/a/n;

.field private final h:Lcom/b/a/aw;

.field private i:Ljava/net/Socket;

.field private j:Ljava/net/Socket;

.field private k:Lcom/b/a/z;

.field private l:Lcom/b/a/al;

.field private m:Lcom/b/a/a/e/j;

.field private n:Lcom/b/b/h;

.field private o:Lcom/b/b/g;


# direct methods
.method public constructor <init>(Lcom/b/a/n;Lcom/b/a/aw;)V
    .locals 2

    .prologue
    .line 108
    invoke-direct {p0}, Lcom/b/a/a/e/s;-><init>()V

    .line 100
    const/4 v0, 0x1

    iput v0, p0, Lcom/b/a/a/b/c;->c:I

    .line 103
    new-instance v0, Ljava/util/ArrayList;

    invoke-direct {v0}, Ljava/util/ArrayList;-><init>()V

    iput-object v0, p0, Lcom/b/a/a/b/c;->d:Ljava/util/List;

    .line 106
    const-wide v0, 0x7fffffffffffffffL

    iput-wide v0, p0, Lcom/b/a/a/b/c;->e:J

    .line 109
    iput-object p1, p0, Lcom/b/a/a/b/c;->g:Lcom/b/a/n;

    .line 110
    iput-object p2, p0, Lcom/b/a/a/b/c;->h:Lcom/b/a/aw;

    .line 111
    return-void
.end method

.method private a(II)V
    .locals 4

    .prologue
    .line 211
    iget-object v0, p0, Lcom/b/a/a/b/c;->h:Lcom/b/a/aw;

    invoke-virtual {v0}, Lcom/b/a/aw;->b()Ljava/net/Proxy;

    move-result-object v1

    .line 212
    iget-object v0, p0, Lcom/b/a/a/b/c;->h:Lcom/b/a/aw;

    invoke-virtual {v0}, Lcom/b/a/aw;->a()Lcom/b/a/a;

    move-result-object v0

    .line 214
    invoke-virtual {v1}, Ljava/net/Proxy;->type()Ljava/net/Proxy$Type;

    move-result-object v2

    sget-object v3, Ljava/net/Proxy$Type;->DIRECT:Ljava/net/Proxy$Type;

    if-eq v2, v3, :cond_0

    invoke-virtual {v1}, Ljava/net/Proxy;->type()Ljava/net/Proxy$Type;

    move-result-object v2

    sget-object v3, Ljava/net/Proxy$Type;->HTTP:Ljava/net/Proxy$Type;

    if-ne v2, v3, :cond_1

    .line 215
    :cond_0
    invoke-virtual {v0}, Lcom/b/a/a;->c()Ljavax/net/SocketFactory;

    move-result-object v0

    invoke-virtual {v0}, Ljavax/net/SocketFactory;->createSocket()Ljava/net/Socket;

    move-result-object v0

    :goto_0
    iput-object v0, p0, Lcom/b/a/a/b/c;->i:Ljava/net/Socket;

    .line 218
    iget-object v0, p0, Lcom/b/a/a/b/c;->i:Ljava/net/Socket;

    invoke-virtual {v0, p2}, Ljava/net/Socket;->setSoTimeout(I)V

    .line 220
    :try_start_0
    invoke-static {}, Lcom/b/a/a/g/h;->b()Lcom/b/a/a/g/h;

    move-result-object v0

    iget-object v1, p0, Lcom/b/a/a/b/c;->i:Ljava/net/Socket;

    iget-object v2, p0, Lcom/b/a/a/b/c;->h:Lcom/b/a/aw;

    invoke-virtual {v2}, Lcom/b/a/aw;->c()Ljava/net/InetSocketAddress;

    move-result-object v2

    invoke-virtual {v0, v1, v2, p1}, Lcom/b/a/a/g/h;->a(Ljava/net/Socket;Ljava/net/InetSocketAddress;I)V
    :try_end_0
    .catch Ljava/net/ConnectException; {:try_start_0 .. :try_end_0} :catch_0

    .line 226
    iget-object v0, p0, Lcom/b/a/a/b/c;->i:Ljava/net/Socket;

    invoke-static {v0}, Lcom/b/b/n;->b(Ljava/net/Socket;)Lcom/b/b/x;

    move-result-object v0

    invoke-static {v0}, Lcom/b/b/n;->a(Lcom/b/b/x;)Lcom/b/b/h;

    move-result-object v0

    iput-object v0, p0, Lcom/b/a/a/b/c;->n:Lcom/b/b/h;

    .line 227
    iget-object v0, p0, Lcom/b/a/a/b/c;->i:Ljava/net/Socket;

    invoke-static {v0}, Lcom/b/b/n;->a(Ljava/net/Socket;)Lcom/b/b/w;

    move-result-object v0

    invoke-static {v0}, Lcom/b/b/n;->a(Lcom/b/b/w;)Lcom/b/b/g;

    move-result-object v0

    iput-object v0, p0, Lcom/b/a/a/b/c;->o:Lcom/b/b/g;

    .line 228
    return-void

    .line 215
    :cond_1
    new-instance v0, Ljava/net/Socket;

    invoke-direct {v0, v1}, Ljava/net/Socket;-><init>(Ljava/net/Proxy;)V

    goto :goto_0

    .line 221
    :catch_0
    move-exception v0

    .line 222
    new-instance v1, Ljava/net/ConnectException;

    new-instance v2, Ljava/lang/StringBuilder;

    const-string v3, "Failed to connect to "

    invoke-direct {v2, v3}, Ljava/lang/StringBuilder;-><init>(Ljava/lang/String;)V

    iget-object v3, p0, Lcom/b/a/a/b/c;->h:Lcom/b/a/aw;

    invoke-virtual {v3}, Lcom/b/a/aw;->c()Ljava/net/InetSocketAddress;

    move-result-object v3

    invoke-virtual {v2, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/Object;)Ljava/lang/StringBuilder;

    move-result-object v2

    invoke-virtual {v2}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v2

    invoke-direct {v1, v2}, Ljava/net/ConnectException;-><init>(Ljava/lang/String;)V

    .line 223
    invoke-virtual {v1, v0}, Ljava/net/ConnectException;->initCause(Ljava/lang/Throwable;)Ljava/lang/Throwable;

    .line 224
    throw v1
.end method


# virtual methods
.method public final a(Lcom/b/a/ai;Lcom/b/a/a/b/g;)Lcom/b/a/a/c/c;
    .locals 4

    .prologue
    .line 385
    iget-object v0, p0, Lcom/b/a/a/b/c;->m:Lcom/b/a/a/e/j;

    if-eqz v0, :cond_0

    .line 386
    new-instance v0, Lcom/b/a/a/e/h;

    iget-object v1, p0, Lcom/b/a/a/b/c;->m:Lcom/b/a/a/e/j;

    invoke-direct {v0, p1, p2, v1}, Lcom/b/a/a/e/h;-><init>(Lcom/b/a/ai;Lcom/b/a/a/b/g;Lcom/b/a/a/e/j;)V

    .line 391
    :goto_0
    return-object v0

    .line 388
    :cond_0
    iget-object v0, p0, Lcom/b/a/a/b/c;->j:Ljava/net/Socket;

    invoke-virtual {p1}, Lcom/b/a/ai;->b()I

    move-result v1

    invoke-virtual {v0, v1}, Ljava/net/Socket;->setSoTimeout(I)V

    .line 389
    iget-object v0, p0, Lcom/b/a/a/b/c;->n:Lcom/b/b/h;

    invoke-interface {v0}, Lcom/b/b/h;->a()Lcom/b/b/y;

    move-result-object v0

    invoke-virtual {p1}, Lcom/b/a/ai;->b()I

    move-result v1

    int-to-long v2, v1

    sget-object v1, Ljava/util/concurrent/TimeUnit;->MILLISECONDS:Ljava/util/concurrent/TimeUnit;

    invoke-virtual {v0, v2, v3, v1}, Lcom/b/b/y;->a(JLjava/util/concurrent/TimeUnit;)Lcom/b/b/y;

    .line 390
    iget-object v0, p0, Lcom/b/a/a/b/c;->o:Lcom/b/b/g;

    invoke-interface {v0}, Lcom/b/b/g;->a()Lcom/b/b/y;

    move-result-object v0

    invoke-virtual {p1}, Lcom/b/a/ai;->c()I

    move-result v1

    int-to-long v2, v1

    sget-object v1, Ljava/util/concurrent/TimeUnit;->MILLISECONDS:Ljava/util/concurrent/TimeUnit;

    invoke-virtual {v0, v2, v3, v1}, Lcom/b/b/y;->a(JLjava/util/concurrent/TimeUnit;)Lcom/b/b/y;

    .line 391
    new-instance v0, Lcom/b/a/a/d/a;

    iget-object v1, p0, Lcom/b/a/a/b/c;->n:Lcom/b/b/h;

    iget-object v2, p0, Lcom/b/a/a/b/c;->o:Lcom/b/b/g;

    invoke-direct {v0, p1, p2, v1, v2}, Lcom/b/a/a/d/a;-><init>(Lcom/b/a/ai;Lcom/b/a/a/b/g;Lcom/b/b/h;Lcom/b/b/g;)V

    goto :goto_0
.end method

.method public final a()Lcom/b/a/aw;
    .locals 1

    .prologue
    .line 404
    iget-object v0, p0, Lcom/b/a/a/b/c;->h:Lcom/b/a/aw;

    return-object v0
.end method

.method public final a(IIIZ)V
    .locals 11

    .prologue
    const/4 v2, 0x0

    .line 123
    iget-object v0, p0, Lcom/b/a/a/b/c;->l:Lcom/b/a/al;

    if-eqz v0, :cond_0

    new-instance v0, Ljava/lang/IllegalStateException;

    const-string v1, "already connected"

    invoke-direct {v0, v1}, Ljava/lang/IllegalStateException;-><init>(Ljava/lang/String;)V

    throw v0

    .line 126
    :cond_0
    iget-object v0, p0, Lcom/b/a/a/b/c;->h:Lcom/b/a/aw;

    invoke-virtual {v0}, Lcom/b/a/aw;->a()Lcom/b/a/a;

    move-result-object v0

    invoke-virtual {v0}, Lcom/b/a/a;->f()Ljava/util/List;

    move-result-object v0

    .line 127
    new-instance v4, Lcom/b/a/a/b/b;

    invoke-direct {v4, v0}, Lcom/b/a/a/b/b;-><init>(Ljava/util/List;)V

    .line 129
    iget-object v1, p0, Lcom/b/a/a/b/c;->h:Lcom/b/a/aw;

    invoke-virtual {v1}, Lcom/b/a/aw;->a()Lcom/b/a/a;

    move-result-object v1

    invoke-virtual {v1}, Lcom/b/a/a;->i()Ljavax/net/ssl/SSLSocketFactory;

    move-result-object v1

    if-nez v1, :cond_13

    .line 130
    sget-object v1, Lcom/b/a/p;->c:Lcom/b/a/p;

    invoke-interface {v0, v1}, Ljava/util/List;->contains(Ljava/lang/Object;)Z

    move-result v0

    if-nez v0, :cond_1

    .line 131
    new-instance v0, Lcom/b/a/a/b/e;

    new-instance v1, Ljava/net/UnknownServiceException;

    const-string v2, "CLEARTEXT communication not enabled for client"

    invoke-direct {v1, v2}, Ljava/net/UnknownServiceException;-><init>(Ljava/lang/String;)V

    invoke-direct {v0, v1}, Lcom/b/a/a/b/e;-><init>(Ljava/io/IOException;)V

    throw v0

    .line 134
    :cond_1
    iget-object v0, p0, Lcom/b/a/a/b/c;->h:Lcom/b/a/aw;

    invoke-virtual {v0}, Lcom/b/a/aw;->a()Lcom/b/a/a;

    move-result-object v0

    invoke-virtual {v0}, Lcom/b/a/a;->a()Lcom/b/a/ac;

    move-result-object v0

    invoke-virtual {v0}, Lcom/b/a/ac;->f()Ljava/lang/String;

    move-result-object v0

    .line 135
    invoke-static {}, Lcom/b/a/a/g/h;->b()Lcom/b/a/a/g/h;

    move-result-object v1

    invoke-virtual {v1, v0}, Lcom/b/a/a/g/h;->b(Ljava/lang/String;)Z

    move-result v1

    if-nez v1, :cond_13

    .line 136
    new-instance v1, Lcom/b/a/a/b/e;

    new-instance v2, Ljava/net/UnknownServiceException;

    new-instance v3, Ljava/lang/StringBuilder;

    const-string v4, "CLEARTEXT communication to "

    invoke-direct {v3, v4}, Ljava/lang/StringBuilder;-><init>(Ljava/lang/String;)V

    invoke-virtual {v3, v0}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    const-string v3, " not permitted by network security policy"

    invoke-virtual {v0, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-virtual {v0}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v0

    invoke-direct {v2, v0}, Ljava/net/UnknownServiceException;-><init>(Ljava/lang/String;)V

    invoke-direct {v1, v2}, Lcom/b/a/a/b/e;-><init>(Ljava/io/IOException;)V

    throw v1

    :cond_2
    move-object v3, v1

    .line 143
    :goto_0
    :try_start_0
    iget-object v0, p0, Lcom/b/a/a/b/c;->h:Lcom/b/a/aw;

    invoke-virtual {v0}, Lcom/b/a/aw;->d()Z

    move-result v0

    if-eqz v0, :cond_6

    .line 1368
    new-instance v0, Lcom/b/a/ap;

    invoke-direct {v0}, Lcom/b/a/ap;-><init>()V

    iget-object v1, p0, Lcom/b/a/a/b/c;->h:Lcom/b/a/aw;

    .line 1369
    invoke-virtual {v1}, Lcom/b/a/aw;->a()Lcom/b/a/a;

    move-result-object v1

    invoke-virtual {v1}, Lcom/b/a/a;->a()Lcom/b/a/ac;

    move-result-object v1

    invoke-virtual {v0, v1}, Lcom/b/a/ap;->a(Lcom/b/a/ac;)Lcom/b/a/ap;

    move-result-object v0

    const-string v1, "Host"

    iget-object v5, p0, Lcom/b/a/a/b/c;->h:Lcom/b/a/aw;

    .line 1370
    invoke-virtual {v5}, Lcom/b/a/aw;->a()Lcom/b/a/a;

    move-result-object v5

    invoke-virtual {v5}, Lcom/b/a/a;->a()Lcom/b/a/ac;

    move-result-object v5

    const/4 v6, 0x1

    invoke-static {v5, v6}, Lcom/b/a/a/c;->a(Lcom/b/a/ac;Z)Ljava/lang/String;

    move-result-object v5

    invoke-virtual {v0, v1, v5}, Lcom/b/a/ap;->a(Ljava/lang/String;Ljava/lang/String;)Lcom/b/a/ap;

    move-result-object v0

    const-string v1, "Proxy-Connection"

    const-string v5, "Keep-Alive"

    .line 1371
    invoke-virtual {v0, v1, v5}, Lcom/b/a/ap;->a(Ljava/lang/String;Ljava/lang/String;)Lcom/b/a/ap;

    move-result-object v0

    const-string v1, "User-Agent"

    .line 2007
    const-string v5, "okhttp/3.6.0"

    .line 1372
    invoke-virtual {v0, v1, v5}, Lcom/b/a/ap;->a(Ljava/lang/String;Ljava/lang/String;)Lcom/b/a/ap;

    move-result-object v0

    .line 1373
    invoke-virtual {v0}, Lcom/b/a/ap;->a()Lcom/b/a/ao;

    move-result-object v0

    .line 1187
    invoke-virtual {v0}, Lcom/b/a/ao;->a()Lcom/b/a/ac;

    move-result-object v1

    .line 1195
    invoke-direct {p0, p1, p2}, Lcom/b/a/a/b/c;->a(II)V

    .line 2315
    new-instance v5, Ljava/lang/StringBuilder;

    const-string v6, "CONNECT "

    invoke-direct {v5, v6}, Ljava/lang/StringBuilder;-><init>(Ljava/lang/String;)V

    const/4 v6, 0x1

    invoke-static {v1, v6}, Lcom/b/a/a/c;->a(Lcom/b/a/ac;Z)Ljava/lang/String;

    move-result-object v1

    invoke-virtual {v5, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    const-string v5, " HTTP/1.1"

    invoke-virtual {v1, v5}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v1

    .line 2317
    new-instance v5, Lcom/b/a/a/d/a;

    const/4 v6, 0x0

    const/4 v7, 0x0

    iget-object v8, p0, Lcom/b/a/a/b/c;->n:Lcom/b/b/h;

    iget-object v9, p0, Lcom/b/a/a/b/c;->o:Lcom/b/b/g;

    invoke-direct {v5, v6, v7, v8, v9}, Lcom/b/a/a/d/a;-><init>(Lcom/b/a/ai;Lcom/b/a/a/b/g;Lcom/b/b/h;Lcom/b/b/g;)V

    .line 2318
    iget-object v6, p0, Lcom/b/a/a/b/c;->n:Lcom/b/b/h;

    invoke-interface {v6}, Lcom/b/b/h;->a()Lcom/b/b/y;

    move-result-object v6

    int-to-long v8, p2

    sget-object v7, Ljava/util/concurrent/TimeUnit;->MILLISECONDS:Ljava/util/concurrent/TimeUnit;

    invoke-virtual {v6, v8, v9, v7}, Lcom/b/b/y;->a(JLjava/util/concurrent/TimeUnit;)Lcom/b/b/y;

    .line 2319
    iget-object v6, p0, Lcom/b/a/a/b/c;->o:Lcom/b/b/g;

    invoke-interface {v6}, Lcom/b/b/g;->a()Lcom/b/b/y;

    move-result-object v6

    int-to-long v8, p3

    sget-object v7, Ljava/util/concurrent/TimeUnit;->MILLISECONDS:Ljava/util/concurrent/TimeUnit;

    invoke-virtual {v6, v8, v9, v7}, Lcom/b/b/y;->a(JLjava/util/concurrent/TimeUnit;)Lcom/b/b/y;

    .line 2320
    invoke-virtual {v0}, Lcom/b/a/ao;->c()Lcom/b/a/aa;

    move-result-object v6

    invoke-virtual {v5, v6, v1}, Lcom/b/a/a/d/a;->a(Lcom/b/a/aa;Ljava/lang/String;)V

    .line 2321
    invoke-virtual {v5}, Lcom/b/a/a/d/a;->b()V

    .line 2322
    const/4 v1, 0x0

    invoke-virtual {v5, v1}, Lcom/b/a/a/d/a;->a(Z)Lcom/b/a/at;

    move-result-object v1

    .line 2323
    invoke-virtual {v1, v0}, Lcom/b/a/at;->a(Lcom/b/a/ao;)Lcom/b/a/at;

    move-result-object v0

    .line 2324
    invoke-virtual {v0}, Lcom/b/a/at;->a()Lcom/b/a/as;

    move-result-object v6

    .line 2327
    invoke-static {v6}, Lcom/b/a/a/c/f;->a(Lcom/b/a/as;)J

    move-result-wide v0

    .line 2328
    const-wide/16 v8, -0x1

    cmp-long v7, v0, v8

    if-nez v7, :cond_3

    .line 2329
    const-wide/16 v0, 0x0

    .line 2331
    :cond_3
    invoke-virtual {v5, v0, v1}, Lcom/b/a/a/d/a;->a(J)Lcom/b/b/x;

    move-result-object v0

    .line 2332
    const v1, 0x7fffffff

    sget-object v5, Ljava/util/concurrent/TimeUnit;->MILLISECONDS:Ljava/util/concurrent/TimeUnit;

    invoke-static {v0, v1, v5}, Lcom/b/a/a/c;->a(Lcom/b/b/x;ILjava/util/concurrent/TimeUnit;)Z

    .line 2333
    invoke-interface {v0}, Lcom/b/b/x;->close()V

    .line 2335
    invoke-virtual {v6}, Lcom/b/a/as;->b()I

    move-result v0

    sparse-switch v0, :sswitch_data_0

    .line 2356
    new-instance v0, Ljava/io/IOException;

    new-instance v1, Ljava/lang/StringBuilder;

    const-string v5, "Unexpected response code for CONNECT: "

    invoke-direct {v1, v5}, Ljava/lang/StringBuilder;-><init>(Ljava/lang/String;)V

    .line 2357
    invoke-virtual {v6}, Lcom/b/a/as;->b()I

    move-result v5

    invoke-virtual {v1, v5}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v1

    invoke-direct {v0, v1}, Ljava/io/IOException;-><init>(Ljava/lang/String;)V

    throw v0
    :try_end_0
    .catch Ljava/io/IOException; {:try_start_0 .. :try_end_0} :catch_0

    .line 150
    :catch_0
    move-exception v0

    .line 151
    iget-object v1, p0, Lcom/b/a/a/b/c;->j:Ljava/net/Socket;

    invoke-static {v1}, Lcom/b/a/a/c;->a(Ljava/net/Socket;)V

    .line 152
    iget-object v1, p0, Lcom/b/a/a/b/c;->i:Ljava/net/Socket;

    invoke-static {v1}, Lcom/b/a/a/c;->a(Ljava/net/Socket;)V

    .line 153
    iput-object v2, p0, Lcom/b/a/a/b/c;->j:Ljava/net/Socket;

    .line 154
    iput-object v2, p0, Lcom/b/a/a/b/c;->i:Ljava/net/Socket;

    .line 155
    iput-object v2, p0, Lcom/b/a/a/b/c;->n:Lcom/b/b/h;

    .line 156
    iput-object v2, p0, Lcom/b/a/a/b/c;->o:Lcom/b/b/g;

    .line 157
    iput-object v2, p0, Lcom/b/a/a/b/c;->k:Lcom/b/a/z;

    .line 158
    iput-object v2, p0, Lcom/b/a/a/b/c;->l:Lcom/b/a/al;

    .line 159
    iput-object v2, p0, Lcom/b/a/a/b/c;->m:Lcom/b/a/a/e/j;

    .line 161
    if-nez v3, :cond_12

    .line 162
    new-instance v1, Lcom/b/a/a/b/e;

    invoke-direct {v1, v0}, Lcom/b/a/a/b/e;-><init>(Ljava/io/IOException;)V

    .line 167
    :goto_1
    if-eqz p4, :cond_4

    invoke-virtual {v4, v0}, Lcom/b/a/a/b/b;->a(Ljava/io/IOException;)Z

    move-result v0

    if-nez v0, :cond_2

    .line 168
    :cond_4
    throw v1

    .line 2341
    :sswitch_0
    :try_start_1
    iget-object v0, p0, Lcom/b/a/a/b/c;->n:Lcom/b/b/h;

    invoke-interface {v0}, Lcom/b/b/h;->c()Lcom/b/b/f;

    move-result-object v0

    invoke-virtual {v0}, Lcom/b/b/f;->d()Z

    move-result v0

    if-eqz v0, :cond_5

    iget-object v0, p0, Lcom/b/a/a/b/c;->o:Lcom/b/b/g;

    invoke-interface {v0}, Lcom/b/b/g;->c()Lcom/b/b/f;

    move-result-object v0

    invoke-virtual {v0}, Lcom/b/b/f;->d()Z

    move-result v0

    if-nez v0, :cond_7

    .line 2342
    :cond_5
    new-instance v0, Ljava/io/IOException;

    const-string v1, "TLS tunnel buffered too many bytes!"

    invoke-direct {v0, v1}, Ljava/io/IOException;-><init>(Ljava/lang/String;)V

    throw v0

    .line 2347
    :sswitch_1
    iget-object v0, p0, Lcom/b/a/a/b/c;->h:Lcom/b/a/aw;

    invoke-virtual {v0}, Lcom/b/a/aw;->a()Lcom/b/a/a;

    move-result-object v0

    invoke-virtual {v0}, Lcom/b/a/a;->d()Lcom/b/a/b;

    move-result-object v0

    invoke-interface {v0}, Lcom/b/a/b;->a()Lcom/b/a/ao;

    .line 2348
    new-instance v0, Ljava/io/IOException;

    const-string v1, "Failed to authenticate with proxy"

    invoke-direct {v0, v1}, Ljava/io/IOException;-><init>(Ljava/lang/String;)V

    throw v0

    .line 146
    :cond_6
    invoke-direct {p0, p1, p2}, Lcom/b/a/a/b/c;->a(II)V

    .line 3231
    :cond_7
    iget-object v0, p0, Lcom/b/a/a/b/c;->h:Lcom/b/a/aw;

    invoke-virtual {v0}, Lcom/b/a/aw;->a()Lcom/b/a/a;

    move-result-object v0

    invoke-virtual {v0}, Lcom/b/a/a;->i()Ljavax/net/ssl/SSLSocketFactory;

    move-result-object v0

    if-nez v0, :cond_a

    .line 3232
    sget-object v0, Lcom/b/a/al;->b:Lcom/b/a/al;

    iput-object v0, p0, Lcom/b/a/a/b/c;->l:Lcom/b/a/al;

    .line 3233
    iget-object v0, p0, Lcom/b/a/a/b/c;->i:Ljava/net/Socket;

    iput-object v0, p0, Lcom/b/a/a/b/c;->j:Ljava/net/Socket;
    :try_end_1
    .catch Ljava/io/IOException; {:try_start_1 .. :try_end_1} :catch_0

    .line 173
    :cond_8
    :goto_2
    iget-object v0, p0, Lcom/b/a/a/b/c;->m:Lcom/b/a/a/e/j;

    if-eqz v0, :cond_9

    .line 174
    iget-object v1, p0, Lcom/b/a/a/b/c;->g:Lcom/b/a/n;

    monitor-enter v1

    .line 175
    :try_start_2
    iget-object v0, p0, Lcom/b/a/a/b/c;->m:Lcom/b/a/a/e/j;

    invoke-virtual {v0}, Lcom/b/a/a/e/j;->a()I

    move-result v0

    iput v0, p0, Lcom/b/a/a/b/c;->c:I

    .line 176
    monitor-exit v1
    :try_end_2
    .catchall {:try_start_2 .. :try_end_2} :catchall_1

    .line 178
    :cond_9
    return-void

    .line 3250
    :cond_a
    :try_start_3
    iget-object v0, p0, Lcom/b/a/a/b/c;->h:Lcom/b/a/aw;

    invoke-virtual {v0}, Lcom/b/a/aw;->a()Lcom/b/a/a;

    move-result-object v5

    .line 3251
    invoke-virtual {v5}, Lcom/b/a/a;->i()Ljavax/net/ssl/SSLSocketFactory;
    :try_end_3
    .catch Ljava/io/IOException; {:try_start_3 .. :try_end_3} :catch_0

    move-result-object v0

    .line 3256
    :try_start_4
    iget-object v1, p0, Lcom/b/a/a/b/c;->i:Ljava/net/Socket;

    .line 3257
    invoke-virtual {v5}, Lcom/b/a/a;->a()Lcom/b/a/ac;

    move-result-object v6

    invoke-virtual {v6}, Lcom/b/a/ac;->f()Ljava/lang/String;

    move-result-object v6

    invoke-virtual {v5}, Lcom/b/a/a;->a()Lcom/b/a/ac;

    move-result-object v7

    invoke-virtual {v7}, Lcom/b/a/ac;->g()I

    move-result v7

    const/4 v8, 0x1

    .line 3256
    invoke-virtual {v0, v1, v6, v7, v8}, Ljavax/net/ssl/SSLSocketFactory;->createSocket(Ljava/net/Socket;Ljava/lang/String;IZ)Ljava/net/Socket;

    move-result-object v0

    check-cast v0, Ljavax/net/ssl/SSLSocket;
    :try_end_4
    .catch Ljava/lang/AssertionError; {:try_start_4 .. :try_end_4} :catch_2
    .catchall {:try_start_4 .. :try_end_4} :catchall_2

    .line 3260
    :try_start_5
    invoke-virtual {v4, v0}, Lcom/b/a/a/b/b;->a(Ljavax/net/ssl/SSLSocket;)Lcom/b/a/p;

    move-result-object v1

    .line 3261
    invoke-virtual {v1}, Lcom/b/a/p;->a()Z

    move-result v6

    if-eqz v6, :cond_b

    .line 3262
    invoke-static {}, Lcom/b/a/a/g/h;->b()Lcom/b/a/a/g/h;

    move-result-object v6

    .line 3263
    invoke-virtual {v5}, Lcom/b/a/a;->a()Lcom/b/a/ac;

    move-result-object v7

    invoke-virtual {v7}, Lcom/b/a/ac;->f()Ljava/lang/String;

    move-result-object v7

    invoke-virtual {v5}, Lcom/b/a/a;->e()Ljava/util/List;

    move-result-object v8

    .line 3262
    invoke-virtual {v6, v0, v7, v8}, Lcom/b/a/a/g/h;->a(Ljavax/net/ssl/SSLSocket;Ljava/lang/String;Ljava/util/List;)V

    .line 3267
    :cond_b
    invoke-virtual {v0}, Ljavax/net/ssl/SSLSocket;->startHandshake()V

    .line 3268
    invoke-virtual {v0}, Ljavax/net/ssl/SSLSocket;->getSession()Ljavax/net/ssl/SSLSession;

    move-result-object v6

    invoke-static {v6}, Lcom/b/a/z;->a(Ljavax/net/ssl/SSLSession;)Lcom/b/a/z;

    move-result-object v6

    .line 3271
    invoke-virtual {v5}, Lcom/b/a/a;->j()Ljavax/net/ssl/HostnameVerifier;

    move-result-object v7

    invoke-virtual {v5}, Lcom/b/a/a;->a()Lcom/b/a/ac;

    move-result-object v8

    invoke-virtual {v8}, Lcom/b/a/ac;->f()Ljava/lang/String;

    move-result-object v8

    invoke-virtual {v0}, Ljavax/net/ssl/SSLSocket;->getSession()Ljavax/net/ssl/SSLSession;

    move-result-object v9

    invoke-interface {v7, v8, v9}, Ljavax/net/ssl/HostnameVerifier;->verify(Ljava/lang/String;Ljavax/net/ssl/SSLSession;)Z

    move-result v7

    if-nez v7, :cond_d

    .line 3272
    invoke-virtual {v6}, Lcom/b/a/z;->b()Ljava/util/List;

    move-result-object v1

    const/4 v6, 0x0

    invoke-interface {v1, v6}, Ljava/util/List;->get(I)Ljava/lang/Object;

    move-result-object v1

    check-cast v1, Ljava/security/cert/X509Certificate;

    .line 3273
    new-instance v6, Ljavax/net/ssl/SSLPeerUnverifiedException;

    new-instance v7, Ljava/lang/StringBuilder;

    const-string v8, "Hostname "

    invoke-direct {v7, v8}, Ljava/lang/StringBuilder;-><init>(Ljava/lang/String;)V

    invoke-virtual {v5}, Lcom/b/a/a;->a()Lcom/b/a/ac;

    move-result-object v5

    invoke-virtual {v5}, Lcom/b/a/ac;->f()Ljava/lang/String;

    move-result-object v5

    invoke-virtual {v7, v5}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v5

    const-string v7, " not verified:\n    certificate: "

    invoke-virtual {v5, v7}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v5

    .line 3274
    invoke-static {v1}, Lcom/b/a/i;->a(Ljava/security/cert/Certificate;)Ljava/lang/String;

    move-result-object v7

    invoke-virtual {v5, v7}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v5

    const-string v7, "\n    DN: "

    invoke-virtual {v5, v7}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v5

    .line 3275
    invoke-virtual {v1}, Ljava/security/cert/X509Certificate;->getSubjectDN()Ljava/security/Principal;

    move-result-object v7

    invoke-interface {v7}, Ljava/security/Principal;->getName()Ljava/lang/String;

    move-result-object v7

    invoke-virtual {v5, v7}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v5

    const-string v7, "\n    subjectAltNames: "

    invoke-virtual {v5, v7}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v5

    .line 3276
    invoke-static {v1}, Lcom/b/a/a/h/d;->a(Ljava/security/cert/X509Certificate;)Ljava/util/List;

    move-result-object v1

    invoke-virtual {v5, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/Object;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v1

    invoke-direct {v6, v1}, Ljavax/net/ssl/SSLPeerUnverifiedException;-><init>(Ljava/lang/String;)V

    throw v6
    :try_end_5
    .catch Ljava/lang/AssertionError; {:try_start_5 .. :try_end_5} :catch_1
    .catchall {:try_start_5 .. :try_end_5} :catchall_3

    .line 3295
    :catch_1
    move-exception v1

    move-object v10, v1

    move-object v1, v0

    move-object v0, v10

    .line 3296
    :goto_3
    :try_start_6
    invoke-static {v0}, Lcom/b/a/a/c;->a(Ljava/lang/AssertionError;)Z

    move-result v5

    if-eqz v5, :cond_11

    new-instance v5, Ljava/io/IOException;

    invoke-direct {v5, v0}, Ljava/io/IOException;-><init>(Ljava/lang/Throwable;)V

    throw v5
    :try_end_6
    .catchall {:try_start_6 .. :try_end_6} :catchall_0

    .line 3299
    :catchall_0
    move-exception v0

    :goto_4
    if-eqz v1, :cond_c

    .line 3300
    :try_start_7
    invoke-static {}, Lcom/b/a/a/g/h;->b()Lcom/b/a/a/g/h;

    move-result-object v5

    invoke-virtual {v5, v1}, Lcom/b/a/a/g/h;->b(Ljavax/net/ssl/SSLSocket;)V

    .line 3303
    :cond_c
    invoke-static {v1}, Lcom/b/a/a/c;->a(Ljava/net/Socket;)V

    throw v0
    :try_end_7
    .catch Ljava/io/IOException; {:try_start_7 .. :try_end_7} :catch_0

    .line 3280
    :cond_d
    :try_start_8
    invoke-virtual {v5}, Lcom/b/a/a;->k()Lcom/b/a/i;

    move-result-object v7

    invoke-virtual {v5}, Lcom/b/a/a;->a()Lcom/b/a/ac;

    move-result-object v5

    invoke-virtual {v5}, Lcom/b/a/ac;->f()Ljava/lang/String;

    move-result-object v5

    .line 3281
    invoke-virtual {v6}, Lcom/b/a/z;->b()Ljava/util/List;

    move-result-object v8

    .line 3280
    invoke-virtual {v7, v5, v8}, Lcom/b/a/i;->a(Ljava/lang/String;Ljava/util/List;)V

    .line 3284
    invoke-virtual {v1}, Lcom/b/a/p;->a()Z

    move-result v1

    if-eqz v1, :cond_f

    .line 3285
    invoke-static {}, Lcom/b/a/a/g/h;->b()Lcom/b/a/a/g/h;

    move-result-object v1

    invoke-virtual {v1, v0}, Lcom/b/a/a/g/h;->a(Ljavax/net/ssl/SSLSocket;)Ljava/lang/String;

    move-result-object v1

    .line 3287
    :goto_5
    iput-object v0, p0, Lcom/b/a/a/b/c;->j:Ljava/net/Socket;

    .line 3288
    iget-object v5, p0, Lcom/b/a/a/b/c;->j:Ljava/net/Socket;

    invoke-static {v5}, Lcom/b/b/n;->b(Ljava/net/Socket;)Lcom/b/b/x;

    move-result-object v5

    invoke-static {v5}, Lcom/b/b/n;->a(Lcom/b/b/x;)Lcom/b/b/h;

    move-result-object v5

    iput-object v5, p0, Lcom/b/a/a/b/c;->n:Lcom/b/b/h;

    .line 3289
    iget-object v5, p0, Lcom/b/a/a/b/c;->j:Ljava/net/Socket;

    invoke-static {v5}, Lcom/b/b/n;->a(Ljava/net/Socket;)Lcom/b/b/w;

    move-result-object v5

    invoke-static {v5}, Lcom/b/b/n;->a(Lcom/b/b/w;)Lcom/b/b/g;

    move-result-object v5

    iput-object v5, p0, Lcom/b/a/a/b/c;->o:Lcom/b/b/g;

    .line 3290
    iput-object v6, p0, Lcom/b/a/a/b/c;->k:Lcom/b/a/z;

    .line 3291
    if-eqz v1, :cond_10

    .line 3292
    invoke-static {v1}, Lcom/b/a/al;->a(Ljava/lang/String;)Lcom/b/a/al;

    move-result-object v1

    :goto_6
    iput-object v1, p0, Lcom/b/a/a/b/c;->l:Lcom/b/a/al;
    :try_end_8
    .catch Ljava/lang/AssertionError; {:try_start_8 .. :try_end_8} :catch_1
    .catchall {:try_start_8 .. :try_end_8} :catchall_3

    .line 3299
    if-eqz v0, :cond_e

    .line 3300
    :try_start_9
    invoke-static {}, Lcom/b/a/a/g/h;->b()Lcom/b/a/a/g/h;

    move-result-object v1

    invoke-virtual {v1, v0}, Lcom/b/a/a/g/h;->b(Ljavax/net/ssl/SSLSocket;)V

    .line 3239
    :cond_e
    iget-object v0, p0, Lcom/b/a/a/b/c;->l:Lcom/b/a/al;

    sget-object v1, Lcom/b/a/al;->d:Lcom/b/a/al;

    if-ne v0, v1, :cond_8

    .line 3240
    iget-object v0, p0, Lcom/b/a/a/b/c;->j:Ljava/net/Socket;

    const/4 v1, 0x0

    invoke-virtual {v0, v1}, Ljava/net/Socket;->setSoTimeout(I)V

    .line 3241
    new-instance v0, Lcom/b/a/a/e/r;

    invoke-direct {v0}, Lcom/b/a/a/e/r;-><init>()V

    iget-object v1, p0, Lcom/b/a/a/b/c;->j:Ljava/net/Socket;

    iget-object v5, p0, Lcom/b/a/a/b/c;->h:Lcom/b/a/aw;

    .line 3242
    invoke-virtual {v5}, Lcom/b/a/aw;->a()Lcom/b/a/a;

    move-result-object v5

    invoke-virtual {v5}, Lcom/b/a/a;->a()Lcom/b/a/ac;

    move-result-object v5

    invoke-virtual {v5}, Lcom/b/a/ac;->f()Ljava/lang/String;

    move-result-object v5

    iget-object v6, p0, Lcom/b/a/a/b/c;->n:Lcom/b/b/h;

    iget-object v7, p0, Lcom/b/a/a/b/c;->o:Lcom/b/b/g;

    invoke-virtual {v0, v1, v5, v6, v7}, Lcom/b/a/a/e/r;->a(Ljava/net/Socket;Ljava/lang/String;Lcom/b/b/h;Lcom/b/b/g;)Lcom/b/a/a/e/r;

    move-result-object v0

    .line 3243
    invoke-virtual {v0, p0}, Lcom/b/a/a/e/r;->a(Lcom/b/a/a/e/s;)Lcom/b/a/a/e/r;

    move-result-object v0

    .line 3244
    invoke-virtual {v0}, Lcom/b/a/a/e/r;->a()Lcom/b/a/a/e/j;

    move-result-object v0

    iput-object v0, p0, Lcom/b/a/a/b/c;->m:Lcom/b/a/a/e/j;

    .line 3245
    iget-object v0, p0, Lcom/b/a/a/b/c;->m:Lcom/b/a/a/e/j;

    invoke-virtual {v0}, Lcom/b/a/a/e/j;->b()V
    :try_end_9
    .catch Ljava/io/IOException; {:try_start_9 .. :try_end_9} :catch_0

    goto/16 :goto_2

    :cond_f
    move-object v1, v2

    .line 3285
    goto :goto_5

    .line 3292
    :cond_10
    :try_start_a
    sget-object v1, Lcom/b/a/al;->b:Lcom/b/a/al;
    :try_end_a
    .catch Ljava/lang/AssertionError; {:try_start_a .. :try_end_a} :catch_1
    .catchall {:try_start_a .. :try_end_a} :catchall_3

    goto :goto_6

    .line 3297
    :cond_11
    :try_start_b
    throw v0
    :try_end_b
    .catchall {:try_start_b .. :try_end_b} :catchall_0

    .line 164
    :cond_12
    invoke-virtual {v3, v0}, Lcom/b/a/a/b/e;->a(Ljava/io/IOException;)V

    move-object v1, v3

    goto/16 :goto_1

    .line 176
    :catchall_1
    move-exception v0

    :try_start_c
    monitor-exit v1
    :try_end_c
    .catchall {:try_start_c .. :try_end_c} :catchall_1

    throw v0

    .line 3299
    :catchall_2
    move-exception v0

    move-object v1, v2

    goto/16 :goto_4

    :catchall_3
    move-exception v1

    move-object v10, v1

    move-object v1, v0

    move-object v0, v10

    goto/16 :goto_4

    .line 3295
    :catch_2
    move-exception v0

    move-object v1, v2

    goto/16 :goto_3

    :cond_13
    move-object v3, v2

    goto/16 :goto_0

    .line 2335
    nop

    :sswitch_data_0
    .sparse-switch
        0xc8 -> :sswitch_0
        0x197 -> :sswitch_1
    .end sparse-switch
.end method

.method public final a(Lcom/b/a/a/e/ab;)V
    .locals 1

    .prologue
    .line 450
    sget-object v0, Lcom/b/a/a/e/b;->e:Lcom/b/a/a/e/b;

    invoke-virtual {p1, v0}, Lcom/b/a/a/e/ab;->a(Lcom/b/a/a/e/b;)V

    .line 451
    return-void
.end method

.method public final a(Lcom/b/a/a/e/j;)V
    .locals 2

    .prologue
    .line 455
    iget-object v1, p0, Lcom/b/a/a/b/c;->g:Lcom/b/a/n;

    monitor-enter v1

    .line 456
    :try_start_0
    invoke-virtual {p1}, Lcom/b/a/a/e/j;->a()I

    move-result v0

    iput v0, p0, Lcom/b/a/a/b/c;->c:I

    .line 457
    monitor-exit v1

    return-void

    :catchall_0
    move-exception v0

    monitor-exit v1
    :try_end_0
    .catchall {:try_start_0 .. :try_end_0} :catchall_0

    throw v0
.end method

.method public final a(Lcom/b/a/a;)Z
    .locals 2

    .prologue
    .line 378
    iget-object v0, p0, Lcom/b/a/a/b/c;->d:Ljava/util/List;

    invoke-interface {v0}, Ljava/util/List;->size()I

    move-result v0

    iget v1, p0, Lcom/b/a/a/b/c;->c:I

    if-ge v0, v1, :cond_0

    .line 3404
    iget-object v0, p0, Lcom/b/a/a/b/c;->h:Lcom/b/a/aw;

    .line 379
    invoke-virtual {v0}, Lcom/b/a/aw;->a()Lcom/b/a/a;

    move-result-object v0

    invoke-virtual {p1, v0}, Lcom/b/a/a;->equals(Ljava/lang/Object;)Z

    move-result v0

    if-eqz v0, :cond_0

    iget-boolean v0, p0, Lcom/b/a/a/b/c;->a:Z

    if-nez v0, :cond_0

    const/4 v0, 0x1

    :goto_0
    return v0

    :cond_0
    const/4 v0, 0x0

    .line 378
    goto :goto_0
.end method

.method public final a(Z)Z
    .locals 5

    .prologue
    const/4 v0, 0x1

    const/4 v1, 0x0

    .line 418
    iget-object v2, p0, Lcom/b/a/a/b/c;->j:Ljava/net/Socket;

    invoke-virtual {v2}, Ljava/net/Socket;->isClosed()Z

    move-result v2

    if-nez v2, :cond_0

    iget-object v2, p0, Lcom/b/a/a/b/c;->j:Ljava/net/Socket;

    invoke-virtual {v2}, Ljava/net/Socket;->isInputShutdown()Z

    move-result v2

    if-nez v2, :cond_0

    iget-object v2, p0, Lcom/b/a/a/b/c;->j:Ljava/net/Socket;

    invoke-virtual {v2}, Ljava/net/Socket;->isOutputShutdown()Z

    move-result v2

    if-eqz v2, :cond_2

    :cond_0
    move v0, v1

    .line 445
    :cond_1
    :goto_0
    return v0

    .line 422
    :cond_2
    iget-object v2, p0, Lcom/b/a/a/b/c;->m:Lcom/b/a/a/e/j;

    if-eqz v2, :cond_3

    .line 423
    iget-object v2, p0, Lcom/b/a/a/b/c;->m:Lcom/b/a/a/e/j;

    invoke-virtual {v2}, Lcom/b/a/a/e/j;->c()Z

    move-result v2

    if-eqz v2, :cond_1

    move v0, v1

    goto :goto_0

    .line 426
    :cond_3
    if-eqz p1, :cond_1

    .line 428
    :try_start_0
    iget-object v2, p0, Lcom/b/a/a/b/c;->j:Ljava/net/Socket;

    invoke-virtual {v2}, Ljava/net/Socket;->getSoTimeout()I
    :try_end_0
    .catch Ljava/net/SocketTimeoutException; {:try_start_0 .. :try_end_0} :catch_0
    .catch Ljava/io/IOException; {:try_start_0 .. :try_end_0} :catch_1

    move-result v3

    .line 430
    :try_start_1
    iget-object v2, p0, Lcom/b/a/a/b/c;->j:Ljava/net/Socket;

    const/4 v4, 0x1

    invoke-virtual {v2, v4}, Ljava/net/Socket;->setSoTimeout(I)V

    .line 431
    iget-object v2, p0, Lcom/b/a/a/b/c;->n:Lcom/b/b/h;

    invoke-interface {v2}, Lcom/b/b/h;->d()Z
    :try_end_1
    .catchall {:try_start_1 .. :try_end_1} :catchall_0

    move-result v2

    if-eqz v2, :cond_4

    .line 436
    :try_start_2
    iget-object v2, p0, Lcom/b/a/a/b/c;->j:Ljava/net/Socket;

    invoke-virtual {v2, v3}, Ljava/net/Socket;->setSoTimeout(I)V

    move v0, v1

    .line 432
    goto :goto_0

    .line 436
    :cond_4
    iget-object v2, p0, Lcom/b/a/a/b/c;->j:Ljava/net/Socket;

    invoke-virtual {v2, v3}, Ljava/net/Socket;->setSoTimeout(I)V

    goto :goto_0

    .line 442
    :catch_0
    move-exception v1

    goto :goto_0

    .line 436
    :catchall_0
    move-exception v2

    iget-object v4, p0, Lcom/b/a/a/b/c;->j:Ljava/net/Socket;

    invoke-virtual {v4, v3}, Ljava/net/Socket;->setSoTimeout(I)V

    throw v2
    :try_end_2
    .catch Ljava/net/SocketTimeoutException; {:try_start_2 .. :try_end_2} :catch_0
    .catch Ljava/io/IOException; {:try_start_2 .. :try_end_2} :catch_1

    .line 441
    :catch_1
    move-exception v0

    move v0, v1

    goto :goto_0
.end method

.method public final b()Ljava/net/Socket;
    .locals 1

    .prologue
    .line 413
    iget-object v0, p0, Lcom/b/a/a/b/c;->j:Ljava/net/Socket;

    return-object v0
.end method

.method public final c()Lcom/b/a/z;
    .locals 1

    .prologue
    .line 461
    iget-object v0, p0, Lcom/b/a/a/b/c;->k:Lcom/b/a/z;

    return-object v0
.end method

.method public final d()Z
    .locals 1

    .prologue
    .line 469
    iget-object v0, p0, Lcom/b/a/a/b/c;->m:Lcom/b/a/a/e/j;

    if-eqz v0, :cond_0

    const/4 v0, 0x1

    :goto_0
    return v0

    :cond_0
    const/4 v0, 0x0

    goto :goto_0
.end method

.method public final toString()Ljava/lang/String;
    .locals 2

    .prologue
    .line 477
    new-instance v0, Ljava/lang/StringBuilder;

    const-string v1, "Connection{"

    invoke-direct {v0, v1}, Ljava/lang/StringBuilder;-><init>(Ljava/lang/String;)V

    iget-object v1, p0, Lcom/b/a/a/b/c;->h:Lcom/b/a/aw;

    .line 478
    invoke-virtual {v1}, Lcom/b/a/aw;->a()Lcom/b/a/a;

    move-result-object v1

    invoke-virtual {v1}, Lcom/b/a/a;->a()Lcom/b/a/ac;

    move-result-object v1

    invoke-virtual {v1}, Lcom/b/a/ac;->f()Ljava/lang/String;

    move-result-object v1

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    const-string v1, ":"

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    iget-object v1, p0, Lcom/b/a/a/b/c;->h:Lcom/b/a/aw;

    invoke-virtual {v1}, Lcom/b/a/aw;->a()Lcom/b/a/a;

    move-result-object v1

    invoke-virtual {v1}, Lcom/b/a/a;->a()Lcom/b/a/ac;

    move-result-object v1

    invoke-virtual {v1}, Lcom/b/a/ac;->g()I

    move-result v1

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v0

    const-string v1, ", proxy="

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    iget-object v1, p0, Lcom/b/a/a/b/c;->h:Lcom/b/a/aw;

    .line 480
    invoke-virtual {v1}, Lcom/b/a/aw;->b()Ljava/net/Proxy;

    move-result-object v1

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/Object;)Ljava/lang/StringBuilder;

    move-result-object v0

    const-string v1, " hostAddress="

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    iget-object v1, p0, Lcom/b/a/a/b/c;->h:Lcom/b/a/aw;

    .line 482
    invoke-virtual {v1}, Lcom/b/a/aw;->c()Ljava/net/InetSocketAddress;

    move-result-object v1

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/Object;)Ljava/lang/StringBuilder;

    move-result-object v0

    const-string v1, " cipherSuite="

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    iget-object v0, p0, Lcom/b/a/a/b/c;->k:Lcom/b/a/z;

    if-eqz v0, :cond_0

    iget-object v0, p0, Lcom/b/a/a/b/c;->k:Lcom/b/a/z;

    .line 484
    invoke-virtual {v0}, Lcom/b/a/z;->a()Lcom/b/a/l;

    move-result-object v0

    :goto_0
    invoke-virtual {v1, v0}, Ljava/lang/StringBuilder;->append(Ljava/lang/Object;)Ljava/lang/StringBuilder;

    move-result-object v0

    const-string v1, " protocol="

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    iget-object v1, p0, Lcom/b/a/a/b/c;->l:Lcom/b/a/al;

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/Object;)Ljava/lang/StringBuilder;

    move-result-object v0

    const/16 v1, 0x7d

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(C)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-virtual {v0}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v0

    .line 477
    return-object v0

    .line 484
    :cond_0
    const-string v0, "none"

    goto :goto_0
.end method
