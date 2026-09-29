.class Lcom/cyjh/feedback/lib/fragment/FeedBackInfoFragment$MyHandler;
.super Landroid/os/Handler;
.source "FeedBackInfoFragment.java"


# annotations
.annotation system Ldalvik/annotation/EnclosingClass;
    value = Lcom/cyjh/feedback/lib/fragment/FeedBackInfoFragment;
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0xa
    name = "MyHandler"
.end annotation


# instance fields
.field private final mFragment:Ljava/lang/ref/WeakReference;
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "Ljava/lang/ref/WeakReference",
            "<",
            "Lcom/cyjh/feedback/lib/fragment/FeedBackInfoFragment;",
            ">;"
        }
    .end annotation
.end field


# direct methods
.method private constructor <init>(Lcom/cyjh/feedback/lib/fragment/FeedBackInfoFragment;)V
    .locals 1
    .param p1, "fragment"    # Lcom/cyjh/feedback/lib/fragment/FeedBackInfoFragment;

    .prologue
    .line 169
    invoke-direct {p0}, Landroid/os/Handler;-><init>()V

    .line 170
    new-instance v0, Ljava/lang/ref/WeakReference;

    invoke-direct {v0, p1}, Ljava/lang/ref/WeakReference;-><init>(Ljava/lang/Object;)V

    iput-object v0, p0, Lcom/cyjh/feedback/lib/fragment/FeedBackInfoFragment$MyHandler;->mFragment:Ljava/lang/ref/WeakReference;

    .line 171
    return-void
.end method

.method synthetic constructor <init>(Lcom/cyjh/feedback/lib/fragment/FeedBackInfoFragment;Lcom/cyjh/feedback/lib/fragment/FeedBackInfoFragment$1;)V
    .locals 0
    .param p1, "x0"    # Lcom/cyjh/feedback/lib/fragment/FeedBackInfoFragment;
    .param p2, "x1"    # Lcom/cyjh/feedback/lib/fragment/FeedBackInfoFragment$1;

    .prologue
    .line 167
    invoke-direct {p0, p1}, Lcom/cyjh/feedback/lib/fragment/FeedBackInfoFragment$MyHandler;-><init>(Lcom/cyjh/feedback/lib/fragment/FeedBackInfoFragment;)V

    return-void
.end method


# virtual methods
.method public handleMessage(Landroid/os/Message;)V
    .locals 3
    .param p1, "msg"    # Landroid/os/Message;

    .prologue
    .line 174
    iget-object v2, p0, Lcom/cyjh/feedback/lib/fragment/FeedBackInfoFragment$MyHandler;->mFragment:Ljava/lang/ref/WeakReference;

    invoke-virtual {v2}, Ljava/lang/ref/WeakReference;->get()Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Lcom/cyjh/feedback/lib/fragment/FeedBackInfoFragment;

    .line 175
    .local v0, "mFeedBackInfoFragment":Lcom/cyjh/feedback/lib/fragment/FeedBackInfoFragment;
    if-eqz v0, :cond_0

    .line 176
    iget-object v1, p1, Landroid/os/Message;->obj:Ljava/lang/Object;

    check-cast v1, Lcom/cyjh/feedback/lib/entities/PicDataBean;

    .line 177
    .local v1, "mPicDataBean":Lcom/cyjh/feedback/lib/entities/PicDataBean;
    invoke-static {v0}, Lcom/cyjh/feedback/lib/fragment/FeedBackInfoFragment;->access$100(Lcom/cyjh/feedback/lib/fragment/FeedBackInfoFragment;)Lcom/cyjh/feedback/lib/dialog/LoadingDialog;

    move-result-object v2

    invoke-virtual {v2}, Lcom/cyjh/feedback/lib/dialog/LoadingDialog;->dismiss()V

    .line 178
    invoke-static {v0}, Lcom/cyjh/feedback/lib/fragment/FeedBackInfoFragment;->access$200(Lcom/cyjh/feedback/lib/fragment/FeedBackInfoFragment;)Lcom/cyjh/feedback/lib/entities/FeedBackInfoBean;

    move-result-object v2

    invoke-virtual {v2, v1}, Lcom/cyjh/feedback/lib/entities/FeedBackInfoBean;->setData(Lcom/cyjh/feedback/lib/entities/PicDataBean;)V

    .line 179
    invoke-static {v0}, Lcom/cyjh/feedback/lib/fragment/FeedBackInfoFragment;->access$300(Lcom/cyjh/feedback/lib/fragment/FeedBackInfoFragment;)V

    .line 181
    .end local v1    # "mPicDataBean":Lcom/cyjh/feedback/lib/entities/PicDataBean;
    :cond_0
    return-void
.end method
