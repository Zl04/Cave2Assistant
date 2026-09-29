.class public abstract Lcom/github/kevinsawicki/http/HttpRequest$FlushOperation;
.super Lcom/github/kevinsawicki/http/HttpRequest$Operation;
.source "SourceFile"


# annotations
.annotation system Ldalvik/annotation/EnclosingClass;
    value = Lcom/github/kevinsawicki/http/HttpRequest;
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x40c
    name = "FlushOperation"
.end annotation

.annotation system Ldalvik/annotation/Signature;
    value = {
        "<V:",
        "Ljava/lang/Object;",
        ">",
        "Lcom/github/kevinsawicki/http/HttpRequest$Operation",
        "<TV;>;"
    }
.end annotation


# instance fields
.field private final flushable:Ljava/io/Flushable;


# direct methods
.method protected constructor <init>(Ljava/io/Flushable;)V
    .locals 0

    .prologue
    .line 783
    invoke-direct {p0}, Lcom/github/kevinsawicki/http/HttpRequest$Operation;-><init>()V

    .line 784
    iput-object p1, p0, Lcom/github/kevinsawicki/http/HttpRequest$FlushOperation;->flushable:Ljava/io/Flushable;

    .line 785
    return-void
.end method


# virtual methods
.method protected done()V
    .locals 1
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljava/io/IOException;
        }
    .end annotation

    .prologue
    .line 789
    iget-object v0, p0, Lcom/github/kevinsawicki/http/HttpRequest$FlushOperation;->flushable:Ljava/io/Flushable;

    invoke-interface {v0}, Ljava/io/Flushable;->flush()V

    .line 790
    return-void
.end method
