.class public Lcom/cyjh/elfin/rom/HuaweiUtils;
.super Ljava/lang/Object;
.source "HuaweiUtils.java"


# static fields
.field private static final TAG:Ljava/lang/String; = "HuaweiUtils"


# direct methods
.method public constructor <init>()V
    .locals 0

    .prologue
    .line 19
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method

.method public static applyPermission(Landroid/content/Context;)V
    .locals 9
    .param p0, "context"    # Landroid/content/Context;

    .prologue
    const/high16 v8, 0x10000000

    .line 38
    :try_start_0
    new-instance v2, Landroid/content/Intent;

    invoke-direct {v2}, Landroid/content/Intent;-><init>()V

    .line 39
    .local v2, "intent":Landroid/content/Intent;
    const/high16 v3, 0x10000000

    invoke-virtual {v2, v3}, Landroid/content/Intent;->setFlags(I)Landroid/content/Intent;

    .line 43
    new-instance v0, Landroid/content/ComponentName;

    const-string v3, "com.huawei.systemmanager"

    const-string v4, "com.huawei.systemmanager.addviewmonitor.AddViewMonitorActivity"

    invoke-direct {v0, v3, v4}, Landroid/content/ComponentName;-><init>(Ljava/lang/String;Ljava/lang/String;)V

    .line 44
    .local v0, "comp":Landroid/content/ComponentName;
    invoke-virtual {v2, v0}, Landroid/content/Intent;->setComponent(Landroid/content/ComponentName;)Landroid/content/Intent;

    .line 45
    invoke-static {}, Lcom/cyjh/elfin/rom/RomUtils;->getEmuiVersion()D

    move-result-wide v4

    const-wide v6, 0x4008cccccccccccdL    # 3.1

    cmpl-double v3, v4, v6

    if-nez v3, :cond_0

    .line 47
    invoke-virtual {p0, v2}, Landroid/content/Context;->startActivity(Landroid/content/Intent;)V

    .line 82
    .end local v0    # "comp":Landroid/content/ComponentName;
    .end local v2    # "intent":Landroid/content/Intent;
    :goto_0
    return-void

    .line 50
    .restart local v0    # "comp":Landroid/content/ComponentName;
    .restart local v2    # "intent":Landroid/content/Intent;
    :cond_0
    new-instance v0, Landroid/content/ComponentName;

    .end local v0    # "comp":Landroid/content/ComponentName;
    const-string v3, "com.huawei.systemmanager"

    const-string v4, "com.huawei.notificationmanager.ui.NotificationManagmentActivity"

    invoke-direct {v0, v3, v4}, Landroid/content/ComponentName;-><init>(Ljava/lang/String;Ljava/lang/String;)V

    .line 51
    .restart local v0    # "comp":Landroid/content/ComponentName;
    invoke-virtual {v2, v0}, Landroid/content/Intent;->setComponent(Landroid/content/ComponentName;)Landroid/content/Intent;

    .line 52
    invoke-virtual {p0, v2}, Landroid/content/Context;->startActivity(Landroid/content/Intent;)V
    :try_end_0
    .catch Ljava/lang/SecurityException; {:try_start_0 .. :try_end_0} :catch_0
    .catch Landroid/content/ActivityNotFoundException; {:try_start_0 .. :try_end_0} :catch_1
    .catch Ljava/lang/Exception; {:try_start_0 .. :try_end_0} :catch_2

    goto :goto_0

    .line 54
    .end local v0    # "comp":Landroid/content/ComponentName;
    .end local v2    # "intent":Landroid/content/Intent;
    :catch_0
    move-exception v1

    .line 55
    .local v1, "e":Ljava/lang/SecurityException;
    new-instance v2, Landroid/content/Intent;

    invoke-direct {v2}, Landroid/content/Intent;-><init>()V

    .line 56
    .restart local v2    # "intent":Landroid/content/Intent;
    invoke-virtual {v2, v8}, Landroid/content/Intent;->setFlags(I)Landroid/content/Intent;

    .line 58
    new-instance v0, Landroid/content/ComponentName;

    const-string v3, "com.huawei.systemmanager"

    const-string v4, "com.huawei.permissionmanager.ui.MainActivity"

    invoke-direct {v0, v3, v4}, Landroid/content/ComponentName;-><init>(Ljava/lang/String;Ljava/lang/String;)V

    .line 61
    .restart local v0    # "comp":Landroid/content/ComponentName;
    invoke-virtual {v2, v0}, Landroid/content/Intent;->setComponent(Landroid/content/ComponentName;)Landroid/content/Intent;

    .line 62
    invoke-virtual {p0, v2}, Landroid/content/Context;->startActivity(Landroid/content/Intent;)V

    .line 63
    const-string v3, "HuaweiUtils"

    invoke-static {v1}, Landroid/util/Log;->getStackTraceString(Ljava/lang/Throwable;)Ljava/lang/String;

    move-result-object v4

    invoke-static {v3, v4}, Landroid/util/Log;->e(Ljava/lang/String;Ljava/lang/String;)I

    goto :goto_0

    .line 64
    .end local v0    # "comp":Landroid/content/ComponentName;
    .end local v1    # "e":Ljava/lang/SecurityException;
    .end local v2    # "intent":Landroid/content/Intent;
    :catch_1
    move-exception v1

    .line 69
    .local v1, "e":Landroid/content/ActivityNotFoundException;
    new-instance v2, Landroid/content/Intent;

    invoke-direct {v2}, Landroid/content/Intent;-><init>()V

    .line 70
    .restart local v2    # "intent":Landroid/content/Intent;
    invoke-virtual {v2, v8}, Landroid/content/Intent;->setFlags(I)Landroid/content/Intent;

    .line 71
    new-instance v0, Landroid/content/ComponentName;

    const-string v3, "com.Android.settings"

    const-string v4, "com.android.settings.permission.TabItem"

    invoke-direct {v0, v3, v4}, Landroid/content/ComponentName;-><init>(Ljava/lang/String;Ljava/lang/String;)V

    .line 73
    .restart local v0    # "comp":Landroid/content/ComponentName;
    invoke-virtual {v2, v0}, Landroid/content/Intent;->setComponent(Landroid/content/ComponentName;)Landroid/content/Intent;

    .line 74
    invoke-virtual {p0, v2}, Landroid/content/Context;->startActivity(Landroid/content/Intent;)V

    .line 75
    invoke-virtual {v1}, Landroid/content/ActivityNotFoundException;->printStackTrace()V

    .line 76
    const-string v3, "HuaweiUtils"

    invoke-static {v1}, Landroid/util/Log;->getStackTraceString(Ljava/lang/Throwable;)Ljava/lang/String;

    move-result-object v4

    invoke-static {v3, v4}, Landroid/util/Log;->e(Ljava/lang/String;Ljava/lang/String;)I

    goto :goto_0

    .line 77
    .end local v0    # "comp":Landroid/content/ComponentName;
    .end local v1    # "e":Landroid/content/ActivityNotFoundException;
    .end local v2    # "intent":Landroid/content/Intent;
    :catch_2
    move-exception v1

    .line 79
    .local v1, "e":Ljava/lang/Exception;
    const-string v3, "\u8fdb\u5165\u8bbe\u7f6e\u9875\u9762\u5931\u8d25\uff0c\u8bf7\u624b\u52a8\u8bbe\u7f6e"

    const/4 v4, 0x1

    invoke-static {p0, v3, v4}, Landroid/widget/Toast;->makeText(Landroid/content/Context;Ljava/lang/CharSequence;I)Landroid/widget/Toast;

    move-result-object v3

    invoke-virtual {v3}, Landroid/widget/Toast;->show()V

    .line 80
    const-string v3, "HuaweiUtils"

    invoke-static {v1}, Landroid/util/Log;->getStackTraceString(Ljava/lang/Throwable;)Ljava/lang/String;

    move-result-object v4

    invoke-static {v3, v4}, Landroid/util/Log;->e(Ljava/lang/String;Ljava/lang/String;)I

    goto :goto_0
.end method

.method public static checkFloatWindowPermission(Landroid/content/Context;)Z
    .locals 2
    .param p0, "context"    # Landroid/content/Context;

    .prologue
    .line 26
    sget v0, Landroid/os/Build$VERSION;->SDK_INT:I

    .line 27
    .local v0, "version":I
    const/16 v1, 0x13

    if-lt v0, v1, :cond_0

    .line 28
    const/16 v1, 0x18

    invoke-static {p0, v1}, Lcom/cyjh/elfin/rom/HuaweiUtils;->checkOp(Landroid/content/Context;I)Z

    move-result v1

    .line 30
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

    .line 86
    sget v4, Landroid/os/Build$VERSION;->SDK_INT:I

    .line 87
    .local v4, "version":I
    const/16 v5, 0x13

    if-lt v4, v5, :cond_1

    .line 88
    const-string v5, "appops"

    invoke-virtual {p0, v5}, Landroid/content/Context;->getSystemService(Ljava/lang/String;)Ljava/lang/Object;

    move-result-object v2

    check-cast v2, Landroid/app/AppOpsManager;

    .line 90
    .local v2, "manager":Landroid/app/AppOpsManager;
    :try_start_0
    const-class v0, Landroid/app/AppOpsManager;

    .line 91
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

    .line 92
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

    .line 99
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

    .line 92
    goto :goto_0

    .line 93
    .end local v0    # "clazz":Ljava/lang/Class;
    .end local v3    # "method":Ljava/lang/reflect/Method;
    :catch_0
    move-exception v1

    .line 94
    .local v1, "e":Ljava/lang/Exception;
    const-string v5, "HuaweiUtils"

    invoke-static {v1}, Landroid/util/Log;->getStackTraceString(Ljava/lang/Throwable;)Ljava/lang/String;

    move-result-object v6

    invoke-static {v5, v6}, Landroid/util/Log;->e(Ljava/lang/String;Ljava/lang/String;)I

    .end local v1    # "e":Ljava/lang/Exception;
    .end local v2    # "manager":Landroid/app/AppOpsManager;
    :goto_1
    move v5, v7

    .line 99
    goto :goto_0

    .line 97
    :cond_1
    const-string v5, "HuaweiUtils"

    const-string v6, "Below API 19 cannot invoke!"

    invoke-static {v5, v6}, Landroid/util/Log;->e(Ljava/lang/String;Ljava/lang/String;)I

    goto :goto_1
.end method
