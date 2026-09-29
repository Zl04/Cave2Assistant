.class Lcom/cyjh/elfin/activity/AbGamesDetailsActivity$1;
.super Ljava/lang/Object;
.source "AbGamesDetailsActivity.java"

# interfaces
.implements Lcom/cyjh/elfin/customview/TitleView$OnLeftImageViewListener;


# annotations
.annotation system Ldalvik/annotation/EnclosingClass;
    value = Lcom/cyjh/elfin/activity/AbGamesDetailsActivity;
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x0
    name = null
.end annotation


# instance fields
.field final synthetic this$0:Lcom/cyjh/elfin/activity/AbGamesDetailsActivity;


# direct methods
.method constructor <init>(Lcom/cyjh/elfin/activity/AbGamesDetailsActivity;)V
    .locals 0
    .param p1, "this$0"    # Lcom/cyjh/elfin/activity/AbGamesDetailsActivity;

    .prologue
    .line 50
    iput-object p1, p0, Lcom/cyjh/elfin/activity/AbGamesDetailsActivity$1;->this$0:Lcom/cyjh/elfin/activity/AbGamesDetailsActivity;

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method


# virtual methods
.method public onClick(Landroid/view/View;)V
    .locals 1
    .param p1, "view"    # Landroid/view/View;

    .prologue
    .line 53
    iget-object v0, p0, Lcom/cyjh/elfin/activity/AbGamesDetailsActivity$1;->this$0:Lcom/cyjh/elfin/activity/AbGamesDetailsActivity;

    invoke-virtual {v0}, Lcom/cyjh/elfin/activity/AbGamesDetailsActivity;->finish()V

    .line 54
    return-void
.end method
