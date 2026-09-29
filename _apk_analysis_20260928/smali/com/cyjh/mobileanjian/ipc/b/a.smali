.class public Lcom/cyjh/mobileanjian/ipc/b/a;
.super Ljava/lang/Object;
.source "SourceFile"


# static fields
.field private static final a:I = 0x1000


# instance fields
.field private b:Landroid/net/LocalSocket;

.field private c:Ljava/net/Socket;

.field private d:Ljava/io/InputStream;

.field private e:Ljava/io/OutputStream;


# direct methods
.method public constructor <init>(Landroid/net/LocalSocket;)V
    .locals 1

    .prologue
    const/4 v0, 0x0

    .line 38
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    .line 17
    iput-object v0, p0, Lcom/cyjh/mobileanjian/ipc/b/a;->b:Landroid/net/LocalSocket;

    .line 18
    iput-object v0, p0, Lcom/cyjh/mobileanjian/ipc/b/a;->c:Ljava/net/Socket;

    .line 19
    iput-object v0, p0, Lcom/cyjh/mobileanjian/ipc/b/a;->d:Ljava/io/InputStream;

    .line 20
    iput-object v0, p0, Lcom/cyjh/mobileanjian/ipc/b/a;->e:Ljava/io/OutputStream;

    .line 39
    iput-object p1, p0, Lcom/cyjh/mobileanjian/ipc/b/a;->b:Landroid/net/LocalSocket;

    .line 42
    :try_start_0
    iget-object v0, p0, Lcom/cyjh/mobileanjian/ipc/b/a;->b:Landroid/net/LocalSocket;

    invoke-virtual {v0}, Landroid/net/LocalSocket;->getInputStream()Ljava/io/InputStream;

    move-result-object v0

    iput-object v0, p0, Lcom/cyjh/mobileanjian/ipc/b/a;->d:Ljava/io/InputStream;

    .line 43
    iget-object v0, p0, Lcom/cyjh/mobileanjian/ipc/b/a;->b:Landroid/net/LocalSocket;

    invoke-virtual {v0}, Landroid/net/LocalSocket;->getOutputStream()Ljava/io/OutputStream;

    move-result-object v0

    iput-object v0, p0, Lcom/cyjh/mobileanjian/ipc/b/a;->e:Ljava/io/OutputStream;
    :try_end_0
    .catch Ljava/io/IOException; {:try_start_0 .. :try_end_0} :catch_0

    .line 50
    :goto_0
    return-void

    .line 45
    :catch_0
    move-exception v0

    .line 47
    invoke-virtual {v0}, Ljava/io/IOException;->printStackTrace()V

    goto :goto_0
.end method

.method public constructor <init>(Ljava/net/Socket;)V
    .locals 1

    .prologue
    const/4 v0, 0x0

    .line 23
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    .line 17
    iput-object v0, p0, Lcom/cyjh/mobileanjian/ipc/b/a;->b:Landroid/net/LocalSocket;

    .line 18
    iput-object v0, p0, Lcom/cyjh/mobileanjian/ipc/b/a;->c:Ljava/net/Socket;

    .line 19
    iput-object v0, p0, Lcom/cyjh/mobileanjian/ipc/b/a;->d:Ljava/io/InputStream;

    .line 20
    iput-object v0, p0, Lcom/cyjh/mobileanjian/ipc/b/a;->e:Ljava/io/OutputStream;

    .line 24
    iput-object p1, p0, Lcom/cyjh/mobileanjian/ipc/b/a;->c:Ljava/net/Socket;

    .line 27
    :try_start_0
    iget-object v0, p0, Lcom/cyjh/mobileanjian/ipc/b/a;->c:Ljava/net/Socket;

    invoke-virtual {v0}, Ljava/net/Socket;->getInputStream()Ljava/io/InputStream;

    move-result-object v0

    iput-object v0, p0, Lcom/cyjh/mobileanjian/ipc/b/a;->d:Ljava/io/InputStream;

    .line 28
    iget-object v0, p0, Lcom/cyjh/mobileanjian/ipc/b/a;->c:Ljava/net/Socket;

    invoke-virtual {v0}, Ljava/net/Socket;->getOutputStream()Ljava/io/OutputStream;

    move-result-object v0

    iput-object v0, p0, Lcom/cyjh/mobileanjian/ipc/b/a;->e:Ljava/io/OutputStream;
    :try_end_0
    .catch Ljava/io/IOException; {:try_start_0 .. :try_end_0} :catch_0

    .line 35
    :goto_0
    return-void

    .line 30
    :catch_0
    move-exception v0

    .line 32
    invoke-virtual {v0}, Ljava/io/IOException;->printStackTrace()V

    goto :goto_0
.end method


# virtual methods
.method protected a()V
    .locals 1

    .prologue
    .line 112
    :try_start_0
    iget-object v0, p0, Lcom/cyjh/mobileanjian/ipc/b/a;->c:Ljava/net/Socket;

    if-eqz v0, :cond_0

    .line 113
    iget-object v0, p0, Lcom/cyjh/mobileanjian/ipc/b/a;->c:Ljava/net/Socket;

    invoke-virtual {v0}, Ljava/net/Socket;->close()V

    .line 114
    :cond_0
    iget-object v0, p0, Lcom/cyjh/mobileanjian/ipc/b/a;->b:Landroid/net/LocalSocket;

    if-eqz v0, :cond_1

    .line 115
    iget-object v0, p0, Lcom/cyjh/mobileanjian/ipc/b/a;->b:Landroid/net/LocalSocket;

    invoke-virtual {v0}, Landroid/net/LocalSocket;->close()V

    .line 116
    :cond_1
    iget-object v0, p0, Lcom/cyjh/mobileanjian/ipc/b/a;->d:Ljava/io/InputStream;

    if-eqz v0, :cond_2

    .line 117
    iget-object v0, p0, Lcom/cyjh/mobileanjian/ipc/b/a;->d:Ljava/io/InputStream;

    invoke-virtual {v0}, Ljava/io/InputStream;->close()V

    .line 118
    :cond_2
    iget-object v0, p0, Lcom/cyjh/mobileanjian/ipc/b/a;->e:Ljava/io/OutputStream;

    if-eqz v0, :cond_3

    .line 119
    iget-object v0, p0, Lcom/cyjh/mobileanjian/ipc/b/a;->e:Ljava/io/OutputStream;

    invoke-virtual {v0}, Ljava/io/OutputStream;->close()V
    :try_end_0
    .catch Ljava/io/IOException; {:try_start_0 .. :try_end_0} :catch_0

    .line 125
    :cond_3
    :goto_0
    return-void

    .line 121
    :catch_0
    move-exception v0

    .line 123
    invoke-virtual {v0}, Ljava/io/IOException;->printStackTrace()V

    goto :goto_0
.end method

.method protected a(Ljava/nio/ByteBuffer;)V
    .locals 3

    .prologue
    const/16 v2, 0x1000

    .line 62
    const/16 v0, 0x1000

    :try_start_0
    new-array v0, v0, [B

    .line 64
    :goto_0
    invoke-virtual {p1}, Ljava/nio/ByteBuffer;->hasRemaining()Z

    move-result v1

    if-eqz v1, :cond_1

    .line 66
    invoke-virtual {p1}, Ljava/nio/ByteBuffer;->remaining()I

    move-result v1

    if-lt v1, v2, :cond_0

    .line 68
    invoke-virtual {p1, v0}, Ljava/nio/ByteBuffer;->get([B)Ljava/nio/ByteBuffer;

    .line 75
    :goto_1
    iget-object v1, p0, Lcom/cyjh/mobileanjian/ipc/b/a;->e:Ljava/io/OutputStream;

    invoke-virtual {v1, v0}, Ljava/io/OutputStream;->write([B)V
    :try_end_0
    .catch Ljava/io/IOException; {:try_start_0 .. :try_end_0} :catch_0

    goto :goto_0

    .line 79
    :catch_0
    move-exception v0

    .line 81
    invoke-virtual {v0}, Ljava/io/IOException;->printStackTrace()V

    .line 83
    :goto_2
    return-void

    .line 72
    :cond_0
    :try_start_1
    invoke-virtual {p1}, Ljava/nio/ByteBuffer;->remaining()I

    move-result v0

    new-array v0, v0, [B

    .line 73
    invoke-virtual {p1, v0}, Ljava/nio/ByteBuffer;->get([B)Ljava/nio/ByteBuffer;

    goto :goto_1

    .line 77
    :cond_1
    iget-object v0, p0, Lcom/cyjh/mobileanjian/ipc/b/a;->e:Ljava/io/OutputStream;

    invoke-virtual {v0}, Ljava/io/OutputStream;->flush()V
    :try_end_1
    .catch Ljava/io/IOException; {:try_start_1 .. :try_end_1} :catch_0

    goto :goto_2
.end method

.method protected a([B)V
    .locals 1

    .prologue
    .line 54
    invoke-static {p1}, Ljava/nio/ByteBuffer;->wrap([B)Ljava/nio/ByteBuffer;

    move-result-object v0

    .line 55
    invoke-virtual {p0, v0}, Lcom/cyjh/mobileanjian/ipc/b/a;->a(Ljava/nio/ByteBuffer;)V

    .line 56
    return-void
.end method

.method protected b([B)I
    .locals 5

    .prologue
    const/4 v1, 0x0

    const/4 v0, -0x1

    .line 87
    .line 89
    array-length v4, p1

    move v2, v1

    .line 93
    :goto_0
    if-ge v2, v4, :cond_1

    .line 95
    :try_start_0
    iget-object v1, p0, Lcom/cyjh/mobileanjian/ipc/b/a;->d:Ljava/io/InputStream;

    sub-int v3, v4, v2

    invoke-virtual {v1, p1, v2, v3}, Ljava/io/InputStream;->read([BII)I
    :try_end_0
    .catch Ljava/io/IOException; {:try_start_0 .. :try_end_0} :catch_0

    move-result v3

    if-gez v3, :cond_0

    .line 105
    :goto_1
    return v0

    .line 97
    :cond_0
    add-int v1, v2, v3

    move v2, v1

    move v1, v3

    goto :goto_0

    :cond_1
    move v0, v1

    .line 104
    goto :goto_1

    .line 100
    :catch_0
    move-exception v1

    .line 102
    invoke-virtual {v1}, Ljava/io/IOException;->printStackTrace()V

    goto :goto_1
.end method
