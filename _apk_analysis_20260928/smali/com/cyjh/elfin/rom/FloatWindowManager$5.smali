.class Lcom/cyjh/elfin/rom/FloatWindowManager$5;
.super Ljava/lang/Object;
.source "FloatWindowManager.java"

# interfaces
.implements Lcom/cyjh/elfin/rom/FloatWindowManager$OnConfirmResult;


# annotations
.annotation system Ldalvik/annotation/EnclosingMethod;
    value = Lcom/cyjh/elfin/rom/FloatWindowManager;->oppoROMPermissionApply(Landroid/content/Context;)V
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x0
    name = null
.end annotation


# instance fields
.field final synthetic this$0:Lcom/cyjh/elfin/rom/FloatWindowManager;

.field final synthetic val$context:Landroid/content/Context;


# direct methods
.method constructor <init>(Lcom/cyjh/elfin/rom/FloatWindowManager;Landroid/content/Context;)V
    .locals 0
    .param p1, "this$0"    # Lcom/cyjh/elfin/rom/FloatWindowManager;

    .prologue
    .line 187
    iput-object p1, p0, Lcom/cyjh/elfin/rom/FloatWindowManager$5;->this$0:Lcom/cyjh/elfin/rom/FloatWindowManager;

    iput-object p2, p0, Lcom/cyjh/elfin/rom/FloatWindowManager$5;->val$context:Landroid/content/Context;

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method


# virtual methods
.method public confirmResult(Z)V
    .locals 2
    .param p1, "confirm"    # Z

    .prologue
    .line 190
    if-eqz p1, :cond_0

    .line 191
    iget-object v0, p0, Lcom/cyjh/elfin/rom/FloatWindowManager$5;->val$context:Landroid/content/Context;

    invoke-static {v0}, Lcom/cyjh/elfin/rom/OppoUtils;->applyOppoPermission(Landroid/content/Context;)V

    .line 195
    :goto_0
    return-void

    .line 193
    :cond_0
    const-string v0, "FloatWindowManager"

    const-string v1, "ROM:miui, user manually refuse OVERLAY_PERMISSION"

    invoke-static {v0, v1}, Landroid/util/Log;->e(Ljava/lang/String;Ljava/lang/String;)I

    goto :goto_0
.end method
