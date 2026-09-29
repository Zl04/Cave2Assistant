.class Lcom/cyjh/elfin/activity/ScriptLogActivity$OnRightImageViewListener;
.super Ljava/lang/Object;
.source "ScriptLogActivity.java"

# interfaces
.implements Lcom/cyjh/elfin/customview/TitleView$OnRightImageViewListener;


# annotations
.annotation system Ldalvik/annotation/EnclosingClass;
    value = Lcom/cyjh/elfin/activity/ScriptLogActivity;
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x2
    name = "OnRightImageViewListener"
.end annotation


# instance fields
.field final synthetic this$0:Lcom/cyjh/elfin/activity/ScriptLogActivity;


# direct methods
.method private constructor <init>(Lcom/cyjh/elfin/activity/ScriptLogActivity;)V
    .locals 0

    .prologue
    .line 118
    iput-object p1, p0, Lcom/cyjh/elfin/activity/ScriptLogActivity$OnRightImageViewListener;->this$0:Lcom/cyjh/elfin/activity/ScriptLogActivity;

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method

.method synthetic constructor <init>(Lcom/cyjh/elfin/activity/ScriptLogActivity;Lcom/cyjh/elfin/activity/ScriptLogActivity$1;)V
    .locals 0
    .param p1, "x0"    # Lcom/cyjh/elfin/activity/ScriptLogActivity;
    .param p2, "x1"    # Lcom/cyjh/elfin/activity/ScriptLogActivity$1;

    .prologue
    .line 118
    invoke-direct {p0, p1}, Lcom/cyjh/elfin/activity/ScriptLogActivity$OnRightImageViewListener;-><init>(Lcom/cyjh/elfin/activity/ScriptLogActivity;)V

    return-void
.end method


# virtual methods
.method public onClick(Landroid/view/View;)V
    .locals 5
    .param p1, "view"    # Landroid/view/View;

    .prologue
    const/16 v4, 0x8

    const/4 v2, 0x0

    .line 121
    iget-object v3, p0, Lcom/cyjh/elfin/activity/ScriptLogActivity$OnRightImageViewListener;->this$0:Lcom/cyjh/elfin/activity/ScriptLogActivity;

    iget-object v1, p0, Lcom/cyjh/elfin/activity/ScriptLogActivity$OnRightImageViewListener;->this$0:Lcom/cyjh/elfin/activity/ScriptLogActivity;

    invoke-static {v1}, Lcom/cyjh/elfin/activity/ScriptLogActivity;->access$200(Lcom/cyjh/elfin/activity/ScriptLogActivity;)Z

    move-result v1

    if-nez v1, :cond_0

    const/4 v1, 0x1

    :goto_0
    invoke-static {v3, v1}, Lcom/cyjh/elfin/activity/ScriptLogActivity;->access$202(Lcom/cyjh/elfin/activity/ScriptLogActivity;Z)Z

    .line 122
    iget-object v1, p0, Lcom/cyjh/elfin/activity/ScriptLogActivity$OnRightImageViewListener;->this$0:Lcom/cyjh/elfin/activity/ScriptLogActivity;

    invoke-static {v1}, Lcom/cyjh/elfin/activity/ScriptLogActivity;->access$200(Lcom/cyjh/elfin/activity/ScriptLogActivity;)Z

    move-result v1

    if-eqz v1, :cond_1

    .line 123
    iget-object v1, p0, Lcom/cyjh/elfin/activity/ScriptLogActivity$OnRightImageViewListener;->this$0:Lcom/cyjh/elfin/activity/ScriptLogActivity;

    invoke-static {v1}, Lcom/cyjh/elfin/activity/ScriptLogActivity;->access$300(Lcom/cyjh/elfin/activity/ScriptLogActivity;)Landroid/widget/Button;

    move-result-object v1

    invoke-virtual {v1, v2}, Landroid/widget/Button;->setVisibility(I)V

    .line 124
    iget-object v1, p0, Lcom/cyjh/elfin/activity/ScriptLogActivity$OnRightImageViewListener;->this$0:Lcom/cyjh/elfin/activity/ScriptLogActivity;

    invoke-static {v1}, Lcom/cyjh/elfin/activity/ScriptLogActivity;->access$400(Lcom/cyjh/elfin/activity/ScriptLogActivity;)Landroid/widget/Button;

    move-result-object v1

    invoke-virtual {v1, v2}, Landroid/widget/Button;->setVisibility(I)V

    .line 125
    iget-object v1, p0, Lcom/cyjh/elfin/activity/ScriptLogActivity$OnRightImageViewListener;->this$0:Lcom/cyjh/elfin/activity/ScriptLogActivity;

    invoke-static {v1}, Lcom/cyjh/elfin/activity/ScriptLogActivity;->access$500(Lcom/cyjh/elfin/activity/ScriptLogActivity;)Lcom/cyjh/elfin/customview/TitleView;

    move-result-object v1

    const v3, 0x7f020092

    invoke-virtual {v1, v3}, Lcom/cyjh/elfin/customview/TitleView;->setRightImage(I)V

    .line 131
    :goto_1
    iget-object v1, p0, Lcom/cyjh/elfin/activity/ScriptLogActivity$OnRightImageViewListener;->this$0:Lcom/cyjh/elfin/activity/ScriptLogActivity;

    invoke-static {v1}, Lcom/cyjh/elfin/activity/ScriptLogActivity;->access$600(Lcom/cyjh/elfin/activity/ScriptLogActivity;)Ljava/util/ArrayList;

    move-result-object v1

    invoke-virtual {v1}, Ljava/util/ArrayList;->iterator()Ljava/util/Iterator;

    move-result-object v1

    :goto_2
    invoke-interface {v1}, Ljava/util/Iterator;->hasNext()Z

    move-result v3

    if-eqz v3, :cond_2

    invoke-interface {v1}, Ljava/util/Iterator;->next()Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Lcom/cyjh/elfin/entity/ScriptLog;

    .line 132
    .local v0, "scriptLog":Lcom/cyjh/elfin/entity/ScriptLog;
    invoke-virtual {v0, v2}, Lcom/cyjh/elfin/entity/ScriptLog;->setSelect(Z)V

    goto :goto_2

    .end local v0    # "scriptLog":Lcom/cyjh/elfin/entity/ScriptLog;
    :cond_0
    move v1, v2

    .line 121
    goto :goto_0

    .line 127
    :cond_1
    iget-object v1, p0, Lcom/cyjh/elfin/activity/ScriptLogActivity$OnRightImageViewListener;->this$0:Lcom/cyjh/elfin/activity/ScriptLogActivity;

    invoke-static {v1}, Lcom/cyjh/elfin/activity/ScriptLogActivity;->access$300(Lcom/cyjh/elfin/activity/ScriptLogActivity;)Landroid/widget/Button;

    move-result-object v1

    invoke-virtual {v1, v4}, Landroid/widget/Button;->setVisibility(I)V

    .line 128
    iget-object v1, p0, Lcom/cyjh/elfin/activity/ScriptLogActivity$OnRightImageViewListener;->this$0:Lcom/cyjh/elfin/activity/ScriptLogActivity;

    invoke-static {v1}, Lcom/cyjh/elfin/activity/ScriptLogActivity;->access$400(Lcom/cyjh/elfin/activity/ScriptLogActivity;)Landroid/widget/Button;

    move-result-object v1

    invoke-virtual {v1, v4}, Landroid/widget/Button;->setVisibility(I)V

    .line 129
    iget-object v1, p0, Lcom/cyjh/elfin/activity/ScriptLogActivity$OnRightImageViewListener;->this$0:Lcom/cyjh/elfin/activity/ScriptLogActivity;

    invoke-static {v1}, Lcom/cyjh/elfin/activity/ScriptLogActivity;->access$500(Lcom/cyjh/elfin/activity/ScriptLogActivity;)Lcom/cyjh/elfin/customview/TitleView;

    move-result-object v1

    const v3, 0x7f020099

    invoke-virtual {v1, v3}, Lcom/cyjh/elfin/customview/TitleView;->setRightImage(I)V

    goto :goto_1

    .line 135
    :cond_2
    iget-object v1, p0, Lcom/cyjh/elfin/activity/ScriptLogActivity$OnRightImageViewListener;->this$0:Lcom/cyjh/elfin/activity/ScriptLogActivity;

    invoke-static {v1}, Lcom/cyjh/elfin/activity/ScriptLogActivity;->access$700(Lcom/cyjh/elfin/activity/ScriptLogActivity;)Lcom/cyjh/elfin/adpter/ScriptLogListViewAdapter;

    move-result-object v1

    iget-object v2, p0, Lcom/cyjh/elfin/activity/ScriptLogActivity$OnRightImageViewListener;->this$0:Lcom/cyjh/elfin/activity/ScriptLogActivity;

    invoke-static {v2}, Lcom/cyjh/elfin/activity/ScriptLogActivity;->access$200(Lcom/cyjh/elfin/activity/ScriptLogActivity;)Z

    move-result v2

    invoke-virtual {v1, v2}, Lcom/cyjh/elfin/adpter/ScriptLogListViewAdapter;->setManage(Z)V

    .line 136
    iget-object v1, p0, Lcom/cyjh/elfin/activity/ScriptLogActivity$OnRightImageViewListener;->this$0:Lcom/cyjh/elfin/activity/ScriptLogActivity;

    invoke-static {v1}, Lcom/cyjh/elfin/activity/ScriptLogActivity;->access$700(Lcom/cyjh/elfin/activity/ScriptLogActivity;)Lcom/cyjh/elfin/adpter/ScriptLogListViewAdapter;

    move-result-object v1

    invoke-virtual {v1}, Lcom/cyjh/elfin/adpter/ScriptLogListViewAdapter;->notifyDataSetChanged()V

    .line 137
    return-void
.end method
