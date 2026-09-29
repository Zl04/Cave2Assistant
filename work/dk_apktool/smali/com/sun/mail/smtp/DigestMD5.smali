.class public Lcom/sun/mail/smtp/DigestMD5;
.super Ljava/lang/Object;
.source "SourceFile"


# static fields
.field private static digits:[C


# instance fields
.field private clientResponse:Ljava/lang/String;

.field private debugout:Ljava/io/PrintStream;

.field private md5:Ljava/security/MessageDigest;

.field private uri:Ljava/lang/String;


# direct methods
.method static constructor <clinit>()V
    .locals 1

    .prologue
    .line 213
    const/16 v0, 0x10

    new-array v0, v0, [C

    fill-array-data v0, :array_0

    sput-object v0, Lcom/sun/mail/smtp/DigestMD5;->digits:[C

    .line 56
    return-void

    .line 213
    :array_0
    .array-data 2
        0x30s
        0x31s
        0x32s
        0x33s
        0x34s
        0x35s
        0x36s
        0x37s
        0x38s
        0x39s
        0x61s
        0x62s
        0x63s
        0x64s
        0x65s
        0x66s
    .end array-data
.end method

.method public constructor <init>(Ljava/io/PrintStream;)V
    .locals 1

    .prologue
    .line 63
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    .line 64
    iput-object p1, p0, Lcom/sun/mail/smtp/DigestMD5;->debugout:Ljava/io/PrintStream;

    .line 65
    if-eqz p1, :cond_0

    .line 66
    const-string v0, "DEBUG DIGEST-MD5: Loaded"

    invoke-virtual {p1, v0}, Ljava/io/PrintStream;->println(Ljava/lang/String;)V

    .line 67
    :cond_0
    return-void
.end method

.method private static toHex([B)Ljava/lang/String;
    .locals 7

    .prologue
    const/4 v0, 0x0

    .line 222
    array-length v1, p0

    mul-int/lit8 v1, v1, 0x2

    new-array v2, v1, [C

    move v1, v0

    .line 224
    :goto_0
    array-length v3, p0

    if-lt v1, v3, :cond_0

    .line 229
    new-instance v0, Ljava/lang/String;

    invoke-direct {v0, v2}, Ljava/lang/String;-><init>([C)V

    return-object v0

    .line 225
    :cond_0
    aget-byte v3, p0, v1

    and-int/lit16 v3, v3, 0xff

    .line 226
    add-int/lit8 v4, v0, 0x1

    sget-object v5, Lcom/sun/mail/smtp/DigestMD5;->digits:[C

    shr-int/lit8 v6, v3, 0x4

    aget-char v5, v5, v6

    aput-char v5, v2, v0

    .line 227
    add-int/lit8 v0, v4, 0x1

    sget-object v5, Lcom/sun/mail/smtp/DigestMD5;->digits:[C

    and-int/lit8 v3, v3, 0xf

    aget-char v3, v5, v3

    aput-char v3, v2, v4

    .line 224
    add-int/lit8 v1, v1, 0x1

    goto :goto_0
.end method

.method private tokenize(Ljava/lang/String;)Ljava/util/Hashtable;
    .locals 11
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljava/io/IOException;
        }
    .end annotation

    .prologue
    const/4 v1, 0x0

    const/16 v10, 0x39

    const/16 v9, 0x30

    .line 176
    new-instance v2, Ljava/util/Hashtable;

    invoke-direct {v2}, Ljava/util/Hashtable;-><init>()V

    .line 177
    invoke-virtual {p1}, Ljava/lang/String;->getBytes()[B

    move-result-object v0

    .line 181
    new-instance v3, Ljava/io/StreamTokenizer;

    .line 182
    new-instance v4, Ljava/io/InputStreamReader;

    .line 183
    new-instance v5, Lcom/sun/mail/util/BASE64DecoderStream;

    .line 184
    new-instance v6, Ljava/io/ByteArrayInputStream;

    const/4 v7, 0x4

    array-length v8, v0

    add-int/lit8 v8, v8, -0x4

    invoke-direct {v6, v0, v7, v8}, Ljava/io/ByteArrayInputStream;-><init>([BII)V

    .line 183
    invoke-direct {v5, v6}, Lcom/sun/mail/util/BASE64DecoderStream;-><init>(Ljava/io/InputStream;)V

    .line 182
    invoke-direct {v4, v5}, Ljava/io/InputStreamReader;-><init>(Ljava/io/InputStream;)V

    .line 181
    invoke-direct {v3, v4}, Ljava/io/StreamTokenizer;-><init>(Ljava/io/Reader;)V

    .line 187
    invoke-virtual {v3, v9, v10}, Ljava/io/StreamTokenizer;->ordinaryChars(II)V

    .line 188
    invoke-virtual {v3, v9, v10}, Ljava/io/StreamTokenizer;->wordChars(II)V

    move-object v0, v1

    .line 189
    :goto_0
    invoke-virtual {v3}, Ljava/io/StreamTokenizer;->nextToken()I

    move-result v4

    const/4 v5, -0x1

    if-ne v4, v5, :cond_0

    .line 210
    return-object v2

    .line 190
    :cond_0
    sparse-switch v4, :sswitch_data_0

    goto :goto_0

    .line 192
    :sswitch_0
    if-nez v0, :cond_1

    .line 193
    iget-object v0, v3, Ljava/io/StreamTokenizer;->sval:Ljava/lang/String;

    goto :goto_0

    .line 198
    :cond_1
    :sswitch_1
    iget-object v4, p0, Lcom/sun/mail/smtp/DigestMD5;->debugout:Ljava/io/PrintStream;

    if-eqz v4, :cond_2

    .line 199
    iget-object v4, p0, Lcom/sun/mail/smtp/DigestMD5;->debugout:Ljava/io/PrintStream;

    new-instance v5, Ljava/lang/StringBuilder;

    const-string v6, "DEBUG DIGEST-MD5: Received => "

    invoke-direct {v5, v6}, Ljava/lang/StringBuilder;-><init>(Ljava/lang/String;)V

    .line 200
    invoke-virtual {v5, v0}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v5

    const-string v6, "=\'"

    invoke-virtual {v5, v6}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v5

    iget-object v6, v3, Ljava/io/StreamTokenizer;->sval:Ljava/lang/String;

    invoke-virtual {v5, v6}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v5

    const-string v6, "\'"

    invoke-virtual {v5, v6}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v5

    invoke-virtual {v5}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v5

    .line 199
    invoke-virtual {v4, v5}, Ljava/io/PrintStream;->println(Ljava/lang/String;)V

    .line 201
    :cond_2
    invoke-virtual {v2, v0}, Ljava/util/Hashtable;->containsKey(Ljava/lang/Object;)Z

    move-result v4

    if-eqz v4, :cond_3

    .line 202
    new-instance v4, Ljava/lang/StringBuilder;

    invoke-direct {v4}, Ljava/lang/StringBuilder;-><init>()V

    invoke-virtual {v2, v0}, Ljava/util/Hashtable;->get(Ljava/lang/Object;)Ljava/lang/Object;

    move-result-object v5

    invoke-virtual {v4, v5}, Ljava/lang/StringBuilder;->append(Ljava/lang/Object;)Ljava/lang/StringBuilder;

    move-result-object v4

    const-string v5, ","

    invoke-virtual {v4, v5}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v4

    iget-object v5, v3, Ljava/io/StreamTokenizer;->sval:Ljava/lang/String;

    invoke-virtual {v4, v5}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v4

    invoke-virtual {v4}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v4

    invoke-virtual {v2, v0, v4}, Ljava/util/Hashtable;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    :goto_1
    move-object v0, v1

    .line 206
    goto :goto_0

    .line 204
    :cond_3
    iget-object v4, v3, Ljava/io/StreamTokenizer;->sval:Ljava/lang/String;

    invoke-virtual {v2, v0, v4}, Ljava/util/Hashtable;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    goto :goto_1

    .line 190
    :sswitch_data_0
    .sparse-switch
        -0x3 -> :sswitch_0
        0x22 -> :sswitch_1
    .end sparse-switch
.end method


# virtual methods
.method public authClient(Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;)[B
    .locals 12
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljava/io/IOException;
        }
    .end annotation

    .prologue
    .line 77
    new-instance v2, Ljava/io/ByteArrayOutputStream;

    invoke-direct {v2}, Ljava/io/ByteArrayOutputStream;-><init>()V

    .line 78
    new-instance v3, Lcom/sun/mail/util/BASE64EncoderStream;

    const v1, 0x7fffffff

    invoke-direct {v3, v2, v1}, Lcom/sun/mail/util/BASE64EncoderStream;-><init>(Ljava/io/OutputStream;I)V

    .line 82
    :try_start_0
    new-instance v4, Ljava/security/SecureRandom;

    invoke-direct {v4}, Ljava/security/SecureRandom;-><init>()V

    .line 83
    const-string v1, "MD5"

    invoke-static {v1}, Ljava/security/MessageDigest;->getInstance(Ljava/lang/String;)Ljava/security/MessageDigest;

    move-result-object v1

    iput-object v1, p0, Lcom/sun/mail/smtp/DigestMD5;->md5:Ljava/security/MessageDigest;
    :try_end_0
    .catch Ljava/security/NoSuchAlgorithmException; {:try_start_0 .. :try_end_0} :catch_0

    .line 89
    new-instance v5, Ljava/lang/StringBuffer;

    invoke-direct {v5}, Ljava/lang/StringBuffer;-><init>()V

    .line 91
    new-instance v1, Ljava/lang/StringBuilder;

    const-string v6, "smtp/"

    invoke-direct {v1, v6}, Ljava/lang/StringBuilder;-><init>(Ljava/lang/String;)V

    invoke-virtual {v1, p1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v1

    iput-object v1, p0, Lcom/sun/mail/smtp/DigestMD5;->uri:Ljava/lang/String;

    .line 92
    const-string v6, "00000001"

    .line 93
    const-string v7, "auth"

    .line 94
    const/16 v1, 0x20

    new-array v8, v1, [B

    .line 97
    iget-object v1, p0, Lcom/sun/mail/smtp/DigestMD5;->debugout:Ljava/io/PrintStream;

    if-eqz v1, :cond_0

    .line 98
    iget-object v1, p0, Lcom/sun/mail/smtp/DigestMD5;->debugout:Ljava/io/PrintStream;

    const-string v9, "DEBUG DIGEST-MD5: Begin authentication ..."

    invoke-virtual {v1, v9}, Ljava/io/PrintStream;->println(Ljava/lang/String;)V

    .line 101
    :cond_0
    move-object/from16 v0, p5

    invoke-direct {p0, v0}, Lcom/sun/mail/smtp/DigestMD5;->tokenize(Ljava/lang/String;)Ljava/util/Hashtable;

    move-result-object v9

    .line 103
    if-nez p4, :cond_4

    .line 104
    const-string v1, "realm"

    invoke-virtual {v9, v1}, Ljava/util/Hashtable;->get(Ljava/lang/Object;)Ljava/lang/Object;

    move-result-object v1

    check-cast v1, Ljava/lang/String;

    .line 105
    if-eqz v1, :cond_1

    new-instance v10, Ljava/util/StringTokenizer;

    const-string v11, ","

    invoke-direct {v10, v1, v11}, Ljava/util/StringTokenizer;-><init>(Ljava/lang/String;Ljava/lang/String;)V

    invoke-virtual {v10}, Ljava/util/StringTokenizer;->nextToken()Ljava/lang/String;

    move-result-object p1

    .line 110
    :cond_1
    :goto_0
    const-string v1, "nonce"

    invoke-virtual {v9, v1}, Ljava/util/Hashtable;->get(Ljava/lang/Object;)Ljava/lang/Object;

    move-result-object v1

    check-cast v1, Ljava/lang/String;

    .line 112
    invoke-virtual {v4, v8}, Ljava/security/SecureRandom;->nextBytes([B)V

    .line 113
    invoke-virtual {v3, v8}, Ljava/io/OutputStream;->write([B)V

    .line 114
    invoke-virtual {v3}, Ljava/io/OutputStream;->flush()V

    .line 117
    invoke-virtual {v2}, Ljava/io/ByteArrayOutputStream;->toString()Ljava/lang/String;

    move-result-object v4

    .line 118
    invoke-virtual {v2}, Ljava/io/ByteArrayOutputStream;->reset()V

    .line 121
    iget-object v8, p0, Lcom/sun/mail/smtp/DigestMD5;->md5:Ljava/security/MessageDigest;

    iget-object v9, p0, Lcom/sun/mail/smtp/DigestMD5;->md5:Ljava/security/MessageDigest;

    .line 122
    new-instance v10, Ljava/lang/StringBuilder;

    invoke-static {p2}, Ljava/lang/String;->valueOf(Ljava/lang/Object;)Ljava/lang/String;

    move-result-object v11

    invoke-direct {v10, v11}, Ljava/lang/StringBuilder;-><init>(Ljava/lang/String;)V

    const-string v11, ":"

    invoke-virtual {v10, v11}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v10

    invoke-virtual {v10, p1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v10

    const-string v11, ":"

    invoke-virtual {v10, v11}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v10

    invoke-virtual {v10, p3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v10

    invoke-virtual {v10}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v10

    invoke-static {v10}, Lcom/sun/mail/util/ASCIIUtility;->getBytes(Ljava/lang/String;)[B

    move-result-object v10

    .line 121
    invoke-virtual {v9, v10}, Ljava/security/MessageDigest;->digest([B)[B

    move-result-object v9

    invoke-virtual {v8, v9}, Ljava/security/MessageDigest;->update([B)V

    .line 123
    iget-object v8, p0, Lcom/sun/mail/smtp/DigestMD5;->md5:Ljava/security/MessageDigest;

    new-instance v9, Ljava/lang/StringBuilder;

    const-string v10, ":"

    invoke-direct {v9, v10}, Ljava/lang/StringBuilder;-><init>(Ljava/lang/String;)V

    invoke-virtual {v9, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v9

    const-string v10, ":"

    invoke-virtual {v9, v10}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v9

    invoke-virtual {v9, v4}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v9

    invoke-virtual {v9}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v9

    invoke-static {v9}, Lcom/sun/mail/util/ASCIIUtility;->getBytes(Ljava/lang/String;)[B

    move-result-object v9

    invoke-virtual {v8, v9}, Ljava/security/MessageDigest;->update([B)V

    .line 124
    new-instance v8, Ljava/lang/StringBuilder;

    iget-object v9, p0, Lcom/sun/mail/smtp/DigestMD5;->md5:Ljava/security/MessageDigest;

    invoke-virtual {v9}, Ljava/security/MessageDigest;->digest()[B

    move-result-object v9

    invoke-static {v9}, Lcom/sun/mail/smtp/DigestMD5;->toHex([B)Ljava/lang/String;

    move-result-object v9

    invoke-static {v9}, Ljava/lang/String;->valueOf(Ljava/lang/Object;)Ljava/lang/String;

    move-result-object v9

    invoke-direct {v8, v9}, Ljava/lang/StringBuilder;-><init>(Ljava/lang/String;)V

    .line 125
    const-string v9, ":"

    invoke-virtual {v8, v9}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v8

    invoke-virtual {v8, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v8

    const-string v9, ":"

    invoke-virtual {v8, v9}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v8

    invoke-virtual {v8, v6}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v8

    const-string v9, ":"

    invoke-virtual {v8, v9}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v8

    invoke-virtual {v8, v4}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v8

    const-string v9, ":"

    invoke-virtual {v8, v9}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v8

    invoke-virtual {v8, v7}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v8

    const-string v9, ":"

    invoke-virtual {v8, v9}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v8

    invoke-virtual {v8}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v8

    .line 124
    iput-object v8, p0, Lcom/sun/mail/smtp/DigestMD5;->clientResponse:Ljava/lang/String;

    .line 128
    iget-object v8, p0, Lcom/sun/mail/smtp/DigestMD5;->md5:Ljava/security/MessageDigest;

    new-instance v9, Ljava/lang/StringBuilder;

    const-string v10, "AUTHENTICATE:"

    invoke-direct {v9, v10}, Ljava/lang/StringBuilder;-><init>(Ljava/lang/String;)V

    iget-object v10, p0, Lcom/sun/mail/smtp/DigestMD5;->uri:Ljava/lang/String;

    invoke-virtual {v9, v10}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v9

    invoke-virtual {v9}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v9

    invoke-static {v9}, Lcom/sun/mail/util/ASCIIUtility;->getBytes(Ljava/lang/String;)[B

    move-result-object v9

    invoke-virtual {v8, v9}, Ljava/security/MessageDigest;->update([B)V

    .line 129
    iget-object v8, p0, Lcom/sun/mail/smtp/DigestMD5;->md5:Ljava/security/MessageDigest;

    new-instance v9, Ljava/lang/StringBuilder;

    iget-object v10, p0, Lcom/sun/mail/smtp/DigestMD5;->clientResponse:Ljava/lang/String;

    invoke-static {v10}, Ljava/lang/String;->valueOf(Ljava/lang/Object;)Ljava/lang/String;

    move-result-object v10

    invoke-direct {v9, v10}, Ljava/lang/StringBuilder;-><init>(Ljava/lang/String;)V

    iget-object v10, p0, Lcom/sun/mail/smtp/DigestMD5;->md5:Ljava/security/MessageDigest;

    invoke-virtual {v10}, Ljava/security/MessageDigest;->digest()[B

    move-result-object v10

    invoke-static {v10}, Lcom/sun/mail/smtp/DigestMD5;->toHex([B)Ljava/lang/String;

    move-result-object v10

    invoke-virtual {v9, v10}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v9

    invoke-virtual {v9}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v9

    invoke-static {v9}, Lcom/sun/mail/util/ASCIIUtility;->getBytes(Ljava/lang/String;)[B

    move-result-object v9

    invoke-virtual {v8, v9}, Ljava/security/MessageDigest;->update([B)V

    .line 132
    new-instance v8, Ljava/lang/StringBuilder;

    const-string v9, "username=\""

    invoke-direct {v8, v9}, Ljava/lang/StringBuilder;-><init>(Ljava/lang/String;)V

    invoke-virtual {v8, p2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v8

    const-string v9, "\""

    invoke-virtual {v8, v9}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v8

    invoke-virtual {v8}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v8

    invoke-virtual {v5, v8}, Ljava/lang/StringBuffer;->append(Ljava/lang/String;)Ljava/lang/StringBuffer;

    .line 133
    new-instance v8, Ljava/lang/StringBuilder;

    const-string v9, ",realm=\""

    invoke-direct {v8, v9}, Ljava/lang/StringBuilder;-><init>(Ljava/lang/String;)V

    invoke-virtual {v8, p1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v8

    const-string v9, "\""

    invoke-virtual {v8, v9}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v8

    invoke-virtual {v8}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v8

    invoke-virtual {v5, v8}, Ljava/lang/StringBuffer;->append(Ljava/lang/String;)Ljava/lang/StringBuffer;

    .line 134
    new-instance v8, Ljava/lang/StringBuilder;

    const-string v9, ",qop="

    invoke-direct {v8, v9}, Ljava/lang/StringBuilder;-><init>(Ljava/lang/String;)V

    invoke-virtual {v8, v7}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v7

    invoke-virtual {v7}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v7

    invoke-virtual {v5, v7}, Ljava/lang/StringBuffer;->append(Ljava/lang/String;)Ljava/lang/StringBuffer;

    .line 135
    new-instance v7, Ljava/lang/StringBuilder;

    const-string v8, ",nc="

    invoke-direct {v7, v8}, Ljava/lang/StringBuilder;-><init>(Ljava/lang/String;)V

    invoke-virtual {v7, v6}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v6

    invoke-virtual {v6}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v6

    invoke-virtual {v5, v6}, Ljava/lang/StringBuffer;->append(Ljava/lang/String;)Ljava/lang/StringBuffer;

    .line 136
    new-instance v6, Ljava/lang/StringBuilder;

    const-string v7, ",nonce=\""

    invoke-direct {v6, v7}, Ljava/lang/StringBuilder;-><init>(Ljava/lang/String;)V

    invoke-virtual {v6, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    const-string v6, "\""

    invoke-virtual {v1, v6}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v1

    invoke-virtual {v5, v1}, Ljava/lang/StringBuffer;->append(Ljava/lang/String;)Ljava/lang/StringBuffer;

    .line 137
    new-instance v1, Ljava/lang/StringBuilder;

    const-string v6, ",cnonce=\""

    invoke-direct {v1, v6}, Ljava/lang/StringBuilder;-><init>(Ljava/lang/String;)V

    invoke-virtual {v1, v4}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    const-string v4, "\""

    invoke-virtual {v1, v4}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v1

    invoke-virtual {v5, v1}, Ljava/lang/StringBuffer;->append(Ljava/lang/String;)Ljava/lang/StringBuffer;

    .line 138
    new-instance v1, Ljava/lang/StringBuilder;

    const-string v4, ",digest-uri=\""

    invoke-direct {v1, v4}, Ljava/lang/StringBuilder;-><init>(Ljava/lang/String;)V

    iget-object v4, p0, Lcom/sun/mail/smtp/DigestMD5;->uri:Ljava/lang/String;

    invoke-virtual {v1, v4}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    const-string v4, "\""

    invoke-virtual {v1, v4}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v1

    invoke-virtual {v5, v1}, Ljava/lang/StringBuffer;->append(Ljava/lang/String;)Ljava/lang/StringBuffer;

    .line 139
    new-instance v1, Ljava/lang/StringBuilder;

    const-string v4, ",response="

    invoke-direct {v1, v4}, Ljava/lang/StringBuilder;-><init>(Ljava/lang/String;)V

    iget-object v4, p0, Lcom/sun/mail/smtp/DigestMD5;->md5:Ljava/security/MessageDigest;

    invoke-virtual {v4}, Ljava/security/MessageDigest;->digest()[B

    move-result-object v4

    invoke-static {v4}, Lcom/sun/mail/smtp/DigestMD5;->toHex([B)Ljava/lang/String;

    move-result-object v4

    invoke-virtual {v1, v4}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v1

    invoke-virtual {v5, v1}, Ljava/lang/StringBuffer;->append(Ljava/lang/String;)Ljava/lang/StringBuffer;

    .line 141
    iget-object v1, p0, Lcom/sun/mail/smtp/DigestMD5;->debugout:Ljava/io/PrintStream;

    if-eqz v1, :cond_2

    .line 142
    iget-object v1, p0, Lcom/sun/mail/smtp/DigestMD5;->debugout:Ljava/io/PrintStream;

    new-instance v4, Ljava/lang/StringBuilder;

    const-string v6, "DEBUG DIGEST-MD5: Response => "

    invoke-direct {v4, v6}, Ljava/lang/StringBuilder;-><init>(Ljava/lang/String;)V

    .line 143
    invoke-virtual {v5}, Ljava/lang/StringBuffer;->toString()Ljava/lang/String;

    move-result-object v6

    invoke-virtual {v4, v6}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v4

    invoke-virtual {v4}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v4

    .line 142
    invoke-virtual {v1, v4}, Ljava/io/PrintStream;->println(Ljava/lang/String;)V

    .line 144
    :cond_2
    invoke-virtual {v5}, Ljava/lang/StringBuffer;->toString()Ljava/lang/String;

    move-result-object v1

    invoke-static {v1}, Lcom/sun/mail/util/ASCIIUtility;->getBytes(Ljava/lang/String;)[B

    move-result-object v1

    invoke-virtual {v3, v1}, Ljava/io/OutputStream;->write([B)V

    .line 145
    invoke-virtual {v3}, Ljava/io/OutputStream;->flush()V

    .line 146
    invoke-virtual {v2}, Ljava/io/ByteArrayOutputStream;->toByteArray()[B

    move-result-object v1

    return-object v1

    .line 84
    :catch_0
    move-exception v1

    .line 85
    iget-object v2, p0, Lcom/sun/mail/smtp/DigestMD5;->debugout:Ljava/io/PrintStream;

    if-eqz v2, :cond_3

    .line 86
    iget-object v2, p0, Lcom/sun/mail/smtp/DigestMD5;->debugout:Ljava/io/PrintStream;

    new-instance v3, Ljava/lang/StringBuilder;

    const-string v4, "DEBUG DIGEST-MD5: "

    invoke-direct {v3, v4}, Ljava/lang/StringBuilder;-><init>(Ljava/lang/String;)V

    invoke-virtual {v3, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/Object;)Ljava/lang/StringBuilder;

    move-result-object v3

    invoke-virtual {v3}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v3

    invoke-virtual {v2, v3}, Ljava/io/PrintStream;->println(Ljava/lang/String;)V

    .line 87
    :cond_3
    new-instance v2, Ljava/io/IOException;

    invoke-virtual {v1}, Ljava/security/NoSuchAlgorithmException;->toString()Ljava/lang/String;

    move-result-object v1

    invoke-direct {v2, v1}, Ljava/io/IOException;-><init>(Ljava/lang/String;)V

    throw v2

    :cond_4
    move-object/from16 p1, p4

    goto/16 :goto_0
.end method

.method public authServer(Ljava/lang/String;)Z
    .locals 4
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljava/io/IOException;
        }
    .end annotation

    .prologue
    .line 156
    invoke-direct {p0, p1}, Lcom/sun/mail/smtp/DigestMD5;->tokenize(Ljava/lang/String;)Ljava/util/Hashtable;

    move-result-object v0

    .line 158
    iget-object v1, p0, Lcom/sun/mail/smtp/DigestMD5;->md5:Ljava/security/MessageDigest;

    new-instance v2, Ljava/lang/StringBuilder;

    const-string v3, ":"

    invoke-direct {v2, v3}, Ljava/lang/StringBuilder;-><init>(Ljava/lang/String;)V

    iget-object v3, p0, Lcom/sun/mail/smtp/DigestMD5;->uri:Ljava/lang/String;

    invoke-virtual {v2, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    invoke-virtual {v2}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v2

    invoke-static {v2}, Lcom/sun/mail/util/ASCIIUtility;->getBytes(Ljava/lang/String;)[B

    move-result-object v2

    invoke-virtual {v1, v2}, Ljava/security/MessageDigest;->update([B)V

    .line 159
    iget-object v1, p0, Lcom/sun/mail/smtp/DigestMD5;->md5:Ljava/security/MessageDigest;

    new-instance v2, Ljava/lang/StringBuilder;

    iget-object v3, p0, Lcom/sun/mail/smtp/DigestMD5;->clientResponse:Ljava/lang/String;

    invoke-static {v3}, Ljava/lang/String;->valueOf(Ljava/lang/Object;)Ljava/lang/String;

    move-result-object v3

    invoke-direct {v2, v3}, Ljava/lang/StringBuilder;-><init>(Ljava/lang/String;)V

    iget-object v3, p0, Lcom/sun/mail/smtp/DigestMD5;->md5:Ljava/security/MessageDigest;

    invoke-virtual {v3}, Ljava/security/MessageDigest;->digest()[B

    move-result-object v3

    invoke-static {v3}, Lcom/sun/mail/smtp/DigestMD5;->toHex([B)Ljava/lang/String;

    move-result-object v3

    invoke-virtual {v2, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    invoke-virtual {v2}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v2

    invoke-static {v2}, Lcom/sun/mail/util/ASCIIUtility;->getBytes(Ljava/lang/String;)[B

    move-result-object v2

    invoke-virtual {v1, v2}, Ljava/security/MessageDigest;->update([B)V

    .line 160
    iget-object v1, p0, Lcom/sun/mail/smtp/DigestMD5;->md5:Ljava/security/MessageDigest;

    invoke-virtual {v1}, Ljava/security/MessageDigest;->digest()[B

    move-result-object v1

    invoke-static {v1}, Lcom/sun/mail/smtp/DigestMD5;->toHex([B)Ljava/lang/String;

    move-result-object v1

    .line 161
    const-string v2, "rspauth"

    invoke-virtual {v0, v2}, Ljava/util/Hashtable;->get(Ljava/lang/Object;)Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Ljava/lang/String;

    invoke-virtual {v1, v0}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v0

    if-nez v0, :cond_1

    .line 162
    iget-object v0, p0, Lcom/sun/mail/smtp/DigestMD5;->debugout:Ljava/io/PrintStream;

    if-eqz v0, :cond_0

    .line 163
    iget-object v0, p0, Lcom/sun/mail/smtp/DigestMD5;->debugout:Ljava/io/PrintStream;

    new-instance v2, Ljava/lang/StringBuilder;

    const-string v3, "DEBUG DIGEST-MD5: Expected => rspauth="

    invoke-direct {v2, v3}, Ljava/lang/StringBuilder;-><init>(Ljava/lang/String;)V

    .line 164
    invoke-virtual {v2, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v1

    .line 163
    invoke-virtual {v0, v1}, Ljava/io/PrintStream;->println(Ljava/lang/String;)V

    .line 165
    :cond_0
    const/4 v0, 0x0

    .line 167
    :goto_0
    return v0

    :cond_1
    const/4 v0, 0x1

    goto :goto_0
.end method
