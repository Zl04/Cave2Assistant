.class public Lcom/cyjh/elfin/util/UniqIdUtil;
.super Ljava/lang/Object;
.source "UniqIdUtil.java"


# direct methods
.method public constructor <init>()V
    .locals 0

    .prologue
    .line 14
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method

.method private static getArmUniqId(Landroid/content/Context;)Ljava/lang/String;
    .locals 8
    .param p0, "context"    # Landroid/content/Context;

    .prologue
    .line 131
    const/4 v5, 0x0

    invoke-static {p0, v5}, Lcom/cyjh/elfin/util/UniqIdUtil;->getUniqIdCommon(Landroid/content/Context;Z)Ljava/lang/String;

    move-result-object v2

    .line 132
    .local v2, "id":Ljava/lang/String;
    const-string v3, ""

    .line 136
    .local v3, "model":Ljava/lang/String;
    :try_start_0
    new-instance v0, Ljava/io/BufferedReader;

    new-instance v5, Ljava/io/InputStreamReader;

    new-instance v6, Ljava/io/FileInputStream;

    const-string v7, "/proc/cpuinfo"

    invoke-direct {v6, v7}, Ljava/io/FileInputStream;-><init>(Ljava/lang/String;)V

    invoke-direct {v5, v6}, Ljava/io/InputStreamReader;-><init>(Ljava/io/InputStream;)V

    invoke-direct {v0, v5}, Ljava/io/BufferedReader;-><init>(Ljava/io/Reader;)V

    .line 137
    .local v0, "br":Ljava/io/BufferedReader;
    :cond_0
    invoke-virtual {v0}, Ljava/io/BufferedReader;->readLine()Ljava/lang/String;

    move-result-object v3

    if-eqz v3, :cond_1

    .line 138
    const-string v5, "Hardware"

    invoke-virtual {v3, v5}, Ljava/lang/String;->startsWith(Ljava/lang/String;)Z

    move-result v5

    if-eqz v5, :cond_0

    .line 140
    const-string v5, ":"

    invoke-virtual {v3, v5}, Ljava/lang/String;->split(Ljava/lang/String;)[Ljava/lang/String;

    move-result-object v4

    .line 142
    .local v4, "models":[Ljava/lang/String;
    const/4 v5, 0x1

    aget-object v5, v4, v5

    invoke-virtual {v5}, Ljava/lang/String;->trim()Ljava/lang/String;

    move-result-object v5

    const-string v6, " "

    const-string v7, "_"

    invoke-virtual {v5, v6, v7}, Ljava/lang/String;->replaceAll(Ljava/lang/String;Ljava/lang/String;)Ljava/lang/String;

    move-result-object v3

    .line 145
    .end local v4    # "models":[Ljava/lang/String;
    :cond_1
    invoke-virtual {v0}, Ljava/io/BufferedReader;->close()V
    :try_end_0
    .catch Ljava/io/FileNotFoundException; {:try_start_0 .. :try_end_0} :catch_0
    .catch Ljava/io/IOException; {:try_start_0 .. :try_end_0} :catch_1
    .catch Ljava/lang/Exception; {:try_start_0 .. :try_end_0} :catch_2

    .line 153
    .end local v0    # "br":Ljava/io/BufferedReader;
    :goto_0
    new-instance v5, Ljava/lang/StringBuilder;

    invoke-direct {v5}, Ljava/lang/StringBuilder;-><init>()V

    invoke-virtual {v5, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v5

    const-string v6, "-"

    invoke-virtual {v5, v6}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v5

    invoke-virtual {v5, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v5

    invoke-virtual {v5}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v2

    .line 154
    return-object v2

    .line 146
    :catch_0
    move-exception v1

    .line 147
    .local v1, "e":Ljava/io/FileNotFoundException;
    const-string v3, "unknown"

    .line 152
    goto :goto_0

    .line 148
    .end local v1    # "e":Ljava/io/FileNotFoundException;
    :catch_1
    move-exception v1

    .line 149
    .local v1, "e":Ljava/io/IOException;
    const-string v3, "unknown"

    .line 152
    goto :goto_0

    .line 150
    .end local v1    # "e":Ljava/io/IOException;
    :catch_2
    move-exception v1

    .line 151
    .local v1, "e":Ljava/lang/Exception;
    const-string v3, "unknown"

    goto :goto_0
.end method

.method private static getCpuSerial()Ljava/lang/String;
    .locals 7

    .prologue
    .line 17
    const-string v3, ""

    .line 20
    .local v3, "serial":Ljava/lang/String;
    :try_start_0
    new-instance v0, Ljava/io/BufferedReader;

    new-instance v4, Ljava/io/InputStreamReader;

    new-instance v5, Ljava/io/FileInputStream;

    const-string v6, "/proc/cpuinfo"

    invoke-direct {v5, v6}, Ljava/io/FileInputStream;-><init>(Ljava/lang/String;)V

    invoke-direct {v4, v5}, Ljava/io/InputStreamReader;-><init>(Ljava/io/InputStream;)V

    invoke-direct {v0, v4}, Ljava/io/BufferedReader;-><init>(Ljava/io/Reader;)V

    .line 22
    .local v0, "br":Ljava/io/BufferedReader;
    :cond_0
    :goto_0
    invoke-virtual {v0}, Ljava/io/BufferedReader;->readLine()Ljava/lang/String;

    move-result-object v2

    .local v2, "line":Ljava/lang/String;
    if-eqz v2, :cond_1

    .line 23
    const-string v4, "Serial"

    invoke-virtual {v2, v4}, Ljava/lang/String;->startsWith(Ljava/lang/String;)Z

    move-result v4

    if-eqz v4, :cond_0

    .line 25
    const-string v4, ":"

    invoke-virtual {v2, v4}, Ljava/lang/String;->indexOf(Ljava/lang/String;)I

    move-result v4

    add-int/lit8 v4, v4, 0x1

    invoke-virtual {v2, v4}, Ljava/lang/String;->substring(I)Ljava/lang/String;

    move-result-object v3

    .line 26
    invoke-virtual {v3}, Ljava/lang/String;->trim()Ljava/lang/String;

    move-result-object v3

    goto :goto_0

    .line 28
    :cond_1
    invoke-virtual {v0}, Ljava/io/BufferedReader;->close()V
    :try_end_0
    .catch Ljava/io/IOException; {:try_start_0 .. :try_end_0} :catch_0

    .line 32
    .end local v0    # "br":Ljava/io/BufferedReader;
    .end local v2    # "line":Ljava/lang/String;
    :goto_1
    if-nez v3, :cond_2

    .line 33
    const-string v3, ""

    .line 36
    :cond_2
    const/4 v1, 0x0

    .local v1, "i":I
    :goto_2
    invoke-virtual {v3}, Ljava/lang/String;->length()I

    move-result v4

    if-ge v1, v4, :cond_3

    .line 37
    invoke-virtual {v3, v1}, Ljava/lang/String;->charAt(I)C

    move-result v4

    const/16 v5, 0x30

    if-eq v4, v5, :cond_5

    .line 39
    :cond_3
    invoke-virtual {v3}, Ljava/lang/String;->length()I

    move-result v4

    if-ne v1, v4, :cond_4

    .line 40
    const-string v3, ""

    .line 41
    :cond_4
    return-object v3

    .line 36
    :cond_5
    add-int/lit8 v1, v1, 0x1

    goto :goto_2

    .line 29
    .end local v1    # "i":I
    :catch_0
    move-exception v4

    goto :goto_1
.end method

.method private static getImei(Landroid/content/Context;)Ljava/lang/String;
    .locals 11
    .param p0, "context"    # Landroid/content/Context;

    .prologue
    const/4 v10, 0x1

    const/4 v9, 0x2

    .line 68
    const-string v3, ""

    .local v3, "imei1":Ljava/lang/String;
    const-string v4, ""

    .local v4, "imei2":Ljava/lang/String;
    const-string v2, ""

    .line 69
    .local v2, "imei":Ljava/lang/String;
    const/4 v5, 0x0

    .line 70
    .local v5, "phone_type1":I
    const/4 v6, 0x0

    .line 71
    .local v6, "phone_type2":I
    const/4 v7, 0x0

    .line 73
    .local v7, "tm":Landroid/telephony/TelephonyManager;
    :try_start_0
    const-string v8, "phone"

    invoke-virtual {p0, v8}, Landroid/content/Context;->getSystemService(Ljava/lang/String;)Ljava/lang/Object;

    move-result-object v8

    move-object v0, v8

    check-cast v0, Landroid/telephony/TelephonyManager;

    move-object v7, v0

    .line 74
    invoke-virtual {v7}, Landroid/telephony/TelephonyManager;->getPhoneType()I

    move-result v5

    .line 75
    invoke-virtual {v7}, Landroid/telephony/TelephonyManager;->getDeviceId()Ljava/lang/String;
    :try_end_0
    .catch Ljava/lang/Exception; {:try_start_0 .. :try_end_0} :catch_0

    move-result-object v3

    .line 81
    :goto_0
    :try_start_1
    const-string v8, "phone2"

    invoke-virtual {p0, v8}, Landroid/content/Context;->getSystemService(Ljava/lang/String;)Ljava/lang/Object;

    move-result-object v8

    move-object v0, v8

    check-cast v0, Landroid/telephony/TelephonyManager;

    move-object v7, v0

    .line 82
    invoke-virtual {v7}, Landroid/telephony/TelephonyManager;->getPhoneType()I

    move-result v6

    .line 83
    invoke-virtual {v7}, Landroid/telephony/TelephonyManager;->getDeviceId()Ljava/lang/String;
    :try_end_1
    .catch Ljava/lang/Exception; {:try_start_1 .. :try_end_1} :catch_1

    move-result-object v4

    .line 88
    :goto_1
    if-ne v5, v10, :cond_1

    .line 89
    move-object v2, v3

    .line 90
    if-ne v6, v9, :cond_0

    .line 91
    new-instance v8, Ljava/lang/StringBuilder;

    invoke-direct {v8}, Ljava/lang/StringBuilder;-><init>()V

    invoke-virtual {v8, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v8

    const-string v9, "|"

    invoke-virtual {v8, v9}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v8

    invoke-virtual {v8, v4}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v8

    invoke-virtual {v8}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v2

    .line 103
    :cond_0
    :goto_2
    return-object v2

    .line 76
    :catch_0
    move-exception v1

    .line 77
    .local v1, "e":Ljava/lang/Exception;
    const-string v3, ""

    goto :goto_0

    .line 84
    .end local v1    # "e":Ljava/lang/Exception;
    :catch_1
    move-exception v1

    .line 85
    .restart local v1    # "e":Ljava/lang/Exception;
    const-string v4, ""

    goto :goto_1

    .line 93
    .end local v1    # "e":Ljava/lang/Exception;
    :cond_1
    if-ne v6, v10, :cond_2

    .line 94
    move-object v2, v4

    .line 95
    if-ne v5, v9, :cond_0

    .line 96
    new-instance v8, Ljava/lang/StringBuilder;

    invoke-direct {v8}, Ljava/lang/StringBuilder;-><init>()V

    invoke-virtual {v8, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v8

    const-string v9, "|"

    invoke-virtual {v8, v9}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v8

    invoke-virtual {v8, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v8

    invoke-virtual {v8}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v2

    goto :goto_2

    .line 100
    :cond_2
    if-ne v5, v9, :cond_0

    .line 101
    move-object v2, v3

    goto :goto_2
.end method

.method private static getOtherUniqId(Landroid/content/Context;)Ljava/lang/String;
    .locals 7
    .param p0, "context"    # Landroid/content/Context;

    .prologue
    const/4 v4, 0x1

    .line 159
    invoke-static {p0, v4}, Lcom/cyjh/elfin/util/UniqIdUtil;->getUniqIdCommon(Landroid/content/Context;Z)Ljava/lang/String;

    move-result-object v1

    .line 160
    .local v1, "id":Ljava/lang/String;
    const-string v2, ""

    .line 163
    .local v2, "model":Ljava/lang/String;
    :try_start_0
    new-instance v0, Ljava/io/BufferedReader;

    new-instance v4, Ljava/io/InputStreamReader;

    new-instance v5, Ljava/io/FileInputStream;

    const-string v6, "/proc/cpuinfo"

    invoke-direct {v5, v6}, Ljava/io/FileInputStream;-><init>(Ljava/lang/String;)V

    invoke-direct {v4, v5}, Ljava/io/InputStreamReader;-><init>(Ljava/io/InputStream;)V

    invoke-direct {v0, v4}, Ljava/io/BufferedReader;-><init>(Ljava/io/Reader;)V

    .line 164
    .local v0, "br":Ljava/io/BufferedReader;
    :cond_0
    invoke-virtual {v0}, Ljava/io/BufferedReader;->readLine()Ljava/lang/String;

    move-result-object v2

    if-eqz v2, :cond_1

    .line 165
    const-string v4, "model name"

    invoke-virtual {v2, v4}, Ljava/lang/String;->startsWith(Ljava/lang/String;)Z

    move-result v4

    if-eqz v4, :cond_0

    .line 167
    const-string v4, ":"

    invoke-virtual {v2, v4}, Ljava/lang/String;->split(Ljava/lang/String;)[Ljava/lang/String;

    move-result-object v3

    .line 169
    .local v3, "models":[Ljava/lang/String;
    const/4 v4, 0x1

    aget-object v4, v3, v4

    invoke-virtual {v4}, Ljava/lang/String;->trim()Ljava/lang/String;

    move-result-object v4

    const-string v5, " "

    const-string v6, "_"

    invoke-virtual {v4, v5, v6}, Ljava/lang/String;->replaceAll(Ljava/lang/String;Ljava/lang/String;)Ljava/lang/String;

    move-result-object v2

    .line 172
    .end local v3    # "models":[Ljava/lang/String;
    :cond_1
    invoke-virtual {v0}, Ljava/io/BufferedReader;->close()V
    :try_end_0
    .catch Ljava/io/FileNotFoundException; {:try_start_0 .. :try_end_0} :catch_2
    .catch Ljava/io/IOException; {:try_start_0 .. :try_end_0} :catch_1
    .catch Ljava/lang/Exception; {:try_start_0 .. :try_end_0} :catch_0

    .line 181
    .end local v0    # "br":Ljava/io/BufferedReader;
    :goto_0
    if-eqz v2, :cond_2

    .line 182
    new-instance v4, Ljava/lang/StringBuilder;

    invoke-direct {v4}, Ljava/lang/StringBuilder;-><init>()V

    invoke-virtual {v4, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v4

    const-string v5, "-"

    invoke-virtual {v4, v5}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v4

    invoke-virtual {v4, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v4

    invoke-virtual {v4}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v1

    .line 184
    :cond_2
    return-object v1

    .line 177
    :catch_0
    move-exception v4

    goto :goto_0

    .line 175
    :catch_1
    move-exception v4

    goto :goto_0

    .line 173
    :catch_2
    move-exception v4

    goto :goto_0
.end method

.method private static getSerialno()Ljava/lang/String;
    .locals 8

    .prologue
    .line 49
    :try_start_0
    const-string v4, "android.os.SystemProperties"

    invoke-static {v4}, Ljava/lang/Class;->forName(Ljava/lang/String;)Ljava/lang/Class;

    move-result-object v0

    .line 50
    .local v0, "SystemProperties":Ljava/lang/Class;, "Ljava/lang/Class<*>;"
    const-string v4, "get"

    const/4 v5, 0x2

    new-array v5, v5, [Ljava/lang/Class;

    const/4 v6, 0x0

    const-class v7, Ljava/lang/String;

    aput-object v7, v5, v6

    const/4 v6, 0x1

    const-class v7, Ljava/lang/String;

    aput-object v7, v5, v6

    invoke-virtual {v0, v4, v5}, Ljava/lang/Class;->getMethod(Ljava/lang/String;[Ljava/lang/Class;)Ljava/lang/reflect/Method;

    move-result-object v2

    .line 52
    .local v2, "method":Ljava/lang/reflect/Method;
    const/4 v4, 0x2

    new-array v4, v4, [Ljava/lang/Object;

    const/4 v5, 0x0

    const-string v6, "ro.serialno"

    aput-object v6, v4, v5

    const/4 v5, 0x1

    const-string v6, "cyjhuser"

    aput-object v6, v4, v5

    invoke-virtual {v2, v0, v4}, Ljava/lang/reflect/Method;->invoke(Ljava/lang/Object;[Ljava/lang/Object;)Ljava/lang/Object;

    move-result-object v3

    check-cast v3, Ljava/lang/String;
    :try_end_0
    .catch Ljava/lang/ClassNotFoundException; {:try_start_0 .. :try_end_0} :catch_0
    .catch Ljava/lang/NoSuchMethodException; {:try_start_0 .. :try_end_0} :catch_1
    .catch Ljava/lang/IllegalAccessException; {:try_start_0 .. :try_end_0} :catch_3
    .catch Ljava/lang/reflect/InvocationTargetException; {:try_start_0 .. :try_end_0} :catch_2

    .line 63
    .end local v2    # "method":Ljava/lang/reflect/Method;
    :goto_0
    return-object v3

    .line 54
    :catch_0
    move-exception v1

    .line 55
    .local v1, "e":Ljava/lang/ClassNotFoundException;
    const-string v3, ""

    goto :goto_0

    .line 56
    .end local v1    # "e":Ljava/lang/ClassNotFoundException;
    :catch_1
    move-exception v1

    .line 57
    .local v1, "e":Ljava/lang/NoSuchMethodException;
    const-string v3, ""

    goto :goto_0

    .line 60
    .end local v1    # "e":Ljava/lang/NoSuchMethodException;
    :catch_2
    move-exception v4

    .line 63
    :goto_1
    const-string v3, ""

    goto :goto_0

    .line 58
    :catch_3
    move-exception v4

    goto :goto_1
.end method

.method public static getUniqId(Landroid/content/Context;)Ljava/lang/String;
    .locals 3
    .param p0, "context"    # Landroid/content/Context;

    .prologue
    .line 188
    const-string v1, "os.arch"

    invoke-static {v1}, Ljava/lang/System;->getProperty(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v0

    .line 189
    .local v0, "arch":Ljava/lang/String;
    const-string v1, "arm"

    invoke-virtual {v0, v1}, Ljava/lang/String;->indexOf(Ljava/lang/String;)I

    move-result v1

    const/4 v2, -0x1

    if-eq v1, v2, :cond_0

    .line 190
    invoke-static {p0}, Lcom/cyjh/elfin/util/UniqIdUtil;->getArmUniqId(Landroid/content/Context;)Ljava/lang/String;

    move-result-object v1

    .line 192
    :goto_0
    return-object v1

    :cond_0
    invoke-static {p0}, Lcom/cyjh/elfin/util/UniqIdUtil;->getOtherUniqId(Landroid/content/Context;)Ljava/lang/String;

    move-result-object v1

    goto :goto_0
.end method

.method private static getUniqIdCommon(Landroid/content/Context;Z)Ljava/lang/String;
    .locals 6
    .param p0, "context"    # Landroid/content/Context;
    .param p1, "bKP"    # Z

    .prologue
    .line 106
    invoke-static {p0}, Lcom/cyjh/elfin/util/UniqIdUtil;->getImei(Landroid/content/Context;)Ljava/lang/String;

    move-result-object v2

    .line 107
    .local v2, "imei":Ljava/lang/String;
    invoke-static {}, Lcom/cyjh/elfin/util/UniqIdUtil;->getCpuSerial()Ljava/lang/String;

    move-result-object v0

    .line 108
    .local v0, "cpuSerial":Ljava/lang/String;
    invoke-static {}, Lcom/cyjh/elfin/util/UniqIdUtil;->getSerialno()Ljava/lang/String;

    move-result-object v3

    .line 110
    .local v3, "roSerial":Ljava/lang/String;
    move-object v1, v2

    .line 112
    .local v1, "id":Ljava/lang/String;
    if-eqz p1, :cond_1

    if-eqz v2, :cond_1

    const-string v4, ""

    if-eq v2, v4, :cond_1

    .line 113
    if-eqz v3, :cond_0

    const-string v4, ""

    if-eq v3, v4, :cond_0

    .line 114
    new-instance v4, Ljava/lang/StringBuilder;

    invoke-direct {v4}, Ljava/lang/StringBuilder;-><init>()V

    invoke-virtual {v4, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v4

    const-string v5, "-"

    invoke-virtual {v4, v5}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v4

    invoke-virtual {v4, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v4

    invoke-virtual {v4}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v1

    .line 123
    :cond_0
    :goto_0
    const-string v4, ""

    if-ne v2, v4, :cond_5

    .line 124
    new-instance v4, Ljava/lang/StringBuilder;

    invoke-direct {v4}, Ljava/lang/StringBuilder;-><init>()V

    const-string v5, "imei:none-"

    invoke-virtual {v4, v5}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v4

    invoke-virtual {v4, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v4

    invoke-virtual {v4}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v1

    .line 128
    :goto_1
    return-object v1

    .line 116
    :cond_1
    if-eqz v1, :cond_2

    const-string v4, ""

    if-ne v1, v4, :cond_3

    .line 117
    :cond_2
    move-object v1, v0

    .line 119
    :cond_3
    if-eqz v1, :cond_4

    const-string v4, ""

    if-ne v1, v4, :cond_0

    .line 120
    :cond_4
    move-object v1, v3

    goto :goto_0

    .line 126
    :cond_5
    new-instance v4, Ljava/lang/StringBuilder;

    invoke-direct {v4}, Ljava/lang/StringBuilder;-><init>()V

    const-string v5, "imei:"

    invoke-virtual {v4, v5}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v4

    invoke-virtual {v4, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v4

    invoke-virtual {v4}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v1

    goto :goto_1
.end method
