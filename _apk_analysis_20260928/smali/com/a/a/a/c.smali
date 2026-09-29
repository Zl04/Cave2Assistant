.class public final Lcom/a/a/a/c;
.super Ljava/lang/Thread;
.source "SourceFile"


# instance fields
.field private final a:Ljava/io/BufferedReader;

.field private b:Ljava/util/List;
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "Ljava/util/List",
            "<",
            "Ljava/lang/String;",
            ">;"
        }
    .end annotation
.end field

.field private c:Lcom/a/a/a/d;


# direct methods
.method public constructor <init>(Ljava/io/InputStream;Ljava/util/List;)V
    .locals 2
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "(",
            "Ljava/io/InputStream;",
            "Ljava/util/List",
            "<",
            "Ljava/lang/String;",
            ">;)V"
        }
    .end annotation

    .prologue
    .line 64
    invoke-direct {p0}, Ljava/lang/Thread;-><init>()V

    .line 65
    new-instance v0, Ljava/io/BufferedReader;

    new-instance v1, Ljava/io/InputStreamReader;

    invoke-direct {v1, p1}, Ljava/io/InputStreamReader;-><init>(Ljava/io/InputStream;)V

    invoke-direct {v0, v1}, Ljava/io/BufferedReader;-><init>(Ljava/io/Reader;)V

    iput-object v0, p0, Lcom/a/a/a/c;->a:Ljava/io/BufferedReader;

    .line 66
    iput-object p2, p0, Lcom/a/a/a/c;->b:Ljava/util/List;

    .line 67
    return-void
.end method


# virtual methods
.method public final run()V
    .locals 2

    .prologue
    .line 90
    :cond_0
    :goto_0
    :try_start_0
    iget-object v0, p0, Lcom/a/a/a/c;->a:Ljava/io/BufferedReader;

    invoke-virtual {v0}, Ljava/io/BufferedReader;->readLine()Ljava/lang/String;

    move-result-object v0

    if-eqz v0, :cond_2

    .line 91
    iget-object v1, p0, Lcom/a/a/a/c;->b:Ljava/util/List;

    if-eqz v1, :cond_1

    .line 92
    iget-object v1, p0, Lcom/a/a/a/c;->b:Ljava/util/List;

    invoke-interface {v1, v0}, Ljava/util/List;->add(Ljava/lang/Object;)Z

    .line 94
    :cond_1
    iget-object v0, p0, Lcom/a/a/a/c;->c:Lcom/a/a/a/d;
    :try_end_0
    .catch Ljava/io/IOException; {:try_start_0 .. :try_end_0} :catch_0

    if-eqz v0, :cond_0

    goto :goto_0

    :catch_0
    move-exception v0

    .line 104
    :cond_2
    :try_start_1
    iget-object v0, p0, Lcom/a/a/a/c;->a:Ljava/io/BufferedReader;

    invoke-virtual {v0}, Ljava/io/BufferedReader;->close()V
    :try_end_1
    .catch Ljava/io/IOException; {:try_start_1 .. :try_end_1} :catch_1

    .line 107
    :goto_1
    return-void

    :catch_1
    move-exception v0

    goto :goto_1
.end method
