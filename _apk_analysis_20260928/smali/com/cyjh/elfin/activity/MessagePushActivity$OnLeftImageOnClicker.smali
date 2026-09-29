.class Lcom/cyjh/elfin/activity/MessagePushActivity$OnLeftImageOnClicker;
.super Ljava/lang/Object;
.source "MessagePushActivity.java"

# interfaces
.implements Lcom/cyjh/elfin/customview/TitleView$OnLeftImageViewListener;


# annotations
.annotation system Ldalvik/annotation/EnclosingClass;
    value = Lcom/cyjh/elfin/activity/MessagePushActivity;
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x2
    name = "OnLeftImageOnClicker"
.end annotation


# instance fields
.field final synthetic this$0:Lcom/cyjh/elfin/activity/MessagePushActivity;


# direct methods
.method private constructor <init>(Lcom/cyjh/elfin/activity/MessagePushActivity;)V
    .locals 0

    .prologue
    .line 61
    iput-object p1, p0, Lcom/cyjh/elfin/activity/MessagePushActivity$OnLeftImageOnClicker;->this$0:Lcom/cyjh/elfin/activity/MessagePushActivity;

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method

.method synthetic constructor <init>(Lcom/cyjh/elfin/activity/MessagePushActivity;Lcom/cyjh/elfin/activity/MessagePushActivity$1;)V
    .locals 0
    .param p1, "x0"    # Lcom/cyjh/elfin/activity/MessagePushActivity;
    .param p2, "x1"    # Lcom/cyjh/elfin/activity/MessagePushActivity$1;

    .prologue
    .line 61
    invoke-direct {p0, p1}, Lcom/cyjh/elfin/activity/MessagePushActivity$OnLeftImageOnClicker;-><init>(Lcom/cyjh/elfin/activity/MessagePushActivity;)V

    return-void
.end method


# virtual methods
.method public onClick(Landroid/view/View;)V
    .locals 1
    .param p1, "view"    # Landroid/view/View;

    .prologue
    .line 64
    iget-object v0, p0, Lcom/cyjh/elfin/activity/MessagePushActivity$OnLeftImageOnClicker;->this$0:Lcom/cyjh/elfin/activity/MessagePushActivity;

    invoke-virtual {v0}, Lcom/cyjh/elfin/activity/MessagePushActivity;->finish()V

    .line 65
    return-void
.end method
