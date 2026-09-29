.class public Lorg/apache/commons/mail/EmailException;
.super Ljava/lang/Exception;
.source "SourceFile"


# static fields
.field private static final serialVersionUID:J = 0x4d07f50c618d1678L


# direct methods
.method public constructor <init>()V
    .locals 0

    .prologue
    .line 46
    invoke-direct {p0}, Ljava/lang/Exception;-><init>()V

    .line 47
    return-void
.end method

.method public constructor <init>(Ljava/lang/String;)V
    .locals 0

    .prologue
    .line 57
    invoke-direct {p0, p1}, Ljava/lang/Exception;-><init>(Ljava/lang/String;)V

    .line 58
    return-void
.end method

.method public constructor <init>(Ljava/lang/String;Ljava/lang/Throwable;)V
    .locals 0

    .prologue
    .line 82
    invoke-direct {p0, p1, p2}, Ljava/lang/Exception;-><init>(Ljava/lang/String;Ljava/lang/Throwable;)V

    .line 83
    return-void
.end method

.method public constructor <init>(Ljava/lang/Throwable;)V
    .locals 0

    .prologue
    .line 69
    invoke-direct {p0, p1}, Ljava/lang/Exception;-><init>(Ljava/lang/Throwable;)V

    .line 70
    return-void
.end method


# virtual methods
.method public printStackTrace()V
    .locals 1

    .prologue
    .line 91
    sget-object v0, Ljava/lang/System;->err:Ljava/io/PrintStream;

    invoke-virtual {p0, v0}, Lorg/apache/commons/mail/EmailException;->printStackTrace(Ljava/io/PrintStream;)V

    .line 92
    return-void
.end method

.method public printStackTrace(Ljava/io/PrintStream;)V
    .locals 2

    .prologue
    .line 102
    monitor-enter p1

    .line 104
    :try_start_0
    new-instance v0, Ljava/io/PrintWriter;

    const/4 v1, 0x0

    invoke-direct {v0, p1, v1}, Ljava/io/PrintWriter;-><init>(Ljava/io/OutputStream;Z)V

    .line 105
    invoke-virtual {p0, v0}, Lorg/apache/commons/mail/EmailException;->printStackTrace(Ljava/io/PrintWriter;)V

    .line 108
    invoke-virtual {v0}, Ljava/io/PrintWriter;->flush()V

    .line 109
    monitor-exit p1

    .line 110
    return-void

    .line 109
    :catchall_0
    move-exception v0

    monitor-exit p1
    :try_end_0
    .catchall {:try_start_0 .. :try_end_0} :catchall_0

    throw v0
.end method

.method public printStackTrace(Ljava/io/PrintWriter;)V
    .locals 1

    .prologue
    .line 120
    monitor-enter p1

    .line 122
    :try_start_0
    invoke-super {p0, p1}, Ljava/lang/Exception;->printStackTrace(Ljava/io/PrintWriter;)V

    .line 123
    monitor-exit p1

    .line 124
    return-void

    .line 123
    :catchall_0
    move-exception v0

    monitor-exit p1
    :try_end_0
    .catchall {:try_start_0 .. :try_end_0} :catchall_0

    throw v0
.end method
