.class public Lcom/lidroid/xutils/bitmap/PauseOnScrollListener;
.super Ljava/lang/Object;
.source "SourceFile"

# interfaces
.implements Landroid/widget/AbsListView$OnScrollListener;


# instance fields
.field private final externalListener:Landroid/widget/AbsListView$OnScrollListener;

.field private final pauseOnFling:Z

.field private final pauseOnScroll:Z

.field private taskHandler:Lcom/lidroid/xutils/task/TaskHandler;


# direct methods
.method public constructor <init>(Lcom/lidroid/xutils/task/TaskHandler;ZZ)V
    .locals 1

    .prologue
    .line 39
    const/4 v0, 0x0

    invoke-direct {p0, p1, p2, p3, v0}, Lcom/lidroid/xutils/bitmap/PauseOnScrollListener;-><init>(Lcom/lidroid/xutils/task/TaskHandler;ZZLandroid/widget/AbsListView$OnScrollListener;)V

    .line 40
    return-void
.end method

.method public constructor <init>(Lcom/lidroid/xutils/task/TaskHandler;ZZLandroid/widget/AbsListView$OnScrollListener;)V
    .locals 0

    .prologue
    .line 51
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    .line 52
    iput-object p1, p0, Lcom/lidroid/xutils/bitmap/PauseOnScrollListener;->taskHandler:Lcom/lidroid/xutils/task/TaskHandler;

    .line 53
    iput-boolean p2, p0, Lcom/lidroid/xutils/bitmap/PauseOnScrollListener;->pauseOnScroll:Z

    .line 54
    iput-boolean p3, p0, Lcom/lidroid/xutils/bitmap/PauseOnScrollListener;->pauseOnFling:Z

    .line 55
    iput-object p4, p0, Lcom/lidroid/xutils/bitmap/PauseOnScrollListener;->externalListener:Landroid/widget/AbsListView$OnScrollListener;

    .line 56
    return-void
.end method


# virtual methods
.method public onScroll(Landroid/widget/AbsListView;III)V
    .locals 1

    .prologue
    .line 82
    iget-object v0, p0, Lcom/lidroid/xutils/bitmap/PauseOnScrollListener;->externalListener:Landroid/widget/AbsListView$OnScrollListener;

    if-eqz v0, :cond_0

    .line 83
    iget-object v0, p0, Lcom/lidroid/xutils/bitmap/PauseOnScrollListener;->externalListener:Landroid/widget/AbsListView$OnScrollListener;

    invoke-interface {v0, p1, p2, p3, p4}, Landroid/widget/AbsListView$OnScrollListener;->onScroll(Landroid/widget/AbsListView;III)V

    .line 85
    :cond_0
    return-void
.end method

.method public onScrollStateChanged(Landroid/widget/AbsListView;I)V
    .locals 1

    .prologue
    .line 60
    packed-switch p2, :pswitch_data_0

    .line 75
    :cond_0
    :goto_0
    iget-object v0, p0, Lcom/lidroid/xutils/bitmap/PauseOnScrollListener;->externalListener:Landroid/widget/AbsListView$OnScrollListener;

    if-eqz v0, :cond_1

    .line 76
    iget-object v0, p0, Lcom/lidroid/xutils/bitmap/PauseOnScrollListener;->externalListener:Landroid/widget/AbsListView$OnScrollListener;

    invoke-interface {v0, p1, p2}, Landroid/widget/AbsListView$OnScrollListener;->onScrollStateChanged(Landroid/widget/AbsListView;I)V

    .line 78
    :cond_1
    return-void

    .line 62
    :pswitch_0
    iget-object v0, p0, Lcom/lidroid/xutils/bitmap/PauseOnScrollListener;->taskHandler:Lcom/lidroid/xutils/task/TaskHandler;

    invoke-interface {v0}, Lcom/lidroid/xutils/task/TaskHandler;->resume()V

    goto :goto_0

    .line 65
    :pswitch_1
    iget-boolean v0, p0, Lcom/lidroid/xutils/bitmap/PauseOnScrollListener;->pauseOnScroll:Z

    if-eqz v0, :cond_0

    .line 66
    iget-object v0, p0, Lcom/lidroid/xutils/bitmap/PauseOnScrollListener;->taskHandler:Lcom/lidroid/xutils/task/TaskHandler;

    invoke-interface {v0}, Lcom/lidroid/xutils/task/TaskHandler;->pause()V

    goto :goto_0

    .line 70
    :pswitch_2
    iget-boolean v0, p0, Lcom/lidroid/xutils/bitmap/PauseOnScrollListener;->pauseOnFling:Z

    if-eqz v0, :cond_0

    .line 71
    iget-object v0, p0, Lcom/lidroid/xutils/bitmap/PauseOnScrollListener;->taskHandler:Lcom/lidroid/xutils/task/TaskHandler;

    invoke-interface {v0}, Lcom/lidroid/xutils/task/TaskHandler;->pause()V

    goto :goto_0

    .line 60
    nop

    :pswitch_data_0
    .packed-switch 0x0
        :pswitch_0
        :pswitch_1
        :pswitch_2
    .end packed-switch
.end method
