.class public Lcom/cyjh/mqm/MQLanguageStub;
.super Ljava/lang/Object;
.source "SourceFile"


# annotations
.annotation system Ldalvik/annotation/MemberClasses;
    value = {
        Lcom/cyjh/mqm/MQLanguageStub$MQAuxiliary;
    }
.end annotation


# instance fields
.field private volatile m_RunnerPointer:J


# direct methods
.method public constructor <init>()V
    .locals 2

    .prologue
    .line 5
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    .line 13
    const-wide/16 v0, 0x0

    iput-wide v0, p0, Lcom/cyjh/mqm/MQLanguageStub;->m_RunnerPointer:J

    return-void
.end method


# virtual methods
.method public DebugMessage([B)[B
    .locals 1

    .prologue
    .line 27
    invoke-static {p1}, Lcom/cyjh/event/a;->a([B)[B

    move-result-object v0

    return-object v0
.end method

.method public native Pause()I
.end method

.method public native Resume()I
.end method

.method public native Run(Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;IIJ)I
.end method

.method public native SetLocalDir(Ljava/lang/String;Ljava/lang/String;)V
.end method

.method public native Stop()I
.end method

.method public declared-synchronized getRunner()J
    .locals 2

    .prologue
    .line 17
    monitor-enter p0

    :try_start_0
    iget-wide v0, p0, Lcom/cyjh/mqm/MQLanguageStub;->m_RunnerPointer:J
    :try_end_0
    .catchall {:try_start_0 .. :try_end_0} :catchall_0

    monitor-exit p0

    return-wide v0

    :catchall_0
    move-exception v0

    monitor-exit p0

    throw v0
.end method

.method public declared-synchronized setRunner(J)V
    .locals 1

    .prologue
    .line 22
    monitor-enter p0

    :try_start_0
    iput-wide p1, p0, Lcom/cyjh/mqm/MQLanguageStub;->m_RunnerPointer:J
    :try_end_0
    .catchall {:try_start_0 .. :try_end_0} :catchall_0

    .line 23
    monitor-exit p0

    return-void

    .line 22
    :catchall_0
    move-exception v0

    monitor-exit p0

    throw v0
.end method
