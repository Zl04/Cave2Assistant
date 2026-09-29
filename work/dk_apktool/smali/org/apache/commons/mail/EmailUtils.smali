.class final Lorg/apache/commons/mail/EmailUtils;
.super Ljava/lang/Object;
.source "SourceFile"


# static fields
.field private static final ESCAPE_CHAR:C = '%'

.field private static final RADIX:I = 0x10

.field private static final RANDOM:Ljava/util/Random;

.field private static final SAFE_URL:Ljava/util/BitSet;

.field private static final US_ASCII:Ljava/lang/String; = "US-ASCII"


# direct methods
.method static constructor <clinit>()V
    .locals 2

    .prologue
    .line 52
    new-instance v0, Ljava/util/Random;

    invoke-direct {v0}, Ljava/util/Random;-><init>()V

    sput-object v0, Lorg/apache/commons/mail/EmailUtils;->RANDOM:Ljava/util/Random;

    .line 72
    new-instance v0, Ljava/util/BitSet;

    const/16 v1, 0x100

    invoke-direct {v0, v1}, Ljava/util/BitSet;-><init>(I)V

    sput-object v0, Lorg/apache/commons/mail/EmailUtils;->SAFE_URL:Ljava/util/BitSet;

    .line 77
    const/16 v0, 0x61

    :goto_0
    const/16 v1, 0x7a

    if-gt v0, v1, :cond_0

    .line 79
    sget-object v1, Lorg/apache/commons/mail/EmailUtils;->SAFE_URL:Ljava/util/BitSet;

    invoke-virtual {v1, v0}, Ljava/util/BitSet;->set(I)V

    .line 77
    add-int/lit8 v0, v0, 0x1

    goto :goto_0

    .line 81
    :cond_0
    const/16 v0, 0x41

    :goto_1
    const/16 v1, 0x5a

    if-gt v0, v1, :cond_1

    .line 83
    sget-object v1, Lorg/apache/commons/mail/EmailUtils;->SAFE_URL:Ljava/util/BitSet;

    invoke-virtual {v1, v0}, Ljava/util/BitSet;->set(I)V

    .line 81
    add-int/lit8 v0, v0, 0x1

    goto :goto_1

    .line 86
    :cond_1
    const/16 v0, 0x30

    :goto_2
    const/16 v1, 0x39

    if-gt v0, v1, :cond_2

    .line 88
    sget-object v1, Lorg/apache/commons/mail/EmailUtils;->SAFE_URL:Ljava/util/BitSet;

    invoke-virtual {v1, v0}, Ljava/util/BitSet;->set(I)V

    .line 86
    add-int/lit8 v0, v0, 0x1

    goto :goto_2

    .line 92
    :cond_2
    sget-object v0, Lorg/apache/commons/mail/EmailUtils;->SAFE_URL:Ljava/util/BitSet;

    const/16 v1, 0x2d

    invoke-virtual {v0, v1}, Ljava/util/BitSet;->set(I)V

    .line 93
    sget-object v0, Lorg/apache/commons/mail/EmailUtils;->SAFE_URL:Ljava/util/BitSet;

    const/16 v1, 0x5f

    invoke-virtual {v0, v1}, Ljava/util/BitSet;->set(I)V

    .line 94
    sget-object v0, Lorg/apache/commons/mail/EmailUtils;->SAFE_URL:Ljava/util/BitSet;

    const/16 v1, 0x2e

    invoke-virtual {v0, v1}, Ljava/util/BitSet;->set(I)V

    .line 95
    sget-object v0, Lorg/apache/commons/mail/EmailUtils;->SAFE_URL:Ljava/util/BitSet;

    const/16 v1, 0x2a

    invoke-virtual {v0, v1}, Ljava/util/BitSet;->set(I)V

    .line 96
    sget-object v0, Lorg/apache/commons/mail/EmailUtils;->SAFE_URL:Ljava/util/BitSet;

    const/16 v1, 0x2b

    invoke-virtual {v0, v1}, Ljava/util/BitSet;->set(I)V

    .line 97
    sget-object v0, Lorg/apache/commons/mail/EmailUtils;->SAFE_URL:Ljava/util/BitSet;

    const/16 v1, 0x24

    invoke-virtual {v0, v1}, Ljava/util/BitSet;->set(I)V

    .line 98
    sget-object v0, Lorg/apache/commons/mail/EmailUtils;->SAFE_URL:Ljava/util/BitSet;

    const/16 v1, 0x21

    invoke-virtual {v0, v1}, Ljava/util/BitSet;->set(I)V

    .line 99
    sget-object v0, Lorg/apache/commons/mail/EmailUtils;->SAFE_URL:Ljava/util/BitSet;

    const/16 v1, 0x27

    invoke-virtual {v0, v1}, Ljava/util/BitSet;->set(I)V

    .line 100
    sget-object v0, Lorg/apache/commons/mail/EmailUtils;->SAFE_URL:Ljava/util/BitSet;

    const/16 v1, 0x28

    invoke-virtual {v0, v1}, Ljava/util/BitSet;->set(I)V

    .line 101
    sget-object v0, Lorg/apache/commons/mail/EmailUtils;->SAFE_URL:Ljava/util/BitSet;

    const/16 v1, 0x29

    invoke-virtual {v0, v1}, Ljava/util/BitSet;->set(I)V

    .line 102
    sget-object v0, Lorg/apache/commons/mail/EmailUtils;->SAFE_URL:Ljava/util/BitSet;

    const/16 v1, 0x2c

    invoke-virtual {v0, v1}, Ljava/util/BitSet;->set(I)V

    .line 103
    sget-object v0, Lorg/apache/commons/mail/EmailUtils;->SAFE_URL:Ljava/util/BitSet;

    const/16 v1, 0x40

    invoke-virtual {v0, v1}, Ljava/util/BitSet;->set(I)V

    .line 104
    return-void
.end method

.method private constructor <init>()V
    .locals 0

    .prologue
    .line 111
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    .line 112
    return-void
.end method

.method static encodeUrl(Ljava/lang/String;)Ljava/lang/String;
    .locals 7
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljava/io/UnsupportedEncodingException;
        }
    .end annotation

    .prologue
    const/16 v6, 0x10

    .line 283
    if-nez p0, :cond_0

    .line 285
    const/4 v0, 0x0

    .line 309
    :goto_0
    return-object v0

    .line 288
    :cond_0
    new-instance v2, Ljava/lang/StringBuilder;

    invoke-direct {v2}, Ljava/lang/StringBuilder;-><init>()V

    .line 289
    const-string v0, "US-ASCII"

    invoke-virtual {p0, v0}, Ljava/lang/String;->getBytes(Ljava/lang/String;)[B

    move-result-object v3

    array-length v4, v3

    const/4 v0, 0x0

    move v1, v0

    :goto_1
    if-ge v1, v4, :cond_3

    aget-byte v0, v3, v1

    .line 292
    if-gez v0, :cond_1

    .line 294
    add-int/lit16 v0, v0, 0x100

    .line 296
    :cond_1
    sget-object v5, Lorg/apache/commons/mail/EmailUtils;->SAFE_URL:Ljava/util/BitSet;

    invoke-virtual {v5, v0}, Ljava/util/BitSet;->get(I)Z

    move-result v5

    if-eqz v5, :cond_2

    .line 298
    int-to-char v0, v0

    invoke-virtual {v2, v0}, Ljava/lang/StringBuilder;->append(C)Ljava/lang/StringBuilder;

    .line 289
    :goto_2
    add-int/lit8 v0, v1, 0x1

    move v1, v0

    goto :goto_1

    .line 302
    :cond_2
    const/16 v5, 0x25

    invoke-virtual {v2, v5}, Ljava/lang/StringBuilder;->append(C)Ljava/lang/StringBuilder;

    .line 303
    shr-int/lit8 v5, v0, 0x4

    and-int/lit8 v5, v5, 0xf

    invoke-static {v5, v6}, Ljava/lang/Character;->forDigit(II)C

    move-result v5

    invoke-static {v5}, Ljava/lang/Character;->toUpperCase(C)C

    move-result v5

    .line 304
    and-int/lit8 v0, v0, 0xf

    invoke-static {v0, v6}, Ljava/lang/Character;->forDigit(II)C

    move-result v0

    invoke-static {v0}, Ljava/lang/Character;->toUpperCase(C)C

    move-result v0

    .line 305
    invoke-virtual {v2, v5}, Ljava/lang/StringBuilder;->append(C)Ljava/lang/StringBuilder;

    .line 306
    invoke-virtual {v2, v0}, Ljava/lang/StringBuilder;->append(C)Ljava/lang/StringBuilder;

    goto :goto_2

    .line 309
    :cond_3
    invoke-virtual {v2}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v0

    goto :goto_0
.end method

.method static isEmpty(Ljava/lang/String;)Z
    .locals 1

    .prologue
    .line 125
    if-eqz p0, :cond_0

    invoke-virtual {p0}, Ljava/lang/String;->length()I

    move-result v0

    if-nez v0, :cond_1

    :cond_0
    const/4 v0, 0x1

    :goto_0
    return v0

    :cond_1
    const/4 v0, 0x0

    goto :goto_0
.end method

.method static isNotEmpty(Ljava/lang/String;)Z
    .locals 1

    .prologue
    .line 139
    if-eqz p0, :cond_0

    invoke-virtual {p0}, Ljava/lang/String;->length()I

    move-result v0

    if-lez v0, :cond_0

    const/4 v0, 0x1

    :goto_0
    return v0

    :cond_0
    const/4 v0, 0x0

    goto :goto_0
.end method

.method static notNull(Ljava/lang/Object;Ljava/lang/String;)V
    .locals 1

    .prologue
    .line 155
    if-nez p0, :cond_0

    .line 157
    new-instance v0, Ljava/lang/IllegalArgumentException;

    invoke-direct {v0, p1}, Ljava/lang/IllegalArgumentException;-><init>(Ljava/lang/String;)V

    throw v0

    .line 159
    :cond_0
    return-void
.end method

.method private static random(IIIZZ[CLjava/util/Random;)Ljava/lang/String;
    .locals 5

    .prologue
    .line 222
    if-nez p0, :cond_0

    .line 224
    const-string v0, ""

    .line 270
    :goto_0
    return-object v0

    .line 226
    :cond_0
    if-gez p0, :cond_1

    .line 228
    new-instance v0, Ljava/lang/IllegalArgumentException;

    new-instance v1, Ljava/lang/StringBuilder;

    invoke-direct {v1}, Ljava/lang/StringBuilder;-><init>()V

    const-string v2, "Requested random string length "

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1, p0}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v1

    const-string v2, " is less than 0."

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v1

    invoke-direct {v0, v1}, Ljava/lang/IllegalArgumentException;-><init>(Ljava/lang/String;)V

    throw v0

    .line 231
    :cond_1
    if-nez p1, :cond_2

    if-nez p2, :cond_2

    .line 233
    const/16 p2, 0x7b

    .line 234
    const/16 p1, 0x20

    .line 236
    if-nez p3, :cond_2

    if-nez p4, :cond_2

    .line 238
    const/4 p1, 0x0

    .line 239
    const p2, 0x7fffffff

    .line 243
    :cond_2
    new-instance v2, Ljava/lang/StringBuffer;

    invoke-direct {v2}, Ljava/lang/StringBuffer;-><init>()V

    .line 244
    sub-int v3, p2, p1

    .line 246
    :goto_1
    add-int/lit8 v0, p0, -0x1

    if-eqz p0, :cond_9

    .line 250
    if-nez p5, :cond_7

    .line 252
    invoke-virtual {p6, v3}, Ljava/util/Random;->nextInt(I)I

    move-result v1

    add-int/2addr v1, p1

    int-to-char v1, v1

    .line 259
    :goto_2
    if-eqz p3, :cond_3

    if-eqz p4, :cond_3

    invoke-static {v1}, Ljava/lang/Character;->isLetterOrDigit(C)Z

    move-result v4

    if-nez v4, :cond_6

    :cond_3
    if-eqz p3, :cond_4

    invoke-static {v1}, Ljava/lang/Character;->isLetter(C)Z

    move-result v4

    if-nez v4, :cond_6

    :cond_4
    if-eqz p4, :cond_5

    invoke-static {v1}, Ljava/lang/Character;->isDigit(C)Z

    move-result v4

    if-nez v4, :cond_6

    :cond_5
    if-nez p3, :cond_8

    if-nez p4, :cond_8

    .line 262
    :cond_6
    invoke-virtual {v2, v1}, Ljava/lang/StringBuffer;->append(C)Ljava/lang/StringBuffer;

    :goto_3
    move p0, v0

    .line 268
    goto :goto_1

    .line 256
    :cond_7
    invoke-virtual {p6, v3}, Ljava/util/Random;->nextInt(I)I

    move-result v1

    add-int/2addr v1, p1

    aget-char v1, p5, v1

    goto :goto_2

    .line 266
    :cond_8
    add-int/lit8 v0, v0, 0x1

    goto :goto_3

    .line 270
    :cond_9
    invoke-virtual {v2}, Ljava/lang/StringBuffer;->toString()Ljava/lang/String;

    move-result-object v0

    goto :goto_0
.end method

.method static randomAlphabetic(I)Ljava/lang/String;
    .locals 7

    .prologue
    const/4 v1, 0x0

    .line 176
    const/4 v3, 0x1

    const/4 v5, 0x0

    sget-object v6, Lorg/apache/commons/mail/EmailUtils;->RANDOM:Ljava/util/Random;

    move v0, p0

    move v2, v1

    move v4, v1

    invoke-static/range {v0 .. v6}, Lorg/apache/commons/mail/EmailUtils;->random(IIIZZ[CLjava/util/Random;)Ljava/lang/String;

    move-result-object v0

    return-object v0
.end method

.method static writeMimeMessage(Ljava/io/File;Ljavax/mail/internet/MimeMessage;)V
    .locals 0
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljava/io/IOException;,
            Ljavax/mail/MessagingException;
        }
    .end annotation

    .prologue
    .line 323
    invoke-static {p1, p0}, Lorg/apache/commons/mail/b/b;->a(Ljavax/mail/internet/MimeMessage;Ljava/io/File;)V

    .line 324
    return-void
.end method
