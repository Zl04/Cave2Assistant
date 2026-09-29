.class Lcom/cyjh/elfin/rom/FloatWindowManager$2;
.super Ljava/lang/Object;
.source "FloatWindowManager.java"

# interfaces
.implements Lcom/cyjh/elfin/rom/FloatWindowManager$OnConfirmResult;


# annotations
.annotation system Ldalvik/annotation/EnclosingMethod;
    value = Lcom/cyjh/elfin/rom/FloatWindowManager;->huaweiROMPermissionApply(Landroid/content/Context;)V
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
    .line 148
    iput-object p1, p0, Lcom/cyjh/elfin/rom/FloatWindowManager$2;->this$0:Lcom/cyjh/elfin/rom/FloatWindowManager;

    iput-object p2, p0, Lcom/cyjh/elfin/rom/FloatWindowManager$2;->val$context:Landroid/content/Context;

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method


# virtual methods
.method public confirmResult(Z)V
    .locals 2
    .param p1, "confirm"    # Z

    .prologue
    .line 151
    if-eqz p1, :cond_0

    .line 152
    iget-object v0, p0, Lcom/cyjh/elfin/rom/FloatWindowManager$2;->val$context:Landroid/content/Context;

    invoke-static {v0}, Lcom/cyjh/elfin/rom/HuaweiUtils;->applyPermission(Landroid/content/Context;)V

    .line 156
    :goto_0
    return-void

    .line 154
    :cond_0
    const-string v0, "FloatWindowManager"

    const-string v1, "ROM:huawei, user manually refuse OVERLAY_PERMISSION"

    invoke-static {v0, v1}, Landroid/util/Log;->e(Ljava/lang/String;Ljava/lang/String;)I

    goto :goto_0
.end method
