.class public Lcom/sun/activation/registries/MailcapFile;
.super Ljava/lang/Object;
.source "SourceFile"


# static fields
.field private static addReverse:Z


# instance fields
.field private fallback_hash:Ljava/util/Map;

.field private native_commands:Ljava/util/Map;

.field private type_hash:Ljava/util/Map;


# direct methods
.method static constructor <clinit>()V
    .locals 1

    .prologue
    .line 67
    const/4 v0, 0x0

    sput-boolean v0, Lcom/sun/activation/registries/MailcapFile;->addReverse:Z

    .line 71
    :try_start_0
    const-string v0, "javax.activation.addreverse"

    invoke-static {v0}, Ljava/lang/Boolean;->getBoolean(Ljava/lang/String;)Z

    move-result v0

    sput-boolean v0, Lcom/sun/activation/registries/MailcapFile;->addReverse:Z
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_0

    .line 46
    :goto_0
    return-void

    .line 72
    :catch_0
    move-exception v0

    goto :goto_0
.end method

.method public constructor <init>()V
    .locals 1

    .prologue
    .line 112
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    .line 54
    new-instance v0, Ljava/util/HashMap;

    invoke-direct {v0}, Ljava/util/HashMap;-><init>()V

    iput-object v0, p0, Lcom/sun/activation/registries/MailcapFile;->type_hash:Ljava/util/Map;

    .line 59
    new-instance v0, Ljava/util/HashMap;

    invoke-direct {v0}, Ljava/util/HashMap;-><init>()V

    iput-object v0, p0, Lcom/sun/activation/registries/MailcapFile;->fallback_hash:Ljava/util/Map;

    .line 65
    new-instance v0, Ljava/util/HashMap;

    invoke-direct {v0}, Ljava/util/HashMap;-><init>()V

    iput-object v0, p0, Lcom/sun/activation/registries/MailcapFile;->native_commands:Ljava/util/Map;

    .line 113
    invoke-static {}, Lcom/sun/activation/registries/LogSupport;->isLoggable()Z

    move-result v0

    if-eqz v0, :cond_0

    .line 114
    const-string v0, "new MailcapFile: default"

    invoke-static {v0}, Lcom/sun/activation/registries/LogSupport;->log(Ljava/lang/String;)V

    .line 115
    :cond_0
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
    .line 103
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    .line 54
    new-instance v0, Ljava/util/HashMap;

    invoke-direct {v0}, Ljava/util/HashMap;-><init>()V

    iput-object v0, p0, Lcom/sun/activation/registries/MailcapFile;->type_hash:Ljava/util/Map;

    .line 59
    new-instance v0, Ljava/util/HashMap;

    invoke-direct {v0}, Ljava/util/HashMap;-><init>()V

    iput-object v0, p0, Lcom/sun/activation/registries/MailcapFile;->fallback_hash:Ljava/util/Map;

    .line 65
    new-instance v0, Ljava/util/HashMap;

    invoke-direct {v0}, Ljava/util/HashMap;-><init>()V

    iput-object v0, p0, Lcom/sun/activation/registries/MailcapFile;->native_commands:Ljava/util/Map;

    .line 104
    invoke-static {}, Lcom/sun/activation/registries/LogSupport;->isLoggable()Z

    move-result v0

    if-eqz v0, :cond_0

    .line 105
    const-string v0, "new MailcapFile: InputStream"

    invoke-static {v0}, Lcom/sun/activation/registries/LogSupport;->log(Ljava/lang/String;)V

    .line 106
    :cond_0
    new-instance v0, Ljava/io/BufferedReader;

    new-instance v1, Ljava/io/InputStreamReader;

    const-string v2, "iso-8859-1"

    invoke-direct {v1, p1, v2}, Ljava/io/InputStreamReader;-><init>(Ljava/io/InputStream;Ljava/lang/String;)V

    invoke-direct {v0, v1}, Ljava/io/BufferedReader;-><init>(Ljava/io/Reader;)V

    invoke-direct {p0, v0}, Lcom/sun/activation/registries/MailcapFile;->parse(Ljava/io/Reader;)V

    .line 107
    return-void
.end method

.method public constructor <init>(Ljava/lang/String;)V
    .locals 3
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljava/io/IOException;
        }
    .end annotation

    .prologue
    .line 82
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    .line 54
    new-instance v0, Ljava/util/HashMap;

    invoke-direct {v0}, Ljava/util/HashMap;-><init>()V

    iput-object v0, p0, Lcom/sun/activation/registries/MailcapFile;->type_hash:Ljava/util/Map;

    .line 59
    new-instance v0, Ljava/util/HashMap;

    invoke-direct {v0}, Ljava/util/HashMap;-><init>()V

    iput-object v0, p0, Lcom/sun/activation/registries/MailcapFile;->fallback_hash:Ljava/util/Map;

    .line 65
    new-instance v0, Ljava/util/HashMap;

    invoke-direct {v0}, Ljava/util/HashMap;-><init>()V

    iput-object v0, p0, Lcom/sun/activation/registries/MailcapFile;->native_commands:Ljava/util/Map;

    .line 83
    invoke-static {}, Lcom/sun/activation/registries/LogSupport;->isLoggable()Z

    move-result v0

    if-eqz v0, :cond_0

    .line 84
    new-instance v0, Ljava/lang/StringBuilder;

    const-string v1, "new MailcapFile: file "

    invoke-direct {v0, v1}, Ljava/lang/StringBuilder;-><init>(Ljava/lang/String;)V

    invoke-virtual {v0, p1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-virtual {v0}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v0

    invoke-static {v0}, Lcom/sun/activation/registries/LogSupport;->log(Ljava/lang/String;)V

    .line 85
    :cond_0
    const/4 v2, 0x0

    .line 87
    :try_start_0
    new-instance v1, Ljava/io/FileReader;

    invoke-direct {v1, p1}, Ljava/io/FileReader;-><init>(Ljava/lang/String;)V
    :try_end_0
    .catchall {:try_start_0 .. :try_end_0} :catchall_0

    .line 88
    :try_start_1
    new-instance v0, Ljava/io/BufferedReader;

    invoke-direct {v0, v1}, Ljava/io/BufferedReader;-><init>(Ljava/io/Reader;)V

    invoke-direct {p0, v0}, Lcom/sun/activation/registries/MailcapFile;->parse(Ljava/io/Reader;)V
    :try_end_1
    .catchall {:try_start_1 .. :try_end_1} :catchall_1

    .line 90
    if-eqz v1, :cond_1

    .line 92
    :try_start_2
    invoke-virtual {v1}, Ljava/io/FileReader;->close()V
    :try_end_2
    .catch Ljava/io/IOException; {:try_start_2 .. :try_end_2} :catch_1

    .line 96
    :cond_1
    :goto_0
    return-void

    .line 89
    :catchall_0
    move-exception v0

    move-object v1, v2

    .line 90
    :goto_1
    if-eqz v1, :cond_2

    .line 92
    :try_start_3
    invoke-virtual {v1}, Ljava/io/FileReader;->close()V
    :try_end_3
    .catch Ljava/io/IOException; {:try_start_3 .. :try_end_3} :catch_0

    .line 95
    :cond_2
    :goto_2
    throw v0

    .line 93
    :catch_0
    move-exception v1

    goto :goto_2

    :catch_1
    move-exception v0

    goto :goto_0

    .line 89
    :catchall_1
    move-exception v0

    goto :goto_1
.end method

.method private mergeResults(Ljava/util/Map;Ljava/util/Map;)Ljava/util/Map;
    .locals 6

    .prologue
    .line 216
    invoke-interface {p2}, Ljava/util/Map;->keySet()Ljava/util/Set;

    move-result-object v0

    invoke-interface {v0}, Ljava/util/Set;->iterator()Ljava/util/Iterator;

    move-result-object v3

    .line 217
    new-instance v4, Ljava/util/HashMap;

    invoke-direct {v4, p1}, Ljava/util/HashMap;-><init>(Ljava/util/Map;)V

    .line 220
    :goto_0
    invoke-interface {v3}, Ljava/util/Iterator;->hasNext()Z

    move-result v0

    if-nez v0, :cond_0

    .line 233
    return-object v4

    .line 221
    :cond_0
    invoke-interface {v3}, Ljava/util/Iterator;->next()Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Ljava/lang/String;

    .line 222
    invoke-interface {v4, v0}, Ljava/util/Map;->get(Ljava/lang/Object;)Ljava/lang/Object;

    move-result-object v1

    check-cast v1, Ljava/util/List;

    .line 223
    if-nez v1, :cond_1

    .line 224
    invoke-interface {p2, v0}, Ljava/util/Map;->get(Ljava/lang/Object;)Ljava/lang/Object;

    move-result-object v1

    invoke-interface {v4, v0, v1}, Ljava/util/Map;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    goto :goto_0

    .line 227
    :cond_1
    invoke-interface {p2, v0}, Ljava/util/Map;->get(Ljava/lang/Object;)Ljava/lang/Object;

    move-result-object v2

    check-cast v2, Ljava/util/List;

    .line 228
    new-instance v5, Ljava/util/ArrayList;

    invoke-direct {v5, v1}, Ljava/util/ArrayList;-><init>(Ljava/util/Collection;)V

    .line 229
    invoke-interface {v5, v2}, Ljava/util/List;->addAll(Ljava/util/Collection;)Z

    .line 230
    invoke-interface {v4, v0, v5}, Ljava/util/Map;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    goto :goto_0
.end method

.method private parse(Ljava/io/Reader;)V
    .locals 7
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljava/io/IOException;
        }
    .end annotation

    .prologue
    const/4 v1, 0x0

    .line 260
    new-instance v2, Ljava/io/BufferedReader;

    invoke-direct {v2, p1}, Ljava/io/BufferedReader;-><init>(Ljava/io/Reader;)V

    move-object v0, v1

    .line 264
    :cond_0
    :goto_0
    invoke-virtual {v2}, Ljava/io/BufferedReader;->readLine()Ljava/lang/String;

    move-result-object v3

    if-nez v3, :cond_1

    .line 299
    return-void

    .line 267
    :cond_1
    invoke-virtual {v3}, Ljava/lang/String;->trim()Ljava/lang/String;

    move-result-object v3

    .line 270
    const/4 v4, 0x0

    :try_start_0
    invoke-virtual {v3, v4}, Ljava/lang/String;->charAt(I)C

    move-result v4

    const/16 v5, 0x23

    if-eq v4, v5, :cond_0

    .line 272
    invoke-virtual {v3}, Ljava/lang/String;->length()I

    move-result v4

    add-int/lit8 v4, v4, -0x1

    invoke-virtual {v3, v4}, Ljava/lang/String;->charAt(I)C

    move-result v4

    const/16 v5, 0x5c

    if-ne v4, v5, :cond_3

    .line 273
    if-eqz v0, :cond_2

    .line 274
    new-instance v4, Ljava/lang/StringBuilder;

    invoke-static {v0}, Ljava/lang/String;->valueOf(Ljava/lang/Object;)Ljava/lang/String;

    move-result-object v5

    invoke-direct {v4, v5}, Ljava/lang/StringBuilder;-><init>(Ljava/lang/String;)V

    const/4 v5, 0x0

    invoke-virtual {v3}, Ljava/lang/String;->length()I

    move-result v6

    add-int/lit8 v6, v6, -0x1

    invoke-virtual {v3, v5, v6}, Ljava/lang/String;->substring(II)Ljava/lang/String;

    move-result-object v3

    invoke-virtual {v4, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v3

    invoke-virtual {v3}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v0

    goto :goto_0

    .line 276
    :cond_2
    const/4 v4, 0x0

    invoke-virtual {v3}, Ljava/lang/String;->length()I

    move-result v5

    add-int/lit8 v5, v5, -0x1

    invoke-virtual {v3, v4, v5}, Ljava/lang/String;->substring(II)Ljava/lang/String;

    move-result-object v0

    goto :goto_0

    .line 277
    :cond_3
    if-eqz v0, :cond_4

    .line 279
    new-instance v4, Ljava/lang/StringBuilder;

    invoke-static {v0}, Ljava/lang/String;->valueOf(Ljava/lang/Object;)Ljava/lang/String;

    move-result-object v5

    invoke-direct {v4, v5}, Ljava/lang/StringBuilder;-><init>(Ljava/lang/String;)V

    invoke-virtual {v4, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v3

    invoke-virtual {v3}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;
    :try_end_0
    .catch Ljava/lang/StringIndexOutOfBoundsException; {:try_start_0 .. :try_end_0} :catch_2

    move-result-object v0

    .line 282
    :try_start_1
    invoke-virtual {p0, v0}, Lcom/sun/activation/registries/MailcapFile;->parseLine(Ljava/lang/String;)V
    :try_end_1
    .catch Lcom/sun/activation/registries/MailcapParseException; {:try_start_1 .. :try_end_1} :catch_1
    .catch Ljava/lang/StringIndexOutOfBoundsException; {:try_start_1 .. :try_end_1} :catch_2

    :goto_1
    move-object v0, v1

    .line 286
    goto :goto_0

    .line 291
    :cond_4
    :try_start_2
    invoke-virtual {p0, v3}, Lcom/sun/activation/registries/MailcapFile;->parseLine(Ljava/lang/String;)V
    :try_end_2
    .catch Lcom/sun/activation/registries/MailcapParseException; {:try_start_2 .. :try_end_2} :catch_0
    .catch Ljava/lang/StringIndexOutOfBoundsException; {:try_start_2 .. :try_end_2} :catch_2

    goto :goto_0

    .line 293
    :catch_0
    move-exception v3

    goto :goto_0

    .line 283
    :catch_1
    move-exception v0

    goto :goto_1

    .line 297
    :catch_2
    move-exception v3

    goto :goto_0
.end method

.method protected static reportParseError(IIIILjava/lang/String;)V
    .locals 3
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Lcom/sun/activation/registries/MailcapParseException;
        }
    .end annotation

    .prologue
    .line 533
    invoke-static {}, Lcom/sun/activation/registries/LogSupport;->isLoggable()Z

    move-result v0

    if-eqz v0, :cond_0

    .line 534
    new-instance v0, Ljava/lang/StringBuilder;

    const-string v1, "PARSE ERROR: Encountered a "

    invoke-direct {v0, v1}, Ljava/lang/StringBuilder;-><init>(Ljava/lang/String;)V

    .line 535
    invoke-static {p3}, Lcom/sun/activation/registries/MailcapTokenizer;->nameForToken(I)Ljava/lang/String;

    move-result-object v1

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    const-string v1, " token ("

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    .line 536
    invoke-virtual {v0, p4}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    const-string v1, ") while expecting a "

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    .line 537
    invoke-static {p0}, Lcom/sun/activation/registries/MailcapTokenizer;->nameForToken(I)Ljava/lang/String;

    move-result-object v1

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    const-string v1, ", a "

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    .line 538
    invoke-static {p1}, Lcom/sun/activation/registries/MailcapTokenizer;->nameForToken(I)Ljava/lang/String;

    move-result-object v1

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    const-string v1, ", or a "

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    .line 539
    invoke-static {p2}, Lcom/sun/activation/registries/MailcapTokenizer;->nameForToken(I)Ljava/lang/String;

    move-result-object v1

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    const-string v1, " token."

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    .line 534
    invoke-virtual {v0}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v0

    invoke-static {v0}, Lcom/sun/activation/registries/LogSupport;->log(Ljava/lang/String;)V

    .line 540
    :cond_0
    new-instance v0, Lcom/sun/activation/registries/MailcapParseException;

    new-instance v1, Ljava/lang/StringBuilder;

    const-string v2, "Encountered a "

    invoke-direct {v1, v2}, Ljava/lang/StringBuilder;-><init>(Ljava/lang/String;)V

    .line 541
    invoke-static {p3}, Lcom/sun/activation/registries/MailcapTokenizer;->nameForToken(I)Ljava/lang/String;

    move-result-object v2

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    const-string v2, " token ("

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    .line 542
    invoke-virtual {v1, p4}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    const-string v2, ") while expecting a "

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    .line 543
    invoke-static {p0}, Lcom/sun/activation/registries/MailcapTokenizer;->nameForToken(I)Ljava/lang/String;

    move-result-object v2

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    const-string v2, ", a "

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    .line 544
    invoke-static {p1}, Lcom/sun/activation/registries/MailcapTokenizer;->nameForToken(I)Ljava/lang/String;

    move-result-object v2

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    const-string v2, ", or a "

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    .line 545
    invoke-static {p2}, Lcom/sun/activation/registries/MailcapTokenizer;->nameForToken(I)Ljava/lang/String;

    move-result-object v2

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    const-string v2, " token."

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v1

    .line 540
    invoke-direct {v0, v1}, Lcom/sun/activation/registries/MailcapParseException;-><init>(Ljava/lang/String;)V

    throw v0
.end method

.method protected static reportParseError(IIILjava/lang/String;)V
    .locals 3
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Lcom/sun/activation/registries/MailcapParseException;
        }
    .end annotation

    .prologue
    .line 523
    new-instance v0, Lcom/sun/activation/registries/MailcapParseException;

    new-instance v1, Ljava/lang/StringBuilder;

    const-string v2, "Encountered a "

    invoke-direct {v1, v2}, Ljava/lang/StringBuilder;-><init>(Ljava/lang/String;)V

    .line 524
    invoke-static {p2}, Lcom/sun/activation/registries/MailcapTokenizer;->nameForToken(I)Ljava/lang/String;

    move-result-object v2

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    const-string v2, " token ("

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    .line 525
    invoke-virtual {v1, p3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    const-string v2, ") while expecting a "

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    .line 526
    invoke-static {p0}, Lcom/sun/activation/registries/MailcapTokenizer;->nameForToken(I)Ljava/lang/String;

    move-result-object v2

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    const-string v2, " or a "

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    .line 527
    invoke-static {p1}, Lcom/sun/activation/registries/MailcapTokenizer;->nameForToken(I)Ljava/lang/String;

    move-result-object v2

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    const-string v2, " token."

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v1

    .line 523
    invoke-direct {v0, v1}, Lcom/sun/activation/registries/MailcapParseException;-><init>(Ljava/lang/String;)V

    throw v0
.end method

.method protected static reportParseError(IILjava/lang/String;)V
    .locals 3
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Lcom/sun/activation/registries/MailcapParseException;
        }
    .end annotation

    .prologue
    .line 514
    new-instance v0, Lcom/sun/activation/registries/MailcapParseException;

    new-instance v1, Ljava/lang/StringBuilder;

    const-string v2, "Encountered a "

    invoke-direct {v1, v2}, Ljava/lang/StringBuilder;-><init>(Ljava/lang/String;)V

    .line 515
    invoke-static {p1}, Lcom/sun/activation/registries/MailcapTokenizer;->nameForToken(I)Ljava/lang/String;

    move-result-object v2

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    const-string v2, " token ("

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    .line 516
    invoke-virtual {v1, p2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    const-string v2, ") while expecting a "

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    .line 517
    invoke-static {p0}, Lcom/sun/activation/registries/MailcapTokenizer;->nameForToken(I)Ljava/lang/String;

    move-result-object v2

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    const-string v2, " token."

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v1

    .line 514
    invoke-direct {v0, v1}, Lcom/sun/activation/registries/MailcapParseException;-><init>(Ljava/lang/String;)V

    throw v0
.end method


# virtual methods
.method public appendToMailcap(Ljava/lang/String;)V
    .locals 2

    .prologue
    .line 247
    invoke-static {}, Lcom/sun/activation/registries/LogSupport;->isLoggable()Z

    move-result v0

    if-eqz v0, :cond_0

    .line 248
    new-instance v0, Ljava/lang/StringBuilder;

    const-string v1, "appendToMailcap: "

    invoke-direct {v0, v1}, Ljava/lang/StringBuilder;-><init>(Ljava/lang/String;)V

    invoke-virtual {v0, p1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-virtual {v0}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v0

    invoke-static {v0}, Lcom/sun/activation/registries/LogSupport;->log(Ljava/lang/String;)V

    .line 250
    :cond_0
    :try_start_0
    new-instance v0, Ljava/io/StringReader;

    invoke-direct {v0, p1}, Ljava/io/StringReader;-><init>(Ljava/lang/String;)V

    invoke-direct {p0, v0}, Lcom/sun/activation/registries/MailcapFile;->parse(Ljava/io/Reader;)V
    :try_end_0
    .catch Ljava/io/IOException; {:try_start_0 .. :try_end_0} :catch_0

    .line 254
    :goto_0
    return-void

    .line 251
    :catch_0
    move-exception v0

    goto :goto_0
.end method

.method public getMailcapFallbackList(Ljava/lang/String;)Ljava/util/Map;
    .locals 4

    .prologue
    .line 159
    .line 163
    iget-object v0, p0, Lcom/sun/activation/registries/MailcapFile;->fallback_hash:Ljava/util/Map;

    invoke-interface {v0, p1}, Ljava/util/Map;->get(Ljava/lang/Object;)Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Ljava/util/Map;

    .line 166
    const/16 v1, 0x2f

    invoke-virtual {p1, v1}, Ljava/lang/String;->indexOf(I)I

    move-result v1

    .line 167
    add-int/lit8 v2, v1, 0x1

    invoke-virtual {p1, v2}, Ljava/lang/String;->substring(I)Ljava/lang/String;

    move-result-object v2

    .line 168
    const-string v3, "*"

    invoke-virtual {v2, v3}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v2

    if-nez v2, :cond_0

    .line 169
    new-instance v2, Ljava/lang/StringBuilder;

    const/4 v3, 0x0

    add-int/lit8 v1, v1, 0x1

    invoke-virtual {p1, v3, v1}, Ljava/lang/String;->substring(II)Ljava/lang/String;

    move-result-object v1

    invoke-static {v1}, Ljava/lang/String;->valueOf(Ljava/lang/Object;)Ljava/lang/String;

    move-result-object v1

    invoke-direct {v2, v1}, Ljava/lang/StringBuilder;-><init>(Ljava/lang/String;)V

    const-string v1, "*"

    invoke-virtual {v2, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v1

    .line 170
    iget-object v2, p0, Lcom/sun/activation/registries/MailcapFile;->fallback_hash:Ljava/util/Map;

    invoke-interface {v2, v1}, Ljava/util/Map;->get(Ljava/lang/Object;)Ljava/lang/Object;

    move-result-object v1

    check-cast v1, Ljava/util/Map;

    .line 172
    if-eqz v1, :cond_0

    .line 173
    if-eqz v0, :cond_1

    .line 175
    invoke-direct {p0, v0, v1}, Lcom/sun/activation/registries/MailcapFile;->mergeResults(Ljava/util/Map;Ljava/util/Map;)Ljava/util/Map;

    move-result-object v0

    .line 180
    :cond_0
    :goto_0
    return-object v0

    :cond_1
    move-object v0, v1

    .line 177
    goto :goto_0
.end method

.method public getMailcapList(Ljava/lang/String;)Ljava/util/Map;
    .locals 4

    .prologue
    .line 126
    .line 130
    iget-object v0, p0, Lcom/sun/activation/registries/MailcapFile;->type_hash:Ljava/util/Map;

    invoke-interface {v0, p1}, Ljava/util/Map;->get(Ljava/lang/Object;)Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Ljava/util/Map;

    .line 133
    const/16 v1, 0x2f

    invoke-virtual {p1, v1}, Ljava/lang/String;->indexOf(I)I

    move-result v1

    .line 134
    add-int/lit8 v2, v1, 0x1

    invoke-virtual {p1, v2}, Ljava/lang/String;->substring(I)Ljava/lang/String;

    move-result-object v2

    .line 135
    const-string v3, "*"

    invoke-virtual {v2, v3}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v2

    if-nez v2, :cond_0

    .line 136
    new-instance v2, Ljava/lang/StringBuilder;

    const/4 v3, 0x0

    add-int/lit8 v1, v1, 0x1

    invoke-virtual {p1, v3, v1}, Ljava/lang/String;->substring(II)Ljava/lang/String;

    move-result-object v1

    invoke-static {v1}, Ljava/lang/String;->valueOf(Ljava/lang/Object;)Ljava/lang/String;

    move-result-object v1

    invoke-direct {v2, v1}, Ljava/lang/StringBuilder;-><init>(Ljava/lang/String;)V

    const-string v1, "*"

    invoke-virtual {v2, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v1

    .line 137
    iget-object v2, p0, Lcom/sun/activation/registries/MailcapFile;->type_hash:Ljava/util/Map;

    invoke-interface {v2, v1}, Ljava/util/Map;->get(Ljava/lang/Object;)Ljava/lang/Object;

    move-result-object v1

    check-cast v1, Ljava/util/Map;

    .line 139
    if-eqz v1, :cond_0

    .line 140
    if-eqz v0, :cond_1

    .line 142
    invoke-direct {p0, v0, v1}, Lcom/sun/activation/registries/MailcapFile;->mergeResults(Ljava/util/Map;Ljava/util/Map;)Ljava/util/Map;

    move-result-object v0

    .line 147
    :cond_0
    :goto_0
    return-object v0

    :cond_1
    move-object v0, v1

    .line 144
    goto :goto_0
.end method

.method public getMimeTypes()[Ljava/lang/String;
    .locals 2

    .prologue
    .line 187
    new-instance v0, Ljava/util/HashSet;

    iget-object v1, p0, Lcom/sun/activation/registries/MailcapFile;->type_hash:Ljava/util/Map;

    invoke-interface {v1}, Ljava/util/Map;->keySet()Ljava/util/Set;

    move-result-object v1

    invoke-direct {v0, v1}, Ljava/util/HashSet;-><init>(Ljava/util/Collection;)V

    .line 188
    iget-object v1, p0, Lcom/sun/activation/registries/MailcapFile;->fallback_hash:Ljava/util/Map;

    invoke-interface {v1}, Ljava/util/Map;->keySet()Ljava/util/Set;

    move-result-object v1

    invoke-interface {v0, v1}, Ljava/util/Set;->addAll(Ljava/util/Collection;)Z

    .line 189
    iget-object v1, p0, Lcom/sun/activation/registries/MailcapFile;->native_commands:Ljava/util/Map;

    invoke-interface {v1}, Ljava/util/Map;->keySet()Ljava/util/Set;

    move-result-object v1

    invoke-interface {v0, v1}, Ljava/util/Set;->addAll(Ljava/util/Collection;)Z

    .line 190
    invoke-interface {v0}, Ljava/util/Set;->size()I

    move-result v1

    new-array v1, v1, [Ljava/lang/String;

    .line 191
    invoke-interface {v0, v1}, Ljava/util/Set;->toArray([Ljava/lang/Object;)[Ljava/lang/Object;

    move-result-object v0

    check-cast v0, [Ljava/lang/String;

    .line 192
    return-object v0
.end method

.method public getNativeCommands(Ljava/lang/String;)[Ljava/lang/String;
    .locals 3

    .prologue
    .line 199
    const/4 v0, 0x0

    check-cast v0, [Ljava/lang/String;

    .line 201
    iget-object v1, p0, Lcom/sun/activation/registries/MailcapFile;->native_commands:Ljava/util/Map;

    sget-object v2, Ljava/util/Locale;->ENGLISH:Ljava/util/Locale;

    invoke-virtual {p1, v2}, Ljava/lang/String;->toLowerCase(Ljava/util/Locale;)Ljava/lang/String;

    move-result-object v2

    invoke-interface {v1, v2}, Ljava/util/Map;->get(Ljava/lang/Object;)Ljava/lang/Object;

    move-result-object v1

    check-cast v1, Ljava/util/List;

    .line 202
    if-eqz v1, :cond_0

    .line 203
    invoke-interface {v1}, Ljava/util/List;->size()I

    move-result v0

    new-array v0, v0, [Ljava/lang/String;

    .line 204
    invoke-interface {v1, v0}, Ljava/util/List;->toArray([Ljava/lang/Object;)[Ljava/lang/Object;

    move-result-object v0

    check-cast v0, [Ljava/lang/String;

    .line 206
    :cond_0
    return-object v0
.end method

.method protected parseLine(Ljava/lang/String;)V
    .locals 14
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Lcom/sun/activation/registries/MailcapParseException;,
            Ljava/io/IOException;
        }
    .end annotation

    .prologue
    const/4 v2, 0x1

    const/4 v12, 0x5

    const/4 v3, 0x0

    const/4 v11, 0x2

    const/16 v10, 0x3b

    .line 309
    new-instance v4, Lcom/sun/activation/registries/MailcapTokenizer;

    invoke-direct {v4, p1}, Lcom/sun/activation/registries/MailcapTokenizer;-><init>(Ljava/lang/String;)V

    .line 310
    invoke-virtual {v4, v3}, Lcom/sun/activation/registries/MailcapTokenizer;->setIsAutoquoting(Z)V

    .line 312
    invoke-static {}, Lcom/sun/activation/registries/LogSupport;->isLoggable()Z

    move-result v0

    if-eqz v0, :cond_0

    .line 313
    new-instance v0, Ljava/lang/StringBuilder;

    const-string v1, "parse: "

    invoke-direct {v0, v1}, Ljava/lang/StringBuilder;-><init>(Ljava/lang/String;)V

    invoke-virtual {v0, p1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-virtual {v0}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v0

    invoke-static {v0}, Lcom/sun/activation/registries/LogSupport;->log(Ljava/lang/String;)V

    .line 315
    :cond_0
    invoke-virtual {v4}, Lcom/sun/activation/registries/MailcapTokenizer;->nextToken()I

    move-result v0

    .line 316
    if-eq v0, v11, :cond_1

    .line 318
    invoke-virtual {v4}, Lcom/sun/activation/registries/MailcapTokenizer;->getCurrentTokenValue()Ljava/lang/String;

    move-result-object v1

    .line 317
    invoke-static {v11, v0, v1}, Lcom/sun/activation/registries/MailcapFile;->reportParseError(IILjava/lang/String;)V

    .line 321
    :cond_1
    invoke-virtual {v4}, Lcom/sun/activation/registries/MailcapTokenizer;->getCurrentTokenValue()Ljava/lang/String;

    move-result-object v0

    sget-object v1, Ljava/util/Locale;->ENGLISH:Ljava/util/Locale;

    invoke-virtual {v0, v1}, Ljava/lang/String;->toLowerCase(Ljava/util/Locale;)Ljava/lang/String;

    move-result-object v5

    .line 322
    const-string v0, "*"

    .line 326
    invoke-virtual {v4}, Lcom/sun/activation/registries/MailcapTokenizer;->nextToken()I

    move-result v1

    .line 327
    const/16 v6, 0x2f

    if-eq v1, v6, :cond_2

    .line 328
    if-eq v1, v10, :cond_2

    .line 329
    const/16 v6, 0x2f

    .line 331
    invoke-virtual {v4}, Lcom/sun/activation/registries/MailcapTokenizer;->getCurrentTokenValue()Ljava/lang/String;

    move-result-object v7

    .line 329
    invoke-static {v6, v10, v1, v7}, Lcom/sun/activation/registries/MailcapFile;->reportParseError(IIILjava/lang/String;)V

    .line 335
    :cond_2
    const/16 v6, 0x2f

    if-ne v1, v6, :cond_4

    .line 337
    invoke-virtual {v4}, Lcom/sun/activation/registries/MailcapTokenizer;->nextToken()I

    move-result v0

    .line 338
    if-eq v0, v11, :cond_3

    .line 340
    invoke-virtual {v4}, Lcom/sun/activation/registries/MailcapTokenizer;->getCurrentTokenValue()Ljava/lang/String;

    move-result-object v1

    .line 339
    invoke-static {v11, v0, v1}, Lcom/sun/activation/registries/MailcapFile;->reportParseError(IILjava/lang/String;)V

    .line 343
    :cond_3
    invoke-virtual {v4}, Lcom/sun/activation/registries/MailcapTokenizer;->getCurrentTokenValue()Ljava/lang/String;

    move-result-object v0

    sget-object v1, Ljava/util/Locale;->ENGLISH:Ljava/util/Locale;

    invoke-virtual {v0, v1}, Ljava/lang/String;->toLowerCase(Ljava/util/Locale;)Ljava/lang/String;

    move-result-object v0

    .line 346
    invoke-virtual {v4}, Lcom/sun/activation/registries/MailcapTokenizer;->nextToken()I

    move-result v1

    .line 349
    :cond_4
    new-instance v6, Ljava/lang/StringBuilder;

    invoke-static {v5}, Ljava/lang/String;->valueOf(Ljava/lang/Object;)Ljava/lang/String;

    move-result-object v5

    invoke-direct {v6, v5}, Ljava/lang/StringBuilder;-><init>(Ljava/lang/String;)V

    const-string v5, "/"

    invoke-virtual {v6, v5}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v5

    invoke-virtual {v5, v0}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-virtual {v0}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v5

    .line 351
    invoke-static {}, Lcom/sun/activation/registries/LogSupport;->isLoggable()Z

    move-result v0

    if-eqz v0, :cond_5

    .line 352
    new-instance v0, Ljava/lang/StringBuilder;

    const-string v6, "  Type: "

    invoke-direct {v0, v6}, Ljava/lang/StringBuilder;-><init>(Ljava/lang/String;)V

    invoke-virtual {v0, v5}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-virtual {v0}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v0

    invoke-static {v0}, Lcom/sun/activation/registries/LogSupport;->log(Ljava/lang/String;)V

    .line 355
    :cond_5
    new-instance v6, Ljava/util/LinkedHashMap;

    invoke-direct {v6}, Ljava/util/LinkedHashMap;-><init>()V

    .line 358
    if-eq v1, v10, :cond_6

    .line 360
    invoke-virtual {v4}, Lcom/sun/activation/registries/MailcapTokenizer;->getCurrentTokenValue()Ljava/lang/String;

    move-result-object v0

    .line 359
    invoke-static {v10, v1, v0}, Lcom/sun/activation/registries/MailcapFile;->reportParseError(IILjava/lang/String;)V

    .line 365
    :cond_6
    invoke-virtual {v4, v2}, Lcom/sun/activation/registries/MailcapTokenizer;->setIsAutoquoting(Z)V

    .line 366
    invoke-virtual {v4}, Lcom/sun/activation/registries/MailcapTokenizer;->nextToken()I

    move-result v1

    .line 367
    invoke-virtual {v4, v3}, Lcom/sun/activation/registries/MailcapTokenizer;->setIsAutoquoting(Z)V

    .line 368
    if-eq v1, v11, :cond_7

    .line 369
    if-eq v1, v10, :cond_7

    .line 372
    invoke-virtual {v4}, Lcom/sun/activation/registries/MailcapTokenizer;->getCurrentTokenValue()Ljava/lang/String;

    move-result-object v0

    .line 370
    invoke-static {v11, v10, v1, v0}, Lcom/sun/activation/registries/MailcapFile;->reportParseError(IIILjava/lang/String;)V

    .line 375
    :cond_7
    if-ne v1, v11, :cond_8

    .line 378
    iget-object v0, p0, Lcom/sun/activation/registries/MailcapFile;->native_commands:Ljava/util/Map;

    invoke-interface {v0, v5}, Ljava/util/Map;->get(Ljava/lang/Object;)Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Ljava/util/List;

    .line 379
    if-nez v0, :cond_e

    .line 380
    new-instance v0, Ljava/util/ArrayList;

    invoke-direct {v0}, Ljava/util/ArrayList;-><init>()V

    .line 381
    invoke-interface {v0, p1}, Ljava/util/List;->add(Ljava/lang/Object;)Z

    .line 382
    iget-object v7, p0, Lcom/sun/activation/registries/MailcapFile;->native_commands:Ljava/util/Map;

    invoke-interface {v7, v5, v0}, Ljava/util/Map;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    .line 390
    :cond_8
    :goto_0
    if-eq v1, v10, :cond_1e

    .line 391
    invoke-virtual {v4}, Lcom/sun/activation/registries/MailcapTokenizer;->nextToken()I

    move-result v0

    .line 396
    :goto_1
    if-ne v0, v10, :cond_1b

    move v1, v3

    .line 402
    :goto_2
    invoke-virtual {v4}, Lcom/sun/activation/registries/MailcapTokenizer;->nextToken()I

    move-result v0

    .line 403
    if-eq v0, v11, :cond_9

    .line 405
    invoke-virtual {v4}, Lcom/sun/activation/registries/MailcapTokenizer;->getCurrentTokenValue()Ljava/lang/String;

    move-result-object v7

    .line 404
    invoke-static {v11, v0, v7}, Lcom/sun/activation/registries/MailcapFile;->reportParseError(IILjava/lang/String;)V

    .line 407
    :cond_9
    invoke-virtual {v4}, Lcom/sun/activation/registries/MailcapTokenizer;->getCurrentTokenValue()Ljava/lang/String;

    move-result-object v0

    .line 408
    sget-object v7, Ljava/util/Locale;->ENGLISH:Ljava/util/Locale;

    invoke-virtual {v0, v7}, Ljava/lang/String;->toLowerCase(Ljava/util/Locale;)Ljava/lang/String;

    move-result-object v7

    .line 411
    invoke-virtual {v4}, Lcom/sun/activation/registries/MailcapTokenizer;->nextToken()I

    move-result v0

    .line 412
    const/16 v8, 0x3d

    if-eq v0, v8, :cond_a

    .line 413
    if-eq v0, v10, :cond_a

    .line 414
    if-eq v0, v12, :cond_a

    .line 415
    const/16 v8, 0x3d

    .line 418
    invoke-virtual {v4}, Lcom/sun/activation/registries/MailcapTokenizer;->getCurrentTokenValue()Ljava/lang/String;

    move-result-object v9

    .line 415
    invoke-static {v8, v10, v12, v0, v9}, Lcom/sun/activation/registries/MailcapFile;->reportParseError(IIIILjava/lang/String;)V

    .line 422
    :cond_a
    const/16 v8, 0x3d

    if-ne v0, v8, :cond_1d

    .line 426
    invoke-virtual {v4, v2}, Lcom/sun/activation/registries/MailcapTokenizer;->setIsAutoquoting(Z)V

    .line 427
    invoke-virtual {v4}, Lcom/sun/activation/registries/MailcapTokenizer;->nextToken()I

    move-result v0

    .line 428
    invoke-virtual {v4, v3}, Lcom/sun/activation/registries/MailcapTokenizer;->setIsAutoquoting(Z)V

    .line 429
    if-eq v0, v11, :cond_b

    .line 431
    invoke-virtual {v4}, Lcom/sun/activation/registries/MailcapTokenizer;->getCurrentTokenValue()Ljava/lang/String;

    move-result-object v8

    .line 430
    invoke-static {v11, v0, v8}, Lcom/sun/activation/registries/MailcapFile;->reportParseError(IILjava/lang/String;)V

    .line 434
    :cond_b
    invoke-virtual {v4}, Lcom/sun/activation/registries/MailcapTokenizer;->getCurrentTokenValue()Ljava/lang/String;

    move-result-object v8

    .line 437
    const-string v0, "x-java-"

    invoke-virtual {v7, v0}, Ljava/lang/String;->startsWith(Ljava/lang/String;)Z

    move-result v0

    if-eqz v0, :cond_c

    .line 438
    const/4 v0, 0x7

    invoke-virtual {v7, v0}, Ljava/lang/String;->substring(I)Ljava/lang/String;

    move-result-object v7

    .line 441
    const-string v0, "fallback-entry"

    invoke-virtual {v7, v0}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v0

    if-eqz v0, :cond_f

    .line 442
    const-string v0, "true"

    invoke-virtual {v8, v0}, Ljava/lang/String;->equalsIgnoreCase(Ljava/lang/String;)Z

    move-result v0

    if-eqz v0, :cond_f

    move v1, v2

    .line 463
    :cond_c
    :goto_3
    invoke-virtual {v4}, Lcom/sun/activation/registries/MailcapTokenizer;->nextToken()I

    move-result v0

    move v13, v1

    move v1, v0

    move v0, v13

    .line 465
    :goto_4
    if-eq v1, v10, :cond_1c

    .line 467
    if-eqz v0, :cond_13

    iget-object v0, p0, Lcom/sun/activation/registries/MailcapFile;->fallback_hash:Ljava/util/Map;

    move-object v1, v0

    .line 469
    :goto_5
    invoke-interface {v1, v5}, Ljava/util/Map;->get(Ljava/lang/Object;)Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Ljava/util/Map;

    .line 470
    if-nez v0, :cond_14

    .line 471
    invoke-interface {v1, v5, v6}, Ljava/util/Map;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    .line 510
    :cond_d
    :goto_6
    return-void

    .line 385
    :cond_e
    invoke-interface {v0, p1}, Ljava/util/List;->add(Ljava/lang/Object;)Z

    goto/16 :goto_0

    .line 447
    :cond_f
    invoke-static {}, Lcom/sun/activation/registries/LogSupport;->isLoggable()Z

    move-result v0

    if-eqz v0, :cond_10

    .line 448
    new-instance v0, Ljava/lang/StringBuilder;

    const-string v9, "    Command: "

    invoke-direct {v0, v9}, Ljava/lang/StringBuilder;-><init>(Ljava/lang/String;)V

    invoke-virtual {v0, v7}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    .line 449
    const-string v9, ", Class: "

    invoke-virtual {v0, v9}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-virtual {v0, v8}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    .line 448
    invoke-virtual {v0}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v0

    invoke-static {v0}, Lcom/sun/activation/registries/LogSupport;->log(Ljava/lang/String;)V

    .line 450
    :cond_10
    invoke-interface {v6, v7}, Ljava/util/Map;->get(Ljava/lang/Object;)Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Ljava/util/List;

    .line 451
    if-nez v0, :cond_11

    .line 452
    new-instance v0, Ljava/util/ArrayList;

    invoke-direct {v0}, Ljava/util/ArrayList;-><init>()V

    .line 453
    invoke-interface {v6, v7, v0}, Ljava/util/Map;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    .line 455
    :cond_11
    sget-boolean v7, Lcom/sun/activation/registries/MailcapFile;->addReverse:Z

    if-eqz v7, :cond_12

    .line 456
    invoke-interface {v0, v3, v8}, Ljava/util/List;->add(ILjava/lang/Object;)V

    goto :goto_3

    .line 458
    :cond_12
    invoke-interface {v0, v8}, Ljava/util/List;->add(Ljava/lang/Object;)Z

    goto :goto_3

    .line 467
    :cond_13
    iget-object v0, p0, Lcom/sun/activation/registries/MailcapFile;->type_hash:Ljava/util/Map;

    move-object v1, v0

    goto :goto_5

    .line 473
    :cond_14
    invoke-static {}, Lcom/sun/activation/registries/LogSupport;->isLoggable()Z

    move-result v1

    if-eqz v1, :cond_15

    .line 474
    new-instance v1, Ljava/lang/StringBuilder;

    const-string v2, "Merging commands for type "

    invoke-direct {v1, v2}, Ljava/lang/StringBuilder;-><init>(Ljava/lang/String;)V

    invoke-virtual {v1, v5}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v1

    invoke-static {v1}, Lcom/sun/activation/registries/LogSupport;->log(Ljava/lang/String;)V

    .line 477
    :cond_15
    invoke-interface {v0}, Ljava/util/Map;->keySet()Ljava/util/Set;

    move-result-object v1

    invoke-interface {v1}, Ljava/util/Set;->iterator()Ljava/util/Iterator;

    move-result-object v4

    .line 478
    :cond_16
    invoke-interface {v4}, Ljava/util/Iterator;->hasNext()Z

    move-result v1

    if-nez v1, :cond_18

    .line 496
    invoke-interface {v6}, Ljava/util/Map;->keySet()Ljava/util/Set;

    move-result-object v1

    invoke-interface {v1}, Ljava/util/Set;->iterator()Ljava/util/Iterator;

    move-result-object v3

    .line 497
    :cond_17
    :goto_7
    invoke-interface {v3}, Ljava/util/Iterator;->hasNext()Z

    move-result v1

    if-eqz v1, :cond_d

    .line 498
    invoke-interface {v3}, Ljava/util/Iterator;->next()Ljava/lang/Object;

    move-result-object v1

    check-cast v1, Ljava/lang/String;

    .line 499
    invoke-interface {v0, v1}, Ljava/util/Map;->containsKey(Ljava/lang/Object;)Z

    move-result v2

    if-nez v2, :cond_17

    .line 501
    invoke-interface {v6, v1}, Ljava/util/Map;->get(Ljava/lang/Object;)Ljava/lang/Object;

    move-result-object v2

    check-cast v2, Ljava/util/List;

    .line 502
    invoke-interface {v0, v1, v2}, Ljava/util/Map;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    goto :goto_7

    .line 479
    :cond_18
    invoke-interface {v4}, Ljava/util/Iterator;->next()Ljava/lang/Object;

    move-result-object v1

    check-cast v1, Ljava/lang/String;

    .line 480
    invoke-interface {v0, v1}, Ljava/util/Map;->get(Ljava/lang/Object;)Ljava/lang/Object;

    move-result-object v2

    check-cast v2, Ljava/util/List;

    .line 481
    invoke-interface {v6, v1}, Ljava/util/Map;->get(Ljava/lang/Object;)Ljava/lang/Object;

    move-result-object v1

    check-cast v1, Ljava/util/List;

    .line 482
    if-eqz v1, :cond_16

    .line 485
    invoke-interface {v1}, Ljava/util/List;->iterator()Ljava/util/Iterator;

    move-result-object v5

    .line 486
    :cond_19
    :goto_8
    invoke-interface {v5}, Ljava/util/Iterator;->hasNext()Z

    move-result v1

    if-eqz v1, :cond_16

    .line 487
    invoke-interface {v5}, Ljava/util/Iterator;->next()Ljava/lang/Object;

    move-result-object v1

    check-cast v1, Ljava/lang/String;

    .line 488
    invoke-interface {v2, v1}, Ljava/util/List;->contains(Ljava/lang/Object;)Z

    move-result v7

    if-nez v7, :cond_19

    .line 489
    sget-boolean v7, Lcom/sun/activation/registries/MailcapFile;->addReverse:Z

    if-eqz v7, :cond_1a

    .line 490
    invoke-interface {v2, v3, v1}, Ljava/util/List;->add(ILjava/lang/Object;)V

    goto :goto_8

    .line 492
    :cond_1a
    invoke-interface {v2, v1}, Ljava/util/List;->add(Ljava/lang/Object;)Z

    goto :goto_8

    .line 505
    :cond_1b
    if-eq v0, v12, :cond_d

    .line 508
    invoke-virtual {v4}, Lcom/sun/activation/registries/MailcapTokenizer;->getCurrentTokenValue()Ljava/lang/String;

    move-result-object v1

    .line 506
    invoke-static {v12, v10, v0, v1}, Lcom/sun/activation/registries/MailcapFile;->reportParseError(IIILjava/lang/String;)V

    goto/16 :goto_6

    :cond_1c
    move v1, v0

    goto/16 :goto_2

    :cond_1d
    move v13, v1

    move v1, v0

    move v0, v13

    goto/16 :goto_4

    :cond_1e
    move v0, v1

    goto/16 :goto_1
.end method
