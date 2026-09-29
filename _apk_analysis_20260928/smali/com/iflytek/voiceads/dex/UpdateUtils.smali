.class public Lcom/iflytek/voiceads/dex/UpdateUtils;
.super Ljava/lang/Object;
.source "UpdateUtils.java"


# direct methods
.method public constructor <init>()V
    .locals 0

    .prologue
    .line 26
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method

.method static synthetic access$000(Ljava/lang/String;Ljava/lang/String;)I
    .locals 1
    .param p0, "x0"    # Ljava/lang/String;
    .param p1, "x1"    # Ljava/lang/String;

    .prologue
    .line 26
    invoke-static {p0, p1}, Lcom/iflytek/voiceads/dex/UpdateUtils;->getDexVersion(Ljava/lang/String;Ljava/lang/String;)I

    move-result v0

    return v0
.end method

.method public static checkDexUpdate(Landroid/content/Context;Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;)V
    .locals 10
    .param p0, "context"    # Landroid/content/Context;
    .param p1, "cacheFileDir"    # Ljava/lang/String;
    .param p2, "sdkVersion"    # Ljava/lang/String;
    .param p3, "localVersion"    # Ljava/lang/String;

    .prologue
    .line 138
    invoke-static {}, Ljava/lang/System;->currentTimeMillis()J

    move-result-wide v2

    .line 139
    .local v2, "now":J
    const-string v6, "adsp"

    const/4 v7, 0x0

    invoke-virtual {p0, v6, v7}, Landroid/content/Context;->getSharedPreferences(Ljava/lang/String;I)Landroid/content/SharedPreferences;

    move-result-object v4

    .line 140
    .local v4, "sp":Landroid/content/SharedPreferences;
    const-string v6, "checkUpdateTime"

    const-wide/16 v8, 0x0

    invoke-interface {v4, v6, v8, v9}, Landroid/content/SharedPreferences;->getLong(Ljava/lang/String;J)J

    move-result-wide v0

    .line 141
    .local v0, "last":J
    sub-long v6, v2, v0

    const-wide/32 v8, 0x5265c00

    cmp-long v6, v6, v8

    if-gez v6, :cond_0

    .line 142
    const-string v6, "less than 24h"

    invoke-static {v6}, Lcom/iflytek/voiceads/dex/SDKLogger;->d(Ljava/lang/String;)V

    .line 204
    :goto_0
    return-void

    .line 145
    :cond_0
    invoke-interface {v4}, Landroid/content/SharedPreferences;->edit()Landroid/content/SharedPreferences$Editor;

    move-result-object v6

    const-string v7, "checkUpdateTime"

    invoke-interface {v6, v7, v2, v3}, Landroid/content/SharedPreferences$Editor;->putLong(Ljava/lang/String;J)Landroid/content/SharedPreferences$Editor;

    move-result-object v6

    invoke-interface {v6}, Landroid/content/SharedPreferences$Editor;->apply()V

    .line 147
    new-instance v6, Ljava/lang/StringBuilder;

    invoke-direct {v6}, Ljava/lang/StringBuilder;-><init>()V

    const-string v7, "http://api.voiceads.cn/hotUpdate/?ver="

    invoke-virtual {v6, v7}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v6

    invoke-virtual {v6, p2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v6

    invoke-virtual {v6}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v5

    .line 149
    .local v5, "updateServer":Ljava/lang/String;
    new-instance v6, Ljava/lang/Thread;

    new-instance v7, Lcom/iflytek/voiceads/dex/UpdateUtils$1;

    invoke-direct {v7, v5, p2, p3, p1}, Lcom/iflytek/voiceads/dex/UpdateUtils$1;-><init>(Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;)V

    invoke-direct {v6, v7}, Ljava/lang/Thread;-><init>(Ljava/lang/Runnable;)V

    invoke-virtual {v6}, Ljava/lang/Thread;->start()V

    goto :goto_0
.end method

.method private static copyDexFile(Landroid/content/Context;Ljava/lang/String;Ljava/lang/String;)V
    .locals 8
    .param p0, "context"    # Landroid/content/Context;
    .param p1, "toPath"    # Ljava/lang/String;
    .param p2, "fromName"    # Ljava/lang/String;

    .prologue
    .line 260
    const-string v7, "copyDexFile"

    invoke-static {v7}, Lcom/iflytek/voiceads/dex/SDKLogger;->d(Ljava/lang/String;)V

    .line 261
    const/4 v4, 0x0

    .line 262
    .local v4, "in":Ljava/io/InputStream;
    const/4 v2, 0x0

    .line 263
    .local v2, "fos":Ljava/io/FileOutputStream;
    invoke-virtual {p0}, Landroid/content/Context;->getAssets()Landroid/content/res/AssetManager;

    move-result-object v0

    .line 265
    .local v0, "assets":Landroid/content/res/AssetManager;
    :try_start_0
    invoke-virtual {v0, p2}, Landroid/content/res/AssetManager;->open(Ljava/lang/String;)Ljava/io/InputStream;

    move-result-object v4

    .line 266
    new-instance v3, Ljava/io/FileOutputStream;

    new-instance v7, Ljava/io/File;

    invoke-direct {v7, p1}, Ljava/io/File;-><init>(Ljava/lang/String;)V

    invoke-direct {v3, v7}, Ljava/io/FileOutputStream;-><init>(Ljava/io/File;)V
    :try_end_0
    .catch Ljava/io/IOException; {:try_start_0 .. :try_end_0} :catch_4
    .catchall {:try_start_0 .. :try_end_0} :catchall_0

    .line 267
    .end local v2    # "fos":Ljava/io/FileOutputStream;
    .local v3, "fos":Ljava/io/FileOutputStream;
    const/16 v7, 0x400

    :try_start_1
    new-array v6, v7, [B

    .line 268
    .local v6, "temp":[B
    const/4 v5, 0x0

    .line 269
    .local v5, "len":I
    :goto_0
    invoke-virtual {v4, v6}, Ljava/io/InputStream;->read([B)I

    move-result v5

    if-lez v5, :cond_1

    .line 270
    const/4 v7, 0x0

    invoke-virtual {v3, v6, v7, v5}, Ljava/io/FileOutputStream;->write([BII)V
    :try_end_1
    .catch Ljava/io/IOException; {:try_start_1 .. :try_end_1} :catch_0
    .catchall {:try_start_1 .. :try_end_1} :catchall_1

    goto :goto_0

    .line 274
    .end local v5    # "len":I
    .end local v6    # "temp":[B
    :catch_0
    move-exception v1

    move-object v2, v3

    .line 275
    .end local v3    # "fos":Ljava/io/FileOutputStream;
    .local v1, "e":Ljava/io/IOException;
    .restart local v2    # "fos":Ljava/io/FileOutputStream;
    :goto_1
    :try_start_2
    invoke-virtual {v1}, Ljava/io/IOException;->printStackTrace()V
    :try_end_2
    .catchall {:try_start_2 .. :try_end_2} :catchall_0

    .line 278
    if-eqz v2, :cond_0

    .line 279
    :try_start_3
    invoke-virtual {v2}, Ljava/io/FileOutputStream;->close()V

    .line 280
    const/4 v2, 0x0

    .line 281
    if-eqz v4, :cond_0

    .line 282
    invoke-virtual {v4}, Ljava/io/InputStream;->close()V
    :try_end_3
    .catch Ljava/io/IOException; {:try_start_3 .. :try_end_3} :catch_2

    .line 283
    const/4 v4, 0x0

    .line 290
    .end local v1    # "e":Ljava/io/IOException;
    :cond_0
    :goto_2
    return-void

    .line 272
    .end local v2    # "fos":Ljava/io/FileOutputStream;
    .restart local v3    # "fos":Ljava/io/FileOutputStream;
    .restart local v5    # "len":I
    .restart local v6    # "temp":[B
    :cond_1
    :try_start_4
    invoke-virtual {v3}, Ljava/io/FileOutputStream;->flush()V
    :try_end_4
    .catch Ljava/io/IOException; {:try_start_4 .. :try_end_4} :catch_0
    .catchall {:try_start_4 .. :try_end_4} :catchall_1

    .line 278
    if-eqz v3, :cond_3

    .line 279
    :try_start_5
    invoke-virtual {v3}, Ljava/io/FileOutputStream;->close()V
    :try_end_5
    .catch Ljava/io/IOException; {:try_start_5 .. :try_end_5} :catch_1

    .line 280
    const/4 v2, 0x0

    .line 281
    .end local v3    # "fos":Ljava/io/FileOutputStream;
    .restart local v2    # "fos":Ljava/io/FileOutputStream;
    if-eqz v4, :cond_0

    .line 282
    :try_start_6
    invoke-virtual {v4}, Ljava/io/InputStream;->close()V
    :try_end_6
    .catch Ljava/io/IOException; {:try_start_6 .. :try_end_6} :catch_5

    .line 283
    const/4 v4, 0x0

    goto :goto_2

    .line 286
    .end local v2    # "fos":Ljava/io/FileOutputStream;
    .restart local v3    # "fos":Ljava/io/FileOutputStream;
    :catch_1
    move-exception v1

    move-object v2, v3

    .line 287
    .end local v3    # "fos":Ljava/io/FileOutputStream;
    .restart local v1    # "e":Ljava/io/IOException;
    .restart local v2    # "fos":Ljava/io/FileOutputStream;
    :goto_3
    invoke-virtual {v1}, Ljava/io/IOException;->printStackTrace()V

    goto :goto_2

    .line 286
    .end local v5    # "len":I
    .end local v6    # "temp":[B
    :catch_2
    move-exception v1

    .line 287
    invoke-virtual {v1}, Ljava/io/IOException;->printStackTrace()V

    goto :goto_2

    .line 277
    .end local v1    # "e":Ljava/io/IOException;
    :catchall_0
    move-exception v7

    .line 278
    :goto_4
    if-eqz v2, :cond_2

    .line 279
    :try_start_7
    invoke-virtual {v2}, Ljava/io/FileOutputStream;->close()V

    .line 280
    const/4 v2, 0x0

    .line 281
    if-eqz v4, :cond_2

    .line 282
    invoke-virtual {v4}, Ljava/io/InputStream;->close()V
    :try_end_7
    .catch Ljava/io/IOException; {:try_start_7 .. :try_end_7} :catch_3

    .line 283
    const/4 v4, 0x0

    .line 288
    :cond_2
    :goto_5
    throw v7

    .line 286
    :catch_3
    move-exception v1

    .line 287
    .restart local v1    # "e":Ljava/io/IOException;
    invoke-virtual {v1}, Ljava/io/IOException;->printStackTrace()V

    goto :goto_5

    .line 277
    .end local v1    # "e":Ljava/io/IOException;
    .end local v2    # "fos":Ljava/io/FileOutputStream;
    .restart local v3    # "fos":Ljava/io/FileOutputStream;
    :catchall_1
    move-exception v7

    move-object v2, v3

    .end local v3    # "fos":Ljava/io/FileOutputStream;
    .restart local v2    # "fos":Ljava/io/FileOutputStream;
    goto :goto_4

    .line 274
    :catch_4
    move-exception v1

    goto :goto_1

    .line 286
    .restart local v5    # "len":I
    .restart local v6    # "temp":[B
    :catch_5
    move-exception v1

    goto :goto_3

    .end local v2    # "fos":Ljava/io/FileOutputStream;
    .restart local v3    # "fos":Ljava/io/FileOutputStream;
    :cond_3
    move-object v2, v3

    .end local v3    # "fos":Ljava/io/FileOutputStream;
    .restart local v2    # "fos":Ljava/io/FileOutputStream;
    goto :goto_2
.end method

.method protected static downloadRemoteDex(Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;)V
    .locals 3
    .param p0, "cacheFileDir"    # Ljava/lang/String;
    .param p1, "sdkVersion"    # Ljava/lang/String;
    .param p2, "remoteVersion"    # Ljava/lang/String;
    .param p3, "downloadUrl"    # Ljava/lang/String;

    .prologue
    .line 210
    move-object v0, p3

    .line 211
    .local v0, "downloadServer":Ljava/lang/String;
    new-instance v1, Ljava/lang/Thread;

    new-instance v2, Lcom/iflytek/voiceads/dex/UpdateUtils$2;

    invoke-direct {v2, p2, v0, p0}, Lcom/iflytek/voiceads/dex/UpdateUtils$2;-><init>(Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;)V

    invoke-direct {v1, v2}, Ljava/lang/Thread;-><init>(Ljava/lang/Runnable;)V

    invoke-virtual {v1}, Ljava/lang/Thread;->start()V

    .line 256
    return-void
.end method

.method public static getAssetDex(Landroid/content/Context;Ljava/lang/String;)Ljava/lang/String;
    .locals 4
    .param p0, "context"    # Landroid/content/Context;
    .param p1, "sdkVersion"    # Ljava/lang/String;

    .prologue
    .line 77
    const/4 v0, 0x0

    .line 79
    .local v0, "assetList":[Ljava/lang/String;
    :try_start_0
    invoke-virtual {p0}, Landroid/content/Context;->getAssets()Landroid/content/res/AssetManager;

    move-result-object v2

    const-string v3, ""

    invoke-virtual {v2, v3}, Landroid/content/res/AssetManager;->list(Ljava/lang/String;)[Ljava/lang/String;
    :try_end_0
    .catch Ljava/io/IOException; {:try_start_0 .. :try_end_0} :catch_0

    move-result-object v0

    .line 83
    :goto_0
    invoke-static {v0, p1}, Lcom/iflytek/voiceads/dex/UpdateUtils;->getStringArrayDex([Ljava/lang/String;Ljava/lang/String;)Ljava/lang/String;

    move-result-object v2

    return-object v2

    .line 80
    :catch_0
    move-exception v1

    .line 81
    .local v1, "e":Ljava/io/IOException;
    invoke-virtual {v1}, Ljava/io/IOException;->printStackTrace()V

    goto :goto_0
.end method

.method public static getCacheDex(Landroid/content/Context;Ljava/lang/String;)Ljava/lang/String;
    .locals 4
    .param p0, "context"    # Landroid/content/Context;
    .param p1, "sdkVersion"    # Ljava/lang/String;

    .prologue
    .line 92
    new-instance v2, Ljava/lang/StringBuilder;

    invoke-direct {v2}, Ljava/lang/StringBuilder;-><init>()V

    invoke-virtual {p0}, Landroid/content/Context;->getFilesDir()Ljava/io/File;

    move-result-object v3

    invoke-virtual {v3}, Ljava/io/File;->getAbsolutePath()Ljava/lang/String;

    move-result-object v3

    invoke-virtual {v2, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    sget-object v3, Ljava/io/File;->separator:Ljava/lang/String;

    invoke-virtual {v2, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    invoke-virtual {v2}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v1

    .line 93
    .local v1, "tempPath":Ljava/lang/String;
    new-instance v2, Ljava/io/File;

    invoke-direct {v2, v1}, Ljava/io/File;-><init>(Ljava/lang/String;)V

    invoke-virtual {v2}, Ljava/io/File;->list()[Ljava/lang/String;

    move-result-object v0

    .line 94
    .local v0, "fileList":[Ljava/lang/String;
    invoke-static {v0, p1}, Lcom/iflytek/voiceads/dex/UpdateUtils;->getStringArrayDex([Ljava/lang/String;Ljava/lang/String;)Ljava/lang/String;

    move-result-object v2

    return-object v2
.end method

.method private static getDexVersion(Ljava/lang/String;Ljava/lang/String;)I
    .locals 4
    .param p0, "versionName"    # Ljava/lang/String;
    .param p1, "sdkVersion"    # Ljava/lang/String;

    .prologue
    .line 127
    const/4 v0, -0x1

    .line 128
    .local v0, "result":I
    new-instance v2, Ljava/lang/StringBuilder;

    invoke-direct {v2}, Ljava/lang/StringBuilder;-><init>()V

    const-string v3, "^AdDex."

    invoke-virtual {v2, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    invoke-virtual {v2, p1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    const-string v3, "(\\.[0-9]{1,})\\.dex$"

    invoke-virtual {v2, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    invoke-virtual {v2}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v2

    invoke-static {v2, p0}, Ljava/util/regex/Pattern;->matches(Ljava/lang/String;Ljava/lang/CharSequence;)Z

    move-result v2

    if-nez v2, :cond_0

    move v1, v0

    .line 132
    .end local v0    # "result":I
    .local v1, "result":I
    :goto_0
    return v1

    .line 131
    .end local v1    # "result":I
    .restart local v0    # "result":I
    :cond_0
    const-string v2, "\\."

    invoke-virtual {p0, v2}, Ljava/lang/String;->split(Ljava/lang/String;)[Ljava/lang/String;

    move-result-object v2

    const/4 v3, 0x3

    aget-object v2, v2, v3

    invoke-static {v2}, Ljava/lang/Integer;->valueOf(Ljava/lang/String;)Ljava/lang/Integer;

    move-result-object v2

    invoke-virtual {v2}, Ljava/lang/Integer;->intValue()I

    move-result v0

    move v1, v0

    .line 132
    .end local v0    # "result":I
    .restart local v1    # "result":I
    goto :goto_0
.end method

.method public static getLocalDex(Landroid/content/Context;Ljava/lang/String;)Ljava/lang/String;
    .locals 6
    .param p0, "context"    # Landroid/content/Context;
    .param p1, "sdkVersion"    # Ljava/lang/String;

    .prologue
    .line 35
    const-string v3, "AdDex.0.0.0.dex"

    .line 36
    .local v3, "localVersion":Ljava/lang/String;
    invoke-static {p0, p1}, Lcom/iflytek/voiceads/dex/UpdateUtils;->getAssetDex(Landroid/content/Context;Ljava/lang/String;)Ljava/lang/String;

    move-result-object v0

    .line 37
    .local v0, "assetVersion":Ljava/lang/String;
    invoke-static {p0, p1}, Lcom/iflytek/voiceads/dex/UpdateUtils;->getCacheDex(Landroid/content/Context;Ljava/lang/String;)Ljava/lang/String;

    move-result-object v2

    .line 38
    .local v2, "cacheVersion":Ljava/lang/String;
    new-instance v4, Ljava/lang/StringBuilder;

    invoke-direct {v4}, Ljava/lang/StringBuilder;-><init>()V

    invoke-virtual {p0}, Landroid/content/Context;->getFilesDir()Ljava/io/File;

    move-result-object v5

    invoke-virtual {v5}, Ljava/io/File;->getAbsolutePath()Ljava/lang/String;

    move-result-object v5

    invoke-virtual {v4, v5}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v4

    sget-object v5, Ljava/io/File;->separator:Ljava/lang/String;

    invoke-virtual {v4, v5}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v4

    invoke-virtual {v4}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v1

    .line 39
    .local v1, "cacheFileDir":Ljava/lang/String;
    invoke-static {v0, p1}, Lcom/iflytek/voiceads/dex/UpdateUtils;->getDexVersion(Ljava/lang/String;Ljava/lang/String;)I

    move-result v4

    invoke-static {v2, p1}, Lcom/iflytek/voiceads/dex/UpdateUtils;->getDexVersion(Ljava/lang/String;Ljava/lang/String;)I

    move-result v5

    if-le v4, v5, :cond_0

    .line 40
    new-instance v4, Ljava/lang/StringBuilder;

    invoke-direct {v4}, Ljava/lang/StringBuilder;-><init>()V

    invoke-virtual {v4, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v4

    invoke-virtual {v4, v0}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v4

    invoke-virtual {v4}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v4

    invoke-static {p0, v4, v0}, Lcom/iflytek/voiceads/dex/UpdateUtils;->copyDexFile(Landroid/content/Context;Ljava/lang/String;Ljava/lang/String;)V

    .line 41
    move-object v2, v0

    .line 43
    :cond_0
    move-object v3, v2

    .line 44
    invoke-static {p0, v1, p1, v3}, Lcom/iflytek/voiceads/dex/UpdateUtils;->checkDexUpdate(Landroid/content/Context;Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;)V

    .line 45
    return-object v3
.end method

.method public static getRawDex(Landroid/content/Context;Ljava/lang/String;)Ljava/lang/String;
    .locals 8
    .param p0, "context"    # Landroid/content/Context;
    .param p1, "sdkVersion"    # Ljava/lang/String;

    .prologue
    .line 58
    invoke-virtual {p0}, Landroid/content/Context;->getFilesDir()Ljava/io/File;

    move-result-object v6

    invoke-virtual {v6}, Ljava/io/File;->listFiles()[Ljava/io/File;

    move-result-object v0

    .local v0, "arr$":[Ljava/io/File;
    array-length v5, v0

    .local v5, "len$":I
    const/4 v4, 0x0

    .local v4, "i$":I
    :goto_0
    if-ge v4, v5, :cond_1

    aget-object v3, v0, v4

    .line 59
    .local v3, "file":Ljava/io/File;
    invoke-virtual {v3}, Ljava/io/File;->getName()Ljava/lang/String;

    move-result-object v6

    invoke-static {v6, p1}, Lcom/iflytek/voiceads/dex/UpdateUtils;->getDexVersion(Ljava/lang/String;Ljava/lang/String;)I

    move-result v6

    const/4 v7, -0x1

    if-eq v6, v7, :cond_0

    .line 60
    new-instance v6, Ljava/lang/StringBuilder;

    invoke-direct {v6}, Ljava/lang/StringBuilder;-><init>()V

    const-string v7, "delete "

    invoke-virtual {v6, v7}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v6

    invoke-virtual {v3}, Ljava/io/File;->getName()Ljava/lang/String;

    move-result-object v7

    invoke-virtual {v6, v7}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v6

    invoke-virtual {v6}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v6

    invoke-static {v6}, Lcom/iflytek/voiceads/dex/SDKLogger;->d(Ljava/lang/String;)V

    .line 61
    invoke-virtual {v3}, Ljava/io/File;->delete()Z

    .line 58
    :cond_0
    add-int/lit8 v4, v4, 0x1

    goto :goto_0

    .line 64
    .end local v3    # "file":Ljava/io/File;
    :cond_1
    invoke-static {p0, p1}, Lcom/iflytek/voiceads/dex/UpdateUtils;->getAssetDex(Landroid/content/Context;Ljava/lang/String;)Ljava/lang/String;

    move-result-object v1

    .line 65
    .local v1, "assetVersion":Ljava/lang/String;
    new-instance v6, Ljava/lang/StringBuilder;

    invoke-direct {v6}, Ljava/lang/StringBuilder;-><init>()V

    invoke-virtual {p0}, Landroid/content/Context;->getFilesDir()Ljava/io/File;

    move-result-object v7

    invoke-virtual {v7}, Ljava/io/File;->getAbsolutePath()Ljava/lang/String;

    move-result-object v7

    invoke-virtual {v6, v7}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v6

    sget-object v7, Ljava/io/File;->separator:Ljava/lang/String;

    invoke-virtual {v6, v7}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v6

    invoke-virtual {v6}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v2

    .line 66
    .local v2, "cacheFileDir":Ljava/lang/String;
    new-instance v6, Ljava/lang/StringBuilder;

    invoke-direct {v6}, Ljava/lang/StringBuilder;-><init>()V

    invoke-virtual {v6, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v6

    invoke-virtual {v6, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v6

    invoke-virtual {v6}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v6

    invoke-static {p0, v6, v1}, Lcom/iflytek/voiceads/dex/UpdateUtils;->copyDexFile(Landroid/content/Context;Ljava/lang/String;Ljava/lang/String;)V

    .line 67
    invoke-static {p0, v2, p1, v1}, Lcom/iflytek/voiceads/dex/UpdateUtils;->checkDexUpdate(Landroid/content/Context;Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;)V

    .line 68
    return-object v1
.end method

.method public static getStringArrayDex([Ljava/lang/String;Ljava/lang/String;)Ljava/lang/String;
    .locals 8
    .param p0, "list"    # [Ljava/lang/String;
    .param p1, "sdkVersion"    # Ljava/lang/String;

    .prologue
    .line 104
    const/4 v1, 0x0

    .line 105
    .local v1, "dexVersion":I
    if-eqz p0, :cond_2

    .line 106
    new-instance v2, Ljava/util/ArrayList;

    invoke-direct {v2}, Ljava/util/ArrayList;-><init>()V

    .line 107
    .local v2, "dexVersionList":Ljava/util/ArrayList;, "Ljava/util/ArrayList<Ljava/lang/Integer;>;"
    move-object v0, p0

    .local v0, "arr$":[Ljava/lang/String;
    array-length v4, v0

    .local v4, "len$":I
    const/4 v3, 0x0

    .local v3, "i$":I
    :goto_0
    if-ge v3, v4, :cond_1

    aget-object v5, v0, v3

    .line 108
    .local v5, "temp":Ljava/lang/String;
    invoke-static {v5, p1}, Lcom/iflytek/voiceads/dex/UpdateUtils;->getDexVersion(Ljava/lang/String;Ljava/lang/String;)I

    move-result v6

    if-lez v6, :cond_0

    .line 109
    invoke-static {v5, p1}, Lcom/iflytek/voiceads/dex/UpdateUtils;->getDexVersion(Ljava/lang/String;Ljava/lang/String;)I

    move-result v6

    invoke-static {v6}, Ljava/lang/Integer;->valueOf(I)Ljava/lang/Integer;

    move-result-object v6

    invoke-virtual {v2, v6}, Ljava/util/ArrayList;->add(Ljava/lang/Object;)Z

    .line 107
    :cond_0
    add-int/lit8 v3, v3, 0x1

    goto :goto_0

    .line 112
    .end local v5    # "temp":Ljava/lang/String;
    :cond_1
    invoke-virtual {v2}, Ljava/util/ArrayList;->size()I

    move-result v6

    if-lez v6, :cond_2

    .line 113
    invoke-static {v2}, Ljava/util/Collections;->sort(Ljava/util/List;)V

    .line 114
    invoke-virtual {v2}, Ljava/util/ArrayList;->size()I

    move-result v6

    add-int/lit8 v6, v6, -0x1

    invoke-virtual {v2, v6}, Ljava/util/ArrayList;->get(I)Ljava/lang/Object;

    move-result-object v6

    check-cast v6, Ljava/lang/Integer;

    invoke-virtual {v6}, Ljava/lang/Integer;->intValue()I

    move-result v1

    .line 117
    .end local v0    # "arr$":[Ljava/lang/String;
    .end local v2    # "dexVersionList":Ljava/util/ArrayList;, "Ljava/util/ArrayList<Ljava/lang/Integer;>;"
    .end local v3    # "i$":I
    .end local v4    # "len$":I
    :cond_2
    new-instance v6, Ljava/lang/StringBuilder;

    invoke-direct {v6}, Ljava/lang/StringBuilder;-><init>()V

    const-string v7, "AdDex."

    invoke-virtual {v6, v7}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v6

    invoke-virtual {v6, p1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v6

    const-string v7, "."

    invoke-virtual {v6, v7}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v6

    invoke-virtual {v6, v1}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v6

    const-string v7, ".dex"

    invoke-virtual {v6, v7}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v6

    invoke-virtual {v6}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v6

    return-object v6
.end method
