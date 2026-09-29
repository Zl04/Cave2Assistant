.class Lcom/umeng/commonsdk/proguard/ak$a;
.super Lcom/umeng/commonsdk/proguard/bj;
.source "TUnion.java"


# annotations
.annotation system Ldalvik/annotation/EnclosingClass;
    value = Lcom/umeng/commonsdk/proguard/ak;
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0xa
    name = "a"
.end annotation

.annotation system Ldalvik/annotation/Signature;
    value = {
        "Lcom/umeng/commonsdk/proguard/bj",
        "<",
        "Lcom/umeng/commonsdk/proguard/ak;",
        ">;"
    }
.end annotation


# direct methods
.method private constructor <init>()V
    .locals 0

    .prologue
    .line 215
    invoke-direct {p0}, Lcom/umeng/commonsdk/proguard/bj;-><init>()V

    return-void
.end method

.method synthetic constructor <init>(Lcom/umeng/commonsdk/proguard/ak$1;)V
    .locals 0

    .prologue
    .line 215
    invoke-direct {p0}, Lcom/umeng/commonsdk/proguard/ak$a;-><init>()V

    return-void
.end method


# virtual methods
.method public synthetic a(Lcom/umeng/commonsdk/proguard/az;Lcom/umeng/commonsdk/proguard/aa;)V
    .locals 0
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Lcom/umeng/commonsdk/proguard/ag;
        }
    .end annotation

    .prologue
    .line 215
    check-cast p2, Lcom/umeng/commonsdk/proguard/ak;

    invoke-virtual {p0, p1, p2}, Lcom/umeng/commonsdk/proguard/ak$a;->b(Lcom/umeng/commonsdk/proguard/az;Lcom/umeng/commonsdk/proguard/ak;)V

    return-void
.end method

.method public a(Lcom/umeng/commonsdk/proguard/az;Lcom/umeng/commonsdk/proguard/ak;)V
    .locals 2
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Lcom/umeng/commonsdk/proguard/ag;
        }
    .end annotation

    .prologue
    const/4 v0, 0x0

    .line 219
    iput-object v0, p2, Lcom/umeng/commonsdk/proguard/ak;->b:Lcom/umeng/commonsdk/proguard/ah;

    .line 220
    iput-object v0, p2, Lcom/umeng/commonsdk/proguard/ak;->a:Ljava/lang/Object;

    .line 222
    invoke-virtual {p1}, Lcom/umeng/commonsdk/proguard/az;->j()Lcom/umeng/commonsdk/proguard/be;

    .line 224
    invoke-virtual {p1}, Lcom/umeng/commonsdk/proguard/az;->l()Lcom/umeng/commonsdk/proguard/au;

    move-result-object v0

    .line 226
    invoke-virtual {p2, p1, v0}, Lcom/umeng/commonsdk/proguard/ak;->a(Lcom/umeng/commonsdk/proguard/az;Lcom/umeng/commonsdk/proguard/au;)Ljava/lang/Object;

    move-result-object v1

    iput-object v1, p2, Lcom/umeng/commonsdk/proguard/ak;->a:Ljava/lang/Object;

    .line 227
    iget-object v1, p2, Lcom/umeng/commonsdk/proguard/ak;->a:Ljava/lang/Object;

    if-eqz v1, :cond_0

    .line 228
    iget-short v0, v0, Lcom/umeng/commonsdk/proguard/au;->c:S

    invoke-virtual {p2, v0}, Lcom/umeng/commonsdk/proguard/ak;->a(S)Lcom/umeng/commonsdk/proguard/ah;

    move-result-object v0

    iput-object v0, p2, Lcom/umeng/commonsdk/proguard/ak;->b:Lcom/umeng/commonsdk/proguard/ah;

    .line 231
    :cond_0
    invoke-virtual {p1}, Lcom/umeng/commonsdk/proguard/az;->m()V

    .line 235
    invoke-virtual {p1}, Lcom/umeng/commonsdk/proguard/az;->l()Lcom/umeng/commonsdk/proguard/au;

    .line 236
    invoke-virtual {p1}, Lcom/umeng/commonsdk/proguard/az;->k()V

    .line 237
    return-void
.end method

.method public synthetic b(Lcom/umeng/commonsdk/proguard/az;Lcom/umeng/commonsdk/proguard/aa;)V
    .locals 0
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Lcom/umeng/commonsdk/proguard/ag;
        }
    .end annotation

    .prologue
    .line 215
    check-cast p2, Lcom/umeng/commonsdk/proguard/ak;

    invoke-virtual {p0, p1, p2}, Lcom/umeng/commonsdk/proguard/ak$a;->a(Lcom/umeng/commonsdk/proguard/az;Lcom/umeng/commonsdk/proguard/ak;)V

    return-void
.end method

.method public b(Lcom/umeng/commonsdk/proguard/az;Lcom/umeng/commonsdk/proguard/ak;)V
    .locals 2
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Lcom/umeng/commonsdk/proguard/ag;
        }
    .end annotation

    .prologue
    .line 241
    invoke-virtual {p2}, Lcom/umeng/commonsdk/proguard/ak;->a()Lcom/umeng/commonsdk/proguard/ah;

    move-result-object v0

    if-eqz v0, :cond_0

    invoke-virtual {p2}, Lcom/umeng/commonsdk/proguard/ak;->b()Ljava/lang/Object;

    move-result-object v0

    if-nez v0, :cond_1

    .line 242
    :cond_0
    new-instance v0, Lcom/umeng/commonsdk/proguard/ba;

    const-string v1, "Cannot write a TUnion with no set value!"

    invoke-direct {v0, v1}, Lcom/umeng/commonsdk/proguard/ba;-><init>(Ljava/lang/String;)V

    throw v0

    .line 244
    :cond_1
    invoke-virtual {p2}, Lcom/umeng/commonsdk/proguard/ak;->d()Lcom/umeng/commonsdk/proguard/be;

    move-result-object v0

    invoke-virtual {p1, v0}, Lcom/umeng/commonsdk/proguard/az;->a(Lcom/umeng/commonsdk/proguard/be;)V

    .line 245
    iget-object v0, p2, Lcom/umeng/commonsdk/proguard/ak;->b:Lcom/umeng/commonsdk/proguard/ah;

    invoke-virtual {p2, v0}, Lcom/umeng/commonsdk/proguard/ak;->c(Lcom/umeng/commonsdk/proguard/ah;)Lcom/umeng/commonsdk/proguard/au;

    move-result-object v0

    invoke-virtual {p1, v0}, Lcom/umeng/commonsdk/proguard/az;->a(Lcom/umeng/commonsdk/proguard/au;)V

    .line 246
    invoke-virtual {p2, p1}, Lcom/umeng/commonsdk/proguard/ak;->a(Lcom/umeng/commonsdk/proguard/az;)V

    .line 247
    invoke-virtual {p1}, Lcom/umeng/commonsdk/proguard/az;->c()V

    .line 248
    invoke-virtual {p1}, Lcom/umeng/commonsdk/proguard/az;->d()V

    .line 249
    invoke-virtual {p1}, Lcom/umeng/commonsdk/proguard/az;->b()V

    .line 250
    return-void
.end method
