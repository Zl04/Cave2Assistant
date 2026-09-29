.class public Lcom/cyjh/mobileanjian/ipc/ClientService;
.super Ljava/lang/Object;
.source "SourceFile"


# static fields
.field private static final a:Ljava/lang/Class;

.field private static b:Lcom/cyjh/mobileanjian/ipc/b/b;

.field private static c:Ljava/lang/String;

.field private static d:I

.field private static final e:[Ljava/lang/String;


# direct methods
.method static constructor <clinit>()V
    .locals 3

    .prologue
    const/4 v1, 0x0

    .line 31
    const-class v0, Lcom/cyjh/mobileanjian/ipc/ClientService;

    sput-object v0, Lcom/cyjh/mobileanjian/ipc/ClientService;->a:Ljava/lang/Class;

    .line 33
    sput-object v1, Lcom/cyjh/mobileanjian/ipc/ClientService;->b:Lcom/cyjh/mobileanjian/ipc/b/b;

    .line 34
    sput-object v1, Lcom/cyjh/mobileanjian/ipc/ClientService;->c:Ljava/lang/String;

    .line 134
    const/4 v0, 0x1

    new-array v0, v0, [Ljava/lang/String;

    const/4 v1, 0x0

    const-string v2, "elfinject"

    aput-object v2, v0, v1

    sput-object v0, Lcom/cyjh/mobileanjian/ipc/ClientService;->e:[Ljava/lang/String;

    return-void
.end method

.method public constructor <init>()V
    .locals 0

    .prologue
    .line 29
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method

.method public static a()Lcom/cyjh/mobileanjian/ipc/b/b;
    .locals 1

    .prologue
    .line 304
    sget-object v0, Lcom/cyjh/mobileanjian/ipc/ClientService;->b:Lcom/cyjh/mobileanjian/ipc/b/b;

    return-object v0
.end method

.method private static b()V
    .locals 4

    .prologue
    const/4 v0, 0x0

    .line 121
    sget-object v1, Lcom/cyjh/mobileanjian/ipc/ClientService;->c:Ljava/lang/String;

    const-string v2, ".event.localserver"

    invoke-virtual {v1, v2}, Ljava/lang/String;->lastIndexOf(Ljava/lang/String;)I

    move-result v1

    .line 122
    if-lez v1, :cond_0

    .line 124
    sget-object v2, Lcom/cyjh/mobileanjian/ipc/ClientService;->c:Ljava/lang/String;

    invoke-virtual {v2, v0, v1}, Ljava/lang/String;->substring(II)Ljava/lang/String;

    move-result-object v1

    .line 125
    invoke-static {v1}, Lcom/cyjh/mobileanjian/ipc/a/a;->g(Ljava/lang/String;)V

    .line 127
    new-instance v2, Ljava/lang/StringBuilder;

    invoke-direct {v2}, Ljava/lang/StringBuilder;-><init>()V

    const-string v3, "pkgName="

    invoke-virtual {v2, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    invoke-virtual {v2, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v1

    sget-object v2, Lcom/cyjh/mobileanjian/ipc/ClientService;->a:Ljava/lang/Class;

    invoke-static {v1, v2}, Lcom/cyjh/mobileanjian/ipc/engine/utils/CLog;->i(Ljava/lang/String;Ljava/lang/Class;)V

    .line 130
    :cond_0
    invoke-static {}, Landroid/os/Process;->myUid()I

    move-result v1

    if-nez v1, :cond_1

    const/4 v0, 0x1

    :cond_1
    invoke-static {v0}, Lcom/cyjh/mobileanjian/ipc/a/a;->a(Z)V

    .line 131
    return-void
.end method

.method private static c()V
    .locals 7

    .prologue
    const/4 v0, 0x0

    .line 137
    sget-object v2, Lcom/cyjh/mobileanjian/ipc/ClientService;->e:[Ljava/lang/String;

    array-length v3, v2

    move v1, v0

    :goto_0
    if-ge v1, v3, :cond_0

    aget-object v0, v2, v1

    .line 139
    new-instance v4, Ljava/lang/StringBuilder;

    invoke-direct {v4}, Ljava/lang/StringBuilder;-><init>()V

    invoke-static {}, Lcom/cyjh/mobileanjian/ipc/a/a;->v()Ljava/lang/String;

    move-result-object v5

    invoke-virtual {v4, v5}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v4

    sget-object v5, Ljava/io/File;->separator:Ljava/lang/String;

    invoke-virtual {v4, v5}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v4

    invoke-virtual {v4, v0}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v4

    invoke-virtual {v4}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v4

    .line 140
    new-instance v5, Ljava/lang/StringBuilder;

    invoke-direct {v5}, Ljava/lang/StringBuilder;-><init>()V

    invoke-static {}, Lcom/cyjh/mobileanjian/ipc/a/a;->w()Ljava/lang/String;

    move-result-object v6

    invoke-virtual {v5, v6}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v5

    sget-object v6, Ljava/io/File;->separator:Ljava/lang/String;

    invoke-virtual {v5, v6}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v5

    invoke-virtual {v5, v0}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-virtual {v0}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v0

    .line 141
    new-instance v5, Ljava/io/File;

    invoke-direct {v5, v4}, Ljava/io/File;-><init>(Ljava/lang/String;)V

    .line 142
    new-instance v4, Ljava/io/File;

    invoke-direct {v4, v0}, Ljava/io/File;-><init>(Ljava/lang/String;)V

    .line 145
    :try_start_0
    invoke-static {v5, v4}, Lorg/apache/commons/io/FileUtils;->copyFile(Ljava/io/File;Ljava/io/File;)V

    .line 146
    const/4 v0, 0x1

    const/4 v5, 0x0

    invoke-virtual {v4, v0, v5}, Ljava/io/File;->setReadable(ZZ)Z

    .line 147
    const/4 v0, 0x1

    const/4 v5, 0x0

    invoke-virtual {v4, v0, v5}, Ljava/io/File;->setExecutable(ZZ)Z
    :try_end_0
    .catch Ljava/io/IOException; {:try_start_0 .. :try_end_0} :catch_0

    .line 137
    :goto_1
    add-int/lit8 v0, v1, 0x1

    move v1, v0

    goto :goto_0

    .line 148
    :catch_0
    move-exception v0

    .line 150
    invoke-virtual {v0}, Ljava/io/IOException;->printStackTrace()V

    goto :goto_1

    .line 153
    :cond_0
    return-void
.end method

.method private static d()I
    .locals 4

    .prologue
    .line 157
    const/4 v0, -0x1

    .line 158
    new-instance v1, Ljava/lang/StringBuilder;

    invoke-direct {v1}, Ljava/lang/StringBuilder;-><init>()V

    new-instance v2, Ljava/io/File;

    sget-object v3, Lcom/cyjh/mobileanjian/ipc/engine/utils/g;->c:Ljava/lang/String;

    invoke-direct {v2, v3}, Ljava/io/File;-><init>(Ljava/lang/String;)V

    invoke-virtual {v2}, Ljava/io/File;->getParentFile()Ljava/io/File;

    move-result-object v2

    invoke-virtual {v2}, Ljava/io/File;->getParent()Ljava/lang/String;

    move-result-object v2

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    sget-object v2, Ljava/io/File;->separator:Ljava/lang/String;

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    const-string v2, "files"

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v1

    .line 159
    new-instance v2, Ljava/io/File;

    new-instance v3, Ljava/lang/StringBuilder;

    invoke-direct {v3}, Ljava/lang/StringBuilder;-><init>()V

    invoke-virtual {v3, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    sget-object v3, Ljava/io/File;->separator:Ljava/lang/String;

    invoke-virtual {v1, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    const-string v3, "v"

    invoke-virtual {v1, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v1

    invoke-direct {v2, v1}, Ljava/io/File;-><init>(Ljava/lang/String;)V

    .line 160
    invoke-virtual {v2}, Ljava/io/File;->exists()Z

    move-result v1

    if-eqz v1, :cond_0

    .line 164
    :try_start_0
    new-instance v1, Ljava/io/DataInputStream;

    new-instance v3, Ljava/io/FileInputStream;

    invoke-direct {v3, v2}, Ljava/io/FileInputStream;-><init>(Ljava/io/File;)V

    invoke-direct {v1, v3}, Ljava/io/DataInputStream;-><init>(Ljava/io/InputStream;)V

    .line 165
    invoke-virtual {v1}, Ljava/io/DataInputStream;->readInt()I

    move-result v0

    .line 166
    invoke-virtual {v1}, Ljava/io/DataInputStream;->close()V
    :try_end_0
    .catch Ljava/io/FileNotFoundException; {:try_start_0 .. :try_end_0} :catch_0
    .catch Ljava/io/IOException; {:try_start_0 .. :try_end_0} :catch_1

    .line 177
    :cond_0
    :goto_0
    new-instance v1, Ljava/lang/StringBuilder;

    invoke-direct {v1}, Ljava/lang/StringBuilder;-><init>()V

    const-string v2, "get .so overwritten version is: "

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1, v0}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v1

    sget-object v2, Lcom/cyjh/mobileanjian/ipc/ClientService;->a:Ljava/lang/Class;

    invoke-static {v1, v2}, Lcom/cyjh/mobileanjian/ipc/engine/utils/CLog;->i(Ljava/lang/String;Ljava/lang/Class;)V

    .line 178
    return v0

    .line 168
    :catch_0
    move-exception v1

    .line 170
    invoke-virtual {v1}, Ljava/io/FileNotFoundException;->printStackTrace()V

    goto :goto_0

    .line 172
    :catch_1
    move-exception v1

    .line 174
    invoke-virtual {v1}, Ljava/io/IOException;->printStackTrace()V

    goto :goto_0
.end method

.method private static e()V
    .locals 3

    .prologue
    .line 183
    new-instance v0, Ljava/lang/StringBuilder;

    invoke-direct {v0}, Ljava/lang/StringBuilder;-><init>()V

    new-instance v1, Ljava/io/File;

    sget-object v2, Lcom/cyjh/mobileanjian/ipc/engine/utils/g;->c:Ljava/lang/String;

    invoke-direct {v1, v2}, Ljava/io/File;-><init>(Ljava/lang/String;)V

    invoke-virtual {v1}, Ljava/io/File;->getParentFile()Ljava/io/File;

    move-result-object v1

    invoke-virtual {v1}, Ljava/io/File;->getParent()Ljava/lang/String;

    move-result-object v1

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    sget-object v1, Ljava/io/File;->separator:Ljava/lang/String;

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    const-string v1, "files"

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-virtual {v0}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v0

    .line 184
    new-instance v1, Ljava/io/File;

    new-instance v2, Ljava/lang/StringBuilder;

    invoke-direct {v2}, Ljava/lang/StringBuilder;-><init>()V

    invoke-virtual {v2, v0}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    sget-object v2, Ljava/io/File;->separator:Ljava/lang/String;

    invoke-virtual {v0, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    const-string v2, "v"

    invoke-virtual {v0, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-virtual {v0}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v0

    invoke-direct {v1, v0}, Ljava/io/File;-><init>(Ljava/lang/String;)V

    .line 187
    :try_start_0
    invoke-virtual {v1}, Ljava/io/File;->exists()Z

    move-result v0

    if-nez v0, :cond_0

    .line 189
    invoke-virtual {v1}, Ljava/io/File;->createNewFile()Z

    .line 191
    :cond_0
    new-instance v0, Ljava/io/DataOutputStream;

    new-instance v2, Ljava/io/FileOutputStream;

    invoke-direct {v2, v1}, Ljava/io/FileOutputStream;-><init>(Ljava/io/File;)V

    invoke-direct {v0, v2}, Ljava/io/DataOutputStream;-><init>(Ljava/io/OutputStream;)V

    .line 192
    const/16 v1, 0xa

    invoke-virtual {v0, v1}, Ljava/io/DataOutputStream;->writeInt(I)V

    .line 193
    invoke-virtual {v0}, Ljava/io/DataOutputStream;->close()V
    :try_end_0
    .catch Ljava/io/FileNotFoundException; {:try_start_0 .. :try_end_0} :catch_0
    .catch Ljava/io/IOException; {:try_start_0 .. :try_end_0} :catch_1

    .line 203
    :goto_0
    return-void

    .line 195
    :catch_0
    move-exception v0

    .line 197
    invoke-virtual {v0}, Ljava/io/FileNotFoundException;->printStackTrace()V

    goto :goto_0

    .line 199
    :catch_1
    move-exception v0

    .line 201
    invoke-virtual {v0}, Ljava/io/IOException;->printStackTrace()V

    goto :goto_0
.end method

.method private f()V
    .locals 7

    .prologue
    const/4 v3, 0x0

    .line 207
    new-instance v0, Ljava/lang/StringBuilder;

    invoke-direct {v0}, Ljava/lang/StringBuilder;-><init>()V

    const-string v1, "client service start with pid: "

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-static {}, Landroid/os/Process;->myPid()I

    move-result v1

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-virtual {v0}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v0

    sget-object v1, Lcom/cyjh/mobileanjian/ipc/ClientService;->a:Ljava/lang/Class;

    invoke-static {v0, v1}, Lcom/cyjh/mobileanjian/ipc/engine/utils/CLog;->i(Ljava/lang/String;Ljava/lang/Class;)V

    .line 208
    invoke-direct {p0}, Lcom/cyjh/mobileanjian/ipc/ClientService;->g()V

    move v2, v3

    move v1, v3

    .line 218
    :goto_0
    :try_start_0
    rem-int/lit8 v0, v2, 0x2

    if-nez v0, :cond_1

    .line 220
    new-instance v0, Landroid/net/LocalSocketAddress;

    sget-object v4, Lcom/cyjh/mobileanjian/ipc/ClientService;->c:Ljava/lang/String;

    invoke-direct {v0, v4}, Landroid/net/LocalSocketAddress;-><init>(Ljava/lang/String;)V

    .line 221
    new-instance v4, Landroid/net/LocalSocket;

    invoke-direct {v4}, Landroid/net/LocalSocket;-><init>()V

    .line 222
    const-string v5, "connecting... with local socket"

    sget-object v6, Lcom/cyjh/mobileanjian/ipc/ClientService;->a:Ljava/lang/Class;

    invoke-static {v5, v6}, Lcom/cyjh/mobileanjian/ipc/engine/utils/CLog;->i(Ljava/lang/String;Ljava/lang/Class;)V

    .line 223
    invoke-virtual {v4, v0}, Landroid/net/LocalSocket;->connect(Landroid/net/LocalSocketAddress;)V

    .line 224
    const-string v0, "connected successfully."

    sget-object v5, Lcom/cyjh/mobileanjian/ipc/ClientService;->a:Ljava/lang/Class;

    invoke-static {v0, v5}, Lcom/cyjh/mobileanjian/ipc/engine/utils/CLog;->i(Ljava/lang/String;Ljava/lang/Class;)V

    .line 225
    new-instance v0, Lcom/cyjh/mobileanjian/ipc/b/b;

    invoke-direct {v0, v4}, Lcom/cyjh/mobileanjian/ipc/b/b;-><init>(Landroid/net/LocalSocket;)V

    sput-object v0, Lcom/cyjh/mobileanjian/ipc/ClientService;->b:Lcom/cyjh/mobileanjian/ipc/b/b;

    .line 234
    :goto_1
    sget-object v0, Lcom/cyjh/mobileanjian/ipc/ClientService;->b:Lcom/cyjh/mobileanjian/ipc/b/b;

    invoke-virtual {v0}, Lcom/cyjh/mobileanjian/ipc/b/b;->b()V
    :try_end_0
    .catch Ljava/net/UnknownHostException; {:try_start_0 .. :try_end_0} :catch_0
    .catch Ljava/io/IOException; {:try_start_0 .. :try_end_0} :catch_3
    .catchall {:try_start_0 .. :try_end_0} :catchall_0

    .line 235
    const/4 v1, 0x1

    .line 252
    add-int/lit8 v0, v2, 0x1

    .line 253
    const-wide/16 v4, 0x64

    :try_start_1
    invoke-static {v4, v5}, Ljava/lang/Thread;->sleep(J)V
    :try_end_1
    .catch Ljava/lang/InterruptedException; {:try_start_1 .. :try_end_1} :catch_2

    .line 260
    :goto_2
    invoke-static {}, Lcom/cyjh/mobileanjian/ipc/a/a;->s()Z

    move-result v2

    if-eqz v2, :cond_2

    .line 262
    if-nez v1, :cond_0

    const/16 v2, 0x1e

    if-le v0, v2, :cond_2

    .line 266
    :cond_0
    invoke-static {v3}, Ljava/lang/System;->exit(I)V

    .line 267
    return-void

    .line 229
    :cond_1
    :try_start_2
    const-string v0, "connecting... with socket"

    sget-object v4, Lcom/cyjh/mobileanjian/ipc/ClientService;->a:Ljava/lang/Class;

    invoke-static {v0, v4}, Lcom/cyjh/mobileanjian/ipc/engine/utils/CLog;->i(Ljava/lang/String;Ljava/lang/Class;)V

    .line 230
    new-instance v0, Ljava/net/Socket;

    const-string v4, "127.0.0.1"

    sget v5, Lcom/cyjh/mobileanjian/ipc/ClientService;->d:I

    invoke-direct {v0, v4, v5}, Ljava/net/Socket;-><init>(Ljava/lang/String;I)V

    .line 231
    const-string v4, "Successfully connected to ipc server."

    sget-object v5, Lcom/cyjh/mobileanjian/ipc/ClientService;->a:Ljava/lang/Class;

    invoke-static {v4, v5}, Lcom/cyjh/mobileanjian/ipc/engine/utils/CLog;->i(Ljava/lang/String;Ljava/lang/Class;)V

    .line 232
    new-instance v4, Lcom/cyjh/mobileanjian/ipc/b/b;

    invoke-direct {v4, v0}, Lcom/cyjh/mobileanjian/ipc/b/b;-><init>(Ljava/net/Socket;)V

    sput-object v4, Lcom/cyjh/mobileanjian/ipc/ClientService;->b:Lcom/cyjh/mobileanjian/ipc/b/b;
    :try_end_2
    .catch Ljava/net/UnknownHostException; {:try_start_2 .. :try_end_2} :catch_0
    .catch Ljava/io/IOException; {:try_start_2 .. :try_end_2} :catch_3
    .catchall {:try_start_2 .. :try_end_2} :catchall_0

    goto :goto_1

    .line 237
    :catch_0
    move-exception v0

    .line 239
    :try_start_3
    const-string v4, "connect failed!!, after 1 seconds will try again"

    sget-object v5, Lcom/cyjh/mobileanjian/ipc/ClientService;->a:Ljava/lang/Class;

    invoke-static {v4, v5}, Lcom/cyjh/mobileanjian/ipc/engine/utils/CLog;->i(Ljava/lang/String;Ljava/lang/Class;)V

    .line 240
    invoke-virtual {v0}, Ljava/net/UnknownHostException;->printStackTrace()V
    :try_end_3
    .catchall {:try_start_3 .. :try_end_3} :catchall_0

    .line 252
    add-int/lit8 v0, v2, 0x1

    .line 253
    const-wide/16 v4, 0x64

    :try_start_4
    invoke-static {v4, v5}, Ljava/lang/Thread;->sleep(J)V
    :try_end_4
    .catch Ljava/lang/InterruptedException; {:try_start_4 .. :try_end_4} :catch_1

    goto :goto_2

    .line 255
    :catch_1
    move-exception v2

    .line 257
    invoke-virtual {v2}, Ljava/lang/InterruptedException;->printStackTrace()V

    goto :goto_2

    .line 255
    :catch_2
    move-exception v2

    .line 257
    invoke-virtual {v2}, Ljava/lang/InterruptedException;->printStackTrace()V

    goto :goto_2

    .line 242
    :catch_3
    move-exception v0

    .line 244
    :try_start_5
    const-string v4, "connect failed!!, after 1 seconds will try again"

    sget-object v5, Lcom/cyjh/mobileanjian/ipc/ClientService;->a:Ljava/lang/Class;

    invoke-static {v4, v5}, Lcom/cyjh/mobileanjian/ipc/engine/utils/CLog;->i(Ljava/lang/String;Ljava/lang/Class;)V

    .line 245
    invoke-virtual {v0}, Ljava/io/IOException;->printStackTrace()V
    :try_end_5
    .catchall {:try_start_5 .. :try_end_5} :catchall_0

    .line 252
    add-int/lit8 v0, v2, 0x1

    .line 253
    const-wide/16 v4, 0x64

    :try_start_6
    invoke-static {v4, v5}, Ljava/lang/Thread;->sleep(J)V
    :try_end_6
    .catch Ljava/lang/InterruptedException; {:try_start_6 .. :try_end_6} :catch_4

    goto :goto_2

    .line 255
    :catch_4
    move-exception v2

    .line 257
    invoke-virtual {v2}, Ljava/lang/InterruptedException;->printStackTrace()V

    goto :goto_2

    .line 250
    :catchall_0
    move-exception v0

    .line 252
    add-int/lit8 v1, v2, 0x1

    .line 253
    const-wide/16 v2, 0x64

    :try_start_7
    invoke-static {v2, v3}, Ljava/lang/Thread;->sleep(J)V
    :try_end_7
    .catch Ljava/lang/InterruptedException; {:try_start_7 .. :try_end_7} :catch_5

    .line 258
    :goto_3
    throw v0

    .line 255
    :catch_5
    move-exception v1

    .line 257
    invoke-virtual {v1}, Ljava/lang/InterruptedException;->printStackTrace()V

    goto :goto_3

    :cond_2
    move v2, v0

    goto/16 :goto_0
.end method

.method private g()V
    .locals 4

    .prologue
    .line 273
    :try_start_0
    new-instance v0, Ljava/io/File;

    const-string v1, "/data/local/tmp"

    new-instance v2, Ljava/lang/StringBuilder;

    invoke-direct {v2}, Ljava/lang/StringBuilder;-><init>()V

    invoke-static {}, Lcom/cyjh/mobileanjian/ipc/a/a;->u()Ljava/lang/String;

    move-result-object v3

    invoke-virtual {v2, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    const-string v3, ".id"

    invoke-virtual {v2, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    invoke-virtual {v2}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v2

    invoke-direct {v0, v1, v2}, Ljava/io/File;-><init>(Ljava/lang/String;Ljava/lang/String;)V

    .line 274
    invoke-static {}, Landroid/os/Process;->myPid()I

    move-result v1

    invoke-static {v1}, Ljava/lang/String;->valueOf(I)Ljava/lang/String;

    move-result-object v1

    invoke-static {v0, v1}, Lorg/apache/commons/io/FileUtils;->write(Ljava/io/File;Ljava/lang/CharSequence;)V

    .line 275
    const/4 v1, 0x1

    const/4 v2, 0x0

    invoke-virtual {v0, v1, v2}, Ljava/io/File;->setReadable(ZZ)Z

    .line 276
    const/4 v1, 0x1

    const/4 v2, 0x0

    invoke-virtual {v0, v1, v2}, Ljava/io/File;->setWritable(ZZ)Z
    :try_end_0
    .catch Ljava/io/IOException; {:try_start_0 .. :try_end_0} :catch_0

    .line 281
    :goto_0
    return-void

    .line 277
    :catch_0
    move-exception v0

    .line 279
    invoke-virtual {v0}, Ljava/io/IOException;->printStackTrace()V

    goto :goto_0
.end method

.method private h()V
    .locals 0

    .prologue
    .line 289
    invoke-direct {p0}, Lcom/cyjh/mobileanjian/ipc/ClientService;->i()V

    .line 290
    return-void
.end method

.method private i()V
    .locals 3

    .prologue
    .line 294
    invoke-static {}, Lcom/cyjh/mobileanjian/ipc/a/a;->e()Ljava/lang/String;

    move-result-object v0

    .line 295
    if-eqz v0, :cond_0

    .line 297
    new-instance v1, Ljava/lang/StringBuilder;

    invoke-direct {v1}, Ljava/lang/StringBuilder;-><init>()V

    const-string v2, "ime set "

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1, v0}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-virtual {v0}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v0

    .line 298
    const/4 v1, 0x1

    const/4 v2, 0x0

    invoke-static {v0, v1, v2}, Lcom/cyjh/mobileanjian/ipc/engine/utils/f;->a(Ljava/lang/String;ZI)Lcom/cyjh/mobileanjian/ipc/engine/utils/f$a;

    .line 300
    :cond_0
    return-void
.end method

.method public static main([Ljava/lang/String;)V
    .locals 7

    .prologue
    const/4 v6, 0x2

    const/4 v0, 0x1

    const/4 v2, 0x0

    .line 40
    const-string v1, "start client service"

    sget-object v3, Lcom/cyjh/mobileanjian/ipc/ClientService;->a:Ljava/lang/Class;

    invoke-static {v1, v3}, Lcom/cyjh/mobileanjian/ipc/engine/utils/CLog;->i(Ljava/lang/String;Ljava/lang/Class;)V

    .line 41
    array-length v1, p0

    if-ge v1, v6, :cond_0

    .line 43
    const/4 v1, -0x1

    invoke-static {v1}, Ljava/lang/System;->exit(I)V

    .line 45
    :cond_0
    aget-object v1, p0, v2

    sput-object v1, Lcom/cyjh/mobileanjian/ipc/ClientService;->c:Ljava/lang/String;

    .line 46
    aget-object v1, p0, v6

    invoke-static {v1}, Ljava/lang/Integer;->parseInt(Ljava/lang/String;)I

    move-result v1

    sput v1, Lcom/cyjh/mobileanjian/ipc/ClientService;->d:I

    .line 47
    aget-object v1, p0, v0

    sput-object v1, Lcom/cyjh/mobileanjian/ipc/engine/utils/g;->c:Ljava/lang/String;

    .line 49
    invoke-static {}, Lcom/cyjh/mobileanjian/ipc/ClientService;->b()V

    .line 51
    invoke-static {}, Lcom/cyjh/mobileanjian/ipc/a/a;->s()Z

    move-result v1

    if-eqz v1, :cond_1

    .line 53
    const-string v1, "setenforce 0"

    invoke-static {v1, v0, v2}, Lcom/cyjh/mobileanjian/ipc/engine/utils/f;->a(Ljava/lang/String;ZI)Lcom/cyjh/mobileanjian/ipc/engine/utils/f$a;

    .line 54
    invoke-static {}, Lcom/cyjh/mobileanjian/ipc/ClientService;->c()V

    .line 61
    :cond_1
    :try_start_0
    sget-object v1, Lcom/cyjh/mobileanjian/ipc/engine/utils/g;->c:Ljava/lang/String;

    invoke-static {v1}, Ljava/lang/System;->load(Ljava/lang/String;)V
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_0

    move v1, v0

    .line 75
    :goto_0
    if-nez v1, :cond_4

    .line 78
    new-instance v3, Ljava/lang/StringBuilder;

    invoke-direct {v3}, Ljava/lang/StringBuilder;-><init>()V

    const-string v4, "/system/"

    invoke-virtual {v3, v4}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v3

    invoke-static {}, Lcom/cyjh/mobileanjian/ipc/a/a;->u()Ljava/lang/String;

    move-result-object v4

    invoke-virtual {v3, v4}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v3

    const-string v4, "/libmqm.so"

    invoke-virtual {v3, v4}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v3

    invoke-virtual {v3}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v3

    sput-object v3, Lcom/cyjh/mobileanjian/ipc/engine/utils/g;->d:Ljava/lang/String;

    .line 79
    invoke-static {}, Lcom/cyjh/mobileanjian/ipc/ClientService;->d()I

    move-result v3

    const/16 v4, 0xa

    if-ge v3, v4, :cond_2

    .line 81
    const/4 v3, 0x4

    new-array v3, v3, [Ljava/lang/String;

    const-string v4, "mount -o remount,rw /system"

    aput-object v4, v3, v2

    new-instance v4, Ljava/lang/StringBuilder;

    invoke-direct {v4}, Ljava/lang/StringBuilder;-><init>()V

    const-string v5, "mkdir /system/"

    invoke-virtual {v4, v5}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v4

    .line 83
    invoke-static {}, Lcom/cyjh/mobileanjian/ipc/a/a;->u()Ljava/lang/String;

    move-result-object v5

    invoke-virtual {v4, v5}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v4

    invoke-virtual {v4}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v4

    aput-object v4, v3, v0

    new-instance v4, Ljava/lang/StringBuilder;

    invoke-direct {v4}, Ljava/lang/StringBuilder;-><init>()V

    const-string v5, "cat "

    invoke-virtual {v4, v5}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v4

    sget-object v5, Lcom/cyjh/mobileanjian/ipc/engine/utils/g;->c:Ljava/lang/String;

    invoke-virtual {v4, v5}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v4

    const-string v5, " > "

    invoke-virtual {v4, v5}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v4

    sget-object v5, Lcom/cyjh/mobileanjian/ipc/engine/utils/g;->d:Ljava/lang/String;

    invoke-virtual {v4, v5}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v4

    invoke-virtual {v4}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v4

    aput-object v4, v3, v6

    const/4 v4, 0x3

    const-string v5, "mount -o remount,ro /system"

    aput-object v5, v3, v4

    .line 88
    invoke-static {v3, v0, v2}, Lcom/cyjh/mobileanjian/ipc/engine/utils/f;->a([Ljava/lang/String;ZI)Lcom/cyjh/mobileanjian/ipc/engine/utils/f$a;

    .line 94
    :cond_2
    :try_start_1
    new-instance v3, Ljava/io/File;

    sget-object v4, Lcom/cyjh/mobileanjian/ipc/engine/utils/g;->d:Ljava/lang/String;

    invoke-direct {v3, v4}, Ljava/io/File;-><init>(Ljava/lang/String;)V

    invoke-virtual {v3}, Ljava/io/File;->exists()Z

    move-result v3

    if-eqz v3, :cond_4

    .line 96
    invoke-static {}, Lcom/cyjh/mobileanjian/ipc/ClientService;->e()V

    .line 97
    sget-object v1, Lcom/cyjh/mobileanjian/ipc/engine/utils/g;->d:Ljava/lang/String;

    invoke-static {v1}, Ljava/lang/System;->load(Ljava/lang/String;)V
    :try_end_1
    .catch Ljava/lang/Throwable; {:try_start_1 .. :try_end_1} :catch_1

    .line 107
    :goto_1
    if-eqz v0, :cond_3

    .line 108
    new-instance v0, Lcom/cyjh/mobileanjian/ipc/ClientService;

    invoke-direct {v0}, Lcom/cyjh/mobileanjian/ipc/ClientService;-><init>()V

    invoke-direct {v0}, Lcom/cyjh/mobileanjian/ipc/ClientService;->f()V

    .line 111
    :goto_2
    return-void

    .line 63
    :catch_0
    move-exception v1

    .line 65
    const-string v1, "!!! load first libmqm.so FAILED !!!"

    sget-object v3, Lcom/cyjh/mobileanjian/ipc/ClientService;->a:Ljava/lang/Class;

    invoke-static {v1, v3}, Lcom/cyjh/mobileanjian/ipc/engine/utils/CLog;->e(Ljava/lang/String;Ljava/lang/Class;)V

    move v1, v2

    .line 66
    goto/16 :goto_0

    .line 101
    :catch_1
    move-exception v0

    .line 103
    const-string v0, "!!! load second libmqm.so FAILED !!!"

    sget-object v1, Lcom/cyjh/mobileanjian/ipc/ClientService;->a:Ljava/lang/Class;

    invoke-static {v0, v1}, Lcom/cyjh/mobileanjian/ipc/engine/utils/CLog;->e(Ljava/lang/String;Ljava/lang/Class;)V

    move v0, v2

    .line 104
    goto :goto_1

    .line 110
    :cond_3
    const-string v0, "MAJ_ERROR"

    const-string v1, "CAN NOT LOAD NATIVE LIBRARY!!!"

    invoke-static {v0, v1}, Landroid/util/Log;->e(Ljava/lang/String;Ljava/lang/String;)I

    goto :goto_2

    :cond_4
    move v0, v1

    goto :goto_1
.end method
