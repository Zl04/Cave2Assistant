.class public Lorg/apache/commons/mail/a/e;
.super Lorg/apache/commons/mail/a/a;
.source "SourceFile"


# instance fields
.field private final a:Ljava/net/URL;


# direct methods
.method public constructor <init>(Ljava/net/URL;)V
    .locals 0

    .prologue
    .line 43
    invoke-direct {p0}, Lorg/apache/commons/mail/a/a;-><init>()V

    .line 44
    iput-object p1, p0, Lorg/apache/commons/mail/a/e;->a:Ljava/net/URL;

    .line 45
    return-void
.end method

.method public constructor <init>(Ljava/net/URL;Z)V
    .locals 0

    .prologue
    .line 55
    invoke-direct {p0, p2}, Lorg/apache/commons/mail/a/a;-><init>(Z)V

    .line 56
    iput-object p1, p0, Lorg/apache/commons/mail/a/e;->a:Ljava/net/URL;

    .line 57
    return-void
.end method


# virtual methods
.method public b()Ljava/net/URL;
    .locals 1

    .prologue
    .line 66
    iget-object v0, p0, Lorg/apache/commons/mail/a/e;->a:Ljava/net/URL;

    return-object v0
.end method

.method protected d(Ljava/lang/String;)Ljava/net/URL;
    .locals 4
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljava/net/MalformedURLException;
        }
    .end annotation

    .prologue
    .line 113
    iget-object v0, p0, Lorg/apache/commons/mail/a/e;->a:Ljava/net/URL;

    if-nez v0, :cond_0

    .line 115
    new-instance v0, Ljava/net/URL;

    invoke-direct {v0, p1}, Ljava/net/URL;-><init>(Ljava/lang/String;)V

    .line 130
    :goto_0
    return-object v0

    .line 119
    :cond_0
    if-eqz p1, :cond_1

    invoke-virtual {p1}, Ljava/lang/String;->length()I

    move-result v0

    if-nez v0, :cond_2

    .line 121
    :cond_1
    new-instance v0, Ljava/lang/IllegalArgumentException;

    const-string v1, "No resource defined"

    invoke-direct {v0, v1}, Ljava/lang/IllegalArgumentException;-><init>(Ljava/lang/String;)V

    throw v0

    .line 125
    :cond_2
    invoke-virtual {p0, p1}, Lorg/apache/commons/mail/a/e;->b(Ljava/lang/String;)Z

    move-result v0

    if-nez v0, :cond_3

    invoke-virtual {p0, p1}, Lorg/apache/commons/mail/a/e;->c(Ljava/lang/String;)Z

    move-result v0

    if-eqz v0, :cond_4

    .line 127
    :cond_3
    new-instance v0, Ljava/net/URL;

    invoke-direct {v0, p1}, Ljava/net/URL;-><init>(Ljava/lang/String;)V

    goto :goto_0

    .line 130
    :cond_4
    new-instance v0, Ljava/net/URL;

    invoke-virtual {p0}, Lorg/apache/commons/mail/a/e;->b()Ljava/net/URL;

    move-result-object v1

    const-string v2, "&amp;"

    const-string v3, "&"

    invoke-virtual {p1, v2, v3}, Ljava/lang/String;->replaceAll(Ljava/lang/String;Ljava/lang/String;)Ljava/lang/String;

    move-result-object v2

    invoke-direct {v0, v1, v2}, Ljava/net/URL;-><init>(Ljava/net/URL;Ljava/lang/String;)V

    goto :goto_0
.end method

.method public resolve(Ljava/lang/String;)Ljavax/activation/DataSource;
    .locals 1
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljava/io/IOException;
        }
    .end annotation

    .prologue
    .line 72
    invoke-virtual {p0}, Lorg/apache/commons/mail/a/e;->a()Z

    move-result v0

    invoke-virtual {p0, p1, v0}, Lorg/apache/commons/mail/a/e;->resolve(Ljava/lang/String;Z)Ljavax/activation/DataSource;

    move-result-object v0

    return-object v0
.end method

.method public resolve(Ljava/lang/String;Z)Ljavax/activation/DataSource;
    .locals 3
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljava/io/IOException;
        }
    .end annotation

    .prologue
    const/4 v1, 0x0

    .line 78
    .line 82
    :try_start_0
    invoke-virtual {p0, p1}, Lorg/apache/commons/mail/a/e;->a(Ljava/lang/String;)Z

    move-result v0

    if-nez v0, :cond_1

    .line 84
    invoke-virtual {p0, p1}, Lorg/apache/commons/mail/a/e;->d(Ljava/lang/String;)Ljava/net/URL;

    move-result-object v2

    .line 85
    new-instance v0, Ljavax/activation/URLDataSource;

    invoke-direct {v0, v2}, Ljavax/activation/URLDataSource;-><init>(Ljava/net/URL;)V

    .line 86
    invoke-interface {v0}, Ljavax/activation/DataSource;->getInputStream()Ljava/io/InputStream;
    :try_end_0
    .catch Ljava/io/IOException; {:try_start_0 .. :try_end_0} :catch_0

    .line 95
    :goto_0
    return-object v0

    .line 91
    :catch_0
    move-exception v0

    .line 93
    if-eqz p2, :cond_0

    move-object v0, v1

    .line 95
    goto :goto_0

    .line 97
    :cond_0
    throw v0

    :cond_1
    move-object v0, v1

    goto :goto_0
.end method
