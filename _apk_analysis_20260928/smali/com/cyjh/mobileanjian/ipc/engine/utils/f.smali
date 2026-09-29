.class public Lcom/cyjh/mobileanjian/ipc/engine/utils/f;
.super Ljava/lang/Object;
.source "SourceFile"


# annotations
.annotation system Ldalvik/annotation/MemberClasses;
    value = {
        Lcom/cyjh/mobileanjian/ipc/engine/utils/f$b;,
        Lcom/cyjh/mobileanjian/ipc/engine/utils/f$a;
    }
.end annotation


# static fields
.field public static final a:Ljava/lang/String; = "su"

.field public static final b:Ljava/lang/String; = "sh"

.field public static final c:Ljava/lang/String; = "exit\n"

.field public static final d:Ljava/lang/String; = "\n"

.field private static e:Z


# direct methods
.method static constructor <clinit>()V
    .locals 1

    .prologue
    .line 237
    const/4 v0, 0x0

    sput-boolean v0, Lcom/cyjh/mobileanjian/ipc/engine/utils/f;->e:Z

    return-void
.end method

.method private constructor <init>()V
    .locals 1

    .prologue
    .line 36
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    .line 37
    new-instance v0, Ljava/lang/AssertionError;

    invoke-direct {v0}, Ljava/lang/AssertionError;-><init>()V

    throw v0
.end method

.method public static a(Ljava/lang/String;ZI)Lcom/cyjh/mobileanjian/ipc/engine/utils/f$a;
    .locals 3

    .prologue
    const/4 v2, 0x1

    .line 58
    new-array v0, v2, [Ljava/lang/String;

    const/4 v1, 0x0

    aput-object p0, v0, v1

    invoke-static {v0, p1, v2, p2}, Lcom/cyjh/mobileanjian/ipc/engine/utils/f;->a([Ljava/lang/String;ZZI)Lcom/cyjh/mobileanjian/ipc/engine/utils/f$a;

    move-result-object v0

    return-object v0
.end method

.method public static a(Ljava/lang/String;ZZI)Lcom/cyjh/mobileanjian/ipc/engine/utils/f$a;
    .locals 2

    .prologue
    .line 95
    const/4 v0, 0x1

    new-array v0, v0, [Ljava/lang/String;

    const/4 v1, 0x0

    aput-object p0, v0, v1

    invoke-static {v0, p1, p2, p3}, Lcom/cyjh/mobileanjian/ipc/engine/utils/f;->a([Ljava/lang/String;ZZI)Lcom/cyjh/mobileanjian/ipc/engine/utils/f$a;

    move-result-object v0

    return-object v0
.end method

.method public static a(Ljava/util/List;ZI)Lcom/cyjh/mobileanjian/ipc/engine/utils/f$a;
    .locals 2
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "(",
            "Ljava/util/List",
            "<",
            "Ljava/lang/String;",
            ">;ZI)",
            "Lcom/cyjh/mobileanjian/ipc/engine/utils/f$a;"
        }
    .end annotation

    .prologue
    .line 70
    if-nez p0, :cond_0

    const/4 v0, 0x0

    :goto_0
    const/4 v1, 0x1

    invoke-static {v0, p1, v1, p2}, Lcom/cyjh/mobileanjian/ipc/engine/utils/f;->a([Ljava/lang/String;ZZI)Lcom/cyjh/mobileanjian/ipc/engine/utils/f$a;

    move-result-object v0

    return-object v0

    :cond_0
    const/4 v0, 0x0

    new-array v0, v0, [Ljava/lang/String;

    invoke-interface {p0, v0}, Ljava/util/List;->toArray([Ljava/lang/Object;)[Ljava/lang/Object;

    move-result-object v0

    check-cast v0, [Ljava/lang/String;

    goto :goto_0
.end method

.method public static a(Ljava/util/List;ZZI)Lcom/cyjh/mobileanjian/ipc/engine/utils/f$a;
    .locals 1
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "(",
            "Ljava/util/List",
            "<",
            "Ljava/lang/String;",
            ">;ZZI)",
            "Lcom/cyjh/mobileanjian/ipc/engine/utils/f$a;"
        }
    .end annotation

    .prologue
    .line 108
    if-nez p0, :cond_0

    const/4 v0, 0x0

    :goto_0
    invoke-static {v0, p1, p2, p3}, Lcom/cyjh/mobileanjian/ipc/engine/utils/f;->a([Ljava/lang/String;ZZI)Lcom/cyjh/mobileanjian/ipc/engine/utils/f$a;

    move-result-object v0

    return-object v0

    :cond_0
    const/4 v0, 0x0

    new-array v0, v0, [Ljava/lang/String;

    invoke-interface {p0, v0}, Ljava/util/List;->toArray([Ljava/lang/Object;)[Ljava/lang/Object;

    move-result-object v0

    check-cast v0, [Ljava/lang/String;

    goto :goto_0
.end method

.method public static a([Ljava/lang/String;ZI)Lcom/cyjh/mobileanjian/ipc/engine/utils/f$a;
    .locals 1

    .prologue
    .line 82
    const/4 v0, 0x1

    invoke-static {p0, p1, v0, p2}, Lcom/cyjh/mobileanjian/ipc/engine/utils/f;->a([Ljava/lang/String;ZZI)Lcom/cyjh/mobileanjian/ipc/engine/utils/f$a;

    move-result-object v0

    return-object v0
.end method

.method public static a([Ljava/lang/String;ZZI)Lcom/cyjh/mobileanjian/ipc/engine/utils/f$a;
    .locals 11

    .prologue
    const/4 v0, 0x0

    const/4 v3, 0x0

    .line 124
    const/4 v2, -0x1

    .line 125
    if-eqz p0, :cond_0

    array-length v1, p0

    if-nez v1, :cond_1

    .line 126
    :cond_0
    new-instance v0, Lcom/cyjh/mobileanjian/ipc/engine/utils/f$a;

    invoke-direct {v0, v2, v3, v3}, Lcom/cyjh/mobileanjian/ipc/engine/utils/f$a;-><init>(ILjava/lang/String;Ljava/lang/String;)V

    .line 201
    :goto_0
    return-object v0

    .line 137
    :cond_1
    sput-boolean v0, Lcom/cyjh/mobileanjian/ipc/engine/utils/f;->e:Z

    .line 139
    :try_start_0
    invoke-static {}, Ljava/lang/Runtime;->getRuntime()Ljava/lang/Runtime;

    move-result-object v4

    if-eqz p1, :cond_2

    const-string v1, "su"

    :goto_1
    invoke-virtual {v4, v1}, Ljava/lang/Runtime;->exec(Ljava/lang/String;)Ljava/lang/Process;
    :try_end_0
    .catch Ljava/io/IOException; {:try_start_0 .. :try_end_0} :catch_15
    .catch Ljava/lang/Exception; {:try_start_0 .. :try_end_0} :catch_f
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_6
    .catchall {:try_start_0 .. :try_end_0} :catchall_0

    move-result-object v8

    .line 140
    :try_start_1
    new-instance v4, Ljava/io/DataOutputStream;

    invoke-virtual {v8}, Ljava/lang/Process;->getOutputStream()Ljava/io/OutputStream;

    move-result-object v1

    invoke-direct {v4, v1}, Ljava/io/DataOutputStream;-><init>(Ljava/io/OutputStream;)V
    :try_end_1
    .catch Ljava/io/IOException; {:try_start_1 .. :try_end_1} :catch_16
    .catch Ljava/lang/Exception; {:try_start_1 .. :try_end_1} :catch_10
    .catch Ljava/lang/Throwable; {:try_start_1 .. :try_end_1} :catch_9
    .catchall {:try_start_1 .. :try_end_1} :catchall_1

    .line 141
    :try_start_2
    array-length v1, p0

    :goto_2
    if-ge v0, v1, :cond_8

    aget-object v5, p0, v0
    :try_end_2
    .catch Ljava/io/IOException; {:try_start_2 .. :try_end_2} :catch_0
    .catch Ljava/lang/Exception; {:try_start_2 .. :try_end_2} :catch_11
    .catch Ljava/lang/Throwable; {:try_start_2 .. :try_end_2} :catch_a
    .catchall {:try_start_2 .. :try_end_2} :catchall_2

    .line 142
    if-nez v5, :cond_3

    .line 141
    :goto_3
    add-int/lit8 v0, v0, 0x1

    goto :goto_2

    .line 139
    :cond_2
    :try_start_3
    const-string v1, "sh"
    :try_end_3
    .catch Ljava/io/IOException; {:try_start_3 .. :try_end_3} :catch_15
    .catch Ljava/lang/Exception; {:try_start_3 .. :try_end_3} :catch_f
    .catch Ljava/lang/Throwable; {:try_start_3 .. :try_end_3} :catch_6
    .catchall {:try_start_3 .. :try_end_3} :catchall_0

    goto :goto_1

    .line 147
    :cond_3
    :try_start_4
    invoke-virtual {v5}, Ljava/lang/String;->getBytes()[B

    move-result-object v5

    invoke-virtual {v4, v5}, Ljava/io/DataOutputStream;->write([B)V

    .line 148
    const-string v5, "\n"

    invoke-virtual {v4, v5}, Ljava/io/DataOutputStream;->writeBytes(Ljava/lang/String;)V

    .line 149
    invoke-virtual {v4}, Ljava/io/DataOutputStream;->flush()V
    :try_end_4
    .catch Ljava/io/IOException; {:try_start_4 .. :try_end_4} :catch_0
    .catch Ljava/lang/Exception; {:try_start_4 .. :try_end_4} :catch_11
    .catch Ljava/lang/Throwable; {:try_start_4 .. :try_end_4} :catch_a
    .catchall {:try_start_4 .. :try_end_4} :catchall_2

    goto :goto_3

    .line 174
    :catch_0
    move-exception v0

    move-object v5, v4

    move-object v1, v3

    move-object v6, v3

    move-object v7, v3

    move-object v4, v0

    move-object v0, v3

    .line 175
    :goto_4
    :try_start_5
    invoke-virtual {v4}, Ljava/io/IOException;->printStackTrace()V
    :try_end_5
    .catchall {:try_start_5 .. :try_end_5} :catchall_5

    .line 184
    if-eqz v5, :cond_4

    .line 185
    :try_start_6
    invoke-virtual {v5}, Ljava/io/DataOutputStream;->close()V

    .line 187
    :cond_4
    if-eqz v7, :cond_5

    .line 188
    invoke-virtual {v7}, Ljava/io/BufferedReader;->close()V

    .line 190
    :cond_5
    if-eqz v6, :cond_6

    .line 191
    invoke-virtual {v6}, Ljava/io/BufferedReader;->close()V
    :try_end_6
    .catch Ljava/io/IOException; {:try_start_6 .. :try_end_6} :catch_4

    .line 197
    :cond_6
    :goto_5
    if-eqz v8, :cond_7

    .line 198
    invoke-virtual {v8}, Ljava/lang/Process;->destroy()V

    .line 201
    :cond_7
    :goto_6
    new-instance v4, Lcom/cyjh/mobileanjian/ipc/engine/utils/f$a;

    if-nez v1, :cond_19

    move-object v1, v3

    :goto_7
    if-nez v0, :cond_1a

    move-object v0, v3

    .line 202
    :goto_8
    invoke-direct {v4, v2, v1, v0}, Lcom/cyjh/mobileanjian/ipc/engine/utils/f$a;-><init>(ILjava/lang/String;Ljava/lang/String;)V

    move-object v0, v4

    .line 201
    goto :goto_0

    .line 151
    :cond_8
    :try_start_7
    const-string v0, "exit\n"

    invoke-virtual {v4, v0}, Ljava/io/DataOutputStream;->writeBytes(Ljava/lang/String;)V

    .line 152
    invoke-virtual {v4}, Ljava/io/DataOutputStream;->flush()V

    .line 153
    if-lez p3, :cond_9

    .line 155
    new-instance v0, Lcom/cyjh/mobileanjian/ipc/engine/utils/f$b;

    invoke-direct {v0, v8, p3}, Lcom/cyjh/mobileanjian/ipc/engine/utils/f$b;-><init>(Ljava/lang/Process;I)V

    invoke-virtual {v0}, Lcom/cyjh/mobileanjian/ipc/engine/utils/f$b;->start()V

    .line 157
    :cond_9
    invoke-virtual {v8}, Ljava/lang/Process;->waitFor()I

    move-result v2

    .line 158
    const-string v0, "SYS"

    const-string v1, "command finished."

    invoke-static {v0, v1}, Landroid/util/Log;->i(Ljava/lang/String;Ljava/lang/String;)I

    .line 159
    const/4 v0, 0x1

    sput-boolean v0, Lcom/cyjh/mobileanjian/ipc/engine/utils/f;->e:Z

    .line 161
    if-eqz p2, :cond_1b

    .line 162
    new-instance v5, Ljava/lang/StringBuilder;

    invoke-direct {v5}, Ljava/lang/StringBuilder;-><init>()V
    :try_end_7
    .catch Ljava/io/IOException; {:try_start_7 .. :try_end_7} :catch_0
    .catch Ljava/lang/Exception; {:try_start_7 .. :try_end_7} :catch_11
    .catch Ljava/lang/Throwable; {:try_start_7 .. :try_end_7} :catch_a
    .catchall {:try_start_7 .. :try_end_7} :catchall_2

    .line 163
    :try_start_8
    new-instance v1, Ljava/lang/StringBuilder;

    invoke-direct {v1}, Ljava/lang/StringBuilder;-><init>()V
    :try_end_8
    .catch Ljava/io/IOException; {:try_start_8 .. :try_end_8} :catch_17
    .catch Ljava/lang/Exception; {:try_start_8 .. :try_end_8} :catch_12
    .catch Ljava/lang/Throwable; {:try_start_8 .. :try_end_8} :catch_b
    .catchall {:try_start_8 .. :try_end_8} :catchall_2

    .line 164
    :try_start_9
    new-instance v7, Ljava/io/BufferedReader;

    new-instance v0, Ljava/io/InputStreamReader;

    invoke-virtual {v8}, Ljava/lang/Process;->getInputStream()Ljava/io/InputStream;

    move-result-object v6

    invoke-direct {v0, v6}, Ljava/io/InputStreamReader;-><init>(Ljava/io/InputStream;)V

    invoke-direct {v7, v0}, Ljava/io/BufferedReader;-><init>(Ljava/io/Reader;)V
    :try_end_9
    .catch Ljava/io/IOException; {:try_start_9 .. :try_end_9} :catch_18
    .catch Ljava/lang/Exception; {:try_start_9 .. :try_end_9} :catch_13
    .catch Ljava/lang/Throwable; {:try_start_9 .. :try_end_9} :catch_c
    .catchall {:try_start_9 .. :try_end_9} :catchall_2

    .line 165
    :try_start_a
    new-instance v6, Ljava/io/BufferedReader;

    new-instance v0, Ljava/io/InputStreamReader;

    invoke-virtual {v8}, Ljava/lang/Process;->getErrorStream()Ljava/io/InputStream;

    move-result-object v9

    invoke-direct {v0, v9}, Ljava/io/InputStreamReader;-><init>(Ljava/io/InputStream;)V

    invoke-direct {v6, v0}, Ljava/io/BufferedReader;-><init>(Ljava/io/Reader;)V
    :try_end_a
    .catch Ljava/io/IOException; {:try_start_a .. :try_end_a} :catch_19
    .catch Ljava/lang/Exception; {:try_start_a .. :try_end_a} :catch_14
    .catch Ljava/lang/Throwable; {:try_start_a .. :try_end_a} :catch_d
    .catchall {:try_start_a .. :try_end_a} :catchall_3

    .line 167
    :goto_9
    :try_start_b
    invoke-virtual {v7}, Ljava/io/BufferedReader;->readLine()Ljava/lang/String;

    move-result-object v0

    if-eqz v0, :cond_a

    .line 168
    invoke-virtual {v5, v0}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    goto :goto_9

    .line 174
    :catch_1
    move-exception v0

    move-object v10, v0

    move-object v0, v1

    move-object v1, v5

    move-object v5, v4

    move-object v4, v10

    goto :goto_4

    .line 170
    :cond_a
    :goto_a
    invoke-virtual {v6}, Ljava/io/BufferedReader;->readLine()Ljava/lang/String;

    move-result-object v0

    if-eqz v0, :cond_e

    .line 171
    invoke-virtual {v1, v0}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;
    :try_end_b
    .catch Ljava/io/IOException; {:try_start_b .. :try_end_b} :catch_1
    .catch Ljava/lang/Exception; {:try_start_b .. :try_end_b} :catch_2
    .catch Ljava/lang/Throwable; {:try_start_b .. :try_end_b} :catch_e
    .catchall {:try_start_b .. :try_end_b} :catchall_4

    goto :goto_a

    .line 176
    :catch_2
    move-exception v0

    move-object v10, v0

    move-object v0, v1

    move-object v1, v5

    move-object v5, v4

    move-object v4, v10

    .line 177
    :goto_b
    :try_start_c
    invoke-virtual {v4}, Ljava/lang/Exception;->printStackTrace()V
    :try_end_c
    .catchall {:try_start_c .. :try_end_c} :catchall_5

    .line 184
    if-eqz v5, :cond_b

    .line 185
    :try_start_d
    invoke-virtual {v5}, Ljava/io/DataOutputStream;->close()V

    .line 187
    :cond_b
    if-eqz v7, :cond_c

    .line 188
    invoke-virtual {v7}, Ljava/io/BufferedReader;->close()V

    .line 190
    :cond_c
    if-eqz v6, :cond_d

    .line 191
    invoke-virtual {v6}, Ljava/io/BufferedReader;->close()V
    :try_end_d
    .catch Ljava/io/IOException; {:try_start_d .. :try_end_d} :catch_5

    .line 197
    :cond_d
    :goto_c
    if-eqz v8, :cond_7

    .line 198
    invoke-virtual {v8}, Ljava/lang/Process;->destroy()V

    goto/16 :goto_6

    :cond_e
    move-object v0, v1

    move-object v1, v5

    .line 184
    :goto_d
    if-eqz v4, :cond_f

    .line 185
    :try_start_e
    invoke-virtual {v4}, Ljava/io/DataOutputStream;->close()V

    .line 187
    :cond_f
    if-eqz v7, :cond_10

    .line 188
    invoke-virtual {v7}, Ljava/io/BufferedReader;->close()V

    .line 190
    :cond_10
    if-eqz v6, :cond_11

    .line 191
    invoke-virtual {v6}, Ljava/io/BufferedReader;->close()V
    :try_end_e
    .catch Ljava/io/IOException; {:try_start_e .. :try_end_e} :catch_3

    .line 197
    :cond_11
    :goto_e
    if-eqz v8, :cond_7

    .line 198
    invoke-virtual {v8}, Ljava/lang/Process;->destroy()V

    goto/16 :goto_6

    .line 193
    :catch_3
    move-exception v4

    .line 194
    invoke-virtual {v4}, Ljava/io/IOException;->printStackTrace()V

    goto :goto_e

    .line 193
    :catch_4
    move-exception v4

    .line 194
    invoke-virtual {v4}, Ljava/io/IOException;->printStackTrace()V

    goto/16 :goto_5

    .line 193
    :catch_5
    move-exception v4

    .line 194
    invoke-virtual {v4}, Ljava/io/IOException;->printStackTrace()V

    goto :goto_c

    .line 178
    :catch_6
    move-exception v0

    move-object v4, v0

    move-object v5, v3

    move-object v1, v3

    move-object v6, v3

    move-object v7, v3

    move-object v8, v3

    move-object v0, v3

    .line 180
    :goto_f
    :try_start_f
    invoke-virtual {v4}, Ljava/lang/Throwable;->printStackTrace()V
    :try_end_f
    .catchall {:try_start_f .. :try_end_f} :catchall_5

    .line 184
    if-eqz v5, :cond_12

    .line 185
    :try_start_10
    invoke-virtual {v5}, Ljava/io/DataOutputStream;->close()V

    .line 187
    :cond_12
    if-eqz v7, :cond_13

    .line 188
    invoke-virtual {v7}, Ljava/io/BufferedReader;->close()V

    .line 190
    :cond_13
    if-eqz v6, :cond_14

    .line 191
    invoke-virtual {v6}, Ljava/io/BufferedReader;->close()V
    :try_end_10
    .catch Ljava/io/IOException; {:try_start_10 .. :try_end_10} :catch_7

    .line 197
    :cond_14
    :goto_10
    if-eqz v8, :cond_7

    .line 198
    invoke-virtual {v8}, Ljava/lang/Process;->destroy()V

    goto/16 :goto_6

    .line 193
    :catch_7
    move-exception v4

    .line 194
    invoke-virtual {v4}, Ljava/io/IOException;->printStackTrace()V

    goto :goto_10

    .line 183
    :catchall_0
    move-exception v0

    move-object v4, v3

    move-object v7, v3

    move-object v8, v3

    .line 184
    :goto_11
    if-eqz v4, :cond_15

    .line 185
    :try_start_11
    invoke-virtual {v4}, Ljava/io/DataOutputStream;->close()V

    .line 187
    :cond_15
    if-eqz v7, :cond_16

    .line 188
    invoke-virtual {v7}, Ljava/io/BufferedReader;->close()V

    .line 190
    :cond_16
    if-eqz v3, :cond_17

    .line 191
    invoke-virtual {v3}, Ljava/io/BufferedReader;->close()V
    :try_end_11
    .catch Ljava/io/IOException; {:try_start_11 .. :try_end_11} :catch_8

    .line 197
    :cond_17
    :goto_12
    if-eqz v8, :cond_18

    .line 198
    invoke-virtual {v8}, Ljava/lang/Process;->destroy()V

    :cond_18
    throw v0

    .line 193
    :catch_8
    move-exception v1

    .line 194
    invoke-virtual {v1}, Ljava/io/IOException;->printStackTrace()V

    goto :goto_12

    .line 201
    :cond_19
    invoke-virtual {v1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v1

    goto/16 :goto_7

    .line 202
    :cond_1a
    invoke-virtual {v0}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v0

    goto/16 :goto_8

    .line 183
    :catchall_1
    move-exception v0

    move-object v4, v3

    move-object v7, v3

    goto :goto_11

    :catchall_2
    move-exception v0

    move-object v7, v3

    goto :goto_11

    :catchall_3
    move-exception v0

    goto :goto_11

    :catchall_4
    move-exception v0

    move-object v3, v6

    goto :goto_11

    :catchall_5
    move-exception v0

    move-object v4, v5

    move-object v3, v6

    goto :goto_11

    .line 178
    :catch_9
    move-exception v0

    move-object v4, v0

    move-object v5, v3

    move-object v1, v3

    move-object v6, v3

    move-object v7, v3

    move-object v0, v3

    goto :goto_f

    :catch_a
    move-exception v0

    move-object v5, v4

    move-object v1, v3

    move-object v6, v3

    move-object v7, v3

    move-object v4, v0

    move-object v0, v3

    goto :goto_f

    :catch_b
    move-exception v0

    move-object v1, v5

    move-object v6, v3

    move-object v7, v3

    move-object v5, v4

    move-object v4, v0

    move-object v0, v3

    goto :goto_f

    :catch_c
    move-exception v0

    move-object v6, v3

    move-object v7, v3

    move-object v10, v1

    move-object v1, v5

    move-object v5, v4

    move-object v4, v0

    move-object v0, v10

    goto :goto_f

    :catch_d
    move-exception v0

    move-object v6, v3

    move-object v10, v4

    move-object v4, v0

    move-object v0, v1

    move-object v1, v5

    move-object v5, v10

    goto :goto_f

    :catch_e
    move-exception v0

    move-object v10, v0

    move-object v0, v1

    move-object v1, v5

    move-object v5, v4

    move-object v4, v10

    goto/16 :goto_f

    .line 176
    :catch_f
    move-exception v0

    move-object v4, v0

    move-object v5, v3

    move-object v1, v3

    move-object v6, v3

    move-object v7, v3

    move-object v8, v3

    move-object v0, v3

    goto/16 :goto_b

    :catch_10
    move-exception v0

    move-object v4, v0

    move-object v5, v3

    move-object v1, v3

    move-object v6, v3

    move-object v7, v3

    move-object v0, v3

    goto/16 :goto_b

    :catch_11
    move-exception v0

    move-object v5, v4

    move-object v1, v3

    move-object v6, v3

    move-object v7, v3

    move-object v4, v0

    move-object v0, v3

    goto/16 :goto_b

    :catch_12
    move-exception v0

    move-object v1, v5

    move-object v6, v3

    move-object v7, v3

    move-object v5, v4

    move-object v4, v0

    move-object v0, v3

    goto/16 :goto_b

    :catch_13
    move-exception v0

    move-object v6, v3

    move-object v7, v3

    move-object v10, v1

    move-object v1, v5

    move-object v5, v4

    move-object v4, v0

    move-object v0, v10

    goto/16 :goto_b

    :catch_14
    move-exception v0

    move-object v6, v3

    move-object v10, v4

    move-object v4, v0

    move-object v0, v1

    move-object v1, v5

    move-object v5, v10

    goto/16 :goto_b

    .line 174
    :catch_15
    move-exception v0

    move-object v4, v0

    move-object v5, v3

    move-object v1, v3

    move-object v6, v3

    move-object v7, v3

    move-object v8, v3

    move-object v0, v3

    goto/16 :goto_4

    :catch_16
    move-exception v0

    move-object v4, v0

    move-object v5, v3

    move-object v1, v3

    move-object v6, v3

    move-object v7, v3

    move-object v0, v3

    goto/16 :goto_4

    :catch_17
    move-exception v0

    move-object v1, v5

    move-object v6, v3

    move-object v7, v3

    move-object v5, v4

    move-object v4, v0

    move-object v0, v3

    goto/16 :goto_4

    :catch_18
    move-exception v0

    move-object v6, v3

    move-object v7, v3

    move-object v10, v1

    move-object v1, v5

    move-object v5, v4

    move-object v4, v0

    move-object v0, v10

    goto/16 :goto_4

    :catch_19
    move-exception v0

    move-object v6, v3

    move-object v10, v4

    move-object v4, v0

    move-object v0, v1

    move-object v1, v5

    move-object v5, v10

    goto/16 :goto_4

    :cond_1b
    move-object v0, v3

    move-object v1, v3

    move-object v6, v3

    move-object v7, v3

    goto/16 :goto_d
.end method

.method public static a()Z
    .locals 3

    .prologue
    const/4 v0, 0x1

    const/4 v1, 0x0

    .line 46
    const-string v2, "echo root"

    invoke-static {v2, v0, v1, v1}, Lcom/cyjh/mobileanjian/ipc/engine/utils/f;->a(Ljava/lang/String;ZZI)Lcom/cyjh/mobileanjian/ipc/engine/utils/f$a;

    move-result-object v2

    iget v2, v2, Lcom/cyjh/mobileanjian/ipc/engine/utils/f$a;->a:I

    if-nez v2, :cond_0

    :goto_0
    return v0

    :cond_0
    move v0, v1

    goto :goto_0
.end method

.method static synthetic b()Z
    .locals 1

    .prologue
    .line 29
    sget-boolean v0, Lcom/cyjh/mobileanjian/ipc/engine/utils/f;->e:Z

    return v0
.end method
