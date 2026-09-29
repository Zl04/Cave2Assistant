.class Lcom/umeng/commonsdk/proguard/w$c;
.super Lcom/umeng/commonsdk/proguard/bk;
.source "UMEnvelope.java"


# annotations
.annotation system Ldalvik/annotation/EnclosingClass;
    value = Lcom/umeng/commonsdk/proguard/w;
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0xa
    name = "c"
.end annotation

.annotation system Ldalvik/annotation/Signature;
    value = {
        "Lcom/umeng/commonsdk/proguard/bk",
        "<",
        "Lcom/umeng/commonsdk/proguard/w;",
        ">;"
    }
.end annotation


# direct methods
.method private constructor <init>()V
    .locals 0

    .prologue
    .line 910
    invoke-direct {p0}, Lcom/umeng/commonsdk/proguard/bk;-><init>()V

    return-void
.end method

.method synthetic constructor <init>(Lcom/umeng/commonsdk/proguard/w$1;)V
    .locals 0

    .prologue
    .line 910
    invoke-direct {p0}, Lcom/umeng/commonsdk/proguard/w$c;-><init>()V

    return-void
.end method


# virtual methods
.method public bridge synthetic a(Lcom/umeng/commonsdk/proguard/az;Lcom/umeng/commonsdk/proguard/aa;)V
    .locals 0
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Lcom/umeng/commonsdk/proguard/ag;
        }
    .end annotation

    .prologue
    .line 910
    check-cast p2, Lcom/umeng/commonsdk/proguard/w;

    invoke-virtual {p0, p1, p2}, Lcom/umeng/commonsdk/proguard/w$c;->a(Lcom/umeng/commonsdk/proguard/az;Lcom/umeng/commonsdk/proguard/w;)V

    return-void
.end method

.method public a(Lcom/umeng/commonsdk/proguard/az;Lcom/umeng/commonsdk/proguard/w;)V
    .locals 2
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Lcom/umeng/commonsdk/proguard/ag;
        }
    .end annotation

    .prologue
    .line 915
    check-cast p1, Lcom/umeng/commonsdk/proguard/bf;

    .line 916
    iget-object v0, p2, Lcom/umeng/commonsdk/proguard/w;->a:Ljava/lang/String;

    invoke-virtual {p1, v0}, Lcom/umeng/commonsdk/proguard/bf;->a(Ljava/lang/String;)V

    .line 917
    iget-object v0, p2, Lcom/umeng/commonsdk/proguard/w;->b:Ljava/lang/String;

    invoke-virtual {p1, v0}, Lcom/umeng/commonsdk/proguard/bf;->a(Ljava/lang/String;)V

    .line 918
    iget-object v0, p2, Lcom/umeng/commonsdk/proguard/w;->c:Ljava/lang/String;

    invoke-virtual {p1, v0}, Lcom/umeng/commonsdk/proguard/bf;->a(Ljava/lang/String;)V

    .line 919
    iget v0, p2, Lcom/umeng/commonsdk/proguard/w;->d:I

    invoke-virtual {p1, v0}, Lcom/umeng/commonsdk/proguard/bf;->a(I)V

    .line 920
    iget v0, p2, Lcom/umeng/commonsdk/proguard/w;->e:I

    invoke-virtual {p1, v0}, Lcom/umeng/commonsdk/proguard/bf;->a(I)V

    .line 921
    iget v0, p2, Lcom/umeng/commonsdk/proguard/w;->f:I

    invoke-virtual {p1, v0}, Lcom/umeng/commonsdk/proguard/bf;->a(I)V

    .line 922
    iget-object v0, p2, Lcom/umeng/commonsdk/proguard/w;->g:Ljava/nio/ByteBuffer;

    invoke-virtual {p1, v0}, Lcom/umeng/commonsdk/proguard/bf;->a(Ljava/nio/ByteBuffer;)V

    .line 923
    iget-object v0, p2, Lcom/umeng/commonsdk/proguard/w;->h:Ljava/lang/String;

    invoke-virtual {p1, v0}, Lcom/umeng/commonsdk/proguard/bf;->a(Ljava/lang/String;)V

    .line 924
    iget-object v0, p2, Lcom/umeng/commonsdk/proguard/w;->i:Ljava/lang/String;

    invoke-virtual {p1, v0}, Lcom/umeng/commonsdk/proguard/bf;->a(Ljava/lang/String;)V

    .line 925
    new-instance v0, Ljava/util/BitSet;

    invoke-direct {v0}, Ljava/util/BitSet;-><init>()V

    .line 926
    invoke-virtual {p2}, Lcom/umeng/commonsdk/proguard/w;->F()Z

    move-result v1

    if-eqz v1, :cond_0

    .line 927
    const/4 v1, 0x0

    invoke-virtual {v0, v1}, Ljava/util/BitSet;->set(I)V

    .line 929
    :cond_0
    const/4 v1, 0x1

    invoke-virtual {p1, v0, v1}, Lcom/umeng/commonsdk/proguard/bf;->a(Ljava/util/BitSet;I)V

    .line 930
    invoke-virtual {p2}, Lcom/umeng/commonsdk/proguard/w;->F()Z

    move-result v0

    if-eqz v0, :cond_1

    .line 931
    iget v0, p2, Lcom/umeng/commonsdk/proguard/w;->j:I

    invoke-virtual {p1, v0}, Lcom/umeng/commonsdk/proguard/bf;->a(I)V

    .line 933
    :cond_1
    return-void
.end method

.method public bridge synthetic b(Lcom/umeng/commonsdk/proguard/az;Lcom/umeng/commonsdk/proguard/aa;)V
    .locals 0
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Lcom/umeng/commonsdk/proguard/ag;
        }
    .end annotation

    .prologue
    .line 910
    check-cast p2, Lcom/umeng/commonsdk/proguard/w;

    invoke-virtual {p0, p1, p2}, Lcom/umeng/commonsdk/proguard/w$c;->b(Lcom/umeng/commonsdk/proguard/az;Lcom/umeng/commonsdk/proguard/w;)V

    return-void
.end method

.method public b(Lcom/umeng/commonsdk/proguard/az;Lcom/umeng/commonsdk/proguard/w;)V
    .locals 3
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Lcom/umeng/commonsdk/proguard/ag;
        }
    .end annotation

    .prologue
    const/4 v2, 0x1

    .line 938
    check-cast p1, Lcom/umeng/commonsdk/proguard/bf;

    .line 939
    invoke-virtual {p1}, Lcom/umeng/commonsdk/proguard/bf;->z()Ljava/lang/String;

    move-result-object v0

    iput-object v0, p2, Lcom/umeng/commonsdk/proguard/w;->a:Ljava/lang/String;

    .line 940
    invoke-virtual {p2, v2}, Lcom/umeng/commonsdk/proguard/w;->a(Z)V

    .line 941
    invoke-virtual {p1}, Lcom/umeng/commonsdk/proguard/bf;->z()Ljava/lang/String;

    move-result-object v0

    iput-object v0, p2, Lcom/umeng/commonsdk/proguard/w;->b:Ljava/lang/String;

    .line 942
    invoke-virtual {p2, v2}, Lcom/umeng/commonsdk/proguard/w;->b(Z)V

    .line 943
    invoke-virtual {p1}, Lcom/umeng/commonsdk/proguard/bf;->z()Ljava/lang/String;

    move-result-object v0

    iput-object v0, p2, Lcom/umeng/commonsdk/proguard/w;->c:Ljava/lang/String;

    .line 944
    invoke-virtual {p2, v2}, Lcom/umeng/commonsdk/proguard/w;->c(Z)V

    .line 945
    invoke-virtual {p1}, Lcom/umeng/commonsdk/proguard/bf;->w()I

    move-result v0

    iput v0, p2, Lcom/umeng/commonsdk/proguard/w;->d:I

    .line 946
    invoke-virtual {p2, v2}, Lcom/umeng/commonsdk/proguard/w;->d(Z)V

    .line 947
    invoke-virtual {p1}, Lcom/umeng/commonsdk/proguard/bf;->w()I

    move-result v0

    iput v0, p2, Lcom/umeng/commonsdk/proguard/w;->e:I

    .line 948
    invoke-virtual {p2, v2}, Lcom/umeng/commonsdk/proguard/w;->e(Z)V

    .line 949
    invoke-virtual {p1}, Lcom/umeng/commonsdk/proguard/bf;->w()I

    move-result v0

    iput v0, p2, Lcom/umeng/commonsdk/proguard/w;->f:I

    .line 950
    invoke-virtual {p2, v2}, Lcom/umeng/commonsdk/proguard/w;->f(Z)V

    .line 951
    invoke-virtual {p1}, Lcom/umeng/commonsdk/proguard/bf;->A()Ljava/nio/ByteBuffer;

    move-result-object v0

    iput-object v0, p2, Lcom/umeng/commonsdk/proguard/w;->g:Ljava/nio/ByteBuffer;

    .line 952
    invoke-virtual {p2, v2}, Lcom/umeng/commonsdk/proguard/w;->g(Z)V

    .line 953
    invoke-virtual {p1}, Lcom/umeng/commonsdk/proguard/bf;->z()Ljava/lang/String;

    move-result-object v0

    iput-object v0, p2, Lcom/umeng/commonsdk/proguard/w;->h:Ljava/lang/String;

    .line 954
    invoke-virtual {p2, v2}, Lcom/umeng/commonsdk/proguard/w;->h(Z)V

    .line 955
    invoke-virtual {p1}, Lcom/umeng/commonsdk/proguard/bf;->z()Ljava/lang/String;

    move-result-object v0

    iput-object v0, p2, Lcom/umeng/commonsdk/proguard/w;->i:Ljava/lang/String;

    .line 956
    invoke-virtual {p2, v2}, Lcom/umeng/commonsdk/proguard/w;->i(Z)V

    .line 957
    invoke-virtual {p1, v2}, Lcom/umeng/commonsdk/proguard/bf;->b(I)Ljava/util/BitSet;

    move-result-object v0

    .line 958
    const/4 v1, 0x0

    invoke-virtual {v0, v1}, Ljava/util/BitSet;->get(I)Z

    move-result v0

    if-eqz v0, :cond_0

    .line 959
    invoke-virtual {p1}, Lcom/umeng/commonsdk/proguard/bf;->w()I

    move-result v0

    iput v0, p2, Lcom/umeng/commonsdk/proguard/w;->j:I

    .line 960
    invoke-virtual {p2, v2}, Lcom/umeng/commonsdk/proguard/w;->j(Z)V

    .line 962
    :cond_0
    return-void
.end method
