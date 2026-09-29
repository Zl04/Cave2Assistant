.class public Lcom/cyjh/elfin/util/GsonExUtil;
.super Ljava/lang/Object;
.source "GsonExUtil.java"


# static fields
.field public static final DATE_FORMAT:Ljava/lang/String; = "yyyy-MM-dd HH:mm:ss"


# direct methods
.method public constructor <init>()V
    .locals 0

    .prologue
    .line 12
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method

.method public static StringToDate(Ljava/lang/Object;)Ljava/lang/Object;
    .locals 3
    .param p0, "o"    # Ljava/lang/Object;

    .prologue
    .line 54
    :try_start_0
    new-instance v1, Lcom/google/gson/Gson;

    invoke-direct {v1}, Lcom/google/gson/Gson;-><init>()V

    .line 55
    .local v1, "gson":Lcom/google/gson/Gson;
    invoke-virtual {v1, p0}, Lcom/google/gson/Gson;->toJson(Ljava/lang/Object;)Ljava/lang/String;
    :try_end_0
    .catch Ljava/lang/Exception; {:try_start_0 .. :try_end_0} :catch_0

    move-result-object v2

    .line 60
    .end local v1    # "gson":Lcom/google/gson/Gson;
    :goto_0
    return-object v2

    .line 56
    :catch_0
    move-exception v0

    .line 57
    .local v0, "e":Ljava/lang/Exception;
    invoke-virtual {v0}, Ljava/lang/Exception;->printStackTrace()V

    .line 60
    const/4 v2, 0x0

    goto :goto_0
.end method

.method public static class2Data(Ljava/lang/Object;)Ljava/lang/String;
    .locals 3
    .param p0, "object"    # Ljava/lang/Object;

    .prologue
    .line 76
    :try_start_0
    new-instance v1, Lcom/google/gson/Gson;

    invoke-direct {v1}, Lcom/google/gson/Gson;-><init>()V

    .line 77
    .local v1, "gson":Lcom/google/gson/Gson;
    invoke-virtual {v1, p0}, Lcom/google/gson/Gson;->toJson(Ljava/lang/Object;)Ljava/lang/String;
    :try_end_0
    .catch Ljava/lang/Exception; {:try_start_0 .. :try_end_0} :catch_0

    move-result-object v2

    .line 82
    .end local v1    # "gson":Lcom/google/gson/Gson;
    :goto_0
    return-object v2

    .line 78
    :catch_0
    move-exception v0

    .line 79
    .local v0, "e":Ljava/lang/Exception;
    invoke-virtual {v0}, Ljava/lang/Exception;->printStackTrace()V

    .line 82
    const/4 v2, 0x0

    goto :goto_0
.end method

.method public static getGson()Lcom/google/gson/Gson;
    .locals 2

    .prologue
    .line 24
    new-instance v0, Lcom/google/gson/GsonBuilder;

    invoke-direct {v0}, Lcom/google/gson/GsonBuilder;-><init>()V

    invoke-virtual {v0}, Lcom/google/gson/GsonBuilder;->serializeNulls()Lcom/google/gson/GsonBuilder;

    move-result-object v0

    const-string v1, "yyyy-MM-dd HH:mm:ss"

    invoke-virtual {v0, v1}, Lcom/google/gson/GsonBuilder;->setDateFormat(Ljava/lang/String;)Lcom/google/gson/GsonBuilder;

    move-result-object v0

    invoke-virtual {v0}, Lcom/google/gson/GsonBuilder;->create()Lcom/google/gson/Gson;

    move-result-object v0

    return-object v0
.end method

.method public static json2Collection(Ljava/lang/String;Ljava/lang/Class;)Ljava/util/List;
    .locals 2
    .param p0, "jsonStr"    # Ljava/lang/String;
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "<T:",
            "Ljava/lang/Object;",
            ">(",
            "Ljava/lang/String;",
            "Ljava/lang/Class",
            "<TT;>;)",
            "Ljava/util/List",
            "<TT;>;"
        }
    .end annotation

    .prologue
    .line 36
    .local p1, "tClass":Ljava/lang/Class;, "Ljava/lang/Class<TT;>;"
    invoke-static {}, Lcom/cyjh/elfin/util/GsonExUtil;->getGson()Lcom/google/gson/Gson;

    move-result-object v0

    new-instance v1, Lcom/cyjh/elfin/util/GsonExUtil$1;

    invoke-direct {v1}, Lcom/cyjh/elfin/util/GsonExUtil$1;-><init>()V

    invoke-virtual {v1}, Lcom/cyjh/elfin/util/GsonExUtil$1;->getType()Ljava/lang/reflect/Type;

    move-result-object v1

    invoke-virtual {v0, p0, v1}, Lcom/google/gson/Gson;->fromJson(Ljava/lang/String;Ljava/lang/reflect/Type;)Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Ljava/util/List;

    return-object v0
.end method

.method public static parsData(Ljava/lang/String;Ljava/lang/Class;)Ljava/lang/Object;
    .locals 3
    .param p0, "json"    # Ljava/lang/String;
    .param p1, "clazz"    # Ljava/lang/Class;

    .prologue
    .line 42
    :try_start_0
    new-instance v1, Lcom/google/gson/Gson;

    invoke-direct {v1}, Lcom/google/gson/Gson;-><init>()V

    .line 43
    .local v1, "gson":Lcom/google/gson/Gson;
    invoke-virtual {v1, p0, p1}, Lcom/google/gson/Gson;->fromJson(Ljava/lang/String;Ljava/lang/Class;)Ljava/lang/Object;
    :try_end_0
    .catch Ljava/lang/Exception; {:try_start_0 .. :try_end_0} :catch_0

    move-result-object v2

    .line 48
    .end local v1    # "gson":Lcom/google/gson/Gson;
    :goto_0
    return-object v2

    .line 44
    :catch_0
    move-exception v0

    .line 45
    .local v0, "e":Ljava/lang/Exception;
    invoke-virtual {v0}, Ljava/lang/Exception;->printStackTrace()V

    .line 48
    const/4 v2, 0x0

    goto :goto_0
.end method

.method public static parsListData(Ljava/lang/String;Ljava/lang/Class;)Ljava/lang/Object;
    .locals 3
    .param p0, "json"    # Ljava/lang/String;
    .param p1, "clazz"    # Ljava/lang/Class;
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "<T:",
            "Ljava/lang/Object;",
            ">(",
            "Ljava/lang/String;",
            "Ljava/lang/Class;",
            ")",
            "Ljava/lang/Object;"
        }
    .end annotation

    .prologue
    .line 66
    :try_start_0
    new-instance v1, Lcom/google/gson/Gson;

    invoke-direct {v1}, Lcom/google/gson/Gson;-><init>()V

    .line 67
    .local v1, "gson":Lcom/google/gson/Gson;
    new-instance v2, Lcom/cyjh/elfin/util/GsonExUtil$2;

    invoke-direct {v2}, Lcom/cyjh/elfin/util/GsonExUtil$2;-><init>()V

    invoke-virtual {v2}, Lcom/cyjh/elfin/util/GsonExUtil$2;->getType()Ljava/lang/reflect/Type;

    move-result-object v2

    invoke-virtual {v1, p0, v2}, Lcom/google/gson/Gson;->fromJson(Ljava/lang/String;Ljava/lang/reflect/Type;)Ljava/lang/Object;
    :try_end_0
    .catch Ljava/lang/Exception; {:try_start_0 .. :try_end_0} :catch_0

    move-result-object v2

    .line 72
    .end local v1    # "gson":Lcom/google/gson/Gson;
    :goto_0
    return-object v2

    .line 68
    :catch_0
    move-exception v0

    .line 69
    .local v0, "e":Ljava/lang/Exception;
    invoke-virtual {v0}, Ljava/lang/Exception;->printStackTrace()V

    .line 72
    const/4 v2, 0x0

    goto :goto_0
.end method
