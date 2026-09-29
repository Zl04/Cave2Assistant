.class public Lcom/umeng/commonsdk/proguard/as$a;
.super Ljava/lang/Object;
.source "TBinaryProtocol.java"

# interfaces
.implements Lcom/umeng/commonsdk/proguard/bb;


# annotations
.annotation system Ldalvik/annotation/EnclosingClass;
    value = Lcom/umeng/commonsdk/proguard/as;
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x9
    name = "a"
.end annotation


# instance fields
.field protected a:Z

.field protected b:Z

.field protected c:I


# direct methods
.method public constructor <init>()V
    .locals 2

    .prologue
    .line 58
    const/4 v0, 0x0

    const/4 v1, 0x1

    invoke-direct {p0, v0, v1}, Lcom/umeng/commonsdk/proguard/as$a;-><init>(ZZ)V

    .line 59
    return-void
.end method

.method public constructor <init>(ZZ)V
    .locals 1

    .prologue
    .line 62
    const/4 v0, 0x0

    invoke-direct {p0, p1, p2, v0}, Lcom/umeng/commonsdk/proguard/as$a;-><init>(ZZI)V

    .line 63
    return-void
.end method

.method public constructor <init>(ZZI)V
    .locals 1

    .prologue
    .line 65
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    .line 53
    const/4 v0, 0x0

    iput-boolean v0, p0, Lcom/umeng/commonsdk/proguard/as$a;->a:Z

    .line 54
    const/4 v0, 0x1

    iput-boolean v0, p0, Lcom/umeng/commonsdk/proguard/as$a;->b:Z

    .line 66
    iput-boolean p1, p0, Lcom/umeng/commonsdk/proguard/as$a;->a:Z

    .line 67
    iput-boolean p2, p0, Lcom/umeng/commonsdk/proguard/as$a;->b:Z

    .line 68
    iput p3, p0, Lcom/umeng/commonsdk/proguard/as$a;->c:I

    .line 69
    return-void
.end method


# virtual methods
.method public a(Lcom/umeng/commonsdk/proguard/bn;)Lcom/umeng/commonsdk/proguard/az;
    .locals 3

    .prologue
    .line 72
    new-instance v0, Lcom/umeng/commonsdk/proguard/as;

    iget-boolean v1, p0, Lcom/umeng/commonsdk/proguard/as$a;->a:Z

    iget-boolean v2, p0, Lcom/umeng/commonsdk/proguard/as$a;->b:Z

    invoke-direct {v0, p1, v1, v2}, Lcom/umeng/commonsdk/proguard/as;-><init>(Lcom/umeng/commonsdk/proguard/bn;ZZ)V

    .line 73
    iget v1, p0, Lcom/umeng/commonsdk/proguard/as$a;->c:I

    if-eqz v1, :cond_0

    .line 74
    iget v1, p0, Lcom/umeng/commonsdk/proguard/as$a;->c:I

    invoke-virtual {v0, v1}, Lcom/umeng/commonsdk/proguard/as;->c(I)V

    .line 76
    :cond_0
    return-object v0
.end method
