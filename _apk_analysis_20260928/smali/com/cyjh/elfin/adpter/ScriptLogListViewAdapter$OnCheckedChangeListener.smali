.class Lcom/cyjh/elfin/adpter/ScriptLogListViewAdapter$OnCheckedChangeListener;
.super Ljava/lang/Object;
.source "ScriptLogListViewAdapter.java"

# interfaces
.implements Landroid/widget/CompoundButton$OnCheckedChangeListener;


# annotations
.annotation system Ldalvik/annotation/EnclosingClass;
    value = Lcom/cyjh/elfin/adpter/ScriptLogListViewAdapter;
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x2
    name = "OnCheckedChangeListener"
.end annotation


# instance fields
.field private position:I

.field final synthetic this$0:Lcom/cyjh/elfin/adpter/ScriptLogListViewAdapter;


# direct methods
.method public constructor <init>(Lcom/cyjh/elfin/adpter/ScriptLogListViewAdapter;I)V
    .locals 0
    .param p2, "position"    # I

    .prologue
    .line 103
    iput-object p1, p0, Lcom/cyjh/elfin/adpter/ScriptLogListViewAdapter$OnCheckedChangeListener;->this$0:Lcom/cyjh/elfin/adpter/ScriptLogListViewAdapter;

    .line 104
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    .line 105
    iput p2, p0, Lcom/cyjh/elfin/adpter/ScriptLogListViewAdapter$OnCheckedChangeListener;->position:I

    .line 106
    return-void
.end method


# virtual methods
.method public onCheckedChanged(Landroid/widget/CompoundButton;Z)V
    .locals 2
    .param p1, "buttonView"    # Landroid/widget/CompoundButton;
    .param p2, "isChecked"    # Z

    .prologue
    .line 111
    iget-object v0, p0, Lcom/cyjh/elfin/adpter/ScriptLogListViewAdapter$OnCheckedChangeListener;->this$0:Lcom/cyjh/elfin/adpter/ScriptLogListViewAdapter;

    invoke-static {v0}, Lcom/cyjh/elfin/adpter/ScriptLogListViewAdapter;->access$000(Lcom/cyjh/elfin/adpter/ScriptLogListViewAdapter;)Ljava/util/ArrayList;

    move-result-object v0

    iget v1, p0, Lcom/cyjh/elfin/adpter/ScriptLogListViewAdapter$OnCheckedChangeListener;->position:I

    invoke-virtual {v0, v1}, Ljava/util/ArrayList;->get(I)Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Lcom/cyjh/elfin/entity/ScriptLog;

    invoke-virtual {v0, p2}, Lcom/cyjh/elfin/entity/ScriptLog;->setSelect(Z)V

    .line 112
    return-void
.end method
