.class Ljavax/mail/internet/MailDateParser;
.super Ljava/lang/Object;
.source "SourceFile"


# instance fields
.field index:I

.field orig:[C


# direct methods
.method public constructor <init>([C)V
    .locals 1

    .prologue
    .line 461
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    .line 458
    const/4 v0, 0x0

    iput v0, p0, Ljavax/mail/internet/MailDateParser;->index:I

    .line 459
    const/4 v0, 0x0

    iput-object v0, p0, Ljavax/mail/internet/MailDateParser;->orig:[C

    .line 462
    iput-object p1, p0, Ljavax/mail/internet/MailDateParser;->orig:[C

    .line 463
    return-void
.end method


# virtual methods
.method getIndex()I
    .locals 1

    .prologue
    .line 900
    iget v0, p0, Ljavax/mail/internet/MailDateParser;->index:I

    return v0
.end method

.method public parseAlphaTimeZone()I
    .locals 7
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljava/text/ParseException;
        }
    .end annotation

    .prologue
    const/4 v0, 0x0

    const/16 v6, 0x74

    const/16 v5, 0x54

    const/4 v1, 0x1

    .line 820
    .line 825
    :try_start_0
    iget-object v2, p0, Ljavax/mail/internet/MailDateParser;->orig:[C

    iget v3, p0, Ljavax/mail/internet/MailDateParser;->index:I

    add-int/lit8 v4, v3, 0x1

    iput v4, p0, Ljavax/mail/internet/MailDateParser;->index:I

    aget-char v2, v2, v3

    sparse-switch v2, :sswitch_data_0

    .line 872
    new-instance v0, Ljava/text/ParseException;

    const-string v1, "Bad Alpha TimeZone"

    iget v2, p0, Ljavax/mail/internet/MailDateParser;->index:I

    invoke-direct {v0, v1, v2}, Ljava/text/ParseException;-><init>(Ljava/lang/String;I)V

    throw v0
    :try_end_0
    .catch Ljava/lang/ArrayIndexOutOfBoundsException; {:try_start_0 .. :try_end_0} :catch_0

    .line 874
    :catch_0
    move-exception v0

    .line 875
    new-instance v0, Ljava/text/ParseException;

    const-string v1, "Bad Alpha TimeZone"

    iget v2, p0, Ljavax/mail/internet/MailDateParser;->index:I

    invoke-direct {v0, v1, v2}, Ljava/text/ParseException;-><init>(Ljava/lang/String;I)V

    throw v0

    .line 828
    :sswitch_0
    :try_start_1
    iget-object v1, p0, Ljavax/mail/internet/MailDateParser;->orig:[C

    iget v2, p0, Ljavax/mail/internet/MailDateParser;->index:I

    add-int/lit8 v3, v2, 0x1

    iput v3, p0, Ljavax/mail/internet/MailDateParser;->index:I

    aget-char v1, v1, v2
    :try_end_1
    .catch Ljava/lang/ArrayIndexOutOfBoundsException; {:try_start_1 .. :try_end_1} :catch_0

    .line 829
    if-eq v1, v5, :cond_0

    if-ne v1, v6, :cond_2

    :cond_0
    move v1, v0

    .line 878
    :goto_0
    if-eqz v1, :cond_9

    .line 879
    iget-object v1, p0, Ljavax/mail/internet/MailDateParser;->orig:[C

    iget v2, p0, Ljavax/mail/internet/MailDateParser;->index:I

    add-int/lit8 v3, v2, 0x1

    iput v3, p0, Ljavax/mail/internet/MailDateParser;->index:I

    aget-char v1, v1, v2

    .line 880
    const/16 v2, 0x53

    if-eq v1, v2, :cond_1

    const/16 v2, 0x73

    if-ne v1, v2, :cond_6

    .line 881
    :cond_1
    iget-object v1, p0, Ljavax/mail/internet/MailDateParser;->orig:[C

    iget v2, p0, Ljavax/mail/internet/MailDateParser;->index:I

    add-int/lit8 v3, v2, 0x1

    iput v3, p0, Ljavax/mail/internet/MailDateParser;->index:I

    aget-char v1, v1, v2

    .line 882
    if-eq v1, v5, :cond_9

    if-eq v1, v6, :cond_9

    .line 883
    new-instance v0, Ljava/text/ParseException;

    const-string v1, "Bad Alpha TimeZone"

    iget v2, p0, Ljavax/mail/internet/MailDateParser;->index:I

    invoke-direct {v0, v1, v2}, Ljava/text/ParseException;-><init>(Ljava/lang/String;I)V

    throw v0

    .line 833
    :cond_2
    :try_start_2
    new-instance v0, Ljava/text/ParseException;

    const-string v1, "Bad Alpha TimeZone"

    iget v2, p0, Ljavax/mail/internet/MailDateParser;->index:I

    invoke-direct {v0, v1, v2}, Ljava/text/ParseException;-><init>(Ljava/lang/String;I)V

    throw v0

    .line 837
    :sswitch_1
    iget-object v1, p0, Ljavax/mail/internet/MailDateParser;->orig:[C

    iget v2, p0, Ljavax/mail/internet/MailDateParser;->index:I

    add-int/lit8 v3, v2, 0x1

    iput v3, p0, Ljavax/mail/internet/MailDateParser;->index:I

    aget-char v1, v1, v2

    .line 838
    const/16 v2, 0x4d

    if-eq v1, v2, :cond_3

    const/16 v2, 0x6d

    if-ne v1, v2, :cond_5

    .line 839
    :cond_3
    iget-object v1, p0, Ljavax/mail/internet/MailDateParser;->orig:[C

    iget v2, p0, Ljavax/mail/internet/MailDateParser;->index:I

    add-int/lit8 v3, v2, 0x1

    iput v3, p0, Ljavax/mail/internet/MailDateParser;->index:I

    aget-char v1, v1, v2

    .line 840
    if-eq v1, v5, :cond_4

    if-ne v1, v6, :cond_5

    :cond_4
    move v1, v0

    .line 842
    goto :goto_0

    .line 845
    :cond_5
    new-instance v0, Ljava/text/ParseException;

    const-string v1, "Bad Alpha TimeZone"

    iget v2, p0, Ljavax/mail/internet/MailDateParser;->index:I

    invoke-direct {v0, v1, v2}, Ljava/text/ParseException;-><init>(Ljava/lang/String;I)V

    throw v0
    :try_end_2
    .catch Ljava/lang/ArrayIndexOutOfBoundsException; {:try_start_2 .. :try_end_2} :catch_0

    .line 849
    :sswitch_2
    const/16 v0, 0x12c

    .line 851
    goto :goto_0

    .line 855
    :sswitch_3
    const/16 v0, 0x168

    .line 857
    goto :goto_0

    .line 861
    :sswitch_4
    const/16 v0, 0x1a4

    .line 863
    goto :goto_0

    .line 867
    :sswitch_5
    const/16 v0, 0x1e0

    .line 869
    goto :goto_0

    .line 885
    :cond_6
    const/16 v2, 0x44

    if-eq v1, v2, :cond_7

    const/16 v2, 0x64

    if-ne v1, v2, :cond_9

    .line 886
    :cond_7
    iget-object v1, p0, Ljavax/mail/internet/MailDateParser;->orig:[C

    iget v2, p0, Ljavax/mail/internet/MailDateParser;->index:I

    add-int/lit8 v3, v2, 0x1

    iput v3, p0, Ljavax/mail/internet/MailDateParser;->index:I

    aget-char v1, v1, v2

    .line 887
    if-eq v1, v5, :cond_8

    if-eq v1, v6, :cond_a

    .line 889
    :cond_8
    add-int/lit8 v0, v0, -0x3c

    .line 896
    :cond_9
    return v0

    .line 891
    :cond_a
    new-instance v0, Ljava/text/ParseException;

    const-string v1, "Bad Alpha TimeZone"

    iget v2, p0, Ljavax/mail/internet/MailDateParser;->index:I

    invoke-direct {v0, v1, v2}, Ljava/text/ParseException;-><init>(Ljava/lang/String;I)V

    throw v0

    .line 825
    :sswitch_data_0
    .sparse-switch
        0x43 -> :sswitch_3
        0x45 -> :sswitch_2
        0x47 -> :sswitch_1
        0x4d -> :sswitch_4
        0x50 -> :sswitch_5
        0x55 -> :sswitch_0
        0x63 -> :sswitch_3
        0x65 -> :sswitch_2
        0x67 -> :sswitch_1
        0x6d -> :sswitch_4
        0x70 -> :sswitch_5
        0x75 -> :sswitch_0
    .end sparse-switch
.end method

.method public parseMonth()I
    .locals 8
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljava/text/ParseException;
        }
    .end annotation

    .prologue
    const/16 v7, 0x50

    const/16 v6, 0x4e

    const/16 v5, 0x43

    const/16 v4, 0x65

    const/16 v3, 0x45

    .line 653
    :try_start_0
    iget-object v0, p0, Ljavax/mail/internet/MailDateParser;->orig:[C

    iget v1, p0, Ljavax/mail/internet/MailDateParser;->index:I

    add-int/lit8 v2, v1, 0x1

    iput v2, p0, Ljavax/mail/internet/MailDateParser;->index:I

    aget-char v0, v0, v1
    :try_end_0
    .catch Ljava/lang/ArrayIndexOutOfBoundsException; {:try_start_0 .. :try_end_0} :catch_0

    sparse-switch v0, :sswitch_data_0

    .line 765
    :cond_0
    :goto_0
    new-instance v0, Ljava/text/ParseException;

    const-string v1, "Bad Month"

    iget v2, p0, Ljavax/mail/internet/MailDateParser;->index:I

    invoke-direct {v0, v1, v2}, Ljava/text/ParseException;-><init>(Ljava/lang/String;I)V

    throw v0

    .line 657
    :sswitch_0
    :try_start_1
    iget-object v0, p0, Ljavax/mail/internet/MailDateParser;->orig:[C

    iget v1, p0, Ljavax/mail/internet/MailDateParser;->index:I

    add-int/lit8 v2, v1, 0x1

    iput v2, p0, Ljavax/mail/internet/MailDateParser;->index:I

    aget-char v0, v0, v1

    sparse-switch v0, :sswitch_data_1

    goto :goto_0

    .line 660
    :sswitch_1
    iget-object v0, p0, Ljavax/mail/internet/MailDateParser;->orig:[C

    iget v1, p0, Ljavax/mail/internet/MailDateParser;->index:I

    add-int/lit8 v2, v1, 0x1

    iput v2, p0, Ljavax/mail/internet/MailDateParser;->index:I

    aget-char v0, v0, v1

    .line 661
    if-eq v0, v6, :cond_1

    const/16 v1, 0x6e

    if-ne v0, v1, :cond_0

    .line 662
    :cond_1
    const/4 v0, 0x0

    .line 757
    :goto_1
    return v0

    .line 668
    :sswitch_2
    iget-object v0, p0, Ljavax/mail/internet/MailDateParser;->orig:[C

    iget v1, p0, Ljavax/mail/internet/MailDateParser;->index:I

    add-int/lit8 v2, v1, 0x1

    iput v2, p0, Ljavax/mail/internet/MailDateParser;->index:I

    aget-char v0, v0, v1

    .line 669
    if-eq v0, v6, :cond_2

    const/16 v1, 0x6e

    if-ne v0, v1, :cond_3

    .line 670
    :cond_2
    const/4 v0, 0x5

    goto :goto_1

    .line 671
    :cond_3
    const/16 v1, 0x4c

    if-eq v0, v1, :cond_4

    const/16 v1, 0x6c

    if-ne v0, v1, :cond_0

    .line 672
    :cond_4
    const/4 v0, 0x6

    goto :goto_1

    .line 680
    :sswitch_3
    iget-object v0, p0, Ljavax/mail/internet/MailDateParser;->orig:[C

    iget v1, p0, Ljavax/mail/internet/MailDateParser;->index:I

    add-int/lit8 v2, v1, 0x1

    iput v2, p0, Ljavax/mail/internet/MailDateParser;->index:I

    aget-char v0, v0, v1

    .line 681
    if-eq v0, v3, :cond_5

    if-ne v0, v4, :cond_0

    .line 682
    :cond_5
    iget-object v0, p0, Ljavax/mail/internet/MailDateParser;->orig:[C

    iget v1, p0, Ljavax/mail/internet/MailDateParser;->index:I

    add-int/lit8 v2, v1, 0x1

    iput v2, p0, Ljavax/mail/internet/MailDateParser;->index:I

    aget-char v0, v0, v1

    .line 683
    const/16 v1, 0x42

    if-eq v0, v1, :cond_6

    const/16 v1, 0x62

    if-ne v0, v1, :cond_0

    .line 684
    :cond_6
    const/4 v0, 0x1

    goto :goto_1

    .line 691
    :sswitch_4
    iget-object v0, p0, Ljavax/mail/internet/MailDateParser;->orig:[C

    iget v1, p0, Ljavax/mail/internet/MailDateParser;->index:I

    add-int/lit8 v2, v1, 0x1

    iput v2, p0, Ljavax/mail/internet/MailDateParser;->index:I

    aget-char v0, v0, v1

    .line 692
    const/16 v1, 0x41

    if-eq v0, v1, :cond_7

    const/16 v1, 0x61

    if-ne v0, v1, :cond_0

    .line 693
    :cond_7
    iget-object v0, p0, Ljavax/mail/internet/MailDateParser;->orig:[C

    iget v1, p0, Ljavax/mail/internet/MailDateParser;->index:I

    add-int/lit8 v2, v1, 0x1

    iput v2, p0, Ljavax/mail/internet/MailDateParser;->index:I

    aget-char v0, v0, v1

    .line 694
    const/16 v1, 0x52

    if-eq v0, v1, :cond_8

    const/16 v1, 0x72

    if-ne v0, v1, :cond_9

    .line 695
    :cond_8
    const/4 v0, 0x2

    goto :goto_1

    .line 696
    :cond_9
    const/16 v1, 0x59

    if-eq v0, v1, :cond_a

    const/16 v1, 0x79

    if-ne v0, v1, :cond_0

    .line 697
    :cond_a
    const/4 v0, 0x4

    goto :goto_1

    .line 704
    :sswitch_5
    iget-object v0, p0, Ljavax/mail/internet/MailDateParser;->orig:[C

    iget v1, p0, Ljavax/mail/internet/MailDateParser;->index:I

    add-int/lit8 v2, v1, 0x1

    iput v2, p0, Ljavax/mail/internet/MailDateParser;->index:I

    aget-char v0, v0, v1

    .line 705
    if-eq v0, v7, :cond_b

    const/16 v1, 0x70

    if-ne v0, v1, :cond_d

    .line 706
    :cond_b
    iget-object v0, p0, Ljavax/mail/internet/MailDateParser;->orig:[C

    iget v1, p0, Ljavax/mail/internet/MailDateParser;->index:I

    add-int/lit8 v2, v1, 0x1

    iput v2, p0, Ljavax/mail/internet/MailDateParser;->index:I

    aget-char v0, v0, v1

    .line 707
    const/16 v1, 0x52

    if-eq v0, v1, :cond_c

    const/16 v1, 0x72

    if-ne v0, v1, :cond_0

    .line 708
    :cond_c
    const/4 v0, 0x3

    goto/16 :goto_1

    .line 710
    :cond_d
    const/16 v1, 0x55

    if-eq v0, v1, :cond_e

    const/16 v1, 0x75

    if-ne v0, v1, :cond_0

    .line 711
    :cond_e
    iget-object v0, p0, Ljavax/mail/internet/MailDateParser;->orig:[C

    iget v1, p0, Ljavax/mail/internet/MailDateParser;->index:I

    add-int/lit8 v2, v1, 0x1

    iput v2, p0, Ljavax/mail/internet/MailDateParser;->index:I

    aget-char v0, v0, v1

    .line 712
    const/16 v1, 0x47

    if-eq v0, v1, :cond_f

    const/16 v1, 0x67

    if-ne v0, v1, :cond_0

    .line 713
    :cond_f
    const/4 v0, 0x7

    goto/16 :goto_1

    .line 720
    :sswitch_6
    iget-object v0, p0, Ljavax/mail/internet/MailDateParser;->orig:[C

    iget v1, p0, Ljavax/mail/internet/MailDateParser;->index:I

    add-int/lit8 v2, v1, 0x1

    iput v2, p0, Ljavax/mail/internet/MailDateParser;->index:I

    aget-char v0, v0, v1

    .line 721
    if-eq v0, v3, :cond_10

    if-ne v0, v4, :cond_0

    .line 722
    :cond_10
    iget-object v0, p0, Ljavax/mail/internet/MailDateParser;->orig:[C

    iget v1, p0, Ljavax/mail/internet/MailDateParser;->index:I

    add-int/lit8 v2, v1, 0x1

    iput v2, p0, Ljavax/mail/internet/MailDateParser;->index:I

    aget-char v0, v0, v1

    .line 723
    if-eq v0, v7, :cond_11

    const/16 v1, 0x70

    if-ne v0, v1, :cond_0

    .line 724
    :cond_11
    const/16 v0, 0x8

    goto/16 :goto_1

    .line 731
    :sswitch_7
    iget-object v0, p0, Ljavax/mail/internet/MailDateParser;->orig:[C

    iget v1, p0, Ljavax/mail/internet/MailDateParser;->index:I

    add-int/lit8 v2, v1, 0x1

    iput v2, p0, Ljavax/mail/internet/MailDateParser;->index:I

    aget-char v0, v0, v1

    .line 732
    if-eq v0, v5, :cond_12

    const/16 v1, 0x63

    if-ne v0, v1, :cond_0

    .line 733
    :cond_12
    iget-object v0, p0, Ljavax/mail/internet/MailDateParser;->orig:[C

    iget v1, p0, Ljavax/mail/internet/MailDateParser;->index:I

    add-int/lit8 v2, v1, 0x1

    iput v2, p0, Ljavax/mail/internet/MailDateParser;->index:I

    aget-char v0, v0, v1

    .line 734
    const/16 v1, 0x54

    if-eq v0, v1, :cond_13

    const/16 v1, 0x74

    if-ne v0, v1, :cond_0

    .line 735
    :cond_13
    const/16 v0, 0x9

    goto/16 :goto_1

    .line 742
    :sswitch_8
    iget-object v0, p0, Ljavax/mail/internet/MailDateParser;->orig:[C

    iget v1, p0, Ljavax/mail/internet/MailDateParser;->index:I

    add-int/lit8 v2, v1, 0x1

    iput v2, p0, Ljavax/mail/internet/MailDateParser;->index:I

    aget-char v0, v0, v1

    .line 743
    const/16 v1, 0x4f

    if-eq v0, v1, :cond_14

    const/16 v1, 0x6f

    if-ne v0, v1, :cond_0

    .line 744
    :cond_14
    iget-object v0, p0, Ljavax/mail/internet/MailDateParser;->orig:[C

    iget v1, p0, Ljavax/mail/internet/MailDateParser;->index:I

    add-int/lit8 v2, v1, 0x1

    iput v2, p0, Ljavax/mail/internet/MailDateParser;->index:I

    aget-char v0, v0, v1

    .line 745
    const/16 v1, 0x56

    if-eq v0, v1, :cond_15

    const/16 v1, 0x76

    if-ne v0, v1, :cond_0

    .line 746
    :cond_15
    const/16 v0, 0xa

    goto/16 :goto_1

    .line 753
    :sswitch_9
    iget-object v0, p0, Ljavax/mail/internet/MailDateParser;->orig:[C

    iget v1, p0, Ljavax/mail/internet/MailDateParser;->index:I

    add-int/lit8 v2, v1, 0x1

    iput v2, p0, Ljavax/mail/internet/MailDateParser;->index:I

    aget-char v0, v0, v1

    .line 754
    if-eq v0, v3, :cond_16

    if-ne v0, v4, :cond_0

    .line 755
    :cond_16
    iget-object v0, p0, Ljavax/mail/internet/MailDateParser;->orig:[C

    iget v1, p0, Ljavax/mail/internet/MailDateParser;->index:I

    add-int/lit8 v2, v1, 0x1

    iput v2, p0, Ljavax/mail/internet/MailDateParser;->index:I

    aget-char v0, v0, v1
    :try_end_1
    .catch Ljava/lang/ArrayIndexOutOfBoundsException; {:try_start_1 .. :try_end_1} :catch_0

    .line 756
    if-eq v0, v5, :cond_17

    const/16 v1, 0x63

    if-ne v0, v1, :cond_0

    .line 757
    :cond_17
    const/16 v0, 0xb

    goto/16 :goto_1

    .line 762
    :catch_0
    move-exception v0

    goto/16 :goto_0

    .line 653
    :sswitch_data_0
    .sparse-switch
        0x41 -> :sswitch_5
        0x44 -> :sswitch_9
        0x46 -> :sswitch_3
        0x4a -> :sswitch_0
        0x4d -> :sswitch_4
        0x4e -> :sswitch_8
        0x4f -> :sswitch_7
        0x53 -> :sswitch_6
        0x61 -> :sswitch_5
        0x64 -> :sswitch_9
        0x66 -> :sswitch_3
        0x6a -> :sswitch_0
        0x6d -> :sswitch_4
        0x6e -> :sswitch_8
        0x6f -> :sswitch_7
        0x73 -> :sswitch_6
    .end sparse-switch

    .line 657
    :sswitch_data_1
    .sparse-switch
        0x41 -> :sswitch_1
        0x55 -> :sswitch_2
        0x61 -> :sswitch_1
        0x75 -> :sswitch_2
    .end sparse-switch
.end method

.method public parseNumber()I
    .locals 6
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljava/text/ParseException;
        }
    .end annotation

    .prologue
    const/4 v0, 0x0

    const/4 v2, 0x1

    .line 569
    iget-object v1, p0, Ljavax/mail/internet/MailDateParser;->orig:[C

    array-length v3, v1

    move v1, v0

    .line 573
    :goto_0
    iget v4, p0, Ljavax/mail/internet/MailDateParser;->index:I

    if-lt v4, v3, :cond_1

    .line 636
    if-eqz v1, :cond_2

    .line 637
    :cond_0
    return v0

    .line 574
    :cond_1
    iget-object v4, p0, Ljavax/mail/internet/MailDateParser;->orig:[C

    iget v5, p0, Ljavax/mail/internet/MailDateParser;->index:I

    aget-char v4, v4, v5

    packed-switch v4, :pswitch_data_0

    .line 626
    if-nez v1, :cond_0

    .line 629
    new-instance v0, Ljava/text/ParseException;

    const-string v1, "No Number found"

    iget v2, p0, Ljavax/mail/internet/MailDateParser;->index:I

    invoke-direct {v0, v1, v2}, Ljava/text/ParseException;-><init>(Ljava/lang/String;I)V

    throw v0

    .line 576
    :pswitch_0
    mul-int/lit8 v0, v0, 0xa

    .line 632
    :goto_1
    iget v1, p0, Ljavax/mail/internet/MailDateParser;->index:I

    add-int/lit8 v1, v1, 0x1

    iput v1, p0, Ljavax/mail/internet/MailDateParser;->index:I

    move v1, v2

    goto :goto_0

    .line 581
    :pswitch_1
    mul-int/lit8 v0, v0, 0xa

    add-int/lit8 v0, v0, 0x1

    .line 583
    goto :goto_1

    .line 586
    :pswitch_2
    mul-int/lit8 v0, v0, 0xa

    add-int/lit8 v0, v0, 0x2

    .line 588
    goto :goto_1

    .line 591
    :pswitch_3
    mul-int/lit8 v0, v0, 0xa

    add-int/lit8 v0, v0, 0x3

    .line 593
    goto :goto_1

    .line 596
    :pswitch_4
    mul-int/lit8 v0, v0, 0xa

    add-int/lit8 v0, v0, 0x4

    .line 598
    goto :goto_1

    .line 601
    :pswitch_5
    mul-int/lit8 v0, v0, 0xa

    add-int/lit8 v0, v0, 0x5

    .line 603
    goto :goto_1

    .line 606
    :pswitch_6
    mul-int/lit8 v0, v0, 0xa

    add-int/lit8 v0, v0, 0x6

    .line 608
    goto :goto_1

    .line 611
    :pswitch_7
    mul-int/lit8 v0, v0, 0xa

    add-int/lit8 v0, v0, 0x7

    .line 613
    goto :goto_1

    .line 616
    :pswitch_8
    mul-int/lit8 v0, v0, 0xa

    add-int/lit8 v0, v0, 0x8

    .line 618
    goto :goto_1

    .line 621
    :pswitch_9
    mul-int/lit8 v0, v0, 0xa

    add-int/lit8 v0, v0, 0x9

    .line 623
    goto :goto_1

    .line 640
    :cond_2
    new-instance v0, Ljava/text/ParseException;

    const-string v1, "No Number found"

    iget v2, p0, Ljavax/mail/internet/MailDateParser;->index:I

    invoke-direct {v0, v1, v2}, Ljava/text/ParseException;-><init>(Ljava/lang/String;I)V

    throw v0

    .line 574
    nop

    :pswitch_data_0
    .packed-switch 0x30
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

.method public parseNumericTimeZone()I
    .locals 4
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljava/text/ParseException;
        }
    .end annotation

    .prologue
    .line 797
    const/4 v0, 0x0

    .line 798
    iget-object v1, p0, Ljavax/mail/internet/MailDateParser;->orig:[C

    iget v2, p0, Ljavax/mail/internet/MailDateParser;->index:I

    add-int/lit8 v3, v2, 0x1

    iput v3, p0, Ljavax/mail/internet/MailDateParser;->index:I

    aget-char v1, v1, v2

    .line 799
    const/16 v2, 0x2b

    if-ne v1, v2, :cond_1

    .line 800
    const/4 v0, 0x1

    .line 805
    :cond_0
    invoke-virtual {p0}, Ljavax/mail/internet/MailDateParser;->parseNumber()I

    move-result v1

    .line 806
    div-int/lit8 v2, v1, 0x64

    mul-int/lit8 v2, v2, 0x3c

    rem-int/lit8 v1, v1, 0x64

    add-int/2addr v1, v2

    .line 807
    if-eqz v0, :cond_2

    .line 808
    neg-int v0, v1

    .line 810
    :goto_0
    return v0

    .line 801
    :cond_1
    const/16 v2, 0x2d

    if-eq v1, v2, :cond_0

    .line 802
    new-instance v0, Ljava/text/ParseException;

    const-string v1, "Bad Numeric TimeZone"

    iget v2, p0, Ljavax/mail/internet/MailDateParser;->index:I

    invoke-direct {v0, v1, v2}, Ljava/text/ParseException;-><init>(Ljava/lang/String;I)V

    throw v0

    :cond_2
    move v0, v1

    .line 810
    goto :goto_0
.end method

.method public parseTimeZone()I
    .locals 3
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljava/text/ParseException;
        }
    .end annotation

    .prologue
    .line 774
    iget v0, p0, Ljavax/mail/internet/MailDateParser;->index:I

    iget-object v1, p0, Ljavax/mail/internet/MailDateParser;->orig:[C

    array-length v1, v1

    if-lt v0, v1, :cond_0

    .line 775
    new-instance v0, Ljava/text/ParseException;

    const-string v1, "No more characters"

    iget v2, p0, Ljavax/mail/internet/MailDateParser;->index:I

    invoke-direct {v0, v1, v2}, Ljava/text/ParseException;-><init>(Ljava/lang/String;I)V

    throw v0

    .line 777
    :cond_0
    iget-object v0, p0, Ljavax/mail/internet/MailDateParser;->orig:[C

    iget v1, p0, Ljavax/mail/internet/MailDateParser;->index:I

    aget-char v0, v0, v1

    .line 778
    const/16 v1, 0x2b

    if-eq v0, v1, :cond_1

    const/16 v1, 0x2d

    if-ne v0, v1, :cond_2

    .line 779
    :cond_1
    invoke-virtual {p0}, Ljavax/mail/internet/MailDateParser;->parseNumericTimeZone()I

    move-result v0

    .line 781
    :goto_0
    return v0

    :cond_2
    invoke-virtual {p0}, Ljavax/mail/internet/MailDateParser;->parseAlphaTimeZone()I

    move-result v0

    goto :goto_0
.end method

.method public peekChar()I
    .locals 3
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljava/text/ParseException;
        }
    .end annotation

    .prologue
    .line 523
    iget v0, p0, Ljavax/mail/internet/MailDateParser;->index:I

    iget-object v1, p0, Ljavax/mail/internet/MailDateParser;->orig:[C

    array-length v1, v1

    if-ge v0, v1, :cond_0

    .line 524
    iget-object v0, p0, Ljavax/mail/internet/MailDateParser;->orig:[C

    iget v1, p0, Ljavax/mail/internet/MailDateParser;->index:I

    aget-char v0, v0, v1

    return v0

    .line 526
    :cond_0
    new-instance v0, Ljava/text/ParseException;

    const-string v1, "No more characters"

    iget v2, p0, Ljavax/mail/internet/MailDateParser;->index:I

    invoke-direct {v0, v1, v2}, Ljava/text/ParseException;-><init>(Ljava/lang/String;I)V

    throw v0
.end method

.method public skipChar(C)V
    .locals 3
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljava/text/ParseException;
        }
    .end annotation

    .prologue
    .line 534
    iget v0, p0, Ljavax/mail/internet/MailDateParser;->index:I

    iget-object v1, p0, Ljavax/mail/internet/MailDateParser;->orig:[C

    array-length v1, v1

    if-ge v0, v1, :cond_1

    .line 535
    iget-object v0, p0, Ljavax/mail/internet/MailDateParser;->orig:[C

    iget v1, p0, Ljavax/mail/internet/MailDateParser;->index:I

    aget-char v0, v0, v1

    if-ne v0, p1, :cond_0

    .line 536
    iget v0, p0, Ljavax/mail/internet/MailDateParser;->index:I

    add-int/lit8 v0, v0, 0x1

    iput v0, p0, Ljavax/mail/internet/MailDateParser;->index:I

    .line 543
    return-void

    .line 538
    :cond_0
    new-instance v0, Ljava/text/ParseException;

    const-string v1, "Wrong char"

    iget v2, p0, Ljavax/mail/internet/MailDateParser;->index:I

    invoke-direct {v0, v1, v2}, Ljava/text/ParseException;-><init>(Ljava/lang/String;I)V

    throw v0

    .line 541
    :cond_1
    new-instance v0, Ljava/text/ParseException;

    const-string v1, "No more characters"

    iget v2, p0, Ljavax/mail/internet/MailDateParser;->index:I

    invoke-direct {v0, v1, v2}, Ljava/text/ParseException;-><init>(Ljava/lang/String;I)V

    throw v0
.end method

.method public skipIfChar(C)Z
    .locals 3
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljava/text/ParseException;
        }
    .end annotation

    .prologue
    .line 550
    iget v0, p0, Ljavax/mail/internet/MailDateParser;->index:I

    iget-object v1, p0, Ljavax/mail/internet/MailDateParser;->orig:[C

    array-length v1, v1

    if-ge v0, v1, :cond_1

    .line 551
    iget-object v0, p0, Ljavax/mail/internet/MailDateParser;->orig:[C

    iget v1, p0, Ljavax/mail/internet/MailDateParser;->index:I

    aget-char v0, v0, v1

    if-ne v0, p1, :cond_0

    .line 552
    iget v0, p0, Ljavax/mail/internet/MailDateParser;->index:I

    add-int/lit8 v0, v0, 0x1

    iput v0, p0, Ljavax/mail/internet/MailDateParser;->index:I

    .line 553
    const/4 v0, 0x1

    .line 555
    :goto_0
    return v0

    :cond_0
    const/4 v0, 0x0

    goto :goto_0

    .line 558
    :cond_1
    new-instance v0, Ljava/text/ParseException;

    const-string v1, "No more characters"

    iget v2, p0, Ljavax/mail/internet/MailDateParser;->index:I

    invoke-direct {v0, v1, v2}, Ljava/text/ParseException;-><init>(Ljava/lang/String;I)V

    throw v0
.end method

.method public skipUntilNumber()V
    .locals 3
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljava/text/ParseException;
        }
    .end annotation

    .prologue
    .line 474
    :goto_0
    :try_start_0
    iget-object v0, p0, Ljavax/mail/internet/MailDateParser;->orig:[C

    iget v1, p0, Ljavax/mail/internet/MailDateParser;->index:I

    aget-char v0, v0, v1

    packed-switch v0, :pswitch_data_0

    .line 488
    iget v0, p0, Ljavax/mail/internet/MailDateParser;->index:I

    add-int/lit8 v0, v0, 0x1

    iput v0, p0, Ljavax/mail/internet/MailDateParser;->index:I
    :try_end_0
    .catch Ljava/lang/ArrayIndexOutOfBoundsException; {:try_start_0 .. :try_end_0} :catch_0

    goto :goto_0

    .line 492
    :catch_0
    move-exception v0

    .line 493
    new-instance v0, Ljava/text/ParseException;

    const-string v1, "No Number Found"

    iget v2, p0, Ljavax/mail/internet/MailDateParser;->index:I

    invoke-direct {v0, v1, v2}, Ljava/text/ParseException;-><init>(Ljava/lang/String;I)V

    throw v0

    .line 485
    :pswitch_0
    return-void

    .line 474
    :pswitch_data_0
    .packed-switch 0x30
        :pswitch_0
        :pswitch_0
        :pswitch_0
        :pswitch_0
        :pswitch_0
        :pswitch_0
        :pswitch_0
        :pswitch_0
        :pswitch_0
        :pswitch_0
    .end packed-switch
.end method

.method public skipWhiteSpace()V
    .locals 3

    .prologue
    .line 501
    iget-object v0, p0, Ljavax/mail/internet/MailDateParser;->orig:[C

    array-length v0, v0

    .line 502
    :goto_0
    iget v1, p0, Ljavax/mail/internet/MailDateParser;->index:I

    if-lt v1, v0, :cond_0

    .line 515
    :goto_1
    return-void

    .line 503
    :cond_0
    iget-object v1, p0, Ljavax/mail/internet/MailDateParser;->orig:[C

    iget v2, p0, Ljavax/mail/internet/MailDateParser;->index:I

    aget-char v1, v1, v2

    sparse-switch v1, :sswitch_data_0

    goto :goto_1

    .line 508
    :sswitch_0
    iget v1, p0, Ljavax/mail/internet/MailDateParser;->index:I

    add-int/lit8 v1, v1, 0x1

    iput v1, p0, Ljavax/mail/internet/MailDateParser;->index:I

    goto :goto_0

    .line 503
    nop

    :sswitch_data_0
    .sparse-switch
        0x9 -> :sswitch_0
        0xa -> :sswitch_0
        0xd -> :sswitch_0
        0x20 -> :sswitch_0
    .end sparse-switch
.end method
