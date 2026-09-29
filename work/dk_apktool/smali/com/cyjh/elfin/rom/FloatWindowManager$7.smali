.class Lcom/cyjh/elfin/rom/FloatWindowManager$7;
.super Ljava/lang/Object;
.source "FloatWindowManager.java"

# interfaces
.implements Lcom/cyjh/elfin/dialog/FloatGuideDialog$OnConfirmResult;


# annotations
.annotation system Ldalvik/annotation/EnclosingMethod;
    value = Lcom/cyjh/elfin/rom/FloatWindowManager;->showConfirmDialog(Landroid/content/Context;Ljava/lang/String;Lcom/cyjh/elfin/rom/FloatWindowManager$OnConfirmResult;)V
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x0
    name = null
.end annotation


# instance fields
.field final synthetic this$0:Lcom/cyjh/elfin/rom/FloatWindowManager;

.field final synthetic val$result:Lcom/cyjh/elfin/rom/FloatWindowManager$OnConfirmResult;


# direct methods
.method constructor <init>(Lcom/cyjh/elfin/rom/FloatWindowManager;Lcom/cyjh/elfin/rom/FloatWindowManager$OnConfirmResult;)V
    .locals 0
    .param p1, "this$0"    # Lcom/cyjh/elfin/rom/FloatWindowManager;

    .prologue
    .line 266
    iput-object p1, p0, Lcom/cyjh/elfin/rom/FloatWindowManager$7;->this$0:Lcom/cyjh/elfin/rom/FloatWindowManager;

    iput-object p2, p0, Lcom/cyjh/elfin/rom/FloatWindowManager$7;->val$result:Lcom/cyjh/elfin/rom/FloatWindowManager$OnConfirmResult;

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method


# virtual methods
.method public confirmResult(Z)V
    .locals 1
    .param p1, "confirm"    # Z

    .prologue
    .line 269
    iget-object v0, p0, Lcom/cyjh/elfin/rom/FloatWindowManager$7;->val$result:Lcom/cyjh/elfin/rom/FloatWindowManager$OnConfirmResult;

    invoke-interface {v0, p1}, Lcom/cyjh/elfin/rom/FloatWindowManager$OnConfirmResult;->confirmResult(Z)V

    .line 270
    iget-object v0, p0, Lcom/cyjh/elfin/rom/FloatWindowManager$7;->this$0:Lcom/cyjh/elfin/rom/FloatWindowManager;

    invoke-static {v0}, Lcom/cyjh/elfin/rom/FloatWindowManager;->access$000(Lcom/cyjh/elfin/rom/FloatWindowManager;)Lcom/cyjh/elfin/dialog/FloatGuideDialog;

    move-result-object v0

    invoke-virtual {v0}, Lcom/cyjh/elfin/dialog/FloatGuideDialog;->dismiss()V

    .line 271
    return-void
.end method
