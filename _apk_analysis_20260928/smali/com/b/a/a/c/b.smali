.class public final Lcom/b/a/a/c/b;
.super Ljava/lang/Object;
.source "SourceFile"

# interfaces
.implements Lcom/b/a/af;


# instance fields
.field private final a:Z


# direct methods
.method public constructor <init>(Z)V
    .locals 0

    .prologue
    .line 33
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    .line 34
    iput-boolean p1, p0, Lcom/b/a/a/c/b;->a:Z

    .line 35
    return-void
.end method


# virtual methods
.method public final a(Lcom/b/a/ag;)Lcom/b/a/as;
    .locals 8

    .prologue
    .line 38
    move-object v0, p1

    check-cast v0, Lcom/b/a/a/c/h;

    invoke-virtual {v0}, Lcom/b/a/a/c/h;->c()Lcom/b/a/a/c/c;

    move-result-object v1

    move-object v0, p1

    .line 39
    check-cast v0, Lcom/b/a/a/c/h;

    invoke-virtual {v0}, Lcom/b/a/a/c/h;->b()Lcom/b/a/a/b/g;

    move-result-object v2

    .line 40
    invoke-interface {p1}, Lcom/b/a/ag;->a()Lcom/b/a/ao;

    move-result-object v3

    .line 42
    invoke-static {}, Ljava/lang/System;->currentTimeMillis()J

    move-result-wide v4

    .line 43
    invoke-interface {v1, v3}, Lcom/b/a/a/c/c;->a(Lcom/b/a/ao;)V

    .line 45
    const/4 v0, 0x0

    .line 46
    invoke-virtual {v3}, Lcom/b/a/ao;->b()Ljava/lang/String;

    move-result-object v6

    invoke-static {v6}, Lcom/b/a/a/c/g;->b(Ljava/lang/String;)Z

    move-result v6

    if-eqz v6, :cond_1

    invoke-virtual {v3}, Lcom/b/a/ao;->d()Lcom/b/a/aq;

    move-result-object v6

    if-eqz v6, :cond_1

    .line 50
    const-string v6, "100-continue"

    const-string v7, "Expect"

    invoke-virtual {v3, v7}, Lcom/b/a/ao;->a(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v7

    invoke-virtual {v6, v7}, Ljava/lang/String;->equalsIgnoreCase(Ljava/lang/String;)Z

    move-result v6

    if-eqz v6, :cond_0

    .line 51
    invoke-interface {v1}, Lcom/b/a/a/c/c;->a()V

    .line 52
    const/4 v0, 0x1

    invoke-interface {v1, v0}, Lcom/b/a/a/c/c;->a(Z)Lcom/b/a/at;

    move-result-object v0

    .line 56
    :cond_0
    if-nez v0, :cond_1

    .line 57
    invoke-virtual {v3}, Lcom/b/a/ao;->d()Lcom/b/a/aq;

    move-result-object v6

    invoke-virtual {v6}, Lcom/b/a/aq;->b()J

    move-result-wide v6

    invoke-interface {v1, v3, v6, v7}, Lcom/b/a/a/c/c;->a(Lcom/b/a/ao;J)Lcom/b/b/w;

    move-result-object v6

    .line 58
    invoke-static {v6}, Lcom/b/b/n;->a(Lcom/b/b/w;)Lcom/b/b/g;

    move-result-object v6

    .line 59
    invoke-virtual {v3}, Lcom/b/a/ao;->d()Lcom/b/a/aq;

    move-result-object v7

    invoke-virtual {v7, v6}, Lcom/b/a/aq;->a(Lcom/b/b/g;)V

    .line 60
    invoke-interface {v6}, Lcom/b/b/g;->close()V

    .line 64
    :cond_1
    invoke-interface {v1}, Lcom/b/a/a/c/c;->b()V

    .line 66
    if-nez v0, :cond_2

    .line 67
    const/4 v0, 0x0

    invoke-interface {v1, v0}, Lcom/b/a/a/c/c;->a(Z)Lcom/b/a/at;

    move-result-object v0

    .line 71
    :cond_2
    invoke-virtual {v0, v3}, Lcom/b/a/at;->a(Lcom/b/a/ao;)Lcom/b/a/at;

    move-result-object v0

    .line 72
    invoke-virtual {v2}, Lcom/b/a/a/b/g;->b()Lcom/b/a/a/b/c;

    move-result-object v3

    invoke-virtual {v3}, Lcom/b/a/a/b/c;->c()Lcom/b/a/z;

    move-result-object v3

    invoke-virtual {v0, v3}, Lcom/b/a/at;->a(Lcom/b/a/z;)Lcom/b/a/at;

    move-result-object v0

    .line 73
    invoke-virtual {v0, v4, v5}, Lcom/b/a/at;->a(J)Lcom/b/a/at;

    move-result-object v0

    .line 74
    invoke-static {}, Ljava/lang/System;->currentTimeMillis()J

    move-result-wide v4

    invoke-virtual {v0, v4, v5}, Lcom/b/a/at;->b(J)Lcom/b/a/at;

    move-result-object v0

    .line 75
    invoke-virtual {v0}, Lcom/b/a/at;->a()Lcom/b/a/as;

    move-result-object v0

    .line 77
    invoke-virtual {v0}, Lcom/b/a/as;->b()I

    move-result v3

    .line 78
    iget-boolean v4, p0, Lcom/b/a/a/c/b;->a:Z

    if-eqz v4, :cond_6

    const/16 v4, 0x65

    if-ne v3, v4, :cond_6

    .line 80
    invoke-virtual {v0}, Lcom/b/a/as;->f()Lcom/b/a/at;

    move-result-object v0

    sget-object v1, Lcom/b/a/a/c;->c:Lcom/b/a/au;

    .line 81
    invoke-virtual {v0, v1}, Lcom/b/a/at;->a(Lcom/b/a/au;)Lcom/b/a/at;

    move-result-object v0

    .line 82
    invoke-virtual {v0}, Lcom/b/a/at;->a()Lcom/b/a/as;

    move-result-object v0

    .line 89
    :goto_0
    const-string v1, "close"

    invoke-virtual {v0}, Lcom/b/a/as;->a()Lcom/b/a/ao;

    move-result-object v4

    const-string v5, "Connection"

    invoke-virtual {v4, v5}, Lcom/b/a/ao;->a(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v4

    invoke-virtual {v1, v4}, Ljava/lang/String;->equalsIgnoreCase(Ljava/lang/String;)Z

    move-result v1

    if-nez v1, :cond_3

    const-string v1, "close"

    const-string v4, "Connection"

    .line 90
    invoke-virtual {v0, v4}, Lcom/b/a/as;->a(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v4

    invoke-virtual {v1, v4}, Ljava/lang/String;->equalsIgnoreCase(Ljava/lang/String;)Z

    move-result v1

    if-eqz v1, :cond_4

    .line 91
    :cond_3
    invoke-virtual {v2}, Lcom/b/a/a/b/g;->d()V

    .line 94
    :cond_4
    const/16 v1, 0xcc

    if-eq v3, v1, :cond_5

    const/16 v1, 0xcd

    if-ne v3, v1, :cond_7

    :cond_5
    invoke-virtual {v0}, Lcom/b/a/as;->e()Lcom/b/a/au;

    move-result-object v1

    invoke-virtual {v1}, Lcom/b/a/au;->b()J

    move-result-wide v4

    const-wide/16 v6, 0x0

    cmp-long v1, v4, v6

    if-lez v1, :cond_7

    .line 95
    new-instance v1, Ljava/net/ProtocolException;

    new-instance v2, Ljava/lang/StringBuilder;

    const-string v4, "HTTP "

    invoke-direct {v2, v4}, Ljava/lang/StringBuilder;-><init>(Ljava/lang/String;)V

    invoke-virtual {v2, v3}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v2

    const-string v3, " had non-zero Content-Length: "

    invoke-virtual {v2, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    .line 96
    invoke-virtual {v0}, Lcom/b/a/as;->e()Lcom/b/a/au;

    move-result-object v0

    invoke-virtual {v0}, Lcom/b/a/au;->b()J

    move-result-wide v4

    invoke-virtual {v2, v4, v5}, Ljava/lang/StringBuilder;->append(J)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-virtual {v0}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v0

    invoke-direct {v1, v0}, Ljava/net/ProtocolException;-><init>(Ljava/lang/String;)V

    throw v1

    .line 84
    :cond_6
    invoke-virtual {v0}, Lcom/b/a/as;->f()Lcom/b/a/at;

    move-result-object v4

    .line 85
    invoke-interface {v1, v0}, Lcom/b/a/a/c/c;->a(Lcom/b/a/as;)Lcom/b/a/au;

    move-result-object v0

    invoke-virtual {v4, v0}, Lcom/b/a/at;->a(Lcom/b/a/au;)Lcom/b/a/at;

    move-result-object v0

    .line 86
    invoke-virtual {v0}, Lcom/b/a/at;->a()Lcom/b/a/as;

    move-result-object v0

    goto :goto_0

    .line 99
    :cond_7
    return-object v0
.end method
