.class final Lcom/iflytek/voiceads/dex/UpdateUtils$2;
.super Ljava/lang/Object;
.source "UpdateUtils.java"

# interfaces
.implements Ljava/lang/Runnable;


# annotations
.annotation system Ldalvik/annotation/EnclosingMethod;
    value = Lcom/iflytek/voiceads/dex/UpdateUtils;->downloadRemoteDex(Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;)V
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x8
    name = null
.end annotation


# instance fields
.field final synthetic val$cacheFileDir:Ljava/lang/String;

.field final synthetic val$downloadServer:Ljava/lang/String;

.field final synthetic val$remoteVersion:Ljava/lang/String;


# direct methods
.method constructor <init>(Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;)V
    .locals 0

    .prologue
    .line 211
    iput-object p1, p0, Lcom/iflytek/voiceads/dex/UpdateUtils$2;->val$remoteVersion:Ljava/lang/String;

    iput-object p2, p0, Lcom/iflytek/voiceads/dex/UpdateUtils$2;->val$downloadServer:Ljava/lang/String;

    iput-object p3, p0, Lcom/iflytek/voiceads/dex/UpdateUtils$2;->val$cacheFileDir:Ljava/lang/String;

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method


# virtual methods
.method public run()V
    .locals 11

    .prologue
    .line 215
    new-instance v9, Ljava/lang/StringBuilder;

    invoke-direct {v9}, Ljava/lang/StringBuilder;-><init>()V

    const-string v10, "downloading new version:"

    invoke-virtual {v9, v10}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v9

    iget-object v10, p0, Lcom/iflytek/voiceads/dex/UpdateUtils$2;->val$remoteVersion:Ljava/lang/String;

    invoke-virtual {v9, v10}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v9

    invoke-virtual {v9}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v9

    invoke-static {v9}, Lcom/iflytek/voiceads/dex/SDKLogger;->d(Ljava/lang/String;)V

    .line 216
    const/4 v5, 0x0

    .line 217
    .local v5, "in":Ljava/io/InputStream;
    const/4 v3, 0x0

    .line 219
    .local v3, "fos":Ljava/io/FileOutputStream;
    :try_start_0
    new-instance v8, Ljava/net/URL;

    iget-object v9, p0, Lcom/iflytek/voiceads/dex/UpdateUtils$2;->val$downloadServer:Ljava/lang/String;

    invoke-direct {v8, v9}, Ljava/net/URL;-><init>(Ljava/lang/String;)V

    .line 220
    .local v8, "url":Ljava/net/URL;
    invoke-virtual {v8}, Ljava/net/URL;->openConnection()Ljava/net/URLConnection;

    move-result-object v1

    check-cast v1, Ljava/net/HttpURLConnection;

    .line 221
    .local v1, "conn":Ljava/net/HttpURLConnection;
    const/16 v9, 0x1388

    invoke-virtual {v1, v9}, Ljava/net/HttpURLConnection;->setReadTimeout(I)V

    .line 222
    const/16 v9, 0x1388

    invoke-virtual {v1, v9}, Ljava/net/HttpURLConnection;->setConnectTimeout(I)V

    .line 223
    const-string v9, "GET"

    invoke-virtual {v1, v9}, Ljava/net/HttpURLConnection;->setRequestMethod(Ljava/lang/String;)V

    .line 224
    invoke-virtual {v1}, Ljava/net/HttpURLConnection;->getResponseCode()I

    move-result v7

    .line 225
    .local v7, "rCode":I
    const/16 v9, 0xc8

    if-ne v7, v9, :cond_3

    .line 226
    invoke-virtual {v1}, Ljava/net/HttpURLConnection;->getInputStream()Ljava/io/InputStream;

    move-result-object v5

    .line 227
    new-instance v4, Ljava/io/FileOutputStream;

    new-instance v9, Ljava/lang/StringBuilder;

    invoke-direct {v9}, Ljava/lang/StringBuilder;-><init>()V

    iget-object v10, p0, Lcom/iflytek/voiceads/dex/UpdateUtils$2;->val$cacheFileDir:Ljava/lang/String;

    invoke-virtual {v9, v10}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v9

    iget-object v10, p0, Lcom/iflytek/voiceads/dex/UpdateUtils$2;->val$remoteVersion:Ljava/lang/String;

    invoke-virtual {v9, v10}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v9

    invoke-virtual {v9}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v9

    invoke-direct {v4, v9}, Ljava/io/FileOutputStream;-><init>(Ljava/lang/String;)V
    :try_end_0
    .catch Ljava/net/MalformedURLException; {:try_start_0 .. :try_end_0} :catch_7
    .catch Ljava/io/IOException; {:try_start_0 .. :try_end_0} :catch_3
    .catchall {:try_start_0 .. :try_end_0} :catchall_0

    .line 228
    .end local v3    # "fos":Ljava/io/FileOutputStream;
    .local v4, "fos":Ljava/io/FileOutputStream;
    const/16 v9, 0x400

    :try_start_1
    new-array v0, v9, [B

    .line 229
    .local v0, "buf":[B
    const/4 v6, 0x0

    .line 230
    .local v6, "length":I
    :goto_0
    invoke-virtual {v5, v0}, Ljava/io/InputStream;->read([B)I

    move-result v6

    const/4 v9, -0x1

    if-le v6, v9, :cond_2

    .line 231
    const/4 v9, 0x0

    invoke-virtual {v4, v0, v9, v6}, Ljava/io/FileOutputStream;->write([BII)V
    :try_end_1
    .catch Ljava/net/MalformedURLException; {:try_start_1 .. :try_end_1} :catch_0
    .catch Ljava/io/IOException; {:try_start_1 .. :try_end_1} :catch_6
    .catchall {:try_start_1 .. :try_end_1} :catchall_1

    goto :goto_0

    .line 236
    .end local v0    # "buf":[B
    .end local v6    # "length":I
    :catch_0
    move-exception v2

    move-object v3, v4

    .line 237
    .end local v1    # "conn":Ljava/net/HttpURLConnection;
    .end local v4    # "fos":Ljava/io/FileOutputStream;
    .end local v7    # "rCode":I
    .end local v8    # "url":Ljava/net/URL;
    .local v2, "e":Ljava/net/MalformedURLException;
    .restart local v3    # "fos":Ljava/io/FileOutputStream;
    :goto_1
    :try_start_2
    invoke-virtual {v2}, Ljava/net/MalformedURLException;->printStackTrace()V
    :try_end_2
    .catchall {:try_start_2 .. :try_end_2} :catchall_0

    .line 242
    if-eqz v5, :cond_0

    .line 243
    :try_start_3
    invoke-virtual {v5}, Ljava/io/InputStream;->close()V

    .line 244
    const/4 v5, 0x0

    .line 246
    :cond_0
    if-eqz v3, :cond_1

    .line 247
    invoke-virtual {v3}, Ljava/io/FileOutputStream;->close()V
    :try_end_3
    .catch Ljava/io/IOException; {:try_start_3 .. :try_end_3} :catch_2

    .line 248
    const/4 v3, 0x0

    .line 254
    .end local v2    # "e":Ljava/net/MalformedURLException;
    :cond_1
    :goto_2
    return-void

    .line 233
    .end local v3    # "fos":Ljava/io/FileOutputStream;
    .restart local v0    # "buf":[B
    .restart local v1    # "conn":Ljava/net/HttpURLConnection;
    .restart local v4    # "fos":Ljava/io/FileOutputStream;
    .restart local v6    # "length":I
    .restart local v7    # "rCode":I
    .restart local v8    # "url":Ljava/net/URL;
    :cond_2
    :try_start_4
    invoke-virtual {v4}, Ljava/io/FileOutputStream;->flush()V

    .line 234
    new-instance v9, Ljava/lang/StringBuilder;

    invoke-direct {v9}, Ljava/lang/StringBuilder;-><init>()V

    const-string v10, "download "

    invoke-virtual {v9, v10}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v9

    iget-object v10, p0, Lcom/iflytek/voiceads/dex/UpdateUtils$2;->val$remoteVersion:Ljava/lang/String;

    invoke-virtual {v9, v10}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v9

    const-string v10, " completed, it will be loaded next time"

    invoke-virtual {v9, v10}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v9

    invoke-virtual {v9}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v9

    invoke-static {v9}, Lcom/iflytek/voiceads/dex/SDKLogger;->d(Ljava/lang/String;)V
    :try_end_4
    .catch Ljava/net/MalformedURLException; {:try_start_4 .. :try_end_4} :catch_0
    .catch Ljava/io/IOException; {:try_start_4 .. :try_end_4} :catch_6
    .catchall {:try_start_4 .. :try_end_4} :catchall_1

    move-object v3, v4

    .line 242
    .end local v0    # "buf":[B
    .end local v4    # "fos":Ljava/io/FileOutputStream;
    .end local v6    # "length":I
    .restart local v3    # "fos":Ljava/io/FileOutputStream;
    :cond_3
    if-eqz v5, :cond_4

    .line 243
    :try_start_5
    invoke-virtual {v5}, Ljava/io/InputStream;->close()V

    .line 244
    const/4 v5, 0x0

    .line 246
    :cond_4
    if-eqz v3, :cond_1

    .line 247
    invoke-virtual {v3}, Ljava/io/FileOutputStream;->close()V
    :try_end_5
    .catch Ljava/io/IOException; {:try_start_5 .. :try_end_5} :catch_1

    .line 248
    const/4 v3, 0x0

    goto :goto_2

    .line 250
    :catch_1
    move-exception v2

    .line 251
    .local v2, "e":Ljava/io/IOException;
    invoke-virtual {v2}, Ljava/io/IOException;->printStackTrace()V

    goto :goto_2

    .line 250
    .end local v1    # "conn":Ljava/net/HttpURLConnection;
    .end local v7    # "rCode":I
    .end local v8    # "url":Ljava/net/URL;
    .local v2, "e":Ljava/net/MalformedURLException;
    :catch_2
    move-exception v2

    .line 251
    .local v2, "e":Ljava/io/IOException;
    invoke-virtual {v2}, Ljava/io/IOException;->printStackTrace()V

    goto :goto_2

    .line 238
    .end local v2    # "e":Ljava/io/IOException;
    :catch_3
    move-exception v2

    .line 239
    .restart local v2    # "e":Ljava/io/IOException;
    :goto_3
    :try_start_6
    invoke-virtual {v2}, Ljava/io/IOException;->printStackTrace()V
    :try_end_6
    .catchall {:try_start_6 .. :try_end_6} :catchall_0

    .line 242
    if-eqz v5, :cond_5

    .line 243
    :try_start_7
    invoke-virtual {v5}, Ljava/io/InputStream;->close()V

    .line 244
    const/4 v5, 0x0

    .line 246
    :cond_5
    if-eqz v3, :cond_1

    .line 247
    invoke-virtual {v3}, Ljava/io/FileOutputStream;->close()V
    :try_end_7
    .catch Ljava/io/IOException; {:try_start_7 .. :try_end_7} :catch_4

    .line 248
    const/4 v3, 0x0

    goto :goto_2

    .line 250
    :catch_4
    move-exception v2

    .line 251
    invoke-virtual {v2}, Ljava/io/IOException;->printStackTrace()V

    goto :goto_2

    .line 241
    .end local v2    # "e":Ljava/io/IOException;
    :catchall_0
    move-exception v9

    .line 242
    :goto_4
    if-eqz v5, :cond_6

    .line 243
    :try_start_8
    invoke-virtual {v5}, Ljava/io/InputStream;->close()V

    .line 244
    const/4 v5, 0x0

    .line 246
    :cond_6
    if-eqz v3, :cond_7

    .line 247
    invoke-virtual {v3}, Ljava/io/FileOutputStream;->close()V
    :try_end_8
    .catch Ljava/io/IOException; {:try_start_8 .. :try_end_8} :catch_5

    .line 248
    const/4 v3, 0x0

    .line 252
    :cond_7
    :goto_5
    throw v9

    .line 250
    :catch_5
    move-exception v2

    .line 251
    .restart local v2    # "e":Ljava/io/IOException;
    invoke-virtual {v2}, Ljava/io/IOException;->printStackTrace()V

    goto :goto_5

    .line 241
    .end local v2    # "e":Ljava/io/IOException;
    .end local v3    # "fos":Ljava/io/FileOutputStream;
    .restart local v1    # "conn":Ljava/net/HttpURLConnection;
    .restart local v4    # "fos":Ljava/io/FileOutputStream;
    .restart local v7    # "rCode":I
    .restart local v8    # "url":Ljava/net/URL;
    :catchall_1
    move-exception v9

    move-object v3, v4

    .end local v4    # "fos":Ljava/io/FileOutputStream;
    .restart local v3    # "fos":Ljava/io/FileOutputStream;
    goto :goto_4

    .line 238
    .end local v3    # "fos":Ljava/io/FileOutputStream;
    .restart local v4    # "fos":Ljava/io/FileOutputStream;
    :catch_6
    move-exception v2

    move-object v3, v4

    .end local v4    # "fos":Ljava/io/FileOutputStream;
    .restart local v3    # "fos":Ljava/io/FileOutputStream;
    goto :goto_3

    .line 236
    .end local v1    # "conn":Ljava/net/HttpURLConnection;
    .end local v7    # "rCode":I
    .end local v8    # "url":Ljava/net/URL;
    :catch_7
    move-exception v2

    goto :goto_1
.end method
