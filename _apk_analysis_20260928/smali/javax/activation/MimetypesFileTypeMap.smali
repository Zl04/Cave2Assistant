.class public Ljavax/activation/MimetypesFileTypeMap;
.super Ljavax/activation/FileTypeMap;
.source "SourceFile"


# static fields
.field private static final PROG:I

.field private static defDB:Lcom/sun/activation/registries/MimeTypeFile;

.field private static defaultType:Ljava/lang/String;


# instance fields
.field private DB:[Lcom/sun/activation/registries/MimeTypeFile;


# direct methods
.method static constructor <clinit>()V
    .locals 1

    .prologue
    .line 89
    const/4 v0, 0x0

    sput-object v0, Ljavax/activation/MimetypesFileTypeMap;->defDB:Lcom/sun/activation/registries/MimeTypeFile;

    .line 93
    const-string v0, "application/octet-stream"

    sput-object v0, Ljavax/activation/MimetypesFileTypeMap;->defaultType:Ljava/lang/String;

    .line 82
    return-void
.end method

.method public constructor <init>()V
    .locals 3

    .prologue
    .line 98
    invoke-direct {p0}, Ljavax/activation/FileTypeMap;-><init>()V

    .line 99
    new-instance v0, Ljava/util/Vector;

    const/4 v1, 0x5

    invoke-direct {v0, v1}, Ljava/util/Vector;-><init>(I)V

    .line 101
    const/4 v1, 0x0

    invoke-virtual {v0, v1}, Ljava/util/Vector;->addElement(Ljava/lang/Object;)V

    .line 103
    const-string v1, "MimetypesFileTypeMap: load HOME"

    invoke-static {v1}, Lcom/sun/activation/registries/LogSupport;->log(Ljava/lang/String;)V

    .line 105
    :try_start_0
    const-string v1, "user.home"

    invoke-static {v1}, Ljava/lang/System;->getProperty(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v1

    .line 107
    if-eqz v1, :cond_0

    .line 108
    new-instance v2, Ljava/lang/StringBuilder;

    invoke-static {v1}, Ljava/lang/String;->valueOf(Ljava/lang/Object;)Ljava/lang/String;

    move-result-object v1

    invoke-direct {v2, v1}, Ljava/lang/StringBuilder;-><init>(Ljava/lang/String;)V

    sget-object v1, Ljava/io/File;->separator:Ljava/lang/String;

    invoke-virtual {v2, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    const-string v2, ".mime.types"

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v1

    .line 109
    invoke-direct {p0, v1}, Ljavax/activation/MimetypesFileTypeMap;->loadFile(Ljava/lang/String;)Lcom/sun/activation/registries/MimeTypeFile;

    move-result-object v1

    .line 110
    if-eqz v1, :cond_0

    .line 111
    invoke-virtual {v0, v1}, Ljava/util/Vector;->addElement(Ljava/lang/Object;)V
    :try_end_0
    .catch Ljava/lang/SecurityException; {:try_start_0 .. :try_end_0} :catch_1

    .line 115
    :cond_0
    :goto_0
    const-string v1, "MimetypesFileTypeMap: load SYS"

    invoke-static {v1}, Lcom/sun/activation/registries/LogSupport;->log(Ljava/lang/String;)V

    .line 118
    :try_start_1
    new-instance v1, Ljava/lang/StringBuilder;

    const-string v2, "java.home"

    invoke-static {v2}, Ljava/lang/System;->getProperty(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v2

    invoke-static {v2}, Ljava/lang/String;->valueOf(Ljava/lang/Object;)Ljava/lang/String;

    move-result-object v2

    invoke-direct {v1, v2}, Ljava/lang/StringBuilder;-><init>(Ljava/lang/String;)V

    .line 119
    sget-object v2, Ljava/io/File;->separator:Ljava/lang/String;

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    const-string v2, "lib"

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    sget-object v2, Ljava/io/File;->separator:Ljava/lang/String;

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    const-string v2, "mime.types"

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    .line 118
    invoke-virtual {v1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v1

    .line 120
    invoke-direct {p0, v1}, Ljavax/activation/MimetypesFileTypeMap;->loadFile(Ljava/lang/String;)Lcom/sun/activation/registries/MimeTypeFile;

    move-result-object v1

    .line 121
    if-eqz v1, :cond_1

    .line 122
    invoke-virtual {v0, v1}, Ljava/util/Vector;->addElement(Ljava/lang/Object;)V
    :try_end_1
    .catch Ljava/lang/SecurityException; {:try_start_1 .. :try_end_1} :catch_0

    .line 125
    :cond_1
    :goto_1
    const-string v1, "MimetypesFileTypeMap: load JAR"

    invoke-static {v1}, Lcom/sun/activation/registries/LogSupport;->log(Ljava/lang/String;)V

    .line 127
    const-string v1, "mime.types"

    invoke-direct {p0, v0, v1}, Ljavax/activation/MimetypesFileTypeMap;->loadAllResources(Ljava/util/Vector;Ljava/lang/String;)V

    .line 129
    const-string v1, "MimetypesFileTypeMap: load DEF"

    invoke-static {v1}, Lcom/sun/activation/registries/LogSupport;->log(Ljava/lang/String;)V

    .line 130
    const-class v1, Ljavax/activation/MimetypesFileTypeMap;

    monitor-enter v1

    .line 132
    :try_start_2
    sget-object v2, Ljavax/activation/MimetypesFileTypeMap;->defDB:Lcom/sun/activation/registries/MimeTypeFile;

    if-nez v2, :cond_2

    .line 133
    const-string v2, "/mimetypes.default"

    invoke-direct {p0, v2}, Ljavax/activation/MimetypesFileTypeMap;->loadResource(Ljava/lang/String;)Lcom/sun/activation/registries/MimeTypeFile;

    move-result-object v2

    sput-object v2, Ljavax/activation/MimetypesFileTypeMap;->defDB:Lcom/sun/activation/registries/MimeTypeFile;

    .line 130
    :cond_2
    monitor-exit v1
    :try_end_2
    .catchall {:try_start_2 .. :try_end_2} :catchall_0

    .line 136
    sget-object v1, Ljavax/activation/MimetypesFileTypeMap;->defDB:Lcom/sun/activation/registries/MimeTypeFile;

    if-eqz v1, :cond_3

    .line 137
    sget-object v1, Ljavax/activation/MimetypesFileTypeMap;->defDB:Lcom/sun/activation/registries/MimeTypeFile;

    invoke-virtual {v0, v1}, Ljava/util/Vector;->addElement(Ljava/lang/Object;)V

    .line 139
    :cond_3
    invoke-virtual {v0}, Ljava/util/Vector;->size()I

    move-result v1

    new-array v1, v1, [Lcom/sun/activation/registries/MimeTypeFile;

    iput-object v1, p0, Ljavax/activation/MimetypesFileTypeMap;->DB:[Lcom/sun/activation/registries/MimeTypeFile;

    .line 140
    iget-object v1, p0, Ljavax/activation/MimetypesFileTypeMap;->DB:[Lcom/sun/activation/registries/MimeTypeFile;

    invoke-virtual {v0, v1}, Ljava/util/Vector;->copyInto([Ljava/lang/Object;)V

    .line 141
    return-void

    .line 130
    :catchall_0
    move-exception v0

    :try_start_3
    monitor-exit v1
    :try_end_3
    .catchall {:try_start_3 .. :try_end_3} :catchall_0

    throw v0

    .line 123
    :catch_0
    move-exception v1

    goto :goto_1

    .line 113
    :catch_1
    move-exception v1

    goto :goto_0
.end method

.method public constructor <init>(Ljava/io/InputStream;)V
    .locals 3

    .prologue
    .line 277
    invoke-direct {p0}, Ljavax/activation/MimetypesFileTypeMap;-><init>()V

    .line 279
    :try_start_0
    iget-object v0, p0, Ljavax/activation/MimetypesFileTypeMap;->DB:[Lcom/sun/activation/registries/MimeTypeFile;

    const/4 v1, 0x0

    new-instance v2, Lcom/sun/activation/registries/MimeTypeFile;

    invoke-direct {v2, p1}, Lcom/sun/activation/registries/MimeTypeFile;-><init>(Ljava/io/InputStream;)V

    aput-object v2, v0, v1
    :try_end_0
    .catch Ljava/io/IOException; {:try_start_0 .. :try_end_0} :catch_0

    .line 283
    :goto_0
    return-void

    .line 280
    :catch_0
    move-exception v0

    goto :goto_0
.end method

.method public constructor <init>(Ljava/lang/String;)V
    .locals 3
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljava/io/IOException;
        }
    .end annotation

    .prologue
    .line 266
    invoke-direct {p0}, Ljavax/activation/MimetypesFileTypeMap;-><init>()V

    .line 267
    iget-object v0, p0, Ljavax/activation/MimetypesFileTypeMap;->DB:[Lcom/sun/activation/registries/MimeTypeFile;

    const/4 v1, 0x0

    new-instance v2, Lcom/sun/activation/registries/MimeTypeFile;

    invoke-direct {v2, p1}, Lcom/sun/activation/registries/MimeTypeFile;-><init>(Ljava/lang/String;)V

    aput-object v2, v0, v1

    .line 268
    return-void
.end method

.method private loadAllResources(Ljava/util/Vector;Ljava/lang/String;)V
    .locals 9

    .prologue
    const/4 v2, 0x0

    .line 180
    .line 185
    :try_start_0
    invoke-static {}, Ljavax/activation/SecuritySupport;->getContextClassLoader()Ljava/lang/ClassLoader;

    move-result-object v0

    .line 186
    if-nez v0, :cond_0

    .line 187
    invoke-virtual {p0}, Ljava/lang/Object;->getClass()Ljava/lang/Class;

    move-result-object v0

    invoke-virtual {v0}, Ljava/lang/Class;->getClassLoader()Ljava/lang/ClassLoader;

    move-result-object v0

    .line 188
    :cond_0
    if-eqz v0, :cond_4

    .line 189
    invoke-static {v0, p2}, Ljavax/activation/SecuritySupport;->getResources(Ljava/lang/ClassLoader;Ljava/lang/String;)[Ljava/net/URL;

    move-result-object v0

    move-object v4, v0

    .line 192
    :goto_0
    if-eqz v4, :cond_2

    .line 193
    invoke-static {}, Lcom/sun/activation/registries/LogSupport;->isLoggable()Z

    move-result v0

    if-eqz v0, :cond_1

    .line 194
    const-string v0, "MimetypesFileTypeMap: getResources"

    invoke-static {v0}, Lcom/sun/activation/registries/LogSupport;->log(Ljava/lang/String;)V

    :cond_1
    move v3, v2

    .line 195
    :goto_1
    array-length v0, v4
    :try_end_0
    .catch Ljava/lang/Exception; {:try_start_0 .. :try_end_0} :catch_4

    if-lt v3, v0, :cond_5

    .line 237
    :cond_2
    :goto_2
    if-nez v2, :cond_3

    .line 238
    const-string v0, "MimetypesFileTypeMap: !anyLoaded"

    invoke-static {v0}, Lcom/sun/activation/registries/LogSupport;->log(Ljava/lang/String;)V

    .line 239
    new-instance v0, Ljava/lang/StringBuilder;

    const-string v1, "/"

    invoke-direct {v0, v1}, Ljava/lang/StringBuilder;-><init>(Ljava/lang/String;)V

    invoke-virtual {v0, p2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-virtual {v0}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v0

    invoke-direct {p0, v0}, Ljavax/activation/MimetypesFileTypeMap;->loadResource(Ljava/lang/String;)Lcom/sun/activation/registries/MimeTypeFile;

    move-result-object v0

    .line 240
    if-eqz v0, :cond_3

    .line 241
    invoke-virtual {p1, v0}, Ljava/util/Vector;->addElement(Ljava/lang/Object;)V

    .line 243
    :cond_3
    return-void

    .line 191
    :cond_4
    :try_start_1
    invoke-static {p2}, Ljavax/activation/SecuritySupport;->getSystemResources(Ljava/lang/String;)[Ljava/net/URL;

    move-result-object v0

    move-object v4, v0

    goto :goto_0

    .line 196
    :cond_5
    aget-object v5, v4, v3

    .line 197
    const/4 v1, 0x0

    .line 198
    invoke-static {}, Lcom/sun/activation/registries/LogSupport;->isLoggable()Z

    move-result v0

    if-eqz v0, :cond_6

    .line 199
    new-instance v0, Ljava/lang/StringBuilder;

    const-string v6, "MimetypesFileTypeMap: URL "

    invoke-direct {v0, v6}, Ljava/lang/StringBuilder;-><init>(Ljava/lang/String;)V

    invoke-virtual {v0, v5}, Ljava/lang/StringBuilder;->append(Ljava/lang/Object;)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-virtual {v0}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v0

    invoke-static {v0}, Lcom/sun/activation/registries/LogSupport;->log(Ljava/lang/String;)V
    :try_end_1
    .catch Ljava/lang/Exception; {:try_start_1 .. :try_end_1} :catch_4

    .line 201
    :cond_6
    :try_start_2
    invoke-static {v5}, Ljavax/activation/SecuritySupport;->openStream(Ljava/net/URL;)Ljava/io/InputStream;
    :try_end_2
    .catch Ljava/io/IOException; {:try_start_2 .. :try_end_2} :catch_0
    .catch Ljava/lang/SecurityException; {:try_start_2 .. :try_end_2} :catch_2
    .catchall {:try_start_2 .. :try_end_2} :catchall_0

    move-result-object v1

    .line 202
    if-eqz v1, :cond_8

    .line 203
    :try_start_3
    new-instance v0, Lcom/sun/activation/registries/MimeTypeFile;

    invoke-direct {v0, v1}, Lcom/sun/activation/registries/MimeTypeFile;-><init>(Ljava/io/InputStream;)V

    invoke-virtual {p1, v0}, Ljava/util/Vector;->addElement(Ljava/lang/Object;)V

    .line 204
    const/4 v2, 0x1

    .line 205
    invoke-static {}, Lcom/sun/activation/registries/LogSupport;->isLoggable()Z

    move-result v0

    if-eqz v0, :cond_c

    .line 206
    new-instance v0, Ljava/lang/StringBuilder;

    const-string v6, "MimetypesFileTypeMap: successfully loaded mime types from URL: "

    invoke-direct {v0, v6}, Ljava/lang/StringBuilder;-><init>(Ljava/lang/String;)V

    .line 208
    invoke-virtual {v0, v5}, Ljava/lang/StringBuilder;->append(Ljava/lang/Object;)Ljava/lang/StringBuilder;

    move-result-object v0

    .line 206
    invoke-virtual {v0}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v0

    invoke-static {v0}, Lcom/sun/activation/registries/LogSupport;->log(Ljava/lang/String;)V
    :try_end_3
    .catch Ljava/io/IOException; {:try_start_3 .. :try_end_3} :catch_9
    .catch Ljava/lang/SecurityException; {:try_start_3 .. :try_end_3} :catch_8
    .catchall {:try_start_3 .. :try_end_3} :catchall_0

    move v0, v2

    .line 225
    :goto_3
    if-eqz v1, :cond_7

    .line 226
    :try_start_4
    invoke-virtual {v1}, Ljava/io/InputStream;->close()V
    :try_end_4
    .catch Ljava/io/IOException; {:try_start_4 .. :try_end_4} :catch_6
    .catch Ljava/lang/Exception; {:try_start_4 .. :try_end_4} :catch_7

    .line 195
    :cond_7
    :goto_4
    add-int/lit8 v2, v3, 0x1

    move v3, v2

    move v2, v0

    goto :goto_1

    .line 210
    :cond_8
    :try_start_5
    invoke-static {}, Lcom/sun/activation/registries/LogSupport;->isLoggable()Z

    move-result v0

    if-eqz v0, :cond_c

    .line 211
    new-instance v0, Ljava/lang/StringBuilder;

    const-string v6, "MimetypesFileTypeMap: not loading mime types from URL: "

    invoke-direct {v0, v6}, Ljava/lang/StringBuilder;-><init>(Ljava/lang/String;)V

    .line 213
    invoke-virtual {v0, v5}, Ljava/lang/StringBuilder;->append(Ljava/lang/Object;)Ljava/lang/StringBuilder;

    move-result-object v0

    .line 211
    invoke-virtual {v0}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v0

    invoke-static {v0}, Lcom/sun/activation/registries/LogSupport;->log(Ljava/lang/String;)V
    :try_end_5
    .catch Ljava/io/IOException; {:try_start_5 .. :try_end_5} :catch_9
    .catch Ljava/lang/SecurityException; {:try_start_5 .. :try_end_5} :catch_8
    .catchall {:try_start_5 .. :try_end_5} :catchall_0

    move v0, v2

    goto :goto_3

    .line 215
    :catch_0
    move-exception v0

    move-object v8, v0

    move v0, v2

    move-object v2, v1

    move-object v1, v8

    .line 216
    :goto_5
    :try_start_6
    invoke-static {}, Lcom/sun/activation/registries/LogSupport;->isLoggable()Z

    move-result v6

    if-eqz v6, :cond_9

    .line 217
    new-instance v6, Ljava/lang/StringBuilder;

    const-string v7, "MimetypesFileTypeMap: can\'t load "

    invoke-direct {v6, v7}, Ljava/lang/StringBuilder;-><init>(Ljava/lang/String;)V

    .line 218
    invoke-virtual {v6, v5}, Ljava/lang/StringBuilder;->append(Ljava/lang/Object;)Ljava/lang/StringBuilder;

    move-result-object v5

    .line 217
    invoke-virtual {v5}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v5

    invoke-static {v5, v1}, Lcom/sun/activation/registries/LogSupport;->log(Ljava/lang/String;Ljava/lang/Throwable;)V
    :try_end_6
    .catchall {:try_start_6 .. :try_end_6} :catchall_1

    .line 225
    :cond_9
    if-eqz v2, :cond_7

    .line 226
    :try_start_7
    invoke-virtual {v2}, Ljava/io/InputStream;->close()V
    :try_end_7
    .catch Ljava/io/IOException; {:try_start_7 .. :try_end_7} :catch_1
    .catch Ljava/lang/Exception; {:try_start_7 .. :try_end_7} :catch_7

    goto :goto_4

    .line 227
    :catch_1
    move-exception v1

    goto :goto_4

    .line 219
    :catch_2
    move-exception v0

    move-object v8, v0

    move v0, v2

    move-object v2, v1

    move-object v1, v8

    .line 220
    :goto_6
    :try_start_8
    invoke-static {}, Lcom/sun/activation/registries/LogSupport;->isLoggable()Z

    move-result v6

    if-eqz v6, :cond_a

    .line 221
    new-instance v6, Ljava/lang/StringBuilder;

    const-string v7, "MimetypesFileTypeMap: can\'t load "

    invoke-direct {v6, v7}, Ljava/lang/StringBuilder;-><init>(Ljava/lang/String;)V

    .line 222
    invoke-virtual {v6, v5}, Ljava/lang/StringBuilder;->append(Ljava/lang/Object;)Ljava/lang/StringBuilder;

    move-result-object v5

    .line 221
    invoke-virtual {v5}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v5

    invoke-static {v5, v1}, Lcom/sun/activation/registries/LogSupport;->log(Ljava/lang/String;Ljava/lang/Throwable;)V
    :try_end_8
    .catchall {:try_start_8 .. :try_end_8} :catchall_1

    .line 225
    :cond_a
    if-eqz v2, :cond_7

    .line 226
    :try_start_9
    invoke-virtual {v2}, Ljava/io/InputStream;->close()V
    :try_end_9
    .catch Ljava/io/IOException; {:try_start_9 .. :try_end_9} :catch_3
    .catch Ljava/lang/Exception; {:try_start_9 .. :try_end_9} :catch_7

    goto :goto_4

    .line 227
    :catch_3
    move-exception v1

    goto :goto_4

    .line 223
    :catchall_0
    move-exception v0

    .line 225
    :goto_7
    if-eqz v1, :cond_b

    .line 226
    :try_start_a
    invoke-virtual {v1}, Ljava/io/InputStream;->close()V
    :try_end_a
    .catch Ljava/io/IOException; {:try_start_a .. :try_end_a} :catch_5
    .catch Ljava/lang/Exception; {:try_start_a .. :try_end_a} :catch_4

    .line 228
    :cond_b
    :goto_8
    :try_start_b
    throw v0
    :try_end_b
    .catch Ljava/lang/Exception; {:try_start_b .. :try_end_b} :catch_4

    .line 231
    :catch_4
    move-exception v0

    .line 232
    :goto_9
    invoke-static {}, Lcom/sun/activation/registries/LogSupport;->isLoggable()Z

    move-result v1

    if-eqz v1, :cond_2

    .line 233
    new-instance v1, Ljava/lang/StringBuilder;

    const-string v3, "MimetypesFileTypeMap: can\'t load "

    invoke-direct {v1, v3}, Ljava/lang/StringBuilder;-><init>(Ljava/lang/String;)V

    invoke-virtual {v1, p2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v1

    invoke-static {v1, v0}, Lcom/sun/activation/registries/LogSupport;->log(Ljava/lang/String;Ljava/lang/Throwable;)V

    goto/16 :goto_2

    .line 227
    :catch_5
    move-exception v1

    goto :goto_8

    :catch_6
    move-exception v1

    goto/16 :goto_4

    .line 231
    :catch_7
    move-exception v1

    move v2, v0

    move-object v0, v1

    goto :goto_9

    .line 223
    :catchall_1
    move-exception v1

    move-object v8, v1

    move-object v1, v2

    move v2, v0

    move-object v0, v8

    goto :goto_7

    .line 219
    :catch_8
    move-exception v0

    move-object v8, v0

    move v0, v2

    move-object v2, v1

    move-object v1, v8

    goto :goto_6

    .line 215
    :catch_9
    move-exception v0

    move-object v8, v0

    move v0, v2

    move-object v2, v1

    move-object v1, v8

    goto/16 :goto_5

    :cond_c
    move v0, v2

    goto/16 :goto_3
.end method

.method private loadFile(Ljava/lang/String;)Lcom/sun/activation/registries/MimeTypeFile;
    .locals 2

    .prologue
    .line 249
    const/4 v1, 0x0

    .line 252
    :try_start_0
    new-instance v0, Lcom/sun/activation/registries/MimeTypeFile;

    invoke-direct {v0, p1}, Lcom/sun/activation/registries/MimeTypeFile;-><init>(Ljava/lang/String;)V
    :try_end_0
    .catch Ljava/io/IOException; {:try_start_0 .. :try_end_0} :catch_0

    .line 256
    :goto_0
    return-object v0

    .line 253
    :catch_0
    move-exception v0

    move-object v0, v1

    goto :goto_0
.end method

.method private loadResource(Ljava/lang/String;)Lcom/sun/activation/registries/MimeTypeFile;
    .locals 5

    .prologue
    const/4 v1, 0x0

    .line 147
    .line 149
    :try_start_0
    invoke-virtual {p0}, Ljava/lang/Object;->getClass()Ljava/lang/Class;

    move-result-object v0

    invoke-static {v0, p1}, Ljavax/activation/SecuritySupport;->getResourceAsStream(Ljava/lang/Class;Ljava/lang/String;)Ljava/io/InputStream;
    :try_end_0
    .catch Ljava/io/IOException; {:try_start_0 .. :try_end_0} :catch_0
    .catch Ljava/lang/SecurityException; {:try_start_0 .. :try_end_0} :catch_2
    .catchall {:try_start_0 .. :try_end_0} :catchall_0

    move-result-object v2

    .line 150
    if-eqz v2, :cond_2

    .line 151
    :try_start_1
    new-instance v0, Lcom/sun/activation/registries/MimeTypeFile;

    invoke-direct {v0, v2}, Lcom/sun/activation/registries/MimeTypeFile;-><init>(Ljava/io/InputStream;)V

    .line 152
    invoke-static {}, Lcom/sun/activation/registries/LogSupport;->isLoggable()Z

    move-result v3

    if-eqz v3, :cond_0

    .line 153
    new-instance v3, Ljava/lang/StringBuilder;

    const-string v4, "MimetypesFileTypeMap: successfully loaded mime types file: "

    invoke-direct {v3, v4}, Ljava/lang/StringBuilder;-><init>(Ljava/lang/String;)V

    .line 154
    invoke-virtual {v3, p1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v3

    .line 153
    invoke-virtual {v3}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v3

    invoke-static {v3}, Lcom/sun/activation/registries/LogSupport;->log(Ljava/lang/String;)V
    :try_end_1
    .catch Ljava/io/IOException; {:try_start_1 .. :try_end_1} :catch_8
    .catch Ljava/lang/SecurityException; {:try_start_1 .. :try_end_1} :catch_7
    .catchall {:try_start_1 .. :try_end_1} :catchall_1

    .line 169
    :cond_0
    if-eqz v2, :cond_1

    .line 170
    :try_start_2
    invoke-virtual {v2}, Ljava/io/InputStream;->close()V
    :try_end_2
    .catch Ljava/io/IOException; {:try_start_2 .. :try_end_2} :catch_4

    .line 173
    :cond_1
    :goto_0
    return-object v0

    .line 157
    :cond_2
    :try_start_3
    invoke-static {}, Lcom/sun/activation/registries/LogSupport;->isLoggable()Z

    move-result v0

    if-eqz v0, :cond_3

    .line 158
    new-instance v0, Ljava/lang/StringBuilder;

    const-string v3, "MimetypesFileTypeMap: not loading mime types file: "

    invoke-direct {v0, v3}, Ljava/lang/StringBuilder;-><init>(Ljava/lang/String;)V

    .line 159
    invoke-virtual {v0, p1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    .line 158
    invoke-virtual {v0}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v0

    invoke-static {v0}, Lcom/sun/activation/registries/LogSupport;->log(Ljava/lang/String;)V
    :try_end_3
    .catch Ljava/io/IOException; {:try_start_3 .. :try_end_3} :catch_8
    .catch Ljava/lang/SecurityException; {:try_start_3 .. :try_end_3} :catch_7
    .catchall {:try_start_3 .. :try_end_3} :catchall_1

    .line 169
    :cond_3
    if-eqz v2, :cond_4

    .line 170
    :try_start_4
    invoke-virtual {v2}, Ljava/io/InputStream;->close()V
    :try_end_4
    .catch Ljava/io/IOException; {:try_start_4 .. :try_end_4} :catch_6

    :cond_4
    :goto_1
    move-object v0, v1

    .line 173
    goto :goto_0

    .line 161
    :catch_0
    move-exception v0

    move-object v2, v1

    .line 162
    :goto_2
    :try_start_5
    invoke-static {}, Lcom/sun/activation/registries/LogSupport;->isLoggable()Z

    move-result v3

    if-eqz v3, :cond_5

    .line 163
    new-instance v3, Ljava/lang/StringBuilder;

    const-string v4, "MimetypesFileTypeMap: can\'t load "

    invoke-direct {v3, v4}, Ljava/lang/StringBuilder;-><init>(Ljava/lang/String;)V

    invoke-virtual {v3, p1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v3

    invoke-virtual {v3}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v3

    invoke-static {v3, v0}, Lcom/sun/activation/registries/LogSupport;->log(Ljava/lang/String;Ljava/lang/Throwable;)V
    :try_end_5
    .catchall {:try_start_5 .. :try_end_5} :catchall_1

    .line 169
    :cond_5
    if-eqz v2, :cond_4

    .line 170
    :try_start_6
    invoke-virtual {v2}, Ljava/io/InputStream;->close()V
    :try_end_6
    .catch Ljava/io/IOException; {:try_start_6 .. :try_end_6} :catch_1

    goto :goto_1

    .line 171
    :catch_1
    move-exception v0

    goto :goto_1

    .line 164
    :catch_2
    move-exception v0

    move-object v2, v1

    .line 165
    :goto_3
    :try_start_7
    invoke-static {}, Lcom/sun/activation/registries/LogSupport;->isLoggable()Z

    move-result v3

    if-eqz v3, :cond_6

    .line 166
    new-instance v3, Ljava/lang/StringBuilder;

    const-string v4, "MimetypesFileTypeMap: can\'t load "

    invoke-direct {v3, v4}, Ljava/lang/StringBuilder;-><init>(Ljava/lang/String;)V

    invoke-virtual {v3, p1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v3

    invoke-virtual {v3}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v3

    invoke-static {v3, v0}, Lcom/sun/activation/registries/LogSupport;->log(Ljava/lang/String;Ljava/lang/Throwable;)V
    :try_end_7
    .catchall {:try_start_7 .. :try_end_7} :catchall_1

    .line 169
    :cond_6
    if-eqz v2, :cond_4

    .line 170
    :try_start_8
    invoke-virtual {v2}, Ljava/io/InputStream;->close()V
    :try_end_8
    .catch Ljava/io/IOException; {:try_start_8 .. :try_end_8} :catch_3

    goto :goto_1

    .line 171
    :catch_3
    move-exception v0

    goto :goto_1

    .line 167
    :catchall_0
    move-exception v0

    move-object v2, v1

    .line 169
    :goto_4
    if-eqz v2, :cond_7

    .line 170
    :try_start_9
    invoke-virtual {v2}, Ljava/io/InputStream;->close()V
    :try_end_9
    .catch Ljava/io/IOException; {:try_start_9 .. :try_end_9} :catch_5

    .line 172
    :cond_7
    :goto_5
    throw v0

    .line 171
    :catch_4
    move-exception v1

    goto :goto_0

    :catch_5
    move-exception v1

    goto :goto_5

    :catch_6
    move-exception v0

    goto :goto_1

    .line 167
    :catchall_1
    move-exception v0

    goto :goto_4

    .line 164
    :catch_7
    move-exception v0

    goto :goto_3

    .line 161
    :catch_8
    move-exception v0

    goto :goto_2
.end method


# virtual methods
.method public declared-synchronized addMimeTypes(Ljava/lang/String;)V
    .locals 3

    .prologue
    .line 292
    monitor-enter p0

    :try_start_0
    iget-object v0, p0, Ljavax/activation/MimetypesFileTypeMap;->DB:[Lcom/sun/activation/registries/MimeTypeFile;

    const/4 v1, 0x0

    aget-object v0, v0, v1

    if-nez v0, :cond_0

    .line 293
    iget-object v0, p0, Ljavax/activation/MimetypesFileTypeMap;->DB:[Lcom/sun/activation/registries/MimeTypeFile;

    const/4 v1, 0x0

    new-instance v2, Lcom/sun/activation/registries/MimeTypeFile;

    invoke-direct {v2}, Lcom/sun/activation/registries/MimeTypeFile;-><init>()V

    aput-object v2, v0, v1

    .line 295
    :cond_0
    iget-object v0, p0, Ljavax/activation/MimetypesFileTypeMap;->DB:[Lcom/sun/activation/registries/MimeTypeFile;

    const/4 v1, 0x0

    aget-object v0, v0, v1

    invoke-virtual {v0, p1}, Lcom/sun/activation/registries/MimeTypeFile;->appendToRegistry(Ljava/lang/String;)V
    :try_end_0
    .catchall {:try_start_0 .. :try_end_0} :catchall_0

    .line 296
    monitor-exit p0

    return-void

    .line 292
    :catchall_0
    move-exception v0

    monitor-exit p0

    throw v0
.end method

.method public getContentType(Ljava/io/File;)Ljava/lang/String;
    .locals 1

    .prologue
    .line 307
    invoke-virtual {p1}, Ljava/io/File;->getName()Ljava/lang/String;

    move-result-object v0

    invoke-virtual {p0, v0}, Ljavax/activation/MimetypesFileTypeMap;->getContentType(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v0

    return-object v0
.end method

.method public declared-synchronized getContentType(Ljava/lang/String;)Ljava/lang/String;
    .locals 3

    .prologue
    .line 320
    monitor-enter p0

    :try_start_0
    const-string v0, "."

    invoke-virtual {p1, v0}, Ljava/lang/String;->lastIndexOf(Ljava/lang/String;)I

    move-result v0

    .line 322
    if-gez v0, :cond_0

    .line 323
    sget-object v0, Ljavax/activation/MimetypesFileTypeMap;->defaultType:Ljava/lang/String;
    :try_end_0
    .catchall {:try_start_0 .. :try_end_0} :catchall_0

    .line 336
    :goto_0
    monitor-exit p0

    return-object v0

    .line 325
    :cond_0
    add-int/lit8 v0, v0, 0x1

    :try_start_1
    invoke-virtual {p1, v0}, Ljava/lang/String;->substring(I)Ljava/lang/String;

    move-result-object v2

    .line 326
    invoke-virtual {v2}, Ljava/lang/String;->length()I

    move-result v0

    if-nez v0, :cond_1

    .line 327
    sget-object v0, Ljavax/activation/MimetypesFileTypeMap;->defaultType:Ljava/lang/String;

    goto :goto_0

    .line 329
    :cond_1
    const/4 v0, 0x0

    move v1, v0

    :goto_1
    iget-object v0, p0, Ljavax/activation/MimetypesFileTypeMap;->DB:[Lcom/sun/activation/registries/MimeTypeFile;

    array-length v0, v0

    if-lt v1, v0, :cond_2

    .line 336
    sget-object v0, Ljavax/activation/MimetypesFileTypeMap;->defaultType:Ljava/lang/String;

    goto :goto_0

    .line 330
    :cond_2
    iget-object v0, p0, Ljavax/activation/MimetypesFileTypeMap;->DB:[Lcom/sun/activation/registries/MimeTypeFile;

    aget-object v0, v0, v1

    if-nez v0, :cond_4

    .line 329
    :cond_3
    add-int/lit8 v0, v1, 0x1

    move v1, v0

    goto :goto_1

    .line 332
    :cond_4
    iget-object v0, p0, Ljavax/activation/MimetypesFileTypeMap;->DB:[Lcom/sun/activation/registries/MimeTypeFile;

    aget-object v0, v0, v1

    invoke-virtual {v0, v2}, Lcom/sun/activation/registries/MimeTypeFile;->getMIMETypeString(Ljava/lang/String;)Ljava/lang/String;
    :try_end_1
    .catchall {:try_start_1 .. :try_end_1} :catchall_0

    move-result-object v0

    .line 333
    if-eqz v0, :cond_3

    goto :goto_0

    .line 320
    :catchall_0
    move-exception v0

    monitor-exit p0

    throw v0
.end method
