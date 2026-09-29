.class Lcom/cyjh/mobileanjian/ipc/i$3$1;
.super Ljava/lang/Object;
.source "SourceFile"

# interfaces
.implements Lcom/goldcoast/sdk/domain/AnalyseResult;


# annotations
.annotation system Ldalvik/annotation/EnclosingMethod;
    value = Lcom/cyjh/mobileanjian/ipc/i$3;->run()V
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x0
    name = null
.end annotation


# instance fields
.field final synthetic a:Lcom/cyjh/mobileanjian/ipc/i$3;


# direct methods
.method constructor <init>(Lcom/cyjh/mobileanjian/ipc/i$3;)V
    .locals 0

    .prologue
    .line 158
    iput-object p1, p0, Lcom/cyjh/mobileanjian/ipc/i$3$1;->a:Lcom/cyjh/mobileanjian/ipc/i$3;

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method


# virtual methods
.method public onException(Ljava/lang/String;)V
    .locals 3

    .prologue
    const/4 v2, 0x0

    .line 198
    iget-object v0, p0, Lcom/cyjh/mobileanjian/ipc/i$3$1;->a:Lcom/cyjh/mobileanjian/ipc/i$3;

    iget-object v0, v0, Lcom/cyjh/mobileanjian/ipc/i$3;->b:Lcom/cyjh/mobileanjian/ipc/i;

    invoke-static {v0, v2}, Lcom/cyjh/mobileanjian/ipc/i;->a(Lcom/cyjh/mobileanjian/ipc/i;Z)Z

    .line 199
    iget-object v0, p0, Lcom/cyjh/mobileanjian/ipc/i$3$1;->a:Lcom/cyjh/mobileanjian/ipc/i$3;

    iget-object v0, v0, Lcom/cyjh/mobileanjian/ipc/i$3;->b:Lcom/cyjh/mobileanjian/ipc/i;

    invoke-static {v0}, Lcom/cyjh/mobileanjian/ipc/i;->b(Lcom/cyjh/mobileanjian/ipc/i;)Z

    move-result v0

    if-nez v0, :cond_0

    .line 200
    iget-object v0, p0, Lcom/cyjh/mobileanjian/ipc/i$3$1;->a:Lcom/cyjh/mobileanjian/ipc/i$3;

    iget-object v0, v0, Lcom/cyjh/mobileanjian/ipc/i$3;->b:Lcom/cyjh/mobileanjian/ipc/i;

    invoke-static {v0}, Lcom/cyjh/mobileanjian/ipc/i;->a(Lcom/cyjh/mobileanjian/ipc/i;)Landroid/os/Handler;

    move-result-object v0

    const/4 v1, 0x3

    invoke-virtual {v0, v1, p1}, Landroid/os/Handler;->obtainMessage(ILjava/lang/Object;)Landroid/os/Message;

    move-result-object v0

    invoke-virtual {v0}, Landroid/os/Message;->sendToTarget()V

    .line 202
    :cond_0
    iget-object v0, p0, Lcom/cyjh/mobileanjian/ipc/i$3$1;->a:Lcom/cyjh/mobileanjian/ipc/i$3;

    iget-object v0, v0, Lcom/cyjh/mobileanjian/ipc/i$3;->b:Lcom/cyjh/mobileanjian/ipc/i;

    const/4 v1, 0x1

    invoke-static {v0, v1}, Lcom/cyjh/mobileanjian/ipc/i;->b(Lcom/cyjh/mobileanjian/ipc/i;Z)Z

    .line 204
    iget-object v0, p0, Lcom/cyjh/mobileanjian/ipc/i$3$1;->a:Lcom/cyjh/mobileanjian/ipc/i$3;

    iget-object v0, v0, Lcom/cyjh/mobileanjian/ipc/i$3;->b:Lcom/cyjh/mobileanjian/ipc/i;

    invoke-static {v0, v2}, Lcom/cyjh/mobileanjian/ipc/i;->d(Lcom/cyjh/mobileanjian/ipc/i;Z)V

    .line 205
    return-void
.end method

.method public onFailed(Ljava/lang/String;)V
    .locals 3

    .prologue
    const/4 v2, 0x0

    .line 181
    iget-object v0, p0, Lcom/cyjh/mobileanjian/ipc/i$3$1;->a:Lcom/cyjh/mobileanjian/ipc/i$3;

    iget-object v0, v0, Lcom/cyjh/mobileanjian/ipc/i$3;->b:Lcom/cyjh/mobileanjian/ipc/i;

    invoke-static {v0, v2}, Lcom/cyjh/mobileanjian/ipc/i;->a(Lcom/cyjh/mobileanjian/ipc/i;Z)Z

    .line 182
    iget-object v0, p0, Lcom/cyjh/mobileanjian/ipc/i$3$1;->a:Lcom/cyjh/mobileanjian/ipc/i$3;

    iget-object v0, v0, Lcom/cyjh/mobileanjian/ipc/i$3;->b:Lcom/cyjh/mobileanjian/ipc/i;

    invoke-static {v0}, Lcom/cyjh/mobileanjian/ipc/i;->b(Lcom/cyjh/mobileanjian/ipc/i;)Z

    move-result v0

    if-nez v0, :cond_0

    .line 183
    iget-object v0, p0, Lcom/cyjh/mobileanjian/ipc/i$3$1;->a:Lcom/cyjh/mobileanjian/ipc/i$3;

    iget-object v0, v0, Lcom/cyjh/mobileanjian/ipc/i$3;->b:Lcom/cyjh/mobileanjian/ipc/i;

    invoke-static {v0}, Lcom/cyjh/mobileanjian/ipc/i;->a(Lcom/cyjh/mobileanjian/ipc/i;)Landroid/os/Handler;

    move-result-object v0

    const/4 v1, 0x3

    invoke-virtual {v0, v1, p1}, Landroid/os/Handler;->obtainMessage(ILjava/lang/Object;)Landroid/os/Message;

    move-result-object v0

    invoke-virtual {v0}, Landroid/os/Message;->sendToTarget()V

    .line 184
    :cond_0
    iget-object v0, p0, Lcom/cyjh/mobileanjian/ipc/i$3$1;->a:Lcom/cyjh/mobileanjian/ipc/i$3;

    iget-object v0, v0, Lcom/cyjh/mobileanjian/ipc/i$3;->b:Lcom/cyjh/mobileanjian/ipc/i;

    const/4 v1, 0x1

    invoke-static {v0, v1}, Lcom/cyjh/mobileanjian/ipc/i;->b(Lcom/cyjh/mobileanjian/ipc/i;Z)Z

    .line 186
    iget-object v0, p0, Lcom/cyjh/mobileanjian/ipc/i$3$1;->a:Lcom/cyjh/mobileanjian/ipc/i$3;

    iget-object v0, v0, Lcom/cyjh/mobileanjian/ipc/i$3;->b:Lcom/cyjh/mobileanjian/ipc/i;

    invoke-static {v0, v2}, Lcom/cyjh/mobileanjian/ipc/i;->d(Lcom/cyjh/mobileanjian/ipc/i;Z)V

    .line 187
    return-void
.end method

.method public onProgress(Ljava/lang/String;)V
    .locals 0

    .prologue
    .line 193
    return-void
.end method

.method public onSuccess(Ljava/lang/String;)V
    .locals 6

    .prologue
    const/4 v5, 0x2

    const/4 v4, 0x0

    const/4 v3, 0x1

    .line 162
    iget-object v0, p0, Lcom/cyjh/mobileanjian/ipc/i$3$1;->a:Lcom/cyjh/mobileanjian/ipc/i$3;

    iget-object v0, v0, Lcom/cyjh/mobileanjian/ipc/i$3;->a:Ljava/io/File;

    invoke-virtual {v0}, Ljava/io/File;->exists()Z

    move-result v0

    if-eqz v0, :cond_0

    .line 164
    iget-object v0, p0, Lcom/cyjh/mobileanjian/ipc/i$3$1;->a:Lcom/cyjh/mobileanjian/ipc/i$3;

    iget-object v0, v0, Lcom/cyjh/mobileanjian/ipc/i$3;->a:Ljava/io/File;

    invoke-virtual {v0}, Ljava/io/File;->delete()Z

    .line 166
    :cond_0
    iget-object v0, p0, Lcom/cyjh/mobileanjian/ipc/i$3$1;->a:Lcom/cyjh/mobileanjian/ipc/i$3;

    iget-object v0, v0, Lcom/cyjh/mobileanjian/ipc/i$3;->b:Lcom/cyjh/mobileanjian/ipc/i;

    invoke-static {v0, v4}, Lcom/cyjh/mobileanjian/ipc/i;->a(Lcom/cyjh/mobileanjian/ipc/i;Z)Z

    .line 167
    iget-object v0, p0, Lcom/cyjh/mobileanjian/ipc/i$3$1;->a:Lcom/cyjh/mobileanjian/ipc/i$3;

    iget-object v0, v0, Lcom/cyjh/mobileanjian/ipc/i$3;->b:Lcom/cyjh/mobileanjian/ipc/i;

    invoke-static {v0, v3}, Lcom/cyjh/mobileanjian/ipc/i;->b(Lcom/cyjh/mobileanjian/ipc/i;Z)Z

    .line 168
    iget-object v0, p0, Lcom/cyjh/mobileanjian/ipc/i$3$1;->a:Lcom/cyjh/mobileanjian/ipc/i$3;

    iget-object v0, v0, Lcom/cyjh/mobileanjian/ipc/i$3;->b:Lcom/cyjh/mobileanjian/ipc/i;

    invoke-static {v0, v3}, Lcom/cyjh/mobileanjian/ipc/i;->c(Lcom/cyjh/mobileanjian/ipc/i;Z)Z

    .line 169
    invoke-static {}, Lcom/cyjh/mobileanjian/ipc/h;->d()Ljava/io/File;

    move-result-object v0

    .line 170
    new-array v1, v5, [Ljava/lang/String;

    const-string v2, "chmod 777 /dev/input/*"

    aput-object v2, v1, v4

    invoke-virtual {v0}, Ljava/io/File;->getAbsolutePath()Ljava/lang/String;

    move-result-object v0

    aput-object v0, v1, v3

    .line 172
    invoke-static {}, Lcom/goldcoast/sdk/domain/EntryPoint;->instance()Lcom/goldcoast/sdk/domain/EntryPoint;

    move-result-object v0

    invoke-virtual {v0, v1}, Lcom/goldcoast/sdk/domain/EntryPoint;->exec([Ljava/lang/String;)Z

    .line 173
    iget-object v0, p0, Lcom/cyjh/mobileanjian/ipc/i$3$1;->a:Lcom/cyjh/mobileanjian/ipc/i$3;

    iget-object v0, v0, Lcom/cyjh/mobileanjian/ipc/i$3;->b:Lcom/cyjh/mobileanjian/ipc/i;

    invoke-static {v0}, Lcom/cyjh/mobileanjian/ipc/i;->a(Lcom/cyjh/mobileanjian/ipc/i;)Landroid/os/Handler;

    move-result-object v0

    invoke-virtual {v0, v5, p1}, Landroid/os/Handler;->obtainMessage(ILjava/lang/Object;)Landroid/os/Message;

    move-result-object v0

    invoke-virtual {v0}, Landroid/os/Message;->sendToTarget()V

    .line 175
    iget-object v0, p0, Lcom/cyjh/mobileanjian/ipc/i$3$1;->a:Lcom/cyjh/mobileanjian/ipc/i$3;

    iget-object v0, v0, Lcom/cyjh/mobileanjian/ipc/i$3;->b:Lcom/cyjh/mobileanjian/ipc/i;

    invoke-static {v0, v3}, Lcom/cyjh/mobileanjian/ipc/i;->d(Lcom/cyjh/mobileanjian/ipc/i;Z)V

    .line 176
    return-void
.end method
