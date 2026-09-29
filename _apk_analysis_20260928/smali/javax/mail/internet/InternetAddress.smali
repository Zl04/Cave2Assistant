.class public Ljavax/mail/internet/InternetAddress;
.super Ljavax/mail/Address;
.source "SourceFile"

# interfaces
.implements Ljava/lang/Cloneable;


# static fields
.field private static final rfc822phrase:Ljava/lang/String;

.field private static final serialVersionUID:J = -0x6830565bb828acb7L

.field private static final specialsNoDot:Ljava/lang/String; = "()<>,;:\\\"[]@"

.field private static final specialsNoDotNoAt:Ljava/lang/String; = "()<>,;:\\\"[]"


# instance fields
.field protected address:Ljava/lang/String;

.field protected encodedPersonal:Ljava/lang/String;

.field protected personal:Ljava/lang/String;


# direct methods
.method static constructor <clinit>()V
    .locals 3

    .prologue
    const/4 v2, 0x0

    .line 324
    const-string v0, "()<>@,;:\\\"\t .[]"

    const/16 v1, 0x20

    invoke-virtual {v0, v1, v2}, Ljava/lang/String;->replace(CC)Ljava/lang/String;

    move-result-object v0

    const/16 v1, 0x9

    invoke-virtual {v0, v1, v2}, Ljava/lang/String;->replace(CC)Ljava/lang/String;

    move-result-object v0

    .line 323
    sput-object v0, Ljavax/mail/internet/InternetAddress;->rfc822phrase:Ljava/lang/String;

    .line 61
    return-void
.end method

.method public constructor <init>()V
    .locals 0

    .prologue
    .line 85
    invoke-direct {p0}, Ljavax/mail/Address;-><init>()V

    return-void
.end method

.method public constructor <init>(Ljava/lang/String;)V
    .locals 4
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljavax/mail/internet/AddressException;
        }
    .end annotation

    .prologue
    const/4 v3, 0x1

    const/4 v2, 0x0

    .line 103
    invoke-direct {p0}, Ljavax/mail/Address;-><init>()V

    .line 105
    invoke-static {p1, v3}, Ljavax/mail/internet/InternetAddress;->parse(Ljava/lang/String;Z)[Ljavax/mail/internet/InternetAddress;

    move-result-object v0

    .line 107
    array-length v1, v0

    if-eq v1, v3, :cond_0

    .line 108
    new-instance v0, Ljavax/mail/internet/AddressException;

    const-string v1, "Illegal address"

    invoke-direct {v0, v1, p1}, Ljavax/mail/internet/AddressException;-><init>(Ljava/lang/String;Ljava/lang/String;)V

    throw v0

    .line 116
    :cond_0
    aget-object v1, v0, v2

    iget-object v1, v1, Ljavax/mail/internet/InternetAddress;->address:Ljava/lang/String;

    iput-object v1, p0, Ljavax/mail/internet/InternetAddress;->address:Ljava/lang/String;

    .line 117
    aget-object v1, v0, v2

    iget-object v1, v1, Ljavax/mail/internet/InternetAddress;->personal:Ljava/lang/String;

    iput-object v1, p0, Ljavax/mail/internet/InternetAddress;->personal:Ljava/lang/String;

    .line 118
    aget-object v0, v0, v2

    iget-object v0, v0, Ljavax/mail/internet/InternetAddress;->encodedPersonal:Ljava/lang/String;

    iput-object v0, p0, Ljavax/mail/internet/InternetAddress;->encodedPersonal:Ljava/lang/String;

    .line 119
    return-void
.end method

.method public constructor <init>(Ljava/lang/String;Ljava/lang/String;)V
    .locals 1
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljava/io/UnsupportedEncodingException;
        }
    .end annotation

    .prologue
    .line 147
    const/4 v0, 0x0

    invoke-direct {p0, p1, p2, v0}, Ljavax/mail/internet/InternetAddress;-><init>(Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;)V

    .line 148
    return-void
.end method

.method public constructor <init>(Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;)V
    .locals 0
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljava/io/UnsupportedEncodingException;
        }
    .end annotation

    .prologue
    .line 158
    invoke-direct {p0}, Ljavax/mail/Address;-><init>()V

    .line 160
    iput-object p1, p0, Ljavax/mail/internet/InternetAddress;->address:Ljava/lang/String;

    .line 161
    invoke-virtual {p0, p2, p3}, Ljavax/mail/internet/InternetAddress;->setPersonal(Ljava/lang/String;Ljava/lang/String;)V

    .line 162
    return-void
.end method

.method public constructor <init>(Ljava/lang/String;Z)V
    .locals 2
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljavax/mail/internet/AddressException;
        }
    .end annotation

    .prologue
    const/4 v1, 0x1

    .line 133
    invoke-direct {p0, p1}, Ljavax/mail/internet/InternetAddress;-><init>(Ljava/lang/String;)V

    .line 134
    if-eqz p2, :cond_0

    .line 135
    iget-object v0, p0, Ljavax/mail/internet/InternetAddress;->address:Ljava/lang/String;

    invoke-static {v0, v1, v1}, Ljavax/mail/internet/InternetAddress;->checkAddress(Ljava/lang/String;ZZ)V

    .line 136
    :cond_0
    return-void
.end method

.method private static checkAddress(Ljava/lang/String;ZZ)V
    .locals 4
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljavax/mail/internet/AddressException;
        }
    .end annotation

    .prologue
    const/16 v3, 0x40

    const/4 v0, 0x0

    .line 886
    .line 887
    const/16 v1, 0x22

    invoke-virtual {p0, v1}, Ljava/lang/String;->indexOf(I)I

    move-result v1

    if-ltz v1, :cond_1

    .line 949
    :cond_0
    return-void

    .line 889
    :cond_1
    if-eqz p1, :cond_2

    .line 894
    :goto_0
    const-string v1, ",:"

    invoke-static {p0, v1, v0}, Ljavax/mail/internet/InternetAddress;->indexOfAny(Ljava/lang/String;Ljava/lang/String;I)I

    move-result v1

    if-gez v1, :cond_3

    .line 911
    :cond_2
    :goto_1
    invoke-virtual {p0, v3, v0}, Ljava/lang/String;->indexOf(II)I

    move-result v2

    if-ltz v2, :cond_8

    .line 912
    if-ne v2, v0, :cond_6

    .line 913
    new-instance v0, Ljavax/mail/internet/AddressException;

    const-string v1, "Missing local name"

    invoke-direct {v0, v1, p0}, Ljavax/mail/internet/AddressException;-><init>(Ljava/lang/String;Ljava/lang/String;)V

    throw v0

    .line 896
    :cond_3
    invoke-virtual {p0, v0}, Ljava/lang/String;->charAt(I)C

    move-result v0

    if-eq v0, v3, :cond_4

    .line 897
    new-instance v0, Ljavax/mail/internet/AddressException;

    const-string v1, "Illegal route-addr"

    invoke-direct {v0, v1, p0}, Ljavax/mail/internet/AddressException;-><init>(Ljava/lang/String;Ljava/lang/String;)V

    throw v0

    .line 898
    :cond_4
    invoke-virtual {p0, v1}, Ljava/lang/String;->charAt(I)C

    move-result v0

    const/16 v2, 0x3a

    if-ne v0, v2, :cond_5

    .line 900
    add-int/lit8 v0, v1, 0x1

    .line 901
    goto :goto_1

    .line 895
    :cond_5
    add-int/lit8 v0, v1, 0x1

    goto :goto_0

    .line 914
    :cond_6
    invoke-virtual {p0}, Ljava/lang/String;->length()I

    move-result v1

    add-int/lit8 v1, v1, -0x1

    if-ne v2, v1, :cond_7

    .line 915
    new-instance v0, Ljavax/mail/internet/AddressException;

    const-string v1, "Missing domain"

    invoke-direct {v0, v1, p0}, Ljavax/mail/internet/AddressException;-><init>(Ljava/lang/String;Ljava/lang/String;)V

    throw v0

    .line 916
    :cond_7
    invoke-virtual {p0, v0, v2}, Ljava/lang/String;->substring(II)Ljava/lang/String;

    move-result-object v1

    .line 917
    add-int/lit8 v0, v2, 0x1

    invoke-virtual {p0, v0}, Ljava/lang/String;->substring(I)Ljava/lang/String;

    move-result-object v0

    .line 939
    :goto_2
    const-string v2, " \t\n\r"

    invoke-static {p0, v2}, Ljavax/mail/internet/InternetAddress;->indexOfAny(Ljava/lang/String;Ljava/lang/String;)I

    move-result v2

    if-ltz v2, :cond_a

    .line 940
    new-instance v0, Ljavax/mail/internet/AddressException;

    const-string v1, "Illegal whitespace in address"

    invoke-direct {v0, v1, p0}, Ljavax/mail/internet/AddressException;-><init>(Ljava/lang/String;Ljava/lang/String;)V

    throw v0

    .line 928
    :cond_8
    if-eqz p2, :cond_9

    .line 929
    new-instance v0, Ljavax/mail/internet/AddressException;

    const-string v1, "Missing final \'@domain\'"

    invoke-direct {v0, v1, p0}, Ljavax/mail/internet/AddressException;-><init>(Ljava/lang/String;Ljava/lang/String;)V

    throw v0

    .line 936
    :cond_9
    const/4 v0, 0x0

    move-object v1, p0

    goto :goto_2

    .line 942
    :cond_a
    const-string v2, "()<>,;:\\\"[]@"

    invoke-static {v1, v2}, Ljavax/mail/internet/InternetAddress;->indexOfAny(Ljava/lang/String;Ljava/lang/String;)I

    move-result v1

    if-ltz v1, :cond_b

    .line 943
    new-instance v0, Ljavax/mail/internet/AddressException;

    const-string v1, "Illegal character in local name"

    invoke-direct {v0, v1, p0}, Ljavax/mail/internet/AddressException;-><init>(Ljava/lang/String;Ljava/lang/String;)V

    throw v0

    .line 945
    :cond_b
    if-eqz v0, :cond_0

    const/16 v1, 0x5b

    invoke-virtual {v0, v1}, Ljava/lang/String;->indexOf(I)I

    move-result v1

    if-gez v1, :cond_0

    .line 946
    const-string v1, "()<>,;:\\\"[]@"

    invoke-static {v0, v1}, Ljavax/mail/internet/InternetAddress;->indexOfAny(Ljava/lang/String;Ljava/lang/String;)I

    move-result v0

    if-ltz v0, :cond_0

    .line 947
    new-instance v0, Ljavax/mail/internet/AddressException;

    const-string v1, "Illegal character in domain"

    invoke-direct {v0, v1, p0}, Ljavax/mail/internet/AddressException;-><init>(Ljava/lang/String;Ljava/lang/String;)V

    throw v0
.end method

.method public static getLocalAddress(Ljavax/mail/Session;)Ljavax/mail/internet/InternetAddress;
    .locals 5

    .prologue
    const/4 v0, 0x0

    .line 502
    .line 504
    if-nez p0, :cond_2

    .line 505
    :try_start_0
    const-string v1, "user.name"

    invoke-static {v1}, Ljava/lang/System;->getProperty(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v2

    .line 506
    invoke-static {}, Ljava/net/InetAddress;->getLocalHost()Ljava/net/InetAddress;

    move-result-object v1

    invoke-virtual {v1}, Ljava/net/InetAddress;->getHostName()Ljava/lang/String;

    move-result-object v1

    move-object v3, v2

    move-object v2, v1

    move-object v1, v0

    .line 524
    :cond_0
    :goto_0
    if-nez v1, :cond_8

    if-eqz v3, :cond_8

    invoke-virtual {v3}, Ljava/lang/String;->length()I

    move-result v4

    if-eqz v4, :cond_8

    .line 525
    if-eqz v2, :cond_8

    invoke-virtual {v2}, Ljava/lang/String;->length()I

    move-result v4

    if-eqz v4, :cond_8

    .line 526
    new-instance v1, Ljava/lang/StringBuilder;

    invoke-static {v3}, Ljava/lang/String;->valueOf(Ljava/lang/Object;)Ljava/lang/String;

    move-result-object v3

    invoke-direct {v1, v3}, Ljava/lang/StringBuilder;-><init>(Ljava/lang/String;)V

    const-string v3, "@"

    invoke-virtual {v1, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v1

    move-object v2, v1

    .line 528
    :goto_1
    if-eqz v2, :cond_1

    .line 529
    new-instance v1, Ljavax/mail/internet/InternetAddress;

    invoke-direct {v1, v2}, Ljavax/mail/internet/InternetAddress;-><init>(Ljava/lang/String;)V

    move-object v0, v1

    .line 533
    :cond_1
    :goto_2
    return-object v0

    .line 508
    :cond_2
    const-string v1, "mail.from"

    invoke-virtual {p0, v1}, Ljavax/mail/Session;->getProperty(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v1

    .line 509
    if-nez v1, :cond_9

    .line 510
    const-string v2, "mail.user"

    invoke-virtual {p0, v2}, Ljavax/mail/Session;->getProperty(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v3

    .line 511
    if-eqz v3, :cond_3

    invoke-virtual {v3}, Ljava/lang/String;->length()I

    move-result v2

    if-nez v2, :cond_4

    .line 512
    :cond_3
    const-string v2, "user.name"

    invoke-virtual {p0, v2}, Ljavax/mail/Session;->getProperty(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v3

    .line 513
    :cond_4
    if-eqz v3, :cond_5

    invoke-virtual {v3}, Ljava/lang/String;->length()I

    move-result v2

    if-nez v2, :cond_6

    .line 514
    :cond_5
    const-string v2, "user.name"

    invoke-static {v2}, Ljava/lang/System;->getProperty(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v3

    .line 515
    :cond_6
    const-string v2, "mail.host"

    invoke-virtual {p0, v2}, Ljavax/mail/Session;->getProperty(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v2

    .line 516
    if-eqz v2, :cond_7

    invoke-virtual {v2}, Ljava/lang/String;->length()I

    move-result v4

    if-nez v4, :cond_0

    .line 517
    :cond_7
    invoke-static {}, Ljava/net/InetAddress;->getLocalHost()Ljava/net/InetAddress;

    move-result-object v4

    .line 518
    if-eqz v4, :cond_0

    .line 519
    invoke-virtual {v4}, Ljava/net/InetAddress;->getHostName()Ljava/lang/String;
    :try_end_0
    .catch Ljava/lang/SecurityException; {:try_start_0 .. :try_end_0} :catch_2
    .catch Ljavax/mail/internet/AddressException; {:try_start_0 .. :try_end_0} :catch_1
    .catch Ljava/net/UnknownHostException; {:try_start_0 .. :try_end_0} :catch_0

    move-result-object v2

    goto :goto_0

    .line 532
    :catch_0
    move-exception v1

    goto :goto_2

    .line 531
    :catch_1
    move-exception v1

    goto :goto_2

    .line 530
    :catch_2
    move-exception v1

    goto :goto_2

    :cond_8
    move-object v2, v1

    goto :goto_1

    :cond_9
    move-object v2, v0

    move-object v3, v0

    goto :goto_0
.end method

.method private static indexOfAny(Ljava/lang/String;Ljava/lang/String;)I
    .locals 1

    .prologue
    .line 1007
    const/4 v0, 0x0

    invoke-static {p0, p1, v0}, Ljavax/mail/internet/InternetAddress;->indexOfAny(Ljava/lang/String;Ljava/lang/String;I)I

    move-result v0

    return v0
.end method

.method private static indexOfAny(Ljava/lang/String;Ljava/lang/String;I)I
    .locals 4

    .prologue
    const/4 v1, -0x1

    .line 1012
    :try_start_0
    invoke-virtual {p0}, Ljava/lang/String;->length()I

    move-result v2

    move v0, p2

    .line 1013
    :goto_0
    if-lt v0, v2, :cond_1

    move v0, v1

    .line 1019
    :cond_0
    :goto_1
    return v0

    .line 1014
    :cond_1
    invoke-virtual {p0, v0}, Ljava/lang/String;->charAt(I)C

    move-result v3

    invoke-virtual {p1, v3}, Ljava/lang/String;->indexOf(I)I
    :try_end_0
    .catch Ljava/lang/StringIndexOutOfBoundsException; {:try_start_0 .. :try_end_0} :catch_0

    move-result v3

    if-gez v3, :cond_0

    .line 1013
    add-int/lit8 v0, v0, 0x1

    goto :goto_0

    .line 1018
    :catch_0
    move-exception v0

    move v0, v1

    .line 1019
    goto :goto_1
.end method

.method private isSimple()Z
    .locals 2

    .prologue
    .line 956
    iget-object v0, p0, Ljavax/mail/internet/InternetAddress;->address:Ljava/lang/String;

    if-eqz v0, :cond_0

    iget-object v0, p0, Ljavax/mail/internet/InternetAddress;->address:Ljava/lang/String;

    const-string v1, "()<>,;:\\\"[]"

    invoke-static {v0, v1}, Ljavax/mail/internet/InternetAddress;->indexOfAny(Ljava/lang/String;Ljava/lang/String;)I

    move-result v0

    if-ltz v0, :cond_0

    const/4 v0, 0x0

    :goto_0
    return v0

    :cond_0
    const/4 v0, 0x1

    goto :goto_0
.end method

.method private static lengthOfFirstSegment(Ljava/lang/String;)I
    .locals 2

    .prologue
    .line 469
    const-string v0, "\r\n"

    invoke-virtual {p0, v0}, Ljava/lang/String;->indexOf(Ljava/lang/String;)I

    move-result v0

    const/4 v1, -0x1

    if-eq v0, v1, :cond_0

    .line 472
    :goto_0
    return v0

    :cond_0
    invoke-virtual {p0}, Ljava/lang/String;->length()I

    move-result v0

    goto :goto_0
.end method

.method private static lengthOfLastSegment(Ljava/lang/String;I)I
    .locals 2

    .prologue
    .line 482
    const-string v0, "\r\n"

    invoke-virtual {p0, v0}, Ljava/lang/String;->lastIndexOf(Ljava/lang/String;)I

    move-result v0

    const/4 v1, -0x1

    if-eq v0, v1, :cond_0

    .line 483
    invoke-virtual {p0}, Ljava/lang/String;->length()I

    move-result v1

    sub-int v0, v1, v0

    add-int/lit8 v0, v0, -0x2

    .line 485
    :goto_0
    return v0

    :cond_0
    invoke-virtual {p0}, Ljava/lang/String;->length()I

    move-result v0

    add-int/2addr v0, p1

    goto :goto_0
.end method

.method public static parse(Ljava/lang/String;)[Ljavax/mail/internet/InternetAddress;
    .locals 1
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljavax/mail/internet/AddressException;
        }
    .end annotation

    .prologue
    .line 546
    const/4 v0, 0x1

    invoke-static {p0, v0}, Ljavax/mail/internet/InternetAddress;->parse(Ljava/lang/String;Z)[Ljavax/mail/internet/InternetAddress;

    move-result-object v0

    return-object v0
.end method

.method public static parse(Ljava/lang/String;Z)[Ljavax/mail/internet/InternetAddress;
    .locals 1
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljavax/mail/internet/AddressException;
        }
    .end annotation

    .prologue
    .line 569
    const/4 v0, 0x0

    invoke-static {p0, p1, v0}, Ljavax/mail/internet/InternetAddress;->parse(Ljava/lang/String;ZZ)[Ljavax/mail/internet/InternetAddress;

    move-result-object v0

    return-object v0
.end method

.method private static parse(Ljava/lang/String;ZZ)[Ljavax/mail/internet/InternetAddress;
    .locals 14
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljavax/mail/internet/AddressException;
        }
    .end annotation

    .prologue
    .line 608
    const/4 v0, -0x1

    const/4 v3, -0x1

    .line 609
    invoke-virtual {p0}, Ljava/lang/String;->length()I

    move-result v9

    .line 610
    const/4 v7, 0x0

    .line 611
    const/4 v6, 0x0

    .line 612
    const/4 v5, 0x0

    .line 614
    new-instance v10, Ljava/util/Vector;

    invoke-direct {v10}, Ljava/util/Vector;-><init>()V

    .line 617
    const/4 v2, -0x1

    const/4 v1, 0x0

    move v4, v2

    :goto_0
    if-lt v1, v9, :cond_5

    .line 822
    if-ltz v4, :cond_4

    .line 828
    const/4 v7, -0x1

    if-ne v2, v7, :cond_20

    .line 830
    :goto_1
    invoke-virtual {p0, v4, v1}, Ljava/lang/String;->substring(II)Ljava/lang/String;

    move-result-object v1

    invoke-virtual {v1}, Ljava/lang/String;->trim()Ljava/lang/String;

    move-result-object v1

    .line 831
    if-nez v5, :cond_0

    if-nez p1, :cond_0

    if-eqz p2, :cond_1f

    .line 832
    :cond_0
    if-nez p1, :cond_1

    if-nez p2, :cond_2

    .line 833
    :cond_1
    const/4 v2, 0x0

    invoke-static {v1, v6, v2}, Ljavax/mail/internet/InternetAddress;->checkAddress(Ljava/lang/String;ZZ)V

    .line 834
    :cond_2
    new-instance v2, Ljavax/mail/internet/InternetAddress;

    invoke-direct {v2}, Ljavax/mail/internet/InternetAddress;-><init>()V

    .line 835
    invoke-virtual {v2, v1}, Ljavax/mail/internet/InternetAddress;->setAddress(Ljava/lang/String;)V

    .line 836
    if-ltz v0, :cond_3

    .line 838
    invoke-virtual {p0, v0, v3}, Ljava/lang/String;->substring(II)Ljava/lang/String;

    move-result-object v0

    invoke-virtual {v0}, Ljava/lang/String;->trim()Ljava/lang/String;

    move-result-object v0

    .line 837
    invoke-static {v0}, Ljavax/mail/internet/InternetAddress;->unquote(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v0

    iput-object v0, v2, Ljavax/mail/internet/InternetAddress;->encodedPersonal:Ljava/lang/String;

    .line 840
    :cond_3
    invoke-virtual {v10, v2}, Ljava/util/Vector;->addElement(Ljava/lang/Object;)V

    .line 854
    :cond_4
    invoke-virtual {v10}, Ljava/util/Vector;->size()I

    move-result v0

    new-array v0, v0, [Ljavax/mail/internet/InternetAddress;

    .line 855
    invoke-virtual {v10, v0}, Ljava/util/Vector;->copyInto([Ljava/lang/Object;)V

    .line 856
    return-object v0

    .line 618
    :cond_5
    invoke-virtual {p0, v1}, Ljava/lang/String;->charAt(I)C

    move-result v8

    .line 620
    sparse-switch v8, :sswitch_data_0

    .line 816
    const/4 v8, -0x1

    if-ne v4, v8, :cond_21

    move v4, v0

    move v0, v5

    move v5, v1

    move v12, v6

    move v6, v2

    move v2, v7

    move v7, v1

    move v1, v12

    .line 617
    :goto_2
    add-int/lit8 v5, v5, 0x1

    move v12, v0

    move v0, v4

    move v4, v7

    move v7, v2

    move v2, v6

    move v6, v1

    move v1, v5

    move v5, v12

    goto :goto_0

    .line 624
    :sswitch_0
    const/4 v5, 0x1

    .line 625
    if-ltz v4, :cond_26

    const/4 v8, -0x1

    if-ne v2, v8, :cond_26

    move v8, v1

    .line 627
    :goto_3
    const/4 v2, -0x1

    if-ne v0, v2, :cond_6

    .line 628
    add-int/lit8 v0, v1, 0x1

    .line 629
    :cond_6
    add-int/lit8 v2, v1, 0x1

    const/4 v1, 0x1

    :goto_4
    if-ge v2, v9, :cond_7

    if-gtz v1, :cond_8

    .line 646
    :cond_7
    if-lez v1, :cond_9

    .line 647
    new-instance v0, Ljavax/mail/internet/AddressException;

    const-string v1, "Missing \')\'"

    invoke-direct {v0, v1, p0, v2}, Ljavax/mail/internet/AddressException;-><init>(Ljava/lang/String;Ljava/lang/String;I)V

    throw v0

    .line 631
    :cond_8
    invoke-virtual {p0, v2}, Ljava/lang/String;->charAt(I)C

    move-result v11

    .line 632
    sparse-switch v11, :sswitch_data_1

    .line 630
    :goto_5
    add-int/lit8 v2, v2, 0x1

    goto :goto_4

    .line 634
    :sswitch_1
    add-int/lit8 v2, v2, 0x1

    .line 635
    goto :goto_5

    .line 637
    :sswitch_2
    add-int/lit8 v1, v1, 0x1

    .line 638
    goto :goto_5

    .line 640
    :sswitch_3
    add-int/lit8 v1, v1, -0x1

    .line 641
    goto :goto_5

    .line 648
    :cond_9
    add-int/lit8 v1, v2, -0x1

    .line 649
    const/4 v2, -0x1

    if-ne v3, v2, :cond_25

    move v2, v7

    move v3, v1

    move v7, v4

    move v4, v0

    move v0, v5

    move v5, v1

    move v1, v6

    move v6, v8

    .line 651
    goto :goto_2

    .line 654
    :sswitch_4
    new-instance v0, Ljavax/mail/internet/AddressException;

    const-string v2, "Missing \'(\'"

    invoke-direct {v0, v2, p0, v1}, Ljavax/mail/internet/AddressException;-><init>(Ljava/lang/String;Ljava/lang/String;I)V

    throw v0

    .line 657
    :sswitch_5
    const/4 v5, 0x1

    .line 658
    if-eqz v6, :cond_a

    .line 659
    new-instance v0, Ljavax/mail/internet/AddressException;

    const-string v2, "Extra route-addr"

    invoke-direct {v0, v2, p0, v1}, Ljavax/mail/internet/AddressException;-><init>(Ljava/lang/String;Ljava/lang/String;I)V

    throw v0

    .line 660
    :cond_a
    if-nez v7, :cond_24

    .line 662
    if-ltz v4, :cond_23

    move v0, v1

    .line 664
    :goto_6
    add-int/lit8 v2, v1, 0x1

    move v12, v4

    move v4, v2

    move v2, v12

    .line 667
    :goto_7
    const/4 v3, 0x0

    .line 669
    add-int/lit8 v1, v1, 0x1

    move v12, v3

    move v3, v1

    move v1, v12

    :goto_8
    if-lt v3, v9, :cond_c

    .line 686
    :cond_b
    if-lt v3, v9, :cond_f

    .line 687
    if-eqz v1, :cond_e

    .line 688
    new-instance v0, Ljavax/mail/internet/AddressException;

    const-string v1, "Missing \'\"\'"

    invoke-direct {v0, v1, p0, v3}, Ljavax/mail/internet/AddressException;-><init>(Ljava/lang/String;Ljava/lang/String;I)V

    throw v0

    .line 670
    :cond_c
    invoke-virtual {p0, v3}, Ljava/lang/String;->charAt(I)C

    move-result v6

    .line 671
    sparse-switch v6, :sswitch_data_2

    .line 669
    :goto_9
    add-int/lit8 v3, v3, 0x1

    goto :goto_8

    .line 673
    :sswitch_6
    add-int/lit8 v3, v3, 0x1

    .line 674
    goto :goto_9

    .line 676
    :sswitch_7
    if-eqz v1, :cond_d

    const/4 v1, 0x0

    goto :goto_9

    :cond_d
    const/4 v1, 0x1

    goto :goto_9

    .line 679
    :sswitch_8
    if-eqz v1, :cond_b

    goto :goto_9

    .line 690
    :cond_e
    new-instance v0, Ljavax/mail/internet/AddressException;

    const-string v1, "Missing \'>\'"

    invoke-direct {v0, v1, p0, v3}, Ljavax/mail/internet/AddressException;-><init>(Ljava/lang/String;Ljava/lang/String;I)V

    throw v0

    .line 692
    :cond_f
    const/4 v1, 0x1

    move v6, v3

    move v12, v7

    move v7, v4

    move v4, v2

    move v2, v12

    move v13, v3

    move v3, v0

    move v0, v5

    move v5, v13

    .line 694
    goto/16 :goto_2

    .line 696
    :sswitch_9
    new-instance v0, Ljavax/mail/internet/AddressException;

    const-string v2, "Missing \'<\'"

    invoke-direct {v0, v2, p0, v1}, Ljavax/mail/internet/AddressException;-><init>(Ljava/lang/String;Ljava/lang/String;I)V

    throw v0

    .line 699
    :sswitch_a
    const/4 v5, 0x1

    .line 700
    const/4 v8, -0x1

    if-ne v4, v8, :cond_10

    move v4, v1

    .line 703
    :cond_10
    add-int/lit8 v1, v1, 0x1

    :goto_a
    if-lt v1, v9, :cond_11

    .line 715
    :sswitch_b
    if-lt v1, v9, :cond_21

    .line 716
    new-instance v0, Ljavax/mail/internet/AddressException;

    const-string v2, "Missing \'\"\'"

    invoke-direct {v0, v2, p0, v1}, Ljavax/mail/internet/AddressException;-><init>(Ljava/lang/String;Ljava/lang/String;I)V

    throw v0

    .line 704
    :cond_11
    invoke-virtual {p0, v1}, Ljava/lang/String;->charAt(I)C

    move-result v8

    .line 705
    sparse-switch v8, :sswitch_data_3

    .line 703
    :goto_b
    add-int/lit8 v1, v1, 0x1

    goto :goto_a

    .line 707
    :sswitch_c
    add-int/lit8 v1, v1, 0x1

    .line 708
    goto :goto_b

    .line 720
    :sswitch_d
    const/4 v5, 0x1

    .line 722
    add-int/lit8 v1, v1, 0x1

    :goto_c
    if-lt v1, v9, :cond_12

    .line 734
    :pswitch_0
    if-lt v1, v9, :cond_21

    .line 735
    new-instance v0, Ljavax/mail/internet/AddressException;

    const-string v2, "Missing \']\'"

    invoke-direct {v0, v2, p0, v1}, Ljavax/mail/internet/AddressException;-><init>(Ljava/lang/String;Ljava/lang/String;I)V

    throw v0

    .line 723
    :cond_12
    invoke-virtual {p0, v1}, Ljava/lang/String;->charAt(I)C

    move-result v8

    .line 724
    packed-switch v8, :pswitch_data_0

    .line 722
    :goto_d
    add-int/lit8 v1, v1, 0x1

    goto :goto_c

    .line 726
    :pswitch_1
    add-int/lit8 v1, v1, 0x1

    .line 727
    goto :goto_d

    .line 739
    :sswitch_e
    const/4 v8, -0x1

    if-ne v4, v8, :cond_13

    .line 740
    const/4 v4, 0x0

    .line 741
    const/4 v2, 0x0

    .line 742
    const/4 v5, -0x1

    move v6, v5

    move v12, v4

    move v4, v0

    move v0, v2

    move v2, v7

    move v7, v5

    move v5, v1

    move v1, v12

    .line 743
    goto/16 :goto_2

    .line 745
    :cond_13
    if-eqz v7, :cond_14

    .line 746
    const/4 v6, 0x0

    move v12, v5

    move v5, v1

    move v1, v6

    move v6, v2

    move v2, v7

    move v7, v4

    move v4, v0

    move v0, v12

    .line 747
    goto/16 :goto_2

    .line 750
    :cond_14
    const/4 v8, -0x1

    if-ne v2, v8, :cond_15

    move v2, v1

    .line 752
    :cond_15
    invoke-virtual {p0, v4, v2}, Ljava/lang/String;->substring(II)Ljava/lang/String;

    move-result-object v2

    invoke-virtual {v2}, Ljava/lang/String;->trim()Ljava/lang/String;

    move-result-object v2

    .line 753
    if-nez v5, :cond_16

    if-nez p1, :cond_16

    if-eqz p2, :cond_1b

    .line 754
    :cond_16
    if-nez p1, :cond_17

    if-nez p2, :cond_18

    .line 755
    :cond_17
    const/4 v4, 0x0

    invoke-static {v2, v6, v4}, Ljavax/mail/internet/InternetAddress;->checkAddress(Ljava/lang/String;ZZ)V

    .line 756
    :cond_18
    new-instance v4, Ljavax/mail/internet/InternetAddress;

    invoke-direct {v4}, Ljavax/mail/internet/InternetAddress;-><init>()V

    .line 757
    invoke-virtual {v4, v2}, Ljavax/mail/internet/InternetAddress;->setAddress(Ljava/lang/String;)V

    .line 758
    if-ltz v0, :cond_19

    .line 760
    invoke-virtual {p0, v0, v3}, Ljava/lang/String;->substring(II)Ljava/lang/String;

    move-result-object v0

    invoke-virtual {v0}, Ljava/lang/String;->trim()Ljava/lang/String;

    move-result-object v0

    .line 759
    invoke-static {v0}, Ljavax/mail/internet/InternetAddress;->unquote(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v0

    iput-object v0, v4, Ljavax/mail/internet/InternetAddress;->encodedPersonal:Ljava/lang/String;

    .line 761
    const/4 v3, -0x1

    move v0, v3

    .line 763
    :cond_19
    invoke-virtual {v10, v4}, Ljava/util/Vector;->addElement(Ljava/lang/Object;)V

    .line 776
    :cond_1a
    const/4 v4, 0x0

    .line 777
    const/4 v2, 0x0

    .line 778
    const/4 v5, -0x1

    move v6, v5

    move v12, v4

    move v4, v0

    move v0, v2

    move v2, v7

    move v7, v5

    move v5, v1

    move v1, v12

    .line 779
    goto/16 :goto_2

    .line 766
    :cond_1b
    new-instance v4, Ljava/util/StringTokenizer;

    invoke-direct {v4, v2}, Ljava/util/StringTokenizer;-><init>(Ljava/lang/String;)V

    .line 767
    :goto_e
    invoke-virtual {v4}, Ljava/util/StringTokenizer;->hasMoreTokens()Z

    move-result v2

    if-eqz v2, :cond_1a

    .line 768
    invoke-virtual {v4}, Ljava/util/StringTokenizer;->nextToken()Ljava/lang/String;

    move-result-object v2

    .line 769
    const/4 v5, 0x0

    const/4 v6, 0x0

    invoke-static {v2, v5, v6}, Ljavax/mail/internet/InternetAddress;->checkAddress(Ljava/lang/String;ZZ)V

    .line 770
    new-instance v5, Ljavax/mail/internet/InternetAddress;

    invoke-direct {v5}, Ljavax/mail/internet/InternetAddress;-><init>()V

    .line 771
    invoke-virtual {v5, v2}, Ljavax/mail/internet/InternetAddress;->setAddress(Ljava/lang/String;)V

    .line 772
    invoke-virtual {v10, v5}, Ljava/util/Vector;->addElement(Ljava/lang/Object;)V

    goto :goto_e

    .line 782
    :sswitch_f
    const/4 v5, 0x1

    .line 783
    if-eqz v7, :cond_1c

    .line 784
    new-instance v0, Ljavax/mail/internet/AddressException;

    const-string v2, "Nested group"

    invoke-direct {v0, v2, p0, v1}, Ljavax/mail/internet/AddressException;-><init>(Ljava/lang/String;Ljava/lang/String;I)V

    throw v0

    .line 785
    :cond_1c
    const/4 v7, 0x1

    .line 786
    const/4 v8, -0x1

    if-ne v4, v8, :cond_21

    move v4, v0

    move v0, v5

    move v5, v1

    move v12, v6

    move v6, v2

    move v2, v7

    move v7, v1

    move v1, v12

    .line 788
    goto/16 :goto_2

    .line 791
    :sswitch_10
    const/4 v2, -0x1

    if-ne v4, v2, :cond_22

    move v2, v1

    .line 793
    :goto_f
    if-nez v7, :cond_1d

    .line 794
    new-instance v0, Ljavax/mail/internet/AddressException;

    .line 795
    const-string v2, "Illegal semicolon, not in group"

    .line 794
    invoke-direct {v0, v2, p0, v1}, Ljavax/mail/internet/AddressException;-><init>(Ljava/lang/String;Ljava/lang/String;I)V

    throw v0

    .line 796
    :cond_1d
    const/4 v4, 0x0

    .line 797
    const/4 v6, -0x1

    if-ne v2, v6, :cond_1e

    move v2, v1

    .line 799
    :cond_1e
    new-instance v6, Ljavax/mail/internet/InternetAddress;

    invoke-direct {v6}, Ljavax/mail/internet/InternetAddress;-><init>()V

    .line 800
    add-int/lit8 v7, v1, 0x1

    .line 801
    invoke-virtual {p0, v2, v7}, Ljava/lang/String;->substring(II)Ljava/lang/String;

    move-result-object v2

    invoke-virtual {v2}, Ljava/lang/String;->trim()Ljava/lang/String;

    move-result-object v2

    invoke-virtual {v6, v2}, Ljavax/mail/internet/InternetAddress;->setAddress(Ljava/lang/String;)V

    .line 802
    invoke-virtual {v10, v6}, Ljava/util/Vector;->addElement(Ljava/lang/Object;)V

    .line 804
    const/4 v2, 0x0

    .line 805
    const/4 v6, -0x1

    move v7, v6

    move v12, v2

    move v2, v4

    move v4, v0

    move v0, v5

    move v5, v1

    move v1, v12

    .line 806
    goto/16 :goto_2

    :sswitch_11
    move v12, v5

    move v5, v1

    move v1, v6

    move v6, v2

    move v2, v7

    move v7, v4

    move v4, v0

    move v0, v12

    .line 813
    goto/16 :goto_2

    .line 843
    :cond_1f
    new-instance v0, Ljava/util/StringTokenizer;

    invoke-direct {v0, v1}, Ljava/util/StringTokenizer;-><init>(Ljava/lang/String;)V

    .line 844
    :goto_10
    invoke-virtual {v0}, Ljava/util/StringTokenizer;->hasMoreTokens()Z

    move-result v1

    if-eqz v1, :cond_4

    .line 845
    invoke-virtual {v0}, Ljava/util/StringTokenizer;->nextToken()Ljava/lang/String;

    move-result-object v1

    .line 846
    const/4 v2, 0x0

    const/4 v3, 0x0

    invoke-static {v1, v2, v3}, Ljavax/mail/internet/InternetAddress;->checkAddress(Ljava/lang/String;ZZ)V

    .line 847
    new-instance v2, Ljavax/mail/internet/InternetAddress;

    invoke-direct {v2}, Ljavax/mail/internet/InternetAddress;-><init>()V

    .line 848
    invoke-virtual {v2, v1}, Ljavax/mail/internet/InternetAddress;->setAddress(Ljava/lang/String;)V

    .line 849
    invoke-virtual {v10, v2}, Ljava/util/Vector;->addElement(Ljava/lang/Object;)V

    goto :goto_10

    :cond_20
    move v1, v2

    goto/16 :goto_1

    :cond_21
    move v12, v5

    move v5, v1

    move v1, v6

    move v6, v2

    move v2, v7

    move v7, v4

    move v4, v0

    move v0, v12

    goto/16 :goto_2

    :cond_22
    move v2, v4

    goto :goto_f

    :cond_23
    move v0, v3

    goto/16 :goto_6

    :cond_24
    move v2, v0

    move v0, v3

    goto/16 :goto_7

    :cond_25
    move v2, v7

    move v7, v4

    move v4, v0

    move v0, v5

    move v5, v1

    move v1, v6

    move v6, v8

    goto/16 :goto_2

    :cond_26
    move v8, v2

    goto/16 :goto_3

    .line 620
    :sswitch_data_0
    .sparse-switch
        0x9 -> :sswitch_11
        0xa -> :sswitch_11
        0xd -> :sswitch_11
        0x20 -> :sswitch_11
        0x22 -> :sswitch_a
        0x28 -> :sswitch_0
        0x29 -> :sswitch_4
        0x2c -> :sswitch_e
        0x3a -> :sswitch_f
        0x3b -> :sswitch_10
        0x3c -> :sswitch_5
        0x3e -> :sswitch_9
        0x5b -> :sswitch_d
    .end sparse-switch

    .line 632
    :sswitch_data_1
    .sparse-switch
        0x28 -> :sswitch_2
        0x29 -> :sswitch_3
        0x5c -> :sswitch_1
    .end sparse-switch

    .line 671
    :sswitch_data_2
    .sparse-switch
        0x22 -> :sswitch_7
        0x3e -> :sswitch_8
        0x5c -> :sswitch_6
    .end sparse-switch

    .line 705
    :sswitch_data_3
    .sparse-switch
        0x22 -> :sswitch_b
        0x5c -> :sswitch_c
    .end sparse-switch

    .line 724
    :pswitch_data_0
    .packed-switch 0x5c
        :pswitch_1
        :pswitch_0
    .end packed-switch
.end method

.method public static parseHeader(Ljava/lang/String;Z)[Ljavax/mail/internet/InternetAddress;
    .locals 1
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljavax/mail/internet/AddressException;
        }
    .end annotation

    .prologue
    .line 594
    const/4 v0, 0x1

    invoke-static {p0, p1, v0}, Ljavax/mail/internet/InternetAddress;->parse(Ljava/lang/String;ZZ)[Ljavax/mail/internet/InternetAddress;

    move-result-object v0

    return-object v0
.end method

.method private static quotePhrase(Ljava/lang/String;)Ljava/lang/String;
    .locals 8

    .prologue
    const/16 v7, 0x5c

    const/4 v1, 0x0

    const/16 v6, 0x22

    .line 327
    invoke-virtual {p0}, Ljava/lang/String;->length()I

    move-result v3

    move v2, v1

    move v0, v1

    .line 330
    :goto_0
    if-lt v2, v3, :cond_1

    .line 351
    if-eqz v0, :cond_0

    .line 352
    new-instance v0, Ljava/lang/StringBuffer;

    add-int/lit8 v1, v3, 0x2

    invoke-direct {v0, v1}, Ljava/lang/StringBuffer;-><init>(I)V

    .line 353
    invoke-virtual {v0, v6}, Ljava/lang/StringBuffer;->append(C)Ljava/lang/StringBuffer;

    move-result-object v1

    invoke-virtual {v1, p0}, Ljava/lang/StringBuffer;->append(Ljava/lang/String;)Ljava/lang/StringBuffer;

    move-result-object v1

    invoke-virtual {v1, v6}, Ljava/lang/StringBuffer;->append(C)Ljava/lang/StringBuffer;

    .line 354
    invoke-virtual {v0}, Ljava/lang/StringBuffer;->toString()Ljava/lang/String;

    move-result-object p0

    .line 356
    :cond_0
    :goto_1
    return-object p0

    .line 331
    :cond_1
    invoke-virtual {p0, v2}, Ljava/lang/String;->charAt(I)C

    move-result v4

    .line 332
    if-eq v4, v6, :cond_2

    if-ne v4, v7, :cond_6

    .line 334
    :cond_2
    new-instance v2, Ljava/lang/StringBuffer;

    add-int/lit8 v0, v3, 0x3

    invoke-direct {v2, v0}, Ljava/lang/StringBuffer;-><init>(I)V

    .line 335
    invoke-virtual {v2, v6}, Ljava/lang/StringBuffer;->append(C)Ljava/lang/StringBuffer;

    move v0, v1

    .line 336
    :goto_2
    if-lt v0, v3, :cond_3

    .line 343
    invoke-virtual {v2, v6}, Ljava/lang/StringBuffer;->append(C)Ljava/lang/StringBuffer;

    .line 344
    invoke-virtual {v2}, Ljava/lang/StringBuffer;->toString()Ljava/lang/String;

    move-result-object p0

    goto :goto_1

    .line 337
    :cond_3
    invoke-virtual {p0, v0}, Ljava/lang/String;->charAt(I)C

    move-result v1

    .line 338
    if-eq v1, v6, :cond_4

    if-ne v1, v7, :cond_5

    .line 340
    :cond_4
    invoke-virtual {v2, v7}, Ljava/lang/StringBuffer;->append(C)Ljava/lang/StringBuffer;

    .line 341
    :cond_5
    invoke-virtual {v2, v1}, Ljava/lang/StringBuffer;->append(C)Ljava/lang/StringBuffer;

    .line 336
    add-int/lit8 v0, v0, 0x1

    goto :goto_2

    .line 345
    :cond_6
    const/16 v5, 0x20

    if-ge v4, v5, :cond_7

    const/16 v5, 0xd

    if-eq v4, v5, :cond_7

    const/16 v5, 0xa

    if-eq v4, v5, :cond_7

    const/16 v5, 0x9

    if-ne v4, v5, :cond_8

    .line 346
    :cond_7
    const/16 v5, 0x7f

    if-ge v4, v5, :cond_8

    sget-object v5, Ljavax/mail/internet/InternetAddress;->rfc822phrase:Ljava/lang/String;

    invoke-virtual {v5, v4}, Ljava/lang/String;->indexOf(I)I

    move-result v4

    if-ltz v4, :cond_9

    .line 348
    :cond_8
    const/4 v0, 0x1

    .line 330
    :cond_9
    add-int/lit8 v2, v2, 0x1

    goto :goto_0
.end method

.method public static toString([Ljavax/mail/Address;)Ljava/lang/String;
    .locals 1

    .prologue
    .line 416
    const/4 v0, 0x0

    invoke-static {p0, v0}, Ljavax/mail/internet/InternetAddress;->toString([Ljavax/mail/Address;I)Ljava/lang/String;

    move-result-object v0

    return-object v0
.end method

.method public static toString([Ljavax/mail/Address;I)Ljava/lang/String;
    .locals 5

    .prologue
    .line 440
    if-eqz p0, :cond_0

    array-length v0, p0

    if-nez v0, :cond_1

    .line 441
    :cond_0
    const/4 v0, 0x0

    .line 461
    :goto_0
    return-object v0

    .line 443
    :cond_1
    new-instance v1, Ljava/lang/StringBuffer;

    invoke-direct {v1}, Ljava/lang/StringBuffer;-><init>()V

    .line 445
    const/4 v0, 0x0

    :goto_1
    array-length v2, p0

    if-lt v0, v2, :cond_2

    .line 461
    invoke-virtual {v1}, Ljava/lang/StringBuffer;->toString()Ljava/lang/String;

    move-result-object v0

    goto :goto_0

    .line 446
    :cond_2
    if-eqz v0, :cond_3

    .line 447
    const-string v2, ", "

    invoke-virtual {v1, v2}, Ljava/lang/StringBuffer;->append(Ljava/lang/String;)Ljava/lang/StringBuffer;

    .line 448
    add-int/lit8 p1, p1, 0x2

    .line 451
    :cond_3
    aget-object v2, p0, v0

    invoke-virtual {v2}, Ljavax/mail/Address;->toString()Ljava/lang/String;

    move-result-object v2

    .line 452
    invoke-static {v2}, Ljavax/mail/internet/InternetAddress;->lengthOfFirstSegment(Ljava/lang/String;)I

    move-result v3

    .line 453
    add-int/2addr v3, p1

    const/16 v4, 0x4c

    if-le v3, v4, :cond_4

    .line 454
    const-string v3, "\r\n\t"

    invoke-virtual {v1, v3}, Ljava/lang/StringBuffer;->append(Ljava/lang/String;)Ljava/lang/StringBuffer;

    .line 455
    const/16 p1, 0x8

    .line 457
    :cond_4
    invoke-virtual {v1, v2}, Ljava/lang/StringBuffer;->append(Ljava/lang/String;)Ljava/lang/StringBuffer;

    .line 458
    invoke-static {v2, p1}, Ljavax/mail/internet/InternetAddress;->lengthOfLastSegment(Ljava/lang/String;I)I

    move-result p1

    .line 445
    add-int/lit8 v0, v0, 0x1

    goto :goto_1
.end method

.method private static unquote(Ljava/lang/String;)Ljava/lang/String;
    .locals 6

    .prologue
    const/16 v4, 0x5c

    .line 360
    const-string v0, "\""

    invoke-virtual {p0, v0}, Ljava/lang/String;->startsWith(Ljava/lang/String;)Z

    move-result v0

    if-eqz v0, :cond_0

    const-string v0, "\""

    invoke-virtual {p0, v0}, Ljava/lang/String;->endsWith(Ljava/lang/String;)Z

    move-result v0

    if-eqz v0, :cond_0

    .line 361
    const/4 v0, 0x1

    invoke-virtual {p0}, Ljava/lang/String;->length()I

    move-result v1

    add-int/lit8 v1, v1, -0x1

    invoke-virtual {p0, v0, v1}, Ljava/lang/String;->substring(II)Ljava/lang/String;

    move-result-object p0

    .line 363
    invoke-virtual {p0, v4}, Ljava/lang/String;->indexOf(I)I

    move-result v0

    if-ltz v0, :cond_0

    .line 364
    new-instance v2, Ljava/lang/StringBuffer;

    invoke-virtual {p0}, Ljava/lang/String;->length()I

    move-result v0

    invoke-direct {v2, v0}, Ljava/lang/StringBuffer;-><init>(I)V

    .line 365
    const/4 v0, 0x0

    :goto_0
    invoke-virtual {p0}, Ljava/lang/String;->length()I

    move-result v1

    if-lt v0, v1, :cond_1

    .line 371
    invoke-virtual {v2}, Ljava/lang/StringBuffer;->toString()Ljava/lang/String;

    move-result-object p0

    .line 374
    :cond_0
    return-object p0

    .line 366
    :cond_1
    invoke-virtual {p0, v0}, Ljava/lang/String;->charAt(I)C

    move-result v1

    .line 367
    if-ne v1, v4, :cond_2

    invoke-virtual {p0}, Ljava/lang/String;->length()I

    move-result v3

    add-int/lit8 v3, v3, -0x1

    if-ge v0, v3, :cond_2

    .line 368
    add-int/lit8 v1, v0, 0x1

    invoke-virtual {p0, v1}, Ljava/lang/String;->charAt(I)C

    move-result v0

    .line 369
    :goto_1
    invoke-virtual {v2, v0}, Ljava/lang/StringBuffer;->append(C)Ljava/lang/StringBuffer;

    .line 365
    add-int/lit8 v0, v1, 0x1

    goto :goto_0

    :cond_2
    move v5, v1

    move v1, v0

    move v0, v5

    goto :goto_1
.end method


# virtual methods
.method public clone()Ljava/lang/Object;
    .locals 2

    .prologue
    .line 169
    const/4 v1, 0x0

    .line 171
    :try_start_0
    invoke-super {p0}, Ljava/lang/Object;->clone()Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Ljavax/mail/internet/InternetAddress;
    :try_end_0
    .catch Ljava/lang/CloneNotSupportedException; {:try_start_0 .. :try_end_0} :catch_0

    .line 173
    :goto_0
    return-object v0

    .line 172
    :catch_0
    move-exception v0

    move-object v0, v1

    goto :goto_0
.end method

.method public equals(Ljava/lang/Object;)Z
    .locals 4

    .prologue
    const/4 v1, 0x1

    const/4 v0, 0x0

    .line 381
    instance-of v2, p1, Ljavax/mail/internet/InternetAddress;

    if-nez v2, :cond_1

    .line 390
    :cond_0
    :goto_0
    return v0

    .line 384
    :cond_1
    check-cast p1, Ljavax/mail/internet/InternetAddress;

    invoke-virtual {p1}, Ljavax/mail/internet/InternetAddress;->getAddress()Ljava/lang/String;

    move-result-object v2

    .line 385
    iget-object v3, p0, Ljavax/mail/internet/InternetAddress;->address:Ljava/lang/String;

    if-ne v2, v3, :cond_2

    move v0, v1

    .line 386
    goto :goto_0

    .line 387
    :cond_2
    iget-object v3, p0, Ljavax/mail/internet/InternetAddress;->address:Ljava/lang/String;

    if-eqz v3, :cond_0

    iget-object v3, p0, Ljavax/mail/internet/InternetAddress;->address:Ljava/lang/String;

    invoke-virtual {v3, v2}, Ljava/lang/String;->equalsIgnoreCase(Ljava/lang/String;)Z

    move-result v2

    if-eqz v2, :cond_0

    move v0, v1

    .line 388
    goto :goto_0
.end method

.method public getAddress()Ljava/lang/String;
    .locals 1

    .prologue
    .line 240
    iget-object v0, p0, Ljavax/mail/internet/InternetAddress;->address:Ljava/lang/String;

    return-object v0
.end method

.method public getGroup(Z)[Ljavax/mail/internet/InternetAddress;
    .locals 3
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljavax/mail/internet/AddressException;
        }
    .end annotation

    .prologue
    const/4 v0, 0x0

    .line 986
    .line 987
    invoke-virtual {p0}, Ljavax/mail/internet/InternetAddress;->getAddress()Ljava/lang/String;

    move-result-object v1

    .line 989
    const-string v2, ";"

    invoke-virtual {v1, v2}, Ljava/lang/String;->endsWith(Ljava/lang/String;)Z

    move-result v2

    if-nez v2, :cond_1

    .line 997
    :cond_0
    :goto_0
    return-object v0

    .line 991
    :cond_1
    const/16 v2, 0x3a

    invoke-virtual {v1, v2}, Ljava/lang/String;->indexOf(I)I

    move-result v2

    .line 992
    if-ltz v2, :cond_0

    .line 995
    add-int/lit8 v0, v2, 0x1

    invoke-virtual {v1}, Ljava/lang/String;->length()I

    move-result v2

    add-int/lit8 v2, v2, -0x1

    invoke-virtual {v1, v0, v2}, Ljava/lang/String;->substring(II)Ljava/lang/String;

    move-result-object v0

    .line 997
    invoke-static {v0, p1}, Ljavax/mail/internet/InternetAddress;->parseHeader(Ljava/lang/String;Z)[Ljavax/mail/internet/InternetAddress;

    move-result-object v0

    goto :goto_0
.end method

.method public getPersonal()Ljava/lang/String;
    .locals 1

    .prologue
    .line 251
    iget-object v0, p0, Ljavax/mail/internet/InternetAddress;->personal:Ljava/lang/String;

    if-eqz v0, :cond_0

    .line 252
    iget-object v0, p0, Ljavax/mail/internet/InternetAddress;->personal:Ljava/lang/String;

    .line 266
    :goto_0
    return-object v0

    .line 254
    :cond_0
    iget-object v0, p0, Ljavax/mail/internet/InternetAddress;->encodedPersonal:Ljava/lang/String;

    if-eqz v0, :cond_1

    .line 256
    :try_start_0
    iget-object v0, p0, Ljavax/mail/internet/InternetAddress;->encodedPersonal:Ljava/lang/String;

    invoke-static {v0}, Ljavax/mail/internet/MimeUtility;->decodeText(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v0

    iput-object v0, p0, Ljavax/mail/internet/InternetAddress;->personal:Ljava/lang/String;

    .line 257
    iget-object v0, p0, Ljavax/mail/internet/InternetAddress;->personal:Ljava/lang/String;
    :try_end_0
    .catch Ljava/lang/Exception; {:try_start_0 .. :try_end_0} :catch_0

    goto :goto_0

    .line 258
    :catch_0
    move-exception v0

    .line 262
    iget-object v0, p0, Ljavax/mail/internet/InternetAddress;->encodedPersonal:Ljava/lang/String;

    goto :goto_0

    .line 266
    :cond_1
    const/4 v0, 0x0

    goto :goto_0
.end method

.method public getType()Ljava/lang/String;
    .locals 1

    .prologue
    .line 181
    const-string v0, "rfc822"

    return-object v0
.end method

.method public hashCode()I
    .locals 2

    .prologue
    .line 397
    iget-object v0, p0, Ljavax/mail/internet/InternetAddress;->address:Ljava/lang/String;

    if-nez v0, :cond_0

    .line 398
    const/4 v0, 0x0

    .line 400
    :goto_0
    return v0

    :cond_0
    iget-object v0, p0, Ljavax/mail/internet/InternetAddress;->address:Ljava/lang/String;

    sget-object v1, Ljava/util/Locale;->ENGLISH:Ljava/util/Locale;

    invoke-virtual {v0, v1}, Ljava/lang/String;->toLowerCase(Ljava/util/Locale;)Ljava/lang/String;

    move-result-object v0

    invoke-virtual {v0}, Ljava/lang/String;->hashCode()I

    move-result v0

    goto :goto_0
.end method

.method public isGroup()Z
    .locals 2

    .prologue
    .line 970
    iget-object v0, p0, Ljavax/mail/internet/InternetAddress;->address:Ljava/lang/String;

    if-eqz v0, :cond_0

    .line 971
    iget-object v0, p0, Ljavax/mail/internet/InternetAddress;->address:Ljava/lang/String;

    const-string v1, ";"

    invoke-virtual {v0, v1}, Ljava/lang/String;->endsWith(Ljava/lang/String;)Z

    move-result v0

    if-eqz v0, :cond_0

    iget-object v0, p0, Ljavax/mail/internet/InternetAddress;->address:Ljava/lang/String;

    const/16 v1, 0x3a

    invoke-virtual {v0, v1}, Ljava/lang/String;->indexOf(I)I

    move-result v0

    if-lez v0, :cond_0

    const/4 v0, 0x1

    :goto_0
    return v0

    :cond_0
    const/4 v0, 0x0

    .line 970
    goto :goto_0
.end method

.method public setAddress(Ljava/lang/String;)V
    .locals 0

    .prologue
    .line 190
    iput-object p1, p0, Ljavax/mail/internet/InternetAddress;->address:Ljava/lang/String;

    .line 191
    return-void
.end method

.method public setPersonal(Ljava/lang/String;)V
    .locals 1
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljava/io/UnsupportedEncodingException;
        }
    .end annotation

    .prologue
    .line 228
    iput-object p1, p0, Ljavax/mail/internet/InternetAddress;->personal:Ljava/lang/String;

    .line 229
    if-eqz p1, :cond_0

    .line 230
    invoke-static {p1}, Ljavax/mail/internet/MimeUtility;->encodeWord(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v0

    iput-object v0, p0, Ljavax/mail/internet/InternetAddress;->encodedPersonal:Ljava/lang/String;

    .line 233
    :goto_0
    return-void

    .line 232
    :cond_0
    const/4 v0, 0x0

    iput-object v0, p0, Ljavax/mail/internet/InternetAddress;->encodedPersonal:Ljava/lang/String;

    goto :goto_0
.end method

.method public setPersonal(Ljava/lang/String;Ljava/lang/String;)V
    .locals 1
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljava/io/UnsupportedEncodingException;
        }
    .end annotation

    .prologue
    const/4 v0, 0x0

    .line 208
    iput-object p1, p0, Ljavax/mail/internet/InternetAddress;->personal:Ljava/lang/String;

    .line 209
    if-eqz p1, :cond_0

    .line 210
    invoke-static {p1, p2, v0}, Ljavax/mail/internet/MimeUtility;->encodeWord(Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;)Ljava/lang/String;

    move-result-object v0

    iput-object v0, p0, Ljavax/mail/internet/InternetAddress;->encodedPersonal:Ljava/lang/String;

    .line 213
    :goto_0
    return-void

    .line 212
    :cond_0
    iput-object v0, p0, Ljavax/mail/internet/InternetAddress;->encodedPersonal:Ljava/lang/String;

    goto :goto_0
.end method

.method public toString()Ljava/lang/String;
    .locals 2

    .prologue
    .line 277
    iget-object v0, p0, Ljavax/mail/internet/InternetAddress;->encodedPersonal:Ljava/lang/String;

    if-nez v0, :cond_0

    iget-object v0, p0, Ljavax/mail/internet/InternetAddress;->personal:Ljava/lang/String;

    if-eqz v0, :cond_0

    .line 279
    :try_start_0
    iget-object v0, p0, Ljavax/mail/internet/InternetAddress;->personal:Ljava/lang/String;

    invoke-static {v0}, Ljavax/mail/internet/MimeUtility;->encodeWord(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v0

    iput-object v0, p0, Ljavax/mail/internet/InternetAddress;->encodedPersonal:Ljava/lang/String;
    :try_end_0
    .catch Ljava/io/UnsupportedEncodingException; {:try_start_0 .. :try_end_0} :catch_0

    .line 282
    :cond_0
    :goto_0
    iget-object v0, p0, Ljavax/mail/internet/InternetAddress;->encodedPersonal:Ljava/lang/String;

    if-eqz v0, :cond_1

    .line 283
    new-instance v0, Ljava/lang/StringBuilder;

    iget-object v1, p0, Ljavax/mail/internet/InternetAddress;->encodedPersonal:Ljava/lang/String;

    invoke-static {v1}, Ljavax/mail/internet/InternetAddress;->quotePhrase(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v1

    invoke-static {v1}, Ljava/lang/String;->valueOf(Ljava/lang/Object;)Ljava/lang/String;

    move-result-object v1

    invoke-direct {v0, v1}, Ljava/lang/StringBuilder;-><init>(Ljava/lang/String;)V

    const-string v1, " <"

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    iget-object v1, p0, Ljavax/mail/internet/InternetAddress;->address:Ljava/lang/String;

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    const-string v1, ">"

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-virtual {v0}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v0

    .line 287
    :goto_1
    return-object v0

    .line 284
    :cond_1
    invoke-virtual {p0}, Ljavax/mail/internet/InternetAddress;->isGroup()Z

    move-result v0

    if-nez v0, :cond_2

    invoke-direct {p0}, Ljavax/mail/internet/InternetAddress;->isSimple()Z

    move-result v0

    if-eqz v0, :cond_3

    .line 285
    :cond_2
    iget-object v0, p0, Ljavax/mail/internet/InternetAddress;->address:Ljava/lang/String;

    goto :goto_1

    .line 287
    :cond_3
    new-instance v0, Ljava/lang/StringBuilder;

    const-string v1, "<"

    invoke-direct {v0, v1}, Ljava/lang/StringBuilder;-><init>(Ljava/lang/String;)V

    iget-object v1, p0, Ljavax/mail/internet/InternetAddress;->address:Ljava/lang/String;

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    const-string v1, ">"

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-virtual {v0}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v0

    goto :goto_1

    .line 280
    :catch_0
    move-exception v0

    goto :goto_0
.end method

.method public toUnicodeString()Ljava/lang/String;
    .locals 2

    .prologue
    .line 298
    invoke-virtual {p0}, Ljavax/mail/internet/InternetAddress;->getPersonal()Ljava/lang/String;

    move-result-object v0

    .line 299
    if-eqz v0, :cond_0

    .line 300
    new-instance v1, Ljava/lang/StringBuilder;

    invoke-static {v0}, Ljavax/mail/internet/InternetAddress;->quotePhrase(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v0

    invoke-static {v0}, Ljava/lang/String;->valueOf(Ljava/lang/Object;)Ljava/lang/String;

    move-result-object v0

    invoke-direct {v1, v0}, Ljava/lang/StringBuilder;-><init>(Ljava/lang/String;)V

    const-string v0, " <"

    invoke-virtual {v1, v0}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    iget-object v1, p0, Ljavax/mail/internet/InternetAddress;->address:Ljava/lang/String;

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    const-string v1, ">"

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-virtual {v0}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v0

    .line 304
    :goto_0
    return-object v0

    .line 301
    :cond_0
    invoke-virtual {p0}, Ljavax/mail/internet/InternetAddress;->isGroup()Z

    move-result v0

    if-nez v0, :cond_1

    invoke-direct {p0}, Ljavax/mail/internet/InternetAddress;->isSimple()Z

    move-result v0

    if-eqz v0, :cond_2

    .line 302
    :cond_1
    iget-object v0, p0, Ljavax/mail/internet/InternetAddress;->address:Ljava/lang/String;

    goto :goto_0

    .line 304
    :cond_2
    new-instance v0, Ljava/lang/StringBuilder;

    const-string v1, "<"

    invoke-direct {v0, v1}, Ljava/lang/StringBuilder;-><init>(Ljava/lang/String;)V

    iget-object v1, p0, Ljavax/mail/internet/InternetAddress;->address:Ljava/lang/String;

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    const-string v1, ">"

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-virtual {v0}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v0

    goto :goto_0
.end method

.method public validate()V
    .locals 2
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljavax/mail/internet/AddressException;
        }
    .end annotation

    .prologue
    const/4 v1, 0x1

    .line 870
    invoke-virtual {p0}, Ljavax/mail/internet/InternetAddress;->getAddress()Ljava/lang/String;

    move-result-object v0

    invoke-static {v0, v1, v1}, Ljavax/mail/internet/InternetAddress;->checkAddress(Ljava/lang/String;ZZ)V

    .line 871
    return-void
.end method
