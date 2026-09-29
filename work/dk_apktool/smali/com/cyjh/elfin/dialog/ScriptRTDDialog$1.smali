.class Lcom/cyjh/elfin/dialog/ScriptRTDDialog$1;
.super Ljava/lang/Object;
.source "ScriptRTDDialog.java"

# interfaces
.implements Lcom/cyjh/elfin/AppContext$ScreenOrientationConversion;


# annotations
.annotation system Ldalvik/annotation/EnclosingMethod;
    value = Lcom/cyjh/elfin/dialog/ScriptRTDDialog;->initEvent()V
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x0
    name = null
.end annotation


# instance fields
.field final synthetic this$0:Lcom/cyjh/elfin/dialog/ScriptRTDDialog;


# direct methods
.method constructor <init>(Lcom/cyjh/elfin/dialog/ScriptRTDDialog;)V
    .locals 0
    .param p1, "this$0"    # Lcom/cyjh/elfin/dialog/ScriptRTDDialog;

    .prologue
    .line 51
    iput-object p1, p0, Lcom/cyjh/elfin/dialog/ScriptRTDDialog$1;->this$0:Lcom/cyjh/elfin/dialog/ScriptRTDDialog;

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method


# virtual methods
.method public onLandscapeOrientation()V
    .locals 3

    .prologue
    .line 54
    iget-object v0, p0, Lcom/cyjh/elfin/dialog/ScriptRTDDialog$1;->this$0:Lcom/cyjh/elfin/dialog/ScriptRTDDialog;

    const v1, 0x3f666666    # 0.9f

    const v2, 0x3f4ccccd    # 0.8f

    invoke-static {v0, v1, v2}, Lcom/cyjh/elfin/dialog/ScriptRTDDialog;->access$000(Lcom/cyjh/elfin/dialog/ScriptRTDDialog;FF)V

    .line 55
    return-void
.end method

.method public onPortraitOrientation()V
    .locals 3

    .prologue
    .line 58
    iget-object v0, p0, Lcom/cyjh/elfin/dialog/ScriptRTDDialog$1;->this$0:Lcom/cyjh/elfin/dialog/ScriptRTDDialog;

    const v1, 0x3f666666    # 0.9f

    const v2, 0x3f19999a    # 0.6f

    invoke-static {v0, v1, v2}, Lcom/cyjh/elfin/dialog/ScriptRTDDialog;->access$000(Lcom/cyjh/elfin/dialog/ScriptRTDDialog;FF)V

    .line 59
    return-void
.end method
