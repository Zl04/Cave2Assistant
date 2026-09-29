.class public Lcom/cyjh/feedback/lib/utils/AppDevicesUtils;
.super Ljava/lang/Object;
.source "AppDevicesUtils.java"


# static fields
.field private static final KEY_MIUI_INTERNAL_STORAGE:Ljava/lang/String; = "ro.miui.internal.storage"

.field private static final KEY_MIUI_VERSION_CODE:Ljava/lang/String; = "ro.miui.ui.version.code"

.field private static final KEY_MIUI_VERSION_NAME:Ljava/lang/String; = "ro.miui.ui.version.name"


# direct methods
.method public constructor <init>()V
    .locals 0

    .prologue
    .line 31
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method

.method public static getBaseBandVer()Ljava/lang/String;
    .locals 10

    .prologue
    .line 183
    const-string v1, ""

    .line 185
    .local v1, "Version":Ljava/lang/String;
    :try_start_0
    const-string v6, "android.os.SystemProperties"

    invoke-static {v6}, Ljava/lang/Class;->forName(Ljava/lang/String;)Ljava/lang/Class;

    move-result-object v2

    .line 186
    .local v2, "cl":Ljava/lang/Class;
    invoke-virtual {v2}, Ljava/lang/Class;->newInstance()Ljava/lang/Object;

    move-result-object v3

    .line 187
    .local v3, "invoker":Ljava/lang/Object;
    const-string v6, "get"

    const/4 v7, 0x2

    new-array v7, v7, [Ljava/lang/Class;

    const/4 v8, 0x0

    const-class v9, Ljava/lang/String;

    aput-object v9, v7, v8

    const/4 v8, 0x1

    const-class v9, Ljava/lang/String;

    aput-object v9, v7, v8

    invoke-virtual {v2, v6, v7}, Ljava/lang/Class;->getMethod(Ljava/lang/String;[Ljava/lang/Class;)Ljava/lang/reflect/Method;

    move-result-object v4

    .line 188
    .local v4, "m":Ljava/lang/reflect/Method;
    const/4 v6, 0x2

    new-array v6, v6, [Ljava/lang/Object;

    const/4 v7, 0x0

    const-string v8, "gsm.version.baseband"

    aput-object v8, v6, v7

    const/4 v7, 0x1

    const-string v8, "no message"

    aput-object v8, v6, v7

    invoke-virtual {v4, v3, v6}, Ljava/lang/reflect/Method;->invoke(Ljava/lang/Object;[Ljava/lang/Object;)Ljava/lang/Object;

    move-result-object v5

    .line 189
    .local v5, "result":Ljava/lang/Object;
    move-object v0, v5

    check-cast v0, Ljava/lang/String;

    move-object v1, v0
    :try_end_0
    .catch Ljava/lang/Exception; {:try_start_0 .. :try_end_0} :catch_0

    .line 192
    .end local v2    # "cl":Ljava/lang/Class;
    .end local v3    # "invoker":Ljava/lang/Object;
    .end local v4    # "m":Ljava/lang/reflect/Method;
    .end local v5    # "result":Ljava/lang/Object;
    :goto_0
    return-object v1

    .line 190
    :catch_0
    move-exception v6

    goto :goto_0
.end method

.method public static getCpuInfo()Ljava/lang/String;
    .locals 11

    .prologue
    const/4 v10, 0x0

    .line 231
    const-string v5, "/proc/cpuinfo"

    .line 232
    .local v5, "str1":Ljava/lang/String;
    const-string v6, ""

    .line 233
    .local v6, "str2":Ljava/lang/String;
    const/4 v7, 0x2

    new-array v1, v7, [Ljava/lang/String;

    const-string v7, ""

    aput-object v7, v1, v10

    const/4 v7, 0x1

    const-string v8, ""

    aput-object v8, v1, v7

    .line 236
    .local v1, "cpuInfo":[Ljava/lang/String;
    :try_start_0
    new-instance v2, Ljava/io/FileReader;

    invoke-direct {v2, v5}, Ljava/io/FileReader;-><init>(Ljava/lang/String;)V

    .line 237
    .local v2, "fr":Ljava/io/FileReader;
    new-instance v4, Ljava/io/BufferedReader;

    const/16 v7, 0x2000

    invoke-direct {v4, v2, v7}, Ljava/io/BufferedReader;-><init>(Ljava/io/Reader;I)V

    .line 238
    .local v4, "localBufferedReader":Ljava/io/BufferedReader;
    invoke-virtual {v4}, Ljava/io/BufferedReader;->readLine()Ljava/lang/String;

    move-result-object v6

    .line 240
    const-string v7, "\\s+"

    invoke-virtual {v6, v7}, Ljava/lang/String;->split(Ljava/lang/String;)[Ljava/lang/String;

    move-result-object v0

    .line 242
    .local v0, "arrayOfString":[Ljava/lang/String;
    const/4 v3, 0x2

    .local v3, "i":I
    :goto_0
    array-length v7, v0

    if-ge v3, v7, :cond_0

    .line 243
    const/4 v7, 0x0

    new-instance v8, Ljava/lang/StringBuilder;

    invoke-direct {v8}, Ljava/lang/StringBuilder;-><init>()V

    const/4 v9, 0x0

    aget-object v9, v1, v9

    invoke-virtual {v8, v9}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v8

    aget-object v9, v0, v3

    invoke-virtual {v8, v9}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v8

    const-string v9, " "

    invoke-virtual {v8, v9}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v8

    invoke-virtual {v8}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v8

    aput-object v8, v1, v7

    .line 242
    add-int/lit8 v3, v3, 0x1

    goto :goto_0

    .line 249
    :cond_0
    invoke-virtual {v4}, Ljava/io/BufferedReader;->close()V
    :try_end_0
    .catch Ljava/io/IOException; {:try_start_0 .. :try_end_0} :catch_0

    .line 253
    .end local v0    # "arrayOfString":[Ljava/lang/String;
    .end local v2    # "fr":Ljava/io/FileReader;
    .end local v3    # "i":I
    .end local v4    # "localBufferedReader":Ljava/io/BufferedReader;
    :goto_1
    aget-object v7, v1, v10

    return-object v7

    .line 250
    :catch_0
    move-exception v7

    goto :goto_1
.end method

.method public static getKernelVersion()Ljava/lang/String;
    .locals 11

    .prologue
    .line 128
    const-string v6, ""

    .line 129
    .local v6, "kernelVersion":Ljava/lang/String;
    const/4 v4, 0x0

    .line 131
    .local v4, "inputStream":Ljava/io/InputStream;
    :try_start_0
    new-instance v5, Ljava/io/FileInputStream;

    const-string v9, "/proc/version"

    invoke-direct {v5, v9}, Ljava/io/FileInputStream;-><init>(Ljava/lang/String;)V
    :try_end_0
    .catch Ljava/io/FileNotFoundException; {:try_start_0 .. :try_end_0} :catch_0

    .line 136
    .end local v4    # "inputStream":Ljava/io/InputStream;
    .local v5, "inputStream":Ljava/io/InputStream;
    new-instance v0, Ljava/io/BufferedReader;

    new-instance v9, Ljava/io/InputStreamReader;

    invoke-direct {v9, v5}, Ljava/io/InputStreamReader;-><init>(Ljava/io/InputStream;)V

    const/16 v10, 0x2000

    invoke-direct {v0, v9, v10}, Ljava/io/BufferedReader;-><init>(Ljava/io/Reader;I)V

    .line 137
    .local v0, "bufferedReader":Ljava/io/BufferedReader;
    const-string v3, ""

    .line 138
    .local v3, "info":Ljava/lang/String;
    const-string v8, ""

    .line 140
    .local v8, "line":Ljava/lang/String;
    :goto_0
    :try_start_1
    invoke-virtual {v0}, Ljava/io/BufferedReader;->readLine()Ljava/lang/String;

    move-result-object v8

    if-eqz v8, :cond_0

    .line 141
    new-instance v9, Ljava/lang/StringBuilder;

    invoke-direct {v9}, Ljava/lang/StringBuilder;-><init>()V

    invoke-virtual {v9, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v9

    invoke-virtual {v9, v8}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v9

    invoke-virtual {v9}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;
    :try_end_1
    .catch Ljava/io/IOException; {:try_start_1 .. :try_end_1} :catch_2
    .catchall {:try_start_1 .. :try_end_1} :catchall_0

    move-result-object v3

    goto :goto_0

    .line 132
    .end local v0    # "bufferedReader":Ljava/io/BufferedReader;
    .end local v3    # "info":Ljava/lang/String;
    .end local v5    # "inputStream":Ljava/io/InputStream;
    .end local v8    # "line":Ljava/lang/String;
    .restart local v4    # "inputStream":Ljava/io/InputStream;
    :catch_0
    move-exception v1

    .line 133
    .local v1, "e":Ljava/io/FileNotFoundException;
    invoke-virtual {v1}, Ljava/io/FileNotFoundException;->printStackTrace()V

    .line 165
    .end local v1    # "e":Ljava/io/FileNotFoundException;
    :goto_1
    return-object v6

    .line 147
    .end local v4    # "inputStream":Ljava/io/InputStream;
    .restart local v0    # "bufferedReader":Ljava/io/BufferedReader;
    .restart local v3    # "info":Ljava/lang/String;
    .restart local v5    # "inputStream":Ljava/io/InputStream;
    .restart local v8    # "line":Ljava/lang/String;
    :cond_0
    :try_start_2
    invoke-virtual {v0}, Ljava/io/BufferedReader;->close()V

    .line 148
    invoke-virtual {v5}, Ljava/io/InputStream;->close()V
    :try_end_2
    .catch Ljava/io/IOException; {:try_start_2 .. :try_end_2} :catch_1

    .line 155
    :goto_2
    :try_start_3
    const-string v9, ""

    if-eq v3, v9, :cond_1

    .line 156
    const-string v7, "version "

    .line 157
    .local v7, "keyword":Ljava/lang/String;
    const-string v9, "version "

    invoke-virtual {v3, v9}, Ljava/lang/String;->indexOf(Ljava/lang/String;)I

    move-result v2

    .line 158
    .local v2, "index":I
    const-string v9, "version "

    invoke-virtual {v9}, Ljava/lang/String;->length()I

    move-result v9

    add-int/2addr v9, v2

    invoke-virtual {v3, v9}, Ljava/lang/String;->substring(I)Ljava/lang/String;

    move-result-object v8

    .line 159
    const-string v9, " "

    invoke-virtual {v8, v9}, Ljava/lang/String;->indexOf(Ljava/lang/String;)I

    move-result v2

    .line 160
    const/4 v9, 0x0

    invoke-virtual {v8, v9, v2}, Ljava/lang/String;->substring(II)Ljava/lang/String;
    :try_end_3
    .catch Ljava/lang/IndexOutOfBoundsException; {:try_start_3 .. :try_end_3} :catch_5

    move-result-object v6

    .end local v2    # "index":I
    .end local v7    # "keyword":Ljava/lang/String;
    :cond_1
    :goto_3
    move-object v4, v5

    .line 165
    .end local v5    # "inputStream":Ljava/io/InputStream;
    .restart local v4    # "inputStream":Ljava/io/InputStream;
    goto :goto_1

    .line 149
    .end local v4    # "inputStream":Ljava/io/InputStream;
    .restart local v5    # "inputStream":Ljava/io/InputStream;
    :catch_1
    move-exception v1

    .line 150
    .local v1, "e":Ljava/io/IOException;
    invoke-virtual {v1}, Ljava/io/IOException;->printStackTrace()V

    goto :goto_2

    .line 143
    .end local v1    # "e":Ljava/io/IOException;
    :catch_2
    move-exception v1

    .line 144
    .restart local v1    # "e":Ljava/io/IOException;
    :try_start_4
    invoke-virtual {v1}, Ljava/io/IOException;->printStackTrace()V
    :try_end_4
    .catchall {:try_start_4 .. :try_end_4} :catchall_0

    .line 147
    :try_start_5
    invoke-virtual {v0}, Ljava/io/BufferedReader;->close()V

    .line 148
    invoke-virtual {v5}, Ljava/io/InputStream;->close()V
    :try_end_5
    .catch Ljava/io/IOException; {:try_start_5 .. :try_end_5} :catch_3

    goto :goto_2

    .line 149
    :catch_3
    move-exception v1

    .line 150
    invoke-virtual {v1}, Ljava/io/IOException;->printStackTrace()V

    goto :goto_2

    .line 146
    .end local v1    # "e":Ljava/io/IOException;
    :catchall_0
    move-exception v9

    .line 147
    :try_start_6
    invoke-virtual {v0}, Ljava/io/BufferedReader;->close()V

    .line 148
    invoke-virtual {v5}, Ljava/io/InputStream;->close()V
    :try_end_6
    .catch Ljava/io/IOException; {:try_start_6 .. :try_end_6} :catch_4

    .line 151
    :goto_4
    throw v9

    .line 149
    :catch_4
    move-exception v1

    .line 150
    .restart local v1    # "e":Ljava/io/IOException;
    invoke-virtual {v1}, Ljava/io/IOException;->printStackTrace()V

    goto :goto_4

    .line 162
    .end local v1    # "e":Ljava/io/IOException;
    :catch_5
    move-exception v1

    .line 163
    .local v1, "e":Ljava/lang/IndexOutOfBoundsException;
    invoke-virtual {v1}, Ljava/lang/IndexOutOfBoundsException;->printStackTrace()V

    goto :goto_3
.end method

.method public static getNumCores()I
    .locals 6

    .prologue
    const/4 v5, 0x0

    .line 214
    :try_start_0
    new-instance v0, Ljava/io/File;

    const-string v3, "/sys/devices/system/cpu/"

    invoke-direct {v0, v3}, Ljava/io/File;-><init>(Ljava/lang/String;)V

    .line 216
    .local v0, "dir":Ljava/io/File;
    new-instance v3, Lcom/cyjh/feedback/lib/utils/AppDevicesUtils$1CpuFilter;

    invoke-direct {v3}, Lcom/cyjh/feedback/lib/utils/AppDevicesUtils$1CpuFilter;-><init>()V

    invoke-virtual {v0, v3}, Ljava/io/File;->listFiles(Ljava/io/FileFilter;)[Ljava/io/File;

    move-result-object v2

    .line 217
    .local v2, "files":[Ljava/io/File;
    new-instance v3, Ljava/lang/StringBuilder;

    invoke-direct {v3}, Ljava/lang/StringBuilder;-><init>()V

    const-string v4, "CPU Count="

    invoke-virtual {v3, v4}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v3

    array-length v4, v2

    invoke-virtual {v3, v4}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v3

    invoke-virtual {v3}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v3

    const/4 v4, 0x0

    new-array v4, v4, [Ljava/lang/Object;

    invoke-static {v3, v4}, Lcom/orhanobut/logger/Logger;->e(Ljava/lang/String;[Ljava/lang/Object;)V

    .line 219
    array-length v3, v2
    :try_end_0
    .catch Ljava/lang/Exception; {:try_start_0 .. :try_end_0} :catch_0

    .line 225
    .end local v2    # "files":[Ljava/io/File;
    :goto_0
    return v3

    .line 220
    :catch_0
    move-exception v1

    .line 222
    .local v1, "e":Ljava/lang/Exception;
    const-string v3, "CPU Count: Failed."

    new-array v4, v5, [Ljava/lang/Object;

    invoke-static {v3, v4}, Lcom/orhanobut/logger/Logger;->e(Ljava/lang/String;[Ljava/lang/Object;)V

    .line 223
    invoke-virtual {v1}, Ljava/lang/Exception;->printStackTrace()V

    .line 225
    const/4 v3, 0x1

    goto :goto_0
.end method

.method public static getResolution(Landroid/content/Context;)Landroid/graphics/Point;
    .locals 4
    .param p0, "context"    # Landroid/content/Context;

    .prologue
    .line 54
    const-string v3, "window"

    invoke-virtual {p0, v3}, Landroid/content/Context;->getSystemService(Ljava/lang/String;)Ljava/lang/Object;

    move-result-object v2

    check-cast v2, Landroid/view/WindowManager;

    .line 55
    .local v2, "windowManager":Landroid/view/WindowManager;
    invoke-interface {v2}, Landroid/view/WindowManager;->getDefaultDisplay()Landroid/view/Display;

    move-result-object v0

    .line 56
    .local v0, "display":Landroid/view/Display;
    new-instance v1, Landroid/graphics/Point;

    invoke-direct {v1}, Landroid/graphics/Point;-><init>()V

    .line 57
    .local v1, "point":Landroid/graphics/Point;
    invoke-virtual {v0, v1}, Landroid/view/Display;->getSize(Landroid/graphics/Point;)V

    .line 58
    return-object v1
.end method

.method public static getScreenDPI(Landroid/content/Context;)I
    .locals 3
    .param p0, "context"    # Landroid/content/Context;

    .prologue
    .line 117
    const-string v2, "window"

    invoke-virtual {p0, v2}, Landroid/content/Context;->getSystemService(Ljava/lang/String;)Ljava/lang/Object;

    move-result-object v1

    check-cast v1, Landroid/view/WindowManager;

    .line 118
    .local v1, "wm":Landroid/view/WindowManager;
    new-instance v0, Landroid/util/DisplayMetrics;

    invoke-direct {v0}, Landroid/util/DisplayMetrics;-><init>()V

    .line 119
    .local v0, "metrics":Landroid/util/DisplayMetrics;
    invoke-interface {v1}, Landroid/view/WindowManager;->getDefaultDisplay()Landroid/view/Display;

    move-result-object v2

    invoke-virtual {v2, v0}, Landroid/view/Display;->getMetrics(Landroid/util/DisplayMetrics;)V

    .line 120
    iget v2, v0, Landroid/util/DisplayMetrics;->densityDpi:I

    return v2
.end method

.method public static getSerialNumber()Ljava/lang/String;
    .locals 1

    .prologue
    .line 174
    sget-object v0, Landroid/os/Build;->SERIAL:Ljava/lang/String;

    return-object v0
.end method

.method public static getStatusBarHeight(Landroid/content/Context;)I
    .locals 6
    .param p0, "context"    # Landroid/content/Context;

    .prologue
    .line 39
    const/4 v1, 0x0

    .line 40
    .local v1, "result":I
    invoke-virtual {p0}, Landroid/content/Context;->getResources()Landroid/content/res/Resources;

    move-result-object v2

    const-string v3, "status_bar_height"

    const-string v4, "dimen"

    const-string v5, "android"

    invoke-virtual {v2, v3, v4, v5}, Landroid/content/res/Resources;->getIdentifier(Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;)I

    move-result v0

    .line 41
    .local v0, "resourceId":I
    if-lez v0, :cond_0

    .line 42
    invoke-virtual {p0}, Landroid/content/Context;->getResources()Landroid/content/res/Resources;

    move-result-object v2

    invoke-virtual {v2, v0}, Landroid/content/res/Resources;->getDimensionPixelSize(I)I

    move-result v1

    .line 44
    :cond_0
    return v1
.end method

.method public static getTotalMemorySize(Landroid/content/Context;)J
    .locals 10
    .param p0, "context"    # Landroid/content/Context;

    .prologue
    .line 97
    const-string v1, "/proc/meminfo"

    .line 99
    .local v1, "dir":Ljava/lang/String;
    :try_start_0
    new-instance v3, Ljava/io/FileReader;

    invoke-direct {v3, v1}, Ljava/io/FileReader;-><init>(Ljava/lang/String;)V

    .line 100
    .local v3, "fr":Ljava/io/FileReader;
    new-instance v0, Ljava/io/BufferedReader;

    const/16 v6, 0x800

    invoke-direct {v0, v3, v6}, Ljava/io/BufferedReader;-><init>(Ljava/io/Reader;I)V

    .line 101
    .local v0, "br":Ljava/io/BufferedReader;
    invoke-virtual {v0}, Ljava/io/BufferedReader;->readLine()Ljava/lang/String;

    move-result-object v4

    .line 102
    .local v4, "memoryLine":Ljava/lang/String;
    const/4 v6, 0x0

    new-array v6, v6, [Ljava/lang/Object;

    invoke-static {v4, v6}, Lcom/orhanobut/logger/Logger;->e(Ljava/lang/String;[Ljava/lang/Object;)V

    .line 103
    const-string v6, "MemTotal:"

    invoke-virtual {v4, v6}, Ljava/lang/String;->indexOf(Ljava/lang/String;)I

    move-result v6

    invoke-virtual {v4, v6}, Ljava/lang/String;->substring(I)Ljava/lang/String;

    move-result-object v5

    .line 104
    .local v5, "subMemoryLine":Ljava/lang/String;
    invoke-virtual {v0}, Ljava/io/BufferedReader;->close()V

    .line 106
    const-string v6, "\\D+"

    const-string v7, ""

    invoke-virtual {v5, v6, v7}, Ljava/lang/String;->replaceAll(Ljava/lang/String;Ljava/lang/String;)Ljava/lang/String;

    move-result-object v6

    invoke-static {v6}, Ljava/lang/Integer;->parseInt(Ljava/lang/String;)I
    :try_end_0
    .catch Ljava/io/IOException; {:try_start_0 .. :try_end_0} :catch_0

    move-result v6

    int-to-long v6, v6

    const-wide/16 v8, 0x400

    mul-long/2addr v6, v8

    .line 110
    .end local v0    # "br":Ljava/io/BufferedReader;
    .end local v3    # "fr":Ljava/io/FileReader;
    .end local v4    # "memoryLine":Ljava/lang/String;
    .end local v5    # "subMemoryLine":Ljava/lang/String;
    :goto_0
    return-wide v6

    .line 107
    :catch_0
    move-exception v2

    .line 108
    .local v2, "e":Ljava/io/IOException;
    invoke-virtual {v2}, Ljava/io/IOException;->printStackTrace()V

    .line 110
    const-wide/16 v6, 0x0

    goto :goto_0
.end method

.method public static installAPK(Landroid/content/Context;Ljava/io/File;)V
    .locals 3
    .param p0, "context"    # Landroid/content/Context;
    .param p1, "appFile"    # Ljava/io/File;

    .prologue
    .line 68
    new-instance v0, Landroid/content/Intent;

    const-string v1, "android.intent.action.VIEW"

    invoke-direct {v0, v1}, Landroid/content/Intent;-><init>(Ljava/lang/String;)V

    .line 69
    .local v0, "intent":Landroid/content/Intent;
    invoke-static {p1}, Landroid/net/Uri;->fromFile(Ljava/io/File;)Landroid/net/Uri;

    move-result-object v1

    const-string v2, "application/vnd.android.package-archive"

    invoke-virtual {v0, v1, v2}, Landroid/content/Intent;->setDataAndType(Landroid/net/Uri;Ljava/lang/String;)Landroid/content/Intent;

    .line 70
    const/high16 v1, 0x10000000

    invoke-virtual {v0, v1}, Landroid/content/Intent;->setFlags(I)Landroid/content/Intent;

    .line 71
    invoke-virtual {p0, v0}, Landroid/content/Context;->startActivity(Landroid/content/Intent;)V

    .line 72
    return-void
.end method

.method public static isEmpty(Ljava/lang/String;)Z
    .locals 2
    .param p0, "value"    # Ljava/lang/String;

    .prologue
    .line 292
    if-eqz p0, :cond_0

    const-string v0, ""

    invoke-virtual {p0}, Ljava/lang/String;->trim()Ljava/lang/String;

    move-result-object v1

    invoke-virtual {v0, v1}, Ljava/lang/String;->equalsIgnoreCase(Ljava/lang/String;)Z

    move-result v0

    if-nez v0, :cond_0

    const-string v0, "null"

    invoke-virtual {p0}, Ljava/lang/String;->trim()Ljava/lang/String;

    move-result-object v1

    invoke-virtual {v0, v1}, Ljava/lang/String;->equalsIgnoreCase(Ljava/lang/String;)Z

    move-result v0

    if-nez v0, :cond_0

    .line 293
    const/4 v0, 0x0

    .line 295
    :goto_0
    return v0

    :cond_0
    const/4 v0, 0x1

    goto :goto_0
.end method

.method public static isFlyme()Z
    .locals 6

    .prologue
    const/4 v2, 0x0

    .line 264
    :try_start_0
    const-class v3, Landroid/os/Build;

    const-string v4, "hasSmartBar"

    const/4 v5, 0x0

    new-array v5, v5, [Ljava/lang/Class;

    invoke-virtual {v3, v4, v5}, Ljava/lang/Class;->getMethod(Ljava/lang/String;[Ljava/lang/Class;)Ljava/lang/reflect/Method;
    :try_end_0
    .catch Ljava/lang/Exception; {:try_start_0 .. :try_end_0} :catch_0

    move-result-object v1

    .line 265
    .local v1, "method":Ljava/lang/reflect/Method;
    if-eqz v1, :cond_0

    const/4 v2, 0x1

    .line 267
    .end local v1    # "method":Ljava/lang/reflect/Method;
    :cond_0
    :goto_0
    return v2

    .line 266
    :catch_0
    move-exception v0

    .line 267
    .local v0, "e":Ljava/lang/Exception;
    goto :goto_0
.end method

.method public static isMIUI()Z
    .locals 5

    .prologue
    const/4 v2, 0x0

    .line 281
    :try_start_0
    invoke-static {}, Lcom/cyjh/feedback/lib/utils/BuildProperties;->newInstance()Lcom/cyjh/feedback/lib/utils/BuildProperties;

    move-result-object v1

    .line 282
    .local v1, "prop":Lcom/cyjh/feedback/lib/utils/BuildProperties;
    const-string v3, "ro.miui.ui.version.code"

    const/4 v4, 0x0

    invoke-virtual {v1, v3, v4}, Lcom/cyjh/feedback/lib/utils/BuildProperties;->getProperty(Ljava/lang/String;Ljava/lang/String;)Ljava/lang/String;

    move-result-object v3

    if-nez v3, :cond_0

    const-string v3, "ro.miui.ui.version.name"

    const/4 v4, 0x0

    .line 283
    invoke-virtual {v1, v3, v4}, Lcom/cyjh/feedback/lib/utils/BuildProperties;->getProperty(Ljava/lang/String;Ljava/lang/String;)Ljava/lang/String;

    move-result-object v3

    if-nez v3, :cond_0

    const-string v3, "ro.miui.internal.storage"

    const/4 v4, 0x0

    .line 284
    invoke-virtual {v1, v3, v4}, Lcom/cyjh/feedback/lib/utils/BuildProperties;->getProperty(Ljava/lang/String;Ljava/lang/String;)Ljava/lang/String;
    :try_end_0
    .catch Ljava/io/IOException; {:try_start_0 .. :try_end_0} :catch_0

    move-result-object v3

    if-eqz v3, :cond_1

    :cond_0
    const/4 v2, 0x1

    .line 286
    :cond_1
    :goto_0
    return v2

    .line 285
    :catch_0
    move-exception v0

    .line 286
    .local v0, "e":Ljava/io/IOException;
    goto :goto_0
.end method

.method public static isMetCondition(Ljava/lang/String;)Z
    .locals 2
    .param p0, "filename"    # Ljava/lang/String;

    .prologue
    .line 305
    invoke-virtual {p0}, Ljava/lang/String;->toLowerCase()Ljava/lang/String;

    move-result-object v0

    const-string v1, ".jpg"

    invoke-virtual {v0, v1}, Ljava/lang/String;->endsWith(Ljava/lang/String;)Z

    move-result v0

    if-nez v0, :cond_0

    invoke-virtual {p0}, Ljava/lang/String;->toLowerCase()Ljava/lang/String;

    move-result-object v0

    const-string v1, ".jpeg"

    invoke-virtual {v0, v1}, Ljava/lang/String;->endsWith(Ljava/lang/String;)Z

    move-result v0

    if-nez v0, :cond_0

    .line 306
    invoke-virtual {p0}, Ljava/lang/String;->toLowerCase()Ljava/lang/String;

    move-result-object v0

    const-string v1, ".png"

    invoke-virtual {v0, v1}, Ljava/lang/String;->endsWith(Ljava/lang/String;)Z

    move-result v0

    if-eqz v0, :cond_1

    :cond_0
    const/4 v0, 0x1

    .line 305
    :goto_0
    return v0

    .line 306
    :cond_1
    const/4 v0, 0x0

    goto :goto_0
.end method

.method public static isMobileNO(Ljava/lang/String;)Z
    .locals 2
    .param p0, "mobiles"    # Ljava/lang/String;

    .prologue
    .line 86
    const-string v0, "[1][34587]\\d{9}"

    .line 87
    .local v0, "telRegex":Ljava/lang/String;
    invoke-static {p0}, Landroid/text/TextUtils;->isEmpty(Ljava/lang/CharSequence;)Z

    move-result v1

    if-eqz v1, :cond_0

    .line 88
    const/4 v1, 0x0

    .line 90
    :goto_0
    return v1

    :cond_0
    invoke-virtual {p0, v0}, Ljava/lang/String;->matches(Ljava/lang/String;)Z

    move-result v1

    goto :goto_0
.end method

.method public static scriptVibration(Landroid/content/Context;J)V
    .locals 3
    .param p0, "context"    # Landroid/content/Context;
    .param p1, "milliseconds"    # J

    .prologue
    .line 78
    const-string v1, "vibrator"

    invoke-virtual {p0, v1}, Landroid/content/Context;->getSystemService(Ljava/lang/String;)Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Landroid/os/Vibrator;

    .line 79
    .local v0, "mVibrator":Landroid/os/Vibrator;
    invoke-virtual {v0, p1, p2}, Landroid/os/Vibrator;->vibrate(J)V

    .line 80
    return-void
.end method
