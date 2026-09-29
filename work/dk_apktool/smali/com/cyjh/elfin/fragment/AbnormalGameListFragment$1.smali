.class Lcom/cyjh/elfin/fragment/AbnormalGameListFragment$1;
.super Ljava/lang/Object;
.source "AbnormalGameListFragment.java"

# interfaces
.implements Lcom/cyjh/elfin/mvp/views/loadstate/IListViewLoadCallBack;


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
    .line 151
    iput-object p1, p0, Lcom/cyjh/elfin/fragment/AbnormalGameListFragment$1;->this$0:Lcom/cyjh/elfin/fragment/AbnormalGameListFragment;

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method


# virtual methods
.method public loadNextPage()V
    .locals 1

    .prologue
    .line 154
    iget-object v0, p0, Lcom/cyjh/elfin/fragment/AbnormalGameListFragment$1;->this$0:Lcom/cyjh/elfin/fragment/AbnormalGameListFragment;

    invoke-virtual {v0}, Lcom/cyjh/elfin/fragment/AbnormalGameListFragment;->loadDataNextPage()V

    .line 155
    return-void
.end method
