.class public abstract Lcom/github/kevinsawicki/http/HttpRequest$Operation;
.super Ljava/lang/Object;
.source "SourceFile"

# interfaces
.implements Ljava/util/concurrent/Callable;


# annotations
.annotation system Ldalvik/annotation/EnclosingClass;
    value = Lcom/github/kevinsawicki/http/HttpRequest;
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x40c
    name = "Operation"
.end annotation

.annotation system Ldalvik/annotation/Signature;
    value = {
        "<V:",
        "Ljava/lang/Object;",
        ">",
        "Ljava/lang/Object;",
        "Ljava/util/concurrent/Callable",
        "<TV;>;"
    }
.end annotation


# direct methods
.method protected constructor <init>()V
    .locals 0

    .prologue
    .line 690
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method


# virtual methods
.method public call()Ljava/lang/Object;
    .locals 3
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "()TV;"
        }
    .end annotation

    .annotation system Ldalvik/annotation/Throws;
        value = {
            Lcom/github/kevinsawicki/http/HttpRequest$HttpRequestException;
        }
    .end annotation

    .prologue
    const/4 v1, 0x1

    .line 709
    const/4 v2, 0x0

    .line 711
    :try_start_0
    invoke-virtual {p0}, Lcom/github/kevinsawicki/http/HttpRequest$Operation;->run()Ljava/lang/Object;
    :try_end_0
    .catch Lcom/github/kevinsawicki/http/HttpRequest$HttpRequestException; {:try_start_0 .. :try_end_0} :catch_1
    .catch Ljava/io/IOException; {:try_start_0 .. :try_end_0} :catch_2
    .catchall {:try_start_0 .. :try_end_0} :catchall_1

    move-result-object v0

    .line 720
    :try_start_1
    invoke-virtual {p0}, Lcom/github/kevinsawicki/http/HttpRequest$Operation;->done()V
    :try_end_1
    .catch Ljava/io/IOException; {:try_start_1 .. :try_end_1} :catch_0

    .line 724
    return-object v0

    .line 721
    :catch_0
    move-exception v0

    .line 723
    new-instance v1, Lcom/github/kevinsawicki/http/HttpRequest$HttpRequestException;

    invoke-direct {v1, v0}, Lcom/github/kevinsawicki/http/HttpRequest$HttpRequestException;-><init>(Ljava/io/IOException;)V

    throw v1

    .line 712
    :catch_1
    move-exception v0

    .line 714
    :try_start_2
    throw v0
    :try_end_2
    .catchall {:try_start_2 .. :try_end_2} :catchall_0

    .line 719
    :catchall_0
    move-exception v0

    .line 720
    :goto_0
    :try_start_3
    invoke-virtual {p0}, Lcom/github/kevinsawicki/http/HttpRequest$Operation;->done()V
    :try_end_3
    .catch Ljava/io/IOException; {:try_start_3 .. :try_end_3} :catch_3

    .line 724
    :cond_0
    throw v0

    .line 715
    :catch_2
    move-exception v0

    .line 717
    :try_start_4
    new-instance v2, Lcom/github/kevinsawicki/http/HttpRequest$HttpRequestException;

    invoke-direct {v2, v0}, Lcom/github/kevinsawicki/http/HttpRequest$HttpRequestException;-><init>(Ljava/io/IOException;)V

    throw v2
    :try_end_4
    .catchall {:try_start_4 .. :try_end_4} :catchall_0

    .line 721
    :catch_3
    move-exception v2

    .line 722
    if-nez v1, :cond_0

    .line 723
    new-instance v0, Lcom/github/kevinsawicki/http/HttpRequest$HttpRequestException;

    invoke-direct {v0, v2}, Lcom/github/kevinsawicki/http/HttpRequest$HttpRequestException;-><init>(Ljava/io/IOException;)V

    throw v0

    .line 719
    :catchall_1
    move-exception v0

    move v1, v2

    goto :goto_0
.end method

.method protected abstract done()V
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljava/io/IOException;
        }
    .end annotation
.end method

.method protected abstract run()Ljava/lang/Object;
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "()TV;"
        }
    .end annotation

    .annotation system Ldalvik/annotation/Throws;
        value = {
            Lcom/github/kevinsawicki/http/HttpRequest$HttpRequestException;,
            Ljava/io/IOException;
        }
    .end annotation
.end method
