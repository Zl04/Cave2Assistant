.class public Lcom/iflytek/voiceads/IFLYNativeAd;
.super Ljava/lang/Object;
.source "IFLYNativeAd.java"


# static fields
.field public static final TAG:Ljava/lang/String; = "IFLYNativeAd"

.field private static c_IFLYNativeAdImpl:Ljava/lang/Class;
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "Ljava/lang/Class",
            "<*>;"
        }
    .end annotation
.end field

.field private static isClassLoaded:Z


# instance fields
.field private iFLYNativeAdImpl:Lcom/iflytek/voiceads/IFLYNativeAd;

.field private listener:Lcom/iflytek/voiceads/IFLYNativeListener;


# direct methods
.method static constructor <clinit>()V
    .locals 1

    .prologue
    .line 17
    const/4 v0, 0x0

    sput-boolean v0, Lcom/iflytek/voiceads/IFLYNativeAd;->isClassLoaded:Z

    return-void
.end method

.method public constructor <init>(Landroid/content/Context;)V
    .locals 0
    .param p1, "context"    # Landroid/content/Context;

    .prologue
    .line 20
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    .line 21
    return-void
.end method

.method public constructor <init>(Landroid/content/Context;Ljava/lang/String;Lcom/iflytek/voiceads/IFLYNativeListener;)V
    .locals 6
    .param p1, "context"    # Landroid/content/Context;
    .param p2, "adUnitId"    # Ljava/lang/String;
    .param p3, "listener"    # Lcom/iflytek/voiceads/IFLYNativeListener;

    .prologue
    .line 23
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    .line 24
    iput-object p3, p0, Lcom/iflytek/voiceads/IFLYNativeAd;->listener:Lcom/iflytek/voiceads/IFLYNativeListener;

    .line 26
    :try_start_0
    sget-boolean v2, Lcom/iflytek/voiceads/IFLYNativeAd;->isClassLoaded:Z

    if-nez v2, :cond_0

    .line 27
    const-string v2, "com.iflytek.voiceads.IFLYNativeAdImpl"

    invoke-static {p1, v2}, Lcom/iflytek/voiceads/dex/AdDexLoader;->loadAdClass(Landroid/content/Context;Ljava/lang/String;)Ljava/lang/Class;

    move-result-object v2

    sput-object v2, Lcom/iflytek/voiceads/IFLYNativeAd;->c_IFLYNativeAdImpl:Ljava/lang/Class;

    .line 28
    const/4 v2, 0x1

    sput-boolean v2, Lcom/iflytek/voiceads/IFLYNativeAd;->isClassLoaded:Z

    .line 30
    :cond_0
    sget-object v2, Lcom/iflytek/voiceads/IFLYNativeAd;->c_IFLYNativeAdImpl:Ljava/lang/Class;

    const/4 v3, 0x3

    new-array v3, v3, [Ljava/lang/Class;

    const/4 v4, 0x0

    const-class v5, Landroid/content/Context;

    aput-object v5, v3, v4

    const/4 v4, 0x1

    const-class v5, Ljava/lang/String;

    aput-object v5, v3, v4

    const/4 v4, 0x2

    const-class v5, Lcom/iflytek/voiceads/IFLYNativeListener;

    aput-object v5, v3, v4

    invoke-virtual {v2, v3}, Ljava/lang/Class;->getConstructor([Ljava/lang/Class;)Ljava/lang/reflect/Constructor;

    move-result-object v0

    .line 32
    .local v0, "cons_IFLYNativeAdImpl":Ljava/lang/reflect/Constructor;, "Ljava/lang/reflect/Constructor<Lcom/iflytek/voiceads/IFLYNativeAd;>;"
    const/4 v2, 0x3

    new-array v2, v2, [Ljava/lang/Object;

    const/4 v3, 0x0

    aput-object p1, v2, v3

    const/4 v3, 0x1

    aput-object p2, v2, v3

    const/4 v3, 0x2

    aput-object p3, v2, v3

    invoke-virtual {v0, v2}, Ljava/lang/reflect/Constructor;->newInstance([Ljava/lang/Object;)Ljava/lang/Object;

    move-result-object v2

    check-cast v2, Lcom/iflytek/voiceads/IFLYNativeAd;

    iput-object v2, p0, Lcom/iflytek/voiceads/IFLYNativeAd;->iFLYNativeAdImpl:Lcom/iflytek/voiceads/IFLYNativeAd;
    :try_end_0
    .catch Ljava/lang/ClassNotFoundException; {:try_start_0 .. :try_end_0} :catch_0
    .catch Ljava/lang/NoSuchMethodException; {:try_start_0 .. :try_end_0} :catch_1
    .catch Ljava/lang/InstantiationException; {:try_start_0 .. :try_end_0} :catch_2
    .catch Ljava/lang/IllegalAccessException; {:try_start_0 .. :try_end_0} :catch_3
    .catch Ljava/lang/IllegalArgumentException; {:try_start_0 .. :try_end_0} :catch_4
    .catch Ljava/lang/reflect/InvocationTargetException; {:try_start_0 .. :try_end_0} :catch_5
    .catch Ljava/lang/NoSuchFieldException; {:try_start_0 .. :try_end_0} :catch_6

    .line 48
    .end local v0    # "cons_IFLYNativeAdImpl":Ljava/lang/reflect/Constructor;, "Ljava/lang/reflect/Constructor<Lcom/iflytek/voiceads/IFLYNativeAd;>;"
    :goto_0
    return-void

    .line 33
    :catch_0
    move-exception v1

    .line 34
    .local v1, "e":Ljava/lang/ClassNotFoundException;
    invoke-virtual {v1}, Ljava/lang/ClassNotFoundException;->printStackTrace()V

    goto :goto_0

    .line 35
    .end local v1    # "e":Ljava/lang/ClassNotFoundException;
    :catch_1
    move-exception v1

    .line 36
    .local v1, "e":Ljava/lang/NoSuchMethodException;
    invoke-virtual {v1}, Ljava/lang/NoSuchMethodException;->printStackTrace()V

    goto :goto_0

    .line 37
    .end local v1    # "e":Ljava/lang/NoSuchMethodException;
    :catch_2
    move-exception v1

    .line 38
    .local v1, "e":Ljava/lang/InstantiationException;
    invoke-virtual {v1}, Ljava/lang/InstantiationException;->printStackTrace()V

    goto :goto_0

    .line 39
    .end local v1    # "e":Ljava/lang/InstantiationException;
    :catch_3
    move-exception v1

    .line 40
    .local v1, "e":Ljava/lang/IllegalAccessException;
    invoke-virtual {v1}, Ljava/lang/IllegalAccessException;->printStackTrace()V

    goto :goto_0

    .line 41
    .end local v1    # "e":Ljava/lang/IllegalAccessException;
    :catch_4
    move-exception v1

    .line 42
    .local v1, "e":Ljava/lang/IllegalArgumentException;
    invoke-virtual {v1}, Ljava/lang/IllegalArgumentException;->printStackTrace()V

    goto :goto_0

    .line 43
    .end local v1    # "e":Ljava/lang/IllegalArgumentException;
    :catch_5
    move-exception v1

    .line 44
    .local v1, "e":Ljava/lang/reflect/InvocationTargetException;
    invoke-virtual {v1}, Ljava/lang/reflect/InvocationTargetException;->printStackTrace()V

    goto :goto_0

    .line 45
    .end local v1    # "e":Ljava/lang/reflect/InvocationTargetException;
    :catch_6
    move-exception v1

    .line 46
    .local v1, "e":Ljava/lang/NoSuchFieldException;
    invoke-virtual {v1}, Ljava/lang/NoSuchFieldException;->printStackTrace()V

    goto :goto_0
.end method


# virtual methods
.method public loadAd(I)V
    .locals 3
    .param p1, "count"    # I

    .prologue
    .line 59
    iget-object v0, p0, Lcom/iflytek/voiceads/IFLYNativeAd;->iFLYNativeAdImpl:Lcom/iflytek/voiceads/IFLYNativeAd;

    if-nez v0, :cond_1

    .line 60
    const-string v0, "can\'t find valided AdDex file in assets/"

    invoke-static {v0}, Lcom/iflytek/voiceads/dex/SDKLogger;->d(Ljava/lang/String;)V

    .line 61
    iget-object v0, p0, Lcom/iflytek/voiceads/IFLYNativeAd;->listener:Lcom/iflytek/voiceads/IFLYNativeListener;

    if-eqz v0, :cond_0

    .line 62
    iget-object v0, p0, Lcom/iflytek/voiceads/IFLYNativeAd;->listener:Lcom/iflytek/voiceads/IFLYNativeListener;

    new-instance v1, Lcom/iflytek/voiceads/AdError;

    const v2, 0x1155a

    invoke-direct {v1, v2}, Lcom/iflytek/voiceads/AdError;-><init>(I)V

    invoke-interface {v0, v1}, Lcom/iflytek/voiceads/IFLYNativeListener;->onAdFailed(Lcom/iflytek/voiceads/AdError;)V

    .line 67
    :cond_0
    :goto_0
    return-void

    .line 66
    :cond_1
    iget-object v0, p0, Lcom/iflytek/voiceads/IFLYNativeAd;->iFLYNativeAdImpl:Lcom/iflytek/voiceads/IFLYNativeAd;

    goto :goto_0
.end method

.method public setParameter(Ljava/lang/String;Ljava/lang/String;)V
    .locals 1
    .param p1, "key"    # Ljava/lang/String;
    .param p2, "value"    # Ljava/lang/String;

    .prologue
    .line 51
    iget-object v0, p0, Lcom/iflytek/voiceads/IFLYNativeAd;->iFLYNativeAdImpl:Lcom/iflytek/voiceads/IFLYNativeAd;

    if-nez v0, :cond_0

    .line 52
    const-string v0, "can\'t find valided AdDex file in assets/"

    invoke-static {v0}, Lcom/iflytek/voiceads/dex/SDKLogger;->d(Ljava/lang/String;)V

    .line 56
    :goto_0
    return-void

    .line 55
    :cond_0
    iget-object v0, p0, Lcom/iflytek/voiceads/IFLYNativeAd;->iFLYNativeAdImpl:Lcom/iflytek/voiceads/IFLYNativeAd;

    invoke-virtual {v0, p1, p2}, Lcom/iflytek/voiceads/IFLYNativeAd;->setParameter(Ljava/lang/String;Ljava/lang/String;)V

    goto :goto_0
.end method
