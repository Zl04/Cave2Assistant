.class Lcom/cyjh/elfin/dialog/ScriptUIDialog$1;
.super Ljava/lang/Object;
.source "ScriptUIDialog.java"

# interfaces
.implements Lcom/cyjh/elfin/AppContext$ScreenOrientationConversion;


# annotations
.annotation system Ldalvik/annotation/EnclosingMethod;
    value = Lcom/cyjh/elfin/dialog/ScriptUIDialog;->initEvent()V
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x0
    name = null
.end annotation


# instance fields
.field final synthetic this$0:Lcom/cyjh/elfin/dialog/ScriptUIDialog;


# direct methods
.method constructor <init>(Lcom/cyjh/elfin/dialog/ScriptUIDialog;)V
    .locals 0
    .param p1, "this$0"    # Lcom/cyjh/elfin/dialog/ScriptUIDialog;

    .prologue
    .line 102
    iput-object p1, p0, Lcom/cyjh/elfin/dialog/ScriptUIDialog$1;->this$0:Lcom/cyjh/elfin/dialog/ScriptUIDialog;

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method


# virtual methods
.method public onLandscapeOrientation()V
    .locals 5

    .prologue
    .line 105
    iget-object v0, p0, Lcom/cyjh/elfin/dialog/ScriptUIDialog$1;->this$0:Lcom/cyjh/elfin/dialog/ScriptUIDialog;

    const v1, 0x3f666666    # 0.9f

    const v2, 0x3f4ccccd    # 0.8f

    const/4 v3, 0x2

    const/4 v4, 0x0

    invoke-static {v0, v1, v2, v3, v4}, Lcom/cyjh/elfin/dialog/ScriptUIDialog;->access$000(Lcom/cyjh/elfin/dialog/ScriptUIDialog;FFIZ)V

    .line 106
    return-void
.end method

.method public onPortraitOrientation()V
    .locals 5

    .prologue
    .line 109
    iget-object v0, p0, Lcom/cyjh/elfin/dialog/ScriptUIDialog$1;->this$0:Lcom/cyjh/elfin/dialog/ScriptUIDialog;

    const v1, 0x3f666666    # 0.9f

    const v2, 0x3f19999a    # 0.6f

    const/4 v3, 0x1

    const/4 v4, 0x0

    invoke-static {v0, v1, v2, v3, v4}, Lcom/cyjh/elfin/dialog/ScriptUIDialog;->access$000(Lcom/cyjh/elfin/dialog/ScriptUIDialog;FFIZ)V

    .line 110
    return-void
.end method
