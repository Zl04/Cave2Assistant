.class public Lcom/lidroid/xutils/http/callback/FileDownloadHandler;
.super Ljava/lang/Object;
.source "SourceFile"


# direct methods
.method public constructor <init>()V
    .locals 0

    .prologue
    .line 24
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method


# virtual methods
.method public handleEntity(Lorg/apache/http/HttpEntity;Lcom/lidroid/xutils/http/callback/RequestCallBackHandler;Ljava/lang/String;ZLjava/lang/String;)Ljava/io/File;
    .locals 14
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljava/io/IOException;
        }
    .end annotation

    .prologue
    .line 31
    if-eqz p1, :cond_0

    invoke-static/range {p3 .. p3}, Landroid/text/TextUtils;->isEmpty(Ljava/lang/CharSequence;)Z

    move-result v2

    if-eqz v2, :cond_2

    .line 32
    :cond_0
    const/4 v9, 0x0

    .line 90
    :cond_1
    :goto_0
    return-object v9

    .line 35
    :cond_2
    new-instance v9, Ljava/io/File;

    move-object/from16 v0, p3

    invoke-direct {v9, v0}, Ljava/io/File;-><init>(Ljava/lang/String;)V

    .line 37
    invoke-virtual {v9}, Ljava/io/File;->exists()Z

    move-result v2

    if-nez v2, :cond_4

    .line 38
    invoke-virtual {v9}, Ljava/io/File;->getParentFile()Ljava/io/File;

    move-result-object v2

    .line 39
    invoke-virtual {v2}, Ljava/io/File;->exists()Z

    move-result v3

    if-nez v3, :cond_3

    invoke-virtual {v2}, Ljava/io/File;->mkdirs()Z

    move-result v2

    if-eqz v2, :cond_4

    .line 40
    :cond_3
    invoke-virtual {v9}, Ljava/io/File;->createNewFile()Z

    .line 44
    :cond_4
    const-wide/16 v6, 0x0

    .line 45
    const/4 v8, 0x0

    .line 46
    const/4 v3, 0x0

    .line 49
    if-eqz p4, :cond_5

    .line 50
    :try_start_0
    invoke-virtual {v9}, Ljava/io/File;->length()J

    move-result-wide v6

    .line 51
    new-instance v2, Ljava/io/FileOutputStream;

    const/4 v4, 0x1

    move-object/from16 v0, p3

    invoke-direct {v2, v0, v4}, Ljava/io/FileOutputStream;-><init>(Ljava/lang/String;Z)V

    .line 55
    :goto_1
    invoke-interface {p1}, Lorg/apache/http/HttpEntity;->getContentLength()J

    move-result-wide v4

    add-long/2addr v4, v6

    .line 56
    new-instance v11, Ljava/io/BufferedInputStream;

    invoke-interface {p1}, Lorg/apache/http/HttpEntity;->getContent()Ljava/io/InputStream;

    move-result-object v10

    invoke-direct {v11, v10}, Ljava/io/BufferedInputStream;-><init>(Ljava/io/InputStream;)V
    :try_end_0
    .catchall {:try_start_0 .. :try_end_0} :catchall_0

    .line 57
    :try_start_1
    new-instance v10, Ljava/io/BufferedOutputStream;

    invoke-direct {v10, v2}, Ljava/io/BufferedOutputStream;-><init>(Ljava/io/OutputStream;)V
    :try_end_1
    .catchall {:try_start_1 .. :try_end_1} :catchall_1

    .line 59
    if-eqz p2, :cond_6

    const/4 v8, 0x1

    move-object/from16 v3, p2

    :try_start_2
    invoke-interface/range {v3 .. v8}, Lcom/lidroid/xutils/http/callback/RequestCallBackHandler;->updateProgress(JJZ)Z
    :try_end_2
    .catchall {:try_start_2 .. :try_end_2} :catchall_2

    move-result v2

    if-nez v2, :cond_6

    .line 79
    invoke-static {v11}, Lcom/lidroid/xutils/util/IOUtils;->closeQuietly(Ljava/io/Closeable;)V

    .line 80
    invoke-static {v10}, Lcom/lidroid/xutils/util/IOUtils;->closeQuietly(Ljava/io/Closeable;)V

    goto :goto_0

    .line 53
    :cond_5
    :try_start_3
    new-instance v2, Ljava/io/FileOutputStream;

    move-object/from16 v0, p3

    invoke-direct {v2, v0}, Ljava/io/FileOutputStream;-><init>(Ljava/lang/String;)V
    :try_end_3
    .catchall {:try_start_3 .. :try_end_3} :catchall_0

    goto :goto_1

    .line 78
    :catchall_0
    move-exception v2

    move-object v4, v8

    .line 79
    :goto_2
    invoke-static {v4}, Lcom/lidroid/xutils/util/IOUtils;->closeQuietly(Ljava/io/Closeable;)V

    .line 80
    invoke-static {v3}, Lcom/lidroid/xutils/util/IOUtils;->closeQuietly(Ljava/io/Closeable;)V

    .line 81
    throw v2

    .line 63
    :cond_6
    const/16 v2, 0x1000

    :try_start_4
    new-array v2, v2, [B

    .line 65
    :cond_7
    invoke-virtual {v11, v2}, Ljava/io/BufferedInputStream;->read([B)I

    move-result v3

    const/4 v8, -0x1

    if-ne v3, v8, :cond_9

    .line 74
    invoke-virtual {v10}, Ljava/io/BufferedOutputStream;->flush()V

    .line 75
    if-eqz p2, :cond_8

    .line 76
    const/4 v8, 0x1

    move-object/from16 v3, p2

    invoke-interface/range {v3 .. v8}, Lcom/lidroid/xutils/http/callback/RequestCallBackHandler;->updateProgress(JJZ)Z
    :try_end_4
    .catchall {:try_start_4 .. :try_end_4} :catchall_2

    .line 79
    :cond_8
    invoke-static {v11}, Lcom/lidroid/xutils/util/IOUtils;->closeQuietly(Ljava/io/Closeable;)V

    .line 80
    invoke-static {v10}, Lcom/lidroid/xutils/util/IOUtils;->closeQuietly(Ljava/io/Closeable;)V

    .line 83
    invoke-virtual {v9}, Ljava/io/File;->exists()Z

    move-result v2

    if-eqz v2, :cond_1

    invoke-static/range {p5 .. p5}, Landroid/text/TextUtils;->isEmpty(Ljava/lang/CharSequence;)Z

    move-result v2

    if-nez v2, :cond_1

    .line 84
    new-instance v2, Ljava/io/File;

    invoke-virtual {v9}, Ljava/io/File;->getParent()Ljava/lang/String;

    move-result-object v3

    move-object/from16 v0, p5

    invoke-direct {v2, v3, v0}, Ljava/io/File;-><init>(Ljava/lang/String;Ljava/lang/String;)V

    .line 85
    :goto_3
    invoke-virtual {v2}, Ljava/io/File;->exists()Z

    move-result v3

    if-nez v3, :cond_a

    .line 88
    invoke-virtual {v9, v2}, Ljava/io/File;->renameTo(Ljava/io/File;)Z

    move-result v3

    if-eqz v3, :cond_b

    :goto_4
    move-object v9, v2

    goto/16 :goto_0

    .line 66
    :cond_9
    const/4 v8, 0x0

    :try_start_5
    invoke-virtual {v10, v2, v8, v3}, Ljava/io/BufferedOutputStream;->write([BII)V

    .line 67
    int-to-long v12, v3

    add-long/2addr v6, v12

    .line 68
    if-eqz p2, :cond_7

    .line 69
    const/4 v8, 0x0

    move-object/from16 v3, p2

    invoke-interface/range {v3 .. v8}, Lcom/lidroid/xutils/http/callback/RequestCallBackHandler;->updateProgress(JJZ)Z
    :try_end_5
    .catchall {:try_start_5 .. :try_end_5} :catchall_2

    move-result v3

    if-nez v3, :cond_7

    .line 79
    invoke-static {v11}, Lcom/lidroid/xutils/util/IOUtils;->closeQuietly(Ljava/io/Closeable;)V

    .line 80
    invoke-static {v10}, Lcom/lidroid/xutils/util/IOUtils;->closeQuietly(Ljava/io/Closeable;)V

    goto/16 :goto_0

    .line 86
    :cond_a
    new-instance v2, Ljava/io/File;

    invoke-virtual {v9}, Ljava/io/File;->getParent()Ljava/lang/String;

    move-result-object v3

    new-instance v4, Ljava/lang/StringBuilder;

    invoke-static {}, Ljava/lang/System;->currentTimeMillis()J

    move-result-wide v6

    invoke-static {v6, v7}, Ljava/lang/String;->valueOf(J)Ljava/lang/String;

    move-result-object v5

    invoke-direct {v4, v5}, Ljava/lang/StringBuilder;-><init>(Ljava/lang/String;)V

    move-object/from16 v0, p5

    invoke-virtual {v4, v0}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v4

    invoke-virtual {v4}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v4

    invoke-direct {v2, v3, v4}, Ljava/io/File;-><init>(Ljava/lang/String;Ljava/lang/String;)V

    goto :goto_3

    :cond_b
    move-object v2, v9

    .line 88
    goto :goto_4

    .line 78
    :catchall_1
    move-exception v2

    move-object v4, v11

    goto/16 :goto_2

    :catchall_2
    move-exception v2

    move-object v3, v10

    move-object v4, v11

    goto/16 :goto_2
.end method
