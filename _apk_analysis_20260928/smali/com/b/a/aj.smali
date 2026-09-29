.class final Lcom/b/a/aj;
.super Lcom/b/a/a/a;
.source "SourceFile"


# direct methods
.method constructor <init>()V
    .locals 0

    .prologue
    .line 129
    invoke-direct {p0}, Lcom/b/a/a/a;-><init>()V

    return-void
.end method


# virtual methods
.method public final a(Lcom/b/a/at;)I
    .locals 1

    .prologue
    .line 166
    iget v0, p1, Lcom/b/a/at;->c:I

    return v0
.end method

.method public final a(Lcom/b/a/n;Lcom/b/a/a;Lcom/b/a/a/b/g;)Lcom/b/a/a/b/c;
    .locals 1

    .prologue
    .line 149
    invoke-virtual {p1, p2, p3}, Lcom/b/a/n;->a(Lcom/b/a/a;Lcom/b/a/a/b/g;)Lcom/b/a/a/b/c;

    move-result-object v0

    return-object v0
.end method

.method public final a(Lcom/b/a/n;)Lcom/b/a/a/b/d;
    .locals 1

    .prologue
    .line 162
    iget-object v0, p1, Lcom/b/a/n;->a:Lcom/b/a/a/b/d;

    return-object v0
.end method

.method public final a(Lcom/b/a/ab;Ljava/lang/String;)V
    .locals 3

    .prologue
    const/4 v2, 0x1

    .line 1247
    const-string v0, ":"

    invoke-virtual {p2, v0, v2}, Ljava/lang/String;->indexOf(Ljava/lang/String;I)I

    move-result v0

    .line 1248
    const/4 v1, -0x1

    if-eq v0, v1, :cond_0

    .line 1249
    const/4 v1, 0x0

    invoke-virtual {p2, v1, v0}, Ljava/lang/String;->substring(II)Ljava/lang/String;

    move-result-object v1

    add-int/lit8 v0, v0, 0x1

    invoke-virtual {p2, v0}, Ljava/lang/String;->substring(I)Ljava/lang/String;

    move-result-object v0

    invoke-virtual {p1, v1, v0}, Lcom/b/a/ab;->b(Ljava/lang/String;Ljava/lang/String;)Lcom/b/a/ab;

    .line 1253
    :goto_0
    return-void

    .line 1250
    :cond_0
    const-string v0, ":"

    invoke-virtual {p2, v0}, Ljava/lang/String;->startsWith(Ljava/lang/String;)Z

    move-result v0

    if-eqz v0, :cond_1

    .line 1253
    const-string v0, ""

    invoke-virtual {p2, v2}, Ljava/lang/String;->substring(I)Ljava/lang/String;

    move-result-object v1

    invoke-virtual {p1, v0, v1}, Lcom/b/a/ab;->b(Ljava/lang/String;Ljava/lang/String;)Lcom/b/a/ab;

    goto :goto_0

    .line 1255
    :cond_1
    const-string v0, ""

    invoke-virtual {p1, v0, p2}, Lcom/b/a/ab;->b(Ljava/lang/String;Ljava/lang/String;)Lcom/b/a/ab;

    goto :goto_0
.end method

.method public final a(Lcom/b/a/ab;Ljava/lang/String;Ljava/lang/String;)V
    .locals 0

    .prologue
    .line 135
    invoke-virtual {p1, p2, p3}, Lcom/b/a/ab;->b(Ljava/lang/String;Ljava/lang/String;)Lcom/b/a/ab;

    .line 136
    return-void
.end method

.method public final a(Lcom/b/a/p;Ljavax/net/ssl/SSLSocket;Z)V
    .locals 4

    .prologue
    .line 171
    .line 2148
    iget-object v0, p1, Lcom/b/a/p;->f:[Ljava/lang/String;

    if-eqz v0, :cond_3

    const-class v0, Ljava/lang/String;

    iget-object v1, p1, Lcom/b/a/p;->f:[Ljava/lang/String;

    .line 2149
    invoke-virtual {p2}, Ljavax/net/ssl/SSLSocket;->getEnabledCipherSuites()[Ljava/lang/String;

    move-result-object v2

    invoke-static {v0, v1, v2}, Lcom/b/a/a/c;->a(Ljava/lang/Class;[Ljava/lang/Object;[Ljava/lang/Object;)[Ljava/lang/Object;

    move-result-object v0

    check-cast v0, [Ljava/lang/String;

    move-object v1, v0

    .line 2151
    :goto_0
    iget-object v0, p1, Lcom/b/a/p;->g:[Ljava/lang/String;

    if-eqz v0, :cond_4

    const-class v0, Ljava/lang/String;

    iget-object v2, p1, Lcom/b/a/p;->g:[Ljava/lang/String;

    .line 2152
    invoke-virtual {p2}, Ljavax/net/ssl/SSLSocket;->getEnabledProtocols()[Ljava/lang/String;

    move-result-object v3

    invoke-static {v0, v2, v3}, Lcom/b/a/a/c;->a(Ljava/lang/Class;[Ljava/lang/Object;[Ljava/lang/Object;)[Ljava/lang/Object;

    move-result-object v0

    check-cast v0, [Ljava/lang/String;

    .line 2157
    :goto_1
    if-eqz p3, :cond_0

    invoke-virtual {p2}, Ljavax/net/ssl/SSLSocket;->getSupportedCipherSuites()[Ljava/lang/String;

    move-result-object v2

    const-string v3, "TLS_FALLBACK_SCSV"

    invoke-static {v2, v3}, Lcom/b/a/a/c;->a([Ljava/lang/Object;Ljava/lang/Object;)I

    move-result v2

    const/4 v3, -0x1

    if-eq v2, v3, :cond_0

    .line 2158
    const-string v2, "TLS_FALLBACK_SCSV"

    invoke-static {v1, v2}, Lcom/b/a/a/c;->a([Ljava/lang/String;Ljava/lang/String;)[Ljava/lang/String;

    move-result-object v1

    .line 2161
    :cond_0
    new-instance v2, Lcom/b/a/q;

    invoke-direct {v2, p1}, Lcom/b/a/q;-><init>(Lcom/b/a/p;)V

    .line 2162
    invoke-virtual {v2, v1}, Lcom/b/a/q;->a([Ljava/lang/String;)Lcom/b/a/q;

    move-result-object v1

    .line 2163
    invoke-virtual {v1, v0}, Lcom/b/a/q;->b([Ljava/lang/String;)Lcom/b/a/q;

    move-result-object v0

    .line 2164
    invoke-virtual {v0}, Lcom/b/a/q;->b()Lcom/b/a/p;

    move-result-object v0

    .line 2135
    iget-object v1, v0, Lcom/b/a/p;->g:[Ljava/lang/String;

    if-eqz v1, :cond_1

    .line 2136
    iget-object v1, v0, Lcom/b/a/p;->g:[Ljava/lang/String;

    invoke-virtual {p2, v1}, Ljavax/net/ssl/SSLSocket;->setEnabledProtocols([Ljava/lang/String;)V

    .line 2138
    :cond_1
    iget-object v1, v0, Lcom/b/a/p;->f:[Ljava/lang/String;

    if-eqz v1, :cond_2

    .line 2139
    iget-object v0, v0, Lcom/b/a/p;->f:[Ljava/lang/String;

    invoke-virtual {p2, v0}, Ljavax/net/ssl/SSLSocket;->setEnabledCipherSuites([Ljava/lang/String;)V

    .line 172
    :cond_2
    return-void

    .line 2150
    :cond_3
    invoke-virtual {p2}, Ljavax/net/ssl/SSLSocket;->getEnabledCipherSuites()[Ljava/lang/String;

    move-result-object v0

    move-object v1, v0

    goto :goto_0

    .line 2153
    :cond_4
    invoke-virtual {p2}, Ljavax/net/ssl/SSLSocket;->getEnabledProtocols()[Ljava/lang/String;

    move-result-object v0

    goto :goto_1
.end method

.method public final a(Lcom/b/a/n;Lcom/b/a/a/b/c;)Z
    .locals 1

    .prologue
    .line 144
    invoke-virtual {p1, p2}, Lcom/b/a/n;->b(Lcom/b/a/a/b/c;)Z

    move-result v0

    return v0
.end method

.method public final b(Lcom/b/a/n;Lcom/b/a/a;Lcom/b/a/a/b/g;)Ljava/net/Socket;
    .locals 1

    .prologue
    .line 154
    invoke-virtual {p1, p2, p3}, Lcom/b/a/n;->b(Lcom/b/a/a;Lcom/b/a/a/b/g;)Ljava/net/Socket;

    move-result-object v0

    return-object v0
.end method

.method public final b(Lcom/b/a/n;Lcom/b/a/a/b/c;)V
    .locals 0

    .prologue
    .line 158
    invoke-virtual {p1, p2}, Lcom/b/a/n;->a(Lcom/b/a/a/b/c;)V

    .line 159
    return-void
.end method
