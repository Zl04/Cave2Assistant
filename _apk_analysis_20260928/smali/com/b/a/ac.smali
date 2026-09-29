.class public final Lcom/b/a/ac;
.super Ljava/lang/Object;
.source "SourceFile"


# static fields
.field private static final d:[C


# instance fields
.field final a:Ljava/lang/String;

.field final b:Ljava/lang/String;

.field final c:I

.field private final e:Ljava/lang/String;

.field private final f:Ljava/lang/String;

.field private final g:Ljava/util/List;
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "Ljava/util/List",
            "<",
            "Ljava/lang/String;",
            ">;"
        }
    .end annotation
.end field

.field private final h:Ljava/util/List;
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "Ljava/util/List",
            "<",
            "Ljava/lang/String;",
            ">;"
        }
    .end annotation
.end field

.field private final i:Ljava/lang/String;

.field private final j:Ljava/lang/String;


# direct methods
.method static constructor <clinit>()V
    .locals 1

    .prologue
    .line 285
    const/16 v0, 0x10

    new-array v0, v0, [C

    fill-array-data v0, :array_0

    sput-object v0, Lcom/b/a/ac;->d:[C

    return-void

    :array_0
    .array-data 2
        0x30s
        0x31s
        0x32s
        0x33s
        0x34s
        0x35s
        0x36s
        0x37s
        0x38s
        0x39s
        0x41s
        0x42s
        0x43s
        0x44s
        0x45s
        0x46s
    .end array-data
.end method

.method constructor <init>(Lcom/b/a/ad;)V
    .locals 4

    .prologue
    const/4 v1, 0x0

    const/4 v3, 0x0

    .line 333
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    .line 334
    iget-object v0, p1, Lcom/b/a/ad;->a:Ljava/lang/String;

    iput-object v0, p0, Lcom/b/a/ac;->a:Ljava/lang/String;

    .line 335
    iget-object v0, p1, Lcom/b/a/ad;->b:Ljava/lang/String;

    invoke-static {v0, v3}, Lcom/b/a/ac;->a(Ljava/lang/String;Z)Ljava/lang/String;

    move-result-object v0

    iput-object v0, p0, Lcom/b/a/ac;->e:Ljava/lang/String;

    .line 336
    iget-object v0, p1, Lcom/b/a/ad;->c:Ljava/lang/String;

    invoke-static {v0, v3}, Lcom/b/a/ac;->a(Ljava/lang/String;Z)Ljava/lang/String;

    move-result-object v0

    iput-object v0, p0, Lcom/b/a/ac;->f:Ljava/lang/String;

    .line 337
    iget-object v0, p1, Lcom/b/a/ad;->d:Ljava/lang/String;

    iput-object v0, p0, Lcom/b/a/ac;->b:Ljava/lang/String;

    .line 338
    invoke-virtual {p1}, Lcom/b/a/ad;->a()I

    move-result v0

    iput v0, p0, Lcom/b/a/ac;->c:I

    .line 339
    iget-object v0, p1, Lcom/b/a/ad;->f:Ljava/util/List;

    invoke-static {v0, v3}, Lcom/b/a/ac;->a(Ljava/util/List;Z)Ljava/util/List;

    move-result-object v0

    iput-object v0, p0, Lcom/b/a/ac;->g:Ljava/util/List;

    .line 340
    iget-object v0, p1, Lcom/b/a/ad;->g:Ljava/util/List;

    if-eqz v0, :cond_1

    iget-object v0, p1, Lcom/b/a/ad;->g:Ljava/util/List;

    const/4 v2, 0x1

    .line 341
    invoke-static {v0, v2}, Lcom/b/a/ac;->a(Ljava/util/List;Z)Ljava/util/List;

    move-result-object v0

    :goto_0
    iput-object v0, p0, Lcom/b/a/ac;->h:Ljava/util/List;

    .line 343
    iget-object v0, p1, Lcom/b/a/ad;->h:Ljava/lang/String;

    if-eqz v0, :cond_0

    iget-object v0, p1, Lcom/b/a/ad;->h:Ljava/lang/String;

    .line 344
    invoke-static {v0, v3}, Lcom/b/a/ac;->a(Ljava/lang/String;Z)Ljava/lang/String;

    move-result-object v1

    :cond_0
    iput-object v1, p0, Lcom/b/a/ac;->i:Ljava/lang/String;

    .line 346
    invoke-virtual {p1}, Lcom/b/a/ad;->toString()Ljava/lang/String;

    move-result-object v0

    iput-object v0, p0, Lcom/b/a/ac;->j:Ljava/lang/String;

    .line 347
    return-void

    :cond_1
    move-object v0, v1

    .line 341
    goto :goto_0
.end method

.method static a(C)I
    .locals 1

    .prologue
    .line 1784
    const/16 v0, 0x30

    if-lt p0, v0, :cond_0

    const/16 v0, 0x39

    if-gt p0, v0, :cond_0

    add-int/lit8 v0, p0, -0x30

    .line 1787
    :goto_0
    return v0

    .line 1785
    :cond_0
    const/16 v0, 0x61

    if-lt p0, v0, :cond_1

    const/16 v0, 0x66

    if-gt p0, v0, :cond_1

    add-int/lit8 v0, p0, -0x61

    add-int/lit8 v0, v0, 0xa

    goto :goto_0

    .line 1786
    :cond_1
    const/16 v0, 0x41

    if-lt p0, v0, :cond_2

    const/16 v0, 0x46

    if-gt p0, v0, :cond_2

    add-int/lit8 v0, p0, -0x41

    add-int/lit8 v0, v0, 0xa

    goto :goto_0

    .line 1787
    :cond_2
    const/4 v0, -0x1

    goto :goto_0
.end method

.method public static a(Ljava/lang/String;)I
    .locals 1

    .prologue
    .line 505
    const-string v0, "http"

    invoke-virtual {p0, v0}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v0

    if-eqz v0, :cond_0

    .line 506
    const/16 v0, 0x50

    .line 510
    :goto_0
    return v0

    .line 507
    :cond_0
    const-string v0, "https"

    invoke-virtual {p0, v0}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v0

    if-eqz v0, :cond_1

    .line 508
    const/16 v0, 0x1bb

    goto :goto_0

    .line 510
    :cond_1
    const/4 v0, -0x1

    goto :goto_0
.end method

.method static a(Ljava/lang/String;IILjava/lang/String;ZZZZ)Ljava/lang/String;
    .locals 7

    .prologue
    .line 1809
    move v0, p1

    :goto_0
    if-ge v0, p2, :cond_d

    .line 1810
    invoke-virtual {p0, v0}, Ljava/lang/String;->codePointAt(I)I

    move-result v1

    .line 1811
    const/16 v2, 0x20

    if-lt v1, v2, :cond_2

    const/16 v2, 0x7f

    if-eq v1, v2, :cond_2

    const/16 v2, 0x80

    if-lt v1, v2, :cond_0

    if-nez p7, :cond_2

    .line 1814
    :cond_0
    invoke-virtual {p3, v1}, Ljava/lang/String;->indexOf(I)I

    move-result v2

    const/4 v3, -0x1

    if-ne v2, v3, :cond_2

    const/16 v2, 0x25

    if-ne v1, v2, :cond_1

    if-eqz p4, :cond_2

    if-eqz p5, :cond_1

    .line 1815
    invoke-static {p0, v0, p2}, Lcom/b/a/ac;->a(Ljava/lang/String;II)Z

    move-result v2

    if-eqz v2, :cond_2

    :cond_1
    const/16 v2, 0x2b

    if-ne v1, v2, :cond_c

    if-eqz p6, :cond_c

    .line 1818
    :cond_2
    new-instance v3, Lcom/b/b/f;

    invoke-direct {v3}, Lcom/b/b/f;-><init>()V

    .line 1819
    invoke-virtual {v3, p0, p1, v0}, Lcom/b/b/f;->a(Ljava/lang/String;II)Lcom/b/b/f;

    .line 4832
    const/4 v1, 0x0

    move v2, v0

    move-object v0, v1

    .line 4834
    :goto_1
    if-ge v2, p2, :cond_b

    .line 4835
    invoke-virtual {p0, v2}, Ljava/lang/String;->codePointAt(I)I

    move-result v4

    .line 4836
    if-eqz p4, :cond_3

    const/16 v1, 0x9

    if-eq v4, v1, :cond_4

    const/16 v1, 0xa

    if-eq v4, v1, :cond_4

    const/16 v1, 0xc

    if-eq v4, v1, :cond_4

    const/16 v1, 0xd

    if-eq v4, v1, :cond_4

    .line 4839
    :cond_3
    const/16 v1, 0x2b

    if-ne v4, v1, :cond_6

    if-eqz p6, :cond_6

    .line 4841
    if-eqz p4, :cond_5

    const-string v1, "+"

    :goto_2
    invoke-virtual {v3, v1}, Lcom/b/b/f;->a(Ljava/lang/String;)Lcom/b/b/f;

    .line 4834
    :cond_4
    :goto_3
    invoke-static {v4}, Ljava/lang/Character;->charCount(I)I

    move-result v1

    add-int/2addr v1, v2

    move v2, v1

    goto :goto_1

    .line 4841
    :cond_5
    const-string v1, "%2B"

    goto :goto_2

    .line 4842
    :cond_6
    const/16 v1, 0x20

    if-lt v4, v1, :cond_8

    const/16 v1, 0x7f

    if-eq v4, v1, :cond_8

    const/16 v1, 0x80

    if-lt v4, v1, :cond_7

    if-nez p7, :cond_8

    .line 4845
    :cond_7
    invoke-virtual {p3, v4}, Ljava/lang/String;->indexOf(I)I

    move-result v1

    const/4 v5, -0x1

    if-ne v1, v5, :cond_8

    const/16 v1, 0x25

    if-ne v4, v1, :cond_a

    if-eqz p4, :cond_8

    if-eqz p5, :cond_a

    .line 4846
    invoke-static {p0, v2, p2}, Lcom/b/a/ac;->a(Ljava/lang/String;II)Z

    move-result v1

    if-nez v1, :cond_a

    .line 4848
    :cond_8
    if-nez v0, :cond_9

    .line 4849
    new-instance v0, Lcom/b/b/f;

    invoke-direct {v0}, Lcom/b/b/f;-><init>()V

    .line 4851
    :cond_9
    invoke-virtual {v0, v4}, Lcom/b/b/f;->a(I)Lcom/b/b/f;

    .line 4852
    :goto_4
    invoke-virtual {v0}, Lcom/b/b/f;->d()Z

    move-result v1

    if-nez v1, :cond_4

    .line 4853
    invoke-virtual {v0}, Lcom/b/b/f;->e()B

    move-result v1

    and-int/lit16 v1, v1, 0xff

    .line 4854
    const/16 v5, 0x25

    invoke-virtual {v3, v5}, Lcom/b/b/f;->b(I)Lcom/b/b/f;

    .line 4855
    sget-object v5, Lcom/b/a/ac;->d:[C

    shr-int/lit8 v6, v1, 0x4

    and-int/lit8 v6, v6, 0xf

    aget-char v5, v5, v6

    invoke-virtual {v3, v5}, Lcom/b/b/f;->b(I)Lcom/b/b/f;

    .line 4856
    sget-object v5, Lcom/b/a/ac;->d:[C

    and-int/lit8 v1, v1, 0xf

    aget-char v1, v5, v1

    invoke-virtual {v3, v1}, Lcom/b/b/f;->b(I)Lcom/b/b/f;

    goto :goto_4

    .line 4860
    :cond_a
    invoke-virtual {v3, v4}, Lcom/b/b/f;->a(I)Lcom/b/b/f;

    goto :goto_3

    .line 1822
    :cond_b
    invoke-virtual {v3}, Lcom/b/b/f;->l()Ljava/lang/String;

    move-result-object v0

    .line 1827
    :goto_5
    return-object v0

    .line 1809
    :cond_c
    invoke-static {v1}, Ljava/lang/Character;->charCount(I)I

    move-result v1

    add-int/2addr v0, v1

    goto/16 :goto_0

    .line 1827
    :cond_d
    invoke-virtual {p0, p1, p2}, Ljava/lang/String;->substring(II)Ljava/lang/String;

    move-result-object v0

    goto :goto_5
.end method

.method static a(Ljava/lang/String;IIZ)Ljava/lang/String;
    .locals 8

    .prologue
    const/16 v7, 0x2b

    const/16 v6, 0x25

    const/4 v5, -0x1

    .line 1741
    move v0, p1

    :goto_0
    if-ge v0, p2, :cond_5

    .line 1742
    invoke-virtual {p0, v0}, Ljava/lang/String;->charAt(I)C

    move-result v1

    .line 1743
    if-eq v1, v6, :cond_0

    if-ne v1, v7, :cond_4

    if-eqz p3, :cond_4

    .line 1745
    :cond_0
    new-instance v1, Lcom/b/b/f;

    invoke-direct {v1}, Lcom/b/b/f;-><init>()V

    .line 1746
    invoke-virtual {v1, p0, p1, v0}, Lcom/b/b/f;->a(Ljava/lang/String;II)Lcom/b/b/f;

    .line 4758
    :goto_1
    if-ge v0, p2, :cond_3

    .line 4759
    invoke-virtual {p0, v0}, Ljava/lang/String;->codePointAt(I)I

    move-result v2

    .line 4760
    if-ne v2, v6, :cond_1

    add-int/lit8 v3, v0, 0x2

    if-ge v3, p2, :cond_1

    .line 4761
    add-int/lit8 v3, v0, 0x1

    invoke-virtual {p0, v3}, Ljava/lang/String;->charAt(I)C

    move-result v3

    invoke-static {v3}, Lcom/b/a/ac;->a(C)I

    move-result v3

    .line 4762
    add-int/lit8 v4, v0, 0x2

    invoke-virtual {p0, v4}, Ljava/lang/String;->charAt(I)C

    move-result v4

    invoke-static {v4}, Lcom/b/a/ac;->a(C)I

    move-result v4

    .line 4763
    if-eq v3, v5, :cond_2

    if-eq v4, v5, :cond_2

    .line 4764
    shl-int/lit8 v3, v3, 0x4

    add-int/2addr v3, v4

    invoke-virtual {v1, v3}, Lcom/b/b/f;->b(I)Lcom/b/b/f;

    .line 4765
    add-int/lit8 v0, v0, 0x2

    .line 4758
    :goto_2
    invoke-static {v2}, Ljava/lang/Character;->charCount(I)I

    move-result v2

    add-int/2addr v0, v2

    goto :goto_1

    .line 4768
    :cond_1
    if-ne v2, v7, :cond_2

    if-eqz p3, :cond_2

    .line 4769
    const/16 v3, 0x20

    invoke-virtual {v1, v3}, Lcom/b/b/f;->b(I)Lcom/b/b/f;

    goto :goto_2

    .line 4772
    :cond_2
    invoke-virtual {v1, v2}, Lcom/b/b/f;->a(I)Lcom/b/b/f;

    goto :goto_2

    .line 1748
    :cond_3
    invoke-virtual {v1}, Lcom/b/b/f;->l()Ljava/lang/String;

    move-result-object v0

    .line 1753
    :goto_3
    return-object v0

    .line 1741
    :cond_4
    add-int/lit8 v0, v0, 0x1

    goto :goto_0

    .line 1753
    :cond_5
    invoke-virtual {p0, p1, p2}, Ljava/lang/String;->substring(II)Ljava/lang/String;

    move-result-object v0

    goto :goto_3
.end method

.method static a(Ljava/lang/String;Ljava/lang/String;ZZZZ)Ljava/lang/String;
    .locals 8

    .prologue
    .line 1867
    const/4 v1, 0x0

    .line 1868
    invoke-virtual {p0}, Ljava/lang/String;->length()I

    move-result v2

    move-object v0, p0

    move-object v3, p1

    move v4, p2

    move v5, p3

    move v6, p4

    move v7, p5

    .line 1867
    invoke-static/range {v0 .. v7}, Lcom/b/a/ac;->a(Ljava/lang/String;IILjava/lang/String;ZZZZ)Ljava/lang/String;

    move-result-object v0

    return-object v0
.end method

.method private static a(Ljava/lang/String;Z)Ljava/lang/String;
    .locals 2

    .prologue
    .line 1727
    const/4 v0, 0x0

    invoke-virtual {p0}, Ljava/lang/String;->length()I

    move-result v1

    invoke-static {p0, v0, v1, p1}, Lcom/b/a/ac;->a(Ljava/lang/String;IIZ)Ljava/lang/String;

    move-result-object v0

    return-object v0
.end method

.method private static a(Ljava/util/List;Z)Ljava/util/List;
    .locals 4
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "(",
            "Ljava/util/List",
            "<",
            "Ljava/lang/String;",
            ">;Z)",
            "Ljava/util/List",
            "<",
            "Ljava/lang/String;",
            ">;"
        }
    .end annotation

    .prologue
    .line 1731
    invoke-interface {p0}, Ljava/util/List;->size()I

    move-result v2

    .line 1732
    new-instance v3, Ljava/util/ArrayList;

    invoke-direct {v3, v2}, Ljava/util/ArrayList;-><init>(I)V

    .line 1733
    const/4 v0, 0x0

    move v1, v0

    :goto_0
    if-ge v1, v2, :cond_1

    .line 1734
    invoke-interface {p0, v1}, Ljava/util/List;->get(I)Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Ljava/lang/String;

    .line 1735
    if-eqz v0, :cond_0

    invoke-static {v0, p1}, Lcom/b/a/ac;->a(Ljava/lang/String;Z)Ljava/lang/String;

    move-result-object v0

    :goto_1
    invoke-interface {v3, v0}, Ljava/util/List;->add(Ljava/lang/Object;)Z

    .line 1733
    add-int/lit8 v0, v1, 0x1

    move v1, v0

    goto :goto_0

    .line 1735
    :cond_0
    const/4 v0, 0x0

    goto :goto_1

    .line 1737
    :cond_1
    invoke-static {v3}, Ljava/util/Collections;->unmodifiableList(Ljava/util/List;)Ljava/util/List;

    move-result-object v0

    return-object v0
.end method

.method static a(Ljava/lang/StringBuilder;Ljava/util/List;)V
    .locals 3
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "(",
            "Ljava/lang/StringBuilder;",
            "Ljava/util/List",
            "<",
            "Ljava/lang/String;",
            ">;)V"
        }
    .end annotation

    .prologue
    .line 547
    const/4 v0, 0x0

    invoke-interface {p1}, Ljava/util/List;->size()I

    move-result v2

    move v1, v0

    :goto_0
    if-ge v1, v2, :cond_0

    .line 548
    const/16 v0, 0x2f

    invoke-virtual {p0, v0}, Ljava/lang/StringBuilder;->append(C)Ljava/lang/StringBuilder;

    .line 549
    invoke-interface {p1, v1}, Ljava/util/List;->get(I)Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Ljava/lang/String;

    invoke-virtual {p0, v0}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    .line 547
    add-int/lit8 v0, v1, 0x1

    move v1, v0

    goto :goto_0

    .line 551
    :cond_0
    return-void
.end method

.method private static a(Ljava/lang/String;II)Z
    .locals 3

    .prologue
    const/4 v2, -0x1

    .line 1777
    add-int/lit8 v0, p1, 0x2

    if-ge v0, p2, :cond_0

    .line 1778
    invoke-virtual {p0, p1}, Ljava/lang/String;->charAt(I)C

    move-result v0

    const/16 v1, 0x25

    if-ne v0, v1, :cond_0

    add-int/lit8 v0, p1, 0x1

    .line 1779
    invoke-virtual {p0, v0}, Ljava/lang/String;->charAt(I)C

    move-result v0

    invoke-static {v0}, Lcom/b/a/ac;->a(C)I

    move-result v0

    if-eq v0, v2, :cond_0

    add-int/lit8 v0, p1, 0x2

    .line 1780
    invoke-virtual {p0, v0}, Ljava/lang/String;->charAt(I)C

    move-result v0

    invoke-static {v0}, Lcom/b/a/ac;->a(C)I

    move-result v0

    if-eq v0, v2, :cond_0

    const/4 v0, 0x1

    :goto_0
    return v0

    :cond_0
    const/4 v0, 0x0

    .line 1777
    goto :goto_0
.end method

.method static b(Ljava/lang/String;)Ljava/util/List;
    .locals 5
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "(",
            "Ljava/lang/String;",
            ")",
            "Ljava/util/List",
            "<",
            "Ljava/lang/String;",
            ">;"
        }
    .end annotation

    .prologue
    const/4 v4, -0x1

    .line 634
    new-instance v2, Ljava/util/ArrayList;

    invoke-direct {v2}, Ljava/util/ArrayList;-><init>()V

    .line 635
    const/4 v0, 0x0

    :goto_0
    invoke-virtual {p0}, Ljava/lang/String;->length()I

    move-result v1

    if-gt v0, v1, :cond_3

    .line 636
    const/16 v1, 0x26

    invoke-virtual {p0, v1, v0}, Ljava/lang/String;->indexOf(II)I

    move-result v1

    .line 637
    if-ne v1, v4, :cond_0

    invoke-virtual {p0}, Ljava/lang/String;->length()I

    move-result v1

    .line 639
    :cond_0
    const/16 v3, 0x3d

    invoke-virtual {p0, v3, v0}, Ljava/lang/String;->indexOf(II)I

    move-result v3

    .line 640
    if-eq v3, v4, :cond_1

    if-le v3, v1, :cond_2

    .line 641
    :cond_1
    invoke-virtual {p0, v0, v1}, Ljava/lang/String;->substring(II)Ljava/lang/String;

    move-result-object v0

    invoke-interface {v2, v0}, Ljava/util/List;->add(Ljava/lang/Object;)Z

    .line 642
    const/4 v0, 0x0

    invoke-interface {v2, v0}, Ljava/util/List;->add(Ljava/lang/Object;)Z

    .line 647
    :goto_1
    add-int/lit8 v0, v1, 0x1

    .line 648
    goto :goto_0

    .line 644
    :cond_2
    invoke-virtual {p0, v0, v3}, Ljava/lang/String;->substring(II)Ljava/lang/String;

    move-result-object v0

    invoke-interface {v2, v0}, Ljava/util/List;->add(Ljava/lang/Object;)Z

    .line 645
    add-int/lit8 v0, v3, 0x1

    invoke-virtual {p0, v0, v1}, Ljava/lang/String;->substring(II)Ljava/lang/String;

    move-result-object v0

    invoke-interface {v2, v0}, Ljava/util/List;->add(Ljava/lang/Object;)Z

    goto :goto_1

    .line 649
    :cond_3
    return-object v2
.end method

.method static b(Ljava/lang/StringBuilder;Ljava/util/List;)V
    .locals 5
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "(",
            "Ljava/lang/StringBuilder;",
            "Ljava/util/List",
            "<",
            "Ljava/lang/String;",
            ">;)V"
        }
    .end annotation

    .prologue
    .line 615
    const/4 v0, 0x0

    invoke-interface {p1}, Ljava/util/List;->size()I

    move-result v3

    move v2, v0

    :goto_0
    if-ge v2, v3, :cond_2

    .line 616
    invoke-interface {p1, v2}, Ljava/util/List;->get(I)Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Ljava/lang/String;

    .line 617
    add-int/lit8 v1, v2, 0x1

    invoke-interface {p1, v1}, Ljava/util/List;->get(I)Ljava/lang/Object;

    move-result-object v1

    check-cast v1, Ljava/lang/String;

    .line 618
    if-lez v2, :cond_0

    const/16 v4, 0x26

    invoke-virtual {p0, v4}, Ljava/lang/StringBuilder;->append(C)Ljava/lang/StringBuilder;

    .line 619
    :cond_0
    invoke-virtual {p0, v0}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    .line 620
    if-eqz v1, :cond_1

    .line 621
    const/16 v0, 0x3d

    invoke-virtual {p0, v0}, Ljava/lang/StringBuilder;->append(C)Ljava/lang/StringBuilder;

    .line 622
    invoke-virtual {p0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    .line 615
    :cond_1
    add-int/lit8 v0, v2, 0x2

    move v2, v0

    goto :goto_0

    .line 625
    :cond_2
    return-void
.end method

.method public static e(Ljava/lang/String;)Lcom/b/a/ac;
    .locals 4

    .prologue
    const/4 v0, 0x0

    .line 896
    new-instance v1, Lcom/b/a/ad;

    invoke-direct {v1}, Lcom/b/a/ad;-><init>()V

    .line 897
    invoke-virtual {v1, v0, p0}, Lcom/b/a/ad;->a(Lcom/b/a/ac;Ljava/lang/String;)I

    move-result v2

    .line 898
    sget v3, Lcom/b/a/ae;->a:I

    if-ne v2, v3, :cond_0

    invoke-virtual {v1}, Lcom/b/a/ad;->b()Lcom/b/a/ac;

    move-result-object v0

    :cond_0
    return-object v0
.end method


# virtual methods
.method public final a()Ljava/net/URI;
    .locals 12

    .prologue
    const/4 v4, 0x0

    const/4 v2, 0x1

    .line 372
    .line 2867
    new-instance v11, Lcom/b/a/ad;

    invoke-direct {v11}, Lcom/b/a/ad;-><init>()V

    .line 2868
    iget-object v0, p0, Lcom/b/a/ac;->a:Ljava/lang/String;

    iput-object v0, v11, Lcom/b/a/ad;->a:Ljava/lang/String;

    .line 2869
    invoke-virtual {p0}, Lcom/b/a/ac;->d()Ljava/lang/String;

    move-result-object v0

    iput-object v0, v11, Lcom/b/a/ad;->b:Ljava/lang/String;

    .line 2870
    invoke-virtual {p0}, Lcom/b/a/ac;->e()Ljava/lang/String;

    move-result-object v0

    iput-object v0, v11, Lcom/b/a/ad;->c:Ljava/lang/String;

    .line 2871
    iget-object v0, p0, Lcom/b/a/ac;->b:Ljava/lang/String;

    iput-object v0, v11, Lcom/b/a/ad;->d:Ljava/lang/String;

    .line 2873
    iget v0, p0, Lcom/b/a/ac;->c:I

    iget-object v1, p0, Lcom/b/a/ac;->a:Ljava/lang/String;

    invoke-static {v1}, Lcom/b/a/ac;->a(Ljava/lang/String;)I

    move-result v1

    if-eq v0, v1, :cond_0

    iget v0, p0, Lcom/b/a/ac;->c:I

    :goto_0
    iput v0, v11, Lcom/b/a/ad;->e:I

    .line 2874
    iget-object v0, v11, Lcom/b/a/ad;->f:Ljava/util/List;

    invoke-interface {v0}, Ljava/util/List;->clear()V

    .line 2875
    iget-object v0, v11, Lcom/b/a/ad;->f:Ljava/util/List;

    invoke-virtual {p0}, Lcom/b/a/ac;->i()Ljava/util/List;

    move-result-object v1

    invoke-interface {v0, v1}, Ljava/util/List;->addAll(Ljava/util/Collection;)Z

    .line 2876
    invoke-virtual {p0}, Lcom/b/a/ac;->j()Ljava/lang/String;

    move-result-object v0

    invoke-virtual {v11, v0}, Lcom/b/a/ad;->b(Ljava/lang/String;)Lcom/b/a/ad;

    .line 3823
    iget-object v0, p0, Lcom/b/a/ac;->i:Ljava/lang/String;

    if-nez v0, :cond_1

    const/4 v0, 0x0

    .line 2877
    :goto_1
    iput-object v0, v11, Lcom/b/a/ad;->h:Ljava/lang/String;

    .line 4211
    iget-object v0, v11, Lcom/b/a/ad;->f:Ljava/util/List;

    invoke-interface {v0}, Ljava/util/List;->size()I

    move-result v7

    move v6, v4

    :goto_2
    if-ge v6, v7, :cond_2

    .line 4212
    iget-object v0, v11, Lcom/b/a/ad;->f:Ljava/util/List;

    invoke-interface {v0, v6}, Ljava/util/List;->get(I)Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Ljava/lang/String;

    .line 4213
    iget-object v8, v11, Lcom/b/a/ad;->f:Ljava/util/List;

    const-string v1, "[]"

    move v3, v2

    move v5, v2

    .line 4214
    invoke-static/range {v0 .. v5}, Lcom/b/a/ac;->a(Ljava/lang/String;Ljava/lang/String;ZZZZ)Ljava/lang/String;

    move-result-object v0

    .line 4213
    invoke-interface {v8, v6, v0}, Ljava/util/List;->set(ILjava/lang/Object;)Ljava/lang/Object;

    .line 4211
    add-int/lit8 v0, v6, 0x1

    move v6, v0

    goto :goto_2

    .line 2873
    :cond_0
    const/4 v0, -0x1

    goto :goto_0

    .line 3824
    :cond_1
    iget-object v0, p0, Lcom/b/a/ac;->j:Ljava/lang/String;

    const/16 v1, 0x23

    invoke-virtual {v0, v1}, Ljava/lang/String;->indexOf(I)I

    move-result v0

    add-int/lit8 v0, v0, 0x1

    .line 3825
    iget-object v1, p0, Lcom/b/a/ac;->j:Ljava/lang/String;

    invoke-virtual {v1, v0}, Ljava/lang/String;->substring(I)Ljava/lang/String;

    move-result-object v0

    goto :goto_1

    .line 4216
    :cond_2
    iget-object v0, v11, Lcom/b/a/ad;->g:Ljava/util/List;

    if-eqz v0, :cond_4

    .line 4217
    iget-object v0, v11, Lcom/b/a/ad;->g:Ljava/util/List;

    invoke-interface {v0}, Ljava/util/List;->size()I

    move-result v1

    move v0, v4

    :goto_3
    if-ge v0, v1, :cond_4

    .line 4218
    iget-object v3, v11, Lcom/b/a/ad;->g:Ljava/util/List;

    invoke-interface {v3, v0}, Ljava/util/List;->get(I)Ljava/lang/Object;

    move-result-object v5

    check-cast v5, Ljava/lang/String;

    .line 4219
    if-eqz v5, :cond_3

    .line 4220
    iget-object v3, v11, Lcom/b/a/ad;->g:Ljava/util/List;

    const-string v6, "\\^`{|}"

    move v7, v2

    move v8, v2

    move v9, v2

    move v10, v2

    .line 4221
    invoke-static/range {v5 .. v10}, Lcom/b/a/ac;->a(Ljava/lang/String;Ljava/lang/String;ZZZZ)Ljava/lang/String;

    move-result-object v5

    .line 4220
    invoke-interface {v3, v0, v5}, Ljava/util/List;->set(ILjava/lang/Object;)Ljava/lang/Object;

    .line 4217
    :cond_3
    add-int/lit8 v0, v0, 0x1

    goto :goto_3

    .line 4225
    :cond_4
    iget-object v0, v11, Lcom/b/a/ad;->h:Ljava/lang/String;

    if-eqz v0, :cond_5

    .line 4226
    iget-object v0, v11, Lcom/b/a/ad;->h:Ljava/lang/String;

    const-string v1, " \"#<>\\^`{|}"

    move v3, v2

    move v5, v4

    invoke-static/range {v0 .. v5}, Lcom/b/a/ac;->a(Ljava/lang/String;Ljava/lang/String;ZZZZ)Ljava/lang/String;

    move-result-object v0

    iput-object v0, v11, Lcom/b/a/ad;->h:Ljava/lang/String;

    .line 372
    :cond_5
    invoke-virtual {v11}, Lcom/b/a/ad;->toString()Ljava/lang/String;

    move-result-object v1

    .line 374
    :try_start_0
    new-instance v0, Ljava/net/URI;

    invoke-direct {v0, v1}, Ljava/net/URI;-><init>(Ljava/lang/String;)V
    :try_end_0
    .catch Ljava/net/URISyntaxException; {:try_start_0 .. :try_end_0} :catch_0

    .line 379
    :goto_4
    return-object v0

    .line 375
    :catch_0
    move-exception v0

    .line 378
    :try_start_1
    const-string v2, "[\\u0000-\\u001F\\u007F-\\u009F\\p{javaWhitespace}]"

    const-string v3, ""

    invoke-virtual {v1, v2, v3}, Ljava/lang/String;->replaceAll(Ljava/lang/String;Ljava/lang/String;)Ljava/lang/String;

    move-result-object v1

    .line 379
    invoke-static {v1}, Ljava/net/URI;->create(Ljava/lang/String;)Ljava/net/URI;
    :try_end_1
    .catch Ljava/lang/Exception; {:try_start_1 .. :try_end_1} :catch_1

    move-result-object v0

    goto :goto_4

    .line 381
    :catch_1
    move-exception v1

    new-instance v1, Ljava/lang/RuntimeException;

    invoke-direct {v1, v0}, Ljava/lang/RuntimeException;-><init>(Ljava/lang/Throwable;)V

    throw v1
.end method

.method public final b()Ljava/lang/String;
    .locals 1

    .prologue
    .line 388
    iget-object v0, p0, Lcom/b/a/ac;->a:Ljava/lang/String;

    return-object v0
.end method

.method public final c(Ljava/lang/String;)Lcom/b/a/ac;
    .locals 1

    .prologue
    .line 862
    invoke-virtual {p0, p1}, Lcom/b/a/ac;->d(Ljava/lang/String;)Lcom/b/a/ad;

    move-result-object v0

    .line 863
    if-eqz v0, :cond_0

    invoke-virtual {v0}, Lcom/b/a/ad;->b()Lcom/b/a/ac;

    move-result-object v0

    :goto_0
    return-object v0

    :cond_0
    const/4 v0, 0x0

    goto :goto_0
.end method

.method public final c()Z
    .locals 2

    .prologue
    .line 392
    iget-object v0, p0, Lcom/b/a/ac;->a:Ljava/lang/String;

    const-string v1, "https"

    invoke-virtual {v0, v1}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v0

    return v0
.end method

.method public final d(Ljava/lang/String;)Lcom/b/a/ad;
    .locals 3

    .prologue
    .line 886
    new-instance v0, Lcom/b/a/ad;

    invoke-direct {v0}, Lcom/b/a/ad;-><init>()V

    .line 887
    invoke-virtual {v0, p0, p1}, Lcom/b/a/ad;->a(Lcom/b/a/ac;Ljava/lang/String;)I

    move-result v1

    .line 888
    sget v2, Lcom/b/a/ae;->a:I

    if-ne v1, v2, :cond_0

    :goto_0
    return-object v0

    :cond_0
    const/4 v0, 0x0

    goto :goto_0
.end method

.method public final d()Ljava/lang/String;
    .locals 4

    .prologue
    .line 407
    iget-object v0, p0, Lcom/b/a/ac;->e:Ljava/lang/String;

    invoke-virtual {v0}, Ljava/lang/String;->isEmpty()Z

    move-result v0

    if-eqz v0, :cond_0

    const-string v0, ""

    .line 410
    :goto_0
    return-object v0

    .line 408
    :cond_0
    iget-object v0, p0, Lcom/b/a/ac;->a:Ljava/lang/String;

    invoke-virtual {v0}, Ljava/lang/String;->length()I

    move-result v0

    add-int/lit8 v0, v0, 0x3

    .line 409
    iget-object v1, p0, Lcom/b/a/ac;->j:Ljava/lang/String;

    iget-object v2, p0, Lcom/b/a/ac;->j:Ljava/lang/String;

    invoke-virtual {v2}, Ljava/lang/String;->length()I

    move-result v2

    const-string v3, ":@"

    invoke-static {v1, v0, v2, v3}, Lcom/b/a/a/c;->a(Ljava/lang/String;IILjava/lang/String;)I

    move-result v1

    .line 410
    iget-object v2, p0, Lcom/b/a/ac;->j:Ljava/lang/String;

    invoke-virtual {v2, v0, v1}, Ljava/lang/String;->substring(II)Ljava/lang/String;

    move-result-object v0

    goto :goto_0
.end method

.method public final e()Ljava/lang/String;
    .locals 3

    .prologue
    .line 440
    iget-object v0, p0, Lcom/b/a/ac;->f:Ljava/lang/String;

    invoke-virtual {v0}, Ljava/lang/String;->isEmpty()Z

    move-result v0

    if-eqz v0, :cond_0

    const-string v0, ""

    .line 443
    :goto_0
    return-object v0

    .line 441
    :cond_0
    iget-object v0, p0, Lcom/b/a/ac;->j:Ljava/lang/String;

    const/16 v1, 0x3a

    iget-object v2, p0, Lcom/b/a/ac;->a:Ljava/lang/String;

    invoke-virtual {v2}, Ljava/lang/String;->length()I

    move-result v2

    add-int/lit8 v2, v2, 0x3

    invoke-virtual {v0, v1, v2}, Ljava/lang/String;->indexOf(II)I

    move-result v0

    add-int/lit8 v0, v0, 0x1

    .line 442
    iget-object v1, p0, Lcom/b/a/ac;->j:Ljava/lang/String;

    const/16 v2, 0x40

    invoke-virtual {v1, v2}, Ljava/lang/String;->indexOf(I)I

    move-result v1

    .line 443
    iget-object v2, p0, Lcom/b/a/ac;->j:Ljava/lang/String;

    invoke-virtual {v2, v0, v1}, Ljava/lang/String;->substring(II)Ljava/lang/String;

    move-result-object v0

    goto :goto_0
.end method

.method public final equals(Ljava/lang/Object;)Z
    .locals 2

    .prologue
    .line 937
    instance-of v0, p1, Lcom/b/a/ac;

    if-eqz v0, :cond_0

    check-cast p1, Lcom/b/a/ac;

    iget-object v0, p1, Lcom/b/a/ac;->j:Ljava/lang/String;

    iget-object v1, p0, Lcom/b/a/ac;->j:Ljava/lang/String;

    invoke-virtual {v0, v1}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v0

    if-eqz v0, :cond_0

    const/4 v0, 0x1

    :goto_0
    return v0

    :cond_0
    const/4 v0, 0x0

    goto :goto_0
.end method

.method public final f()Ljava/lang/String;
    .locals 1

    .prologue
    .line 481
    iget-object v0, p0, Lcom/b/a/ac;->b:Ljava/lang/String;

    return-object v0
.end method

.method public final g()I
    .locals 1

    .prologue
    .line 497
    iget v0, p0, Lcom/b/a/ac;->c:I

    return v0
.end method

.method public final h()Ljava/lang/String;
    .locals 4

    .prologue
    .line 541
    iget-object v0, p0, Lcom/b/a/ac;->j:Ljava/lang/String;

    const/16 v1, 0x2f

    iget-object v2, p0, Lcom/b/a/ac;->a:Ljava/lang/String;

    invoke-virtual {v2}, Ljava/lang/String;->length()I

    move-result v2

    add-int/lit8 v2, v2, 0x3

    invoke-virtual {v0, v1, v2}, Ljava/lang/String;->indexOf(II)I

    move-result v0

    .line 542
    iget-object v1, p0, Lcom/b/a/ac;->j:Ljava/lang/String;

    iget-object v2, p0, Lcom/b/a/ac;->j:Ljava/lang/String;

    invoke-virtual {v2}, Ljava/lang/String;->length()I

    move-result v2

    const-string v3, "?#"

    invoke-static {v1, v0, v2, v3}, Lcom/b/a/a/c;->a(Ljava/lang/String;IILjava/lang/String;)I

    move-result v1

    .line 543
    iget-object v2, p0, Lcom/b/a/ac;->j:Ljava/lang/String;

    invoke-virtual {v2, v0, v1}, Ljava/lang/String;->substring(II)Ljava/lang/String;

    move-result-object v0

    return-object v0
.end method

.method public final hashCode()I
    .locals 1

    .prologue
    .line 941
    iget-object v0, p0, Lcom/b/a/ac;->j:Ljava/lang/String;

    invoke-virtual {v0}, Ljava/lang/String;->hashCode()I

    move-result v0

    return v0
.end method

.method public final i()Ljava/util/List;
    .locals 6
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "()",
            "Ljava/util/List",
            "<",
            "Ljava/lang/String;",
            ">;"
        }
    .end annotation

    .prologue
    const/16 v5, 0x2f

    .line 565
    iget-object v0, p0, Lcom/b/a/ac;->j:Ljava/lang/String;

    iget-object v1, p0, Lcom/b/a/ac;->a:Ljava/lang/String;

    invoke-virtual {v1}, Ljava/lang/String;->length()I

    move-result v1

    add-int/lit8 v1, v1, 0x3

    invoke-virtual {v0, v5, v1}, Ljava/lang/String;->indexOf(II)I

    move-result v0

    .line 566
    iget-object v1, p0, Lcom/b/a/ac;->j:Ljava/lang/String;

    iget-object v2, p0, Lcom/b/a/ac;->j:Ljava/lang/String;

    invoke-virtual {v2}, Ljava/lang/String;->length()I

    move-result v2

    const-string v3, "?#"

    invoke-static {v1, v0, v2, v3}, Lcom/b/a/a/c;->a(Ljava/lang/String;IILjava/lang/String;)I

    move-result v1

    .line 567
    new-instance v2, Ljava/util/ArrayList;

    invoke-direct {v2}, Ljava/util/ArrayList;-><init>()V

    .line 568
    :goto_0
    if-ge v0, v1, :cond_0

    .line 569
    add-int/lit8 v3, v0, 0x1

    .line 570
    iget-object v0, p0, Lcom/b/a/ac;->j:Ljava/lang/String;

    invoke-static {v0, v3, v1, v5}, Lcom/b/a/a/c;->a(Ljava/lang/String;IIC)I

    move-result v0

    .line 571
    iget-object v4, p0, Lcom/b/a/ac;->j:Ljava/lang/String;

    invoke-virtual {v4, v3, v0}, Ljava/lang/String;->substring(II)Ljava/lang/String;

    move-result-object v3

    invoke-interface {v2, v3}, Ljava/util/List;->add(Ljava/lang/Object;)Z

    goto :goto_0

    .line 574
    :cond_0
    return-object v2
.end method

.method public final j()Ljava/lang/String;
    .locals 5

    .prologue
    .line 608
    iget-object v0, p0, Lcom/b/a/ac;->h:Ljava/util/List;

    if-nez v0, :cond_0

    const/4 v0, 0x0

    .line 611
    :goto_0
    return-object v0

    .line 609
    :cond_0
    iget-object v0, p0, Lcom/b/a/ac;->j:Ljava/lang/String;

    const/16 v1, 0x3f

    invoke-virtual {v0, v1}, Ljava/lang/String;->indexOf(I)I

    move-result v0

    add-int/lit8 v0, v0, 0x1

    .line 610
    iget-object v1, p0, Lcom/b/a/ac;->j:Ljava/lang/String;

    add-int/lit8 v2, v0, 0x1

    iget-object v3, p0, Lcom/b/a/ac;->j:Ljava/lang/String;

    invoke-virtual {v3}, Ljava/lang/String;->length()I

    move-result v3

    const/16 v4, 0x23

    invoke-static {v1, v2, v3, v4}, Lcom/b/a/a/c;->a(Ljava/lang/String;IIC)I

    move-result v1

    .line 611
    iget-object v2, p0, Lcom/b/a/ac;->j:Ljava/lang/String;

    invoke-virtual {v2, v0, v1}, Ljava/lang/String;->substring(II)Ljava/lang/String;

    move-result-object v0

    goto :goto_0
.end method

.method public final k()Ljava/lang/String;
    .locals 2

    .prologue
    .line 668
    iget-object v0, p0, Lcom/b/a/ac;->h:Ljava/util/List;

    if-nez v0, :cond_0

    const/4 v0, 0x0

    .line 671
    :goto_0
    return-object v0

    .line 669
    :cond_0
    new-instance v0, Ljava/lang/StringBuilder;

    invoke-direct {v0}, Ljava/lang/StringBuilder;-><init>()V

    .line 670
    iget-object v1, p0, Lcom/b/a/ac;->h:Ljava/util/List;

    invoke-static {v0, v1}, Lcom/b/a/ac;->b(Ljava/lang/StringBuilder;Ljava/util/List;)V

    .line 671
    invoke-virtual {v0}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v0

    goto :goto_0
.end method

.method public final toString()Ljava/lang/String;
    .locals 1

    .prologue
    .line 945
    iget-object v0, p0, Lcom/b/a/ac;->j:Ljava/lang/String;

    return-object v0
.end method
