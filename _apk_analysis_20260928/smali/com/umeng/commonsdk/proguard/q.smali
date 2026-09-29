.class public Lcom/umeng/commonsdk/proguard/q;
.super Ljava/lang/Object;
.source "SDStorage.java"


# static fields
.field private static final b:Ljava/lang/String; = "/.um/.umm.dat"

.field private static final c:Ljava/lang/String; = "/.uxx/.cca.dat"

.field private static final d:Ljava/lang/String; = "/.cc/.adfwe.dat"

.field private static final e:Ljava/lang/String; = "/.a.dat"

.field private static final f:Ljava/lang/String; = "umdat"


# instance fields
.field private a:Landroid/content/Context;


# direct methods
.method public constructor <init>(Landroid/content/Context;)V
    .locals 0

    .prologue
    .line 31
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    .line 32
    iput-object p1, p0, Lcom/umeng/commonsdk/proguard/q;->a:Landroid/content/Context;

    .line 33
    return-void
.end method

.method private a(Ljava/lang/String;Ljava/lang/String;)V
    .locals 4

    .prologue
    .line 120
    iget-object v0, p0, Lcom/umeng/commonsdk/proguard/q;->a:Landroid/content/Context;

    const-string v1, "android.permission.WRITE_EXTERNAL_STORAGE"

    invoke-static {v0, v1}, Lcom/umeng/commonsdk/statistics/common/DeviceConfig;->checkPermission(Landroid/content/Context;Ljava/lang/String;)Z

    move-result v0

    if-eqz v0, :cond_2

    .line 123
    :try_start_0
    invoke-static {}, Landroid/os/Environment;->getExternalStorageState()Ljava/lang/String;

    move-result-object v0

    .line 124
    if-eqz v0, :cond_2

    const-string v1, "mounted"

    invoke-virtual {v0, v1}, Ljava/lang/String;->equalsIgnoreCase(Ljava/lang/String;)Z

    move-result v0

    if-eqz v0, :cond_2

    .line 125
    invoke-direct {p0, p2}, Lcom/umeng/commonsdk/proguard/q;->b(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v0

    .line 126
    if-eqz v0, :cond_0

    invoke-virtual {v0, p1}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v0

    if-nez v0, :cond_2

    .line 127
    :cond_0
    new-instance v0, Ljava/io/File;

    new-instance v1, Ljava/lang/StringBuilder;

    invoke-direct {v1}, Ljava/lang/StringBuilder;-><init>()V

    invoke-static {}, Landroid/os/Environment;->getExternalStorageDirectory()Ljava/io/File;

    move-result-object v2

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/Object;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1, p2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v1

    invoke-direct {v0, v1}, Ljava/io/File;-><init>(Ljava/lang/String;)V

    .line 128
    invoke-virtual {v0}, Ljava/io/File;->getParentFile()Ljava/io/File;

    move-result-object v1

    if-eqz v1, :cond_1

    invoke-virtual {v0}, Ljava/io/File;->getParentFile()Ljava/io/File;

    move-result-object v1

    invoke-virtual {v1}, Ljava/io/File;->exists()Z

    move-result v1

    if-nez v1, :cond_1

    .line 129
    invoke-virtual {v0}, Ljava/io/File;->getParentFile()Ljava/io/File;

    move-result-object v0

    invoke-virtual {v0}, Ljava/io/File;->mkdir()Z

    .line 131
    :cond_1
    new-instance v0, Ljava/io/RandomAccessFile;

    new-instance v1, Ljava/lang/StringBuilder;

    invoke-direct {v1}, Ljava/lang/StringBuilder;-><init>()V

    .line 132
    invoke-static {}, Landroid/os/Environment;->getExternalStorageDirectory()Ljava/io/File;

    move-result-object v2

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/Object;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1, p2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v1

    const-string v2, "rw"

    invoke-direct {v0, v1, v2}, Ljava/io/RandomAccessFile;-><init>(Ljava/lang/String;Ljava/lang/String;)V

    .line 133
    invoke-virtual {p1}, Ljava/lang/String;->getBytes()[B

    move-result-object v1

    array-length v1, v1

    int-to-long v2, v1

    invoke-virtual {v0, v2, v3}, Ljava/io/RandomAccessFile;->setLength(J)V

    .line 135
    invoke-virtual {v0}, Ljava/io/RandomAccessFile;->getChannel()Ljava/nio/channels/FileChannel;

    move-result-object v0

    .line 136
    invoke-virtual {v0}, Ljava/nio/channels/FileChannel;->tryLock()Ljava/nio/channels/FileLock;

    move-result-object v1

    .line 138
    const/16 v2, 0x400

    invoke-static {v2}, Ljava/nio/ByteBuffer;->allocate(I)Ljava/nio/ByteBuffer;

    move-result-object v2

    .line 139
    invoke-virtual {v2}, Ljava/nio/ByteBuffer;->clear()Ljava/nio/Buffer;

    .line 140
    invoke-virtual {p1}, Ljava/lang/String;->getBytes()[B

    move-result-object v3

    invoke-virtual {v2, v3}, Ljava/nio/ByteBuffer;->put([B)Ljava/nio/ByteBuffer;

    .line 141
    invoke-virtual {v2}, Ljava/nio/ByteBuffer;->flip()Ljava/nio/Buffer;

    .line 143
    :goto_0
    invoke-virtual {v2}, Ljava/nio/ByteBuffer;->hasRemaining()Z

    move-result v3

    if-eqz v3, :cond_3

    .line 144
    invoke-virtual {v0, v2}, Ljava/nio/channels/FileChannel;->write(Ljava/nio/ByteBuffer;)I
    :try_end_0
    .catch Ljava/lang/Exception; {:try_start_0 .. :try_end_0} :catch_0

    goto :goto_0

    .line 157
    :catch_0
    move-exception v0

    .line 158
    if-eqz v0, :cond_2

    .line 159
    new-instance v1, Ljava/lang/StringBuilder;

    invoke-direct {v1}, Ljava/lang/StringBuilder;-><init>()V

    const-string v2, "saveFileUmtt:"

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v0}, Ljava/lang/Exception;->getMessage()Ljava/lang/String;

    move-result-object v0

    invoke-virtual {v1, v0}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-virtual {v0}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v0

    invoke-static {v0}, Lcom/umeng/commonsdk/statistics/common/e;->e(Ljava/lang/String;)V

    .line 164
    :cond_2
    :goto_1
    return-void

    .line 147
    :cond_3
    const/4 v2, 0x1

    :try_start_1
    invoke-virtual {v0, v2}, Ljava/nio/channels/FileChannel;->force(Z)V

    .line 149
    if-eqz v1, :cond_4

    .line 150
    invoke-virtual {v1}, Ljava/nio/channels/FileLock;->release()V

    .line 153
    :cond_4
    invoke-virtual {v0}, Ljava/nio/channels/FileChannel;->close()V
    :try_end_1
    .catch Ljava/lang/Exception; {:try_start_1 .. :try_end_1} :catch_0

    goto :goto_1
.end method

.method private b(Ljava/lang/String;)Ljava/lang/String;
    .locals 8

    .prologue
    .line 173
    const/4 v0, 0x0

    .line 176
    :try_start_0
    iget-object v1, p0, Lcom/umeng/commonsdk/proguard/q;->a:Landroid/content/Context;

    const-string v2, "android.permission.READ_EXTERNAL_STORAGE"

    invoke-static {v1, v2}, Lcom/umeng/commonsdk/statistics/common/DeviceConfig;->checkPermission(Landroid/content/Context;Ljava/lang/String;)Z

    move-result v1

    if-eqz v1, :cond_0

    .line 177
    invoke-static {}, Landroid/os/Environment;->getExternalStorageState()Ljava/lang/String;

    move-result-object v1

    .line 178
    if-eqz v1, :cond_0

    const-string v2, "mounted"

    invoke-virtual {v1, v2}, Ljava/lang/String;->equalsIgnoreCase(Ljava/lang/String;)Z

    move-result v1

    if-eqz v1, :cond_0

    .line 180
    new-instance v1, Ljava/io/File;

    new-instance v2, Ljava/lang/StringBuilder;

    invoke-direct {v2}, Ljava/lang/StringBuilder;-><init>()V

    invoke-static {}, Landroid/os/Environment;->getExternalStorageDirectory()Ljava/io/File;

    move-result-object v3

    invoke-virtual {v2, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/Object;)Ljava/lang/StringBuilder;

    move-result-object v2

    invoke-virtual {v2, p1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    invoke-virtual {v2}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v2

    invoke-direct {v1, v2}, Ljava/io/File;-><init>(Ljava/lang/String;)V

    .line 181
    invoke-virtual {v1}, Ljava/io/File;->exists()Z

    move-result v1

    if-nez v1, :cond_1

    .line 219
    :cond_0
    :goto_0
    return-object v0

    .line 185
    :cond_1
    new-instance v1, Ljava/io/RandomAccessFile;

    new-instance v2, Ljava/lang/StringBuilder;

    invoke-direct {v2}, Ljava/lang/StringBuilder;-><init>()V

    .line 186
    invoke-static {}, Landroid/os/Environment;->getExternalStorageDirectory()Ljava/io/File;

    move-result-object v3

    invoke-virtual {v2, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/Object;)Ljava/lang/StringBuilder;

    move-result-object v2

    invoke-virtual {v2, p1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    invoke-virtual {v2}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v2

    const-string v3, "rw"

    invoke-direct {v1, v2, v3}, Ljava/io/RandomAccessFile;-><init>(Ljava/lang/String;Ljava/lang/String;)V

    .line 187
    invoke-virtual {v1}, Ljava/io/RandomAccessFile;->getChannel()Ljava/nio/channels/FileChannel;

    move-result-object v2

    .line 188
    invoke-virtual {v2}, Ljava/nio/channels/FileChannel;->tryLock()Ljava/nio/channels/FileLock;

    move-result-object v3

    .line 190
    new-instance v4, Ljava/lang/StringBuilder;

    invoke-direct {v4}, Ljava/lang/StringBuilder;-><init>()V

    .line 192
    const/16 v1, 0x400

    invoke-static {v1}, Ljava/nio/ByteBuffer;->allocate(I)Ljava/nio/ByteBuffer;

    move-result-object v5

    .line 193
    invoke-virtual {v5}, Ljava/nio/ByteBuffer;->clear()Ljava/nio/Buffer;

    .line 195
    :goto_1
    invoke-virtual {v2, v5}, Ljava/nio/channels/FileChannel;->read(Ljava/nio/ByteBuffer;)I

    move-result v1

    const/4 v6, -0x1

    if-eq v1, v6, :cond_3

    .line 196
    invoke-virtual {v5}, Ljava/nio/ByteBuffer;->position()I

    move-result v1

    new-array v6, v1, [B

    .line 198
    const/4 v1, 0x0

    :goto_2
    invoke-virtual {v5}, Ljava/nio/ByteBuffer;->position()I

    move-result v7

    if-ge v1, v7, :cond_2

    .line 199
    invoke-virtual {v5, v1}, Ljava/nio/ByteBuffer;->get(I)B

    move-result v7

    aput-byte v7, v6, v1

    .line 198
    add-int/lit8 v1, v1, 0x1

    goto :goto_2

    .line 202
    :cond_2
    new-instance v1, Ljava/lang/String;

    invoke-direct {v1, v6}, Ljava/lang/String;-><init>([B)V

    invoke-virtual {v4, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    .line 204
    invoke-virtual {v5}, Ljava/nio/ByteBuffer;->clear()Ljava/nio/Buffer;
    :try_end_0
    .catch Ljava/lang/Exception; {:try_start_0 .. :try_end_0} :catch_0

    goto :goto_1

    .line 214
    :catch_0
    move-exception v1

    .line 215
    if-eqz v1, :cond_0

    .line 216
    new-instance v2, Ljava/lang/StringBuilder;

    invoke-direct {v2}, Ljava/lang/StringBuilder;-><init>()V

    const-string v3, "getFileUmtt:"

    invoke-virtual {v2, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    invoke-virtual {v1}, Ljava/lang/Exception;->getMessage()Ljava/lang/String;

    move-result-object v1

    invoke-virtual {v2, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v1

    invoke-static {v1}, Lcom/umeng/commonsdk/statistics/common/e;->e(Ljava/lang/String;)V

    goto :goto_0

    .line 207
    :cond_3
    if-eqz v2, :cond_4

    .line 208
    :try_start_1
    invoke-virtual {v3}, Ljava/nio/channels/FileLock;->release()V

    .line 210
    :cond_4
    invoke-virtual {v2}, Ljava/nio/channels/FileChannel;->close()V

    .line 211
    invoke-virtual {v4}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;
    :try_end_1
    .catch Ljava/lang/Exception; {:try_start_1 .. :try_end_1} :catch_0

    move-result-object v0

    goto/16 :goto_0
.end method

.method private c(Ljava/lang/String;)V
    .locals 3

    .prologue
    .line 228
    iget-object v0, p0, Lcom/umeng/commonsdk/proguard/q;->a:Landroid/content/Context;

    invoke-virtual {v0}, Landroid/content/Context;->getApplicationContext()Landroid/content/Context;

    move-result-object v0

    const-string v1, "umdat"

    const/4 v2, 0x0

    .line 229
    invoke-virtual {v0, v1, v2}, Landroid/content/Context;->getSharedPreferences(Ljava/lang/String;I)Landroid/content/SharedPreferences;

    move-result-object v0

    .line 231
    if-eqz v0, :cond_1

    .line 232
    const-string v1, "u"

    const/4 v2, 0x0

    invoke-interface {v0, v1, v2}, Landroid/content/SharedPreferences;->getString(Ljava/lang/String;Ljava/lang/String;)Ljava/lang/String;

    move-result-object v1

    .line 233
    if-eqz v1, :cond_0

    invoke-virtual {v1, p1}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v1

    if-nez v1, :cond_1

    .line 234
    :cond_0
    invoke-interface {v0}, Landroid/content/SharedPreferences;->edit()Landroid/content/SharedPreferences$Editor;

    move-result-object v0

    const-string v1, "u"

    invoke-interface {v0, v1, p1}, Landroid/content/SharedPreferences$Editor;->putString(Ljava/lang/String;Ljava/lang/String;)Landroid/content/SharedPreferences$Editor;

    move-result-object v0

    invoke-interface {v0}, Landroid/content/SharedPreferences$Editor;->commit()Z

    .line 237
    :cond_1
    return-void
.end method

.method private h()Ljava/lang/String;
    .locals 3

    .prologue
    .line 95
    iget-object v0, p0, Lcom/umeng/commonsdk/proguard/q;->a:Landroid/content/Context;

    const-string v1, "umtt"

    const/4 v2, 0x0

    invoke-static {v0, v1, v2}, Lcom/umeng/commonsdk/framework/a;->a(Landroid/content/Context;Ljava/lang/String;Ljava/lang/String;)Ljava/lang/String;

    move-result-object v0

    .line 96
    return-object v0
.end method

.method private i()Ljava/lang/String;
    .locals 4

    .prologue
    const/4 v0, 0x0

    .line 245
    .line 246
    iget-object v1, p0, Lcom/umeng/commonsdk/proguard/q;->a:Landroid/content/Context;

    invoke-virtual {v1}, Landroid/content/Context;->getApplicationContext()Landroid/content/Context;

    move-result-object v1

    const-string v2, "umdat"

    const/4 v3, 0x0

    .line 247
    invoke-virtual {v1, v2, v3}, Landroid/content/Context;->getSharedPreferences(Ljava/lang/String;I)Landroid/content/SharedPreferences;

    move-result-object v1

    .line 249
    if-eqz v1, :cond_0

    .line 250
    const-string v2, "u"

    invoke-interface {v1, v2, v0}, Landroid/content/SharedPreferences;->getString(Ljava/lang/String;Ljava/lang/String;)Ljava/lang/String;

    move-result-object v0

    .line 252
    :cond_0
    return-object v0
.end method


# virtual methods
.method public a()Ljava/lang/String;
    .locals 2

    .prologue
    .line 41
    invoke-virtual {p0}, Lcom/umeng/commonsdk/proguard/q;->b()Ljava/lang/String;

    move-result-object v0

    .line 42
    if-eqz v0, :cond_0

    const-string v1, ""

    invoke-virtual {v0, v1}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v1

    if-eqz v1, :cond_1

    .line 43
    :cond_0
    invoke-virtual {p0}, Lcom/umeng/commonsdk/proguard/q;->g()Ljava/lang/String;

    move-result-object v0

    .line 45
    :cond_1
    if-eqz v0, :cond_2

    const-string v1, ""

    invoke-virtual {v0, v1}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v1

    if-eqz v1, :cond_3

    .line 46
    :cond_2
    invoke-virtual {p0}, Lcom/umeng/commonsdk/proguard/q;->c()Ljava/lang/String;

    move-result-object v0

    .line 48
    :cond_3
    if-eqz v0, :cond_4

    const-string v1, ""

    invoke-virtual {v0, v1}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v1

    if-eqz v1, :cond_5

    .line 49
    :cond_4
    invoke-virtual {p0}, Lcom/umeng/commonsdk/proguard/q;->d()Ljava/lang/String;

    move-result-object v0

    .line 51
    :cond_5
    if-eqz v0, :cond_6

    const-string v1, ""

    invoke-virtual {v0, v1}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v1

    if-eqz v1, :cond_7

    .line 52
    :cond_6
    invoke-virtual {p0}, Lcom/umeng/commonsdk/proguard/q;->e()Ljava/lang/String;

    move-result-object v0

    .line 54
    :cond_7
    if-eqz v0, :cond_8

    const-string v1, ""

    invoke-virtual {v0, v1}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v1

    if-eqz v1, :cond_9

    .line 55
    :cond_8
    invoke-virtual {p0}, Lcom/umeng/commonsdk/proguard/q;->f()Ljava/lang/String;

    move-result-object v0

    .line 57
    :cond_9
    return-object v0
.end method

.method public a(Ljava/lang/String;)V
    .locals 1

    .prologue
    .line 105
    const-string v0, "/.um/.umm.dat"

    invoke-direct {p0, p1, v0}, Lcom/umeng/commonsdk/proguard/q;->a(Ljava/lang/String;Ljava/lang/String;)V

    .line 106
    const-string v0, "/.uxx/.cca.dat"

    invoke-direct {p0, p1, v0}, Lcom/umeng/commonsdk/proguard/q;->a(Ljava/lang/String;Ljava/lang/String;)V

    .line 107
    const-string v0, "/.cc/.adfwe.dat"

    invoke-direct {p0, p1, v0}, Lcom/umeng/commonsdk/proguard/q;->a(Ljava/lang/String;Ljava/lang/String;)V

    .line 108
    const-string v0, "/.a.dat"

    invoke-direct {p0, p1, v0}, Lcom/umeng/commonsdk/proguard/q;->a(Ljava/lang/String;Ljava/lang/String;)V

    .line 110
    invoke-direct {p0, p1}, Lcom/umeng/commonsdk/proguard/q;->c(Ljava/lang/String;)V

    .line 111
    return-void
.end method

.method public b()Ljava/lang/String;
    .locals 1

    .prologue
    .line 61
    invoke-direct {p0}, Lcom/umeng/commonsdk/proguard/q;->h()Ljava/lang/String;

    move-result-object v0

    return-object v0
.end method

.method public c()Ljava/lang/String;
    .locals 1

    .prologue
    .line 65
    const-string v0, "/.um/.umm.dat"

    invoke-direct {p0, v0}, Lcom/umeng/commonsdk/proguard/q;->b(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v0

    .line 66
    return-object v0
.end method

.method public d()Ljava/lang/String;
    .locals 1

    .prologue
    .line 70
    const-string v0, "/.uxx/.cca.dat"

    invoke-direct {p0, v0}, Lcom/umeng/commonsdk/proguard/q;->b(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v0

    .line 71
    return-object v0
.end method

.method public e()Ljava/lang/String;
    .locals 1

    .prologue
    .line 75
    const-string v0, "/.cc/.adfwe.dat"

    invoke-direct {p0, v0}, Lcom/umeng/commonsdk/proguard/q;->b(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v0

    .line 76
    return-object v0
.end method

.method public f()Ljava/lang/String;
    .locals 1

    .prologue
    .line 80
    const-string v0, "/.a.dat"

    invoke-direct {p0, v0}, Lcom/umeng/commonsdk/proguard/q;->b(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v0

    .line 81
    return-object v0
.end method

.method public g()Ljava/lang/String;
    .locals 1

    .prologue
    .line 85
    invoke-direct {p0}, Lcom/umeng/commonsdk/proguard/q;->i()Ljava/lang/String;

    move-result-object v0

    .line 86
    return-object v0
.end method
