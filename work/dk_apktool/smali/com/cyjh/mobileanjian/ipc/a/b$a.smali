.class Lcom/cyjh/mobileanjian/ipc/a/b$a;
.super Ljava/lang/Thread;
.source "SourceFile"


# annotations
.annotation system Ldalvik/annotation/EnclosingClass;
    value = Lcom/cyjh/mobileanjian/ipc/a/b;
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x2
    name = "a"
.end annotation


# instance fields
.field final synthetic a:Lcom/cyjh/mobileanjian/ipc/a/b;

.field private b:I


# direct methods
.method private constructor <init>(Lcom/cyjh/mobileanjian/ipc/a/b;)V
    .locals 0

    .prologue
    .line 379
    iput-object p1, p0, Lcom/cyjh/mobileanjian/ipc/a/b$a;->a:Lcom/cyjh/mobileanjian/ipc/a/b;

    invoke-direct {p0}, Ljava/lang/Thread;-><init>()V

    return-void
.end method

.method synthetic constructor <init>(Lcom/cyjh/mobileanjian/ipc/a/b;Lcom/cyjh/mobileanjian/ipc/a/b$1;)V
    .locals 0

    .prologue
    .line 379
    invoke-direct {p0, p1}, Lcom/cyjh/mobileanjian/ipc/a/b$a;-><init>(Lcom/cyjh/mobileanjian/ipc/a/b;)V

    return-void
.end method


# virtual methods
.method public run()V
    .locals 2

    .prologue
    .line 387
    :goto_0
    iget-object v0, p0, Lcom/cyjh/mobileanjian/ipc/a/b$a;->a:Lcom/cyjh/mobileanjian/ipc/a/b;

    invoke-static {v0}, Lcom/cyjh/mobileanjian/ipc/a/b;->b(Lcom/cyjh/mobileanjian/ipc/a/b;)Lcom/cyjh/mobileanjian/ipc/b/b;

    move-result-object v0

    invoke-virtual {v0}, Lcom/cyjh/mobileanjian/ipc/b/b;->c()Z

    move-result v0

    if-eqz v0, :cond_0

    .line 389
    iget-object v0, p0, Lcom/cyjh/mobileanjian/ipc/a/b$a;->a:Lcom/cyjh/mobileanjian/ipc/a/b;

    invoke-static {v0}, Lcom/cyjh/mobileanjian/ipc/a/b;->a(Lcom/cyjh/mobileanjian/ipc/a/b;)Lcom/cyjh/mqm/MQLanguageStub$MQAuxiliary;

    move-result-object v0

    invoke-virtual {v0}, Lcom/cyjh/mqm/MQLanguageStub$MQAuxiliary;->WaitKey()I

    move-result v0

    iput v0, p0, Lcom/cyjh/mobileanjian/ipc/a/b$a;->b:I

    .line 390
    new-instance v0, Ljava/lang/StringBuilder;

    invoke-direct {v0}, Ljava/lang/StringBuilder;-><init>()V

    const-string v1, "Pressed Key! KEY CODE IS "

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    iget v1, p0, Lcom/cyjh/mobileanjian/ipc/a/b$a;->b:I

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-virtual {v0}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v0

    invoke-static {}, Lcom/cyjh/mobileanjian/ipc/a/b;->b()Ljava/lang/Class;

    move-result-object v1

    invoke-static {v0, v1}, Lcom/cyjh/mobileanjian/ipc/engine/utils/CLog;->i(Ljava/lang/String;Ljava/lang/Class;)V

    .line 391
    iget v0, p0, Lcom/cyjh/mobileanjian/ipc/a/b$a;->b:I

    const/4 v1, -0x1

    if-ne v0, v1, :cond_1

    .line 400
    :cond_0
    return-void

    .line 394
    :cond_1
    invoke-static {}, Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$IpcMessage;->newBuilder()Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$IpcMessage$Builder;

    move-result-object v0

    const/16 v1, 0x81

    .line 395
    invoke-virtual {v0, v1}, Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$IpcMessage$Builder;->setCmd(I)Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$IpcMessage$Builder;

    move-result-object v0

    iget v1, p0, Lcom/cyjh/mobileanjian/ipc/a/b$a;->b:I

    .line 396
    invoke-virtual {v0, v1}, Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$IpcMessage$Builder;->addArg1(I)Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$IpcMessage$Builder;

    move-result-object v0

    .line 397
    invoke-virtual {v0}, Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$IpcMessage$Builder;->build()Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$IpcMessage;

    move-result-object v0

    .line 398
    iget-object v1, p0, Lcom/cyjh/mobileanjian/ipc/a/b$a;->a:Lcom/cyjh/mobileanjian/ipc/a/b;

    invoke-static {v1}, Lcom/cyjh/mobileanjian/ipc/a/b;->b(Lcom/cyjh/mobileanjian/ipc/a/b;)Lcom/cyjh/mobileanjian/ipc/b/b;

    move-result-object v1

    invoke-virtual {v1, v0}, Lcom/cyjh/mobileanjian/ipc/b/b;->a(Lcom/cyjh/mobileanjian/ipc/share/proto/Ipc$IpcMessage;)V

    goto :goto_0
.end method
