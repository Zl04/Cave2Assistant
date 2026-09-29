.class public final Lcom/cyjh/mobileanjian/ipc/j;
.super Ljava/lang/Object;
.source "SourceFile"


# annotations
.annotation system Ldalvik/annotation/MemberClasses;
    value = {
        Lcom/cyjh/mobileanjian/ipc/j$a;
    }
.end annotation


# static fields
.field private static final a:Ljava/lang/String; = "echo \"rootOK\"\n"

.field private static b:Lcom/cyjh/mobileanjian/ipc/j;


# instance fields
.field private c:Lcom/cyjh/mobileanjian/ipc/interfaces/OnRootApplyCallback;

.field private d:Lcom/cyjh/mobileanjian/ipc/j$a;

.field private e:Z

.field private f:Ljava/io/DataOutputStream;

.field private g:Ljava/io/InputStream;

.field private h:Ljava/lang/Process;


# direct methods
.method public constructor <init>()V
    .locals 2

    .prologue
    const/4 v1, 0x0

    .line 35
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    .line 25
    iput-object v1, p0, Lcom/cyjh/mobileanjian/ipc/j;->c:Lcom/cyjh/mobileanjian/ipc/interfaces/OnRootApplyCallback;

    .line 27
    iput-object v1, p0, Lcom/cyjh/mobileanjian/ipc/j;->d:Lcom/cyjh/mobileanjian/ipc/j$a;

    .line 29
    const/4 v0, 0x0

    iput-boolean v0, p0, Lcom/cyjh/mobileanjian/ipc/j;->e:Z

    .line 30
    iput-object v1, p0, Lcom/cyjh/mobileanjian/ipc/j;->f:Ljava/io/DataOutputStream;

    .line 31
    iput-object v1, p0, Lcom/cyjh/mobileanjian/ipc/j;->g:Ljava/io/InputStream;

    .line 32
    iput-object v1, p0, Lcom/cyjh/mobileanjian/ipc/j;->h:Ljava/lang/Process;

    .line 37
    return-void
.end method

.method static synthetic a(Lcom/cyjh/mobileanjian/ipc/j;Ljava/io/DataOutputStream;)Ljava/io/DataOutputStream;
    .locals 0

    .prologue
    .line 19
    iput-object p1, p0, Lcom/cyjh/mobileanjian/ipc/j;->f:Ljava/io/DataOutputStream;

    return-object p1
.end method

.method static synthetic a(Lcom/cyjh/mobileanjian/ipc/j;Ljava/io/InputStream;)Ljava/io/InputStream;
    .locals 0

    .prologue
    .line 19
    iput-object p1, p0, Lcom/cyjh/mobileanjian/ipc/j;->g:Ljava/io/InputStream;

    return-object p1
.end method

.method static synthetic a(Lcom/cyjh/mobileanjian/ipc/j;)Ljava/lang/Process;
    .locals 1

    .prologue
    .line 19
    iget-object v0, p0, Lcom/cyjh/mobileanjian/ipc/j;->h:Ljava/lang/Process;

    return-object v0
.end method

.method static synthetic a(Lcom/cyjh/mobileanjian/ipc/j;Ljava/lang/Process;)Ljava/lang/Process;
    .locals 0

    .prologue
    .line 19
    iput-object p1, p0, Lcom/cyjh/mobileanjian/ipc/j;->h:Ljava/lang/Process;

    return-object p1
.end method

.method static synthetic a(Lcom/cyjh/mobileanjian/ipc/j;Ljava/lang/Process;Z)V
    .locals 0

    .prologue
    .line 19
    invoke-direct {p0, p1, p2}, Lcom/cyjh/mobileanjian/ipc/j;->a(Ljava/lang/Process;Z)V

    return-void
.end method

.method private a(Ljava/lang/Process;Z)V
    .locals 3

    .prologue
    .line 106
    new-instance v0, Lcom/cyjh/mobileanjian/ipc/j$1;

    const-string v1, ""

    invoke-direct {v0, p0, v1, p1}, Lcom/cyjh/mobileanjian/ipc/j$1;-><init>(Lcom/cyjh/mobileanjian/ipc/j;Ljava/lang/String;Ljava/lang/Process;)V

    .line 147
    new-instance v1, Lcom/cyjh/mobileanjian/ipc/j$2;

    const-string v2, ""

    invoke-direct {v1, p0, v2, p2}, Lcom/cyjh/mobileanjian/ipc/j$2;-><init>(Lcom/cyjh/mobileanjian/ipc/j;Ljava/lang/String;Z)V

    .line 198
    if-eqz p2, :cond_0

    .line 199
    invoke-virtual {v0}, Ljava/lang/Thread;->start()V

    .line 200
    :cond_0
    invoke-virtual {v1}, Ljava/lang/Thread;->start()V

    .line 205
    if-eqz p2, :cond_3

    .line 209
    :try_start_0
    invoke-virtual {v0}, Ljava/lang/Thread;->join()V
    :try_end_0
    .catch Ljava/lang/InterruptedException; {:try_start_0 .. :try_end_0} :catch_3

    .line 216
    :goto_0
    :try_start_1
    invoke-virtual {v1}, Ljava/lang/Thread;->join()V
    :try_end_1
    .catch Ljava/lang/InterruptedException; {:try_start_1 .. :try_end_1} :catch_0

    .line 235
    :goto_1
    new-instance v0, Ljava/lang/StringBuilder;

    invoke-direct {v0}, Ljava/lang/StringBuilder;-><init>()V

    const-string v1, "go straight here, mRoot = "

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    iget-boolean v1, p0, Lcom/cyjh/mobileanjian/ipc/j;->e:Z

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Z)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-virtual {v0}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v0

    invoke-static {v0}, Lcom/cyjh/mobileanjian/ipc/utils/CLog;->w(Ljava/lang/String;)V

    .line 237
    iget-boolean v0, p0, Lcom/cyjh/mobileanjian/ipc/j;->e:Z

    if-nez v0, :cond_2

    .line 239
    iget-object v0, p0, Lcom/cyjh/mobileanjian/ipc/j;->h:Ljava/lang/Process;

    invoke-virtual {v0}, Ljava/lang/Process;->destroy()V

    .line 240
    iget-object v0, p0, Lcom/cyjh/mobileanjian/ipc/j;->c:Lcom/cyjh/mobileanjian/ipc/interfaces/OnRootApplyCallback;

    if-eqz v0, :cond_1

    .line 241
    iget-object v0, p0, Lcom/cyjh/mobileanjian/ipc/j;->c:Lcom/cyjh/mobileanjian/ipc/interfaces/OnRootApplyCallback;

    invoke-interface {v0}, Lcom/cyjh/mobileanjian/ipc/interfaces/OnRootApplyCallback;->onRefused()V

    .line 244
    :cond_1
    :try_start_2
    iget-object v0, p0, Lcom/cyjh/mobileanjian/ipc/j;->f:Ljava/io/DataOutputStream;

    invoke-virtual {v0}, Ljava/io/DataOutputStream;->close()V
    :try_end_2
    .catch Ljava/io/IOException; {:try_start_2 .. :try_end_2} :catch_2

    .line 251
    :cond_2
    :goto_2
    return-void

    .line 218
    :catch_0
    move-exception v0

    .line 220
    invoke-virtual {v0}, Ljava/lang/InterruptedException;->printStackTrace()V

    goto :goto_1

    .line 227
    :cond_3
    :try_start_3
    invoke-virtual {v1}, Ljava/lang/Thread;->join()V
    :try_end_3
    .catch Ljava/lang/InterruptedException; {:try_start_3 .. :try_end_3} :catch_1

    goto :goto_1

    .line 229
    :catch_1
    move-exception v0

    .line 231
    invoke-virtual {v0}, Ljava/lang/InterruptedException;->printStackTrace()V

    goto :goto_1

    .line 246
    :catch_2
    move-exception v0

    .line 248
    invoke-virtual {v0}, Ljava/io/IOException;->printStackTrace()V

    goto :goto_2

    .line 211
    :catch_3
    move-exception v0

    goto :goto_0
.end method

.method static synthetic a(Lcom/cyjh/mobileanjian/ipc/j;Z)Z
    .locals 0

    .prologue
    .line 19
    iput-boolean p1, p0, Lcom/cyjh/mobileanjian/ipc/j;->e:Z

    return p1
.end method

.method public static declared-synchronized b()Lcom/cyjh/mobileanjian/ipc/j;
    .locals 2

    .prologue
    .line 70
    const-class v1, Lcom/cyjh/mobileanjian/ipc/j;

    monitor-enter v1

    :try_start_0
    sget-object v0, Lcom/cyjh/mobileanjian/ipc/j;->b:Lcom/cyjh/mobileanjian/ipc/j;

    if-nez v0, :cond_0

    .line 71
    new-instance v0, Lcom/cyjh/mobileanjian/ipc/j;

    invoke-direct {v0}, Lcom/cyjh/mobileanjian/ipc/j;-><init>()V

    sput-object v0, Lcom/cyjh/mobileanjian/ipc/j;->b:Lcom/cyjh/mobileanjian/ipc/j;

    .line 72
    :cond_0
    sget-object v0, Lcom/cyjh/mobileanjian/ipc/j;->b:Lcom/cyjh/mobileanjian/ipc/j;
    :try_end_0
    .catchall {:try_start_0 .. :try_end_0} :catchall_0

    monitor-exit v1

    return-object v0

    .line 70
    :catchall_0
    move-exception v0

    monitor-exit v1

    throw v0
.end method

.method static synthetic b(Lcom/cyjh/mobileanjian/ipc/j;)Ljava/io/DataOutputStream;
    .locals 1

    .prologue
    .line 19
    iget-object v0, p0, Lcom/cyjh/mobileanjian/ipc/j;->f:Ljava/io/DataOutputStream;

    return-object v0
.end method

.method static synthetic c(Lcom/cyjh/mobileanjian/ipc/j;)Lcom/cyjh/mobileanjian/ipc/interfaces/OnRootApplyCallback;
    .locals 1

    .prologue
    .line 19
    iget-object v0, p0, Lcom/cyjh/mobileanjian/ipc/j;->c:Lcom/cyjh/mobileanjian/ipc/interfaces/OnRootApplyCallback;

    return-object v0
.end method

.method static synthetic d(Lcom/cyjh/mobileanjian/ipc/j;)Ljava/io/InputStream;
    .locals 1

    .prologue
    .line 19
    iget-object v0, p0, Lcom/cyjh/mobileanjian/ipc/j;->g:Ljava/io/InputStream;

    return-object v0
.end method

.method private d()V
    .locals 2

    .prologue
    .line 297
    new-instance v0, Lcom/cyjh/mobileanjian/ipc/j$a;

    const/4 v1, 0x0

    invoke-direct {v0, p0, v1}, Lcom/cyjh/mobileanjian/ipc/j$a;-><init>(Lcom/cyjh/mobileanjian/ipc/j;Lcom/cyjh/mobileanjian/ipc/j$1;)V

    iput-object v0, p0, Lcom/cyjh/mobileanjian/ipc/j;->d:Lcom/cyjh/mobileanjian/ipc/j$a;

    .line 298
    iget-object v0, p0, Lcom/cyjh/mobileanjian/ipc/j;->d:Lcom/cyjh/mobileanjian/ipc/j$a;

    invoke-virtual {v0}, Lcom/cyjh/mobileanjian/ipc/j$a;->start()V

    .line 299
    return-void
.end method


# virtual methods
.method public a(Lcom/cyjh/mobileanjian/ipc/interfaces/OnRootApplyCallback;)V
    .locals 1

    .prologue
    .line 55
    iget-boolean v0, p0, Lcom/cyjh/mobileanjian/ipc/j;->e:Z

    if-eqz v0, :cond_0

    .line 56
    invoke-interface {p1}, Lcom/cyjh/mobileanjian/ipc/interfaces/OnRootApplyCallback;->onObtained()V

    .line 62
    :goto_0
    return-void

    .line 59
    :cond_0
    iput-object p1, p0, Lcom/cyjh/mobileanjian/ipc/j;->c:Lcom/cyjh/mobileanjian/ipc/interfaces/OnRootApplyCallback;

    .line 60
    invoke-direct {p0}, Lcom/cyjh/mobileanjian/ipc/j;->d()V

    goto :goto_0
.end method

.method public a(Ljava/lang/String;)V
    .locals 0

    .prologue
    .line 42
    return-void
.end method

.method public a()Z
    .locals 1

    .prologue
    .line 46
    iget-boolean v0, p0, Lcom/cyjh/mobileanjian/ipc/j;->e:Z

    return v0
.end method

.method public b(Ljava/lang/String;)Z
    .locals 2

    .prologue
    .line 280
    iget-boolean v0, p0, Lcom/cyjh/mobileanjian/ipc/j;->e:Z

    if-nez v0, :cond_0

    .line 281
    const/4 v0, 0x0

    .line 292
    :goto_0
    return v0

    .line 284
    :cond_0
    :try_start_0
    iget-object v0, p0, Lcom/cyjh/mobileanjian/ipc/j;->f:Ljava/io/DataOutputStream;

    invoke-virtual {p1}, Ljava/lang/String;->getBytes()[B

    move-result-object v1

    invoke-virtual {v0, v1}, Ljava/io/DataOutputStream;->write([B)V

    .line 285
    iget-object v0, p0, Lcom/cyjh/mobileanjian/ipc/j;->f:Ljava/io/DataOutputStream;

    const-string v1, "\n"

    invoke-virtual {v1}, Ljava/lang/String;->getBytes()[B

    move-result-object v1

    invoke-virtual {v0, v1}, Ljava/io/DataOutputStream;->write([B)V

    .line 286
    iget-object v0, p0, Lcom/cyjh/mobileanjian/ipc/j;->f:Ljava/io/DataOutputStream;

    invoke-virtual {v0}, Ljava/io/DataOutputStream;->flush()V

    .line 287
    new-instance v0, Ljava/lang/StringBuilder;

    invoke-direct {v0}, Ljava/lang/StringBuilder;-><init>()V

    const-string v1, "execute command: "

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-virtual {v0, p1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-virtual {v0}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v0

    invoke-static {v0}, Lcom/cyjh/mobileanjian/ipc/utils/CLog;->i(Ljava/lang/String;)V
    :try_end_0
    .catch Ljava/io/IOException; {:try_start_0 .. :try_end_0} :catch_0

    .line 292
    :goto_1
    const/4 v0, 0x1

    goto :goto_0

    .line 288
    :catch_0
    move-exception v0

    .line 290
    invoke-virtual {v0}, Ljava/io/IOException;->printStackTrace()V

    goto :goto_1
.end method

.method public c()V
    .locals 1

    .prologue
    .line 255
    iget-boolean v0, p0, Lcom/cyjh/mobileanjian/ipc/j;->e:Z

    if-eqz v0, :cond_1

    .line 257
    const-string v0, "exit"

    invoke-virtual {p0, v0}, Lcom/cyjh/mobileanjian/ipc/j;->b(Ljava/lang/String;)Z

    .line 258
    iget-object v0, p0, Lcom/cyjh/mobileanjian/ipc/j;->d:Lcom/cyjh/mobileanjian/ipc/j$a;

    invoke-virtual {v0}, Lcom/cyjh/mobileanjian/ipc/j$a;->isAlive()Z

    move-result v0

    if-eqz v0, :cond_0

    .line 260
    iget-object v0, p0, Lcom/cyjh/mobileanjian/ipc/j;->d:Lcom/cyjh/mobileanjian/ipc/j$a;

    invoke-virtual {v0}, Lcom/cyjh/mobileanjian/ipc/j$a;->interrupt()V

    .line 264
    :cond_0
    :try_start_0
    iget-object v0, p0, Lcom/cyjh/mobileanjian/ipc/j;->f:Ljava/io/DataOutputStream;

    invoke-virtual {v0}, Ljava/io/DataOutputStream;->close()V
    :try_end_0
    .catch Ljava/io/IOException; {:try_start_0 .. :try_end_0} :catch_0

    .line 271
    :cond_1
    :goto_0
    const/4 v0, 0x0

    sput-object v0, Lcom/cyjh/mobileanjian/ipc/j;->b:Lcom/cyjh/mobileanjian/ipc/j;

    .line 272
    return-void

    .line 266
    :catch_0
    move-exception v0

    .line 268
    invoke-virtual {v0}, Ljava/io/IOException;->printStackTrace()V

    goto :goto_0
.end method
