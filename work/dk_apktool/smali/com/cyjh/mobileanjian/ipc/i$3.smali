.class Lcom/cyjh/mobileanjian/ipc/i$3;
.super Ljava/lang/Thread;
.source "SourceFile"


# annotations
.annotation system Ldalvik/annotation/EnclosingMethod;
    value = Lcom/cyjh/mobileanjian/ipc/i;->d()V
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x0
    name = null
.end annotation


# instance fields
.field final synthetic a:Ljava/io/File;

.field final synthetic b:Lcom/cyjh/mobileanjian/ipc/i;


# direct methods
.method constructor <init>(Lcom/cyjh/mobileanjian/ipc/i;Ljava/lang/String;Ljava/io/File;)V
    .locals 0

    .prologue
    .line 146
    iput-object p1, p0, Lcom/cyjh/mobileanjian/ipc/i$3;->b:Lcom/cyjh/mobileanjian/ipc/i;

    iput-object p3, p0, Lcom/cyjh/mobileanjian/ipc/i$3;->a:Ljava/io/File;

    invoke-direct {p0, p2}, Ljava/lang/Thread;-><init>(Ljava/lang/String;)V

    return-void
.end method


# virtual methods
.method public run()V
    .locals 4

    .prologue
    const/4 v3, 0x0

    .line 152
    :try_start_0
    iget-object v0, p0, Lcom/cyjh/mobileanjian/ipc/i$3;->a:Ljava/io/File;

    invoke-virtual {v0}, Ljava/io/File;->exists()Z

    move-result v0

    if-nez v0, :cond_0

    .line 154
    iget-object v0, p0, Lcom/cyjh/mobileanjian/ipc/i$3;->a:Ljava/io/File;

    invoke-virtual {v0}, Ljava/io/File;->createNewFile()Z

    .line 157
    :cond_0
    invoke-static {}, Lcom/goldcoast/sdk/domain/EntryPoint;->instance()Lcom/goldcoast/sdk/domain/EntryPoint;

    move-result-object v0

    new-instance v1, Lcom/cyjh/mobileanjian/ipc/i$3$1;

    invoke-direct {v1, p0}, Lcom/cyjh/mobileanjian/ipc/i$3$1;-><init>(Lcom/cyjh/mobileanjian/ipc/i$3;)V

    invoke-virtual {v0, v1}, Lcom/goldcoast/sdk/domain/EntryPoint;->analyse(Lcom/goldcoast/sdk/domain/AnalyseResult;)V
    :try_end_0
    .catch Ljava/lang/Exception; {:try_start_0 .. :try_end_0} :catch_0

    .line 215
    :goto_0
    return-void

    .line 207
    :catch_0
    move-exception v0

    .line 209
    iget-object v0, p0, Lcom/cyjh/mobileanjian/ipc/i$3;->b:Lcom/cyjh/mobileanjian/ipc/i;

    invoke-static {v0, v3}, Lcom/cyjh/mobileanjian/ipc/i;->a(Lcom/cyjh/mobileanjian/ipc/i;Z)Z

    .line 210
    iget-object v0, p0, Lcom/cyjh/mobileanjian/ipc/i$3;->b:Lcom/cyjh/mobileanjian/ipc/i;

    const/4 v1, 0x1

    invoke-static {v0, v1}, Lcom/cyjh/mobileanjian/ipc/i;->b(Lcom/cyjh/mobileanjian/ipc/i;Z)Z

    .line 211
    iget-object v0, p0, Lcom/cyjh/mobileanjian/ipc/i$3;->b:Lcom/cyjh/mobileanjian/ipc/i;

    invoke-static {v0}, Lcom/cyjh/mobileanjian/ipc/i;->a(Lcom/cyjh/mobileanjian/ipc/i;)Landroid/os/Handler;

    move-result-object v0

    const/4 v1, 0x3

    const-string v2, "Exception occurs when startThirdRoot()"

    invoke-virtual {v0, v1, v2}, Landroid/os/Handler;->obtainMessage(ILjava/lang/Object;)Landroid/os/Message;

    move-result-object v0

    invoke-virtual {v0}, Landroid/os/Message;->sendToTarget()V

    .line 213
    iget-object v0, p0, Lcom/cyjh/mobileanjian/ipc/i$3;->b:Lcom/cyjh/mobileanjian/ipc/i;

    invoke-static {v0, v3}, Lcom/cyjh/mobileanjian/ipc/i;->d(Lcom/cyjh/mobileanjian/ipc/i;Z)V

    goto :goto_0
.end method
