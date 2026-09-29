.class public abstract Lcom/kaopu/download/abst/ADownloadWorker;
.super Ljava/lang/Object;
.source "ADownloadWorker.java"

# interfaces
.implements Ljava/lang/Runnable;


# annotations
.annotation system Ldalvik/annotation/Signature;
    value = {
        "<T:",
        "Lcom/kaopu/download/kernel/BaseDownloadInfo;",
        ">",
        "Ljava/lang/Object;",
        "Ljava/lang/Runnable;"
    }
.end annotation


# static fields
.field public static final POSTFIX_FILE_NAME:Ljava/lang/String; = ".temp"


# instance fields
.field private final identification:Ljava/lang/String;

.field protected final mDownloadInfo:Lcom/kaopu/download/kernel/BaseDownloadInfo;
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "TT;"
        }
    .end annotation
.end field

.field private progress:I

.field private requestType:I

.field private volatile running:Z

.field private saveDir:Ljava/lang/String;

.field private saveFile:Ljava/lang/String;

.field private saveName:Ljava/lang/String;

.field private totalSize:J

.field private url:Ljava/lang/String;


# direct methods
.method public constructor <init>(Lcom/kaopu/download/kernel/BaseDownloadInfo;)V
    .locals 1
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "(TT;)V"
        }
    .end annotation

    .prologue
    .line 84
    .local p0, "this":Lcom/kaopu/download/abst/ADownloadWorker;, "Lcom/kaopu/download/abst/ADownloadWorker<TT;>;"
    .local p1, "info":Lcom/kaopu/download/kernel/BaseDownloadInfo;, "TT;"
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    .line 69
    const/4 v0, 0x3

    iput v0, p0, Lcom/kaopu/download/abst/ADownloadWorker;->requestType:I

    .line 71
    const/4 v0, 0x0

    iput-boolean v0, p0, Lcom/kaopu/download/abst/ADownloadWorker;->running:Z

    .line 85
    invoke-virtual {p1}, Lcom/kaopu/download/kernel/BaseDownloadInfo;->getUrl()Ljava/lang/String;

    move-result-object v0

    invoke-static {v0}, Lcom/kaopu/download/util/DownloadHttpUtil;->utf8URLencode(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v0

    iput-object v0, p0, Lcom/kaopu/download/abst/ADownloadWorker;->url:Ljava/lang/String;

    .line 86
    invoke-virtual {p1}, Lcom/kaopu/download/kernel/BaseDownloadInfo;->getSaveDir()Ljava/lang/String;

    move-result-object v0

    iput-object v0, p0, Lcom/kaopu/download/abst/ADownloadWorker;->saveDir:Ljava/lang/String;

    .line 87
    invoke-virtual {p1}, Lcom/kaopu/download/kernel/BaseDownloadInfo;->getSaveName()Ljava/lang/String;

    move-result-object v0

    iput-object v0, p0, Lcom/kaopu/download/abst/ADownloadWorker;->saveName:Ljava/lang/String;

    .line 88
    invoke-virtual {p1}, Lcom/kaopu/download/kernel/BaseDownloadInfo;->getIdentification()Ljava/lang/String;

    move-result-object v0

    iput-object v0, p0, Lcom/kaopu/download/abst/ADownloadWorker;->identification:Ljava/lang/String;

    .line 89
    iput-object p1, p0, Lcom/kaopu/download/abst/ADownloadWorker;->mDownloadInfo:Lcom/kaopu/download/kernel/BaseDownloadInfo;

    .line 90
    iget-object v0, p0, Lcom/kaopu/download/abst/ADownloadWorker;->saveDir:Ljava/lang/String;

    invoke-virtual {p0, v0}, Lcom/kaopu/download/abst/ADownloadWorker;->maybeInitDir(Ljava/lang/String;)V

    .line 91
    return-void
.end method

.method private download()V
    .locals 30

    .prologue
    .line 107
    .local p0, "this":Lcom/kaopu/download/abst/ADownloadWorker;, "Lcom/kaopu/download/abst/ADownloadWorker<TT;>;"
    const/4 v2, 0x1

    move-object/from16 v0, p0

    iput-boolean v2, v0, Lcom/kaopu/download/abst/ADownloadWorker;->running:Z

    .line 108
    const/16 v20, 0x0

    .line 109
    .local v20, "retryCount":I
    const/16 v22, 0x1

    .line 110
    .local v22, "shouldConn":Z
    sget v2, Lcom/kaopu/download/util/DownloadHttpUtil;->BUFFER_SIZE:I

    new-array v11, v2, [B

    .line 111
    .local v11, "buf":[B
    const/16 v23, 0x0

    .line 113
    .local v23, "size":I
    const-wide/16 v2, 0x0

    move-object/from16 v0, p0

    iput-wide v2, v0, Lcom/kaopu/download/abst/ADownloadWorker;->totalSize:J

    .line 114
    const/4 v14, 0x0

    .line 117
    .local v14, "file":Ljava/io/File;
    const/4 v9, 0x0

    .line 119
    .local v9, "accessFile":Ljava/io/RandomAccessFile;
    const/16 v17, 0x0

    .line 120
    .local v17, "in":Ljava/io/InputStream;
    const/16 v16, 0x0

    .line 122
    .local v16, "httpConn":Ljava/net/HttpURLConnection;
    move-object/from16 v0, p0

    iget-object v2, v0, Lcom/kaopu/download/abst/ADownloadWorker;->saveFile:Ljava/lang/String;

    if-eqz v2, :cond_1

    .line 124
    new-instance v2, Ljava/lang/StringBuilder;

    move-object/from16 v0, p0

    iget-object v3, v0, Lcom/kaopu/download/abst/ADownloadWorker;->saveFile:Ljava/lang/String;

    invoke-static {v3}, Ljava/lang/String;->valueOf(Ljava/lang/Object;)Ljava/lang/String;

    move-result-object v3

    invoke-direct {v2, v3}, Ljava/lang/StringBuilder;-><init>(Ljava/lang/String;)V

    const-string v3, ".temp"

    invoke-virtual {v2, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    invoke-virtual {v2}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v24

    .line 132
    .local v24, "tempFile":Ljava/lang/String;
    :try_start_0
    new-instance v15, Ljava/io/File;

    move-object/from16 v0, p0

    iget-object v2, v0, Lcom/kaopu/download/abst/ADownloadWorker;->saveFile:Ljava/lang/String;

    invoke-direct {v15, v2}, Ljava/io/File;-><init>(Ljava/lang/String;)V
    :try_end_0
    .catch Ljava/lang/Exception; {:try_start_0 .. :try_end_0} :catch_0

    .line 133
    .end local v14    # "file":Ljava/io/File;
    .local v15, "file":Ljava/io/File;
    :try_start_1
    invoke-virtual {v15}, Ljava/io/File;->exists()Z

    move-result v2

    if-eqz v2, :cond_2

    .line 134
    move-object/from16 v0, p0

    iget-object v2, v0, Lcom/kaopu/download/abst/ADownloadWorker;->identification:Ljava/lang/String;

    move-object/from16 v0, p0

    iget-object v3, v0, Lcom/kaopu/download/abst/ADownloadWorker;->saveFile:Ljava/lang/String;

    invoke-virtual {v15}, Ljava/io/File;->length()J

    move-result-wide v4

    move-object/from16 v0, p0

    invoke-virtual {v0, v2, v3, v4, v5}, Lcom/kaopu/download/abst/ADownloadWorker;->onDownloadCompleted(Ljava/lang/String;Ljava/lang/String;J)V
    :try_end_1
    .catch Ljava/lang/Exception; {:try_start_1 .. :try_end_1} :catch_a

    move-object v14, v15

    .line 256
    .end local v15    # "file":Ljava/io/File;
    .end local v24    # "tempFile":Ljava/lang/String;
    .restart local v14    # "file":Ljava/io/File;
    :cond_0
    :goto_0
    return-void

    .line 127
    :cond_1
    move-object/from16 v0, p0

    iget-object v2, v0, Lcom/kaopu/download/abst/ADownloadWorker;->identification:Ljava/lang/String;

    move-object/from16 v0, p0

    invoke-virtual {v0, v2}, Lcom/kaopu/download/abst/ADownloadWorker;->onDownloadFailed(Ljava/lang/String;)V

    goto :goto_0

    .line 137
    .end local v14    # "file":Ljava/io/File;
    .restart local v15    # "file":Ljava/io/File;
    .restart local v24    # "tempFile":Ljava/lang/String;
    :cond_2
    :try_start_2
    new-instance v14, Ljava/io/File;

    move-object/from16 v0, v24

    invoke-direct {v14, v0}, Ljava/io/File;-><init>(Ljava/lang/String;)V
    :try_end_2
    .catch Ljava/lang/Exception; {:try_start_2 .. :try_end_2} :catch_a

    .line 138
    .end local v15    # "file":Ljava/io/File;
    .restart local v14    # "file":Ljava/io/File;
    :try_start_3
    invoke-virtual {v14}, Ljava/io/File;->exists()Z

    move-result v2

    if-nez v2, :cond_3

    .line 139
    invoke-virtual {v14}, Ljava/io/File;->createNewFile()Z

    .line 142
    :cond_3
    new-instance v10, Ljava/io/RandomAccessFile;

    const-string v2, "rw"

    move-object/from16 v0, v24

    invoke-direct {v10, v0, v2}, Ljava/io/RandomAccessFile;-><init>(Ljava/lang/String;Ljava/lang/String;)V
    :try_end_3
    .catch Ljava/lang/Exception; {:try_start_3 .. :try_end_3} :catch_0

    .line 143
    .end local v9    # "accessFile":Ljava/io/RandomAccessFile;
    .local v10, "accessFile":Ljava/io/RandomAccessFile;
    :try_start_4
    invoke-virtual {v14}, Ljava/io/File;->length()J

    move-result-wide v6

    .line 144
    .local v6, "currentSize":J
    move-object/from16 v0, p0

    iget-object v2, v0, Lcom/kaopu/download/abst/ADownloadWorker;->identification:Ljava/lang/String;

    move-object/from16 v0, p0

    invoke-virtual {v0, v2, v6, v7}, Lcom/kaopu/download/abst/ADownloadWorker;->onDownloadConnecting(Ljava/lang/String;J)V
    :try_end_4
    .catch Ljava/lang/Exception; {:try_start_4 .. :try_end_4} :catch_b

    .line 165
    :goto_1
    if-eqz v22, :cond_4

    const/4 v2, 0x3

    move/from16 v0, v20

    if-lt v0, v2, :cond_5

    :cond_4
    :goto_2
    move-object v9, v10

    .line 256
    .end local v10    # "accessFile":Ljava/io/RandomAccessFile;
    .restart local v9    # "accessFile":Ljava/io/RandomAccessFile;
    goto :goto_0

    .line 145
    .end local v6    # "currentSize":J
    :catch_0
    move-exception v13

    .line 146
    .local v13, "ex":Ljava/lang/Exception;
    :goto_3
    invoke-virtual {v13}, Ljava/lang/Exception;->printStackTrace()V

    .line 147
    move-object/from16 v0, p0

    iget-object v2, v0, Lcom/kaopu/download/abst/ADownloadWorker;->identification:Ljava/lang/String;

    move-object/from16 v0, p0

    invoke-virtual {v0, v2}, Lcom/kaopu/download/abst/ADownloadWorker;->onDownloadFailed(Ljava/lang/String;)V

    .line 149
    if-eqz v9, :cond_0

    .line 150
    :try_start_5
    invoke-virtual {v9}, Ljava/io/RandomAccessFile;->close()V
    :try_end_5
    .catch Ljava/lang/Exception; {:try_start_5 .. :try_end_5} :catch_1

    goto :goto_0

    .line 152
    :catch_1
    move-exception v25

    .line 153
    .local v25, "x":Ljava/lang/Exception;
    invoke-virtual/range {v25 .. v25}, Ljava/lang/Exception;->printStackTrace()V

    goto :goto_0

    .line 166
    .end local v9    # "accessFile":Ljava/io/RandomAccessFile;
    .end local v13    # "ex":Ljava/lang/Exception;
    .end local v25    # "x":Ljava/lang/Exception;
    .restart local v6    # "currentSize":J
    .restart local v10    # "accessFile":Ljava/io/RandomAccessFile;
    :cond_5
    move-object/from16 v0, p0

    iget-boolean v2, v0, Lcom/kaopu/download/abst/ADownloadWorker;->running:Z

    if-eqz v2, :cond_6

    invoke-static {}, Ljava/lang/Thread;->interrupted()Z

    move-result v2

    if-eqz v2, :cond_a

    .line 167
    :cond_6
    move-object/from16 v0, p0

    iget v2, v0, Lcom/kaopu/download/abst/ADownloadWorker;->requestType:I

    const/4 v3, 0x1

    if-ne v2, v3, :cond_8

    .line 168
    move-object/from16 v0, p0

    iget-object v2, v0, Lcom/kaopu/download/abst/ADownloadWorker;->identification:Ljava/lang/String;

    move-object/from16 v0, p0

    invoke-virtual {v0, v2}, Lcom/kaopu/download/abst/ADownloadWorker;->onDownloadPaused(Ljava/lang/String;)V

    :cond_7
    :goto_4
    move-object v9, v10

    .line 175
    .end local v10    # "accessFile":Ljava/io/RandomAccessFile;
    .restart local v9    # "accessFile":Ljava/io/RandomAccessFile;
    goto :goto_0

    .line 169
    .end local v9    # "accessFile":Ljava/io/RandomAccessFile;
    .restart local v10    # "accessFile":Ljava/io/RandomAccessFile;
    :cond_8
    move-object/from16 v0, p0

    iget v2, v0, Lcom/kaopu/download/abst/ADownloadWorker;->requestType:I

    const/4 v3, 0x2

    if-ne v2, v3, :cond_7

    .line 170
    invoke-virtual {v14}, Ljava/io/File;->exists()Z

    move-result v2

    if-eqz v2, :cond_9

    .line 171
    invoke-virtual {v14}, Ljava/io/File;->delete()Z

    .line 172
    :cond_9
    move-object/from16 v0, p0

    iget-object v2, v0, Lcom/kaopu/download/abst/ADownloadWorker;->identification:Ljava/lang/String;

    move-object/from16 v0, p0

    invoke-virtual {v0, v2}, Lcom/kaopu/download/abst/ADownloadWorker;->onDownloadCanceled(Ljava/lang/String;)V

    goto :goto_4

    .line 178
    :cond_a
    :try_start_6
    move-object/from16 v0, p0

    iget-object v2, v0, Lcom/kaopu/download/abst/ADownloadWorker;->url:Ljava/lang/String;

    move-object/from16 v0, p0

    invoke-direct {v0, v2}, Lcom/kaopu/download/abst/ADownloadWorker;->getConnection(Ljava/lang/String;)Ljava/net/HttpURLConnection;

    move-result-object v16

    .line 179
    new-instance v2, Ljava/lang/StringBuilder;

    const-string v3, "bytes="

    invoke-direct {v2, v3}, Ljava/lang/StringBuilder;-><init>(Ljava/lang/String;)V

    invoke-virtual {v2, v6, v7}, Ljava/lang/StringBuilder;->append(J)Ljava/lang/StringBuilder;

    move-result-object v2

    const-string v3, "-"

    invoke-virtual {v2, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    invoke-virtual {v2}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v21

    .line 181
    .local v21, "sProperty":Ljava/lang/String;
    const-string v2, "Range"

    move-object/from16 v0, v16

    move-object/from16 v1, v21

    invoke-virtual {v0, v2, v1}, Ljava/net/HttpURLConnection;->setRequestProperty(Ljava/lang/String;Ljava/lang/String;)V

    .line 182
    invoke-virtual/range {v16 .. v16}, Ljava/net/HttpURLConnection;->connect()V

    .line 183
    invoke-virtual/range {v16 .. v16}, Ljava/net/HttpURLConnection;->getContentLength()I

    move-result v2

    int-to-long v2, v2

    move-object/from16 v0, p0

    iput-wide v2, v0, Lcom/kaopu/download/abst/ADownloadWorker;->totalSize:J

    .line 185
    move-object/from16 v0, p0

    iget-wide v2, v0, Lcom/kaopu/download/abst/ADownloadWorker;->totalSize:J

    const-wide/16 v4, -0x1

    cmp-long v2, v2, v4

    if-nez v2, :cond_e

    .line 186
    move-object/from16 v0, p0

    iget-object v2, v0, Lcom/kaopu/download/abst/ADownloadWorker;->identification:Ljava/lang/String;

    move-object/from16 v0, p0

    invoke-virtual {v0, v2}, Lcom/kaopu/download/abst/ADownloadWorker;->onDownloadFailed(Ljava/lang/String;)V
    :try_end_6
    .catch Ljava/lang/Exception; {:try_start_6 .. :try_end_6} :catch_4
    .catchall {:try_start_6 .. :try_end_6} :catchall_0

    .line 241
    if-eqz v17, :cond_b

    .line 242
    :try_start_7
    invoke-virtual/range {v17 .. v17}, Ljava/io/InputStream;->close()V

    .line 244
    :cond_b
    if-eqz v16, :cond_c

    .line 245
    invoke-virtual/range {v16 .. v16}, Ljava/net/HttpURLConnection;->disconnect()V

    .line 246
    :cond_c
    if-eqz v10, :cond_d

    .line 247
    invoke-virtual {v10}, Ljava/io/RandomAccessFile;->close()V
    :try_end_7
    .catch Ljava/io/IOException; {:try_start_7 .. :try_end_7} :catch_2

    :cond_d
    :goto_5
    move-object v9, v10

    .line 187
    .end local v10    # "accessFile":Ljava/io/RandomAccessFile;
    .restart local v9    # "accessFile":Ljava/io/RandomAccessFile;
    goto/16 :goto_0

    .line 249
    .end local v9    # "accessFile":Ljava/io/RandomAccessFile;
    .restart local v10    # "accessFile":Ljava/io/RandomAccessFile;
    :catch_2
    move-exception v12

    .line 250
    .local v12, "e":Ljava/io/IOException;
    invoke-virtual {v12}, Ljava/io/IOException;->printStackTrace()V

    goto :goto_5

    .line 190
    .end local v12    # "e":Ljava/io/IOException;
    :cond_e
    :try_start_8
    move-object/from16 v0, p0

    iget-wide v2, v0, Lcom/kaopu/download/abst/ADownloadWorker;->totalSize:J

    cmp-long v2, v2, v6

    if-nez v2, :cond_11

    .line 191
    move-object/from16 v0, p0

    iget-object v2, v0, Lcom/kaopu/download/abst/ADownloadWorker;->identification:Ljava/lang/String;

    move-object/from16 v0, p0

    iget-object v3, v0, Lcom/kaopu/download/abst/ADownloadWorker;->saveFile:Ljava/lang/String;

    move-object/from16 v0, p0

    iget-wide v4, v0, Lcom/kaopu/download/abst/ADownloadWorker;->totalSize:J

    move-object/from16 v0, p0

    invoke-virtual {v0, v2, v3, v4, v5}, Lcom/kaopu/download/abst/ADownloadWorker;->onDownloadCompleted(Ljava/lang/String;Ljava/lang/String;J)V
    :try_end_8
    .catch Ljava/lang/Exception; {:try_start_8 .. :try_end_8} :catch_4
    .catchall {:try_start_8 .. :try_end_8} :catchall_0

    .line 241
    if-eqz v17, :cond_f

    .line 242
    :try_start_9
    invoke-virtual/range {v17 .. v17}, Ljava/io/InputStream;->close()V

    .line 244
    :cond_f
    if-eqz v16, :cond_10

    .line 245
    invoke-virtual/range {v16 .. v16}, Ljava/net/HttpURLConnection;->disconnect()V

    .line 246
    :cond_10
    if-eqz v10, :cond_4

    .line 247
    invoke-virtual {v10}, Ljava/io/RandomAccessFile;->close()V
    :try_end_9
    .catch Ljava/io/IOException; {:try_start_9 .. :try_end_9} :catch_3

    goto/16 :goto_2

    .line 249
    :catch_3
    move-exception v12

    .line 250
    .restart local v12    # "e":Ljava/io/IOException;
    invoke-virtual {v12}, Ljava/io/IOException;->printStackTrace()V

    goto/16 :goto_2

    .line 194
    .end local v12    # "e":Ljava/io/IOException;
    :cond_11
    :try_start_a
    move-object/from16 v0, p0

    iget-wide v2, v0, Lcom/kaopu/download/abst/ADownloadWorker;->totalSize:J

    add-long/2addr v2, v6

    move-object/from16 v0, p0

    iput-wide v2, v0, Lcom/kaopu/download/abst/ADownloadWorker;->totalSize:J

    .line 199
    move-object/from16 v0, p0

    iget-object v3, v0, Lcom/kaopu/download/abst/ADownloadWorker;->identification:Ljava/lang/String;

    move-object/from16 v0, p0

    iget-wide v4, v0, Lcom/kaopu/download/abst/ADownloadWorker;->totalSize:J

    const-wide/16 v26, 0x64

    mul-long v26, v26, v6

    move-object/from16 v0, p0

    iget-wide v0, v0, Lcom/kaopu/download/abst/ADownloadWorker;->totalSize:J

    move-wide/from16 v28, v0

    div-long v26, v26, v28

    move-wide/from16 v0, v26

    long-to-int v8, v0

    move-object/from16 v2, p0

    invoke-virtual/range {v2 .. v8}, Lcom/kaopu/download/abst/ADownloadWorker;->onDownloadWorking(Ljava/lang/String;JJI)V

    .line 200
    invoke-virtual {v10, v6, v7}, Ljava/io/RandomAccessFile;->seek(J)V

    .line 201
    invoke-virtual/range {v16 .. v16}, Ljava/net/HttpURLConnection;->getInputStream()Ljava/io/InputStream;

    move-result-object v17

    .line 203
    invoke-static {}, Ljava/lang/System;->currentTimeMillis()J

    move-result-wide v18

    .line 204
    .local v18, "lastTime":J
    :cond_12
    :goto_6
    move-object/from16 v0, v17

    invoke-virtual {v0, v11}, Ljava/io/InputStream;->read([B)I

    move-result v23

    const/4 v2, -0x1

    move/from16 v0, v23

    if-ne v0, v2, :cond_16

    .line 223
    move-object/from16 v0, p0

    iget-object v2, v0, Lcom/kaopu/download/abst/ADownloadWorker;->saveFile:Ljava/lang/String;

    move-object/from16 v0, p0

    invoke-direct {v0, v14, v2}, Lcom/kaopu/download/abst/ADownloadWorker;->renameFile(Ljava/io/File;Ljava/lang/String;)V

    .line 224
    move-object/from16 v0, p0

    iget-object v2, v0, Lcom/kaopu/download/abst/ADownloadWorker;->identification:Ljava/lang/String;

    move-object/from16 v0, p0

    iget-object v3, v0, Lcom/kaopu/download/abst/ADownloadWorker;->saveFile:Ljava/lang/String;

    move-object/from16 v0, p0

    iget-wide v4, v0, Lcom/kaopu/download/abst/ADownloadWorker;->totalSize:J

    move-object/from16 v0, p0

    invoke-virtual {v0, v2, v3, v4, v5}, Lcom/kaopu/download/abst/ADownloadWorker;->onDownloadCompleted(Ljava/lang/String;Ljava/lang/String;J)V
    :try_end_a
    .catch Ljava/lang/Exception; {:try_start_a .. :try_end_a} :catch_4
    .catchall {:try_start_a .. :try_end_a} :catchall_0

    .line 225
    const/16 v22, 0x0

    .line 241
    if-eqz v17, :cond_13

    .line 242
    :try_start_b
    invoke-virtual/range {v17 .. v17}, Ljava/io/InputStream;->close()V

    .line 244
    :cond_13
    if-eqz v16, :cond_14

    .line 245
    invoke-virtual/range {v16 .. v16}, Ljava/net/HttpURLConnection;->disconnect()V

    .line 246
    :cond_14
    if-eqz v10, :cond_15

    .line 247
    invoke-virtual {v10}, Ljava/io/RandomAccessFile;->close()V
    :try_end_b
    .catch Ljava/io/IOException; {:try_start_b .. :try_end_b} :catch_9

    .line 253
    .end local v18    # "lastTime":J
    .end local v21    # "sProperty":Ljava/lang/String;
    :cond_15
    :goto_7
    invoke-static {}, Ljava/lang/Thread;->yield()V

    .line 254
    const/4 v2, 0x0

    move-object/from16 v0, p0

    iput-boolean v2, v0, Lcom/kaopu/download/abst/ADownloadWorker;->running:Z

    goto/16 :goto_1

    .line 205
    .restart local v18    # "lastTime":J
    .restart local v21    # "sProperty":Ljava/lang/String;
    :cond_16
    :try_start_c
    move-object/from16 v0, p0

    iget-boolean v2, v0, Lcom/kaopu/download/abst/ADownloadWorker;->running:Z

    if-eqz v2, :cond_17

    invoke-static {}, Ljava/lang/Thread;->interrupted()Z

    move-result v2

    if-eqz v2, :cond_20

    .line 206
    :cond_17
    move-object/from16 v0, p0

    iget v2, v0, Lcom/kaopu/download/abst/ADownloadWorker;->requestType:I

    const/4 v3, 0x1

    if-ne v2, v3, :cond_1c

    .line 207
    move-object/from16 v0, p0

    iget-object v2, v0, Lcom/kaopu/download/abst/ADownloadWorker;->identification:Ljava/lang/String;

    move-object/from16 v0, p0

    invoke-virtual {v0, v2}, Lcom/kaopu/download/abst/ADownloadWorker;->onDownloadPaused(Ljava/lang/String;)V
    :try_end_c
    .catch Ljava/lang/Exception; {:try_start_c .. :try_end_c} :catch_4
    .catchall {:try_start_c .. :try_end_c} :catchall_0

    .line 241
    :cond_18
    :goto_8
    if-eqz v17, :cond_19

    .line 242
    :try_start_d
    invoke-virtual/range {v17 .. v17}, Ljava/io/InputStream;->close()V

    .line 244
    :cond_19
    if-eqz v16, :cond_1a

    .line 245
    invoke-virtual/range {v16 .. v16}, Ljava/net/HttpURLConnection;->disconnect()V

    .line 246
    :cond_1a
    if-eqz v10, :cond_1b

    .line 247
    invoke-virtual {v10}, Ljava/io/RandomAccessFile;->close()V
    :try_end_d
    .catch Ljava/io/IOException; {:try_start_d .. :try_end_d} :catch_6

    :cond_1b
    :goto_9
    move-object v9, v10

    .line 213
    .end local v10    # "accessFile":Ljava/io/RandomAccessFile;
    .restart local v9    # "accessFile":Ljava/io/RandomAccessFile;
    goto/16 :goto_0

    .line 208
    .end local v9    # "accessFile":Ljava/io/RandomAccessFile;
    .restart local v10    # "accessFile":Ljava/io/RandomAccessFile;
    :cond_1c
    :try_start_e
    move-object/from16 v0, p0

    iget v2, v0, Lcom/kaopu/download/abst/ADownloadWorker;->requestType:I

    const/4 v3, 0x2

    if-ne v2, v3, :cond_18

    .line 209
    invoke-virtual {v14}, Ljava/io/File;->exists()Z

    move-result v2

    if-eqz v2, :cond_1d

    .line 210
    invoke-virtual {v14}, Ljava/io/File;->delete()Z

    .line 211
    :cond_1d
    move-object/from16 v0, p0

    iget-object v2, v0, Lcom/kaopu/download/abst/ADownloadWorker;->identification:Ljava/lang/String;

    move-object/from16 v0, p0

    invoke-virtual {v0, v2}, Lcom/kaopu/download/abst/ADownloadWorker;->onDownloadCanceled(Ljava/lang/String;)V
    :try_end_e
    .catch Ljava/lang/Exception; {:try_start_e .. :try_end_e} :catch_4
    .catchall {:try_start_e .. :try_end_e} :catchall_0

    goto :goto_8

    .line 226
    .end local v18    # "lastTime":J
    .end local v21    # "sProperty":Ljava/lang/String;
    :catch_4
    move-exception v13

    .line 227
    .restart local v13    # "ex":Ljava/lang/Exception;
    :try_start_f
    invoke-virtual {v13}, Ljava/lang/Exception;->printStackTrace()V
    :try_end_f
    .catchall {:try_start_f .. :try_end_f} :catchall_0

    .line 228
    const/16 v22, 0x1

    .line 229
    add-int/lit8 v20, v20, 0x1

    .line 231
    const-wide/16 v2, 0x7d0

    :try_start_10
    invoke-static {v2, v3}, Ljava/lang/Thread;->sleep(J)V
    :try_end_10
    .catch Ljava/lang/Exception; {:try_start_10 .. :try_end_10} :catch_7
    .catchall {:try_start_10 .. :try_end_10} :catchall_0

    .line 237
    :goto_a
    :try_start_11
    move-object/from16 v0, p0

    iget-object v2, v0, Lcom/kaopu/download/abst/ADownloadWorker;->identification:Ljava/lang/String;

    move-object/from16 v0, p0

    invoke-virtual {v0, v2}, Lcom/kaopu/download/abst/ADownloadWorker;->onDownloadFailed(Ljava/lang/String;)V
    :try_end_11
    .catchall {:try_start_11 .. :try_end_11} :catchall_0

    .line 241
    if-eqz v17, :cond_1e

    .line 242
    :try_start_12
    invoke-virtual/range {v17 .. v17}, Ljava/io/InputStream;->close()V

    .line 244
    :cond_1e
    if-eqz v16, :cond_1f

    .line 245
    invoke-virtual/range {v16 .. v16}, Ljava/net/HttpURLConnection;->disconnect()V

    .line 246
    :cond_1f
    if-eqz v10, :cond_15

    .line 247
    invoke-virtual {v10}, Ljava/io/RandomAccessFile;->close()V
    :try_end_12
    .catch Ljava/io/IOException; {:try_start_12 .. :try_end_12} :catch_5

    goto :goto_7

    .line 249
    :catch_5
    move-exception v12

    .line 250
    .restart local v12    # "e":Ljava/io/IOException;
    invoke-virtual {v12}, Ljava/io/IOException;->printStackTrace()V

    goto :goto_7

    .line 249
    .end local v12    # "e":Ljava/io/IOException;
    .end local v13    # "ex":Ljava/lang/Exception;
    .restart local v18    # "lastTime":J
    .restart local v21    # "sProperty":Ljava/lang/String;
    :catch_6
    move-exception v12

    .line 250
    .restart local v12    # "e":Ljava/io/IOException;
    invoke-virtual {v12}, Ljava/io/IOException;->printStackTrace()V

    goto :goto_9

    .line 215
    .end local v12    # "e":Ljava/io/IOException;
    :cond_20
    const/4 v2, 0x0

    :try_start_13
    move/from16 v0, v23

    invoke-virtual {v10, v11, v2, v0}, Ljava/io/RandomAccessFile;->write([BII)V

    .line 216
    move/from16 v0, v23

    int-to-long v2, v0

    add-long/2addr v6, v2

    .line 217
    invoke-static {}, Ljava/lang/System;->currentTimeMillis()J

    move-result-wide v2

    sub-long v2, v2, v18

    const-wide/16 v4, 0x3e8

    cmp-long v2, v2, v4

    if-gez v2, :cond_21

    move-object/from16 v0, p0

    iget-wide v2, v0, Lcom/kaopu/download/abst/ADownloadWorker;->totalSize:J

    cmp-long v2, v6, v2

    if-nez v2, :cond_12

    .line 218
    :cond_21
    const-wide/16 v2, 0x64

    mul-long/2addr v2, v6

    move-object/from16 v0, p0

    iget-wide v4, v0, Lcom/kaopu/download/abst/ADownloadWorker;->totalSize:J

    div-long/2addr v2, v4

    long-to-int v2, v2

    move-object/from16 v0, p0

    iput v2, v0, Lcom/kaopu/download/abst/ADownloadWorker;->progress:I

    .line 219
    move-object/from16 v0, p0

    iget-object v3, v0, Lcom/kaopu/download/abst/ADownloadWorker;->identification:Ljava/lang/String;

    move-object/from16 v0, p0

    iget-wide v4, v0, Lcom/kaopu/download/abst/ADownloadWorker;->totalSize:J

    move-object/from16 v0, p0

    iget v8, v0, Lcom/kaopu/download/abst/ADownloadWorker;->progress:I

    move-object/from16 v2, p0

    invoke-virtual/range {v2 .. v8}, Lcom/kaopu/download/abst/ADownloadWorker;->onDownloadWorking(Ljava/lang/String;JJI)V

    .line 220
    invoke-static {}, Ljava/lang/System;->currentTimeMillis()J
    :try_end_13
    .catch Ljava/lang/Exception; {:try_start_13 .. :try_end_13} :catch_4
    .catchall {:try_start_13 .. :try_end_13} :catchall_0

    move-result-wide v18

    goto/16 :goto_6

    .line 233
    .end local v18    # "lastTime":J
    .end local v21    # "sProperty":Ljava/lang/String;
    .restart local v13    # "ex":Ljava/lang/Exception;
    :catch_7
    move-exception v12

    .line 234
    .local v12, "e":Ljava/lang/Exception;
    :try_start_14
    invoke-virtual {v12}, Ljava/lang/Exception;->printStackTrace()V
    :try_end_14
    .catchall {:try_start_14 .. :try_end_14} :catchall_0

    goto :goto_a

    .line 239
    .end local v12    # "e":Ljava/lang/Exception;
    .end local v13    # "ex":Ljava/lang/Exception;
    :catchall_0
    move-exception v2

    .line 241
    if-eqz v17, :cond_22

    .line 242
    :try_start_15
    invoke-virtual/range {v17 .. v17}, Ljava/io/InputStream;->close()V

    .line 244
    :cond_22
    if-eqz v16, :cond_23

    .line 245
    invoke-virtual/range {v16 .. v16}, Ljava/net/HttpURLConnection;->disconnect()V

    .line 246
    :cond_23
    if-eqz v10, :cond_24

    .line 247
    invoke-virtual {v10}, Ljava/io/RandomAccessFile;->close()V
    :try_end_15
    .catch Ljava/io/IOException; {:try_start_15 .. :try_end_15} :catch_8

    .line 252
    :cond_24
    :goto_b
    throw v2

    .line 249
    :catch_8
    move-exception v12

    .line 250
    .local v12, "e":Ljava/io/IOException;
    invoke-virtual {v12}, Ljava/io/IOException;->printStackTrace()V

    goto :goto_b

    .line 249
    .end local v12    # "e":Ljava/io/IOException;
    .restart local v18    # "lastTime":J
    .restart local v21    # "sProperty":Ljava/lang/String;
    :catch_9
    move-exception v12

    .line 250
    .restart local v12    # "e":Ljava/io/IOException;
    invoke-virtual {v12}, Ljava/io/IOException;->printStackTrace()V

    goto/16 :goto_7

    .line 145
    .end local v6    # "currentSize":J
    .end local v10    # "accessFile":Ljava/io/RandomAccessFile;
    .end local v12    # "e":Ljava/io/IOException;
    .end local v14    # "file":Ljava/io/File;
    .end local v18    # "lastTime":J
    .end local v21    # "sProperty":Ljava/lang/String;
    .restart local v9    # "accessFile":Ljava/io/RandomAccessFile;
    .restart local v15    # "file":Ljava/io/File;
    :catch_a
    move-exception v13

    move-object v14, v15

    .end local v15    # "file":Ljava/io/File;
    .restart local v14    # "file":Ljava/io/File;
    goto/16 :goto_3

    .end local v9    # "accessFile":Ljava/io/RandomAccessFile;
    .restart local v10    # "accessFile":Ljava/io/RandomAccessFile;
    :catch_b
    move-exception v13

    move-object v9, v10

    .end local v10    # "accessFile":Ljava/io/RandomAccessFile;
    .restart local v9    # "accessFile":Ljava/io/RandomAccessFile;
    goto/16 :goto_3
.end method

.method private getConnection(Ljava/lang/String;)Ljava/net/HttpURLConnection;
    .locals 4
    .param p1, "urlStr"    # Ljava/lang/String;
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljava/lang/Exception;
        }
    .end annotation

    .prologue
    .line 426
    .local p0, "this":Lcom/kaopu/download/abst/ADownloadWorker;, "Lcom/kaopu/download/abst/ADownloadWorker<TT;>;"
    const/4 v1, 0x0

    .line 427
    .local v1, "url":Ljava/net/URL;
    const/4 v0, 0x0

    .line 428
    .local v0, "conn":Ljava/net/HttpURLConnection;
    new-instance v1, Ljava/net/URL;

    .end local v1    # "url":Ljava/net/URL;
    invoke-static {p1}, Lcom/kaopu/download/util/DownloadHttpUtil;->utf8URLencode(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v2

    invoke-direct {v1, v2}, Ljava/net/URL;-><init>(Ljava/lang/String;)V

    .line 429
    .restart local v1    # "url":Ljava/net/URL;
    invoke-virtual {v1}, Ljava/net/URL;->openConnection()Ljava/net/URLConnection;

    move-result-object v0

    .end local v0    # "conn":Ljava/net/HttpURLConnection;
    check-cast v0, Ljava/net/HttpURLConnection;

    .line 430
    .restart local v0    # "conn":Ljava/net/HttpURLConnection;
    const-string v2, "GET"

    invoke-virtual {v0, v2}, Ljava/net/HttpURLConnection;->setRequestMethod(Ljava/lang/String;)V

    .line 431
    const/4 v2, 0x1

    invoke-virtual {v0, v2}, Ljava/net/HttpURLConnection;->setDoInput(Z)V

    .line 432
    const/16 v2, 0x3a98

    invoke-virtual {v0, v2}, Ljava/net/HttpURLConnection;->setConnectTimeout(I)V

    .line 434
    const/16 v2, 0x7530

    invoke-virtual {v0, v2}, Ljava/net/HttpURLConnection;->setReadTimeout(I)V

    .line 437
    const-string v2, "Accept"

    .line 438
    const-string v3, "image/gif, image/jpeg, image/pjpeg, image/pjpeg, application/x-shockwave-flash, application/xaml+xml, application/vnd.ms-xpsdocument, application/x-ms-xbap, application/x-ms-application, application/vnd.ms-excel, application/vnd.ms-powerpoint, application/msword, */*"

    .line 436
    invoke-virtual {v0, v2, v3}, Ljava/net/HttpURLConnection;->setRequestProperty(Ljava/lang/String;Ljava/lang/String;)V

    .line 439
    const-string v2, "Charset"

    const-string v3, "UTF-8"

    invoke-virtual {v0, v2, v3}, Ljava/net/HttpURLConnection;->setRequestProperty(Ljava/lang/String;Ljava/lang/String;)V

    .line 442
    const-string v2, "Connection"

    const-string v3, "Keep-Alive"

    invoke-virtual {v0, v2, v3}, Ljava/net/HttpURLConnection;->setRequestProperty(Ljava/lang/String;Ljava/lang/String;)V

    .line 443
    return-object v0
.end method

.method public static getFileName(Ljava/lang/String;)Ljava/lang/String;
    .locals 3
    .param p0, "url"    # Ljava/lang/String;

    .prologue
    .line 409
    const/16 v2, 0x2f

    invoke-virtual {p0, v2}, Ljava/lang/String;->lastIndexOf(I)I

    move-result v1

    .line 411
    .local v1, "lastIndex":I
    add-int/lit8 v2, v1, 0x1

    :try_start_0
    invoke-virtual {p0, v2}, Ljava/lang/String;->substring(I)Ljava/lang/String;
    :try_end_0
    .catch Ljava/lang/Exception; {:try_start_0 .. :try_end_0} :catch_0

    move-result-object v2

    .line 415
    :goto_0
    return-object v2

    .line 412
    :catch_0
    move-exception v0

    .line 413
    .local v0, "e":Ljava/lang/Exception;
    invoke-virtual {v0}, Ljava/lang/Exception;->printStackTrace()V

    .line 415
    const/4 v2, 0x0

    goto :goto_0
.end method

.method private renameFile(Ljava/io/File;Ljava/lang/String;)V
    .locals 2
    .param p1, "from"    # Ljava/io/File;
    .param p2, "to"    # Ljava/lang/String;

    .prologue
    .line 259
    .local p0, "this":Lcom/kaopu/download/abst/ADownloadWorker;, "Lcom/kaopu/download/abst/ADownloadWorker<TT;>;"
    new-instance v0, Ljava/io/File;

    invoke-direct {v0, p2}, Ljava/io/File;-><init>(Ljava/lang/String;)V

    .line 260
    .local v0, "toFile":Ljava/io/File;
    invoke-virtual {v0}, Ljava/io/File;->exists()Z

    move-result v1

    if-nez v1, :cond_0

    .line 261
    invoke-virtual {p1, v0}, Ljava/io/File;->renameTo(Ljava/io/File;)Z

    .line 262
    :cond_0
    const/4 v0, 0x0

    .line 263
    return-void
.end method


# virtual methods
.method public final cancle()Z
    .locals 1

    .prologue
    .line 490
    .local p0, "this":Lcom/kaopu/download/abst/ADownloadWorker;, "Lcom/kaopu/download/abst/ADownloadWorker<TT;>;"
    iget-object v0, p0, Lcom/kaopu/download/abst/ADownloadWorker;->identification:Ljava/lang/String;

    invoke-virtual {p0, v0}, Lcom/kaopu/download/abst/ADownloadWorker;->onDownloadCanceling(Ljava/lang/String;)V

    .line 491
    const/4 v0, 0x2

    iput v0, p0, Lcom/kaopu/download/abst/ADownloadWorker;->requestType:I

    .line 492
    iget-boolean v0, p0, Lcom/kaopu/download/abst/ADownloadWorker;->running:Z

    if-eqz v0, :cond_0

    .line 493
    invoke-static {}, Ljava/lang/Thread;->currentThread()Ljava/lang/Thread;

    move-result-object v0

    invoke-virtual {v0}, Ljava/lang/Thread;->interrupt()V

    .line 494
    const/4 v0, 0x0

    iput-boolean v0, p0, Lcom/kaopu/download/abst/ADownloadWorker;->running:Z

    .line 500
    :goto_0
    const/4 v0, 0x1

    return v0

    .line 496
    :cond_0
    invoke-static {p0}, Lcom/kaopu/download/util/DownloadThreadUtil;->remove(Lcom/kaopu/download/abst/ADownloadWorker;)Z

    .line 497
    invoke-virtual {p0}, Lcom/kaopu/download/abst/ADownloadWorker;->deleteTempFile()V

    .line 498
    iget-object v0, p0, Lcom/kaopu/download/abst/ADownloadWorker;->identification:Ljava/lang/String;

    invoke-virtual {p0, v0}, Lcom/kaopu/download/abst/ADownloadWorker;->onDownloadCanceled(Ljava/lang/String;)V

    goto :goto_0
.end method

.method public deleteTempFile()V
    .locals 5

    .prologue
    .line 382
    .local p0, "this":Lcom/kaopu/download/abst/ADownloadWorker;, "Lcom/kaopu/download/abst/ADownloadWorker<TT;>;"
    new-instance v1, Ljava/io/File;

    iget-object v3, p0, Lcom/kaopu/download/abst/ADownloadWorker;->saveFile:Ljava/lang/String;

    invoke-direct {v1, v3}, Ljava/io/File;-><init>(Ljava/lang/String;)V

    .line 383
    .local v1, "file":Ljava/io/File;
    invoke-virtual {v1}, Ljava/io/File;->exists()Z

    move-result v3

    if-eqz v3, :cond_0

    .line 384
    invoke-virtual {v1}, Ljava/io/File;->delete()Z

    .line 385
    :cond_0
    iget-object v3, p0, Lcom/kaopu/download/abst/ADownloadWorker;->identification:Ljava/lang/String;

    invoke-static {v3}, Lcom/kaopu/download/kernel/DownloadWorkerSupervisor;->isDownloading(Ljava/lang/String;)Z

    move-result v3

    if-nez v3, :cond_1

    .line 387
    :try_start_0
    new-instance v2, Ljava/io/File;

    new-instance v3, Ljava/lang/StringBuilder;

    iget-object v4, p0, Lcom/kaopu/download/abst/ADownloadWorker;->saveFile:Ljava/lang/String;

    invoke-static {v4}, Ljava/lang/String;->valueOf(Ljava/lang/Object;)Ljava/lang/String;

    move-result-object v4

    invoke-direct {v3, v4}, Ljava/lang/StringBuilder;-><init>(Ljava/lang/String;)V

    const-string v4, ".temp"

    invoke-virtual {v3, v4}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v3

    invoke-virtual {v3}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v3

    invoke-direct {v2, v3}, Ljava/io/File;-><init>(Ljava/lang/String;)V
    :try_end_0
    .catch Ljava/lang/Exception; {:try_start_0 .. :try_end_0} :catch_0

    .line 388
    .end local v1    # "file":Ljava/io/File;
    .local v2, "file":Ljava/io/File;
    :try_start_1
    invoke-virtual {v2}, Ljava/io/File;->exists()Z

    move-result v3

    if-eqz v3, :cond_2

    .line 389
    invoke-virtual {v2}, Ljava/io/File;->delete()Z
    :try_end_1
    .catch Ljava/lang/Exception; {:try_start_1 .. :try_end_1} :catch_1

    move-object v1, v2

    .line 394
    .end local v2    # "file":Ljava/io/File;
    .restart local v1    # "file":Ljava/io/File;
    :cond_1
    :goto_0
    return-void

    .line 390
    :catch_0
    move-exception v0

    .line 391
    .local v0, "ex":Ljava/lang/Exception;
    :goto_1
    invoke-virtual {v0}, Ljava/lang/Exception;->printStackTrace()V

    goto :goto_0

    .line 390
    .end local v0    # "ex":Ljava/lang/Exception;
    .end local v1    # "file":Ljava/io/File;
    .restart local v2    # "file":Ljava/io/File;
    :catch_1
    move-exception v0

    move-object v1, v2

    .end local v2    # "file":Ljava/io/File;
    .restart local v1    # "file":Ljava/io/File;
    goto :goto_1

    .end local v1    # "file":Ljava/io/File;
    .restart local v2    # "file":Ljava/io/File;
    :cond_2
    move-object v1, v2

    .end local v2    # "file":Ljava/io/File;
    .restart local v1    # "file":Ljava/io/File;
    goto :goto_0
.end method

.method public getBaseDownloadInfo()Lcom/kaopu/download/kernel/BaseDownloadInfo;
    .locals 1
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "()TT;"
        }
    .end annotation

    .prologue
    .line 566
    .local p0, "this":Lcom/kaopu/download/abst/ADownloadWorker;, "Lcom/kaopu/download/abst/ADownloadWorker<TT;>;"
    iget-object v0, p0, Lcom/kaopu/download/abst/ADownloadWorker;->mDownloadInfo:Lcom/kaopu/download/kernel/BaseDownloadInfo;

    return-object v0
.end method

.method public getProgress()I
    .locals 1

    .prologue
    .line 515
    .local p0, "this":Lcom/kaopu/download/abst/ADownloadWorker;, "Lcom/kaopu/download/abst/ADownloadWorker<TT;>;"
    iget v0, p0, Lcom/kaopu/download/abst/ADownloadWorker;->progress:I

    return v0
.end method

.method public getTotalSize()J
    .locals 2

    .prologue
    .line 539
    .local p0, "this":Lcom/kaopu/download/abst/ADownloadWorker;, "Lcom/kaopu/download/abst/ADownloadWorker<TT;>;"
    iget-wide v0, p0, Lcom/kaopu/download/abst/ADownloadWorker;->totalSize:J

    return-wide v0
.end method

.method public getUrl()Ljava/lang/String;
    .locals 1

    .prologue
    .line 548
    .local p0, "this":Lcom/kaopu/download/abst/ADownloadWorker;, "Lcom/kaopu/download/abst/ADownloadWorker<TT;>;"
    iget-object v0, p0, Lcom/kaopu/download/abst/ADownloadWorker;->url:Ljava/lang/String;

    return-object v0
.end method

.method protected maybeInitDir(Ljava/lang/String;)V
    .locals 4
    .param p1, "path"    # Ljava/lang/String;

    .prologue
    .line 94
    .local p0, "this":Lcom/kaopu/download/abst/ADownloadWorker;, "Lcom/kaopu/download/abst/ADownloadWorker<TT;>;"
    new-instance v0, Ljava/io/File;

    invoke-direct {v0, p1}, Ljava/io/File;-><init>(Ljava/lang/String;)V

    .line 95
    .local v0, "file":Ljava/io/File;
    invoke-virtual {v0}, Ljava/io/File;->exists()Z

    move-result v1

    if-nez v1, :cond_0

    .line 96
    invoke-virtual {v0}, Ljava/io/File;->mkdirs()Z

    .line 98
    :cond_0
    new-instance v1, Ljava/io/File;

    iget-object v2, p0, Lcom/kaopu/download/abst/ADownloadWorker;->saveDir:Ljava/lang/String;

    iget-object v3, p0, Lcom/kaopu/download/abst/ADownloadWorker;->saveName:Ljava/lang/String;

    invoke-direct {v1, v2, v3}, Ljava/io/File;-><init>(Ljava/lang/String;Ljava/lang/String;)V

    invoke-virtual {v1}, Ljava/io/File;->getAbsolutePath()Ljava/lang/String;

    move-result-object v1

    iput-object v1, p0, Lcom/kaopu/download/abst/ADownloadWorker;->saveFile:Ljava/lang/String;

    .line 99
    return-void
.end method

.method protected abstract onDownloadCanceled(Ljava/lang/String;)V
.end method

.method protected abstract onDownloadCanceling(Ljava/lang/String;)V
.end method

.method protected abstract onDownloadCompleted(Ljava/lang/String;Ljava/lang/String;J)V
.end method

.method protected abstract onDownloadConnecting(Ljava/lang/String;J)V
.end method

.method protected abstract onDownloadFailed(Ljava/lang/String;)V
.end method

.method protected abstract onDownloadPaused(Ljava/lang/String;)V
.end method

.method protected abstract onDownloadPausing(Ljava/lang/String;)V
.end method

.method protected abstract onDownloadWait(Ljava/lang/String;)V
.end method

.method protected abstract onDownloadWorking(Ljava/lang/String;JJI)V
.end method

.method public final pause()Z
    .locals 2

    .prologue
    .local p0, "this":Lcom/kaopu/download/abst/ADownloadWorker;, "Lcom/kaopu/download/abst/ADownloadWorker<TT;>;"
    const/4 v1, 0x1

    .line 462
    iget-object v0, p0, Lcom/kaopu/download/abst/ADownloadWorker;->identification:Ljava/lang/String;

    invoke-virtual {p0, v0}, Lcom/kaopu/download/abst/ADownloadWorker;->onDownloadPausing(Ljava/lang/String;)V

    .line 463
    iput v1, p0, Lcom/kaopu/download/abst/ADownloadWorker;->requestType:I

    .line 464
    iget-boolean v0, p0, Lcom/kaopu/download/abst/ADownloadWorker;->running:Z

    if-eqz v0, :cond_0

    .line 465
    invoke-static {}, Ljava/lang/Thread;->currentThread()Ljava/lang/Thread;

    move-result-object v0

    invoke-virtual {v0}, Ljava/lang/Thread;->interrupt()V

    .line 466
    const/4 v0, 0x0

    iput-boolean v0, p0, Lcom/kaopu/download/abst/ADownloadWorker;->running:Z

    .line 471
    :goto_0
    return v1

    .line 468
    :cond_0
    invoke-static {p0}, Lcom/kaopu/download/util/DownloadThreadUtil;->remove(Lcom/kaopu/download/abst/ADownloadWorker;)Z

    .line 469
    iget-object v0, p0, Lcom/kaopu/download/abst/ADownloadWorker;->identification:Ljava/lang/String;

    invoke-virtual {p0, v0}, Lcom/kaopu/download/abst/ADownloadWorker;->onDownloadPaused(Ljava/lang/String;)V

    goto :goto_0
.end method

.method public run()V
    .locals 0

    .prologue
    .line 103
    .local p0, "this":Lcom/kaopu/download/abst/ADownloadWorker;, "Lcom/kaopu/download/abst/ADownloadWorker<TT;>;"
    invoke-direct {p0}, Lcom/kaopu/download/abst/ADownloadWorker;->download()V

    .line 104
    return-void
.end method

.method public setSpecifyFileName(Ljava/lang/String;)V
    .locals 0
    .param p1, "specifyFileName"    # Ljava/lang/String;

    .prologue
    .line 525
    .local p0, "this":Lcom/kaopu/download/abst/ADownloadWorker;, "Lcom/kaopu/download/abst/ADownloadWorker<TT;>;"
    iput-object p1, p0, Lcom/kaopu/download/abst/ADownloadWorker;->saveName:Ljava/lang/String;

    .line 526
    return-void
.end method

.method public declared-synchronized start()Z
    .locals 1

    .prologue
    .line 530
    .local p0, "this":Lcom/kaopu/download/abst/ADownloadWorker;, "Lcom/kaopu/download/abst/ADownloadWorker<TT;>;"
    monitor-enter p0

    :try_start_0
    iget-object v0, p0, Lcom/kaopu/download/abst/ADownloadWorker;->identification:Ljava/lang/String;

    invoke-static {v0, p0}, Lcom/kaopu/download/kernel/DownloadWorkerSupervisor;->add(Ljava/lang/String;Lcom/kaopu/download/abst/ADownloadWorker;)Z

    move-result v0

    if-eqz v0, :cond_0

    .line 531
    iget-object v0, p0, Lcom/kaopu/download/abst/ADownloadWorker;->identification:Ljava/lang/String;

    invoke-virtual {p0, v0}, Lcom/kaopu/download/abst/ADownloadWorker;->onDownloadWait(Ljava/lang/String;)V

    .line 532
    invoke-static {p0}, Lcom/kaopu/download/util/DownloadThreadUtil;->excuteDownload(Ljava/lang/Runnable;)V
    :try_end_0
    .catchall {:try_start_0 .. :try_end_0} :catchall_0

    .line 533
    const/4 v0, 0x1

    .line 535
    :goto_0
    monitor-exit p0

    return v0

    :cond_0
    const/4 v0, 0x0

    goto :goto_0

    .line 530
    :catchall_0
    move-exception v0

    monitor-exit p0

    throw v0
.end method

.method public updateDownloadUrl(Ljava/lang/String;)V
    .locals 1
    .param p1, "url"    # Ljava/lang/String;

    .prologue
    .line 557
    .local p0, "this":Lcom/kaopu/download/abst/ADownloadWorker;, "Lcom/kaopu/download/abst/ADownloadWorker<TT;>;"
    invoke-static {p1}, Lcom/kaopu/download/util/DownloadHttpUtil;->utf8URLencode(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v0

    iput-object v0, p0, Lcom/kaopu/download/abst/ADownloadWorker;->url:Ljava/lang/String;

    .line 558
    return-void
.end method
