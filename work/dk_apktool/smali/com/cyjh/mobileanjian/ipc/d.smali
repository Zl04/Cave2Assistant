.class public Lcom/cyjh/mobileanjian/ipc/d;
.super Lcom/cyjh/mobileanjian/ipc/b;
.source "SourceFile"


# static fields
.field private static final a:I = 0x1000

.field private static final b:I = 0x400


# instance fields
.field private c:Z

.field private d:Z

.field private e:Lcom/cyjh/mobileanjian/ipc/g;

.field private f:Landroid/content/Context;

.field private g:Z

.field private h:Z

.field private i:Ljava/util/List;
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "Ljava/util/List",
            "<",
            "Lcom/cyjh/mobileanjian/ipc/interfaces/EngineStateObserver;",
            ">;"
        }
    .end annotation
.end field

.field private j:Ljava/util/Vector;
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "Ljava/util/Vector",
            "<",
            "Lcom/cyjh/mobileanjian/ipc/interfaces/ScriptStateObserver;",
            ">;"
        }
    .end annotation
.end field

.field private k:Lcom/cyjh/mobileanjian/ipc/interfaces/OnRecordScriptCallback;

.field private l:Lcom/cyjh/mobileanjian/ipc/interfaces/OnScreenShotCallback;

.field private m:Lcom/cyjh/mobileanjian/ipc/interfaces/OnUiUpdateCallback;

.field private n:Lcom/cyjh/mobileanjian/ipc/interfaces/OnScriptMessageCallback;

.field private o:Lcom/cyjh/mobileanjian/ipc/interfaces/BasicScriptListener;

.field private p:Lcom/cyjh/mobileanjian/ipc/interfaces/OnScriptListener;

.field private q:Ljava/util/concurrent/ArrayBlockingQueue;
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "Ljava/util/concurrent/ArrayBlockingQueue",
            "<",
            "Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$IpcMessage;",
            ">;"
        }
    .end annotation
.end field

.field private r:Ljava/lang/Thread;

.field private s:Lcom/cyjh/mobileanjian/ipc/interfaces/OnRpcCallback;


# direct methods
.method public constructor <init>(Landroid/content/Context;Landroid/net/LocalSocket;)V
    .locals 3

    .prologue
    const/4 v1, 0x0

    const/4 v2, 0x0

    .line 94
    invoke-direct {p0, p2}, Lcom/cyjh/mobileanjian/ipc/b;-><init>(Landroid/net/LocalSocket;)V

    .line 41
    const/4 v0, 0x1

    iput-boolean v0, p0, Lcom/cyjh/mobileanjian/ipc/d;->c:Z

    .line 42
    iput-boolean v1, p0, Lcom/cyjh/mobileanjian/ipc/d;->d:Z

    .line 44
    iput-object v2, p0, Lcom/cyjh/mobileanjian/ipc/d;->e:Lcom/cyjh/mobileanjian/ipc/g;

    .line 46
    iput-object v2, p0, Lcom/cyjh/mobileanjian/ipc/d;->f:Landroid/content/Context;

    .line 47
    iput-boolean v1, p0, Lcom/cyjh/mobileanjian/ipc/d;->g:Z

    .line 48
    iput-boolean v1, p0, Lcom/cyjh/mobileanjian/ipc/d;->h:Z

    .line 51
    new-instance v0, Ljava/util/ArrayList;

    invoke-direct {v0}, Ljava/util/ArrayList;-><init>()V

    iput-object v0, p0, Lcom/cyjh/mobileanjian/ipc/d;->i:Ljava/util/List;

    .line 52
    new-instance v0, Ljava/util/Vector;

    invoke-direct {v0}, Ljava/util/Vector;-><init>()V

    iput-object v0, p0, Lcom/cyjh/mobileanjian/ipc/d;->j:Ljava/util/Vector;

    .line 55
    iput-object v2, p0, Lcom/cyjh/mobileanjian/ipc/d;->k:Lcom/cyjh/mobileanjian/ipc/interfaces/OnRecordScriptCallback;

    .line 56
    iput-object v2, p0, Lcom/cyjh/mobileanjian/ipc/d;->l:Lcom/cyjh/mobileanjian/ipc/interfaces/OnScreenShotCallback;

    .line 57
    iput-object v2, p0, Lcom/cyjh/mobileanjian/ipc/d;->m:Lcom/cyjh/mobileanjian/ipc/interfaces/OnUiUpdateCallback;

    .line 58
    iput-object v2, p0, Lcom/cyjh/mobileanjian/ipc/d;->n:Lcom/cyjh/mobileanjian/ipc/interfaces/OnScriptMessageCallback;

    .line 59
    iput-object v2, p0, Lcom/cyjh/mobileanjian/ipc/d;->o:Lcom/cyjh/mobileanjian/ipc/interfaces/BasicScriptListener;

    .line 60
    iput-object v2, p0, Lcom/cyjh/mobileanjian/ipc/d;->p:Lcom/cyjh/mobileanjian/ipc/interfaces/OnScriptListener;

    .line 62
    new-instance v0, Ljava/util/concurrent/ArrayBlockingQueue;

    const/16 v1, 0x400

    invoke-direct {v0, v1}, Ljava/util/concurrent/ArrayBlockingQueue;-><init>(I)V

    iput-object v0, p0, Lcom/cyjh/mobileanjian/ipc/d;->q:Ljava/util/concurrent/ArrayBlockingQueue;

    .line 63
    new-instance v0, Lcom/cyjh/mobileanjian/ipc/d$1;

    const-string v1, "send_thread"

    invoke-direct {v0, p0, v1}, Lcom/cyjh/mobileanjian/ipc/d$1;-><init>(Lcom/cyjh/mobileanjian/ipc/d;Ljava/lang/String;)V

    iput-object v0, p0, Lcom/cyjh/mobileanjian/ipc/d;->r:Ljava/lang/Thread;

    .line 156
    iput-object v2, p0, Lcom/cyjh/mobileanjian/ipc/d;->s:Lcom/cyjh/mobileanjian/ipc/interfaces/OnRpcCallback;

    .line 95
    iput-object p1, p0, Lcom/cyjh/mobileanjian/ipc/d;->f:Landroid/content/Context;

    .line 96
    new-instance v0, Lcom/cyjh/mobileanjian/ipc/g;

    invoke-direct {v0, p1, p0}, Lcom/cyjh/mobileanjian/ipc/g;-><init>(Landroid/content/Context;Lcom/cyjh/mobileanjian/ipc/d;)V

    iput-object v0, p0, Lcom/cyjh/mobileanjian/ipc/d;->e:Lcom/cyjh/mobileanjian/ipc/g;

    .line 97
    return-void
.end method

.method public constructor <init>(Landroid/content/Context;Ljava/net/Socket;)V
    .locals 3

    .prologue
    const/4 v1, 0x0

    const/4 v2, 0x0

    .line 87
    invoke-direct {p0, p2}, Lcom/cyjh/mobileanjian/ipc/b;-><init>(Ljava/net/Socket;)V

    .line 41
    const/4 v0, 0x1

    iput-boolean v0, p0, Lcom/cyjh/mobileanjian/ipc/d;->c:Z

    .line 42
    iput-boolean v1, p0, Lcom/cyjh/mobileanjian/ipc/d;->d:Z

    .line 44
    iput-object v2, p0, Lcom/cyjh/mobileanjian/ipc/d;->e:Lcom/cyjh/mobileanjian/ipc/g;

    .line 46
    iput-object v2, p0, Lcom/cyjh/mobileanjian/ipc/d;->f:Landroid/content/Context;

    .line 47
    iput-boolean v1, p0, Lcom/cyjh/mobileanjian/ipc/d;->g:Z

    .line 48
    iput-boolean v1, p0, Lcom/cyjh/mobileanjian/ipc/d;->h:Z

    .line 51
    new-instance v0, Ljava/util/ArrayList;

    invoke-direct {v0}, Ljava/util/ArrayList;-><init>()V

    iput-object v0, p0, Lcom/cyjh/mobileanjian/ipc/d;->i:Ljava/util/List;

    .line 52
    new-instance v0, Ljava/util/Vector;

    invoke-direct {v0}, Ljava/util/Vector;-><init>()V

    iput-object v0, p0, Lcom/cyjh/mobileanjian/ipc/d;->j:Ljava/util/Vector;

    .line 55
    iput-object v2, p0, Lcom/cyjh/mobileanjian/ipc/d;->k:Lcom/cyjh/mobileanjian/ipc/interfaces/OnRecordScriptCallback;

    .line 56
    iput-object v2, p0, Lcom/cyjh/mobileanjian/ipc/d;->l:Lcom/cyjh/mobileanjian/ipc/interfaces/OnScreenShotCallback;

    .line 57
    iput-object v2, p0, Lcom/cyjh/mobileanjian/ipc/d;->m:Lcom/cyjh/mobileanjian/ipc/interfaces/OnUiUpdateCallback;

    .line 58
    iput-object v2, p0, Lcom/cyjh/mobileanjian/ipc/d;->n:Lcom/cyjh/mobileanjian/ipc/interfaces/OnScriptMessageCallback;

    .line 59
    iput-object v2, p0, Lcom/cyjh/mobileanjian/ipc/d;->o:Lcom/cyjh/mobileanjian/ipc/interfaces/BasicScriptListener;

    .line 60
    iput-object v2, p0, Lcom/cyjh/mobileanjian/ipc/d;->p:Lcom/cyjh/mobileanjian/ipc/interfaces/OnScriptListener;

    .line 62
    new-instance v0, Ljava/util/concurrent/ArrayBlockingQueue;

    const/16 v1, 0x400

    invoke-direct {v0, v1}, Ljava/util/concurrent/ArrayBlockingQueue;-><init>(I)V

    iput-object v0, p0, Lcom/cyjh/mobileanjian/ipc/d;->q:Ljava/util/concurrent/ArrayBlockingQueue;

    .line 63
    new-instance v0, Lcom/cyjh/mobileanjian/ipc/d$1;

    const-string v1, "send_thread"

    invoke-direct {v0, p0, v1}, Lcom/cyjh/mobileanjian/ipc/d$1;-><init>(Lcom/cyjh/mobileanjian/ipc/d;Ljava/lang/String;)V

    iput-object v0, p0, Lcom/cyjh/mobileanjian/ipc/d;->r:Ljava/lang/Thread;

    .line 156
    iput-object v2, p0, Lcom/cyjh/mobileanjian/ipc/d;->s:Lcom/cyjh/mobileanjian/ipc/interfaces/OnRpcCallback;

    .line 88
    iput-object p1, p0, Lcom/cyjh/mobileanjian/ipc/d;->f:Landroid/content/Context;

    .line 89
    new-instance v0, Lcom/cyjh/mobileanjian/ipc/g;

    invoke-direct {v0, p1, p0}, Lcom/cyjh/mobileanjian/ipc/g;-><init>(Landroid/content/Context;Lcom/cyjh/mobileanjian/ipc/d;)V

    iput-object v0, p0, Lcom/cyjh/mobileanjian/ipc/d;->e:Lcom/cyjh/mobileanjian/ipc/g;

    .line 90
    return-void
.end method

.method static synthetic a(Lcom/cyjh/mobileanjian/ipc/d;)Z
    .locals 1

    .prologue
    .line 36
    iget-boolean v0, p0, Lcom/cyjh/mobileanjian/ipc/d;->c:Z

    return v0
.end method

.method static synthetic b(Lcom/cyjh/mobileanjian/ipc/d;)Ljava/util/concurrent/ArrayBlockingQueue;
    .locals 1

    .prologue
    .line 36
    iget-object v0, p0, Lcom/cyjh/mobileanjian/ipc/d;->q:Ljava/util/concurrent/ArrayBlockingQueue;

    return-object v0
.end method

.method static synthetic c(Lcom/cyjh/mobileanjian/ipc/d;)Ljava/util/List;
    .locals 1

    .prologue
    .line 36
    iget-object v0, p0, Lcom/cyjh/mobileanjian/ipc/d;->i:Ljava/util/List;

    return-object v0
.end method

.method static synthetic d(Lcom/cyjh/mobileanjian/ipc/d;)Lcom/cyjh/mobileanjian/ipc/interfaces/OnScriptListener;
    .locals 1

    .prologue
    .line 36
    iget-object v0, p0, Lcom/cyjh/mobileanjian/ipc/d;->p:Lcom/cyjh/mobileanjian/ipc/interfaces/OnScriptListener;

    return-object v0
.end method

.method static synthetic e(Lcom/cyjh/mobileanjian/ipc/d;)Landroid/content/Context;
    .locals 1

    .prologue
    .line 36
    iget-object v0, p0, Lcom/cyjh/mobileanjian/ipc/d;->f:Landroid/content/Context;

    return-object v0
.end method

.method private q()I
    .locals 2

    .prologue
    .line 107
    const/4 v0, 0x4

    new-array v0, v0, [B

    .line 108
    invoke-virtual {p0, v0}, Lcom/cyjh/mobileanjian/ipc/d;->b([B)I

    move-result v1

    if-gez v1, :cond_0

    .line 109
    const/4 v0, -0x1

    .line 110
    :goto_0
    return v0

    :cond_0
    invoke-static {v0}, Ljava/nio/ByteBuffer;->wrap([B)Ljava/nio/ByteBuffer;

    move-result-object v0

    invoke-virtual {v0}, Ljava/nio/ByteBuffer;->getInt()I

    move-result v0

    goto :goto_0
.end method

.method private r()Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$IpcMessage;
    .locals 3

    .prologue
    const/4 v0, 0x0

    .line 115
    .line 116
    invoke-direct {p0}, Lcom/cyjh/mobileanjian/ipc/d;->q()I

    move-result v1

    .line 118
    if-gez v1, :cond_0

    .line 120
    invoke-virtual {p0}, Lcom/cyjh/mobileanjian/ipc/d;->a()V

    .line 121
    invoke-virtual {p0}, Lcom/cyjh/mobileanjian/ipc/d;->p()V

    .line 140
    :goto_0
    return-object v0

    .line 125
    :cond_0
    new-array v1, v1, [B

    .line 126
    invoke-virtual {p0, v1}, Lcom/cyjh/mobileanjian/ipc/d;->b([B)I

    move-result v2

    if-gez v2, :cond_1

    .line 128
    invoke-virtual {p0}, Lcom/cyjh/mobileanjian/ipc/d;->a()V

    .line 129
    invoke-virtual {p0}, Lcom/cyjh/mobileanjian/ipc/d;->p()V

    goto :goto_0

    .line 135
    :cond_1
    :try_start_0
    invoke-static {v1}, Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$IpcMessage;->parseFrom([B)Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$IpcMessage;
    :try_end_0
    .catch Lcom/google/protobuf/InvalidProtocolBufferException; {:try_start_0 .. :try_end_0} :catch_0

    move-result-object v0

    goto :goto_0

    .line 136
    :catch_0
    move-exception v1

    .line 138
    invoke-virtual {v1}, Lcom/google/protobuf/InvalidProtocolBufferException;->printStackTrace()V

    goto :goto_0
.end method


# virtual methods
.method protected a()V
    .locals 1

    .prologue
    .line 191
    invoke-super {p0}, Lcom/cyjh/mobileanjian/ipc/b;->a()V

    .line 192
    const/4 v0, 0x0

    iput-boolean v0, p0, Lcom/cyjh/mobileanjian/ipc/d;->c:Z

    .line 193
    const/4 v0, 0x3

    invoke-static {v0}, Lcom/cyjh/mobileanjian/ipc/share/proto/c;->a(I)Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$IpcMessage;

    move-result-object v0

    invoke-virtual {p0, v0}, Lcom/cyjh/mobileanjian/ipc/d;->a(Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$IpcMessage;)V

    .line 194
    return-void
.end method

.method public a(Lcom/cyjh/mobileanjian/ipc/interfaces/BasicScriptListener;)V
    .locals 0

    .prologue
    .line 229
    iput-object p1, p0, Lcom/cyjh/mobileanjian/ipc/d;->o:Lcom/cyjh/mobileanjian/ipc/interfaces/BasicScriptListener;

    .line 230
    return-void
.end method

.method public a(Lcom/cyjh/mobileanjian/ipc/interfaces/OnRecordScriptCallback;)V
    .locals 0

    .prologue
    .line 261
    iput-object p1, p0, Lcom/cyjh/mobileanjian/ipc/d;->k:Lcom/cyjh/mobileanjian/ipc/interfaces/OnRecordScriptCallback;

    .line 262
    return-void
.end method

.method public a(Lcom/cyjh/mobileanjian/ipc/interfaces/OnRpcCallback;)V
    .locals 0

    .prologue
    .line 160
    iput-object p1, p0, Lcom/cyjh/mobileanjian/ipc/d;->s:Lcom/cyjh/mobileanjian/ipc/interfaces/OnRpcCallback;

    .line 161
    return-void
.end method

.method public a(Lcom/cyjh/mobileanjian/ipc/interfaces/OnScreenShotCallback;)V
    .locals 0

    .prologue
    .line 271
    iput-object p1, p0, Lcom/cyjh/mobileanjian/ipc/d;->l:Lcom/cyjh/mobileanjian/ipc/interfaces/OnScreenShotCallback;

    .line 272
    return-void
.end method

.method public a(Lcom/cyjh/mobileanjian/ipc/interfaces/OnScriptListener;)V
    .locals 0

    .prologue
    .line 240
    iput-object p1, p0, Lcom/cyjh/mobileanjian/ipc/d;->p:Lcom/cyjh/mobileanjian/ipc/interfaces/OnScriptListener;

    .line 241
    return-void
.end method

.method public a(Lcom/cyjh/mobileanjian/ipc/interfaces/OnScriptMessageCallback;)V
    .locals 0

    .prologue
    .line 291
    iput-object p1, p0, Lcom/cyjh/mobileanjian/ipc/d;->n:Lcom/cyjh/mobileanjian/ipc/interfaces/OnScriptMessageCallback;

    .line 292
    return-void
.end method

.method public a(Lcom/cyjh/mobileanjian/ipc/interfaces/OnUiUpdateCallback;)V
    .locals 0

    .prologue
    .line 281
    iput-object p1, p0, Lcom/cyjh/mobileanjian/ipc/d;->m:Lcom/cyjh/mobileanjian/ipc/interfaces/OnUiUpdateCallback;

    .line 282
    return-void
.end method

.method public a(Lcom/cyjh/mobileanjian/ipc/interfaces/ScriptStateObserver;)V
    .locals 1

    .prologue
    .line 218
    iget-object v0, p0, Lcom/cyjh/mobileanjian/ipc/d;->j:Ljava/util/Vector;

    invoke-virtual {v0, p1}, Ljava/util/Vector;->add(Ljava/lang/Object;)Z

    .line 219
    return-void
.end method

.method public declared-synchronized a(Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$IpcMessage;)V
    .locals 1

    .prologue
    .line 150
    monitor-enter p0

    :try_start_0
    iget-object v0, p0, Lcom/cyjh/mobileanjian/ipc/d;->q:Ljava/util/concurrent/ArrayBlockingQueue;

    invoke-virtual {v0, p1}, Ljava/util/concurrent/ArrayBlockingQueue;->add(Ljava/lang/Object;)Z
    :try_end_0
    .catchall {:try_start_0 .. :try_end_0} :catchall_0

    .line 154
    monitor-exit p0

    return-void

    .line 150
    :catchall_0
    move-exception v0

    monitor-exit p0

    throw v0
.end method

.method public a(Ljava/util/List;)V
    .locals 0
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "(",
            "Ljava/util/List",
            "<",
            "Lcom/cyjh/mobileanjian/ipc/interfaces/EngineStateObserver;",
            ">;)V"
        }
    .end annotation

    .prologue
    .line 301
    iput-object p1, p0, Lcom/cyjh/mobileanjian/ipc/d;->i:Ljava/util/List;

    .line 302
    return-void
.end method

.method public a(Z)V
    .locals 0

    .prologue
    .line 198
    iput-boolean p1, p0, Lcom/cyjh/mobileanjian/ipc/d;->h:Z

    .line 199
    return-void
.end method

.method public b(Z)V
    .locals 0

    .prologue
    .line 208
    iput-boolean p1, p0, Lcom/cyjh/mobileanjian/ipc/d;->g:Z

    .line 209
    return-void
.end method

.method public b()Z
    .locals 1

    .prologue
    .line 101
    iget-boolean v0, p0, Lcom/cyjh/mobileanjian/ipc/d;->d:Z

    return v0
.end method

.method public c()Lcom/cyjh/mobileanjian/ipc/interfaces/OnRpcCallback;
    .locals 1

    .prologue
    .line 165
    iget-object v0, p0, Lcom/cyjh/mobileanjian/ipc/d;->s:Lcom/cyjh/mobileanjian/ipc/interfaces/OnRpcCallback;

    return-object v0
.end method

.method public d()V
    .locals 2

    .prologue
    .line 173
    const-string v0, "loop start"

    invoke-static {v0}, Lcom/cyjh/mobileanjian/ipc/utils/CLog;->i(Ljava/lang/String;)V

    .line 174
    const/4 v0, 0x1

    iput-boolean v0, p0, Lcom/cyjh/mobileanjian/ipc/d;->d:Z

    .line 175
    iget-object v0, p0, Lcom/cyjh/mobileanjian/ipc/d;->r:Ljava/lang/Thread;

    invoke-virtual {v0}, Ljava/lang/Thread;->start()V

    .line 176
    :goto_0
    iget-boolean v0, p0, Lcom/cyjh/mobileanjian/ipc/d;->c:Z

    if-eqz v0, :cond_0

    .line 178
    invoke-direct {p0}, Lcom/cyjh/mobileanjian/ipc/d;->r()Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$IpcMessage;

    move-result-object v0

    .line 179
    iget-object v1, p0, Lcom/cyjh/mobileanjian/ipc/d;->e:Lcom/cyjh/mobileanjian/ipc/g;

    invoke-virtual {v1, v0}, Lcom/cyjh/mobileanjian/ipc/g;->a(Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$IpcMessage;)V

    goto :goto_0

    .line 181
    :cond_0
    const/4 v0, 0x0

    iput-boolean v0, p0, Lcom/cyjh/mobileanjian/ipc/d;->d:Z

    .line 182
    const-string v0, "loop end"

    invoke-static {v0}, Lcom/cyjh/mobileanjian/ipc/utils/CLog;->i(Ljava/lang/String;)V

    .line 183
    return-void
.end method

.method public e()Z
    .locals 1

    .prologue
    .line 203
    iget-boolean v0, p0, Lcom/cyjh/mobileanjian/ipc/d;->h:Z

    return v0
.end method

.method public f()Z
    .locals 1

    .prologue
    .line 213
    iget-boolean v0, p0, Lcom/cyjh/mobileanjian/ipc/d;->g:Z

    return v0
.end method

.method public g()Ljava/util/Vector;
    .locals 1
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "()",
            "Ljava/util/Vector",
            "<",
            "Lcom/cyjh/mobileanjian/ipc/interfaces/ScriptStateObserver;",
            ">;"
        }
    .end annotation

    .prologue
    .line 223
    iget-object v0, p0, Lcom/cyjh/mobileanjian/ipc/d;->j:Ljava/util/Vector;

    return-object v0
.end method

.method public h()Lcom/cyjh/mobileanjian/ipc/interfaces/BasicScriptListener;
    .locals 1

    .prologue
    .line 235
    iget-object v0, p0, Lcom/cyjh/mobileanjian/ipc/d;->o:Lcom/cyjh/mobileanjian/ipc/interfaces/BasicScriptListener;

    return-object v0
.end method

.method public i()Lcom/cyjh/mobileanjian/ipc/interfaces/OnScriptListener;
    .locals 1

    .prologue
    .line 245
    iget-object v0, p0, Lcom/cyjh/mobileanjian/ipc/d;->p:Lcom/cyjh/mobileanjian/ipc/interfaces/OnScriptListener;

    return-object v0
.end method

.method public j()Lcom/cyjh/mobileanjian/ipc/interfaces/OnRecordScriptCallback;
    .locals 1

    .prologue
    .line 266
    iget-object v0, p0, Lcom/cyjh/mobileanjian/ipc/d;->k:Lcom/cyjh/mobileanjian/ipc/interfaces/OnRecordScriptCallback;

    return-object v0
.end method

.method public k()Lcom/cyjh/mobileanjian/ipc/interfaces/OnScreenShotCallback;
    .locals 1

    .prologue
    .line 276
    iget-object v0, p0, Lcom/cyjh/mobileanjian/ipc/d;->l:Lcom/cyjh/mobileanjian/ipc/interfaces/OnScreenShotCallback;

    return-object v0
.end method

.method public l()Lcom/cyjh/mobileanjian/ipc/interfaces/OnUiUpdateCallback;
    .locals 1

    .prologue
    .line 286
    iget-object v0, p0, Lcom/cyjh/mobileanjian/ipc/d;->m:Lcom/cyjh/mobileanjian/ipc/interfaces/OnUiUpdateCallback;

    return-object v0
.end method

.method public m()Lcom/cyjh/mobileanjian/ipc/interfaces/OnScriptMessageCallback;
    .locals 1

    .prologue
    .line 296
    iget-object v0, p0, Lcom/cyjh/mobileanjian/ipc/d;->n:Lcom/cyjh/mobileanjian/ipc/interfaces/OnScriptMessageCallback;

    return-object v0
.end method

.method public n()V
    .locals 1

    .prologue
    .line 306
    new-instance v0, Lcom/cyjh/mobileanjian/ipc/d$2;

    invoke-direct {v0, p0}, Lcom/cyjh/mobileanjian/ipc/d$2;-><init>(Lcom/cyjh/mobileanjian/ipc/d;)V

    .line 319
    invoke-virtual {v0}, Lcom/cyjh/mobileanjian/ipc/d$2;->start()V

    .line 320
    return-void
.end method

.method public o()V
    .locals 2

    .prologue
    .line 324
    iget-object v0, p0, Lcom/cyjh/mobileanjian/ipc/d;->i:Ljava/util/List;

    invoke-interface {v0}, Ljava/util/List;->iterator()Ljava/util/Iterator;

    move-result-object v1

    :goto_0
    invoke-interface {v1}, Ljava/util/Iterator;->hasNext()Z

    move-result v0

    if-eqz v0, :cond_0

    invoke-interface {v1}, Ljava/util/Iterator;->next()Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Lcom/cyjh/mobileanjian/ipc/interfaces/EngineStateObserver;

    .line 326
    invoke-interface {v0}, Lcom/cyjh/mobileanjian/ipc/interfaces/EngineStateObserver;->onExit()V

    goto :goto_0

    .line 328
    :cond_0
    return-void
.end method

.method public p()V
    .locals 4

    .prologue
    const/16 v3, 0x3ea

    .line 332
    new-instance v1, Lcom/cyjh/mobileanjian/ipc/c;

    invoke-direct {v1}, Lcom/cyjh/mobileanjian/ipc/c;-><init>()V

    .line 333
    invoke-static {}, Lcom/cyjh/mobileanjian/ipc/MqRunner;->getInstance()Lcom/cyjh/mobileanjian/ipc/MqRunner;

    move-result-object v0

    invoke-virtual {v0}, Lcom/cyjh/mobileanjian/ipc/MqRunner;->isScriptStarted()Z

    move-result v0

    invoke-virtual {v1, v0}, Lcom/cyjh/mobileanjian/ipc/c;->a(Z)Lcom/cyjh/mobileanjian/ipc/c;

    .line 335
    invoke-static {}, Lcom/cyjh/mobileanjian/ipc/MqRunner;->getInstance()Lcom/cyjh/mobileanjian/ipc/MqRunner;

    move-result-object v0

    invoke-virtual {v0}, Lcom/cyjh/mobileanjian/ipc/MqRunner;->isScriptStarted()Z

    move-result v0

    if-eqz v0, :cond_1

    .line 338
    iget-object v0, p0, Lcom/cyjh/mobileanjian/ipc/d;->o:Lcom/cyjh/mobileanjian/ipc/interfaces/BasicScriptListener;

    if-eqz v0, :cond_0

    .line 340
    iget-object v0, p0, Lcom/cyjh/mobileanjian/ipc/d;->o:Lcom/cyjh/mobileanjian/ipc/interfaces/BasicScriptListener;

    const-string v2, "root\u8fdb\u7a0b\u5f02\u5e38\u7ec8\u6b62"

    invoke-interface {v0, v3, v2}, Lcom/cyjh/mobileanjian/ipc/interfaces/BasicScriptListener;->onStopScript(ILjava/lang/String;)V

    .line 343
    :cond_0
    new-instance v0, Landroid/os/Handler;

    invoke-static {}, Landroid/os/Looper;->getMainLooper()Landroid/os/Looper;

    move-result-object v2

    invoke-direct {v0, v2}, Landroid/os/Handler;-><init>(Landroid/os/Looper;)V

    new-instance v2, Lcom/cyjh/mobileanjian/ipc/d$3;

    invoke-direct {v2, p0}, Lcom/cyjh/mobileanjian/ipc/d$3;-><init>(Lcom/cyjh/mobileanjian/ipc/d;)V

    invoke-virtual {v0, v2}, Landroid/os/Handler;->post(Ljava/lang/Runnable;)Z

    .line 356
    :cond_1
    invoke-virtual {p0}, Lcom/cyjh/mobileanjian/ipc/d;->f()Z

    move-result v0

    if-eqz v0, :cond_2

    iget-object v0, p0, Lcom/cyjh/mobileanjian/ipc/d;->l:Lcom/cyjh/mobileanjian/ipc/interfaces/OnScreenShotCallback;

    if-eqz v0, :cond_2

    .line 358
    const/4 v0, 0x0

    invoke-virtual {p0, v0}, Lcom/cyjh/mobileanjian/ipc/d;->b(Z)V

    .line 359
    iget-object v0, p0, Lcom/cyjh/mobileanjian/ipc/d;->l:Lcom/cyjh/mobileanjian/ipc/interfaces/OnScreenShotCallback;

    invoke-interface {v0, v3}, Lcom/cyjh/mobileanjian/ipc/interfaces/OnScreenShotCallback;->onScreenShotFailed(I)V

    .line 362
    :cond_2
    iget-object v0, p0, Lcom/cyjh/mobileanjian/ipc/d;->i:Ljava/util/List;

    invoke-interface {v0}, Ljava/util/List;->iterator()Ljava/util/Iterator;

    move-result-object v2

    :goto_0
    invoke-interface {v2}, Ljava/util/Iterator;->hasNext()Z

    move-result v0

    if-eqz v0, :cond_3

    invoke-interface {v2}, Ljava/util/Iterator;->next()Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Lcom/cyjh/mobileanjian/ipc/interfaces/EngineStateObserver;

    .line 364
    invoke-interface {v0, v1}, Lcom/cyjh/mobileanjian/ipc/interfaces/EngineStateObserver;->onCrash(Lcom/cyjh/mobileanjian/ipc/c;)V

    goto :goto_0

    .line 366
    :cond_3
    return-void
.end method
