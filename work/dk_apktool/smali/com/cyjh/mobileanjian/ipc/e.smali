.class public Lcom/cyjh/mobileanjian/ipc/e;
.super Ljava/lang/Object;
.source "SourceFile"

# interfaces
.implements Lcom/cyjh/mobileanjian/ipc/interfaces/AppQuitListener;


# static fields
.field private static final a:I = 0x276c


# instance fields
.field private b:Ljava/net/ServerSocket;

.field private c:Lcom/cyjh/mobileanjian/ipc/d;

.field private d:Landroid/content/Context;

.field private e:Z

.field private f:Ljava/util/List;
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "Ljava/util/List",
            "<",
            "Lcom/cyjh/mobileanjian/ipc/interfaces/EngineStateObserver;",
            ">;"
        }
    .end annotation
.end field


# direct methods
.method public constructor <init>(Landroid/content/Context;)V
    .locals 1

    .prologue
    const/4 v0, 0x0

    .line 33
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    .line 24
    iput-object v0, p0, Lcom/cyjh/mobileanjian/ipc/e;->b:Ljava/net/ServerSocket;

    .line 25
    iput-object v0, p0, Lcom/cyjh/mobileanjian/ipc/e;->c:Lcom/cyjh/mobileanjian/ipc/d;

    .line 27
    iput-object v0, p0, Lcom/cyjh/mobileanjian/ipc/e;->d:Landroid/content/Context;

    .line 28
    const/4 v0, 0x0

    iput-boolean v0, p0, Lcom/cyjh/mobileanjian/ipc/e;->e:Z

    .line 30
    new-instance v0, Ljava/util/ArrayList;

    invoke-direct {v0}, Ljava/util/ArrayList;-><init>()V

    iput-object v0, p0, Lcom/cyjh/mobileanjian/ipc/e;->f:Ljava/util/List;

    .line 34
    iput-object p1, p0, Lcom/cyjh/mobileanjian/ipc/e;->d:Landroid/content/Context;

    .line 35
    return-void
.end method

.method static synthetic a(Lcom/cyjh/mobileanjian/ipc/e;Lcom/cyjh/mobileanjian/ipc/d;)Lcom/cyjh/mobileanjian/ipc/d;
    .locals 0

    .prologue
    .line 21
    iput-object p1, p0, Lcom/cyjh/mobileanjian/ipc/e;->c:Lcom/cyjh/mobileanjian/ipc/d;

    return-object p1
.end method

.method static synthetic a(Lcom/cyjh/mobileanjian/ipc/e;)Z
    .locals 1

    .prologue
    .line 21
    iget-boolean v0, p0, Lcom/cyjh/mobileanjian/ipc/e;->e:Z

    return v0
.end method

.method static synthetic b(Lcom/cyjh/mobileanjian/ipc/e;)Ljava/net/ServerSocket;
    .locals 1

    .prologue
    .line 21
    iget-object v0, p0, Lcom/cyjh/mobileanjian/ipc/e;->b:Ljava/net/ServerSocket;

    return-object v0
.end method

.method static synthetic c(Lcom/cyjh/mobileanjian/ipc/e;)Lcom/cyjh/mobileanjian/ipc/d;
    .locals 1

    .prologue
    .line 21
    iget-object v0, p0, Lcom/cyjh/mobileanjian/ipc/e;->c:Lcom/cyjh/mobileanjian/ipc/d;

    return-object v0
.end method

.method static synthetic d(Lcom/cyjh/mobileanjian/ipc/e;)Landroid/content/Context;
    .locals 1

    .prologue
    .line 21
    iget-object v0, p0, Lcom/cyjh/mobileanjian/ipc/e;->d:Landroid/content/Context;

    return-object v0
.end method

.method static synthetic e(Lcom/cyjh/mobileanjian/ipc/e;)Ljava/util/List;
    .locals 1

    .prologue
    .line 21
    iget-object v0, p0, Lcom/cyjh/mobileanjian/ipc/e;->f:Ljava/util/List;

    return-object v0
.end method


# virtual methods
.method public a(Lcom/cyjh/mobileanjian/ipc/interfaces/EngineStateObserver;)V
    .locals 1

    .prologue
    .line 40
    iget-object v0, p0, Lcom/cyjh/mobileanjian/ipc/e;->f:Ljava/util/List;

    invoke-interface {v0, p1}, Ljava/util/List;->add(Ljava/lang/Object;)Z

    .line 41
    return-void
.end method

.method public a(Ljava/lang/String;I)V
    .locals 4

    .prologue
    .line 50
    :goto_0
    iget-object v0, p0, Lcom/cyjh/mobileanjian/ipc/e;->b:Ljava/net/ServerSocket;

    if-nez v0, :cond_0

    .line 54
    :try_start_0
    new-instance v0, Ljava/net/ServerSocket;

    invoke-direct {v0, p2}, Ljava/net/ServerSocket;-><init>(I)V

    iput-object v0, p0, Lcom/cyjh/mobileanjian/ipc/e;->b:Ljava/net/ServerSocket;
    :try_end_0
    .catch Ljava/io/IOException; {:try_start_0 .. :try_end_0} :catch_0

    goto :goto_0

    .line 55
    :catch_0
    move-exception v0

    .line 59
    const-wide/16 v2, 0x3e8

    :try_start_1
    invoke-static {v2, v3}, Ljava/lang/Thread;->sleep(J)V
    :try_end_1
    .catch Ljava/lang/InterruptedException; {:try_start_1 .. :try_end_1} :catch_1

    .line 64
    :goto_1
    invoke-virtual {v0}, Ljava/io/IOException;->printStackTrace()V

    goto :goto_0

    .line 60
    :catch_1
    move-exception v1

    .line 62
    invoke-virtual {v1}, Ljava/lang/InterruptedException;->printStackTrace()V

    goto :goto_1

    .line 71
    :cond_0
    :try_start_2
    new-instance v0, Lcom/cyjh/mobileanjian/ipc/e$1;

    const-string v1, "server socket thread"

    invoke-direct {v0, p0, v1}, Lcom/cyjh/mobileanjian/ipc/e$1;-><init>(Lcom/cyjh/mobileanjian/ipc/e;Ljava/lang/String;)V

    .line 100
    invoke-virtual {v0}, Lcom/cyjh/mobileanjian/ipc/e$1;->start()V

    .line 103
    new-instance v0, Landroid/net/LocalServerSocket;

    invoke-direct {v0, p1}, Landroid/net/LocalServerSocket;-><init>(Ljava/lang/String;)V

    .line 104
    :goto_2
    iget-boolean v1, p0, Lcom/cyjh/mobileanjian/ipc/e;->e:Z

    if-nez v1, :cond_2

    .line 106
    const-string v1, "Waiting root process connected!"

    invoke-static {v1}, Lcom/cyjh/mobileanjian/ipc/utils/CLog;->i(Ljava/lang/String;)V

    .line 107
    invoke-virtual {v0}, Landroid/net/LocalServerSocket;->accept()Landroid/net/LocalSocket;

    move-result-object v1

    .line 108
    const-string v2, "a root process connected to app!"

    invoke-static {v2}, Lcom/cyjh/mobileanjian/ipc/utils/CLog;->i(Ljava/lang/String;)V

    .line 109
    iget-object v2, p0, Lcom/cyjh/mobileanjian/ipc/e;->c:Lcom/cyjh/mobileanjian/ipc/d;

    if-eqz v2, :cond_1

    iget-object v2, p0, Lcom/cyjh/mobileanjian/ipc/e;->c:Lcom/cyjh/mobileanjian/ipc/d;

    invoke-virtual {v2}, Lcom/cyjh/mobileanjian/ipc/d;->b()Z

    move-result v2

    if-eqz v2, :cond_1

    .line 110
    iget-object v1, p0, Lcom/cyjh/mobileanjian/ipc/e;->c:Lcom/cyjh/mobileanjian/ipc/d;

    invoke-virtual {v1}, Lcom/cyjh/mobileanjian/ipc/d;->a()V
    :try_end_2
    .catch Ljava/io/IOException; {:try_start_2 .. :try_end_2} :catch_2

    goto :goto_2

    .line 122
    :catch_2
    move-exception v0

    .line 124
    invoke-virtual {v0}, Ljava/io/IOException;->printStackTrace()V

    .line 126
    :goto_3
    return-void

    .line 113
    :cond_1
    :try_start_3
    new-instance v2, Lcom/cyjh/mobileanjian/ipc/d;

    iget-object v3, p0, Lcom/cyjh/mobileanjian/ipc/e;->d:Landroid/content/Context;

    invoke-direct {v2, v3, v1}, Lcom/cyjh/mobileanjian/ipc/d;-><init>(Landroid/content/Context;Landroid/net/LocalSocket;)V

    iput-object v2, p0, Lcom/cyjh/mobileanjian/ipc/e;->c:Lcom/cyjh/mobileanjian/ipc/d;

    .line 114
    iget-object v1, p0, Lcom/cyjh/mobileanjian/ipc/e;->c:Lcom/cyjh/mobileanjian/ipc/d;

    iget-object v2, p0, Lcom/cyjh/mobileanjian/ipc/e;->f:Ljava/util/List;

    invoke-virtual {v1, v2}, Lcom/cyjh/mobileanjian/ipc/d;->a(Ljava/util/List;)V

    .line 116
    iget-object v1, p0, Lcom/cyjh/mobileanjian/ipc/e;->c:Lcom/cyjh/mobileanjian/ipc/d;

    invoke-virtual {v1}, Lcom/cyjh/mobileanjian/ipc/d;->d()V

    goto :goto_2

    .line 120
    :cond_2
    const-string v1, "Local server stopped!"

    invoke-static {v1}, Lcom/cyjh/mobileanjian/ipc/utils/CLog;->i(Ljava/lang/String;)V

    .line 121
    invoke-virtual {v0}, Landroid/net/LocalServerSocket;->close()V
    :try_end_3
    .catch Ljava/io/IOException; {:try_start_3 .. :try_end_3} :catch_2

    goto :goto_3
.end method

.method public b(Lcom/cyjh/mobileanjian/ipc/interfaces/EngineStateObserver;)V
    .locals 1

    .prologue
    .line 45
    iget-object v0, p0, Lcom/cyjh/mobileanjian/ipc/e;->f:Ljava/util/List;

    invoke-interface {v0, p1}, Ljava/util/List;->remove(Ljava/lang/Object;)Z

    .line 46
    return-void
.end method

.method public onAppQuit()V
    .locals 1

    .prologue
    .line 131
    iget-boolean v0, p0, Lcom/cyjh/mobileanjian/ipc/e;->e:Z

    if-nez v0, :cond_0

    .line 133
    const/4 v0, 0x1

    iput-boolean v0, p0, Lcom/cyjh/mobileanjian/ipc/e;->e:Z

    .line 134
    iget-object v0, p0, Lcom/cyjh/mobileanjian/ipc/e;->c:Lcom/cyjh/mobileanjian/ipc/d;

    invoke-virtual {v0}, Lcom/cyjh/mobileanjian/ipc/d;->a()V

    .line 136
    :cond_0
    return-void
.end method
