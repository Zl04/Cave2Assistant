.class Ljavax/mail/internet/ParameterList$ToStringBuffer;
.super Ljava/lang/Object;
.source "SourceFile"


# annotations
.annotation system Ldalvik/annotation/EnclosingClass;
    value = Ljavax/mail/internet/ParameterList;
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0xa
    name = "ToStringBuffer"
.end annotation


# instance fields
.field private sb:Ljava/lang/StringBuffer;

.field private used:I


# direct methods
.method public constructor <init>(I)V
    .locals 1

    .prologue
    .line 613
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    .line 611
    new-instance v0, Ljava/lang/StringBuffer;

    invoke-direct {v0}, Ljava/lang/StringBuffer;-><init>()V

    iput-object v0, p0, Ljavax/mail/internet/ParameterList$ToStringBuffer;->sb:Ljava/lang/StringBuffer;

    .line 614
    iput p1, p0, Ljavax/mail/internet/ParameterList$ToStringBuffer;->used:I

    .line 615
    return-void
.end method


# virtual methods
.method public addNV(Ljava/lang/String;Ljava/lang/String;)V
    .locals 4

    .prologue
    const/16 v3, 0x4c

    .line 618
    invoke-static {p2}, Ljavax/mail/internet/ParameterList;->access$0(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v0

    .line 619
    iget-object v1, p0, Ljavax/mail/internet/ParameterList$ToStringBuffer;->sb:Ljava/lang/StringBuffer;

    const-string v2, "; "

    invoke-virtual {v1, v2}, Ljava/lang/StringBuffer;->append(Ljava/lang/String;)Ljava/lang/StringBuffer;

    .line 620
    iget v1, p0, Ljavax/mail/internet/ParameterList$ToStringBuffer;->used:I

    add-int/lit8 v1, v1, 0x2

    iput v1, p0, Ljavax/mail/internet/ParameterList$ToStringBuffer;->used:I

    .line 621
    invoke-virtual {p1}, Ljava/lang/String;->length()I

    move-result v1

    invoke-virtual {v0}, Ljava/lang/String;->length()I

    move-result v2

    add-int/2addr v1, v2

    add-int/lit8 v1, v1, 0x1

    .line 622
    iget v2, p0, Ljavax/mail/internet/ParameterList$ToStringBuffer;->used:I

    add-int/2addr v1, v2

    if-le v1, v3, :cond_0

    .line 623
    iget-object v1, p0, Ljavax/mail/internet/ParameterList$ToStringBuffer;->sb:Ljava/lang/StringBuffer;

    const-string v2, "\r\n\t"

    invoke-virtual {v1, v2}, Ljava/lang/StringBuffer;->append(Ljava/lang/String;)Ljava/lang/StringBuffer;

    .line 624
    const/16 v1, 0x8

    iput v1, p0, Ljavax/mail/internet/ParameterList$ToStringBuffer;->used:I

    .line 626
    :cond_0
    iget-object v1, p0, Ljavax/mail/internet/ParameterList$ToStringBuffer;->sb:Ljava/lang/StringBuffer;

    invoke-virtual {v1, p1}, Ljava/lang/StringBuffer;->append(Ljava/lang/String;)Ljava/lang/StringBuffer;

    move-result-object v1

    const/16 v2, 0x3d

    invoke-virtual {v1, v2}, Ljava/lang/StringBuffer;->append(C)Ljava/lang/StringBuffer;

    .line 627
    iget v1, p0, Ljavax/mail/internet/ParameterList$ToStringBuffer;->used:I

    invoke-virtual {p1}, Ljava/lang/String;->length()I

    move-result v2

    add-int/lit8 v2, v2, 0x1

    add-int/2addr v1, v2

    iput v1, p0, Ljavax/mail/internet/ParameterList$ToStringBuffer;->used:I

    .line 628
    iget v1, p0, Ljavax/mail/internet/ParameterList$ToStringBuffer;->used:I

    invoke-virtual {v0}, Ljava/lang/String;->length()I

    move-result v2

    add-int/2addr v1, v2

    if-le v1, v3, :cond_2

    .line 630
    iget v1, p0, Ljavax/mail/internet/ParameterList$ToStringBuffer;->used:I

    invoke-static {v1, v0}, Ljavax/mail/internet/MimeUtility;->fold(ILjava/lang/String;)Ljava/lang/String;

    move-result-object v0

    .line 631
    iget-object v1, p0, Ljavax/mail/internet/ParameterList$ToStringBuffer;->sb:Ljava/lang/StringBuffer;

    invoke-virtual {v1, v0}, Ljava/lang/StringBuffer;->append(Ljava/lang/String;)Ljava/lang/StringBuffer;

    .line 632
    const/16 v1, 0xa

    invoke-virtual {v0, v1}, Ljava/lang/String;->lastIndexOf(I)I

    move-result v1

    .line 633
    if-ltz v1, :cond_1

    .line 634
    iget v2, p0, Ljavax/mail/internet/ParameterList$ToStringBuffer;->used:I

    invoke-virtual {v0}, Ljava/lang/String;->length()I

    move-result v0

    sub-int/2addr v0, v1

    add-int/lit8 v0, v0, -0x1

    add-int/2addr v0, v2

    iput v0, p0, Ljavax/mail/internet/ParameterList$ToStringBuffer;->used:I

    .line 641
    :goto_0
    return-void

    .line 636
    :cond_1
    iget v1, p0, Ljavax/mail/internet/ParameterList$ToStringBuffer;->used:I

    invoke-virtual {v0}, Ljava/lang/String;->length()I

    move-result v0

    add-int/2addr v0, v1

    iput v0, p0, Ljavax/mail/internet/ParameterList$ToStringBuffer;->used:I

    goto :goto_0

    .line 638
    :cond_2
    iget-object v1, p0, Ljavax/mail/internet/ParameterList$ToStringBuffer;->sb:Ljava/lang/StringBuffer;

    invoke-virtual {v1, v0}, Ljava/lang/StringBuffer;->append(Ljava/lang/String;)Ljava/lang/StringBuffer;

    .line 639
    iget v1, p0, Ljavax/mail/internet/ParameterList$ToStringBuffer;->used:I

    invoke-virtual {v0}, Ljava/lang/String;->length()I

    move-result v0

    add-int/2addr v0, v1

    iput v0, p0, Ljavax/mail/internet/ParameterList$ToStringBuffer;->used:I

    goto :goto_0
.end method

.method public toString()Ljava/lang/String;
    .locals 1

    .prologue
    .line 644
    iget-object v0, p0, Ljavax/mail/internet/ParameterList$ToStringBuffer;->sb:Ljava/lang/StringBuffer;

    invoke-virtual {v0}, Ljava/lang/StringBuffer;->toString()Ljava/lang/String;

    move-result-object v0

    return-object v0
.end method
