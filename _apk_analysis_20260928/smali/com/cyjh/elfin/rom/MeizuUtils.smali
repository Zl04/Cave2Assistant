.class public Lcom/cyjh/elfin/rom/MeizuUtils;
.super Ljava/lang/Object;
.source "MeizuUtils.java"


# static fields
.field private static final TAG:Ljava/lang/String; = "MeizuUtils"


# direct methods
.method public constructor <init>()V
    .locals 0

    .prologue
    .line 17
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method

.method public static applyPermission(Landroid/content/Context;)V
    .locals 6
    .param p0, "context"    # Landroid/content/Context;

    .prologue
    .line 36
    :try_start_0
    new-instance v2, Landroid/content/Intent;

    const-string v3, "com.meizu.safe.security.SHOW_APPSEC"

    invoke-direct {v2, v3}, Landroid/content/Intent;-><init>(Ljava/lang/String;)V

    .line 38
    .local v2, "intent":Landroid/content/Intent;
    const-string v3, "packageName"

    invoke-virtual {p0}, Landroid/content/Context;->getPackageName()Ljava/lang/String;

    move-result-object v4

    invoke-virtual {v2, v3, v4}, Landroid/content/Intent;->putExtra(Ljava/lang/String;Ljava/lang/String;)Landroid/content/Intent;

    .line 39
    const/high16 v3, 0x10000000

    invoke-virtual {v2, v3}, Landroid/content/Intent;->setFlags(I)Landroid/content/Intent;

    .line 40
    invoke-virtual {p0, v2}, Landroid/content/Context;->startActivity(Landroid/content/Intent;)V
    :try_end_0
    .catch Ljava/lang/Exception; {:try_start_0 .. :try_end_0} :catch_0

    .line 51
    .end local v2    # "intent":Landroid/content/Intent;
    :goto_0
    return-void

    .line 41
    :catch_0
    move-exception v0

    .line 43
    .local v0, "e":Ljava/lang/Exception;
    :try_start_1
    const-string v3, "MeizuUtils"

    new-instance v4, Ljava/lang/StringBuilder;

    invoke-direct {v4}, Ljava/lang/StringBuilder;-><init>()V

    const-string v5, "\u83b7\u53d6\u60ac\u6d6e\u7a97\u6743\u9650, \u6253\u5f00AppSecActivity\u5931\u8d25, "

    invoke-virtual {v4, v5}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v4

    invoke-static {v0}, Landroid/util/Log;->getStackTraceString(Ljava/lang/Throwable;)Ljava/lang/String;

    move-result-object v5

    invoke-virtual {v4, v5}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v4

    invoke-virtual {v4}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v4

    invoke-static {v3, v4}, Landroid/util/Log;->e(Ljava/lang/String;Ljava/lang/String;)I

    .line 45
    invoke-static {p0}, Lcom/cyjh/elfin/rom/FloatWindowManager;->commonROMPermissionApplyInternal(Landroid/content/Context;)V
    :try_end_1
    .catch Ljava/lang/Exception; {:try_start_1 .. :try_end_1} :catch_1

    goto :goto_0

    .line 46
    :catch_1
    move-exception v1

    .line 47
    .local v1, "eFinal":Ljava/lang/Exception;
    const-string v3, "MeizuUtils"

    new-instance v4, Ljava/lang/StringBuilder;

    invoke-direct {v4}, Ljava/lang/StringBuilder;-><init>()V

    const-string v5, "\u83b7\u53d6\u60ac\u6d6e\u7a97\u6743\u9650\u5931\u8d25, \u901a\u7528\u83b7\u53d6\u65b9\u6cd5\u5931\u8d25, "

    invoke-virtual {v4, v5}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v4

    invoke-static {v1}, Landroid/util/Log;->getStackTraceString(Ljava/lang/Throwable;)Ljava/lang/String;

    move-result-object v5

    invoke-virtual {v4, v5}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v4

    invoke-virtual {v4}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v4

    invoke-static {v3, v4}, Landroid/util/Log;->e(Ljava/lang/String;Ljava/lang/String;)I

    goto :goto_0
.end method

.method public static checkFloatWindowPermission(Landroid/content/Context;)Z
    .locals 2
    .param p0, "context"    # Landroid/content/Context;

    .prologue
    .line 24
    sget v0, Landroid/os/Build$VERSION;->SDK_INT:I

    .line 25
    .local v0, "version":I
    const/16 v1, 0x13

    if-lt v0, v1, :cond_0

    .line 26
    const/16 v1, 0x18

    invoke-static {p0, v1}, Lcom/cyjh/elfin/rom/MeizuUtils;->checkOp(Landroid/content/Context;I)Z

    move-result v1

    .line 28
    :goto_0
    return v1

    :cond_0
    const/4 v1, 0x1

    goto :goto_0
.end method

.method private static checkOp(Landroid/content/Context;I)Z
    .locals 11
    .param p0, "context"    # Landroid/content/Context;
    .param p1, "op"    # I
    .annotation build Landroid/annotation/TargetApi;
        value = 0x13
    .end annotation

    .prologue
    const/4 v6, 0x1

    const/4 v7, 0x0

    .line 55
    sget v4, Landroid/os/Build$VERSION;->SDK_INT:I

    .line 56
    .local v4, "version":I
    const/16 v5, 0x13

    if-lt v4, v5, :cond_1

    .line 57
    const-string v5, "appops"

    invoke-virtual {p0, v5}, Landroid/content/Context;->getSystemService(Ljava/lang/String;)Ljava/lang/Object;

    move-result-object v2

    check-cast v2, Landroid/app/AppOpsManager;

    .line 59
    .local v2, "manager":Landroid/app/AppOpsManager;
    :try_start_0
    const-class v0, Landroid/app/AppOpsManager;

    .line 60
    .local v0, "clazz":Ljava/lang/Class;
    const-string v5, "checkOp"

    const/4 v8, 0x3

    new-array v8, v8, [Ljava/lang/Class;

    const/4 v9, 0x0

    sget-object v10, Ljava/lang/Integer;->TYPE:Ljava/lang/Class;

    aput-object v10, v8, v9

    const/4 v9, 0x1

    sget-object v10, Ljava/lang/Integer;->TYPE:Ljava/lang/Class;

    aput-object v10, v8, v9

    const/4 v9, 0x2

    const-class v10, Ljava/lang/String;

    aput-object v10, v8, v9

    invoke-virtual {v0, v5, v8}, Ljava/lang/Class;->getDeclaredMethod(Ljava/lang/String;[Ljava/lang/Class;)Ljava/lang/reflect/Method;

    move-result-object v3

    .line 61
    .local v3, "method":Ljava/lang/reflect/Method;
    const/4 v5, 0x3

    new-array v5, v5, [Ljava/lang/Object;

    const/4 v8, 0x0

    invoke-static {p1}, Ljava/lang/Integer;->valueOf(I)Ljava/lang/Integer;

    move-result-object v9

    aput-object v9, v5, v8

    const/4 v8, 0x1

    invoke-static {}, Landroid/os/Binder;->getCallingUid()I

    move-result v9

    invoke-static {v9}, Ljava/lang/Integer;->valueOf(I)Ljava/lang/Integer;

    move-result-object v9

    aput-object v9, v5, v8

    const/4 v8, 0x2

    invoke-virtual {p0}, Landroid/content/Context;->getPackageName()Ljava/lang/String;

    move-result-object v9

    aput-object v9, v5, v8

    invoke-virtual {v3, v2, v5}, Ljava/lang/reflect/Method;->invoke(Ljava/lang/Object;[Ljava/lang/Object;)Ljava/lang/Object;

    move-result-object v5

    check-cast v5, Ljava/lang/Integer;

    invoke-virtual {v5}, Ljava/lang/Integer;->intValue()I
    :try_end_0
    .catch Ljava/lang/Exception; {:try_start_0 .. :try_end_0} :catch_0

    move-result v5

    if-nez v5, :cond_0

    move v5, v6

    .line 68
    .end local v0    # "clazz":Ljava/lang/Class;
    .end local v2    # "manager":Landroid/app/AppOpsManager;
    .end local v3    # "method":Ljava/lang/reflect/Method;
    :goto_0
    return v5

    .restart local v0    # "clazz":Ljava/lang/Class;
    .restart local v2    # "manager":Landroid/app/AppOpsManager;
    .restart local v3    # "method":Ljava/lang/reflect/Method;
    :cond_0
    move v5, v7

    .line 61
    goto :goto_0

    .line 62
    .end local v0    # "clazz":Ljava/lang/Class;
    .end local v3    # "method":Ljava/lang/reflect/Method;
    :catch_0
    move-exception v1

    .line 63
    .local v1, "e":Ljava/lang/Exception;
    const-string v5, "MeizuUtils"

    invoke-static {v1}, Landroid/util/Log;->getStackTraceString(Ljava/lang/Throwable;)Ljava/lang/String;

    move-result-object v6

    invoke-static {v5, v6}, Landroid/util/Log;->e(Ljava/lang/String;Ljava/lang/String;)I

    .end local v1    # "e":Ljava/lang/Exception;
    .end local v2    # "manager":Landroid/app/AppOpsManager;
    :goto_1
    move v5, v7

    .line 68
    goto :goto_0

    .line 66
    :cond_1
    const-string v5, "MeizuUtils"

    const-string v6, "Below API 19 cannot invoke!"

    invoke-static {v5, v6}, Landroid/util/Log;->e(Ljava/lang/String;Ljava/lang/String;)I

    goto :goto_1
.end method
