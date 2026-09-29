.class public final Lcom/b/a/a/a/a;
.super Ljava/lang/Object;
.source "SourceFile"

# interfaces
.implements Lcom/b/a/af;


# instance fields
.field final a:Lcom/b/a/a/a/i;


# direct methods
.method public constructor <init>(Lcom/b/a/a/a/i;)V
    .locals 0

    .prologue
    .line 48
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    .line 49
    iput-object p1, p0, Lcom/b/a/a/a/a;->a:Lcom/b/a/a/a/i;

    .line 50
    return-void
.end method

.method private static a(Lcom/b/a/as;)Lcom/b/a/as;
    .locals 2

    .prologue
    .line 137
    if-eqz p0, :cond_0

    invoke-virtual {p0}, Lcom/b/a/as;->e()Lcom/b/a/au;

    move-result-object v0

    if-eqz v0, :cond_0

    .line 138
    invoke-virtual {p0}, Lcom/b/a/as;->f()Lcom/b/a/at;

    move-result-object v0

    const/4 v1, 0x0

    invoke-virtual {v0, v1}, Lcom/b/a/at;->a(Lcom/b/a/au;)Lcom/b/a/at;

    move-result-object v0

    invoke-virtual {v0}, Lcom/b/a/at;->a()Lcom/b/a/as;

    move-result-object p0

    :cond_0
    return-object p0
.end method

.method private static a(Ljava/lang/String;)Z
    .locals 1

    .prologue
    .line 257
    const-string v0, "Connection"

    invoke-virtual {v0, p0}, Ljava/lang/String;->equalsIgnoreCase(Ljava/lang/String;)Z

    move-result v0

    if-nez v0, :cond_0

    const-string v0, "Keep-Alive"

    .line 258
    invoke-virtual {v0, p0}, Ljava/lang/String;->equalsIgnoreCase(Ljava/lang/String;)Z

    move-result v0

    if-nez v0, :cond_0

    const-string v0, "Proxy-Authenticate"

    .line 259
    invoke-virtual {v0, p0}, Ljava/lang/String;->equalsIgnoreCase(Ljava/lang/String;)Z

    move-result v0

    if-nez v0, :cond_0

    const-string v0, "Proxy-Authorization"

    .line 260
    invoke-virtual {v0, p0}, Ljava/lang/String;->equalsIgnoreCase(Ljava/lang/String;)Z

    move-result v0

    if-nez v0, :cond_0

    const-string v0, "TE"

    .line 261
    invoke-virtual {v0, p0}, Ljava/lang/String;->equalsIgnoreCase(Ljava/lang/String;)Z

    move-result v0

    if-nez v0, :cond_0

    const-string v0, "Trailers"

    .line 262
    invoke-virtual {v0, p0}, Ljava/lang/String;->equalsIgnoreCase(Ljava/lang/String;)Z

    move-result v0

    if-nez v0, :cond_0

    const-string v0, "Transfer-Encoding"

    .line 263
    invoke-virtual {v0, p0}, Ljava/lang/String;->equalsIgnoreCase(Ljava/lang/String;)Z

    move-result v0

    if-nez v0, :cond_0

    const-string v0, "Upgrade"

    .line 264
    invoke-virtual {v0, p0}, Ljava/lang/String;->equalsIgnoreCase(Ljava/lang/String;)Z

    move-result v0

    if-nez v0, :cond_0

    const/4 v0, 0x1

    :goto_0
    return v0

    :cond_0
    const/4 v0, 0x0

    .line 257
    goto :goto_0
.end method


# virtual methods
.method public final a(Lcom/b/a/ag;)Lcom/b/a/as;
    .locals 12

    .prologue
    const/4 v2, 0x0

    const/4 v1, 0x0

    .line 53
    iget-object v0, p0, Lcom/b/a/a/a/a;->a:Lcom/b/a/a/a/i;

    if-eqz v0, :cond_2

    iget-object v0, p0, Lcom/b/a/a/a/a;->a:Lcom/b/a/a/a/i;

    .line 54
    invoke-interface {v0}, Lcom/b/a/a/a/i;->a()Lcom/b/a/as;

    move-result-object v0

    .line 57
    :goto_0
    invoke-static {}, Ljava/lang/System;->currentTimeMillis()J

    move-result-wide v4

    .line 59
    new-instance v3, Lcom/b/a/a/a/e;

    invoke-interface {p1}, Lcom/b/a/ag;->a()Lcom/b/a/ao;

    move-result-object v6

    invoke-direct {v3, v4, v5, v6, v0}, Lcom/b/a/a/a/e;-><init>(JLcom/b/a/ao;Lcom/b/a/as;)V

    invoke-virtual {v3}, Lcom/b/a/a/a/e;->a()Lcom/b/a/a/a/d;

    move-result-object v3

    .line 60
    iget-object v4, v3, Lcom/b/a/a/a/d;->a:Lcom/b/a/ao;

    .line 61
    iget-object v3, v3, Lcom/b/a/a/a/d;->b:Lcom/b/a/as;

    .line 67
    if-eqz v0, :cond_0

    if-nez v3, :cond_0

    .line 68
    invoke-virtual {v0}, Lcom/b/a/as;->e()Lcom/b/a/au;

    move-result-object v5

    invoke-static {v5}, Lcom/b/a/a/c;->a(Ljava/io/Closeable;)V

    .line 72
    :cond_0
    if-nez v4, :cond_3

    if-nez v3, :cond_3

    .line 73
    new-instance v0, Lcom/b/a/at;

    invoke-direct {v0}, Lcom/b/a/at;-><init>()V

    .line 74
    invoke-interface {p1}, Lcom/b/a/ag;->a()Lcom/b/a/ao;

    move-result-object v1

    invoke-virtual {v0, v1}, Lcom/b/a/at;->a(Lcom/b/a/ao;)Lcom/b/a/at;

    move-result-object v0

    sget-object v1, Lcom/b/a/al;->b:Lcom/b/a/al;

    .line 75
    invoke-virtual {v0, v1}, Lcom/b/a/at;->a(Lcom/b/a/al;)Lcom/b/a/at;

    move-result-object v0

    const/16 v1, 0x1f8

    .line 76
    invoke-virtual {v0, v1}, Lcom/b/a/at;->a(I)Lcom/b/a/at;

    move-result-object v0

    const-string v1, "Unsatisfiable Request (only-if-cached)"

    .line 77
    invoke-virtual {v0, v1}, Lcom/b/a/at;->a(Ljava/lang/String;)Lcom/b/a/at;

    move-result-object v0

    sget-object v1, Lcom/b/a/a/c;->c:Lcom/b/a/au;

    .line 78
    invoke-virtual {v0, v1}, Lcom/b/a/at;->a(Lcom/b/a/au;)Lcom/b/a/at;

    move-result-object v0

    const-wide/16 v2, -0x1

    .line 79
    invoke-virtual {v0, v2, v3}, Lcom/b/a/at;->a(J)Lcom/b/a/at;

    move-result-object v0

    .line 80
    invoke-static {}, Ljava/lang/System;->currentTimeMillis()J

    move-result-wide v2

    invoke-virtual {v0, v2, v3}, Lcom/b/a/at;->b(J)Lcom/b/a/at;

    move-result-object v0

    .line 81
    invoke-virtual {v0}, Lcom/b/a/at;->a()Lcom/b/a/as;

    move-result-object v0

    .line 133
    :cond_1
    :goto_1
    return-object v0

    :cond_2
    move-object v0, v1

    .line 54
    goto :goto_0

    .line 85
    :cond_3
    if-nez v4, :cond_4

    .line 86
    invoke-virtual {v3}, Lcom/b/a/as;->f()Lcom/b/a/at;

    move-result-object v0

    .line 87
    invoke-static {v3}, Lcom/b/a/a/a/a;->a(Lcom/b/a/as;)Lcom/b/a/as;

    move-result-object v1

    invoke-virtual {v0, v1}, Lcom/b/a/at;->b(Lcom/b/a/as;)Lcom/b/a/at;

    move-result-object v0

    .line 88
    invoke-virtual {v0}, Lcom/b/a/at;->a()Lcom/b/a/as;

    move-result-object v0

    goto :goto_1

    .line 93
    :cond_4
    :try_start_0
    invoke-interface {p1, v4}, Lcom/b/a/ag;->a(Lcom/b/a/ao;)Lcom/b/a/as;
    :try_end_0
    .catchall {:try_start_0 .. :try_end_0} :catchall_0

    move-result-object v4

    .line 96
    if-nez v4, :cond_5

    if-eqz v0, :cond_5

    .line 97
    invoke-virtual {v0}, Lcom/b/a/as;->e()Lcom/b/a/au;

    move-result-object v0

    invoke-static {v0}, Lcom/b/a/a/c;->a(Ljava/io/Closeable;)V

    .line 102
    :cond_5
    if-eqz v3, :cond_e

    .line 103
    invoke-virtual {v4}, Lcom/b/a/as;->b()I

    move-result v0

    const/16 v5, 0x130

    if-ne v0, v5, :cond_d

    .line 104
    invoke-virtual {v3}, Lcom/b/a/as;->f()Lcom/b/a/at;

    move-result-object v1

    .line 105
    invoke-virtual {v3}, Lcom/b/a/as;->d()Lcom/b/a/aa;

    move-result-object v5

    invoke-virtual {v4}, Lcom/b/a/as;->d()Lcom/b/a/aa;

    move-result-object v6

    .line 1226
    new-instance v7, Lcom/b/a/ab;

    invoke-direct {v7}, Lcom/b/a/ab;-><init>()V

    .line 1228
    invoke-virtual {v5}, Lcom/b/a/aa;->a()I

    move-result v8

    move v0, v2

    :goto_2
    if-ge v0, v8, :cond_a

    .line 1229
    invoke-virtual {v5, v0}, Lcom/b/a/aa;->a(I)Ljava/lang/String;

    move-result-object v9

    .line 1230
    invoke-virtual {v5, v0}, Lcom/b/a/aa;->b(I)Ljava/lang/String;

    move-result-object v10

    .line 1231
    const-string v11, "Warning"

    invoke-virtual {v11, v9}, Ljava/lang/String;->equalsIgnoreCase(Ljava/lang/String;)Z

    move-result v11

    if-eqz v11, :cond_6

    const-string v11, "1"

    invoke-virtual {v10, v11}, Ljava/lang/String;->startsWith(Ljava/lang/String;)Z

    move-result v11

    if-nez v11, :cond_8

    .line 1234
    :cond_6
    invoke-static {v9}, Lcom/b/a/a/a/a;->a(Ljava/lang/String;)Z

    move-result v11

    if-eqz v11, :cond_7

    invoke-virtual {v6, v9}, Lcom/b/a/aa;->a(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v11

    if-nez v11, :cond_8

    .line 1235
    :cond_7
    sget-object v11, Lcom/b/a/a/a;->a:Lcom/b/a/a/a;

    invoke-virtual {v11, v7, v9, v10}, Lcom/b/a/a/a;->a(Lcom/b/a/ab;Ljava/lang/String;Ljava/lang/String;)V

    .line 1228
    :cond_8
    add-int/lit8 v0, v0, 0x1

    goto :goto_2

    .line 96
    :catchall_0
    move-exception v1

    if-eqz v0, :cond_9

    .line 97
    invoke-virtual {v0}, Lcom/b/a/as;->e()Lcom/b/a/au;

    move-result-object v0

    invoke-static {v0}, Lcom/b/a/a/c;->a(Ljava/io/Closeable;)V

    :cond_9
    throw v1

    .line 1239
    :cond_a
    invoke-virtual {v6}, Lcom/b/a/aa;->a()I

    move-result v5

    move v0, v2

    :goto_3
    if-ge v0, v5, :cond_c

    .line 1240
    invoke-virtual {v6, v0}, Lcom/b/a/aa;->a(I)Ljava/lang/String;

    move-result-object v2

    .line 1241
    const-string v8, "Content-Length"

    invoke-virtual {v8, v2}, Ljava/lang/String;->equalsIgnoreCase(Ljava/lang/String;)Z

    move-result v8

    if-nez v8, :cond_b

    .line 1244
    invoke-static {v2}, Lcom/b/a/a/a/a;->a(Ljava/lang/String;)Z

    move-result v8

    if-eqz v8, :cond_b

    .line 1245
    sget-object v8, Lcom/b/a/a/a;->a:Lcom/b/a/a/a;

    invoke-virtual {v6, v0}, Lcom/b/a/aa;->b(I)Ljava/lang/String;

    move-result-object v9

    invoke-virtual {v8, v7, v2, v9}, Lcom/b/a/a/a;->a(Lcom/b/a/ab;Ljava/lang/String;Ljava/lang/String;)V

    .line 1239
    :cond_b
    add-int/lit8 v0, v0, 0x1

    goto :goto_3

    .line 1249
    :cond_c
    invoke-virtual {v7}, Lcom/b/a/ab;->a()Lcom/b/a/aa;

    move-result-object v0

    .line 105
    invoke-virtual {v1, v0}, Lcom/b/a/at;->a(Lcom/b/a/aa;)Lcom/b/a/at;

    move-result-object v0

    .line 106
    invoke-virtual {v4}, Lcom/b/a/as;->h()J

    move-result-wide v6

    invoke-virtual {v0, v6, v7}, Lcom/b/a/at;->a(J)Lcom/b/a/at;

    move-result-object v0

    .line 107
    invoke-virtual {v4}, Lcom/b/a/as;->i()J

    move-result-wide v6

    invoke-virtual {v0, v6, v7}, Lcom/b/a/at;->b(J)Lcom/b/a/at;

    move-result-object v0

    .line 108
    invoke-static {v3}, Lcom/b/a/a/a/a;->a(Lcom/b/a/as;)Lcom/b/a/as;

    move-result-object v1

    invoke-virtual {v0, v1}, Lcom/b/a/at;->b(Lcom/b/a/as;)Lcom/b/a/at;

    move-result-object v0

    .line 109
    invoke-static {v4}, Lcom/b/a/a/a/a;->a(Lcom/b/a/as;)Lcom/b/a/as;

    move-result-object v1

    invoke-virtual {v0, v1}, Lcom/b/a/at;->a(Lcom/b/a/as;)Lcom/b/a/at;

    move-result-object v0

    .line 110
    invoke-virtual {v0}, Lcom/b/a/at;->a()Lcom/b/a/as;

    move-result-object v0

    .line 111
    invoke-virtual {v4}, Lcom/b/a/as;->e()Lcom/b/a/au;

    move-result-object v1

    invoke-virtual {v1}, Lcom/b/a/au;->close()V

    goto/16 :goto_1

    .line 119
    :cond_d
    invoke-virtual {v3}, Lcom/b/a/as;->e()Lcom/b/a/au;

    move-result-object v0

    invoke-static {v0}, Lcom/b/a/a/c;->a(Ljava/io/Closeable;)V

    .line 123
    :cond_e
    invoke-virtual {v4}, Lcom/b/a/as;->f()Lcom/b/a/at;

    move-result-object v0

    .line 124
    invoke-static {v3}, Lcom/b/a/a/a/a;->a(Lcom/b/a/as;)Lcom/b/a/as;

    move-result-object v2

    invoke-virtual {v0, v2}, Lcom/b/a/at;->b(Lcom/b/a/as;)Lcom/b/a/at;

    move-result-object v0

    .line 125
    invoke-static {v4}, Lcom/b/a/a/a/a;->a(Lcom/b/a/as;)Lcom/b/a/as;

    move-result-object v2

    invoke-virtual {v0, v2}, Lcom/b/a/at;->a(Lcom/b/a/as;)Lcom/b/a/at;

    move-result-object v0

    .line 126
    invoke-virtual {v0}, Lcom/b/a/at;->a()Lcom/b/a/as;

    move-result-object v0

    .line 128
    invoke-static {v0}, Lcom/b/a/a/c/f;->b(Lcom/b/a/as;)Z

    move-result v2

    if-eqz v2, :cond_1

    .line 129
    invoke-virtual {v4}, Lcom/b/a/as;->a()Lcom/b/a/ao;

    move-result-object v2

    iget-object v3, p0, Lcom/b/a/a/a/a;->a:Lcom/b/a/a/a/i;

    .line 2144
    if-nez v3, :cond_10

    .line 3170
    :cond_f
    :goto_4
    if-eqz v1, :cond_1

    .line 3171
    invoke-interface {v1}, Lcom/b/a/a/a/c;->a()Lcom/b/b/w;

    move-result-object v2

    .line 3172
    if-eqz v2, :cond_1

    .line 3174
    invoke-virtual {v0}, Lcom/b/a/as;->e()Lcom/b/a/au;

    move-result-object v3

    invoke-virtual {v3}, Lcom/b/a/au;->c()Lcom/b/b/h;

    move-result-object v3

    .line 3175
    invoke-static {v2}, Lcom/b/b/n;->a(Lcom/b/b/w;)Lcom/b/b/g;

    move-result-object v2

    .line 3177
    new-instance v4, Lcom/b/a/a/a/b;

    invoke-direct {v4, p0, v3, v1, v2}, Lcom/b/a/a/a/b;-><init>(Lcom/b/a/a/a/a;Lcom/b/b/h;Lcom/b/a/a/a/c;Lcom/b/b/g;)V

    .line 3219
    invoke-virtual {v0}, Lcom/b/a/as;->f()Lcom/b/a/at;

    move-result-object v1

    new-instance v2, Lcom/b/a/a/c/i;

    .line 3220
    invoke-virtual {v0}, Lcom/b/a/as;->d()Lcom/b/a/aa;

    move-result-object v0

    invoke-static {v4}, Lcom/b/b/n;->a(Lcom/b/b/x;)Lcom/b/b/h;

    move-result-object v3

    invoke-direct {v2, v0, v3}, Lcom/b/a/a/c/i;-><init>(Lcom/b/a/aa;Lcom/b/b/h;)V

    invoke-virtual {v1, v2}, Lcom/b/a/at;->a(Lcom/b/a/au;)Lcom/b/a/at;

    move-result-object v0

    .line 3221
    invoke-virtual {v0}, Lcom/b/a/at;->a()Lcom/b/a/as;

    move-result-object v0

    goto/16 :goto_1

    .line 2147
    :cond_10
    invoke-static {v0, v2}, Lcom/b/a/a/a/d;->a(Lcom/b/a/as;Lcom/b/a/ao;)Z

    move-result v4

    if-nez v4, :cond_11

    .line 2148
    invoke-virtual {v2}, Lcom/b/a/ao;->b()Ljava/lang/String;

    move-result-object v2

    .line 3020
    const-string v3, "POST"

    invoke-virtual {v2, v3}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v3

    if-nez v3, :cond_f

    const-string v3, "PATCH"

    .line 3021
    invoke-virtual {v2, v3}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v3

    if-nez v3, :cond_f

    const-string v3, "PUT"

    .line 3022
    invoke-virtual {v2, v3}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v3

    if-nez v3, :cond_f

    const-string v3, "DELETE"

    .line 3023
    invoke-virtual {v2, v3}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v3

    if-nez v3, :cond_f

    const-string v3, "MOVE"

    .line 3024
    invoke-virtual {v2, v3}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    goto :goto_4

    .line 2159
    :cond_11
    invoke-interface {v3}, Lcom/b/a/a/a/i;->b()Lcom/b/a/a/a/c;

    move-result-object v1

    goto :goto_4
.end method
