.class Lcom/cyjh/elfin/activity/AbnormalGamesActivity$1;
.super Ljava/lang/Object;
.source "AbnormalGamesActivity.java"

# interfaces
.implements Lcom/cyjh/elfin/customview/TitleView$OnLeftImageViewListener;


# annotations
.annotation system Ldalvik/annotation/EnclosingClass;
    value = Lcom/cyjh/elfin/activity/AbnormalGamesActivity;
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x0
    name = null
.end annotation


# instance fields
.field final synthetic this$0:Lcom/cyjh/elfin/activity/AbnormalGamesActivity;


# direct methods
.method constructor <init>(Lcom/cyjh/elfin/activity/AbnormalGamesActivity;)V
    .locals 0
    .param p1, "this$0"    # Lcom/cyjh/elfin/activity/AbnormalGamesActivity;

    .prologue
    .line 44
    iput-object p1, p0, Lcom/cyjh/elfin/activity/AbnormalGamesActivity$1;->this$0:Lcom/cyjh/elfin/activity/AbnormalGamesActivity;

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method


# virtual methods
.method public onClick(Landroid/view/View;)V
    .locals 1
    .param p1, "view"    # Landroid/view/View;

    .prologue
    .line 47
    iget-object v0, p0, Lcom/cyjh/elfin/activity/AbnormalGamesActivity$1;->this$0:Lcom/cyjh/elfin/activity/AbnormalGamesActivity;

    invoke-virtual {v0}, Lcom/cyjh/elfin/activity/AbnormalGamesActivity;->finish()V

    .line 48
    return-void
.end method
