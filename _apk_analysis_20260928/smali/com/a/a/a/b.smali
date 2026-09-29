.class public final Lcom/a/a/a/b;
.super Ljava/lang/Object;
.source "SourceFile"


# static fields
.field static final a:[Ljava/lang/String;


# direct methods
.method static constructor <clinit>()V
    .locals 3

    .prologue
    .line 52
    const/4 v0, 0x2

    new-array v0, v0, [Ljava/lang/String;

    const/4 v1, 0x0

    const-string v2, "echo -BOC-"

    aput-object v2, v0, v1

    const/4 v1, 0x1

    const-string v2, "id"

    aput-object v2, v0, v1

    sput-object v0, Lcom/a/a/a/b;->a:[Ljava/lang/String;

    return-void
.end method

.method public static varargs a(Ljava/lang/String;[Ljava/lang/String;)Lcom/a/a/a/a;
    .locals 1
    .param p0    # Ljava/lang/String;
        .annotation build Landroid/support/annotation/NonNull;
        .end annotation
    .end param
    .param p1    # [Ljava/lang/String;
        .annotation build Landroid/support/annotation/NonNull;
        .end annotation
    .end param

    .prologue
    .line 72
    invoke-static {p0, p1}, Lcom/a/a/a/b;->b(Ljava/lang/String;[Ljava/lang/String;)Lcom/a/a/a/a;

    move-result-object v0

    return-object v0
.end method

.method private static b(Ljava/lang/String;[Ljava/lang/String;)Lcom/a/a/a/a;
    .locals 10
    .param p0    # Ljava/lang/String;
        .annotation build Landroid/support/annotation/NonNull;
        .end annotation
    .end param
    .param p1    # [Ljava/lang/String;
        .annotation build Landroid/support/annotation/NonNull;
        .end annotation
    .end param

    .prologue
    .line 95
    new-instance v0, Ljava/util/ArrayList;

    invoke-direct {v0}, Ljava/util/ArrayList;-><init>()V

    invoke-static {v0}, Ljava/util/Collections;->synchronizedList(Ljava/util/List;)Ljava/util/List;

    move-result-object v1

    .line 96
    new-instance v0, Ljava/util/ArrayList;

    invoke-direct {v0}, Ljava/util/ArrayList;-><init>()V

    invoke-static {v0}, Ljava/util/Collections;->synchronizedList(Ljava/util/List;)Ljava/util/List;

    move-result-object v2

    .line 1185
    :try_start_0
    invoke-static {}, Ljava/lang/Runtime;->getRuntime()Ljava/lang/Runtime;

    move-result-object v0

    const/4 v3, 0x0

    invoke-virtual {v0, p0, v3}, Ljava/lang/Runtime;->exec(Ljava/lang/String;[Ljava/lang/String;)Ljava/lang/Process;

    move-result-object v3

    .line 102
    new-instance v4, Ljava/io/DataOutputStream;

    invoke-virtual {v3}, Ljava/lang/Process;->getOutputStream()Ljava/io/OutputStream;

    move-result-object v0

    invoke-direct {v4, v0}, Ljava/io/DataOutputStream;-><init>(Ljava/io/OutputStream;)V

    .line 103
    new-instance v5, Lcom/a/a/a/c;

    invoke-virtual {v3}, Ljava/lang/Process;->getInputStream()Ljava/io/InputStream;

    move-result-object v0

    invoke-direct {v5, v0, v1}, Lcom/a/a/a/c;-><init>(Ljava/io/InputStream;Ljava/util/List;)V

    .line 104
    new-instance v6, Lcom/a/a/a/c;

    invoke-virtual {v3}, Ljava/lang/Process;->getErrorStream()Ljava/io/InputStream;

    move-result-object v0

    invoke-direct {v6, v0, v2}, Lcom/a/a/a/c;-><init>(Ljava/io/InputStream;Ljava/util/List;)V

    .line 107
    invoke-virtual {v5}, Lcom/a/a/a/c;->start()V

    .line 108
    invoke-virtual {v6}, Lcom/a/a/a/c;->start()V
    :try_end_0
    .catch Ljava/lang/InterruptedException; {:try_start_0 .. :try_end_0} :catch_1
    .catch Ljava/io/IOException; {:try_start_0 .. :try_end_0} :catch_2

    .line 110
    :try_start_1
    array-length v7, p1

    const/4 v0, 0x0

    :goto_0
    if-ge v0, v7, :cond_0

    aget-object v8, p1, v0

    .line 111
    new-instance v9, Ljava/lang/StringBuilder;

    invoke-direct {v9}, Ljava/lang/StringBuilder;-><init>()V

    invoke-virtual {v9, v8}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v8

    const-string v9, "\n"

    invoke-virtual {v8, v9}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v8

    invoke-virtual {v8}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v8

    const-string v9, "UTF-8"

    invoke-virtual {v8, v9}, Ljava/lang/String;->getBytes(Ljava/lang/String;)[B

    move-result-object v8

    invoke-virtual {v4, v8}, Ljava/io/DataOutputStream;->write([B)V

    .line 112
    invoke-virtual {v4}, Ljava/io/DataOutputStream;->flush()V

    .line 110
    add-int/lit8 v0, v0, 0x1

    goto :goto_0

    .line 114
    :cond_0
    const-string v0, "exit\n"

    const-string v7, "UTF-8"

    invoke-virtual {v0, v7}, Ljava/lang/String;->getBytes(Ljava/lang/String;)[B

    move-result-object v0

    invoke-virtual {v4, v0}, Ljava/io/DataOutputStream;->write([B)V

    .line 115
    invoke-virtual {v4}, Ljava/io/DataOutputStream;->flush()V
    :try_end_1
    .catch Ljava/io/IOException; {:try_start_1 .. :try_end_1} :catch_0
    .catch Ljava/lang/InterruptedException; {:try_start_1 .. :try_end_1} :catch_1

    .line 129
    :cond_1
    :try_start_2
    invoke-virtual {v3}, Ljava/lang/Process;->waitFor()I
    :try_end_2
    .catch Ljava/lang/InterruptedException; {:try_start_2 .. :try_end_2} :catch_1
    .catch Ljava/io/IOException; {:try_start_2 .. :try_end_2} :catch_2

    move-result v0

    .line 135
    :try_start_3
    invoke-virtual {v4}, Ljava/io/DataOutputStream;->close()V
    :try_end_3
    .catch Ljava/io/IOException; {:try_start_3 .. :try_end_3} :catch_3
    .catch Ljava/lang/InterruptedException; {:try_start_3 .. :try_end_3} :catch_1

    .line 139
    :goto_1
    :try_start_4
    invoke-virtual {v5}, Lcom/a/a/a/c;->join()V

    .line 140
    invoke-virtual {v6}, Lcom/a/a/a/c;->join()V

    .line 141
    invoke-virtual {v3}, Ljava/lang/Process;->destroy()V
    :try_end_4
    .catch Ljava/lang/InterruptedException; {:try_start_4 .. :try_end_4} :catch_1
    .catch Ljava/io/IOException; {:try_start_4 .. :try_end_4} :catch_2

    .line 148
    :goto_2
    new-instance v3, Lcom/a/a/a/a;

    invoke-direct {v3, v1, v2, v0}, Lcom/a/a/a/a;-><init>(Ljava/util/List;Ljava/util/List;I)V

    return-object v3

    .line 116
    :catch_0
    move-exception v0

    .line 118
    :try_start_5
    invoke-virtual {v0}, Ljava/io/IOException;->getMessage()Ljava/lang/String;

    move-result-object v7

    const-string v8, "EPIPE"

    invoke-virtual {v7, v8}, Ljava/lang/String;->contains(Ljava/lang/CharSequence;)Z

    move-result v7

    if-nez v7, :cond_1

    .line 124
    throw v0
    :try_end_5
    .catch Ljava/lang/InterruptedException; {:try_start_5 .. :try_end_5} :catch_1
    .catch Ljava/io/IOException; {:try_start_5 .. :try_end_5} :catch_2

    .line 143
    :catch_1
    move-exception v0

    const/4 v0, -0x1

    .line 146
    goto :goto_2

    .line 145
    :catch_2
    move-exception v0

    const/4 v0, -0x4

    goto :goto_2

    :catch_3
    move-exception v4

    goto :goto_1
.end method
