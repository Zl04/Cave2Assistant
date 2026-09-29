.class Lcom/cyjh/elfin/dialog/NoRootDialog$1;
.super Ljava/lang/Object;
.source "NoRootDialog.java"

# interfaces
.implements Landroid/view/View$OnClickListener;


# annotations
.annotation system Ldalvik/annotation/EnclosingMethod;
    value = Lcom/cyjh/elfin/dialog/NoRootDialog;->onCreate(Landroid/os/Bundle;)V
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x0
    name = null
.end annotation


# instance fields
.field final synthetic this$0:Lcom/cyjh/elfin/dialog/NoRootDialog;


# direct methods
.method constructor <init>(Lcom/cyjh/elfin/dialog/NoRootDialog;)V
    .locals 0
    .param p1, "this$0"    # Lcom/cyjh/elfin/dialog/NoRootDialog;

    .prologue
    .line 27
    iput-object p1, p0, Lcom/cyjh/elfin/dialog/NoRootDialog$1;->this$0:Lcom/cyjh/elfin/dialog/NoRootDialog;

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method


# virtual methods
.method public onClick(Landroid/view/View;)V
    .locals 1
    .param p1, "v"    # Landroid/view/View;

    .prologue
    .line 30
    iget-object v0, p0, Lcom/cyjh/elfin/dialog/NoRootDialog$1;->this$0:Lcom/cyjh/elfin/dialog/NoRootDialog;

    invoke-virtual {v0}, Lcom/cyjh/elfin/dialog/NoRootDialog;->dismiss()V

    .line 31
    return-void
.end method
