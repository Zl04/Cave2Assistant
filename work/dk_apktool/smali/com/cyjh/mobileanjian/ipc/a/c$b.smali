.class Lcom/cyjh/mobileanjian/ipc/a/c$b;
.super Ljava/lang/Thread;
.source "SourceFile"


# annotations
.annotation system Ldalvik/annotation/EnclosingClass;
    value = Lcom/cyjh/mobileanjian/ipc/a/c;
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x2
    name = "b"
.end annotation


# instance fields
.field final synthetic a:Lcom/cyjh/mobileanjian/ipc/a/c;


# direct methods
.method private constructor <init>(Lcom/cyjh/mobileanjian/ipc/a/c;)V
    .locals 0

    .prologue
    .line 88
    iput-object p1, p0, Lcom/cyjh/mobileanjian/ipc/a/c$b;->a:Lcom/cyjh/mobileanjian/ipc/a/c;

    invoke-direct {p0}, Ljava/lang/Thread;-><init>()V

    return-void
.end method

.method synthetic constructor <init>(Lcom/cyjh/mobileanjian/ipc/a/c;Lcom/cyjh/mobileanjian/ipc/a/c$1;)V
    .locals 0

    .prologue
    .line 88
    invoke-direct {p0, p1}, Lcom/cyjh/mobileanjian/ipc/a/c$b;-><init>(Lcom/cyjh/mobileanjian/ipc/a/c;)V

    return-void
.end method


# virtual methods
.method public run()V
    .locals 9

    .prologue
    const/4 v8, 0x0

    .line 93
    iget-object v0, p0, Lcom/cyjh/mobileanjian/ipc/a/c$b;->a:Lcom/cyjh/mobileanjian/ipc/a/c;

    invoke-static {v0}, Lcom/cyjh/mobileanjian/ipc/a/c;->a(Lcom/cyjh/mobileanjian/ipc/a/c;)Lcom/cyjh/mobileanjian/ipc/engine/utils/d;

    move-result-object v0

    if-nez v0, :cond_0

    .line 136
    :goto_0
    return-void

    .line 95
    :cond_0
    const-string v0, "setenforce 0"

    invoke-static {}, Lcom/cyjh/mobileanjian/ipc/a/a;->s()Z

    move-result v1

    invoke-static {v0, v1, v8}, Lcom/cyjh/mobileanjian/ipc/engine/utils/f;->a(Ljava/lang/String;ZI)Lcom/cyjh/mobileanjian/ipc/engine/utils/f$a;

    .line 97
    invoke-static {}, Landroid/os/Looper;->prepare()V

    .line 98
    iget-object v0, p0, Lcom/cyjh/mobileanjian/ipc/a/c$b;->a:Lcom/cyjh/mobileanjian/ipc/a/c;

    const/4 v1, 0x1

    invoke-static {v0, v1}, Lcom/cyjh/mobileanjian/ipc/a/c;->a(Lcom/cyjh/mobileanjian/ipc/a/c;Z)Z

    .line 99
    const-string v0, "Call Stub.Run() --> run script start"

    invoke-static {}, Lcom/cyjh/mobileanjian/ipc/a/c;->e()Ljava/lang/Class;

    move-result-object v1

    invoke-static {v0, v1}, Lcom/cyjh/mobileanjian/ipc/engine/utils/CLog;->i(Ljava/lang/String;Ljava/lang/Class;)V

    .line 100
    iget-object v0, p0, Lcom/cyjh/mobileanjian/ipc/a/c$b;->a:Lcom/cyjh/mobileanjian/ipc/a/c;

    invoke-static {v0}, Lcom/cyjh/mobileanjian/ipc/a/c;->a(Lcom/cyjh/mobileanjian/ipc/a/c;)Lcom/cyjh/mobileanjian/ipc/engine/utils/d;

    move-result-object v0

    invoke-virtual {v0}, Lcom/cyjh/mobileanjian/ipc/engine/utils/d;->toString()Ljava/lang/String;

    move-result-object v0

    invoke-static {}, Lcom/cyjh/mobileanjian/ipc/a/c;->e()Ljava/lang/Class;

    move-result-object v1

    invoke-static {v0, v1}, Lcom/cyjh/mobileanjian/ipc/engine/utils/CLog;->i(Ljava/lang/String;Ljava/lang/Class;)V

    .line 101
    invoke-static {}, Lcom/cyjh/mobileanjian/ipc/ClientService;->a()Lcom/cyjh/mobileanjian/ipc/b/b;

    move-result-object v0

    const/4 v1, 0x4

    invoke-static {v1}, Lcom/cyjh/mobileanjian/ipc/share/proto/c;->a(I)Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$IpcMessage;

    move-result-object v1

    invoke-virtual {v0, v1}, Lcom/cyjh/mobileanjian/ipc/b/b;->a(Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$IpcMessage;)V

    .line 103
    iget-object v0, p0, Lcom/cyjh/mobileanjian/ipc/a/c$b;->a:Lcom/cyjh/mobileanjian/ipc/a/c;

    invoke-static {v0}, Lcom/cyjh/mobileanjian/ipc/a/c;->a(Lcom/cyjh/mobileanjian/ipc/a/c;)Lcom/cyjh/mobileanjian/ipc/engine/utils/d;

    move-result-object v0

    iget v0, v0, Lcom/cyjh/mobileanjian/ipc/engine/utils/d;->l:I

    if-lez v0, :cond_1

    .line 105
    iget-object v0, p0, Lcom/cyjh/mobileanjian/ipc/a/c$b;->a:Lcom/cyjh/mobileanjian/ipc/a/c;

    new-instance v1, Lcom/cyjh/mobileanjian/ipc/a/c$a;

    iget-object v2, p0, Lcom/cyjh/mobileanjian/ipc/a/c$b;->a:Lcom/cyjh/mobileanjian/ipc/a/c;

    invoke-direct {v1, v2}, Lcom/cyjh/mobileanjian/ipc/a/c$a;-><init>(Lcom/cyjh/mobileanjian/ipc/a/c;)V

    invoke-static {v0, v1}, Lcom/cyjh/mobileanjian/ipc/a/c;->a(Lcom/cyjh/mobileanjian/ipc/a/c;Lcom/cyjh/mobileanjian/ipc/a/c$a;)Lcom/cyjh/mobileanjian/ipc/a/c$a;

    .line 106
    iget-object v0, p0, Lcom/cyjh/mobileanjian/ipc/a/c$b;->a:Lcom/cyjh/mobileanjian/ipc/a/c;

    invoke-static {v0}, Lcom/cyjh/mobileanjian/ipc/a/c;->c(Lcom/cyjh/mobileanjian/ipc/a/c;)Ljava/util/Timer;

    move-result-object v0

    iget-object v1, p0, Lcom/cyjh/mobileanjian/ipc/a/c$b;->a:Lcom/cyjh/mobileanjian/ipc/a/c;

    invoke-static {v1}, Lcom/cyjh/mobileanjian/ipc/a/c;->b(Lcom/cyjh/mobileanjian/ipc/a/c;)Lcom/cyjh/mobileanjian/ipc/a/c$a;

    move-result-object v1

    iget-object v2, p0, Lcom/cyjh/mobileanjian/ipc/a/c$b;->a:Lcom/cyjh/mobileanjian/ipc/a/c;

    invoke-static {v2}, Lcom/cyjh/mobileanjian/ipc/a/c;->a(Lcom/cyjh/mobileanjian/ipc/a/c;)Lcom/cyjh/mobileanjian/ipc/engine/utils/d;

    move-result-object v2

    iget v2, v2, Lcom/cyjh/mobileanjian/ipc/engine/utils/d;->l:I

    mul-int/lit8 v2, v2, 0x3c

    mul-int/lit16 v2, v2, 0x3e8

    int-to-long v2, v2

    invoke-virtual {v0, v1, v2, v3}, Ljava/util/Timer;->schedule(Ljava/util/TimerTask;J)V

    .line 109
    :cond_1
    iget-object v0, p0, Lcom/cyjh/mobileanjian/ipc/a/c$b;->a:Lcom/cyjh/mobileanjian/ipc/a/c;

    invoke-virtual {v0}, Lcom/cyjh/mobileanjian/ipc/a/c;->d()Lcom/cyjh/mqm/MQLanguageStub;

    move-result-object v0

    iget-object v1, p0, Lcom/cyjh/mobileanjian/ipc/a/c$b;->a:Lcom/cyjh/mobileanjian/ipc/a/c;

    invoke-static {v1}, Lcom/cyjh/mobileanjian/ipc/a/c;->a(Lcom/cyjh/mobileanjian/ipc/a/c;)Lcom/cyjh/mobileanjian/ipc/engine/utils/d;

    move-result-object v1

    iget-object v1, v1, Lcom/cyjh/mobileanjian/ipc/engine/utils/d;->b:Ljava/lang/String;

    iget-object v2, p0, Lcom/cyjh/mobileanjian/ipc/a/c$b;->a:Lcom/cyjh/mobileanjian/ipc/a/c;

    invoke-static {v2}, Lcom/cyjh/mobileanjian/ipc/a/c;->a(Lcom/cyjh/mobileanjian/ipc/a/c;)Lcom/cyjh/mobileanjian/ipc/engine/utils/d;

    move-result-object v2

    iget-object v2, v2, Lcom/cyjh/mobileanjian/ipc/engine/utils/d;->d:Ljava/lang/String;

    iget-object v3, p0, Lcom/cyjh/mobileanjian/ipc/a/c$b;->a:Lcom/cyjh/mobileanjian/ipc/a/c;

    invoke-static {v3}, Lcom/cyjh/mobileanjian/ipc/a/c;->a(Lcom/cyjh/mobileanjian/ipc/a/c;)Lcom/cyjh/mobileanjian/ipc/engine/utils/d;

    move-result-object v3

    iget-object v3, v3, Lcom/cyjh/mobileanjian/ipc/engine/utils/d;->e:Ljava/lang/String;

    iget-object v4, p0, Lcom/cyjh/mobileanjian/ipc/a/c$b;->a:Lcom/cyjh/mobileanjian/ipc/a/c;

    .line 110
    invoke-static {v4}, Lcom/cyjh/mobileanjian/ipc/a/c;->a(Lcom/cyjh/mobileanjian/ipc/a/c;)Lcom/cyjh/mobileanjian/ipc/engine/utils/d;

    move-result-object v4

    iget v4, v4, Lcom/cyjh/mobileanjian/ipc/engine/utils/d;->k:I

    iget-object v5, p0, Lcom/cyjh/mobileanjian/ipc/a/c$b;->a:Lcom/cyjh/mobileanjian/ipc/a/c;

    invoke-static {v5}, Lcom/cyjh/mobileanjian/ipc/a/c;->a(Lcom/cyjh/mobileanjian/ipc/a/c;)Lcom/cyjh/mobileanjian/ipc/engine/utils/d;

    move-result-object v5

    iget v5, v5, Lcom/cyjh/mobileanjian/ipc/engine/utils/d;->m:I

    iget-object v6, p0, Lcom/cyjh/mobileanjian/ipc/a/c$b;->a:Lcom/cyjh/mobileanjian/ipc/a/c;

    invoke-static {v6}, Lcom/cyjh/mobileanjian/ipc/a/c;->a(Lcom/cyjh/mobileanjian/ipc/a/c;)Lcom/cyjh/mobileanjian/ipc/engine/utils/d;

    move-result-object v6

    iget-wide v6, v6, Lcom/cyjh/mobileanjian/ipc/engine/utils/d;->n:J

    .line 109
    invoke-virtual/range {v0 .. v7}, Lcom/cyjh/mqm/MQLanguageStub;->Run(Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;IIJ)I

    move-result v0

    .line 112
    iget-object v1, p0, Lcom/cyjh/mobileanjian/ipc/a/c$b;->a:Lcom/cyjh/mobileanjian/ipc/a/c;

    invoke-static {v1}, Lcom/cyjh/mobileanjian/ipc/a/c;->a(Lcom/cyjh/mobileanjian/ipc/a/c;)Lcom/cyjh/mobileanjian/ipc/engine/utils/d;

    move-result-object v1

    iget v1, v1, Lcom/cyjh/mobileanjian/ipc/engine/utils/d;->l:I

    if-lez v1, :cond_2

    .line 114
    iget-object v1, p0, Lcom/cyjh/mobileanjian/ipc/a/c$b;->a:Lcom/cyjh/mobileanjian/ipc/a/c;

    invoke-static {v1}, Lcom/cyjh/mobileanjian/ipc/a/c;->b(Lcom/cyjh/mobileanjian/ipc/a/c;)Lcom/cyjh/mobileanjian/ipc/a/c$a;

    move-result-object v1

    invoke-virtual {v1}, Lcom/cyjh/mobileanjian/ipc/a/c$a;->cancel()Z

    .line 117
    :cond_2
    invoke-static {}, Lcom/cyjh/event/b;->b()V

    .line 118
    invoke-static {}, Lcom/cyjh/event/Injector;->releasePointerInfoArray()V

    .line 119
    invoke-static {}, Lcom/cyjh/event/Injector;->resetIsAnjianIm()V

    .line 122
    invoke-static {}, Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$IpcMessage;->newBuilder()Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$IpcMessage$Builder;

    move-result-object v1

    const/4 v2, 0x6

    .line 123
    invoke-virtual {v1, v2}, Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$IpcMessage$Builder;->setCmd(I)Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$IpcMessage$Builder;

    move-result-object v1

    .line 124
    invoke-virtual {v1, v0}, Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$IpcMessage$Builder;->addArg1(I)Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$IpcMessage$Builder;

    move-result-object v0

    .line 125
    invoke-static {}, Lcom/cyjh/mobileanjian/ipc/log/NativeLog;->getExtraLog()Ljava/lang/String;

    move-result-object v1

    invoke-virtual {v0, v1}, Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$IpcMessage$Builder;->addArg2(Ljava/lang/String;)Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$IpcMessage$Builder;

    move-result-object v0

    .line 126
    invoke-virtual {v0}, Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$IpcMessage$Builder;->build()Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$IpcMessage;

    move-result-object v0

    .line 127
    invoke-static {}, Lcom/cyjh/mobileanjian/ipc/ClientService;->a()Lcom/cyjh/mobileanjian/ipc/b/b;

    move-result-object v1

    invoke-virtual {v1, v0}, Lcom/cyjh/mobileanjian/ipc/b/b;->a(Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$IpcMessage;)V

    .line 129
    invoke-static {}, Lcom/cyjh/mobileanjian/ipc/log/NativeLog;->reset()V

    .line 130
    invoke-static {}, Landroid/os/Looper;->myLooper()Landroid/os/Looper;

    move-result-object v0

    invoke-virtual {v0}, Landroid/os/Looper;->quit()V

    .line 131
    invoke-static {}, Landroid/os/Looper;->loop()V

    .line 134
    iget-object v0, p0, Lcom/cyjh/mobileanjian/ipc/a/c$b;->a:Lcom/cyjh/mobileanjian/ipc/a/c;

    invoke-static {v0, v8}, Lcom/cyjh/mobileanjian/ipc/a/c;->a(Lcom/cyjh/mobileanjian/ipc/a/c;Z)Z

    .line 135
    const-string v0, "--> run script thread ends"

    invoke-static {}, Lcom/cyjh/mobileanjian/ipc/a/c;->e()Ljava/lang/Class;

    move-result-object v1

    invoke-static {v0, v1}, Lcom/cyjh/mobileanjian/ipc/engine/utils/CLog;->i(Ljava/lang/String;Ljava/lang/Class;)V

    goto/16 :goto_0
.end method
