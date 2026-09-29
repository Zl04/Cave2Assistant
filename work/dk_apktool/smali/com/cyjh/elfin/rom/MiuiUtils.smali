.class public Lcom/cyjh/elfin/rom/MiuiUtils;
.super Ljava/lang/Object;
.source "MiuiUtils.java"


# static fields
.field private static final TAG:Ljava/lang/String; = "MiuiUtils"


# direct methods
.method public constructor <init>()V
    .locals 0

    .prologue
    .line 19
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method

.method public static applyMiuiPermission(Landroid/content/Context;)V
    .locals 4
    .param p0, "context"    # Landroid/content/Context;

    .prologue
    .line 80
    invoke-static {}, Lcom/cyjh/elfin/rom/MiuiUtils;->getMiuiVersion()I

    move-result v0

    .line 81
    .local v0, "versionCode":I
    const/4 v1, 0x5

    if-ne v0, v1, :cond_0

    .line 82
    invoke-static {p0}, Lcom/cyjh/elfin/rom/MiuiUtils;->goToMiuiPermissionActivity_V5(Landroid/content/Context;)V

    .line 92
    :goto_0
    return-void

    .line 83
    :cond_0
    const/4 v1, 0x6

    if-ne v0, v1, :cond_1

    .line 84
    invoke-static {p0}, Lcom/cyjh/elfin/rom/MiuiUtils;->goToMiuiPermissionActivity_V6(Landroid/content/Context;)V

    goto :goto_0

    .line 85
    :cond_1
    const/4 v1, 0x7

    if-ne v0, v1, :cond_2

    .line 86
    invoke-static {p0}, Lcom/cyjh/elfin/rom/MiuiUtils;->goToMiuiPermissionActivity_V7(Landroid/content/Context;)V

    goto :goto_0

    .line 87
    :cond_2
    const/16 v1, 0x8

    if-ne v0, v1, :cond_3

    .line 88
    invoke-static {p0}, Lcom/cyjh/elfin/rom/MiuiUtils;->goToMiuiPermissionActivity_V8(Landroid/content/Context;)V

    goto :goto_0

    .line 90
    :cond_3
    const-string v1, "MiuiUtils"

    new-instance v2, Ljava/lang/StringBuilder;

    invoke-direct {v2}, Ljava/lang/StringBuilder;-><init>()V

    const-string v3, "this is a special MIUI rom version, its version code "

    invoke-virtual {v2, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    invoke-virtual {v2, v0}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v2

    invoke-virtual {v2}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v2

    invoke-static {v1, v2}, Landroid/util/Log;->e(Ljava/lang/String;Ljava/lang/String;)I

    goto :goto_0
.end method

.method public static checkFloatWindowPermission(Landroid/content/Context;)Z
    .locals 2
    .param p0, "context"    # Landroid/content/Context;

    .prologue
    .line 44
    sget v0, Landroid/os/Build$VERSION;->SDK_INT:I

    .line 46
    .local v0, "version":I
    const/16 v1, 0x13

    if-lt v0, v1, :cond_0

    .line 47
    const/16 v1, 0x18

    invoke-static {p0, v1}, Lcom/cyjh/elfin/rom/MiuiUtils;->checkOp(Landroid/content/Context;I)Z

    move-result v1

    .line 54
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

    .line 60
    sget v4, Landroid/os/Build$VERSION;->SDK_INT:I

    .line 61
    .local v4, "version":I
    const/16 v5, 0x13

    if-lt v4, v5, :cond_1

    .line 62
    const-string v5, "appops"

    invoke-virtual {p0, v5}, Landroid/content/Context;->getSystemService(Ljava/lang/String;)Ljava/lang/Object;

    move-result-object v2

    check-cast v2, Landroid/app/AppOpsManager;

    .line 64
    .local v2, "manager":Landroid/app/AppOpsManager;
    :try_start_0
    const-class v0, Landroid/app/AppOpsManager;

    .line 65
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

    .line 66
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

    .line 73
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

    .line 66
    goto :goto_0

    .line 67
    .end local v0    # "clazz":Ljava/lang/Class;
    .end local v3    # "method":Ljava/lang/reflect/Method;
    :catch_0
    move-exception v1

    .line 68
    .local v1, "e":Ljava/lang/Exception;
    const-string v5, "MiuiUtils"

    invoke-static {v1}, Landroid/util/Log;->getStackTraceString(Ljava/lang/Throwable;)Ljava/lang/String;

    move-result-object v6

    invoke-static {v5, v6}, Landroid/util/Log;->e(Ljava/lang/String;Ljava/lang/String;)I

    .end local v1    # "e":Ljava/lang/Exception;
    .end local v2    # "manager":Landroid/app/AppOpsManager;
    :goto_1
    move v5, v7

    .line 73
    goto :goto_0

    .line 71
    :cond_1
    const-string v5, "MiuiUtils"

    const-string v6, "Below API 19 cannot invoke!"

    invoke-static {v5, v6}, Landroid/util/Log;->e(Ljava/lang/String;Ljava/lang/String;)I

    goto :goto_1
.end method

.method public static getMiuiVersion()I
    .locals 5

    .prologue
    .line 28
    const-string v2, "ro.miui.ui.version.name"

    invoke-static {v2}, Lcom/cyjh/elfin/rom/RomUtils;->getSystemProperty(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v1

    .line 29
    .local v1, "version":Ljava/lang/String;
    if-eqz v1, :cond_0

    .line 31
    const/4 v2, 0x1

    :try_start_0
    invoke-virtual {v1, v2}, Ljava/lang/String;->substring(I)Ljava/lang/String;

    move-result-object v2

    invoke-static {v2}, Ljava/lang/Integer;->parseInt(Ljava/lang/String;)I
    :try_end_0
    .catch Ljava/lang/Exception; {:try_start_0 .. :try_end_0} :catch_0

    move-result v2

    .line 37
    :goto_0
    return v2

    .line 32
    :catch_0
    move-exception v0

    .line 33
    .local v0, "e":Ljava/lang/Exception;
    const-string v2, "MiuiUtils"

    new-instance v3, Ljava/lang/StringBuilder;

    invoke-direct {v3}, Ljava/lang/StringBuilder;-><init>()V

    const-string v4, "get miui version code error, version : "

    invoke-virtual {v3, v4}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v3

    invoke-virtual {v3, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v3

    invoke-virtual {v3}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v3

    invoke-static {v2, v3}, Landroid/util/Log;->e(Ljava/lang/String;Ljava/lang/String;)I

    .line 34
    const-string v2, "MiuiUtils"

    invoke-static {v0}, Landroid/util/Log;->getStackTraceString(Ljava/lang/Throwable;)Ljava/lang/String;

    move-result-object v3

    invoke-static {v2, v3}, Landroid/util/Log;->e(Ljava/lang/String;Ljava/lang/String;)I

    .line 37
    .end local v0    # "e":Ljava/lang/Exception;
    :cond_0
    const/4 v2, -0x1

    goto :goto_0
.end method

.method public static goToMiuiPermissionActivity_V5(Landroid/content/Context;)V
    .locals 5
    .param p0, "context"    # Landroid/content/Context;

    .prologue
    .line 105
    const/4 v0, 0x0

    .line 106
    .local v0, "intent":Landroid/content/Intent;
    invoke-virtual {p0}, Landroid/content/Context;->getPackageName()Ljava/lang/String;

    move-result-object v1

    .line 107
    .local v1, "packageName":Ljava/lang/String;
    new-instance v0, Landroid/content/Intent;

    .end local v0    # "intent":Landroid/content/Intent;
    const-string v3, "android.settings.APPLICATION_DETAILS_SETTINGS"

    invoke-direct {v0, v3}, Landroid/content/Intent;-><init>(Ljava/lang/String;)V

    .line 108
    .restart local v0    # "intent":Landroid/content/Intent;
    const-string v3, "package"

    const/4 v4, 0x0

    invoke-static {v3, v1, v4}, Landroid/net/Uri;->fromParts(Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;)Landroid/net/Uri;

    move-result-object v2

    .line 109
    .local v2, "uri":Landroid/net/Uri;
    invoke-virtual {v0, v2}, Landroid/content/Intent;->setData(Landroid/net/Uri;)Landroid/content/Intent;

    .line 110
    const/high16 v3, 0x10000000

    invoke-virtual {v0, v3}, Landroid/content/Intent;->setFlags(I)Landroid/content/Intent;

    .line 111
    invoke-static {v0, p0}, Lcom/cyjh/elfin/rom/MiuiUtils;->isIntentAvailable(Landroid/content/Intent;Landroid/content/Context;)Z

    move-result v3

    if-eqz v3, :cond_0

    .line 112
    invoke-virtual {p0, v0}, Landroid/content/Context;->startActivity(Landroid/content/Intent;)V

    .line 134
    :goto_0
    return-void

    .line 114
    :cond_0
    const-string v3, "MiuiUtils"

    const-string v4, "intent is not available!"

    invoke-static {v3, v4}, Landroid/util/Log;->e(Ljava/lang/String;Ljava/lang/String;)I

    goto :goto_0
.end method

.method public static goToMiuiPermissionActivity_V6(Landroid/content/Context;)V
    .locals 3
    .param p0, "context"    # Landroid/content/Context;

    .prologue
    .line 140
    new-instance v0, Landroid/content/Intent;

    const-string v1, "miui.intent.action.APP_PERM_EDITOR"

    invoke-direct {v0, v1}, Landroid/content/Intent;-><init>(Ljava/lang/String;)V

    .line 141
    .local v0, "intent":Landroid/content/Intent;
    const-string v1, "com.miui.securitycenter"

    const-string v2, "com.miui.permcenter.permissions.AppPermissionsEditorActivity"

    invoke-virtual {v0, v1, v2}, Landroid/content/Intent;->setClassName(Ljava/lang/String;Ljava/lang/String;)Landroid/content/Intent;

    .line 142
    const-string v1, "extra_pkgname"

    invoke-virtual {p0}, Landroid/content/Context;->getPackageName()Ljava/lang/String;

    move-result-object v2

    invoke-virtual {v0, v1, v2}, Landroid/content/Intent;->putExtra(Ljava/lang/String;Ljava/lang/String;)Landroid/content/Intent;

    .line 143
    const/high16 v1, 0x10000000

    invoke-virtual {v0, v1}, Landroid/content/Intent;->setFlags(I)Landroid/content/Intent;

    .line 145
    invoke-static {v0, p0}, Lcom/cyjh/elfin/rom/MiuiUtils;->isIntentAvailable(Landroid/content/Intent;Landroid/content/Context;)Z

    move-result v1

    if-eqz v1, :cond_0

    .line 146
    invoke-virtual {p0, v0}, Landroid/content/Context;->startActivity(Landroid/content/Intent;)V

    .line 150
    :goto_0
    return-void

    .line 148
    :cond_0
    const-string v1, "MiuiUtils"

    const-string v2, "Intent is not available!"

    invoke-static {v1, v2}, Landroid/util/Log;->e(Ljava/lang/String;Ljava/lang/String;)I

    goto :goto_0
.end method

.method public static goToMiuiPermissionActivity_V7(Landroid/content/Context;)V
    .locals 3
    .param p0, "context"    # Landroid/content/Context;

    .prologue
    .line 156
    new-instance v0, Landroid/content/Intent;

    const-string v1, "miui.intent.action.APP_PERM_EDITOR"

    invoke-direct {v0, v1}, Landroid/content/Intent;-><init>(Ljava/lang/String;)V

    .line 157
    .local v0, "intent":Landroid/content/Intent;
    const-string v1, "com.miui.securitycenter"

    const-string v2, "com.miui.permcenter.permissions.AppPermissionsEditorActivity"

    invoke-virtual {v0, v1, v2}, Landroid/content/Intent;->setClassName(Ljava/lang/String;Ljava/lang/String;)Landroid/content/Intent;

    .line 158
    const-string v1, "extra_pkgname"

    invoke-virtual {p0}, Landroid/content/Context;->getPackageName()Ljava/lang/String;

    move-result-object v2

    invoke-virtual {v0, v1, v2}, Landroid/content/Intent;->putExtra(Ljava/lang/String;Ljava/lang/String;)Landroid/content/Intent;

    .line 159
    const/high16 v1, 0x10000000

    invoke-virtual {v0, v1}, Landroid/content/Intent;->setFlags(I)Landroid/content/Intent;

    .line 161
    invoke-static {v0, p0}, Lcom/cyjh/elfin/rom/MiuiUtils;->isIntentAvailable(Landroid/content/Intent;Landroid/content/Context;)Z

    move-result v1

    if-eqz v1, :cond_0

    .line 162
    invoke-virtual {p0, v0}, Landroid/content/Context;->startActivity(Landroid/content/Intent;)V

    .line 166
    :goto_0
    return-void

    .line 164
    :cond_0
    const-string v1, "MiuiUtils"

    const-string v2, "Intent is not available!"

    invoke-static {v1, v2}, Landroid/util/Log;->e(Ljava/lang/String;Ljava/lang/String;)I

    goto :goto_0
.end method

.method public static goToMiuiPermissionActivity_V8(Landroid/content/Context;)V
    .locals 4
    .param p0, "context"    # Landroid/content/Context;

    .prologue
    const/high16 v3, 0x10000000

    .line 172
    new-instance v0, Landroid/content/Intent;

    const-string v1, "miui.intent.action.APP_PERM_EDITOR"

    invoke-direct {v0, v1}, Landroid/content/Intent;-><init>(Ljava/lang/String;)V

    .line 173
    .local v0, "intent":Landroid/content/Intent;
    const-string v1, "com.miui.securitycenter"

    const-string v2, "com.miui.permcenter.permissions.PermissionsEditorActivity"

    invoke-virtual {v0, v1, v2}, Landroid/content/Intent;->setClassName(Ljava/lang/String;Ljava/lang/String;)Landroid/content/Intent;

    .line 175
    const-string v1, "extra_pkgname"

    invoke-virtual {p0}, Landroid/content/Context;->getPackageName()Ljava/lang/String;

    move-result-object v2

    invoke-virtual {v0, v1, v2}, Landroid/content/Intent;->putExtra(Ljava/lang/String;Ljava/lang/String;)Landroid/content/Intent;

    .line 176
    invoke-virtual {v0, v3}, Landroid/content/Intent;->setFlags(I)Landroid/content/Intent;

    .line 178
    invoke-static {v0, p0}, Lcom/cyjh/elfin/rom/MiuiUtils;->isIntentAvailable(Landroid/content/Intent;Landroid/content/Context;)Z

    move-result v1

    if-eqz v1, :cond_0

    .line 179
    invoke-virtual {p0, v0}, Landroid/content/Context;->startActivity(Landroid/content/Intent;)V

    .line 192
    :goto_0
    return-void

    .line 181
    :cond_0
    new-instance v0, Landroid/content/Intent;

    .end local v0    # "intent":Landroid/content/Intent;
    const-string v1, "miui.intent.action.APP_PERM_EDITOR"

    invoke-direct {v0, v1}, Landroid/content/Intent;-><init>(Ljava/lang/String;)V

    .line 182
    .restart local v0    # "intent":Landroid/content/Intent;
    const-string v1, "com.miui.securitycenter"

    invoke-virtual {v0, v1}, Landroid/content/Intent;->setPackage(Ljava/lang/String;)Landroid/content/Intent;

    .line 183
    const-string v1, "extra_pkgname"

    invoke-virtual {p0}, Landroid/content/Context;->getPackageName()Ljava/lang/String;

    move-result-object v2

    invoke-virtual {v0, v1, v2}, Landroid/content/Intent;->putExtra(Ljava/lang/String;Ljava/lang/String;)Landroid/content/Intent;

    .line 184
    invoke-virtual {v0, v3}, Landroid/content/Intent;->setFlags(I)Landroid/content/Intent;

    .line 186
    invoke-static {v0, p0}, Lcom/cyjh/elfin/rom/MiuiUtils;->isIntentAvailable(Landroid/content/Intent;Landroid/content/Context;)Z

    move-result v1

    if-eqz v1, :cond_1

    .line 187
    invoke-virtual {p0, v0}, Landroid/content/Context;->startActivity(Landroid/content/Intent;)V

    goto :goto_0

    .line 189
    :cond_1
    const-string v1, "MiuiUtils"

    const-string v2, "Intent is not available!"

    invoke-static {v1, v2}, Landroid/util/Log;->e(Ljava/lang/String;Ljava/lang/String;)I

    goto :goto_0
.end method

.method private static isIntentAvailable(Landroid/content/Intent;Landroid/content/Context;)Z
    .locals 3
    .param p0, "intent"    # Landroid/content/Intent;
    .param p1, "context"    # Landroid/content/Context;

    .prologue
    const/4 v0, 0x0

    .line 95
    if-nez p0, :cond_1

    .line 98
    :cond_0
    :goto_0
    return v0

    :cond_1
    invoke-virtual {p1}, Landroid/content/Context;->getPackageManager()Landroid/content/pm/PackageManager;

    move-result-object v1

    const/high16 v2, 0x10000

    invoke-virtual {v1, p0, v2}, Landroid/content/pm/PackageManager;->queryIntentActivities(Landroid/content/Intent;I)Ljava/util/List;

    move-result-object v1

    invoke-interface {v1}, Ljava/util/List;->size()I

    move-result v1

    if-lez v1, :cond_0

    const/4 v0, 0x1

    goto :goto_0
.end method
