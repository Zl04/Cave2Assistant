.class public Lcom/iflytek/voiceads/dex/AdDexLoader;
.super Ljava/lang/Object;
.source "AdDexLoader.java"


# static fields
.field private static classLoader:Ldalvik/system/DexClassLoader;


# direct methods
.method public constructor <init>()V
    .locals 0

    .prologue
    .line 18
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method

.method private static changePackageClassLoader(Landroid/content/Context;Ldalvik/system/DexClassLoader;)V
    .locals 13
    .param p0, "context"    # Landroid/content/Context;
    .param p1, "classLoader"    # Ldalvik/system/DexClassLoader;
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljava/lang/ClassNotFoundException;,
            Ljava/lang/NoSuchMethodException;,
            Ljava/lang/IllegalAccessException;,
            Ljava/lang/IllegalArgumentException;,
            Ljava/lang/reflect/InvocationTargetException;,
            Ljava/lang/NoSuchFieldException;
        }
    .end annotation

    .prologue
    const/4 v12, 0x1

    const/4 v11, 0x0

    .line 93
    invoke-virtual {p0}, Landroid/content/Context;->getClassLoader()Ljava/lang/ClassLoader;

    move-result-object v9

    const-string v10, "android.app.ActivityThread"

    invoke-virtual {v9, v10}, Ljava/lang/ClassLoader;->loadClass(Ljava/lang/String;)Ljava/lang/Class;

    move-result-object v0

    .line 94
    .local v0, "c_ActivityThread":Ljava/lang/Class;, "Ljava/lang/Class<*>;"
    const-string v9, "currentActivityThread"

    new-array v10, v11, [Ljava/lang/Class;

    invoke-virtual {v0, v9, v10}, Ljava/lang/Class;->getMethod(Ljava/lang/String;[Ljava/lang/Class;)Ljava/lang/reflect/Method;

    move-result-object v6

    .line 95
    .local v6, "m_currentActivityThread":Ljava/lang/reflect/Method;
    const/4 v9, 0x0

    new-array v10, v11, [Ljava/lang/Object;

    invoke-virtual {v6, v9, v10}, Ljava/lang/reflect/Method;->invoke(Ljava/lang/Object;[Ljava/lang/Object;)Ljava/lang/Object;

    move-result-object v2

    .line 97
    .local v2, "currentActivityThread":Ljava/lang/Object;
    invoke-virtual {p0}, Landroid/content/Context;->getPackageName()Ljava/lang/String;

    move-result-object v7

    .line 98
    .local v7, "packageName":Ljava/lang/String;
    const-string v9, "mPackages"

    invoke-virtual {v0, v9}, Ljava/lang/Class;->getDeclaredField(Ljava/lang/String;)Ljava/lang/reflect/Field;

    move-result-object v4

    .line 99
    .local v4, "f_mPackages":Ljava/lang/reflect/Field;
    invoke-virtual {v4, v12}, Ljava/lang/reflect/Field;->setAccessible(Z)V

    .line 100
    invoke-virtual {v4, v2}, Ljava/lang/reflect/Field;->get(Ljava/lang/Object;)Ljava/lang/Object;

    move-result-object v5

    check-cast v5, Ljava/util/Map;

    .line 101
    .local v5, "mPackages":Ljava/util/Map;
    invoke-interface {v5, v7}, Ljava/util/Map;->get(Ljava/lang/Object;)Ljava/lang/Object;

    move-result-object v8

    check-cast v8, Ljava/lang/ref/WeakReference;

    .line 102
    .local v8, "wr":Ljava/lang/ref/WeakReference;
    invoke-virtual {p0}, Landroid/content/Context;->getClassLoader()Ljava/lang/ClassLoader;

    move-result-object v9

    const-string v10, "android.app.LoadedApk"

    invoke-virtual {v9, v10}, Ljava/lang/ClassLoader;->loadClass(Ljava/lang/String;)Ljava/lang/Class;

    move-result-object v1

    .line 103
    .local v1, "c_LoadedApk":Ljava/lang/Class;, "Ljava/lang/Class<*>;"
    const-string v9, "mClassLoader"

    invoke-virtual {v1, v9}, Ljava/lang/Class;->getDeclaredField(Ljava/lang/String;)Ljava/lang/reflect/Field;

    move-result-object v3

    .line 104
    .local v3, "f_mClassLoader":Ljava/lang/reflect/Field;
    invoke-virtual {v3, v12}, Ljava/lang/reflect/Field;->setAccessible(Z)V

    .line 105
    invoke-virtual {v8}, Ljava/lang/ref/WeakReference;->get()Ljava/lang/Object;

    move-result-object v9

    invoke-virtual {v3, v9, p1}, Ljava/lang/reflect/Field;->set(Ljava/lang/Object;Ljava/lang/Object;)V

    .line 107
    return-void
.end method

.method public static loadAdClass(Landroid/content/Context;Ljava/lang/String;)Ljava/lang/Class;
    .locals 3
    .param p0, "context"    # Landroid/content/Context;
    .param p1, "className"    # Ljava/lang/String;
    .annotation build Landroid/annotation/TargetApi;
        value = 0xe
    .end annotation

    .annotation system Ldalvik/annotation/Signature;
        value = {
            "(",
            "Landroid/content/Context;",
            "Ljava/lang/String;",
            ")",
            "Ljava/lang/Class",
            "<*>;"
        }
    .end annotation

    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljava/lang/ClassNotFoundException;,
            Ljava/lang/NoSuchMethodException;,
            Ljava/lang/IllegalAccessException;,
            Ljava/lang/IllegalArgumentException;,
            Ljava/lang/reflect/InvocationTargetException;,
            Ljava/lang/NoSuchFieldException;
        }
    .end annotation

    .prologue
    .line 43
    const-string v2, "use dex"

    invoke-static {v2}, Lcom/iflytek/voiceads/dex/SDKLogger;->d(Ljava/lang/String;)V

    .line 46
    :try_start_0
    sget-object v2, Lcom/iflytek/voiceads/dex/AdDexLoader;->classLoader:Ldalvik/system/DexClassLoader;

    if-nez v2, :cond_0

    .line 47
    invoke-static {p0}, Lcom/iflytek/voiceads/dex/AdDexLoader;->loadDex(Landroid/content/Context;)Ldalvik/system/DexClassLoader;

    move-result-object v2

    sput-object v2, Lcom/iflytek/voiceads/dex/AdDexLoader;->classLoader:Ldalvik/system/DexClassLoader;

    .line 48
    sget-object v2, Lcom/iflytek/voiceads/dex/AdDexLoader;->classLoader:Ldalvik/system/DexClassLoader;

    invoke-static {p0, v2}, Lcom/iflytek/voiceads/dex/AdDexLoader;->changePackageClassLoader(Landroid/content/Context;Ldalvik/system/DexClassLoader;)V

    .line 50
    :cond_0
    sget-object v2, Lcom/iflytek/voiceads/dex/AdDexLoader;->classLoader:Ldalvik/system/DexClassLoader;

    invoke-virtual {v2, p1}, Ldalvik/system/DexClassLoader;->loadClass(Ljava/lang/String;)Ljava/lang/Class;
    :try_end_0
    .catch Ljava/lang/Exception; {:try_start_0 .. :try_end_0} :catch_0

    move-result-object v0

    .line 56
    .local v0, "clazz":Ljava/lang/Class;, "Ljava/lang/Class<*>;"
    :goto_0
    return-object v0

    .line 51
    .end local v0    # "clazz":Ljava/lang/Class;, "Ljava/lang/Class<*>;"
    :catch_0
    move-exception v1

    .line 52
    .local v1, "e":Ljava/lang/Exception;
    invoke-static {p0}, Lcom/iflytek/voiceads/dex/AdDexLoader;->loadRawDex(Landroid/content/Context;)Ldalvik/system/DexClassLoader;

    move-result-object v2

    sput-object v2, Lcom/iflytek/voiceads/dex/AdDexLoader;->classLoader:Ldalvik/system/DexClassLoader;

    .line 53
    sget-object v2, Lcom/iflytek/voiceads/dex/AdDexLoader;->classLoader:Ldalvik/system/DexClassLoader;

    invoke-static {p0, v2}, Lcom/iflytek/voiceads/dex/AdDexLoader;->changePackageClassLoader(Landroid/content/Context;Ldalvik/system/DexClassLoader;)V

    .line 54
    sget-object v2, Lcom/iflytek/voiceads/dex/AdDexLoader;->classLoader:Ldalvik/system/DexClassLoader;

    invoke-virtual {v2, p1}, Ldalvik/system/DexClassLoader;->loadClass(Ljava/lang/String;)Ljava/lang/Class;

    move-result-object v0

    .restart local v0    # "clazz":Ljava/lang/Class;, "Ljava/lang/Class<*>;"
    goto :goto_0
.end method

.method private static loadDex(Landroid/content/Context;)Ldalvik/system/DexClassLoader;
    .locals 4
    .param p0, "context"    # Landroid/content/Context;

    .prologue
    .line 61
    invoke-static {}, Lcom/iflytek/voiceads/Version;->getVersion()Ljava/lang/String;

    move-result-object v2

    const-string v3, "_"

    invoke-virtual {v2, v3}, Ljava/lang/String;->split(Ljava/lang/String;)[Ljava/lang/String;

    move-result-object v2

    const/4 v3, 0x0

    aget-object v1, v2, v3

    .line 62
    .local v1, "sdkVersion":Ljava/lang/String;
    invoke-static {p0, v1}, Lcom/iflytek/voiceads/dex/UpdateUtils;->getLocalDex(Landroid/content/Context;Ljava/lang/String;)Ljava/lang/String;

    move-result-object v0

    .line 63
    .local v0, "localVersion":Ljava/lang/String;
    new-instance v2, Ljava/lang/StringBuilder;

    invoke-direct {v2}, Ljava/lang/StringBuilder;-><init>()V

    const-string v3, "sdkVersion="

    invoke-virtual {v2, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    invoke-virtual {v2, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    const-string v3, ";localVersion="

    invoke-virtual {v2, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    invoke-virtual {v2, v0}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    invoke-virtual {v2}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v2

    invoke-static {v2}, Lcom/iflytek/voiceads/dex/SDKLogger;->d_dev(Ljava/lang/String;)V

    .line 64
    invoke-static {p0, v0}, Lcom/iflytek/voiceads/dex/AdDexLoader;->loadDex(Landroid/content/Context;Ljava/lang/String;)Ldalvik/system/DexClassLoader;

    move-result-object v2

    return-object v2
.end method

.method private static loadDex(Landroid/content/Context;Ljava/lang/String;)Ldalvik/system/DexClassLoader;
    .locals 5
    .param p0, "context"    # Landroid/content/Context;
    .param p1, "dexName"    # Ljava/lang/String;

    .prologue
    .line 82
    new-instance v2, Ljava/lang/StringBuilder;

    invoke-direct {v2}, Ljava/lang/StringBuilder;-><init>()V

    invoke-virtual {p0}, Landroid/content/Context;->getFilesDir()Ljava/io/File;

    move-result-object v3

    invoke-virtual {v3}, Ljava/io/File;->getAbsolutePath()Ljava/lang/String;

    move-result-object v3

    invoke-virtual {v2, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    sget-object v3, Ljava/io/File;->separator:Ljava/lang/String;

    invoke-virtual {v2, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    invoke-virtual {v2, p1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    invoke-virtual {v2}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v1

    .line 83
    .local v1, "dexPath":Ljava/lang/String;
    const-string v2, "dex"

    const/4 v3, 0x0

    invoke-virtual {p0, v2, v3}, Landroid/content/Context;->getDir(Ljava/lang/String;I)Ljava/io/File;

    move-result-object v2

    invoke-virtual {v2}, Ljava/io/File;->getAbsolutePath()Ljava/lang/String;

    move-result-object v0

    .line 84
    .local v0, "dexOutputDir":Ljava/lang/String;
    new-instance v2, Ldalvik/system/DexClassLoader;

    const/4 v3, 0x0

    invoke-virtual {p0}, Landroid/content/Context;->getClassLoader()Ljava/lang/ClassLoader;

    move-result-object v4

    invoke-direct {v2, v1, v0, v3, v4}, Ldalvik/system/DexClassLoader;-><init>(Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;Ljava/lang/ClassLoader;)V

    return-object v2
.end method

.method private static loadRawDex(Landroid/content/Context;)Ldalvik/system/DexClassLoader;
    .locals 4
    .param p0, "context"    # Landroid/content/Context;

    .prologue
    .line 68
    invoke-static {}, Lcom/iflytek/voiceads/Version;->getVersion()Ljava/lang/String;

    move-result-object v2

    const-string v3, "_"

    invoke-virtual {v2, v3}, Ljava/lang/String;->split(Ljava/lang/String;)[Ljava/lang/String;

    move-result-object v2

    const/4 v3, 0x0

    aget-object v1, v2, v3

    .line 69
    .local v1, "sdkVersion":Ljava/lang/String;
    invoke-static {p0, v1}, Lcom/iflytek/voiceads/dex/UpdateUtils;->getRawDex(Landroid/content/Context;Ljava/lang/String;)Ljava/lang/String;

    move-result-object v0

    .line 70
    .local v0, "rawVersion":Ljava/lang/String;
    new-instance v2, Ljava/lang/StringBuilder;

    invoke-direct {v2}, Ljava/lang/StringBuilder;-><init>()V

    const-string v3, "sdkVersion="

    invoke-virtual {v2, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    invoke-virtual {v2, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    const-string v3, ";rawVersion="

    invoke-virtual {v2, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    invoke-virtual {v2, v0}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    invoke-virtual {v2}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v2

    invoke-static {v2}, Lcom/iflytek/voiceads/dex/SDKLogger;->d_dev(Ljava/lang/String;)V

    .line 71
    invoke-static {p0, v0}, Lcom/iflytek/voiceads/dex/AdDexLoader;->loadDex(Landroid/content/Context;Ljava/lang/String;)Ldalvik/system/DexClassLoader;

    move-result-object v2

    return-object v2
.end method
