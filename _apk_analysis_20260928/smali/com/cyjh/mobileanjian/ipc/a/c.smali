.class public Lcom/cyjh/mobileanjian/ipc/a/c;
.super Ljava/lang/Object;
.source "SourceFile"


# annotations
.annotation system Ldalvik/annotation/MemberClasses;
    value = {
        Lcom/cyjh/mobileanjian/ipc/a/c$a;,
        Lcom/cyjh/mobileanjian/ipc/a/c$b;
    }
.end annotation


# static fields
.field private static final a:Ljava/lang/Class;


# instance fields
.field private b:Lcom/cyjh/mobileanjian/ipc/engine/utils/d;

.field private c:Z

.field private d:Ljava/lang/Boolean;

.field private e:Ljava/util/Timer;

.field private f:Lcom/cyjh/mobileanjian/ipc/a/c$a;

.field private g:Lcom/cyjh/mqm/MQLanguageStub;


# direct methods
.method static constructor <clinit>()V
    .locals 1

    .prologue
    .line 28
    const-class v0, Lcom/cyjh/mobileanjian/ipc/a/c;

    sput-object v0, Lcom/cyjh/mobileanjian/ipc/a/c;->a:Ljava/lang/Class;

    return-void
.end method

.method public constructor <init>()V
    .locals 2

    .prologue
    const/4 v1, 0x0

    .line 26
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    .line 29
    iput-object v1, p0, Lcom/cyjh/mobileanjian/ipc/a/c;->b:Lcom/cyjh/mobileanjian/ipc/engine/utils/d;

    .line 30
    const/4 v0, 0x0

    iput-boolean v0, p0, Lcom/cyjh/mobileanjian/ipc/a/c;->c:Z

    .line 32
    const/4 v0, 0x1

    invoke-static {v0}, Ljava/lang/Boolean;->valueOf(Z)Ljava/lang/Boolean;

    move-result-object v0

    iput-object v0, p0, Lcom/cyjh/mobileanjian/ipc/a/c;->d:Ljava/lang/Boolean;

    .line 33
    new-instance v0, Ljava/util/Timer;

    invoke-direct {v0}, Ljava/util/Timer;-><init>()V

    iput-object v0, p0, Lcom/cyjh/mobileanjian/ipc/a/c;->e:Ljava/util/Timer;

    .line 162
    iput-object v1, p0, Lcom/cyjh/mobileanjian/ipc/a/c;->g:Lcom/cyjh/mqm/MQLanguageStub;

    return-void
.end method

.method static synthetic a(Lcom/cyjh/mobileanjian/ipc/a/c;Lcom/cyjh/mobileanjian/ipc/a/c$a;)Lcom/cyjh/mobileanjian/ipc/a/c$a;
    .locals 0

    .prologue
    .line 26
    iput-object p1, p0, Lcom/cyjh/mobileanjian/ipc/a/c;->f:Lcom/cyjh/mobileanjian/ipc/a/c$a;

    return-object p1
.end method

.method static synthetic a(Lcom/cyjh/mobileanjian/ipc/a/c;)Lcom/cyjh/mobileanjian/ipc/engine/utils/d;
    .locals 1

    .prologue
    .line 26
    iget-object v0, p0, Lcom/cyjh/mobileanjian/ipc/a/c;->b:Lcom/cyjh/mobileanjian/ipc/engine/utils/d;

    return-object v0
.end method

.method static synthetic a(Lcom/cyjh/mobileanjian/ipc/a/c;Ljava/lang/Boolean;)Ljava/lang/Boolean;
    .locals 0

    .prologue
    .line 26
    iput-object p1, p0, Lcom/cyjh/mobileanjian/ipc/a/c;->d:Ljava/lang/Boolean;

    return-object p1
.end method

.method static synthetic a(Lcom/cyjh/mobileanjian/ipc/a/c;Z)Z
    .locals 0

    .prologue
    .line 26
    iput-boolean p1, p0, Lcom/cyjh/mobileanjian/ipc/a/c;->c:Z

    return p1
.end method

.method static synthetic b(Lcom/cyjh/mobileanjian/ipc/a/c;)Lcom/cyjh/mobileanjian/ipc/a/c$a;
    .locals 1

    .prologue
    .line 26
    iget-object v0, p0, Lcom/cyjh/mobileanjian/ipc/a/c;->f:Lcom/cyjh/mobileanjian/ipc/a/c$a;

    return-object v0
.end method

.method static synthetic c(Lcom/cyjh/mobileanjian/ipc/a/c;)Ljava/util/Timer;
    .locals 1

    .prologue
    .line 26
    iget-object v0, p0, Lcom/cyjh/mobileanjian/ipc/a/c;->e:Ljava/util/Timer;

    return-object v0
.end method

.method static synthetic d(Lcom/cyjh/mobileanjian/ipc/a/c;)Ljava/lang/Boolean;
    .locals 1

    .prologue
    .line 26
    iget-object v0, p0, Lcom/cyjh/mobileanjian/ipc/a/c;->d:Ljava/lang/Boolean;

    return-object v0
.end method

.method static synthetic e()Ljava/lang/Class;
    .locals 1

    .prologue
    .line 26
    sget-object v0, Lcom/cyjh/mobileanjian/ipc/a/c;->a:Ljava/lang/Class;

    return-object v0
.end method


# virtual methods
.method public a()V
    .locals 1

    .prologue
    .line 69
    invoke-virtual {p0}, Lcom/cyjh/mobileanjian/ipc/a/c;->d()Lcom/cyjh/mqm/MQLanguageStub;

    move-result-object v0

    invoke-virtual {v0}, Lcom/cyjh/mqm/MQLanguageStub;->Pause()I

    .line 70
    return-void
.end method

.method public a(Lcom/cyjh/mobileanjian/ipc/engine/utils/d;)V
    .locals 0

    .prologue
    .line 43
    iput-object p1, p0, Lcom/cyjh/mobileanjian/ipc/a/c;->b:Lcom/cyjh/mobileanjian/ipc/engine/utils/d;

    .line 44
    return-void
.end method

.method public a(Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;)V
    .locals 1

    .prologue
    .line 48
    iget-object v0, p0, Lcom/cyjh/mobileanjian/ipc/a/c;->b:Lcom/cyjh/mobileanjian/ipc/engine/utils/d;

    iput-object p1, v0, Lcom/cyjh/mobileanjian/ipc/engine/utils/d;->h:Ljava/lang/String;

    .line 49
    iget-object v0, p0, Lcom/cyjh/mobileanjian/ipc/a/c;->b:Lcom/cyjh/mobileanjian/ipc/engine/utils/d;

    iput-object p2, v0, Lcom/cyjh/mobileanjian/ipc/engine/utils/d;->i:Ljava/lang/String;

    .line 50
    iget-object v0, p0, Lcom/cyjh/mobileanjian/ipc/a/c;->b:Lcom/cyjh/mobileanjian/ipc/engine/utils/d;

    iput-object p3, v0, Lcom/cyjh/mobileanjian/ipc/engine/utils/d;->j:Ljava/lang/String;

    .line 51
    return-void
.end method

.method public a(Z)V
    .locals 2

    .prologue
    .line 58
    iget-boolean v0, p0, Lcom/cyjh/mobileanjian/ipc/a/c;->c:Z

    if-eqz v0, :cond_0

    .line 59
    invoke-static {}, Lcom/cyjh/mobileanjian/ipc/ClientService;->a()Lcom/cyjh/mobileanjian/ipc/b/b;

    move-result-object v0

    const/4 v1, 0x5

    invoke-static {v1}, Lcom/cyjh/mobileanjian/ipc/share/proto/c;->a(I)Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$IpcMessage;

    move-result-object v1

    invoke-virtual {v0, v1}, Lcom/cyjh/mobileanjian/ipc/b/b;->a(Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$IpcMessage;)V

    .line 62
    :goto_0
    return-void

    .line 61
    :cond_0
    new-instance v0, Lcom/cyjh/mobileanjian/ipc/a/c$b;

    const/4 v1, 0x0

    invoke-direct {v0, p0, v1}, Lcom/cyjh/mobileanjian/ipc/a/c$b;-><init>(Lcom/cyjh/mobileanjian/ipc/a/c;Lcom/cyjh/mobileanjian/ipc/a/c$1;)V

    invoke-virtual {v0}, Lcom/cyjh/mobileanjian/ipc/a/c$b;->start()V

    goto :goto_0
.end method

.method public b()V
    .locals 1

    .prologue
    .line 72
    invoke-virtual {p0}, Lcom/cyjh/mobileanjian/ipc/a/c;->d()Lcom/cyjh/mqm/MQLanguageStub;

    move-result-object v0

    invoke-virtual {v0}, Lcom/cyjh/mqm/MQLanguageStub;->Resume()I

    return-void
.end method

.method public c()V
    .locals 2

    .prologue
    .line 79
    iget-object v0, p0, Lcom/cyjh/mobileanjian/ipc/a/c;->d:Ljava/lang/Boolean;

    invoke-virtual {v0}, Ljava/lang/Boolean;->booleanValue()Z

    move-result v0

    if-nez v0, :cond_0

    .line 81
    iget-object v0, p0, Lcom/cyjh/mobileanjian/ipc/a/c;->f:Lcom/cyjh/mobileanjian/ipc/a/c$a;

    invoke-virtual {v0}, Lcom/cyjh/mobileanjian/ipc/a/c$a;->cancel()Z

    .line 82
    iget-object v0, p0, Lcom/cyjh/mobileanjian/ipc/a/c;->f:Lcom/cyjh/mobileanjian/ipc/a/c$a;

    invoke-virtual {v0}, Lcom/cyjh/mobileanjian/ipc/a/c$a;->run()V

    .line 84
    :cond_0
    invoke-virtual {p0}, Lcom/cyjh/mobileanjian/ipc/a/c;->d()Lcom/cyjh/mqm/MQLanguageStub;

    move-result-object v0

    invoke-virtual {v0}, Lcom/cyjh/mqm/MQLanguageStub;->Stop()I

    .line 85
    const-string v0, "==> Call ScriptRunner.stop()"

    sget-object v1, Lcom/cyjh/mobileanjian/ipc/a/c;->a:Ljava/lang/Class;

    invoke-static {v0, v1}, Lcom/cyjh/mobileanjian/ipc/engine/utils/CLog;->d(Ljava/lang/String;Ljava/lang/Class;)V

    .line 86
    return-void
.end method

.method public d()Lcom/cyjh/mqm/MQLanguageStub;
    .locals 1

    .prologue
    .line 166
    iget-object v0, p0, Lcom/cyjh/mobileanjian/ipc/a/c;->g:Lcom/cyjh/mqm/MQLanguageStub;

    if-nez v0, :cond_0

    .line 167
    new-instance v0, Lcom/cyjh/mqm/MQLanguageStub;

    invoke-direct {v0}, Lcom/cyjh/mqm/MQLanguageStub;-><init>()V

    iput-object v0, p0, Lcom/cyjh/mobileanjian/ipc/a/c;->g:Lcom/cyjh/mqm/MQLanguageStub;

    .line 168
    :cond_0
    iget-object v0, p0, Lcom/cyjh/mobileanjian/ipc/a/c;->g:Lcom/cyjh/mqm/MQLanguageStub;

    return-object v0
.end method
