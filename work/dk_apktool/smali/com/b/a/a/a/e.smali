.class public final Lcom/b/a/a/a/e;
.super Ljava/lang/Object;
.source "SourceFile"


# instance fields
.field final a:J

.field final b:Lcom/b/a/ao;

.field final c:Lcom/b/a/as;

.field private d:Ljava/util/Date;

.field private e:Ljava/lang/String;

.field private f:Ljava/util/Date;

.field private g:Ljava/lang/String;

.field private h:Ljava/util/Date;

.field private i:J

.field private j:J

.field private k:Ljava/lang/String;

.field private l:I


# direct methods
.method public constructor <init>(JLcom/b/a/ao;Lcom/b/a/as;)V
    .locals 7

    .prologue
    const/4 v6, -0x1

    .line 139
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    .line 137
    iput v6, p0, Lcom/b/a/a/a/e;->l:I

    .line 140
    iput-wide p1, p0, Lcom/b/a/a/a/e;->a:J

    .line 141
    iput-object p3, p0, Lcom/b/a/a/a/e;->b:Lcom/b/a/ao;

    .line 142
    iput-object p4, p0, Lcom/b/a/a/a/e;->c:Lcom/b/a/as;

    .line 144
    if-eqz p4, :cond_5

    .line 145
    invoke-virtual {p4}, Lcom/b/a/as;->h()J

    move-result-wide v0

    iput-wide v0, p0, Lcom/b/a/a/a/e;->i:J

    .line 146
    invoke-virtual {p4}, Lcom/b/a/as;->i()J

    move-result-wide v0

    iput-wide v0, p0, Lcom/b/a/a/a/e;->j:J

    .line 147
    invoke-virtual {p4}, Lcom/b/a/as;->d()Lcom/b/a/aa;

    move-result-object v1

    .line 148
    const/4 v0, 0x0

    invoke-virtual {v1}, Lcom/b/a/aa;->a()I

    move-result v2

    :goto_0
    if-ge v0, v2, :cond_5

    .line 149
    invoke-virtual {v1, v0}, Lcom/b/a/aa;->a(I)Ljava/lang/String;

    move-result-object v3

    .line 150
    invoke-virtual {v1, v0}, Lcom/b/a/aa;->b(I)Ljava/lang/String;

    move-result-object v4

    .line 151
    const-string v5, "Date"

    invoke-virtual {v5, v3}, Ljava/lang/String;->equalsIgnoreCase(Ljava/lang/String;)Z

    move-result v5

    if-eqz v5, :cond_1

    .line 152
    invoke-static {v4}, Lcom/b/a/a/c/d;->a(Ljava/lang/String;)Ljava/util/Date;

    move-result-object v3

    iput-object v3, p0, Lcom/b/a/a/a/e;->d:Ljava/util/Date;

    .line 153
    iput-object v4, p0, Lcom/b/a/a/a/e;->e:Ljava/lang/String;

    .line 148
    :cond_0
    :goto_1
    add-int/lit8 v0, v0, 0x1

    goto :goto_0

    .line 154
    :cond_1
    const-string v5, "Expires"

    invoke-virtual {v5, v3}, Ljava/lang/String;->equalsIgnoreCase(Ljava/lang/String;)Z

    move-result v5

    if-eqz v5, :cond_2

    .line 155
    invoke-static {v4}, Lcom/b/a/a/c/d;->a(Ljava/lang/String;)Ljava/util/Date;

    move-result-object v3

    iput-object v3, p0, Lcom/b/a/a/a/e;->h:Ljava/util/Date;

    goto :goto_1

    .line 156
    :cond_2
    const-string v5, "Last-Modified"

    invoke-virtual {v5, v3}, Ljava/lang/String;->equalsIgnoreCase(Ljava/lang/String;)Z

    move-result v5

    if-eqz v5, :cond_3

    .line 157
    invoke-static {v4}, Lcom/b/a/a/c/d;->a(Ljava/lang/String;)Ljava/util/Date;

    move-result-object v3

    iput-object v3, p0, Lcom/b/a/a/a/e;->f:Ljava/util/Date;

    .line 158
    iput-object v4, p0, Lcom/b/a/a/a/e;->g:Ljava/lang/String;

    goto :goto_1

    .line 159
    :cond_3
    const-string v5, "ETag"

    invoke-virtual {v5, v3}, Ljava/lang/String;->equalsIgnoreCase(Ljava/lang/String;)Z

    move-result v5

    if-eqz v5, :cond_4

    .line 160
    iput-object v4, p0, Lcom/b/a/a/a/e;->k:Ljava/lang/String;

    goto :goto_1

    .line 161
    :cond_4
    const-string v5, "Age"

    invoke-virtual {v5, v3}, Ljava/lang/String;->equalsIgnoreCase(Ljava/lang/String;)Z

    move-result v3

    if-eqz v3, :cond_0

    .line 162
    invoke-static {v4, v6}, Lcom/b/a/a/c/f;->b(Ljava/lang/String;I)I

    move-result v3

    iput v3, p0, Lcom/b/a/a/a/e;->l:I

    goto :goto_1

    .line 166
    :cond_5
    return-void
.end method


# virtual methods
.method public final a()Lcom/b/a/a/a/d;
    .locals 12

    .prologue
    .line 172
    .line 1185
    iget-object v0, p0, Lcom/b/a/a/a/e;->c:Lcom/b/a/as;

    if-nez v0, :cond_1

    .line 1186
    new-instance v0, Lcom/b/a/a/a/d;

    iget-object v1, p0, Lcom/b/a/a/a/e;->b:Lcom/b/a/ao;

    const/4 v2, 0x0

    invoke-direct {v0, v1, v2}, Lcom/b/a/a/a/d;-><init>(Lcom/b/a/ao;Lcom/b/a/as;)V

    .line 174
    :goto_0
    iget-object v1, v0, Lcom/b/a/a/a/d;->a:Lcom/b/a/ao;

    if-eqz v1, :cond_0

    iget-object v1, p0, Lcom/b/a/a/a/e;->b:Lcom/b/a/ao;

    invoke-virtual {v1}, Lcom/b/a/ao;->f()Lcom/b/a/e;

    move-result-object v1

    invoke-virtual {v1}, Lcom/b/a/e;->i()Z

    move-result v1

    if-eqz v1, :cond_0

    .line 176
    new-instance v0, Lcom/b/a/a/a/d;

    const/4 v1, 0x0

    const/4 v2, 0x0

    invoke-direct {v0, v1, v2}, Lcom/b/a/a/a/d;-><init>(Lcom/b/a/ao;Lcom/b/a/as;)V

    .line 179
    :cond_0
    return-object v0

    .line 1190
    :cond_1
    iget-object v0, p0, Lcom/b/a/a/a/e;->b:Lcom/b/a/ao;

    invoke-virtual {v0}, Lcom/b/a/ao;->g()Z

    move-result v0

    if-eqz v0, :cond_2

    iget-object v0, p0, Lcom/b/a/a/a/e;->c:Lcom/b/a/as;

    invoke-virtual {v0}, Lcom/b/a/as;->c()Lcom/b/a/z;

    move-result-object v0

    if-nez v0, :cond_2

    .line 1191
    new-instance v0, Lcom/b/a/a/a/d;

    iget-object v1, p0, Lcom/b/a/a/a/e;->b:Lcom/b/a/ao;

    const/4 v2, 0x0

    invoke-direct {v0, v1, v2}, Lcom/b/a/a/a/d;-><init>(Lcom/b/a/ao;Lcom/b/a/as;)V

    goto :goto_0

    .line 1197
    :cond_2
    iget-object v0, p0, Lcom/b/a/a/a/e;->c:Lcom/b/a/as;

    iget-object v1, p0, Lcom/b/a/a/a/e;->b:Lcom/b/a/ao;

    invoke-static {v0, v1}, Lcom/b/a/a/a/d;->a(Lcom/b/a/as;Lcom/b/a/ao;)Z

    move-result v0

    if-nez v0, :cond_3

    .line 1198
    new-instance v0, Lcom/b/a/a/a/d;

    iget-object v1, p0, Lcom/b/a/a/a/e;->b:Lcom/b/a/ao;

    const/4 v2, 0x0

    invoke-direct {v0, v1, v2}, Lcom/b/a/a/a/d;-><init>(Lcom/b/a/ao;Lcom/b/a/as;)V

    goto :goto_0

    .line 1201
    :cond_3
    iget-object v0, p0, Lcom/b/a/a/a/e;->b:Lcom/b/a/ao;

    invoke-virtual {v0}, Lcom/b/a/ao;->f()Lcom/b/a/e;

    move-result-object v6

    .line 1202
    invoke-virtual {v6}, Lcom/b/a/e;->a()Z

    move-result v0

    if-nez v0, :cond_5

    iget-object v0, p0, Lcom/b/a/a/a/e;->b:Lcom/b/a/ao;

    .line 1321
    const-string v1, "If-Modified-Since"

    invoke-virtual {v0, v1}, Lcom/b/a/ao;->a(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v1

    if-nez v1, :cond_4

    const-string v1, "If-None-Match"

    invoke-virtual {v0, v1}, Lcom/b/a/ao;->a(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v0

    if-eqz v0, :cond_6

    :cond_4
    const/4 v0, 0x1

    .line 1202
    :goto_1
    if-eqz v0, :cond_7

    .line 1203
    :cond_5
    new-instance v0, Lcom/b/a/a/a/d;

    iget-object v1, p0, Lcom/b/a/a/a/e;->b:Lcom/b/a/ao;

    const/4 v2, 0x0

    invoke-direct {v0, v1, v2}, Lcom/b/a/a/a/d;-><init>(Lcom/b/a/ao;Lcom/b/a/as;)V

    goto :goto_0

    .line 1321
    :cond_6
    const/4 v0, 0x0

    goto :goto_1

    .line 2296
    :cond_7
    iget-object v0, p0, Lcom/b/a/a/a/e;->d:Ljava/util/Date;

    if-eqz v0, :cond_f

    const-wide/16 v0, 0x0

    iget-wide v2, p0, Lcom/b/a/a/a/e;->j:J

    iget-object v4, p0, Lcom/b/a/a/a/e;->d:Ljava/util/Date;

    .line 2297
    invoke-virtual {v4}, Ljava/util/Date;->getTime()J

    move-result-wide v4

    sub-long/2addr v2, v4

    invoke-static {v0, v1, v2, v3}, Ljava/lang/Math;->max(JJ)J

    move-result-wide v0

    .line 2299
    :goto_2
    iget v2, p0, Lcom/b/a/a/a/e;->l:I

    const/4 v3, -0x1

    if-eq v2, v3, :cond_8

    sget-object v2, Ljava/util/concurrent/TimeUnit;->SECONDS:Ljava/util/concurrent/TimeUnit;

    iget v3, p0, Lcom/b/a/a/a/e;->l:I

    int-to-long v4, v3

    .line 2300
    invoke-virtual {v2, v4, v5}, Ljava/util/concurrent/TimeUnit;->toMillis(J)J

    move-result-wide v2

    invoke-static {v0, v1, v2, v3}, Ljava/lang/Math;->max(JJ)J

    move-result-wide v0

    .line 2302
    :cond_8
    iget-wide v2, p0, Lcom/b/a/a/a/e;->j:J

    iget-wide v4, p0, Lcom/b/a/a/a/e;->i:J

    sub-long/2addr v2, v4

    .line 2303
    iget-wide v4, p0, Lcom/b/a/a/a/e;->a:J

    iget-wide v8, p0, Lcom/b/a/a/a/e;->j:J

    sub-long/2addr v4, v8

    .line 2304
    add-long/2addr v0, v2

    add-long v8, v0, v4

    .line 3267
    iget-object v0, p0, Lcom/b/a/a/a/e;->c:Lcom/b/a/as;

    invoke-virtual {v0}, Lcom/b/a/as;->g()Lcom/b/a/e;

    move-result-object v0

    .line 3268
    invoke-virtual {v0}, Lcom/b/a/e;->c()I

    move-result v1

    const/4 v2, -0x1

    if-eq v1, v2, :cond_10

    .line 3269
    sget-object v1, Ljava/util/concurrent/TimeUnit;->SECONDS:Ljava/util/concurrent/TimeUnit;

    invoke-virtual {v0}, Lcom/b/a/e;->c()I

    move-result v0

    int-to-long v2, v0

    invoke-virtual {v1, v2, v3}, Ljava/util/concurrent/TimeUnit;->toMillis(J)J

    move-result-wide v0

    .line 1209
    :cond_9
    :goto_3
    invoke-virtual {v6}, Lcom/b/a/e;->c()I

    move-result v2

    const/4 v3, -0x1

    if-eq v2, v3, :cond_a

    .line 1210
    sget-object v2, Ljava/util/concurrent/TimeUnit;->SECONDS:Ljava/util/concurrent/TimeUnit;

    invoke-virtual {v6}, Lcom/b/a/e;->c()I

    move-result v3

    int-to-long v4, v3

    invoke-virtual {v2, v4, v5}, Ljava/util/concurrent/TimeUnit;->toMillis(J)J

    move-result-wide v2

    invoke-static {v0, v1, v2, v3}, Ljava/lang/Math;->min(JJ)J

    move-result-wide v0

    .line 1213
    :cond_a
    const-wide/16 v2, 0x0

    .line 1214
    invoke-virtual {v6}, Lcom/b/a/e;->h()I

    move-result v4

    const/4 v5, -0x1

    if-eq v4, v5, :cond_b

    .line 1215
    sget-object v2, Ljava/util/concurrent/TimeUnit;->SECONDS:Ljava/util/concurrent/TimeUnit;

    invoke-virtual {v6}, Lcom/b/a/e;->h()I

    move-result v3

    int-to-long v4, v3

    invoke-virtual {v2, v4, v5}, Ljava/util/concurrent/TimeUnit;->toMillis(J)J

    move-result-wide v2

    .line 1218
    :cond_b
    const-wide/16 v4, 0x0

    .line 1219
    iget-object v7, p0, Lcom/b/a/a/a/e;->c:Lcom/b/a/as;

    invoke-virtual {v7}, Lcom/b/a/as;->g()Lcom/b/a/e;

    move-result-object v7

    .line 1220
    invoke-virtual {v7}, Lcom/b/a/e;->f()Z

    move-result v10

    if-nez v10, :cond_c

    invoke-virtual {v6}, Lcom/b/a/e;->g()I

    move-result v10

    const/4 v11, -0x1

    if-eq v10, v11, :cond_c

    .line 1221
    sget-object v4, Ljava/util/concurrent/TimeUnit;->SECONDS:Ljava/util/concurrent/TimeUnit;

    invoke-virtual {v6}, Lcom/b/a/e;->g()I

    move-result v5

    int-to-long v10, v5

    invoke-virtual {v4, v10, v11}, Ljava/util/concurrent/TimeUnit;->toMillis(J)J

    move-result-wide v4

    .line 1224
    :cond_c
    invoke-virtual {v7}, Lcom/b/a/e;->a()Z

    move-result v6

    if-nez v6, :cond_17

    add-long v6, v8, v2

    add-long/2addr v4, v0

    cmp-long v4, v6, v4

    if-gez v4, :cond_17

    .line 1225
    iget-object v4, p0, Lcom/b/a/a/a/e;->c:Lcom/b/a/as;

    invoke-virtual {v4}, Lcom/b/a/as;->f()Lcom/b/a/at;

    move-result-object v4

    .line 1226
    add-long/2addr v2, v8

    cmp-long v0, v2, v0

    if-ltz v0, :cond_d

    .line 1227
    const-string v0, "Warning"

    const-string v1, "110 HttpURLConnection \"Response is stale\""

    invoke-virtual {v4, v0, v1}, Lcom/b/a/at;->a(Ljava/lang/String;Ljava/lang/String;)Lcom/b/a/at;

    .line 1230
    :cond_d
    const-wide/32 v0, 0x5265c00

    cmp-long v0, v8, v0

    if-lez v0, :cond_e

    .line 3312
    iget-object v0, p0, Lcom/b/a/a/a/e;->c:Lcom/b/a/as;

    invoke-virtual {v0}, Lcom/b/a/as;->g()Lcom/b/a/e;

    move-result-object v0

    invoke-virtual {v0}, Lcom/b/a/e;->c()I

    move-result v0

    const/4 v1, -0x1

    if-ne v0, v1, :cond_16

    iget-object v0, p0, Lcom/b/a/a/a/e;->h:Ljava/util/Date;

    if-nez v0, :cond_16

    const/4 v0, 0x1

    .line 1230
    :goto_4
    if-eqz v0, :cond_e

    .line 1231
    const-string v0, "Warning"

    const-string v1, "113 HttpURLConnection \"Heuristic expiration\""

    invoke-virtual {v4, v0, v1}, Lcom/b/a/at;->a(Ljava/lang/String;Ljava/lang/String;)Lcom/b/a/at;

    .line 1233
    :cond_e
    new-instance v0, Lcom/b/a/a/a/d;

    const/4 v1, 0x0

    invoke-virtual {v4}, Lcom/b/a/at;->a()Lcom/b/a/as;

    move-result-object v2

    invoke-direct {v0, v1, v2}, Lcom/b/a/a/a/d;-><init>(Lcom/b/a/ao;Lcom/b/a/as;)V

    goto/16 :goto_0

    .line 2297
    :cond_f
    const-wide/16 v0, 0x0

    goto/16 :goto_2

    .line 3270
    :cond_10
    iget-object v0, p0, Lcom/b/a/a/a/e;->h:Ljava/util/Date;

    if-eqz v0, :cond_12

    .line 3271
    iget-object v0, p0, Lcom/b/a/a/a/e;->d:Ljava/util/Date;

    if-eqz v0, :cond_11

    iget-object v0, p0, Lcom/b/a/a/a/e;->d:Ljava/util/Date;

    .line 3272
    invoke-virtual {v0}, Ljava/util/Date;->getTime()J

    move-result-wide v0

    .line 3274
    :goto_5
    iget-object v2, p0, Lcom/b/a/a/a/e;->h:Ljava/util/Date;

    invoke-virtual {v2}, Ljava/util/Date;->getTime()J

    move-result-wide v2

    sub-long v0, v2, v0

    .line 3275
    const-wide/16 v2, 0x0

    cmp-long v2, v0, v2

    if-gtz v2, :cond_9

    const-wide/16 v0, 0x0

    goto/16 :goto_3

    .line 3272
    :cond_11
    iget-wide v0, p0, Lcom/b/a/a/a/e;->j:J

    goto :goto_5

    .line 3276
    :cond_12
    iget-object v0, p0, Lcom/b/a/a/a/e;->f:Ljava/util/Date;

    if-eqz v0, :cond_15

    iget-object v0, p0, Lcom/b/a/a/a/e;->c:Lcom/b/a/as;

    .line 3277
    invoke-virtual {v0}, Lcom/b/a/as;->a()Lcom/b/a/ao;

    move-result-object v0

    invoke-virtual {v0}, Lcom/b/a/ao;->a()Lcom/b/a/ac;

    move-result-object v0

    invoke-virtual {v0}, Lcom/b/a/ac;->k()Ljava/lang/String;

    move-result-object v0

    if-nez v0, :cond_15

    .line 3282
    iget-object v0, p0, Lcom/b/a/a/a/e;->d:Ljava/util/Date;

    if-eqz v0, :cond_13

    iget-object v0, p0, Lcom/b/a/a/a/e;->d:Ljava/util/Date;

    .line 3283
    invoke-virtual {v0}, Ljava/util/Date;->getTime()J

    move-result-wide v0

    .line 3285
    :goto_6
    iget-object v2, p0, Lcom/b/a/a/a/e;->f:Ljava/util/Date;

    invoke-virtual {v2}, Ljava/util/Date;->getTime()J

    move-result-wide v2

    sub-long/2addr v0, v2

    .line 3286
    const-wide/16 v2, 0x0

    cmp-long v2, v0, v2

    if-lez v2, :cond_14

    const-wide/16 v2, 0xa

    div-long/2addr v0, v2

    goto/16 :goto_3

    .line 3283
    :cond_13
    iget-wide v0, p0, Lcom/b/a/a/a/e;->i:J

    goto :goto_6

    .line 3286
    :cond_14
    const-wide/16 v0, 0x0

    goto/16 :goto_3

    .line 3288
    :cond_15
    const-wide/16 v0, 0x0

    goto/16 :goto_3

    .line 3312
    :cond_16
    const/4 v0, 0x0

    goto :goto_4

    .line 1240
    :cond_17
    iget-object v0, p0, Lcom/b/a/a/a/e;->k:Ljava/lang/String;

    if-eqz v0, :cond_18

    .line 1241
    const-string v1, "If-None-Match"

    .line 1242
    iget-object v0, p0, Lcom/b/a/a/a/e;->k:Ljava/lang/String;

    .line 1253
    :goto_7
    iget-object v2, p0, Lcom/b/a/a/a/e;->b:Lcom/b/a/ao;

    invoke-virtual {v2}, Lcom/b/a/ao;->c()Lcom/b/a/aa;

    move-result-object v2

    invoke-virtual {v2}, Lcom/b/a/aa;->b()Lcom/b/a/ab;

    move-result-object v2

    .line 1254
    sget-object v3, Lcom/b/a/a/a;->a:Lcom/b/a/a/a;

    invoke-virtual {v3, v2, v1, v0}, Lcom/b/a/a/a;->a(Lcom/b/a/ab;Ljava/lang/String;Ljava/lang/String;)V

    .line 1256
    iget-object v0, p0, Lcom/b/a/a/a/e;->b:Lcom/b/a/ao;

    invoke-virtual {v0}, Lcom/b/a/ao;->e()Lcom/b/a/ap;

    move-result-object v0

    .line 1257
    invoke-virtual {v2}, Lcom/b/a/ab;->a()Lcom/b/a/aa;

    move-result-object v1

    invoke-virtual {v0, v1}, Lcom/b/a/ap;->a(Lcom/b/a/aa;)Lcom/b/a/ap;

    move-result-object v0

    .line 1258
    invoke-virtual {v0}, Lcom/b/a/ap;->a()Lcom/b/a/ao;

    move-result-object v1

    .line 1259
    new-instance v0, Lcom/b/a/a/a/d;

    iget-object v2, p0, Lcom/b/a/a/a/e;->c:Lcom/b/a/as;

    invoke-direct {v0, v1, v2}, Lcom/b/a/a/a/d;-><init>(Lcom/b/a/ao;Lcom/b/a/as;)V

    goto/16 :goto_0

    .line 1243
    :cond_18
    iget-object v0, p0, Lcom/b/a/a/a/e;->f:Ljava/util/Date;

    if-eqz v0, :cond_19

    .line 1244
    const-string v1, "If-Modified-Since"

    .line 1245
    iget-object v0, p0, Lcom/b/a/a/a/e;->g:Ljava/lang/String;

    goto :goto_7

    .line 1246
    :cond_19
    iget-object v0, p0, Lcom/b/a/a/a/e;->d:Ljava/util/Date;

    if-eqz v0, :cond_1a

    .line 1247
    const-string v1, "If-Modified-Since"

    .line 1248
    iget-object v0, p0, Lcom/b/a/a/a/e;->e:Ljava/lang/String;

    goto :goto_7

    .line 1250
    :cond_1a
    new-instance v0, Lcom/b/a/a/a/d;

    iget-object v1, p0, Lcom/b/a/a/a/e;->b:Lcom/b/a/ao;

    const/4 v2, 0x0

    invoke-direct {v0, v1, v2}, Lcom/b/a/a/a/d;-><init>(Lcom/b/a/ao;Lcom/b/a/as;)V

    goto/16 :goto_0
.end method
