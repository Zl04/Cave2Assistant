.class public Lcom/sun/activation/registries/MimeTypeFile;
.super Ljava/lang/Object;
.source "SourceFile"


# instance fields
.field private fname:Ljava/lang/String;

.field private type_hash:Ljava/util/Hashtable;


# direct methods
.method public constructor <init>()V
    .locals 1

    .prologue
    .line 83
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    .line 47
    const/4 v0, 0x0

    iput-object v0, p0, Lcom/sun/activation/registries/MimeTypeFile;->fname:Ljava/lang/String;

    .line 48
    new-instance v0, Ljava/util/Hashtable;

    invoke-direct {v0}, Ljava/util/Hashtable;-><init>()V

    iput-object v0, p0, Lcom/sun/activation/registries/MimeTypeFile;->type_hash:Ljava/util/Hashtable;

    .line 84
    return-void
.end method

.method public constructor <init>(Ljava/io/InputStream;)V
    .locals 3
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljava/io/IOException;
        }
    .end annotation

    .prologue
    .line 76
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    .line 47
    const/4 v0, 0x0

    iput-object v0, p0, Lcom/sun/activation/registries/MimeTypeFile;->fname:Ljava/lang/String;

    .line 48
    new-instance v0, Ljava/util/Hashtable;

    invoke-direct {v0}, Ljava/util/Hashtable;-><init>()V

    iput-object v0, p0, Lcom/sun/activation/registries/MimeTypeFile;->type_hash:Ljava/util/Hashtable;

    .line 77
    new-instance v0, Ljava/io/BufferedReader;

    new-instance v1, Ljava/io/InputStreamReader;

    const-string v2, "iso-8859-1"

    invoke-direct {v1, p1, v2}, Ljava/io/InputStreamReader;-><init>(Ljava/io/InputStream;Ljava/lang/String;)V

    invoke-direct {v0, v1}, Ljava/io/BufferedReader;-><init>(Ljava/io/Reader;)V

    invoke-direct {p0, v0}, Lcom/sun/activation/registries/MimeTypeFile;->parse(Ljava/io/BufferedReader;)V

    .line 78
    return-void
.end method

.method public constructor <init>(Ljava/lang/String;)V
    .locals 2
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljava/io/IOException;
        }
    .end annotation

    .prologue
    .line 55
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    .line 47
    const/4 v0, 0x0

    iput-object v0, p0, Lcom/sun/activation/registries/MimeTypeFile;->fname:Ljava/lang/String;

    .line 48
    new-instance v0, Ljava/util/Hashtable;

    invoke-direct {v0}, Ljava/util/Hashtable;-><init>()V

    iput-object v0, p0, Lcom/sun/activation/registries/MimeTypeFile;->type_hash:Ljava/util/Hashtable;

    .line 59
    iput-object p1, p0, Lcom/sun/activation/registries/MimeTypeFile;->fname:Ljava/lang/String;

    .line 61
    new-instance v0, Ljava/io/File;

    iget-object v1, p0, Lcom/sun/activation/registries/MimeTypeFile;->fname:Ljava/lang/String;

    invoke-direct {v0, v1}, Ljava/io/File;-><init>(Ljava/lang/String;)V

    .line 63
    new-instance v1, Ljava/io/FileReader;

    invoke-direct {v1, v0}, Ljava/io/FileReader;-><init>(Ljava/io/File;)V

    .line 66
    :try_start_0
    new-instance v0, Ljava/io/BufferedReader;

    invoke-direct {v0, v1}, Ljava/io/BufferedReader;-><init>(Ljava/io/Reader;)V

    invoke-direct {p0, v0}, Lcom/sun/activation/registries/MimeTypeFile;->parse(Ljava/io/BufferedReader;)V
    :try_end_0
    .catchall {:try_start_0 .. :try_end_0} :catchall_0

    .line 69
    :try_start_1
    invoke-virtual {v1}, Ljava/io/FileReader;->close()V
    :try_end_1
    .catch Ljava/io/IOException; {:try_start_1 .. :try_end_1} :catch_1

    .line 74
    :goto_0
    return-void

    .line 67
    :catchall_0
    move-exception v0

    .line 69
    :try_start_2
    invoke-virtual {v1}, Ljava/io/FileReader;->close()V
    :try_end_2
    .catch Ljava/io/IOException; {:try_start_2 .. :try_end_2} :catch_0

    .line 73
    :goto_1
    throw v0

    .line 70
    :catch_0
    move-exception v1

    goto :goto_1

    :catch_1
    move-exception v0

    goto :goto_0
.end method

.method private parse(Ljava/io/BufferedReader;)V
    .locals 5
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljava/io/IOException;
        }
    .end annotation

    .prologue
    const/4 v2, 0x0

    .line 132
    move-object v1, v2

    .line 134
    :goto_0
    invoke-virtual {p1}, Ljava/io/BufferedReader;->readLine()Ljava/lang/String;

    move-result-object v0

    if-nez v0, :cond_1

    .line 147
    if-eqz v1, :cond_0

    .line 148
    invoke-direct {p0, v1}, Lcom/sun/activation/registries/MimeTypeFile;->parseEntry(Ljava/lang/String;)V

    .line 149
    :cond_0
    return-void

    .line 135
    :cond_1
    if-nez v1, :cond_2

    .line 139
    :goto_1
    invoke-virtual {v0}, Ljava/lang/String;->length()I

    move-result v1

    .line 140
    invoke-virtual {v0}, Ljava/lang/String;->length()I

    move-result v3

    if-lez v3, :cond_3

    add-int/lit8 v3, v1, -0x1

    invoke-virtual {v0, v3}, Ljava/lang/String;->charAt(I)C

    move-result v3

    const/16 v4, 0x5c

    if-ne v3, v4, :cond_3

    .line 141
    const/4 v3, 0x0

    add-int/lit8 v1, v1, -0x1

    invoke-virtual {v0, v3, v1}, Ljava/lang/String;->substring(II)Ljava/lang/String;

    move-result-object v0

    move-object v1, v0

    .line 142
    goto :goto_0

    .line 138
    :cond_2
    new-instance v3, Ljava/lang/StringBuilder;

    invoke-static {v1}, Ljava/lang/String;->valueOf(Ljava/lang/Object;)Ljava/lang/String;

    move-result-object v1

    invoke-direct {v3, v1}, Ljava/lang/StringBuilder;-><init>(Ljava/lang/String;)V

    invoke-virtual {v3, v0}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-virtual {v0}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v0

    goto :goto_1

    .line 144
    :cond_3
    invoke-direct {p0, v0}, Lcom/sun/activation/registries/MimeTypeFile;->parseEntry(Ljava/lang/String;)V

    move-object v1, v2

    .line 145
    goto :goto_0
.end method

.method private parseEntry(Ljava/lang/String;)V
    .locals 8

    .prologue
    const/4 v1, 0x0

    .line 155
    .line 157
    invoke-virtual {p1}, Ljava/lang/String;->trim()Ljava/lang/String;

    move-result-object v3

    .line 159
    invoke-virtual {v3}, Ljava/lang/String;->length()I

    move-result v0

    if-nez v0, :cond_1

    .line 216
    :cond_0
    :goto_0
    return-void

    .line 163
    :cond_1
    const/4 v0, 0x0

    invoke-virtual {v3, v0}, Ljava/lang/String;->charAt(I)C

    move-result v0

    const/16 v2, 0x23

    if-eq v0, v2, :cond_0

    .line 167
    const/16 v0, 0x3d

    invoke-virtual {v3, v0}, Ljava/lang/String;->indexOf(I)I

    move-result v0

    if-lez v0, :cond_6

    .line 169
    new-instance v4, Lcom/sun/activation/registries/LineTokenizer;

    invoke-direct {v4, v3}, Lcom/sun/activation/registries/LineTokenizer;-><init>(Ljava/lang/String;)V

    move-object v0, v1

    .line 170
    :cond_2
    :goto_1
    invoke-virtual {v4}, Lcom/sun/activation/registries/LineTokenizer;->hasMoreTokens()Z

    move-result v2

    if-eqz v2, :cond_0

    .line 171
    invoke-virtual {v4}, Lcom/sun/activation/registries/LineTokenizer;->nextToken()Ljava/lang/String;

    move-result-object v5

    .line 173
    invoke-virtual {v4}, Lcom/sun/activation/registries/LineTokenizer;->hasMoreTokens()Z

    move-result v2

    if-eqz v2, :cond_8

    invoke-virtual {v4}, Lcom/sun/activation/registries/LineTokenizer;->nextToken()Ljava/lang/String;

    move-result-object v2

    const-string v6, "="

    invoke-virtual {v2, v6}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v2

    if-eqz v2, :cond_8

    .line 174
    invoke-virtual {v4}, Lcom/sun/activation/registries/LineTokenizer;->hasMoreTokens()Z

    move-result v2

    if-eqz v2, :cond_8

    .line 175
    invoke-virtual {v4}, Lcom/sun/activation/registries/LineTokenizer;->nextToken()Ljava/lang/String;

    move-result-object v2

    .line 176
    :goto_2
    if-nez v2, :cond_3

    .line 177
    invoke-static {}, Lcom/sun/activation/registries/LogSupport;->isLoggable()Z

    move-result v0

    if-eqz v0, :cond_0

    .line 178
    new-instance v0, Ljava/lang/StringBuilder;

    const-string v1, "Bad .mime.types entry: "

    invoke-direct {v0, v1}, Ljava/lang/StringBuilder;-><init>(Ljava/lang/String;)V

    invoke-virtual {v0, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-virtual {v0}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v0

    invoke-static {v0}, Lcom/sun/activation/registries/LogSupport;->log(Ljava/lang/String;)V

    goto :goto_0

    .line 181
    :cond_3
    const-string v6, "type"

    invoke-virtual {v5, v6}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v6

    if-eqz v6, :cond_4

    move-object v0, v2

    .line 182
    goto :goto_1

    .line 183
    :cond_4
    const-string v6, "exts"

    invoke-virtual {v5, v6}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v5

    if-eqz v5, :cond_2

    .line 184
    new-instance v5, Ljava/util/StringTokenizer;

    const-string v6, ","

    invoke-direct {v5, v2, v6}, Ljava/util/StringTokenizer;-><init>(Ljava/lang/String;Ljava/lang/String;)V

    .line 185
    :cond_5
    :goto_3
    invoke-virtual {v5}, Ljava/util/StringTokenizer;->hasMoreTokens()Z

    move-result v2

    if-eqz v2, :cond_2

    .line 186
    invoke-virtual {v5}, Ljava/util/StringTokenizer;->nextToken()Ljava/lang/String;

    move-result-object v2

    .line 188
    new-instance v6, Lcom/sun/activation/registries/MimeTypeEntry;

    invoke-direct {v6, v0, v2}, Lcom/sun/activation/registries/MimeTypeEntry;-><init>(Ljava/lang/String;Ljava/lang/String;)V

    .line 189
    iget-object v7, p0, Lcom/sun/activation/registries/MimeTypeFile;->type_hash:Ljava/util/Hashtable;

    invoke-virtual {v7, v2, v6}, Ljava/util/Hashtable;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    .line 190
    invoke-static {}, Lcom/sun/activation/registries/LogSupport;->isLoggable()Z

    move-result v2

    if-eqz v2, :cond_5

    .line 191
    new-instance v2, Ljava/lang/StringBuilder;

    const-string v7, "Added: "

    invoke-direct {v2, v7}, Ljava/lang/StringBuilder;-><init>(Ljava/lang/String;)V

    invoke-virtual {v6}, Lcom/sun/activation/registries/MimeTypeEntry;->toString()Ljava/lang/String;

    move-result-object v6

    invoke-virtual {v2, v6}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    invoke-virtual {v2}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v2

    invoke-static {v2}, Lcom/sun/activation/registries/LogSupport;->log(Ljava/lang/String;)V

    goto :goto_3

    .line 198
    :cond_6
    new-instance v0, Ljava/util/StringTokenizer;

    invoke-direct {v0, v3}, Ljava/util/StringTokenizer;-><init>(Ljava/lang/String;)V

    .line 199
    invoke-virtual {v0}, Ljava/util/StringTokenizer;->countTokens()I

    move-result v1

    .line 201
    if-eqz v1, :cond_0

    .line 204
    invoke-virtual {v0}, Ljava/util/StringTokenizer;->nextToken()Ljava/lang/String;

    move-result-object v1

    .line 206
    :cond_7
    :goto_4
    invoke-virtual {v0}, Ljava/util/StringTokenizer;->hasMoreTokens()Z

    move-result v2

    if-eqz v2, :cond_0

    .line 209
    invoke-virtual {v0}, Ljava/util/StringTokenizer;->nextToken()Ljava/lang/String;

    move-result-object v2

    .line 210
    new-instance v3, Lcom/sun/activation/registries/MimeTypeEntry;

    invoke-direct {v3, v1, v2}, Lcom/sun/activation/registries/MimeTypeEntry;-><init>(Ljava/lang/String;Ljava/lang/String;)V

    .line 211
    iget-object v4, p0, Lcom/sun/activation/registries/MimeTypeFile;->type_hash:Ljava/util/Hashtable;

    invoke-virtual {v4, v2, v3}, Ljava/util/Hashtable;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    .line 212
    invoke-static {}, Lcom/sun/activation/registries/LogSupport;->isLoggable()Z

    move-result v2

    if-eqz v2, :cond_7

    .line 213
    new-instance v2, Ljava/lang/StringBuilder;

    const-string v4, "Added: "

    invoke-direct {v2, v4}, Ljava/lang/StringBuilder;-><init>(Ljava/lang/String;)V

    invoke-virtual {v3}, Lcom/sun/activation/registries/MimeTypeEntry;->toString()Ljava/lang/String;

    move-result-object v3

    invoke-virtual {v2, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    invoke-virtual {v2}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v2

    invoke-static {v2}, Lcom/sun/activation/registries/LogSupport;->log(Ljava/lang/String;)V

    goto :goto_4

    :cond_8
    move-object v2, v1

    goto/16 :goto_2
.end method


# virtual methods
.method public appendToRegistry(Ljava/lang/String;)V
    .locals 2

    .prologue
    .line 122
    :try_start_0
    new-instance v0, Ljava/io/BufferedReader;

    new-instance v1, Ljava/io/StringReader;

    invoke-direct {v1, p1}, Ljava/io/StringReader;-><init>(Ljava/lang/String;)V

    invoke-direct {v0, v1}, Ljava/io/BufferedReader;-><init>(Ljava/io/Reader;)V

    invoke-direct {p0, v0}, Lcom/sun/activation/registries/MimeTypeFile;->parse(Ljava/io/BufferedReader;)V
    :try_end_0
    .catch Ljava/io/IOException; {:try_start_0 .. :try_end_0} :catch_0

    .line 126
    :goto_0
    return-void

    .line 123
    :catch_0
    move-exception v0

    goto :goto_0
.end method

.method public getMIMETypeString(Ljava/lang/String;)Ljava/lang/String;
    .locals 1

    .prologue
    .line 97
    invoke-virtual {p0, p1}, Lcom/sun/activation/registries/MimeTypeFile;->getMimeTypeEntry(Ljava/lang/String;)Lcom/sun/activation/registries/MimeTypeEntry;

    move-result-object v0

    .line 99
    if-eqz v0, :cond_0

    .line 100
    invoke-virtual {v0}, Lcom/sun/activation/registries/MimeTypeEntry;->getMIMEType()Ljava/lang/String;

    move-result-object v0

    .line 102
    :goto_0
    return-object v0

    :cond_0
    const/4 v0, 0x0

    goto :goto_0
.end method

.method public getMimeTypeEntry(Ljava/lang/String;)Lcom/sun/activation/registries/MimeTypeEntry;
    .locals 1

    .prologue
    .line 90
    iget-object v0, p0, Lcom/sun/activation/registries/MimeTypeFile;->type_hash:Ljava/util/Hashtable;

    invoke-virtual {v0, p1}, Ljava/util/Hashtable;->get(Ljava/lang/Object;)Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Lcom/sun/activation/registries/MimeTypeEntry;

    return-object v0
.end method
