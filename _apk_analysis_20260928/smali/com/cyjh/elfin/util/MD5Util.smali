.class public Lcom/cyjh/elfin/util/MD5Util;
.super Ljava/lang/Object;
.source "MD5Util.java"


# direct methods
.method public constructor <init>()V
    .locals 0

    .prologue
    .line 15
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    .line 16
    return-void
.end method

.method public static final MD5(Ljava/lang/String;)Ljava/lang/String;
    .locals 13
    .param p0, "s"    # Ljava/lang/String;

    .prologue
    const/4 v11, 0x0

    .line 18
    if-nez p0, :cond_0

    .line 41
    :goto_0
    return-object v11

    .line 21
    :cond_0
    const/16 v12, 0x10

    new-array v2, v12, [C

    fill-array-data v2, :array_0

    .line 24
    .local v2, "hexDigits":[C
    :try_start_0
    invoke-virtual {p0}, Ljava/lang/String;->getBytes()[B

    move-result-object v1

    .line 25
    .local v1, "e":[B
    const-string v12, "MD5"

    invoke-static {v12}, Ljava/security/MessageDigest;->getInstance(Ljava/lang/String;)Ljava/security/MessageDigest;

    move-result-object v8

    .line 26
    .local v8, "mdInst":Ljava/security/MessageDigest;
    invoke-virtual {v8, v1}, Ljava/security/MessageDigest;->update([B)V

    .line 27
    invoke-virtual {v8}, Ljava/security/MessageDigest;->digest()[B

    move-result-object v7

    .line 28
    .local v7, "md":[B
    array-length v4, v7

    .line 29
    .local v4, "j":I
    mul-int/lit8 v12, v4, 0x2

    new-array v9, v12, [C

    .line 30
    .local v9, "str":[C
    const/4 v5, 0x0

    .line 32
    .local v5, "k":I
    const/4 v3, 0x0

    .local v3, "i":I
    move v6, v5

    .end local v5    # "k":I
    .local v6, "k":I
    :goto_1
    if-ge v3, v4, :cond_1

    .line 33
    aget-byte v0, v7, v3

    .line 34
    .local v0, "byte0":B
    add-int/lit8 v5, v6, 0x1

    .end local v6    # "k":I
    .restart local v5    # "k":I
    ushr-int/lit8 v12, v0, 0x4

    and-int/lit8 v12, v12, 0xf

    aget-char v12, v2, v12

    aput-char v12, v9, v6

    .line 35
    add-int/lit8 v6, v5, 0x1

    .end local v5    # "k":I
    .restart local v6    # "k":I
    and-int/lit8 v12, v0, 0xf

    aget-char v12, v2, v12

    aput-char v12, v9, v5

    .line 32
    add-int/lit8 v3, v3, 0x1

    goto :goto_1

    .line 38
    .end local v0    # "byte0":B
    :cond_1
    new-instance v12, Ljava/lang/String;

    invoke-direct {v12, v9}, Ljava/lang/String;-><init>([C)V
    :try_end_0
    .catch Ljava/lang/Exception; {:try_start_0 .. :try_end_0} :catch_0

    move-object v11, v12

    goto :goto_0

    .line 39
    .end local v1    # "e":[B
    .end local v3    # "i":I
    .end local v4    # "j":I
    .end local v6    # "k":I
    .end local v7    # "md":[B
    .end local v8    # "mdInst":Ljava/security/MessageDigest;
    .end local v9    # "str":[C
    :catch_0
    move-exception v10

    .line 40
    .local v10, "var10":Ljava/lang/Exception;
    invoke-virtual {v10}, Ljava/lang/Exception;->printStackTrace()V

    goto :goto_0

    .line 21
    nop

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
