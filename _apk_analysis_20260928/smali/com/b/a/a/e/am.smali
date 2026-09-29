.class public final Lcom/b/a/a/e/am;
.super Ljava/io/IOException;
.source "SourceFile"


# instance fields
.field public final a:Lcom/b/a/a/e/b;


# direct methods
.method public constructor <init>(Lcom/b/a/a/e/b;)V
    .locals 2

    .prologue
    .line 25
    new-instance v0, Ljava/lang/StringBuilder;

    const-string v1, "stream was reset: "

    invoke-direct {v0, v1}, Ljava/lang/StringBuilder;-><init>(Ljava/lang/String;)V

    invoke-virtual {v0, p1}, Ljava/lang/StringBuilder;->append(Ljava/lang/Object;)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-virtual {v0}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v0

    invoke-direct {p0, v0}, Ljava/io/IOException;-><init>(Ljava/lang/String;)V

    .line 26
    iput-object p1, p0, Lcom/b/a/a/e/am;->a:Lcom/b/a/a/e/b;

    .line 27
    return-void
.end method
