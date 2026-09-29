.class public Lcom/umeng/commonsdk/proguard/e;
.super Ljava/lang/Object;
.source "UMCrashManager.java"


# direct methods
.method public constructor <init>()V
    .locals 0

    .prologue
    .line 19
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method

.method public static a(Landroid/content/Context;Ljava/lang/Throwable;)V
    .locals 2

    .prologue
    .line 22
    new-instance v0, Ljava/lang/Thread;

    new-instance v1, Lcom/umeng/commonsdk/proguard/e$1;

    invoke-direct {v1, p0, p1}, Lcom/umeng/commonsdk/proguard/e$1;-><init>(Landroid/content/Context;Ljava/lang/Throwable;)V

    invoke-direct {v0, v1}, Ljava/lang/Thread;-><init>(Ljava/lang/Runnable;)V

    .line 56
    invoke-virtual {v0}, Ljava/lang/Thread;->start()V

    .line 57
    return-void
.end method
