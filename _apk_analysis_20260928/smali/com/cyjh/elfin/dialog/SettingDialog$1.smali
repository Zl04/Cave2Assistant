.class Lcom/cyjh/elfin/dialog/SettingDialog$1;
.super Ljava/lang/Object;
.source "SettingDialog.java"

# interfaces
.implements Lcom/cyjh/elfin/mvp/managers/UpdateVersionManager$OnUpdateVersionBack;


# annotations
.annotation system Ldalvik/annotation/EnclosingMethod;
    value = Lcom/cyjh/elfin/dialog/SettingDialog;->onClick(Landroid/view/View;)V
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x0
    name = null
.end annotation


# instance fields
.field final synthetic this$0:Lcom/cyjh/elfin/dialog/SettingDialog;


# direct methods
.method constructor <init>(Lcom/cyjh/elfin/dialog/SettingDialog;)V
    .locals 0
    .param p1, "this$0"    # Lcom/cyjh/elfin/dialog/SettingDialog;

    .prologue
    .line 188
    iput-object p1, p0, Lcom/cyjh/elfin/dialog/SettingDialog$1;->this$0:Lcom/cyjh/elfin/dialog/SettingDialog;

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method


# virtual methods
.method public onCall(I)V
    .locals 1
    .param p1, "isUpdate"    # I

    .prologue
    .line 191
    const/4 v0, 0x2

    if-ne p1, v0, :cond_0

    .line 192
    iget-object v0, p0, Lcom/cyjh/elfin/dialog/SettingDialog$1;->this$0:Lcom/cyjh/elfin/dialog/SettingDialog;

    invoke-virtual {v0}, Lcom/cyjh/elfin/dialog/SettingDialog;->dismiss()V

    .line 194
    :cond_0
    return-void
.end method
