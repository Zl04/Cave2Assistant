.class public Lcom/kaopu/download/util/DownloadObjectUtil;
.super Ljava/lang/Object;
.source "DownloadObjectUtil.java"


# static fields
.field private static final FILTER_CREATOR:Ljava/lang/String; = "CREATOR"

.field private static final KEY_CLASS_NAME:Ljava/lang/String; = "class_name"


# direct methods
.method public constructor <init>()V
    .locals 0

    .prologue
    .line 9
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method

.method public static final map2DownloadInfo(Ljava/util/Map;)Lcom/kaopu/download/kernel/BaseDownloadInfo;
    .locals 3
    .param p0, "map"    # Ljava/util/Map;

    .prologue
    .line 81
    invoke-static {p0}, Lcom/kaopu/download/util/DownloadObjectUtil;->map2Object(Ljava/util/Map;)Ljava/lang/Object;

    move-result-object v1

    .line 82
    .local v1, "object":Ljava/lang/Object;
    if-eqz v1, :cond_0

    instance-of v2, v1, Lcom/kaopu/download/kernel/BaseDownloadInfo;

    if-eqz v2, :cond_0

    move-object v0, v1

    .line 83
    check-cast v0, Lcom/kaopu/download/kernel/BaseDownloadInfo;

    .line 86
    :goto_0
    return-object v0

    :cond_0
    const/4 v0, 0x0

    goto :goto_0
.end method

.method public static final map2Object(Ljava/util/Map;)Ljava/lang/Object;
    .locals 11
    .param p0, "map"    # Ljava/util/Map;

    .prologue
    .line 48
    const-string v8, "class_name"

    invoke-interface {p0, v8}, Ljava/util/Map;->get(Ljava/lang/Object;)Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Ljava/lang/String;

    .line 50
    .local v0, "className":Ljava/lang/String;
    :try_start_0
    invoke-static {v0}, Ljava/lang/Class;->forName(Ljava/lang/String;)Ljava/lang/Class;

    move-result-object v1

    .line 51
    .local v1, "clazz":Ljava/lang/Class;, "Ljava/lang/Class<+Ljava/lang/Object;>;"
    invoke-virtual {v1}, Ljava/lang/Class;->newInstance()Ljava/lang/Object;

    move-result-object v6

    .line 52
    .local v6, "object":Ljava/lang/Object;
    invoke-static {v6}, Lcom/kaopu/download/util/ReflectionUtils;->getDeclaredFields(Ljava/lang/Object;)[Ljava/lang/reflect/Field;

    move-result-object v5

    .line 53
    .local v5, "fields":[Ljava/lang/reflect/Field;
    array-length v9, v5

    const/4 v8, 0x0

    :goto_0
    if-lt v8, v9, :cond_0

    .line 70
    .end local v1    # "clazz":Ljava/lang/Class;, "Ljava/lang/Class<+Ljava/lang/Object;>;"
    .end local v5    # "fields":[Ljava/lang/reflect/Field;
    .end local v6    # "object":Ljava/lang/Object;
    :goto_1
    return-object v6

    .line 53
    .restart local v1    # "clazz":Ljava/lang/Class;, "Ljava/lang/Class<+Ljava/lang/Object;>;"
    .restart local v5    # "fields":[Ljava/lang/reflect/Field;
    .restart local v6    # "object":Ljava/lang/Object;
    :cond_0
    aget-object v3, v5, v8

    .line 54
    .local v3, "field":Ljava/lang/reflect/Field;
    invoke-virtual {v3}, Ljava/lang/reflect/Field;->getName()Ljava/lang/String;

    move-result-object v4

    .line 55
    .local v4, "fieldName":Ljava/lang/String;
    const-string v10, "CREATOR"

    invoke-virtual {v4, v10}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v10

    if-eqz v10, :cond_1

    .line 53
    :goto_2
    add-int/lit8 v8, v8, 0x1

    goto :goto_0

    .line 57
    :cond_1
    invoke-interface {p0, v4}, Ljava/util/Map;->get(Ljava/lang/Object;)Ljava/lang/Object;

    move-result-object v7

    .line 58
    .local v7, "val":Ljava/lang/Object;
    invoke-static {v6, v4, v7}, Lcom/kaopu/download/util/ReflectionUtils;->setFieldValue(Ljava/lang/Object;Ljava/lang/String;Ljava/lang/Object;)V
    :try_end_0
    .catch Ljava/lang/IllegalArgumentException; {:try_start_0 .. :try_end_0} :catch_0
    .catch Ljava/lang/ClassNotFoundException; {:try_start_0 .. :try_end_0} :catch_1
    .catch Ljava/lang/InstantiationException; {:try_start_0 .. :try_end_0} :catch_2
    .catch Ljava/lang/IllegalAccessException; {:try_start_0 .. :try_end_0} :catch_3

    goto :goto_2

    .line 61
    .end local v1    # "clazz":Ljava/lang/Class;, "Ljava/lang/Class<+Ljava/lang/Object;>;"
    .end local v3    # "field":Ljava/lang/reflect/Field;
    .end local v4    # "fieldName":Ljava/lang/String;
    .end local v5    # "fields":[Ljava/lang/reflect/Field;
    .end local v6    # "object":Ljava/lang/Object;
    .end local v7    # "val":Ljava/lang/Object;
    :catch_0
    move-exception v2

    .line 62
    .local v2, "e":Ljava/lang/IllegalArgumentException;
    invoke-virtual {v2}, Ljava/lang/IllegalArgumentException;->printStackTrace()V

    .line 70
    .end local v2    # "e":Ljava/lang/IllegalArgumentException;
    :goto_3
    const/4 v6, 0x0

    goto :goto_1

    .line 63
    :catch_1
    move-exception v2

    .line 64
    .local v2, "e":Ljava/lang/ClassNotFoundException;
    invoke-virtual {v2}, Ljava/lang/ClassNotFoundException;->printStackTrace()V

    goto :goto_3

    .line 65
    .end local v2    # "e":Ljava/lang/ClassNotFoundException;
    :catch_2
    move-exception v2

    .line 66
    .local v2, "e":Ljava/lang/InstantiationException;
    invoke-virtual {v2}, Ljava/lang/InstantiationException;->printStackTrace()V

    goto :goto_3

    .line 67
    .end local v2    # "e":Ljava/lang/InstantiationException;
    :catch_3
    move-exception v2

    .line 68
    .local v2, "e":Ljava/lang/IllegalAccessException;
    invoke-virtual {v2}, Ljava/lang/IllegalAccessException;->printStackTrace()V

    goto :goto_3
.end method

.method public static final object2Map(Ljava/lang/Object;)Ljava/util/Map;
    .locals 10
    .param p0, "object"    # Ljava/lang/Object;

    .prologue
    .line 22
    new-instance v5, Ljava/util/HashMap;

    invoke-direct {v5}, Ljava/util/HashMap;-><init>()V

    .line 23
    .local v5, "hashMap":Ljava/util/HashMap;, "Ljava/util/HashMap<Ljava/lang/String;Ljava/lang/Object;>;"
    invoke-virtual {p0}, Ljava/lang/Object;->getClass()Ljava/lang/Class;

    move-result-object v0

    .line 24
    .local v0, "clazz":Ljava/lang/Class;, "Ljava/lang/Class<+Ljava/lang/Object;>;"
    invoke-static {p0}, Lcom/kaopu/download/util/ReflectionUtils;->getDeclaredFields(Ljava/lang/Object;)[Ljava/lang/reflect/Field;

    move-result-object v4

    .line 25
    .local v4, "fields":[Ljava/lang/reflect/Field;
    const-string v7, "class_name"

    invoke-virtual {v0}, Ljava/lang/Class;->getName()Ljava/lang/String;

    move-result-object v8

    invoke-virtual {v5, v7, v8}, Ljava/util/HashMap;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    .line 26
    array-length v8, v4

    const/4 v7, 0x0

    :goto_0
    if-lt v7, v8, :cond_0

    .line 37
    return-object v5

    .line 26
    :cond_0
    aget-object v2, v4, v7

    .line 28
    .local v2, "field":Ljava/lang/reflect/Field;
    :try_start_0
    invoke-virtual {v2}, Ljava/lang/reflect/Field;->getName()Ljava/lang/String;

    move-result-object v3

    .line 29
    .local v3, "fieldName":Ljava/lang/String;
    const-string v9, "CREATOR"

    invoke-virtual {v3, v9}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v9

    if-eqz v9, :cond_1

    .line 26
    .end local v3    # "fieldName":Ljava/lang/String;
    :goto_1
    add-int/lit8 v7, v7, 0x1

    goto :goto_0

    .line 31
    .restart local v3    # "fieldName":Ljava/lang/String;
    :cond_1
    invoke-static {p0, v3}, Lcom/kaopu/download/util/ReflectionUtils;->getFieldValue(Ljava/lang/Object;Ljava/lang/String;)Ljava/lang/Object;

    move-result-object v6

    .line 32
    .local v6, "val":Ljava/lang/Object;
    invoke-virtual {v5, v3, v6}, Ljava/util/HashMap;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;
    :try_end_0
    .catch Ljava/lang/IllegalArgumentException; {:try_start_0 .. :try_end_0} :catch_0

    goto :goto_1

    .line 33
    .end local v3    # "fieldName":Ljava/lang/String;
    .end local v6    # "val":Ljava/lang/Object;
    :catch_0
    move-exception v1

    .line 34
    .local v1, "e":Ljava/lang/IllegalArgumentException;
    invoke-virtual {v1}, Ljava/lang/IllegalArgumentException;->printStackTrace()V

    goto :goto_1
.end method
