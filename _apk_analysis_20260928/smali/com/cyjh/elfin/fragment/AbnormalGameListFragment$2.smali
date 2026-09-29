.class Lcom/cyjh/elfin/fragment/AbnormalGameListFragment$2;
.super Ljava/lang/Object;
.source "AbnormalGameListFragment.java"

# interfaces
.implements Landroid/support/v4/widget/SwipeRefreshLayout$OnRefreshListener;


# annotations
.annotation system Ldalvik/annotation/EnclosingMethod;
    value = Lcom/cyjh/elfin/fragment/AbnormalGameListFragment;->initListener()V
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x0
    name = null
.end annotation


# instance fields
.field final synthetic this$0:Lcom/cyjh/elfin/fragment/AbnormalGameListFragment;


# direct methods
.method constructor <init>(Lcom/cyjh/elfin/fragment/AbnormalGameListFragment;)V
    .locals 0
    .param p1, "this$0"    # Lcom/cyjh/elfin/fragment/AbnormalGameListFragment;

    .prologue
    .line 156
    iput-object p1, p0, Lcom/cyjh/elfin/fragment/AbnormalGameListFragment$2;->this$0:Lcom/cyjh/elfin/fragment/AbnormalGameListFragment;

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method


# virtual methods
.method public onRefresh()V
    .locals 1

    .prologue
    .line 159
    iget-object v0, p0, Lcom/cyjh/elfin/fragment/AbnormalGameListFragment$2;->this$0:Lcom/cyjh/elfin/fragment/AbnormalGameListFragment;

    invoke-virtual {v0}, Lcom/cyjh/elfin/fragment/AbnormalGameListFragment;->onRepeatRefresh()V

    .line 160
    return-void
.end method
