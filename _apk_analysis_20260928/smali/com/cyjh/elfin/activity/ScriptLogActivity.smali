.class public Lcom/cyjh/elfin/activity/ScriptLogActivity;
.super Lcom/cyjh/elfin/activity/BaseActivity;
.source "ScriptLogActivity.java"

# interfaces
.implements Landroid/view/View$OnClickListener;
.implements Landroid/widget/AdapterView$OnItemClickListener;


# annotations
.annotation system Ldalvik/annotation/MemberClasses;
    value = {
        Lcom/cyjh/elfin/activity/ScriptLogActivity$OnRightImageViewListener;,
        Lcom/cyjh/elfin/activity/ScriptLogActivity$OnLeftImageViewListener;
    }
.end annotation


# instance fields
.field private btnRemoveAll:Landroid/widget/Button;

.field private btnSelectAll:Landroid/widget/Button;

.field private isManage:Z

.field private listviewScriptlog:Landroid/widget/ListView;

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

.field private scriptLogListViewAdapter:Lcom/cyjh/elfin/adpter/ScriptLogListViewAdapter;

.field private titleView:Lcom/cyjh/elfin/customview/TitleView;


# direct methods
.method public constructor <init>()V
    .locals 1

    .prologue
    .line 26
    invoke-direct {p0}, Lcom/cyjh/elfin/activity/BaseActivity;-><init>()V

    .line 35
    const/4 v0, 0x0

    iput-boolean v0, p0, Lcom/cyjh/elfin/activity/ScriptLogActivity;->isManage:Z

    return-void
.end method

.method static synthetic access$200(Lcom/cyjh/elfin/activity/ScriptLogActivity;)Z
    .locals 1
    .param p0, "x0"    # Lcom/cyjh/elfin/activity/ScriptLogActivity;

    .prologue
    .line 26
    iget-boolean v0, p0, Lcom/cyjh/elfin/activity/ScriptLogActivity;->isManage:Z

    return v0
.end method

.method static synthetic access$202(Lcom/cyjh/elfin/activity/ScriptLogActivity;Z)Z
    .locals 0
    .param p0, "x0"    # Lcom/cyjh/elfin/activity/ScriptLogActivity;
    .param p1, "x1"    # Z

    .prologue
    .line 26
    iput-boolean p1, p0, Lcom/cyjh/elfin/activity/ScriptLogActivity;->isManage:Z

    return p1
.end method

.method static synthetic access$300(Lcom/cyjh/elfin/activity/ScriptLogActivity;)Landroid/widget/Button;
    .locals 1
    .param p0, "x0"    # Lcom/cyjh/elfin/activity/ScriptLogActivity;

    .prologue
    .line 26
    iget-object v0, p0, Lcom/cyjh/elfin/activity/ScriptLogActivity;->btnRemoveAll:Landroid/widget/Button;

    return-object v0
.end method

.method static synthetic access$400(Lcom/cyjh/elfin/activity/ScriptLogActivity;)Landroid/widget/Button;
    .locals 1
    .param p0, "x0"    # Lcom/cyjh/elfin/activity/ScriptLogActivity;

    .prologue
    .line 26
    iget-object v0, p0, Lcom/cyjh/elfin/activity/ScriptLogActivity;->btnSelectAll:Landroid/widget/Button;

    return-object v0
.end method

.method static synthetic access$500(Lcom/cyjh/elfin/activity/ScriptLogActivity;)Lcom/cyjh/elfin/customview/TitleView;
    .locals 1
    .param p0, "x0"    # Lcom/cyjh/elfin/activity/ScriptLogActivity;

    .prologue
    .line 26
    iget-object v0, p0, Lcom/cyjh/elfin/activity/ScriptLogActivity;->titleView:Lcom/cyjh/elfin/customview/TitleView;

    return-object v0
.end method

.method static synthetic access$600(Lcom/cyjh/elfin/activity/ScriptLogActivity;)Ljava/util/ArrayList;
    .locals 1
    .param p0, "x0"    # Lcom/cyjh/elfin/activity/ScriptLogActivity;

    .prologue
    .line 26
    iget-object v0, p0, Lcom/cyjh/elfin/activity/ScriptLogActivity;->scriptLogList:Ljava/util/ArrayList;

    return-object v0
.end method

.method static synthetic access$700(Lcom/cyjh/elfin/activity/ScriptLogActivity;)Lcom/cyjh/elfin/adpter/ScriptLogListViewAdapter;
    .locals 1
    .param p0, "x0"    # Lcom/cyjh/elfin/activity/ScriptLogActivity;

    .prologue
    .line 26
    iget-object v0, p0, Lcom/cyjh/elfin/activity/ScriptLogActivity;->scriptLogListViewAdapter:Lcom/cyjh/elfin/adpter/ScriptLogListViewAdapter;

    return-object v0
.end method

.method private deleteScriptLogs()V
    .locals 7

    .prologue
    .line 162
    const/4 v1, 0x0

    .line 163
    .local v1, "isChecked":Z
    iget-object v3, p0, Lcom/cyjh/elfin/activity/ScriptLogActivity;->scriptLogList:Ljava/util/ArrayList;

    invoke-virtual {v3}, Ljava/util/ArrayList;->iterator()Ljava/util/Iterator;

    move-result-object v3

    :goto_0
    invoke-interface {v3}, Ljava/util/Iterator;->hasNext()Z

    move-result v4

    if-eqz v4, :cond_0

    invoke-interface {v3}, Ljava/util/Iterator;->next()Ljava/lang/Object;

    move-result-object v2

    check-cast v2, Lcom/cyjh/elfin/entity/ScriptLog;

    .line 164
    .local v2, "scriptLog":Lcom/cyjh/elfin/entity/ScriptLog;
    invoke-virtual {v2}, Lcom/cyjh/elfin/entity/ScriptLog;->isSelect()Z

    move-result v4

    if-eqz v4, :cond_1

    .line 165
    const/4 v1, 0x1

    .line 172
    .end local v2    # "scriptLog":Lcom/cyjh/elfin/entity/ScriptLog;
    :cond_0
    if-nez v1, :cond_2

    .line 173
    iget-object v3, p0, Lcom/cyjh/elfin/activity/ScriptLogActivity;->appContext:Lcom/cyjh/elfin/AppContext;

    const v4, 0x7f0800e0

    invoke-virtual {v3, v4}, Lcom/cyjh/elfin/AppContext;->showToast(I)V

    .line 190
    :goto_1
    return-void

    .line 168
    .restart local v2    # "scriptLog":Lcom/cyjh/elfin/entity/ScriptLog;
    :cond_1
    const/4 v1, 0x0

    .line 170
    goto :goto_0

    .line 177
    .end local v2    # "scriptLog":Lcom/cyjh/elfin/entity/ScriptLog;
    :cond_2
    new-instance v0, Ljava/util/ArrayList;

    invoke-direct {v0}, Ljava/util/ArrayList;-><init>()V

    .line 179
    .local v0, "deletScriptLogList":Ljava/util/List;, "Ljava/util/List<Lcom/cyjh/elfin/entity/ScriptLog;>;"
    iget-object v3, p0, Lcom/cyjh/elfin/activity/ScriptLogActivity;->commonLog:Lcom/cyjh/elfin/log/CommonLog;

    new-instance v4, Ljava/lang/StringBuilder;

    invoke-direct {v4}, Ljava/lang/StringBuilder;-><init>()V

    const-string v5, "scriptLog>>"

    invoke-virtual {v4, v5}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v4

    iget-object v5, p0, Lcom/cyjh/elfin/activity/ScriptLogActivity;->scriptLogList:Ljava/util/ArrayList;

    invoke-virtual {v5}, Ljava/util/ArrayList;->size()I

    move-result v5

    invoke-virtual {v4, v5}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v4

    invoke-virtual {v4}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v4

    invoke-virtual {v3, v4}, Lcom/cyjh/elfin/log/CommonLog;->e(Ljava/lang/Object;)V

    .line 180
    iget-object v3, p0, Lcom/cyjh/elfin/activity/ScriptLogActivity;->scriptLogList:Ljava/util/ArrayList;

    invoke-virtual {v3}, Ljava/util/ArrayList;->iterator()Ljava/util/Iterator;

    move-result-object v3

    :cond_3
    :goto_2
    invoke-interface {v3}, Ljava/util/Iterator;->hasNext()Z

    move-result v4

    if-eqz v4, :cond_4

    invoke-interface {v3}, Ljava/util/Iterator;->next()Ljava/lang/Object;

    move-result-object v2

    check-cast v2, Lcom/cyjh/elfin/entity/ScriptLog;

    .line 181
    .restart local v2    # "scriptLog":Lcom/cyjh/elfin/entity/ScriptLog;
    invoke-virtual {v2}, Lcom/cyjh/elfin/entity/ScriptLog;->isSelect()Z

    move-result v4

    if-eqz v4, :cond_3

    .line 182
    invoke-virtual {v2}, Lcom/cyjh/elfin/entity/ScriptLog;->getFile()Ljava/io/File;

    move-result-object v4

    invoke-virtual {v4}, Ljava/io/File;->delete()Z

    move-result v4

    if-eqz v4, :cond_3

    .line 183
    iget-object v4, p0, Lcom/cyjh/elfin/activity/ScriptLogActivity;->commonLog:Lcom/cyjh/elfin/log/CommonLog;

    new-instance v5, Ljava/lang/StringBuilder;

    invoke-direct {v5}, Ljava/lang/StringBuilder;-><init>()V

    const-string v6, "scriptLog>>"

    invoke-virtual {v5, v6}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v5

    invoke-virtual {v2}, Lcom/cyjh/elfin/entity/ScriptLog;->getName()Ljava/lang/String;

    move-result-object v6

    invoke-virtual {v5, v6}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v5

    invoke-virtual {v5}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v5

    invoke-virtual {v4, v5}, Lcom/cyjh/elfin/log/CommonLog;->e(Ljava/lang/Object;)V

    .line 184
    invoke-interface {v0, v2}, Ljava/util/List;->add(Ljava/lang/Object;)Z

    goto :goto_2

    .line 188
    .end local v2    # "scriptLog":Lcom/cyjh/elfin/entity/ScriptLog;
    :cond_4
    iget-object v3, p0, Lcom/cyjh/elfin/activity/ScriptLogActivity;->scriptLogList:Ljava/util/ArrayList;

    invoke-virtual {v3, v0}, Ljava/util/ArrayList;->removeAll(Ljava/util/Collection;)Z

    .line 189
    iget-object v3, p0, Lcom/cyjh/elfin/activity/ScriptLogActivity;->scriptLogListViewAdapter:Lcom/cyjh/elfin/adpter/ScriptLogListViewAdapter;

    invoke-virtual {v3}, Lcom/cyjh/elfin/adpter/ScriptLogListViewAdapter;->notifyDataSetChanged()V

    goto :goto_1
.end method

.method private getScriptLogListData()V
    .locals 8

    .prologue
    .line 94
    new-instance v1, Lcom/cyjh/elfin/util/FileUtils$FileSuffixrFilter;

    const-string v4, ".log"

    invoke-direct {v1, v4}, Lcom/cyjh/elfin/util/FileUtils$FileSuffixrFilter;-><init>(Ljava/lang/String;)V

    .line 95
    .local v1, "fileSuffixrFilter":Lcom/cyjh/elfin/util/FileUtils$FileSuffixrFilter;
    new-instance v4, Ljava/io/File;

    iget-object v5, p0, Lcom/cyjh/elfin/activity/ScriptLogActivity;->appContext:Lcom/cyjh/elfin/AppContext;

    iget-object v5, v5, Lcom/cyjh/elfin/AppContext;->PATH_PACKAGENAME_LOG:Ljava/lang/String;

    invoke-direct {v4, v5}, Ljava/io/File;-><init>(Ljava/lang/String;)V

    invoke-virtual {v4, v1}, Ljava/io/File;->listFiles(Ljava/io/FilenameFilter;)[Ljava/io/File;

    move-result-object v2

    .line 96
    .local v2, "logFiles":[Ljava/io/File;
    new-instance v4, Ljava/util/ArrayList;

    invoke-direct {v4}, Ljava/util/ArrayList;-><init>()V

    iput-object v4, p0, Lcom/cyjh/elfin/activity/ScriptLogActivity;->scriptLogList:Ljava/util/ArrayList;

    .line 97
    if-eqz v2, :cond_0

    .line 99
    new-instance v4, Lcom/cyjh/elfin/util/FileComparator;

    invoke-direct {v4}, Lcom/cyjh/elfin/util/FileComparator;-><init>()V

    invoke-static {v2, v4}, Ljava/util/Arrays;->sort([Ljava/lang/Object;Ljava/util/Comparator;)V

    .line 100
    array-length v5, v2

    const/4 v4, 0x0

    :goto_0
    if-ge v4, v5, :cond_0

    aget-object v0, v2, v4

    .line 101
    .local v0, "file":Ljava/io/File;
    new-instance v3, Lcom/cyjh/elfin/entity/ScriptLog;

    invoke-direct {v3}, Lcom/cyjh/elfin/entity/ScriptLog;-><init>()V

    .line 102
    .local v3, "scriptLog":Lcom/cyjh/elfin/entity/ScriptLog;
    invoke-virtual {v0}, Ljava/io/File;->length()J

    move-result-wide v6

    invoke-static {v6, v7}, Lcom/cyjh/elfin/util/FileUtils;->formetFileSize(J)Ljava/lang/String;

    move-result-object v6

    invoke-virtual {v3, v6}, Lcom/cyjh/elfin/entity/ScriptLog;->setSize(Ljava/lang/String;)V

    .line 103
    invoke-virtual {v0}, Ljava/io/File;->getName()Ljava/lang/String;

    move-result-object v6

    invoke-virtual {v3, v6}, Lcom/cyjh/elfin/entity/ScriptLog;->setName(Ljava/lang/String;)V

    .line 104
    invoke-virtual {v3, v0}, Lcom/cyjh/elfin/entity/ScriptLog;->setFile(Ljava/io/File;)V

    .line 105
    iget-object v6, p0, Lcom/cyjh/elfin/activity/ScriptLogActivity;->scriptLogList:Ljava/util/ArrayList;

    invoke-virtual {v6, v3}, Ljava/util/ArrayList;->add(Ljava/lang/Object;)Z

    .line 100
    add-int/lit8 v4, v4, 0x1

    goto :goto_0

    .line 109
    .end local v0    # "file":Ljava/io/File;
    .end local v3    # "scriptLog":Lcom/cyjh/elfin/entity/ScriptLog;
    :cond_0
    return-void
.end method

.method private initListView()V
    .locals 2

    .prologue
    .line 82
    const v0, 0x7f0f0084

    invoke-virtual {p0, v0}, Lcom/cyjh/elfin/activity/ScriptLogActivity;->findViewById(I)Landroid/view/View;

    move-result-object v0

    check-cast v0, Landroid/widget/ListView;

    iput-object v0, p0, Lcom/cyjh/elfin/activity/ScriptLogActivity;->listviewScriptlog:Landroid/widget/ListView;

    .line 83
    iget-object v0, p0, Lcom/cyjh/elfin/activity/ScriptLogActivity;->listviewScriptlog:Landroid/widget/ListView;

    invoke-virtual {v0, p0}, Landroid/widget/ListView;->setOnItemClickListener(Landroid/widget/AdapterView$OnItemClickListener;)V

    .line 84
    invoke-direct {p0}, Lcom/cyjh/elfin/activity/ScriptLogActivity;->getScriptLogListData()V

    .line 85
    new-instance v0, Lcom/cyjh/elfin/adpter/ScriptLogListViewAdapter;

    iget-object v1, p0, Lcom/cyjh/elfin/activity/ScriptLogActivity;->scriptLogList:Ljava/util/ArrayList;

    invoke-direct {v0, p0, v1}, Lcom/cyjh/elfin/adpter/ScriptLogListViewAdapter;-><init>(Landroid/content/Context;Ljava/util/ArrayList;)V

    iput-object v0, p0, Lcom/cyjh/elfin/activity/ScriptLogActivity;->scriptLogListViewAdapter:Lcom/cyjh/elfin/adpter/ScriptLogListViewAdapter;

    .line 86
    iget-object v0, p0, Lcom/cyjh/elfin/activity/ScriptLogActivity;->listviewScriptlog:Landroid/widget/ListView;

    iget-object v1, p0, Lcom/cyjh/elfin/activity/ScriptLogActivity;->scriptLogListViewAdapter:Lcom/cyjh/elfin/adpter/ScriptLogListViewAdapter;

    invoke-virtual {v0, v1}, Landroid/widget/ListView;->setAdapter(Landroid/widget/ListAdapter;)V

    .line 87
    return-void
.end method

.method private initTitle()V
    .locals 3

    .prologue
    const/4 v2, 0x0

    .line 71
    const v0, 0x7f0f0083

    invoke-virtual {p0, v0}, Lcom/cyjh/elfin/activity/ScriptLogActivity;->findViewById(I)Landroid/view/View;

    move-result-object v0

    check-cast v0, Lcom/cyjh/elfin/customview/TitleView;

    iput-object v0, p0, Lcom/cyjh/elfin/activity/ScriptLogActivity;->titleView:Lcom/cyjh/elfin/customview/TitleView;

    .line 72
    iget-object v0, p0, Lcom/cyjh/elfin/activity/ScriptLogActivity;->titleView:Lcom/cyjh/elfin/customview/TitleView;

    const v1, 0x7f0800dd

    invoke-virtual {v0, v1}, Lcom/cyjh/elfin/customview/TitleView;->setTitleText(I)V

    .line 73
    iget-object v0, p0, Lcom/cyjh/elfin/activity/ScriptLogActivity;->titleView:Lcom/cyjh/elfin/customview/TitleView;

    const v1, 0x7f02008f

    invoke-virtual {v0, v1}, Lcom/cyjh/elfin/customview/TitleView;->setleftImage(I)V

    .line 74
    iget-object v0, p0, Lcom/cyjh/elfin/activity/ScriptLogActivity;->titleView:Lcom/cyjh/elfin/customview/TitleView;

    new-instance v1, Lcom/cyjh/elfin/activity/ScriptLogActivity$OnLeftImageViewListener;

    invoke-direct {v1, p0, v2}, Lcom/cyjh/elfin/activity/ScriptLogActivity$OnLeftImageViewListener;-><init>(Lcom/cyjh/elfin/activity/ScriptLogActivity;Lcom/cyjh/elfin/activity/ScriptLogActivity$1;)V

    invoke-virtual {v0, v1}, Lcom/cyjh/elfin/customview/TitleView;->setOnLeftImageViewListener(Lcom/cyjh/elfin/customview/TitleView$OnLeftImageViewListener;)V

    .line 76
    iget-object v0, p0, Lcom/cyjh/elfin/activity/ScriptLogActivity;->titleView:Lcom/cyjh/elfin/customview/TitleView;

    const v1, 0x7f020099

    invoke-virtual {v0, v1}, Lcom/cyjh/elfin/customview/TitleView;->setRightImage(I)V

    .line 77
    iget-object v0, p0, Lcom/cyjh/elfin/activity/ScriptLogActivity;->titleView:Lcom/cyjh/elfin/customview/TitleView;

    new-instance v1, Lcom/cyjh/elfin/activity/ScriptLogActivity$OnRightImageViewListener;

    invoke-direct {v1, p0, v2}, Lcom/cyjh/elfin/activity/ScriptLogActivity$OnRightImageViewListener;-><init>(Lcom/cyjh/elfin/activity/ScriptLogActivity;Lcom/cyjh/elfin/activity/ScriptLogActivity$1;)V

    invoke-virtual {v0, v1}, Lcom/cyjh/elfin/customview/TitleView;->setOnRightImageViewListener(Lcom/cyjh/elfin/customview/TitleView$OnRightImageViewListener;)V

    .line 79
    return-void
.end method

.method private initView()V
    .locals 1

    .prologue
    .line 60
    invoke-direct {p0}, Lcom/cyjh/elfin/activity/ScriptLogActivity;->initTitle()V

    .line 61
    invoke-direct {p0}, Lcom/cyjh/elfin/activity/ScriptLogActivity;->initListView()V

    .line 62
    const v0, 0x7f0f0085

    invoke-virtual {p0, v0}, Lcom/cyjh/elfin/activity/ScriptLogActivity;->findViewById(I)Landroid/view/View;

    move-result-object v0

    check-cast v0, Landroid/widget/Button;

    iput-object v0, p0, Lcom/cyjh/elfin/activity/ScriptLogActivity;->btnRemoveAll:Landroid/widget/Button;

    .line 63
    const v0, 0x7f0f0086

    invoke-virtual {p0, v0}, Lcom/cyjh/elfin/activity/ScriptLogActivity;->findViewById(I)Landroid/view/View;

    move-result-object v0

    check-cast v0, Landroid/widget/Button;

    iput-object v0, p0, Lcom/cyjh/elfin/activity/ScriptLogActivity;->btnSelectAll:Landroid/widget/Button;

    .line 65
    iget-object v0, p0, Lcom/cyjh/elfin/activity/ScriptLogActivity;->btnRemoveAll:Landroid/widget/Button;

    invoke-virtual {v0, p0}, Landroid/widget/Button;->setOnClickListener(Landroid/view/View$OnClickListener;)V

    .line 66
    iget-object v0, p0, Lcom/cyjh/elfin/activity/ScriptLogActivity;->btnSelectAll:Landroid/widget/Button;

    invoke-virtual {v0, p0}, Landroid/widget/Button;->setOnClickListener(Landroid/view/View$OnClickListener;)V

    .line 68
    return-void
.end method


# virtual methods
.method public onClick(Landroid/view/View;)V
    .locals 3
    .param p1, "v"    # Landroid/view/View;

    .prologue
    .line 142
    invoke-virtual {p1}, Landroid/view/View;->getId()I

    move-result v1

    packed-switch v1, :pswitch_data_0

    .line 156
    :goto_0
    return-void

    .line 144
    :pswitch_0
    invoke-direct {p0}, Lcom/cyjh/elfin/activity/ScriptLogActivity;->deleteScriptLogs()V

    goto :goto_0

    .line 147
    :pswitch_1
    iget-object v1, p0, Lcom/cyjh/elfin/activity/ScriptLogActivity;->scriptLogList:Ljava/util/ArrayList;

    invoke-virtual {v1}, Ljava/util/ArrayList;->iterator()Ljava/util/Iterator;

    move-result-object v1

    :goto_1
    invoke-interface {v1}, Ljava/util/Iterator;->hasNext()Z

    move-result v2

    if-eqz v2, :cond_0

    invoke-interface {v1}, Ljava/util/Iterator;->next()Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Lcom/cyjh/elfin/entity/ScriptLog;

    .line 148
    .local v0, "scriptLog":Lcom/cyjh/elfin/entity/ScriptLog;
    const/4 v2, 0x1

    invoke-virtual {v0, v2}, Lcom/cyjh/elfin/entity/ScriptLog;->setSelect(Z)V

    goto :goto_1

    .line 150
    .end local v0    # "scriptLog":Lcom/cyjh/elfin/entity/ScriptLog;
    :cond_0
    iget-object v1, p0, Lcom/cyjh/elfin/activity/ScriptLogActivity;->scriptLogListViewAdapter:Lcom/cyjh/elfin/adpter/ScriptLogListViewAdapter;

    invoke-virtual {v1}, Lcom/cyjh/elfin/adpter/ScriptLogListViewAdapter;->notifyDataSetChanged()V

    goto :goto_0

    .line 142
    nop

    :pswitch_data_0
    .packed-switch 0x7f0f0085
        :pswitch_0
        :pswitch_1
    .end packed-switch
.end method

.method protected onCreate(Landroid/os/Bundle;)V
    .locals 1
    .param p1, "savedInstanceState"    # Landroid/os/Bundle;

    .prologue
    .line 39
    invoke-super {p0, p1}, Lcom/cyjh/elfin/activity/BaseActivity;->onCreate(Landroid/os/Bundle;)V

    .line 40
    const v0, 0x7f040025

    invoke-virtual {p0, v0}, Lcom/cyjh/elfin/activity/ScriptLogActivity;->setContentView(I)V

    .line 41
    invoke-direct {p0}, Lcom/cyjh/elfin/activity/ScriptLogActivity;->initView()V

    .line 43
    return-void
.end method

.method public onItemClick(Landroid/widget/AdapterView;Landroid/view/View;IJ)V
    .locals 4
    .param p2, "view"    # Landroid/view/View;
    .param p3, "position"    # I
    .param p4, "id"    # J
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "(",
            "Landroid/widget/AdapterView",
            "<*>;",
            "Landroid/view/View;",
            "IJ)V"
        }
    .end annotation

    .prologue
    .line 194
    .local p1, "parent":Landroid/widget/AdapterView;, "Landroid/widget/AdapterView<*>;"
    iget-boolean v2, p0, Lcom/cyjh/elfin/activity/ScriptLogActivity;->isManage:Z

    if-nez v2, :cond_0

    .line 195
    iget-object v2, p0, Lcom/cyjh/elfin/activity/ScriptLogActivity;->scriptLogList:Ljava/util/ArrayList;

    invoke-virtual {v2, p3}, Ljava/util/ArrayList;->get(I)Ljava/lang/Object;

    move-result-object v1

    check-cast v1, Lcom/cyjh/elfin/entity/ScriptLog;

    .line 196
    .local v1, "scriptLog":Lcom/cyjh/elfin/entity/ScriptLog;
    new-instance v0, Landroid/content/Intent;

    const-class v2, Lcom/cyjh/elfin/activity/ScriptLogDetailActivity;

    invoke-direct {v0, p0, v2}, Landroid/content/Intent;-><init>(Landroid/content/Context;Ljava/lang/Class;)V

    .line 197
    .local v0, "intent":Landroid/content/Intent;
    const-string v2, "com.cyjh.elfin.activity.SettingActivity.FlagLastLog"

    const/4 v3, 0x0

    invoke-virtual {v0, v2, v3}, Landroid/content/Intent;->putExtra(Ljava/lang/String;Z)Landroid/content/Intent;

    .line 198
    const-string v2, "com.cyjh.elfin.activity.ScriptLogActivity.ScriptLog"

    invoke-virtual {v0, v2, v1}, Landroid/content/Intent;->putExtra(Ljava/lang/String;Landroid/os/Parcelable;)Landroid/content/Intent;

    .line 199
    invoke-virtual {p0, v0}, Lcom/cyjh/elfin/activity/ScriptLogActivity;->startActivity(Landroid/content/Intent;)V

    .line 201
    .end local v0    # "intent":Landroid/content/Intent;
    .end local v1    # "scriptLog":Lcom/cyjh/elfin/entity/ScriptLog;
    :cond_0
    return-void
.end method

.method protected onPause()V
    .locals 1

    .prologue
    .line 54
    invoke-super {p0}, Lcom/cyjh/elfin/activity/BaseActivity;->onPause()V

    .line 55
    const-class v0, Lcom/cyjh/elfin/activity/ScriptLogActivity;

    invoke-virtual {v0}, Ljava/lang/Class;->getCanonicalName()Ljava/lang/String;

    move-result-object v0

    invoke-static {v0}, Lcom/umeng/analytics/MobclickAgent;->onPageEnd(Ljava/lang/String;)V

    .line 56
    invoke-static {p0}, Lcom/umeng/analytics/MobclickAgent;->onPause(Landroid/content/Context;)V

    .line 57
    return-void
.end method

.method protected onResume()V
    .locals 1

    .prologue
    .line 47
    invoke-super {p0}, Lcom/cyjh/elfin/activity/BaseActivity;->onResume()V

    .line 48
    const-class v0, Lcom/cyjh/elfin/activity/ScriptLogActivity;

    invoke-virtual {v0}, Ljava/lang/Class;->getCanonicalName()Ljava/lang/String;

    move-result-object v0

    invoke-static {v0}, Lcom/umeng/analytics/MobclickAgent;->onPageStart(Ljava/lang/String;)V

    .line 49
    invoke-static {p0}, Lcom/umeng/analytics/MobclickAgent;->onResume(Landroid/content/Context;)V

    .line 50
    return-void
.end method
