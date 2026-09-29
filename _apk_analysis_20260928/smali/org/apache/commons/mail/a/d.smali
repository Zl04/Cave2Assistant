.class public Lorg/apache/commons/mail/a/d;
.super Lorg/apache/commons/mail/a/a;
.source "SourceFile"


# instance fields
.field private final a:Ljava/io/File;


# direct methods
.method public constructor <init>()V
    .locals 2

    .prologue
    .line 40
    invoke-direct {p0}, Lorg/apache/commons/mail/a/a;-><init>()V

    .line 41
    new-instance v0, Ljava/io/File;

    const-string v1, "."

    invoke-direct {v0, v1}, Ljava/io/File;-><init>(Ljava/lang/String;)V

    iput-object v0, p0, Lorg/apache/commons/mail/a/d;->a:Ljava/io/File;

    .line 42
    return-void
.end method

.method public constructor <init>(Ljava/io/File;)V
    .locals 0

    .prologue
    .line 50
    invoke-direct {p0}, Lorg/apache/commons/mail/a/a;-><init>()V

    .line 51
    iput-object p1, p0, Lorg/apache/commons/mail/a/d;->a:Ljava/io/File;

    .line 52
    return-void
.end method

.method public constructor <init>(Ljava/io/File;Z)V
    .locals 0

    .prologue
    .line 62
    invoke-direct {p0, p2}, Lorg/apache/commons/mail/a/a;-><init>(Z)V

    .line 63
    iput-object p1, p0, Lorg/apache/commons/mail/a/d;->a:Ljava/io/File;

    .line 64
    return-void
.end method


# virtual methods
.method public b()Ljava/io/File;
    .locals 1

    .prologue
    .line 73
    iget-object v0, p0, Lorg/apache/commons/mail/a/d;->a:Ljava/io/File;

    return-object v0
.end method

.method public resolve(Ljava/lang/String;)Ljavax/activation/DataSource;
    .locals 1
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljava/io/IOException;
        }
    .end annotation

    .prologue
    .line 79
    invoke-virtual {p0}, Lorg/apache/commons/mail/a/d;->a()Z

    move-result v0

    invoke-virtual {p0, p1, v0}, Lorg/apache/commons/mail/a/d;->resolve(Ljava/lang/String;Z)Ljavax/activation/DataSource;

    move-result-object v0

    return-object v0
.end method

.method public resolve(Ljava/lang/String;Z)Ljavax/activation/DataSource;
    .locals 4
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljava/io/IOException;
        }
    .end annotation

    .prologue
    .line 86
    const/4 v1, 0x0

    .line 88
    invoke-virtual {p0, p1}, Lorg/apache/commons/mail/a/d;->a(Ljava/lang/String;)Z

    move-result v0

    if-nez v0, :cond_3

    .line 90
    new-instance v0, Ljava/io/File;

    invoke-direct {v0, p1}, Ljava/io/File;-><init>(Ljava/lang/String;)V

    .line 92
    invoke-virtual {v0}, Ljava/io/File;->isAbsolute()Z

    move-result v2

    if-nez v2, :cond_0

    .line 94
    invoke-virtual {p0}, Lorg/apache/commons/mail/a/d;->b()Ljava/io/File;

    move-result-object v0

    if-eqz v0, :cond_1

    new-instance v0, Ljava/io/File;

    invoke-virtual {p0}, Lorg/apache/commons/mail/a/d;->b()Ljava/io/File;

    move-result-object v2

    invoke-direct {v0, v2, p1}, Ljava/io/File;-><init>(Ljava/io/File;Ljava/lang/String;)V

    .line 97
    :cond_0
    :goto_0
    invoke-virtual {v0}, Ljava/io/File;->exists()Z

    move-result v2

    if-eqz v2, :cond_2

    .line 99
    new-instance v1, Ljavax/activation/FileDataSource;

    invoke-direct {v1, v0}, Ljavax/activation/FileDataSource;-><init>(Ljava/io/File;)V

    move-object v0, v1

    .line 110
    :goto_1
    return-object v0

    .line 94
    :cond_1
    new-instance v0, Ljava/io/File;

    invoke-direct {v0, p1}, Ljava/io/File;-><init>(Ljava/lang/String;)V

    goto :goto_0

    .line 103
    :cond_2
    if-nez p2, :cond_3

    .line 105
    new-instance v1, Ljava/io/IOException;

    new-instance v2, Ljava/lang/StringBuilder;

    invoke-direct {v2}, Ljava/lang/StringBuilder;-><init>()V

    const-string v3, "Cant resolve the following file resource :"

    invoke-virtual {v2, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    invoke-virtual {v0}, Ljava/io/File;->getAbsolutePath()Ljava/lang/String;

    move-result-object v0

    invoke-virtual {v2, v0}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-virtual {v0}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v0

    invoke-direct {v1, v0}, Ljava/io/IOException;-><init>(Ljava/lang/String;)V

    throw v1

    :cond_3
    move-object v0, v1

    goto :goto_1
.end method
