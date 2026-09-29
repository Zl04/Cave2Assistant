.class public Lcom/cyjh/elfin/util/FileUtils;
.super Ljava/lang/Object;
.source "FileUtils.java"


# annotations
.annotation system Ldalvik/annotation/MemberClasses;
    value = {
        Lcom/cyjh/elfin/util/FileUtils$copyFilesTask;,
        Lcom/cyjh/elfin/util/FileUtils$FileSuffixrFilter;
    }
.end annotation


# static fields
.field private static final SAFE_FILENAME_PATTERN:Ljava/util/regex/Pattern;


# direct methods
.method static constructor <clinit>()V
    .locals 1

    .prologue
    .line 227
    const-string v0, "[\\w%+,./=_-]+"

    invoke-static {v0}, Ljava/util/regex/Pattern;->compile(Ljava/lang/String;)Ljava/util/regex/Pattern;

    move-result-object v0

    sput-object v0, Lcom/cyjh/elfin/util/FileUtils;->SAFE_FILENAME_PATTERN:Ljava/util/regex/Pattern;

    return-void
.end method

.method public constructor <init>()V
    .locals 0

    .prologue
    .line 39
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method

.method public static copyFile(Ljava/io/File;Ljava/io/File;)Z
    .locals 4
    .param p0, "srcFile"    # Ljava/io/File;
    .param p1, "destFile"    # Ljava/io/File;

    .prologue
    .line 234
    const/4 v2, 0x0

    .line 236
    .local v2, "result":Z
    :try_start_0
    new-instance v1, Ljava/io/FileInputStream;

    invoke-direct {v1, p0}, Ljava/io/FileInputStream;-><init>(Ljava/io/File;)V
    :try_end_0
    .catch Ljava/io/IOException; {:try_start_0 .. :try_end_0} :catch_0

    .line 238
    .local v1, "in":Ljava/io/InputStream;
    :try_start_1
    invoke-static {v1, p1}, Lcom/cyjh/elfin/util/FileUtils;->copyToFile(Ljava/io/InputStream;Ljava/io/File;)Z
    :try_end_1
    .catchall {:try_start_1 .. :try_end_1} :catchall_0

    move-result v2

    .line 240
    :try_start_2
    invoke-virtual {v1}, Ljava/io/InputStream;->close()V

    .line 245
    .end local v1    # "in":Ljava/io/InputStream;
    :goto_0
    return v2

    .line 240
    .restart local v1    # "in":Ljava/io/InputStream;
    :catchall_0
    move-exception v3

    invoke-virtual {v1}, Ljava/io/InputStream;->close()V

    throw v3
    :try_end_2
    .catch Ljava/io/IOException; {:try_start_2 .. :try_end_2} :catch_0

    .line 242
    .end local v1    # "in":Ljava/io/InputStream;
    :catch_0
    move-exception v0

    .line 243
    .local v0, "e":Ljava/io/IOException;
    const/4 v2, 0x0

    goto :goto_0
.end method

.method public static copyToFile(Ljava/io/InputStream;Ljava/io/File;)Z
    .locals 7
    .param p0, "inputStream"    # Ljava/io/InputStream;
    .param p1, "destFile"    # Ljava/io/File;

    .prologue
    const/4 v4, 0x0

    .line 254
    :try_start_0
    invoke-virtual {p1}, Ljava/io/File;->exists()Z

    move-result v5

    if-eqz v5, :cond_0

    .line 255
    invoke-virtual {p1}, Ljava/io/File;->delete()Z

    .line 257
    :cond_0
    new-instance v3, Ljava/io/FileOutputStream;

    invoke-direct {v3, p1}, Ljava/io/FileOutputStream;-><init>(Ljava/io/File;)V
    :try_end_0
    .catch Ljava/io/IOException; {:try_start_0 .. :try_end_0} :catch_0

    .line 259
    .local v3, "out":Ljava/io/FileOutputStream;
    const/16 v5, 0x1000

    :try_start_1
    new-array v0, v5, [B

    .line 261
    .local v0, "buffer":[B
    :goto_0
    invoke-virtual {p0, v0}, Ljava/io/InputStream;->read([B)I

    move-result v1

    .local v1, "bytesRead":I
    if-ltz v1, :cond_1

    .line 262
    const/4 v5, 0x0

    invoke-virtual {v3, v0, v5, v1}, Ljava/io/FileOutputStream;->write([BII)V
    :try_end_1
    .catchall {:try_start_1 .. :try_end_1} :catchall_0

    goto :goto_0

    .line 265
    .end local v0    # "buffer":[B
    .end local v1    # "bytesRead":I
    :catchall_0
    move-exception v5

    :try_start_2
    invoke-virtual {v3}, Ljava/io/FileOutputStream;->flush()V
    :try_end_2
    .catch Ljava/io/IOException; {:try_start_2 .. :try_end_2} :catch_0

    .line 267
    :try_start_3
    invoke-virtual {v3}, Ljava/io/FileOutputStream;->getFD()Ljava/io/FileDescriptor;

    move-result-object v6

    invoke-virtual {v6}, Ljava/io/FileDescriptor;->sync()V
    :try_end_3
    .catch Ljava/io/IOException; {:try_start_3 .. :try_end_3} :catch_1

    .line 270
    :goto_1
    :try_start_4
    invoke-virtual {v3}, Ljava/io/FileOutputStream;->close()V

    throw v5

    .line 273
    .end local v3    # "out":Ljava/io/FileOutputStream;
    :catch_0
    move-exception v2

    .line 274
    :goto_2
    return v4

    .line 265
    .restart local v0    # "buffer":[B
    .restart local v1    # "bytesRead":I
    .restart local v3    # "out":Ljava/io/FileOutputStream;
    :cond_1
    invoke-virtual {v3}, Ljava/io/FileOutputStream;->flush()V
    :try_end_4
    .catch Ljava/io/IOException; {:try_start_4 .. :try_end_4} :catch_0

    .line 267
    :try_start_5
    invoke-virtual {v3}, Ljava/io/FileOutputStream;->getFD()Ljava/io/FileDescriptor;

    move-result-object v5

    invoke-virtual {v5}, Ljava/io/FileDescriptor;->sync()V
    :try_end_5
    .catch Ljava/io/IOException; {:try_start_5 .. :try_end_5} :catch_2

    .line 270
    :goto_3
    :try_start_6
    invoke-virtual {v3}, Ljava/io/FileOutputStream;->close()V
    :try_end_6
    .catch Ljava/io/IOException; {:try_start_6 .. :try_end_6} :catch_0

    .line 272
    const/4 v4, 0x1

    goto :goto_2

    .line 268
    .end local v0    # "buffer":[B
    .end local v1    # "bytesRead":I
    :catch_1
    move-exception v6

    goto :goto_1

    .restart local v0    # "buffer":[B
    .restart local v1    # "bytesRead":I
    :catch_2
    move-exception v5

    goto :goto_3
.end method

.method public static formetFileSize(J)Ljava/lang/String;
    .locals 8
    .param p0, "fileS"    # J

    .prologue
    .line 170
    new-instance v0, Ljava/text/DecimalFormat;

    const-string v2, "#"

    invoke-direct {v0, v2}, Ljava/text/DecimalFormat;-><init>(Ljava/lang/String;)V

    .line 172
    .local v0, "df":Ljava/text/DecimalFormat;
    const-wide/16 v2, 0x400

    cmp-long v2, p0, v2

    if-gez v2, :cond_0

    .line 173
    new-instance v2, Ljava/lang/StringBuilder;

    invoke-direct {v2}, Ljava/lang/StringBuilder;-><init>()V

    long-to-double v4, p0

    invoke-virtual {v0, v4, v5}, Ljava/text/DecimalFormat;->format(D)Ljava/lang/String;

    move-result-object v3

    invoke-virtual {v2, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    const-string v3, "B"

    invoke-virtual {v2, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    invoke-virtual {v2}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v1

    .line 181
    .local v1, "fileSizeString":Ljava/lang/String;
    :goto_0
    return-object v1

    .line 174
    .end local v1    # "fileSizeString":Ljava/lang/String;
    :cond_0
    const-wide/32 v2, 0x100000

    cmp-long v2, p0, v2

    if-gez v2, :cond_1

    .line 175
    new-instance v2, Ljava/lang/StringBuilder;

    invoke-direct {v2}, Ljava/lang/StringBuilder;-><init>()V

    long-to-double v4, p0

    const-wide/high16 v6, 0x4090000000000000L    # 1024.0

    div-double/2addr v4, v6

    invoke-virtual {v0, v4, v5}, Ljava/text/DecimalFormat;->format(D)Ljava/lang/String;

    move-result-object v3

    invoke-virtual {v2, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    const-string v3, "KB"

    invoke-virtual {v2, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    invoke-virtual {v2}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v1

    .restart local v1    # "fileSizeString":Ljava/lang/String;
    goto :goto_0

    .line 176
    .end local v1    # "fileSizeString":Ljava/lang/String;
    :cond_1
    const-wide/32 v2, 0x40000000

    cmp-long v2, p0, v2

    if-gez v2, :cond_2

    .line 177
    new-instance v2, Ljava/lang/StringBuilder;

    invoke-direct {v2}, Ljava/lang/StringBuilder;-><init>()V

    long-to-double v4, p0

    const-wide/high16 v6, 0x4130000000000000L    # 1048576.0

    div-double/2addr v4, v6

    invoke-virtual {v0, v4, v5}, Ljava/text/DecimalFormat;->format(D)Ljava/lang/String;

    move-result-object v3

    invoke-virtual {v2, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    const-string v3, "MB"

    invoke-virtual {v2, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    invoke-virtual {v2}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v1

    .restart local v1    # "fileSizeString":Ljava/lang/String;
    goto :goto_0

    .line 179
    .end local v1    # "fileSizeString":Ljava/lang/String;
    :cond_2
    new-instance v2, Ljava/lang/StringBuilder;

    invoke-direct {v2}, Ljava/lang/StringBuilder;-><init>()V

    long-to-double v4, p0

    const-wide/high16 v6, 0x41d0000000000000L    # 1.073741824E9

    div-double/2addr v4, v6

    invoke-virtual {v0, v4, v5}, Ljava/text/DecimalFormat;->format(D)Ljava/lang/String;

    move-result-object v3

    invoke-virtual {v2, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    const-string v3, "G"

    invoke-virtual {v2, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    invoke-virtual {v2}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v1

    .restart local v1    # "fileSizeString":Ljava/lang/String;
    goto :goto_0
.end method

.method public static isFileExits(Ljava/lang/String;Ljava/lang/String;)Z
    .locals 5
    .param p0, "dir"    # Ljava/lang/String;
    .param p1, "fileName"    # Ljava/lang/String;

    .prologue
    .line 391
    if-nez p1, :cond_0

    const-string p1, ""

    .line 392
    :cond_0
    if-nez p0, :cond_1

    const-string p0, ""

    .line 393
    :cond_1
    const-string v3, "/"

    invoke-virtual {p0, v3}, Ljava/lang/String;->lastIndexOf(Ljava/lang/String;)I

    move-result v2

    .line 395
    .local v2, "index":I
    invoke-virtual {p0}, Ljava/lang/String;->length()I

    move-result v3

    add-int/lit8 v3, v3, -0x1

    if-ne v2, v3, :cond_2

    .line 396
    new-instance v3, Ljava/lang/StringBuilder;

    invoke-direct {v3}, Ljava/lang/StringBuilder;-><init>()V

    invoke-virtual {v3, p0}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v3

    invoke-virtual {v3, p1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v3

    invoke-virtual {v3}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v1

    .line 401
    .local v1, "filePath":Ljava/lang/String;
    :goto_0
    new-instance v0, Ljava/io/File;

    invoke-direct {v0, v1}, Ljava/io/File;-><init>(Ljava/lang/String;)V

    .line 402
    .local v0, "file":Ljava/io/File;
    invoke-virtual {v0}, Ljava/io/File;->exists()Z

    move-result v3

    return v3

    .line 398
    .end local v0    # "file":Ljava/io/File;
    .end local v1    # "filePath":Ljava/lang/String;
    :cond_2
    new-instance v3, Ljava/lang/StringBuilder;

    invoke-direct {v3}, Ljava/lang/StringBuilder;-><init>()V

    invoke-virtual {v3, p0}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v3

    const-string v4, "/"

    invoke-virtual {v3, v4}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v3

    invoke-virtual {v3, p1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v3

    invoke-virtual {v3}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v1

    .restart local v1    # "filePath":Ljava/lang/String;
    goto :goto_0
.end method

.method public static isFilenameSafe(Ljava/io/File;)Z
    .locals 2
    .param p0, "file"    # Ljava/io/File;

    .prologue
    .line 288
    sget-object v0, Lcom/cyjh/elfin/util/FileUtils;->SAFE_FILENAME_PATTERN:Ljava/util/regex/Pattern;

    invoke-virtual {p0}, Ljava/io/File;->getPath()Ljava/lang/String;

    move-result-object v1

    invoke-virtual {v0, v1}, Ljava/util/regex/Pattern;->matcher(Ljava/lang/CharSequence;)Ljava/util/regex/Matcher;

    move-result-object v0

    invoke-virtual {v0}, Ljava/util/regex/Matcher;->matches()Z

    move-result v0

    return v0
.end method

.method public static makePath(Ljava/lang/String;Ljava/lang/String;)Ljava/lang/String;
    .locals 2
    .param p0, "path1"    # Ljava/lang/String;
    .param p1, "name"    # Ljava/lang/String;

    .prologue
    .line 48
    sget-object v0, Ljava/io/File;->separator:Ljava/lang/String;

    invoke-virtual {p0, v0}, Ljava/lang/String;->endsWith(Ljava/lang/String;)Z

    move-result v0

    if-eqz v0, :cond_0

    .line 49
    new-instance v0, Ljava/lang/StringBuilder;

    invoke-direct {v0}, Ljava/lang/StringBuilder;-><init>()V

    invoke-virtual {v0, p0}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-virtual {v0, p1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-virtual {v0}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v0

    .line 51
    :goto_0
    return-object v0

    :cond_0
    new-instance v0, Ljava/lang/StringBuilder;

    invoke-direct {v0}, Ljava/lang/StringBuilder;-><init>()V

    invoke-virtual {v0, p0}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    sget-object v1, Ljava/io/File;->separator:Ljava/lang/String;

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-virtual {v0, p1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-virtual {v0}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v0

    goto :goto_0
.end method

.method public static mkdirs(Ljava/lang/String;)Ljava/lang/String;
    .locals 3
    .param p0, "path"    # Ljava/lang/String;

    .prologue
    .line 409
    new-instance v1, Ljava/io/File;

    invoke-direct {v1, p0}, Ljava/io/File;-><init>(Ljava/lang/String;)V

    .line 410
    .local v1, "file":Ljava/io/File;
    invoke-virtual {v1}, Ljava/io/File;->exists()Z

    move-result v2

    if-nez v2, :cond_0

    .line 411
    invoke-virtual {v1}, Ljava/io/File;->mkdirs()Z

    .line 414
    :try_start_0
    invoke-virtual {v1}, Ljava/io/File;->isDirectory()Z

    move-result v2

    if-nez v2, :cond_0

    .line 416
    invoke-virtual {v1}, Ljava/io/File;->createNewFile()Z
    :try_end_0
    .catch Ljava/io/IOException; {:try_start_0 .. :try_end_0} :catch_0

    .line 422
    :cond_0
    :goto_0
    invoke-virtual {v1}, Ljava/io/File;->getAbsolutePath()Ljava/lang/String;

    move-result-object v2

    return-object v2

    .line 418
    :catch_0
    move-exception v0

    .line 419
    .local v0, "e":Ljava/io/IOException;
    invoke-virtual {v0}, Ljava/io/IOException;->printStackTrace()V

    goto :goto_0
.end method

.method public static readTextFile(Ljava/io/File;)Ljava/lang/String;
    .locals 11
    .param p0, "file"    # Ljava/io/File;

    .prologue
    const/4 v1, 0x0

    const/4 v10, -0x1

    .line 103
    new-instance v6, Ljava/lang/StringBuffer;

    invoke-direct {v6}, Ljava/lang/StringBuffer;-><init>()V

    .line 106
    .local v6, "text":Ljava/lang/StringBuffer;
    :try_start_0
    new-instance v5, Ljava/io/InputStreamReader;

    new-instance v8, Ljava/io/FileInputStream;

    invoke-direct {v8, p0}, Ljava/io/FileInputStream;-><init>(Ljava/io/File;)V

    const-string v9, "UTF-8"

    invoke-direct {v5, v8, v9}, Ljava/io/InputStreamReader;-><init>(Ljava/io/InputStream;Ljava/lang/String;)V

    .line 107
    .local v5, "reader":Ljava/io/InputStreamReader;
    new-instance v3, Ljava/io/BufferedReader;

    invoke-direct {v3, v5}, Ljava/io/BufferedReader;-><init>(Ljava/io/Reader;)V

    .line 109
    .local v3, "in":Ljava/io/BufferedReader;
    :cond_0
    invoke-virtual {v3}, Ljava/io/BufferedReader;->read()I

    move-result v0

    .line 110
    .local v0, "c":I
    if-eq v0, v10, :cond_1

    .line 111
    int-to-char v8, v0

    invoke-virtual {v6, v8}, Ljava/lang/StringBuffer;->append(C)Ljava/lang/StringBuffer;

    .line 113
    :cond_1
    if-ne v0, v10, :cond_0

    .line 114
    invoke-virtual {v3}, Ljava/io/BufferedReader;->close()V
    :try_end_0
    .catch Ljava/io/IOException; {:try_start_0 .. :try_end_0} :catch_0
    .catch Ljava/lang/OutOfMemoryError; {:try_start_0 .. :try_end_0} :catch_1

    .line 121
    invoke-virtual {v6}, Ljava/lang/StringBuffer;->toString()Ljava/lang/String;

    move-result-object v1

    .line 122
    .local v1, "content":Ljava/lang/String;
    const-string v8, "\r\n"

    invoke-virtual {v1, v8}, Ljava/lang/String;->indexOf(Ljava/lang/String;)I

    move-result v7

    .line 123
    .local v7, "windows":I
    const-string v8, "\r"

    invoke-virtual {v1, v8}, Ljava/lang/String;->indexOf(Ljava/lang/String;)I

    move-result v4

    .line 124
    .local v4, "macos":I
    if-eq v7, v10, :cond_3

    .line 125
    const-string v8, "\r\n"

    const-string v9, "\n"

    invoke-virtual {v1, v8, v9}, Ljava/lang/String;->replaceAll(Ljava/lang/String;Ljava/lang/String;)Ljava/lang/String;

    move-result-object v1

    .line 132
    .end local v0    # "c":I
    .end local v1    # "content":Ljava/lang/String;
    .end local v3    # "in":Ljava/io/BufferedReader;
    .end local v4    # "macos":I
    .end local v5    # "reader":Ljava/io/InputStreamReader;
    .end local v7    # "windows":I
    :cond_2
    :goto_0
    return-object v1

    .line 115
    :catch_0
    move-exception v2

    .line 116
    .local v2, "e":Ljava/io/IOException;
    goto :goto_0

    .line 117
    .end local v2    # "e":Ljava/io/IOException;
    :catch_1
    move-exception v2

    .line 118
    .local v2, "e":Ljava/lang/OutOfMemoryError;
    goto :goto_0

    .line 127
    .end local v2    # "e":Ljava/lang/OutOfMemoryError;
    .restart local v0    # "c":I
    .restart local v1    # "content":Ljava/lang/String;
    .restart local v3    # "in":Ljava/io/BufferedReader;
    .restart local v4    # "macos":I
    .restart local v5    # "reader":Ljava/io/InputStreamReader;
    .restart local v7    # "windows":I
    :cond_3
    if-eq v4, v10, :cond_2

    .line 128
    const-string v8, "\r"

    const-string v9, "\n"

    invoke-virtual {v1, v8, v9}, Ljava/lang/String;->replaceAll(Ljava/lang/String;Ljava/lang/String;)Ljava/lang/String;

    move-result-object v1

    goto :goto_0
.end method

.method public static readTextFile(Ljava/io/File;ILjava/lang/String;)Ljava/lang/String;
    .locals 16
    .param p0, "file"    # Ljava/io/File;
    .param p1, "max"    # I
    .param p2, "ellipsis"    # Ljava/lang/String;
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljava/io/IOException;
        }
    .end annotation

    .prologue
    .line 305
    new-instance v5, Ljava/io/FileInputStream;

    move-object/from16 v0, p0

    invoke-direct {v5, v0}, Ljava/io/FileInputStream;-><init>(Ljava/io/File;)V

    .line 312
    .local v5, "input":Ljava/io/InputStream;
    new-instance v2, Ljava/io/BufferedInputStream;

    invoke-direct {v2, v5}, Ljava/io/BufferedInputStream;-><init>(Ljava/io/InputStream;)V

    .line 314
    .local v2, "bis":Ljava/io/BufferedInputStream;
    :try_start_0
    invoke-virtual/range {p0 .. p0}, Ljava/io/File;->length()J

    move-result-wide v10

    .line 315
    .local v10, "size":J
    if-gtz p1, :cond_0

    const-wide/16 v14, 0x0

    cmp-long v13, v10, v14

    if-lez v13, :cond_6

    if-nez p1, :cond_6

    .line 317
    :cond_0
    const-wide/16 v14, 0x0

    cmp-long v13, v10, v14

    if-lez v13, :cond_2

    if-eqz p1, :cond_1

    move/from16 v0, p1

    int-to-long v14, v0

    cmp-long v13, v10, v14

    if-gez v13, :cond_2

    .line 318
    :cond_1
    long-to-int v0, v10

    move/from16 p1, v0

    .line 319
    :cond_2
    add-int/lit8 v13, p1, 0x1

    new-array v4, v13, [B

    .line 320
    .local v4, "data":[B
    invoke-virtual {v2, v4}, Ljava/io/BufferedInputStream;->read([B)I

    move-result v8

    .line 321
    .local v8, "length":I
    if-gtz v8, :cond_3

    .line 322
    const-string v13, ""
    :try_end_0
    .catchall {:try_start_0 .. :try_end_0} :catchall_0

    .line 369
    invoke-virtual {v2}, Ljava/io/BufferedInputStream;->close()V

    .line 370
    invoke-virtual {v5}, Ljava/io/InputStream;->close()V

    .line 366
    .end local v8    # "length":I
    :goto_0
    return-object v13

    .line 323
    .restart local v8    # "length":I
    :cond_3
    move/from16 v0, p1

    if-gt v8, v0, :cond_4

    .line 324
    :try_start_1
    new-instance v13, Ljava/lang/String;

    const/4 v14, 0x0

    invoke-direct {v13, v4, v14, v8}, Ljava/lang/String;-><init>([BII)V
    :try_end_1
    .catchall {:try_start_1 .. :try_end_1} :catchall_0

    .line 369
    invoke-virtual {v2}, Ljava/io/BufferedInputStream;->close()V

    .line 370
    invoke-virtual {v5}, Ljava/io/InputStream;->close()V

    goto :goto_0

    .line 325
    :cond_4
    if-nez p2, :cond_5

    .line 326
    :try_start_2
    new-instance v13, Ljava/lang/String;

    const/4 v14, 0x0

    move/from16 v0, p1

    invoke-direct {v13, v4, v14, v0}, Ljava/lang/String;-><init>([BII)V
    :try_end_2
    .catchall {:try_start_2 .. :try_end_2} :catchall_0

    .line 369
    invoke-virtual {v2}, Ljava/io/BufferedInputStream;->close()V

    .line 370
    invoke-virtual {v5}, Ljava/io/InputStream;->close()V

    goto :goto_0

    .line 327
    :cond_5
    :try_start_3
    new-instance v13, Ljava/lang/StringBuilder;

    invoke-direct {v13}, Ljava/lang/StringBuilder;-><init>()V

    new-instance v14, Ljava/lang/String;

    const/4 v15, 0x0

    move/from16 v0, p1

    invoke-direct {v14, v4, v15, v0}, Ljava/lang/String;-><init>([BII)V

    invoke-virtual {v13, v14}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v13

    move-object/from16 v0, p2

    invoke-virtual {v13, v0}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v13

    invoke-virtual {v13}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;
    :try_end_3
    .catchall {:try_start_3 .. :try_end_3} :catchall_0

    move-result-object v13

    .line 369
    invoke-virtual {v2}, Ljava/io/BufferedInputStream;->close()V

    .line 370
    invoke-virtual {v5}, Ljava/io/InputStream;->close()V

    goto :goto_0

    .line 328
    .end local v4    # "data":[B
    .end local v8    # "length":I
    :cond_6
    if-gez p1, :cond_f

    .line 330
    const/4 v9, 0x0

    .line 331
    .local v9, "rolled":Z
    const/4 v6, 0x0

    .line 332
    .local v6, "last":[B
    const/4 v4, 0x0

    .line 334
    .restart local v4    # "data":[B
    :cond_7
    if-eqz v6, :cond_8

    .line 335
    const/4 v9, 0x1

    .line 336
    :cond_8
    move-object v12, v6

    .line 337
    .local v12, "tmp":[B
    move-object v6, v4

    .line 338
    move-object v4, v12

    .line 339
    if-nez v4, :cond_9

    .line 340
    move/from16 v0, p1

    neg-int v13, v0

    :try_start_4
    new-array v4, v13, [B

    .line 341
    :cond_9
    invoke-virtual {v2, v4}, Ljava/io/BufferedInputStream;->read([B)I

    move-result v7

    .line 342
    .local v7, "len":I
    array-length v13, v4

    if-eq v7, v13, :cond_7

    .line 344
    if-nez v6, :cond_a

    if-gtz v7, :cond_a

    .line 345
    const-string v13, ""
    :try_end_4
    .catchall {:try_start_4 .. :try_end_4} :catchall_0

    .line 369
    invoke-virtual {v2}, Ljava/io/BufferedInputStream;->close()V

    .line 370
    invoke-virtual {v5}, Ljava/io/InputStream;->close()V

    goto :goto_0

    .line 346
    :cond_a
    if-nez v6, :cond_b

    .line 347
    :try_start_5
    new-instance v13, Ljava/lang/String;

    const/4 v14, 0x0

    invoke-direct {v13, v4, v14, v7}, Ljava/lang/String;-><init>([BII)V
    :try_end_5
    .catchall {:try_start_5 .. :try_end_5} :catchall_0

    .line 369
    invoke-virtual {v2}, Ljava/io/BufferedInputStream;->close()V

    .line 370
    invoke-virtual {v5}, Ljava/io/InputStream;->close()V

    goto :goto_0

    .line 348
    :cond_b
    if-lez v7, :cond_c

    .line 349
    const/4 v9, 0x1

    .line 350
    const/4 v13, 0x0

    :try_start_6
    array-length v14, v6

    sub-int/2addr v14, v7

    invoke-static {v6, v7, v6, v13, v14}, Ljava/lang/System;->arraycopy(Ljava/lang/Object;ILjava/lang/Object;II)V

    .line 351
    const/4 v13, 0x0

    array-length v14, v6

    sub-int/2addr v14, v7

    invoke-static {v4, v13, v6, v14, v7}, Ljava/lang/System;->arraycopy(Ljava/lang/Object;ILjava/lang/Object;II)V

    .line 353
    :cond_c
    if-eqz p2, :cond_d

    if-nez v9, :cond_e

    .line 354
    :cond_d
    new-instance v13, Ljava/lang/String;

    invoke-direct {v13, v6}, Ljava/lang/String;-><init>([B)V
    :try_end_6
    .catchall {:try_start_6 .. :try_end_6} :catchall_0

    .line 369
    invoke-virtual {v2}, Ljava/io/BufferedInputStream;->close()V

    .line 370
    invoke-virtual {v5}, Ljava/io/InputStream;->close()V

    goto/16 :goto_0

    .line 355
    :cond_e
    :try_start_7
    new-instance v13, Ljava/lang/StringBuilder;

    invoke-direct {v13}, Ljava/lang/StringBuilder;-><init>()V

    move-object/from16 v0, p2

    invoke-virtual {v13, v0}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v13

    new-instance v14, Ljava/lang/String;

    invoke-direct {v14, v6}, Ljava/lang/String;-><init>([B)V

    invoke-virtual {v13, v14}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v13

    invoke-virtual {v13}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;
    :try_end_7
    .catchall {:try_start_7 .. :try_end_7} :catchall_0

    move-result-object v13

    .line 369
    invoke-virtual {v2}, Ljava/io/BufferedInputStream;->close()V

    .line 370
    invoke-virtual {v5}, Ljava/io/InputStream;->close()V

    goto/16 :goto_0

    .line 358
    .end local v4    # "data":[B
    .end local v6    # "last":[B
    .end local v7    # "len":I
    .end local v9    # "rolled":Z
    .end local v12    # "tmp":[B
    :cond_f
    :try_start_8
    new-instance v3, Ljava/io/ByteArrayOutputStream;

    invoke-direct {v3}, Ljava/io/ByteArrayOutputStream;-><init>()V

    .line 360
    .local v3, "contents":Ljava/io/ByteArrayOutputStream;
    const/16 v13, 0x400

    new-array v4, v13, [B

    .line 362
    .restart local v4    # "data":[B
    :cond_10
    invoke-virtual {v2, v4}, Ljava/io/BufferedInputStream;->read([B)I

    move-result v7

    .line 363
    .restart local v7    # "len":I
    if-lez v7, :cond_11

    .line 364
    const/4 v13, 0x0

    invoke-virtual {v3, v4, v13, v7}, Ljava/io/ByteArrayOutputStream;->write([BII)V

    .line 365
    :cond_11
    array-length v13, v4

    if-eq v7, v13, :cond_10

    .line 366
    invoke-virtual {v3}, Ljava/io/ByteArrayOutputStream;->toString()Ljava/lang/String;
    :try_end_8
    .catchall {:try_start_8 .. :try_end_8} :catchall_0

    move-result-object v13

    .line 369
    invoke-virtual {v2}, Ljava/io/BufferedInputStream;->close()V

    .line 370
    invoke-virtual {v5}, Ljava/io/InputStream;->close()V

    goto/16 :goto_0

    .line 369
    .end local v3    # "contents":Ljava/io/ByteArrayOutputStream;
    .end local v4    # "data":[B
    .end local v7    # "len":I
    .end local v10    # "size":J
    :catchall_0
    move-exception v13

    invoke-virtual {v2}, Ljava/io/BufferedInputStream;->close()V

    .line 370
    invoke-virtual {v5}, Ljava/io/InputStream;->close()V

    throw v13
.end method

.method public static stringToFile(Ljava/lang/String;Ljava/lang/String;)V
    .locals 2
    .param p0, "filename"    # Ljava/lang/String;
    .param p1, "string"    # Ljava/lang/String;
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljava/io/IOException;
        }
    .end annotation

    .prologue
    .line 382
    new-instance v0, Ljava/io/FileWriter;

    invoke-direct {v0, p0}, Ljava/io/FileWriter;-><init>(Ljava/lang/String;)V

    .line 384
    .local v0, "out":Ljava/io/FileWriter;
    :try_start_0
    invoke-virtual {v0, p1}, Ljava/io/FileWriter;->write(Ljava/lang/String;)V
    :try_end_0
    .catchall {:try_start_0 .. :try_end_0} :catchall_0

    .line 386
    invoke-virtual {v0}, Ljava/io/FileWriter;->close()V

    .line 388
    return-void

    .line 386
    :catchall_0
    move-exception v1

    invoke-virtual {v0}, Ljava/io/FileWriter;->close()V

    throw v1
.end method
