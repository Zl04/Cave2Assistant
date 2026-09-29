.class public Lcom/iflytek/voiceads/IFLYVideoAd;
.super Ljava/lang/Object;
.source "IFLYVideoAd.java"


# static fields
.field public static final NATIVE_VIDEO_AD:I = 0x0

.field public static final PATCH_VIDEO_AD:I = 0x3

.field public static final REWARDED_VIDEO_AD:I = 0x1

.field public static final SCREEN_ORIENTATION_LANDSCAPE:I = 0x0

.field public static final SCREEN_ORIENTATION_PORTRAIT:I = 0x1

.field public static final SCREEN_WINDOW_FULLSCREEN:I = 0x1

.field public static final SCREEN_WINDOW_NORMAL:I = 0x0

.field public static final SPLASH_VIDEO_AD:I = 0x2

.field public static final TAG:Ljava/lang/String; = "IFLYVideoAd"

.field private static c_IFLYVideoAdImpl:Ljava/lang/Class;
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "Ljava/lang/Class",
            "<*>;"
        }
    .end annotation
.end field

.field private static isClassLoaded:Z


# instance fields
.field private iFLYVideoAdImpl:Lcom/iflytek/voiceads/IFLYVideoAd;

.field private mVideoAdListener:Lcom/iflytek/voiceads/IFLYVideoAdListener;


# direct methods
.method static constructor <clinit>()V
    .locals 1

    .prologue
    .line 34
    const/4 v0, 0x0

    sput-boolean v0, Lcom/iflytek/voiceads/IFLYVideoAd;->isClassLoaded:Z

    return-void
.end method

.method public constructor <init>(Landroid/content/Context;)V
    .locals 0
    .param p1, "context"    # Landroid/content/Context;

    .prologue
    .line 37
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    .line 38
    return-void
.end method

.method public constructor <init>(Landroid/content/Context;Ljava/lang/String;Lcom/iflytek/voiceads/IFLYVideoAdListener;I)V
    .locals 7
    .param p1, "context"    # Landroid/content/Context;
    .param p2, "adUnitId"    # Ljava/lang/String;
    .param p3, "listener"    # Lcom/iflytek/voiceads/IFLYVideoAdListener;
    .param p4, "adType"    # I

    .prologue
    .line 40
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    .line 41
    iput-object p3, p0, Lcom/iflytek/voiceads/IFLYVideoAd;->mVideoAdListener:Lcom/iflytek/voiceads/IFLYVideoAdListener;

    .line 43
    :try_start_0
    sget-boolean v3, Lcom/iflytek/voiceads/IFLYVideoAd;->isClassLoaded:Z

    if-nez v3, :cond_0

    .line 44
    const-string v3, "com.iflytek.voiceads.IFLYVideoAdImpl"

    invoke-static {p1, v3}, Lcom/iflytek/voiceads/dex/AdDexLoader;->loadAdClass(Landroid/content/Context;Ljava/lang/String;)Ljava/lang/Class;

    move-result-object v3

    sput-object v3, Lcom/iflytek/voiceads/IFLYVideoAd;->c_IFLYVideoAdImpl:Ljava/lang/Class;

    .line 45
    const/4 v3, 0x1

    sput-boolean v3, Lcom/iflytek/voiceads/IFLYVideoAd;->isClassLoaded:Z

    .line 47
    :cond_0
    sget-object v3, Lcom/iflytek/voiceads/IFLYVideoAd;->c_IFLYVideoAdImpl:Ljava/lang/Class;

    const/4 v4, 0x4

    new-array v4, v4, [Ljava/lang/Class;

    const/4 v5, 0x0

    const-class v6, Landroid/content/Context;

    aput-object v6, v4, v5

    const/4 v5, 0x1

    const-class v6, Ljava/lang/String;

    aput-object v6, v4, v5

    const/4 v5, 0x2

    const-class v6, Lcom/iflytek/voiceads/IFLYVideoAdListener;

    aput-object v6, v4, v5

    const/4 v5, 0x3

    sget-object v6, Ljava/lang/Integer;->TYPE:Ljava/lang/Class;

    aput-object v6, v4, v5

    invoke-virtual {v3, v4}, Ljava/lang/Class;->getConstructor([Ljava/lang/Class;)Ljava/lang/reflect/Constructor;

    move-result-object v0

    .line 49
    .local v0, "cons_IFLYVideoAdImpl":Ljava/lang/reflect/Constructor;, "Ljava/lang/reflect/Constructor<Lcom/iflytek/voiceads/IFLYVideoAd;>;"
    const/4 v3, 0x4

    new-array v3, v3, [Ljava/lang/Object;

    const/4 v4, 0x0

    aput-object p1, v3, v4

    const/4 v4, 0x1

    aput-object p2, v3, v4

    const/4 v4, 0x2

    aput-object p3, v3, v4

    const/4 v4, 0x3

    invoke-static {p4}, Ljava/lang/Integer;->valueOf(I)Ljava/lang/Integer;

    move-result-object v5

    aput-object v5, v3, v4

    invoke-virtual {v0, v3}, Ljava/lang/reflect/Constructor;->newInstance([Ljava/lang/Object;)Ljava/lang/Object;

    move-result-object v3

    check-cast v3, Lcom/iflytek/voiceads/IFLYVideoAd;

    iput-object v3, p0, Lcom/iflytek/voiceads/IFLYVideoAd;->iFLYVideoAdImpl:Lcom/iflytek/voiceads/IFLYVideoAd;
    :try_end_0
    .catch Ljava/lang/ClassNotFoundException; {:try_start_0 .. :try_end_0} :catch_0
    .catch Ljava/lang/NoSuchMethodException; {:try_start_0 .. :try_end_0} :catch_1
    .catch Ljava/lang/InstantiationException; {:try_start_0 .. :try_end_0} :catch_2
    .catch Ljava/lang/IllegalAccessException; {:try_start_0 .. :try_end_0} :catch_3
    .catch Ljava/lang/IllegalArgumentException; {:try_start_0 .. :try_end_0} :catch_4
    .catch Ljava/lang/reflect/InvocationTargetException; {:try_start_0 .. :try_end_0} :catch_5
    .catch Ljava/lang/NoSuchFieldException; {:try_start_0 .. :try_end_0} :catch_6

    .line 66
    .end local v0    # "cons_IFLYVideoAdImpl":Ljava/lang/reflect/Constructor;, "Ljava/lang/reflect/Constructor<Lcom/iflytek/voiceads/IFLYVideoAd;>;"
    :goto_0
    return-void

    .line 50
    :catch_0
    move-exception v1

    .line 51
    .local v1, "e":Ljava/lang/ClassNotFoundException;
    invoke-virtual {v1}, Ljava/lang/ClassNotFoundException;->printStackTrace()V

    goto :goto_0

    .line 52
    .end local v1    # "e":Ljava/lang/ClassNotFoundException;
    :catch_1
    move-exception v1

    .line 53
    .local v1, "e":Ljava/lang/NoSuchMethodException;
    invoke-virtual {v1}, Ljava/lang/NoSuchMethodException;->printStackTrace()V

    goto :goto_0

    .line 54
    .end local v1    # "e":Ljava/lang/NoSuchMethodException;
    :catch_2
    move-exception v1

    .line 55
    .local v1, "e":Ljava/lang/InstantiationException;
    invoke-virtual {v1}, Ljava/lang/InstantiationException;->printStackTrace()V

    goto :goto_0

    .line 56
    .end local v1    # "e":Ljava/lang/InstantiationException;
    :catch_3
    move-exception v1

    .line 57
    .local v1, "e":Ljava/lang/IllegalAccessException;
    invoke-virtual {v1}, Ljava/lang/IllegalAccessException;->printStackTrace()V

    goto :goto_0

    .line 58
    .end local v1    # "e":Ljava/lang/IllegalAccessException;
    :catch_4
    move-exception v1

    .line 59
    .local v1, "e":Ljava/lang/IllegalArgumentException;
    invoke-virtual {v1}, Ljava/lang/IllegalArgumentException;->printStackTrace()V

    goto :goto_0

    .line 60
    .end local v1    # "e":Ljava/lang/IllegalArgumentException;
    :catch_5
    move-exception v1

    .line 61
    .local v1, "e":Ljava/lang/reflect/InvocationTargetException;
    invoke-virtual {v1}, Ljava/lang/reflect/InvocationTargetException;->getTargetException()Ljava/lang/Throwable;

    move-result-object v2

    .line 62
    .local v2, "exception":Ljava/lang/Throwable;
    invoke-virtual {v2}, Ljava/lang/Throwable;->printStackTrace()V

    goto :goto_0

    .line 63
    .end local v1    # "e":Ljava/lang/reflect/InvocationTargetException;
    .end local v2    # "exception":Ljava/lang/Throwable;
    :catch_6
    move-exception v1

    .line 64
    .local v1, "e":Ljava/lang/NoSuchFieldException;
    invoke-virtual {v1}, Ljava/lang/NoSuchFieldException;->printStackTrace()V

    goto :goto_0
.end method


# virtual methods
.method public getAdView()Landroid/view/ViewGroup;
    .locals 1

    .prologue
    .line 77
    iget-object v0, p0, Lcom/iflytek/voiceads/IFLYVideoAd;->iFLYVideoAdImpl:Lcom/iflytek/voiceads/IFLYVideoAd;

    if-nez v0, :cond_0

    .line 78
    const-string v0, "can\'t find valided AdDex file in assets/"

    invoke-static {v0}, Lcom/iflytek/voiceads/dex/SDKLogger;->d(Ljava/lang/String;)V

    .line 79
    const/4 v0, 0x0

    .line 81
    :goto_0
    return-object v0

    :cond_0
    iget-object v0, p0, Lcom/iflytek/voiceads/IFLYVideoAd;->iFLYVideoAdImpl:Lcom/iflytek/voiceads/IFLYVideoAd;

    invoke-virtual {v0}, Lcom/iflytek/voiceads/IFLYVideoAd;->getAdView()Landroid/view/ViewGroup;

    move-result-object v0

    goto :goto_0
.end method

.method public isAdPlaying()Z
    .locals 1

    .prologue
    .line 158
    iget-object v0, p0, Lcom/iflytek/voiceads/IFLYVideoAd;->iFLYVideoAdImpl:Lcom/iflytek/voiceads/IFLYVideoAd;

    if-nez v0, :cond_0

    .line 159
    const-string v0, "can\'t find valided AdDex file in assets/"

    invoke-static {v0}, Lcom/iflytek/voiceads/dex/SDKLogger;->d(Ljava/lang/String;)V

    .line 160
    const/4 v0, 0x0

    .line 162
    :goto_0
    return v0

    :cond_0
    iget-object v0, p0, Lcom/iflytek/voiceads/IFLYVideoAd;->iFLYVideoAdImpl:Lcom/iflytek/voiceads/IFLYVideoAd;

    invoke-virtual {v0}, Lcom/iflytek/voiceads/IFLYVideoAd;->isAdPlaying()Z

    move-result v0

    goto :goto_0
.end method

.method public loadAd(I)V
    .locals 3
    .param p1, "count"    # I

    .prologue
    .line 85
    iget-object v0, p0, Lcom/iflytek/voiceads/IFLYVideoAd;->iFLYVideoAdImpl:Lcom/iflytek/voiceads/IFLYVideoAd;

    if-nez v0, :cond_1

    .line 86
    const-string v0, "can\'t find valided AdDex file in assets/"

    invoke-static {v0}, Lcom/iflytek/voiceads/dex/SDKLogger;->d(Ljava/lang/String;)V

    .line 87
    iget-object v0, p0, Lcom/iflytek/voiceads/IFLYVideoAd;->mVideoAdListener:Lcom/iflytek/voiceads/IFLYVideoAdListener;

    if-eqz v0, :cond_0

    .line 88
    iget-object v0, p0, Lcom/iflytek/voiceads/IFLYVideoAd;->mVideoAdListener:Lcom/iflytek/voiceads/IFLYVideoAdListener;

    new-instance v1, Lcom/iflytek/voiceads/AdError;

    const v2, 0x1155a

    invoke-direct {v1, v2}, Lcom/iflytek/voiceads/AdError;-><init>(I)V

    invoke-interface {v0, v1}, Lcom/iflytek/voiceads/IFLYVideoAdListener;->onAdFailed(Lcom/iflytek/voiceads/AdError;)V

    .line 93
    :cond_0
    :goto_0
    return-void

    .line 92
    :cond_1
    iget-object v0, p0, Lcom/iflytek/voiceads/IFLYVideoAd;->iFLYVideoAdImpl:Lcom/iflytek/voiceads/IFLYVideoAd;

    goto :goto_0
.end method

.method public onPause()V
    .locals 1

    .prologue
    .line 142
    iget-object v0, p0, Lcom/iflytek/voiceads/IFLYVideoAd;->iFLYVideoAdImpl:Lcom/iflytek/voiceads/IFLYVideoAd;

    if-nez v0, :cond_0

    .line 143
    const-string v0, "can\'t find valided AdDex file in assets/"

    invoke-static {v0}, Lcom/iflytek/voiceads/dex/SDKLogger;->d(Ljava/lang/String;)V

    .line 147
    :goto_0
    return-void

    .line 146
    :cond_0
    iget-object v0, p0, Lcom/iflytek/voiceads/IFLYVideoAd;->iFLYVideoAdImpl:Lcom/iflytek/voiceads/IFLYVideoAd;

    invoke-virtual {v0}, Lcom/iflytek/voiceads/IFLYVideoAd;->onPause()V

    goto :goto_0
.end method

.method public onResume()V
    .locals 1

    .prologue
    .line 150
    iget-object v0, p0, Lcom/iflytek/voiceads/IFLYVideoAd;->iFLYVideoAdImpl:Lcom/iflytek/voiceads/IFLYVideoAd;

    if-nez v0, :cond_0

    .line 151
    const-string v0, "can\'t find valided AdDex file in assets/"

    invoke-static {v0}, Lcom/iflytek/voiceads/dex/SDKLogger;->d(Ljava/lang/String;)V

    .line 155
    :goto_0
    return-void

    .line 154
    :cond_0
    iget-object v0, p0, Lcom/iflytek/voiceads/IFLYVideoAd;->iFLYVideoAdImpl:Lcom/iflytek/voiceads/IFLYVideoAd;

    invoke-virtual {v0}, Lcom/iflytek/voiceads/IFLYVideoAd;->onResume()V

    goto :goto_0
.end method

.method public releaseVideo()V
    .locals 1

    .prologue
    .line 118
    iget-object v0, p0, Lcom/iflytek/voiceads/IFLYVideoAd;->iFLYVideoAdImpl:Lcom/iflytek/voiceads/IFLYVideoAd;

    if-nez v0, :cond_0

    .line 119
    const-string v0, "can\'t find valided AdDex file in assets/"

    invoke-static {v0}, Lcom/iflytek/voiceads/dex/SDKLogger;->d(Ljava/lang/String;)V

    .line 123
    :goto_0
    return-void

    .line 122
    :cond_0
    iget-object v0, p0, Lcom/iflytek/voiceads/IFLYVideoAd;->iFLYVideoAdImpl:Lcom/iflytek/voiceads/IFLYVideoAd;

    invoke-virtual {v0}, Lcom/iflytek/voiceads/IFLYVideoAd;->releaseVideo()V

    goto :goto_0
.end method

.method public setParameter(Ljava/lang/String;Ljava/lang/String;)V
    .locals 1
    .param p1, "key"    # Ljava/lang/String;
    .param p2, "value"    # Ljava/lang/String;

    .prologue
    .line 69
    iget-object v0, p0, Lcom/iflytek/voiceads/IFLYVideoAd;->iFLYVideoAdImpl:Lcom/iflytek/voiceads/IFLYVideoAd;

    if-nez v0, :cond_0

    .line 70
    const-string v0, "can\'t find valided AdDex file in assets/"

    invoke-static {v0}, Lcom/iflytek/voiceads/dex/SDKLogger;->d(Ljava/lang/String;)V

    .line 74
    :goto_0
    return-void

    .line 73
    :cond_0
    iget-object v0, p0, Lcom/iflytek/voiceads/IFLYVideoAd;->iFLYVideoAdImpl:Lcom/iflytek/voiceads/IFLYVideoAd;

    invoke-virtual {v0, p1, p2}, Lcom/iflytek/voiceads/IFLYVideoAd;->setParameter(Ljava/lang/String;Ljava/lang/String;)V

    goto :goto_0
.end method

.method public setShowWifiTip(Z)V
    .locals 1
    .param p1, "showWifiTip"    # Z

    .prologue
    .line 134
    iget-object v0, p0, Lcom/iflytek/voiceads/IFLYVideoAd;->iFLYVideoAdImpl:Lcom/iflytek/voiceads/IFLYVideoAd;

    if-nez v0, :cond_0

    .line 135
    const-string v0, "can\'t find valided AdDex file in assets/"

    invoke-static {v0}, Lcom/iflytek/voiceads/dex/SDKLogger;->d(Ljava/lang/String;)V

    .line 139
    :goto_0
    return-void

    .line 138
    :cond_0
    iget-object v0, p0, Lcom/iflytek/voiceads/IFLYVideoAd;->iFLYVideoAdImpl:Lcom/iflytek/voiceads/IFLYVideoAd;

    invoke-virtual {v0, p1}, Lcom/iflytek/voiceads/IFLYVideoAd;->setShowWifiTip(Z)V

    goto :goto_0
.end method

.method public setSkipVisibility(I)V
    .locals 1
    .param p1, "visibility"    # I

    .prologue
    .line 126
    iget-object v0, p0, Lcom/iflytek/voiceads/IFLYVideoAd;->iFLYVideoAdImpl:Lcom/iflytek/voiceads/IFLYVideoAd;

    if-nez v0, :cond_0

    .line 127
    const-string v0, "can\'t find valided AdDex file in assets/"

    invoke-static {v0}, Lcom/iflytek/voiceads/dex/SDKLogger;->d(Ljava/lang/String;)V

    .line 131
    :goto_0
    return-void

    .line 130
    :cond_0
    iget-object v0, p0, Lcom/iflytek/voiceads/IFLYVideoAd;->iFLYVideoAdImpl:Lcom/iflytek/voiceads/IFLYVideoAd;

    invoke-virtual {v0, p1}, Lcom/iflytek/voiceads/IFLYVideoAd;->setSkipVisibility(I)V

    goto :goto_0
.end method

.method public varargs showAd(II[Ljava/lang/Object;)V
    .locals 1
    .param p1, "adPosition"    # I
    .param p2, "mediaPosition"    # I
    .param p3, "objects"    # [Ljava/lang/Object;

    .prologue
    .line 102
    iget-object v0, p0, Lcom/iflytek/voiceads/IFLYVideoAd;->iFLYVideoAdImpl:Lcom/iflytek/voiceads/IFLYVideoAd;

    if-nez v0, :cond_0

    .line 103
    const-string v0, "can\'t find valided AdDex file in assets/"

    invoke-static {v0}, Lcom/iflytek/voiceads/dex/SDKLogger;->d(Ljava/lang/String;)V

    .line 107
    :goto_0
    return-void

    .line 106
    :cond_0
    iget-object v0, p0, Lcom/iflytek/voiceads/IFLYVideoAd;->iFLYVideoAdImpl:Lcom/iflytek/voiceads/IFLYVideoAd;

    invoke-virtual {v0, p1, p2, p3}, Lcom/iflytek/voiceads/IFLYVideoAd;->showAd(II[Ljava/lang/Object;)V

    goto :goto_0
.end method

.method public startPlay()V
    .locals 1

    .prologue
    .line 110
    iget-object v0, p0, Lcom/iflytek/voiceads/IFLYVideoAd;->iFLYVideoAdImpl:Lcom/iflytek/voiceads/IFLYVideoAd;

    if-nez v0, :cond_0

    .line 111
    const-string v0, "can\'t find valided AdDex file in assets/"

    invoke-static {v0}, Lcom/iflytek/voiceads/dex/SDKLogger;->d(Ljava/lang/String;)V

    .line 115
    :goto_0
    return-void

    .line 114
    :cond_0
    iget-object v0, p0, Lcom/iflytek/voiceads/IFLYVideoAd;->iFLYVideoAdImpl:Lcom/iflytek/voiceads/IFLYVideoAd;

    invoke-virtual {v0}, Lcom/iflytek/voiceads/IFLYVideoAd;->startPlay()V

    goto :goto_0
.end method
