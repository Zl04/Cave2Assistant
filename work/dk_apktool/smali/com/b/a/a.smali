.class public final Lcom/b/a/a;
.super Ljava/lang/Object;
.source "SourceFile"


# instance fields
.field final a:Lcom/b/a/ac;

.field final b:Lcom/b/a/v;

.field final c:Ljavax/net/SocketFactory;

.field final d:Lcom/b/a/b;

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

.field final g:Ljava/net/ProxySelector;

.field final h:Ljava/net/Proxy;

.field final i:Ljavax/net/ssl/SSLSocketFactory;

.field final j:Ljavax/net/ssl/HostnameVerifier;

.field final k:Lcom/b/a/i;


# direct methods
.method public constructor <init>(Ljava/lang/String;ILcom/b/a/v;Ljavax/net/SocketFactory;Ljavax/net/ssl/SSLSocketFactory;Ljavax/net/ssl/HostnameVerifier;Lcom/b/a/i;Lcom/b/a/b;Ljava/net/Proxy;Ljava/util/List;Ljava/util/List;Ljava/net/ProxySelector;)V
    .locals 5
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "(",
            "Ljava/lang/String;",
            "I",
            "Lcom/b/a/v;",
            "Ljavax/net/SocketFactory;",
            "Ljavax/net/ssl/SSLSocketFactory;",
            "Ljavax/net/ssl/HostnameVerifier;",
            "Lcom/b/a/i;",
            "Lcom/b/a/b;",
            "Ljava/net/Proxy;",
            "Ljava/util/List",
            "<",
            "Lcom/b/a/al;",
            ">;",
            "Ljava/util/List",
            "<",
            "Lcom/b/a/p;",
            ">;",
            "Ljava/net/ProxySelector;",
            ")V"
        }
    .end annotation

    .prologue
    .line 53
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    .line 54
    new-instance v2, Lcom/b/a/ad;

    invoke-direct {v2}, Lcom/b/a/ad;-><init>()V

    if-eqz p5, :cond_1

    const-string v1, "https"

    .line 1965
    :goto_0
    const-string v3, "http"

    invoke-virtual {v1, v3}, Ljava/lang/String;->equalsIgnoreCase(Ljava/lang/String;)Z

    move-result v3

    if-eqz v3, :cond_2

    .line 1966
    const-string v1, "http"

    iput-object v1, v2, Lcom/b/a/ad;->a:Ljava/lang/String;

    .line 56
    :goto_1
    invoke-virtual {v2, p1}, Lcom/b/a/ad;->a(Ljava/lang/String;)Lcom/b/a/ad;

    move-result-object v1

    .line 2014
    if-lez p2, :cond_0

    const v2, 0xffff

    if-le p2, v2, :cond_4

    :cond_0
    new-instance v1, Ljava/lang/IllegalArgumentException;

    new-instance v2, Ljava/lang/StringBuilder;

    const-string v3, "unexpected port: "

    invoke-direct {v2, v3}, Ljava/lang/StringBuilder;-><init>(Ljava/lang/String;)V

    invoke-virtual {v2, p2}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v2

    invoke-virtual {v2}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v2

    invoke-direct {v1, v2}, Ljava/lang/IllegalArgumentException;-><init>(Ljava/lang/String;)V

    throw v1

    .line 54
    :cond_1
    const-string v1, "http"

    goto :goto_0

    .line 1967
    :cond_2
    const-string v3, "https"

    invoke-virtual {v1, v3}, Ljava/lang/String;->equalsIgnoreCase(Ljava/lang/String;)Z

    move-result v3

    if-eqz v3, :cond_3

    .line 1968
    const-string v1, "https"

    iput-object v1, v2, Lcom/b/a/ad;->a:Ljava/lang/String;

    goto :goto_1

    .line 1970
    :cond_3
    new-instance v2, Ljava/lang/IllegalArgumentException;

    new-instance v3, Ljava/lang/StringBuilder;

    const-string v4, "unexpected scheme: "

    invoke-direct {v3, v4}, Ljava/lang/StringBuilder;-><init>(Ljava/lang/String;)V

    invoke-virtual {v3, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v1

    invoke-direct {v2, v1}, Ljava/lang/IllegalArgumentException;-><init>(Ljava/lang/String;)V

    throw v2

    .line 2015
    :cond_4
    iput p2, v1, Lcom/b/a/ad;->e:I

    .line 58
    invoke-virtual {v1}, Lcom/b/a/ad;->b()Lcom/b/a/ac;

    move-result-object v1

    iput-object v1, p0, Lcom/b/a/a;->a:Lcom/b/a/ac;

    .line 60
    if-nez p3, :cond_5

    new-instance v1, Ljava/lang/NullPointerException;

    const-string v2, "dns == null"

    invoke-direct {v1, v2}, Ljava/lang/NullPointerException;-><init>(Ljava/lang/String;)V

    throw v1

    .line 61
    :cond_5
    iput-object p3, p0, Lcom/b/a/a;->b:Lcom/b/a/v;

    .line 63
    if-nez p4, :cond_6

    new-instance v1, Ljava/lang/NullPointerException;

    const-string v2, "socketFactory == null"

    invoke-direct {v1, v2}, Ljava/lang/NullPointerException;-><init>(Ljava/lang/String;)V

    throw v1

    .line 64
    :cond_6
    iput-object p4, p0, Lcom/b/a/a;->c:Ljavax/net/SocketFactory;

    .line 66
    if-nez p8, :cond_7

    .line 67
    new-instance v1, Ljava/lang/NullPointerException;

    const-string v2, "proxyAuthenticator == null"

    invoke-direct {v1, v2}, Ljava/lang/NullPointerException;-><init>(Ljava/lang/String;)V

    throw v1

    .line 69
    :cond_7
    iput-object p8, p0, Lcom/b/a/a;->d:Lcom/b/a/b;

    .line 71
    if-nez p10, :cond_8

    new-instance v1, Ljava/lang/NullPointerException;

    const-string v2, "protocols == null"

    invoke-direct {v1, v2}, Ljava/lang/NullPointerException;-><init>(Ljava/lang/String;)V

    throw v1

    .line 72
    :cond_8
    invoke-static {p10}, Lcom/b/a/a/c;->a(Ljava/util/List;)Ljava/util/List;

    move-result-object v1

    iput-object v1, p0, Lcom/b/a/a;->e:Ljava/util/List;

    .line 74
    if-nez p11, :cond_9

    new-instance v1, Ljava/lang/NullPointerException;

    const-string v2, "connectionSpecs == null"

    invoke-direct {v1, v2}, Ljava/lang/NullPointerException;-><init>(Ljava/lang/String;)V

    throw v1

    .line 75
    :cond_9
    invoke-static/range {p11 .. p11}, Lcom/b/a/a/c;->a(Ljava/util/List;)Ljava/util/List;

    move-result-object v1

    iput-object v1, p0, Lcom/b/a/a;->f:Ljava/util/List;

    .line 77
    if-nez p12, :cond_a

    new-instance v1, Ljava/lang/NullPointerException;

    const-string v2, "proxySelector == null"

    invoke-direct {v1, v2}, Ljava/lang/NullPointerException;-><init>(Ljava/lang/String;)V

    throw v1

    .line 78
    :cond_a
    move-object/from16 v0, p12

    iput-object v0, p0, Lcom/b/a/a;->g:Ljava/net/ProxySelector;

    .line 80
    iput-object p9, p0, Lcom/b/a/a;->h:Ljava/net/Proxy;

    .line 81
    iput-object p5, p0, Lcom/b/a/a;->i:Ljavax/net/ssl/SSLSocketFactory;

    .line 82
    iput-object p6, p0, Lcom/b/a/a;->j:Ljavax/net/ssl/HostnameVerifier;

    .line 83
    iput-object p7, p0, Lcom/b/a/a;->k:Lcom/b/a/i;

    .line 84
    return-void
.end method


# virtual methods
.method public final a()Lcom/b/a/ac;
    .locals 1

    .prologue
    .line 91
    iget-object v0, p0, Lcom/b/a/a;->a:Lcom/b/a/ac;

    return-object v0
.end method

.method public final b()Lcom/b/a/v;
    .locals 1

    .prologue
    .line 96
    iget-object v0, p0, Lcom/b/a/a;->b:Lcom/b/a/v;

    return-object v0
.end method

.method public final c()Ljavax/net/SocketFactory;
    .locals 1

    .prologue
    .line 101
    iget-object v0, p0, Lcom/b/a/a;->c:Ljavax/net/SocketFactory;

    return-object v0
.end method

.method public final d()Lcom/b/a/b;
    .locals 1

    .prologue
    .line 106
    iget-object v0, p0, Lcom/b/a/a;->d:Lcom/b/a/b;

    return-object v0
.end method

.method public final e()Ljava/util/List;
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
    .line 114
    iget-object v0, p0, Lcom/b/a/a;->e:Ljava/util/List;

    return-object v0
.end method

.method public final equals(Ljava/lang/Object;)Z
    .locals 3

    .prologue
    const/4 v0, 0x0

    .line 153
    instance-of v1, p1, Lcom/b/a/a;

    if-eqz v1, :cond_0

    .line 154
    check-cast p1, Lcom/b/a/a;

    .line 155
    iget-object v1, p0, Lcom/b/a/a;->a:Lcom/b/a/ac;

    iget-object v2, p1, Lcom/b/a/a;->a:Lcom/b/a/ac;

    invoke-virtual {v1, v2}, Lcom/b/a/ac;->equals(Ljava/lang/Object;)Z

    move-result v1

    if-eqz v1, :cond_0

    iget-object v1, p0, Lcom/b/a/a;->b:Lcom/b/a/v;

    iget-object v2, p1, Lcom/b/a/a;->b:Lcom/b/a/v;

    .line 156
    invoke-virtual {v1, v2}, Ljava/lang/Object;->equals(Ljava/lang/Object;)Z

    move-result v1

    if-eqz v1, :cond_0

    iget-object v1, p0, Lcom/b/a/a;->d:Lcom/b/a/b;

    iget-object v2, p1, Lcom/b/a/a;->d:Lcom/b/a/b;

    .line 157
    invoke-virtual {v1, v2}, Ljava/lang/Object;->equals(Ljava/lang/Object;)Z

    move-result v1

    if-eqz v1, :cond_0

    iget-object v1, p0, Lcom/b/a/a;->e:Ljava/util/List;

    iget-object v2, p1, Lcom/b/a/a;->e:Ljava/util/List;

    .line 158
    invoke-interface {v1, v2}, Ljava/util/List;->equals(Ljava/lang/Object;)Z

    move-result v1

    if-eqz v1, :cond_0

    iget-object v1, p0, Lcom/b/a/a;->f:Ljava/util/List;

    iget-object v2, p1, Lcom/b/a/a;->f:Ljava/util/List;

    .line 159
    invoke-interface {v1, v2}, Ljava/util/List;->equals(Ljava/lang/Object;)Z

    move-result v1

    if-eqz v1, :cond_0

    iget-object v1, p0, Lcom/b/a/a;->g:Ljava/net/ProxySelector;

    iget-object v2, p1, Lcom/b/a/a;->g:Ljava/net/ProxySelector;

    .line 160
    invoke-virtual {v1, v2}, Ljava/lang/Object;->equals(Ljava/lang/Object;)Z

    move-result v1

    if-eqz v1, :cond_0

    iget-object v1, p0, Lcom/b/a/a;->h:Ljava/net/Proxy;

    iget-object v2, p1, Lcom/b/a/a;->h:Ljava/net/Proxy;

    .line 161
    invoke-static {v1, v2}, Lcom/b/a/a/c;->a(Ljava/lang/Object;Ljava/lang/Object;)Z

    move-result v1

    if-eqz v1, :cond_0

    iget-object v1, p0, Lcom/b/a/a;->i:Ljavax/net/ssl/SSLSocketFactory;

    iget-object v2, p1, Lcom/b/a/a;->i:Ljavax/net/ssl/SSLSocketFactory;

    .line 162
    invoke-static {v1, v2}, Lcom/b/a/a/c;->a(Ljava/lang/Object;Ljava/lang/Object;)Z

    move-result v1

    if-eqz v1, :cond_0

    iget-object v1, p0, Lcom/b/a/a;->j:Ljavax/net/ssl/HostnameVerifier;

    iget-object v2, p1, Lcom/b/a/a;->j:Ljavax/net/ssl/HostnameVerifier;

    .line 163
    invoke-static {v1, v2}, Lcom/b/a/a/c;->a(Ljava/lang/Object;Ljava/lang/Object;)Z

    move-result v1

    if-eqz v1, :cond_0

    iget-object v1, p0, Lcom/b/a/a;->k:Lcom/b/a/i;

    iget-object v2, p1, Lcom/b/a/a;->k:Lcom/b/a/i;

    .line 164
    invoke-static {v1, v2}, Lcom/b/a/a/c;->a(Ljava/lang/Object;Ljava/lang/Object;)Z

    move-result v1

    if-eqz v1, :cond_0

    const/4 v0, 0x1

    .line 166
    :cond_0
    return v0
.end method

.method public final f()Ljava/util/List;
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
    .line 118
    iget-object v0, p0, Lcom/b/a/a;->f:Ljava/util/List;

    return-object v0
.end method

.method public final g()Ljava/net/ProxySelector;
    .locals 1

    .prologue
    .line 126
    iget-object v0, p0, Lcom/b/a/a;->g:Ljava/net/ProxySelector;

    return-object v0
.end method

.method public final h()Ljava/net/Proxy;
    .locals 1

    .prologue
    .line 134
    iget-object v0, p0, Lcom/b/a/a;->h:Ljava/net/Proxy;

    return-object v0
.end method

.method public final hashCode()I
    .locals 3

    .prologue
    const/4 v1, 0x0

    .line 171
    iget-object v0, p0, Lcom/b/a/a;->a:Lcom/b/a/ac;

    invoke-virtual {v0}, Lcom/b/a/ac;->hashCode()I

    move-result v0

    add-int/lit16 v0, v0, 0x20f

    .line 172
    mul-int/lit8 v0, v0, 0x1f

    iget-object v2, p0, Lcom/b/a/a;->b:Lcom/b/a/v;

    invoke-virtual {v2}, Ljava/lang/Object;->hashCode()I

    move-result v2

    add-int/2addr v0, v2

    .line 173
    mul-int/lit8 v0, v0, 0x1f

    iget-object v2, p0, Lcom/b/a/a;->d:Lcom/b/a/b;

    invoke-virtual {v2}, Ljava/lang/Object;->hashCode()I

    move-result v2

    add-int/2addr v0, v2

    .line 174
    mul-int/lit8 v0, v0, 0x1f

    iget-object v2, p0, Lcom/b/a/a;->e:Ljava/util/List;

    invoke-interface {v2}, Ljava/util/List;->hashCode()I

    move-result v2

    add-int/2addr v0, v2

    .line 175
    mul-int/lit8 v0, v0, 0x1f

    iget-object v2, p0, Lcom/b/a/a;->f:Ljava/util/List;

    invoke-interface {v2}, Ljava/util/List;->hashCode()I

    move-result v2

    add-int/2addr v0, v2

    .line 176
    mul-int/lit8 v0, v0, 0x1f

    iget-object v2, p0, Lcom/b/a/a;->g:Ljava/net/ProxySelector;

    invoke-virtual {v2}, Ljava/lang/Object;->hashCode()I

    move-result v2

    add-int/2addr v0, v2

    .line 177
    mul-int/lit8 v2, v0, 0x1f

    iget-object v0, p0, Lcom/b/a/a;->h:Ljava/net/Proxy;

    if-eqz v0, :cond_1

    iget-object v0, p0, Lcom/b/a/a;->h:Ljava/net/Proxy;

    invoke-virtual {v0}, Ljava/net/Proxy;->hashCode()I

    move-result v0

    :goto_0
    add-int/2addr v0, v2

    .line 178
    mul-int/lit8 v2, v0, 0x1f

    iget-object v0, p0, Lcom/b/a/a;->i:Ljavax/net/ssl/SSLSocketFactory;

    if-eqz v0, :cond_2

    iget-object v0, p0, Lcom/b/a/a;->i:Ljavax/net/ssl/SSLSocketFactory;

    invoke-virtual {v0}, Ljava/lang/Object;->hashCode()I

    move-result v0

    :goto_1
    add-int/2addr v0, v2

    .line 179
    mul-int/lit8 v2, v0, 0x1f

    iget-object v0, p0, Lcom/b/a/a;->j:Ljavax/net/ssl/HostnameVerifier;

    if-eqz v0, :cond_3

    iget-object v0, p0, Lcom/b/a/a;->j:Ljavax/net/ssl/HostnameVerifier;

    invoke-virtual {v0}, Ljava/lang/Object;->hashCode()I

    move-result v0

    :goto_2
    add-int/2addr v0, v2

    .line 180
    mul-int/lit8 v0, v0, 0x1f

    iget-object v2, p0, Lcom/b/a/a;->k:Lcom/b/a/i;

    if-eqz v2, :cond_0

    iget-object v1, p0, Lcom/b/a/a;->k:Lcom/b/a/i;

    invoke-virtual {v1}, Lcom/b/a/i;->hashCode()I

    move-result v1

    :cond_0
    add-int/2addr v0, v1

    .line 181
    return v0

    :cond_1
    move v0, v1

    .line 177
    goto :goto_0

    :cond_2
    move v0, v1

    .line 178
    goto :goto_1

    :cond_3
    move v0, v1

    .line 179
    goto :goto_2
.end method

.method public final i()Ljavax/net/ssl/SSLSocketFactory;
    .locals 1

    .prologue
    .line 139
    iget-object v0, p0, Lcom/b/a/a;->i:Ljavax/net/ssl/SSLSocketFactory;

    return-object v0
.end method

.method public final j()Ljavax/net/ssl/HostnameVerifier;
    .locals 1

    .prologue
    .line 144
    iget-object v0, p0, Lcom/b/a/a;->j:Ljavax/net/ssl/HostnameVerifier;

    return-object v0
.end method

.method public final k()Lcom/b/a/i;
    .locals 1

    .prologue
    .line 149
    iget-object v0, p0, Lcom/b/a/a;->k:Lcom/b/a/i;

    return-object v0
.end method

.method public final toString()Ljava/lang/String;
    .locals 3

    .prologue
    .line 185
    new-instance v0, Ljava/lang/StringBuilder;

    const-string v1, "Address{"

    invoke-direct {v0, v1}, Ljava/lang/StringBuilder;-><init>(Ljava/lang/String;)V

    .line 186
    iget-object v1, p0, Lcom/b/a/a;->a:Lcom/b/a/ac;

    .line 2481
    iget-object v1, v1, Lcom/b/a/ac;->b:Ljava/lang/String;

    .line 187
    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    const-string v1, ":"

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    iget-object v1, p0, Lcom/b/a/a;->a:Lcom/b/a/ac;

    .line 2497
    iget v1, v1, Lcom/b/a/ac;->c:I

    .line 187
    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v0

    .line 189
    iget-object v1, p0, Lcom/b/a/a;->h:Ljava/net/Proxy;

    if-eqz v1, :cond_0

    .line 190
    const-string v1, ", proxy="

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    iget-object v2, p0, Lcom/b/a/a;->h:Ljava/net/Proxy;

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/Object;)Ljava/lang/StringBuilder;

    .line 195
    :goto_0
    const-string v1, "}"

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    .line 196
    invoke-virtual {v0}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v0

    return-object v0

    .line 192
    :cond_0
    const-string v1, ", proxySelector="

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    iget-object v2, p0, Lcom/b/a/a;->g:Ljava/net/ProxySelector;

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/Object;)Ljava/lang/StringBuilder;

    goto :goto_0
.end method
