.class public final Lcom/cyjh/mobileanjian/ipc/utils/FileUtils;
.super Ljava/lang/Object;
.source "SourceFile"


# direct methods
.method public constructor <init>()V
    .locals 0

    .prologue
    .line 25
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method

.method private static a(Ljava/lang/String;)Ljava/lang/String;
    .locals 5

    .prologue
    const/4 v0, 0x0

    const/4 v4, 0x0

    .line 102
    if-eqz p0, :cond_0

    invoke-virtual {p0}, Ljava/lang/String;->trim()Ljava/lang/String;

    move-result-object v1

    const-string v2, ""

    invoke-virtual {v1, v2}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v1

    if-eqz v1, :cond_1

    .line 117
    :cond_0
    :goto_0
    return-object v0

    .line 104
    :cond_1
    new-instance v1, Ljava/lang/StringBuffer;

    invoke-direct {v1, p0}, Ljava/lang/StringBuffer;-><init>(Ljava/lang/String;)V

    .line 105
    :cond_2
    invoke-virtual {v1, v4}, Ljava/lang/StringBuffer;->charAt(I)C

    move-result v2

    sget-char v3, Ljava/io/File;->separatorChar:C

    if-ne v2, v3, :cond_3

    .line 107
    invoke-virtual {v1, v4}, Ljava/lang/StringBuffer;->deleteCharAt(I)Ljava/lang/StringBuffer;

    .line 108
    invoke-virtual {v1}, Ljava/lang/StringBuffer;->length()I

    move-result v2

    if-nez v2, :cond_2

    goto :goto_0

    .line 111
    :cond_3
    invoke-virtual {v1}, Ljava/lang/StringBuffer;->length()I

    move-result v2

    add-int/lit8 v2, v2, -0x1

    invoke-virtual {v1, v2}, Ljava/lang/StringBuffer;->charAt(I)C

    move-result v2

    sget-object v3, Ljava/io/File;->separator:Ljava/lang/String;

    invoke-virtual {v3, v4}, Ljava/lang/String;->charAt(I)C

    move-result v3

    if-ne v2, v3, :cond_4

    .line 113
    invoke-virtual {v1}, Ljava/lang/StringBuffer;->length()I

    move-result v2

    add-int/lit8 v2, v2, -0x1

    invoke-virtual {v1, v2}, Ljava/lang/StringBuffer;->deleteCharAt(I)Ljava/lang/StringBuffer;

    .line 114
    invoke-virtual {v1}, Ljava/lang/StringBuffer;->length()I

    move-result v2

    if-nez v2, :cond_3

    goto :goto_0

    .line 117
    :cond_4
    invoke-virtual {v1}, Ljava/lang/StringBuffer;->toString()Ljava/lang/String;

    move-result-object v0

    goto :goto_0
.end method

.method public static copyAssetsFile(Landroid/content/Context;Ljava/lang/String;Ljava/lang/String;)V
    .locals 5

    .prologue
    .line 85
    :try_start_0
    invoke-virtual {p0}, Landroid/content/Context;->getAssets()Landroid/content/res/AssetManager;

    move-result-object v0

    invoke-virtual {v0, p1}, Landroid/content/res/AssetManager;->open(Ljava/lang/String;)Ljava/io/InputStream;

    move-result-object v0

    .line 86
    new-instance v1, Ljava/io/FileOutputStream;

    invoke-direct {v1, p2}, Ljava/io/FileOutputStream;-><init>(Ljava/lang/String;)V

    .line 88
    const/16 v2, 0x1000

    new-array v2, v2, [B

    .line 89
    :goto_0
    invoke-virtual {v0, v2}, Ljava/io/InputStream;->read([B)I

    move-result v3

    if-lez v3, :cond_0

    .line 90
    const/4 v4, 0x0

    invoke-virtual {v1, v2, v4, v3}, Ljava/io/FileOutputStream;->write([BII)V
    :try_end_0
    .catch Ljava/io/IOException; {:try_start_0 .. :try_end_0} :catch_0

    goto :goto_0

    .line 94
    :catch_0
    move-exception v0

    .line 96
    invoke-virtual {v0}, Ljava/io/IOException;->printStackTrace()V

    .line 98
    :goto_1
    return-void

    .line 91
    :cond_0
    :try_start_1
    invoke-virtual {v1}, Ljava/io/FileOutputStream;->flush()V

    .line 92
    invoke-virtual {v0}, Ljava/io/InputStream;->close()V

    .line 93
    invoke-virtual {v1}, Ljava/io/FileOutputStream;->close()V
    :try_end_1
    .catch Ljava/io/IOException; {:try_start_1 .. :try_end_1} :catch_0

    goto :goto_1
.end method

.method public static copyRawFile(Landroid/content/Context;ILjava/lang/String;)Z
    .locals 6

    .prologue
    const/4 v2, 0x0

    const/4 v0, 0x0

    .line 29
    .line 34
    :try_start_0
    new-instance v1, Ljava/io/File;

    invoke-direct {v1, p2}, Ljava/io/File;-><init>(Ljava/lang/String;)V

    .line 35
    invoke-virtual {v1}, Ljava/io/File;->exists()Z

    move-result v3

    if-nez v3, :cond_3

    .line 37
    invoke-virtual {v1}, Ljava/io/File;->createNewFile()Z

    .line 46
    :cond_0
    :goto_0
    const/16 v3, 0x1000

    new-array v5, v3, [B

    .line 47
    invoke-virtual {p0}, Landroid/content/Context;->getResources()Landroid/content/res/Resources;

    move-result-object v3

    invoke-virtual {v3, p1}, Landroid/content/res/Resources;->openRawResource(I)Ljava/io/InputStream;
    :try_end_0
    .catch Ljava/io/FileNotFoundException; {:try_start_0 .. :try_end_0} :catch_1
    .catch Ljava/io/IOException; {:try_start_0 .. :try_end_0} :catch_4
    .catchall {:try_start_0 .. :try_end_0} :catchall_0

    move-result-object v4

    .line 48
    :try_start_1
    new-instance v3, Ljava/io/FileOutputStream;

    invoke-direct {v3, v1}, Ljava/io/FileOutputStream;-><init>(Ljava/io/File;)V
    :try_end_1
    .catch Ljava/io/FileNotFoundException; {:try_start_1 .. :try_end_1} :catch_9
    .catch Ljava/io/IOException; {:try_start_1 .. :try_end_1} :catch_7
    .catchall {:try_start_1 .. :try_end_1} :catchall_1

    .line 49
    :goto_1
    :try_start_2
    invoke-virtual {v4, v5}, Ljava/io/InputStream;->read([B)I

    move-result v1

    if-lez v1, :cond_4

    .line 51
    const/4 v2, 0x0

    invoke-virtual {v3, v5, v2, v1}, Ljava/io/FileOutputStream;->write([BII)V
    :try_end_2
    .catch Ljava/io/FileNotFoundException; {:try_start_2 .. :try_end_2} :catch_0
    .catch Ljava/io/IOException; {:try_start_2 .. :try_end_2} :catch_8
    .catchall {:try_start_2 .. :try_end_2} :catchall_2

    goto :goto_1

    .line 55
    :catch_0
    move-exception v1

    move-object v2, v3

    move-object v3, v4

    .line 57
    :goto_2
    :try_start_3
    invoke-virtual {v1}, Ljava/io/FileNotFoundException;->printStackTrace()V
    :try_end_3
    .catchall {:try_start_3 .. :try_end_3} :catchall_3

    .line 67
    if-eqz v3, :cond_1

    .line 68
    :try_start_4
    invoke-virtual {v3}, Ljava/io/InputStream;->close()V

    .line 69
    :cond_1
    if-eqz v2, :cond_2

    .line 70
    invoke-virtual {v2}, Ljava/io/FileOutputStream;->close()V
    :try_end_4
    .catch Ljava/io/IOException; {:try_start_4 .. :try_end_4} :catch_3

    .line 77
    :cond_2
    :goto_3
    return v0

    .line 39
    :cond_3
    :try_start_5
    invoke-virtual {v1}, Ljava/io/File;->isDirectory()Z

    move-result v3

    if-eqz v3, :cond_0

    .line 41
    invoke-virtual {p0}, Landroid/content/Context;->getResources()Landroid/content/res/Resources;

    move-result-object v1

    invoke-virtual {v1, p1}, Landroid/content/res/Resources;->getResourceName(I)Ljava/lang/String;

    move-result-object v3

    .line 42
    new-instance v1, Ljava/io/File;

    new-instance v4, Ljava/lang/StringBuilder;

    invoke-direct {v4}, Ljava/lang/StringBuilder;-><init>()V

    invoke-virtual {v4, p2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v4

    sget-object v5, Ljava/io/File;->separator:Ljava/lang/String;

    invoke-virtual {v4, v5}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v4

    invoke-virtual {v4, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v3

    invoke-virtual {v3}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v3

    invoke-direct {v1, v3}, Ljava/io/File;-><init>(Ljava/lang/String;)V
    :try_end_5
    .catch Ljava/io/FileNotFoundException; {:try_start_5 .. :try_end_5} :catch_1
    .catch Ljava/io/IOException; {:try_start_5 .. :try_end_5} :catch_4
    .catchall {:try_start_5 .. :try_end_5} :catchall_0

    goto :goto_0

    .line 55
    :catch_1
    move-exception v1

    move-object v3, v2

    goto :goto_2

    .line 53
    :cond_4
    const/4 v0, 0x1

    .line 67
    if-eqz v4, :cond_5

    .line 68
    :try_start_6
    invoke-virtual {v4}, Ljava/io/InputStream;->close()V

    .line 69
    :cond_5
    if-eqz v3, :cond_2

    .line 70
    invoke-virtual {v3}, Ljava/io/FileOutputStream;->close()V
    :try_end_6
    .catch Ljava/io/IOException; {:try_start_6 .. :try_end_6} :catch_2

    goto :goto_3

    .line 72
    :catch_2
    move-exception v1

    .line 74
    invoke-virtual {v1}, Ljava/io/IOException;->printStackTrace()V

    goto :goto_3

    .line 72
    :catch_3
    move-exception v1

    .line 74
    invoke-virtual {v1}, Ljava/io/IOException;->printStackTrace()V

    goto :goto_3

    .line 59
    :catch_4
    move-exception v1

    move-object v4, v2

    .line 61
    :goto_4
    :try_start_7
    invoke-virtual {v1}, Ljava/io/IOException;->printStackTrace()V
    :try_end_7
    .catchall {:try_start_7 .. :try_end_7} :catchall_1

    .line 67
    if-eqz v4, :cond_6

    .line 68
    :try_start_8
    invoke-virtual {v4}, Ljava/io/InputStream;->close()V

    .line 69
    :cond_6
    if-eqz v2, :cond_2

    .line 70
    invoke-virtual {v2}, Ljava/io/FileOutputStream;->close()V
    :try_end_8
    .catch Ljava/io/IOException; {:try_start_8 .. :try_end_8} :catch_5

    goto :goto_3

    .line 72
    :catch_5
    move-exception v1

    .line 74
    invoke-virtual {v1}, Ljava/io/IOException;->printStackTrace()V

    goto :goto_3

    .line 65
    :catchall_0
    move-exception v0

    move-object v4, v2

    .line 67
    :goto_5
    if-eqz v4, :cond_7

    .line 68
    :try_start_9
    invoke-virtual {v4}, Ljava/io/InputStream;->close()V

    .line 69
    :cond_7
    if-eqz v2, :cond_8

    .line 70
    invoke-virtual {v2}, Ljava/io/FileOutputStream;->close()V
    :try_end_9
    .catch Ljava/io/IOException; {:try_start_9 .. :try_end_9} :catch_6

    .line 75
    :cond_8
    :goto_6
    throw v0

    .line 72
    :catch_6
    move-exception v1

    .line 74
    invoke-virtual {v1}, Ljava/io/IOException;->printStackTrace()V

    goto :goto_6

    .line 65
    :catchall_1
    move-exception v0

    goto :goto_5

    :catchall_2
    move-exception v0

    move-object v2, v3

    goto :goto_5

    :catchall_3
    move-exception v0

    move-object v4, v3

    goto :goto_5

    .line 59
    :catch_7
    move-exception v1

    goto :goto_4

    :catch_8
    move-exception v1

    move-object v2, v3

    goto :goto_4

    .line 55
    :catch_9
    move-exception v1

    move-object v3, v4

    goto/16 :goto_2
.end method

.method public static final createFolder(Ljava/lang/String;)I
    .locals 2

    .prologue
    .line 178
    .line 179
    new-instance v0, Ljava/io/File;

    invoke-direct {v0, p0}, Ljava/io/File;-><init>(Ljava/lang/String;)V

    .line 180
    invoke-virtual {v0}, Ljava/io/File;->exists()Z

    move-result v1

    if-eqz v1, :cond_1

    .line 182
    invoke-virtual {v0}, Ljava/io/File;->isDirectory()Z

    move-result v0

    if-eqz v0, :cond_0

    .line 183
    const/4 v0, 0x1

    .line 194
    :goto_0
    return v0

    .line 185
    :cond_0
    const/4 v0, -0x2

    goto :goto_0

    .line 189
    :cond_1
    invoke-virtual {v0}, Ljava/io/File;->mkdirs()Z

    move-result v0

    if-nez v0, :cond_2

    .line 191
    :cond_2
    const/4 v0, -0x1

    goto :goto_0
.end method

.method public static file2Text(Ljava/lang/String;Ljava/lang/String;)Ljava/lang/String;
    .locals 6

    .prologue
    .line 321
    new-instance v1, Ljava/lang/StringBuffer;

    invoke-direct {v1}, Ljava/lang/StringBuffer;-><init>()V

    .line 322
    new-instance v0, Ljava/io/File;

    invoke-direct {v0, p0}, Ljava/io/File;-><init>(Ljava/lang/String;)V

    .line 326
    const/16 v2, 0x400

    :try_start_0
    new-array v2, v2, [B

    .line 327
    new-instance v3, Ljava/io/FileInputStream;

    invoke-direct {v3, v0}, Ljava/io/FileInputStream;-><init>(Ljava/io/File;)V

    .line 328
    :goto_0
    invoke-virtual {v3, v2}, Ljava/io/FileInputStream;->read([B)I

    move-result v0

    if-lez v0, :cond_0

    .line 329
    new-instance v4, Ljava/lang/String;

    const/4 v5, 0x0

    invoke-direct {v4, v2, v5, v0, p1}, Ljava/lang/String;-><init>([BIILjava/lang/String;)V

    invoke-virtual {v1, v4}, Ljava/lang/StringBuffer;->append(Ljava/lang/String;)Ljava/lang/StringBuffer;
    :try_end_0
    .catch Ljava/io/FileNotFoundException; {:try_start_0 .. :try_end_0} :catch_0
    .catch Ljava/io/IOException; {:try_start_0 .. :try_end_0} :catch_1

    goto :goto_0

    .line 331
    :catch_0
    move-exception v0

    .line 333
    invoke-virtual {v0}, Ljava/io/FileNotFoundException;->printStackTrace()V

    .line 339
    :cond_0
    :goto_1
    invoke-virtual {v1}, Ljava/lang/StringBuffer;->toString()Ljava/lang/String;

    move-result-object v0

    return-object v0

    .line 334
    :catch_1
    move-exception v0

    .line 336
    invoke-virtual {v0}, Ljava/io/IOException;->printStackTrace()V

    goto :goto_1
.end method

.method public static getBaseFilePath(Ljava/lang/String;)Ljava/lang/String;
    .locals 2

    .prologue
    .line 199
    if-eqz p0, :cond_0

    invoke-virtual {p0}, Ljava/lang/String;->length()I

    move-result v0

    if-lez v0, :cond_0

    .line 201
    const/16 v0, 0x2e

    invoke-virtual {p0, v0}, Ljava/lang/String;->lastIndexOf(I)I

    move-result v0

    .line 202
    if-ltz v0, :cond_0

    invoke-virtual {p0}, Ljava/lang/String;->length()I

    move-result v1

    if-ge v0, v1, :cond_0

    .line 203
    const/4 v1, 0x0

    invoke-virtual {p0, v1, v0}, Ljava/lang/String;->substring(II)Ljava/lang/String;

    move-result-object p0

    .line 205
    :cond_0
    return-object p0
.end method

.method public static varargs makeAbsolutePath(Ljava/lang/String;[Ljava/lang/String;)Ljava/lang/String;
    .locals 4

    .prologue
    const/4 v2, 0x0

    const/4 v1, 0x0

    .line 129
    if-nez p0, :cond_0

    move-object v0, v2

    .line 165
    :goto_0
    return-object v0

    :cond_0
    move v0, v1

    .line 133
    :goto_1
    array-length v3, p1

    if-ge v0, v3, :cond_2

    .line 135
    aget-object v3, p1, v0

    if-nez v3, :cond_1

    move-object v0, v2

    .line 136
    goto :goto_0

    .line 133
    :cond_1
    add-int/lit8 v0, v0, 0x1

    goto :goto_1

    .line 139
    :cond_2
    sget-object v0, Ljava/io/File;->separator:Ljava/lang/String;

    .line 140
    new-instance v2, Ljava/lang/StringBuffer;

    invoke-direct {v2}, Ljava/lang/StringBuffer;-><init>()V

    .line 141
    invoke-virtual {p0, v0}, Ljava/lang/String;->startsWith(Ljava/lang/String;)Z

    move-result v3

    if-nez v3, :cond_3

    .line 143
    invoke-virtual {v2, v0}, Ljava/lang/StringBuffer;->append(Ljava/lang/String;)Ljava/lang/StringBuffer;

    .line 145
    :cond_3
    invoke-virtual {v2, p0}, Ljava/lang/StringBuffer;->append(Ljava/lang/String;)Ljava/lang/StringBuffer;

    .line 146
    invoke-virtual {p0, v0}, Ljava/lang/String;->endsWith(Ljava/lang/String;)Z

    move-result v3

    if-nez v3, :cond_4

    .line 148
    invoke-virtual {v2, v0}, Ljava/lang/StringBuffer;->append(Ljava/lang/String;)Ljava/lang/StringBuffer;

    .line 151
    :cond_4
    :goto_2
    array-length v3, p1

    if-ge v1, v3, :cond_6

    .line 153
    aget-object v3, p1, v1

    invoke-static {v3}, Lcom/cyjh/mobileanjian/ipc/utils/FileUtils;->a(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v3

    .line 154
    if-nez v3, :cond_5

    .line 151
    :goto_3
    add-int/lit8 v1, v1, 0x1

    goto :goto_2

    .line 156
    :cond_5
    invoke-virtual {v2, v3}, Ljava/lang/StringBuffer;->append(Ljava/lang/String;)Ljava/lang/StringBuffer;

    .line 157
    invoke-virtual {v2, v0}, Ljava/lang/StringBuffer;->append(Ljava/lang/String;)Ljava/lang/StringBuffer;

    goto :goto_3

    .line 160
    :cond_6
    invoke-virtual {v2, v0}, Ljava/lang/StringBuffer;->lastIndexOf(Ljava/lang/String;)I

    move-result v0

    invoke-virtual {v2}, Ljava/lang/StringBuffer;->length()I

    move-result v1

    add-int/lit8 v1, v1, -0x1

    if-ne v0, v1, :cond_7

    .line 162
    invoke-virtual {v2}, Ljava/lang/StringBuffer;->length()I

    move-result v0

    add-int/lit8 v0, v0, -0x1

    invoke-virtual {v2, v0}, Ljava/lang/StringBuffer;->deleteCharAt(I)Ljava/lang/StringBuffer;

    .line 165
    :cond_7
    invoke-virtual {v2}, Ljava/lang/StringBuffer;->toString()Ljava/lang/String;

    move-result-object v0

    goto :goto_0
.end method

.method public static final moveFiles(Ljava/lang/String;Ljava/lang/String;Z)I
    .locals 12

    .prologue
    const-wide/16 v8, 0x0

    const/4 v2, 0x0

    const/4 v7, -0x1

    .line 250
    const/4 v6, 0x0

    .line 254
    new-instance v10, Ljava/io/File;

    invoke-direct {v10, p0}, Ljava/io/File;-><init>(Ljava/lang/String;)V

    .line 255
    new-instance v0, Ljava/io/File;

    invoke-direct {v0, p1}, Ljava/io/File;-><init>(Ljava/lang/String;)V

    .line 259
    invoke-virtual {v10}, Ljava/io/File;->exists()Z

    move-result v1

    if-nez v1, :cond_0

    .line 260
    const/4 v0, 0x1

    .line 316
    :goto_0
    return v0

    .line 261
    :cond_0
    invoke-virtual {v0}, Ljava/io/File;->exists()Z

    move-result v1

    if-nez v1, :cond_1

    .line 262
    const/4 v0, 0x2

    goto :goto_0

    .line 263
    :cond_1
    invoke-virtual {v0}, Ljava/io/File;->isDirectory()Z

    move-result v0

    if-nez v0, :cond_2

    .line 264
    const/4 v0, 0x3

    goto :goto_0

    .line 265
    :cond_2
    invoke-virtual {v10}, Ljava/io/File;->isFile()Z

    move-result v0

    if-eqz v0, :cond_d

    .line 267
    new-instance v0, Ljava/io/File;

    new-instance v1, Ljava/lang/StringBuilder;

    invoke-direct {v1}, Ljava/lang/StringBuilder;-><init>()V

    invoke-virtual {v1, p1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    sget-object v3, Ljava/io/File;->separator:Ljava/lang/String;

    invoke-virtual {v1, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v10}, Ljava/io/File;->getName()Ljava/lang/String;

    move-result-object v3

    invoke-virtual {v1, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v1

    invoke-direct {v0, v1}, Ljava/io/File;-><init>(Ljava/lang/String;)V

    .line 268
    invoke-virtual {v0}, Ljava/io/File;->exists()Z

    move-result v0

    if-eqz v0, :cond_3

    if-nez p2, :cond_3

    .line 269
    const/4 v0, 0x4

    goto :goto_0

    .line 272
    :cond_3
    :try_start_0
    new-instance v0, Ljava/io/FileInputStream;

    invoke-direct {v0, p0}, Ljava/io/FileInputStream;-><init>(Ljava/lang/String;)V

    invoke-virtual {v0}, Ljava/io/FileInputStream;->getChannel()Ljava/nio/channels/FileChannel;
    :try_end_0
    .catch Ljava/io/FileNotFoundException; {:try_start_0 .. :try_end_0} :catch_1
    .catch Ljava/io/IOException; {:try_start_0 .. :try_end_0} :catch_3
    .catchall {:try_start_0 .. :try_end_0} :catchall_0

    move-result-object v1

    .line 273
    :try_start_1
    new-instance v0, Ljava/io/FileInputStream;

    new-instance v3, Ljava/lang/StringBuilder;

    invoke-direct {v3}, Ljava/lang/StringBuilder;-><init>()V

    invoke-virtual {v3, p1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v3

    sget-object v4, Ljava/io/File;->separator:Ljava/lang/String;

    invoke-virtual {v3, v4}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v3

    invoke-virtual {v10}, Ljava/io/File;->getName()Ljava/lang/String;

    move-result-object v4

    invoke-virtual {v3, v4}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v3

    invoke-virtual {v3}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v3

    invoke-direct {v0, v3}, Ljava/io/FileInputStream;-><init>(Ljava/lang/String;)V

    .line 274
    invoke-virtual {v0}, Ljava/io/FileInputStream;->getChannel()Ljava/nio/channels/FileChannel;
    :try_end_1
    .catch Ljava/io/FileNotFoundException; {:try_start_1 .. :try_end_1} :catch_8
    .catch Ljava/io/IOException; {:try_start_1 .. :try_end_1} :catch_6
    .catchall {:try_start_1 .. :try_end_1} :catchall_1

    move-result-object v0

    move-wide v2, v8

    .line 275
    :cond_4
    sub-long v4, v8, v2

    :try_start_2
    invoke-virtual/range {v0 .. v5}, Ljava/nio/channels/FileChannel;->transferFrom(Ljava/nio/channels/ReadableByteChannel;JJ)J

    move-result-wide v4

    add-long/2addr v2, v4

    cmp-long v4, v2, v8

    if-ltz v4, :cond_4

    .line 277
    invoke-virtual {v10}, Ljava/io/File;->delete()Z
    :try_end_2
    .catch Ljava/io/FileNotFoundException; {:try_start_2 .. :try_end_2} :catch_9
    .catch Ljava/io/IOException; {:try_start_2 .. :try_end_2} :catch_7
    .catchall {:try_start_2 .. :try_end_2} :catchall_2

    .line 295
    if-eqz v1, :cond_5

    .line 297
    :try_start_3
    invoke-virtual {v1}, Ljava/nio/channels/FileChannel;->close()V

    .line 299
    :cond_5
    if-eqz v0, :cond_6

    .line 301
    invoke-virtual {v0}, Ljava/nio/channels/FileChannel;->close()V
    :try_end_3
    .catch Ljava/io/IOException; {:try_start_3 .. :try_end_3} :catch_0

    :cond_6
    move v0, v6

    .line 308
    goto/16 :goto_0

    .line 304
    :catch_0
    move-exception v0

    .line 307
    invoke-virtual {v0}, Ljava/io/IOException;->printStackTrace()V

    move v0, v6

    .line 309
    goto/16 :goto_0

    .line 279
    :catch_1
    move-exception v0

    move-object v1, v2

    .line 282
    :goto_1
    :try_start_4
    invoke-virtual {v0}, Ljava/io/FileNotFoundException;->printStackTrace()V
    :try_end_4
    .catchall {:try_start_4 .. :try_end_4} :catchall_3

    .line 295
    if-eqz v2, :cond_7

    .line 297
    :try_start_5
    invoke-virtual {v2}, Ljava/nio/channels/FileChannel;->close()V

    .line 299
    :cond_7
    if-eqz v1, :cond_8

    .line 301
    invoke-virtual {v1}, Ljava/nio/channels/FileChannel;->close()V
    :try_end_5
    .catch Ljava/io/IOException; {:try_start_5 .. :try_end_5} :catch_2

    :cond_8
    move v0, v7

    .line 308
    goto/16 :goto_0

    .line 304
    :catch_2
    move-exception v0

    .line 307
    invoke-virtual {v0}, Ljava/io/IOException;->printStackTrace()V

    move v0, v7

    .line 309
    goto/16 :goto_0

    .line 285
    :catch_3
    move-exception v0

    move-object v1, v2

    .line 288
    :goto_2
    :try_start_6
    invoke-virtual {v0}, Ljava/io/IOException;->printStackTrace()V
    :try_end_6
    .catchall {:try_start_6 .. :try_end_6} :catchall_1

    .line 295
    if-eqz v1, :cond_9

    .line 297
    :try_start_7
    invoke-virtual {v1}, Ljava/nio/channels/FileChannel;->close()V

    .line 299
    :cond_9
    if-eqz v2, :cond_a

    .line 301
    invoke-virtual {v2}, Ljava/nio/channels/FileChannel;->close()V
    :try_end_7
    .catch Ljava/io/IOException; {:try_start_7 .. :try_end_7} :catch_4

    :cond_a
    move v0, v7

    .line 308
    goto/16 :goto_0

    .line 304
    :catch_4
    move-exception v0

    .line 307
    invoke-virtual {v0}, Ljava/io/IOException;->printStackTrace()V

    move v0, v7

    .line 309
    goto/16 :goto_0

    .line 293
    :catchall_0
    move-exception v0

    move-object v1, v2

    .line 295
    :goto_3
    if-eqz v1, :cond_b

    .line 297
    :try_start_8
    invoke-virtual {v1}, Ljava/nio/channels/FileChannel;->close()V

    .line 299
    :cond_b
    if-eqz v2, :cond_c

    .line 301
    invoke-virtual {v2}, Ljava/nio/channels/FileChannel;->close()V
    :try_end_8
    .catch Ljava/io/IOException; {:try_start_8 .. :try_end_8} :catch_5

    .line 308
    :cond_c
    :goto_4
    throw v0

    .line 304
    :catch_5
    move-exception v1

    .line 307
    invoke-virtual {v1}, Ljava/io/IOException;->printStackTrace()V

    goto :goto_4

    .line 311
    :cond_d
    invoke-virtual {v10}, Ljava/io/File;->isDirectory()Z

    move-result v0

    if-eqz v0, :cond_e

    :cond_e
    move v0, v6

    goto/16 :goto_0

    .line 293
    :catchall_1
    move-exception v0

    goto :goto_3

    :catchall_2
    move-exception v2

    move-object v11, v2

    move-object v2, v0

    move-object v0, v11

    goto :goto_3

    :catchall_3
    move-exception v0

    move-object v11, v1

    move-object v1, v2

    move-object v2, v11

    goto :goto_3

    .line 285
    :catch_6
    move-exception v0

    goto :goto_2

    :catch_7
    move-exception v2

    move-object v11, v2

    move-object v2, v0

    move-object v0, v11

    goto :goto_2

    .line 279
    :catch_8
    move-exception v0

    move-object v11, v2

    move-object v2, v1

    move-object v1, v11

    goto :goto_1

    :catch_9
    move-exception v2

    move-object v11, v2

    move-object v2, v1

    move-object v1, v0

    move-object v0, v11

    goto :goto_1
.end method

.method public static recursionDeleteFiles(Ljava/lang/String;)V
    .locals 5

    .prologue
    .line 214
    new-instance v0, Ljava/io/File;

    invoke-direct {v0, p0}, Ljava/io/File;-><init>(Ljava/lang/String;)V

    .line 215
    invoke-virtual {v0}, Ljava/io/File;->isDirectory()Z

    move-result v1

    if-eqz v1, :cond_1

    .line 217
    invoke-virtual {v0}, Ljava/io/File;->listFiles()[Ljava/io/File;

    move-result-object v1

    .line 218
    if-eqz v1, :cond_1

    .line 220
    array-length v2, v1

    const/4 v0, 0x0

    :goto_0
    if-ge v0, v2, :cond_1

    aget-object v3, v1, v0

    .line 222
    invoke-virtual {v3}, Ljava/io/File;->isDirectory()Z

    move-result v4

    if-eqz v4, :cond_0

    .line 223
    invoke-virtual {v3}, Ljava/io/File;->getAbsolutePath()Ljava/lang/String;

    move-result-object v4

    invoke-static {v4}, Lcom/cyjh/mobileanjian/ipc/utils/FileUtils;->recursionDeleteFiles(Ljava/lang/String;)V

    .line 224
    :cond_0
    invoke-virtual {v3}, Ljava/io/File;->delete()Z

    .line 220
    add-int/lit8 v0, v0, 0x1

    goto :goto_0

    .line 228
    :cond_1
    return-void
.end method
