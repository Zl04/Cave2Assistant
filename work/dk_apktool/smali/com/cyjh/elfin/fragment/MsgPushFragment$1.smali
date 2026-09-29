.class Lcom/cyjh/elfin/fragment/MsgPushFragment$1;
.super Ljava/lang/Object;
.source "MsgPushFragment.java"

# interfaces
.implements Lcn/bingoogolapple/androidcommon/adapter/BGAOnRVItemClickListener;


# annotations
.annotation system Ldalvik/annotation/EnclosingClass;
    value = Lcom/cyjh/elfin/fragment/MsgPushFragment;
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x0
    name = null
.end annotation


# instance fields
.field final synthetic this$0:Lcom/cyjh/elfin/fragment/MsgPushFragment;


# direct methods
.method constructor <init>(Lcom/cyjh/elfin/fragment/MsgPushFragment;)V
    .locals 0
    .param p1, "this$0"    # Lcom/cyjh/elfin/fragment/MsgPushFragment;

    .prologue
    .line 100
    iput-object p1, p0, Lcom/cyjh/elfin/fragment/MsgPushFragment$1;->this$0:Lcom/cyjh/elfin/fragment/MsgPushFragment;

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method


# virtual methods
.method public onRVItemClick(Landroid/view/ViewGroup;Landroid/view/View;I)V
    .locals 4
    .param p1, "viewGroup"    # Landroid/view/ViewGroup;
    .param p2, "view"    # Landroid/view/View;
    .param p3, "i"    # I

    .prologue
    .line 104
    iget-object v2, p0, Lcom/cyjh/elfin/fragment/MsgPushFragment$1;->this$0:Lcom/cyjh/elfin/fragment/MsgPushFragment;

    invoke-static {v2}, Lcom/cyjh/elfin/fragment/MsgPushFragment;->access$000(Lcom/cyjh/elfin/fragment/MsgPushFragment;)Lcn/bingoogolapple/androidcommon/adapter/BGARecyclerViewAdapter;

    move-result-object v2

    invoke-virtual {v2, p3}, Lcn/bingoogolapple/androidcommon/adapter/BGARecyclerViewAdapter;->getItem(I)Ljava/lang/Object;

    move-result-object v1

    check-cast v1, Lcom/cyjh/elfin/entity/NotifyMsgBean;

    .line 105
    .local v1, "notifyMsgBean":Lcom/cyjh/elfin/entity/NotifyMsgBean;
    new-instance v0, Landroid/content/Intent;

    iget-object v2, p0, Lcom/cyjh/elfin/fragment/MsgPushFragment$1;->this$0:Lcom/cyjh/elfin/fragment/MsgPushFragment;

    invoke-virtual {v2}, Lcom/cyjh/elfin/fragment/MsgPushFragment;->getActivity()Landroid/support/v4/app/FragmentActivity;

    move-result-object v2

    const-class v3, Lcom/cyjh/elfin/activity/MessageDetailActivity;

    invoke-direct {v0, v2, v3}, Landroid/content/Intent;-><init>(Landroid/content/Context;Ljava/lang/Class;)V

    .line 106
    .local v0, "intent":Landroid/content/Intent;
    const-class v2, Lcom/cyjh/elfin/activity/MessageDetailActivity;

    invoke-virtual {v2}, Ljava/lang/Class;->getCanonicalName()Ljava/lang/String;

    move-result-object v2

    invoke-virtual {v0, v2, v1}, Landroid/content/Intent;->putExtra(Ljava/lang/String;Landroid/os/Parcelable;)Landroid/content/Intent;

    .line 107
    iget-object v2, p0, Lcom/cyjh/elfin/fragment/MsgPushFragment$1;->this$0:Lcom/cyjh/elfin/fragment/MsgPushFragment;

    invoke-virtual {v2, v0}, Lcom/cyjh/elfin/fragment/MsgPushFragment;->startActivity(Landroid/content/Intent;)V

    .line 108
    return-void
.end method
