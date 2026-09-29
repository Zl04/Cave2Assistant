.class Lcom/umeng/commonsdk/framework/d$1$1;
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
    .line 59
    iput-object p1, p0, Lcom/umeng/commonsdk/framework/d$1$1;->b:Lcom/umeng/commonsdk/framework/d$1;

    iput-object p2, p0, Lcom/umeng/commonsdk/framework/d$1$1;->a:Landroid/content/Context;

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method


# virtual methods
.method public run()V
    .locals 1

    .prologue
    .line 62
    iget-object v0, p0, Lcom/umeng/commonsdk/framework/d$1$1;->a:Landroid/content/Context;

    invoke-static {v0}, Lcom/umeng/commonsdk/proguard/j;->d(Landroid/content/Context;)V

    .line 63
    return-void
.end method
