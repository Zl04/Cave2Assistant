.class Lcom/cyjh/elfin/activity/MessageDetailActivity$OnLeftImageOnClickerListener;
.super Ljava/lang/Object;
.source "MessageDetailActivity.java"

# interfaces
.implements Lcom/cyjh/elfin/customview/TitleView$OnLeftImageViewListener;


# annotations
.annotation system Ldalvik/annotation/EnclosingClass;
    value = Lcom/cyjh/elfin/activity/MessageDetailActivity;
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x2
    name = "OnLeftImageOnClickerListener"
.end annotation


# instance fields
.field final synthetic this$0:Lcom/cyjh/elfin/activity/MessageDetailActivity;


# direct methods
.method private constructor <init>(Lcom/cyjh/elfin/activity/MessageDetailActivity;)V
    .locals 0

    .prologue
    .line 37
    iput-object p1, p0, Lcom/cyjh/elfin/activity/MessageDetailActivity$OnLeftImageOnClickerListener;->this$0:Lcom/cyjh/elfin/activity/MessageDetailActivity;

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method

.method synthetic constructor <init>(Lcom/cyjh/elfin/activity/MessageDetailActivity;Lcom/cyjh/elfin/activity/MessageDetailActivity$1;)V
    .locals 0
    .param p1, "x0"    # Lcom/cyjh/elfin/activity/MessageDetailActivity;
    .param p2, "x1"    # Lcom/cyjh/elfin/activity/MessageDetailActivity$1;

    .prologue
    .line 37
    invoke-direct {p0, p1}, Lcom/cyjh/elfin/activity/MessageDetailActivity$OnLeftImageOnClickerListener;-><init>(Lcom/cyjh/elfin/activity/MessageDetailActivity;)V

    return-void
.end method


# virtual methods
.method public onClick(Landroid/view/View;)V
    .locals 1
    .param p1, "view"    # Landroid/view/View;

    .prologue
    .line 40
    iget-object v0, p0, Lcom/cyjh/elfin/activity/MessageDetailActivity$OnLeftImageOnClickerListener;->this$0:Lcom/cyjh/elfin/activity/MessageDetailActivity;

    invoke-virtual {v0}, Lcom/cyjh/elfin/activity/MessageDetailActivity;->finish()V

    .line 41
    return-void
.end method
