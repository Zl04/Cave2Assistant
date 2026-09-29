.class public Lcom/umeng/commonsdk/statistics/common/DeviceConfig;
.super Ljava/lang/Object;
.source "DeviceConfig.java"


# static fields
.field public static final DEFAULT_TIMEZONE:I = 0x8

.field private static final KEY_EMUI_VERSION_CODE:Ljava/lang/String; = "ro.build.hw_emui_api_level"

.field private static final KEY_MIUI_VERSION_NAME:Ljava/lang/String; = "ro.miui.ui.version.name"

.field protected static final LOG_TAG:Ljava/lang/String;

.field public static final MOBILE_NETWORK:Ljava/lang/String; = "2G/3G"

.field public static final UNKNOW:Ljava/lang/String; = ""

.field public static final WIFI:Ljava/lang/String; = "Wi-Fi"


# direct methods
.method static constructor <clinit>()V
    .locals 1

    .prologue
    .line 67
    const-class v0, Lcom/umeng/commonsdk/statistics/common/DeviceConfig;

    invoke-virtual {v0}, Ljava/lang/Class;->getName()Ljava/lang/String;

    move-result-object v0

    sput-object v0, Lcom/umeng/commonsdk/statistics/common/DeviceConfig;->LOG_TAG:Ljava/lang/String;

    return-void
.end method

.method public constructor <init>()V
    .locals 0

    .prologue
    .line 66
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method

.method private static byte2HexFormatted([B)Ljava/lang/String;
    .locals 6

    .prologue
    .line 932
    new-instance v2, Ljava/lang/StringBuilder;

    array-length v0, p0

    mul-int/lit8 v0, v0, 0x2

    invoke-direct {v2, v0}, Ljava/lang/StringBuilder;-><init>(I)V

    .line 933
    const/4 v0, 0x0

    :goto_0
    array-length v1, p0

    if-ge v0, v1, :cond_3

    .line 934
    aget-byte v1, p0, v0

    invoke-static {v1}, Ljava/lang/Integer;->toHexString(I)Ljava/lang/String;

    move-result-object v1

    .line 935
    invoke-virtual {v1}, Ljava/lang/String;->length()I

    move-result v3

    .line 936
    const/4 v4, 0x1

    if-ne v3, v4, :cond_0

    .line 937
    new-instance v4, Ljava/lang/StringBuilder;

    invoke-direct {v4}, Ljava/lang/StringBuilder;-><init>()V

    const-string v5, "0"

    invoke-virtual {v4, v5}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v4

    invoke-virtual {v4, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v1

    .line 938
    :cond_0
    const/4 v4, 0x2

    if-le v3, v4, :cond_1

    .line 939
    add-int/lit8 v4, v3, -0x2

    invoke-virtual {v1, v4, v3}, Ljava/lang/String;->substring(II)Ljava/lang/String;

    move-result-object v1

    .line 940
    :cond_1
    invoke-static {}, Ljava/util/Locale;->getDefault()Ljava/util/Locale;

    move-result-object v3

    invoke-virtual {v1, v3}, Ljava/lang/String;->toUpperCase(Ljava/util/Locale;)Ljava/lang/String;

    move-result-object v1

    invoke-virtual {v2, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    .line 941
    array-length v1, p0

    add-int/lit8 v1, v1, -0x1

    if-ge v0, v1, :cond_2

    .line 942
    const/16 v1, 0x3a

    invoke-virtual {v2, v1}, Ljava/lang/StringBuilder;->append(C)Ljava/lang/StringBuilder;

    .line 933
    :cond_2
    add-int/lit8 v0, v0, 0x1

    goto :goto_0

    .line 944
    :cond_3
    invoke-virtual {v2}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v0

    return-object v0
.end method

.method public static checkPermission(Landroid/content/Context;Ljava/lang/String;)Z
    .locals 7

    .prologue
    const/4 v1, 0x1

    const/4 v2, 0x0

    .line 179
    .line 180
    if-nez p0, :cond_1

    .line 202
    :cond_0
    :goto_0
    return v2

    .line 183
    :cond_1
    sget v0, Landroid/os/Build$VERSION;->SDK_INT:I

    const/16 v3, 0x17

    if-lt v0, v3, :cond_3

    .line 185
    :try_start_0
    const-string v0, "android.content.Context"

    invoke-static {v0}, Ljava/lang/Class;->forName(Ljava/lang/String;)Ljava/lang/Class;

    move-result-object v0

    .line 186
    const-string v3, "checkSelfPermission"

    const/4 v4, 0x1

    new-array v4, v4, [Ljava/lang/Class;

    const/4 v5, 0x0

    const-class v6, Ljava/lang/String;

    aput-object v6, v4, v5

    invoke-virtual {v0, v3, v4}, Ljava/lang/Class;->getMethod(Ljava/lang/String;[Ljava/lang/Class;)Ljava/lang/reflect/Method;

    move-result-object v0

    .line 187
    const/4 v3, 0x1

    new-array v3, v3, [Ljava/lang/Object;

    const/4 v4, 0x0

    aput-object p1, v3, v4

    invoke-virtual {v0, p0, v3}, Ljava/lang/reflect/Method;->invoke(Ljava/lang/Object;[Ljava/lang/Object;)Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Ljava/lang/Integer;

    invoke-virtual {v0}, Ljava/lang/Integer;->intValue()I
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_0

    move-result v0

    .line 188
    if-nez v0, :cond_2

    move v0, v1

    :goto_1
    move v2, v0

    .line 195
    goto :goto_0

    :cond_2
    move v0, v2

    .line 191
    goto :goto_1

    .line 197
    :cond_3
    invoke-virtual {p0}, Landroid/content/Context;->getPackageManager()Landroid/content/pm/PackageManager;

    move-result-object v0

    .line 198
    invoke-virtual {p0}, Landroid/content/Context;->getPackageName()Ljava/lang/String;

    move-result-object v3

    invoke-virtual {v0, p1, v3}, Landroid/content/pm/PackageManager;->checkPermission(Ljava/lang/String;Ljava/lang/String;)I

    move-result v0

    if-nez v0, :cond_0

    move v2, v1

    .line 199
    goto :goto_0

    .line 193
    :catch_0
    move-exception v0

    goto :goto_0
.end method

.method public static getAndroidId(Landroid/content/Context;)Ljava/lang/String;
    .locals 3

    .prologue
    .line 94
    const/4 v0, 0x0

    .line 95
    if-eqz p0, :cond_0

    .line 97
    :try_start_0
    invoke-virtual {p0}, Landroid/content/Context;->getContentResolver()Landroid/content/ContentResolver;

    move-result-object v1

    const-string v2, "android_id"

    invoke-static {v1, v2}, Landroid/provider/Settings$Secure;->getString(Landroid/content/ContentResolver;Ljava/lang/String;)Ljava/lang/String;
    :try_end_0
    .catch Ljava/lang/Exception; {:try_start_0 .. :try_end_0} :catch_0

    move-result-object v0

    .line 105
    :cond_0
    :goto_0
    return-object v0

    .line 98
    :catch_0
    move-exception v1

    .line 99
    sget-boolean v1, Lcom/umeng/commonsdk/statistics/b;->f:Z

    if-eqz v1, :cond_0

    .line 101
    const-string v1, "can\'t read android id"

    invoke-static {v1}, Lcom/umeng/commonsdk/statistics/common/MLog;->w(Ljava/lang/String;)V

    goto :goto_0
.end method

.method public static getAppHashKey(Landroid/content/Context;)Ljava/lang/String;
    .locals 4

    .prologue
    const/4 v3, 0x0

    .line 889
    :try_start_0
    invoke-virtual {p0}, Landroid/content/Context;->getPackageManager()Landroid/content/pm/PackageManager;

    move-result-object v0

    .line 890
    const/16 v1, 0x40

    .line 891
    invoke-static {p0}, Lcom/umeng/commonsdk/statistics/common/DeviceConfig;->getPackageName(Landroid/content/Context;)Ljava/lang/String;

    move-result-object v2

    invoke-virtual {v0, v2, v1}, Landroid/content/pm/PackageManager;->getPackageInfo(Ljava/lang/String;I)Landroid/content/pm/PackageInfo;

    move-result-object v0

    .line 892
    iget-object v0, v0, Landroid/content/pm/PackageInfo;->signatures:[Landroid/content/pm/Signature;

    array-length v1, v0

    const/4 v2, 0x0

    if-ge v3, v1, :cond_0

    aget-object v0, v0, v2

    .line 893
    const-string v1, "SHA"

    invoke-static {v1}, Ljava/security/MessageDigest;->getInstance(Ljava/lang/String;)Ljava/security/MessageDigest;

    move-result-object v1

    .line 894
    invoke-virtual {v0}, Landroid/content/pm/Signature;->toByteArray()[B

    move-result-object v0

    invoke-virtual {v1, v0}, Ljava/security/MessageDigest;->update([B)V

    .line 895
    invoke-virtual {v1}, Ljava/security/MessageDigest;->digest()[B

    move-result-object v0

    const/4 v1, 0x0

    invoke-static {v0, v1}, Landroid/util/Base64;->encodeToString([BI)Ljava/lang/String;

    move-result-object v0

    invoke-virtual {v0}, Ljava/lang/String;->trim()Ljava/lang/String;
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_0

    move-result-object v0

    .line 899
    :goto_0
    return-object v0

    .line 897
    :catch_0
    move-exception v0

    .line 899
    :cond_0
    const/4 v0, 0x0

    goto :goto_0
.end method

.method public static getAppMD5Signature(Landroid/content/Context;)Ljava/lang/String;
    .locals 4

    .prologue
    .line 909
    const/4 v1, 0x0

    .line 910
    if-nez p0, :cond_0

    .line 928
    :goto_0
    return-object v1

    .line 914
    :cond_0
    :try_start_0
    invoke-virtual {p0}, Landroid/content/Context;->getPackageManager()Landroid/content/pm/PackageManager;

    move-result-object v0

    .line 915
    const/16 v2, 0x40

    .line 916
    invoke-static {p0}, Lcom/umeng/commonsdk/statistics/common/DeviceConfig;->getPackageName(Landroid/content/Context;)Ljava/lang/String;

    move-result-object v3

    invoke-virtual {v0, v3, v2}, Landroid/content/pm/PackageManager;->getPackageInfo(Ljava/lang/String;I)Landroid/content/pm/PackageInfo;

    move-result-object v0

    .line 917
    iget-object v0, v0, Landroid/content/pm/PackageInfo;->signatures:[Landroid/content/pm/Signature;

    .line 918
    const/4 v2, 0x0

    aget-object v0, v0, v2

    invoke-virtual {v0}, Landroid/content/pm/Signature;->toByteArray()[B

    move-result-object v0

    .line 919
    new-instance v2, Ljava/io/ByteArrayInputStream;

    invoke-direct {v2, v0}, Ljava/io/ByteArrayInputStream;-><init>([B)V

    .line 920
    const-string v0, "X509"

    invoke-static {v0}, Ljava/security/cert/CertificateFactory;->getInstance(Ljava/lang/String;)Ljava/security/cert/CertificateFactory;

    move-result-object v0

    .line 921
    invoke-virtual {v0, v2}, Ljava/security/cert/CertificateFactory;->generateCertificate(Ljava/io/InputStream;)Ljava/security/cert/Certificate;

    move-result-object v0

    check-cast v0, Ljava/security/cert/X509Certificate;

    .line 923
    const-string v2, "MD5"

    invoke-static {v2}, Ljava/security/MessageDigest;->getInstance(Ljava/lang/String;)Ljava/security/MessageDigest;

    move-result-object v2

    .line 924
    invoke-virtual {v0}, Ljava/security/cert/X509Certificate;->getEncoded()[B

    move-result-object v0

    invoke-virtual {v2, v0}, Ljava/security/MessageDigest;->digest([B)[B

    move-result-object v0

    .line 925
    invoke-static {v0}, Lcom/umeng/commonsdk/statistics/common/DeviceConfig;->byte2HexFormatted([B)Ljava/lang/String;
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_0

    move-result-object v0

    :goto_1
    move-object v1, v0

    .line 928
    goto :goto_0

    .line 926
    :catch_0
    move-exception v0

    move-object v0, v1

    goto :goto_1
.end method

.method public static getAppName(Landroid/content/Context;)Ljava/lang/String;
    .locals 4

    .prologue
    .line 966
    const/4 v0, 0x0

    .line 967
    if-nez p0, :cond_1

    .line 977
    :cond_0
    :goto_0
    return-object v0

    .line 971
    :cond_1
    :try_start_0
    invoke-virtual {p0}, Landroid/content/Context;->getPackageManager()Landroid/content/pm/PackageManager;

    move-result-object v1

    invoke-virtual {p0}, Landroid/content/Context;->getPackageName()Ljava/lang/String;

    move-result-object v2

    const/4 v3, 0x0

    invoke-virtual {v1, v2, v3}, Landroid/content/pm/PackageManager;->getPackageInfo(Ljava/lang/String;I)Landroid/content/pm/PackageInfo;

    move-result-object v1

    .line 972
    iget-object v1, v1, Landroid/content/pm/PackageInfo;->applicationInfo:Landroid/content/pm/ApplicationInfo;

    invoke-virtual {p0}, Landroid/content/Context;->getPackageManager()Landroid/content/pm/PackageManager;

    move-result-object v2

    invoke-virtual {v1, v2}, Landroid/content/pm/ApplicationInfo;->loadLabel(Landroid/content/pm/PackageManager;)Ljava/lang/CharSequence;

    move-result-object v1

    invoke-interface {v1}, Ljava/lang/CharSequence;->toString()Ljava/lang/String;
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_0

    move-result-object v0

    goto :goto_0

    .line 973
    :catch_0
    move-exception v1

    .line 974
    sget-boolean v2, Lcom/umeng/commonsdk/statistics/b;->f:Z

    if-eqz v2, :cond_0

    .line 975
    sget-object v2, Lcom/umeng/commonsdk/statistics/common/DeviceConfig;->LOG_TAG:Ljava/lang/String;

    invoke-static {v2, v1}, Lcom/umeng/commonsdk/statistics/common/MLog;->i(Ljava/lang/String;Ljava/lang/Throwable;)V

    goto :goto_0
.end method

.method public static getAppSHA1Key(Landroid/content/Context;)Ljava/lang/String;
    .locals 4

    .prologue
    .line 864
    .line 865
    const/4 v1, 0x0

    .line 867
    :try_start_0
    invoke-virtual {p0}, Landroid/content/Context;->getPackageManager()Landroid/content/pm/PackageManager;

    move-result-object v0

    .line 868
    const/16 v2, 0x40

    .line 869
    invoke-static {p0}, Lcom/umeng/commonsdk/statistics/common/DeviceConfig;->getPackageName(Landroid/content/Context;)Ljava/lang/String;

    move-result-object v3

    invoke-virtual {v0, v3, v2}, Landroid/content/pm/PackageManager;->getPackageInfo(Ljava/lang/String;I)Landroid/content/pm/PackageInfo;

    move-result-object v0

    .line 870
    iget-object v0, v0, Landroid/content/pm/PackageInfo;->signatures:[Landroid/content/pm/Signature;

    .line 871
    const/4 v2, 0x0

    aget-object v0, v0, v2

    invoke-virtual {v0}, Landroid/content/pm/Signature;->toByteArray()[B

    move-result-object v0

    .line 873
    new-instance v2, Ljava/io/ByteArrayInputStream;

    invoke-direct {v2, v0}, Ljava/io/ByteArrayInputStream;-><init>([B)V

    .line 875
    const-string v0, "X509"

    invoke-static {v0}, Ljava/security/cert/CertificateFactory;->getInstance(Ljava/lang/String;)Ljava/security/cert/CertificateFactory;

    move-result-object v0

    .line 876
    invoke-virtual {v0, v2}, Ljava/security/cert/CertificateFactory;->generateCertificate(Ljava/io/InputStream;)Ljava/security/cert/Certificate;

    move-result-object v0

    check-cast v0, Ljava/security/cert/X509Certificate;

    .line 878
    const-string v2, "SHA1"

    invoke-static {v2}, Ljava/security/MessageDigest;->getInstance(Ljava/lang/String;)Ljava/security/MessageDigest;

    move-result-object v2

    .line 879
    invoke-virtual {v0}, Ljava/security/cert/X509Certificate;->getEncoded()[B

    move-result-object v0

    invoke-virtual {v2, v0}, Ljava/security/MessageDigest;->digest([B)[B

    move-result-object v0

    .line 880
    invoke-static {v0}, Lcom/umeng/commonsdk/statistics/common/DeviceConfig;->byte2HexFormatted([B)Ljava/lang/String;
    :try_end_0
    .catch Ljava/lang/Exception; {:try_start_0 .. :try_end_0} :catch_0

    move-result-object v0

    .line 884
    :goto_0
    return-object v0

    .line 881
    :catch_0
    move-exception v0

    move-object v0, v1

    goto :goto_0
.end method

.method public static getAppVersionCode(Landroid/content/Context;)Ljava/lang/String;
    .locals 1

    .prologue
    .line 136
    invoke-static {p0}, Lcom/umeng/commonsdk/utils/UMUtils;->getAppVersionCode(Landroid/content/Context;)Ljava/lang/String;

    move-result-object v0

    return-object v0
.end method

.method public static getAppVersionName(Landroid/content/Context;)Ljava/lang/String;
    .locals 1

    .prologue
    .line 158
    invoke-static {p0}, Lcom/umeng/commonsdk/utils/UMUtils;->getAppVersionName(Landroid/content/Context;)Ljava/lang/String;

    move-result-object v0

    return-object v0
.end method

.method public static getApplicationLable(Landroid/content/Context;)Ljava/lang/String;
    .locals 2

    .prologue
    .line 954
    if-nez p0, :cond_0

    .line 955
    const-string v0, ""

    .line 957
    :goto_0
    return-object v0

    :cond_0
    invoke-virtual {p0}, Landroid/content/Context;->getPackageManager()Landroid/content/pm/PackageManager;

    move-result-object v0

    invoke-virtual {p0}, Landroid/content/Context;->getApplicationInfo()Landroid/content/pm/ApplicationInfo;

    move-result-object v1

    invoke-virtual {v0, v1}, Landroid/content/pm/PackageManager;->getApplicationLabel(Landroid/content/pm/ApplicationInfo;)Ljava/lang/CharSequence;

    move-result-object v0

    invoke-interface {v0}, Ljava/lang/CharSequence;->toString()Ljava/lang/String;

    move-result-object v0

    goto :goto_0
.end method

.method private static getBuildProp()Ljava/util/Properties;
    .locals 7

    .prologue
    .line 1325
    new-instance v2, Ljava/util/Properties;

    invoke-direct {v2}, Ljava/util/Properties;-><init>()V

    .line 1326
    const/4 v1, 0x0

    .line 1328
    :try_start_0
    new-instance v0, Ljava/io/FileInputStream;

    new-instance v3, Ljava/io/File;

    invoke-static {}, Landroid/os/Environment;->getRootDirectory()Ljava/io/File;

    move-result-object v4

    const-string v5, "build.prop"

    invoke-direct {v3, v4, v5}, Ljava/io/File;-><init>(Ljava/io/File;Ljava/lang/String;)V

    invoke-direct {v0, v3}, Ljava/io/FileInputStream;-><init>(Ljava/io/File;)V
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_0
    .catchall {:try_start_0 .. :try_end_0} :catchall_0

    .line 1329
    :try_start_1
    invoke-virtual {v2, v0}, Ljava/util/Properties;->load(Ljava/io/InputStream;)V
    :try_end_1
    .catch Ljava/lang/Throwable; {:try_start_1 .. :try_end_1} :catch_4
    .catchall {:try_start_1 .. :try_end_1} :catchall_1

    .line 1333
    if-eqz v0, :cond_0

    .line 1335
    :try_start_2
    invoke-virtual {v0}, Ljava/io/FileInputStream;->close()V
    :try_end_2
    .catch Ljava/lang/Throwable; {:try_start_2 .. :try_end_2} :catch_2

    .line 1340
    :cond_0
    :goto_0
    return-object v2

    .line 1330
    :catch_0
    move-exception v0

    move-object v0, v1

    .line 1333
    :goto_1
    if-eqz v0, :cond_0

    .line 1335
    :try_start_3
    invoke-virtual {v0}, Ljava/io/FileInputStream;->close()V
    :try_end_3
    .catch Ljava/lang/Throwable; {:try_start_3 .. :try_end_3} :catch_1

    goto :goto_0

    .line 1336
    :catch_1
    move-exception v0

    goto :goto_0

    .line 1333
    :catchall_0
    move-exception v0

    :goto_2
    if-eqz v1, :cond_1

    .line 1335
    :try_start_4
    invoke-virtual {v1}, Ljava/io/FileInputStream;->close()V
    :try_end_4
    .catch Ljava/lang/Throwable; {:try_start_4 .. :try_end_4} :catch_3

    .line 1337
    :cond_1
    :goto_3
    throw v0

    .line 1336
    :catch_2
    move-exception v0

    goto :goto_0

    :catch_3
    move-exception v1

    goto :goto_3

    .line 1333
    :catchall_1
    move-exception v1

    move-object v6, v1

    move-object v1, v0

    move-object v0, v6

    goto :goto_2

    .line 1330
    :catch_4
    move-exception v1

    goto :goto_1
.end method

.method public static getCPU()Ljava/lang/String;
    .locals 5

    .prologue
    .line 325
    const/4 v0, 0x0

    .line 331
    :try_start_0
    new-instance v1, Ljava/io/FileReader;

    const-string v2, "/proc/cpuinfo"

    invoke-direct {v1, v2}, Ljava/io/FileReader;-><init>(Ljava/lang/String;)V
    :try_end_0
    .catch Ljava/io/FileNotFoundException; {:try_start_0 .. :try_end_0} :catch_2

    .line 332
    if-eqz v1, :cond_0

    .line 334
    :try_start_1
    new-instance v2, Ljava/io/BufferedReader;

    const/16 v3, 0x400

    invoke-direct {v2, v1, v3}, Ljava/io/BufferedReader;-><init>(Ljava/io/Reader;I)V

    .line 335
    invoke-virtual {v2}, Ljava/io/BufferedReader;->readLine()Ljava/lang/String;
    :try_end_1
    .catch Ljava/lang/Throwable; {:try_start_1 .. :try_end_1} :catch_0
    .catch Ljava/io/FileNotFoundException; {:try_start_1 .. :try_end_1} :catch_2

    move-result-object v0

    .line 336
    :try_start_2
    invoke-virtual {v2}, Ljava/io/BufferedReader;->close()V

    .line 337
    invoke-virtual {v1}, Ljava/io/FileReader;->close()V
    :try_end_2
    .catch Ljava/lang/Throwable; {:try_start_2 .. :try_end_2} :catch_0
    .catch Ljava/io/FileNotFoundException; {:try_start_2 .. :try_end_2} :catch_1

    .line 346
    :cond_0
    :goto_0
    if-eqz v0, :cond_1

    .line 347
    const/16 v1, 0x3a

    invoke-virtual {v0, v1}, Ljava/lang/String;->indexOf(I)I

    move-result v1

    add-int/lit8 v1, v1, 0x1

    .line 348
    invoke-virtual {v0, v1}, Ljava/lang/String;->substring(I)Ljava/lang/String;

    move-result-object v0

    .line 349
    invoke-virtual {v0}, Ljava/lang/String;->trim()Ljava/lang/String;

    move-result-object v0

    .line 352
    :goto_1
    return-object v0

    .line 338
    :catch_0
    move-exception v1

    .line 339
    :try_start_3
    sget-object v2, Lcom/umeng/commonsdk/statistics/common/DeviceConfig;->LOG_TAG:Ljava/lang/String;

    const-string v3, "Could not read from file /proc/cpuinfo"

    invoke-static {v2, v3, v1}, Lcom/umeng/commonsdk/statistics/common/MLog;->e(Ljava/lang/String;Ljava/lang/String;Ljava/lang/Throwable;)V
    :try_end_3
    .catch Ljava/io/FileNotFoundException; {:try_start_3 .. :try_end_3} :catch_1

    goto :goto_0

    .line 342
    :catch_1
    move-exception v1

    move-object v4, v1

    move-object v1, v0

    move-object v0, v4

    .line 343
    :goto_2
    sget-object v2, Lcom/umeng/commonsdk/statistics/common/DeviceConfig;->LOG_TAG:Ljava/lang/String;

    const-string v3, "Could not open file /proc/cpuinfo"

    invoke-static {v2, v3, v0}, Lcom/umeng/commonsdk/statistics/common/MLog;->e(Ljava/lang/String;Ljava/lang/String;Ljava/lang/Throwable;)V

    move-object v0, v1

    goto :goto_0

    .line 352
    :cond_1
    const-string v0, ""

    goto :goto_1

    .line 342
    :catch_2
    move-exception v1

    move-object v4, v1

    move-object v1, v0

    move-object v0, v4

    goto :goto_2
.end method

.method public static getDBencryptID(Landroid/content/Context;)Ljava/lang/String;
    .locals 4

    .prologue
    .line 1408
    const/4 v1, 0x0

    .line 1410
    if-eqz p0, :cond_4

    .line 1411
    :try_start_0
    const-string v0, "phone"

    invoke-virtual {p0, v0}, Landroid/content/Context;->getSystemService(Ljava/lang/String;)Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Landroid/telephony/TelephonyManager;

    .line 1413
    if-eqz v0, :cond_3

    .line 1414
    const-string v2, "android.permission.READ_PHONE_STATE"

    invoke-static {p0, v2}, Lcom/umeng/commonsdk/statistics/common/DeviceConfig;->checkPermission(Landroid/content/Context;Ljava/lang/String;)Z

    move-result v2

    if-eqz v2, :cond_3

    .line 1415
    invoke-virtual {v0}, Landroid/telephony/TelephonyManager;->getDeviceId()Ljava/lang/String;
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_1

    move-result-object v1

    move-object v0, v1

    .line 1418
    :goto_0
    :try_start_1
    invoke-static {v0}, Landroid/text/TextUtils;->isEmpty(Ljava/lang/CharSequence;)Z

    move-result v1

    if-eqz v1, :cond_0

    .line 1419
    invoke-virtual {p0}, Landroid/content/Context;->getContentResolver()Landroid/content/ContentResolver;

    move-result-object v1

    const-string v2, "android_id"

    invoke-static {v1, v2}, Landroid/provider/Settings$Secure;->getString(Landroid/content/ContentResolver;Ljava/lang/String;)Ljava/lang/String;
    :try_end_1
    .catch Ljava/lang/Throwable; {:try_start_1 .. :try_end_1} :catch_2

    move-result-object v1

    .line 1420
    :try_start_2
    invoke-static {v1}, Landroid/text/TextUtils;->isEmpty(Ljava/lang/CharSequence;)Z

    move-result v0

    if-eqz v0, :cond_2

    .line 1422
    sget v0, Landroid/os/Build$VERSION;->SDK_INT:I

    const/16 v2, 0x9

    if-lt v0, v2, :cond_2

    .line 1423
    sget v0, Landroid/os/Build$VERSION;->SDK_INT:I
    :try_end_2
    .catch Ljava/lang/Throwable; {:try_start_2 .. :try_end_2} :catch_3

    const/16 v2, 0x1a

    if-lt v0, v2, :cond_1

    .line 1425
    :try_start_3
    const-string v0, "android.os.Build"

    invoke-static {v0}, Ljava/lang/Class;->forName(Ljava/lang/String;)Ljava/lang/Class;

    move-result-object v0

    .line 1426
    const-string v2, "getSerial"

    const/4 v3, 0x0

    new-array v3, v3, [Ljava/lang/Class;

    invoke-virtual {v0, v2, v3}, Ljava/lang/Class;->getMethod(Ljava/lang/String;[Ljava/lang/Class;)Ljava/lang/reflect/Method;

    move-result-object v2

    .line 1427
    const/4 v3, 0x0

    new-array v3, v3, [Ljava/lang/Object;

    invoke-virtual {v2, v0, v3}, Ljava/lang/reflect/Method;->invoke(Ljava/lang/Object;[Ljava/lang/Object;)Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Ljava/lang/String;
    :try_end_3
    .catch Ljava/lang/Throwable; {:try_start_3 .. :try_end_3} :catch_0

    .line 1439
    :cond_0
    :goto_1
    return-object v0

    .line 1428
    :catch_0
    move-exception v0

    move-object v0, v1

    .line 1429
    goto :goto_1

    .line 1431
    :cond_1
    :try_start_4
    sget-object v0, Landroid/os/Build;->SERIAL:Ljava/lang/String;
    :try_end_4
    .catch Ljava/lang/Throwable; {:try_start_4 .. :try_end_4} :catch_3

    goto :goto_1

    .line 1437
    :catch_1
    move-exception v0

    move-object v0, v1

    goto :goto_1

    :catch_2
    move-exception v1

    goto :goto_1

    :catch_3
    move-exception v0

    move-object v0, v1

    goto :goto_1

    :cond_2
    move-object v0, v1

    goto :goto_1

    :cond_3
    move-object v0, v1

    goto :goto_0

    :cond_4
    move-object v0, v1

    goto :goto_1
.end method

.method public static getDeviceId(Landroid/content/Context;)Ljava/lang/String;
    .locals 2

    .prologue
    .line 369
    invoke-static {}, Lcom/umeng/commonsdk/statistics/b;->a()I

    move-result v0

    const/4 v1, 0x2

    if-ne v0, v1, :cond_0

    .line 370
    invoke-static {p0}, Lcom/umeng/commonsdk/statistics/common/DeviceConfig;->getDeviceIdForBox(Landroid/content/Context;)Ljava/lang/String;

    move-result-object v0

    .line 372
    :goto_0
    return-object v0

    :cond_0
    invoke-static {p0}, Lcom/umeng/commonsdk/statistics/common/DeviceConfig;->getDeviceIdForGeneral(Landroid/content/Context;)Ljava/lang/String;

    move-result-object v0

    goto :goto_0
.end method

.method private static getDeviceIdForBox(Landroid/content/Context;)Ljava/lang/String;
    .locals 7

    .prologue
    const/16 v1, 0x17

    const/4 v6, 0x1

    const/4 v5, 0x0

    .line 1077
    const-string v0, ""

    .line 1078
    if-nez p0, :cond_1

    .line 1144
    :cond_0
    :goto_0
    return-object v0

    .line 1081
    :cond_1
    sget v0, Landroid/os/Build$VERSION;->SDK_INT:I

    if-ge v0, v1, :cond_4

    .line 1082
    invoke-virtual {p0}, Landroid/content/Context;->getContentResolver()Landroid/content/ContentResolver;

    move-result-object v0

    const-string v1, "android_id"

    invoke-static {v0, v1}, Landroid/provider/Settings$Secure;->getString(Landroid/content/ContentResolver;Ljava/lang/String;)Ljava/lang/String;

    move-result-object v0

    .line 1083
    sget-boolean v1, Lcom/umeng/commonsdk/statistics/b;->f:Z

    if-eqz v1, :cond_2

    .line 1084
    sget-object v1, Lcom/umeng/commonsdk/statistics/common/DeviceConfig;->LOG_TAG:Ljava/lang/String;

    new-array v2, v6, [Ljava/lang/Object;

    new-instance v3, Ljava/lang/StringBuilder;

    invoke-direct {v3}, Ljava/lang/StringBuilder;-><init>()V

    const-string v4, "getDeviceId, ANDROID_ID: "

    invoke-virtual {v3, v4}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v3

    invoke-virtual {v3, v0}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v3

    invoke-virtual {v3}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v3

    aput-object v3, v2, v5

    invoke-static {v1, v2}, Lcom/umeng/commonsdk/statistics/common/MLog;->i(Ljava/lang/String;[Ljava/lang/Object;)V

    .line 1086
    :cond_2
    invoke-static {v0}, Landroid/text/TextUtils;->isEmpty(Ljava/lang/CharSequence;)Z

    move-result v1

    if-eqz v1, :cond_0

    .line 1087
    invoke-static {p0}, Lcom/umeng/commonsdk/statistics/common/DeviceConfig;->getMacBySystemInterface(Landroid/content/Context;)Ljava/lang/String;

    move-result-object v0

    .line 1088
    sget-boolean v1, Lcom/umeng/commonsdk/statistics/b;->f:Z

    if-eqz v1, :cond_3

    .line 1089
    sget-object v1, Lcom/umeng/commonsdk/statistics/common/DeviceConfig;->LOG_TAG:Ljava/lang/String;

    new-array v2, v6, [Ljava/lang/Object;

    new-instance v3, Ljava/lang/StringBuilder;

    invoke-direct {v3}, Ljava/lang/StringBuilder;-><init>()V

    const-string v4, "getDeviceId, MAC: "

    invoke-virtual {v3, v4}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v3

    invoke-virtual {v3, v0}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v3

    invoke-virtual {v3}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v3

    aput-object v3, v2, v5

    invoke-static {v1, v2}, Lcom/umeng/commonsdk/statistics/common/MLog;->i(Ljava/lang/String;[Ljava/lang/Object;)V

    .line 1091
    :cond_3
    invoke-static {v0}, Landroid/text/TextUtils;->isEmpty(Ljava/lang/CharSequence;)Z

    move-result v1

    if-eqz v1, :cond_0

    .line 1092
    invoke-static {}, Lcom/umeng/commonsdk/statistics/common/DeviceConfig;->getSerialNo()Ljava/lang/String;

    move-result-object v0

    .line 1093
    invoke-static {v0}, Landroid/text/TextUtils;->isEmpty(Ljava/lang/CharSequence;)Z

    move-result v1

    if-eqz v1, :cond_0

    .line 1094
    invoke-static {p0}, Lcom/umeng/commonsdk/statistics/common/DeviceConfig;->getIMEI(Landroid/content/Context;)Ljava/lang/String;

    move-result-object v0

    goto :goto_0

    .line 1098
    :cond_4
    sget v0, Landroid/os/Build$VERSION;->SDK_INT:I

    if-ne v0, v1, :cond_9

    .line 1099
    invoke-virtual {p0}, Landroid/content/Context;->getContentResolver()Landroid/content/ContentResolver;

    move-result-object v0

    const-string v1, "android_id"

    invoke-static {v0, v1}, Landroid/provider/Settings$Secure;->getString(Landroid/content/ContentResolver;Ljava/lang/String;)Ljava/lang/String;

    move-result-object v0

    .line 1100
    sget-boolean v1, Lcom/umeng/commonsdk/statistics/b;->f:Z

    if-eqz v1, :cond_5

    .line 1101
    sget-object v1, Lcom/umeng/commonsdk/statistics/common/DeviceConfig;->LOG_TAG:Ljava/lang/String;

    new-array v2, v6, [Ljava/lang/Object;

    new-instance v3, Ljava/lang/StringBuilder;

    invoke-direct {v3}, Ljava/lang/StringBuilder;-><init>()V

    const-string v4, "getDeviceId, ANDROID_ID: "

    invoke-virtual {v3, v4}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v3

    invoke-virtual {v3, v0}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v3

    invoke-virtual {v3}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v3

    aput-object v3, v2, v5

    invoke-static {v1, v2}, Lcom/umeng/commonsdk/statistics/common/MLog;->i(Ljava/lang/String;[Ljava/lang/Object;)V

    .line 1103
    :cond_5
    invoke-static {v0}, Landroid/text/TextUtils;->isEmpty(Ljava/lang/CharSequence;)Z

    move-result v1

    if-eqz v1, :cond_0

    .line 1104
    invoke-static {}, Lcom/umeng/commonsdk/statistics/common/DeviceConfig;->getMacByJavaAPI()Ljava/lang/String;

    move-result-object v0

    .line 1105
    invoke-static {v0}, Landroid/text/TextUtils;->isEmpty(Ljava/lang/CharSequence;)Z

    move-result v1

    if-eqz v1, :cond_6

    .line 1106
    sget-boolean v0, Lcom/umeng/commonsdk/statistics/b;->d:Z

    if-eqz v0, :cond_8

    .line 1107
    invoke-static {}, Lcom/umeng/commonsdk/statistics/common/DeviceConfig;->getMacShell()Ljava/lang/String;

    move-result-object v0

    .line 1112
    :cond_6
    :goto_1
    sget-boolean v1, Lcom/umeng/commonsdk/statistics/b;->f:Z

    if-eqz v1, :cond_7

    .line 1113
    sget-object v1, Lcom/umeng/commonsdk/statistics/common/DeviceConfig;->LOG_TAG:Ljava/lang/String;

    new-array v2, v6, [Ljava/lang/Object;

    new-instance v3, Ljava/lang/StringBuilder;

    invoke-direct {v3}, Ljava/lang/StringBuilder;-><init>()V

    const-string v4, "getDeviceId, MAC: "

    invoke-virtual {v3, v4}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v3

    invoke-virtual {v3, v0}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v3

    invoke-virtual {v3}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v3

    aput-object v3, v2, v5

    invoke-static {v1, v2}, Lcom/umeng/commonsdk/statistics/common/MLog;->i(Ljava/lang/String;[Ljava/lang/Object;)V

    .line 1115
    :cond_7
    invoke-static {v0}, Landroid/text/TextUtils;->isEmpty(Ljava/lang/CharSequence;)Z

    move-result v1

    if-eqz v1, :cond_0

    .line 1116
    invoke-static {}, Lcom/umeng/commonsdk/statistics/common/DeviceConfig;->getSerialNo()Ljava/lang/String;

    move-result-object v0

    .line 1117
    invoke-static {v0}, Landroid/text/TextUtils;->isEmpty(Ljava/lang/CharSequence;)Z

    move-result v1

    if-eqz v1, :cond_0

    .line 1118
    invoke-static {p0}, Lcom/umeng/commonsdk/statistics/common/DeviceConfig;->getIMEI(Landroid/content/Context;)Ljava/lang/String;

    move-result-object v0

    goto/16 :goto_0

    .line 1109
    :cond_8
    invoke-static {p0}, Lcom/umeng/commonsdk/statistics/common/DeviceConfig;->getMacBySystemInterface(Landroid/content/Context;)Ljava/lang/String;

    move-result-object v0

    goto :goto_1

    .line 1124
    :cond_9
    invoke-virtual {p0}, Landroid/content/Context;->getContentResolver()Landroid/content/ContentResolver;

    move-result-object v0

    const-string v1, "android_id"

    invoke-static {v0, v1}, Landroid/provider/Settings$Secure;->getString(Landroid/content/ContentResolver;Ljava/lang/String;)Ljava/lang/String;

    move-result-object v0

    .line 1125
    sget-boolean v1, Lcom/umeng/commonsdk/statistics/b;->f:Z

    if-eqz v1, :cond_a

    .line 1126
    sget-object v1, Lcom/umeng/commonsdk/statistics/common/DeviceConfig;->LOG_TAG:Ljava/lang/String;

    new-array v2, v6, [Ljava/lang/Object;

    new-instance v3, Ljava/lang/StringBuilder;

    invoke-direct {v3}, Ljava/lang/StringBuilder;-><init>()V

    const-string v4, "getDeviceId: ANDROID_ID: "

    invoke-virtual {v3, v4}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v3

    invoke-virtual {v3, v0}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v3

    invoke-virtual {v3}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v3

    aput-object v3, v2, v5

    invoke-static {v1, v2}, Lcom/umeng/commonsdk/statistics/common/MLog;->i(Ljava/lang/String;[Ljava/lang/Object;)V

    .line 1128
    :cond_a
    invoke-static {v0}, Landroid/text/TextUtils;->isEmpty(Ljava/lang/CharSequence;)Z

    move-result v1

    if-eqz v1, :cond_0

    .line 1129
    invoke-static {}, Lcom/umeng/commonsdk/statistics/common/DeviceConfig;->getSerialNo()Ljava/lang/String;

    move-result-object v0

    .line 1130
    invoke-static {v0}, Landroid/text/TextUtils;->isEmpty(Ljava/lang/CharSequence;)Z

    move-result v1

    if-eqz v1, :cond_0

    .line 1131
    invoke-static {p0}, Lcom/umeng/commonsdk/statistics/common/DeviceConfig;->getIMEI(Landroid/content/Context;)Ljava/lang/String;

    move-result-object v0

    .line 1132
    invoke-static {v0}, Landroid/text/TextUtils;->isEmpty(Ljava/lang/CharSequence;)Z

    move-result v1

    if-eqz v1, :cond_0

    .line 1133
    invoke-static {}, Lcom/umeng/commonsdk/statistics/common/DeviceConfig;->getMacByJavaAPI()Ljava/lang/String;

    move-result-object v0

    .line 1134
    invoke-static {v0}, Landroid/text/TextUtils;->isEmpty(Ljava/lang/CharSequence;)Z

    move-result v1

    if-eqz v1, :cond_0

    .line 1135
    invoke-static {p0}, Lcom/umeng/commonsdk/statistics/common/DeviceConfig;->getMacBySystemInterface(Landroid/content/Context;)Ljava/lang/String;

    move-result-object v0

    .line 1136
    sget-boolean v1, Lcom/umeng/commonsdk/statistics/b;->f:Z

    if-eqz v1, :cond_0

    .line 1137
    sget-object v1, Lcom/umeng/commonsdk/statistics/common/DeviceConfig;->LOG_TAG:Ljava/lang/String;

    new-array v2, v6, [Ljava/lang/Object;

    new-instance v3, Ljava/lang/StringBuilder;

    invoke-direct {v3}, Ljava/lang/StringBuilder;-><init>()V

    const-string v4, "getDeviceId, MAC: "

    invoke-virtual {v3, v4}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v3

    invoke-virtual {v3, v0}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v3

    invoke-virtual {v3}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v3

    aput-object v3, v2, v5

    invoke-static {v1, v2}, Lcom/umeng/commonsdk/statistics/common/MLog;->i(Ljava/lang/String;[Ljava/lang/Object;)V

    goto/16 :goto_0
.end method

.method private static getDeviceIdForGeneral(Landroid/content/Context;)Ljava/lang/String;
    .locals 7

    .prologue
    const/16 v1, 0x17

    const/4 v6, 0x1

    const/4 v5, 0x0

    .line 993
    const-string v0, ""

    .line 994
    if-nez p0, :cond_1

    .line 1061
    :cond_0
    :goto_0
    return-object v0

    .line 997
    :cond_1
    sget v0, Landroid/os/Build$VERSION;->SDK_INT:I

    if-ge v0, v1, :cond_4

    .line 998
    invoke-static {p0}, Lcom/umeng/commonsdk/statistics/common/DeviceConfig;->getIMEI(Landroid/content/Context;)Ljava/lang/String;

    move-result-object v0

    .line 999
    invoke-static {v0}, Landroid/text/TextUtils;->isEmpty(Ljava/lang/CharSequence;)Z

    move-result v1

    if-eqz v1, :cond_0

    .line 1000
    sget-boolean v0, Lcom/umeng/commonsdk/statistics/b;->f:Z

    if-eqz v0, :cond_2

    .line 1001
    sget-object v0, Lcom/umeng/commonsdk/statistics/common/DeviceConfig;->LOG_TAG:Ljava/lang/String;

    new-array v1, v6, [Ljava/lang/Object;

    const-string v2, "No IMEI."

    aput-object v2, v1, v5

    invoke-static {v0, v1}, Lcom/umeng/commonsdk/statistics/common/MLog;->w(Ljava/lang/String;[Ljava/lang/Object;)V

    .line 1004
    :cond_2
    invoke-static {p0}, Lcom/umeng/commonsdk/statistics/common/DeviceConfig;->getMacBySystemInterface(Landroid/content/Context;)Ljava/lang/String;

    move-result-object v0

    .line 1005
    invoke-static {v0}, Landroid/text/TextUtils;->isEmpty(Ljava/lang/CharSequence;)Z

    move-result v1

    if-eqz v1, :cond_0

    .line 1006
    invoke-virtual {p0}, Landroid/content/Context;->getContentResolver()Landroid/content/ContentResolver;

    move-result-object v0

    const-string v1, "android_id"

    invoke-static {v0, v1}, Landroid/provider/Settings$Secure;->getString(Landroid/content/ContentResolver;Ljava/lang/String;)Ljava/lang/String;

    move-result-object v0

    .line 1007
    sget-boolean v1, Lcom/umeng/commonsdk/statistics/b;->f:Z

    if-eqz v1, :cond_3

    .line 1008
    sget-object v1, Lcom/umeng/commonsdk/statistics/common/DeviceConfig;->LOG_TAG:Ljava/lang/String;

    new-array v2, v6, [Ljava/lang/Object;

    new-instance v3, Ljava/lang/StringBuilder;

    invoke-direct {v3}, Ljava/lang/StringBuilder;-><init>()V

    const-string v4, "getDeviceId, ANDROID_ID: "

    invoke-virtual {v3, v4}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v3

    invoke-virtual {v3, v0}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v3

    invoke-virtual {v3}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v3

    aput-object v3, v2, v5

    invoke-static {v1, v2}, Lcom/umeng/commonsdk/statistics/common/MLog;->i(Ljava/lang/String;[Ljava/lang/Object;)V

    .line 1010
    :cond_3
    invoke-static {v0}, Landroid/text/TextUtils;->isEmpty(Ljava/lang/CharSequence;)Z

    move-result v1

    if-eqz v1, :cond_0

    .line 1011
    invoke-static {}, Lcom/umeng/commonsdk/statistics/common/DeviceConfig;->getSerialNo()Ljava/lang/String;

    move-result-object v0

    goto :goto_0

    .line 1015
    :cond_4
    sget v0, Landroid/os/Build$VERSION;->SDK_INT:I

    if-ne v0, v1, :cond_9

    .line 1016
    invoke-static {p0}, Lcom/umeng/commonsdk/statistics/common/DeviceConfig;->getIMEI(Landroid/content/Context;)Ljava/lang/String;

    move-result-object v0

    .line 1017
    invoke-static {v0}, Landroid/text/TextUtils;->isEmpty(Ljava/lang/CharSequence;)Z

    move-result v1

    if-eqz v1, :cond_0

    .line 1018
    invoke-static {}, Lcom/umeng/commonsdk/statistics/common/DeviceConfig;->getMacByJavaAPI()Ljava/lang/String;

    move-result-object v0

    .line 1019
    invoke-static {v0}, Landroid/text/TextUtils;->isEmpty(Ljava/lang/CharSequence;)Z

    move-result v1

    if-eqz v1, :cond_5

    .line 1020
    sget-boolean v0, Lcom/umeng/commonsdk/statistics/b;->d:Z

    if-eqz v0, :cond_8

    .line 1021
    invoke-static {}, Lcom/umeng/commonsdk/statistics/common/DeviceConfig;->getMacShell()Ljava/lang/String;

    move-result-object v0

    .line 1026
    :cond_5
    :goto_1
    sget-boolean v1, Lcom/umeng/commonsdk/statistics/b;->f:Z

    if-eqz v1, :cond_6

    .line 1027
    sget-object v1, Lcom/umeng/commonsdk/statistics/common/DeviceConfig;->LOG_TAG:Ljava/lang/String;

    new-array v2, v6, [Ljava/lang/Object;

    new-instance v3, Ljava/lang/StringBuilder;

    invoke-direct {v3}, Ljava/lang/StringBuilder;-><init>()V

    const-string v4, "getDeviceId, MAC: "

    invoke-virtual {v3, v4}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v3

    invoke-virtual {v3, v0}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v3

    invoke-virtual {v3}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v3

    aput-object v3, v2, v5

    invoke-static {v1, v2}, Lcom/umeng/commonsdk/statistics/common/MLog;->i(Ljava/lang/String;[Ljava/lang/Object;)V

    .line 1029
    :cond_6
    invoke-static {v0}, Landroid/text/TextUtils;->isEmpty(Ljava/lang/CharSequence;)Z

    move-result v1

    if-eqz v1, :cond_0

    .line 1030
    invoke-virtual {p0}, Landroid/content/Context;->getContentResolver()Landroid/content/ContentResolver;

    move-result-object v0

    const-string v1, "android_id"

    invoke-static {v0, v1}, Landroid/provider/Settings$Secure;->getString(Landroid/content/ContentResolver;Ljava/lang/String;)Ljava/lang/String;

    move-result-object v0

    .line 1031
    sget-boolean v1, Lcom/umeng/commonsdk/statistics/b;->f:Z

    if-eqz v1, :cond_7

    .line 1032
    sget-object v1, Lcom/umeng/commonsdk/statistics/common/DeviceConfig;->LOG_TAG:Ljava/lang/String;

    new-array v2, v6, [Ljava/lang/Object;

    new-instance v3, Ljava/lang/StringBuilder;

    invoke-direct {v3}, Ljava/lang/StringBuilder;-><init>()V

    const-string v4, "getDeviceId, ANDROID_ID: "

    invoke-virtual {v3, v4}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v3

    invoke-virtual {v3, v0}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v3

    invoke-virtual {v3}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v3

    aput-object v3, v2, v5

    invoke-static {v1, v2}, Lcom/umeng/commonsdk/statistics/common/MLog;->i(Ljava/lang/String;[Ljava/lang/Object;)V

    .line 1034
    :cond_7
    invoke-static {v0}, Landroid/text/TextUtils;->isEmpty(Ljava/lang/CharSequence;)Z

    move-result v1

    if-eqz v1, :cond_0

    .line 1035
    invoke-static {}, Lcom/umeng/commonsdk/statistics/common/DeviceConfig;->getSerialNo()Ljava/lang/String;

    move-result-object v0

    goto/16 :goto_0

    .line 1023
    :cond_8
    invoke-static {p0}, Lcom/umeng/commonsdk/statistics/common/DeviceConfig;->getMacBySystemInterface(Landroid/content/Context;)Ljava/lang/String;

    move-result-object v0

    goto :goto_1

    .line 1040
    :cond_9
    invoke-static {p0}, Lcom/umeng/commonsdk/statistics/common/DeviceConfig;->getIMEI(Landroid/content/Context;)Ljava/lang/String;

    move-result-object v0

    .line 1041
    invoke-static {v0}, Landroid/text/TextUtils;->isEmpty(Ljava/lang/CharSequence;)Z

    move-result v1

    if-eqz v1, :cond_0

    .line 1042
    invoke-static {}, Lcom/umeng/commonsdk/statistics/common/DeviceConfig;->getSerialNo()Ljava/lang/String;

    move-result-object v0

    .line 1043
    invoke-static {v0}, Landroid/text/TextUtils;->isEmpty(Ljava/lang/CharSequence;)Z

    move-result v1

    if-eqz v1, :cond_0

    .line 1044
    invoke-virtual {p0}, Landroid/content/Context;->getContentResolver()Landroid/content/ContentResolver;

    move-result-object v0

    const-string v1, "android_id"

    invoke-static {v0, v1}, Landroid/provider/Settings$Secure;->getString(Landroid/content/ContentResolver;Ljava/lang/String;)Ljava/lang/String;

    move-result-object v0

    .line 1045
    sget-boolean v1, Lcom/umeng/commonsdk/statistics/b;->f:Z

    if-eqz v1, :cond_a

    .line 1046
    sget-object v1, Lcom/umeng/commonsdk/statistics/common/DeviceConfig;->LOG_TAG:Ljava/lang/String;

    new-array v2, v6, [Ljava/lang/Object;

    new-instance v3, Ljava/lang/StringBuilder;

    invoke-direct {v3}, Ljava/lang/StringBuilder;-><init>()V

    const-string v4, "getDeviceId, ANDROID_ID: "

    invoke-virtual {v3, v4}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v3

    invoke-virtual {v3, v0}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v3

    invoke-virtual {v3}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v3

    aput-object v3, v2, v5

    invoke-static {v1, v2}, Lcom/umeng/commonsdk/statistics/common/MLog;->i(Ljava/lang/String;[Ljava/lang/Object;)V

    .line 1048
    :cond_a
    invoke-static {v0}, Landroid/text/TextUtils;->isEmpty(Ljava/lang/CharSequence;)Z

    move-result v1

    if-eqz v1, :cond_0

    .line 1049
    invoke-static {}, Lcom/umeng/commonsdk/statistics/common/DeviceConfig;->getMacByJavaAPI()Ljava/lang/String;

    move-result-object v0

    .line 1050
    invoke-static {v0}, Landroid/text/TextUtils;->isEmpty(Ljava/lang/CharSequence;)Z

    move-result v1

    if-eqz v1, :cond_0

    .line 1051
    invoke-static {p0}, Lcom/umeng/commonsdk/statistics/common/DeviceConfig;->getMacBySystemInterface(Landroid/content/Context;)Ljava/lang/String;

    move-result-object v0

    .line 1052
    sget-boolean v1, Lcom/umeng/commonsdk/statistics/b;->f:Z

    if-eqz v1, :cond_0

    .line 1053
    sget-object v1, Lcom/umeng/commonsdk/statistics/common/DeviceConfig;->LOG_TAG:Ljava/lang/String;

    new-array v2, v6, [Ljava/lang/Object;

    new-instance v3, Ljava/lang/StringBuilder;

    invoke-direct {v3}, Ljava/lang/StringBuilder;-><init>()V

    const-string v4, "getDeviceId, MAC: "

    invoke-virtual {v3, v4}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v3

    invoke-virtual {v3, v0}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v3

    invoke-virtual {v3}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v3

    aput-object v3, v2, v5

    invoke-static {v1, v2}, Lcom/umeng/commonsdk/statistics/common/MLog;->i(Ljava/lang/String;[Ljava/lang/Object;)V

    goto/16 :goto_0
.end method

.method public static getDeviceIdUmengMD5(Landroid/content/Context;)Ljava/lang/String;
    .locals 1

    .prologue
    .line 385
    invoke-static {p0}, Lcom/umeng/commonsdk/statistics/common/DeviceConfig;->getDeviceId(Landroid/content/Context;)Ljava/lang/String;

    move-result-object v0

    invoke-static {v0}, Lcom/umeng/commonsdk/statistics/common/HelperUtils;->getUmengMD5(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v0

    return-object v0
.end method

.method public static getDeviceType(Landroid/content/Context;)Ljava/lang/String;
    .locals 2

    .prologue
    .line 1383
    const-string v0, "Phone"

    .line 1384
    if-nez p0, :cond_0

    .line 1394
    :goto_0
    return-object v0

    .line 1387
    :cond_0
    invoke-virtual {p0}, Landroid/content/Context;->getResources()Landroid/content/res/Resources;

    move-result-object v0

    invoke-virtual {v0}, Landroid/content/res/Resources;->getConfiguration()Landroid/content/res/Configuration;

    move-result-object v0

    iget v0, v0, Landroid/content/res/Configuration;->screenLayout:I

    and-int/lit8 v0, v0, 0xf

    const/4 v1, 0x3

    if-lt v0, v1, :cond_1

    const/4 v0, 0x1

    .line 1389
    :goto_1
    if-eqz v0, :cond_2

    .line 1390
    const-string v0, "Tablet"

    goto :goto_0

    .line 1387
    :cond_1
    const/4 v0, 0x0

    goto :goto_1

    .line 1392
    :cond_2
    const-string v0, "Phone"

    goto :goto_0
.end method

.method public static getDisplayResolution(Landroid/content/Context;)Ljava/lang/String;
    .locals 3

    .prologue
    .line 490
    if-nez p0, :cond_0

    .line 491
    const-string v0, ""

    .line 505
    :goto_0
    return-object v0

    .line 494
    :cond_0
    :try_start_0
    new-instance v1, Landroid/util/DisplayMetrics;

    invoke-direct {v1}, Landroid/util/DisplayMetrics;-><init>()V

    .line 495
    const-string v0, "window"

    invoke-virtual {p0, v0}, Landroid/content/Context;->getSystemService(Ljava/lang/String;)Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Landroid/view/WindowManager;

    check-cast v0, Landroid/view/WindowManager;

    .line 496
    invoke-interface {v0}, Landroid/view/WindowManager;->getDefaultDisplay()Landroid/view/Display;

    move-result-object v0

    invoke-virtual {v0, v1}, Landroid/view/Display;->getMetrics(Landroid/util/DisplayMetrics;)V

    .line 498
    iget v0, v1, Landroid/util/DisplayMetrics;->widthPixels:I

    .line 499
    iget v1, v1, Landroid/util/DisplayMetrics;->heightPixels:I

    .line 501
    new-instance v2, Ljava/lang/StringBuilder;

    invoke-direct {v2}, Ljava/lang/StringBuilder;-><init>()V

    invoke-static {v1}, Ljava/lang/String;->valueOf(I)Ljava/lang/String;

    move-result-object v1

    invoke-virtual {v2, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    const-string v2, "*"

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-static {v0}, Ljava/lang/String;->valueOf(I)Ljava/lang/String;

    move-result-object v0

    invoke-virtual {v1, v0}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-virtual {v0}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_0

    move-result-object v0

    goto :goto_0

    .line 503
    :catch_0
    move-exception v0

    .line 505
    const-string v0, ""

    goto :goto_0
.end method

.method private static getEmuiVersion(Ljava/util/Properties;)Ljava/lang/String;
    .locals 3

    .prologue
    const/4 v0, 0x0

    .line 1310
    .line 1312
    :try_start_0
    const-string v1, "ro.build.hw_emui_api_level"

    const/4 v2, 0x0

    invoke-virtual {p0, v1, v2}, Ljava/util/Properties;->getProperty(Ljava/lang/String;Ljava/lang/String;)Ljava/lang/String;
    :try_end_0
    .catch Ljava/lang/Exception; {:try_start_0 .. :try_end_0} :catch_0

    move-result-object v0

    .line 1316
    :goto_0
    return-object v0

    .line 1313
    :catch_0
    move-exception v1

    goto :goto_0
.end method

.method private static getFlymeVersion(Ljava/util/Properties;)Ljava/lang/String;
    .locals 2

    .prologue
    .line 1294
    :try_start_0
    const-string v0, "ro.build.display.id"

    invoke-virtual {p0, v0}, Ljava/util/Properties;->getProperty(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v0

    invoke-static {}, Ljava/util/Locale;->getDefault()Ljava/util/Locale;

    move-result-object v1

    invoke-virtual {v0, v1}, Ljava/lang/String;->toLowerCase(Ljava/util/Locale;)Ljava/lang/String;

    move-result-object v0

    .line 1295
    const-string v1, "flyme os"

    invoke-virtual {v0, v1}, Ljava/lang/String;->contains(Ljava/lang/CharSequence;)Z

    move-result v1

    if-eqz v1, :cond_0

    .line 1296
    const-string v1, " "

    invoke-virtual {v0, v1}, Ljava/lang/String;->split(Ljava/lang/String;)[Ljava/lang/String;

    move-result-object v0

    const/4 v1, 0x2

    aget-object v0, v0, v1
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_0

    .line 1300
    :goto_0
    return-object v0

    .line 1298
    :catch_0
    move-exception v0

    .line 1300
    :cond_0
    const/4 v0, 0x0

    goto :goto_0
.end method

.method public static getGPU(Ljavax/microedition/khronos/opengles/GL10;)[Ljava/lang/String;
    .locals 5

    .prologue
    const/4 v4, 0x0

    .line 213
    const/4 v0, 0x2

    :try_start_0
    new-array v0, v0, [Ljava/lang/String;

    .line 214
    const/16 v1, 0x1f00

    invoke-interface {p0, v1}, Ljavax/microedition/khronos/opengles/GL10;->glGetString(I)Ljava/lang/String;

    move-result-object v1

    .line 215
    const/16 v2, 0x1f01

    invoke-interface {p0, v2}, Ljavax/microedition/khronos/opengles/GL10;->glGetString(I)Ljava/lang/String;

    move-result-object v2

    .line 216
    const/4 v3, 0x0

    aput-object v1, v0, v3

    .line 217
    const/4 v1, 0x1

    aput-object v2, v0, v1
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_0

    .line 223
    :goto_0
    return-object v0

    .line 219
    :catch_0
    move-exception v0

    .line 220
    sget-boolean v1, Lcom/umeng/commonsdk/statistics/b;->f:Z

    if-eqz v1, :cond_0

    .line 221
    sget-object v1, Lcom/umeng/commonsdk/statistics/common/DeviceConfig;->LOG_TAG:Ljava/lang/String;

    const-string v2, "Could not read gpu infor:"

    invoke-static {v1, v2, v0}, Lcom/umeng/commonsdk/statistics/common/MLog;->e(Ljava/lang/String;Ljava/lang/String;Ljava/lang/Throwable;)V

    .line 223
    :cond_0
    new-array v0, v4, [Ljava/lang/String;

    goto :goto_0
.end method

.method private static getIMEI(Landroid/content/Context;)Ljava/lang/String;
    .locals 7

    .prologue
    .line 1148
    const-string v1, ""

    .line 1149
    if-nez p0, :cond_0

    .line 1167
    :goto_0
    return-object v1

    .line 1152
    :cond_0
    const-string v0, "phone"

    invoke-virtual {p0, v0}, Landroid/content/Context;->getSystemService(Ljava/lang/String;)Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Landroid/telephony/TelephonyManager;

    .line 1153
    if-eqz v0, :cond_2

    .line 1155
    :try_start_0
    const-string v2, "android.permission.READ_PHONE_STATE"

    invoke-static {p0, v2}, Lcom/umeng/commonsdk/statistics/common/DeviceConfig;->checkPermission(Landroid/content/Context;Ljava/lang/String;)Z

    move-result v2

    if-eqz v2, :cond_2

    .line 1156
    invoke-virtual {v0}, Landroid/telephony/TelephonyManager;->getDeviceId()Ljava/lang/String;
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_0

    move-result-object v0

    .line 1157
    :try_start_1
    sget-boolean v1, Lcom/umeng/commonsdk/statistics/b;->f:Z

    if-eqz v1, :cond_1

    .line 1158
    sget-object v1, Lcom/umeng/commonsdk/statistics/common/DeviceConfig;->LOG_TAG:Ljava/lang/String;

    const/4 v2, 0x1

    new-array v2, v2, [Ljava/lang/Object;

    const/4 v3, 0x0

    new-instance v4, Ljava/lang/StringBuilder;

    invoke-direct {v4}, Ljava/lang/StringBuilder;-><init>()V

    const-string v5, "getDeviceId, IMEI: "

    invoke-virtual {v4, v5}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v4

    invoke-virtual {v4, v0}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v4

    invoke-virtual {v4}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v4

    aput-object v4, v2, v3

    invoke-static {v1, v2}, Lcom/umeng/commonsdk/statistics/common/MLog;->i(Ljava/lang/String;[Ljava/lang/Object;)V
    :try_end_1
    .catch Ljava/lang/Throwable; {:try_start_1 .. :try_end_1} :catch_1

    :cond_1
    :goto_1
    move-object v1, v0

    .line 1167
    goto :goto_0

    .line 1161
    :catch_0
    move-exception v0

    move-object v6, v0

    move-object v0, v1

    move-object v1, v6

    .line 1162
    :goto_2
    sget-boolean v2, Lcom/umeng/commonsdk/statistics/b;->f:Z

    if-eqz v2, :cond_1

    .line 1163
    sget-object v2, Lcom/umeng/commonsdk/statistics/common/DeviceConfig;->LOG_TAG:Ljava/lang/String;

    const-string v3, "No IMEI."

    invoke-static {v2, v3, v1}, Lcom/umeng/commonsdk/statistics/common/MLog;->w(Ljava/lang/String;Ljava/lang/String;Ljava/lang/Throwable;)V

    goto :goto_1

    .line 1161
    :catch_1
    move-exception v1

    goto :goto_2

    :cond_2
    move-object v0, v1

    goto :goto_1
.end method

.method public static getImei(Landroid/content/Context;)Ljava/lang/String;
    .locals 3

    .prologue
    .line 76
    const/4 v1, 0x0

    .line 78
    if-eqz p0, :cond_1

    .line 79
    :try_start_0
    const-string v0, "phone"

    invoke-virtual {p0, v0}, Landroid/content/Context;->getSystemService(Ljava/lang/String;)Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Landroid/telephony/TelephonyManager;

    .line 80
    if-eqz v0, :cond_1

    .line 81
    const-string v2, "android.permission.READ_PHONE_STATE"

    invoke-static {p0, v2}, Lcom/umeng/commonsdk/statistics/common/DeviceConfig;->checkPermission(Landroid/content/Context;Ljava/lang/String;)Z

    move-result v2

    if-eqz v2, :cond_1

    .line 82
    invoke-virtual {v0}, Landroid/telephony/TelephonyManager;->getDeviceId()Ljava/lang/String;
    :try_end_0
    .catch Ljava/lang/Exception; {:try_start_0 .. :try_end_0} :catch_0

    move-result-object v0

    :goto_0
    move-object v1, v0

    .line 90
    :cond_0
    :goto_1
    return-object v1

    .line 86
    :catch_0
    move-exception v0

    .line 87
    sget-boolean v2, Lcom/umeng/commonsdk/statistics/b;->f:Z

    if-eqz v2, :cond_0

    .line 88
    const-string v2, "No IMEI."

    invoke-static {v2, v0}, Lcom/umeng/commonsdk/statistics/common/MLog;->w(Ljava/lang/String;Ljava/lang/Throwable;)V

    goto :goto_1

    :cond_1
    move-object v0, v1

    goto :goto_0
.end method

.method public static getImsi(Landroid/content/Context;)Ljava/lang/String;
    .locals 3

    .prologue
    const/4 v1, 0x0

    .line 431
    if-nez p0, :cond_0

    .line 439
    :goto_0
    return-object v1

    .line 434
    :cond_0
    const-string v0, "phone"

    invoke-virtual {p0, v0}, Landroid/content/Context;->getSystemService(Ljava/lang/String;)Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Landroid/telephony/TelephonyManager;

    .line 436
    const-string v2, "android.permission.READ_PHONE_STATE"

    invoke-static {p0, v2}, Lcom/umeng/commonsdk/statistics/common/DeviceConfig;->checkPermission(Landroid/content/Context;Ljava/lang/String;)Z

    move-result v2

    if-eqz v2, :cond_1

    .line 437
    invoke-virtual {v0}, Landroid/telephony/TelephonyManager;->getSubscriberId()Ljava/lang/String;

    move-result-object v0

    :goto_1
    move-object v1, v0

    .line 439
    goto :goto_0

    :cond_1
    move-object v0, v1

    goto :goto_1
.end method

.method private static getLocale(Landroid/content/Context;)Ljava/util/Locale;
    .locals 5

    .prologue
    .line 707
    const/4 v0, 0x0

    .line 708
    if-nez p0, :cond_1

    .line 709
    invoke-static {}, Ljava/util/Locale;->getDefault()Ljava/util/Locale;

    move-result-object v0

    .line 728
    :cond_0
    :goto_0
    return-object v0

    .line 714
    :cond_1
    :try_start_0
    new-instance v1, Landroid/content/res/Configuration;

    invoke-direct {v1}, Landroid/content/res/Configuration;-><init>()V

    .line 715
    invoke-virtual {v1}, Landroid/content/res/Configuration;->setToDefaults()V

    .line 716
    invoke-virtual {p0}, Landroid/content/Context;->getContentResolver()Landroid/content/ContentResolver;

    move-result-object v2

    invoke-static {v2, v1}, Landroid/provider/Settings$System;->getConfiguration(Landroid/content/ContentResolver;Landroid/content/res/Configuration;)V

    .line 717
    if-eqz v1, :cond_2

    .line 718
    iget-object v0, v1, Landroid/content/res/Configuration;->locale:Ljava/util/Locale;
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_0

    .line 724
    :cond_2
    :goto_1
    if-nez v0, :cond_0

    .line 725
    invoke-static {}, Ljava/util/Locale;->getDefault()Ljava/util/Locale;

    move-result-object v0

    goto :goto_0

    .line 720
    :catch_0
    move-exception v1

    .line 721
    sget-object v1, Lcom/umeng/commonsdk/statistics/common/DeviceConfig;->LOG_TAG:Ljava/lang/String;

    const/4 v2, 0x1

    new-array v2, v2, [Ljava/lang/Object;

    const/4 v3, 0x0

    const-string v4, "fail to read user config locale"

    aput-object v4, v2, v3

    invoke-static {v1, v2}, Lcom/umeng/commonsdk/statistics/common/MLog;->e(Ljava/lang/String;[Ljava/lang/Object;)V

    goto :goto_1
.end method

.method public static getLocaleInfo(Landroid/content/Context;)[Ljava/lang/String;
    .locals 4

    .prologue
    const/4 v3, 0x1

    const/4 v2, 0x0

    .line 674
    const/4 v0, 0x2

    new-array v0, v0, [Ljava/lang/String;

    const-string v1, "Unknown"

    aput-object v1, v0, v2

    const-string v1, "Unknown"

    aput-object v1, v0, v3

    .line 675
    if-nez p0, :cond_1

    .line 696
    :cond_0
    :goto_0
    return-object v0

    .line 679
    :cond_1
    :try_start_0
    invoke-static {p0}, Lcom/umeng/commonsdk/statistics/common/DeviceConfig;->getLocale(Landroid/content/Context;)Ljava/util/Locale;

    move-result-object v1

    .line 681
    if-eqz v1, :cond_2

    .line 682
    const/4 v2, 0x0

    invoke-virtual {v1}, Ljava/util/Locale;->getCountry()Ljava/lang/String;

    move-result-object v3

    aput-object v3, v0, v2

    .line 683
    const/4 v2, 0x1

    invoke-virtual {v1}, Ljava/util/Locale;->getLanguage()Ljava/lang/String;

    move-result-object v1

    aput-object v1, v0, v2

    .line 686
    :cond_2
    const/4 v1, 0x0

    aget-object v1, v0, v1

    invoke-static {v1}, Landroid/text/TextUtils;->isEmpty(Ljava/lang/CharSequence;)Z

    move-result v1

    if-eqz v1, :cond_3

    .line 687
    const/4 v1, 0x0

    const-string v2, "Unknown"

    aput-object v2, v0, v1

    .line 688
    :cond_3
    const/4 v1, 0x1

    aget-object v1, v0, v1

    invoke-static {v1}, Landroid/text/TextUtils;->isEmpty(Ljava/lang/CharSequence;)Z

    move-result v1

    if-eqz v1, :cond_0

    .line 689
    const/4 v1, 0x1

    const-string v2, "Unknown"

    aput-object v2, v0, v1
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_0

    goto :goto_0

    .line 692
    :catch_0
    move-exception v1

    .line 693
    sget-object v2, Lcom/umeng/commonsdk/statistics/common/DeviceConfig;->LOG_TAG:Ljava/lang/String;

    const-string v3, "error in getLocaleInfo"

    invoke-static {v2, v3, v1}, Lcom/umeng/commonsdk/statistics/common/MLog;->e(Ljava/lang/String;Ljava/lang/String;Ljava/lang/Throwable;)V

    goto :goto_0
.end method

.method public static getMCCMNC(Landroid/content/Context;)Ljava/lang/String;
    .locals 5

    .prologue
    const/4 v0, 0x0

    .line 399
    if-nez p0, :cond_1

    .line 414
    :cond_0
    :goto_0
    return-object v0

    .line 402
    :cond_1
    invoke-static {p0}, Lcom/umeng/commonsdk/statistics/common/DeviceConfig;->getImsi(Landroid/content/Context;)Ljava/lang/String;

    move-result-object v1

    if-eqz v1, :cond_0

    .line 405
    invoke-virtual {p0}, Landroid/content/Context;->getResources()Landroid/content/res/Resources;

    move-result-object v1

    invoke-virtual {v1}, Landroid/content/res/Resources;->getConfiguration()Landroid/content/res/Configuration;

    move-result-object v1

    iget v1, v1, Landroid/content/res/Configuration;->mcc:I

    .line 406
    invoke-virtual {p0}, Landroid/content/Context;->getResources()Landroid/content/res/Resources;

    move-result-object v2

    invoke-virtual {v2}, Landroid/content/res/Resources;->getConfiguration()Landroid/content/res/Configuration;

    move-result-object v2

    iget v2, v2, Landroid/content/res/Configuration;->mnc:I

    .line 407
    if-eqz v1, :cond_0

    .line 408
    invoke-static {v2}, Ljava/lang/String;->valueOf(I)Ljava/lang/String;

    move-result-object v0

    .line 409
    const/16 v3, 0xa

    if-ge v2, v3, :cond_2

    .line 410
    const-string v0, "%02d"

    const/4 v3, 0x1

    new-array v3, v3, [Ljava/lang/Object;

    const/4 v4, 0x0

    invoke-static {v2}, Ljava/lang/Integer;->valueOf(I)Ljava/lang/Integer;

    move-result-object v2

    aput-object v2, v3, v4

    invoke-static {v0, v3}, Ljava/lang/String;->format(Ljava/lang/String;[Ljava/lang/Object;)Ljava/lang/String;

    move-result-object v0

    .line 412
    :cond_2
    new-instance v2, Ljava/lang/StringBuffer;

    invoke-direct {v2}, Ljava/lang/StringBuffer;-><init>()V

    invoke-static {v1}, Ljava/lang/String;->valueOf(I)Ljava/lang/String;

    move-result-object v1

    invoke-virtual {v2, v1}, Ljava/lang/StringBuffer;->append(Ljava/lang/String;)Ljava/lang/StringBuffer;

    move-result-object v1

    invoke-virtual {v1, v0}, Ljava/lang/StringBuffer;->append(Ljava/lang/String;)Ljava/lang/StringBuffer;

    move-result-object v0

    invoke-virtual {v0}, Ljava/lang/StringBuffer;->toString()Ljava/lang/String;

    move-result-object v0

    goto :goto_0
.end method

.method public static getMac(Landroid/content/Context;)Ljava/lang/String;
    .locals 2

    .prologue
    const/16 v1, 0x17

    .line 738
    const-string v0, ""

    .line 739
    if-nez p0, :cond_1

    .line 758
    :cond_0
    :goto_0
    return-object v0

    .line 742
    :cond_1
    sget v0, Landroid/os/Build$VERSION;->SDK_INT:I

    if-ge v0, v1, :cond_2

    .line 743
    invoke-static {p0}, Lcom/umeng/commonsdk/statistics/common/DeviceConfig;->getMacBySystemInterface(Landroid/content/Context;)Ljava/lang/String;

    move-result-object v0

    goto :goto_0

    .line 744
    :cond_2
    sget v0, Landroid/os/Build$VERSION;->SDK_INT:I

    if-ne v0, v1, :cond_4

    .line 745
    invoke-static {}, Lcom/umeng/commonsdk/statistics/common/DeviceConfig;->getMacByJavaAPI()Ljava/lang/String;

    move-result-object v0

    .line 746
    invoke-static {v0}, Landroid/text/TextUtils;->isEmpty(Ljava/lang/CharSequence;)Z

    move-result v1

    if-eqz v1, :cond_0

    .line 747
    sget-boolean v0, Lcom/umeng/commonsdk/statistics/b;->d:Z

    if-eqz v0, :cond_3

    .line 748
    invoke-static {}, Lcom/umeng/commonsdk/statistics/common/DeviceConfig;->getMacShell()Ljava/lang/String;

    move-result-object v0

    goto :goto_0

    .line 750
    :cond_3
    invoke-static {p0}, Lcom/umeng/commonsdk/statistics/common/DeviceConfig;->getMacBySystemInterface(Landroid/content/Context;)Ljava/lang/String;

    move-result-object v0

    goto :goto_0

    .line 754
    :cond_4
    invoke-static {}, Lcom/umeng/commonsdk/statistics/common/DeviceConfig;->getMacByJavaAPI()Ljava/lang/String;

    move-result-object v0

    .line 755
    invoke-static {v0}, Landroid/text/TextUtils;->isEmpty(Ljava/lang/CharSequence;)Z

    move-result v1

    if-eqz v1, :cond_0

    .line 756
    invoke-static {p0}, Lcom/umeng/commonsdk/statistics/common/DeviceConfig;->getMacBySystemInterface(Landroid/content/Context;)Ljava/lang/String;

    move-result-object v0

    goto :goto_0
.end method

.method private static getMacByJavaAPI()Ljava/lang/String;
    .locals 9

    .prologue
    const/4 v1, 0x0

    const/4 v2, 0x0

    .line 235
    :try_start_0
    invoke-static {}, Ljava/net/NetworkInterface;->getNetworkInterfaces()Ljava/util/Enumeration;

    move-result-object v3

    .line 236
    :cond_0
    invoke-interface {v3}, Ljava/util/Enumeration;->hasMoreElements()Z

    move-result v0

    if-eqz v0, :cond_6

    .line 237
    invoke-interface {v3}, Ljava/util/Enumeration;->nextElement()Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Ljava/net/NetworkInterface;

    .line 238
    const-string v4, "wlan0"

    invoke-virtual {v0}, Ljava/net/NetworkInterface;->getName()Ljava/lang/String;

    move-result-object v5

    invoke-virtual {v4, v5}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v4

    if-nez v4, :cond_1

    const-string v4, "eth0"

    invoke-virtual {v0}, Ljava/net/NetworkInterface;->getName()Ljava/lang/String;

    move-result-object v5

    invoke-virtual {v4, v5}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v4

    if-eqz v4, :cond_0

    .line 239
    :cond_1
    invoke-virtual {v0}, Ljava/net/NetworkInterface;->getHardwareAddress()[B

    move-result-object v3

    .line 240
    if-eqz v3, :cond_2

    array-length v0, v3

    if-nez v0, :cond_3

    :cond_2
    move-object v0, v1

    .line 255
    :goto_0
    return-object v0

    .line 243
    :cond_3
    new-instance v4, Ljava/lang/StringBuilder;

    invoke-direct {v4}, Ljava/lang/StringBuilder;-><init>()V

    .line 244
    array-length v5, v3

    move v0, v2

    :goto_1
    if-ge v0, v5, :cond_4

    aget-byte v2, v3, v0

    .line 245
    const-string v6, "%02X:"

    const/4 v7, 0x1

    new-array v7, v7, [Ljava/lang/Object;

    const/4 v8, 0x0

    invoke-static {v2}, Ljava/lang/Byte;->valueOf(B)Ljava/lang/Byte;

    move-result-object v2

    aput-object v2, v7, v8

    invoke-static {v6, v7}, Ljava/lang/String;->format(Ljava/lang/String;[Ljava/lang/Object;)Ljava/lang/String;

    move-result-object v2

    invoke-virtual {v4, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    .line 244
    add-int/lit8 v0, v0, 0x1

    goto :goto_1

    .line 247
    :cond_4
    invoke-virtual {v4}, Ljava/lang/StringBuilder;->length()I

    move-result v0

    if-lez v0, :cond_5

    .line 248
    invoke-virtual {v4}, Ljava/lang/StringBuilder;->length()I

    move-result v0

    add-int/lit8 v0, v0, -0x1

    invoke-virtual {v4, v0}, Ljava/lang/StringBuilder;->deleteCharAt(I)Ljava/lang/StringBuilder;

    .line 250
    :cond_5
    invoke-virtual {v4}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v0

    invoke-static {}, Ljava/util/Locale;->getDefault()Ljava/util/Locale;

    move-result-object v2

    invoke-virtual {v0, v2}, Ljava/lang/String;->toLowerCase(Ljava/util/Locale;)Ljava/lang/String;
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_0

    move-result-object v0

    goto :goto_0

    .line 253
    :catch_0
    move-exception v0

    :cond_6
    move-object v0, v1

    .line 255
    goto :goto_0
.end method

.method private static getMacBySystemInterface(Landroid/content/Context;)Ljava/lang/String;
    .locals 6

    .prologue
    const/4 v4, 0x1

    const/4 v5, 0x0

    .line 769
    if-nez p0, :cond_0

    .line 770
    const-string v0, ""

    .line 787
    :goto_0
    return-object v0

    .line 773
    :cond_0
    :try_start_0
    const-string v0, "wifi"

    invoke-virtual {p0, v0}, Landroid/content/Context;->getSystemService(Ljava/lang/String;)Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Landroid/net/wifi/WifiManager;

    .line 774
    const-string v1, "android.permission.ACCESS_WIFI_STATE"

    invoke-static {p0, v1}, Lcom/umeng/commonsdk/statistics/common/DeviceConfig;->checkPermission(Landroid/content/Context;Ljava/lang/String;)Z

    move-result v1

    if-eqz v1, :cond_1

    .line 775
    invoke-virtual {v0}, Landroid/net/wifi/WifiManager;->getConnectionInfo()Landroid/net/wifi/WifiInfo;

    move-result-object v0

    .line 776
    invoke-virtual {v0}, Landroid/net/wifi/WifiInfo;->getMacAddress()Ljava/lang/String;

    move-result-object v0

    goto :goto_0

    .line 778
    :cond_1
    sget-boolean v0, Lcom/umeng/commonsdk/statistics/b;->f:Z

    if-eqz v0, :cond_2

    .line 779
    sget-object v0, Lcom/umeng/commonsdk/statistics/common/DeviceConfig;->LOG_TAG:Ljava/lang/String;

    const/4 v1, 0x1

    new-array v1, v1, [Ljava/lang/Object;

    const/4 v2, 0x0

    const-string v3, "Could not get mac address.[no permission android.permission.ACCESS_WIFI_STATE"

    aput-object v3, v1, v2

    invoke-static {v0, v1}, Lcom/umeng/commonsdk/statistics/common/MLog;->w(Ljava/lang/String;[Ljava/lang/Object;)V

    .line 781
    :cond_2
    const-string v0, ""
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_0

    goto :goto_0

    .line 783
    :catch_0
    move-exception v0

    .line 784
    sget-boolean v1, Lcom/umeng/commonsdk/statistics/b;->f:Z

    if-eqz v1, :cond_3

    .line 785
    sget-object v1, Lcom/umeng/commonsdk/statistics/common/DeviceConfig;->LOG_TAG:Ljava/lang/String;

    new-array v2, v4, [Ljava/lang/Object;

    new-instance v3, Ljava/lang/StringBuilder;

    invoke-direct {v3}, Ljava/lang/StringBuilder;-><init>()V

    const-string v4, "Could not get mac address."

    invoke-virtual {v3, v4}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v3

    invoke-virtual {v0}, Ljava/lang/Throwable;->toString()Ljava/lang/String;

    move-result-object v0

    invoke-virtual {v3, v0}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-virtual {v0}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v0

    aput-object v0, v2, v5

    invoke-static {v1, v2}, Lcom/umeng/commonsdk/statistics/common/MLog;->w(Ljava/lang/String;[Ljava/lang/Object;)V

    .line 787
    :cond_3
    const-string v0, ""

    goto :goto_0
.end method

.method private static getMacShell()Ljava/lang/String;
    .locals 5

    .prologue
    const/4 v0, 0x0

    .line 267
    const/4 v1, 0x3

    :try_start_0
    new-array v2, v1, [Ljava/lang/String;

    const/4 v1, 0x0

    const-string v3, "/sys/class/net/wlan0/address"

    aput-object v3, v2, v1

    const/4 v1, 0x1

    const-string v3, "/sys/class/net/eth0/address"

    aput-object v3, v2, v1

    const/4 v1, 0x2

    const-string v3, "/sys/devices/virtual/net/wlan0/address"

    aput-object v3, v2, v1

    move v1, v0

    .line 270
    :goto_0
    array-length v0, v2
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_1

    if-ge v1, v0, :cond_1

    .line 272
    :try_start_1
    aget-object v0, v2, v1

    invoke-static {v0}, Lcom/umeng/commonsdk/statistics/common/DeviceConfig;->reaMac(Ljava/lang/String;)Ljava/lang/String;
    :try_end_1
    .catch Ljava/lang/Throwable; {:try_start_1 .. :try_end_1} :catch_0

    move-result-object v0

    .line 273
    if-eqz v0, :cond_0

    .line 285
    :goto_1
    return-object v0

    .line 276
    :catch_0
    move-exception v0

    .line 277
    :try_start_2
    sget-boolean v3, Lcom/umeng/commonsdk/statistics/b;->f:Z

    if-eqz v3, :cond_0

    .line 278
    sget-object v3, Lcom/umeng/commonsdk/statistics/common/DeviceConfig;->LOG_TAG:Ljava/lang/String;

    const-string v4, "open file  Failed"

    invoke-static {v3, v4, v0}, Lcom/umeng/commonsdk/statistics/common/MLog;->e(Ljava/lang/String;Ljava/lang/String;Ljava/lang/Throwable;)V
    :try_end_2
    .catch Ljava/lang/Throwable; {:try_start_2 .. :try_end_2} :catch_1

    .line 270
    :cond_0
    add-int/lit8 v0, v1, 0x1

    move v1, v0

    goto :goto_0

    .line 282
    :catch_1
    move-exception v0

    .line 285
    :cond_1
    const/4 v0, 0x0

    goto :goto_1
.end method

.method public static getNetworkAccessMode(Landroid/content/Context;)[Ljava/lang/String;
    .locals 4

    .prologue
    const/4 v3, 0x1

    const/4 v2, 0x0

    .line 518
    const/4 v0, 0x2

    new-array v1, v0, [Ljava/lang/String;

    const-string v0, ""

    aput-object v0, v1, v2

    const-string v0, ""

    aput-object v0, v1, v3

    .line 519
    if-nez p0, :cond_0

    move-object v0, v1

    .line 554
    :goto_0
    return-object v0

    .line 523
    :cond_0
    :try_start_0
    const-string v0, "android.permission.ACCESS_NETWORK_STATE"

    invoke-static {p0, v0}, Lcom/umeng/commonsdk/statistics/common/DeviceConfig;->checkPermission(Landroid/content/Context;Ljava/lang/String;)Z

    move-result v0

    if-nez v0, :cond_1

    .line 524
    const/4 v0, 0x0

    const-string v2, ""

    aput-object v2, v1, v0

    move-object v0, v1

    .line 525
    goto :goto_0

    .line 528
    :cond_1
    const-string v0, "connectivity"

    .line 529
    invoke-virtual {p0, v0}, Landroid/content/Context;->getSystemService(Ljava/lang/String;)Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Landroid/net/ConnectivityManager;

    .line 530
    if-nez v0, :cond_2

    .line 531
    const/4 v0, 0x0

    const-string v2, ""

    aput-object v2, v1, v0

    move-object v0, v1

    .line 532
    goto :goto_0

    .line 534
    :cond_2
    const/4 v2, 0x1

    invoke-virtual {v0, v2}, Landroid/net/ConnectivityManager;->getNetworkInfo(I)Landroid/net/NetworkInfo;

    move-result-object v2

    .line 535
    if-eqz v2, :cond_3

    .line 536
    invoke-virtual {v2}, Landroid/net/NetworkInfo;->getState()Landroid/net/NetworkInfo$State;

    move-result-object v2

    sget-object v3, Landroid/net/NetworkInfo$State;->CONNECTED:Landroid/net/NetworkInfo$State;

    if-ne v2, v3, :cond_3

    .line 537
    const/4 v0, 0x0

    const-string v2, "Wi-Fi"

    aput-object v2, v1, v0

    move-object v0, v1

    .line 538
    goto :goto_0

    .line 541
    :cond_3
    const/4 v2, 0x0

    invoke-virtual {v0, v2}, Landroid/net/ConnectivityManager;->getNetworkInfo(I)Landroid/net/NetworkInfo;

    move-result-object v0

    .line 542
    if-eqz v0, :cond_4

    .line 543
    invoke-virtual {v0}, Landroid/net/NetworkInfo;->getState()Landroid/net/NetworkInfo$State;

    move-result-object v2

    sget-object v3, Landroid/net/NetworkInfo$State;->CONNECTED:Landroid/net/NetworkInfo$State;

    if-ne v2, v3, :cond_4

    .line 544
    const/4 v2, 0x0

    const-string v3, "2G/3G"

    aput-object v3, v1, v2

    .line 545
    const/4 v2, 0x1

    invoke-virtual {v0}, Landroid/net/NetworkInfo;->getSubtypeName()Ljava/lang/String;

    move-result-object v0

    aput-object v0, v1, v2
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_0

    move-object v0, v1

    .line 546
    goto :goto_0

    .line 550
    :catch_0
    move-exception v0

    :cond_4
    move-object v0, v1

    .line 554
    goto :goto_0
.end method

.method public static getNetworkOperatorName(Landroid/content/Context;)Ljava/lang/String;
    .locals 2

    .prologue
    .line 469
    if-nez p0, :cond_0

    .line 470
    const-string v0, ""

    .line 480
    :goto_0
    return-object v0

    .line 473
    :cond_0
    :try_start_0
    const-string v0, "phone"

    invoke-virtual {p0, v0}, Landroid/content/Context;->getSystemService(Ljava/lang/String;)Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Landroid/telephony/TelephonyManager;

    .line 474
    const-string v1, "android.permission.READ_PHONE_STATE"

    invoke-static {p0, v1}, Lcom/umeng/commonsdk/statistics/common/DeviceConfig;->checkPermission(Landroid/content/Context;Ljava/lang/String;)Z

    move-result v1

    if-eqz v1, :cond_1

    .line 475
    if-eqz v0, :cond_1

    .line 476
    invoke-virtual {v0}, Landroid/telephony/TelephonyManager;->getNetworkOperatorName()Ljava/lang/String;
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_0

    move-result-object v0

    goto :goto_0

    .line 478
    :catch_0
    move-exception v0

    .line 480
    :cond_1
    const-string v0, ""

    goto :goto_0
.end method

.method public static getPackageName(Landroid/content/Context;)Ljava/lang/String;
    .locals 1

    .prologue
    .line 856
    if-nez p0, :cond_0

    .line 857
    const/4 v0, 0x0

    .line 859
    :goto_0
    return-object v0

    :cond_0
    invoke-virtual {p0}, Landroid/content/Context;->getPackageName()Ljava/lang/String;

    move-result-object v0

    goto :goto_0
.end method

.method public static getRegisteredOperator(Landroid/content/Context;)Ljava/lang/String;
    .locals 3

    .prologue
    const/4 v1, 0x0

    .line 451
    if-nez p0, :cond_0

    .line 459
    :goto_0
    return-object v1

    .line 454
    :cond_0
    const-string v0, "phone"

    invoke-virtual {p0, v0}, Landroid/content/Context;->getSystemService(Ljava/lang/String;)Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Landroid/telephony/TelephonyManager;

    .line 456
    const-string v2, "android.permission.READ_PHONE_STATE"

    invoke-static {p0, v2}, Lcom/umeng/commonsdk/statistics/common/DeviceConfig;->checkPermission(Landroid/content/Context;Ljava/lang/String;)Z

    move-result v2

    if-eqz v2, :cond_1

    .line 457
    invoke-virtual {v0}, Landroid/telephony/TelephonyManager;->getNetworkOperator()Ljava/lang/String;

    move-result-object v0

    :goto_1
    move-object v1, v0

    .line 459
    goto :goto_0

    :cond_1
    move-object v0, v1

    goto :goto_1
.end method

.method public static getResolutionArray(Landroid/content/Context;)[I
    .locals 5

    .prologue
    const/4 v1, 0x0

    const/4 v3, -0x1

    .line 798
    if-nez p0, :cond_0

    move-object v0, v1

    .line 835
    :goto_0
    return-object v0

    .line 802
    :cond_0
    :try_start_0
    new-instance v4, Landroid/util/DisplayMetrics;

    invoke-direct {v4}, Landroid/util/DisplayMetrics;-><init>()V

    .line 803
    const-string v0, "window"

    invoke-virtual {p0, v0}, Landroid/content/Context;->getSystemService(Ljava/lang/String;)Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Landroid/view/WindowManager;

    check-cast v0, Landroid/view/WindowManager;

    .line 804
    invoke-interface {v0}, Landroid/view/WindowManager;->getDefaultDisplay()Landroid/view/Display;

    move-result-object v0

    invoke-virtual {v0, v4}, Landroid/view/Display;->getMetrics(Landroid/util/DisplayMetrics;)V

    .line 808
    invoke-virtual {p0}, Landroid/content/Context;->getApplicationInfo()Landroid/content/pm/ApplicationInfo;

    move-result-object v0

    iget v0, v0, Landroid/content/pm/ApplicationInfo;->flags:I

    and-int/lit16 v0, v0, 0x2000

    if-nez v0, :cond_5

    .line 809
    const-string v0, "noncompatWidthPixels"

    invoke-static {v4, v0}, Lcom/umeng/commonsdk/statistics/common/DeviceConfig;->reflectMetrics(Ljava/lang/Object;Ljava/lang/String;)I

    move-result v2

    .line 810
    const-string v0, "noncompatHeightPixels"

    invoke-static {v4, v0}, Lcom/umeng/commonsdk/statistics/common/DeviceConfig;->reflectMetrics(Ljava/lang/Object;Ljava/lang/String;)I

    move-result v0

    .line 813
    :goto_1
    if-eq v2, v3, :cond_1

    if-ne v0, v3, :cond_4

    .line 814
    :cond_1
    iget v2, v4, Landroid/util/DisplayMetrics;->widthPixels:I

    .line 815
    iget v0, v4, Landroid/util/DisplayMetrics;->heightPixels:I

    move v3, v2

    move v2, v0

    .line 818
    :goto_2
    const/4 v0, 0x2

    new-array v0, v0, [I

    .line 820
    if-le v3, v2, :cond_3

    .line 821
    const/4 v4, 0x0

    aput v2, v0, v4

    .line 822
    const/4 v2, 0x1

    aput v3, v0, v2
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_0

    goto :goto_0

    .line 829
    :catch_0
    move-exception v0

    .line 830
    sget-boolean v2, Lcom/umeng/commonsdk/statistics/b;->f:Z

    if-eqz v2, :cond_2

    .line 831
    sget-object v2, Lcom/umeng/commonsdk/statistics/common/DeviceConfig;->LOG_TAG:Ljava/lang/String;

    const-string v3, "read resolution fail"

    invoke-static {v2, v3, v0}, Lcom/umeng/commonsdk/statistics/common/MLog;->e(Ljava/lang/String;Ljava/lang/String;Ljava/lang/Throwable;)V

    :cond_2
    move-object v0, v1

    .line 835
    goto :goto_0

    .line 824
    :cond_3
    const/4 v4, 0x0

    :try_start_1
    aput v3, v0, v4

    .line 825
    const/4 v3, 0x1

    aput v2, v0, v3
    :try_end_1
    .catch Ljava/lang/Throwable; {:try_start_1 .. :try_end_1} :catch_0

    goto :goto_0

    :cond_4
    move v3, v2

    move v2, v0

    goto :goto_2

    :cond_5
    move v0, v3

    move v2, v3

    goto :goto_1
.end method

.method public static getSerial()Ljava/lang/String;
    .locals 4

    .prologue
    const/4 v1, 0x0

    .line 109
    sget v0, Landroid/os/Build$VERSION;->SDK_INT:I

    const/16 v2, 0x9

    if-lt v0, v2, :cond_1

    .line 112
    sget v0, Landroid/os/Build$VERSION;->SDK_INT:I

    .line 113
    const/16 v2, 0x1a

    if-lt v0, v2, :cond_0

    .line 115
    :try_start_0
    const-string v0, "android.os.Build"

    invoke-static {v0}, Ljava/lang/Class;->forName(Ljava/lang/String;)Ljava/lang/Class;

    move-result-object v0

    .line 116
    const-string v2, "getSerial"

    const/4 v3, 0x0

    new-array v3, v3, [Ljava/lang/Class;

    invoke-virtual {v0, v2, v3}, Ljava/lang/Class;->getMethod(Ljava/lang/String;[Ljava/lang/Class;)Ljava/lang/reflect/Method;

    move-result-object v2

    .line 117
    const/4 v3, 0x0

    new-array v3, v3, [Ljava/lang/Object;

    invoke-virtual {v2, v0, v3}, Ljava/lang/reflect/Method;->invoke(Ljava/lang/Object;[Ljava/lang/Object;)Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Ljava/lang/String;
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_0

    .line 125
    :goto_0
    return-object v0

    .line 118
    :catch_0
    move-exception v0

    move-object v0, v1

    .line 119
    goto :goto_0

    .line 121
    :cond_0
    sget-object v0, Landroid/os/Build;->SERIAL:Ljava/lang/String;

    goto :goto_0

    :cond_1
    move-object v0, v1

    .line 125
    goto :goto_0
.end method

.method private static getSerialNo()Ljava/lang/String;
    .locals 6

    .prologue
    const/4 v5, 0x0

    .line 1177
    const-string v1, ""

    .line 1178
    sget v0, Landroid/os/Build$VERSION;->SDK_INT:I

    const/16 v2, 0x9

    if-lt v0, v2, :cond_2

    .line 1180
    sget v0, Landroid/os/Build$VERSION;->SDK_INT:I

    const/16 v2, 0x1a

    if-lt v0, v2, :cond_1

    .line 1182
    :try_start_0
    const-string v0, "android.os.Build"

    invoke-static {v0}, Ljava/lang/Class;->forName(Ljava/lang/String;)Ljava/lang/Class;

    move-result-object v0

    .line 1183
    const-string v2, "getSerial"

    const/4 v3, 0x0

    new-array v3, v3, [Ljava/lang/Class;

    invoke-virtual {v0, v2, v3}, Ljava/lang/Class;->getMethod(Ljava/lang/String;[Ljava/lang/Class;)Ljava/lang/reflect/Method;

    move-result-object v2

    .line 1184
    const/4 v3, 0x0

    new-array v3, v3, [Ljava/lang/Object;

    invoke-virtual {v2, v0, v3}, Ljava/lang/reflect/Method;->invoke(Ljava/lang/Object;[Ljava/lang/Object;)Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Ljava/lang/String;
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_0

    .line 1191
    :goto_0
    sget-boolean v1, Lcom/umeng/commonsdk/statistics/b;->f:Z

    if-eqz v1, :cond_0

    .line 1192
    sget-object v1, Lcom/umeng/commonsdk/statistics/common/DeviceConfig;->LOG_TAG:Ljava/lang/String;

    const/4 v2, 0x1

    new-array v2, v2, [Ljava/lang/Object;

    new-instance v3, Ljava/lang/StringBuilder;

    invoke-direct {v3}, Ljava/lang/StringBuilder;-><init>()V

    const-string v4, "getDeviceId, serial no: "

    invoke-virtual {v3, v4}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v3

    invoke-virtual {v3, v0}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v3

    invoke-virtual {v3}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v3

    aput-object v3, v2, v5

    invoke-static {v1, v2}, Lcom/umeng/commonsdk/statistics/common/MLog;->i(Ljava/lang/String;[Ljava/lang/Object;)V

    .line 1194
    :cond_0
    return-object v0

    .line 1185
    :catch_0
    move-exception v0

    move-object v0, v1

    .line 1186
    goto :goto_0

    .line 1188
    :cond_1
    sget-object v0, Landroid/os/Build;->SERIAL:Ljava/lang/String;

    goto :goto_0

    :cond_2
    move-object v0, v1

    goto :goto_0
.end method

.method public static getSubOSName(Landroid/content/Context;)Ljava/lang/String;
    .locals 3

    .prologue
    .line 1207
    .line 1208
    invoke-static {}, Lcom/umeng/commonsdk/statistics/common/DeviceConfig;->getBuildProp()Ljava/util/Properties;

    move-result-object v1

    .line 1210
    :try_start_0
    const-string v0, "ro.miui.ui.version.name"

    invoke-virtual {v1, v0}, Ljava/util/Properties;->getProperty(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v0

    .line 1211
    invoke-static {v0}, Landroid/text/TextUtils;->isEmpty(Ljava/lang/CharSequence;)Z

    move-result v2

    if-eqz v2, :cond_3

    .line 1212
    invoke-static {}, Lcom/umeng/commonsdk/statistics/common/DeviceConfig;->isFlyMe()Z

    move-result v2

    if-eqz v2, :cond_1

    .line 1213
    const-string v0, "Flyme"

    .line 1228
    :cond_0
    :goto_0
    return-object v0

    .line 1214
    :cond_1
    invoke-static {v1}, Lcom/umeng/commonsdk/statistics/common/DeviceConfig;->isEmui(Ljava/util/Properties;)Z

    move-result v2

    if-eqz v2, :cond_2

    .line 1215
    const-string v0, "Emui"

    goto :goto_0

    .line 1217
    :cond_2
    invoke-static {v1}, Lcom/umeng/commonsdk/statistics/common/DeviceConfig;->getYunOSVersion(Ljava/util/Properties;)Ljava/lang/String;

    move-result-object v1

    invoke-static {v1}, Landroid/text/TextUtils;->isEmpty(Ljava/lang/CharSequence;)Z

    move-result v1

    if-nez v1, :cond_0

    .line 1218
    const-string v0, "YunOS"

    goto :goto_0

    .line 1222
    :cond_3
    const-string v0, "MIUI"
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_0

    goto :goto_0

    .line 1224
    :catch_0
    move-exception v0

    .line 1225
    const/4 v0, 0x0

    goto :goto_0
.end method

.method public static getSubOSVersion(Landroid/content/Context;)Ljava/lang/String;
    .locals 3

    .prologue
    .line 1241
    .line 1242
    invoke-static {}, Lcom/umeng/commonsdk/statistics/common/DeviceConfig;->getBuildProp()Ljava/util/Properties;

    move-result-object v1

    .line 1244
    :try_start_0
    const-string v0, "ro.miui.ui.version.name"

    invoke-virtual {v1, v0}, Ljava/util/Properties;->getProperty(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v0

    .line 1245
    invoke-static {v0}, Landroid/text/TextUtils;->isEmpty(Ljava/lang/CharSequence;)Z

    move-result v2

    if-eqz v2, :cond_0

    .line 1246
    invoke-static {}, Lcom/umeng/commonsdk/statistics/common/DeviceConfig;->isFlyMe()Z
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_0

    move-result v2

    if-eqz v2, :cond_1

    .line 1248
    :try_start_1
    invoke-static {v1}, Lcom/umeng/commonsdk/statistics/common/DeviceConfig;->getFlymeVersion(Ljava/util/Properties;)Ljava/lang/String;
    :try_end_1
    .catch Ljava/lang/Throwable; {:try_start_1 .. :try_end_1} :catch_1

    move-result-object v0

    .line 1268
    :cond_0
    :goto_0
    return-object v0

    .line 1251
    :cond_1
    :try_start_2
    invoke-static {v1}, Lcom/umeng/commonsdk/statistics/common/DeviceConfig;->isEmui(Ljava/util/Properties;)Z
    :try_end_2
    .catch Ljava/lang/Throwable; {:try_start_2 .. :try_end_2} :catch_0

    move-result v2

    if-eqz v2, :cond_2

    .line 1253
    :try_start_3
    invoke-static {v1}, Lcom/umeng/commonsdk/statistics/common/DeviceConfig;->getEmuiVersion(Ljava/util/Properties;)Ljava/lang/String;
    :try_end_3
    .catch Ljava/lang/Throwable; {:try_start_3 .. :try_end_3} :catch_2

    move-result-object v0

    goto :goto_0

    .line 1259
    :cond_2
    :try_start_4
    invoke-static {v1}, Lcom/umeng/commonsdk/statistics/common/DeviceConfig;->getYunOSVersion(Ljava/util/Properties;)Ljava/lang/String;
    :try_end_4
    .catch Ljava/lang/Throwable; {:try_start_4 .. :try_end_4} :catch_3

    move-result-object v0

    goto :goto_0

    .line 1264
    :catch_0
    move-exception v0

    .line 1265
    const/4 v0, 0x0

    goto :goto_0

    .line 1249
    :catch_1
    move-exception v1

    goto :goto_0

    .line 1254
    :catch_2
    move-exception v1

    goto :goto_0

    .line 1260
    :catch_3
    move-exception v1

    goto :goto_0
.end method

.method public static getTimeZone(Landroid/content/Context;)I
    .locals 4

    .prologue
    const/16 v0, 0x8

    .line 600
    if-nez p0, :cond_1

    .line 613
    :cond_0
    :goto_0
    return v0

    .line 604
    :cond_1
    :try_start_0
    invoke-static {p0}, Lcom/umeng/commonsdk/statistics/common/DeviceConfig;->getLocale(Landroid/content/Context;)Ljava/util/Locale;

    move-result-object v1

    .line 605
    invoke-static {v1}, Ljava/util/Calendar;->getInstance(Ljava/util/Locale;)Ljava/util/Calendar;

    move-result-object v1

    .line 606
    if-eqz v1, :cond_0

    .line 607
    invoke-virtual {v1}, Ljava/util/Calendar;->getTimeZone()Ljava/util/TimeZone;

    move-result-object v1

    invoke-virtual {v1}, Ljava/util/TimeZone;->getRawOffset()I

    move-result v1

    const v2, 0x36ee80

    div-int v0, v1, v2
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_0

    goto :goto_0

    .line 609
    :catch_0
    move-exception v1

    .line 610
    sget-object v2, Lcom/umeng/commonsdk/statistics/common/DeviceConfig;->LOG_TAG:Ljava/lang/String;

    const-string v3, "error in getTimeZone"

    invoke-static {v2, v3, v1}, Lcom/umeng/commonsdk/statistics/common/MLog;->i(Ljava/lang/String;Ljava/lang/String;Ljava/lang/Throwable;)V

    goto :goto_0
.end method

.method private static getYunOSVersion(Ljava/util/Properties;)Ljava/lang/String;
    .locals 2

    .prologue
    .line 1278
    const-string v0, "ro.yunos.version"

    invoke-virtual {p0, v0}, Ljava/util/Properties;->getProperty(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v0

    .line 1279
    invoke-static {v0}, Landroid/text/TextUtils;->isEmpty(Ljava/lang/CharSequence;)Z

    move-result v1

    if-nez v1, :cond_0

    .line 1283
    :goto_0
    return-object v0

    :cond_0
    const/4 v0, 0x0

    goto :goto_0
.end method

.method public static isChineseAera(Landroid/content/Context;)Z
    .locals 4

    .prologue
    const/4 v1, 0x1

    const/4 v0, 0x0

    .line 632
    if-nez p0, :cond_1

    .line 663
    :cond_0
    :goto_0
    return v0

    .line 637
    :cond_1
    const-string v2, "country"

    const-string v3, ""

    invoke-static {p0, v2, v3}, Lcom/umeng/commonsdk/framework/UMEnvelopeBuild;->imprintProperty(Landroid/content/Context;Ljava/lang/String;Ljava/lang/String;)Ljava/lang/String;

    move-result-object v2

    .line 638
    invoke-static {v2}, Landroid/text/TextUtils;->isEmpty(Ljava/lang/CharSequence;)Z

    move-result v3

    if-nez v3, :cond_2

    .line 639
    const-string v3, "cn"

    invoke-virtual {v2, v3}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v2

    if-eqz v2, :cond_0

    move v0, v1

    .line 640
    goto :goto_0

    .line 645
    :cond_2
    invoke-static {p0}, Lcom/umeng/commonsdk/statistics/common/DeviceConfig;->getImsi(Landroid/content/Context;)Ljava/lang/String;

    move-result-object v2

    if-nez v2, :cond_3

    .line 646
    invoke-static {p0}, Lcom/umeng/commonsdk/statistics/common/DeviceConfig;->getLocaleInfo(Landroid/content/Context;)[Ljava/lang/String;

    move-result-object v2

    aget-object v2, v2, v0

    .line 647
    invoke-static {v2}, Landroid/text/TextUtils;->isEmpty(Ljava/lang/CharSequence;)Z

    move-result v3

    if-nez v3, :cond_0

    const-string v3, "cn"

    invoke-virtual {v2, v3}, Ljava/lang/String;->equalsIgnoreCase(Ljava/lang/String;)Z

    move-result v2

    if-eqz v2, :cond_0

    move v0, v1

    .line 648
    goto :goto_0

    .line 651
    :cond_3
    invoke-virtual {p0}, Landroid/content/Context;->getResources()Landroid/content/res/Resources;

    move-result-object v2

    invoke-virtual {v2}, Landroid/content/res/Resources;->getConfiguration()Landroid/content/res/Configuration;

    move-result-object v2

    iget v2, v2, Landroid/content/res/Configuration;->mcc:I

    .line 652
    const/16 v3, 0x1cc

    if-eq v2, v3, :cond_4

    const/16 v3, 0x1cd

    if-ne v2, v3, :cond_5

    :cond_4
    move v0, v1

    .line 653
    goto :goto_0

    .line 654
    :cond_5
    if-nez v2, :cond_0

    .line 655
    invoke-static {p0}, Lcom/umeng/commonsdk/statistics/common/DeviceConfig;->getLocaleInfo(Landroid/content/Context;)[Ljava/lang/String;

    move-result-object v2

    aget-object v2, v2, v0

    .line 656
    invoke-static {v2}, Landroid/text/TextUtils;->isEmpty(Ljava/lang/CharSequence;)Z

    move-result v3

    if-nez v3, :cond_0

    const-string v3, "cn"

    invoke-virtual {v2, v3}, Ljava/lang/String;->equalsIgnoreCase(Ljava/lang/String;)Z

    move-result v2

    if-eqz v2, :cond_0

    move v0, v1

    .line 657
    goto :goto_0
.end method

.method private static isEmui(Ljava/util/Properties;)Z
    .locals 3

    .prologue
    const/4 v0, 0x0

    .line 1366
    :try_start_0
    const-string v1, "ro.build.hw_emui_api_level"

    const/4 v2, 0x0

    invoke-virtual {p0, v1, v2}, Ljava/util/Properties;->getProperty(Ljava/lang/String;Ljava/lang/String;)Ljava/lang/String;
    :try_end_0
    .catch Ljava/lang/Exception; {:try_start_0 .. :try_end_0} :catch_0

    move-result-object v1

    .line 1367
    if-eqz v1, :cond_0

    .line 1368
    const/4 v0, 0x1

    .line 1373
    :cond_0
    :goto_0
    return v0

    .line 1370
    :catch_0
    move-exception v1

    goto :goto_0
.end method

.method private static isFlyMe()Z
    .locals 4

    .prologue
    const/4 v0, 0x0

    .line 1351
    :try_start_0
    const-class v1, Landroid/os/Build;

    const-string v2, "hasSmartBar"

    const/4 v3, 0x0

    new-array v3, v3, [Ljava/lang/Class;

    invoke-virtual {v1, v2, v3}, Ljava/lang/Class;->getMethod(Ljava/lang/String;[Ljava/lang/Class;)Ljava/lang/reflect/Method;
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_0

    .line 1355
    const/4 v0, 0x1

    :goto_0
    return v0

    .line 1352
    :catch_0
    move-exception v1

    goto :goto_0
.end method

.method public static isOnline(Landroid/content/Context;)Z
    .locals 2

    .prologue
    const/4 v1, 0x0

    .line 575
    if-nez p0, :cond_0

    move v0, v1

    .line 589
    :goto_0
    return v0

    .line 579
    :cond_0
    :try_start_0
    const-string v0, "android.permission.ACCESS_NETWORK_STATE"

    invoke-static {p0, v0}, Lcom/umeng/commonsdk/statistics/common/DeviceConfig;->checkPermission(Landroid/content/Context;Ljava/lang/String;)Z

    move-result v0

    if-eqz v0, :cond_1

    .line 580
    const-string v0, "connectivity"

    invoke-virtual {p0, v0}, Landroid/content/Context;->getSystemService(Ljava/lang/String;)Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Landroid/net/ConnectivityManager;

    .line 581
    if-eqz v0, :cond_1

    .line 582
    invoke-virtual {v0}, Landroid/net/ConnectivityManager;->getActiveNetworkInfo()Landroid/net/NetworkInfo;

    move-result-object v0

    .line 583
    if-eqz v0, :cond_1

    .line 584
    invoke-virtual {v0}, Landroid/net/NetworkInfo;->isConnectedOrConnecting()Z
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_0

    move-result v0

    goto :goto_0

    .line 587
    :catch_0
    move-exception v0

    :cond_1
    move v0, v1

    .line 589
    goto :goto_0
.end method

.method public static isWiFiAvailable(Landroid/content/Context;)Z
    .locals 3

    .prologue
    const/4 v0, 0x0

    .line 558
    if-nez p0, :cond_0

    .line 561
    :goto_0
    return v0

    :cond_0
    const-string v1, "Wi-Fi"

    invoke-static {p0}, Lcom/umeng/commonsdk/statistics/common/DeviceConfig;->getNetworkAccessMode(Landroid/content/Context;)[Ljava/lang/String;

    move-result-object v2

    aget-object v0, v2, v0

    invoke-virtual {v1, v0}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v0

    goto :goto_0
.end method

.method private static reaMac(Ljava/lang/String;)Ljava/lang/String;
    .locals 4

    .prologue
    const/4 v0, 0x0

    .line 289
    .line 291
    :try_start_0
    new-instance v3, Ljava/io/FileReader;

    invoke-direct {v3, p0}, Ljava/io/FileReader;-><init>(Ljava/lang/String;)V
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_0

    .line 293
    if-eqz v3, :cond_1

    .line 295
    :try_start_1
    new-instance v2, Ljava/io/BufferedReader;

    const/16 v1, 0x400

    invoke-direct {v2, v3, v1}, Ljava/io/BufferedReader;-><init>(Ljava/io/Reader;I)V
    :try_end_1
    .catchall {:try_start_1 .. :try_end_1} :catchall_0

    .line 296
    :try_start_2
    invoke-virtual {v2}, Ljava/io/BufferedReader;->readLine()Ljava/lang/String;
    :try_end_2
    .catchall {:try_start_2 .. :try_end_2} :catchall_1

    move-result-object v0

    .line 298
    if-eqz v3, :cond_0

    .line 300
    :try_start_3
    invoke-virtual {v3}, Ljava/io/FileReader;->close()V
    :try_end_3
    .catch Ljava/lang/Throwable; {:try_start_3 .. :try_end_3} :catch_1

    .line 305
    :cond_0
    :goto_0
    if-eqz v2, :cond_1

    .line 307
    :try_start_4
    invoke-virtual {v2}, Ljava/io/BufferedReader;->close()V
    :try_end_4
    .catch Ljava/lang/Throwable; {:try_start_4 .. :try_end_4} :catch_2

    .line 316
    :cond_1
    :goto_1
    return-object v0

    .line 298
    :catchall_0
    move-exception v1

    move-object v2, v0

    :goto_2
    if-eqz v3, :cond_2

    .line 300
    :try_start_5
    invoke-virtual {v3}, Ljava/io/FileReader;->close()V
    :try_end_5
    .catch Ljava/lang/Throwable; {:try_start_5 .. :try_end_5} :catch_3

    .line 305
    :cond_2
    :goto_3
    if-eqz v2, :cond_3

    .line 307
    :try_start_6
    invoke-virtual {v2}, Ljava/io/BufferedReader;->close()V
    :try_end_6
    .catch Ljava/lang/Throwable; {:try_start_6 .. :try_end_6} :catch_4

    .line 310
    :cond_3
    :goto_4
    :try_start_7
    throw v1
    :try_end_7
    .catch Ljava/lang/Throwable; {:try_start_7 .. :try_end_7} :catch_0

    .line 314
    :catch_0
    move-exception v1

    goto :goto_1

    .line 301
    :catch_1
    move-exception v1

    goto :goto_0

    .line 308
    :catch_2
    move-exception v1

    goto :goto_1

    .line 301
    :catch_3
    move-exception v3

    goto :goto_3

    .line 308
    :catch_4
    move-exception v2

    goto :goto_4

    .line 298
    :catchall_1
    move-exception v1

    goto :goto_2
.end method

.method private static reflectMetrics(Ljava/lang/Object;Ljava/lang/String;)I
    .locals 2

    .prologue
    .line 840
    :try_start_0
    const-class v0, Landroid/util/DisplayMetrics;

    invoke-virtual {v0, p1}, Ljava/lang/Class;->getDeclaredField(Ljava/lang/String;)Ljava/lang/reflect/Field;

    move-result-object v0

    .line 841
    const/4 v1, 0x1

    invoke-virtual {v0, v1}, Ljava/lang/reflect/Field;->setAccessible(Z)V

    .line 842
    invoke-virtual {v0, p0}, Ljava/lang/reflect/Field;->getInt(Ljava/lang/Object;)I
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_0

    move-result v0

    .line 846
    :goto_0
    return v0

    .line 843
    :catch_0
    move-exception v0

    .line 846
    const/4 v0, -0x1

    goto :goto_0
.end method
