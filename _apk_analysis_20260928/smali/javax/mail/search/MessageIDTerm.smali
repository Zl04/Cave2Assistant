.class public final Ljavax/mail/search/MessageIDTerm;
.super Ljavax/mail/search/StringTerm;
.source "SourceFile"


# static fields
.field private static final serialVersionUID:J = -0x1d6fa5d7f4941c7bL


# direct methods
.method public constructor <init>(Ljava/lang/String;)V
    .locals 0

    .prologue
    .line 67
    invoke-direct {p0, p1}, Ljavax/mail/search/StringTerm;-><init>(Ljava/lang/String;)V

    .line 68
    return-void
.end method


# virtual methods
.method public equals(Ljava/lang/Object;)Z
    .locals 1

    .prologue
    .line 99
    instance-of v0, p1, Ljavax/mail/search/MessageIDTerm;

    if-nez v0, :cond_0

    .line 100
    const/4 v0, 0x0

    .line 101
    :goto_0
    return v0

    :cond_0
    invoke-super {p0, p1}, Ljavax/mail/search/StringTerm;->equals(Ljava/lang/Object;)Z

    move-result v0

    goto :goto_0
.end method

.method public match(Ljavax/mail/Message;)Z
    .locals 4

    .prologue
    const/4 v1, 0x0

    .line 81
    :try_start_0
    const-string v0, "Message-ID"

    invoke-virtual {p1, v0}, Ljavax/mail/Message;->getHeader(Ljava/lang/String;)[Ljava/lang/String;
    :try_end_0
    .catch Ljava/lang/Exception; {:try_start_0 .. :try_end_0} :catch_0

    move-result-object v2

    .line 86
    if-nez v2, :cond_1

    .line 92
    :cond_0
    :goto_0
    return v1

    :cond_1
    move v0, v1

    .line 89
    :goto_1
    array-length v3, v2

    if-ge v0, v3, :cond_0

    .line 90
    aget-object v3, v2, v0

    invoke-super {p0, v3}, Ljavax/mail/search/StringTerm;->match(Ljava/lang/String;)Z

    move-result v3

    if-eqz v3, :cond_2

    .line 91
    const/4 v1, 0x1

    goto :goto_0

    .line 89
    :cond_2
    add-int/lit8 v0, v0, 0x1

    goto :goto_1

    .line 82
    :catch_0
    move-exception v0

    goto :goto_0
.end method
