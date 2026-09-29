.class Lcom/cyjh/mobileanjian/ipc/j$2;
.super Ljava/lang/Thread;
.source "SourceFile"


# annotations
.annotation system Ldalvik/annotation/EnclosingMethod;
    value = Lcom/cyjh/mobileanjian/ipc/j;->a(Ljava/lang/Process;Z)V
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x0
    name = null
.end annotation


# instance fields
.field final synthetic a:Z

.field final synthetic b:Lcom/cyjh/mobileanjian/ipc/j;


# direct methods
.method constructor <init>(Lcom/cyjh/mobileanjian/ipc/j;Ljava/lang/String;Z)V
    .locals 0

    .prologue
    .line 147
    iput-object p1, p0, Lcom/cyjh/mobileanjian/ipc/j$2;->b:Lcom/cyjh/mobileanjian/ipc/j;

    iput-boolean p3, p0, Lcom/cyjh/mobileanjian/ipc/j$2;->a:Z

    invoke-direct {p0, p2}, Ljava/lang/Thread;-><init>(Ljava/lang/String;)V

    return-void
.end method


# virtual methods
.method public run()V
    .locals 3

    .prologue
    .line 152
    new-instance v1, Ljava/io/BufferedReader;

    new-instance v0, Ljava/io/InputStreamReader;

    iget-object v2, p0, Lcom/cyjh/mobileanjian/ipc/j$2;->b:Lcom/cyjh/mobileanjian/ipc/j;

    invoke-static {v2}, Lcom/cyjh/mobileanjian/ipc/j;->d(Lcom/cyjh/mobileanjian/ipc/j;)Ljava/io/InputStream;

    move-result-object v2

    invoke-direct {v0, v2}, Ljava/io/InputStreamReader;-><init>(Ljava/io/InputStream;)V

    invoke-direct {v1, v0}, Ljava/io/BufferedReader;-><init>(Ljava/io/Reader;)V

    .line 158
    :cond_0
    :try_start_0
    invoke-virtual {v1}, Ljava/io/BufferedReader;->readLine()Ljava/lang/String;

    move-result-object v0

    .line 159
    if-eqz v0, :cond_2

    .line 162
    const-string v2, "rootOK"

    invoke-virtual {v0, v2}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v0

    if-eqz v0, :cond_0

    .line 164
    iget-object v0, p0, Lcom/cyjh/mobileanjian/ipc/j$2;->b:Lcom/cyjh/mobileanjian/ipc/j;

    const/4 v2, 0x1

    invoke-static {v0, v2}, Lcom/cyjh/mobileanjian/ipc/j;->a(Lcom/cyjh/mobileanjian/ipc/j;Z)Z

    .line 165
    iget-object v0, p0, Lcom/cyjh/mobileanjian/ipc/j$2;->b:Lcom/cyjh/mobileanjian/ipc/j;

    invoke-static {v0}, Lcom/cyjh/mobileanjian/ipc/j;->c(Lcom/cyjh/mobileanjian/ipc/j;)Lcom/cyjh/mobileanjian/ipc/interfaces/OnRootApplyCallback;

    move-result-object v0

    if-eqz v0, :cond_1

    .line 167
    iget-object v0, p0, Lcom/cyjh/mobileanjian/ipc/j$2;->b:Lcom/cyjh/mobileanjian/ipc/j;

    invoke-static {v0}, Lcom/cyjh/mobileanjian/ipc/j;->c(Lcom/cyjh/mobileanjian/ipc/j;)Lcom/cyjh/mobileanjian/ipc/interfaces/OnRootApplyCallback;

    move-result-object v0

    invoke-interface {v0}, Lcom/cyjh/mobileanjian/ipc/interfaces/OnRootApplyCallback;->onObtained()V

    .line 169
    :cond_1
    iget-boolean v0, p0, Lcom/cyjh/mobileanjian/ipc/j$2;->a:Z
    :try_end_0
    .catch Ljava/io/IOException; {:try_start_0 .. :try_end_0} :catch_0
    .catchall {:try_start_0 .. :try_end_0} :catchall_0

    if-nez v0, :cond_0

    .line 188
    :goto_0
    :try_start_1
    invoke-virtual {v1}, Ljava/io/BufferedReader;->close()V
    :try_end_1
    .catch Ljava/io/IOException; {:try_start_1 .. :try_end_1} :catch_2

    .line 195
    :goto_1
    return-void

    .line 175
    :cond_2
    :try_start_2
    const-string v0, "read got null"

    invoke-static {v0}, Lcom/cyjh/mobileanjian/ipc/utils/CLog;->e(Ljava/lang/String;)V
    :try_end_2
    .catch Ljava/io/IOException; {:try_start_2 .. :try_end_2} :catch_0
    .catchall {:try_start_2 .. :try_end_2} :catchall_0

    goto :goto_0

    .line 180
    :catch_0
    move-exception v0

    .line 182
    :try_start_3
    invoke-virtual {v0}, Ljava/io/IOException;->printStackTrace()V
    :try_end_3
    .catchall {:try_start_3 .. :try_end_3} :catchall_0

    .line 188
    :try_start_4
    invoke-virtual {v1}, Ljava/io/BufferedReader;->close()V
    :try_end_4
    .catch Ljava/io/IOException; {:try_start_4 .. :try_end_4} :catch_1

    goto :goto_1

    .line 190
    :catch_1
    move-exception v0

    .line 192
    invoke-virtual {v0}, Ljava/io/IOException;->printStackTrace()V

    goto :goto_1

    .line 190
    :catch_2
    move-exception v0

    .line 192
    invoke-virtual {v0}, Ljava/io/IOException;->printStackTrace()V

    goto :goto_1

    .line 186
    :catchall_0
    move-exception v0

    .line 188
    :try_start_5
    invoke-virtual {v1}, Ljava/io/BufferedReader;->close()V
    :try_end_5
    .catch Ljava/io/IOException; {:try_start_5 .. :try_end_5} :catch_3

    .line 193
    :goto_2
    throw v0

    .line 190
    :catch_3
    move-exception v1

    .line 192
    invoke-virtual {v1}, Ljava/io/IOException;->printStackTrace()V

    goto :goto_2
.end method
