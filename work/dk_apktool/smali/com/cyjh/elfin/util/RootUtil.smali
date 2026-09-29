.class public Lcom/cyjh/elfin/util/RootUtil;
.super Ljava/lang/Object;
.source "RootUtil.java"


# static fields
.field private static final TAG:Ljava/lang/String; = "ROOT_UTIL"


# direct methods
.method public constructor <init>()V
    .locals 0

    .prologue
    .line 16
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method

.method private static execSuCmd()Z
    .locals 7

    .prologue
    .line 59
    const/4 v4, 0x0

    .line 60
    .local v4, "rootStatus":Z
    const/4 v3, 0x0

    .line 61
    .local v3, "process":Ljava/lang/Process;
    const/4 v1, 0x0

    .line 64
    .local v1, "os":Ljava/io/DataOutputStream;
    :try_start_0
    invoke-static {}, Ljava/lang/Runtime;->getRuntime()Ljava/lang/Runtime;

    move-result-object v5

    const-string v6, "su"

    invoke-virtual {v5, v6}, Ljava/lang/Runtime;->exec(Ljava/lang/String;)Ljava/lang/Process;

    move-result-object v3

    .line 65
    new-instance v2, Ljava/io/DataOutputStream;

    invoke-virtual {v3}, Ljava/lang/Process;->getOutputStream()Ljava/io/OutputStream;

    move-result-object v5

    invoke-direct {v2, v5}, Ljava/io/DataOutputStream;-><init>(Ljava/io/OutputStream;)V
    :try_end_0
    .catch Ljava/lang/Exception; {:try_start_0 .. :try_end_0} :catch_1
    .catchall {:try_start_0 .. :try_end_0} :catchall_0

    .line 67
    .end local v1    # "os":Ljava/io/DataOutputStream;
    .local v2, "os":Ljava/io/DataOutputStream;
    :try_start_1
    const-string v5, "exit\n"

    invoke-virtual {v2, v5}, Ljava/io/DataOutputStream;->writeBytes(Ljava/lang/String;)V

    .line 68
    invoke-virtual {v2}, Ljava/io/DataOutputStream;->flush()V

    .line 69
    invoke-virtual {v3}, Ljava/lang/Process;->waitFor()I

    .line 71
    const-string v5, "ROOT_UTIL"

    const-string v6, ">>>>>>>\u8bbe\u5907\u6709root\u6743\u9650\uff0c\u4f46\u7528\u6237\u4e3b\u52a8\u62d2\u7edd\u4e86\uff0c\u8868\u793a\u8bbe\u5907\u6709root"

    invoke-static {v5, v6}, Lcom/cyjh/mobileanjian/ipc/utils/CLog;->i(Ljava/lang/String;Ljava/lang/String;)V
    :try_end_1
    .catch Ljava/lang/Exception; {:try_start_1 .. :try_end_1} :catch_4
    .catchall {:try_start_1 .. :try_end_1} :catchall_1

    .line 72
    const/4 v4, 0x1

    .line 83
    if-eqz v2, :cond_0

    .line 85
    :try_start_2
    invoke-virtual {v2}, Ljava/io/DataOutputStream;->close()V

    .line 87
    :cond_0
    invoke-virtual {v3}, Ljava/lang/Process;->destroy()V
    :try_end_2
    .catch Ljava/lang/Exception; {:try_start_2 .. :try_end_2} :catch_0

    move-object v1, v2

    .line 93
    .end local v2    # "os":Ljava/io/DataOutputStream;
    .restart local v1    # "os":Ljava/io/DataOutputStream;
    :goto_0
    return v4

    .line 88
    .end local v1    # "os":Ljava/io/DataOutputStream;
    .restart local v2    # "os":Ljava/io/DataOutputStream;
    :catch_0
    move-exception v5

    move-object v1, v2

    .line 91
    .end local v2    # "os":Ljava/io/DataOutputStream;
    .restart local v1    # "os":Ljava/io/DataOutputStream;
    goto :goto_0

    .line 74
    :catch_1
    move-exception v0

    .line 76
    .local v0, "e":Ljava/lang/Exception;
    :goto_1
    :try_start_3
    const-string v5, "ROOT_UTIL"

    const-string v6, ">>>>>>>\u6267\u884csu\u547d\u4ee4\u5f02\u5e38\uff0c\u8868\u793a\u8bbe\u5907\u672aroot"

    invoke-static {v5, v6}, Lcom/cyjh/mobileanjian/ipc/utils/CLog;->i(Ljava/lang/String;Ljava/lang/String;)V
    :try_end_3
    .catchall {:try_start_3 .. :try_end_3} :catchall_0

    .line 77
    const/4 v4, 0x0

    .line 83
    if-eqz v1, :cond_1

    .line 85
    :try_start_4
    invoke-virtual {v1}, Ljava/io/DataOutputStream;->close()V

    .line 87
    :cond_1
    invoke-virtual {v3}, Ljava/lang/Process;->destroy()V
    :try_end_4
    .catch Ljava/lang/Exception; {:try_start_4 .. :try_end_4} :catch_2

    goto :goto_0

    .line 88
    :catch_2
    move-exception v5

    goto :goto_0

    .line 81
    .end local v0    # "e":Ljava/lang/Exception;
    :catchall_0
    move-exception v5

    .line 83
    :goto_2
    if-eqz v1, :cond_2

    .line 85
    :try_start_5
    invoke-virtual {v1}, Ljava/io/DataOutputStream;->close()V

    .line 87
    :cond_2
    invoke-virtual {v3}, Ljava/lang/Process;->destroy()V
    :try_end_5
    .catch Ljava/lang/Exception; {:try_start_5 .. :try_end_5} :catch_3

    .line 90
    :goto_3
    throw v5

    .line 88
    :catch_3
    move-exception v6

    goto :goto_3

    .line 81
    .end local v1    # "os":Ljava/io/DataOutputStream;
    .restart local v2    # "os":Ljava/io/DataOutputStream;
    :catchall_1
    move-exception v5

    move-object v1, v2

    .end local v2    # "os":Ljava/io/DataOutputStream;
    .restart local v1    # "os":Ljava/io/DataOutputStream;
    goto :goto_2

    .line 74
    .end local v1    # "os":Ljava/io/DataOutputStream;
    .restart local v2    # "os":Ljava/io/DataOutputStream;
    :catch_4
    move-exception v0

    move-object v1, v2

    .end local v2    # "os":Ljava/io/DataOutputStream;
    .restart local v1    # "os":Ljava/io/DataOutputStream;
    goto :goto_1
.end method

.method public static isRoot()Z
    .locals 13

    .prologue
    .line 21
    const/4 v4, 0x0

    .line 22
    .local v4, "isRoot":Z
    const-string v10, "PATH"

    invoke-static {v10}, Ljava/lang/System;->getenv(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v9

    .line 23
    .local v9, "sys":Ljava/lang/String;
    new-instance v0, Ljava/util/ArrayList;

    invoke-direct {v0}, Ljava/util/ArrayList;-><init>()V

    .line 24
    .local v0, "commands":Ljava/util/ArrayList;, "Ljava/util/ArrayList<Ljava/lang/String;>;"
    const-string v10, ":"

    invoke-virtual {v9, v10}, Ljava/lang/String;->split(Ljava/lang/String;)[Ljava/lang/String;

    move-result-object v5

    .line 26
    .local v5, "path":[Ljava/lang/String;
    const/4 v3, 0x0

    .local v3, "i":I
    :goto_0
    array-length v10, v5

    if-ge v3, v10, :cond_1

    .line 28
    new-instance v10, Ljava/lang/StringBuilder;

    invoke-direct {v10}, Ljava/lang/StringBuilder;-><init>()V

    aget-object v11, v5, v3

    invoke-virtual {v10, v11}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v10

    sget-object v11, Ljava/io/File;->separator:Ljava/lang/String;

    invoke-virtual {v10, v11}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v10

    const-string v11, "su"

    invoke-virtual {v10, v11}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v10

    invoke-virtual {v10}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v2

    .line 29
    .local v2, "filePathName":Ljava/lang/String;
    new-instance v10, Ljava/io/File;

    invoke-direct {v10, v2}, Ljava/io/File;-><init>(Ljava/lang/String;)V

    invoke-virtual {v10}, Ljava/io/File;->exists()Z

    move-result v10

    if-eqz v10, :cond_0

    .line 31
    new-instance v10, Ljava/lang/StringBuilder;

    invoke-direct {v10}, Ljava/lang/StringBuilder;-><init>()V

    const-string v11, "ls -l "

    invoke-virtual {v10, v11}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v10

    invoke-virtual {v10, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v10

    invoke-virtual {v10}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v1

    .line 32
    .local v1, "commod":Ljava/lang/String;
    invoke-virtual {v0, v1}, Ljava/util/ArrayList;->add(Ljava/lang/Object;)Z

    .line 26
    .end local v1    # "commod":Ljava/lang/String;
    :cond_0
    add-int/lit8 v3, v3, 0x1

    goto :goto_0

    .line 36
    .end local v2    # "filePathName":Ljava/lang/String;
    :cond_1
    const-string v10, "/system/bin/sh"

    invoke-static {v10, v0}, Lcom/cyjh/elfin/util/RootUtil;->run(Ljava/lang/String;Ljava/util/ArrayList;)Ljava/util/ArrayList;

    move-result-object v6

    .line 37
    .local v6, "res":Ljava/util/ArrayList;, "Ljava/util/ArrayList<Ljava/lang/String;>;"
    const-string v7, ""

    .line 38
    .local v7, "response":Ljava/lang/String;
    const/4 v3, 0x0

    :goto_1
    invoke-virtual {v6}, Ljava/util/ArrayList;->size()I

    move-result v10

    if-ge v3, v10, :cond_2

    .line 39
    new-instance v10, Ljava/lang/StringBuilder;

    invoke-direct {v10}, Ljava/lang/StringBuilder;-><init>()V

    invoke-virtual {v10, v7}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v11

    invoke-virtual {v6, v3}, Ljava/util/ArrayList;->get(I)Ljava/lang/Object;

    move-result-object v10

    check-cast v10, Ljava/lang/String;

    invoke-virtual {v11, v10}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v10

    invoke-virtual {v10}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v7

    .line 38
    add-int/lit8 v3, v3, 0x1

    goto :goto_1

    .line 42
    :cond_2
    const-string v10, "ROOT_UTIL"

    new-instance v11, Ljava/lang/StringBuilder;

    invoke-direct {v11}, Ljava/lang/StringBuilder;-><init>()V

    const-string v12, ">>>>>>>>>>>ls -l \u547d\u4ee4\u6267\u884c\u7ed3\u679c\uff1a"

    invoke-virtual {v11, v12}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v11

    invoke-virtual {v11, v7}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v11

    invoke-virtual {v11}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v11

    invoke-static {v10, v11}, Lcom/cyjh/mobileanjian/ipc/utils/CLog;->i(Ljava/lang/String;Ljava/lang/String;)V

    .line 43
    const-string v8, "-rws"

    .line 44
    .local v8, "root":Ljava/lang/String;
    invoke-virtual {v7, v8}, Ljava/lang/String;->contains(Ljava/lang/CharSequence;)Z

    move-result v10

    if-eqz v10, :cond_3

    .line 45
    const/4 v4, 0x1

    .line 53
    :goto_2
    return v4

    .line 50
    :cond_3
    invoke-static {}, Lcom/cyjh/elfin/util/RootUtil;->execSuCmd()Z

    move-result v4

    goto :goto_2
.end method

.method private static run(Ljava/lang/String;Ljava/util/ArrayList;)Ljava/util/ArrayList;
    .locals 11
    .param p0, "shell"    # Ljava/lang/String;
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "(",
            "Ljava/lang/String;",
            "Ljava/util/ArrayList",
            "<",
            "Ljava/lang/String;",
            ">;)",
            "Ljava/util/ArrayList",
            "<",
            "Ljava/lang/String;",
            ">;"
        }
    .end annotation

    .prologue
    .line 97
    .local p1, "commands":Ljava/util/ArrayList;, "Ljava/util/ArrayList<Ljava/lang/String;>;"
    new-instance v3, Ljava/util/ArrayList;

    invoke-direct {v3}, Ljava/util/ArrayList;-><init>()V

    .line 98
    .local v3, "output":Ljava/util/ArrayList;, "Ljava/util/ArrayList<Ljava/lang/String;>;"
    const/4 v4, 0x0

    .line 100
    .local v4, "process":Ljava/lang/Process;
    :try_start_0
    invoke-static {}, Ljava/lang/Runtime;->getRuntime()Ljava/lang/Runtime;

    move-result-object v7

    invoke-virtual {v7, p0}, Ljava/lang/Runtime;->exec(Ljava/lang/String;)Ljava/lang/Process;

    move-result-object v4

    .line 102
    new-instance v5, Ljava/io/BufferedOutputStream;

    .line 103
    invoke-virtual {v4}, Ljava/lang/Process;->getOutputStream()Ljava/io/OutputStream;

    move-result-object v7

    invoke-direct {v5, v7}, Ljava/io/BufferedOutputStream;-><init>(Ljava/io/OutputStream;)V

    .line 104
    .local v5, "shellInput":Ljava/io/BufferedOutputStream;
    new-instance v6, Ljava/io/BufferedReader;

    new-instance v7, Ljava/io/InputStreamReader;

    .line 105
    invoke-virtual {v4}, Ljava/lang/Process;->getInputStream()Ljava/io/InputStream;

    move-result-object v8

    invoke-direct {v7, v8}, Ljava/io/InputStreamReader;-><init>(Ljava/io/InputStream;)V

    invoke-direct {v6, v7}, Ljava/io/BufferedReader;-><init>(Ljava/io/Reader;)V

    .line 107
    .local v6, "shellOutput":Ljava/io/BufferedReader;
    invoke-virtual {p1}, Ljava/util/ArrayList;->iterator()Ljava/util/Iterator;

    move-result-object v7

    :goto_0
    invoke-interface {v7}, Ljava/util/Iterator;->hasNext()Z

    move-result v8

    if-eqz v8, :cond_0

    invoke-interface {v7}, Ljava/util/Iterator;->next()Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Ljava/lang/String;

    .line 108
    .local v0, "command":Ljava/lang/String;
    const-string v8, "ROOT_UTIL"

    new-instance v9, Ljava/lang/StringBuilder;

    invoke-direct {v9}, Ljava/lang/StringBuilder;-><init>()V

    const-string v10, "command: "

    invoke-virtual {v9, v10}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v9

    invoke-virtual {v9, v0}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v9

    invoke-virtual {v9}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v9

    invoke-static {v8, v9}, Lcom/cyjh/mobileanjian/ipc/utils/CLog;->i(Ljava/lang/String;Ljava/lang/String;)V

    .line 109
    new-instance v8, Ljava/lang/StringBuilder;

    invoke-direct {v8}, Ljava/lang/StringBuilder;-><init>()V

    invoke-virtual {v8, v0}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v8

    const-string v9, " 2>&1\n"

    invoke-virtual {v8, v9}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v8

    invoke-virtual {v8}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v8

    invoke-virtual {v8}, Ljava/lang/String;->getBytes()[B

    move-result-object v8

    invoke-virtual {v5, v8}, Ljava/io/BufferedOutputStream;->write([B)V
    :try_end_0
    .catch Ljava/io/IOException; {:try_start_0 .. :try_end_0} :catch_0
    .catch Ljava/lang/InterruptedException; {:try_start_0 .. :try_end_0} :catch_1
    .catchall {:try_start_0 .. :try_end_0} :catchall_0

    goto :goto_0

    .line 122
    .end local v0    # "command":Ljava/lang/String;
    .end local v5    # "shellInput":Ljava/io/BufferedOutputStream;
    .end local v6    # "shellOutput":Ljava/io/BufferedReader;
    :catch_0
    move-exception v1

    .line 123
    .local v1, "e":Ljava/io/IOException;
    :try_start_1
    invoke-virtual {v1}, Ljava/io/IOException;->printStackTrace()V
    :try_end_1
    .catchall {:try_start_1 .. :try_end_1} :catchall_0

    .line 127
    invoke-virtual {v4}, Ljava/lang/Process;->destroy()V

    .line 130
    .end local v1    # "e":Ljava/io/IOException;
    :goto_1
    return-object v3

    .line 112
    .restart local v5    # "shellInput":Ljava/io/BufferedOutputStream;
    .restart local v6    # "shellOutput":Ljava/io/BufferedReader;
    :cond_0
    :try_start_2
    const-string v7, "exit\n"

    invoke-virtual {v7}, Ljava/lang/String;->getBytes()[B

    move-result-object v7

    invoke-virtual {v5, v7}, Ljava/io/BufferedOutputStream;->write([B)V

    .line 113
    invoke-virtual {v5}, Ljava/io/BufferedOutputStream;->flush()V

    .line 116
    :goto_2
    invoke-virtual {v6}, Ljava/io/BufferedReader;->readLine()Ljava/lang/String;

    move-result-object v2

    .local v2, "line":Ljava/lang/String;
    if-eqz v2, :cond_1

    .line 117
    const-string v7, "ROOT_UTIL"

    new-instance v8, Ljava/lang/StringBuilder;

    invoke-direct {v8}, Ljava/lang/StringBuilder;-><init>()V

    const-string v9, "result: "

    invoke-virtual {v8, v9}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v8

    invoke-virtual {v8, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v8

    invoke-virtual {v8}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v8

    invoke-static {v7, v8}, Lcom/cyjh/mobileanjian/ipc/utils/CLog;->i(Ljava/lang/String;Ljava/lang/String;)V

    .line 118
    invoke-virtual {v3, v2}, Ljava/util/ArrayList;->add(Ljava/lang/Object;)Z
    :try_end_2
    .catch Ljava/io/IOException; {:try_start_2 .. :try_end_2} :catch_0
    .catch Ljava/lang/InterruptedException; {:try_start_2 .. :try_end_2} :catch_1
    .catchall {:try_start_2 .. :try_end_2} :catchall_0

    goto :goto_2

    .line 124
    .end local v2    # "line":Ljava/lang/String;
    .end local v5    # "shellInput":Ljava/io/BufferedOutputStream;
    .end local v6    # "shellOutput":Ljava/io/BufferedReader;
    :catch_1
    move-exception v1

    .line 125
    .local v1, "e":Ljava/lang/InterruptedException;
    :try_start_3
    invoke-virtual {v1}, Ljava/lang/InterruptedException;->printStackTrace()V
    :try_end_3
    .catchall {:try_start_3 .. :try_end_3} :catchall_0

    .line 127
    invoke-virtual {v4}, Ljava/lang/Process;->destroy()V

    goto :goto_1

    .line 121
    .end local v1    # "e":Ljava/lang/InterruptedException;
    .restart local v2    # "line":Ljava/lang/String;
    .restart local v5    # "shellInput":Ljava/io/BufferedOutputStream;
    .restart local v6    # "shellOutput":Ljava/io/BufferedReader;
    :cond_1
    :try_start_4
    invoke-virtual {v4}, Ljava/lang/Process;->waitFor()I
    :try_end_4
    .catch Ljava/io/IOException; {:try_start_4 .. :try_end_4} :catch_0
    .catch Ljava/lang/InterruptedException; {:try_start_4 .. :try_end_4} :catch_1
    .catchall {:try_start_4 .. :try_end_4} :catchall_0

    .line 127
    invoke-virtual {v4}, Ljava/lang/Process;->destroy()V

    goto :goto_1

    .end local v2    # "line":Ljava/lang/String;
    .end local v5    # "shellInput":Ljava/io/BufferedOutputStream;
    .end local v6    # "shellOutput":Ljava/io/BufferedReader;
    :catchall_0
    move-exception v7

    invoke-virtual {v4}, Ljava/lang/Process;->destroy()V

    throw v7
.end method
