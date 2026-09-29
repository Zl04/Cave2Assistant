.class Lcom/umeng/commonsdk/framework/d$2;
.super Landroid/os/Handler;
.source "UMNetWorkSender.java"


# annotations
.annotation system Ldalvik/annotation/EnclosingMethod;
    value = Lcom/umeng/commonsdk/framework/d;-><init>(Landroid/content/Context;Landroid/os/Handler;)V
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x0
    name = null
.end annotation


# instance fields
.field final synthetic a:Lcom/umeng/commonsdk/framework/d;


# direct methods
.method constructor <init>(Lcom/umeng/commonsdk/framework/d;Landroid/os/Looper;)V
    .locals 0

    .prologue
    .line 138
    iput-object p1, p0, Lcom/umeng/commonsdk/framework/d$2;->a:Lcom/umeng/commonsdk/framework/d;

    invoke-direct {p0, p2}, Landroid/os/Handler;-><init>(Landroid/os/Looper;)V

    return-void
.end method


# virtual methods
.method public handleMessage(Landroid/os/Message;)V
    .locals 1

    .prologue
    .line 141
    iget v0, p1, Landroid/os/Message;->what:I

    sparse-switch v0, :sswitch_data_0

    .line 155
    :goto_0
    return-void

    .line 143
    :sswitch_0
    const-string v0, "--->>> handleMessage: recv MSG_PROCESS_NEXT msg."

    invoke-static {v0}, Lcom/umeng/commonsdk/statistics/common/e;->b(Ljava/lang/String;)V

    .line 144
    invoke-static {}, Lcom/umeng/commonsdk/framework/d;->f()V

    goto :goto_0

    .line 148
    :sswitch_1
    invoke-static {}, Lcom/umeng/commonsdk/framework/d;->g()V

    goto :goto_0

    .line 141
    nop

    :sswitch_data_0
    .sparse-switch
        0x111 -> :sswitch_0
        0x200 -> :sswitch_1
    .end sparse-switch
.end method
