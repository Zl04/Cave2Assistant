.class Lcom/cyjh/elfin/activity/RecommendGamesActivity$OnLeftBackListener;
.super Ljava/lang/Object;
.source "RecommendGamesActivity.java"

# interfaces
.implements Lcom/cyjh/elfin/customview/TitleView$OnLeftImageViewListener;


# annotations
.annotation system Ldalvik/annotation/EnclosingClass;
    value = Lcom/cyjh/elfin/activity/RecommendGamesActivity;
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x2
    name = "OnLeftBackListener"
.end annotation


# instance fields
.field final synthetic this$0:Lcom/cyjh/elfin/activity/RecommendGamesActivity;


# direct methods
.method private constructor <init>(Lcom/cyjh/elfin/activity/RecommendGamesActivity;)V
    .locals 0

    .prologue
    .line 60
    iput-object p1, p0, Lcom/cyjh/elfin/activity/RecommendGamesActivity$OnLeftBackListener;->this$0:Lcom/cyjh/elfin/activity/RecommendGamesActivity;

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method

.method synthetic constructor <init>(Lcom/cyjh/elfin/activity/RecommendGamesActivity;Lcom/cyjh/elfin/activity/RecommendGamesActivity$1;)V
    .locals 0
    .param p1, "x0"    # Lcom/cyjh/elfin/activity/RecommendGamesActivity;
    .param p2, "x1"    # Lcom/cyjh/elfin/activity/RecommendGamesActivity$1;

    .prologue
    .line 60
    invoke-direct {p0, p1}, Lcom/cyjh/elfin/activity/RecommendGamesActivity$OnLeftBackListener;-><init>(Lcom/cyjh/elfin/activity/RecommendGamesActivity;)V

    return-void
.end method


# virtual methods
.method public onClick(Landroid/view/View;)V
    .locals 1
    .param p1, "view"    # Landroid/view/View;

    .prologue
    .line 64
    iget-object v0, p0, Lcom/cyjh/elfin/activity/RecommendGamesActivity$OnLeftBackListener;->this$0:Lcom/cyjh/elfin/activity/RecommendGamesActivity;

    invoke-static {v0}, Lcom/cyjh/elfin/activity/RecommendGamesActivity;->access$200(Lcom/cyjh/elfin/activity/RecommendGamesActivity;)V

    .line 65
    return-void
.end method
