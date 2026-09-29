.class Lcom/cyjh/elfin/activity/ElfinFreeActivity$MainHandler;
.super Landroid/os/Handler;
.source "ElfinFreeActivity.java"


# annotations
.annotation system Ldalvik/annotation/EnclosingClass;
    value = Lcom/cyjh/elfin/activity/ElfinFreeActivity;
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0xa
    name = "MainHandler"
.end annotation


# instance fields
.field private mActivity:Ljava/lang/ref/WeakReference;
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "Ljava/lang/ref/WeakReference",
            "<",
            "Lcom/cyjh/elfin/activity/ElfinFreeActivity;",
            ">;"
        }
    .end annotation
.end field


# direct methods
.method private constructor <init>(Lcom/cyjh/elfin/activity/ElfinFreeActivity;)V
    .locals 1
    .param p1, "activity"    # Lcom/cyjh/elfin/activity/ElfinFreeActivity;

    .prologue
    .line 456
    invoke-direct {p0}, Landroid/os/Handler;-><init>()V

    .line 457
    new-instance v0, Ljava/lang/ref/WeakReference;

    invoke-direct {v0, p1}, Ljava/lang/ref/WeakReference;-><init>(Ljava/lang/Object;)V

    iput-object v0, p0, Lcom/cyjh/elfin/activity/ElfinFreeActivity$MainHandler;->mActivity:Ljava/lang/ref/WeakReference;

    .line 458
    return-void
.end method

.method synthetic constructor <init>(Lcom/cyjh/elfin/activity/ElfinFreeActivity;Lcom/cyjh/elfin/activity/ElfinFreeActivity$1;)V
    .locals 0
    .param p1, "x0"    # Lcom/cyjh/elfin/activity/ElfinFreeActivity;
    .param p2, "x1"    # Lcom/cyjh/elfin/activity/ElfinFreeActivity$1;

    .prologue
    .line 454
    invoke-direct {p0, p1}, Lcom/cyjh/elfin/activity/ElfinFreeActivity$MainHandler;-><init>(Lcom/cyjh/elfin/activity/ElfinFreeActivity;)V

    return-void
.end method


# virtual methods
.method public handleMessage(Landroid/os/Message;)V
    .locals 3
    .param p1, "msg"    # Landroid/os/Message;

    .prologue
    .line 461
    iget-object v2, p0, Lcom/cyjh/elfin/activity/ElfinFreeActivity$MainHandler;->mActivity:Ljava/lang/ref/WeakReference;

    invoke-virtual {v2}, Ljava/lang/ref/WeakReference;->get()Ljava/lang/Object;

    move-result-object v1

    check-cast v1, Lcom/cyjh/elfin/activity/ElfinFreeActivity;

    .line 462
    .local v1, "mElfinFreeActivity":Lcom/cyjh/elfin/activity/ElfinFreeActivity;
    if-nez v1, :cond_1

    .line 477
    :cond_0
    :goto_0
    return-void

    .line 463
    :cond_1
    iget v2, p1, Landroid/os/Message;->what:I

    packed-switch v2, :pswitch_data_0

    :pswitch_0
    goto :goto_0

    .line 466
    :pswitch_1
    invoke-static {v1}, Lcom/cyjh/elfin/activity/ElfinFreeActivity;->access$200(Lcom/cyjh/elfin/activity/ElfinFreeActivity;)V

    goto :goto_0

    .line 469
    :pswitch_2
    iget-object v0, p1, Landroid/os/Message;->obj:Ljava/lang/Object;

    check-cast v0, Ljava/util/ArrayList;

    .line 470
    .local v0, "data":Ljava/util/ArrayList;, "Ljava/util/ArrayList<Lcom/cyjh/elfin/entity/NotifyMsgBean;>;"
    if-eqz v0, :cond_0

    .line 471
    invoke-static {v1, v0}, Lcom/cyjh/elfin/activity/ElfinFreeActivity;->access$300(Lcom/cyjh/elfin/activity/ElfinFreeActivity;Ljava/util/ArrayList;)V

    goto :goto_0

    .line 463
    nop

    :pswitch_data_0
    .packed-switch 0x3ea
        :pswitch_1
        :pswitch_0
        :pswitch_0
        :pswitch_2
    .end packed-switch
.end method
