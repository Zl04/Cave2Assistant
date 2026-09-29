.class public Lcom/cyjh/mobileanjian/ipc/rpc/AndroidHelper;
.super Ljava/lang/Object;
.source "SourceFile"


# static fields
.field private static a:Landroid/content/Context;

.field private static b:I

.field private static c:Z


# direct methods
.method static constructor <clinit>()V
    .locals 1

    .prologue
    .line 59
    const/4 v0, 0x0

    sput-object v0, Lcom/cyjh/mobileanjian/ipc/rpc/AndroidHelper;->a:Landroid/content/Context;

    .line 243
    const/16 v0, 0x64

    sput v0, Lcom/cyjh/mobileanjian/ipc/rpc/AndroidHelper;->b:I

    return-void
.end method

.method public constructor <init>()V
    .locals 0

    .prologue
    .line 57
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method

.method static synthetic a(I)I
    .locals 0

    .prologue
    .line 57
    sput p0, Lcom/cyjh/mobileanjian/ipc/rpc/AndroidHelper;->b:I

    return p0
.end method

.method static synthetic a(Z)Z
    .locals 0

    .prologue
    .line 57
    sput-boolean p0, Lcom/cyjh/mobileanjian/ipc/rpc/AndroidHelper;->c:Z

    return p0
.end method

.method public static batteryLevel()Ljava/lang/String;
    .locals 3

    .prologue
    .line 248
    const/4 v0, 0x0

    sput-boolean v0, Lcom/cyjh/mobileanjian/ipc/rpc/AndroidHelper;->c:Z

    .line 249
    new-instance v0, Lcom/cyjh/mobileanjian/ipc/rpc/AndroidHelper$1;

    invoke-direct {v0}, Lcom/cyjh/mobileanjian/ipc/rpc/AndroidHelper$1;-><init>()V

    .line 263
    new-instance v1, Landroid/content/IntentFilter;

    const-string v2, "android.intent.action.BATTERY_CHANGED"

    invoke-direct {v1, v2}, Landroid/content/IntentFilter;-><init>(Ljava/lang/String;)V

    .line 264
    sget-object v2, Lcom/cyjh/mobileanjian/ipc/rpc/AndroidHelper;->a:Landroid/content/Context;

    invoke-virtual {v2, v0, v1}, Landroid/content/Context;->registerReceiver(Landroid/content/BroadcastReceiver;Landroid/content/IntentFilter;)Landroid/content/Intent;

    .line 265
    :goto_0
    sget-boolean v0, Lcom/cyjh/mobileanjian/ipc/rpc/AndroidHelper;->c:Z

    if-nez v0, :cond_0

    .line 269
    const-wide/16 v0, 0xa

    :try_start_0
    invoke-static {v0, v1}, Ljava/lang/Thread;->sleep(J)V
    :try_end_0
    .catch Ljava/lang/InterruptedException; {:try_start_0 .. :try_end_0} :catch_0

    goto :goto_0

    .line 270
    :catch_0
    move-exception v0

    .line 272
    invoke-virtual {v0}, Ljava/lang/InterruptedException;->printStackTrace()V

    goto :goto_0

    .line 275
    :cond_0
    sget v0, Lcom/cyjh/mobileanjian/ipc/rpc/AndroidHelper;->b:I

    invoke-static {v0}, Ljava/lang/String;->valueOf(I)Ljava/lang/String;

    move-result-object v0

    return-object v0
.end method

.method public static getAppDataPath(Ljava/lang/String;)Ljava/lang/String;
    .locals 2

    .prologue
    .line 141
    :try_start_0
    sget-object v0, Lcom/cyjh/mobileanjian/ipc/rpc/AndroidHelper;->a:Landroid/content/Context;

    invoke-virtual {v0}, Landroid/content/Context;->getPackageManager()Landroid/content/pm/PackageManager;

    move-result-object v0

    const/4 v1, 0x0

    invoke-virtual {v0, p0, v1}, Landroid/content/pm/PackageManager;->getApplicationInfo(Ljava/lang/String;I)Landroid/content/pm/ApplicationInfo;

    move-result-object v0

    .line 142
    iget-object v0, v0, Landroid/content/pm/ApplicationInfo;->dataDir:Ljava/lang/String;
    :try_end_0
    .catch Landroid/content/pm/PackageManager$NameNotFoundException; {:try_start_0 .. :try_end_0} :catch_0

    .line 147
    :goto_0
    return-object v0

    .line 143
    :catch_0
    move-exception v0

    .line 145
    invoke-virtual {v0}, Landroid/content/pm/PackageManager$NameNotFoundException;->printStackTrace()V

    .line 147
    const-string v0, ""

    goto :goto_0
.end method

.method public static getBacklightLevel()Ljava/lang/String;
    .locals 6

    .prologue
    .line 286
    const/4 v1, 0x0

    .line 289
    :try_start_0
    sget-object v0, Lcom/cyjh/mobileanjian/ipc/rpc/AndroidHelper;->a:Landroid/content/Context;

    invoke-virtual {v0}, Landroid/content/Context;->getContentResolver()Landroid/content/ContentResolver;

    move-result-object v0

    const-string v2, "screen_brightness"

    invoke-static {v0, v2}, Landroid/provider/Settings$System;->getInt(Landroid/content/ContentResolver;Ljava/lang/String;)I

    move-result v1

    .line 290
    mul-int/lit8 v0, v1, 0x64

    int-to-double v2, v0

    const-wide v4, 0x406fe00000000000L    # 255.0

    div-double/2addr v2, v4

    double-to-int v0, v2

    invoke-static {v0}, Ljava/lang/String;->valueOf(I)Ljava/lang/String;
    :try_end_0
    .catch Landroid/provider/Settings$SettingNotFoundException; {:try_start_0 .. :try_end_0} :catch_0

    move-result-object v0

    .line 296
    :goto_0
    return-object v0

    .line 291
    :catch_0
    move-exception v0

    .line 293
    invoke-virtual {v0}, Landroid/provider/Settings$SettingNotFoundException;->printStackTrace()V

    .line 296
    invoke-static {v1}, Ljava/lang/String;->valueOf(I)Ljava/lang/String;

    move-result-object v0

    goto :goto_0
.end method

.method public static getClipboardText()Ljava/lang/String;
    .locals 3

    .prologue
    .line 81
    const-string v1, ""

    .line 82
    sget-object v0, Lcom/cyjh/mobileanjian/ipc/rpc/AndroidHelper;->a:Landroid/content/Context;

    const-string v2, "clipboard"

    invoke-virtual {v0, v2}, Landroid/content/Context;->getSystemService(Ljava/lang/String;)Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Landroid/content/ClipboardManager;

    .line 83
    invoke-virtual {v0}, Landroid/content/ClipboardManager;->hasPrimaryClip()Z

    move-result v2

    if-eqz v2, :cond_0

    .line 85
    invoke-virtual {v0}, Landroid/content/ClipboardManager;->getPrimaryClip()Landroid/content/ClipData;

    move-result-object v0

    .line 86
    if-eqz v0, :cond_0

    .line 88
    const/4 v2, 0x0

    invoke-virtual {v0, v2}, Landroid/content/ClipData;->getItemAt(I)Landroid/content/ClipData$Item;

    move-result-object v0

    .line 89
    if-eqz v0, :cond_0

    .line 91
    invoke-virtual {v0}, Landroid/content/ClipData$Item;->getText()Ljava/lang/CharSequence;

    move-result-object v0

    invoke-interface {v0}, Ljava/lang/CharSequence;->toString()Ljava/lang/String;

    move-result-object v0

    .line 96
    :goto_0
    return-object v0

    :cond_0
    move-object v0, v1

    goto :goto_0
.end method

.method public static getForegroundPackage()Ljava/lang/String;
    .locals 8

    .prologue
    const/4 v6, 0x0

    .line 101
    sget v0, Landroid/os/Build$VERSION;->SDK_INT:I

    const/16 v1, 0x15

    if-ge v0, v1, :cond_0

    .line 103
    sget-object v0, Lcom/cyjh/mobileanjian/ipc/rpc/AndroidHelper;->a:Landroid/content/Context;

    const-string v1, "activity"

    invoke-virtual {v0, v1}, Landroid/content/Context;->getSystemService(Ljava/lang/String;)Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Landroid/app/ActivityManager;

    .line 104
    const/4 v1, 0x1

    invoke-virtual {v0, v1}, Landroid/app/ActivityManager;->getRunningTasks(I)Ljava/util/List;

    move-result-object v0

    const/4 v1, 0x0

    invoke-interface {v0, v1}, Ljava/util/List;->get(I)Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Landroid/app/ActivityManager$RunningTaskInfo;

    iget-object v0, v0, Landroid/app/ActivityManager$RunningTaskInfo;->topActivity:Landroid/content/ComponentName;

    .line 106
    invoke-virtual {v0}, Landroid/content/ComponentName;->getPackageName()Ljava/lang/String;

    move-result-object v6

    .line 128
    :goto_0
    return-object v6

    .line 110
    :cond_0
    invoke-static {}, Ljava/lang/System;->currentTimeMillis()J

    move-result-wide v4

    .line 111
    sget-object v0, Lcom/cyjh/mobileanjian/ipc/rpc/AndroidHelper;->a:Landroid/content/Context;

    const-string v1, "usagestats"

    invoke-virtual {v0, v1}, Landroid/content/Context;->getSystemService(Ljava/lang/String;)Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Landroid/app/usage/UsageStatsManager;

    .line 112
    const/4 v1, 0x4

    const-wide/16 v2, 0x7d0

    sub-long v2, v4, v2

    invoke-virtual/range {v0 .. v5}, Landroid/app/usage/UsageStatsManager;->queryUsageStats(IJJ)Ljava/util/List;

    move-result-object v0

    .line 113
    if-eqz v0, :cond_1

    invoke-interface {v0}, Ljava/util/List;->isEmpty()Z

    move-result v1

    if-eqz v1, :cond_2

    .line 115
    :cond_1
    const-string v0, "USATE STATS IS null."

    invoke-static {v0}, Lcom/cyjh/mobileanjian/ipc/utils/CLog;->i(Ljava/lang/String;)V

    goto :goto_0

    .line 120
    :cond_2
    invoke-interface {v0}, Ljava/util/List;->iterator()Ljava/util/Iterator;

    move-result-object v2

    move-object v1, v6

    :goto_1
    invoke-interface {v2}, Ljava/util/Iterator;->hasNext()Z

    move-result v0

    if-eqz v0, :cond_4

    invoke-interface {v2}, Ljava/util/Iterator;->next()Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Landroid/app/usage/UsageStats;

    .line 122
    if-eqz v1, :cond_3

    invoke-virtual {v1}, Landroid/app/usage/UsageStats;->getLastTimeUsed()J

    move-result-wide v4

    invoke-virtual {v0}, Landroid/app/usage/UsageStats;->getLastTimeUsed()J

    move-result-wide v6

    cmp-long v3, v4, v6

    if-gez v3, :cond_5

    :cond_3
    :goto_2
    move-object v1, v0

    .line 127
    goto :goto_1

    .line 128
    :cond_4
    invoke-virtual {v1}, Landroid/app/usage/UsageStats;->getPackageName()Ljava/lang/String;

    move-result-object v6

    goto :goto_0

    :cond_5
    move-object v0, v1

    goto :goto_2
.end method

.method public static getIccid()Ljava/lang/String;
    .locals 2

    .prologue
    .line 203
    sget-object v0, Lcom/cyjh/mobileanjian/ipc/rpc/AndroidHelper;->a:Landroid/content/Context;

    const-string v1, "phone"

    invoke-virtual {v0, v1}, Landroid/content/Context;->getSystemService(Ljava/lang/String;)Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Landroid/telephony/TelephonyManager;

    .line 204
    invoke-virtual {v0}, Landroid/telephony/TelephonyManager;->getSimSerialNumber()Ljava/lang/String;

    move-result-object v0

    return-object v0
.end method

.method public static getImsi()Ljava/lang/String;
    .locals 2

    .prologue
    .line 192
    sget-object v0, Lcom/cyjh/mobileanjian/ipc/rpc/AndroidHelper;->a:Landroid/content/Context;

    const-string v1, "phone"

    invoke-virtual {v0, v1}, Landroid/content/Context;->getSystemService(Ljava/lang/String;)Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Landroid/telephony/TelephonyManager;

    .line 193
    invoke-virtual {v0}, Landroid/telephony/TelephonyManager;->getSubscriberId()Ljava/lang/String;

    move-result-object v0

    return-object v0
.end method

.method public static getIp()Ljava/lang/String;
    .locals 4

    .prologue
    .line 157
    sget-object v0, Lcom/cyjh/mobileanjian/ipc/rpc/AndroidHelper;->a:Landroid/content/Context;

    const-string v1, "connectivity"

    invoke-virtual {v0, v1}, Landroid/content/Context;->getSystemService(Ljava/lang/String;)Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Landroid/net/ConnectivityManager;

    .line 158
    const/4 v1, 0x1

    invoke-virtual {v0, v1}, Landroid/net/ConnectivityManager;->getNetworkInfo(I)Landroid/net/NetworkInfo;

    move-result-object v0

    .line 159
    invoke-virtual {v0}, Landroid/net/NetworkInfo;->isConnected()Z

    move-result v0

    if-eqz v0, :cond_0

    .line 161
    sget-object v0, Lcom/cyjh/mobileanjian/ipc/rpc/AndroidHelper;->a:Landroid/content/Context;

    const-string v1, "wifi"

    invoke-virtual {v0, v1}, Landroid/content/Context;->getSystemService(Ljava/lang/String;)Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Landroid/net/wifi/WifiManager;

    .line 162
    invoke-virtual {v0}, Landroid/net/wifi/WifiManager;->isWifiEnabled()Z

    move-result v1

    if-eqz v1, :cond_0

    .line 164
    invoke-virtual {v0}, Landroid/net/wifi/WifiManager;->getConnectionInfo()Landroid/net/wifi/WifiInfo;

    move-result-object v0

    .line 165
    invoke-virtual {v0}, Landroid/net/wifi/WifiInfo;->getIpAddress()I

    move-result v0

    .line 166
    invoke-static {v0}, Lcom/cyjh/mobileanjian/ipc/utils/f;->a(I)Ljava/lang/String;

    move-result-object v0

    .line 187
    :goto_0
    return-object v0

    .line 171
    :cond_0
    :try_start_0
    invoke-static {}, Ljava/net/NetworkInterface;->getNetworkInterfaces()Ljava/util/Enumeration;

    move-result-object v1

    :cond_1
    invoke-interface {v1}, Ljava/util/Enumeration;->hasMoreElements()Z

    move-result v0

    if-eqz v0, :cond_3

    .line 173
    invoke-interface {v1}, Ljava/util/Enumeration;->nextElement()Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Ljava/net/NetworkInterface;

    .line 174
    invoke-virtual {v0}, Ljava/net/NetworkInterface;->getInetAddresses()Ljava/util/Enumeration;

    move-result-object v2

    :cond_2
    invoke-interface {v2}, Ljava/util/Enumeration;->hasMoreElements()Z

    move-result v0

    if-eqz v0, :cond_1

    .line 176
    invoke-interface {v2}, Ljava/util/Enumeration;->nextElement()Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Ljava/net/InetAddress;

    .line 177
    invoke-virtual {v0}, Ljava/net/InetAddress;->isLoopbackAddress()Z

    move-result v3

    if-nez v3, :cond_2

    instance-of v3, v0, Ljava/net/Inet4Address;

    if-eqz v3, :cond_2

    .line 179
    invoke-virtual {v0}, Ljava/net/InetAddress;->getHostAddress()Ljava/lang/String;

    move-result-object v0

    invoke-virtual {v0}, Ljava/lang/String;->toString()Ljava/lang/String;
    :try_end_0
    .catch Ljava/net/SocketException; {:try_start_0 .. :try_end_0} :catch_0

    move-result-object v0

    goto :goto_0

    .line 183
    :catch_0
    move-exception v0

    .line 185
    invoke-virtual {v0}, Ljava/net/SocketException;->printStackTrace()V

    .line 187
    :cond_3
    const/4 v0, 0x0

    goto :goto_0
.end method

.method public static getModel()Ljava/lang/String;
    .locals 2

    .prologue
    .line 198
    new-instance v0, Ljava/lang/StringBuilder;

    invoke-direct {v0}, Ljava/lang/StringBuilder;-><init>()V

    sget-object v1, Landroid/os/Build;->BRAND:Ljava/lang/String;

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    const-string v1, " "

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    sget-object v1, Landroid/os/Build;->MODEL:Ljava/lang/String;

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-virtual {v0}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v0

    return-object v0
.end method

.method public static getNetworkTime()Ljava/lang/String;
    .locals 7

    .prologue
    const/4 v1, 0x0

    .line 213
    :try_start_0
    new-instance v0, Ljava/net/URL;

    const-string v2, "http://api.mobileanjian.com/api/GetDateTime"

    invoke-direct {v0, v2}, Ljava/net/URL;-><init>(Ljava/lang/String;)V

    .line 214
    invoke-virtual {v0}, Ljava/net/URL;->openConnection()Ljava/net/URLConnection;

    move-result-object v0

    check-cast v0, Ljava/net/HttpURLConnection;
    :try_end_0
    .catch Ljava/net/MalformedURLException; {:try_start_0 .. :try_end_0} :catch_0
    .catch Ljava/io/IOException; {:try_start_0 .. :try_end_0} :catch_1
    .catchall {:try_start_0 .. :try_end_0} :catchall_0

    .line 215
    const/16 v2, 0x1388

    :try_start_1
    invoke-virtual {v0, v2}, Ljava/net/HttpURLConnection;->setReadTimeout(I)V

    .line 216
    const/16 v2, 0x1388

    invoke-virtual {v0, v2}, Ljava/net/HttpURLConnection;->setConnectTimeout(I)V

    .line 217
    const-string v2, "GET"

    invoke-virtual {v0, v2}, Ljava/net/HttpURLConnection;->setRequestMethod(Ljava/lang/String;)V

    .line 218
    invoke-virtual {v0}, Ljava/net/HttpURLConnection;->getResponseCode()I

    move-result v2

    const/16 v3, 0xc8

    if-ne v2, v3, :cond_2

    .line 220
    invoke-virtual {v0}, Ljava/net/HttpURLConnection;->getDate()J

    move-result-wide v2

    .line 221
    const-wide/16 v4, 0x0

    cmp-long v4, v2, v4

    if-nez v4, :cond_1

    .line 222
    const-string v1, "timeout"
    :try_end_1
    .catch Ljava/net/MalformedURLException; {:try_start_1 .. :try_end_1} :catch_3
    .catch Ljava/io/IOException; {:try_start_1 .. :try_end_1} :catch_2
    .catchall {:try_start_1 .. :try_end_1} :catchall_1

    .line 235
    if-eqz v0, :cond_0

    .line 236
    invoke-virtual {v0}, Ljava/net/HttpURLConnection;->disconnect()V

    :cond_0
    move-object v0, v1

    .line 239
    :goto_0
    return-object v0

    .line 223
    :cond_1
    :try_start_2
    new-instance v4, Ljava/util/Date;

    invoke-direct {v4, v2, v3}, Ljava/util/Date;-><init>(J)V

    .line 224
    new-instance v2, Ljava/text/SimpleDateFormat;

    const-string v3, "yyyy-MM-dd HH:mm:ss"

    invoke-direct {v2, v3}, Ljava/text/SimpleDateFormat;-><init>(Ljava/lang/String;)V

    invoke-virtual {v2, v4}, Ljava/text/SimpleDateFormat;->format(Ljava/util/Date;)Ljava/lang/String;
    :try_end_2
    .catch Ljava/net/MalformedURLException; {:try_start_2 .. :try_end_2} :catch_3
    .catch Ljava/io/IOException; {:try_start_2 .. :try_end_2} :catch_2
    .catchall {:try_start_2 .. :try_end_2} :catchall_1

    move-result-object v1

    .line 235
    :cond_2
    if-eqz v0, :cond_5

    .line 236
    invoke-virtual {v0}, Ljava/net/HttpURLConnection;->disconnect()V

    move-object v0, v1

    goto :goto_0

    .line 226
    :catch_0
    move-exception v0

    move-object v2, v1

    .line 228
    :goto_1
    :try_start_3
    invoke-virtual {v0}, Ljava/net/MalformedURLException;->printStackTrace()V
    :try_end_3
    .catchall {:try_start_3 .. :try_end_3} :catchall_2

    .line 235
    if-eqz v2, :cond_4

    .line 236
    invoke-virtual {v2}, Ljava/net/HttpURLConnection;->disconnect()V

    move-object v0, v1

    goto :goto_0

    .line 230
    :catch_1
    move-exception v0

    move-object v2, v1

    .line 232
    :goto_2
    :try_start_4
    invoke-virtual {v0}, Ljava/io/IOException;->printStackTrace()V
    :try_end_4
    .catchall {:try_start_4 .. :try_end_4} :catchall_2

    .line 235
    if-eqz v2, :cond_4

    .line 236
    invoke-virtual {v2}, Ljava/net/HttpURLConnection;->disconnect()V

    move-object v0, v1

    goto :goto_0

    .line 235
    :catchall_0
    move-exception v0

    :goto_3
    if-eqz v1, :cond_3

    .line 236
    invoke-virtual {v1}, Ljava/net/HttpURLConnection;->disconnect()V

    :cond_3
    throw v0

    .line 235
    :catchall_1
    move-exception v1

    move-object v6, v1

    move-object v1, v0

    move-object v0, v6

    goto :goto_3

    :catchall_2
    move-exception v0

    move-object v1, v2

    goto :goto_3

    .line 230
    :catch_2
    move-exception v2

    move-object v6, v2

    move-object v2, v0

    move-object v0, v6

    goto :goto_2

    .line 226
    :catch_3
    move-exception v2

    move-object v6, v2

    move-object v2, v0

    move-object v0, v6

    goto :goto_1

    :cond_4
    move-object v0, v1

    goto :goto_0

    :cond_5
    move-object v0, v1

    goto :goto_0
.end method

.method public static init(Landroid/content/Context;)V
    .locals 1

    .prologue
    .line 63
    sget-object v0, Lcom/cyjh/mobileanjian/ipc/rpc/AndroidHelper;->a:Landroid/content/Context;

    if-nez v0, :cond_0

    .line 65
    :cond_0
    sput-object p0, Lcom/cyjh/mobileanjian/ipc/rpc/AndroidHelper;->a:Landroid/content/Context;

    .line 68
    invoke-static {p0}, Lcom/cyjh/mobileanjian/ipc/rpc/Telephony;->init(Landroid/content/Context;)V

    .line 69
    return-void
.end method

.method public static isAppForeground(Ljava/lang/String;)Z
    .locals 1

    .prologue
    .line 134
    invoke-static {}, Lcom/cyjh/mobileanjian/ipc/rpc/AndroidHelper;->getForegroundPackage()Ljava/lang/String;

    move-result-object v0

    invoke-virtual {p0, v0}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v0

    return v0
.end method

.method public static isScreenOn()Ljava/lang/String;
    .locals 2

    .prologue
    .line 280
    sget-object v0, Lcom/cyjh/mobileanjian/ipc/rpc/AndroidHelper;->a:Landroid/content/Context;

    const-string v1, "power"

    invoke-virtual {v0, v1}, Landroid/content/Context;->getSystemService(Ljava/lang/String;)Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Landroid/os/PowerManager;

    .line 281
    invoke-virtual {v0}, Landroid/os/PowerManager;->isScreenOn()Z

    move-result v0

    if-eqz v0, :cond_0

    const-string v0, "true"

    :goto_0
    return-object v0

    :cond_0
    const-string v0, "false"

    goto :goto_0
.end method

.method public static setClipboardText(Ljava/lang/String;)V
    .locals 2

    .prologue
    .line 74
    sget-object v0, Lcom/cyjh/mobileanjian/ipc/rpc/AndroidHelper;->a:Landroid/content/Context;

    const-string v1, "clipboard"

    invoke-virtual {v0, v1}, Landroid/content/Context;->getSystemService(Ljava/lang/String;)Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Landroid/content/ClipboardManager;

    .line 75
    const-string v1, ""

    invoke-static {v1, p0}, Landroid/content/ClipData;->newPlainText(Ljava/lang/CharSequence;Ljava/lang/CharSequence;)Landroid/content/ClipData;

    move-result-object v1

    .line 76
    invoke-virtual {v0, v1}, Landroid/content/ClipboardManager;->setPrimaryClip(Landroid/content/ClipData;)V

    .line 77
    return-void
.end method
