.class Lcom/cyjh/elfin/rom/FloatWindowManager$6;
.super Ljava/lang/Object;
.source "FloatWindowManager.java"

# interfaces
.implements Lcom/cyjh/elfin/rom/FloatWindowManager$OnConfirmResult;


# annotations
.annotation system Ldalvik/annotation/EnclosingMethod;
    value = Lcom/cyjh/elfin/rom/FloatWindowManager;->commonROMPermissionApply(Landroid/content/Context;)V
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
    .line 208
    iput-object p1, p0, Lcom/cyjh/elfin/rom/FloatWindowManager$6;->this$0:Lcom/cyjh/elfin/rom/FloatWindowManager;

    iput-object p2, p0, Lcom/cyjh/elfin/rom/FloatWindowManager$6;->val$context:Landroid/content/Context;

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method


# virtual methods
.method public confirmResult(Z)V
    .locals 3
    .param p1, "confirm"    # Z

    .prologue
    .line 211
    if-eqz p1, :cond_0

    .line 213
    :try_start_0
    iget-object v1, p0, Lcom/cyjh/elfin/rom/FloatWindowManager$6;->val$context:Landroid/content/Context;

    invoke-static {v1}, Lcom/cyjh/elfin/rom/FloatWindowManager;->commonROMPermissionApplyInternal(Landroid/content/Context;)V
    :try_end_0
    .catch Ljava/lang/Exception; {:try_start_0 .. :try_end_0} :catch_0

    .line 221
    :goto_0
    return-void

    .line 214
    :catch_0
    move-exception v0

    .line 215
    .local v0, "e":Ljava/lang/Exception;
    const-string v1, "FloatWindowManager"

    invoke-static {v0}, Landroid/util/Log;->getStackTraceString(Ljava/lang/Throwable;)Ljava/lang/String;

    move-result-object v2

    invoke-static {v1, v2}, Landroid/util/Log;->e(Ljava/lang/String;Ljava/lang/String;)I

    goto :goto_0

    .line 218
    .end local v0    # "e":Ljava/lang/Exception;
    :cond_0
    const-string v1, "FloatWindowManager"

    const-string v2, "user manually refuse OVERLAY_PERMISSION"

    invoke-static {v1, v2}, Landroid/util/Log;->d(Ljava/lang/String;Ljava/lang/String;)I

    goto :goto_0
.end method
