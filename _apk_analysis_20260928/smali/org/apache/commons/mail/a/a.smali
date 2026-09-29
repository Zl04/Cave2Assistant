.class public abstract Lorg/apache/commons/mail/a/a;
.super Ljava/lang/Object;
.source "SourceFile"

# interfaces
.implements Lorg/apache/commons/mail/DataSourceResolver;


# instance fields
.field private final a:Z


# direct methods
.method public constructor <init>()V
    .locals 1

    .prologue
    .line 36
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    .line 37
    const/4 v0, 0x0

    iput-boolean v0, p0, Lorg/apache/commons/mail/a/a;->a:Z

    .line 38
    return-void
.end method

.method public constructor <init>(Z)V
    .locals 0

    .prologue
    .line 46
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    .line 47
    iput-boolean p1, p0, Lorg/apache/commons/mail/a/a;->a:Z

    .line 48
    return-void
.end method


# virtual methods
.method public a()Z
    .locals 1

    .prologue
    .line 57
    iget-boolean v0, p0, Lorg/apache/commons/mail/a/a;->a:Z

    return v0
.end method

.method protected a(Ljava/lang/String;)Z
    .locals 1

    .prologue
    .line 68
    const-string v0, "cid:"

    invoke-virtual {p1, v0}, Ljava/lang/String;->startsWith(Ljava/lang/String;)Z

    move-result v0

    return v0
.end method

.method protected b(Ljava/lang/String;)Z
    .locals 1

    .prologue
    .line 79
    const-string v0, "file:/"

    invoke-virtual {p1, v0}, Ljava/lang/String;->startsWith(Ljava/lang/String;)Z

    move-result v0

    return v0
.end method

.method protected c(Ljava/lang/String;)Z
    .locals 1

    .prologue
    .line 90
    const-string v0, "http://"

    invoke-virtual {p1, v0}, Ljava/lang/String;->startsWith(Ljava/lang/String;)Z

    move-result v0

    if-nez v0, :cond_0

    const-string v0, "https://"

    invoke-virtual {p1, v0}, Ljava/lang/String;->startsWith(Ljava/lang/String;)Z

    move-result v0

    if-eqz v0, :cond_1

    :cond_0
    const/4 v0, 0x1

    :goto_0
    return v0

    :cond_1
    const/4 v0, 0x0

    goto :goto_0
.end method
