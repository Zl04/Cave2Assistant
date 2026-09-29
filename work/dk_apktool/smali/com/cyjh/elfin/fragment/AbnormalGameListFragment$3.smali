.class Lcom/cyjh/elfin/fragment/AbnormalGameListFragment$3;
.super Ljava/lang/Object;
.source "AbnormalGameListFragment.java"

# interfaces
.implements Landroid/widget/AdapterView$OnItemClickListener;


# annotations
.annotation system Ldalvik/annotation/EnclosingMethod;
    value = Lcom/cyjh/elfin/fragment/AbnormalGameListFragment;->setAdapterData(Lcom/cyjh/elfin/entity/Game;)V
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x0
    name = null
.end annotation


# instance fields
.field final synthetic this$0:Lcom/cyjh/elfin/fragment/AbnormalGameListFragment;

.field final synthetic val$gameInfoList:Ljava/util/List;


# direct methods
.method constructor <init>(Lcom/cyjh/elfin/fragment/AbnormalGameListFragment;Ljava/util/List;)V
    .locals 0
    .param p1, "this$0"    # Lcom/cyjh/elfin/fragment/AbnormalGameListFragment;

    .prologue
    .line 221
    iput-object p1, p0, Lcom/cyjh/elfin/fragment/AbnormalGameListFragment$3;->this$0:Lcom/cyjh/elfin/fragment/AbnormalGameListFragment;

    iput-object p2, p0, Lcom/cyjh/elfin/fragment/AbnormalGameListFragment$3;->val$gameInfoList:Ljava/util/List;

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method


# virtual methods
.method public onItemClick(Landroid/widget/AdapterView;Landroid/view/View;IJ)V
    .locals 2
    .param p2, "view"    # Landroid/view/View;
    .param p3, "position"    # I
    .param p4, "id"    # J
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "(",
            "Landroid/widget/AdapterView",
            "<*>;",
            "Landroid/view/View;",
            "IJ)V"
        }
    .end annotation

    .prologue
    .line 224
    .local p1, "parent":Landroid/widget/AdapterView;, "Landroid/widget/AdapterView<*>;"
    iget-object v0, p0, Lcom/cyjh/elfin/fragment/AbnormalGameListFragment$3;->this$0:Lcom/cyjh/elfin/fragment/AbnormalGameListFragment;

    invoke-virtual {v0}, Lcom/cyjh/elfin/fragment/AbnormalGameListFragment;->getActivity()Landroid/support/v4/app/FragmentActivity;

    move-result-object v1

    iget-object v0, p0, Lcom/cyjh/elfin/fragment/AbnormalGameListFragment$3;->val$gameInfoList:Ljava/util/List;

    invoke-interface {v0, p3}, Ljava/util/List;->get(I)Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Lcom/cyjh/elfin/entity/GameInfo;

    invoke-static {v1, v0}, Lcom/cyjh/elfin/util/IntentUtils;->toAbGamesDetailsActivity(Landroid/content/Context;Lcom/cyjh/elfin/entity/GameInfo;)V

    .line 225
    return-void
.end method
