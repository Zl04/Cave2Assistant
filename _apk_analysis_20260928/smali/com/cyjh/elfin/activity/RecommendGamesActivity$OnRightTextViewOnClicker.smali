.class Lcom/cyjh/elfin/activity/RecommendGamesActivity$OnRightTextViewOnClicker;
.super Ljava/lang/Object;
.source "RecommendGamesActivity.java"

# interfaces
.implements Lcom/cyjh/elfin/customview/TitleView$OnRightTextViewListener;


# annotations
.annotation system Ldalvik/annotation/EnclosingClass;
    value = Lcom/cyjh/elfin/activity/RecommendGamesActivity;
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x2
    name = "OnRightTextViewOnClicker"
.end annotation


# instance fields
.field final synthetic this$0:Lcom/cyjh/elfin/activity/RecommendGamesActivity;


# direct methods
.method private constructor <init>(Lcom/cyjh/elfin/activity/RecommendGamesActivity;)V
    .locals 0

    .prologue
    .line 79
    iput-object p1, p0, Lcom/cyjh/elfin/activity/RecommendGamesActivity$OnRightTextViewOnClicker;->this$0:Lcom/cyjh/elfin/activity/RecommendGamesActivity;

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method

.method synthetic constructor <init>(Lcom/cyjh/elfin/activity/RecommendGamesActivity;Lcom/cyjh/elfin/activity/RecommendGamesActivity$1;)V
    .locals 0
    .param p1, "x0"    # Lcom/cyjh/elfin/activity/RecommendGamesActivity;
    .param p2, "x1"    # Lcom/cyjh/elfin/activity/RecommendGamesActivity$1;

    .prologue
    .line 79
    invoke-direct {p0, p1}, Lcom/cyjh/elfin/activity/RecommendGamesActivity$OnRightTextViewOnClicker;-><init>(Lcom/cyjh/elfin/activity/RecommendGamesActivity;)V

    return-void
.end method


# virtual methods
.method public onClicker(Landroid/view/View;)V
    .locals 3
    .param p1, "view"    # Landroid/view/View;

    .prologue
    .line 83
    invoke-static {}, Lorg/greenrobot/eventbus/EventBus;->getDefault()Lorg/greenrobot/eventbus/EventBus;

    move-result-object v0

    new-instance v1, Lcom/cyjh/elfin/entity/MsgItem;

    const/16 v2, 0x3ec

    invoke-direct {v1, v2}, Lcom/cyjh/elfin/entity/MsgItem;-><init>(I)V

    invoke-virtual {v0, v1}, Lorg/greenrobot/eventbus/EventBus;->post(Ljava/lang/Object;)V

    .line 84
    return-void
.end method
