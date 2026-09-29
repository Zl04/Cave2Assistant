.class Lcom/cyjh/elfin/dialog/ScriptUIDialog$3;
.super Ljava/lang/Object;
.source "ScriptUIDialog.java"

# interfaces
.implements Landroid/content/DialogInterface$OnDismissListener;


# annotations
.annotation system Ldalvik/annotation/EnclosingMethod;
    value = Lcom/cyjh/elfin/dialog/ScriptUIDialog;->onClick(Landroid/view/View;)V
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x0
    name = null
.end annotation


# instance fields
.field final synthetic this$0:Lcom/cyjh/elfin/dialog/ScriptUIDialog;

.field final synthetic val$settingDialog:Lcom/cyjh/elfin/dialog/SettingDialog;


# direct methods
.method constructor <init>(Lcom/cyjh/elfin/dialog/ScriptUIDialog;Lcom/cyjh/elfin/dialog/SettingDialog;)V
    .locals 0
    .param p1, "this$0"    # Lcom/cyjh/elfin/dialog/ScriptUIDialog;

    .prologue
    .line 642
    iput-object p1, p0, Lcom/cyjh/elfin/dialog/ScriptUIDialog$3;->this$0:Lcom/cyjh/elfin/dialog/ScriptUIDialog;

    iput-object p2, p0, Lcom/cyjh/elfin/dialog/ScriptUIDialog$3;->val$settingDialog:Lcom/cyjh/elfin/dialog/SettingDialog;

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method


# virtual methods
.method public onDismiss(Landroid/content/DialogInterface;)V
    .locals 1
    .param p1, "dialog"    # Landroid/content/DialogInterface;

    .prologue
    .line 646
    iget-object v0, p0, Lcom/cyjh/elfin/dialog/ScriptUIDialog$3;->val$settingDialog:Lcom/cyjh/elfin/dialog/SettingDialog;

    invoke-virtual {v0}, Lcom/cyjh/elfin/dialog/SettingDialog;->isDismiss()Z

    move-result v0

    if-eqz v0, :cond_0

    .line 647
    iget-object v0, p0, Lcom/cyjh/elfin/dialog/ScriptUIDialog$3;->this$0:Lcom/cyjh/elfin/dialog/ScriptUIDialog;

    invoke-virtual {v0}, Lcom/cyjh/elfin/dialog/ScriptUIDialog;->dismiss()V

    .line 649
    :cond_0
    return-void
.end method
