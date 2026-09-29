.class public Lcom/cyjh/share/util/PathUtils;
.super Ljava/lang/Object;
.source "PathUtils.java"


# static fields
.field private static final DIR_CSTEMP:Ljava/lang/String; = "CSTemp"

.field private static final DIR_MOBILEANJIAN:Ljava/lang/String; = "MobileAnJian"

.field private static final DIR_MQTEMP:Ljava/lang/String; = "MQTemp"

.field private static final DIR_SCRIPT:Ljava/lang/String; = "Script"

.field private static final DIR_UI_CONFIG:Ljava/lang/String; = "UIConfig"


# direct methods
.method public constructor <init>()V
    .locals 0

    .prologue
    .line 10
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method

.method public static getMobileAnjianCSTempPath()Ljava/lang/String;
    .locals 2

    .prologue
    .line 50
    invoke-static {}, Lcom/cyjh/share/util/PathUtils;->getMobileAnjianPath()Ljava/lang/String;

    move-result-object v0

    const-string v1, "CSTemp"

    invoke-static {v0, v1}, Lcom/cyjh/share/util/PathUtils;->makePath(Ljava/lang/String;Ljava/lang/String;)Ljava/lang/String;

    move-result-object v0

    invoke-static {v0}, Lcom/cyjh/share/util/PathUtils;->mkdirs(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v0

    return-object v0
.end method

.method public static getMobileAnjianPath()Ljava/lang/String;
    .locals 2

    .prologue
    .line 32
    invoke-static {}, Lcom/cyjh/share/util/PathUtils;->getSDCardPath()Ljava/lang/String;

    move-result-object v0

    const-string v1, "MobileAnJian"

    invoke-static {v0, v1}, Lcom/cyjh/share/util/PathUtils;->makePath(Ljava/lang/String;Ljava/lang/String;)Ljava/lang/String;

    move-result-object v0

    return-object v0
.end method

.method public static getMobileAnjianScriptPath()Ljava/lang/String;
    .locals 2

    .prologue
    .line 41
    invoke-static {}, Lcom/cyjh/share/util/PathUtils;->getMobileAnjianPath()Ljava/lang/String;

    move-result-object v0

    const-string v1, "Script"

    invoke-static {v0, v1}, Lcom/cyjh/share/util/PathUtils;->makePath(Ljava/lang/String;Ljava/lang/String;)Ljava/lang/String;

    move-result-object v0

    return-object v0
.end method

.method public static getMobileAnjianUIConfigPath()Ljava/lang/String;
    .locals 2

    .prologue
    .line 68
    invoke-static {}, Lcom/cyjh/share/util/PathUtils;->getMobileAnjianPath()Ljava/lang/String;

    move-result-object v0

    const-string v1, "UIConfig"

    invoke-static {v0, v1}, Lcom/cyjh/share/util/PathUtils;->makePath(Ljava/lang/String;Ljava/lang/String;)Ljava/lang/String;

    move-result-object v0

    invoke-static {v0}, Lcom/cyjh/share/util/PathUtils;->mkdirs(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v0

    return-object v0
.end method

.method public static getMqTempPath()Ljava/lang/String;
    .locals 2

    .prologue
    .line 59
    invoke-static {}, Lcom/cyjh/share/util/PathUtils;->getMobileAnjianPath()Ljava/lang/String;

    move-result-object v0

    const-string v1, "MQTemp"

    invoke-static {v0, v1}, Lcom/cyjh/share/util/PathUtils;->makePath(Ljava/lang/String;Ljava/lang/String;)Ljava/lang/String;

    move-result-object v0

    invoke-static {v0}, Lcom/cyjh/share/util/PathUtils;->mkdirs(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v0

    return-object v0
.end method

.method public static getSDCardPath()Ljava/lang/String;
    .locals 1

    .prologue
    .line 23
    invoke-static {}, Landroid/os/Environment;->getExternalStorageDirectory()Ljava/io/File;

    move-result-object v0

    invoke-virtual {v0}, Ljava/io/File;->getAbsolutePath()Ljava/lang/String;

    move-result-object v0

    return-object v0
.end method

.method private static makePath(Ljava/lang/String;Ljava/lang/String;)Ljava/lang/String;
    .locals 2
    .param p0, "path1"    # Ljava/lang/String;
    .param p1, "path2"    # Ljava/lang/String;

    .prologue
    .line 101
    sget-object v0, Ljava/io/File;->separator:Ljava/lang/String;

    invoke-virtual {p0, v0}, Ljava/lang/String;->endsWith(Ljava/lang/String;)Z

    move-result v0

    if-eqz v0, :cond_0

    .line 102
    new-instance v0, Ljava/lang/StringBuilder;

    invoke-direct {v0}, Ljava/lang/StringBuilder;-><init>()V

    invoke-virtual {v0, p0}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-virtual {v0, p1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-virtual {v0}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v0

    .line 104
    :goto_0
    return-object v0

    :cond_0
    new-instance v0, Ljava/lang/StringBuilder;

    invoke-direct {v0}, Ljava/lang/StringBuilder;-><init>()V

    invoke-virtual {v0, p0}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    sget-object v1, Ljava/io/File;->separator:Ljava/lang/String;

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-virtual {v0, p1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-virtual {v0}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v0

    goto :goto_0
.end method

.method private static mkdirs(Ljava/lang/String;)Ljava/lang/String;
    .locals 3
    .param p0, "path"    # Ljava/lang/String;

    .prologue
    .line 77
    new-instance v1, Ljava/io/File;

    invoke-direct {v1, p0}, Ljava/io/File;-><init>(Ljava/lang/String;)V

    .line 79
    .local v1, "file":Ljava/io/File;
    :try_start_0
    invoke-virtual {v1}, Ljava/io/File;->exists()Z

    move-result v2

    if-nez v2, :cond_0

    .line 80
    invoke-virtual {v1}, Ljava/io/File;->mkdirs()Z
    :try_end_0
    .catch Ljava/lang/Exception; {:try_start_0 .. :try_end_0} :catch_0

    .line 86
    :cond_0
    :goto_0
    invoke-virtual {v1}, Ljava/io/File;->getAbsolutePath()Ljava/lang/String;

    move-result-object v2

    return-object v2

    .line 82
    :catch_0
    move-exception v0

    .line 84
    .local v0, "e":Ljava/lang/Exception;
    invoke-virtual {v0}, Ljava/lang/Exception;->printStackTrace()V

    goto :goto_0
.end method
