.class public Lcom/cyjh/mobileanjian/ipc/IpcService;
.super Landroid/app/Service;
.source "SourceFile"


# static fields
.field private static final e:Ljava/lang/String; = "mqm_engine"

.field private static final f:Ljava/lang/String; = "ipc_server_port"

.field private static final g:Ljava/lang/String; = "/system/bin/app_process32"

.field private static final h:Ljava/lang/String; = "elfinject"

.field private static final i:Ljava/lang/String; = "model"

.field private static final j:Ljava/lang/String; = "code_cache"

.field private static final k:Ljava/lang/String; = "secondary-dexes"

.field private static final l:Ljava/lang/String; = "mycache"

.field private static final m:Ljava/lang/String; = "dalvik-cache"


# instance fields
.field private a:Ljava/lang/String;

.field private b:I

.field private c:Ljava/lang/String;

.field private d:Ljava/lang/String;


# direct methods
.method public constructor <init>()V
    .locals 1

    .prologue
    .line 28
    invoke-direct {p0}, Landroid/app/Service;-><init>()V

    .line 30
    const/4 v0, 0x0

    iput-object v0, p0, Lcom/cyjh/mobileanjian/ipc/IpcService;->a:Ljava/lang/String;

    .line 32
    const-string v0, ""

    iput-object v0, p0, Lcom/cyjh/mobileanjian/ipc/IpcService;->c:Ljava/lang/String;

    .line 33
    const-string v0, ""

    iput-object v0, p0, Lcom/cyjh/mobileanjian/ipc/IpcService;->d:Ljava/lang/String;

    return-void
.end method

.method static synthetic a(Lcom/cyjh/mobileanjian/ipc/IpcService;)Ljava/lang/String;
    .locals 1

    .prologue
    .line 28
    iget-object v0, p0, Lcom/cyjh/mobileanjian/ipc/IpcService;->a:Ljava/lang/String;

    return-object v0
.end method

.method private a()V
    .locals 11

    .prologue
    const/4 v10, 0x2

    const/4 v9, 0x1

    const/4 v8, 0x0

    .line 80
    invoke-virtual {p0}, Lcom/cyjh/mobileanjian/ipc/IpcService;->getApplicationContext()Landroid/content/Context;

    move-result-object v0

    invoke-virtual {v0}, Landroid/content/Context;->getFilesDir()Ljava/io/File;

    move-result-object v0

    invoke-virtual {v0}, Ljava/io/File;->getAbsolutePath()Ljava/lang/String;

    move-result-object v2

    .line 81
    new-instance v0, Ljava/io/File;

    invoke-direct {v0, v2}, Ljava/io/File;-><init>(Ljava/lang/String;)V

    .line 82
    invoke-virtual {v0, v9, v8}, Ljava/io/File;->setExecutable(ZZ)Z

    .line 84
    new-instance v0, Ljava/lang/StringBuilder;

    invoke-direct {v0}, Ljava/lang/StringBuilder;-><init>()V

    invoke-virtual {p0}, Lcom/cyjh/mobileanjian/ipc/IpcService;->getApplicationContext()Landroid/content/Context;

    move-result-object v1

    invoke-virtual {v1}, Landroid/content/Context;->getPackageName()Ljava/lang/String;

    move-result-object v1

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    const-string v1, ".event.localserver"

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-virtual {v0}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v0

    iput-object v0, p0, Lcom/cyjh/mobileanjian/ipc/IpcService;->a:Ljava/lang/String;

    .line 85
    invoke-direct {p0}, Lcom/cyjh/mobileanjian/ipc/IpcService;->g()I

    move-result v0

    iput v0, p0, Lcom/cyjh/mobileanjian/ipc/IpcService;->b:I

    .line 87
    invoke-virtual {p0}, Lcom/cyjh/mobileanjian/ipc/IpcService;->getApplicationInfo()Landroid/content/pm/ApplicationInfo;

    move-result-object v0

    iget-object v0, v0, Landroid/content/pm/ApplicationInfo;->sourceDir:Ljava/lang/String;

    .line 88
    invoke-direct {p0}, Lcom/cyjh/mobileanjian/ipc/IpcService;->h()Ljava/lang/String;

    move-result-object v1

    .line 89
    if-eqz v1, :cond_0

    .line 91
    new-instance v3, Ljava/lang/StringBuilder;

    invoke-direct {v3}, Ljava/lang/StringBuilder;-><init>()V

    invoke-virtual {v3, v0}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    const-string v3, ":"

    invoke-virtual {v0, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-virtual {v0}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v0

    .line 94
    :cond_0
    invoke-virtual {p0}, Lcom/cyjh/mobileanjian/ipc/IpcService;->getApplicationInfo()Landroid/content/pm/ApplicationInfo;

    move-result-object v1

    iget-object v1, v1, Landroid/content/pm/ApplicationInfo;->dataDir:Ljava/lang/String;

    new-array v3, v10, [Ljava/lang/String;

    const-string v4, "lib"

    aput-object v4, v3, v8

    const-string v4, "libmqm.so"

    aput-object v4, v3, v9

    invoke-static {v1, v3}, Lcom/cyjh/mobileanjian/ipc/utils/FileUtils;->makeAbsolutePath(Ljava/lang/String;[Ljava/lang/String;)Ljava/lang/String;

    move-result-object v3

    .line 96
    const-string v1, "app_process"

    .line 97
    new-instance v4, Ljava/io/File;

    const-string v5, "/system/bin/app_process32"

    invoke-direct {v4, v5}, Ljava/io/File;-><init>(Ljava/lang/String;)V

    invoke-virtual {v4}, Ljava/io/File;->exists()Z

    move-result v4

    if-eqz v4, :cond_1

    .line 99
    const-string v1, "/system/bin/app_process32"

    .line 102
    :cond_1
    new-instance v4, Ljava/io/File;

    invoke-virtual {p0}, Lcom/cyjh/mobileanjian/ipc/IpcService;->getApplicationInfo()Landroid/content/pm/ApplicationInfo;

    move-result-object v5

    iget-object v5, v5, Landroid/content/pm/ApplicationInfo;->dataDir:Ljava/lang/String;

    new-array v6, v10, [Ljava/lang/String;

    const-string v7, "mycache"

    aput-object v7, v6, v8

    const-string v7, "dalvik-cache"

    aput-object v7, v6, v9

    invoke-static {v5, v6}, Lcom/cyjh/mobileanjian/ipc/utils/FileUtils;->makeAbsolutePath(Ljava/lang/String;[Ljava/lang/String;)Ljava/lang/String;

    move-result-object v5

    invoke-direct {v4, v5}, Ljava/io/File;-><init>(Ljava/lang/String;)V

    .line 103
    invoke-virtual {v4}, Ljava/io/File;->mkdirs()Z

    .line 105
    invoke-virtual {v4, v9, v8}, Ljava/io/File;->setReadable(ZZ)Z

    .line 106
    invoke-virtual {v4, v9, v8}, Ljava/io/File;->setWritable(ZZ)Z

    .line 107
    invoke-virtual {v4, v9, v8}, Ljava/io/File;->setExecutable(ZZ)Z

    .line 109
    invoke-virtual {v4}, Ljava/io/File;->getParentFile()Ljava/io/File;

    move-result-object v5

    invoke-virtual {v5, v9, v8}, Ljava/io/File;->setReadable(ZZ)Z

    .line 110
    invoke-virtual {v4}, Ljava/io/File;->getParentFile()Ljava/io/File;

    move-result-object v5

    invoke-virtual {v5, v9, v8}, Ljava/io/File;->setWritable(ZZ)Z

    .line 111
    invoke-virtual {v4}, Ljava/io/File;->getParentFile()Ljava/io/File;

    move-result-object v5

    invoke-virtual {v5, v9, v8}, Ljava/io/File;->setExecutable(ZZ)Z

    .line 118
    new-instance v5, Ljava/lang/StringBuilder;

    invoke-direct {v5}, Ljava/lang/StringBuilder;-><init>()V

    const-string v6, "export CLASSPATH="

    invoke-virtual {v5, v6}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v5

    invoke-virtual {v5, v0}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    const-string v5, "\n"

    invoke-virtual {v0, v5}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    const-string v5, "exec %s %s %s %s %s %s &"

    const/4 v6, 0x6

    new-array v6, v6, [Ljava/lang/Object;

    aput-object v1, v6, v8

    aput-object v2, v6, v9

    sget-object v1, Lcom/cyjh/mobileanjian/ipc/h;->d:Ljava/lang/String;

    aput-object v1, v6, v10

    const/4 v1, 0x3

    iget-object v2, p0, Lcom/cyjh/mobileanjian/ipc/IpcService;->a:Ljava/lang/String;

    aput-object v2, v6, v1

    const/4 v1, 0x4

    aput-object v3, v6, v1

    const/4 v1, 0x5

    iget v2, p0, Lcom/cyjh/mobileanjian/ipc/IpcService;->b:I

    .line 119
    invoke-static {v2}, Ljava/lang/Integer;->valueOf(I)Ljava/lang/Integer;

    move-result-object v2

    aput-object v2, v6, v1

    invoke-static {v5, v6}, Ljava/lang/String;->format(Ljava/lang/String;[Ljava/lang/Object;)Ljava/lang/String;

    move-result-object v1

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-virtual {v0}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v0

    iput-object v0, p0, Lcom/cyjh/mobileanjian/ipc/IpcService;->c:Ljava/lang/String;

    .line 121
    new-instance v0, Ljava/lang/StringBuilder;

    invoke-direct {v0}, Ljava/lang/StringBuilder;-><init>()V

    const-string v1, "export ANDROID_DATA="

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-virtual {v4}, Ljava/io/File;->getParent()Ljava/lang/String;

    move-result-object v1

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    const-string v1, "\n"

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    iget-object v1, p0, Lcom/cyjh/mobileanjian/ipc/IpcService;->c:Ljava/lang/String;

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-virtual {v0}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v0

    iput-object v0, p0, Lcom/cyjh/mobileanjian/ipc/IpcService;->d:Ljava/lang/String;

    .line 122
    return-void
.end method

.method static synthetic b(Lcom/cyjh/mobileanjian/ipc/IpcService;)I
    .locals 1

    .prologue
    .line 28
    iget v0, p0, Lcom/cyjh/mobileanjian/ipc/IpcService;->b:I

    return v0
.end method

.method private b()V
    .locals 8

    .prologue
    const/4 v0, 0x0

    .line 143
    const-string v1, "model"

    invoke-virtual {p0, v1, v0}, Lcom/cyjh/mobileanjian/ipc/IpcService;->getDir(Ljava/lang/String;I)Ljava/io/File;

    move-result-object v1

    .line 144
    invoke-virtual {v1}, Ljava/io/File;->exists()Z

    move-result v2

    if-nez v2, :cond_0

    .line 146
    invoke-virtual {v1}, Ljava/io/File;->mkdirs()Z

    .line 150
    :cond_0
    :try_start_0
    invoke-virtual {p0}, Lcom/cyjh/mobileanjian/ipc/IpcService;->getResources()Landroid/content/res/Resources;

    move-result-object v2

    invoke-virtual {v2}, Landroid/content/res/Resources;->getAssets()Landroid/content/res/AssetManager;

    move-result-object v2

    const-string v3, "model"

    invoke-virtual {v2, v3}, Landroid/content/res/AssetManager;->list(Ljava/lang/String;)[Ljava/lang/String;

    move-result-object v2

    .line 151
    array-length v3, v2

    :goto_0
    if-ge v0, v3, :cond_2

    aget-object v4, v2, v0

    .line 153
    new-instance v5, Ljava/io/File;

    invoke-direct {v5, v1, v4}, Ljava/io/File;-><init>(Ljava/io/File;Ljava/lang/String;)V

    .line 154
    new-instance v6, Ljava/io/File;

    const-string v7, "model"

    invoke-direct {v6, v7, v4}, Ljava/io/File;-><init>(Ljava/lang/String;Ljava/lang/String;)V

    invoke-virtual {v6}, Ljava/io/File;->getPath()Ljava/lang/String;

    move-result-object v4

    .line 155
    invoke-virtual {v5}, Ljava/io/File;->getAbsolutePath()Ljava/lang/String;

    move-result-object v6

    .line 154
    invoke-static {p0, v4, v6}, Lcom/cyjh/mobileanjian/ipc/utils/FileUtils;->copyAssetsFile(Landroid/content/Context;Ljava/lang/String;Ljava/lang/String;)V

    .line 156
    invoke-virtual {v5}, Ljava/io/File;->exists()Z

    move-result v4

    if-eqz v4, :cond_1

    .line 158
    const/4 v4, 0x1

    const/4 v6, 0x0

    invoke-virtual {v5, v4, v6}, Ljava/io/File;->setReadable(ZZ)Z
    :try_end_0
    .catch Ljava/io/IOException; {:try_start_0 .. :try_end_0} :catch_0

    .line 151
    :cond_1
    add-int/lit8 v0, v0, 0x1

    goto :goto_0

    .line 161
    :catch_0
    move-exception v0

    .line 163
    invoke-virtual {v0}, Ljava/io/IOException;->printStackTrace()V

    .line 165
    :cond_2
    return-void
.end method

.method private c()V
    .locals 2

    .prologue
    .line 169
    new-instance v0, Ljava/lang/StringBuilder;

    invoke-direct {v0}, Ljava/lang/StringBuilder;-><init>()V

    invoke-virtual {p0}, Lcom/cyjh/mobileanjian/ipc/IpcService;->getFilesDir()Ljava/io/File;

    move-result-object v1

    invoke-virtual {v1}, Ljava/io/File;->getAbsolutePath()Ljava/lang/String;

    move-result-object v1

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    sget-object v1, Ljava/io/File;->separator:Ljava/lang/String;

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    const-string v1, "elfinject"

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-virtual {v0}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v0

    .line 170
    invoke-static {p0}, Lcom/cyjh/mobileanjian/ipc/utils/m;->c(Landroid/content/Context;)Z

    move-result v1

    if-eqz v1, :cond_0

    .line 172
    sget v1, Lcom/cyjh/rootipc/R$raw;->elfinject_x86:I

    invoke-static {p0, v1, v0}, Lcom/cyjh/mobileanjian/ipc/utils/FileUtils;->copyRawFile(Landroid/content/Context;ILjava/lang/String;)Z

    .line 178
    :goto_0
    return-void

    .line 176
    :cond_0
    sget v1, Lcom/cyjh/rootipc/R$raw;->elfinject_arm:I

    invoke-static {p0, v1, v0}, Lcom/cyjh/mobileanjian/ipc/utils/FileUtils;->copyRawFile(Landroid/content/Context;ILjava/lang/String;)Z

    goto :goto_0
.end method

.method static synthetic c(Lcom/cyjh/mobileanjian/ipc/IpcService;)V
    .locals 0

    .prologue
    .line 28
    invoke-direct {p0}, Lcom/cyjh/mobileanjian/ipc/IpcService;->b()V

    return-void
.end method

.method private d()V
    .locals 3

    .prologue
    .line 188
    invoke-static {}, Lcom/cyjh/mobileanjian/ipc/h;->c()Ljava/io/File;

    move-result-object v0

    .line 192
    :try_start_0
    iget-object v1, p0, Lcom/cyjh/mobileanjian/ipc/IpcService;->d:Ljava/lang/String;

    invoke-static {v0, v1}, Lorg/apache/commons/io/FileUtils;->writeStringToFile(Ljava/io/File;Ljava/lang/String;)V

    .line 193
    const/4 v1, 0x1

    const/4 v2, 0x0

    invoke-virtual {v0, v1, v2}, Ljava/io/File;->setReadable(ZZ)Z

    .line 194
    const/4 v1, 0x1

    const/4 v2, 0x0

    invoke-virtual {v0, v1, v2}, Ljava/io/File;->setExecutable(ZZ)Z

    .line 196
    invoke-static {}, Lcom/cyjh/mobileanjian/ipc/h;->d()Ljava/io/File;

    move-result-object v0

    iget-object v1, p0, Lcom/cyjh/mobileanjian/ipc/IpcService;->c:Ljava/lang/String;

    invoke-static {v0, v1}, Lorg/apache/commons/io/FileUtils;->write(Ljava/io/File;Ljava/lang/CharSequence;)V

    .line 197
    invoke-static {}, Lcom/cyjh/mobileanjian/ipc/h;->d()Ljava/io/File;

    move-result-object v0

    const/4 v1, 0x1

    const/4 v2, 0x0

    invoke-virtual {v0, v1, v2}, Ljava/io/File;->setExecutable(ZZ)Z
    :try_end_0
    .catch Ljava/io/IOException; {:try_start_0 .. :try_end_0} :catch_0

    .line 203
    :goto_0
    return-void

    .line 198
    :catch_0
    move-exception v0

    .line 200
    invoke-virtual {v0}, Ljava/io/IOException;->printStackTrace()V

    goto :goto_0
.end method

.method static synthetic d(Lcom/cyjh/mobileanjian/ipc/IpcService;)V
    .locals 0

    .prologue
    .line 28
    invoke-direct {p0}, Lcom/cyjh/mobileanjian/ipc/IpcService;->c()V

    return-void
.end method

.method private e()V
    .locals 2

    .prologue
    .line 210
    new-instance v0, Lcom/cyjh/mobileanjian/ipc/IpcService$1;

    const-string v1, "ipcserver_thread"

    invoke-direct {v0, p0, v1}, Lcom/cyjh/mobileanjian/ipc/IpcService$1;-><init>(Lcom/cyjh/mobileanjian/ipc/IpcService;Ljava/lang/String;)V

    .line 221
    invoke-virtual {v0}, Lcom/cyjh/mobileanjian/ipc/IpcService$1;->start()V

    .line 222
    return-void
.end method

.method static synthetic e(Lcom/cyjh/mobileanjian/ipc/IpcService;)V
    .locals 0

    .prologue
    .line 28
    invoke-direct {p0}, Lcom/cyjh/mobileanjian/ipc/IpcService;->d()V

    return-void
.end method

.method private f()V
    .locals 2

    .prologue
    .line 229
    new-instance v0, Lcom/cyjh/mobileanjian/ipc/IpcService$2;

    const-string v1, "startRootRequest"

    invoke-direct {v0, p0, v1}, Lcom/cyjh/mobileanjian/ipc/IpcService$2;-><init>(Lcom/cyjh/mobileanjian/ipc/IpcService;Ljava/lang/String;)V

    .line 240
    invoke-virtual {v0}, Lcom/cyjh/mobileanjian/ipc/IpcService$2;->start()V

    .line 241
    return-void
.end method

.method private g()I
    .locals 3

    .prologue
    .line 246
    const-string v0, "mqm_engine"

    const/4 v1, 0x0

    invoke-virtual {p0, v0, v1}, Lcom/cyjh/mobileanjian/ipc/IpcService;->getSharedPreferences(Ljava/lang/String;I)Landroid/content/SharedPreferences;

    move-result-object v2

    .line 247
    const-string v0, "ipc_server_port"

    const/4 v1, -0x1

    invoke-interface {v2, v0, v1}, Landroid/content/SharedPreferences;->getInt(Ljava/lang/String;I)I

    move-result v0

    .line 248
    const/16 v1, 0x1770

    if-le v0, v1, :cond_0

    :goto_0
    move v1, v0

    .line 254
    :goto_1
    :try_start_0
    new-instance v0, Ljava/net/ServerSocket;

    invoke-direct {v0, v1}, Ljava/net/ServerSocket;-><init>(I)V

    .line 255
    invoke-virtual {v0}, Ljava/net/ServerSocket;->close()V
    :try_end_0
    .catch Ljava/net/UnknownHostException; {:try_start_0 .. :try_end_0} :catch_0
    .catch Ljava/io/IOException; {:try_start_0 .. :try_end_0} :catch_1

    .line 272
    invoke-interface {v2}, Landroid/content/SharedPreferences;->edit()Landroid/content/SharedPreferences$Editor;

    move-result-object v0

    .line 273
    const-string v2, "ipc_server_port"

    invoke-interface {v0, v2, v1}, Landroid/content/SharedPreferences$Editor;->putInt(Ljava/lang/String;I)Landroid/content/SharedPreferences$Editor;

    .line 274
    invoke-interface {v0}, Landroid/content/SharedPreferences$Editor;->commit()Z

    .line 276
    return v1

    .line 248
    :cond_0
    new-instance v0, Ljava/util/Random;

    invoke-direct {v0}, Ljava/util/Random;-><init>()V

    const/16 v1, 0xfa0

    invoke-virtual {v0, v1}, Ljava/util/Random;->nextInt(I)I

    move-result v0

    add-int/lit16 v0, v0, 0x1770

    goto :goto_0

    .line 258
    :catch_0
    move-exception v0

    .line 260
    add-int/lit8 v1, v1, 0x1

    .line 261
    invoke-virtual {v0}, Ljava/net/UnknownHostException;->printStackTrace()V

    goto :goto_1

    .line 264
    :catch_1
    move-exception v0

    .line 266
    add-int/lit8 v1, v1, 0x1

    .line 267
    invoke-virtual {v0}, Ljava/io/IOException;->printStackTrace()V

    goto :goto_1
.end method

.method private h()Ljava/lang/String;
    .locals 11

    .prologue
    const/4 v0, 0x0

    const/4 v10, 0x1

    const/4 v2, 0x0

    .line 281
    .line 284
    :try_start_0
    invoke-virtual {p0}, Lcom/cyjh/mobileanjian/ipc/IpcService;->getApplicationInfo()Landroid/content/pm/ApplicationInfo;
    :try_end_0
    .catch Ljava/lang/RuntimeException; {:try_start_0 .. :try_end_0} :catch_0

    move-result-object v1

    .line 285
    if-nez v1, :cond_1

    .line 328
    :cond_0
    :goto_0
    return-object v0

    .line 295
    :cond_1
    new-instance v3, Ljava/lang/StringBuilder;

    invoke-direct {v3}, Ljava/lang/StringBuilder;-><init>()V

    const-string v4, "code_cache"

    invoke-virtual {v3, v4}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v3

    sget-object v4, Ljava/io/File;->separator:Ljava/lang/String;

    invoke-virtual {v3, v4}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v3

    const-string v4, "secondary-dexes"

    invoke-virtual {v3, v4}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v3

    invoke-virtual {v3}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v3

    .line 296
    new-instance v4, Ljava/io/File;

    iget-object v1, v1, Landroid/content/pm/ApplicationInfo;->dataDir:Ljava/lang/String;

    invoke-direct {v4, v1, v3}, Ljava/io/File;-><init>(Ljava/lang/String;Ljava/lang/String;)V

    .line 297
    invoke-virtual {v4}, Ljava/io/File;->exists()Z

    move-result v1

    if-eqz v1, :cond_3

    invoke-virtual {v4}, Ljava/io/File;->isDirectory()Z

    move-result v1

    if-eqz v1, :cond_3

    .line 299
    invoke-virtual {v4}, Ljava/io/File;->listFiles()[Ljava/io/File;

    move-result-object v5

    .line 300
    array-length v6, v5

    move v1, v2

    :goto_1
    if-ge v1, v6, :cond_3

    aget-object v7, v5, v1

    .line 302
    invoke-virtual {v7}, Ljava/io/File;->getName()Ljava/lang/String;

    move-result-object v8

    const-string v9, ".zip"

    invoke-virtual {v8, v9}, Ljava/lang/String;->endsWith(Ljava/lang/String;)Z

    move-result v8

    if-eqz v8, :cond_2

    .line 304
    invoke-virtual {v4, v10, v2}, Ljava/io/File;->setExecutable(ZZ)Z

    .line 305
    invoke-virtual {v4}, Ljava/io/File;->getParentFile()Ljava/io/File;

    move-result-object v0

    invoke-virtual {v0, v10, v2}, Ljava/io/File;->setExecutable(ZZ)Z

    .line 306
    invoke-virtual {v7, v10, v2}, Ljava/io/File;->setReadable(ZZ)Z

    .line 307
    invoke-virtual {v7}, Ljava/io/File;->getAbsolutePath()Ljava/lang/String;

    move-result-object v0

    goto :goto_0

    .line 300
    :cond_2
    add-int/lit8 v1, v1, 0x1

    goto :goto_1

    .line 312
    :cond_3
    new-instance v4, Ljava/io/File;

    invoke-virtual {p0}, Lcom/cyjh/mobileanjian/ipc/IpcService;->getFilesDir()Ljava/io/File;

    move-result-object v1

    invoke-direct {v4, v1, v3}, Ljava/io/File;-><init>(Ljava/io/File;Ljava/lang/String;)V

    .line 313
    invoke-virtual {v4}, Ljava/io/File;->exists()Z

    move-result v1

    if-eqz v1, :cond_0

    invoke-virtual {v4}, Ljava/io/File;->isDirectory()Z

    move-result v1

    if-eqz v1, :cond_0

    .line 315
    invoke-virtual {v4}, Ljava/io/File;->listFiles()[Ljava/io/File;

    move-result-object v3

    .line 316
    array-length v5, v3

    move v1, v2

    :goto_2
    if-ge v1, v5, :cond_0

    aget-object v6, v3, v1

    .line 318
    invoke-virtual {v6}, Ljava/io/File;->getName()Ljava/lang/String;

    move-result-object v7

    const-string v8, ".zip"

    invoke-virtual {v7, v8}, Ljava/lang/String;->endsWith(Ljava/lang/String;)Z

    move-result v7

    if-eqz v7, :cond_4

    .line 320
    invoke-virtual {v4, v10, v2}, Ljava/io/File;->setExecutable(ZZ)Z

    .line 321
    invoke-virtual {v4}, Ljava/io/File;->getParentFile()Ljava/io/File;

    move-result-object v0

    invoke-virtual {v0, v10, v2}, Ljava/io/File;->setExecutable(ZZ)Z

    .line 322
    invoke-virtual {v6, v10, v2}, Ljava/io/File;->setReadable(ZZ)Z

    .line 323
    invoke-virtual {v6}, Ljava/io/File;->getAbsolutePath()Ljava/lang/String;

    move-result-object v0

    goto/16 :goto_0

    .line 316
    :cond_4
    add-int/lit8 v1, v1, 0x1

    goto :goto_2

    .line 291
    :catch_0
    move-exception v1

    goto/16 :goto_0
.end method


# virtual methods
.method public onBind(Landroid/content/Intent;)Landroid/os/IBinder;
    .locals 1
    .annotation build Landroid/support/annotation/Nullable;
    .end annotation

    .prologue
    .line 68
    const/4 v0, 0x0

    return-object v0
.end method

.method public onConfigurationChanged(Landroid/content/res/Configuration;)V
    .locals 1

    .prologue
    .line 136
    invoke-super {p0, p1}, Landroid/app/Service;->onConfigurationChanged(Landroid/content/res/Configuration;)V

    .line 137
    invoke-static {}, Lcom/cyjh/mobileanjian/ipc/MqRunner;->getInstance()Lcom/cyjh/mobileanjian/ipc/MqRunner;

    move-result-object v0

    invoke-virtual {v0}, Lcom/cyjh/mobileanjian/ipc/MqRunner;->notifyRotationStatus()V

    .line 138
    return-void
.end method

.method public onCreate()V
    .locals 2

    .prologue
    .line 54
    invoke-super {p0}, Landroid/app/Service;->onCreate()V

    .line 55
    invoke-static {p0}, Lcom/cyjh/mobileanjian/ipc/rpc/AndroidHelper;->init(Landroid/content/Context;)V

    .line 56
    invoke-direct {p0}, Lcom/cyjh/mobileanjian/ipc/IpcService;->a()V

    .line 58
    invoke-direct {p0}, Lcom/cyjh/mobileanjian/ipc/IpcService;->e()V

    .line 59
    invoke-direct {p0}, Lcom/cyjh/mobileanjian/ipc/IpcService;->f()V

    .line 61
    const-string v0, "VERSION"

    const-string v1, "build info: branch_3.2.7 on 2017-11-02 14:41:17"

    invoke-static {v0, v1}, Landroid/util/Log;->i(Ljava/lang/String;Ljava/lang/String;)I

    .line 62
    return-void
.end method

.method public onDestroy()V
    .locals 1

    .prologue
    .line 128
    invoke-super {p0}, Landroid/app/Service;->onDestroy()V

    .line 129
    const-string v0, "LcoalServerService ==> onDestroy()"

    invoke-static {v0}, Lcom/cyjh/mobileanjian/ipc/utils/CLog;->d(Ljava/lang/String;)V

    .line 130
    invoke-static {}, Lcom/cyjh/mobileanjian/ipc/j;->b()Lcom/cyjh/mobileanjian/ipc/j;

    move-result-object v0

    invoke-virtual {v0}, Lcom/cyjh/mobileanjian/ipc/j;->c()V

    .line 131
    return-void
.end method
