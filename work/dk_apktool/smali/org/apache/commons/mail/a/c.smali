.class public Lorg/apache/commons/mail/a/c;
.super Lorg/apache/commons/mail/a/a;
.source "SourceFile"


# instance fields
.field private final a:[Lorg/apache/commons/mail/DataSourceResolver;


# direct methods
.method public constructor <init>([Lorg/apache/commons/mail/DataSourceResolver;)V
    .locals 3

    .prologue
    const/4 v2, 0x0

    .line 42
    invoke-direct {p0}, Lorg/apache/commons/mail/a/a;-><init>()V

    .line 43
    array-length v0, p1

    new-array v0, v0, [Lorg/apache/commons/mail/DataSourceResolver;

    iput-object v0, p0, Lorg/apache/commons/mail/a/c;->a:[Lorg/apache/commons/mail/DataSourceResolver;

    .line 44
    iget-object v0, p0, Lorg/apache/commons/mail/a/c;->a:[Lorg/apache/commons/mail/DataSourceResolver;

    array-length v1, p1

    invoke-static {p1, v2, v0, v2, v1}, Ljava/lang/System;->arraycopy(Ljava/lang/Object;ILjava/lang/Object;II)V

    .line 45
    return-void
.end method

.method public constructor <init>([Lorg/apache/commons/mail/DataSourceResolver;Z)V
    .locals 3

    .prologue
    const/4 v2, 0x0

    .line 55
    invoke-direct {p0, p2}, Lorg/apache/commons/mail/a/a;-><init>(Z)V

    .line 56
    array-length v0, p1

    new-array v0, v0, [Lorg/apache/commons/mail/DataSourceResolver;

    iput-object v0, p0, Lorg/apache/commons/mail/a/c;->a:[Lorg/apache/commons/mail/DataSourceResolver;

    .line 57
    iget-object v0, p0, Lorg/apache/commons/mail/a/c;->a:[Lorg/apache/commons/mail/DataSourceResolver;

    array-length v1, p1

    invoke-static {p1, v2, v0, v2, v1}, Ljava/lang/System;->arraycopy(Ljava/lang/Object;ILjava/lang/Object;II)V

    .line 58
    return-void
.end method


# virtual methods
.method public b()[Lorg/apache/commons/mail/DataSourceResolver;
    .locals 4

    .prologue
    const/4 v3, 0x0

    .line 68
    iget-object v0, p0, Lorg/apache/commons/mail/a/c;->a:[Lorg/apache/commons/mail/DataSourceResolver;

    array-length v0, v0

    new-array v0, v0, [Lorg/apache/commons/mail/DataSourceResolver;

    .line 69
    iget-object v1, p0, Lorg/apache/commons/mail/a/c;->a:[Lorg/apache/commons/mail/DataSourceResolver;

    iget-object v2, p0, Lorg/apache/commons/mail/a/c;->a:[Lorg/apache/commons/mail/DataSourceResolver;

    array-length v2, v2

    invoke-static {v1, v3, v0, v3, v2}, Ljava/lang/System;->arraycopy(Ljava/lang/Object;ILjava/lang/Object;II)V

    .line 70
    return-object v0
.end method

.method public resolve(Ljava/lang/String;)Ljavax/activation/DataSource;
    .locals 3
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljava/io/IOException;
        }
    .end annotation

    .prologue
    .line 76
    const/4 v0, 0x1

    invoke-virtual {p0, p1, v0}, Lorg/apache/commons/mail/a/c;->resolve(Ljava/lang/String;Z)Ljavax/activation/DataSource;

    move-result-object v0

    .line 78
    invoke-virtual {p0}, Lorg/apache/commons/mail/a/c;->a()Z

    move-result v1

    if-nez v1, :cond_0

    if-eqz v0, :cond_1

    .line 80
    :cond_0
    return-object v0

    .line 82
    :cond_1
    new-instance v0, Ljava/io/IOException;

    new-instance v1, Ljava/lang/StringBuilder;

    invoke-direct {v1}, Ljava/lang/StringBuilder;-><init>()V

    const-string v2, "The following resource was not found : "

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1, p1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v1

    invoke-direct {v0, v1}, Ljava/io/IOException;-><init>(Ljava/lang/String;)V

    throw v0
.end method

.method public resolve(Ljava/lang/String;Z)Ljavax/activation/DataSource;
    .locals 3
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljava/io/IOException;
        }
    .end annotation

    .prologue
    .line 89
    const/4 v0, 0x0

    :goto_0
    invoke-virtual {p0}, Lorg/apache/commons/mail/a/c;->b()[Lorg/apache/commons/mail/DataSourceResolver;

    move-result-object v1

    array-length v1, v1

    if-ge v0, v1, :cond_1

    .line 91
    invoke-virtual {p0}, Lorg/apache/commons/mail/a/c;->b()[Lorg/apache/commons/mail/DataSourceResolver;

    move-result-object v1

    aget-object v1, v1, v0

    .line 92
    invoke-interface {v1, p1, p2}, Lorg/apache/commons/mail/DataSourceResolver;->resolve(Ljava/lang/String;Z)Ljavax/activation/DataSource;

    move-result-object v1

    .line 94
    if-eqz v1, :cond_0

    move-object v0, v1

    .line 102
    :goto_1
    return-object v0

    .line 89
    :cond_0
    add-int/lit8 v0, v0, 0x1

    goto :goto_0

    .line 100
    :cond_1
    if-eqz p2, :cond_2

    .line 102
    const/4 v0, 0x0

    goto :goto_1

    .line 104
    :cond_2
    new-instance v0, Ljava/io/IOException;

    new-instance v1, Ljava/lang/StringBuilder;

    invoke-direct {v1}, Ljava/lang/StringBuilder;-><init>()V

    const-string v2, "The following resource was not found : "

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1, p1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v1

    invoke-direct {v0, v1}, Ljava/io/IOException;-><init>(Ljava/lang/String;)V

    throw v0
.end method
