.class Lcom/umeng/commonsdk/proguard/w$a;
.super Lcom/umeng/commonsdk/proguard/bj;
.source "UMEnvelope.java"


# annotations
.annotation system Ldalvik/annotation/EnclosingClass;
    value = Lcom/umeng/commonsdk/proguard/w;
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0xa
    name = "a"
.end annotation

.annotation system Ldalvik/annotation/Signature;
    value = {
        "Lcom/umeng/commonsdk/proguard/bj",
        "<",
        "Lcom/umeng/commonsdk/proguard/w;",
        ">;"
    }
.end annotation


# direct methods
.method private constructor <init>()V
    .locals 0

    .prologue
    .line 732
    invoke-direct {p0}, Lcom/umeng/commonsdk/proguard/bj;-><init>()V

    return-void
.end method

.method synthetic constructor <init>(Lcom/umeng/commonsdk/proguard/w$1;)V
    .locals 0

    .prologue
    .line 732
    invoke-direct {p0}, Lcom/umeng/commonsdk/proguard/w$a;-><init>()V

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
    .line 732
    check-cast p2, Lcom/umeng/commonsdk/proguard/w;

    invoke-virtual {p0, p1, p2}, Lcom/umeng/commonsdk/proguard/w$a;->b(Lcom/umeng/commonsdk/proguard/az;Lcom/umeng/commonsdk/proguard/w;)V

    return-void
.end method

.method public a(Lcom/umeng/commonsdk/proguard/az;Lcom/umeng/commonsdk/proguard/w;)V
    .locals 5
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Lcom/umeng/commonsdk/proguard/ag;
        }
    .end annotation

    .prologue
    const/16 v4, 0x8

    const/16 v3, 0xb

    const/4 v2, 0x1

    .line 737
    invoke-virtual {p1}, Lcom/umeng/commonsdk/proguard/az;->j()Lcom/umeng/commonsdk/proguard/be;

    .line 739
    :goto_0
    invoke-virtual {p1}, Lcom/umeng/commonsdk/proguard/az;->l()Lcom/umeng/commonsdk/proguard/au;

    move-result-object v0

    .line 740
    iget-byte v1, v0, Lcom/umeng/commonsdk/proguard/au;->b:B

    if-nez v1, :cond_0

    .line 829
    invoke-virtual {p1}, Lcom/umeng/commonsdk/proguard/az;->k()V

    .line 833
    invoke-virtual {p2}, Lcom/umeng/commonsdk/proguard/w;->m()Z

    move-result v0

    if-nez v0, :cond_b

    .line 834
    new-instance v0, Lcom/umeng/commonsdk/proguard/ba;

    new-instance v1, Ljava/lang/StringBuilder;

    invoke-direct {v1}, Ljava/lang/StringBuilder;-><init>()V

    const-string v2, "Required field \'serial_num\' was not found in serialized data! Struct: "

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    .line 835
    invoke-virtual {p0}, Ljava/lang/Object;->toString()Ljava/lang/String;

    move-result-object v2

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v1

    invoke-direct {v0, v1}, Lcom/umeng/commonsdk/proguard/ba;-><init>(Ljava/lang/String;)V

    throw v0

    .line 743
    :cond_0
    iget-short v1, v0, Lcom/umeng/commonsdk/proguard/au;->c:S

    packed-switch v1, :pswitch_data_0

    .line 825
    iget-byte v0, v0, Lcom/umeng/commonsdk/proguard/au;->b:B

    invoke-static {p1, v0}, Lcom/umeng/commonsdk/proguard/bc;->a(Lcom/umeng/commonsdk/proguard/az;B)V

    .line 827
    :goto_1
    invoke-virtual {p1}, Lcom/umeng/commonsdk/proguard/az;->m()V

    goto :goto_0

    .line 745
    :pswitch_0
    iget-byte v1, v0, Lcom/umeng/commonsdk/proguard/au;->b:B

    if-ne v1, v3, :cond_1

    .line 746
    invoke-virtual {p1}, Lcom/umeng/commonsdk/proguard/az;->z()Ljava/lang/String;

    move-result-object v0

    iput-object v0, p2, Lcom/umeng/commonsdk/proguard/w;->a:Ljava/lang/String;

    .line 747
    invoke-virtual {p2, v2}, Lcom/umeng/commonsdk/proguard/w;->a(Z)V

    goto :goto_1

    .line 749
    :cond_1
    iget-byte v0, v0, Lcom/umeng/commonsdk/proguard/au;->b:B

    invoke-static {p1, v0}, Lcom/umeng/commonsdk/proguard/bc;->a(Lcom/umeng/commonsdk/proguard/az;B)V

    goto :goto_1

    .line 753
    :pswitch_1
    iget-byte v1, v0, Lcom/umeng/commonsdk/proguard/au;->b:B

    if-ne v1, v3, :cond_2

    .line 754
    invoke-virtual {p1}, Lcom/umeng/commonsdk/proguard/az;->z()Ljava/lang/String;

    move-result-object v0

    iput-object v0, p2, Lcom/umeng/commonsdk/proguard/w;->b:Ljava/lang/String;

    .line 755
    invoke-virtual {p2, v2}, Lcom/umeng/commonsdk/proguard/w;->b(Z)V

    goto :goto_1

    .line 757
    :cond_2
    iget-byte v0, v0, Lcom/umeng/commonsdk/proguard/au;->b:B

    invoke-static {p1, v0}, Lcom/umeng/commonsdk/proguard/bc;->a(Lcom/umeng/commonsdk/proguard/az;B)V

    goto :goto_1

    .line 761
    :pswitch_2
    iget-byte v1, v0, Lcom/umeng/commonsdk/proguard/au;->b:B

    if-ne v1, v3, :cond_3

    .line 762
    invoke-virtual {p1}, Lcom/umeng/commonsdk/proguard/az;->z()Ljava/lang/String;

    move-result-object v0

    iput-object v0, p2, Lcom/umeng/commonsdk/proguard/w;->c:Ljava/lang/String;

    .line 763
    invoke-virtual {p2, v2}, Lcom/umeng/commonsdk/proguard/w;->c(Z)V

    goto :goto_1

    .line 765
    :cond_3
    iget-byte v0, v0, Lcom/umeng/commonsdk/proguard/au;->b:B

    invoke-static {p1, v0}, Lcom/umeng/commonsdk/proguard/bc;->a(Lcom/umeng/commonsdk/proguard/az;B)V

    goto :goto_1

    .line 769
    :pswitch_3
    iget-byte v1, v0, Lcom/umeng/commonsdk/proguard/au;->b:B

    if-ne v1, v4, :cond_4

    .line 770
    invoke-virtual {p1}, Lcom/umeng/commonsdk/proguard/az;->w()I

    move-result v0

    iput v0, p2, Lcom/umeng/commonsdk/proguard/w;->d:I

    .line 771
    invoke-virtual {p2, v2}, Lcom/umeng/commonsdk/proguard/w;->d(Z)V

    goto :goto_1

    .line 773
    :cond_4
    iget-byte v0, v0, Lcom/umeng/commonsdk/proguard/au;->b:B

    invoke-static {p1, v0}, Lcom/umeng/commonsdk/proguard/bc;->a(Lcom/umeng/commonsdk/proguard/az;B)V

    goto :goto_1

    .line 777
    :pswitch_4
    iget-byte v1, v0, Lcom/umeng/commonsdk/proguard/au;->b:B

    if-ne v1, v4, :cond_5

    .line 778
    invoke-virtual {p1}, Lcom/umeng/commonsdk/proguard/az;->w()I

    move-result v0

    iput v0, p2, Lcom/umeng/commonsdk/proguard/w;->e:I

    .line 779
    invoke-virtual {p2, v2}, Lcom/umeng/commonsdk/proguard/w;->e(Z)V

    goto :goto_1

    .line 781
    :cond_5
    iget-byte v0, v0, Lcom/umeng/commonsdk/proguard/au;->b:B

    invoke-static {p1, v0}, Lcom/umeng/commonsdk/proguard/bc;->a(Lcom/umeng/commonsdk/proguard/az;B)V

    goto :goto_1

    .line 785
    :pswitch_5
    iget-byte v1, v0, Lcom/umeng/commonsdk/proguard/au;->b:B

    if-ne v1, v4, :cond_6

    .line 786
    invoke-virtual {p1}, Lcom/umeng/commonsdk/proguard/az;->w()I

    move-result v0

    iput v0, p2, Lcom/umeng/commonsdk/proguard/w;->f:I

    .line 787
    invoke-virtual {p2, v2}, Lcom/umeng/commonsdk/proguard/w;->f(Z)V

    goto :goto_1

    .line 789
    :cond_6
    iget-byte v0, v0, Lcom/umeng/commonsdk/proguard/au;->b:B

    invoke-static {p1, v0}, Lcom/umeng/commonsdk/proguard/bc;->a(Lcom/umeng/commonsdk/proguard/az;B)V

    goto :goto_1

    .line 793
    :pswitch_6
    iget-byte v1, v0, Lcom/umeng/commonsdk/proguard/au;->b:B

    if-ne v1, v3, :cond_7

    .line 794
    invoke-virtual {p1}, Lcom/umeng/commonsdk/proguard/az;->A()Ljava/nio/ByteBuffer;

    move-result-object v0

    iput-object v0, p2, Lcom/umeng/commonsdk/proguard/w;->g:Ljava/nio/ByteBuffer;

    .line 795
    invoke-virtual {p2, v2}, Lcom/umeng/commonsdk/proguard/w;->g(Z)V

    goto/16 :goto_1

    .line 797
    :cond_7
    iget-byte v0, v0, Lcom/umeng/commonsdk/proguard/au;->b:B

    invoke-static {p1, v0}, Lcom/umeng/commonsdk/proguard/bc;->a(Lcom/umeng/commonsdk/proguard/az;B)V

    goto/16 :goto_1

    .line 801
    :pswitch_7
    iget-byte v1, v0, Lcom/umeng/commonsdk/proguard/au;->b:B

    if-ne v1, v3, :cond_8

    .line 802
    invoke-virtual {p1}, Lcom/umeng/commonsdk/proguard/az;->z()Ljava/lang/String;

    move-result-object v0

    iput-object v0, p2, Lcom/umeng/commonsdk/proguard/w;->h:Ljava/lang/String;

    .line 803
    invoke-virtual {p2, v2}, Lcom/umeng/commonsdk/proguard/w;->h(Z)V

    goto/16 :goto_1

    .line 805
    :cond_8
    iget-byte v0, v0, Lcom/umeng/commonsdk/proguard/au;->b:B

    invoke-static {p1, v0}, Lcom/umeng/commonsdk/proguard/bc;->a(Lcom/umeng/commonsdk/proguard/az;B)V

    goto/16 :goto_1

    .line 809
    :pswitch_8
    iget-byte v1, v0, Lcom/umeng/commonsdk/proguard/au;->b:B

    if-ne v1, v3, :cond_9

    .line 810
    invoke-virtual {p1}, Lcom/umeng/commonsdk/proguard/az;->z()Ljava/lang/String;

    move-result-object v0

    iput-object v0, p2, Lcom/umeng/commonsdk/proguard/w;->i:Ljava/lang/String;

    .line 811
    invoke-virtual {p2, v2}, Lcom/umeng/commonsdk/proguard/w;->i(Z)V

    goto/16 :goto_1

    .line 813
    :cond_9
    iget-byte v0, v0, Lcom/umeng/commonsdk/proguard/au;->b:B

    invoke-static {p1, v0}, Lcom/umeng/commonsdk/proguard/bc;->a(Lcom/umeng/commonsdk/proguard/az;B)V

    goto/16 :goto_1

    .line 817
    :pswitch_9
    iget-byte v1, v0, Lcom/umeng/commonsdk/proguard/au;->b:B

    if-ne v1, v4, :cond_a

    .line 818
    invoke-virtual {p1}, Lcom/umeng/commonsdk/proguard/az;->w()I

    move-result v0

    iput v0, p2, Lcom/umeng/commonsdk/proguard/w;->j:I

    .line 819
    invoke-virtual {p2, v2}, Lcom/umeng/commonsdk/proguard/w;->j(Z)V

    goto/16 :goto_1

    .line 821
    :cond_a
    iget-byte v0, v0, Lcom/umeng/commonsdk/proguard/au;->b:B

    invoke-static {p1, v0}, Lcom/umeng/commonsdk/proguard/bc;->a(Lcom/umeng/commonsdk/proguard/az;B)V

    goto/16 :goto_1

    .line 837
    :cond_b
    invoke-virtual {p2}, Lcom/umeng/commonsdk/proguard/w;->p()Z

    move-result v0

    if-nez v0, :cond_c

    .line 838
    new-instance v0, Lcom/umeng/commonsdk/proguard/ba;

    new-instance v1, Ljava/lang/StringBuilder;

    invoke-direct {v1}, Ljava/lang/StringBuilder;-><init>()V

    const-string v2, "Required field \'ts_secs\' was not found in serialized data! Struct: "

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    .line 839
    invoke-virtual {p0}, Ljava/lang/Object;->toString()Ljava/lang/String;

    move-result-object v2

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v1

    invoke-direct {v0, v1}, Lcom/umeng/commonsdk/proguard/ba;-><init>(Ljava/lang/String;)V

    throw v0

    .line 841
    :cond_c
    invoke-virtual {p2}, Lcom/umeng/commonsdk/proguard/w;->s()Z

    move-result v0

    if-nez v0, :cond_d

    .line 842
    new-instance v0, Lcom/umeng/commonsdk/proguard/ba;

    new-instance v1, Ljava/lang/StringBuilder;

    invoke-direct {v1}, Ljava/lang/StringBuilder;-><init>()V

    const-string v2, "Required field \'length\' was not found in serialized data! Struct: "

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    .line 843
    invoke-virtual {p0}, Ljava/lang/Object;->toString()Ljava/lang/String;

    move-result-object v2

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v1

    invoke-direct {v0, v1}, Lcom/umeng/commonsdk/proguard/ba;-><init>(Ljava/lang/String;)V

    throw v0

    .line 845
    :cond_d
    invoke-virtual {p2}, Lcom/umeng/commonsdk/proguard/w;->G()V

    .line 846
    return-void

    .line 743
    :pswitch_data_0
    .packed-switch 0x1
        :pswitch_0
        :pswitch_1
        :pswitch_2
        :pswitch_3
        :pswitch_4
        :pswitch_5
        :pswitch_6
        :pswitch_7
        :pswitch_8
        :pswitch_9
    .end packed-switch
.end method

.method public synthetic b(Lcom/umeng/commonsdk/proguard/az;Lcom/umeng/commonsdk/proguard/aa;)V
    .locals 0
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Lcom/umeng/commonsdk/proguard/ag;
        }
    .end annotation

    .prologue
    .line 732
    check-cast p2, Lcom/umeng/commonsdk/proguard/w;

    invoke-virtual {p0, p1, p2}, Lcom/umeng/commonsdk/proguard/w$a;->a(Lcom/umeng/commonsdk/proguard/az;Lcom/umeng/commonsdk/proguard/w;)V

    return-void
.end method

.method public b(Lcom/umeng/commonsdk/proguard/az;Lcom/umeng/commonsdk/proguard/w;)V
    .locals 1
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Lcom/umeng/commonsdk/proguard/ag;
        }
    .end annotation

    .prologue
    .line 850
    invoke-virtual {p2}, Lcom/umeng/commonsdk/proguard/w;->G()V

    .line 852
    invoke-static {}, Lcom/umeng/commonsdk/proguard/w;->H()Lcom/umeng/commonsdk/proguard/be;

    move-result-object v0

    invoke-virtual {p1, v0}, Lcom/umeng/commonsdk/proguard/az;->a(Lcom/umeng/commonsdk/proguard/be;)V

    .line 853
    iget-object v0, p2, Lcom/umeng/commonsdk/proguard/w;->a:Ljava/lang/String;

    if-eqz v0, :cond_0

    .line 854
    invoke-static {}, Lcom/umeng/commonsdk/proguard/w;->I()Lcom/umeng/commonsdk/proguard/au;

    move-result-object v0

    invoke-virtual {p1, v0}, Lcom/umeng/commonsdk/proguard/az;->a(Lcom/umeng/commonsdk/proguard/au;)V

    .line 855
    iget-object v0, p2, Lcom/umeng/commonsdk/proguard/w;->a:Ljava/lang/String;

    invoke-virtual {p1, v0}, Lcom/umeng/commonsdk/proguard/az;->a(Ljava/lang/String;)V

    .line 856
    invoke-virtual {p1}, Lcom/umeng/commonsdk/proguard/az;->c()V

    .line 858
    :cond_0
    iget-object v0, p2, Lcom/umeng/commonsdk/proguard/w;->b:Ljava/lang/String;

    if-eqz v0, :cond_1

    .line 859
    invoke-static {}, Lcom/umeng/commonsdk/proguard/w;->J()Lcom/umeng/commonsdk/proguard/au;

    move-result-object v0

    invoke-virtual {p1, v0}, Lcom/umeng/commonsdk/proguard/az;->a(Lcom/umeng/commonsdk/proguard/au;)V

    .line 860
    iget-object v0, p2, Lcom/umeng/commonsdk/proguard/w;->b:Ljava/lang/String;

    invoke-virtual {p1, v0}, Lcom/umeng/commonsdk/proguard/az;->a(Ljava/lang/String;)V

    .line 861
    invoke-virtual {p1}, Lcom/umeng/commonsdk/proguard/az;->c()V

    .line 863
    :cond_1
    iget-object v0, p2, Lcom/umeng/commonsdk/proguard/w;->c:Ljava/lang/String;

    if-eqz v0, :cond_2

    .line 864
    invoke-static {}, Lcom/umeng/commonsdk/proguard/w;->K()Lcom/umeng/commonsdk/proguard/au;

    move-result-object v0

    invoke-virtual {p1, v0}, Lcom/umeng/commonsdk/proguard/az;->a(Lcom/umeng/commonsdk/proguard/au;)V

    .line 865
    iget-object v0, p2, Lcom/umeng/commonsdk/proguard/w;->c:Ljava/lang/String;

    invoke-virtual {p1, v0}, Lcom/umeng/commonsdk/proguard/az;->a(Ljava/lang/String;)V

    .line 866
    invoke-virtual {p1}, Lcom/umeng/commonsdk/proguard/az;->c()V

    .line 868
    :cond_2
    invoke-static {}, Lcom/umeng/commonsdk/proguard/w;->L()Lcom/umeng/commonsdk/proguard/au;

    move-result-object v0

    invoke-virtual {p1, v0}, Lcom/umeng/commonsdk/proguard/az;->a(Lcom/umeng/commonsdk/proguard/au;)V

    .line 869
    iget v0, p2, Lcom/umeng/commonsdk/proguard/w;->d:I

    invoke-virtual {p1, v0}, Lcom/umeng/commonsdk/proguard/az;->a(I)V

    .line 870
    invoke-virtual {p1}, Lcom/umeng/commonsdk/proguard/az;->c()V

    .line 871
    invoke-static {}, Lcom/umeng/commonsdk/proguard/w;->M()Lcom/umeng/commonsdk/proguard/au;

    move-result-object v0

    invoke-virtual {p1, v0}, Lcom/umeng/commonsdk/proguard/az;->a(Lcom/umeng/commonsdk/proguard/au;)V

    .line 872
    iget v0, p2, Lcom/umeng/commonsdk/proguard/w;->e:I

    invoke-virtual {p1, v0}, Lcom/umeng/commonsdk/proguard/az;->a(I)V

    .line 873
    invoke-virtual {p1}, Lcom/umeng/commonsdk/proguard/az;->c()V

    .line 874
    invoke-static {}, Lcom/umeng/commonsdk/proguard/w;->N()Lcom/umeng/commonsdk/proguard/au;

    move-result-object v0

    invoke-virtual {p1, v0}, Lcom/umeng/commonsdk/proguard/az;->a(Lcom/umeng/commonsdk/proguard/au;)V

    .line 875
    iget v0, p2, Lcom/umeng/commonsdk/proguard/w;->f:I

    invoke-virtual {p1, v0}, Lcom/umeng/commonsdk/proguard/az;->a(I)V

    .line 876
    invoke-virtual {p1}, Lcom/umeng/commonsdk/proguard/az;->c()V

    .line 877
    iget-object v0, p2, Lcom/umeng/commonsdk/proguard/w;->g:Ljava/nio/ByteBuffer;

    if-eqz v0, :cond_3

    .line 878
    invoke-static {}, Lcom/umeng/commonsdk/proguard/w;->O()Lcom/umeng/commonsdk/proguard/au;

    move-result-object v0

    invoke-virtual {p1, v0}, Lcom/umeng/commonsdk/proguard/az;->a(Lcom/umeng/commonsdk/proguard/au;)V

    .line 879
    iget-object v0, p2, Lcom/umeng/commonsdk/proguard/w;->g:Ljava/nio/ByteBuffer;

    invoke-virtual {p1, v0}, Lcom/umeng/commonsdk/proguard/az;->a(Ljava/nio/ByteBuffer;)V

    .line 880
    invoke-virtual {p1}, Lcom/umeng/commonsdk/proguard/az;->c()V

    .line 882
    :cond_3
    iget-object v0, p2, Lcom/umeng/commonsdk/proguard/w;->h:Ljava/lang/String;

    if-eqz v0, :cond_4

    .line 883
    invoke-static {}, Lcom/umeng/commonsdk/proguard/w;->P()Lcom/umeng/commonsdk/proguard/au;

    move-result-object v0

    invoke-virtual {p1, v0}, Lcom/umeng/commonsdk/proguard/az;->a(Lcom/umeng/commonsdk/proguard/au;)V

    .line 884
    iget-object v0, p2, Lcom/umeng/commonsdk/proguard/w;->h:Ljava/lang/String;

    invoke-virtual {p1, v0}, Lcom/umeng/commonsdk/proguard/az;->a(Ljava/lang/String;)V

    .line 885
    invoke-virtual {p1}, Lcom/umeng/commonsdk/proguard/az;->c()V

    .line 887
    :cond_4
    iget-object v0, p2, Lcom/umeng/commonsdk/proguard/w;->i:Ljava/lang/String;

    if-eqz v0, :cond_5

    .line 888
    invoke-static {}, Lcom/umeng/commonsdk/proguard/w;->Q()Lcom/umeng/commonsdk/proguard/au;

    move-result-object v0

    invoke-virtual {p1, v0}, Lcom/umeng/commonsdk/proguard/az;->a(Lcom/umeng/commonsdk/proguard/au;)V

    .line 889
    iget-object v0, p2, Lcom/umeng/commonsdk/proguard/w;->i:Ljava/lang/String;

    invoke-virtual {p1, v0}, Lcom/umeng/commonsdk/proguard/az;->a(Ljava/lang/String;)V

    .line 890
    invoke-virtual {p1}, Lcom/umeng/commonsdk/proguard/az;->c()V

    .line 892
    :cond_5
    invoke-virtual {p2}, Lcom/umeng/commonsdk/proguard/w;->F()Z

    move-result v0

    if-eqz v0, :cond_6

    .line 893
    invoke-static {}, Lcom/umeng/commonsdk/proguard/w;->R()Lcom/umeng/commonsdk/proguard/au;

    move-result-object v0

    invoke-virtual {p1, v0}, Lcom/umeng/commonsdk/proguard/az;->a(Lcom/umeng/commonsdk/proguard/au;)V

    .line 894
    iget v0, p2, Lcom/umeng/commonsdk/proguard/w;->j:I

    invoke-virtual {p1, v0}, Lcom/umeng/commonsdk/proguard/az;->a(I)V

    .line 895
    invoke-virtual {p1}, Lcom/umeng/commonsdk/proguard/az;->c()V

    .line 897
    :cond_6
    invoke-virtual {p1}, Lcom/umeng/commonsdk/proguard/az;->d()V

    .line 898
    invoke-virtual {p1}, Lcom/umeng/commonsdk/proguard/az;->b()V

    .line 899
    return-void
.end method
