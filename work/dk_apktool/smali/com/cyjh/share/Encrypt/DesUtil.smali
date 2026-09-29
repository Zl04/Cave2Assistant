.class public Lcom/cyjh/share/Encrypt/DesUtil;
.super Ljava/lang/Object;
.source "DesUtil.java"


# static fields
.field static iv:Ljava/security/spec/AlgorithmParameterSpec;

.field private static key:Ljava/security/Key;


# direct methods
.method static constructor <clinit>()V
    .locals 1

    .prologue
    const/4 v0, 0x0

    .line 22
    sput-object v0, Lcom/cyjh/share/Encrypt/DesUtil;->iv:Ljava/security/spec/AlgorithmParameterSpec;

    .line 23
    sput-object v0, Lcom/cyjh/share/Encrypt/DesUtil;->key:Ljava/security/Key;

    return-void
.end method

.method public constructor <init>()V
    .locals 0

    .prologue
    .line 16
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method

.method public static decode(Ljava/lang/String;[B[B)Ljava/lang/String;
    .locals 5
    .param p0, "data"    # Ljava/lang/String;
    .param p1, "DESkey"    # [B
    .param p2, "DESIV"    # [B
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljava/lang/Exception;
        }
    .end annotation

    .prologue
    .line 64
    invoke-static {p1, p2}, Lcom/cyjh/share/Encrypt/DesUtil;->init([B[B)V

    .line 65
    const-string v2, "DES/CBC/PKCS5Padding"

    invoke-static {v2}, Ljavax/crypto/Cipher;->getInstance(Ljava/lang/String;)Ljavax/crypto/Cipher;

    move-result-object v0

    .line 66
    .local v0, "deCipher":Ljavax/crypto/Cipher;
    const/4 v2, 0x2

    sget-object v3, Lcom/cyjh/share/Encrypt/DesUtil;->key:Ljava/security/Key;

    sget-object v4, Lcom/cyjh/share/Encrypt/DesUtil;->iv:Ljava/security/spec/AlgorithmParameterSpec;

    invoke-virtual {v0, v2, v3, v4}, Ljavax/crypto/Cipher;->init(ILjava/security/Key;Ljava/security/spec/AlgorithmParameterSpec;)V

    .line 67
    const/4 v2, 0x0

    invoke-static {p0, v2}, Landroid/util/Base64;->decode(Ljava/lang/String;I)[B

    move-result-object v2

    invoke-virtual {v0, v2}, Ljavax/crypto/Cipher;->doFinal([B)[B

    move-result-object v1

    .line 68
    .local v1, "pasByte":[B
    new-instance v2, Ljava/lang/String;

    const-string v3, "UTF-8"

    invoke-direct {v2, v1, v3}, Ljava/lang/String;-><init>([BLjava/lang/String;)V

    return-object v2
.end method

.method public static encode(Ljava/lang/String;[B[B)Ljava/lang/String;
    .locals 5
    .param p0, "data"    # Ljava/lang/String;
    .param p1, "DESkey"    # [B
    .param p2, "DESIV"    # [B
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljava/lang/Exception;
        }
    .end annotation

    .prologue
    .line 33
    invoke-static {p1, p2}, Lcom/cyjh/share/Encrypt/DesUtil;->init([B[B)V

    .line 34
    const-string v2, "DES/CBC/PKCS5Padding"

    invoke-static {v2}, Ljavax/crypto/Cipher;->getInstance(Ljava/lang/String;)Ljavax/crypto/Cipher;

    move-result-object v0

    .line 35
    .local v0, "enCipher":Ljavax/crypto/Cipher;
    const/4 v2, 0x1

    sget-object v3, Lcom/cyjh/share/Encrypt/DesUtil;->key:Ljava/security/Key;

    sget-object v4, Lcom/cyjh/share/Encrypt/DesUtil;->iv:Ljava/security/spec/AlgorithmParameterSpec;

    invoke-virtual {v0, v2, v3, v4}, Ljavax/crypto/Cipher;->init(ILjava/security/Key;Ljava/security/spec/AlgorithmParameterSpec;)V

    .line 36
    const-string v2, "utf-8"

    invoke-virtual {p0, v2}, Ljava/lang/String;->getBytes(Ljava/lang/String;)[B

    move-result-object v2

    invoke-virtual {v0, v2}, Ljavax/crypto/Cipher;->doFinal([B)[B

    move-result-object v1

    .line 37
    .local v1, "pasByte":[B
    const/4 v2, 0x2

    invoke-static {v1, v2}, Landroid/util/Base64;->encodeToString([BI)Ljava/lang/String;

    move-result-object v2

    return-object v2
.end method

.method private static init([B[B)V
    .locals 4
    .param p0, "DESkey"    # [B
    .param p1, "DESIV"    # [B

    .prologue
    .line 43
    :try_start_0
    new-instance v2, Ljavax/crypto/spec/DESKeySpec;

    invoke-direct {v2, p0}, Ljavax/crypto/spec/DESKeySpec;-><init>([B)V

    .line 44
    .local v2, "keySpec":Ljavax/crypto/spec/DESKeySpec;
    new-instance v3, Ljavax/crypto/spec/IvParameterSpec;

    invoke-direct {v3, p1}, Ljavax/crypto/spec/IvParameterSpec;-><init>([B)V

    sput-object v3, Lcom/cyjh/share/Encrypt/DesUtil;->iv:Ljava/security/spec/AlgorithmParameterSpec;

    .line 45
    const-string v3, "DES"

    invoke-static {v3}, Ljavax/crypto/SecretKeyFactory;->getInstance(Ljava/lang/String;)Ljavax/crypto/SecretKeyFactory;

    move-result-object v1

    .line 46
    .local v1, "keyFactory":Ljavax/crypto/SecretKeyFactory;
    invoke-virtual {v1, v2}, Ljavax/crypto/SecretKeyFactory;->generateSecret(Ljava/security/spec/KeySpec;)Ljavax/crypto/SecretKey;

    move-result-object v3

    sput-object v3, Lcom/cyjh/share/Encrypt/DesUtil;->key:Ljava/security/Key;
    :try_end_0
    .catch Ljava/security/InvalidKeyException; {:try_start_0 .. :try_end_0} :catch_0
    .catch Ljava/security/NoSuchAlgorithmException; {:try_start_0 .. :try_end_0} :catch_1
    .catch Ljava/security/spec/InvalidKeySpecException; {:try_start_0 .. :try_end_0} :catch_2

    .line 54
    .end local v1    # "keyFactory":Ljavax/crypto/SecretKeyFactory;
    .end local v2    # "keySpec":Ljavax/crypto/spec/DESKeySpec;
    :goto_0
    return-void

    .line 47
    :catch_0
    move-exception v0

    .line 48
    .local v0, "e":Ljava/security/InvalidKeyException;
    invoke-virtual {v0}, Ljava/security/InvalidKeyException;->printStackTrace()V

    goto :goto_0

    .line 49
    .end local v0    # "e":Ljava/security/InvalidKeyException;
    :catch_1
    move-exception v0

    .line 50
    .local v0, "e":Ljava/security/NoSuchAlgorithmException;
    invoke-virtual {v0}, Ljava/security/NoSuchAlgorithmException;->printStackTrace()V

    goto :goto_0

    .line 51
    .end local v0    # "e":Ljava/security/NoSuchAlgorithmException;
    :catch_2
    move-exception v0

    .line 52
    .local v0, "e":Ljava/security/spec/InvalidKeySpecException;
    invoke-virtual {v0}, Ljava/security/spec/InvalidKeySpecException;->printStackTrace()V

    goto :goto_0
.end method
