.class Lcom/cyjh/elfin/fragment/AbnormalGameListFragment$6;
.super Ljava/lang/Object;
.source "AbnormalGameListFragment.java"

# interfaces
.implements Landroid/view/View$OnClickListener;


# annotations
.annotation system Ldalvik/annotation/EnclosingMethod;
    value = Lcom/cyjh/elfin/fragment/AbnormalGameListFragment;->getLoadFailedView()Landroid/view/View;
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
    .line 311
    iput-object p1, p0, Lcom/cyjh/elfin/fragment/AbnormalGameListFragment$6;->this$0:Lcom/cyjh/elfin/fragment/AbnormalGameListFragment;

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method


# virtual methods
.method public onClick(Landroid/view/View;)V
    .locals 1
    .param p1, "v"    # Landroid/view/View;

    .prologue
    .line 314
    iget-object v0, p0, Lcom/cyjh/elfin/fragment/AbnormalGameListFragment$6;->this$0:Lcom/cyjh/elfin/fragment/AbnormalGameListFragment;

    invoke-virtual {v0}, Lcom/cyjh/elfin/fragment/AbnormalGameListFragment;->firstLoadData()V

    .line 315
    return-void
.end method
