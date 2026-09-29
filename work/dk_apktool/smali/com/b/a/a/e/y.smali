.class final Lcom/b/a/a/e/y;
.super Ljava/lang/Object;
.source "SourceFile"

# interfaces
.implements Ljava/io/Closeable;


# static fields
.field static final a:Ljava/util/logging/Logger;


# instance fields
.field final b:Lcom/b/a/a/e/e;

.field private final c:Lcom/b/b/h;

.field private final d:Lcom/b/a/a/e/z;

.field private final e:Z


# direct methods
.method static constructor <clinit>()V
    .locals 1

    .prologue
    .line 60
    const-class v0, Lcom/b/a/a/e/g;

    invoke-virtual {v0}, Ljava/lang/Class;->getName()Ljava/lang/String;

    move-result-object v0

    invoke-static {v0}, Ljava/util/logging/Logger;->getLogger(Ljava/lang/String;)Ljava/util/logging/Logger;

    move-result-object v0

    sput-object v0, Lcom/b/a/a/e/y;->a:Ljava/util/logging/Logger;

    return-void
.end method

.method public constructor <init>(Lcom/b/b/h;Z)V
    .locals 2

    .prologue
    .line 70
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    .line 71
    iput-object p1, p0, Lcom/b/a/a/e/y;->c:Lcom/b/b/h;

    .line 72
    iput-boolean p2, p0, Lcom/b/a/a/e/y;->e:Z

    .line 73
    new-instance v0, Lcom/b/a/a/e/z;

    iget-object v1, p0, Lcom/b/a/a/e/y;->c:Lcom/b/b/h;

    invoke-direct {v0, v1}, Lcom/b/a/a/e/z;-><init>(Lcom/b/b/h;)V

    iput-object v0, p0, Lcom/b/a/a/e/y;->d:Lcom/b/a/a/e/z;

    .line 74
    new-instance v0, Lcom/b/a/a/e/e;

    iget-object v1, p0, Lcom/b/a/a/e/y;->d:Lcom/b/a/a/e/z;

    invoke-direct {v0, v1}, Lcom/b/a/a/e/e;-><init>(Lcom/b/b/x;)V

    iput-object v0, p0, Lcom/b/a/a/e/y;->b:Lcom/b/a/a/e/e;

    .line 75
    return-void
.end method

.method private static a(IBS)I
    .locals 4

    .prologue
    .line 404
    and-int/lit8 v0, p1, 0x8

    if-eqz v0, :cond_0

    add-int/lit8 p0, p0, -0x1

    .line 405
    :cond_0
    if-le p2, p0, :cond_1

    .line 406
    const-string v0, "PROTOCOL_ERROR padding %s > remaining length %s"

    const/4 v1, 0x2

    new-array v1, v1, [Ljava/lang/Object;

    const/4 v2, 0x0

    invoke-static {p2}, Ljava/lang/Short;->valueOf(S)Ljava/lang/Short;

    move-result-object v3

    aput-object v3, v1, v2

    const/4 v2, 0x1

    invoke-static {p0}, Ljava/lang/Integer;->valueOf(I)Ljava/lang/Integer;

    move-result-object v3

    aput-object v3, v1, v2

    invoke-static {v0, v1}, Lcom/b/a/a/e/g;->b(Ljava/lang/String;[Ljava/lang/Object;)Ljava/io/IOException;

    move-result-object v0

    throw v0

    .line 408
    :cond_1
    sub-int v0, p0, p2

    int-to-short v0, v0

    return v0
.end method

.method static a(Lcom/b/b/h;)I
    .locals 2

    .prologue
    .line 397
    invoke-interface {p0}, Lcom/b/b/h;->e()B

    move-result v0

    and-int/lit16 v0, v0, 0xff

    shl-int/lit8 v0, v0, 0x10

    .line 398
    invoke-interface {p0}, Lcom/b/b/h;->e()B

    move-result v1

    and-int/lit16 v1, v1, 0xff

    shl-int/lit8 v1, v1, 0x8

    or-int/2addr v0, v1

    .line 399
    invoke-interface {p0}, Lcom/b/b/h;->e()B

    move-result v1

    and-int/lit16 v1, v1, 0xff

    or-int/2addr v0, v1

    .line 397
    return v0
.end method

.method private a(ISBI)Ljava/util/List;
    .locals 2
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "(ISBI)",
            "Ljava/util/List",
            "<",
            "Lcom/b/a/a/e/c;",
            ">;"
        }
    .end annotation

    .prologue
    .line 189
    iget-object v0, p0, Lcom/b/a/a/e/y;->d:Lcom/b/a/a/e/z;

    iget-object v1, p0, Lcom/b/a/a/e/y;->d:Lcom/b/a/a/e/z;

    iput p1, v1, Lcom/b/a/a/e/z;->d:I

    iput p1, v0, Lcom/b/a/a/e/z;->a:I

    .line 190
    iget-object v0, p0, Lcom/b/a/a/e/y;->d:Lcom/b/a/a/e/z;

    iput-short p2, v0, Lcom/b/a/a/e/z;->e:S

    .line 191
    iget-object v0, p0, Lcom/b/a/a/e/y;->d:Lcom/b/a/a/e/z;

    iput-byte p3, v0, Lcom/b/a/a/e/z;->b:B

    .line 192
    iget-object v0, p0, Lcom/b/a/a/e/y;->d:Lcom/b/a/a/e/z;

    iput p4, v0, Lcom/b/a/a/e/z;->c:I

    .line 196
    iget-object v0, p0, Lcom/b/a/a/e/y;->b:Lcom/b/a/a/e/e;

    invoke-virtual {v0}, Lcom/b/a/a/e/e;->a()V

    .line 197
    iget-object v0, p0, Lcom/b/a/a/e/y;->b:Lcom/b/a/a/e/e;

    invoke-virtual {v0}, Lcom/b/a/a/e/e;->b()Ljava/util/List;

    move-result-object v0

    return-object v0
.end method

.method private a()V
    .locals 1

    .prologue
    .line 224
    iget-object v0, p0, Lcom/b/a/a/e/y;->c:Lcom/b/b/h;

    invoke-interface {v0}, Lcom/b/b/h;->g()I

    .line 227
    iget-object v0, p0, Lcom/b/a/a/e/y;->c:Lcom/b/b/h;

    invoke-interface {v0}, Lcom/b/b/h;->e()B

    .line 229
    return-void
.end method


# virtual methods
.method public final a(Lcom/b/a/a/e/aa;)V
    .locals 7

    .prologue
    const/4 v6, 0x1

    const/4 v5, 0x0

    .line 78
    iget-boolean v0, p0, Lcom/b/a/a/e/y;->e:Z

    if-eqz v0, :cond_0

    .line 80
    invoke-virtual {p0, v6, p1}, Lcom/b/a/a/e/y;->a(ZLcom/b/a/a/e/aa;)Z

    move-result v0

    if-nez v0, :cond_2

    .line 81
    const-string v0, "Required SETTINGS preface not received"

    new-array v1, v5, [Ljava/lang/Object;

    invoke-static {v0, v1}, Lcom/b/a/a/e/g;->b(Ljava/lang/String;[Ljava/lang/Object;)Ljava/io/IOException;

    move-result-object v0

    throw v0

    .line 85
    :cond_0
    iget-object v0, p0, Lcom/b/a/a/e/y;->c:Lcom/b/b/h;

    sget-object v1, Lcom/b/a/a/e/g;->a:Lcom/b/b/i;

    invoke-virtual {v1}, Lcom/b/b/i;->g()I

    move-result v1

    int-to-long v2, v1

    invoke-interface {v0, v2, v3}, Lcom/b/b/h;->c(J)Lcom/b/b/i;

    move-result-object v0

    .line 86
    sget-object v1, Lcom/b/a/a/e/y;->a:Ljava/util/logging/Logger;

    sget-object v2, Ljava/util/logging/Level;->FINE:Ljava/util/logging/Level;

    invoke-virtual {v1, v2}, Ljava/util/logging/Logger;->isLoggable(Ljava/util/logging/Level;)Z

    move-result v1

    if-eqz v1, :cond_1

    sget-object v1, Lcom/b/a/a/e/y;->a:Ljava/util/logging/Logger;

    const-string v2, "<< CONNECTION %s"

    new-array v3, v6, [Ljava/lang/Object;

    invoke-virtual {v0}, Lcom/b/b/i;->e()Ljava/lang/String;

    move-result-object v4

    aput-object v4, v3, v5

    invoke-static {v2, v3}, Lcom/b/a/a/c;->a(Ljava/lang/String;[Ljava/lang/Object;)Ljava/lang/String;

    move-result-object v2

    invoke-virtual {v1, v2}, Ljava/util/logging/Logger;->fine(Ljava/lang/String;)V

    .line 87
    :cond_1
    sget-object v1, Lcom/b/a/a/e/g;->a:Lcom/b/b/i;

    invoke-virtual {v1, v0}, Lcom/b/b/i;->equals(Ljava/lang/Object;)Z

    move-result v1

    if-nez v1, :cond_2

    .line 88
    const-string v1, "Expected a connection header but was %s"

    new-array v2, v6, [Ljava/lang/Object;

    invoke-virtual {v0}, Lcom/b/b/i;->a()Ljava/lang/String;

    move-result-object v0

    aput-object v0, v2, v5

    invoke-static {v1, v2}, Lcom/b/a/a/e/g;->b(Ljava/lang/String;[Ljava/lang/Object;)Ljava/io/IOException;

    move-result-object v0

    throw v0

    .line 91
    :cond_2
    return-void
.end method

.method public final a(ZLcom/b/a/a/e/aa;)Z
    .locals 11

    .prologue
    const/16 v10, 0x4000

    const/16 v9, 0x8

    const/4 v3, 0x4

    const/4 v4, 0x1

    const/4 v0, 0x0

    .line 95
    :try_start_0
    iget-object v1, p0, Lcom/b/a/a/e/y;->c:Lcom/b/b/h;

    const-wide/16 v6, 0x9

    invoke-interface {v1, v6, v7}, Lcom/b/b/h;->a(J)V
    :try_end_0
    .catch Ljava/io/IOException; {:try_start_0 .. :try_end_0} :catch_0

    .line 111
    iget-object v1, p0, Lcom/b/a/a/e/y;->c:Lcom/b/b/h;

    invoke-static {v1}, Lcom/b/a/a/e/y;->a(Lcom/b/b/h;)I

    move-result v1

    .line 112
    if-ltz v1, :cond_0

    if-le v1, v10, :cond_2

    .line 113
    :cond_0
    const-string v2, "FRAME_SIZE_ERROR: %s"

    new-array v3, v4, [Ljava/lang/Object;

    invoke-static {v1}, Ljava/lang/Integer;->valueOf(I)Ljava/lang/Integer;

    move-result-object v1

    aput-object v1, v3, v0

    invoke-static {v2, v3}, Lcom/b/a/a/e/g;->b(Ljava/lang/String;[Ljava/lang/Object;)Ljava/io/IOException;

    move-result-object v0

    throw v0

    .line 97
    :catch_0
    move-exception v1

    move v4, v0

    .line 164
    :cond_1
    :goto_0
    return v4

    .line 115
    :cond_2
    iget-object v2, p0, Lcom/b/a/a/e/y;->c:Lcom/b/b/h;

    invoke-interface {v2}, Lcom/b/b/h;->e()B

    move-result v2

    and-int/lit16 v2, v2, 0xff

    int-to-byte v2, v2

    .line 116
    if-eqz p1, :cond_3

    if-eq v2, v3, :cond_3

    .line 117
    const-string v1, "Expected a SETTINGS frame but was %s"

    new-array v3, v4, [Ljava/lang/Object;

    invoke-static {v2}, Ljava/lang/Byte;->valueOf(B)Ljava/lang/Byte;

    move-result-object v2

    aput-object v2, v3, v0

    invoke-static {v1, v3}, Lcom/b/a/a/e/g;->b(Ljava/lang/String;[Ljava/lang/Object;)Ljava/io/IOException;

    move-result-object v0

    throw v0

    .line 119
    :cond_3
    iget-object v5, p0, Lcom/b/a/a/e/y;->c:Lcom/b/b/h;

    invoke-interface {v5}, Lcom/b/b/h;->e()B

    move-result v5

    and-int/lit16 v5, v5, 0xff

    int-to-byte v5, v5

    .line 120
    iget-object v6, p0, Lcom/b/a/a/e/y;->c:Lcom/b/b/h;

    invoke-interface {v6}, Lcom/b/b/h;->g()I

    move-result v6

    const v7, 0x7fffffff

    and-int/2addr v6, v7

    .line 121
    sget-object v7, Lcom/b/a/a/e/y;->a:Ljava/util/logging/Logger;

    sget-object v8, Ljava/util/logging/Level;->FINE:Ljava/util/logging/Level;

    invoke-virtual {v7, v8}, Ljava/util/logging/Logger;->isLoggable(Ljava/util/logging/Level;)Z

    move-result v7

    if-eqz v7, :cond_4

    sget-object v7, Lcom/b/a/a/e/y;->a:Ljava/util/logging/Logger;

    invoke-static {v4, v6, v1, v2, v5}, Lcom/b/a/a/e/g;->a(ZIIBB)Ljava/lang/String;

    move-result-object v8

    invoke-virtual {v7, v8}, Ljava/util/logging/Logger;->fine(Ljava/lang/String;)V

    .line 123
    :cond_4
    packed-switch v2, :pswitch_data_0

    .line 162
    iget-object v0, p0, Lcom/b/a/a/e/y;->c:Lcom/b/b/h;

    int-to-long v2, v1

    invoke-interface {v0, v2, v3}, Lcom/b/b/h;->f(J)V

    goto :goto_0

    .line 1203
    :pswitch_0
    and-int/lit8 v2, v5, 0x1

    if-eqz v2, :cond_5

    move v3, v4

    .line 1204
    :goto_1
    and-int/lit8 v2, v5, 0x20

    if-eqz v2, :cond_6

    move v2, v4

    .line 1205
    :goto_2
    if-eqz v2, :cond_7

    .line 1206
    const-string v1, "PROTOCOL_ERROR: FLAG_COMPRESSED without SETTINGS_COMPRESS_DATA"

    new-array v0, v0, [Ljava/lang/Object;

    invoke-static {v1, v0}, Lcom/b/a/a/e/g;->b(Ljava/lang/String;[Ljava/lang/Object;)Ljava/io/IOException;

    move-result-object v0

    throw v0

    :cond_5
    move v3, v0

    .line 1203
    goto :goto_1

    :cond_6
    move v2, v0

    .line 1204
    goto :goto_2

    .line 1209
    :cond_7
    and-int/lit8 v2, v5, 0x8

    if-eqz v2, :cond_8

    iget-object v0, p0, Lcom/b/a/a/e/y;->c:Lcom/b/b/h;

    invoke-interface {v0}, Lcom/b/b/h;->e()B

    move-result v0

    and-int/lit16 v0, v0, 0xff

    int-to-short v0, v0

    .line 1210
    :cond_8
    invoke-static {v1, v5, v0}, Lcom/b/a/a/e/y;->a(IBS)I

    move-result v1

    .line 1212
    iget-object v2, p0, Lcom/b/a/a/e/y;->c:Lcom/b/b/h;

    invoke-interface {p2, v3, v6, v2, v1}, Lcom/b/a/a/e/aa;->a(ZILcom/b/b/h;I)V

    .line 1213
    iget-object v1, p0, Lcom/b/a/a/e/y;->c:Lcom/b/b/h;

    int-to-long v2, v0

    invoke-interface {v1, v2, v3}, Lcom/b/b/h;->f(J)V

    goto/16 :goto_0

    .line 2169
    :pswitch_1
    if-nez v6, :cond_9

    const-string v1, "PROTOCOL_ERROR: TYPE_HEADERS streamId == 0"

    new-array v0, v0, [Ljava/lang/Object;

    invoke-static {v1, v0}, Lcom/b/a/a/e/g;->b(Ljava/lang/String;[Ljava/lang/Object;)Ljava/io/IOException;

    move-result-object v0

    throw v0

    .line 2171
    :cond_9
    and-int/lit8 v2, v5, 0x1

    if-eqz v2, :cond_a

    move v3, v4

    .line 2173
    :goto_3
    and-int/lit8 v2, v5, 0x8

    if-eqz v2, :cond_b

    iget-object v0, p0, Lcom/b/a/a/e/y;->c:Lcom/b/b/h;

    invoke-interface {v0}, Lcom/b/b/h;->e()B

    move-result v0

    and-int/lit16 v0, v0, 0xff

    int-to-short v0, v0

    move v2, v0

    .line 2175
    :goto_4
    and-int/lit8 v0, v5, 0x20

    if-eqz v0, :cond_22

    .line 2176
    invoke-direct {p0}, Lcom/b/a/a/e/y;->a()V

    .line 2177
    add-int/lit8 v0, v1, -0x5

    .line 2180
    :goto_5
    invoke-static {v0, v5, v2}, Lcom/b/a/a/e/y;->a(IBS)I

    move-result v0

    .line 2182
    invoke-direct {p0, v0, v2, v5, v6}, Lcom/b/a/a/e/y;->a(ISBI)Ljava/util/List;

    move-result-object v0

    .line 2184
    invoke-interface {p2, v3, v6, v0}, Lcom/b/a/a/e/aa;->a(ZILjava/util/List;)V

    goto/16 :goto_0

    :cond_a
    move v3, v0

    .line 2171
    goto :goto_3

    :cond_b
    move v2, v0

    .line 2173
    goto :goto_4

    .line 2218
    :pswitch_2
    const/4 v2, 0x5

    if-eq v1, v2, :cond_c

    const-string v2, "TYPE_PRIORITY length: %d != 5"

    new-array v3, v4, [Ljava/lang/Object;

    invoke-static {v1}, Ljava/lang/Integer;->valueOf(I)Ljava/lang/Integer;

    move-result-object v1

    aput-object v1, v3, v0

    invoke-static {v2, v3}, Lcom/b/a/a/e/g;->b(Ljava/lang/String;[Ljava/lang/Object;)Ljava/io/IOException;

    move-result-object v0

    throw v0

    .line 2219
    :cond_c
    if-nez v6, :cond_d

    const-string v1, "TYPE_PRIORITY streamId == 0"

    new-array v0, v0, [Ljava/lang/Object;

    invoke-static {v1, v0}, Lcom/b/a/a/e/g;->b(Ljava/lang/String;[Ljava/lang/Object;)Ljava/io/IOException;

    move-result-object v0

    throw v0

    .line 2220
    :cond_d
    invoke-direct {p0}, Lcom/b/a/a/e/y;->a()V

    goto/16 :goto_0

    .line 2233
    :pswitch_3
    if-eq v1, v3, :cond_e

    const-string v2, "TYPE_RST_STREAM length: %d != 4"

    new-array v3, v4, [Ljava/lang/Object;

    invoke-static {v1}, Ljava/lang/Integer;->valueOf(I)Ljava/lang/Integer;

    move-result-object v1

    aput-object v1, v3, v0

    invoke-static {v2, v3}, Lcom/b/a/a/e/g;->b(Ljava/lang/String;[Ljava/lang/Object;)Ljava/io/IOException;

    move-result-object v0

    throw v0

    .line 2234
    :cond_e
    if-nez v6, :cond_f

    const-string v1, "TYPE_RST_STREAM streamId == 0"

    new-array v0, v0, [Ljava/lang/Object;

    invoke-static {v1, v0}, Lcom/b/a/a/e/g;->b(Ljava/lang/String;[Ljava/lang/Object;)Ljava/io/IOException;

    move-result-object v0

    throw v0

    .line 2235
    :cond_f
    iget-object v1, p0, Lcom/b/a/a/e/y;->c:Lcom/b/b/h;

    invoke-interface {v1}, Lcom/b/b/h;->g()I

    move-result v1

    .line 2236
    invoke-static {v1}, Lcom/b/a/a/e/b;->a(I)Lcom/b/a/a/e/b;

    move-result-object v2

    .line 2237
    if-nez v2, :cond_10

    .line 2238
    const-string v2, "TYPE_RST_STREAM unexpected error code: %d"

    new-array v3, v4, [Ljava/lang/Object;

    invoke-static {v1}, Ljava/lang/Integer;->valueOf(I)Ljava/lang/Integer;

    move-result-object v1

    aput-object v1, v3, v0

    invoke-static {v2, v3}, Lcom/b/a/a/e/g;->b(Ljava/lang/String;[Ljava/lang/Object;)Ljava/io/IOException;

    move-result-object v0

    throw v0

    .line 2240
    :cond_10
    invoke-interface {p2, v6, v2}, Lcom/b/a/a/e/aa;->a(ILcom/b/a/a/e/b;)V

    goto/16 :goto_0

    .line 2245
    :pswitch_4
    if-eqz v6, :cond_11

    const-string v1, "TYPE_SETTINGS streamId != 0"

    new-array v0, v0, [Ljava/lang/Object;

    invoke-static {v1, v0}, Lcom/b/a/a/e/g;->b(Ljava/lang/String;[Ljava/lang/Object;)Ljava/io/IOException;

    move-result-object v0

    throw v0

    .line 2246
    :cond_11
    and-int/lit8 v2, v5, 0x1

    if-eqz v2, :cond_12

    .line 2247
    if-eqz v1, :cond_1

    const-string v1, "FRAME_SIZE_ERROR ack frame should be empty!"

    new-array v0, v0, [Ljava/lang/Object;

    invoke-static {v1, v0}, Lcom/b/a/a/e/g;->b(Ljava/lang/String;[Ljava/lang/Object;)Ljava/io/IOException;

    move-result-object v0

    throw v0

    .line 2252
    :cond_12
    rem-int/lit8 v2, v1, 0x6

    if-eqz v2, :cond_13

    const-string v2, "TYPE_SETTINGS length %% 6 != 0: %s"

    new-array v3, v4, [Ljava/lang/Object;

    invoke-static {v1}, Ljava/lang/Integer;->valueOf(I)Ljava/lang/Integer;

    move-result-object v1

    aput-object v1, v3, v0

    invoke-static {v2, v3}, Lcom/b/a/a/e/g;->b(Ljava/lang/String;[Ljava/lang/Object;)Ljava/io/IOException;

    move-result-object v0

    throw v0

    .line 2253
    :cond_13
    new-instance v6, Lcom/b/a/a/e/al;

    invoke-direct {v6}, Lcom/b/a/a/e/al;-><init>()V

    move v5, v0

    .line 2254
    :goto_6
    if-ge v5, v1, :cond_16

    .line 2255
    iget-object v2, p0, Lcom/b/a/a/e/y;->c:Lcom/b/b/h;

    invoke-interface {v2}, Lcom/b/b/h;->f()S

    move-result v2

    .line 2256
    iget-object v7, p0, Lcom/b/a/a/e/y;->c:Lcom/b/b/h;

    invoke-interface {v7}, Lcom/b/b/h;->g()I

    move-result v7

    .line 2258
    packed-switch v2, :pswitch_data_1

    .line 2285
    :cond_14
    :goto_7
    :pswitch_5
    invoke-virtual {v6, v2, v7}, Lcom/b/a/a/e/al;->a(II)Lcom/b/a/a/e/al;

    .line 2254
    add-int/lit8 v2, v5, 0x6

    move v5, v2

    goto :goto_6

    .line 2262
    :pswitch_6
    if-eqz v7, :cond_14

    if-eq v7, v4, :cond_14

    .line 2263
    const-string v1, "PROTOCOL_ERROR SETTINGS_ENABLE_PUSH != 0 or 1"

    new-array v0, v0, [Ljava/lang/Object;

    invoke-static {v1, v0}, Lcom/b/a/a/e/g;->b(Ljava/lang/String;[Ljava/lang/Object;)Ljava/io/IOException;

    move-result-object v0

    throw v0

    :pswitch_7
    move v2, v3

    .line 2268
    goto :goto_7

    .line 2270
    :pswitch_8
    const/4 v2, 0x7

    .line 2271
    if-gez v7, :cond_14

    .line 2272
    const-string v1, "PROTOCOL_ERROR SETTINGS_INITIAL_WINDOW_SIZE > 2^31 - 1"

    new-array v0, v0, [Ljava/lang/Object;

    invoke-static {v1, v0}, Lcom/b/a/a/e/g;->b(Ljava/lang/String;[Ljava/lang/Object;)Ljava/io/IOException;

    move-result-object v0

    throw v0

    .line 2276
    :pswitch_9
    if-lt v7, v10, :cond_15

    const v8, 0xffffff

    if-le v7, v8, :cond_14

    .line 2277
    :cond_15
    const-string v1, "PROTOCOL_ERROR SETTINGS_MAX_FRAME_SIZE: %s"

    new-array v2, v4, [Ljava/lang/Object;

    invoke-static {v7}, Ljava/lang/Integer;->valueOf(I)Ljava/lang/Integer;

    move-result-object v3

    aput-object v3, v2, v0

    invoke-static {v1, v2}, Lcom/b/a/a/e/g;->b(Ljava/lang/String;[Ljava/lang/Object;)Ljava/io/IOException;

    move-result-object v0

    throw v0

    .line 2287
    :cond_16
    invoke-interface {p2, v6}, Lcom/b/a/a/e/aa;->a(Lcom/b/a/a/e/al;)V

    goto/16 :goto_0

    .line 2292
    :pswitch_a
    if-nez v6, :cond_17

    .line 2293
    const-string v1, "PROTOCOL_ERROR: TYPE_PUSH_PROMISE streamId == 0"

    new-array v0, v0, [Ljava/lang/Object;

    invoke-static {v1, v0}, Lcom/b/a/a/e/g;->b(Ljava/lang/String;[Ljava/lang/Object;)Ljava/io/IOException;

    move-result-object v0

    throw v0

    .line 2295
    :cond_17
    and-int/lit8 v2, v5, 0x8

    if-eqz v2, :cond_18

    iget-object v0, p0, Lcom/b/a/a/e/y;->c:Lcom/b/b/h;

    invoke-interface {v0}, Lcom/b/b/h;->e()B

    move-result v0

    and-int/lit16 v0, v0, 0xff

    int-to-short v0, v0

    .line 2296
    :cond_18
    iget-object v2, p0, Lcom/b/a/a/e/y;->c:Lcom/b/b/h;

    invoke-interface {v2}, Lcom/b/b/h;->g()I

    move-result v2

    const v3, 0x7fffffff

    and-int/2addr v2, v3

    .line 2297
    add-int/lit8 v1, v1, -0x4

    .line 2298
    invoke-static {v1, v5, v0}, Lcom/b/a/a/e/y;->a(IBS)I

    move-result v1

    .line 2299
    invoke-direct {p0, v1, v0, v5, v6}, Lcom/b/a/a/e/y;->a(ISBI)Ljava/util/List;

    move-result-object v0

    .line 2300
    invoke-interface {p2, v2, v0}, Lcom/b/a/a/e/aa;->a(ILjava/util/List;)V

    goto/16 :goto_0

    .line 2305
    :pswitch_b
    if-eq v1, v9, :cond_19

    const-string v2, "TYPE_PING length != 8: %s"

    new-array v3, v4, [Ljava/lang/Object;

    invoke-static {v1}, Ljava/lang/Integer;->valueOf(I)Ljava/lang/Integer;

    move-result-object v1

    aput-object v1, v3, v0

    invoke-static {v2, v3}, Lcom/b/a/a/e/g;->b(Ljava/lang/String;[Ljava/lang/Object;)Ljava/io/IOException;

    move-result-object v0

    throw v0

    .line 2306
    :cond_19
    if-eqz v6, :cond_1a

    const-string v1, "TYPE_PING streamId != 0"

    new-array v0, v0, [Ljava/lang/Object;

    invoke-static {v1, v0}, Lcom/b/a/a/e/g;->b(Ljava/lang/String;[Ljava/lang/Object;)Ljava/io/IOException;

    move-result-object v0

    throw v0

    .line 2307
    :cond_1a
    iget-object v1, p0, Lcom/b/a/a/e/y;->c:Lcom/b/b/h;

    invoke-interface {v1}, Lcom/b/b/h;->g()I

    move-result v1

    .line 2308
    iget-object v2, p0, Lcom/b/a/a/e/y;->c:Lcom/b/b/h;

    invoke-interface {v2}, Lcom/b/b/h;->g()I

    move-result v2

    .line 2309
    and-int/lit8 v3, v5, 0x1

    if-eqz v3, :cond_1b

    move v0, v4

    .line 2310
    :cond_1b
    invoke-interface {p2, v0, v1, v2}, Lcom/b/a/a/e/aa;->a(ZII)V

    goto/16 :goto_0

    .line 2315
    :pswitch_c
    if-ge v1, v9, :cond_1c

    const-string v2, "TYPE_GOAWAY length < 8: %s"

    new-array v3, v4, [Ljava/lang/Object;

    invoke-static {v1}, Ljava/lang/Integer;->valueOf(I)Ljava/lang/Integer;

    move-result-object v1

    aput-object v1, v3, v0

    invoke-static {v2, v3}, Lcom/b/a/a/e/g;->b(Ljava/lang/String;[Ljava/lang/Object;)Ljava/io/IOException;

    move-result-object v0

    throw v0

    .line 2316
    :cond_1c
    if-eqz v6, :cond_1d

    const-string v1, "TYPE_GOAWAY streamId != 0"

    new-array v0, v0, [Ljava/lang/Object;

    invoke-static {v1, v0}, Lcom/b/a/a/e/g;->b(Ljava/lang/String;[Ljava/lang/Object;)Ljava/io/IOException;

    move-result-object v0

    throw v0

    .line 2317
    :cond_1d
    iget-object v2, p0, Lcom/b/a/a/e/y;->c:Lcom/b/b/h;

    invoke-interface {v2}, Lcom/b/b/h;->g()I

    move-result v2

    .line 2318
    iget-object v3, p0, Lcom/b/a/a/e/y;->c:Lcom/b/b/h;

    invoke-interface {v3}, Lcom/b/b/h;->g()I

    move-result v3

    .line 2319
    add-int/lit8 v1, v1, -0x8

    .line 2320
    invoke-static {v3}, Lcom/b/a/a/e/b;->a(I)Lcom/b/a/a/e/b;

    move-result-object v5

    .line 2321
    if-nez v5, :cond_1e

    .line 2322
    const-string v1, "TYPE_GOAWAY unexpected error code: %d"

    new-array v2, v4, [Ljava/lang/Object;

    invoke-static {v3}, Ljava/lang/Integer;->valueOf(I)Ljava/lang/Integer;

    move-result-object v3

    aput-object v3, v2, v0

    invoke-static {v1, v2}, Lcom/b/a/a/e/g;->b(Ljava/lang/String;[Ljava/lang/Object;)Ljava/io/IOException;

    move-result-object v0

    throw v0

    .line 2324
    :cond_1e
    sget-object v0, Lcom/b/b/i;->b:Lcom/b/b/i;

    .line 2325
    if-lez v1, :cond_1f

    .line 2326
    iget-object v0, p0, Lcom/b/a/a/e/y;->c:Lcom/b/b/h;

    int-to-long v6, v1

    invoke-interface {v0, v6, v7}, Lcom/b/b/h;->c(J)Lcom/b/b/i;

    move-result-object v0

    .line 2328
    :cond_1f
    invoke-interface {p2, v2, v0}, Lcom/b/a/a/e/aa;->a(ILcom/b/b/i;)V

    goto/16 :goto_0

    .line 2333
    :pswitch_d
    if-eq v1, v3, :cond_20

    const-string v2, "TYPE_WINDOW_UPDATE length !=4: %s"

    new-array v3, v4, [Ljava/lang/Object;

    invoke-static {v1}, Ljava/lang/Integer;->valueOf(I)Ljava/lang/Integer;

    move-result-object v1

    aput-object v1, v3, v0

    invoke-static {v2, v3}, Lcom/b/a/a/e/g;->b(Ljava/lang/String;[Ljava/lang/Object;)Ljava/io/IOException;

    move-result-object v0

    throw v0

    .line 2334
    :cond_20
    iget-object v1, p0, Lcom/b/a/a/e/y;->c:Lcom/b/b/h;

    invoke-interface {v1}, Lcom/b/b/h;->g()I

    move-result v1

    int-to-long v2, v1

    const-wide/32 v8, 0x7fffffff

    and-long/2addr v2, v8

    .line 2335
    const-wide/16 v8, 0x0

    cmp-long v1, v2, v8

    if-nez v1, :cond_21

    const-string v1, "windowSizeIncrement was 0"

    new-array v4, v4, [Ljava/lang/Object;

    invoke-static {v2, v3}, Ljava/lang/Long;->valueOf(J)Ljava/lang/Long;

    move-result-object v2

    aput-object v2, v4, v0

    invoke-static {v1, v4}, Lcom/b/a/a/e/g;->b(Ljava/lang/String;[Ljava/lang/Object;)Ljava/io/IOException;

    move-result-object v0

    throw v0

    .line 2336
    :cond_21
    invoke-interface {p2, v6, v2, v3}, Lcom/b/a/a/e/aa;->a(IJ)V

    goto/16 :goto_0

    :cond_22
    move v0, v1

    goto/16 :goto_5

    .line 123
    nop

    :pswitch_data_0
    .packed-switch 0x0
        :pswitch_0
        :pswitch_1
        :pswitch_2
        :pswitch_3
        :pswitch_4
        :pswitch_a
        :pswitch_b
        :pswitch_c
        :pswitch_d
    .end packed-switch

    .line 2258
    :pswitch_data_1
    .packed-switch 0x1
        :pswitch_5
        :pswitch_6
        :pswitch_7
        :pswitch_8
        :pswitch_9
    .end packed-switch
.end method

.method public final close()V
    .locals 1

    .prologue
    .line 340
    iget-object v0, p0, Lcom/b/a/a/e/y;->c:Lcom/b/b/h;

    invoke-interface {v0}, Lcom/b/b/h;->close()V

    .line 341
    return-void
.end method
