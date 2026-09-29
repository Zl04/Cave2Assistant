.class public Lcom/cyjh/mobileanjian/ipc/rpc/Invocator;
.super Ljava/lang/Object;
.source "SourceFile"


# static fields
.field public static final TAG:Ljava/lang/String;


# direct methods
.method static constructor <clinit>()V
    .locals 1

    .prologue
    .line 29
    const-class v0, Lcom/cyjh/mobileanjian/ipc/rpc/Invocator;

    invoke-virtual {v0}, Ljava/lang/Class;->getSimpleName()Ljava/lang/String;

    move-result-object v0

    sput-object v0, Lcom/cyjh/mobileanjian/ipc/rpc/Invocator;->TAG:Ljava/lang/String;

    return-void
.end method

.method public constructor <init>()V
    .locals 0

    .prologue
    .line 27
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method

.method public static invoke(Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;Ljava/util/List;Ljava/util/List;)I
    .locals 7
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "(",
            "Ljava/lang/String;",
            "Ljava/lang/String;",
            "Ljava/lang/String;",
            "Ljava/util/List",
            "<",
            "Ljava/lang/String;",
            ">;",
            "Ljava/util/List",
            "<",
            "Ljava/lang/String;",
            ">;)I"
        }
    .end annotation

    .prologue
    const/4 v1, 0x0

    .line 38
    sget-object v0, Lcom/cyjh/mobileanjian/ipc/rpc/Invocator;->TAG:Ljava/lang/String;

    new-instance v2, Ljava/lang/StringBuilder;

    invoke-direct {v2}, Ljava/lang/StringBuilder;-><init>()V

    const-string v3, "want method: "

    invoke-virtual {v2, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    invoke-virtual {v2, p0}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    const-string v3, "."

    invoke-virtual {v2, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    invoke-virtual {v2, p1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    const-string v3, "."

    invoke-virtual {v2, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    invoke-virtual {v2, p2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    invoke-virtual {v2}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v2

    invoke-static {v0, v2}, Lcom/cyjh/mobileanjian/ipc/utils/CLog;->d(Ljava/lang/String;Ljava/lang/String;)V

    .line 39
    sget-object v0, Lcom/cyjh/mobileanjian/ipc/rpc/Invocator;->TAG:Ljava/lang/String;

    new-instance v2, Ljava/lang/StringBuilder;

    invoke-direct {v2}, Ljava/lang/StringBuilder;-><init>()V

    const-string v3, "types: "

    invoke-virtual {v2, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    invoke-virtual {v2, p3}, Ljava/lang/StringBuilder;->append(Ljava/lang/Object;)Ljava/lang/StringBuilder;

    move-result-object v2

    invoke-virtual {v2}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v2

    invoke-static {v0, v2}, Lcom/cyjh/mobileanjian/ipc/utils/CLog;->d(Ljava/lang/String;Ljava/lang/String;)V

    .line 40
    sget-object v0, Lcom/cyjh/mobileanjian/ipc/rpc/Invocator;->TAG:Ljava/lang/String;

    new-instance v2, Ljava/lang/StringBuilder;

    invoke-direct {v2}, Ljava/lang/StringBuilder;-><init>()V

    const-string v3, "value: "

    invoke-virtual {v2, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    invoke-virtual {v2, p4}, Ljava/lang/StringBuilder;->append(Ljava/lang/Object;)Ljava/lang/StringBuilder;

    move-result-object v2

    invoke-virtual {v2}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v2

    invoke-static {v0, v2}, Lcom/cyjh/mobileanjian/ipc/utils/CLog;->d(Ljava/lang/String;Ljava/lang/String;)V

    .line 43
    if-nez p3, :cond_0

    if-nez p4, :cond_2

    :cond_0
    if-eqz p3, :cond_1

    if-eqz p4, :cond_2

    :cond_1
    if-eqz p3, :cond_3

    if-eqz p4, :cond_3

    .line 45
    invoke-interface {p3}, Ljava/util/List;->size()I

    move-result v0

    invoke-interface {p4}, Ljava/util/List;->size()I

    move-result v2

    if-eq v0, v2, :cond_3

    .line 48
    :cond_2
    const/4 v0, 0x6

    .line 104
    :goto_0
    return v0

    .line 52
    :cond_3
    sget-object v0, Lcom/cyjh/mobileanjian/ipc/rpc/Invocator;->TAG:Ljava/lang/String;

    const-string v2, ">>>>>>>>>>>>>>>>>>start invoke.."

    invoke-static {v0, v2}, Lcom/cyjh/mobileanjian/ipc/utils/CLog;->d(Ljava/lang/String;Ljava/lang/String;)V

    .line 58
    const/4 v0, 0x0

    .line 59
    if-eqz p3, :cond_5

    :try_start_0
    invoke-interface {p3}, Ljava/util/List;->size()I

    move-result v2

    if-lez v2, :cond_5

    .line 61
    invoke-interface {p3}, Ljava/util/List;->size()I

    move-result v0

    new-array v2, v0, [Ljava/lang/Class;

    move v3, v1

    .line 62
    :goto_1
    array-length v0, v2

    if-ge v3, v0, :cond_4

    .line 63
    sget-object v4, Lcom/cyjh/mobileanjian/ipc/utils/j;->j:Lcom/cyjh/mobileanjian/ipc/utils/g;

    invoke-interface {p3, v3}, Ljava/util/List;->get(I)Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Ljava/lang/String;

    invoke-virtual {v4, v0}, Lcom/cyjh/mobileanjian/ipc/utils/g;->a(Ljava/lang/String;)Ljava/lang/Class;

    move-result-object v0

    aput-object v0, v2, v3

    .line 62
    add-int/lit8 v0, v3, 0x1

    move v3, v0

    goto :goto_1

    :cond_4
    move-object v0, v2

    .line 66
    :cond_5
    new-instance v2, Ljava/lang/StringBuilder;

    invoke-direct {v2}, Ljava/lang/StringBuilder;-><init>()V

    invoke-virtual {v2, p0}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    const-string v3, "."

    invoke-virtual {v2, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    invoke-virtual {v2, p1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    invoke-virtual {v2}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v2

    invoke-static {v2}, Ljava/lang/Class;->forName(Ljava/lang/String;)Ljava/lang/Class;

    move-result-object v2

    .line 67
    invoke-virtual {v2, p2, v0}, Ljava/lang/Class;->getDeclaredMethod(Ljava/lang/String;[Ljava/lang/Class;)Ljava/lang/reflect/Method;

    move-result-object v3

    .line 69
    sget-object v4, Lcom/cyjh/mobileanjian/ipc/rpc/Invocator;->TAG:Ljava/lang/String;

    new-instance v5, Ljava/lang/StringBuilder;

    invoke-direct {v5}, Ljava/lang/StringBuilder;-><init>()V

    const-string v6, "Get method: "

    invoke-virtual {v5, v6}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v5

    invoke-virtual {v5, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/Object;)Ljava/lang/StringBuilder;

    move-result-object v5

    invoke-virtual {v5}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v5

    invoke-static {v4, v5}, Lcom/cyjh/mobileanjian/ipc/utils/CLog;->d(Ljava/lang/String;Ljava/lang/String;)V

    .line 71
    invoke-static {p3, p4}, Lcom/cyjh/mobileanjian/ipc/utils/l;->a(Ljava/util/List;Ljava/util/List;)[Ljava/lang/Object;

    move-result-object v4

    .line 72
    if-eqz v0, :cond_6

    if-nez v4, :cond_6

    .line 74
    const/4 v0, 0x7

    goto :goto_0

    .line 76
    :cond_6
    invoke-virtual {v3, v2, v4}, Ljava/lang/reflect/Method;->invoke(Ljava/lang/Object;[Ljava/lang/Object;)Ljava/lang/Object;
    :try_end_0
    .catch Ljava/lang/ClassNotFoundException; {:try_start_0 .. :try_end_0} :catch_0
    .catch Ljava/lang/NoSuchMethodException; {:try_start_0 .. :try_end_0} :catch_1
    .catch Ljava/lang/IllegalAccessException; {:try_start_0 .. :try_end_0} :catch_2
    .catch Ljava/lang/IllegalArgumentException; {:try_start_0 .. :try_end_0} :catch_3
    .catch Ljava/lang/reflect/InvocationTargetException; {:try_start_0 .. :try_end_0} :catch_4

    move v0, v1

    .line 102
    goto :goto_0

    .line 78
    :catch_0
    move-exception v0

    .line 80
    const/4 v0, 0x1

    .line 102
    goto :goto_0

    .line 82
    :catch_1
    move-exception v0

    .line 84
    sget-object v0, Lcom/cyjh/mobileanjian/ipc/rpc/Invocator;->TAG:Ljava/lang/String;

    const-string v1, "\u6ca1\u6709\u627e\u5230\u5bf9\u5e94\u7684\u65b9\u6cd5"

    invoke-static {v0, v1}, Lcom/cyjh/mobileanjian/ipc/utils/CLog;->d(Ljava/lang/String;Ljava/lang/String;)V

    .line 85
    const/4 v0, 0x2

    .line 102
    goto :goto_0

    .line 87
    :catch_2
    move-exception v0

    .line 89
    invoke-virtual {v0}, Ljava/lang/IllegalAccessException;->printStackTrace()V

    .line 90
    const/4 v0, 0x3

    .line 102
    goto/16 :goto_0

    .line 92
    :catch_3
    move-exception v0

    .line 94
    invoke-virtual {v0}, Ljava/lang/IllegalArgumentException;->printStackTrace()V

    .line 95
    const/4 v0, 0x4

    .line 102
    goto/16 :goto_0

    .line 97
    :catch_4
    move-exception v0

    .line 100
    invoke-virtual {v0}, Ljava/lang/reflect/InvocationTargetException;->printStackTrace()V

    .line 101
    const/4 v0, 0x5

    goto/16 :goto_0
.end method

.method public static invoke(Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;Ljava/util/List;Ljava/util/List;I)Ljava/lang/Object;
    .locals 7
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "(",
            "Ljava/lang/String;",
            "Ljava/lang/String;",
            "Ljava/lang/String;",
            "Ljava/util/List",
            "<",
            "Ljava/lang/String;",
            ">;",
            "Ljava/util/List",
            "<",
            "Ljava/lang/String;",
            ">;I)",
            "Ljava/lang/Object;"
        }
    .end annotation

    .prologue
    const/4 v1, 0x0

    .line 109
    sget-object v0, Lcom/cyjh/mobileanjian/ipc/rpc/Invocator;->TAG:Ljava/lang/String;

    new-instance v2, Ljava/lang/StringBuilder;

    invoke-direct {v2}, Ljava/lang/StringBuilder;-><init>()V

    const-string v3, "want method: "

    invoke-virtual {v2, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    invoke-virtual {v2, p0}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    const-string v3, "."

    invoke-virtual {v2, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    invoke-virtual {v2, p1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    const-string v3, "."

    invoke-virtual {v2, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    invoke-virtual {v2, p2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    invoke-virtual {v2}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v2

    invoke-static {v0, v2}, Lcom/cyjh/mobileanjian/ipc/utils/CLog;->d(Ljava/lang/String;Ljava/lang/String;)V

    .line 110
    sget-object v0, Lcom/cyjh/mobileanjian/ipc/rpc/Invocator;->TAG:Ljava/lang/String;

    new-instance v2, Ljava/lang/StringBuilder;

    invoke-direct {v2}, Ljava/lang/StringBuilder;-><init>()V

    const-string v3, "types: "

    invoke-virtual {v2, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    invoke-virtual {v2, p3}, Ljava/lang/StringBuilder;->append(Ljava/lang/Object;)Ljava/lang/StringBuilder;

    move-result-object v2

    invoke-virtual {v2}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v2

    invoke-static {v0, v2}, Lcom/cyjh/mobileanjian/ipc/utils/CLog;->d(Ljava/lang/String;Ljava/lang/String;)V

    .line 111
    sget-object v0, Lcom/cyjh/mobileanjian/ipc/rpc/Invocator;->TAG:Ljava/lang/String;

    new-instance v2, Ljava/lang/StringBuilder;

    invoke-direct {v2}, Ljava/lang/StringBuilder;-><init>()V

    const-string v3, "value: "

    invoke-virtual {v2, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    invoke-virtual {v2, p4}, Ljava/lang/StringBuilder;->append(Ljava/lang/Object;)Ljava/lang/StringBuilder;

    move-result-object v2

    invoke-virtual {v2}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v2

    invoke-static {v0, v2}, Lcom/cyjh/mobileanjian/ipc/utils/CLog;->d(Ljava/lang/String;Ljava/lang/String;)V

    .line 114
    if-nez p3, :cond_0

    if-nez p4, :cond_2

    :cond_0
    if-eqz p3, :cond_1

    if-eqz p4, :cond_2

    :cond_1
    if-eqz p3, :cond_3

    if-eqz p4, :cond_3

    .line 116
    invoke-interface {p3}, Ljava/util/List;->size()I

    move-result v0

    invoke-interface {p4}, Ljava/util/List;->size()I

    move-result v2

    if-eq v0, v2, :cond_3

    :cond_2
    move-object v0, v1

    .line 180
    :goto_0
    return-object v0

    .line 124
    :cond_3
    sget-object v0, Lcom/cyjh/mobileanjian/ipc/rpc/Invocator;->TAG:Ljava/lang/String;

    const-string v2, ">>>>>>>>>>>>>>>>>>start invoke.."

    invoke-static {v0, v2}, Lcom/cyjh/mobileanjian/ipc/utils/CLog;->d(Ljava/lang/String;Ljava/lang/String;)V

    .line 131
    if-eqz p3, :cond_6

    :try_start_0
    invoke-interface {p3}, Ljava/util/List;->size()I

    move-result v0

    if-lez v0, :cond_6

    .line 133
    invoke-interface {p3}, Ljava/util/List;->size()I

    move-result v0

    new-array v2, v0, [Ljava/lang/Class;

    .line 134
    const/4 v0, 0x0

    move v3, v0

    :goto_1
    array-length v0, v2

    if-ge v3, v0, :cond_4

    .line 135
    sget-object v4, Lcom/cyjh/mobileanjian/ipc/utils/j;->j:Lcom/cyjh/mobileanjian/ipc/utils/g;

    invoke-interface {p3, v3}, Ljava/util/List;->get(I)Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Ljava/lang/String;

    invoke-virtual {v4, v0}, Lcom/cyjh/mobileanjian/ipc/utils/g;->a(Ljava/lang/String;)Ljava/lang/Class;

    move-result-object v0

    aput-object v0, v2, v3

    .line 134
    add-int/lit8 v0, v3, 0x1

    move v3, v0

    goto :goto_1

    :cond_4
    move-object v0, v2

    .line 138
    :goto_2
    new-instance v2, Ljava/lang/StringBuilder;

    invoke-direct {v2}, Ljava/lang/StringBuilder;-><init>()V

    invoke-virtual {v2, p0}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    const-string v3, "."

    invoke-virtual {v2, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    invoke-virtual {v2, p1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    invoke-virtual {v2}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v2

    invoke-static {v2}, Ljava/lang/Class;->forName(Ljava/lang/String;)Ljava/lang/Class;

    move-result-object v2

    .line 139
    invoke-virtual {v2, p2, v0}, Ljava/lang/Class;->getDeclaredMethod(Ljava/lang/String;[Ljava/lang/Class;)Ljava/lang/reflect/Method;

    move-result-object v3

    .line 141
    sget-object v4, Lcom/cyjh/mobileanjian/ipc/rpc/Invocator;->TAG:Ljava/lang/String;

    new-instance v5, Ljava/lang/StringBuilder;

    invoke-direct {v5}, Ljava/lang/StringBuilder;-><init>()V

    const-string v6, "Get method: "

    invoke-virtual {v5, v6}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v5

    invoke-virtual {v5, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/Object;)Ljava/lang/StringBuilder;

    move-result-object v5

    invoke-virtual {v5}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v5

    invoke-static {v4, v5}, Lcom/cyjh/mobileanjian/ipc/utils/CLog;->d(Ljava/lang/String;Ljava/lang/String;)V

    .line 143
    invoke-static {p3, p4}, Lcom/cyjh/mobileanjian/ipc/utils/l;->a(Ljava/util/List;Ljava/util/List;)[Ljava/lang/Object;

    move-result-object v4

    .line 144
    if-eqz v0, :cond_5

    if-nez v4, :cond_5

    move-object v0, v1

    .line 147
    goto :goto_0

    .line 150
    :cond_5
    invoke-virtual {v3, v2, v4}, Ljava/lang/reflect/Method;->invoke(Ljava/lang/Object;[Ljava/lang/Object;)Ljava/lang/Object;

    move-result-object v0

    .line 151
    sget-object v2, Lcom/cyjh/mobileanjian/ipc/rpc/Invocator;->TAG:Ljava/lang/String;

    new-instance v3, Ljava/lang/StringBuilder;

    invoke-direct {v3}, Ljava/lang/StringBuilder;-><init>()V

    const-string v4, "result: "

    invoke-virtual {v3, v4}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v3

    invoke-virtual {v3, v0}, Ljava/lang/StringBuilder;->append(Ljava/lang/Object;)Ljava/lang/StringBuilder;

    move-result-object v3

    invoke-virtual {v3}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v3

    invoke-static {v2, v3}, Lcom/cyjh/mobileanjian/ipc/utils/CLog;->d(Ljava/lang/String;Ljava/lang/String;)V
    :try_end_0
    .catch Ljava/lang/ClassNotFoundException; {:try_start_0 .. :try_end_0} :catch_0
    .catch Ljava/lang/NoSuchMethodException; {:try_start_0 .. :try_end_0} :catch_1
    .catch Ljava/lang/IllegalAccessException; {:try_start_0 .. :try_end_0} :catch_2
    .catch Ljava/lang/IllegalArgumentException; {:try_start_0 .. :try_end_0} :catch_3
    .catch Ljava/lang/reflect/InvocationTargetException; {:try_start_0 .. :try_end_0} :catch_4

    goto/16 :goto_0

    .line 154
    :catch_0
    move-exception v0

    :goto_3
    move-object v0, v1

    .line 180
    goto/16 :goto_0

    .line 158
    :catch_1
    move-exception v0

    .line 160
    sget-object v0, Lcom/cyjh/mobileanjian/ipc/rpc/Invocator;->TAG:Ljava/lang/String;

    const-string v2, "\u6ca1\u6709\u627e\u5230\u5bf9\u5e94\u7684\u65b9\u6cd5"

    invoke-static {v0, v2}, Lcom/cyjh/mobileanjian/ipc/utils/CLog;->d(Ljava/lang/String;Ljava/lang/String;)V

    goto :goto_3

    .line 163
    :catch_2
    move-exception v0

    .line 165
    invoke-virtual {v0}, Ljava/lang/IllegalAccessException;->printStackTrace()V

    goto :goto_3

    .line 168
    :catch_3
    move-exception v0

    .line 170
    invoke-virtual {v0}, Ljava/lang/IllegalArgumentException;->printStackTrace()V

    goto :goto_3

    .line 173
    :catch_4
    move-exception v0

    .line 176
    invoke-virtual {v0}, Ljava/lang/reflect/InvocationTargetException;->printStackTrace()V

    goto :goto_3

    :cond_6
    move-object v0, v1

    goto :goto_2
.end method

.method public static isListEmpty(Ljava/util/List;)Z
    .locals 1

    .prologue
    .line 33
    if-eqz p0, :cond_0

    invoke-interface {p0}, Ljava/util/List;->size()I

    move-result v0

    if-nez v0, :cond_1

    :cond_0
    const/4 v0, 0x1

    :goto_0
    return v0

    :cond_1
    const/4 v0, 0x0

    goto :goto_0
.end method
