.class public final Lcom/goldcoast/sdk/c/d;
.super Ljava/lang/Object;
.source "SourceFile"


# static fields
.field private static a:Lcom/goldcoast/sdk/c/d;

.field private static b:Landroid/content/Context;


# direct methods
.method private constructor <init>()V
    .locals 0

    .prologue
    .line 20
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    .line 22
    return-void
.end method

.method public static a()Lcom/goldcoast/sdk/a/b;
    .locals 9

    .prologue
    const/4 v1, 0x0

    .line 33
    new-instance v4, Lcom/goldcoast/sdk/a/b;

    invoke-direct {v4}, Lcom/goldcoast/sdk/a/b;-><init>()V

    .line 35
    new-instance v5, Ljava/util/HashMap;

    invoke-direct {v5}, Ljava/util/HashMap;-><init>()V

    .line 39
    new-instance v0, Ljava/util/HashMap;

    invoke-direct {v0}, Ljava/util/HashMap;-><init>()V

    .line 40
    const-string v3, ""

    .line 41
    const-string v2, ""

    .line 48
    invoke-static {}, Lcom/goldcoast/sdk/c/d;->c()Lcom/goldcoast/sdk/a/e;

    move-result-object v6

    .line 52
    :try_start_0
    const-string v7, "MemTotal"

    const-string v8, ""

    invoke-interface {v0, v7, v8}, Ljava/util/Map;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    .line 53
    new-instance v7, Ljava/io/FileInputStream;

    const-string v8, "/proc/meminfo"

    invoke-direct {v7, v8}, Ljava/io/FileInputStream;-><init>(Ljava/lang/String;)V

    .line 54
    invoke-static {v7, v0}, Lcom/goldcoast/sdk/c/f;->a(Ljava/io/InputStream;Ljava/util/Map;)Ljava/lang/String;

    .line 55
    const-string v7, "MemTotal"

    invoke-interface {v0, v7}, Ljava/util/Map;->get(Ljava/lang/Object;)Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Ljava/lang/String;
    :try_end_0
    .catch Ljava/io/FileNotFoundException; {:try_start_0 .. :try_end_0} :catch_0

    move-object v3, v0

    .line 62
    :goto_0
    :try_start_1
    new-instance v0, Ljava/io/FileInputStream;

    const-string v7, "/proc/version"

    invoke-direct {v0, v7}, Ljava/io/FileInputStream;-><init>(Ljava/lang/String;)V

    .line 63
    const/4 v7, 0x0

    invoke-static {v0, v7}, Lcom/goldcoast/sdk/c/f;->a(Ljava/io/InputStream;Ljava/util/Map;)Ljava/lang/String;

    move-result-object v0

    .line 1129
    const-string v7, " "

    invoke-virtual {v0, v7}, Ljava/lang/String;->split(Ljava/lang/String;)[Ljava/lang/String;

    move-result-object v0

    const/4 v7, 0x2

    aget-object v0, v0, v7
    :try_end_1
    .catch Ljava/io/FileNotFoundException; {:try_start_1 .. :try_end_1} :catch_1

    move-object v2, v0

    .line 72
    :goto_1
    :try_start_2
    new-instance v0, Ljava/io/FileInputStream;

    const-string v7, "/proc/cpuinfo"

    invoke-direct {v0, v7}, Ljava/io/FileInputStream;-><init>(Ljava/lang/String;)V

    .line 73
    invoke-static {v0, v5}, Lcom/goldcoast/sdk/c/f;->a(Ljava/io/InputStream;Ljava/util/Map;)Ljava/lang/String;

    .line 74
    new-instance v0, Lcom/goldcoast/sdk/a/a;

    invoke-direct {v0, v5}, Lcom/goldcoast/sdk/a/a;-><init>(Ljava/util/Map;)V
    :try_end_2
    .catch Ljava/io/FileNotFoundException; {:try_start_2 .. :try_end_2} :catch_2

    .line 90
    :goto_2
    invoke-virtual {v4, v0}, Lcom/goldcoast/sdk/a/b;->a(Lcom/goldcoast/sdk/a/a;)V

    .line 92
    invoke-virtual {v4, v6}, Lcom/goldcoast/sdk/a/b;->a(Lcom/goldcoast/sdk/a/e;)V

    .line 93
    invoke-virtual {v4, v2}, Lcom/goldcoast/sdk/a/b;->b(Ljava/lang/String;)V

    .line 94
    invoke-virtual {v4, v3}, Lcom/goldcoast/sdk/a/b;->a(Ljava/lang/String;)V

    .line 95
    invoke-static {}, Lcom/goldcoast/sdk/c/d;->d()Ljava/lang/String;

    move-result-object v0

    invoke-virtual {v4, v0}, Lcom/goldcoast/sdk/a/b;->c(Ljava/lang/String;)V

    .line 96
    invoke-static {}, Lcom/goldcoast/sdk/c/d;->b()Ljava/lang/String;

    move-result-object v0

    invoke-virtual {v4, v0}, Lcom/goldcoast/sdk/a/b;->e(Ljava/lang/String;)V

    .line 97
    invoke-static {}, Lcom/goldcoast/sdk/c/d;->e()Ljava/lang/String;

    move-result-object v0

    invoke-virtual {v4, v0}, Lcom/goldcoast/sdk/a/b;->d(Ljava/lang/String;)V

    .line 98
    invoke-static {}, Lcom/goldcoast/sdk/c/b;->a()Ljava/lang/String;

    move-result-object v0

    invoke-virtual {v4, v0}, Lcom/goldcoast/sdk/a/b;->g(Ljava/lang/String;)V

    .line 100
    invoke-static {}, Ljava/lang/System;->currentTimeMillis()J

    move-result-wide v0

    invoke-static {v0, v1}, Ljava/lang/String;->valueOf(J)Ljava/lang/String;

    move-result-object v0

    invoke-virtual {v4, v0}, Lcom/goldcoast/sdk/a/b;->f(Ljava/lang/String;)V

    .line 101
    return-object v4

    .line 57
    :catch_0
    move-exception v0

    invoke-virtual {v0}, Ljava/io/FileNotFoundException;->printStackTrace()V

    goto :goto_0

    .line 67
    :catch_1
    move-exception v0

    invoke-virtual {v0}, Ljava/io/FileNotFoundException;->printStackTrace()V

    goto :goto_1

    .line 76
    :catch_2
    move-exception v0

    invoke-virtual {v0}, Ljava/io/FileNotFoundException;->printStackTrace()V

    move-object v0, v1

    goto :goto_2
.end method

.method public static a(Landroid/content/Context;)Lcom/goldcoast/sdk/c/d;
    .locals 1

    .prologue
    .line 25
    sput-object p0, Lcom/goldcoast/sdk/c/d;->b:Landroid/content/Context;

    .line 26
    sget-object v0, Lcom/goldcoast/sdk/c/d;->a:Lcom/goldcoast/sdk/c/d;

    if-nez v0, :cond_0

    .line 27
    new-instance v0, Lcom/goldcoast/sdk/c/d;

    invoke-direct {v0}, Lcom/goldcoast/sdk/c/d;-><init>()V

    sput-object v0, Lcom/goldcoast/sdk/c/d;->a:Lcom/goldcoast/sdk/c/d;

    .line 29
    :cond_0
    sget-object v0, Lcom/goldcoast/sdk/c/d;->a:Lcom/goldcoast/sdk/c/d;

    return-object v0
.end method

.method public static b()Ljava/lang/String;
    .locals 3

    .prologue
    .line 144
    const-string v0, "0"

    .line 146
    :try_start_0
    sget-object v1, Lcom/goldcoast/sdk/c/d;->b:Landroid/content/Context;

    invoke-virtual {v1}, Landroid/content/Context;->getContentResolver()Landroid/content/ContentResolver;

    move-result-object v1

    const-string v2, "android_id"

    invoke-static {v1, v2}, Landroid/provider/Settings$Secure;->getString(Landroid/content/ContentResolver;Ljava/lang/String;)Ljava/lang/String;
    :try_end_0
    .catch Ljava/lang/Exception; {:try_start_0 .. :try_end_0} :catch_0

    move-result-object v0

    .line 150
    :goto_0
    return-object v0

    .line 148
    :catch_0
    move-exception v1

    invoke-virtual {v1}, Ljava/lang/Exception;->printStackTrace()V

    goto :goto_0
.end method

.method public static c()Lcom/goldcoast/sdk/a/e;
    .locals 6

    .prologue
    const/16 v5, 0x19

    const/4 v0, 0x0

    .line 165
    new-instance v1, Ljava/util/HashMap;

    invoke-direct {v1}, Ljava/util/HashMap;-><init>()V

    .line 1209
    new-array v2, v5, [Ljava/lang/String;

    const-string v3, "ro.product.brand"

    aput-object v3, v2, v0

    const/4 v3, 0x1

    const-string v4, "ro.product.name"

    aput-object v4, v2, v3

    const/4 v3, 0x2

    const-string v4, "ro.product.model"

    aput-object v4, v2, v3

    const/4 v3, 0x3

    const-string v4, "ro.build.fingerprint"

    aput-object v4, v2, v3

    const/4 v3, 0x4

    const-string v4, "ro.build.version.sdk"

    aput-object v4, v2, v3

    const/4 v3, 0x5

    const-string v4, "ro.build.version.release"

    aput-object v4, v2, v3

    const/4 v3, 0x6

    const-string v4, "ro.build.date"

    aput-object v4, v2, v3

    const/4 v3, 0x7

    const-string v4, "ro.build.date.utc"

    aput-object v4, v2, v3

    const/16 v3, 0x8

    const-string v4, "ro.boot.cpuid"

    aput-object v4, v2, v3

    const/16 v3, 0x9

    const-string v4, "ro.btconfig.vendor"

    aput-object v4, v2, v3

    const/16 v3, 0xa

    const-string v4, "persist.sys.timezone"

    aput-object v4, v2, v3

    const/16 v3, 0xb

    const-string v4, "persist.sys.country"

    aput-object v4, v2, v3

    const/16 v3, 0xc

    const-string v4, "persist.sys.language"

    aput-object v4, v2, v3

    const/16 v3, 0xd

    const-string v4, "persist.sys.dalvik.vm.lib"

    aput-object v4, v2, v3

    const/16 v3, 0xe

    const-string v4, "ro.build.description"

    aput-object v4, v2, v3

    const/16 v3, 0xf

    const-string v4, "ro.runtime.firstboot"

    aput-object v4, v2, v3

    const/16 v3, 0x10

    const-string v4, "ro.serialno"

    aput-object v4, v2, v3

    const/16 v3, 0x11

    const-string v4, "ro.hardware"

    aput-object v4, v2, v3

    const/16 v3, 0x12

    const-string v4, "ro.product.board"

    aput-object v4, v2, v3

    const/16 v3, 0x13

    const-string v4, "ro.product.locale.language"

    aput-object v4, v2, v3

    const/16 v3, 0x14

    const-string v4, "ro.product.locale.region"

    aput-object v4, v2, v3

    const/16 v3, 0x15

    const-string v4, "ro.product.cpu.abi"

    aput-object v4, v2, v3

    const/16 v3, 0x16

    const-string v4, "ro.board.platform"

    aput-object v4, v2, v3

    const/16 v3, 0x17

    const-string v4, "ro.build.selinux"

    aput-object v4, v2, v3

    const/16 v3, 0x18

    const-string v4, "ro.build.selinux.enforce"

    aput-object v4, v2, v3

    .line 166
    :goto_0
    if-ge v0, v5, :cond_0

    aget-object v3, v2, v0

    .line 167
    const-string v4, ""

    invoke-interface {v1, v3, v4}, Ljava/util/Map;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    .line 166
    add-int/lit8 v0, v0, 0x1

    goto :goto_0

    .line 170
    :cond_0
    invoke-interface {v1}, Ljava/util/Map;->entrySet()Ljava/util/Set;

    move-result-object v0

    invoke-interface {v0}, Ljava/util/Set;->iterator()Ljava/util/Iterator;

    move-result-object v2

    :goto_1
    invoke-interface {v2}, Ljava/util/Iterator;->hasNext()Z

    move-result v0

    if-eqz v0, :cond_1

    invoke-interface {v2}, Ljava/util/Iterator;->next()Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Ljava/util/Map$Entry;

    .line 171
    invoke-interface {v0}, Ljava/util/Map$Entry;->getKey()Ljava/lang/Object;

    move-result-object v3

    invoke-interface {v0}, Ljava/util/Map$Entry;->getKey()Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Ljava/lang/String;

    invoke-static {v0}, Lcom/goldcoast/sdk/c/i;->a(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v0

    invoke-interface {v1, v3, v0}, Ljava/util/Map;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    goto :goto_1

    .line 174
    :cond_1
    new-instance v0, Lcom/goldcoast/sdk/a/e;

    invoke-direct {v0, v1}, Lcom/goldcoast/sdk/a/e;-><init>(Ljava/util/Map;)V

    return-object v0
.end method

.method private static d()Ljava/lang/String;
    .locals 3

    .prologue
    .line 133
    const-string v1, "0"

    .line 135
    :try_start_0
    sget-object v0, Lcom/goldcoast/sdk/c/d;->b:Landroid/content/Context;

    const-string v2, "phone"

    invoke-virtual {v0, v2}, Landroid/content/Context;->getSystemService(Ljava/lang/String;)Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Landroid/telephony/TelephonyManager;

    .line 136
    invoke-virtual {v0}, Landroid/telephony/TelephonyManager;->getDeviceId()Ljava/lang/String;
    :try_end_0
    .catch Ljava/lang/Exception; {:try_start_0 .. :try_end_0} :catch_0

    move-result-object v0

    .line 140
    :goto_0
    return-object v0

    .line 138
    :catch_0
    move-exception v0

    invoke-virtual {v0}, Ljava/lang/Exception;->printStackTrace()V

    move-object v0, v1

    goto :goto_0
.end method

.method private static e()Ljava/lang/String;
    .locals 3

    .prologue
    .line 154
    const-string v1, "0"

    .line 156
    :try_start_0
    sget-object v0, Lcom/goldcoast/sdk/c/d;->b:Landroid/content/Context;

    const-string v2, "wifi"

    invoke-virtual {v0, v2}, Landroid/content/Context;->getSystemService(Ljava/lang/String;)Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Landroid/net/wifi/WifiManager;

    .line 157
    invoke-virtual {v0}, Landroid/net/wifi/WifiManager;->getConnectionInfo()Landroid/net/wifi/WifiInfo;

    move-result-object v0

    invoke-virtual {v0}, Landroid/net/wifi/WifiInfo;->getMacAddress()Ljava/lang/String;
    :try_end_0
    .catch Ljava/lang/Exception; {:try_start_0 .. :try_end_0} :catch_0

    move-result-object v0

    .line 161
    :goto_0
    return-object v0

    .line 159
    :catch_0
    move-exception v0

    invoke-virtual {v0}, Ljava/lang/Exception;->printStackTrace()V

    move-object v0, v1

    goto :goto_0
.end method
