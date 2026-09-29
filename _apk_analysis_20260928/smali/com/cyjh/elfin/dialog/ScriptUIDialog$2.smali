.class Lcom/cyjh/elfin/dialog/ScriptUIDialog$2;
.super Ljava/lang/Object;
.source "ScriptUIDialog.java"

# interfaces
.implements Ljava/lang/Runnable;


# annotations
.annotation system Ldalvik/annotation/EnclosingMethod;
    value = Lcom/cyjh/elfin/dialog/ScriptUIDialog;->convertScreen(FFIZ)V
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x0
    name = null
.end annotation


# instance fields
.field final synthetic this$0:Lcom/cyjh/elfin/dialog/ScriptUIDialog;

.field final synthetic val$flag:I

.field final synthetic val$height:F

.field final synthetic val$isCreatedFirst:Z

.field final synthetic val$width:F


# direct methods
.method constructor <init>(Lcom/cyjh/elfin/dialog/ScriptUIDialog;FFIZ)V
    .locals 0
    .param p1, "this$0"    # Lcom/cyjh/elfin/dialog/ScriptUIDialog;

    .prologue
    .line 117
    iput-object p1, p0, Lcom/cyjh/elfin/dialog/ScriptUIDialog$2;->this$0:Lcom/cyjh/elfin/dialog/ScriptUIDialog;

    iput p2, p0, Lcom/cyjh/elfin/dialog/ScriptUIDialog$2;->val$width:F

    iput p3, p0, Lcom/cyjh/elfin/dialog/ScriptUIDialog$2;->val$height:F

    iput p4, p0, Lcom/cyjh/elfin/dialog/ScriptUIDialog$2;->val$flag:I

    iput-boolean p5, p0, Lcom/cyjh/elfin/dialog/ScriptUIDialog$2;->val$isCreatedFirst:Z

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method


# virtual methods
.method public run()V
    .locals 3

    .prologue
    .line 120
    iget-object v0, p0, Lcom/cyjh/elfin/dialog/ScriptUIDialog$2;->this$0:Lcom/cyjh/elfin/dialog/ScriptUIDialog;

    iget v1, p0, Lcom/cyjh/elfin/dialog/ScriptUIDialog$2;->val$width:F

    iget v2, p0, Lcom/cyjh/elfin/dialog/ScriptUIDialog$2;->val$height:F

    invoke-virtual {v0, v1, v2}, Lcom/cyjh/elfin/dialog/ScriptUIDialog;->setDialogSize(FF)V

    .line 121
    iget-object v0, p0, Lcom/cyjh/elfin/dialog/ScriptUIDialog$2;->this$0:Lcom/cyjh/elfin/dialog/ScriptUIDialog;

    iget v1, p0, Lcom/cyjh/elfin/dialog/ScriptUIDialog$2;->val$flag:I

    iget-boolean v2, p0, Lcom/cyjh/elfin/dialog/ScriptUIDialog$2;->val$isCreatedFirst:Z

    invoke-static {v0, v1, v2}, Lcom/cyjh/elfin/dialog/ScriptUIDialog;->access$100(Lcom/cyjh/elfin/dialog/ScriptUIDialog;IZ)V

    .line 122
    iget-object v0, p0, Lcom/cyjh/elfin/dialog/ScriptUIDialog$2;->this$0:Lcom/cyjh/elfin/dialog/ScriptUIDialog;

    invoke-virtual {v0}, Lcom/cyjh/elfin/dialog/ScriptUIDialog;->show()V

    .line 123
    return-void
.end method
