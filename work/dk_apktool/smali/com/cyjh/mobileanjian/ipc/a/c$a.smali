.class Lcom/cyjh/mobileanjian/ipc/a/c$a;
.super Ljava/util/TimerTask;
.source "SourceFile"


# annotations
.annotation system Ldalvik/annotation/EnclosingClass;
    value = Lcom/cyjh/mobileanjian/ipc/a/c;
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x2
    name = "a"
.end annotation


# instance fields
.field final synthetic a:Lcom/cyjh/mobileanjian/ipc/a/c;


# direct methods
.method public constructor <init>(Lcom/cyjh/mobileanjian/ipc/a/c;)V
    .locals 1

    .prologue
    .line 147
    iput-object p1, p0, Lcom/cyjh/mobileanjian/ipc/a/c$a;->a:Lcom/cyjh/mobileanjian/ipc/a/c;

    invoke-direct {p0}, Ljava/util/TimerTask;-><init>()V

    .line 148
    const/4 v0, 0x0

    invoke-static {v0}, Ljava/lang/Boolean;->valueOf(Z)Ljava/lang/Boolean;

    move-result-object v0

    invoke-static {p1, v0}, Lcom/cyjh/mobileanjian/ipc/a/c;->a(Lcom/cyjh/mobileanjian/ipc/a/c;Ljava/lang/Boolean;)Ljava/lang/Boolean;

    .line 149
    return-void
.end method


# virtual methods
.method public run()V
    .locals 3

    .prologue
    .line 153
    iget-object v0, p0, Lcom/cyjh/mobileanjian/ipc/a/c$a;->a:Lcom/cyjh/mobileanjian/ipc/a/c;

    invoke-static {v0}, Lcom/cyjh/mobileanjian/ipc/a/c;->d(Lcom/cyjh/mobileanjian/ipc/a/c;)Ljava/lang/Boolean;

    move-result-object v1

    monitor-enter v1

    .line 155
    :try_start_0
    iget-object v0, p0, Lcom/cyjh/mobileanjian/ipc/a/c$a;->a:Lcom/cyjh/mobileanjian/ipc/a/c;

    const/4 v2, 0x1

    invoke-static {v2}, Ljava/lang/Boolean;->valueOf(Z)Ljava/lang/Boolean;

    move-result-object v2

    invoke-static {v0, v2}, Lcom/cyjh/mobileanjian/ipc/a/c;->a(Lcom/cyjh/mobileanjian/ipc/a/c;Ljava/lang/Boolean;)Ljava/lang/Boolean;

    .line 156
    monitor-exit v1
    :try_end_0
    .catchall {:try_start_0 .. :try_end_0} :catchall_0

    .line 157
    iget-object v0, p0, Lcom/cyjh/mobileanjian/ipc/a/c$a;->a:Lcom/cyjh/mobileanjian/ipc/a/c;

    invoke-virtual {v0}, Lcom/cyjh/mobileanjian/ipc/a/c;->d()Lcom/cyjh/mqm/MQLanguageStub;

    move-result-object v0

    invoke-virtual {v0}, Lcom/cyjh/mqm/MQLanguageStub;->Stop()I

    .line 158
    return-void

    .line 156
    :catchall_0
    move-exception v0

    :try_start_1
    monitor-exit v1
    :try_end_1
    .catchall {:try_start_1 .. :try_end_1} :catchall_0

    throw v0
.end method
