.class public Lcom/cyjh/elfin/rom/FloatWindowManager;
.super Ljava/lang/Object;
.source "FloatWindowManager.java"


# annotations
.annotation system Ldalvik/annotation/MemberClasses;
    value = {
        Lcom/cyjh/elfin/rom/FloatWindowManager$OnConfirmResult;
    }
.end annotation


# static fields
.field private static final TAG:Ljava/lang/String; = "FloatWindowManager"

.field private static volatile instance:Lcom/cyjh/elfin/rom/FloatWindowManager;


# instance fields
.field private dialog:Lcom/cyjh/elfin/dialog/FloatGuideDialog;

.field private isWindowDismiss:Z

.field private mParams:Landroid/view/WindowManager$LayoutParams;

.field private windowManager:Landroid/view/WindowManager;


# direct methods
.method public constructor <init>()V
    .locals 2

    .prologue
    const/4 v1, 0x0

    .line 29
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    .line 34
    const/4 v0, 0x1

    iput-boolean v0, p0, Lcom/cyjh/elfin/rom/FloatWindowManager;->isWindowDismiss:Z

    .line 35
    iput-object v1, p0, Lcom/cyjh/elfin/rom/FloatWindowManager;->windowManager:Landroid/view/WindowManager;

    .line 36
    iput-object v1, p0, Lcom/cyjh/elfin/rom/FloatWindowManager;->mParams:Landroid/view/WindowManager$LayoutParams;

    return-void
.end method

.method private ROM360PermissionApply(Landroid/content/Context;)V
    .locals 1
    .param p1, "context"    # Landroid/content/Context;

    .prologue
    .line 135
    new-instance v0, Lcom/cyjh/elfin/rom/FloatWindowManager$1;

    invoke-direct {v0, p0, p1}, Lcom/cyjh/elfin/rom/FloatWindowManager$1;-><init>(Lcom/cyjh/elfin/rom/FloatWindowManager;Landroid/content/Context;)V

    invoke-direct {p0, p1, v0}, Lcom/cyjh/elfin/rom/FloatWindowManager;->showConfirmDialog(Landroid/content/Context;Lcom/cyjh/elfin/rom/FloatWindowManager$OnConfirmResult;)V

    .line 145
    return-void
.end method

.method static synthetic access$000(Lcom/cyjh/elfin/rom/FloatWindowManager;)Lcom/cyjh/elfin/dialog/FloatGuideDialog;
    .locals 1
    .param p0, "x0"    # Lcom/cyjh/elfin/rom/FloatWindowManager;

    .prologue
    .line 29
    iget-object v0, p0, Lcom/cyjh/elfin/rom/FloatWindowManager;->dialog:Lcom/cyjh/elfin/dialog/FloatGuideDialog;

    return-object v0
.end method

.method private commonROMPermissionApply(Landroid/content/Context;)V
    .locals 2
    .param p1, "context"    # Landroid/content/Context;

    .prologue
    .line 204
    invoke-static {}, Lcom/cyjh/elfin/rom/RomUtils;->checkIsMeizuRom()Z

    move-result v0

    if-eqz v0, :cond_1

    .line 205
    invoke-direct {p0, p1}, Lcom/cyjh/elfin/rom/FloatWindowManager;->meizuROMPermissionApply(Landroid/content/Context;)V

    .line 225
    :cond_0
    :goto_0
    return-void

    .line 207
    :cond_1
    sget v0, Landroid/os/Build$VERSION;->SDK_INT:I

    const/16 v1, 0x17

    if-lt v0, v1, :cond_0

    .line 208
    new-instance v0, Lcom/cyjh/elfin/rom/FloatWindowManager$6;

    invoke-direct {v0, p0, p1}, Lcom/cyjh/elfin/rom/FloatWindowManager$6;-><init>(Lcom/cyjh/elfin/rom/FloatWindowManager;Landroid/content/Context;)V

    invoke-direct {p0, p1, v0}, Lcom/cyjh/elfin/rom/FloatWindowManager;->showConfirmDialog(Landroid/content/Context;Lcom/cyjh/elfin/rom/FloatWindowManager$OnConfirmResult;)V

    goto :goto_0
.end method

.method public static commonROMPermissionApplyInternal(Landroid/content/Context;)V
    .locals 5
    .param p0, "context"    # Landroid/content/Context;
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljava/lang/NoSuchFieldException;,
            Ljava/lang/IllegalAccessException;
        }
    .end annotation

    .prologue
    .line 228
    const-class v0, Landroid/provider/Settings;

    .line 229
    .local v0, "clazz":Ljava/lang/Class;
    const-string v3, "ACTION_MANAGE_OVERLAY_PERMISSION"

    invoke-virtual {v0, v3}, Ljava/lang/Class;->getDeclaredField(Ljava/lang/String;)Ljava/lang/reflect/Field;

    move-result-object v1

    .line 231
    .local v1, "field":Ljava/lang/reflect/Field;
    new-instance v2, Landroid/content/Intent;

    const/4 v3, 0x0

    invoke-virtual {v1, v3}, Ljava/lang/reflect/Field;->get(Ljava/lang/Object;)Ljava/lang/Object;

    move-result-object v3

    invoke-virtual {v3}, Ljava/lang/Object;->toString()Ljava/lang/String;

    move-result-object v3

    invoke-direct {v2, v3}, Landroid/content/Intent;-><init>(Ljava/lang/String;)V

    .line 232
    .local v2, "intent":Landroid/content/Intent;
    const/high16 v3, 0x10000000

    invoke-virtual {v2, v3}, Landroid/content/Intent;->setFlags(I)Landroid/content/Intent;

    .line 233
    new-instance v3, Ljava/lang/StringBuilder;

    invoke-direct {v3}, Ljava/lang/StringBuilder;-><init>()V

    const-string v4, "package:"

    invoke-virtual {v3, v4}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v3

    invoke-virtual {p0}, Landroid/content/Context;->getPackageName()Ljava/lang/String;

    move-result-object v4

    invoke-virtual {v3, v4}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v3

    invoke-virtual {v3}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v3

    invoke-static {v3}, Landroid/net/Uri;->parse(Ljava/lang/String;)Landroid/net/Uri;

    move-result-object v3

    invoke-virtual {v2, v3}, Landroid/content/Intent;->setData(Landroid/net/Uri;)Landroid/content/Intent;

    .line 234
    invoke-virtual {p0, v2}, Landroid/content/Context;->startActivity(Landroid/content/Intent;)V

    .line 235
    return-void
.end method

.method private commonROMPermissionCheck(Landroid/content/Context;)Z
    .locals 9
    .param p1, "context"    # Landroid/content/Context;

    .prologue
    const/4 v6, 0x1

    .line 99
    invoke-static {}, Lcom/cyjh/elfin/rom/RomUtils;->checkIsMeizuRom()Z

    move-result v5

    if-eqz v5, :cond_0

    .line 100
    invoke-direct {p0, p1}, Lcom/cyjh/elfin/rom/FloatWindowManager;->meizuPermissionCheck(Landroid/content/Context;)Z

    move-result v5

    .line 112
    :goto_0
    return v5

    .line 102
    :cond_0
    invoke-static {v6}, Ljava/lang/Boolean;->valueOf(Z)Ljava/lang/Boolean;

    move-result-object v4

    .line 103
    .local v4, "result":Ljava/lang/Boolean;
    sget v5, Landroid/os/Build$VERSION;->SDK_INT:I

    const/16 v6, 0x17

    if-lt v5, v6, :cond_1

    .line 105
    :try_start_0
    const-class v2, Landroid/provider/Settings;

    .line 106
    .local v2, "clazz":Ljava/lang/Class;
    const-string v5, "canDrawOverlays"

    const/4 v6, 0x1

    new-array v6, v6, [Ljava/lang/Class;

    const/4 v7, 0x0

    const-class v8, Landroid/content/Context;

    aput-object v8, v6, v7

    invoke-virtual {v2, v5, v6}, Ljava/lang/Class;->getDeclaredMethod(Ljava/lang/String;[Ljava/lang/Class;)Ljava/lang/reflect/Method;

    move-result-object v1

    .line 107
    .local v1, "canDrawOverlays":Ljava/lang/reflect/Method;
    const/4 v5, 0x0

    const/4 v6, 0x1

    new-array v6, v6, [Ljava/lang/Object;

    const/4 v7, 0x0

    aput-object p1, v6, v7

    invoke-virtual {v1, v5, v6}, Ljava/lang/reflect/Method;->invoke(Ljava/lang/Object;[Ljava/lang/Object;)Ljava/lang/Object;

    move-result-object v5

    move-object v0, v5

    check-cast v0, Ljava/lang/Boolean;

    move-object v4, v0
    :try_end_0
    .catch Ljava/lang/Exception; {:try_start_0 .. :try_end_0} :catch_0

    .line 112
    .end local v1    # "canDrawOverlays":Ljava/lang/reflect/Method;
    .end local v2    # "clazz":Ljava/lang/Class;
    :cond_1
    :goto_1
    invoke-virtual {v4}, Ljava/lang/Boolean;->booleanValue()Z

    move-result v5

    goto :goto_0

    .line 108
    :catch_0
    move-exception v3

    .line 109
    .local v3, "e":Ljava/lang/Exception;
    const-string v5, "FloatWindowManager"

    invoke-static {v3}, Landroid/util/Log;->getStackTraceString(Ljava/lang/Throwable;)Ljava/lang/String;

    move-result-object v6

    invoke-static {v5, v6}, Landroid/util/Log;->e(Ljava/lang/String;Ljava/lang/String;)I

    goto :goto_1
.end method

.method private dp2px(Landroid/content/Context;F)I
    .locals 3
    .param p1, "context"    # Landroid/content/Context;
    .param p2, "dp"    # F

    .prologue
    .line 281
    invoke-virtual {p1}, Landroid/content/Context;->getResources()Landroid/content/res/Resources;

    move-result-object v1

    invoke-virtual {v1}, Landroid/content/res/Resources;->getDisplayMetrics()Landroid/util/DisplayMetrics;

    move-result-object v1

    iget v0, v1, Landroid/util/DisplayMetrics;->density:F

    .line 282
    .local v0, "scale":F
    mul-float v1, p2, v0

    const/high16 v2, 0x3f000000    # 0.5f

    add-float/2addr v1, v2

    float-to-int v1, v1

    return v1
.end method

.method public static getInstance()Lcom/cyjh/elfin/rom/FloatWindowManager;
    .locals 2

    .prologue
    .line 41
    sget-object v0, Lcom/cyjh/elfin/rom/FloatWindowManager;->instance:Lcom/cyjh/elfin/rom/FloatWindowManager;

    if-nez v0, :cond_1

    .line 42
    const-class v1, Lcom/cyjh/elfin/rom/FloatWindowManager;

    monitor-enter v1

    .line 43
    :try_start_0
    sget-object v0, Lcom/cyjh/elfin/rom/FloatWindowManager;->instance:Lcom/cyjh/elfin/rom/FloatWindowManager;

    if-nez v0, :cond_0

    .line 44
    new-instance v0, Lcom/cyjh/elfin/rom/FloatWindowManager;

    invoke-direct {v0}, Lcom/cyjh/elfin/rom/FloatWindowManager;-><init>()V

    sput-object v0, Lcom/cyjh/elfin/rom/FloatWindowManager;->instance:Lcom/cyjh/elfin/rom/FloatWindowManager;

    .line 46
    :cond_0
    monitor-exit v1
    :try_end_0
    .catchall {:try_start_0 .. :try_end_0} :catchall_0

    .line 48
    :cond_1
    sget-object v0, Lcom/cyjh/elfin/rom/FloatWindowManager;->instance:Lcom/cyjh/elfin/rom/FloatWindowManager;

    return-object v0

    .line 46
    :catchall_0
    move-exception v0

    :try_start_1
    monitor-exit v1
    :try_end_1
    .catchall {:try_start_1 .. :try_end_1} :catchall_0

    throw v0
.end method

.method private huaweiPermissionCheck(Landroid/content/Context;)Z
    .locals 1
    .param p1, "context"    # Landroid/content/Context;

    .prologue
    .line 78
    invoke-static {p1}, Lcom/cyjh/elfin/rom/HuaweiUtils;->checkFloatWindowPermission(Landroid/content/Context;)Z

    move-result v0

    return v0
.end method

.method private huaweiROMPermissionApply(Landroid/content/Context;)V
    .locals 1
    .param p1, "context"    # Landroid/content/Context;

    .prologue
    .line 148
    new-instance v0, Lcom/cyjh/elfin/rom/FloatWindowManager$2;

    invoke-direct {v0, p0, p1}, Lcom/cyjh/elfin/rom/FloatWindowManager$2;-><init>(Lcom/cyjh/elfin/rom/FloatWindowManager;Landroid/content/Context;)V

    invoke-direct {p0, p1, v0}, Lcom/cyjh/elfin/rom/FloatWindowManager;->showConfirmDialog(Landroid/content/Context;Lcom/cyjh/elfin/rom/FloatWindowManager$OnConfirmResult;)V

    .line 158
    return-void
.end method

.method private meizuPermissionCheck(Landroid/content/Context;)Z
    .locals 1
    .param p1, "context"    # Landroid/content/Context;

    .prologue
    .line 86
    invoke-static {p1}, Lcom/cyjh/elfin/rom/MeizuUtils;->checkFloatWindowPermission(Landroid/content/Context;)Z

    move-result v0

    return v0
.end method

.method private meizuROMPermissionApply(Landroid/content/Context;)V
    .locals 1
    .param p1, "context"    # Landroid/content/Context;

    .prologue
    .line 161
    new-instance v0, Lcom/cyjh/elfin/rom/FloatWindowManager$3;

    invoke-direct {v0, p0, p1}, Lcom/cyjh/elfin/rom/FloatWindowManager$3;-><init>(Lcom/cyjh/elfin/rom/FloatWindowManager;Landroid/content/Context;)V

    invoke-direct {p0, p1, v0}, Lcom/cyjh/elfin/rom/FloatWindowManager;->showConfirmDialog(Landroid/content/Context;Lcom/cyjh/elfin/rom/FloatWindowManager$OnConfirmResult;)V

    .line 171
    return-void
.end method

.method private miuiPermissionCheck(Landroid/content/Context;)Z
    .locals 1
    .param p1, "context"    # Landroid/content/Context;

    .prologue
    .line 82
    invoke-static {p1}, Lcom/cyjh/elfin/rom/MiuiUtils;->checkFloatWindowPermission(Landroid/content/Context;)Z

    move-result v0

    return v0
.end method

.method private miuiROMPermissionApply(Landroid/content/Context;)V
    .locals 1
    .param p1, "context"    # Landroid/content/Context;

    .prologue
    .line 174
    new-instance v0, Lcom/cyjh/elfin/rom/FloatWindowManager$4;

    invoke-direct {v0, p0, p1}, Lcom/cyjh/elfin/rom/FloatWindowManager$4;-><init>(Lcom/cyjh/elfin/rom/FloatWindowManager;Landroid/content/Context;)V

    invoke-direct {p0, p1, v0}, Lcom/cyjh/elfin/rom/FloatWindowManager;->showConfirmDialog(Landroid/content/Context;Lcom/cyjh/elfin/rom/FloatWindowManager$OnConfirmResult;)V

    .line 184
    return-void
.end method

.method private oppoROMPermissionApply(Landroid/content/Context;)V
    .locals 1
    .param p1, "context"    # Landroid/content/Context;

    .prologue
    .line 187
    new-instance v0, Lcom/cyjh/elfin/rom/FloatWindowManager$5;

    invoke-direct {v0, p0, p1}, Lcom/cyjh/elfin/rom/FloatWindowManager$5;-><init>(Lcom/cyjh/elfin/rom/FloatWindowManager;Landroid/content/Context;)V

    invoke-direct {p0, p1, v0}, Lcom/cyjh/elfin/rom/FloatWindowManager;->showConfirmDialog(Landroid/content/Context;Lcom/cyjh/elfin/rom/FloatWindowManager$OnConfirmResult;)V

    .line 197
    return-void
.end method

.method private oppoROMPermissionCheck(Landroid/content/Context;)Z
    .locals 1
    .param p1, "context"    # Landroid/content/Context;

    .prologue
    .line 94
    invoke-static {p1}, Lcom/cyjh/elfin/rom/OppoUtils;->checkFloatWindowPermission(Landroid/content/Context;)Z

    move-result v0

    return v0
.end method

.method private qikuPermissionCheck(Landroid/content/Context;)Z
    .locals 1
    .param p1, "context"    # Landroid/content/Context;

    .prologue
    .line 90
    invoke-static {p1}, Lcom/cyjh/elfin/rom/QikuUtils;->checkFloatWindowPermission(Landroid/content/Context;)Z

    move-result v0

    return v0
.end method

.method private showConfirmDialog(Landroid/content/Context;Lcom/cyjh/elfin/rom/FloatWindowManager$OnConfirmResult;)V
    .locals 1
    .param p1, "context"    # Landroid/content/Context;
    .param p2, "result"    # Lcom/cyjh/elfin/rom/FloatWindowManager$OnConfirmResult;

    .prologue
    .line 238
    const-string v0, "\u60a8\u7684\u624b\u673a\u6ca1\u6709\u6388\u4e88\u60ac\u6d6e\u7a97\u6743\u9650\uff0c\u8bf7\u5f00\u542f\u540e\u518d\u8bd5"

    invoke-direct {p0, p1, v0, p2}, Lcom/cyjh/elfin/rom/FloatWindowManager;->showConfirmDialog(Landroid/content/Context;Ljava/lang/String;Lcom/cyjh/elfin/rom/FloatWindowManager$OnConfirmResult;)V

    .line 239
    return-void
.end method

.method private showConfirmDialog(Landroid/content/Context;Ljava/lang/String;Lcom/cyjh/elfin/rom/FloatWindowManager$OnConfirmResult;)V
    .locals 2
    .param p1, "context"    # Landroid/content/Context;
    .param p2, "message"    # Ljava/lang/String;
    .param p3, "result"    # Lcom/cyjh/elfin/rom/FloatWindowManager$OnConfirmResult;

    .prologue
    .line 242
    iget-object v0, p0, Lcom/cyjh/elfin/rom/FloatWindowManager;->dialog:Lcom/cyjh/elfin/dialog/FloatGuideDialog;

    if-eqz v0, :cond_0

    iget-object v0, p0, Lcom/cyjh/elfin/rom/FloatWindowManager;->dialog:Lcom/cyjh/elfin/dialog/FloatGuideDialog;

    invoke-virtual {v0}, Lcom/cyjh/elfin/dialog/FloatGuideDialog;->isShowing()Z

    move-result v0

    if-eqz v0, :cond_0

    .line 243
    iget-object v0, p0, Lcom/cyjh/elfin/rom/FloatWindowManager;->dialog:Lcom/cyjh/elfin/dialog/FloatGuideDialog;

    invoke-virtual {v0}, Lcom/cyjh/elfin/dialog/FloatGuideDialog;->dismiss()V

    .line 265
    :cond_0
    new-instance v0, Lcom/cyjh/elfin/dialog/FloatGuideDialog;

    invoke-direct {v0, p1}, Lcom/cyjh/elfin/dialog/FloatGuideDialog;-><init>(Landroid/content/Context;)V

    iput-object v0, p0, Lcom/cyjh/elfin/rom/FloatWindowManager;->dialog:Lcom/cyjh/elfin/dialog/FloatGuideDialog;

    .line 266
    iget-object v0, p0, Lcom/cyjh/elfin/rom/FloatWindowManager;->dialog:Lcom/cyjh/elfin/dialog/FloatGuideDialog;

    new-instance v1, Lcom/cyjh/elfin/rom/FloatWindowManager$7;

    invoke-direct {v1, p0, p3}, Lcom/cyjh/elfin/rom/FloatWindowManager$7;-><init>(Lcom/cyjh/elfin/rom/FloatWindowManager;Lcom/cyjh/elfin/rom/FloatWindowManager$OnConfirmResult;)V

    invoke-virtual {v0, v1}, Lcom/cyjh/elfin/dialog/FloatGuideDialog;->setConfirmResult(Lcom/cyjh/elfin/dialog/FloatGuideDialog$OnConfirmResult;)V

    .line 273
    iget-object v0, p0, Lcom/cyjh/elfin/rom/FloatWindowManager;->dialog:Lcom/cyjh/elfin/dialog/FloatGuideDialog;

    invoke-virtual {v0}, Lcom/cyjh/elfin/dialog/FloatGuideDialog;->show()V

    .line 274
    return-void
.end method


# virtual methods
.method public applyOrShowFloatWindow(Landroid/content/Context;)V
    .locals 1
    .param p1, "context"    # Landroid/content/Context;

    .prologue
    .line 52
    invoke-virtual {p0, p1}, Lcom/cyjh/elfin/rom/FloatWindowManager;->checkPermission(Landroid/content/Context;)Z

    move-result v0

    if-eqz v0, :cond_0

    .line 57
    :goto_0
    return-void

    .line 55
    :cond_0
    invoke-virtual {p0, p1}, Lcom/cyjh/elfin/rom/FloatWindowManager;->applyPermission(Landroid/content/Context;)V

    goto :goto_0
.end method

.method public applyPermission(Landroid/content/Context;)V
    .locals 2
    .param p1, "context"    # Landroid/content/Context;

    .prologue
    .line 117
    sget v0, Landroid/os/Build$VERSION;->SDK_INT:I

    const/16 v1, 0x17

    if-ge v0, v1, :cond_5

    .line 118
    invoke-static {}, Lcom/cyjh/elfin/rom/RomUtils;->checkIsMiuiRom()Z

    move-result v0

    if-eqz v0, :cond_1

    .line 119
    invoke-direct {p0, p1}, Lcom/cyjh/elfin/rom/FloatWindowManager;->miuiROMPermissionApply(Landroid/content/Context;)V

    .line 132
    :cond_0
    :goto_0
    return-void

    .line 120
    :cond_1
    invoke-static {}, Lcom/cyjh/elfin/rom/RomUtils;->checkIsMeizuRom()Z

    move-result v0

    if-eqz v0, :cond_2

    .line 121
    invoke-direct {p0, p1}, Lcom/cyjh/elfin/rom/FloatWindowManager;->meizuROMPermissionApply(Landroid/content/Context;)V

    goto :goto_0

    .line 122
    :cond_2
    invoke-static {}, Lcom/cyjh/elfin/rom/RomUtils;->checkIsHuaweiRom()Z

    move-result v0

    if-eqz v0, :cond_3

    .line 123
    invoke-direct {p0, p1}, Lcom/cyjh/elfin/rom/FloatWindowManager;->huaweiROMPermissionApply(Landroid/content/Context;)V

    goto :goto_0

    .line 124
    :cond_3
    invoke-static {}, Lcom/cyjh/elfin/rom/RomUtils;->checkIs360Rom()Z

    move-result v0

    if-eqz v0, :cond_4

    .line 125
    invoke-direct {p0, p1}, Lcom/cyjh/elfin/rom/FloatWindowManager;->ROM360PermissionApply(Landroid/content/Context;)V

    goto :goto_0

    .line 126
    :cond_4
    invoke-static {}, Lcom/cyjh/elfin/rom/RomUtils;->checkIsOppoRom()Z

    move-result v0

    if-eqz v0, :cond_0

    .line 127
    invoke-direct {p0, p1}, Lcom/cyjh/elfin/rom/FloatWindowManager;->oppoROMPermissionApply(Landroid/content/Context;)V

    goto :goto_0

    .line 130
    :cond_5
    invoke-direct {p0, p1}, Lcom/cyjh/elfin/rom/FloatWindowManager;->commonROMPermissionApply(Landroid/content/Context;)V

    goto :goto_0
.end method

.method public checkPermission(Landroid/content/Context;)Z
    .locals 2
    .param p1, "context"    # Landroid/content/Context;

    .prologue
    .line 61
    sget v0, Landroid/os/Build$VERSION;->SDK_INT:I

    const/16 v1, 0x17

    if-ge v0, v1, :cond_4

    .line 62
    invoke-static {}, Lcom/cyjh/elfin/rom/RomUtils;->checkIsMiuiRom()Z

    move-result v0

    if-eqz v0, :cond_0

    .line 63
    invoke-direct {p0, p1}, Lcom/cyjh/elfin/rom/FloatWindowManager;->miuiPermissionCheck(Landroid/content/Context;)Z

    move-result v0

    .line 74
    :goto_0
    return v0

    .line 64
    :cond_0
    invoke-static {}, Lcom/cyjh/elfin/rom/RomUtils;->checkIsMeizuRom()Z

    move-result v0

    if-eqz v0, :cond_1

    .line 65
    invoke-direct {p0, p1}, Lcom/cyjh/elfin/rom/FloatWindowManager;->meizuPermissionCheck(Landroid/content/Context;)Z

    move-result v0

    goto :goto_0

    .line 66
    :cond_1
    invoke-static {}, Lcom/cyjh/elfin/rom/RomUtils;->checkIsHuaweiRom()Z

    move-result v0

    if-eqz v0, :cond_2

    .line 67
    invoke-direct {p0, p1}, Lcom/cyjh/elfin/rom/FloatWindowManager;->huaweiPermissionCheck(Landroid/content/Context;)Z

    move-result v0

    goto :goto_0

    .line 68
    :cond_2
    invoke-static {}, Lcom/cyjh/elfin/rom/RomUtils;->checkIs360Rom()Z

    move-result v0

    if-eqz v0, :cond_3

    .line 69
    invoke-direct {p0, p1}, Lcom/cyjh/elfin/rom/FloatWindowManager;->qikuPermissionCheck(Landroid/content/Context;)Z

    move-result v0

    goto :goto_0

    .line 70
    :cond_3
    invoke-static {}, Lcom/cyjh/elfin/rom/RomUtils;->checkIsOppoRom()Z

    move-result v0

    if-eqz v0, :cond_4

    .line 71
    invoke-direct {p0, p1}, Lcom/cyjh/elfin/rom/FloatWindowManager;->oppoROMPermissionCheck(Landroid/content/Context;)Z

    move-result v0

    goto :goto_0

    .line 74
    :cond_4
    invoke-direct {p0, p1}, Lcom/cyjh/elfin/rom/FloatWindowManager;->commonROMPermissionCheck(Landroid/content/Context;)Z

    move-result v0

    goto :goto_0
.end method
