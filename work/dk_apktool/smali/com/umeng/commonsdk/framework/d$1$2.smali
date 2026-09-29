.class Lcom/umeng/commonsdk/framework/d$1$2;
.super Ljava/lang/Object;
.source "UMNetWorkSender.java"

# interfaces
.implements Ljava/lang/Runnable;


# annotations
.annotation system Ldalvik/annotation/EnclosingMethod;
    value = Lcom/umeng/commonsdk/framework/d$1;->onReceive(Landroid/content/Context;Landroid/content/Intent;)V
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x0
    name = null
.end annotation


# instance fields
.field final synthetic a:Landroid/content/Context;

.field final synthetic b:Lcom/umeng/commonsdk/framework/d$1;


# direct methods
.method constructor <init>(Lcom/umeng/commonsdk/framework/d$1;Landroid/content/Context;)V
    .locals 0

    .prologue
    .line 80
    iput-object p1, p0, Lcom/umeng/commonsdk/framework/d$1$2;->b:Lcom/umeng/commonsdk/framework/d$1;

    iput-object p2, p0, Lcom/umeng/commonsdk/framework/d$1$2;->a:Landroid/content/Context;

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method


# virtual methods
.method public run()V
    .locals 2

    .prologue
    .line 84
    :try_start_0
    iget-object v0, p0, Lcom/umeng/commonsdk/framework/d$1$2;->a:Landroid/content/Context;

    invoke-static {v0}, Lcom/umeng/commonsdk/proguard/u;->a(Landroid/content/Context;)V
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_0

    .line 88
    :goto_0
    return-void

    .line 85
    :catch_0
    move-exception v0

    .line 86
    iget-object v1, p0, Lcom/umeng/commonsdk/framework/d$1$2;->a:Landroid/content/Context;

    invoke-static {v1, v0}, Lcom/umeng/commonsdk/proguard/e;->a(Landroid/content/Context;Ljava/lang/Throwable;)V

    goto :goto_0
.end method
