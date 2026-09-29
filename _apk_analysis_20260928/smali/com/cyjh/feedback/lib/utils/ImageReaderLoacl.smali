.class public Lcom/cyjh/feedback/lib/utils/ImageReaderLoacl;
.super Ljava/lang/Object;
.source "ImageReaderLoacl.java"


# static fields
.field private static final RATIO:I = 0x2


# direct methods
.method public constructor <init>()V
    .locals 0

    .prologue
    .line 20
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method

.method public static compressBmpFromBmp(Landroid/graphics/Bitmap;)Landroid/graphics/Bitmap;
    .locals 7
    .param p0, "bmp"    # Landroid/graphics/Bitmap;

    .prologue
    const/4 v4, 0x0

    .line 85
    if-nez p0, :cond_0

    move-object p0, v4

    .line 98
    .local v0, "bais":Ljava/io/ByteArrayInputStream;
    .local v1, "baos":Ljava/io/ByteArrayOutputStream;
    .local v2, "bitmap":Landroid/graphics/Bitmap;
    .local v3, "option":I
    :goto_0
    return-object p0

    .line 88
    .end local v0    # "bais":Ljava/io/ByteArrayInputStream;
    .end local v1    # "baos":Ljava/io/ByteArrayOutputStream;
    .end local v2    # "bitmap":Landroid/graphics/Bitmap;
    .end local v3    # "option":I
    :cond_0
    new-instance v1, Ljava/io/ByteArrayOutputStream;

    invoke-direct {v1}, Ljava/io/ByteArrayOutputStream;-><init>()V

    .line 89
    .restart local v1    # "baos":Ljava/io/ByteArrayOutputStream;
    const/16 v3, 0x64

    .line 90
    .restart local v3    # "option":I
    sget-object v5, Landroid/graphics/Bitmap$CompressFormat;->JPEG:Landroid/graphics/Bitmap$CompressFormat;

    invoke-virtual {p0, v5, v3, v1}, Landroid/graphics/Bitmap;->compress(Landroid/graphics/Bitmap$CompressFormat;ILjava/io/OutputStream;)Z

    .line 91
    :goto_1
    invoke-virtual {v1}, Ljava/io/ByteArrayOutputStream;->toByteArray()[B

    move-result-object v5

    array-length v5, v5

    div-int/lit16 v5, v5, 0x400

    const/16 v6, 0x64

    if-le v5, v6, :cond_1

    .line 92
    invoke-virtual {v1}, Ljava/io/ByteArrayOutputStream;->reset()V

    .line 93
    add-int/lit8 v3, v3, -0xa

    .line 94
    sget-object v5, Landroid/graphics/Bitmap$CompressFormat;->JPEG:Landroid/graphics/Bitmap$CompressFormat;

    invoke-virtual {p0, v5, v3, v1}, Landroid/graphics/Bitmap;->compress(Landroid/graphics/Bitmap$CompressFormat;ILjava/io/OutputStream;)Z

    goto :goto_1

    .line 96
    :cond_1
    new-instance v0, Ljava/io/ByteArrayInputStream;

    invoke-virtual {v1}, Ljava/io/ByteArrayOutputStream;->toByteArray()[B

    move-result-object v5

    invoke-direct {v0, v5}, Ljava/io/ByteArrayInputStream;-><init>([B)V

    .line 97
    .restart local v0    # "bais":Ljava/io/ByteArrayInputStream;
    invoke-static {v0, v4, v4}, Landroid/graphics/BitmapFactory;->decodeStream(Ljava/io/InputStream;Landroid/graphics/Rect;Landroid/graphics/BitmapFactory$Options;)Landroid/graphics/Bitmap;

    move-result-object v2

    .line 98
    .restart local v2    # "bitmap":Landroid/graphics/Bitmap;
    goto :goto_0
.end method

.method public static img2Base64(Landroid/content/Context;Ljava/lang/String;)Ljava/lang/String;
    .locals 13
    .param p0, "context"    # Landroid/content/Context;
    .param p1, "imagPath"    # Ljava/lang/String;

    .prologue
    const/4 v8, 0x0

    const/4 v12, 0x0

    .line 37
    const/4 v0, 0x0

    .line 38
    .local v0, "bitmap":Landroid/graphics/Bitmap;
    if-eqz p1, :cond_0

    invoke-virtual {p1}, Ljava/lang/String;->length()I

    move-result v9

    if-lez v9, :cond_0

    .line 39
    new-instance v2, Ljava/io/File;

    invoke-direct {v2, p1}, Ljava/io/File;-><init>(Ljava/lang/String;)V

    .line 40
    .local v2, "file":Ljava/io/File;
    invoke-virtual {v2}, Ljava/io/File;->length()J

    move-result-wide v10

    invoke-static {p0, v10, v11}, Landroid/text/format/Formatter;->formatFileSize(Landroid/content/Context;J)Ljava/lang/String;

    move-result-object v3

    .line 41
    .local v3, "imgLength":Ljava/lang/String;
    new-instance v9, Ljava/lang/StringBuilder;

    invoke-direct {v9}, Ljava/lang/StringBuilder;-><init>()V

    const-string v10, "\u56fe\u7247\u5927\u5c0f:"

    invoke-virtual {v9, v10}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v9

    invoke-virtual {v9, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v9

    invoke-virtual {v9}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v9

    new-array v10, v12, [Ljava/lang/Object;

    invoke-static {v9, v10}, Lcom/orhanobut/logger/Logger;->e(Ljava/lang/String;[Ljava/lang/Object;)V

    .line 43
    new-instance v5, Landroid/graphics/BitmapFactory$Options;

    invoke-direct {v5}, Landroid/graphics/BitmapFactory$Options;-><init>()V

    .line 44
    .local v5, "options":Landroid/graphics/BitmapFactory$Options;
    const/4 v9, 0x1

    iput-boolean v9, v5, Landroid/graphics/BitmapFactory$Options;->inJustDecodeBounds:Z

    .line 45
    invoke-static {p1, v5}, Landroid/graphics/BitmapFactory;->decodeFile(Ljava/lang/String;Landroid/graphics/BitmapFactory$Options;)Landroid/graphics/Bitmap;

    .line 46
    const/4 v4, 0x2

    .line 48
    .local v4, "inSampleSize":I
    iput v4, v5, Landroid/graphics/BitmapFactory$Options;->inSampleSize:I

    .line 49
    iput-boolean v12, v5, Landroid/graphics/BitmapFactory$Options;->inJustDecodeBounds:Z

    .line 50
    invoke-static {p1, v5}, Landroid/graphics/BitmapFactory;->decodeFile(Ljava/lang/String;Landroid/graphics/BitmapFactory$Options;)Landroid/graphics/Bitmap;

    move-result-object v0

    .line 52
    .end local v2    # "file":Ljava/io/File;
    .end local v3    # "imgLength":Ljava/lang/String;
    .end local v4    # "inSampleSize":I
    .end local v5    # "options":Landroid/graphics/BitmapFactory$Options;
    :cond_0
    if-nez v0, :cond_2

    .line 69
    :cond_1
    :goto_0
    return-object v8

    .line 55
    :cond_2
    const/4 v6, 0x0

    .line 57
    .local v6, "out":Ljava/io/ByteArrayOutputStream;
    :try_start_0
    new-instance v7, Ljava/io/ByteArrayOutputStream;

    invoke-direct {v7}, Ljava/io/ByteArrayOutputStream;-><init>()V
    :try_end_0
    .catch Ljava/lang/Exception; {:try_start_0 .. :try_end_0} :catch_4
    .catchall {:try_start_0 .. :try_end_0} :catchall_0

    .line 58
    .end local v6    # "out":Ljava/io/ByteArrayOutputStream;
    .local v7, "out":Ljava/io/ByteArrayOutputStream;
    :try_start_1
    sget-object v9, Landroid/graphics/Bitmap$CompressFormat;->JPEG:Landroid/graphics/Bitmap$CompressFormat;

    const/16 v10, 0x64

    invoke-virtual {v0, v9, v10, v7}, Landroid/graphics/Bitmap;->compress(Landroid/graphics/Bitmap$CompressFormat;ILjava/io/OutputStream;)Z

    .line 59
    const/16 v5, 0x64

    .line 61
    .local v5, "options":I
    :goto_1
    invoke-virtual {v7}, Ljava/io/ByteArrayOutputStream;->toByteArray()[B

    move-result-object v9

    array-length v9, v9

    div-int/lit16 v9, v9, 0x400

    const/16 v10, 0x41

    if-le v9, v10, :cond_3

    .line 62
    invoke-virtual {v7}, Ljava/io/ByteArrayOutputStream;->reset()V

    .line 63
    add-int/lit8 v5, v5, -0xa

    .line 64
    sget-object v9, Landroid/graphics/Bitmap$CompressFormat;->JPEG:Landroid/graphics/Bitmap$CompressFormat;

    invoke-virtual {v0, v9, v5, v7}, Landroid/graphics/Bitmap;->compress(Landroid/graphics/Bitmap$CompressFormat;ILjava/io/OutputStream;)Z
    :try_end_1
    .catch Ljava/lang/Exception; {:try_start_1 .. :try_end_1} :catch_0
    .catchall {:try_start_1 .. :try_end_1} :catchall_1

    goto :goto_1

    .line 68
    .end local v5    # "options":I
    :catch_0
    move-exception v1

    move-object v6, v7

    .line 71
    .end local v7    # "out":Ljava/io/ByteArrayOutputStream;
    .local v1, "e":Ljava/lang/Exception;
    .restart local v6    # "out":Ljava/io/ByteArrayOutputStream;
    :goto_2
    if-eqz v6, :cond_1

    .line 73
    :try_start_2
    invoke-virtual {v6}, Ljava/io/ByteArrayOutputStream;->close()V
    :try_end_2
    .catch Ljava/io/IOException; {:try_start_2 .. :try_end_2} :catch_1

    goto :goto_0

    .line 74
    :catch_1
    move-exception v1

    .line 75
    .local v1, "e":Ljava/io/IOException;
    invoke-virtual {v1}, Ljava/io/IOException;->printStackTrace()V

    goto :goto_0

    .line 66
    .end local v1    # "e":Ljava/io/IOException;
    .end local v6    # "out":Ljava/io/ByteArrayOutputStream;
    .restart local v5    # "options":I
    .restart local v7    # "out":Ljava/io/ByteArrayOutputStream;
    :cond_3
    :try_start_3
    new-instance v9, Ljava/lang/StringBuilder;

    invoke-direct {v9}, Ljava/lang/StringBuilder;-><init>()V

    const-string v10, "\u56fe\u7247\u7684\u5927\u5c0f:"

    invoke-virtual {v9, v10}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v9

    invoke-virtual {v7}, Ljava/io/ByteArrayOutputStream;->toByteArray()[B

    move-result-object v10

    array-length v10, v10

    div-int/lit16 v10, v10, 0x400

    invoke-virtual {v9, v10}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v9

    invoke-virtual {v9}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v9

    const/4 v10, 0x0

    new-array v10, v10, [Ljava/lang/Object;

    invoke-static {v9, v10}, Lcom/orhanobut/logger/Logger;->e(Ljava/lang/String;[Ljava/lang/Object;)V

    .line 67
    invoke-virtual {v7}, Ljava/io/ByteArrayOutputStream;->toByteArray()[B

    move-result-object v9

    const/4 v10, 0x0

    invoke-static {v9, v10}, Landroid/util/Base64;->encodeToString([BI)Ljava/lang/String;

    move-result-object v9

    const-string v10, "UTF-8"

    invoke-static {v9, v10}, Ljava/net/URLEncoder;->encode(Ljava/lang/String;Ljava/lang/String;)Ljava/lang/String;
    :try_end_3
    .catch Ljava/lang/Exception; {:try_start_3 .. :try_end_3} :catch_0
    .catchall {:try_start_3 .. :try_end_3} :catchall_1

    move-result-object v8

    .line 71
    if-eqz v7, :cond_1

    .line 73
    :try_start_4
    invoke-virtual {v7}, Ljava/io/ByteArrayOutputStream;->close()V
    :try_end_4
    .catch Ljava/io/IOException; {:try_start_4 .. :try_end_4} :catch_2

    goto :goto_0

    .line 74
    :catch_2
    move-exception v1

    .line 75
    .restart local v1    # "e":Ljava/io/IOException;
    invoke-virtual {v1}, Ljava/io/IOException;->printStackTrace()V

    goto :goto_0

    .line 71
    .end local v1    # "e":Ljava/io/IOException;
    .end local v5    # "options":I
    .end local v7    # "out":Ljava/io/ByteArrayOutputStream;
    .restart local v6    # "out":Ljava/io/ByteArrayOutputStream;
    :catchall_0
    move-exception v8

    :goto_3
    if-eqz v6, :cond_4

    .line 73
    :try_start_5
    invoke-virtual {v6}, Ljava/io/ByteArrayOutputStream;->close()V
    :try_end_5
    .catch Ljava/io/IOException; {:try_start_5 .. :try_end_5} :catch_3

    .line 76
    :cond_4
    :goto_4
    throw v8

    .line 74
    :catch_3
    move-exception v1

    .line 75
    .restart local v1    # "e":Ljava/io/IOException;
    invoke-virtual {v1}, Ljava/io/IOException;->printStackTrace()V

    goto :goto_4

    .line 71
    .end local v1    # "e":Ljava/io/IOException;
    .end local v6    # "out":Ljava/io/ByteArrayOutputStream;
    .restart local v7    # "out":Ljava/io/ByteArrayOutputStream;
    :catchall_1
    move-exception v8

    move-object v6, v7

    .end local v7    # "out":Ljava/io/ByteArrayOutputStream;
    .restart local v6    # "out":Ljava/io/ByteArrayOutputStream;
    goto :goto_3

    .line 68
    :catch_4
    move-exception v1

    goto :goto_2
.end method

.method public static readBitmapFromPath(Ljava/lang/String;)Landroid/graphics/Bitmap;
    .locals 2
    .param p0, "imgPath"    # Ljava/lang/String;

    .prologue
    .line 27
    :try_start_0
    invoke-static {p0}, Landroid/graphics/BitmapFactory;->decodeFile(Ljava/lang/String;)Landroid/graphics/Bitmap;
    :try_end_0
    .catch Ljava/lang/Exception; {:try_start_0 .. :try_end_0} :catch_0

    move-result-object v1

    .line 29
    :goto_0
    return-object v1

    .line 28
    :catch_0
    move-exception v0

    .line 29
    .local v0, "e":Ljava/lang/Exception;
    const/4 v1, 0x0

    goto :goto_0
.end method
