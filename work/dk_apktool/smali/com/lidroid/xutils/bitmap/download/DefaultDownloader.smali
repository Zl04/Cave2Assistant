.class public Lcom/lidroid/xutils/bitmap/download/DefaultDownloader;
.super Lcom/lidroid/xutils/bitmap/download/Downloader;
.source "SourceFile"


# direct methods
.method public constructor <init>()V
    .locals 0

    .prologue
    .line 27
    invoke-direct {p0}, Lcom/lidroid/xutils/bitmap/download/Downloader;-><init>()V

    return-void
.end method


# virtual methods
.method public downloadToStream(Ljava/lang/String;Ljava/io/OutputStream;Lcom/lidroid/xutils/BitmapUtils$BitmapLoadTask;)J
    .locals 16
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "(",
            "Ljava/lang/String;",
            "Ljava/io/OutputStream;",
            "Lcom/lidroid/xutils/BitmapUtils$BitmapLoadTask",
            "<*>;)J"
        }
    .end annotation

    .prologue
    .line 40
    if-eqz p3, :cond_0

    invoke-virtual/range {p3 .. p3}, Lcom/lidroid/xutils/BitmapUtils$BitmapLoadTask;->isCancelled()Z

    move-result v2

    if-nez v2, :cond_0

    invoke-virtual/range {p3 .. p3}, Lcom/lidroid/xutils/BitmapUtils$BitmapLoadTask;->getTargetContainer()Landroid/view/View;

    move-result-object v2

    if-nez v2, :cond_1

    :cond_0
    const-wide/16 v2, -0x1

    .line 90
    :goto_0
    return-wide v2

    .line 43
    :cond_1
    const/4 v4, 0x0

    .line 45
    invoke-static {}, Lcom/lidroid/xutils/util/OtherUtils;->trustAllHttpsURLConnection()V

    .line 49
    const-wide/16 v6, 0x0

    .line 51
    :try_start_0
    const-string v2, "/"

    move-object/from16 v0, p1

    invoke-virtual {v0, v2}, Ljava/lang/String;->startsWith(Ljava/lang/String;)Z

    move-result v2

    if-eqz v2, :cond_3

    .line 52
    new-instance v2, Ljava/io/FileInputStream;

    move-object/from16 v0, p1

    invoke-direct {v2, v0}, Ljava/io/FileInputStream;-><init>(Ljava/lang/String;)V

    .line 53
    invoke-virtual {v2}, Ljava/io/FileInputStream;->available()I

    move-result v3

    int-to-long v8, v3

    .line 54
    new-instance v3, Ljava/io/BufferedInputStream;

    invoke-direct {v3, v2}, Ljava/io/BufferedInputStream;-><init>(Ljava/io/InputStream;)V
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_1
    .catchall {:try_start_0 .. :try_end_0} :catchall_0

    .line 55
    :try_start_1
    invoke-static {}, Ljava/lang/System;->currentTimeMillis()J

    move-result-wide v4

    invoke-virtual/range {p0 .. p0}, Lcom/lidroid/xutils/bitmap/download/DefaultDownloader;->getDefaultExpiry()J
    :try_end_1
    .catch Ljava/lang/Throwable; {:try_start_1 .. :try_end_1} :catch_2
    .catchall {:try_start_1 .. :try_end_1} :catchall_1

    move-result-wide v10

    add-long/2addr v4, v10

    move-wide v14, v4

    move-object v4, v3

    move-wide v2, v14

    .line 72
    :goto_1
    :try_start_2
    invoke-virtual/range {p3 .. p3}, Lcom/lidroid/xutils/BitmapUtils$BitmapLoadTask;->isCancelled()Z

    move-result v5

    if-nez v5, :cond_2

    invoke-virtual/range {p3 .. p3}, Lcom/lidroid/xutils/BitmapUtils$BitmapLoadTask;->getTargetContainer()Landroid/view/View;
    :try_end_2
    .catch Ljava/lang/Throwable; {:try_start_2 .. :try_end_2} :catch_0
    .catchall {:try_start_2 .. :try_end_2} :catchall_0

    move-result-object v5

    if-nez v5, :cond_6

    .line 88
    :cond_2
    invoke-static {v4}, Lcom/lidroid/xutils/util/IOUtils;->closeQuietly(Ljava/io/Closeable;)V

    .line 72
    const-wide/16 v2, -0x1

    goto :goto_0

    .line 56
    :cond_3
    :try_start_3
    const-string v2, "assets/"

    move-object/from16 v0, p1

    invoke-virtual {v0, v2}, Ljava/lang/String;->startsWith(Ljava/lang/String;)Z

    move-result v2

    if-eqz v2, :cond_4

    .line 57
    invoke-virtual/range {p0 .. p0}, Lcom/lidroid/xutils/bitmap/download/DefaultDownloader;->getContext()Landroid/content/Context;

    move-result-object v2

    invoke-virtual {v2}, Landroid/content/Context;->getAssets()Landroid/content/res/AssetManager;

    move-result-object v2

    const/4 v3, 0x7

    invoke-virtual/range {p1 .. p1}, Ljava/lang/String;->length()I

    move-result v5

    move-object/from16 v0, p1

    invoke-virtual {v0, v3, v5}, Ljava/lang/String;->substring(II)Ljava/lang/String;

    move-result-object v3

    invoke-virtual {v2, v3}, Landroid/content/res/AssetManager;->open(Ljava/lang/String;)Ljava/io/InputStream;

    move-result-object v5

    .line 58
    invoke-virtual {v5}, Ljava/io/InputStream;->available()I

    move-result v2

    int-to-long v2, v2

    .line 59
    new-instance v8, Ljava/io/BufferedInputStream;

    invoke-direct {v8, v5}, Ljava/io/BufferedInputStream;-><init>(Ljava/io/InputStream;)V

    .line 60
    const-wide v4, 0x7fffffffffffffffL

    move-wide v14, v2

    move-wide v2, v4

    move-object v4, v8

    move-wide v8, v14

    .line 61
    goto :goto_1

    .line 62
    :cond_4
    new-instance v2, Ljava/net/URL;

    move-object/from16 v0, p1

    invoke-direct {v2, v0}, Ljava/net/URL;-><init>(Ljava/lang/String;)V

    .line 63
    invoke-virtual {v2}, Ljava/net/URL;->openConnection()Ljava/net/URLConnection;

    move-result-object v2

    .line 64
    invoke-virtual/range {p0 .. p0}, Lcom/lidroid/xutils/bitmap/download/DefaultDownloader;->getDefaultConnectTimeout()I

    move-result v3

    invoke-virtual {v2, v3}, Ljava/net/URLConnection;->setConnectTimeout(I)V

    .line 65
    invoke-virtual/range {p0 .. p0}, Lcom/lidroid/xutils/bitmap/download/DefaultDownloader;->getDefaultReadTimeout()I

    move-result v3

    invoke-virtual {v2, v3}, Ljava/net/URLConnection;->setReadTimeout(I)V

    .line 66
    new-instance v3, Ljava/io/BufferedInputStream;

    invoke-virtual {v2}, Ljava/net/URLConnection;->getInputStream()Ljava/io/InputStream;

    move-result-object v5

    invoke-direct {v3, v5}, Ljava/io/BufferedInputStream;-><init>(Ljava/io/InputStream;)V
    :try_end_3
    .catch Ljava/lang/Throwable; {:try_start_3 .. :try_end_3} :catch_1
    .catchall {:try_start_3 .. :try_end_3} :catchall_0

    .line 67
    :try_start_4
    invoke-virtual {v2}, Ljava/net/URLConnection;->getExpiration()J

    move-result-wide v8

    .line 68
    invoke-static {}, Ljava/lang/System;->currentTimeMillis()J

    move-result-wide v4

    cmp-long v4, v8, v4

    if-gez v4, :cond_5

    invoke-static {}, Ljava/lang/System;->currentTimeMillis()J

    move-result-wide v4

    invoke-virtual/range {p0 .. p0}, Lcom/lidroid/xutils/bitmap/download/DefaultDownloader;->getDefaultExpiry()J

    move-result-wide v8

    add-long/2addr v8, v4

    .line 69
    :cond_5
    invoke-virtual {v2}, Ljava/net/URLConnection;->getContentLength()I
    :try_end_4
    .catch Ljava/lang/Throwable; {:try_start_4 .. :try_end_4} :catch_3
    .catchall {:try_start_4 .. :try_end_4} :catchall_2

    move-result v2

    int-to-long v4, v2

    move-wide v14, v4

    move-object v4, v3

    move-wide v2, v8

    move-wide v8, v14

    goto/16 :goto_1

    .line 74
    :cond_6
    const/16 v5, 0x1000

    :try_start_5
    new-array v5, v5, [B

    .line 76
    new-instance v10, Ljava/io/BufferedOutputStream;

    move-object/from16 v0, p2

    invoke-direct {v10, v0}, Ljava/io/BufferedOutputStream;-><init>(Ljava/io/OutputStream;)V

    .line 77
    :goto_2
    invoke-virtual {v4, v5}, Ljava/io/BufferedInputStream;->read([B)I

    move-result v11

    const/4 v12, -0x1

    if-ne v11, v12, :cond_7

    .line 83
    invoke-virtual {v10}, Ljava/io/BufferedOutputStream;->flush()V
    :try_end_5
    .catch Ljava/lang/Throwable; {:try_start_5 .. :try_end_5} :catch_0
    .catchall {:try_start_5 .. :try_end_5} :catchall_0

    .line 88
    invoke-static {v4}, Lcom/lidroid/xutils/util/IOUtils;->closeQuietly(Ljava/io/Closeable;)V

    goto/16 :goto_0

    .line 78
    :cond_7
    const/4 v12, 0x0

    :try_start_6
    invoke-virtual {v10, v5, v12, v11}, Ljava/io/BufferedOutputStream;->write([BII)V

    .line 79
    int-to-long v12, v11

    add-long/2addr v6, v12

    .line 80
    invoke-virtual/range {p3 .. p3}, Lcom/lidroid/xutils/BitmapUtils$BitmapLoadTask;->isCancelled()Z

    move-result v11

    if-nez v11, :cond_8

    invoke-virtual/range {p3 .. p3}, Lcom/lidroid/xutils/BitmapUtils$BitmapLoadTask;->getTargetContainer()Landroid/view/View;
    :try_end_6
    .catch Ljava/lang/Throwable; {:try_start_6 .. :try_end_6} :catch_0
    .catchall {:try_start_6 .. :try_end_6} :catchall_0

    move-result-object v11

    if-nez v11, :cond_9

    .line 88
    :cond_8
    invoke-static {v4}, Lcom/lidroid/xutils/util/IOUtils;->closeQuietly(Ljava/io/Closeable;)V

    .line 80
    const-wide/16 v2, -0x1

    goto/16 :goto_0

    .line 81
    :cond_9
    :try_start_7
    move-object/from16 v0, p3

    invoke-virtual {v0, v8, v9, v6, v7}, Lcom/lidroid/xutils/BitmapUtils$BitmapLoadTask;->updateProgress(JJ)V
    :try_end_7
    .catch Ljava/lang/Throwable; {:try_start_7 .. :try_end_7} :catch_0
    .catchall {:try_start_7 .. :try_end_7} :catchall_0

    goto :goto_2

    .line 84
    :catch_0
    move-exception v2

    move-object v5, v4

    move-object v4, v2

    .line 85
    :goto_3
    const-wide/16 v2, -0x1

    .line 86
    :try_start_8
    invoke-virtual {v4}, Ljava/lang/Throwable;->getMessage()Ljava/lang/String;

    move-result-object v6

    invoke-static {v6, v4}, Lcom/lidroid/xutils/util/LogUtils;->e(Ljava/lang/String;Ljava/lang/Throwable;)V
    :try_end_8
    .catchall {:try_start_8 .. :try_end_8} :catchall_3

    .line 88
    invoke-static {v5}, Lcom/lidroid/xutils/util/IOUtils;->closeQuietly(Ljava/io/Closeable;)V

    goto/16 :goto_0

    .line 87
    :catchall_0
    move-exception v2

    .line 88
    :goto_4
    invoke-static {v4}, Lcom/lidroid/xutils/util/IOUtils;->closeQuietly(Ljava/io/Closeable;)V

    .line 89
    throw v2

    .line 87
    :catchall_1
    move-exception v2

    move-object v4, v3

    goto :goto_4

    :catchall_2
    move-exception v2

    move-object v4, v3

    goto :goto_4

    :catchall_3
    move-exception v2

    move-object v4, v5

    goto :goto_4

    .line 84
    :catch_1
    move-exception v2

    move-object v5, v4

    move-object v4, v2

    goto :goto_3

    :catch_2
    move-exception v2

    move-object v4, v2

    move-object v5, v3

    goto :goto_3

    :catch_3
    move-exception v2

    move-object v4, v2

    move-object v5, v3

    goto :goto_3
.end method
