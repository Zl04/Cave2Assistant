.class public Lcom/cyjh/mobileanjian/ipc/utils/m;
.super Ljava/lang/Object;
.source "SourceFile"


# static fields
.field private static a:Ljava/lang/String;


# direct methods
.method static constructor <clinit>()V
    .locals 1

    .prologue
    .line 16
    const-string v0, ""

    sput-object v0, Lcom/cyjh/mobileanjian/ipc/utils/m;->a:Ljava/lang/String;

    return-void
.end method

.method public constructor <init>()V
    .locals 0

    .prologue
    .line 14
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method

.method private static a()Ljava/lang/String;
    .locals 5

    .prologue
    .line 19
    const-string v0, ""

    .line 22
    :try_start_0
    new-instance v1, Ljava/io/BufferedReader;

    new-instance v2, Ljava/io/InputStreamReader;

    new-instance v3, Ljava/io/FileInputStream;

    const-string v4, "/proc/cpuinfo"

    invoke-direct {v3, v4}, Ljava/io/FileInputStream;-><init>(Ljava/lang/String;)V

    invoke-direct {v2, v3}, Ljava/io/InputStreamReader;-><init>(Ljava/io/InputStream;)V

    invoke-direct {v1, v2}, Ljava/io/BufferedReader;-><init>(Ljava/io/Reader;)V

    .line 24
    :cond_0
    :goto_0
    invoke-virtual {v1}, Ljava/io/BufferedReader;->readLine()Ljava/lang/String;

    move-result-object v2

    if-eqz v2, :cond_1

    .line 25
    const-string v3, "Serial"

    invoke-virtual {v2, v3}, Ljava/lang/String;->startsWith(Ljava/lang/String;)Z

    move-result v3

    if-eqz v3, :cond_0

    .line 27
    const-string v3, ":"

    invoke-virtual {v2, v3}, Ljava/lang/String;->indexOf(Ljava/lang/String;)I

    move-result v3

    add-int/lit8 v3, v3, 0x1

    invoke-virtual {v2, v3}, Ljava/lang/String;->substring(I)Ljava/lang/String;

    move-result-object v0

    .line 28
    invoke-virtual {v0}, Ljava/lang/String;->trim()Ljava/lang/String;

    move-result-object v0

    goto :goto_0

    .line 30
    :cond_1
    invoke-virtual {v1}, Ljava/io/BufferedReader;->close()V
    :try_end_0
    .catch Ljava/io/IOException; {:try_start_0 .. :try_end_0} :catch_0

    .line 34
    :goto_1
    if-nez v0, :cond_2

    .line 35
    const-string v0, ""

    .line 38
    :cond_2
    const/4 v1, 0x0

    :goto_2
    invoke-virtual {v0}, Ljava/lang/String;->length()I

    move-result v2

    if-ge v1, v2, :cond_3

    .line 39
    invoke-virtual {v0, v1}, Ljava/lang/String;->charAt(I)C

    move-result v2

    const/16 v3, 0x30

    if-eq v2, v3, :cond_5

    .line 41
    :cond_3
    invoke-virtual {v0}, Ljava/lang/String;->length()I

    move-result v2

    if-ne v1, v2, :cond_4

    .line 42
    const-string v0, ""

    .line 43
    :cond_4
    return-object v0

    .line 38
    :cond_5
    add-int/lit8 v1, v1, 0x1

    goto :goto_2

    .line 31
    :catch_0
    move-exception v1

    goto :goto_1
.end method

.method public static a(Landroid/content/Context;)Ljava/lang/String;
    .locals 2

    .prologue
    .line 202
    sget-object v0, Lcom/cyjh/mobileanjian/ipc/utils/m;->a:Ljava/lang/String;

    const-string v1, ""

    if-eq v0, v1, :cond_0

    .line 204
    sget-object v0, Lcom/cyjh/mobileanjian/ipc/utils/m;->a:Ljava/lang/String;

    .line 213
    :goto_0
    return-object v0

    .line 207
    :cond_0
    invoke-static {p0}, Lcom/cyjh/mobileanjian/ipc/utils/m;->e(Landroid/content/Context;)Ljava/lang/String;

    move-result-object v0

    .line 208
    const-string v1, "null"

    invoke-virtual {v0, v1}, Ljava/lang/String;->endsWith(Ljava/lang/String;)Z

    move-result v1

    if-nez v1, :cond_1

    const-string v1, "unknown"

    invoke-virtual {v0, v1}, Ljava/lang/String;->endsWith(Ljava/lang/String;)Z

    move-result v1

    if-eqz v1, :cond_2

    .line 210
    :cond_1
    invoke-static {p0}, Lcom/cyjh/mobileanjian/ipc/utils/m;->f(Landroid/content/Context;)Ljava/lang/String;

    move-result-object v0

    .line 212
    :cond_2
    sput-object v0, Lcom/cyjh/mobileanjian/ipc/utils/m;->a:Ljava/lang/String;

    .line 213
    sget-object v0, Lcom/cyjh/mobileanjian/ipc/utils/m;->a:Ljava/lang/String;

    goto :goto_0
.end method

.method private static a(Landroid/content/Context;Z)Ljava/lang/String;
    .locals 4

    .prologue
    .line 108
    invoke-static {p0}, Lcom/cyjh/mobileanjian/ipc/utils/m;->d(Landroid/content/Context;)Ljava/lang/String;

    move-result-object v1

    .line 109
    invoke-static {}, Lcom/cyjh/mobileanjian/ipc/utils/m;->a()Ljava/lang/String;

    move-result-object v0

    .line 110
    invoke-static {}, Lcom/cyjh/mobileanjian/ipc/utils/m;->b()Ljava/lang/String;

    move-result-object v2

    .line 114
    if-eqz p1, :cond_1

    if-eqz v1, :cond_1

    const-string v3, ""

    if-eq v1, v3, :cond_1

    .line 115
    if-eqz v2, :cond_6

    const-string v0, ""

    if-eq v2, v0, :cond_6

    .line 116
    new-instance v0, Ljava/lang/StringBuilder;

    invoke-direct {v0}, Ljava/lang/StringBuilder;-><init>()V

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    const-string v3, "-"

    invoke-virtual {v0, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-virtual {v0, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-virtual {v0}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v0

    .line 125
    :cond_0
    :goto_0
    const-string v2, ""

    if-ne v1, v2, :cond_4

    .line 126
    new-instance v1, Ljava/lang/StringBuilder;

    invoke-direct {v1}, Ljava/lang/StringBuilder;-><init>()V

    const-string v2, "imei:none-"

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1, v0}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-virtual {v0}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v0

    .line 130
    :goto_1
    return-object v0

    .line 118
    :cond_1
    if-eqz v1, :cond_2

    const-string v3, ""

    if-ne v1, v3, :cond_5

    .line 121
    :cond_2
    :goto_2
    if-eqz v0, :cond_3

    const-string v3, ""

    if-ne v0, v3, :cond_0

    :cond_3
    move-object v0, v2

    .line 122
    goto :goto_0

    .line 128
    :cond_4
    new-instance v1, Ljava/lang/StringBuilder;

    invoke-direct {v1}, Ljava/lang/StringBuilder;-><init>()V

    const-string v2, "imei:"

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1, v0}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-virtual {v0}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v0

    goto :goto_1

    :cond_5
    move-object v0, v1

    goto :goto_2

    :cond_6
    move-object v0, v1

    goto :goto_0
.end method

.method private static b()Ljava/lang/String;
    .locals 5

    .prologue
    .line 51
    :try_start_0
    const-string v0, "android.os.SystemProperties"

    invoke-static {v0}, Ljava/lang/Class;->forName(Ljava/lang/String;)Ljava/lang/Class;

    move-result-object v0

    .line 52
    const-string v1, "get"

    const/4 v2, 0x2

    new-array v2, v2, [Ljava/lang/Class;

    const/4 v3, 0x0

    const-class v4, Ljava/lang/String;

    aput-object v4, v2, v3

    const/4 v3, 0x1

    const-class v4, Ljava/lang/String;

    aput-object v4, v2, v3

    invoke-virtual {v0, v1, v2}, Ljava/lang/Class;->getMethod(Ljava/lang/String;[Ljava/lang/Class;)Ljava/lang/reflect/Method;

    move-result-object v1

    .line 54
    const/4 v2, 0x2

    new-array v2, v2, [Ljava/lang/Object;

    const/4 v3, 0x0

    const-string v4, "ro.serialno"

    aput-object v4, v2, v3

    const/4 v3, 0x1

    const-string v4, "cyjhuser"

    aput-object v4, v2, v3

    invoke-virtual {v1, v0, v2}, Ljava/lang/reflect/Method;->invoke(Ljava/lang/Object;[Ljava/lang/Object;)Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Ljava/lang/String;
    :try_end_0
    .catch Ljava/lang/ClassNotFoundException; {:try_start_0 .. :try_end_0} :catch_0
    .catch Ljava/lang/NoSuchMethodException; {:try_start_0 .. :try_end_0} :catch_1
    .catch Ljava/lang/IllegalAccessException; {:try_start_0 .. :try_end_0} :catch_3
    .catch Ljava/lang/reflect/InvocationTargetException; {:try_start_0 .. :try_end_0} :catch_2

    .line 65
    :goto_0
    return-object v0

    .line 56
    :catch_0
    move-exception v0

    .line 57
    const-string v0, ""

    goto :goto_0

    .line 58
    :catch_1
    move-exception v0

    .line 59
    const-string v0, ""

    goto :goto_0

    .line 62
    :catch_2
    move-exception v0

    .line 65
    :goto_1
    const-string v0, ""

    goto :goto_0

    .line 60
    :catch_3
    move-exception v0

    goto :goto_1
.end method

.method public static b(Landroid/content/Context;)Ljava/lang/String;
    .locals 2

    .prologue
    .line 217
    invoke-static {p0}, Lcom/cyjh/mobileanjian/ipc/utils/m;->e(Landroid/content/Context;)Ljava/lang/String;

    move-result-object v0

    .line 218
    const-string v1, "null"

    invoke-virtual {v0, v1}, Ljava/lang/String;->endsWith(Ljava/lang/String;)Z

    move-result v1

    if-nez v1, :cond_0

    const-string v1, "unknown"

    invoke-virtual {v0, v1}, Ljava/lang/String;->endsWith(Ljava/lang/String;)Z

    move-result v1

    if-eqz v1, :cond_1

    .line 220
    :cond_0
    invoke-static {p0}, Lcom/cyjh/mobileanjian/ipc/utils/m;->g(Landroid/content/Context;)Ljava/lang/String;

    move-result-object v0

    .line 222
    :cond_1
    return-object v0
.end method

.method public static c(Landroid/content/Context;)Z
    .locals 2

    .prologue
    .line 227
    invoke-static {p0}, Lcom/cyjh/mobileanjian/ipc/utils/m;->e(Landroid/content/Context;)Ljava/lang/String;

    move-result-object v0

    .line 228
    const-string v1, "null"

    invoke-virtual {v0, v1}, Ljava/lang/String;->endsWith(Ljava/lang/String;)Z

    move-result v1

    if-nez v1, :cond_0

    const-string v1, "unknown"

    invoke-virtual {v0, v1}, Ljava/lang/String;->endsWith(Ljava/lang/String;)Z

    move-result v0

    if-eqz v0, :cond_1

    :cond_0
    const/4 v0, 0x1

    :goto_0
    return v0

    :cond_1
    const/4 v0, 0x0

    goto :goto_0
.end method

.method private static d(Landroid/content/Context;)Ljava/lang/String;
    .locals 7

    .prologue
    const/4 v6, 0x1

    const/4 v3, 0x0

    const/4 v5, 0x2

    .line 70
    const-string v0, ""

    const-string v0, ""

    const-string v2, ""

    .line 75
    :try_start_0
    const-string v0, "phone"

    invoke-virtual {p0, v0}, Landroid/content/Context;->getSystemService(Ljava/lang/String;)Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Landroid/telephony/TelephonyManager;

    .line 76
    invoke-virtual {v0}, Landroid/telephony/TelephonyManager;->getPhoneType()I
    :try_end_0
    .catch Ljava/lang/Exception; {:try_start_0 .. :try_end_0} :catch_0

    move-result v1

    .line 77
    :try_start_1
    invoke-virtual {v0}, Landroid/telephony/TelephonyManager;->getDeviceId()Ljava/lang/String;
    :try_end_1
    .catch Ljava/lang/Exception; {:try_start_1 .. :try_end_1} :catch_2

    move-result-object v0

    move v4, v1

    move-object v1, v0

    .line 83
    :goto_0
    :try_start_2
    const-string v0, "phone"

    invoke-virtual {p0, v0}, Landroid/content/Context;->getSystemService(Ljava/lang/String;)Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Landroid/telephony/TelephonyManager;

    .line 84
    invoke-virtual {v0}, Landroid/telephony/TelephonyManager;->getPhoneType()I

    move-result v3

    .line 85
    invoke-virtual {v0}, Landroid/telephony/TelephonyManager;->getDeviceId()Ljava/lang/String;
    :try_end_2
    .catch Ljava/lang/Exception; {:try_start_2 .. :try_end_2} :catch_1

    move-result-object v0

    .line 90
    :goto_1
    if-ne v4, v6, :cond_1

    .line 92
    if-ne v3, v5, :cond_4

    .line 93
    new-instance v2, Ljava/lang/StringBuilder;

    invoke-direct {v2}, Ljava/lang/StringBuilder;-><init>()V

    invoke-virtual {v2, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    const-string v2, "|"

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1, v0}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-virtual {v0}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v0

    .line 105
    :cond_0
    :goto_2
    return-object v0

    .line 78
    :catch_0
    move-exception v0

    move v0, v3

    .line 79
    :goto_3
    const-string v1, ""

    move v4, v0

    goto :goto_0

    .line 86
    :catch_1
    move-exception v0

    .line 87
    const-string v0, ""

    goto :goto_1

    .line 95
    :cond_1
    if-ne v3, v6, :cond_2

    .line 97
    if-ne v4, v5, :cond_0

    .line 98
    new-instance v2, Ljava/lang/StringBuilder;

    invoke-direct {v2}, Ljava/lang/StringBuilder;-><init>()V

    invoke-virtual {v2, v0}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    const-string v2, "|"

    invoke-virtual {v0, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-virtual {v0}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v0

    goto :goto_2

    .line 102
    :cond_2
    if-ne v4, v5, :cond_3

    move-object v0, v1

    .line 103
    goto :goto_2

    .line 78
    :catch_2
    move-exception v0

    move v0, v1

    goto :goto_3

    :cond_3
    move-object v0, v2

    goto :goto_2

    :cond_4
    move-object v0, v1

    goto :goto_2
.end method

.method private static e(Landroid/content/Context;)Ljava/lang/String;
    .locals 5

    .prologue
    .line 133
    const/4 v0, 0x0

    invoke-static {p0, v0}, Lcom/cyjh/mobileanjian/ipc/utils/m;->a(Landroid/content/Context;Z)Ljava/lang/String;

    move-result-object v1

    .line 134
    const-string v0, "unknown"

    .line 138
    :try_start_0
    new-instance v2, Ljava/io/BufferedReader;

    new-instance v0, Ljava/io/InputStreamReader;

    new-instance v3, Ljava/io/FileInputStream;

    const-string v4, "/proc/cpuinfo"

    invoke-direct {v3, v4}, Ljava/io/FileInputStream;-><init>(Ljava/lang/String;)V

    invoke-direct {v0, v3}, Ljava/io/InputStreamReader;-><init>(Ljava/io/InputStream;)V

    invoke-direct {v2, v0}, Ljava/io/BufferedReader;-><init>(Ljava/io/Reader;)V

    .line 139
    :cond_0
    invoke-virtual {v2}, Ljava/io/BufferedReader;->readLine()Ljava/lang/String;

    move-result-object v0

    if-eqz v0, :cond_1

    .line 140
    const-string v3, "Hardware"

    invoke-virtual {v0, v3}, Ljava/lang/String;->startsWith(Ljava/lang/String;)Z

    move-result v3

    if-eqz v3, :cond_0

    .line 142
    const-string v3, ":"

    invoke-virtual {v0, v3}, Ljava/lang/String;->split(Ljava/lang/String;)[Ljava/lang/String;

    move-result-object v0

    .line 144
    const/4 v3, 0x1

    aget-object v0, v0, v3

    invoke-virtual {v0}, Ljava/lang/String;->trim()Ljava/lang/String;

    move-result-object v0

    const-string v3, " "

    const-string v4, "_"

    invoke-virtual {v0, v3, v4}, Ljava/lang/String;->replaceAll(Ljava/lang/String;Ljava/lang/String;)Ljava/lang/String;

    move-result-object v0

    .line 147
    :cond_1
    invoke-virtual {v2}, Ljava/io/BufferedReader;->close()V
    :try_end_0
    .catch Ljava/io/FileNotFoundException; {:try_start_0 .. :try_end_0} :catch_0
    .catch Ljava/io/IOException; {:try_start_0 .. :try_end_0} :catch_1
    .catch Ljava/lang/Exception; {:try_start_0 .. :try_end_0} :catch_2

    .line 156
    :goto_0
    new-instance v2, Ljava/lang/StringBuilder;

    invoke-direct {v2}, Ljava/lang/StringBuilder;-><init>()V

    invoke-virtual {v2, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    const-string v2, "[arm]@_@"

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1, v0}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-virtual {v0}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v0

    .line 158
    return-object v0

    .line 148
    :catch_0
    move-exception v0

    .line 149
    const-string v0, "unknown"

    goto :goto_0

    .line 150
    :catch_1
    move-exception v0

    .line 151
    const-string v0, "unknown"

    goto :goto_0

    .line 152
    :catch_2
    move-exception v0

    .line 153
    const-string v0, "unknown"

    goto :goto_0
.end method

.method private static f(Landroid/content/Context;)Ljava/lang/String;
    .locals 3

    .prologue
    .line 163
    const/4 v0, 0x1

    invoke-static {p0, v0}, Lcom/cyjh/mobileanjian/ipc/utils/m;->a(Landroid/content/Context;Z)Ljava/lang/String;

    move-result-object v0

    .line 165
    const-string v1, "model"

    .line 169
    new-instance v2, Ljava/lang/StringBuilder;

    invoke-direct {v2}, Ljava/lang/StringBuilder;-><init>()V

    invoke-virtual {v2, v0}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    const-string v2, "[x86]@_@"

    invoke-virtual {v0, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-virtual {v0}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v0

    .line 170
    return-object v0
.end method

.method private static g(Landroid/content/Context;)Ljava/lang/String;
    .locals 5

    .prologue
    const/4 v0, 0x1

    .line 174
    invoke-static {p0, v0}, Lcom/cyjh/mobileanjian/ipc/utils/m;->a(Landroid/content/Context;Z)Ljava/lang/String;

    move-result-object v1

    .line 175
    const-string v0, "unknown"

    .line 178
    :try_start_0
    new-instance v2, Ljava/io/BufferedReader;

    new-instance v0, Ljava/io/InputStreamReader;

    new-instance v3, Ljava/io/FileInputStream;

    const-string v4, "/proc/cpuinfo"

    invoke-direct {v3, v4}, Ljava/io/FileInputStream;-><init>(Ljava/lang/String;)V

    invoke-direct {v0, v3}, Ljava/io/InputStreamReader;-><init>(Ljava/io/InputStream;)V

    invoke-direct {v2, v0}, Ljava/io/BufferedReader;-><init>(Ljava/io/Reader;)V

    .line 179
    :cond_0
    invoke-virtual {v2}, Ljava/io/BufferedReader;->readLine()Ljava/lang/String;

    move-result-object v0

    if-eqz v0, :cond_1

    .line 180
    const-string v3, "model name"

    invoke-virtual {v0, v3}, Ljava/lang/String;->startsWith(Ljava/lang/String;)Z

    move-result v3

    if-eqz v3, :cond_0

    .line 182
    const-string v3, ":"

    invoke-virtual {v0, v3}, Ljava/lang/String;->split(Ljava/lang/String;)[Ljava/lang/String;

    move-result-object v0

    .line 184
    const/4 v3, 0x1

    aget-object v0, v0, v3

    invoke-virtual {v0}, Ljava/lang/String;->trim()Ljava/lang/String;

    move-result-object v0

    const-string v3, " "

    const-string v4, "_"

    invoke-virtual {v0, v3, v4}, Ljava/lang/String;->replaceAll(Ljava/lang/String;Ljava/lang/String;)Ljava/lang/String;

    move-result-object v0

    .line 187
    :cond_1
    invoke-virtual {v2}, Ljava/io/BufferedReader;->close()V
    :try_end_0
    .catch Ljava/io/FileNotFoundException; {:try_start_0 .. :try_end_0} :catch_0
    .catch Ljava/io/IOException; {:try_start_0 .. :try_end_0} :catch_1
    .catch Ljava/lang/Exception; {:try_start_0 .. :try_end_0} :catch_2

    .line 197
    :goto_0
    new-instance v2, Ljava/lang/StringBuilder;

    invoke-direct {v2}, Ljava/lang/StringBuilder;-><init>()V

    invoke-virtual {v2, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    const-string v2, "[x86]@_@"

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1, v0}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-virtual {v0}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v0

    .line 198
    return-object v0

    .line 188
    :catch_0
    move-exception v0

    .line 189
    const-string v0, "unknown"

    goto :goto_0

    .line 190
    :catch_1
    move-exception v0

    .line 191
    const-string v0, "unknown"

    goto :goto_0

    .line 192
    :catch_2
    move-exception v0

    .line 193
    const-string v0, "unknown"

    goto :goto_0
.end method
