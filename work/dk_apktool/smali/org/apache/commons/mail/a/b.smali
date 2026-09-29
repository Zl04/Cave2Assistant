.class public Lorg/apache/commons/mail/a/b;
.super Lorg/apache/commons/mail/a/a;
.source "SourceFile"


# instance fields
.field private final a:Ljava/lang/String;


# direct methods
.method public constructor <init>()V
    .locals 1

    .prologue
    .line 41
    invoke-direct {p0}, Lorg/apache/commons/mail/a/a;-><init>()V

    .line 42
    const-string v0, "/"

    iput-object v0, p0, Lorg/apache/commons/mail/a/b;->a:Ljava/lang/String;

    .line 43
    return-void
.end method

.method public constructor <init>(Ljava/lang/String;)V
    .locals 2

    .prologue
    .line 51
    invoke-direct {p0}, Lorg/apache/commons/mail/a/a;-><init>()V

    .line 52
    const-string v0, "/"

    invoke-virtual {p1, v0}, Ljava/lang/String;->endsWith(Ljava/lang/String;)Z

    move-result v0

    if-eqz v0, :cond_0

    :goto_0
    iput-object p1, p0, Lorg/apache/commons/mail/a/b;->a:Ljava/lang/String;

    .line 53
    return-void

    .line 52
    :cond_0
    new-instance v0, Ljava/lang/StringBuilder;

    invoke-direct {v0}, Ljava/lang/StringBuilder;-><init>()V

    invoke-virtual {v0, p1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    const-string v1, "/"

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-virtual {v0}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object p1

    goto :goto_0
.end method

.method public constructor <init>(Ljava/lang/String;Z)V
    .locals 2

    .prologue
    .line 63
    invoke-direct {p0, p2}, Lorg/apache/commons/mail/a/a;-><init>(Z)V

    .line 64
    const-string v0, "/"

    invoke-virtual {p1, v0}, Ljava/lang/String;->endsWith(Ljava/lang/String;)Z

    move-result v0

    if-eqz v0, :cond_0

    :goto_0
    iput-object p1, p0, Lorg/apache/commons/mail/a/b;->a:Ljava/lang/String;

    .line 65
    return-void

    .line 64
    :cond_0
    new-instance v0, Ljava/lang/StringBuilder;

    invoke-direct {v0}, Ljava/lang/StringBuilder;-><init>()V

    invoke-virtual {v0, p1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    const-string v1, "/"

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-virtual {v0}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object p1

    goto :goto_0
.end method

.method private d(Ljava/lang/String;)Ljava/lang/String;
    .locals 3

    .prologue
    .line 134
    new-instance v0, Ljava/lang/StringBuilder;

    invoke-direct {v0}, Ljava/lang/StringBuilder;-><init>()V

    invoke-virtual {p0}, Lorg/apache/commons/mail/a/b;->b()Ljava/lang/String;

    move-result-object v1

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-virtual {v0, p1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-virtual {v0}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v0

    const-string v1, "//"

    const-string v2, "/"

    invoke-virtual {v0, v1, v2}, Ljava/lang/String;->replaceAll(Ljava/lang/String;Ljava/lang/String;)Ljava/lang/String;

    move-result-object v0

    return-object v0
.end method


# virtual methods
.method public b()Ljava/lang/String;
    .locals 1

    .prologue
    .line 72
    iget-object v0, p0, Lorg/apache/commons/mail/a/b;->a:Ljava/lang/String;

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
    .line 78
    invoke-virtual {p0}, Lorg/apache/commons/mail/a/b;->a()Z

    move-result v0

    invoke-virtual {p0, p1, v0}, Lorg/apache/commons/mail/a/b;->resolve(Ljava/lang/String;Z)Ljavax/activation/DataSource;

    move-result-object v0

    return-object v0
.end method

.method public resolve(Ljava/lang/String;Z)Ljavax/activation/DataSource;
    .locals 5
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljava/io/IOException;
        }
    .end annotation

    .prologue
    const/4 v1, 0x0

    .line 84
    .line 88
    :try_start_0
    invoke-virtual {p0, p1}, Lorg/apache/commons/mail/a/b;->a(Ljava/lang/String;)Z

    move-result v0

    if-nez v0, :cond_2

    invoke-virtual {p0, p1}, Lorg/apache/commons/mail/a/b;->c(Ljava/lang/String;)Z

    move-result v0

    if-nez v0, :cond_2

    .line 90
    invoke-static {}, Ljavax/activation/FileTypeMap;->getDefaultFileTypeMap()Ljavax/activation/FileTypeMap;

    move-result-object v0

    invoke-virtual {v0, p1}, Ljavax/activation/FileTypeMap;->getContentType(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v2

    .line 91
    invoke-direct {p0, p1}, Lorg/apache/commons/mail/a/b;->d(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v3

    .line 92
    const-class v0, Lorg/apache/commons/mail/a/b;

    invoke-virtual {v0, v3}, Ljava/lang/Class;->getResourceAsStream(Ljava/lang/String;)Ljava/io/InputStream;

    move-result-object v4

    .line 94
    if-eqz v4, :cond_1

    .line 96
    new-instance v0, Ljavax/mail/util/ByteArrayDataSource;

    invoke-direct {v0, v4, v2}, Ljavax/mail/util/ByteArrayDataSource;-><init>(Ljava/io/InputStream;Ljava/lang/String;)V

    .line 99
    const-class v2, Lorg/apache/commons/mail/a/b;

    invoke-virtual {v2, v3}, Ljava/lang/Class;->getResource(Ljava/lang/String;)Ljava/net/URL;

    move-result-object v2

    invoke-virtual {v2}, Ljava/net/URL;->toString()Ljava/lang/String;

    move-result-object v2

    invoke-virtual {v0, v2}, Ljavax/mail/util/ByteArrayDataSource;->setName(Ljava/lang/String;)V

    :goto_0
    move-object v1, v0

    .line 119
    :cond_0
    return-object v1

    .line 104
    :cond_1
    if-nez p2, :cond_0

    .line 108
    new-instance v0, Ljava/io/IOException;

    new-instance v2, Ljava/lang/StringBuilder;

    invoke-direct {v2}, Ljava/lang/StringBuilder;-><init>()V

    const-string v3, "The following class path resource was not found : "

    invoke-virtual {v2, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    invoke-virtual {v2, p1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    invoke-virtual {v2}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v2

    invoke-direct {v0, v2}, Ljava/io/IOException;-><init>(Ljava/lang/String;)V

    throw v0
    :try_end_0
    .catch Ljava/io/IOException; {:try_start_0 .. :try_end_0} :catch_0

    .line 115
    :catch_0
    move-exception v0

    .line 117
    if-nez p2, :cond_0

    .line 121
    throw v0

    :cond_2
    move-object v0, v1

    goto :goto_0
.end method
