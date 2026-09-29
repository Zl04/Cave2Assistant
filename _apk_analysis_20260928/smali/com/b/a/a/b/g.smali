.class public final Lcom/b/a/a/b/g;
.super Ljava/lang/Object;
.source "SourceFile"


# static fields
.field static final synthetic b:Z


# instance fields
.field public final a:Lcom/b/a/a;

.field private c:Lcom/b/a/aw;

.field private final d:Lcom/b/a/n;

.field private final e:Ljava/lang/Object;

.field private final f:Lcom/b/a/a/b/f;

.field private g:I

.field private h:Lcom/b/a/a/b/c;

.field private i:Z

.field private j:Z

.field private k:Lcom/b/a/a/c/c;


# direct methods
.method static constructor <clinit>()V
    .locals 1

    .prologue
    .line 72
    const-class v0, Lcom/b/a/a/b/g;

    invoke-virtual {v0}, Ljava/lang/Class;->desiredAssertionStatus()Z

    move-result v0

    if-nez v0, :cond_0

    const/4 v0, 0x1

    :goto_0
    sput-boolean v0, Lcom/b/a/a/b/g;->b:Z

    return-void

    :cond_0
    const/4 v0, 0x0

    goto :goto_0
.end method

.method public constructor <init>(Lcom/b/a/n;Lcom/b/a/a;Ljava/lang/Object;)V
    .locals 2

    .prologue
    .line 86
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    .line 87
    iput-object p1, p0, Lcom/b/a/a/b/g;->d:Lcom/b/a/n;

    .line 88
    iput-object p2, p0, Lcom/b/a/a/b/g;->a:Lcom/b/a/a;

    .line 89
    new-instance v0, Lcom/b/a/a/b/f;

    invoke-direct {p0}, Lcom/b/a/a/b/g;->f()Lcom/b/a/a/b/d;

    move-result-object v1

    invoke-direct {v0, p2, v1}, Lcom/b/a/a/b/f;-><init>(Lcom/b/a/a;Lcom/b/a/a/b/d;)V

    iput-object v0, p0, Lcom/b/a/a/b/g;->f:Lcom/b/a/a/b/f;

    .line 90
    iput-object p3, p0, Lcom/b/a/a/b/g;->e:Ljava/lang/Object;

    .line 91
    return-void
.end method

.method private a(IIIZ)Lcom/b/a/a/b/c;
    .locals 6

    .prologue
    .line 149
    iget-object v1, p0, Lcom/b/a/a/b/g;->d:Lcom/b/a/n;

    monitor-enter v1

    .line 150
    :try_start_0
    iget-boolean v0, p0, Lcom/b/a/a/b/g;->i:Z

    if-eqz v0, :cond_0

    new-instance v0, Ljava/lang/IllegalStateException;

    const-string v2, "released"

    invoke-direct {v0, v2}, Ljava/lang/IllegalStateException;-><init>(Ljava/lang/String;)V

    throw v0

    .line 167
    :catchall_0
    move-exception v0

    monitor-exit v1
    :try_end_0
    .catchall {:try_start_0 .. :try_end_0} :catchall_0

    throw v0

    .line 151
    :cond_0
    :try_start_1
    iget-object v0, p0, Lcom/b/a/a/b/g;->k:Lcom/b/a/a/c/c;

    if-eqz v0, :cond_1

    new-instance v0, Ljava/lang/IllegalStateException;

    const-string v2, "codec != null"

    invoke-direct {v0, v2}, Ljava/lang/IllegalStateException;-><init>(Ljava/lang/String;)V

    throw v0

    .line 152
    :cond_1
    iget-boolean v0, p0, Lcom/b/a/a/b/g;->j:Z

    if-eqz v0, :cond_2

    new-instance v0, Ljava/io/IOException;

    const-string v2, "Canceled"

    invoke-direct {v0, v2}, Ljava/io/IOException;-><init>(Ljava/lang/String;)V

    throw v0

    .line 155
    :cond_2
    iget-object v0, p0, Lcom/b/a/a/b/g;->h:Lcom/b/a/a/b/c;

    .line 156
    if-eqz v0, :cond_3

    iget-boolean v2, v0, Lcom/b/a/a/b/c;->a:Z

    if-nez v2, :cond_3

    .line 157
    monitor-exit v1

    .line 203
    :goto_0
    return-object v0

    .line 161
    :cond_3
    sget-object v0, Lcom/b/a/a/a;->a:Lcom/b/a/a/a;

    iget-object v2, p0, Lcom/b/a/a/b/g;->d:Lcom/b/a/n;

    iget-object v3, p0, Lcom/b/a/a/b/g;->a:Lcom/b/a/a;

    invoke-virtual {v0, v2, v3, p0}, Lcom/b/a/a/a;->a(Lcom/b/a/n;Lcom/b/a/a;Lcom/b/a/a/b/g;)Lcom/b/a/a/b/c;

    .line 162
    iget-object v0, p0, Lcom/b/a/a/b/g;->h:Lcom/b/a/a/b/c;

    if-eqz v0, :cond_4

    .line 163
    iget-object v0, p0, Lcom/b/a/a/b/g;->h:Lcom/b/a/a/b/c;

    monitor-exit v1

    goto :goto_0

    .line 166
    :cond_4
    iget-object v0, p0, Lcom/b/a/a/b/g;->c:Lcom/b/a/aw;

    .line 167
    monitor-exit v1
    :try_end_1
    .catchall {:try_start_1 .. :try_end_1} :catchall_0

    .line 170
    if-nez v0, :cond_5

    .line 171
    iget-object v0, p0, Lcom/b/a/a/b/g;->f:Lcom/b/a/a/b/f;

    invoke-virtual {v0}, Lcom/b/a/a/b/f;->b()Lcom/b/a/aw;

    move-result-object v0

    .line 177
    :cond_5
    iget-object v2, p0, Lcom/b/a/a/b/g;->d:Lcom/b/a/n;

    monitor-enter v2

    .line 178
    :try_start_2
    iput-object v0, p0, Lcom/b/a/a/b/g;->c:Lcom/b/a/aw;

    .line 179
    const/4 v1, 0x0

    iput v1, p0, Lcom/b/a/a/b/g;->g:I

    .line 180
    new-instance v1, Lcom/b/a/a/b/c;

    iget-object v3, p0, Lcom/b/a/a/b/g;->d:Lcom/b/a/n;

    invoke-direct {v1, v3, v0}, Lcom/b/a/a/b/c;-><init>(Lcom/b/a/n;Lcom/b/a/aw;)V

    .line 181
    invoke-virtual {p0, v1}, Lcom/b/a/a/b/g;->a(Lcom/b/a/a/b/c;)V

    .line 182
    iget-boolean v0, p0, Lcom/b/a/a/b/g;->j:Z

    if-eqz v0, :cond_6

    new-instance v0, Ljava/io/IOException;

    const-string v1, "Canceled"

    invoke-direct {v0, v1}, Ljava/io/IOException;-><init>(Ljava/lang/String;)V

    throw v0

    .line 183
    :catchall_1
    move-exception v0

    monitor-exit v2
    :try_end_2
    .catchall {:try_start_2 .. :try_end_2} :catchall_1

    throw v0

    :cond_6
    :try_start_3
    monitor-exit v2
    :try_end_3
    .catchall {:try_start_3 .. :try_end_3} :catchall_1

    .line 186
    invoke-virtual {v1, p1, p2, p3, p4}, Lcom/b/a/a/b/c;->a(IIIZ)V

    .line 187
    invoke-direct {p0}, Lcom/b/a/a/b/g;->f()Lcom/b/a/a/b/d;

    move-result-object v0

    invoke-virtual {v1}, Lcom/b/a/a/b/c;->a()Lcom/b/a/aw;

    move-result-object v2

    invoke-virtual {v0, v2}, Lcom/b/a/a/b/d;->b(Lcom/b/a/aw;)V

    .line 189
    const/4 v0, 0x0

    .line 190
    iget-object v2, p0, Lcom/b/a/a/b/g;->d:Lcom/b/a/n;

    monitor-enter v2

    .line 192
    :try_start_4
    sget-object v3, Lcom/b/a/a/a;->a:Lcom/b/a/a/a;

    iget-object v4, p0, Lcom/b/a/a/b/g;->d:Lcom/b/a/n;

    invoke-virtual {v3, v4, v1}, Lcom/b/a/a/a;->b(Lcom/b/a/n;Lcom/b/a/a/b/c;)V

    .line 196
    invoke-virtual {v1}, Lcom/b/a/a/b/c;->d()Z

    move-result v3

    if-eqz v3, :cond_7

    .line 197
    sget-object v0, Lcom/b/a/a/a;->a:Lcom/b/a/a/a;

    iget-object v1, p0, Lcom/b/a/a/b/g;->d:Lcom/b/a/n;

    iget-object v3, p0, Lcom/b/a/a/b/g;->a:Lcom/b/a/a;

    invoke-virtual {v0, v1, v3, p0}, Lcom/b/a/a/a;->b(Lcom/b/a/n;Lcom/b/a/a;Lcom/b/a/a/b/g;)Ljava/net/Socket;

    move-result-object v0

    .line 198
    iget-object v1, p0, Lcom/b/a/a/b/g;->h:Lcom/b/a/a/b/c;

    move-object v5, v0

    move-object v0, v1

    move-object v1, v5

    .line 200
    :goto_1
    monitor-exit v2
    :try_end_4
    .catchall {:try_start_4 .. :try_end_4} :catchall_2

    .line 201
    invoke-static {v1}, Lcom/b/a/a/c;->a(Ljava/net/Socket;)V

    goto :goto_0

    .line 200
    :catchall_2
    move-exception v0

    :try_start_5
    monitor-exit v2
    :try_end_5
    .catchall {:try_start_5 .. :try_end_5} :catchall_2

    throw v0

    :cond_7
    move-object v5, v0

    move-object v0, v1

    move-object v1, v5

    goto :goto_1
.end method

.method private a(IIIZZ)Lcom/b/a/a/b/c;
    .locals 3

    .prologue
    .line 121
    :goto_0
    invoke-direct {p0, p1, p2, p3, p4}, Lcom/b/a/a/b/g;->a(IIIZ)Lcom/b/a/a/b/c;

    move-result-object v0

    .line 125
    iget-object v1, p0, Lcom/b/a/a/b/g;->d:Lcom/b/a/n;

    monitor-enter v1

    .line 126
    :try_start_0
    iget v2, v0, Lcom/b/a/a/b/c;->b:I

    if-nez v2, :cond_1

    .line 127
    monitor-exit v1

    .line 138
    :cond_0
    return-object v0

    .line 129
    :cond_1
    monitor-exit v1
    :try_end_0
    .catchall {:try_start_0 .. :try_end_0} :catchall_0

    .line 133
    invoke-virtual {v0, p5}, Lcom/b/a/a/b/c;->a(Z)Z

    move-result v1

    if-nez v1, :cond_0

    .line 134
    invoke-virtual {p0}, Lcom/b/a/a/b/g;->d()V

    goto :goto_0

    .line 129
    :catchall_0
    move-exception v0

    :try_start_1
    monitor-exit v1
    :try_end_1
    .catchall {:try_start_1 .. :try_end_1} :catchall_0

    throw v0
.end method

.method private a(ZZZ)Ljava/net/Socket;
    .locals 4

    .prologue
    const/4 v2, 0x1

    const/4 v1, 0x0

    .line 259
    sget-boolean v0, Lcom/b/a/a/b/g;->b:Z

    if-nez v0, :cond_0

    iget-object v0, p0, Lcom/b/a/a/b/g;->d:Lcom/b/a/n;

    invoke-static {v0}, Ljava/lang/Thread;->holdsLock(Ljava/lang/Object;)Z

    move-result v0

    if-nez v0, :cond_0

    new-instance v0, Ljava/lang/AssertionError;

    invoke-direct {v0}, Ljava/lang/AssertionError;-><init>()V

    throw v0

    .line 261
    :cond_0
    if-eqz p3, :cond_1

    .line 262
    iput-object v1, p0, Lcom/b/a/a/b/g;->k:Lcom/b/a/a/c/c;

    .line 264
    :cond_1
    if-eqz p2, :cond_2

    .line 265
    iput-boolean v2, p0, Lcom/b/a/a/b/g;->i:Z

    .line 268
    :cond_2
    iget-object v0, p0, Lcom/b/a/a/b/g;->h:Lcom/b/a/a/b/c;

    if-eqz v0, :cond_5

    .line 269
    if-eqz p1, :cond_3

    .line 270
    iget-object v0, p0, Lcom/b/a/a/b/g;->h:Lcom/b/a/a/b/c;

    iput-boolean v2, v0, Lcom/b/a/a/b/c;->a:Z

    .line 272
    :cond_3
    iget-object v0, p0, Lcom/b/a/a/b/g;->k:Lcom/b/a/a/c/c;

    if-nez v0, :cond_5

    iget-boolean v0, p0, Lcom/b/a/a/b/g;->i:Z

    if-nez v0, :cond_4

    iget-object v0, p0, Lcom/b/a/a/b/g;->h:Lcom/b/a/a/b/c;

    iget-boolean v0, v0, Lcom/b/a/a/b/c;->a:Z

    if-eqz v0, :cond_5

    .line 273
    :cond_4
    iget-object v0, p0, Lcom/b/a/a/b/g;->h:Lcom/b/a/a/b/c;

    invoke-direct {p0, v0}, Lcom/b/a/a/b/g;->c(Lcom/b/a/a/b/c;)V

    .line 274
    iget-object v0, p0, Lcom/b/a/a/b/g;->h:Lcom/b/a/a/b/c;

    iget-object v0, v0, Lcom/b/a/a/b/c;->d:Ljava/util/List;

    invoke-interface {v0}, Ljava/util/List;->isEmpty()Z

    move-result v0

    if-eqz v0, :cond_6

    .line 275
    iget-object v0, p0, Lcom/b/a/a/b/g;->h:Lcom/b/a/a/b/c;

    invoke-static {}, Ljava/lang/System;->nanoTime()J

    move-result-wide v2

    iput-wide v2, v0, Lcom/b/a/a/b/c;->e:J

    .line 276
    sget-object v0, Lcom/b/a/a/a;->a:Lcom/b/a/a/a;

    iget-object v2, p0, Lcom/b/a/a/b/g;->d:Lcom/b/a/n;

    iget-object v3, p0, Lcom/b/a/a/b/g;->h:Lcom/b/a/a/b/c;

    invoke-virtual {v0, v2, v3}, Lcom/b/a/a/a;->a(Lcom/b/a/n;Lcom/b/a/a/b/c;)Z

    move-result v0

    if-eqz v0, :cond_6

    .line 277
    iget-object v0, p0, Lcom/b/a/a/b/g;->h:Lcom/b/a/a/b/c;

    invoke-virtual {v0}, Lcom/b/a/a/b/c;->b()Ljava/net/Socket;

    move-result-object v0

    .line 280
    :goto_0
    iput-object v1, p0, Lcom/b/a/a/b/g;->h:Lcom/b/a/a/b/c;

    move-object v1, v0

    .line 283
    :cond_5
    return-object v1

    :cond_6
    move-object v0, v1

    goto :goto_0
.end method

.method private c(Lcom/b/a/a/b/c;)V
    .locals 3

    .prologue
    .line 349
    const/4 v0, 0x0

    iget-object v1, p1, Lcom/b/a/a/b/c;->d:Ljava/util/List;

    invoke-interface {v1}, Ljava/util/List;->size()I

    move-result v2

    move v1, v0

    :goto_0
    if-ge v1, v2, :cond_1

    .line 350
    iget-object v0, p1, Lcom/b/a/a/b/c;->d:Ljava/util/List;

    invoke-interface {v0, v1}, Ljava/util/List;->get(I)Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Ljava/lang/ref/Reference;

    .line 351
    invoke-virtual {v0}, Ljava/lang/ref/Reference;->get()Ljava/lang/Object;

    move-result-object v0

    if-ne v0, p0, :cond_0

    .line 352
    iget-object v0, p1, Lcom/b/a/a/b/c;->d:Ljava/util/List;

    invoke-interface {v0, v1}, Ljava/util/List;->remove(I)Ljava/lang/Object;

    .line 353
    return-void

    .line 349
    :cond_0
    add-int/lit8 v0, v1, 0x1

    move v1, v0

    goto :goto_0

    .line 356
    :cond_1
    new-instance v0, Ljava/lang/IllegalStateException;

    invoke-direct {v0}, Ljava/lang/IllegalStateException;-><init>()V

    throw v0
.end method

.method private f()Lcom/b/a/a/b/d;
    .locals 2

    .prologue
    .line 227
    sget-object v0, Lcom/b/a/a/a;->a:Lcom/b/a/a/a;

    iget-object v1, p0, Lcom/b/a/a/b/g;->d:Lcom/b/a/n;

    invoke-virtual {v0, v1}, Lcom/b/a/a/a;->a(Lcom/b/a/n;)Lcom/b/a/a/b/d;

    move-result-object v0

    return-object v0
.end method


# virtual methods
.method public final a()Lcom/b/a/a/c/c;
    .locals 2

    .prologue
    .line 221
    iget-object v1, p0, Lcom/b/a/a/b/g;->d:Lcom/b/a/n;

    monitor-enter v1

    .line 222
    :try_start_0
    iget-object v0, p0, Lcom/b/a/a/b/g;->k:Lcom/b/a/a/c/c;

    monitor-exit v1

    return-object v0

    .line 223
    :catchall_0
    move-exception v0

    monitor-exit v1
    :try_end_0
    .catchall {:try_start_0 .. :try_end_0} :catchall_0

    throw v0
.end method

.method public final a(Lcom/b/a/ai;Z)Lcom/b/a/a/c/c;
    .locals 6

    .prologue
    .line 94
    invoke-virtual {p1}, Lcom/b/a/ai;->a()I

    move-result v1

    .line 95
    invoke-virtual {p1}, Lcom/b/a/ai;->b()I

    move-result v2

    .line 96
    invoke-virtual {p1}, Lcom/b/a/ai;->c()I

    move-result v3

    .line 97
    invoke-virtual {p1}, Lcom/b/a/ai;->q()Z

    move-result v4

    move-object v0, p0

    move v5, p2

    .line 100
    :try_start_0
    invoke-direct/range {v0 .. v5}, Lcom/b/a/a/b/g;->a(IIIZZ)Lcom/b/a/a/b/c;

    move-result-object v0

    .line 102
    invoke-virtual {v0, p1, p0}, Lcom/b/a/a/b/c;->a(Lcom/b/a/ai;Lcom/b/a/a/b/g;)Lcom/b/a/a/c/c;

    move-result-object v0

    .line 104
    iget-object v1, p0, Lcom/b/a/a/b/g;->d:Lcom/b/a/n;

    monitor-enter v1
    :try_end_0
    .catch Ljava/io/IOException; {:try_start_0 .. :try_end_0} :catch_0

    .line 105
    :try_start_1
    iput-object v0, p0, Lcom/b/a/a/b/g;->k:Lcom/b/a/a/c/c;

    .line 106
    monitor-exit v1

    return-object v0

    .line 107
    :catchall_0
    move-exception v0

    monitor-exit v1
    :try_end_1
    .catchall {:try_start_1 .. :try_end_1} :catchall_0

    :try_start_2
    throw v0
    :try_end_2
    .catch Ljava/io/IOException; {:try_start_2 .. :try_end_2} :catch_0

    .line 108
    :catch_0
    move-exception v0

    .line 109
    new-instance v1, Lcom/b/a/a/b/e;

    invoke-direct {v1, v0}, Lcom/b/a/a/b/e;-><init>(Ljava/io/IOException;)V

    throw v1
.end method

.method public final a(Lcom/b/a/a/b/c;)V
    .locals 3

    .prologue
    .line 340
    sget-boolean v0, Lcom/b/a/a/b/g;->b:Z

    if-nez v0, :cond_0

    iget-object v0, p0, Lcom/b/a/a/b/g;->d:Lcom/b/a/n;

    invoke-static {v0}, Ljava/lang/Thread;->holdsLock(Ljava/lang/Object;)Z

    move-result v0

    if-nez v0, :cond_0

    new-instance v0, Ljava/lang/AssertionError;

    invoke-direct {v0}, Ljava/lang/AssertionError;-><init>()V

    throw v0

    .line 341
    :cond_0
    iget-object v0, p0, Lcom/b/a/a/b/g;->h:Lcom/b/a/a/b/c;

    if-eqz v0, :cond_1

    new-instance v0, Ljava/lang/IllegalStateException;

    invoke-direct {v0}, Ljava/lang/IllegalStateException;-><init>()V

    throw v0

    .line 343
    :cond_1
    iput-object p1, p0, Lcom/b/a/a/b/g;->h:Lcom/b/a/a/b/c;

    .line 344
    iget-object v0, p1, Lcom/b/a/a/b/c;->d:Ljava/util/List;

    new-instance v1, Lcom/b/a/a/b/h;

    iget-object v2, p0, Lcom/b/a/a/b/g;->e:Ljava/lang/Object;

    invoke-direct {v1, p0, v2}, Lcom/b/a/a/b/h;-><init>(Lcom/b/a/a/b/g;Ljava/lang/Object;)V

    invoke-interface {v0, v1}, Ljava/util/List;->add(Ljava/lang/Object;)Z

    .line 345
    return-void
.end method

.method public final a(Ljava/io/IOException;)V
    .locals 5

    .prologue
    const/4 v0, 0x0

    const/4 v1, 0x1

    .line 303
    .line 305
    iget-object v2, p0, Lcom/b/a/a/b/g;->d:Lcom/b/a/n;

    monitor-enter v2

    .line 306
    :try_start_0
    instance-of v3, p1, Lcom/b/a/a/e/am;

    if-eqz v3, :cond_4

    .line 307
    check-cast p1, Lcom/b/a/a/e/am;

    .line 308
    iget-object v3, p1, Lcom/b/a/a/e/am;->a:Lcom/b/a/a/e/b;

    sget-object v4, Lcom/b/a/a/e/b;->e:Lcom/b/a/a/e/b;

    if-ne v3, v4, :cond_0

    .line 309
    iget v3, p0, Lcom/b/a/a/b/g;->g:I

    add-int/lit8 v3, v3, 0x1

    iput v3, p0, Lcom/b/a/a/b/g;->g:I

    .line 313
    :cond_0
    iget-object v3, p1, Lcom/b/a/a/e/am;->a:Lcom/b/a/a/e/b;

    sget-object v4, Lcom/b/a/a/e/b;->e:Lcom/b/a/a/e/b;

    if-ne v3, v4, :cond_1

    iget v3, p0, Lcom/b/a/a/b/g;->g:I

    if-le v3, v1, :cond_3

    .line 315
    :cond_1
    const/4 v0, 0x0

    iput-object v0, p0, Lcom/b/a/a/b/g;->c:Lcom/b/a/aw;

    :cond_2
    :goto_0
    move v0, v1

    .line 329
    :cond_3
    const/4 v1, 0x0

    const/4 v3, 0x1

    invoke-direct {p0, v0, v1, v3}, Lcom/b/a/a/b/g;->a(ZZZ)Ljava/net/Socket;

    move-result-object v0

    .line 330
    monitor-exit v2
    :try_end_0
    .catchall {:try_start_0 .. :try_end_0} :catchall_0

    .line 332
    invoke-static {v0}, Lcom/b/a/a/c;->a(Ljava/net/Socket;)V

    .line 333
    return-void

    .line 317
    :cond_4
    :try_start_1
    iget-object v3, p0, Lcom/b/a/a/b/g;->h:Lcom/b/a/a/b/c;

    if-eqz v3, :cond_3

    iget-object v3, p0, Lcom/b/a/a/b/g;->h:Lcom/b/a/a/b/c;

    .line 318
    invoke-virtual {v3}, Lcom/b/a/a/b/c;->d()Z

    move-result v3

    if-eqz v3, :cond_5

    instance-of v3, p1, Lcom/b/a/a/e/a;

    if-eqz v3, :cond_3

    .line 322
    :cond_5
    iget-object v0, p0, Lcom/b/a/a/b/g;->h:Lcom/b/a/a/b/c;

    iget v0, v0, Lcom/b/a/a/b/c;->b:I

    if-nez v0, :cond_2

    .line 323
    iget-object v0, p0, Lcom/b/a/a/b/g;->c:Lcom/b/a/aw;

    if-eqz v0, :cond_6

    if-eqz p1, :cond_6

    .line 324
    iget-object v0, p0, Lcom/b/a/a/b/g;->f:Lcom/b/a/a/b/f;

    iget-object v3, p0, Lcom/b/a/a/b/g;->c:Lcom/b/a/aw;

    invoke-virtual {v0, v3, p1}, Lcom/b/a/a/b/f;->a(Lcom/b/a/aw;Ljava/io/IOException;)V

    .line 326
    :cond_6
    const/4 v0, 0x0

    iput-object v0, p0, Lcom/b/a/a/b/g;->c:Lcom/b/a/aw;

    goto :goto_0

    .line 330
    :catchall_0
    move-exception v0

    monitor-exit v2
    :try_end_1
    .catchall {:try_start_1 .. :try_end_1} :catchall_0

    throw v0
.end method

.method public final a(ZLcom/b/a/a/c/c;)V
    .locals 4

    .prologue
    .line 208
    iget-object v1, p0, Lcom/b/a/a/b/g;->d:Lcom/b/a/n;

    monitor-enter v1

    .line 209
    if-eqz p2, :cond_0

    :try_start_0
    iget-object v0, p0, Lcom/b/a/a/b/g;->k:Lcom/b/a/a/c/c;

    if-eq p2, v0, :cond_1

    .line 210
    :cond_0
    new-instance v0, Ljava/lang/IllegalStateException;

    new-instance v2, Ljava/lang/StringBuilder;

    const-string v3, "expected "

    invoke-direct {v2, v3}, Ljava/lang/StringBuilder;-><init>(Ljava/lang/String;)V

    iget-object v3, p0, Lcom/b/a/a/b/g;->k:Lcom/b/a/a/c/c;

    invoke-virtual {v2, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/Object;)Ljava/lang/StringBuilder;

    move-result-object v2

    const-string v3, " but was "

    invoke-virtual {v2, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    invoke-virtual {v2, p2}, Ljava/lang/StringBuilder;->append(Ljava/lang/Object;)Ljava/lang/StringBuilder;

    move-result-object v2

    invoke-virtual {v2}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v2

    invoke-direct {v0, v2}, Ljava/lang/IllegalStateException;-><init>(Ljava/lang/String;)V

    throw v0

    .line 216
    :catchall_0
    move-exception v0

    monitor-exit v1
    :try_end_0
    .catchall {:try_start_0 .. :try_end_0} :catchall_0

    throw v0

    .line 212
    :cond_1
    if-nez p1, :cond_2

    .line 213
    :try_start_1
    iget-object v0, p0, Lcom/b/a/a/b/g;->h:Lcom/b/a/a/b/c;

    iget v2, v0, Lcom/b/a/a/b/c;->b:I

    add-int/lit8 v2, v2, 0x1

    iput v2, v0, Lcom/b/a/a/b/c;->b:I

    .line 215
    :cond_2
    const/4 v0, 0x0

    const/4 v2, 0x1

    invoke-direct {p0, p1, v0, v2}, Lcom/b/a/a/b/g;->a(ZZZ)Ljava/net/Socket;

    move-result-object v0

    .line 216
    monitor-exit v1
    :try_end_1
    .catchall {:try_start_1 .. :try_end_1} :catchall_0

    .line 217
    invoke-static {v0}, Lcom/b/a/a/c;->a(Ljava/net/Socket;)V

    .line 218
    return-void
.end method

.method public final declared-synchronized b()Lcom/b/a/a/b/c;
    .locals 1

    .prologue
    .line 231
    monitor-enter p0

    :try_start_0
    iget-object v0, p0, Lcom/b/a/a/b/g;->h:Lcom/b/a/a/b/c;
    :try_end_0
    .catchall {:try_start_0 .. :try_end_0} :catchall_0

    monitor-exit p0

    return-object v0

    :catchall_0
    move-exception v0

    monitor-exit p0

    throw v0
.end method

.method public final b(Lcom/b/a/a/b/c;)Ljava/net/Socket;
    .locals 3

    .prologue
    const/4 v2, 0x1

    const/4 v1, 0x0

    .line 368
    sget-boolean v0, Lcom/b/a/a/b/g;->b:Z

    if-nez v0, :cond_0

    iget-object v0, p0, Lcom/b/a/a/b/g;->d:Lcom/b/a/n;

    invoke-static {v0}, Ljava/lang/Thread;->holdsLock(Ljava/lang/Object;)Z

    move-result v0

    if-nez v0, :cond_0

    new-instance v0, Ljava/lang/AssertionError;

    invoke-direct {v0}, Ljava/lang/AssertionError;-><init>()V

    throw v0

    .line 369
    :cond_0
    iget-object v0, p0, Lcom/b/a/a/b/g;->k:Lcom/b/a/a/c/c;

    if-nez v0, :cond_1

    iget-object v0, p0, Lcom/b/a/a/b/g;->h:Lcom/b/a/a/b/c;

    iget-object v0, v0, Lcom/b/a/a/b/c;->d:Ljava/util/List;

    invoke-interface {v0}, Ljava/util/List;->size()I

    move-result v0

    if-eq v0, v2, :cond_2

    :cond_1
    new-instance v0, Ljava/lang/IllegalStateException;

    invoke-direct {v0}, Ljava/lang/IllegalStateException;-><init>()V

    throw v0

    .line 372
    :cond_2
    iget-object v0, p0, Lcom/b/a/a/b/g;->h:Lcom/b/a/a/b/c;

    iget-object v0, v0, Lcom/b/a/a/b/c;->d:Ljava/util/List;

    invoke-interface {v0, v1}, Ljava/util/List;->get(I)Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Ljava/lang/ref/Reference;

    .line 373
    invoke-direct {p0, v2, v1, v1}, Lcom/b/a/a/b/g;->a(ZZZ)Ljava/net/Socket;

    move-result-object v1

    .line 376
    iput-object p1, p0, Lcom/b/a/a/b/g;->h:Lcom/b/a/a/b/c;

    .line 377
    iget-object v2, p1, Lcom/b/a/a/b/c;->d:Ljava/util/List;

    invoke-interface {v2, v0}, Ljava/util/List;->add(Ljava/lang/Object;)Z

    .line 379
    return-object v1
.end method

.method public final c()V
    .locals 4

    .prologue
    .line 236
    iget-object v1, p0, Lcom/b/a/a/b/g;->d:Lcom/b/a/n;

    monitor-enter v1

    .line 237
    const/4 v0, 0x0

    const/4 v2, 0x1

    const/4 v3, 0x0

    :try_start_0
    invoke-direct {p0, v0, v2, v3}, Lcom/b/a/a/b/g;->a(ZZZ)Ljava/net/Socket;

    move-result-object v0

    .line 238
    monitor-exit v1
    :try_end_0
    .catchall {:try_start_0 .. :try_end_0} :catchall_0

    .line 239
    invoke-static {v0}, Lcom/b/a/a/c;->a(Ljava/net/Socket;)V

    .line 240
    return-void

    .line 238
    :catchall_0
    move-exception v0

    :try_start_1
    monitor-exit v1
    :try_end_1
    .catchall {:try_start_1 .. :try_end_1} :catchall_0

    throw v0
.end method

.method public final d()V
    .locals 4

    .prologue
    .line 245
    iget-object v1, p0, Lcom/b/a/a/b/g;->d:Lcom/b/a/n;

    monitor-enter v1

    .line 246
    const/4 v0, 0x1

    const/4 v2, 0x0

    const/4 v3, 0x0

    :try_start_0
    invoke-direct {p0, v0, v2, v3}, Lcom/b/a/a/b/g;->a(ZZZ)Ljava/net/Socket;

    move-result-object v0

    .line 247
    monitor-exit v1
    :try_end_0
    .catchall {:try_start_0 .. :try_end_0} :catchall_0

    .line 248
    invoke-static {v0}, Lcom/b/a/a/c;->a(Ljava/net/Socket;)V

    .line 249
    return-void

    .line 247
    :catchall_0
    move-exception v0

    :try_start_1
    monitor-exit v1
    :try_end_1
    .catchall {:try_start_1 .. :try_end_1} :catchall_0

    throw v0
.end method

.method public final e()Z
    .locals 1

    .prologue
    .line 383
    iget-object v0, p0, Lcom/b/a/a/b/g;->c:Lcom/b/a/aw;

    if-nez v0, :cond_0

    iget-object v0, p0, Lcom/b/a/a/b/g;->f:Lcom/b/a/a/b/f;

    invoke-virtual {v0}, Lcom/b/a/a/b/f;->a()Z

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

.method public final toString()Ljava/lang/String;
    .locals 1

    .prologue
    .line 387
    invoke-virtual {p0}, Lcom/b/a/a/b/g;->b()Lcom/b/a/a/b/c;

    move-result-object v0

    .line 388
    if-eqz v0, :cond_0

    invoke-virtual {v0}, Lcom/b/a/a/b/c;->toString()Ljava/lang/String;

    move-result-object v0

    :goto_0
    return-object v0

    :cond_0
    iget-object v0, p0, Lcom/b/a/a/b/g;->a:Lcom/b/a/a;

    invoke-virtual {v0}, Lcom/b/a/a;->toString()Ljava/lang/String;

    move-result-object v0

    goto :goto_0
.end method
