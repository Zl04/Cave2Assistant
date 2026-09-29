.class public final Lcom/b/a/a/c/k;
.super Ljava/lang/Object;
.source "SourceFile"

# interfaces
.implements Lcom/b/a/af;


# instance fields
.field private final a:Lcom/b/a/ai;

.field private final b:Z

.field private c:Lcom/b/a/a/b/g;

.field private d:Ljava/lang/Object;

.field private volatile e:Z


# direct methods
.method public constructor <init>(Lcom/b/a/ai;Z)V
    .locals 0

    .prologue
    .line 71
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    .line 72
    iput-object p1, p0, Lcom/b/a/a/c/k;->a:Lcom/b/a/ai;

    .line 73
    iput-boolean p2, p0, Lcom/b/a/a/c/k;->b:Z

    .line 74
    return-void
.end method

.method private a(Lcom/b/a/ac;)Lcom/b/a/a;
    .locals 13

    .prologue
    const/4 v7, 0x0

    .line 188
    .line 191
    invoke-virtual {p1}, Lcom/b/a/ac;->c()Z

    move-result v0

    if-eqz v0, :cond_0

    .line 192
    iget-object v0, p0, Lcom/b/a/a/c/k;->a:Lcom/b/a/ai;

    invoke-virtual {v0}, Lcom/b/a/ai;->i()Ljavax/net/ssl/SSLSocketFactory;

    move-result-object v5

    .line 193
    iget-object v0, p0, Lcom/b/a/a/c/k;->a:Lcom/b/a/ai;

    invoke-virtual {v0}, Lcom/b/a/ai;->j()Ljavax/net/ssl/HostnameVerifier;

    move-result-object v6

    .line 194
    iget-object v0, p0, Lcom/b/a/a/c/k;->a:Lcom/b/a/ai;

    invoke-virtual {v0}, Lcom/b/a/ai;->k()Lcom/b/a/i;

    move-result-object v7

    .line 197
    :goto_0
    new-instance v0, Lcom/b/a/a;

    invoke-virtual {p1}, Lcom/b/a/ac;->f()Ljava/lang/String;

    move-result-object v1

    invoke-virtual {p1}, Lcom/b/a/ac;->g()I

    move-result v2

    iget-object v3, p0, Lcom/b/a/a/c/k;->a:Lcom/b/a/ai;

    invoke-virtual {v3}, Lcom/b/a/ai;->g()Lcom/b/a/v;

    move-result-object v3

    iget-object v4, p0, Lcom/b/a/a/c/k;->a:Lcom/b/a/ai;

    invoke-virtual {v4}, Lcom/b/a/ai;->h()Ljavax/net/SocketFactory;

    move-result-object v4

    iget-object v8, p0, Lcom/b/a/a/c/k;->a:Lcom/b/a/ai;

    .line 198
    invoke-virtual {v8}, Lcom/b/a/ai;->m()Lcom/b/a/b;

    move-result-object v8

    iget-object v9, p0, Lcom/b/a/a/c/k;->a:Lcom/b/a/ai;

    .line 199
    invoke-virtual {v9}, Lcom/b/a/ai;->d()Ljava/net/Proxy;

    move-result-object v9

    iget-object v10, p0, Lcom/b/a/a/c/k;->a:Lcom/b/a/ai;

    invoke-virtual {v10}, Lcom/b/a/ai;->r()Ljava/util/List;

    move-result-object v10

    iget-object v11, p0, Lcom/b/a/a/c/k;->a:Lcom/b/a/ai;

    invoke-virtual {v11}, Lcom/b/a/ai;->s()Ljava/util/List;

    move-result-object v11

    iget-object v12, p0, Lcom/b/a/a/c/k;->a:Lcom/b/a/ai;

    invoke-virtual {v12}, Lcom/b/a/ai;->e()Ljava/net/ProxySelector;

    move-result-object v12

    invoke-direct/range {v0 .. v12}, Lcom/b/a/a;-><init>(Ljava/lang/String;ILcom/b/a/v;Ljavax/net/SocketFactory;Ljavax/net/ssl/SSLSocketFactory;Ljavax/net/ssl/HostnameVerifier;Lcom/b/a/i;Lcom/b/a/b;Ljava/net/Proxy;Ljava/util/List;Ljava/util/List;Ljava/net/ProxySelector;)V

    .line 197
    return-object v0

    :cond_0
    move-object v6, v7

    move-object v5, v7

    goto :goto_0
.end method

.method private static a(Lcom/b/a/as;Lcom/b/a/ac;)Z
    .locals 3

    .prologue
    .line 358
    invoke-virtual {p0}, Lcom/b/a/as;->a()Lcom/b/a/ao;

    move-result-object v0

    invoke-virtual {v0}, Lcom/b/a/ao;->a()Lcom/b/a/ac;

    move-result-object v0

    .line 359
    invoke-virtual {v0}, Lcom/b/a/ac;->f()Ljava/lang/String;

    move-result-object v1

    invoke-virtual {p1}, Lcom/b/a/ac;->f()Ljava/lang/String;

    move-result-object v2

    invoke-virtual {v1, v2}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v1

    if-eqz v1, :cond_0

    .line 360
    invoke-virtual {v0}, Lcom/b/a/ac;->g()I

    move-result v1

    invoke-virtual {p1}, Lcom/b/a/ac;->g()I

    move-result v2

    if-ne v1, v2, :cond_0

    .line 361
    invoke-virtual {v0}, Lcom/b/a/ac;->b()Ljava/lang/String;

    move-result-object v0

    invoke-virtual {p1}, Lcom/b/a/ac;->b()Ljava/lang/String;

    move-result-object v1

    invoke-virtual {v0, v1}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v0

    if-eqz v0, :cond_0

    const/4 v0, 0x1

    :goto_0
    return v0

    :cond_0
    const/4 v0, 0x0

    .line 359
    goto :goto_0
.end method

.method private a(Ljava/io/IOException;ZLcom/b/a/ao;)Z
    .locals 3

    .prologue
    const/4 v1, 0x1

    const/4 v0, 0x0

    .line 209
    iget-object v2, p0, Lcom/b/a/a/c/k;->c:Lcom/b/a/a/b/g;

    invoke-virtual {v2, p1}, Lcom/b/a/a/b/g;->a(Ljava/io/IOException;)V

    .line 212
    iget-object v2, p0, Lcom/b/a/a/c/k;->a:Lcom/b/a/ai;

    invoke-virtual {v2}, Lcom/b/a/ai;->q()Z

    move-result v2

    if-nez v2, :cond_1

    .line 224
    :cond_0
    :goto_0
    return v0

    .line 215
    :cond_1
    if-eqz p2, :cond_2

    invoke-virtual {p3}, Lcom/b/a/ao;->d()Lcom/b/a/aq;

    move-result-object v2

    instance-of v2, v2, Lcom/b/a/a/c/m;

    if-nez v2, :cond_0

    .line 2229
    :cond_2
    instance-of v2, p1, Ljava/net/ProtocolException;

    if-eqz v2, :cond_3

    move v2, v0

    .line 218
    :goto_1
    if-eqz v2, :cond_0

    .line 221
    iget-object v2, p0, Lcom/b/a/a/c/k;->c:Lcom/b/a/a/b/g;

    invoke-virtual {v2}, Lcom/b/a/a/b/g;->e()Z

    move-result v2

    if-eqz v2, :cond_0

    move v0, v1

    .line 224
    goto :goto_0

    .line 2235
    :cond_3
    instance-of v2, p1, Ljava/io/InterruptedIOException;

    if-eqz v2, :cond_5

    .line 2236
    instance-of v2, p1, Ljava/net/SocketTimeoutException;

    if-eqz v2, :cond_4

    if-eqz p2, :cond_7

    :cond_4
    move v2, v0

    goto :goto_1

    .line 2241
    :cond_5
    instance-of v2, p1, Ljavax/net/ssl/SSLHandshakeException;

    if-eqz v2, :cond_6

    .line 2244
    invoke-virtual {p1}, Ljava/io/IOException;->getCause()Ljava/lang/Throwable;

    move-result-object v2

    instance-of v2, v2, Ljava/security/cert/CertificateException;

    if-eqz v2, :cond_6

    move v2, v0

    .line 2245
    goto :goto_1

    .line 2248
    :cond_6
    instance-of v2, p1, Ljavax/net/ssl/SSLPeerUnverifiedException;

    if-eqz v2, :cond_7

    move v2, v0

    .line 2250
    goto :goto_1

    :cond_7
    move v2, v1

    .line 2256
    goto :goto_1
.end method


# virtual methods
.method public final a(Lcom/b/a/ag;)Lcom/b/a/as;
    .locals 11

    .prologue
    const/4 v8, 0x1

    const/4 v5, 0x0

    const/4 v2, 0x0

    .line 104
    invoke-interface {p1}, Lcom/b/a/ag;->a()Lcom/b/a/ao;

    move-result-object v1

    .line 106
    new-instance v3, Lcom/b/a/a/b/g;

    iget-object v4, p0, Lcom/b/a/a/c/k;->a:Lcom/b/a/ai;

    .line 107
    invoke-virtual {v4}, Lcom/b/a/ai;->n()Lcom/b/a/n;

    move-result-object v4

    invoke-virtual {v1}, Lcom/b/a/ao;->a()Lcom/b/a/ac;

    move-result-object v6

    invoke-direct {p0, v6}, Lcom/b/a/a/c/k;->a(Lcom/b/a/ac;)Lcom/b/a/a;

    move-result-object v6

    iget-object v7, p0, Lcom/b/a/a/c/k;->d:Ljava/lang/Object;

    invoke-direct {v3, v4, v6, v7}, Lcom/b/a/a/b/g;-><init>(Lcom/b/a/n;Lcom/b/a/a;Ljava/lang/Object;)V

    iput-object v3, p0, Lcom/b/a/a/c/k;->c:Lcom/b/a/a/b/g;

    move-object v3, v2

    move v4, v5

    move-object v6, v1

    .line 112
    :cond_0
    :goto_0
    iget-boolean v1, p0, Lcom/b/a/a/c/k;->e:Z

    if-eqz v1, :cond_1

    .line 113
    iget-object v1, p0, Lcom/b/a/a/c/k;->c:Lcom/b/a/a/b/g;

    invoke-virtual {v1}, Lcom/b/a/a/b/g;->c()V

    .line 114
    new-instance v1, Ljava/io/IOException;

    const-string v2, "Canceled"

    invoke-direct {v1, v2}, Ljava/io/IOException;-><init>(Ljava/lang/String;)V

    throw v1

    .line 120
    :cond_1
    :try_start_0
    move-object v0, p1

    check-cast v0, Lcom/b/a/a/c/h;

    move-object v1, v0

    iget-object v7, p0, Lcom/b/a/a/c/k;->c:Lcom/b/a/a/b/g;

    const/4 v9, 0x0

    const/4 v10, 0x0

    invoke-virtual {v1, v6, v7, v9, v10}, Lcom/b/a/a/c/h;->a(Lcom/b/a/ao;Lcom/b/a/a/b/g;Lcom/b/a/a/c/c;Lcom/b/a/m;)Lcom/b/a/as;
    :try_end_0
    .catch Lcom/b/a/a/b/e; {:try_start_0 .. :try_end_0} :catch_0
    .catch Ljava/io/IOException; {:try_start_0 .. :try_end_0} :catch_1
    .catchall {:try_start_0 .. :try_end_0} :catchall_0

    move-result-object v1

    .line 144
    if-eqz v3, :cond_15

    .line 145
    invoke-virtual {v1}, Lcom/b/a/as;->f()Lcom/b/a/at;

    move-result-object v1

    .line 146
    invoke-virtual {v3}, Lcom/b/a/as;->f()Lcom/b/a/at;

    move-result-object v3

    .line 147
    invoke-virtual {v3, v2}, Lcom/b/a/at;->a(Lcom/b/a/au;)Lcom/b/a/at;

    move-result-object v3

    .line 148
    invoke-virtual {v3}, Lcom/b/a/at;->a()Lcom/b/a/as;

    move-result-object v3

    .line 146
    invoke-virtual {v1, v3}, Lcom/b/a/at;->c(Lcom/b/a/as;)Lcom/b/a/at;

    move-result-object v1

    .line 149
    invoke-virtual {v1}, Lcom/b/a/at;->a()Lcom/b/a/as;

    move-result-object v3

    .line 1265
    :goto_1
    if-nez v3, :cond_3

    new-instance v1, Ljava/lang/IllegalStateException;

    invoke-direct {v1}, Ljava/lang/IllegalStateException;-><init>()V

    throw v1

    .line 122
    :catch_0
    move-exception v1

    .line 124
    :try_start_1
    invoke-virtual {v1}, Lcom/b/a/a/b/e;->a()Ljava/io/IOException;

    move-result-object v7

    const/4 v9, 0x0

    invoke-direct {p0, v7, v9, v6}, Lcom/b/a/a/c/k;->a(Ljava/io/IOException;ZLcom/b/a/ao;)Z

    move-result v7

    if-nez v7, :cond_0

    .line 125
    invoke-virtual {v1}, Lcom/b/a/a/b/e;->a()Ljava/io/IOException;

    move-result-object v1

    throw v1
    :try_end_1
    .catchall {:try_start_1 .. :try_end_1} :catchall_0

    .line 137
    :catchall_0
    move-exception v1

    .line 138
    iget-object v3, p0, Lcom/b/a/a/c/k;->c:Lcom/b/a/a/b/g;

    invoke-virtual {v3, v2}, Lcom/b/a/a/b/g;->a(Ljava/io/IOException;)V

    .line 139
    iget-object v2, p0, Lcom/b/a/a/c/k;->c:Lcom/b/a/a/b/g;

    invoke-virtual {v2}, Lcom/b/a/a/b/g;->c()V

    throw v1

    .line 129
    :catch_1
    move-exception v1

    .line 131
    :try_start_2
    instance-of v7, v1, Lcom/b/a/a/e/a;

    if-nez v7, :cond_2

    move v7, v8

    .line 132
    :goto_2
    invoke-direct {p0, v1, v7, v6}, Lcom/b/a/a/c/k;->a(Ljava/io/IOException;ZLcom/b/a/ao;)Z

    move-result v7

    if-nez v7, :cond_0

    throw v1
    :try_end_2
    .catchall {:try_start_2 .. :try_end_2} :catchall_0

    :cond_2
    move v7, v5

    .line 131
    goto :goto_2

    .line 1266
    :cond_3
    iget-object v1, p0, Lcom/b/a/a/c/k;->c:Lcom/b/a/a/b/g;

    invoke-virtual {v1}, Lcom/b/a/a/b/g;->b()Lcom/b/a/a/b/c;

    move-result-object v1

    .line 1267
    if-eqz v1, :cond_6

    .line 1268
    invoke-interface {v1}, Lcom/b/a/m;->a()Lcom/b/a/aw;

    move-result-object v1

    .line 1270
    :goto_3
    invoke-virtual {v3}, Lcom/b/a/as;->b()I

    move-result v6

    .line 1272
    invoke-virtual {v3}, Lcom/b/a/as;->a()Lcom/b/a/ao;

    move-result-object v7

    invoke-virtual {v7}, Lcom/b/a/ao;->b()Ljava/lang/String;

    move-result-object v7

    .line 1273
    sparse-switch v6, :sswitch_data_0

    :cond_4
    move-object v6, v2

    .line 154
    :goto_4
    if-nez v6, :cond_10

    .line 155
    iget-boolean v1, p0, Lcom/b/a/a/c/k;->b:Z

    if-nez v1, :cond_5

    .line 156
    iget-object v1, p0, Lcom/b/a/a/c/k;->c:Lcom/b/a/a/b/g;

    invoke-virtual {v1}, Lcom/b/a/a/b/g;->c()V

    .line 158
    :cond_5
    return-object v3

    :cond_6
    move-object v1, v2

    .line 1268
    goto :goto_3

    .line 1275
    :sswitch_0
    if-eqz v1, :cond_7

    .line 1276
    invoke-virtual {v1}, Lcom/b/a/aw;->b()Ljava/net/Proxy;

    move-result-object v1

    .line 1278
    :goto_5
    invoke-virtual {v1}, Ljava/net/Proxy;->type()Ljava/net/Proxy$Type;

    move-result-object v1

    sget-object v6, Ljava/net/Proxy$Type;->HTTP:Ljava/net/Proxy$Type;

    if-eq v1, v6, :cond_8

    .line 1279
    new-instance v1, Ljava/net/ProtocolException;

    const-string v2, "Received HTTP_PROXY_AUTH (407) code while not using proxy"

    invoke-direct {v1, v2}, Ljava/net/ProtocolException;-><init>(Ljava/lang/String;)V

    throw v1

    .line 1276
    :cond_7
    iget-object v1, p0, Lcom/b/a/a/c/k;->a:Lcom/b/a/ai;

    .line 1277
    invoke-virtual {v1}, Lcom/b/a/ai;->d()Ljava/net/Proxy;

    move-result-object v1

    goto :goto_5

    .line 1281
    :cond_8
    iget-object v1, p0, Lcom/b/a/a/c/k;->a:Lcom/b/a/ai;

    invoke-virtual {v1}, Lcom/b/a/ai;->m()Lcom/b/a/b;

    move-result-object v1

    invoke-interface {v1}, Lcom/b/a/b;->a()Lcom/b/a/ao;

    move-result-object v6

    goto :goto_4

    .line 1284
    :sswitch_1
    iget-object v1, p0, Lcom/b/a/a/c/k;->a:Lcom/b/a/ai;

    invoke-virtual {v1}, Lcom/b/a/ai;->l()Lcom/b/a/b;

    move-result-object v1

    invoke-interface {v1}, Lcom/b/a/b;->a()Lcom/b/a/ao;

    move-result-object v6

    goto :goto_4

    .line 1290
    :sswitch_2
    const-string v1, "GET"

    invoke-virtual {v7, v1}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v1

    if-nez v1, :cond_9

    const-string v1, "HEAD"

    invoke-virtual {v7, v1}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v1

    if-eqz v1, :cond_4

    .line 1299
    :cond_9
    :sswitch_3
    iget-object v1, p0, Lcom/b/a/a/c/k;->a:Lcom/b/a/ai;

    invoke-virtual {v1}, Lcom/b/a/ai;->p()Z

    move-result v1

    if-eqz v1, :cond_4

    .line 1301
    const-string v1, "Location"

    invoke-virtual {v3, v1}, Lcom/b/a/as;->a(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v1

    .line 1302
    if-eqz v1, :cond_4

    .line 1303
    invoke-virtual {v3}, Lcom/b/a/as;->a()Lcom/b/a/ao;

    move-result-object v6

    invoke-virtual {v6}, Lcom/b/a/ao;->a()Lcom/b/a/ac;

    move-result-object v6

    invoke-virtual {v6, v1}, Lcom/b/a/ac;->c(Ljava/lang/String;)Lcom/b/a/ac;

    move-result-object v6

    .line 1306
    if-eqz v6, :cond_4

    .line 1309
    invoke-virtual {v6}, Lcom/b/a/ac;->b()Ljava/lang/String;

    move-result-object v1

    invoke-virtual {v3}, Lcom/b/a/as;->a()Lcom/b/a/ao;

    move-result-object v9

    invoke-virtual {v9}, Lcom/b/a/ao;->a()Lcom/b/a/ac;

    move-result-object v9

    invoke-virtual {v9}, Lcom/b/a/ac;->b()Ljava/lang/String;

    move-result-object v9

    invoke-virtual {v1, v9}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v1

    .line 1310
    if-nez v1, :cond_a

    iget-object v1, p0, Lcom/b/a/a/c/k;->a:Lcom/b/a/ai;

    invoke-virtual {v1}, Lcom/b/a/ai;->o()Z

    move-result v1

    if-eqz v1, :cond_4

    .line 1313
    :cond_a
    invoke-virtual {v3}, Lcom/b/a/as;->a()Lcom/b/a/ao;

    move-result-object v1

    invoke-virtual {v1}, Lcom/b/a/ao;->e()Lcom/b/a/ap;

    move-result-object v9

    .line 1314
    invoke-static {v7}, Lcom/b/a/a/c/g;->b(Ljava/lang/String;)Z

    move-result v1

    if-eqz v1, :cond_b

    .line 2045
    const-string v1, "PROPFIND"

    invoke-virtual {v7, v1}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v10

    .line 2050
    const-string v1, "PROPFIND"

    invoke-virtual {v7, v1}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v1

    if-nez v1, :cond_d

    move v1, v8

    .line 1316
    :goto_6
    if-eqz v1, :cond_e

    .line 1317
    const-string v1, "GET"

    invoke-virtual {v9, v1, v2}, Lcom/b/a/ap;->a(Ljava/lang/String;Lcom/b/a/aq;)Lcom/b/a/ap;

    .line 1322
    :goto_7
    if-nez v10, :cond_b

    .line 1323
    const-string v1, "Transfer-Encoding"

    invoke-virtual {v9, v1}, Lcom/b/a/ap;->b(Ljava/lang/String;)Lcom/b/a/ap;

    .line 1324
    const-string v1, "Content-Length"

    invoke-virtual {v9, v1}, Lcom/b/a/ap;->b(Ljava/lang/String;)Lcom/b/a/ap;

    .line 1325
    const-string v1, "Content-Type"

    invoke-virtual {v9, v1}, Lcom/b/a/ap;->b(Ljava/lang/String;)Lcom/b/a/ap;

    .line 1332
    :cond_b
    invoke-static {v3, v6}, Lcom/b/a/a/c/k;->a(Lcom/b/a/as;Lcom/b/a/ac;)Z

    move-result v1

    if-nez v1, :cond_c

    .line 1333
    const-string v1, "Authorization"

    invoke-virtual {v9, v1}, Lcom/b/a/ap;->b(Ljava/lang/String;)Lcom/b/a/ap;

    .line 1336
    :cond_c
    invoke-virtual {v9, v6}, Lcom/b/a/ap;->a(Lcom/b/a/ac;)Lcom/b/a/ap;

    move-result-object v1

    invoke-virtual {v1}, Lcom/b/a/ap;->a()Lcom/b/a/ao;

    move-result-object v6

    goto/16 :goto_4

    :cond_d
    move v1, v5

    .line 2050
    goto :goto_6

    .line 1319
    :cond_e
    if-eqz v10, :cond_f

    invoke-virtual {v3}, Lcom/b/a/as;->a()Lcom/b/a/ao;

    move-result-object v1

    invoke-virtual {v1}, Lcom/b/a/ao;->d()Lcom/b/a/aq;

    move-result-object v1

    .line 1320
    :goto_8
    invoke-virtual {v9, v7, v1}, Lcom/b/a/ap;->a(Ljava/lang/String;Lcom/b/a/aq;)Lcom/b/a/ap;

    goto :goto_7

    :cond_f
    move-object v1, v2

    .line 1319
    goto :goto_8

    .line 1342
    :sswitch_4
    invoke-virtual {v3}, Lcom/b/a/as;->a()Lcom/b/a/ao;

    move-result-object v1

    invoke-virtual {v1}, Lcom/b/a/ao;->d()Lcom/b/a/aq;

    move-result-object v1

    instance-of v1, v1, Lcom/b/a/a/c/m;

    if-nez v1, :cond_4

    .line 1346
    invoke-virtual {v3}, Lcom/b/a/as;->a()Lcom/b/a/ao;

    move-result-object v6

    goto/16 :goto_4

    .line 161
    :cond_10
    invoke-virtual {v3}, Lcom/b/a/as;->e()Lcom/b/a/au;

    move-result-object v1

    invoke-static {v1}, Lcom/b/a/a/c;->a(Ljava/io/Closeable;)V

    .line 163
    add-int/lit8 v1, v4, 0x1

    const/16 v4, 0x14

    if-le v1, v4, :cond_11

    .line 164
    iget-object v2, p0, Lcom/b/a/a/c/k;->c:Lcom/b/a/a/b/g;

    invoke-virtual {v2}, Lcom/b/a/a/b/g;->c()V

    .line 165
    new-instance v2, Ljava/net/ProtocolException;

    new-instance v3, Ljava/lang/StringBuilder;

    const-string v4, "Too many follow-up requests: "

    invoke-direct {v3, v4}, Ljava/lang/StringBuilder;-><init>(Ljava/lang/String;)V

    invoke-virtual {v3, v1}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v1

    invoke-direct {v2, v1}, Ljava/net/ProtocolException;-><init>(Ljava/lang/String;)V

    throw v2

    .line 168
    :cond_11
    invoke-virtual {v6}, Lcom/b/a/ao;->d()Lcom/b/a/aq;

    move-result-object v4

    instance-of v4, v4, Lcom/b/a/a/c/m;

    if-eqz v4, :cond_12

    .line 169
    iget-object v1, p0, Lcom/b/a/a/c/k;->c:Lcom/b/a/a/b/g;

    invoke-virtual {v1}, Lcom/b/a/a/b/g;->c()V

    .line 170
    new-instance v1, Ljava/net/HttpRetryException;

    const-string v2, "Cannot retry streamed HTTP body"

    invoke-virtual {v3}, Lcom/b/a/as;->b()I

    move-result v3

    invoke-direct {v1, v2, v3}, Ljava/net/HttpRetryException;-><init>(Ljava/lang/String;I)V

    throw v1

    .line 173
    :cond_12
    invoke-virtual {v6}, Lcom/b/a/ao;->a()Lcom/b/a/ac;

    move-result-object v4

    invoke-static {v3, v4}, Lcom/b/a/a/c/k;->a(Lcom/b/a/as;Lcom/b/a/ac;)Z

    move-result v4

    if-nez v4, :cond_14

    .line 174
    iget-object v4, p0, Lcom/b/a/a/c/k;->c:Lcom/b/a/a/b/g;

    invoke-virtual {v4}, Lcom/b/a/a/b/g;->c()V

    .line 175
    new-instance v4, Lcom/b/a/a/b/g;

    iget-object v7, p0, Lcom/b/a/a/c/k;->a:Lcom/b/a/ai;

    .line 176
    invoke-virtual {v7}, Lcom/b/a/ai;->n()Lcom/b/a/n;

    move-result-object v7

    invoke-virtual {v6}, Lcom/b/a/ao;->a()Lcom/b/a/ac;

    move-result-object v9

    invoke-direct {p0, v9}, Lcom/b/a/a/c/k;->a(Lcom/b/a/ac;)Lcom/b/a/a;

    move-result-object v9

    iget-object v10, p0, Lcom/b/a/a/c/k;->d:Ljava/lang/Object;

    invoke-direct {v4, v7, v9, v10}, Lcom/b/a/a/b/g;-><init>(Lcom/b/a/n;Lcom/b/a/a;Ljava/lang/Object;)V

    iput-object v4, p0, Lcom/b/a/a/c/k;->c:Lcom/b/a/a/b/g;

    :cond_13
    move v4, v1

    .line 184
    goto/16 :goto_0

    .line 177
    :cond_14
    iget-object v4, p0, Lcom/b/a/a/c/k;->c:Lcom/b/a/a/b/g;

    invoke-virtual {v4}, Lcom/b/a/a/b/g;->a()Lcom/b/a/a/c/c;

    move-result-object v4

    if-eqz v4, :cond_13

    .line 178
    new-instance v1, Ljava/lang/IllegalStateException;

    new-instance v2, Ljava/lang/StringBuilder;

    const-string v4, "Closing the body of "

    invoke-direct {v2, v4}, Ljava/lang/StringBuilder;-><init>(Ljava/lang/String;)V

    invoke-virtual {v2, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/Object;)Ljava/lang/StringBuilder;

    move-result-object v2

    const-string v3, " didn\'t close its backing stream. Bad interceptor?"

    invoke-virtual {v2, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    invoke-virtual {v2}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v2

    invoke-direct {v1, v2}, Ljava/lang/IllegalStateException;-><init>(Ljava/lang/String;)V

    throw v1

    :cond_15
    move-object v3, v1

    goto/16 :goto_1

    .line 1273
    :sswitch_data_0
    .sparse-switch
        0x12c -> :sswitch_3
        0x12d -> :sswitch_3
        0x12e -> :sswitch_3
        0x12f -> :sswitch_3
        0x133 -> :sswitch_2
        0x134 -> :sswitch_2
        0x191 -> :sswitch_1
        0x197 -> :sswitch_0
        0x198 -> :sswitch_4
    .end sparse-switch
.end method

.method public final a(Ljava/lang/Object;)V
    .locals 0

    .prologue
    .line 96
    iput-object p1, p0, Lcom/b/a/a/c/k;->d:Ljava/lang/Object;

    .line 97
    return-void
.end method

.method public final a()Z
    .locals 1

    .prologue
    .line 92
    iget-boolean v0, p0, Lcom/b/a/a/c/k;->e:Z

    return v0
.end method
