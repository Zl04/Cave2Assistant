.class public Lcom/cyjh/elfin/rom/RomUtils;
.super Ljava/lang/Object;
.source "RomUtils.java"


# static fields
.field private static final TAG:Ljava/lang/String; = "RomUtils"


# direct methods
.method public constructor <init>()V
    .locals 0

    .prologue
    .line 20
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method

.method public static checkIs360Rom()Z
    .locals 2

    .prologue
    .line 102
    sget-object v0, Landroid/os/Build;->MANUFACTURER:Ljava/lang/String;

    const-string v1, "QiKU"

    invoke-virtual {v0, v1}, Ljava/lang/String;->contains(Ljava/lang/CharSequence;)Z

    move-result v0

    if-nez v0, :cond_0

    sget-object v0, Landroid/os/Build;->MANUFACTURER:Ljava/lang/String;

    const-string v1, "360"

    .line 103
    invoke-virtual {v0, v1}, Ljava/lang/String;->contains(Ljava/lang/CharSequence;)Z

    move-result v0

    if-eqz v0, :cond_1

    :cond_0
    const/4 v0, 0x1

    .line 102
    :goto_0
    return v0

    .line 103
    :cond_1
    const/4 v0, 0x0

    goto :goto_0
.end method

.method public static checkIsHuaweiRom()Z
    .locals 2

    .prologue
    .line 78
    sget-object v0, Landroid/os/Build;->MANUFACTURER:Ljava/lang/String;

    const-string v1, "HUAWEI"

    invoke-virtual {v0, v1}, Ljava/lang/String;->contains(Ljava/lang/CharSequence;)Z

    move-result v0

    return v0
.end method

.method public static checkIsMeizuRom()Z
    .locals 4

    .prologue
    const/4 v1, 0x0

    .line 90
    const-string v2, "ro.build.display.id"

    invoke-static {v2}, Lcom/cyjh/elfin/rom/RomUtils;->getSystemProperty(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v0

    .line 91
    .local v0, "meizuFlymeOSFlag":Ljava/lang/String;
    invoke-static {v0}, Landroid/text/TextUtils;->isEmpty(Ljava/lang/CharSequence;)Z

    move-result v2

    if-eqz v2, :cond_1

    .line 96
    :cond_0
    :goto_0
    return v1

    .line 93
    :cond_1
    const-string v2, "flyme"

    invoke-virtual {v0, v2}, Ljava/lang/String;->contains(Ljava/lang/CharSequence;)Z

    move-result v2

    if-nez v2, :cond_2

    invoke-virtual {v0}, Ljava/lang/String;->toLowerCase()Ljava/lang/String;

    move-result-object v2

    const-string v3, "flyme"

    invoke-virtual {v2, v3}, Ljava/lang/String;->contains(Ljava/lang/CharSequence;)Z

    move-result v2

    if-eqz v2, :cond_0

    .line 94
    :cond_2
    const/4 v1, 0x1

    goto :goto_0
.end method

.method public static checkIsMiuiRom()Z
    .locals 1

    .prologue
    .line 85
    const-string v0, "ro.miui.ui.version.name"

    invoke-static {v0}, Lcom/cyjh/elfin/rom/RomUtils;->getSystemProperty(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v0

    invoke-static {v0}, Landroid/text/TextUtils;->isEmpty(Ljava/lang/CharSequence;)Z

    move-result v0

    if-nez v0, :cond_0

    const/4 v0, 0x1

    :goto_0
    return v0

    :cond_0
    const/4 v0, 0x0

    goto :goto_0
.end method

.method public static checkIsOppoRom()Z
    .locals 2

    .prologue
    .line 108
    sget-object v0, Landroid/os/Build;->MANUFACTURER:Ljava/lang/String;

    const-string v1, "OPPO"

    invoke-virtual {v0, v1}, Ljava/lang/String;->contains(Ljava/lang/CharSequence;)Z

    move-result v0

    if-nez v0, :cond_0

    sget-object v0, Landroid/os/Build;->MANUFACTURER:Ljava/lang/String;

    const-string v1, "oppo"

    invoke-virtual {v0, v1}, Ljava/lang/String;->contains(Ljava/lang/CharSequence;)Z

    move-result v0

    if-eqz v0, :cond_1

    :cond_0
    const/4 v0, 0x1

    :goto_0
    return v0

    :cond_1
    const/4 v0, 0x0

    goto :goto_0
.end method

.method public static getEmuiVersion()D
    .locals 6

    .prologue
    .line 29
    :try_start_0
    const-string v3, "ro.build.version.emui"

    invoke-static {v3}, Lcom/cyjh/elfin/rom/RomUtils;->getSystemProperty(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v1

    .line 30
    .local v1, "emuiVersion":Ljava/lang/String;
    const-string v3, "_"

    invoke-virtual {v1, v3}, Ljava/lang/String;->indexOf(Ljava/lang/String;)I

    move-result v3

    add-int/lit8 v3, v3, 0x1

    invoke-virtual {v1, v3}, Ljava/lang/String;->substring(I)Ljava/lang/String;

    move-result-object v2

    .line 31
    .local v2, "version":Ljava/lang/String;
    invoke-static {v2}, Ljava/lang/Double;->parseDouble(Ljava/lang/String;)D
    :try_end_0
    .catch Ljava/lang/Exception; {:try_start_0 .. :try_end_0} :catch_0

    move-result-wide v4

    .line 35
    .end local v2    # "version":Ljava/lang/String;
    :goto_0
    return-wide v4

    .line 32
    :catch_0
    move-exception v0

    .line 33
    .local v0, "e":Ljava/lang/Exception;
    invoke-virtual {v0}, Ljava/lang/Exception;->printStackTrace()V

    .line 35
    const-wide/high16 v4, 0x4010000000000000L    # 4.0

    goto :goto_0
.end method

.method public static getMiuiVersion()I
    .locals 5

    .prologue
    .line 44
    const-string v2, "ro.miui.ui.version.name"

    invoke-static {v2}, Lcom/cyjh/elfin/rom/RomUtils;->getSystemProperty(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v1

    .line 45
    .local v1, "version":Ljava/lang/String;
    if-eqz v1, :cond_0

    .line 47
    const/4 v2, 0x1

    :try_start_0
    invoke-virtual {v1, v2}, Ljava/lang/String;->substring(I)Ljava/lang/String;

    move-result-object v2

    invoke-static {v2}, Ljava/lang/Integer;->parseInt(Ljava/lang/String;)I
    :try_end_0
    .catch Ljava/lang/Exception; {:try_start_0 .. :try_end_0} :catch_0

    move-result v2

    .line 52
    :goto_0
    return v2

    .line 48
    :catch_0
    move-exception v0

    .line 49
    .local v0, "e":Ljava/lang/Exception;
    const-string v2, "RomUtils"

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

    .line 52
    .end local v0    # "e":Ljava/lang/Exception;
    :cond_0
    const/4 v2, -0x1

    goto :goto_0
.end method

.method public static getSystemProperty(Ljava/lang/String;)Ljava/lang/String;
    .locals 9
    .param p0, "propName"    # Ljava/lang/String;

    .prologue
    .line 57
    const/4 v2, 0x0

    .line 59
    .local v2, "input":Ljava/io/BufferedReader;
    :try_start_0
    invoke-static {}, Ljava/lang/Runtime;->getRuntime()Ljava/lang/Runtime;

    move-result-object v6

    new-instance v7, Ljava/lang/StringBuilder;

    invoke-direct {v7}, Ljava/lang/StringBuilder;-><init>()V

    const-string v8, "getprop "

    invoke-virtual {v7, v8}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v7

    invoke-virtual {v7, p0}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v7

    invoke-virtual {v7}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v7

    invoke-virtual {v6, v7}, Ljava/lang/Runtime;->exec(Ljava/lang/String;)Ljava/lang/Process;

    move-result-object v5

    .line 60
    .local v5, "p":Ljava/lang/Process;
    new-instance v3, Ljava/io/BufferedReader;

    new-instance v6, Ljava/io/InputStreamReader;

    invoke-virtual {v5}, Ljava/lang/Process;->getInputStream()Ljava/io/InputStream;

    move-result-object v7

    invoke-direct {v6, v7}, Ljava/io/InputStreamReader;-><init>(Ljava/io/InputStream;)V

    const/16 v7, 0x400

    invoke-direct {v3, v6, v7}, Ljava/io/BufferedReader;-><init>(Ljava/io/Reader;I)V
    :try_end_0
    .catch Ljava/io/IOException; {:try_start_0 .. :try_end_0} :catch_1
    .catchall {:try_start_0 .. :try_end_0} :catchall_0

    .line 61
    .end local v2    # "input":Ljava/io/BufferedReader;
    .local v3, "input":Ljava/io/BufferedReader;
    :try_start_1
    invoke-virtual {v3}, Ljava/io/BufferedReader;->readLine()Ljava/lang/String;

    move-result-object v4

    .line 62
    .local v4, "line":Ljava/lang/String;
    invoke-virtual {v3}, Ljava/io/BufferedReader;->close()V
    :try_end_1
    .catch Ljava/io/IOException; {:try_start_1 .. :try_end_1} :catch_4
    .catchall {:try_start_1 .. :try_end_1} :catchall_1

    .line 67
    if-eqz v3, :cond_0

    .line 69
    :try_start_2
    invoke-virtual {v3}, Ljava/io/BufferedReader;->close()V
    :try_end_2
    .catch Ljava/io/IOException; {:try_start_2 .. :try_end_2} :catch_0

    :cond_0
    :goto_0
    move-object v2, v3

    .line 75
    .end local v3    # "input":Ljava/io/BufferedReader;
    .end local v4    # "line":Ljava/lang/String;
    .end local v5    # "p":Ljava/lang/Process;
    .restart local v2    # "input":Ljava/io/BufferedReader;
    :cond_1
    :goto_1
    return-object v4

    .line 70
    .end local v2    # "input":Ljava/io/BufferedReader;
    .restart local v3    # "input":Ljava/io/BufferedReader;
    .restart local v4    # "line":Ljava/lang/String;
    .restart local v5    # "p":Ljava/lang/Process;
    :catch_0
    move-exception v0

    .line 71
    .local v0, "e":Ljava/io/IOException;
    const-string v6, "RomUtils"

    const-string v7, "Exception while closing InputStream"

    invoke-static {v6, v7, v0}, Landroid/util/Log;->e(Ljava/lang/String;Ljava/lang/String;Ljava/lang/Throwable;)I

    goto :goto_0

    .line 63
    .end local v0    # "e":Ljava/io/IOException;
    .end local v3    # "input":Ljava/io/BufferedReader;
    .end local v4    # "line":Ljava/lang/String;
    .end local v5    # "p":Ljava/lang/Process;
    .restart local v2    # "input":Ljava/io/BufferedReader;
    :catch_1
    move-exception v1

    .line 64
    .local v1, "ex":Ljava/io/IOException;
    :goto_2
    :try_start_3
    const-string v6, "RomUtils"

    new-instance v7, Ljava/lang/StringBuilder;

    invoke-direct {v7}, Ljava/lang/StringBuilder;-><init>()V

    const-string v8, "Unable to read sysprop "

    invoke-virtual {v7, v8}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v7

    invoke-virtual {v7, p0}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v7

    invoke-virtual {v7}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v7

    invoke-static {v6, v7, v1}, Landroid/util/Log;->e(Ljava/lang/String;Ljava/lang/String;Ljava/lang/Throwable;)I
    :try_end_3
    .catchall {:try_start_3 .. :try_end_3} :catchall_0

    .line 65
    const/4 v4, 0x0

    .line 67
    if-eqz v2, :cond_1

    .line 69
    :try_start_4
    invoke-virtual {v2}, Ljava/io/BufferedReader;->close()V
    :try_end_4
    .catch Ljava/io/IOException; {:try_start_4 .. :try_end_4} :catch_2

    goto :goto_1

    .line 70
    :catch_2
    move-exception v0

    .line 71
    .restart local v0    # "e":Ljava/io/IOException;
    const-string v6, "RomUtils"

    const-string v7, "Exception while closing InputStream"

    invoke-static {v6, v7, v0}, Landroid/util/Log;->e(Ljava/lang/String;Ljava/lang/String;Ljava/lang/Throwable;)I

    goto :goto_1

    .line 67
    .end local v0    # "e":Ljava/io/IOException;
    .end local v1    # "ex":Ljava/io/IOException;
    :catchall_0
    move-exception v6

    :goto_3
    if-eqz v2, :cond_2

    .line 69
    :try_start_5
    invoke-virtual {v2}, Ljava/io/BufferedReader;->close()V
    :try_end_5
    .catch Ljava/io/IOException; {:try_start_5 .. :try_end_5} :catch_3

    .line 72
    :cond_2
    :goto_4
    throw v6

    .line 70
    :catch_3
    move-exception v0

    .line 71
    .restart local v0    # "e":Ljava/io/IOException;
    const-string v7, "RomUtils"

    const-string v8, "Exception while closing InputStream"

    invoke-static {v7, v8, v0}, Landroid/util/Log;->e(Ljava/lang/String;Ljava/lang/String;Ljava/lang/Throwable;)I

    goto :goto_4

    .line 67
    .end local v0    # "e":Ljava/io/IOException;
    .end local v2    # "input":Ljava/io/BufferedReader;
    .restart local v3    # "input":Ljava/io/BufferedReader;
    .restart local v5    # "p":Ljava/lang/Process;
    :catchall_1
    move-exception v6

    move-object v2, v3

    .end local v3    # "input":Ljava/io/BufferedReader;
    .restart local v2    # "input":Ljava/io/BufferedReader;
    goto :goto_3

    .line 63
    .end local v2    # "input":Ljava/io/BufferedReader;
    .restart local v3    # "input":Ljava/io/BufferedReader;
    :catch_4
    move-exception v1

    move-object v2, v3

    .end local v3    # "input":Ljava/io/BufferedReader;
    .restart local v2    # "input":Ljava/io/BufferedReader;
    goto :goto_2
.end method
