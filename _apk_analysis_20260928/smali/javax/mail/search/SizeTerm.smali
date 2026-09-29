.class public final Ljavax/mail/search/SizeTerm;
.super Ljavax/mail/search/IntegerComparisonTerm;
.source "SourceFile"


# static fields
.field private static final serialVersionUID:J = -0x2379840c191a6e5dL


# direct methods
.method public constructor <init>(II)V
    .locals 0

    .prologue
    .line 62
    invoke-direct {p0, p1, p2}, Ljavax/mail/search/IntegerComparisonTerm;-><init>(II)V

    .line 63
    return-void
.end method


# virtual methods
.method public equals(Ljava/lang/Object;)Z
    .locals 1

    .prologue
    .line 90
    instance-of v0, p1, Ljavax/mail/search/SizeTerm;

    if-nez v0, :cond_0

    .line 91
    const/4 v0, 0x0

    .line 92
    :goto_0
    return v0

    :cond_0
    invoke-super {p0, p1}, Ljavax/mail/search/IntegerComparisonTerm;->equals(Ljava/lang/Object;)Z

    move-result v0

    goto :goto_0
.end method

.method public match(Ljavax/mail/Message;)Z
    .locals 3

    .prologue
    const/4 v0, 0x0

    .line 75
    :try_start_0
    invoke-virtual {p1}, Ljavax/mail/Message;->getSize()I
    :try_end_0
    .catch Ljava/lang/Exception; {:try_start_0 .. :try_end_0} :catch_0

    move-result v1

    .line 80
    const/4 v2, -0x1

    if-ne v1, v2, :cond_0

    .line 83
    :goto_0
    return v0

    :cond_0
    invoke-super {p0, v1}, Ljavax/mail/search/IntegerComparisonTerm;->match(I)Z

    move-result v0

    goto :goto_0

    .line 76
    :catch_0
    move-exception v1

    goto :goto_0
.end method
