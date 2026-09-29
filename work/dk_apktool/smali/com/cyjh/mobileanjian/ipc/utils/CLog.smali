.class public final Lcom/cyjh/mobileanjian/ipc/utils/CLog;
.super Ljava/lang/Object;
.source "SourceFile"


# static fields
.field private static final a:Z = false

.field private static final b:Ljava/lang/String; = "IPC_ANDROID"


# direct methods
.method public constructor <init>()V
    .locals 0

    .prologue
    .line 7
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method

.method private static a()Ljava/lang/String;
    .locals 6

    .prologue
    .line 23
    invoke-static {}, Ljava/lang/Thread;->currentThread()Ljava/lang/Thread;

    move-result-object v0

    invoke-virtual {v0}, Ljava/lang/Thread;->getStackTrace()[Ljava/lang/StackTraceElement;

    move-result-object v1

    .line 24
    array-length v2, v1

    const/4 v0, 0x0

    :goto_0
    if-ge v0, v2, :cond_2

    aget-object v3, v1, v0

    .line 25
    invoke-virtual {v3}, Ljava/lang/StackTraceElement;->isNativeMethod()Z

    move-result v4

    if-eqz v4, :cond_1

    .line 24
    :cond_0
    add-int/lit8 v0, v0, 0x1

    goto :goto_0

    .line 29
    :cond_1
    invoke-virtual {v3}, Ljava/lang/StackTraceElement;->getClassName()Ljava/lang/String;

    move-result-object v4

    const-class v5, Ljava/lang/Thread;

    invoke-virtual {v5}, Ljava/lang/Class;->getName()Ljava/lang/String;

    move-result-object v5

    invoke-virtual {v4, v5}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v4

    if-nez v4, :cond_0

    .line 33
    invoke-virtual {v3}, Ljava/lang/StackTraceElement;->getClassName()Ljava/lang/String;

    move-result-object v4

    const-class v5, Lcom/cyjh/mobileanjian/ipc/utils/CLog;

    invoke-virtual {v5}, Ljava/lang/Class;->getName()Ljava/lang/String;

    move-result-object v5

    invoke-virtual {v4, v5}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v4

    if-nez v4, :cond_0

    .line 37
    new-instance v0, Ljava/lang/StringBuilder;

    invoke-direct {v0}, Ljava/lang/StringBuilder;-><init>()V

    const-string v1, "("

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-virtual {v3}, Ljava/lang/StackTraceElement;->getFileName()Ljava/lang/String;

    move-result-object v1

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    const-string v1, ":"

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-virtual {v3}, Ljava/lang/StackTraceElement;->getLineNumber()I

    move-result v1

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v0

    const-string v1, ")"

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-virtual {v0}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v0

    .line 40
    :goto_1
    return-object v0

    :cond_2
    const/4 v0, 0x0

    goto :goto_1
.end method

.method public static d(Ljava/lang/String;)V
    .locals 1

    .prologue
    .line 93
    const-string v0, "IPC_ANDROID"

    invoke-static {v0, p0}, Lcom/cyjh/mobileanjian/ipc/utils/CLog;->d(Ljava/lang/String;Ljava/lang/String;)V

    .line 94
    return-void
.end method

.method public static d(Ljava/lang/String;Ljava/lang/String;)V
    .locals 0

    .prologue
    .line 65
    return-void
.end method

.method public static e(Ljava/lang/String;)V
    .locals 1

    .prologue
    .line 83
    const-string v0, "IPC_ANDROID"

    invoke-static {v0, p0}, Lcom/cyjh/mobileanjian/ipc/utils/CLog;->e(Ljava/lang/String;Ljava/lang/String;)V

    .line 84
    return-void
.end method

.method public static e(Ljava/lang/String;Ljava/lang/String;)V
    .locals 0

    .prologue
    .line 53
    return-void
.end method

.method public static i(Ljava/lang/String;)V
    .locals 1

    .prologue
    .line 98
    const-string v0, "IPC_ANDROID"

    invoke-static {v0, p0}, Lcom/cyjh/mobileanjian/ipc/utils/CLog;->i(Ljava/lang/String;Ljava/lang/String;)V

    .line 99
    return-void
.end method

.method public static i(Ljava/lang/String;Ljava/lang/String;)V
    .locals 0

    .prologue
    .line 71
    return-void
.end method

.method public static isDebug()Z
    .locals 1

    .prologue
    .line 14
    const/4 v0, 0x0

    return v0
.end method

.method public static v(Ljava/lang/String;)V
    .locals 1

    .prologue
    .line 78
    const-string v0, "IPC_ANDROID"

    invoke-static {v0, p0}, Lcom/cyjh/mobileanjian/ipc/utils/CLog;->v(Ljava/lang/String;Ljava/lang/String;)V

    .line 79
    return-void
.end method

.method public static v(Ljava/lang/String;Ljava/lang/String;)V
    .locals 0

    .prologue
    .line 47
    return-void
.end method

.method public static w(Ljava/lang/String;)V
    .locals 1

    .prologue
    .line 88
    const-string v0, "IPC_ANDROID"

    invoke-static {v0, p0}, Lcom/cyjh/mobileanjian/ipc/utils/CLog;->w(Ljava/lang/String;Ljava/lang/String;)V

    .line 89
    return-void
.end method

.method public static w(Ljava/lang/String;Ljava/lang/String;)V
    .locals 0

    .prologue
    .line 59
    return-void
.end method
