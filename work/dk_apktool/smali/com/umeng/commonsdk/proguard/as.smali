.class public Lcom/umeng/commonsdk/proguard/as;
.super Lcom/umeng/commonsdk/proguard/az;
.source "TBinaryProtocol.java"


# annotations
.annotation system Ldalvik/annotation/MemberClasses;
    value = {
        Lcom/umeng/commonsdk/proguard/as$a;
    }
.end annotation


# static fields
.field protected static final a:I = -0x10000

.field protected static final b:I = -0x7fff0000

.field private static final h:Lcom/umeng/commonsdk/proguard/be;


# instance fields
.field protected c:Z

.field protected d:Z

.field protected e:I

.field protected f:Z

.field private i:[B

.field private j:[B

.field private k:[B

.field private l:[B

.field private m:[B

.field private n:[B

.field private o:[B

.field private p:[B


# direct methods
.method static constructor <clinit>()V
    .locals 1

    .prologue
    .line 34
    new-instance v0, Lcom/umeng/commonsdk/proguard/be;

    invoke-direct {v0}, Lcom/umeng/commonsdk/proguard/be;-><init>()V

    sput-object v0, Lcom/umeng/commonsdk/proguard/as;->h:Lcom/umeng/commonsdk/proguard/be;

    return-void
.end method

.method public constructor <init>(Lcom/umeng/commonsdk/proguard/bn;)V
    .locals 2

    .prologue
    .line 84
    const/4 v0, 0x0

    const/4 v1, 0x1

    invoke-direct {p0, p1, v0, v1}, Lcom/umeng/commonsdk/proguard/as;-><init>(Lcom/umeng/commonsdk/proguard/bn;ZZ)V

    .line 85
    return-void
.end method

.method public constructor <init>(Lcom/umeng/commonsdk/proguard/bn;ZZ)V
    .locals 5

    .prologue
    const/16 v4, 0x8

    const/4 v3, 0x4

    const/4 v2, 0x2

    const/4 v0, 0x0

    const/4 v1, 0x1

    .line 88
    invoke-direct {p0, p1}, Lcom/umeng/commonsdk/proguard/az;-><init>(Lcom/umeng/commonsdk/proguard/bn;)V

    .line 39
    iput-boolean v0, p0, Lcom/umeng/commonsdk/proguard/as;->c:Z

    .line 40
    iput-boolean v1, p0, Lcom/umeng/commonsdk/proguard/as;->d:Z

    .line 43
    iput-boolean v0, p0, Lcom/umeng/commonsdk/proguard/as;->f:Z

    .line 149
    new-array v0, v1, [B

    iput-object v0, p0, Lcom/umeng/commonsdk/proguard/as;->i:[B

    .line 155
    new-array v0, v2, [B

    iput-object v0, p0, Lcom/umeng/commonsdk/proguard/as;->j:[B

    .line 162
    new-array v0, v3, [B

    iput-object v0, p0, Lcom/umeng/commonsdk/proguard/as;->k:[B

    .line 171
    new-array v0, v4, [B

    iput-object v0, p0, Lcom/umeng/commonsdk/proguard/as;->l:[B

    .line 262
    new-array v0, v1, [B

    iput-object v0, p0, Lcom/umeng/commonsdk/proguard/as;->m:[B

    .line 273
    new-array v0, v2, [B

    iput-object v0, p0, Lcom/umeng/commonsdk/proguard/as;->n:[B

    .line 292
    new-array v0, v3, [B

    iput-object v0, p0, Lcom/umeng/commonsdk/proguard/as;->o:[B

    .line 311
    new-array v0, v4, [B

    iput-object v0, p0, Lcom/umeng/commonsdk/proguard/as;->p:[B

    .line 89
    iput-boolean p2, p0, Lcom/umeng/commonsdk/proguard/as;->c:Z

    .line 90
    iput-boolean p3, p0, Lcom/umeng/commonsdk/proguard/as;->d:Z

    .line 91
    return-void
.end method

.method private a([BII)I
    .locals 1
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Lcom/umeng/commonsdk/proguard/ag;
        }
    .end annotation

    .prologue
    .line 382
    invoke-virtual {p0, p3}, Lcom/umeng/commonsdk/proguard/as;->d(I)V

    .line 383
    iget-object v0, p0, Lcom/umeng/commonsdk/proguard/as;->g:Lcom/umeng/commonsdk/proguard/bn;

    invoke-virtual {v0, p1, p2, p3}, Lcom/umeng/commonsdk/proguard/bn;->d([BII)I

    move-result v0

    return v0
.end method


# virtual methods
.method public A()Ljava/nio/ByteBuffer;
    .locals 4
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Lcom/umeng/commonsdk/proguard/ag;
        }
    .end annotation

    .prologue
    .line 367
    invoke-virtual {p0}, Lcom/umeng/commonsdk/proguard/as;->w()I

    move-result v1

    .line 368
    invoke-virtual {p0, v1}, Lcom/umeng/commonsdk/proguard/as;->d(I)V

    .line 370
    iget-object v0, p0, Lcom/umeng/commonsdk/proguard/as;->g:Lcom/umeng/commonsdk/proguard/bn;

    invoke-virtual {v0}, Lcom/umeng/commonsdk/proguard/bn;->h()I

    move-result v0

    if-lt v0, v1, :cond_0

    .line 371
    iget-object v0, p0, Lcom/umeng/commonsdk/proguard/as;->g:Lcom/umeng/commonsdk/proguard/bn;

    invoke-virtual {v0}, Lcom/umeng/commonsdk/proguard/bn;->f()[B

    move-result-object v0

    iget-object v2, p0, Lcom/umeng/commonsdk/proguard/as;->g:Lcom/umeng/commonsdk/proguard/bn;

    invoke-virtual {v2}, Lcom/umeng/commonsdk/proguard/bn;->g()I

    move-result v2

    invoke-static {v0, v2, v1}, Ljava/nio/ByteBuffer;->wrap([BII)Ljava/nio/ByteBuffer;

    move-result-object v0

    .line 372
    iget-object v2, p0, Lcom/umeng/commonsdk/proguard/as;->g:Lcom/umeng/commonsdk/proguard/bn;

    invoke-virtual {v2, v1}, Lcom/umeng/commonsdk/proguard/bn;->a(I)V

    .line 378
    :goto_0
    return-object v0

    .line 376
    :cond_0
    new-array v0, v1, [B

    .line 377
    iget-object v2, p0, Lcom/umeng/commonsdk/proguard/as;->g:Lcom/umeng/commonsdk/proguard/bn;

    const/4 v3, 0x0

    invoke-virtual {v2, v0, v3, v1}, Lcom/umeng/commonsdk/proguard/bn;->d([BII)I

    .line 378
    invoke-static {v0}, Ljava/nio/ByteBuffer;->wrap([B)Ljava/nio/ByteBuffer;

    move-result-object v0

    goto :goto_0
.end method

.method public a()V
    .locals 0

    .prologue
    .line 106
    return-void
.end method

.method public a(B)V
    .locals 4
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Lcom/umeng/commonsdk/proguard/ag;
        }
    .end annotation

    .prologue
    const/4 v3, 0x0

    .line 151
    iget-object v0, p0, Lcom/umeng/commonsdk/proguard/as;->i:[B

    aput-byte p1, v0, v3

    .line 152
    iget-object v0, p0, Lcom/umeng/commonsdk/proguard/as;->g:Lcom/umeng/commonsdk/proguard/bn;

    iget-object v1, p0, Lcom/umeng/commonsdk/proguard/as;->i:[B

    const/4 v2, 0x1

    invoke-virtual {v0, v1, v3, v2}, Lcom/umeng/commonsdk/proguard/bn;->b([BII)V

    .line 153
    return-void
.end method

.method public a(D)V
    .locals 3
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Lcom/umeng/commonsdk/proguard/ag;
        }
    .end annotation

    .prologue
    .line 185
    invoke-static {p1, p2}, Ljava/lang/Double;->doubleToLongBits(D)J

    move-result-wide v0

    invoke-virtual {p0, v0, v1}, Lcom/umeng/commonsdk/proguard/as;->a(J)V

    .line 186
    return-void
.end method

.method public a(I)V
    .locals 4
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Lcom/umeng/commonsdk/proguard/ag;
        }
    .end annotation

    .prologue
    const/4 v3, 0x0

    .line 164
    iget-object v0, p0, Lcom/umeng/commonsdk/proguard/as;->k:[B

    shr-int/lit8 v1, p1, 0x18

    and-int/lit16 v1, v1, 0xff

    int-to-byte v1, v1

    aput-byte v1, v0, v3

    .line 165
    iget-object v0, p0, Lcom/umeng/commonsdk/proguard/as;->k:[B

    const/4 v1, 0x1

    shr-int/lit8 v2, p1, 0x10

    and-int/lit16 v2, v2, 0xff

    int-to-byte v2, v2

    aput-byte v2, v0, v1

    .line 166
    iget-object v0, p0, Lcom/umeng/commonsdk/proguard/as;->k:[B

    const/4 v1, 0x2

    shr-int/lit8 v2, p1, 0x8

    and-int/lit16 v2, v2, 0xff

    int-to-byte v2, v2

    aput-byte v2, v0, v1

    .line 167
    iget-object v0, p0, Lcom/umeng/commonsdk/proguard/as;->k:[B

    const/4 v1, 0x3

    and-int/lit16 v2, p1, 0xff

    int-to-byte v2, v2

    aput-byte v2, v0, v1

    .line 168
    iget-object v0, p0, Lcom/umeng/commonsdk/proguard/as;->g:Lcom/umeng/commonsdk/proguard/bn;

    iget-object v1, p0, Lcom/umeng/commonsdk/proguard/as;->k:[B

    const/4 v2, 0x4

    invoke-virtual {v0, v1, v3, v2}, Lcom/umeng/commonsdk/proguard/bn;->b([BII)V

    .line 169
    return-void
.end method

.method public a(J)V
    .locals 9
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Lcom/umeng/commonsdk/proguard/ag;
        }
    .end annotation

    .prologue
    const/16 v7, 0x8

    const/4 v6, 0x0

    const-wide/16 v4, 0xff

    .line 173
    iget-object v0, p0, Lcom/umeng/commonsdk/proguard/as;->l:[B

    const/16 v1, 0x38

    shr-long v2, p1, v1

    and-long/2addr v2, v4

    long-to-int v1, v2

    int-to-byte v1, v1

    aput-byte v1, v0, v6

    .line 174
    iget-object v0, p0, Lcom/umeng/commonsdk/proguard/as;->l:[B

    const/4 v1, 0x1

    const/16 v2, 0x30

    shr-long v2, p1, v2

    and-long/2addr v2, v4

    long-to-int v2, v2

    int-to-byte v2, v2

    aput-byte v2, v0, v1

    .line 175
    iget-object v0, p0, Lcom/umeng/commonsdk/proguard/as;->l:[B

    const/4 v1, 0x2

    const/16 v2, 0x28

    shr-long v2, p1, v2

    and-long/2addr v2, v4

    long-to-int v2, v2

    int-to-byte v2, v2

    aput-byte v2, v0, v1

    .line 176
    iget-object v0, p0, Lcom/umeng/commonsdk/proguard/as;->l:[B

    const/4 v1, 0x3

    const/16 v2, 0x20

    shr-long v2, p1, v2

    and-long/2addr v2, v4

    long-to-int v2, v2

    int-to-byte v2, v2

    aput-byte v2, v0, v1

    .line 177
    iget-object v0, p0, Lcom/umeng/commonsdk/proguard/as;->l:[B

    const/4 v1, 0x4

    const/16 v2, 0x18

    shr-long v2, p1, v2

    and-long/2addr v2, v4

    long-to-int v2, v2

    int-to-byte v2, v2

    aput-byte v2, v0, v1

    .line 178
    iget-object v0, p0, Lcom/umeng/commonsdk/proguard/as;->l:[B

    const/4 v1, 0x5

    const/16 v2, 0x10

    shr-long v2, p1, v2

    and-long/2addr v2, v4

    long-to-int v2, v2

    int-to-byte v2, v2

    aput-byte v2, v0, v1

    .line 179
    iget-object v0, p0, Lcom/umeng/commonsdk/proguard/as;->l:[B

    const/4 v1, 0x6

    shr-long v2, p1, v7

    and-long/2addr v2, v4

    long-to-int v2, v2

    int-to-byte v2, v2

    aput-byte v2, v0, v1

    .line 180
    iget-object v0, p0, Lcom/umeng/commonsdk/proguard/as;->l:[B

    const/4 v1, 0x7

    and-long v2, v4, p1

    long-to-int v2, v2

    int-to-byte v2, v2

    aput-byte v2, v0, v1

    .line 181
    iget-object v0, p0, Lcom/umeng/commonsdk/proguard/as;->g:Lcom/umeng/commonsdk/proguard/bn;

    iget-object v1, p0, Lcom/umeng/commonsdk/proguard/as;->l:[B

    invoke-virtual {v0, v1, v6, v7}, Lcom/umeng/commonsdk/proguard/bn;->b([BII)V

    .line 182
    return-void
.end method

.method public a(Lcom/umeng/commonsdk/proguard/au;)V
    .locals 1
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Lcom/umeng/commonsdk/proguard/ag;
        }
    .end annotation

    .prologue
    .line 113
    iget-byte v0, p1, Lcom/umeng/commonsdk/proguard/au;->b:B

    invoke-virtual {p0, v0}, Lcom/umeng/commonsdk/proguard/as;->a(B)V

    .line 114
    iget-short v0, p1, Lcom/umeng/commonsdk/proguard/au;->c:S

    invoke-virtual {p0, v0}, Lcom/umeng/commonsdk/proguard/as;->a(S)V

    .line 115
    return-void
.end method

.method public a(Lcom/umeng/commonsdk/proguard/av;)V
    .locals 1
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Lcom/umeng/commonsdk/proguard/ag;
        }
    .end annotation

    .prologue
    .line 132
    iget-byte v0, p1, Lcom/umeng/commonsdk/proguard/av;->a:B

    invoke-virtual {p0, v0}, Lcom/umeng/commonsdk/proguard/as;->a(B)V

    .line 133
    iget v0, p1, Lcom/umeng/commonsdk/proguard/av;->b:I

    invoke-virtual {p0, v0}, Lcom/umeng/commonsdk/proguard/as;->a(I)V

    .line 134
    return-void
.end method

.method public a(Lcom/umeng/commonsdk/proguard/aw;)V
    .locals 1
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Lcom/umeng/commonsdk/proguard/ag;
        }
    .end annotation

    .prologue
    .line 124
    iget-byte v0, p1, Lcom/umeng/commonsdk/proguard/aw;->a:B

    invoke-virtual {p0, v0}, Lcom/umeng/commonsdk/proguard/as;->a(B)V

    .line 125
    iget-byte v0, p1, Lcom/umeng/commonsdk/proguard/aw;->b:B

    invoke-virtual {p0, v0}, Lcom/umeng/commonsdk/proguard/as;->a(B)V

    .line 126
    iget v0, p1, Lcom/umeng/commonsdk/proguard/aw;->c:I

    invoke-virtual {p0, v0}, Lcom/umeng/commonsdk/proguard/as;->a(I)V

    .line 127
    return-void
.end method

.method public a(Lcom/umeng/commonsdk/proguard/ax;)V
    .locals 2
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Lcom/umeng/commonsdk/proguard/ag;
        }
    .end annotation

    .prologue
    .line 94
    iget-boolean v0, p0, Lcom/umeng/commonsdk/proguard/as;->d:Z

    if-eqz v0, :cond_0

    .line 95
    const/high16 v0, -0x7fff0000

    iget-byte v1, p1, Lcom/umeng/commonsdk/proguard/ax;->b:B

    or-int/2addr v0, v1

    .line 96
    invoke-virtual {p0, v0}, Lcom/umeng/commonsdk/proguard/as;->a(I)V

    .line 97
    iget-object v0, p1, Lcom/umeng/commonsdk/proguard/ax;->a:Ljava/lang/String;

    invoke-virtual {p0, v0}, Lcom/umeng/commonsdk/proguard/as;->a(Ljava/lang/String;)V

    .line 98
    iget v0, p1, Lcom/umeng/commonsdk/proguard/ax;->c:I

    invoke-virtual {p0, v0}, Lcom/umeng/commonsdk/proguard/as;->a(I)V

    .line 104
    :goto_0
    return-void

    .line 100
    :cond_0
    iget-object v0, p1, Lcom/umeng/commonsdk/proguard/ax;->a:Ljava/lang/String;

    invoke-virtual {p0, v0}, Lcom/umeng/commonsdk/proguard/as;->a(Ljava/lang/String;)V

    .line 101
    iget-byte v0, p1, Lcom/umeng/commonsdk/proguard/ax;->b:B

    invoke-virtual {p0, v0}, Lcom/umeng/commonsdk/proguard/as;->a(B)V

    .line 102
    iget v0, p1, Lcom/umeng/commonsdk/proguard/ax;->c:I

    invoke-virtual {p0, v0}, Lcom/umeng/commonsdk/proguard/as;->a(I)V

    goto :goto_0
.end method

.method public a(Lcom/umeng/commonsdk/proguard/bd;)V
    .locals 1
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Lcom/umeng/commonsdk/proguard/ag;
        }
    .end annotation

    .prologue
    .line 139
    iget-byte v0, p1, Lcom/umeng/commonsdk/proguard/bd;->a:B

    invoke-virtual {p0, v0}, Lcom/umeng/commonsdk/proguard/as;->a(B)V

    .line 140
    iget v0, p1, Lcom/umeng/commonsdk/proguard/bd;->b:I

    invoke-virtual {p0, v0}, Lcom/umeng/commonsdk/proguard/as;->a(I)V

    .line 141
    return-void
.end method

.method public a(Lcom/umeng/commonsdk/proguard/be;)V
    .locals 0

    .prologue
    .line 108
    return-void
.end method

.method public a(Ljava/lang/String;)V
    .locals 4
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Lcom/umeng/commonsdk/proguard/ag;
        }
    .end annotation

    .prologue
    .line 190
    :try_start_0
    const-string v0, "UTF-8"

    invoke-virtual {p1, v0}, Ljava/lang/String;->getBytes(Ljava/lang/String;)[B

    move-result-object v0

    .line 191
    array-length v1, v0

    invoke-virtual {p0, v1}, Lcom/umeng/commonsdk/proguard/as;->a(I)V

    .line 192
    iget-object v1, p0, Lcom/umeng/commonsdk/proguard/as;->g:Lcom/umeng/commonsdk/proguard/bn;

    const/4 v2, 0x0

    array-length v3, v0

    invoke-virtual {v1, v0, v2, v3}, Lcom/umeng/commonsdk/proguard/bn;->b([BII)V
    :try_end_0
    .catch Ljava/io/UnsupportedEncodingException; {:try_start_0 .. :try_end_0} :catch_0

    .line 196
    return-void

    .line 193
    :catch_0
    move-exception v0

    .line 194
    new-instance v0, Lcom/umeng/commonsdk/proguard/ag;

    const-string v1, "JVM DOES NOT SUPPORT UTF-8"

    invoke-direct {v0, v1}, Lcom/umeng/commonsdk/proguard/ag;-><init>(Ljava/lang/String;)V

    throw v0
.end method

.method public a(Ljava/nio/ByteBuffer;)V
    .locals 5
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Lcom/umeng/commonsdk/proguard/ag;
        }
    .end annotation

    .prologue
    .line 199
    invoke-virtual {p1}, Ljava/nio/ByteBuffer;->limit()I

    move-result v0

    invoke-virtual {p1}, Ljava/nio/ByteBuffer;->position()I

    move-result v1

    sub-int/2addr v0, v1

    .line 200
    invoke-virtual {p0, v0}, Lcom/umeng/commonsdk/proguard/as;->a(I)V

    .line 201
    iget-object v1, p0, Lcom/umeng/commonsdk/proguard/as;->g:Lcom/umeng/commonsdk/proguard/bn;

    invoke-virtual {p1}, Ljava/nio/ByteBuffer;->array()[B

    move-result-object v2

    invoke-virtual {p1}, Ljava/nio/ByteBuffer;->position()I

    move-result v3

    invoke-virtual {p1}, Ljava/nio/ByteBuffer;->arrayOffset()I

    move-result v4

    add-int/2addr v3, v4

    invoke-virtual {v1, v2, v3, v0}, Lcom/umeng/commonsdk/proguard/bn;->b([BII)V

    .line 202
    return-void
.end method

.method public a(S)V
    .locals 4
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Lcom/umeng/commonsdk/proguard/ag;
        }
    .end annotation

    .prologue
    const/4 v3, 0x0

    .line 157
    iget-object v0, p0, Lcom/umeng/commonsdk/proguard/as;->j:[B

    shr-int/lit8 v1, p1, 0x8

    and-int/lit16 v1, v1, 0xff

    int-to-byte v1, v1

    aput-byte v1, v0, v3

    .line 158
    iget-object v0, p0, Lcom/umeng/commonsdk/proguard/as;->j:[B

    const/4 v1, 0x1

    and-int/lit16 v2, p1, 0xff

    int-to-byte v2, v2

    aput-byte v2, v0, v1

    .line 159
    iget-object v0, p0, Lcom/umeng/commonsdk/proguard/as;->g:Lcom/umeng/commonsdk/proguard/bn;

    iget-object v1, p0, Lcom/umeng/commonsdk/proguard/as;->j:[B

    const/4 v2, 0x2

    invoke-virtual {v0, v1, v3, v2}, Lcom/umeng/commonsdk/proguard/bn;->b([BII)V

    .line 160
    return-void
.end method

.method public a(Z)V
    .locals 1
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Lcom/umeng/commonsdk/proguard/ag;
        }
    .end annotation

    .prologue
    .line 146
    if-eqz p1, :cond_0

    const/4 v0, 0x1

    :goto_0
    invoke-virtual {p0, v0}, Lcom/umeng/commonsdk/proguard/as;->a(B)V

    .line 147
    return-void

    .line 146
    :cond_0
    const/4 v0, 0x0

    goto :goto_0
.end method

.method public b(I)Ljava/lang/String;
    .locals 3
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Lcom/umeng/commonsdk/proguard/ag;
        }
    .end annotation

    .prologue
    .line 357
    :try_start_0
    invoke-virtual {p0, p1}, Lcom/umeng/commonsdk/proguard/as;->d(I)V

    .line 358
    new-array v0, p1, [B

    .line 359
    iget-object v1, p0, Lcom/umeng/commonsdk/proguard/as;->g:Lcom/umeng/commonsdk/proguard/bn;

    const/4 v2, 0x0

    invoke-virtual {v1, v0, v2, p1}, Lcom/umeng/commonsdk/proguard/bn;->d([BII)I

    .line 360
    new-instance v1, Ljava/lang/String;

    const-string v2, "UTF-8"

    invoke-direct {v1, v0, v2}, Ljava/lang/String;-><init>([BLjava/lang/String;)V
    :try_end_0
    .catch Ljava/io/UnsupportedEncodingException; {:try_start_0 .. :try_end_0} :catch_0

    return-object v1

    .line 361
    :catch_0
    move-exception v0

    .line 362
    new-instance v0, Lcom/umeng/commonsdk/proguard/ag;

    const-string v1, "JVM DOES NOT SUPPORT UTF-8"

    invoke-direct {v0, v1}, Lcom/umeng/commonsdk/proguard/ag;-><init>(Ljava/lang/String;)V

    throw v0
.end method

.method public b()V
    .locals 0

    .prologue
    .line 110
    return-void
.end method

.method public c()V
    .locals 0

    .prologue
    .line 117
    return-void
.end method

.method public c(I)V
    .locals 1

    .prologue
    .line 387
    iput p1, p0, Lcom/umeng/commonsdk/proguard/as;->e:I

    .line 388
    const/4 v0, 0x1

    iput-boolean v0, p0, Lcom/umeng/commonsdk/proguard/as;->f:Z

    .line 389
    return-void
.end method

.method public d()V
    .locals 1
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Lcom/umeng/commonsdk/proguard/ag;
        }
    .end annotation

    .prologue
    .line 120
    const/4 v0, 0x0

    invoke-virtual {p0, v0}, Lcom/umeng/commonsdk/proguard/as;->a(B)V

    .line 121
    return-void
.end method

.method protected d(I)V
    .locals 3
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Lcom/umeng/commonsdk/proguard/ag;
        }
    .end annotation

    .prologue
    .line 392
    if-gez p1, :cond_0

    .line 393
    new-instance v0, Lcom/umeng/commonsdk/proguard/ba;

    new-instance v1, Ljava/lang/StringBuilder;

    invoke-direct {v1}, Ljava/lang/StringBuilder;-><init>()V

    const-string v2, "Negative length: "

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1, p1}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v1

    invoke-direct {v0, v1}, Lcom/umeng/commonsdk/proguard/ba;-><init>(Ljava/lang/String;)V

    throw v0

    .line 395
    :cond_0
    iget-boolean v0, p0, Lcom/umeng/commonsdk/proguard/as;->f:Z

    if-eqz v0, :cond_1

    .line 396
    iget v0, p0, Lcom/umeng/commonsdk/proguard/as;->e:I

    sub-int/2addr v0, p1

    iput v0, p0, Lcom/umeng/commonsdk/proguard/as;->e:I

    .line 397
    iget v0, p0, Lcom/umeng/commonsdk/proguard/as;->e:I

    if-gez v0, :cond_1

    .line 398
    new-instance v0, Lcom/umeng/commonsdk/proguard/ba;

    new-instance v1, Ljava/lang/StringBuilder;

    invoke-direct {v1}, Ljava/lang/StringBuilder;-><init>()V

    const-string v2, "Message length exceeded: "

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1, p1}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v1

    invoke-direct {v0, v1}, Lcom/umeng/commonsdk/proguard/ba;-><init>(Ljava/lang/String;)V

    throw v0

    .line 401
    :cond_1
    return-void
.end method

.method public e()V
    .locals 0

    .prologue
    .line 129
    return-void
.end method

.method public f()V
    .locals 0

    .prologue
    .line 136
    return-void
.end method

.method public g()V
    .locals 0

    .prologue
    .line 143
    return-void
.end method

.method public h()Lcom/umeng/commonsdk/proguard/ax;
    .locals 4
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Lcom/umeng/commonsdk/proguard/ag;
        }
    .end annotation

    .prologue
    const/4 v3, 0x4

    .line 209
    invoke-virtual {p0}, Lcom/umeng/commonsdk/proguard/as;->w()I

    move-result v1

    .line 210
    if-gez v1, :cond_1

    .line 211
    const/high16 v0, -0x10000

    and-int/2addr v0, v1

    .line 212
    const/high16 v2, -0x7fff0000

    if-eq v0, v2, :cond_0

    .line 213
    new-instance v0, Lcom/umeng/commonsdk/proguard/ba;

    const-string v1, "Bad version in readMessageBegin"

    invoke-direct {v0, v3, v1}, Lcom/umeng/commonsdk/proguard/ba;-><init>(ILjava/lang/String;)V

    throw v0

    .line 215
    :cond_0
    new-instance v0, Lcom/umeng/commonsdk/proguard/ax;

    invoke-virtual {p0}, Lcom/umeng/commonsdk/proguard/as;->z()Ljava/lang/String;

    move-result-object v2

    and-int/lit16 v1, v1, 0xff

    int-to-byte v1, v1

    invoke-virtual {p0}, Lcom/umeng/commonsdk/proguard/as;->w()I

    move-result v3

    invoke-direct {v0, v2, v1, v3}, Lcom/umeng/commonsdk/proguard/ax;-><init>(Ljava/lang/String;BI)V

    .line 220
    :goto_0
    return-object v0

    .line 217
    :cond_1
    iget-boolean v0, p0, Lcom/umeng/commonsdk/proguard/as;->c:Z

    if-eqz v0, :cond_2

    .line 218
    new-instance v0, Lcom/umeng/commonsdk/proguard/ba;

    const-string v1, "Missing version in readMessageBegin, old client?"

    invoke-direct {v0, v3, v1}, Lcom/umeng/commonsdk/proguard/ba;-><init>(ILjava/lang/String;)V

    throw v0

    .line 220
    :cond_2
    new-instance v0, Lcom/umeng/commonsdk/proguard/ax;

    invoke-virtual {p0, v1}, Lcom/umeng/commonsdk/proguard/as;->b(I)Ljava/lang/String;

    move-result-object v1

    invoke-virtual {p0}, Lcom/umeng/commonsdk/proguard/as;->u()B

    move-result v2

    invoke-virtual {p0}, Lcom/umeng/commonsdk/proguard/as;->w()I

    move-result v3

    invoke-direct {v0, v1, v2, v3}, Lcom/umeng/commonsdk/proguard/ax;-><init>(Ljava/lang/String;BI)V

    goto :goto_0
.end method

.method public i()V
    .locals 0

    .prologue
    .line 224
    return-void
.end method

.method public j()Lcom/umeng/commonsdk/proguard/be;
    .locals 1

    .prologue
    .line 227
    sget-object v0, Lcom/umeng/commonsdk/proguard/as;->h:Lcom/umeng/commonsdk/proguard/be;

    return-object v0
.end method

.method public k()V
    .locals 0

    .prologue
    .line 230
    return-void
.end method

.method public l()Lcom/umeng/commonsdk/proguard/au;
    .locals 4
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Lcom/umeng/commonsdk/proguard/ag;
        }
    .end annotation

    .prologue
    .line 233
    invoke-virtual {p0}, Lcom/umeng/commonsdk/proguard/as;->u()B

    move-result v1

    .line 234
    if-nez v1, :cond_0

    const/4 v0, 0x0

    .line 235
    :goto_0
    new-instance v2, Lcom/umeng/commonsdk/proguard/au;

    const-string v3, ""

    invoke-direct {v2, v3, v1, v0}, Lcom/umeng/commonsdk/proguard/au;-><init>(Ljava/lang/String;BS)V

    return-object v2

    .line 234
    :cond_0
    invoke-virtual {p0}, Lcom/umeng/commonsdk/proguard/as;->v()S

    move-result v0

    goto :goto_0
.end method

.method public m()V
    .locals 0

    .prologue
    .line 238
    return-void
.end method

.method public n()Lcom/umeng/commonsdk/proguard/aw;
    .locals 4
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Lcom/umeng/commonsdk/proguard/ag;
        }
    .end annotation

    .prologue
    .line 241
    new-instance v0, Lcom/umeng/commonsdk/proguard/aw;

    invoke-virtual {p0}, Lcom/umeng/commonsdk/proguard/as;->u()B

    move-result v1

    invoke-virtual {p0}, Lcom/umeng/commonsdk/proguard/as;->u()B

    move-result v2

    invoke-virtual {p0}, Lcom/umeng/commonsdk/proguard/as;->w()I

    move-result v3

    invoke-direct {v0, v1, v2, v3}, Lcom/umeng/commonsdk/proguard/aw;-><init>(BBI)V

    return-object v0
.end method

.method public o()V
    .locals 0

    .prologue
    .line 244
    return-void
.end method

.method public p()Lcom/umeng/commonsdk/proguard/av;
    .locals 3
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Lcom/umeng/commonsdk/proguard/ag;
        }
    .end annotation

    .prologue
    .line 247
    new-instance v0, Lcom/umeng/commonsdk/proguard/av;

    invoke-virtual {p0}, Lcom/umeng/commonsdk/proguard/as;->u()B

    move-result v1

    invoke-virtual {p0}, Lcom/umeng/commonsdk/proguard/as;->w()I

    move-result v2

    invoke-direct {v0, v1, v2}, Lcom/umeng/commonsdk/proguard/av;-><init>(BI)V

    return-object v0
.end method

.method public q()V
    .locals 0

    .prologue
    .line 250
    return-void
.end method

.method public r()Lcom/umeng/commonsdk/proguard/bd;
    .locals 3
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Lcom/umeng/commonsdk/proguard/ag;
        }
    .end annotation

    .prologue
    .line 253
    new-instance v0, Lcom/umeng/commonsdk/proguard/bd;

    invoke-virtual {p0}, Lcom/umeng/commonsdk/proguard/as;->u()B

    move-result v1

    invoke-virtual {p0}, Lcom/umeng/commonsdk/proguard/as;->w()I

    move-result v2

    invoke-direct {v0, v1, v2}, Lcom/umeng/commonsdk/proguard/bd;-><init>(BI)V

    return-object v0
.end method

.method public s()V
    .locals 0

    .prologue
    .line 256
    return-void
.end method

.method public t()Z
    .locals 2
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Lcom/umeng/commonsdk/proguard/ag;
        }
    .end annotation

    .prologue
    const/4 v0, 0x1

    .line 259
    invoke-virtual {p0}, Lcom/umeng/commonsdk/proguard/as;->u()B

    move-result v1

    if-ne v1, v0, :cond_0

    :goto_0
    return v0

    :cond_0
    const/4 v0, 0x0

    goto :goto_0
.end method

.method public u()B
    .locals 3
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Lcom/umeng/commonsdk/proguard/ag;
        }
    .end annotation

    .prologue
    const/4 v1, 0x0

    const/4 v2, 0x1

    .line 264
    iget-object v0, p0, Lcom/umeng/commonsdk/proguard/as;->g:Lcom/umeng/commonsdk/proguard/bn;

    invoke-virtual {v0}, Lcom/umeng/commonsdk/proguard/bn;->h()I

    move-result v0

    if-lt v0, v2, :cond_0

    .line 265
    iget-object v0, p0, Lcom/umeng/commonsdk/proguard/as;->g:Lcom/umeng/commonsdk/proguard/bn;

    invoke-virtual {v0}, Lcom/umeng/commonsdk/proguard/bn;->f()[B

    move-result-object v0

    iget-object v1, p0, Lcom/umeng/commonsdk/proguard/as;->g:Lcom/umeng/commonsdk/proguard/bn;

    invoke-virtual {v1}, Lcom/umeng/commonsdk/proguard/bn;->g()I

    move-result v1

    aget-byte v0, v0, v1

    .line 266
    iget-object v1, p0, Lcom/umeng/commonsdk/proguard/as;->g:Lcom/umeng/commonsdk/proguard/bn;

    invoke-virtual {v1, v2}, Lcom/umeng/commonsdk/proguard/bn;->a(I)V

    .line 270
    :goto_0
    return v0

    .line 269
    :cond_0
    iget-object v0, p0, Lcom/umeng/commonsdk/proguard/as;->m:[B

    invoke-direct {p0, v0, v1, v2}, Lcom/umeng/commonsdk/proguard/as;->a([BII)I

    .line 270
    iget-object v0, p0, Lcom/umeng/commonsdk/proguard/as;->m:[B

    aget-byte v0, v0, v1

    goto :goto_0
.end method

.method public v()S
    .locals 4
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Lcom/umeng/commonsdk/proguard/ag;
        }
    .end annotation

    .prologue
    const/4 v0, 0x0

    const/4 v3, 0x2

    .line 275
    iget-object v1, p0, Lcom/umeng/commonsdk/proguard/as;->n:[B

    .line 278
    iget-object v2, p0, Lcom/umeng/commonsdk/proguard/as;->g:Lcom/umeng/commonsdk/proguard/bn;

    invoke-virtual {v2}, Lcom/umeng/commonsdk/proguard/bn;->h()I

    move-result v2

    if-lt v2, v3, :cond_0

    .line 279
    iget-object v0, p0, Lcom/umeng/commonsdk/proguard/as;->g:Lcom/umeng/commonsdk/proguard/bn;

    invoke-virtual {v0}, Lcom/umeng/commonsdk/proguard/bn;->f()[B

    move-result-object v1

    .line 280
    iget-object v0, p0, Lcom/umeng/commonsdk/proguard/as;->g:Lcom/umeng/commonsdk/proguard/bn;

    invoke-virtual {v0}, Lcom/umeng/commonsdk/proguard/bn;->g()I

    move-result v0

    .line 281
    iget-object v2, p0, Lcom/umeng/commonsdk/proguard/as;->g:Lcom/umeng/commonsdk/proguard/bn;

    invoke-virtual {v2, v3}, Lcom/umeng/commonsdk/proguard/bn;->a(I)V

    .line 286
    :goto_0
    aget-byte v2, v1, v0

    and-int/lit16 v2, v2, 0xff

    shl-int/lit8 v2, v2, 0x8

    add-int/lit8 v0, v0, 0x1

    aget-byte v0, v1, v0

    and-int/lit16 v0, v0, 0xff

    or-int/2addr v0, v2

    int-to-short v0, v0

    return v0

    .line 283
    :cond_0
    iget-object v2, p0, Lcom/umeng/commonsdk/proguard/as;->n:[B

    invoke-direct {p0, v2, v0, v3}, Lcom/umeng/commonsdk/proguard/as;->a([BII)I

    goto :goto_0
.end method

.method public w()I
    .locals 4
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Lcom/umeng/commonsdk/proguard/ag;
        }
    .end annotation

    .prologue
    const/4 v0, 0x0

    const/4 v3, 0x4

    .line 294
    iget-object v1, p0, Lcom/umeng/commonsdk/proguard/as;->o:[B

    .line 297
    iget-object v2, p0, Lcom/umeng/commonsdk/proguard/as;->g:Lcom/umeng/commonsdk/proguard/bn;

    invoke-virtual {v2}, Lcom/umeng/commonsdk/proguard/bn;->h()I

    move-result v2

    if-lt v2, v3, :cond_0

    .line 298
    iget-object v0, p0, Lcom/umeng/commonsdk/proguard/as;->g:Lcom/umeng/commonsdk/proguard/bn;

    invoke-virtual {v0}, Lcom/umeng/commonsdk/proguard/bn;->f()[B

    move-result-object v1

    .line 299
    iget-object v0, p0, Lcom/umeng/commonsdk/proguard/as;->g:Lcom/umeng/commonsdk/proguard/bn;

    invoke-virtual {v0}, Lcom/umeng/commonsdk/proguard/bn;->g()I

    move-result v0

    .line 300
    iget-object v2, p0, Lcom/umeng/commonsdk/proguard/as;->g:Lcom/umeng/commonsdk/proguard/bn;

    invoke-virtual {v2, v3}, Lcom/umeng/commonsdk/proguard/bn;->a(I)V

    .line 304
    :goto_0
    aget-byte v2, v1, v0

    and-int/lit16 v2, v2, 0xff

    shl-int/lit8 v2, v2, 0x18

    add-int/lit8 v3, v0, 0x1

    aget-byte v3, v1, v3

    and-int/lit16 v3, v3, 0xff

    shl-int/lit8 v3, v3, 0x10

    or-int/2addr v2, v3

    add-int/lit8 v3, v0, 0x2

    aget-byte v3, v1, v3

    and-int/lit16 v3, v3, 0xff

    shl-int/lit8 v3, v3, 0x8

    or-int/2addr v2, v3

    add-int/lit8 v0, v0, 0x3

    aget-byte v0, v1, v0

    and-int/lit16 v0, v0, 0xff

    or-int/2addr v0, v2

    return v0

    .line 302
    :cond_0
    iget-object v2, p0, Lcom/umeng/commonsdk/proguard/as;->o:[B

    invoke-direct {p0, v2, v0, v3}, Lcom/umeng/commonsdk/proguard/as;->a([BII)I

    goto :goto_0
.end method

.method public x()J
    .locals 8
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Lcom/umeng/commonsdk/proguard/ag;
        }
    .end annotation

    .prologue
    const/4 v0, 0x0

    const/16 v7, 0x8

    .line 313
    iget-object v1, p0, Lcom/umeng/commonsdk/proguard/as;->p:[B

    .line 316
    iget-object v2, p0, Lcom/umeng/commonsdk/proguard/as;->g:Lcom/umeng/commonsdk/proguard/bn;

    invoke-virtual {v2}, Lcom/umeng/commonsdk/proguard/bn;->h()I

    move-result v2

    if-lt v2, v7, :cond_0

    .line 317
    iget-object v0, p0, Lcom/umeng/commonsdk/proguard/as;->g:Lcom/umeng/commonsdk/proguard/bn;

    invoke-virtual {v0}, Lcom/umeng/commonsdk/proguard/bn;->f()[B

    move-result-object v1

    .line 318
    iget-object v0, p0, Lcom/umeng/commonsdk/proguard/as;->g:Lcom/umeng/commonsdk/proguard/bn;

    invoke-virtual {v0}, Lcom/umeng/commonsdk/proguard/bn;->g()I

    move-result v0

    .line 319
    iget-object v2, p0, Lcom/umeng/commonsdk/proguard/as;->g:Lcom/umeng/commonsdk/proguard/bn;

    invoke-virtual {v2, v7}, Lcom/umeng/commonsdk/proguard/bn;->a(I)V

    .line 324
    :goto_0
    aget-byte v2, v1, v0

    and-int/lit16 v2, v2, 0xff

    int-to-long v2, v2

    const/16 v4, 0x38

    shl-long/2addr v2, v4

    add-int/lit8 v4, v0, 0x1

    aget-byte v4, v1, v4

    and-int/lit16 v4, v4, 0xff

    int-to-long v4, v4

    const/16 v6, 0x30

    shl-long/2addr v4, v6

    or-long/2addr v2, v4

    add-int/lit8 v4, v0, 0x2

    aget-byte v4, v1, v4

    and-int/lit16 v4, v4, 0xff

    int-to-long v4, v4

    const/16 v6, 0x28

    shl-long/2addr v4, v6

    or-long/2addr v2, v4

    add-int/lit8 v4, v0, 0x3

    aget-byte v4, v1, v4

    and-int/lit16 v4, v4, 0xff

    int-to-long v4, v4

    const/16 v6, 0x20

    shl-long/2addr v4, v6

    or-long/2addr v2, v4

    add-int/lit8 v4, v0, 0x4

    aget-byte v4, v1, v4

    and-int/lit16 v4, v4, 0xff

    int-to-long v4, v4

    const/16 v6, 0x18

    shl-long/2addr v4, v6

    or-long/2addr v2, v4

    add-int/lit8 v4, v0, 0x5

    aget-byte v4, v1, v4

    and-int/lit16 v4, v4, 0xff

    int-to-long v4, v4

    const/16 v6, 0x10

    shl-long/2addr v4, v6

    or-long/2addr v2, v4

    add-int/lit8 v4, v0, 0x6

    aget-byte v4, v1, v4

    and-int/lit16 v4, v4, 0xff

    int-to-long v4, v4

    shl-long/2addr v4, v7

    or-long/2addr v2, v4

    add-int/lit8 v0, v0, 0x7

    aget-byte v0, v1, v0

    and-int/lit16 v0, v0, 0xff

    int-to-long v0, v0

    or-long/2addr v0, v2

    return-wide v0

    .line 321
    :cond_0
    iget-object v2, p0, Lcom/umeng/commonsdk/proguard/as;->p:[B

    invoke-direct {p0, v2, v0, v7}, Lcom/umeng/commonsdk/proguard/as;->a([BII)I

    goto :goto_0
.end method

.method public y()D
    .locals 2
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Lcom/umeng/commonsdk/proguard/ag;
        }
    .end annotation

    .prologue
    .line 336
    invoke-virtual {p0}, Lcom/umeng/commonsdk/proguard/as;->x()J

    move-result-wide v0

    invoke-static {v0, v1}, Ljava/lang/Double;->longBitsToDouble(J)D

    move-result-wide v0

    return-wide v0
.end method

.method public z()Ljava/lang/String;
    .locals 5
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Lcom/umeng/commonsdk/proguard/ag;
        }
    .end annotation

    .prologue
    .line 340
    invoke-virtual {p0}, Lcom/umeng/commonsdk/proguard/as;->w()I

    move-result v1

    .line 342
    iget-object v0, p0, Lcom/umeng/commonsdk/proguard/as;->g:Lcom/umeng/commonsdk/proguard/bn;

    invoke-virtual {v0}, Lcom/umeng/commonsdk/proguard/bn;->h()I

    move-result v0

    if-lt v0, v1, :cond_0

    .line 344
    :try_start_0
    new-instance v0, Ljava/lang/String;

    iget-object v2, p0, Lcom/umeng/commonsdk/proguard/as;->g:Lcom/umeng/commonsdk/proguard/bn;

    invoke-virtual {v2}, Lcom/umeng/commonsdk/proguard/bn;->f()[B

    move-result-object v2

    iget-object v3, p0, Lcom/umeng/commonsdk/proguard/as;->g:Lcom/umeng/commonsdk/proguard/bn;

    invoke-virtual {v3}, Lcom/umeng/commonsdk/proguard/bn;->g()I

    move-result v3

    const-string v4, "UTF-8"

    invoke-direct {v0, v2, v3, v1, v4}, Ljava/lang/String;-><init>([BIILjava/lang/String;)V

    .line 345
    iget-object v2, p0, Lcom/umeng/commonsdk/proguard/as;->g:Lcom/umeng/commonsdk/proguard/bn;

    invoke-virtual {v2, v1}, Lcom/umeng/commonsdk/proguard/bn;->a(I)V
    :try_end_0
    .catch Ljava/io/UnsupportedEncodingException; {:try_start_0 .. :try_end_0} :catch_0

    .line 352
    :goto_0
    return-object v0

    .line 347
    :catch_0
    move-exception v0

    .line 348
    new-instance v0, Lcom/umeng/commonsdk/proguard/ag;

    const-string v1, "JVM DOES NOT SUPPORT UTF-8"

    invoke-direct {v0, v1}, Lcom/umeng/commonsdk/proguard/ag;-><init>(Ljava/lang/String;)V

    throw v0

    .line 352
    :cond_0
    invoke-virtual {p0, v1}, Lcom/umeng/commonsdk/proguard/as;->b(I)Ljava/lang/String;

    move-result-object v0

    goto :goto_0
.end method
