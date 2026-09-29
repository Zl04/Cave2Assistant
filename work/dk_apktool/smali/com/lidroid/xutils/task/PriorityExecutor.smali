.class public Lcom/lidroid/xutils/task/PriorityExecutor;
.super Ljava/lang/Object;
.source "SourceFile"

# interfaces
.implements Ljava/util/concurrent/Executor;


# static fields
.field private static final CORE_POOL_SIZE:I = 0x5

.field private static final KEEP_ALIVE:I = 0x1

.field private static final MAXIMUM_POOL_SIZE:I = 0x100

.field private static final sThreadFactory:Ljava/util/concurrent/ThreadFactory;


# instance fields
.field private final mPoolWorkQueue:Ljava/util/concurrent/BlockingQueue;
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "Ljava/util/concurrent/BlockingQueue",
            "<",
            "Ljava/lang/Runnable;",
            ">;"
        }
    .end annotation
.end field

.field private final mThreadPoolExecutor:Ljava/util/concurrent/ThreadPoolExecutor;


# direct methods
.method static constructor <clinit>()V
    .locals 1

    .prologue
    .line 17
    new-instance v0, Lcom/lidroid/xutils/task/PriorityExecutor$1;

    invoke-direct {v0}, Lcom/lidroid/xutils/task/PriorityExecutor$1;-><init>()V

    sput-object v0, Lcom/lidroid/xutils/task/PriorityExecutor;->sThreadFactory:Ljava/util/concurrent/ThreadFactory;

    .line 24
    return-void
.end method

.method public constructor <init>()V
    .locals 1

    .prologue
    .line 30
    const/4 v0, 0x5

    invoke-direct {p0, v0}, Lcom/lidroid/xutils/task/PriorityExecutor;-><init>(I)V

    .line 31
    return-void
.end method

.method public constructor <init>(I)V
    .locals 9

    .prologue
    .line 33
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    .line 26
    new-instance v0, Lcom/lidroid/xutils/task/PriorityObjectBlockingQueue;

    invoke-direct {v0}, Lcom/lidroid/xutils/task/PriorityObjectBlockingQueue;-><init>()V

    iput-object v0, p0, Lcom/lidroid/xutils/task/PriorityExecutor;->mPoolWorkQueue:Ljava/util/concurrent/BlockingQueue;

    .line 34
    new-instance v1, Ljava/util/concurrent/ThreadPoolExecutor;

    .line 36
    const/16 v3, 0x100

    .line 37
    const-wide/16 v4, 0x1

    .line 38
    sget-object v6, Ljava/util/concurrent/TimeUnit;->SECONDS:Ljava/util/concurrent/TimeUnit;

    .line 39
    iget-object v7, p0, Lcom/lidroid/xutils/task/PriorityExecutor;->mPoolWorkQueue:Ljava/util/concurrent/BlockingQueue;

    .line 40
    sget-object v8, Lcom/lidroid/xutils/task/PriorityExecutor;->sThreadFactory:Ljava/util/concurrent/ThreadFactory;

    move v2, p1

    invoke-direct/range {v1 .. v8}, Ljava/util/concurrent/ThreadPoolExecutor;-><init>(IIJLjava/util/concurrent/TimeUnit;Ljava/util/concurrent/BlockingQueue;Ljava/util/concurrent/ThreadFactory;)V

    .line 34
    iput-object v1, p0, Lcom/lidroid/xutils/task/PriorityExecutor;->mThreadPoolExecutor:Ljava/util/concurrent/ThreadPoolExecutor;

    .line 41
    return-void
.end method


# virtual methods
.method public execute(Ljava/lang/Runnable;)V
    .locals 1

    .prologue
    .line 59
    iget-object v0, p0, Lcom/lidroid/xutils/task/PriorityExecutor;->mThreadPoolExecutor:Ljava/util/concurrent/ThreadPoolExecutor;

    invoke-virtual {v0, p1}, Ljava/util/concurrent/ThreadPoolExecutor;->execute(Ljava/lang/Runnable;)V

    .line 60
    return-void
.end method

.method public getPoolSize()I
    .locals 1

    .prologue
    .line 44
    iget-object v0, p0, Lcom/lidroid/xutils/task/PriorityExecutor;->mThreadPoolExecutor:Ljava/util/concurrent/ThreadPoolExecutor;

    invoke-virtual {v0}, Ljava/util/concurrent/ThreadPoolExecutor;->getCorePoolSize()I

    move-result v0

    return v0
.end method

.method public isBusy()Z
    .locals 2

    .prologue
    .line 54
    iget-object v0, p0, Lcom/lidroid/xutils/task/PriorityExecutor;->mThreadPoolExecutor:Ljava/util/concurrent/ThreadPoolExecutor;

    invoke-virtual {v0}, Ljava/util/concurrent/ThreadPoolExecutor;->getActiveCount()I

    move-result v0

    iget-object v1, p0, Lcom/lidroid/xutils/task/PriorityExecutor;->mThreadPoolExecutor:Ljava/util/concurrent/ThreadPoolExecutor;

    invoke-virtual {v1}, Ljava/util/concurrent/ThreadPoolExecutor;->getCorePoolSize()I

    move-result v1

    if-lt v0, v1, :cond_0

    const/4 v0, 0x1

    :goto_0
    return v0

    :cond_0
    const/4 v0, 0x0

    goto :goto_0
.end method

.method public setPoolSize(I)V
    .locals 1

    .prologue
    .line 48
    if-lez p1, :cond_0

    .line 49
    iget-object v0, p0, Lcom/lidroid/xutils/task/PriorityExecutor;->mThreadPoolExecutor:Ljava/util/concurrent/ThreadPoolExecutor;

    invoke-virtual {v0, p1}, Ljava/util/concurrent/ThreadPoolExecutor;->setCorePoolSize(I)V

    .line 51
    :cond_0
    return-void
.end method
