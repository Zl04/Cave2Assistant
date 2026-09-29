.class public Lcom/umeng/commonsdk/statistics/idtracking/g;
.super Ljava/lang/Object;
.source "ImprintHandler.java"


# annotations
.annotation system Ldalvik/annotation/MemberClasses;
    value = {
        Lcom/umeng/commonsdk/statistics/idtracking/g$a;
    }
.end annotation


# static fields
.field private static final a:Ljava/lang/String; = "ImprintHandler"

.field private static b:Ljava/lang/Object; = null

.field private static final c:Ljava/lang/String; = ".imprint"

.field private static final d:[B

.field private static h:Lcom/umeng/commonsdk/statistics/idtracking/g;

.field private static i:Landroid/content/Context;


# instance fields
.field private e:Lcom/umeng/commonsdk/statistics/internal/d;

.field private f:Lcom/umeng/commonsdk/statistics/idtracking/g$a;

.field private g:Lcom/umeng/commonsdk/statistics/proto/d;


# direct methods
.method static constructor <clinit>()V
    .locals 1

    .prologue
    .line 36
    new-instance v0, Ljava/lang/Object;

    invoke-direct {v0}, Ljava/lang/Object;-><init>()V

    sput-object v0, Lcom/umeng/commonsdk/statistics/idtracking/g;->b:Ljava/lang/Object;

    .line 39
    const-string v0, "pbl0"

    invoke-virtual {v0}, Ljava/lang/String;->getBytes()[B

    move-result-object v0

    sput-object v0, Lcom/umeng/commonsdk/statistics/idtracking/g;->d:[B

    .line 45
    const/4 v0, 0x0

    sput-object v0, Lcom/umeng/commonsdk/statistics/idtracking/g;->h:Lcom/umeng/commonsdk/statistics/idtracking/g;

    return-void
.end method

.method private constructor <init>(Landroid/content/Context;)V
    .locals 1

    .prologue
    .line 49
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    .line 43
    new-instance v0, Lcom/umeng/commonsdk/statistics/idtracking/g$a;

    invoke-direct {v0}, Lcom/umeng/commonsdk/statistics/idtracking/g$a;-><init>()V

    iput-object v0, p0, Lcom/umeng/commonsdk/statistics/idtracking/g;->f:Lcom/umeng/commonsdk/statistics/idtracking/g$a;

    .line 44
    const/4 v0, 0x0

    iput-object v0, p0, Lcom/umeng/commonsdk/statistics/idtracking/g;->g:Lcom/umeng/commonsdk/statistics/proto/d;

    .line 50
    invoke-virtual {p1}, Landroid/content/Context;->getApplicationContext()Landroid/content/Context;

    move-result-object v0

    sput-object v0, Lcom/umeng/commonsdk/statistics/idtracking/g;->i:Landroid/content/Context;

    .line 51
    return-void
.end method

.method public static declared-synchronized a(Landroid/content/Context;)Lcom/umeng/commonsdk/statistics/idtracking/g;
    .locals 2

    .prologue
    .line 54
    const-class v1, Lcom/umeng/commonsdk/statistics/idtracking/g;

    monitor-enter v1

    :try_start_0
    sget-object v0, Lcom/umeng/commonsdk/statistics/idtracking/g;->h:Lcom/umeng/commonsdk/statistics/idtracking/g;

    if-nez v0, :cond_0

    .line 55
    new-instance v0, Lcom/umeng/commonsdk/statistics/idtracking/g;

    invoke-direct {v0, p0}, Lcom/umeng/commonsdk/statistics/idtracking/g;-><init>(Landroid/content/Context;)V

    sput-object v0, Lcom/umeng/commonsdk/statistics/idtracking/g;->h:Lcom/umeng/commonsdk/statistics/idtracking/g;

    .line 56
    sget-object v0, Lcom/umeng/commonsdk/statistics/idtracking/g;->h:Lcom/umeng/commonsdk/statistics/idtracking/g;

    invoke-direct {v0}, Lcom/umeng/commonsdk/statistics/idtracking/g;->e()V

    .line 59
    :cond_0
    sget-object v0, Lcom/umeng/commonsdk/statistics/idtracking/g;->h:Lcom/umeng/commonsdk/statistics/idtracking/g;
    :try_end_0
    .catchall {:try_start_0 .. :try_end_0} :catchall_0

    monitor-exit v1

    return-object v0

    .line 54
    :catchall_0
    move-exception v0

    monitor-exit v1

    throw v0
.end method

.method private a(Lcom/umeng/commonsdk/statistics/proto/d;Lcom/umeng/commonsdk/statistics/proto/d;)Lcom/umeng/commonsdk/statistics/proto/d;
    .locals 4

    .prologue
    .line 180
    if-nez p2, :cond_0

    .line 200
    :goto_0
    return-object p1

    .line 184
    :cond_0
    invoke-virtual {p1}, Lcom/umeng/commonsdk/statistics/proto/d;->c()Ljava/util/Map;

    move-result-object v2

    .line 185
    invoke-virtual {p2}, Lcom/umeng/commonsdk/statistics/proto/d;->c()Ljava/util/Map;

    move-result-object v0

    .line 187
    invoke-interface {v0}, Ljava/util/Map;->entrySet()Ljava/util/Set;

    move-result-object v0

    invoke-interface {v0}, Ljava/util/Set;->iterator()Ljava/util/Iterator;

    move-result-object v3

    :goto_1
    invoke-interface {v3}, Ljava/util/Iterator;->hasNext()Z

    move-result v0

    if-eqz v0, :cond_2

    invoke-interface {v3}, Ljava/util/Iterator;->next()Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Ljava/util/Map$Entry;

    .line 188
    invoke-interface {v0}, Ljava/util/Map$Entry;->getValue()Ljava/lang/Object;

    move-result-object v1

    check-cast v1, Lcom/umeng/commonsdk/statistics/proto/e;

    invoke-virtual {v1}, Lcom/umeng/commonsdk/statistics/proto/e;->d()Z

    move-result v1

    if-eqz v1, :cond_1

    .line 189
    invoke-interface {v0}, Ljava/util/Map$Entry;->getKey()Ljava/lang/Object;

    move-result-object v1

    invoke-interface {v0}, Ljava/util/Map$Entry;->getValue()Ljava/lang/Object;

    move-result-object v0

    invoke-interface {v2, v1, v0}, Ljava/util/Map;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    goto :goto_1

    .line 191
    :cond_1
    invoke-interface {v0}, Ljava/util/Map$Entry;->getKey()Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Ljava/lang/String;

    .line 192
    invoke-interface {v2, v0}, Ljava/util/Map;->remove(Ljava/lang/Object;)Ljava/lang/Object;

    .line 193
    iget-object v1, p0, Lcom/umeng/commonsdk/statistics/idtracking/g;->f:Lcom/umeng/commonsdk/statistics/idtracking/g$a;

    invoke-virtual {v1, v0}, Lcom/umeng/commonsdk/statistics/idtracking/g$a;->a(Ljava/lang/String;)V

    goto :goto_1

    .line 197
    :cond_2
    invoke-virtual {p2}, Lcom/umeng/commonsdk/statistics/proto/d;->f()I

    move-result v0

    invoke-virtual {p1, v0}, Lcom/umeng/commonsdk/statistics/proto/d;->a(I)Lcom/umeng/commonsdk/statistics/proto/d;

    .line 198
    invoke-virtual {p0, p1}, Lcom/umeng/commonsdk/statistics/idtracking/g;->a(Lcom/umeng/commonsdk/statistics/proto/d;)Ljava/lang/String;

    move-result-object v0

    invoke-virtual {p1, v0}, Lcom/umeng/commonsdk/statistics/proto/d;->a(Ljava/lang/String;)Lcom/umeng/commonsdk/statistics/proto/d;

    goto :goto_0
.end method

.method private a(Ljava/lang/String;Ljava/lang/String;)Z
    .locals 1

    .prologue
    .line 168
    if-nez p1, :cond_1

    .line 169
    if-eqz p2, :cond_0

    .line 170
    const/4 v0, 0x0

    .line 175
    :goto_0
    return v0

    .line 172
    :cond_0
    const/4 v0, 0x1

    goto :goto_0

    .line 175
    :cond_1
    invoke-virtual {p1, p2}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v0

    goto :goto_0
.end method

.method private c(Lcom/umeng/commonsdk/statistics/proto/d;)Z
    .locals 7

    .prologue
    const/4 v1, 0x0

    .line 85
    invoke-virtual {p1}, Lcom/umeng/commonsdk/statistics/proto/d;->i()Ljava/lang/String;

    move-result-object v0

    invoke-virtual {p0, p1}, Lcom/umeng/commonsdk/statistics/idtracking/g;->a(Lcom/umeng/commonsdk/statistics/proto/d;)Ljava/lang/String;

    move-result-object v2

    invoke-virtual {v0, v2}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v0

    if-nez v0, :cond_0

    move v0, v1

    .line 99
    :goto_0
    return v0

    .line 89
    :cond_0
    invoke-virtual {p1}, Lcom/umeng/commonsdk/statistics/proto/d;->c()Ljava/util/Map;

    move-result-object v0

    invoke-interface {v0}, Ljava/util/Map;->values()Ljava/util/Collection;

    move-result-object v0

    invoke-interface {v0}, Ljava/util/Collection;->iterator()Ljava/util/Iterator;

    move-result-object v2

    :cond_1
    invoke-interface {v2}, Ljava/util/Iterator;->hasNext()Z

    move-result v0

    if-eqz v0, :cond_3

    invoke-interface {v2}, Ljava/util/Iterator;->next()Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Lcom/umeng/commonsdk/statistics/proto/e;

    .line 90
    invoke-virtual {v0}, Lcom/umeng/commonsdk/statistics/proto/e;->h()Ljava/lang/String;

    move-result-object v3

    invoke-static {v3}, Lcom/umeng/commonsdk/statistics/common/DataHelper;->reverseHexString(Ljava/lang/String;)[B

    move-result-object v3

    .line 91
    invoke-virtual {p0, v0}, Lcom/umeng/commonsdk/statistics/idtracking/g;->a(Lcom/umeng/commonsdk/statistics/proto/e;)[B

    move-result-object v4

    move v0, v1

    .line 93
    :goto_1
    const/4 v5, 0x4

    if-ge v0, v5, :cond_1

    .line 94
    aget-byte v5, v3, v0

    aget-byte v6, v4, v0

    if-eq v5, v6, :cond_2

    move v0, v1

    .line 95
    goto :goto_0

    .line 93
    :cond_2
    add-int/lit8 v0, v0, 0x1

    goto :goto_1

    .line 99
    :cond_3
    const/4 v0, 0x1

    goto :goto_0
.end method

.method private d(Lcom/umeng/commonsdk/statistics/proto/d;)Lcom/umeng/commonsdk/statistics/proto/d;
    .locals 5

    .prologue
    .line 204
    invoke-virtual {p1}, Lcom/umeng/commonsdk/statistics/proto/d;->c()Ljava/util/Map;

    move-result-object v2

    .line 205
    new-instance v3, Ljava/util/ArrayList;

    invoke-interface {v2}, Ljava/util/Map;->size()I

    move-result v0

    div-int/lit8 v0, v0, 0x2

    invoke-direct {v3, v0}, Ljava/util/ArrayList;-><init>(I)V

    .line 207
    invoke-interface {v2}, Ljava/util/Map;->entrySet()Ljava/util/Set;

    move-result-object v0

    invoke-interface {v0}, Ljava/util/Set;->iterator()Ljava/util/Iterator;

    move-result-object v4

    :cond_0
    :goto_0
    invoke-interface {v4}, Ljava/util/Iterator;->hasNext()Z

    move-result v0

    if-eqz v0, :cond_1

    invoke-interface {v4}, Ljava/util/Iterator;->next()Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Ljava/util/Map$Entry;

    .line 208
    invoke-interface {v0}, Ljava/util/Map$Entry;->getValue()Ljava/lang/Object;

    move-result-object v1

    check-cast v1, Lcom/umeng/commonsdk/statistics/proto/e;

    invoke-virtual {v1}, Lcom/umeng/commonsdk/statistics/proto/e;->d()Z

    move-result v1

    if-nez v1, :cond_0

    .line 209
    invoke-interface {v0}, Ljava/util/Map$Entry;->getKey()Ljava/lang/Object;

    move-result-object v0

    invoke-interface {v3, v0}, Ljava/util/List;->add(Ljava/lang/Object;)Z

    goto :goto_0

    .line 213
    :cond_1
    invoke-interface {v3}, Ljava/util/List;->iterator()Ljava/util/Iterator;

    move-result-object v1

    :goto_1
    invoke-interface {v1}, Ljava/util/Iterator;->hasNext()Z

    move-result v0

    if-eqz v0, :cond_2

    invoke-interface {v1}, Ljava/util/Iterator;->next()Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Ljava/lang/String;

    .line 214
    invoke-interface {v2, v0}, Ljava/util/Map;->remove(Ljava/lang/Object;)Ljava/lang/Object;

    goto :goto_1

    .line 217
    :cond_2
    return-object p1
.end method

.method private e()V
    .locals 4

    .prologue
    const/4 v2, 0x0

    .line 229
    new-instance v0, Ljava/io/File;

    sget-object v1, Lcom/umeng/commonsdk/statistics/idtracking/g;->i:Landroid/content/Context;

    invoke-virtual {v1}, Landroid/content/Context;->getFilesDir()Ljava/io/File;

    move-result-object v1

    const-string v3, ".imprint"

    invoke-direct {v0, v1, v3}, Ljava/io/File;-><init>(Ljava/io/File;Ljava/lang/String;)V

    .line 231
    sget-object v3, Lcom/umeng/commonsdk/statistics/idtracking/g;->b:Ljava/lang/Object;

    monitor-enter v3

    .line 232
    :try_start_0
    invoke-virtual {v0}, Ljava/io/File;->exists()Z

    move-result v0

    if-nez v0, :cond_0

    .line 233
    monitor-exit v3
    :try_end_0
    .catchall {:try_start_0 .. :try_end_0} :catchall_0

    .line 259
    :goto_0
    return-void

    .line 239
    :cond_0
    :try_start_1
    sget-object v0, Lcom/umeng/commonsdk/statistics/idtracking/g;->i:Landroid/content/Context;

    const-string v1, ".imprint"

    invoke-virtual {v0, v1}, Landroid/content/Context;->openFileInput(Ljava/lang/String;)Ljava/io/FileInputStream;
    :try_end_1
    .catch Ljava/lang/Exception; {:try_start_1 .. :try_end_1} :catch_0
    .catchall {:try_start_1 .. :try_end_1} :catchall_1

    move-result-object v1

    .line 240
    :try_start_2
    invoke-static {v1}, Lcom/umeng/commonsdk/statistics/common/HelperUtils;->readStreamToByteArray(Ljava/io/InputStream;)[B
    :try_end_2
    .catch Ljava/lang/Exception; {:try_start_2 .. :try_end_2} :catch_2
    .catchall {:try_start_2 .. :try_end_2} :catchall_2

    move-result-object v2

    .line 244
    :try_start_3
    invoke-static {v1}, Lcom/umeng/commonsdk/statistics/common/HelperUtils;->safeClose(Ljava/io/InputStream;)V
    :try_end_3
    .catchall {:try_start_3 .. :try_end_3} :catchall_0

    .line 247
    :goto_1
    if-eqz v2, :cond_1

    .line 249
    :try_start_4
    new-instance v0, Lcom/umeng/commonsdk/statistics/proto/d;

    invoke-direct {v0}, Lcom/umeng/commonsdk/statistics/proto/d;-><init>()V

    .line 250
    new-instance v1, Lcom/umeng/commonsdk/proguard/ad;

    invoke-direct {v1}, Lcom/umeng/commonsdk/proguard/ad;-><init>()V

    invoke-virtual {v1, v0, v2}, Lcom/umeng/commonsdk/proguard/ad;->a(Lcom/umeng/commonsdk/proguard/aa;[B)V

    .line 251
    iput-object v0, p0, Lcom/umeng/commonsdk/statistics/idtracking/g;->g:Lcom/umeng/commonsdk/statistics/proto/d;

    .line 252
    iget-object v1, p0, Lcom/umeng/commonsdk/statistics/idtracking/g;->f:Lcom/umeng/commonsdk/statistics/idtracking/g$a;

    invoke-virtual {v1, v0}, Lcom/umeng/commonsdk/statistics/idtracking/g$a;->a(Lcom/umeng/commonsdk/statistics/proto/d;)V
    :try_end_4
    .catch Ljava/lang/Exception; {:try_start_4 .. :try_end_4} :catch_1
    .catchall {:try_start_4 .. :try_end_4} :catchall_0

    .line 257
    :cond_1
    :goto_2
    :try_start_5
    monitor-exit v3

    goto :goto_0

    :catchall_0
    move-exception v0

    monitor-exit v3
    :try_end_5
    .catchall {:try_start_5 .. :try_end_5} :catchall_0

    throw v0

    .line 241
    :catch_0
    move-exception v0

    move-object v1, v2

    .line 242
    :goto_3
    :try_start_6
    invoke-virtual {v0}, Ljava/lang/Exception;->printStackTrace()V
    :try_end_6
    .catchall {:try_start_6 .. :try_end_6} :catchall_2

    .line 244
    :try_start_7
    invoke-static {v1}, Lcom/umeng/commonsdk/statistics/common/HelperUtils;->safeClose(Ljava/io/InputStream;)V

    goto :goto_1

    :catchall_1
    move-exception v0

    :goto_4
    invoke-static {v2}, Lcom/umeng/commonsdk/statistics/common/HelperUtils;->safeClose(Ljava/io/InputStream;)V

    throw v0

    .line 253
    :catch_1
    move-exception v0

    .line 254
    invoke-virtual {v0}, Ljava/lang/Exception;->printStackTrace()V
    :try_end_7
    .catchall {:try_start_7 .. :try_end_7} :catchall_0

    goto :goto_2

    .line 244
    :catchall_2
    move-exception v0

    move-object v2, v1

    goto :goto_4

    .line 241
    :catch_2
    move-exception v0

    goto :goto_3
.end method


# virtual methods
.method public declared-synchronized a()Lcom/umeng/commonsdk/statistics/proto/d;
    .locals 1

    .prologue
    .line 221
    monitor-enter p0

    :try_start_0
    iget-object v0, p0, Lcom/umeng/commonsdk/statistics/idtracking/g;->g:Lcom/umeng/commonsdk/statistics/proto/d;
    :try_end_0
    .catchall {:try_start_0 .. :try_end_0} :catchall_0

    monitor-exit p0

    return-object v0

    :catchall_0
    move-exception v0

    monitor-exit p0

    throw v0
.end method

.method public a(Lcom/umeng/commonsdk/statistics/proto/d;)Ljava/lang/String;
    .locals 6

    .prologue
    .line 67
    new-instance v2, Ljava/lang/StringBuilder;

    invoke-direct {v2}, Ljava/lang/StringBuilder;-><init>()V

    .line 68
    new-instance v0, Ljava/util/TreeMap;

    invoke-virtual {p1}, Lcom/umeng/commonsdk/statistics/proto/d;->c()Ljava/util/Map;

    move-result-object v1

    invoke-direct {v0, v1}, Ljava/util/TreeMap;-><init>(Ljava/util/Map;)V

    .line 70
    invoke-interface {v0}, Ljava/util/Map;->entrySet()Ljava/util/Set;

    move-result-object v0

    invoke-interface {v0}, Ljava/util/Set;->iterator()Ljava/util/Iterator;

    move-result-object v3

    :goto_0
    invoke-interface {v3}, Ljava/util/Iterator;->hasNext()Z

    move-result v0

    if-eqz v0, :cond_1

    invoke-interface {v3}, Ljava/util/Iterator;->next()Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Ljava/util/Map$Entry;

    .line 71
    invoke-interface {v0}, Ljava/util/Map$Entry;->getKey()Ljava/lang/Object;

    move-result-object v1

    check-cast v1, Ljava/lang/String;

    invoke-virtual {v2, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    .line 72
    invoke-interface {v0}, Ljava/util/Map$Entry;->getValue()Ljava/lang/Object;

    move-result-object v1

    check-cast v1, Lcom/umeng/commonsdk/statistics/proto/e;

    invoke-virtual {v1}, Lcom/umeng/commonsdk/statistics/proto/e;->d()Z

    move-result v1

    if-eqz v1, :cond_0

    .line 73
    invoke-interface {v0}, Ljava/util/Map$Entry;->getValue()Ljava/lang/Object;

    move-result-object v1

    check-cast v1, Lcom/umeng/commonsdk/statistics/proto/e;

    invoke-virtual {v1}, Lcom/umeng/commonsdk/statistics/proto/e;->b()Ljava/lang/String;

    move-result-object v1

    invoke-virtual {v2, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    .line 75
    :cond_0
    invoke-interface {v0}, Ljava/util/Map$Entry;->getValue()Ljava/lang/Object;

    move-result-object v1

    check-cast v1, Lcom/umeng/commonsdk/statistics/proto/e;

    invoke-virtual {v1}, Lcom/umeng/commonsdk/statistics/proto/e;->e()J

    move-result-wide v4

    invoke-virtual {v2, v4, v5}, Ljava/lang/StringBuilder;->append(J)Ljava/lang/StringBuilder;

    .line 76
    invoke-interface {v0}, Ljava/util/Map$Entry;->getValue()Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Lcom/umeng/commonsdk/statistics/proto/e;

    invoke-virtual {v0}, Lcom/umeng/commonsdk/statistics/proto/e;->h()Ljava/lang/String;

    move-result-object v0

    invoke-virtual {v2, v0}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    goto :goto_0

    .line 79
    :cond_1
    iget v0, p1, Lcom/umeng/commonsdk/statistics/proto/d;->b:I

    invoke-virtual {v2, v0}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    .line 81
    invoke-virtual {v2}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v0

    invoke-static {v0}, Lcom/umeng/commonsdk/statistics/common/HelperUtils;->MD5(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v0

    sget-object v1, Ljava/util/Locale;->US:Ljava/util/Locale;

    invoke-virtual {v0, v1}, Ljava/lang/String;->toLowerCase(Ljava/util/Locale;)Ljava/lang/String;

    move-result-object v0

    return-object v0
.end method

.method public a(Lcom/umeng/commonsdk/statistics/internal/d;)V
    .locals 0

    .prologue
    .line 63
    iput-object p1, p0, Lcom/umeng/commonsdk/statistics/idtracking/g;->e:Lcom/umeng/commonsdk/statistics/internal/d;

    .line 64
    return-void
.end method

.method public a(Lcom/umeng/commonsdk/statistics/proto/e;)[B
    .locals 7

    .prologue
    const/4 v6, 0x4

    .line 103
    const/16 v0, 0x8

    invoke-static {v0}, Ljava/nio/ByteBuffer;->allocate(I)Ljava/nio/ByteBuffer;

    move-result-object v0

    .line 104
    const/4 v1, 0x0

    invoke-virtual {v0, v1}, Ljava/nio/ByteBuffer;->order(Ljava/nio/ByteOrder;)Ljava/nio/ByteBuffer;

    .line 105
    invoke-virtual {p1}, Lcom/umeng/commonsdk/statistics/proto/e;->e()J

    move-result-wide v2

    invoke-virtual {v0, v2, v3}, Ljava/nio/ByteBuffer;->putLong(J)Ljava/nio/ByteBuffer;

    .line 107
    invoke-virtual {v0}, Ljava/nio/ByteBuffer;->array()[B

    move-result-object v1

    .line 108
    sget-object v2, Lcom/umeng/commonsdk/statistics/idtracking/g;->d:[B

    .line 109
    new-array v3, v6, [B

    .line 111
    const/4 v0, 0x0

    :goto_0
    if-ge v0, v6, :cond_0

    .line 112
    aget-byte v4, v1, v0

    aget-byte v5, v2, v0

    xor-int/2addr v4, v5

    int-to-byte v4, v4

    aput-byte v4, v3, v0

    .line 111
    add-int/lit8 v0, v0, 0x1

    goto :goto_0

    .line 115
    :cond_0
    return-object v3
.end method

.method public b()Lcom/umeng/commonsdk/statistics/idtracking/g$a;
    .locals 1

    .prologue
    .line 225
    iget-object v0, p0, Lcom/umeng/commonsdk/statistics/idtracking/g;->f:Lcom/umeng/commonsdk/statistics/idtracking/g$a;

    return-object v0
.end method

.method public b(Lcom/umeng/commonsdk/statistics/proto/d;)V
    .locals 5

    .prologue
    const/4 v1, 0x0

    .line 119
    if-nez p1, :cond_1

    .line 120
    sget-boolean v0, Lcom/umeng/commonsdk/statistics/b;->f:Z

    if-eqz v0, :cond_0

    .line 121
    const-string v0, "Imprint is null"

    invoke-static {v0}, Lcom/umeng/commonsdk/statistics/common/MLog;->d(Ljava/lang/String;)V

    .line 165
    :cond_0
    :goto_0
    return-void

    .line 125
    :cond_1
    invoke-direct {p0, p1}, Lcom/umeng/commonsdk/statistics/idtracking/g;->c(Lcom/umeng/commonsdk/statistics/proto/d;)Z

    move-result v0

    if-nez v0, :cond_2

    .line 126
    sget-boolean v0, Lcom/umeng/commonsdk/statistics/b;->f:Z

    if-eqz v0, :cond_0

    .line 127
    const-string v0, "Imprint is not valid"

    invoke-static {v0}, Lcom/umeng/commonsdk/statistics/common/MLog;->e(Ljava/lang/String;)V

    goto :goto_0

    .line 130
    :cond_2
    sget-boolean v0, Lcom/umeng/commonsdk/statistics/b;->f:Z

    if-eqz v0, :cond_3

    .line 131
    const-string v0, "Imprint is ok"

    invoke-static {v0}, Lcom/umeng/commonsdk/statistics/common/MLog;->d(Ljava/lang/String;)V

    .line 134
    :cond_3
    const/4 v0, 0x0

    .line 135
    monitor-enter p0

    .line 136
    :try_start_0
    iget-object v4, p0, Lcom/umeng/commonsdk/statistics/idtracking/g;->g:Lcom/umeng/commonsdk/statistics/proto/d;

    .line 139
    if-nez v4, :cond_6

    move-object v3, v1

    .line 140
    :goto_1
    if-nez v4, :cond_7

    .line 141
    invoke-direct {p0, p1}, Lcom/umeng/commonsdk/statistics/idtracking/g;->d(Lcom/umeng/commonsdk/statistics/proto/d;)Lcom/umeng/commonsdk/statistics/proto/d;

    move-result-object v2

    .line 146
    :goto_2
    iput-object v2, p0, Lcom/umeng/commonsdk/statistics/idtracking/g;->g:Lcom/umeng/commonsdk/statistics/proto/d;

    .line 147
    if-nez v2, :cond_8

    .line 148
    :goto_3
    invoke-direct {p0, v3, v1}, Lcom/umeng/commonsdk/statistics/idtracking/g;->a(Ljava/lang/String;Ljava/lang/String;)Z

    move-result v1

    if-nez v1, :cond_4

    .line 149
    const/4 v0, 0x1

    .line 151
    :cond_4
    monitor-exit p0
    :try_end_0
    .catchall {:try_start_0 .. :try_end_0} :catchall_0

    .line 153
    iget-object v1, p0, Lcom/umeng/commonsdk/statistics/idtracking/g;->g:Lcom/umeng/commonsdk/statistics/proto/d;

    if-eqz v1, :cond_0

    .line 154
    sget-boolean v1, Lcom/umeng/commonsdk/statistics/b;->f:Z

    if-eqz v1, :cond_5

    .line 157
    :cond_5
    if-eqz v0, :cond_0

    .line 158
    iget-object v0, p0, Lcom/umeng/commonsdk/statistics/idtracking/g;->f:Lcom/umeng/commonsdk/statistics/idtracking/g$a;

    iget-object v1, p0, Lcom/umeng/commonsdk/statistics/idtracking/g;->g:Lcom/umeng/commonsdk/statistics/proto/d;

    invoke-virtual {v0, v1}, Lcom/umeng/commonsdk/statistics/idtracking/g$a;->a(Lcom/umeng/commonsdk/statistics/proto/d;)V

    .line 159
    iget-object v0, p0, Lcom/umeng/commonsdk/statistics/idtracking/g;->e:Lcom/umeng/commonsdk/statistics/internal/d;

    if-eqz v0, :cond_0

    .line 160
    iget-object v0, p0, Lcom/umeng/commonsdk/statistics/idtracking/g;->e:Lcom/umeng/commonsdk/statistics/internal/d;

    iget-object v1, p0, Lcom/umeng/commonsdk/statistics/idtracking/g;->f:Lcom/umeng/commonsdk/statistics/idtracking/g$a;

    invoke-interface {v0, v1}, Lcom/umeng/commonsdk/statistics/internal/d;->onImprintChanged(Lcom/umeng/commonsdk/statistics/idtracking/g$a;)V

    goto :goto_0

    .line 139
    :cond_6
    :try_start_1
    invoke-virtual {v4}, Lcom/umeng/commonsdk/statistics/proto/d;->i()Ljava/lang/String;

    move-result-object v2

    move-object v3, v2

    goto :goto_1

    .line 143
    :cond_7
    invoke-direct {p0, v4, p1}, Lcom/umeng/commonsdk/statistics/idtracking/g;->a(Lcom/umeng/commonsdk/statistics/proto/d;Lcom/umeng/commonsdk/statistics/proto/d;)Lcom/umeng/commonsdk/statistics/proto/d;

    move-result-object v2

    goto :goto_2

    .line 147
    :cond_8
    invoke-virtual {v2}, Lcom/umeng/commonsdk/statistics/proto/d;->i()Ljava/lang/String;

    move-result-object v1

    goto :goto_3

    .line 151
    :catchall_0
    move-exception v0

    monitor-exit p0
    :try_end_1
    .catchall {:try_start_1 .. :try_end_1} :catchall_0

    throw v0
.end method

.method public c()V
    .locals 6

    .prologue
    .line 262
    iget-object v0, p0, Lcom/umeng/commonsdk/statistics/idtracking/g;->g:Lcom/umeng/commonsdk/statistics/proto/d;

    if-nez v0, :cond_0

    .line 282
    :goto_0
    return-void

    .line 267
    :cond_0
    :try_start_0
    sget-object v1, Lcom/umeng/commonsdk/statistics/idtracking/g;->b:Ljava/lang/Object;

    monitor-enter v1
    :try_end_0
    .catch Ljava/lang/Exception; {:try_start_0 .. :try_end_0} :catch_0

    .line 268
    :try_start_1
    new-instance v0, Lcom/umeng/commonsdk/proguard/aj;

    invoke-direct {v0}, Lcom/umeng/commonsdk/proguard/aj;-><init>()V

    iget-object v2, p0, Lcom/umeng/commonsdk/statistics/idtracking/g;->g:Lcom/umeng/commonsdk/statistics/proto/d;

    invoke-virtual {v0, v2}, Lcom/umeng/commonsdk/proguard/aj;->a(Lcom/umeng/commonsdk/proguard/aa;)[B

    move-result-object v0

    .line 270
    new-instance v2, Ljava/io/FileOutputStream;

    new-instance v3, Ljava/io/File;

    sget-object v4, Lcom/umeng/commonsdk/statistics/idtracking/g;->i:Landroid/content/Context;

    invoke-virtual {v4}, Landroid/content/Context;->getFilesDir()Ljava/io/File;

    move-result-object v4

    const-string v5, ".imprint"

    invoke-direct {v3, v4, v5}, Ljava/io/File;-><init>(Ljava/io/File;Ljava/lang/String;)V

    invoke-direct {v2, v3}, Ljava/io/FileOutputStream;-><init>(Ljava/io/File;)V
    :try_end_1
    .catchall {:try_start_1 .. :try_end_1} :catchall_0

    .line 273
    :try_start_2
    invoke-virtual {v2, v0}, Ljava/io/FileOutputStream;->write([B)V

    .line 274
    invoke-virtual {v2}, Ljava/io/FileOutputStream;->flush()V
    :try_end_2
    .catchall {:try_start_2 .. :try_end_2} :catchall_1

    .line 276
    :try_start_3
    invoke-static {v2}, Lcom/umeng/commonsdk/statistics/common/HelperUtils;->safeClose(Ljava/io/OutputStream;)V

    .line 278
    monitor-exit v1

    goto :goto_0

    :catchall_0
    move-exception v0

    monitor-exit v1
    :try_end_3
    .catchall {:try_start_3 .. :try_end_3} :catchall_0

    :try_start_4
    throw v0
    :try_end_4
    .catch Ljava/lang/Exception; {:try_start_4 .. :try_end_4} :catch_0

    .line 279
    :catch_0
    move-exception v0

    .line 280
    invoke-virtual {v0}, Ljava/lang/Exception;->printStackTrace()V

    goto :goto_0

    .line 276
    :catchall_1
    move-exception v0

    :try_start_5
    invoke-static {v2}, Lcom/umeng/commonsdk/statistics/common/HelperUtils;->safeClose(Ljava/io/OutputStream;)V

    throw v0
    :try_end_5
    .catchall {:try_start_5 .. :try_end_5} :catchall_0
.end method

.method public d()Z
    .locals 3

    .prologue
    .line 285
    new-instance v0, Ljava/io/File;

    sget-object v1, Lcom/umeng/commonsdk/statistics/idtracking/g;->i:Landroid/content/Context;

    invoke-virtual {v1}, Landroid/content/Context;->getFilesDir()Ljava/io/File;

    move-result-object v1

    const-string v2, ".imprint"

    invoke-direct {v0, v1, v2}, Ljava/io/File;-><init>(Ljava/io/File;Ljava/lang/String;)V

    .line 286
    invoke-virtual {v0}, Ljava/io/File;->delete()Z

    move-result v0

    return v0
.end method
