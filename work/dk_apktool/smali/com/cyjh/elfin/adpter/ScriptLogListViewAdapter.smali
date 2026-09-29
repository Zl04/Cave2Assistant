.class public Lcom/cyjh/elfin/adpter/ScriptLogListViewAdapter;
.super Landroid/widget/BaseAdapter;
.source "ScriptLogListViewAdapter.java"


# annotations
.annotation system Ldalvik/annotation/MemberClasses;
    value = {
        Lcom/cyjh/elfin/adpter/ScriptLogListViewAdapter$OnCheckedChangeListener;,
        Lcom/cyjh/elfin/adpter/ScriptLogListViewAdapter$ViewHolder;
    }
.end annotation


# instance fields
.field private appContext:Lcom/cyjh/elfin/AppContext;

.field private commonLog:Lcom/cyjh/elfin/log/CommonLog;

.field private context:Landroid/content/Context;

.field private isManage:Z

.field private layoutInflater:Landroid/view/LayoutInflater;

.field private scriptLogList:Ljava/util/ArrayList;
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "Ljava/util/ArrayList",
            "<",
            "Lcom/cyjh/elfin/entity/ScriptLog;",
            ">;"
        }
    .end annotation
.end field


# direct methods
.method public constructor <init>(Landroid/content/Context;Ljava/util/ArrayList;)V
    .locals 1
    .param p1, "context"    # Landroid/content/Context;
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "(",
            "Landroid/content/Context;",
            "Ljava/util/ArrayList",
            "<",
            "Lcom/cyjh/elfin/entity/ScriptLog;",
            ">;)V"
        }
    .end annotation

    .prologue
    .line 31
    .local p2, "scriptLogList":Ljava/util/ArrayList;, "Ljava/util/ArrayList<Lcom/cyjh/elfin/entity/ScriptLog;>;"
    invoke-direct {p0}, Landroid/widget/BaseAdapter;-><init>()V

    .line 28
    new-instance v0, Lcom/cyjh/elfin/log/CommonLog;

    invoke-direct {v0}, Lcom/cyjh/elfin/log/CommonLog;-><init>()V

    iput-object v0, p0, Lcom/cyjh/elfin/adpter/ScriptLogListViewAdapter;->commonLog:Lcom/cyjh/elfin/log/CommonLog;

    .line 32
    iput-object p1, p0, Lcom/cyjh/elfin/adpter/ScriptLogListViewAdapter;->context:Landroid/content/Context;

    .line 33
    invoke-virtual {p1}, Landroid/content/Context;->getApplicationContext()Landroid/content/Context;

    move-result-object v0

    check-cast v0, Lcom/cyjh/elfin/AppContext;

    iput-object v0, p0, Lcom/cyjh/elfin/adpter/ScriptLogListViewAdapter;->appContext:Lcom/cyjh/elfin/AppContext;

    .line 34
    iput-object p2, p0, Lcom/cyjh/elfin/adpter/ScriptLogListViewAdapter;->scriptLogList:Ljava/util/ArrayList;

    .line 36
    invoke-static {p1}, Landroid/view/LayoutInflater;->from(Landroid/content/Context;)Landroid/view/LayoutInflater;

    move-result-object v0

    iput-object v0, p0, Lcom/cyjh/elfin/adpter/ScriptLogListViewAdapter;->layoutInflater:Landroid/view/LayoutInflater;

    .line 37
    return-void
.end method

.method static synthetic access$000(Lcom/cyjh/elfin/adpter/ScriptLogListViewAdapter;)Ljava/util/ArrayList;
    .locals 1
    .param p0, "x0"    # Lcom/cyjh/elfin/adpter/ScriptLogListViewAdapter;

    .prologue
    .line 20
    iget-object v0, p0, Lcom/cyjh/elfin/adpter/ScriptLogListViewAdapter;->scriptLogList:Ljava/util/ArrayList;

    return-object v0
.end method


# virtual methods
.method public getCount()I
    .locals 1

    .prologue
    .line 41
    iget-object v0, p0, Lcom/cyjh/elfin/adpter/ScriptLogListViewAdapter;->scriptLogList:Ljava/util/ArrayList;

    invoke-virtual {v0}, Ljava/util/ArrayList;->size()I

    move-result v0

    return v0
.end method

.method public getItem(I)Ljava/lang/Object;
    .locals 1
    .param p1, "position"    # I

    .prologue
    .line 46
    iget-object v0, p0, Lcom/cyjh/elfin/adpter/ScriptLogListViewAdapter;->scriptLogList:Ljava/util/ArrayList;

    invoke-virtual {v0, p1}, Ljava/util/ArrayList;->get(I)Ljava/lang/Object;

    move-result-object v0

    return-object v0
.end method

.method public getItemId(I)J
    .locals 2
    .param p1, "position"    # I

    .prologue
    .line 51
    int-to-long v0, p1

    return-wide v0
.end method

.method public getView(ILandroid/view/View;Landroid/view/ViewGroup;)Landroid/view/View;
    .locals 7
    .param p1, "position"    # I
    .param p2, "convertView"    # Landroid/view/View;
    .param p3, "parent"    # Landroid/view/ViewGroup;

    .prologue
    const/16 v6, 0x8

    const/4 v5, 0x0

    .line 57
    if-nez p2, :cond_0

    .line 58
    iget-object v2, p0, Lcom/cyjh/elfin/adpter/ScriptLogListViewAdapter;->layoutInflater:Landroid/view/LayoutInflater;

    const v3, 0x7f04005a

    const/4 v4, 0x0

    invoke-virtual {v2, v3, v4}, Landroid/view/LayoutInflater;->inflate(ILandroid/view/ViewGroup;)Landroid/view/View;

    move-result-object p2

    .line 60
    new-instance v1, Lcom/cyjh/elfin/adpter/ScriptLogListViewAdapter$ViewHolder;

    invoke-direct {v1}, Lcom/cyjh/elfin/adpter/ScriptLogListViewAdapter$ViewHolder;-><init>()V

    .line 61
    .local v1, "viewHolder":Lcom/cyjh/elfin/adpter/ScriptLogListViewAdapter$ViewHolder;
    const v2, 0x7f0f0138

    invoke-virtual {p2, v2}, Landroid/view/View;->findViewById(I)Landroid/view/View;

    move-result-object v2

    check-cast v2, Landroid/widget/TextView;

    iput-object v2, v1, Lcom/cyjh/elfin/adpter/ScriptLogListViewAdapter$ViewHolder;->tvSize:Landroid/widget/TextView;

    .line 62
    const v2, 0x7f0f0139

    invoke-virtual {p2, v2}, Landroid/view/View;->findViewById(I)Landroid/view/View;

    move-result-object v2

    check-cast v2, Landroid/widget/TextView;

    iput-object v2, v1, Lcom/cyjh/elfin/adpter/ScriptLogListViewAdapter$ViewHolder;->tvName:Landroid/widget/TextView;

    .line 63
    const v2, 0x7f0f013a

    invoke-virtual {p2, v2}, Landroid/view/View;->findViewById(I)Landroid/view/View;

    move-result-object v2

    check-cast v2, Landroid/widget/CheckBox;

    iput-object v2, v1, Lcom/cyjh/elfin/adpter/ScriptLogListViewAdapter$ViewHolder;->cbSelect:Landroid/widget/CheckBox;

    .line 64
    const v2, 0x7f0f013b

    invoke-virtual {p2, v2}, Landroid/view/View;->findViewById(I)Landroid/view/View;

    move-result-object v2

    check-cast v2, Landroid/widget/ImageView;

    iput-object v2, v1, Lcom/cyjh/elfin/adpter/ScriptLogListViewAdapter$ViewHolder;->imgArrow:Landroid/widget/ImageView;

    .line 66
    invoke-virtual {p2, v1}, Landroid/view/View;->setTag(Ljava/lang/Object;)V

    .line 71
    :goto_0
    iget-object v2, p0, Lcom/cyjh/elfin/adpter/ScriptLogListViewAdapter;->scriptLogList:Ljava/util/ArrayList;

    invoke-virtual {v2, p1}, Ljava/util/ArrayList;->get(I)Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Lcom/cyjh/elfin/entity/ScriptLog;

    .line 73
    .local v0, "scriptLog":Lcom/cyjh/elfin/entity/ScriptLog;
    iget-boolean v2, p0, Lcom/cyjh/elfin/adpter/ScriptLogListViewAdapter;->isManage:Z

    if-eqz v2, :cond_1

    .line 74
    iget-object v2, v1, Lcom/cyjh/elfin/adpter/ScriptLogListViewAdapter$ViewHolder;->cbSelect:Landroid/widget/CheckBox;

    invoke-virtual {v2, v5}, Landroid/widget/CheckBox;->setVisibility(I)V

    .line 75
    iget-object v2, v1, Lcom/cyjh/elfin/adpter/ScriptLogListViewAdapter$ViewHolder;->imgArrow:Landroid/widget/ImageView;

    invoke-virtual {v2, v6}, Landroid/widget/ImageView;->setVisibility(I)V

    .line 82
    :goto_1
    iget-object v2, v1, Lcom/cyjh/elfin/adpter/ScriptLogListViewAdapter$ViewHolder;->tvSize:Landroid/widget/TextView;

    invoke-virtual {v0}, Lcom/cyjh/elfin/entity/ScriptLog;->getSize()Ljava/lang/String;

    move-result-object v3

    invoke-virtual {v2, v3}, Landroid/widget/TextView;->setText(Ljava/lang/CharSequence;)V

    .line 83
    iget-object v2, v1, Lcom/cyjh/elfin/adpter/ScriptLogListViewAdapter$ViewHolder;->tvName:Landroid/widget/TextView;

    invoke-virtual {v0}, Lcom/cyjh/elfin/entity/ScriptLog;->getName()Ljava/lang/String;

    move-result-object v3

    invoke-virtual {v2, v3}, Landroid/widget/TextView;->setText(Ljava/lang/CharSequence;)V

    .line 84
    iget-object v2, v1, Lcom/cyjh/elfin/adpter/ScriptLogListViewAdapter$ViewHolder;->cbSelect:Landroid/widget/CheckBox;

    new-instance v3, Lcom/cyjh/elfin/adpter/ScriptLogListViewAdapter$OnCheckedChangeListener;

    invoke-direct {v3, p0, p1}, Lcom/cyjh/elfin/adpter/ScriptLogListViewAdapter$OnCheckedChangeListener;-><init>(Lcom/cyjh/elfin/adpter/ScriptLogListViewAdapter;I)V

    invoke-virtual {v2, v3}, Landroid/widget/CheckBox;->setOnCheckedChangeListener(Landroid/widget/CompoundButton$OnCheckedChangeListener;)V

    .line 86
    iget-object v2, v1, Lcom/cyjh/elfin/adpter/ScriptLogListViewAdapter$ViewHolder;->cbSelect:Landroid/widget/CheckBox;

    invoke-virtual {v0}, Lcom/cyjh/elfin/entity/ScriptLog;->isSelect()Z

    move-result v3

    invoke-virtual {v2, v3}, Landroid/widget/CheckBox;->setChecked(Z)V

    .line 88
    return-object p2

    .line 68
    .end local v0    # "scriptLog":Lcom/cyjh/elfin/entity/ScriptLog;
    .end local v1    # "viewHolder":Lcom/cyjh/elfin/adpter/ScriptLogListViewAdapter$ViewHolder;
    :cond_0
    invoke-virtual {p2}, Landroid/view/View;->getTag()Ljava/lang/Object;

    move-result-object v1

    check-cast v1, Lcom/cyjh/elfin/adpter/ScriptLogListViewAdapter$ViewHolder;

    .restart local v1    # "viewHolder":Lcom/cyjh/elfin/adpter/ScriptLogListViewAdapter$ViewHolder;
    goto :goto_0

    .line 78
    .restart local v0    # "scriptLog":Lcom/cyjh/elfin/entity/ScriptLog;
    :cond_1
    iget-object v2, v1, Lcom/cyjh/elfin/adpter/ScriptLogListViewAdapter$ViewHolder;->cbSelect:Landroid/widget/CheckBox;

    invoke-virtual {v2, v6}, Landroid/widget/CheckBox;->setVisibility(I)V

    .line 79
    iget-object v2, v1, Lcom/cyjh/elfin/adpter/ScriptLogListViewAdapter$ViewHolder;->imgArrow:Landroid/widget/ImageView;

    invoke-virtual {v2, v5}, Landroid/widget/ImageView;->setVisibility(I)V

    goto :goto_1
.end method

.method public isManage()Z
    .locals 1

    .prologue
    .line 116
    iget-boolean v0, p0, Lcom/cyjh/elfin/adpter/ScriptLogListViewAdapter;->isManage:Z

    return v0
.end method

.method public setManage(Z)V
    .locals 0
    .param p1, "isManage"    # Z

    .prologue
    .line 120
    iput-boolean p1, p0, Lcom/cyjh/elfin/adpter/ScriptLogListViewAdapter;->isManage:Z

    .line 121
    return-void
.end method
