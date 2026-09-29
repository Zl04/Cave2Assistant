.class public Lcom/cyjh/mobileanjian/ipc/stuff/AppAttr;
.super Ljava/lang/Object;
.source "SourceFile"


# static fields
.field public static final ANJIAN_PKG_NAME:Ljava/lang/String; = "com.cyjh.mobileanjian"

.field private static a:Z

.field private static b:Ljava/lang/String;

.field private static c:Ljava/lang/String;

.field private static d:Ljava/lang/String;


# direct methods
.method static constructor <clinit>()V
    .locals 1

    .prologue
    .line 14
    const/4 v0, 0x1

    sput-boolean v0, Lcom/cyjh/mobileanjian/ipc/stuff/AppAttr;->a:Z

    .line 15
    const-string v0, "12345678-0000-0000-0000-BA9876543210"

    sput-object v0, Lcom/cyjh/mobileanjian/ipc/stuff/AppAttr;->b:Ljava/lang/String;

    .line 16
    const-string v0, "2015-06-24"

    sput-object v0, Lcom/cyjh/mobileanjian/ipc/stuff/AppAttr;->c:Ljava/lang/String;

    .line 18
    const-string v0, ""

    sput-object v0, Lcom/cyjh/mobileanjian/ipc/stuff/AppAttr;->d:Ljava/lang/String;

    return-void
.end method

.method public constructor <init>()V
    .locals 0

    .prologue
    .line 10
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method

.method public static getApkVersionCode(Landroid/content/Context;)I
    .locals 4

    .prologue
    .line 74
    const/16 v0, -0x7d0

    .line 75
    invoke-virtual {p0}, Landroid/content/Context;->getPackageManager()Landroid/content/pm/PackageManager;

    move-result-object v1

    .line 78
    :try_start_0
    invoke-static {p0}, Lcom/cyjh/mobileanjian/ipc/stuff/AppAttr;->getPackageName(Landroid/content/Context;)Ljava/lang/String;

    move-result-object v2

    const/4 v3, 0x0

    invoke-virtual {v1, v2, v3}, Landroid/content/pm/PackageManager;->getPackageInfo(Ljava/lang/String;I)Landroid/content/pm/PackageInfo;

    move-result-object v1

    .line 79
    iget v0, v1, Landroid/content/pm/PackageInfo;->versionCode:I
    :try_end_0
    .catch Landroid/content/pm/PackageManager$NameNotFoundException; {:try_start_0 .. :try_end_0} :catch_0

    .line 84
    :goto_0
    return v0

    .line 80
    :catch_0
    move-exception v1

    .line 82
    invoke-virtual {v1}, Landroid/content/pm/PackageManager$NameNotFoundException;->printStackTrace()V

    goto :goto_0
.end method

.method public static getApkVersionName(Landroid/content/Context;)Ljava/lang/String;
    .locals 4

    .prologue
    .line 59
    const-string v0, "NOT_FOUND"

    .line 60
    invoke-virtual {p0}, Landroid/content/Context;->getPackageManager()Landroid/content/pm/PackageManager;

    move-result-object v1

    .line 63
    :try_start_0
    invoke-static {p0}, Lcom/cyjh/mobileanjian/ipc/stuff/AppAttr;->getPackageName(Landroid/content/Context;)Ljava/lang/String;

    move-result-object v2

    const/4 v3, 0x0

    invoke-virtual {v1, v2, v3}, Landroid/content/pm/PackageManager;->getPackageInfo(Ljava/lang/String;I)Landroid/content/pm/PackageInfo;

    move-result-object v1

    .line 64
    iget-object v0, v1, Landroid/content/pm/PackageInfo;->versionName:Ljava/lang/String;
    :try_end_0
    .catch Landroid/content/pm/PackageManager$NameNotFoundException; {:try_start_0 .. :try_end_0} :catch_0

    .line 69
    :goto_0
    return-object v0

    .line 65
    :catch_0
    move-exception v1

    .line 67
    invoke-virtual {v1}, Landroid/content/pm/PackageManager$NameNotFoundException;->printStackTrace()V

    goto :goto_0
.end method

.method public static getAppId()Ljava/lang/String;
    .locals 1

    .prologue
    .line 47
    sget-object v0, Lcom/cyjh/mobileanjian/ipc/stuff/AppAttr;->b:Ljava/lang/String;

    return-object v0
.end method

.method public static getAppName()Ljava/lang/String;
    .locals 1

    .prologue
    .line 94
    sget-object v0, Lcom/cyjh/mobileanjian/ipc/stuff/AppAttr;->d:Ljava/lang/String;

    return-object v0
.end method

.method public static getEfinVersion()Ljava/lang/String;
    .locals 1

    .prologue
    .line 37
    sget-object v0, Lcom/cyjh/mobileanjian/ipc/stuff/AppAttr;->c:Ljava/lang/String;

    return-object v0
.end method

.method public static getPackageName(Landroid/content/Context;)Ljava/lang/String;
    .locals 1

    .prologue
    .line 54
    invoke-virtual {p0}, Landroid/content/Context;->getApplicationContext()Landroid/content/Context;

    move-result-object v0

    invoke-virtual {v0}, Landroid/content/Context;->getPackageName()Ljava/lang/String;

    move-result-object v0

    return-object v0
.end method

.method public static isAnjian(Landroid/content/Context;)Z
    .locals 2

    .prologue
    .line 99
    invoke-virtual {p0}, Landroid/content/Context;->getApplicationContext()Landroid/content/Context;

    move-result-object v0

    invoke-virtual {v0}, Landroid/content/Context;->getPackageName()Ljava/lang/String;

    move-result-object v0

    const-string v1, "com.cyjh.mobileanjian"

    invoke-virtual {v0, v1}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v0

    return v0
.end method

.method public static isEfinFree()Z
    .locals 1

    .prologue
    .line 27
    sget-boolean v0, Lcom/cyjh/mobileanjian/ipc/stuff/AppAttr;->a:Z

    return v0
.end method

.method public static setAppId(Ljava/lang/String;)V
    .locals 0

    .prologue
    .line 42
    sput-object p0, Lcom/cyjh/mobileanjian/ipc/stuff/AppAttr;->b:Ljava/lang/String;

    .line 43
    return-void
.end method

.method public static setAppName(Ljava/lang/String;)V
    .locals 0

    .prologue
    .line 89
    sput-object p0, Lcom/cyjh/mobileanjian/ipc/stuff/AppAttr;->d:Ljava/lang/String;

    .line 90
    return-void
.end method

.method public static setEfinVersion(Ljava/lang/String;)V
    .locals 0

    .prologue
    .line 32
    sput-object p0, Lcom/cyjh/mobileanjian/ipc/stuff/AppAttr;->c:Ljava/lang/String;

    .line 33
    return-void
.end method

.method public static setElfinFree(Z)V
    .locals 0

    .prologue
    .line 22
    sput-boolean p0, Lcom/cyjh/mobileanjian/ipc/stuff/AppAttr;->a:Z

    .line 23
    return-void
.end method
