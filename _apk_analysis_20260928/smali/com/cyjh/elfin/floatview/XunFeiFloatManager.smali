.class public Lcom/cyjh/elfin/floatview/XunFeiFloatManager;
.super Ljava/lang/Object;
.source "XunFeiFloatManager.java"


# static fields
.field private static sFloatManager:Lcom/cyjh/elfin/floatview/XunFeiFloatManager;


# instance fields
.field private context:Landroid/content/Context;

.field public isAddBig:Z

.field private mFloatDisplayXunFei:Lcom/cyjh/elfin/floatview/BottomScreenDisplayXunFeiFloat;

.field private params:Landroid/view/WindowManager$LayoutParams;

.field private wm:Landroid/view/WindowManager;


# direct methods
.method public constructor <init>(Landroid/content/Context;)V
    .locals 2
    .param p1, "context"    # Landroid/content/Context;

    .prologue
    .line 26
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    .line 23
    const/4 v0, 0x0

    iput-boolean v0, p0, Lcom/cyjh/elfin/floatview/XunFeiFloatManager;->isAddBig:Z

    .line 27
    iput-object p1, p0, Lcom/cyjh/elfin/floatview/XunFeiFloatManager;->context:Landroid/content/Context;

    .line 28
    new-instance v0, Lcom/cyjh/elfin/floatview/BottomScreenDisplayXunFeiFloat;

    iget-object v1, p0, Lcom/cyjh/elfin/floatview/XunFeiFloatManager;->context:Landroid/content/Context;

    invoke-direct {v0, v1}, Lcom/cyjh/elfin/floatview/BottomScreenDisplayXunFeiFloat;-><init>(Landroid/content/Context;)V

    iput-object v0, p0, Lcom/cyjh/elfin/floatview/XunFeiFloatManager;->mFloatDisplayXunFei:Lcom/cyjh/elfin/floatview/BottomScreenDisplayXunFeiFloat;

    .line 29
    invoke-direct {p0}, Lcom/cyjh/elfin/floatview/XunFeiFloatManager;->initFloat()V

    .line 30
    invoke-direct {p0}, Lcom/cyjh/elfin/floatview/XunFeiFloatManager;->initEvent()V

    .line 31
    return-void
.end method

.method static synthetic access$000(Lcom/cyjh/elfin/floatview/XunFeiFloatManager;)Lcom/cyjh/elfin/floatview/BottomScreenDisplayXunFeiFloat;
    .locals 1
    .param p0, "x0"    # Lcom/cyjh/elfin/floatview/XunFeiFloatManager;

    .prologue
    .line 19
    iget-object v0, p0, Lcom/cyjh/elfin/floatview/XunFeiFloatManager;->mFloatDisplayXunFei:Lcom/cyjh/elfin/floatview/BottomScreenDisplayXunFeiFloat;

    return-object v0
.end method

.method public static getInstance(Landroid/content/Context;)Lcom/cyjh/elfin/floatview/XunFeiFloatManager;
    .locals 2
    .param p0, "context"    # Landroid/content/Context;

    .prologue
    .line 76
    sget-object v0, Lcom/cyjh/elfin/floatview/XunFeiFloatManager;->sFloatManager:Lcom/cyjh/elfin/floatview/XunFeiFloatManager;

    if-nez v0, :cond_1

    .line 77
    const-class v1, Lcom/cyjh/elfin/floatview/XunFeiFloatManager;

    monitor-enter v1

    .line 78
    :try_start_0
    sget-object v0, Lcom/cyjh/elfin/floatview/XunFeiFloatManager;->sFloatManager:Lcom/cyjh/elfin/floatview/XunFeiFloatManager;

    if-nez v0, :cond_0

    .line 79
    new-instance v0, Lcom/cyjh/elfin/floatview/XunFeiFloatManager;

    invoke-direct {v0, p0}, Lcom/cyjh/elfin/floatview/XunFeiFloatManager;-><init>(Landroid/content/Context;)V

    sput-object v0, Lcom/cyjh/elfin/floatview/XunFeiFloatManager;->sFloatManager:Lcom/cyjh/elfin/floatview/XunFeiFloatManager;

    .line 81
    :cond_0
    monitor-exit v1
    :try_end_0
    .catchall {:try_start_0 .. :try_end_0} :catchall_0

    .line 83
    :cond_1
    sget-object v0, Lcom/cyjh/elfin/floatview/XunFeiFloatManager;->sFloatManager:Lcom/cyjh/elfin/floatview/XunFeiFloatManager;

    return-object v0

    .line 81
    :catchall_0
    move-exception v0

    :try_start_1
    monitor-exit v1
    :try_end_1
    .catchall {:try_start_1 .. :try_end_1} :catchall_0

    throw v0
.end method

.method private initEvent()V
    .locals 2

    .prologue
    .line 34
    invoke-static {}, Lcom/cyjh/elfin/AppContext;->getInstance()Lcom/cyjh/elfin/AppContext;

    move-result-object v0

    new-instance v1, Lcom/cyjh/elfin/floatview/XunFeiFloatManager$1;

    invoke-direct {v1, p0}, Lcom/cyjh/elfin/floatview/XunFeiFloatManager$1;-><init>(Lcom/cyjh/elfin/floatview/XunFeiFloatManager;)V

    invoke-virtual {v0, v1}, Lcom/cyjh/elfin/AppContext;->setScreenConversion(Lcom/cyjh/elfin/AppContext$ScreenOrientationConversion;)V

    .line 55
    return-void
.end method

.method private initFloat()V
    .locals 2

    .prologue
    .line 58
    iget-object v0, p0, Lcom/cyjh/elfin/floatview/XunFeiFloatManager;->context:Landroid/content/Context;

    const-string v1, "window"

    invoke-virtual {v0, v1}, Landroid/content/Context;->getSystemService(Ljava/lang/String;)Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Landroid/view/WindowManager;

    iput-object v0, p0, Lcom/cyjh/elfin/floatview/XunFeiFloatManager;->wm:Landroid/view/WindowManager;

    .line 59
    new-instance v0, Landroid/view/WindowManager$LayoutParams;

    invoke-direct {v0}, Landroid/view/WindowManager$LayoutParams;-><init>()V

    iput-object v0, p0, Lcom/cyjh/elfin/floatview/XunFeiFloatManager;->params:Landroid/view/WindowManager$LayoutParams;

    .line 61
    iget-object v0, p0, Lcom/cyjh/elfin/floatview/XunFeiFloatManager;->params:Landroid/view/WindowManager$LayoutParams;

    const/4 v1, 0x1

    iput v1, v0, Landroid/view/WindowManager$LayoutParams;->format:I

    .line 62
    sget v0, Landroid/os/Build$VERSION;->SDK_INT:I

    const/16 v1, 0x13

    if-lt v0, v1, :cond_0

    sget v0, Landroid/os/Build$VERSION;->SDK_INT:I

    const/16 v1, 0x18

    if-ge v0, v1, :cond_0

    .line 64
    iget-object v0, p0, Lcom/cyjh/elfin/floatview/XunFeiFloatManager;->params:Landroid/view/WindowManager$LayoutParams;

    const/16 v1, 0x7d5

    iput v1, v0, Landroid/view/WindowManager$LayoutParams;->type:I

    .line 72
    :goto_0
    iget-object v0, p0, Lcom/cyjh/elfin/floatview/XunFeiFloatManager;->params:Landroid/view/WindowManager$LayoutParams;

    const/16 v1, 0x28

    iput v1, v0, Landroid/view/WindowManager$LayoutParams;->flags:I

    .line 73
    return-void

    .line 67
    :cond_0
    iget-object v0, p0, Lcom/cyjh/elfin/floatview/XunFeiFloatManager;->params:Landroid/view/WindowManager$LayoutParams;

    const/16 v1, 0x7d2

    iput v1, v0, Landroid/view/WindowManager$LayoutParams;->type:I

    goto :goto_0
.end method


# virtual methods
.method public addBigFloat()V
    .locals 3

    .prologue
    const/4 v2, 0x0

    .line 103
    const/4 v0, 0x1

    iput-boolean v0, p0, Lcom/cyjh/elfin/floatview/XunFeiFloatManager;->isAddBig:Z

    .line 104
    iget-object v0, p0, Lcom/cyjh/elfin/floatview/XunFeiFloatManager;->params:Landroid/view/WindowManager$LayoutParams;

    invoke-virtual {p0}, Lcom/cyjh/elfin/floatview/XunFeiFloatManager;->getScreenWidth()I

    move-result v1

    iput v1, v0, Landroid/view/WindowManager$LayoutParams;->width:I

    .line 105
    iget-object v0, p0, Lcom/cyjh/elfin/floatview/XunFeiFloatManager;->params:Landroid/view/WindowManager$LayoutParams;

    const/4 v1, -0x2

    iput v1, v0, Landroid/view/WindowManager$LayoutParams;->height:I

    .line 106
    iget-object v0, p0, Lcom/cyjh/elfin/floatview/XunFeiFloatManager;->params:Landroid/view/WindowManager$LayoutParams;

    const/16 v1, 0x53

    iput v1, v0, Landroid/view/WindowManager$LayoutParams;->gravity:I

    .line 107
    iget-object v0, p0, Lcom/cyjh/elfin/floatview/XunFeiFloatManager;->params:Landroid/view/WindowManager$LayoutParams;

    iput v2, v0, Landroid/view/WindowManager$LayoutParams;->x:I

    .line 108
    iget-object v0, p0, Lcom/cyjh/elfin/floatview/XunFeiFloatManager;->params:Landroid/view/WindowManager$LayoutParams;

    iput v2, v0, Landroid/view/WindowManager$LayoutParams;->y:I

    .line 109
    iget-object v0, p0, Lcom/cyjh/elfin/floatview/XunFeiFloatManager;->wm:Landroid/view/WindowManager;

    iget-object v1, p0, Lcom/cyjh/elfin/floatview/XunFeiFloatManager;->mFloatDisplayXunFei:Lcom/cyjh/elfin/floatview/BottomScreenDisplayXunFeiFloat;

    iget-object v2, p0, Lcom/cyjh/elfin/floatview/XunFeiFloatManager;->params:Landroid/view/WindowManager$LayoutParams;

    invoke-interface {v0, v1, v2}, Landroid/view/WindowManager;->addView(Landroid/view/View;Landroid/view/ViewGroup$LayoutParams;)V

    .line 110
    return-void
.end method

.method public getScreenHeight()I
    .locals 1

    .prologue
    .line 99
    iget-object v0, p0, Lcom/cyjh/elfin/floatview/XunFeiFloatManager;->wm:Landroid/view/WindowManager;

    invoke-interface {v0}, Landroid/view/WindowManager;->getDefaultDisplay()Landroid/view/Display;

    move-result-object v0

    invoke-virtual {v0}, Landroid/view/Display;->getHeight()I

    move-result v0

    return v0
.end method

.method public getScreenWidth()I
    .locals 1

    .prologue
    .line 91
    iget-object v0, p0, Lcom/cyjh/elfin/floatview/XunFeiFloatManager;->wm:Landroid/view/WindowManager;

    invoke-interface {v0}, Landroid/view/WindowManager;->getDefaultDisplay()Landroid/view/Display;

    move-result-object v0

    invoke-virtual {v0}, Landroid/view/Display;->getWidth()I

    move-result v0

    return v0
.end method

.method public removeAll()V
    .locals 1

    .prologue
    .line 121
    iget-object v0, p0, Lcom/cyjh/elfin/floatview/XunFeiFloatManager;->wm:Landroid/view/WindowManager;

    if-eqz v0, :cond_0

    .line 122
    iget-boolean v0, p0, Lcom/cyjh/elfin/floatview/XunFeiFloatManager;->isAddBig:Z

    if-eqz v0, :cond_0

    .line 123
    invoke-virtual {p0}, Lcom/cyjh/elfin/floatview/XunFeiFloatManager;->removeBigFloat()V

    .line 126
    :cond_0
    return-void
.end method

.method public removeBigFloat()V
    .locals 2

    .prologue
    .line 114
    iget-boolean v0, p0, Lcom/cyjh/elfin/floatview/XunFeiFloatManager;->isAddBig:Z

    if-eqz v0, :cond_0

    .line 115
    const/4 v0, 0x0

    iput-boolean v0, p0, Lcom/cyjh/elfin/floatview/XunFeiFloatManager;->isAddBig:Z

    .line 116
    iget-object v0, p0, Lcom/cyjh/elfin/floatview/XunFeiFloatManager;->wm:Landroid/view/WindowManager;

    iget-object v1, p0, Lcom/cyjh/elfin/floatview/XunFeiFloatManager;->mFloatDisplayXunFei:Lcom/cyjh/elfin/floatview/BottomScreenDisplayXunFeiFloat;

    invoke-interface {v0, v1}, Landroid/view/WindowManager;->removeView(Landroid/view/View;)V

    .line 118
    :cond_0
    return-void
.end method
