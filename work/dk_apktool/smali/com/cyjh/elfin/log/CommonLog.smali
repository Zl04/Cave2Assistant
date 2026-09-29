.class public Lcom/cyjh/elfin/log/CommonLog;
.super Ljava/lang/Object;
.source "CommonLog.java"


# instance fields
.field private isDebug:Z

.field private tag:Ljava/lang/String;


# direct methods
.method public constructor <init>()V
    .locals 1

    .prologue
    .line 8
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    .line 10
    const-string v0, "Elfin"

    iput-object v0, p0, Lcom/cyjh/elfin/log/CommonLog;->tag:Ljava/lang/String;

    .line 11
    invoke-static {}, Lcom/cyjh/elfin/constant/MyBuildConfig;->isOutputLog()Z

    move-result v0

    iput-boolean v0, p0, Lcom/cyjh/elfin/log/CommonLog;->isDebug:Z

    return-void
.end method

.method private debug(Ljava/lang/Object;)V
    .locals 2
    .param p1, "str"    # Ljava/lang/Object;

    .prologue
    .line 44
    iget-object v0, p0, Lcom/cyjh/elfin/log/CommonLog;->tag:Ljava/lang/String;

    invoke-direct {p0, p1}, Lcom/cyjh/elfin/log/CommonLog;->getMeg(Ljava/lang/Object;)Ljava/lang/String;

    move-result-object v1

    invoke-static {v0, v1}, Landroid/util/Log;->d(Ljava/lang/String;Ljava/lang/String;)I

    .line 45
    return-void
.end method

.method private error(Ljava/lang/Object;)V
    .locals 2
    .param p1, "str"    # Ljava/lang/Object;

    .prologue
    .line 56
    iget-object v0, p0, Lcom/cyjh/elfin/log/CommonLog;->tag:Ljava/lang/String;

    invoke-direct {p0, p1}, Lcom/cyjh/elfin/log/CommonLog;->getMeg(Ljava/lang/Object;)Ljava/lang/String;

    move-result-object v1

    invoke-static {v0, v1}, Landroid/util/Log;->e(Ljava/lang/String;Ljava/lang/String;)I

    .line 57
    return-void
.end method

.method private getFunctionName()Ljava/lang/String;
    .locals 7

    .prologue
    const/4 v2, 0x0

    .line 14
    invoke-static {}, Ljava/lang/Thread;->currentThread()Ljava/lang/Thread;

    move-result-object v3

    invoke-virtual {v3}, Ljava/lang/Thread;->getStackTrace()[Ljava/lang/StackTraceElement;

    move-result-object v1

    .line 16
    .local v1, "sts":[Ljava/lang/StackTraceElement;
    if-nez v1, :cond_1

    .line 36
    :cond_0
    :goto_0
    return-object v2

    .line 20
    :cond_1
    array-length v4, v1

    const/4 v3, 0x0

    :goto_1
    if-ge v3, v4, :cond_0

    aget-object v0, v1, v3

    .line 21
    .local v0, "st":Ljava/lang/StackTraceElement;
    invoke-virtual {v0}, Ljava/lang/StackTraceElement;->isNativeMethod()Z

    move-result v5

    if-eqz v5, :cond_3

    .line 20
    :cond_2
    add-int/lit8 v3, v3, 0x1

    goto :goto_1

    .line 25
    :cond_3
    invoke-virtual {v0}, Ljava/lang/StackTraceElement;->getClassName()Ljava/lang/String;

    move-result-object v5

    const-class v6, Ljava/lang/Thread;

    invoke-virtual {v6}, Ljava/lang/Class;->getName()Ljava/lang/String;

    move-result-object v6

    invoke-virtual {v5, v6}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v5

    if-nez v5, :cond_2

    .line 29
    invoke-virtual {v0}, Ljava/lang/StackTraceElement;->getClassName()Ljava/lang/String;

    move-result-object v5

    invoke-virtual {p0}, Ljava/lang/Object;->getClass()Ljava/lang/Class;

    move-result-object v6

    invoke-virtual {v6}, Ljava/lang/Class;->getName()Ljava/lang/String;

    move-result-object v6

    invoke-virtual {v5, v6}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v5

    if-nez v5, :cond_2

    .line 33
    new-instance v2, Ljava/lang/StringBuilder;

    invoke-direct {v2}, Ljava/lang/StringBuilder;-><init>()V

    const-string v3, "["

    invoke-virtual {v2, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    invoke-static {}, Ljava/lang/Thread;->currentThread()Ljava/lang/Thread;

    move-result-object v3

    invoke-virtual {v3}, Ljava/lang/Thread;->getId()J

    move-result-wide v4

    invoke-virtual {v2, v4, v5}, Ljava/lang/StringBuilder;->append(J)Ljava/lang/StringBuilder;

    move-result-object v2

    const-string v3, ": "

    invoke-virtual {v2, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    invoke-virtual {v0}, Ljava/lang/StackTraceElement;->getFileName()Ljava/lang/String;

    move-result-object v3

    invoke-virtual {v2, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    const-string v3, ":"

    invoke-virtual {v2, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    invoke-virtual {v0}, Ljava/lang/StackTraceElement;->getLineNumber()I

    move-result v3

    invoke-virtual {v2, v3}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v2

    const-string v3, "]"

    invoke-virtual {v2, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    invoke-virtual {v2}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v2

    goto :goto_0
.end method

.method private getMeg(Ljava/lang/Object;)Ljava/lang/String;
    .locals 4
    .param p1, "str"    # Ljava/lang/Object;

    .prologue
    .line 60
    invoke-direct {p0}, Lcom/cyjh/elfin/log/CommonLog;->getFunctionName()Ljava/lang/String;

    move-result-object v1

    .line 61
    .local v1, "name":Ljava/lang/String;
    if-nez v1, :cond_0

    invoke-virtual {p1}, Ljava/lang/Object;->toString()Ljava/lang/String;

    move-result-object v0

    .line 62
    .local v0, "ls":Ljava/lang/String;
    :goto_0
    return-object v0

    .line 61
    .end local v0    # "ls":Ljava/lang/String;
    :cond_0
    new-instance v2, Ljava/lang/StringBuilder;

    invoke-direct {v2}, Ljava/lang/StringBuilder;-><init>()V

    invoke-virtual {v2, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    const-string v3, " >>>>"

    invoke-virtual {v2, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    invoke-virtual {v2, p1}, Ljava/lang/StringBuilder;->append(Ljava/lang/Object;)Ljava/lang/StringBuilder;

    move-result-object v2

    invoke-virtual {v2}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v0

    goto :goto_0
.end method

.method private info(Ljava/lang/Object;)V
    .locals 2
    .param p1, "str"    # Ljava/lang/Object;

    .prologue
    .line 48
    iget-object v0, p0, Lcom/cyjh/elfin/log/CommonLog;->tag:Ljava/lang/String;

    invoke-direct {p0, p1}, Lcom/cyjh/elfin/log/CommonLog;->getMeg(Ljava/lang/Object;)Ljava/lang/String;

    move-result-object v1

    invoke-static {v0, v1}, Landroid/util/Log;->i(Ljava/lang/String;Ljava/lang/String;)I

    .line 49
    return-void
.end method

.method private verbose(Ljava/lang/Object;)V
    .locals 2
    .param p1, "str"    # Ljava/lang/Object;

    .prologue
    .line 40
    iget-object v0, p0, Lcom/cyjh/elfin/log/CommonLog;->tag:Ljava/lang/String;

    invoke-direct {p0, p1}, Lcom/cyjh/elfin/log/CommonLog;->getMeg(Ljava/lang/Object;)Ljava/lang/String;

    move-result-object v1

    invoke-static {v0, v1}, Landroid/util/Log;->v(Ljava/lang/String;Ljava/lang/String;)I

    .line 41
    return-void
.end method

.method private warn(Ljava/lang/Object;)V
    .locals 2
    .param p1, "str"    # Ljava/lang/Object;

    .prologue
    .line 52
    iget-object v0, p0, Lcom/cyjh/elfin/log/CommonLog;->tag:Ljava/lang/String;

    invoke-direct {p0, p1}, Lcom/cyjh/elfin/log/CommonLog;->getMeg(Ljava/lang/Object;)Ljava/lang/String;

    move-result-object v1

    invoke-static {v0, v1}, Landroid/util/Log;->w(Ljava/lang/String;Ljava/lang/String;)I

    .line 53
    return-void
.end method


# virtual methods
.method public d(Ljava/lang/Object;)V
    .locals 1
    .param p1, "str"    # Ljava/lang/Object;

    .prologue
    .line 82
    iget-boolean v0, p0, Lcom/cyjh/elfin/log/CommonLog;->isDebug:Z

    if-eqz v0, :cond_0

    .line 83
    invoke-direct {p0, p1}, Lcom/cyjh/elfin/log/CommonLog;->debug(Ljava/lang/Object;)V

    .line 85
    :cond_0
    return-void
.end method

.method public d(Ljava/lang/String;Ljava/lang/Object;)V
    .locals 1
    .param p1, "tag"    # Ljava/lang/String;
    .param p2, "str"    # Ljava/lang/Object;

    .prologue
    .line 88
    iput-object p1, p0, Lcom/cyjh/elfin/log/CommonLog;->tag:Ljava/lang/String;

    .line 89
    iget-boolean v0, p0, Lcom/cyjh/elfin/log/CommonLog;->isDebug:Z

    if-eqz v0, :cond_0

    .line 90
    invoke-direct {p0, p2}, Lcom/cyjh/elfin/log/CommonLog;->debug(Ljava/lang/Object;)V

    .line 92
    :cond_0
    return-void
.end method

.method public e(Ljava/lang/Object;)V
    .locals 1
    .param p1, "str"    # Ljava/lang/Object;

    .prologue
    .line 121
    iget-boolean v0, p0, Lcom/cyjh/elfin/log/CommonLog;->isDebug:Z

    if-eqz v0, :cond_0

    .line 122
    invoke-direct {p0, p1}, Lcom/cyjh/elfin/log/CommonLog;->error(Ljava/lang/Object;)V

    .line 124
    :cond_0
    return-void
.end method

.method public e(Ljava/lang/String;Ljava/lang/Object;)V
    .locals 1
    .param p1, "tag"    # Ljava/lang/String;
    .param p2, "str"    # Ljava/lang/Object;

    .prologue
    .line 127
    iput-object p1, p0, Lcom/cyjh/elfin/log/CommonLog;->tag:Ljava/lang/String;

    .line 128
    iget-boolean v0, p0, Lcom/cyjh/elfin/log/CommonLog;->isDebug:Z

    if-eqz v0, :cond_0

    .line 129
    invoke-direct {p0, p2}, Lcom/cyjh/elfin/log/CommonLog;->error(Ljava/lang/Object;)V

    .line 131
    :cond_0
    return-void
.end method

.method public i(Ljava/lang/Object;)V
    .locals 1
    .param p1, "str"    # Ljava/lang/Object;

    .prologue
    .line 95
    iget-boolean v0, p0, Lcom/cyjh/elfin/log/CommonLog;->isDebug:Z

    if-eqz v0, :cond_0

    .line 96
    invoke-direct {p0, p1}, Lcom/cyjh/elfin/log/CommonLog;->info(Ljava/lang/Object;)V

    .line 98
    :cond_0
    return-void
.end method

.method public i(Ljava/lang/String;Ljava/lang/Object;)V
    .locals 1
    .param p1, "tag"    # Ljava/lang/String;
    .param p2, "str"    # Ljava/lang/Object;

    .prologue
    .line 101
    iput-object p1, p0, Lcom/cyjh/elfin/log/CommonLog;->tag:Ljava/lang/String;

    .line 102
    iget-boolean v0, p0, Lcom/cyjh/elfin/log/CommonLog;->isDebug:Z

    if-eqz v0, :cond_0

    .line 103
    invoke-direct {p0, p2}, Lcom/cyjh/elfin/log/CommonLog;->info(Ljava/lang/Object;)V

    .line 105
    :cond_0
    return-void
.end method

.method public v(Ljava/lang/Object;)V
    .locals 1
    .param p1, "str"    # Ljava/lang/Object;

    .prologue
    .line 69
    iget-boolean v0, p0, Lcom/cyjh/elfin/log/CommonLog;->isDebug:Z

    if-eqz v0, :cond_0

    .line 70
    invoke-direct {p0, p1}, Lcom/cyjh/elfin/log/CommonLog;->verbose(Ljava/lang/Object;)V

    .line 72
    :cond_0
    return-void
.end method

.method public v(Ljava/lang/String;Ljava/lang/Object;)V
    .locals 1
    .param p1, "tag"    # Ljava/lang/String;
    .param p2, "str"    # Ljava/lang/Object;

    .prologue
    .line 75
    iput-object p1, p0, Lcom/cyjh/elfin/log/CommonLog;->tag:Ljava/lang/String;

    .line 76
    iget-boolean v0, p0, Lcom/cyjh/elfin/log/CommonLog;->isDebug:Z

    if-eqz v0, :cond_0

    .line 77
    invoke-direct {p0, p2}, Lcom/cyjh/elfin/log/CommonLog;->verbose(Ljava/lang/Object;)V

    .line 79
    :cond_0
    return-void
.end method

.method public w(Ljava/lang/Object;)V
    .locals 1
    .param p1, "str"    # Ljava/lang/Object;

    .prologue
    .line 108
    iget-boolean v0, p0, Lcom/cyjh/elfin/log/CommonLog;->isDebug:Z

    if-eqz v0, :cond_0

    .line 109
    invoke-direct {p0, p1}, Lcom/cyjh/elfin/log/CommonLog;->warn(Ljava/lang/Object;)V

    .line 111
    :cond_0
    return-void
.end method

.method public w(Ljava/lang/String;Ljava/lang/Object;)V
    .locals 1
    .param p1, "tag"    # Ljava/lang/String;
    .param p2, "str"    # Ljava/lang/Object;

    .prologue
    .line 114
    iput-object p1, p0, Lcom/cyjh/elfin/log/CommonLog;->tag:Ljava/lang/String;

    .line 115
    iget-boolean v0, p0, Lcom/cyjh/elfin/log/CommonLog;->isDebug:Z

    if-eqz v0, :cond_0

    .line 116
    invoke-direct {p0, p2}, Lcom/cyjh/elfin/log/CommonLog;->warn(Ljava/lang/Object;)V

    .line 118
    :cond_0
    return-void
.end method
