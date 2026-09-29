.class public Lcom/lidroid/xutils/bitmap/BitmapDisplayConfig;
.super Ljava/lang/Object;
.source "SourceFile"


# instance fields
.field private animation:Landroid/view/animation/Animation;

.field private autoRotation:Z

.field private bitmapConfig:Landroid/graphics/Bitmap$Config;

.field private bitmapFactory:Lcom/lidroid/xutils/bitmap/factory/BitmapFactory;

.field private bitmapMaxSize:Lcom/lidroid/xutils/bitmap/core/BitmapSize;

.field private loadFailedDrawable:Landroid/graphics/drawable/Drawable;

.field private loadingDrawable:Landroid/graphics/drawable/Drawable;

.field private priority:Lcom/lidroid/xutils/task/Priority;

.field private showOriginal:Z


# direct methods
.method public constructor <init>()V
    .locals 1

    .prologue
    const/4 v0, 0x0

    .line 38
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    .line 31
    iput-boolean v0, p0, Lcom/lidroid/xutils/bitmap/BitmapDisplayConfig;->autoRotation:Z

    .line 32
    iput-boolean v0, p0, Lcom/lidroid/xutils/bitmap/BitmapDisplayConfig;->showOriginal:Z

    .line 33
    sget-object v0, Landroid/graphics/Bitmap$Config;->RGB_565:Landroid/graphics/Bitmap$Config;

    iput-object v0, p0, Lcom/lidroid/xutils/bitmap/BitmapDisplayConfig;->bitmapConfig:Landroid/graphics/Bitmap$Config;

    .line 39
    return-void
.end method


# virtual methods
.method public cloneNew()Lcom/lidroid/xutils/bitmap/BitmapDisplayConfig;
    .locals 2

    .prologue
    .line 120
    new-instance v0, Lcom/lidroid/xutils/bitmap/BitmapDisplayConfig;

    invoke-direct {v0}, Lcom/lidroid/xutils/bitmap/BitmapDisplayConfig;-><init>()V

    .line 121
    iget-object v1, p0, Lcom/lidroid/xutils/bitmap/BitmapDisplayConfig;->bitmapMaxSize:Lcom/lidroid/xutils/bitmap/core/BitmapSize;

    iput-object v1, v0, Lcom/lidroid/xutils/bitmap/BitmapDisplayConfig;->bitmapMaxSize:Lcom/lidroid/xutils/bitmap/core/BitmapSize;

    .line 122
    iget-object v1, p0, Lcom/lidroid/xutils/bitmap/BitmapDisplayConfig;->animation:Landroid/view/animation/Animation;

    iput-object v1, v0, Lcom/lidroid/xutils/bitmap/BitmapDisplayConfig;->animation:Landroid/view/animation/Animation;

    .line 123
    iget-object v1, p0, Lcom/lidroid/xutils/bitmap/BitmapDisplayConfig;->loadingDrawable:Landroid/graphics/drawable/Drawable;

    iput-object v1, v0, Lcom/lidroid/xutils/bitmap/BitmapDisplayConfig;->loadingDrawable:Landroid/graphics/drawable/Drawable;

    .line 124
    iget-object v1, p0, Lcom/lidroid/xutils/bitmap/BitmapDisplayConfig;->loadFailedDrawable:Landroid/graphics/drawable/Drawable;

    iput-object v1, v0, Lcom/lidroid/xutils/bitmap/BitmapDisplayConfig;->loadFailedDrawable:Landroid/graphics/drawable/Drawable;

    .line 125
    iget-boolean v1, p0, Lcom/lidroid/xutils/bitmap/BitmapDisplayConfig;->autoRotation:Z

    iput-boolean v1, v0, Lcom/lidroid/xutils/bitmap/BitmapDisplayConfig;->autoRotation:Z

    .line 126
    iget-boolean v1, p0, Lcom/lidroid/xutils/bitmap/BitmapDisplayConfig;->showOriginal:Z

    iput-boolean v1, v0, Lcom/lidroid/xutils/bitmap/BitmapDisplayConfig;->showOriginal:Z

    .line 127
    iget-object v1, p0, Lcom/lidroid/xutils/bitmap/BitmapDisplayConfig;->bitmapConfig:Landroid/graphics/Bitmap$Config;

    iput-object v1, v0, Lcom/lidroid/xutils/bitmap/BitmapDisplayConfig;->bitmapConfig:Landroid/graphics/Bitmap$Config;

    .line 128
    iget-object v1, p0, Lcom/lidroid/xutils/bitmap/BitmapDisplayConfig;->bitmapFactory:Lcom/lidroid/xutils/bitmap/factory/BitmapFactory;

    iput-object v1, v0, Lcom/lidroid/xutils/bitmap/BitmapDisplayConfig;->bitmapFactory:Lcom/lidroid/xutils/bitmap/factory/BitmapFactory;

    .line 129
    iget-object v1, p0, Lcom/lidroid/xutils/bitmap/BitmapDisplayConfig;->priority:Lcom/lidroid/xutils/task/Priority;

    iput-object v1, v0, Lcom/lidroid/xutils/bitmap/BitmapDisplayConfig;->priority:Lcom/lidroid/xutils/task/Priority;

    .line 130
    return-object v0
.end method

.method public getAnimation()Landroid/view/animation/Animation;
    .locals 1

    .prologue
    .line 50
    iget-object v0, p0, Lcom/lidroid/xutils/bitmap/BitmapDisplayConfig;->animation:Landroid/view/animation/Animation;

    return-object v0
.end method

.method public getBitmapConfig()Landroid/graphics/Bitmap$Config;
    .locals 1

    .prologue
    .line 90
    iget-object v0, p0, Lcom/lidroid/xutils/bitmap/BitmapDisplayConfig;->bitmapConfig:Landroid/graphics/Bitmap$Config;

    return-object v0
.end method

.method public getBitmapFactory()Lcom/lidroid/xutils/bitmap/factory/BitmapFactory;
    .locals 1

    .prologue
    .line 98
    iget-object v0, p0, Lcom/lidroid/xutils/bitmap/BitmapDisplayConfig;->bitmapFactory:Lcom/lidroid/xutils/bitmap/factory/BitmapFactory;

    return-object v0
.end method

.method public getBitmapMaxSize()Lcom/lidroid/xutils/bitmap/core/BitmapSize;
    .locals 1

    .prologue
    .line 42
    iget-object v0, p0, Lcom/lidroid/xutils/bitmap/BitmapDisplayConfig;->bitmapMaxSize:Lcom/lidroid/xutils/bitmap/core/BitmapSize;

    if-nez v0, :cond_0

    sget-object v0, Lcom/lidroid/xutils/bitmap/core/BitmapSize;->ZERO:Lcom/lidroid/xutils/bitmap/core/BitmapSize;

    :goto_0
    return-object v0

    :cond_0
    iget-object v0, p0, Lcom/lidroid/xutils/bitmap/BitmapDisplayConfig;->bitmapMaxSize:Lcom/lidroid/xutils/bitmap/core/BitmapSize;

    goto :goto_0
.end method

.method public getLoadFailedDrawable()Landroid/graphics/drawable/Drawable;
    .locals 1

    .prologue
    .line 66
    iget-object v0, p0, Lcom/lidroid/xutils/bitmap/BitmapDisplayConfig;->loadFailedDrawable:Landroid/graphics/drawable/Drawable;

    return-object v0
.end method

.method public getLoadingDrawable()Landroid/graphics/drawable/Drawable;
    .locals 1

    .prologue
    .line 58
    iget-object v0, p0, Lcom/lidroid/xutils/bitmap/BitmapDisplayConfig;->loadingDrawable:Landroid/graphics/drawable/Drawable;

    return-object v0
.end method

.method public getPriority()Lcom/lidroid/xutils/task/Priority;
    .locals 1

    .prologue
    .line 106
    iget-object v0, p0, Lcom/lidroid/xutils/bitmap/BitmapDisplayConfig;->priority:Lcom/lidroid/xutils/task/Priority;

    return-object v0
.end method

.method public isAutoRotation()Z
    .locals 1

    .prologue
    .line 74
    iget-boolean v0, p0, Lcom/lidroid/xutils/bitmap/BitmapDisplayConfig;->autoRotation:Z

    return v0
.end method

.method public isShowOriginal()Z
    .locals 1

    .prologue
    .line 82
    iget-boolean v0, p0, Lcom/lidroid/xutils/bitmap/BitmapDisplayConfig;->showOriginal:Z

    return v0
.end method

.method public setAnimation(Landroid/view/animation/Animation;)V
    .locals 0

    .prologue
    .line 54
    iput-object p1, p0, Lcom/lidroid/xutils/bitmap/BitmapDisplayConfig;->animation:Landroid/view/animation/Animation;

    .line 55
    return-void
.end method

.method public setAutoRotation(Z)V
    .locals 0

    .prologue
    .line 78
    iput-boolean p1, p0, Lcom/lidroid/xutils/bitmap/BitmapDisplayConfig;->autoRotation:Z

    .line 79
    return-void
.end method

.method public setBitmapConfig(Landroid/graphics/Bitmap$Config;)V
    .locals 0

    .prologue
    .line 94
    iput-object p1, p0, Lcom/lidroid/xutils/bitmap/BitmapDisplayConfig;->bitmapConfig:Landroid/graphics/Bitmap$Config;

    .line 95
    return-void
.end method

.method public setBitmapFactory(Lcom/lidroid/xutils/bitmap/factory/BitmapFactory;)V
    .locals 0

    .prologue
    .line 102
    iput-object p1, p0, Lcom/lidroid/xutils/bitmap/BitmapDisplayConfig;->bitmapFactory:Lcom/lidroid/xutils/bitmap/factory/BitmapFactory;

    .line 103
    return-void
.end method

.method public setBitmapMaxSize(Lcom/lidroid/xutils/bitmap/core/BitmapSize;)V
    .locals 0

    .prologue
    .line 46
    iput-object p1, p0, Lcom/lidroid/xutils/bitmap/BitmapDisplayConfig;->bitmapMaxSize:Lcom/lidroid/xutils/bitmap/core/BitmapSize;

    .line 47
    return-void
.end method

.method public setLoadFailedDrawable(Landroid/graphics/drawable/Drawable;)V
    .locals 0

    .prologue
    .line 70
    iput-object p1, p0, Lcom/lidroid/xutils/bitmap/BitmapDisplayConfig;->loadFailedDrawable:Landroid/graphics/drawable/Drawable;

    .line 71
    return-void
.end method

.method public setLoadingDrawable(Landroid/graphics/drawable/Drawable;)V
    .locals 0

    .prologue
    .line 62
    iput-object p1, p0, Lcom/lidroid/xutils/bitmap/BitmapDisplayConfig;->loadingDrawable:Landroid/graphics/drawable/Drawable;

    .line 63
    return-void
.end method

.method public setPriority(Lcom/lidroid/xutils/task/Priority;)V
    .locals 0

    .prologue
    .line 110
    iput-object p1, p0, Lcom/lidroid/xutils/bitmap/BitmapDisplayConfig;->priority:Lcom/lidroid/xutils/task/Priority;

    .line 111
    return-void
.end method

.method public setShowOriginal(Z)V
    .locals 0

    .prologue
    .line 86
    iput-boolean p1, p0, Lcom/lidroid/xutils/bitmap/BitmapDisplayConfig;->showOriginal:Z

    .line 87
    return-void
.end method

.method public toString()Ljava/lang/String;
    .locals 2

    .prologue
    .line 115
    new-instance v1, Ljava/lang/StringBuilder;

    invoke-virtual {p0}, Lcom/lidroid/xutils/bitmap/BitmapDisplayConfig;->isShowOriginal()Z

    move-result v0

    if-eqz v0, :cond_0

    const-string v0, ""

    :goto_0
    invoke-static {v0}, Ljava/lang/String;->valueOf(Ljava/lang/Object;)Ljava/lang/String;

    move-result-object v0

    invoke-direct {v1, v0}, Ljava/lang/StringBuilder;-><init>(Ljava/lang/String;)V

    .line 116
    iget-object v0, p0, Lcom/lidroid/xutils/bitmap/BitmapDisplayConfig;->bitmapFactory:Lcom/lidroid/xutils/bitmap/factory/BitmapFactory;

    if-nez v0, :cond_1

    const-string v0, ""

    :goto_1
    invoke-virtual {v1, v0}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    .line 115
    invoke-virtual {v0}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v0

    return-object v0

    :cond_0
    iget-object v0, p0, Lcom/lidroid/xutils/bitmap/BitmapDisplayConfig;->bitmapMaxSize:Lcom/lidroid/xutils/bitmap/core/BitmapSize;

    invoke-virtual {v0}, Lcom/lidroid/xutils/bitmap/core/BitmapSize;->toString()Ljava/lang/String;

    move-result-object v0

    goto :goto_0

    .line 116
    :cond_1
    iget-object v0, p0, Lcom/lidroid/xutils/bitmap/BitmapDisplayConfig;->bitmapFactory:Lcom/lidroid/xutils/bitmap/factory/BitmapFactory;

    invoke-virtual {v0}, Ljava/lang/Object;->getClass()Ljava/lang/Class;

    move-result-object v0

    invoke-virtual {v0}, Ljava/lang/Class;->getName()Ljava/lang/String;

    move-result-object v0

    goto :goto_1
.end method
