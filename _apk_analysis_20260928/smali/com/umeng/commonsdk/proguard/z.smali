.class public Lcom/umeng/commonsdk/proguard/z;
.super Lcom/umeng/commonsdk/proguard/ag;
.source "TApplicationException.java"


# static fields
.field public static final a:I = 0x0

.field public static final b:I = 0x1

.field public static final c:I = 0x2

.field public static final d:I = 0x3

.field public static final e:I = 0x4

.field public static final f:I = 0x5

.field public static final g:I = 0x6

.field public static final h:I = 0x7

.field private static final j:Lcom/umeng/commonsdk/proguard/be;

.field private static final k:Lcom/umeng/commonsdk/proguard/au;

.field private static final l:Lcom/umeng/commonsdk/proguard/au;

.field private static final m:J = 0x1L


# instance fields
.field protected i:I


# direct methods
.method static constructor <clinit>()V
    .locals 4

    .prologue
    .line 34
    new-instance v0, Lcom/umeng/commonsdk/proguard/be;

    const-string v1, "TApplicationException"

    invoke-direct {v0, v1}, Lcom/umeng/commonsdk/proguard/be;-><init>(Ljava/lang/String;)V

    sput-object v0, Lcom/umeng/commonsdk/proguard/z;->j:Lcom/umeng/commonsdk/proguard/be;

    .line 35
    new-instance v0, Lcom/umeng/commonsdk/proguard/au;

    const-string v1, "message"

    const/16 v2, 0xb

    const/4 v3, 0x1

    invoke-direct {v0, v1, v2, v3}, Lcom/umeng/commonsdk/proguard/au;-><init>(Ljava/lang/String;BS)V

    sput-object v0, Lcom/umeng/commonsdk/proguard/z;->k:Lcom/umeng/commonsdk/proguard/au;

    .line 36
    new-instance v0, Lcom/umeng/commonsdk/proguard/au;

    const-string v1, "type"

    const/16 v2, 0x8

    const/4 v3, 0x2

    invoke-direct {v0, v1, v2, v3}, Lcom/umeng/commonsdk/proguard/au;-><init>(Ljava/lang/String;BS)V

    sput-object v0, Lcom/umeng/commonsdk/proguard/z;->l:Lcom/umeng/commonsdk/proguard/au;

    return-void
.end method

.method public constructor <init>()V
    .locals 1

    .prologue
    .line 52
    invoke-direct {p0}, Lcom/umeng/commonsdk/proguard/ag;-><init>()V

    .line 49
    const/4 v0, 0x0

    iput v0, p0, Lcom/umeng/commonsdk/proguard/z;->i:I

    .line 53
    return-void
.end method

.method public constructor <init>(I)V
    .locals 1

    .prologue
    .line 56
    invoke-direct {p0}, Lcom/umeng/commonsdk/proguard/ag;-><init>()V

    .line 49
    const/4 v0, 0x0

    iput v0, p0, Lcom/umeng/commonsdk/proguard/z;->i:I

    .line 57
    iput p1, p0, Lcom/umeng/commonsdk/proguard/z;->i:I

    .line 58
    return-void
.end method

.method public constructor <init>(ILjava/lang/String;)V
    .locals 1

    .prologue
    .line 61
    invoke-direct {p0, p2}, Lcom/umeng/commonsdk/proguard/ag;-><init>(Ljava/lang/String;)V

    .line 49
    const/4 v0, 0x0

    iput v0, p0, Lcom/umeng/commonsdk/proguard/z;->i:I

    .line 62
    iput p1, p0, Lcom/umeng/commonsdk/proguard/z;->i:I

    .line 63
    return-void
.end method

.method public constructor <init>(Ljava/lang/String;)V
    .locals 1

    .prologue
    .line 66
    invoke-direct {p0, p1}, Lcom/umeng/commonsdk/proguard/ag;-><init>(Ljava/lang/String;)V

    .line 49
    const/4 v0, 0x0

    iput v0, p0, Lcom/umeng/commonsdk/proguard/z;->i:I

    .line 67
    return-void
.end method

.method public static a(Lcom/umeng/commonsdk/proguard/az;)Lcom/umeng/commonsdk/proguard/z;
    .locals 5
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Lcom/umeng/commonsdk/proguard/ag;
        }
    .end annotation

    .prologue
    .line 75
    invoke-virtual {p0}, Lcom/umeng/commonsdk/proguard/az;->j()Lcom/umeng/commonsdk/proguard/be;

    .line 77
    const/4 v1, 0x0

    .line 78
    const/4 v0, 0x0

    .line 81
    :goto_0
    invoke-virtual {p0}, Lcom/umeng/commonsdk/proguard/az;->l()Lcom/umeng/commonsdk/proguard/au;

    move-result-object v2

    .line 82
    iget-byte v3, v2, Lcom/umeng/commonsdk/proguard/au;->b:B

    if-nez v3, :cond_0

    .line 106
    invoke-virtual {p0}, Lcom/umeng/commonsdk/proguard/az;->k()V

    .line 108
    new-instance v2, Lcom/umeng/commonsdk/proguard/z;

    invoke-direct {v2, v0, v1}, Lcom/umeng/commonsdk/proguard/z;-><init>(ILjava/lang/String;)V

    return-object v2

    .line 85
    :cond_0
    iget-short v3, v2, Lcom/umeng/commonsdk/proguard/au;->c:S

    packed-switch v3, :pswitch_data_0

    .line 101
    iget-byte v2, v2, Lcom/umeng/commonsdk/proguard/au;->b:B

    invoke-static {p0, v2}, Lcom/umeng/commonsdk/proguard/bc;->a(Lcom/umeng/commonsdk/proguard/az;B)V

    .line 104
    :goto_1
    invoke-virtual {p0}, Lcom/umeng/commonsdk/proguard/az;->m()V

    goto :goto_0

    .line 87
    :pswitch_0
    iget-byte v3, v2, Lcom/umeng/commonsdk/proguard/au;->b:B

    const/16 v4, 0xb

    if-ne v3, v4, :cond_1

    .line 88
    invoke-virtual {p0}, Lcom/umeng/commonsdk/proguard/az;->z()Ljava/lang/String;

    move-result-object v1

    goto :goto_1

    .line 90
    :cond_1
    iget-byte v2, v2, Lcom/umeng/commonsdk/proguard/au;->b:B

    invoke-static {p0, v2}, Lcom/umeng/commonsdk/proguard/bc;->a(Lcom/umeng/commonsdk/proguard/az;B)V

    goto :goto_1

    .line 94
    :pswitch_1
    iget-byte v3, v2, Lcom/umeng/commonsdk/proguard/au;->b:B

    const/16 v4, 0x8

    if-ne v3, v4, :cond_2

    .line 95
    invoke-virtual {p0}, Lcom/umeng/commonsdk/proguard/az;->w()I

    move-result v0

    goto :goto_1

    .line 97
    :cond_2
    iget-byte v2, v2, Lcom/umeng/commonsdk/proguard/au;->b:B

    invoke-static {p0, v2}, Lcom/umeng/commonsdk/proguard/bc;->a(Lcom/umeng/commonsdk/proguard/az;B)V

    goto :goto_1

    .line 85
    :pswitch_data_0
    .packed-switch 0x1
        :pswitch_0
        :pswitch_1
    .end packed-switch
.end method


# virtual methods
.method public a()I
    .locals 1

    .prologue
    .line 70
    iget v0, p0, Lcom/umeng/commonsdk/proguard/z;->i:I

    return v0
.end method

.method public b(Lcom/umeng/commonsdk/proguard/az;)V
    .locals 1
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Lcom/umeng/commonsdk/proguard/ag;
        }
    .end annotation

    .prologue
    .line 112
    sget-object v0, Lcom/umeng/commonsdk/proguard/z;->j:Lcom/umeng/commonsdk/proguard/be;

    invoke-virtual {p1, v0}, Lcom/umeng/commonsdk/proguard/az;->a(Lcom/umeng/commonsdk/proguard/be;)V

    .line 113
    invoke-virtual {p0}, Lcom/umeng/commonsdk/proguard/z;->getMessage()Ljava/lang/String;

    move-result-object v0

    if-eqz v0, :cond_0

    .line 114
    sget-object v0, Lcom/umeng/commonsdk/proguard/z;->k:Lcom/umeng/commonsdk/proguard/au;

    invoke-virtual {p1, v0}, Lcom/umeng/commonsdk/proguard/az;->a(Lcom/umeng/commonsdk/proguard/au;)V

    .line 115
    invoke-virtual {p0}, Lcom/umeng/commonsdk/proguard/z;->getMessage()Ljava/lang/String;

    move-result-object v0

    invoke-virtual {p1, v0}, Lcom/umeng/commonsdk/proguard/az;->a(Ljava/lang/String;)V

    .line 116
    invoke-virtual {p1}, Lcom/umeng/commonsdk/proguard/az;->c()V

    .line 118
    :cond_0
    sget-object v0, Lcom/umeng/commonsdk/proguard/z;->l:Lcom/umeng/commonsdk/proguard/au;

    invoke-virtual {p1, v0}, Lcom/umeng/commonsdk/proguard/az;->a(Lcom/umeng/commonsdk/proguard/au;)V

    .line 119
    iget v0, p0, Lcom/umeng/commonsdk/proguard/z;->i:I

    invoke-virtual {p1, v0}, Lcom/umeng/commonsdk/proguard/az;->a(I)V

    .line 120
    invoke-virtual {p1}, Lcom/umeng/commonsdk/proguard/az;->c()V

    .line 121
    invoke-virtual {p1}, Lcom/umeng/commonsdk/proguard/az;->d()V

    .line 122
    invoke-virtual {p1}, Lcom/umeng/commonsdk/proguard/az;->b()V

    .line 123
    return-void
.end method
