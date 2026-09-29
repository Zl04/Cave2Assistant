.class Lcom/cyjh/elfin/activity/FeedbackActivity$1;
.super Ljava/lang/Object;
.source "FeedbackActivity.java"

# interfaces
.implements Lcom/cyjh/elfin/customview/TitleView$OnLeftImageViewListener;


# annotations
.annotation system Ldalvik/annotation/EnclosingMethod;
    value = Lcom/cyjh/elfin/activity/FeedbackActivity;->initTitle()V
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x0
    name = null
.end annotation


# instance fields
.field final synthetic this$0:Lcom/cyjh/elfin/activity/FeedbackActivity;


# direct methods
.method constructor <init>(Lcom/cyjh/elfin/activity/FeedbackActivity;)V
    .locals 0
    .param p1, "this$0"    # Lcom/cyjh/elfin/activity/FeedbackActivity;

    .prologue
    .line 35
    iput-object p1, p0, Lcom/cyjh/elfin/activity/FeedbackActivity$1;->this$0:Lcom/cyjh/elfin/activity/FeedbackActivity;

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method


# virtual methods
.method public onClick(Landroid/view/View;)V
    .locals 1
    .param p1, "view"    # Landroid/view/View;

    .prologue
    .line 38
    iget-object v0, p0, Lcom/cyjh/elfin/activity/FeedbackActivity$1;->this$0:Lcom/cyjh/elfin/activity/FeedbackActivity;

    invoke-virtual {v0}, Lcom/cyjh/elfin/activity/FeedbackActivity;->onBackPressed()V

    .line 39
    return-void
.end method
