.class Lcom/cyjh/elfin/activity/ScriptLogDetailActivity$OnLeftImageViewListener;
.super Ljava/lang/Object;
.source "ScriptLogDetailActivity.java"

# interfaces
.implements Lcom/cyjh/elfin/customview/TitleView$OnLeftImageViewListener;


# annotations
.annotation system Ldalvik/annotation/EnclosingClass;
    value = Lcom/cyjh/elfin/activity/ScriptLogDetailActivity;
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x2
    name = "OnLeftImageViewListener"
.end annotation


# instance fields
.field final synthetic this$0:Lcom/cyjh/elfin/activity/ScriptLogDetailActivity;


# direct methods
.method private constructor <init>(Lcom/cyjh/elfin/activity/ScriptLogDetailActivity;)V
    .locals 0

    .prologue
    .line 83
    iput-object p1, p0, Lcom/cyjh/elfin/activity/ScriptLogDetailActivity$OnLeftImageViewListener;->this$0:Lcom/cyjh/elfin/activity/ScriptLogDetailActivity;

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method

.method synthetic constructor <init>(Lcom/cyjh/elfin/activity/ScriptLogDetailActivity;Lcom/cyjh/elfin/activity/ScriptLogDetailActivity$1;)V
    .locals 0
    .param p1, "x0"    # Lcom/cyjh/elfin/activity/ScriptLogDetailActivity;
    .param p2, "x1"    # Lcom/cyjh/elfin/activity/ScriptLogDetailActivity$1;

    .prologue
    .line 83
    invoke-direct {p0, p1}, Lcom/cyjh/elfin/activity/ScriptLogDetailActivity$OnLeftImageViewListener;-><init>(Lcom/cyjh/elfin/activity/ScriptLogDetailActivity;)V

    return-void
.end method


# virtual methods
.method public onClick(Landroid/view/View;)V
    .locals 1
    .param p1, "view"    # Landroid/view/View;

    .prologue
    .line 87
    iget-object v0, p0, Lcom/cyjh/elfin/activity/ScriptLogDetailActivity$OnLeftImageViewListener;->this$0:Lcom/cyjh/elfin/activity/ScriptLogDetailActivity;

    invoke-virtual {v0}, Lcom/cyjh/elfin/activity/ScriptLogDetailActivity;->finish()V

    .line 88
    return-void
.end method
