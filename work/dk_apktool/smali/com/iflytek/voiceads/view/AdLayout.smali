.class public abstract Lcom/iflytek/voiceads/view/AdLayout;
.super Landroid/widget/RelativeLayout;
.source "AdLayout.java"


# instance fields
.field private hasDestroyed:Z

.field protected mAdActivity:Landroid/app/Activity;

.field protected mInternalListener:Lcom/iflytek/voiceads/listener/InternalListener;


# direct methods
.method public constructor <init>(Landroid/content/Context;)V
    .locals 1
    .param p1, "context"    # Landroid/content/Context;

    .prologue
    .line 16
    invoke-direct {p0, p1}, Landroid/widget/RelativeLayout;-><init>(Landroid/content/Context;)V

    .line 20
    const/4 v0, 0x0

    iput-boolean v0, p0, Lcom/iflytek/voiceads/view/AdLayout;->hasDestroyed:Z

    .line 21
    new-instance v0, Lcom/iflytek/voiceads/view/AdLayout$1;

    invoke-direct {v0, p0}, Lcom/iflytek/voiceads/view/AdLayout$1;-><init>(Lcom/iflytek/voiceads/view/AdLayout;)V

    iput-object v0, p0, Lcom/iflytek/voiceads/view/AdLayout;->mInternalListener:Lcom/iflytek/voiceads/listener/InternalListener;

    .line 17
    check-cast p1, Landroid/app/Activity;

    .end local p1    # "context":Landroid/content/Context;
    iput-object p1, p0, Lcom/iflytek/voiceads/view/AdLayout;->mAdActivity:Landroid/app/Activity;

    .line 18
    return-void
.end method

.method static synthetic access$000(Lcom/iflytek/voiceads/view/AdLayout;)Z
    .locals 1
    .param p0, "x0"    # Lcom/iflytek/voiceads/view/AdLayout;

    .prologue
    .line 11
    iget-boolean v0, p0, Lcom/iflytek/voiceads/view/AdLayout;->hasDestroyed:Z

    return v0
.end method

.method static synthetic access$002(Lcom/iflytek/voiceads/view/AdLayout;Z)Z
    .locals 0
    .param p0, "x0"    # Lcom/iflytek/voiceads/view/AdLayout;
    .param p1, "x1"    # Z

    .prologue
    .line 11
    iput-boolean p1, p0, Lcom/iflytek/voiceads/view/AdLayout;->hasDestroyed:Z

    return p1
.end method


# virtual methods
.method protected declared-synchronized destroy()V
    .locals 1

    .prologue
    .line 46
    monitor-enter p0

    :try_start_0
    invoke-virtual {p0}, Lcom/iflytek/voiceads/view/AdLayout;->getParent()Landroid/view/ViewParent;

    move-result-object v0

    check-cast v0, Landroid/view/ViewGroup;

    invoke-virtual {v0, p0}, Landroid/view/ViewGroup;->removeView(Landroid/view/View;)V

    .line 47
    invoke-virtual {p0}, Lcom/iflytek/voiceads/view/AdLayout;->removeAllViews()V

    .line 48
    const/16 v0, 0x8

    invoke-virtual {p0, v0}, Lcom/iflytek/voiceads/view/AdLayout;->setVisibility(I)V
    :try_end_0
    .catchall {:try_start_0 .. :try_end_0} :catchall_0

    .line 49
    monitor-exit p0

    return-void

    .line 46
    :catchall_0
    move-exception v0

    monitor-exit p0

    throw v0
.end method
