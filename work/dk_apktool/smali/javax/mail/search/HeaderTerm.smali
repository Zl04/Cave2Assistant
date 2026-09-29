.class public final Ljavax/mail/search/HeaderTerm;
.super Ljavax/mail/search/StringTerm;
.source "SourceFile"


# static fields
.field private static final serialVersionUID:J = 0x73c690dfba9d2142L


# instance fields
.field protected headerName:Ljava/lang/String;


# direct methods
.method public constructor <init>(Ljava/lang/String;Ljava/lang/String;)V
    .locals 0

    .prologue
    .line 70
    invoke-direct {p0, p2}, Ljavax/mail/search/StringTerm;-><init>(Ljava/lang/String;)V

    .line 71
    iput-object p1, p0, Ljavax/mail/search/HeaderTerm;->headerName:Ljava/lang/String;

    .line 72
    return-void
.end method


# virtual methods
.method public equals(Ljava/lang/Object;)Z
    .locals 3

    .prologue
    const/4 v0, 0x0

    .line 109
    instance-of v1, p1, Ljavax/mail/search/HeaderTerm;

    if-nez v1, :cond_1

    .line 113
    :cond_0
    :goto_0
    return v0

    .line 111
    :cond_1
    check-cast p1, Ljavax/mail/search/HeaderTerm;

    .line 113
    iget-object v1, p1, Ljavax/mail/search/HeaderTerm;->headerName:Ljava/lang/String;

    iget-object v2, p0, Ljavax/mail/search/HeaderTerm;->headerName:Ljava/lang/String;

    invoke-virtual {v1, v2}, Ljava/lang/String;->equalsIgnoreCase(Ljava/lang/String;)Z

    move-result v1

    if-eqz v1, :cond_0

    invoke-super {p0, p1}, Ljavax/mail/search/StringTerm;->equals(Ljava/lang/Object;)Z

    move-result v1

    if-eqz v1, :cond_0

    const/4 v0, 0x1

    goto :goto_0
.end method

.method public getHeaderName()Ljava/lang/String;
    .locals 1

    .prologue
    .line 78
    iget-object v0, p0, Ljavax/mail/search/HeaderTerm;->headerName:Ljava/lang/String;

    return-object v0
.end method

.method public hashCode()I
    .locals 2

    .prologue
    .line 121
    iget-object v0, p0, Ljavax/mail/search/HeaderTerm;->headerName:Ljava/lang/String;

    sget-object v1, Ljava/util/Locale;->ENGLISH:Ljava/util/Locale;

    invoke-virtual {v0, v1}, Ljava/lang/String;->toLowerCase(Ljava/util/Locale;)Ljava/lang/String;

    move-result-object v0

    invoke-virtual {v0}, Ljava/lang/String;->hashCode()I

    move-result v0

    .line 122
    invoke-super {p0}, Ljavax/mail/search/StringTerm;->hashCode()I

    move-result v1

    .line 121
    add-int/2addr v0, v1

    return v0
.end method

.method public match(Ljavax/mail/Message;)Z
    .locals 4

    .prologue
    const/4 v1, 0x0

    .line 91
    :try_start_0
    iget-object v0, p0, Ljavax/mail/search/HeaderTerm;->headerName:Ljava/lang/String;

    invoke-virtual {p1, v0}, Ljavax/mail/Message;->getHeader(Ljava/lang/String;)[Ljava/lang/String;
    :try_end_0
    .catch Ljava/lang/Exception; {:try_start_0 .. :try_end_0} :catch_0

    move-result-object v2

    .line 96
    if-nez v2, :cond_1

    .line 102
    :cond_0
    :goto_0
    return v1

    :cond_1
    move v0, v1

    .line 99
    :goto_1
    array-length v3, v2

    if-ge v0, v3, :cond_0

    .line 100
    aget-object v3, v2, v0

    invoke-super {p0, v3}, Ljavax/mail/search/StringTerm;->match(Ljava/lang/String;)Z

    move-result v3

    if-eqz v3, :cond_2

    .line 101
    const/4 v1, 0x1

    goto :goto_0

    .line 99
    :cond_2
    add-int/lit8 v0, v0, 0x1

    goto :goto_1

    .line 92
    :catch_0
    move-exception v0

    goto :goto_0
.end method
