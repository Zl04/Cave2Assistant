.class public final Ljavax/mail/search/AndTerm;
.super Ljavax/mail/search/SearchTerm;
.source "SourceFile"


# static fields
.field private static final serialVersionUID:J = -0x31ba592d79f28a8eL


# instance fields
.field protected terms:[Ljavax/mail/search/SearchTerm;


# direct methods
.method public constructor <init>(Ljavax/mail/search/SearchTerm;Ljavax/mail/search/SearchTerm;)V
    .locals 2

    .prologue
    .line 70
    invoke-direct {p0}, Ljavax/mail/search/SearchTerm;-><init>()V

    .line 71
    const/4 v0, 0x2

    new-array v0, v0, [Ljavax/mail/search/SearchTerm;

    iput-object v0, p0, Ljavax/mail/search/AndTerm;->terms:[Ljavax/mail/search/SearchTerm;

    .line 72
    iget-object v0, p0, Ljavax/mail/search/AndTerm;->terms:[Ljavax/mail/search/SearchTerm;

    const/4 v1, 0x0

    aput-object p1, v0, v1

    .line 73
    iget-object v0, p0, Ljavax/mail/search/AndTerm;->terms:[Ljavax/mail/search/SearchTerm;

    const/4 v1, 0x1

    aput-object p2, v0, v1

    .line 74
    return-void
.end method

.method public constructor <init>([Ljavax/mail/search/SearchTerm;)V
    .locals 3

    .prologue
    .line 81
    invoke-direct {p0}, Ljavax/mail/search/SearchTerm;-><init>()V

    .line 82
    array-length v0, p1

    new-array v0, v0, [Ljavax/mail/search/SearchTerm;

    iput-object v0, p0, Ljavax/mail/search/AndTerm;->terms:[Ljavax/mail/search/SearchTerm;

    .line 83
    const/4 v0, 0x0

    :goto_0
    array-length v1, p1

    if-lt v0, v1, :cond_0

    .line 85
    return-void

    .line 84
    :cond_0
    iget-object v1, p0, Ljavax/mail/search/AndTerm;->terms:[Ljavax/mail/search/SearchTerm;

    aget-object v2, p1, v0

    aput-object v2, v1, v0

    .line 83
    add-int/lit8 v0, v0, 0x1

    goto :goto_0
.end method


# virtual methods
.method public equals(Ljava/lang/Object;)Z
    .locals 4

    .prologue
    const/4 v1, 0x0

    .line 115
    instance-of v0, p1, Ljavax/mail/search/AndTerm;

    if-nez v0, :cond_1

    .line 123
    :cond_0
    :goto_0
    return v1

    .line 117
    :cond_1
    check-cast p1, Ljavax/mail/search/AndTerm;

    .line 118
    iget-object v0, p1, Ljavax/mail/search/AndTerm;->terms:[Ljavax/mail/search/SearchTerm;

    array-length v0, v0

    iget-object v2, p0, Ljavax/mail/search/AndTerm;->terms:[Ljavax/mail/search/SearchTerm;

    array-length v2, v2

    if-ne v0, v2, :cond_0

    move v0, v1

    .line 120
    :goto_1
    iget-object v2, p0, Ljavax/mail/search/AndTerm;->terms:[Ljavax/mail/search/SearchTerm;

    array-length v2, v2

    if-lt v0, v2, :cond_2

    .line 123
    const/4 v1, 0x1

    goto :goto_0

    .line 121
    :cond_2
    iget-object v2, p0, Ljavax/mail/search/AndTerm;->terms:[Ljavax/mail/search/SearchTerm;

    aget-object v2, v2, v0

    iget-object v3, p1, Ljavax/mail/search/AndTerm;->terms:[Ljavax/mail/search/SearchTerm;

    aget-object v3, v3, v0

    invoke-virtual {v2, v3}, Ljava/lang/Object;->equals(Ljava/lang/Object;)Z

    move-result v2

    if-eqz v2, :cond_0

    .line 120
    add-int/lit8 v0, v0, 0x1

    goto :goto_1
.end method

.method public getTerms()[Ljavax/mail/search/SearchTerm;
    .locals 1

    .prologue
    .line 91
    iget-object v0, p0, Ljavax/mail/search/AndTerm;->terms:[Ljavax/mail/search/SearchTerm;

    invoke-virtual {v0}, [Ljavax/mail/search/SearchTerm;->clone()Ljava/lang/Object;

    move-result-object v0

    check-cast v0, [Ljavax/mail/search/SearchTerm;

    return-object v0
.end method

.method public hashCode()I
    .locals 3

    .prologue
    const/4 v0, 0x0

    .line 130
    move v1, v0

    .line 131
    :goto_0
    iget-object v2, p0, Ljavax/mail/search/AndTerm;->terms:[Ljavax/mail/search/SearchTerm;

    array-length v2, v2

    if-lt v0, v2, :cond_0

    .line 133
    return v1

    .line 132
    :cond_0
    iget-object v2, p0, Ljavax/mail/search/AndTerm;->terms:[Ljavax/mail/search/SearchTerm;

    aget-object v2, v2, v0

    invoke-virtual {v2}, Ljava/lang/Object;->hashCode()I

    move-result v2

    add-int/2addr v1, v2

    .line 131
    add-int/lit8 v0, v0, 0x1

    goto :goto_0
.end method

.method public match(Ljavax/mail/Message;)Z
    .locals 3

    .prologue
    const/4 v1, 0x0

    .line 105
    move v0, v1

    :goto_0
    iget-object v2, p0, Ljavax/mail/search/AndTerm;->terms:[Ljavax/mail/search/SearchTerm;

    array-length v2, v2

    if-lt v0, v2, :cond_1

    .line 108
    const/4 v1, 0x1

    :cond_0
    return v1

    .line 106
    :cond_1
    iget-object v2, p0, Ljavax/mail/search/AndTerm;->terms:[Ljavax/mail/search/SearchTerm;

    aget-object v2, v2, v0

    invoke-virtual {v2, p1}, Ljavax/mail/search/SearchTerm;->match(Ljavax/mail/Message;)Z

    move-result v2

    if-eqz v2, :cond_0

    .line 105
    add-int/lit8 v0, v0, 0x1

    goto :goto_0
.end method
