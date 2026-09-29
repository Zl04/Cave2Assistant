.class public final Lcom/b/b/n;
.super Ljava/lang/Object;
.source "SourceFile"


# static fields
.field static final a:Ljava/util/logging/Logger;


# direct methods
.method static constructor <clinit>()V
    .locals 1

    .prologue
    .line 39
    const-class v0, Lcom/b/b/n;

    invoke-virtual {v0}, Ljava/lang/Class;->getName()Ljava/lang/String;

    move-result-object v0

    invoke-static {v0}, Ljava/util/logging/Logger;->getLogger(Ljava/lang/String;)Ljava/util/logging/Logger;

    move-result-object v0

    sput-object v0, Lcom/b/b/n;->a:Ljava/util/logging/Logger;

    return-void
.end method

.method private constructor <init>()V
    .locals 0

    .prologue
    .line 41
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    .line 42
    return-void
.end method

.method public static a(Lcom/b/b/w;)Lcom/b/b/g;
    .locals 1

    .prologue
    .line 59
    new-instance v0, Lcom/b/b/r;

    invoke-direct {v0, p0}, Lcom/b/b/r;-><init>(Lcom/b/b/w;)V

    return-object v0
.end method

.method public static a(Lcom/b/b/x;)Lcom/b/b/h;
    .locals 1

    .prologue
    .line 50
    new-instance v0, Lcom/b/b/s;

    invoke-direct {v0, p0}, Lcom/b/b/s;-><init>(Lcom/b/b/x;)V

    return-object v0
.end method

.method public static a(Ljava/net/Socket;)Lcom/b/b/w;
    .locals 3

    .prologue
    .line 115
    if-nez p0, :cond_0

    new-instance v0, Ljava/lang/IllegalArgumentException;

    const-string v1, "socket == null"

    invoke-direct {v0, v1}, Ljava/lang/IllegalArgumentException;-><init>(Ljava/lang/String;)V

    throw v0

    .line 116
    :cond_0
    invoke-static {p0}, Lcom/b/b/n;->c(Ljava/net/Socket;)Lcom/b/b/a;

    move-result-object v0

    .line 117
    invoke-virtual {p0}, Ljava/net/Socket;->getOutputStream()Ljava/io/OutputStream;

    move-result-object v1

    .line 1068
    if-nez v1, :cond_1

    new-instance v0, Ljava/lang/IllegalArgumentException;

    const-string v1, "out == null"

    invoke-direct {v0, v1}, Ljava/lang/IllegalArgumentException;-><init>(Ljava/lang/String;)V

    throw v0

    .line 1071
    :cond_1
    new-instance v2, Lcom/b/b/o;

    invoke-direct {v2, v0, v1}, Lcom/b/b/o;-><init>(Lcom/b/b/y;Ljava/io/OutputStream;)V

    .line 1159
    new-instance v1, Lcom/b/b/b;

    invoke-direct {v1, v0, v2}, Lcom/b/b/b;-><init>(Lcom/b/b/a;Lcom/b/b/w;)V

    .line 118
    return-object v1
.end method

.method static a(Ljava/lang/AssertionError;)Z
    .locals 2

    .prologue
    .line 257
    invoke-virtual {p0}, Ljava/lang/AssertionError;->getCause()Ljava/lang/Throwable;

    move-result-object v0

    if-eqz v0, :cond_0

    invoke-virtual {p0}, Ljava/lang/AssertionError;->getMessage()Ljava/lang/String;

    move-result-object v0

    if-eqz v0, :cond_0

    .line 258
    invoke-virtual {p0}, Ljava/lang/AssertionError;->getMessage()Ljava/lang/String;

    move-result-object v0

    const-string v1, "getsockname failed"

    invoke-virtual {v0, v1}, Ljava/lang/String;->contains(Ljava/lang/CharSequence;)Z

    move-result v0

    if-eqz v0, :cond_0

    const/4 v0, 0x1

    :goto_0
    return v0

    :cond_0
    const/4 v0, 0x0

    .line 257
    goto :goto_0
.end method

.method public static b(Ljava/net/Socket;)Lcom/b/b/x;
    .locals 3

    .prologue
    .line 218
    if-nez p0, :cond_0

    new-instance v0, Ljava/lang/IllegalArgumentException;

    const-string v1, "socket == null"

    invoke-direct {v0, v1}, Ljava/lang/IllegalArgumentException;-><init>(Ljava/lang/String;)V

    throw v0

    .line 219
    :cond_0
    invoke-static {p0}, Lcom/b/b/n;->c(Ljava/net/Socket;)Lcom/b/b/a;

    move-result-object v0

    .line 220
    invoke-virtual {p0}, Ljava/net/Socket;->getInputStream()Ljava/io/InputStream;

    move-result-object v1

    .line 2127
    if-nez v1, :cond_1

    new-instance v0, Ljava/lang/IllegalArgumentException;

    const-string v1, "in == null"

    invoke-direct {v0, v1}, Ljava/lang/IllegalArgumentException;-><init>(Ljava/lang/String;)V

    throw v0

    .line 2130
    :cond_1
    new-instance v2, Lcom/b/b/p;

    invoke-direct {v2, v0, v1}, Lcom/b/b/p;-><init>(Lcom/b/b/y;Ljava/io/InputStream;)V

    .line 2231
    new-instance v1, Lcom/b/b/c;

    invoke-direct {v1, v0, v2}, Lcom/b/b/c;-><init>(Lcom/b/b/a;Lcom/b/b/x;)V

    .line 221
    return-object v1
.end method

.method private static c(Ljava/net/Socket;)Lcom/b/b/a;
    .locals 1

    .prologue
    .line 225
    new-instance v0, Lcom/b/b/q;

    invoke-direct {v0, p0}, Lcom/b/b/q;-><init>(Ljava/net/Socket;)V

    return-object v0
.end method
