.class public final Lorg/apache/commons/mail/b/b;
.super Ljava/lang/Object;
.source "SourceFile"


# direct methods
.method private constructor <init>()V
    .locals 0

    .prologue
    .line 42
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    .line 43
    return-void
.end method

.method public static a(Ljavax/mail/Session;Ljava/io/File;)Ljavax/mail/internet/MimeMessage;
    .locals 3
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljavax/mail/MessagingException;,
            Ljava/io/IOException;
        }
    .end annotation

    .prologue
    .line 85
    const/4 v2, 0x0

    .line 89
    :try_start_0
    new-instance v1, Ljava/io/FileInputStream;

    invoke-direct {v1, p1}, Ljava/io/FileInputStream;-><init>(Ljava/io/File;)V
    :try_end_0
    .catchall {:try_start_0 .. :try_end_0} :catchall_0

    .line 90
    :try_start_1
    invoke-static {p0, v1}, Lorg/apache/commons/mail/b/b;->a(Ljavax/mail/Session;Ljava/io/InputStream;)Ljavax/mail/internet/MimeMessage;
    :try_end_1
    .catchall {:try_start_1 .. :try_end_1} :catchall_1

    move-result-object v0

    .line 94
    if-eqz v1, :cond_0

    .line 96
    invoke-virtual {v1}, Ljava/io/FileInputStream;->close()V

    :cond_0
    return-object v0

    .line 94
    :catchall_0
    move-exception v0

    move-object v1, v2

    :goto_0
    if-eqz v1, :cond_1

    .line 96
    invoke-virtual {v1}, Ljava/io/FileInputStream;->close()V

    :cond_1
    throw v0

    .line 94
    :catchall_1
    move-exception v0

    goto :goto_0
.end method

.method public static a(Ljavax/mail/Session;Ljava/io/InputStream;)Ljavax/mail/internet/MimeMessage;
    .locals 1
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljavax/mail/MessagingException;
        }
    .end annotation

    .prologue
    .line 112
    new-instance v0, Ljavax/mail/internet/MimeMessage;

    invoke-direct {v0, p0, p1}, Ljavax/mail/internet/MimeMessage;-><init>(Ljavax/mail/Session;Ljava/io/InputStream;)V

    return-object v0
.end method

.method public static a(Ljavax/mail/Session;Ljava/lang/String;)Ljavax/mail/internet/MimeMessage;
    .locals 3
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljavax/mail/MessagingException;,
            Ljava/io/IOException;
        }
    .end annotation

    .prologue
    .line 127
    const/4 v2, 0x0

    .line 131
    :try_start_0
    invoke-virtual {p1}, Ljava/lang/String;->getBytes()[B

    move-result-object v0

    .line 132
    new-instance v1, Ljava/io/ByteArrayInputStream;

    invoke-direct {v1, v0}, Ljava/io/ByteArrayInputStream;-><init>([B)V
    :try_end_0
    .catchall {:try_start_0 .. :try_end_0} :catchall_0

    .line 133
    :try_start_1
    invoke-static {p0, v1}, Lorg/apache/commons/mail/b/b;->a(Ljavax/mail/Session;Ljava/io/InputStream;)Ljavax/mail/internet/MimeMessage;
    :try_end_1
    .catchall {:try_start_1 .. :try_end_1} :catchall_1

    move-result-object v0

    .line 137
    if-eqz v1, :cond_0

    .line 139
    invoke-virtual {v1}, Ljava/io/ByteArrayInputStream;->close()V

    :cond_0
    return-object v0

    .line 137
    :catchall_0
    move-exception v0

    move-object v1, v2

    :goto_0
    if-eqz v1, :cond_1

    .line 139
    invoke-virtual {v1}, Ljava/io/ByteArrayInputStream;->close()V

    :cond_1
    throw v0

    .line 137
    :catchall_1
    move-exception v0

    goto :goto_0
.end method

.method public static a(Ljavax/mail/Session;[B)Ljavax/mail/internet/MimeMessage;
    .locals 3
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljavax/mail/MessagingException;,
            Ljava/io/IOException;
        }
    .end annotation

    .prologue
    .line 57
    const/4 v2, 0x0

    .line 61
    :try_start_0
    new-instance v1, Ljava/io/ByteArrayInputStream;

    invoke-direct {v1, p1}, Ljava/io/ByteArrayInputStream;-><init>([B)V
    :try_end_0
    .catchall {:try_start_0 .. :try_end_0} :catchall_0

    .line 62
    :try_start_1
    new-instance v0, Ljavax/mail/internet/MimeMessage;

    invoke-direct {v0, p0, v1}, Ljavax/mail/internet/MimeMessage;-><init>(Ljavax/mail/Session;Ljava/io/InputStream;)V
    :try_end_1
    .catchall {:try_start_1 .. :try_end_1} :catchall_1

    .line 66
    if-eqz v1, :cond_0

    .line 68
    invoke-virtual {v1}, Ljava/io/ByteArrayInputStream;->close()V

    :cond_0
    return-object v0

    .line 66
    :catchall_0
    move-exception v0

    move-object v1, v2

    :goto_0
    if-eqz v1, :cond_1

    .line 68
    invoke-virtual {v1}, Ljava/io/ByteArrayInputStream;->close()V

    :cond_1
    throw v0

    .line 66
    :catchall_1
    move-exception v0

    goto :goto_0
.end method

.method public static a(Ljavax/mail/internet/MimeMessage;Ljava/io/File;)V
    .locals 4
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljavax/mail/MessagingException;,
            Ljava/io/IOException;
        }
    .end annotation

    .prologue
    const/4 v1, 0x0

    .line 156
    .line 160
    :try_start_0
    invoke-virtual {p1}, Ljava/io/File;->getParentFile()Ljava/io/File;

    move-result-object v0

    invoke-virtual {v0}, Ljava/io/File;->exists()Z

    move-result v0

    if-nez v0, :cond_1

    invoke-virtual {p1}, Ljava/io/File;->getParentFile()Ljava/io/File;

    move-result-object v0

    invoke-virtual {v0}, Ljava/io/File;->mkdirs()Z

    move-result v0

    if-nez v0, :cond_1

    .line 162
    new-instance v0, Ljava/io/IOException;

    new-instance v2, Ljava/lang/StringBuilder;

    invoke-direct {v2}, Ljava/lang/StringBuilder;-><init>()V

    const-string v3, "Failed to create the following parent directories: "

    invoke-virtual {v2, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    invoke-virtual {p1}, Ljava/io/File;->getParentFile()Ljava/io/File;

    move-result-object v3

    invoke-virtual {v2, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/Object;)Ljava/lang/StringBuilder;

    move-result-object v2

    invoke-virtual {v2}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v2

    invoke-direct {v0, v2}, Ljava/io/IOException;-><init>(Ljava/lang/String;)V

    throw v0
    :try_end_0
    .catchall {:try_start_0 .. :try_end_0} :catchall_0

    .line 175
    :catchall_0
    move-exception v0

    :goto_0
    if-eqz v1, :cond_0

    .line 179
    :try_start_1
    invoke-virtual {v1}, Ljava/io/FileOutputStream;->close()V
    :try_end_1
    .catch Ljava/lang/Exception; {:try_start_1 .. :try_end_1} :catch_1

    .line 184
    :cond_0
    :goto_1
    throw v0

    .line 167
    :cond_1
    :try_start_2
    new-instance v2, Ljava/io/FileOutputStream;

    invoke-direct {v2, p1}, Ljava/io/FileOutputStream;-><init>(Ljava/io/File;)V
    :try_end_2
    .catchall {:try_start_2 .. :try_end_2} :catchall_0

    .line 168
    :try_start_3
    invoke-virtual {p0, v2}, Ljavax/mail/internet/MimeMessage;->writeTo(Ljava/io/OutputStream;)V

    .line 169
    invoke-virtual {v2}, Ljava/io/FileOutputStream;->flush()V

    .line 170
    invoke-virtual {v2}, Ljava/io/FileOutputStream;->close()V
    :try_end_3
    .catchall {:try_start_3 .. :try_end_3} :catchall_1

    .line 171
    const/4 v0, 0x0

    .line 175
    if-eqz v1, :cond_2

    .line 179
    :try_start_4
    invoke-virtual {v0}, Ljava/io/FileOutputStream;->close()V
    :try_end_4
    .catch Ljava/lang/Exception; {:try_start_4 .. :try_end_4} :catch_0

    .line 187
    :cond_2
    :goto_2
    return-void

    .line 181
    :catch_0
    move-exception v0

    .line 183
    invoke-virtual {v0}, Ljava/lang/Exception;->printStackTrace()V

    goto :goto_2

    .line 181
    :catch_1
    move-exception v1

    .line 183
    invoke-virtual {v1}, Ljava/lang/Exception;->printStackTrace()V

    goto :goto_1

    .line 175
    :catchall_1
    move-exception v0

    move-object v1, v2

    goto :goto_0
.end method
