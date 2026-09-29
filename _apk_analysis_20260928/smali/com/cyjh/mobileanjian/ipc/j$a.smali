.class Lcom/cyjh/mobileanjian/ipc/j$a;
.super Ljava/lang/Thread;
.source "SourceFile"


# annotations
.annotation system Ldalvik/annotation/EnclosingClass;
    value = Lcom/cyjh/mobileanjian/ipc/j;
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x2
    name = "a"
.end annotation


# instance fields
.field final synthetic a:Lcom/cyjh/mobileanjian/ipc/j;


# direct methods
.method private constructor <init>(Lcom/cyjh/mobileanjian/ipc/j;)V
    .locals 0

    .prologue
    .line 75
    iput-object p1, p0, Lcom/cyjh/mobileanjian/ipc/j$a;->a:Lcom/cyjh/mobileanjian/ipc/j;

    invoke-direct {p0}, Ljava/lang/Thread;-><init>()V

    return-void
.end method

.method synthetic constructor <init>(Lcom/cyjh/mobileanjian/ipc/j;Lcom/cyjh/mobileanjian/ipc/j$1;)V
    .locals 0

    .prologue
    .line 75
    invoke-direct {p0, p1}, Lcom/cyjh/mobileanjian/ipc/j$a;-><init>(Lcom/cyjh/mobileanjian/ipc/j;)V

    return-void
.end method


# virtual methods
.method public run()V
    .locals 3

    .prologue
    .line 82
    :try_start_0
    iget-object v0, p0, Lcom/cyjh/mobileanjian/ipc/j$a;->a:Lcom/cyjh/mobileanjian/ipc/j;

    invoke-static {}, Ljava/lang/Runtime;->getRuntime()Ljava/lang/Runtime;

    move-result-object v1

    const-string v2, "su"

    invoke-virtual {v1, v2}, Ljava/lang/Runtime;->exec(Ljava/lang/String;)Ljava/lang/Process;

    move-result-object v1

    invoke-static {v0, v1}, Lcom/cyjh/mobileanjian/ipc/j;->a(Lcom/cyjh/mobileanjian/ipc/j;Ljava/lang/Process;)Ljava/lang/Process;

    .line 83
    iget-object v0, p0, Lcom/cyjh/mobileanjian/ipc/j$a;->a:Lcom/cyjh/mobileanjian/ipc/j;

    new-instance v1, Ljava/io/DataOutputStream;

    iget-object v2, p0, Lcom/cyjh/mobileanjian/ipc/j$a;->a:Lcom/cyjh/mobileanjian/ipc/j;

    invoke-static {v2}, Lcom/cyjh/mobileanjian/ipc/j;->a(Lcom/cyjh/mobileanjian/ipc/j;)Ljava/lang/Process;

    move-result-object v2

    invoke-virtual {v2}, Ljava/lang/Process;->getOutputStream()Ljava/io/OutputStream;

    move-result-object v2

    invoke-direct {v1, v2}, Ljava/io/DataOutputStream;-><init>(Ljava/io/OutputStream;)V

    invoke-static {v0, v1}, Lcom/cyjh/mobileanjian/ipc/j;->a(Lcom/cyjh/mobileanjian/ipc/j;Ljava/io/DataOutputStream;)Ljava/io/DataOutputStream;

    .line 84
    iget-object v0, p0, Lcom/cyjh/mobileanjian/ipc/j$a;->a:Lcom/cyjh/mobileanjian/ipc/j;

    iget-object v1, p0, Lcom/cyjh/mobileanjian/ipc/j$a;->a:Lcom/cyjh/mobileanjian/ipc/j;

    invoke-static {v1}, Lcom/cyjh/mobileanjian/ipc/j;->a(Lcom/cyjh/mobileanjian/ipc/j;)Ljava/lang/Process;

    move-result-object v1

    invoke-virtual {v1}, Ljava/lang/Process;->getInputStream()Ljava/io/InputStream;

    move-result-object v1

    invoke-static {v0, v1}, Lcom/cyjh/mobileanjian/ipc/j;->a(Lcom/cyjh/mobileanjian/ipc/j;Ljava/io/InputStream;)Ljava/io/InputStream;

    .line 85
    iget-object v0, p0, Lcom/cyjh/mobileanjian/ipc/j$a;->a:Lcom/cyjh/mobileanjian/ipc/j;

    invoke-static {v0}, Lcom/cyjh/mobileanjian/ipc/j;->b(Lcom/cyjh/mobileanjian/ipc/j;)Ljava/io/DataOutputStream;

    move-result-object v0

    const-string v1, "echo \"rootOK\"\n"

    invoke-virtual {v0, v1}, Ljava/io/DataOutputStream;->writeBytes(Ljava/lang/String;)V

    .line 87
    iget-object v0, p0, Lcom/cyjh/mobileanjian/ipc/j$a;->a:Lcom/cyjh/mobileanjian/ipc/j;

    invoke-static {v0}, Lcom/cyjh/mobileanjian/ipc/j;->b(Lcom/cyjh/mobileanjian/ipc/j;)Ljava/io/DataOutputStream;

    move-result-object v0

    invoke-virtual {v0}, Ljava/io/DataOutputStream;->flush()V

    .line 88
    iget-object v0, p0, Lcom/cyjh/mobileanjian/ipc/j$a;->a:Lcom/cyjh/mobileanjian/ipc/j;

    iget-object v1, p0, Lcom/cyjh/mobileanjian/ipc/j$a;->a:Lcom/cyjh/mobileanjian/ipc/j;

    invoke-static {v1}, Lcom/cyjh/mobileanjian/ipc/j;->a(Lcom/cyjh/mobileanjian/ipc/j;)Ljava/lang/Process;

    move-result-object v1

    const/4 v2, 0x0

    invoke-static {v0, v1, v2}, Lcom/cyjh/mobileanjian/ipc/j;->a(Lcom/cyjh/mobileanjian/ipc/j;Ljava/lang/Process;Z)V
    :try_end_0
    .catch Ljava/io/IOException; {:try_start_0 .. :try_end_0} :catch_0

    .line 99
    :goto_0
    return-void

    .line 90
    :catch_0
    move-exception v0

    .line 92
    const-string v1, "requestRoot() --:  Exception"

    invoke-static {v1}, Lcom/cyjh/mobileanjian/ipc/utils/CLog;->i(Ljava/lang/String;)V

    .line 93
    iget-object v1, p0, Lcom/cyjh/mobileanjian/ipc/j$a;->a:Lcom/cyjh/mobileanjian/ipc/j;

    invoke-static {v1}, Lcom/cyjh/mobileanjian/ipc/j;->a(Lcom/cyjh/mobileanjian/ipc/j;)Ljava/lang/Process;

    move-result-object v1

    if-eqz v1, :cond_0

    .line 94
    iget-object v1, p0, Lcom/cyjh/mobileanjian/ipc/j$a;->a:Lcom/cyjh/mobileanjian/ipc/j;

    invoke-static {v1}, Lcom/cyjh/mobileanjian/ipc/j;->a(Lcom/cyjh/mobileanjian/ipc/j;)Ljava/lang/Process;

    move-result-object v1

    invoke-virtual {v1}, Ljava/lang/Process;->destroy()V

    .line 95
    :cond_0
    iget-object v1, p0, Lcom/cyjh/mobileanjian/ipc/j$a;->a:Lcom/cyjh/mobileanjian/ipc/j;

    invoke-static {v1}, Lcom/cyjh/mobileanjian/ipc/j;->c(Lcom/cyjh/mobileanjian/ipc/j;)Lcom/cyjh/mobileanjian/ipc/interfaces/OnRootApplyCallback;

    move-result-object v1

    if-eqz v1, :cond_1

    .line 96
    iget-object v1, p0, Lcom/cyjh/mobileanjian/ipc/j$a;->a:Lcom/cyjh/mobileanjian/ipc/j;

    invoke-static {v1}, Lcom/cyjh/mobileanjian/ipc/j;->c(Lcom/cyjh/mobileanjian/ipc/j;)Lcom/cyjh/mobileanjian/ipc/interfaces/OnRootApplyCallback;

    move-result-object v1

    invoke-interface {v1}, Lcom/cyjh/mobileanjian/ipc/interfaces/OnRootApplyCallback;->onRefused()V

    .line 97
    :cond_1
    invoke-virtual {v0}, Ljava/io/IOException;->printStackTrace()V

    goto :goto_0
.end method
