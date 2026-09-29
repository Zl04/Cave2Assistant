.class public Lcom/cyjh/mobileanjian/ipc/engine/utils/e;
.super Ljava/lang/Object;
.source "SourceFile"


# static fields
.field private static b:Lcom/cyjh/mobileanjian/ipc/engine/utils/e;


# instance fields
.field private a:Ljava/io/OutputStream;


# direct methods
.method static constructor <clinit>()V
    .locals 1

    .prologue
    .line 25
    const/4 v0, 0x0

    sput-object v0, Lcom/cyjh/mobileanjian/ipc/engine/utils/e;->b:Lcom/cyjh/mobileanjian/ipc/engine/utils/e;

    return-void
.end method

.method private constructor <init>()V
    .locals 2

    .prologue
    .line 28
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    .line 24
    const/4 v0, 0x0

    iput-object v0, p0, Lcom/cyjh/mobileanjian/ipc/engine/utils/e;->a:Ljava/io/OutputStream;

    .line 31
    :try_start_0
    invoke-static {}, Ljava/lang/Runtime;->getRuntime()Ljava/lang/Runtime;

    move-result-object v1

    invoke-static {}, Lcom/cyjh/mobileanjian/ipc/a/a;->s()Z

    move-result v0

    if-eqz v0, :cond_0

    const-string v0, "su \n"

    :goto_0
    invoke-virtual {v1, v0}, Ljava/lang/Runtime;->exec(Ljava/lang/String;)Ljava/lang/Process;

    move-result-object v0

    .line 32
    invoke-virtual {v0}, Ljava/lang/Process;->getOutputStream()Ljava/io/OutputStream;

    move-result-object v0

    iput-object v0, p0, Lcom/cyjh/mobileanjian/ipc/engine/utils/e;->a:Ljava/io/OutputStream;

    .line 38
    :goto_1
    return-void

    .line 31
    :cond_0
    const-string v0, "sh \n"
    :try_end_0
    .catch Ljava/io/IOException; {:try_start_0 .. :try_end_0} :catch_0

    goto :goto_0

    .line 34
    :catch_0
    move-exception v0

    .line 36
    invoke-virtual {v0}, Ljava/io/IOException;->printStackTrace()V

    goto :goto_1
.end method

.method public static a()Lcom/cyjh/mobileanjian/ipc/engine/utils/e;
    .locals 1

    .prologue
    .line 48
    sget-object v0, Lcom/cyjh/mobileanjian/ipc/engine/utils/e;->b:Lcom/cyjh/mobileanjian/ipc/engine/utils/e;

    if-nez v0, :cond_0

    .line 49
    new-instance v0, Lcom/cyjh/mobileanjian/ipc/engine/utils/e;

    invoke-direct {v0}, Lcom/cyjh/mobileanjian/ipc/engine/utils/e;-><init>()V

    sput-object v0, Lcom/cyjh/mobileanjian/ipc/engine/utils/e;->b:Lcom/cyjh/mobileanjian/ipc/engine/utils/e;

    .line 50
    :cond_0
    sget-object v0, Lcom/cyjh/mobileanjian/ipc/engine/utils/e;->b:Lcom/cyjh/mobileanjian/ipc/engine/utils/e;

    return-object v0
.end method


# virtual methods
.method public a(Ljava/lang/String;)V
    .locals 2

    .prologue
    .line 63
    :try_start_0
    iget-object v0, p0, Lcom/cyjh/mobileanjian/ipc/engine/utils/e;->a:Ljava/io/OutputStream;

    invoke-virtual {p1}, Ljava/lang/String;->getBytes()[B

    move-result-object v1

    invoke-virtual {v0, v1}, Ljava/io/OutputStream;->write([B)V

    .line 64
    iget-object v0, p0, Lcom/cyjh/mobileanjian/ipc/engine/utils/e;->a:Ljava/io/OutputStream;

    const-string v1, " \n"

    invoke-virtual {v1}, Ljava/lang/String;->getBytes()[B

    move-result-object v1

    invoke-virtual {v0, v1}, Ljava/io/OutputStream;->write([B)V

    .line 65
    iget-object v0, p0, Lcom/cyjh/mobileanjian/ipc/engine/utils/e;->a:Ljava/io/OutputStream;

    invoke-virtual {v0}, Ljava/io/OutputStream;->flush()V
    :try_end_0
    .catch Ljava/io/IOException; {:try_start_0 .. :try_end_0} :catch_0

    .line 71
    :goto_0
    return-void

    .line 67
    :catch_0
    move-exception v0

    .line 69
    invoke-virtual {v0}, Ljava/io/IOException;->printStackTrace()V

    goto :goto_0
.end method

.method public b()V
    .locals 1

    .prologue
    .line 77
    :try_start_0
    iget-object v0, p0, Lcom/cyjh/mobileanjian/ipc/engine/utils/e;->a:Ljava/io/OutputStream;

    if-eqz v0, :cond_0

    .line 79
    const-string v0, "exit"

    invoke-virtual {p0, v0}, Lcom/cyjh/mobileanjian/ipc/engine/utils/e;->a(Ljava/lang/String;)V

    .line 80
    iget-object v0, p0, Lcom/cyjh/mobileanjian/ipc/engine/utils/e;->a:Ljava/io/OutputStream;

    invoke-virtual {v0}, Ljava/io/OutputStream;->close()V
    :try_end_0
    .catch Ljava/io/IOException; {:try_start_0 .. :try_end_0} :catch_0

    .line 87
    :cond_0
    :goto_0
    return-void

    .line 83
    :catch_0
    move-exception v0

    .line 85
    invoke-virtual {v0}, Ljava/io/IOException;->printStackTrace()V

    goto :goto_0
.end method
