.class public Lcom/iflytek/voiceads/IFLYInterstitialAd;
.super Lcom/iflytek/voiceads/view/AdLayout;
.source "IFLYInterstitialAd.java"


# static fields
.field private static c_IFLYInterstitialAdImpl:Ljava/lang/Class;
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "Ljava/lang/Class",
            "<*>;"
        }
    .end annotation
.end field

.field private static iFLYInterstitialAdImpl:Lcom/iflytek/voiceads/IFLYInterstitialAd;

.field private static isClassLoaded:Z


# direct methods
.method static constructor <clinit>()V
    .locals 1

    .prologue
    .line 17
    const/4 v0, 0x0

    sput-boolean v0, Lcom/iflytek/voiceads/IFLYInterstitialAd;->isClassLoaded:Z

    return-void
.end method

.method protected constructor <init>(Landroid/content/Context;)V
    .locals 0
    .param p1, "context"    # Landroid/content/Context;

    .prologue
    .line 20
    invoke-direct {p0, p1}, Lcom/iflytek/voiceads/view/AdLayout;-><init>(Landroid/content/Context;)V

    .line 21
    return-void
.end method

.method public static createInterstitialAd(Landroid/content/Context;Ljava/lang/String;)Lcom/iflytek/voiceads/IFLYInterstitialAd;
    .locals 7
    .param p0, "context"    # Landroid/content/Context;
    .param p1, "adUnitId"    # Ljava/lang/String;

    .prologue
    .line 25
    :try_start_0
    sget-boolean v2, Lcom/iflytek/voiceads/IFLYInterstitialAd;->isClassLoaded:Z

    if-nez v2, :cond_0

    .line 26
    const-string v2, "com.iflytek.voiceads.IFLYInterstitialAdImpl"

    invoke-static {p0, v2}, Lcom/iflytek/voiceads/dex/AdDexLoader;->loadAdClass(Landroid/content/Context;Ljava/lang/String;)Ljava/lang/Class;

    move-result-object v2

    sput-object v2, Lcom/iflytek/voiceads/IFLYInterstitialAd;->c_IFLYInterstitialAdImpl:Ljava/lang/Class;

    .line 27
    const/4 v2, 0x1

    sput-boolean v2, Lcom/iflytek/voiceads/IFLYInterstitialAd;->isClassLoaded:Z

    .line 29
    :cond_0
    sget-object v2, Lcom/iflytek/voiceads/IFLYInterstitialAd;->c_IFLYInterstitialAdImpl:Ljava/lang/Class;

    const-string v3, "createInterstitialAd"

    const/4 v4, 0x2

    new-array v4, v4, [Ljava/lang/Class;

    const/4 v5, 0x0

    const-class v6, Landroid/content/Context;

    aput-object v6, v4, v5

    const/4 v5, 0x1

    const-class v6, Ljava/lang/String;

    aput-object v6, v4, v5

    invoke-virtual {v2, v3, v4}, Ljava/lang/Class;->getMethod(Ljava/lang/String;[Ljava/lang/Class;)Ljava/lang/reflect/Method;

    move-result-object v1

    .line 30
    .local v1, "m_createInterstitialAd":Ljava/lang/reflect/Method;
    const/4 v2, 0x0

    const/4 v3, 0x2

    new-array v3, v3, [Ljava/lang/Object;

    const/4 v4, 0x0

    aput-object p0, v3, v4

    const/4 v4, 0x1

    aput-object p1, v3, v4

    invoke-virtual {v1, v2, v3}, Ljava/lang/reflect/Method;->invoke(Ljava/lang/Object;[Ljava/lang/Object;)Ljava/lang/Object;

    move-result-object v2

    check-cast v2, Lcom/iflytek/voiceads/IFLYInterstitialAd;

    sput-object v2, Lcom/iflytek/voiceads/IFLYInterstitialAd;->iFLYInterstitialAdImpl:Lcom/iflytek/voiceads/IFLYInterstitialAd;

    .line 31
    sget-object v2, Lcom/iflytek/voiceads/IFLYInterstitialAd;->iFLYInterstitialAdImpl:Lcom/iflytek/voiceads/IFLYInterstitialAd;
    :try_end_0
    .catch Ljava/lang/NoSuchMethodException; {:try_start_0 .. :try_end_0} :catch_0
    .catch Ljava/lang/IllegalAccessException; {:try_start_0 .. :try_end_0} :catch_1
    .catch Ljava/lang/IllegalArgumentException; {:try_start_0 .. :try_end_0} :catch_2
    .catch Ljava/lang/reflect/InvocationTargetException; {:try_start_0 .. :try_end_0} :catch_3
    .catch Ljava/lang/ClassNotFoundException; {:try_start_0 .. :try_end_0} :catch_4
    .catch Ljava/lang/NoSuchFieldException; {:try_start_0 .. :try_end_0} :catch_5

    .line 45
    .end local v1    # "m_createInterstitialAd":Ljava/lang/reflect/Method;
    :goto_0
    return-object v2

    .line 32
    :catch_0
    move-exception v0

    .line 33
    .local v0, "e":Ljava/lang/NoSuchMethodException;
    invoke-virtual {v0}, Ljava/lang/NoSuchMethodException;->printStackTrace()V

    .line 45
    .end local v0    # "e":Ljava/lang/NoSuchMethodException;
    :goto_1
    new-instance v2, Lcom/iflytek/voiceads/IFLYInterstitialAd;

    invoke-direct {v2, p0}, Lcom/iflytek/voiceads/IFLYInterstitialAd;-><init>(Landroid/content/Context;)V

    goto :goto_0

    .line 34
    :catch_1
    move-exception v0

    .line 35
    .local v0, "e":Ljava/lang/IllegalAccessException;
    invoke-virtual {v0}, Ljava/lang/IllegalAccessException;->printStackTrace()V

    goto :goto_1

    .line 36
    .end local v0    # "e":Ljava/lang/IllegalAccessException;
    :catch_2
    move-exception v0

    .line 37
    .local v0, "e":Ljava/lang/IllegalArgumentException;
    invoke-virtual {v0}, Ljava/lang/IllegalArgumentException;->printStackTrace()V

    goto :goto_1

    .line 38
    .end local v0    # "e":Ljava/lang/IllegalArgumentException;
    :catch_3
    move-exception v0

    .line 39
    .local v0, "e":Ljava/lang/reflect/InvocationTargetException;
    invoke-virtual {v0}, Ljava/lang/reflect/InvocationTargetException;->printStackTrace()V

    goto :goto_1

    .line 40
    .end local v0    # "e":Ljava/lang/reflect/InvocationTargetException;
    :catch_4
    move-exception v0

    .line 41
    .local v0, "e":Ljava/lang/ClassNotFoundException;
    invoke-virtual {v0}, Ljava/lang/ClassNotFoundException;->printStackTrace()V

    goto :goto_1

    .line 42
    .end local v0    # "e":Ljava/lang/ClassNotFoundException;
    :catch_5
    move-exception v0

    .line 43
    .local v0, "e":Ljava/lang/NoSuchFieldException;
    invoke-virtual {v0}, Ljava/lang/NoSuchFieldException;->printStackTrace()V

    goto :goto_1
.end method


# virtual methods
.method public destroy()V
    .locals 2

    .prologue
    const/4 v1, 0x0

    .line 67
    sget-object v0, Lcom/iflytek/voiceads/IFLYInterstitialAd;->iFLYInterstitialAdImpl:Lcom/iflytek/voiceads/IFLYInterstitialAd;

    if-eqz v0, :cond_0

    .line 68
    sput-object v1, Lcom/iflytek/voiceads/IFLYInterstitialAd;->c_IFLYInterstitialAdImpl:Ljava/lang/Class;

    .line 69
    sput-object v1, Lcom/iflytek/voiceads/IFLYInterstitialAd;->iFLYInterstitialAdImpl:Lcom/iflytek/voiceads/IFLYInterstitialAd;

    .line 70
    const/4 v0, 0x0

    sput-boolean v0, Lcom/iflytek/voiceads/IFLYInterstitialAd;->isClassLoaded:Z

    .line 71
    invoke-super {p0}, Lcom/iflytek/voiceads/view/AdLayout;->destroy()V

    .line 73
    :cond_0
    return-void
.end method

.method public loadAd(Lcom/iflytek/voiceads/IFLYAdListener;)V
    .locals 2
    .param p1, "listener"    # Lcom/iflytek/voiceads/IFLYAdListener;

    .prologue
    .line 57
    const-string v0, "can\'t find valided AdDex file in assets/"

    invoke-static {v0}, Lcom/iflytek/voiceads/dex/SDKLogger;->d(Ljava/lang/String;)V

    .line 58
    new-instance v0, Lcom/iflytek/voiceads/AdError;

    const v1, 0x1155a

    invoke-direct {v0, v1}, Lcom/iflytek/voiceads/AdError;-><init>(I)V

    invoke-interface {p1, v0}, Lcom/iflytek/voiceads/IFLYAdListener;->onAdFailed(Lcom/iflytek/voiceads/AdError;)V

    .line 59
    return-void
.end method

.method public setAdSize(Lcom/iflytek/voiceads/IFLYAdSize;)V
    .locals 1
    .param p1, "adSize"    # Lcom/iflytek/voiceads/IFLYAdSize;

    .prologue
    .line 49
    const-string v0, "can\'t find valided AdDex file in assets/"

    invoke-static {v0}, Lcom/iflytek/voiceads/dex/SDKLogger;->d(Ljava/lang/String;)V

    .line 50
    return-void
.end method

.method public setParameter(Ljava/lang/String;Ljava/lang/String;)V
    .locals 1
    .param p1, "key"    # Ljava/lang/String;
    .param p2, "value"    # Ljava/lang/String;

    .prologue
    .line 53
    const-string v0, "can\'t find valided AdDex file in assets/"

    invoke-static {v0}, Lcom/iflytek/voiceads/dex/SDKLogger;->d(Ljava/lang/String;)V

    .line 54
    return-void
.end method

.method public showAd()V
    .locals 1

    .prologue
    .line 62
    const-string v0, "can\'t find valided AdDex file in assets/"

    invoke-static {v0}, Lcom/iflytek/voiceads/dex/SDKLogger;->d(Ljava/lang/String;)V

    .line 63
    return-void
.end method
