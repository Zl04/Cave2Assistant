.class public Lcom/umeng/commonsdk/proguard/d;
.super Ljava/lang/Object;
.source "UMInternalManager.java"


# direct methods
.method public constructor <init>()V
    .locals 0

    .prologue
    .line 36
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method

.method public static a()Lorg/json/JSONObject;
    .locals 4

    .prologue
    .line 666
    new-instance v0, Lorg/json/JSONObject;

    invoke-direct {v0}, Lorg/json/JSONObject;-><init>()V

    .line 668
    :try_start_0
    const-string v1, "f"

    invoke-static {}, Lcom/umeng/commonsdk/proguard/j;->c()J

    move-result-wide v2

    invoke-virtual {v0, v1, v2, v3}, Lorg/json/JSONObject;->put(Ljava/lang/String;J)Lorg/json/JSONObject;

    .line 669
    const-string v1, "t"

    invoke-static {}, Lcom/umeng/commonsdk/proguard/j;->d()J

    move-result-wide v2

    invoke-virtual {v0, v1, v2, v3}, Lorg/json/JSONObject;->put(Ljava/lang/String;J)Lorg/json/JSONObject;

    .line 670
    const-string v1, "ts"

    invoke-static {}, Ljava/lang/System;->currentTimeMillis()J

    move-result-wide v2

    invoke-virtual {v0, v1, v2, v3}, Lorg/json/JSONObject;->put(Ljava/lang/String;J)Lorg/json/JSONObject;
    :try_end_0
    .catch Ljava/lang/Exception; {:try_start_0 .. :try_end_0} :catch_0

    .line 673
    :goto_0
    return-object v0

    .line 672
    :catch_0
    move-exception v1

    goto :goto_0
.end method

.method public static a(Landroid/content/Context;)V
    .locals 4

    .prologue
    .line 43
    const-string v0, "walle"

    const/4 v1, 0x1

    new-array v1, v1, [Ljava/lang/Object;

    const/4 v2, 0x0

    const-string v3, "[internal] begin by stateful--->>>"

    aput-object v3, v1, v2

    invoke-static {v0, v1}, Lcom/umeng/commonsdk/statistics/common/e;->a(Ljava/lang/String;[Ljava/lang/Object;)V

    .line 45
    if-eqz p0, :cond_0

    .line 47
    :try_start_0
    sget-object v0, Lcom/umeng/commonsdk/framework/UMLogDataProtocol$UMBusinessType;->U_INTERNAL:Lcom/umeng/commonsdk/framework/UMLogDataProtocol$UMBusinessType;

    invoke-static {p0, v0}, Lcom/umeng/commonsdk/framework/UMEnvelopeBuild;->isReadyBuild(Landroid/content/Context;Lcom/umeng/commonsdk/framework/UMLogDataProtocol$UMBusinessType;)Z

    move-result v0

    if-eqz v0, :cond_0

    .line 48
    const v0, 0x8001

    .line 49
    invoke-static {p0}, Lcom/umeng/commonsdk/proguard/b;->a(Landroid/content/Context;)Lcom/umeng/commonsdk/proguard/b;

    move-result-object v1

    invoke-virtual {v1}, Lcom/umeng/commonsdk/proguard/b;->a()Lcom/umeng/commonsdk/proguard/c;

    move-result-object v1

    const/4 v2, 0x0

    .line 48
    invoke-static {p0, v0, v1, v2}, Lcom/umeng/commonsdk/framework/UMWorkDispatch;->sendEvent(Landroid/content/Context;ILcom/umeng/commonsdk/framework/UMLogDataProtocol;Ljava/lang/Object;)V
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_0

    .line 55
    :cond_0
    :goto_0
    return-void

    .line 51
    :catch_0
    move-exception v0

    .line 52
    invoke-static {p0, v0}, Lcom/umeng/commonsdk/proguard/e;->a(Landroid/content/Context;Ljava/lang/Throwable;)V

    goto :goto_0
.end method

.method private static a(Landroid/content/Context;Lorg/json/JSONObject;)V
    .locals 3

    .prologue
    .line 571
    if-eqz p0, :cond_1

    .line 572
    invoke-virtual {p0}, Landroid/content/Context;->getApplicationContext()Landroid/content/Context;

    move-result-object v0

    .line 573
    invoke-virtual {v0}, Landroid/content/Context;->getPackageManager()Landroid/content/pm/PackageManager;

    move-result-object v0

    .line 574
    if-eqz v0, :cond_1

    .line 575
    if-nez p1, :cond_0

    .line 576
    new-instance p1, Lorg/json/JSONObject;

    invoke-direct {p1}, Lorg/json/JSONObject;-><init>()V

    .line 578
    :cond_0
    const-string v1, "gp"

    const-string v2, "android.hardware.location.gps"

    invoke-virtual {v0, v2}, Landroid/content/pm/PackageManager;->hasSystemFeature(Ljava/lang/String;)Z

    move-result v2

    invoke-static {p1, v1, v2}, Lcom/umeng/commonsdk/proguard/d;->a(Lorg/json/JSONObject;Ljava/lang/String;Z)V

    .line 579
    const-string v1, "to"

    const-string v2, "android.hardware.touchscreen"

    invoke-virtual {v0, v2}, Landroid/content/pm/PackageManager;->hasSystemFeature(Ljava/lang/String;)Z

    move-result v2

    invoke-static {p1, v1, v2}, Lcom/umeng/commonsdk/proguard/d;->a(Lorg/json/JSONObject;Ljava/lang/String;Z)V

    .line 580
    const-string v1, "mo"

    const-string v2, "android.hardware.telephony"

    invoke-virtual {v0, v2}, Landroid/content/pm/PackageManager;->hasSystemFeature(Ljava/lang/String;)Z

    move-result v2

    invoke-static {p1, v1, v2}, Lcom/umeng/commonsdk/proguard/d;->a(Lorg/json/JSONObject;Ljava/lang/String;Z)V

    .line 581
    const-string v1, "ca"

    const-string v2, "android.hardware.camera"

    invoke-virtual {v0, v2}, Landroid/content/pm/PackageManager;->hasSystemFeature(Ljava/lang/String;)Z

    move-result v2

    invoke-static {p1, v1, v2}, Lcom/umeng/commonsdk/proguard/d;->a(Lorg/json/JSONObject;Ljava/lang/String;Z)V

    .line 582
    const-string v1, "fl"

    const-string v2, "android.hardware.camera.flash"

    invoke-virtual {v0, v2}, Landroid/content/pm/PackageManager;->hasSystemFeature(Ljava/lang/String;)Z

    move-result v0

    invoke-static {p1, v1, v0}, Lcom/umeng/commonsdk/proguard/d;->a(Lorg/json/JSONObject;Ljava/lang/String;Z)V

    .line 590
    :cond_1
    return-void
.end method

.method private static a(Lorg/json/JSONObject;Ljava/lang/String;Z)V
    .locals 1

    .prologue
    .line 593
    if-eqz p0, :cond_0

    invoke-static {p1}, Landroid/text/TextUtils;->isEmpty(Ljava/lang/CharSequence;)Z

    move-result v0

    if-nez v0, :cond_0

    .line 595
    if-eqz p2, :cond_1

    .line 596
    const/4 v0, 0x1

    :try_start_0
    invoke-virtual {p0, p1, v0}, Lorg/json/JSONObject;->put(Ljava/lang/String;I)Lorg/json/JSONObject;

    .line 602
    :cond_0
    :goto_0
    return-void

    .line 598
    :cond_1
    const/4 v0, 0x0

    invoke-virtual {p0, p1, v0}, Lorg/json/JSONObject;->put(Ljava/lang/String;I)Lorg/json/JSONObject;
    :try_end_0
    .catch Ljava/lang/Exception; {:try_start_0 .. :try_end_0} :catch_0

    goto :goto_0

    .line 600
    :catch_0
    move-exception v0

    goto :goto_0
.end method

.method public static b()Lorg/json/JSONObject;
    .locals 6

    .prologue
    const/16 v5, 0x15

    const/4 v0, 0x0

    .line 677
    new-instance v2, Lorg/json/JSONObject;

    invoke-direct {v2}, Lorg/json/JSONObject;-><init>()V

    .line 679
    :try_start_0
    const-string v1, "a_bl"

    sget-object v3, Landroid/os/Build;->BOOTLOADER:Ljava/lang/String;

    invoke-virtual {v2, v1, v3}, Lorg/json/JSONObject;->put(Ljava/lang/String;Ljava/lang/Object;)Lorg/json/JSONObject;

    .line 680
    sget v1, Landroid/os/Build$VERSION;->SDK_INT:I

    const/16 v3, 0xe

    if-lt v1, v3, :cond_0

    .line 681
    const-string v1, "a_rv"

    invoke-static {}, Landroid/os/Build;->getRadioVersion()Ljava/lang/String;

    move-result-object v3

    invoke-virtual {v2, v1, v3}, Lorg/json/JSONObject;->put(Ljava/lang/String;Ljava/lang/Object;)Lorg/json/JSONObject;

    .line 683
    :cond_0
    const-string v1, "a_fp"

    sget-object v3, Landroid/os/Build;->FINGERPRINT:Ljava/lang/String;

    invoke-virtual {v2, v1, v3}, Lorg/json/JSONObject;->put(Ljava/lang/String;Ljava/lang/Object;)Lorg/json/JSONObject;

    .line 684
    const-string v1, "a_hw"

    sget-object v3, Landroid/os/Build;->HARDWARE:Ljava/lang/String;

    invoke-virtual {v2, v1, v3}, Lorg/json/JSONObject;->put(Ljava/lang/String;Ljava/lang/Object;)Lorg/json/JSONObject;

    .line 685
    const-string v1, "a_host"

    sget-object v3, Landroid/os/Build;->HOST:Ljava/lang/String;

    invoke-virtual {v2, v1, v3}, Lorg/json/JSONObject;->put(Ljava/lang/String;Ljava/lang/Object;)Lorg/json/JSONObject;

    .line 686
    sget v1, Landroid/os/Build$VERSION;->SDK_INT:I

    if-lt v1, v5, :cond_2

    .line 687
    new-instance v3, Lorg/json/JSONArray;

    invoke-direct {v3}, Lorg/json/JSONArray;-><init>()V

    move v1, v0

    .line 688
    :goto_0
    sget-object v4, Landroid/os/Build;->SUPPORTED_32_BIT_ABIS:[Ljava/lang/String;

    array-length v4, v4

    if-ge v1, v4, :cond_1

    .line 689
    sget-object v4, Landroid/os/Build;->SUPPORTED_32_BIT_ABIS:[Ljava/lang/String;

    aget-object v4, v4, v1

    invoke-virtual {v3, v4}, Lorg/json/JSONArray;->put(Ljava/lang/Object;)Lorg/json/JSONArray;

    .line 688
    add-int/lit8 v1, v1, 0x1

    goto :goto_0

    .line 691
    :cond_1
    if-eqz v3, :cond_2

    invoke-virtual {v3}, Lorg/json/JSONArray;->length()I

    move-result v1

    if-lez v1, :cond_2

    .line 692
    const-string v1, "a_s32"

    invoke-virtual {v2, v1, v3}, Lorg/json/JSONObject;->put(Ljava/lang/String;Ljava/lang/Object;)Lorg/json/JSONObject;

    .line 695
    :cond_2
    sget v1, Landroid/os/Build$VERSION;->SDK_INT:I

    if-lt v1, v5, :cond_4

    .line 696
    new-instance v3, Lorg/json/JSONArray;

    invoke-direct {v3}, Lorg/json/JSONArray;-><init>()V

    move v1, v0

    .line 697
    :goto_1
    sget-object v4, Landroid/os/Build;->SUPPORTED_64_BIT_ABIS:[Ljava/lang/String;

    array-length v4, v4

    if-ge v1, v4, :cond_3

    .line 698
    sget-object v4, Landroid/os/Build;->SUPPORTED_64_BIT_ABIS:[Ljava/lang/String;

    aget-object v4, v4, v1

    invoke-virtual {v3, v4}, Lorg/json/JSONArray;->put(Ljava/lang/Object;)Lorg/json/JSONArray;

    .line 697
    add-int/lit8 v1, v1, 0x1

    goto :goto_1

    .line 700
    :cond_3
    if-eqz v3, :cond_4

    invoke-virtual {v3}, Lorg/json/JSONArray;->length()I

    move-result v1

    if-lez v1, :cond_4

    .line 701
    const-string v1, "a_s64"

    invoke-virtual {v2, v1, v3}, Lorg/json/JSONObject;->put(Ljava/lang/String;Ljava/lang/Object;)Lorg/json/JSONObject;

    .line 704
    :cond_4
    sget v1, Landroid/os/Build$VERSION;->SDK_INT:I

    if-lt v1, v5, :cond_6

    .line 705
    new-instance v1, Lorg/json/JSONArray;

    invoke-direct {v1}, Lorg/json/JSONArray;-><init>()V

    .line 706
    :goto_2
    sget-object v3, Landroid/os/Build;->SUPPORTED_ABIS:[Ljava/lang/String;

    array-length v3, v3

    if-ge v0, v3, :cond_5

    .line 707
    sget-object v3, Landroid/os/Build;->SUPPORTED_ABIS:[Ljava/lang/String;

    aget-object v3, v3, v0

    invoke-virtual {v1, v3}, Lorg/json/JSONArray;->put(Ljava/lang/Object;)Lorg/json/JSONArray;

    .line 706
    add-int/lit8 v0, v0, 0x1

    goto :goto_2

    .line 709
    :cond_5
    if-eqz v1, :cond_6

    invoke-virtual {v1}, Lorg/json/JSONArray;->length()I

    move-result v0

    if-lez v0, :cond_6

    .line 710
    const-string v0, "a_sa"

    invoke-virtual {v2, v0, v1}, Lorg/json/JSONObject;->put(Ljava/lang/String;Ljava/lang/Object;)Lorg/json/JSONObject;

    .line 713
    :cond_6
    const-string v0, "a_ta"

    sget-object v1, Landroid/os/Build;->TAGS:Ljava/lang/String;

    invoke-virtual {v2, v0, v1}, Lorg/json/JSONObject;->put(Ljava/lang/String;Ljava/lang/Object;)Lorg/json/JSONObject;

    .line 714
    const-string v0, "a_uk"

    const-string v1, "unknown"

    invoke-virtual {v2, v0, v1}, Lorg/json/JSONObject;->put(Ljava/lang/String;Ljava/lang/Object;)Lorg/json/JSONObject;

    .line 715
    const-string v0, "a_user"

    sget-object v1, Landroid/os/Build;->USER:Ljava/lang/String;

    invoke-virtual {v2, v0, v1}, Lorg/json/JSONObject;->put(Ljava/lang/String;Ljava/lang/Object;)Lorg/json/JSONObject;

    .line 716
    const-string v0, "a_cpu1"

    sget-object v1, Landroid/os/Build;->CPU_ABI:Ljava/lang/String;

    invoke-virtual {v2, v0, v1}, Lorg/json/JSONObject;->put(Ljava/lang/String;Ljava/lang/Object;)Lorg/json/JSONObject;

    .line 717
    const-string v0, "a_cpu2"

    sget-object v1, Landroid/os/Build;->CPU_ABI2:Ljava/lang/String;

    invoke-virtual {v2, v0, v1}, Lorg/json/JSONObject;->put(Ljava/lang/String;Ljava/lang/Object;)Lorg/json/JSONObject;

    .line 718
    const-string v0, "a_ra"

    sget-object v1, Landroid/os/Build;->RADIO:Ljava/lang/String;

    invoke-virtual {v2, v0, v1}, Lorg/json/JSONObject;->put(Ljava/lang/String;Ljava/lang/Object;)Lorg/json/JSONObject;

    .line 719
    sget v0, Landroid/os/Build$VERSION;->SDK_INT:I

    const/16 v1, 0x17

    if-lt v0, v1, :cond_7

    .line 720
    const-string v0, "a_bos"

    sget-object v1, Landroid/os/Build$VERSION;->BASE_OS:Ljava/lang/String;

    invoke-virtual {v2, v0, v1}, Lorg/json/JSONObject;->put(Ljava/lang/String;Ljava/lang/Object;)Lorg/json/JSONObject;

    .line 721
    const-string v0, "a_pre"

    sget v1, Landroid/os/Build$VERSION;->PREVIEW_SDK_INT:I

    invoke-virtual {v2, v0, v1}, Lorg/json/JSONObject;->put(Ljava/lang/String;I)Lorg/json/JSONObject;

    .line 722
    const-string v0, "a_sp"

    sget-object v1, Landroid/os/Build$VERSION;->SECURITY_PATCH:Ljava/lang/String;

    invoke-virtual {v2, v0, v1}, Lorg/json/JSONObject;->put(Ljava/lang/String;Ljava/lang/Object;)Lorg/json/JSONObject;

    .line 724
    :cond_7
    const-string v0, "a_cn"

    sget-object v1, Landroid/os/Build$VERSION;->CODENAME:Ljava/lang/String;

    invoke-virtual {v2, v0, v1}, Lorg/json/JSONObject;->put(Ljava/lang/String;Ljava/lang/Object;)Lorg/json/JSONObject;

    .line 725
    const-string v0, "a_intl"

    sget-object v1, Landroid/os/Build$VERSION;->INCREMENTAL:Ljava/lang/String;

    invoke-virtual {v2, v0, v1}, Lorg/json/JSONObject;->put(Ljava/lang/String;Ljava/lang/Object;)Lorg/json/JSONObject;
    :try_end_0
    .catch Ljava/lang/Exception; {:try_start_0 .. :try_end_0} :catch_0

    .line 729
    :goto_3
    return-object v2

    .line 726
    :catch_0
    move-exception v0

    goto :goto_3
.end method

.method public static b(Landroid/content/Context;)V
    .locals 8

    .prologue
    .line 62
    if-eqz p0, :cond_1

    .line 64
    :try_start_0
    const-string v0, "walle"

    const/4 v1, 0x1

    new-array v1, v1, [Ljava/lang/Object;

    const/4 v2, 0x0

    const-string v3, "[internal] begin by not stateful--->>>"

    aput-object v3, v1, v2

    invoke-static {v0, v1}, Lcom/umeng/commonsdk/statistics/common/e;->a(Ljava/lang/String;[Ljava/lang/Object;)V

    .line 65
    invoke-virtual {p0}, Landroid/content/Context;->getApplicationContext()Landroid/content/Context;

    move-result-object p0

    .line 66
    new-instance v1, Lcom/umeng/commonsdk/stateless/UMSLEnvelopeBuild;

    invoke-direct {v1}, Lcom/umeng/commonsdk/stateless/UMSLEnvelopeBuild;-><init>()V

    .line 67
    invoke-virtual {v1, p0}, Lcom/umeng/commonsdk/stateless/UMSLEnvelopeBuild;->buildSLBaseHeader(Landroid/content/Context;)Lorg/json/JSONObject;

    move-result-object v2

    .line 68
    if-eqz v2, :cond_0

    const-string v0, "header"

    invoke-virtual {v2, v0}, Lorg/json/JSONObject;->has(Ljava/lang/String;)Z
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_0

    move-result v0

    if-eqz v0, :cond_0

    .line 70
    :try_start_1
    const-string v0, "header"

    invoke-virtual {v2, v0}, Lorg/json/JSONObject;->opt(Ljava/lang/String;)Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Lorg/json/JSONObject;

    .line 71
    if-eqz v0, :cond_0

    .line 72
    const-string v3, "i_sdk_v"

    const-string v4, "1.2.0"

    invoke-virtual {v0, v3, v4}, Lorg/json/JSONObject;->put(Ljava/lang/String;Ljava/lang/Object;)Lorg/json/JSONObject;
    :try_end_1
    .catch Ljava/lang/Exception; {:try_start_1 .. :try_end_1} :catch_1
    .catch Ljava/lang/Throwable; {:try_start_1 .. :try_end_1} :catch_0

    .line 77
    :cond_0
    :goto_0
    :try_start_2
    const-string v0, "walle"

    const/4 v3, 0x1

    new-array v3, v3, [Ljava/lang/Object;

    const/4 v4, 0x0

    new-instance v5, Ljava/lang/StringBuilder;

    invoke-direct {v5}, Ljava/lang/StringBuilder;-><init>()V

    const-string v6, "[internal] header is "

    invoke-virtual {v5, v6}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v5

    invoke-virtual {v2}, Lorg/json/JSONObject;->toString()Ljava/lang/String;

    move-result-object v6

    invoke-virtual {v5, v6}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v5

    invoke-virtual {v5}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v5

    aput-object v5, v3, v4

    invoke-static {v0, v3}, Lcom/umeng/commonsdk/statistics/common/e;->a(Ljava/lang/String;[Ljava/lang/Object;)V

    .line 78
    invoke-static {p0}, Lcom/umeng/commonsdk/proguard/d;->c(Landroid/content/Context;)Lorg/json/JSONObject;

    move-result-object v0

    .line 79
    const-string v3, "walle"

    const/4 v4, 0x1

    new-array v4, v4, [Ljava/lang/Object;

    const/4 v5, 0x0

    new-instance v6, Ljava/lang/StringBuilder;

    invoke-direct {v6}, Ljava/lang/StringBuilder;-><init>()V

    const-string v7, "[internal] body is "

    invoke-virtual {v6, v7}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v6

    invoke-virtual {v0}, Lorg/json/JSONObject;->toString()Ljava/lang/String;

    move-result-object v7

    invoke-virtual {v6, v7}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v6

    invoke-virtual {v6}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v6

    aput-object v6, v4, v5

    invoke-static {v3, v4}, Lcom/umeng/commonsdk/statistics/common/e;->a(Ljava/lang/String;[Ljava/lang/Object;)V

    .line 80
    const-string v3, "umpx_internal"

    invoke-virtual {v1, p0, v2, v0, v3}, Lcom/umeng/commonsdk/stateless/UMSLEnvelopeBuild;->buildSLEnvelope(Landroid/content/Context;Lorg/json/JSONObject;Lorg/json/JSONObject;Ljava/lang/String;)Lorg/json/JSONObject;

    move-result-object v0

    .line 82
    const-string v1, "walle"

    const/4 v2, 0x1

    new-array v2, v2, [Ljava/lang/Object;

    const/4 v3, 0x0

    invoke-virtual {v0}, Lorg/json/JSONObject;->toString()Ljava/lang/String;

    move-result-object v0

    aput-object v0, v2, v3

    invoke-static {v1, v2}, Lcom/umeng/commonsdk/statistics/common/e;->a(Ljava/lang/String;[Ljava/lang/Object;)V
    :try_end_2
    .catch Ljava/lang/Throwable; {:try_start_2 .. :try_end_2} :catch_0

    .line 87
    :cond_1
    :goto_1
    return-void

    .line 83
    :catch_0
    move-exception v0

    .line 84
    invoke-static {p0, v0}, Lcom/umeng/commonsdk/proguard/e;->a(Landroid/content/Context;Ljava/lang/Throwable;)V

    goto :goto_1

    .line 74
    :catch_1
    move-exception v0

    goto :goto_0
.end method

.method private static b(Landroid/content/Context;Lorg/json/JSONObject;)V
    .locals 3

    .prologue
    .line 605
    if-eqz p0, :cond_3

    .line 606
    invoke-static {p0}, Lcom/umeng/commonsdk/proguard/t;->a(Landroid/content/Context;)Ljava/lang/String;

    move-result-object v0

    .line 607
    invoke-static {v0}, Landroid/text/TextUtils;->isEmpty(Ljava/lang/CharSequence;)Z

    move-result v1

    if-nez v1, :cond_3

    .line 609
    :try_start_0
    new-instance v1, Lorg/json/JSONObject;

    invoke-direct {v1, v0}, Lorg/json/JSONObject;-><init>(Ljava/lang/String;)V

    .line 610
    if-eqz v1, :cond_3

    .line 611
    if-nez p1, :cond_0

    .line 612
    new-instance p1, Lorg/json/JSONObject;

    invoke-direct {p1}, Lorg/json/JSONObject;-><init>()V

    .line 614
    :cond_0
    const-string v0, "_gdf_r"

    invoke-virtual {v1, v0}, Lorg/json/JSONObject;->has(Ljava/lang/String;)Z

    move-result v0

    if-eqz v0, :cond_1

    .line 615
    const-string v0, "_gdf_r"

    const-string v2, "_gdf_r"

    invoke-virtual {v1, v2}, Lorg/json/JSONObject;->opt(Ljava/lang/String;)Ljava/lang/Object;

    move-result-object v2

    invoke-virtual {p1, v0, v2}, Lorg/json/JSONObject;->put(Ljava/lang/String;Ljava/lang/Object;)Lorg/json/JSONObject;

    .line 617
    :cond_1
    const-string v0, "_thm_z"

    invoke-virtual {v1, v0}, Lorg/json/JSONObject;->has(Ljava/lang/String;)Z

    move-result v0

    if-eqz v0, :cond_2

    .line 618
    const-string v0, "_thm_z"

    const-string v2, "_thm_z"

    invoke-virtual {v1, v2}, Lorg/json/JSONObject;->opt(Ljava/lang/String;)Ljava/lang/Object;

    move-result-object v2

    invoke-virtual {p1, v0, v2}, Lorg/json/JSONObject;->put(Ljava/lang/String;Ljava/lang/Object;)Lorg/json/JSONObject;

    .line 620
    :cond_2
    const-string v0, "_dsk_s"

    invoke-virtual {v1, v0}, Lorg/json/JSONObject;->has(Ljava/lang/String;)Z

    move-result v0

    if-eqz v0, :cond_3

    .line 621
    const-string v0, "_dsk_s"

    const-string v2, "_dsk_s"

    invoke-virtual {v1, v2}, Lorg/json/JSONObject;->opt(Ljava/lang/String;)Ljava/lang/Object;

    move-result-object v1

    invoke-virtual {p1, v0, v1}, Lorg/json/JSONObject;->put(Ljava/lang/String;Ljava/lang/Object;)Lorg/json/JSONObject;
    :try_end_0
    .catch Ljava/lang/Exception; {:try_start_0 .. :try_end_0} :catch_0

    .line 627
    :cond_3
    :goto_0
    return-void

    .line 624
    :catch_0
    move-exception v0

    goto :goto_0
.end method

.method public static c(Landroid/content/Context;)Lorg/json/JSONObject;
    .locals 5

    .prologue
    .line 90
    new-instance v1, Lorg/json/JSONObject;

    invoke-direct {v1}, Lorg/json/JSONObject;-><init>()V

    .line 91
    new-instance v2, Lorg/json/JSONObject;

    invoke-direct {v2}, Lorg/json/JSONObject;-><init>()V

    .line 92
    if-eqz p0, :cond_3

    .line 93
    invoke-virtual {p0}, Landroid/content/Context;->getApplicationContext()Landroid/content/Context;

    move-result-object v3

    .line 97
    :try_start_0
    invoke-static {v3}, Lcom/umeng/commonsdk/proguard/d;->o(Landroid/content/Context;)Lorg/json/JSONArray;

    move-result-object v0

    .line 98
    if-eqz v0, :cond_0

    invoke-virtual {v0}, Lorg/json/JSONArray;->length()I

    move-result v4

    if-lez v4, :cond_0

    .line 99
    const-string v4, "run_server"

    invoke-virtual {v2, v4, v0}, Lorg/json/JSONObject;->put(Ljava/lang/String;Ljava/lang/Object;)Lorg/json/JSONObject;
    :try_end_0
    .catch Ljava/lang/Exception; {:try_start_0 .. :try_end_0} :catch_0

    .line 106
    :cond_0
    :goto_0
    :try_start_1
    invoke-static {v3}, Lcom/umeng/commonsdk/proguard/j;->k(Landroid/content/Context;)Ljava/lang/String;

    move-result-object v0

    .line 107
    invoke-static {v0}, Landroid/text/TextUtils;->isEmpty(Ljava/lang/CharSequence;)Z

    move-result v4

    if-nez v4, :cond_1

    .line 108
    const-string v4, "imsi"

    invoke-virtual {v2, v4, v0}, Lorg/json/JSONObject;->put(Ljava/lang/String;Ljava/lang/Object;)Lorg/json/JSONObject;
    :try_end_1
    .catch Ljava/lang/Exception; {:try_start_1 .. :try_end_1} :catch_2

    .line 125
    :cond_1
    :goto_1
    :try_start_2
    invoke-static {v3}, Lcom/umeng/commonsdk/proguard/j;->l(Landroid/content/Context;)Ljava/lang/String;

    move-result-object v0

    .line 126
    invoke-static {v0}, Landroid/text/TextUtils;->isEmpty(Ljava/lang/CharSequence;)Z

    move-result v4

    if-nez v4, :cond_2

    .line 127
    const-string v4, "meid"

    invoke-virtual {v2, v4, v0}, Lorg/json/JSONObject;->put(Ljava/lang/String;Ljava/lang/Object;)Lorg/json/JSONObject;
    :try_end_2
    .catch Ljava/lang/Exception; {:try_start_2 .. :try_end_2} :catch_3

    .line 135
    :cond_2
    :goto_2
    :try_start_3
    const-string v0, "internal"

    invoke-virtual {v1, v0, v2}, Lorg/json/JSONObject;->put(Ljava/lang/String;Ljava/lang/Object;)Lorg/json/JSONObject;
    :try_end_3
    .catch Lorg/json/JSONException; {:try_start_3 .. :try_end_3} :catch_4
    .catch Ljava/lang/Exception; {:try_start_3 .. :try_end_3} :catch_1

    .line 145
    :cond_3
    :goto_3
    return-object v1

    .line 101
    :catch_0
    move-exception v0

    .line 102
    :try_start_4
    invoke-static {v3, v0}, Lcom/umeng/commonsdk/proguard/e;->a(Landroid/content/Context;Ljava/lang/Throwable;)V

    goto :goto_0

    .line 140
    :catch_1
    move-exception v0

    goto :goto_3

    .line 110
    :catch_2
    move-exception v0

    .line 111
    invoke-static {v3, v0}, Lcom/umeng/commonsdk/proguard/e;->a(Landroid/content/Context;Ljava/lang/Throwable;)V

    goto :goto_1

    .line 130
    :catch_3
    move-exception v0

    .line 131
    invoke-static {v3, v0}, Lcom/umeng/commonsdk/proguard/e;->a(Landroid/content/Context;Ljava/lang/Throwable;)V

    goto :goto_2

    .line 136
    :catch_4
    move-exception v0

    .line 137
    invoke-static {v3, v0}, Lcom/umeng/commonsdk/proguard/e;->a(Landroid/content/Context;Ljava/lang/Throwable;)V
    :try_end_4
    .catch Ljava/lang/Exception; {:try_start_4 .. :try_end_4} :catch_1

    goto :goto_3
.end method

.method public static d(Landroid/content/Context;)Lorg/json/JSONObject;
    .locals 6

    .prologue
    .line 149
    new-instance v1, Lorg/json/JSONObject;

    invoke-direct {v1}, Lorg/json/JSONObject;-><init>()V

    .line 150
    new-instance v2, Lorg/json/JSONObject;

    invoke-direct {v2}, Lorg/json/JSONObject;-><init>()V

    .line 151
    if-eqz p0, :cond_11

    .line 152
    invoke-virtual {p0}, Landroid/content/Context;->getApplicationContext()Landroid/content/Context;

    move-result-object v3

    .line 164
    :try_start_0
    invoke-static {v3}, Lcom/umeng/commonsdk/proguard/d;->o(Landroid/content/Context;)Lorg/json/JSONArray;

    move-result-object v0

    .line 165
    if-eqz v0, :cond_0

    invoke-virtual {v0}, Lorg/json/JSONArray;->length()I

    move-result v4

    if-lez v4, :cond_0

    .line 166
    const-string v4, "rs"

    invoke-virtual {v2, v4, v0}, Lorg/json/JSONObject;->put(Ljava/lang/String;Ljava/lang/Object;)Lorg/json/JSONObject;
    :try_end_0
    .catch Ljava/lang/Exception; {:try_start_0 .. :try_end_0} :catch_0

    .line 180
    :cond_0
    :goto_0
    :try_start_1
    invoke-static {v3}, Lcom/umeng/commonsdk/proguard/d;->p(Landroid/content/Context;)Lorg/json/JSONArray;

    move-result-object v0

    .line 181
    if-eqz v0, :cond_1

    invoke-virtual {v0}, Lorg/json/JSONArray;->length()I

    move-result v4

    if-lez v4, :cond_1

    .line 182
    const-string v4, "bstn"

    invoke-virtual {v2, v4, v0}, Lorg/json/JSONObject;->put(Ljava/lang/String;Ljava/lang/Object;)Lorg/json/JSONObject;
    :try_end_1
    .catch Ljava/lang/Exception; {:try_start_1 .. :try_end_1} :catch_1

    .line 190
    :cond_1
    :goto_1
    :try_start_2
    invoke-static {v3}, Lcom/umeng/commonsdk/proguard/d;->q(Landroid/content/Context;)Lorg/json/JSONArray;

    move-result-object v0

    .line 191
    if-eqz v0, :cond_2

    invoke-virtual {v0}, Lorg/json/JSONArray;->length()I

    move-result v4

    if-lez v4, :cond_2

    .line 192
    const-string v4, "by"

    invoke-virtual {v2, v4, v0}, Lorg/json/JSONObject;->put(Ljava/lang/String;Ljava/lang/Object;)Lorg/json/JSONObject;
    :try_end_2
    .catch Ljava/lang/Exception; {:try_start_2 .. :try_end_2} :catch_2

    .line 207
    :cond_2
    :goto_2
    :try_start_3
    invoke-static {v3, v2}, Lcom/umeng/commonsdk/proguard/d;->a(Landroid/content/Context;Lorg/json/JSONObject;)V
    :try_end_3
    .catch Ljava/lang/Exception; {:try_start_3 .. :try_end_3} :catch_3

    .line 221
    :goto_3
    :try_start_4
    invoke-static {v3, v2}, Lcom/umeng/commonsdk/proguard/d;->b(Landroid/content/Context;Lorg/json/JSONObject;)V
    :try_end_4
    .catch Ljava/lang/Exception; {:try_start_4 .. :try_end_4} :catch_4

    .line 240
    :goto_4
    :try_start_5
    invoke-static {}, Lcom/umeng/commonsdk/proguard/d;->a()Lorg/json/JSONObject;

    move-result-object v0

    .line 241
    if-eqz v0, :cond_3

    invoke-virtual {v0}, Lorg/json/JSONObject;->length()I

    move-result v4

    if-lez v4, :cond_3

    .line 242
    const-string v4, "sd"

    invoke-virtual {v2, v4, v0}, Lorg/json/JSONObject;->put(Ljava/lang/String;Ljava/lang/Object;)Lorg/json/JSONObject;
    :try_end_5
    .catch Ljava/lang/Exception; {:try_start_5 .. :try_end_5} :catch_5

    .line 250
    :cond_3
    :goto_5
    :try_start_6
    invoke-static {}, Lcom/umeng/commonsdk/proguard/d;->b()Lorg/json/JSONObject;

    move-result-object v0

    .line 251
    if-eqz v0, :cond_4

    invoke-virtual {v0}, Lorg/json/JSONObject;->length()I

    move-result v4

    if-lez v4, :cond_4

    .line 252
    const-string v4, "build"

    invoke-virtual {v2, v4, v0}, Lorg/json/JSONObject;->put(Ljava/lang/String;Ljava/lang/Object;)Lorg/json/JSONObject;
    :try_end_6
    .catch Ljava/lang/Exception; {:try_start_6 .. :try_end_6} :catch_6

    .line 260
    :cond_4
    :goto_6
    :try_start_7
    new-instance v0, Lorg/json/JSONObject;

    invoke-direct {v0}, Lorg/json/JSONObject;-><init>()V

    .line 261
    invoke-static {v3}, Lcom/umeng/commonsdk/proguard/d;->f(Landroid/content/Context;)Lorg/json/JSONArray;

    move-result-object v4

    .line 262
    if-eqz v4, :cond_5

    invoke-virtual {v4}, Lorg/json/JSONArray;->length()I
    :try_end_7
    .catch Ljava/lang/Exception; {:try_start_7 .. :try_end_7} :catch_7

    move-result v5

    if-lez v5, :cond_5

    .line 264
    :try_start_8
    const-string v5, "a_sr"

    invoke-virtual {v0, v5, v4}, Lorg/json/JSONObject;->put(Ljava/lang/String;Ljava/lang/Object;)Lorg/json/JSONObject;
    :try_end_8
    .catch Lorg/json/JSONException; {:try_start_8 .. :try_end_8} :catch_15
    .catch Ljava/lang/Exception; {:try_start_8 .. :try_end_8} :catch_7

    .line 267
    :cond_5
    :goto_7
    :try_start_9
    invoke-static {v3}, Lcom/umeng/commonsdk/proguard/r;->c(Landroid/content/Context;)Lorg/json/JSONArray;

    move-result-object v4

    .line 268
    if-eqz v4, :cond_6

    invoke-virtual {v4}, Lorg/json/JSONArray;->length()I
    :try_end_9
    .catch Ljava/lang/Exception; {:try_start_9 .. :try_end_9} :catch_7

    move-result v5

    if-lez v5, :cond_6

    .line 270
    :try_start_a
    const-string v5, "stat"

    invoke-virtual {v0, v5, v4}, Lorg/json/JSONObject;->put(Ljava/lang/String;Ljava/lang/Object;)Lorg/json/JSONObject;
    :try_end_a
    .catch Lorg/json/JSONException; {:try_start_a .. :try_end_a} :catch_14
    .catch Ljava/lang/Exception; {:try_start_a .. :try_end_a} :catch_7

    .line 273
    :cond_6
    :goto_8
    :try_start_b
    const-string v4, "sr"

    invoke-virtual {v2, v4, v0}, Lorg/json/JSONObject;->put(Ljava/lang/String;Ljava/lang/Object;)Lorg/json/JSONObject;
    :try_end_b
    .catch Ljava/lang/Exception; {:try_start_b .. :try_end_b} :catch_7

    .line 280
    :goto_9
    :try_start_c
    invoke-static {v3}, Lcom/umeng/commonsdk/proguard/d;->g(Landroid/content/Context;)Lorg/json/JSONObject;

    move-result-object v0

    .line 281
    if-eqz v0, :cond_7

    invoke-virtual {v0}, Lorg/json/JSONObject;->length()I

    move-result v4

    if-lez v4, :cond_7

    .line 282
    const-string v4, "scr"

    invoke-virtual {v2, v4, v0}, Lorg/json/JSONObject;->put(Ljava/lang/String;Ljava/lang/Object;)Lorg/json/JSONObject;
    :try_end_c
    .catch Ljava/lang/Exception; {:try_start_c .. :try_end_c} :catch_8

    .line 290
    :cond_7
    :goto_a
    :try_start_d
    invoke-static {v3}, Lcom/umeng/commonsdk/proguard/d;->h(Landroid/content/Context;)Lorg/json/JSONObject;

    move-result-object v0

    .line 291
    if-eqz v0, :cond_8

    invoke-virtual {v0}, Lorg/json/JSONObject;->length()I

    move-result v4

    if-lez v4, :cond_8

    .line 292
    const-string v4, "sinfo"

    invoke-virtual {v2, v4, v0}, Lorg/json/JSONObject;->put(Ljava/lang/String;Ljava/lang/Object;)Lorg/json/JSONObject;
    :try_end_d
    .catch Ljava/lang/Exception; {:try_start_d .. :try_end_d} :catch_9

    .line 307
    :cond_8
    :goto_b
    :try_start_e
    new-instance v0, Lorg/json/JSONObject;

    invoke-direct {v0}, Lorg/json/JSONObject;-><init>()V

    .line 308
    invoke-static {v3}, Lcom/umeng/commonsdk/proguard/j;->e(Landroid/content/Context;)Lorg/json/JSONArray;

    move-result-object v4

    .line 309
    if-eqz v4, :cond_9

    invoke-virtual {v4}, Lorg/json/JSONArray;->length()I
    :try_end_e
    .catch Ljava/lang/Exception; {:try_start_e .. :try_end_e} :catch_a

    move-result v5

    if-lez v5, :cond_9

    .line 311
    :try_start_f
    const-string v5, "wl"

    invoke-virtual {v0, v5, v4}, Lorg/json/JSONObject;->put(Ljava/lang/String;Ljava/lang/Object;)Lorg/json/JSONObject;
    :try_end_f
    .catch Lorg/json/JSONException; {:try_start_f .. :try_end_f} :catch_13
    .catch Ljava/lang/Exception; {:try_start_f .. :try_end_f} :catch_a

    .line 314
    :cond_9
    :goto_c
    :try_start_10
    invoke-static {v3}, Lcom/umeng/commonsdk/proguard/d;->i(Landroid/content/Context;)Lorg/json/JSONArray;

    move-result-object v4

    .line 315
    if-eqz v4, :cond_a

    invoke-virtual {v4}, Lorg/json/JSONArray;->length()I
    :try_end_10
    .catch Ljava/lang/Exception; {:try_start_10 .. :try_end_10} :catch_a

    move-result v5

    if-lez v5, :cond_a

    .line 317
    :try_start_11
    const-string v5, "a_wls"

    invoke-virtual {v0, v5, v4}, Lorg/json/JSONObject;->put(Ljava/lang/String;Ljava/lang/Object;)Lorg/json/JSONObject;
    :try_end_11
    .catch Lorg/json/JSONException; {:try_start_11 .. :try_end_11} :catch_12
    .catch Ljava/lang/Exception; {:try_start_11 .. :try_end_11} :catch_a

    .line 320
    :cond_a
    :goto_d
    :try_start_12
    const-string v4, "winfo"

    invoke-virtual {v2, v4, v0}, Lorg/json/JSONObject;->put(Ljava/lang/String;Ljava/lang/Object;)Lorg/json/JSONObject;
    :try_end_12
    .catch Ljava/lang/Exception; {:try_start_12 .. :try_end_12} :catch_a

    .line 327
    :goto_e
    :try_start_13
    invoke-static {v3}, Lcom/umeng/commonsdk/proguard/d;->j(Landroid/content/Context;)Lorg/json/JSONArray;

    move-result-object v0

    .line 328
    if-eqz v0, :cond_b

    invoke-virtual {v0}, Lorg/json/JSONArray;->length()I

    move-result v4

    if-lez v4, :cond_b

    .line 329
    const-string v4, "input"

    invoke-virtual {v2, v4, v0}, Lorg/json/JSONObject;->put(Ljava/lang/String;Ljava/lang/Object;)Lorg/json/JSONObject;
    :try_end_13
    .catch Ljava/lang/Exception; {:try_start_13 .. :try_end_13} :catch_b

    .line 343
    :cond_b
    :goto_f
    :try_start_14
    invoke-static {v3}, Lcom/umeng/commonsdk/proguard/j;->o(Landroid/content/Context;)Lorg/json/JSONObject;

    move-result-object v0

    .line 344
    if-eqz v0, :cond_c

    invoke-virtual {v0}, Lorg/json/JSONObject;->length()I

    move-result v4

    if-lez v4, :cond_c

    .line 345
    const-string v4, "bt"

    invoke-virtual {v2, v4, v0}, Lorg/json/JSONObject;->put(Ljava/lang/String;Ljava/lang/Object;)Lorg/json/JSONObject;
    :try_end_14
    .catch Ljava/lang/Exception; {:try_start_14 .. :try_end_14} :catch_c

    .line 353
    :cond_c
    :goto_10
    :try_start_15
    invoke-static {v3}, Lcom/umeng/commonsdk/proguard/d;->k(Landroid/content/Context;)Lorg/json/JSONArray;

    move-result-object v0

    .line 354
    if-eqz v0, :cond_d

    invoke-virtual {v0}, Lorg/json/JSONArray;->length()I

    move-result v4

    if-lez v4, :cond_d

    .line 355
    const-string v4, "cam"

    invoke-virtual {v2, v4, v0}, Lorg/json/JSONObject;->put(Ljava/lang/String;Ljava/lang/Object;)Lorg/json/JSONObject;
    :try_end_15
    .catch Ljava/lang/Exception; {:try_start_15 .. :try_end_15} :catch_d

    .line 363
    :cond_d
    :goto_11
    :try_start_16
    invoke-static {v3}, Lcom/umeng/commonsdk/proguard/d;->l(Landroid/content/Context;)Lorg/json/JSONArray;

    move-result-object v0

    .line 364
    if-eqz v0, :cond_e

    invoke-virtual {v0}, Lorg/json/JSONArray;->length()I

    move-result v4

    if-lez v4, :cond_e

    .line 365
    const-string v4, "appls"

    invoke-virtual {v2, v4, v0}, Lorg/json/JSONObject;->put(Ljava/lang/String;Ljava/lang/Object;)Lorg/json/JSONObject;
    :try_end_16
    .catch Ljava/lang/Exception; {:try_start_16 .. :try_end_16} :catch_e

    .line 373
    :cond_e
    :goto_12
    :try_start_17
    invoke-static {v3}, Lcom/umeng/commonsdk/proguard/d;->m(Landroid/content/Context;)Lorg/json/JSONObject;

    move-result-object v0

    .line 374
    if-eqz v0, :cond_f

    invoke-virtual {v0}, Lorg/json/JSONObject;->length()I

    move-result v4

    if-lez v4, :cond_f

    .line 375
    const-string v4, "mem"

    invoke-virtual {v2, v4, v0}, Lorg/json/JSONObject;->put(Ljava/lang/String;Ljava/lang/Object;)Lorg/json/JSONObject;
    :try_end_17
    .catch Ljava/lang/Exception; {:try_start_17 .. :try_end_17} :catch_f

    .line 383
    :cond_f
    :goto_13
    :try_start_18
    invoke-static {v3}, Lcom/umeng/commonsdk/proguard/d;->n(Landroid/content/Context;)Lorg/json/JSONObject;

    move-result-object v0

    .line 384
    if-eqz v0, :cond_10

    invoke-virtual {v0}, Lorg/json/JSONObject;->length()I

    move-result v4

    if-lez v4, :cond_10

    .line 385
    const-string v4, "lbs"

    invoke-virtual {v2, v4, v0}, Lorg/json/JSONObject;->put(Ljava/lang/String;Ljava/lang/Object;)Lorg/json/JSONObject;
    :try_end_18
    .catch Ljava/lang/Exception; {:try_start_18 .. :try_end_18} :catch_10

    .line 392
    :cond_10
    :goto_14
    :try_start_19
    const-string v0, "inner"

    invoke-virtual {v1, v0, v2}, Lorg/json/JSONObject;->put(Ljava/lang/String;Ljava/lang/Object;)Lorg/json/JSONObject;
    :try_end_19
    .catch Lorg/json/JSONException; {:try_start_19 .. :try_end_19} :catch_11

    .line 398
    :cond_11
    :goto_15
    return-object v1

    .line 168
    :catch_0
    move-exception v0

    .line 169
    invoke-static {v3, v0}, Lcom/umeng/commonsdk/proguard/e;->a(Landroid/content/Context;Ljava/lang/Throwable;)V

    goto/16 :goto_0

    .line 184
    :catch_1
    move-exception v0

    .line 185
    invoke-static {v3, v0}, Lcom/umeng/commonsdk/proguard/e;->a(Landroid/content/Context;Ljava/lang/Throwable;)V

    goto/16 :goto_1

    .line 194
    :catch_2
    move-exception v0

    .line 195
    invoke-static {v3, v0}, Lcom/umeng/commonsdk/proguard/e;->a(Landroid/content/Context;Ljava/lang/Throwable;)V

    goto/16 :goto_2

    .line 208
    :catch_3
    move-exception v0

    .line 209
    invoke-static {v3, v0}, Lcom/umeng/commonsdk/proguard/e;->a(Landroid/content/Context;Ljava/lang/Throwable;)V

    goto/16 :goto_3

    .line 222
    :catch_4
    move-exception v0

    .line 223
    invoke-static {v3, v0}, Lcom/umeng/commonsdk/proguard/e;->a(Landroid/content/Context;Ljava/lang/Throwable;)V

    goto/16 :goto_4

    .line 244
    :catch_5
    move-exception v0

    .line 245
    invoke-static {v3, v0}, Lcom/umeng/commonsdk/proguard/e;->a(Landroid/content/Context;Ljava/lang/Throwable;)V

    goto/16 :goto_5

    .line 254
    :catch_6
    move-exception v0

    .line 255
    invoke-static {v3, v0}, Lcom/umeng/commonsdk/proguard/e;->a(Landroid/content/Context;Ljava/lang/Throwable;)V

    goto/16 :goto_6

    .line 274
    :catch_7
    move-exception v0

    .line 275
    invoke-static {v3, v0}, Lcom/umeng/commonsdk/proguard/e;->a(Landroid/content/Context;Ljava/lang/Throwable;)V

    goto/16 :goto_9

    .line 284
    :catch_8
    move-exception v0

    .line 285
    invoke-static {v3, v0}, Lcom/umeng/commonsdk/proguard/e;->a(Landroid/content/Context;Ljava/lang/Throwable;)V

    goto/16 :goto_a

    .line 294
    :catch_9
    move-exception v0

    .line 295
    invoke-static {v3, v0}, Lcom/umeng/commonsdk/proguard/e;->a(Landroid/content/Context;Ljava/lang/Throwable;)V

    goto/16 :goto_b

    .line 321
    :catch_a
    move-exception v0

    .line 322
    invoke-static {v3, v0}, Lcom/umeng/commonsdk/proguard/e;->a(Landroid/content/Context;Ljava/lang/Throwable;)V

    goto/16 :goto_e

    .line 331
    :catch_b
    move-exception v0

    .line 332
    invoke-static {v3, v0}, Lcom/umeng/commonsdk/proguard/e;->a(Landroid/content/Context;Ljava/lang/Throwable;)V

    goto/16 :goto_f

    .line 347
    :catch_c
    move-exception v0

    .line 348
    invoke-static {v3, v0}, Lcom/umeng/commonsdk/proguard/e;->a(Landroid/content/Context;Ljava/lang/Throwable;)V

    goto/16 :goto_10

    .line 357
    :catch_d
    move-exception v0

    .line 358
    invoke-static {v3, v0}, Lcom/umeng/commonsdk/proguard/e;->a(Landroid/content/Context;Ljava/lang/Throwable;)V

    goto/16 :goto_11

    .line 367
    :catch_e
    move-exception v0

    .line 368
    invoke-static {v3, v0}, Lcom/umeng/commonsdk/proguard/e;->a(Landroid/content/Context;Ljava/lang/Throwable;)V

    goto :goto_12

    .line 377
    :catch_f
    move-exception v0

    .line 378
    invoke-static {v3, v0}, Lcom/umeng/commonsdk/proguard/e;->a(Landroid/content/Context;Ljava/lang/Throwable;)V

    goto :goto_13

    .line 387
    :catch_10
    move-exception v0

    .line 388
    invoke-static {v3, v0}, Lcom/umeng/commonsdk/proguard/e;->a(Landroid/content/Context;Ljava/lang/Throwable;)V

    goto :goto_14

    .line 393
    :catch_11
    move-exception v0

    .line 394
    invoke-static {v3, v0}, Lcom/umeng/commonsdk/proguard/e;->a(Landroid/content/Context;Ljava/lang/Throwable;)V

    goto :goto_15

    .line 318
    :catch_12
    move-exception v4

    goto/16 :goto_d

    .line 312
    :catch_13
    move-exception v4

    goto/16 :goto_c

    .line 271
    :catch_14
    move-exception v4

    goto/16 :goto_8

    .line 265
    :catch_15
    move-exception v4

    goto/16 :goto_7
.end method

.method public static e(Landroid/content/Context;)Ljava/lang/String;
    .locals 3

    .prologue
    .line 631
    const/4 v1, 0x0

    .line 633
    :try_start_0
    invoke-static {p0}, Lcom/umeng/commonsdk/statistics/idtracking/e;->a(Landroid/content/Context;)Lcom/umeng/commonsdk/statistics/idtracking/e;

    move-result-object v0

    .line 634
    if-eqz v0, :cond_0

    .line 635
    invoke-virtual {v0}, Lcom/umeng/commonsdk/statistics/idtracking/e;->a()V

    .line 636
    invoke-virtual {v0}, Lcom/umeng/commonsdk/statistics/idtracking/e;->b()Lcom/umeng/commonsdk/statistics/proto/c;

    move-result-object v0

    .line 637
    new-instance v2, Lcom/umeng/commonsdk/proguard/aj;

    invoke-direct {v2}, Lcom/umeng/commonsdk/proguard/aj;-><init>()V

    invoke-virtual {v2, v0}, Lcom/umeng/commonsdk/proguard/aj;->a(Lcom/umeng/commonsdk/proguard/aa;)[B

    move-result-object v0

    .line 638
    const/4 v2, 0x0

    invoke-static {v0, v2}, Landroid/util/Base64;->encodeToString([BI)Ljava/lang/String;

    move-result-object v0

    .line 639
    invoke-static {v0}, Landroid/text/TextUtils;->isEmpty(Ljava/lang/CharSequence;)Z
    :try_end_0
    .catch Ljava/lang/Exception; {:try_start_0 .. :try_end_0} :catch_0

    move-result v2

    if-nez v2, :cond_0

    .line 647
    :goto_0
    return-object v0

    .line 643
    :catch_0
    move-exception v0

    .line 644
    invoke-static {p0, v0}, Lcom/umeng/commonsdk/proguard/e;->a(Landroid/content/Context;Ljava/lang/Throwable;)V

    :cond_0
    move-object v0, v1

    goto :goto_0
.end method

.method public static f(Landroid/content/Context;)Lorg/json/JSONArray;
    .locals 1

    .prologue
    .line 733
    const/4 v0, 0x0

    .line 734
    if-eqz p0, :cond_0

    .line 735
    invoke-virtual {p0}, Landroid/content/Context;->getApplicationContext()Landroid/content/Context;

    move-result-object v0

    .line 736
    invoke-static {v0}, Lcom/umeng/commonsdk/proguard/s;->g(Landroid/content/Context;)Lorg/json/JSONArray;

    move-result-object v0

    .line 738
    :cond_0
    return-object v0
.end method

.method public static g(Landroid/content/Context;)Lorg/json/JSONObject;
    .locals 6

    .prologue
    .line 742
    new-instance v1, Lorg/json/JSONObject;

    invoke-direct {v1}, Lorg/json/JSONObject;-><init>()V

    .line 743
    if-eqz p0, :cond_0

    .line 745
    :try_start_0
    const-string v0, "a_st_h"

    invoke-static {p0}, Lcom/umeng/commonsdk/proguard/j;->h(Landroid/content/Context;)I

    move-result v2

    invoke-virtual {v1, v0, v2}, Lorg/json/JSONObject;->put(Ljava/lang/String;I)Lorg/json/JSONObject;

    .line 746
    const-string v0, "a_nav_h"

    invoke-static {p0}, Lcom/umeng/commonsdk/proguard/j;->i(Landroid/content/Context;)I

    move-result v2

    invoke-virtual {v1, v0, v2}, Lorg/json/JSONObject;->put(Ljava/lang/String;I)Lorg/json/JSONObject;

    .line 747
    invoke-virtual {p0}, Landroid/content/Context;->getResources()Landroid/content/res/Resources;

    move-result-object v0

    if-eqz v0, :cond_0

    .line 748
    invoke-virtual {p0}, Landroid/content/Context;->getResources()Landroid/content/res/Resources;

    move-result-object v0

    invoke-virtual {v0}, Landroid/content/res/Resources;->getDisplayMetrics()Landroid/util/DisplayMetrics;

    move-result-object v0

    .line 749
    if-eqz v0, :cond_0

    .line 750
    const-string v2, "a_den"

    iget v3, v0, Landroid/util/DisplayMetrics;->density:F

    float-to-double v4, v3

    invoke-virtual {v1, v2, v4, v5}, Lorg/json/JSONObject;->put(Ljava/lang/String;D)Lorg/json/JSONObject;

    .line 751
    const-string v2, "a_dpi"

    iget v0, v0, Landroid/util/DisplayMetrics;->densityDpi:I

    invoke-virtual {v1, v2, v0}, Lorg/json/JSONObject;->put(Ljava/lang/String;I)Lorg/json/JSONObject;
    :try_end_0
    .catch Ljava/lang/Exception; {:try_start_0 .. :try_end_0} :catch_0

    .line 759
    :cond_0
    :goto_0
    return-object v1

    .line 754
    :catch_0
    move-exception v0

    .line 755
    invoke-static {p0, v0}, Lcom/umeng/commonsdk/proguard/e;->a(Landroid/content/Context;Ljava/lang/Throwable;)V

    goto :goto_0
.end method

.method public static h(Landroid/content/Context;)Lorg/json/JSONObject;
    .locals 6

    .prologue
    .line 763
    new-instance v1, Lorg/json/JSONObject;

    invoke-direct {v1}, Lorg/json/JSONObject;-><init>()V

    .line 764
    if-eqz p0, :cond_2

    .line 765
    invoke-virtual {p0}, Landroid/content/Context;->getApplicationContext()Landroid/content/Context;

    move-result-object v2

    .line 766
    invoke-virtual {v2}, Landroid/content/Context;->getPackageName()Ljava/lang/String;

    move-result-object v0

    .line 768
    :try_start_0
    const-string v3, "a_fit"

    .line 769
    invoke-static {v2, v0}, Lcom/umeng/commonsdk/proguard/j;->a(Landroid/content/Context;Ljava/lang/String;)J

    move-result-wide v4

    .line 768
    invoke-virtual {v1, v3, v4, v5}, Lorg/json/JSONObject;->put(Ljava/lang/String;J)Lorg/json/JSONObject;

    .line 770
    const-string v3, "a_alut"

    .line 771
    invoke-static {v2, v0}, Lcom/umeng/commonsdk/proguard/j;->b(Landroid/content/Context;Ljava/lang/String;)J

    move-result-wide v4

    .line 770
    invoke-virtual {v1, v3, v4, v5}, Lorg/json/JSONObject;->put(Ljava/lang/String;J)Lorg/json/JSONObject;

    .line 772
    const-string v3, "a_c"

    .line 773
    invoke-static {v2, v0}, Lcom/umeng/commonsdk/proguard/j;->c(Landroid/content/Context;Ljava/lang/String;)Ljava/lang/String;

    move-result-object v4

    .line 772
    invoke-virtual {v1, v3, v4}, Lorg/json/JSONObject;->put(Ljava/lang/String;Ljava/lang/Object;)Lorg/json/JSONObject;

    .line 774
    const-string v3, "a_uid"

    .line 775
    invoke-static {v2, v0}, Lcom/umeng/commonsdk/proguard/j;->d(Landroid/content/Context;Ljava/lang/String;)I

    move-result v0

    .line 774
    invoke-virtual {v1, v3, v0}, Lorg/json/JSONObject;->put(Ljava/lang/String;I)Lorg/json/JSONObject;

    .line 776
    invoke-static {}, Lcom/umeng/commonsdk/proguard/j;->a()Z

    move-result v0

    if-eqz v0, :cond_3

    .line 777
    const-string v0, "a_root"

    const/4 v3, 0x1

    invoke-virtual {v1, v0, v3}, Lorg/json/JSONObject;->put(Ljava/lang/String;I)Lorg/json/JSONObject;

    .line 781
    :goto_0
    const-string v0, "a_ua"

    invoke-static {v2}, Lcom/umeng/commonsdk/proguard/j;->s(Landroid/content/Context;)Ljava/lang/String;

    move-result-object v3

    invoke-virtual {v1, v0, v3}, Lorg/json/JSONObject;->put(Ljava/lang/String;Ljava/lang/Object;)Lorg/json/JSONObject;

    .line 782
    const-string v0, "tf"

    .line 783
    invoke-static {}, Lcom/umeng/commonsdk/proguard/j;->b()Ljava/lang/String;

    move-result-object v3

    .line 782
    invoke-virtual {v1, v0, v3}, Lorg/json/JSONObject;->put(Ljava/lang/String;Ljava/lang/Object;)Lorg/json/JSONObject;

    .line 784
    const-string v0, "s_fs"

    .line 785
    invoke-static {v2}, Lcom/umeng/commonsdk/proguard/j;->a(Landroid/content/Context;)F

    move-result v3

    float-to-double v4, v3

    .line 784
    invoke-virtual {v1, v0, v4, v5}, Lorg/json/JSONObject;->put(Ljava/lang/String;D)Lorg/json/JSONObject;

    .line 786
    const-string v0, "a_meid"

    .line 787
    invoke-static {v2}, Lcom/umeng/commonsdk/proguard/j;->l(Landroid/content/Context;)Ljava/lang/String;

    move-result-object v3

    .line 786
    invoke-virtual {v1, v0, v3}, Lorg/json/JSONObject;->put(Ljava/lang/String;Ljava/lang/Object;)Lorg/json/JSONObject;

    .line 788
    const-string v0, "a_imsi"

    .line 789
    invoke-static {v2}, Lcom/umeng/commonsdk/proguard/j;->k(Landroid/content/Context;)Ljava/lang/String;

    move-result-object v3

    .line 788
    invoke-virtual {v1, v0, v3}, Lorg/json/JSONObject;->put(Ljava/lang/String;Ljava/lang/Object;)Lorg/json/JSONObject;

    .line 790
    const-string v0, "st"

    .line 791
    invoke-static {}, Lcom/umeng/commonsdk/proguard/j;->f()J

    move-result-wide v4

    .line 790
    invoke-virtual {v1, v0, v4, v5}, Lorg/json/JSONObject;->put(Ljava/lang/String;J)Lorg/json/JSONObject;

    .line 792
    invoke-static {v2}, Lcom/umeng/commonsdk/proguard/s;->b(Landroid/content/Context;)Ljava/lang/String;

    move-result-object v0

    .line 793
    invoke-static {v0}, Landroid/text/TextUtils;->isEmpty(Ljava/lang/CharSequence;)Z
    :try_end_0
    .catch Ljava/lang/Exception; {:try_start_0 .. :try_end_0} :catch_0

    move-result v3

    if-nez v3, :cond_0

    .line 795
    :try_start_1
    const-string v3, "a_iccid"

    invoke-virtual {v1, v3, v0}, Lorg/json/JSONObject;->put(Ljava/lang/String;Ljava/lang/Object;)Lorg/json/JSONObject;
    :try_end_1
    .catch Ljava/lang/Exception; {:try_start_1 .. :try_end_1} :catch_2

    .line 798
    :cond_0
    :goto_1
    :try_start_2
    invoke-static {v2}, Lcom/umeng/commonsdk/proguard/s;->c(Landroid/content/Context;)Ljava/lang/String;

    move-result-object v0

    .line 799
    invoke-static {v0}, Landroid/text/TextUtils;->isEmpty(Ljava/lang/CharSequence;)Z
    :try_end_2
    .catch Ljava/lang/Exception; {:try_start_2 .. :try_end_2} :catch_0

    move-result v3

    if-nez v3, :cond_1

    .line 801
    :try_start_3
    const-string v3, "a_simei"

    invoke-virtual {v1, v3, v0}, Lorg/json/JSONObject;->put(Ljava/lang/String;Ljava/lang/Object;)Lorg/json/JSONObject;
    :try_end_3
    .catch Ljava/lang/Exception; {:try_start_3 .. :try_end_3} :catch_1

    .line 804
    :cond_1
    :goto_2
    :try_start_4
    const-string v0, "hn"

    invoke-static {}, Lcom/umeng/commonsdk/proguard/j;->g()Ljava/lang/String;

    move-result-object v3

    invoke-virtual {v1, v0, v3}, Lorg/json/JSONObject;->put(Ljava/lang/String;Ljava/lang/Object;)Lorg/json/JSONObject;

    .line 805
    const-string v0, "ts"

    invoke-static {}, Ljava/lang/System;->currentTimeMillis()J

    move-result-wide v4

    invoke-virtual {v1, v0, v4, v5}, Lorg/json/JSONObject;->put(Ljava/lang/String;J)Lorg/json/JSONObject;

    .line 810
    :cond_2
    :goto_3
    return-object v1

    .line 779
    :cond_3
    const-string v0, "a_root"

    const/4 v3, 0x0

    invoke-virtual {v1, v0, v3}, Lorg/json/JSONObject;->put(Ljava/lang/String;I)Lorg/json/JSONObject;
    :try_end_4
    .catch Ljava/lang/Exception; {:try_start_4 .. :try_end_4} :catch_0

    goto :goto_0

    .line 806
    :catch_0
    move-exception v0

    .line 807
    invoke-static {v2, v0}, Lcom/umeng/commonsdk/proguard/e;->a(Landroid/content/Context;Ljava/lang/Throwable;)V

    goto :goto_3

    .line 802
    :catch_1
    move-exception v0

    goto :goto_2

    .line 796
    :catch_2
    move-exception v0

    goto :goto_1
.end method

.method public static i(Landroid/content/Context;)Lorg/json/JSONArray;
    .locals 8

    .prologue
    .line 841
    new-instance v1, Lorg/json/JSONArray;

    invoke-direct {v1}, Lorg/json/JSONArray;-><init>()V

    .line 843
    if-eqz p0, :cond_4

    .line 844
    invoke-virtual {p0}, Landroid/content/Context;->getApplicationContext()Landroid/content/Context;

    move-result-object v2

    .line 845
    invoke-static {v2}, Lcom/umeng/commonsdk/proguard/j;->b(Landroid/content/Context;)Ljava/util/List;

    move-result-object v0

    .line 846
    if-eqz v0, :cond_4

    invoke-interface {v0}, Ljava/util/List;->size()I

    move-result v3

    if-lez v3, :cond_4

    .line 847
    invoke-interface {v0}, Ljava/util/List;->iterator()Ljava/util/Iterator;

    move-result-object v3

    :cond_0
    :goto_0
    invoke-interface {v3}, Ljava/util/Iterator;->hasNext()Z

    move-result v0

    if-eqz v0, :cond_4

    invoke-interface {v3}, Ljava/util/Iterator;->next()Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Landroid/net/wifi/ScanResult;

    .line 849
    :try_start_0
    new-instance v4, Lorg/json/JSONObject;

    invoke-direct {v4}, Lorg/json/JSONObject;-><init>()V

    .line 850
    const-string v5, "a_bssid"

    iget-object v6, v0, Landroid/net/wifi/ScanResult;->BSSID:Ljava/lang/String;

    invoke-virtual {v4, v5, v6}, Lorg/json/JSONObject;->put(Ljava/lang/String;Ljava/lang/Object;)Lorg/json/JSONObject;

    .line 851
    const-string v5, "a_ssid"

    iget-object v6, v0, Landroid/net/wifi/ScanResult;->BSSID:Ljava/lang/String;

    invoke-virtual {v4, v5, v6}, Lorg/json/JSONObject;->put(Ljava/lang/String;Ljava/lang/Object;)Lorg/json/JSONObject;

    .line 852
    const-string v5, "a_cap"

    iget-object v6, v0, Landroid/net/wifi/ScanResult;->capabilities:Ljava/lang/String;

    invoke-virtual {v4, v5, v6}, Lorg/json/JSONObject;->put(Ljava/lang/String;Ljava/lang/Object;)Lorg/json/JSONObject;

    .line 853
    const-string v5, "a_fcy"

    iget v6, v0, Landroid/net/wifi/ScanResult;->frequency:I

    invoke-virtual {v4, v5, v6}, Lorg/json/JSONObject;->put(Ljava/lang/String;I)Lorg/json/JSONObject;

    .line 854
    const-string v5, "ts"

    invoke-static {}, Ljava/lang/System;->currentTimeMillis()J

    move-result-wide v6

    invoke-virtual {v4, v5, v6, v7}, Lorg/json/JSONObject;->put(Ljava/lang/String;J)Lorg/json/JSONObject;

    .line 856
    sget v5, Landroid/os/Build$VERSION;->SDK_INT:I

    const/16 v6, 0x17

    if-lt v5, v6, :cond_1

    .line 857
    const-string v5, "a_c0"

    iget v6, v0, Landroid/net/wifi/ScanResult;->centerFreq0:I

    invoke-virtual {v4, v5, v6}, Lorg/json/JSONObject;->put(Ljava/lang/String;I)Lorg/json/JSONObject;

    .line 858
    const-string v5, "a_c1"

    iget v6, v0, Landroid/net/wifi/ScanResult;->centerFreq1:I

    invoke-virtual {v4, v5, v6}, Lorg/json/JSONObject;->put(Ljava/lang/String;I)Lorg/json/JSONObject;

    .line 859
    const-string v5, "a_cw"

    iget v6, v0, Landroid/net/wifi/ScanResult;->channelWidth:I

    invoke-virtual {v4, v5, v6}, Lorg/json/JSONObject;->put(Ljava/lang/String;I)Lorg/json/JSONObject;

    .line 860
    invoke-virtual {v0}, Landroid/net/wifi/ScanResult;->is80211mcResponder()Z

    move-result v5

    if-eqz v5, :cond_2

    .line 861
    const-string v5, "a_is80211"

    const/4 v6, 0x1

    invoke-virtual {v4, v5, v6}, Lorg/json/JSONObject;->put(Ljava/lang/String;I)Lorg/json/JSONObject;

    .line 865
    :goto_1
    invoke-virtual {v0}, Landroid/net/wifi/ScanResult;->isPasspointNetwork()Z

    move-result v5

    if-eqz v5, :cond_3

    .line 866
    const-string v5, "a_isppn"

    const/4 v6, 0x1

    invoke-virtual {v4, v5, v6}, Lorg/json/JSONObject;->put(Ljava/lang/String;I)Lorg/json/JSONObject;

    .line 870
    :goto_2
    const-string v5, "a_ofn"

    iget-object v6, v0, Landroid/net/wifi/ScanResult;->operatorFriendlyName:Ljava/lang/CharSequence;

    invoke-virtual {v4, v5, v6}, Lorg/json/JSONObject;->put(Ljava/lang/String;Ljava/lang/Object;)Lorg/json/JSONObject;

    .line 871
    const-string v5, "a_vn"

    iget-object v6, v0, Landroid/net/wifi/ScanResult;->venueName:Ljava/lang/CharSequence;

    invoke-virtual {v4, v5, v6}, Lorg/json/JSONObject;->put(Ljava/lang/String;Ljava/lang/Object;)Lorg/json/JSONObject;

    .line 874
    :cond_1
    const-string v5, "a_dc"

    invoke-virtual {v0}, Landroid/net/wifi/ScanResult;->describeContents()I

    move-result v0

    invoke-virtual {v4, v5, v0}, Lorg/json/JSONObject;->put(Ljava/lang/String;I)Lorg/json/JSONObject;

    .line 878
    if-eqz v4, :cond_0

    .line 879
    invoke-virtual {v1, v4}, Lorg/json/JSONArray;->put(Ljava/lang/Object;)Lorg/json/JSONArray;
    :try_end_0
    .catch Ljava/lang/Exception; {:try_start_0 .. :try_end_0} :catch_0

    goto/16 :goto_0

    .line 881
    :catch_0
    move-exception v0

    .line 882
    invoke-static {v2, v0}, Lcom/umeng/commonsdk/proguard/e;->a(Landroid/content/Context;Ljava/lang/Throwable;)V

    goto/16 :goto_0

    .line 863
    :cond_2
    :try_start_1
    const-string v5, "a_is80211"

    const/4 v6, 0x0

    invoke-virtual {v4, v5, v6}, Lorg/json/JSONObject;->put(Ljava/lang/String;I)Lorg/json/JSONObject;

    goto :goto_1

    .line 868
    :cond_3
    const-string v5, "a_isppn"

    const/4 v6, 0x0

    invoke-virtual {v4, v5, v6}, Lorg/json/JSONObject;->put(Ljava/lang/String;I)Lorg/json/JSONObject;
    :try_end_1
    .catch Ljava/lang/Exception; {:try_start_1 .. :try_end_1} :catch_0

    goto :goto_2

    .line 888
    :cond_4
    return-object v1
.end method

.method public static j(Landroid/content/Context;)Lorg/json/JSONArray;
    .locals 8

    .prologue
    .line 892
    new-instance v1, Lorg/json/JSONArray;

    invoke-direct {v1}, Lorg/json/JSONArray;-><init>()V

    .line 894
    if-eqz p0, :cond_1

    .line 895
    invoke-virtual {p0}, Landroid/content/Context;->getApplicationContext()Landroid/content/Context;

    move-result-object v2

    .line 896
    invoke-static {v2}, Lcom/umeng/commonsdk/proguard/j;->m(Landroid/content/Context;)Ljava/util/List;

    move-result-object v0

    .line 897
    if-eqz v0, :cond_1

    .line 898
    invoke-interface {v0}, Ljava/util/List;->iterator()Ljava/util/Iterator;

    move-result-object v3

    :cond_0
    :goto_0
    invoke-interface {v3}, Ljava/util/Iterator;->hasNext()Z

    move-result v0

    if-eqz v0, :cond_1

    invoke-interface {v3}, Ljava/util/Iterator;->next()Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Landroid/view/inputmethod/InputMethodInfo;

    .line 900
    :try_start_0
    invoke-virtual {v2}, Landroid/content/Context;->getPackageManager()Landroid/content/pm/PackageManager;

    move-result-object v4

    invoke-virtual {v0, v4}, Landroid/view/inputmethod/InputMethodInfo;->loadLabel(Landroid/content/pm/PackageManager;)Ljava/lang/CharSequence;

    move-result-object v4

    .line 901
    new-instance v5, Lorg/json/JSONObject;

    invoke-direct {v5}, Lorg/json/JSONObject;-><init>()V

    .line 902
    const-string v6, "a_la"

    invoke-virtual {v5, v6, v4}, Lorg/json/JSONObject;->put(Ljava/lang/String;Ljava/lang/Object;)Lorg/json/JSONObject;

    .line 903
    const-string v4, "a_pn"

    invoke-virtual {v0}, Landroid/view/inputmethod/InputMethodInfo;->getPackageName()Ljava/lang/String;

    move-result-object v0

    invoke-virtual {v5, v4, v0}, Lorg/json/JSONObject;->put(Ljava/lang/String;Ljava/lang/Object;)Lorg/json/JSONObject;

    .line 904
    const-string v0, "ts"

    invoke-static {}, Ljava/lang/System;->currentTimeMillis()J

    move-result-wide v6

    invoke-virtual {v5, v0, v6, v7}, Lorg/json/JSONObject;->put(Ljava/lang/String;J)Lorg/json/JSONObject;

    .line 905
    if-eqz v5, :cond_0

    .line 906
    invoke-virtual {v1, v5}, Lorg/json/JSONArray;->put(Ljava/lang/Object;)Lorg/json/JSONArray;
    :try_end_0
    .catch Ljava/lang/Exception; {:try_start_0 .. :try_end_0} :catch_0

    goto :goto_0

    .line 908
    :catch_0
    move-exception v0

    .line 909
    invoke-static {v2, v0}, Lcom/umeng/commonsdk/proguard/e;->a(Landroid/content/Context;Ljava/lang/Throwable;)V

    goto :goto_0

    .line 914
    :cond_1
    return-object v1
.end method

.method public static k(Landroid/content/Context;)Lorg/json/JSONArray;
    .locals 8

    .prologue
    .line 935
    new-instance v1, Lorg/json/JSONArray;

    invoke-direct {v1}, Lorg/json/JSONArray;-><init>()V

    .line 937
    if-eqz p0, :cond_1

    .line 938
    invoke-virtual {p0}, Landroid/content/Context;->getApplicationContext()Landroid/content/Context;

    move-result-object v2

    .line 939
    invoke-static {v2}, Lcom/umeng/commonsdk/proguard/r;->e(Landroid/content/Context;)Ljava/util/List;

    move-result-object v0

    .line 940
    if-eqz v0, :cond_1

    invoke-interface {v0}, Ljava/util/List;->isEmpty()Z

    move-result v3

    if-nez v3, :cond_1

    .line 941
    invoke-interface {v0}, Ljava/util/List;->iterator()Ljava/util/Iterator;

    move-result-object v3

    :cond_0
    :goto_0
    invoke-interface {v3}, Ljava/util/Iterator;->hasNext()Z

    move-result v0

    if-eqz v0, :cond_1

    invoke-interface {v3}, Ljava/util/Iterator;->next()Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Lcom/umeng/commonsdk/proguard/r$a;

    .line 942
    if-eqz v0, :cond_0

    .line 944
    :try_start_0
    new-instance v4, Lorg/json/JSONObject;

    invoke-direct {v4}, Lorg/json/JSONObject;-><init>()V

    .line 945
    const-string v5, "a_w"

    iget v6, v0, Lcom/umeng/commonsdk/proguard/r$a;->a:I

    invoke-virtual {v4, v5, v6}, Lorg/json/JSONObject;->put(Ljava/lang/String;I)Lorg/json/JSONObject;

    .line 946
    const-string v5, "a_h"

    iget v0, v0, Lcom/umeng/commonsdk/proguard/r$a;->b:I

    invoke-virtual {v4, v5, v0}, Lorg/json/JSONObject;->put(Ljava/lang/String;I)Lorg/json/JSONObject;

    .line 947
    const-string v0, "ts"

    invoke-static {}, Ljava/lang/System;->currentTimeMillis()J

    move-result-wide v6

    invoke-virtual {v4, v0, v6, v7}, Lorg/json/JSONObject;->put(Ljava/lang/String;J)Lorg/json/JSONObject;

    .line 948
    if-eqz v4, :cond_0

    .line 949
    invoke-virtual {v1, v4}, Lorg/json/JSONArray;->put(Ljava/lang/Object;)Lorg/json/JSONArray;
    :try_end_0
    .catch Ljava/lang/Exception; {:try_start_0 .. :try_end_0} :catch_0

    goto :goto_0

    .line 951
    :catch_0
    move-exception v0

    .line 952
    invoke-static {v2, v0}, Lcom/umeng/commonsdk/proguard/e;->a(Landroid/content/Context;Ljava/lang/Throwable;)V

    goto :goto_0

    .line 958
    :cond_1
    return-object v1
.end method

.method public static l(Landroid/content/Context;)Lorg/json/JSONArray;
    .locals 8

    .prologue
    .line 962
    new-instance v1, Lorg/json/JSONArray;

    invoke-direct {v1}, Lorg/json/JSONArray;-><init>()V

    .line 964
    if-eqz p0, :cond_1

    .line 965
    invoke-virtual {p0}, Landroid/content/Context;->getApplicationContext()Landroid/content/Context;

    move-result-object v2

    .line 966
    invoke-static {v2}, Lcom/umeng/commonsdk/proguard/j;->p(Landroid/content/Context;)Ljava/util/List;

    move-result-object v0

    .line 967
    if-eqz v0, :cond_1

    invoke-interface {v0}, Ljava/util/List;->isEmpty()Z

    move-result v3

    if-nez v3, :cond_1

    .line 968
    invoke-interface {v0}, Ljava/util/List;->iterator()Ljava/util/Iterator;

    move-result-object v3

    :cond_0
    :goto_0
    invoke-interface {v3}, Ljava/util/Iterator;->hasNext()Z

    move-result v0

    if-eqz v0, :cond_1

    invoke-interface {v3}, Ljava/util/Iterator;->next()Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Lcom/umeng/commonsdk/proguard/j$a;

    .line 969
    if-eqz v0, :cond_0

    .line 971
    :try_start_0
    new-instance v4, Lorg/json/JSONObject;

    invoke-direct {v4}, Lorg/json/JSONObject;-><init>()V

    .line 972
    const-string v5, "a_pn"

    iget-object v6, v0, Lcom/umeng/commonsdk/proguard/j$a;->a:Ljava/lang/String;

    invoke-virtual {v4, v5, v6}, Lorg/json/JSONObject;->put(Ljava/lang/String;Ljava/lang/Object;)Lorg/json/JSONObject;

    .line 973
    const-string v5, "a_la"

    iget-object v0, v0, Lcom/umeng/commonsdk/proguard/j$a;->b:Ljava/lang/String;

    invoke-virtual {v4, v5, v0}, Lorg/json/JSONObject;->put(Ljava/lang/String;Ljava/lang/Object;)Lorg/json/JSONObject;

    .line 974
    const-string v0, "ts"

    invoke-static {}, Ljava/lang/System;->currentTimeMillis()J

    move-result-wide v6

    invoke-virtual {v4, v0, v6, v7}, Lorg/json/JSONObject;->put(Ljava/lang/String;J)Lorg/json/JSONObject;

    .line 975
    if-eqz v4, :cond_0

    .line 976
    invoke-virtual {v1, v4}, Lorg/json/JSONArray;->put(Ljava/lang/Object;)Lorg/json/JSONArray;
    :try_end_0
    .catch Ljava/lang/Exception; {:try_start_0 .. :try_end_0} :catch_0

    goto :goto_0

    .line 978
    :catch_0
    move-exception v0

    .line 979
    invoke-static {v2, v0}, Lcom/umeng/commonsdk/proguard/e;->a(Landroid/content/Context;Ljava/lang/Throwable;)V

    goto :goto_0

    .line 986
    :cond_1
    return-object v1
.end method

.method public static m(Landroid/content/Context;)Lorg/json/JSONObject;
    .locals 6

    .prologue
    .line 990
    new-instance v1, Lorg/json/JSONObject;

    invoke-direct {v1}, Lorg/json/JSONObject;-><init>()V

    .line 991
    if-eqz p0, :cond_1

    .line 992
    invoke-virtual {p0}, Landroid/content/Context;->getApplicationContext()Landroid/content/Context;

    move-result-object v2

    .line 993
    invoke-static {v2}, Lcom/umeng/commonsdk/proguard/j;->q(Landroid/content/Context;)Landroid/app/ActivityManager$MemoryInfo;

    move-result-object v0

    .line 994
    if-eqz v0, :cond_1

    .line 996
    :try_start_0
    sget v3, Landroid/os/Build$VERSION;->SDK_INT:I

    const/16 v4, 0x10

    if-lt v3, v4, :cond_0

    .line 997
    const-string v3, "t"

    iget-wide v4, v0, Landroid/app/ActivityManager$MemoryInfo;->totalMem:J

    invoke-virtual {v1, v3, v4, v5}, Lorg/json/JSONObject;->put(Ljava/lang/String;J)Lorg/json/JSONObject;

    .line 999
    :cond_0
    const-string v3, "f"

    iget-wide v4, v0, Landroid/app/ActivityManager$MemoryInfo;->availMem:J

    invoke-virtual {v1, v3, v4, v5}, Lorg/json/JSONObject;->put(Ljava/lang/String;J)Lorg/json/JSONObject;

    .line 1000
    const-string v0, "ts"

    invoke-static {}, Ljava/lang/System;->currentTimeMillis()J

    move-result-wide v4

    invoke-virtual {v1, v0, v4, v5}, Lorg/json/JSONObject;->put(Ljava/lang/String;J)Lorg/json/JSONObject;
    :try_end_0
    .catch Ljava/lang/Exception; {:try_start_0 .. :try_end_0} :catch_0

    .line 1006
    :cond_1
    :goto_0
    return-object v1

    .line 1001
    :catch_0
    move-exception v0

    .line 1002
    invoke-static {v2, v0}, Lcom/umeng/commonsdk/proguard/e;->a(Landroid/content/Context;Ljava/lang/Throwable;)V

    goto :goto_0
.end method

.method private static n(Landroid/content/Context;)Lorg/json/JSONObject;
    .locals 1

    .prologue
    .line 402
    const/4 v0, 0x0

    .line 403
    if-eqz p0, :cond_0

    .line 404
    invoke-virtual {p0}, Landroid/content/Context;->getApplicationContext()Landroid/content/Context;

    move-result-object v0

    .line 405
    invoke-static {v0}, Lcom/umeng/commonsdk/proguard/h;->b(Landroid/content/Context;)Lorg/json/JSONObject;

    move-result-object v0

    .line 407
    :cond_0
    return-object v0
.end method

.method private static o(Landroid/content/Context;)Lorg/json/JSONArray;
    .locals 7

    .prologue
    .line 412
    const/4 v1, 0x0

    .line 414
    if-eqz p0, :cond_1

    .line 415
    :try_start_0
    invoke-virtual {p0}, Landroid/content/Context;->getApplicationContext()Landroid/content/Context;

    move-result-object v0

    const-string v2, "activity"

    .line 416
    invoke-virtual {v0, v2}, Landroid/content/Context;->getSystemService(Ljava/lang/String;)Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Landroid/app/ActivityManager;

    .line 417
    if-eqz v0, :cond_1

    .line 418
    const v2, 0x7fffffff

    invoke-virtual {v0, v2}, Landroid/app/ActivityManager;->getRunningServices(I)Ljava/util/List;

    move-result-object v3

    .line 419
    if-eqz v3, :cond_1

    invoke-interface {v3}, Ljava/util/List;->isEmpty()Z

    move-result v0

    if-nez v0, :cond_1

    .line 422
    const/4 v0, 0x0

    move v2, v0

    :goto_0
    invoke-interface {v3}, Ljava/util/List;->size()I

    move-result v0

    if-ge v2, v0, :cond_0

    .line 423
    invoke-interface {v3, v2}, Ljava/util/List;->get(I)Ljava/lang/Object;

    move-result-object v0

    if-eqz v0, :cond_3

    invoke-interface {v3, v2}, Ljava/util/List;->get(I)Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Landroid/app/ActivityManager$RunningServiceInfo;

    iget-object v0, v0, Landroid/app/ActivityManager$RunningServiceInfo;->service:Landroid/content/ComponentName;

    if-eqz v0, :cond_3

    invoke-interface {v3, v2}, Ljava/util/List;->get(I)Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Landroid/app/ActivityManager$RunningServiceInfo;

    iget-object v0, v0, Landroid/app/ActivityManager$RunningServiceInfo;->service:Landroid/content/ComponentName;

    invoke-virtual {v0}, Landroid/content/ComponentName;->getClassName()Ljava/lang/String;

    move-result-object v0

    if-eqz v0, :cond_3

    .line 424
    invoke-interface {v3, v2}, Ljava/util/List;->get(I)Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Landroid/app/ActivityManager$RunningServiceInfo;

    iget-object v0, v0, Landroid/app/ActivityManager$RunningServiceInfo;->service:Landroid/content/ComponentName;

    invoke-virtual {v0}, Landroid/content/ComponentName;->getPackageName()Ljava/lang/String;
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_0

    move-result-object v0

    if-eqz v0, :cond_3

    .line 426
    :try_start_1
    new-instance v4, Lorg/json/JSONObject;

    invoke-direct {v4}, Lorg/json/JSONObject;-><init>()V

    .line 427
    const-string v5, "sn"

    invoke-interface {v3, v2}, Ljava/util/List;->get(I)Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Landroid/app/ActivityManager$RunningServiceInfo;

    iget-object v0, v0, Landroid/app/ActivityManager$RunningServiceInfo;->service:Landroid/content/ComponentName;

    invoke-virtual {v0}, Landroid/content/ComponentName;->getClassName()Ljava/lang/String;

    move-result-object v0

    invoke-virtual {v0}, Ljava/lang/String;->toString()Ljava/lang/String;

    move-result-object v0

    invoke-virtual {v4, v5, v0}, Lorg/json/JSONObject;->put(Ljava/lang/String;Ljava/lang/Object;)Lorg/json/JSONObject;

    .line 428
    const-string v5, "pn"

    invoke-interface {v3, v2}, Ljava/util/List;->get(I)Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Landroid/app/ActivityManager$RunningServiceInfo;

    iget-object v0, v0, Landroid/app/ActivityManager$RunningServiceInfo;->service:Landroid/content/ComponentName;

    invoke-virtual {v0}, Landroid/content/ComponentName;->getPackageName()Ljava/lang/String;

    move-result-object v0

    invoke-virtual {v0}, Ljava/lang/String;->toString()Ljava/lang/String;

    move-result-object v0

    invoke-virtual {v4, v5, v0}, Lorg/json/JSONObject;->put(Ljava/lang/String;Ljava/lang/Object;)Lorg/json/JSONObject;

    .line 429
    if-nez v1, :cond_2

    .line 430
    new-instance v0, Lorg/json/JSONArray;

    invoke-direct {v0}, Lorg/json/JSONArray;-><init>()V
    :try_end_1
    .catch Lorg/json/JSONException; {:try_start_1 .. :try_end_1} :catch_6
    .catch Ljava/lang/Throwable; {:try_start_1 .. :try_end_1} :catch_0

    .line 432
    :goto_1
    :try_start_2
    invoke-virtual {v0, v4}, Lorg/json/JSONArray;->put(Ljava/lang/Object;)Lorg/json/JSONArray;
    :try_end_2
    .catch Lorg/json/JSONException; {:try_start_2 .. :try_end_2} :catch_5
    .catch Ljava/lang/Throwable; {:try_start_2 .. :try_end_2} :catch_1

    .line 422
    :goto_2
    add-int/lit8 v1, v2, 0x1

    move v2, v1

    move-object v1, v0

    goto :goto_0

    .line 438
    :cond_0
    if-eqz v1, :cond_1

    .line 439
    :try_start_3
    new-instance v0, Lorg/json/JSONObject;

    invoke-direct {v0}, Lorg/json/JSONObject;-><init>()V
    :try_end_3
    .catch Ljava/lang/Throwable; {:try_start_3 .. :try_end_3} :catch_0

    .line 441
    :try_start_4
    const-string v2, "ts"

    invoke-static {}, Ljava/lang/System;->currentTimeMillis()J

    move-result-wide v4

    invoke-virtual {v0, v2, v4, v5}, Lorg/json/JSONObject;->put(Ljava/lang/String;J)Lorg/json/JSONObject;

    .line 442
    const-string v2, "ls"

    invoke-virtual {v0, v2, v1}, Lorg/json/JSONObject;->put(Ljava/lang/String;Ljava/lang/Object;)Lorg/json/JSONObject;
    :try_end_4
    .catch Lorg/json/JSONException; {:try_start_4 .. :try_end_4} :catch_4
    .catch Ljava/lang/Throwable; {:try_start_4 .. :try_end_4} :catch_0

    .line 446
    :goto_3
    :try_start_5
    new-instance v2, Lorg/json/JSONObject;

    invoke-direct {v2}, Lorg/json/JSONObject;-><init>()V
    :try_end_5
    .catch Ljava/lang/Throwable; {:try_start_5 .. :try_end_5} :catch_0

    .line 448
    :try_start_6
    const-string v3, "sers"

    invoke-virtual {v2, v3, v0}, Lorg/json/JSONObject;->put(Ljava/lang/String;Ljava/lang/Object;)Lorg/json/JSONObject;
    :try_end_6
    .catch Lorg/json/JSONException; {:try_start_6 .. :try_end_6} :catch_3
    .catch Ljava/lang/Throwable; {:try_start_6 .. :try_end_6} :catch_0

    .line 453
    :goto_4
    :try_start_7
    new-instance v0, Lorg/json/JSONArray;

    invoke-direct {v0}, Lorg/json/JSONArray;-><init>()V
    :try_end_7
    .catch Ljava/lang/Throwable; {:try_start_7 .. :try_end_7} :catch_0

    .line 454
    :try_start_8
    invoke-virtual {v0, v2}, Lorg/json/JSONArray;->put(Ljava/lang/Object;)Lorg/json/JSONArray;
    :try_end_8
    .catch Ljava/lang/Throwable; {:try_start_8 .. :try_end_8} :catch_2

    move-object v1, v0

    .line 464
    :cond_1
    :goto_5
    return-object v1

    .line 460
    :catch_0
    move-exception v0

    .line 461
    :goto_6
    invoke-static {p0, v0}, Lcom/umeng/commonsdk/proguard/e;->a(Landroid/content/Context;Ljava/lang/Throwable;)V

    goto :goto_5

    .line 460
    :catch_1
    move-exception v1

    move-object v6, v1

    move-object v1, v0

    move-object v0, v6

    goto :goto_6

    :catch_2
    move-exception v1

    move-object v6, v1

    move-object v1, v0

    move-object v0, v6

    goto :goto_6

    .line 449
    :catch_3
    move-exception v0

    goto :goto_4

    .line 443
    :catch_4
    move-exception v2

    goto :goto_3

    .line 433
    :catch_5
    move-exception v1

    goto :goto_2

    :catch_6
    move-exception v0

    move-object v0, v1

    goto :goto_2

    :cond_2
    move-object v0, v1

    goto :goto_1

    :cond_3
    move-object v0, v1

    goto :goto_2
.end method

.method private static p(Landroid/content/Context;)Lorg/json/JSONArray;
    .locals 4

    .prologue
    .line 469
    new-instance v0, Lorg/json/JSONArray;

    invoke-direct {v0}, Lorg/json/JSONArray;-><init>()V

    .line 470
    invoke-static {p0}, Lcom/umeng/commonsdk/proguard/s;->d(Landroid/content/Context;)Lorg/json/JSONObject;

    move-result-object v1

    .line 471
    if-eqz v1, :cond_1

    .line 473
    :try_start_0
    invoke-static {p0}, Lcom/umeng/commonsdk/proguard/s;->e(Landroid/content/Context;)Ljava/lang/String;

    move-result-object v2

    .line 474
    invoke-static {v2}, Landroid/text/TextUtils;->isEmpty(Ljava/lang/CharSequence;)Z

    move-result v3

    if-nez v3, :cond_0

    .line 475
    const-string v3, "sig"

    invoke-virtual {v1, v3, v2}, Lorg/json/JSONObject;->put(Ljava/lang/String;Ljava/lang/Object;)Lorg/json/JSONObject;

    .line 477
    :cond_0
    invoke-virtual {v0, v1}, Lorg/json/JSONArray;->put(Ljava/lang/Object;)Lorg/json/JSONArray;
    :try_end_0
    .catch Ljava/lang/Exception; {:try_start_0 .. :try_end_0} :catch_0

    .line 480
    :cond_1
    :goto_0
    return-object v0

    .line 478
    :catch_0
    move-exception v1

    goto :goto_0
.end method

.method private static q(Landroid/content/Context;)Lorg/json/JSONArray;
    .locals 3

    .prologue
    .line 484
    new-instance v0, Lorg/json/JSONArray;

    invoke-direct {v0}, Lorg/json/JSONArray;-><init>()V

    .line 486
    invoke-static {p0}, Lcom/umeng/commonsdk/proguard/s;->f(Landroid/content/Context;)Ljava/lang/String;

    move-result-object v1

    .line 487
    invoke-static {v1}, Landroid/text/TextUtils;->isEmpty(Ljava/lang/CharSequence;)Z

    move-result v2

    if-nez v2, :cond_0

    .line 489
    :try_start_0
    new-instance v2, Lorg/json/JSONObject;

    invoke-direct {v2, v1}, Lorg/json/JSONObject;-><init>(Ljava/lang/String;)V

    .line 490
    if-eqz v2, :cond_0

    .line 491
    invoke-virtual {v0, v2}, Lorg/json/JSONArray;->put(Ljava/lang/Object;)Lorg/json/JSONArray;
    :try_end_0
    .catch Ljava/lang/Exception; {:try_start_0 .. :try_end_0} :catch_0

    .line 496
    :cond_0
    :goto_0
    return-object v0

    .line 493
    :catch_0
    move-exception v1

    goto :goto_0
.end method

.method private static r(Landroid/content/Context;)Lorg/json/JSONArray;
    .locals 6

    .prologue
    .line 500
    new-instance v2, Lorg/json/JSONArray;

    invoke-direct {v2}, Lorg/json/JSONArray;-><init>()V

    .line 501
    const/4 v0, 0x0

    .line 502
    if-eqz p0, :cond_b

    .line 503
    invoke-virtual {p0}, Landroid/content/Context;->getApplicationContext()Landroid/content/Context;

    move-result-object v3

    .line 505
    invoke-static {v3}, Lcom/umeng/commonsdk/proguard/s;->a(Landroid/content/Context;)Ljava/lang/String;

    move-result-object v4

    .line 506
    invoke-static {v4}, Landroid/text/TextUtils;->isEmpty(Ljava/lang/CharSequence;)Z

    move-result v1

    if-nez v1, :cond_1

    .line 508
    if-nez v0, :cond_0

    .line 509
    :try_start_0
    new-instance v1, Lorg/json/JSONObject;

    invoke-direct {v1}, Lorg/json/JSONObject;-><init>()V

    move-object v0, v1

    .line 511
    :cond_0
    const-string v1, "bluetoothmac"

    invoke-virtual {v0, v1, v4}, Lorg/json/JSONObject;->put(Ljava/lang/String;Ljava/lang/Object;)Lorg/json/JSONObject;
    :try_end_0
    .catch Ljava/lang/Exception; {:try_start_0 .. :try_end_0} :catch_4

    .line 515
    :cond_1
    :goto_0
    invoke-static {v3}, Lcom/umeng/commonsdk/proguard/s;->b(Landroid/content/Context;)Ljava/lang/String;

    move-result-object v4

    .line 516
    invoke-static {v4}, Landroid/text/TextUtils;->isEmpty(Ljava/lang/CharSequence;)Z

    move-result v1

    if-nez v1, :cond_3

    .line 518
    if-nez v0, :cond_2

    .line 519
    :try_start_1
    new-instance v1, Lorg/json/JSONObject;

    invoke-direct {v1}, Lorg/json/JSONObject;-><init>()V

    move-object v0, v1

    .line 521
    :cond_2
    const-string v1, "iccid"

    invoke-virtual {v0, v1, v4}, Lorg/json/JSONObject;->put(Ljava/lang/String;Ljava/lang/Object;)Lorg/json/JSONObject;
    :try_end_1
    .catch Ljava/lang/Exception; {:try_start_1 .. :try_end_1} :catch_3

    .line 525
    :cond_3
    :goto_1
    invoke-static {v3}, Lcom/umeng/commonsdk/proguard/s;->c(Landroid/content/Context;)Ljava/lang/String;

    move-result-object v4

    .line 526
    invoke-static {v4}, Landroid/text/TextUtils;->isEmpty(Ljava/lang/CharSequence;)Z

    move-result v1

    if-nez v1, :cond_5

    .line 528
    if-nez v0, :cond_4

    .line 529
    :try_start_2
    new-instance v1, Lorg/json/JSONObject;

    invoke-direct {v1}, Lorg/json/JSONObject;-><init>()V

    move-object v0, v1

    .line 531
    :cond_4
    const-string v1, "secondaryimei"

    invoke-virtual {v0, v1, v4}, Lorg/json/JSONObject;->put(Ljava/lang/String;Ljava/lang/Object;)Lorg/json/JSONObject;
    :try_end_2
    .catch Ljava/lang/Exception; {:try_start_2 .. :try_end_2} :catch_2

    .line 536
    :cond_5
    :goto_2
    invoke-static {v3}, Lcom/umeng/commonsdk/proguard/s;->d(Landroid/content/Context;)Lorg/json/JSONObject;

    move-result-object v4

    .line 537
    if-eqz v4, :cond_8

    .line 539
    :try_start_3
    invoke-static {v3}, Lcom/umeng/commonsdk/proguard/s;->e(Landroid/content/Context;)Ljava/lang/String;

    move-result-object v1

    .line 540
    invoke-static {v1}, Landroid/text/TextUtils;->isEmpty(Ljava/lang/CharSequence;)Z

    move-result v5

    if-nez v5, :cond_6

    .line 541
    const-string v5, "signalscale"

    invoke-virtual {v4, v5, v1}, Lorg/json/JSONObject;->put(Ljava/lang/String;Ljava/lang/Object;)Lorg/json/JSONObject;

    .line 543
    :cond_6
    if-nez v0, :cond_7

    .line 544
    new-instance v1, Lorg/json/JSONObject;

    invoke-direct {v1}, Lorg/json/JSONObject;-><init>()V

    move-object v0, v1

    .line 546
    :cond_7
    const-string v1, "basestation"

    invoke-virtual {v0, v1, v4}, Lorg/json/JSONObject;->put(Ljava/lang/String;Ljava/lang/Object;)Lorg/json/JSONObject;
    :try_end_3
    .catch Ljava/lang/Exception; {:try_start_3 .. :try_end_3} :catch_1

    .line 550
    :cond_8
    :goto_3
    invoke-static {v3}, Lcom/umeng/commonsdk/proguard/s;->f(Landroid/content/Context;)Ljava/lang/String;

    move-result-object v3

    .line 551
    invoke-static {v3}, Landroid/text/TextUtils;->isEmpty(Ljava/lang/CharSequence;)Z

    move-result v1

    if-nez v1, :cond_a

    .line 553
    if-nez v0, :cond_9

    .line 554
    :try_start_4
    new-instance v1, Lorg/json/JSONObject;

    invoke-direct {v1}, Lorg/json/JSONObject;-><init>()V

    move-object v0, v1

    .line 556
    :cond_9
    const-string v1, "battery"

    new-instance v4, Lorg/json/JSONObject;

    invoke-direct {v4, v3}, Lorg/json/JSONObject;-><init>(Ljava/lang/String;)V

    invoke-virtual {v0, v1, v4}, Lorg/json/JSONObject;->put(Ljava/lang/String;Ljava/lang/Object;)Lorg/json/JSONObject;
    :try_end_4
    .catch Ljava/lang/Exception; {:try_start_4 .. :try_end_4} :catch_0

    .line 561
    :cond_a
    :goto_4
    if-eqz v0, :cond_b

    .line 562
    invoke-virtual {v2, v0}, Lorg/json/JSONArray;->put(Ljava/lang/Object;)Lorg/json/JSONArray;

    .line 567
    :cond_b
    return-object v2

    .line 557
    :catch_0
    move-exception v1

    goto :goto_4

    .line 547
    :catch_1
    move-exception v1

    goto :goto_3

    .line 532
    :catch_2
    move-exception v1

    goto :goto_2

    .line 522
    :catch_3
    move-exception v1

    goto :goto_1

    .line 512
    :catch_4
    move-exception v1

    goto :goto_0
.end method
