.class Lcom/cyjh/elfin/floatview/XunFeiFloatManager$1;
.super Ljava/lang/Object;
.source "XunFeiFloatManager.java"

# interfaces
.implements Lcom/cyjh/elfin/AppContext$ScreenOrientationConversion;


# annotations
.annotation system Ldalvik/annotation/EnclosingMethod;
    value = Lcom/cyjh/elfin/floatview/XunFeiFloatManager;->initEvent()V
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x0
    name = null
.end annotation


# instance fields
.field final synthetic this$0:Lcom/cyjh/elfin/floatview/XunFeiFloatManager;


# direct methods
.method constructor <init>(Lcom/cyjh/elfin/floatview/XunFeiFloatManager;)V
    .locals 0
    .param p1, "this$0"    # Lcom/cyjh/elfin/floatview/XunFeiFloatManager;

    .prologue
    .line 34
    iput-object p1, p0, Lcom/cyjh/elfin/floatview/XunFeiFloatManager$1;->this$0:Lcom/cyjh/elfin/floatview/XunFeiFloatManager;

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method


# virtual methods
.method public onLandscapeOrientation()V
    .locals 2

    .prologue
    .line 37
    const-string v0, "zzz"

    const-string v1, "new AppContext.ScreenOrientationConversion()--onLandscapeOrientation-1"

    invoke-static {v0, v1}, Landroid/util/Log;->e(Ljava/lang/String;Ljava/lang/String;)I

    .line 38
    iget-object v0, p0, Lcom/cyjh/elfin/floatview/XunFeiFloatManager$1;->this$0:Lcom/cyjh/elfin/floatview/XunFeiFloatManager;

    invoke-static {v0}, Lcom/cyjh/elfin/floatview/XunFeiFloatManager;->access$000(Lcom/cyjh/elfin/floatview/XunFeiFloatManager;)Lcom/cyjh/elfin/floatview/BottomScreenDisplayXunFeiFloat;

    move-result-object v0

    iget-boolean v0, v0, Lcom/cyjh/elfin/floatview/BottomScreenDisplayXunFeiFloat;->isDisplayComplete:Z

    if-nez v0, :cond_0

    .line 39
    const-string v0, "zzz"

    const-string v1, "new AppContext.ScreenOrientationConversion()--onLandscapeOrientation-"

    invoke-static {v0, v1}, Landroid/util/Log;->e(Ljava/lang/String;Ljava/lang/String;)I

    .line 40
    iget-object v0, p0, Lcom/cyjh/elfin/floatview/XunFeiFloatManager$1;->this$0:Lcom/cyjh/elfin/floatview/XunFeiFloatManager;

    invoke-virtual {v0}, Lcom/cyjh/elfin/floatview/XunFeiFloatManager;->removeBigFloat()V

    .line 41
    iget-object v0, p0, Lcom/cyjh/elfin/floatview/XunFeiFloatManager$1;->this$0:Lcom/cyjh/elfin/floatview/XunFeiFloatManager;

    invoke-virtual {v0}, Lcom/cyjh/elfin/floatview/XunFeiFloatManager;->addBigFloat()V

    .line 43
    :cond_0
    return-void
.end method

.method public onPortraitOrientation()V
    .locals 2

    .prologue
    .line 47
    const-string v0, "zzz"

    const-string v1, "new AppContext.ScreenOrientationConversion()--onPortraitOrientation-1"

    invoke-static {v0, v1}, Landroid/util/Log;->e(Ljava/lang/String;Ljava/lang/String;)I

    .line 48
    iget-object v0, p0, Lcom/cyjh/elfin/floatview/XunFeiFloatManager$1;->this$0:Lcom/cyjh/elfin/floatview/XunFeiFloatManager;

    invoke-static {v0}, Lcom/cyjh/elfin/floatview/XunFeiFloatManager;->access$000(Lcom/cyjh/elfin/floatview/XunFeiFloatManager;)Lcom/cyjh/elfin/floatview/BottomScreenDisplayXunFeiFloat;

    move-result-object v0

    iget-boolean v0, v0, Lcom/cyjh/elfin/floatview/BottomScreenDisplayXunFeiFloat;->isDisplayComplete:Z

    if-nez v0, :cond_0

    .line 49
    const-string v0, "zzz"

    const-string v1, "new AppContext.ScreenOrientationConversion()--onPortraitOrientation-"

    invoke-static {v0, v1}, Landroid/util/Log;->e(Ljava/lang/String;Ljava/lang/String;)I

    .line 50
    iget-object v0, p0, Lcom/cyjh/elfin/floatview/XunFeiFloatManager$1;->this$0:Lcom/cyjh/elfin/floatview/XunFeiFloatManager;

    invoke-virtual {v0}, Lcom/cyjh/elfin/floatview/XunFeiFloatManager;->removeBigFloat()V

    .line 51
    iget-object v0, p0, Lcom/cyjh/elfin/floatview/XunFeiFloatManager$1;->this$0:Lcom/cyjh/elfin/floatview/XunFeiFloatManager;

    invoke-virtual {v0}, Lcom/cyjh/elfin/floatview/XunFeiFloatManager;->addBigFloat()V

    .line 53
    :cond_0
    return-void
.end method
