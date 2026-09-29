.class public Lcom/cyjh/mobileanjian/ipc/log/b;
.super Ljava/lang/Object;
.source "SourceFile"


# static fields
.field private static o:Lcom/cyjh/mobileanjian/ipc/log/b; = null

.field private static final p:Ljava/io/File;

.field private static final q:Ljava/lang/String; = "com.cyjh.mobileanjian"


# instance fields
.field public final a:Ljava/lang/String;

.field public final b:Ljava/lang/String;

.field public final c:Ljava/lang/String;

.field public final d:Ljava/lang/String;

.field public final e:Ljava/lang/String;

.field public final f:Ljava/lang/String;

.field public final g:Ljava/lang/String;

.field public final h:Ljava/lang/String;

.field public final i:Ljava/lang/String;

.field public final j:Z

.field public final k:Ljava/lang/String;

.field public final l:Ljava/lang/String;

.field public final m:Z

.field public final n:Z


# direct methods
.method static constructor <clinit>()V
    .locals 3

    .prologue
    .line 32
    new-instance v0, Ljava/io/File;

    invoke-static {}, Landroid/os/Environment;->getExternalStorageDirectory()Ljava/io/File;

    move-result-object v1

    const-string v2, ".oldmarkuser"

    invoke-direct {v0, v1, v2}, Ljava/io/File;-><init>(Ljava/io/File;Ljava/lang/String;)V

    sput-object v0, Lcom/cyjh/mobileanjian/ipc/log/b;->p:Ljava/io/File;

    return-void
.end method

.method private constructor <init>(Landroid/content/Context;ZLjava/lang/String;Ljava/lang/String;)V
    .locals 5

    .prologue
    const/4 v0, 0x0

    const/4 v1, 0x1

    .line 71
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    .line 37
    sget-object v2, Landroid/os/Build$VERSION;->RELEASE:Ljava/lang/String;

    iput-object v2, p0, Lcom/cyjh/mobileanjian/ipc/log/b;->b:Ljava/lang/String;

    .line 72
    invoke-static {p1}, Lcom/cyjh/mobileanjian/ipc/log/b;->c(Landroid/content/Context;)Ljava/lang/String;

    move-result-object v2

    invoke-static {v2}, Lcom/cyjh/mobileanjian/ipc/log/b;->a(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v2

    iput-object v2, p0, Lcom/cyjh/mobileanjian/ipc/log/b;->c:Ljava/lang/String;

    .line 73
    invoke-static {}, Lcom/cyjh/mobileanjian/ipc/utils/RomUtils;->getKnownRomVersion()Ljava/lang/String;

    move-result-object v2

    iput-object v2, p0, Lcom/cyjh/mobileanjian/ipc/log/b;->d:Ljava/lang/String;

    .line 74
    invoke-static {}, Lcom/cyjh/mobileanjian/ipc/utils/RomUtils;->isEmulator()Z

    move-result v2

    if-eqz v2, :cond_3

    .line 76
    iget-object v2, p0, Lcom/cyjh/mobileanjian/ipc/log/b;->d:Ljava/lang/String;

    iput-object v2, p0, Lcom/cyjh/mobileanjian/ipc/log/b;->a:Ljava/lang/String;

    .line 83
    :goto_0
    invoke-static {p1}, Lcom/cyjh/mobileanjian/ipc/log/b;->a(Landroid/content/Context;)Ljava/lang/String;

    move-result-object v2

    iput-object v2, p0, Lcom/cyjh/mobileanjian/ipc/log/b;->h:Ljava/lang/String;

    .line 84
    invoke-static {p1}, Lcom/cyjh/mobileanjian/ipc/log/b;->b(Landroid/content/Context;)Ljava/lang/String;

    move-result-object v2

    iput-object v2, p0, Lcom/cyjh/mobileanjian/ipc/log/b;->l:Ljava/lang/String;

    .line 85
    invoke-virtual {p1}, Landroid/content/Context;->getPackageName()Ljava/lang/String;

    move-result-object v2

    iput-object v2, p0, Lcom/cyjh/mobileanjian/ipc/log/b;->g:Ljava/lang/String;

    .line 86
    const-string v2, "com.cyjh.mobileanjian"

    iget-object v3, p0, Lcom/cyjh/mobileanjian/ipc/log/b;->g:Ljava/lang/String;

    invoke-virtual {v2, v3}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v2

    iput-boolean v2, p0, Lcom/cyjh/mobileanjian/ipc/log/b;->n:Z

    .line 87
    iput-boolean p2, p0, Lcom/cyjh/mobileanjian/ipc/log/b;->j:Z

    .line 88
    iput-object p3, p0, Lcom/cyjh/mobileanjian/ipc/log/b;->i:Ljava/lang/String;

    .line 89
    iput-object p4, p0, Lcom/cyjh/mobileanjian/ipc/log/b;->k:Ljava/lang/String;

    .line 92
    sget-object v2, Lcom/cyjh/mobileanjian/ipc/log/b;->p:Ljava/io/File;

    invoke-virtual {v2}, Ljava/io/File;->exists()Z

    move-result v2

    if-nez v2, :cond_0

    move v0, v1

    :cond_0
    iput-boolean v0, p0, Lcom/cyjh/mobileanjian/ipc/log/b;->m:Z

    if-ne v0, v1, :cond_1

    .line 96
    :try_start_0
    sget-object v0, Lcom/cyjh/mobileanjian/ipc/log/b;->p:Ljava/io/File;

    invoke-virtual {v0}, Ljava/io/File;->createNewFile()Z
    :try_end_0
    .catch Ljava/io/IOException; {:try_start_0 .. :try_end_0} :catch_0

    .line 103
    :cond_1
    :goto_1
    invoke-static {p1}, Lcom/cyjh/mobileanjian/ipc/log/b;->d(Landroid/content/Context;)Ljava/lang/String;

    move-result-object v0

    iput-object v0, p0, Lcom/cyjh/mobileanjian/ipc/log/b;->e:Ljava/lang/String;

    .line 105
    const/4 v0, 0x0

    .line 108
    :try_start_1
    new-instance v1, Ljava/io/File;

    const-string v2, "/proc/version"

    invoke-direct {v1, v2}, Ljava/io/File;-><init>(Ljava/lang/String;)V

    invoke-static {v1}, Lorg/apache/commons/io/FileUtils;->readFileToString(Ljava/io/File;)Ljava/lang/String;
    :try_end_1
    .catch Ljava/io/IOException; {:try_start_1 .. :try_end_1} :catch_1

    move-result-object v0

    .line 113
    :goto_2
    invoke-static {v0}, Landroid/text/TextUtils;->isEmpty(Ljava/lang/CharSequence;)Z

    move-result v1

    if-eqz v1, :cond_2

    const-string v0, "Unknown"

    :cond_2
    iput-object v0, p0, Lcom/cyjh/mobileanjian/ipc/log/b;->f:Ljava/lang/String;

    .line 114
    return-void

    .line 80
    :cond_3
    const-string v2, "%s %s"

    const/4 v3, 0x2

    new-array v3, v3, [Ljava/lang/Object;

    sget-object v4, Landroid/os/Build;->BRAND:Ljava/lang/String;

    aput-object v4, v3, v0

    sget-object v4, Landroid/os/Build;->MODEL:Ljava/lang/String;

    aput-object v4, v3, v1

    invoke-static {v2, v3}, Ljava/lang/String;->format(Ljava/lang/String;[Ljava/lang/Object;)Ljava/lang/String;

    move-result-object v2

    iput-object v2, p0, Lcom/cyjh/mobileanjian/ipc/log/b;->a:Ljava/lang/String;

    goto :goto_0

    .line 97
    :catch_0
    move-exception v0

    .line 99
    invoke-virtual {v0}, Ljava/io/IOException;->printStackTrace()V

    goto :goto_1

    .line 109
    :catch_1
    move-exception v1

    .line 111
    invoke-virtual {v1}, Ljava/io/IOException;->printStackTrace()V

    goto :goto_2
.end method

.method public static a()Lcom/cyjh/mobileanjian/ipc/log/b;
    .locals 1

    .prologue
    .line 67
    sget-object v0, Lcom/cyjh/mobileanjian/ipc/log/b;->o:Lcom/cyjh/mobileanjian/ipc/log/b;

    return-object v0
.end method

.method private static a(Landroid/content/Context;)Ljava/lang/String;
    .locals 3

    .prologue
    .line 118
    invoke-virtual {p0}, Landroid/content/Context;->getPackageManager()Landroid/content/pm/PackageManager;

    move-result-object v0

    .line 121
    :try_start_0
    invoke-virtual {p0}, Landroid/content/Context;->getPackageName()Ljava/lang/String;

    move-result-object v1

    const/4 v2, 0x0

    invoke-virtual {v0, v1, v2}, Landroid/content/pm/PackageManager;->getApplicationInfo(Ljava/lang/String;I)Landroid/content/pm/ApplicationInfo;

    move-result-object v1

    .line 122
    if-eqz v1, :cond_0

    .line 123
    invoke-virtual {v0, v1}, Landroid/content/pm/PackageManager;->getApplicationLabel(Landroid/content/pm/ApplicationInfo;)Ljava/lang/CharSequence;

    move-result-object v0

    check-cast v0, Ljava/lang/String;
    :try_end_0
    .catch Landroid/content/pm/PackageManager$NameNotFoundException; {:try_start_0 .. :try_end_0} :catch_0

    .line 128
    :goto_0
    return-object v0

    .line 124
    :catch_0
    move-exception v0

    .line 126
    invoke-virtual {v0}, Landroid/content/pm/PackageManager$NameNotFoundException;->printStackTrace()V

    .line 128
    :cond_0
    const-string v0, "Unknown"

    goto :goto_0
.end method

.method private static final a(Ljava/lang/String;)Ljava/lang/String;
    .locals 7

    .prologue
    .line 160
    const-string v0, "MD5"

    .line 164
    :try_start_0
    const-string v0, "MD5"

    invoke-static {v0}, Ljava/security/MessageDigest;->getInstance(Ljava/lang/String;)Ljava/security/MessageDigest;

    move-result-object v0

    .line 165
    invoke-virtual {p0}, Ljava/lang/String;->getBytes()[B

    move-result-object v1

    invoke-virtual {v0, v1}, Ljava/security/MessageDigest;->update([B)V

    .line 166
    invoke-virtual {v0}, Ljava/security/MessageDigest;->digest()[B

    move-result-object v2

    .line 169
    new-instance v3, Ljava/lang/StringBuilder;

    invoke-direct {v3}, Ljava/lang/StringBuilder;-><init>()V

    .line 170
    array-length v4, v2

    const/4 v0, 0x0

    move v1, v0

    :goto_0
    if-ge v1, v4, :cond_1

    aget-byte v0, v2, v1

    .line 172
    and-int/lit16 v0, v0, 0xff

    invoke-static {v0}, Ljava/lang/Integer;->toHexString(I)Ljava/lang/String;

    move-result-object v0

    .line 173
    :goto_1
    invoke-virtual {v0}, Ljava/lang/String;->length()I

    move-result v5

    const/4 v6, 0x2

    if-ge v5, v6, :cond_0

    .line 174
    new-instance v5, Ljava/lang/StringBuilder;

    invoke-direct {v5}, Ljava/lang/StringBuilder;-><init>()V

    const-string v6, "0"

    invoke-virtual {v5, v6}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v5

    invoke-virtual {v5, v0}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-virtual {v0}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v0

    goto :goto_1

    .line 175
    :cond_0
    invoke-virtual {v3, v0}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    .line 170
    add-int/lit8 v0, v1, 0x1

    move v1, v0

    goto :goto_0

    .line 177
    :cond_1
    invoke-virtual {v3}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;
    :try_end_0
    .catch Ljava/security/NoSuchAlgorithmException; {:try_start_0 .. :try_end_0} :catch_0

    move-result-object p0

    .line 183
    :goto_2
    return-object p0

    .line 179
    :catch_0
    move-exception v0

    .line 181
    invoke-virtual {v0}, Ljava/security/NoSuchAlgorithmException;->printStackTrace()V

    goto :goto_2
.end method

.method public static a(Landroid/content/Context;ZLjava/lang/String;Ljava/lang/String;)V
    .locals 1

    .prologue
    .line 59
    if-nez p2, :cond_0

    const-string p2, ""

    .line 60
    :cond_0
    if-nez p3, :cond_1

    const-string p3, ""

    .line 61
    :cond_1
    new-instance v0, Lcom/cyjh/mobileanjian/ipc/log/b;

    invoke-direct {v0, p0, p1, p2, p3}, Lcom/cyjh/mobileanjian/ipc/log/b;-><init>(Landroid/content/Context;ZLjava/lang/String;Ljava/lang/String;)V

    sput-object v0, Lcom/cyjh/mobileanjian/ipc/log/b;->o:Lcom/cyjh/mobileanjian/ipc/log/b;

    .line 62
    sget-object v0, Lcom/cyjh/mobileanjian/ipc/log/b;->o:Lcom/cyjh/mobileanjian/ipc/log/b;

    invoke-virtual {v0}, Lcom/cyjh/mobileanjian/ipc/log/b;->toString()Ljava/lang/String;

    move-result-object v0

    invoke-static {v0}, Lcom/cyjh/mobileanjian/ipc/utils/CLog;->i(Ljava/lang/String;)V

    .line 63
    return-void
.end method

.method private static b(Landroid/content/Context;)Ljava/lang/String;
    .locals 3

    .prologue
    .line 133
    invoke-virtual {p0}, Landroid/content/Context;->getPackageManager()Landroid/content/pm/PackageManager;

    move-result-object v0

    .line 136
    :try_start_0
    invoke-virtual {p0}, Landroid/content/Context;->getPackageName()Ljava/lang/String;

    move-result-object v1

    const/4 v2, 0x0

    invoke-virtual {v0, v1, v2}, Landroid/content/pm/PackageManager;->getPackageInfo(Ljava/lang/String;I)Landroid/content/pm/PackageInfo;

    move-result-object v0

    .line 137
    iget-object v0, v0, Landroid/content/pm/PackageInfo;->versionName:Ljava/lang/String;
    :try_end_0
    .catch Landroid/content/pm/PackageManager$NameNotFoundException; {:try_start_0 .. :try_end_0} :catch_0

    .line 142
    :goto_0
    return-object v0

    .line 138
    :catch_0
    move-exception v0

    .line 140
    invoke-virtual {v0}, Landroid/content/pm/PackageManager$NameNotFoundException;->printStackTrace()V

    .line 142
    const-string v0, "Unknown"

    goto :goto_0
.end method

.method private static c(Landroid/content/Context;)Ljava/lang/String;
    .locals 2

    .prologue
    .line 148
    const-string v0, "wifi"

    invoke-virtual {p0, v0}, Landroid/content/Context;->getSystemService(Ljava/lang/String;)Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Landroid/net/wifi/WifiManager;

    .line 149
    invoke-virtual {v0}, Landroid/net/wifi/WifiManager;->getConnectionInfo()Landroid/net/wifi/WifiInfo;

    move-result-object v0

    .line 150
    if-nez v0, :cond_0

    .line 151
    const-string v0, "UNKNOWN"

    .line 155
    :goto_0
    return-object v0

    .line 152
    :cond_0
    invoke-virtual {v0}, Landroid/net/wifi/WifiInfo;->getMacAddress()Ljava/lang/String;

    move-result-object v1

    if-nez v1, :cond_1

    .line 153
    const-string v0, "UNKNOWN"

    goto :goto_0

    .line 155
    :cond_1
    invoke-virtual {v0}, Landroid/net/wifi/WifiInfo;->getMacAddress()Ljava/lang/String;

    move-result-object v0

    goto :goto_0
.end method

.method private static d(Landroid/content/Context;)Ljava/lang/String;
    .locals 2

    .prologue
    .line 188
    const-string v0, "phone"

    invoke-virtual {p0, v0}, Landroid/content/Context;->getSystemService(Ljava/lang/String;)Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Landroid/telephony/TelephonyManager;

    .line 189
    invoke-virtual {v0}, Landroid/telephony/TelephonyManager;->getDeviceId()Ljava/lang/String;

    move-result-object v0

    .line 191
    invoke-static {v0}, Landroid/text/TextUtils;->isEmpty(Ljava/lang/CharSequence;)Z

    move-result v1

    if-eqz v1, :cond_0

    const-string v0, "None"

    :cond_0
    return-object v0
.end method


# virtual methods
.method public toString()Ljava/lang/String;
    .locals 2

    .prologue
    .line 198
    new-instance v0, Ljava/lang/StringBuilder;

    invoke-direct {v0}, Ljava/lang/StringBuilder;-><init>()V

    const-string v1, "\u624b\u673a\u578b\u53f7: "

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    iget-object v1, p0, Lcom/cyjh/mobileanjian/ipc/log/b;->a:Ljava/lang/String;

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    const-string v1, "\nIMEI: "

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    iget-object v1, p0, Lcom/cyjh/mobileanjian/ipc/log/b;->e:Ljava/lang/String;

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    const-string v1, "\nLinux: "

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    iget-object v1, p0, Lcom/cyjh/mobileanjian/ipc/log/b;->f:Ljava/lang/String;

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    const-string v1, "\nMAC\u7684MD5: "

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    iget-object v1, p0, Lcom/cyjh/mobileanjian/ipc/log/b;->c:Ljava/lang/String;

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    const-string v1, "\n\u5b89\u5353\u7248\u672c: "

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    iget-object v1, p0, Lcom/cyjh/mobileanjian/ipc/log/b;->b:Ljava/lang/String;

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    const-string v1, "\n\u5b9a\u5236\u5b89\u5353: "

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    iget-object v1, p0, Lcom/cyjh/mobileanjian/ipc/log/b;->d:Ljava/lang/String;

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    const-string v1, "\n\u5e94\u7528\u540d\u79f0: "

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    iget-object v1, p0, Lcom/cyjh/mobileanjian/ipc/log/b;->h:Ljava/lang/String;

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    const-string v1, "\n\u5e94\u7528\u5305\u540d: "

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    iget-object v1, p0, Lcom/cyjh/mobileanjian/ipc/log/b;->g:Ljava/lang/String;

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    const-string v1, "\n\u5e94\u7528\u7248\u672c: "

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    iget-object v1, p0, Lcom/cyjh/mobileanjian/ipc/log/b;->l:Ljava/lang/String;

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    const-string v1, "\n\u552f\u4e00\u6807\u8bc6: "

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    iget-object v1, p0, Lcom/cyjh/mobileanjian/ipc/log/b;->i:Ljava/lang/String;

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    const-string v1, "\n\u7cbe\u7075\u7248\u672c: "

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    iget-object v1, p0, Lcom/cyjh/mobileanjian/ipc/log/b;->k:Ljava/lang/String;

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    const-string v1, "\n\u4ea7\u54c1\u5f62\u6001: "

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    iget-boolean v0, p0, Lcom/cyjh/mobileanjian/ipc/log/b;->n:Z

    if-eqz v0, :cond_0

    const-string v0, "\u6309\u952e\u7cbe\u7075"

    :goto_0
    invoke-virtual {v1, v0}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    const-string v1, "\n\u662f\u5426\u4ed8\u8d39: "

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    iget-boolean v0, p0, Lcom/cyjh/mobileanjian/ipc/log/b;->j:Z

    if-eqz v0, :cond_1

    const-string v0, "\u514d\u8d39"

    :goto_1
    invoke-virtual {v1, v0}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    const-string v1, "\n"

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-virtual {v0}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v0

    return-object v0

    :cond_0
    const-string v0, "\u5c0f\u7cbe\u7075"

    goto :goto_0

    :cond_1
    const-string v0, "\u6536\u8d39"

    goto :goto_1
.end method
