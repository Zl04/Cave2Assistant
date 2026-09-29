.class Lcom/cyjh/elfin/activity/ScriptLogActivity$OnLeftImageViewListener;
.super Ljava/lang/Object;
.source "ScriptLogActivity.java"

# interfaces
.implements Lcom/cyjh/elfin/customview/TitleView$OnLeftImageViewListener;


# annotations
.annotation system Ldalvik/annotation/EnclosingClass;
    value = Lcom/cyjh/elfin/activity/ScriptLogActivity;
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x2
    name = "OnLeftImageViewListener"
.end annotation


# instance fields
.field final synthetic this$0:Lcom/cyjh/elfin/activity/ScriptLogActivity;


# direct methods
.method private constructor <init>(Lcom/cyjh/elfin/activity/ScriptLogActivity;)V
    .locals 0

    .prologue
    .line 111
    iput-object p1, p0, Lcom/cyjh/elfin/activity/ScriptLogActivity$OnLeftImageViewListener;->this$0:Lcom/cyjh/elfin/activity/ScriptLogActivity;

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method

.method synthetic constructor <init>(Lcom/cyjh/elfin/activity/ScriptLogActivity;Lcom/cyjh/elfin/activity/ScriptLogActivity$1;)V
    .locals 0
    .param p1, "x0"    # Lcom/cyjh/elfin/activity/ScriptLogActivity;
    .param p2, "x1"    # Lcom/cyjh/elfin/activity/ScriptLogActivity$1;

    .prologue
    .line 111
    invoke-direct {p0, p1}, Lcom/cyjh/elfin/activity/ScriptLogActivity$OnLeftImageViewListener;-><init>(Lcom/cyjh/elfin/activity/ScriptLogActivity;)V

    return-void
.end method


# virtual methods
.method public onClick(Landroid/view/View;)V
    .locals 1
    .param p1, "view"    # Landroid/view/View;

    .prologue
    .line 114
    iget-object v0, p0, Lcom/cyjh/elfin/activity/ScriptLogActivity$OnLeftImageViewListener;->this$0:Lcom/cyjh/elfin/activity/ScriptLogActivity;

    invoke-virtual {v0}, Lcom/cyjh/elfin/activity/ScriptLogActivity;->finish()V

    .line 115
    return-void
.end method
