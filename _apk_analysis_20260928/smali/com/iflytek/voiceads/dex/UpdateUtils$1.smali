.class final Lcom/iflytek/voiceads/dex/UpdateUtils$1;
.super Ljava/lang/Object;
.source "UpdateUtils.java"

# interfaces
.implements Ljava/lang/Runnable;


# annotations
.annotation system Ldalvik/annotation/EnclosingMethod;
    value = Lcom/iflytek/voiceads/dex/UpdateUtils;->checkDexUpdate(Landroid/content/Context;Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;)V
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x8
    name = null
.end annotation


# instance fields
.field final synthetic val$cacheFileDir:Ljava/lang/String;

.field final synthetic val$localVersion:Ljava/lang/String;

.field final synthetic val$sdkVersion:Ljava/lang/String;

.field final synthetic val$updateServer:Ljava/lang/String;


# direct methods
.method constructor <init>(Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;)V
    .locals 0

    .prologue
    .line 149
    iput-object p1, p0, Lcom/iflytek/voiceads/dex/UpdateUtils$1;->val$updateServer:Ljava/lang/String;

    iput-object p2, p0, Lcom/iflytek/voiceads/dex/UpdateUtils$1;->val$sdkVersion:Ljava/lang/String;

    iput-object p3, p0, Lcom/iflytek/voiceads/dex/UpdateUtils$1;->val$localVersion:Ljava/lang/String;

    iput-object p4, p0, Lcom/iflytek/voiceads/dex/UpdateUtils$1;->val$cacheFileDir:Ljava/lang/String;

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method


# virtual methods
.method public run()V
    .locals 13

    .prologue
    .line 152
    const-string v9, "checking update"

    invoke-static {v9}, Lcom/iflytek/voiceads/dex/SDKLogger;->d(Ljava/lang/String;)V

    .line 153
    const/4 v4, 0x0

    .line 154
    .local v4, "in":Ljava/io/InputStream;
    new-instance v0, Ljava/io/ByteArrayOutputStream;

    invoke-direct {v0}, Ljava/io/ByteArrayOutputStream;-><init>()V

    .line 156
    .local v0, "bos":Ljava/io/ByteArrayOutputStream;
    :try_start_0
    new-instance v8, Ljava/net/URL;

    iget-object v9, p0, Lcom/iflytek/voiceads/dex/UpdateUtils$1;->val$updateServer:Ljava/lang/String;

    invoke-direct {v8, v9}, Ljava/net/URL;-><init>(Ljava/lang/String;)V

    .line 157
    .local v8, "url":Ljava/net/URL;
    invoke-virtual {v8}, Ljava/net/URL;->openConnection()Ljava/net/URLConnection;

    move-result-object v2

    check-cast v2, Ljava/net/HttpURLConnection;

    .line 158
    .local v2, "conn":Ljava/net/HttpURLConnection;
    const/16 v9, 0x1388

    invoke-virtual {v2, v9}, Ljava/net/HttpURLConnection;->setReadTimeout(I)V

    .line 159
    const/16 v9, 0x1388

    invoke-virtual {v2, v9}, Ljava/net/HttpURLConnection;->setConnectTimeout(I)V

    .line 160
    const-string v9, "GET"

    invoke-virtual {v2, v9}, Ljava/net/HttpURLConnection;->setRequestMethod(Ljava/lang/String;)V

    .line 161
    const-string v9, "Charset"

    const-string v10, "utf-8"

    invoke-virtual {v2, v9, v10}, Ljava/net/HttpURLConnection;->setRequestProperty(Ljava/lang/String;Ljava/lang/String;)V

    .line 162
    invoke-virtual {v2}, Ljava/net/HttpURLConnection;->getResponseCode()I

    move-result v6

    .line 163
    .local v6, "rCode":I
    const/16 v9, 0xc8

    if-ne v6, v9, :cond_6

    .line 164
    invoke-virtual {v2}, Ljava/net/HttpURLConnection;->getInputStream()Ljava/io/InputStream;

    move-result-object v4

    .line 165
    const/16 v9, 0x400

    new-array v1, v9, [B

    .line 166
    .local v1, "buf":[B
    const/4 v5, 0x0

    .line 167
    .local v5, "length":I
    :goto_0
    invoke-virtual {v4, v1}, Ljava/io/InputStream;->read([B)I

    move-result v5

    const/4 v9, -0x1

    if-le v5, v9, :cond_2

    .line 168
    const/4 v9, 0x0

    invoke-virtual {v0, v1, v9, v5}, Ljava/io/ByteArrayOutputStream;->write([BII)V
    :try_end_0
    .catch Ljava/net/MalformedURLException; {:try_start_0 .. :try_end_0} :catch_0
    .catch Ljava/io/IOException; {:try_start_0 .. :try_end_0} :catch_2
    .catchall {:try_start_0 .. :try_end_0} :catchall_0

    goto :goto_0

    .line 183
    .end local v1    # "buf":[B
    .end local v2    # "conn":Ljava/net/HttpURLConnection;
    .end local v5    # "length":I
    .end local v6    # "rCode":I
    .end local v8    # "url":Ljava/net/URL;
    :catch_0
    move-exception v3

    .line 184
    .local v3, "e":Ljava/net/MalformedURLException;
    :try_start_1
    invoke-virtual {v3}, Ljava/net/MalformedURLException;->printStackTrace()V
    :try_end_1
    .catchall {:try_start_1 .. :try_end_1} :catchall_0

    .line 189
    if-eqz v4, :cond_0

    .line 190
    :try_start_2
    invoke-virtual {v4}, Ljava/io/InputStream;->close()V

    .line 191
    const/4 v4, 0x0

    .line 193
    :cond_0
    if-eqz v0, :cond_1

    .line 194
    invoke-virtual {v0}, Ljava/io/ByteArrayOutputStream;->close()V
    :try_end_2
    .catch Ljava/io/IOException; {:try_start_2 .. :try_end_2} :catch_4

    .line 195
    const/4 v0, 0x0

    .line 202
    .end local v3    # "e":Ljava/net/MalformedURLException;
    :cond_1
    :goto_1
    return-void

    .line 171
    .restart local v1    # "buf":[B
    .restart local v2    # "conn":Ljava/net/HttpURLConnection;
    .restart local v5    # "length":I
    .restart local v6    # "rCode":I
    .restart local v8    # "url":Ljava/net/URL;
    :cond_2
    :try_start_3
    new-instance v9, Ljava/lang/String;

    invoke-virtual {v0}, Ljava/io/ByteArrayOutputStream;->toByteArray()[B

    move-result-object v10

    invoke-direct {v9, v10}, Ljava/lang/String;-><init>([B)V

    invoke-static {v9}, Lcom/iflytek/voiceads/dex/UpdateResp;->parseData(Ljava/lang/String;)Lcom/iflytek/voiceads/dex/UpdateResp;

    move-result-object v7

    .line 172
    .local v7, "resp":Lcom/iflytek/voiceads/dex/UpdateResp;
    invoke-virtual {v7}, Lcom/iflytek/voiceads/dex/UpdateResp;->getRemoteSubversion()Ljava/lang/String;

    move-result-object v9

    if-eqz v9, :cond_3

    invoke-virtual {v7}, Lcom/iflytek/voiceads/dex/UpdateResp;->getRemoteUrl()Ljava/lang/String;

    move-result-object v9

    if-nez v9, :cond_5

    .line 173
    :cond_3
    const-string v9, "no version"

    invoke-static {v9}, Lcom/iflytek/voiceads/dex/SDKLogger;->d(Ljava/lang/String;)V
    :try_end_3
    .catch Ljava/net/MalformedURLException; {:try_start_3 .. :try_end_3} :catch_0
    .catch Ljava/io/IOException; {:try_start_3 .. :try_end_3} :catch_2
    .catchall {:try_start_3 .. :try_end_3} :catchall_0

    .line 189
    if-eqz v4, :cond_4

    .line 190
    :try_start_4
    invoke-virtual {v4}, Ljava/io/InputStream;->close()V

    .line 191
    const/4 v4, 0x0

    .line 193
    :cond_4
    if-eqz v0, :cond_1

    .line 194
    invoke-virtual {v0}, Ljava/io/ByteArrayOutputStream;->close()V
    :try_end_4
    .catch Ljava/io/IOException; {:try_start_4 .. :try_end_4} :catch_1

    .line 195
    const/4 v0, 0x0

    goto :goto_1

    .line 197
    :catch_1
    move-exception v3

    .line 198
    .local v3, "e":Ljava/io/IOException;
    invoke-virtual {v3}, Ljava/io/IOException;->printStackTrace()V

    goto :goto_1

    .line 176
    .end local v3    # "e":Ljava/io/IOException;
    :cond_5
    :try_start_5
    invoke-virtual {v7}, Lcom/iflytek/voiceads/dex/UpdateResp;->getRemoteSubversion()Ljava/lang/String;

    move-result-object v9

    iget-object v10, p0, Lcom/iflytek/voiceads/dex/UpdateUtils$1;->val$sdkVersion:Ljava/lang/String;

    invoke-static {v9, v10}, Lcom/iflytek/voiceads/dex/UpdateUtils;->access$000(Ljava/lang/String;Ljava/lang/String;)I

    move-result v9

    iget-object v10, p0, Lcom/iflytek/voiceads/dex/UpdateUtils$1;->val$localVersion:Ljava/lang/String;

    iget-object v11, p0, Lcom/iflytek/voiceads/dex/UpdateUtils$1;->val$sdkVersion:Ljava/lang/String;

    invoke-static {v10, v11}, Lcom/iflytek/voiceads/dex/UpdateUtils;->access$000(Ljava/lang/String;Ljava/lang/String;)I

    move-result v10

    if-le v9, v10, :cond_8

    .line 177
    new-instance v9, Ljava/lang/StringBuilder;

    invoke-direct {v9}, Ljava/lang/StringBuilder;-><init>()V

    const-string v10, "find new version:"

    invoke-virtual {v9, v10}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v9

    invoke-virtual {v7}, Lcom/iflytek/voiceads/dex/UpdateResp;->getRemoteSubversion()Ljava/lang/String;

    move-result-object v10

    invoke-virtual {v9, v10}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v9

    invoke-virtual {v9}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v9

    invoke-static {v9}, Lcom/iflytek/voiceads/dex/SDKLogger;->d(Ljava/lang/String;)V

    .line 178
    iget-object v9, p0, Lcom/iflytek/voiceads/dex/UpdateUtils$1;->val$cacheFileDir:Ljava/lang/String;

    iget-object v10, p0, Lcom/iflytek/voiceads/dex/UpdateUtils$1;->val$sdkVersion:Ljava/lang/String;

    invoke-virtual {v7}, Lcom/iflytek/voiceads/dex/UpdateResp;->getRemoteSubversion()Ljava/lang/String;

    move-result-object v11

    invoke-virtual {v7}, Lcom/iflytek/voiceads/dex/UpdateResp;->getRemoteUrl()Ljava/lang/String;

    move-result-object v12

    invoke-static {v9, v10, v11, v12}, Lcom/iflytek/voiceads/dex/UpdateUtils;->downloadRemoteDex(Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;)V
    :try_end_5
    .catch Ljava/net/MalformedURLException; {:try_start_5 .. :try_end_5} :catch_0
    .catch Ljava/io/IOException; {:try_start_5 .. :try_end_5} :catch_2
    .catchall {:try_start_5 .. :try_end_5} :catchall_0

    .line 189
    .end local v1    # "buf":[B
    .end local v5    # "length":I
    .end local v7    # "resp":Lcom/iflytek/voiceads/dex/UpdateResp;
    :cond_6
    :goto_2
    if-eqz v4, :cond_7

    .line 190
    :try_start_6
    invoke-virtual {v4}, Ljava/io/InputStream;->close()V

    .line 191
    const/4 v4, 0x0

    .line 193
    :cond_7
    if-eqz v0, :cond_1

    .line 194
    invoke-virtual {v0}, Ljava/io/ByteArrayOutputStream;->close()V
    :try_end_6
    .catch Ljava/io/IOException; {:try_start_6 .. :try_end_6} :catch_3

    .line 195
    const/4 v0, 0x0

    goto :goto_1

    .line 180
    .restart local v1    # "buf":[B
    .restart local v5    # "length":I
    .restart local v7    # "resp":Lcom/iflytek/voiceads/dex/UpdateResp;
    :cond_8
    :try_start_7
    const-string v9, "no new version dex"

    invoke-static {v9}, Lcom/iflytek/voiceads/dex/SDKLogger;->d(Ljava/lang/String;)V
    :try_end_7
    .catch Ljava/net/MalformedURLException; {:try_start_7 .. :try_end_7} :catch_0
    .catch Ljava/io/IOException; {:try_start_7 .. :try_end_7} :catch_2
    .catchall {:try_start_7 .. :try_end_7} :catchall_0

    goto :goto_2

    .line 185
    .end local v1    # "buf":[B
    .end local v2    # "conn":Ljava/net/HttpURLConnection;
    .end local v5    # "length":I
    .end local v6    # "rCode":I
    .end local v7    # "resp":Lcom/iflytek/voiceads/dex/UpdateResp;
    .end local v8    # "url":Ljava/net/URL;
    :catch_2
    move-exception v3

    .line 186
    .restart local v3    # "e":Ljava/io/IOException;
    :try_start_8
    invoke-virtual {v3}, Ljava/io/IOException;->printStackTrace()V
    :try_end_8
    .catchall {:try_start_8 .. :try_end_8} :catchall_0

    .line 189
    if-eqz v4, :cond_9

    .line 190
    :try_start_9
    invoke-virtual {v4}, Ljava/io/InputStream;->close()V

    .line 191
    const/4 v4, 0x0

    .line 193
    :cond_9
    if-eqz v0, :cond_1

    .line 194
    invoke-virtual {v0}, Ljava/io/ByteArrayOutputStream;->close()V
    :try_end_9
    .catch Ljava/io/IOException; {:try_start_9 .. :try_end_9} :catch_5

    .line 195
    const/4 v0, 0x0

    goto/16 :goto_1

    .line 197
    .end local v3    # "e":Ljava/io/IOException;
    .restart local v2    # "conn":Ljava/net/HttpURLConnection;
    .restart local v6    # "rCode":I
    .restart local v8    # "url":Ljava/net/URL;
    :catch_3
    move-exception v3

    .line 198
    .restart local v3    # "e":Ljava/io/IOException;
    invoke-virtual {v3}, Ljava/io/IOException;->printStackTrace()V

    goto/16 :goto_1

    .line 197
    .end local v2    # "conn":Ljava/net/HttpURLConnection;
    .end local v6    # "rCode":I
    .end local v8    # "url":Ljava/net/URL;
    .local v3, "e":Ljava/net/MalformedURLException;
    :catch_4
    move-exception v3

    .line 198
    .local v3, "e":Ljava/io/IOException;
    invoke-virtual {v3}, Ljava/io/IOException;->printStackTrace()V

    goto/16 :goto_1

    .line 197
    :catch_5
    move-exception v3

    .line 198
    invoke-virtual {v3}, Ljava/io/IOException;->printStackTrace()V

    goto/16 :goto_1

    .line 188
    .end local v3    # "e":Ljava/io/IOException;
    :catchall_0
    move-exception v9

    .line 189
    if-eqz v4, :cond_a

    .line 190
    :try_start_a
    invoke-virtual {v4}, Ljava/io/InputStream;->close()V

    .line 191
    const/4 v4, 0x0

    .line 193
    :cond_a
    if-eqz v0, :cond_b

    .line 194
    invoke-virtual {v0}, Ljava/io/ByteArrayOutputStream;->close()V
    :try_end_a
    .catch Ljava/io/IOException; {:try_start_a .. :try_end_a} :catch_6

    .line 195
    const/4 v0, 0x0

    .line 199
    :cond_b
    :goto_3
    throw v9

    .line 197
    :catch_6
    move-exception v3

    .line 198
    .restart local v3    # "e":Ljava/io/IOException;
    invoke-virtual {v3}, Ljava/io/IOException;->printStackTrace()V

    goto :goto_3
.end method
