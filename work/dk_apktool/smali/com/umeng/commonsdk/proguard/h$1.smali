.class final Lcom/umeng/commonsdk/proguard/h$1;
.super Ljava/lang/Object;
.source "UMSysLocationCache.java"

# interfaces
.implements Ljava/lang/Runnable;


# annotations
.annotation system Ldalvik/annotation/EnclosingMethod;
    value = Lcom/umeng/commonsdk/proguard/h;->a(Landroid/content/Context;)V
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x8
    name = null
.end annotation


# instance fields
.field final synthetic a:Landroid/content/Context;


# direct methods
.method constructor <init>(Landroid/content/Context;)V
    .locals 0

    .prologue
    .line 57
    iput-object p1, p0, Lcom/umeng/commonsdk/proguard/h$1;->a:Landroid/content/Context;

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method


# virtual methods
.method public run()V
    .locals 2

    .prologue
    .line 61
    :try_start_0
    invoke-static {}, Landroid/os/Looper;->prepare()V

    .line 63
    new-instance v0, Lcom/umeng/commonsdk/proguard/g;

    iget-object v1, p0, Lcom/umeng/commonsdk/proguard/h$1;->a:Landroid/content/Context;

    invoke-direct {v0, v1}, Lcom/umeng/commonsdk/proguard/g;-><init>(Landroid/content/Context;)V

    .line 64
    new-instance v1, Lcom/umeng/commonsdk/proguard/h$1$1;

    invoke-direct {v1, p0, v0}, Lcom/umeng/commonsdk/proguard/h$1$1;-><init>(Lcom/umeng/commonsdk/proguard/h$1;Lcom/umeng/commonsdk/proguard/g;)V

    invoke-virtual {v0, v1}, Lcom/umeng/commonsdk/proguard/g;->a(Lcom/umeng/commonsdk/proguard/i;)V

    .line 105
    invoke-static {}, Landroid/os/Looper;->loop()V
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_0

    .line 109
    :goto_0
    return-void

    .line 106
    :catch_0
    move-exception v0

    .line 107
    iget-object v1, p0, Lcom/umeng/commonsdk/proguard/h$1;->a:Landroid/content/Context;

    invoke-static {v1, v0}, Lcom/umeng/commonsdk/proguard/e;->a(Landroid/content/Context;Ljava/lang/Throwable;)V

    goto :goto_0
.end method
